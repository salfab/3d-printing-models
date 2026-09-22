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

col_d    = 7.3;   // mm — Ø du fût noir                                   (relevé)
vis_d    = 3.4;   // mm — Ø de la tige lisse                              (relevé)
vis_l    = 14.0;  // mm — longueur de tige libre, fût → tête              (relevé)
tete_h   = 3.0;   // mm — hauteur de la tête                              (relevé)

// Saillie totale hors bois, VIS EN PLACE. C'est la seule cote prise sur
// l'ensemble monté, donc la seule qui intègre ce que le fût s'enfonce ; les
// autres sont prises sur la pièce nue. On en DÉDUIT donc la saillie du fût au
// lieu de la mesurer : mesuré hors bois il fait 6, en place il n'en dépasse que
// 5,2. Les 0,8 mm sont enfouis.
//
// Ce n'est pas un détail : à col_h = 6 la plaque porteuse irait de 6 à 19,5
// alors que le dessous de la tête est à 19,2. Elles se chevaucheraient de
// 0,3 mm et le panier resterait décollé du bois, en appui sur deux têtes de vis.
col_saillie = 22.2;                          // mm                        (relevé)
col_h    = col_saillie - vis_l - tete_h;     // 5.2
tete_d   = 8.0;   // mm — Ø de la tête. Jamais mesuré, et MAJORÉ VOLONTAIREMENT :
                  //      son logement ne guide rien, il ne fait que dégager.
                  //      L'élargir ne coûte rien, le sous-estimer coincerait.

entraxe  = 95;    // mm — écartement des deux chevilles. La seconde est à poser,
                  //      donc cette valeur est libre : assez large pour empêcher
                  //      le vrillage, tout en laissant de la matière entre la
                  //      colonne pleine (dos_plein) et le bord de la pièce.

jeu_col  = 0.8;   // mm — jeu diamétral dans le canal du fût
jeu_vis  = 0.8;   // mm — jeu diamétral dans la fente de tige
jeu_tete = 3.0;   // mm — le logement de tête ne guide rien, il dégage

// --- Dos ----------------------------------------------------------------------

porteur  = vis_l - 0.5;                        // plaque porteuse : toute la tige
loge_e   = tete_h + 2.0;                       // logement de la tête, large exprès
dos_av   = 2.4;                                // peau avant, celle qui cache tout
dos_e    = col_h + porteur + loge_e + dos_av;  // 26.1

dos_peau = 1.6;   // mm — peau arrière, celle qui plaque sur le bois
dos_nerv = 1.6;   // mm — nervures d'allègement. Elles ne travaillent qu'en
                  //      cisaillement entre les deux peaux : 4 passes de buse
                  //      suffisent, et sur 22 mm de profondeur chaque dixième
                  //      compte.
dos_bord = 3.0;   // mm — bord de la plaque, DISTINCT des nervures. C'est en les
                  //      confondant qu'une version antérieure n'a laissé que
                  //      1,5 mm de matière sur tout le pourtour du dos.
dos_pas  = 38;    // mm — pas de la grille. Fixe aussi la portée que la peau
                  //      avant doit ponter au-dessus de chaque cavité.
dos_plein = 12;   // mm — demi-largeur de matière pleine autour de chaque cheville.
                  //      La fente ne fait que 4,2 : 10 mm de matière de chaque côté
                  //      suffisent largement, et au-delà on ne fait qu'alourdir.

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
bac_int  = 70;    // mm — profondeur intérieure utile
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
r_ext    = 14;    // mm — arrondi des angles saillants de la silhouette

// Le dessus du dos : une arche, pas un bandeau. Elle ne doit rester haute que là
// où les vis portent ; au-delà elle peut redescendre, et c'est ce qui casse la
// silhouette rectangulaire.
z_som    = 145;   // mm — sommet de l'arche
x_som    = -10;   // mm — son abscisse, décalée du centre pour éviter la symétrie
z_bord_g = 120;   // mm — hauteur du dos au bord gauche
z_bord_d = 114;   // mm — et au bord droit, plus bas : la pièce s'effile vers le
                  //      crochet, dans le même sens que le fond qui remonte.
                  //      Borné par l'assertion : sous 114, l'arche passe sous le
                  //      siège de la vis droite et le canal débouche par le haut.

insert_fond = 1.6;   // mm — fond propre de l'insert. Mince car il ne travaille
                     //      pas : il repose à plat sur celui de la coque.
insert_rebord = 8;   // mm — hauteur du rebord bas de l'insert
insert_paroi  = 2.0; // mm — épaisseur de ce rebord
insert_jeu = 0.5;    // mm — jeu entre l'insert et la coque, par côté. C'est le
                     //      retrait DIFFÉRENTIEL des deux pièces qui compte, pas
                     //      le retrait absolu : même matière, même machine.

prof     = dos_e + bac_int + paroi;   // profondeur hors tout

