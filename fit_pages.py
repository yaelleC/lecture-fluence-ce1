#!/usr/bin/env python3
"""Wrap each chapter of livret_lecture_CE1_v2.tex in a per-chapter font size so
that every chapter (story + questions + tracking table) fits on EXACTLY one page.

Idempotent: re-running it first strips any previous wrappers, then re-injects
using the sizes in CHAPTER_FONTSIZE below. Tune the numbers and re-run, then
recompile with ./compile_v2.sh.

The wrappers are marked with "% <<FIT n>>" / "% <<FIT END n>>" sentinel
comments so they can be cleanly found and removed on the next run. The group
is opened just after the \\newpage that precedes a chapter and closed at the
next \\newpage, so the whole chapter (title + story + questions + table) is
typeset at the chosen size.
"""

import re

TEX = "livret_lecture_CE1_v2.tex"

# chapter number -> body font size in pt (baseline is 1.2x, see \storyfont).
# Larger = easier for a young reader; we keep each as large as fits one page.
CHAPTER_FONTSIZE = {
    1: 12, 2: 13, 3: 13, 4: 12,
    5: 12, 6: 12, 7: 12, 8: 11,
    9: 10, 10: 10, 11: 11, 12: 10,
    # Section 4 has no "Mon suivi de lecture" table, so it can run larger.
    13: 11, 14: 11, 15: 10, 16: 10,
}


def strip_existing(text):
    # Remove previously injected wrapper lines (idempotency).
    text = re.sub(r"^% <<FIT \d+>>\n", "", text, flags=re.MULTILINE)
    text = re.sub(r"^\{\\storyfont\{\d+\}%\n", "", text, flags=re.MULTILINE)
    text = re.sub(r"^\}% <<FIT END \d+>>\n", "", text, flags=re.MULTILINE)
    return text


def next_chapter_num(lines, start):
    """If the next non-blank line at/after `start` is a chapter section, return
    its number, else None."""
    for j in range(start, min(start + 5, len(lines))):
        if lines[j].strip() == "":
            continue
        m = re.match(r"\\section\{Chapitre (\d+)", lines[j])
        return int(m.group(1)) if m else None
    return None


def main():
    text = open(TEX, encoding="utf-8").read()
    text = strip_existing(text)
    lines = text.split("\n")

    out = []
    open_chapter = None
    for i, line in enumerate(lines):
        is_boundary = (line.strip() == r"\newpage")

        # Close the current chapter group at the next page break.
        if is_boundary and open_chapter is not None:
            out.append(r"}%% <<FIT END %d>>" % open_chapter)
            open_chapter = None

        out.append(line)

        # Open a new chapter group right after a \newpage that precedes a chapter.
        if is_boundary:
            n = next_chapter_num(lines, i + 1)
            size = CHAPTER_FONTSIZE.get(n) if n else None
            if size:
                out.append(r"%% <<FIT %d>>" % n)
                out.append(r"{\storyfont{%d}%%" % size)
                open_chapter = n

    if open_chapter is not None:  # safeguard; last chapter is followed by \newpage
        out.append(r"}%% <<FIT END %d>>" % open_chapter)

    open(TEX, "w", encoding="utf-8").write("\n".join(out))
    print("Wrapped chapters:", ", ".join(str(k) for k in sorted(CHAPTER_FONTSIZE)))


if __name__ == "__main__":
    main()
