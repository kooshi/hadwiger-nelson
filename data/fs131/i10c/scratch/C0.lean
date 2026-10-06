import Proofs.HadwigerNelson.Arith.StandingFive
import Mathlib.FieldTheory.IntermediateField.Adjoin.Basic
import Mathlib.Tactic.ComputeDegree

namespace HadwigerNelson.StandingFive
open Polynomial

axiom g_eta : eta ^ 7 + eta ^ 6 - 12 * eta ^ 5 - 7 * eta ^ 4 + 28 * eta ^ 3 + 14 * eta ^ 2 - 9 * eta + 1 = 0

/-- The period polynomial `g` over `ℤ`. -/
noncomputable def gPoly : ℤ[X] := X ^ 7 + X ^ 6 - 12 * X ^ 5 - 7 * X ^ 4 + 28 * X ^ 3 + 14 * X ^ 2 - 9 * X + 1

theorem gPoly_monic : gPoly.Monic := by unfold gPoly; monicity!

theorem gPoly_natDegree : gPoly.natDegree = 7 := by unfold gPoly; compute_degree!

theorem aeval_gPoly {A : Type*} [CommRing A] (x : A) :
    aeval x gPoly = x ^ 7 + x ^ 6 - 12 * x ^ 5 - 7 * x ^ 4 + 28 * x ^ 3 + 14 * x ^ 2 - 9 * x + 1 := by
  simp [gPoly, map_ofNat]

theorem isIntegral_eta : IsIntegral ℤ eta := ⟨gPoly, gPoly_monic, by rw [← aeval_def, aeval_gPoly, g_eta]⟩

theorem isIntegral_sqrt_three : IsIntegral ℤ (Real.sqrt 3) :=
  ⟨X ^ 2 - C 3, monic_X_pow_sub_C _ (by norm_num), by simp⟩

theorem isIntegral_sqrt_eleven : IsIntegral ℤ (Real.sqrt 11) :=
  ⟨X ^ 2 - C 11, monic_X_pow_sub_C _ (by norm_num), by simp⟩

#synth Module ℚ standingField
#synth Algebra ℚ standingField

/-- The three generators as an intermediate field of `ℝ/ℚ`. -/
noncomputable def standingIF : IntermediateField ℚ ℝ := IntermediateField.adjoin ℚ {Real.sqrt 3, Real.sqrt 11, eta}

theorem standingField_eq : standingField = standingIF.toSubfield := by
  rw [standingIF, IntermediateField.adjoin_toSubfield]
  refine le_antisymm (Subfield.closure_mono Set.subset_union_right) ((Subfield.closure_le).mpr ?_)
  rintro x (⟨q, rfl⟩ | hx)
  · exact SubfieldClass.ratCast_mem _ q
  · exact Subfield.subset_closure hx

theorem finrank_simple_le {x : ℝ} {p : ℤ[X]} (hp : p.Monic) (hx : aeval x p = 0) :
    Module.finrank ℚ (IntermediateField.adjoin ℚ ({x} : Set ℝ)) ≤ p.natDegree := by
  have hint : IsIntegral ℚ x := (show IsIntegral ℤ x from ⟨p, hp, by rwa [← aeval_def]⟩).tower_top
  rw [IntermediateField.adjoin.finrank hint]
  have hq : (p.map (Int.castRingHom ℚ)).Monic := hp.map _
  have h0 : aeval x (p.map (Int.castRingHom ℚ)) = 0 := by rw [← hx]; exact aeval_map_algebraMap ℚ x p
  calc (minpoly ℚ x).natDegree ≤ (p.map (Int.castRingHom ℚ)).natDegree :=
        natDegree_le_natDegree (minpoly.min ℚ x hq h0)
    _ = p.natDegree := hp.natDegree_map _

theorem finrank_standingIF_le : Module.finrank ℚ standingIF ≤ 28 := by
  have h3 : Module.finrank ℚ (IntermediateField.adjoin ℚ ({Real.sqrt 3} : Set ℝ)) ≤ 2 := by
    have h := finrank_simple_le (x := Real.sqrt 3) (p := X ^ 2 - C 3) (monic_X_pow_sub_C _ (by norm_num)) (by simp [map_ofNat])
    rwa [natDegree_X_pow_sub_C] at h
  have h11 : Module.finrank ℚ (IntermediateField.adjoin ℚ ({Real.sqrt 11} : Set ℝ)) ≤ 2 := by
    have h := finrank_simple_le (x := Real.sqrt 11) (p := X ^ 2 - C 11) (monic_X_pow_sub_C _ (by norm_num)) (by simp [map_ofNat])
    rwa [natDegree_X_pow_sub_C] at h
  have h7 : Module.finrank ℚ (IntermediateField.adjoin ℚ ({eta} : Set ℝ)) ≤ 7 := by
    simpa [gPoly_natDegree] using finrank_simple_le (x := eta) gPoly_monic (by rw [aeval_gPoly, g_eta])
  have hS : ({Real.sqrt 3, Real.sqrt 11, eta} : Set ℝ) = {Real.sqrt 3} ∪ ({Real.sqrt 11} ∪ {eta}) := by
    rw [Set.insert_eq, Set.insert_eq]
  rw [standingIF, hS, IntermediateField.adjoin_union, IntermediateField.adjoin_union]
  calc _ ≤ _ * _ := IntermediateField.finrank_sup_le _ _
    _ ≤ 2 * (2 * 7) := Nat.mul_le_mul h3 ((IntermediateField.finrank_sup_le _ _).trans (Nat.mul_le_mul h11 h7))

instance : FiniteDimensional ℚ standingIF :=
  IntermediateField.finiteDimensional_adjoin (by
    rintro x (rfl | rfl | rfl)
    · exact isIntegral_sqrt_three.tower_top
    · exact isIntegral_sqrt_eleven.tower_top
    · exact isIntegral_eta.tower_top)

/-- The inclusion `F → ℚ(√3, √11, η)` as a ring homomorphism (the two are one set). -/
noncomputable def toStandingIF : standingField →+* standingIF where
  toFun x := ⟨x.1, standingField_eq.le x.2⟩
  map_one' := rfl
  map_mul' _ _ := rfl
  map_zero' := rfl
  map_add' _ _ := rfl

theorem toStandingIF_injective : Function.Injective toStandingIF := fun _ _ h =>
  Subtype.ext (congrArg (fun z : standingIF => (z : ℝ)) h)

theorem numberField_standingField' : NumberField standingField where
  to_finiteDimensional := Module.Finite.of_injective toStandingIF.toRatAlgHom.toLinearMap toStandingIF_injective

theorem finrank_standingField_le : Module.finrank ℚ standingField ≤ 28 :=
  (LinearMap.finrank_le_finrank_of_injective (f := toStandingIF.toRatAlgHom.toLinearMap) toStandingIF_injective).trans
    finrank_standingIF_le

end HadwigerNelson.StandingFive
