// _template — point de départ pour un nouveau modèle.
// Copier le répertoire, le renommer <slug>, renommer ce fichier <slug>.scad.

include <../../lib/std.scad>

// --- Paramètres -------------------------------------------------------------

largeur   = 40;   // mm
profondeur = 30;  // mm
hauteur   = 20;   // mm
paroi     = 2.4;  // mm — 3 périmètres à 0.4 mm de buse
jeu       = 0.3;  // mm — jeu fonctionnel des ajustements glissants

// --- Géométrie --------------------------------------------------------------

module main() {
    difference() {
        cube([largeur, profondeur, hauteur], center = true);
        translate([0, 0, paroi])
            cube([largeur - 2 * paroi, profondeur - 2 * paroi, hauteur], center = true);
    }
}

main();
