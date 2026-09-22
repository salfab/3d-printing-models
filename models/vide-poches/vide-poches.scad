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

dos_ep   = 3.0;   // mm — épaisseur du dos PARTOUT SAUF au droit des vis. Toute
                  //      l'épaisseur de fixation (26 mm) n'est nécessaire que sur
                  //      la course d'enfilage ; ailleurs une simple plaque suffit,
                  //      et les 23 mm libérés derrière le bac deviennent du
                  //      rangement.
course   = 20;    // mm — descente nécessaire pour verrouiller. Courte parce que la
                  //      tête entre par un TROU, au lieu de remonter depuis le bas
                  //      de la pièce. C'est ce trou qui permet de ne pas épaissir
                  //      tout le dos.
boss_larg = 20;   // mm — diamètre du noyau plein autour de chaque vis. Le
                  //      renflement s'étale au-delà, mais pas trop : c'est son
                  //      emprise qui décide du couloir à tailler dans l'insert.
boss_bas  = 8;    // mm — de combien il descend sous le trou d'entrée
boss_haut = 12;   // mm — et de combien il monte au-dessus du siège
jeu_entree = 1.5; // mm — jeu diamétral du trou de passage de la tête
boss_etale = 20;  // mm — sur quelle distance le renflement de fixation s'éteint
n_galbe    = 34;  // marches du galbe avant, partagées par la peau et l'enveloppe

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
fond     = 2.4;   // mm
r_coin   = 4;     // mm — congé vertical des compartiments

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
r_ext    = 20;    // mm — arrondi des angles saillants de la silhouette.
                  //      DOIT rester franchement supérieur à `r_av_bac` : le
                  //      galbe avant rétrécit le contour de r_av_bac, et à 14
                  //      contre 15 il effaçait purement et simplement les coins
                  //      — d'où les ruptures de continuité en haut et en bas du
                  //      panier.
r_av_dos = 10;    // mm — arrondi de l'arête avant du dos. Généreux : c'est lui
                  //      qui effile la crête de l'arche en une nervure au lieu
                  //      d'une tranche de 26 mm.
r_av_bac = 15;    // mm — galbe de la jointure entre les faces perpendiculaires
                  //      au mur et la face avant. Large, pas un simple bourrelet.
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

// Le dessus du dos : DEUX ÉPAULES au droit des vis, et un creux entre elles.
//
// L'arche culminait d'abord au milieu, alors que les vis sont sur les côtés : la
// matière était là où il n'y a pas d'effort, et les bouts ne servaient à rien.
// En portant les points hauts sur les vis, le dessin devient structurellement
// honnête — et il autorise un entraxe bien plus large, donc une bien meilleure
// tenue au vrillage.
x_bosse  = entraxe / 2;   // les épaules sont à l'aplomb des vis, par construction
z_creux  = 120;   // mm — le creux entre les deux épaules. Peu marqué : plus
                  //      bas, les épaules se lisent comme deux oreilles au
                  //      lieu d'une ligne continue.
z_epaul_g = 142;  // mm — épaule gauche
z_epaul_d = 136;  // mm — épaule droite, plus basse : la pièce s'effile vers le
                  //      crochet, dans le même sens que le fond qui remonte
z_fin_g  = 124;   // mm — et la retombée aux deux extrémités
z_fin_d  = 112;   // mm

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
                   //      partie profonde. L'arceau du XM5 fait ~32 mm de large :
                   //      30 mm de portée restent une assise pleine.
croc_e     = 13;   // mm — épaisseur du bras. Épais comme les parois galbées
                   //      du panier : un bras mince se lisait comme une pièce
                   //      rapportée, d'un autre vocabulaire.
croc_bas   = 4;    // mm — Z du dessous du bras. Laisse 4 mm d'air sous lui, pour
                   //      qu'il se lise comme suspendu et non comme un bloc posé
                   //      dans le prolongement du fond.
croc_l     = 70;   // mm — longueur du bras
croc_ame   = 14;   // mm — épaisseur de l'âme qui relie le bras au dos
croc_col_y = 22;   // mm — profondeur de la racine adossée au dos
croc_rc    = 12;    // mm — congé des plis RENTRANTS. C'est lui qui fait du crochet
                   //      un fer plié plutôt que deux pièces soudées.
