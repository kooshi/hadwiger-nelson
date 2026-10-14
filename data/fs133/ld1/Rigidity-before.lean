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

Everything else in this file is kernel-checked: `Spectral.residual_fourier_cross` (two vectors, by polarisation;
on the import) and `Spectral.residual_fourier_model` (a model of the hypotheses with a non-zero vector, where the
conclusion holds by computation; on no axiom beyond the standard three).

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
statements differ by twenty-four constants there and four here, in place of four and two. The release's stored
statement, rebuilt at this pin from its print (120 constants, each present here), is accepted by this pin's kernel
as definitionally equal to this statement, and each of the two instance terms that differ (`Semiring ↥E`,
`Semiring ℂ`) is kernel-equal to its counterpart (`data/fs133/ia1/rebuild/`, `plans/FS133-IA1-implementation.md`
stage 6); what the comparison leaves to trust is that a Mathlib constant of one name means one thing at the two
pins. A model of
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
  have key : ∀ x : H, x ∈ (ContinuousVectors.space U)ᗮ → (∀ k, (W k : H →L[ℂ] H) x = x) →
      ⟪(ContinuousVectors.op U z : H →ₗ[ℂ] H) x, x⟫_ℂ = 0 := by
    intro x hx hfx
    have h := residual_fourier U W hcov x hx hfx z hz
    rw [← inner_conj_symm, ContinuousLinearMap.coe_coe, h, map_zero]
  have h := inner_map_polarization (ContinuousVectors.op U z : H →ₗ[ℂ] H) v w
  rw [key (v + w) (add_mem hv hw) (fun k => by rw [map_add, hfixv, hfixw]),
    key (v - w) (sub_mem hv hw) (fun k => by rw [map_sub, hfixv, hfixw]),
    key (v + Complex.I • w) (add_mem hv (Submodule.smul_mem _ _ hw))
      (fun k => by rw [map_add, map_smul, hfixv, hfixw]),
    key (v - Complex.I • w) (sub_mem hv (Submodule.smul_mem _ _ hw))
      (fun k => by rw [map_sub, map_smul, hfixv, hfixw])] at h
  have h0 : ⟪ContinuousVectors.op U z w, v⟫_ℂ = 0 := by simpa using h
  rw [← inner_conj_symm, h0, map_zero]

/-- Composition with a bijection of the index set, as a linear isometric equivalence of `ℓ²` (for the model). -/
private def lpReindex {ι : Type} (σ : ι ≃ ι) : lp (fun _ : ι => ℂ) 2 ≃ₗᵢ[ℂ] lp (fun _ : ι => ℂ) 2 where
  toFun f := ⟨fun x => f (σ x), memℓp_gen ((σ.summable_iff (f := fun i => ‖f i‖ ^ (2 : ENNReal).toReal)).mpr
    ((memℓp_gen_iff (by norm_num)).mp (lp.memℓp f)))⟩
  invFun f := ⟨fun x => f (σ.symm x),
    memℓp_gen ((σ.symm.summable_iff (f := fun i => ‖f i‖ ^ (2 : ENNReal).toReal)).mpr
      ((memℓp_gen_iff (by norm_num)).mp (lp.memℓp f)))⟩
  map_add' f g := rfl
  map_smul' c f := rfl
  left_inv f := lp.ext (funext fun x => congrArg f (σ.apply_symm_apply x))
  right_inv f := lp.ext (funext fun x => congrArg f (σ.symm_apply_apply x))
  norm_map' f := by
    have h2 : 0 < (2 : ENNReal).toReal := by norm_num
    rw [lp.norm_eq_tsum_rpow h2, lp.norm_eq_tsum_rpow h2]
    exact congrArg (· ^ (1 / (2 : ENNReal).toReal)) (σ.tsum_eq fun i => ‖f i‖ ^ (2 : ENNReal).toReal)

