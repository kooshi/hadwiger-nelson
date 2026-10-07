import Proofs.HadwigerNelson.Plane.CoverExamples
import Proofs.HadwigerNelson.Plane.LocalStructure

/-!
# Essential boundary points of an arc map's regions (FS-131 wave 6, FS131-I6B)

The local fact FS121-C1-SAT's argument reads (`plans/FS121-C1-proof.md` § 2.3: "the two faces beside it … each of density `1/2`
… `x` is a density point of no class, so it is an essential boundary point"), proved for every arc map with no sector chart:

* **The two sides of a line or a circle near one of its points.** `curveSide z κ b` is the defining function of
  `curveAt z κ b` (wave 3): zero on the curve, negative on the side of `b` (inside the circle), positive on the other. In a
  ball about `z` of radius at most `‖b‖` each side is preconnected — the negative one convex (`convex_curveSide_neg`), the
  positive one because every point of it is joined to the far half-disc by a segment along `-b`
  (`isPreconnected_curveSide_pos`) — and each holds the disc of radius `s` tangent at `z`
  (`curveSide_neg_of_mem_ball`, `curveSide_pos_of_mem_ball`).
* **A punctured disc is preconnected** (`MapEdge.isPreconnected_puncturedBall`).
* **`ArcMap.exists_mem_essBoundary_region`**: at a point of the domain in the closures of two different colours' regions,
  every neighbourhood holds an essential boundary point of each of the two regions. (Inside a good ball about the point,
  wave 3's `GoodAt.exists_local_curve` puts the arcs near any other point `z` on one full curve; the punctured ball is
  connected, so some `z` is in the closure of `region i` and of the other colours; the two sides of the curve at `z` are in
  one region each, one of them `region i`, the other not, and each has lower density at least `1/16` at `z`.)

