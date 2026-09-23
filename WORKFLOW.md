# Méthode de conception

Comment on conçoit une pièce dans ce dépôt : le cycle de travail, l'outillage, et la
discipline de vérification qui va avec.

Ce document s'adresse aux humains. [`CLAUDE.md`](CLAUDE.md) contient les mêmes
conventions sous forme d'instructions pour Claude Code — les deux doivent rester
cohérents.

## 1. Le cycle

```
cadrer  →  paramétrer  →  rendre vite  →  REGARDER  →  mesurer  →  itérer
                              ↑                                      │
                              └──────────────────────────────────────┘
```

**Cadrer d'abord.** Une pièce imprimée matérialise une série de décisions : diamètre
réel de l'objet à accueillir, jeu fonctionnel, sens d'insertion, orientation
d'impression, mode de fixation. Les arrêter avant de modéliser coûte cinq minutes ;
les découvrir après coûte une bobine.

**Paramétrer, pas coter.** Toute dimension est une variable nommée en tête de fichier,
avec son unité et la raison de sa valeur. Un modèle où l'on change le diamètre de
l'objet visé et où tout suit vaut infiniment mieux qu'un modèle juste une fois.

**Rendre vite pour itérer.** `--fast` produit un aperçu en quelques dixièmes de
seconde là où le rendu CGAL complet prend plusieurs minutes. On itère sur la forme en
mode rapide, on ne passe au rendu complet que pour les livrables.

**Regarder.** C'est l'étape qu'on saute et qu'il ne faut jamais sauter. Un rendu qu'on
n'a pas ouvert ne prouve rien. Deux exemples vécus : une bride entièrement disparue
d'un modèle qui compilait sans la moindre erreur, et des colliers si étroits qu'ils ne
lisaient plus comme des volumes.

**Mesurer sur le maillage, pas sur le source.** Le `.scad` dit ce qu'on a demandé ; le
STL dit ce qui sera imprimé. Entre les deux il y a la polygonisation, les opérations
booléennes et les approximations de CGAL. `scripts/scad.py info` et les scripts d'analyse
lisent le maillage exporté.

## 2. L'outillage

| Outil | Rôle |
|---|---|
| `scripts/scad.py` | pilote OpenSCAD : rendus, coupes, tranches, dessins, STL, encombrement, contrôle de péremption |
| `lib/std.scad` | `section()`, `quarter_cut()`, `slice_2d()`, `view_2d()`, et la résolution des courbes |
| `scripts/setup_libs.py` | installe les bibliothèques tierces dans `vendor/`, exclu du dépôt |
| skill `scad-preview` | publie un aperçu web : viewer 3D interactif et planche de rendus |

Passer par `scad.py` plutôt que par `openscad` en direct : les caméras normalisées et
l'enrobage `use <>` qui permet de couper ou projeter un modèle sans le modifier sont
non triviaux, et le contrôle de péremption ne fonctionne que par lui.

```bash
python scripts/scad.py views   <slug> --fast          # itérer sur la forme
python scripts/scad.py section <slug> --axis quarter  # voir l'intérieur
python scripts/scad.py slices  <slug> --axis z --count 5
python scripts/scad.py drawing <slug>                 # dessins techniques cotables
python scripts/scad.py info    <slug>                 # encombrement mesuré
python scripts/scad.py stl     <slug> --binaire
python scripts/scad.py check   <slug>                 # les sorties sont-elles à jour ?
```

`-D CLE=VALEUR` surcharge n'importe quelle variable du modèle. C'est ainsi qu'un même
fichier produit plusieurs pièces — `-D PIECE=avant`, `-D PIECE=guide` — sans duplication,
et les sorties sont nommées d'après la variante.

## 3. Quatre vérifications, pas une

Une pièce peut être juste sur un axe et fausse sur un autre. Chacun de ces quatre
contrôles a rattrapé un défaut réel dans ce dépôt, qu'aucun des trois autres ne voyait.

**Les sections.** Épaisseurs de paroi, jeux, matière restante aux emboîtements. Se
mesure sur le maillage. Attention au piège du diamètre : OpenSCAD trace des polygones
**inscrits**, donc un alésage passe toujours un peu plus petit que sa cote nominale.
C'est la distance du centre au **milieu de chaque corde** qui donne le passage réel —
un contrôle naïf sur les sommets afficherait la cote nominale et masquerait le défaut.

