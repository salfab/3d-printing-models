// vide-poches — panier mural suspendu sur deux chevilles d'assemblage,
// vis invisibles, crochet à casque intégré.
//
// Le panier s'enfile par le haut : on le présente au-dessus des deux vis, on le
// descend, il se verrouille. Rien à visser une fois la pièce en main, rien à
// démonter pour le décrocher.
//
// La fixation tient en trois canaux verticaux superposés dans l'épaisseur du dos,
// un par étage de la vis : le fût au fond, la tige lisse au milieu, la tête
// devant. Chacun monte dans le sien pendant la descente. Conséquence utile : la
// tête ne traverse jamais rien, elle monte dans son logement — donc aucun trou de
// passage n'est nécessaire et la peau avant reste pleine. Les vis sont invisibles
// de l'extérieur comme de l'intérieur du bac.
//
// La plaque porteuse occupe toute la longueur de tige lisse disponible : la tête
// vient buter directement contre elle, sans jeu axial vers l'avant.
//
// Le dos plaque à plat contre le bois sur toute sa surface. C'est lui qui encaisse
// le basculement, avec un long bras de levier — les vis ne travaillent qu'en
// cisaillement.
//
// FORME. Le bac n'est pas une boîte : il plonge à gauche, où les lunettes et la
// poche à tabac tiennent debout sur 91 mm, et remonte à droite, où les briquets et
// les câbles n'ont besoin que de 45. Entre les deux, un galbe et non une marche.
// Le crochet à casque passe sous la partie haute, de sorte que la masse pendante à
// gauche et le casque à droite se répondent.
//
// Cette forme est GRATUITE, et c'est ce qui la rend évidente : la pièce
// s'imprimant couchée sur son dos, le plan de la façade EST le plan du plateau.
// Toute silhouette qu'on y dessine sort sans un gramme de support. Ce qui coûte,
// c'est de faire varier la profondeur — et elle est constante ici. Tout le modèle
// est donc bâti sur un profil 2D en élévation, extrudé en profondeur.
//
// IMPRESSION : coque posée sur le dos, insert posé à plat. Aucun support.

include <../../lib/std.scad>
include <BOSL2/std.scad>

// "coque"   : dos + bac nu + crochet          — pièce à imprimer n°1
// "insert"  : le bac à séparations            — pièce à imprimer n°2
// "panier"  : les deux en place, pour regarder
// "gabarit" : réglet de perçage de la deuxième cheville (consommable)
// "montage" : le panier, le bois et les vis, pour vérifier la cinématique
PIECE = "panier";

// --- Chevilles de fixation ----------------------------------------------------
// Tout relevé au réglet sur la cheville en place. Ces cotes ne pilotent que
// l'épaisseur du dos, jamais le reste de la pièce.

// VIS COURTES. C'est le choix de vis qui commande l'épaisseur du dos, et donc
// tout le dessin. Avec la cheville d'origine — fût de 5,2 hors bois, tige lisse
// de 14, tête de 3 — il fallait 26,1 mm d'épaisseur, d'où des renflements de
// fixation massifs et un couloir large à réserver dans l'insert.
//
// Avec une vis dont la tige ne dépasse que de 2,5 mm plus une tête de 3, le dos
// tombe à 8,4. Les renflements deviennent des ondulations.
//
// Si la douille plastique reste en place et dépasse du bois, remettre sa saillie
// dans `col_h` : c'est un recul sec, ajouté à tout le reste.
col_d    = 7.3;   // mm — Ø du fût, si une douille dépasse encore
col_h    = 0;     // mm — de combien elle dépasse du bois. Zéro : vis directement
                  //      dans le bois, ou douille arasée.
vis_d    = 3.4;   // mm — Ø de la tige lisse
vis_l    = 2.5;   // mm — longueur de tige libre entre le bois et la tête
tete_h   = 3.0;   // mm — hauteur de la tête
tete_d   = 8.0;   // mm — Ø de la tête, MAJORÉ volontairement : son logement ne
                  //      guide rien, il ne fait que dégager.

entraxe  = 140;   // mm — écartement des deux chevilles. La seconde est à poser,
                  //      donc cette valeur est libre : assez large pour empêcher
                  //      le vrillage, tout en laissant de la matière entre la
                  //      colonne de fixation et le bord de la pièce.

jeu_col  = 0.8;   // mm — jeu diamétral dans le canal du fût
jeu_vis  = 0.8;   // mm — jeu diamétral dans la fente de tige
jeu_tete = 3.0;   // mm — le logement de tête ne guide rien, il dégage

// --- Dos ----------------------------------------------------------------------

porteur  = vis_l - 0.5;                        // plaque porteuse : toute la tige
                                               // libre. À 2,0 mm elle ne travaille
                                               // qu'en cisaillement sous le poids :
                                               // ~8,5 N sur 50 mm² de section utile,
                                               // soit 0,17 MPa. Sans commune mesure
                                               // avec ce que tient le PLA.
loge_e   = tete_h + 2.0;                       // logement de la tête, large exprès
dos_av   = 2.4;                                // peau avant, celle qui cache tout
dos_e    = col_h + porteur + loge_e + dos_av;  // 8.4 avec des vis courtes

dos_ep   = 2.0;   // mm — épaisseur du dos PARTOUT SAUF au droit des vis. Toute
                  //      l'épaisseur de fixation (26 mm) n'est nécessaire que sur
                  //      la course d'enfilage ; ailleurs une simple plaque suffit,
                  //      et les 23 mm libérés derrière le bac deviennent du
                  //      rangement.
course   = 14;    // mm — descente nécessaire pour verrouiller. Courte parce que la
                  //      tête entre par un TROU, au lieu de remonter depuis le bas
                  //      de la pièce. C'est ce trou qui permet de ne pas épaissir
                  //      tout le dos.
boss_larg = 20;   // mm — diamètre du noyau plein autour de chaque vis. Le
                  //      renflement s'étale au-delà, mais pas trop : c'est son
                  //      emprise qui décide du couloir à tailler dans l'insert.
boss_bas  = 6;    // mm — de combien il descend sous le trou d'entrée
boss_haut = 12;   // mm — et de combien il monte au-dessus du siège
jeu_entree = 1.5; // mm — jeu diamétral du trou de passage de la tête
boss_etale = 20;  // mm — sur quelle distance le renflement de fixation s'éteint
n_galbe    = 34;  // marches du galbe avant, partagées par la peau et l'enveloppe

// La plaque du dos doit tenir ENTIÈREMENT dans la longueur de tige libre :
// c'est elle qui vient se glisser entre le bois et la tête de vis. Plus épaisse,
// elle ne rentre pas, et la fente de tige ne la traverse même pas de part en
// part — il reste de la matière en travers du trou de serrure.
//
// Le piège est qu'elle ne se voit pas : le passage aux vis courtes a fait tomber
// `porteur` de 13,5 à 2,0 pendant que `dos_ep` restait à 3,0, et rien ne l'a
// signalé.
assert(dos_ep <= col_h + porteur,
       "dos_ep depasse la longueur de tige libre : la plaque ne peut pas se glisser sous la tete");

// La grille d'allègement a été retirée : le remplissage du trancheur fait le
// même travail, mieux, et sans piège.

// --- Bac ----------------------------------------------------------------------

