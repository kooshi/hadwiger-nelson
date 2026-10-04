import Proofs.HadwigerNelson.Plane.Basic

/-!
# Sets with null unit pairs, density points, upper density, essential support

The measure-theoretic vocabulary of lane P (`plans/FS131-kernel-plan.md` § 5). The primitive is one set,
not a colouring: almost every row of FS-106, FS-111 and FS-121 is about one colour class at a time, and
FS-129's audit restated three of them (CLOSURE, HULLSET) for a single measurable set with null unit pairs.

* `unitPairSet A ⊆ ℂ × ℝ` is the set of `(x, θ)` with `x ∈ A` and `x + e θ ∈ A`; `UnitPairsNull A` says
  it is `volume ⊗ arcLength`-null — the rows' "`(Leb ⊗ σ){(x, w) : x ∈ A, x + w ∈ A} = 0`", read through
  the angle parametrization of `σ`.
* `densitySet A` is `Ã`, the points where `A` has Lebesgue density `1` (closed balls, as in
  `Besicovitch.ae_tendsto_measure_inter_div`, which says almost every point of `A` is one);
  `upperDensityAt A x` is `d̄_A(x)`, so the rows' `A* = {x : d̄_A(x) > 0}` is
  `{x | 0 < upperDensityAt A x}`; `essSupport A` is `supp A`, the points every ball about which meets
  `A` in positive measure.
-/

namespace HadwigerNelson.Plane

open Complex Real Set MeasureTheory Filter Topology Metric

/-- The unit pairs of `A`, as `(x, θ)` with both `x` and `x + e θ` in `A`. -/
def unitPairSet (A : Set ℂ) : Set (ℂ × ℝ) := {q | q.1 ∈ A ∧ q.1 + e q.2 ∈ A}

/-- `A` has null unit pairs: `(Leb ⊗ σ){(x, w) : x ∈ A, x + w ∈ A} = 0`. -/
def UnitPairsNull (A : Set ℂ) : Prop := (volume.prod arcLength) (unitPairSet A) = 0

/-- The ratio `|A ∩ B̄(x, r)| / |B̄(x, r)|` whose limits define density. -/
noncomputable def densityRatio (A : Set ℂ) (x : ℂ) (r : ℝ) : ENNReal :=
  volume (A ∩ closedBall x r) / volume (closedBall x r)

/-- `Ã`: the points of Lebesgue density `1` of `A`. -/
def densitySet (A : Set ℂ) : Set ℂ := {x | Tendsto (densityRatio A x) (𝓝[>] 0) (𝓝 1)}

/-- `d̄_A(x)`: the upper density of `A` at `x`. -/
noncomputable def upperDensityAt (A : Set ℂ) (x : ℂ) : ENNReal := limsup (densityRatio A x) (𝓝[>] 0)

/-- `supp A`: the points every open ball about which meets `A` in positive measure. -/
def essSupport (A : Set ℂ) : Set ℂ := {x | ∀ r > 0, 0 < volume (A ∩ ball x r)}