// --- Crochet à casque ---------------------------------------------------------
// Sony WH-1000XM5 : ne se plie pas, seulement à plat. L'arceau porte sur toute la
// largeur du bras, d'où une portée large plutôt qu'une patte fine.

croc_larg  = 30;   // mm — largeur de portée sous l'arceau. À 40, le crochet
                   //      occupait 40 des 47 mm du creux laissé par le galbe et
                   //      la silhouette se refermait en boîte. À 30, calé à
                   //      droite, il laisse 18 mm d'air visible entre lui et la
                   //      partie profonde. L'arceau du XM5 fait ~32 mm de large :
                   //      30 mm de portée restent une assise pleine.
croc_e     = 10;   // mm — épaisseur du bras
croc_bas   = 4;    // mm — Z du dessous du bras. Laisse 4 mm d'air sous lui, pour
                   //      qu'il se lise comme suspendu et non comme un bloc posé
                   //      dans le prolongement du fond.
croc_l     = 70;   // mm — longueur du bras
croc_ame   = 14;   // mm — épaisseur de l'âme qui relie le bras au dos
croc_col   = 18;   // mm — LARGEUR de cette âme. Bien plus étroite que le bras,
                   //      et c'est le point : à 40 mm elle bouchait exactement
                   //      le vide que le galbe venait de créer, et la silhouette
                   //      redevenait une boîte. Un col étroit laisse l'air se
                   //      voir sous la courbe.
croc_ch    = 3;    // mm — chanfrein des arêtes de portée
croc_r_y   = 16;   // mm — emprise de la rampe de retenue
croc_r_z   = 12;   // mm — remontée de la rampe.
                   //      croc_r_z < croc_r_y IMPÉRATIVEMENT : à l'impression la
                   //      rampe est un porte-à-faux dont l'angle depuis la
                   //      verticale vaut atan(croc_r_z / croc_r_y). 14/16 = 41°,
                   //      sous la limite de 45°. Au-delà, il faut des supports.

// --- Niveaux ------------------------------------------------------------------
// z = 0 au point le plus bas de la coque, sous la partie profonde.

garde_vis = 20;                  // mm — de l'arase du bac à l'axe des vis
z_haut    = bac_h;               //  95 — arase du bac
z_vis     = z_haut + garde_vis;  // 115 — axe des chevilles, en butée haute
z_top     = z_som;               // 145 — point le plus haut de l'arche

fond_bas  = fond;                //  2,4 — fond côté profond  → 91 mm utiles
fond_haut = marche + fond;       // 48,4 — fond côté peu profond → 45 mm utiles

// --- Compartiments ------------------------------------------------------------
// Dictés par les objets, pas par une grille régulière.

xi0 = -larg / 2 + paroi;
xi1 =  larg / 2 - paroi;
yi0 = dos_e;
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

