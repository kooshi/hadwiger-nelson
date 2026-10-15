import Proofs.HadwigerNelson.Rigidity.Herglotz
import Mathlib.MeasureTheory.Measure.Portmanteau

/-!
# The invariant measure on a closed invariant set of colourings (FS-131, job FS131-KR1; module M3; skeleton)

**Read aloud, against the informal claim.** For a subfield `F ⊆ ℝ` whose unit-vector ring `R = ℤ[U_F]` is countable, every
nonempty closed measurable set `K` of colourings `R → Fin 4`, stable under the shifts `c ↦ c(· + y)` and the rotations
`c ↦ c(u ·)`, carries a probability measure invariant under both: `invariantMeasureOnClosed_of_countable :
InvariantMeasureOnClosed F`, the library's `Prop` (`SpectralChain` l. 345), the headline's `hL1`. The printed route is
Markov–Kakutani twice (`[Kakutani1938]`, not held); this module reads no fixed-point theorem.

**The route (`plans/FS131-KR1-chain-map.md` § 2.2).** (1) `exists_shiftInvariant_on`: average the push-forwards of a point
mass at `c ∈ K` under the shifts with the almost-invariant probability weights `(w n)²` of `exists_almostInvariant_weights`;
a weak limit point on the compact metrizable space `unitRing F → Fin 4` is shift-invariant and, `K` being closed, carried by
`K`. (2) `exists_rotInvariant_of_shiftInvariant`: the same averaging over the countable abelian group of unit vectors acting
by rotations; `shift_y ∘ rot_u = rot_u ∘ shift_{u y}` keeps every average shift-invariant, and the limit is invariant under
both.

**Models.** `F = ⊥` (the rationals): `R` is countable, `K = X₄(⊥)` is nonempty (the plane over `ℚ` is two-colourable) and
closed, measurable and invariant (`SpectralChain.isClosed_X4`, `measurableSet_X4`, `shift_mem_X4`, `rot_mem_X4`).
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory SpectralChain

noncomputable section

-- The proofs follow FS133-IB1's route (`Plane/OneClass/InvariantLaw` on `main`, whose helpers are private there): a
-- Cesàro limit fixes one continuous map inside a closed class of probabilities, and compactness of the class fixes a
-- commuting family; no almost-invariant weights are read.

section Average

open scoped ENNReal

variable {X : Type*} [MeasurableSpace X]

/-- The uniform average of the measures `μ i`, `i ∈ s`. -/
private def avgMeasure {ι : Type*} (s : Finset ι) (μ : ι → Measure X) : Measure X :=
  (s.card : ℝ≥0∞)⁻¹ • ∑ i ∈ s, μ i

private theorem avgMeasure_apply {ι : Type*} (s : Finset ι) (μ : ι → Measure X) (A : Set X) :
    avgMeasure s μ A = (s.card : ℝ≥0∞)⁻¹ * ∑ i ∈ s, μ i A := by
  simp only [avgMeasure, Measure.smul_apply, Measure.coe_finsetSum, Finset.sum_apply, smul_eq_mul]

private theorem isProbabilityMeasure_avgMeasure {ι : Type*} {s : Finset ι} (hs : s.Nonempty) {μ : ι → Measure X}
    (hμ : ∀ i ∈ s, IsProbabilityMeasure (μ i)) : IsProbabilityMeasure (avgMeasure s μ) := by
  refine ⟨?_⟩
  rw [avgMeasure_apply, Finset.sum_congr rfl fun i hi => (hμ i hi).measure_univ, Finset.sum_const, nsmul_eq_mul,
    mul_one]
  exact ENNReal.inv_mul_cancel (by simpa using hs.ne_empty) (ENNReal.natCast_ne_top _)

private theorem avgMeasure_map {ι : Type*} (s : Finset ι) (μ : ι → Measure X) {g : X → X} (hg : Measurable g) :
    (avgMeasure s μ).map g = avgMeasure s fun i => (μ i).map g := by
  simp only [avgMeasure, ← Measure.mapₗ_apply_of_measurable hg, map_smul, map_sum]

