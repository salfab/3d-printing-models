// vide-poches — panier mural suspendu sur deux chevilles d'assemblage,
// vis invisibles, crochet à casque intégré.
//
// Le panier s'enfile par le haut : on le présente au-dessus des deux vis, on le
// descend, il se verrouille. Rien à visser une fois la pièce en main, rien à
// démonter pour le décrocher.
//
// La fixation tient en trois canaux verticaux superposés dans l'épaisseur du dos,
// un par étage de la vis : la collerette au fond, la tige lisse au milieu, la tête
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
// IMPRESSION : posé sur le dos, plaque arrière contre le plateau. Tout ce qui
// pointe vers l'avant à l'usage devient vertical, y compris le bras du crochet.
// Aucun support.

include <../../lib/std.scad>

// "coque"   : dos + bac nu + crochet          — pièce à imprimer n°1
// "insert"  : les séparateurs seuls            — pièce à imprimer n°2
// "panier"  : les deux en place, pour regarder
// "gabarit" : réglet de perçage de la deuxième cheville (consommable)
// "montage" : le panier, le bois et les vis, pour vérifier la cinématique
PIECE = "panier";

// --- Chevilles de fixation ----------------------------------------------------
// Tout relevé au réglet sur la cheville en place. Ces cotes ne pilotent que
// l'épaisseur du dos, jamais le reste de la pièce.

col_d    = 7.3;   // mm — Ø du fût noir                                   (relevé)
col_h    = 6.0;   // mm — de combien il dépasse du bois                   (relevé)
vis_d    = 3.4;   // mm — Ø de la tige lisse                              (relevé)
vis_l    = 14.0;  // mm — longueur de tige libre, fût → tête              (relevé)
tete_h   = 3.0;   // mm — hauteur de la tête                              (relevé)
                  //      Contrôle : 6 + 14 + 3 = 23, pour une cheville annoncée
                  //      à 22. Un millimètre d'écart sur trois relevés séparés,
                  //      sans conséquence — cette cote ne dimensionne qu'un
                  //      dégagement, jamais une portée.
tete_d   = 8.0;   // mm — Ø de la tête. Jamais mesuré, et MAJORÉ VOLONTAIREMENT :
                  //      son logement ne guide rien, il ne fait que dégager.
                  //      L'élargir ne coûte rien, le sous-estimer coincerait.

entraxe  = 140;   // mm — écartement des deux chevilles. La seconde est à poser,
                  //      donc cette valeur est libre : assez large pour empêcher
                  //      le vrillage, avec 30 mm de marge de chaque côté.

jeu_col  = 0.8;   // mm — jeu diamétral dans le canal de la collerette
jeu_vis  = 0.8;   // mm — jeu diamétral dans la fente de tige
jeu_tete = 3.0;   // mm — le logement de tête ne guide rien, il dégage

// --- Dos ----------------------------------------------------------------------

porteur  = vis_l - 0.5;                        // plaque porteuse : toute la tige
loge_e   = tete_h + 2.0;                       // logement de la tête, large exprès
dos_av   = 2.4;                                // peau avant, celle qui cache tout
dos_e    = col_h + porteur + loge_e + dos_av;  // 26.9

dos_peau = 1.6;   // mm — peau arrière, celle qui plaque sur le bois
dos_nerv = 2.4;   // mm — nervures d'allègement
dos_pas  = 34;    // mm — pas de la grille d'allègement
dos_plein = 12;   // mm — demi-largeur de matière pleine autour de chaque cheville.
                  //      La fente ne fait que 4,2 : 10 mm de matière de chaque côté
                  //      suffisent largement, et au-delà on ne fait qu'alourdir.

// --- Bac ----------------------------------------------------------------------

larg     = 200;   // mm — largeur hors tout. 150 sont imposés par les lunettes ;
                  //      200 tient sur un plateau de 220 avec de la marge.
bac_h    = 60;    // mm
bac_int  = 76;    // mm — profondeur intérieure utile
paroi    = 2.4;   // mm — 6 périmètres à 0,4
cloison  = 2.4;   // mm
fond     = 2.4;   // mm
r_coin   = 4;     // mm — congé vertical des compartiments
insert_fond = 1.6;   // mm — fond propre de l'insert. Mince car il ne travaille
                     //      pas : il repose à plat sur celui de la coque.
insert_rebord = 8;   // mm — hauteur du rebord bas de l'insert
insert_paroi  = 2.0; // mm — épaisseur de ce rebord
insert_jeu = 0.5; // mm — jeu entre l'insert et la coque, par côté. Sur 195 mm de
                  //      long, c'est le retrait différentiel des deux pièces qui
                  //      compte, pas le retrait absolu : même matière, même
                  //      machine, donc 0,5 suffit.

