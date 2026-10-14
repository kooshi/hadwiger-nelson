import Proofs.HadwigerNelson.Rigidity.DualGroup
import Mathlib.Analysis.Fourier.FiniteAbelian.Orthogonality
import Mathlib.Topology.Algebra.PontryaginDual

/-!
# Annihilators between a discrete abelian group and its dual (FS-131, job FS131-KPD1; skeleton)

**Read aloud, against the informal claim.** For an abelian group `G` and its characters `Ĝ = AddChar G Circle`, the pairing
`⟨χ, g⟩ = χ g` gives two annihilators, each the set of what kills everything on the other side:

* `dualAnnihilator N` (written `N^⊥ ⊆ Ĝ`) — the characters that are `1` on the subgroup `N ⊆ G`;
* `dualCoannihilator Y` (written `Y^⊥ ⊆ G`) — the points at which every character of `Y ⊆ Ĝ` is `1`.

They form a Galois connection (`gc_dualAnnihilator`: `Y ≤ N^⊥ ↔ N ≤ Y^⊥`, both saying that `Y` and `N` kill each other), so both
are antitone and `Y ≤ (Y^⊥)^⊥` for every `Y` (`le_dualAnnihilator_dualCoannihilator`) with no topology. The topology of
`Rigidity/DualGroup` enters twice: `N^⊥` is closed (`isClosed_dualAnnihilator`, each evaluation is continuous), and a subgroup
and its closure have one annihilator (`dualCoannihilator_topologicalClosure`). **The converse `(Y^⊥)^⊥ ≤ Y` for closed `Y` is
Pontryagin duality** (`Rigidity/Duality`), not proved here.

A finite count beside them, read by the chain's PE-1′ (`Rigidity.isTotallyIrreducible_pieceAction`, at `N ≠ 0`): if `G ⧸ N` is
finite, `N^⊥` is finite — a character trivial on `N` is a character of the finite group `G ⧸ N`
(`finite_dualAnnihilator`).

**Models.** `N = ⊥` (`dualAnnihilator_bot`, every character) and `Y = ⊥` (`dualCoannihilator_bot`, every point) exercise both
maps at their extreme; `finite_dualAnnihilator` at `N = ⊤` (one character). The module states nothing about an empty domain.
-/

namespace HadwigerNelson.Rigidity

open Topology

noncomputable section

variable {G : Type*} [AddCommGroup G]

/-- **`N^⊥`, the characters of `G` that are `1` on `N`.** -/
def dualAnnihilator (N : AddSubgroup G) : Subgroup (AddChar G Circle) where
  carrier := {χ | ∀ g ∈ N, χ g = 1}
  one_mem' := fun _ _ => AddChar.one_apply _
  mul_mem' := fun hχ hψ g hg => by rw [AddChar.mul_apply, hχ g hg, hψ g hg, one_mul]
  inv_mem' := fun hχ g hg => by rw [AddChar.inv_apply', hχ g hg, inv_one]

/-- **`Y^⊥`, the points of `G` at which every character in `Y` is `1`.** -/
def dualCoannihilator (Y : Subgroup (AddChar G Circle)) : AddSubgroup G where
  carrier := {g | ∀ χ ∈ Y, χ g = 1}
  zero_mem' := fun χ _ => AddChar.map_zero_eq_one χ
  add_mem' := fun hg hh χ hχ => by rw [AddChar.map_add_eq_mul, hg χ hχ, hh χ hχ, one_mul]
  neg_mem' := fun hg χ hχ => by rw [AddChar.map_neg_eq_inv, hg χ hχ, inv_one]

@[simp]
theorem mem_dualAnnihilator {N : AddSubgroup G} {χ : AddChar G Circle} :
    χ ∈ dualAnnihilator N ↔ ∀ g ∈ N, χ g = 1 :=
  Iff.rfl

@[simp]
theorem mem_dualCoannihilator {Y : Subgroup (AddChar G Circle)} {g : G} :
    g ∈ dualCoannihilator Y ↔ ∀ χ ∈ Y, χ g = 1 :=
  Iff.rfl

