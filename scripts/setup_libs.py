#!/usr/bin/env python3
"""Installe les bibliotheques OpenSCAD du depot dans vendor/.

vendor/ est exclu de git : ces bibliotheques pesent des dizaines de Mo et sont
reproductibles depuis leur source. Ce script les retablit a la version epinglee.

    python scripts/setup_libs.py
    python scripts/setup_libs.py --force    # reinstalle meme si deja present

scripts/scad.py ajoute vendor/ a OPENSCADPATH, donc `include <BOSL2/std.scad>`
fonctionne sans configuration. Pour l'interface graphique d'OpenSCAD, qui ne passe
pas par ce script, definir soi-meme la variable d'environnement OPENSCADPATH sur
le chemin absolu de vendor/.
"""
from __future__ import annotations

import argparse
import shutil
import sys
import tarfile
import tempfile
import urllib.request
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


def main() -> None:
    p = argparse.ArgumentParser(description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--force", action="store_true", help="reinstalle meme si deja present")
    a = p.parse_args()

    vendor = ROOT / "vendor"
    vendor.mkdir(exist_ok=True)
    for lib in BIBLIOTHEQUES:
        installer(lib, vendor, a.force)
    print(f"\nOPENSCADPATH a utiliser pour l'interface graphique :\n  {vendor}")


if __name__ == "__main__":
    main()
