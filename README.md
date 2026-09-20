# 3d-printing-models

Pièces paramétriques modélisées en [OpenSCAD](https://openscad.org/), destinées à
l'impression 3D. Un modèle par sous-répertoire, avec son outillage de rendu, de coupe et
de dessin technique.

Unités : millimètres. Documentation en français.

**[Méthode de conception](WORKFLOW.md)** — le cycle de travail, la discipline de
vérification et les pièges rencontrés, avec leurs chiffres.

**[Journal de conception](work-log/)** — les sessions racontées, ce qu'on y a appris et
ce qu'on y a raté.

## Modèles

| Modèle | Description |
|---|---|
| [rack-sodastream](models/rack-sodastream/) | Rack à visser sous une planche pour deux cylindres de CO2 SodaStream, tenus à l'horizontale et invisibles depuis le dessus |

## Démarrer

Il faut OpenSCAD et Python 3.11 ou plus.

```bash
winget install OpenSCAD.OpenSCAD
```

```bash
python scripts/setup_libs.py
```

Le second installe les bibliothèques OpenSCAD tierces dans `vendor/`, qui est exclu du
dépôt.

## Outillage

`scripts/scad.py` pilote OpenSCAD : il gère les caméras, les fichiers d'enrobage et les
sorties, qui atterrissent toutes dans `models/<slug>/out/`.

```bash
python scripts/scad.py views   <slug>                    # rendus 3D : iso, face, droite, dessus
python scripts/scad.py section <slug> --axis x --at 0    # coupe en demi-espace
python scripts/scad.py slices  <slug> --axis z --count 5 # tranches 2D
python scripts/scad.py drawing <slug>                    # dessins techniques (SVG + PNG)
python scripts/scad.py info    <slug>                    # encombrement, lu dans le maillage
python scripts/scad.py stl     <slug> --binaire          # export STL
```

`--fast` bascule en aperçu au lieu du rendu complet : quelques dixièmes de seconde au
lieu de plusieurs minutes, pour itérer sur la forme.

`info` et les commandes de tranche lisent le **maillage exporté**, pas le source. Les
cotes rapportées sont donc celles qui partiront à l'impression, polygonisation comprise.

## Structure

```
models/<slug>/
  <slug>.scad     fichier principal, exposant un module main()
  README.md       à quoi sert la pièce, cotes, montage, impression
  out/            tout le généré — régénérable, hors dépôt
lib/std.scad      coupes, tranches, vues techniques
scripts/          outillage
vendor/           bibliothèques tierces — hors dépôt
```

Chaque modèle expose un `module main()` et l'appelle : l'outillage fait `use <…>` sur le
fichier, et les rendus, coupes et dessins en dépendent.

## Licence

Aucune licence n'est encore fixée pour ce dépôt. `vendor/BOSL2`, installé séparément,
reste sous sa propre licence BSD-2-Clause.