/-- **The two annihilators kill each other**: `Y ≤ N^⊥` exactly when `N ≤ Y^⊥`. -/
theorem le_dualAnnihilator_iff {N : AddSubgroup G} {Y : Subgroup (AddChar G Circle)} :
    Y ≤ dualAnnihilator N ↔ N ≤ dualCoannihilator Y :=
  ⟨fun h _ hg _ hχ => h hχ _ hg, fun h _ hχ _ hg => h hg _ hχ⟩

/-- **The Galois connection** (antitone on both sides, written through `OrderDual`); every closure statement about the pair
is a `GaloisConnection` lemma of Mathlib. -/
theorem gc_dualAnnihilator :
    GaloisConnection (OrderDual.toDual ∘ (dualAnnihilator : AddSubgroup G → Subgroup (AddChar G Circle)))
      (dualCoannihilator ∘ OrderDual.ofDual) :=
  fun _ _ => le_dualAnnihilator_iff

/-- `Y ≤ (Y^⊥)^⊥`, for every `Y` (no topology): every character in `Y` kills `Y^⊥`. -/
theorem le_dualAnnihilator_dualCoannihilator (Y : Subgroup (AddChar G Circle)) :
    Y ≤ dualAnnihilator (dualCoannihilator Y) :=
  le_dualAnnihilator_iff.mpr le_rfl

/-- `N ≤ (N^⊥)^⊥`, for every `N`. -/
theorem le_dualCoannihilator_dualAnnihilator (N : AddSubgroup G) :
    N ≤ dualCoannihilator (dualAnnihilator N) :=
  le_dualAnnihilator_iff.mp le_rfl

/-- The annihilator of a larger subgroup of the dual is smaller. -/
theorem dualCoannihilator_antitone : Antitone (dualCoannihilator : Subgroup (AddChar G Circle) → AddSubgroup G) :=
  fun _ _ h _ hg χ hχ => hg χ (h hχ)

/-- The annihilator of a larger subgroup of `G` is smaller. -/
theorem dualAnnihilator_antitone : Antitone (dualAnnihilator : AddSubgroup G → Subgroup (AddChar G Circle)) :=
  fun _ _ h _ hχ g hg => hχ g (h hg)

