import Proofs.HadwigerNelson.Rigidity.Entropy
import Proofs.HadwigerNelson.Rigidity.Solenoid
import Proofs.HadwigerNelson.Rigidity.EntropyFibres
import Mathlib.MeasureTheory.Measure.MutuallySingular
import Mathlib.MeasureTheory.Group.Measure
import Mathlib.GroupTheory.QuotientGroup.Basic
import Mathlib.MeasureTheory.Constructions.Polish.Basic
import Mathlib.MeasureTheory.Measure.Haar.Unique

/-!
# The positive entropy rigidity theorem of Einsiedler and Lindenstrauss, declared; its totally irreducible case, stated (FS-131, jobs FS131-KN3 and FS131-KN7; skeleton)

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
  sorry

/-- **FS105-NVC, the factors** (FS105-DED step 0d, the primal route): an irreducible action on a connected T1 group that is
not virtually cyclic has no virtually cyclic factor. A closed invariant `Y ≠ X` is finite by irreducibility; if the action is
virtually cyclic modulo `Y`, then for `m ∈ Λ` the continuous homomorphism `α^m − α^{kn}` maps the connected `X` into the
finite `Y`, its zero set is clopen and contains `0`, so it vanishes: the action is virtually cyclic. -/
theorem noVirtuallyCyclicFactors_of_isIrreducible [IsTopologicalAddGroup X] [T1Space X] [ConnectedSpace X]
    (α : ZdAction d X) (hirr : α.IsIrreducible) (hvc : ¬ α.IsVirtuallyCyclic) : α.NoVirtuallyCyclicFactors := by
  sorry

/-- **`α^{q n}` is the `q`-th iterate of `α^n`**: `map_add'` and induction on `q`. -/
theorem coe_nsmul (α : ZdAction d X) (q : ℕ) (n : Fin d → ℤ) : ⇑(α (q • n)) = (⇑(α n))^[q] := by
  sorry

/-- **Haar measure is invariant under every `α^n`** (C1 of FS105-DED § 2.2): `(α^n)_* m` is a left-invariant probability
measure — `g + α^n x = α^n (α^{-n} g + x)` — hence a Haar probability measure
(`MeasureTheory.Measure.isAddHaarMeasure_of_isCompact_nonempty_interior` at `univ`), hence `m`
(`MeasureTheory.Measure.isAddHaarMeasure_eq_of_isProbabilityMeasure`; a compact Hausdorff group is locally compact). -/
theorem map_eq_of_isAddHaarMeasure [IsTopologicalAddGroup X] [CompactSpace X] [T2Space X] [MeasurableSpace X]
    [BorelSpace X] (α : ZdAction d X) (ν : Measure X) [IsProbabilityMeasure ν] [ν.IsAddHaarMeasure]
    (n : Fin d → ℤ) : ν.map (α n) = ν := by
  sorry

/-- **An ergodic measure with an invariant component is that component** (FS105-DED step 2, C3, with no use of clause (3)
of the declared theorem): if `µ = J⁻¹(ν 1 + … + ν J)` with mutually singular probability measures and `ν j₀` is
`α`-invariant, then `µ = ν j₀`. Route: `A := ⋂_{k ≠ j₀}` of the null sets of `ν k ⟂ ν j₀`, `A′ := ⋂_n (α^n)⁻¹ A`, exactly
invariant, `ν j₀ (A′ᶜ) = 0` and `ν k A′ = 0` for `k ≠ j₀`; so `µ A′ = J⁻¹` and `µ A′ᶜ = (J − 1)/J`, and ergodicity
forces `J = 1`. Where `J ≥ 2` the hypotheses have no model — that is the content. -/
theorem eq_of_isErgodicOn_of_invariant_component [MeasurableSpace X] [BorelSpace X] (α : ZdAction d X) (μ : Measure X)
    (herg : α.IsErgodicOn ⊤ μ) {J : ℕ} (ν : Fin J → Measure X) (hμ : μ = (J : ℝ≥0∞)⁻¹ • ∑ j, ν j)
    (hsing : ∀ i j, i ≠ j → ν i ⟂ₘ ν j) (hprob : ∀ j, IsProbabilityMeasure (ν j)) (j₀ : Fin J)
    (hinv : ∀ n, (ν j₀).map (α n) = ν j₀) : μ = ν j₀ := by
  sorry

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

/-- **A model of FS105-NVC's hypotheses**, every clause exercised: `×2, ×3` on `ℝ` (a connected T1 group) is irreducible —
a closed subgroup of `ℝ` is `0`, cyclic or `ℝ` (`Real.subgroup_dense_or_cyclic`-shape), and `cℤ` with `c ≠ 0` is not
invariant under doubling — and not virtually cyclic — `2^a 3^b = 1` forces `a = b = 0` (unique factorisation), so a
finite-index `Λ ∋ (N, 0), (0, N)` is not inside one line `ℤn`. -/
theorem mulTwoThree_model : mulTwoThree.IsIrreducible ∧ ¬ mulTwoThree.IsVirtuallyCyclic := by
  sorry

/-- **A model of the invariant-component statement's hypotheses** at `J = 1` (where its conclusion is `µ = ν 0`): the
trivial action on the one-point group, `µ = ν 0` the point mass. At `J ≥ 2` the hypotheses have no model; that is the
statement's content. -/
theorem invariantComponent_model :
    (trivial 2 Unit).IsErgodicOn ⊤ (Measure.dirac ()) ∧
      Measure.dirac () = ((1 : ℕ) : ℝ≥0∞)⁻¹ • ∑ j : Fin 1, (fun _ => Measure.dirac ()) j ∧
      IsProbabilityMeasure (Measure.dirac ()) ∧ ∀ n, (Measure.dirac ()).map ((trivial 2 Unit) n) = Measure.dirac () := by
  sorry

end ZdAction

/-- **A model of the Haar statements' hypotheses**: the uniform probability on the compact group `ℤ/2` is invariant under
every translation (`isAddHaarMeasure_of_add_invariant`), and so is a Haar probability measure, the hypothesis of
`ZdAction.map_eq_of_isAddHaarMeasure`. -/
theorem finTwo_haar_model :
    IsProbabilityMeasure ((2 : ℝ≥0∞)⁻¹ • Measure.count : Measure (Fin 2)) ∧
      ∀ (g : Fin 2) (B : Set (Fin 2)), MeasurableSet B →
        ((2 : ℝ≥0∞)⁻¹ • Measure.count : Measure (Fin 2)) ((fun x => x + g) ⁻¹' B) =
          ((2 : ℝ≥0∞)⁻¹ • Measure.count : Measure (Fin 2)) B := by
  sorry

/-- **A translation-invariant probability measure on a compact group is a Haar measure** (C1 of FS105-DED § 2.2, the half
read in Case A): clause (2) of the declared theorem with `G j = X` says `ν((· + g)⁻¹ B) = ν B` for every `g` and measurable
`B`, which is left invariance (`X` is commutative); then
`MeasureTheory.Measure.isAddHaarMeasure_of_isCompact_nonempty_interior` at `K = univ`. -/
theorem isAddHaarMeasure_of_add_invariant {X : Type*} [AddCommGroup X] [TopologicalSpace X] [IsTopologicalAddGroup X]
    [CompactSpace X] [MeasurableSpace X] [BorelSpace X] (ν : Measure X) [IsProbabilityMeasure ν]
    (h : ∀ g : X, ∀ B : Set X, MeasurableSet B → ν ((fun x => x + g) ⁻¹' B) = ν B) : ν.IsAddHaarMeasure := by
  sorry

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
  sorry

end HadwigerNelson.Rigidity
