#!/usr/bin/env python3
"""FP stage 3: the stubs (FS-112, FS-111, FS-109, FS-102, FS-20, FS-104) and plans/FRONTIER-STUBS.md rows 1, 4, 5, 17 (row text only)."""
from pathlib import Path

def once(text, old, new, where):
    n = text.count(old)
    assert n == 1, f"{where}: occurs {n} times: {old[:90]!r}"
    return text.replace(old, new)

SRC = "`data/consolidation-2026-09-27/fp/record.md` stage 1"

# G1 FS-112
p = Path("plans/STUB-unit-arc-half.md"); t = p.read_text(encoding="utf-8")
anchor = "Provisional bearings (WORKFLOW 3.1 replaces them at the opening): G82, G79, G51, G21, G71, G13, G50.*\n"
banner = anchor + (
    "\n**Banner (the consolidation run, 2026-09-27; job FP from the reading jobs LW, LW2 and LW3 — `data/consolidation-2026-09-27/reports/LW2.md`"
    " §§ 0–1, `LW.md` § 1; the quotations checked on the pages, " + SRC + "): four re-aims from print.**\n"
    "1. **The question is posed in print.** `[Polymath2021]` p. 199 hopes *\"to strengthen the seminal result of Thomassen [11]\"* by eliminating"
    " *\"(ii) the unit-radius tactic\"*, defined on p. 194 (a boundary arc of radius 1 centred on a point where a same-coloured tile touches). FS-112's"
    " NO answers it as posed, for locally finite segment-and-arc tilings almost everywhere, whatever reading of the paper's criterion (i), since"
    " FS-112 forbids neither (i) nor (ii); outside that class (tiles bounded by closed curves, p. 191) FS-112 is silent. Row 134 is the"
    " complementary case — (i) dropped, every radius-1 arc forbidden — incomparable with Thomassen's theorem. `CLOSED-QUESTIONS.md` §3 holds"
    " the question verbatim.\n"
    "2. **One exact known positive:** `[AxenovichEtAl2014]` Thm 4.2's six-coloured strip of height `√15/2 + √3` (≈ 3.668), its symmetric tiles"
    " of width 1/2 *\"with the rounded boundary being a circular arc of radius 1 centered at the opposite corner of the tile\"*. The exact"
    " checkers accept it before any of their refusals is believed (G21). `[Polymath2021]`'s six-tiled disk (Fig. 10, p. 200) prints no"
    " coordinates and is no positive until reconstructed (LW2).\n"
    "3. **The tactic, measured in the neighbouring problem:** `[Parts2021]` p. 181, \"Wavy sides\" (*\"an arc with a radius of 1 centered at the"
    " nearest corner of the adjacent tile to slightly reduce the distance between the tiles\"*), and p. 182: *\"for m = 6, it is possible to"
    " reduce k from 31 to 29 (due to reduction of d by only 0.15%)\"* — multi-fold colouring, so nothing moves at `m = 1`, but print"
    " evidence that the tactic buys colours. And `[Parts2020c]` §2.5 (p. 37), numerical optimisation over symmetric tilings: *\"a) vertices"
    " in which three or more colored tiles converge are disadvantageous (a void is superior to any such vertex)\"* and *\"d) the curving of"
    " pairs of opposite tile sides is optimized with a radius of 1/2\"*; there radius-1 arcs bound only voids (p. 34) — the best printed"
    " designs leave the unit-arc seam by leaving voids. A measured prior, never a cap (`CLAUDE.md` § Counter-priors). **The registered"
    " expectation \"a YES by formula (0.03)\" below is to be re-registered at the milestone's opening with these in view** (G21: say what"
    " the registration's population was); it is not re-registered here.\n"
    "4. **Its everywhere-form sibling, posed in 1992:** `[Kainen1992]` p. 35, *\"(2) CONJECTURE. The chromatic number of the plane is"
    " robust.\"* — given `[Voronov2023]` Thm 1.1 it is `χ(ℝ²) = 7` (`CLOSED-QUESTIONS.md` §3). It frames link 5 historically and changes no"
    " step.\n")
t = once(t, anchor, banner, "FS-112 banner")
p.write_text(t, encoding="utf-8")

# G2 FS-111
p = Path("plans/STUB-reg-scale.md"); t = p.read_text(encoding="utf-8")
t = once(t, "\n## Killing tests and registered expectations",
    "\n**The one print prior** (the consolidation run, 2026-09-27; job FP from the reading jobs LW and LW2): `[Parts2020c]` §2.5 (p. 37), in the"
    " best 5- and 6-tilings found by numerical optimisation over symmetric tilings, *\"a) vertices in which three or more colored tiles"
    " converge are disadvantageous (a void is superior to any such vertex)\"* — the junctions this stub asks about are voids in the best"
    " designs known; a measured prior, never a cap (`CLAUDE.md` § Counter-priors). `[BrownDunfieldPerry1994]` Thm 8 (p. 111) argues"
    " topologically about how open regions meet, at no scale. Nothing read in the journal's archive gives a junction-scale bound or a family"
    " of unbounded complexity.\n\n## Killing tests and registered expectations", "FS-111")
