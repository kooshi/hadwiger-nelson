import Proofs.HadwigerNelson.Compulsion

/-! # Coupled circle systems: the unit-distance pivot pair (M21)

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

private theorem sq_sqrt3 : Real.sqrt 3 * Real.sqrt 3 = 3 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sq_sqrt11 : Real.sqrt 11 * Real.sqrt 11 = 11 :=
  Real.mul_self_sqrt (by norm_num)

/-! ## The reflection package: the ± branches for the price of one -/

/-- The pair premise in multiplicative form: the axis direction is a unit. -/
private theorem norm_q_sub_p {p q : ℂ} (h : dist p q = 1) : ‖q - p‖ = 1 := by
  rw [← Complex.dist_eq, dist_comm]
  exact h

/-- The pair premise in `normSq` form — the engine for every cancellation below. -/
private theorem normSq_q_sub_p {p q : ℂ} (h : dist p q = 1) : normSq (q - p) = 1 := by
  rw [← Complex.sq_norm, norm_q_sub_p h]
  norm_num

/-- The premise as one multiplicative identity: `(q−p)·conj(q−p) = 1`. Every proof in
the package is a `linear_combination` of this line. -/
private theorem mul_conj_q_sub_p {p q : ℂ} (h : dist p q = 1) :
    (q - p) * (starRingEnd ℂ) (q - p) = 1 := by
  rw [Complex.mul_conj, normSq_q_sub_p h, Complex.ofReal_one]

/-- The reflection fixes the first pivot — no distance hypothesis needed
(`conj 0 = 0`; the obligation pass deleted the dead premise). -/
theorem reflAcross_pivot_left (p q : ℂ) : reflAcross p q p = p := by
  simp [reflAcross]

/-- The reflection fixes the second pivot. -/
theorem reflAcross_pivot_right {p q : ℂ} (h : dist p q = 1) : reflAcross p q q = q := by
  have key := mul_conj_q_sub_p h
  simp only [reflAcross]
  linear_combination (q - p) * key

/-- The reflection does not care which pivot anchors it: `reflAcross q p = reflAcross p q`
(their difference telescopes to `(p − q) + (q − p)·normSq (q − p)`). Makes the swap
corollary below a rewrite. -/
theorem reflAcross_swap {p q : ℂ} (h : dist p q = 1) :
    reflAcross q p = reflAcross p q := by
  funext z
  have key := mul_conj_q_sub_p h
  have hc : (starRingEnd ℂ) (z - q) = (starRingEnd ℂ) (z - p) - (starRingEnd ℂ) (q - p) := by
    rw [← map_sub]
    congr 1
    ring
  simp only [reflAcross]
  rw [hc]
  linear_combination (-(q - p)) * key

/-- The reflection is an involution. -/
theorem reflAcross_reflAcross {p q : ℂ} (h : dist p q = 1) (z : ℂ) :
    reflAcross p q (reflAcross p q z) = z := by
  have key := mul_conj_q_sub_p h
  simp only [reflAcross, add_sub_cancel_left, map_mul, map_pow, Complex.conj_conj]
  linear_combination (((q - p) * (starRingEnd ℂ) (q - p) + 1) * (z - p)) * key

/-- The reflection is an isometry. With the pivot-fixing lemmas this transports every
sphere membership and every unit chord to the mirror branch. -/
theorem dist_reflAcross {p q : ℂ} (h : dist p q = 1) (z w : ℂ) :
    dist (reflAcross p q z) (reflAcross p q w) = dist z w := by
  have h1 : reflAcross p q z - reflAcross p q w = (q - p) ^ 2 * (starRingEnd ℂ) (z - w) := by
    have hc : (starRingEnd ℂ) (z - w)
        = (starRingEnd ℂ) (z - p) - (starRingEnd ℂ) (w - p) := by
      rw [← map_sub]
      congr 1
      ring
    rw [hc]
    simp only [reflAcross]
    ring
  rw [Complex.dist_eq, Complex.dist_eq, h1, norm_mul, norm_pow, RCLike.norm_conj,
    norm_q_sub_p h, one_pow, one_mul]

/-- Mirrors stay on every circle about `p` (isometry + fixed pivot, specialized). -/
theorem reflAcross_mem_sphere_left {p q z : ℂ} (h : dist p q = 1) {r : ℝ}
    (hz : z ∈ Metric.sphere p r) : reflAcross p q z ∈ Metric.sphere p r := by
  simp only [Metric.mem_sphere] at hz ⊢
  calc dist (reflAcross p q z) p
      = dist (reflAcross p q z) (reflAcross p q p) := by rw [reflAcross_pivot_left]
    _ = dist z p := dist_reflAcross h z p
    _ = r := hz