/-- **`((Y^⊥)^⊥)^⊥ = Y^⊥`** (the Galois connection's `u ∘ l ∘ u = u`). -/
theorem dualCoannihilator_dualAnnihilator_dualCoannihilator (Y : Subgroup (AddChar G Circle)) :
    dualCoannihilator (dualAnnihilator (dualCoannihilator Y)) = dualCoannihilator Y :=
  le_antisymm (dualCoannihilator_antitone (le_dualAnnihilator_dualCoannihilator Y))
    (le_dualCoannihilator_dualAnnihilator _)

/-- `⊥^⊥ = Ĝ`: every character is `1` at `0`. -/
@[simp]
theorem dualAnnihilator_bot : dualAnnihilator (⊥ : AddSubgroup G) = ⊤ :=
  eq_top_iff.mpr fun _ _ g hg => by rw [AddSubgroup.mem_bot.mp hg, AddChar.map_zero_eq_one]

/-- `⊥^⊥ = G` on the other side: the trivial character is `1` everywhere. -/
@[simp]
theorem dualCoannihilator_bot : dualCoannihilator (⊥ : Subgroup (AddChar G Circle)) = ⊤ :=
  eq_top_iff.mpr fun g _ χ hχ => by rw [Subgroup.mem_bot.mp hχ, AddChar.one_apply]

/-- **`Ĝ^⊥ = 0`**: separation (`Rigidity.exists_apply_ne_one`). -/
@[simp]
theorem dualCoannihilator_top : dualCoannihilator (⊤ : Subgroup (AddChar G Circle)) = ⊥ := by
  refine eq_bot_iff.mpr fun g hg => AddSubgroup.mem_bot.mpr ?_
  by_contra hne
  obtain ⟨ψ, hψ⟩ := exists_apply_ne_one hne
  exact hψ (hg ψ (Subgroup.mem_top ψ))

/-- `{χ | χ g = 1}` is closed (read through `ℂ`, where the evaluation is continuous: in this module's environment
`T2Space Circle` is not synthesized). -/
theorem isClosed_setOf_apply_eq_one (g : G) : IsClosed {χ : AddChar G Circle | χ g = 1} := by
  have h : {χ : AddChar G Circle | χ g = 1} = (fun χ : AddChar G Circle => (χ g : ℂ)) ⁻¹' {1} := by
    ext χ
    simp [Circle.ext_iff]
  rw [h]
  exact isClosed_singleton.preimage (continuous_evalChar G g)

/-- **`N^⊥` is closed** in the pointwise topology: an intersection of the closed sets `{χ | χ g = 1}`. -/
theorem isClosed_dualAnnihilator (N : AddSubgroup G) : IsClosed (dualAnnihilator N : Set (AddChar G Circle)) := by
  have h : (dualAnnihilator N : Set (AddChar G Circle)) = ⋂ g ∈ N, {χ | χ g = 1} := by
    ext χ
    simp
  rw [h]
  exact isClosed_biInter fun g _ => isClosed_setOf_apply_eq_one g

/-- **A subgroup and its closure have one annihilator**: `{χ | χ g = 1}` is closed. -/
theorem dualCoannihilator_topologicalClosure (Y : Subgroup (AddChar G Circle)) :
    dualCoannihilator Y.topologicalClosure = dualCoannihilator Y := by
  refine le_antisymm (dualCoannihilator_antitone Y.le_topologicalClosure) fun g hg χ hχ => ?_
  have hcl : IsClosed {χ : AddChar G Circle | χ g = 1} := isClosed_setOf_apply_eq_one g
  have hmem : χ ∈ closure (Y : Set (AddChar G Circle)) := by
    rwa [← Subgroup.topologicalClosure_coe]
  exact closure_minimal (fun ψ hψ => hg ψ hψ) hcl hmem

/-- **`N^⊥` is finite when `G ⧸ N` is**: restriction along `G → G ⧸ N` identifies `N^⊥` with the characters of the finite
group `G ⧸ N` (`AddChar.instFintype`). Read by PE-1′'s total irreducibility at `N ≠ 0`. -/
theorem finite_dualAnnihilator (N : AddSubgroup G) [Finite (G ⧸ N)] :
    (dualAnnihilator N : Set (AddChar G Circle)).Finite := by
  let e : dualAnnihilator N → AddChar (G ⧸ N) ℂ := fun χ =>
    Circle.coeHom.compAddChar (AddChar.toAddMonoidHomEquiv.symm
      (QuotientAddGroup.lift N (χ.1.toAddMonoidHom) fun g hg => by
        show Additive.ofMul (χ.1 g) = 0
        rw [χ.2 g hg]
        rfl))
  have he : Function.Injective e := by
    intro χ ψ h
    refine Subtype.ext (AddChar.ext _ _ fun g => Circle.ext ?_)
    have := congrArg (fun φ : AddChar (G ⧸ N) ℂ => φ (QuotientAddGroup.mk g)) h
    exact this
  haveI : Finite (dualAnnihilator N) := Finite.of_injective e he
  exact Set.toFinite _

-- Spec: at `N = ⊤` the annihilator is the trivial character alone (fails if `dualAnnihilator` drifts to `{χ | ∃ g ∈ N, …}`).
example : dualAnnihilator (⊤ : AddSubgroup ℤ) = ⊥ := by
  ext χ
  simp only [mem_dualAnnihilator, AddSubgroup.mem_top, true_implies, Subgroup.mem_bot]
  exact ⟨fun h => AddChar.ext χ 1 fun g => h g, fun h g => by rw [h, AddChar.one_apply]⟩

end

end HadwigerNelson.Rigidity
