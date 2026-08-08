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

The named point's imaginary part is `√(r₁²·d² − A²)/d²` — the square root the partner
construction adjoins. That the formula IS the field-growth meter is the point: the
tools-side closure (`tools/couple.py` at implementation) cites this statement as the
definition of the move, so the construction is stated, not merely computed.

The mirror operator generalizes M21's `reflAcross` by the axis normalization
`(q−p)²/|q−p|²`; at unit axis it agrees with `Coupled.reflAcross` definitionally up to
the `normSq = 1` rewrite, recorded as a bridge lemma.

SKELETON: proofs are `sorry`; the statements are the specification under review.
-/

namespace HadwigerNelson
namespace Glue

open Complex Compulsion

/-! ## The operators -/

/-- Reflection across the line through `p` and `q`, any `p ≠ q`:
`z ↦ p + ((q−p)²/|q−p|²)·conj(z−p)`. Generalizes `Coupled.reflAcross` (axis length
folded out rather than assumed 1). -/
noncomputable def reflAxis (p q z : ℂ) : ℂ :=
  p + (q - p) ^ 2 / (normSq (q - p) : ℂ) * (starRingEnd ℂ) (z - p)

/-- The (+)-branch intersection of `sphere p r₁` and `sphere q r₂`, explicit. With
`d² = normSq (q−p)` and `A = (d² + r₁² − r₂²)/2`, the point is
`p + ⟨A/d², √(r₁²d² − A²)/d²⟩·(q−p)`; its mirror is `reflAxis` of it. Total: outside
the annulus condition the `√` clamps to zero and the point is simply not in the
intersection (which is then empty — `sphere_inter_sphere_eq_empty_*`). -/
noncomputable def gluePoint (p q : ℂ) (r₁ r₂ : ℝ) : ℂ :=
  p + (⟨(normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2 / normSq (q - p),
        Real.sqrt (r₁ ^ 2 * normSq (q - p)
          - ((normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2) ^ 2) / normSq (q - p)⟩ : ℂ)
      * (q - p)

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
`r`) and at the metapivot couplings (axis 1/√3). Tangency (`equality` in either bound)
is the case `gluePoint = its mirror`; the two-element notation collapses and the
statement stands. -/
theorem sphere_inter_sphere {p q : ℂ} (hpq : p ≠ q) {r₁ r₂ : ℝ}
    (h₁ : 0 ≤ r₁) (h₂ : 0 ≤ r₂)
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

end Glue
end HadwigerNelson
