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

## Provisional bearings

G30 (a dial), G21 (a negative measures its enumeration), G65 (the solver's phase diagram, if a SAT encoding is used), G82.