p.write_text(t, encoding="utf-8")

# G3 FS-109
p = Path("plans/STUB-hole-dial.md"); t = p.read_text(encoding="utf-8")
t = once(t, "\n## Provisional bearings\n",
    "\n## Folded in at the consolidation run: three dials from print\n\n"
    "*Added 2026-09-27 by job FP from the reading jobs LW, LW2 and LW3; the quotations checked on the pages (" + SRC + ").* **X₆**"
    " (`[Soifer1994X6]`, 1994), p. 140: *\"Find the 6-realizable set X6 of all positive numbers α such that there exists a 6-coloring of the"
    " plane of type (1,1,1,1,1,α).\"*; p. 141: *\"[√2 − 1, 1/√5] ⊆ X6\"* and *\"if 1 ∉ X6, then χ = 7 / if 1 ∈ X6, then χ ≤ 6\"*."
    " `[Mundinger2024]` extends the known part to `[0.354, 0.657]` with polytopal tiles, validity checked numerically. A second dial beside"
    " this one — how close to 1 the sixth colour's forbidden distance can be pushed — everywhere-proper, so it bears on the plane and not on"
    " row 131's measurable form. **The almost chromatic number** (`[HoffmanSoifer1993]`, 1993), p. 38: *\"almost all (i.e., all but one)"
    " colors forbid the unit distance, and the remaining color forbids a distance\"*, *\"4 ≤ χa ≤ 6.\"*, *\"And the problem is: find χa.\"*"
    " **`[Parts2020c]` §2.4's tile-share dial** (p. 37): *\"We are unaware of any way to obtain a Siamese-free tiling with the relative"
    " proportion of tiles of some color being less than 1/8.\"* — a count beside this stub's area. No row answers X₆ or `χa`; they are"
    " recorded here rather than in `CLOSED-QUESTIONS.md`, which takes questions a row answers (the owner's ruling of 2026-09-27 on"
    " `[Johnson1994choice]`, applied to these).\n\n## Provisional bearings\n", "FS-109")
p.write_text(t, encoding="utf-8")

# G5 FS-102
p = Path("plans/STUB-writeup-main-clause-five.md"); t = p.read_text(encoding="utf-8")
t = once(t, "- **Blocking, before any draft (G50):** `[Johnson2000]` and `[Johnson2006]` are unread — **Kooshi, acquiring** (`BIBLIOGRAPHY.md` § R.6).\n"
    "  Until they are read, novelty is \"not found\", never \"first\" (rows 121, 123).",
    "- **Was blocking, now met (G50):** `[Johnson2000]` and `[Johnson2006]` are read in full (2026-09-27, the consolidation run's job LP; a second\n"
    "  reading by LV): **not found in either** — they hold no value of `χ(F²)` at five and pose the four-colour question as open\n"
    "  (`CLOSED-QUESTIONS.md` §1.7; rows 121, 123). Novelty stays \"not found in print\", never \"first\".", "FS-102")
p.write_text(t, encoding="utf-8")

# G6 FS-20
p = Path("plans/STUB-theorem-B-writeup.md"); t = p.read_text(encoding="utf-8")
a = "One naming table (`BIBLIOGRAPHY.md` §E) serves both.\n"
t = once(t, a, a + (
    "\n**At the consolidation run (2026-09-27, jobs LP and LV; `data/consolidation-2026-09-27/reports/LV.md`).** Open items R2 (`[Johnson2006]`,"
    " read in full) and R3 (Benda–Perles's Open Problem 11.6 quoted from the source, `CLOSED-QUESTIONS.md` §1.1) are met. The manuscript's"
    " headline, Theorem A's general form (`CLOSED-QUESTIONS.md` §1.2), is prior art in its construction: `[Fischer1990]` Thm 1(i) (p. 183)"
    " and `[Johnson2006]` p. 213, its first instances `[BendaPerles2000]`'s (1976; `ℚ²` and `ℚ³`, pp. 120–121). FS-20's remaining novel"
    " content is the kernel proof, the `𝔽₄` residue colouring and the metric-free statement — the last not found in print, with"
    " `[Johnson1982]` unread (held since 2026-09-27; job LX reads it): read it before any manuscript claims it.\n"), "FS-20")
p.write_text(t, encoding="utf-8")

