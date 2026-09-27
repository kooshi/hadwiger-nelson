# FS-112 — the unit-arc half: does a tight six-map exist once boundary arcs of radius 1 are allowed? (stub)

*Minted 2026-09-27 by the close planner FS110-C at FS-110's close (`plans/FS110-tangency-seam.md` §R-close; inventory items 68, 78; A5-5.6, A6-2.2 (b)).
Provisional bearings (WORKFLOW 3.1 replaces them at the opening): G82, G79, G51, G21, G71, G13, G50.*

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