/-- Mirrors stay on every circle about `q`. -/
theorem reflAcross_mem_sphere_right {p q z : ℂ} (h : dist p q = 1) {r : ℝ}
    (hz : z ∈ Metric.sphere q r) : reflAcross p q z ∈ Metric.sphere q r := by
  simp only [Metric.mem_sphere] at hz ⊢
  calc dist (reflAcross p q z) q
      = dist (reflAcross p q z) (reflAcross p q q) := by rw [reflAcross_pivot_right h]
    _ = dist z q := dist_reflAcross h z q
    _ = r := hz

/-- The mirror of a point given by its axis ratio: `reflAcross` conjugates the ratio.
The verified identity from the obligation pass — every mirror branch below is this line. -/
private theorem reflAcross_ratio {p q : ℂ} (h : dist p q = 1) (u : ℂ) :
    reflAcross p q (p + u * (q - p)) = p + (starRingEnd ℂ) u * (q - p) := by
  have key := mul_conj_q_sub_p h
  simp only [reflAcross, add_sub_cancel_left, map_mul]
  linear_combination ((starRingEnd ℂ) u * (q - p)) * key

/-- Conjugation on explicit components. -/
private theorem conj_mk (a b : ℝ) : (starRingEnd ℂ) (⟨a, b⟩ : ℂ) = ⟨a, -b⟩ := by
  refine Complex.ext ?_ ?_ <;> simp

/-! ## The interlock: each system's operators land on the partner

