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
| 1 | **FS-11 lift a 6-critical finite-plane subgraph to the field** — `plans/STUB-finite-plane-lift.md` | the constructive face of the pivot: a subgraph H of UD(𝔽_p,2) lifted vertex-by-vertex into its residue classes with every edge unit is a copy of H in F², so a lifted 6-critical subgraph of UD(𝔽₁₃₁,2) (≥ 8-chromatic) would be a 6-chromatic unit-distance graph; the local (𝔭-adic) lift test decides cheaply whether any core can lift at all | **medium** — the one route the pivot opens that could PRODUCE a 6-object; odds set by an overdetermined diophantine system | days | stubbed 2026-09-06 (M58 close) | M58 close |
| 2 | **FS-6 a family-keeping thickening, on the 6-open fields** — `plans/STUB-family-keeping-thickening.md` | de Grey's field, K(√7), K(√13), K(√79), K(√127) are the fields held or nameable that are 6-open (M58: wall broken ∧ 11 inert); de Grey's half-spindle closure keeps its additive family — grow it and read γ̄; K(√7)-fabric is the second bed | medium — the only place M57's principle could bite, now with the field list a theorem | 1–2 days | stubbed 2026-09-06 (M57 close); restricted to the 6-open fields at the M58 close | M58 close |
| 3 | **FS-2 Kempe classes, re-aimed** — `plans/STUB-kempe-classes.md` | what carries forcing when the additive family does not (the seed's 252-cheat subset, K-fabric's 16-pair residue); a mechanism question on 5-sealed beds whose design consequence must be carried to a 6-open field | medium — mechanism only; the seed half is answered (M57 §R2) | 1–2 days | stubbed 2026-09-06; re-aimed at the M57 close; scope note at the pivot | pivot 2026-09-06 |
| 4 | **FS-8 the Haugland 7-adic check** (now one `fplane.py map` row once his field's radicands are known; his field contains cos 2π/7 — cubic, so the sieve needs the odd-residue-degree form) — `plans/STUB-haugland-7adic.md` | does the heptagonal 5-forcer's field have a degree-one prime above 7 (then χ(UD(𝔽₇,2)) = 4 makes it 4-colourable and the external verification is wrong) or does its detuning adjoin a 7-inert radical | low-medium — a scope correction for G3/G7/G11 and a hand-checkable falsifier of an external claim; needs the import | half a day + the fetch | stubbed 2026-09-06 (the pivot) | pivot 2026-09-06 |
| 5 | **FS-4 Theorem B in the kernel** — `plans/STUB-field-wall-kernel.md` | the residue colouring of ℚ(√3, √11)² as a kernel theorem | low-medium — a foundation rung; after the pivot, the general reduction (a degree-one prime above p ⟹ a homomorphism into UD(𝔽_p,2)) is the statement worth the kernel, with Theorem B its p = 2 face | 3–5 days | stubbed 2026-09-05 | pivot 2026-09-06 |
| 6 | **FS-9 topological lower bounds** — `plans/STUB-topological-bounds.md` | does any unit-distance graph have a Borsuk–Ulam-type lower bound (neighbourhood/box complex coindex) above 3 — the one lower-bound genre sharp at every integer; the 791-forcer's central symmetry is a free ℤ₂-action; D1 predicts the neighbourhood complex is homotopy 2-dimensional on every unit-distance graph (bound ≤ 4), the box complex undecided | low-medium — no object; a NEW KIND of lower bound if the room is open; a day if D1 closes it | 1–3 days | stubbed 2026-09-06 (mined from the analysis) | pivot 2026-09-06 |
| 7 | **FS-10 Nullstellensatz certificates** — `plans/STUB-nullstellensatz.md` | k-colourability as a polynomial system; infeasibility certified by a polynomial identity of bounded degree (NulLA), checkable in the kernel by `linear_combination` — a second certificate genre beside LRAT, with the degree as an integrality dial; first on the spindle, the 9-, 23- and 122-cores | low-medium — a certificate language, not an object; an independent kernel route for every refutation | 2–3 days | stubbed 2026-09-06 (mined from the analysis) | pivot 2026-09-06 |
| 8 | **FS-5 bookkeeping** — the ν = number-of-spindles law (T25) and the plane instance of `extends_of_hubs` | closes two open ends of M54/M55 | low | an afternoon | listed 2026-09-06, no stub file | M57 close |
| — | **FS-7 the field sieve — CLOSED as M58** — `plans/M58-field-sieve.md` §R | the spectral bound settled every plane from 59 up (131: ≥ 8) with no solver; for every field containing K, 6-open ⟺ 2-adic wall broken ∧ 11 inert (a theorem); χ(UD(𝔽₁₁,2)) = 5 and χ(Heule-510) = 5 exactly in the kernel; the map of 19 fields; the shadow sieve's spectral floors | done — the field-selection instrument the hunt now consults first | — | closed 2026-09-06 | M58 close |
| — | **FS-3 thickened material — DEMOTED** — `plans/STUB-thickened-material.md` | the F₂₄₇ cross thickening | none for 6: K(√247) is 5-sealed (a degree-one prime above 11); kept for its measurements and the 108 asks still running | — | demoted at the pivot | pivot 2026-09-06 |
| — | **FS-1 additive rigidity — CLOSED as M57** — `plans/M57-additive-rigidity.md` | the reduction theorem (kernel), the closure gauge γ, G exactly rigid, every unit object Kempe-open, thickening kills the family | delivered | — | opened and closed 2026-09-06 | M57 close |

## Demoted (banners kept in the stubs; never deleted)

* FS-3 thickened material — no 6-forcer exists in K(√247) (the finite-plane bound, 2026-09-06); the F₂₄₇ half of FS-6 likewise.
* FS-3's additive pre-filter (its D2) — vacuous on F₂₄₇ by M57 §R5 (no ℤ/5-hom on the thickened stage); the sweep it was to shorten must run unfiltered.
* M55's "many spindles over one fabric" — dead by theorem (absorption, `Absorb.lean`); the stub is `plans/M55-absorption.md` §R.
* The k = 5 class-avoidance / gadget hunts on existing witnesses (M35, M41, M48) — closed by G31 (nothing to extract at the top rung).

## How a milestone is chosen

Kooshi picks from the top of the table; the default if nothing is said is rank 1. A milestone that opens is
renumbered (M57, …) and its stub file becomes `plans/Mxx-<name>.md`; the row stays here with its status.

**The pivot of 2026-09-06 (the finite-plane bound, `reference/Chat-analysis/VERIFICATION.md`):** a field with a degree-one
prime above a prime p ≡ 3 (mod 4) has χ(F²) ≤ χ(UD(𝔽_p, 2)), the chromatic number of the finite Euclidean plane; since
χ(UD(𝔽₁₁, 2)) = 5, every field with 11 usable — K, K(√5), K(√247), Heule's — is 5-sealed. Every stub is now read against
that: a route to 6 must live in a 6-open field (de Grey's, K(√7), K(√35), … pending their planes), and FS-7 decides which.
