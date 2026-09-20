# Quatre vérifications, pas une

*Journal de conception — 20 septembre 2026*

Une journée passée à concevoir une pièce imprimable en 3D avec un assistant, et ce
qu'elle apprend sur la répartition du travail entre une machine qui calcule vite et un
humain qui a déjà manipulé des objets.

L'objet : un rack à visser sous une planche en bois, pour ranger deux cylindres de CO2 à
l'horizontale, invisibles depuis le dessus.

Précision qui a son importance pour les cotes : il s'agit de **cylindres universels**
425 g au filetage TR21×4, pas de cylindres de marque — ils se rechargent chez n'importe
quel distributeur de gaz. L'appareil est une gazéifieuse **Aarke**, qui accepte ce
filetage ; ne pas passer par du matériel SodaStream est un choix assumé, pour des raisons
géopolitiques. Les deux familles de cylindres n'ont d'ailleurs pas les mêmes dimensions,
et c'est la première chose qu'il a fallu trancher.

---

## Le piège nommé dès la première minute

La demande initiale contenait déjà l'avertissement :

> Le piège facile serait d'avoir finalement que des demi-cercles sous la planche en bois,
> ce qui ne permettrait pas de faire entrer un cylindre SodaStream.

C'est exactement le genre de chose qu'on ne trouve pas en raisonnant sur des cotes. Une
gouttière semi-circulaire vissée sous une planche est géométriquement irréprochable, et
la bouteille tombe. Il fallait des alésages **fermés à 360°**, donc une insertion axiale,
donc un rail de guidage, donc une queue d'aronde pour le retenir, donc un talon d'arrêt
qui ne gêne ni le cylindre ni l'impression.

Chacune de ces implications a été découverte au fil de la journée, et presque toujours de
la même façon : par une question de l'humain, jamais par une vérification de la machine.

## La thèse

**L'assistant était bon pour vérifier, mauvais pour savoir quoi vérifier.**

Les idées de conception — le rail de guidage, la queue d'aronde, le talon reculé — sont
venues de l'humain. Et surtout, **chaque défaut de conception a été attrapé par une de
ses questions** :

| La question | Le défaut qu'elle a révélé |
|---|---|
| « le rail sera juste posé, il va beaucoup bouger » | rien ne le retenait vers le haut |
| « assure-toi que l'aronde ne soit pas trop fine » | le talon de la lèvre méritait 1 mm de plus |
| « je ne comprends pas comment ce crochet bloque quoi que ce soit » | il bloquait la mauvaise direction |
| « cette butée va compliquer l'impression » | elle exigeait des supports sur 236 mm |
| « assure-toi qu'il y ait assez de polygones » | le passage réel n'est pas le diamètre nominal |

Ces questions ont un point commun : elles viennent d'avoir tenu des objets dans les
mains. Savoir qu'une pièce mal tenue cliquette, qu'une languette fine de PLA casse, qu'un
porte-à-faux veut du support, qu'on emboîte avant de visser. Aucune ne demandait de
savoir modéliser.

Ce que la machine apportait en face, c'était le calcul qui transforme une intuition en
décision :

- « ça peut être difficile de bien viser » devient **±50 mm de dérive** au second collier.
  Une fois le cylindre engagé dans les 12 mm du premier alésage, il peut basculer de 14° ;
  200 mm plus loin, le nez a dérivé de 50 mm. Le rail n'est plus une commodité, il est
  nécessaire.
- « pas trop fine » devient **+113 % de rigidité pour 1 mm de hauteur** : la rigidité en
  flexion varie comme le cube de l'épaisseur, passer le rail de 3,5 à 4,5 mm la double.
- « assez de polygones » devient **0,0218 mm de perte pour 2,978 mm de jeu**, soit un
  rapport de 137.

## Quatre vérifications, pas une

Le cœur de ce qu'on a appris tient là. Une pièce peut être juste sur un axe et fausse sur
un autre. Quatre contrôles indépendants ont chacun rattrapé, dans cette seule journée, un
défaut qu'**aucun des trois autres ne voyait**.

### Les sections

Épaisseurs, jeux, matière restante aux emboîtements. Se mesurent sur le maillage exporté.

C'est ici qu'on rencontre le piège le plus élégant de la journée. OpenSCAD trace des
polygones **inscrits** : les cordes passent à l'intérieur du cercle nominal, donc un
alésage sort toujours plus petit que sa cote. Sur le rack :

