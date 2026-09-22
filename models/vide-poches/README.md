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

### Ce qui commande la forme

**Le rangement debout.** Les lunettes pliées passent de 150 × 46 au sol à 50 × 37,
la poche à tabac de 105 × 30 à 85 × 30. C'est ce qui a fait tomber la pièce de
200 mm de large à 135.

**La hauteur des lunettes.** Debout elles font 145 mm et leur sommet doit rester à
moins de 35 mm au-dessus de l'axe des colonnettes. D'où

```
dépassement = 145 − (bac_h − fond − insert_fond) − garde_vis
            = 145 − 91 − 20 = 34 mm
```

C'est cette inégalité, et non un besoin de volume, qui fixe `bac_h` à 95.

**Le fond à deux niveaux.** Un bac uniformément profond de 95 mm serait un puits où
il faudrait pêcher un briquet. Le fond plonge donc à gauche, où les lunettes et le
tabac tiennent debout sur 91 mm, et remonte à droite, où les briquets et les câbles
n'ont besoin que de 45. Entre les deux, un galbe et non une marche.

**Et cette forme est gratuite.** La pièce s'imprimant couchée sur son dos, le plan
de la façade EST le plan du plateau : toute silhouette qu'on y dessine sort sans un
gramme de support. Ce qui coûte, c'est de faire varier la profondeur — et elle est
constante. Tout le modèle est donc bâti sur un profil 2D en élévation, extrudé en
profondeur. Le passage de la boîte droite à cette forme a **retiré 76 g**.

| Objet | Rangé | Zone | Empreinte | Dépasse du bord |
|---|---|---|---|---|
| Lunettes pliées | debout | profonde, 91 mm | 50 × 37,6 | 54 mm |
| Poche à tabac | debout | profonde, 91 mm | 85 × 30 | 9 mm |
| Stylos, grands objets | debout | profonde, 91 mm | 32,6 × 37,6 | — |
| Câbles USB | en vrac | peu profonde, 45 mm | 42,8 × 42 | — |
| Briquets | en vrac | peu profonde, 45 mm | 42,8 × 25,6 | — |
| Casque WH-1000XM5 | pendu au crochet | — | — | — |

Le XM5 **ne se plie pas**, contrairement au XM4 : il faut une portée large sous
l'arceau, pas une patte fine.

## 2. Pièces à imprimer

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
cloison qui sépare les deux niveaux appartient à la coque, pas à l'insert, puisque
c'est elle qui retient le socle du côté peu profond et qu'elle raidit le bac en
reliant la paroi avant au dos à mi-largeur. Un contrôle de morceaux détachés doit
donc en attendre deux ici, et un seul par zone.

**Chaque insert porte son propre fond.** Une version antérieure n'était qu'un peigne
de cloisons sans fond, pour ne pas empiler deux fonds : elle économisait 29 g et ne
touchait le plateau que par la tranche de ses parois — 7 cm² pour toute la pièce.
Fragile à l'impression comme à la main.

Coque et inserts se déduisent tous de la **même liste `cuves`** : un compartiment
ajouté ou déplacé met tout à jour, rien ne peut diverger. Et un agencement se change
maintenant **zone par zone**.

`PIECE=panier` montre l'ensemble monté ; `dos`, `bac`, `crochet` isolent un
sous-ensemble pour l'inspecter ou le mesurer. Aucun de ces quatre ne s'imprime.

## 3. Cotes principales

Mesurées sur les maillages exportés.

| | Volume | PLA | Encombrement |
|---|---|---|---|
| Coque | 271,8 cm³ | 337 g | 135 × 98,5 × 133 mm |
| Inserts (2) | 53,1 cm³ | 66 g | |
| **Total** | **324,9 cm³** | **403 g** | |

> Ces 403 g sont le **volume géométrique**, pas le fil consommé. Les zones épaisses
> — bras du crochet, colonnes du dos — seront remplies par le trancheur, pas
> massives. Compter plutôt **320 à 350 g** réellement.

| Cote | Valeur | Origine |
|---|---|---|
| Épaisseur du dos | 26,1 mm | `col_h + porteur + loge_e + dos_av` |
| Empilage du dos (plans Y) | 0 / 1,60 / 5,20 / 18,70 / 23,70 / 26,10 | mesuré sur le maillage |
| Plaque porteuse | 13,5 mm | `vis_l − 0,5` : toute la tige libre |
| Dégagement devant la tête | 0,5 mm | plaque à 18,70, dessous de tête à 19,20 |
| Fonds du bac (plans Z) | 2,40 et 48,40 ; arase 95 | mesuré sur le maillage |
| Entraxe des chevilles | 95 mm | libre — la 2ᵉ est à poser |
| Fente de tige | 4,2 mm | `vis_d + jeu_vis` |
| Matière autour de la fente | 10 mm de chaque côté | `dos_plein − fente/2` |
| Profondeur, zone profonde | 91 mm | tabac, lunettes, stylos |
| Profondeur, zone peu profonde | 45 mm | câbles, briquets |
| Passage libre sous le crochet | 32 mm | `marche − croc_z − croc_e` |
| Jeu insert / coque | 0,5 mm par côté | `insert_jeu` |

## 4. Montage ou usage

1. **Percer la seconde cheville.** Poser le gabarit sur la cheville existante, le
   mettre de niveau, pointer par le petit trou. Les deux chevilles doivent être à
   la **même hauteur** : c'est ce qui empêche le panier de vriller quand on le
   charge de travers.
