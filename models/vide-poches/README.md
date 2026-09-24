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

**La hauteur des lunettes — règle abandonnée.** Debout elles font 145 mm, et la
règle de départ voulait leur sommet à moins de 35 mm au-dessus de l'axe des
colonnettes. C'est elle qui a fixé `bac_h` à 95.

Elle a été **levée par choix**, pour cacher la fixation dans le bac (voir §7). Les
vis étant fixes sur le meuble, descendre les trous de serrure dans la pièce fait
monter toute la pièce d'autant : **37 mm**. Les lunettes dépassent désormais l'axe
des vis de **71 mm** au lieu de 34. Le haut de la pièce, lui, n'est qu'à 17 mm
au-dessus des vis : la casquette, qui montait à 50, a été retirée. `bac_h` est resté
à 95 pour garder les proportions.

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
| Inserts | `insert` | 1 jeu | deux petits bacs à séparations, un par zone — **deux corps**, et le liseré du bord |
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

**Deux couleurs de PLA.** Les inserts portent le liseré qui borde l'ouverture : les
imprimer dans une autre couleur que la coque dessine un filet tout autour du bord,
plus les séparations. C'est prévu pour.

**Le dos est plein, sans grille d'allègement** — c'est le remplissage du trancheur
qui s'en charge, mieux et sans les pièges qui allaient avec.

## 4. Cotes principales

Mesurées sur les maillages exportés.

| | Volume | Encombrement |
|---|---|---|
| Coque | 283,2 cm³ | 182,0 × 85,8 × 95,0 mm |
| Inserts (2 corps) | 116,7 cm³ (75,3 + 41,4) | 176,2 × 80,4 × 92,1 mm |
| **Total** | **399,9 cm³** | |

Exportés avec le moteur **Manifold** ; un export `--cgal` rend le même volume au
dixième de cm³.

> Volume **géométrique**, pas le fil consommé. Les parois font 2,4 mm et sortent
> pleines ; le socle du côté peu profond, lui, est un bloc massif que le trancheur
> remplit au taux qu'on lui donne.

| Cote | Valeur | Origine |
|---|---|---|
| Épaisseur du dos, hors fixation | 2,0 mm | `dos_ep` |
| Épaisseur au droit des vis | 7,6 mm | `col_h + porteur + loge_e + dos_av` |
| Plaque porteuse | 2,0 mm | `vis_l − 0,5` — la tige ne dépasse que de 2,5 |
| Course d'enfilage | 14 mm | `course` |
| Axe des vis | z = 78, **17 mm sous l'arase** | déduit de l'arase : renflement + `arase_marge` |
| Entraxe des chevilles | 124 mm | 16,6 mm entre noyau et flanc, pour que le renflement s'y éteigne |
| Fente de tige | 4,2 mm | `vis_d + jeu_vis` |
| Trou de passage de la tête | 9,5 mm | `tete_d + jeu_entree` |
| Logement de tête | 11,0 mm | `tete_d + jeu_tete` |
| Profondeur, zone profonde | 92,2 mm | `bac_h − fond_bas` |
| Profondeur, zone peu profonde | 46,2 mm | `bac_h − fond_haut` |
| Marche entre les deux niveaux | 46 mm sur 45 de galbe | `marche`, `galbe` |
| Galbe de la jointure avant | 8 mm | `r_av_bac` — borné par l'arase, voir §7 |
| Angles hauts du bac | 8 mm | `r_coin_bac` = `r_av_bac` : à 6, l'angle devenait vif sur la face avant |
| Arase, paroi pleine jusqu'à | z = 88 | puis extinction sur 4 mm |
| Paroi / cloison / fond | 2,4 / 2,4 / **2,8** mm | `fond` ≠ `paroi` : voir §7 |
| Jeu insert / coque | 0,5 mm par côté | `insert_jeu` — c'est aussi le filet qui sépare les deux couleurs |
| Paroi d'insert | 1,2 mm, pleine hauteur | `insert_paroi` — 3 périmètres ; elle porte le liseré |
| Bandeau arrière | de 2,5 à 9,3 mm du mur, 2 mm d'épaisseur au bord | `cadre_h`, encorbellement à 45° |
| Largeur hors tout | 182 mm | `larg` passé de 175 à 182 : 4 × 1,7 de parois d'insert, les compartiments gardent leur largeur |
| Portée du crochet | 84 mm | `croc_l` — pointe à 0,9 de la face avant |
| Raccord crochet / panier | congé 8 mm, 6,1 côté flanc | `croc_raccord`, `croc_raccord_ext` |
| Profondeur hors tout | 85,8 mm | `bac_int` = 81,4 : l'insert prend 9,3 au fond et 1,7 devant |
| Largeur du crochet | 34 mm | `croc_larg`, mesurée le long de l'ARC du casque |
| **Vallée de l'arceau** | **42 mm** | `croc_vallee` — la cote qui compte, voir ci-dessous |
| Passage libre sous la coque | 28 mm | `marche − croc_creux` |
| Bras au plus fin | 10 mm | `croc_creux − croc_z − croc_relev` |
| Nez du crochet | demi-rond Ø 20 | `croc_nez`, déduit du profil |
| Galbe latéral du crochet | 4 mm | `croc_rb` |

