# vide-poches

Panier mural qui s'enfile par le haut sur deux chevilles d'assemblage de meuble,
en les gardant invisibles, avec crochet à casque intégré et séparateurs amovibles.

## 1. À quoi sert la pièce

Vider ses poches en rentrant : paquet de tabac, briquets, lunettes, câbles USB,
petites bricoles — et suspendre un casque Sony WH-1000XM5 dessous.

La pièce se visse sur le flanc d'un meuble en bois. Une cheville d'assemblage y est
déjà en place ; la seconde est à poser, donc son écartement est libre.

**Géométrie de la cheville** (relevée sur la pièce en place, photo au réglet) :
douille plastique sertie dans le bois, collerette de **Ø 7,3** qui dépasse de la
surface, puis **tige lisse de Ø 3,4**, puis tête bombée.

> Les cotes `col_h` (dépassement de la collerette), `vis_l` (longueur de tige
> libre) et `tete_d` / `tete_h` sont pour l'instant **lues sur photo**, pas au
> réglet. Elles ne pilotent que l'épaisseur du dos — aucune autre partie de la
> pièce n'en dépend.

**Objets visés** :

| Objet | Encombrement retenu | Conséquence |
|---|---|---|
| Lunettes pliées | 145 × 45 mm | impose les **150 mm** du grand compartiment, donc la largeur de la pièce |
| Paquet de tabac | ~100 × 80 × 25 mm | rangé **sur la tranche**, d'où une fente de 27 mm au lieu d'un bac de 80 |
| Casque WH-1000XM5 | arceau, ~250 g | ne se plie pas (contrairement au XM4) : il faut une portée large, pas une patte |

## 2. Pièces à imprimer

| Pièce | `PIECE=` | Qté | Rôle |
|---|---|---|---|
| Coque | `coque` | 1 | dos, bac nu, crochet |
| Insert | `insert` | 1 | les séparateurs seuls |
| Gabarit | `gabarit` | 1 | réglet de perçage de la seconde cheville — consommable |

```bash
python scripts/scad.py stl vide-poches -D PIECE=coque   --binaire
python scripts/scad.py stl vide-poches -D PIECE=insert  --binaire
python scripts/scad.py stl vide-poches -D PIECE=gabarit --binaire
```

**L'insert n'a pas de fond** : c'est celui de la coque qui sert de fond aux
compartiments. Il n'ajoute donc rien au poids par rapport à une version monobloc —
il en retire même 20 g, parce qu'il est rétréci de `insert_jeu` au pourtour.
Changer d'agencement ne coûte que **53 g** de réimpression, et la coque reste
utilisable en plateau nu.

Coque et insert se déduisent tous deux de la **même liste `cuves`** : un compartiment
ajouté ou déplacé met les deux pièces à jour, elles ne peuvent pas diverger.

`PIECE=panier` montre l'ensemble monté ; `dos`, `bac`, `crochet` isolent un
sous-ensemble pour l'inspecter ou le mesurer. Aucun de ces quatre ne s'imprime.

## 3. Cotes principales

Mesurées sur les maillages exportés.

| | Volume | PLA | Encombrement |
|---|---|---|---|
| Coque | 307,7 cm³ | 382 g | 200 × 102,3 × 138 mm |
| Insert | 43,0 cm³ | 53 g | 194,2 × 75,0 × 57,6 mm |
| **Total** | **350,7 cm³** | **435 g** | |

| Cote | Valeur | Origine |
|---|---|---|
| Épaisseur du dos | 23,9 mm | `col_h + porteur + loge_e + dos_av` |
| Empilage du dos (plans Y) | 0 / 1,60 / 5,00 / 17,50 / 21,50 / 23,90 | mesuré sur le maillage |
| Entraxe des chevilles | 140 mm | libre — la 2ᵉ est à poser |
| Fente de tige | 4,2 mm | `vis_d + jeu_vis` |
| Matière autour de la fente | 10 mm de chaque côté | `dos_plein − fente/2` |
| Course d'enfilage | 80 mm | du bas du dos au siège |
| Jeu insert / coque | 0,5 mm par côté | `insert_jeu` |
| Air piégé dans le dos | 221,2 cm³ en 14 cavités | mesuré sur le maillage |

## 4. Montage ou usage

1. **Percer la seconde cheville.** Poser le gabarit sur la cheville existante, le
   mettre de niveau, pointer par le petit trou. Les deux chevilles doivent être à
   la **même hauteur** : c'est ce qui empêche le panier de vriller quand on le
   charge de travers.
2. **Présenter la coque au-dessus des vis**, les deux têtes en face des canaux.
3. **La descendre.** Les collerettes montent dans leur canal, les tiges dans leur
   fente, les têtes dans leur logement. Elle vient en butée toute seule.
