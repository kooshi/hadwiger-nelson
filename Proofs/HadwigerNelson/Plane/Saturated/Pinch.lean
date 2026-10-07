import Proofs.HadwigerNelson.Plane.Saturated.Basic
import Proofs.HadwigerNelson.Plane.Diameter

/-!
# The pinch at an interface point (FS-131 wave 6)

Rows of `plans/LEAN-BACKLOG.md`, each at the class its argument reads (`plans/FS131-w6-kernel-plan.md` §§ 2, 4):

* **FS121-D3-FALLSAT** — `saturated_of_forall_isMUA`: a family of maximal unit-avoiding sets is saturated; no partition is
  read. `AeColouring.saturated_of_idomatic` is the row's own form. **Proved.**
* **FS111-M-HALF** — `half_dichotomy` (a preconnected piece of `S̃` lies in the closed unit disc about a contact or
  misses the open one; one class, no colouring; **proved**) and `half_upperDensity` (upper density at most `1/2`).
* **FS111-M-PINCH** — `pinch` (two sets on an open set `N`, any point of `N`, given contacts: split, one way or the
  other, or tangent), `pinch_not_in_in`, `pinch_interface` (every interface point of a family, where it is saturated).
* **FS111-M-C11**, clauses (i) and (iii) — `c11_discs` (every point of the one `N`), `c11_discs_interface`,
  `c11_split`. Clause (ii), the `C^{1,1}` graph, is FS131-E8-LOCAL (`Plane/Saturated/LocalGraph`).
* **FS121-V2-EROSION-DIAM** — `erosion_diam`, `erosion_diam_cot`: two straight pieces from `z` in the closure of one
  preconnected unit-distance-free set. No sector and no colouring is read. **Proved.**

**Every row above is proved; the module holds no `sorry`**: the rows marked so by the planner, and `pinch`,
`pinch_not_in_in`, `c11_discs`, `c11_split`, `half_upperDensity`, `TwoColourOn.essBoundary_inter_eq`, `sq9_isTangentAt`
by FS131-I6A (`plans/FS131-I6A-implementation.md`), with `pinch_interface` and `c11_discs_interface` over them.

**Inhabitants.** FALLSAT: `r7Cls` (`r7Cls_isMaximalCover` with `isMaximalCover_iff`, seven MUA sets). PINCH and C11:
`sq9` at `sqEdgePt` (`sq9_twoColourNhd`; saturated by `sq9_tight_saturated`), of tangent type (`sq9_isTangentAt`).
HALF: any class of `sq9` with a contact. EROSION-DIAM: an open square of side `1/2` at a corner.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

/-! ## FS121-D3-FALLSAT -/

