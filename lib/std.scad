// lib/std.scad — utilitaires partagés par tous les modèles.
// Unités : millimètres. Convention : chaque modèle définit `module main()`.

// Résolution des courbes : basse en preview, fine au rendu final.
// $fa = 3 donne 120 segments sur un Ø 69, soit 0,04 mm d'erreur de corde :
// très en deçà de ce qu'une buse de 0,4 mm sait reproduire.
$fs = $preview ? 0.8 : 0.3;
$fa = $preview ? 9   : 3;

EPS = 0.01;   // pour éviter les faces coplanaires dans les difference()
BIG = 1000;   // demi-espace de coupe, largement plus grand que les modèles

// Coupe en demi-espace : supprime la matière au-delà de `at` le long de `axis`.
//   axis : "x" | "y" | "z"
//   keep : "neg" garde le côté < at, "pos" garde le côté > at
module section(axis = "x", at = 0, keep = "neg") {
    s = (keep == "neg") ? 1 : -1;
    difference() {
        children();
        translate(
            axis == "x" ? [at + s * BIG / 2, 0, 0] :
            axis == "y" ? [0, at + s * BIG / 2, 0] :
                          [0, 0, at + s * BIG / 2]
        ) cube(BIG, center = true);
    }
}

// Coupe de quart (deux plans) — très lisible pour montrer l'intérieur d'une pièce.
module quarter_cut(x = 0, y = 0) {
    section("x", x, "neg") section("y", y, "neg") children();
}

// Tranche 2D : intersection du modèle avec un plan perpendiculaire à `axis`.
module slice_2d(axis = "z", at = 0) {
    projection(cut = true)
        rotate(axis == "x" ? [0, 90, 0] : axis == "y" ? [-90, 0, 0] : [0, 0, 0])
        translate(axis == "x" ? [-at, 0, 0] : axis == "y" ? [0, -at, 0] : [0, 0, -at])
        children();
}

// Vue technique 2D : silhouette projetée (front / top / right / left / back / bottom).
module view_2d(view = "front") {
    projection(cut = false)
        rotate(
            view == "front"  ? [-90, 0,   0] :
            view == "back"   ? [-90, 0, 180] :
            view == "right"  ? [-90, 0, -90] :
            view == "left"   ? [-90, 0,  90] :
            view == "bottom" ? [180, 0,   0] :
                               [  0, 0,   0]   // top
        ) children();
}
