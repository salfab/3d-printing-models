// rack-sodastream — rack à visser sous une planche pour cylindres de CO2 SodaStream.
//
// Deux plaques identiques, percées d'alésages fermés à 360°, espacées le long de
// l'axe des cylindres. Les bouteilles se glissent axialement à travers les deux.
// Aucun demi-cercle : le cylindre est tenu sur tout son pourtour et ne peut pas rouler.
//
// La plaque est une seule extrusion prismatique : bride et colliers ont la même
// profondeur, ce qui donne du volume aux colliers et raidit l'ensemble.
//
// Repère : X = largeur (perpendiculaire aux cylindres)
//          Y = axe des cylindres
//          Z = vertical, z = 0 est la sous-face de la planche, la matière descend.

include <../../lib/std.scad>

// --- Pièce à produire -------------------------------------------------------
// "avant"   : plaque ouverte, côté par lequel on introduit le cylindre
// "arriere" : plaque avec fond de butée
// "guide"   : rail de guidage reliant les deux plaques (à imprimer en 2 exemplaires)
// "montage" : visualisation de l'ensemble monté, cylindres compris (non imprimable)
PIECE = "avant";

// --- Cylindre de gaz --------------------------------------------------------

cyl_diametre = 60;    // mm — Ø du corps (recharge universelle 425 g / TR21x4)
cyl_longueur = 356;   // mm — longueur hors tout, filetage compris
jeu_radial   = 1.5;   // mm — jeu au rayon pour un glissement franc

// --- Plaque -----------------------------------------------------------------

nb_cylindres = 2;
paroi        = 3;     // mm — épaisseur du collier, et de l'âme partagée
plaque_prof  = 40;    // mm — profondeur le long de l'axe, bride et colliers confondus
butee_ep     = 3;     // mm — fond de butée de la plaque arrière

// --- Adoucissement des arêtes -----------------------------------------------

conge        = 6;     // mm — congé aux cuspides entre deux colliers
raccord      = 2;     // mm — congé au raccord bride / colliers
coin         = 2;     // mm — rayon des coins de la bride (max bride_ep/2)
chanfrein    = 1.5;   // mm — chanfrein d'entrée des alésages
chanf_bord   = 1.2;   // mm — chanfrein des arêtes d'extrémité (0 pour aucun)
chanf_pas    = 6;     // marches du chanfrein : 1,2/6 = 0,2 mm, une couche

// --- Rail de guidage --------------------------------------------------------
// Prolonge la surface de l'alésage d'une plaque à l'autre pour que le nez du
// cylindre ne puisse pas manquer le second alésage.

guide         = true; // false pour un rack sans rails
guide_larg    = 20;   // mm — largeur de l'encoche en fond
guide_aronde  = 3;    // mm — retrait par côté au débouché : queue d'aronde qui
                      //      empêche le rail de se soulever dans l'alésage
guide_ep      = 4.5;  // mm — profondeur de l'encoche = épaisseur du rail au centre
guide_jeu     = 0.3;  // mm — jeu perpendiculaire du rail dans son encoche. Le rack
                      //      s'assemble avant vissage, le rail alignant lui-même les
                      //      plaques : les avant-trous se marquent à travers le rack monté
guide_entree  = 1.5;  // mm — chanfrein d'engagement au bout du rail (0 pour aucun)
guide_jeu_axe = 1.0;  // mm — raccourcissement du rail. Sans lui il ferait exactement
                      //      la longueur disponible et ne rentrerait pas
guide_talon   = 5;    // mm — hauteur du talon d'arrêt (0 pour aucun). Reculé d'une
                      //      profondeur de plaque, il porte contre la face ARRIÈRE de
                      //      la plaque avant et empêche le rail d'avancer et de sortir

// --- Bride de fixation ------------------------------------------------------

bride_ep     = 6;     // mm — épaisseur plaquée contre le bois
oreille      = 16;    // mm — débord latéral, seul endroit où loger une tête fraisée
vis_passage  = 5;     // mm — Ø de passage pour vis M4 (1 mm de flottement au Ø)
vis_tete     = 8;     // mm — Ø du fraisage. Tête fraisée M4 : 7,5 mm maxi (DIN 965),
                      //      donc la tête s'enfonce de 0,25 mm sous la surface

// --- Implantation (visualisation "montage" uniquement) ----------------------

ecart_plaques = 200;  // mm — entraxe recommandé entre les deux plaques
planche       = true; // false pour dégager la vue sur le rack

// --- Grandeurs dérivées -----------------------------------------------------