The pair premise as membership is Mathlib's own `Metric.mem_sphere'.mpr h : q ∈ sphere p 1`
— no alias is minted (the experience pass deleted one: an alias a search must wade past
teaches less than the lemma the search already finds). -/

/-- The seam of one system lands on the other: `seamImage p q` sits on `p`'s inner
circle AND on `q`'s outer circle. The interlock that makes the pair rigid. -/
theorem seamImage_interlock {p q : ℂ} (h : dist p q = 1) :
    seamImage p q ∈ Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q 1 := by
  have hqp : dist q p = 1 := by rw [dist_comm]; exact h
  refine ⟨dist_seamImage_pivot hqp, ?_⟩
  simp only [Metric.mem_sphere]
  rw [dist_comm]
  exact dist_self_seamImage hqp

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
  obtain ⟨hx1, hx2⟩ := hx
  have key := mul_conj_q_sub_p h
  refine ⟨(x - p) * (starRingEnd ℂ) (q - p), ?_, ?_, ?_⟩
  · linear_combination (p - x) * key
  · rw [norm_mul, RCLike.norm_conj, norm_q_sub_p h, mul_one, ← Complex.dist_eq]
    exact hx1
  · have hv1 : (x - p) * (starRingEnd ℂ) (q - p) - 1
        = (x - q) * (starRingEnd ℂ) (q - p) := by
      linear_combination key
    rw [hv1, norm_mul, RCLike.norm_conj, norm_q_sub_p h, mul_one, ← Complex.dist_eq]
    exact hx2

/-- Two pinned norms fix the real part: `v.re = (1 + r₁² − r₂²)/2`. -/
private theorem re_of_norms {v : ℂ} {r₁ r₂ : ℝ} (h₁ : ‖v‖ = r₁) (h₂ : ‖v - 1‖ = r₂) :
    v.re = (1 + r₁ ^ 2 - r₂ ^ 2) / 2 := by
  have hn1 : normSq v = r₁ ^ 2 := by rw [← Complex.sq_norm, h₁]
  have hn2 : normSq (v - 1) = r₂ ^ 2 := by rw [← Complex.sq_norm, h₂]
  simp only [normSq_apply, Complex.sub_re, Complex.sub_im, Complex.one_re,
    Complex.one_im] at hn1 hn2
  linear_combination (1 / 2 : ℝ) * hn1 - (1 / 2 : ℝ) * hn2

/-- Two pinned norms fix the imaginary part up to sign: `v.im² = r₁² − v.re²`. -/
private theorem im_sq_of_norm {v : ℂ} {r₁ : ℝ} (h₁ : ‖v‖ = r₁) :
    v.im ^ 2 = r₁ ^ 2 - v.re ^ 2 := by
  have hn1 : normSq v = r₁ ^ 2 := by rw [← Complex.sq_norm, h₁]
  simp only [normSq_apply] at hn1
  linear_combination hn1

/-- Outer meets outer in exactly the partner's hex step and its mirror. -/
theorem outer_inter_outer {p q : ℂ} (h : dist p q = 1) :
    Metric.sphere p 1 ∩ Metric.sphere q 1
      = {hexStep p q, reflAcross p q (hexStep p q)} := by
  have hqp : dist q p = 1 := by rw [dist_comm]; exact h
  have hq1 : q ∈ Metric.sphere p 1 := hqp
  have hratio : hexStep p q = p + (⟨1 / 2, Real.sqrt 3 / 2⟩ : ℂ) * (q - p) := rfl
  have hmirror : reflAcross p q (hexStep p q)
      = p + (⟨1 / 2, -(Real.sqrt 3 / 2)⟩ : ℂ) * (q - p) := by
    rw [hratio, reflAcross_ratio h, conj_mk]
  apply Set.Subset.antisymm
  · intro x hx
    obtain ⟨v, hxv, hv1, hv2⟩ := unit_frame h hx
    have hre : v.re = 1 / 2 := by
      rw [re_of_norms hv1 hv2]
      norm_num
    have him : v.im * v.im = (Real.sqrt 3 / 2) * (Real.sqrt 3 / 2) := by
      have h2 := im_sq_of_norm hv1
      rw [hre] at h2
      linear_combination h2 - (1 / 4 : ℝ) * sq_sqrt3
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff]
    rcases mul_self_eq_mul_self_iff.mp him with h1 | h1
    · left
      have hv : v = (⟨1 / 2, Real.sqrt 3 / 2⟩ : ℂ) := Complex.ext hre h1
      rw [hxv, hv, ← hratio]
    · right
      have hv : v = (⟨1 / 2, -(Real.sqrt 3 / 2)⟩ : ℂ) := Complex.ext hre h1
      rw [hxv, hv, ← hmirror]
  · intro x hx
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hx
    have hmem : hexStep p q ∈ Metric.sphere p 1 ∩ Metric.sphere q 1 := by
      refine ⟨hexStep_mem_sphere hq1, ?_⟩
      simp only [Metric.mem_sphere]
      rw [dist_comm]
      exact dist_self_hexStep hqp
    rcases hx with rfl | rfl
    · exact hmem
    · exact ⟨reflAcross_mem_sphere_left h hmem.1, reflAcross_mem_sphere_right h hmem.2⟩

/-- `p`'s outer meets `q`'s inner in exactly the seam image of `p` about `q` and its
mirror. -/
theorem outer_inter_inner {p q : ℂ} (h : dist p q = 1) :
    Metric.sphere p 1 ∩ Metric.sphere q (Real.sqrt 3 / 3)
      = {seamImage q p, reflAcross p q (seamImage q p)} := by
  have hratio : seamImage q p = p + (⟨5 / 6, -(Real.sqrt 11 / 6)⟩ : ℂ) * (q - p) := by
    have hc : (⟨5 / 6, -(Real.sqrt 11 / 6)⟩ : ℂ) = 1 - seamRatio := by
      refine Complex.ext ?_ ?_ <;>
        simp only [Complex.sub_re, Complex.sub_im, Complex.one_re, Complex.one_im,
          seamRatio] <;>
        norm_num
    rw [hc]
    simp only [seamImage]
    ring
  have hmirror : reflAcross p q (seamImage q p)
      = p + (⟨5 / 6, Real.sqrt 11 / 6⟩ : ℂ) * (q - p) := by
    rw [hratio, reflAcross_ratio h, conj_mk, neg_neg]
  apply Set.Subset.antisymm
  · intro x hx
    obtain ⟨v, hxv, hv1, hv2⟩ := unit_frame h hx
    have hre : v.re = 5 / 6 := by
      rw [re_of_norms hv1 hv2, div_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 3)]
      norm_num
    have him : v.im * v.im = (-(Real.sqrt 11 / 6)) * (-(Real.sqrt 11 / 6)) := by
      have h2 := im_sq_of_norm hv1
      rw [hre] at h2
      linear_combination h2 - (1 / 36 : ℝ) * sq_sqrt11
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff]
    rcases mul_self_eq_mul_self_iff.mp him with h1 | h1
    · left
      have hv : v = (⟨5 / 6, -(Real.sqrt 11 / 6)⟩ : ℂ) := Complex.ext hre h1
      rw [hxv, hv, ← hratio]
    · right
      have h1' : v.im = Real.sqrt 11 / 6 := by rw [h1]; ring
      have hv : v = (⟨5 / 6, Real.sqrt 11 / 6⟩ : ℂ) := Complex.ext hre h1'
      rw [hxv, hv, ← hmirror]
  · intro x hx
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hx
    have hmem : seamImage q p ∈ Metric.sphere p 1 ∩ Metric.sphere q (Real.sqrt 3 / 3) := by
      constructor
      · simp only [Metric.mem_sphere]
        rw [dist_comm]
        exact dist_self_seamImage h
      · exact dist_seamImage_pivot h
    rcases hx with rfl | rfl
    · exact hmem
    · exact ⟨reflAcross_mem_sphere_left h hmem.1, reflAcross_mem_sphere_right h hmem.2⟩

/-- `p`'s inner meets `q`'s outer: the swap image of `outer_inter_inner`. -/
theorem inner_inter_outer {p q : ℂ} (h : dist p q = 1) :
    Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q 1
      = {seamImage p q, reflAcross p q (seamImage p q)} := by
  have hqp : dist q p = 1 := by rw [dist_comm]; exact h
  rw [Set.inter_comm, outer_inter_inner hqp, reflAcross_swap h]

/-- Inner meets inner in exactly the half-sector point and its mirror. -/
theorem inner_inter_inner {p q : ℂ} (h : dist p q = 1) :
    Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q (Real.sqrt 3 / 3)
      = {p + innerGlueRatio * (q - p), reflAcross p q (p + innerGlueRatio * (q - p))} := by
  have hmirror : reflAcross p q (p + innerGlueRatio * (q - p))
      = p + (⟨1 / 2, -(Real.sqrt 3 / 6)⟩ : ℂ) * (q - p) := by
    have hconj : (starRingEnd ℂ) innerGlueRatio = (⟨1 / 2, -(Real.sqrt 3 / 6)⟩ : ℂ) := by
      simp only [innerGlueRatio, conj_mk]
    rw [reflAcross_ratio h, hconj]
  have hnr : ‖innerGlueRatio‖ = Real.sqrt 3 / 3 := by
    have hsq : normSq innerGlueRatio = 1 / 3 := by
      simp only [normSq_apply, innerGlueRatio]
      linear_combination (1 / 36 : ℝ) * sq_sqrt3
    rw [Complex.norm_def, hsq,
      show (1 : ℝ) / 3 = (Real.sqrt 3 / 3) ^ 2 by
        rw [div_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 3)]; norm_num]
    exact Real.sqrt_sq (by positivity)
  have hnr' : ‖innerGlueRatio - 1‖ = Real.sqrt 3 / 3 := by
    have hsq : normSq (innerGlueRatio - 1) = 1 / 3 := by
      simp only [normSq_apply, Complex.sub_re, Complex.sub_im, Complex.one_re,
        Complex.one_im, innerGlueRatio]
      linear_combination (1 / 36 : ℝ) * sq_sqrt3
    rw [Complex.norm_def, hsq,
      show (1 : ℝ) / 3 = (Real.sqrt 3 / 3) ^ 2 by
        rw [div_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 3)]; norm_num]
    exact Real.sqrt_sq (by positivity)
  apply Set.Subset.antisymm
  · intro x hx
    obtain ⟨v, hxv, hv1, hv2⟩ := unit_frame h hx
    have hre : v.re = 1 / 2 := by
      rw [re_of_norms hv1 hv2]
      ring_nf
    have him : v.im * v.im = (Real.sqrt 3 / 6) * (Real.sqrt 3 / 6) := by
      have h2 := im_sq_of_norm hv1
      rw [hre, div_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 3)] at h2
      linear_combination h2 - (1 / 36 : ℝ) * sq_sqrt3
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff]
    rcases mul_self_eq_mul_self_iff.mp him with h1 | h1
    · left
      have hv : v = innerGlueRatio := Complex.ext hre h1
      rw [hxv, hv]
    · right
      have hv : v = (⟨1 / 2, -(Real.sqrt 3 / 6)⟩ : ℂ) := Complex.ext hre h1
      rw [hxv, hv, ← hmirror]
  · intro x hx
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hx
    have hmem : p + innerGlueRatio * (q - p)
        ∈ Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q (Real.sqrt 3 / 3) := by
      constructor
      · simp only [Metric.mem_sphere]
        rw [Complex.dist_eq, add_sub_cancel_left, norm_mul, norm_q_sub_p h, mul_one]
        exact hnr
      · simp only [Metric.mem_sphere]
        rw [Complex.dist_eq,
          show p + innerGlueRatio * (q - p) - q = (innerGlueRatio - 1) * (q - p) by ring,
          norm_mul, norm_q_sub_p h, mul_one]
        exact hnr'
    rcases hx with rfl | rfl
    · exact hmem
    · exact ⟨reflAcross_mem_sphere_left h hmem.1, reflAcross_mem_sphere_right h hmem.2⟩

/-! ## The lower bound -/

/-- Any vertex set containing one pivot's whole system needs at least four colours —
M20's cap read through the superset quantification (colourings restrict, so the
monotonicity is baked into the statement; the M20 lesson). -/
theorem four_le_chromaticNumber_of_system_subset {p : ℂ} {D : Set ℂ}
    (hD : system p ⊆ D) : 4 ≤ ((unitDistance ℂ).induce D).chromaticNumber := by
  by_contra hlt
  have h3 : ((unitDistance ℂ).induce D).chromaticNumber ≤ 3 := by
    have := lt_of_not_ge hlt
    exact Order.le_of_lt_add_one (by exact_mod_cast this)
  have hcol : ((unitDistance ℂ).induce D).Colorable 3 :=
    SimpleGraph.chromaticNumber_le_iff_colorable.mp h3
  have hmaps : Set.MapsTo id (system p) D := fun x hx => hD hx
  have hcol' : ((unitDistance ℂ).induce (system p)).Colorable 3 :=
    hcol.of_hom (SimpleGraph.induceHom SimpleGraph.Hom.id hmaps)
  exact concentric_not_colorable_three p hcol'

/-- The pair needs at least four colours — no distance hypothesis required. -/
theorem four_le_chromaticNumber_pairSystem (p q : ℂ) :
    4 ≤ ((unitDistance ℂ).induce (pairSystem p q)).chromaticNumber :=
  four_le_chromaticNumber_of_system_subset Set.subset_union_left

/-! ## Specification

Non-vacuity of the module premise, and the classification's teeth: the gluing sets are
exactly two points, so a third candidate is refuted. The examples consume the lemmas
above. -/

private theorem dist_zero_one : dist (0 : ℂ) 1 = 1 := by
  rw [Complex.dist_eq]
  simp

/-- The module premise is inhabited: `0` and `1` are at distance one. -/
example : dist (0 : ℂ) 1 = 1 := dist_zero_one

/-- The gluing sets are inhabited: the hex step of the partner really does sit on both
outer circles (the `⊇` direction of `outer_inter_outer`, at the concrete pair). -/
example : hexStep 0 1 ∈ Metric.sphere (0 : ℂ) 1 ∩ Metric.sphere (1 : ℂ) 1 := by
  rw [outer_inter_outer dist_zero_one]
  exact Set.mem_insert _ _

/-- The interlock is inhabited at the concrete pair: the seam image of `1` about `0`
lies on `0`'s inner circle and one unit from `1`. -/
example : seamImage 0 1 ∈ Metric.sphere (0 : ℂ) (Real.sqrt 3 / 3) ∩ Metric.sphere 1 1 :=
  seamImage_interlock dist_zero_one

/-- The classification's teeth (adversarial member): the second pivot itself lies on
`p`'s outer circle, yet NOT in the outer∩outer gluing set (its distance to itself is 0,
not 1) — the two named points really are the only ones. Refuted through the
classification's right-hand side: the candidate differs from both named points in its
real part (`1 ≠ 1/2`). -/
example : (1 : ℂ) ∉ Metric.sphere (0 : ℂ) 1 ∩ Metric.sphere (1 : ℂ) 1 := by
  rw [outer_inter_outer dist_zero_one]
  intro hmem
  have hre : (1 : ℂ).re = 1 / 2 := by
    rcases hmem with h | h
    · calc (1 : ℂ).re = (hexStep 0 1).re := by rw [← h]
        _ = 1 / 2 := by
          simp only [hexStep, TwoCircle.zeta6]
          simp
    · rw [Set.mem_singleton_iff] at h
      calc (1 : ℂ).re = (reflAcross 0 1 (hexStep 0 1)).re := by rw [← h]
        _ = 1 / 2 := by
          simp only [reflAcross, hexStep, TwoCircle.zeta6]
          simp
  norm_num at hre

end Coupled
end HadwigerNelson
