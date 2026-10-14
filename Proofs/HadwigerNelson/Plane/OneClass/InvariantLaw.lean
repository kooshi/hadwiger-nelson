import Proofs.HadwigerNelson.Plane.OneClass.Defs
import Mathlib.MeasureTheory.Constructions.BorelSpace.Basic
import Mathlib.Topology.Algebra.InfiniteSum.Basic
import Mathlib.Algebra.AlgebraicCard
import Mathlib.MeasureTheory.Measure.Portmanteau
import Mathlib.MeasureTheory.Measure.Prokhorov

/-!
# An invariant random independent set of the best density (FS-133)

The derivation's entry C133-INV-CLASS (`plans/FS133-E1-derivation.md`, stage 4), on `E → Bool`:

* `IsShiftInvariantLaw.measure_origin_le` — its step (1): a translation-invariant random independent set of **any**
  graph on the algebraic plane has density at most the graph's finitary independence ratio;
* `exists_foelner_finset` — a countable rational vector space has a Følner sequence of finite sets;
* `exists_shiftInvariant_of_foelner` — its step (2), for labellings: a limit of Følner averages of translates;
* `exists_turnInvariant` — its step (3), for labellings: a common fixed point of the rotations, in place of the
  Markov–Kakutani theorem;
* `exists_isInvariantLaw` — the entry: for a connection set `S` invariant under the algebraic rotations, an
  invariant random independent set of the Cayley graph of `S` whose density **is** the ratio.

The Cayley graph is Mathlib's `SimpleGraph.circulantGraph S`, which symmetrises `S` and drops `0`: the entry's
"`S ⊆ E ∖ {0}` symmetric" is not a hypothesis here. The two middle statements are about labellings in any finite
set, because C133-PAIR's step F1 uses them again.
-/

open MeasureTheory Filter Set
open scoped ENNReal Topology BoundedContinuousFunction

namespace HadwigerNelson.OneClass

open HadwigerNelson.Outside.OAI158 HadwigerNelson.Outside.OAI158.Spectral SimpleGraph

/-! ### Averages of measures, weak limits, and a common fixed point (private) -/

section Average

variable {X : Type*} [MeasurableSpace X]

/-- The uniform average of the measures `μ i`, `i ∈ s`. -/
private noncomputable def avgMeasure {ι : Type*} (s : Finset ι) (μ : ι → Measure X) : Measure X :=
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

end Average

