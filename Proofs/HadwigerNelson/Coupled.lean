import Proofs.HadwigerNelson.Compulsion

/-! # Coupled circle systems: the unit-distance pivot pair (M21 skeleton)

M20's one-pivot cap proved a 5th colour needs structure spanning at least two pivots;
this module studies the smallest such structure. Two pivots at distance exactly 1, each
carrying its two circles (radius `1` and `1/√3` — M20's cap object, here named `system`):
each pivot lies ON the partner's outer circle, and the systems interlock through the
strip's own operators — the eight circle-intersection points are `hexStep` images
(outer∩outer), `seamImage`s (outer∩inner and its swap), and one new half-sector
direction (inner∩inner). The gluing classification below is the pair's analogue of
M19's three chord lemmas.

The configuration's symmetry is a single operator: `reflAcross p q`, reflection across
the pivot axis — an involutive isometry fixing both pivots (exactly when `dist p q = 1`,
which is the module's standing premise). Every intersection pair is {a point, its
mirror}; every ±-branch fact is the +-branch fact plus one isometry application.

The χ of the pair system is measured-but-open (subplan §2.4): every sampled finite
sub-lattice is 4-colourable, yet no pair of M19 sector colourings is proper on the pair
under any rotation, reflection, or palette injection — so neither `= 4` nor `≥ 5` is
committed as a statement here; each carries a reopening gate in the subplan. The
mesh-barrier fact stays tools-side: its honest statement quantifies over a continuous
offset and would cost analytic curve-coverage machinery (domain pass, 2026-08-05).

SKELETON: proofs are `sorry`; the statements are the specification under review.
-/

namespace HadwigerNelson
namespace Coupled

open Complex Compulsion

/-! ## The objects -/

/-- One pivot's whole system: the centre and its two circles — M20's cap object, named.
`chromaticNumber_concentric` says its induced unit-distance graph is exactly 4-chromatic. -/
noncomputable def system (p : ℂ) : Set ℂ :=
  insert p (Metric.sphere p 1 ∪ Metric.sphere p (Real.sqrt 3 / 3))

/-- The coupled system of two pivots. At `dist p q = 1` this is the milestone's object. -/
noncomputable def pairSystem (p q : ℂ) : Set ℂ := system p ∪ system q

/-- Reflection across the line through `p` and `q`: `z ↦ p + (q−p)²·conj(z−p)`.
An involutive isometry fixing `p` and `q` exactly when `dist p q = 1` (the module's
standing premise; the normalization `(q−p)/|q−p|` is folded away by it). The
configuration's one symmetry: every gluing pair below is {a point, its mirror}. -/
def reflAcross (p q z : ℂ) : ℂ := p + (q - p) ^ 2 * (starRingEnd ℂ) (z - p)

/-- The inner∩inner gluing ratio `⟨1/2, √3/6⟩` — `ζ₁₂/√3`, the half-sector direction:
the one intersection direction the strip operators do not already name. -/
noncomputable def innerGlueRatio : ℂ := ⟨1 / 2, Real.sqrt 3 / 6⟩

/-! ## The reflection package: the ± branches for the price of one -/

/-- The reflection fixes the first pivot. -/
theorem reflAcross_pivot_left {p q : ℂ} (h : dist p q = 1) : reflAcross p q p = p := by
  sorry

/-- The reflection fixes the second pivot. -/
theorem reflAcross_pivot_right {p q : ℂ} (h : dist p q = 1) : reflAcross p q q = q := by
  sorry

/-- The reflection is an involution. -/
theorem reflAcross_reflAcross {p q : ℂ} (h : dist p q = 1) (z : ℂ) :
    reflAcross p q (reflAcross p q z) = z := by
  sorry

/-- The reflection is an isometry. With the pivot-fixing lemmas this transports every
sphere membership and every unit chord to the mirror branch. -/
theorem dist_reflAcross {p q : ℂ} (h : dist p q = 1) (z w : ℂ) :
    dist (reflAcross p q z) (reflAcross p q w) = dist z w := by
  sorry

/-- Mirrors stay on every circle about `p` (isometry + fixed pivot, specialized). -/
theorem reflAcross_mem_sphere_left {p q z : ℂ} (h : dist p q = 1) {r : ℝ}
    (hz : z ∈ Metric.sphere p r) : reflAcross p q z ∈ Metric.sphere p r := by
  sorry

/-- Mirrors stay on every circle about `q`. -/
theorem reflAcross_mem_sphere_right {p q z : ℂ} (h : dist p q = 1) {r : ℝ}
    (hz : z ∈ Metric.sphere q r) : reflAcross p q z ∈ Metric.sphere q r := by
  sorry

/-! ## The interlock: each system's operators land on the partner -/

/-- The pair premise as membership: at distance 1 the partner pivot is an outer point. -/
theorem pivot_mem_outer {p q : ℂ} (h : dist p q = 1) : q ∈ Metric.sphere p 1 := by
  sorry

/-- The seam of one system lands on the other: `seamImage p q` sits on `p`'s inner
circle AND on `q`'s outer circle. The interlock that makes the pair rigid. -/
theorem seamImage_interlock {p q : ℂ} (h : dist p q = 1) :
    seamImage p q ∈ Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q 1 := by
  sorry

/-! ## The gluing classification: the four circle-pair intersections, explicitly -/

/-- Outer meets outer in exactly the partner's hex step and its mirror. -/
theorem outer_inter_outer {p q : ℂ} (h : dist p q = 1) :
    Metric.sphere p 1 ∩ Metric.sphere q 1
      = {hexStep p q, reflAcross p q (hexStep p q)} := by
  sorry

/-- `p`'s outer meets `q`'s inner in exactly the seam image of `p` about `q` and its
mirror. -/
theorem outer_inter_inner {p q : ℂ} (h : dist p q = 1) :
    Metric.sphere p 1 ∩ Metric.sphere q (Real.sqrt 3 / 3)
      = {seamImage q p, reflAcross p q (seamImage q p)} := by
  sorry

/-- `p`'s inner meets `q`'s outer: the swap image of `outer_inter_inner`. -/
theorem inner_inter_outer {p q : ℂ} (h : dist p q = 1) :
    Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q 1
      = {seamImage p q, reflAcross p q (seamImage p q)} := by
  sorry

/-- Inner meets inner in exactly the half-sector point and its mirror. -/
theorem inner_inter_inner {p q : ℂ} (h : dist p q = 1) :
    Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q (Real.sqrt 3 / 3)
      = {p + innerGlueRatio * (q - p), reflAcross p q (p + innerGlueRatio * (q - p))} := by
  sorry

/-! ## The lower bound -/

/-- Any vertex set containing one pivot's whole system needs at least four colours —
M20's cap read through the superset quantification (colourings restrict, so the
monotonicity is baked into the statement; the M20 lesson). -/
theorem four_le_chromaticNumber_of_system_subset {p : ℂ} {D : Set ℂ}
    (hD : system p ⊆ D) : 4 ≤ ((unitDistance ℂ).induce D).chromaticNumber := by
  sorry

/-- The pair needs at least four colours — no distance hypothesis required. -/
theorem four_le_chromaticNumber_pairSystem (p q : ℂ) :
    4 ≤ ((unitDistance ℂ).induce (pairSystem p q)).chromaticNumber :=
  four_le_chromaticNumber_of_system_subset Set.subset_union_left

end Coupled
end HadwigerNelson
