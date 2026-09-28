#!/usr/bin/env python3
"""FS112-C2 stage 4: the stage-1b edits to plans/STUB-stuck-ray.md (FS-115) and plans/STUB-global-step.md (FS-114), exact replacements."""
import pathlib, sys
def apply(path, E):
    P = pathlib.Path('/home/kooshi/source/lean-dir') / path
    t = P.read_text()
    for o, n in E:
        c = t.count(o)
        if c != 1:
            print(path, 'COUNT', c, 'for:', o[:120]); sys.exit(1)
        t = t.replace(o, n)
    P.write_text(t); print(path, 'applied', len(E))

S = []
S.append(("# FS-115 — the stuck ray: can a one-sided chain of stuck vertices live in a six-map with unit arcs, and are finite chains bounded? (stub)",
          "# FS-115 — the stuck ray: can a one-sided chain of stuck vertices live in a six-map with unit arcs, are finite chains bounded, and does the one-vertex bowtie end live in one? (stub)"))
S.append(("`plans/FS112-derivation.md` §§1–3, and `data/fs112/fs112-c/reconciliation.md` §§1.5–1.6.*",
          "`plans/FS112-derivation.md` §§1–3 and its entries FS112-Y3-END-NEEDS and FS112-BOWTIE,\n`data/fs112/fs112-c/reconciliation.md` §§1.5–1.6 and 1.8–1.9 (stage 1b, FS112-C2), and `plans/FS112-YB3-verification.md` §3.1.*"))
S.append(("G21 (a local fragment is not a map; a finite chain is not a ray), G30 (the next discipline: dynamics of a parabolic map), G51, G17; rows 133–136; stubs\nFS-114, FS-111.",
          "G21 (a local fragment is not a map; a finite chain is not a ray), G30 (the next discipline: dynamics of a parabolic map), G51, G17, G71 (the index at a\n"
          "bowtie seam; FS-112's E12 untested); rows 133–136; stubs FS-114, FS-111."))
S.append(("> **Long chains (b″, named at FS-112's close).** Is the length of finite stuck chains bounded — uniformly over the map — or can a valid map carry finite\n"
          "> chains of every length? (N3-ALPH, the case of finitely many arc radii that is not periodic, is a sub-question.)",
          "> **Long chains (b″, named at FS-112's close).** Is the length of finite stuck chains bounded — uniformly over the map — or can a valid map carry finite\n"
          "> chains of every length? (N3-ALPH, the case of finitely many arc radii that is not periodic, is a sub-question.)\n"
          "> **The bowtie end (c, added at stage 1b of FS-112's close).** A stuck vertex whose two horns lie between the unit circles about its two neighbours on\n"
          "> the normal line — bounded by unit arcs above and below, shadowed by the unit-radius tactic's own in-type sectors at both neighbours — is a chain of one\n"
          "> vertex that ends at unit arcs on both sides. It exists as an exact local fragment (FS112-BOWTIE). Can it live in a valid map of the plane? And the\n"
          "> chain ends FS-112 did not walk: a unit arc bounding **one** horn only of a side (an (R2) arc), at a chain of any length."))
S.append(("- **What every end carries** (FS112-N3-END, two minds, one blind): at an end with horn bound `−1`, the next point carries at least four colours and a\n"
          "  repeated colour, and a both-kind unit arc is centred two steps beyond; with FS-112's close, **the point one step beyond every finite end has at least\n"
          "  four colours** (FS112-C-ENDS, one mind). So a ray's one end is anchored at a four-colour vertex; its vertices are repeated-colour vertices, consistent\n"
          "  with DENSE3 along its line.",
          "- **What every end carries** (FS112-N3-END, two minds, one blind): at an end with horn bound `−1`, the next point carries at least four colours and a\n"
          "  repeated colour, and a both-kind unit arc is centred two steps beyond — **or the chain is the single doubly bounded vertex**, N3-END's second disjunct;\n"
          "  with FS-112's close, **the point one step beyond every finite end has at least four colours** (FS112-C-ENDS, one mind, repaired at stage 1b for the\n"
          "  single vertex; its one residue below). So a ray's one end is anchored at a four-colour vertex; its vertices are repeated-colour vertices, consistent\n"
          "  with DENSE3 along its line."))
