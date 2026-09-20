#!/usr/bin/env python3
"""Pilote OpenSCAD pour ce depot : rendus 3D, coupes, tranches, dessins techniques.

Chaque modele vit dans models/<slug>/ et expose un module `main()` dans
models/<slug>/<slug>.scad. Les sorties vont dans models/<slug>/out/ (regenerables).

Exemples :
    python scripts/scad.py views   boitier
    python scripts/scad.py section boitier --axis x --at 0 --keep neg
    python scripts/scad.py slices  boitier --axis z --count 5
    python scripts/scad.py drawing boitier
    python scripts/scad.py stl     boitier
    python scripts/scad.py info    boitier
    python scripts/scad.py all     boitier
"""
from __future__ import annotations

import argparse
import os
import shutil
import struct
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

# Rotations camera d'OpenSCAD (rx, ry, rz) pour les vues normalisees.
VIEWS = {
    "iso":    (55, 0, 25),
    "front":  (90, 0, 0),
    "back":   (90, 0, 180),
    "left":   (90, 0, 270),
    "right":  (90, 0, 90),
    "top":    (0, 0, 0),
    "bottom": (180, 0, 0),
}
DEFAULT_VIEWS = ["iso", "front", "right", "top"]
IMGSIZE = "1200,900"
COLORSCHEME = "Tomorrow"


def find_openscad() -> str:
    env = os.environ.get("OPENSCAD")
    if env and Path(env).exists():
        return env
    # Sous Windows, openscad.com est la variante console (sortie/exit code corrects).
    for name in ("openscad.com", "openscad", "openscad.exe"):
        p = shutil.which(name)
        if p:
            return p
    for p in (
        Path(r"C:\Program Files\OpenSCAD\openscad.com"),
        Path(r"C:\Program Files\OpenSCAD\openscad.exe"),
        Path(r"C:\Program Files (x86)\OpenSCAD\openscad.com"),
    ):
        if p.exists():
            return str(p)
    sys.exit(
        "OpenSCAD introuvable. Installe-le (winget install OpenSCAD.OpenSCAD) "
        "ou definis la variable d'environnement OPENSCAD."
    )


def model_paths(slug: str) -> tuple[Path, Path]:
    d = ROOT / "models" / slug
    scad = d / f"{slug}.scad"
    if not scad.exists():
        sys.exit(f"Modele introuvable : {scad}")
    out = d / "out"
    out.mkdir(exist_ok=True)
    return scad, out


def env_openscad() -> dict:
    """Ajoute vendor/ au chemin de bibliotheques d'OpenSCAD.

    Les bibliotheques du depot vivent dans vendor/<Nom>/ plutot que dans le dossier
    Documents de l'utilisateur, qui est synchronise sur OneDrive ici.
    """
    env = os.environ.copy()
    vendor = str(ROOT / "vendor")
    ancien = env.get("OPENSCADPATH")
    env["OPENSCADPATH"] = f"{vendor}{os.pathsep}{ancien}" if ancien else vendor
    return env


def run(cmd: list[str]) -> None:
    print("  $", " ".join(str(c) for c in cmd))
    r = subprocess.run(cmd, capture_output=True, text=True, env=env_openscad())
    noise = (r.stderr or "").strip()
    if noise:
        print("\n".join("    " + l for l in noise.splitlines()[-20:]))
    if r.returncode != 0:
        sys.exit(f"OpenSCAD a echoue (code {r.returncode}).")


def wrapper(scad: Path, body: str) -> Path:
    """Ecrit un .scad temporaire qui `use` le modele et applique `body`."""
    src = (
        f"use <{scad.as_posix()}>\n"
        f"include <{(ROOT / 'lib' / 'std.scad').as_posix()}>\n"
        f"{body}\n"
    )
    f = tempfile.NamedTemporaryFile("w", suffix=".scad", delete=False, encoding="utf-8")
    f.write(src)
    f.close()
    return Path(f.name)


def defines(a) -> list[str]:
    """Traduit --define CLE=VALEUR en options -D d'OpenSCAD.

    Une valeur non numerique est automatiquement passee comme chaine OpenSCAD.
    """
    out = []
    for d in getattr(a, "define", None) or []:
        if "=" not in d:
            sys.exit(f"--define attend CLE=VALEUR, recu : {d}")
        k, v = d.split("=", 1)
        try:
            float(v)
        except ValueError:
            if v not in ("true", "false") and not v.startswith(('"', "[")):
                v = f'"{v}"'
        out += ["-D", f"{k}={v}"]
    return out


