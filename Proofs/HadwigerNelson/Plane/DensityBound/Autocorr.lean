import Proofs.HadwigerNelson.Plane.DensityBound.Bessel
import Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform
import Mathlib.MeasureTheory.Integral.PeakFunction
import Mathlib.MeasureTheory.Measure.ContinuousPreimage
import Mathlib.MeasureTheory.Measure.Lebesgue.Complex
import Mathlib.Analysis.Fourier.Inversion

/-!
# The autocorrelation of a bounded planar set is positive definite against `J₀` (FS-131: FS131-KDB1's statements, FS131-IDB2's proofs)

`autocorr E z = vol(E ∩ (E − z))`. For a bounded measurable `E ⊆ ℂ`, radii `r_k` and reals `c_k`,

  if `Σ c_k J₀(t r_k) ≥ 0` for every `t ≥ 0`, then `Σ c_k F̊(r_k) ≥ 0`,

where `F̊` is the circle average of `F = autocorr E`. This is the Fourier side of `[AmbrusEtAl2023]` Proposition 1 (pp. 13–14)
without the paper's periodic reduction and torus (§§ 2, 5): the Gaussian `Γ_ε` regularizes, its Fourier integral
(`GaussianFourier.integral_cexp_neg_mul_sq_norm_add`) and Fubini turn the regularized sum into
`(4π²)⁻¹ ∫ e^{−ε|ξ|²/4} |1̂_E(ξ)|² Σ c_k J₀(r_k|ξ|) dξ ≥ 0`, and `ε → 0` is a peak-function limit at points where `F` is
continuous — everywhere (`continuous_autocorr`). KMOR's Lemma 3.2 (1) is `autocorr_eq_zero_of_norm_eq_one` here.
Plan: `plans/FS131-KDB1-density-bound.md` § 3.
-/

namespace HadwigerNelson.DensityBound

open Real MeasureTheory Set Metric
open scoped ENNReal