**La cinématique.** *Dans quel sens cette pièce peut-elle bouger, et qu'est-ce qui l'en
empêche ?* Un arrêt peut être parfaitement dimensionné et bloquer la mauvaise direction.
Les sections ne le voient jamais.

**L'imprimabilité.** Porte-à-faux, pontages, orientation des couches vis-à-vis de la
charge. **À revérifier après toute modification de géométrie** : un changement de forme
peut invalider une contrainte de fabrication établie plus tôt, et c'est une régression
qu'aucune mesure de section ne détecte.

**La fraîcheur.** Les sorties viennent-elles bien du source actuel ? Une génération
lancée en tâche de fond continue pendant qu'on modifie le `.scad`, et les rendus se
retrouvent issus de versions différentes sans que rien ne le signale.

```bash
python scripts/scad.py check <slug>
```

Chaque sortie est inscrite dans `out/.manifest.json` avec l'empreinte SHA-256 des
sources dont elle vient — le `.scad` du modèle **et** `lib/`, puisqu'un module partagé
périme aussi les rendus. `preview_pack.py` refuse de publier tant qu'une sortie est
périmée.

## 4. Pièges rencontrés

Tous vérifiés dans ce dépôt, avec leurs chiffres.

**Un `offset(r=)` trop grand vide une forme en silence.** Arrondir les coins d'une bride
de 6 mm avec un rayon de 4 donne un carré de base de hauteur −2 : profil vide, aucune
erreur, bride absente du rendu. Borner les rayons par construction.

**Une résolution trop fine fait exploser le temps de calcul.** `$fa = 1` produit 360
segments sur un alésage de Ø 69 et portait un rendu à plus de sept minutes. À `$fa = 3`,
soit 120 segments, la flèche tombe à 0,011 mm — très en deçà de ce qu'une buse de 0,4 mm
reproduit — et le rendu à moins de deux minutes.

**OpenSCAD 2021.01 n'exporte qu'en STL ASCII**, six fois plus volumineux que le binaire.
D'où l'option `--binaire`, qui ramène une plaque de 9,3 à 2,6 Mo.

**Comparer deux fichiers n'est pas comparer deux pièces.** Un `cmp` opposant un export
binaire à un export ASCII crie « différent » sur une géométrie rigoureusement identique.
Comparer plutôt le nombre de triangles, de sommets distincts, et l'encombrement.

**Le chanfrein 3D n'existe pas en OpenSCAD standard.** Sur un profil concave, ni `hull()`
— qui rend l'enveloppe convexe — ni `minkowski()` — impraticable au-delà de quelques
centaines de sommets — ne conviennent. Deux sorties : empiler des tranches de profil
décalé à raison d'une marche par couche d'impression, ou passer par BOSL2 et
`offset_sweep()`.

**Le rendu couleur d'OpenSCAD 2021.01 n'est pas fiable.** `color()` est ignoré par le
rendu CGAL ; il ne s'affiche qu'en aperçu OpenCSG, qui produit des traînées blanches
ressemblant à des trous là où deux surfaces sont proches ou minces. Une illustration
montrant plusieurs pièces doit donc les distinguer **par la forme ou par la séparation**,
jamais par la couleur : dessiner un détail reconnaissable, ou simplement retirer de la
scène ce qui n'est pas le sujet. Le corollaire vaut aussi pour le diagnostic : un trou vu
sur un aperçu se vérifie sur le maillage avant d'être cru.

**Une pièce obtenue par soustraction peut sortir en plusieurs morceaux.** Quand on
définit un objet comme « le plein moins les creux » — des séparateurs comme
l'intérieur moins les compartiments, par exemple — il suffit qu'un creux soit plus
arrondi que son voisin pour qu'il reste dans un coin un fragment détaché du reste,
que rien ne signale. Le contrôle se fait sur le maillage : on soude les sommets par
position, on relie ceux qui partagent un triangle, et on somme le volume signé de
chaque composante. **Une composante de volume positif est une pièce, une composante
de volume négatif est une cavité fermée.** Deux volumes positifs, c'est un morceau
libre. Le dos du vide-poches, par exemple, compte 1 coque et 14 cavités : correct.

**Une cavité fermée n'est pas un allègement gratuit.** Des poches prises entre deux
peaux se lisent volontiers comme « ouvertes », alors que le trancheur doit ponter
chacune sur tout son pas. Le commentaire qui les décrit doit dire laquelle des deux
choses elles sont, sinon c'est lui qu'on croira.

