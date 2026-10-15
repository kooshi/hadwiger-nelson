import Proofs.HadwigerNelson.Rigidity.SpectralSubspace

/-! FS131-KM11 first leaf, priced in scratch: `exists_spectral_vector` (the cyclic-subspace vector), the assembly of step
(d), over the module's other leaves (`sorry` there). Stated exactly as in `Rigidity/SpectralSubspace`, primed. -/

namespace HadwigerNelson.Rigidity

open MeasureTheory SpectralChain SpectralInputs Filter Topology

noncomputable section

variable {R : Type*} [AddCommGroup R] {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}

theorem trigPoly_sub' (a b : R →₀ ℂ) (χ : AddChar R Circle) : trigPoly (a - b) χ = trigPoly a χ - trigPoly b χ := by
  simp [trigPoly, map_sub]

theorem trigPoly_eq_sum' (a : R →₀ ℂ) (χ : AddChar R Circle) :
    trigPoly a χ = ∑ y ∈ a.support, a y * ((χ y : Circle) : ℂ) := by
  simp [trigPoly, Finsupp.linearCombination_apply, Finsupp.sum]

theorem measurable_trigPoly' (a : R →₀ ℂ) : Measurable (trigPoly a) := by
  have h : trigPoly a = fun χ => ∑ y ∈ a.support, a y * ((χ y : Circle) : ℂ) := funext (trigPoly_eq_sum' a)
  rw [h]
  exact Finset.measurable_sum _ fun y _ => measurable_const.mul (measurable_evalChar y)

theorem norm_trigPoly_le' (a : R →₀ ℂ) (χ : AddChar R Circle) : ‖trigPoly a χ‖ ≤ ∑ y ∈ a.support, ‖a y‖ := by
  rw [trigPoly_eq_sum']
  refine (norm_sum_le _ _).trans (Finset.sum_le_sum fun y _ => ?_)
  rw [norm_mul, Circle.norm_coe, mul_one]

/-- The error `‖P_a − 1_A‖²` is integrable. -/
theorem integrable_err' (σ : Measure (AddChar R Circle)) [IsFiniteMeasure σ] {A : Set (AddChar R Circle)}
    (hA : MeasurableSet A) (a : R →₀ ℂ) :
    Integrable (fun χ => ‖trigPoly a χ - A.indicator 1 χ‖ ^ 2) σ := by
  refine Integrable.of_bound (C := (∑ y ∈ a.support, ‖a y‖ + 1) ^ 2) ?_ ?_
  · exact (((measurable_trigPoly' a).sub (measurable_const.indicator hA)).norm.pow_const 2).aestronglyMeasurable
  · refine Filter.Eventually.of_forall fun χ => ?_
    rw [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _)]
    have h1 : ‖A.indicator (1 : AddChar R Circle → ℂ) χ‖ ≤ 1 := by
      by_cases h : χ ∈ A <;> simp [h]
    have h2 : ‖trigPoly a χ - A.indicator 1 χ‖ ≤ ∑ y ∈ a.support, ‖a y‖ + 1 :=
      (norm_sub_le _ _).trans (add_le_add (norm_trigPoly_le' a χ) h1)
    exact pow_le_pow_left₀ (norm_nonneg _) h2 2

/-- `∫ ‖P_a − 1_A‖ → 0` when `∫ ‖P_a − 1_A‖² → 0` (`‖g‖ ≤ δ + ‖g‖²/δ`). -/
theorem tendsto_integral_norm_of_sq' (σ : Measure (AddChar R Circle)) [IsFiniteMeasure σ] (g : ℕ → AddChar R Circle → ℂ)
    (hg : ∀ n, Measurable (g n)) (hint : ∀ n, Integrable (fun χ => ‖g n χ‖ ^ 2) σ)
    (h : Tendsto (fun n => ∫ χ, ‖g n χ‖ ^ 2 ∂σ) atTop (𝓝 0)) :
    Tendsto (fun n => ∫ χ, ‖g n χ‖ ∂σ) atTop (𝓝 0) := by
  set C := σ.real Set.univ + 1 with hC
  have hCpos : 0 < C := by positivity
  rw [Metric.tendsto_atTop]
  intro η hη
  set δ := η / (2 * C) with hδ
  have hδpos : 0 < δ := by positivity
  obtain ⟨N, hN⟩ := Metric.tendsto_atTop.mp h (δ * η / 2) (by positivity)
  refine ⟨N, fun n hn => ?_⟩
  have hsq := hN n hn
  rw [Real.dist_eq, sub_zero, abs_of_nonneg (integral_nonneg fun _ => sq_nonneg _)] at hsq
  have hpt : ∀ χ, ‖g n χ‖ ≤ δ + ‖g n χ‖ ^ 2 / δ := by
    intro χ
    rcases le_or_gt ‖g n χ‖ δ with h1 | h1
    · have : 0 ≤ ‖g n χ‖ ^ 2 / δ := by positivity
      linarith
    · have : ‖g n χ‖ ≤ ‖g n χ‖ ^ 2 / δ := by
        rw [le_div_iff₀ hδpos, sq]
        exact mul_le_mul_of_nonneg_left h1.le (norm_nonneg _)
      have : 0 ≤ δ := hδpos.le
      linarith
  have hintb : Integrable (fun χ => δ + ‖g n χ‖ ^ 2 / δ) σ := (integrable_const δ).add ((hint n).div_const δ)
  have hle : ∫ χ, ‖g n χ‖ ∂σ ≤ δ * σ.real Set.univ + (∫ χ, ‖g n χ‖ ^ 2 ∂σ) / δ := by
    have hint1 : Integrable (fun χ => ‖g n χ‖) σ :=
      Integrable.mono' hintb (hg n).norm.aestronglyMeasurable
        (Filter.Eventually.of_forall fun χ => by rw [Real.norm_eq_abs, abs_norm]; exact hpt χ)
    calc ∫ χ, ‖g n χ‖ ∂σ ≤ ∫ χ, (δ + ‖g n χ‖ ^ 2 / δ) ∂σ := integral_mono hint1 hintb hpt
      _ = δ * σ.real Set.univ + (∫ χ, ‖g n χ‖ ^ 2 ∂σ) / δ := by
        rw [integral_add (integrable_const δ) ((hint n).div_const δ), integral_const, integral_div, smul_eq_mul,
          mul_comm]
  rw [Real.dist_eq, sub_zero, abs_of_nonneg (integral_nonneg fun _ => norm_nonneg _)]
  have h1 : δ * σ.real Set.univ < η / 2 := by
    rw [hδ]
    have : σ.real Set.univ < C := by linarith
    calc η / (2 * C) * σ.real Set.univ < η / (2 * C) * C := mul_lt_mul_of_pos_left this (by positivity)
      _ = η / 2 := by field_simp
  have h2 : (∫ χ, ‖g n χ‖ ^ 2 ∂σ) / δ < η / 2 := by
    rw [div_lt_iff₀ hδpos]
    linarith
  linarith

theorem trigPoly_mapDomain_add' (b : R →₀ ℂ) (z : R) (χ : AddChar R Circle) :
    trigPoly (b.mapDomain (· + z)) χ = ((χ z : Circle) : ℂ) * trigPoly b χ := by
  unfold trigPoly
  rw [Finsupp.linearCombination_mapDomain, Finsupp.linearCombination_apply, Finsupp.linearCombination_apply,
    Finsupp.sum, Finsupp.sum, Finset.mul_sum]
  refine Finset.sum_congr rfl fun y _ => ?_
  simp only [Function.comp_apply, AddChar.map_add_eq_mul, Circle.coe_mul, smul_eq_mul]
  ring

theorem exists_spectral_vector' [Countable R] (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) {f : Lp ℝ 2 μ} {σ : Measure (AddChar R Circle)}
    (hσ : IsSpectralMeasureOf T hT f σ) {A : Set (AddChar R Circle)} (hA : MeasurableSet A) :
    ∃ w : Lp ℝ 2 μ, inner ℝ w f = σ.real A ∧
      ∀ z : R, ‖Lp.compMeasurePreserving (T z) (hT z) w - w‖ ^ 2 ≤
        2 * ∫ χ in A, ‖((χ z : Circle) : ℂ) - 1‖ ^ 2 ∂σ := by
  haveI := hσ.1
  obtain ⟨a, ha⟩ := exists_trigPoly_tendsto σ hA
  let re : (R →₀ ℂ) → (R →₀ ℝ) := fun b => b.mapRange Complex.re Complex.zero_re
  have hre_sub : ∀ b c, re (b - c) = re b - re c := fun b c => by ext; simp [re]
  set ε : ℕ → ℝ := fun n => ∫ χ, ‖trigPoly (a n) χ - A.indicator 1 χ‖ ^ 2 ∂σ with hε
  set u : ℕ → Lp ℝ 2 μ := fun n => koopmanSum T hT f (re (a n)) with hu
  -- the Koopman sums are Cauchy: `‖u n − u m‖² ≤ 2 ε n + 2 ε m`
  have hdiff : ∀ n m, ‖u n - u m‖ ^ 2 ≤ 2 * ε n + 2 * ε m := by
    intro n m
    have hiso := norm_sq_koopmanSum_re_add_im T hT hadd hσ (a n - a m)
    have h1 : ‖u n - u m‖ ^ 2 ≤ ∫ χ, ‖trigPoly (a n - a m) χ‖ ^ 2 ∂σ := by
      rw [← hiso]
      have : u n - u m = koopmanSum T hT f ((a n - a m).mapRange Complex.re Complex.zero_re) := by
        simp only [hu, ← map_sub]
        rw [← hre_sub]
      rw [this]
      exact le_add_of_nonneg_right (sq_nonneg _)
    refine h1.trans ?_
    have hpt : ∀ χ, ‖trigPoly (a n - a m) χ‖ ^ 2 ≤
        2 * ‖trigPoly (a n) χ - A.indicator 1 χ‖ ^ 2 + 2 * ‖trigPoly (a m) χ - A.indicator 1 χ‖ ^ 2 := by
      intro χ
      have e : trigPoly (a n - a m) χ = (trigPoly (a n) χ - A.indicator 1 χ) - (trigPoly (a m) χ - A.indicator 1 χ) := by
        rw [trigPoly_sub']; ring
      rw [e]
      have := norm_sub_le (trigPoly (a n) χ - A.indicator 1 χ) (trigPoly (a m) χ - A.indicator 1 χ)
      have hsq := pow_le_pow_left₀ (norm_nonneg _) this 2
      nlinarith [hsq, sq_nonneg (‖trigPoly (a n) χ - A.indicator 1 χ‖ - ‖trigPoly (a m) χ - A.indicator 1 χ‖)]
    have hintd : Integrable (fun χ => ‖trigPoly (a n - a m) χ‖ ^ 2) σ := by
      have := integrable_err' σ MeasurableSet.empty (a n - a m)
      simpa using this
    calc ∫ χ, ‖trigPoly (a n - a m) χ‖ ^ 2 ∂σ
        ≤ ∫ χ, (2 * ‖trigPoly (a n) χ - A.indicator 1 χ‖ ^ 2 + 2 * ‖trigPoly (a m) χ - A.indicator 1 χ‖ ^ 2) ∂σ :=
          integral_mono hintd (((integrable_err' σ hA (a n)).const_mul 2).add
            ((integrable_err' σ hA (a m)).const_mul 2)) hpt
      _ = 2 * ε n + 2 * ε m := by
          rw [integral_add ((integrable_err' σ hA (a n)).const_mul 2) ((integrable_err' σ hA (a m)).const_mul 2),
            integral_const_mul, integral_const_mul]
  have hcauchy : CauchySeq u := by
    rw [Metric.cauchySeq_iff]
    intro η hη
    obtain ⟨N, hN⟩ := Metric.tendsto_atTop.mp ha (η ^ 2 / 4) (by positivity)
    refine ⟨N, fun m hm n hn => ?_⟩
    have e1 := hN m hm
    have e2 := hN n hn
    rw [Real.dist_eq, sub_zero, abs_of_nonneg (integral_nonneg fun _ => sq_nonneg _)] at e1 e2
    have hsq : dist (u m) (u n) ^ 2 < η ^ 2 := by
      rw [dist_eq_norm]
      calc ‖u m - u n‖ ^ 2 ≤ 2 * ε m + 2 * ε n := hdiff m n
        _ < η ^ 2 := by simp only [hε]; linarith
    exact lt_of_pow_lt_pow_left₀ 2 hη.le hsq
  obtain ⟨w, hw⟩ := cauchySeq_tendsto_of_complete hcauchy
  refine ⟨w, ?_, fun z => ?_⟩
  · -- `⟨w, f⟩ = lim ⟨u n, f⟩ = lim Re ∫ P_n = σ(A)`
    have h1 : Tendsto (fun n => inner ℝ (u n) f) atTop (𝓝 (inner ℝ w f)) := hw.inner tendsto_const_nhds
    have hL1 := tendsto_integral_norm_of_sq' σ (fun n χ => trigPoly (a n) χ - A.indicator 1 χ)
      (fun n => (measurable_trigPoly' (a n)).sub (measurable_const.indicator hA)) (fun n => integrable_err' σ hA (a n)) ha
    have h2 : Tendsto (fun n => inner ℝ (u n) f) atTop (𝓝 (σ.real A)) := by
      rw [Metric.tendsto_atTop]
      intro η hη
      obtain ⟨N, hN⟩ := Metric.tendsto_atTop.mp hL1 η hη
      refine ⟨N, fun n hn => ?_⟩
      have hb := hN n hn
      rw [Real.dist_eq, sub_zero, abs_of_nonneg (integral_nonneg fun _ => norm_nonneg _)] at hb
      rw [inner_koopmanSum_re T hT hσ (a n)]
      have hindA : ∫ χ, A.indicator (1 : AddChar R Circle → ℂ) χ ∂σ = (σ.real A : ℂ) := by
        rw [integral_indicator hA]
        simp
      have hTint : Integrable (trigPoly (a n)) σ := by
        refine Integrable.of_bound (C := ∑ y ∈ (a n).support, ‖a n y‖) (measurable_trigPoly' (a n)).aestronglyMeasurable
          (Filter.Eventually.of_forall fun χ => norm_trigPoly_le' (a n) χ)
      have hIint : Integrable (A.indicator (1 : AddChar R Circle → ℂ)) σ :=
        (integrable_const (1 : ℂ)).indicator hA
      have e : (∫ χ, trigPoly (a n) χ ∂σ).re - σ.real A = (∫ χ, (trigPoly (a n) χ - A.indicator 1 χ) ∂σ).re := by
        rw [integral_sub hTint hIint, hindA, Complex.sub_re, Complex.ofReal_re]
      rw [Real.dist_eq, e]
      exact lt_of_le_of_lt ((Complex.abs_re_le_norm _).trans (norm_integral_le_integral_norm _)) hb
    exact tendsto_nhds_unique h1 h2
  · -- `‖V_z w − w‖² = lim ‖V_z u n − u n‖² ≤ lim (2 ∫_A |χ z − 1|² + 8 ε n)`
    set V : Lp ℝ 2 μ → Lp ℝ 2 μ := fun g => Lp.compMeasurePreserving (T z) (hT z) g with hV
    have hVc : Continuous V := (Lp.isometry_compMeasurePreserving (hT z)).continuous
    have hlimL : Tendsto (fun n => ‖V (u n) - u n‖ ^ 2) atTop (𝓝 (‖V w - w‖ ^ 2)) :=
      (((hVc.tendsto w).comp hw).sub hw).norm.pow 2
    set c : AddChar R Circle → ℂ := fun χ => ((χ z : Circle) : ℂ) - 1 with hc
    have hcb : ∀ χ, ‖c χ‖ ≤ 2 := fun χ => (norm_sub_le _ _).trans (by simp; norm_num)
    have hcm : Measurable c := (measurable_evalChar z).sub measurable_const
    set J := ∫ χ in A, ‖((χ z : Circle) : ℂ) - 1‖ ^ 2 ∂σ with hJ
    have hbound : ∀ n, ‖V (u n) - u n‖ ^ 2 ≤ 2 * J + 8 * ε n := by
      intro n
      have hshift : V (u n) - u n =
          koopmanSum T hT f (((a n).mapDomain (· + z) - a n).mapRange Complex.re Complex.zero_re) := by
        simp only [hu, hV]
        rw [comp_koopmanSum T hT hadd, ← map_sub]
        congr 1
        rw [show ((a n).mapDomain (· + z) - a n).mapRange Complex.re Complex.zero_re =
            re ((a n).mapDomain (· + z)) - re (a n) from hre_sub _ _]
        simp only [re]
        rw [Finsupp.mapDomain_mapRange _ _ _ _ (fun x y => Complex.add_re x y)]
      have hiso := norm_sq_koopmanSum_re_add_im T hT hadd hσ ((a n).mapDomain (· + z) - a n)
      have h1 : ‖V (u n) - u n‖ ^ 2 ≤ ∫ χ, ‖c χ * trigPoly (a n) χ‖ ^ 2 ∂σ := by
        rw [hshift]
        calc _ ≤ ‖koopmanSum T hT f (((a n).mapDomain (· + z) - a n).mapRange Complex.re Complex.zero_re)‖ ^ 2 +
              ‖koopmanSum T hT f (((a n).mapDomain (· + z) - a n).mapRange Complex.im Complex.zero_im)‖ ^ 2 :=
            le_add_of_nonneg_right (sq_nonneg _)
          _ = _ := by
            rw [hiso]
            refine integral_congr_ae (Filter.Eventually.of_forall fun χ => ?_)
            simp only [trigPoly_sub', trigPoly_mapDomain_add', hc]
            ring_nf
      have hpt : ∀ χ, ‖c χ * trigPoly (a n) χ‖ ^ 2 ≤
          2 * A.indicator (fun χ => ‖((χ z : Circle) : ℂ) - 1‖ ^ 2) χ +
            8 * ‖trigPoly (a n) χ - A.indicator 1 χ‖ ^ 2 := by
        intro χ
        have e : c χ * trigPoly (a n) χ = c χ * A.indicator 1 χ + c χ * (trigPoly (a n) χ - A.indicator 1 χ) := by
          ring
        have hind : ‖c χ * A.indicator 1 χ‖ ^ 2 = A.indicator (fun χ => ‖((χ z : Circle) : ℂ) - 1‖ ^ 2) χ := by
          by_cases h : χ ∈ A <;> simp [h, hc]
        have h2 : ‖c χ * (trigPoly (a n) χ - A.indicator 1 χ)‖ ≤ 2 * ‖trigPoly (a n) χ - A.indicator 1 χ‖ := by
          rw [norm_mul]
          exact mul_le_mul_of_nonneg_right (hcb χ) (norm_nonneg _)
        have h3 := norm_add_le (c χ * A.indicator 1 χ) (c χ * (trigPoly (a n) χ - A.indicator 1 χ))
        rw [e, ← hind]
        have hsq := pow_le_pow_left₀ (norm_nonneg _) h3 2
        nlinarith [hsq, sq_nonneg (‖c χ * A.indicator 1 χ‖ - ‖c χ * (trigPoly (a n) χ - A.indicator 1 χ)‖),
          norm_nonneg (c χ * (trigPoly (a n) χ - A.indicator 1 χ)), norm_nonneg (trigPoly (a n) χ - A.indicator 1 χ)]
      have hintI : Integrable (A.indicator fun χ => ‖((χ z : Circle) : ℂ) - 1‖ ^ 2) σ := by
        refine (Integrable.of_bound (C := 4) ((hcm.norm.pow_const 2).aestronglyMeasurable)
          (Filter.Eventually.of_forall fun χ => ?_)).indicator hA
        rw [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _)]
        nlinarith [hcb χ, norm_nonneg (c χ)]
      have hintL : Integrable (fun χ => ‖c χ * trigPoly (a n) χ‖ ^ 2) σ := by
        refine Integrable.of_bound (C := (2 * ∑ y ∈ (a n).support, ‖a n y‖) ^ 2)
          (((hcm.mul (measurable_trigPoly' (a n))).norm.pow_const 2).aestronglyMeasurable)
          (Filter.Eventually.of_forall fun χ => ?_)
        rw [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _), norm_mul]
        exact pow_le_pow_left₀ (by positivity)
          (mul_le_mul (hcb χ) (norm_trigPoly_le' (a n) χ) (norm_nonneg _) (by norm_num)) 2
      calc ‖V (u n) - u n‖ ^ 2 ≤ ∫ χ, ‖c χ * trigPoly (a n) χ‖ ^ 2 ∂σ := h1
        _ ≤ ∫ χ, (2 * A.indicator (fun χ => ‖((χ z : Circle) : ℂ) - 1‖ ^ 2) χ +
              8 * ‖trigPoly (a n) χ - A.indicator 1 χ‖ ^ 2) ∂σ :=
            integral_mono hintL ((hintI.const_mul 2).add ((integrable_err' σ hA (a n)).const_mul 8)) hpt
        _ = 2 * J + 8 * ε n := by
            rw [integral_add (hintI.const_mul 2) ((integrable_err' σ hA (a n)).const_mul 8), integral_const_mul,
              integral_const_mul, integral_indicator hA]
    have hlimR : Tendsto (fun n => 2 * J + 8 * ε n) atTop (𝓝 (2 * J)) := by
      simpa using (ha.const_mul 8).const_add (2 * J)
    exact le_of_tendsto_of_tendsto' hlimL hlimR hbound

end

end HadwigerNelson.Rigidity
