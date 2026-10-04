import Proofs.HadwigerNelson.Plane.UnitPairs

/-!
# Maximal unit-avoiding sets and the circle measure `φ_A` (FS-131 wave 1)

Row: **FS111-M2-ZERO**. Plan: `plans/FS131-kernel-plan.md` § 6.

`φ_A(p) = σ{w ∈ S¹ : p + w ∈ A}` is `phi A p`, read through the angle parametrization of `σ`. A **MUA set** (maximal
unit-avoiding) is a measurable set with null unit pairs, maximal under inclusion up to null sets among such sets — "a
measurable independent dominating set of the unit-distance graph". By Tonelli, null unit pairs is `φ_A = 0` almost
everywhere on `A`, and maximality is `φ_A > 0` almost everywhere off `A`.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

/-- `φ_A(p)`: the arc-length of the directions from `p` that land in `A` at distance `1`. -/
noncomputable def phi (A : Set ℂ) (p : ℂ) : ENNReal := arcLength {θ | p + e θ ∈ A}

/-- A **MUA set**: measurable, null unit pairs, and maximal up to null sets among measurable sets with null unit
pairs. -/
def IsMUA (A : Set ℂ) : Prop :=
  MeasurableSet A ∧ UnitPairsNull A ∧
    ∀ B : Set ℂ, MeasurableSet B → UnitPairsNull B → A ≤ᵐ[volume] B → B ≤ᵐ[volume] A

/-- Spec: `φ` of the plane is the whole circle. -/
theorem phi_univ (p : ℂ) : phi univ p = ENNReal.ofReal (2 * Real.pi) := by
  simp [phi, arcLength, Real.volume_Ico]

/-- `φ_A` is measurable for measurable `A`. -/
theorem measurable_phi {A : Set ℂ} (hA : MeasurableSet A) : Measurable (phi A) :=
  measurable_arcLength_slice hA