```
Diamètre circonscrit, par les sommets  : 63,0001 mm
Diamètre inscrit, par les cordes       : 62,9783 mm   ← le passage réel
```

Un contrôle naïf sur les sommets affiche 63,0001 et **masque exactement le défaut qu'on
cherchait**. C'est la distance du centre au milieu de chaque corde qu'il faut mesurer.

Ici la perte est négligeable — 0,022 mm pour 2,98 mm de jeu — mais c'est la méthode qui
compte, pas le verdict.

### La cinématique

*Dans quel sens cette pièce peut-elle bouger, et qu'est-ce qui l'en empêche ?*

Le rail de guidage portait un crochet censé l'empêcher de sortir. Trois vérifications
successives avaient mesuré ses sections, son jeu, sa matière. Aucune n'avait posé cette
question. Quand elle l'a été, l'analyse a pris trois lignes :

> Le crochet est en y = 120, la face avant de la plaque en y = 120. Si le rail recule, le
> crochet appuie contre elle : bloqué. S'il **avance**, le crochet s'éloigne et le rail
> sort librement.

Le crochet était donc à la fois **redondant** — le recul était déjà limité à 1 mm par la
butée du fond — et **inutile pour la seule direction qui comptait**. La correction : le
reculer de 40 mm, exactement la profondeur d'une plaque, pour qu'il porte contre sa face
*arrière*.

Les sections ne voient jamais ce genre de chose.

### L'imprimabilité

Porte-à-faux, pontages, orientation des couches vis-à-vis de la charge.

Et c'est là que la correction précédente a créé un défaut nouveau. Le talon reculé
descendait de 5 mm sous le fond du rail — or le rail s'imprime précisément **posé sur ce
fond**. Il aurait fallu surélever 236 mm de pièce sur support. La consigne « aucun
support » écrite trois messages plus tôt était devenue fausse.

La correction tient en une idée : rien n'oblige un talon à descendre. Il ne doit pas
traverser l'encoche, et pour ça il suffit qu'il soit **plus large** qu'elle. Il s'évase
donc latéralement, à partir du même fond plat.

| | avant | après |
|---|---|---|
| Encombrement | 19,4 × 236 × 10,07 mm | **26,0 × 236 × 4,77 mm** |
| Matière sous le fond | oui | **non** |
| Supports | sur 236 mm | **aucun** |

**Leçon générale : une modification de forme peut invalider une contrainte de fabrication
établie plus tôt.** C'est une régression qu'aucune mesure de section ne détecte, et il
faut la revérifier explicitement après chaque changement de géométrie.

### La fraîcheur

Les sorties viennent-elles bien du source actuel ?

Une génération lancée en tâche de fond continue de tourner pendant qu'on modifie le
fichier. Les rendus se retrouvent alors issus de versions différentes, sans que rien ne
le signale. Une vue d'ensemble avec **plus d'une heure de retard** sur son source a ainsi
été publiée dans l'aperçu partagé.

D'où un garde-fou ajouté dans la foulée : chaque sortie produite est inscrite dans un
manifeste avec l'empreinte SHA-256 des sources dont elle vient — le fichier du modèle
*et* la bibliothèque partagée, puisqu'un module commun périme aussi les rendus.

```bash
python scripts/scad.py check <slug>
```

sort en code 1 et nomme les fichiers fautifs. L'outil de publication refuse de partir
tant qu'il en reste un.

## Le vrai adversaire : les pannes silencieuses

Un fil traverse toute la journée : **rien n'a jamais levé d'erreur.**

La bride de fixation a purement et simplement disparu d'un modèle qui compilait sans un
mot. En cause, un arrondi de coin trop grand pour la pièce : `6 − 2×4` fait −2, et
OpenSCAD accepte sans broncher un carré de hauteur négative. Profil vide, aucune erreur,
deux colliers flottant dans le vide sur le rendu.

Rien ne l'aurait attrapé, sinon **regarder l'image**.

Autres pannes muettes de la même journée :

- Un `$fa = 1` produisant 360 segments sur un alésage de Ø 69 et portant un rendu à plus
  de sept minutes. À `$fa = 3`, la flèche tombe à 0,011 mm — très en deçà de ce qu'une
  buse de 0,4 mm reproduit — et le rendu à moins de deux.