// Fente verticale à sommet rond : le sommet est le siège, la vis y porte en
// contact réparti plutôt que sur une arête.
module fente_2d(l, z_siege) {
    hull() {
        translate([0, z_siege - l / 2]) circle(d = l);
        translate([-l / 2, -20]) square([l, 1]);
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

// Le dessus du dos : une arche. Elle ne doit rester haute que là où les vis
// portent ; ailleurs elle redescend, et c'est ce qui casse le rectangle.
function dessus(x) =
    x <= x_som ? z_bord_g + (z_som - z_bord_g) * liss((x + larg / 2) / (x_som + larg / 2))
               : z_bord_d + (z_som - z_bord_d) * liss((larg / 2 - x) / (larg / 2 - x_som));

// L'arche est libre de sa forme SAUF au droit des vis : il faut de la matière
// au-dessus du siège, sinon le canal débouche par le haut et la vis ne porte
// plus. Rien dans la géométrie ne le signalerait — d'où l'assertion.
assert(dessus( entraxe / 2) >= z_vis + 10,
       "l'arche passe trop bas au droit de la vis droite : remonter z_bord_d ou z_som");
assert(dessus(-entraxe / 2) >= z_vis + 10,
       "l'arche passe trop bas au droit de la vis gauche : remonter z_bord_g ou z_som");

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
module silhouette_bac_2d() {
    arrondi() polygon(concat(
        sil_bas(),
        [[larg / 2, z_haut], [-larg / 2, z_haut]]
    ));
}

// --- Géométrie ----------------------------------------------------------------

// Les trois canaux d'une cheville, superposés dans l'épaisseur du dos.
// Seule la fente de tige porte : les deux autres ont 1 mm de dégagement au
// sommet pour ne pas venir en butée avant elle.
module canaux(xc) {
    en_travers(-EPS, col_h + EPS)
        translate([xc, 0]) fente_2d(col_d + jeu_col, z_vis + col_d / 2 + 1);

    en_travers(col_h, porteur)
        translate([xc, 0]) fente_2d(vis_d + jeu_vis, z_vis + vis_d / 2);

    en_travers(col_h + porteur, loge_e)
        translate([xc, 0]) fente_2d(tete_d + jeu_tete, z_vis + tete_d / 2 + 1);
}

module dos() {
    difference() {
        union() {
            // La plaque, allégée par une grille de poches confinée à la
            // silhouette. Elles sont FERMÉES — la peau avant les referme — donc
            // chacune est une cavité scellée que le trancheur doit ponter sur le
            // pas de la grille. Sans difficulté en PLA, et la peau fait 6
            // couches : seule la première ponte. Mais ce n'est pas gratuit,
            // contrairement à ce qu'on croirait si on les imaginait ouvertes.
            difference() {
                en_travers(0, dos_e) silhouette_dos_2d();

                nx = ceil(larg / dos_pas);
                nz = ceil(z_top / dos_pas);
                intersection() {
                    for (i = [0 : nx - 1], j = [0 : nz - 1])
                        translate([-larg / 2 + i * dos_pas, dos_peau, j * dos_pas])
                            cube([dos_pas - dos_nerv,
                                  dos_e - dos_peau - dos_av,
                                  dos_pas - dos_nerv]);
                    en_travers(dos_peau, dos_e - dos_peau - dos_av)
                        offset(r = -dos_bord) silhouette_dos_2d();
                }
            }

            // Matière pleine autour de chaque cheville : c'est la plaque porteuse.
            // Uniquement dans le bandeau — c'est la seule hauteur où la vis porte.
            // Plus bas, le canal n'est qu'un couloir libre entre les nervures, et
            // le dos peut rester un caisson creux.
            // Taillées DANS la silhouette : sans l'intersection, elles restent
            // rectangulaires et dépassent de l'arche en deux oreilles carrées.
            for (s = [-1, 1])
                intersection() {
                    translate([s * entraxe / 2 - dos_plein, 0, z_haut - 12])
                        cube([2 * dos_plein, dos_e, z_top - z_haut + 12]);
                    en_travers(0, dos_e) silhouette_dos_2d();
                }
        }

        for (s = [-1, 1]) canaux(s * entraxe / 2);
    }
}

// La coque : le bac nu, sans aucune séparation intérieure sauf la cloison qui
// sépare les deux niveaux — celle-là est structurelle.
module bac() {
    difference() {
        en_travers(dos_e, prof - dos_e) silhouette_bac_2d();

        // une seule cavité par zone, depuis son propre fond
        for (z = zones)
            translate([0, 0, z[2]])
                linear_extrude(z_haut - z[2] + 10)
                    rect_2d(z[0], z[1], yi0, yi1);

        // Évidement sous le socle du côté peu profond. Sans lui, le coin entre le
        // galbe et ce socle serait un bloc plein : des dizaines de grammes de
        // matière qui ne servent à rien.
        en_travers(dos_e, prof - dos_e - paroi)
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

module insert() {
    for (z = zones) insert_zone(z);
}

// --- Crochet ------------------------------------------------------------------

croc_x = larg / 2 - croc_larg / 2;    // calé à droite, sous la zone peu profonde
croc_z = croc_bas;                    // 4
// Passage libre pour l'arceau, entre le dessus du bras et le dessous de la coque.
croc_jour = marche - croc_z - croc_e; // 32

module crochet() {
    profil = [
        [0,                  0],
        [croc_l,             0],
        [croc_l,             croc_e + croc_r_z],
        [croc_l - croc_r_y,  croc_e],
        [0,                  croc_e],
    ];

    difference() {
        union() {
            // bras : profil dans le plan YZ, extrudé sur la largeur de portée
            translate([croc_x, 0, croc_z])
                rotate([90, 0, 90])
                    translate([0, 0, -croc_larg / 2])
                        linear_extrude(croc_larg)
                            offset(r = 1.2) offset(r = -1.2)
                                polygon(profil);

            // Âme : un col étroit, calé à droite, qui descend de la coque
            // jusqu'au bras. Ce qu'il reste du rectangle une fois la coque
            // retirée — il épouse donc le galbe au lieu de le couper au carré.
            en_travers(0, croc_ame)
                difference() {
                    // Le col s'évase vers le haut sur un quart de cercle : sans
                    // cet évasement, son flanc vertical rencontrait le dessous
                    // horizontal de la coque en une arête vive à 90°.
                    let (xg = croc_x + croc_larg / 2 - croc_col,
                         xd = croc_x + croc_larg / 2,
                         zb = croc_z + croc_e - EPS,
                         zh = marche + 20,
                         rc = 20)
                    offset(r = 4) offset(r = -4)
                        polygon(concat(
                            [[xg, zb], [xd, zb], [xd, zh]],
                            [for (i = [0 : 12])
                             let (t = i / 12, a = 90 * t)
                             [xg - rc * sin(a), zh - rc + rc * cos(a)]]
                        ));
                    silhouette_bac_2d();
                }
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

module coque() {
    union() { dos(); bac(); crochet(); }
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
    else                         panier();
}

main();