private theorem integral_avgMeasure {ι : Type*} (s : Finset ι) {μ : ι → Measure X} {f : X → ℝ}
    (hf : ∀ i ∈ s, Integrable f (μ i)) :
    ∫ x, f x ∂avgMeasure s μ = (s.card : ℝ)⁻¹ * ∑ i ∈ s, ∫ x, f x ∂μ i := by
  rw [avgMeasure, integral_smul_measure, integral_finsetSum_measure hf, ENNReal.toReal_inv, ENNReal.toReal_natCast,
    smul_eq_mul]

/-- A null set stays null under a uniform average. -/
private theorem avgMeasure_eq_zero {ι : Type*} (s : Finset ι) {μ : ι → Measure X} {A : Set X}
    (h : ∀ i ∈ s, μ i A = 0) : avgMeasure s μ A = 0 := by
  rw [avgMeasure_apply, Finset.sum_eq_zero h, mul_zero]

/-- A uniform average of measures that one map fixes is fixed by it. -/
private theorem avgMeasure_map_eq {ι : Type*} (s : Finset ι) {μ : ι → Measure X} {g : X → X} (hg : Measurable g)
    (h : ∀ i ∈ s, (μ i).map g = μ i) : (avgMeasure s μ).map g = avgMeasure s μ := by
  rw [avgMeasure_map _ _ hg]
  unfold avgMeasure
  congr 1
  exact Finset.sum_congr rfl h

end Average

section Weak

open Filter Topology

variable {X : Type*} [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X] [HasOuterApproxClosed X]

/-- A weak limit of probabilities that are asymptotically invariant under a continuous map is invariant. -/
private theorem map_eq_of_tendsto {ι : Type*} {L : Filter ι} [L.NeBot] {ν : ι → ProbabilityMeasure X}
    {Q : ProbabilityMeasure X} (hν : Tendsto ν L (𝓝 Q)) {g : X → X} (hg : Continuous g)
    (h : ∀ f : BoundedContinuousFunction X ℝ,
      Tendsto (fun i => ∫ x, f (g x) ∂(ν i : Measure X) - ∫ x, f x ∂(ν i : Measure X)) L (𝓝 0)) :
    (Q : Measure X).map g = Q := by
  haveI : IsProbabilityMeasure ((Q : Measure X).map g) :=
    Measure.isProbabilityMeasure_map hg.measurable.aemeasurable
  refine ext_of_forall_integral_eq_of_IsFiniteMeasure fun f => ?_
  rw [integral_map hg.measurable.aemeasurable f.continuous.aestronglyMeasurable]
  have h1 := ProbabilityMeasure.tendsto_iff_forall_integral_tendsto.1 hν (f.compContinuous ⟨g, hg⟩)
  have h2 := ProbabilityMeasure.tendsto_iff_forall_integral_tendsto.1 hν f
  exact sub_eq_zero.1 (tendsto_nhds_unique (h1.sub h2) (h f))

/-- A weak limit of probabilities invariant under a continuous map is invariant. -/
private theorem map_eq_of_tendsto_of_eventually {ι : Type*} {L : Filter ι} [L.NeBot]
    {ν : ι → ProbabilityMeasure X} {Q : ProbabilityMeasure X} (hν : Tendsto ν L (𝓝 Q)) {g : X → X}
    (hg : Continuous g) (h : ∀ᶠ i in L, (ν i : Measure X).map g = ν i) : (Q : Measure X).map g = Q := by
  refine map_eq_of_tendsto hν hg fun f => tendsto_const_nhds.congr' (h.mono fun i hi => ?_)
  have h1 := integral_map (μ := (ν i : Measure X)) hg.measurable.aemeasurable
    (f := f) f.continuous.aestronglyMeasurable
  rw [hi] at h1
  show (0 : ℝ) = ∫ x, f (g x) ∂(ν i : Measure X) - ∫ x, f x ∂(ν i : Measure X)
  rw [← h1, sub_self]

