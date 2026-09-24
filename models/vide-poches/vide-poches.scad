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
// "gabarit" : réglet de perçage de la deuxième vis, et cale de réglage de sa
//             profondeur (consommable)
// "essai"   : les 10 derniers mm de la coque et de l'insert, côte à côte, pour
//             valider le jeu avant la vraie impression
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
// SPAX 3 × 12 à tête fraisée, relevée au pied à coulisse : tête Ø 6, tige Ø 3.
// Elle remplace une vis à tête cylindrique de Ø 8 × 3, et c'est la hauteur de
// tête qui compte : le cône s'enfonce dans la plaque au lieu de se poser devant.
vis_d    = 3.0;   // mm — Ø de la tige (filet compris)
vis_l    = 1.5;   // mm — tige LIBRE entre le bois et le départ du cône. C'est la
                  //      profondeur de vissage à respecter : la cale du gabarit
                  //      la donne.
tete_d   = 6.0;   // mm — Ø de la tête
tete_cone = (tete_d - vis_d) / 2;   // 1,5 — hauteur du cône, fraisure à 90°
tete_bord = 0.2;  // mm — petit bord cylindrique au-dessus du cône (estimé)
tete_h   = tete_cone + tete_bord;   // 1,7
chanfrein = 0.6;  // mm — la fente de tige est chanfreinée à 45° côté tête : le
                  //      cône y porte sur un anneau de Ø 3,8 à 5,0 au lieu de
                  //      deux arêtes, et se centre de lui-même. Sans lui, le PLA
                  //      se tasserait sous deux lignes de contact.

entraxe  = 124;   // mm — écartement des deux chevilles. La seconde est à poser,
                  //      donc cette valeur est libre : assez large pour empêcher
                  //      le vrillage, tout en laissant de la matière entre la
                  //      colonne de fixation et le bord de la pièce.
                  //      Il a valu 140, les renflements tout au bord. Mais il ne
                  //      restait alors que 7,5 mm entre le noyau et le flanc, et le
                  //      renflement y roulait à 70°. À 124, il reste 15,5 mm : il
                  //      s'y éteint à 37°. C'est ce qui le fait fondre dans la
                  //      plaque au lieu de s'y poser.

jeu_col  = 0.8;   // mm — jeu diamétral dans le canal du fût
jeu_vis  = 0.8;   // mm — jeu diamétral dans la fente de tige
jeu_tete = 3.0;   // mm — le logement de tête ne guide rien, il dégage

// --- Dos ----------------------------------------------------------------------

fente_vis = vis_d + jeu_vis;                   // 3,8 — la fente qui porte
enfonce  = (fente_vis + 2 * chanfrein - vis_d) / 2;   // 1,0 — de combien le
                                               // départ du cône est SOUS la face
                                               // avant de la plaque, tête en siège
porteur  = vis_l - 0.5 + enfonce;              // 2,0 — plaque porteuse : la tige
                                               // libre moins 0,5 de jeu axial, plus
                                               // ce que le cône y enfonce. Elle ne
                                               // travaille qu'en cisaillement sous
                                               // le poids : ~8,5 N sur 50 mm², soit
                                               // 0,17 MPa.
loge_e   = tete_h - enfonce + 1.0;             // 1,7 — la tête ne dépasse plus que
                                               // de 0,7 devant la plaque ; 1 mm de
                                               // jeu devant elle suffit.
dos_av   = 1.6;                                // peau avant, celle qui cache tout :
                                               // quatre passes de buse de 0,4. À 2,4
                                               // elle rendait le renflement plus haut
                                               // d'autant, sans rien cacher de plus.
dos_e    = col_h + porteur + loge_e + dos_av;  // 5,3 — 7,6 avec l'ancienne vis

dos_ep   = 2.0;   // mm — épaisseur du dos PARTOUT SAUF au droit des vis. Toute
                  //      l'épaisseur de fixation (26 mm) n'est nécessaire que sur
                  //      la course d'enfilage ; ailleurs une simple plaque suffit,
                  //      et les 23 mm libérés derrière le bac deviennent du
                  //      rangement.
// LES RENFLEMENTS SONT MINIMAUX. Cachés derrière l'insert, ils n'ont plus à être
// élégants — cinq générations de galbes ont servi tant qu'ils se voyaient. Ce qui
// compte désormais est leur HAUTEUR : tout ce qu'ils ne prennent pas au-dessus
// des vis est rendu à l'inclinaison douce de la paroi arrière de l'insert.
//
// Le noyau est donc concentrique au logement de tête, avec `boss_marge` de
// matière autour, et le raccord à la plaque se fait sur 2 mm.
boss_marge = 1.5; // mm — matière autour du logement de tête, sur tout son tour
boss_larg = tete_d + jeu_tete + 2 * boss_marge;  // 12 — diamètre du noyau
boss_bas  = boss_larg / 2;   // 6 — sous le trou d'entrée : le noyau est un
boss_haut = boss_larg / 2;   // 6 — stade centré sur la course, comme le logement
boss_Dhaut = 2;   // mm — raccord à la plaque au-dessus du noyau
boss_Dbas  = 2;   // mm — et au-dessous
jeu_entree = 1.5; // mm — jeu diamétral du trou de passage de la tête
course_appui = 1.0; // mm — appui de la plaque au-delà du bord de la tête, en siège

// La COURSE, déduite et non plus fixée. La tête entre par un trou, au bas de la
// course ; en haut, elle doit être entièrement sortie de l'aplomb de ce trou,
// plus `course_appui` de plaque tout autour pour porter : rayon du trou + rayon
// de la tête + appui. Elle valait 14, héritage de l'ancienne vis (tête de Ø 8,
// trou de 9,5) : 6 mm de fente, de renflement et de plaque percée en trop, pris
// sur la hauteur libre au-dessus des vis.
course   = ceil((tete_d + jeu_entree) / 2 + tete_d / 2 + course_appui);   // 8
boss_etale = 2;   // mm — raccord à la plaque sur les côtés
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
// Le chanfrein doit laisser la tête porter : ouvert au Ø de la tête, elle
// traverserait la fente.
assert(fente_vis + 2 * chanfrein < tete_d - 0.5,
       "chanfrein trop large : la tete fraisee passerait a travers la fente");
assert(chanfrein < porteur - 0.8, "chanfrein trop profond pour la plaque porteuse");

// La grille d'allègement a été retirée : le remplissage du trancheur fait le
// même travail, mieux, et sans piège.

// --- Bac ----------------------------------------------------------------------

larg     = 181;   // mm — largeur hors tout. La zone profonde vaut 85 UTILES,
                  //      imposée par la poche à tabac debout ; le reste va à la
                  //      zone peu profonde. À 135 elle ne faisait que 47 mm, le
                  //      crochet en prenait 30 et frôlait le galbe.
                  //      175 → 181 quand les inserts ont reçu des parois pleine
                  //      hauteur : quatre fois `ins_ep` (1,5) en travers, rendus
                  //      pour que chaque compartiment garde sa largeur.
bac_h    = 95;    // mm — hauteur hors tout du côté PROFOND. Fixée d'abord par la
                  //      règle « lunettes à moins de 35 mm au-dessus des vis »,
                  //      gardée depuis pour les proportions. Cette règle est
                  //      abandonnée : voir `z_vis`.