larg     = 175;   // mm — largeur hors tout. La zone profonde vaut 85, imposée par
                  //      la poche à tabac debout ; le reste va à la zone peu
                  //      profonde. À 135 elle ne faisait que 47 mm, le crochet en
                  //      prenait 30 et frôlait le galbe. À 175 elle en fait 83 :
                  //      le galbe court sur 45 et le crochet se pose sur le plat.
bac_h    = 95;    // mm — hauteur hors tout du côté PROFOND. Commandée par une
                  //      contrainte de hauteur, pas de volume : le haut des
                  //      lunettes doit rester à moins de 35 mm au-dessus de l'axe
                  //      des colonnettes. Debout elles font 145 et posent sur le
                  //      fond de l'insert, d'où
                  //          145 - (bac_h - fond - insert_fond) - garde_vis = 34
bac_int  = 78;    // mm — profondeur intérieure utile. Gagne 8 mm sur la version
                  //      à dos plein, alors que la pièce en perd 15 hors tout :
                  //      c'est l'épaisseur de fixation qu'on ne traîne plus
                  //      partout.
paroi    = 2.4;   // mm — 6 périmètres à 0,4
cloison  = 2.4;   // mm
fond     = 2.8;   // mm — VOLONTAIREMENT différent de `paroi`. Les deux niveaux
                  //      de plancher valent `fond` et `marche + fond` ; le dessous
                  //      de l'enveloppe intérieure, lui, vaut `paroi` et
                  //      `marche + paroi`. Les faire coïncider posait le fond des
                  //      compartiments EXACTEMENT sur la peau intérieure de la
                  //      coque : deux surfaces confondues sur toute leur étendue,
                  //      et un galbe tangent à ce plan à son sommet. C'est ce qui
                  //      se voyait comme un trou triangulaire là où la profondeur
                  //      change. Les 0,4 mm d'écart rendent l'intersection franche.
r_coin   = 4;     // mm — congé vertical des compartiments

// Débord des prismes de creusement au-delà de l'enveloppe intérieure.
//
// Une cavité bornée PILE sur la paroi qu'elle longe donne deux faces coplanaires,
// que CGAL rend en arêtes non-variété et l'aperçu en trous. Les prismes débordent
// donc franchement : c'est l'enveloppe qui ferme le compartiment de ce côté, et
// elle le fait proprement. 5 mm, pas 0,2 : un petit débord laisserait un éclat
// rasant à la place de la face coplanaire, ce qui n'est pas mieux.
deb      = 5;     // mm

// Le galbe : de combien le dessous remonte côté peu profond, et sur quelle
// emprise horizontale il le fait.
marche   = 46;    // mm — 45 mm de profondeur utile à droite au lieu de 91
galbe    = 45;    // mm — emprise du raccord. Plus il est long, plus le profil
                  //      coule ; trop long, il passe sous la zone profonde et
                  //      crève son fond — d'où l'assertion plus bas.
r_galbe  = 4;     // mm — arrondi des angles rentrants.
                  //      À BORNER SÉVÈREMENT : l'arrondi rentrant se fait par un
                  //      offset(+r) suivi d'un offset(-r), donc la forme est
                  //      DILATÉE de r avant d'être contractée. Le creux du galbe
                  //      se rétrécit vers le haut ; à r = 25 la dilatation le
                  //      rebouchait et le galbe ne montait plus qu'à 23 mm au lieu
                  //      de 46 — sans la moindre erreur. Depuis que les raccords
                  //      sont des courbes à tangente nulle, il n'y a presque plus
                  //      d'angle rentrant à traiter : 4 suffit.
r_ext    = 20;    // mm — arrondi des angles BAS de la silhouette.
                  //      DOIT rester franchement supérieur à `r_av_bac` : le
                  //      galbe avant rétrécit le contour de r_av_bac, et à 14
                  //      contre 15 il effaçait purement et simplement les coins
                  //      — d'où les ruptures de continuité en haut et en bas du
                  //      panier.
r_coin_bac = 6;   // mm — arrondi des DEUX angles HAUTS du bac, et rien d'autre.
                  //
                  //      Il valait `r_ext`, soit 20, et c'était un piège. Le
                  //      contour intérieur, lui, est bâti sur
                  //      `chemin_bac(z_haut + 60)` : ses angles hauts sont 60 mm
                  //      plus haut, donc il monte tout droit à x = ±85,1 et
                  //      TRAVERSAIT l'arrondi extérieur. Au-dessus de z = 84,5 les
                  //      côtés du panier n'existaient plus du tout — mesuré au
                  //      lancer de rayon, la tranche à z = 86 ne contient plus que
                  //      la cloison. C'est ça, les angles en lame de couteau.
                  //
                  //      À 6, la paroi tient ses 2,4 mm jusqu'à z = 89 et ne
                  //      s'éteint que sur les 4 derniers millimètres. C'est aussi
                  //      le rayon des angles hauts du dos, `r_coin_haut` : les deux
                  //      silhouettes se répondent.
                  //
                  //      Le correctif de fond serait de donner au contour intérieur
                  //      les mêmes angles hauts, concentriques. Il y faut un contour
                  //      ouvert par le haut MAIS congé à la bonne hauteur, ce qu'un
                  //      simple offset du contour surélevé ne sait pas produire.
r_av_dos = 3.5;   // mm — arrondi de l'arête avant du dos. Il valait 10 quand le
                  //      dos faisait 26 mm ; à 9,4 c'était plus que l'épaisseur
                  //      elle-même. `extrude_arrondi` le borne désormais, mais
                  //      autant le régler juste.
r_av_bac = 8;     // mm — galbe de la jointure entre les faces perpendiculaires
                  //      au mur et la face avant.
                  //
                  //      IL EST BORNÉ PAR L'ÉPAISSEUR DE L'ARASE, et c'est la
                  //      contrainte qu'on oublie. L'arrondi rentre le contour
                  //      extérieur de `r` à l'approche de la face avant, et le
                  //      contour intérieur de `r - paroi` seulement : les deux ne
                  //      sont donc PAS parallèles, et l'anneau de matière s'amincit
                  //      vers l'avant. À la dernière hauteur où la cavité existe il
                  //      ne vaut plus que
                  //          paroi + f(r-paroi, paroi) - f(r, paroi),
                  //      avec f(r,h) = r - sqrt(2rh - h²).
                  //      À r = 15 : 0,74 mm, sur les 12,6 derniers millimètres de
                  //      la pièce — un fil de couteau, mesuré sur le maillage. La
                  //      paroi avant y tombait même à ZÉRO au-dessus de z = 88,1.
                  //      À r = 8 : 1,12 mm, et seulement sur 5,6 mm.
                  //
                  //      Aller au-delà demanderait une lèvre roulée — la cavité se
                  //      retirant de `r` au droit de l'arase — qui coûterait autant
                  //      de profondeur d'ouverture et se répercuterait sur les
                  //      inserts. Ce n'est pas un réglage, c'est une refonte.
                  //
                  //      Il a longtemps été borné à 2 mm : tant que les cavités
                  //      étaient de simples prismes posés à un niveau, l'arrondi
                  //      rétrécissait le pourtour jusqu'à passer DERRIÈRE elles,
                  //      et le bac débouchait. Depuis que les cavités se
                  //      découpent dans l'enveloppe intérieure, celle-ci suit le
                  //      galbe à `paroi` en retrait : la coque garde son
                  //      épaisseur partout et le galbe peut être aussi ample
                  //      qu'on veut.
                  //
                  //      Effet de bord voulu : l'arase descend de r à l'approche
                  //      de la face avant. Le bord du bac n'est plus une ligne
                  //      droite mais une courbe.