/-- A null set of directions' shift by `Real.pi` is null, for `2Real.pi`-periodic data. -/
theorem ae_arcLength_shift_pi (f : ℝ → ENNReal) (hper : ∀ θ, f (θ + 2 * Real.pi) = f θ)
    (h : ∀ᵐ θ ∂arcLength, f θ = 0) : ∀ᵐ θ ∂arcLength, f (θ + Real.pi) = 0 := by
  set M : Set ℝ := {θ | f θ ≠ 0} ∩ Ico 0 (2 * Real.pi) with hM
  have hM0 : volume M = 0 := by
    have := (ae_iff.mp h)
    rw [arcLength, Measure.restrict_apply' measurableSet_Ico] at this
    simpa [hM] using this
  rw [ae_iff, arcLength, Measure.restrict_apply' measurableSet_Ico]
  refine measure_mono_null ?_ (measure_union_null
    (show volume ((fun θ => θ + Real.pi) ⁻¹' M) = 0 by rw [measure_preimage_add_right]; exact hM0)
    (show volume ((fun θ => θ + (-Real.pi)) ⁻¹' M) = 0 by rw [measure_preimage_add_right]; exact hM0))
  rintro θ ⟨hθ, hθI⟩
  have hθ' : f (θ + Real.pi) ≠ 0 := hθ
  rcases lt_or_ge θ Real.pi with hlt | hge
  · left
    exact ⟨hθ', by linarith [hθI.1, Real.pi_pos], by linarith [hθI.2, Real.pi_pos]⟩
  · right
    have : f (θ + -Real.pi) = f (θ + Real.pi) := by
      rw [← hper (θ + -Real.pi)]; congr 1; ring
    exact ⟨show f (θ + -Real.pi) ≠ 0 by rw [this]; exact hθ', by linarith [hθI.1, Real.pi_pos],
      by linarith [hθI.2, Real.pi_pos]⟩

/-- A set of positive measure meets some disc of radius `1/3` in a set of positive measure. -/
theorem exists_ball_pos_inter {E : Set ℂ} (hE : 0 < volume E) : ∃ d : ℂ, 0 < volume (E ∩ ball d (1 / 3)) := by
  obtain ⟨D, hDc, hDd⟩ := TopologicalSpace.exists_countable_dense ℂ
  by_contra hcon
  push Not at hcon
  have hz : ∀ d ∈ D, volume (E ∩ ball d (1 / 3)) = 0 := fun d _ => nonpos_iff_eq_zero.mp (hcon d)
  have hsub : E ⊆ ⋃ d ∈ D, E ∩ ball d (1 / 3) := by
    intro x hx
    obtain ⟨d, hd, hdD⟩ := Metric.dense_iff.mp hDd x (1 / 3) (by norm_num)
    exact mem_biUnion hdD ⟨hx, by rwa [mem_ball, dist_comm] at hd⟩
  have : volume E = 0 := measure_mono_null hsub ((measure_biUnion_null_iff hDc).mpr hz)
  exact hE.ne' this

/-- **FS111-M2-ZERO**, unit-avoiding half: a measurable `A` has null unit pairs iff `φ_A = 0` almost everywhere on `A`. -/
theorem unitPairsNull_iff_ae_phi_eq_zero {A : Set ℂ} (hA : MeasurableSet A) :
    UnitPairsNull A ↔ ∀ᵐ p ∂(volume.restrict A), phi A p = 0 := by
  rw [UnitPairsNull, unitPairs_measure_eq_lintegral hA]
  exact lintegral_eq_zero_iff (measurable_phi hA)

/-- **FS111-M2-ZERO**, maximal half: a measurable `A` with null unit pairs is a MUA set iff `φ_A > 0` almost
everywhere off `A`. -/
theorem isMUA_iff_ae_phi_pos {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) :
    IsMUA A ↔ ∀ᵐ p ∂(volume.restrict Aᶜ), 0 < phi A p := by
  constructor
  · rintro ⟨-, hAn, hmax⟩
    set E : Set ℂ := {p | p ∉ A ∧ phi A p = 0} with hE
    have hEm : MeasurableSet E :=
      hA.compl.inter ((measurable_phi hA) (measurableSet_singleton 0))
    have hE0 : volume E = 0 := by
      by_contra hne
      obtain ⟨d, hd⟩ := exists_ball_pos_inter (pos_iff_ne_zero.mpr hne)
      set E' : Set ℂ := E ∩ ball d (1 / 3) with hE'
      have hE'm : MeasurableSet E' := hEm.inter measurableSet_ball
      -- pairs from `E'` into `A` are null, because `φ_A = 0` on `E`
      have hEA : (volume.prod arcLength) (pairSet E' A) = 0 := by
        rw [pairSet_measure_eq_lintegral hE'm hA]
        have : ∫⁻ p in E', phi A p = 0 := by
          rw [setLIntegral_congr_fun hE'm (g := fun _ => 0) (fun p hp => hp.1.2)]
          simp
        exact this
      have hs1 : ∀ᵐ θ ∂arcLength, volume {x : ℂ | x ∈ E' ∧ x + e θ ∈ A} = 0 :=
        (pairSet_null_iff_ae_slice hE'm hA).mp hEA
      have hs2 : ∀ᵐ θ ∂arcLength, volume {x : ℂ | x ∈ A ∧ x + e θ ∈ E'} = 0 := by
        have := ae_arcLength_shift_pi (fun θ => volume {x : ℂ | x ∈ E' ∧ x + e θ ∈ A})
          (fun θ => by simp only [e_add_two_pi]) hs1
        filter_upwards [this] with θ hθ
        rw [volume_slice_swap]; exact hθ
      have hs3 := (unitPairsNull_iff_ae_slice hA).mp hAn
      have hBn : UnitPairsNull (A ∪ E') := by
        rw [unitPairsNull_iff_ae_slice (hA.union hE'm)]
        filter_upwards [hs1, hs2, hs3] with θ h1 h2 h3
        refine measure_mono_null ?_ (measure_union_null (measure_union_null h3 h2) h1)
        rintro x ⟨hx, hxe⟩
        rcases hx with hx | hx <;> rcases hxe with hxe | hxe
        · exact Or.inl (Or.inl ⟨hx, hxe⟩)
        · exact Or.inl (Or.inr ⟨hx, hxe⟩)
        · exact Or.inr ⟨hx, hxe⟩
        · exfalso
          have h1 := hx.2
          have h2 := hxe.2
          rw [mem_ball, dist_eq_norm] at h1
          rw [mem_ball, dist_eq_norm] at h2
          have : ‖e θ‖ ≤ ‖x + e θ - d‖ + ‖x - d‖ := by
            calc ‖e θ‖ = ‖(x + e θ - d) - (x - d)‖ := by congr 1; ring
              _ ≤ _ := norm_sub_le _ _
          rw [norm_e] at this; linarith
      have hB := hmax (A ∪ E') (hA.union hE'm) hBn (Filter.Eventually.of_forall subset_union_left)
      have hB' : ∀ᵐ x ∂volume, x ∈ A ∪ E' → x ∈ A := hB
      have hz : volume {x : ℂ | ¬(x ∈ A ∪ E' → x ∈ A)} = 0 := ae_iff.mp hB'
      refine hd.ne' (measure_mono_null (fun x hx => ?_) hz)
      exact fun h => hx.1.1 (h (Or.inr hx))
    rw [ae_restrict_iff' hA.compl]
    filter_upwards [measure_eq_zero_iff_ae_notMem.mp hE0] with p hp hpA
    by_contra h0
    exact hp ⟨hpA, nonpos_iff_eq_zero.mp (not_lt.mp h0)⟩
  · intro hpos
    refine ⟨hA, hnull, fun B hBm hBn hAB => ?_⟩
    set N : Set ℂ := B \ A with hN
    have hNm : MeasurableSet N := hBm.diff hA
    have hAB' : ∀ᵐ x ∂volume, x ∈ A → x ∈ B := hAB
    have hAB1 : volume {x : ℂ | ¬(x ∈ A → x ∈ B)} = 0 := ae_iff.mp hAB'
    have hAB0 : volume (A \ B) = 0 := by
      refine measure_mono_null (fun x hx => ?_) hAB1
      exact fun h => hx.2 (h hx.1)
    have hNA : (volume.prod arcLength) (pairSet N A) = 0 := by
      rw [pairSet_null_iff_ae_slice hNm hA]
      filter_upwards [(unitPairsNull_iff_ae_slice hBm).mp hBn] with θ hθ
      refine measure_mono_null ?_ (measure_union_null hθ
        (show volume ((fun x => x + e θ) ⁻¹' (A \ B)) = 0 by
          rw [measure_preimage_add_right]; exact hAB0))
      rintro x ⟨hx, hxe⟩
      by_cases hxeB : x + e θ ∈ B
      · exact Or.inl ⟨hx.1, hxeB⟩
      · exact Or.inr ⟨hxe, hxeB⟩
    rw [pairSet_measure_eq_lintegral hNm hA] at hNA
    have hNA' : ∫⁻ p in N, phi A p = 0 := hNA
    rw [lintegral_eq_zero_iff (measurable_phi hA)] at hNA'
    have h1 := (ae_restrict_iff' hNm).mp hNA'
    have h2 : ∀ᵐ p ∂(volume.restrict N), 0 < phi A p :=
      ae_restrict_of_ae_restrict_of_subset (fun p hp => hp.2) hpos
    have h2' := (ae_restrict_iff' hNm).mp h2
    have hN0 : volume N = 0 := by
      rw [measure_eq_zero_iff_ae_notMem]
      filter_upwards [h1, h2'] with p hp1 hp2 hpN
      have := hp2 hpN
      rw [hp1 hpN] at this
      exact lt_irrefl _ this
    filter_upwards [measure_eq_zero_iff_ae_notMem.mp hN0] with x hx hxB
    by_contra hxA
    exact hx ⟨hxB, hxA⟩

/-- **FS111-M2-ZERO**: a measurable `A` is a MUA set iff `A = {φ_A = 0}` almost everywhere. -/
theorem isMUA_iff_ae_eq {A : Set ℂ} (hA : MeasurableSet A) :
    IsMUA A ↔ A =ᵐ[volume] {p | phi A p = 0} := by
  constructor
  · intro hM
    have hAn := hM.2.1
    have h1 := (ae_restrict_iff' hA).mp ((unitPairsNull_iff_ae_phi_eq_zero hA).mp hAn)
    have h2 := (ae_restrict_iff' hA.compl).mp ((isMUA_iff_ae_phi_pos hA hAn).mp hM)
    filter_upwards [h1, h2] with p a b
    exact propext ⟨fun hp => a hp, fun hp => by_contra fun hpA => (pos_iff_ne_zero.mp (b hpA)) hp⟩
  · intro hAE
    have hae := Filter.eventuallyEq_set.mp hAE
    have hnull : UnitPairsNull A := (unitPairsNull_iff_ae_phi_eq_zero hA).mpr
      ((ae_restrict_iff' hA).mpr (hae.mono fun p h hp => h.mp hp))
    refine (isMUA_iff_ae_phi_pos hA hnull).mpr ((ae_restrict_iff' hA.compl).mpr (hae.mono fun p h hp => ?_))
    exact pos_iff_ne_zero.mpr fun h0 => hp (h.mpr h0)

end HadwigerNelson.Plane
