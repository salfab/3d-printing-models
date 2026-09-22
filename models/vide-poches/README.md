# vide-poches

Panier mural qui s'enfile par le haut sur deux chevilles d'assemblage de meuble,
en les gardant invisibles, avec compartiments et crochet à casque intégré.

## 1. À quoi sert la pièce

Vider ses poches en rentrant : paquet de tabac, briquets, lunettes, câbles USB,
petites bricoles — et suspendre un casque Sony WH-1000XM5 dessous.

La pièce se visse sur le flanc d'un meuble en bois. Une cheville d'assemblage y est
déjà en place ; la seconde est à poser, donc son écartement est libre.

**Géométrie de la cheville** (relevée sur la pièce en place, photo au réglet) :
douille plastique sertie dans le bois, collerette de **Ø 7,3** qui dépasse de la
surface, puis **tige lisse de Ø 3,4**, puis tête bombée.

> Les cotes `col_h` (dépassement de la collerette), `vis_l` (longueur de tige
> libre) et `tete_d` / `tete_h` sont pour l'instant **lues sur photo**, pas au
> réglet. Elles ne pilotent que l'épaisseur du dos — aucune autre partie de la
> pièce n'en dépend.

**Objets visés** :

| Objet | Encombrement retenu | Conséquence |
|---|---|---|
| Lunettes pliées | 145 × 45 mm | impose les **150 mm** du grand compartiment, donc la largeur de la pièce |
| Paquet de tabac | ~100 × 80 × 25 mm | rangé **sur la tranche**, d'où une fente de 27 mm au lieu d'un bac de 80 |
| Casque WH-1000XM5 | arceau, ~250 g | ne se plie pas (contrairement au XM4) : il faut une portée large, pas une patte |

## 2. Pièces à imprimer

| Pièce | `PIECE=` | Qté | Rôle |
|---|---|---|---|
| Panier | `panier` (défaut) | 1 | toute la pièce, d'un seul bloc |
| Gabarit | `gabarit` | 1 | réglet de perçage de la seconde cheville — consommable |

```bash
python scripts/scad.py stl vide-poches --binaire
python scripts/scad.py stl vide-poches -D PIECE=gabarit --binaire
```

`dos`, `bac` et `crochet` existent aussi comme valeurs de `PIECE=`, pour inspecter
ou mesurer un sous-ensemble. Ils ne s'impriment pas séparément.

## 3. Cotes principales

Mesurées sur le maillage exporté.

| Cote | Valeur | Origine |
|---|---|---|
| Encombrement | 200 × 102,3 × 138 mm | mesuré |
| Volume de matière | 367,1 cm³ (≈ 455 g de PLA) | intégré sur le maillage |
| — dont dos | 172,4 cm³ (47 %) | |
| — dont bac | 146,5 cm³ (40 %) | |
| — dont crochet | 48,3 cm³ (13 %) | |
| Épaisseur du dos | 23,9 mm | `col_h + porteur + loge_e + dos_av` |
| Empilage du dos (plans Y) | 0 / 1,6 / 5,0 / 17,5 / 21,5 / 23,9 | mesuré sur le maillage |
| Entraxe des chevilles | 140 mm | libre — la 2ᵉ est à poser |
| Fente de tige | 4,2 mm | `vis_d + jeu_vis` |
| Matière autour de la fente | 10 mm de chaque côté | `dos_plein − fente/2` |
| Course d'enfilage | 80 mm | du bas du dos au siège |

## 4. Montage ou usage

1. **Percer la seconde cheville.** Poser le gabarit sur la cheville existante, le
   mettre de niveau, pointer par le petit trou. Les deux chevilles doivent être à
   la **même hauteur** : c'est ce qui empêche le panier de vriller quand on le
   charge de travers.
2. **Présenter le panier au-dessus des vis**, les deux têtes en face des canaux.
3. **Le descendre.** Les collerettes montent dans leur canal, les tiges dans leur
   fente, les têtes dans leur logement. Il vient en butée tout seul.

Pour le décrocher : le soulever de 80 mm et le tirer vers soi. Rien à dévisser.

## 5. Impression

**Posé sur le dos, plaque arrière contre le plateau.** C'est l'orientation qui rend
la pièce imprimable d'un seul bloc : tout ce qui pointe vers l'avant à l'usage — les
cloisons, le fond du bac, le bras du crochet — devient vertical sur le plateau.

- **Aucun support.**
- Le plus grand pontage est la peau avant du dos au-dessus d'une poche
  d'allègement : **30 mm**. Sans difficulté en PLA.
- PLA. Le bras du crochet travaille en traction entre couches, la direction faible :
  250 g de casque à 60 mm de porte-à-faux donnent **0,22 MPa** sur une section de
  40 × 10 mm, contre ~20 MPa de cohésion inter-couches. Facteur 90.
- Emprise plateau : 200 × 138 mm. Tient sur un plateau de 220 avec 10 mm de marge
  de chaque côté.

## 6. Contraintes à connaître avant de modifier

- **`dos_peau` (plaque porteuse) ≤ `vis_l`.** La plaque se glisse entre la
  collerette et la tête : plus épaisse que la tige libre, elle ne rentre pas.
  Le modèle la fixe à `vis_l − 0,5`, c'est-à-dire au maximum utile — la tête vient
  alors buter directement contre elle, sans jeu axial vers l'avant.
- **`croc_r_z` < `croc_r_y` impérativement.** À l'impression, la rampe de retenue
  du crochet est un porte-à-faux dont l'angle depuis la verticale vaut
  `atan(croc_r_z / croc_r_y)`. À 14/16 on est à 41°, sous la limite de 45° ;
  au-delà il faut des supports et l'orientation « un seul bloc » s'écroule.
- **La grille d'allègement doit laisser une nervure pleine sur ses quatre bords.**
  Une première version démarrait à une demi-nervure du bord et laissait 1,5 mm de
  matière sur tout le pourtour du dos.
- **`dos_plein` ne doit pas avaler la grille.** À 22 mm, les colonnes pleines
  recouvraient la moitié des poches et ne laissaient que des fentes de 2 à 3 mm :
  du vide qui n'allège rien et qui affaiblit. 12 mm suffisent.
- **Les colonnes pleines n'existent que dans le bandeau**, au-dessus du bac. C'est
  la seule hauteur où la vis porte ; plus bas, le canal n'est qu'un couloir libre
  entre les nervures.
- **L'`offset(r) offset(−r)` qui adoucit le profil du crochet rogne sa pointe.**
  À r = 2 la rampe perdait 2,4 mm de hauteur sans que rien ne le signale.
- **150 mm de compartiment à lunettes commandent la largeur de la pièce.** Réduire
  `larg` sans toucher au compartiment ne donne rien.

## 7. Points de vérification

- [ ] **Relever au réglet** `col_h`, `vis_l`, `tete_d`, `tete_h`. Elles ne sont pour
      l'instant que lues sur photo.
- [ ] **La douille métallique déjà en place**, à ~45 mm en diagonale de la cheville,
      est-elle utilisable ? À cet écartement elle ne convient pas pour un panier de
      200 mm — il faut une seconde cheville à la même hauteur.
- [ ] **455 g de PLA** pour une pièce annoncée « petit panier ». À arbitrer :
      réduire `bac_h`, `bac_int`, ou la hauteur du bandeau.
- [ ] Vérifier que le casque passe : `croc_jour` = 30 mm entre le bras et le
      dessous du bac, à confronter à l'arceau réel.
- [ ] Coupe de contrôle du bac (compartiments, épaisseurs de cloison) — pas encore
      faite.