// Le dessus du dos : une CASQUETTE, convexe, qui culmine au milieu.
//
// Une version antérieure portait deux épaules à l'aplomb des vis avec un creux
// entre elles. Structurellement c'était plus honnête — la matière là où l'effort
// passe — mais le profil concave se lit comme deux oreilles. La casquette gagne.
//
// Difficulté : les vis sont à ±70, près des bords, et une casquette y redescend.
// D'où un exposant élevé sur la retombée — la courbe reste haute jusqu'à 80 % de
// la demi-largeur puis plonge sur les derniers millimètres. C'est `dessus_p` qui
// règle ça, et l'assertion plus bas qui le vérifie.
z_som    = 128;   // mm — sommet de la casquette, au milieu. 33 mm au-dessus de
                  //      l'arase : une petite casquette, bornée par le bas par
                  //      l'assertion qui la veut au-dessus du siège des vis.
dessus_p = 8;     // exposant de la retombée. Plus il est grand, plus la casquette
                  //      reste plate longtemps avant de tomber. À 3, elle passait
                  //      sous le siège des vis et l'assertion se déclenchait.
z_fin_g  = 116;   // mm — hauteur au bord gauche
z_fin_d  = 108;   // mm

insert_fond = 1.6;   // mm — fond propre de l'insert. Mince car il ne travaille
                     //      pas : il repose à plat sur celui de la coque.
insert_rebord = 8;   // mm — hauteur du rebord bas de l'insert
insert_paroi  = 2.0; // mm — épaisseur de ce rebord
insert_jeu = 0.5;    // mm — jeu entre l'insert et la coque, par côté. C'est le
                     //      retrait DIFFÉRENTIEL des deux pièces qui compte, pas
                     //      le retrait absolu : même matière, même machine.

prof     = dos_ep + bac_int + paroi;  // profondeur hors tout

// --- Crochet à casque ---------------------------------------------------------
// Sony WH-1000XM5 : ne se plie pas, seulement à plat. L'arceau porte sur toute la
// largeur du bras, d'où une portée large plutôt qu'une patte fine.

croc_larg  = 34;   // mm — largeur de portée sous l'arceau. À 40, le crochet
                   //      occupait 40 des 47 mm du creux laissé par le galbe et
                   //      la silhouette se refermait en boîte. À 30, calé à
                   //      droite, il laisse 18 mm d'air visible entre lui et la
                   //      partie profonde.
                   //      ATTENTION à ne pas confondre les deux directions : le
                   //      bras enfourche l'arceau, donc `croc_larg` est mesuré le
                   //      long de l'ARC du casque, pas de la largeur de sa sangle.
                   //      C'est la longueur d'arc sur laquelle le poids se répartit
                   //      — 34 mm, assez pour ne pas marquer la mousse. La largeur
                   //      de la sangle, elle, se couche selon Y et c'est `croc_l`
                   //      qui la commande.
croc_e     = 14;   // mm — épaisseur du bras au droit du mur. Épais comme les
                   //      parois galbées du panier : un bras mince se lisait
                   //      comme une pièce rapportée, d'un autre vocabulaire.
croc_bas   = 4;    // mm — Z du dessous du bras. Laisse 4 mm d'air sous lui, pour
                   //      qu'il se lise comme suspendu et non comme un bloc posé
                   //      dans le prolongement du fond.
croc_l     = 82;   // mm — longueur du bras. C'est elle qui décide si le casque
                   //      s'assoit ou se perche, et rien d'autre : l'arceau se
                   //      couche en travers du bras, sa SANGLE le long de Y. Le
                   //      XM5 a une sangle d'environ 38 mm. À 70 mm de bras la
                   //      vallée ne faisait que 26 mm du pied du congé au sommet
                   //      de la butée — la sangle reposait sur les deux épaules,
                   //      11 mm au-dessus du fond, et la butée ne retenait plus
                   //      rien. À 82 la vallée fait 42 mm : la sangle descend à
                   //      3,6 mm du fond et il reste 6,4 mm de butée devant elle.
                   //      82 aligne aussi la pointe sur la face avant du panier,
                   //      qui est à 82,4 — le crochet ne dépasse pas.
croc_col_y = 22;   // mm — profondeur de la racine adossée au dos

// Le galbe du crochet. Rien ici n'est un pli : le profil est une suite d'arcs et
// de S qui se rejoignent tangentiellement, comme le dessous du panier rejoint son
// socle. Les quatre valeurs qui suivent décrivent chacune une portion de courbe.
croc_relev = 4;    // mm — de combien le dessous du bras remonte vers la pointe.
                   //      Un S tangent aux deux bouts : le bras s'affine en
                   //      s'éloignant du mur au lieu de filer droit.
croc_r_z   = 10;   // mm — hauteur de la butée au-dessus du fond de gorge
croc_gorge = 20;   // mm — longueur sur laquelle la butée se relève.
                   //      C'est elle qui fixe le porte-à-faux : un S de course
                   //      `croc_gorge` et de hauteur `croc_r_z` a pour pente
                   //      maximale 1,875·croc_r_z/croc_gorge, et cette pente est
                   //      l'angle depuis la verticale à l'impression. Assertion
                   //      plus bas : elle doit rester sous 45°.
croc_conge = 8;    // mm — rayon du quart de cercle qui relève le fond de gorge
                   //      vers la colonne. Remplace le congé de pli : la gorge où
                   //      l'arceau se pose est une vallée continue. Il mange sur
                   //      cette vallée, d'où 8 et non 12 : chaque millimètre de
                   //      congé est un millimètre de moins pour la sangle.
croc_rb    = 4;    // mm — galbe latéral, sur TOUT le pourtour du profil.
                   //      Le bac s'arrondit de `r_av_bac` sur sa face avant ; le
                   //      crochet s'arrondit de même sur ses flancs. Remplace les
                   //      chanfreins à 45°, qui étaient la dernière arête vive de
                   //      la pièce. Borné par deux choses, toutes deux vérifiées
                   //      par assertion : la moitié de l'épaisseur la plus faible
                   //      du bras, et le rayon concave le plus serré du profil.
n_croc     = 16;   // échantillons par portion de courbe

// --- Niveaux ------------------------------------------------------------------
// z = 0 au point le plus bas de la coque, sous la partie profonde.

garde_vis = course + boss_bas;   // 20 mm — de l'arase du bac à l'axe des vis.
                                 //      DÉDUITE, pas choisie : c'est la valeur
                                 //      qui pose la base du renflement exactement
                                 //      sur l'arase. En dessous, le renflement
                                 //      descend dans le bac, la cavité le tranche,
                                 //      et le logement de tête débouche dans la
                                 //      paroi arrière — on voit la vis de
                                 //      l'intérieur.
                                 //      Elle valait 28 pour que le renflement ne
                                 //      descende jamais sous l'arase. C'était un
                                 //      reste de l'époque où le dos faisait 26 mm :
                                 //      à 8,4, ce qu'il en déborde ne coûte qu'un
                                 //      copeau de 5 mm dans l'insert. Et cette
                                 //      garde commandait directement la hauteur de
                                 //      la casquette.