prof     = dos_e + bac_int + paroi;   // profondeur hors tout

// --- Crochet à casque ---------------------------------------------------------
// Sony WH-1000XM5 : ne se plie pas, seulement à plat. L'arceau porte sur toute la
// largeur du bras, d'où une portée large plutôt qu'une patte fine.

croc_larg  = 40;   // mm — largeur de portée sous l'arceau
croc_e     = 10;   // mm — épaisseur du bras
croc_jour  = 30;   // mm — passage libre entre le bras et le dessous du bac
croc_l     = 70;   // mm — longueur du bras
croc_ame   = 14;   // mm — épaisseur de l'âme qui relie le bras au dos
croc_ch    = 3;    // mm — chanfrein des arêtes de portée
croc_r_y   = 16;   // mm — emprise de la rampe de retenue
croc_r_z   = 14;   // mm — remontée de la rampe.
                   //      croc_r_z < croc_r_y IMPÉRATIVEMENT : à l'impression la
                   //      rampe est un porte-à-faux dont l'angle depuis la
                   //      verticale vaut atan(croc_r_z / croc_r_y). 14/16 = 41°,
                   //      sous la limite de 45°. Au-delà, il faut des supports.

// --- Niveaux ------------------------------------------------------------------

z_bac    = croc_e + croc_jour;   //  40 — dessous du bac
z_haut   = z_bac + bac_h;        // 100 — bord supérieur du bac
z_vis    = z_haut + 20;          // 120 — axe des chevilles, en butée haute
z_top    = z_vis + 18;           // 138 — sommet du dos

// --- Compartiments ------------------------------------------------------------
// Dictés par les objets, pas par une grille régulière.

xi0 = -larg / 2 + paroi;
xi1 =  larg / 2 - paroi;
yi0 = dos_e;
yi1 = prof - paroi;

x_sep = xi0 + 150;     // frontière bloc gauche (lunettes) / bloc droit
x_tab = xi0 + 110;     // largeur de la fente à tabac
y_sep = yi0 + 46;      // fond du bac à lunettes
y_cab = yi0 + 42.8;    // le puits à câbles est carré

// [x0, x1, y0, y1]
// TOUS au même congé r_coin, et ce n'est pas un choix esthétique : l'insert se
// calcule comme « l'intérieur moins les compartiments ». Un compartiment plus
// arrondi que le pourtour laisse dans le coin un fragment de matière détaché du
// reste, qui sortirait de l'imprimante en morceau libre.
cuves = [
    [xi0,             x_sep, yi0,             y_sep],  // lunettes
    [xi0,             x_tab, y_sep + cloison, yi1  ],  // tabac, sur la tranche
    [x_tab + cloison, x_sep, y_sep + cloison, yi1  ],  // petites bricoles
    [x_sep + cloison, xi1,   yi0,             y_cab],  // câbles USB
    [x_sep + cloison, xi1,   y_cab + cloison, yi1  ],  // briquets
];

// --- Outils de construction ---------------------------------------------------

// Extrude un profil 2D dessiné dans le plan de la face (X horizontal, Y = Z du
// modèle) à travers l'épaisseur du dos, de y0 à y0 + e.
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
        translate([-l / 2, z_bac - 20]) square([l, 1]);
    }
}