S.append(("- **Y3's end analysis** (FS112-Y3-END-NEEDS, one mind; its blind verifier FS112-YB3 was running at the close — read its record first): keeping the end\n"
          "  stuck and its unit-arc centre terminal needs at least five colours at the centre, and blocking both its MERGE and its SHAVE needs a seventh colour — so\n"
          "  **no stuck chain of a terminal map ends at a unit arc while its end vertex has three colours**. If it holds, horn-bound-`±1` ends do not occur, and a\n"
          "  ray's finite end, and every finite chain's ends, sit at a four-colour vertex of NB4P's kind or at an arc of the end vertex's own circle through the\n"
          "  next point. Two scope points the close named: its setting excludes FLANK's in-type exception at the centre (the count seems to close there too, not\n"
          "  said), and its corollary about periodic maps omits ends at four-colour vertices without a horn bound `±1`.",
          "- **The end analysis, corrected** (FS112-Y3-END-NEEDS; its levels two minds, one blind: Y3; YB3): if both horns of a stuck vertex `E` are bounded by unit\n"
          "  arcs of `ω(E + n)` and **neither** by a unit arc of `ω(E − n)`, keeping `E` stuck and `E + n` terminal needs five colours at `E + n` and a seventh at\n"
          "  `E + 2n` — so no such end exists. That covers every end of a chain of two or more vertices (FS112-END). **As Y3 stated it — every three-colour end at a\n"
          "  unit arc — it is FALSE** (FS112-YB3): its first requirement missed an in-type tile at `E − n`, possible exactly when `E`'s lower arcs are unit arcs of\n"
          "  `ω(E − n)`, and the one step the seventh colour needs that Y3 assumed (the lower flank at `E + n` is not `E`'s upper colour) is YB3's alone. Composed at\n"
          "  the close (FS112-C-HORNEND, one mind): **a horn bound `±1` on both horns of a stuck vertex of a terminal map occurs only at a one-vertex chain bounded\n"
          "  by unit arcs on both sides**; and when all four horn arcs are unit arcs, both neighbours carry in-type flank tiles and are (Q) centres with at least four\n"
          "  colours (FS112-C-DOUBLE, one mind, a sketch). So a ray's finite end, and every end of a chain of two or more vertices, sits where the next point is an\n"
          "  NB4P exception or carries an arc of the end vertex's own circle through it, or at a unit arc bounding one horn only — the case not walked. The close's\n"
          "  first scope point (FLANK's in-type exception at the centre) is settled: it does not occur at such an end (YB3, one mind); its second (Y3's periodic\n"
          "  corollary) is corrected in the reconciliation §1.9."))
S.append(("  exactly over ℚ with `N` completed two ways, neither terminal at `N` (FS112-Y3-END-AB, `tools/fs112_y3_chainend.py`). No ray, no terminal chain end,\n"
          "  no chain longer than three is held.",
          "  exactly over ℚ with `N` completed two ways, neither terminal at `N` (FS112-Y3-END-AB; two rebuilds, one blind: `tools/fs112_y3_chainend.py`,\n"
          "  `tools/fs112_yb3_frags.py enda endb`). **BOWTIE** (FS112-BOWTIE, `tools/fs112_yb3_frags.py bowtie`, exact, 21 / 21 pairs): `E = (0, 0)`, its colour-2\n"
          "  horns between `ω((0, 1))` and `ω((0, −1))`, the in-type sectors `G` (colour 1) about `(0, 1)` and `H` (colour 3) about `(0, −1)`, radius 1, half-angle\n"
          "  `arcsin(5/13)`; `E` stuck with three colours, both neighbours four-coloured and not stuck, locally terminal. It is FS112-N3-END's second disjunct in N3's\n"
          "  first description, built blind by the construction side's verifier. No ray, no terminal end of a chain of two or more vertices, no chain longer than\n"
          "  three is held."))