z_haut    = bac_h;               //  95 — arase du bac
z_vis     = z_haut + garde_vis;  // 115 — axe des chevilles, en butée haute
z_top     = z_som;               // 128 — le sommet de la casquette

fond_bas  = fond;                //  2,8 — fond côté profond  → 92,2 mm utiles
fond_haut = marche + fond;       // 48,8 — fond côté peu profond → 46,2 mm utiles

z_entree  = z_vis - course;      //  95 — hauteur du trou de passage de la tête
boss_z0   = z_entree - boss_bas; //  87
boss_z1   = z_vis + boss_haut;   // 127 — le bossage ne fait que 40 mm de haut

// --- Compartiments ------------------------------------------------------------
// Dictés par les objets, pas par une grille régulière.

xi0 = -larg / 2 + paroi;
xi1 =  larg / 2 - paroi;
yi0 = dos_ep;
yi1 = prof - paroi;

x_tab = xi0 + 85;     // largeur de la fente à tabac — le plus large des objets
x_lun = xi0 + 50;     // largeur de la fente à lunettes
x_cab = x_tab + cloison + 42.7;   // frontière câbles / briquets
y_tab = yi0 + 30;     // épaisseur d'une poche à tabac debout
y_cab = yi0 + 42;     // profondeur de la rangée arrière, côté peu profond

// [x0, x1, y0, y1, z du fond]
//
// Le dernier champ place le fond du compartiment, et c'est lui qui répartit les
// objets entre la zone profonde et la zone peu profonde. Les deux niveaux se
// retrouvent dans la coque ET dans l'insert, puisque les deux se calculent d'ici.
//
// TOUS les compartiments au même congé r_coin, et ce n'est pas un choix
// esthétique : l'insert se calcule comme « l'intérieur moins les compartiments ».
// Un compartiment plus arrondi que le pourtour laisse dans le coin un fragment de
// matière détaché du reste, qui sortirait de l'imprimante en morceau libre.
cuves = [
    [xi0,             x_tab, yi0,             y_tab, fond_bas ],  // tabac, DEBOUT
    [xi0,             x_lun, y_tab + cloison, yi1,   fond_bas ],  // lunettes, DEBOUT
    [x_lun + cloison, x_tab, y_tab + cloison, yi1,   fond_bas ],  // stylos, grands objets
    [x_tab + cloison, x_cab, yi0,             y_cab, fond_haut],  // câbles USB
    [x_cab + cloison, xi1,   yi0,             y_cab, fond_haut],  // briquets
    [x_tab + cloison, xi1,   y_cab + cloison, yi1,   fond_haut],  // petites bricoles
];

// Les deux niveaux du bac. La cloison qui les sépare appartient à la COQUE et
// non à l'insert : c'est elle qui retient le socle du côté peu profond, et elle
// raidit le bac en reliant la paroi avant au dos à mi-largeur.
//
// Chaque zone reçoit donc son propre insert. Deux petites pièces plutôt qu'une,
// et un agencement se change zone par zone.
//
// [x0, x1, z du fond]
zones = [
    [xi0,             x_tab, fond_bas ],   // profonde     — 91 mm
    [x_tab + cloison, xi1,   fond_haut],   // peu profonde — 45 mm
];

// --- Outils de construction ---------------------------------------------------

// Extrude un profil 2D dessiné dans le plan de la façade (X horizontal, Y = Z du
// modèle) à travers la profondeur, de y0 à y0 + e.
module en_travers(y0, e) {
    translate([0, y0, 0])
        rotate([90, 0, 0])
            translate([0, 0, -e])
                linear_extrude(e)
                    children();
}

// Extrude un profil 2D depuis y0 sur une épaisseur e, en arrondissant l'arête
// AVANT — celle qui se voit — sur un rayon r.
//
// C'est ici que se joue la marge de manœuvre sur la forme, et je l'avais d'abord
// crue nulle. La pièce s'imprimant dos contre le plateau, la direction de
// construction est la PROFONDEUR : toute surface tournée vers l'avant est un
// toit, et un toit se pose sur la couche du dessous quelle que soit sa pente. On
// peut donc galber l'avant librement. C'est l'arrière qui est contraint — et
// justement il reste plat, puisque c'est la face qui porte sur le bois.
// `n` est imposé de l'extérieur pour que la peau et l'enveloppe intérieure
// partagent EXACTEMENT les mêmes plans de marche. Avec deux échantillonnages
// différents, l'épaisseur de paroi oscille d'une marche à l'autre, et ça se voit
// sur les arêtes.
module extrude_arrondi(y0, e, rr, n = 0) {
    // RAYON BORNÉ PAR L'ÉPAISSEUR. Un rayon supérieur à `e` donne un corps
    // d'épaisseur NÉGATIVE et des tranches rognées de plus que leur propre
    // largeur : la forme se vide par le sommet, sans la moindre erreur. C'est
    // exactement ce qui est arrivé quand le dos est passé de 26 à 9,4 mm sans que
    // r_av_dos suive — les renflements de fixation existaient partout SAUF au
    // droit des vis, donc ne servaient à rien.
    r = min(rr, e - 0.6);
    n = n > 0 ? n : max(4, ceil(r * 2));
    translate([0, y0, 0]) {
        en_travers(0, e - r + EPS) children();
        for (i = [0 : n - 1]) {
            ya = e - r + r * sin(90 * i / n);
            yb = e - r + r * sin(90 * (i + 1) / n);
            en_travers(ya, yb - ya + EPS)
                offset(r = -r * (1 - cos(90 * (i + 1) / n)))
                    children();
        }
    }
}

// Fente verticale à deux bouts ronds, entre les axes z0 et z1. Le bout haut est
// le siège : la vis y porte en contact réparti plutôt que sur une arête.
module fente_2d(l, z0, z1) {
    hull() {
        translate([0, z0]) circle(d = l);
        translate([0, z1]) circle(d = l);
    }
}

// Rectangle à coins arrondis, en 2D.
module rect_2d(x0, x1, y0, y1, r = r_coin) {
    offset(r = r) offset(r = -r)
        polygon([[x0, y0], [x1, y0], [x1, y1], [x0, y1]]);
}

// --- La silhouette ------------------------------------------------------------
//
// Tout le modèle est bâti sur ce profil en élévation, extrudé en profondeur.
// C'est le seul plan où dessiner ne coûte rien : la pièce s'imprimant couchée sur
// son dos, le plan de la façade EST le plan du plateau. En revanche la profondeur
// reste constante — faire varier celle-là ferait des porte-à-faux partout. D'où
// un bas-relief galbé plutôt qu'une surface doublement courbe.

sil_n = 72;   // points d'échantillonnage sur la largeur

// Interpolation à tangente NULLE aux deux extrémités : deux courbes qui se
// rejoignent en un point de raccord y arrivent à plat, donc sans arête.
function liss(t) = t <= 0 ? 0 : t >= 1 ? 1 : t * t * (3 - 2 * t);

