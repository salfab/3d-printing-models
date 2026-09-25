# vide-poches

Panier mural qui s'enfile par le haut sur deux vis à tête fraisée, en les gardant
invisibles. Fond à deux niveaux reliés par un galbe, crochet à casque sous la
partie haute, inserts à séparations amovibles qui bordent l'ouverture d'un liseré.

## 1. À quoi sert la pièce

Vider ses poches en rentrant : paquet de tabac, briquets, lunettes, câbles USB,
petites bricoles — et suspendre un casque Sony WH-1000XM5 dessous.

La pièce s'accroche sur le flanc d'un meuble en bois, à deux vis SPAX 3 × 12
posées pour elle : leur écartement est donc libre, fixé à 124 mm (`entraxe`).
Elle a d'abord été dessinée pour une cheville d'assemblage déjà en place ; ce qui
suit en garde la trace là où l'histoire explique une cote.

Une douille métallique subsiste à ~45 mm en diagonale de la cheville, reste d'un
ancien montage. **Elle n'est pas utilisée** : à cet écartement les deux points
seraient concentrés au centre de la pièce, le couple de vrillage repris sur un bras
trois fois plus court, et la diagonale ne bloque pas la rotation aussi bien qu'un
alignement horizontal.

### La vis : SPAX 3 × 12 à tête fraisée

Deux vis à bois vissées directement dans le flanc du meuble. Relevé au pied à
coulisse : **tête Ø 6, tige Ø 3**. Fraisure à 90°, donc un cône de 1,5 mm ; le petit
bord cylindrique au-dessus est **estimé** à 0,2 (`tete_bord`).

Elle remplace une vis à tête cylindrique de Ø 8 × 3, et c'est la hauteur de tête
qui compte. La plaque porteuse est **fraisée au même cône**, avec `jeu_cone` = 0,3 mm :
elle mord donc 1,0 mm DANS le cône, comme un fraisage de menuiserie. La tête y porte
sur toute la surface conique et s'y centre.

```
bois | 1,5 de tige libre | fraisage : 1,0 dans la plaque | 0,4 de cone + 0,2 de bord | 0,4 de jeu | peau 1,2
     └───────────── plaque porteuse 2,6 ─────────────┘└────────── logement 1,0 ──────────┘
```

**Il y a eu un faux fraisage**, et c'est le genre d'erreur qui ne se voit pas sur un
rendu : un « chanfrein » de 0,6 mm, bien à 45° comme le cône, mais décalé de 0,5 mm
au rayon. Deux surfaces parallèles qui ne se rencontraient **jamais** : la tête
n'appuyait qu'après que le panier ait avancé de 0,5 mm, et sur un anneau de 0,55 mm
de large. Mesuré en plaçant la vis dans le canal — le calcul qui l'avait produit
supposait un point de contact qui n'existait pas sur le cône.

L'épaisseur au droit des vis vaut **4,8 mm**, contre 7,6 avec l'ancienne vis. Elle
serait passée à 5,8 avec le vrai fraisage si deux vides n'avaient pas été repris en
même temps : le logement de tête était calibré pour une tête de Ø 8 (1,5 mm de vide
au rayon, `jeu_tete` de 3 à 2) et la peau avant faisait quatre passes de buse là où
trois suffisent (`dos_av` de 1,6 à 1,2). Bilan : **0,5 mm de gagné**, et un siège
qui porte. Les bosses tombent de 20 mm de large à 11.

**Le gabarit se pose par un VRAI TROU DE SERRURE**, celui du panier, pris dans le
corps même du réglet. On l'enfile comme le panier — présenter, pousser, descendre
de 8 mm — et il devient captif, tenu par le siège conique. C'est plus précis qu'un
trou de passage, qui aurait laissé 0,4 mm de flottement au report de l'entraxe, et
surtout **l'essai de pose est la mise en place** : un seul geste au lieu de deux.

Il répond ainsi aux quatre questions qu'un écran ne tranche pas — la tête passe-t-elle
par le trou d'entrée, le fraisage se glisse-t-il sous le cône, la course la rend-elle
captive, la peau de 1,2 mm sort-elle propre sur son pontage. **Si le gabarit ne
s'enfile pas, le panier ne s'enfilera pas non plus.** Le réglet s'imprime à plat,
donc dans la même orientation que la coque : le pontage y est représentatif.

