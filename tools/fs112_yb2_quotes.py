#!/usr/bin/env python3
"""FS112-YB2's quotation check (standing rule 5): every quotation in my brief, instance file and record, found verbatim in its source.

Normalisation (stated): whitespace collapsed; typographic quotes and apostrophes mapped to ASCII; the ligatures fi, fl expanded; a line break
after a hyphen dropped (the hyphen kept); PDF text read in plain and -layout modes (plain mode dehyphenates by itself).  A quotation that
matches only without its terminal period is reported as such, never as FOUND.  A quotation is FOUND iff its normalised text is a substring of its normalised source.  --self-test alters one word of a
quotation and checks that it is then MISSING while the faithful twin is FOUND (a check that can fail).
Run: python3 tools/fs112_yb2_quotes.py [--self-test]
"""
from __future__ import annotations
import os
import re
import subprocess
import sys

HOME = os.path.expanduser("~")
REPO = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")
AXE = os.path.join(HOME, "source/library/pdf/axenovich-2014-chromatic-number-subsets-euclidean-plane.pdf")
PM21 = os.path.join(HOME, "source/library/geombinatorics/geombinatorics-v30-n4-2021-04.pdf")
PM16 = os.path.join(HOME, "source/library/notes/polymath16-threads-1-18-text.txt")


def norm(s: str) -> str:
    s = s.replace("’", "'").replace("‘", "'").replace("“", '"').replace("”", '"')
    s = s.replace("ﬁ", "fi").replace("ﬂ", "fl")
    s = re.sub(r"-[ \t]*\n\s*", "-", s)     # a hyphen at a line end is kept (a printed "unit-edge"); the line break dropped
    return re.sub(r"\s+", " ", s).strip()


def pdf(path, first, last):
    """the text layer twice: plain (pdftotext dehyphenates line ends itself) and -layout (keeps a printed hyphen such as "unit-/edge")."""
    outs = []
    for extra in ([], ["-layout"]):
        outs.append(subprocess.run(["pdftotext", *extra, "-f", str(first), "-l", str(last), path, "-"],
                                   capture_output=True, text=True, check=True).stdout)
    return "\n\n".join(outs)


def file(path):
    with open(path, encoding="utf-8") as f:
        return f.read()


SOURCES = {
    "Axenovich p.8": lambda: pdf(AXE, 8, 9),
    "Polymath2021 pp.194-200": lambda: pdf(PM21, 30, 36),
    "Polymath16 threads": lambda: file(PM16),
    "CLAUDE.md": lambda: file(os.path.join(REPO, "CLAUDE.md")),
    "CONSOLIDATION": lambda: file(os.path.join(REPO, "plans/CONSOLIDATION-2026-09-27.md")),
    "claims.md": lambda: file(os.path.join(REPO, "data/fs112/claims.md")),
}

QUOTES = [
    ("brief step 2; claims §7 CAL-STRIP", "Axenovich p.8",
     "The symmetric tiles have width 1/2, with the rounded boundary being a circular arc of radius 1 centered at the opposite corner of the tile. "
     "The tiles used in the top and bottom rows are determined by the distance 1 between the point of intersection of circular arcs and the "
     "opposite corner of a tile."),
    ("instance O1 ([11.34])", "Polymath16 threads", "a skeleton from five connected regular pentagons with unit edges"),
    ("[11.34] radius (record)", "Polymath16 threads",
     "Minimum radius of 6-flower is $r=\\frac{1+\\sqrt5}{2} \\sqrt{\\frac{15+\\sqrt5}{10}} \\approx 2.12426$"),
    ("[07.49] (record)", "Polymath16 threads", "I think it is possible to get beyond a radius of 2 with something like this"),
    ("[07.50] (record)", "Polymath16 threads", "(Same thing at the equivalent tiles at multiples of 72 degrees rotated, of course.)"),
    ("[16.346] (record)", "Polymath16 threads",
     "In the dual graphs, they both have quads on the interior, and triangles on the exterior. Arrows in the dual graph correspond to curved "
     "edges in the tile graph. Each quad in the dual graph “emits” four arrows."),
    ("[16.106] (record)", "Polymath16 threads", "a {1,3,5,6} junction (at 2 o’clock on the central tile of the main disc; call it B)"),
    ("[16.91] (record)", "Polymath16 threads", "Interestingly, they can all be one colour: they come in Siamese pairs."),
    ("claims §7 CAL-DISK, p.199", "Polymath2021 pp.194-200", "For k = 6, our best result is the disk shown in Fig. 10, whose radius"),
    ("claims §7 CAL-DISK, p.199", "Polymath2021 pp.194-200",
     "(The relative simplicity of the expression for this radius arises because the points A,B,C,D,E lie at the vertices of a unit-edge regular "
     "pentagon.)"),
    ("claims §7 CAL-DISK, p.198", "Polymath2021 pp.194-200", "Note that we again employ the tactic of drawing inter-tile boundaries as arcs of radius 1"),
    ("claims §0, p.194's tactic", "Polymath2021 pp.194-200",
     "a tile T of color 1 can share a boundary segment E with a tile U of color 2 and also a point P with a tile V also of color 2, if E is drawn "
     "as an arc of radius 1 centered on P"),
    ("claims §7 caption (text layer part)", "Polymath2021 pp.194-200", "A 6-tiling of a disk of radius"),
    ("standing rule 0", "CLAUDE.md",
     "From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. You are capable, and you will "
     "surprise yourself."),
    ("standing rule 3", "CLAUDE.md",
     "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time"),
    ("standing rule 3", "CLAUDE.md", "search for a finite graph is out. It would be huge, not feasible."),
    ("standing rule 4", "CLAUDE.md", "A proven theorem about why its impossible is also valid. All novel knowledge is a success."),
    ("standing rule 10", "CONSOLIDATION",
     "It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress."),
    ("claims §6 C-ARC-END (record)", "claims.md",
     "the end vertices of a unit arc of a tight map are realised in a fully coloured neighbourhood (an **arc-closed**"),
    ("claims §0 contact kinds (record)", "claims.md",
     "**out-contact** — `s_out ∈ P_cl(P)`: two tiles of colour `s_out` at distance exactly 1 along `α`"),
]


def run(quotes):
    cache, rows = {}, []
    for where, src, q in quotes:
        if src not in cache:
            cache[src] = norm(SOURCES[src]())
        nq = norm(q)
        if nq in cache[src]:
            v = "FOUND"
        elif nq.endswith(".") and nq[:-1] in cache[src]:
            v = "FOUND up to a terminal period"          # reported, never counted as FOUND
        else:
            v = "MISSING"
        rows.append((where, src, v, q))
    return rows


def main():
    if "--self-test" in sys.argv:
        where, src, q = QUOTES[0]
        bad = q.replace("width 1/2", "width 1/3")
        rows = run([(where, src, q), (where + " (altered)", src, bad)])
        ok = rows[0][2] == "FOUND" and rows[1][2] == "MISSING"
        print(f"self-test: faithful FOUND={rows[0][2]}, altered FOUND={rows[1][2]} -> {'PASS' if ok else 'FAIL'}")
        sys.exit(0 if ok else 1)
    rows = run(QUOTES)
    for where, src, found, q in rows:
        print(f"{found:30s} | {src:24s} | {where:38s} | {q[:60]}")
    n = sum(r[2] == "FOUND" for r in rows)
    print(f"{n} of {len(rows)} FOUND verbatim; the rest listed above with their verdicts")
    sys.exit(0 if n == len(rows) else 1)


if __name__ == "__main__":
    main()
