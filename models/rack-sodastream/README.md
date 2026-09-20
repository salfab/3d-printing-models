# rack-sodastream

Rack à visser sous une planche en bois pour ranger deux cylindres de CO2 SodaStream
à l'horizontale, invisibles depuis le dessus.

Les cylindres traversent deux plaques percées d'**alésages fermés à 360°** : tenue sur
tout le pourtour, aucun roulement possible. Un rail de guidage relie les deux plaques
pour que le nez du cylindre trouve tout seul le second alésage.

## Cylindre visé

Recharge universelle 425 g / 60 L, filetage TR21×4 : **Ø 60 mm × 356 mm**, 0,72 kg à
vide, ~1,15 kg plein.

**Le Ø 60 est mesuré au pied à coulisse**, pas relevé sur une fiche produit — les fiches
se contredisent d'un vendeur à l'autre. La longueur de 356 mm, elle, vient encore d'une
fiche, mais elle ne conditionne aucune cote des pièces imprimées : seulement la
visualisation du montage et le débord du cylindre devant la plaque avant.

Pour un cylindre SodaStream d'origine (plus court et plus gros), changer
`cyl_diametre` et `cyl_longueur` en tête du `.scad` — alésage, entraxe, largeur des
plaques et rail suivent.

## Pièces à imprimer

| Pièce | `PIECE=` | Quantité |
|---|---|---|
| Plaque avant (ouverte) | `avant` | 1 |
| Plaque arrière (fond de butée) | `arriere` | 1 |
| Rail de guidage | `guide` | 2 |

```bash
python scripts/scad.py stl rack-sodastream -D PIECE=avant
```

```bash
python scripts/scad.py stl rack-sodastream -D PIECE=arriere
```

```bash
python scripts/scad.py stl rack-sodastream -D PIECE=guide
```

## Cotes principales

| | |
|---|---|
| Alésage | Ø 63 mm (Ø 60 + 1,5 mm de jeu au rayon) |
| Paroi du collier | 3 mm |
| Profondeur de la plaque | 40 mm, bride et colliers confondus |
| Entraxe des cylindres | 66 mm — les cercles extérieurs se recoupent, âme partagée de 3 mm |
| Encombrement d'une plaque | 167 × 40 mm |
| Hauteur sous la planche | 72,5 mm |
| Écart entre les deux plaques | 200 mm (`ecart_plaques`) |
| Rail de guidage | 236 mm, 20 mm en fond, 15 mm au débouché, 4,77 mm d'épaisseur |

Bride et colliers ont la même profondeur : la plaque est **une seule extrusion
prismatique**, ce qui donne du volume aux colliers et raidit l'ensemble.

## Perçage de la planche

**Quatre vis par plaque, M4 à tête fraisée**, dans les oreilles latérales. C'est le seul
endroit possible : partout ailleurs la tête serait noyée dans la matière des colliers.
Coordonnées en mm, origine au centre de la plaque, X en largeur et Y le long des
cylindres :

```
(-75,5 ; -14)   (+75,5 ; -14)
(-75,5 ; +14)   (+75,5 ; +14)
```

| | mesuré sur le maillage |
|---|---|
| Trou de passage | Ø 5,000 mm nominal, **4,991 mm** au polygone inscrit |
| Fraisage | Ø 8,000 mm, cône à **90,0°**, profondeur **1,50 mm** |
| Matière restante sous le fraisage | 4,5 mm sur les 6 mm de bride |

Une tête fraisée M4 fait 7,5 mm au maximum (DIN 965), pour 2,2 mm de hauteur. Le
fraisage de 8 mm est donc plus large qu'elle : la tête s'enfonce de 0,25 mm sous la
surface au lieu de dépasser. Et le passage de 5 mm laisse 1 mm de flottement au
diamètre sur la tige de Ø 4.

**Visserie retenue : vis à bois Ø 4 à tête fraisée**, vissées directement dans la
planche. Avant-trou Ø 2,5 mm. Le trou de passage de 5 mm et le fraisage de 8 mm leur
conviennent tels quels — ils ont été cotés pour une tête fraisée M4, dont le Ø 7,5 mm
est celui d'une tête de vis à bois Ø 4.

Longueur : l'épaisseur de la bride est de 6 mm, dont 1,5 consommés par le fraisage. Une
vis de 25 mm laisse donc ~20 mm d'ancrage dans le bois.

Les deux plaques sont espacées de 200 mm centre à centre.

Quatre vis sur 151 mm d'entraxe tiennent mieux au basculement que six vis resserrées,
et la charge totale reste de 2,3 kg pour huit vis.

## Le rail de guidage est en queue d'aronde

L'encoche s'évase vers le bas : **20 mm en fond, 15 mm au débouché dans l'alésage**. Le
rail, copie du profil réduite de 0,25 mm, y est donc captif en hauteur comme
latéralement — pour s'échapper vers l'alésage il devrait franchir une ouverture de 15 mm
en étant large de 19. Il ne peut que coulisser axialement, ce que la butée arrière et le
crochet avant bloquent.

Un simple logement ouvert ne tiendrait pas : rien n'empêcherait le rail de se soulever et
de taper contre le cylindre. Un tunnel entièrement fermé aurait tenu le rail, mais
l'aurait séparé de l'alésage par de la matière, et son dessus n'aurait plus prolongé la
surface de guidage.

Dans l'orientation d'impression, les flancs de l'aronde sont verticaux des deux côtés :
aucun porte-à-faux, ni sur la plaque ni sur le rail.

**Jeu de montage : 0,3 mm perpendiculaire**, mesuré sur le maillage — section pleine de
19,06 mm dans une encoche de 20,00, fond du rail à 0,30 mm du fond de l'encoche. Le bout
porte un **chanfrein d'engagement de 1,5 mm** qui l'amincit jusqu'à 14,37 mm.