// Rectangle à coins arrondis, en 2D.
module rect_2d(x0, x1, y0, y1, r = r_coin) {
    offset(r = r) offset(r = -r)
        polygon([[x0, y0], [x1, y0], [x1, y1], [x0, y1]]);
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

// Pave une zone de poches d'allègement, en laissant une nervure pleine entre
// chacune ET sur les quatre bords de la zone.
module grille(x0, x1, z0, z1) {
    nx = max(1, round((x1 - x0) / dos_pas));
    nz = max(1, round((z1 - z0) / dos_pas));
    px = (x1 - x0) / nx;
    pz = (z1 - z0) / nz;
    for (i = [0 : nx - 1], j = [0 : nz - 1])
        translate([x0 + i * px, dos_peau, z0 + j * pz])
            cube([px - dos_nerv, dos_e - dos_peau - dos_av, pz - dos_nerv]);
}

module dos() {
    difference() {
        union() {
            // La plaque, allégée par une grille de poches. Elles sont FERMÉES —
            // la peau avant les referme — donc chacune est une cavité scellée que
            // le trancheur doit ponter sur le pas de la grille, 30 mm. C'est sans
            // difficulté en PLA, et la peau fait 6 couches : seule la première
            // ponte, les cinq autres se posent dessus. Mais ce n'est pas gratuit,
            // contrairement à ce qu'on croirait si on les imaginait ouvertes.
            difference() {
                translate([-larg / 2, 0, z_bac])
                    cube([larg, dos_e, z_top - z_bac]);
                grille(-larg / 2 + dos_nerv, larg / 2,
                       z_bac + dos_nerv,      z_top);
            }

            // Matière pleine autour de chaque cheville : c'est la plaque porteuse.
            // Uniquement dans le bandeau — c'est la seule hauteur où la vis porte.
            // Plus bas, le canal n'est qu'un couloir libre entre les nervures, et
            // le dos peut rester un caisson creux.
            for (s = [-1, 1])
                translate([s * entraxe / 2 - dos_plein, 0, z_haut - 12])
                    cube([2 * dos_plein, dos_e, z_top - z_haut + 12]);
        }

        for (s = [-1, 1]) canaux(s * entraxe / 2);
    }
}

// La coque : le bac nu, sans aucune séparation. Utilisable seule en plateau.
module bac() {
    difference() {
        translate([-larg / 2, dos_e, z_bac])
            cube([larg, prof - dos_e, bac_h]);
        translate([0, 0, z_bac + fond])
            linear_extrude(bac_h)
                rect_2d(xi0, xi1, yi0, yi1);
    }
}

// Le contour de l'insert : l'intérieur de la coque, rétréci du jeu de montage.
module contour_2d() {
    offset(r = -insert_jeu) rect_2d(xi0, xi1, yi0, yi1);
}

// L'insert : un bac à séparations d'un seul tenant, qui se pose au fond de la
// coque et se retire avec son contenu.
//
// Il porte son propre fond. Une version antérieure n'était qu'un peigne de
// cloisons sans fond, pour ne pas empiler deux fonds : elle économisait 29 g et
// donnait quatre parois de 2,4 mm hautes de 57, en porte-à-faux jusqu'à 97 mm,
// ne touchant le plateau que par leur tranche — 7 cm² pour toute la pièce.
// Fragile à l'impression comme à la main. Le fond raidit tout, colle la pièce au
// plateau sur 145 cm², et permet de sortir l'insert plein.
//
// Il reste mince parce qu'il ne travaille pas : il repose à plat sur le fond de
// la coque, qui reprend seul les charges.
//
// Séparations et coque se calculent toutes deux à partir de la liste `cuves` :
// une seule description, donc pas de divergence possible.
module insert() {
    translate([0, 0, z_bac + fond]) {
        linear_extrude(insert_fond) contour_2d();

        // Rebord bas. Les compartiments extérieurs sont fermés par les parois de
        // la coque, pas par l'insert — pas de double paroi, donc pas de place
        // perdue. Mais sans rien, leur contenu glisse dès qu'on soulève l'insert,
        // et surtout le bord libre d'un fond plat de 194 × 75 en 1,6 mm gondole à
        // l'impression. Le rebord règle les deux pour 7 g.
        linear_extrude(insert_rebord)
            difference() {
                contour_2d();
                offset(r = -insert_paroi) contour_2d();
            }

        linear_extrude(bac_h - fond)
            intersection() {
                difference() {
                    rect_2d(xi0, xi1, yi0, yi1);
                    for (c = cuves) rect_2d(c[0], c[1], c[2], c[3]);
                }
                contour_2d();
            }
    }
}

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
            rotate([90, 0, 90])
                translate([0, 0, -croc_larg / 2])
                    linear_extrude(croc_larg)
                        offset(r = 1.2) offset(r = -1.2)
                            polygon(profil);

            // âme : relie le bras au dos et au fond du bac
            translate([-croc_larg / 2, 0, croc_e - EPS])
                cube([croc_larg, croc_ame, z_bac - croc_e + EPS]);
        }

        // arêtes de portée chanfreinées : une arête vive marque la mousse de
        // l'arceau à la longue. Verticales à l'impression, donc gratuites.
        for (s = [-1, 1])
            translate([s * croc_larg / 2, croc_l / 2, croc_e])
                rotate([0, 45, 0])
                    cube([croc_ch * sqrt(2), croc_l + 20, croc_ch * sqrt(2)],
                         center = true);
    }
}

module panier() {
    union() {
        dos();
        bac();
        insert();
        crochet();
    }
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
    translate([-larg / 2 - 20, -18, z_bac - 20])
        cube([larg + 40, 18, z_top - z_bac + 40]);
}

module main() {
    if (PIECE == "gabarit")      gabarit();
    else if (PIECE == "montage") montage();
    // sous-ensembles : pour inspecter et pour mesurer où part la matière
    // les deux pièces à imprimer
    else if (PIECE == "coque")   { dos(); bac(); crochet(); }
    else if (PIECE == "insert")  insert();
    // sous-ensembles : pour inspecter et pour mesurer où part la matière
    else if (PIECE == "dos")     dos();
    else if (PIECE == "bac")     bac();
    else if (PIECE == "crochet") crochet();
    else                         panier();
}

main();