// Lissage QUINTIQUE, pour le galbe du dessous. Même départ et même arrivée que
// le cubique, mais la courbure se répartit au lieu de se concentrer aux deux
// bouts — et c'est cela qui compte ici, pas l'allure.
//
// Le rayon de courbure concave MINIMAL du S borne le galbe avant : rétrécir le
// contour de plus que ce rayon fait se replier la surface sur elle-même, et elle
// se troue sur l'arête de la face avant. En cubique
//     R = galbe² / (6·marche) = 45² / (6·46) = 7,3 mm
// pour un galbe avant de 15. En quintique, R monte à 17,2 et la marge revient.
function liss5(t) = t <= 0 ? 0 : t >= 1 ? 1 : t * t * t * (t * (6 * t - 15) + 10);

// Le dessous : plat côté profond, puis un S qui remonte vers la zone peu profonde.
function dessous(x) =
    x <= x_tab           ? 0 :
    x >= x_tab + galbe   ? marche
                         : marche * liss5((x - x_tab) / galbe);

// Le dessus du dos : une casquette convexe, plate au sommet et qui plonge tard.
// Tangente nulle au milieu comme aux deux bords : pas une arête sur tout le
// profil, et les deux bords peuvent être à des hauteurs différentes.
function dessus(x) =
    let (u  = abs(x) / (larg / 2),
         zb = x < 0 ? z_fin_g : z_fin_d)
    zb + (z_som - zb) * liss(1 - pow(u, dessus_p));

