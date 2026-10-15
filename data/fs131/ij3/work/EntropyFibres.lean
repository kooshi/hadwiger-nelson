import Proofs.HadwigerNelson.Rigidity.Entropy
import Mathlib.Topology.Algebra.Group.Quotient
import Mathlib.MeasureTheory.Constructions.BorelSpace.Basic
import Mathlib.Logic.Equiv.Fin.Basic
import Mathlib.MeasureTheory.Measure.Count

/-!
# Entropy under powers, finite mixtures and finite-fibred factors (FS-131, job FS131-KN9; skeleton)

**What this module is for.** The deduction of `[EinsiedlerLindenstrauss2022]` Theorem 1.2 from its Theorem 1.3
(FS105-DED, `plans/FS105-D-deduction.md` § 2.1, [hand], two minds) reads three facts about the entropy of a map, its classical
inputs C4–C6 there (§ 2.2). Each is stated here in the form the deduction reads, over `Rigidity.ksEntropy` (the infimum form),
and each has an elementary route that needs no conditional measure:

* **C6, Abramov's power formula, in the direction read** (`ksEntropy_eq_zero_of_iterate`): if `T^q` has entropy zero for
  some `q ≥ 1`, so has `T`. The names of `T` of length `q·n` are the names of `T^q` of length `n` for the block label
  (`blockLabel`, `blockEntropy_iterate`), and with the infimum form this needs no invariance of the measure.
* **C5, affinity, in the direction read** (`ksEntropy_finite_mixture_eq_zero`): a uniform finite mixture of invariant
  probability measures of entropy zero has entropy zero — the chain's mixture lemma `Rigidity.ksEntropy_bind_eq_zero` at the
  uniform measure on `Fin J`.
* **C4, Abramov–Rokhlin, in the case read** (`ksEntropy_eq_zero_iff_of_finite`): over a factor by a finite subgroup `G` of a
  compact group, entropy zero on `X ⧸ G` gives entropy zero on `X`. **No Abramov–Rokhlin formula and no disintegration**: a
  finite measurable partition `Q` meeting each coset of `G` in at most one point (`exists_sectionPartition`) and the
  *pattern* of a partition `P` on the cosets (`exists_pattern_names_le`) make the names of `P` a function of the time-zero
  cell of `Q` and the names of the pattern; so `H_n(P) ≤ H_n(pattern) + log |Q|`, and the pattern is a partition of the
  factor.

**The σ-algebra on `X ⧸ G`** in `ksEntropy_eq_zero_iff_of_finite` is the Borel one, as in clause (4) of the declared
`Rigidity.positive_entropy_rigidity` and on its page: the projection is an open embedding on each translate of a small
open set, so the section partition's cells carry Borel sets to Borel sets (`exists_sectionPartition`), and the step needs
no Lusin–Souslin and no `PolishSpace`. **So the deduction of Theorem 1.2 needs no `PolishSpace`**: `Rigidity.haar_or_zero_entropy`
takes none since FS131-KN9 (the coordinator's ruling of 2026-10-14), and its proof reads the declared axiom's clause (4)
as stated. No form over Mathlib's quotient σ-algebra is stated: nothing reads one.

**Inhabitants.** The finite-fibred step's hypotheses: `finFour_fibre_model` (`ℤ/4`, the subgroup `{0, 2}`, the identity, the
uniform probability). The power and the mixture take a measurable map and invariant probability measures: the point mass
and the identity are a model of both, and `Rigidity/PositiveEntropy` reads them at the declared theorem's components. The
block label has a concrete check (an `example`). The plan per leaf: `plans/FS131-KN9-chain-zero-entropy.md` § Stage 2.
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory

open scoped ENNReal

variable {X : Type*}

/-! ## C6 in the direction read: entropy zero passes from `T^q` to `T` -/

/-- **The block label of length `q`**: the word `(P x, P (T x), …, P (T^[q-1] x))`, as one letter of `Fin (k ^ q)`. The names
of `T^[q]` for it are the names of `T` read in blocks of `q` (`blockEntropy_iterate`). -/
def blockLabel {k : ℕ} (T : X → X) (P : X → Fin k) (q : ℕ) (x : X) : Fin (k ^ q) :=
  finFunctionFinEquiv fun i : Fin q => P (T^[i] x)

-- The block label of `(x mod 2)` along `x ↦ x + 1`, read for two steps from `0`: the word `(0, 1)`, the letter `0 + 1·2`.
example : blockLabel Nat.succ (fun x => (⟨x % 2, Nat.mod_lt _ two_pos⟩ : Fin 2)) 2 0 = 2 := by decide

/-- The block label is measurable when the map and the label map are. -/
theorem measurable_blockLabel {m : MeasurableSpace X} {k : ℕ} {T : X → X} (hT : Measurable T) {P : X → Fin k}
    (hP : Measurable P) (q : ℕ) : Measurable (blockLabel T P q) :=
  (measurable_of_countable _).comp (measurable_pi_lambda _ fun i => hP.comp (hT.iterate i))

