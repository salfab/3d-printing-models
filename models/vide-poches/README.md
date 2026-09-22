# vide-poches

Panier mural qui s'enfile par le haut sur deux chevilles d'assemblage de meuble,
en les gardant invisibles. Fond à deux niveaux, crochet à casque sous la partie
haute, séparations amovibles.

## 1. À quoi sert la pièce

Vider ses poches en rentrant : paquet de tabac, briquets, lunettes, câbles USB,
petites bricoles — et suspendre un casque Sony WH-1000XM5 dessous.

La pièce se visse sur le flanc d'un meuble en bois. Une cheville d'assemblage y est
déjà en place ; la seconde est à poser, et percer ne pose pas de problème — son
écartement est donc libre, fixé à 95 mm.

Une douille métallique subsiste à ~45 mm en diagonale de la cheville, reste d'un
ancien montage. **Elle n'est pas utilisée** : à cet écartement les deux points
seraient concentrés au centre de la pièce, le couple de vrillage repris sur un bras
trois fois plus court, et la diagonale ne bloque pas la rotation aussi bien qu'un
alignement horizontal.

### La cheville

Douille plastique sertie dans le bois, fût de **Ø 7,3** qui dépasse de la surface,
puis **tige lisse de Ø 3,4**, puis tête bombée.

Relevé au réglet : tige lisse libre **14 mm**, tête **3 mm** de haut, et **saillie
totale hors bois, vis en place, 22,2 mm**.

Cette dernière est la seule cote prise sur **l'ensemble monté**, donc la seule qui
intègre ce que le fût s'enfonce. Le modèle en déduit la saillie du fût —
22,2 − 14 − 3 = **5,2 mm** — au lieu de la mesurer : hors bois le fût fait 6, en
place il n'en dépasse que 5,2.

Ce n'est pas un détail de 0,8 mm. À `col_h = 6`, la plaque porteuse irait de 6 à
19,5 alors que le dessous de la tête est à 19,2 : elles se chevaucheraient de
0,3 mm, la tête taperait la plaque avant que le dos ne touche le bois, et le panier
resterait décollé, en appui sur deux têtes de vis.

Le Ø de la tête n'a pas été mesuré et le modèle le **majore volontairement** à 8 :
son logement ne guide rien, il ne fait que dégager.

### Un vrai trou de serrure, et ce qu'il change

La tête entre par un **trou percé dans la plaque porteuse**, au bas de la course.
On présente, on pousse contre le bois, on descend de 20 mm : la tige monte dans la
fente étroite et la tête se retrouve captive derrière.

Une version antérieure faisait remonter la tête depuis le **bord inférieur** de la
pièce. Conséquence invisible mais lourde : les 26 mm d'épaisseur de fixation
devaient courir sur toute la hauteur, 145 mm. Avec le trou d'entrée, **40 mm de
bossage suffisent** — le reste du dos n'est plus qu'une plaque de 3 mm, les 23 mm
libérés derrière le bac deviennent du rangement, et la pièce perd 15 mm de
profondeur hors tout tout en gagnant 8 mm de rangement.

### Ce qui commande la forme

**Le rangement debout.** Les lunettes pliées passent de 150 × 46 au sol à 50 × 37,
la poche à tabac de 105 × 30 à 85 × 30.

**La hauteur des lunettes.** Debout elles font 145 mm et leur sommet doit rester à
moins de 35 mm au-dessus de l'axe des colonnettes. D'où

```
dépassement = 145 − (bac_h − fond − insert_fond) − garde_vis = 34 mm
```

C'est cette inégalité, et non un besoin de volume, qui fixe `bac_h` à 95.

**Le fond à deux niveaux.** Un bac uniformément profond serait un puits où il
faudrait pêcher un briquet. Le fond plonge à gauche, où les lunettes et le tabac
tiennent debout sur 91 mm, et remonte à droite, où les briquets et les câbles n'ont
besoin que de 45. Entre les deux, un galbe et non une marche.

| Objet | Rangé | Zone | Empreinte |
|---|---|---|---|
| Lunettes pliées | debout | profonde, 91 mm | 50 × 37,6 |
| Poche à tabac | debout | profonde, 91 mm | 85 × 30 |
| Stylos, grands objets | debout | profonde, 91 mm | 32,6 × 37,6 |
| Câbles USB | en vrac | peu profonde, 45 mm | 42,7 × 42 |
| Briquets | en vrac | peu profonde, 45 mm | 37,7 × 42 |
| Petites bricoles | en vrac | peu profonde, 45 mm | 82,8 × 25,6 |