# G7 FS-104
p = Path("plans/STUB-cp-plane-six.md"); t = p.read_text(encoding="utf-8")
a = "# FS-104 — the stationary chromatic number at six: is `χ_CP(ℝ²) ≥ 6`? (stub)\n\n"
t = once(t, a, a + (
    "> **Print addresses from the consolidation run (2026-09-27; job FP from the reading jobs LW and LW3, `data/consolidation-2026-09-27/reports/LW3.md`\n"
    "> §§ 1, 4; the quotations checked on the pages, " + SRC + ").** **Item (1), the null-set step:** its compactness step is in print,\n"
    "> `[Johnson1994choice]` p. 125: *\"The well-known DeBruijn-Erdös theorem on the chromatic number of an infinite graph holds for the choice\n"
    "> number. That is, if G is an infinite graph, k is a positive integer, and c(H) ≤ k for every finite subgraph H of G, then c(G) ≤ k.\"*\n"
    "> (proved there by Tychonoff), and the same paper asks, p. 124, *\"Is the choice number of the planar unit distance graph finite?\"* — a\n"
    "> posed question no row answers, recorded here, not in `CLOSED-QUESTIONS.md` (the owner's ruling, 2026-09-27). If print answers \"infinite\",\n"
    "> item (1) cannot close by a general list-colouring theorem and must use where the lists come from (FS103-M-D's hunch). **Check first**\n"
    "> whether it is answered (LW3 recalls, unread, an average-degree lower bound for choice numbers). **Item (3), the ZF + DC audit:**\n"
    "> `[Soifer2007]` p. 86 prints, with no proof, *\"Chromatic Number of the Plane Theorem. In ZFS the chromatic number of the plane is 5, 6, or\n"
    "> 7.\"*; `[ShelahSoifer2003b]` p. 43 asserts *\"DC is sufficient for Falconer's result [F]\"* and p. 42 names de Bruijn–Erdős's use of\n"
    "> choice; that link 2 uses choice only there, its averaging needing only ZF + DC, is a reading at one mind (LW3). **The question as posed\n"
    "> in print:** *\"The Ronald L. Graham New $1,000 Problem. Prove or disprove the existence of a 6-chromatic unit-distance graph.\"*\n"
    "> (`[Soifer2019]` p. 213) — by de Bruijn–Erdős it is `χ(ℝ²) ≥ 6`, and given MR (rows 128, 130) it is this stub's `χ_m⁰(ℝ²) ≥ 6`.\n\n"), "FS-104")
p.write_text(t, encoding="utf-8")

# G8 FRONTIER-STUBS rows (text only)
p = Path("plans/FRONTIER-STUBS.md"); t = p.read_text(encoding="utf-8")
t = once(t, "W-3's winding transport fails across same-type edges (YB3-SAME) | decisive both ways at bounded complexity: YES gives `χ(ℝ²) ≤ 6` with no MR; NO answers `[SokolovVoronov2025]` Question 2 a.e. \nfor circular-arc maps".replace(" \nfor", " for"),
    "W-3's winding transport fails across same-type edges (YB3-SAME). **Posed in print** (the consolidation run, 2026-09-27; the stub's banner):"
    " `[Polymath2021]` p. 199 asks to \"eliminate criterion (ii)\", \"(ii) the unit-radius tactic\"; one exact known positive, `[AxenovichEtAl2014]`"
    " Thm 4.2's strip; the tactic measured saving two colours in six-fold tilings (`[Parts2021]` p. 182); its everywhere-form sibling"
    " `[Kainen1992]`'s robustness conjecture, `χ(ℝ²) = 7` given Voronov | decisive both ways at bounded complexity: YES gives `χ(ℝ²) ≤ 6` with no MR;"
    " NO answers `[SokolovVoronov2025]` Question 2 and `[Polymath2021]`'s question a.e. for circular-arc maps", "FRONTIER rank 1")
t = once(t, "C-VOID's thin-hole re" + "futation, by formula, in the ban |",
    "C-VOID's thin-hole refutation, by formula, in the ban; from print, a second dial, X₆ (`[Soifer1994X6]`: \"if 1 ∉ X6, then χ = 7 / if 1 ∈ X6,"
    " then χ ≤ 6\"), with the almost chromatic number `χa` (`[HoffmanSoifer1993]`) and `[Parts2020c]` §2.4's tile-share dial (the stub, 2026-09-27) |",
    "FRONTIER rank 4")
t = once(t, "**Three of its five items answered at FS-110's close (row 134):** S–V Thm 2's `d = 2` case struck",
    "**Four of its five items answered:** at FS-110's close (row 134), S–V Thm 2's `d = 2` case struck", "FRONTIER rank 5a")
t = once(t, "(W-MERGE, N4's cone removal). **Left:** Townsend's (c) filled in full; `[Townsend2005]` against the manuscript |",
    "(W-MERGE, N4's cone removal); at the consolidation run (2026-09-27, LP, a second reading by LV), `[Townsend2005]` is the 1979 manuscript"
    " word for word, simplification (c) unargued there too. **Left:** Townsend's (c) filled in full, with a reading of `[Soifer2024]` ch. 25's"
    " 2007 Theorem 5 against FS106-V3's flagged steps |", "FRONTIER rank 5b")
t = once(t, "Owed first: `[Johnson2000]`, `[Johnson2006]` (Kooshi, acquiring); the kernel form (FS-101).",
    "`[Johnson2000]`, `[Johnson2006]` read, not found (2026-09-27, the consolidation run's LP and LV). Owed first: the kernel form (FS-101).",
    "FRONTIER rank 17")
p.write_text(t, encoding="utf-8")
print("stage 3 applied")