bac_int  = 80.5;  // mm — profondeur intérieure de la coque. C'est le CROCHET qui
                  //      la fixe désormais : sa portée de 84 doit tenir dans la
                  //      profondeur hors tout (assertion). L'insert prend 6,8 au
                  //      fond (il passe devant les renflements) et 1,5 à l'avant :
                  //      la fente à lunettes a 41,8 mm, pour des lunettes de 37,6.
                  //      Historique : Gagne 8 mm sur la version
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
r_coin_bac = 8;   // mm — arrondi des DEUX angles HAUTS du bac, et rien d'autre.
                  //
                  //      ÉGAL à `r_av_bac`, et ce n'est pas du goût. L'arrondi
                  //      avant rétrécit le contour de 8 mm en approchant de la
                  //      face avant ; un angle de rayon 6 y tombait à ZÉRO avant
                  //      d'arriver : angle vif sur la face avant, raccord gauche
                  //      entre les deux arrondis. À rayons égaux, l'angle devient
                  //      un coin sphérique, et le bord a le même profil sur les
                  //      flancs qu'à l'avant — le liseré aussi.
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

// Le dessus du dos : il n'y en a plus. Le dos s'arrête à l'arase, comme le bac :
// un seul bord, au même niveau sur tout le pourtour, avec les mêmes congés. Il a
// porté une casquette — deux épaules d'abord, puis une arche convexe — tant que la
// fixation vivait au-dessus de l'arase ; elle est descendue dans le bac.

insert_fond = 1.6;   // mm — fond propre de l'insert. Mince car il ne travaille
                     //      pas : il repose à plat sur celui de la coque.
insert_paroi  = 1.2; // mm — paroi de l'insert, PLEINE HAUTEUR, 3 périmètres à
                     //      0,4. C'est elle qui porte le liseré : son dessus,
                     //      rogné par l'enveloppe extérieure de la coque,
                     //      prolonge les arrondis du bord. Elle remplace le
                     //      rebord bas de 8 mm, qui ne retenait que le fond.
n_incl = 28;         // tranches de la paroi arrière en S (voir `y_arr`)
insert_jeu = 0.3;    // mm — jeu entre l'insert et la coque, par côté. 0,5 donnait
                     //      1 mm de ballant et un filet trop large entre les deux
                     //      couleurs ; 0,3 couvre encore la patte d'éléphant et
                     //      l'écart de cote courant. À valider sur PIECE=essai.
                     //      C'est le
                     //      retrait DIFFÉRENTIEL des deux pièces qui compte, pas
                     //      le retrait absolu : même matière, même machine.

prof     = dos_ep + bac_int + paroi;  // profondeur hors tout
ins_ep   = insert_jeu + insert_paroi; // 1,7 — ce qu'un insert prend à un
                                      //       compartiment, sur chaque paroi

// --- Crochet à casque ---------------------------------------------------------
// Sony WH-1000XM5 : ne se plie pas, seulement à plat. L'arceau porte sur toute la
// largeur du bras, d'où une portée large plutôt qu'une patte fine.

// Vu de CÔTÉ (plan y, z) : une racine en S, un creux, une spatule.
croc_bas   = 4;    // mm — Z du dessous du crochet contre le mur. Laisse 4 mm d'air
                   //      sous lui : il se lit comme suspendu, pas comme posé.
croc_e     = 14;   // mm — du dessous du crochet au fond de gorge, contre le mur
croc_l     = 84;   // mm — portée, du mur au bout de la spatule. Elle doit tenir
                   //      dans la profondeur du panier (assertion). Le XM5 a une
                   //      sangle d'environ 38 mm, qui se couche selon Y dans le creux.
croc_racine = 26;  // mm — longueur du S de la racine. Il part TANGENT au dessous
                   //      du panier, contre le mur, et descend jusqu'au fond de
                   //      gorge : le dessous du panier se prolonge dans le crochet
                   //      comme il se prolonge dans le galbe, sans colonne ni pli.
croc_relev = 4;    // mm — de combien le dessous du bras remonte avant la spatule
croc_r_z   = 10;   // mm — hauteur de la butée : la spatule se relève d'autant
croc_gorge = 20;   // mm — longueur sur laquelle la spatule se relève. Elle fixe le
                   //      porte-à-faux à l'impression : pente maximale
                   //      1,875·croc_r_z/croc_gorge, à garder sous 45° (assertion).
croc_bout  = 5;    // mm — rayon du bout de la spatule : la moitié de l'épaisseur
                   //      du bras, un bout rond et non plus un nez de 20 mm
croc_rb    = 4;    // mm — arrondi des arêtes du dessus du crochet

// Vu de FACE (plan x, z) : la vague. Le flanc droit est celui de la coque,
// prolongé ; le flanc gauche descend en S, en écho au galbe.
croc_v0_ecart = 3; // mm — le flanc gauche part, en haut, à cette distance de la
                   //      fin du galbe (défini plus bas, `croc_v0`)
croc_v1    = 58;   // mm — flanc gauche au bas du S
croc_vz1   = croc_bas + 12;      // 16 — hauteur du bas du S
croc_rv    = 12;   // mm — arrondi du coin bas gauche ; le coin bas droit prend
                   //      `r_ext`, 20, comme le coin bas gauche de la coque
n_croc     = 16;   // échantillons par portion de courbe

// --- Niveaux ------------------------------------------------------------------
// z = 0 au point le plus bas de la coque, sous la partie profonde.

// LA FIXATION EST DANS LE BAC, sous l'arase, et cachée derrière la paroi arrière
// de l'insert.
//
// Les vis sont placées AU PLUS BAS : le renflement droit se pose sur le fond du
// côté peu profond, à `bas_marge` près. Elles ont été déduites de l'arase, par le
// haut, tant que le renflement devait se fondre sous le bord ; caché, il n'a plus
// qu'à laisser la place — tout ce qui est gagné en bas l'est sous le bord, pour le
// S de la paroi arrière de l'insert.
//
// PRIX ACCEPTÉ, par choix explicite : la règle des 35 mm (lunettes à moins de 35
// mm au-dessus des vis) est abandonnée. Les vis sont fixes sur le meuble : plus
// elles sont bas dans la pièce, plus la pièce monte par rapport à elles.
bas_marge = 2;                   // mm — garde entre le bas du renflement droit et le
                                 //      fond du côté peu profond, qu'il surplombe
z_haut    = bac_h;               //  95 — arase du bac
fond_haut_ = marche + fond;      // 48,8 — `fond_haut`, qui n'est défini que plus bas
z_vis     = fond_haut_ + bas_marge + boss_Dbas + boss_bas + course;  // 66,8
garde_vis = z_vis - z_haut;      // −28,2 : les vis sont SOUS l'arase
z_top     = z_haut;               // le sommet de la pièce (plus de casquette)

fond_bas  = fond;                //  2,8 — fond côté profond  → 92,2 mm utiles
fond_haut = marche + fond;       // 48,8 — fond côté peu profond → 46,2 mm utiles

z_entree  = z_vis - course;      //  58,8 — hauteur du trou de passage de la tête
boss_z0   = z_entree - boss_bas; //  52,8 — bas du noyau
boss_z1   = z_vis + boss_haut;   //  72,8 — haut du noyau

assert(boss_z0 - boss_Dbas >= fond_haut + bas_marge - 0.001,
       "le renflement droit descend jusqu'au fond du côté peu profond");
assert(z_haut - (boss_z1 + boss_Dhaut) >= 10,
       "le renflement monte trop haut : la paroi arriere de l'insert n'a plus la place de s'incliner");