// L'arche est libre de sa forme SAUF au droit des vis : il faut de la matière
// au-dessus du siège, sinon le canal débouche par le haut et la vis ne porte
// plus. Rien dans la géométrie ne le signalerait — d'où l'assertion.
assert(dessus( entraxe / 2) >= z_vis + 10,
       "la casquette passe sous le siège de la vis droite : monter z_som, z_fin_d
        ou l'exposant dessus_p");
assert(dessus(-entraxe / 2) >= z_vis + 10,
       "la casquette passe sous le siège de la vis gauche : monter z_som, z_fin_g
        ou l'exposant dessus_p");

// Le galbe ne doit pas passer sous un compartiment profond : il en crèverait le
// fond, et la cavité déboucherait à l'air libre.
assert(x_tab >= xi0, "le galbe démarre à gauche de la zone profonde");
assert(dessous(x_tab + cloison) + paroi <= fond_haut,
       "le galbe remonte trop vite : il perce le socle du côté peu profond");

function sil_bas() = [for (i = [0 : sil_n])
                      let (x = -larg / 2 + i * larg / sil_n) [x, dessous(x)]];

module arrondi() {
    offset(r =  r_ext)   offset(r = -r_ext)       // angles saillants
        offset(r = -r_galbe) offset(r = r_galbe)  // angles rentrants
            children();
}

// Le dos : dessous galbé, dessus en arche.
module silhouette_dos_2d() { polygon(chemin_dos()); }

// Le bac : même dessous, arase plate — c'est le bord où l'on pose la main.
// `ztop` sert à en obtenir une version prolongée vers le haut : l'enveloppe
// intérieure doit rester OUVERTE à l'arase, sinon les compartiments se
// retrouveraient coiffés d'un couvercle.
module silhouette_bac_2d(ztop = 0) {
    polygon(chemin_bac(ztop > 0 ? ztop : z_haut));
}

// L'enveloppe intérieure de la coque : sa peau en retrait de `paroi`.
//
// Les cavités doivent être DÉCOUPÉES DEDANS, et non simplement posées à un
// niveau donné. Le dessous de la coque remonte vers les extrémités — coins
// arrondis, galbe — alors qu'un fond de compartiment est plat : près des coins
// il passait sous la peau et le bac débouchait par en dessous. Rien dans la
// géométrie ne le signalait.
module enveloppe_int_2d(retrait = 0) { polygon(chemin_int(retrait)); }

// --- Les mêmes contours, en CHEMINS DE POINTS ---------------------------------
//
// `offset_sweep` de BOSL2 réclame une liste de points, pas de la géométrie 2D
// opaque. En échange il rend une surface arrondie CONTINUE là où un empilement de
// tranches décalées laisse des marches — et il valide ce qu'on lui demande, au
// lieu de se vider en silence.
//
// Contrainte qui en découle : on ne met des points QUE là où la courbe en a
// besoin. `round_corners` refuse un congé plus large que la place disponible
// entre deux sommets ; échantillonner les parties droites tous les 2,4 mm tuait
// les congés de 20 mm, et il le dit sans ambiguïté.
//
// Seule la COQUE passe par ce chemin. Le bornage de l'insert reste sur
// l'extrusion en tranches : c'est lui qui avait fait exploser la pièce à
// 1708 cm³, et il n'a besoin que d'être conservateur — le jeu de 0,5 mm absorbe
// l'écart entre les deux méthodes.

n_galbe_pts = 20;   // points sur le S du dessous
n_cap_pts   = 24;   // points sur la casquette

r_coin_haut = 6;    // mm — congé des deux coins hauts du dos. Petit PAR
                    //      NÉCESSITÉ : la casquette y arrive par des segments
                    //      courts, un congé plus large n'y tiendrait pas.

function pts_bas() = concat(
    [[-larg / 2, 0], [x_tab, 0]],
    [for (i = [1 : n_galbe_pts - 1]) let (t = i / n_galbe_pts)
        [x_tab + galbe * t, marche * liss5(t)]],
    [[x_tab + galbe, marche], [larg / 2, marche]]
);
function ray_bas() = concat([r_ext, 0], [for (i = [1 : n_galbe_pts - 1]) 0], [0, r_ext]);

function chemin_bac(ztop) =
    round_corners(concat(pts_bas(), [[larg / 2, ztop], [-larg / 2, ztop]]),
                  r = concat(ray_bas(), [r_coin_bac, r_coin_bac]), closed = true);

function chemin_dos() =
    round_corners(
        concat(pts_bas(),
               [[larg / 2, dessus(larg / 2)]],
               [for (i = [n_cap_pts - 1 : -1 : 1])
                   let (x = -larg / 2 + larg * i / n_cap_pts) [x, dessus(x)]],
               [[-larg / 2, dessus(-larg / 2)]]),
        r = concat(ray_bas(), [r_coin_haut],
                   [for (i = [n_cap_pts - 1 : -1 : 1]) 0], [r_coin_haut]),
        closed = true);

function chemin_int(retrait) =
    offset(chemin_bac(z_haut + 60), r = -(paroi + retrait), closed = true);

// Extrusion en profondeur, arête AVANT arrondie, par BOSL2.
module sweep_y(y0, e, r, chemin) {
    translate([0, y0, 0])
        rotate([90, 0, 0])
            translate([0, 0, -e])
                // check_valid ACTIVÉ. Il était désactivé « pour aller plus
                // vite », et c'est précisément le contrôle qui repère un rayon
                // d'arrondi supérieur au rayon de courbure concave du contour —
                // le défaut qui avait troué l'arête de la face avant au galbe.
                offset_sweep(chemin, height = e,
                             bottom = os_circle(r = min(r, e - 0.6)),
                             steps = 12, check_valid = true);
}

// --- Géométrie ----------------------------------------------------------------

// Le trou de serrure d'une cheville, en trois étages superposés dans l'épaisseur
// du bossage : le fût au fond, la tige lisse au milieu, la tête devant.
//
// La tête entre par un TROU percé dans la plaque porteuse, au bas de la course.
// C'est tout le changement : en la faisant auparavant remonter depuis le bord
// inférieur de la pièce, il fallait 26 mm d'épaisseur sur 145 mm de haut. Ici
// 40 mm suffisent, et la pose devient « présenter, pousser, descendre de 20 ».
module canaux(xc) {
    translate([xc, 0, 0]) {
        // 1. le fût, dans une rainure de la face arrière
        en_travers(-EPS, col_h + EPS)
            fente_2d(col_d + jeu_col, z_entree, z_vis);

        // 2. la tige lisse — c'est cette fente qui porte — et le trou par lequel
        //    la tête traverse la plaque au moment de la pose
        en_travers(col_h, porteur) {
            fente_2d(vis_d + jeu_vis, z_entree, z_vis);
            translate([0, z_entree]) circle(d = tete_d + jeu_entree);
        }

        // 3. le logement de la tête, devant la plaque
        en_travers(col_h + porteur, loge_e)
            fente_2d(tete_d + jeu_tete, z_entree, z_vis);
    }
}

// Les deux bossages qui portent la fixation. `marge` les grossit, pour dégager
// l'insert qui doit passer devant.
// Le renflement qui porte la fixation.
//
// Ce n'était d'abord que deux plaques posées sur l'arche : des mottes, avec une
// arête franche tout autour. Ici l'épaisseur du dos passe de `dos_ep` au bord à
// `dos_e` au droit des vis, par une lentille qui s'éteint sur `boss_etale`. Le
// rayon de dilatation suit un cosinus : large en bas, NUL au sommet, donc la
// lentille arrive tangente à sa propre crête au lieu de finir par une marche.
//
// `marge` > 0 donne la forme de dégagement pour l'insert, un peu plus grosse.
// DEUX noyaux distincts, un par vis, et surtout pas leur enveloppe convexe : en
// les reliant, le renflement devenait une seule bosse en travers de toute la
// largeur, et une casquette au-dessus du bac.
module noyau_2d() {
    for (s = [-1, 1]) hull() {
        translate([s * entraxe / 2, boss_z0 + boss_larg / 2]) circle(d = boss_larg);
        translate([s * entraxe / 2, boss_z1 - boss_larg / 2]) circle(d = boss_larg);
    }
}

module bossages(marge = 0) {
    n = 20;
    intersection() {
        union() for (i = [0 : n - 1]) {
            y0 = dos_ep + (dos_e - dos_ep) * i / n;
            y1 = dos_ep + (dos_e - dos_ep) * (i + 1) / n;
            en_travers(y0, y1 - y0 + EPS)
                offset(r = boss_etale * cos(90 * i / n) + marge)
                    noyau_2d();
        }
        sweep_y(0, dos_e + marge, r_av_dos, chemin_dos());
    }
}

// Le dos : la plaque qui porte contre le bois et qui reçoit la fixation.
//
// Elle est PLEINE. Une version antérieure la creusait d'une grille de poches
// d'allègement ; le trancheur fait le même travail avec sa densité de
// remplissage, et sans aucun des pièges qui allaient avec — pontages, cavités
// scellées, et surtout le recul de la grille vis-à-vis du galbe avant, qui mal
// calculé avait supprimé cinq poches et alourdi la coque de 77 cm³ d'un coup.
//
// Conséquence à garder en tête : le volume géométrique mesuré plus bas surestime
// franchement le fil consommé, puisque toute cette épaisseur sera remplie.
module dos() {
    difference() {
        union() {
            sweep_y(0, dos_ep, r_av_dos, chemin_dos());
            bossages();
        }
        for (s = [-1, 1]) canaux(s * entraxe / 2);
    }
}

// Le bac, plein — sa cavité est retirée plus haut, au niveau de la coque.
module bac_plein() {
    sweep_y(dos_ep, prof - dos_ep, r_av_bac, chemin_bac(z_haut));
}

// Les cavités de rangement, découpées dans l'enveloppe intérieure de la coque.
//
// Elles ne doivent PAS être posées à un niveau : le dessous de la coque remonte
// vers les extrémités — coins arrondis, galbe — alors qu'un fond de compartiment
// est plat. Posées à plat, elles passaient sous la peau près des coins et le bac
// débouchait par en dessous.
module cavites() {
    intersection() {
        sweep_y(dos_ep, prof - dos_ep, r_av_bac, chemin_int(0));
        // Arrêtées EXACTEMENT à l'arase, à EPS près. Elles montaient 10 mm
        // au-dessus — un débord de confort contre les faces coplanaires — et
        // tranchaient le renflement de fixation, qui vit précisément là et
        // s'avance dans l'emprise du bac. Dix millimètres de commodité
        // détruisaient la fixation, sans un mot.
        union() for (z = zones)
            translate([0, 0, z[2]])
                linear_extrude(z_haut - z[2] + EPS)
                    rect_2d(z[0] <= xi0 ? xi0 - deb : z[0],
                            z[1] >= xi1 ? xi1 + deb : z[1],
                            yi0 - deb, yi1);
    }
}

// Pas d'évidement sous le socle du côté peu profond : il est PLEIN.
//
// Il a été creux, et c'est ce creux qui perçait la coque — il débouchait par la
// lèvre avant, là où la profondeur change. Refermé proprement, il devenait une
// cavité scellée de 60 cm³ dont le plafond est la face avant : en orientation
// d'impression — dos sur le plateau, donc la profondeur en hauteur — c'est un
// pontage de 80 × 40 mm à 80 mm de haut, et aucun trancheur ne sait poser de
// support à l'intérieur d'un volume fermé. Il s'affaisserait.
//
// Un socle plein coûte 60 cm³ de volume modèle, mais le trancheur les remplit au
// taux qu'on lui donne : une dizaine de grammes de plastique en plus, contre un
// pontage impossible — et la pièce est plus rigide juste au-dessus du crochet.
module bac() {
    difference() { bac_plein(); cavites(); }
}

// --- Insert -------------------------------------------------------------------

// Le contour d'un insert : l'intérieur de sa zone, rétréci du jeu de montage.
module contour_2d(z) {
    offset(r = -insert_jeu) rect_2d(z[0], z[1], yi0, yi1);
}

// La bande périphérique dont est fait le rebord.
module ceinture_2d(z) {
    difference() {
        contour_2d(z);
        offset(r = -insert_paroi) contour_2d(z);
    }
}

// L'insert d'une zone : un bac à séparations d'un seul tenant, qui se pose au
// fond de sa cavité et se retire avec son contenu.
//
// Il porte son propre fond. Une version antérieure n'était qu'un peigne de
// cloisons sans fond, pour ne pas empiler deux fonds : elle économisait 29 g et
// ne touchait le plateau que par la tranche de ses parois — 7 cm² pour toute la
// pièce. Fragile à l'impression comme à la main.
//
// Séparations et coque se calculent toutes deux à partir de la liste `cuves` :
// une seule description, donc pas de divergence possible.
module insert_zone(z) {
    miennes = [for (c = cuves) if (c[0] >= z[0] - EPS && c[1] <= z[1] + EPS) c];
    translate([0, 0, z[2]]) {
        linear_extrude(insert_fond) contour_2d(z);

        // Rebord. Les compartiments extérieurs sont fermés par les parois de la
        // COQUE, pas par l'insert — pas de double paroi, donc pas de place
        // perdue. Mais sans rien, leur contenu glisse dès qu'on soulève l'insert,
        // et le bord libre d'un fond plat mince gondole à l'impression.
        linear_extrude(insert_rebord) ceinture_2d(z);

        // Séparations : la matière entre les compartiments, jusqu'à l'arase.
        linear_extrude(z_haut - z[2])
            intersection() {
                difference() {
                    rect_2d(z[0], z[1], yi0, yi1);
                    for (c = miennes) rect_2d(c[0], c[1], c[2], c[3]);
                }
                contour_2d(z);
            }
    }
}

// Le couloir que l'insert doit laisser libre à l'aplomb des renflements.
//
// L'insert descend VERTICALEMENT : il ne suffit pas de le creuser à la hauteur
// des renflements, il faut dégager toute la colonne au-dessous, sinon il bute
// en cours de descente. Chaque tranche du renflement impose sa propre largeur,
// et le couloir est leur empilement.
module couloir_insert(marge) {
    n = 20;
    for (i = [0 : n - 1]) {
        y0 = dos_ep + (dos_e - dos_ep) * i / n;
        y1 = dos_ep + (dos_e - dos_ep) * (i + 1) / n;
        d  = boss_etale * cos(90 * i / n) + boss_larg / 2 + marge;
        for (s = [-1, 1])
            translate([s * entraxe / 2 - d, y0 - marge, -20])
                cube([2 * d, y1 - y0 + 2 * marge, z_haut + 40]);
    }
}

module insert() {
    difference() {
        // borné à l'enveloppe intérieure comme les cavités de la coque, sinon
        // l'insert dépasse là où la coque remonte
        intersection() {
            extrude_arrondi(dos_ep, prof - dos_ep, r_av_bac,
                            n_galbe)
                enveloppe_int_2d(insert_jeu);
            union() for (z = zones) insert_zone(z);
        }
        couloir_insert(insert_jeu);
    }
}

// --- Crochet ------------------------------------------------------------------

croc_x = 66;      // mm — centré sous la partie plate du dessous, à l'écart du
                  //      galbe, qui se termine vers x = 45

croc_z     = croc_bas;                //  4 — dessous du bras au droit du mur
croc_creux = croc_z + croc_e;         // 18 — fond de gorge, où porte l'arceau
croc_som   = croc_creux + croc_r_z;   // 28 — sommet de la butée
croc_nez   = (croc_som - croc_z - croc_relev) / 2;  // 10 — rayon du demi-rond
croc_haut  = marche + 15;             // 61 — la racine remonte dans la coque
croc_dos   = croc_rb + 2;             //  6 — débord du profil DERRIÈRE le mur

// Passage libre pour l'arceau, entre le fond de gorge et le dessous de la coque.
croc_jour  = marche - croc_creux;     // 28

// La vallée : du pied du congé au sommet de la butée. C'est la cote qui décide si
// le casque s'assoit ou se perche, et la seule du crochet qui dépende vraiment du
// casque. La sangle du XM5 fait ~38 mm et se couche là-dedans.
croc_vallee = (croc_l - croc_nez) - (croc_col_y + croc_conge);   // 42

// Épaisseur du bras à son point le plus fin : juste avant que la butée ne se
// relève, là où le dessous a déjà pris ses `croc_relev`.
croc_mince = croc_creux - croc_z - croc_relev;   // 10

assert(croc_mince > 2 * croc_rb + 1,
       "le bras du crochet est trop fin pour son galbe latéral : baisser croc_rb ou croc_relev, ou épaissir croc_e");
assert(croc_gorge * croc_gorge > 6 * croc_r_z * croc_rb,
       "la butée se relève trop vite pour le galbe latéral : allonger croc_gorge ou baisser croc_r_z");
assert(1.875 * croc_r_z <= croc_gorge,
       "la butée du crochet dépasse 45° de porte-à-faux : allonger croc_gorge ou baisser croc_r_z");
assert(croc_conge > croc_rb,
       "le congé de gorge est plus serré que le galbe latéral : offset_sweep se recoupera");
assert(croc_l - croc_nez - croc_gorge >= croc_col_y + croc_conge,
       "la butée et le congé de gorge se chevauchent : raccourcir croc_gorge ou croc_conge");
assert(croc_vallee >= 40,
       "la vallée est trop courte pour la sangle du casque : allonger croc_l ou raccourcir croc_conge");
assert(croc_l <= prof,
       "le crochet dépasse la face avant du panier : raccourcir croc_l");

// Le profil du crochet, dans le plan (y, z) — QUE des courbes tangentes.
//
// Trois générations : deux morceaux extrudés qui se rencontraient en T sans le
// moindre congé ; puis un fer plié, d'un seul tenant mais à angles filetés de
// congés ; celle-ci n'a plus de pli du tout. Chaque portion arrive tangente à la
// suivante, si bien qu'il ne reste aucun angle à arrondir après coup — le galbe
// est dans la courbe elle-même, pas dans un raccord posé dessus.
function chemin_croc() = concat(
    // Le dos. Il déborde DERRIÈRE le plan du mur ; crochet() recoupe.
    [[-croc_dos, croc_haut], [-croc_dos, croc_z]],
    // Dessous du bras : un S qui le relève doucement vers la pointe, tangent à
    // l'horizontale aux deux bouts. Le bras s'affine en s'éloignant du mur.
    //
    // L'échantillonnage démarre à i = 1, PAS à 0 : le point t = 0 tomberait à
    // y = 0 pile, c'est-à-dire exactement sur le plan de recoupe du dos. Un plan
    // de coupe qui passe par un sommet du profil, ce sont 35 arêtes non-variété
    // au pied du crochet — mesurées. Entre y = 0 et le premier échantillon le S
    // ne monte que de 9 µm : la droite qui vient du dos y est indiscernable.
    [for (i = [1 : n_croc]) let (t = i / n_croc)
        [(croc_l - croc_nez) * t, croc_z + croc_relev * liss5(t)]],
    // Le nez : un demi-rond franc, tangent au dessous en bas et à la butée en
    // haut. La pointe du crochet n'a donc aucune arête, dans aucun plan.
    [for (i = [1 : n_croc - 1]) let (a = 180 * i / n_croc)
        [croc_l - croc_nez + croc_nez * sin(a),
         croc_z + croc_relev + croc_nez * (1 - cos(a))]],
    // La butée redescend en S vers le fond de gorge.
    [for (i = [0 : n_croc]) let (u = i / n_croc)
        [croc_l - croc_nez - croc_gorge * u, croc_som - croc_r_z * liss5(u)]],
    // Le quart de cercle qui relève le fond de gorge vers la colonne. Là aussi
    // on saute le point u = 0 : il est quasi aligné avec la fin de la butée, et
    // trois points alignés dans un balayage décalé donnent des éclats.
    [for (i = [1 : n_croc]) let (u = i / n_croc)
        [croc_col_y + croc_conge * (1 - sin(90 * u)),
         croc_creux + croc_conge * (1 - cos(90 * u))]],
    // La colonne remonte dans la coque.
    [[croc_col_y, croc_haut]]);

module crochet() {
    difference() {
        // Balayé selon X et galbé sur ses DEUX flancs, comme le bac l'est sur sa
        // face avant. C'est ce qui remplace les chanfreins à 45°.
        translate([croc_x, 0, 0])
            rotate([90, 0, 90])
                translate([0, 0, -croc_larg / 2])
                    offset_sweep(chemin_croc(), height = croc_larg,
                                 bottom = os_circle(r = croc_rb),
                                 top    = os_circle(r = croc_rb),
                                 steps = 12, check_valid = true);

        // Le profil déborde de `croc_dos` derrière le plan du mur, et on recoupe
        // ici. Sans ce débord, le galbe latéral ramènerait le dos du profil
        // EXACTEMENT sur y = 0 en bout de balayage : le solide serait tangent à
        // son propre plan de coupe, et une tangence donne des éclats. Le dos doit
        // par ailleurs rester plat — c'est la face qui porte contre le bois, et
        // c'est elle qui repose sur le plateau d'impression.
        translate([-BIG / 2, -BIG, -BIG / 2]) cube(BIG);
    }
}

// PAS de recoupe à plat de la racine — et c'est un correctif, pas un oubli.
//
// Il y en a eu une : « tout ce qui dépasse au-dessus de z = marche et hors de la
// silhouette ». Elle partait d'une idée juste — le dessous de la coque remonte
// près du coin arrondi, la racine ne doit pas pendre dans le vide — mais elle
// coupait à PLAT, en z = marche, alors que ce dessous remonte le long de l'arc de
// `r_ext`. Le coin bas-droit de la silhouette est arrondi de 20 mm : son arc part
// de x = 67,5 à z = 46 et monte jusqu'à x = 87,5 à z = 66. Or le crochet va de
// x = 49 à 83 — il TRAVERSE cet arc. La recoupe lui taillait donc un croissant,
// mesuré au lancer de rayon : 0,25 mm de jour à x = 70, 1,2 à x = 74, 3,4 à
// x = 78, et 5,5 à x = 81. La racine ne tenait plus que par sa moitié gauche.
//
// Sans recoupe, la colonne monte jusqu'à `croc_haut` et rencontre le dessous réel
// de la coque, quel qu'il soit. Ce qui reste au-dessus est noyé dans la coque, et
// `cavites()` s'occupe de ce qui déborderait dans un compartiment. Le prix à payer
// est visible et assumé : la racine comble le bas de l'arc du coin, sur 7,4 mm au
// plus. C'est 7,4 mm d'un arc qui en monte 20, et le crochet est de toute façon
// là — il vaut mieux qu'il s'y raccorde franchement que proprement détaché.
//
// `PIECE=jointure` vérifie en permanence qu'il ne reste pas de jour.
module jointure() {
    difference() {
        intersection() {
            // Au coeur de la colonne, à l'écart du galbe latéral qui la rentre
            // de `croc_rb` sur les bords.
            translate([croc_x - croc_larg / 2 + croc_rb + 1, 1, marche + 0.2])
                cube([croc_larg - 2 * (croc_rb + 1), croc_col_y - 2, 30]);
            // Le croissant : au-dessus de l'arase du socle, hors silhouette.
            difference() {
                translate([-BIG / 2, -BIG / 2, marche]) cube(BIG);
                en_travers(-1, prof + 2) silhouette_bac_2d();
            }
        }
        coque();
    }
}

// --- Assemblages --------------------------------------------------------------

// Les cavités sont retirées au niveau de la COQUE, pas dans le bac.
//
// C'est ce qui a fait qu'un crochet dont la racine est noyée de 15 mm dans la
// coque ressortait à l'intérieur d'un compartiment : le bac faisait sa
// soustraction dans son coin, et rien ne taillait le crochet. Toute pièce qui
// vient se noyer dans la coque doit être creusée par les mêmes cavités.
// TEST DE DESCENTE — doit sortir VIDE.
//
// L'insert descend verticalement dans la coque. Tout point (x, y) où l'insert a
// de la matière et où la coque en a au-dessus de l'arase l'empêche d'entrer :
// il buterait en cours de descente, et pas forcément à la hauteur de l'obstacle.
// C'est ce qui rend le défaut invisible à l'œil — d'où ce test.
//
//   python scripts/scad.py stl vide-poches -D PIECE=descente
//
// Un export vide (OpenSCAD refuse d'écrire) signifie que le montage passe.
module descente() {
    linear_extrude(1)
        intersection() {
            projection() insert();
            projection() intersection() {
                coque();
                translate([-BIG / 2, -BIG / 2, z_haut]) cube(BIG);
            }
        }
}

// TEST DE PEAU — le pavé doit sortir PLEIN, soit 691 mm³.
//
// Il prélève l'épaisseur de la peau avant, au droit de chaque vis, sur toute la
// course du trou de serrure. S'il ressort creux, le logement de tête débouche et
// on voit la vis — de l'extérieur si c'est la peau avant qui manque, de
// l'intérieur du bac si c'est la cavité qui a tranché le renflement.
//
//   python scripts/scad.py stl vide-poches -D PIECE=peau
//
// Deux défauts l'ont déclenché : des prismes de cavité qui montaient 10 mm
// au-dessus de l'arase et tranchaient le renflement, et une garde de vis trop
// faible qui faisait descendre le renflement dans le bac.
module peau() {
    for (s = [-1, 1])
        intersection() {
            coque();
            translate([s * entraxe / 2 - 6, col_h + porteur + loge_e + 0.2,
                       z_entree - 2])
                cube([12, dos_av - 0.8, course + 4]);
        }
}

module coque() {
    difference() {
        union() { dos(); bac_plein(); crochet(); }
        cavites();
    }
}

module panier() {
    union() { coque(); insert(); }
}

// Réglet de perçage de la seconde cheville : se pose sur la première, se met de
// niveau, et donne le point à pointer. Consommable, imprimé à plat.
module gabarit() {
    ep = 4;
    h  = 24;
    difference() {
        translate([-entraxe / 2 - 15, 0, 0])
            cube([entraxe + 30, h, ep]);
        translate([-entraxe / 2, h / 2, -EPS])
            cylinder(d = col_d + jeu_col, h = ep + 2 * EPS);
        translate([entraxe / 2, h / 2, -EPS])
            cylinder(d = 3, h = ep + 2 * EPS);
    }
}

// Le bois et les deux vis, pour vérifier la cinématique. Jamais imprimé.
module vis_reelle() {
    rotate([-90, 0, 0]) {
        cylinder(d = col_d,  h = col_h);
        translate([0, 0, col_h])          cylinder(d = vis_d,  h = vis_l);
        translate([0, 0, col_h + vis_l])  cylinder(d = tete_d, h = tete_h);
    }
}

module montage() {
    panier();
    for (s = [-1, 1])
        translate([s * entraxe / 2, 0, z_vis]) vis_reelle();
    translate([-larg / 2 - 20, -18, -20])
        cube([larg + 40, 18, z_top + 40]);
}

module main() {
    if (PIECE == "gabarit")      gabarit();
    else if (PIECE == "montage") montage();
    // les deux pièces à imprimer
    else if (PIECE == "coque")   coque();
    else if (PIECE == "insert")  insert();
    // sous-ensembles : pour inspecter et pour mesurer où part la matière
    else if (PIECE == "dos")     dos();
    else if (PIECE == "bac")     bac();
    else if (PIECE == "crochet") crochet();
    else if (PIECE == "descente") descente();
    else if (PIECE == "peau")     peau();
    else if (PIECE == "jointure") jointure();
    else                         panier();
}

main();