def render_png(scad_file: Path, out: Path, view: str = "iso", fast: bool = False,
               extra: list[str] | None = None) -> None:
    rx, ry, rz = VIEWS[view]
    cmd = [
        find_openscad(), "-o", str(out),
        f"--imgsize={IMGSIZE}",
        f"--camera=0,0,0,{rx},{ry},{rz},0",
        "--viewall", "--autocenter",
        f"--colorscheme={COLORSCHEME}",
    ]
    if not fast:
        cmd.append("--render")
    cmd += (extra or [])
    cmd.append(str(scad_file))
    run(cmd)


def export(scad_file: Path, out: Path, extra: list[str] | None = None) -> None:
    run([find_openscad(), "-o", str(out)] + (extra or []) + [str(scad_file)])


def stl_load(path: Path) -> tuple[list, list]:
    """Lit un STL ASCII ou binaire. Retourne (normales, triangles).

    OpenSCAD 2021.01 exporte en ASCII ; les versions recentes savent faire du binaire.
    Le test fiable est la taille : un STL binaire fait exactement 84 + 50 octets par
    triangle, y compris quand son en-tete commence par le mot « solid ».
    """
    data = path.read_bytes()
    if len(data) >= 84:
        n = struct.unpack("<I", data[80:84])[0]
        if 84 + n * 50 == len(data):
            nor, tri = [], []
            for i in range(n):
                off = 84 + i * 50
                nor.append(struct.unpack("<3f", data[off:off + 12]))
                tri.append(tuple(
                    struct.unpack("<3f", data[off + 12 + v * 12: off + 24 + v * 12])
                    for v in range(3)
                ))
            return nor, tri

    nor, tri, cur = [], [], []
    for ligne in data.decode("utf-8", "replace").splitlines():
        t = ligne.split()
        if not t:
            continue
        if t[0] == "facet" and len(t) >= 5:
            nor.append(tuple(float(x) for x in t[2:5]))
        elif t[0] == "vertex" and len(t) >= 4:
            cur.append(tuple(float(x) for x in t[1:4]))
            if len(cur) == 3:
                tri.append(tuple(cur))
                cur = []
    if not tri:
        sys.exit(f"{path.name} : STL illisible (ni binaire ni ASCII exploitable).")
    return nor, tri


def stl_bbox(path: Path) -> tuple[tuple[float, ...], tuple[float, ...]]:
    _, tri = stl_load(path)
    lo = [float("inf")] * 3
    hi = [float("-inf")] * 3
    for face in tri:
        for pt in face:
            for k, c in enumerate(pt):
                lo[k] = min(lo[k], c)
                hi[k] = max(hi[k], c)
    return tuple(lo), tuple(hi)


def stl_binary(path: Path) -> bytes:
    """Rend le STL en binaire, quelle que soit sa forme d'origine (~6x plus compact)."""
    nor, tri = stl_load(path)
    out = [b"binaire par scad.py".ljust(80, b"\0"), struct.pack("<I", len(tri))]
    for i, face in enumerate(tri):
        n = nor[i] if i < len(nor) else (0.0, 0.0, 0.0)
        out.append(struct.pack("<12fH", *n, *face[0], *face[1], *face[2], 0))
    return b"".join(out)


# --- commandes -------------------------------------------------------------

def tag(a) -> str:
    """Suffixe de nom de fichier derive des --define, pour ne pas ecraser les variantes."""
    parts = [d.split("=", 1)[1] for d in (getattr(a, "define", None) or [])]
    return ("-" + "-".join(parts)) if parts else ""


def cmd_stl(a) -> Path:
    scad, out = model_paths(a.slug)
    dst = out / f"{a.slug}{tag(a)}.stl"
    print(f"[stl] {dst}")
    export(scad, dst, defines(a))
    if getattr(a, "binaire", False):
        # OpenSCAD 2021.01 n'exporte qu'en ASCII ; le binaire est ~6x plus compact
        # et se charge bien plus vite dans un trancheur.
        avant = dst.stat().st_size
        brut = stl_binary(dst)
        dst.write_bytes(brut)
        print(f"      converti en binaire : {avant/1e6:.2f} Mo -> {len(brut)/1e6:.2f} Mo")
    return dst


def cmd_info(a) -> None:
    dst = cmd_stl(a)
    lo, hi = stl_bbox(dst)
    print(f"\nEncombrement de {a.slug}{tag(a)} (mm)")
    for k, ax in enumerate("XYZ"):
        print(f"  {ax} : {lo[k]:8.2f} -> {hi[k]:8.2f}   ({hi[k] - lo[k]:.2f})")