/-- A set with no two points at distance `1` or more has no unit pairs at all. -/
theorem unitPairsNull_of_dist_lt_one {A : Set ℂ} (h : ∀ x ∈ A, ∀ y ∈ A, dist x y < 1) :
    UnitPairsNull A := by
  have : unitPairSet A = ∅ := by
    ext ⟨x, θ⟩
    simp only [unitPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
    intro hx hy
    have := h _ hy _ hx
    simp [dist_eq_norm] at this
  rw [UnitPairsNull, this, measure_empty]

/-- Unit pairs are monotone in the set. -/
theorem unitPairSet_mono {A B : Set ℂ} (h : A ⊆ B) : unitPairSet A ⊆ unitPairSet B :=
  fun _ hq => ⟨h hq.1, h hq.2⟩

/-- A subset of a set with null unit pairs has null unit pairs. -/
theorem UnitPairsNull.mono {A B : Set ℂ} (hB : UnitPairsNull B) (h : A ⊆ B) : UnitPairsNull A :=
  measure_mono_null (unitPairSet_mono h) hB

/-- **Adversary**: a disc of radius `2` does not have null unit pairs — every `x` within `1/2` of the
centre has its whole unit circle inside, so the pair set holds a product of positive measure. -/
theorem not_unitPairsNull_ball_two : ¬ UnitPairsNull (ball (0 : ℂ) 2) := by
  intro h
  have hsub : ball (0 : ℂ) (1 / 2) ×ˢ Ico 0 (2 * π) ⊆ unitPairSet (ball 0 2) := by
    rintro ⟨x, θ⟩ ⟨hx, -⟩
    simp only [mem_ball, dist_zero_right] at hx
    refine ⟨by simp only [mem_ball, dist_zero_right]; linarith, ?_⟩
    simp only [mem_ball, dist_zero_right]
    calc ‖x + e θ‖ ≤ ‖x‖ + ‖e θ‖ := norm_add_le _ _
      _ < 2 := by rw [norm_e]; linarith
  have hpos : 0 < (volume.prod arcLength) (ball (0 : ℂ) (1 / 2) ×ˢ Ico 0 (2 * π)) := by
    rw [Measure.prod_prod]
    refine ENNReal.mul_pos (measure_ball_pos volume 0 (by norm_num)).ne' ?_
    simp [arcLength, Real.volume_Ico, Real.pi_pos]
  exact hpos.ne' (measure_mono_null hsub h)

/-- On a ball of positive radius the ratio of the whole plane is `1`. -/
theorem densityRatio_univ (x : ℂ) {r : ℝ} (hr : 0 < r) : densityRatio univ x r = 1 := by
  rw [densityRatio, univ_inter]
  exact ENNReal.div_self (measure_closedBall_pos volume x hr).ne' measure_closedBall_lt_top.ne

/-! ## Measurability and Tonelli (supporting lemmas for FS-131 wave 1) -/

/-- `e` is continuous. -/
theorem continuous_e : Continuous e :=
  Complex.continuous_exp.comp (Complex.continuous_ofReal.mul continuous_const)

/-- `e (θ + π) = − e θ`. -/
theorem e_add_pi (θ : ℝ) : e (θ + π) = - e θ := by
  rw [e_add, e_eq π]; simp

/-- The pairs `(x, θ)` with `x ∈ S` and `x + e θ ∈ T`; the unit pairs of `A` are `pairSet A A`. -/
def pairSet (S T : Set ℂ) : Set (ℂ × ℝ) := {q | q.1 ∈ S ∧ q.1 + e q.2 ∈ T}

/-- The unit pairs of `A` are the pairs from `A` to `A`. -/
theorem unitPairSet_eq_pairSet (A : Set ℂ) : unitPairSet A = pairSet A A := rfl

/-- Pairs between measurable sets form a measurable set. -/
theorem measurableSet_pairSet {S T : Set ℂ} (hS : MeasurableSet S) (hT : MeasurableSet T) :
    MeasurableSet (pairSet S T) := by
  have h2 : Measurable fun q : ℂ × ℝ => q.1 + e q.2 :=
    measurable_fst.add (continuous_e.measurable.comp measurable_snd)
  exact (measurable_fst hS).inter (h2 hT)

/-- The unit pairs of a measurable set form a measurable set. -/
theorem measurableSet_unitPairSet {A : Set ℂ} (hA : MeasurableSet A) :
    MeasurableSet (unitPairSet A) := measurableSet_pairSet hA hA

/-- The direction set `{θ | p + e θ ∈ A}` has measurable arc-length in `p`. -/
theorem measurable_arcLength_slice {A : Set ℂ} (hA : MeasurableSet A) :
    Measurable fun p : ℂ => arcLength {θ | p + e θ ∈ A} := by
  have h2 : Measurable fun q : ℂ × ℝ => q.1 + e q.2 :=
    measurable_fst.add (continuous_e.measurable.comp measurable_snd)
  exact measurable_measure_prodMk_left (ν := arcLength) (s := {q : ℂ × ℝ | q.1 + e q.2 ∈ A}) (h2 hA)

/-- Tonelli in the point: the mass of the pairs from `S` to `T` is the integral over `S` of the arc-length of
the directions landing in `T`. -/
theorem pairSet_measure_eq_lintegral {S T : Set ℂ} (hS : MeasurableSet S) (hT : MeasurableSet T) :
    (volume.prod arcLength) (pairSet S T) = ∫⁻ p in S, arcLength {θ | p + e θ ∈ T} := by
  rw [Measure.prod_apply (measurableSet_pairSet hS hT), ← lintegral_indicator hS]
  refine lintegral_congr fun p => ?_
  by_cases hp : p ∈ S
  · simp only [indicator_of_mem hp]
    congr 1
    ext θ; simp [pairSet, hp]
  · simp only [indicator_of_notMem hp]
    have : Prod.mk p ⁻¹' pairSet S T = ∅ := by
      ext θ; simp [pairSet, hp]
    rw [this, measure_empty]

/-- Tonelli in the direction: the pairs from `S` to `T` are null iff for almost every direction `θ` the points
`x ∈ S` with `x + e θ ∈ T` are null. -/
theorem pairSet_null_iff_ae_slice {S T : Set ℂ} (hS : MeasurableSet S) (hT : MeasurableSet T) :
    (volume.prod arcLength) (pairSet S T) = 0 ↔
      ∀ᵐ θ ∂arcLength, volume {x : ℂ | x ∈ S ∧ x + e θ ∈ T} = 0 := by
  have hm : MeasurableSet (Prod.swap ⁻¹' pairSet S T) :=
    measurable_swap (measurableSet_pairSet hS hT)
  have h1 : (arcLength.prod volume) (Prod.swap ⁻¹' pairSet S T) = (volume.prod arcLength) (pairSet S T) :=
    (Measure.measurePreserving_swap (μ := arcLength) (ν := volume)).measure_preimage
      (measurableSet_pairSet hS hT).nullMeasurableSet
  rw [← h1, Measure.measure_prod_null hm]
  constructor
  · intro h
    filter_upwards [h] with θ hθ
    simpa [pairSet] using hθ
  · intro h
    filter_upwards [h] with θ hθ
    simpa [pairSet] using hθ

/-- A measurable `A` has null unit pairs iff almost every direction has a null set of unit pairs. -/
theorem unitPairsNull_iff_ae_slice {A : Set ℂ} (hA : MeasurableSet A) :
    UnitPairsNull A ↔ ∀ᵐ θ ∂arcLength, volume {x : ℂ | x ∈ A ∧ x + e θ ∈ A} = 0 :=
  pairSet_null_iff_ae_slice hA hA

/-- Tonelli in the point, for the unit pairs. -/
theorem unitPairs_measure_eq_lintegral {A : Set ℂ} (hA : MeasurableSet A) :
    (volume.prod arcLength) (unitPairSet A) = ∫⁻ p in A, arcLength {θ | p + e θ ∈ A} :=
  pairSet_measure_eq_lintegral hA hA

/-- Translating by `e θ` swaps the two ends of a slice, at the opposite direction. -/
theorem volume_slice_swap (S T : Set ℂ) (θ : ℝ) :
    volume {x : ℂ | x ∈ S ∧ x + e θ ∈ T} = volume {x : ℂ | x ∈ T ∧ x + e (θ + π) ∈ S} := by
  have : {x : ℂ | x ∈ S ∧ x + e θ ∈ T} = (fun x => x + e θ) ⁻¹' {x : ℂ | x ∈ T ∧ x + e (θ + π) ∈ S} := by
    ext x; simp [e_add_pi, and_comm]
  rw [this, measure_preimage_add_right]

/-! ## Spec examples -/

/-- A small disc has null unit pairs. -/
example : UnitPairsNull (ball (0 : ℂ) (1 / 3)) := by
  refine unitPairsNull_of_dist_lt_one fun x hx y hy => ?_
  rw [mem_ball] at hx hy
  calc dist x y ≤ dist x 0 + dist 0 y := dist_triangle _ _ _
    _ < 1 := by rw [dist_comm 0 y]; linarith

/-- Every point is a density point of the plane. -/
example (x : ℂ) : x ∈ densitySet univ := by
  refine tendsto_const_nhds.congr' ?_
  filter_upwards [self_mem_nhdsWithin] with r hr using (densityRatio_univ x hr).symm

/-- **Adversary**: no point is a density point of the empty set. -/
example (x : ℂ) : x ∉ densitySet ∅ := by
  intro h
  have h0 : densityRatio ∅ x = fun _ => 0 := by
    funext r; simp [densityRatio]
  rw [densitySet, mem_setOf_eq, h0] at h
  exact zero_ne_one (tendsto_nhds_unique tendsto_const_nhds h)

/-- The plane has upper density `1` everywhere. -/
example (x : ℂ) : upperDensityAt univ x = 1 := by
  rw [upperDensityAt]
  have : densityRatio univ x =ᶠ[𝓝[>] 0] fun _ => 1 := by
    filter_upwards [self_mem_nhdsWithin] with r hr using densityRatio_univ x hr
  rw [limsup_congr this, limsup_const]

/-- Every point is in the essential support of the plane, and none in that of the empty set. -/
example (x : ℂ) : x ∈ essSupport univ ∧ x ∉ essSupport ∅ := by
  refine ⟨fun r hr => by simpa using measure_ball_pos volume x hr, fun h => ?_⟩
  simpa using h 1 one_pos

end HadwigerNelson.Plane
