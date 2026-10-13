import Proofs.HadwigerNelson.Plane.OneClass.Defs
import Proofs.HadwigerNelson.Outside.OAI158Transfer

/-!
# The field theorem: rotation-fixed observables of a plane system have continuous parts on the real plane (FS-133)

One statement carries the forward half of both C133-ALG (steps F3–F9, one observable) and C133-PAIR (steps F2–F5,
one observable per label) of `plans/FS133-E1-derivation.md`: for a probability space on which the algebraic plane
and its rotations act, and finitely many `[0, 1]`-valued observables fixed by the rotations, there are jointly
measurable `[0, 1]`-valued fields over the real plane with the observables' means and linear relations, in which a
pair of observables uncorrelated at one non-zero algebraic displacement is uncorrelated on the whole circle of that
radius.

It rests on the declared outside theorem `Outside.OAI158.Spectral.residual_fourier` (through
`residual_fourier_cross`) and on the release's generic lemmas, ported (`plans/FS133-kernel-plan.md`, leaf P): the
field is the orbit extension of the projection of each observable on the continuous vectors.
-/

open MeasureTheory Filter Set
open scoped ENNReal Topology

namespace HadwigerNelson.OneClass

open HadwigerNelson.Outside.OAI158 HadwigerNelson.Outside.OAI158.Spectral

/-- **The field theorem.** Let `P`, `τ`, `ρ` be a plane system and `f i`, `i` in a finite type, measurable
`[0, 1]`-valued observables each fixed by every rotation. Then there are jointly measurable `H i : ℂ × Ω → ℝ` with
values in `[0, 1]` such that
* the mean of `H i (x, ·)` is the mean of `f i`, at every `x`;
* every affine relation that holds among the `f i` almost surely holds among the `H i (x, ·)`, at every `x`;
* if `f i` and `f j ∘ τ z` have almost surely zero product at some `z ≠ 0` of the algebraic plane, then
  `H i (x, ·)` and `H j (x + w, ·)` have almost surely zero product at every `x` and every `w` of the real plane
  with `‖w‖ = ‖z‖`.
Rests on the declared outside theorem `Spectral.residual_fourier`. The hypotheses are inhabited at an invariant
random independent set with its indicator at the origin (`IsInvariantLaw.isPlaneSystem`); the consumer there is
`IsInvariantLaw.measure_origin_le_mOne`. -/
theorem exists_field {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {τ : E → Ω → Ω} {ρ : K → Ω → Ω}
    (h : IsPlaneSystem P τ ρ) {ι : Type*} [Fintype ι] (f : ι → Ω → ℝ) (hf : ∀ i, Measurable (f i))
    (h01 : ∀ i ω, 0 ≤ f i ω ∧ f i ω ≤ 1) (hfix : ∀ i u ω, f i (ρ u ω) = f i ω) :
    ∃ H : ι → ℂ × Ω → ℝ, (∀ i, Measurable (H i)) ∧ (∀ i p, 0 ≤ H i p ∧ H i p ≤ 1) ∧
      (∀ i x, ∫ ω, H i (x, ω) ∂P = ∫ ω, f i ω ∂P) ∧
      (∀ (c : ι → ℝ) (d : ℝ), (∀ᵐ ω ∂P, ∑ i, c i * f i ω = d) → ∀ x, ∀ᵐ ω ∂P, ∑ i, c i * H i (x, ω) = d) ∧
      ∀ i j, ∀ z : E, z ≠ 0 → (∀ᵐ ω ∂P, f i ω * f j (τ z ω) = 0) →
        ∀ x w : ℂ, ‖w‖ = ‖(z : ℂ)‖ → ∀ᵐ ω ∂P, H i (x, ω) * H j (x + w, ω) = 0 := by
  sorry

end HadwigerNelson.OneClass