alesage   = cyl_diametre + 2 * jeu_radial;
exterieur = alesage + 2 * paroi;
entraxe   = alesage + paroi;                        // les colliers se recoupent
largeur   = entraxe * (nb_cylindres - 1) + exterieur + 2 * oreille;
z_axe     = -exterieur / 2;
tete_prof = (vis_tete - vis_passage) / 2;           // fraisage à 90°

// Les vis ne peuvent aller que dans les oreilles : ailleurs, la tête serait noyée
// dans la matière des colliers.
vis_x     = [-(largeur / 2 - oreille / 2), largeur / 2 - oreille / 2];
vis_y     = plaque_prof / 2 - vis_tete / 2 - 2;

z_bas      = z_axe - alesage / 2;                   // point bas de l'alésage
z_encoche  = z_bas - guide_ep;                      // fond plat de l'encoche
z_bossage  = z_encoche - paroi;                     // dessous du bossage local
guide_long = ecart_plaques + plaque_prof - butee_ep - guide_jeu_axe;
// Position du rail dans le montage : crochet en appui sur la face avant, le jeu axial
// se retrouvant donc entièrement à l'arrière, contre la butée.
guide_y    = ecart_plaques / 2 + plaque_prof / 2 - guide_long / 2;

function axe_x(i) = (i - (nb_cylindres - 1) / 2) * entraxe;

// --- Profil de la plaque ----------------------------------------------------

// Colliers et bossages. La fermeture morphologique comble les cuspides où les
// cercles extérieurs se recoupent : elle n'ajoute que de la matière, jamais ne
// rogne les parois de 3 mm.
module profil_colliers() {
    offset(r = -conge) offset(r = conge)
        for (i = [0 : nb_cylindres - 1]) translate([axe_x(i), 0]) {
            translate([0, z_axe]) circle(d = exterieur);
            if (guide)
                translate([0, (z_axe + z_bossage) / 2])
                    square([guide_larg + 2 * paroi, z_axe - z_bossage], center = true);
        }
}

// Bride aux coins adoucis. La face supérieure reste plane pour porter à plat
// contre le bois.
module profil_bride() {
    r = min(coin, bride_ep / 2, largeur / 2);
    offset(r = r)
        translate([0, -bride_ep / 2])
            square([largeur - 2 * r, bride_ep - 2 * r], center = true);
}

module profil_plaque() {
    offset(r = -raccord) offset(r = raccord)
        union() {
            profil_colliers();
            profil_bride();
        }
}

// Profil de l'encoche : queue d'aronde à fond plat sous l'alésage, évasée vers le
// bas. Le rail en est la copie réduite du jeu, si bien que son dessus arqué
// prolonge exactement l'alésage tout en étant retenu en hauteur.
module profil_encoche() {
    h  = guide_ep + 2;                       // dépasse dans l'alésage, qui recoupe
    wb = guide_larg / 2;                     // demi-largeur en fond
    wh = guide_larg / 2 - guide_aronde;      // demi-largeur au débouché
    difference() {
        polygon([[-wb, z_encoche], [wb, z_encoche],
                 [wh, z_encoche + h], [-wh, z_encoche + h]]);
        translate([0, z_axe]) circle(d = alesage);
    }
}

// --- Volumes ----------------------------------------------------------------

// Extrusion dont les deux faces d'extrémité sont chanfreinées. Le profil étant
// très concave, ni hull() ni minkowski() ne conviennent : on empile des tranches
// de profil décalé. Avec une marche par couche d'impression, le résultat est
// exactement ce qu'un trancheur produirait d'un vrai chanfrein à 45°.
module extrude_chanfrein(h, c, n) {
    if (c <= 0) {
        translate([0, 0, -h / 2]) linear_extrude(height = h) children();
    } else {
        for (i = [0 : n]) {
            t = c * i / n;
            translate([0, 0, -h / 2 + c - t])
                linear_extrude(height = h - 2 * (c - t))
                    offset(delta = -t) children();
        }
    }
}

module corps_plaque() {
    // rotate([90,0,0]) conserve le sens vertical du profil et extrude selon Y.
    rotate([90, 0, 0])
        extrude_chanfrein(plaque_prof, chanf_bord, chanf_pas)
            profil_plaque();
}

// Alésages. Avec butée, ils s'arrêtent avant la face arrière (-Y).
module alesages(butee = false) {
    debut = butee ? -plaque_prof / 2 + butee_ep : -plaque_prof / 2 - EPS;
    fin   = plaque_prof / 2 + EPS;
    for (i = [0 : nb_cylindres - 1])
        translate([axe_x(i), debut, z_axe])
            rotate([-90, 0, 0])
                cylinder(h = fin - debut, d = alesage);
}

