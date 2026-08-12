# M42 — Kernel promotion of the gap atlas (PRE-SUBPLAN STUB)

*Written 2026-08-12 at M40's close. Read order for a fresh session:
`plans/M40-chi-omega-hunt.md` WHOLE (the band decomposition, the corrected census, §R),
then `Coset.lean` (M37–M39's kernel layer — the machinery this milestone extends).
Everything here is measured mathematics awaiting formalization; nothing is speculative.*

## What gets promoted, in expected order of cost

1. **The 12-clique window** — `twelve_le_card_of_cell_constant`: any colouring constant
   on the cells at scale `p ∈ (√(3/13), 1/2)` needs at least TWELVE colours, via the
   12-point trapezoid `{(0,0),(0,1),(0,2),(1,−1),(1,0),(1,1),(1,2),(2,−1),(2,0),(2,1),
   (3,−1),(3,0)}` (verified: all 66 pairwise difference norms in {1,3,4,7,9}). The
   OBSTACLE the M40 §0e note prices: M38's `exists_unit_pair` constructor uses the
   inscribed-disc window, whose norm-1 case needs `p > 1/2` — the norm-1 and norm-9
   pairs on this band need EXACT-HEXAGON witnesses (norm-9's realizing pair sits at a
   cell-edge midpoint, norm-1's toward the deep-hole corners). One new constructor
   (`exists_unit_pair_corner`?) with an explicit rational witness pair per direction
   family; the M32 sympy-first discipline applies (derive the witness coordinates
   exactly, verify zero residual, then state).
2. **The M = 4 shell window** — `seven_le_card_shell4`: the 2Λ-scaled closed shell
   (norms {4,12,16}) is a 7-clique for `p ∈ (√(3/28)·2? — compute: T² ∈ (9, 28/3))`,
   i.e. `p ∈ (√(3/28)... use exact: (0.3273, 1/3))`. A numeral adaptation of M39's
   `seven_le_card_fine`; corrects M39 §0e's exhaustion claim IN the kernel.
3. **The coset impossibility** — no index-7 sublattice coset colouring is proper on the
   G\* band: for each of the eight HNF sublattices, one explicit short vector with norm
   in {3,4,7,9} (witnesses in M40's artifact), each certified an edge by the
   exists-unit-pair machinery. Statement shape: "for `p ∈ (√3/4, √(3/13))`, no
   colouring of the plane that factors through lattice-cosets of any index-7 sublattice
   is proper" — the first kernel statement that the classical mechanism dies below the
   window.
4. **χ(G\*) ≥ 7 via the 23-core** — the M06-chain shape: the core's 61-edge list (edges
   = pairs at norms {3,4,7,9}), each edge certified by an exact unit-pair witness, the
   6-colour refusal by `decide` or a small pinned LRAT (23 vertices × 6 colours = 138
   vars — likely `decide`-scale with the M34 Gadget palette closure), and the plane
   corollary: any cell-constant colouring at those scales that uses ≤ 6 colours is
   improper. Pair with the 12×12 torus colouring as `colorQ`-style sharpness if wanted
   (χ = 7 exactly, both halves kernel).

## Failure clauses (sharpen at registration)

* The exact-hexagon witness constructor balloons: land items 2–3 (which need only
  norms ≥ 3, where the inscribed-disc constructor may already reach — CHECK its exact
  window per norm first) and report item 1's measured wall.
* The 23-core decide exceeds heartbeats: the M05 LRAT segmentation machinery is the
  standing fallback.
* Any segfault: HALT and report (standing).

## Why it is worth a milestone

These are the first kernel theorems of the gap phenomenon (G24): the strongest
"cell-constant colourings cannot do better, and their good scales work differently"
package the repository can hold, they harden M40's headline against any instrument
doubt, and item 4's shape (finite core + unit-pair geometry + refusal certificate) is
exactly the template any future fine-tail refutation (the p = 1/7 hunt) would promote
through same-day.
