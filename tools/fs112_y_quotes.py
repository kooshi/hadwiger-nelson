#!/usr/bin/env python3
"""FS112-Y stage 1: the quotation check (standing rule 5).

Every quotation the job FS112-Y relies on is searched, verbatim up to whitespace, typographic quotes and ligatures, in
its source.  PDF sources are read through `pdftotext -layout`.  A quotation not found is printed MISSING and the exit
status is 1.  `--self-test` plants a one-word alteration in a faithful quotation and requires it to be MISSING while the
faithful twin is FOUND.
"""
from __future__ import annotations
import re, subprocess, sys, os

HOME = os.path.expanduser("~")
LIB = f"{HOME}/source/library"


def norm(s: str) -> str:
    s = s.replace("’", "'").replace("‘", "'").replace("“", '"').replace("”", '"')
    s = s.replace("ﬁ", "fi").replace("ﬂ", "fl").replace("–", "-").replace("—", "-")
    s = s.replace("`", "")
    return re.sub(r"\s+", " ", s).strip()


_cache: dict[str, str] = {}


def text(src: str) -> str:
    if src not in _cache:
        if src.endswith(".pdf"):
            out = subprocess.run(["pdftotext", "-layout", src, "-"], capture_output=True, text=True, check=True).stdout
        else:
            out = open(src, encoding="utf-8").read()
        # a line-final hyphen is either a soft hyphen (joined) or a real one (kept): both readings are kept
        _cache[src] = norm(out) + " \x00 " + norm(re.sub(r"-\n\s*", "", out)) + " \x00 " + norm(re.sub(r"-\n\s*", "-", out))
    return _cache[src]