/-- The unitary of `ℓ²` that composes with a bijection of the index set (for the model). -/
private def lpUnitary {ι : Type} (σ : ι ≃ ι) :
    unitary (lp (fun _ : ι => ℂ) 2 →L[ℂ] lp (fun _ : ι => ℂ) 2) :=
  Unitary.linearIsometryEquiv.symm (lpReindex σ)

private theorem lpUnitary_apply {ι : Type} (σ : ι ≃ ι) (f : lp (fun _ : ι => ℂ) 2) (x : ι) :
    ((lpUnitary σ : lp (fun _ : ι => ℂ) 2 →L[ℂ] lp (fun _ : ι => ℂ) 2) f) x = f (σ x) := rfl

/-- Multiplication by the inverse of a rotation, as a bijection of the algebraic plane (for the model). -/
private def turnEquiv (k : K) : E ≃ E where
  toFun x := kCoeff k⁻¹ * x
  invFun x := kCoeff k * x
  left_inv x := by
    have h : kCoeff k * kCoeff k⁻¹ = 1 := by
      change kCoeff (k * k⁻¹) = 1
      rw [mul_inv_cancel]; rfl
    change kCoeff k * (kCoeff k⁻¹ * x) = x
    rw [← mul_assoc, h, one_mul]
  right_inv x := by
    have h : kCoeff k⁻¹ * kCoeff k = 1 := by
      change kCoeff (k⁻¹ * k) = 1
      rw [inv_mul_cancel]; rfl
    change kCoeff k⁻¹ * (kCoeff k * x) = x
    rw [← mul_assoc, h, one_mul]

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
  classical
  -- the regular representation: `(U z f) x = f (x + z)`, `(W k f) x = f (k⁻¹ x)`
  let U : DiscreteE →* unitary (lp (fun _ : E => ℂ) 2 →L[ℂ] lp (fun _ : E => ℂ) 2) :=
    { toFun := fun z => lpUnitary (Equiv.addRight (Multiplicative.toAdd z))
      map_one' := by
        apply Subtype.ext
        apply ContinuousLinearMap.ext
        intro f
        apply lp.ext
        funext x
        change f (x + 0) = f x
        rw [add_zero]
      map_mul' := by
        intro a b
        apply Subtype.ext
        apply ContinuousLinearMap.ext
        intro f
        apply lp.ext
        funext x
        change f (x + (Multiplicative.toAdd a + Multiplicative.toAdd b)) =
          f (x + Multiplicative.toAdd a + Multiplicative.toAdd b)
        rw [add_assoc] }
  have hU : ∀ (a : E) (f : lp (fun _ : E => ℂ) 2) (x : E), (ContinuousVectors.op U a f) x = f (x + a) :=
    fun _ _ _ => rfl
  let W : K → unitary (lp (fun _ : E => ℂ) 2 →L[ℂ] lp (fun _ : E => ℂ) 2) := fun k => lpUnitary (turnEquiv k)
  have hW : ∀ (k : K) (f : lp (fun _ : E => ℂ) 2) (x : E),
      ((W k : lp (fun _ : E => ℂ) 2 →L[ℂ] lp (fun _ : E => ℂ) 2) f) x = f (kCoeff k⁻¹ * x) := fun _ _ _ => rfl
  have hkk : ∀ k : K, kCoeff k⁻¹ * kCoeff k = 1 := by
    intro k
    change kCoeff (k⁻¹ * k) = 1
    rw [inv_mul_cancel]; rfl
  refine ⟨lp (fun _ : E => ℂ) 2, inferInstance, inferInstance, inferInstance, U, W, lp.single 2 (0 : E) (1 : ℂ),
    ?_, ?_, ?_, ?_, ?_⟩
  · -- covariance
    intro k z w
    apply lp.ext
    funext x
    rw [hW, hU, hU, hW, mul_add, ← mul_assoc, hkk, one_mul]
  · -- the point mass at the origin is orthogonal to every continuous vector
    rw [Submodule.mem_orthogonal]
    intro w hw
    rw [lp.inner_single_right]
    have hw' : Filter.Tendsto (fun a : E => ContinuousVectors.op U a w) (nhds 0) (nhds w) := hw
    -- the coordinate at the origin of the translate by `a` is `w a`, and tends to `w 0`
    have h1 : Filter.Tendsto (fun a : E => w a) (nhds 0) (nhds (w 0)) := by
      refine tendsto_iff_norm_sub_tendsto_zero.mpr (squeeze_zero (fun _ => norm_nonneg _) (fun a => ?_)
        (tendsto_iff_norm_sub_tendsto_zero.mp hw'))
      have h := lp.norm_apply_le_norm (two_ne_zero) (ContinuousVectors.op U a w - w) 0
      rw [lp.coeFn_sub, Pi.sub_apply, hU, zero_add] at h
      exact h
    -- along the distinct points `1 / (n + 1)` the coordinates of `w` tend to `w 0`, and are square-summable
    let s : ℕ → E := fun n => ((n : E) + 1)⁻¹
    have hs0 : Filter.Tendsto s Filter.atTop (nhds 0) := by
      rw [tendsto_subtype_rng]
      have h := tendsto_one_div_add_atTop_nhds_zero_nat (𝕜 := ℂ)
      simpa [s, one_div] using h
    have hsinj : Function.Injective s := by
      intro m n hmn
      have h := inv_injective hmn
      exact_mod_cast add_right_cancel h
    have h2 : Filter.Tendsto (fun n => w (s n)) Filter.atTop (nhds (w 0)) := h1.comp hs0
    have hsum : Summable fun i : E => ‖w i‖ ^ (2 : ENNReal).toReal :=
      (memℓp_gen_iff (by norm_num)).mp (lp.memℓp w)
    have h3 : Filter.Tendsto (fun n => ‖w (s n)‖ ^ (2 : ENNReal).toReal) Filter.atTop (nhds 0) :=
      hsum.tendsto_cofinite_zero.comp (Nat.cofinite_eq_atTop ▸ hsinj.tendsto_cofinite)
    have h4 : Filter.Tendsto (fun n => ‖w (s n)‖ ^ (2 : ENNReal).toReal) Filter.atTop
        (nhds (‖w 0‖ ^ (2 : ENNReal).toReal)) :=
      (h2.norm).rpow_const (Or.inr (by norm_num))
    have h5 : ‖w 0‖ ^ (2 : ENNReal).toReal = 0 := tendsto_nhds_unique h4 h3
    have h6 : w 0 = 0 := by
      have := (Real.rpow_eq_zero_iff_of_nonneg (norm_nonneg (w 0))).mp h5
      exact norm_eq_zero.mp this.1
    rw [h6, inner_zero_left]
  · -- fixed by the rotations
    intro k
    apply lp.ext
    funext x
    rw [hW, lp.single_apply, lp.single_apply]
    by_cases hx : x = 0
    · simp [hx]
    · have hne : kCoeff k⁻¹ * x ≠ 0 := by
        intro h
        apply hx
        have h' := congrArg (fun y => kCoeff k * y) h
        simp only [mul_zero] at h'
        have hk : kCoeff k * kCoeff k⁻¹ = 1 := by
          change kCoeff (k * k⁻¹) = 1
          rw [mul_inv_cancel]; rfl
        rwa [← mul_assoc, hk, one_mul] at h'
      simp [hx, hne]
  · -- not zero
    intro h
    have h' := congrArg (fun f : lp (fun _ : E => ℂ) 2 => f 0) h
    simp at h'
  · -- the conclusion, by computation
    intro z hz
    rw [lp.inner_single_left, hU, zero_add, lp.single_apply]
    simp [hz]

end Spectral

end

end HadwigerNelson.Outside.OAI158
