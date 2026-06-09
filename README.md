# Livret de Lecture — Fluence CE1

Un livret imprimable, en français, pour aider les enfants de CE1 (7–8 ans) à progresser en fluence de lecture. Les textes sont originaux, progressifs, et conçus pour des lecteurs qui ont besoin d'un coup de pouce.

> *A printable French reading-fluency booklet for 2nd-grade kids (ages 7–8). 16 original texts, four difficulty tiers, comprehension questions and a time tracker on every page.*

---

## Télécharger le livret

➡️ **[Télécharger le PDF](../../releases/latest/download/livret_lecture_CE1_v2.pdf)**
(format A4, prêt à imprimer)

---

## Ce que contient le livret

- **16 textes originaux** en français, du plus court au plus long
- **4 sections de difficulté croissante** :
  1. **Textes courts** (~180 mots, ~2 min)
  2. **Niveau 1** (~270 mots, ~3 min)
  3. **Niveau 2** (~360 mots, ~4 min)
  4. **Niveau 3** (~450 mots, ~5 min, niveau CE1 complet)
- Pour chaque texte : **questions de compréhension** (+ un **tableau de suivi** du temps de lecture pour les sections 1 à 3 ; la section 4 laisse un espace libre pour noter)
- Une **page de présentation** par section, avec les temps de référence (CP, CE1, CE2)

---

## Pour qui ?

Pour les **parents**, **enseignant·e·s**, **orthophonistes** et toute personne qui accompagne un enfant qui :

- lit en dessous de la fluence attendue à son âge,
- a besoin de textes engageants à la bonne difficulté,
- aime mesurer ses propres progrès.

---

## Comment l'utiliser

1. Télécharge le PDF et imprime-le (A4, recto seul de préférence).
2. Lis le texte une première fois **avec l'enfant**, sans chronomètre.
3. La fois suivante, **l'enfant lit seul·e**, en se chronométrant.
4. Notez le temps dans le tableau de suivi.
5. **Refaites le même texte** quelques jours plus tard — la vitesse augmente presque toujours, et c'est très motivant.
6. Discutez du texte avec les **questions de compréhension** — lire, ce n'est pas seulement déchiffrer, c'est aussi comprendre.

---

## Donner ton avis / Raconter ton expérience

Si ce livret a aidé un enfant, j'aimerais beaucoup le savoir !

➡️ **[Laisser un message](https://forms.gle/XMzsfRFwtjkXsNPV8)** 

Tu peux aussi ouvrir une *issue* directement ici sur GitHub.

---

## Construire le PDF depuis les sources

Si tu veux **adapter le livret** (changer le prénom, le ton, ajouter un texte…), tout est dans **le fichier `tex` source** 

- `livret_lecture_CE1_v2.tex` — **la source** : le texte, la mise en page et les images, tout s'édite ici
- `compile_v2.sh` — compile le `.tex` en PDF (et l'ouvre)
- `img/` — images des textes

> Une version antérieure (`livret_lecture_CE1.*`, `compile.sh`) est conservée dans le dépôt pour référence. Il s'agit d'un livret avec 16 textes indépendants au lieu d'un seule histoire à 16 chapitres.

Pour reconstruire le PDF après avoir modifié le texte :

```bash
./compile_v2.sh     # LaTeX → PDF
```

(Nécessite **BasicTeX** ou **MacTeX** avec les paquets `wrapfig`, `tabularx`. Pour qu'un chapitre tienne sur exactement une page, ajuste la taille dans son `\storyfont{...}` au début du chapitre — par exemple `\storyfont{12}`.)

---

### Conseils typographiques pour les enfants en difficulté de lecture

- Police lisible : **OpenDyslexic**, **Lexend**, **Andika**, ou à défaut Verdana, Comic Sans MS.
- Taille : 14 à 16 points pour le corps de texte.
- Interligne : 1,5.
- Texte aligné à gauche (jamais justifié).
- Marges généreuses sur les côtés.

---

## Licence

Ce livret est distribué sous licence **[Creative Commons BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.fr)**.

Tu peux librement :
- ✅ **Le télécharger**, l'imprimer et le partager
- ✅ **Le modifier**, l'adapter, le traduire (par exemple pour un autre prénom)
- ✅ **Le redistribuer**, gratuitement

À condition de :
- ❌ **Ne pas l'utiliser à des fins commerciales** (pas de vente, pas inclus dans un produit payant)
- 🔁 **Garder la même licence libre** pour tes adaptations (partage dans les mêmes conditions)
- ✍️ **Mentionner les autrices originales**

---

## Autrices

Yaëlle et Camille Chaudy

---

*Si ce livret t'a aidé·e, le plus beau remerciement, c'est de le partager à une autre famille qui en aurait besoin.*