croc_rv    = 6;    // mm — arrondi des arêtes saillantes
croc_ch    = 3;    // mm — chanfrein des arêtes de portée
croc_r_y   = 16;   // mm — emprise de la rampe de retenue
croc_r_z   = 12;   // mm — remontée de la rampe.
                   //      croc_r_z < croc_r_y IMPÉRATIVEMENT : à l'impression la
                   //      rampe est un porte-à-faux dont l'angle depuis la
                   //      verticale vaut atan(croc_r_z / croc_r_y). 14/16 = 41°,
                   //      sous la limite de 45°. Au-delà, il faut des supports.

// --- Niveaux ------------------------------------------------------------------
// z = 0 au point le plus bas de la coque, sous la partie profonde.

garde_vis = 28;                  // mm — de l'arase du bac à l'axe des vis.
                                 //      Calé pour que boss_z0 tombe exactement
                                 //      sur l'arase : au-dessous, le renflement
                                 //      mordrait dans le rangement.
z_haut    = bac_h;               //  95 — arase du bac
z_vis     = z_haut + garde_vis;  // 115 — axe des chevilles, en butée haute
z_top     = max(z_epaul_g, z_epaul_d);   // 138 — le plus haut des deux épaules

fond_bas  = fond;                //  2,4 — fond côté profond  → 91 mm utiles
fond_haut = marche + fond;       // 48,4 — fond côté peu profond → 45 mm utiles

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
module extrude_arrondi(y0, e, r, n = 0) {
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

// Le dessous : plat côté profond, puis un S qui remonte vers la zone peu profonde.
function dessous(x) =
    x <= x_tab           ? 0 :
    x >= x_tab + galbe   ? marche
                         : marche * liss((x - x_tab) / galbe);

// Le dessus du dos : deux épaules à l'aplomb des vis, un creux entre elles, et
// une retombée aux extrémités. Quatre raccords, tous à tangente nulle : le profil
// n'a pas une seule arête.
function dessus(x) =
    x <= -x_bosse ? z_fin_g   + (z_epaul_g - z_fin_g) * liss((x + larg / 2) / (larg / 2 - x_bosse)) :
    x <=  0       ? z_creux   + (z_epaul_g - z_creux) * liss(-x / x_bosse) :
    x <=  x_bosse ? z_creux   + (z_epaul_d - z_creux) * liss( x / x_bosse)
                  : z_fin_d   + (z_epaul_d - z_fin_d) * liss((larg / 2 - x) / (larg / 2 - x_bosse));

// L'arche est libre de sa forme SAUF au droit des vis : il faut de la matière
// au-dessus du siège, sinon le canal débouche par le haut et la vis ne porte
// plus. Rien dans la géométrie ne le signalerait — d'où l'assertion.
assert(dessus( entraxe / 2) >= z_vis + 10,
       "l'arche passe trop bas au droit de la vis droite : remonter z_epaul_d");
assert(dessus(-entraxe / 2) >= z_vis + 10,
       "l'arche passe trop bas au droit de la vis gauche : remonter z_epaul_g");

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
module silhouette_dos_2d() {
    arrondi() polygon(concat(
        sil_bas(),
        [for (i = [sil_n : -1 : 0])
         let (x = -larg / 2 + i * larg / sil_n) [x, dessus(x)]]
    ));
}

// Le bac : même dessous, arase plate — c'est le bord où l'on pose la main.
// `ztop` sert à en obtenir une version prolongée vers le haut : l'enveloppe
// intérieure doit rester OUVERTE à l'arase, sinon les compartiments se
// retrouveraient coiffés d'un couvercle.
module silhouette_bac_2d(ztop = 0) {
    zt = ztop > 0 ? ztop : z_haut;
    arrondi() polygon(concat(
        sil_bas(),
        [[larg / 2, zt], [-larg / 2, zt]]
    ));
}

// L'enveloppe intérieure de la coque : sa peau en retrait de `paroi`.
//
// Les cavités doivent être DÉCOUPÉES DEDANS, et non simplement posées à un
// niveau donné. Le dessous de la coque remonte vers les extrémités — coins
// arrondis, galbe — alors qu'un fond de compartiment est plat : près des coins
// il passait sous la peau et le bac débouchait par en dessous. Rien dans la
// géométrie ne le signalait.
module enveloppe_int_2d(retrait = 0) {
    offset(r = -(paroi + retrait)) silhouette_bac_2d(z_haut + 60);
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
        extrude_arrondi(0, dos_e + marge, r_av_dos) silhouette_dos_2d();
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
            extrude_arrondi(0, dos_ep, min(r_av_dos, dos_ep - 0.6)) silhouette_dos_2d();
            bossages();
        }
        for (s = [-1, 1]) canaux(s * entraxe / 2);
    }
}

