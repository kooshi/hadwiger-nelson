import Proofs.HadwigerNelson.Compulsion

/-! # Coupled circle systems: the unit-distance pivot pair

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

The whole classification is one lemma applied four times: `inter_eq_pair` says the
intersection of the sphere of radius `‖c‖` about `p` with the sphere of radius `‖c − 1‖`
about `q` is exactly the conjugate ratio pair `{p + c·(q−p), p + conj c·(q−p)}`. The
four named theorems differ only in which ratio `c` they feed it — `ζ₆`, `1 − σ`, `σ`,
and the half-sector ratio — so the geometric content sits in the ratios and their two
norms, not in four separate arguments.
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
  rw [← Complex.dist_eq, dist_comm]; exact h

/-- The pair premise in `normSq` form — the engine for every cancellation below. -/
private theorem normSq_q_sub_p {p q : ℂ} (h : dist p q = 1) : normSq (q - p) = 1 := by
  rw [← Complex.sq_norm, norm_q_sub_p h]; norm_num

/-- The axis cancellation `(q − p)·conj (q − p) = 1`: the single algebraic fact every
reflection lemma below is a `linear_combination` of. -/
private theorem axis_cancel {p q : ℂ} (h : dist p q = 1) :
    (q - p) * (starRingEnd ℂ) (q - p) = 1 := by
  rw [Complex.mul_conj, normSq_q_sub_p h]; norm_num

/-- The reflection fixes the first pivot — no distance hypothesis needed
(`conj 0 = 0`; the obligation pass deleted the dead premise). -/
theorem reflAcross_pivot_left (p q : ℂ) : reflAcross p q p = p := by
  simp [reflAcross]

/-- The reflection fixes the second pivot. -/
theorem reflAcross_pivot_right {p q : ℂ} (h : dist p q = 1) : reflAcross p q q = q := by
  simp only [reflAcross]
  linear_combination (q - p) * axis_cancel h

/-- The reflection does not care which pivot anchors it: `reflAcross q p = reflAcross p q`.
Makes the swap corollary below a rewrite. -/
theorem reflAcross_swap {p q : ℂ} (h : dist p q = 1) :
    reflAcross q p = reflAcross p q := by
  have ha := axis_cancel h
  simp only [map_sub] at ha
  funext z
  simp only [reflAcross, map_sub]
  linear_combination (-(q - p)) * ha

/-- The reflection is an involution. -/
theorem reflAcross_reflAcross {p q : ℂ} (h : dist p q = 1) (z : ℂ) :
    reflAcross p q (reflAcross p q z) = z := by
  have ha := axis_cancel h
  simp only [reflAcross, add_sub_cancel_left, map_mul, map_pow, Complex.conj_conj]
  linear_combination ((z - p) * ((q - p) * (starRingEnd ℂ) (q - p) + 1)) * ha

/-- The reflection is an isometry. With the pivot-fixing lemmas this transports every
sphere membership and every unit chord to the mirror branch. -/
theorem dist_reflAcross {p q : ℂ} (h : dist p q = 1) (z w : ℂ) :
    dist (reflAcross p q z) (reflAcross p q w) = dist z w := by
  have hd : reflAcross p q z - reflAcross p q w
      = (q - p) ^ 2 * (starRingEnd ℂ) (z - w) := by
    simp only [reflAcross, map_sub]; ring
  rw [Complex.dist_eq, hd, norm_mul, norm_pow, norm_q_sub_p h, norm_conj,
    ← Complex.dist_eq]
  norm_num

/-- Mirrors stay on every circle about `p` (isometry + fixed pivot, specialized). -/
theorem reflAcross_mem_sphere_left {p q z : ℂ} (h : dist p q = 1) {r : ℝ}
    (hz : z ∈ Metric.sphere p r) : reflAcross p q z ∈ Metric.sphere p r := by
  have key := dist_reflAcross h z p
  rw [reflAcross_pivot_left] at key
  simp only [Metric.mem_sphere] at hz ⊢
  rw [key]; exact hz

/-- Mirrors stay on every circle about `q`. -/
theorem reflAcross_mem_sphere_right {p q z : ℂ} (h : dist p q = 1) {r : ℝ}
    (hz : z ∈ Metric.sphere q r) : reflAcross p q z ∈ Metric.sphere q r := by
  have key := dist_reflAcross h z q
  rw [reflAcross_pivot_right h] at key
  simp only [Metric.mem_sphere] at hz ⊢
  rw [key]; exact hz