// --- Compartiments ------------------------------------------------------------
// Dictés par les objets, pas par une grille régulière.

xi0 = -larg / 2 + paroi;
xi1 =  larg / 2 - paroi;
yi0 = dos_ep;
yi1 = prof - paroi;

// L'insert est un petit bac : sa paroi arrière passe DEVANT les renflements de
// fixation et les cache. Il commence donc à `dos_e` + jeu, là où s'arrête le plus
// épais des renflements, et ses compartiments arrière une paroi plus loin.
yi0_ins = dos_e + insert_jeu + insert_paroi;   // 9,3

// Les cotes de compartiment sont des cotes UTILES, entre parois d'insert : chaque
// face contre la coque (paroi ou cloison) en perd `ins_ep`.
x_tab = xi0 + ins_ep + 85 + ins_ep;   // cloison centrale — la fente à tabac, le
                                      // plus large des objets, fait 85 utiles
x_lun = xi0 + ins_ep + 50;            // fente à lunettes : 50 utiles
y_tab = yi0_ins + 30;  // épaisseur d'une poche à tabac debout, depuis la paroi
                      // arrière de l'insert
y_cab = yi0 + 42;     // profondeur de la rangée arrière, côté peu profond

// [x0, x1, y0, y1] ou [x0, x1, y0, y1, z du fond]
//
// Le fond suit le dessous de la coque, galbe compris (voir `plancher`) — sauf pour
// un compartiment qui donne son propre fond, plat, en cinquième champ.
//
// TOUS les compartiments au même congé r_coin, et ce n'est pas un choix
// esthétique : l'insert se calcule comme « l'intérieur moins les compartiments ».
// Un compartiment plus arrondi que le pourtour laisse dans le coin un fragment de
// matière détaché du reste, qui sortirait de l'imprimante en morceau libre.
cx0 = xi0 + ins_ep;               // bords utiles, entre parois d'insert
cx1 = xi1 - ins_ep;
cxt = x_tab - ins_ep;              // contre la cloison centrale, côté profond
cxc = x_tab + cloison + ins_ep;    // et côté peu profond
cy1 = yi1 - ins_ep;                // contre la paroi avant

// LA CASE À BRIQUETS, au creux du galbe. Contre la cloison, le fond du côté peu
// profond descend presque aussi bas que la zone profonde : c'est la place d'un
// objet haut et étroit, un briquet debout. Son fond suit le galbe, mais il est
// ARRÊTÉ par un replat à `briq_prof` sous le bord : sans lui, la case finirait en
// pointe au pied de la cloison, 90 mm plus bas, et un briquet y disparaîtrait.
// Sous le replat, l'insert ne suit plus le galbe : il reste un vide entre lui et
// la coque.
//
// Un fond entièrement plat a été essayé : il fallait le monter au niveau du galbe
// au bord de la case, soit 65 mm de profondeur seulement.
//
// Une case rectangulaire comme les autres, pas des alvéoles à la forme du
// briquet : vue d'en haut, la grille reste orthogonale.
//
// Bic J26 (Maxi) : 82 × 25 × 15 mm. Clipper Large (CP11) : 74 mm de haut, 16
// d'épaisseur. La largeur tient le plus épais.
briq_l = 17;                        // mm — largeur utile de la case
briq_prof = 72;                     // mm — profondeur du replat sous le bord : le
                                    //      Bic dépasse de 10, le Clipper de 2. À 78,
                                    //      le Clipper disparaît sous le bord.
x_brq  = cxc + briq_l;              // frontière briquets / câbles
x_cab  = (x_brq + cx1) / 2;         // frontière câbles / petits objets : le reste
                                    // du rang arrière, en deux cases égales

z_brq = z_haut - briq_prof;         // 23 — le replat ; le fond de la case est le
                                    //      plus haut du replat et du galbe (~13 mm
                                    //      de replat, puis le galbe)

cuves = [
    [cx0,             cxt,   yi0_ins,         y_tab],  // tabac, DEBOUT
    [cx0,             x_lun, y_tab + cloison, cy1  ],  // lunettes, DEBOUT
    [x_lun + cloison, cxt,   y_tab + cloison, cy1  ],  // stylos, grands objets
    [cxc,             x_brq, yi0_ins,         y_cab, z_brq],  // briquets, DEBOUT
    [x_brq + cloison, x_cab, yi0_ins,         y_cab],  // câbles USB
    [x_cab + cloison, cx1,   yi0_ins,         y_cab],  // petits objets
    [cxc,             cx1,   y_cab + cloison, cy1  ],  // petites bricoles
];

// Les deux niveaux du bac. La cloison qui les sépare appartient à la COQUE et
// non à l'insert : c'est elle qui retient le socle du côté peu profond, et elle
// raidit le bac en reliant la paroi avant au dos à mi-largeur.
//
// Chaque zone reçoit donc son propre insert. Deux petites pièces plutôt qu'une,
// et un agencement se change zone par zone.
//
// [x0, x1]
zones = [
    [xi0,             x_tab],   // profonde     — 92 mm
    [x_tab + cloison, xi1  ],   // peu profonde — 46 mm sur le plat, 92 au pied du galbe
];

// LE FOND, pour la coque comme pour l'insert : le dessous de la coque, rentré de
// `fond` + `retrait`, perpendiculairement à la surface.
//
// Il était à deux niveaux plats, 2,8 et 48,8. Sous le côté peu profond, le galbe
// laissait donc un socle PLEIN de 45 mm de large et jusqu'à 46 de haut — de la
// place perdue. Le fond suit maintenant le S : au pied de la cloison, les
// compartiments câbles et bricoles descendent aussi bas que la zone profonde.
//
// Le contour est prolongé de 20 mm au-delà des flancs, et sans ses arrondis
// d'angle : ce sont les flancs de l'enveloppe intérieure qui bornent sur les
// côtés, et ses arrondis qui bornent aux coins. Lui ne règle que le fond.
function pts_fond() =
    let (b = pts_bas())
    concat([[-larg / 2 - 20, 0]],
           [for (i = [1 : len(b) - 2]) b[i]],
           [[larg / 2 + 20, marche], [larg / 2 + 20, z_haut + 60],
            [-larg / 2 - 20, z_haut + 60]]);
//
// BALAYÉ avec le même arrondi avant que l'enveloppe intérieure, et non extrudé
// droit. L'enveloppe remonte de d(y) en approchant de la face avant ; un fond
// droit, lui, restait à 2,8. À la profondeur où d valait 0,4, les deux —
// décalages du MÊME S, de 2,4 + d et de 2,8 — se confondaient sur tout le galbe :
// 18 arêtes non-variété. Balayés ensemble, ils restent à 0,4 l'un de l'autre.
function chemin_fond(retrait) =
    offset(pts_fond(), r = -(fond + retrait), closed = true);
module plancher(retrait = 0) {
    sweep_y(dos_ep, prof - dos_ep, r_av_bac, chemin_fond(retrait));
}

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

