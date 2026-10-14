import Proofs.HadwigerNelson.Rigidity.Herglotz
import Mathlib.MeasureTheory.Function.ContinuousMapDense
import Mathlib.Topology.ContinuousMap.StoneWeierstrass

/-! FS131-KM11 first leaf, priced in scratch: `exists_trigPoly_tendsto` (trigonometric polynomials are dense in `L²(σ)`).
`trigPoly` is restated here exactly as in `Rigidity/SpectralSubspace`. -/

namespace HadwigerNelson.Rigidity.KM11Scratch

open MeasureTheory SpectralChain SpectralInputs Filter Topology

noncomputable section

variable {R : Type*} [AddCommGroup R]

def trigPoly (a : R →₀ ℂ) (χ : AddChar R Circle) : ℂ :=
  Finsupp.linearCombination ℂ (fun y : R => ((χ y : Circle) : ℂ)) a

variable (R) in
/-- The evaluations, as continuous functions on the compact dual. -/
def evC (y : R) : C(AddChar R Circle, ℂ) := ⟨fun χ => ((χ y : Circle) : ℂ), continuous_evalChar R y⟩

theorem evC_add (y z : R) : evC R (y + z) = evC R y * evC R z := by
  ext χ
  simp [evC, AddChar.map_add_eq_mul]

theorem evC_zero : evC R 0 = 1 := by
  ext χ
  simp [evC]

theorem star_evC (y : R) : star (evC R y) = evC R (-y) := by
  ext χ
  simp only [evC, ContinuousMap.star_apply, ContinuousMap.coe_mk, AddChar.map_neg_eq_inv, Circle.coe_inv_eq_conj]
  rfl

variable (R) in
/-- The span of the evaluations, a star subalgebra of `C(R̂, ℂ)`. -/
def trigAlg : StarSubalgebra ℂ C(AddChar R Circle, ℂ) where
  carrier := Submodule.span ℂ (Set.range (evC R))
  mul_mem' {a b} ha hb := by
    induction ha using Submodule.span_induction with
    | mem x hx =>
      induction hb using Submodule.span_induction with
      | mem y hy =>
        obtain ⟨r, rfl⟩ := hx
        obtain ⟨s, rfl⟩ := hy
        rw [← evC_add]
        exact Submodule.subset_span ⟨r + s, rfl⟩
      | zero => rw [mul_zero]; exact Submodule.zero_mem _
      | add y z _ _ hy hz => rw [mul_add]; exact Submodule.add_mem _ hy hz
      | smul c y _ hy => rw [mul_smul_comm]; exact Submodule.smul_mem _ c hy
    | zero => rw [zero_mul]; exact Submodule.zero_mem _
    | add x y _ _ hx hy => rw [add_mul]; exact Submodule.add_mem _ hx hy
    | smul c x _ hx => rw [smul_mul_assoc]; exact Submodule.smul_mem _ c hx
  one_mem' := by
    rw [← evC_zero]
    exact Submodule.subset_span ⟨0, rfl⟩
  add_mem' := Submodule.add_mem _
  zero_mem' := Submodule.zero_mem _
  algebraMap_mem' c := by
    rw [Algebra.algebraMap_eq_smul_one, ← evC_zero]
    exact Submodule.smul_mem _ c (Submodule.subset_span ⟨0, rfl⟩)
  star_mem' {a} ha := by
    induction ha using Submodule.span_induction with
    | mem x hx =>
      obtain ⟨r, rfl⟩ := hx
      rw [star_evC]
      exact Submodule.subset_span ⟨-r, rfl⟩
    | zero => rw [star_zero]; exact Submodule.zero_mem _
    | add x y _ _ hx hy => rw [star_add]; exact Submodule.add_mem _ hx hy
    | smul c x _ hx => rw [star_smul]; exact Submodule.smul_mem _ _ hx

theorem trigAlg_separatesPoints : (trigAlg R).SeparatesPoints := by
  intro χ χ' hne
  have hr : ∃ r : R, χ r ≠ χ' r := by
    by_contra hall
    push Not at hall
    exact hne (AddChar.ext _ _ hall)
  obtain ⟨r, hr⟩ := hr
  exact ⟨evC R r, ⟨evC R r, Submodule.subset_span ⟨r, rfl⟩, rfl⟩, fun h => hr (Circle.ext h)⟩

/-- A trigonometric polynomial as a continuous function. -/
def trigC (a : R →₀ ℂ) : C(AddChar R Circle, ℂ) := Finsupp.linearCombination ℂ (evC R) a

theorem trigC_apply (a : R →₀ ℂ) (χ : AddChar R Circle) : trigC a χ = trigPoly a χ := by
  simp only [trigC, trigPoly, Finsupp.linearCombination_apply, Finsupp.sum, ContinuousMap.coe_sum, Finset.sum_apply,
    ContinuousMap.coe_smul, Pi.smul_apply, smul_eq_mul, evC, ContinuousMap.coe_mk]

/-- Uniform approximation by trigonometric polynomials (Stone–Weierstrass). -/
theorem exists_trigC_near [Countable R] (g : C(AddChar R Circle, ℂ)) {ε : ℝ} (hε : 0 < ε) :
    ∃ a : R →₀ ℂ, ‖trigC a - g‖ < ε := by
  have htop := ContinuousMap.starSubalgebra_topologicalClosure_eq_top_of_separatesPoints (trigAlg R)
    trigAlg_separatesPoints
  have hg : g ∈ (trigAlg R).topologicalClosure := by rw [htop]; trivial
  obtain ⟨p, hp, hdist⟩ := Metric.mem_closure_iff.mp hg ε hε
  obtain ⟨a, rfl⟩ := Finsupp.mem_span_range_iff_exists_finsupp.mp
    (show p ∈ Submodule.span ℂ (Set.range (evC R)) from hp)
  refine ⟨a, ?_⟩
  rw [← dist_eq_norm, dist_comm]
  exact hdist