module chanfreins(butee = false) {
    faces = butee ? [1] : [-1, 1];
    for (i = [0 : nb_cylindres - 1], s = faces)
        translate([axe_x(i), s * (plaque_prof / 2 + EPS), z_axe])
            rotate([s * 90, 0, 0])
                cylinder(h = chanfrein + EPS,
                         r1 = alesage / 2 + chanfrein, r2 = alesage / 2);
}

// Encoches du rail. Sur la plaque arrière elles s'arrêtent à la butée, qui
// reste ainsi un fond plein.
module encoches(butee = false) {
    debut = butee ? -plaque_prof / 2 + butee_ep : -plaque_prof / 2 - EPS;
    fin   = plaque_prof / 2 + EPS;
    for (i = [0 : nb_cylindres - 1])
        translate([axe_x(i), fin, 0])
            rotate([90, 0, 0])
                linear_extrude(height = fin - debut)
                    profil_encoche();
}

module percages_vis() {
    for (x = vis_x, s = [-1, 1])
        translate([x, s * vis_y, 0]) {
            translate([0, 0, -bride_ep - EPS])
                cylinder(h = bride_ep + 2 * EPS, d = vis_passage);
            translate([0, 0, -bride_ep])
                cylinder(h = tete_prof, d1 = vis_tete, d2 = vis_passage);
        }
}

module plaque(butee = false) {
    difference() {
        corps_plaque();
        alesages(butee);
        chanfreins(butee);
        percages_vis();
        if (guide) encoches(butee);
    }
}

// Rail de guidage : glissière à fond plat et dessus arqué, un par cylindre.
//
// Le talon d'arrêt est reculé de `plaque_prof` depuis le bout avant, de sorte qu'il
// vienne en appui sur la face ARRIÈRE de la plaque avant : c'est l'avancée du rail
// qu'il faut arrêter, le recul étant déjà pris par la butée du fond. Le talon reste
// donc entre les deux plaques, rien ne dépasse de l'encombrement du rack — mais le
// rail ne peut plus s'introduire que par l'arrière, avant la pose de la plaque du fond.
// Extrusion dont l'extremite z = h s'amincit, pour que le rail s'engage seul dans
// la seconde queue d'aronde meme si les deux plaques ne sont pas parfaitement alignees.
module extrude_entree(h, c, n) {
    if (c <= 0) {
        linear_extrude(height = h) children();
    } else {
        for (i = [0 : n]) {
            t = c * i / n;
            linear_extrude(height = h - c + t) offset(delta = -t) children();
        }
    }
}

module rail() {
    translate([0, guide_long / 2, 0]) rotate([90, 0, 0]) {
        extrude_entree(guide_long, guide_entree, 4)
            offset(r = -guide_jeu) profil_encoche();
        if (guide_talon > 0)
            translate([0, 0, plaque_prof])
                linear_extrude(height = paroi)
                    translate([0, z_encoche - guide_talon / 2])
                        square([guide_larg - 2 * guide_jeu, guide_talon], center = true);
    }
}

// Cylindre de gaz simplifié, pour la visualisation du montage.
module cylindre_gaz() {
    col = 22;
    rotate([-90, 0, 0]) {
        cylinder(h = cyl_longueur - col, d = cyl_diametre);
        translate([0, 0, cyl_longueur - col]) cylinder(h = col / 2, d1 = cyl_diametre, d2 = 25);
        translate([0, 0, cyl_longueur - col / 2]) cylinder(h = col / 2, d = 25);
    }
}

module montage() {
    translate([0, ecart_plaques / 2, 0])  plaque(false);
    translate([0, -ecart_plaques / 2, 0]) plaque(true);
    if (guide)
        color("#4f7d8c")
            for (i = [0 : nb_cylindres - 1])
                translate([axe_x(i), guide_y, 0]) rail();
    color("#9aa3ab")
        for (i = [0 : nb_cylindres - 1])
            translate([axe_x(i), -ecart_plaques / 2 - plaque_prof / 2 + butee_ep, z_axe])
                cylindre_gaz();
    if (planche)
        color("#c9a227")
            translate([0, 0, 9]) cube([largeur + 60, cyl_longueur + 40, 18], center = true);
}

module main() {
    if (PIECE == "montage")      montage();
    else if (PIECE == "arriere") plaque(true);
    else if (PIECE == "guide")   rail();
    else                         plaque(false);
}

main();