**Un trou dans un modèle est presque toujours une coïncidence, pas une absence.**
Trois s'en sont suivies sur la même pièce, toutes rendues en arêtes non-variété et
toutes vues à l'écran comme un trou. *Un niveau dérivé qui retombe sur une surface* :
un fond de compartiment à `marche + fond` et un dessous d'enveloppe à `marche + paroi`
sont le même plan tant que `fond == paroi`. *Un prisme de creusement borné pile sur la
paroi qu'il longe* : il doit déborder franchement — 5 mm, pas 0,2, sinon on remplace la
face coplanaire par un éclat rasant. *Deux balayages concentriques à leur lèvre* : un
arrondi `offset_sweep` rentre le profil de son propre rayon, donc un extérieur arrondi
de `r` et un intérieur décalé de `e` et arrondi de `r - e` **coïncident exactement** à
la lèvre ; tout ce qui se soustrait doit s'arrêter avant.

Le diagnostic qui a marché : compter les arêtes du maillage par nombre de faces, puis
**lister les arêtes non-variété une par une avec leurs coordonnées**. Les histogrammes
par axe ne disent rien ; les coordonnées brutes, elles, tombent pile sur les valeurs
nommées du source — `±xi0`, `dos_ep`, `fond_haut` — et nomment le coupable.

**Zéro arête de bord ne veut pas dire zéro trou.** Une soustraction qui débouche là où
elle ne devrait pas produit une forme parfaitement fermée : le maillage est sain, la
pièce est percée. C'est le volume et les composantes qu'il faut regarder, pas l'étanchéité.

**Un `-D` mal cité échoue en silence.** OpenSCAD rend 0 même quand il n'a rien
écrit : des guillemets passés en trop produisent un nom de fichier invalide, aucun
export, aucune erreur — et la mesure suivante porte sur le fichier de la run
précédente. `scripts/scad.py` refuse désormais un export vide.

**Éditer un fichier par script est dangereux ; passer par un outil d'édition qui
exige une correspondance unique ne l'est pas.** Un `str.index()` sur un marqueur qui
apparaît deux fois dans un fichier a produit une tranche vide, puis un
`replace("")` a inséré un bloc entre chaque caractère : 339 lignes devenues 1,2
million. Corollaire : **commiter un modèle dès qu'il compile**, avant toute
retouche — c'est ce qui rend l'incident réparable au lieu d'être une perte sèche.

**Les têtes fraisées annulent le jeu des trous de passage.** Un cône à 90° se centre
dans son fraisage en se serrant. Ce sont donc les avant-trous qui imposent la position
d'une pièce vissée, pas l'ajustement des trous — d'où l'obligation de marquer les
perçages à travers l'assemblage monté plutôt que d'après un gabarit.

## 5. Publier un aperçu

La skill `scad-preview` produit un artefact web à deux onglets : un viewer 3D rotatif
alimenté par le STL, et une planche des rendus, coupes et dessins.

Trois contraintes techniques y sont figées, chacune vérifiée :

- **Un seul script externe**, `three.min.js` en UMD depuis cdnjs. Le dossier `examples/`
  n'y est pas servi — `STLLoader.js` renvoie 404 — donc le parseur de STL binaire et les
  contrôles d'orbite sont écrits en ligne.
- **Le STL ne peut pas être un fichier compagnon** : `model/stl` n'est pas un type web
  standard. Il transite en base64 dans un `.js`. Les PNG, eux, partent en fichiers
  compagnons, là où est le volume.
- **Le cadrage caméra doit tenir compte du champ horizontal**, pas seulement du vertical :
  sur un écran de téléphone, étroit et haut, c'est lui qui contraint.

Tester la page en local avant publication, via le serveur déclaré dans
`.claude/launch.json`, évite de consommer une version d'artefact pour un essai.

## 6. Conventions

- **Un modèle par sous-répertoire** sous `models/<slug>/`, jamais de `.scad` de modèle à
  la racine.
- Le fichier principal **expose un `module main()`** et l'appelle. L'outillage fait
  `use <…>` dessus : sans `main()`, ni rendu, ni coupe, ni dessin.
- **Chaque modèle a un README**, rédigé au fur et à mesure. Ses sections sont décrites
  dans `CLAUDE.md`, et `models/_template/README.md` en donne le squelette.
- Millimètres partout. Documentation en français.
- `models/*/out/` et `vendor/` sont hors dépôt : régénérables l'un et l'autre.