// Le dos a désormais la silhouette du bac, exactement : c'est ce qui met le bord
// au même niveau tout autour.
function chemin_dos() = chemin_bac(z_haut);

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

        // 2. la tige — c'est cette fente qui porte — et le trou par lequel la
        //    tête traverse la plaque au moment de la pose
        en_travers(col_h, porteur) {
            fente_2d(fente_vis, z_entree, z_vis);
            translate([0, z_entree]) circle(d = tete_d + jeu_entree);
        }
        // 2 bis. son chanfrein à 45°, côté tête, sur toute la course : le cône de
        //    la tête fraisée y porte en siège, et y glisse pendant la descente
        //    Son petit bout est 0,1 PLUS LARGE que la fente, et 0,05 plus haut :
        //    une marche de 0,05. Pile à sa largeur, il était coaxial au bout rond
        //    de la fente et tombait exactement sur lui ; plus étroit, il en longeait
        //    les flancs. Dans les deux cas, des arêtes non-variété.
        hull() for (zz = [z_entree, z_vis])
            translate([0, col_h + porteur - chanfrein + 0.05, zz])
                rotate([-90, 0, 0])
                    cylinder(d1 = fente_vis + 0.1,
                             d2 = fente_vis + 2 * (chanfrein + EPS),
                             h = chanfrein - 0.05 + EPS);

        // 3. le logement de la tête, devant la plaque
        en_travers(col_h + porteur, loge_e)
            fente_2d(tete_d + jeu_tete, z_entree, z_vis);
    }
}

// Le renflement qui porte la fixation : la plaque qui GONFLE, pas un dôme posé
// dessus.
//
// Trois générations. D'abord deux plaques posées sur l'arche — des mottes, arête
// franche tout autour. Puis une lentille dont le rayon suivait un cosinus :
// tangente à sa crête, mais VERTICALE à sa base, puisque la dérivée du cosinus est
// nulle en zéro. Le contour ne rétrécissait presque pas en quittant la plaque, la
// paroi en partait donc à 90° : un quart d'ellipse, exactement un dôme posé sur
// une plaque, avec l'angle franc qui va avec.
//
// Ici le profil est un S quintique : à une distance `ρ` au-delà du noyau, la
// surépaisseur vaut (dos_e − dos_ep)·liss5(1 − ρ/boss_etale). Dérivée première ET
// seconde nulles aux deux bouts : la surface quitte la plaque tangentiellement,
// sans rupture de courbure, et arrive de même sur le plateau du noyau. Il n'y a
// plus de ligne où l'œil puisse dire « ici finit la plaque, ici commence la
// bosse ». Pente maximale : 1,875·7,4/20 = 0,69, soit 35°.
//
// IL EST DANS LE BAC. Posé sur la plaque au-dessus de l'arase, il se voyait
// toujours, quelle que soit sa forme — cinq versions l'ont montré. Il vit
// désormais sous l'arase, sur la paroi arrière des compartiments, où les objets le
// cachent. La casquette au-dessus n'est plus qu'une plaque nette.
//
// Il reste construit pour ne rencontrer aucune limite en étant encore épais : il
// s'éteint de lui-même, tangent, avant la paroi latérale du bac, avant l'arase et
// avant le bas. C'est un CHAMP DE HAUTEUR,
//     épaisseur = plaque + surépaisseur × S(ρ) × W(paroi) × W(arase) × W(bas),
// où chaque facteur est un `liss5` — un produit de fonctions lisses est lisse, il
// n'y a de pli nulle part. Il n'est pas retranché par la cavité (voir coque()) :
// il est ajouté après, et se fond dans la paroi arrière.
//
// DEUX noyaux distincts, un par vis, et surtout pas leur enveloppe convexe : en
// les reliant, le renflement devenait une seule bosse en travers de toute la
// largeur, et une casquette au-dessus du bac.

boss_deb   = 0.02;  // mm — la surface part SOUS la face de la plaque.
                    //      Partie pile dessus, elle y coucherait des sommets — la
                    //      famille de coïncidences qui a coûté 35 arêtes au
                    //      crochet. Enfoncée de 0,02 mm, elle la traverse à 2,4°.
boss_bord  = 1.5;   // mm — le renflement est ÉTEINT à cette distance du contour.
                    //      Plus que l'arrondi avant de la plaque, 1,4 : c'est là,
                    //      et là seulement, que la plaque est pleine sur toute son
                    //      épaisseur et peut avaler ce qui reste du renflement.
boss_Dx    = 12;    // mm — extinction vers la paroi latérale du bac. Le noyau
                    //      finit à 13,1 mm de sa face intérieure : 0,5 + 12, il
                    //      reste plein jusqu'au bout.
boss_pas   = 0.5;   // mm — pas de la grille du champ de hauteur

// Distance au noyau (stade vertical, demi-largeur boss_larg/2), en plan.
function boss_dist(x, z, cx) =
    let (zb = boss_z0 + boss_larg / 2,
         zh = boss_z1 - boss_larg / 2,
         v  = z < zb ? zb - z : z > zh ? z - zh : 0)
    max(0, sqrt((x - cx) * (x - cx) + v * v) - boss_larg / 2);



// Pondération d'extinction vers les deux bords : flanc, et casquette mesurée
// NORMALEMENT à sa courbe — pas verticalement, sinon là où elle plonge le
// renflement arriverait encore épais sur le bord.
function boss_W(x, z) =
    liss5((xi1 - abs(x) - 0.5) / boss_Dx)                       // paroi latérale
  * liss5((boss_z1 + boss_Dhaut - z) / boss_Dhaut)              // arase, au-dessus
  * liss5((z - (boss_z0 - boss_Dbas)) / boss_Dbas);             // et au-dessous

// Face avant du dos au point (x, z), pour le renflement centré en cx.
function boss_T(x, z, cx) =
    let (q = boss_dist(x, z, cx) / boss_etale)
    (dos_ep - boss_deb) + (dos_e - dos_ep + boss_deb) * liss5(1 - q) * boss_W(x, z);

// Emprise de la grille. Elle déborde de 0,5 mm au-delà de la silhouette rentrée
// de `boss_bord` qui la découpe : le bord de la grille et la découpe ne doivent
// pas coïncider. Là, la surface est à 1,98 — sous la face de la plaque, cachée.
boss_x_in  = entraxe / 2 - boss_larg / 2 - boss_etale;       // 54
boss_x_out = larg / 2 - boss_bord + 0.5;                     // 89,5
boss_z_lo  = boss_z0 - boss_Dbas - 0.5;                      // 50,3
boss_z_hi  = boss_z1 + boss_Dhaut + 0.5;                     // 75,3

function boss_vnf(s) =
    let (nx = round((boss_x_out - boss_x_in) / boss_pas),
         nz = round((boss_z_hi - boss_z_lo) / boss_pas),
         xa = s > 0 ? boss_x_in : -boss_x_out,
         xb = s > 0 ? boss_x_out : -boss_x_in,
         cx = s * entraxe / 2,
         yb = dos_ep - boss_deb - 0.5,        // fond de la grille, noyé dans la plaque
         xs = [for (i = [0 : nx]) xa + (xb - xa) * i / nx])
    vnf_vertex_array(
        [for (j = [0 : nz]) let (z = boss_z_lo + (boss_z_hi - boss_z_lo) * j / nz)
            concat([for (x = xs) [x, boss_T(x, z, cx), z]],
                   [for (i = [nx : -1 : 0]) [xs[i], yb, z]])],
        col_wrap = true, caps = true);

module renflement(s) { vnf_polyhedron(boss_vnf(s)); }


// La découpe par la silhouette RENTRÉE de `boss_bord` ne tombe que là où le
// renflement est déjà éteint à 1,98, sous la face de la plaque : elle est cachée
// dans la plaque, qui y est pleine sur toute son épaisseur. Aucune arête visible.
module bossages() {
    intersection() {
        union() for (s = [-1, 1]) renflement(s);
        en_travers(dos_ep - boss_deb - 1, dos_e + 2)
            offset(r = -boss_bord) silhouette_dos_2d();
    }
}


