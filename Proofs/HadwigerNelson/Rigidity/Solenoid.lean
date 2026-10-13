import Mathlib.Topology.Algebra.PontryaginDual
import Mathlib.Topology.Algebra.Group.Quotient
import Mathlib.GroupTheory.Index
import Mathlib.Dynamics.Ergodic.MeasurePreserving
import Mathlib.MeasureTheory.Measure.Dirac
import Mathlib.MeasureTheory.Constructions.BorelSpace.Basic

/-!
# Actions of `ℤ^d` by automorphisms of a solenoid: the words of the printed rigidity theorem (FS-131, job FS131-KN3; skeleton)

**Read aloud, against the page.** `[EinsiedlerLindenstrauss2022]` § 1, p. 2 (arXiv:2101.11120v1): "In the following a
solenoid `X` is a compact, connected, abelian group whose Pontryagin dual `X̂` can be embedded into a finite-dimensional vector
space over `ℚ`. … A `ℤ^d`-action `α` by automorphisms of a solenoid `X` is called irreducible if there is no proper infinite
closed subgroup which is invariant under `α`, and totally irreducible if there is no finite index subgroup `Λ ⊆ ℤ^d` and no
proper infinite closed subgroup `Y ⊆ X` which is invariant under the induced action `α_Λ`. A `ℤ^d`-action is virtually cyclic
if there exists `n ∈ ℤ^d` such that for every element `m ∈ Λ` of a finite index subgroup `Λ ⊆ ℤ^d` there exists some `k ∈ ℤ`
with `α^m = α^{kn}`."

Each is typed here in those words: `IsSolenoid`, `ZdAction` (a homomorphism `n ↦ α^n` from `ℤ^d` into the continuous
endomorphisms; each `α^n` is then an automorphism, with inverse `α^{-n}`), `ZdAction.IsIrreducible`,
`ZdAction.IsTotallyIrreducible`, `ZdAction.IsVirtuallyCyclic`. Groups are written additively, as on the page.