QUOTES = [
    # (label, source, quotation)
    ("Kooshi aim", "CLAUDE.md", "My goal is to fully solve, and then verify in Lean, HN. Then we publish."),
    ("Kooshi ambition", "CLAUDE.md", "Let's see some ambition. I know we can do it."),
    ("Kooshi finite graph", "CLAUDE.md", "search for a finite graph is out. It would be huge, not feasible."),
    ("Q-full", "plans/STUB-unit-arc-half.md",
     "a locally finite map bounded by segments and circular arcs, arcs of radius 1 allowed, carrying a six-colouring in which no two "
     "interior points of one colour are at distance exactly 1."),
    ("C-CHAIN-1", "plans/FS110-derivation.md", "In a tight six-map in 𝓜_K under Condition 5 no vertex has four colours (nor five)."),
    ("C-CHAIN-2", "plans/FS110-derivation.md", "Under Condition 5 a tight six-map in 𝓜_K has no close covering pair."),
    ("C-CHAIN-3", "plans/FS110-derivation.md",
     "Contacts of a colour on ω(v) are in-type or out-type; directions of c-sectors lie in D_c(v); compact sets inside int D_c(v) are "
     "clear near v; tangent in- and out-contacts are upward closed."),
    ("C-CHAIN-4", "plans/FS110-derivation.md",
     "Woodall's step 3 almost everywhere for curved arcs: if int D_c(v) is nonempty, two non-adjacent c-sectors at v are joined by "
     "recolouring the gap inside D_c(v) near v; validity and Condition 5 kept, types only shrink."),
    ("C-CHAIN-5", "plans/FS110-derivation.md",
     "int D_c(v) is empty only in Woodall's cone: out-type c-contacts at both v ± n, every c-sector a cusp horn along ±a with bounding "
     "curvatures in (−1, 1)."),
    ("C-CHAIN-6", "plans/FS110-derivation.md",
     "The shadow near v of a tile at N = v + n beyond an arc tangent to a at N is one side of the circle through v concentric with that "
     "arc; curvature f(λ) = λ/(1 + λ) going down, f̃(υ) = υ/(1 − υ) going up; a horn is shadowed by its flanks only through out-type "
     "tiles at S′ and N tangent to a (N4-FLANK)."),
    ("C-CHAIN-7", "plans/FS110-derivation.md",
     "A horn tip can be recoloured by its two flank colours, valid and keeping Condition 5, unless doubly shadowed (σ_h < σ_g); two "
     "horns of one colour on one ray merge (N4-RAY)."),
    ("C-CHAIN-8", "plans/FS110-derivation.md",
     "At a vertex admitting no merge, ray merge or shave, a two-sector colour has exactly two horns ±a, the vertex has degree 4, and "
     "the antipodes carry P_cl(N) = {c, h, r}, P_cl(S′) = {c, g, r′} with double sectors; in a terminal map a stuck vertex forces "
     "stuck vertices at unit spacing along the normal line, bi-infinite (N4-PROP)."),
    ("C-CHAIN-9", "plans/FS110-derivation.md",
     "No bi-infinite sequence −1 < λ_k < υ_k < 1 with λ_k ≤ f(λ_{k+1}) and f̃(υ_{k−1}) ≤ υ_k."),
    ("C-CHAIN-10", "plans/FS110-derivation.md",
     "Every valid map has a terminal valid modification (each point changed finitely often), and in it no colour has two sectors at any "
     "vertex: every vertex is cubic, sectors possibly cusp horns (N4-CONE, N4-RED)."),
    ("C-CHAIN-11", "plans/FS110-derivation.md",
     "The terminal map's only surviving cusp horns are single horns that are doubly shadowed with D_c(v) the line ±a: single-horn "
     "Woodall cones."),
    ("C-CHAIN-12", "plans/FS110-derivation.md",
     "Under Condition 5 no vertex with exactly three sectors has a purely rotating ring (six 60° arcs)."),
    ("C-CHAIN-13", "plans/FS110-derivation.md",
     "S–V Corollary 1 holds almost everywhere for curved cubic maps under Condition 5 with no d = 2 exception, for same- and "
     "disjoint-multicolour pairs."),
    ("C-CHAIN-14", "plans/FS110-derivation.md",
     "S–V Lemma 3 holds almost everywhere for all 1 < d < 2, by Voronov's bicycle run on the two pseudo-coloured circles; the printed "
     "Fig. 5 argument fails from √3 on."),
    ("C-CHAIN-15", "plans/FS110-derivation.md",
     "The Antipodal Lemma: at a trichromatic cubic vertex u, cusps and double cusps allowed, no two M-in points of ω(u) are at distance "
     "2; it is one-sided, and two antipodal points may both have the strip inside."),
    ("C-CHAIN-16", "plans/FS110-derivation.md",
     "CB's D5 repaired by R1–R4 and the Antipodal Lemma: every pair the chain hands to S–V Lemma 3 or Cor. 3 is at distance below 2, "
     "at cusp centres and cusp endpoints included, so S–V Cor. 1 almost everywhere needs no d = 2 exception."),
    ("C-CHAIN-17", "plans/FS110-derivation.md",
     "CB's route holds at cubic vertices with a cusp or double cusp at D2's strip (a)–(c), D5 item 5 and D1's (P′); along a cusp's "
     "normal |u ± n − x(m)|² − 1 = 4R(R ∓ 1)m²/(1 + m²)."),
    ("C-CHAIN-18", "plans/FS110-derivation.md",
     "Under Condition 5 no locally finite map of the plane bounded by segments and circular arcs carries a full a.e.-proper "
     "six-colouring; the Condition-5 half of S–V Question 2 is answered yes, almost everywhere."),
    ("CAL-STRIP rule 1", f"{LIB}/pdf/axenovich-2014-chromatic-number-subsets-euclidean-plane.pdf",
     "The symmetric tiles have width 1/2, with the rounded boundary being a circular arc of radius 1 centered at the opposite corner of "
     "the tile."),
    ("CAL-STRIP rule 2", f"{LIB}/pdf/axenovich-2014-chromatic-number-subsets-euclidean-plane.pdf",
     "The tiles used in the top and bottom rows are determined by the distance 1 between the point of intersection of circular arcs and "
     "the opposite corner of a tile."),
    ("CAL-DISK p.199", f"{LIB}/geombinatorics/geombinatorics-v30-n4-2021-04.pdf",
     "For k = 6, our best result is the disk shown in Fig. 10, whose radius is"),
    ("CAL-DISK pentagon", f"{LIB}/geombinatorics/geombinatorics-v30-n4-2021-04.pdf",
     "(The relative simplicity of the expression for this radius arises because the points A,B,C,D,E lie at the vertices of a "
     "unit-edge regular pentagon.)"),
    ("Polymath p.194 tactic", f"{LIB}/geombinatorics/geombinatorics-v30-n4-2021-04.pdf",
     "a tile T of color 1 can share a boundary segment E with a tile U of color 2 and also a point P with a tile V also of color 2, if E "
     "is drawn as an arc of radius 1 centered on P"),
    ("[07.10] strip rule", f"{LIB}/notes/polymath16-threads-1-18-text.txt",
     "The curved lines are arcs at constant radius 1 from the opposite corner, so each vertex down the middle mandates four such curved "
     "edges, but they interdigitate without problems."),
    ("[11.34] disk skeleton", f"{LIB}/notes/polymath16-threads-1-18-text.txt",
     "One can see here a skeleton from five connected regular pentagons with unit edges (dotted lines)."),
    ("TS-U l.15", "plans/FS106-TS-derivation.md",
     "a unit-arc boundary with colours c | c′ puts c in the wedge facing it and c′ in the wedge facing away at its centre, and neither "
     "in the two side cones"),
    ("Thomassen p.850", f"{LIB}/papers/Thomassen-1999-On-the-Nelson-unit-distance-coloring-problem.txt",
     "each face (i.e., arcwise connected component of S\\G) has diameter less than 1, is homeomorphic to a disc, and is bounded by a "
     "cycle in G."),
    ("S-V Question 2", f"{LIB}/pdf/arXiv-2502.01958-maptype.pdf",
     "Is it true that 7 colors are needed to color a locally finite map in the plane if the boundaries can be arcs of unit circles and "
     "if trichromatic vertices of degree greater than 3 are allowed?"),
    ("S-V Corollary 3", f"{LIB}/pdf/arXiv-2502.01958-maptype.pdf",
     "There do not exist two trichromatic points with disjoint multicolors such that the distance between them is less than 2 and the "
     "boundaries between each pair of colors in their respective multicolor sets extend from each point."),
]