// La plaque est une extrusion DROITE. Elle a eu son propre arrondi avant ; mais
// sa face avant est collée au bac, et partout où leurs contours coïncident — les
// flancs, le dessous, et désormais le haut — cet arrondi creusait entre eux une
// rainure de 1,4 mm le long de tout le pourtour arrière.
module plaque() { en_travers(0, dos_ep) silhouette_dos_2d(); }
module canaux_tous() { for (s = [-1, 1]) canaux(s * entraxe / 2); }

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
        union() { plaque(); bossages(); }
        canaux_tous();
    }
}

// Le bac, plein, DOS COMPRIS — sa cavité est retirée plus haut, au niveau de la
// coque.
//
// Un seul balayage depuis le mur, et non la plaque (y de 0 à dos_ep) plus un bac
// balayé à partir de dos_ep. Depuis que la casquette est partie, les deux ont
// EXACTEMENT le même contour, et leur union recollait bout à bout deux prismes à
// faces latérales coplanaires, tout le long du pourtour arrière. CGAL, en
// arithmétique exacte, les fusionnait ; Manifold, en flottants, y laissait 129
// arêtes pincées. Un seul corps, pas de raccord.
module bac_plein() {
    sweep_y(0, prof, r_av_bac, chemin_bac(z_haut));
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
        // le fond : c'est lui qui le fait, pas le prisme, parti 1 mm dessous
        plancher();
        union() for (z = zones)
            translate([0, 0, fond_bas - 1])
                linear_extrude(z_haut - fond_bas + 1 + EPS)
                    zone_2d(z);
    }
}

// L'emprise d'une zone en plan, commune à la cavité et, rentrée du jeu, à
// l'insert : leurs coins sont donc concentriques.
//
// LES QUATRE COINS arrondis de `r_arr` = 5,6 : l'arrondi extérieur de 8 moins la
// paroi de 2,4, donc CONCENTRIQUE aux coins extérieurs — la paroi garde ses 2,4
// jusque dans le coin.
//
// Les coins avant étaient laissés au balayage, et c'était une erreur de lecture.
// L'arrondi avant rétrécit le contour intérieur EN BLOC, il ne l'arrondit pas en
// plan : le flanc intérieur y suit un arc de rayon 8 décalé de la paroi, que la
// face avant coupe net à 44° au lieu de s'y raccorder. L'insert, qui suit la
// coque, en héritait. Dessiné ici, le coin est un vrai quart de cercle, tangent
// au flanc et à la face avant ; le balayage ne l'emporte plus que sur ses tout
// premiers millimètres, où il se confond presque avec lui.
//
// Coins arrière : ils étaient vifs — le prisme passait 5 mm derrière la plaque —,
// et l'insert, arrondi en face d'un coin vif, y aurait laissé un vide.
//
// Le prisme ne dépasse la paroi que de `zone_deb` : assez pour ne pas coïncider
// avec elle, assez peu pour que le congé tombe bien dans le coin.
// 0,1 de PLUS que le rayon concentrique, et pas par goût : à 5,6 pile, le congé
// démarrait exactement dans le plan où démarre l'arrondi avant du balayage
// (y = prof − r_av_bac), et les sommets de l'un tombaient sur les arêtes de
// l'autre — 6 arêtes non-variété au bout de la cloison.
r_arr    = r_av_bac - paroi + 0.1;   // 5,7
zone_deb = 0.05;               // mm
module zone_2d(z) {
    x0 = z[0] <= xi0 ? xi0 - zone_deb : z[0];
    x1 = z[1] >= xi1 ? xi1 + zone_deb : z[1];
    y0 = yi0 - zone_deb;
    hull()
        for (x = [x0 + r_arr, x1 - r_arr], y = [y0 + r_arr, yi1 - r_arr])
            translate([x, y]) circle(r = r_arr);
}

// Sous le côté peu profond, plus de socle plein : le fond suit le galbe.
//
// Il ne faut pas pour autant le CREUSER par-dessous. Un évidement sous le socle
// a existé : il perçait la coque par la lèvre avant, et refermé proprement il
// devenait une cavité scellée de 60 cm³ dont le plafond est la face avant — un
// pontage de 80 × 40 mm à 80 mm de haut en orientation d'impression, sans aucun
// support possible dans un volume fermé. Le fond galbé, lui, est ouvert par le
// haut : couchée sur le dos, la coque le trace comme un simple contour.
module bac() {
    difference() { bac_plein(); cavites(); }
}

// --- Insert -------------------------------------------------------------------

// LA PAROI ARRIÈRE EN S — pour un liseré de même largeur tout autour.
//
// Le corps de l'insert commence à `y_ins`, devant le plus épais des renflements.
// Au-dessus d'eux, la paroi arrière n'a plus rien à contourner : elle recule vers
// le mur et arrive au bord à `y_bnd`, contre la plaque, avec la même épaisseur
// que partout ailleurs. Vu d'en haut, le liseré a la même largeur sur les quatre
// côtés.
//
// Elle a d'abord été un bandeau horizontal épais de toute la fente — un liseré
// arrière trois fois plus large que les autres —, puis un plan incliné sur les
// 7 derniers millimètres, avec deux arêtes que la lumière soulignait. C'est
// maintenant un S (`liss5`) sur toute la hauteur libérée au-dessus des
// renflements : tangent à la verticale en bas ET en haut, sans arête. Les
// renflements, minimaux et descendus au plus bas, lui laissent 20 mm : 17° au
// plus fort de la pente.
//
// La DESCENTE passe : le S ne commence qu'au-dessus des renflements.
y_ins = dos_e + insert_jeu;                     // 5,6 — paroi arrière, en bas
y_bnd = dos_ep + insert_jeu;                    // 2,3 — paroi arrière, au bord
incl_z0 = boss_z1 + boss_Dhaut;                 // 74,8 — haut des renflements
function y_arr(z) = y_ins - (y_ins - y_bnd) * liss5((z - incl_z0) / (z_haut - incl_z0));
// (liss5 est bornée à 0 et 1 : y_ins sous le pied du S, y_bnd au-dessus du bord)
incl_pente_max = 1.875 * (y_ins - y_bnd) / (z_haut - incl_z0);   // au milieu du S
assert(incl_pente_max < 1, "paroi arriere plus inclinee que 45 degres : elle ne s'imprime plus");

// Contrôle, sur le renflement réel au droit de son noyau, que la paroi passe
// devant lui à chaque hauteur, jeu compris.
function boss_crete(z) = boss_T(entraxe / 2, z, entraxe / 2);
assert(min([for (z = [boss_z0 - boss_Dbas : 0.25 : z_haut])
                y_arr(z) - (boss_crete(z) + insert_jeu)]) >= -0.001,
       "la paroi arriere de l'insert mord sur un renflement");

// Le demi-espace qui est devant la face arrière de la paroi (décalé de dy).
function z_incl(i) = incl_z0 + (z_haut - incl_z0) * i / n_incl;
module devant_paroi_arr(dy = 0) {
    rotate([90, 0, 90])
        linear_extrude(BIG, center = true)
            polygon(concat([[y_ins + dy, fond_bas - 2]],
                           [for (i = [0 : n_incl]) [y_arr(z_incl(i)) + dy, z_incl(i)]],
                           [[y_bnd + dy, z_haut + 2], [prof + 5, z_haut + 2],
                            [prof + 5, fond_bas - 2]]));
}

