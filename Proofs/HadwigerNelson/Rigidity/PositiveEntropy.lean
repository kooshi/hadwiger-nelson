import Proofs.HadwigerNelson.Rigidity.Entropy
import Proofs.HadwigerNelson.Rigidity.Solenoid
import Mathlib.MeasureTheory.Measure.MutuallySingular
import Mathlib.MeasureTheory.Group.Measure
import Mathlib.GroupTheory.QuotientGroup.Basic

/-!
# The positive entropy rigidity theorem of Einsiedler and Lindenstrauss, declared; its totally irreducible case, stated (FS-131, job FS131-KN3; skeleton)

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

**The read-back, clause by clause, is `plans/FS131-KN3-chain-plan.md` § The four items.** Three places where the Lean
statement fixes a sense the page leaves to the reader, each chosen so that the axiom says no more than the page: "no
virtually cyclic factors" is `ZdAction.NoVirtuallyCyclicFactors` (the literal phrase is met by no action; module docstring of
`Rigidity/Solenoid`); the `µ_j` are probability measures (the page's "ergodic" and its factor `1/J`); the entropy on `X/G_j`
is `ksEntropy` for the quotient σ-algebra, which for a solenoid is the Borel σ-algebra of `X/G_j` — the infimum form of
the entropy, on the safe side of the page with nothing to prove (the axiom's docstring).

**Model of its hypotheses** (`positive_entropy_rigidity_model`): the one-point solenoid with the trivial action of `ℤ²`
and the point mass — degenerate, its clause on factors empty. The model that exercises every clause is PE-1′, a leaf of the
chain.

**Ours, stated here and not proved:** `haar_or_zero_entropy`, the paper's Theorem 1.2 (p. 2), which the paper attributes to
its announcement `[EinsiedlerLindenstrauss2003]`, where the proof is an outline. Its deduction from Theorem 1.3 is this
project's (FS105-DED, `plans/FS105-derivation.md`, [hand], two minds) and is a leaf to formalize
(`data/fs131/kn3/claims-M5-totally-irreducible.md`).
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
The page is quoted in the module docstring; the read-back is `plans/FS131-KN3-chain-plan.md` § The four items.

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
          ksEntropy ((ν j).map (QuotientAddGroup.mk' (G j))) (QuotientAddGroup.map (G j) (G j) (α n) h) = 0

/-- **A model of the hypotheses of `positive_entropy_rigidity`**: the one-point solenoid, the trivial action of `ℤ²`, the
point mass. Degenerate — there is no non-trivial factor to check; PE-1′ is the model that exercises that clause. -/
theorem positive_entropy_rigidity_model :
    ∃ (α : ZdAction 2 Unit) (μ : Measure Unit), IsSolenoid Unit ∧ α.NoVirtuallyCyclicFactors ∧ IsProbabilityMeasure μ ∧
      α.IsErgodicOn ⊤ μ :=
  ⟨ZdAction.trivial 2 Unit, Measure.dirac (), isSolenoid_unit, trivialAction_noVirtuallyCyclicFactors 2,
    inferInstance, trivialAction_isErgodicOn 2 ⊤⟩

-- The one-point group carries the Borel structure the axiom asks of `X`.
example : BorelSpace Unit := inferInstance

/-- **`[EinsiedlerLindenstrauss2022]` Theorem 1.2 (p. 2)**: "Let `α` be a totally irreducible, not virtually-cyclic
`ℤ^d`-action by automorphisms of a solenoid `X`. Let `µ` be an `α`-invariant and ergodic probability measure. Then either
`µ = m_X` is the Haar measure of `X`, or the entropy `h_µ(αⁿ) = 0` vanishes for all `n ∈ ℤ^d`." **Ours to prove** from
`positive_entropy_rigidity` (FS105-DED): Theorem 1.3 applies (FS105-NVC); each `G j` is finite or `X`; some `G j = X` makes
`µ` translation-invariant; every `G j` finite gives entropy zero through the finite-fibred factors. No inhabitant of the
hypotheses is in the library yet: PE-1′ supplies the pieces `M̂`. -/
theorem haar_or_zero_entropy {X : Type*} [AddCommGroup X] [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X]
    (hX : IsSolenoid X) {d : ℕ} (α : ZdAction d X) (hirr : α.IsTotallyIrreducible)
    (hvc : ¬ α.IsVirtuallyCyclic) (μ : Measure X) (hμ : IsProbabilityMeasure μ) (herg : α.IsErgodicOn ⊤ μ) :
    μ.IsAddHaarMeasure ∨ ∀ n : Fin d → ℤ, ksEntropy μ (α n) = 0 := by
  sorry

end HadwigerNelson.Rigidity
