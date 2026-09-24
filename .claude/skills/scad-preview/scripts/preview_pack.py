#!/usr/bin/env python3
"""Prepare l'aperçu web d'un modele : STL en base64 + manifeste des rendus.

Produit models/<slug>/out/preview/ contenant model-data.js et une copie des PNG.
La page viewer.html de la skill lit window.SCAD_MODEL depuis model-data.js.

    python .claude/skills/scad-preview/scripts/preview_pack.py <slug>
    python .claude/skills/scad-preview/scripts/preview_pack.py rack-sodastream --stl out/rack-avant.stl

Plusieurs pièces : répéter --stl. Le viewer les montre ensemble, chacune dans sa
couleur, et propose un bouton par pièce. Elles doivent être modélisées EN PLACE
(même repère) pour que la vue d'ensemble les montre assemblées.
"""
from __future__ import annotations

import argparse
import base64
import json
import shutil
import sys
from pathlib import Path

SEUIL_MO = 8.0  # au-dela, regenerer le STL en resolution preview

# scad.py nomme ses sorties <genre>[-<variante>...]-<vue>.png, la variante venant
# des -D passes en ligne de commande. On analyse donc le nom par ses extremites.
GROUPES = {
    "view": "Rendus 3D",
    "drawing": "Dessins techniques",
    "section": "Coupes",
    "slice": "Tranches",
}
VUES = {
    "iso": "Isométrique", "front": "Face", "back": "Arrière", "right": "Droite",
    "left": "Gauche", "top": "Dessus", "bottom": "Dessous",
}
# Valeurs de -D sans interet dans un libelle.
BRUIT = {"true", "false"}


def etiquette(nom: str) -> tuple[str, str]:
    base = nom[:-4] if nom.lower().endswith(".png") else nom
    parts = base.split("-")
    groupe = GROUPES.get(parts[0], "Autres")
    vue = VUES.get(parts[-1], parts[-1])
    variante = " ".join(p for p in parts[1:-1] if p and p not in BRUIT)
    return groupe, f"{vue} — {variante}" if variante else vue


def outils(root: Path):
    """Importe les fonctions partagees de scripts/scad.py."""
    sys.path.insert(0, str(root / "scripts"))
    from scad import stl_bbox, stl_binary, perimes  # type: ignore
    return stl_bbox, stl_binary, perimes


def controle_peremption(perimes, slug: str, out: Path, ignorer: bool) -> None:
    """Refuse de publier une sortie qui ne vient pas du source actuel.

    Une generation lancee en tache de fond pendant qu'on modifie le .scad laisse des
    rendus issus de versions differentes, sans que rien ne le signale. C'est ainsi
    qu'une vue perimee finit publiee.
    """
    mauvais = perimes(slug, out)
    if not mauvais:
        return
    lignes = "\n".join(f"   {n:44s} {r}" for n, r in mauvais)
    if ignorer:
        print(f"AVERTISSEMENT — {len(mauvais)} sortie(s) perimee(s), publiees quand meme :\n{lignes}\n")
        return
    sys.exit(
        f"{len(mauvais)} sortie(s) ne viennent pas du source actuel :\n{lignes}\n\n"
        f"Regenere-les, par exemple :\n"
        f"  python scripts/scad.py all {slug}\n"
        f"Puis verifie :\n"
        f"  python scripts/scad.py check {slug}\n"
        f"Pour passer outre en connaissance de cause : --ignorer-peremption"
    )


def bbox(stl_bbox, stl: Path):
    lo, hi = stl_bbox(stl)
    return {
        "min": [round(v, 2) for v in lo],
        "max": [round(v, 2) for v in hi],
        "size": [round(hi[i] - lo[i], 2) for i in range(3)],
    }