**La profondeur de vissage n'est plus libre.** La plaque se glisse entre le bois et
le cône avec 0,5 mm de jeu axial : vissée trop profond, la vis ne laisse plus
passer la plaque. D'où la **cale** du gabarit, une fourche de 1,7 mm à glisser sous
la tête : on visse jusqu'à ce que le cône la pince. Ses 1,7 et non 1,5 tiennent
compte de ce que le cône porte sur les bords de la fourche, pas sur la tige.

### Un vrai trou de serrure, et ce qu'il change

La tête entre par un **trou percé dans la plaque porteuse**, au bas de la course.
On présente, on pousse contre le bois, on descend de 8 mm : la tige monte dans la
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
Cotes **utiles**, entre parois d'insert. La profondeur varie dans les
compartiments que le galbe traverse : le fond le suit.

| Objet | Rangé | Largeur × profondeur | Profondeur utile |
|---|---|---|---|
| Poche à tabac | debout | 85,0 × 30,0 | 90 |
| Lunettes pliées | debout | 55,0 × 41,8 | 90 |
| Stylos, grands objets | debout | 27,6 × 41,8 | 90 |
| **Briquets** (Bic J26, Clipper) | debout | 17,0 × 37,2 | 65 à 76 |
| Câbles USB | en vrac | 30,5 × 37,2 | 44 à 61 |
| Petits objets | en vrac | 30,5 × 37,2 | 44 |
| Petites bricoles | en vrac | 82,8 × 34,6 | 44 à 90 |

**La fente à lunettes fait 55 et non 50** : à 50, les branches d'une monture large
forçaient. Les 5 mm sont pris sur la case à stylos, qui tombe de 32,6 à 27,6.

**La case à briquets** occupe le creux du galbe, contre la cloison : une case
rectangulaire comme les autres, pour garder à la grille son dessin orthogonal vue
d'en haut. Son fond suit le galbe mais s'arrête sur un replat à `briq_prof` = 76 mm
sous le bord, pour ne pas finir en pointe — 11 mm de plat contre la cloison, puis
le fond remonte avec le galbe. **Sous le replat, l'insert est plein** : la case
repose sur la coque.

Bic J26 : 82 × 25 × 15 mm ; Clipper Large : 74 mm de haut, 16 d'épaisseur — d'où
17 de large. Le Bic dépasse du bord de 6 mm ; le Clipper passe 2 mm dessous, et
s'attrape par le côté (37 mm de profondeur de case pour 22 d'épaisseur de briquet).
Plus bas, il faudrait retourner l'insert pour le sortir.

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
| Gabarit | `gabarit` | 1 | réglet à trou de serrure, repère de perçage et cale de profondeur — consommable |
| Pièce d'essai | `essai` | 1 | les 10 derniers mm de la coque et des inserts, pour valider le jeu **avant tout** |

