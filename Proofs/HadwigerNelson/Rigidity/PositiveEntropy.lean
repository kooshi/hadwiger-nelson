import Proofs.HadwigerNelson.Rigidity.Entropy
import Proofs.HadwigerNelson.Rigidity.Solenoid
import Proofs.HadwigerNelson.Rigidity.EntropyFibres
import Mathlib.MeasureTheory.Measure.MutuallySingular
import Mathlib.MeasureTheory.Group.Measure
import Mathlib.GroupTheory.QuotientGroup.Basic
import Mathlib.MeasureTheory.Constructions.Polish.Basic
import Mathlib.MeasureTheory.Measure.Haar.Unique

/-!
# The positive entropy rigidity theorem of Einsiedler and Lindenstrauss, declared; its totally irreducible case, stated (FS-131, jobs FS131-KN3 and FS131-KN7; proved by FS131-IJ3 and FS131-IJN1: no `sorry`)

**The import.** `positive_entropy_rigidity` is `[EinsiedlerLindenstrauss2022]` Theorem 1.3 ("Positive entropy rigidity
theorem"), § 1.1, pp. 2–3 of arXiv:2101.11120v1 (Ergodic Theory Dynam. Systems 42 (2022) 691–736), **an outside theorem
declared as an axiom**. The page:

> Let `α` be a `ℤ^d`-action (`d ≥ 2`) by automorphisms of a solenoid `X`. Suppose `α` has no virtually cyclic factors, and
> let `µ` be an `α`-invariant and ergodic probability measure on `X`. Then there exists a subgroup `Λ ⊆ ℤ^d` of finite index
> and a decomposition `µ = (1/J)(µ₁ + … + µ_J)` of `µ` into mutually singular measures with the following properties for
> every `j = 1, …, J`. (1) The measure `µ_j` is `α_Λ`-ergodic, where `α_Λ` is the restriction of `α` to `Λ`. (2) There exists
> an `α_Λ`-invariant closed subgroup `G_j` such that `µ_j` is invariant under translation with elements in `G_j`, i.e.
> `µ_j(B) = µ_j(B + g)` for all `g ∈ G_j` and every measurable set `B ⊆ X`. (3) For `n ∈ ℤ^d`, `αⁿ_* µ_j = µ_k` for some
> `k ∈ {1, …, J}` and `αⁿ(G_j) = G_k`. (4) The measure `µ_j` induces a measure on the factor `X/G_j` with
> `h_{µ_j}(αⁿ_{X/G_j}) = 0` for any `n ∈ Λ`. (Here `α_{X/G_j}` denotes the action induced on `X/G_j`.)

**The read-back, clause by clause, is `plans/FS131-KN7-chain-next.md` § Stage 3** (it replaces the first one,
`plans/FS131-KN3-chain-plan.md` § 5.3, at clause (4)). Three places where the Lean statement fixes a sense the page leaves
to the reader, each chosen so that the axiom says no more than the page: "no virtually cyclic factors" is
`ZdAction.NoVirtuallyCyclicFactors` (the literal phrase is met by no action; module docstring of `Rigidity/Solenoid`); the
`µ_j` are probability measures (the page's "ergodic" and its factor `1/J`); "ergodic" is triviality of the strictly
invariant measurable sets, which for the countable group `ℤ^d` is the textbook's sense (an almost invariant set differs by
a null set from the intersection of its translates). **The σ-algebra on `X/G_j` is the page's own**: the Borel σ-algebra of
the quotient group, `borel (X ⧸ G j)` — p. 4, § 1.3: "the preimage A = π⁻¹B_{X/X′} of the Borel σ-algebra B_{X/X′} of
X/X′". Mathlib's instance on `X ⧸ G j` is the quotient σ-algebra (the sets whose preimage is measurable), which contains
the Borel one and can be larger; the two are one when `X` is Polish (`QuotientAddGroup.borelSpace`), and
`positive_entropy_rigidity_of_polishSpace` states the theorem over Mathlib's instance there. The entropy is the infimum
form, on the safe side of the page with nothing to prove (the axiom's docstring).

**Model of its hypotheses** (`positive_entropy_rigidity_model`): the one-point solenoid with the trivial action of `ℤ²`
and the point mass — degenerate, its clause on factors empty; the one-point group is Polish, so it is also a model of the
hypotheses of `positive_entropy_rigidity_of_polishSpace`. The model that exercises every clause is PE-1′, a leaf of the
chain.

**Ours, proved here over the declared theorem:** `haar_or_zero_entropy`, the paper's Theorem 1.2 (p. 2), which the paper
attributes to its announcement `[EinsiedlerLindenstrauss2003]`, where the proof is an outline. Its deduction from Theorem
1.3 is this project's (FS105-DED, `plans/FS105-derivation.md`, [hand], two minds), formalized by FS131-IJ3
(`data/fs131/kn3/claims-M5-totally-irreducible.md`); the model of FS105-NVC's hypotheses, `ZdAction.mulTwoThree_model`, by
FS131-IJN1.
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory

open scoped ENNReal

-- Every binder of the two statements below is written in its signature, none taken from a section `variable`: read as the
-- kernel had it, the axiom stated with `variable … [BorelSpace X]` carried no `BorelSpace` binder (its statement names none),
-- and said the theorem of every σ-algebra on `X` (FS131-KN3, `data/fs131/kn3/logs/FirstLayerCheck-before-binder-fix.log`).

/-- **`[EinsiedlerLindenstrauss2022]` Theorem 1.3, § 1.1, pp. 2–3 (arXiv:2101.11120v1) — an outside theorem, declared.**
For a `ℤ^d`-action `α`, `d ≥ 2`, by automorphisms of a solenoid `X` with no virtually cyclic factors and an `α`-invariant
ergodic probability measure `µ`: a finite-index `Λ` and mutually singular probability measures `ν 1, …, ν J` with
`µ = (1/J) Σ ν j`, each `α_Λ`-ergodic, each invariant under translation by a closed `α_Λ`-invariant subgroup `G j`, permuted
with their subgroups by every `αⁿ`, and each inducing on `X/G j` a measure for which every `αⁿ`, `n ∈ Λ`, has entropy zero.
The page is quoted in the module docstring; the read-back is `plans/FS131-KN7-chain-next.md` § Stage 3.

**The σ-algebra on `X/G j` in clause (4) is the Borel σ-algebra of the quotient group** (`borel (X ⧸ G j)`), as on the
page (p. 4, § 1.3), and the measure on it is the push-forward of `ν j` by the projection, which is continuous. It is written
out because Mathlib's instance on `X ⧸ G j` is the quotient σ-algebra, which contains it and can be larger: over that
instance the clause would say more than the page wherever the two differ (FS131-KN7, Amendment 1 of its brief). For Polish
`X` they are one: `positive_entropy_rigidity_of_polishSpace`.

**The entropy in clause (4) is the infimum form**, `Rigidity.ksEntropy`: the supremum over finite measurable partitions
of `inf_n H_n / n`. For a probability measure that the map preserves — which the measure induced on `X/G j` is, for
`n ∈ Λ` — it is the textbook's number `lim_n H_n / n` (`Rigidity.tendsto_blockEntropy_div`, the pinning theorem). **This
statement is implied by the printed one whether or not that theorem is proved**, because the entropy occurs here once, in
the conclusion, and only as "`= 0`": the infimum is below every reading of the limit (`Rigidity.partitionEntropy_le_liminf`).
**A later edit that puts the entropy into a hypothesis of this or of any declared statement reverses that direction and
may not be made before the pinning theorem is proved.** -/
axiom positive_entropy_rigidity {X : Type*} [AddCommGroup X] [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X]
    (hX : IsSolenoid X) {d : ℕ} (hd : 2 ≤ d) (α : ZdAction d X)
    (hα : α.NoVirtuallyCyclicFactors) (μ : Measure X) (hμ : IsProbabilityMeasure μ) (herg : α.IsErgodicOn ⊤ μ) :
    ∃ (Λ : AddSubgroup (Fin d → ℤ)) (J : ℕ) (ν : Fin J → Measure X) (G : Fin J → AddSubgroup X),
      Λ.FiniteIndex ∧ 0 < J ∧ μ = (J : ℝ≥0∞)⁻¹ • ∑ j, ν j ∧ (∀ i j, i ≠ j → ν i ⟂ₘ ν j) ∧
      ∀ j, IsProbabilityMeasure (ν j) ∧ α.IsErgodicOn Λ (ν j) ∧
        (IsClosed (G j : Set X) ∧ α.InvariantOn Λ (G j) ∧
          ∀ g ∈ G j, ∀ B : Set X, MeasurableSet B → ν j ((fun x => x + g) ⁻¹' B) = ν j B) ∧
        (∀ n : Fin d → ℤ, ∃ k, (ν j).map (α n) = ν k ∧ (G j).map (α n) = G k) ∧
        ∀ n ∈ Λ, ∀ h : G j ≤ (G j).comap (α n),
          @ksEntropy (X ⧸ G j) (borel (X ⧸ G j))
            (@Measure.map X (X ⧸ G j) _ (borel (X ⧸ G j)) (QuotientAddGroup.mk' (G j)) (ν j))
            (QuotientAddGroup.map (G j) (G j) (α n) h) = 0

/-- **The declared theorem over Mathlib's σ-algebra on `X ⧸ G j`, for Polish `X`**: there the quotient σ-algebra is the
Borel one (`QuotientAddGroup.borelSpace`, Lusin–Souslin; `G j` is closed by clause (2)), so clause (4) reads with the
instance. A module that needs this form takes `[PolishSpace X]`; every solenoid is metrizable (its dual is countable), but
that is not a theorem of this library. -/
theorem positive_entropy_rigidity_of_polishSpace {X : Type*} [AddCommGroup X] [TopologicalSpace X] [MeasurableSpace X]
    [BorelSpace X] [PolishSpace X]
    (hX : IsSolenoid X) {d : ℕ} (hd : 2 ≤ d) (α : ZdAction d X)
    (hα : α.NoVirtuallyCyclicFactors) (μ : Measure X) (hμ : IsProbabilityMeasure μ) (herg : α.IsErgodicOn ⊤ μ) :
    ∃ (Λ : AddSubgroup (Fin d → ℤ)) (J : ℕ) (ν : Fin J → Measure X) (G : Fin J → AddSubgroup X),
      Λ.FiniteIndex ∧ 0 < J ∧ μ = (J : ℝ≥0∞)⁻¹ • ∑ j, ν j ∧ (∀ i j, i ≠ j → ν i ⟂ₘ ν j) ∧
      ∀ j, IsProbabilityMeasure (ν j) ∧ α.IsErgodicOn Λ (ν j) ∧
        (IsClosed (G j : Set X) ∧ α.InvariantOn Λ (G j) ∧
          ∀ g ∈ G j, ∀ B : Set X, MeasurableSet B → ν j ((fun x => x + g) ⁻¹' B) = ν j B) ∧
        (∀ n : Fin d → ℤ, ∃ k, (ν j).map (α n) = ν k ∧ (G j).map (α n) = G k) ∧
        ∀ n ∈ Λ, ∀ h : G j ≤ (G j).comap (α n),
          ksEntropy ((ν j).map (QuotientAddGroup.mk' (G j))) (QuotientAddGroup.map (G j) (G j) (α n) h) = 0 := by
  haveI := hX.isTopologicalAddGroup
  obtain ⟨Λ, J, ν, G, hΛ, hJ, hμeq, hsing, hj⟩ := positive_entropy_rigidity hX hd α hα μ hμ herg
  refine ⟨Λ, J, ν, G, hΛ, hJ, hμeq, hsing, fun j => ?_⟩
  obtain ⟨h1, h2, ⟨hcl, hinv, htr⟩, h3, h4⟩ := hj j
  refine ⟨h1, h2, ⟨hcl, hinv, htr⟩, h3, fun n hn h => ?_⟩
  haveI : IsClosed ((G j : AddSubgroup X) : Set X) := hcl
  have e : QuotientAddGroup.measurableSpace (G j) = borel (X ⧸ G j) := BorelSpace.measurable_eq
  rw [e]
  exact h4 n hn h

/-- **A model of the hypotheses of `positive_entropy_rigidity`**: the one-point solenoid, the trivial action of `ℤ²`, the
point mass. Degenerate — there is no non-trivial factor to check; PE-1′ is the model that exercises that clause. -/
theorem positive_entropy_rigidity_model :
    ∃ (α : ZdAction 2 Unit) (μ : Measure Unit), IsSolenoid Unit ∧ α.NoVirtuallyCyclicFactors ∧ IsProbabilityMeasure μ ∧
      α.IsErgodicOn ⊤ μ :=
  ⟨ZdAction.trivial 2 Unit, Measure.dirac (), isSolenoid_unit, trivialAction_noVirtuallyCyclicFactors 2,
    inferInstance, trivialAction_isErgodicOn 2 ⊤⟩

-- The one-point group carries the Borel structure the axiom asks of `X`, and is Polish (the model of the second form).
example : BorelSpace Unit := inferInstance
example : PolishSpace Unit := inferInstance

/-! ## The deduction's steps (FS105-DED, `plans/FS105-D-deduction.md` § 2.1; FS131-KN9's plan, `plans/FS131-KN9-chain-zero-entropy.md` § Stage 2)

Step 0 is FS105-NVC: the hypotheses of the declared theorem follow from those of Theorem 1.2
(`ZdAction.two_le_of_not_isVirtuallyCyclic`, `ZdAction.noVirtuallyCyclicFactors_of_isIrreducible`). Step 1 is total
irreducibility read at `Λ`, inline in the proof. Step 2 (Case A, some `G j = X`) is `isAddHaarMeasure_of_add_invariant`,
`ZdAction.map_eq_of_isAddHaarMeasure` and `ZdAction.eq_of_isErgodicOn_of_invariant_component`. Step 3 (Case B, every `G j`
finite) is `Rigidity/EntropyFibres`: the finite-fibred step, the finite mixture, and the power, with `ZdAction.coe_nsmul`. -/

namespace ZdAction

variable {d : ℕ} {X : Type*} [AddCommGroup X] [TopologicalSpace X]

/-- **Total irreducibility gives irreducibility**: read it at `Λ = ℤ^d`. -/
theorem IsTotallyIrreducible.isIrreducible {α : ZdAction d X} (h : α.IsTotallyIrreducible) : α.IsIrreducible :=
  fun Y hY hinv => h ⊤ inferInstance Y hY hinv

/-- **FS105-NVC, the rank** (FS105-DED step 0a): an action of `ℤ⁰` or `ℤ¹` is virtually cyclic (`n = 0`, resp. `n = 1`, with
`Λ = ℤ^d` and `k = m₀`), so an action that is not has `d ≥ 2`. No hypothesis on `X`. -/
theorem two_le_of_not_isVirtuallyCyclic (α : ZdAction d X) (h : ¬ α.IsVirtuallyCyclic) : 2 ≤ d := by
  by_contra hd
  push Not at hd
  apply h
  interval_cases d
  · exact ⟨0, ⊤, inferInstance, fun m _ => ⟨0, congrArg α (funext fun i => i.elim0)⟩⟩
  · refine ⟨fun _ => 1, ⊤, inferInstance, fun m _ => ⟨m 0, congrArg α (funext fun i => ?_)⟩⟩
    rw [Subsingleton.elim i 0]
    simp

/-- **FS105-NVC, the factors** (FS105-DED step 0d, the primal route): an irreducible action on a connected T1 group that is
not virtually cyclic has no virtually cyclic factor. A closed invariant `Y ≠ X` is finite by irreducibility; if the action is
virtually cyclic modulo `Y`, then for `m ∈ Λ` the continuous homomorphism `α^m − α^{kn}` maps the connected `X` into the
finite `Y`, its zero set is clopen and contains `0`, so it vanishes: the action is virtually cyclic. -/
theorem noVirtuallyCyclicFactors_of_isIrreducible [IsTopologicalAddGroup X] [T1Space X] [ConnectedSpace X]
    (α : ZdAction d X) (hirr : α.IsIrreducible) (hvc : ¬ α.IsVirtuallyCyclic) : α.NoVirtuallyCyclicFactors := by
  intro Y hY hinv hne hmod
  have hYfin : (Y : Set X).Finite := (hirr Y hY hinv).resolve_right hne
  -- a continuous additive map with values in the finite `Y` vanishes on the connected `X`
  have hzero : ∀ f : X →+ X, Continuous f → (∀ x, f x ∈ Y) → f = 0 := by
    intro f hf hfY
    have hclosed : IsClosed (f ⁻¹' {0}) := isClosed_singleton.preimage hf
    have hopen : IsOpen (f ⁻¹' {0}) := by
      have hc : IsClosed (f ⁻¹' ((Y : Set X) \ {0})) :=
        (hYfin.subset Set.sdiff_subset).isClosed.preimage hf
      have he : f ⁻¹' {0} = (f ⁻¹' ((Y : Set X) \ {0}))ᶜ := by
        ext x
        simp only [Set.mem_preimage, Set.mem_singleton_iff, Set.mem_compl_iff, Set.mem_sdiff, not_and, not_not]
        exact ⟨fun h _ => h, fun h => h (hfY x)⟩
      rw [he]
      exact hc.isOpen_compl
    have huniv := (IsClopen.eq_univ ⟨hclosed, hopen⟩ ⟨0, by simp⟩)
    ext x
    have hx : x ∈ f ⁻¹' {0} := huniv ▸ Set.mem_univ x
    simpa using hx
  apply hvc
  obtain ⟨n, Λ, hΛ, h⟩ := hmod
  refine ⟨n, Λ, hΛ, fun m hm => ?_⟩
  obtain ⟨k, hk⟩ := h m hm
  refine ⟨k, ?_⟩
  have h0 := hzero (α m - α (k • n)) ((α.continuous' m).sub (α.continuous' (k • n))) fun x => by
    simpa using hk x
  exact sub_eq_zero.1 h0

/-- **`α^{q n}` is the `q`-th iterate of `α^n`**: `map_add'` and induction on `q`. -/
theorem coe_nsmul (α : ZdAction d X) (q : ℕ) (n : Fin d → ℤ) : ⇑(α (q • n)) = (⇑(α n))^[q] := by
  induction q with
  | zero =>
    rw [zero_smul, Function.iterate_zero]
    show ⇑(α.toFun 0) = id
    rw [α.map_zero']
    rfl
  | succ q ih =>
    rw [succ_nsmul, Function.iterate_succ, ← ih]
    show ⇑(α.toFun (q • n + n)) = ⇑(α.toFun (q • n)) ∘ ⇑(α.toFun n)
    rw [α.map_add']
    rfl

/-- **Haar measure is invariant under every `α^n`** (C1 of FS105-DED § 2.2): `(α^n)_* m` is a left-invariant probability
measure — `g + α^n x = α^n (α^{-n} g + x)` — hence a Haar probability measure
(`MeasureTheory.Measure.isAddHaarMeasure_of_isCompact_nonempty_interior` at `univ`), hence `m`
(`MeasureTheory.Measure.isAddHaarMeasure_eq_of_isProbabilityMeasure`; a compact Hausdorff group is locally compact). -/
theorem map_eq_of_isAddHaarMeasure [IsTopologicalAddGroup X] [CompactSpace X] [MeasurableSpace X]
    [BorelSpace X] (α : ZdAction d X) (ν : Measure X) [IsProbabilityMeasure ν] [ν.IsAddHaarMeasure]
    (n : Fin d → ℤ) : ν.map (α n) = ν := by
  have hcont : ∀ m, Continuous (α m) := α.continuous'
  have hmeas : ∀ m, Measurable (α m) := fun m => (hcont m).measurable
  -- `α n` is a bijection with inverse `α (−n)`
  have hinv : ∀ x, α n (α (-n) x) = x := by
    intro x
    have h := α.map_add' n (-n)
    rw [add_neg_cancel, α.map_zero'] at h
    exact (DFunLike.congr_fun h x).symm
  haveI : IsProbabilityMeasure (ν.map (α n)) := Measure.isProbabilityMeasure_map (hmeas n).aemeasurable
  haveI : (ν.map (α n)).IsAddLeftInvariant := by
    refine ⟨fun g => ?_⟩
    rw [Measure.map_map (measurable_const_add g) (hmeas n)]
    have hcomp : (fun x => g + x) ∘ ⇑(α n) = ⇑(α n) ∘ fun x => α (-n) g + x := by
      funext x
      simp only [Function.comp_apply, map_add, hinv]
    rw [hcomp, ← Measure.map_map (hmeas n) (measurable_const_add _), map_add_left_eq_self]
  haveI : (ν.map (α n)).IsAddHaarMeasure :=
    Measure.isAddHaarMeasure_of_isCompact_nonempty_interior _ Set.univ isCompact_univ
      (by rw [interior_univ]; exact Set.univ_nonempty) (by simp) (by simp)
  exact Measure.isAddHaarMeasure_eq_of_isProbabilityMeasure _ _

/-- **An ergodic measure with an invariant component is that component** (FS105-DED step 2, C3, with no use of clause (3)
of the declared theorem): if `µ = J⁻¹(ν 1 + … + ν J)` with mutually singular probability measures and `ν j₀` is
`α`-invariant, then `µ = ν j₀`. Route: `A := ⋂_{k ≠ j₀}` of the null sets of `ν k ⟂ ν j₀`, `A′ := ⋂_n (α^n)⁻¹ A`, exactly
invariant, `ν j₀ (A′ᶜ) = 0` and `ν k A′ = 0` for `k ≠ j₀`; so `µ A′ = J⁻¹` and `µ A′ᶜ = (J − 1)/J`, and ergodicity
forces `J = 1`. Where `J ≥ 2` the hypotheses have no model — that is the content. -/
theorem eq_of_isErgodicOn_of_invariant_component [MeasurableSpace X] [BorelSpace X] (α : ZdAction d X) (μ : Measure X)
    (herg : α.IsErgodicOn ⊤ μ) {J : ℕ} (ν : Fin J → Measure X) (hμ : μ = (J : ℝ≥0∞)⁻¹ • ∑ j, ν j)
    (hsing : ∀ i j, i ≠ j → ν i ⟂ₘ ν j) (hprob : ∀ j, IsProbabilityMeasure (ν j)) (j₀ : Fin J)
    (hinv : ∀ n, (ν j₀).map (α n) = ν j₀) : μ = ν j₀ := by
  classical
  have hmeas : ∀ n, Measurable (α n) := fun n => (α.continuous' n).measurable
  -- `A`: null for every `ν k`, `k ≠ j₀`, and conull for `ν j₀`
  let N : Fin J → Set X := fun k => if h : k = j₀ then Set.univ else (hsing k j₀ h).nullSet
  have hNm : ∀ k, MeasurableSet (N k) := fun k => by
    by_cases h : k = j₀
    · simp [N, h]
    · simp only [N, dif_neg h]
      exact (hsing k j₀ h).measurableSet_nullSet
  set A := ⋂ k, N k with hA
  have hAm : MeasurableSet A := MeasurableSet.iInter hNm
  have hAk : ∀ k, k ≠ j₀ → ν k A = 0 := fun k hk =>
    measure_mono_null (Set.iInter_subset _ k) (by
      rw [show N k = (hsing k j₀ hk).nullSet from dif_neg hk]
      exact (hsing k j₀ hk).measure_nullSet)
  have hAj₀ : ν j₀ Aᶜ = 0 := by
    rw [hA, Set.compl_iInter]
    refine measure_iUnion_null fun k => ?_
    by_cases h : k = j₀
    · simp [N, h]
    · rw [show N k = (hsing k j₀ h).nullSet from dif_neg h]
      exact (hsing k j₀ h).measure_compl_nullSet
  -- `A′ = ⋂ₙ (αⁿ)⁻¹ A`, exactly invariant
  set A' := ⋂ n : Fin d → ℤ, (α n) ⁻¹' A with hA'
  have hA'm : MeasurableSet A' := MeasurableSet.iInter fun n => hmeas n hAm
  have hA'inv : ∀ m, (α m) ⁻¹' A' = A' := by
    intro m
    ext x
    simp only [hA', Set.mem_preimage, Set.mem_iInter]
    constructor
    · intro h n
      have := h (n - m)
      have e : α (n - m) (α m x) = α n x := by
        have h1 := α.map_add' (n - m) m
        rw [sub_add_cancel] at h1
        exact (DFunLike.congr_fun h1 x).symm
      rwa [e] at this
    · intro h n
      have e : α n (α m x) = α (n + m) x := by
        have h1 := α.map_add' n m
        exact (DFunLike.congr_fun h1 x).symm
      rw [e]
      exact h (n + m)
  have hA'j₀ : ν j₀ A'ᶜ = 0 := by
    rw [hA', Set.compl_iInter]
    refine measure_iUnion_null fun n => ?_
    rw [← Set.preimage_compl, ← Measure.map_apply (hmeas n) hAm.compl, hinv n]
    exact hAj₀
  have hA'k : ∀ k, k ≠ j₀ → ν k A' = 0 := fun k hk =>
    measure_mono_null (fun x hx => by
      have := Set.mem_iInter.1 hx 0
      have e : α 0 x = x := by
        show α.toFun 0 x = x
        rw [α.map_zero']
        rfl
      rwa [Set.mem_preimage, e] at this) (hAk k hk)
  -- ergodicity
  have hJ : (J : ℝ≥0∞) ≠ 0 := by
    have : 0 < J := Fin.pos_iff_nonempty.2 ⟨j₀⟩
    exact_mod_cast this.ne'
  rcases herg.2 A' hA'm (fun n _ => hA'inv n) with h0 | h0
  · -- `μ A′ ≥ J⁻¹ ν j₀ A′ = J⁻¹`
    exfalso
    have h1 : ν j₀ A' = 1 := by
      haveI := hprob j₀
      have := prob_add_prob_compl (μ := ν j₀) hA'm
      rw [hA'j₀, add_zero] at this
      exact this
    rw [hμ, Measure.smul_apply, Measure.coe_finsetSum, Finset.sum_apply, smul_eq_mul, mul_eq_zero] at h0
    rcases h0 with h0 | h0
    · exact ENNReal.inv_ne_zero.2 (ENNReal.natCast_ne_top J) h0
    · have := (Finset.sum_eq_zero_iff.1 h0) j₀ (Finset.mem_univ _)
      rw [h1] at this
      exact one_ne_zero this
  · -- no other component: each would give `A′ᶜ` mass
    have hall : ∀ k, k = j₀ := by
      intro k
      by_contra hk
      have h1 : ν k A'ᶜ = 1 := by
        haveI := hprob k
        have := prob_add_prob_compl (μ := ν k) hA'm
        rw [hA'k k hk, zero_add] at this
        exact this
      rw [hμ, Measure.smul_apply, Measure.coe_finsetSum, Finset.sum_apply, smul_eq_mul, mul_eq_zero] at h0
      rcases h0 with h0 | h0
      · exact ENNReal.inv_ne_zero.2 (ENNReal.natCast_ne_top J) h0
      · have := (Finset.sum_eq_zero_iff.1 h0) k (Finset.mem_univ _)
        rw [h1] at this
        exact one_ne_zero this
    have hcard : J = 1 := by
      have := Fintype.card_le_one_iff.2 fun a b => (hall a).trans (hall b).symm
      have h1 : 0 < J := Fin.pos_iff_nonempty.2 ⟨j₀⟩
      simp only [Fintype.card_fin] at this
      omega
    subst hcard
    rw [hμ, Fin.sum_univ_one, Nat.cast_one, inv_one, one_smul]
    rw [Subsingleton.elim j₀ 0]

/-- **`×2, ×3` on the line**: `n ↦ (x ↦ 2^{n₀} 3^{n₁} x)`, an action of `ℤ²` by continuous automorphisms of `ℝ` — the model of
FS105-NVC's hypotheses (`mulTwoThree_model`). -/
noncomputable def mulTwoThree : ZdAction 2 ℝ where
  toFun n := AddMonoidHom.mulLeft ((2 : ℝ) ^ n 0 * (3 : ℝ) ^ n 1)
  map_zero' := by
    ext x
    simp
  map_add' m n := by
    ext x
    simp only [Pi.add_apply, AddMonoidHom.coe_mulLeft, AddMonoidHom.coe_comp, Function.comp_apply]
    rw [zpow_add₀ two_ne_zero, zpow_add₀ three_ne_zero]
    ring
  continuous' n := continuous_const_mul _

-- `α^{(1, 0)}` doubles.
example : mulTwoThree ![1, 0] 1 = 2 := by
  simp [mulTwoThree]

/-- `2^m = 3^n` or `2^m · 3^n = 1` in `ℕ` only at `m = n = 0`: `2^m` is even unless `m = 0`, `3^n` is odd. -/
private theorem two_pow_three_pow_nat {m n : ℕ} (h : 2 ^ m = 3 ^ n ∨ 2 ^ m * 3 ^ n = 1) : m = 0 ∧ n = 0 := by
  have h3 : ∀ k : ℕ, 3 ^ k = 1 → k = 0 := fun k hk =>
    Nat.pow_right_injective (le_refl 2) (show 2 ^ k = 2 ^ 0 from by
      have := Nat.pow_right_injective (by norm_num : 2 ≤ 3) (show 3 ^ k = 3 ^ 0 by rw [hk, pow_zero])
      rw [this])
  have h2 : ∀ k : ℕ, 2 ^ k = 1 → k = 0 := fun k hk =>
    Nat.pow_right_injective (le_refl 2) (show 2 ^ k = 2 ^ 0 by rw [hk, pow_zero])
  rcases h with h | h
  · have hm : m = 0 := by
      by_contra hm
      have he : Even (2 ^ m) := (Nat.even_pow' hm).2 even_two
      rw [h] at he
      exact (Nat.not_even_iff_odd.2 (Odd.pow (by decide : Odd 3))) he
    subst hm
    exact ⟨rfl, h3 n (by rw [← h, pow_zero])⟩
  · exact ⟨h2 m (Nat.eq_one_of_mul_eq_one_right h), h3 n (Nat.eq_one_of_mul_eq_one_left h)⟩

/-- **Unique factorisation at `2` and `3`**: `2^x = 3^y` in `ℝ` with `x y : ℤ` only at `x = y = 0`. -/
private theorem two_zpow_eq_three_zpow {x y : ℤ} (h : (2 : ℝ) ^ x = (3 : ℝ) ^ y) : x = 0 ∧ y = 0 := by
  obtain ⟨m, hm | hm⟩ := Int.eq_nat_or_neg x <;> obtain ⟨n, hn | hn⟩ := Int.eq_nat_or_neg y <;> subst hm hn <;>
    simp only [zpow_neg, zpow_natCast] at h
  · have := two_pow_three_pow_nat (m := m) (n := n) (Or.inl (by exact_mod_cast h))
    omega
  · have h' : (2 : ℝ) ^ m * 3 ^ n = 1 := by rw [h, inv_mul_cancel₀ (pow_ne_zero _ three_ne_zero)]
    have := two_pow_three_pow_nat (m := m) (n := n) (Or.inr (by exact_mod_cast h'))
    omega
  · have h' : (2 : ℝ) ^ m * 3 ^ n = 1 := by
      rw [← h, mul_inv_cancel₀ (pow_ne_zero _ two_ne_zero)]
    have := two_pow_three_pow_nat (m := m) (n := n) (Or.inr (by exact_mod_cast h'))
    omega
  · have h' : (2 : ℝ) ^ m = 3 ^ n := inv_inj.mp h
    have := two_pow_three_pow_nat (m := m) (n := n) (Or.inl (by exact_mod_cast h'))
    omega

/-- **Unique factorisation at `2` and `3`**: `2^a 3^b = 2^c 3^d` in `ℝ` forces `a = c` and `b = d`. -/
private theorem two_three_zpow_inj {a b c e : ℤ} (h : (2 : ℝ) ^ a * (3 : ℝ) ^ b = (2 : ℝ) ^ c * (3 : ℝ) ^ e) :
    a = c ∧ b = e := by
  have h' : (2 : ℝ) ^ (a - c) = (3 : ℝ) ^ (e - b) := by
    rw [zpow_sub₀ two_ne_zero, zpow_sub₀ three_ne_zero,
      div_eq_div_iff (zpow_ne_zero _ two_ne_zero) (zpow_ne_zero _ three_ne_zero)]
    linear_combination h
  have := two_zpow_eq_three_zpow h'
  omega

private theorem mulTwoThree_apply (n : Fin 2 → ℤ) (x : ℝ) :
    mulTwoThree n x = (2 : ℝ) ^ n 0 * (3 : ℝ) ^ n 1 * x := rfl

/-- **A model of FS105-NVC's hypotheses**, every clause exercised: `×2, ×3` on `ℝ` (a connected T1 group) is irreducible —
a subgroup of `ℝ` is dense or cyclic (`AddSubgroup.dense_or_cyclic`), a closed dense one is `ℝ`, and `aℤ` with `a ≠ 0` is
not mapped onto itself by doubling (`a = 2ka` gives `2k = 1`) — and not virtually cyclic — `2^a 3^b = 2^c 3^d` forces
`a = c`, `b = d` (parity in `ℕ`), so the multiples `(N, 0)` and `(0, N)` of `Λ`'s index `N` are not both multiples of one
`n`. -/
theorem mulTwoThree_model : mulTwoThree.IsIrreducible ∧ ¬ mulTwoThree.IsVirtuallyCyclic := by
  refine ⟨fun Y _hY hinv => ?_, fun ⟨n, Λ, hΛ, hm⟩ => ?_⟩
  · -- a closed subgroup of `ℝ` is dense, hence everything, or cyclic; a nonzero cyclic one is not doubled onto itself
    rcases Y.dense_or_cyclic with hd | ⟨a, ha⟩
    · exact Or.inr (SetLike.coe_injective (by rw [AddSubgroup.coe_top, ← _hY.closure_eq, hd.closure_eq]))
    · by_cases ha0 : a = 0
      · left
        subst ha0
        rw [ha, AddSubgroup.closure_singleton_zero, AddSubgroup.coe_bot]
        exact Set.finite_singleton 0
      · exfalso
        have haY : a ∈ Y := ha ▸ AddSubgroup.subset_closure rfl
        have hmap := hinv ![1, 0] (AddSubgroup.mem_top _)
        rw [← hmap] at haY
        obtain ⟨y, hy, hya⟩ := AddSubgroup.mem_map.mp haY
        rw [ha, AddSubgroup.mem_closure_singleton] at hy
        obtain ⟨k, rfl⟩ := hy
        rw [mulTwoThree_apply] at hya
        simp only [Matrix.cons_val_zero, Matrix.cons_val_one, zpow_one, zpow_zero, mul_one, zsmul_eq_mul] at hya
        have h2k : ((2 * k - 1 : ℤ) : ℝ) * a = 0 := by push_cast; linarith
        have hk : (2 * k - 1 : ℤ) = 0 := by
          have := (mul_eq_zero.mp h2k).resolve_right ha0
          exact_mod_cast this
        omega
  · -- `(N, 0)` and `(0, N)` lie in `Λ` (`N` its index); each a multiple of one `n` forces `N = 0`
    have hN : Λ.index ≠ 0 := hΛ.index_ne_zero
    obtain ⟨k₁, hk₁⟩ := hm (Λ.index • ![1, 0]) (Λ.nsmul_index_mem _)
    obtain ⟨k₂, hk₂⟩ := hm (Λ.index • ![0, 1]) (Λ.nsmul_index_mem _)
    have e₁ := congrArg (fun f => f (1 : ℝ)) hk₁
    have e₂ := congrArg (fun f => f (1 : ℝ)) hk₂
    have v : ∀ (N : ℕ) (i j : ℤ), (N • ![i, j] : Fin 2 → ℤ) 0 = N * i ∧ (N • ![i, j] : Fin 2 → ℤ) 1 = N * j :=
      fun N i j => by simp
    have w : ∀ (k : ℤ) (i : Fin 2), (k • n) i = k * n i := fun k i => by simp
    simp only [mulTwoThree_apply, mul_one] at e₁ e₂
    rw [(v _ 1 0).1, (v _ 1 0).2, w, w] at e₁
    rw [(v _ 0 1).1, (v _ 0 1).2, w, w] at e₂
    obtain ⟨a₁, b₁⟩ := two_three_zpow_inj e₁
    obtain ⟨a₂, b₂⟩ := two_three_zpow_inj e₂
    have hNz : (Λ.index : ℤ) ≠ 0 := by exact_mod_cast hN
    rw [mul_one] at a₁ b₂
    rw [mul_zero] at b₁ a₂
    have hk₁ : k₁ ≠ 0 := fun h => hNz (by rw [a₁, h, zero_mul])
    have hn₁ : n 1 = 0 := (mul_eq_zero.mp b₁.symm).resolve_left hk₁
    exact hNz (by rw [b₂, hn₁, mul_zero])

/-- **A model of the invariant-component statement's hypotheses** at `J = 1` (where its conclusion is `µ = ν 0`): the
trivial action on the one-point group, `µ = ν 0` the point mass. At `J ≥ 2` the hypotheses have no model; that is the
statement's content. -/
theorem invariantComponent_model :
    (trivial 2 Unit).IsErgodicOn ⊤ (Measure.dirac ()) ∧
      Measure.dirac () = ((1 : ℕ) : ℝ≥0∞)⁻¹ • ∑ j : Fin 1, (fun _ => Measure.dirac ()) j ∧
      IsProbabilityMeasure (Measure.dirac ()) ∧ ∀ n, (Measure.dirac ()).map ((trivial 2 Unit) n) = Measure.dirac () := by
  refine ⟨trivialAction_isErgodicOn 2 ⊤, by simp, inferInstance, fun n => ?_⟩
  exact Measure.map_dirac' (measurable_of_countable _) () |>.trans (by rfl)

end ZdAction

/-- **A model of the Haar statements' hypotheses**: the uniform probability on the compact group `ℤ/2` is invariant under
every translation (`isAddHaarMeasure_of_add_invariant`), and so is a Haar probability measure, the hypothesis of
`ZdAction.map_eq_of_isAddHaarMeasure`. -/
theorem finTwo_haar_model :
    IsProbabilityMeasure ((2 : ℝ≥0∞)⁻¹ • Measure.count : Measure (Fin 2)) ∧
      ∀ (g : Fin 2) (B : Set (Fin 2)), MeasurableSet B →
        ((2 : ℝ≥0∞)⁻¹ • Measure.count : Measure (Fin 2)) ((fun x => x + g) ⁻¹' B) =
          ((2 : ℝ≥0∞)⁻¹ • Measure.count : Measure (Fin 2)) B := by
  refine ⟨⟨?_⟩, fun g B hB => ?_⟩
  · rw [Measure.smul_apply, Measure.count_univ, smul_eq_mul]
    simp only [ENat.card_eq_coe_fintype_card, Fintype.card_fin]
    exact ENNReal.inv_mul_cancel (by norm_num) (by norm_num)
  · rw [Measure.smul_apply, Measure.smul_apply]
    congr 1
    have := map_add_right_eq_self (Measure.count : Measure (Fin 2)) g
    rw [← Measure.map_apply (measurable_add_const g) hB, this]

/-- **A translation-invariant probability measure on a compact group is a Haar measure** (C1 of FS105-DED § 2.2, the half
read in Case A): clause (2) of the declared theorem with `G j = X` says `ν((· + g)⁻¹ B) = ν B` for every `g` and measurable
`B`, which is left invariance (`X` is commutative); then
`MeasureTheory.Measure.isAddHaarMeasure_of_isCompact_nonempty_interior` at `K = univ`. -/
theorem isAddHaarMeasure_of_add_invariant {X : Type*} [AddCommGroup X] [TopologicalSpace X] [IsTopologicalAddGroup X]
    [CompactSpace X] [MeasurableSpace X] [BorelSpace X] (ν : Measure X) [IsProbabilityMeasure ν]
    (h : ∀ g : X, ∀ B : Set X, MeasurableSet B → ν ((fun x => x + g) ⁻¹' B) = ν B) : ν.IsAddHaarMeasure := by
  haveI : ν.IsAddLeftInvariant := by
    refine ⟨fun g => Measure.ext fun B hB => ?_⟩
    rw [Measure.map_apply (measurable_const_add g) hB]
    have hcomm : (fun x => g + x) ⁻¹' B = (fun x => x + g) ⁻¹' B := by
      ext x
      simp [add_comm]
    rw [hcomm, h g B hB]
  haveI : Nonempty X := nonempty_of_isProbabilityMeasure ν
  exact Measure.isAddHaarMeasure_of_isCompact_nonempty_interior ν Set.univ isCompact_univ
    (by rw [interior_univ]; exact Set.univ_nonempty) (by simp) (by simp)

/-- **`[EinsiedlerLindenstrauss2022]` Theorem 1.2 (p. 2)**: "Let `α` be a totally irreducible, not virtually-cyclic
`ℤ^d`-action by automorphisms of a solenoid `X`. Let `µ` be an `α`-invariant and ergodic probability measure. Then either
`µ = m_X` is the Haar measure of `X`, or the entropy `h_µ(αⁿ) = 0` vanishes for all `n ∈ ℤ^d`." **Ours to prove** from
`positive_entropy_rigidity` (FS105-DED): Theorem 1.3 applies (FS105-NVC); each `G j` is finite or `X`; some `G j = X` makes
`µ` translation-invariant; every `G j` finite gives entropy zero through the finite-fibred factors. No inhabitant of the
hypotheses is in the library yet: PE-1′ supplies the pieces `M̂`.

**No `PolishSpace`** (FS131-KN9, the coordinator's ruling of 2026-10-14; the binder FS131-KN8 added is gone): the
finite-fibred step holds over the Borel σ-algebra of `X ⧸ G j` that clause (4) of the declared theorem states, for every
compact T1 group (`Rigidity.ksEntropy_eq_zero_iff_of_finite`: the projection is an open embedding on each translate of a
small open set, so no Lusin–Souslin is read), and Haar uniqueness asks local compactness only. So the proof reads
`positive_entropy_rigidity` as declared.

**Its proof's children** (FS131-KN9, `plans/FS131-KN9-chain-zero-entropy.md` § Stage 2) are the statements of the section
above and of `Rigidity/EntropyFibres`: step 0 by FS105-NVC, the declared theorem as stated, step 1 inline, Case A
through Haar measure and the invariant component, Case B through the finite-fibred step, the finite mixture and the power. -/
theorem haar_or_zero_entropy {X : Type*} [AddCommGroup X] [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X]
    (hX : IsSolenoid X) {d : ℕ} (α : ZdAction d X) (hirr : α.IsTotallyIrreducible)
    (hvc : ¬ α.IsVirtuallyCyclic) (μ : Measure X) (hμ : IsProbabilityMeasure μ) (herg : α.IsErgodicOn ⊤ μ) :
    μ.IsAddHaarMeasure ∨ ∀ n : Fin d → ℤ, ksEntropy μ (α n) = 0 := by
  haveI := hX.isTopologicalAddGroup
  haveI := hX.t2Space
  haveI := hX.compactSpace
  haveI := hX.connectedSpace
  have hd := ZdAction.two_le_of_not_isVirtuallyCyclic α hvc
  have hnvc := ZdAction.noVirtuallyCyclicFactors_of_isIrreducible α hirr.isIrreducible hvc
  obtain ⟨Λ, J, ν, G, hΛ, hJ, hμeq, hsing, hj⟩ := positive_entropy_rigidity hX hd α hnvc μ hμ herg
  by_cases hA : ∃ j, G j = ⊤
  · -- Case A: a component invariant under every translation is Haar, and is `μ`
    left
    obtain ⟨j₀, hj₀⟩ := hA
    obtain ⟨hprob, -, ⟨-, -, htr⟩, -, -⟩ := hj j₀
    haveI := hprob
    haveI hhaar : (ν j₀).IsAddHaarMeasure :=
      isAddHaarMeasure_of_add_invariant (ν j₀) fun g B hB => htr g (by rw [hj₀]; trivial) B hB
    have heq := ZdAction.eq_of_isErgodicOn_of_invariant_component α μ herg ν hμeq hsing (fun j => (hj j).1) j₀
      fun n => ZdAction.map_eq_of_isAddHaarMeasure α (ν j₀) n
    rw [heq]
    exact hhaar
  · -- Case B: every `G j` is finite, so entropy zero passes up from the factors
    right
    push Not at hA
    have hfin : ∀ j, ((G j : AddSubgroup X) : Set X).Finite := fun j => by
      obtain ⟨-, -, ⟨hcl, hinvG, -⟩, -, -⟩ := hj j
      exact (hirr Λ hΛ (G j) hcl hinvG).resolve_right (hA j)
    have hΛzero : ∀ n ∈ Λ, ksEntropy μ (α n) = 0 := by
      intro n hn
      have hcomp : ∀ j, ksEntropy (ν j) (α n) = 0 := by
        intro j
        obtain ⟨hprob, hergj, ⟨-, hinvG, -⟩, -, h4⟩ := hj j
        haveI := hprob
        have hle : G j ≤ (G j).comap (α n) := by
          intro g hg
          have h1 := hinvG n hn
          rw [AddSubgroup.mem_comap, ← h1]
          exact AddSubgroup.mem_map_of_mem _ hg
        exact (ksEntropy_eq_zero_iff_of_finite (G j) (hfin j) (α n) (α.continuous' n) hle (ν j)
          (hergj.1 n hn)).1 (h4 n hn hle)
      rw [hμeq]
      exact ksEntropy_finite_mixture_eq_zero ν (fun j => (hj j).1) (α.continuous' n).measurable
        (fun j => (hj j).2.1.1 n hn) hcomp
    intro n
    have hq : 0 < Λ.index := Nat.pos_of_ne_zero hΛ.index_ne_zero
    have h1 := hΛzero _ (Λ.nsmul_index_mem n)
    rw [ZdAction.coe_nsmul] at h1
    exact ksEntropy_eq_zero_of_iterate μ (α.continuous' n).measurable hq h1

end HadwigerNelson.Rigidity