2. **Présenter la coque au-dessus des vis**, les deux têtes en face des canaux.
3. **La descendre.** Les fûts montent dans leur canal, les tiges dans leur fente,
   les têtes dans leur logement. Elle vient en butée toute seule.
4. **Poser les deux inserts**, chacun dans sa zone. Rien à fixer.

Pour décrocher : soulever, tirer vers soi. Rien à dévisser.

## 5. Impression

**La coque se pose sur son dos, plaque arrière contre le plateau.** C'est
l'orientation qui la rend imprimable d'un seul bloc, et c'est aussi elle qui rend
la silhouette gratuite : tout ce qui pointe vers l'avant à l'usage — le fond du
bac, le bras du crochet — devient vertical.

**Les inserts se posent à plat**, fond contre le plateau, séparations debout.

- **Aucun support, sur aucune pièce.**
- Le plus grand pontage est la peau avant du dos au-dessus d'une cavité
  d'allègement : **38 mm**, le pas de la grille. La peau fait 6 couches, seule la
  première ponte.
- PLA. Le bras du crochet travaille en traction entre couches, la direction faible :
  250 g de casque à 60 mm de porte-à-faux donnent **0,29 MPa** sur une section de
  30 × 10 mm, contre ~20 MPa de cohésion inter-couches. Facteur 70.
- Emprise plateau : 135 × 133 mm pour la coque.

## 6. Contraintes à connaître avant de modifier

- **Le galbe DOIT démarrer à l'aplomb de `x_tab`**, la frontière entre les deux
  zones. Plus à gauche, il passe sous un compartiment profond et en crève le fond.
  C'est `galbe`, son emprise horizontale, qui est bornée par là.
- **`r_galbe` doit rester petit.** L'arrondi d'un angle rentrant se fait par un
  `offset(+r)` suivi d'un `offset(−r)` : la forme est **dilatée de r avant d'être
  contractée**. Le creux du galbe se rétrécit vers le haut ; à r = 25 la dilatation
  le rebouchait et le galbe ne montait plus qu'à 23 mm au lieu de 46 — sans la
  moindre erreur. Même piège que l'`offset` qui vide une bride en silence, pris par
  l'autre bout.
- **La largeur du crochet est un paramètre de forme autant que de fonction.** À
  40 mm il occupait 40 des 47 mm du creux laissé par le galbe, et la silhouette se
  refermait en boîte. À 30, calé à droite, il laisse de l'air visible.
- **`bac_h` est fixé par une contrainte de hauteur, pas de volume.** Le réduire fait
  ressortir les lunettes d'autant au-dessus de l'axe des colonnettes, où la limite
  est de 35 mm. On est à 34.
- **`porteur` ≤ `vis_l`.** La plaque porteuse se glisse entre le fût et la tête :
  plus épaisse que la tige libre, elle ne rentre pas.
- **Tous les compartiments doivent avoir le même congé.** L'insert se calcule comme
  *l'intérieur de sa zone moins les compartiments* : un compartiment plus arrondi
  que le pourtour laisse dans le coin un **fragment de matière détaché**, qui
  sortirait de l'imprimante en morceau libre.
- **Un compartiment doit tenir entièrement dans une zone.** À cheval sur les deux,
  il n'appartient à aucun insert et disparaît.
- **`croc_r_z` < `croc_r_y` impérativement.** À l'impression, la rampe de retenue
  du crochet est un porte-à-faux dont l'angle depuis la verticale vaut
  `atan(croc_r_z / croc_r_y)`. À 12/16 on est à 37°, sous la limite de 45°.
- **`dos_bord` est distinct de `dos_nerv`, et c'est voulu.** En les confondant, une
  version antérieure ne laissait que 1,5 mm de matière sur tout le pourtour du dos.
- **`dos_plein` ne doit pas avaler la grille.** À 22 mm, les colonnes pleines
  recouvraient la moitié des poches et ne laissaient que des fentes de 2 à 3 mm.
  12 mm suffisent.

## 7. Points de vérification

- [ ] **Le galbe reste un détail de coin, et ne peut pas être autre chose à ces
      proportions.** La zone profonde fait 85 mm sur 135 parce que la poche à tabac
      debout en fait 85 ; il ne reste que 47 mm à la zone peu profonde. Une forme
      qui plonge d'un côté et remonte de l'autre demande deux côtés comparables.
      Voir la note en fin de fichier.
- [ ] Vérifier que le casque passe : 32 mm entre le bras et le dessous de la coque,
      à confronter à l'arceau réel.
- [ ] Le jeu de 0,5 mm au pourtour des inserts n'a pas été validé à l'impression.
- [ ] Les lunettes debout dans une fente de 50 × 37,6 sur 91 mm de profondeur :
      tenue à vérifier en vrai.
- [ ] La poche à tabac debout dans une fente de 85 × 30 : une blague souple tient-elle
      droite, ou s'affaisse-t-elle ? C'est elle qui commande toute la largeur.

## Note — pour aller plus loin sur la forme

Trois façons d'obtenir un galbe qui domine la silhouette au lieu de l'orner :

1. **Élargir la pièce à ~175 mm** : 85 de zone profonde et 85 de zone peu profonde,
   deux côtés comparables. Coût : environ +60 g et 40 mm de mur en plus.
2. **Descendre la poche à tabac dans la zone peu profonde.** La zone profonde n'a
   plus à loger que les lunettes, 50 mm, et le galbe court sur 80. Coût : la poche
   dépasse de 55 mm au lieu de 9, et une blague souple à moitié sortie s'affaisse.
3. **Ne rien changer** et assumer le galbe comme un détail de coin, ce qu'il est
   aujourd'hui.
