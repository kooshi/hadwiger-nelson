# M42 — Kernel promotion of the gap atlas
# (SUBPLAN — §0 registered 2026-08-12 laptop, at the M41 close; the stub below stands;
#  §0a supersedes its pricing: the exact-hexagon constructor ALREADY EXISTS.)

## §0a — The repricing derivation (hand-verified against Coset.lean's actual lemmas)

M40 §0e priced item 1 around a NEW exact-hexagon witness constructor. Reading
`Coset.lean` at subplan time: **`corner_sweep` already sweeps to the hexagon corner**
(`hexQ(addr (j•d) + (2s)•hole i) = Qi + 2j·(holeF i d)·s·… reaching Qi + 2j·holeF + 4/3
at s → 1`), and `collinear_sweep` handles every interior window. The per-norm witness
table for the three bands (each row = the sweep instance whose IVT window CONTAINS the
band; all hand-checked including the `hsmall` guards):

**Band T² ∈ (4, 13/3) — the 12-clique window, pairs at norms {1,3,4,7,9}:**
norm 1: corner sweep at `holeF = 1` (reach 1 + 2 + 4/3 = 13/3 — needs the ONE new
lemma: `corner_sweep` generalized from its `holeF i d = 2` hypothesis to a parameter);
norm 3: collinear, d norm 3, j = 1, σ ≈ +0.29-window ✓; norm 4: collinear, j = 1 on
d = (2,0), small σ ✓; norm 7: collinear, j = 1, σ ≈ −0.11 (pulling TOGETHER — the
lemma is sign-agnostic) ✓; norm 9: collinear, d = (1,0), j = 3, σ ∈ (−0.5, −0.46),
`hsmall` = 4σ² < 1 holds at 0.846 ✓.

**Band T² ∈ (13/3, 16/3) — G\*, pairs at norms {3,4,7,9}** (for the coset-impossibility):
norms 3, 4, 7 collinear as above with shifted σ; norm 9: σ ∈ (−0.46, −0.345) ✓.

**Band T² ∈ (9, 28/3) — the M = 4 shell window, pairs at norms {4,12,16}:**
norm 4: **the EXISTING `corner_sweep` verbatim** (holeF = 2 at d = (2,0), j = 1: reach
4 + 4 + 4/3 = 28/3 — the collinear sweep tops at exactly 9 and misses; this is why the
corner lemma exists) ✓; norm 12: collinear, j = 1 on norm-12, σ ≈ −0.065 ✓; norm 16:
collinear, d = (1,0), j = 4, σ ≈ −0.475 (hsmall 0.9 < 1) ✓.

So the Lean surface is: ONE generalized lemma (`corner_sweep` with `holeF i d = c` a
parameter — or simply a second instance at c = 1), per-norm refutation instances in
the existing `sweep_ivt` shape, the three window theorems in the `seven_values` /
`eight_le_card_of_cell_constant` counting shape, and the coset-impossibility (the φ
homomorphism framing takes `φ d = 0` natively — one short vector per HNF sublattice,
norms in the band's edge set, from M40's witness table). Items in leaf order:
shell-4 window (existing lemmas only) → G\* coset-impossibility → 12-clique window
(the one new lemma) → χ(G\*) ≥ 7 via the 23-core (the M06-chain certificate shape,
possibly with the two-act decomposition as a named intermediate).

## §0b–d — Predictions and clauses (compact)

* P1 [high]: the shell-4 window theorem lands with NO new sweep machinery.
* P2 [high]: the coset-impossibility lands as a finite case bundle over 8 sublattices.
* P3 [medium-high]: the generalized corner lemma is ≤ 30 lines (it is `corner_sweep`
  with `2` renamed); the 12-clique window follows.
* P4 [medium]: the 23-core refusal by `decide` at 138 vars is affordable; else the
  M05 LRAT pipeline (fallback registered).
* Failure clauses: any sweep window that misses its band on exact arithmetic HALTS the
  item and reports the arithmetic (the σ-table above is hand-derived — the Lean
  elaborator is its checker); builds through `scripts/build.sh` ONLY; laptop RAM is
  the ceiling; any segfault: HALT.

## §0e — Domain-modeling pass (2026-08-12, applied before the skeleton)

* **The band enters as two rational inequalities on p².** The file's earlier windows
  used p-inequalities because their endpoints were rational in p; M42's endpoints are
  rational in T² = 1/p² (D1's thresholds), so the intrinsic radical-free form is
  `3/28 < p^2 → p^2 < 1/9 → …` (shell-4), `3/13 < p^2 → p^2 < 1/4` (12-clique),
  `3/16 < p^2 → p^2 < 3/13` (G\*). Same convention one level down; no radicals.
* **The coset-impossibility quantifies over `φ : (ℤ×ℤ) →+ ZMod 7`, `φ ≠ 0`.** Seven
  is prime, so every index-7 quotient IS ℤ/7 — the abstract subgroup quantifier
  collapses to nonzero homs (φ ≠ 0 ⟹ surjective, ZMod 7 simple). The proof is a
  48-case witness table ((φ(1,0), φ(0,1)) = (a,b) ≠ 0; per case a kernel vector d with
  `a·d.1 + b·d.2 ≡ 0 [ZMOD 7]` and `hexQi d ∈ {3,4,7,9}`) — checkable by `decide` —
  feeding the sweep refutation through the existing `φ d = 0` hypothesis shape.
* **The 23-core is two-layer, house style**: a `Fin 23` graph refusal certificate
  (edges = the band's constraint pairs, each justified by an `exists_unit_pair`
  instance; the 6-colour refusal by pinned-clique `decide` — the ω = 4 clique closes
  the palette, M34 Gadget pattern — with the M05 LRAT pipeline as registered fallback)
  plus the plane corollary in cell-constant vocabulary (a cell-constant colouring
  restricted to the 23 addresses is a proper colouring of the certificate graph).
* **Non-vacuity models**: a rational p per band pinned in the skeleton (e.g.
  `p² = 21/100` for G\*), the `rnd` model reused from M37's sharpness half.
* Obligation-modeling note (compact, run as part of this pass given the overlap): the
  decompositions ARE §0a's σ-table — each window theorem = per-norm sweep instances ×
  the counting wrapper; the risky obligations are (i) the `hsmall` guards at the
  extreme σ (norm-9 at the 12-clique band: 4σ² = 0.846 — nlinarith-friendly margins),
  (ii) the 23-core decide budget (P4's fallback stands). Experience pass skipped: the
  surface follows the file's existing conventions exactly.

# THE ORIGINAL STUB (pricing superseded by §0a above)

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
