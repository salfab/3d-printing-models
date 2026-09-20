# Dépôt de modèles 3D — instructions

Dépôt de pièces paramétriques modélisées en **OpenSCAD**, destinées à l'impression 3D.
Unités : **millimètres**. Langue des commentaires et de la documentation : **français**.

## Règle n°1 — un modèle = un sous-répertoire

Chaque nouveau modèle va dans son propre sous-répertoire `models/<slug>/`.
Ne jamais ajouter une pièce sans rapport dans le répertoire d'un modèle existant, et
ne jamais mettre de `.scad` de modèle à la racine.

```
models/<slug>/
  <slug>.scad     # fichier principal — MÊME NOM que le répertoire
  params.scad     # paramètres du modèle (optionnel, si nombreux)
  parts/          # sous-modules si le modèle est décomposé
  README.md       # à quoi sert la pièce, paramètres clés, réglages d'impression
  out/            # TOUT le généré (png, svg, stl) — jamais committé, régénérable
```

`_template/` est le point de départ : le copier pour démarrer un modèle.

## Conventions OpenSCAD obligatoires

- Le fichier principal **doit définir `module main()`** et l'appeler à la fin par
  `main();`. L'outillage fait `use <…>` sur ce fichier : sans `main()`, les rendus,
  coupes et dessins ne fonctionnent pas.
- Commencer par `include <../../lib/std.scad>` (résolution `$fs`/`$fa`, `EPS`, `BIG`,
  et les modules `section()`, `quarter_cut()`, `slice_2d()`, `view_2d()`).
- Tous les paramètres sont des **variables nommées en tête de fichier**, avec unité et
  commentaire. Aucun nombre magique au milieu de la géométrie.
- Jeux fonctionnels (`clearance`, `fit`) toujours en variable explicite, jamais codés en dur.
- `EPS` pour décaler les soustractions et éviter les faces coplanaires.
- Ne pas fixer `$fn` globalement : `std.scad` règle `$fs`/`$fa` (grossier en preview,
  fin au rendu final). `$fn` local uniquement pour les polygones voulus (hexagones, etc.).

## Chaque modèle a un README — obligatoire

`models/<slug>/README.md` fait partie du modèle, au même titre que son `.scad`. Un
modèle sans README est incomplet. Il se rédige **au fur et à mesure**, pas à la fin :
c'est là qu'on consigne ce que les cotes ne disent pas.

Sections attendues, dans cet ordre :

1. **À quoi sert la pièce** — un paragraphe, et ce qu'elle vise comme objet réel
   (référence, dimensions constatées, source de ces dimensions).
2. **Pièces à imprimer** — un tableau *pièce / valeur de `PIECE=` / quantité*, avec la
   commande d'export.
3. **Cotes principales** — tableau. Privilégier les valeurs **mesurées sur le maillage
   exporté** aux valeurs du source : ce sont elles qui iront dans l'imprimante.
4. **Montage ou usage** — l'ordre des opérations quand il compte, et pourquoi.
5. **Impression** — orientation, supports, matière, remplissage.
6. **Contraintes à connaître avant de modifier** — les bornes des paramètres et ce qui
   casse si on les dépasse. C'est la section la plus utile et la plus vite oubliée.
7. **Points de vérification** — ce qui reste incertain, et quoi mesurer pour trancher.

Copier `models/_template/README.md` en même temps que le `.scad`.

Expliquer **pourquoi** une cote vaut ce qu'elle vaut, pas seulement sa valeur : un
lecteur qui connaît la raison d'un jeu de 0,3 mm saura le changer à bon escient.

## Outillage — `scripts/scad.py`

Tout passe par ce script ; il gère les caméras, les fichiers d'enrobage et les sorties.

```bash
python scripts/scad.py views   <slug>                          # rendus 3D : iso, face, droite, dessus
python scripts/scad.py section <slug> --axis x --at 0          # coupe demi-espace (ou --axis quarter)
python scripts/scad.py slices  <slug> --axis z --count 5       # tranches 2D réparties automatiquement
python scripts/scad.py drawing <slug>                          # dessins techniques 2D (face/droite/dessus)
python scripts/scad.py info    <slug>                          # encombrement (bounding box) en mm
python scripts/scad.py stl     <slug> --binaire                # export STL (binaire : 6x plus compact)
python scripts/scad.py all     <slug>                          # vues + dessins + encombrement
```