/-- **The autocorrelation** `F(z) = vol(E ∩ (E − z))`, as a real number (finite for the bounded sets it is used on). -/
noncomputable def autocorr (E : Set ℂ) (z : ℂ) : ℝ := (volume (E ∩ (fun y => y + z) ⁻¹' E)).toReal

/-- **`[KMOR2016]` Lemma 3.2 (1), finite-window form**: a 1-avoiding set meets no translate of itself by a unit vector. -/
theorem autocorr_eq_zero_of_norm_eq_one {E : Set ℂ} (h1 : ∀ a ∈ E, ∀ b ∈ E, dist a b ≠ 1) {z : ℂ}
    (hz : ‖z‖ = 1) : autocorr E z = 0 := by
  have hempty : E ∩ (fun y => y + z) ⁻¹' E = ∅ := by
    ext y
    simp only [mem_inter_iff, mem_preimage, mem_empty_iff_false, iff_false, not_and]
    intro hy hyz
    exact h1 _ hyz _ hy (by rw [dist_eq_norm, add_sub_cancel_left, hz])
  simp [autocorr, hempty]

/-- The circle average of the autocorrelation at radius `1` vanishes. -/
theorem circleAvg_autocorr_one {E : Set ℂ} (h1 : ∀ a ∈ E, ∀ b ∈ E, dist a b ≠ 1) :
    Real.circleAverage (autocorr E) 0 1 = 0 := by
  apply Real.circleAverage_const_on_circle
  intro x hx
  rw [abs_one, mem_sphere_zero_iff_norm] at hx
  exact autocorr_eq_zero_of_norm_eq_one h1 hx

/-- At radius `0`: `F̊(0) = F(0) = vol E`. -/
theorem circleAvg_autocorr_zero (E : Set ℂ) : Real.circleAverage (autocorr E) 0 0 = (volume E).toReal := by
  apply Real.circleAverage_const_on_circle
  intro x hx
  rw [abs_zero, sphere_zero, mem_singleton_iff] at hx
  subst hx
  simp [autocorr]

-- `|vol(E ∩ A) − vol(E ∩ B)| ≤ vol(A Δ B)` for sets of finite measure.
private theorem abs_measureReal_inter_sub_le {E A B : Set ℂ} (hA : volume A ≠ ∞) (hB : volume B ≠ ∞) :
    |volume.real (E ∩ A) - volume.real (E ∩ B)| ≤ volume.real (symmDiff A B) := by
  have hAB : volume (symmDiff A B) ≠ ∞ :=
    measure_ne_top_of_subset symmDiff_subset_union (measure_union_ne_top hA hB)
  have key : ∀ {P Q : Set ℂ}, volume P ≠ ∞ → volume Q ≠ ∞ → volume (symmDiff P Q) ≠ ∞ →
      volume.real (E ∩ P) ≤ volume.real (E ∩ Q) + volume.real (symmDiff P Q) := by
    intro P Q hP hQ hPQ
    have hsub : E ∩ P ⊆ (E ∩ Q) ∪ symmDiff P Q := by
      intro y ⟨hyE, hyP⟩
      by_cases hyQ : y ∈ Q
      · exact Or.inl ⟨hyE, hyQ⟩
      · exact Or.inr (Or.inl ⟨hyP, hyQ⟩)
    calc volume.real (E ∩ P) ≤ volume.real ((E ∩ Q) ∪ symmDiff P Q) :=
          measureReal_mono hsub (measure_union_ne_top (measure_ne_top_of_subset inter_subset_right hQ) hPQ)
      _ ≤ volume.real (E ∩ Q) + volume.real (symmDiff P Q) := measureReal_union_le _ _
  rw [abs_sub_le_iff]
  constructor
  · linarith [key hA hB hAB]
  · have := key hB hA (by rwa [symmDiff_comm])
    rw [symmDiff_comm] at this
    linarith

/-- `F` is continuous for a measurable set of finite measure (translation is continuous in measure:
`tendsto_measure_symmDiff_preimage_nhds_zero`). -/
theorem continuous_autocorr {E : Set ℂ} (hE : MeasurableSet E) (hfin : volume E ≠ ∞) :
    Continuous (autocorr E) := by
  let T : C(ℂ, C(ℂ, ℂ)) := ContinuousMap.curry ⟨fun p : ℂ × ℂ => p.2 + p.1, by fun_prop⟩
  have hT : ∀ z, (T z : ℂ → ℂ) = fun y => y + z := fun _ => rfl
  rw [continuous_iff_continuousAt]
  intro z₀
  have hsd : Filter.Tendsto (fun z => volume (symmDiff (T z ⁻¹' E) (T z₀ ⁻¹' E))) (nhds z₀) (nhds 0) :=
    tendsto_measure_symmDiff_preimage_nhds_zero (T.continuous.tendsto z₀)
      (Filter.Eventually.of_forall fun z => by rw [hT]; exact measurePreserving_add_right volume z)
      (by rw [hT]; exact measurePreserving_add_right volume z₀) hE.nullMeasurableSet hfin
  have hfinT : ∀ z, volume (T z ⁻¹' E) ≠ ∞ := fun z => by
    rw [hT, measure_preimage_add_right]; exact hfin
  have hbound : ∀ z, ‖autocorr E z - autocorr E z₀‖ ≤
      (volume (symmDiff (T z ⁻¹' E) (T z₀ ⁻¹' E))).toReal := by
    intro z
    have := abs_measureReal_inter_sub_le (E := E) (hfinT z) (hfinT z₀)
    simpa [autocorr, Measure.real, hT, Real.norm_eq_abs] using this
  have h0 : Filter.Tendsto (fun z => (volume (symmDiff (T z ⁻¹' E) (T z₀ ⁻¹' E))).toReal) (nhds z₀) (nhds 0) := by
    have h := (ENNReal.tendsto_toReal ENNReal.zero_ne_top).comp hsd
    rw [ENNReal.toReal_zero] at h
    exact h
  exact tendsto_iff_norm_sub_tendsto_zero.2 (squeeze_zero (fun _ => norm_nonneg _) hbound h0)

section Fourier

open Complex Filter Topology
open scoped FourierTransform RealInnerProductSpace

-- `1_E(y) 1_E(y + z) = 1_{E ∩ (E − z)}(y)`.
private theorem ind_mul_ind (E : Set ℂ) (z y : ℂ) :
    E.indicator (fun _ => (1 : ℂ)) y * E.indicator (fun _ => (1 : ℂ)) (y + z) =
      (E ∩ (fun y => y + z) ⁻¹' E).indicator (fun _ => (1 : ℂ)) y := by
  by_cases h1 : y ∈ E <;> by_cases h2 : y + z ∈ E <;> simp [h1, h2]

private theorem autocorr_eq_integral {E : Set ℂ} (hE : MeasurableSet E) (z : ℂ) :
    ((autocorr E z : ℝ) : ℂ) =
      ∫ y, E.indicator (fun _ => (1 : ℂ)) y * E.indicator (fun _ => (1 : ℂ)) (y + z) := by
  simp_rw [ind_mul_ind]
  rw [integral_indicator_const _ (hE.inter (hE.preimage (measurable_add_const z)))]
  simp [autocorr, Measure.real]

private theorem autocorr_le {E : Set ℂ} (hfin : volume E ≠ ∞) (z : ℂ) : autocorr E z ≤ (volume E).toReal :=
  ENNReal.toReal_mono hfin (measure_mono inter_subset_left)

private theorem autocorr_eq_zero_of_lt {E : Set ℂ} {ρ : ℝ} (hρ : E ⊆ closedBall 0 ρ) {z : ℂ} (hz : 2 * ρ < ‖z‖) :
    autocorr E z = 0 := by
  have hempty : E ∩ (fun y => y + z) ⁻¹' E = ∅ := by
    ext y
    simp only [mem_inter_iff, mem_preimage, mem_empty_iff_false, iff_false, not_and]
    intro hy hyz
    have h1 := hρ hy
    have h2 := hρ hyz
    rw [mem_closedBall_zero_iff] at h1 h2
    have : ‖z‖ ≤ ‖y + z‖ + ‖y‖ := by
      calc ‖z‖ = ‖(y + z) - y‖ := by rw [add_sub_cancel_left]
        _ ≤ ‖y + z‖ + ‖y‖ := norm_sub_le _ _
    linarith
  simp [autocorr, hempty]

private theorem integrable_autocorr {E : Set ℂ} (hE : MeasurableSet E) (hb : Bornology.IsBounded E) :
    Integrable (autocorr E) := by
  obtain ⟨ρ, hρ⟩ := hb.subset_closedBall 0
  refine (continuous_autocorr hE hb.measure_lt_top.ne).integrable_of_hasCompactSupport
    (HasCompactSupport.intro (isCompact_closedBall 0 (2 * ρ)) fun z hz => ?_)
  rw [mem_closedBall_zero_iff, not_le] at hz
  exact autocorr_eq_zero_of_lt hρ hz

-- `1̂_E` is bounded by `vol E`.
private theorem norm_fourier_ind_le {E : Set ℂ} (hE : MeasurableSet E) (ξ : ℂ) :
    ‖𝓕 (E.indicator (fun _ => (1 : ℂ))) ξ‖ ≤ (volume E).toReal := by
  have h := VectorFourier.norm_fourierIntegral_le_integral_norm 𝐞 volume (innerₗ ℂ)
    (E.indicator (fun _ => (1 : ℂ))) ξ
  have hn : (fun v => ‖E.indicator (fun _ => (1 : ℂ)) v‖) = E.indicator (fun _ => (1 : ℝ)) := by
    funext v; rw [norm_indicator_eq_indicator_norm]; simp
  rw [hn, integral_indicator_const _ hE] at h
  change ‖VectorFourier.fourierIntegral 𝐞 volume (innerₗ ℂ) (E.indicator (fun _ => (1 : ℂ))) ξ‖ ≤ _
  simpa [Measure.real] using h

-- **The Fourier transform of the autocorrelation is `|1̂_E|²`** (Fubini on `(w, y)`).
private theorem fourier_autocorr {E : Set ℂ} (hE : MeasurableSet E) (hb : Bornology.IsBounded E) (ξ : ℂ) :
    𝓕 (fun z => ((autocorr E z : ℝ) : ℂ)) ξ = ((‖𝓕 (E.indicator (fun _ => (1 : ℂ))) ξ‖ ^ 2 : ℝ) : ℂ) := by
  set g : ℂ → ℂ := E.indicator (fun _ => (1 : ℂ)) with hg_def
  have hfin : volume E ≠ ∞ := hb.measure_lt_top.ne
  have hgm : Measurable g := measurable_const.indicator hE
  have hgi : Integrable g := (integrable_indicator_iff hE).2 (integrableOn_const hfin)
  have hg1 : ∀ y, ‖g y‖ ≤ 1 := fun y => by
    by_cases h : y ∈ E <;> simp [hg_def, h]
  have hgconj : ∀ y, (starRingEnd ℂ) (g y) = g y := fun y => by
    by_cases h : y ∈ E <;> simp [hg_def, h]
  have hex_add : ∀ a b : ℝ, cexp (↑(a + b) * I) = cexp (↑a * I) * cexp (↑b * I) := by
    intro a b; rw [← Complex.exp_add]; congr 1; push_cast; ring
  set f : ℂ × ℂ → ℂ := fun p => cexp (↑(-2 * π * ⟪p.1, ξ⟫) * I) * (g p.2 * g (p.2 + p.1)) with hf_def
  have hfmeas : Measurable f :=
    (Continuous.measurable (by fun_prop)).mul ((hgm.comp measurable_snd).mul (hgm.comp (measurable_snd.add measurable_fst)))
  have hnorm : ∀ w y : ℂ, ‖f (w, y)‖ = (E ∩ (fun y => y + w) ⁻¹' E).indicator (fun _ => (1 : ℝ)) y := by
    intro w y
    simp only [hf_def]
    rw [norm_mul, Complex.norm_exp_ofReal_mul_I, one_mul, hg_def, ind_mul_ind, norm_indicator_eq_indicator_norm]
    simp
  have hfi : Integrable f (volume.prod volume) := by
    rw [integrable_prod_iff hfmeas.aestronglyMeasurable]
    constructor
    · refine Eventually.of_forall fun w => Integrable.mono' hgi.norm
        (hfmeas.comp measurable_prodMk_left).aestronglyMeasurable (Eventually.of_forall fun y => ?_)
      simp only [hf_def]
      rw [norm_mul, Complex.norm_exp_ofReal_mul_I, one_mul, norm_mul]
      exact mul_le_of_le_one_right (norm_nonneg _) (hg1 _)
    · have he : (fun w => ∫ y, ‖f (w, y)‖) = autocorr E := by
        funext w
        simp_rw [hnorm]
        rw [integral_indicator_const _ (hE.inter (hE.preimage (measurable_add_const w)))]
        simp [autocorr, Measure.real]
      rw [he]
      exact integrable_autocorr hE hb
  -- the inner integral, for each `y`
  have hinner : ∀ y : ℂ, ∫ w, f (w, y) = g y * (cexp (↑(2 * π * ⟪y, ξ⟫) * I) * 𝓕 g ξ) := by
    intro y
    have h1 : ∫ w, f (w, y) = g y * ∫ w, cexp (↑(-2 * π * ⟪w, ξ⟫) * I) * g (y + w) := by
      rw [← integral_const_mul]
      congr 1; funext w; simp only [hf_def]; ring
    have h2 : ∫ w, cexp (↑(-2 * π * ⟪w, ξ⟫) * I) * g (y + w) =
        ∫ u, cexp (↑(-2 * π * ⟪u - y, ξ⟫) * I) * g u := by
      rw [← integral_add_left_eq_self (fun u => cexp (↑(-2 * π * ⟪u - y, ξ⟫) * I) * g u) y]
      simp only [add_sub_cancel_left]
    have h3 : ∫ u, cexp (↑(-2 * π * ⟪u - y, ξ⟫) * I) * g u =
        cexp (↑(2 * π * ⟪y, ξ⟫) * I) * 𝓕 g ξ := by
      rw [Real.fourier_eq', ← integral_const_mul]
      congr 1; funext u
      rw [inner_sub_left, show -2 * π * (⟪u, ξ⟫ - ⟪y, ξ⟫) = 2 * π * ⟪y, ξ⟫ + (-2 * π * ⟪u, ξ⟫) by ring, hex_add,
        smul_eq_mul]
      ring
    rw [h1, h2, h3]
  have hconj : (starRingEnd ℂ) (𝓕 g ξ) = ∫ y, g y * cexp (↑(2 * π * ⟪y, ξ⟫) * I) := by
    rw [Real.fourier_eq', ← integral_conj]
    congr 1; funext y
    rw [smul_eq_mul, map_mul, hgconj, ← Complex.exp_conj, map_mul, Complex.conj_ofReal, Complex.conj_I, mul_comm]
    congr 2
    push_cast; ring
  calc 𝓕 (fun z => ((autocorr E z : ℝ) : ℂ)) ξ
      = ∫ w, ∫ y, f (w, y) := by
        rw [Real.fourier_eq']
        congr 1; funext w
        rw [smul_eq_mul, autocorr_eq_integral hE w, ← integral_const_mul]
    _ = ∫ y, ∫ w, f (w, y) := integral_integral_swap hfi
    _ = (∫ y, g y * cexp (↑(2 * π * ⟪y, ξ⟫) * I)) * 𝓕 g ξ := by
        simp_rw [hinner]
        rw [← integral_mul_const]
        congr 1; funext y; ring
    _ = ((‖𝓕 g ξ‖ ^ 2 : ℝ) : ℂ) := by
        rw [← hconj, Complex.conj_mul']
        push_cast; ring

-- **The Gaussian-smoothed value**, on the Fourier side, tends to `f z` at a continuity point.
private theorem tendsto_smooth {f : ℂ → ℂ} (hf : Integrable f) {z : ℂ} (hfz : ContinuousAt f z) :
    Tendsto (fun c : ℝ => ∫ ξ : ℂ, cexp (- c⁻¹ * ‖ξ‖ ^ 2 + 2 * π * I * ⟪z, ξ⟫) • 𝓕 f ξ) atTop (𝓝 (f z)) := by
  apply (Real.tendsto_integral_gaussian_smul' hf hfz).congr'
  filter_upwards [Ioi_mem_atTop 0] with c (hc : 0 < c)
  have J : Integrable (fun w : ℂ => cexp (- c⁻¹ * ‖w‖ ^ 2 + 2 * π * I * ⟪z, w⟫)) :=
    GaussianFourier.integrable_cexp_neg_mul_sq_norm_add (by simpa) _ _
  have B : ∫ w, 𝓕 (fun w : ℂ => cexp (- c⁻¹ * ‖w‖ ^ 2 + 2 * π * I * ⟪z, w⟫)) w • f w =
      ∫ w, cexp (- c⁻¹ * ‖w‖ ^ 2 + 2 * π * I * ⟪z, w⟫) • 𝓕 f w := by
    simpa using! (VectorFourier.integral_fourierIntegral_smul_eq_flip (L := innerₗ ℂ)
      Real.continuous_fourierChar continuous_inner J hf)
  rw [← B]
  congr with w
  rw [fourier_gaussian_innerProductSpace' (by simpa), Complex.ofReal_inv, div_inv_eq_mul, div_inv_eq_mul,
    show -(π : ℂ) ^ 2 * ‖z - w‖ ^ 2 * c = -π ^ 2 * c * ‖z - w‖ ^ 2 by ring]

-- **The circle average of a weighted Fourier integral** is the weighted integral of `J₀`.
private theorem circleAverage_fourierWeight {w : ℂ → ℝ} (hwc : Continuous w) (hwi : Integrable w) (r : ℝ) :
    Real.circleAverage (fun z => ∫ ξ, (w ξ : ℂ) * cexp (↑(2 * π * ⟪z, ξ⟫) * I)) 0 r =
      ∫ ξ, ((w ξ * J0 (r * (2 * π * ‖ξ‖)) : ℝ) : ℂ) := by
  have hcont : Continuous (fun p : ℝ × ℂ => (w p.2 : ℂ) * cexp (↑(2 * π * ⟪circleMap 0 r p.1, p.2⟫) * I)) := by
    have := continuous_circleMap 0 r
    fun_prop
  have hint : Integrable (Function.uncurry fun (θ : ℝ) (ξ : ℂ) =>
      (w ξ : ℂ) * cexp (↑(2 * π * ⟪circleMap 0 r θ, ξ⟫) * I))
      ((volume.restrict (uIoc 0 (2 * π))).prod volume) := by
    haveI : IsFiniteMeasure (volume.restrict (uIoc 0 (2 * π))) :=
      ⟨by rw [Measure.restrict_apply_univ]
          exact lt_of_le_of_lt (measure_mono uIoc_subset_uIcc) isCompact_uIcc.measure_lt_top⟩
    have hb : Integrable (fun p : ℝ × ℂ => (1 : ℝ) * ‖w p.2‖) ((volume.restrict (uIoc 0 (2 * π))).prod volume) :=
      (integrable_const (1 : ℝ)).mul_prod hwi.norm
    refine hb.mono' hcont.aestronglyMeasurable (Eventually.of_forall fun p => ?_)
    obtain ⟨θ, ξ⟩ := p
    simp only [Function.uncurry_apply_pair, norm_mul, Complex.norm_exp_ofReal_mul_I, Complex.norm_real, mul_one,
      one_mul, le_refl]
  rw [Real.circleAverage_def, intervalIntegral_integral_swap hint, ← integral_smul]
  congr 1
  funext ξ
  have h := circleAverage_exp_inner ((2 * π : ℝ) • ξ) r
  rw [Real.circleAverage_def] at h
  have hn : ‖(2 * π : ℝ) • ξ‖ = 2 * π * ‖ξ‖ := by
    rw [norm_smul, Real.norm_of_nonneg (by positivity)]
  rw [hn] at h
  have hθ : ∀ θ : ℝ, (w ξ : ℂ) * cexp (↑(2 * π * ⟪circleMap 0 r θ, ξ⟫) * I) =
      (w ξ : ℂ) * cexp (I * ↑(inner ℝ ((2 * π : ℝ) • ξ) (circleMap 0 r θ))) := by
    intro θ
    rw [real_inner_smul_left, real_inner_comm]
    congr 2
    push_cast; ring
  simp_rw [hθ]
  rw [intervalIntegral.integral_const_mul, ← mul_smul_comm, h, Complex.ofReal_mul]

end Fourier

/-- **Positive definiteness against `J₀`** (the Fourier side, Gaussian-regularized). -/
theorem sum_circleAvg_autocorr_nonneg {E : Set ℂ} (hE : MeasurableSet E) (hb : Bornology.IsBounded E)
    {ι : Type*} (s : Finset ι) (c r : ι → ℝ) (hW : ∀ t : ℝ, 0 ≤ t → 0 ≤ ∑ k ∈ s, c k * J0 (t * r k)) :
    0 ≤ ∑ k ∈ s, c k * Real.circleAverage (autocorr E) 0 (r k) := by
  open Complex Filter Topology in
  open scoped FourierTransform RealInnerProductSpace in
  have hfin : volume E ≠ ∞ := hb.measure_lt_top.ne
  set g : ℂ → ℂ := E.indicator (fun _ => (1 : ℂ)) with hg_def
  set K : ℝ := (volume E).toReal with hK_def
  set F : ℂ → ℂ := fun z => ((autocorr E z : ℝ) : ℂ) with hF_def
  have hFi : Integrable F := (integrable_autocorr hE hb).ofReal
  have hFc : Continuous F := continuous_ofReal.comp (continuous_autocorr hE hfin)
  have hgi : Integrable g := (integrable_indicator_iff hE).2 (integrableOn_const hfin)
  have hgc : Continuous (𝓕 g) :=
    VectorFourier.fourierIntegral_continuous Real.continuous_fourierChar continuous_inner hgi
  -- the Gaussian weights `w_a(ξ) = e^{−‖ξ‖²/a} |1̂_E(ξ)|² ≥ 0`
  set wt : ℝ → ℂ → ℝ := fun a ξ => Real.exp (-a⁻¹ * ‖ξ‖ ^ 2) * ‖𝓕 g ξ‖ ^ 2 with hwt_def
  have hwc : ∀ a, Continuous (wt a) := fun a => by simp only [hwt_def]; fun_prop
  have hwnn : ∀ a ξ, 0 ≤ wt a ξ := fun a ξ => by simp only [hwt_def]; positivity
  have hwi : ∀ a, 0 < a → Integrable (wt a) := by
    intro a ha
    have J := GaussianFourier.integrable_cexp_neg_mul_sq_norm_add (V := ℂ) (b := ((a⁻¹ : ℝ) : ℂ))
      (by simpa using inv_pos.2 ha) 0 0
    have hG : Integrable (fun ξ : ℂ => Real.exp (-a⁻¹ * ‖ξ‖ ^ 2)) := by
      refine J.norm.congr (Eventually.of_forall fun ξ => ?_)
      simp only
      rw [show (-((a⁻¹ : ℝ) : ℂ) * ((‖ξ‖ : ℝ) : ℂ) ^ 2 + 0 * ((⟪(0 : ℂ), ξ⟫ : ℝ) : ℂ)) =
          ((-a⁻¹ * ‖ξ‖ ^ 2 : ℝ) : ℂ) by push_cast; ring, Complex.norm_exp_ofReal]
    refine (hG.mul_const (K ^ 2)).mono' (hwc a).aestronglyMeasurable (Eventually.of_forall fun ξ => ?_)
    rw [Real.norm_of_nonneg (hwnn a ξ)]
    simp only [hwt_def]
    gcongr
    exact norm_fourier_ind_le hE ξ
  -- the smoothed autocorrelation, on the Fourier side
  set Φ : ℝ → ℂ → ℂ := fun a z => ∫ ξ, (wt a ξ : ℂ) * cexp (↑(2 * π * ⟪z, ξ⟫) * I) with hΦ_def
  have hΦ : ∀ a z, Φ a z = ∫ ξ, cexp (- a⁻¹ * ‖ξ‖ ^ 2 + 2 * π * I * ⟪z, ξ⟫) • 𝓕 F ξ := by
    intro a z
    simp only [hΦ_def]
    congr 1; funext ξ
    rw [fourier_autocorr hE hb ξ, smul_eq_mul,
      show (-((a⁻¹ : ℝ) : ℂ) * ((‖ξ‖ : ℝ) : ℂ) ^ 2 + 2 * π * I * ((⟪z, ξ⟫ : ℝ) : ℂ)) =
        ((-a⁻¹ * ‖ξ‖ ^ 2 : ℝ) : ℂ) + ((2 * π * ⟪z, ξ⟫ : ℝ) : ℂ) * I by push_cast; ring,
      Complex.exp_add, ← Complex.ofReal_exp]
    simp only [hwt_def]
    push_cast; ring
  have hlim : ∀ z, Tendsto (fun a => Φ a z) atTop (𝓝 (F z)) := fun z => by
    simp_rw [hΦ]
    exact tendsto_smooth hFi hFc.continuousAt
  -- domination: `‖Φ_a z‖ ≤ Φ_a 0`, and `Φ_a 0 → vol E`
  have hΦ0 : ∀ a, Φ a 0 = ((∫ ξ, wt a ξ : ℝ) : ℂ) := by
    intro a
    simp only [hΦ_def, inner_zero_left, mul_zero, Complex.ofReal_zero, zero_mul, Complex.exp_zero, mul_one]
    exact integral_complex_ofReal
  have hdom : ∀ a z, ‖Φ a z‖ ≤ ∫ ξ, wt a ξ := by
    intro a z
    refine (norm_integral_le_integral_norm _).trans (le_of_eq ?_)
    congr 1; funext ξ
    rw [norm_mul, Complex.norm_exp_ofReal_mul_I, mul_one, Complex.norm_real, Real.norm_of_nonneg (hwnn a ξ)]
  have hF0 : ‖F 0‖ ≤ K := by
    simp only [hF_def, Complex.norm_real]
    exact (Real.norm_of_nonneg (show 0 ≤ autocorr E 0 from ENNReal.toReal_nonneg)).le.trans (autocorr_le hfin 0)
  have hev : ∀ᶠ a in atTop, ∀ z, ‖Φ a z‖ ≤ K + 1 := by
    have h := (hlim 0).norm.eventually (gt_mem_nhds (lt_add_one ‖F 0‖))
    filter_upwards [h] with a ha z
    have h1 : ∫ ξ, wt a ξ ≤ ‖Φ a 0‖ := by
      rw [hΦ0, Complex.norm_real, Real.norm_eq_abs]; exact le_abs_self _
    linarith [hdom a z]
  have hΦc : ∀ a, 0 < a → Continuous (Φ a) := fun a ha =>
    continuous_of_dominated (bound := fun ξ => ‖wt a ξ‖)
      (fun z => (Continuous.aestronglyMeasurable (by have := hwc a; fun_prop)))
      (fun z => Eventually.of_forall fun ξ => by
        rw [norm_mul, Complex.norm_exp_ofReal_mul_I, mul_one, Complex.norm_real])
      (hwi a ha).norm (Eventually.of_forall fun ξ => by fun_prop)
  -- the circle averages converge
  have hcirc : ∀ ρ : ℝ, Tendsto (fun a => Real.circleAverage (Φ a) 0 ρ) atTop
      (𝓝 (Real.circleAverage F 0 ρ)) := by
    intro ρ
    simp only [Real.circleAverage_def]
    apply Tendsto.const_smul
    apply intervalIntegral.tendsto_integral_filter_of_dominated_convergence (fun _ => K + 1)
    · filter_upwards [Ioi_mem_atTop 0] with a ha
      exact ((hΦc a ha).comp (continuous_circleMap 0 ρ)).aestronglyMeasurable
    · filter_upwards [hev] with a ha
      exact Eventually.of_forall fun θ _ => ha _
    · exact intervalIntegrable_const
    · exact Eventually.of_forall fun θ _ => hlim _
  -- each regularized sum is a nonnegative real number
  set S : ℝ → ℝ := fun a => ∫ ξ, wt a ξ * ∑ k ∈ s, c k * J0 (2 * π * ‖ξ‖ * r k) with hS_def
  have hSnn : ∀ a, 0 ≤ S a := fun a =>
    integral_nonneg fun ξ => mul_nonneg (hwnn a ξ) (hW _ (by positivity))
  have hSeq : ∀ a, 0 < a → (∑ k ∈ s, (c k : ℂ) * Real.circleAverage (Φ a) 0 (r k)) = ((S a : ℝ) : ℂ) := by
    intro a ha
    have hk : ∀ k ∈ s, Integrable (fun ξ => c k * (wt a ξ * J0 (r k * (2 * π * ‖ξ‖)))) := by
      intro k _
      refine ((hwi a ha).const_mul (|c k|)).mono'
        (Continuous.aestronglyMeasurable (by have := hwc a; have := continuous_J0; fun_prop))
        (Eventually.of_forall fun ξ => ?_)
      rw [norm_mul, norm_mul, Real.norm_of_nonneg (hwnn a ξ), Real.norm_eq_abs, Real.norm_eq_abs]
      exact mul_le_mul_of_nonneg_left (mul_le_of_le_one_right (hwnn a ξ) (abs_J0_le_one _)) (abs_nonneg _)
    have hSa : S a = ∑ k ∈ s, c k * ∫ ξ, wt a ξ * J0 (r k * (2 * π * ‖ξ‖)) := by
      have h1 : S a = ∫ ξ, ∑ k ∈ s, c k * (wt a ξ * J0 (r k * (2 * π * ‖ξ‖))) := by
        simp only [hS_def]
        congr 1; funext ξ
        rw [Finset.mul_sum]
        refine Finset.sum_congr rfl fun k _ => ?_
        rw [mul_comm (2 * π * ‖ξ‖) (r k)]; ring
      rw [h1, integral_finsetSum s hk]
      exact Finset.sum_congr rfl fun k _ => integral_const_mul _ _
    simp_rw [hΦ_def, circleAverage_fourierWeight (hwc a) (hwi a ha), integral_complex_ofReal]
    rw [hSa, Complex.ofReal_sum]
    simp only [Complex.ofReal_mul]
  -- pass to the limit
  have hlimS : Tendsto (fun a => ((S a : ℝ) : ℂ)) atTop
      (𝓝 (∑ k ∈ s, (c k : ℂ) * Real.circleAverage F 0 (r k))) := by
    have h := tendsto_finsetSum s fun k _ => (hcirc (r k)).const_mul (c k : ℂ)
    refine h.congr' ?_
    filter_upwards [Ioi_mem_atTop 0] with a ha
    exact hSeq a ha
  have hre := (Complex.continuous_re.tendsto _).comp hlimS
  have hci : ∀ ρ : ℝ, Real.circleAverage F 0 ρ = ((Real.circleAverage (autocorr E) 0 ρ : ℝ) : ℂ) := by
    intro ρ
    have := Complex.ofRealCLM.circleAverage_comp_comm
      ((continuous_autocorr hE hfin).continuousOn.circleIntegrable' (c := 0) (R := ρ))
    have hFeq : F = Complex.ofRealCLM ∘ autocorr E := by funext z; simp [hF_def]
    rw [hFeq]; exact this
  simp only [hci, Function.comp_def, Complex.ofReal_re] at hre
  have hval : (∑ k ∈ s, (c k : ℂ) * ((Real.circleAverage (autocorr E) 0 (r k) : ℝ) : ℂ)).re =
      ∑ k ∈ s, c k * Real.circleAverage (autocorr E) 0 (r k) := by
    push_cast [← Complex.ofReal_mul, ← Complex.ofReal_sum]
    rw [Complex.ofReal_re]
  rw [← hval]
  exact ge_of_tendsto hre (Eventually.of_forall hSnn)

/-- **A model** of `sum_circleAvg_autocorr_nonneg`'s hypotheses with every clause exercised: `E` the open disc of radius
`1/2` (measurable, bounded, nonempty), and the single term `c = 1` at `r = 0`, where `Σ c J₀(t·0) = J₀ 0 = 1 ≥ 0`. -/
example : MeasurableSet (ball (0 : ℂ) (1 / 2)) ∧ Bornology.IsBounded (ball (0 : ℂ) (1 / 2)) ∧
    ∀ t : ℝ, 0 ≤ t → 0 ≤ ∑ k ∈ ({0} : Finset ℕ), (fun _ => (1 : ℝ)) k * J0 (t * (fun _ => (0 : ℝ)) k) := by
  refine ⟨measurableSet_ball, isBounded_ball, fun t _ => ?_⟩
  simp [J0_zero]

end HadwigerNelson.DensityBound