/-- **The names of `T^[q]` for the block label are the names of `T` of length `q·n`**: the two families of cells are one
family, re-indexed by the equivalence of words `(Fin (q·n) → Fin k) ≃ (Fin n → Fin (k ^ q))`. For every measure. -/
theorem blockEntropy_iterate {m : MeasurableSpace X} (μ : Measure X) {k : ℕ} (T : X → X) (P : X → Fin k) (q n : ℕ) :
    blockEntropy μ (T^[q]) (blockLabel T P q) n = blockEntropy μ T P (q * n) := by
  -- the words of length `q·n` and the words of `n` blocks of length `q`
  let e₁ : Fin n × Fin q ≃ Fin (q * n) := finProdFinEquiv.trans (finCongr (Nat.mul_comm n q))
  let e : (Fin (q * n) → Fin k) ≃ (Fin n → Fin (k ^ q)) :=
    (e₁.arrowCongr (Equiv.refl (Fin k))).symm.trans
      ((Equiv.curry (Fin n) (Fin q) (Fin k)).trans (Equiv.piCongrRight fun _ => finFunctionFinEquiv))
  have he₁ : ∀ (j : Fin n) (i : Fin q), ((e₁ (j, i) : Fin (q * n)) : ℕ) = i + q * j := fun j i => rfl
  have hname : ∀ x, Outside.OAI015.orbitName (T^[q]) (blockLabel T P q) n x =
      e (Outside.OAI015.orbitName T P (q * n) x) := by
    intro x
    funext j
    simp only [Outside.OAI015.orbitName, blockLabel, e, Equiv.trans_apply, Equiv.piCongrRight_apply,
      Equiv.curry_apply]
    congr 1
    funext i
    show P (T^[i] (T^[q]^[j] x)) = Outside.OAI015.orbitName T P (q * n) x (e₁ (j, i))
    simp only [Outside.OAI015.orbitName]
    rw [he₁, Function.iterate_add_apply, Function.iterate_mul]
  rw [blockEntropy_eq_observationEntropy, blockEntropy_eq_observationEntropy]
  rw [show Outside.OAI015.orbitName (T^[q]) (blockLabel T P q) n =
    fun x => e (Outside.OAI015.orbitName T P (q * n) x) from funext hname]
  exact Outside.OAI015.observationEntropy_equiv μ _ e

/-- **C6, in the direction the deduction reads** (FS105-DED, step B3): if `T^[q]` has entropy zero for some `q ≥ 1`, so has
`T`. With the infimum form no invariance is read: `h_μ(T, P) ≤ H_{q(n+1)}(T, P)/(q(n+1)) ≤ H_{n+1}(T^q, P^{(q)})/(n+1)` for
every `n`, the second step because `H ≥ 0` or both sides vanish under `ENNReal.ofReal`. -/
theorem ksEntropy_eq_zero_of_iterate {m : MeasurableSpace X} (μ : Measure X) {T : X → X} (hT : Measurable T) {q : ℕ}
    (hq : 0 < q) (h : ksEntropy μ (T^[q]) = 0) : ksEntropy μ T = 0 := by
  rw [ksEntropy_eq_zero_iff] at h ⊢
  intro k P hP
  have h0 := h (k ^ q) (blockLabel T P q) (measurable_blockLabel hT hP q)
  refine le_antisymm ?_ zero_le
  rw [← h0]
  refine le_iInf fun n => ?_
  have hpos : 0 < q * (n + 1) := Nat.mul_pos hq n.succ_pos
  have h1 := partitionEntropy_le μ T P (q * (n + 1) - 1)
  have hidx : q * (n + 1) - 1 + 1 = q * (n + 1) := Nat.sub_add_cancel hpos
  have hden : ((q * (n + 1) - 1 : ℕ) : ℝ) + 1 = (q : ℝ) * (n + 1) := by
    have : (((q * (n + 1) - 1 + 1 : ℕ)) : ℝ) = ((q * (n + 1) : ℕ) : ℝ) := by rw [hidx]
    push_cast at this
    linarith
  rw [hidx, hden, ← blockEntropy_iterate] at h1
  refine h1.trans ?_
  set a := blockEntropy μ (T^[q]) (blockLabel T P q) (n + 1)
  have hq1 : (1 : ℝ) ≤ q := by exact_mod_cast hq
  have hn1 : (0 : ℝ) < n + 1 := by positivity
  rcases le_or_gt 0 a with ha | ha
  · refine ENNReal.ofReal_le_ofReal (div_le_div_of_nonneg_left ha hn1 ?_)
    nlinarith
  · rw [ENNReal.ofReal_of_nonpos (div_nonpos_of_nonpos_of_nonneg ha.le (by positivity))]
    exact zero_le

/-! ## C5 in the direction read: a finite mixture -/