- `--fast` : preview au lieu du rendu CGAL complet, pour itérer vite.
- `--views iso front right top bottom left back` pour choisir les angles.
- Les commandes 2D produisent **SVG + PNG** : le SVG pour la CAO/l'impression papier,
  le PNG pour pouvoir le regarder.

## Boucle de travail attendue

1. Modifier le `.scad`.
2. **Régénérer et REGARDER les rendus** — ne jamais déclarer une pièce correcte sans
   avoir ouvert les PNG produits (les images sont lisibles directement).
3. Pour toute cavité, emboîtement ou paroi interne : produire une **coupe**
   (`section`) et/ou des **tranches** (`slices`) et vérifier visuellement les épaisseurs.
4. Vérifier l'encombrement avec `info` et le confronter aux cotes visées.
5. Consigner les cotes clés et les réglages d'impression dans le `README.md` du modèle.

Les images de `out/` sont régénérables : ne pas les committer. Si une vue doit être
conservée pour la documentation, la copier dans `models/<slug>/doc/`.

## Bibliothèque BOSL2

**BOSL2 v2.0.755** (BSD-2) vit dans **`vendor/BOSL2/`**, à l'intérieur du dépôt.

`vendor/` est **exclu de git** : 13 Mo de code tiers, reproductibles depuis leur source.
Après un clone :

```bash
python scripts/setup_libs.py
```

`scripts/scad.py` ajoute automatiquement `vendor/` à `OPENSCADPATH`, donc la ligne
`include <BOSL2/std.scad>` fonctionne sans rien configurer.

**L'interface graphique d'OpenSCAD ne passe pas par ce script.** Pour y ouvrir un modèle
qui utilise BOSL2, définir soi-même la variable d'environnement `OPENSCADPATH` sur le
chemin absolu de `vendor/`. Ne pas remettre la bibliothèque dans le dossier Documents :
il est synchronisé sur OneDrive sur cette machine.

```openscad
include <BOSL2/std.scad>
```

À préférer aux constructions maison pour :

- **Congés et chanfreins 3D** — `cuboid(chamfer=)`, `cyl(rounding=)`,
  `offset_sweep()` pour chanfreiner les extrémités d'une extrusion, `rounded_prism()`.
  OpenSCAD seul n'a pas d'opérateur de chanfrein 3D : sur un profil concave, ni `hull()`
  (qui rend l'enveloppe convexe) ni `minkowski()` (impraticable au-delà de quelques
  centaines de sommets) ne conviennent.
- **Visserie et filetages** — vis métriques et têtes fraisées aux cotes normalisées,
  filetage trapézoïdal (le TR21×4 des cylindres de CO2, par exemple).
- **Attachements** — `attach()` / `position()` placent une pièce contre une autre par
  ancrages nommés, au lieu d'empiler des `translate()` où les erreurs de repère sont
  faciles.

Contreparties, à peser avant de l'inclure :

- Elle alourdit nettement les temps de compilation, déjà le point douloureux ici.
- `offset_sweep()` travaille sur des **chemins de points**, pas sur la géométrie opaque
  que rend l'`offset()` natif : passer un profil existant à BOSL2 demande de le
  reconstruire avec les régions BOSL2, ce n'est pas un simple `include` de plus.
- Le dépôt est encore estampillé BETA en amont.

`models/rack-sodastream/` reste volontairement en OpenSCAD standard.

## Environnement

- OpenSCAD doit être installé et accessible : `winget install OpenSCAD.OpenSCAD`.
  Le script cherche `openscad.com`/`openscad.exe` dans le `PATH`, puis dans
  `C:\Program Files\OpenSCAD\`, sinon la variable d'environnement `OPENSCAD`.
- Aucun MCP ni skill OpenSCAD publique n'existe : passer par `scripts/scad.py`, pas par
  des appels `openscad` improvisés (les caméras et l'enrobage `use <>` sont non triviaux).
- `.claude/launch.json` déclare un serveur statique (`preview`, port 8765) pour tester
  une page localement avant publication.

## Partager un aperçu

La skill de projet **`scad-preview`** publie un artefact à deux onglets — viewer 3D
rotatif alimenté par le STL, et planche des rendus. Elle ne remplace pas la boucle de
vérification ci-dessus : on regarde les PNG soi-même avant de publier quoi que ce soit.