### Le crochet et le Sony WH-1000XM5

Une seule cote du crochet dépend vraiment du casque, et ce n'est pas celle qu'on
croit. **Le bras enfourche l'arceau** : `croc_larg` se mesure donc le long de l'arc
du casque — c'est la longueur sur laquelle le poids se répartit, 34 mm, assez pour
ne pas marquer la mousse. La **sangle**, elle, se couche selon Y, et c'est la
longueur de la vallée qui décide si le casque s'assoit ou se perche.

Assise mesurée sur le maillage exporté, en posant une sangle plate sur le profil :

| Largeur de sangle | S'assoit à | Au-dessus du fond de gorge | Butée restante devant |
|---|---|---|---|
| 30 mm | z 18,8 | 0,8 mm | 9,2 mm |
| 34 mm | z 20,2 | 2,2 mm | 7,8 mm |
| 38 mm | z 22,1 | 4,1 mm | 5,9 mm |
| 42 mm | — | ne s'assoit pas | — |

Le XM5 pèse **250 g** (spécification Sony) et **ne se plie pas** — il ne fait que
pivoter à plat, donc on le pend tel quel. Sa sangle fait de l'ordre de 38 mm ; c'est
la seule cote que Sony ne publie pas, et elle mérite un coup de réglet avant
impression. Le crochet accepte jusqu'à ~40 mm.

À `croc_l` = 70, la vallée ne faisait que 26 mm : une sangle de 38 mm reposait sur
les deux épaules, 11 mm au-dessus du fond, et la butée ne retenait plus rien. C'est
pour ça que la portée est passée à 82 — qui aligne au passage la pointe sur la face
avant du panier, à 82,4.

Contrôles topologiques sur le maillage, tous à zéro :

| Pièce | Solides | Cavités scellées | Arêtes de bord | Arêtes non-variété |
|---|---|---|---|---|
| Coque | 1 | 0 | 0 | 0 |
| Inserts | 2 | 0 | 0 | 0 |

## 5. Montage

1. **Percer la seconde cheville** au gabarit, à la **même hauteur** que
   l'existante : c'est ce qui empêche le panier de vriller quand on le charge de
   travers. Entraxe 124 mm.
2. **Présenter la coque**, les deux têtes en face des trous de passage de 9,5.
3. **Pousser contre le bois**, puis **descendre de 14 mm** (`course`). Elle vient
   en butée toute seule.
4. **Poser les deux inserts**, chacun dans sa zone. Ils descendent à la verticale ;
   le bandeau arrière passe au-dessus des renflements de fixation et vient se
   poser au ras de la plaque.

Pour décrocher : remonter de 14 mm, tirer vers soi. Rien à dévisser.

## 6. Impression

- **Aucun support, sur aucune pièce.**
- Coque sur son dos ; inserts à plat, fond contre le plateau. Le bandeau arrière
  des inserts est en porte-à-faux vers l'arrière : son encorbellement ne dépasse
  jamais 45°, y compris là où il contourne les renflements (voir §7).