// L'insert d'une zone, en bloc : son contour, devant la paroi arrière. Les
// compartiments y sont creusés ensuite, d'un seul coup pour les deux zones.
//
// Il porte son propre fond. Une version antérieure n'était qu'un peigne de
// cloisons sans fond, pour ne pas empiler deux fonds : elle économisait 29 g et
// ne touchait le plateau que par la tranche de ses parois — 7 cm² pour toute la
// pièce. Fragile à l'impression comme à la main.
//
// Le contour est celui de `zone_2d` rétréci du jeu : coins concentriques à ceux de
// la cavité.
module bloc_zone(z) {
    intersection() {
        translate([0, 0, fond_bas - 1])
            linear_extrude(z_haut - fond_bas + 2)
                offset(r = -insert_jeu) zone_2d(z);
        devant_paroi_arr();
    }
}

// Un compartiment en volume. Ceux du rang arrière suivent le S de la paroi : une
// SEULE peau (`skin`), de son fond à son sommet, par des sections rectangulaires à
// coins arrondis dont le bord arrière recule avec la paroi — les coins restent
// arrondis tout du long, la face avant reste verticale. Mêmes tranches que la
// paroi. Construits en tranches collées bout à bout, ils laissaient des
// micro-arêtes à chaque raccord.
//
// Tous sont bornés par le contour de leur zone rentré d'une paroi d'insert : aux
// angles extérieurs, leur coin devient concentrique à celui de l'insert, et le
// liseré garde sa largeur dans les coins aussi.
function zone_de(c) = zones[c[0] < x_tab ? 0 : 1];
function bas_cuve(c) = len(c) > 4 ? c[4] : fond_bas - 1;
function section_cuve(c, z) =
    let (y0 = c[2] - (y_ins - y_arr(z)))
    path3d(move([(c[0] + c[1]) / 2, (y0 + c[3]) / 2],
                rect([c[1] - c[0], c[3] - y0], rounding = r_coin)), z);
module cuve_3d(c) {
    haut = z_haut + 1;
    intersection() {
        translate([0, 0, fond_bas - 1])
            linear_extrude(haut - fond_bas + 1)
                offset(r = -(ins_ep - 0.05)) zone_2d(zone_de(c));
        if (c[2] > yi0_ins + EPS)
            translate([0, 0, bas_cuve(c)])
                linear_extrude(haut - bas_cuve(c)) rect_2d(c[0], c[1], c[2], c[3]);
        else
            skin(concat([section_cuve(c, bas_cuve(c))],
                        [for (i = [0 : n_incl]) section_cuve(c, z_incl(i))],
                        [section_cuve(c, haut)]),
                 slices = 0);
    }
}

// L'insert : deux petits bacs, un par zone, que la cloison centrale de la coque
// sépare. Quatre bornages :
//
// 1. l'enveloppe intérieure de la coque moins le jeu — sinon il dépasse là où la
//    coque se resserre (coins arrondis, galbe, arrondi avant) ;
// 2. l'enveloppe EXTÉRIEURE de la coque, `bac_plein` — c'est elle qui fait le
//    liseré. Le bord de la coque est arrondi de 8 mm ; ses parois de 2,4 n'en
//    portent que la naissance. Rogné par la même surface, le dessus des parois
//    d'insert en prend la suite : un seul galbe, en deux couleurs, coupé par le jeu ;
// 3. le fond de la coque, relevé du jeu : l'insert l'épouse, galbe compris ;
// 4. les compartiments, creusés dans l'enveloppe rentrée de jeu + paroi, pour que
//    la paroi d'insert garde son épaisseur là où la coque se resserre, et au-dessus
//    du fond relevé de jeu + `insert_fond`.
//
// L'insert peu profond, à fond galbé, NE S'IMPRIME PAS SANS SUPPORT : debout sur
// son point bas, la partie plate de son fond est un plafond à 46 mm du plateau.
// Supports sous le fond seulement — la face cachée, posée dans la coque.
//
// Séparations et parois viennent toutes de la liste `cuves` : l'insert est « son
// contour moins ses compartiments ». Une seule description, pas de divergence.
module insert() {
    intersection() {
        extrude_arrondi(dos_ep, prof - dos_ep, r_av_bac, n_galbe)
            enveloppe_int_2d(insert_jeu);
        bac_plein();
        plancher(insert_jeu);
        difference() {
            union() for (z = zones) bloc_zone(z);
            intersection() {
                // 0,05 de moins que la paroi : sur les flancs droits, c'est la
                // cuve qui fait la paroi, et les deux faces ne coïncident pas
                extrude_arrondi(dos_ep, prof - dos_ep, r_av_bac, n_galbe)
                    enveloppe_int_2d(ins_ep - 0.05);
                plancher(insert_jeu + insert_fond);
                union() for (c = cuves) cuve_3d(c);
            }
            sous_briquets();
        }
    }
}

// Sous le replat de la case à briquets, l'insert ne descend plus vers le galbe :
// tout ce qui est plus bas est ôté, depuis le milieu de la cloison jusqu'à la
// face de la case côté galbe, et de l'arrière jusqu'à sa face avant. La paroi qui
// la sépare des petites bricoles, devant, descend, elle, jusqu'au galbe : c'est le
// fond de la case voisine.
module sous_briquets() {
    translate([x_tab + cloison / 2, -1, fond_bas - 5])
        cube([x_brq - (x_tab + cloison / 2), y_cab + 1,
              (z_brq - insert_fond) - (fond_bas - 5)]);
}

// --- Crochet ------------------------------------------------------------------

croc_v0    = x_tab + galbe + croc_v0_ecart;   // 47,8 — flanc gauche, en haut
croc_creux = croc_bas + croc_e;       // 18 — fond de gorge, où porte l'arceau
croc_jour  = marche - croc_creux;     // 28 — passage de l'arceau sous le panier
croc_ys1   = croc_l - croc_bout;      // 79 — fin de la spatule, départ du bout rond
croc_ys0   = croc_ys1 - croc_gorge;   // 59 — pied de la spatule
croc_zc    = croc_creux + croc_r_z - croc_bout;   // 23 — centre du bout rond
croc_mince = croc_creux - croc_bas - croc_relev;  // 10 — le bras au plus fin

// Le creux, mesuré à mi-hauteur de la butée : c'est là que la sangle s'assoit.
function croc_mi(t0) = [for (i = [0 : 200]) let (t = i / 200)
                            if (1 - liss5(t) <= t0) t][0];
croc_vallee = (croc_ys0 + croc_gorge / 2)
            - croc_racine * croc_mi((croc_r_z / 2) / (marche - croc_creux));   // ~50

assert(1.875 * croc_r_z <= croc_gorge,
       "la spatule du crochet depasse 45 degres de porte-a-faux : allonger croc_gorge ou baisser croc_r_z");
assert(croc_racine < croc_ys0 - 20, "la racine et la spatule se chevauchent : le creux disparait");
assert(croc_vallee >= 40, "le creux est trop court pour la sangle du casque");
assert(croc_l <= prof, "le crochet depasse la face avant du panier : raccourcir croc_l");
assert(croc_mince >= 2 * croc_bout - 0.001, "le bras est plus mince que son bout rond");

