import Proofs.HadwigerNelson.Rigidity.CountExtension
/-! First leaf of block E (scratch; FS131-K12A): C1, continuity in probability along the completion, over its two
sibling leaves `measure_ne_eq` and `comap_ιG_le_nhds_tauPrime`. -/
namespace HadwigerNelson.Rigidity.Counting
open SpectralChain NumberField MeasureTheory Filter Topology
variable {F : Subfield ℝ} [NumberField F]

theorem leafE (μ : InvariantColouring F) {σ : Measure (Dual F)} (hσ : IsTraceSpectral F μ.μ σ)
    (hTA : σ (TA F)ᶜ = 0) : Tendsto (fun y => μ.μ {c | c 0 ≠ c y}) (comap (ιG F) (𝓝 0)) (𝓝 0) := by
  haveI : IsFiniteMeasure σ := hσ.1
  haveI := μ.isProb
  -- the correlation tends to `σ univ` by dominated convergence
  have hpt : ∀ᵐ χ ∂σ, Tendsto (fun y : unitRing F => ((χ y : Circle) : ℂ)) (comap (ιG F) (𝓝 0)) (𝓝 (1 : ℂ)) := by
    have hae : ∀ᵐ χ ∂σ, χ ∈ TA F := by
      rw [ae_iff]; simpa [Set.compl_def] using hTA
    filter_upwards [hae] with χ hχ
    have hc : @Continuous (unitRing F) Circle (tauPrime F) _ fun y => χ y := TA_subset_contChars F hχ
    have h0 := (@Continuous.tendsto _ _ (tauPrime F) _ _ hc 0)
    rw [AddChar.map_zero_eq_one] at h0
    have hcoe : Continuous (fun z : Circle => (z : ℂ)) := by fun_prop
    have := ((hcoe.tendsto 1).comp h0).mono_left (comap_ιG_le_nhds_tauPrime F)
    rw [Circle.coe_one] at this
    exact this
  have hint : Tendsto (fun y : unitRing F => ∫ χ, ((χ y : Circle) : ℂ) ∂σ) (comap (ιG F) (𝓝 0))
      (𝓝 (∫ _χ, (1 : ℂ) ∂σ)) := by
    refine tendsto_integral_filter_of_dominated_convergence (fun _ => (1 : ℝ)) ?_ ?_ ?_ hpt
    · exact Eventually.of_forall fun y => (measurable_eval y).aestronglyMeasurable
    · exact Eventually.of_forall fun y => Eventually.of_forall fun χ => by simp
    · exact integrable_const _
  -- `σ univ = 1`, from the trace at `0`
  have h1 : (∫ _χ, (1 : ℂ) ∂σ) = 1 := by
    have h := hσ.2 0
    simp only [AddChar.map_zero_eq_one, Circle.coe_one] at h
    rw [h]
    simp [corr, tetra]
  rw [h1] at hint
  have hcorr : Tendsto (fun y => corr F μ.μ y) (comap (ιG F) (𝓝 0)) (𝓝 1) := by
    have := (Complex.continuous_re.tendsto 1).comp hint
    simpa [Function.comp_def, hσ.2] using this
  have hreal : Tendsto (fun y => (μ.μ {c | c 0 ≠ c y}).toReal) (comap (ιG F) (𝓝 0)) (𝓝 0) := by
    simp_rw [measure_ne_eq]
    have := (hcorr.const_sub 1).const_mul (3 / 4 : ℝ)
    simpa using this
  have hfin : ∀ y, μ.μ {c | c 0 ≠ c y} ≠ ⊤ := fun y => measure_ne_top _ _
  have := (ENNReal.tendsto_ofReal hreal)
  rw [ENNReal.ofReal_zero] at this
  refine this.congr fun y => ?_
  exact ENNReal.ofReal_toReal (hfin y)

end HadwigerNelson.Rigidity.Counting
