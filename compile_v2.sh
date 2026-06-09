#!/bin/bash
# =============================================================================
#  Fabrique le PDF à partir du fichier LaTeX  ·  "Une année avec Mango"
#
#  USAGE :  ./compile_v2.sh
#
#  Ce script compile livret_lecture_CE1_v2.tex  →  livret_lecture_CE1_v2.pdf,
#  puis l'ouvre.
#
#  La SOURCE du livret, c'est livret_lecture_CE1_v2.tex : on l'édite à la main
#  (texte, mise en page, images), puis on relance ./compile_v2.sh. Il n'y a pas
#  d'autre fichier à régénérer — tout est dans le .tex.
#
#  Astuce : pour qu'un chapitre tienne sur une page, ajuste la taille dans son
#  \storyfont{...} (au début du chapitre, ex. \storyfont{12}).
#
#  Pré-requis : BasicTeX (xelatex).
# =============================================================================

set -e
cd "$(dirname "$0")"

# Rend xelatex / BasicTeX visible (il n'est pas dans le PATH par défaut).
eval "$(/usr/libexec/path_helper)"

if ! command -v xelatex >/dev/null 2>&1; then
  echo "❌  'xelatex' est introuvable."
  echo "    → brew install --cask basictex   (puis rouvre le terminal)"
  exit 1
fi

if [ ! -f livret_lecture_CE1_v2.tex ]; then
  echo "❌  livret_lecture_CE1_v2.tex est introuvable."
  exit 1
fi

echo "1/2  Fabrication du PDF (2 passages) ..."
xelatex -interaction=nonstopmode livret_lecture_CE1_v2.tex >/dev/null
xelatex -interaction=nonstopmode livret_lecture_CE1_v2.tex >/dev/null

# Nettoyage des fichiers temporaires de LaTeX.
rm -f livret_lecture_CE1_v2.aux livret_lecture_CE1_v2.log livret_lecture_CE1_v2.out

echo "2/2  Terminé ✅  →  livret_lecture_CE1_v2.pdf"
open livret_lecture_CE1_v2.pdf