4. **Poser l'insert** dans le bac. Il tombe en place, rien à fixer.

Pour décrocher : retirer l'insert si on veut, soulever de 80 mm, tirer vers soi.
Rien à dévisser. L'insert se reprend en pinçant le séparateur central, qui court
sur toute la profondeur.

## 5. Impression

**La coque se pose sur son dos, plaque arrière contre le plateau.** C'est
l'orientation qui la rend imprimable d'un seul bloc : tout ce qui pointe vers
l'avant à l'usage — le fond du bac, le bras du crochet — devient vertical.

**L'insert se pose à plat**, séparateurs debout. Un **bord d'adhérence (brim) est
recommandé** : il ne touche le plateau que par la tranche de ses cloisons, soit
7,1 cm² seulement, pour des parois de 57,6 mm de haut.

- **Aucun support, sur aucune des deux pièces.**
- Le plus grand pontage est la peau avant du dos au-dessus d'une cavité
  d'allègement : **30 mm**. Sans difficulté en PLA, et la peau fait 6 couches —
  seule la première ponte.
- PLA. Le bras du crochet travaille en traction entre couches, la direction faible :
  250 g de casque à 60 mm de porte-à-faux donnent **0,22 MPa** sur une section de
  40 × 10 mm, contre ~20 MPa de cohésion inter-couches. Facteur 90.
- Emprise plateau : 200 × 138 mm pour la coque. Tient sur un plateau de 220 avec
  10 mm de marge de chaque côté.

## 6. Contraintes à connaître avant de modifier

- **`porteur` ≤ `vis_l`.** La plaque porteuse se glisse entre la collerette et la
  tête : plus épaisse que la tige libre, elle ne rentre pas. Le modèle la fixe à
  `vis_l − 0,5`, c'est-à-dire au maximum utile — la tête vient alors buter
  directement contre elle, sans jeu axial vers l'avant.
- **Tous les compartiments doivent avoir le même congé.** L'insert se calcule comme
  *l'intérieur moins les compartiments* : un compartiment plus arrondi que le
  pourtour laisse dans le coin un **fragment de matière détaché**, qui sortirait de
  l'imprimante en morceau libre. C'est ce qui a fait renoncer au puits à câbles
  rond (r = 18 contre r = 4).
- **Tout compartiment ajouté doit toucher au moins un autre séparateur**, sinon il
  détache un morceau de l'insert. À vérifier sur le maillage, pas à l'œil.
- **`croc_r_z` < `croc_r_y` impérativement.** À l'impression, la rampe de retenue
  du crochet est un porte-à-faux dont l'angle depuis la verticale vaut
  `atan(croc_r_z / croc_r_y)`. À 14/16 on est à 41°, sous la limite de 45° ;
  au-delà il faut des supports et l'orientation « un seul bloc » s'écroule.
- **La grille d'allègement doit laisser une nervure pleine sur ses quatre bords.**
  Une première version démarrait à une demi-nervure du bord et laissait 1,5 mm de
  matière sur tout le pourtour du dos.
- **`dos_plein` ne doit pas avaler la grille.** À 22 mm, les colonnes pleines
  recouvraient la moitié des poches et ne laissaient que des fentes de 2 à 3 mm :
  du vide qui n'allège rien et qui affaiblit. 12 mm suffisent.
- **Les colonnes pleines n'existent que dans le bandeau**, au-dessus du bac. C'est
  la seule hauteur où la vis porte ; plus bas, le canal n'est qu'un couloir libre
  entre les nervures.
- **L'`offset(r) offset(−r)` qui adoucit le profil du crochet rogne sa pointe.**
  À r = 2 la rampe perdait 2,4 mm de hauteur sans que rien ne le signale.
- **150 mm de compartiment à lunettes commandent la largeur de la pièce.** Réduire
  `larg` sans toucher au compartiment ne donne rien.

## 7. Points de vérification

- [ ] **Relever au réglet** `col_h`, `vis_l`, `tete_d`, `tete_h`. Elles ne sont pour
      l'instant que lues sur photo.
- [ ] **La douille métallique déjà en place**, à ~45 mm en diagonale de la cheville,
      est-elle utilisable ? À cet écartement elle ne convient pas pour un panier de
      200 mm — il faut une seconde cheville à la même hauteur.
- [ ] **435 g de PLA** pour une pièce annoncée « petit panier ». À arbitrer :
      réduire `bac_h`, `bac_int`, ou la hauteur du bandeau.
- [ ] Vérifier que le casque passe : `croc_jour` = 30 mm entre le bras et le
      dessous du bac, à confronter à l'arceau réel.
- [ ] Le jeu de 0,5 mm au pourtour de l'insert n'a pas été validé à l'impression.
      Un insert trop serré ne rentre pas ; trop lâche, il cliquette.
