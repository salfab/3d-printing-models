# vide-poches

Panier mural qui s'enfile par le haut sur deux chevilles d'assemblage de meuble,
en les gardant invisibles, avec crochet à casque intégré et bac à séparations
amovible.

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

**Géométrie de la cheville.** Douille plastique sertie dans le bois, fût de **Ø 7,3**
qui dépasse de la surface, puis **tige lisse de Ø 3,4**, puis tête bombée.

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

**Le rangement debout commande toute la géométrie.** Deux objets encombrants sont
rangés sur leur petit côté plutôt qu'à plat : les lunettes pliées passent de
150 × 46 au sol à 50 × 37, la poche à tabac de 105 × 30 à 85 × 30. C'est ce qui a
fait tomber la pièce de 200 mm de large à 135.

En échange ils dépassent du bord, et cela impose la contrainte inverse : **le haut
des lunettes doit rester à moins de 35 mm au-dessus de l'axe des colonnettes.**
Debout, elles font 145 mm et posent sur le fond de l'insert. D'où

```
dépassement = 145 − (bac_h − fond − insert_fond) − garde_vis
            = 145 − 91 − 20 = 34 mm
```

C'est cette inégalité, et non un besoin de volume, qui fixe `bac_h` à 95.

| Objet | Rangé | Empreinte | Dépasse du bord |
|---|---|---|---|
| Lunettes pliées | debout | 50 × 37,6 | 54 mm |
| Poche à tabac | debout | 85 × 30 | 9 mm |
| Câbles USB | en vrac | 42,8 × 42 | — |
| Briquets | en vrac | 42,8 × 25,6 | — |
| Petites bricoles | en vrac | 32,6 × 37,6 | — |
| Casque WH-1000XM5 | pendu au crochet | — | — |

Le XM5 **ne se plie pas**, contrairement au XM4 : il faut une portée large sous
l'arceau, pas une patte fine.

## 2. Pièces à imprimer

| Pièce | `PIECE=` | Qté | Rôle |
|---|---|---|---|
| Coque | `coque` | 1 | dos, bac nu, crochet |
| Insert | `insert` | 1 | le bac à séparations, amovible |
| Gabarit | `gabarit` | 1 | réglet de perçage de la seconde cheville — consommable |

```bash
python scripts/scad.py stl vide-poches -D PIECE=coque   --binaire
python scripts/scad.py stl vide-poches -D PIECE=insert  --binaire
python scripts/scad.py stl vide-poches -D PIECE=gabarit --binaire
```

**L'insert porte son propre fond**, et c'est délibéré même si cela empile deux
fonds. Une version antérieure n'était qu'un peigne de cloisons sans fond, pour
économiser 29 g : elle ne touchait le plateau que par la tranche de ses parois,
**7 cm² pour toute la pièce**. Avec son fond, l'insert colle sur **89 cm²**, tient
tout seul, et se sort plein.

Le fond de la coque n'est pas supprimé pour compenser : c'est lui qui relie la
paroi avant au dos, le raidisseur de la coque.

Coque et insert se déduisent tous deux de la **même liste `cuves`** : un
compartiment ajouté ou déplacé met les deux pièces à jour, elles ne peuvent pas
diverger. Changer d'agencement ne coûte que **116 g** de réimpression, et la coque
reste utilisable en plateau nu.

`PIECE=panier` montre l'ensemble monté ; `dos`, `bac`, `crochet` isolent un
sous-ensemble pour l'inspecter ou le mesurer. Aucun de ces quatre ne s'imprime.

## 3. Cotes principales

Mesurées sur les maillages exportés.

| | Volume | PLA | Encombrement |
|---|---|---|---|
| Coque | 292,6 cm³ | 363 g | 135 × 98,5 × 173 mm |
| Insert | 93,6 cm³ | 116 g | 129,2 × 69,0 × 92,6 mm |
| **Total** | **386,2 cm³** | **479 g** | |

> Ces 479 g sont le **volume géométrique**, pas le fil consommé. Les zones épaisses
> — bras du crochet (10 mm), âme (14), colonnes du dos (24 × 26) — seront remplies
> par le trancheur, pas massives. Compter plutôt **380 à 410 g** réellement.

| Cote | Valeur | Origine |
|---|---|---|
| Épaisseur du dos | 26,1 mm | `col_h + porteur + loge_e + dos_av` |
| Empilage du dos (plans Y) | 0 / 1,60 / 5,20 / 18,70 / 23,70 / 26,10 | mesuré sur le maillage |
| Plaque porteuse | 13,5 mm | `vis_l − 0,5` : toute la tige libre |
| Dégagement devant la tête | 0,5 mm | plaque à 18,70, dessous de tête à 19,20 |
| Entraxe des chevilles | 95 mm | libre — la 2ᵉ est à poser |
| Fente de tige | 4,2 mm | `vis_d + jeu_vis` |
| Matière autour de la fente | 10 mm de chaque côté | `dos_plein − fente/2` |
| Course d'enfilage | 115 mm | du bas du dos au siège |
| Profondeur des compartiments profonds | 91 mm | tabac, lunettes |
| Profondeur des compartiments relevés | 45 et 40 mm | bricoles et câbles, briquets |
| Jeu insert / coque | 0,5 mm par côté | `insert_jeu` |
| Contact plateau de l'insert | 89,0 cm² | mesuré sur le maillage |

## 4. Montage ou usage

1. **Percer la seconde cheville.** Poser le gabarit sur la cheville existante, le
   mettre de niveau, pointer par le petit trou. Les deux chevilles doivent être à
   la **même hauteur** : c'est ce qui empêche le panier de vriller quand on le
   charge de travers.