Le XM5 **ne se plie pas**, contrairement au XM4 : il faut une portée large sous
l'arceau, pas une patte fine.

## 2. Ce que l'orientation d'impression autorise

La coque s'imprime **couchée sur son dos**, plaque arrière contre le plateau. La
direction de construction est donc la **profondeur**, et c'est tout le sujet :

- Le plan de la **façade est le plan du plateau**. Toute silhouette qu'on y dessine
  sort sans un gramme de support : dessous en S, dessus en arche, congés partout.
- Toute surface tournée **vers l'avant est un toit**, et un toit se pose sur la
  couche du dessous quelle que soit sa pente. La face visible peut donc varier
  librement en profondeur — d'où le galbe de 15 mm à la jointure entre les faces
  perpendiculaires au mur et la face avant.
- C'est l'**arrière** qui est contraint, et justement il est plat : c'est la face
  qui porte sur le bois.

La pièce n'est donc pas un profil constant, contrairement à ce que j'ai d'abord
cru : c'est un volume dont seule la face cachée est plane.

## 3. Pièces à imprimer

| Pièce | `PIECE=` | Qté | Rôle |
|---|---|---|---|
| Coque | `coque` | 1 | dos, bac à deux niveaux, crochet |
| Inserts | `insert` | 1 jeu | les séparations — **deux corps**, un par zone |
| Gabarit | `gabarit` | 1 | réglet de perçage de la seconde cheville — consommable |

```bash
python scripts/scad.py stl vide-poches -D PIECE=coque   --binaire
python scripts/scad.py stl vide-poches -D PIECE=insert  --binaire
python scripts/scad.py stl vide-poches -D PIECE=gabarit --binaire
```

`PIECE=insert` sort **deux solides disjoints** dans un même STL, un par zone : la
cloison qui sépare les deux niveaux appartient à la coque, pas à l'insert. Un
contrôle de morceaux détachés doit donc en attendre deux ici, et **un seul** pour
la coque.

Coque et inserts se déduisent tous de la **même liste `cuves`** : un compartiment
ajouté ou déplacé met tout à jour, rien ne peut diverger.

**Le dos est plein, sans grille d'allègement** — c'est le remplissage du trancheur
qui s'en charge, mieux et sans les pièges qui allaient avec.

## 4. Cotes principales

Mesurées sur les maillages exportés.

| | Volume | Encombrement |
|---|---|---|
| Coque | 224,7 cm³ | 175 × 83,4 × 145 mm |
| Inserts (2) | 62,2 cm³ | |
| **Total** | **286,8 cm³** | |

> Volume **géométrique**. Le fil consommé dépend du remplissage choisi ; seuls les
> deux bossages de fixation et le bras du crochet sont épais, tout le reste est en
> parois minces qui s'impriment pleines.

| Cote | Valeur | Origine |
|---|---|---|
| Épaisseur du dos, hors fixation | 3,0 mm | `dos_ep` |
| Épaisseur au droit des vis | 26,1 mm | `col_h + porteur + loge_e + dos_av` |
| Hauteur du bossage | 40 mm | `boss_z1 − boss_z0` |
| Course d'enfilage | 20 mm | `course` |
| Plaque porteuse | 13,5 mm | `vis_l − 0,5` : toute la tige libre |
| Dégagement devant la tête | 0,5 mm | plaque à 18,70, dessous de tête à 19,20 |
| Entraxe des chevilles | 95 mm | libre — la 2ᵉ est à poser |
| Fente de tige | 4,2 mm | `vis_d + jeu_vis` |
| Trou de passage de la tête | 9,5 mm | `tete_d + jeu_entree` |
| Profondeur, zone profonde | 91 mm | tabac, lunettes, stylos |
| Profondeur, zone peu profonde | 45 mm | câbles, briquets, bricoles |
| Galbe de la jointure avant | 15 mm | `r_av_bac` |
| Jeu insert / coque | 0,5 mm par côté | `insert_jeu` |

## 5. Montage