The generic density facts used on the way are stated in the namespace `MapEdge` (names of this module's own: giving each
one home with the same facts of other modules is a tidy after wave 6's first landing).

**Inhabitant.** `sq9Map` at the edge point `sqEdgePt`, colours `sqColA` and `sqColB`: the two `example`s after
`sq9Map_sat_model` in `Plane/Saturated/MapColouring` instantiate `ArcMap.mem_essBoundary_region_of_curve` (the line
`re z = 1/2` in `B(sqEdgePt, 1/8)`) and `ArcMap.exists_mem_essBoundary_region` there.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

/-! ## Density facts -/

namespace MapEdge

/-- Almost everywhere equal sets have the same density ratios. -/
theorem densityRatio_congr_ae {A B : Set ℂ} (h : A =ᵐ[volume] B) : densityRatio A = densityRatio B := by
  funext x r
  unfold densityRatio
  rw [measure_congr (h.inter (ae_eq_refl (closedBall x r)))]

/-- Almost everywhere equal sets have the same essential boundary. -/
theorem essBoundary_congr_ae {A B : Set ℂ} (h : A =ᵐ[volume] B) : essBoundary A = essBoundary B := by
  simp only [essBoundary, essClosure, densitySet, upperDensityAt, densityRatio_congr_ae h]

/-- Almost everywhere equal sets have the same support. -/
theorem essSupport_congr_ae {A B : Set ℂ} (h : A =ᵐ[volume] B) : essSupport A = essSupport B :=
  subset_antisymm (essSupport_mono_ae h.le) (essSupport_mono_ae h.symm.le)

/-- A point at which a set disjoint from the measurable set `A` has positive upper density is not a density point of
`A`. -/
theorem notMem_densitySet_of_disjoint {A B : Set ℂ} (hA : MeasurableSet A) (hAB : Disjoint A B) {z : ℂ}
    (hB : 0 < upperDensityAt B z) : z ∉ densitySet A := by
  intro hz
  have h0 := tendsto_densityRatio_compl_of_mem hA hz
  have hle : ∀ r, densityRatio B z r ≤ densityRatio Aᶜ z r := fun r => by
    unfold densityRatio
    gcongr
    exact fun w hw hwA => Set.disjoint_left.1 hAB hwA hw
  have h1 : upperDensityAt B z ≤ 0 := by
    rw [← h0.limsup_eq]
    exact limsup_le_limsup (Eventually.of_forall hle)
  exact (lt_of_lt_of_le hB h1).false

end MapEdge

/-! ## The two sides of a line or a circle -/

/-- The defining function of `curveAt z κ b`: zero on the curve, negative on the side of `b` (inside the circle about
`z + b` when `κ = 1`), positive on the other side. -/
noncomputable def curveSide (z : ℂ) (κ : ℝ) (b w : ℂ) : ℝ :=
  κ * Complex.normSq (w - z) - 2 * ((w - z) * (starRingEnd ℂ) b).re

/-- The curve is the zero set of its defining function. -/
theorem mem_curveAt_iff_curveSide {z : ℂ} {κ : ℝ} {b w : ℂ} : w ∈ curveAt z κ b ↔ curveSide z κ b w = 0 := by
  simp only [curveAt, mem_setOf_eq, curveSide, sub_eq_zero]

/-- Spec: on the unit circle about `1` through `0`, the centre is on the negative side and the point `3` on the
positive side. -/
example : curveSide 0 1 1 1 < 0 ∧ 0 < curveSide 0 1 1 3 := by
  constructor <;> norm_num [curveSide, Complex.normSq_apply]

/-- The defining function in coordinates. -/
theorem curveSide_eq (z : ℂ) (κ : ℝ) (b w : ℂ) :
    curveSide z κ b w = κ * ((w.re - z.re) ^ 2 + (w.im - z.im) ^ 2) -
      2 * ((w.re - z.re) * b.re + (w.im - z.im) * b.im) := by
  simp only [curveSide, re_mul_conj_eq, Complex.normSq_apply, Complex.sub_re, Complex.sub_im]
  ring

/-- **Re-basing**: the curve through `x` with data `(κ, b)` has, at any of its points `z`, the data `(κ, b − κ (z − x))`,
with the same defining function. -/
theorem curveSide_rebase {x z : ℂ} {κ : ℝ} {b : ℂ} (hz : curveSide x κ b z = 0) (w : ℂ) :
    curveSide z κ (b - (κ : ℂ) * (z - x)) w = curveSide x κ b w := by
  rw [curveSide_eq] at hz
  rw [curveSide_eq, curveSide_eq]
  simp only [Complex.sub_re, Complex.sub_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im]
  linear_combination -hz

/-- Re-basing keeps the size of the data vector. -/
theorem normSq_rebase {x z : ℂ} {κ : ℝ} {b : ℂ} (hz : curveSide x κ b z = 0) :
    Complex.normSq (b - (κ : ℂ) * (z - x)) = Complex.normSq b := by
  rw [curveSide_eq] at hz
  simp only [Complex.normSq_apply, Complex.sub_re, Complex.sub_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re,
    Complex.ofReal_im]
  linear_combination κ * hz

/-- The defining function is continuous. -/
theorem continuous_curveSide (z : ℂ) (κ : ℝ) (b : ℂ) : Continuous (curveSide z κ b) := by
  unfold curveSide
  fun_prop

/-- The negative side of a line or a circle (`κ ≥ 0`) is convex. -/
theorem convex_curveSide_neg (z : ℂ) {κ : ℝ} (hκ : 0 ≤ κ) (b : ℂ) : Convex ℝ {w | curveSide z κ b w < 0} := by
  intro w₁ h₁ w₂ h₂ s t hs ht hst
  simp only [mem_setOf_eq, curveSide_eq] at h₁ h₂ ⊢
  simp only [Complex.add_re, Complex.add_im, Complex.real_smul, Complex.mul_re, Complex.mul_im, Complex.ofReal_re,
    Complex.ofReal_im, zero_mul, sub_zero, add_zero]
  obtain rfl : t = 1 - s := by linarith
  have key : κ * ((s * w₁.re + (1 - s) * w₂.re - z.re) ^ 2 + (s * w₁.im + (1 - s) * w₂.im - z.im) ^ 2) -
      2 * ((s * w₁.re + (1 - s) * w₂.re - z.re) * b.re + (s * w₁.im + (1 - s) * w₂.im - z.im) * b.im) =
      s * (κ * ((w₁.re - z.re) ^ 2 + (w₁.im - z.im) ^ 2) - 2 * ((w₁.re - z.re) * b.re + (w₁.im - z.im) * b.im)) +
      (1 - s) * (κ * ((w₂.re - z.re) ^ 2 + (w₂.im - z.im) ^ 2) - 2 * ((w₂.re - z.re) * b.re + (w₂.im - z.im) * b.im)) -
      κ * (s * (1 - s)) * ((w₁.re - w₂.re) ^ 2 + (w₁.im - w₂.im) ^ 2) := by ring
  rw [key]
  have h3 : 0 ≤ κ * (s * (1 - s)) * ((w₁.re - w₂.re) ^ 2 + (w₁.im - w₂.im) ^ 2) := by positivity
  rcases eq_or_lt_of_le hs with rfl | hs'
  · simp only [zero_mul, zero_add, sub_zero, one_mul, mul_zero] at h3 ⊢
    linarith
  · nlinarith [mul_pos hs' (neg_pos.2 h₁), mul_nonneg ht (neg_pos.2 h₂).le]

/-- Membership in a ball, in coordinates. -/
theorem MapEdge.mem_ball_iff_sq {z w : ℂ} {δ : ℝ} (hδ : 0 < δ) :
    w ∈ ball z δ ↔ (w.re - z.re) ^ 2 + (w.im - z.im) ^ 2 < δ ^ 2 := by
  rw [mem_ball, Complex.dist_eq_re_im, Real.sqrt_lt' hδ]

/-- The inequalities of the push along `-b` (real variables: `N = |w − z|²`, `R = ⟨w − z, b⟩`, `B = |b|²`; the point
`w − t b` has `N − 2tR + t²B` and `R − tB` in their places). -/
theorem MapEdge.push_real {κ N R B δ τ T t : ℝ} (hκ0 : 0 ≤ κ) (hκ1 : κ ≤ 1) (hB : 0 < B) (hR0 : 0 ≤ R) (hRB : R ≤ B)
    (hf : 0 < κ * N - 2 * R) (hτ0 : 0 < τ) (hτ1 : τ ≤ 1) (hτ : τ * (2 * R + B) < δ ^ 2 - N)
    (hT : T * B = 2 * R + τ * B) (ht0 : 0 ≤ t) (htT : t ≤ T) :
    N - 2 * t * R + t ^ 2 * B < δ ^ 2 ∧ 0 < κ * (N - 2 * t * R + t ^ 2 * B) - 2 * (R - t * B) := by
  have h1 : t * (T * B) = t * (2 * R + τ * B) := by rw [hT]
  have h2 : τ * (T * B) = τ * (2 * R + τ * B) := by rw [hT]
  have a1 : 0 ≤ t * (T - t) * B := mul_nonneg (mul_nonneg ht0 (sub_nonneg.2 htT)) hB.le
  have a2 : 0 ≤ (T - t) * τ * B := mul_nonneg (mul_nonneg (sub_nonneg.2 htT) hτ0.le) hB.le
  have a3 : 0 ≤ τ * B * (1 - τ) := mul_nonneg (mul_nonneg hτ0.le hB.le) (sub_nonneg.2 hτ1)
  have a4 : 0 ≤ (1 - κ) * R := mul_nonneg (sub_nonneg.2 hκ1) hR0
  have a5 : 0 ≤ t * (B - κ * R) := mul_nonneg ht0 (by linarith)
  have a6 : 0 ≤ κ * t ^ 2 * B := mul_nonneg (mul_nonneg hκ0 (sq_nonneg t)) hB.le
  constructor
  · nlinarith
  · nlinarith

/-- **The push**: a point on the positive side of a line or a circle, in a ball about a point `z` of it of radius at most
`‖b‖`, is joined inside that side of the ball to the open half-disc beyond the tangent at `z`, by a segment along `-b`. -/
theorem exists_segment_curveSide_pos {z : ℂ} {κ : ℝ} (hκ0 : 0 ≤ κ) (hκ1 : κ ≤ 1) {b : ℂ} (hb : b ≠ 0) {δ : ℝ}
    (hδ : δ ≤ ‖b‖) {w : ℂ} (hw : w ∈ ball z δ) (hpos : 0 < curveSide z κ b w) :
    ∃ w', (w' ∈ ball z δ ∧ ((w' - z) * (starRingEnd ℂ) b).re < 0) ∧
      segment ℝ w w' ⊆ {v | v ∈ ball z δ ∧ 0 < curveSide z κ b v} := by
  have hδ0 : 0 < δ := lt_of_le_of_lt dist_nonneg hw
  set N := (w.re - z.re) ^ 2 + (w.im - z.im) ^ 2 with hN
  set R := (w.re - z.re) * b.re + (w.im - z.im) * b.im with hR
  set B := b.re ^ 2 + b.im ^ 2 with hBdef
  have hB : 0 < B := by
    have := Complex.normSq_pos.2 hb
    rw [Complex.normSq_apply] at this
    rw [hBdef]; nlinarith
  have hNδ : N < δ ^ 2 := (MapEdge.mem_ball_iff_sq hδ0).1 hw
  have hδB : δ ^ 2 ≤ B := by
    have h1 : ‖b‖ ^ 2 = B := by rw [Complex.sq_norm, Complex.normSq_apply, hBdef]; ring
    rw [← h1]
    exact pow_le_pow_left₀ hδ0.le hδ 2
  have hf : 0 < κ * N - 2 * R := by rw [curveSide_eq] at hpos; exact hpos
  by_cases hR0 : R < 0
  · refine ⟨w, ⟨hw, by rw [re_mul_conj_eq, Complex.sub_re, Complex.sub_im]; exact hR0⟩, ?_⟩
    rw [segment_same]
    exact singleton_subset_iff.2 ⟨hw, hpos⟩
  rw [not_lt] at hR0
  have hCS : R ^ 2 ≤ N * B := by
    rw [hR, hN, hBdef]
    nlinarith [sq_nonneg ((w.re - z.re) * b.im - (w.im - z.im) * b.re)]
  have hRB : R ≤ B := by
    by_contra hcon
    rw [not_le] at hcon
    have hN0 : 0 ≤ N := by rw [hN]; positivity
    nlinarith [mul_le_mul_of_nonneg_right (hNδ.le.trans hδB) hB.le]
  set τ := min 1 ((δ ^ 2 - N) / (2 * (2 * R + B))) with hτdef
  have hden : 0 < 2 * (2 * R + B) := by linarith
  have hτ0 : 0 < τ := lt_min one_pos (div_pos (by linarith) hden)
  have hτ1 : τ ≤ 1 := min_le_left _ _
  have hτ : τ * (2 * R + B) < δ ^ 2 - N := by
    have h1 : τ ≤ (δ ^ 2 - N) / (2 * (2 * R + B)) := min_le_right _ _
    rw [le_div_iff₀ hden] at h1
    linarith
  set T := (2 * R + τ * B) / B with hTdef
  have hT : T * B = 2 * R + τ * B := by rw [hTdef]; field_simp
  have hT0 : 0 ≤ T := div_nonneg (by positivity) hB.le
  have hcoord : ∀ t : ℝ, ((w - (t : ℂ) * b).re - z.re) ^ 2 + ((w - (t : ℂ) * b).im - z.im) ^ 2 = N - 2 * t * R + t ^ 2 * B ∧
      ((w - (t : ℂ) * b).re - z.re) * b.re + ((w - (t : ℂ) * b).im - z.im) * b.im = R - t * B := by
    intro t
    simp only [Complex.sub_re, Complex.sub_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
      zero_mul, sub_zero, add_zero, hN, hR, hBdef]
    constructor <;> ring
  have hpt : ∀ t : ℝ, 0 ≤ t → t ≤ T → w - (t : ℂ) * b ∈ ball z δ ∧ 0 < curveSide z κ b (w - (t : ℂ) * b) := by
    intro t ht0 htT
    obtain ⟨g1, g2⟩ := MapEdge.push_real hκ0 hκ1 hB hR0 hRB hf hτ0 hτ1 hτ hT ht0 htT
    rw [MapEdge.mem_ball_iff_sq hδ0, curveSide_eq, (hcoord t).1, (hcoord t).2]
    exact ⟨g1, g2⟩
  refine ⟨w - (T : ℂ) * b, ⟨(hpt T hT0 le_rfl).1, ?_⟩, ?_⟩
  · rw [re_mul_conj_eq, Complex.sub_re (w - (T : ℂ) * b), Complex.sub_im (w - (T : ℂ) * b), (hcoord T).2]
    nlinarith
  · rw [segment_eq_image]
    rintro v ⟨θ, hθ, rfl⟩
    have e : (1 - θ) • w + θ • (w - (T : ℂ) * b) = w - ((θ * T : ℝ) : ℂ) * b := by
      simp only [Complex.real_smul]; push_cast; ring
    show (1 - θ) • w + θ • (w - (T : ℂ) * b) ∈ _
    rw [e]
    exact hpt (θ * T) (mul_nonneg hθ.1 hT0) (by nlinarith [hθ.2])

/-- The open half-disc beyond the tangent at `z` is convex. -/
theorem MapEdge.convex_halfDisc (z b : ℂ) (δ : ℝ) :
    Convex ℝ {v : ℂ | v ∈ ball z δ ∧ ((v - z) * (starRingEnd ℂ) b).re < 0} := by
  have h : {v : ℂ | v ∈ ball z δ ∧ ((v - z) * (starRingEnd ℂ) b).re < 0} = ball z δ ∩ {v | curveSide z 0 (-b) v < 0} := by
    ext v
    simp only [mem_setOf_eq, mem_inter_iff, curveSide, zero_mul, zero_sub, map_neg, mul_neg, Complex.neg_re]
    constructor <;> rintro ⟨h1, h2⟩ <;> exact ⟨h1, by linarith⟩
  rw [h]
  exact (convex_ball z δ).inter (convex_curveSide_neg z le_rfl (-b))

/-- **The positive side is preconnected**: of a line or a circle (`0 ≤ κ ≤ 1`), in a ball about one of its points of
radius at most `‖b‖`. -/
theorem isPreconnected_curveSide_pos {z : ℂ} {κ : ℝ} (hκ0 : 0 ≤ κ) (hκ1 : κ ≤ 1) {b : ℂ} (hb : b ≠ 0) {δ : ℝ}
    (hδ : δ ≤ ‖b‖) : IsPreconnected {w | w ∈ ball z δ ∧ 0 < curveSide z κ b w} := by
  apply isPreconnected_of_forall_pair
  intro w₁ h₁ w₂ h₂
  obtain ⟨w₁', hH₁, hs₁⟩ := exists_segment_curveSide_pos hκ0 hκ1 hb hδ h₁.1 h₁.2
  obtain ⟨w₂', hH₂, hs₂⟩ := exists_segment_curveSide_pos hκ0 hκ1 hb hδ h₂.1 h₂.2
  have hHsub : {v : ℂ | v ∈ ball z δ ∧ ((v - z) * (starRingEnd ℂ) b).re < 0} ⊆
      {w | w ∈ ball z δ ∧ 0 < curveSide z κ b w} := by
    rintro v ⟨hv1, hv2⟩
    refine ⟨hv1, ?_⟩
    have : 0 ≤ κ * Complex.normSq (v - z) := mul_nonneg hκ0 (Complex.normSq_nonneg _)
    unfold curveSide
    linarith
  refine ⟨segment ℝ w₁ w₁' ∪ {v : ℂ | v ∈ ball z δ ∧ ((v - z) * (starRingEnd ℂ) b).re < 0} ∪ segment ℝ w₂ w₂',
    union_subset (union_subset hs₁ hHsub) hs₂, Or.inl (Or.inl (left_mem_segment ℝ w₁ w₁')),
    Or.inr (left_mem_segment ℝ w₂ w₂'), ?_⟩
  exact (IsPreconnected.union w₁' (right_mem_segment ℝ w₁ w₁') hH₁ (convex_segment w₁ w₁').isPreconnected
    (MapEdge.convex_halfDisc z b δ).isPreconnected).union w₂' (Or.inr hH₂) (right_mem_segment ℝ w₂ w₂')
    (convex_segment w₂ w₂').isPreconnected

/-- The negative side is preconnected (convex), in any ball. -/
theorem isPreconnected_curveSide_neg (z : ℂ) {κ : ℝ} (hκ0 : 0 ≤ κ) (b : ℂ) (δ : ℝ) :
    IsPreconnected {w | w ∈ ball z δ ∧ curveSide z κ b w < 0} :=
  ((convex_ball z δ).inter (convex_curveSide_neg z hκ0 b)).isPreconnected

/-- The disc of radius `s ≤ ‖b‖` tangent at `z` on the side of `b` lies on the negative side, within `2s` of `z`. -/
theorem curveSide_neg_of_mem_ball {z : ℂ} {κ : ℝ} (hκ1 : κ ≤ 1) {b : ℂ} (hb : b ≠ 0) {s : ℝ} (hs0 : 0 < s)
    (hs : s ≤ ‖b‖) {w : ℂ} (hw : w ∈ ball (z + ((s / ‖b‖ : ℝ) : ℂ) * b) s) :
    curveSide z κ b w < 0 ∧ dist w z < 2 * s := by
  have hb0 : 0 < ‖b‖ := norm_pos_iff.2 hb
  set l := s / ‖b‖ with hl
  have hl0 : 0 < l := div_pos hs0 hb0
  have hl1 : l ≤ 1 := (div_le_one hb0).2 hs
  have hls : l * ‖b‖ = s := div_mul_cancel₀ s hb0.ne'
  have hc : dist (z + (l : ℂ) * b) z = s := by
    rw [dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hl0, hls]
  refine ⟨?_, by have := dist_triangle w (z + (l : ℂ) * b) z; rw [mem_ball] at hw; linarith⟩
  have hB : l ^ 2 * (b.re ^ 2 + b.im ^ 2) = s ^ 2 := by
    have h1 : ‖b‖ ^ 2 = b.re ^ 2 + b.im ^ 2 := by rw [Complex.sq_norm, Complex.normSq_apply]; ring
    rw [← h1, ← hls]; ring
  rw [MapEdge.mem_ball_iff_sq hs0] at hw
  simp only [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
    zero_mul, sub_zero, add_zero] at hw
  rw [curveSide_eq]
  set N := (w.re - z.re) ^ 2 + (w.im - z.im) ^ 2 with hN
  set R := (w.re - z.re) * b.re + (w.im - z.im) * b.im with hR
  have hN0 : 0 ≤ N := by rw [hN]; positivity
  have h1 : N < 2 * l * R := by rw [hN, hR]; nlinarith
  have hRpos : 0 < R := by
    by_contra hcon
    rw [not_lt] at hcon
    nlinarith [mul_nonneg hl0.le (neg_nonneg.2 hcon)]
  nlinarith [mul_nonneg (sub_nonneg.2 hκ1) hN0, mul_nonneg (sub_nonneg.2 hl1) hRpos.le]

/-- The disc of radius `s` tangent at `z` on the side away from `b` lies on the positive side, within `2s` of `z`. -/
theorem curveSide_pos_of_mem_ball {z : ℂ} {κ : ℝ} (hκ0 : 0 ≤ κ) {b : ℂ} (hb : b ≠ 0) {s : ℝ} (hs0 : 0 < s) {w : ℂ}
    (hw : w ∈ ball (z - ((s / ‖b‖ : ℝ) : ℂ) * b) s) : 0 < curveSide z κ b w ∧ dist w z < 2 * s := by
  have hb0 : 0 < ‖b‖ := norm_pos_iff.2 hb
  set l := s / ‖b‖ with hl
  have hl0 : 0 < l := div_pos hs0 hb0
  have hls : l * ‖b‖ = s := div_mul_cancel₀ s hb0.ne'
  have hc : dist (z - (l : ℂ) * b) z = s := by
    rw [dist_eq_norm, sub_sub_cancel_left, norm_neg, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hl0, hls]
  refine ⟨?_, by have := dist_triangle w (z - (l : ℂ) * b) z; rw [mem_ball] at hw; linarith⟩
  have hB : l ^ 2 * (b.re ^ 2 + b.im ^ 2) = s ^ 2 := by
    have h1 : ‖b‖ ^ 2 = b.re ^ 2 + b.im ^ 2 := by rw [Complex.sq_norm, Complex.normSq_apply]; ring
    rw [← h1, ← hls]; ring
  rw [MapEdge.mem_ball_iff_sq hs0] at hw
  simp only [Complex.sub_re, Complex.sub_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
    zero_mul, sub_zero, add_zero] at hw
  rw [curveSide_eq]
  set N := (w.re - z.re) ^ 2 + (w.im - z.im) ^ 2 with hN
  set R := (w.re - z.re) * b.re + (w.im - z.im) * b.im with hR
  have hN0 : 0 ≤ N := by rw [hN]; positivity
  have h1 : N + 2 * l * R < 0 := by rw [hN, hR]; nlinarith
  have hRneg : R < 0 := by
    by_contra hcon
    rw [not_lt] at hcon
    nlinarith [mul_nonneg hl0.le hcon]
  nlinarith [mul_nonneg hκ0 hN0]

/-! ## A punctured disc -/

/-- A punctured disc is preconnected (the image of `(0, ρ) × ℝ` under polar coordinates). The same statement is
`isPreconnected_ball_diff_singleton` of `Plane/ValidMap/Limit`, which is not upstream of this module. -/
theorem MapEdge.isPreconnected_puncturedBall (x : ℂ) (ρ : ℝ) : IsPreconnected (ball x ρ \ {x}) := by
  have h : ball x ρ \ {x} = (fun q : ℝ × ℝ => polarPt x q.1 q.2) '' (Ioo 0 ρ ×ˢ univ) := by
    ext w
    constructor
    · rintro ⟨hw, hne⟩
      have hpos : 0 < ‖w - x‖ := norm_pos_iff.2 (sub_ne_zero.2 hne)
      refine ⟨(‖w - x‖, arg (w - x)), ⟨⟨hpos, by rwa [mem_ball, dist_eq_norm] at hw⟩, mem_univ _⟩, ?_⟩
      show polarPt x ‖w - x‖ (arg (w - x)) = w
      rw [polarPt, ← eq_polar_arg (w - x)]
      ring
    · rintro ⟨⟨s, θ⟩, ⟨hs, -⟩, rfl⟩
      have hn : ‖polarPt x s θ - x‖ = s := by rw [norm_polarPt_sub, abs_of_pos hs.1]
      refine ⟨by rw [mem_ball, dist_eq_norm, hn]; exact hs.2, fun heq => ?_⟩
      have heq' : polarPt x s θ = x := heq
      rw [heq', sub_self, norm_zero] at hn
      exact hs.1.ne hn
  rw [h]
  exact (isPreconnected_Ioo.prod isPreconnected_univ).image _ (continuous_polarPt x).continuousOn

/-! ## Essential boundary points of the regions -/

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- A preconnected set of interior points lies in the region of the colour of any of its points. -/
theorem subset_region_of_isPreconnected {S : Set ℂ} (hS : IsPreconnected S) (hSI : S ⊆ F.interiorPts) {p : ℂ}
    (hp : p ∈ S) : S ⊆ F.region (F.col p) :=
  fun _ hw => ⟨hSI hw, hS.constant (F.continuousOn_col.mono hSI) hw hp⟩

/-- The interior points off one colour's region are an open set. -/
theorem isOpen_interiorPts_diff_region (i : Fin k) : IsOpen (F.interiorPts \ F.region i) := by
  have h : F.interiorPts \ F.region i = F.interiorPts ∩ F.col ⁻¹' {i}ᶜ := by
    ext w
    simp only [region, Set.mem_sdiff, mem_inter_iff, mem_preimage, mem_singleton_iff, mem_compl_iff]
    tauto
  rw [h]
  exact F.continuousOn_col.isOpen_inter_preimage F.isOpen_interiorPts (isOpen_discrete _)

/-- The regions of two different colours are disjoint. -/
theorem disjoint_region {j l : Fin k} (h : j ≠ l) : Disjoint (F.region j) (F.region l) :=
  Set.disjoint_left.2 fun w hj hl => h ((show F.col w = j from hj.2).symm.trans hl.2)

/-- **A point of one curve between two colours is an essential boundary point.** If the arcs meeting `ball z δ` lie
on the line or circle `curveAt z κ b` there (`δ ≤ ‖b‖`), and `z` is in the closure of `region i` and in the closure of
the interior points off `region i`, then `z` is an essential boundary point of `region i`: each side of the curve in
the ball is in one region, one side in `region i` and the other not, and each holds the disc of radius `r/4` tangent
at `z`. Inhabitant: `sq9Map` at `sqEdgePt`, with the line `re z = 1/2` (an `example` after `sq9Map_sat_model`,
`Plane/Saturated/MapColouring`). -/
theorem mem_essBoundary_region_of_curve {z : ℂ} {κ : ℝ} (hκ : κ = 0 ∨ κ = 1) {b : ℂ} (hb : b ≠ 0) {δ : ℝ} (hδ0 : 0 < δ)
    (hδ : δ ≤ ‖b‖) (hdom : ball z δ ⊆ F.dom)
    (hcurve : ∀ y ∈ ball z δ, ∀ a ∈ F.arcs, y ∈ a.carrier → y ∈ curveAt z κ b) {i : Fin k}
    (hzi : z ∈ closure (F.region i)) (hzo : z ∈ closure (F.interiorPts \ F.region i)) :
    z ∈ essBoundary (F.region i) := by
  have hκ0 : 0 ≤ κ := by rcases hκ with rfl | rfl <;> norm_num
  have hκ1 : κ ≤ 1 := by rcases hκ with rfl | rfl <;> norm_num
  have hint : ∀ w ∈ ball z δ, curveSide z κ b w ≠ 0 → w ∈ F.interiorPts := by
    intro w hw hne
    refine ⟨hdom hw, fun hmem => ?_⟩
    obtain ⟨a, ha, hwa⟩ := mem_iUnion₂.1 hmem
    exact hne (mem_curveAt_iff_curveSide.1 (hcurve w hw a ha hwa))
  have hSpI : {w | w ∈ ball z δ ∧ 0 < curveSide z κ b w} ⊆ F.interiorPts := fun w hw => hint w hw.1 hw.2.ne'
  have hSmI : {w | w ∈ ball z δ ∧ curveSide z κ b w < 0} ⊆ F.interiorPts := fun w hw => hint w hw.1 hw.2.ne
  have hSpc := isPreconnected_curveSide_pos (z := z) hκ0 hκ1 hb hδ
  have hSmc := isPreconnected_curveSide_neg z hκ0 b δ
  -- an open set with `z` in its closure has a point on one of the two sides
  have hoff : ∀ O : Set ℂ, IsOpen O → z ∈ closure O → ∃ w ∈ O,
      w ∈ {w | w ∈ ball z δ ∧ 0 < curveSide z κ b w} ∨ w ∈ {w | w ∈ ball z δ ∧ curveSide z κ b w < 0} := by
    intro O hO hz
    obtain ⟨p, hpO, hpz⟩ := Metric.mem_closure_iff.1 hz δ hδ0
    obtain ⟨w, ⟨hwO, hwb⟩, hwc⟩ := exists_notMem_curveAt (x := z) hκ hb (hO.inter isOpen_ball)
      ⟨p, hpO, by rwa [mem_ball, dist_comm]⟩
    have hne : curveSide z κ b w ≠ 0 := fun h => hwc (mem_curveAt_iff_curveSide.2 h)
    rcases lt_or_gt_of_ne hne with h | h
    · exact ⟨w, hwO, Or.inr ⟨hwb, h⟩⟩
    · exact ⟨w, hwO, Or.inl ⟨hwb, h⟩⟩
  -- each side has positive upper density at `z`
  have hposP : ∀ A : Set ℂ, {w | w ∈ ball z δ ∧ 0 < curveSide z κ b w} ⊆ A → 0 < upperDensityAt A z := by
    intro A hA
    refine upperDensityAt_pos_of_balls hδ0 fun r hr hrδ => ⟨z - ((r / 4 / ‖b‖ : ℝ) : ℂ) * b, fun w hw => ?_, ?_⟩
    · have := (curveSide_pos_of_mem_ball (κ := κ) hκ0 hb (by positivity) hw).2
      rw [mem_closedBall]; linarith
    · refine measure_mono_null (t := ∅) (fun w hw => hw.2 (hA ?_)) measure_empty
      obtain ⟨h1, h2⟩ := curveSide_pos_of_mem_ball (κ := κ) hκ0 hb (by positivity) hw.1
      exact ⟨by rw [mem_ball]; linarith, h1⟩
  have hposM : ∀ A : Set ℂ, {w | w ∈ ball z δ ∧ curveSide z κ b w < 0} ⊆ A → 0 < upperDensityAt A z := by
    intro A hA
    refine upperDensityAt_pos_of_balls hδ0 fun r hr hrδ => ⟨z + ((r / 4 / ‖b‖ : ℝ) : ℂ) * b, fun w hw => ?_, ?_⟩
    · have := (curveSide_neg_of_mem_ball (κ := κ) hκ1 hb (by positivity) (by linarith) hw).2
      rw [mem_closedBall]; linarith
    · refine measure_mono_null (t := ∅) (fun w hw => hw.2 (hA ?_)) measure_empty
      obtain ⟨h1, h2⟩ := curveSide_neg_of_mem_ball (κ := κ) hκ1 hb (by positivity) (by linarith) hw.1
      exact ⟨by rw [mem_ball]; linarith, h1⟩
  obtain ⟨p, hpi, hp⟩ := hoff _ (F.isOpen_region i) hzi
  obtain ⟨q, hqo, hq⟩ := hoff _ (F.isOpen_interiorPts_diff_region i) hzo
  have hpc : F.col p = i := hpi.2
  have hqc : F.col q ≠ i := fun h => hqo.2 ⟨hqo.1, h⟩
  have hfin : ∀ A B : Set ℂ, A ⊆ F.region i → B ⊆ F.region (F.col q) → 0 < upperDensityAt A z →
      0 < upperDensityAt B z → z ∈ essBoundary (F.region i) := by
    intro A B hA hB hdA hdB
    have mono : ∀ {S T : Set ℂ}, S ⊆ T → upperDensityAt S z ≤ upperDensityAt T z := fun {S T} hST =>
      limsup_le_limsup (Eventually.of_forall fun r => by unfold densityRatio; gcongr)
    exact ⟨lt_of_lt_of_le hdA (mono hA), MapEdge.notMem_densitySet_of_disjoint (F.isOpen_region i).measurableSet
      (F.disjoint_region (Ne.symm hqc)) (lt_of_lt_of_le hdB (mono hB))⟩
  rcases hp with hp | hp <;> rcases hq with hq | hq
  · exact absurd ((F.subset_region_of_isPreconnected hSpc hSpI hp hq).2.trans hpc) hqc
  · have h1 := F.subset_region_of_isPreconnected hSpc hSpI hp
    rw [hpc] at h1
    exact hfin _ _ h1 (F.subset_region_of_isPreconnected hSmc hSmI hq) (hposP _ subset_rfl) (hposM _ subset_rfl)
  · have h1 := F.subset_region_of_isPreconnected hSmc hSmI hp
    rw [hpc] at h1
    exact hfin _ _ h1 (F.subset_region_of_isPreconnected hSpc hSpI hq) (hposM _ subset_rfl) (hposP _ subset_rfl)
  · exact absurd ((F.subset_region_of_isPreconnected hSmc hSmI hp hq).2.trans hpc) hqc

/-- **Essential boundary points accumulate where two colours meet.** At a point `x` of the domain in the closures of the
regions of two different colours `i`, `m`, every ball about `x` holds an essential boundary point of `region i`. No
neighbourhood of `x` free of other colours is asked, and `x` itself may be a cusp of `region i`. Inhabitant: `sq9Map` at
`sqEdgePt`, colours `sqColA`, `sqColB` (an `example` after `sq9Map_sat_model`, `Plane/Saturated/MapColouring`). -/
theorem exists_mem_essBoundary_region {x : ℂ} (hx : x ∈ F.dom) {i m : Fin k} (him : i ≠ m)
    (hxi : x ∈ closure (F.region i)) (hxm : x ∈ closure (F.region m)) {ε : ℝ} (hε : 0 < ε) :
    ∃ z ∈ ball x ε, z ∈ essBoundary (F.region i) := by
  obtain ⟨ρ₀, hG⟩ := F.exists_goodAt hx
  have hρ0 : 0 < min ρ₀ ε := lt_min hG.pos hε
  have hxni : x ∉ F.region i := fun h => by
    obtain ⟨y, hy1, hy2⟩ := mem_closure_iff.1 hxm _ (F.isOpen_region i) h
    exact Set.disjoint_left.1 (F.disjoint_region him) hy1 hy2
  have hxnm : x ∉ F.region m := fun h => by
    obtain ⟨y, hy1, hy2⟩ := mem_closure_iff.1 hxi _ (F.isOpen_region m) h
    exact Set.disjoint_left.1 (F.disjoint_region him) hy2 hy1
  -- the punctured ball is connected: some `z ≠ x` in it is in both closures
  have hz : ∃ z ∈ ball x (min ρ₀ ε) \ {x}, z ∈ closure (F.region i) ∧ z ∈ closure (F.interiorPts \ F.region i) := by
    by_contra hno
    push Not at hno
    obtain ⟨p, hpi, hpx⟩ := Metric.mem_closure_iff.1 hxi _ hρ0
    obtain ⟨q, hqm, hqx⟩ := Metric.mem_closure_iff.1 hxm _ hρ0
    have hpW : p ∈ ball x (min ρ₀ ε) \ {x} :=
      ⟨by rwa [mem_ball, dist_comm], fun h => hxni (by rw [← mem_singleton_iff.1 h]; exact hpi)⟩
    have hqW : q ∈ ball x (min ρ₀ ε) \ {x} :=
      ⟨by rwa [mem_ball, dist_comm], fun h => hxnm (by rw [← mem_singleton_iff.1 h]; exact hqm)⟩
    obtain ⟨z, hzW, hzU, hzV⟩ := MapEdge.isPreconnected_puncturedBall x (min ρ₀ ε)
      (closure (F.interiorPts \ F.region i))ᶜ (closure (F.region i))ᶜ isClosed_closure.isOpen_compl
      isClosed_closure.isOpen_compl
      (fun z hz => by
        by_cases h : z ∈ closure (F.region i)
        · exact Or.inl (hno z hz h)
        · exact Or.inr h)
      ⟨p, hpW, fun h => by
        obtain ⟨y, hy1, hy2⟩ := mem_closure_iff.1 h _ (F.isOpen_region i) hpi
        exact hy2.2 hy1⟩
      ⟨q, hqW, fun h => by
        obtain ⟨y, hy1, hy2⟩ := mem_closure_iff.1 h _ (F.isOpen_region m) hqm
        exact Set.disjoint_left.1 (F.disjoint_region him) hy2 hy1⟩
    have hzd : z ∈ closure F.interiorPts :=
      F.dense_interiorPts (hG.subdom (ball_subset_ball (min_le_left _ _) hzW.1))
    have hsplit : F.interiorPts ⊆ F.region i ∪ (F.interiorPts \ F.region i) := fun w hw => by
      by_cases h : w ∈ F.region i
      · exact Or.inl h
      · exact Or.inr ⟨hw, h⟩
    have h2 := closure_mono hsplit hzd
    rw [closure_union] at h2
    rcases h2 with h | h
    · exact hzV h
    · exact hzU h
  obtain ⟨z, ⟨hzb, hzx⟩, hzi, hzo⟩ := hz
  have hzx' : z ≠ x := hzx
  have hzρ₀ : z ∈ ball x ρ₀ := ball_subset_ball (min_le_left _ _) hzb
  refine ⟨z, ball_subset_ball (min_le_right _ _) hzb, ?_⟩
  -- `z` is on an arc
  have hzI : z ∉ F.interiorPts := by
    intro hI
    have hzr : z ∈ F.region (F.col z) := ⟨hI, rfl⟩
    by_cases hc : F.col z = i
    · obtain ⟨y, hy1, hy2⟩ := mem_closure_iff.1 hzo _ (F.isOpen_region (F.col z)) hzr
      rw [hc] at hy1
      exact hy2.2 hy1
    · obtain ⟨y, hy1, hy2⟩ := mem_closure_iff.1 hzi _ (F.isOpen_region (F.col z)) hzr
      exact Set.disjoint_left.1 (F.disjoint_region hc) hy1 hy2
  have hza : ∃ a ∈ F.arcs, z ∈ a.carrier := by
    by_contra hno
    exact hzI ⟨hG.subdom hzρ₀, fun h => hno (by simpa using h)⟩
  obtain ⟨a, ha, hza⟩ := hza
  obtain ⟨δ₀, hδ₀, hsub, hcurve⟩ := hG.exists_local_curve hzρ₀ hzx' ha hza
  have hxa : x ∈ a.carrier := hG.through a ha ⟨z, hza, hzρ₀⟩
  have hκ : (a.curveData x).1 = 0 ∨ (a.curveData x).1 = 1 := Arc.curveData_kappa x a
  have hb₀ : (a.curveData x).2 ≠ 0 := Arc.curveData_ne (F.nondegenerate a ha) hxa
  have hz0 : curveSide x (a.curveData x).1 (a.curveData x).2 z = 0 :=
    mem_curveAt_iff_curveSide.1 (Arc.carrier_subset_curve hxa hza)
  have hb : (a.curveData x).2 - (((a.curveData x).1 : ℝ) : ℂ) * (z - x) ≠ 0 := by
    rw [← Complex.normSq_pos, normSq_rebase hz0]
    exact Complex.normSq_pos.2 hb₀
  refine F.mem_essBoundary_region_of_curve hκ hb (lt_min hδ₀ (norm_pos_iff.2 hb)) (min_le_right _ _)
    ((ball_subset_ball (min_le_left _ _)).trans (hsub.trans hG.subdom)) ?_ hzi hzo
  intro y hy a' ha' hya'
  have h3 := hcurve y (ball_subset_ball (min_le_left _ _) hy) a' ha' hya'
  rw [mem_curveAt_iff_curveSide, curveSide_rebase hz0]
  exact mem_curveAt_iff_curveSide.1 h3

end ArcMap

end HadwigerNelson.Plane