Ce jeu serré suppose l'ordre de montage ci-dessous. Il tient parce que le rail aligne
lui-même les deux plaques *avant* qu'elles ne soient vissées.

**Le rail est aussi raccourci de 1 mm** (`guide_jeu_axe`). Sans ce retrait il ferait
exactement les 237 mm disponibles entre le fond de butée et la face avant, et les seules
tolérances d'impression suffiraient à l'empêcher d'entrer.

**Le talon d'arrêt** est une collerette large de 26 mm, **reculée de 40 mm** depuis le
bout avant — soit exactement la profondeur d'une plaque. Plus large que l'encoche, qui
n'en fait que 20, elle ne peut pas la traverser : elle porte contre la face *arrière* de
la plaque avant, sur environ 4 mm de chaque côté. C'est l'**avancée** du rail qu'elle
arrête, la seule direction par laquelle il pourrait sortir ; le recul est déjà pris par
la butée du fond.

Elle s'évase **latéralement**, à partir du même fond plat que le rail, et ne descend pas
en dessous. Un talon qui descendrait aurait obligé à imprimer les 236 mm du rail sur
support.

Un talon placé au bout du rail, en appui sur la face *avant*, n'aurait rien bloqué
d'utile : il n'aurait arrêté que le recul, déjà limité à 1 mm par la butée, en laissant
le rail libre de coulisser vers l'avant et de tomber.

Conséquence sur le montage : le talon ne peut pas franchir l'encoche, donc **le rail
s'introduit par l'arrière**, avant la pose de la plaque du fond. En contrepartie, rien
ne dépasse de l'encombrement du rack.

Le jeu ne peut pas faire dépasser le rail dans l'alésage : comme il est uniforme, le
rail qui remonte au maximum arrive exactement affleurant, jamais au-delà — les lèvres
l'arrêtent là.

## Montage

L'ordre compte : **assembler d'abord, percer ensuite.**

1. Enfiler les deux rails dans la plaque avant **par l'arrière**, jusqu'à ce que leur
   talon vienne buter sur la face arrière de la plaque ; le bout du rail affleure alors
   la face avant. Engager ensuite la plaque du fond sur l'autre extrémité des rails.
   Le rack tient alors tout seul, et les rails imposent l'alignement des deux plaques.
2. Présenter le rack assemblé sous la planche, butée côté fond, et **marquer les huit
   avant-trous à travers les oreilles**. Ne pas percer d'après un gabarit théorique.
3. Démonter, percer les avant-trous Ø 3 mm, visser les deux plaques, puis remonter les
   rails — plaque du fond en dernier.
4. Engager les cylindres. Ils butent contre le fond de la plaque arrière et dépassent
   d'environ 116 mm devant la plaque avant — de quoi les saisir.

**Pourquoi marquer plutôt que mesurer.** Les vis sont à tête fraisée : le cône à 90° se
centre dans son fraisage en se serrant et annule les 0,25 mm de flottement des trous de
passage. Ce sont donc les avant-trous, et non le rail, qui fixent la position des
plaques. Percés d'après un gabarit, ils désaligneraient les deux arondes et le rail
coincerait. Marqués à travers le rack monté, ils sont justes par construction.

## Impression

- **Plaques** : posées à plat, alésages verticaux. Aucun support. Les couches sont alors
  perpendiculaires à l'axe des cylindres, donc la charge ne travaille pas en pelage.
- **Plaque arrière** : butée côté plateau, pour éviter un pontage sur Ø 63.
- **Rails** : posés sur leur fond plat, creux vers le haut. Aucun support : toute la
  face inférieure touche le plateau, talon compris, et rien ne dépasse par en dessous.
- PLA ou PETG, 3 périmètres, 25 % de remplissage. La paroi de 3 mm est entièrement
  remplie par les périmètres.

## Contraintes à connaître avant de modifier

- **`ecart_plaques` ne peut pas dépasser ~213 mm** sur un plateau de 256 mm : la longueur
  du rail vaut `ecart_plaques + 40 − 3`, et au-delà il faudrait l'imprimer en diagonale
  ou le couper en deux.
- **`coin` ne peut pas dépasser `bride_ep / 2`**, sinon le carré de base de la bride
  devient de hauteur négative et la bride disparaît sans erreur. Le modèle borne
  désormais la valeur, mais la contrainte reste réelle.
- **Le chanfrein d'entrée des alésages ne peut pas dépasser `paroi − 1`** : au-delà, le
  cône de chanfrein mange toute l'épaisseur du collier à la face d'entrée.
- Le chanfrein des arêtes d'extrémité est un empilement de marches, faute d'opérateur de
  chanfrein 3D en OpenSCAD standard sur un profil aussi concave. Réglé à 0,2 mm par
  marche, soit une couche d'impression : le trancheur produit le même résultat qu'avec un
  vrai chanfrein à 45°.

## Points de vérification

- Le Ø du cylindre est **confirmé à 60 mm au pied à coulisse**. Le jeu de 1,5 mm au rayon
  donne donc 2,978 mm de battement diamétral réel — mesuré sur le maillage, polygonisation
  comprise. Franc à glisser ; pour un maintien plus serré, passer `jeu_radial` à 0,75.
- Le rail affleure 0,3 mm sous la surface de l'alésage : il ne serre jamais le cylindre,
  il ne fait que rattraper le nez quand il pique.
- Si le rail coulisse trop dur une fois les plaques vissées, c'est le perçage qui est en
  cause avant le modèle. Avant d'augmenter `guide_jeu`, vérifie qu'il coulisse bien sur
  les plaques libres : si oui, ce sont les avant-trous qui tirent les plaques de travers.
