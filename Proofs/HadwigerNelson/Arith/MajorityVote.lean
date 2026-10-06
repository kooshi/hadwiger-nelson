import Mathlib.Probability.Moments.Variance
import Mathlib.MeasureTheory.Function.ConvergenceInMeasure

/-!
# Majority decoding (FS131-E8-SI5C), the step under J45-SI-5 (c) (FS-131 wave 10, second planning pass)

**Read aloud, against the informal claim.** `plans/FS131-E8-derivation.md` § 5.1, entry FS131-E8-SI5C: "let I be a
countably infinite set, G a random variable with values in a finite set, c = (c(x)) for x in I random variables with values
in the same finite set, and ε = (ε(x)) for x in I indicator variables, pairwise independent, each of probability p < 1/2,
such that almost surely c(x) ≠ G implies ε(x) = 1 for every x in I; then G is almost surely equal to a function of c,
measurable for the σ-algebra c generates". It replaces "ergodic averages along a tempered Følner sequence" in J45-SI-5 (c).

**The class the argument reads** (Chebyshev for a sum of pairwise uncorrelated indicators, a strict majority, and a
subsequence converging almost surely) is wider than the entry's in three ways, all in the statement: the index set need
only be infinite; the events need only have probability **at most** `p < 1/2` (not equal probabilities); and "almost
surely … for every `x`" is read one `x` at a time. Mathlib's strong law at the pin (`ProbabilityTheory.strong_law_ae`,
Etemadi's: pairwise independent, **identically distributed**) serves the entry's class and not this one, so the plan is
Chebyshev written out (`ProbabilityTheory.meas_ge_le_variance_div_sq`, `ProbabilityTheory.IndepFun.variance_sum`).

**Proved (FS131-I10F)**, by the route above with Borel–Cantelli in place of the closed subspace: along an injective
sequence in `I`, the event "at least half of the first `n` errors occur" has probability at most `1/(4n(1/2 − p)²)`
(`measure_half_le_sum_indicator_le`); off it `G` is the strict majority of the first `n` values
(`lt_two_mul_card_filter_of_bad`), and a strict majority is unique (`eq_of_lt_two_mul_card_filter`); along a subsequence
with summable probabilities `G` is almost surely the eventual strict majority, and "the eventual strict majority" is a
measurable map for the σ-algebra the `c x` generate (`measurableSet_lt_two_mul_card_filter`,
`exists_measurable_selector`). **The argument reads less than the statement carries**: not the measurability of `G`, not
the measurability of the `c x`, and of `[Finite K]` only that `K` is countable.

**Inhabitants.** The degenerate model (`E x = ∅`, `c x = G`) satisfies every hypothesis and makes the conclusion trivial
(the spec example); the entry's model — `I = ℕ`, `G` uniform on two values, `ε` i.i.d. of probability `1/3` — exercises the
clause `c x ≠ G → E x` and needs an infinite product measure, not built here.
-/

namespace HadwigerNelson.MajorityVote

open MeasureTheory

/-! ## The strict majority (pointwise) -/

