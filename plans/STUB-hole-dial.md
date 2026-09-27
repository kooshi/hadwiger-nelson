# FS-109 — the hole dial: how fast does the six-colourable fraction approach the whole plane as the band closes? (stub; post-ban)

*Minted 2026-09-27 by the close planner FS106-C at FS-106's close (`plans/FS106-close-inventory.md` item 52; FS106-TQ §5.4; FS106-A2 §3.5, "the
joint dial"). **Solver column: post-ban** — an optimiser over periodic grid tilings is a search, so nothing runs before 2026-10-01 (Kooshi's ban,
`CLAUDE.md` § Toolchain). Read `CLAUDE.md` § The aim, `LEDGER.md` row 131 and `plans/STUB-regularity-wall.md` § FS-107 first.*

## The question

Trace `1 − µ₆^per(ε)` — the least uncovered density of a periodic partial six-colouring by grid squares with no monochromatic pair at a distance
in `[1 − ε, 1 + ε]` — as `ε → 0`, along two families: `[Parts2020c]`'s six-colour tiling eroded to slack `2κ` (FS106-TQ's TQ-ERODE), and FS-107
W's families. Row 131 brackets it: `ε²/(6+ε)² ≤ 1 − µ₆(ε) ≤ δ₆ + O(ε)`, `δ₆ = 1.430172·10⁻⁴`, and `µ₆^per(ε) = µ₆(ε)`.

## Why it is a dial, not a search for a positive (G30)

Informative both ways: a curve flat near `10⁻⁴` is evidence for FS-107's R (holes of `ε`-independent measure); a falling one is evidence for W.
Either outcome decides nothing alone — row 131's equivalence needs `lim µ₆(ε)`, and a finite trace bounds it only from one side.

## Standard of evidence

Every point on the curve is a given tiling with rational data, checked exactly (a monochromatic pair of squares whose distance interval meets
the band refutes it), never a solver's word. Report the enumeration's bounds (period, grid size) in the headline (G21).

## Folded in at FS-107's close: C-VOID's thin-hole refutation (runnable in the ban, by formula)

*Added 2026-09-27 by FS107-C (`plans/FS107-close-inventory.md` items 23, 28; `plans/FS107-W-near-colourings.md` §4.5).* C-VOID (R′), verbatim
(`data/fs107/claims.md` §1): "There are ρ₀, R₀ > 0 such that for every ε > 0 every band-proper partial six-colouring of ℝ² has, inside every disc of
radius R₀, a disc of radius ρ₀ whose uncovered part has full measure." A family whose largest such disc has radius `→ 0` refutes it; it decides nothing
unless its coverage `→ 1` (then it is W's claim). FS-107's W expects it FALSE; FS-107's E6 gave a refutation 0.30; neither side tested it (HX's voids
have radius `≥ 0.22`). **Why here:** since FS107-V showed that R's reduction does not give C-VOID (`plans/FS107-derivation.md` FS107-RR), C-VOID is off
R's path, so its refutation is a fact about the shape of holes along a family — this dial's subject — and, unlike the dial's optimiser, it needs only a
family given by formula and exact checks of its members, so it runs inside the ban. **A recognition for the dial (FS-107 §R-close 3.2):** by FS107-W-POLY
a polygonal family of bounded complexity keeps holes `≥ δ₀(K)` (bar `d = 2`), so `[MundingerEtAl2025]`'s cell designs at fixed resolution are bounded
below; a falling curve needs curved tiles (FS-110) or growing complexity (FS-111). Provisional bearings added: G21, G82 as corrected, FS107-HX-STALL.

## Provisional bearings

G30 (a dial), G21 (a negative measures its enumeration), G65 (the solver's phase diagram, if a SAT encoding is used), G82.
