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
* `exists_foelner_finset` — a countable commutative group has a Følner sequence of finite sets;
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


/-! ### Almost-invariant finite sets (private) -/

/-- The points of a finite set that a translation moves out of it, counted as a `Finset`. -/
private theorem ncard_setOf_mem_and_add_notMem {A : Type*} [AddCommGroup A] [DecidableEq A] (F : Finset A)
    (z : A) : {a | a ∈ F ∧ a + z ∉ F}.ncard = (F.filter fun a => a + z ∉ F).card := by
  have h : {a | a ∈ F ∧ a + z ∉ F} = ((F.filter fun a => a + z ∉ F : Finset A) : Set A) := by
    ext a; simp
  rw [h, Set.ncard_coe_finset]

/-- **Polynomial growth gives almost-invariant sets.** In a commutative group, for finitely many `z` and `ε > 0`,
some finite nonempty `F` loses at most `ε · #F` of its points under the translation by each `z`: the images
`G N` of the boxes `[0, N]^Z` under `c ↦ ∑ c z • z` have at most `(N + 1)^#Z` points and `G N + z ⊆ G (N + 1)`,
so some step grows by a factor at most `1 + ε`. -/
private theorem exists_almost_invariant {A : Type*} [AddCommGroup A] (Z : Finset A) {ε : ℝ} (hε : 0 < ε) :
    ∃ F : Finset A, F.Nonempty ∧ ∀ z ∈ Z, ({a | a ∈ F ∧ a + z ∉ F}.ncard : ℝ) ≤ ε * F.card := by
  classical
  set φ : (Z → ℕ) → A := fun c => ∑ w : Z, c w • (w : A) with hφ
  set G : ℕ → Finset A := fun N => (Fintype.piFinset fun _ : Z => Finset.range (N + 1)).image φ with hGdef
  have hne : ∀ N, (G N).Nonempty := fun N =>
    ⟨φ 0, Finset.mem_image_of_mem _ (Fintype.mem_piFinset.2 fun _ => Finset.mem_range.2 (Nat.succ_pos N))⟩
  have hcard : ∀ N, (G N).card ≤ (N + 1) ^ Z.card := fun N =>
    Finset.card_image_le.trans (le_of_eq (by simp [Fintype.card_piFinset]))
  have hmono : ∀ N, G N ⊆ G (N + 1) := fun N =>
    Finset.image_subset_image (Fintype.piFinset_subset _ _ fun _ => Finset.range_mono (Nat.le_succ _))
  have hstep : ∀ N, ∀ z ∈ Z, ∀ a ∈ G N, a + z ∈ G (N + 1) := by
    intro N z hz a ha
    obtain ⟨c, hc, rfl⟩ := Finset.mem_image.1 ha
    refine Finset.mem_image.2 ⟨c + Pi.single ⟨z, hz⟩ 1, Fintype.mem_piFinset.2 fun w => ?_, ?_⟩
    · have h1 := Finset.mem_range.1 (Fintype.mem_piFinset.1 hc w)
      have h2 : (Pi.single (⟨z, hz⟩ : Z) 1 : Z → ℕ) w ≤ 1 := by
        by_cases h : w = ⟨z, hz⟩
        · rw [h, Pi.single_eq_same]
        · rw [Pi.single_eq_of_ne h]; exact Nat.zero_le 1
      exact Finset.mem_range.2 (by rw [Pi.add_apply]; omega)
    · simp only [hφ, Pi.add_apply, add_smul, Finset.sum_add_distrib]
      congr 1
      rw [Finset.sum_eq_single (⟨z, hz⟩ : Z) (fun w _ hw => by rw [Pi.single_eq_of_ne hw, zero_smul])
        (fun h => absurd (Finset.mem_univ _) h), Pi.single_eq_same, one_smul]
  -- some step grows by a factor at most `1 + ε`: otherwise `#G N ≥ (1 + ε)^N` against `#G N ≤ (N + 1)^#Z`
  have hgrow : ∃ N, ((G (N + 1)).card : ℝ) ≤ (1 + ε) * (G N).card := by
    by_contra hcon
    push Not at hcon
    have hexp : ∀ N, (1 + ε) ^ N ≤ ((G N).card : ℝ) := by
      intro N
      induction N with
      | zero =>
        rw [pow_zero]
        exact_mod_cast (hne 0).card_pos
      | succ N ih =>
        calc (1 + ε) ^ (N + 1) = (1 + ε) * (1 + ε) ^ N := pow_succ' _ _
          _ ≤ (1 + ε) * (G N).card := mul_le_mul_of_nonneg_left ih (by linarith)
          _ ≤ (G (N + 1)).card := (hcon N).le
    have hr : (1 : ℝ) < 1 + ε := by linarith
    have ht := tendsto_pow_const_div_const_pow_of_one_lt Z.card hr
    obtain ⟨N, hN⟩ := eventually_atTop.1 (ht.eventually (gt_mem_nhds (inv_pos.2 (by linarith : (0 : ℝ) < 1 + ε))))
    have h1 := hN (N + 1) (Nat.le_succ N)
    have h2 : (1 + ε) ^ N ≤ ((N + 1 : ℕ) : ℝ) ^ Z.card := (hexp N).trans (by exact_mod_cast hcard N)
    have hpos : (0 : ℝ) < (1 + ε) ^ (N + 1) := by positivity
    have h3 : (1 + ε)⁻¹ * (1 + ε) ^ (N + 1) = (1 + ε) ^ N := by
      rw [pow_succ']; field_simp
    rw [div_lt_iff₀ hpos, h3] at h1
    exact absurd h2 (not_le.2 h1)
  obtain ⟨N, hN⟩ := hgrow
  refine ⟨G N, hne N, fun z hz => ?_⟩
  rw [ncard_setOf_mem_and_add_notMem]
  have hinj : ((G N).filter fun a => a + z ∉ G N).card ≤ (G (N + 1) \ G N).card := by
    rw [← Finset.card_map (addRightEmbedding z)]
    refine Finset.card_le_card fun s hs => ?_
    obtain ⟨a, ha, rfl⟩ := Finset.mem_map.1 hs
    obtain ⟨ha1, ha2⟩ := Finset.mem_filter.1 ha
    exact Finset.mem_sdiff.2 ⟨hstep N z hz a ha1, ha2⟩
  have hsd : ((G (N + 1) \ G N).card : ℝ) = (G (N + 1)).card - (G N).card := by
    rw [Finset.card_sdiff_of_subset (hmono N), Nat.cast_sub (Finset.card_le_card (hmono N))]
  calc (((G N).filter fun a => a + z ∉ G N).card : ℝ) ≤ (G (N + 1) \ G N).card := by exact_mod_cast hinj
    _ = (G (N + 1)).card - (G N).card := hsd
    _ ≤ ε * (G N).card := by linarith

/-- A rotation is not the zero of the algebraic plane. -/
private theorem kCoeff_ne_zero' (u : K) : kCoeff u ≠ 0 := fun h =>
  Circle.coe_ne_zero u.val (congrArg (fun z : E => (z : ℂ)) h)

/-- **C133-INV-CLASS, the upper bound** (step (1); any graph on the algebraic plane, translations only). -/
theorem IsShiftInvariantLaw.measure_origin_le {G : SimpleGraph E} {P : Measure (E → Bool)}
    (h : IsShiftInvariantLaw G P) : P {I | I 0 = true} ≤ G.finIndepRatio := by
  classical
  haveI := h.prob
  have hT : ∀ g : E, MeasurableSet {I : E → Bool | I g = true} := fun g =>
    show MeasurableSet ((fun I : E → Bool => I g) ⁻¹' {true}) from
      measurable_pi_apply g (measurableSet_singleton true)
  have hshift : ∀ g : E, P {I | I g = true} = P {I | I 0 = true} := by
    intro g
    have hm : Measurable (shiftLab g : (E → Bool) → E → Bool) :=
      measurable_pi_lambda _ fun x => measurable_pi_apply _
    have h1 : P.map (shiftLab g) {I | I 0 = true} = P {I | I 0 = true} := by rw [h.shift g]
    rw [Measure.map_apply hm (hT 0)] at h1
    rw [← h1]
    congr 1
    ext I
    show I g = true ↔ I (0 + g) = true
    rw [zero_add]
  rw [SimpleGraph.le_finIndepRatio_iff]
  intro S _
  -- a largest independent subset `J` of `S`: the random set meets `S` in at most `#J` points
  obtain ⟨J, hJmem, hJmax⟩ := Finset.exists_max_image (S.powerset.filter fun J : Finset E => G.IsIndepSet (J : Set E))
    Finset.card ⟨∅, Finset.mem_filter.2 ⟨Finset.empty_mem_powerset S, by simp⟩⟩
  obtain ⟨hJS, hJ⟩ := Finset.mem_filter.1 hJmem
  refine ⟨J, Finset.mem_powerset.1 hJS, hJ, ?_⟩
  calc P {I | I 0 = true} * S.card = ∑ g ∈ S, P {I | I g = true} := by
        rw [Finset.sum_congr rfl fun g _ => hshift g, Finset.sum_const, nsmul_eq_mul, mul_comm]
    _ = ∫⁻ I, ∑ g ∈ S, ({I : E → Bool | I g = true}.indicator 1 I : ℝ≥0∞) ∂P := by
        rw [lintegral_finsetSum _ fun g _ => measurable_one.indicator (hT g)]
        exact Finset.sum_congr rfl fun g _ => (lintegral_indicator_one (hT g)).symm
    _ ≤ ∫⁻ _, (J.card : ℝ≥0∞) ∂P := by
        refine lintegral_mono_ae (h.indep.mono fun I hI => ?_)
        -- the sum counts the points of `S` in the random set
        have hsum : ∑ g ∈ S, ({I : E → Bool | I g = true}.indicator 1 I : ℝ≥0∞) =
            ((S.filter fun g => I g = true).card : ℝ≥0∞) := by
          rw [Finset.card_filter, Nat.cast_sum]
          refine Finset.sum_congr rfl fun g _ => ?_
          by_cases hg : I g = true
          · rw [indicator_of_mem (show I ∈ {I : E → Bool | I g = true} from hg), if_pos hg]; simp
          · rw [indicator_of_notMem (show I ∉ {I : E → Bool | I g = true} from hg), if_neg hg]; simp
        rw [hsum]
        exact_mod_cast hJmax _ (Finset.mem_filter.2 ⟨Finset.mem_powerset.2 (Finset.filter_subset _ S),
          Set.Pairwise.mono (fun g hg => (Finset.mem_filter.1 hg).2) hI⟩)
    _ = J.card := by rw [lintegral_const, measure_univ, mul_one]

/-- **A Følner sequence**: a countable commutative group has finite nonempty sets `F n` such that, for every `z`,
the proportion of `F n` that `z` translates out of `F n` tends to `0`. -/
theorem exists_foelner_finset (A : Type*) [AddCommGroup A] [Countable A] :
    ∃ F : ℕ → Finset A, (∀ n, (F n).Nonempty) ∧ ∀ z : A,
      Tendsto (fun n => ({a | a ∈ F n ∧ a + z ∉ F n}.ncard : ℝ) / (F n).card) atTop (𝓝 0) := by
  classical
  obtain ⟨e, he⟩ := exists_surjective_nat A
  choose F hFne hF using fun n : ℕ =>
    exists_almost_invariant ((Finset.range n).image e) (ε := 1 / ((n : ℝ) + 1)) (by positivity)
  refine ⟨F, hFne, fun z => ?_⟩
  obtain ⟨k, rfl⟩ := he z
  refine squeeze_zero' (Eventually.of_forall fun n => by positivity) ?_ tendsto_one_div_add_atTop_nhds_zero_nat
  filter_upwards [eventually_gt_atTop k] with n hn
  have hc : (0 : ℝ) < (F n).card := by exact_mod_cast (hFne n).card_pos
  rw [div_le_iff₀ hc]
  exact hF n (e k) (Finset.mem_image_of_mem e (Finset.mem_range.2 hn))

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
commuting continuous maps, a Cesàro limit fixes one at a time, and compactness fixes them all). From a
translation-invariant probability carried by a closed set `C` that the rotations preserve: one invariant under
both, carried by `C`, with the same law of the label at the origin. (That the translations preserve `C` is not
asked: a rotation of a translation-invariant law is translation-invariant by the covariance alone.) -/
theorem exists_turnInvariant {C : Set (E → Λ)} (hC : IsClosed C)
    (hturn : ∀ u, MapsTo (turnLab u) C C) {P₀ : Measure (E → Λ)} [IsProbabilityMeasure P₀] (h0 : P₀ Cᶜ = 0)
    (hinv : ∀ z, P₀.map (shiftLab z) = P₀) :
    ∃ P : Measure (E → Λ), IsProbabilityMeasure P ∧ P Cᶜ = 0 ∧ (∀ z, P.map (shiftLab z) = P) ∧
      (∀ u, P.map (turnLab u) = P) ∧ ∀ a, P {ℓ | ℓ 0 = a} = P₀ {ℓ | ℓ 0 = a} := by
  classical
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
  obtain ⟨P, hP, hPC, hs, ht, -⟩ := exists_turnInvariant hC hturn h0 hinv
  exact ⟨P, hP, hPC, hs, ht⟩

/-- **C133-INV-CLASS.** For a set `S` of the algebraic plane invariant under the algebraic rotations, some
invariant random independent set of the Cayley graph of `S` has density equal to the graph's finitary independence
ratio. (With `IsShiftInvariantLaw.measure_origin_le`: no translation-invariant one has more.) -/
theorem exists_isInvariantLaw (S : Set E) (hS : ∀ u : K, ∀ s ∈ S, kCoeff u * s ∈ S) :
    ∃ P : Measure (E → Bool), IsInvariantLaw (circulantGraph S) P ∧
      P {I | I 0 = true} = (circulantGraph S).finIndepRatio := by
  classical
  haveI := countable_algPlane
  set G : SimpleGraph E := circulantGraph S with hG
  set C : Set (E → Bool) := {I | G.IsIndepSet {z | I z = true}} with hCdef
  have hC : IsClosed C := by
    have : C = ⋂ a, ⋂ b, {I : E → Bool | I a = true → I b = true → a ≠ b → ¬ G.Adj a b} := by
      ext I
      simp only [hCdef, mem_setOf_eq, mem_iInter, SimpleGraph.IsIndepSet, Set.Pairwise]
      exact ⟨fun h x y hx hy => h hx hy, fun h x hx y hy => h x y hx hy⟩
    rw [this]
    exact isClosed_iInter fun a => isClosed_iInter fun b =>
      show IsClosed ((fun I : E → Bool => (I a, I b)) ⁻¹'
        {p : Bool × Bool | p.1 = true → p.2 = true → a ≠ b → ¬ G.Adj a b}) from
      (isClosed_discrete _).preimage ((continuous_apply a).prodMk (continuous_apply b))
  have hshift : ∀ z, MapsTo (shiftLab z) C C := by
    intro z I hI
    show Set.Pairwise {x | I (x + z) = true} fun v w => ¬ G.Adj v w
    intro x hx y hy hxy hadj
    refine hI (show I (x + z) = true from hx) (show I (y + z) = true from hy)
      (fun h => hxy (add_right_cancel h)) ?_
    rw [hG, circulantGraph_adj] at hadj ⊢
    refine ⟨fun h => hxy (add_right_cancel h), ?_⟩
    rw [add_sub_add_right_eq_sub, add_sub_add_right_eq_sub]
    exact hadj.2
  have hturn : ∀ u, MapsTo (turnLab u) C C := by
    intro u I hI
    show Set.Pairwise {x | I (kCoeff u * x) = true} fun v w => ¬ G.Adj v w
    intro x hx y hy hxy hadj
    have hne : kCoeff u * x ≠ kCoeff u * y := fun h => hxy (mul_left_cancel₀ (kCoeff_ne_zero' u) h)
    refine hI (show I (kCoeff u * x) = true from hx) (show I (kCoeff u * y) = true from hy) hne ?_
    rw [hG, circulantGraph_adj] at hadj ⊢
    refine ⟨hne, ?_⟩
    rw [← mul_sub, ← mul_sub]
    exact hadj.2.imp (hS u _) (hS u _)
  obtain ⟨F, hF, hFz⟩ := exists_foelner_finset E
  choose J hJF hJind hJcard using fun n => (G.le_finIndepRatio_iff.1 le_rfl) (F n) (hF n)
  set ℓ : ℕ → E → Bool := fun n x => decide (x ∈ J n) with hℓ
  have hset : ∀ n, {z : E | ℓ n z = true} = (J n : Set E) := fun n => by
    ext z; simp [hℓ]
  have hℓC : ∀ n, ℓ n ∈ C := fun n => by
    show G.IsIndepSet {z | ℓ n z = true}
    rw [hset]
    exact hJind n
  have hr : G.finIndepRatio ≠ ⊤ := by
    intro htop
    have h1 := hJcard 0
    rw [htop, ENNReal.top_mul (by simpa using (hF 0).ne_empty)] at h1
    exact ENNReal.natCast_ne_top _ (top_le_iff.1 h1)
  obtain ⟨P₀, hP₀, h0, hinv, hlab⟩ := exists_shiftInvariant_of_foelner hF hFz hC hshift ℓ hℓC
  have hge : G.finIndepRatio ≤ P₀ {I | I 0 = true} := by
    have h1 := hlab true G.finIndepRatio.toReal fun n => by
      have hsub : {r | r ∈ F n ∧ ℓ n r = true} = (J n : Set E) := by
        ext r
        simp only [hℓ, mem_setOf_eq, decide_eq_true_eq, Finset.mem_coe]
        exact ⟨fun h => h.2, fun h => ⟨hJF n h, h⟩⟩
      rw [hsub, Set.ncard_coe_finset]
      have h2 := ENNReal.toReal_mono (ENNReal.natCast_ne_top _) (hJcard n)
      simpa [ENNReal.toReal_mul] using h2
    rwa [ENNReal.ofReal_toReal hr] at h1
  haveI := hP₀
  obtain ⟨P, hP, hPC, hPs, hPt, hPlab⟩ := exists_turnInvariant hC hturn h0 hinv
  have hlaw : IsInvariantLaw G P :=
    { prob := hP
      indep := by
        filter_upwards [measure_eq_zero_iff_ae_notMem.1 hPC] with I hI
        exact not_not.1 hI
      shift := hPs
      turn := hPt }
  refine ⟨P, hlaw, le_antisymm hlaw.toIsShiftInvariantLaw.measure_origin_le ?_⟩
  rw [hPlab true]
  exact hge

/-- A rotation preserves the modulus of a point of the algebraic plane. -/
theorem norm_kCoeff_mul (u : K) (z : E) : ‖((kCoeff u * z : E) : ℂ)‖ = ‖(z : ℂ)‖ := by
  show ‖((u.val : Circle) : ℂ) * (z : ℂ)‖ = ‖(z : ℂ)‖
  rw [norm_mul, Circle.norm_coe, one_mul]

/-- The unit-distance graph of the algebraic plane is the Cayley graph of its unit circle. -/
theorem unitDistance_algPlane_eq_circulantGraph :
    unitDistance E = circulantGraph {z : E | ‖(z : ℂ)‖ = 1} := by
  ext a b
  have hd : dist a b = ‖((a - b : E) : ℂ)‖ := by
    rw [Subtype.dist_eq, dist_eq_norm]
    rfl
  have hrev : ‖((b - a : E) : ℂ)‖ = ‖((a - b : E) : ℂ)‖ := by
    show ‖(b : ℂ) - (a : ℂ)‖ = ‖(a : ℂ) - (b : ℂ)‖
    exact norm_sub_rev _ _
  rw [unitDistance_adj, circulantGraph_adj, hd]
  simp only [mem_setOf_eq, hrev, or_self]
  refine ⟨fun h => ⟨?_, h⟩, fun h => h.2⟩
  rintro rfl
  rw [sub_self] at h
  simp at h

/-- **C133-INV, as posed, with equality**: the unit-distance graph of the algebraic plane has an invariant random
independent set whose density is its finitary independence ratio. -/
theorem exists_isInvariantLaw_unitDistance :
    ∃ P : Measure (E → Bool), IsInvariantLaw (unitDistance E) P ∧
      P {I | I 0 = true} = (unitDistance E).finIndepRatio := by
  rw [unitDistance_algPlane_eq_circulantGraph]
  exact exists_isInvariantLaw _ fun u s hs => (norm_kCoeff_mul u s).trans hs

end HadwigerNelson.OneClass