/-- **Two strict majorities among `n` values are the same value.** -/
theorem eq_of_lt_two_mul_card_filter {K : Type*} [DecidableEq K] {n : ℕ} {cs : ℕ → K} {k k' : K}
    (hk : n < 2 * ((Finset.range n).filter fun i => cs i = k).card)
    (hk' : n < 2 * ((Finset.range n).filter fun i => cs i = k').card) : k = k' := by
  by_contra hne
  have hdisj : Disjoint ((Finset.range n).filter fun i => cs i = k) ((Finset.range n).filter fun i => cs i = k') := by
    rw [Finset.disjoint_filter]
    intro i _ h1 h2
    exact hne (h1.symm.trans h2)
  have hsum : ((Finset.range n).filter fun i => cs i = k).card + ((Finset.range n).filter fun i => cs i = k').card ≤ n := by
    rw [← Finset.card_union_of_disjoint hdisj]
    calc _ ≤ (Finset.range n).card :=
          Finset.card_le_card (Finset.union_subset (Finset.filter_subset _ _) (Finset.filter_subset _ _))
      _ = n := Finset.card_range n
  omega

/-- **A value that all but fewer than half of `n` entries take is the strict majority**: if `cs i = g` off a set `bad` of
indices with `2·#bad < n`, then `g` occurs more than `n/2` times. -/
theorem lt_two_mul_card_filter_of_bad {K : Type*} [DecidableEq K] {n : ℕ} {cs : ℕ → K} {g : K} {bad : ℕ → Prop}
    [DecidablePred bad] (h : ∀ i < n, cs i ≠ g → bad i) (hlt : 2 * ((Finset.range n).filter bad).card < n) :
    n < 2 * ((Finset.range n).filter fun i => cs i = g).card := by
  have hg : n ≤ ((Finset.range n).filter fun i => cs i = g).card + ((Finset.range n).filter bad).card :=
    calc n = (Finset.range n).card := (Finset.card_range n).symm
      _ ≤ (((Finset.range n).filter fun i => cs i = g) ∪ ((Finset.range n).filter bad)).card := by
          refine Finset.card_le_card fun i hi => ?_
          rw [Finset.mem_union, Finset.mem_filter, Finset.mem_filter]
          by_cases hig : cs i = g
          · exact Or.inl ⟨hi, hig⟩
          · exact Or.inr ⟨hi, h i (Finset.mem_range.mp hi) hig⟩
      _ ≤ _ := Finset.card_union_le _ _
  omega

/-! ## Chebyshev for pairwise uncorrelated events of probability at most `p < 1/2` -/

/-- **The weak law, written out**: for events `E i`, pairwise independent, each of probability at most `p < 1/2`, the
probability that at least half of the first `n` occur is at most `1 / (4 (1/2 − p)²) / n`. -/
theorem measure_half_le_sum_indicator_le {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ]
    (E : ℕ → Set Ω) (hE : ∀ i, MeasurableSet (E i)) {p : ℝ} (hp : p < 1 / 2) (hEp : ∀ i, μ.real (E i) ≤ p)
    (hindep : ∀ i j, i ≠ j → μ (E i ∩ E j) = μ (E i) * μ (E j)) {n : ℕ} (hn : 0 < n) :
    μ {ω | (n : ℝ) / 2 ≤ ∑ i ∈ Finset.range n, (E i).indicator (fun _ => (1 : ℝ)) ω} ≤
      ENNReal.ofReal (1 / (4 * (1 / 2 - p) ^ 2) / n) := by
  set X : ℕ → Ω → ℝ := fun i => (E i).indicator fun _ => (1 : ℝ) with hX
  have hmeas : ∀ i, Measurable (X i) := fun i => measurable_const.indicator (hE i)
  have hmem : ∀ i, MemLp (X i) 2 μ := fun i => memLp_indicator_const 2 (hE i) 1 (Or.inr (measure_ne_top μ _))
  have hind : ∀ i j, i ≠ j → ProbabilityTheory.IndepFun (X i) (X j) μ := by
    intro i j hij
    have h0 : ProbabilityTheory.IndepSet (E i) (E j) μ :=
      (ProbabilityTheory.indepSet_iff_measure_inter_eq_mul (hE i) (hE j) μ).mpr (hindep i j hij)
    refine ProbabilityTheory.indep_of_indep_of_le_left (ProbabilityTheory.indep_of_indep_of_le_right h0 ?_) ?_
    · exact (measurable_const.indicator (MeasurableSpace.measurableSet_generateFrom (Set.mem_singleton _))).comap_le
    · exact (measurable_const.indicator (MeasurableSpace.measurableSet_generateFrom (Set.mem_singleton _))).comap_le
  have hvar : ProbabilityTheory.variance (∑ i ∈ Finset.range n, X i) μ ≤ n / 4 := by
    rw [ProbabilityTheory.IndepFun.variance_sum (fun i _ => hmem i) (fun i _ j _ hij => hind i j hij)]
    have h1 : ∀ i ∈ Finset.range n, ProbabilityTheory.variance (X i) μ ≤ 1 / 4 := by
      intro i _
      have h := ProbabilityTheory.variance_le_sq_of_bounded (μ := μ) (a := 0) (b := 1) (X := X i)
        (ae_of_all _ fun ω => by by_cases h : ω ∈ E i <;> simp [hX, h]) (hmeas i).aemeasurable
      norm_num at h
      exact h
    calc ∑ i ∈ Finset.range n, ProbabilityTheory.variance (X i) μ ≤ ∑ _i ∈ Finset.range n, (1 / 4 : ℝ) :=
          Finset.sum_le_sum h1
      _ = n / 4 := by simp; ring
  have hmean : ∫ ω, (∑ i ∈ Finset.range n, X i) ω ∂μ ≤ n * p := by
    simp only [Finset.sum_apply]
    rw [integral_finsetSum _ (fun i _ => (hmem i).integrable (by norm_num))]
    calc ∑ i ∈ Finset.range n, ∫ a, X i a ∂μ = ∑ i ∈ Finset.range n, μ.real (E i) :=
          Finset.sum_congr rfl fun i _ => integral_indicator_one (hE i)
      _ ≤ ∑ _i ∈ Finset.range n, p := Finset.sum_le_sum fun i _ => hEp i
      _ = n * p := by simp
  have hd : 0 < 1 / 2 - p := by linarith
  have hn' : (0 : ℝ) < n := Nat.cast_pos.mpr hn
  have hc : 0 < (n : ℝ) * (1 / 2 - p) := mul_pos hn' hd
  have hmemS : MemLp (∑ i ∈ Finset.range n, X i) 2 μ := memLp_finsetSum' _ fun i _ => hmem i
  refine (measure_mono ?_).trans ((ProbabilityTheory.meas_ge_le_variance_div_sq hmemS hc).trans ?_)
  · intro ω hω
    simp only [Set.mem_setOf_eq] at hω ⊢
    rw [Finset.sum_apply]
    have h1 : (n : ℝ) * (1 / 2 - p) ≤ ∑ i ∈ Finset.range n, X i ω - ∫ x, (∑ i ∈ Finset.range n, X i) x ∂μ := by
      linarith
    exact h1.trans (le_abs_self _)
  · refine ENNReal.ofReal_le_ofReal ?_
    calc ProbabilityTheory.variance (∑ i ∈ Finset.range n, X i) μ / ((n : ℝ) * (1 / 2 - p)) ^ 2
        ≤ (n / 4) / ((n : ℝ) * (1 / 2 - p)) ^ 2 := div_le_div_of_nonneg_right hvar (sq_nonneg _)
      _ = 1 / (4 * (1 / 2 - p) ^ 2) / n := by
          field_simp

/-! ## Measurability of the vote, for one σ-algebra -/

/-- "`k` is the strict majority of the first `n` values" is an event of any σ-algebra for which each `{cs i = k}` is. -/
theorem measurableSet_lt_two_mul_card_filter {Ω K : Type*} {m : MeasurableSpace Ω} [DecidableEq K] (cs : ℕ → Ω → K)
    (k : K) (hcs : ∀ i, MeasurableSet {ω | cs i ω = k}) (n : ℕ) :
    MeasurableSet {ω | n < 2 * ((Finset.range n).filter fun i => cs i ω = k).card} := by
  have hcount : Measurable fun ω => ((Finset.range n).filter fun i => cs i ω = k).card := by
    simp only [Finset.card_filter]
    exact Finset.measurable_sum _ fun i _ => Measurable.ite (hcs i) measurable_const measurable_const
  exact hcount (MeasurableSet.of_discrete (s := {t : ℕ | n < 2 * t}))

/-- **A measurable selector**: countably many measurable sets, no point in two of them, are the fibres of a measurable
map (off their union it takes the value `k₀`). -/
theorem exists_measurable_selector {Ω K : Type*} {m : MeasurableSpace Ω} [Countable K] [MeasurableSpace K]
    (B : K → Set Ω) (hB : ∀ k, MeasurableSet (B k)) (hdisj : ∀ ω k k', ω ∈ B k → ω ∈ B k' → k = k') (k₀ : K) :
    ∃ g : Ω → K, Measurable g ∧ ∀ ω k, ω ∈ B k → g ω = k := by
  classical
  let g : Ω → K := fun ω => if h : ∃ k, ω ∈ B k then h.choose else k₀
  have hg : ∀ ω k, g ω = k ↔ ω ∈ B k ∨ (k = k₀ ∧ ∀ k', ω ∉ B k') := by
    intro ω k
    by_cases h : ∃ k', ω ∈ B k'
    · have hgω : g ω = h.choose := dif_pos h
      rw [hgω]
      constructor
      · rintro rfl
        exact Or.inl h.choose_spec
      · rintro (h1 | ⟨-, h2⟩)
        · exact hdisj ω _ _ h.choose_spec h1
        · exact absurd h.choose_spec (h2 _)
    · have hgω : g ω = k₀ := dif_neg h
      rw [hgω]
      constructor
      · rintro rfl
        exact Or.inr ⟨rfl, fun k' hk' => h ⟨k', hk'⟩⟩
      · rintro (h1 | ⟨h1, -⟩)
        · exact absurd ⟨k, h1⟩ h
        · exact h1.symm
  refine ⟨g, measurable_to_countable' fun k => ?_, fun ω k hk => (hg ω k).mpr (Or.inl hk)⟩
  have h : g ⁻¹' {k} = B k ∪ ({_ω | k = k₀} ∩ ⋂ k', (B k')ᶜ) := by
    ext ω
    simp only [Set.mem_preimage, Set.mem_singleton_iff, hg ω k, Set.mem_union, Set.mem_inter_iff, Set.mem_setOf_eq,
      Set.mem_iInter, Set.mem_compl_iff]
  rw [h]
  exact (hB k).union ((MeasurableSet.const _).inter (MeasurableSet.iInter fun k' => (hB k').compl))

/-! ## The lemma -/

/-- **FS131-E8-SI5C — majority decoding.** A finite-valued `G` that every `c x` equals unless an event `E x` of
probability at most `p < 1/2` occurs, the `E x` pairwise independent over an infinite index set, is almost surely equal to
a function measurable for the σ-algebra the `c x` generate. -/
theorem ae_eq_measurable_of_majority {Ω I K : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ]
    [Infinite I] [Finite K] [MeasurableSpace K] [MeasurableSingletonClass K] (G : Ω → K) (hG : Measurable G)
    (c : I → Ω → K) (hc : ∀ x, Measurable (c x)) (E : I → Set Ω) (hE : ∀ x, MeasurableSet (E x)) {p : ℝ}
    (hp : p < 1 / 2) (hEp : ∀ x, μ.real (E x) ≤ p)
    (hindep : ∀ x y, x ≠ y → μ (E x ∩ E y) = μ (E x) * μ (E y))
    (hGc : ∀ x, ∀ᵐ ω ∂μ, c x ω ≠ G ω → ω ∈ E x) :
    ∃ g : Ω → K, Measurable[⨆ x, MeasurableSpace.comap (c x) inferInstance] g ∧ G =ᵐ[μ] g := by
  classical
  -- the measurability of `G` and of the `c x` is not read by this argument, and of `[Finite K]` only countability is
  have _hG := hG
  have _hc := hc
  let x : ℕ ↪ I := Infinite.natEmbedding I
  -- the bad events: at least half of the first `n` errors occur
  let Bad : ℕ → Set Ω := fun n =>
    {ω | (n : ℝ) / 2 ≤ ∑ i ∈ Finset.range n, (E (x i)).indicator (fun _ => (1 : ℝ)) ω}
  have hBad : ∀ n, 0 < n → μ (Bad n) ≤ ENNReal.ofReal (1 / (4 * (1 / 2 - p) ^ 2) / n) := fun n hn =>
    measure_half_le_sum_indicator_le (fun i => E (x i)) (fun i => hE _) hp (fun i => hEp _)
      (fun i j hij => hindep _ _ (x.injective.ne hij)) hn
  have hBad0 : Filter.Tendsto (fun n => μ (Bad n)) Filter.atTop (nhds 0) := by
    have h1 : Filter.Tendsto (fun n : ℕ => ENNReal.ofReal (1 / (4 * (1 / 2 - p) ^ 2) / n)) Filter.atTop (nhds 0) := by
      have h := ENNReal.tendsto_ofReal (tendsto_const_div_atTop_nhds_zero_nat (1 / (4 * (1 / 2 - p) ^ 2)))
      simpa using h
    refine tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds h1
      (Filter.Eventually.of_forall fun _ => zero_le) ?_
    filter_upwards [Filter.eventually_gt_atTop 0] with n hn using hBad n hn
  -- a subsequence along which the bad events are summable: Borel–Cantelli
  obtain ⟨δ, hδpos, hδsum⟩ := ENNReal.exists_pos_sum_of_countable (ε := 1) one_ne_zero ℕ
  have hex : ∀ j : ℕ, ∃ n : ℕ, μ (Bad n) < δ j := fun j =>
    (hBad0.eventually_lt_const (by exact_mod_cast hδpos j)).exists
  choose nn hnn using hex
  have hsum : ∑' j, μ (Bad (nn j)) ≠ ⊤ :=
    ne_top_of_le_ne_top hδsum.ne_top (ENNReal.tsum_le_tsum fun j => (hnn j).le)
  have hev : ∀ᵐ ω ∂μ, ∀ᶠ j in Filter.atTop, ω ∉ Bad (nn j) := ae_eventually_notMem hsum
  have hall : ∀ᵐ ω ∂μ, ∀ i : ℕ, c (x i) ω ≠ G ω → ω ∈ E (x i) := ae_all_iff.mpr fun i => hGc (x i)
  -- the strict-majority events, and their limits: events of the σ-algebra the `c x` generate
  let A : ℕ → K → Set Ω := fun n k => {ω | n < 2 * ((Finset.range n).filter fun i => c (x i) ω = k).card}
  have hA : ∀ n k, MeasurableSet[⨆ y, MeasurableSpace.comap (c y) inferInstance] (A n k) := fun n k =>
    measurableSet_lt_two_mul_card_filter (fun i ω => c (x i) ω) k
      (fun i => (le_iSup (fun y => MeasurableSpace.comap (c y) inferInstance) (x i)) _
        ⟨{k}, measurableSet_singleton k, rfl⟩) n
  let Bk : K → Set Ω := fun k => {ω | ∀ᶠ j in Filter.atTop, ω ∈ A (nn j) k}
  have hBk : ∀ k, MeasurableSet[⨆ y, MeasurableSpace.comap (c y) inferInstance] (Bk k) := by
    intro k
    have h : Bk k = ⋃ N : ℕ, ⋂ j : ℕ, ⋂ (_ : N ≤ j), A (nn j) k := by
      ext ω
      simp only [Bk, Set.mem_setOf_eq, Filter.eventually_atTop, Set.mem_iUnion, Set.mem_iInter]
    rw [h]
    exact MeasurableSet.iUnion fun N => MeasurableSet.iInter fun j => MeasurableSet.iInter fun _ => hA _ _
  have hdisj : ∀ ω k k', ω ∈ Bk k → ω ∈ Bk k' → k = k' := by
    intro ω k k' h1 h2
    obtain ⟨j, hj1, hj2⟩ := (h1.and h2).exists
    exact eq_of_lt_two_mul_card_filter hj1 hj2
  have hG : ∀ᵐ ω ∂μ, ω ∈ Bk (G ω) := by
    filter_upwards [hev, hall] with ω h1 h2
    filter_upwards [h1] with j hj
    refine lt_two_mul_card_filter_of_bad (bad := fun i => ω ∈ E (x i)) (fun i _ hi => h2 i hi) ?_
    have hj' : ∑ i ∈ Finset.range (nn j), (E (x i)).indicator (fun _ => (1 : ℝ)) ω < (nn j : ℝ) / 2 := not_le.mp hj
    simp only [Set.indicator_apply, Finset.sum_boole] at hj'
    have h3 : (2 * ((Finset.range (nn j)).filter fun i => ω ∈ E (x i)).card : ℝ) < (nn j : ℝ) := by linarith
    exact_mod_cast h3
  obtain ⟨ω₀⟩ := nonempty_of_isProbabilityMeasure μ
  haveI : Countable K := Finite.to_countable
  obtain ⟨g, hgm, hg⟩ := exists_measurable_selector (m := ⨆ y, MeasurableSpace.comap (c y) inferInstance) Bk hBk hdisj
    (G ω₀)
  refine ⟨g, hgm, ?_⟩
  filter_upwards [hG] with ω hω
  exact (hg ω (G ω) hω).symm

/-! ## Spec -/

-- the degenerate model: no error event, every `c x` is `G`; all hypotheses hold at `p = 0`.
example {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ] (G : Ω → Bool) (hG : Measurable G) :
    ∃ g : Ω → Bool, Measurable[⨆ _x : ℕ, MeasurableSpace.comap G inferInstance] g ∧ G =ᵐ[μ] g :=
  ae_eq_measurable_of_majority G hG (fun _ : ℕ => G) (fun _ => hG) (fun _ => ∅) (fun _ => MeasurableSet.empty)
    (p := 0) (by norm_num) (fun _ => by simp) (fun _ _ _ => by simp) (fun _ => by simp)

end HadwigerNelson.MajorityVote