def found(src: str, q: str) -> bool:
    return norm(q) in text(src)


def main() -> int:
    if "--self-test" in sys.argv:
        src, q = QUOTES[4][1], QUOTES[4][2]
        planted = q.replace("four colours", "three colours")
        ok = found(src, q) and not found(src, planted)
        print("self-test:", "faithful FOUND, planted MISSING" if ok else "FAILED")
        return 0 if ok else 1
    bad = 0
    for label, src, q in QUOTES:
        f = found(src, q)
        bad += not f
        print(f"{'FOUND  ' if f else 'MISSING'} {label:24s} {os.path.basename(src)}")
    import math
    s = math.sqrt
    nums = [("√15/2 + √3 ≈ 3.66854", s(15) / 2 + s(3), 3.66854), ("√(5/2 + 9/(2√5)) ≈ 2.12426", s(5 / 2 + 9 / (2 * s(5))), 2.12426),
            ("(√15/2 + √3)/2 ≈ 1.834", (s(15) / 2 + s(3)) / 2, 1.834)]
    for lab, v, want in nums:
        ok = abs(v - want) < 5e-4 if want == 1.834 else abs(v - want) < 5e-6
        bad += not ok
        print(f"{'OK     ' if ok else 'WRONG  '} {lab:28s} computed {v:.6f}")
    print(f"{len(QUOTES)} quotations, {bad} not found or wrong")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
