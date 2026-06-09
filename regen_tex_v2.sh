#!/bin/bash
# =============================================================================
#  (Re)génère le fichier LaTeX à partir du texte Markdown  ·  v2
#
#  USAGE :  ./regen_tex_v2.sh
#
#  À utiliser quand tu as modifié l'HISTOIRE (livret_lecture_CE1_v2.md) ou
#  ajouté des images dans img/. Ce script reconstruit livret_lecture_CE1_v2.tex
#  depuis le Markdown (pandoc + mise en page + images).
#
#  ⚠️  ATTENTION : cela ÉCRASE livret_lecture_CE1_v2.tex et donc toutes les
#  retouches faites à la main dans ce fichier .tex. Pour te protéger, une
#  sauvegarde horodatée du .tex est créée AVANT (livret_lecture_CE1_v2.tex.SAUVE-…).
#
#  Ce script ne compile pas le PDF : lance ./compile_v2.sh ensuite.
#
#  Pré-requis : pandoc, python3.
# =============================================================================

set -e
cd "$(dirname "$0")"
eval "$(/usr/libexec/path_helper)"

for tool in pandoc python3; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    echo "❌  '$tool' est introuvable. Installe-le puis relance ./regen_tex_v2.sh"
    [ "$tool" = "pandoc" ] && echo "    → brew install pandoc"
    exit 1
  fi
done

# Sauvegarde du .tex existant avant de l'écraser.
if [ -f livret_lecture_CE1_v2.tex ]; then
  BACKUP="livret_lecture_CE1_v2.tex.SAUVE-$(date +%Y%m%d-%H%M%S)"
  cp livret_lecture_CE1_v2.tex "$BACKUP"
  echo "💾  Sauvegarde de ton .tex actuel  →  $BACKUP"
fi

echo "1/2  Texte (Markdown) → LaTeX ..."
pandoc livret_lecture_CE1_v2.md -o livret_lecture_CE1_v2.tex \
  --standalone --include-in-header=header.tex \
  -V documentclass=extarticle \
  -V classoption=french -V classoption=14pt -V classoption=a4paper \
  -V mainfont="Verdana" -V geometry:margin=2cm -V lang=fr-FR

echo "2/3  Mise en page (titres de section + images du dossier img/) ..."
python3 fix_v2_tex.py

echo "3/3  Taille de police par chapitre (1 chapitre = 1 page) ..."
python3 fit_pages.py

echo
echo "✅  livret_lecture_CE1_v2.tex régénéré. Compile-le avec : ./compile_v2.sh"