- PLA. Le bras du crochet travaille en traction entre couches, la direction faible :
  250 g de casque à 60 mm de porte-à-faux donnent **0,26 MPa** sur sa section la
  plus faible, 34 × 10 mm, contre ~20 MPa de cohésion inter-couches. Facteur 77.
- Le crochet n'a **aucun porte-à-faux au-delà de 45°** : la butée est le seul
  élément qui s'écarte de la verticale à l'impression, et son S atteint au plus
  1,875·`croc_r_z`/`croc_gorge` = 0,78, soit 38°. Assertion dans le modèle.
- Emprise plateau : 182 × 95 mm pour la coque.
- Remplissage libre : aucun volume fermé dans la pièce, donc rien que le trancheur
  doive ponter à l'aveugle.

## 7. Contraintes à connaître avant de modifier

### Géométrie interne

- **Les cavités doivent être découpées dans l'enveloppe intérieure, jamais posées
  à un niveau.** Le dessous de la coque remonte vers les extrémités — coins
  arrondis, galbe — alors qu'un fond de compartiment est plat. Posées à plat, les
  cavités passaient sous la peau près des coins et **le bac débouchait par en
  dessous**, sur plusieurs millimètres, sans que rien ne le signale.
- **C'est cette même enveloppe qui débride le galbe avant.** Tant que les cavités
  étaient des prismes posés, `r_av_bac` était borné à l'épaisseur de paroi : au-delà
  l'arrondi passait derrière elles.
### Le haut du bac : deux contours qui doivent rester parallèles

Ce README a affirmé que « la coque garde son épaisseur partout ». C'était faux, et
deux fois plutôt qu'une. Les deux défauts ont la même forme — **le contour intérieur
ne suivait pas l'extérieur** — et se voyaient tous deux comme des angles en lame de
couteau en haut du panier.

- **Les angles hauts du bac.** `chemin_bac` les arrondissait de `r_ext` = 20, mais
  `chemin_int` est bâti sur `chemin_bac(z_haut + 60)` : ses angles hauts sont 60 mm
  plus haut, donc il monte tout droit à x = ±85,1 et **traversait** l'arrondi
  extérieur. Au-dessus de z = 84,5 **les côtés du panier n'existaient plus du
  tout** — la tranche à z = 86 ne contenait que la cloison. D'où `r_coin_bac`,
  découplé de `r_ext` et ramené à 6, qui est aussi le rayon des angles hauts du dos.
- **`r_coin_bac` ne doit pas descendre sous `r_av_bac`.** Ramené à 6, il avait
  réglé les angles en lame de couteau mais en créait un autre défaut : l'arrondi
  avant rétrécit le contour de 8 mm vers la face avant, et un angle de 6 y tombait
  à zéro — angle vif sur la face avant, raccord maladroit entre deux arrondis. À 8,
  les deux rayons sont égaux et l'angle devient un coin sphérique. Le haut des
  parois s'amincit alors sur les 8 derniers millimètres au lieu de 6.
- **Les deux arrondis avant doivent avoir le MÊME rayon.** L'intérieur valait
  `r_av_bac − paroi` — le réflexe pour un offset 3D, et l'erreur. Ce qui compte à
  l'impression est la distance dans le **plan du lit**, couche par couche, et elle
  ne vaut `paroi` que si les deux rayons sont égaux. À rayons différents, l'anneau
  tombait à 0,74 mm sur les 12,6 derniers millimètres de la pièce.

Mesuré au lancer de rayon, avant et après :

| z | paroi latérale, avant | après | paroi avant, avant | après |
|---|---|---|---|---|
| 80 | 1,68 mm | **2,40** | 2,40 mm | **2,40** |
| 86 | **néant** | **2,40** | 0,98 mm | **2,40** |
| 88 | néant | **2,40** | néant | **2,28** |
| 91 | néant | 1,94 | néant | 1,13 |