// Le bac, plein — sa cavité est retirée plus haut, au niveau de la coque.
module bac_plein() {
    extrude_arrondi(dos_ep, prof - dos_ep, r_av_bac, n_galbe) silhouette_bac_2d();
}

// Les cavités de rangement, découpées dans l'enveloppe intérieure de la coque.
//
// Elles ne doivent PAS être posées à un niveau : le dessous de la coque remonte
// vers les extrémités — coins arrondis, galbe — alors qu'un fond de compartiment
// est plat. Posées à plat, elles passaient sous la peau près des coins et le bac
// débouchait par en dessous.
module cavites() {
    intersection() {
        extrude_arrondi(dos_ep, prof - dos_ep, max(0.6, r_av_bac - paroi), n_galbe)
            enveloppe_int_2d();
        union() for (z = zones)
            translate([0, 0, z[2]])
                linear_extrude(z_haut - z[2] + 10)
                    rect_2d(z[0], z[1], yi0, yi1);
    }
}

// Évidement sous le socle du côté peu profond : sans lui, le coin entre le galbe
// et ce socle serait un bloc plein.
module evidement() {
    en_travers(dos_ep, prof - dos_ep - paroi)
        intersection() {
            offset(r = -paroi) silhouette_bac_2d();
            polygon([
                [-larg,            -20],
                [ larg,            -20],
                [ larg,            fond_haut],
                [ x_tab + cloison, fond_haut],
                [ x_tab + cloison, fond_bas],
                [-larg,            fond_bas],
            ]);
        }
}

// Pour inspection seule : le bac creusé, sans le reste.
module bac() {
    difference() { bac_plein(); cavites(); evidement(); }
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
            extrude_arrondi(dos_ep, prof - dos_ep, max(0.6, r_av_bac - paroi),
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
croc_z = croc_bas;                    // 4
// Passage libre pour l'arceau, entre le dessus du bras et le dessous de la coque.
croc_jour = marche - croc_z - croc_e; // 32

// Le crochet, d'UN SEUL PROFIL plié.
//
// Une version antérieure l'assemblait en deux morceaux : un bras extrudé dans un
// sens, un col extrudé dans l'autre, qui se rencontraient en T sans le moindre
// congé. Ça se voyait, et ça concentrait la contrainte exactement là où le
// casque tire. Ici c'est une seule section, du dos jusqu'à la butée, avec des
// congés rentrants à chaque pli — comme un fer plié, pas comme deux pièces
// soudées.
module crochet() {
    profil = [
        [0,                 marche + 15],              // adossé au dos, noyé dedans
        [0,                 croc_z],                   // descend le long du bois
        [croc_l,            croc_z],                   // file vers l'avant
        [croc_l,            croc_z + croc_e + croc_r_z],  // remonte : la butée
        [croc_l - croc_r_y, croc_z + croc_e],          // redescend le long de la rampe
        [croc_col_y,        croc_z + croc_e],          // le dessus du bras
        [croc_col_y,        marche + 15],              // et remonte au dos
    ];

    difference() {
        translate([croc_x, 0, 0])
            rotate([90, 0, 90])
                translate([0, 0, -croc_larg / 2])
                    linear_extrude(croc_larg)
                        offset(r = -croc_rc) offset(r = croc_rc)   // plis rentrants
                            offset(r = croc_rv) offset(r = -croc_rv)  // arêtes vives
                                polygon(profil);

        // La racine est noyée de 15 mm dans la coque pour que la jonction soit
        // franche. Ce qui dépasserait au-dessus du dessous de la coque — près du
        // coin arrondi, elle remonte — est retiré.
        difference() {
            translate([-BIG / 2, -BIG / 2, marche]) cube(BIG);
            en_travers(-1, prof + 2) silhouette_bac_2d();
        }

        // arêtes de portée chanfreinées : une arête vive marque la mousse de
        // l'arceau à la longue. Verticales à l'impression, donc gratuites.
        for (s = [-1, 1])
            translate([croc_x + s * croc_larg / 2, croc_l / 2, croc_z + croc_e])
                rotate([0, 45, 0])
                    cube([croc_ch * sqrt(2), croc_l + 20, croc_ch * sqrt(2)],
                         center = true);
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

module coque() {
    difference() {
        union() { dos(); bac_plein(); crochet(); }
        cavites();
        evidement();
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
    else                         panier();
}

main();
