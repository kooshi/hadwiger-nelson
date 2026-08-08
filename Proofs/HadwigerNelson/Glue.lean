import Proofs.HadwigerNelson.Coupled

/-! # The general gluing classification (M22 skeleton)

M21 classified the four circle-pair intersections of the unit-distance pivot pair —
axis length 1, radii drawn from {1, 1/√3}. Two consumers immediately demand the general
statement: the **partner construction** (M22 thread 1: the unit-partners of a lattice
point `x` on a circle `(c, r)` are `sphere x 1 ∩ sphere c r`, an intersection whose
axis `dist x c` is generically neither 1 nor even rational), and the **metapivot
system** (M23 horizon: the centroid couples to its pivots at axis 1/√3). This module
states the classification once, for any two distinct centres and any two nonnegative
radii: when the annulus condition holds, the intersection is exactly a named point and
its mirror across the axis; outside it, the intersection is empty.

The named point's frame components are division-free — `⟨A, √(r₁²d² − A²)⟩` with one
frame-inverting division `/conj(q−p)` — and the `√`'s argument is the gluing
discriminant, the square root the partner construction adjoins. That the formula IS
the field-growth meter is the point: the tools-side closure (`tools/couple.py` at
implementation) cites this statement as the definition of the move, so the
construction is stated, not merely computed.

The mirror operator is ratio conjugation — M21's mirror identity elevated to the
definition; at unit axis it collapses to `Coupled.reflAcross` (the bridge lemma). The
module also hosts the nine-step near-cycle (§2.3): the first certified near-relation,
kept by the domain pass because both its halves are exact field arithmetic.

SKELETON: proofs are `sorry`; the statements are the specification under review.
-/

namespace HadwigerNelson
namespace Glue

open Complex Compulsion

/-! ## The operators -/

/-- Reflection across the line through `p` and `q`, any `p ≠ q`: **conjugate the axis
ratio** — `z ↦ p + (q−p)·conj((z−p)/(q−p))`. M21's mirror identity
(`reflAcross` conjugates the ratio — the obligation-pass lemma `reflAcross_ratio`)
elevated to the definition; at unit axis it collapses to `Coupled.reflAcross`
(`reflAxis_eq_reflAcross`). Total: at `p = q` the ratio is junk `0` and the map
degenerates to `const p`; every theorem carries `p ≠ q`. -/
noncomputable def reflAxis (p q z : ℂ) : ℂ :=
  p + (q - p) * (starRingEnd ℂ) ((z - p) / (q - p))

