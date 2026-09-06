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
| 1 | **FS-2 Kempe classes, re-aimed** — `plans/STUB-kempe-classes.md` | what carries forcing when the additive family does not: the reconfiguration graph (single-vertex moves, Kempe swaps) of a FORCING object — the seed's 252-cheat subset (> 5,000 colourings, one additive, the pair forced) and K-fabric's 16-pair residue; is the forced pair constant on every component, and are the components the Kempe classes of a few colourings | medium-high — after M57 this is the only mechanism question left about "tight at χ" on objects we hold; the seed half (H's Kempe graph within distance 2 of the family) is answered by M57 B2 | 1–2 days | stubbed 2026-09-06; **re-aimed at the M57 close** (the seed half done) | M57 close |
| 2 | **FS-6 a family-keeping thickening** — `plans/STUB-family-keeping-thickening.md` | is there a field and construction that add unit directions to a 5-chromatic chunk without making its joint lattice 5-divisible (the F₂₄₇ cross lattice does at depth one: 500 units in 5Λ, no ℤ/5-hom); the de Grey gen-1 closure's dial first, Heule's field and the half-spindle words next | medium — the principle of M57 bites only there; a negative closes it at five colours as a design route | 1–2 days | stubbed 2026-09-06 (M57 close); **first datum favourable**: de Grey's whole gen-1 closure keeps ≥ 300 homs, no unit in 5Λ | M57 close |
| 3 | **FS-3 thickened material** — `plans/STUB-thickened-material.md` | the F₂₄₇ cross thickening (the only construction that moved the redundancy dial): T24's derivation, the symmetric thickening; **its D2 additive pre-filter is VACUOUS (M57: no ℤ/5-hom on the thickened stage) and is struck**; the 108 asks in flight are its first datum | medium — advances by measurement on the one object neither localization theorem decides | 2–3 days | stubbed 2026-09-06 (carried from M55); pre-filter struck at the M57 close | M57 close |
| 4 | **FS-4 Theorem B in the kernel** — `plans/STUB-field-wall-kernel.md` | the residue colouring of ℚ(√3, √11)² as a kernel theorem (the order ℤ[ζ₁₂, (1+√33)/2], its prime above 2, the DVR argument) | low-medium — a foundation rung for the field-as-input programme, not an object; formalization of our own theorem, below the publication bar | 3–5 days | stubbed 2026-09-05 | M57 close |
| 5 | **FS-5 bookkeeping** — the ν = number-of-spindles law (T25) and the plane instance of `extends_of_hubs` (a `Copy.copyUnion` shown to satisfy the hub hypotheses from census data) | closes two open ends of M54/M55 | low — bookkeeping; fold into whichever milestone next touches spindle unions | an afternoon | listed 2026-09-06, no stub file (T25 holds the derivation sketch) | M57 close |
| — | **FS-1 additive rigidity — CLOSED as M57** — `plans/M57-additive-rigidity.md` | the reduction theorem (kernel), the closure gauge γ, G exactly rigid, every unit object Kempe-open, thickening kills the family | delivered: a sufficient condition the kernel holds and a solver-free gauge; on every object we hold the principle has no purchase | — | opened and closed 2026-09-06 | M57 close |
| — | **candidate, not stubbed: Haugland's heptagonal 5-forcer through the additive lens** | does L8 hold on a cubic-field fabric (is its spindle chord in 4Λ), and does its colouring space have an additive skeleton | low-medium — a check of L7/L8's generality; needs the import (floats + uncertified SAT, cubic field) | 2 days | candidate 2026-09-06 | M56 close |

## Demoted (banners kept in the stubs; never deleted)

* FS-3's additive pre-filter (its D2) — vacuous on F₂₄₇ by M57 §R5 (no ℤ/5-hom on the thickened stage); the sweep it was to shorten must run unfiltered.
* M55's "many spindles over one fabric" — dead by theorem (absorption, `Absorb.lean`); the stub is `plans/M55-absorption.md` §R.
* The k = 5 class-avoidance / gadget hunts on existing witnesses (M35, M41, M48) — closed by G31 (nothing to extract at the top rung).

## How a milestone is chosen

Kooshi picks from the top of the table; the default if nothing is said is rank 1. A milestone that opens is
renumbered (M57, …) and its stub file becomes `plans/Mxx-<name>.md`; the row stays here with its status.
