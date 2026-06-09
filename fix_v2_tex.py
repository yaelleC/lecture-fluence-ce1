#!/usr/bin/env python3
"""Post-process the pandoc-generated livret_lecture_CE1_v2.tex:

  1. Turn the four "Section N --- Title" headings into the decorated
     \\sectiondivider command (defined in header.tex).
  2. Drop the right picture from img/ into each chapter.

For the images: each chapter has a target filename below. If that file
EXISTS in img/, it is placed in the chapter; if it does NOT exist yet, the
chapter keeps a clean "(image)" placeholder box. So to add a new picture,
just save it in img/ with the matching name and re-run the build — no need
to edit this script.
"""

import os
import re

TEX = "livret_lecture_CE1_v2.tex"
IMG_DIR = "img"

# chapter number -> image filename (without .png) expected in img/
CHAPTER_IMAGE = {
    1:  "ch01_camille",       # to generate
    2:  "amie",               # reused from v1
    3:  "cabane",             # reused
    4:  "ch04_nouvelle",      # to generate
    5:  "mango",              # reused
    6:  "ch06_tresor",        # to generate
    7:  "radis",              # reused
    8:  "patinoire",          # reused
    9:  "foret",              # reused
    10: "ch10_perdu",         # to generate
    11: "ch11_entrainement",  # to generate
    12: "medor",              # reused
    13: "mer",                # reused
    14: "saisons",            # reused
    15: "spectacle",          # reused
    16: "ch16_lettre",        # to generate
}

PLACEHOLDER = [
    r"\begin{wrapfigure}{r}{5cm}",
    r"\fbox{\begin{minipage}[c][5cm][c]{4.7cm}\centering\textit{(image)}\end{minipage}}",
    r"\end{wrapfigure}",
]


def image_block(name):
    return [
        r"\begin{wrapfigure}{r}{7cm}",
        r"\includegraphics[width=7cm]{img/%s.png}" % name,
        r"\end{wrapfigure}",
    ]


def main():
    src = open(TEX, encoding="utf-8").read()

    # 1) Section headings -> decorated dividers.
    def divider(m):
        num = m.group(1)
        title = " ".join(m.group(2).split())  # collapse wrapped whitespace
        return r"\sectiondivider{%s}{%s}" % (num, title)

    src = re.sub(r"\\section\{Section (\d) --- (.*?)\}\\label\{[^}]*\}",
                 divider, src, flags=re.DOTALL)

    # 2) Walk lines; swap each chapter's placeholder for its image if present.
    lines = src.split("\n")
    out, cur, i = [], None, 0
    placed, missing = [], []
    while i < len(lines):
        line = lines[i]
        m = re.match(r"\\section\{Chapitre (\d+)", line)
        if m:
            cur = int(m.group(1))
        if line == PLACEHOLDER[0] and lines[i + 1:i + 3] == PLACEHOLDER[1:3]:
            name = CHAPTER_IMAGE.get(cur)
            if name and os.path.exists(os.path.join(IMG_DIR, name + ".png")):
                out += image_block(name)
                placed.append((cur, name))
            else:
                out += PLACEHOLDER  # keep placeholder
                if name:
                    missing.append((cur, name))
            i += 3
            continue
        out.append(line)
        i += 1

    open(TEX, "w", encoding="utf-8").write("\n".join(out))

    print("Images placed: %d / 16" % len(placed))
    if missing:
        print("Still placeholders (save these PNGs in img/ to fill them in):")
        for ch, name in sorted(missing):
            print("  - chapitre %2d  ->  img/%s.png" % (ch, name))


if __name__ == "__main__":
    main()