```bash
python scripts/scad.py stl vide-poches -D PIECE=coque   --binaire
python scripts/scad.py stl vide-poches -D PIECE=insert  --binaire
python scripts/scad.py stl vide-poches -D PIECE=gabarit --binaire
python scripts/scad.py stl vide-poches -D PIECE=essai   --binaire
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
| Coque | 184,8 cm³ | 181,0 × 84,9 × 95,0 mm |
| Inserts (2 corps) | 135,0 cm³ (74,2 + 60,8) | 175,6 × 79,9 × 91,9 mm |
| **Total** | **319,8 cm³** | |

La coque a perdu 75 cm³ quand le fond s'est mis à suivre le galbe : le socle plein
sous le côté peu profond a disparu.

Exportés avec le moteur **Manifold** ; un export `--cgal` rend le même volume au
dixième de cm³.

> Volume **géométrique**, pas le fil consommé. Les parois font 2,4 mm et sortent
> pleines ; le socle du côté peu profond, lui, est un bloc massif que le trancheur
> remplit au taux qu'on lui donne.

| Cote | Valeur | Origine |
|---|---|---|
| Épaisseur du dos, hors fixation | 2,0 mm | `dos_ep` |
| Épaisseur au droit des vis | **4,8 mm** | `col_h + porteur + loge_e + dos_av` — 7,6 avec l'ancienne vis |
| Plaque porteuse | 2,6 mm | `tete_bout − fraise_reste` — elle mord 1,0 mm dans le cône |
| Fraisage du siège | cône à 45°, Ø 3,8 → 5,8 | `jeu_cone` = 0,3 — 19 mm² de portée |
| Peau avant | 1,2 mm | `dos_av` — trois passes de buse ; elle ne porte rien |
| Course d'enfilage | 8 mm | `course`, déduite : rayon du trou d'entrée + rayon de la tête + 1 mm d'appui |
| Axe des vis | z = 66,3, **29 mm sous l'arase** | au plus bas : le renflement droit se pose à 2 mm du fond peu profond |
| Renflements | noyau Ø 11 | minimaux : 1,5 mm autour du logement, raccord sur 2 mm |
| Paroi arrière de l'insert | S de 5,6 à 2,3 mm du mur, sur 20,2 mm (z = 74,8 → 95) | `y_arr`, 17° au plus fort |
| Entraxe des chevilles | 124 mm | 17,1 mm entre noyau et flanc, pour que le renflement s'y éteigne |
| Fente de tige | 3,8 mm | `vis_d + jeu_vis` |
| Trou de passage de la tête | 7,5 mm | `tete_d + jeu_entree` |
| Logement de tête | Ø 8,0 × 1,0 mm | `tete_d + jeu_tete`, `loge_e` — la tête n'en dépasse que de 0,6 |
| Profondeur, zone profonde | 92,2 mm | `bac_h − fond_bas` |
| Profondeur, zone peu profonde | 46,2 mm sur le plat, 92 au pied du galbe | le fond suit le dessous : `plancher` |
| Marche entre les deux niveaux | 46 mm sur 45 de galbe | `marche`, `galbe` |
| Galbe de la jointure avant | 8 mm | `r_av_bac` — borné par l'arase, voir §7 |
| Angles hauts du bac | 8 mm | `r_coin_bac` = `r_av_bac` : à 6, l'angle devenait vif sur la face avant |
| Paroi / cloison / fond | 2,4 / 2,4 / **2,8** mm | `fond` ≠ `paroi` : voir §7 |
| Jeu insert / coque | 0,3 mm par côté | `insert_jeu` — c'est aussi le filet entre les deux couleurs ; à valider sur `essai` |
| Paroi d'insert | 1,2 mm, pleine hauteur | `insert_paroi` — 3 périmètres ; elle porte le liseré |
| Largeur hors tout | 181 mm | `larg` passé de 175 à 181 : 4 × 1,5 de parois d'insert, les compartiments gardent leur largeur |
| Portée du crochet | 84 mm | `croc_l` — bout à 0,9 de la face avant |
| Racine du crochet | S de 26 mm, tangent au dessous du panier | `croc_racine` |
| Profondeur hors tout | 84,9 mm | `bac_int` = 80,5, fixé par la portée du crochet (84) ; la fente à lunettes a 41,8 |
| Crochet, vu de face | la vague : 42,7 mm en haut, ~32,5 au creux, au nu du flanc droit | `croc_v0`, `croc_v1`, `croc_rv`, `r_ext` |
| **Creux de l'arceau** | **~50 mm** à mi-hauteur de la butée, 33 de fond plat | `croc_vallee` |
| Passage libre sous la coque | 28 mm | `croc_jour` = `marche − croc_creux` |
| Bras au plus fin | 10 mm | `croc_mince` |
| Butée | 10 mm, spatule relevée sur 20 | `croc_r_z`, `croc_gorge` |
| Bout du crochet | arrondi R5 | `croc_bout` |
| Arrondi des arêtes du crochet | 4 mm, **dessus ET dessous** | `croc_rb` — 40 % de l'épaisseur du bras, contre 9 % pour l'arête avant de la coque |

### Le crochet et le Sony WH-1000XM5

**Le bras enfourche l'arceau** : l'arceau se couche en travers du bras, sur ~32 mm
de large au creux, et sa **sangle** se couche selon Y, dans le creux entre la
racine et la spatule. C'est la longueur de ce creux qui décide si le casque
s'assoit ou se perche : ~50 mm à mi-hauteur de la butée, 33 de fond plat.

Le XM5 pèse **250 g** (spécification Sony) et **ne se plie pas** — il ne fait que
pivoter à plat, donc on le pend tel quel. Sa sangle fait de l'ordre de 38 mm ; c'est
la seule cote que Sony ne publie pas, et elle mérite un coup de réglet avant
impression.

### Le crochet, troisième dessin : une vague de face, un S de côté

Il détonnait : un bloc de 34 mm aux coins de 4, rapporté sous le plateau, une
colonne droite, un bras plat et un gros nez rond — des droites et un bouton sous
une coque qui ne parle qu'en grandes courbes. Il reprend désormais les deux gestes
de la coque :

- **De face, la vague.** Son flanc droit est celui de la coque, prolongé jusqu'en
  bas et arrondi de `r_ext` = 20 comme le coin bas gauche de la pièce ; son flanc
  gauche descend en S, en écho au galbe.
- **De côté, un S puis une spatule.** La racine part tangente au dessous du panier
  et descend en S jusqu'au creux — le dessous se prolonge dans le crochet comme il
  se prolonge dans le galbe. Le bras, de 10 à 12 mm, se relève au bout comme une
  spatule et finit par un arrondi de 5.

Construction : l'INTERSECTION d'un champ de hauteur, qui porte le profil de côté,
et du prisme de la vague, qui porte la vue de face.

- **Le dessus de la racine suit le dessous réel du panier**, plat puis l'arc du coin
  bas droit : contre le mur, la racine comble le dessous de cet arc et le flanc du
  crochet continue celui de la coque. `jointure` le vérifie.
- **Il en part 0,3 mm plus haut**, dans la coque : parti pile sur le dessous, le S
  lui serait tangent sur toute une bande — la famille de coïncidences de ce modèle.
- **Les arêtes du DESSOUS sont arrondies comme celles du dessus.** Elles ne
  l'étaient pas : la coupe du bras montrait un dessus galbé posé sur deux angles
  vifs à 90°, et c'est ce qui faisait lire le crochet comme plus dur que la coque.
- **Le rayon est borné par la demi-épaisseur locale.** Au bout de la spatule la
  section s'annule, et deux arrondis de 4 s'y traverseraient.
- **Le congé se place par son CENTRE**, et non en remontant le dessous d'une
  quantité qui dépendrait de la distance au flanc. Les flancs de la vague sont
  très inclinés dans la hauteur du bras — l'arc de 20 y rentre de 1,4 mm par
  millimètre —, et deux méthodes plus simples y ont échoué :
  1. *distance mesurée à plat, à la hauteur de départ* : l'arrondi remontait de
     4 mm au-dessus d'un flanc qui, 4 mm plus haut, s'était écarté de 3. Il restait
     une **marche de 3 mm** au lieu d'un congé, visible en coupe ;
  2. *la même distance, mesurée à la hauteur d'arrivée* : c'est une équation
     implicite, résolue par itérations. Elles **oscillent** près du flanc — sauts
     de pente de 6 par dixième de millimètre, mesurés — et ces oscillations se
     lisaient comme des **fissures le long du dessous du bras**, bien visibles sur
     un rendu de dessous.

  Le congé est maintenant le cercle de rayon `croc_rb` tangent aux deux faces : on
  résout pour son centre. Exact pour un flanc droit, sans itération, et les sauts
  de pente tombent de 6 à moins de 0,11.
- **Dessous et dessus ne se traitent pas pareil**, parce que l'angle n'est pas le
  même. La vague s'élargit vers le haut :
  - *dessous* — angle **aigu**. Le cercle touche le flanc avant d'atteindre son
    point le plus à gauche ; on plafonne le creux à cette valeur, et ce plafond
    tombe pile sur le flanc. Le raccord est tangent, la partie plate est hors pièce.
  - *dessus* — angle **obtus**. Le cercle passe par son point le plus à gauche
    AVANT de toucher le flanc, et un champ de hauteur ne sait pas décrire la
    suite : il plafonnait, donc posait une bande **plate de 1 mm à l'intérieur de
    la pièce, bordée d'une arête à 90°**. Au bout de la spatule, côté panier, cela
    se lisait comme une **ligne de moulage**. Le centre est donc placé pour que le
    cercle arrive vertical exactement là où le flanc passe à la hauteur d'arrivée :
    plus de partie plate, et le raccord fait l'angle du flanc — au pire 20°, soit
    une arête à 160° au lieu de 90°.
- **`croc_pas` reste à 0,5 mm.** À 0,3 le bout de la spatule est plus lisse, mais le
  STL passe de 14 à 32 Mo — trop lourd pour l'aperçu, et invisible à l'impression.
- **L'extinction porte sur le RAYON, pas sur le déplacement** : un rayon qui décroît
  reste un congé, un déplacement rogné ne l'est plus.
- **L'arrondi du dessus s'éteint là où il est encore collé au panier** : il y
  creuserait une rainure entre les deux.
- **Aucun porte-à-faux au-delà de 45°** à l'impression : la racine et le dessous ne
  font que rétrécir à chaque couche, et la spatule monte à 43° au plus
  (1,875 × 10 / 20). Assertion dans le modèle.

Contrôles topologiques sur le maillage, tous à zéro :

| Pièce | Solides | Cavités scellées | Arêtes de bord | Arêtes non-variété |
|---|---|---|---|---|
| Coque | 1 | 0 | 0 | 0 |
| Inserts | 2 | 0 | 0 | 0 |

## 5. Montage

L'ordre compte : le gabarit se pose sur la **première** vis, et c'est de là qu'il
reporte la seconde.

0. **Imprimer d'abord le gabarit et la pièce d'essai.** Sur `PIECE=essai`, l'anneau
   d'insert doit entrer dans l'anneau de coque sans forcer et sans ballotter —
   sinon, ajuster `insert_jeu`.
1. **Poser la première vis** où le panier doit venir : avant-trou de Ø 2 dans du
   bois tendre, Ø 2,5 dans du dur. C'est elle qui fixe la hauteur de l'ensemble.
2. **Régler sa profondeur à la cale.** On glisse la fourche sous la tête, à plat
   contre le bois, et on visse jusqu'à ce que le cône vienne la pincer. Elle se
   retire alors en forçant légèrement : la tige libre fait 1,5 mm.
3. **Enfiler le gabarit** sur cette vis par son trou de serrure : présenter,
   pousser contre le bois, descendre de 8 mm. Il doit devenir **captif** —
   impossible à tirer vers soi. S'il force, la vis est trop profonde ; s'il flotte,
   elle ne l'est pas assez. C'est le même essai que celui du panier, en 320 cm³ de
   moins, et le gabarit se trouve du même coup en place.
4. **Mettre le réglet d'aplomb** et **marquer** à travers le repère de Ø 2. Rien
   sur la pièce ne garantit l'horizontale : un petit niveau contre sa face, ou une
   mesure égale depuis le chant avant du meuble aux deux extrémités. Les deux vis
   doivent être à la **même hauteur**, sinon le panier vrille quand on le charge de
   travers.
5. **Retirer le gabarit, percer, visser la seconde vis**, et régler sa profondeur
   à la même cale. Entraxe 124 mm.
6. **Présenter la coque**, les deux têtes en face des trous d'entrée de Ø 7,5.
7. **Pousser contre le bois**, puis **descendre de 8 mm** (`course`). Elle vient
   en butée toute seule.
8. **Poser les deux inserts**, chacun dans sa zone. Ils descendent à la verticale ;
   le haut de leur paroi arrière, qui recule vers le mur, passe au-dessus des
   renflements de fixation.

Pour décrocher : remonter de 8 mm, tirer vers soi. Rien à dévisser.

## 6. Impression

- **Aucun support, sauf sous le fond de l'insert peu profond.** Son fond suit le
  galbe : debout sur son point bas, la partie plate est un plafond à 46 mm du
  plateau. Supports sous le fond uniquement — c'est la face cachée, posée dans la
  coque. Environ 40 g de support. Tout le reste s'imprime sans.
- Coque sur son dos ; inserts à plat, fond contre le plateau. Le haut de la paroi
  arrière des inserts recule vers le mur en S : 17° de la verticale au plus fort,
  sans support.
- PLA. Le bras du crochet travaille en traction entre couches, la direction faible :
  250 g de casque à 60 mm de porte-à-faux donnent **0,26 MPa** sur sa section la
  plus faible, 34 × 10 mm, contre ~20 MPa de cohésion inter-couches. Facteur 77.
- Le crochet n'a **aucun porte-à-faux au-delà de 45°** : la spatule est le seul
  élément qui s'écarte de la verticale à l'impression, et son S atteint au plus
  1,875·`croc_r_z`/`croc_gorge` = 0,94, soit 43°. Assertion dans le modèle.
- Emprise plateau : 181 × 95 mm pour la coque ; 181 × 176 mm pour la pièce d'essai,
  à couper en deux lancers si le plateau est plus petit.
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

Autour de chaque vis, le dos passe de `dos_ep` = 2,0 mm à `dos_e` = 4,8 mm. La façon
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
7. **Tête fraisée.** La SPAX 3 × 12 fait tomber `dos_e` de 7,6 à 5,3 : le
   renflement n'a plus que 3,3 mm de surépaisseur.
8. **Minimal, et au plus bas.** Caché derrière l'insert, il n'a plus à être
   élégant ; c'est sa hauteur qui compte, parce que tout ce qu'il ne prend pas
   au-dessus des vis revient au S de la paroi arrière de l'insert. Noyau
   concentrique au logement de tête avec 1,5 mm de matière autour (Ø 12), raccord
   à la plaque sur 2 mm, course ramenée de 14 à 8. Il passe de 38 à 24 mm de haut,
   et se pose à 2 mm du fond du côté peu profond. Ses raccords sont raides —
   jusqu'à 70° — et ça n'a aucune importance : couchée sur le dos, la coque les
   trace comme des toits.

Il reste un champ de hauteur qui s'éteint avant chaque limite :

```
face avant = plaque + surépaisseur × S(ρ) × W(paroi) × W(arase) × W(bas)
```

Les profils mesurés et les pentes des générations précédentes ne valent plus :
avec des raccords de 2 mm, la pente atteint 1,875 × 3,3 / 2 ≈ 3, soit 72°.

Ce qu'il faut savoir avant d'y toucher :

- **Il n'est pas retranché par la cavité** : `coque()` l'ajoute APRÈS le
  creusement. Retranché avec le reste, il disparaîtrait — il est tout entier dans
  le volume des compartiments.
- **L'insert les cache : c'est un petit bac.** Son corps passe DEVANT les
  renflements, à `dos_e` + jeu = 5,1 mm du mur, et ses compartiments arrière
  commencent une paroi plus loin (`yi0_ins` = 6,3). Au-dessus des renflements, sa
  paroi arrière recule en S jusqu'à la plaque (ci-dessous).
- **Ça coûte 6,3 mm au fond de chaque compartiment arrière** (9,3 avec l'ancienne
  vis).
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
galbe, en deux couleurs, coupé par le jeu.

- **Ne pas redonner à l'insert un dessus plat** : il dépasserait de l'arrondi de
  la coque au lieu de le prolonger.
- **Les compartiments sont creusés dans l'enveloppe rentrée de jeu + paroi**, pas
  seulement bornés par `cuves`. Là où la coque se resserre — près de l'avant, son
  intérieur suit l'arrondi de 8 mm —, une paroi d'insert simplement tracée par
  les cuves s'amincissait jusqu'à disparaître au coin.
- **Les cotes de `cuves` sont des cotes UTILES**, entre parois d'insert. D'où
  `larg` qui a grandi : garder la poche à tabac à 85 coûte 1,5 mm
  à chaque paroi que l'insert double.

### Les coins : concentriques, en coque comme en insert, aux quatre angles

Les quatre coins de chaque zone sont dessinés dans son profil en plan, `zone_2d`,
avec `r_arr` = 5,7 mm : l'arrondi extérieur de 8 moins la paroi de 2,4, plus 0,1.
La paroi de la coque garde donc ses 2,4 jusque dans le coin, l'insert suit à 5,4,
rentré du jeu, et les compartiments d'angle sont bornés par le même profil rentré
d'une paroi d'insert : le liseré garde sa largeur dans les coins aussi.

- **Les coins avant étaient laissés au balayage, et c'était une erreur.** L'arrondi
  avant rétrécit le contour intérieur EN BLOC, il ne l'arrondit pas en plan : le
  flanc intérieur y suit un arc de rayon 8 que la face avant coupe à 44° au lieu de
  s'y raccorder. L'insert en héritait. C'étaient les deux angles « mal dessinés ».
- **Les coins arrière étaient vifs** — le prisme passait 5 mm derrière la plaque —,
  et un insert arrondi en face d'un coin vif y aurait laissé un vide.
- **Les 0,1 mm de plus ne sont pas du goût.** À 5,6 pile, le congé démarrait dans
  le plan exact où démarre l'arrondi avant du balayage (y = prof − 8), et les
  sommets de l'un tombaient sur les arêtes de l'autre : 6 arêtes non-variété au
  bout de la cloison.
- **Le prisme ne dépasse la paroi que de `zone_deb` = 0,05 mm** : assez pour ne pas
  coïncider avec elle, assez peu pour que le congé tombe dans le coin.

### Le fond suit le galbe : `plancher`

Le fond n'est plus à deux niveaux plats (2,8 et 48,8). C'est le dessous de la coque
rentré de `fond` = 2,8, perpendiculairement : sous le côté peu profond, il suit le
S, et les compartiments câbles et bricoles descendent au pied de la cloison aussi
bas que la zone profonde. Une seule définition sert à la coque (`plancher()`), à
l'insert (`plancher(jeu)`) et au fond de ses compartiments (`plancher(jeu +
insert_fond)`). Les niveaux de fond par zone et par compartiment ont disparu.

- **Il est BALAYÉ avec le même arrondi avant que l'enveloppe intérieure.** Extrudé
  droit, il restait à 2,8 pendant que l'enveloppe remontait de d(y) vers la face
  avant ; là où d valait 0,4, les deux — décalages du même S, de 2,4 + d et de
  2,8 — se confondaient sur tout le galbe. 18 arêtes non-variété.
- **Son contour est prolongé de 20 mm au-delà des flancs, sans arrondis d'angle** :
  il ne règle que le fond ; ce sont les flancs et les coins de l'enveloppe
  intérieure qui bornent le reste.
- **Ce n'est pas un évidement par-dessous.** Il est ouvert par le haut, et la coque,
  couchée sur le dos, le trace comme un simple contour. L'évidement fermé qui avait
  existé sous le socle, lui, était une cavité scellée impossible à imprimer.
- **Il coûte un support à l'insert peu profond**, et à lui seul (voir §5).
- **Sous la case à briquets, l'insert est PLEIN.** Il a été creux, et c'était un
  défaut : le fond de 1,6 mm se retrouvait en porte-à-faux sur 14 × 37 mm au-dessus
  de 18 mm de vide, tenu par deux de ses quatre côtés seulement. Le plein coûte
  2,3 cm³ de volume modèle — deux grammes au remplissage courant — contre un fond
  qui ploie et un plafond de plus à soutenir à l'impression.

### La paroi arrière de l'insert : un S au-dessus des renflements

Le corps de l'insert passe devant les renflements, à 5,6 mm du mur. Au-dessus
d'eux, sa paroi arrière recule en S jusqu'à 2,3 mm du mur au bord, avec son
épaisseur de 1,2 : **le liseré a la même largeur sur les quatre côtés**. Le S est un
`liss5` sur toute la hauteur libre au-dessus des renflements, 20,2 mm : tangent à
la verticale en bas ET en haut, sans arête que la lumière soulignerait, 17° au plus
fort de sa pente.

Trois versions l'ont précédé :

1. un bandeau horizontal épais de toute la fente, porté par un encorbellement à
   45° qui contournait les renflements — le liseré arrière faisait trois fois les
   autres ;
2. un plan incliné sur les 7 derniers millimètres, deux arêtes nettes ;
3. le S, une fois les renflements rendus minimaux et descendus au plus bas.

- **Deux assertions le gardent** : la pente reste sous 45°, et la paroi passe devant
  le renflement réel, jeu compris, à chaque hauteur.
- **La descente passe** : le S ne commence qu'au-dessus des renflements. Le test
  `descente` n'est plus une simple projection — le haut de la paroi surplombe les
  renflements, légitimement — mais un test par niveaux.
- **Les compartiments arrière suivent le S** en une seule peau (`skin`), sections à
  coins arrondis dont le bord arrière recule avec la paroi. Construits en tranches
  collées, ils laissaient des micro-arêtes à chaque raccord.
- **Si les renflements remontent**, le S se raccourcit et se raidit. L'assertion
  exige au moins 10 mm de hauteur libre.

### Bornes des paramètres

- **La plaque porteuse ne doit pas dépasser le cône** (`porteur < tete_bout`) :
  au-delà elle buterait sur le petit bord cylindrique de la tête, et le fraisage ne
  porterait plus.
- **Le logement de tête doit rester STRICTEMENT plus large que le trou d'entrée**,
  qu'il prolonge en y. À égalité, leurs deux contours coïncident dans le plan qui
  les sépare : 116 arêtes non-variété, mesurées. Assertion.
- **Le fraisage se prolonge de 0,3 mm dans le logement.** Fini pile au plan de la
  face avant, il y coïncidait avec le début du logement.
- **`dos_ep` ≤ `col_h + porteur`** — assertion. La plaque se glisse entre le bois et
  la tête ; plus épaisse que la tige libre, elle ne passe pas, et la fente de tige ne
  traverse même plus. C'est ce qu'a cassé le passage aux vis courtes.
- **`z_vis` est déduit du fond, par le bas** :
  `fond_haut + bas_marge + boss_Dbas + boss_bas + course`. Plus haut, le S de la
  paroi arrière de l'insert se raccourcit ; une assertion exige 10 mm libres
  au-dessus des renflements.
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
### Le crochet — bornes sous assertion

- **1,875·`croc_r_z` ≤ `croc_gorge`** : le porte-à-faux de la spatule à
  l'impression. La pente maximale d'un S quintique vaut 1,875 fois sa hauteur sur
  sa course, et cette pente est l'angle depuis la verticale. 1 = 45°.
- **La racine et la spatule ne se chevauchent pas**, avec 20 mm de creux entre les
  deux au moins.
- **`croc_vallee` ≥ 40 mm**, sinon la sangle se perche au lieu de s'asseoir.
- **`croc_l` ≤ `prof`**, sinon le bout dépasse la face avant du panier.
- **Le bras reste plus épais que son bout rond.**

Deux pièges évités par construction : le champ de hauteur déborde de 3 mm derrière
le mur, pour que la recoupe au plan du mur ne passe par aucun de ses sommets ; et
il est parcouru dans le même sens que les renflements — parcouru à l'envers, il
sortait retourné, volume négatif.

### Les deux tests permanents

Ils sont dans le modèle, pas dans un script à part, et se lancent comme une pièce.

| `PIECE=` | Ce qu'il vérifie | Résultat attendu |
|---|---|---|
| `descente` | que les inserts descendent malgré les renflements — projection de l'insert ∩ projection de ce qui dépasse de l'arase OU de la paroi arrière | **vide** (`Current top level object is empty`) |
| `peau` | qu'il reste de la matière devant chaque logement de tête | **plein**, 115 mm³ (12 × 0,4 × (course + 4), deux fois) |
| `jointure` | qu'il ne reste aucun jour entre la racine du crochet et le dessous de la coque | **vide** |

Un renflement mal placé rend `peau` creux ; un renflement trop gros rend `descente`
non vide. Les deux sont muets si on ne les lance pas.

## 8. Points de vérification

- [ ] **La pièce pend 37 mm plus haut** qu'à l'origine par rapport aux vis, mais son
      haut n'est plus qu'à 17 mm au-dessus d'elles depuis que la casquette est partie.
- [ ] **La paroi arrière en S** : que l'insert descende sans frotter sur les
      renflements, et que le S ne marque pas à la lumière.
- [ ] **La course de 8 mm** : la tête doit passer le trou d'entrée franchement, et
      rester captive en haut sans pouvoir ressortir.
- [ ] **Le jeu de 0,3 mm**, sur la pièce d'essai, avant toute chose : l'anneau
      d'insert entre sans forcer et sans ballotter ? C'est aussi le filet entre les
      deux couleurs.
- [ ] **Hauteur réelle de la tête SPAX** : `tete_bord` = 0,2 est estimé, et le
      logement ne laisse plus que 0,4 mm de jeu devant la tête. Un bord plus haut
      s'absorbe en remontant `loge_e`.
- [ ] **Le fraisage est exigeant sur la profondeur de vissage** : 0,3 mm de jeu
      seulement. Vissée trop profond, la plaque ne se glisse plus. C'est la cale du
      gabarit qui le règle — et c'est elle qu'il faut vérifier en premier.
- [ ] **La peau avant à 1,2 mm** est un pontage de 8 mm à l'impression. Regarder
      qu'elle sorte propre, et que la vis ne se devine pas au travers.
- [ ] **La cale du gabarit** : la vis réglée avec elle laisse-t-elle passer la plaque
      avec un peu de jeu, sans flotter ?
- [ ] **Le fond galbé de l'insert peu profond** : supports faciles à retirer, et
      l'insert repose-t-il bien au fond sans basculer ?
- [ ] **Mesurer la sangle du XM5 au réglet**, dans le sens avant-arrière. C'est la
      seule cote du casque que Sony ne publie pas, et c'est celle qui commande
      `croc_l`. Le crochet est dimensionné pour 38 et accepte jusqu'à ~40.
- [ ] **Mesurer l'épaisseur de la sangle**, coussin compris, et la confronter aux
      28 mm de `croc_jour` — c'est le passage entre le fond de gorge et le dessous
      de la coque. 28 mm devraient être confortables, mais ce n'est pas vérifié.
- [ ] Les coquilles pendent librement sous le crochet : rien ne les gêne dans le
      modèle, mais l'écart au mur reste à juger casque en main.
- [ ] Les lunettes debout dans une fente de 50 × 37,6 sur 92,2 mm : tenue à vérifier.
- [ ] La poche à tabac debout dans une fente de 85 × 30 : une blague souple
      tient-elle droite ? C'est elle qui commande la largeur de la zone profonde.
- [ ] Les renflements descendent sous l'arase et mordent sur le haut des
      compartiments arrière. L'insert leur est dégagé — test `descente` — mais
      l'encombrement réel reste à juger en main.