1. **Percer la seconde cheville** au gabarit, à la **même hauteur** que
   l'existante : c'est ce qui empêche le panier de vriller quand on le charge de
   travers.
2. **Présenter la coque**, les deux têtes en face des trous de passage.
3. **Pousser contre le bois**, puis **descendre de 20 mm**. Elle vient en butée
   toute seule.
4. **Poser les deux inserts**, chacun dans sa zone.

Pour décrocher : remonter de 20 mm, tirer vers soi. Rien à dévisser.

## 6. Impression

- **Aucun support, sur aucune pièce.**
- Coque sur son dos ; inserts à plat, fond contre le plateau.
- PLA. Le bras du crochet travaille en traction entre couches, la direction faible :
  250 g de casque à 60 mm de porte-à-faux donnent **0,29 MPa** sur une section de
  30 × 10 mm, contre ~20 MPa de cohésion inter-couches. Facteur 70.
- Emprise plateau : 175 × 145 mm pour la coque.

## 7. Contraintes à connaître avant de modifier

- **Les cavités doivent être découpées dans l'enveloppe intérieure, jamais posées
  à un niveau.** Le dessous de la coque remonte vers les extrémités — coins
  arrondis, galbe — alors qu'un fond de compartiment est plat. Posées à plat, les
  cavités passaient sous la peau près des coins et **le bac débouchait par en
  dessous**, sur plusieurs millimètres, sans que rien ne le signale.
- **C'est cette même enveloppe qui débride le galbe avant.** Tant que les cavités
  étaient des prismes posés, `r_av_bac` était borné à l'épaisseur de paroi, 2 mm :
  au-delà l'arrondi passait derrière elles. Depuis, la coque garde son épaisseur
  partout et le galbe peut être aussi ample qu'on veut. Effet voulu : l'arase
  descend de `r_av_bac` à l'approche de la face avant.
- **L'arche doit passer au-dessus du siège de chaque vis** — assertion dans le
  modèle. Sinon le canal débouche par le haut et la vis ne retient plus rien. Elle
  a arrêté le rendu dès le premier essai.
- **Le galbe ne doit pas passer sous un compartiment profond** — autre assertion.
- **`r_galbe` doit rester petit.** L'arrondi d'un angle rentrant dilate la forme de
  r avant de la contracter ; le creux du galbe se rétrécit vers le haut, et à
  r = 25 la dilatation le rebouchait — le galbe ne montait plus qu'à 23 mm au lieu
  de 46, sans la moindre erreur.
- **L'arrondi avant se fait par marches empilées.** Deux marches par millimètre de
  rayon : à cinq marches pour 10 mm, les gradins se voient.
- **`bac_h` est fixé par une contrainte de hauteur, pas de volume.** Le réduire fait
  ressortir les lunettes au-dessus de l'axe des colonnettes, où la limite est 35 mm.
- **`porteur` ≤ `vis_l`.** La plaque porteuse se glisse entre le fût et la tête.
- **Tous les compartiments au même congé.** L'insert se calcule comme *l'intérieur
  de sa zone moins les compartiments* : un compartiment plus arrondi que le pourtour
  laisse dans le coin un fragment de matière détaché, qui sortirait de l'imprimante
  en morceau libre.
- **Un compartiment doit tenir entièrement dans une zone**, sinon il n'appartient à
  aucun insert et disparaît.
- **`croc_r_z` < `croc_r_y` impérativement** : la rampe de retenue du crochet est un
  porte-à-faux dont l'angle depuis la verticale vaut `atan(croc_r_z / croc_r_y)`.

## 8. Points de vérification

- [ ] Vérifier que le casque passe : le jour sous le crochet, à confronter à
      l'arceau réel.
- [ ] Le jeu de 0,5 mm au pourtour des inserts n'a pas été validé à l'impression.
- [ ] Les lunettes debout dans une fente de 50 × 37,6 sur 91 mm : tenue à vérifier.
- [ ] La poche à tabac debout dans une fente de 85 × 30 : une blague souple
      tient-elle droite ? C'est elle qui commande la largeur de la zone profonde.
- [ ] Les bossages descendent de 8 mm sous l'arase et mordent donc sur le haut des
      compartiments arrière. L'insert leur est dégagé, mais l'encombrement réel
      reste à juger en main.
