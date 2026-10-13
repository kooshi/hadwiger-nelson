import Mathlib.FieldTheory.AlgebraicClosure
import Mathlib.Analysis.Complex.Circle
import Mathlib.Analysis.InnerProductSpace.Adjoint
import Mathlib.Analysis.InnerProductSpace.Orthogonal
import Mathlib.Analysis.InnerProductSpace.l2Space
import Mathlib.Analysis.CStarAlgebra.Classes
import Mathlib.Analysis.CStarAlgebra.Module.Constructions

/-!
# Rotation-fixed vectors orthogonal to the continuous vectors are uncorrelated: an outside theorem, imported (FS-133)

**The outside theorem of this module** is `Spectral.residual_fourier`, a lemma of the Lean development of
`[OAIMath2026]` family 158 (github.com/openai/math, read at its commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a`),
declared here as an `axiom` **in the release's own form, over the release's own definitions, copied**. It is the
release's third declared theorem in this library; the other two are in `Outside/OAI158`.

It is **not** a numbered statement of the release's manuscript. It is the manuscript's Theorem 2.3 ("Rigidity of wild
character laws") composed, in the release's Lean, with the spectral theorem for a unitary representation of the
discrete group of the algebraic plane: the step "If it is nonzero, normalize it and apply Theorem 2.3. The scalar
spectral measure is therefore a multiple of Haar measure" in the proof of the manuscript's Proposition "From proper to
weak measurable colorings" (§ 4, `sections/transfer.tex` ll. 181–187), which the release's own transfer consumes in
this form (`BorelTransfer.lean` l. 61).

The six definitions copied are `Spectral.E` (the algebraic plane, Mathlib's `algebraicClosure ℚ ℂ`), `Spectral.K`
(the algebraic numbers of modulus one, a subgroup of `Circle`), `Spectral.DiscreteE` (the additive group of the
algebraic plane written multiplicatively, with its derived `CommGroup`), `Spectral.kCoeff` (a rotation as a point of
the plane), `ContinuousVectors.op` (a representation read at an additive argument) and `ContinuousVectors.space`
(the vectors whose orbit map is continuous at `0` for the topology the plane's points carry as complex numbers).

Everything else in this file is kernel-checked or a leaf of FS-133's skeleton: `Spectral.residual_fourier_cross`
(two vectors, by polarisation) and `Spectral.residual_fourier_model` (a model of the hypotheses with a non-zero
vector, where the conclusion holds by computation).

The release's text is under the Apache License 2.0 (`Outside/OAIMath2026-LICENSE.txt`); the copied definitions are
changed in their namespace only (`OAI.PlaneFiveColor.Spectral` to `HadwigerNelson.Outside.OAI158.Spectral`,
`OAI.EuclideanFiveColor.ContinuousVectors` to `HadwigerNelson.Outside.OAI158.ContinuousVectors`) and carry a
docstring each.
-/

open scoped InnerProductSpace

namespace HadwigerNelson.Outside.OAI158

noncomputable section

namespace Spectral

/-- The algebraic plane: the algebraic numbers, as a subfield of `ℂ`. The release's `OAI.PlaneFiveColor.Spectral.E`
(`lean/OAI/Analysis/PlaneSpectrum/Basic.lean` l. 9), copied. -/
abbrev E := algebraicClosure ℚ ℂ

/-- The algebraic numbers of modulus one. The release's `OAI.PlaneFiveColor.Spectral.K` (`Basic.lean` ll. 11–15),
copied. -/
def K : Subgroup Circle where
  carrier := {u | IsAlgebraic ℚ (u : ℂ)}
  one_mem' := by simpa using (isAlgebraic_one : IsAlgebraic ℚ (1 : ℂ))
  mul_mem' := by intro a b ha hb; exact ha.mul hb
  inv_mem' := by intro a ha; exact ha.inv

/-- The additive group of the algebraic plane, written multiplicatively. The release's
`OAI.PlaneFiveColor.Spectral.DiscreteE` (`Basic.lean` l. 44), copied with its derived instance; the release's
discrete topology on it is not copied, because the imported statement does not read it. -/
def DiscreteE := Multiplicative E deriving CommGroup

/-- A rotation by an algebraic number of modulus one, as a point of the algebraic plane. The release's
`OAI.PlaneFiveColor.Spectral.kCoeff` (`Basic.lean` l. 224), copied. -/
def kCoeff (u : K) : E := ⟨(u.val : ℂ), mem_algebraicClosure_iff.mpr u.property⟩

end Spectral

namespace ContinuousVectors

variable {A H : Type*} [AddCommGroup A]
  [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
  (U : Multiplicative A →* unitary (H →L[ℂ] H))

/-- The operator of a unitary representation at an additive argument. The release's
`OAI.EuclideanFiveColor.ContinuousVectors.op` (`lean/OAI/Analysis/PlaneSpectrum/Representations.lean` l. 171),
copied. -/
def op (a : A) : H →L[ℂ] H := U (Multiplicative.ofAdd a)

variable [TopologicalSpace A]

open Filter Topology in
/-- The continuous vectors of a representation: those `v` with `op U a v → v` as `a → 0` in the topology of `A`.
The release's `OAI.EuclideanFiveColor.ContinuousVectors.space` (`Representations.lean` ll. 182–192), copied. -/
def space : Submodule ℂ H where
  carrier := {v | Tendsto (fun a => op U a v) (𝓝 0) (𝓝 v)}
  zero_mem' := by simp
  add_mem' := by
    intro v w hv hw
    change Tendsto (fun a => op U a (v+w)) (𝓝 0) (𝓝 (v+w))
    simpa only [map_add] using hv.add hw
  smul_mem' := by
    intro c v hv
    change Tendsto (fun a => op U a (c • v)) (𝓝 0) (𝓝 (c • v))
    simpa only [map_smul] using hv.const_smul c

end ContinuousVectors

namespace Spectral

/-- **IMPORTED: a rotation-fixed vector orthogonal to the continuous vectors is uncorrelated with its translates** —
`[OAIMath2026]`, an external Lean development (github.com/openai/math, commit
`adc7f1241b42e322a6451854ab7e4b4c146bf78a`), family 158, `lean/OAI/Analysis/PlaneSpectrum/Ergodicity.lean`
**line 403**, the lemma `OAI.PlaneFiveColor.Spectral.residual_fourier`.

For a unitary representation `U` of the discrete additive group of the algebraic plane on a complex Hilbert space,
with unitaries `W k` for the algebraic rotations that are covariant (`W k (U z w) = U (k z) (W k w)`): a vector `v`
orthogonal to the continuous vectors of `U` and fixed by every `W k` has `⟪v, U z v⟫ = 0` at every `z ≠ 0`.

**This is a lemma of the release's Lean, not a numbered statement of its manuscript.** It is the manuscript's
Theorem 2.3 ("Rigidity of wild character laws", `sections/spectral.tex` l. 64) composed with the spectral theorem for
the representation and with the fact that the spectral measure of such a `v` gives the continuous characters measure
zero; in the manuscript it is one step of the proof of the Proposition "From proper to weak measurable colorings"
(§ 4, `sections/transfer.tex` ll. 181–187). The binders are the release's, which stand there on a `variable` line
(`Ergodicity.lean` ll. 377–380) and are written here in the signature.

Proved there on `[propext, Classical.choice, Quot.sound]` at Lean v4.34.1 (`data/fs133/k1/readback/ReleaseAxioms.out`).
Read back against the release's stored statement in `plans/FS133-kernel-plan.md` stage 2, and again on this module
as it stands (`data/fs133/ia1/axiom-readback/`, FS133-IA1): the six copied definitions are the release's term for
term; **this statement is the release's up to instance arguments, not term for term** — binders, names and every
explicit and implicit argument agree, and the stored types differ only inside instance arguments, on one path: the
`Semiring` of a `Semifield` (of the algebraic plane, and of `ℂ`) is reached through `CommSemiring` at the release's
pin (`CommSemiring.toSemiring`, `Semifield.toCommSemiring`, `SubsemiringClass.toCommSemiring`,
`Complex.instCommSemiring`; Mathlib v4.34.1) and through `DivisionSemiring` at this one
(`DivisionSemiring.toSemiring`, `Semifield.toDivisionSemiring`; Mathlib v4.32.0). Which instances a stored statement
names depends on the module's imports as well as on the pin: this module imports
`Mathlib.Analysis.CStarAlgebra.Classes` and `Mathlib.Analysis.CStarAlgebra.Module.Constructions` so that the inner
product of `H` and the normed ring `ℂ` are reached as at the release's pin (`CStarModule.toInner`,
`WithCStarModule.instCStarModuleComplex`, `instCommCStarAlgebraComplex`); without those two imports the two stored
statements differ by twenty-four constants there and four here, in place of four and two. A model of
its hypotheses with `v ≠ 0`, where its conclusion holds by computation, is `residual_fourier_model` below. Declared in
`ARCHITECTURE.md` § Trust. -/
axiom residual_fourier {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
    (U : DiscreteE →* unitary (H →L[ℂ] H)) (W : K → unitary (H →L[ℂ] H))
    (hcov : ∀ k z w, (W k : H →L[ℂ] H) (ContinuousVectors.op U z w) =
      ContinuousVectors.op U ((kCoeff k)*z) ((W k : H →L[ℂ] H) w))
    (v : H) (hv : v ∈ (ContinuousVectors.space U)ᗮ)
    (hfix : ∀ k, (W k : H →L[ℂ] H) v = v) (z : E) (hz : z ≠ 0) :
    ⟪v,ContinuousVectors.op U z v⟫_ℂ = 0

/-- **Two vectors** (ours, from the import by polarisation; the derivation's C133-PAIR, step F4, first route): two
rotation-fixed vectors orthogonal to the continuous vectors are uncorrelated at every non-zero translate. Rests on
`residual_fourier`. -/
theorem residual_fourier_cross {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
    (U : DiscreteE →* unitary (H →L[ℂ] H)) (W : K → unitary (H →L[ℂ] H))
    (hcov : ∀ k z w, (W k : H →L[ℂ] H) (ContinuousVectors.op U z w) =
      ContinuousVectors.op U ((kCoeff k)*z) ((W k : H →L[ℂ] H) w))
    (v w : H) (hv : v ∈ (ContinuousVectors.space U)ᗮ) (hw : w ∈ (ContinuousVectors.space U)ᗮ)
    (hfixv : ∀ k, (W k : H →L[ℂ] H) v = v) (hfixw : ∀ k, (W k : H →L[ℂ] H) w = w) (z : E) (hz : z ≠ 0) :
    ⟪v,ContinuousVectors.op U z w⟫_ℂ = 0 := by
  sorry

/-- **A model of the import's hypotheses, with a non-zero vector** (the regular representation of the algebraic
plane on `ℓ²` of its points, the rotations acting on the points, and the point mass at the origin): a Hilbert space,
a representation, covariant rotations and a non-zero rotation-fixed vector orthogonal to the continuous vectors —
and there the import's conclusion holds by computation, with no axiom. -/
theorem residual_fourier_model :
    ∃ (H : Type) (_ : NormedAddCommGroup H) (_ : InnerProductSpace ℂ H) (_ : CompleteSpace H)
      (U : DiscreteE →* unitary (H →L[ℂ] H)) (W : K → unitary (H →L[ℂ] H)) (v : H),
      (∀ k z w, (W k : H →L[ℂ] H) (ContinuousVectors.op U z w) =
        ContinuousVectors.op U ((kCoeff k)*z) ((W k : H →L[ℂ] H) w)) ∧
      v ∈ (ContinuousVectors.space U)ᗮ ∧ (∀ k, (W k : H →L[ℂ] H) v = v) ∧ v ≠ 0 ∧
      ∀ z : E, z ≠ 0 → ⟪v,ContinuousVectors.op U z v⟫_ℂ = 0 := by
  sorry

end Spectral

end

end HadwigerNelson.Outside.OAI158