/-- **C5, in the direction the deduction reads** (FS105-DED, step B2): the uniform mixture `J⁻¹ (ν 1 + … + ν J)` of
`T`-invariant probability measures of entropy zero has entropy zero. Route: `Rigidity.ksEntropy_bind_eq_zero` with the
uniform probability on `Fin J` and the kernel `j ↦ ν j`; at `J = 0` the measure is `0` (`ksEntropy_zero_measure`). -/
theorem ksEntropy_finite_mixture_eq_zero {m : MeasurableSpace X} {J : ℕ} (ν : Fin J → Measure X)
    (hν : ∀ j, IsProbabilityMeasure (ν j)) {T : X → X} (hT : Measurable T)
    (hpres : ∀ j, MeasurePreserving T (ν j) (ν j)) (hzero : ∀ j, ksEntropy (ν j) T = 0) :
    ksEntropy ((J : ℝ≥0∞)⁻¹ • ∑ j, ν j) T = 0 := by
  rcases Nat.eq_zero_or_pos J with hJ | hJ
  · subst hJ
    simp
  -- the uniform probability on `Fin J`, and the kernel `j ↦ ν j`
  let κ : ProbabilityTheory.Kernel (Fin J) X := ProbabilityTheory.Kernel.ofFunOfCountable ν
  haveI : ProbabilityTheory.IsMarkovKernel κ := ⟨fun j => hν j⟩
  set τ : Measure (Fin J) := (J : ℝ≥0∞)⁻¹ • Measure.count with hτ
  have hJ0 : (J : ℝ≥0∞) ≠ 0 := by exact_mod_cast hJ.ne'
  haveI : IsProbabilityMeasure τ := ⟨by
    rw [hτ, Measure.smul_apply, Measure.count_univ, smul_eq_mul, ENat.card_eq_coe_fintype_card,
      Fintype.card_fin]
    exact ENNReal.inv_mul_cancel hJ0 (ENNReal.natCast_ne_top J)⟩
  have hbind : τ.bind κ = (J : ℝ≥0∞)⁻¹ • ∑ j, ν j := by
    ext s hs
    rw [Measure.bind_apply hs κ.aemeasurable, hτ, lintegral_smul_measure, lintegral_count, tsum_fintype,
      Measure.smul_apply, Measure.coe_finsetSum, Finset.sum_apply, smul_eq_mul]
    rfl
  rw [← hbind]
  exact ksEntropy_bind_eq_zero τ κ hT (Filter.Eventually.of_forall hpres) (Filter.Eventually.of_forall hzero)

/-! ## C4 in the case read: a factor by a finite subgroup -/

/-- **Coarsening lowers Shannon entropy**: a function of an observation carries at most its entropy. The mass of a fibre of
`f ∘ A` is the sum of the masses of the fibres of `A` above it, and `−x log x` is subadditive on `[0, ∞)` (the port's
`negMulLog_sum_le`). Read by `exists_pattern_names_le`: the names of `P` are a function of `Q` and the names of the
pattern. Not in the port (FS131-KN9 searched `OAI015Shannon`). -/
theorem observationEntropy_comp_le {Y α β : Type*} [MeasurableSpace Y] [Fintype α] [Fintype β] (μ : Measure Y)
    [IsFiniteMeasure μ] (A : Y → α) (hA : ∀ a, MeasurableSet {y | A y = a}) (f : α → β) :
    Outside.OAI015.observationEntropy μ (fun y => f (A y)) ≤ Outside.OAI015.observationEntropy μ A := by
  classical
  unfold Outside.OAI015.observationEntropy Outside.OAI015.finiteShannon
  have hfib : ∀ b, μ.real {y | f (A y) = b} = ∑ a, if f a = b then μ.real {y | A y = a} else 0 := by
    intro b
    have hset : {y | f (A y) = b} = ⋃ a ∈ Finset.univ.filter (fun a => f a = b), {y | A y = a} := by
      ext y
      simp
    rw [hset, measureReal_biUnion_finset, Finset.sum_filter]
    · intro a _ a' _ hne
      exact Set.disjoint_left.2 fun y h1 h2 => hne (h1.symm.trans h2)
    · exact fun a _ => hA a
  have hle : ∀ b, Real.negMulLog (μ.real {y | f (A y) = b}) ≤
      ∑ a, if f a = b then Real.negMulLog (μ.real {y | A y = a}) else 0 := by
    intro b
    rw [hfib b]
    refine (Outside.OAI015.negMulLog_sum_le _ fun a => ?_).trans (le_of_eq ?_)
    · split_ifs
      · exact measureReal_nonneg
      · exact le_rfl
    · refine Finset.sum_congr rfl fun a _ => ?_
      split_ifs <;> simp
  calc ∑ b, Real.negMulLog (μ.real {y | f (A y) = b})
      ≤ ∑ b, ∑ a, if f a = b then Real.negMulLog (μ.real {y | A y = a}) else 0 := Finset.sum_le_sum fun b _ => hle b
    _ = ∑ a, Real.negMulLog (μ.real {y | A y = a}) := by
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun a _ => ?_
        rw [Finset.sum_ite_eq]
        simp

section FiniteFibres

variable [AddCommGroup X] [TopologicalSpace X] [IsTopologicalAddGroup X] [MeasurableSpace X] [BorelSpace X]