/-- A weak limit of probabilities carried by a closed set is carried by it. -/
private theorem measure_compl_eq_zero_of_tendsto {ι : Type*} {L : Filter ι} [L.NeBot]
    {ν : ι → ProbabilityMeasure X} {Q : ProbabilityMeasure X} (hν : Tendsto ν L (𝓝 Q)) {C : Set X}
    (hC : IsClosed C) (h : ∀ᶠ i in L, (ν i : Measure X) Cᶜ = 0) : (Q : Measure X) Cᶜ = 0 := by
  rw [prob_compl_eq_zero_iff hC.measurableSet]
  refine le_antisymm prob_le_one ?_
  have h1 := ProbabilityMeasure.limsup_measure_closed_le_of_tendsto hν hC
  have h2 : limsup (fun i => (ν i : Measure X) C) L = 1 := by
    rw [limsup_congr (h.mono fun i hi => (prob_compl_eq_zero_iff hC.measurableSet).1 hi)]
    exact limsup_const 1
  rwa [h2] at h1

omit [HasOuterApproxClosed X] in
/-- A property of measures that passes to weak limits defines a closed set of probabilities. -/
private theorem isClosed_setOf_of_tendsto {p : Measure X → Prop}
    (h : ∀ (L : Filter (ProbabilityMeasure X)) (_ : L.NeBot) (Q : ProbabilityMeasure X), Tendsto id L (𝓝 Q) →
      (∀ᶠ P : ProbabilityMeasure X in L, p (P : Measure X)) → p (Q : Measure X)) :
    IsClosed {Q : ProbabilityMeasure X | p (Q : Measure X)} :=
  isClosed_iff_forall_filter.2 fun Q L hL hs hQ => h L hL Q hQ (le_principal_iff.1 hs)

variable [CompactSpace X] [T2Space X]