// Le dessous du panier, là où le crochet le rejoint : plat, puis l'arc du coin.
function croc_dessous(x) =
    let (xc = larg / 2 - r_ext)
    x > xc ? marche + r_ext - sqrt(max(0, r_ext * r_ext - (x - xc) * (x - xc)))
           : dessous(x);

// La vague : flanc gauche et flanc droit, vus de face, à la hauteur z.
function croc_xg(z) =
    z >= marche  ? croc_v0 :
    z >= croc_vz1 ? croc_v0 + (croc_v1 - croc_v0) * liss5((marche - z) / (marche - croc_vz1))
                  : croc_v1 + croc_rv
                    - sqrt(max(0, croc_rv * croc_rv - (z - croc_vz1) * (z - croc_vz1)));
function croc_xd(z) =
    z >= croc_bas + r_ext ? larg / 2 - 0.01
                          : larg / 2 - r_ext
                            + sqrt(max(0, r_ext * r_ext - (z - croc_bas - r_ext) * (z - croc_bas - r_ext)));

// Le profil de côté, en deux fonctions de y : le dessus et le dessous.
function croc_spat(y) = croc_r_z * liss5((y - croc_ys0) / croc_gorge);
function croc_haut_brut(x, y) =
    y <= croc_racine
        ? croc_creux + (croc_dessous(x) + 0.3 - croc_creux) * (1 - liss5(y / croc_racine))
        : y <= croc_ys1 ? croc_creux + croc_spat(y)
                        : croc_zc + sqrt(max(0, croc_bout * croc_bout - (y - croc_ys1) * (y - croc_ys1)));
function croc_bas_brut(y) =
    y <= croc_ys1 ? croc_bas + croc_relev * liss5(max(y, 0) / croc_ys0) + croc_spat(y)
                  : croc_zc - sqrt(max(0, croc_bout * croc_bout - (y - croc_ys1) * (y - croc_ys1)));

// LES ARÊTES, arrondies de `croc_rb` le long des deux flancs de la vague — DESSUS
// ET DESSOUS. Le dessous ne l'était pas : la coupe du bras montrait un dessus
// galbé posé sur deux angles vifs à 90°, et c'est ce qui faisait lire le crochet
// comme plus dur que la coque.
//
// LE CONGÉ SE PLACE PAR SON CENTRE, et non en remontant le dessous d'une quantité
// qui dépendrait de la distance au flanc. Les flancs de la vague sont très
// inclinés dans la hauteur du bras — l'arc de `r_ext` y rentre de 1,4 mm par
// millimètre —, et deux méthodes plus simples ont échoué là-dessus :
//
//   1. distance mesurée à plat, à la hauteur de départ : l'arrondi remontait de
//      4 mm au-dessus d'un flanc qui, 4 mm plus haut, s'était écarté de 3. Il
//      restait une MARCHE de 3 mm au lieu d'un congé, visible en coupe ;
//   2. la même distance, mais mesurée à la hauteur d'arrivée : c'est une équation
//      implicite, résolue par itérations. Elles OSCILLENT près du flanc — sauts
//      de pente de 6 par dixième de millimètre, mesurés — et ces oscillations se
//      lisaient comme des fissures le long du dessous du bras.
//
// Ici, le congé est le cercle de rayon r tangent aux DEUX faces : on résout pour
// son centre, ce qui est exact pour un flanc droit et sans la moindre itération.
// À distance `p` du centre, en projection, le creux vaut r − √(r² − p²).
//
// Il est PLAFONNÉ à sa valeur au point de tangence avec le flanc : au-delà, le
// cercle repasserait devant le flanc et le champ de hauteur mordrait dans la
// pièce. Plafonné, il reste en retrait, et c'est le flanc qui prend le relais.
croc_dz = 0.05;   // mm — pas de la dérivée numérique des flancs
croc_pmax = 4;    // pente maximale retenue : au-delà le flanc est si couché que
                  //      le congé s'y aplatit de lui-même

function croc_pd(z) = max(-croc_pmax, min(croc_pmax,
    (croc_xd(z + croc_dz) - croc_xd(z - croc_dz)) / (2 * croc_dz)));
function croc_pg(z) = max(-croc_pmax, min(croc_pmax,
    (croc_xg(z + croc_dz) - croc_xg(z - croc_dz)) / (2 * croc_dz)));
function croc_creu(u, r) = u <= 0 ? 0 : u >= r ? r : r - sqrt(r * r - u * u);

// `v` = +1 pour le dessous (le congé creuse vers le haut), −1 pour le dessus.
function croc_conge(x, z0, r, v) =
    r <= 0 ? 0 :
    let (p = croc_pd(z0), q = croc_pg(z0),
         sp = sqrt(1 + p * p), sq = sqrt(1 + q * q),
         cd = croc_xd(z0) + v * r * p - r * sp,   // centres des deux congés
         cg = croc_xg(z0) + v * r * q + r * sq,
         td = max(0, min(r, r - v * r * p / sp)),  // creux au point de tangence
         tg = max(0, min(r, r + v * r * q / sq)))
    max(min(croc_creu(x - cd, r), td), min(croc_creu(cg - x, r), tg));

// Le rayon est borné par la DEMI-ÉPAISSEUR locale : au bout de la spatule la
// section s'annule, et deux congés de 4 s'y traverseraient. Ainsi borné, chacun
// ne creuse au plus que jusqu'à 0,1 mm du milieu — ils ne se rencontrent jamais.
function croc_rloc(x, y) = min(croc_rb, (croc_haut_brut(x, y) - croc_bas_brut(y)) / 2 - 0.1);

// Le dessus s'arrondit PARTOUT SAUF là où il est encore collé au dessous du
// panier : l'arrondi y creuserait une rainure entre les deux. L'extinction porte
// sur le RAYON, et non sur le creux : un rayon qui décroît reste un congé, un
// creux rogné ne l'est plus.
function croc_haut(x, y) =
    let (z0 = croc_haut_brut(x, y),
         f = liss5((croc_dessous(x) - z0) / croc_rb))
    z0 - croc_conge(x, z0, croc_rloc(x, y) * f, -1);

function croc_bas_y(x, y) =
    let (z0 = croc_bas_brut(y))
    z0 + croc_conge(x, z0, croc_rloc(x, y), 1);

// Le crochet est l'INTERSECTION de deux formes : ce champ de hauteur, qui porte le
// profil de côté, et le prisme de la vague, qui porte la vue de face.
croc_pas = 0.5;
function croc_vnf() =
    let (xa = croc_v0 - 1, xb = larg / 2 + 1,
         ya = -3, yb = croc_l - 0.05,
         nx = round((xb - xa) / croc_pas), ny = round((yb - ya) / croc_pas),
         xs = [for (i = [0 : nx]) xa + (xb - xa) * i / nx])
    vnf_vertex_array(
        [for (j = [0 : ny]) let (y = ya + (yb - ya) * j / ny)
            // même sens de parcours que les renflements : dessous, puis dessus
            concat([for (x = xs) [x, y, croc_bas_y(x, y)]],
                   [for (i = [nx : -1 : 0]) [xs[i], y, croc_haut(xs[i], y)]])],
        col_wrap = true, caps = true);

module croc_vague_2d() {
    polygon(concat(
        [[croc_v0, z_haut]],
        [for (i = [0 : 2 * n_croc]) let (z = marche - (marche - croc_bas) * i / (2 * n_croc))
            [croc_xg(z), z]],
        [for (i = [0 : n_croc]) let (z = croc_bas + r_ext * i / n_croc) [croc_xd(z), z]],
        [[larg / 2 - 0.01, z_haut]]));
}