/-- Translating a finite set moves a bounded sum over it by at most twice the bound times the number of points
translated out of the set. -/
private theorem abs_sum_add_sub_sum_le {A : Type*} [AddCommGroup A] (F : Finset A) (z : A) (h : A → ℝ) {M : ℝ}
    (hM : ∀ a, |h a| ≤ M) :
    |∑ r ∈ F, h (r + z) - ∑ r ∈ F, h r| ≤ 2 * M * ({a | a ∈ F ∧ a + z ∉ F}.ncard : ℝ) := by
  classical
  set F' : Finset A := F.map (addRightEmbedding z) with hF'
  have hsum : ∑ r ∈ F, h (r + z) = ∑ s ∈ F', h s := by
    rw [hF', Finset.sum_map]; rfl
  have hcard : F'.card = F.card := Finset.card_map _
  have hout : (F' \ F).card = {a | a ∈ F ∧ a + z ∉ F}.ncard := by
    have h1 : F' \ F = (F.filter fun a => a + z ∉ F).map (addRightEmbedding z) := by
      ext s
      simp only [hF', Finset.mem_sdiff, Finset.mem_map, Finset.mem_filter, addRightEmbedding_apply]
      constructor
      · rintro ⟨⟨a, ha, rfl⟩, hs⟩
        exact ⟨a, ⟨ha, hs⟩, rfl⟩
      · rintro ⟨a, ⟨ha, hs⟩, rfl⟩
        exact ⟨⟨a, ha, rfl⟩, hs⟩
    have h2 : {a | a ∈ F ∧ a + z ∉ F} = ((F.filter fun a => a + z ∉ F : Finset A) : Set A) := by
      ext a; simp
    rw [h1, Finset.card_map, h2, Set.ncard_coe_finset]
  have hbd : ∀ T : Finset A, |∑ s ∈ T, h s| ≤ T.card * M := fun T =>
    (Finset.abs_sum_le_sum_abs _ _).trans <| by
      simpa [nsmul_eq_mul] using Finset.sum_le_card_nsmul T (fun s => |h s|) M fun s _ => hM s
  rw [hsum, ← Finset.sum_sdiff_sub_sum_sdiff]
  have h3 := hbd (F' \ F)
  have h4 := hbd (F \ F')
  rw [Finset.card_sdiff_comm hcard.symm, hout] at h4
  rw [hout] at h3
  have h5 := abs_sub (∑ s ∈ F' \ F, h s) (∑ s ∈ F \ F', h s)
  linarith

section Weak

variable {X : Type*} [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X] [HasOuterApproxClosed X]

/-- A weak limit of probabilities that are asymptotically invariant under a continuous map is invariant. -/
private theorem map_eq_of_tendsto {ι : Type*} {L : Filter ι} [L.NeBot] {ν : ι → ProbabilityMeasure X}
    {Q : ProbabilityMeasure X} (hν : Tendsto ν L (𝓝 Q)) {g : X → X} (hg : Continuous g)
    (h : ∀ f : X →ᵇ ℝ,
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

/-- The measure of a clopen set is continuous along a weak limit. -/
private theorem tendsto_measure_of_isClopen {ι : Type*} {L : Filter ι} {ν : ι → ProbabilityMeasure X}
    {Q : ProbabilityMeasure X} (hν : Tendsto ν L (𝓝 Q)) {Z : Set X} (hZ : IsClopen Z) :
    Tendsto (fun i => (ν i : Measure X) Z) L (𝓝 ((Q : Measure X) Z)) :=
  ProbabilityMeasure.tendsto_measure_of_null_frontier_of_tendsto' hν (by rw [hZ.frontier_eq]; exact measure_empty)

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
          (fun s hs μ hμ => ⟨havg s hs μ fun k hk => ⟨(hμ k hk).1, (hμ k hk).2.1⟩, fun i hi => by
            rw [avgMeasure_map _ _ (hg i).measurable]
            unfold avgMeasure
            congr 1
            exact Finset.sum_congr rfl fun k hk => (hμ k hk).2.2 i hi⟩)
      refine ⟨Q, hQp, fun i hi => ?_⟩
      rcases Finset.mem_insert.1 hi with rfl | hi
      exacts [hQj, hQT i hi]
  obtain ⟨Q, hQp, hQ⟩ := hcl.isCompact.inter_iInter_nonempty
    (fun i => {Q : ProbabilityMeasure X | (Q : Measure X).map (g i) = Q}) hfix fun T => by
      obtain ⟨Q, hQp, hQT⟩ := hfin T
      exact ⟨Q, hQp, by simpa using hQT⟩
  exact ⟨Q, hQp, fun i => by simpa using mem_iInter.1 hQ i⟩

end Weak

/-- **C133-INV-CLASS, the upper bound** (step (1); any graph on the algebraic plane, translations only). -/
theorem IsShiftInvariantLaw.measure_origin_le {G : SimpleGraph E} {P : Measure (E → Bool)}
    (h : IsShiftInvariantLaw G P) : P {I | I 0 = true} ≤ G.finIndepRatio := by
  sorry

/-- The algebraic plane is countable (the release's `E_countable`; a theorem, not an instance: `E` is Mathlib's
type). -/
theorem countable_algPlane : Countable E := by
  apply Set.Countable.to_subtype
  have heq : (algebraicClosure ℚ ℂ : Set ℂ) = {x | IsAlgebraic ℚ x} := by
    ext z; exact mem_algebraicClosure_iff
  rw [heq]
  exact Algebraic.countable ℚ ℂ

/-- **A Følner sequence**: a countable rational vector space has finite nonempty sets `F n` such that, for every
`z`, the proportion of `F n` that `z` translates out of `F n` tends to `0`. -/
theorem exists_foelner_finset (A : Type*) [AddCommGroup A] [Module ℚ A] [Countable A] :
    ∃ F : ℕ → Finset A, (∀ n, (F n).Nonempty) ∧ ∀ z : A,
      Tendsto (fun n => ({a | a ∈ F n ∧ a + z ∉ F n}.ncard : ℝ) / (F n).card) atTop (𝓝 0) := by
  sorry

variable {Λ : Type*} [Finite Λ] [TopologicalSpace Λ] [DiscreteTopology Λ] [MeasurableSpace Λ]
  [MeasurableSingletonClass Λ]

omit [Finite Λ] [DiscreteTopology Λ] [MeasurableSpace Λ] [MeasurableSingletonClass Λ] in
private theorem continuous_shiftLab (z : E) : Continuous (shiftLab z : (E → Λ) → E → Λ) :=
  continuous_pi fun x => continuous_apply (x + z)

omit [Finite Λ] [DiscreteTopology Λ] [MeasurableSpace Λ] [MeasurableSingletonClass Λ] in
private theorem continuous_turnLab (u : K) : Continuous (turnLab u : (E → Λ) → E → Λ) :=
  continuous_pi fun x => continuous_apply (kCoeff u * x)

omit [Finite Λ] [MeasurableSpace Λ] [MeasurableSingletonClass Λ] in
private theorem isClopen_setOf_origin_eq (a : Λ) : IsClopen {ℓ : E → Λ | ℓ 0 = a} :=
  (isClopen_discrete {a}).preimage (continuous_apply (0 : E))

/-- **Følner averages of translates have an invariant limit** (step (2)). For a closed set `C` of labellings that
the translations preserve, labellings `ℓ n ∈ C` and a Følner sequence `F`: some translation-invariant probability
carried by `C` gives each label `a`, at the origin, at least any proportion `c` that `ℓ n` gives `a` on every
`F n`. -/
theorem exists_shiftInvariant_of_foelner {F : ℕ → Finset E} (hF : ∀ n, (F n).Nonempty)
    (hFz : ∀ z : E, Tendsto (fun n => ({a | a ∈ F n ∧ a + z ∉ F n}.ncard : ℝ) / (F n).card) atTop (𝓝 0))
    {C : Set (E → Λ)} (hC : IsClosed C) (hshift : ∀ z, MapsTo (shiftLab z) C C) (ℓ : ℕ → E → Λ)
    (hℓ : ∀ n, ℓ n ∈ C) :
    ∃ P : Measure (E → Λ), IsProbabilityMeasure P ∧ P Cᶜ = 0 ∧ (∀ z, P.map (shiftLab z) = P) ∧
      ∀ (a : Λ) (c : ℝ), (∀ n, c * (F n).card ≤ {r | r ∈ F n ∧ ℓ n r = a}.ncard) →
        ENNReal.ofReal c ≤ P {ℓ' | ℓ' 0 = a} := by
  classical
  haveI := countable_algPlane
  set μ : ℕ → Measure (E → Λ) := fun n => avgMeasure (F n) fun r => Measure.dirac (shiftLab r (ℓ n)) with hμ
  have hprob : ∀ n, IsProbabilityMeasure (μ n) := fun n =>
    isProbabilityMeasure_avgMeasure (hF n) fun r _ => Measure.dirac.isProbabilityMeasure
  set ν : ℕ → ProbabilityMeasure (E → Λ) := fun n => ⟨μ n, hprob n⟩ with hν
  obtain ⟨Q, -, hQ⟩ := isCompact_univ.ultrafilter_le_nhds ((Ultrafilter.of atTop).map ν) (by simp)
  have hlim : Tendsto ν ((Ultrafilter.of atTop : Ultrafilter ℕ) : Filter ℕ) (𝓝 Q) := hQ
  have hint : ∀ (n : ℕ) (f : (E → Λ) →ᵇ ℝ) (g : (E → Λ) → E → Λ),
      ∫ y, f (g y) ∂(ν n : Measure (E → Λ)) =
        ((F n).card : ℝ)⁻¹ * ∑ r ∈ F n, f (g (shiftLab r (ℓ n))) := by
    intro n f g
    have := integral_avgMeasure (F n) (μ := fun r => Measure.dirac (shiftLab r (ℓ n))) (f := fun y => f (g y))
      fun r _ => integrable_dirac (by simp)
    show ∫ y, f (g y) ∂avgMeasure (F n) (fun r => Measure.dirac (shiftLab r (ℓ n))) = _
    simpa using this
  refine ⟨Q, inferInstance, ?_, fun z => ?_, fun a c hc => ?_⟩
  · -- carried by `C`
    refine measure_compl_eq_zero_of_tendsto hlim hC (Eventually.of_forall fun n => ?_)
    show avgMeasure (F n) (fun r => Measure.dirac (shiftLab r (ℓ n))) Cᶜ = 0
    rw [avgMeasure_apply, Finset.sum_eq_zero, mul_zero]
    intro r _
    rw [Measure.dirac_apply' _ hC.measurableSet.compl, indicator_of_notMem]
    exact fun h => h (hshift r (hℓ n))
  · -- invariant under the translation by `z`
    refine map_eq_of_tendsto hlim (continuous_shiftLab z) fun f => ?_
    have hbound : ∀ n : ℕ,
        ‖∫ y, f (shiftLab z y) ∂(ν n : Measure (E → Λ)) - ∫ y, f y ∂(ν n : Measure (E → Λ))‖ ≤
          2 * ‖f‖ * (({a | a ∈ F n ∧ a + z ∉ F n}.ncard : ℝ) / (F n).card) := by
      intro n
      have e1 := hint n f id
      have e2 := hint n f (shiftLab z)
      simp only [id] at e1
      have e3 : ∀ r : E, shiftLab z (shiftLab r (ℓ n)) = shiftLab (r + z) (ℓ n) := fun r => by
        funext x
        show ℓ n (x + z + r) = ℓ n (x + (r + z))
        rw [add_assoc, add_comm z r]
      simp only [e3] at e2
      rw [e1, e2, ← mul_sub, Real.norm_eq_abs, abs_mul, abs_of_nonneg (by positivity : (0 : ℝ) ≤ ((F n).card : ℝ)⁻¹)]
      have := abs_sum_add_sub_sum_le (F n) z (fun r => f (shiftLab r (ℓ n))) (M := ‖f‖)
        fun a => f.norm_coe_le_norm _
      calc ((F n).card : ℝ)⁻¹ * |∑ r ∈ F n, f (shiftLab (r + z) (ℓ n)) - ∑ r ∈ F n, f (shiftLab r (ℓ n))|
          ≤ ((F n).card : ℝ)⁻¹ * (2 * ‖f‖ * ({a | a ∈ F n ∧ a + z ∉ F n}.ncard : ℝ)) :=
            mul_le_mul_of_nonneg_left this (by positivity)
        _ = 2 * ‖f‖ * (({a | a ∈ F n ∧ a + z ∉ F n}.ncard : ℝ) / (F n).card) := by ring
    have h0 : Tendsto (fun n : ℕ => 2 * ‖f‖ * (({a | a ∈ F n ∧ a + z ∉ F n}.ncard : ℝ) / (F n).card)) atTop
        (𝓝 0) := by
      simpa using (hFz z).const_mul (2 * ‖f‖)
    exact (squeeze_zero_norm hbound h0).mono_left (Ultrafilter.of_le atTop)
  · -- the label of the origin
    refine ge_of_tendsto' (tendsto_measure_of_isClopen hlim (isClopen_setOf_origin_eq a)) fun n => ?_
    show ENNReal.ofReal c ≤ avgMeasure (F n) (fun r => Measure.dirac (shiftLab r (ℓ n))) {ℓ' | ℓ' 0 = a}
    have hcard : (0 : ℝ) < (F n).card := by exact_mod_cast (hF n).card_pos
    have hset : {r | r ∈ F n ∧ ℓ n r = a} = ((F n).filter fun r => ℓ n r = a : Finset E) := by
      ext r; simp
    have hsum : ∑ r ∈ F n, Measure.dirac (shiftLab r (ℓ n)) {ℓ' : E → Λ | ℓ' 0 = a} =
        (((F n).filter fun r => ℓ n r = a).card : ℝ≥0∞) := by
      rw [Finset.card_filter, Nat.cast_sum]
      refine Finset.sum_congr rfl fun r _ => ?_
      rw [Measure.dirac_apply' _ (isClopen_setOf_origin_eq a).isOpen.measurableSet]
      by_cases h : ℓ n r = a
      · rw [indicator_of_mem (by show ℓ n (0 + r) = a; rwa [zero_add]), if_pos h]; simp
      · rw [indicator_of_notMem (by show ¬ ℓ n (0 + r) = a; rwa [zero_add]), if_neg h]; simp
    rw [avgMeasure_apply, hsum]
    have h1 : c ≤ (((F n).filter fun r => ℓ n r = a).card : ℝ) / (F n).card := by
      rw [le_div_iff₀ hcard]
      have := hc n
      rwa [hset, Set.ncard_coe_finset] at this
    calc ENNReal.ofReal c ≤ ENNReal.ofReal ((((F n).filter fun r => ℓ n r = a).card : ℝ) / (F n).card) :=
          ENNReal.ofReal_le_ofReal h1
      _ = ((F n).card : ℝ≥0∞)⁻¹ * (((F n).filter fun r => ℓ n r = a).card : ℝ≥0∞) := by
          rw [ENNReal.ofReal_div_of_pos hcard, ENNReal.ofReal_natCast, ENNReal.ofReal_natCast, div_eq_mul_inv,
            mul_comm]

/-- **The rotations have a common fixed point** (step (3), with no Markov–Kakutani theorem: the rotations are
countably many commuting continuous maps, and a Cesàro limit fixes one at a time). From a translation-invariant
probability carried by a closed set `C` that translations and rotations preserve: one invariant under both, carried
by `C`, with the same law of the label at the origin. -/
theorem exists_turnInvariant {C : Set (E → Λ)} (hC : IsClosed C) (hshift : ∀ z, MapsTo (shiftLab z) C C)
    (hturn : ∀ u, MapsTo (turnLab u) C C) {P₀ : Measure (E → Λ)} [IsProbabilityMeasure P₀] (h0 : P₀ Cᶜ = 0)
    (hinv : ∀ z, P₀.map (shiftLab z) = P₀) :
    ∃ P : Measure (E → Λ), IsProbabilityMeasure P ∧ P Cᶜ = 0 ∧ (∀ z, P.map (shiftLab z) = P) ∧
      (∀ u, P.map (turnLab u) = P) ∧ ∀ a, P {ℓ | ℓ 0 = a} = P₀ {ℓ | ℓ 0 = a} := by
  classical
  -- the proof does not read `hshift`: a rotation of a translation-invariant law is translation-invariant by the
  -- covariance alone, whatever its carrier
  have _ := hshift
  haveI := countable_algPlane
  have hmeas_shift : ∀ z : E, Measurable (shiftLab z : (E → Λ) → E → Λ) := fun z => (continuous_shiftLab z).measurable
  have hmeas_turn : ∀ u : K, Measurable (turnLab u : (E → Λ) → E → Λ) := fun u => (continuous_turnLab u).measurable
  have hZ : ∀ a : Λ, MeasurableSet {ℓ : E → Λ | ℓ 0 = a} := fun a => (isClopen_setOf_origin_eq a).isOpen.measurableSet
  suffices h : ∃ Q : ProbabilityMeasure (E → Λ),
      ((Q : Measure (E → Λ)) Cᶜ = 0 ∧ (∀ z, (Q : Measure (E → Λ)).map (shiftLab z) = Q) ∧
        ∀ a, (Q : Measure (E → Λ)) {ℓ | ℓ 0 = a} = P₀ {ℓ | ℓ 0 = a}) ∧
      ∀ u : K, (Q : Measure (E → Λ)).map (turnLab u) = Q by
    obtain ⟨Q, ⟨h1, h2, h3⟩, h4⟩ := h
    exact ⟨Q, inferInstance, h1, h2, h4, h3⟩
  refine exists_common_fixed
    (p := fun μ : Measure (E → Λ) => μ Cᶜ = 0 ∧ (∀ z, μ.map (shiftLab z) = μ) ∧
      ∀ a, μ {ℓ | ℓ 0 = a} = P₀ {ℓ | ℓ 0 = a})
    (g := fun u : K => (turnLab u : (E → Λ) → E → Λ)) ?_ ⟨⟨P₀, inferInstance⟩, h0, hinv, fun _ => rfl⟩
    continuous_turnLab ?_ ?_ ?_
  · -- the class is closed
    refine isClosed_setOf_of_tendsto (X := E → Λ)
      (p := fun μ : Measure (E → Λ) => μ Cᶜ = 0 ∧ (∀ z, μ.map (shiftLab z) = μ) ∧
        ∀ a, μ {ℓ | ℓ 0 = a} = P₀ {ℓ | ℓ 0 = a}) fun L hL Q hQ h => ?_
    haveI := hL
    refine ⟨measure_compl_eq_zero_of_tendsto hQ hC (h.mono fun P hP => hP.1), fun z =>
      map_eq_of_tendsto_of_eventually hQ (continuous_shiftLab z) (h.mono fun P hP => hP.2.1 z), fun a => ?_⟩
    exact tendsto_nhds_unique (tendsto_measure_of_isClopen hQ (isClopen_setOf_origin_eq a))
      (tendsto_const_nhds.congr' (h.mono fun P hP => (hP.2.2 a).symm))
  · -- the rotations commute
    intro u v
    funext ℓ x
    show ℓ (kCoeff v * (kCoeff u * x)) = ℓ (kCoeff u * (kCoeff v * x))
    rw [mul_left_comm]
  · -- a rotation keeps the class
    rintro u μ hμ ⟨hμC, hμs, hμa⟩
    refine ⟨?_, fun z => ?_, fun a => ?_⟩
    · rw [Measure.map_apply (hmeas_turn u) hC.measurableSet.compl]
      exact measure_mono_null (fun ℓ hℓ hℓC => hℓ (hturn u hℓC)) hμC
    · have hcov : (shiftLab z : (E → Λ) → E → Λ) ∘ turnLab u = turnLab u ∘ shiftLab (kCoeff u * z) := by
        funext ℓ x
        show ℓ (kCoeff u * (x + z)) = ℓ (kCoeff u * x + kCoeff u * z)
        rw [mul_add]
      rw [Measure.map_map (hmeas_shift z) (hmeas_turn u), hcov,
        ← Measure.map_map (hmeas_turn u) (hmeas_shift _), hμs]
    · rw [Measure.map_apply (hmeas_turn u) (hZ a), ← hμa a]
      congr 1
      ext ℓ
      show ℓ (kCoeff u * 0) = a ↔ ℓ 0 = a
      rw [mul_zero]
  · -- an average keeps the class
    intro s hs μ hμ
    refine ⟨?_, fun z => ?_, fun a => ?_⟩
    · rw [avgMeasure_apply, Finset.sum_eq_zero fun k hk => (hμ k hk).2.1, mul_zero]
    · rw [avgMeasure_map _ _ (hmeas_shift z)]
      unfold avgMeasure
      congr 1
      exact Finset.sum_congr rfl fun k hk => (hμ k hk).2.2.1 z
    · rw [avgMeasure_apply, Finset.sum_congr rfl fun k hk => (hμ k hk).2.2.2 a, Finset.sum_const, nsmul_eq_mul,
        ← mul_assoc, ENNReal.inv_mul_cancel (by simpa using hs.ne_empty) (ENNReal.natCast_ne_top _), one_mul]

/-- **An invariant probability on a closed invariant set of labellings** (C133-PAIR's step F1): a nonempty closed
set of labellings that the translations and the rotations preserve carries a probability invariant under both. -/
theorem exists_invariant_of_closed {C : Set (E → Λ)} (hC : IsClosed C) (hne : C.Nonempty)
    (hshift : ∀ z, MapsTo (shiftLab z) C C) (hturn : ∀ u, MapsTo (turnLab u) C C) :
    ∃ P : Measure (E → Λ), IsProbabilityMeasure P ∧ P Cᶜ = 0 ∧ (∀ z, P.map (shiftLab z) = P) ∧
      ∀ u, P.map (turnLab u) = P := by
  obtain ⟨ℓ₀, hℓ₀⟩ := hne
  haveI := countable_algPlane
  obtain ⟨F, hF, hFz⟩ := exists_foelner_finset E
  obtain ⟨P₀, hP₀, h0, hinv, -⟩ :=
    exists_shiftInvariant_of_foelner hF hFz hC hshift (fun _ => ℓ₀) (fun _ => hℓ₀)
  obtain ⟨P, hP, hPC, hs, ht, -⟩ := exists_turnInvariant hC hshift hturn h0 hinv
  exact ⟨P, hP, hPC, hs, ht⟩

/-- **C133-INV-CLASS.** For a set `S` of the algebraic plane invariant under the algebraic rotations, some
invariant random independent set of the Cayley graph of `S` has density equal to the graph's finitary independence
ratio. (With `IsShiftInvariantLaw.measure_origin_le`: no translation-invariant one has more.) -/
theorem exists_isInvariantLaw (S : Set E) (hS : ∀ u : K, ∀ s ∈ S, kCoeff u * s ∈ S) :
    ∃ P : Measure (E → Bool), IsInvariantLaw (circulantGraph S) P ∧
      P {I | I 0 = true} = (circulantGraph S).finIndepRatio := by
  sorry

/-- A rotation preserves the modulus of a point of the algebraic plane. -/
theorem norm_kCoeff_mul (u : K) (z : E) : ‖((kCoeff u * z : E) : ℂ)‖ = ‖(z : ℂ)‖ := by
  sorry

/-- The unit-distance graph of the algebraic plane is the Cayley graph of its unit circle. -/
theorem unitDistance_algPlane_eq_circulantGraph :
    unitDistance E = circulantGraph {z : E | ‖(z : ℂ)‖ = 1} := by
  sorry

/-- **C133-INV, as posed, with equality**: the unit-distance graph of the algebraic plane has an invariant random
independent set whose density is its finitary independence ratio. -/
theorem exists_isInvariantLaw_unitDistance :
    ∃ P : Measure (E → Bool), IsInvariantLaw (unitDistance E) P ∧
      P {I | I 0 = true} = (unitDistance E).finIndepRatio := by
  rw [unitDistance_algPlane_eq_circulantGraph]
  exact exists_isInvariantLaw _ fun u s hs => (norm_kCoeff_mul u s).trans hs

end HadwigerNelson.OneClass