/-- A point whose unit circle misses the support of a MUA set `A` has a ball almost everywhere inside `A`
(`IsMUA.interior_union_unitShadow`'s argument, kept at the ball: for an irregular MUA set `int (supp A)` is larger). -/
theorem IsMUA.exists_ball_ae_subset {A : Set ℂ} (hA : IsMUA A) {z : ℂ} (hz : z ∉ unitShadow (essSupport A)) :
    ∃ δ > 0, (ball z δ : Set ℂ) ≤ᵐ[volume] A := by
  obtain ⟨hAm, hAn, hmax⟩ := hA
  have hnone : ∀ y ∈ essSupport A, dist z y ≠ 1 := fun y hy h => hz ⟨y, hy, h⟩
  obtain ⟨δ, hδ0, hδ, hann⟩ := exists_annulus_subset_compl (isClosed_essSupport A) hnone
  set B : Set ℂ := ball z δ with hB
  have hN : volume (A \ essSupport A) = 0 := volume_diff_essSupport A
  have h1 : (volume.prod arcLength) {q : ℂ × ℝ | q.1 ∈ A \ essSupport A} = 0 := by
    have : {q : ℂ × ℝ | q.1 ∈ A \ essSupport A} = (A \ essSupport A) ×ˢ univ := by ext q; simp
    rw [this, Measure.prod_prod, hN, zero_mul]
  have h2 := volume_prod_shift_null hN
  have hA' : UnitPairsNull (A ∪ B) := by
    refine measure_mono_null (t := unitPairSet A ∪ {q : ℂ × ℝ | q.1 ∈ A \ essSupport A} ∪
      {q : ℂ × ℝ | q.1 + e q.2 ∈ A \ essSupport A}) ?_ (measure_union_null (measure_union_null hAn h1) h2)
    rintro ⟨x, θ⟩ ⟨hx, hxe⟩
    simp only [unitPairSet] at hx hxe ⊢
    have hnorm : dist x (x + e θ) = 1 := by rw [dist_eq_norm, sub_add_cancel_left, norm_neg, norm_e]
    rcases hx with hx | hx <;> rcases hxe with hxe | hxe
    · exact Or.inl (Or.inl ⟨hx, hxe⟩)
    · -- `x ∈ A`, `x + e θ ∈ B`: `x` lies in the annulus about `z`
      refine Or.inl (Or.inr ⟨hx, fun hF => hann x ?_ hF⟩)
      rw [mem_ball] at hxe
      have t1 := dist_triangle x (x + e θ) z
      have t2 := dist_triangle x z (x + e θ)
      rw [dist_comm z (x + e θ)] at t2
      rw [abs_sub_lt_iff]; constructor <;> linarith
    · refine Or.inr ⟨hxe, fun hF => hann (x + e θ) ?_ hF⟩
      rw [mem_ball] at hx
      have t1 := dist_triangle (x + e θ) x z
      have t2 := dist_triangle x z (x + e θ)
      rw [dist_comm (x + e θ) x] at t1
      rw [dist_comm z (x + e θ)] at t2
      rw [abs_sub_lt_iff]; constructor <;> linarith
    · exfalso
      rw [mem_ball] at hx hxe
      have t1 := dist_triangle x z (x + e θ)
      rw [dist_comm z (x + e θ)] at t1
      linarith
  have hle : A ≤ᵐ[volume] (A ∪ B : Set ℂ) := Eventually.of_forall fun x hx => Or.inl hx
  have hBA : (A ∪ B : Set ℂ) ≤ᵐ[volume] A := hmax (A ∪ B) (hAm.union measurableSet_ball) hA' hle
  have hB : (B : Set ℂ) ≤ᵐ[volume] (A ∪ B : Set ℂ) := Eventually.of_forall fun x hx => Or.inr hx
  exact ⟨δ, hδ0, Filter.EventuallyLE.trans hB hBA⟩

/-- **FS121-D3-FALLSAT**, at the class its argument reads: every family of maximal unit-avoiding sets is saturated —
each essential boundary point of each class is a contact point of that class. The row's partition is not read. -/
theorem saturated_of_forall_isMUA {C : Fin k → Set ℂ} (h : ∀ j, IsMUA (C j)) : Saturated C := by
  intro j x hx
  by_contra hc
  have hz : x ∉ unitShadow (essSupport (C j)) := by
    rintro ⟨y, hy, hxy⟩
    exact hc ⟨y, by rwa [← essSupport_eq_closure_densitySet], hxy⟩
  obtain ⟨δ, hδ, hsub⟩ := (h j).exists_ball_ae_subset hz
  exact hx.2 (subset_densitySet_of_isOpen_ae_subset isOpen_ball hsub (mem_ball_self hδ))

/-- **FS121-D3-FALLSAT**, the row's form: a colouring whose classes are each maximal among measurable sets with null
unit pairs (a measurable idomatic partition) is saturated; honest and a.e.-proper are the type. -/
theorem AeColouring.saturated_of_idomatic (c : AeColouring k) (h : ∀ j, IsMUA (c.cls j)) : Saturated c.cls :=
  saturated_of_forall_isMUA h

/-- Inhabitant of FALLSAT's hypothesis: R7's seven classes are MUA sets, so the theorem gives `r7Cls_saturated` again. -/
example : Saturated r7Cls :=
  saturated_of_forall_isMUA ((isMaximalCover_iff fun j => (r7Cls_isMaximalCover.1.1 j).1).1 r7Cls_isMaximalCover).1

/-! ## FS111-M-HALF -/

/-- **FS111-M-HALF**, the dichotomy (FS111-M-PINCH's Step 1): for one measurable set `A` with null unit pairs and a point
`y` of `supp A`, a preconnected piece `P` of the density set lies in the closed unit disc about `y` or misses the open
one. With `|x − y| = 1` these are the two half-planes of every blow-up at `x`. -/
theorem half_dichotomy {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {y : ℂ}
    (hy : y ∈ closure (densitySet A)) {P : Set ℂ} (hP : IsPreconnected P) (hPA : P ⊆ densitySet A) :
    P ⊆ closedBall y 1 ∨ Disjoint P (ball y 1) := by
  by_contra hcon
  rw [not_or] at hcon
  obtain ⟨hout, hin⟩ := hcon
  obtain ⟨p, hpP, hp⟩ := Set.not_subset.mp hout
  obtain ⟨p', hp'P, hp'⟩ := Set.not_disjoint_iff.mp hin
  rw [mem_closedBall, not_le] at hp
  rw [mem_ball] at hp'
  obtain ⟨q, hq, hqy⟩ := Metric.mem_closure_iff.mp hy (min (dist p y - 1) (1 - dist p' y))
    (lt_min (by linarith) (by linarith))
  have h1 : dist y q < dist p y - 1 := lt_of_lt_of_le hqy (min_le_left _ _)
  have h2 : dist y q < 1 - dist p' y := lt_of_lt_of_le hqy (min_le_right _ _)
  rcases hullset hA hnull hP hPA (upperDensityAt_pos_of_mem_densitySet hq) with h | h
  · have := h p hpP
    have t := dist_triangle p q y
    rw [dist_comm q p] at this
    rw [dist_comm q y] at t
    linarith
  · have := h p' hp'P
    have t := dist_triangle q y p'
    rw [dist_comm q y, dist_comm y p'] at t
    linarith

/-! ### HALF's half-plane, before the blow-up (FS131-I6A) -/

/-- **FS111-M-HALF**, "a closed half-plane in every blow-up", facing an inner contact: a point `z` of the closed unit
disc about `y`, seen from a point `x` of its circle, has `|z − x|² / 2 ≤ ⟨z − x, y − x⟩`. -/
theorem half_sq_norm_le_inner_of_mem_closedBall {x y z : ℂ} (hxy : dist x y = 1) (hz : z ∈ closedBall y 1) :
    ‖z - x‖ ^ 2 / 2 ≤ inner ℝ (z - x) (y - x) := by
  have hu : ‖y - x‖ = 1 := by rw [← dist_eq_norm, dist_comm]; exact hxy
  have h1 : ‖z - x - (y - x)‖ ≤ 1 := by
    have := mem_closedBall.1 hz
    rwa [dist_eq_norm, show z - y = z - x - (y - x) by ring] at this
  have h2 := norm_sub_sq_real (z - x) (y - x)
  have h3 : ‖z - x - (y - x)‖ ^ 2 ≤ 1 := pow_le_one₀ (norm_nonneg _) h1
  rw [hu] at h2
  linarith

/-- **FS111-M-HALF**, "a closed half-plane in every blow-up", facing away from an outer contact: a point `z` outside the
open unit disc about `y`, seen from a point `x` of its circle, has `⟨z − x, y − x⟩ ≤ |z − x|² / 2`. -/
theorem inner_le_half_sq_norm_of_notMem_ball {x y z : ℂ} (hxy : dist x y = 1) (hz : z ∉ ball y 1) :
    inner ℝ (z - x) (y - x) ≤ ‖z - x‖ ^ 2 / 2 := by
  have hu : ‖y - x‖ = 1 := by rw [← dist_eq_norm, dist_comm]; exact hxy
  have h1 : 1 ≤ ‖z - x - (y - x)‖ := by
    rwa [mem_ball, not_lt, dist_eq_norm, show z - y = z - x - (y - x) by ring] at hz
  have h2 := norm_sub_sq_real (z - x) (y - x)
  have h3 : 1 ≤ ‖z - x - (y - x)‖ ^ 2 := one_le_pow₀ h1
  rw [hu] at h2
  linarith

/-! ### HALF's density clause: half a disc, by the reflection in its centre (FS131-I6A) -/

/-- The part of a closed disc strictly behind its centre `x`, in the direction `ν`, is at most half the disc: the
reflection `z ↦ 2x − z` preserves area and the disc, and moves that part off itself. -/
theorem volume_halfPlane_inter_closedBall_le (x ν : ℂ) (R : ℝ) :
    volume ({z : ℂ | inner ℝ (z - x) ν < 0} ∩ closedBall x R) ≤ volume (closedBall x R) / 2 := by
  set H : Set ℂ := {z : ℂ | inner ℝ (z - x) ν < 0} ∩ closedBall x R with hH
  have hmeas : MeasurableSet H :=
    (isOpen_lt (by fun_prop) continuous_const).measurableSet.inter measurableSet_closedBall
  have hrefl : ∀ z : ℂ, x + x - z - x = -(z - x) := fun z => by ring
  have hvol : volume ((fun z => x + x - z) ⁻¹' H) = volume H :=
    (Measure.measurePreserving_sub_left volume (x + x)).measure_preimage hmeas.nullMeasurableSet
  have hdisj : Disjoint H ((fun z => x + x - z) ⁻¹' H) := by
    rw [Set.disjoint_left]
    rintro z ⟨hz, -⟩ ⟨hz', -⟩
    simp only [mem_setOf_eq] at hz hz'
    rw [hrefl, inner_neg_left] at hz'
    linarith
  have hsub : H ∪ (fun z => x + x - z) ⁻¹' H ⊆ closedBall x R := by
    refine union_subset inter_subset_right fun z hz => ?_
    have h2 := hz.2
    rw [mem_closedBall, dist_eq_norm] at h2 ⊢
    rwa [hrefl, norm_neg] at h2
  have h2 : volume H + volume H ≤ volume (closedBall x R) := by
    have := measure_union (μ := volume) hdisj ((Measure.measurePreserving_sub_left volume (x + x)).measurable hmeas)
    rw [hvol] at this
    rw [← this]
    exact measure_mono hsub
  rw [ENNReal.le_div_iff_mul_le (Or.inl two_ne_zero) (Or.inl ENNReal.ofNat_ne_top), mul_two]
  exact h2

/-- The part of the closed disc `B̄(x, r)` behind the line at signed distance `s ≥ 0` in the unit direction `ν` is at
most half of `B̄(x, r + s)` (translate by `−s ν`). -/
theorem volume_shifted_halfPlane_inter_closedBall_le {x ν : ℂ} (hν : ‖ν‖ = 1) {s : ℝ} (hs : 0 ≤ s) (r : ℝ) :
    volume ({z : ℂ | inner ℝ (z - x) ν < s} ∩ closedBall x r) ≤ volume (closedBall x (r + s)) / 2 := by
  refine le_trans ?_ (volume_halfPlane_inter_closedBall_le x ν (r + s))
  rw [← measure_preimage_add_right volume (-(s : ℂ) * ν) ({z : ℂ | inner ℝ (z - x) ν < 0} ∩ closedBall x (r + s))]
  refine measure_mono ?_
  rintro z ⟨hz, hzb⟩
  constructor
  · show inner ℝ (z + -(s : ℂ) * ν - x) ν < 0
    have e : z + -(s : ℂ) * ν - x = (z - x) - s • ν := by rw [Complex.real_smul]; ring
    rw [e, inner_sub_left, real_inner_smul_left, real_inner_self_eq_norm_sq, hν]
    simp only [mem_setOf_eq] at hz
    linarith
  · rw [mem_closedBall] at hzb ⊢
    have h1 : dist (z + -(s : ℂ) * ν) z = s := by
      rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_neg, Complex.norm_real, hν, mul_one, Real.norm_of_nonneg hs]
    linarith [dist_triangle (z + -(s : ℂ) * ν) z x]

/-- A set whose part in `B̄(x, r)` lies behind the line at distance `r²` in a unit direction has density ratio at most
`(1 + r)² / 2` at `x`, radius `r`. -/
theorem densityRatio_le_of_subset_halfPlane {P : Set ℂ} {x ν : ℂ} (hν : ‖ν‖ = 1) {r : ℝ} (hr : 0 < r)
    (h : P ∩ closedBall x r ⊆ {z : ℂ | inner ℝ (z - x) ν < r ^ 2}) :
    densityRatio P x r ≤ ENNReal.ofReal ((1 + r) ^ 2 / 2) := by
  have hsub : P ∩ closedBall x r ⊆ {z : ℂ | inner ℝ (z - x) ν < r ^ 2} ∩ closedBall x r := fun z hz => ⟨h hz, hz.2⟩
  have h1 : volume (P ∩ closedBall x r) ≤ volume (closedBall x (r + r ^ 2)) / 2 :=
    (measure_mono hsub).trans (volume_shifted_halfPlane_inter_closedBall_le hν (sq_nonneg r) r)
  have h2 : volume (closedBall x (r + r ^ 2)) / 2 = ENNReal.ofReal ((1 + r) ^ 2 / 2) * volume (closedBall x r) := by
    rw [volume_closedBall_ofReal _ (by positivity), volume_closedBall_ofReal _ hr.le,
      ← ENNReal.ofReal_mul (by positivity), ← ENNReal.ofReal_ofNat 2, ← ENNReal.ofReal_div_of_pos (by norm_num)]
    congr 1; ring
  rw [densityRatio]
  exact ENNReal.div_le_of_le_mul (h1.trans_eq h2)

/-- `(1 + r)² / 2 → 1/2` as `r → 0⁺`, in `ENNReal`. -/
theorem tendsto_ofReal_one_add_sq_div_two :
    Tendsto (fun r : ℝ => ENNReal.ofReal ((1 + r) ^ 2 / 2)) (𝓝[>] 0) (𝓝 (1 / 2)) := by
  have h0 : Tendsto (fun r : ℝ => (1 + r) ^ 2 / 2) (𝓝 0) (𝓝 ((1 + 0) ^ 2 / 2)) :=
    Continuous.tendsto (by fun_prop) 0
  have h1 := ENNReal.tendsto_ofReal (h0.mono_left (nhdsWithin_le_nhds (s := Ioi (0 : ℝ))))
  have e : ENNReal.ofReal ((1 + 0) ^ 2 / 2) = 1 / 2 := by
    rw [ENNReal.ofReal_div_of_pos (by norm_num)]; simp
  rwa [e] at h1

/-- **FS111-M-HALF**, the density form: at a point `x` with a contact `y` (`|x − y| = 1`, `y ∈ supp A`), every
preconnected piece of the density set has upper density at most `1/2` at `x` — no colour takes a reflex angle at a
saturated point.
Inhabitant of the hypotheses, all at once: the class `sqColA` of `sq9` at `sqEdgePt`, the contact `sqEdgePt + 1`
(`sq9_isTangentAt`), `P` the class's open part in `B(sqEdgePt, 1/8)` (`sq9_twoColourNhd`): the `example` under "The models". -/
theorem half_upperDensity {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {x y : ℂ}
    (hy : y ∈ closure (densitySet A)) (hxy : dist x y = 1) {P : Set ℂ} (hP : IsPreconnected P)
    (hPA : P ⊆ densitySet A) : upperDensityAt P x ≤ 1 / 2 := by
  have hu : ‖y - x‖ = 1 := by rw [← dist_eq_norm, dist_comm]; exact hxy
  -- a unit direction `ν` behind whose parabola-thin neighbourhood of the tangent line the piece lies
  obtain ⟨ν, hν, hside⟩ : ∃ ν : ℂ, ‖ν‖ = 1 ∧ ∀ z ∈ P, inner ℝ (z - x) ν ≤ ‖z - x‖ ^ 2 / 2 := by
    rcases half_dichotomy hA hnull hy hP hPA with hin | hout
    · refine ⟨-(y - x), by rwa [norm_neg], fun z hz => ?_⟩
      have h1 := half_sq_norm_le_inner_of_mem_closedBall hxy (hin hz)
      rw [inner_neg_right]
      linarith [sq_nonneg ‖z - x‖]
    · exact ⟨y - x, hu, fun z hz => inner_le_half_sq_norm_of_notMem_ball hxy (Set.disjoint_left.1 hout hz)⟩
  have hbound : ∀ᶠ r in 𝓝[>] (0 : ℝ), densityRatio P x r ≤ ENNReal.ofReal ((1 + r) ^ 2 / 2) := by
    filter_upwards [self_mem_nhdsWithin] with r hr
    have hr0 : 0 < r := hr
    refine densityRatio_le_of_subset_halfPlane hν hr0 fun z hz => ?_
    have h1 := hside z hz.1
    have h2 : ‖z - x‖ ≤ r := by rw [← dist_eq_norm]; exact mem_closedBall.1 hz.2
    have h3 : ‖z - x‖ ^ 2 ≤ r ^ 2 := pow_le_pow_left₀ (norm_nonneg _) h2 2
    show inner ℝ (z - x) ν < r ^ 2
    nlinarith [sq_pos_of_pos hr0]
  calc upperDensityAt P x ≤ limsup (fun r : ℝ => ENNReal.ofReal ((1 + r) ^ 2 / 2)) (𝓝[>] 0) :=
        limsup_le_limsup hbound
    _ = 1 / 2 := tendsto_ofReal_one_add_sq_div_two.limsup_eq

/-! ## FS111-M-PINCH -/

/-- `sq9` at the edge point is of tangent type: beyond `sq9_hasTwoDiscsAt`, the contacts `sqEdgePt ± 1` lie in the
supports of the two squares' colours (the squares one unit to the right and to the left). -/
theorem sq9_isTangentAt :
    IsTangentAt (sq9.cls sqColA) (sq9.cls sqColB) (ball sqEdgePt (1 / 8)) sqEdgePt 1 := by
  refine ⟨sq9_hasTwoDiscsAt, ?_, ?_⟩
  · have h : sqEdgePt + 1 ∈ sq9Sq 3 0 := by
      refine ⟨?_, ?_, ?_, ?_⟩ <;> simp [sqEdgePt] <;> norm_num
    have hc : finProdFinEquiv (((3 : ℤ) : ZMod 3), ((0 : ℤ) : ZMod 3)) = sqColA := by decide
    have := essClosure_subset_essSupport _ (sq9Sq_subset_essClosure 3 0 h)
    rwa [hc] at this
  · have h : sqEdgePt - 1 ∈ sq9Sq (-2) 0 := by
      refine ⟨?_, ?_, ?_, ?_⟩ <;> simp [sqEdgePt] <;> norm_num
    have hc : finProdFinEquiv (((-2 : ℤ) : ZMod 3), ((0 : ℤ) : ZMod 3)) = sqColB := by decide
    have := essClosure_subset_essSupport _ (sq9Sq_subset_essClosure (-2) 0 h)
    rwa [hc] at this

/-! ### The pinch's geometry: one identity for the four cells (FS131-I6A) -/

/-- **The identity all four cells of the pinch read**: for a unit `u`, a direction `w` and a real `t`,
`‖t w − u‖² = 1 − 2 t ⟨w, u⟩ + t² ‖w‖²`. -/
theorem norm_sq_mul_sub_of_norm_eq_one {u : ℂ} (hu : ‖u‖ = 1) (w : ℂ) (t : ℝ) :
    ‖(t : ℂ) * w - u‖ ^ 2 = 1 - 2 * t * inner ℝ w u + t ^ 2 * ‖w‖ ^ 2 := by
  rw [← Complex.real_smul, norm_sub_sq_real, norm_smul, real_inner_smul_left, hu, Real.norm_eq_abs, mul_pow, sq_abs]
  ring

/-- Moving from a point `x` of the unit circle about `y` along a direction `w` with `‖w‖² ≤ 2 ⟨w, y − x⟩` and
`⟨w, y − x⟩ > 0` enters the open unit disc: `x + t w ∈ B(y, 1)` for `0 < t < 1`. -/
theorem dist_add_mul_lt_one {x y w : ℂ} (hxy : dist x y = 1) (hw : ‖w‖ ^ 2 ≤ 2 * inner ℝ w (y - x))
    (hpos : 0 < inner ℝ w (y - x)) {t : ℝ} (ht0 : 0 < t) (ht1 : t < 1) : dist (x + (t : ℂ) * w) y < 1 := by
  have hu : ‖y - x‖ = 1 := by rw [← dist_eq_norm, dist_comm]; exact hxy
  have h := norm_sq_mul_sub_of_norm_eq_one hu w t
  have he : x + (t : ℂ) * w - y = (t : ℂ) * w - (y - x) := by ring
  rw [dist_eq_norm, he]
  have hlt : ‖(t : ℂ) * w - (y - x)‖ ^ 2 < 1 := by
    rw [h]; nlinarith [mul_pos ht0 hpos, mul_pos (mul_pos ht0 hpos) (sub_pos.2 ht1), sq_nonneg t]
  have h0 := norm_nonneg ((t : ℂ) * w - (y - x))
  nlinarith

/-- Moving from a point `x` of the unit circle about `y` along a non-zero direction `w` with `⟨w, y − x⟩ ≤ 0` leaves the
closed unit disc: `1 < |x + t w − y|` for `t > 0`. -/
theorem one_lt_dist_add_mul {x y w : ℂ} (hxy : dist x y = 1) (hw : w ≠ 0) (hle : inner ℝ w (y - x) ≤ 0) {t : ℝ}
    (ht0 : 0 < t) : 1 < dist (x + (t : ℂ) * w) y := by
  have hu : ‖y - x‖ = 1 := by rw [← dist_eq_norm, dist_comm]; exact hxy
  have h := norm_sq_mul_sub_of_norm_eq_one hu w t
  have he : x + (t : ℂ) * w - y = (t : ℂ) * w - (y - x) := by ring
  rw [dist_eq_norm, he]
  have hwpos : 0 < ‖w‖ ^ 2 := by positivity
  have hlt : 1 < ‖(t : ℂ) * w - (y - x)‖ ^ 2 := by
    rw [h]; nlinarith [mul_nonneg ht0.le (neg_nonneg.2 hle), mul_pos (sq_pos_of_pos ht0) hwpos]
  have h0 := norm_nonneg ((t : ℂ) * w - (y - x))
  nlinarith

/-- From a point of an open set one can move a little along any direction and stay in the set: some `t ∈ (0, 1)`. -/
theorem exists_add_mul_mem_of_isOpen {N : Set ℂ} (hN : IsOpen N) {x : ℂ} (hx : x ∈ N) (w : ℂ) :
    ∃ t : ℝ, 0 < t ∧ t < 1 ∧ x + (t : ℂ) * w ∈ N := by
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.1 hN x hx
  have hden : 0 < 2 * (‖w‖ + 1) := by positivity
  refine ⟨min (1 / 2) (ε / (2 * (‖w‖ + 1))), lt_min (by norm_num) (div_pos hε hden),
    lt_of_le_of_lt (min_le_left _ _) (by norm_num), hball ?_⟩
  set t := min (1 / 2) (ε / (2 * (‖w‖ + 1))) with ht
  have ht0 : 0 < t := lt_min (by norm_num) (div_pos hε hden)
  have ht2 : t ≤ ε / (2 * (‖w‖ + 1)) := min_le_right _ _
  rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_of_nonneg ht0.le]
  rw [le_div_iff₀ hden] at ht2
  nlinarith [norm_nonneg w]

/-- For unit vectors `u ≠ v`, `⟨u, v⟩ < 1`. -/
theorem real_inner_lt_one_of_ne {u v : ℂ} (hu : ‖u‖ = 1) (hv : ‖v‖ = 1) (h : u ≠ v) : inner ℝ u v < 1 := by
  have h1 := norm_sub_sq_real u v
  have h2 : 0 < ‖u - v‖ ^ 2 := by
    have : u - v ≠ 0 := sub_ne_zero.2 h
    positivity
  rw [hu, hv] at h1
  nlinarith

/-- For unit vectors with `u ≠ −v`, `−1 < ⟨u, v⟩`. -/
theorem neg_one_lt_real_inner_of_ne_neg {u v : ℂ} (hu : ‖u‖ = 1) (hv : ‖v‖ = 1) (h : u ≠ -v) : -1 < inner ℝ u v := by
  have := real_inner_lt_one_of_ne hu (by rwa [norm_neg] : ‖-v‖ = 1) h
  rw [inner_neg_right] at this
  linarith

/-- **An open set almost everywhere inside a closed set is inside it** (the difference is open and null). -/
theorem subset_of_isOpen_ae_le_isClosed {U F : Set ℂ} (hU : IsOpen U) (hF : IsClosed F) (h : U ≤ᵐ[volume] F) : U ⊆ F := by
  have h0 : volume (U \ F) = 0 := ae_le_set.1 h
  have h1 : U \ F = ∅ := ((hU.sdiff hF).measure_eq_zero_iff volume).1 h0
  exact sdiff_eq_empty.1 h1

/-- **FS111-M-PINCH**, "the case (in, in) is impossible", at the class its argument reads: if an open set `N` is
almost everywhere `A ∪ B`, no point `x` of `N` on the unit circles about `ya` and `yb` has `A` and `B` both, within
`N`, in the closed unit discs about them. Neither (H2), nor almost-disjointness, nor measurability is read.
A refutation; its hypotheses without the last are met by `sq9` at `sqEdgePt` (`sq9_twoColourNhd`, with
`ya = sqEdgePt + 1`, `yb = sqEdgePt - 1`), where the last fails. -/
theorem pinch_not_in_in {A B N : Set ℂ} (hN : IsOpen N) (hcover : (N : Set ℂ) ≤ᵐ[volume] (A ∪ B : Set ℂ))
    {x ya yb : ℂ} (hx : x ∈ N) (hxa : dist x ya = 1) (hxb : dist x yb = 1)
    (hin : (A ∩ N : Set ℂ) ≤ᵐ[volume] closedBall ya 1 ∧ (B ∩ N : Set ℂ) ≤ᵐ[volume] closedBall yb 1) : False := by
  have hsub : N ⊆ closedBall ya 1 ∪ closedBall yb 1 := by
    refine subset_of_isOpen_ae_le_isClosed hN (isClosed_closedBall.union isClosed_closedBall) ?_
    filter_upwards [hcover, hin.1, hin.2] with z hz ha hb hzN
    rcases hz hzN with h | h
    · exact Or.inl (ha ⟨h, hzN⟩)
    · exact Or.inr (hb ⟨h, hzN⟩)
  have hu : ‖ya - x‖ = 1 := by rw [← dist_eq_norm, dist_comm]; exact hxa
  have hv : ‖yb - x‖ = 1 := by rw [← dist_eq_norm, dist_comm]; exact hxb
  -- a direction leaving both closed discs: `−(u + v)`, or `i u` when `v = −u`
  obtain ⟨w, hw0, hwa, hwb⟩ : ∃ w : ℂ, w ≠ 0 ∧ inner ℝ w (ya - x) ≤ 0 ∧ inner ℝ w (yb - x) ≤ 0 := by
    by_cases hs : (ya - x) + (yb - x) = 0
    · have hvu : yb - x = -(ya - x) := (neg_eq_of_add_eq_zero_right hs).symm
      have h0 : inner ℝ (I * (ya - x)) (ya - x) = 0 := by
        rw [Complex.inner]; simp only [map_mul, conj_I, mul_re, mul_im, neg_re, neg_im, I_re, I_im, conj_re, conj_im]; ring
      refine ⟨I * (ya - x), mul_ne_zero I_ne_zero (norm_ne_zero_iff.1 (by rw [hu]; norm_num)), h0.le, ?_⟩
      rw [hvu, inner_neg_right, h0, neg_zero]
    · have hc := neg_one_le_real_inner_of_norm_eq_one hu hv
      refine ⟨-((ya - x) + (yb - x)), neg_ne_zero.2 hs, ?_, ?_⟩
      · rw [inner_neg_left, inner_add_left, real_inner_self_eq_norm_sq, hu, real_inner_comm]; linarith
      · rw [inner_neg_left, inner_add_left, real_inner_self_eq_norm_sq, hv]; linarith
  obtain ⟨t, ht0, -, htN⟩ := exists_add_mul_mem_of_isOpen hN hx w
  have h1 := one_lt_dist_add_mul hxa hw0 hwa ht0
  have h2 := one_lt_dist_add_mul hxb hw0 hwb ht0
  rcases hsub htN with h | h <;> rw [mem_closedBall] at h <;> linarith

/-- **FS111-M-PINCH, the cell (in, out)**, at the class it reads: if an open set `N` is almost everywhere `A ∪ B`, and
within `N` the set `A` lies in the closed unit disc about `ya` and `B` misses the open unit disc about `yb`, then at a
point `x` of `N` on both unit circles the centres agree and `x` is of split type, `A` inside. Neither (H2), nor
almost-disjointness, nor measurability is read. -/
theorem isSplitAt_of_in_out {A B N : Set ℂ} (hN : IsOpen N) (hcover : (N : Set ℂ) ≤ᵐ[volume] (A ∪ B : Set ℂ))
    {x ya yb : ℂ} (hx : x ∈ N) (hxa : dist x ya = 1) (hxb : dist x yb = 1)
    (ha : (A ∩ N : Set ℂ) ≤ᵐ[volume] closedBall ya 1) (hb : (B ∩ N : Set ℂ) ≤ᵐ[volume] (ball yb 1)ᶜ) :
    ya = yb ∧ IsSplitAt A B N x ya := by
  have h1 : (ball yb 1 ∩ N : Set ℂ) ≤ᵐ[volume] A := by
    filter_upwards [hcover, hb] with z hz hbz hzb
    rcases hz hzb.2 with h | h
    · exact h
    · exact absurd hzb.1 (hbz ⟨h, hzb.2⟩)
  have h2 : ball yb 1 ∩ N ⊆ closedBall ya 1 := by
    refine subset_of_isOpen_ae_le_isClosed (isOpen_ball.inter hN) isClosed_closedBall ?_
    filter_upwards [h1, ha] with z hz haz hzb using haz ⟨hz hzb, hzb.2⟩
  have heq : ya = yb := by
    by_contra hne
    have hu : ‖ya - x‖ = 1 := by rw [← dist_eq_norm, dist_comm]; exact hxa
    have hv : ‖yb - x‖ = 1 := by rw [← dist_eq_norm, dist_comm]; exact hxb
    have huv : ya - x ≠ yb - x := fun h => hne (sub_left_injective h)
    have hc := real_inner_lt_one_of_ne hu hv huv
    have hnorm := norm_sub_sq_real (yb - x) (ya - x)
    rw [hu, hv, real_inner_comm] at hnorm
    obtain ⟨t, ht0, ht1, htN⟩ := exists_add_mul_mem_of_isOpen hN hx ((yb - x) - (ya - x))
    have hin : dist (x + (t : ℂ) * ((yb - x) - (ya - x))) yb < 1 := by
      refine dist_add_mul_lt_one hxb ?_ ?_ ht0 ht1
      · rw [inner_sub_left, real_inner_self_eq_norm_sq, hv, hnorm]; linarith
      · rw [inner_sub_left, real_inner_self_eq_norm_sq, hv]; linarith
    have hout : 1 < dist (x + (t : ℂ) * ((yb - x) - (ya - x))) ya := by
      refine one_lt_dist_add_mul hxa (sub_ne_zero.2 huv.symm) ?_ ht0
      rw [inner_sub_left, real_inner_self_eq_norm_sq, hu, real_inner_comm]; linarith
    have := h2 ⟨mem_ball.2 hin, htN⟩
    rw [mem_closedBall] at this
    linarith
  subst heq
  have hsph : ∀ᵐ z ∂(volume : Measure ℂ), z ∉ sphere ya 1 :=
    measure_eq_zero_iff_ae_notMem.1 (Measure.addHaar_sphere volume ya 1)
  refine ⟨rfl, hxa, Filter.EventuallyLE.antisymm ?_ ?_, Filter.EventuallyLE.antisymm ?_ ?_⟩
  · filter_upwards [ha, hsph] with z hz hzs hzA
    exact ⟨mem_ball.2 (lt_of_le_of_ne (mem_closedBall.1 (hz hzA)) fun h => hzs (mem_sphere.2 h)), hzA.2⟩
  · filter_upwards [h1] with z hz hzb using ⟨hz hzb, hzb.2⟩
  · filter_upwards [hb, hsph] with z hz hzs hzB
    refine ⟨hzB.2, fun hc => ?_⟩
    rcases (mem_closedBall.1 hc).lt_or_eq with h | h
    · exact hz hzB (mem_ball.2 h)
    · exact hzs (mem_sphere.2 h)
  · filter_upwards [hcover, ha] with z hz haz hzN
    rcases hz hzN.1 with h | h
    · exact absurd (haz ⟨h, hzN.1⟩) hzN.2
    · exact ⟨h, hzN.1⟩

/-- **FS111-M-PINCH, the cell (out, out)**, at the class it reads: if an open set `N` is almost everywhere `A ∪ B`, the
two sets are almost disjoint in `N`, and within `N` each misses the open unit disc about its own contact, then at a point
`x` of `N` on both unit circles the contacts are antipodal and the two open unit discs lie, within `N`, each in the other
set. Neither (H2) nor measurability is read; almost-disjointness is (two overlapping sets may fill a lens). -/
theorem hasTwoDiscsAt_of_out_out {A B N : Set ℂ} (hN : IsOpen N) (hcover : (N : Set ℂ) ≤ᵐ[volume] (A ∪ B : Set ℂ))
    (hdisj : volume (A ∩ B ∩ N) = 0) {x ya yb : ℂ} (hx : x ∈ N) (hxa : dist x ya = 1) (hxb : dist x yb = 1)
    (ha : (A ∩ N : Set ℂ) ≤ᵐ[volume] (ball ya 1)ᶜ) (hb : (B ∩ N : Set ℂ) ≤ᵐ[volume] (ball yb 1)ᶜ) :
    yb - x = -(ya - x) ∧ HasTwoDiscsAt A B N x (ya - x) := by
  have hu : ‖ya - x‖ = 1 := by rw [← dist_eq_norm, dist_comm]; exact hxa
  have hv : ‖yb - x‖ = 1 := by rw [← dist_eq_norm, dist_comm]; exact hxb
  have h1 : (ball ya 1 ∩ N : Set ℂ) ≤ᵐ[volume] B := by
    filter_upwards [hcover, ha] with z hz haz hzb
    rcases hz hzb.2 with h | h
    · exact absurd hzb.1 (haz ⟨h, hzb.2⟩)
    · exact h
  have h2 : (ball yb 1 ∩ N : Set ℂ) ≤ᵐ[volume] A := by
    filter_upwards [hcover, hb] with z hz hbz hzb
    rcases hz hzb.2 with h | h
    · exact h
    · exact absurd hzb.1 (hbz ⟨h, hzb.2⟩)
  have h3 : ball ya 1 ∩ ball yb 1 ∩ N = ∅ := by
    refine (((isOpen_ball.inter isOpen_ball).inter hN).measure_eq_zero_iff volume).1 ?_
    refine nonpos_iff_eq_zero.1 ((measure_mono_ae ?_).trans_eq hdisj)
    filter_upwards [h1, h2] with z hz1 hz2 hz
    exact ⟨⟨hz2 ⟨hz.1.2, hz.2⟩, hz1 ⟨hz.1.1, hz.2⟩⟩, hz.2⟩
  have hneg : yb - x = -(ya - x) := by
    by_contra hne
    have hne' : ya - x ≠ -(yb - x) := fun h => hne (by rw [h, neg_neg])
    have hc := neg_one_lt_real_inner_of_ne_neg hu hv hne'
    have hnorm : ‖(ya - x) + (yb - x)‖ ^ 2 = 2 + 2 * inner ℝ (ya - x) (yb - x) := by
      rw [norm_add_sq_real, hu, hv]; ring
    obtain ⟨t, ht0, ht1, htN⟩ := exists_add_mul_mem_of_isOpen hN hx ((ya - x) + (yb - x))
    have hina : dist (x + (t : ℂ) * ((ya - x) + (yb - x))) ya < 1 := by
      refine dist_add_mul_lt_one hxa ?_ ?_ ht0 ht1
      · rw [inner_add_left, real_inner_self_eq_norm_sq, hu, hnorm, real_inner_comm]; linarith
      · rw [inner_add_left, real_inner_self_eq_norm_sq, hu, real_inner_comm]; linarith
    have hinb : dist (x + (t : ℂ) * ((ya - x) + (yb - x))) yb < 1 := by
      refine dist_add_mul_lt_one hxb ?_ ?_ ht0 ht1
      · rw [inner_add_left, real_inner_self_eq_norm_sq, hv, hnorm]; linarith
      · rw [inner_add_left, real_inner_self_eq_norm_sq, hv]; linarith
    have hmem : x + (t : ℂ) * ((ya - x) + (yb - x)) ∈ ball ya 1 ∩ ball yb 1 ∩ N :=
      ⟨⟨mem_ball.2 hina, mem_ball.2 hinb⟩, htN⟩
    rw [h3] at hmem
    exact hmem
  have hyb : x - (ya - x) = yb := by linear_combination -hneg
  refine ⟨hneg, hu, ?_, ?_⟩
  · rw [add_sub_cancel]; exact h1
  · rw [hyb]; exact h2

/-- **FS111-M-PINCH**, at the class its argument reads: two measurable sets `A`, `B` with null unit pairs, an open set
`N` on which they satisfy the row's hypotheses (`TwoColourOn`: (H1) as "cover and almost disjoint", (H2) for each), a
point `x` of `N` — any point, `N` is not centred at it — and contacts `ya` of `A`, `yb` of `B` (points of the supports
at distance exactly `1`; no density of the partner is asked). Either `ya = yb` and `N` is split by the unit circle
about it, `A` inside and `B` outside or the reverse, or the contacts are antipodal and `x` is of tangent type with
normal `ya − x` into `B`. No colouring, no third class and no family is read.
Inhabitant of the hypotheses, all at once: `sq9` at `sqEdgePt` with the contacts `sqEdgePt ± 1` (`sq9_twoColourNhd`,
`sq9_isTangentAt`): the `example` under "The models". -/
theorem pinch {A B N : Set ℂ} (hA : MeasurableSet A) (hAn : UnitPairsNull A) (hB : MeasurableSet B)
    (hBn : UnitPairsNull B) (h : TwoColourOn A B N) {x ya yb : ℂ} (hx : x ∈ N)
    (hya : ya ∈ essSupport A) (hxa : dist x ya = 1) (hyb : yb ∈ essSupport B) (hxb : dist x yb = 1) :
    (ya = yb ∧ (IsSplitAt A B N x ya ∨ IsSplitAt B A N x ya)) ∨
      (yb - x = -(ya - x) ∧ IsTangentAt A B N x (ya - x)) := by
  obtain ⟨Pa, -, hPac, hPaA, hAPa⟩ := h.h2a
  obtain ⟨Pb, -, hPbc, hPbB, hBPb⟩ := h.h2b
  have hya' : ya ∈ closure (densitySet A) := by rwa [← essSupport_eq_closure_densitySet]
  have hyb' : yb ∈ closure (densitySet B) := by rwa [← essSupport_eq_closure_densitySet]
  -- Step 1: each set, within `N`, is on one side of the unit circle about its contact
  have inA : Pa ⊆ closedBall ya 1 → (A ∩ N : Set ℂ) ≤ᵐ[volume] closedBall ya 1 := fun hs =>
    hAPa.le.trans (Eventually.of_forall hs)
  have inB : Pb ⊆ closedBall yb 1 → (B ∩ N : Set ℂ) ≤ᵐ[volume] closedBall yb 1 := fun hs =>
    hBPb.le.trans (Eventually.of_forall hs)
  have outA : Disjoint Pa (ball ya 1) → (A ∩ N : Set ℂ) ≤ᵐ[volume] (ball ya 1)ᶜ := fun hd =>
    hAPa.le.trans (Eventually.of_forall fun z hz hzb => Set.disjoint_left.1 hd hz hzb)
  have outB : Disjoint Pb (ball yb 1) → (B ∩ N : Set ℂ) ≤ᵐ[volume] (ball yb 1)ᶜ := fun hd =>
    hBPb.le.trans (Eventually.of_forall fun z hz hzb => Set.disjoint_left.1 hd hz hzb)
  have hcover' : (N : Set ℂ) ≤ᵐ[volume] (B ∪ A : Set ℂ) := by rw [union_comm]; exact h.cover
  -- Step 2: the 2 × 2 table
  rcases half_dichotomy hA hAn hya' hPac.isPreconnected hPaA with ha | ha <;>
    rcases half_dichotomy hB hBn hyb' hPbc.isPreconnected hPbB with hb | hb
  · exact (pinch_not_in_in h.isOpen h.cover hx hxa hxb ⟨inA ha, inB hb⟩).elim
  · obtain ⟨he, hs⟩ := isSplitAt_of_in_out h.isOpen h.cover hx hxa hxb (inA ha) (outB hb)
    exact Or.inl ⟨he, Or.inl hs⟩
  · obtain ⟨he, hs⟩ := isSplitAt_of_in_out h.isOpen hcover' hx hxb hxa (inB hb) (outA ha)
    exact Or.inl ⟨he.symm, Or.inr (he ▸ hs)⟩
  · obtain ⟨hneg, hd⟩ := hasTwoDiscsAt_of_out_out h.isOpen h.cover h.disj hx hxa hxb (outA ha) (outB hb)
    refine Or.inr ⟨hneg, hd, ?_, ?_⟩
    · rw [add_sub_cancel]; exact hya
    · have hyb'' : x - (ya - x) = yb := by linear_combination -hneg
      rw [hyb'']; exact hyb

/-- In an open set that is almost everywhere `A ∪ B`, with `A ∩ B` null in it, the density ratios of `A` and `B` on a
closed ball inside the set sum to `1`. -/
theorem densityRatio_add_of_cover {A B N : Set ℂ} (hA : MeasurableSet A) (hcover : (N : Set ℂ) ≤ᵐ[volume] (A ∪ B : Set ℂ))
    (hdisj : volume (A ∩ B ∩ N) = 0) {x : ℂ} {r : ℝ} (hr : 0 < r) (hsub : closedBall x r ⊆ N) :
    densityRatio A x r + densityRatio B x r = 1 := by
  have hB0 : volume (closedBall x r) ≠ 0 := (measure_closedBall_pos volume x hr).ne'
  have hB' : volume (closedBall x r) ≠ ⊤ := measure_closedBall_lt_top.ne
  rw [densityRatio, densityRatio, ← ENNReal.add_div]
  have h1 := measure_union_add_inter (μ := volume) (B ∩ closedBall x r) (hA.inter (measurableSet_closedBall (x := x) (ε := r)))
  have h2 : volume (B ∩ closedBall x r ∩ (A ∩ closedBall x r)) = 0 :=
    measure_mono_null (t := A ∩ B ∩ N) (fun z hz => ⟨⟨hz.2.1, hz.1.1⟩, hsub hz.1.2⟩) hdisj
  have h3 : volume (B ∩ closedBall x r ∪ A ∩ closedBall x r) = volume (closedBall x r) := by
    refine le_antisymm (measure_mono (union_subset inter_subset_right inter_subset_right)) (measure_mono_ae ?_)
    filter_upwards [hcover] with z hz hzb
    rcases hz (hsub hzb) with h | h
    · exact Or.inr ⟨h, hzb⟩
    · exact Or.inl ⟨h, hzb⟩
  rw [add_comm, ← h1, h2, add_zero, h3, ENNReal.div_self hB0 hB']

/-- One inclusion of `TwoColourOn.essBoundary_inter_eq`: only `A` is asked to be measurable. -/
theorem TwoColourOn.essBoundary_inter_subset {A B N : Set ℂ} (hA : MeasurableSet A) (h : TwoColourOn A B N) :
    essBoundary A ∩ N ⊆ essBoundary B := by
  rintro x ⟨⟨hxc, hxd⟩, hxN⟩
  obtain ⟨r₀, hr₀, hball⟩ := Metric.isOpen_iff.1 h.isOpen x hxN
  have hsum : ∀ᶠ r in 𝓝[>] (0 : ℝ), densityRatio A x r + densityRatio B x r = 1 := by
    filter_upwards [Ioo_mem_nhdsGT hr₀] with r hr
    exact densityRatio_add_of_cover hA h.cover h.disj hr.1 ((closedBall_subset_ball hr.2).trans hball)
  constructor
  · -- were `B` of density `0` at `x`, `A` would have density `1`
    by_contra hnc
    have h1 := ENNReal.Tendsto.sub (tendsto_const_nhds (x := (1 : ENNReal)))
      (tendsto_densityRatio_of_notMem_essClosure hnc) (Or.inl ENNReal.one_ne_top)
    rw [tsub_zero] at h1
    refine hxd (h1.congr' ?_)
    filter_upwards [hsum] with r hs
    have hne : densityRatio B x r ≠ ⊤ := by
      intro htop; rw [htop, add_top] at hs; exact ENNReal.top_ne_one hs
    exact (ENNReal.eq_sub_of_add_eq hne hs).symm
  · -- were `B` of density `1` at `x`, `A` would have density `0`
    intro hxB
    have h1 := ENNReal.Tendsto.sub (tendsto_const_nhds (x := (1 : ENNReal))) hxB (Or.inl ENNReal.one_ne_top)
    rw [tsub_self] at h1
    have hA0 : Tendsto (densityRatio A x) (𝓝[>] 0) (𝓝 0) := by
      refine h1.congr' ?_
      filter_upwards [hsum] with r hs
      have hne : densityRatio B x r ≠ ⊤ := by
        intro htop; rw [htop, add_top] at hs; exact ENNReal.top_ne_one hs
      exact (ENNReal.eq_sub_of_add_eq hne hs).symm
    exact (ne_of_gt hxc) hA0.limsup_eq

/-- In a two-colour open set the two sets have the same essential boundary: where one is neither of density `1` nor
of density `0`, so is the other (the density ratios of `A` and `B` sum to `1` in small balls). -/
theorem TwoColourOn.essBoundary_inter_eq {A B N : Set ℂ} (hA : MeasurableSet A) (hB : MeasurableSet B)
    (h : TwoColourOn A B N) : essBoundary A ∩ N = essBoundary B ∩ N :=
  Subset.antisymm (fun _ hx => ⟨h.essBoundary_inter_subset hA hx, hx.2⟩)
    (fun _ hx => ⟨h.symm.essBoundary_inter_subset hB hx, hx.2⟩)

/-- In a two-colour neighbourhood of a family, an essential boundary point of the family is an essential boundary
point of both classes (a third class is null near it). With `cl P = supp` inside `N` this is the frozen (H2)'s clause
`x ∈ cl P_a ∩ cl P_b`. -/
theorem TwoColourNhd.mem_essBoundary {C : Fin k → Set ℂ} (hm : ∀ j, MeasurableSet (C j)) {N : Set ℂ} {a b : Fin k}
    (h : TwoColourNhd C N a b) {x : ℂ} (hx : x ∈ N) (hxb : x ∈ essBdry C) :
    x ∈ essBoundary (C a) ∧ x ∈ essBoundary (C b) := by
  obtain ⟨j, hj⟩ := mem_iUnion.1 hxb
  have key := h.two.essBoundary_inter_eq (hm a) (hm b)
  by_cases hja : j = a
  · subst hja
    exact ⟨hj, (key.subset ⟨hj, hx⟩).1⟩
  · by_cases hjb : j = b
    · subst hjb
      exact ⟨(key.superset ⟨hj, hx⟩).1, hj⟩
    · exfalso
      obtain ⟨r, hr, hsub⟩ := Metric.isOpen_iff.1 h.two.isOpen x hx
      have h0 : ∀ s, 0 < s → s ≤ r / 2 → volume (C j ∩ closedBall x s) = 0 := fun s _ hs =>
        measure_mono_null (inter_subset_inter_right _ ((closedBall_subset_ball (by linarith)).trans hsub))
          (h.h1 j hja hjb)
      exact (ne_of_gt hj.1) (upperDensityAt_eq_zero_of_null (half_pos hr) h0)

/-- **FS111-M-PINCH** at the points it is used, for a family (a colouring's classes: `c.cls`, with
`c.isAeCover.1`): at an interface point where the family is saturated, some ball centred there is a two-colour
neighbourhood in which the point is of split type (`a` inside) or of tangent type. -/
theorem pinch_interface {C : Fin k → Set ℂ} (hC : IsAdmissible C) {U : Set ℂ} (hsat : SaturatedOn C U) {x : ℂ}
    (hxU : x ∈ U) (hx : x ∈ interfaceSet C) :
    ∃ ρ a b, TwoColourNhd C (ball x ρ) a b ∧
      ((∃ y, IsSplitAt (C a) (C b) (ball x ρ) x y) ∨ ∃ ν, IsTangentAt (C a) (C b) (ball x ρ) x ν) := by
  obtain ⟨ρ, a, b, h⟩ := exists_twoColourNhd_of_mem_interfaceSet hx
  have hxN : x ∈ ball x ρ := mem_ball_self h.radius_pos
  obtain ⟨hxa, hxb⟩ := h.mem_essBoundary (fun j => (hC j).1) hxN hx.1
  obtain ⟨ya, hya, hda⟩ := hsat a x ⟨hxa, hxU⟩
  obtain ⟨yb, hyb, hdb⟩ := hsat b x ⟨hxb, hxU⟩
  rw [← essSupport_eq_closure_densitySet] at hya hyb
  rcases pinch (hC a).1 (hC a).2 (hC b).1 (hC b).2 h.two hxN hya hda hyb hdb with ⟨rfl, hs | hs⟩ | ⟨-, ht⟩
  · exact ⟨ρ, a, b, h, Or.inl ⟨ya, hs⟩⟩
  · exact ⟨ρ, b, a, h.symm, Or.inl ⟨ya, hs⟩⟩
  · exact ⟨ρ, a, b, h, Or.inr ⟨_, ht⟩⟩

/-! ## FS111-M-C11, clauses (i) and (iii) -/

/-- A point of split type carries the two tangent unit discs, with the normal `x − y` pointing away from the centre. -/
theorem IsSplitAt.hasTwoDiscsAt {A B N : Set ℂ} {x y : ℂ} (h : IsSplitAt A B N x y) : HasTwoDiscsAt A B N x (x - y) := by
  obtain ⟨hxy, hA, hB⟩ := h
  refine ⟨by rw [← dist_eq_norm]; exact hxy, ?_, ?_⟩
  · have hsub : ball (x + (x - y)) 1 ∩ N ⊆ N \ closedBall y 1 := by
      rintro z ⟨hz, hzN⟩
      refine ⟨hzN, fun hc => ?_⟩
      rw [mem_ball] at hz
      rw [mem_closedBall] at hc
      have h2 : dist (x + (x - y)) y = 2 := by
        rw [dist_eq_norm, show x + (x - y) - y = (2 : ℂ) * (x - y) by ring, norm_mul, ← dist_eq_norm, hxy]
        simp
      have := dist_triangle (x + (x - y)) z y
      rw [dist_comm (x + (x - y)) z] at this
      linarith
    filter_upwards [hB.symm.le] with z hz hzb using (hz (hsub hzb)).1
  · rw [sub_sub_cancel]
    filter_upwards [hA.symm.le] with z hz hzb using (hz hzb).1

/-- **FS111-M-C11 (i)**, at the class its argument reads: in a two-colour open set `N`, every point of `N` with a
contact of `A` and a contact of `B` — every point, with the one `N` — carries two open unit discs tangent there from
opposite sides, one in each set (within `N`, up to null sets): at the split type as at the tangent type. (At a point
of `N` off the common essential boundary the two contacts cannot both exist.) -/
theorem c11_discs {A B N : Set ℂ} (hA : MeasurableSet A) (hAn : UnitPairsNull A) (hB : MeasurableSet B)
    (hBn : UnitPairsNull B) (h : TwoColourOn A B N) {x : ℂ} (hx : x ∈ N) (hcA : IsContactFor A x)
    (hcB : IsContactFor B x) : ∃ ν, HasTwoDiscsAt A B N x ν := by
  obtain ⟨ya, hya, hxa⟩ := hcA
  obtain ⟨yb, hyb, hxb⟩ := hcB
  rw [← essSupport_eq_closure_densitySet] at hya hyb
  rcases pinch hA hAn hB hBn h hx hya hxa hyb hxb with ⟨-, hs | hs⟩ | ⟨-, ht⟩
  · exact ⟨x - ya, hs.hasTwoDiscsAt⟩
  · exact ⟨-(x - ya), hasTwoDiscsAt_comm.2 (by rw [neg_neg]; exact hs.hasTwoDiscsAt)⟩
  · exact ⟨_, ht.1⟩

/-- **FS111-M-C11 (i)** at an interface point of a family saturated there: a two-colour ball centred at the point,
and the two tangent unit discs in it. -/
theorem c11_discs_interface {C : Fin k → Set ℂ} (hC : IsAdmissible C) {U : Set ℂ} (hsat : SaturatedOn C U) {x : ℂ}
    (hxU : x ∈ U) (hx : x ∈ interfaceSet C) :
    ∃ ρ a b ν, TwoColourNhd C (ball x ρ) a b ∧ HasTwoDiscsAt (C a) (C b) (ball x ρ) x ν := by
  obtain ⟨ρ, a, b, h⟩ := exists_twoColourNhd_of_mem_interfaceSet hx
  have hxN : x ∈ ball x ρ := mem_ball_self h.radius_pos
  obtain ⟨hxa, hxb⟩ := h.mem_essBoundary (fun j => (hC j).1) hxN hx.1
  obtain ⟨ν, hν⟩ := c11_discs (hC a).1 (hC a).2 (hC b).1 (hC b).2 h.two hxN (hsat a x ⟨hxa, hxU⟩)
    (hsat b x ⟨hxb, hxU⟩)
  exact ⟨ρ, a, b, ν, h, hν⟩

/-! ### C11 (iii): the essential boundary of a disc, and of a set that is a disc within an open set (FS131-I6A) -/

/-- Within an open set `N`, the density ratios at a point of `N` read a set only up to a null set of `N`. -/
theorem densityRatio_eventuallyEq_of_ae_eq_inter {A S N : Set ℂ} (hN : IsOpen N)
    (h : (A ∩ N : Set ℂ) =ᵐ[volume] (S ∩ N : Set ℂ)) {z : ℂ} (hz : z ∈ N) :
    densityRatio A z =ᶠ[𝓝[>] 0] densityRatio S z := by
  obtain ⟨r₀, hr₀, hball⟩ := Metric.isOpen_iff.1 hN z hz
  filter_upwards [Ioo_mem_nhdsGT hr₀] with r hr
  have hsub : closedBall z r ⊆ N := (closedBall_subset_ball hr.2).trans hball
  have e : ∀ T : Set ℂ, T ∩ closedBall z r = T ∩ N ∩ closedBall z r := fun T => by
    ext w; exact ⟨fun hw => ⟨⟨hw.1, hsub hw.2⟩, hw.2⟩, fun hw => ⟨hw.1.1, hw.2⟩⟩
  rw [densityRatio, densityRatio, e A, e S, measure_congr (h.inter (ae_eq_refl _))]

/-- Within an open set `N`, the essential boundary reads a set only up to a null set of `N`. -/
theorem essBoundary_inter_congr {A S N : Set ℂ} (hN : IsOpen N) (h : (A ∩ N : Set ℂ) =ᵐ[volume] (S ∩ N : Set ℂ)) :
    essBoundary A ∩ N = essBoundary S ∩ N := by
  ext z
  simp only [mem_inter_iff]
  refine and_congr_left fun hz => ?_
  have he := densityRatio_eventuallyEq_of_ae_eq_inter hN h hz
  have h1 : upperDensityAt A z = upperDensityAt S z := limsup_congr he
  have h2 : z ∈ densitySet A ↔ z ∈ densitySet S := tendsto_congr' he
  show (0 < upperDensityAt A z ∧ z ∉ densitySet A) ↔ (0 < upperDensityAt S z ∧ z ∉ densitySet S)
  rw [h1, h2]

/-- A point at which a measurable set and its complement each contain, at every small scale `r`, a ball of radius `r/4`
within distance `r` is an essential boundary point of the set. -/
theorem mem_essBoundary_of_balls {S : Set ℂ} (hS : MeasurableSet S) {z : ℂ} {r₀ : ℝ} (hr₀ : 0 < r₀)
    (h1 : ∀ r, 0 < r → r < r₀ → ∃ c, ball c (r / 4) ⊆ closedBall z r ∧ volume (ball c (r / 4) \ S) = 0)
    (h2 : ∀ r, 0 < r → r < r₀ → ∃ c, ball c (r / 4) ⊆ closedBall z r ∧ volume (ball c (r / 4) \ Sᶜ) = 0) :
    z ∈ essBoundary S := by
  refine ⟨upperDensityAt_pos_of_balls hr₀ h1, fun hd => ?_⟩
  have h0 : upperDensityAt Sᶜ z = 0 := (tendsto_densityRatio_compl_of_mem hS hd).limsup_eq
  exact (ne_of_gt (upperDensityAt_pos_of_balls hr₀ h2)) h0

/-- At a point `z` of the unit circle about `y`, the ball of radius `r/4` about the point `r/2` towards `y` lies within
`r` of `z` and inside the open unit disc. -/
theorem exists_ball_subset_ball_of_mem_sphere {y z : ℂ} (hz : dist z y = 1) {r : ℝ} (hr : 0 < r) (hr1 : r < 1) :
    ∃ c, ball c (r / 4) ⊆ closedBall z r ∧ ball c (r / 4) ⊆ ball y 1 := by
  have hn : ‖y - z‖ = 1 := by rw [← dist_eq_norm, dist_comm]; exact hz
  have hcz : dist (z + ((r / 2 : ℝ) : ℂ) * (y - z)) z = r / 2 := by
    rw [dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, hn, mul_one, Real.norm_of_nonneg (by linarith)]
  have hcy : dist (z + ((r / 2 : ℝ) : ℂ) * (y - z)) y = 1 - r / 2 := by
    have e : z + ((r / 2 : ℝ) : ℂ) * (y - z) - y = ((r / 2 - 1 : ℝ) : ℂ) * (y - z) := by push_cast; ring
    rw [dist_eq_norm, e, norm_mul, Complex.norm_real, hn, mul_one, Real.norm_eq_abs, abs_of_neg (by linarith)]
    ring
  refine ⟨z + ((r / 2 : ℝ) : ℂ) * (y - z), fun w hw => ?_, fun w hw => ?_⟩ <;> rw [mem_ball] at hw
  · rw [mem_closedBall]; linarith [dist_triangle w (z + ((r / 2 : ℝ) : ℂ) * (y - z)) z]
  · rw [mem_ball]; linarith [dist_triangle w (z + ((r / 2 : ℝ) : ℂ) * (y - z)) y]

/-- At a point `z` of the unit circle about `y`, the ball of radius `r/4` about the point `r/2` away from `y` lies within
`r` of `z` and outside the closed unit disc. -/
theorem exists_ball_subset_compl_closedBall_of_mem_sphere {y z : ℂ} (hz : dist z y = 1) {r : ℝ} (hr : 0 < r) :
    ∃ c, ball c (r / 4) ⊆ closedBall z r ∧ ball c (r / 4) ⊆ (closedBall y 1)ᶜ := by
  have hn : ‖y - z‖ = 1 := by rw [← dist_eq_norm, dist_comm]; exact hz
  have hcz : dist (z - ((r / 2 : ℝ) : ℂ) * (y - z)) z = r / 2 := by
    rw [dist_eq_norm, sub_sub_cancel_left, norm_neg, norm_mul, Complex.norm_real, hn, mul_one,
      Real.norm_of_nonneg (by linarith)]
  have hcy : dist (z - ((r / 2 : ℝ) : ℂ) * (y - z)) y = 1 + r / 2 := by
    have e : z - ((r / 2 : ℝ) : ℂ) * (y - z) - y = ((-(1 + r / 2) : ℝ) : ℂ) * (y - z) := by push_cast; ring
    rw [dist_eq_norm, e, norm_mul, Complex.norm_real, hn, mul_one, Real.norm_eq_abs, abs_neg, abs_of_pos (by linarith)]
  refine ⟨z - ((r / 2 : ℝ) : ℂ) * (y - z), fun w hw => ?_, fun w hw hc => ?_⟩ <;> rw [mem_ball] at hw
  · rw [mem_closedBall]; linarith [dist_triangle w (z - ((r / 2 : ℝ) : ℂ) * (y - z)) z]
  · rw [mem_closedBall] at hc
    have := dist_triangle (z - ((r / 2 : ℝ) : ℂ) * (y - z)) w y
    rw [dist_comm (z - ((r / 2 : ℝ) : ℂ) * (y - z)) w] at this
    linarith

/-- The essential boundary of the open unit disc is the unit circle. -/
theorem essBoundary_ball_one (y : ℂ) : essBoundary (ball y 1) = sphere y 1 := by
  ext z
  rw [mem_sphere]
  constructor
  · intro hz
    rcases lt_trichotomy (dist z y) 1 with h | h | h
    · exact absurd (subset_densitySet_of_isOpen_ae_subset isOpen_ball (Eventually.of_forall fun _ hw => hw)
        (mem_ball.2 h)) hz.2
    · exact h
    · exfalso
      refine (ne_of_gt hz.1) (upperDensityAt_eq_zero_of_null (r₀ := (dist z y - 1) / 2) (by linarith) fun r _ hr => ?_)
      refine measure_mono_null (t := ∅) (fun w hw => ?_) measure_empty
      have h1 := mem_ball.1 hw.1
      have h2 := mem_closedBall.1 hw.2
      have := dist_triangle z w y
      rw [dist_comm z w] at this
      linarith
  · intro hz
    refine mem_essBoundary_of_balls measurableSet_ball one_pos (fun r hr hr1 => ?_) (fun r hr _ => ?_)
    · obtain ⟨c, h1, h2⟩ := exists_ball_subset_ball_of_mem_sphere hz hr hr1
      exact ⟨c, h1, by rw [sdiff_eq_empty.2 h2, measure_empty]⟩
    · obtain ⟨c, h1, h2⟩ := exists_ball_subset_compl_closedBall_of_mem_sphere hz hr
      refine ⟨c, h1, ?_⟩
      rw [sdiff_eq_empty.2 (h2.trans (compl_subset_compl.2 ball_subset_closedBall)), measure_empty]

/-- The essential boundary of the complement of the closed unit disc is the unit circle. -/
theorem essBoundary_compl_closedBall_one (y : ℂ) : essBoundary (closedBall y 1)ᶜ = sphere y 1 := by
  ext z
  rw [mem_sphere]
  constructor
  · intro hz
    rcases lt_trichotomy (dist z y) 1 with h | h | h
    · exfalso
      refine (ne_of_gt hz.1) (upperDensityAt_eq_zero_of_null (r₀ := (1 - dist z y) / 2) (by linarith) fun r _ hr => ?_)
      refine measure_mono_null (t := ∅) (fun w hw => ?_) measure_empty
      have h1 : ¬ dist w y ≤ 1 := fun hc => hw.1 (mem_closedBall.2 hc)
      have h2 := mem_closedBall.1 hw.2
      have := dist_triangle w z y
      exact h1 (by linarith)
    · exact h
    · exact absurd (subset_densitySet_of_isOpen_ae_subset isClosed_closedBall.isOpen_compl
        (Eventually.of_forall fun _ hw => hw) (fun hc => absurd (mem_closedBall.1 hc) (not_le.2 h))) hz.2
  · intro hz
    refine mem_essBoundary_of_balls isClosed_closedBall.measurableSet.compl one_pos (fun r hr _ => ?_)
      (fun r hr hr1 => ?_)
    · obtain ⟨c, h1, h2⟩ := exists_ball_subset_compl_closedBall_of_mem_sphere hz hr
      exact ⟨c, h1, by rw [sdiff_eq_empty.2 h2, measure_empty]⟩
    · obtain ⟨c, h1, h2⟩ := exists_ball_subset_ball_of_mem_sphere hz hr hr1
      refine ⟨c, h1, ?_⟩
      rw [compl_compl, sdiff_eq_empty.2 (h2.trans ball_subset_closedBall), measure_empty]

/-- **FS111-M-C11 (iii).** If some point is of split type in the open set `N` about `y`, the essential boundary of
each of the two sets in `N` is the arc of the unit circle about `y`. -/
theorem c11_split {A B N : Set ℂ} (hN : IsOpen N) {x y : ℂ} (h : IsSplitAt A B N x y) :
    essBoundary A ∩ N = sphere y 1 ∩ N ∧ essBoundary B ∩ N = sphere y 1 ∩ N := by
  obtain ⟨-, hA, hB⟩ := h
  have hB' : (B ∩ N : Set ℂ) =ᵐ[volume] ((closedBall y 1)ᶜ ∩ N : Set ℂ) := by
    rwa [inter_comm (closedBall y 1)ᶜ N, ← sdiff_eq]
  exact ⟨by rw [essBoundary_inter_congr hN hA, essBoundary_ball_one],
    by rw [essBoundary_inter_congr hN hB', essBoundary_compl_closedBall_one]⟩

/-! ### The models (FS131-I6A): `sq9` at `sqEdgePt` for HALF, PINCH and C11 (i); a disc and its exterior for the split type -/

/-- The contacts of the model: `sqEdgePt ± 1` are at distance `1` from `sqEdgePt`. -/
theorem dist_sqEdgePt_add_one : dist sqEdgePt (sqEdgePt + 1) = 1 ∧ dist sqEdgePt (sqEdgePt - 1) = 1 := by
  constructor <;> simp [dist_eq_norm]

/-- **Inhabitant of `pinch`'s hypotheses, all at once**: `sq9`'s two classes in `B(sqEdgePt, 1/8)`, the point `sqEdgePt`,
the contacts `sqEdgePt ± 1`. (There the theorem's second disjunct holds: `sq9_isTangentAt`.) -/
example :
    (sqEdgePt + 1 = sqEdgePt - 1 ∧
        (IsSplitAt (sq9.cls sqColA) (sq9.cls sqColB) (ball sqEdgePt (1 / 8)) sqEdgePt (sqEdgePt + 1) ∨
          IsSplitAt (sq9.cls sqColB) (sq9.cls sqColA) (ball sqEdgePt (1 / 8)) sqEdgePt (sqEdgePt + 1))) ∨
      (sqEdgePt - 1 - sqEdgePt = -(sqEdgePt + 1 - sqEdgePt) ∧
        IsTangentAt (sq9.cls sqColA) (sq9.cls sqColB) (ball sqEdgePt (1 / 8)) sqEdgePt (sqEdgePt + 1 - sqEdgePt)) :=
  pinch (sq9.measurableSet_cls _) (sq9.unitPairsNull _) (sq9.measurableSet_cls _) (sq9.unitPairsNull _)
    sq9_twoColourNhd.two sqEdgePt_mem_ball sq9_isTangentAt.2.1 dist_sqEdgePt_add_one.1 sq9_isTangentAt.2.2
    dist_sqEdgePt_add_one.2

/-- **Inhabitant of `half_upperDensity`'s hypotheses, all at once**: the class `sqColA` of `sq9`, the point `sqEdgePt`,
the contact `sqEdgePt + 1`, and for `P` the class's connected open part in `B(sqEdgePt, 1/8)` — a non-empty piece. -/
example : ∃ P : Set ℂ, P.Nonempty ∧ upperDensityAt P sqEdgePt ≤ 1 / 2 := by
  obtain ⟨P, -, hPc, hPA, -⟩ := sq9_twoColourNhd.two.h2a
  exact ⟨P, hPc.nonempty, half_upperDensity (sq9.measurableSet_cls sqColA) (sq9.unitPairsNull sqColA)
    (by rw [← essSupport_eq_closure_densitySet]; exact sq9_isTangentAt.2.1) dist_sqEdgePt_add_one.1
    hPc.isPreconnected hPA⟩

/-- **Inhabitant of `c11_discs`'s hypotheses, all at once**: the same model, the contacts as `IsContactFor`. -/
example : ∃ ν, HasTwoDiscsAt (sq9.cls sqColA) (sq9.cls sqColB) (ball sqEdgePt (1 / 8)) sqEdgePt ν :=
  c11_discs (sq9.measurableSet_cls _) (sq9.unitPairsNull _) (sq9.measurableSet_cls _) (sq9.unitPairsNull _)
    sq9_twoColourNhd.two sqEdgePt_mem_ball
    ⟨sqEdgePt + 1, by rw [← essSupport_eq_closure_densitySet]; exact sq9_isTangentAt.2.1, dist_sqEdgePt_add_one.1⟩
    ⟨sqEdgePt - 1, by rw [← essSupport_eq_closure_densitySet]; exact sq9_isTangentAt.2.2, dist_sqEdgePt_add_one.2⟩

/-- **Inhabitant of `TwoColourOn.essBoundary_inter_eq`'s hypotheses**: the same two classes on the same ball. -/
example : essBoundary (sq9.cls sqColA) ∩ ball sqEdgePt (1 / 8) = essBoundary (sq9.cls sqColB) ∩ ball sqEdgePt (1 / 8) :=
  sq9_twoColourNhd.two.essBoundary_inter_eq (sq9.measurableSet_cls _) (sq9.measurableSet_cls _)

/-- **Model of the split type**: the open unit disc and the complement of the closed one, on the whole plane, at the
point `1` of the circle. -/
theorem isSplitAt_ball_compl_closedBall :
    IsSplitAt (ball (0 : ℂ) 1) (closedBall (0 : ℂ) 1)ᶜ univ 1 0 := by
  have e : ((closedBall (0 : ℂ) 1)ᶜ ∩ univ : Set ℂ) = univ \ closedBall 0 1 := by
    rw [inter_univ, compl_eq_univ_sdiff]
  refine ⟨by simp, ae_eq_refl _, ?_⟩
  rw [e]

/-- **Inhabitant of `c11_split`'s hypotheses**: the disc and its exterior; each has the unit circle as essential
boundary. (`sq9` is no model here: its edge point is of tangent type.) -/
example : essBoundary (ball (0 : ℂ) 1) ∩ univ = sphere 0 1 ∩ univ ∧
    essBoundary (closedBall (0 : ℂ) 1)ᶜ ∩ univ = sphere 0 1 ∩ univ :=
  c11_split isOpen_univ isSplitAt_ball_compl_closedBall

/-- Spec for `IsSplitAt.hasTwoDiscsAt`: at the point `1` of the split model the normal is `1 − 0`, away from the centre. -/
example : HasTwoDiscsAt (ball (0 : ℂ) 1) (closedBall (0 : ℂ) 1)ᶜ univ 1 (1 - 0) :=
  isSplitAt_ball_compl_closedBall.hasTwoDiscsAt

/-! ## FS121-V2-EROSION-DIAM -/

/-- Two points of the closure of a preconnected set with no two points at distance `1` are at distance at most `1`. -/
theorem dist_le_one_of_mem_closure {D : Set ℂ} (hD : IsPreconnected D) (hfree : ∀ p ∈ D, ∀ q ∈ D, dist p q ≠ 1)
    {p q : ℂ} (hp : p ∈ closure D) (hq : q ∈ closure D) : dist p q ≤ 1 := by
  have hlt := dist_lt_one_of_forall_dist_ne_one hD hfree
  have h1 : (p, q) ∈ closure (D ×ˢ D) := by rw [closure_prod_eq]; exact ⟨hp, hq⟩
  have h2 : IsClosed {w : ℂ × ℂ | dist w.1 w.2 ≤ 1} :=
    isClosed_le (continuous_fst.dist continuous_snd) continuous_const
  exact closure_minimal (fun w hw => (hlt w.1 hw.1 w.2 hw.2).le) h2 h1

/-- **FS121-V2-EROSION-DIAM**, at the class its argument reads: if the straight pieces `[z, z + L₁ e α]` and
`[z, z + L₂ e β]`, at an angle `θ = β − α ∈ (0, π)`, end in the closure of one preconnected set with no two points at
distance `1` (a component of a colour, in any a.e.-proper colouring), then `min(L₁, L₂) ≤ 1 / (2 sin (θ/2))`. The
colour's sector between the pieces is not read. -/
theorem erosion_diam {D : Set ℂ} (hD : IsPreconnected D) (hfree : ∀ p ∈ D, ∀ q ∈ D, dist p q ≠ 1) {z : ℂ}
    {α β L₁ L₂ : ℝ} (hαβ : α < β) (hβα : β - α < Real.pi) (hL₁ : 0 ≤ L₁) (hL₂ : 0 ≤ L₂)
    (h₁ : ∀ t ∈ Icc 0 L₁, z + (t : ℂ) * e α ∈ closure D) (h₂ : ∀ t ∈ Icc 0 L₂, z + (t : ℂ) * e β ∈ closure D) :
    min L₁ L₂ ≤ 1 / (2 * Real.sin ((β - α) / 2)) := by
  set m := min L₁ L₂ with hm
  have hm0 : 0 ≤ m := le_min hL₁ hL₂
  have hd := dist_le_one_of_mem_closure hD hfree (h₁ m ⟨hm0, min_le_left _ _⟩) (h₂ m ⟨hm0, min_le_right _ _⟩)
  have hring : dist (ringPt 0 α) (ringPt 0 β) = 2 * Real.sin ((β - α) / 2) := by
    rw [dist_ringPt_ringPt 0 (by rw [abs_sub_comm, abs_of_pos (by linarith)]; exact hβα.le), abs_sub_comm,
      abs_of_pos (by linarith)]
  have hdist : dist (z + (m : ℂ) * e α) (z + (m : ℂ) * e β) = m * (2 * Real.sin ((β - α) / 2)) := by
    rw [← hring, dist_eq_norm, dist_eq_norm, add_sub_add_left_eq_sub, ← mul_sub, norm_mul, Complex.norm_real,
      Real.norm_eq_abs, abs_of_nonneg hm0]
    simp [ringPt]
  have hsin : 0 < Real.sin ((β - α) / 2) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith [Real.pi_pos])
  rw [hdist] at hd
  rw [le_div_iff₀ (by positivity)]
  exact hd

/-- **FS121-V2-EROSION-DIAM**, the "so" clause: for `θ ≤ 2π/3` the bound is at most `cot (θ/2)`. -/
theorem erosion_diam_cot {D : Set ℂ} (hD : IsPreconnected D) (hfree : ∀ p ∈ D, ∀ q ∈ D, dist p q ≠ 1) {z : ℂ}
    {α β L₁ L₂ : ℝ} (hαβ : α < β) (hβα : β - α ≤ 2 * Real.pi / 3) (hL₁ : 0 ≤ L₁) (hL₂ : 0 ≤ L₂)
    (h₁ : ∀ t ∈ Icc 0 L₁, z + (t : ℂ) * e α ∈ closure D) (h₂ : ∀ t ∈ Icc 0 L₂, z + (t : ℂ) * e β ∈ closure D) :
    min L₁ L₂ ≤ Real.cos ((β - α) / 2) / Real.sin ((β - α) / 2) := by
  have hpi := Real.pi_pos
  have h := erosion_diam hD hfree hαβ (by linarith) hL₁ hL₂ h₁ h₂
  have hsin : 0 < Real.sin ((β - α) / 2) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
  have hcos : 1 / 2 ≤ Real.cos ((β - α) / 2) := by
    rw [← Real.cos_pi_div_three]
    exact Real.cos_le_cos_of_nonneg_of_le_pi (by linarith) (by linarith) (by linarith)
  refine h.trans ?_
  rw [div_le_div_iff₀ (by positivity) hsin]
  nlinarith

/-- Spec for `erosion_diam`: at a right angle the bound is `1/√2` — two pieces of length `1/2` (a square of side `1/2`)
pass, two of length `3/4` do not. -/
example : (1 / 2 : ℝ) ≤ 1 / (2 * Real.sin ((Real.pi / 2 - 0) / 2)) ∧ ¬ (3 / 4 : ℝ) ≤ 1 / (2 * Real.sin ((Real.pi / 2 - 0) / 2)) := by
  rw [sub_zero, show Real.pi / 2 / 2 = Real.pi / 4 by ring, Real.sin_pi_div_four]
  have h2 : (0 : ℝ) < √2 := by positivity
  have h3 : √2 * √2 = 2 := Real.mul_self_sqrt (by norm_num)
  constructor
  · rw [le_div_iff₀ (by positivity)]; nlinarith
  · rw [not_le, div_lt_iff₀ (by positivity)]; nlinarith

end HadwigerNelson.Plane