2. **Présenter la coque au-dessus des vis**, les deux têtes en face des canaux.
3. **La descendre** de 115 mm. Les fûts montent dans leur canal, les tiges dans
   leur fente, les têtes dans leur logement. Elle vient en butée toute seule.
4. **Poser l'insert** dans le bac. Il tombe en place, rien à fixer.

Pour décrocher : soulever de 115 mm, tirer vers soi. Rien à dévisser.

L'insert se reprend en pinçant le séparateur central, qui court sur toute la
profondeur. Son rebord de 8 mm retient le contenu pendant le transfert.

## 5. Impression

**La coque se pose sur son dos, plaque arrière contre le plateau.** C'est
l'orientation qui la rend imprimable d'un seul bloc : tout ce qui pointe vers
l'avant à l'usage — le fond du bac, le bras du crochet — devient vertical.

**L'insert se pose à plat**, fond contre le plateau, séparateurs debout. 89 cm² de
contact : ni brim ni précaution.

- **Aucun support, sur aucune des deux pièces.** Les fonds relevés des petits
  compartiments sont horizontaux dans cette orientation, mais chacun repose sur
  un rebord qui monte jusqu'à lui : ce sont des plateaux appuyés sur tout leur
  pourtour, pas des pontages en porte-à-faux.
- Le plus grand pontage est la peau avant du dos au-dessus d'une cavité
  d'allègement : **42 mm**, le pas de la grille. La peau fait 6 couches, seule la
  première ponte.
- PLA. Le bras du crochet travaille en traction entre couches, la direction faible :
  250 g de casque à 60 mm de porte-à-faux donnent **0,22 MPa** sur une section de
  40 × 10 mm, contre ~20 MPa de cohésion inter-couches. Facteur 90.
- Emprise plateau : 135 × 173 mm pour la coque.

## 6. Contraintes à connaître avant de modifier

- **`bac_h` est fixé par une contrainte de hauteur, pas de volume.** Le réduire fait
  ressortir les lunettes d'autant au-dessus de l'axe des colonnettes, où la limite
  est de 35 mm. On est à 34.
- **`porteur` ≤ `vis_l`.** La plaque porteuse se glisse entre le fût et la tête :
  plus épaisse que la tige libre, elle ne rentre pas. Le modèle la fixe à
  `vis_l − 0,5`, au maximum utile — la tête bute alors directement contre elle.
- **Tous les compartiments doivent avoir le même congé.** L'insert se calcule comme
  *l'intérieur moins les compartiments* : un compartiment plus arrondi que le
  pourtour laisse dans le coin un **fragment de matière détaché**, qui sortirait de
  l'imprimante en morceau libre. C'est ce qui a fait renoncer au puits à câbles
  rond (r = 18 contre r = 4).
- **Tout compartiment ajouté doit toucher au moins un autre séparateur**, sinon il
  détache un morceau de l'insert. À vérifier sur le maillage, pas à l'œil.
- **Un fond relevé impose un rebord relevé en face.** Les compartiments
  extérieurs sont fermés par les parois de la COQUE, pas par l'insert : côté
  extérieur, leur fond relevé ne reposerait sur rien et s'affaisserait à
  l'impression. Le modèle relève le rebord au droit de chacun — uniquement là,
  car le relever sur tout le pourtour coûte 40 g contre 22.
- **Le rebord de l'insert n'est pas décoratif.** Sans lui, le bord libre d'un fond
  plat de 129 × 69 en 1,6 mm de PLA gondole à l'impression, et le contenu des
  compartiments extérieurs — fermés par les parois de la coque, pas par l'insert —
  glisse dès qu'on soulève celui-ci.
- **`dos_bord` est distinct de `dos_nerv`, et c'est voulu.** En les confondant, une
  version antérieure ne laissait que 1,5 mm de matière sur tout le pourtour du dos.
- **`dos_plein` ne doit pas avaler la grille.** À 22 mm, les colonnes pleines
  recouvraient la moitié des poches et ne laissaient que des fentes de 2 à 3 mm :
  du vide qui n'allège rien et qui affaiblit. 12 mm suffisent.
- **Les colonnes pleines n'existent que dans le bandeau**, au-dessus du bac. C'est
  la seule hauteur où la vis porte ; plus bas, le canal n'est qu'un couloir libre
  entre les nervures.
- **`croc_r_z` < `croc_r_y` impérativement.** À l'impression, la rampe de retenue
  du crochet est un porte-à-faux dont l'angle depuis la verticale vaut
  `atan(croc_r_z / croc_r_y)`. À 14/16 on est à 41°, sous la limite de 45° ;
  au-delà il faut des supports et l'orientation « un seul bloc » s'écroule.
- **L'`offset(r) offset(−r)` qui adoucit le profil du crochet rogne sa pointe.**
  À r = 2 la rampe perdait 2,4 mm de hauteur sans que rien ne le signale.

## 7. Points de vérification

- [ ] **479 g géométriques.** Le dos pèse à lui seul 45 % du total, et l'essentiel
      est dans ses deux peaux — irréductibles tant qu'on veut un caisson fermé, qui
      est précisément ce qui cache les têtes de vis.
- [ ] Vérifier que le casque passe : `croc_jour` = 30 mm entre le bras et le
      dessous du bac, à confronter à l'arceau réel.
- [ ] Le jeu de 0,5 mm au pourtour de l'insert n'a pas été validé à l'impression.
      Un insert trop serré ne rentre pas ; trop lâche, il cliquette.
- [ ] Les lunettes debout dans une fente de 50 × 37,6 sur 91 mm de profondeur :
      tenue à vérifier en vrai. Elles ne peuvent pencher que de l'angle du jeu,
      mais c'est une prévision, pas une mesure.