/-- **A section partition**: on a compact T1 group, a finite subgroup `G` has a finite measurable partition `Q` each of whose
cells meets each coset of `G` in at most one point, and the projection carries every measurable subset of a cell to a
**Borel** set of `X ⧸ G`. Route: `V := (G ∖ {0})ᶜ` is an open neighbourhood of `0` (T1, `G` finite); an open `U ∋ 0` with
`U − U ⊆ V`; finitely many translates `x_i + U` cover `X` (`compact_covered_by_add_left_translates`); `Q x` is the first
translate containing `x`. On `x_i + U` the projection is injective (`U − U` meets `G` only in `0`), continuous and open
(`QuotientAddGroup.isOpenMap_coe`), so an open embedding there (`Topology.IsOpenEmbedding.of_continuous_injective_isOpenMap`),
whose images of Borel sets are Borel (`Topology.IsOpenEmbedding.measurableEmbedding`). No Lusin–Souslin. -/
theorem exists_sectionPartition [CompactSpace X] [T1Space X] (G : AddSubgroup X) (hG : (G : Set X).Finite) :
    ∃ (k : ℕ) (Q : X → Fin k), Measurable Q ∧ (∀ x, ∀ g ∈ G, Q (x + g) = Q x → g = 0) ∧
      ∀ (i : Fin k) (S : Set X), MeasurableSet S →
        MeasurableSet[borel (X ⧸ G)] (QuotientAddGroup.mk' G '' (Q ⁻¹' {i} ∩ S)) := by
  classical
  -- `V = (G ∖ {0})ᶜ` is an open neighbourhood of `0`; `U` with `U − U ⊆ V`
  have hV : IsOpen (((G : Set X) \ {0})ᶜ) := (hG.subset Set.sdiff_subset).isClosed.isOpen_compl
  have hV0 : (0 : X) ∈ (((G : Set X) \ {0})ᶜ) := fun h => h.2 rfl
  obtain ⟨U₀, hU₀, hU₀0, hU₀V⟩ := exists_open_nhds_zero_half (hV.mem_nhds hV0)
  set U : Set X := U₀ ∩ (fun x => -x) ⁻¹' U₀ with hUdef
  have hU : IsOpen U := hU₀.inter (hU₀.preimage continuous_neg)
  have hU0 : (0 : X) ∈ U := ⟨hU₀0, by simpa using hU₀0⟩
  have hUU : ∀ a ∈ U, ∀ b ∈ U, ∀ g ∈ G, a + g = b → g = 0 := by
    intro a ha b hb g hg hab
    have h1 : b + -a ∈ (((G : Set X) \ {0})ᶜ) := hU₀V b hb.1 (-a) ha.2
    have h2 : b + -a = g := by rw [← hab]; abel
    rw [h2] at h1
    by_contra hg0
    exact h1 ⟨hg, hg0⟩
  -- finitely many translates cover `X`
  obtain ⟨t, ht⟩ := compact_covered_by_add_left_translates (isCompact_univ (X := X)) (V := U)
    ⟨0, by rw [hU.interior_eq]; exact hU0⟩
  set W : X → Set X := fun g => (fun h => g + h) ⁻¹' U with hW
  have hWopen : ∀ g, IsOpen (W g) := fun g => hU.preimage (continuous_const.add continuous_id)
  let c : Fin t.card → X := fun i => (t.equivFin.symm i : X)
  have hcover : ∀ x, ∃ i, x ∈ W (c i) := by
    intro x
    obtain ⟨g, hg, hx⟩ := Set.mem_iUnion₂.1 (ht (Set.mem_univ x))
    exact ⟨t.equivFin ⟨g, hg⟩, by simpa [c, W] using hx⟩
  let Q : X → Fin t.card := fun x =>
    (Finset.univ.filter fun i => x ∈ W (c i)).min' (by
      obtain ⟨i, hi⟩ := hcover x
      exact ⟨i, by simpa using hi⟩)
  have hQmem : ∀ x, x ∈ W (c (Q x)) := fun x => by
    have := Finset.min'_mem (Finset.univ.filter fun i => x ∈ W (c i)) (by
      obtain ⟨i, hi⟩ := hcover x
      exact ⟨i, by simpa using hi⟩)
    simpa using this
  have hQle : ∀ x j, x ∈ W (c j) → Q x ≤ j := fun x j hj =>
    Finset.min'_le _ _ (by simpa using hj)
  have hQeq : ∀ x i, Q x = i ↔ x ∈ W (c i) ∧ ∀ j, j < i → x ∉ W (c j) := by
    intro x i
    constructor
    · rintro rfl
      exact ⟨hQmem x, fun j hj hxj => absurd (hQle x j hxj) (not_le.2 hj)⟩
    · rintro ⟨hi, hlt⟩
      refine le_antisymm (hQle x i hi) ?_
      by_contra hlt'
      exact hlt _ (not_le.1 hlt') (hQmem x)
  have hWm : ∀ g, MeasurableSet (W g) := fun g => (hWopen g).measurableSet
  have hcell : ∀ i, Q ⁻¹' {i} = W (c i) ∩ ⋂ j : Fin t.card, {x | j < i → x ∉ W (c j)} := by
    intro i
    ext x
    simp only [Set.mem_preimage, Set.mem_singleton_iff, hQeq, Set.mem_inter_iff, Set.mem_iInter, Set.mem_setOf_eq]
  have hcellm : ∀ i, MeasurableSet (Q ⁻¹' {i}) := by
    intro i
    rw [hcell i]
    refine (hWm _).inter (MeasurableSet.iInter fun j => ?_)
    by_cases hj : j < i
    · have e : {x | j < i → x ∉ W (c j)} = (W (c j))ᶜ := by
        ext x
        simp [hj]
      rw [e]
      exact (hWm (c j)).compl
    · have e : {x | j < i → x ∉ W (c j)} = Set.univ := by
        ext x
        simp [hj]
      rw [e]
      exact MeasurableSet.univ
  refine ⟨t.card, Q, measurable_to_countable' hcellm, ?_, ?_⟩
  · -- a cell meets a coset in at most one point
    intro x g hg hQ
    have h1 := hQmem x
    have h2 := hQmem (x + g)
    rw [hQ] at h2
    exact hUU (c (Q x) + x) h1 (c (Q x) + (x + g)) h2 g hg (by abel)
  · -- the projection is an open embedding on each translate, so it carries Borel sets to Borel sets
    intro i S hS
    letI : MeasurableSpace (X ⧸ G) := borel (X ⧸ G)
    haveI : BorelSpace (X ⧸ G) := ⟨rfl⟩
    set Wi := W (c i)
    let f : Wi → X ⧸ G := fun y => QuotientAddGroup.mk' G (y : X)
    have hfc : Continuous f := (continuous_quot_mk.comp continuous_subtype_val)
    have hfinj : Function.Injective f := by
      intro y y' hyy
      have hyy' : QuotientAddGroup.mk' G (y : X) = QuotientAddGroup.mk' G (y' : X) := hyy
      rw [QuotientAddGroup.mk'_apply, QuotientAddGroup.mk'_apply, QuotientAddGroup.eq] at hyy'
      have h0 := hUU (c i + (y : X)) y.2 (c i + (y' : X)) y'.2 (-(y : X) + y') hyy' (by abel)
      apply Subtype.ext
      have : (y : X) + (-(y : X) + y') = y' := by abel
      rw [h0, add_zero] at this
      exact this
    have hfopen : IsOpenMap f := by
      intro O hO
      have h1 : IsOpen ((Subtype.val : Wi → X) '' O) := (hWopen (c i)).isOpenMap_subtype_val O hO
      have h2 := (QuotientAddGroup.isOpenMap_coe (N := G)) _ h1
      rw [Set.image_image] at h2
      exact h2
    have hemb : Topology.IsOpenEmbedding f :=
      Topology.IsOpenEmbedding.of_continuous_injective_isOpenMap hfc hfinj hfopen
    have hme := hemb.measurableEmbedding
    have hS' : MeasurableSet ((Subtype.val : Wi → X) ⁻¹' (Q ⁻¹' {i} ∩ S)) :=
      measurable_subtype_coe ((hcellm i).inter hS)
    have himage : f '' ((Subtype.val : Wi → X) ⁻¹' (Q ⁻¹' {i} ∩ S)) =
        QuotientAddGroup.mk' G '' (Q ⁻¹' {i} ∩ S) := by
      ext z
      constructor
      · rintro ⟨y, hy, rfl⟩
        exact ⟨y, hy, rfl⟩
      · rintro ⟨y, hy, rfl⟩
        have hyW : y ∈ Wi := by
          have := (hQeq y i).1 hy.1
          exact this.1
        exact ⟨⟨y, hyW⟩, hy, rfl⟩
    rw [← himage]
    exact hme.measurableSet_image.2 hS'

omit [IsTopologicalAddGroup X] in
/-- **The names of a partition are bounded by the names of its pattern on the cosets.** Given a section partition `Q` of
`G` (`exists_sectionPartition`), every finite measurable partition `P` has a partition `R` of the factor — measurable for
the σ-algebra pulled back from the Borel σ-algebra of `X ⧸ G` — with `H_n(P) ≤ H_n(R) + log k` for every `n` and every
measurable `T`. `R` is the pattern: at `x`, for each cell `i` of `Q`, whether the coset `x + G` meets it, and if so the labels
`P` and `Q ∘ T` at the point where it does; each cell of `R` is the preimage of the image of a measurable subset of a cell of
`Q`. The names of `P` are a function of `Q` at time zero and the names of `R`, because `R y (Q y) = (P y, Q (T y))` at every
point (the point of `y + G` in `Q`'s cell of `y` is `y`); then the port's `observationEntropy_joint_le` and
`finiteShannon_le_log_card`, and coarsening by `negMulLog_sum_le`. Neither the finiteness of `G`, nor invariance of `μ`, nor
`T(G) ⊆ G` is read. -/
theorem exists_pattern_names_le (μ : Measure X) [IsProbabilityMeasure μ] (G : AddSubgroup X) {k : ℕ} {Q : X → Fin k}
    (hQ : Measurable Q) (hsec : ∀ x, ∀ g ∈ G, Q (x + g) = Q x → g = 0)
    (himg : ∀ (i : Fin k) (S : Set X), MeasurableSet S →
      MeasurableSet[borel (X ⧸ G)] (QuotientAddGroup.mk' G '' (Q ⁻¹' {i} ∩ S)))
    {T : X → X} (hT : Measurable T) {l : ℕ} {P : X → Fin l} (hP : Measurable P) :
    ∃ (K : ℕ) (R : X → Fin K), Measurable[MeasurableSpace.comap (QuotientAddGroup.mk' G) (borel (X ⧸ G))] R ∧
      ∀ n, blockEntropy μ T P n ≤ blockEntropy μ T R n + Real.log k := by
  classical
  rcases isEmpty_or_nonempty X with hX | ⟨⟨y₀⟩⟩
  · exact absurd (Measure.eq_zero_of_isEmpty μ) (IsProbabilityMeasure.ne_zero μ)
  set π : X →+ X ⧸ G := QuotientAddGroup.mk' G with hπ
  -- a coset meets a cell of `Q` in at most one point
  have huniq : ∀ (y y' : X), Q y = Q y' → π y = π y' → y = y' := by
    intro y y' hq hyy
    rw [hπ, QuotientAddGroup.mk'_apply, QuotientAddGroup.mk'_apply, QuotientAddGroup.eq] at hyy
    have h0 := hsec y (-y + y') hyy (by rw [add_neg_cancel_left]; exact hq.symm)
    have : y + (-y + y') = y' := by abel
    rw [h0, add_zero] at this
    exact this
  -- the pattern: at each cell, the labels at the point where the coset meets it
  let R₀ : X → Fin k → Option (Fin l × Fin k) := fun x i =>
    if h : ∃ y, Q y = i ∧ π y = π x then some (P h.choose, Q (T h.choose)) else none
  have hR₀ : ∀ x i a c, R₀ x i = some (a, c) ↔ ∃ y, (Q y = i ∧ P y = a ∧ Q (T y) = c) ∧ π y = π x := by
    intro x i a c
    simp only [R₀]
    split_ifs with h
    · simp only [Option.some.injEq, Prod.mk.injEq]
      constructor
      · rintro ⟨ha, hc⟩
        exact ⟨h.choose, ⟨h.choose_spec.1, ha, hc⟩, h.choose_spec.2⟩
      · rintro ⟨y, ⟨hy, ha, hc⟩, hyx⟩
        have he := huniq h.choose y (h.choose_spec.1.trans hy.symm) (h.choose_spec.2.trans hyx.symm)
        rw [he]
        exact ⟨ha, hc⟩
    · simp only [false_iff]
      rintro ⟨y, ⟨hy, -, -⟩, hyx⟩
      exact h ⟨y, hy, hyx⟩
  have hR₀none : ∀ x i, R₀ x i = none ↔ ¬ ∃ y, (Q y = i) ∧ π y = π x := by
    intro x i
    simp only [R₀]
    split_ifs with h
    · simp only [false_iff, not_not]
      exact h
    · simp only [true_iff]
      exact h
  have hkey : ∀ y, R₀ y (Q y) = some (P y, Q (T y)) := fun y => (hR₀ y (Q y) _ _).2 ⟨y, ⟨rfl, rfl, rfl⟩, rfl⟩
  let e := Fintype.equivFin (Fin k → Option (Fin l × Fin k))
  let R : X → Fin (Fintype.card (Fin k → Option (Fin l × Fin k))) := fun x => e (R₀ x)
  -- the cells of the pattern are preimages of Borel sets of the factor
  have hpre : ∀ (i : Fin k) (S : Set X), MeasurableSet S →
      MeasurableSet[MeasurableSpace.comap π (borel (X ⧸ G))] {x | ∃ y, (Q y = i ∧ y ∈ S) ∧ π y = π x} := by
    intro i S hS
    refine ⟨_, himg i S hS, ?_⟩
    ext x
    simp only [Set.mem_preimage, Set.mem_image, Set.mem_inter_iff, Set.mem_singleton_iff, Set.mem_setOf_eq]
  have hRc : Measurable[MeasurableSpace.comap π (borel (X ⧸ G))] R := by
    refine @measurable_to_countable' _ _ _ _ (MeasurableSpace.comap π (borel (X ⧸ G))) R fun v => ?_
    have hset : R ⁻¹' {v} = ⋂ i, {x | R₀ x i = e.symm v i} := by
      ext x
      simp only [R, Set.mem_preimage, Set.mem_singleton_iff, Set.mem_iInter, Set.mem_setOf_eq]
      constructor
      · rintro rfl i
        simp
      · intro h
        rw [← e.apply_symm_apply v]
        exact congrArg e (funext h)
    rw [hset]
    refine MeasurableSet.iInter fun i => ?_
    rcases h : e.symm v i with _ | ⟨a, c⟩
    · have : {x | R₀ x i = none} = {x | ∃ y, (Q y = i ∧ y ∈ Set.univ) ∧ π y = π x}ᶜ := by
        ext x
        simp only [Set.mem_setOf_eq, Set.mem_compl_iff, hR₀none, Set.mem_univ, and_true]
      rw [this]
      exact (hpre i Set.univ MeasurableSet.univ).compl
    · have : {x | R₀ x i = some (a, c)} = {x | ∃ y, (Q y = i ∧ y ∈ P ⁻¹' {a} ∩ (Q ∘ T) ⁻¹' {c}) ∧ π y = π x} := by
        ext x
        simp only [Set.mem_setOf_eq, hR₀, Set.mem_inter_iff, Set.mem_preimage, Set.mem_singleton_iff,
          Function.comp_apply]
      rw [this]
      exact hpre i _ ((hP (measurableSet_singleton a)).inter ((hQ.comp hT) (measurableSet_singleton c)))
  -- measurable for the σ-algebra of `X`
  have hπm : @Measurable X (X ⧸ G) _ (borel (X ⧸ G)) π :=
    measurable_generateFrom fun t ht => (IsOpen.preimage continuous_quot_mk ht).measurableSet
  have hR : Measurable R := hRc.mono hπm.comap_le le_rfl
  refine ⟨_, R, hRc, fun n => ?_⟩
  -- the names of `P` are determined by the time-zero cell of `Q` and the names of `R`
  set Rn := Outside.OAI015.orbitName T R n with hRn
  have hdet : ∀ y y', Q y = Q y' → Rn y = Rn y' →
      Outside.OAI015.orbitName T P n y = Outside.OAI015.orbitName T P n y' := by
    intro y y' hq hr
    have hstep : ∀ j, j < n → Q (T^[j] y) = Q (T^[j] y') →
        P (T^[j] y) = P (T^[j] y') ∧ Q (T^[j + 1] y) = Q (T^[j + 1] y') := by
      intro j hj hqj
      have h1 : R₀ (T^[j] y) = R₀ (T^[j] y') := e.injective (congrFun hr ⟨j, hj⟩)
      have h2 := hkey (T^[j] y)
      have h3 := hkey (T^[j] y')
      rw [h1, hqj, h3] at h2
      simp only [Option.some.injEq, Prod.mk.injEq] at h2
      rw [Function.iterate_succ_apply', Function.iterate_succ_apply']
      exact ⟨h2.1.symm, h2.2.symm⟩
    have hQall : ∀ j, j ≤ n → Q (T^[j] y) = Q (T^[j] y') := by
      intro j
      induction j with
      | zero => intro _; exact hq
      | succ j ih =>
        intro hj
        exact (hstep j hj (ih (Nat.le_of_succ_le hj))).2
    funext j
    exact (hstep j j.2 (hQall j j.2.le)).1
  let D : Fin k × (Fin n → Fin (Fintype.card (Fin k → Option (Fin l × Fin k)))) → (Fin n → Fin l) := fun a =>
    if h : ∃ y, (Q y, Rn y) = a then Outside.OAI015.orbitName T P n h.choose
    else Outside.OAI015.orbitName T P n y₀
  have hD : ∀ y, D (Q y, Rn y) = Outside.OAI015.orbitName T P n y := by
    intro y
    have h : ∃ y', (Q y', Rn y') = (Q y, Rn y) := ⟨y, rfl⟩
    show (if h' : ∃ y', (Q y', Rn y') = (Q y, Rn y) then Outside.OAI015.orbitName T P n h'.choose
      else Outside.OAI015.orbitName T P n y₀) = _
    rw [dif_pos h]
    have hc := h.choose_spec
    exact hdet _ _ (congrArg Prod.fst hc) (congrArg Prod.snd hc)
  have hQf : ∀ i, MeasurableSet {y | Q y = i} := fun i => hQ (measurableSet_singleton i)
  have hRnf : ∀ w, MeasurableSet {y | Rn y = w} := fun w =>
    Outside.OAI015.orbitName_measurable_fiber hT (fun v => hR (measurableSet_singleton v)) n w
  have hpair : ∀ a, MeasurableSet {y | (Q y, Rn y) = a} := by
    intro a
    have : {y | (Q y, Rn y) = a} = {y | Q y = a.1} ∩ {y | Rn y = a.2} := by
      ext y
      simp [Prod.ext_iff]
    rw [this]
    exact (hQf _).inter (hRnf _)
  rw [blockEntropy_eq_observationEntropy, blockEntropy_eq_observationEntropy]
  have hcomp : Outside.OAI015.orbitName T P n = fun y => D (Q y, Rn y) := funext fun y => (hD y).symm
  rw [hcomp]
  have hlogQ : Outside.OAI015.observationEntropy μ Q ≤ Real.log k := by
    have := Outside.OAI015.finiteShannon_le_log_card (p := fun i => μ.real {y | Q y = i})
      (fun i => measureReal_nonneg) (Outside.OAI015.observation_distribution_sum μ Q hQf)
    simpa [Outside.OAI015.observationEntropy, Fintype.card_fin] using this
  calc Outside.OAI015.observationEntropy μ (fun y => D (Q y, Rn y))
      ≤ Outside.OAI015.observationEntropy μ (fun y => (Q y, Rn y)) := observationEntropy_comp_le μ _ hpair D
    _ ≤ Outside.OAI015.observationEntropy μ Q + Outside.OAI015.observationEntropy μ Rn :=
        Outside.OAI015.observationEntropy_joint_le μ Q Rn hQf hRnf
    _ ≤ Outside.OAI015.observationEntropy μ Rn + Real.log k := by linarith

/-- **C4, in the case the deduction reads** (FS105-DED, step B1), over the σ-algebra of the declared theorem's clause (4),
the Borel σ-algebra of `X ⧸ G` (`[EinsiedlerLindenstrauss2022]` p. 4, § 1.3): over the factor of a compact group by a
finite subgroup, entropy zero below is entropy zero above. `⇒`: for a measurable `P`, the pattern `R` of
`exists_pattern_names_le` is a partition of the factor, so its entropy is zero by the hypothesis through
`Rigidity.ksEntropy_map` (at `@ksEntropy_map … (borel (X ⧸ G))`, the projection and the induced map being continuous);
`Rigidity.exists_blockEntropy_le_mul` gives blocks `n ≥ log k / ε` with `H_n(R) ≤ εn`, so `h(T, P) ≤ 2ε`. `⇐`: a factor
has at most the entropy (`ksEntropy_map`, `ksEntropyOn_le_ksEntropy`). No `PolishSpace`. -/
theorem ksEntropy_eq_zero_iff_of_finite [CompactSpace X] [T1Space X] (G : AddSubgroup X) (hG : (G : Set X).Finite)
    (T : X →+ X) (hT : Continuous T) (hTG : G ≤ G.comap T) (μ : Measure X) [IsProbabilityMeasure μ]
    (hμ : MeasurePreserving T μ μ) :
    @ksEntropy (X ⧸ G) (borel (X ⧸ G)) (@Measure.map X (X ⧸ G) _ (borel (X ⧸ G)) (QuotientAddGroup.mk' G) μ)
        (QuotientAddGroup.map G G T hTG) = 0 ↔ ksEntropy μ T = 0 := by
  set π : X →+ X ⧸ G := QuotientAddGroup.mk' G with hπ
  have hπm : @Measurable X (X ⧸ G) _ (borel (X ⧸ G)) π :=
    measurable_generateFrom fun t ht => (IsOpen.preimage continuous_quot_mk ht).measurableSet
  have hSc : Continuous (QuotientAddGroup.map G G T hTG) :=
    continuous_coinduced_dom.2 (continuous_quot_mk.comp hT)
  have hSm : @Measurable (X ⧸ G) (X ⧸ G) (borel (X ⧸ G)) (borel (X ⧸ G)) (QuotientAddGroup.map G G T hTG) :=
    @measurable_generateFrom (X ⧸ G) (X ⧸ G) (borel (X ⧸ G)) {s | IsOpen s} _ fun t ht =>
      MeasurableSpace.measurableSet_generateFrom (ht.preimage hSc)
  have hcomm : ∀ x, π (T x) = QuotientAddGroup.map G G T hTG (π x) := fun x => rfl
  have hmap := @ksEntropy_map X _ (X ⧸ G) (borel (X ⧸ G)) μ T π hπm (QuotientAddGroup.map G G T hTG) hSm hcomm
  rw [hmap]
  have hTm : Measurable T := hT.measurable
  constructor
  · intro h0
    rw [ksEntropy_eq_zero_iff]
    intro l P hP
    obtain ⟨k, Q, hQ, hsec, himg⟩ := exists_sectionPartition G hG
    obtain ⟨K, R, hRc, hRP⟩ := exists_pattern_names_le μ G hQ hsec himg hTm hP
    have hR : Measurable R := hRc.mono hπm.comap_le le_rfl
    have hR0 : partitionEntropy μ T R = 0 :=
      nonpos_iff_eq_zero.1 (h0 ▸ partitionEntropy_le_ksEntropyOn μ T hRc)
    refine nonpos_iff_eq_zero.1 (ENNReal.le_of_forall_pos_le_add fun ε hε _ => ?_)
    rw [zero_add]
    have hε2 : (0 : ℝ) < (ε : ℝ) / 2 := by positivity
    obtain ⟨K₀, hK₀⟩ := exists_nat_gt (Real.log k / ((ε : ℝ) / 2))
    obtain ⟨n, hKn, hn0, hn⟩ := exists_blockEntropy_le_mul μ hμ hR hR0 hε2 K₀
    have hn' : (0 : ℝ) < n := by exact_mod_cast hn0
    have hidx : n - 1 + 1 = n := Nat.sub_add_cancel hn0
    have h1 := partitionEntropy_le μ T P (n - 1)
    have hden : ((n - 1 : ℕ) : ℝ) + 1 = n := by
      have : (((n - 1 + 1 : ℕ)) : ℝ) = (n : ℝ) := by rw [hidx]
      push_cast at this
      linarith
    rw [hidx, hden] at h1
    refine h1.trans ?_
    rw [← ENNReal.ofReal_coe_nnreal]
    refine ENNReal.ofReal_le_ofReal ?_
    have hP' := hRP n
    have hlogk : Real.log k ≤ (ε : ℝ) / 2 * n := by
      have hKn' : (K₀ : ℝ) ≤ n := by exact_mod_cast hKn
      have := (div_lt_iff₀ hε2).1 hK₀
      nlinarith
    rw [div_le_iff₀ hn']
    linarith
  · intro h0
    exact nonpos_iff_eq_zero.1 (h0 ▸ ksEntropyOn_le_ksEntropy hπm.comap_le μ T)

/-- **A model of the hypotheses of the finite-fibred step**, every clause at once with `G ≠ 0`: the discrete group `ℤ/4`
(compact, T1, Borel), its subgroup `{0, 2}` (finite, non-trivial), the identity (continuous, mapping `G` into `G`) and the
uniform probability, which it preserves. A model of `exists_sectionPartition` and `exists_pattern_names_le` too. -/
theorem finFour_fibre_model :
    ((AddSubgroup.zmultiples (2 : Fin 4) : Set (Fin 4))).Finite ∧ AddSubgroup.zmultiples (2 : Fin 4) ≠ ⊥ ∧
      AddSubgroup.zmultiples (2 : Fin 4) ≤ (AddSubgroup.zmultiples (2 : Fin 4)).comap (AddMonoidHom.id (Fin 4)) ∧
      IsProbabilityMeasure ((4 : ℝ≥0∞)⁻¹ • Measure.count : Measure (Fin 4)) ∧
      MeasurePreserving (AddMonoidHom.id (Fin 4)) ((4 : ℝ≥0∞)⁻¹ • Measure.count) ((4 : ℝ≥0∞)⁻¹ • Measure.count) := by
  refine ⟨Set.toFinite _, ?_, ?_, ⟨?_⟩, MeasurePreserving.id _⟩
  · intro h
    have h2 : (2 : Fin 4) ∈ AddSubgroup.zmultiples (2 : Fin 4) := AddSubgroup.mem_zmultiples 2
    rw [h, AddSubgroup.mem_bot] at h2
    exact absurd h2 (by decide)
  · intro x hx
    simpa using hx
  · rw [Measure.smul_apply, Measure.count_univ, smul_eq_mul]
    simp only [ENat.card_eq_coe_fintype_card, Fintype.card_fin]
    exact ENNReal.inv_mul_cancel (by norm_num) (by norm_num)

end FiniteFibres

end HadwigerNelson.Rigidity
