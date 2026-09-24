#!/usr/bin/env python3
"""Installe dans vendor/ les bibliotheques OpenSCAD du depot, et OpenSCAD lui-meme.

vendor/ est exclu de git : ces bibliotheques pesent des dizaines de Mo et sont
reproductibles depuis leur source. Ce script les retablit a la version epinglee.

    python scripts/setup_libs.py
    python scripts/setup_libs.py --force    # reinstalle meme si deja present

scripts/scad.py ajoute vendor/ a OPENSCADPATH, donc `include <BOSL2/std.scad>`
fonctionne sans configuration. Pour l'interface graphique d'OpenSCAD, qui ne passe
pas par ce script, definir soi-meme la variable d'environnement OPENSCADPATH sur
le chemin absolu de vendor/.

OPENSCAD. La version de developpement (moteur Manifold, 10 a 30 fois plus rapide
que CGAL) va dans vendor/openscad-nightly/, en archive portable : rien n'est
installe sur le systeme, et scripts/scad.py la prefere a celle du PATH. Windows
seulement. Ces versions sont retirees du serveur au bout de quelques semaines :
si l'epinglee a disparu, on prend la plus recente, toujours verifiee par SHA-256.

    python scripts/setup_libs.py --openscad-derniere   # force la plus recente
"""
from __future__ import annotations

import argparse
import hashlib
import re
import shutil
import sys
import tarfile
import tempfile
import urllib.error
import urllib.request
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

BIBLIOTHEQUES = [
    {
        "nom": "BOSL2",
        "version": "v2.0.755",
        "url": "https://github.com/BelfrySCAD/BOSL2/archive/refs/tags/v2.0.755.tar.gz",
        "racine": "BOSL2-2.0.755",   # dossier a la racine de l'archive
        "licence": "BSD-2-Clause",
    },
]

OPENSCAD = {
    "version": "2026.09.23",
    "depot": "https://files.openscad.org/snapshots/",
    "archive": "OpenSCAD-{v}-x86-64.zip",
}


def installer(lib: dict, vendor: Path, force: bool) -> None:
    cible = vendor / lib["nom"]
    if cible.is_dir() and not force:
        print(f"{lib['nom']:8s} deja present ({len(list(cible.glob('*.scad')))} fichiers .scad)")
        return

    print(f"{lib['nom']:8s} telechargement de {lib['version']}...")
    with tempfile.TemporaryDirectory() as tmp:
        tmp = Path(tmp)
        archive = tmp / "lib.tar.gz"
        with urllib.request.urlopen(lib["url"]) as r, archive.open("wb") as f:
            shutil.copyfileobj(r, f)
        with tarfile.open(archive) as t:
            t.extractall(tmp)
        source = tmp / lib["racine"]
        if not source.is_dir():
            sys.exit(f"{lib['nom']} : dossier {lib['racine']} absent de l'archive.")
        if cible.is_dir():
            shutil.rmtree(cible)
        shutil.move(str(source), str(cible))
    print(f"{lib['nom']:8s} installe dans {cible}  ({lib['licence']})")


def _lire(url: str) -> bytes:
    with urllib.request.urlopen(url) as r:
        return r.read()


def installer_openscad(vendor: Path, force: bool, derniere: bool) -> None:
    if sys.platform != "win32":
        print("OpenSCAD  version de developpement : archive Windows seulement, "
              "installer a la main (https://openscad.org/downloads.html#snapshots)")
        return
    cible = vendor / "openscad-nightly"
    deja = sorted(cible.glob("OpenSCAD-*/openscad.com"))
    if deja and not force and not derniere:
        print(f"OpenSCAD  deja present ({deja[-1].parent.name})")
        return

    version = OPENSCAD["version"]
    nom = OPENSCAD["archive"].format(v=version)
    try:
        if derniere:
            raise urllib.error.HTTPError(None, 404, "derniere demandee", None, None)
        empreinte = _lire(OPENSCAD["depot"] + nom + ".sha256")
    except urllib.error.HTTPError:
        liste = _lire(OPENSCAD["depot"]).decode("utf-8", "replace")
        versions = sorted(set(re.findall(r"OpenSCAD-([0-9.]+)-x86-64\.zip\.sha256", liste)))
        if not versions:
            sys.exit("OpenSCAD : aucune version de developpement Windows sur le serveur.")
        if not derniere:
            print(f"OpenSCAD  {version} retiree du serveur, on prend la plus recente")
        version = versions[-1]
        nom = OPENSCAD["archive"].format(v=version)
        empreinte = _lire(OPENSCAD["depot"] + nom + ".sha256")
    attendu = empreinte.decode().split()[0].lower()

    print(f"OpenSCAD  telechargement de {nom}...")
    with tempfile.TemporaryDirectory() as tmp:
        archive = Path(tmp) / nom
        with urllib.request.urlopen(OPENSCAD["depot"] + nom) as r, archive.open("wb") as f:
            shutil.copyfileobj(r, f)
        obtenu = hashlib.sha256(archive.read_bytes()).hexdigest()
        if obtenu != attendu:
            sys.exit(f"OpenSCAD : empreinte SHA-256 fausse, archive refusee.\n"
                     f"  attendue {attendu}\n  obtenue  {obtenu}")
        if cible.is_dir():
            shutil.rmtree(cible)
        cible.mkdir(parents=True)
        with zipfile.ZipFile(archive) as z:
            z.extractall(cible)
    print(f"OpenSCAD  {version} installe dans {cible}  (SHA-256 verifie, GPL-2.0)")


def main() -> None:
    p = argparse.ArgumentParser(description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--force", action="store_true", help="reinstalle meme si deja present")
    p.add_argument("--openscad-derniere", action="store_true",
                   help="remplace OpenSCAD par la version de developpement la plus recente")
    a = p.parse_args()

    vendor = ROOT / "vendor"
    vendor.mkdir(exist_ok=True)
    for lib in BIBLIOTHEQUES:
        installer(lib, vendor, a.force)
    installer_openscad(vendor, a.force, a.openscad_derniere)
    print(f"\nOPENSCADPATH a utiliser pour l'interface graphique :\n  {vendor}")


if __name__ == "__main__":
    main()
