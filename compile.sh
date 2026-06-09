#!/bin/bash
# Compile livret_lecture_CE1.tex to PDF.
# Two xelatex passes (so tables settle), then clean up and open.

set -e

cd "$(dirname "$0")"
eval "$(/usr/libexec/path_helper)"

xelatex -interaction=nonstopmode livret_lecture_CE1.tex
xelatex -interaction=nonstopmode livret_lecture_CE1.tex

rm -f livret_lecture_CE1.aux livret_lecture_CE1.log livret_lecture_CE1.out

open livret_lecture_CE1.pdf
