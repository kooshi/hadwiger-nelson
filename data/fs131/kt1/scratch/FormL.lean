import Mathlib.NumberTheory.RamificationInertia.Valuation
import Mathlib.NumberTheory.NumberField.Completion.FinitePlace
import Mathlib.NumberTheory.Padics.HeightOneSpectrum
import Mathlib.NumberTheory.Padics.RingHoms
import Mathlib.Analysis.SpecialFunctions.Complex.Circle
import Mathlib.RingTheory.Trace.Basic

/-! FS131-KT1, stage 3 — form L of the local character, its first two leaves (scratch; measurement only).

Form L: `ψ_w(z) := ψ_p(Tr_{L_w/ℚ_p}(z))`, `ψ_p : ℚ_p → S¹` the standard character.
Leaf L1: `L_w` as a `ℚ_p`-algebra (here: `K_v`-algebra for `w | v`, with the instances Mathlib's `Module.Finite Kv Lw` takes).
Leaf L2: `ψ_p`, an additive character of `ℚ_[p]` trivial on `ℤ_[p]`.
-/

open IsDedekindDomain IsDedekindDomain.HeightOneSpectrum NumberField

section L1

variable {K L : Type*} [Field K] [Field L] [NumberField K] [NumberField L] [Algebra K L]
variable (v : HeightOneSpectrum (𝓞 K)) (w : HeightOneSpectrum (𝓞 L)) [w.asIdeal.LiesOver v.asIdeal]

/-- **L1, the map.** `K_v → L_w`, the completion of `K → L` (uniformly continuous by `uniformContinuous_algebraMap_liesOver`). -/
noncomputable def L1map : v.adicCompletion K →+* w.adicCompletion L :=
  ((adicCompletion.equiv L w).symm.toRingHom.comp
    (UniformSpace.Completion.mapRingHom (algebraMap (WithVal (v.valuation K)) (WithVal (w.valuation L)))
      (uniformContinuous_algebraMap_liesOver K L v w).continuous)).comp
    (adicCompletion.equiv K v).toRingHom

/-- **L1, the instance.** -/
noncomputable instance L1algebra : Algebra (v.adicCompletion K) (w.adicCompletion L) := (L1map v w).toAlgebra

/-- **L1, the tower** (the hypothesis `IsScalarTower K Kv Lw` of Mathlib's `Module.Finite Kv Lw`). -/
theorem L1tower : IsScalarTower K (v.adicCompletion K) (w.adicCompletion L) :=
  IsScalarTower.of_algebraMap_eq fun k => by
    show algebraMap K (w.adicCompletion L) k = L1map v w (algebraMap K (v.adicCompletion K) k)
    rw [algebraMap_adicCompletion, algebraMap_adicCompletion]
    simp only [Function.comp_apply, Algebra.algebraMap_self, RingHom.id_apply, L1map, RingHom.comp_apply,
      RingEquiv.toRingHom_eq_coe, RingEquiv.coe_toRingHom]
    show _ = (adicCompletion.equiv L w).symm (UniformSpace.Completion.mapRingHom _ _ ((k : (v.valuation K).Completion)))
    rw [UniformSpace.Completion.mapRingHom_coe]
    rfl

/-- **L1, continuity** (the hypothesis `ContinuousSMul Kv Lw`). -/
theorem L1continuous : ContinuousSMul (v.adicCompletion K) (w.adicCompletion L) := by
  have hc : Continuous (L1map v w) :=
    (adicCompletion.continuous_ofCompletion L w).comp
      (UniformSpace.Completion.continuous_map.comp (adicCompletion.continuous_toCompletion K v))
  exact ⟨(hc.comp continuous_fst).mul continuous_snd⟩

end L1

section L2

variable (p : ℕ) [Fact p.Prime]

/-- **L2, the decomposition step**: every `x ∈ ℚ_p` is `m / p^k + y` with `y ∈ ℤ_p`. -/
theorem L2decomp (x : ℚ_[p]) : ∃ (m : ℤ) (k : ℕ), ‖x - (m : ℚ_[p]) / (p : ℚ_[p]) ^ k‖ ≤ 1 := by
  -- a power of `p` brings `x` into `ℤ_p`
  obtain ⟨k, hk⟩ : ∃ k : ℕ, ‖(p : ℚ_[p]) ^ k * x‖ ≤ 1 := by
    rcases eq_or_ne x 0 with rfl | hx
    · exact ⟨0, by simp⟩
    refine ⟨x.valuation.natAbs, ?_⟩
    have hp1 : (1 : ℝ) < p := by exact_mod_cast (Fact.out : p.Prime).one_lt
    rw [norm_mul, norm_pow, Padic.norm_p, Padic.norm_eq_zpow_neg_valuation hx, inv_pow,
      ← zpow_natCast, ← zpow_neg, ← zpow_add₀ (by positivity)]
    exact zpow_le_one_of_nonpos₀ hp1.le (by omega)
  let y : ℤ_[p] := ⟨(p : ℚ_[p]) ^ k * x, hk⟩
  have hy := PadicInt.appr_spec k y
  refine ⟨(PadicInt.appr y k : ℤ), k, ?_⟩
  obtain ⟨z, hz⟩ := Ideal.mem_span_singleton'.mp hy
  have hp : (p : ℚ_[p]) ^ k ≠ 0 := pow_ne_zero _ (by exact_mod_cast (Fact.out : p.Prime).ne_zero)
  have : x - ((PadicInt.appr y k : ℤ) : ℚ_[p]) / (p : ℚ_[p]) ^ k = (z : ℚ_[p]) := by
    have hz' : ((z * (p : ℤ_[p]) ^ k : ℤ_[p]) : ℚ_[p]) = (y : ℚ_[p]) - (PadicInt.appr y k : ℚ_[p]) := by
      rw [hz]; push_cast; rfl
    have hyx : (y : ℚ_[p]) = (p : ℚ_[p]) ^ k * x := rfl
    rw [hyx] at hz'
    push_cast at hz'
    rw [show ((PadicInt.appr y k : ℤ) : ℚ_[p]) = (p : ℚ_[p]) ^ k * x - (z : ℚ_[p]) * (p : ℚ_[p]) ^ k by
      push_cast; linear_combination hz']
    field_simp
    ring
  rw [this]; exact z.2

/-- **L2, the character** (its definition from `L2decomp`, then additivity from well-definedness: `m/p^k − m′/p^{k′} ∈ ℤ_p`
forces it into `ℤ`). Stated as the leaf: an additive character of `ℚ_p` trivial exactly on... here, on `ℤ_p`, and nontrivial. -/
theorem L2char : ∃ ψ : AddChar ℚ_[p] Circle, (∀ x : ℚ_[p], ‖x‖ ≤ 1 → ψ x = 1) ∧ ψ ((p : ℚ_[p])⁻¹) ≠ 1 := by
  sorry

end L2
