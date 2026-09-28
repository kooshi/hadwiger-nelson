#!/usr/bin/env python3
"""FS114-N quotation check (standing rule 5): every quotation in the brief and the record, verbatim, against its source.

Whitespace (including line breaks and pdftotext layout padding) is collapsed to one space on both sides before the
search; nothing else is normalised, so a changed word, a changed letter or a changed punctuation mark is NOT FOUND.

Run:   python3 tools/fs114_n_quotes.py            -> one line per quotation, FOUND / NOT FOUND, exit 0 iff all FOUND
       python3 tools/fs114_n_quotes.py --plant    -> the planted fault (one quotation with one word changed) must be
                                                     NOT FOUND and its faithful twin FOUND; exit 0 iff both hold
Sources that are PDFs are read through `pdftotext -layout` into a temporary string (never written to the tree).
"""
import re
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
LIB = Path.home() / "source" / "library"

def text_of(src: str) -> str:
    p = Path(src)
    if not p.is_absolute():
        p = REPO / p
    if p.suffix == ".pdf":
        out = subprocess.run(["pdftotext", "-layout", str(p), "-"], capture_output=True, text=True, check=True)
        raw = out.stdout
    else:
        raw = p.read_text(encoding="utf-8")
    return re.sub(r"\s+", " ", raw)

def norm(q: str) -> str:
    return re.sub(r"\s+", " ", q).strip()

SV = str(LIB / "pdf" / "arXiv-2502.01958-maptype.pdf")
Z50 = str(LIB / "hadwiger-nelson-problem-group" / "threads" / "Z50mmulkXCQ.txt")
JTW = str(LIB / "hadwiger-nelson-problem-group" / "threads" / "J_Tw1_hUxQI.txt")
THOM = str(LIB / "papers" / "Thomassen-1999-On-the-Nelson-unit-distance-coloring-problem.txt")
AGO = str(LIB / "pdf" / "arXiv-2404.14398-agoston-nicely-colour-sphere.pdf")
MOH = str(LIB / "pdf" / "Mohar-2002-light-structures-infinite-planar.pdf")

QUOTES = [
    # (label, source, quotation)
    ("brief: Kooshi, the aim", "CLAUDE.md", "My goal is to fully solve, and then verify in Lean, HN. Then we publish."),
    ("brief: Kooshi, ambition", "CLAUDE.md", "Let's see some ambition. I know we can do it."),
    ("brief: S-V Question 2", SV, "Is it true that 7 colors are needed to color a locally finite map in the plane if the boundaries can be arcs of unit circles and if trichromatic vertices of degree greater than 3 are allowed?"),
    ("brief: card 2", "plans/POROS-2026-09-27-night-aim.md", "Is the unit-arc NO local — an explicit radius past which no valid fragment survives around a four-colour vertex — or visible only to a count over the whole plane, as Euler's formula and discharging give?"),
    ("brief: row 132 via CLAUDE.md link 4", "CLAUDE.md", "closedness enters once, as compactness giving a band"),
    ("brief: Kooshi's ruling", "CLAUDE.md", "search for a finite graph is out. It would be huge, not feasible."),
    ("brief: FS112-N3-DENSE3", "plans/FS112-derivation.md", "Every closed disc of radius 3 of every valid map holds a vertex of at least four colours or a vertex with a repeated colour."),
    ("claims 8: C114-FIVE-COUNT", JTW, "so 200% of the edges are curved, so a 5-coloring is impossible."),
    ("claims 8: C114-EDGE-RAINBOW", Z50, "Degree 6 isn't possible with only 6 colors."),
    ("claims 8: C114-DUAL-COUNT", Z50, "1 quad \"emits\" 4 curved edges. This is 2n edges (80% of all edges)."),
    ("claims 8: degree-4", JTW, "Allowing a degree-4 vertex can prevent curved edges adjacent to that vertex, but I think it creates another quad/pentagon."),
    ("claims 8: C114-ENCLOSED3", JTW, "So, a valid tiling can't have an enclosed vertex with 3 neighbors."),
    ("record: de Grey on Siamese", JTW, "a proof that we need 7 colours unless there are Siamese tiles would still be a really big result."),
    ("record: Thomassen Lemma 1", THOM, "Lemma 1. If G is a connected, locally finite, and locally Hamiltonian graph with at least 13 vertices, then G has a vertex of degree at least 6."),
    ("record: Thomassen rainbow step", THOM, "Now x and its neighbors must have distinct colors because x corresponds to a face of diameter < 1 on S."),
    ("record: Thomassen map graph", THOM, "We define the map graph M = M(G, S) as the graph whose vertices are the faces of G such that two vertices in M are neighbors if and only if the corresponding facial cycles in G intersect."),
    ("record: S-V radius 3", SV, "Note that all reasoning remains valid if we consider the interior of a circle of radius 3."),
    ("record: S-V Hausdorff dimension", SV, "But in this case, “pecularity” has Hausdorff dimension 1, not 0."),
    ("record: Agoston title, line 1 (the PDF sets the arXiv stamp between the title's two lines)", AGO, "A lower bound on the number of colours needed"),
    ("record: Agoston title, line 2", AGO, "to nicely colour a sphere"),
    ("record: Agoston plane via Euler", AGO, "Note that the statement for the plane also follows from a relatively easy proof using Lemma 7 and the fact that a triangulated planar graph has 3n − 6 edges."),
    ("record: Mohar abstract", MOH, "It is shown that the discharging method can be successfully applied on inﬁnite planar graphs of subexponential growth"),
]

PLANT = ("PLANT: C114-EDGE-RAINBOW with one word changed", Z50, "Degree 6 isn't possible with only 7 colors.")
TWIN = ("TWIN: the same quotation, faithful", Z50, "Degree 6 isn't possible with only 6 colors.")

def check(items):
    cache = {}
    results = []
    for label, src, q in items:
        if src not in cache:
            cache[src] = text_of(src)
        # pdftotext hyphenation/ligature artefacts are not repaired: a NOT FOUND there is reported, never patched
        t = cache[src]
        if norm(q) in t:
            results.append((label, src, "FOUND"))
        elif norm(q) in re.sub(r"(\w)- (\w)", r"\1\2", t):
            # a line-end hyphen of the source (OCR or pdftotext) removed: reported by name, never silently
            results.append((label, src, "FOUND after removing a line-end hyphen of the source"))
        else:
            results.append((label, src, "NOT FOUND"))
    return results

def main():
    if "--plant" in sys.argv:
        (pl, _, pf), (tl, _, tf) = check([PLANT, TWIN])
        print(f"{pf}  {pl}   (must be NOT FOUND)")
        print(f"{tf}  {tl}   (must be FOUND)")
        ok = pf == "NOT FOUND" and tf == "FOUND"
        print("PLANT FIRES FOR ITS OWN REASON" if ok else "PLANT DID NOT BEHAVE")
        sys.exit(0 if ok else 1)
    res = check(QUOTES)
    n = 0
    for label, src, verdict in res:
        n += verdict != "NOT FOUND"
        print(f"{verdict}  {label}  [{Path(src).name}]")
    print(f"{n} of {len(res)} FOUND")
    sys.exit(0 if n == len(res) else 1)

if __name__ == "__main__":
    main()