- Un `cmp` criant « différent » sur deux géométries rigoureusement identiques, parce
  qu'il opposait un export binaire à un export ASCII. Il fallait comparer le nombre de
  triangles (51 600 de part et d'autre), de sommets distincts et l'encombrement.
- Une tête de vis annoncée de mémoire à 8,4 mm, alors que la norme DIN 965 donne
  **7,5 mm maximum** pour du M4.

## Pourquoi ça a mieux marché qu'un script copié-collé

Le workflow précédent de l'auteur : demander un script OpenSCAD à un modèle, le coller
dans un playground en ligne, regarder, décrire ce qui cloche. Résultat jugé « assez
médiocre ».

Trois explications possibles, classées par la quantité de preuves que cette journée
apporte.

**1. La boucle s'est fermée.** De loin la mieux étayée. Dans le workflow copier-coller,
le modèle ne voit jamais le résultat. Ici, trois canaux de retour distincts ont fonctionné,
et chacun a attrapé ce que les deux autres ne voyaient pas :

- **exécuter** le code → l'explosion du temps de calcul, l'export en ASCII
- **regarder** les images → la bride évaporée
- **mesurer** le maillage → le diamètre inscrit, l'identité des plaques, la hauteur du talon

**2. L'humain était dans la boucle**, avec une intuition physique. Indépendant du modèle.

**3. La capacité brute du modèle.** Plausible, invérifiable ici. Ce qu'on observe : les
raisonnements décisifs — la dérive de ±50 mm, la distinction inscrit/circonscrit, le sens
de l'aronde — sont de l'arithmétique et de la géométrie élémentaires. Les erreurs commises
n'étaient pas des échecs de raisonnement mais **des échecs d'attention** : oublier de
revérifier une contrainte posée trois messages plus tôt. Ça penche pour l'outillage
plutôt que pour le modèle.

### Une nuance qui compte

On dit volontiers « le résultat est validé s'il correspond au prompt ». Ce n'est pas ce
qui s'est passé, et la distinction est importante.

Le prompt était satisfait **par la toute première version** — celle dont la bride avait
disparu. Ce qui a validé le résultat, ce sont des **mesures** et le **jugement de
l'humain**. Un assistant qui s'autovalide contre sa propre compréhension de la demande
tourne en rond.

## Ce qui reste

Le rack coûte trois euros de PLA. Ce qui a de la valeur, c'est ce qui se transporte au
modèle suivant — 1 605 lignes, sans une seule référence à cette pièce précise :

| | lignes | rôle |
|---|---|---|
| le pilote OpenSCAD | 428 | rendus, coupes, tranches, dessins, STL, encombrement, péremption |
| l'aperçu web | 619 | viewer 3D et planche de rendus, publiables |
| les conventions et la méthode | 333 | ce document et ses règles |
| les modules de coupe, l'installation des libs | 127 | |

Mais **le vrai mécanisme de réutilisation est le fichier d'instructions du dépôt.** Chaque
leçon de la journée y est écrite, et il est réinjecté au début de chaque session. Le
prochain modèle démarre donc avec les quatre vérifications, l'obligation de regarder les
rendus, les bornes de paramètres déjà payées. Ce n'est pas la mémoire de l'assistant qui
porte l'apprentissage — c'est le dépôt. C'est ce qui rend l'exercice cumulatif au lieu
d'être un coup unique.

Un mot sur l'outillage local face à un playground en ligne : le playground donne un
visualiseur, il ne donne pas de quoi **mesurer**. Tout le contrôle décrit ici repose sur
la possibilité de relire le STL exporté et d'en compter les triangles, d'en calculer un
diamètre inscrit, de vérifier qu'aucune matière ne descend sous le plan d'impression.

## L'honnêteté finale

**Rien n'a encore été imprimé au moment d'écrire ces lignes.**

Une plaque était en cours sur le plateau, les deux autres pièces attendaient. Tout ce qui
précède a été vérifié sur des maillages, jamais sur du plastique. Le jeu de 0,3 mm de la
queue d'aronde est peut-être trop serré ; le talon casse peut-être au montage ; le
cylindre entre peut-être moins bien que les 2,978 mm calculés ne le laissent croire.

C'est la cinquième vérification, et c'est la seule qu'aucun outil ne remplace.

---

*Le dépôt : [github.com/salfab/3d-printing-models](https://github.com/salfab/3d-printing-models)*
