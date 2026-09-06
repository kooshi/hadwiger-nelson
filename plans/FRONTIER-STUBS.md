# The frontier stubs — the ranked set of next milestones (created 2026-09-06 at the M56 close, Kooshi's direction)

*Kooshi, at the M56 close: "we'll build a set of frontier stubs, adding to the set and re-ranking at the end of
each milestone." This file is that set. Every row is a full stub in `plans/` (the stub rule, WORKFLOW § Plan:
mission context, facts, derivations first, phases, registered predictions, failure clauses, instruments, costs,
addresses). **Maintenance rule (WORKFLOW step 9):** the session closing a milestone re-ranks this table, adds every
candidate the milestone surfaced (as a stub file, however small), demotes with a banner and never deletes, and
mirrors the top of the table into `CLAUDE.md` § Paths forward. The `bearing on 6` column answers Kooshi's
question — does the milestone advance our understanding in a way that helps reach χ(ℝ²) ≥ 6 — honestly, and a
row whose bearing is only "bookkeeping" says so.*

| rank | stub | the question | bearing on 6 | cost | status | added / last re-ranked |
|---|---|---|---|---|---|---|
| 1 | **FS-1 additive rigidity** — `plans/M57-additive-rigidity.md` | a unit-distance graph whose 5-colourings are all additive and which holds a 5Λ-pair is 5-tight by arithmetic (the reduction theorem, kernel-able); which constraints are free for the additive family; the bridging case at four colours; where the additive skeleton dies per field (the richness dial, folded in); the additive defect as the descent's gauge | **HIGH** — a sufficient condition for χ ≥ 6 the kernel can hold, and a continuous score for the goal the descent stalled on | 3–5 days | stubbed 2026-09-06; **opened as M57** 2026-09-06 (`plans/M57-additive-rigidity.md`) | M56 close |
| 2 | **FS-2 Kempe classes** — `plans/STUB-kempe-classes.md` | is K-fabric's 4-colouring space the Kempe closure of its eight additive colourings (the 16-pair residue); the seed's 35-vertex Kempe graph; W's colourings from the Kempe side | medium — the mechanism of "rigid at χ" on the one bed where everything is computable; hands FS-1 its mechanism or its obstruction | 1 day | stubbed 2026-09-06 | M56 close |
| 3 | **FS-3 thickened material** — `plans/STUB-thickened-material.md` | the F₂₄₇ cross thickening (the only construction that moved the redundancy dial): T24's derivation, the symmetric thickening, the additive pre-filter before any sweep; the 108 asks in flight are its first datum | medium — advances by measurement on the one object neither localization theorem decides | 2–3 days | stubbed 2026-09-06 (carried from M55) | M56 close |
| 4 | **FS-4 Theorem B in the kernel** — `plans/STUB-field-wall-kernel.md` | the residue colouring of ℚ(√3, √11)² as a kernel theorem (the order ℤ[ζ₁₂, (1+√33)/2], its prime above 2, the DVR argument) | low-medium — a foundation rung for the field-as-input programme, not an object; formalization of our own theorem, below the publication bar | 3–5 days | stubbed 2026-09-05 | M56 close |
| 5 | **FS-5 bookkeeping** — the ν = number-of-spindles law (T25) and the plane instance of `extends_of_hubs` (a `Copy.copyUnion` shown to satisfy the hub hypotheses from census data) | closes two open ends of M54/M55 | low — bookkeeping; fold into whichever milestone next touches spindle unions | an afternoon | listed 2026-09-06, no stub file (T25 holds the derivation sketch) | M56 close |
| — | **candidate, not stubbed: Haugland's heptagonal 5-forcer through the additive lens** | does L8 hold on a cubic-field fabric (is its spindle chord in 4Λ), and does its colouring space have an additive skeleton | low-medium — a check of L7/L8's generality; needs the import (floats + uncertified SAT, cubic field) | 2 days | candidate 2026-09-06 | M56 close |

## Demoted (banners kept in the stubs; never deleted)

* M55's "many spindles over one fabric" — dead by theorem (absorption, `Absorb.lean`); the stub is `plans/M55-absorption.md` §R.
* The k = 5 class-avoidance / gadget hunts on existing witnesses (M35, M41, M48) — closed by G31 (nothing to extract at the top rung).

## How a milestone is chosen

Kooshi picks from the top of the table; the default if nothing is said is rank 1. A milestone that opens is
renumbered (M57, …) and its stub file becomes `plans/Mxx-<name>.md`; the row stays here with its status.
