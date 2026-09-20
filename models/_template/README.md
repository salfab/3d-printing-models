# _template

> Squelette de README de modèle. Copier ce fichier avec le `.scad`, puis remplacer
> chaque section. Supprimer ce bloc de citation.

Un paragraphe : à quoi sert la pièce, dans quel contexte elle s'emploie, et ce qui a
motivé sa forme générale.

## Objet visé

Ce que la pièce doit accueillir ou remplacer, avec ses dimensions et **la source de ces
dimensions** — mesuré au pied à coulisse, relevé sur une fiche produit, déduit d'une
norme. Signaler franchement celles qui restent à vérifier.

## Pièces à imprimer

| Pièce | `PIECE=` | Quantité |
|---|---|---|
| … | `…` | 1 |

```bash
python scripts/scad.py stl <slug> -D PIECE=… --binaire
```

## Cotes principales

| | |
|---|---|
| … | … mm |

Préférer les valeurs **mesurées sur le maillage exporté** à celles du source :

```bash
python scripts/scad.py info <slug>
```

## Montage

Quand l'ordre des opérations compte, le donner numéroté, et dire **pourquoi** il compte.
Les erreurs de montage viennent presque toujours d'un enchaînement dont la raison
n'était écrite nulle part.

## Impression

- Orientation de chaque pièce sur le plateau, et ce qu'elle évite : supports, pontages,
  couches travaillant en pelage.
- Matière, nombre de périmètres, remplissage.

## Contraintes à connaître avant de modifier

Les bornes des paramètres et ce qui casse au-delà. Section la plus utile du document, et
la plus vite oubliée : la remplir au moment où on découvre la contrainte, jamais après.

## Points de vérification

Ce qui reste incertain, et quelle mesure trancherait.
