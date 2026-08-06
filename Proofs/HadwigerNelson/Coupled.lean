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

/-- The pair premise in multiplicative form: the axis direction is a unit. -/
private theorem norm_q_sub_p {p q : ℂ} (h : dist p q = 1) : ‖q - p‖ = 1 := by
  sorry

/-- The pair premise in `normSq` form — the engine for every cancellation below. -/
private theorem normSq_q_sub_p {p q : ℂ} (h : dist p q = 1) : normSq (q - p) = 1 := by
  sorry

/-- The reflection fixes the first pivot — no distance hypothesis needed
(`conj 0 = 0`; the obligation pass deleted the dead premise). -/
theorem reflAcross_pivot_left (p q : ℂ) : reflAcross p q p = p := by
  sorry

/-- The reflection fixes the second pivot. -/
theorem reflAcross_pivot_right {p q : ℂ} (h : dist p q = 1) : reflAcross p q q = q := by
  sorry

/-- The reflection does not care which pivot anchors it: `reflAcross q p = reflAcross p q`
(their difference telescopes to `(p − q) + (q − p)·normSq (q − p)`). Makes the swap
corollary below a rewrite. -/
theorem reflAcross_swap {p q : ℂ} (h : dist p q = 1) :
    reflAcross q p = reflAcross p q := by
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

/-! ## The interlock: each system's operators land on the partner

The pair premise as membership is Mathlib's own `Metric.mem_sphere'.mpr h : q ∈ sphere p 1`
— no alias is minted (the experience pass deleted one: an alias a search must wade past
teaches less than the lemma the search already finds). -/

/-- The seam of one system lands on the other: `seamImage p q` sits on `p`'s inner
circle AND on `q`'s outer circle. The interlock that makes the pair rigid. -/
theorem seamImage_interlock {p q : ℂ} (h : dist p q = 1) :
    seamImage p q ∈ Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q 1 := by
  sorry

/-! ## The gluing classification: the four circle-pair intersections, explicitly

The `⊆` direction of all three classifications shares one spine, minted once: pass to
the unit frame `v = (x − p)·conj(q − p)` (norms preserved since the axis is a unit),
where the two sphere memberships pin `v.re` and `v.im²` — two roots, the named point
and its mirror. The `⊇` direction is four distance computations per lemma, all M20
norm lemmas plus the reflection package. -/

/-- The unit-frame move: a point on both spheres, rewritten as `p + v·(q − p)` with both
norms of `v` pinned. One lemma carries the `⊆` spine of all three classifications. -/
private theorem unit_frame {p q x : ℂ} (h : dist p q = 1) {r₁ r₂ : ℝ}
    (hx : x ∈ Metric.sphere p r₁ ∩ Metric.sphere q r₂) :
    ∃ v : ℂ, x = p + v * (q - p) ∧ ‖v‖ = r₁ ∧ ‖v - 1‖ = r₂ := by
  sorry

/-- Two pinned norms fix the real part: `v.re = (1 + r₁² − r₂²)/2`. -/
private theorem re_of_norms {v : ℂ} {r₁ r₂ : ℝ} (h₁ : ‖v‖ = r₁) (h₂ : ‖v - 1‖ = r₂) :
    v.re = (1 + r₁ ^ 2 - r₂ ^ 2) / 2 := by
  sorry

/-- Two pinned norms fix the imaginary part up to sign: `v.im² = r₁² − v.re²`. -/
private theorem im_sq_of_norm {v : ℂ} {r₁ : ℝ} (h₁ : ‖v‖ = r₁) :
    v.im ^ 2 = r₁ ^ 2 - v.re ^ 2 := by
  sorry

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

/-! ## Specification

Non-vacuity of the module premise, and the classification's teeth: the gluing sets are
exactly two points, so a third candidate is refuted. Filled at implementation (the
examples consume the lemmas above). -/

/-- The module premise is inhabited: `0` and `1` are at distance one. -/
example : dist (0 : ℂ) 1 = 1 := by
  sorry

/-- The gluing sets are inhabited: the hex step of the partner really does sit on both
outer circles (the `⊇` direction of `outer_inter_outer`, at the concrete pair). -/
example : hexStep 0 1 ∈ Metric.sphere (0 : ℂ) 1 ∩ Metric.sphere (1 : ℂ) 1 := by
  sorry

/-- The interlock is inhabited at the concrete pair: the seam image of `1` about `0`
lies on `0`'s inner circle and one unit from `1`. -/
example : seamImage 0 1 ∈ Metric.sphere (0 : ℂ) (Real.sqrt 3 / 3) ∩ Metric.sphere 1 1 := by
  sorry

/-- The classification's teeth (adversarial member): the second pivot itself lies on
`p`'s outer circle, yet NOT in the outer∩outer gluing set (its distance to itself is 0,
not 1) — the two named points really are the only ones. -/
example : (1 : ℂ) ∉ Metric.sphere (0 : ℂ) 1 ∩ Metric.sphere (1 : ℂ) 1 := by
  sorry

end Coupled
end HadwigerNelson
