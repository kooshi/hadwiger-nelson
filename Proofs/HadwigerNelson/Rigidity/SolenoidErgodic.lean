import Proofs.HadwigerNelson.Rigidity.Solenoid

/-!
# Ergodicity of a `ℤ^d`-action: the strict form gives the textbook's (FS-131, job FS131-KN7; proved by FS131-IN1L)

`ZdAction.IsErgodicOn` (`Rigidity/Solenoid`) asks that every measurable set **strictly** fixed by every `α n`, `n ∈ Λ`, be
null or conull — Mathlib's convention for one map. The textbook's ergodicity (and Mathlib's `ErgodicSMul` for a group
action) asks it of every set fixed **up to a null set**. As the hypothesis of the declared theorem
`Rigidity.positive_entropy_rigidity` the strict form asks less of the measure, so this module's one theorem is the row of
that theorem's read-back that says the declared hypothesis implies the page's (`plans/FS131-KN7-chain-next.md` § 2.3):
for the countable group `Λ ⊆ ℤ^d`, a measurable set fixed by every `α n` up to a null set differs by a null set from the
intersection of its translates, which is strictly fixed.

**Inhabitants.** The hypotheses are met by the trivial action on the one-point group with the point mass
(`trivialAction_isErgodicOn`, any `Λ`, any measurable `s`).
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory

namespace ZdAction

/-- **Strict ergodicity gives ergodicity for almost invariant sets**: if `μ` is ergodic for the restriction of `α` to `Λ` in
the strict sense, then a measurable set `s` with `α n ⁻¹' s = s` up to a `μ`-null set for every `n ∈ Λ` is null or conull.
Route: `s′ := ⋂_{n ∈ Λ} α n ⁻¹' s` is measurable (`Λ` is countable), strictly fixed (`α (n + m) = α n ∘ α m` and
`n ↦ n + m` permutes `Λ` for `m ∈ Λ`), and `s′ = s` almost everywhere (`ae_all_iff`; `0 ∈ Λ`). -/
theorem IsErgodicOn.null_or_conull_of_ae_invariant {d : ℕ} {X : Type*} [AddCommGroup X] [TopologicalSpace X]
    [MeasurableSpace X] [BorelSpace X] {α : ZdAction d X} {Λ : AddSubgroup (Fin d → ℤ)} {μ : Measure X}
    (h : α.IsErgodicOn Λ μ) {s : Set X} (hs : MeasurableSet s) (hinv : ∀ n ∈ Λ, (α n ⁻¹' s : Set X) =ᵐ[μ] s) :
    μ s = 0 ∨ μ sᶜ = 0 := by
  have hadd : ∀ a b x, α (a + b) x = α a (α b x) := fun a b x => congrArg (fun f : X →+ X => f x) (α.map_add' a b)
  let s' : Set X := ⋂ n : Λ, (α n ⁻¹' s : Set X)
  have hmeas : MeasurableSet s' := MeasurableSet.iInter fun n => (α.continuous' n).measurable hs
  have hfix : ∀ m ∈ Λ, (α m ⁻¹' s' : Set X) = s' := by
    intro m hm
    ext x
    simp only [s', Set.mem_preimage, Set.mem_iInter]
    constructor
    · intro h n
      have h1 := h ⟨(n : Fin d → ℤ) - m, Λ.sub_mem n.2 hm⟩
      rwa [← hadd, sub_add_cancel] at h1
    · intro h n
      rw [← hadd]
      exact h ⟨(n : Fin d → ℤ) + m, Λ.add_mem n.2 hm⟩
  have hae : s' =ᵐ[μ] s := by
    have h1 : ∀ᵐ x ∂μ, ∀ n : Λ, (α n ⁻¹' s : Set X) x = s x := ae_all_iff.mpr fun n => hinv n n.2
    filter_upwards [h1] with x hx
    show (x ∈ s') = (x ∈ s)
    apply propext
    simp only [s', Set.mem_iInter]
    constructor
    · intro h
      exact Eq.mp (hx ⟨0, Λ.zero_mem⟩) (h ⟨0, Λ.zero_mem⟩)
    · intro h n
      exact Eq.mpr (hx n) h
  rcases h.2 s' hmeas hfix with h0 | h0
  · exact Or.inl ((measure_congr hae).symm.trans h0)
  · exact Or.inr ((measure_congr hae.compl).symm.trans h0)

-- Spec: on the one-point group every measurable set is null or conull for the point mass, so the theorem's hypotheses
-- have an inhabitant (the trivial action, `Λ = ⊤`).
example : (ZdAction.trivial 2 Unit).IsErgodicOn ⊤ (Measure.dirac ()) := trivialAction_isErgodicOn 2 ⊤

end ZdAction

end HadwigerNelson.Rigidity