S.append(("4. A second mind on Y3-END-NEEDS (if FS112-YB3 did not settle it) and its two scope points.",
          "4. **The bowtie end (c).** Can FS112-BOWTIE's neighbourhood be completed: `E ± n` have four colours each, so their rings must meet NB4P (FS112-NB4P), and\n"
          "   the arc of `G` on `ω(E + n)` spans ≈ 45.2° — YB3's in-ban test, first. Then whether the configuration lives in a valid map, and YB3's question: can\n"
          "   every stuck vertex of a terminal map be read as a bowtie?\n"
          "5. **The ends not walked.** A unit arc bounding one horn only of a side (an (R2) arc), at a chain of any length: FS112-C-HORNEND's and FS112-C-DOUBLE's\n"
          "   hypotheses exclude it, and FS112-C-ENDS's one residue sits there (a one-vertex chain bounded by unit arcs on both sides but not on all four horn\n"
          "   arcs, at a bound on an (R2) arc). Second minds on FS112-C-HORNEND and FS112-C-DOUBLE."))
S.append(("5. **The transverse structure of a ray**", "6. **The transverse structure of a ray**"))
S.append(("`[08.45]`–`[08.65]`, de Grey's rules; `[06.62]`–`[07.33]`, Gibbs's degree-4 enumeration, whose outputs are unheld); zbMATH `au:\"Woodall, D\"` for any\nlater treatment of his cones.",
          "`[08.45]`–`[08.65]`, de Grey's rules; `[06.62]`–`[07.33]`, Gibbs's degree-4 enumeration, whose outputs are unheld — does it list the vertex between two\n"
          "tangent unit circles, BOWTIE's `E`?); zbMATH `au:\"Woodall, D\"` for any later treatment of his cones."))
S.append(("| Y3-END-NEEDS holds as stated (a second mind) | 0.6 | FS112-YB3's verdict, or a terminal end fragment with a three-colour end vertex |",
          "| BOWTIE's neighbourhood completes to a valid fragment containing the closed discs of radius 1 about both neighbours | 0.5 | an exact fragment by formula; or a derived obstruction at a named ring point |\n"
          "| the one-horn unit-arc end excluded as the two-horn one is (a seventh colour) | 0.55 | a derivation; or an exact terminal end fragment with one horn bounded by a unit arc |\n"
          "| a second mind confirms FS112-C-HORNEND and FS112-C-DOUBLE | 0.75 | a derivation; or a terminal doubly bounded vertex whose neighbour is an (R2) centre |"))
S.append(("verdicts on (b′), (b″) and N3-ALPH with their grades; the transverse structure of the extremal ray, derived.",
          "verdicts on (b′), (b″), N3-ALPH and the bowtie end (c) with their grades; the transverse structure of the extremal ray, derived."))
apply('plans/STUB-stuck-ray.md', S)

G = []
G.append(("`plans/FS112-unit-arc-half.md` §R-close, and `data/fs112/fs112-c/reconciliation.md` §§1.5–1.6.*",
          "`plans/FS112-unit-arc-half.md` §R-close, and `data/fs112/fs112-c/reconciliation.md` §§1.5–1.6 and 1.8–1.9.*"))
G.append(("stuck chains** — degree-4 vertices at unit spacing along a line (FS112-N2-TERM) — and the point one step beyond each finite end of a chain has at\n"
          "  least four colours (FS112-C-ENDS, one mind). Trading repeated colours for four colours is FS-115's business.",
          "stuck chains** — degree-4 vertices at unit spacing along a line (FS112-N2-TERM) — and the point one step beyond each finite end of a chain has at\n"
          "  least four colours (FS112-C-ENDS, one mind; at a single vertex bounded by unit arcs on both sides — FS112-BOWTIE's kind — through FS112-C-DOUBLE, one\n"
          "  mind, with one residue named in FS-115's stub). No line of this stub rests on FS112-Y3-END-NEEDS. Trading repeated colours for four colours is FS-115's\n"
          "  business."))
G.append(("4. **A second derivation of row 134's base steps** that N3-BASE inherits (above), and second minds on FS112-C-ENDS, C-COMPOSE and C-PARTNERS.",
          "4. **A second derivation of row 134's base steps** that N3-BASE inherits (above), and second minds on FS112-C-ENDS (with its stage-1b repair),\n"
          "   C-COMPOSE and C-PARTNERS."))
apply('plans/STUB-global-step.md', G)