module crochet() {
    difference() {
        intersection() {
            vnf_polyhedron(croc_vnf());
            en_travers(-4, croc_l + 5) croc_vague_2d();
        }
        // Recoupe au plan du mur : le champ déborde de 3 mm derrière lui, pour que
        // la recoupe ne passe par aucun de ses sommets.
        translate([-BIG / 2, -BIG, -BIG / 2]) cube(BIG);
    }
}

// TEST DE JOINTURE — doit sortir VIDE.
//
// Contre le mur, la racine du crochet doit remplir tout l'espace sous le panier,
// jusqu'à son dessous réel — plat, puis l'arc du coin bas droit. Une recoupe à
// plat de la racine y a laissé jusqu'à 5,5 mm de jour, invisible de face. Le test
// prend une tranche de 1,5 mm contre le mur, hors de la silhouette de la coque et
// dans l'emprise de la vague, et vérifie que la coque (crochet compris) la remplit.
//
//   python scripts/scad.py stl vide-poches -D PIECE=jointure
module jointure() {
    difference() {
        intersection() {
            union() {
                translate([croc_v1 + croc_rv + 1, 0.5, croc_bas + r_ext])
                    cube([larg / 2 - croc_rb - 1 - (croc_v1 + croc_rv + 1), 1.5, 60]);
                translate([croc_xg(marche - 14) + croc_rb, 0.5, marche - 14])
                    cube([croc_v1 + croc_rv - (croc_xg(marche - 14) + croc_rb), 1.5, 60]);
            }
            difference() {
                translate([-BIG / 2, -BIG / 2, croc_bas]) cube(BIG);
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
    linear_extrude(1) union() {
        // le corps, devant les renflements : en projection, comme avant
        intersection() {
            projection() intersection() {
                insert();
                translate([-BIG / 2, y_ins - 0.01, -BIG / 2]) cube(BIG);
            }
            projection() union() {
                intersection() {                       // au-dessus de l'arase
                    coque();
                    translate([-BIG / 2, -BIG / 2, z_haut]) cube(BIG);
                }
                intersection() {                       // les renflements, dans le bac
                    bossages();
                    translate([-BIG / 2, dos_ep + 0.05, -BIG / 2]) cube(BIG);
                }
            }
        }
        // le haut incliné de la paroi arrière, qui passe AU-DESSUS des
        // renflements : il ne bute que si un renflement a de la matière plus haut
        // que lui à son aplomb. Test par niveaux : ce qui est sous zk contre ce
        // qui est au-dessus.
        for (zk = [incl_z0 - 1 : 0.5 : z_haut])
            intersection() {
                projection() intersection() {
                    insert();
                    translate([-BIG / 2, -BIG + y_ins - 0.01, -BIG + zk]) cube(BIG);
                }
                projection() intersection() {
                    bossages();
                    translate([-BIG / 2, dos_ep + 0.05, zk]) cube(BIG);
                }
            }
    }
}

// TEST DE PEAU — le pavé doit sortir PLEIN : 12 × 0,8 × (course + 4), deux fois, soit
// 230 mm³ avec la course de 8.
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

// Les renflements sont ajoutés APRÈS le creusement des cavités, et c'est voulu.
// Retranchés avec le reste, ils étaient tranchés à plat à l'arase et
// surplombaient la paroi arrière du bac : une arête vive et un surplomb. Ajoutés
// après, ils plongent dans le bac et s'y fondent dans la paroi arrière. L'insert
// n'en souffre pas : son couloir est taillé sur toute la hauteur.
// Les canaux, eux, viennent en tout dernier : ils traversent plaque ET renflement.
module coque() {
    difference() {
        union() {
            difference() {
                union() { bac_plein(); crochet(); }   // le dos est dans bac_plein
                cavites();
            }
            bossages();
        }
        canaux_tous();
    }
}

module panier() {
    union() { coque(); insert(); }
}

// Réglet de perçage de la seconde cheville : se pose sur la première, se met de
// niveau, et donne le point à pointer. Consommable, imprimé à plat.
// Le gabarit : un réglet qui se coiffe sur la tête de la première vis et marque
// l'avant-trou de la seconde, plus une CALE qui règle leur profondeur.
//
// La profondeur de vissage n'est plus libre : la plaque se glisse entre le bois
// et le cône avec 0,5 mm de jeu axial seulement. La cale est une fourche
// d'épaisseur `cale_e` : glissée sous la tête contre le bois, on visse jusqu'à ce
// que le cône vienne la pincer. Son épaisseur tient compte de ce que le cône
// porte sur les bords de la fourche, pas sur la tige.
cale_fente = vis_d + 0.4;                           // 3,4
cale_e     = vis_l + (cale_fente - vis_d) / 2;      // 1,7
module gabarit() {
    ep = 4;
    h  = 24;
    difference() {
        union() {
            translate([-entraxe / 2 - 15, 0, 0])
                cube([entraxe + 30, h, ep]);
            translate([entraxe / 2 + 15 - EPS, h / 2 - 6, 0])
                cube([24, 12, cale_e]);
        }
        translate([-entraxe / 2, h / 2, -EPS])
            cylinder(d = tete_d + jeu_col, h = ep + 2 * EPS);   // sur la tête
        translate([entraxe / 2, h / 2, -EPS])
            cylinder(d = 2, h = ep + 2 * EPS);                  // avant-trou Ø 2
        translate([entraxe / 2 + 25, h / 2 - cale_fente / 2, -EPS])
            cube([20, cale_fente, ep]);                         // la fourche
    }
}

// Le bois et les deux vis, pour vérifier la cinématique. Jamais imprimé.
module vis_reelle() {
    rotate([-90, 0, 0]) {
        cylinder(d = col_d,  h = col_h);
        translate([0, 0, col_h])          cylinder(d = vis_d,  h = vis_l);
        translate([0, 0, col_h + vis_l])  cylinder(d1 = vis_d, d2 = tete_d, h = tete_cone);
        translate([0, 0, col_h + vis_l + tete_cone]) cylinder(d = tete_d, h = tete_bord);
    }
}

module montage() {
    panier();
    for (s = [-1, 1])
        translate([s * entraxe / 2, 0, z_vis]) vis_reelle();
    translate([-larg / 2 - 20, -18, -20])
        cube([larg + 40, 18, z_top + 40]);
}

// PIÈCE D'ESSAI — les `essai_h` derniers millimètres de la coque et de l'insert,
// côte à côte, posés sur leur coupe. Un quart d'heure d'impression pour valider
// `insert_jeu` avant d'engager 400 cm³ : l'anneau d'insert doit entrer dans
// l'anneau de coque sans forcer et sans ballotter. Imprimer les deux dans la
// matière et sur la machine de la vraie pièce.
essai_h = 10;   // mm
module essai() {
    translate([0, 0, -(z_haut - essai_h)]) {
        intersection() {
            coque();
            translate([-BIG / 2, -BIG / 2, z_haut - essai_h]) cube(BIG);
        }
        translate([0, -(prof + 8), 0])
            intersection() {
                insert();
                translate([-BIG / 2, -BIG / 2, z_haut - essai_h]) cube(BIG);
            }
    }
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
    else if (PIECE == "essai")    essai();
    else                         panier();
}

main();
