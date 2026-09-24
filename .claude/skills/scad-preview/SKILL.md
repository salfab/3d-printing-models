---
name: scad-preview
description: Publie un aperçu web d'un modèle OpenSCAD du dépôt — viewer 3D interactif plus planche de rendus, dans un artefact Claude partageable. À utiliser quand on demande un aperçu, une prévisualisation, un lien à partager, ou « montre-moi la pièce » pour un modèle de models/<slug>/.
---

# Aperçu web d'un modèle OpenSCAD

Publie un artefact à deux onglets : un **viewer 3D** rotatif alimenté par le STL, et une
**planche** des rendus, coupes, tranches et dessins techniques produits par `scripts/scad.py`.

## Quand ne pas l'utiliser

Cette skill est l'étape de **restitution**, pas de vérification. La boucle de contrôle reste
celle du `CLAUDE.md` : régénérer les vues et les regarder soi-même. Ne publie jamais un
rendu que tu n'as pas ouvert — un artefact ne dispense pas de juger la pièce.

Pour une simple question de cote, `python scripts/scad.py info <slug>` suffit.

## Étape 1 — générer

```bash
python scripts/scad.py all <slug>
python scripts/scad.py stl <slug>
```

Ajoute les coupes et tranches qui montrent ce qui compte sur cette pièce, par exemple
`section <slug> --axis quarter` ou `slices <slug> --axis z --count 5`.

## Étape 2 — regarder

Ouvre les PNG de `models/<slug>/out/`. C'est ici qu'on juge la pièce. Si quelque chose
cloche, corrige le `.scad` et reprends à l'étape 1.

## Étape 3 — préparer les pièces jointes

```bash
python .claude/skills/scad-preview/scripts/preview_pack.py <slug> --titre "<Nom lisible>"
```

Écrit `models/<slug>/out/preview/` contenant `model-data.js` (le STL en base64 plus le
manifeste des vues et l'encombrement) et une copie des PNG. Le script refuse un STL de
plus de 8 Mo et indique alors de le régénérer avec `--fast`.

Pour une pièce précise d'un modèle multi-variantes, passe le STL voulu :
`--stl models/<slug>/out/<slug>-avant.stl`.

Un modèle en plusieurs pièces (coque et insert, par exemple) : répète `--stl`, une fois
par pièce. Le viewer les montre ensemble, chacune dans sa couleur, avec un bouton par
pièce pour l'isoler. Elles doivent être modélisées **en place**, dans le même repère,
pour que la vue d'ensemble les montre assemblées. Le seuil de taille porte sur le total.

## Étape 4 — construire la page

1. Charge d'abord la skill `artifact-design` — obligatoire avant toute écriture de page.
2. Copie `references/viewer.html` vers `models/<slug>/out/preview/index.html`.
3. Adapte au modèle : le `<title>` doit être un **nom** de deux à quatre mots propre à
   cette pièce, jamais « Aperçu » ni un libellé générique. Ajuste la phrase d'aide et les
   boutons de vue si la pièce a des orientations remarquables.

Le template est déjà conforme au contrat d'artefact : tokens de couleur sur `:root` avec
les deux blocs sombres, `body` au fond explicite, gouttière de 16 px, grille responsive.

## Étape 5 — publier

Outil `Artifact`, action `publish` :

- `file_path` = `models/<slug>/out/preview/index.html`
- `files` = `model-data.js` **et chaque PNG**, publiés au même nom qu'ils portent dans
  `preview/` (la page les référence en chemin relatif)
- `icon` = un mot générique, par exemple `cube`, au premier envoi seulement
- `description` = une phrase

Pour une itération suivante sur le même modèle, republie avec le **même `file_path`**, ou
avec `url` s'il vient d'une conversation antérieure. Ne crée jamais un second artefact
pour la même pièce.

## Contraintes vérifiées

- **Un seul script externe** : `https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js`,
  build UMD qui définit le global `THREE`.
- **cdnjs ne sert pas le dossier `examples/`** — `STLLoader.js` et `OrbitControls.js`
  renvoient 404. Le template embarque donc son propre parseur de STL binaire et ses
  contrôles d'orbite. Ne tente pas de les charger depuis un CDN, et n'introduis pas
  d'`importmap` ESM : le contrat d'artefact demande un build UMD.
- **Le STL ne peut pas être un fichier compagnon** : `model/stl` n'est pas un type web
  standard. Il transite en base64 dans `model-data.js`, qui est du JavaScript, donc un
  type accepté. Les PNG, eux, partent en fichiers compagnons — c'est là qu'est le volume,
  et on évite ainsi les +33 % du base64.
- **16 Mo** pour la page rendue, data URI compris.
- La géométrie est tournée de −90° autour de X : OpenSCAD travaille en Z vers le haut,
  three.js en Y vers le haut.

## Tester avant de publier

`.claude/launch.json` déclare un serveur statique. `preview_start` avec le nom `preview`,
puis ouvrir `http://localhost:8765/models/<slug>/out/preview/index.html` : les fichiers
compagnons se résolvent alors correctement, ce qui n'est pas le cas en `file://`. Cela
évite de consommer une version d'artefact pour un essai.

## Fichiers de la skill

- `references/viewer.html` — le template de page, testé et conforme.
- `scripts/preview_pack.py` — prépare `model-data.js` et copie les PNG.