- **Ce qui reste, et qui est normal :** `r_av_bac` fixe la hauteur à laquelle la
  paroi avant s'éteint, `z_haut − f(r_av_bac, paroi)` avec `f(r,h) = r − √(2rh − h²)`.
  À 8 c'est z = 92,7 ; à 15 c'était 88,1. Les 4 derniers millimètres s'amincissent :
  c'est un bord supérieur arrondi, pas un défaut.

  Un bord franc jusqu'à l'arase demanderait une **lèvre roulée** — la cavité se
  retirant de `r` au droit de l'arase. Ça coûte autant de profondeur d'ouverture,
  ça se répercute sur les inserts qui doivent passer dessous, et l'intérieur de la
  lèvre devient un porte-à-faux à brider à 45°. Ce n'est pas un réglage.
- **Le socle du côté peu profond est PLEIN, et doit le rester.** Il a été creux ;
  refermé proprement, ce creux devenait une cavité scellée de 60 cm³ dont le plafond
  est la face avant. En orientation d'impression c'est un pontage de 80 × 40 mm à
  80 mm de haut, et aucun trancheur ne sait poser de support dans un volume fermé.

### Les trois pièges de coïncidence — tous vécus sur cette pièce

Chacun s'est manifesté en arêtes non-variété, et se voyait à l'écran comme un trou.

- **`fond` ne doit PAS valoir `paroi`.** Les deux niveaux de plancher valent `fond`
  et `marche + fond` ; le dessous de l'enveloppe intérieure vaut `paroi` et
  `marche + paroi`. Les faire coïncider posait le fond des compartiments exactement
  sur la peau intérieure — deux surfaces confondues sur toute leur étendue, et un
  galbe tangent à ce plan à son sommet.
- **Un prisme de creusement ne se borne pas sur la paroi qu'il longe.** Il déborde
  de `deb` = 5 mm : c'est l'enveloppe qui ferme le compartiment de ce côté. Et 5 mm,
  pas 0,2 — un petit débord remplace la face coplanaire par un éclat rasant.
