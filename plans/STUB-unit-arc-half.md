# FS-112 — the unit-arc half: does a tight six-map exist once boundary arcs of radius 1 are allowed? (stub)

*Minted 2026-09-27 by the close planner FS110-C at FS-110's close (`plans/FS110-tangency-seam.md` §R-close; inventory items 68, 78; A5-5.6, A6-2.2 (b)).
Provisional bearings (WORKFLOW 3.1 replaces them at the opening): G82, G79, G51, G21, G71, G13, G50.*

**Banner (the consolidation run, 2026-09-27; job FP from the reading jobs LW, LW2 and LW3 — `data/consolidation-2026-09-27/reports/LW2.md` §§ 0–1, `LW.md` § 1; the quotations checked on the pages, `data/consolidation-2026-09-27/fp/record.md` stage 1): four re-aims from print.**
1. **The question is posed in print.** `[Polymath2021]` p. 199 hopes *"to strengthen the seminal result of Thomassen [11]"* by eliminating *"(ii) the unit-radius tactic"*, defined on p. 194 (a boundary arc of radius 1 centred on a point where a same-coloured tile touches). FS-112's NO answers it as posed, for locally finite segment-and-arc tilings almost everywhere, whatever reading of the paper's criterion (i), since FS-112 forbids neither (i) nor (ii); outside that class (tiles bounded by closed curves, p. 191) FS-112 is silent. Row 134 is the complementary case — (i) dropped, every radius-1 arc forbidden — incomparable with Thomassen's theorem. `CLOSED-QUESTIONS.md` §3 holds the question verbatim.
2. **One exact known positive:** `[AxenovichEtAl2014]` Thm 4.2's six-coloured strip of height `√15/2 + √3` (≈ 3.668), its symmetric tiles of width 1/2 *"with the rounded boundary being a circular arc of radius 1 centered at the opposite corner of the tile"*. The exact checkers accept it before any of their refusals is believed (G21). `[Polymath2021]`'s six-tiled disk (Fig. 10, p. 200) prints no coordinates and is no positive until reconstructed (LW2).
3. **The tactic, measured in the neighbouring problem:** `[Parts2021]` p. 181, "Wavy sides" (*"an arc with a radius of 1 centered at the nearest corner of the adjacent tile to slightly reduce the distance between the tiles"*), and p. 182: *"for m = 6, it is possible to reduce k from 31 to 29 (due to reduction of d by only 0.15%)"* — multi-fold colouring, so nothing moves at `m = 1`, but print evidence that the tactic buys colours. And `[Parts2020c]` §2.5 (p. 37), numerical optimisation over symmetric tilings: *"a) vertices in which three or more colored tiles converge are disadvantageous (a void is superior to any such vertex)"* and *"d) the curving of pairs of opposite tile sides is optimized with a radius of 1/2"*; there radius-1 arcs bound only voids (p. 34) — the best printed designs leave the unit-arc seam by leaving voids. A measured prior, never a cap (`CLAUDE.md` § Counter-priors). **The registered expectation "a YES by formula (0.03)" below is to be re-registered at the milestone's opening with these in view** (G21: say what the registration's population was); it is not re-registered here.
4. **Its everywhere-form sibling, posed in 1992:** `[Kainen1992]` p. 35, *"(2) CONJECTURE. The chromatic number of the plane is robust."* — given `[Voronov2023]` Thm 1.1 it is `χ(ℝ²) = 7` (`CLOSED-QUESTIONS.md` §3). It frames link 5 historically and changes no step.

**The question.** `[SokolovVoronov2025]` Question 2 asks "Is it true that 7 colors are needed to color a locally finite map …?" (verbatim,
`data/fs110/claims.md` l. 63). FS-110 answered its Condition-5 half yes, almost everywhere (row 134). What is left is the half with unit arcs: a
locally finite map bounded by segments and circular arcs, arcs of radius 1 allowed, carrying a six-colouring in which no two interior points of one
colour are at distance exactly 1. With FS-107's W-EQ-K (row 133) a YES at bounded complexity gives `χ(ℝ²) ≤ 6` with no MR; a NO answers Question 2
almost everywhere for circular-arc maps and closes door (A).

**What FS-110 leaves here** (addresses in `plans/FS110-derivation.md`): every close complementary pair sits on a unit arc — (S1) (a bowtie centred on two
boundary unit arcs; N2-S1 forces the bowtie colour at the hexagon neighbours bar `|u − v| ∈ {1, √3}`; Y2-S1i's GAP when both side colours are cusps), the
T2 rhombus (four-colour seam points), and NB-4's four-colour exception (a `Γ`-arc through a change point of every ring orbit; A4-SIX-ARCS, one mind);
fragments S1, T2, BB, MX a.e.-proper and tight (two exact checkers); YB-V5X (bichromatic degree-≥ 4 ends need a unit arc or cusps); Y-BIKE-3C's GAP at
grid-corner passages (A4-BAND's cross-swap); the Act-One winding apparatus with **YB3-SAME: `W` is not transported across a same-type edge** — prove it,
or refute it by an exact local fragment (item 78); Y3-SIX at bowties; the eight-arc aligned ring; whether a generic `|W| = 3` ring is realisable at one
vertex (item 68). **The route that closed Condition 5** — Woodall's merge, the cone removal, S–V Cor. 1 — needs Condition 5 at NB-4 and NB-5 only;
the first question is which of the chain's steps survive unit arcs.

**Registered expectations** (instruments, never caps; to be re-registered at the opening): the chain's W-MERGE and N4 steps survive unit arcs outside
the arcs' centres (0.6); the first obstruction is at a unit-arc centre carrying four colours (0.5); a YES by formula (0.03).

**Instruments.** The exact curved checkers (`tools/fs110_y_check.py`, `tools/fs110_yb_check.py`, `tools/fs110_yb4_check.py`); the fragments; the
competitor protocol with a blind verifier per side. In-ban: derivation and exact checks of fragments given by formula.