/-- `‖F‖² = ∫ ‖F‖²` in `L²`. -/
theorem integral_norm_sq_eq {X : Type*} [MeasurableSpace X] {ν : Measure X} (F : Lp ℂ 2 ν) :
    ∫ x, ‖(F : X → ℂ) x‖ ^ 2 ∂ν = ‖F‖ ^ 2 := by
  rw [norm_sq_eq_re_inner (𝕜 := ℂ), MeasureTheory.L2.inner_def]
  have h : ∀ x, (inner ℂ ((F : X → ℂ) x) ((F : X → ℂ) x) : ℂ) = ((‖(F : X → ℂ) x‖ ^ 2 : ℝ) : ℂ) := fun x => by
    rw [inner_self_eq_norm_sq_to_K]; push_cast; rfl
  simp_rw [h]
  rw [integral_complex_ofReal]
  simp

/-- **The leaf.** -/
theorem exists_trigPoly_tendsto [Countable R] (σ : Measure (AddChar R Circle)) [IsFiniteMeasure σ]
    {A : Set (AddChar R Circle)} (hA : MeasurableSet A) :
    ∃ a : ℕ → (R →₀ ℂ), Tendsto (fun n => ∫ χ, ‖trigPoly (a n) χ - A.indicator 1 χ‖ ^ 2 ∂σ) atTop (𝓝 0) := by
  haveI : σ.WeaklyRegular := Measure.WeaklyRegular.of_pseudoMetrizableSpace_of_isFiniteMeasure σ
  haveI : Fact ((1 : ENNReal) ≤ 2) := ⟨by norm_num⟩
  set I : Lp ℂ 2 σ := indicatorConstLp 2 hA (measure_ne_top σ A) (1 : ℂ) with hI
  set L := (ContinuousMap.toLp (E := ℂ) 2 σ ℂ : C(AddChar R Circle, ℂ) →L[ℂ] Lp ℂ 2 σ) with hL
  have hdense : DenseRange L := ContinuousMap.toLp_denseRange ℂ σ ℂ (by norm_num)
  have hstep : ∀ n : ℕ, ∃ a : R →₀ ℂ, dist (L (trigC a)) I < 2 / (n + 1) := by
    intro n
    have hε : (0 : ℝ) < 1 / (n + 1) := by positivity
    obtain ⟨g, hg⟩ := hdense.exists_dist_lt I hε
    obtain ⟨a, ha⟩ := exists_trigC_near g (ε := 1 / (n + 1) / (‖L‖ + 1)) (by positivity)
    refine ⟨a, ?_⟩
    have h1 : dist (L (trigC a)) (L g) ≤ ‖L‖ * ‖trigC a - g‖ := by
      rw [dist_eq_norm, ← map_sub]
      exact L.le_opNorm _
    have h2 : ‖L‖ * ‖trigC a - g‖ ≤ 1 / (n + 1) := by
      have := mul_le_mul_of_nonneg_left ha.le (norm_nonneg L)
      refine this.trans ?_
      rw [mul_div_assoc']
      rw [div_le_iff₀ (by positivity)]
      nlinarith [norm_nonneg L, hε]
    calc dist (L (trigC a)) I ≤ dist (L (trigC a)) (L g) + dist (L g) I := dist_triangle _ _ _
      _ < 1 / (n + 1) + 1 / (n + 1) := by rw [dist_comm] at hg; linarith
      _ = 2 / (n + 1) := by ring
  choose a ha using hstep
  refine ⟨a, ?_⟩
  have hint : ∀ n, ∫ χ, ‖trigPoly (a n) χ - A.indicator 1 χ‖ ^ 2 ∂σ = dist (L (trigC (a n))) I ^ 2 := by
    intro n
    rw [dist_eq_norm, ← integral_norm_sq_eq]
    refine integral_congr_ae ?_
    filter_upwards [Lp.coeFn_sub (L (trigC (a n))) I, ContinuousMap.coeFn_toLp (E := ℂ) (p := 2) σ (𝕜 := ℂ) (trigC (a n)),
      indicatorConstLp_coeFn (p := 2) (hs := hA) (hμs := measure_ne_top σ A) (c := (1 : ℂ))] with χ h1 h2 h3
    rw [h1, Pi.sub_apply, h2, h3, trigC_apply]
    rfl
  simp_rw [hint]
  have hlim : Tendsto (fun n : ℕ => (2 / ((n : ℝ) + 1)) ^ 2) atTop (𝓝 0) := by
    have h := (tendsto_const_div_atTop_nhds_zero_nat (2 : ℝ)).comp (tendsto_add_atTop_nat 1)
    have h' : Tendsto (fun n : ℕ => 2 / ((n : ℝ) + 1)) atTop (𝓝 0) := by
      refine h.congr fun n => ?_
      simp
    simpa using h'.pow 2
  refine squeeze_zero (fun n => sq_nonneg _) (fun n => ?_) hlim
  exact pow_le_pow_left₀ dist_nonneg (ha n).le 2

end

end HadwigerNelson.Rigidity.KM11Scratch

#print axioms HadwigerNelson.Rigidity.KM11Scratch.exists_trigPoly_tendsto