def main() -> None:
    p = argparse.ArgumentParser(description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("slug")
    p.add_argument("--root", default=".", help="racine du depot (defaut : repertoire courant)")
    p.add_argument("--stl", action="append",
                   help="STL a embarquer, repetable : une piece par option "
                        "(defaut : le premier de out/)")
    p.add_argument("--titre", help="nom affiche du modele")
    p.add_argument("--ignorer-peremption", action="store_true",
                   help="publie meme si des sorties ne viennent pas du source actuel")
    a = p.parse_args()

    root = Path(a.root).resolve()
    out = root / "models" / a.slug / "out"
    if not out.is_dir():
        sys.exit(f"Aucune sortie dans {out}. Lance d'abord : python scripts/scad.py all {a.slug}")

    stls = [Path(x) for x in a.stl] if a.stl else [next(iter(sorted(out.glob("*.stl"))), None)]
    for stl in stls:
        if stl is None or not stl.exists():
            sys.exit(f"STL introuvable : {stl}. Lance : python scripts/scad.py stl {a.slug}")

    stl_bbox, stl_binary, perimes = outils(root)
    controle_peremption(perimes, a.slug, out, a.ignorer_peremption)

    # OpenSCAD 2021.01 n'exporte qu'en ASCII : on convertit, c'est ~6x plus compact.
    # Le seuil porte donc sur la taille binaire TOTALE, la seule qui parte dans la page.
    def nom_piece(stl: Path) -> str:
        nom = stl.stem
        if nom.startswith(a.slug + "-"):
            nom = nom[len(a.slug) + 1:]
        return nom[:1].upper() + nom[1:]

    pieces, total = [], 0.0
    for stl in stls:
        brut = stl_binary(stl)
        total += len(brut) / 1e6
        pieces.append({
            "nom": nom_piece(stl),
            "source": stl.name,
            "bbox": bbox(stl_bbox, stl),
            "stl": base64.b64encode(brut).decode("ascii"),
            "_ascii_mo": stl.stat().st_size / 1e6,
            "_mo": len(brut) / 1e6,
        })
    if total > SEUIL_MO:
        sys.exit(
            f"Les STL pesent {total:.1f} Mo en binaire (seuil {SEUIL_MO} Mo). En base64 ils "
            f"occuperaient {total * 1.33:.1f} Mo de la page. Regenere-les plus grossierement "
            f"en relachant $fa/$fs dans lib/std.scad."
        )

    preview = out / "preview"
    preview.mkdir(exist_ok=True)
    for vieux in preview.glob("*.png"):
        vieux.unlink()

    vues = []
    for png in sorted(out.glob("*.png")):
        shutil.copy2(png, preview / png.name)
        groupe, libelle = etiquette(png.name)
        vues.append({"file": png.name, "group": groupe, "label": libelle})

    rapports = [(pc["source"], pc.pop("_ascii_mo"), pc.pop("_mo")) for pc in pieces]
    data = {
        "slug": a.slug,
        "titre": a.titre or a.slug,
        # La premiere piece reste aussi a plat, pour les pages d'avant le multi-piece.
        "source": pieces[0]["source"],
        "bbox": pieces[0]["bbox"],
        "stl": pieces[0]["stl"],
        "pieces": pieces,
        "views": vues,
    }
    cible = preview / "model-data.js"
    cible.write_text(
        "window.SCAD_MODEL = " + json.dumps(data, ensure_ascii=False) + ";\n",
        encoding="utf-8",
    )

    for source, ascii_mo, mo in rapports:
        print(f"STL     : {source} — {ascii_mo:.2f} Mo ASCII -> {mo:.2f} Mo binaire "
              f"-> {mo * 1.33:.2f} Mo en base64")
    if data["bbox"]:
        x, y, z = data["bbox"]["size"]
        print(f"Encombrement : {x} x {y} x {z} mm")
    print(f"Rendus  : {len(vues)} PNG copies dans {preview}")
    print(f"Ecrit   : {cible}")
    print("\nFichiers a publier :")
    print(f"  page  = <viewer.html adapte>")
    print(f"  files = model-data.js + les {len(vues)} PNG de {preview}")


if __name__ == "__main__":
    main()