def cmd_views(a) -> None:
    scad, out = model_paths(a.slug)
    for v in (a.views or DEFAULT_VIEWS):
        dst = out / f"view{tag(a)}-{v}.png"
        print(f"[vue 3D] {dst}")
        render_png(scad, dst, v, a.fast, defines(a))


def cmd_section(a) -> None:
    scad, out = model_paths(a.slug)
    body = (
        f"quarter_cut({a.at}, {a.at}) main();" if a.axis == "quarter"
        else f'section("{a.axis}", {a.at}, "{a.keep}") main();'
    )
    w = wrapper(scad, body)
    try:
        for v in (a.views or ["iso"]):
            dst = out / f"section{tag(a)}-{a.axis}{a.at:g}-{v}.png"
            print(f"[coupe] {dst}")
            render_png(w, dst, v, a.fast, defines(a))
    finally:
        w.unlink(missing_ok=True)


def cmd_slices(a) -> None:
    scad, out = model_paths(a.slug)
    positions = a.at
    if not positions:
        stl = out / f"{a.slug}{tag(a)}.stl"
        if not stl.exists():
            export(scad, stl, defines(a))
        lo, hi = stl_bbox(stl)
        k = "xyz".index(a.axis)
        step = (hi[k] - lo[k]) / (a.count + 1)
        positions = [lo[k] + step * (i + 1) for i in range(a.count)]
    for p in positions:
        w = wrapper(scad, f'slice_2d("{a.axis}", {p}) main();')
        try:
            base = f"slice{tag(a)}-{a.axis}{p:+.2f}"
            print(f"[tranche] {out / (base + '.svg')}")
            export(w, out / f"{base}.svg", defines(a))
            render_png(w, out / f"{base}.png", "top", a.fast, defines(a))
        finally:
            w.unlink(missing_ok=True)


def cmd_drawing(a) -> None:
    scad, out = model_paths(a.slug)
    for v in (a.views or ["front", "right", "top"]):
        w = wrapper(scad, f'view_2d("{v}") main();')
        try:
            base = f"drawing{tag(a)}-{v}"
            print(f"[dessin] {out / (base + '.svg')}")
            export(w, out / f"{base}.svg", defines(a))
            render_png(w, out / f"{base}.png", "top", a.fast, defines(a))
        finally:
            w.unlink(missing_ok=True)


def cmd_all(a) -> None:
    cmd_views(a)
    cmd_drawing(argparse.Namespace(**{**vars(a), "views": None}))
    cmd_info(a)


def main() -> None:
    p = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    sub = p.add_subparsers(dest="cmd", required=True)

    def common(sp):
        sp.add_argument("slug", help="nom du sous-repertoire sous models/")
        sp.add_argument("--views", nargs="+", help="vues a rendre")
        sp.add_argument("--fast", action="store_true",
                        help="preview au lieu du rendu CGAL complet")
        sp.add_argument("-D", "--define", action="append", metavar="CLE=VALEUR",
                        help="surcharge une variable du modele (repetable)")
        return sp

    common(sub.add_parser("views", help="rendus 3D sous plusieurs angles")).set_defaults(fn=cmd_views)

    s = common(sub.add_parser("section", help="rendu 3D avec coupe en demi-espace"))
    s.add_argument("--axis", default="x", choices=["x", "y", "z", "quarter"])
    s.add_argument("--at", type=float, default=0)
    s.add_argument("--keep", default="neg", choices=["neg", "pos"])
    s.set_defaults(fn=cmd_section)

    s = common(sub.add_parser("slices", help="tranches 2D (SVG + PNG)"))
    s.add_argument("--axis", default="z", choices=["x", "y", "z"])
    s.add_argument("--count", type=int, default=5,
                   help="nombre de tranches reparties sur l'encombrement")
    s.add_argument("--at", type=float, nargs="+", help="positions explicites (mm)")
    s.set_defaults(fn=cmd_slices)

    common(sub.add_parser("drawing", help="dessins techniques 2D (SVG + PNG)")).set_defaults(fn=cmd_drawing)

    s = common(sub.add_parser("stl", help="export STL"))
    s.add_argument("--binaire", action="store_true",
                   help="convertit le STL en binaire (~6x plus compact)")
    s.set_defaults(fn=cmd_stl)
    common(sub.add_parser("info", help="encombrement (bounding box)")).set_defaults(fn=cmd_info)
    common(sub.add_parser("all", help="vues 3D + dessins + encombrement")).set_defaults(fn=cmd_all)

    a = p.parse_args()
    a.fn(a)


if __name__ == "__main__":
    main()