/-- **One map** (Krylov–Bogolyubov inside a closed class): a closed nonempty class of probabilities on a compact
space, stable under a continuous map and under finite uniform averages, holds a probability the map fixes. -/
private theorem exists_fixed_of_average {p : Measure X → Prop}
    (hcl : IsClosed {Q : ProbabilityMeasure X | p (Q : Measure X)})
    (hne : ∃ Q : ProbabilityMeasure X, p (Q : Measure X)) {g : X → X} (hg : Continuous g)
    (hmap : ∀ μ : Measure X, IsProbabilityMeasure μ → p μ → p (μ.map g))
    (havg : ∀ s : Finset ℕ, s.Nonempty → ∀ μ : ℕ → Measure X,
      (∀ k ∈ s, IsProbabilityMeasure (μ k) ∧ p (μ k)) → p (avgMeasure s μ)) :
    ∃ Q : ProbabilityMeasure X, p (Q : Measure X) ∧ (Q : Measure X).map g = Q := by
  obtain ⟨P, hP⟩ := hne
  have hit : ∀ k : ℕ, IsProbabilityMeasure ((P : Measure X).map g^[k]) ∧ p ((P : Measure X).map g^[k]) := by
    intro k
    induction k with
    | zero =>
      rw [Function.iterate_zero, Measure.map_id]
      exact ⟨inferInstance, hP⟩
    | succ k ih =>
      rw [Function.iterate_succ', ← Measure.map_map hg.measurable (hg.measurable.iterate k)]
      haveI := ih.1
      exact ⟨Measure.isProbabilityMeasure_map hg.measurable.aemeasurable, hmap _ ih.1 ih.2⟩
  set μ : ℕ → Measure X := fun k => (P : Measure X).map g^[k] with hμ
  have hprob : ∀ n : ℕ, IsProbabilityMeasure (avgMeasure (Finset.range (n + 1)) μ) := fun n =>
    isProbabilityMeasure_avgMeasure Finset.nonempty_range_add_one fun k _ => (hit k).1
  set ν : ℕ → ProbabilityMeasure X := fun n => ⟨avgMeasure (Finset.range (n + 1)) μ, hprob n⟩ with hν
  have hνp : ∀ n, p (ν n : Measure X) := fun n =>
    havg _ Finset.nonempty_range_add_one μ fun k _ => hit k
  obtain ⟨Q, -, hQ⟩ := isCompact_univ.ultrafilter_le_nhds ((Ultrafilter.of atTop).map ν) (by simp)
  have hlim : Tendsto ν ((Ultrafilter.of atTop : Ultrafilter ℕ) : Filter ℕ) (𝓝 Q) := hQ
  refine ⟨Q, hcl.mem_of_tendsto hlim (Eventually.of_forall hνp), map_eq_of_tendsto hlim hg fun f => ?_⟩
  -- the two integrals against the `n`-th average differ by a telescoping sum
  set a : ℕ → ℝ := fun k => ∫ x, f (g^[k] x) ∂(P : Measure X) with ha
  have hak : ∀ k, |a k| ≤ ‖f‖ := by
    intro k
    have := norm_integral_le_of_norm_le_const (μ := (P : Measure X)) (f := fun x => f (g^[k] x)) (C := ‖f‖)
      (Eventually.of_forall fun x => f.norm_coe_le_norm _)
    simpa using this
  have h1 : ∀ k, ∫ x, f x ∂μ k = a k := fun k =>
    integral_map (hg.measurable.iterate k).aemeasurable f.continuous.aestronglyMeasurable
  have h2 : ∀ k, ∫ x, f (g x) ∂μ k = a (k + 1) := fun k => by
    have := integral_map (μ := (P : Measure X)) (hg.measurable.iterate k).aemeasurable
      (f := fun x => f (g x)) (f.continuous.comp hg).aestronglyMeasurable
    rw [hμ, this, ha]
    simp only [Function.iterate_succ_apply']
  have hbound : ∀ n : ℕ,
      ‖∫ x, f (g x) ∂(ν n : Measure X) - ∫ x, f x ∂(ν n : Measure X)‖ ≤ 2 * ‖f‖ * (1 / ((n : ℝ) + 1)) := by
    intro n
    haveI := fun k => (hit k).1
    have e1 : ∫ x, f x ∂(ν n : Measure X) = ((n : ℝ) + 1)⁻¹ * ∑ k ∈ Finset.range (n + 1), a k := by
      have := integral_avgMeasure (Finset.range (n + 1)) (μ := μ) (f := f) fun k _ => f.integrable _
      show ∫ x, f x ∂avgMeasure (Finset.range (n + 1)) μ = _
      simpa [h1] using this
    have e2 : ∫ x, f (g x) ∂(ν n : Measure X) = ((n : ℝ) + 1)⁻¹ * ∑ k ∈ Finset.range (n + 1), a (k + 1) := by
      have := integral_avgMeasure (Finset.range (n + 1)) (μ := μ) (f := fun x => f (g x)) fun k _ =>
        (f.compContinuous ⟨g, hg⟩).integrable _
      show ∫ x, f (g x) ∂avgMeasure (Finset.range (n + 1)) μ = _
      simpa [h2] using this
    rw [e1, e2, ← mul_sub, ← Finset.sum_sub_distrib, Finset.sum_range_sub, Real.norm_eq_abs, abs_mul,
      abs_of_nonneg (by positivity : (0 : ℝ) ≤ ((n : ℝ) + 1)⁻¹), one_div, mul_comm]
    have := abs_sub (a (n + 1)) (a 0)
    have h3 := hak (n + 1)
    have h4 := hak 0
    exact mul_le_mul_of_nonneg_right (by linarith) (by positivity)
  have h0 : Tendsto (fun n : ℕ => 2 * ‖f‖ * (1 / ((n : ℝ) + 1))) atTop (𝓝 0) := by
    simpa using tendsto_one_div_add_atTop_nhds_zero_nat.const_mul (2 * ‖f‖)
  exact (squeeze_zero_norm hbound h0).mono_left (Ultrafilter.of_le atTop)

/-- **A common fixed point** (in place of the Markov–Kakutani theorem): a closed nonempty class of probabilities on
a compact space, stable under each of a family of commuting continuous maps and under finite uniform averages,
holds a probability that every map of the family fixes. -/
private theorem exists_common_fixed {ι : Type*} {p : Measure X → Prop}
    (hcl : IsClosed {Q : ProbabilityMeasure X | p (Q : Measure X)})
    (hne : ∃ Q : ProbabilityMeasure X, p (Q : Measure X)) {g : ι → X → X} (hg : ∀ i, Continuous (g i))
    (hcomm : ∀ i j, g i ∘ g j = g j ∘ g i)
    (hmap : ∀ i, ∀ μ : Measure X, IsProbabilityMeasure μ → p μ → p (μ.map (g i)))
    (havg : ∀ s : Finset ℕ, s.Nonempty → ∀ μ : ℕ → Measure X,
      (∀ k ∈ s, IsProbabilityMeasure (μ k) ∧ p (μ k)) → p (avgMeasure s μ)) :
    ∃ Q : ProbabilityMeasure X, p (Q : Measure X) ∧ ∀ i, (Q : Measure X).map (g i) = Q := by
  classical
  have hfix : ∀ i, IsClosed {Q : ProbabilityMeasure X | (Q : Measure X).map (g i) = Q} := fun i =>
    isClosed_setOf_of_tendsto (p := fun μ => μ.map (g i) = μ) fun L hL Q hQ h =>
      haveI := hL
      map_eq_of_tendsto_of_eventually hQ (hg i) h
  have hfin : ∀ T : Finset ι,
      ∃ Q : ProbabilityMeasure X, p (Q : Measure X) ∧ ∀ i ∈ T, (Q : Measure X).map (g i) = Q := by
    intro T
    induction T using Finset.induction_on with
    | empty =>
      obtain ⟨Q, hQ⟩ := hne
      exact ⟨Q, hQ, by simp⟩
    | insert j T _ ih =>
      have hclT : IsClosed {Q : ProbabilityMeasure X |
          p (Q : Measure X) ∧ ∀ i ∈ T, (Q : Measure X).map (g i) = Q} := by
        have : {Q : ProbabilityMeasure X | p (Q : Measure X) ∧ ∀ i ∈ T, (Q : Measure X).map (g i) = Q} =
            {Q : ProbabilityMeasure X | p (Q : Measure X)} ∩
              ⋂ i ∈ T, {Q : ProbabilityMeasure X | (Q : Measure X).map (g i) = Q} := by
          ext Q; simp
        rw [this]
        exact hcl.inter (isClosed_biInter fun i _ => hfix i)
      obtain ⟨Q, ⟨hQp, hQT⟩, hQj⟩ :=
        exists_fixed_of_average (p := fun μ => p μ ∧ ∀ i ∈ T, μ.map (g i) = μ) hclT ih (hg j)
          (fun μ hμ hpμ => ⟨hmap j μ hμ hpμ.1, fun i hi => by
            rw [Measure.map_map (hg i).measurable (hg j).measurable, hcomm i j,
              ← Measure.map_map (hg j).measurable (hg i).measurable, hpμ.2 i hi]⟩)
          (fun s hs μ hμ => ⟨havg s hs μ fun k hk => ⟨(hμ k hk).1, (hμ k hk).2.1⟩, fun i hi =>
            avgMeasure_map_eq s (hg i).measurable fun k hk => (hμ k hk).2.2 i hi⟩)
      refine ⟨Q, hQp, fun i hi => ?_⟩
      rcases Finset.mem_insert.1 hi with rfl | hi
      exacts [hQj, hQT i hi]
  obtain ⟨Q, hQp, hQ⟩ := hcl.isCompact.inter_iInter_nonempty
    (fun i => {Q : ProbabilityMeasure X | (Q : Measure X).map (g i) = Q}) hfix fun T => by
      obtain ⟨Q, hQp, hQT⟩ := hfin T
      exact ⟨Q, hQp, by simpa using hQT⟩
  exact ⟨Q, hQp, fun i => by simpa using Set.mem_iInter.1 hQ i⟩

end Weak

variable (F : Subfield ℝ)

/-! ### Private helpers: the shifts and the rotations of colourings -/

/-- The shift `c ↦ c(· + y)`. -/
private theorem continuous_shiftCol (y : unitRing F) :
    Continuous fun (c : unitRing F → Fin 4) (x : unitRing F) => c (x + y) :=
  continuous_pi fun x => continuous_apply (x + y)

/-- The rotation `c ↦ c(u ·)`. -/
private theorem continuous_rotCol (u : unitVectors F) :
    Continuous fun (c : unitRing F → Fin 4) (x : unitRing F) => c (uvRing u * x) :=
  continuous_pi fun x => continuous_apply (uvRing u * x)

/-- A map keeping `K` sends no measure carried by `K` off it. -/
private theorem map_compl_eq_zero {K : Set (unitRing F → Fin 4)} (hmeas : MeasurableSet K)
    {g : (unitRing F → Fin 4) → unitRing F → Fin 4} (hg : Measurable g) (hgK : ∀ c ∈ K, g c ∈ K)
    {μ : Measure (unitRing F → Fin 4)} (hμ : μ Kᶜ = 0) : (μ.map g) Kᶜ = 0 := by
  rw [Measure.map_apply hg hmeas.compl]
  exact measure_mono_null (fun c hc hcK => hc (hgK c hcK)) hμ

/-- **Step 1: a shift-invariant probability measure on `K`.** -/
theorem exists_shiftInvariant_on [Countable (unitRing F)] (K : Set (unitRing F → Fin 4)) (hne : K.Nonempty)
    (hcl : IsClosed K) (hmeas : MeasurableSet K) (hshift : ∀ y : unitRing F, ∀ c ∈ K, (fun x => c (x + y)) ∈ K) :
    ∃ μ : Measure (unitRing F → Fin 4), IsProbabilityMeasure μ ∧ μ Kᶜ = 0 ∧
      ∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ := by
  obtain ⟨c₀, hc₀⟩ := hne
  suffices h : ∃ Q : ProbabilityMeasure (unitRing F → Fin 4), (Q : Measure (unitRing F → Fin 4)) Kᶜ = 0 ∧
      ∀ y : unitRing F, (Q : Measure (unitRing F → Fin 4)).map (fun c x => c (x + y)) = Q by
    obtain ⟨Q, h1, h2⟩ := h
    exact ⟨Q, inferInstance, h1, h2⟩
  refine exists_common_fixed (p := fun μ : Measure (unitRing F → Fin 4) => μ Kᶜ = 0)
    (g := fun (y : unitRing F) (c : unitRing F → Fin 4) (x : unitRing F) => c (x + y)) ?_
    ⟨⟨Measure.dirac c₀, inferInstance⟩, ?_⟩ (continuous_shiftCol F) ?_ ?_ ?_
  · -- the class is closed
    refine isClosed_setOf_of_tendsto (p := fun μ : Measure (unitRing F → Fin 4) => μ Kᶜ = 0)
      fun L hL Q hQ h => ?_
    haveI := hL
    exact measure_compl_eq_zero_of_tendsto hQ hcl h
  · -- the point mass at `c₀ ∈ K`
    show (Measure.dirac c₀) Kᶜ = 0
    rw [Measure.dirac_apply' _ hmeas.compl, Set.indicator_of_notMem (Set.notMem_compl_iff.2 hc₀)]
  · -- the shifts commute
    intro y z
    funext c x
    show c (x + y + z) = c (x + z + y)
    rw [add_right_comm]
  · -- the shifts keep the class
    intro y μ _ hμ
    exact map_compl_eq_zero F hmeas (continuous_shiftCol F y).measurable (hshift y) hμ
  · -- so do the averages
    intro s _ μ hμ
    exact avgMeasure_eq_zero s fun k hk => (hμ k hk).2

/-- **Step 2: rotation averages of a shift-invariant measure on `K`.** -/
theorem exists_rotInvariant_of_shiftInvariant [Countable (unitRing F)] (K : Set (unitRing F → Fin 4))
    (hcl : IsClosed K) (hmeas : MeasurableSet K)
    (hrot : ∀ u : unitVectors F, ∀ c ∈ K, (fun x => c (uvRing u * x)) ∈ K)
    (μ₀ : Measure (unitRing F → Fin 4)) (h₀ : IsProbabilityMeasure μ₀) (hK₀ : μ₀ Kᶜ = 0)
    (hs₀ : ∀ y : unitRing F, μ₀.map (fun c x => c (x + y)) = μ₀) :
    ∃ μ : Measure (unitRing F → Fin 4), IsProbabilityMeasure μ ∧ μ Kᶜ = 0 ∧
      (∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ) ∧
      ∀ u : unitVectors F, μ.map (fun c x => c (uvRing u * x)) = μ := by
  suffices h : ∃ Q : ProbabilityMeasure (unitRing F → Fin 4),
      ((Q : Measure (unitRing F → Fin 4)) Kᶜ = 0 ∧
        ∀ y : unitRing F, (Q : Measure (unitRing F → Fin 4)).map (fun c x => c (x + y)) = Q) ∧
      ∀ u : unitVectors F, (Q : Measure (unitRing F → Fin 4)).map (fun c x => c (uvRing u * x)) = Q by
    obtain ⟨Q, ⟨h1, h2⟩, h3⟩ := h
    exact ⟨Q, inferInstance, h1, h2, h3⟩
  -- `shift_y ∘ rot_u = rot_u ∘ shift_{u y}`
  have hsr : ∀ (y : unitRing F) (u : unitVectors F),
      ((fun (c : unitRing F → Fin 4) (x : unitRing F) => c (x + y)) ∘
        fun (c : unitRing F → Fin 4) (x : unitRing F) => c (uvRing u * x)) =
      (fun (c : unitRing F → Fin 4) (x : unitRing F) => c (uvRing u * x)) ∘
        fun (c : unitRing F → Fin 4) (x : unitRing F) => c (x + uvRing u * y) := by
    intro y u
    funext c x
    show c (uvRing u * (x + y)) = c (uvRing u * x + uvRing u * y)
    rw [mul_add]
  refine exists_common_fixed
    (p := fun μ : Measure (unitRing F → Fin 4) => μ Kᶜ = 0 ∧
      ∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ)
    (g := fun (u : unitVectors F) (c : unitRing F → Fin 4) (x : unitRing F) => c (uvRing u * x)) ?_
    ⟨⟨μ₀, h₀⟩, hK₀, hs₀⟩ (continuous_rotCol F) ?_ ?_ ?_
  · -- the class is closed
    refine isClosed_setOf_of_tendsto (p := fun μ : Measure (unitRing F → Fin 4) => μ Kᶜ = 0 ∧
      ∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ) fun L hL Q hQ h => ?_
    haveI := hL
    exact ⟨measure_compl_eq_zero_of_tendsto hQ hcl (h.mono fun P hP => hP.1), fun y =>
      map_eq_of_tendsto_of_eventually hQ (continuous_shiftCol F y) (h.mono fun P hP => hP.2 y)⟩
  · -- the rotations commute
    intro u v
    funext c x
    show c (uvRing v * (uvRing u * x)) = c (uvRing u * (uvRing v * x))
    rw [mul_left_comm]
  · -- the rotations keep the class
    intro u μ _ hμ
    refine ⟨map_compl_eq_zero F hmeas (continuous_rotCol F u).measurable (hrot u) hμ.1, fun y => ?_⟩
    rw [Measure.map_map (continuous_shiftCol F y).measurable (continuous_rotCol F u).measurable, hsr y u,
      ← Measure.map_map (continuous_rotCol F u).measurable (continuous_shiftCol F _).measurable, hμ.2]
  · -- so do the averages
    intro s _ μ hμ
    exact ⟨avgMeasure_eq_zero s fun k hk => (hμ k hk).2.1, fun y =>
      avgMeasure_map_eq s (continuous_shiftCol F y).measurable fun k hk => (hμ k hk).2.2 y⟩

/-- **The invariant measure on a closed invariant set** (`[Kakutani1938]`'s conclusion, by averaging), for every subfield
whose unit-vector ring is countable — every number field (`SpectralChain.countable_unitRing`). -/
theorem invariantMeasureOnClosed_of_countable [Countable (unitRing F)] : InvariantMeasureOnClosed F := by
  intro K hne hcl hmeas hshift hrot
  obtain ⟨μ₀, h₀, hK₀, hs₀⟩ := exists_shiftInvariant_on F K hne hcl hmeas hshift
  exact exists_rotInvariant_of_shiftInvariant F K hcl hmeas hrot μ₀ h₀ hK₀ hs₀

end

end HadwigerNelson.Rigidity

#print axioms HadwigerNelson.Rigidity.invariantMeasureOnClosed_of_countable
#print axioms HadwigerNelson.Rigidity.exists_shiftInvariant_on
#print axioms HadwigerNelson.Rigidity.exists_rotInvariant_of_shiftInvariant