- **Deux balayages concentriques affleurent à la lèvre avant.** Un arrondi
  `offset_sweep` rentre le profil de son propre rayon : à la lèvre, le bac vaut
  `chemin_bac − r_av_bac` et l'enveloppe intérieure `chemin_bac − paroi −
  (r_av_bac − paroi)`. **La même courbe.** Tout ce qui se soustrait au bac doit donc
  s'arrêter à `yi1`, jamais à `prof`. C'est ce piège qui perçait le galbe.

### Les renflements de fixation : la plaque qui gonfle

Autour de chaque vis, le dos passe de `dos_ep` = 2,0 mm à `dos_e` = 7,6 mm. La façon
dont il y passe a changé cinq fois ; chaque étape a levé un défaut précis.

1. **Deux plaques posées sur l'arche** — des mottes, arête franche tout autour.
2. **Une lentille empilée** dont le rayon suivait `boss_etale · cos(90·i/n)` —
   tangente à sa crête, mais **verticale à sa base** : la dérivée du cosinus est
   nulle en zéro, la paroi quittait donc la plaque à 90°. Un dôme posé sur une plaque.
3. **Un S quintique** : surépaisseur `(dos_e − dos_ep) · liss5(1 − ρ/boss_etale)`,
   tangente à la plaque ET au plateau. Plus d'angle à la jonction.
4. **Un champ de hauteur qui s'éteint avant chaque bord.** Même en S, il restait
   trois arêtes — sur le flanc, sous la casquette, et à l'arase où la cavité le
   tranchait à plat. Il s'éteint désormais de lui-même avant chaque limite :

   ```
   face avant = plaque + surépaisseur × S(ρ) × W(flanc) × W(bord haut)
   ```

   où chaque facteur est un `liss5` — un produit de fonctions lisses est lisse.
5. **Plus bas, plus larges, vis rapprochées.** La surépaisseur tombe de 7,4 à
   **5,6 mm** (jeu devant la tête 2 → 1 mm, peau 2,4 → 1,6), et l'entraxe passe de 140
   à **124**.
6. **Dans le bac.** Posé sur la plaque au-dessus de l'arase, il se voyait toujours,
   quelle que soit sa forme — les cinq versions précédentes l'ont montré. Il vit
   désormais **sous l'arase**, sur la paroi arrière des compartiments, où les objets
   le cachent. La casquette, devenue inutile, a été retirée. L'axe des vis descend de
   z = 115 à z = 78.

Il reste construit pour ne rencontrer aucune limite en étant encore épais : il
s'éteint, tangent, avant la paroi latérale du bac, avant l'arase et avant le bas.

```
face avant = plaque + surépaisseur × S(ρ) × W(paroi) × W(arase) × W(bas)
```

Profils mesurés sur le maillage, pente nulle aux deux bouts à chaque fois :

| vers | de → à | pente max |
|---|---|---|
| l'intérieur (z = 72) | 7,60 → 2,00 mm | 0,87 |
| la paroi latérale du bac | 7,60 → 2,00 mm | 1,11 |
| l'arase, au-dessus | 7,60 → 2,00 mm | 1,87 |
| le bas | 7,60 → 2,00 mm | 2,09 |

Les pentes sont plus raides qu'au-dessus de l'arase, et c'est voulu : dans le bac,
tout ce que le renflement étale est pris sur les compartiments. `boss_etale` est
revenu à 12.

Ce qu'il faut savoir avant d'y toucher :

- **Il n'est pas retranché par la cavité** : `coque()` l'ajoute APRÈS le
  creusement. Retranché avec le reste, il disparaîtrait — il est tout entier dans
  le volume des compartiments.
- **L'insert les cache : c'est un petit bac.** Son corps passe DEVANT les
  renflements, à `dos_e` + jeu = 8,1 mm du mur, et ses compartiments arrière
  commencent une paroi plus loin (`yi0_ins` = 9,3). La fente de 6 mm qui restait
  entre la plaque et l'insert est fermée par le **bandeau arrière** (ci-dessous).
- **Ça coûte 9,3 mm au fond de chaque compartiment arrière**, rendus par
  `bac_int` = 81,4 : la fente à lunettes garde 40 mm pour des lunettes de 37,6.
- **Sa hauteur est bornée des deux côtés.** Par l'arase au-dessus — sinon il
  dépasse du bord (assertion) — et par le fond du côté peu profond
  au-dessous, pour le renflement droit (assertion). C'est pour tenir entre les deux
  que `boss_haut` est passé de 12 à 9.
- **La seule découpe restante tombe là où le renflement est éteint.** Elle suit la
  silhouette rentrée de `boss_bord` = 1,5 mm, où la surface est à 1,98 mm — sous la
  face de la plaque, dans une zone où la plaque est pleine sur toute son épaisseur.
  Elle est donc invisible. `boss_bord` doit rester supérieur à l'arrondi avant de
  la plaque (1,4), sinon cette découpe ressortirait dans l'arrondi.
- **La surface part 0,02 mm SOUS la plaque** (`boss_deb`). Partie pile dessus, elle
  y coucherait des sommets — la famille de coïncidences qui avait coûté 35 arêtes au
  crochet. Elle la traverse à 2,4°.
- **L'insert a longtemps été entaillé** d'un couloir à l'aplomb de chaque
  renflement. Deux leçons en restent. Un escalier de boîtes, une par tranche de
  profondeur, avait été soupçonné d'isoler des éclats de rebord ; c'était faux. La
  vraie cause : le renflement s'éteignant avant la paroi latérale, le couloir
  laissait au coin arrière un tronçon de rebord pris entre lui et l'arrondi d'angle
  du bac — un morceau **libre**, 11 mm³ de chaque côté, que seul le compte de
  solides a vu. Le petit bac règle la question à la racine : plus de couloir.

Un piège de mesure, au passage : un lancer de rayon qui tombe **pile sur une arête**
de la triangulation, avec un test d'appartenance strict, rate les deux triangles
voisins. Plusieurs sondes à « ,3 » annonçaient 0 mm en plein noyau. Test inclusif
et coordonnées décalées : la face était bien là.

### Le liseré : l'insert finit le bord de la coque

La coque n'a pas bougé pour lui. Son bord est arrondi de 6 mm sur les flancs et de
8 mm à l'avant, mais ses parois ne font que 2,4 : elles n'en portent que la
naissance, et l'arrondi s'arrête net sur leur face intérieure, à 1,2 mm sous le
bord sur les flancs et à 2,3 mm à l'avant.

L'insert en prend la suite. Ses parois de 1,2 mm montent sur toute la hauteur, et
leur dessus est rogné par **la même surface** que l'extérieur de la coque,
`bac_plein`. Mesuré sur les maillages : sur le flanc, la coque s'arrête à z = 93,8,
l'insert reprend à 94,1 et monte à 95 ; à l'avant, 92,7 puis 93,1 → 94,0. Un seul
galbe, en deux couleurs, coupé par le jeu de 0,5 mm.

- **Ne pas redonner à l'insert un dessus plat** : il dépasserait de l'arrondi de
  la coque au lieu de le prolonger.
- **Les compartiments sont creusés dans l'enveloppe rentrée de jeu + paroi**, pas
  seulement bornés par `cuves`. Là où la coque se resserre — près de l'avant, son
  intérieur suit l'arrondi de 8 mm —, une paroi d'insert simplement tracée par
  les cuves s'amincissait jusqu'à disparaître au coin.
- **Les cotes de `cuves` sont des cotes UTILES**, entre parois d'insert. D'où
  `larg` et `bac_int` qui ont grandi : garder la poche à tabac à 85 coûte 1,7 mm
  à chaque paroi que l'insert double.

### Les coins arrière : concentriques, en coque comme en insert

La cavité avait des coins arrière vifs : son prisme passait 5 mm derrière la plaque.
Ils sont arrondis de `r_arr` = 5,6 mm, le rayon qu'ont déjà ses coins avant (8 mm
d'arrondi extérieur moins la paroi), et l'insert les suit à 5,1, rentré du jeu. Les
deux se calculent depuis le même profil, `zone_2d`. Un insert arrondi en face d'un
coin vif y aurait laissé un vide visible d'en haut.

- **Le prisme ne dépasse la paroi que de `zone_deb` = 0,05 mm** : assez pour ne pas
  coïncider avec elle, assez peu pour que le congé tombe dans le coin. À 5 mm, il
  tombait dehors.
- **Le corps de l'insert commence à 8,1**, au-delà de l'arrondi (qui finit à 7,6) :
  il reste droit, et c'est le bandeau qui épouse les coins.

### Le bandeau arrière : au-dessus des renflements, jamais plus plat que 45°

Il couvre la fente derrière le corps de l'insert, de 8,1 à 2,5 mm du mur, sur
`cadre_h` = 2 mm au bord. L'insert s'imprimant debout, c'est un porte-à-faux vers
l'arrière, porté par un encorbellement à 45° — qui passerait là où sont les
sommets des renflements. La coque ne bouge pas : c'est l'encorbellement qui les
contourne. Sa face arrière est un champ de hauteur,

    y(x, z) = max( droite à 45°,  ombre des renflements )
    ombre(x, z) = max sur z' ≤ z de  T(x, z') + jeu − (z − z')

L'ombre étale le renflement, gonflé du jeu, à 45° vers le haut. Deux garanties d'un
coup : aucun surplomb plus plat que 45°, même là où il épouse un renflement plus
pentu ; et la descente, parce qu'au-dessus de leur noyau (z > 77) les renflements
ne font que s'amincir en montant — un point qui les surplombe à sa hauteur les
surplombe pendant toute la descente. Au droit d'une vis, la coupe montre
l'encorbellement à 0,5 mm du renflement sur toute sa pente.

- **Le pied de l'encorbellement est noyé dans la paroi** : le champ commence 0,3 mm
  sous la droite à 45°. Parti pile à son pied, il se couchait sur la face arrière du
  corps — Manifold y voyait 8 arêtes non-variété, CGAL les fusionnait.
- **Le test `descente` ne peut plus être une simple projection** : le bandeau
  surplombe les renflements, légitimement. Il est testé par niveaux — ce qui est
  sous `zk` contre ce qui est au-dessus.
- **Si les renflements montent** (`arase_marge` réduit, `boss_Dhaut` allongé), le
  bandeau s'amincit à leur aplomb ; au-delà de z ≈ 93 il ne reste plus rien.

### Bornes des paramètres### Bornes des paramètres

- **`dos_ep` ≤ `col_h + porteur`** — assertion. La plaque se glisse entre le bois et
  la tête ; plus épaisse que la tige libre, elle ne passe pas, et la fente de tige ne
  traverse même plus. C'est ce qu'a cassé le passage aux vis courtes.
- **`z_vis` est déduit de l'arase, par le haut** :
  `z_haut − arase_marge − boss_Dhaut − boss_haut`. Ce n'est plus la casquette qui
  porte la fixation ; elle est libre de sa forme.
- **Le S du galbe est quintique (`liss5`), pas cubique.** Un décrochement de course
  `galbe` et de hauteur `marche` a un rayon concave minimal de `galbe²/(6·marche)` :
  7,3 mm en cubique, 17,2 en quintique. `r_av_bac` a valu 15 — il ne passait pas
  avec le cubique — et vaut 8 aujourd'hui, pour l'arase. `check_valid = true` doit
  rester activé pour le dire.
- **`bac_h` n'est plus contraint par les lunettes** : la règle des 35 mm est levée.
  Le changer déplace l'arase, donc les vis avec elle.
- **Tous les compartiments au même congé.** L'insert se calcule comme *l'intérieur
  de sa zone moins les compartiments* : un compartiment plus arrondi que le pourtour
  laisse dans le coin un fragment détaché, qui sortirait en morceau libre.
- **Un compartiment doit tenir entièrement dans une zone**, sinon il n'appartient à
  aucun insert et disparaît.
### Le crochet — quatre bornes, toutes sous assertion

Son profil n'a plus un seul pli : chaque portion arrive tangente à la suivante, et
le galbe est dans la courbe, pas dans un congé posé dessus. En échange, le galbe
latéral `croc_rb` est contraint de quatre côtés.

- **`croc_mince` > 2·`croc_rb` + 1.** Le galbe latéral est un `offset_sweep`, qui
  rentre le profil de son rayon en bout de balayage. Plus large que la moitié de
  l'épaisseur du bras, il le traverse et le profil se recoupe.
- **`croc_gorge`² > 6·`croc_r_z`·`croc_rb`.** Même raison, côté concave : un S de
  course `croc_gorge` et de hauteur `croc_r_z` a un rayon concave minimal de
  `croc_gorge²/(6·croc_r_z)`, et un décalage plus grand se recoupe.
- **1,875·`croc_r_z` ≤ `croc_gorge`.** C'est le porte-à-faux : la pente maximale
  d'un S quintique vaut 1,875 fois sa hauteur sur sa course, et cette pente est
  l'angle depuis la verticale à l'impression. 1 = 45°.
- **`croc_l` − `croc_nez` − `croc_gorge` ≥ `croc_col_y` + `croc_conge`.** Sinon la
  butée et le congé de gorge se chevauchent et la vallée disparaît.

Deux bornes de plus, qui viennent du casque et non de la géométrie :

- **`croc_vallee` ≥ 40 mm**, sinon la sangle se perche au lieu de s'asseoir. Voir §4.
- **`croc_l` ≤ `prof`**, sinon la pointe dépasse la face avant du panier.

Et une règle qui n'est pas une borne mais un piège : **aucun échantillon du profil
ne doit tomber sur un plan de recoupe.** Le dos du profil déborde exprès de
`croc_dos` = `croc_rb` + 2 derrière le mur, et l'échantillonnage du dessous démarre
à `i = 1`. Avec un point à y = 0 pile, le plan de coupe passait par un sommet du
maillage : 35 arêtes non-variété au pied du crochet, mesurées.

### La racine du crochet : ni recoupée à plat, ni plantée à angle droit

Il y a eu une recoupe « tout ce qui dépasse au-dessus de `marche` et hors de la
silhouette ». Elle coupait **à plat**, alors que le dessous suit l'arc de `r_ext` : le
coin bas-droit est arrondi de 20 mm, et le crochet (x = 49 → 83) traverse cet arc. La
recoupe lui taillait un croissant — jusqu'à **5,5 mm de jour à x = 81**, mesuré. Sans
recoupe, la colonne monte à `croc_haut` et rencontre le dessous réel de la coque.

Restait l'angle droit entre la colonne et le dessous : le seul angle vif entre deux
pièces dont tout le reste est galbé. Il est remplacé par un **congé concave**, en
quart de cercle, tangent à la colonne et au dessous. C'est un champ de hauteur en z :
à une distance `d` de la colonne, en plan, il descend du dessous du panier de
`R − √(R² − (R − d)²)`. Il épouse le dessous tel qu'il est, plat puis remontant le
long de l'arc, et la colonne avec ses coins avant arrondis.

- `R` vaut 8, comme l'arrondi avant du bac, et tombe à 6,1 côté flanc : il ne reste
  là que 6,1 mm jusqu'au bord de la pièce, et le congé doit s'y éteindre tangent
  plutôt que d'y être recoupé.
- Mesuré sur le maillage devant la colonne, il suit le quart de cercle théorique à
  0,02 mm près.
- Il s'imprime sans support : à chaque couche il ne fait que rétrécir.

### Les deux tests permanents

Ils sont dans le modèle, pas dans un script à part, et se lancent comme une pièce.

| `PIECE=` | Ce qu'il vérifie | Résultat attendu |
|---|---|---|
| `descente` | que les inserts descendent malgré les renflements — projection de l'insert ∩ projection de ce qui dépasse de l'arase OU de la paroi arrière | **vide** (`Current top level object is empty`) |
| `peau` | qu'il reste de la matière devant chaque logement de tête | **plein**, 346 mm³ |
| `jointure` | qu'il ne reste aucun jour entre la racine du crochet et le dessous de la coque | **vide** |

Un renflement mal placé rend `peau` creux ; un renflement trop gros rend `descente`
non vide. Les deux sont muets si on ne les lance pas.

## 8. Points de vérification

- [ ] **La pièce pend 37 mm plus haut** qu'à l'origine par rapport aux vis, mais son
      haut n'est plus qu'à 17 mm au-dessus d'elles depuis que la casquette est partie.
- [ ] **Le bandeau arrière** est en porte-à-faux sur 5,6 mm : l'encorbellement à 45°
      doit sortir propre. Regarder sa face cachée, et que l'insert descende sans
      frotter sur les renflements.
- [ ] **Le filet de 0,5 mm entre les deux couleurs** : régulier sur tout le
      pourtour ? S'il paraît trop large, `insert_jeu` le commande — mais c'est
      aussi le jeu de montage.
- [ ] **La cheville reste-t-elle en saillie du bois ?** Si oui, sa hauteur hors bois
      doit revenir dans `col_h`, aujourd'hui à 0 — et toute la fixation se décale.
- [ ] **Mesurer la sangle du XM5 au réglet**, dans le sens avant-arrière. C'est la
      seule cote du casque que Sony ne publie pas, et c'est celle qui commande
      `croc_l`. Le crochet est dimensionné pour 38 et accepte jusqu'à ~40.
- [ ] **Mesurer l'épaisseur de la sangle**, coussin compris, et la confronter aux
      28 mm de `croc_jour` — c'est le passage entre le fond de gorge et le dessous
      de la coque. 28 mm devraient être confortables, mais ce n'est pas vérifié.
- [ ] Les coquilles pendent librement sous le crochet : rien ne les gêne dans le
      modèle, mais l'écart au mur reste à juger casque en main.
- [ ] Le jeu de 0,5 mm au pourtour des inserts n'a pas été validé à l'impression.
- [ ] Les lunettes debout dans une fente de 50 × 37,6 sur 92,2 mm : tenue à vérifier.
- [ ] La poche à tabac debout dans une fente de 85 × 30 : une blague souple
      tient-elle droite ? C'est elle qui commande la largeur de la zone profonde.
- [ ] Les renflements descendent sous l'arase et mordent sur le haut des
      compartiments arrière. L'insert leur est dégagé — test `descente` — mais
      l'encombrement réel reste à juger en main.