/-- **The mirror is conjugation in the axis frame**: reflecting the point at ratio `c`
along the axis gives the point at ratio `conj c`. The fact that makes all three gluing
classifications one argument — every intersection pair is a conjugate pair of ratios. -/
private theorem reflAcross_frame {p q : ℂ} (h : dist p q = 1) (c : ℂ) :
    reflAcross p q (p + c * (q - p)) = p + (starRingEnd ℂ) c * (q - p) := by
  have ha := axis_cancel h
  simp only [reflAcross, add_sub_cancel_left, map_mul]
  linear_combination ((starRingEnd ℂ) c * (q - p)) * ha

/-! ## The interlock: each system's operators land on the partner

The pair premise as membership is Mathlib's own `Metric.mem_sphere'.mpr h : q ∈ sphere p 1`
— no alias is minted (the experience pass deleted one: an alias a search must wade past
teaches less than the lemma the search already finds). -/

/-- The seam of one system lands on the other: `seamImage p q` sits on `p`'s inner
circle AND on `q`'s outer circle. The interlock that makes the pair rigid. -/
theorem seamImage_interlock {p q : ℂ} (h : dist p q = 1) :
    seamImage p q ∈ Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q 1 := by
  have hqp : dist q p = 1 := by rw [dist_comm]; exact h
  refine ⟨?_, ?_⟩
  · simpa only [Metric.mem_sphere] using dist_seamImage_pivot hqp
  · simp only [Metric.mem_sphere, dist_comm (seamImage p q) q]
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
  simp only [Metric.mem_sphere] at hx1 hx2
  have ha := axis_cancel h
  have hc : ‖(starRingEnd ℂ) (q - p)‖ = 1 := by rw [norm_conj]; exact norm_q_sub_p h
  refine ⟨(x - p) * (starRingEnd ℂ) (q - p), ?_, ?_, ?_⟩
  · linear_combination (-(x - p)) * ha
  · rw [norm_mul, hc, mul_one, ← Complex.dist_eq]; exact hx1
  · have hshift : (x - p) * (starRingEnd ℂ) (q - p) - 1
        = (x - q) * (starRingEnd ℂ) (q - p) := by linear_combination ha
    rw [hshift, norm_mul, hc, mul_one, ← Complex.dist_eq]; exact hx2

/-- Two pinned norms fix the real part: `v.re = (1 + r₁² − r₂²)/2`. -/
private theorem re_of_norms {v : ℂ} {r₁ r₂ : ℝ} (h₁ : ‖v‖ = r₁) (h₂ : ‖v - 1‖ = r₂) :
    v.re = (1 + r₁ ^ 2 - r₂ ^ 2) / 2 := by
  have e₁ : normSq v = r₁ ^ 2 := by rw [← Complex.sq_norm, h₁]
  have e₂ : normSq (v - 1) = r₂ ^ 2 := by rw [← Complex.sq_norm, h₂]
  simp only [Complex.normSq_apply, Complex.sub_re, Complex.sub_im, Complex.one_re,
    Complex.one_im] at e₁ e₂
  linear_combination (e₁ - e₂) / 2

/-- Two pinned norms fix the imaginary part up to sign: `v.im² = r₁² − v.re²`. -/
private theorem im_sq_of_norm {v : ℂ} {r₁ : ℝ} (h₁ : ‖v‖ = r₁) :
    v.im ^ 2 = r₁ ^ 2 - v.re ^ 2 := by
  have e₁ : normSq v = r₁ ^ 2 := by rw [← Complex.sq_norm, h₁]
  simp only [Complex.normSq_apply] at e₁
  linear_combination e₁

/-- The two roots: a complex number whose real part matches `c` and whose imaginary part
matches `c` up to sign is `c` or its conjugate. Closes every `⊆` direction below. -/
private theorem eq_or_eq_conj {v c : ℂ} (hre : v.re = c.re) (him : v.im ^ 2 = c.im ^ 2) :
    v = c ∨ v = (starRingEnd ℂ) c := by
  have h0 : (v.im - c.im) * (v.im + c.im) = 0 := by linear_combination him
  rcases mul_eq_zero.mp h0 with hz | hz
  · exact Or.inl (Complex.ext hre (by linarith))
  · exact Or.inr (Complex.ext (by rw [Complex.conj_re]; exact hre)
      (by rw [Complex.conj_im]; linarith))

/-- The `⊇` spine, exact converse of `unit_frame`: the point at ratio `c` sits on the
two spheres its norms name. -/
private theorem mem_inter_of_ratio {p q : ℂ} (h : dist p q = 1) {c : ℂ} {r₁ r₂ : ℝ}
    (h₁ : ‖c‖ = r₁) (h₂ : ‖c - 1‖ = r₂) :
    p + c * (q - p) ∈ Metric.sphere p r₁ ∩ Metric.sphere q r₂ := by
  constructor
  · simp only [Metric.mem_sphere, Complex.dist_eq, add_sub_cancel_left, norm_mul,
      norm_q_sub_p h, mul_one]
    exact h₁
  · simp only [Metric.mem_sphere, Complex.dist_eq]
    rw [show p + c * (q - p) - q = (c - 1) * (q - p) by ring, norm_mul, norm_q_sub_p h,
      mul_one]
    exact h₂

/-- The whole classification argument, once: the intersection of the two spheres is
the conjugate pair of ratios that `c` names. Each of the four theorems below is this
lemma plus the two norm facts of its ratio. -/
private theorem inter_eq_pair {p q : ℂ} (h : dist p q = 1) {c : ℂ} {r₁ r₂ : ℝ}
    (h₁ : ‖c‖ = r₁) (h₂ : ‖c - 1‖ = r₂) :
    Metric.sphere p r₁ ∩ Metric.sphere q r₂
      = {p + c * (q - p), reflAcross p q (p + c * (q - p))} := by
  ext x
  simp only [Set.mem_insert_iff, Set.mem_singleton_iff]
  constructor
  · intro hx
    obtain ⟨v, rfl, hv1, hv2⟩ := unit_frame h hx
    have hre : v.re = c.re := by rw [re_of_norms hv1 hv2, re_of_norms h₁ h₂]
    have him : v.im ^ 2 = c.im ^ 2 := by
      rw [im_sq_of_norm hv1, im_sq_of_norm h₁, hre]
    rcases eq_or_eq_conj hre him with rfl | rfl
    · exact Or.inl rfl
    · exact Or.inr (reflAcross_frame h c).symm
  · rintro (rfl | rfl)
    · exact mem_inter_of_ratio h h₁ h₂
    · rw [reflAcross_frame h]
      refine mem_inter_of_ratio h ?_ ?_
      · rw [norm_conj]; exact h₁
      · rw [show (starRingEnd ℂ) c - 1 = (starRingEnd ℂ) (c - 1) by simp, norm_conj]
        exact h₂

/-! ### The four ratios and their norms -/

private theorem sq_sqrt3 : Real.sqrt 3 * Real.sqrt 3 = 3 :=
  Real.mul_self_sqrt (by norm_num)

private theorem inner_radius_sq : (Real.sqrt 3 / 3) ^ 2 = 1 / 3 := by
  rw [div_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 3)]; norm_num

private theorem inner_radius_nonneg : (0 : ℝ) ≤ Real.sqrt 3 / 3 := by positivity

private theorem norm_eq_of_normSq {z : ℂ} {r : ℝ} (hr : 0 ≤ r) (h : normSq z = r ^ 2) :
    ‖z‖ = r := by rw [Complex.norm_def, h, Real.sqrt_sq hr]

private theorem norm_zeta6_sub_one : ‖TwoCircle.zeta6 - 1‖ = 1 := by
  refine norm_eq_of_normSq (by norm_num) ?_
  simp only [normSq_apply, Complex.sub_re, Complex.sub_im, Complex.one_re,
    Complex.one_im, TwoCircle.zeta6]
  nlinarith [sq_sqrt3]

private theorem norm_seamRatio : ‖seamRatio‖ = Real.sqrt 3 / 3 :=
  norm_eq_of_normSq inner_radius_nonneg (by rw [normSq_seamRatio, inner_radius_sq])

private theorem norm_one_sub_seamRatio : ‖1 - seamRatio‖ = 1 :=
  norm_eq_of_normSq (by norm_num) (by rw [normSq_one_sub_seamRatio]; norm_num)

private theorem norm_seamRatio_sub_one : ‖seamRatio - 1‖ = 1 := by
  rw [norm_sub_rev]; exact norm_one_sub_seamRatio

private theorem norm_one_sub_seamRatio_sub_one :
    ‖(1 - seamRatio) - 1‖ = Real.sqrt 3 / 3 := by
  rw [show (1 - seamRatio) - 1 = -seamRatio by ring, norm_neg]; exact norm_seamRatio

private theorem norm_innerGlueRatio : ‖innerGlueRatio‖ = Real.sqrt 3 / 3 := by
  refine norm_eq_of_normSq inner_radius_nonneg ?_
  rw [inner_radius_sq]
  simp only [normSq_apply, innerGlueRatio]
  nlinarith [sq_sqrt3]

private theorem norm_innerGlueRatio_sub_one :
    ‖innerGlueRatio - 1‖ = Real.sqrt 3 / 3 := by
  refine norm_eq_of_normSq inner_radius_nonneg ?_
  rw [inner_radius_sq]
  simp only [normSq_apply, Complex.sub_re, Complex.sub_im, Complex.one_re,
    Complex.one_im, innerGlueRatio]
  nlinarith [sq_sqrt3]

/-! ### The classifications -/

/-- Outer meets outer in exactly the partner's hex step and its mirror. -/
theorem outer_inter_outer {p q : ℂ} (h : dist p q = 1) :
    Metric.sphere p 1 ∩ Metric.sphere q 1
      = {hexStep p q, reflAcross p q (hexStep p q)} :=
  inter_eq_pair h TwoCircle.norm_zeta6 norm_zeta6_sub_one

/-- `p`'s outer meets `q`'s inner in exactly the seam image of `p` about `q` and its
mirror — the partner's seam, seen in `p`'s frame at ratio `1 − σ`. -/
theorem outer_inter_inner {p q : ℂ} (h : dist p q = 1) :
    Metric.sphere p 1 ∩ Metric.sphere q (Real.sqrt 3 / 3)
      = {seamImage q p, reflAcross p q (seamImage q p)} := by
  have hframe : seamImage q p = p + (1 - seamRatio) * (q - p) := by
    simp only [seamImage]; ring
  rw [hframe]
  exact inter_eq_pair h norm_one_sub_seamRatio norm_one_sub_seamRatio_sub_one

/-- `p`'s inner meets `q`'s outer: the swap image of `outer_inter_inner`. -/
theorem inner_inter_outer {p q : ℂ} (h : dist p q = 1) :
    Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q 1
      = {seamImage p q, reflAcross p q (seamImage p q)} := by
  have hqp : dist q p = 1 := by rw [dist_comm]; exact h
  rw [Set.inter_comm, outer_inter_inner hqp, reflAcross_swap h]

/-- Inner meets inner in exactly the half-sector point and its mirror. -/
theorem inner_inter_inner {p q : ℂ} (h : dist p q = 1) :
    Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q (Real.sqrt 3 / 3)
      = {p + innerGlueRatio * (q - p), reflAcross p q (p + innerGlueRatio * (q - p))} :=
  inter_eq_pair h norm_innerGlueRatio norm_innerGlueRatio_sub_one

/-! ## The lower bound -/

/-- Any vertex set containing one pivot's whole system needs at least four colours —
M20's cap read through the superset quantification (colourings restrict, so the
monotonicity is baked into the statement; the M20 lesson). -/
theorem four_le_chromaticNumber_of_system_subset {p : ℂ} {D : Set ℂ}
    (hD : system p ⊆ D) : 4 ≤ ((unitDistance ℂ).induce D).chromaticNumber := by
  by_contra hlt
  have h3 : ((unitDistance ℂ).induce D).chromaticNumber ≤ 3 :=
    Order.le_of_lt_add_one (by exact_mod_cast lt_of_not_ge hlt)
  have hcol : ((unitDistance ℂ).induce D).Colorable 3 :=
    SimpleGraph.chromaticNumber_le_iff_colorable.mp h3
  have hmaps : Set.MapsTo (id : ℂ → ℂ) (system p) D := fun _ hz => hD hz
  exact concentric_not_colorable_three p
    (hcol.of_hom (SimpleGraph.induceHom SimpleGraph.Hom.id hmaps))

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