**"No virtually cyclic factors" — the sense the hypothesis is forced to have** (`ZdAction.NoVirtuallyCyclicFactors`). Read
literally the phrase is satisfied by no action: the trivial factor `X/X` is virtually cyclic (`α^m = id = α^{0·n}`). The
sense the paper uses (its Lemma 7.4, p. 32, applied to a factor `Y_irred ≠ 0`) and this project's reading (FS105-VC,
`plans/FS105-derivation.md`, three minds): **no non-trivial algebraic factor carries a virtually cyclic action**. An algebraic
factor (p. 4: a surjective continuous homomorphism intertwining the actions) is `X/Y` for a closed `α`-invariant subgroup
`Y`, non-trivial exactly when `Y ≠ X`, and the action induced on `X/Y` is virtually cyclic exactly when `α^m x − α^{kn} x ∈ Y`
for every `x` (`ZdAction.IsVirtuallyCyclicMod Y`: the page's sentence read on the quotient, with no quotient object built).

**Invariance and ergodicity of a measure** under the restriction of the action to a subgroup `Λ` (`ZdAction.IsErgodicOn`):
every `α^n`, `n ∈ Λ`, preserves `μ`, and every measurable set fixed by all of them is null or conull. For a countable group
this is the textbook definition (an almost invariant set differs from a strictly invariant one by a null set).

**Inhabitants.** The one-point group is a solenoid (`isSolenoid_unit`), with the trivial action of `ℤ²`; its only closed
subgroup is the whole group, so it has no non-trivial factor and `NoVirtuallyCyclicFactors` holds with nothing to check
(`trivialAction_noVirtuallyCyclicFactors`) — **a degenerate model: the factor clause is empty there.** The model that
exercises it is this project's own lemma PE-1′ (the pieces `M̂` with the action of an admissible `Γ ≅ ℤ²`), a leaf of the
chain (`data/fs131/kn3/claims-M6-pieces.md`).
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory

/-- **A solenoid** (`[EinsiedlerLindenstrauss2022]` p. 2): "a compact, connected, abelian group whose Pontryagin dual `X̂`
can be embedded into a finite-dimensional vector space over `ℚ`". Compact groups are Hausdorff, as throughout that paper. -/
structure IsSolenoid (X : Type*) [AddCommGroup X] [TopologicalSpace X] : Prop where
  /-- Addition and negation are continuous. -/
  isTopologicalAddGroup : IsTopologicalAddGroup X
  /-- Hausdorff. -/
  t2Space : T2Space X
  /-- Compact. -/
  compactSpace : CompactSpace X
  /-- Connected. -/
  connectedSpace : ConnectedSpace X
  /-- The Pontryagin dual embeds, as a group, into `ℚⁿ` for some `n`. -/
  dual_embeds : ∃ (n : ℕ) (f : PontryaginDual (Multiplicative X) →* Multiplicative (Fin n → ℚ)), Function.Injective f

/-- **A `ℤ^d`-action by automorphisms** of a topological abelian group: `n ↦ α^n`, a homomorphism from `ℤ^d` into the
continuous endomorphisms (so each `α^n` is an automorphism, with inverse `α^{-n}`). -/
structure ZdAction (d : ℕ) (X : Type*) [AddCommGroup X] [TopologicalSpace X] where
  /-- `n ↦ α^n`. -/
  toFun : (Fin d → ℤ) → X →+ X
  /-- `α^0 = id`. -/
  map_zero' : toFun 0 = AddMonoidHom.id X
  /-- `α^{m+n} = α^m ∘ α^n`. -/
  map_add' : ∀ m n, toFun (m + n) = (toFun m).comp (toFun n)
  /-- Each `α^n` is continuous. -/
  continuous' : ∀ n, Continuous (toFun n)

namespace ZdAction

variable {d : ℕ} {X : Type*} [AddCommGroup X] [TopologicalSpace X]

instance : CoeFun (ZdAction d X) fun _ => (Fin d → ℤ) → X →+ X := ⟨ZdAction.toFun⟩

/-- The trivial action. -/
def trivial (d : ℕ) (X : Type*) [AddCommGroup X] [TopologicalSpace X] : ZdAction d X where
  toFun _ := AddMonoidHom.id X
  map_zero' := rfl
  map_add' _ _ := rfl
  continuous' _ := continuous_id

/-- A subgroup invariant under the restriction of the action to `Λ`. -/
def InvariantOn (α : ZdAction d X) (Λ : AddSubgroup (Fin d → ℤ)) (Y : AddSubgroup X) : Prop :=
  ∀ n ∈ Λ, Y.map (α n) = Y

/-- **Irreducible**: "there is no proper infinite closed subgroup which is invariant under `α`". -/
def IsIrreducible (α : ZdAction d X) : Prop :=
  ∀ Y : AddSubgroup X, IsClosed (Y : Set X) → α.InvariantOn ⊤ Y → (Y : Set X).Finite ∨ Y = ⊤

/-- **Totally irreducible**: "there is no finite index subgroup `Λ ⊆ ℤ^d` and no proper infinite closed subgroup `Y ⊆ X`
which is invariant under the induced action `α_Λ`". -/
def IsTotallyIrreducible (α : ZdAction d X) : Prop :=
  ∀ Λ : AddSubgroup (Fin d → ℤ), Λ.FiniteIndex → ∀ Y : AddSubgroup X, IsClosed (Y : Set X) → α.InvariantOn Λ Y →
    (Y : Set X).Finite ∨ Y = ⊤

/-- **Virtually cyclic on the factor `X/Y`**: "there exists `n ∈ ℤ^d` such that for every element `m ∈ Λ` of a finite index
subgroup `Λ ⊆ ℤ^d` there exists some `k ∈ ℤ` with `α^m = α^{kn}`", the equality read in `X/Y`. -/
def IsVirtuallyCyclicMod (α : ZdAction d X) (Y : AddSubgroup X) : Prop :=
  ∃ (n : Fin d → ℤ) (Λ : AddSubgroup (Fin d → ℤ)), Λ.FiniteIndex ∧ ∀ m ∈ Λ, ∃ k : ℤ, ∀ x : X, α m x - α (k • n) x ∈ Y

/-- **Virtually cyclic** (`[EinsiedlerLindenstrauss2022]` p. 2). -/
def IsVirtuallyCyclic (α : ZdAction d X) : Prop :=
  ∃ (n : Fin d → ℤ) (Λ : AddSubgroup (Fin d → ℤ)), Λ.FiniteIndex ∧ ∀ m ∈ Λ, ∃ k : ℤ, α m = α (k • n)

/-- **No virtually cyclic factors**, in the sense the hypothesis of Theorem 1.3 is forced to have (module docstring;
FS105-VC): no closed `α`-invariant subgroup `Y ≠ X` has a virtually cyclic action on `X/Y`. -/
def NoVirtuallyCyclicFactors (α : ZdAction d X) : Prop :=
  ∀ Y : AddSubgroup X, IsClosed (Y : Set X) → α.InvariantOn ⊤ Y → Y ≠ ⊤ → ¬ α.IsVirtuallyCyclicMod Y

/-- Virtually cyclic is virtually cyclic on the factor by the trivial subgroup: the two definitions agree at `Y = 0`. -/
theorem isVirtuallyCyclicMod_bot (α : ZdAction d X) : α.IsVirtuallyCyclicMod ⊥ ↔ α.IsVirtuallyCyclic := by
  constructor
  · rintro ⟨n, Λ, hΛ, h⟩
    refine ⟨n, Λ, hΛ, fun m hm => ?_⟩
    obtain ⟨k, hk⟩ := h m hm
    exact ⟨k, AddMonoidHom.ext fun x => sub_eq_zero.mp (AddSubgroup.mem_bot.mp (hk x))⟩
  · rintro ⟨n, Λ, hΛ, h⟩
    refine ⟨n, Λ, hΛ, fun m hm => ?_⟩
    obtain ⟨k, hk⟩ := h m hm
    exact ⟨k, fun x => by rw [hk, sub_self]; exact AddSubgroup.zero_mem _⟩

/-- **`μ` is invariant and ergodic under the restriction of the action to `Λ`.** -/
def IsErgodicOn [MeasurableSpace X] (α : ZdAction d X) (Λ : AddSubgroup (Fin d → ℤ)) (μ : Measure X) : Prop :=
  (∀ n ∈ Λ, MeasurePreserving (α n) μ μ) ∧
    ∀ s : Set X, MeasurableSet s → (∀ n ∈ Λ, α n ⁻¹' s = s) → μ s = 0 ∨ μ sᶜ = 0

end ZdAction

/-! ## The degenerate model -/

/-- The one-point group is a solenoid: its dual is trivial and embeds in `ℚ⁰`. -/
theorem isSolenoid_unit : IsSolenoid Unit where
  isTopologicalAddGroup := inferInstance
  t2Space := inferInstance
  compactSpace := inferInstance
  connectedSpace := { isPreconnected_univ := Set.subsingleton_univ.isPreconnected, toNonempty := ⟨()⟩ }
  dual_embeds := ⟨0, 1, fun χ ψ _ => by
    ext x
    have hx : x = 1 := Subsingleton.elim _ _
    rw [hx, map_one, map_one]⟩

/-- On the one-point group there is no non-trivial factor, so the clause on factors has nothing to check. -/
theorem trivialAction_noVirtuallyCyclicFactors (d : ℕ) : (ZdAction.trivial d Unit).NoVirtuallyCyclicFactors :=
  fun Y _ _ hY => absurd (eq_top_iff.mpr fun x _ => by rw [Subsingleton.elim x 0]; exact Y.zero_mem) hY

/-- The point mass is invariant and ergodic for the trivial action on the one-point group. -/
theorem trivialAction_isErgodicOn (d : ℕ) (Λ : AddSubgroup (Fin d → ℤ)) :
    (ZdAction.trivial d Unit).IsErgodicOn Λ (Measure.dirac ()) := by
  refine ⟨fun n _ => MeasurePreserving.id _, fun s hs _ => ?_⟩
  by_cases h : () ∈ s
  · right
    rw [Measure.dirac_apply' _ hs.compl]
    simp [h]
  · left
    rw [Measure.dirac_apply' _ hs]
    simp [h]

-- Spec: the trivial action is virtually cyclic (so the factor clause cannot be dropped from `NoVirtuallyCyclicFactors`).
example : (ZdAction.trivial 2 Unit).IsVirtuallyCyclic :=
  ⟨0, ⊤, inferInstance, fun _ _ => ⟨0, rfl⟩⟩

end HadwigerNelson.Rigidity
