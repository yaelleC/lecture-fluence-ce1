#!/bin/bash
# =============================================================================
#  Fabrique le PDF à partir du fichier LaTeX  ·  "Une année avec Mango"
#
#  USAGE :  ./compile_v2.sh
#
#  Ce script compile livret_lecture_CE1_v2.tex  →  livret_lecture_CE1_v2.pdf,
#  puis l'ouvre.
#
#  IMPORTANT : ce script NE touche PAS au fichier .tex. Tu peux donc modifier
#  livret_lecture_CE1_v2.tex à la main (mise en page, images, etc.) et relancer
#  ./compile_v2.sh autant de fois que tu veux : tes modifications sont gardées.
#
#  (Pour repartir du texte Markdown — et donc ÉCRASER le .tex — utilise plutôt
#   ./regen_tex_v2.sh, qui fait d'abord une sauvegarde du .tex.)
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
  echo "    → génère-le d'abord depuis le texte avec : ./regen_tex_v2.sh"
  exit 1
fi

echo "1/2  Fabrication du PDF (2 passages) ..."
xelatex -interaction=nonstopmode livret_lecture_CE1_v2.tex >/dev/null
xelatex -interaction=nonstopmode livret_lecture_CE1_v2.tex >/dev/null

# Nettoyage des fichiers temporaires de LaTeX.
rm -f livret_lecture_CE1_v2.aux livret_lecture_CE1_v2.log livret_lecture_CE1_v2.out

echo "2/2  Terminé ✅  →  livret_lecture_CE1_v2.pdf"
open livret_lecture_CE1_v2.pdf