/-- The (+)-branch intersection of `sphere p r₁` and `sphere q r₂`, explicit and
division-once. In the frame `v = (x−p)·conj(q−p)` the point is the DIVISION-FREE pair
`⟨A, √(r₁²d² − A²)⟩` with `d² = normSq (q−p)`, `A = (d² + r₁² − r₂²)/2` (two pinned
norms fix `v.re = A` exactly — no denominator); the single division is the frame's
inverse, `·/conj(q−p)` (legitimate because `(q−p)·conj(q−p) = d²`). The `√`'s argument
is the **gluing discriminant** — nonnegative exactly on the annulus condition, and the
square root the partner construction adjoins: the formula IS the field-growth meter.
Total: outside the annulus the `√` clamps to 0 and the point simply fails membership
(the intersection is then empty — `sphere_inter_sphere_eq_empty_*`); at tangency the
point equals its mirror and the classification's pair degenerates to a singleton. -/
noncomputable def gluePoint (p q : ℂ) (r₁ r₂ : ℝ) : ℂ :=
  p + (⟨(normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2,
        Real.sqrt (r₁ ^ 2 * normSq (q - p)
          - ((normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2) ^ 2)⟩ : ℂ)
      / (starRingEnd ℂ) (q - p)

/-! ## The reflection package, general axis -/

/-- The reflection fixes the first pivot. -/
theorem reflAxis_pivot_left (p q : ℂ) : reflAxis p q p = p := by
  sorry

/-- The reflection fixes the second pivot (any distinct pair — the M21 unit premise
was the normalization, not the mechanism). -/
theorem reflAxis_pivot_right {p q : ℂ} (h : p ≠ q) : reflAxis p q q = q := by
  sorry

/-- The reflection is an involution. -/
theorem reflAxis_reflAxis {p q : ℂ} (h : p ≠ q) (z : ℂ) :
    reflAxis p q (reflAxis p q z) = z := by
  sorry

/-- The reflection is an isometry. -/
theorem dist_reflAxis {p q : ℂ} (h : p ≠ q) (z w : ℂ) :
    dist (reflAxis p q z) (reflAxis p q w) = dist z w := by
  sorry

/-- Mirrors stay on every circle about `p`. -/
theorem reflAxis_mem_sphere_left {p q z : ℂ} (h : p ≠ q) {r : ℝ}
    (hz : z ∈ Metric.sphere p r) : reflAxis p q z ∈ Metric.sphere p r := by
  sorry

/-- Mirrors stay on every circle about `q`. -/
theorem reflAxis_mem_sphere_right {p q z : ℂ} (h : p ≠ q) {r : ℝ}
    (hz : z ∈ Metric.sphere q r) : reflAxis p q z ∈ Metric.sphere q r := by
  sorry

/-- At unit axis the general mirror is M21's: the bridge to `Coupled.reflAcross`. -/
theorem reflAxis_eq_reflAcross {p q : ℂ} (h : dist p q = 1) :
    reflAxis p q = Coupled.reflAcross p q := by
  sorry

/-! ## The classification -/

/-- **The general gluing classification.** Two distinct centres, radii satisfying the
annulus condition: the intersection is exactly the glue point and its mirror. Subsumes
M21's four unit-axis gluings; instantiates at every partner adjunction (`x`, `c`, `1`,
`r`) and at the metapivot couplings (axis 1/√3). Tangency (equality in either bound)
is the case `gluePoint = its mirror`; the two-element notation collapses and the
statement stands — as does the zero-radius degeneracy (`r₁ = 0`, `d = r₂`: both
points collapse onto `p`). Radius nonnegativity is NOT assumed: it is derivable from
the annulus pair (`|r₁ − r₂| ≤ d ≤ r₁ + r₂` forces both radii ≥ 0 — the obligation
pass re-derives it internally), so the hypotheses are exactly the three that bind:
distinct centres and the two annulus bounds. -/
theorem sphere_inter_sphere {p q : ℂ} (hpq : p ≠ q) {r₁ r₂ : ℝ}
    (hlo : |r₁ - r₂| ≤ dist p q) (hhi : dist p q ≤ r₁ + r₂) :
    Metric.sphere p r₁ ∩ Metric.sphere q r₂
      = {gluePoint p q r₁ r₂, reflAxis p q (gluePoint p q r₁ r₂)} := by
  sorry

/-- Empty outside the annulus, far side: the circles are too separated to meet. -/
theorem sphere_inter_sphere_eq_empty_of_far {p q : ℂ} {r₁ r₂ : ℝ}
    (hhi : r₁ + r₂ < dist p q) :
    Metric.sphere p r₁ ∩ Metric.sphere q r₂ = ∅ := by
  sorry

/-- Empty outside the annulus, near side: one circle strictly inside the other. -/
theorem sphere_inter_sphere_eq_empty_of_near {p q : ℂ} {r₁ r₂ : ℝ}
    (hlo : dist p q < |r₁ - r₂|) :
    Metric.sphere p r₁ ∩ Metric.sphere q r₂ = ∅ := by
  sorry

/-! ## Specification

Non-vacuity at a NON-unit axis (the whole point of the generalization), the bridge to
the M21 case, and the metapivot instance from the M23 horizon. Filled at
implementation. -/

/-- At the unit case the glue point is the hex step: the M21 outer∩outer
classification is this module's `(1, 1)` instance at the canonical pair. -/
example : gluePoint 0 1 1 1 = hexStep 0 1 := by
  sorry

/-- The metapivot instance (axis 1/√3 — a genuinely non-unit axis): the centroid
`⟨1/2, √3/6⟩` of the unit triangle {0, 1, ζ₆} has its outer circle meet `0`'s inner
circle in exactly the centroid's 120°-partners about `0`. The concrete model of the
classification's hypotheses beyond M21's reach. -/
example : rot3 0 (⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ)
    ∈ Metric.sphere (⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ) 1
      ∩ Metric.sphere (0 : ℂ) (Real.sqrt 3 / 3) := by
  sorry

/-- The far empty case is inhabited: unit circles about `0` and `3` miss. -/
example : Metric.sphere (0 : ℂ) 1 ∩ Metric.sphere (3 : ℂ) 1 = ∅ := by
  sorry

/-! ## The nine-step near-cycle (§2.3, kept by the domain pass)

Nine seam steps miss one hex step by chord < 1/50 — and do NOT close. Both facts are
exact field arithmetic (no transcendence): since `|ζ₆·σ⁹| = 1`, the chord bound
reduces to `re (ζ₆·σ⁹) > 1 − 1/5000`, a rational inequality against √3, √11 bounds;
the nonvanishing reduces through sixth powers to `σ⁵⁴ ≠ 1`, M19's `seam_pow_ne_one`.
The first certified near-relation: the aiming lemma of the exactness thread. -/

/-- The near-cycle does not close: `ζ₆·σ⁹ ≠ 1` (else `σ⁵⁴ = 1`, against the seam's
infinite order). The `0 <` half of the near-miss. -/
theorem zeta6_mul_seam_pow_nine_ne_one : TwoCircle.zeta6 * TwoCircle.seam ^ 9 ≠ 1 := by
  sorry

/-- **The nine-step near-cycle**: `normSq (ζ₆·σ⁹ − 1) < 1/2500` — nine seam steps
return to within chord 1/50 of one hex step. Exact arithmetic in ℚ(√3,√11);
numerically the miss is 1.008°, chord ≈ 0.0176. -/
theorem normSq_zeta6_mul_seam_pow_nine_sub_one_lt :
    normSq (TwoCircle.zeta6 * TwoCircle.seam ^ 9 - 1) < 1 / 2500 := by
  sorry

end Glue
end HadwigerNelson
