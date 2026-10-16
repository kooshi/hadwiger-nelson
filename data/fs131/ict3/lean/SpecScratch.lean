import Proofs.HadwigerNelson.CayleyThree.Density
/-! FS131-ICT3 — iteration only: the five spec examples, elaborated against the built modules before they go into them. -/
set_option autoImplicit false
set_option relaxedAutoImplicit false

namespace HadwigerNelson.CayleyThree

open HadwigerNelson.ThreeColour HadwigerNelson.CharacterColouring HadwigerNelson.ThreeColourCharacter SimpleGraph

#check @Set.eq_empty_of_forall_notMem
#check @Set.eq_univ_of_forall

-- `circularColoring` drifts if it stops being `x ↦ ⌊3·{θ x}⌋` on the graph: at `θ x = x/3` on `ℤ`, step `1`, `2 ↦ 2`.
example : circularColoring (S := ({1} : Set ℤ)) (mk1.comp ((AddMonoidHom.mulLeft (1 / 3 : ℝ)).comp (Int.castAddHom ℝ)))
    (fun u hu => by
      rw [Set.mem_singleton_iff] at hu
      subst hu
      exact ⟨1 / 3, ⟨by norm_num, by norm_num⟩, by simp⟩) 2 = 2 := by
  have h : (mk1.comp ((AddMonoidHom.mulLeft (1 / 3 : ℝ)).comp (Int.castAddHom ℝ))) 2 = ((2 / 3 : ℝ) : UnitAddCircle) := by
    simp only [AddMonoidHom.coe_comp, Function.comp_apply, Int.coe_castAddHom, Int.cast_ofNat, AddMonoidHom.coe_mulLeft]
    norm_num
  change ((⌊3 * rep01 ((mk1.comp ((AddMonoidHom.mulLeft (1 / 3 : ℝ)).comp (Int.castAddHom ℝ))) 2)⌋ : ℤ) : ZMod 3) = 2
  rw [h, rep01_coe ⟨by norm_num, by norm_num⟩, show (3 : ℝ) * (2 / 3) = 2 by norm_num, Int.floor_ofNat]
  rfl

-- `tightSet` drifts if it stops being "the directions a tight relation moves": along `(1, 2)` the tight relation
-- `(2, −1)` moves both directions; along `(1, 1)` every relation `k·(1, −1)` rises by `−|k|` against a winding of `0`,
-- so none is tight and no direction is.
example : tightSet (heightWinding properAlong_one_two) = Set.univ :=
  Set.eq_univ_of_forall fun j => ⟨⟨![2, -1], by decide⟩, by fin_cases j <;> decide, isTight_one_two⟩

example : tightSet (heightWinding (s := ![(1 : ℤ), 1]) (c := fun x => (x : ZMod 3))
    (fun a j => by fin_cases j <;> simp)) = ∅ := by
  generalize_proofs hc
  have h1 : (heightWinding hc).toHom ⟨![1, -1], by decide⟩ = 0 := by
    rw [heightWinding_apply]; decide
  refine Set.eq_empty_of_forall_notMem fun j ⟨σ, hσ, ht⟩ => hσ ?_
  have h := σ.2
  change ∑ k, (σ : Fin 2 → ℤ) k • ![(1 : ℤ), 1] k = 0 at h
  simp only [Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one, smul_eq_mul, mul_one] at h
  have hσ' : σ = ((σ : Fin 2 → ℤ) 0) • (⟨![1, -1], by decide⟩ : (relMap ![(1 : ℤ), 1]).ker) := by
    apply Subtype.ext
    funext i
    fin_cases i
    · simp
    · simp; linarith
  have hW : (heightWinding hc).toHom σ = 0 := by rw [hσ', map_zsmul, h1, smul_zero]
  change minRise (σ : Fin 2 → ℤ) = 3 * (heightWinding hc).toHom σ at ht
  rw [hW] at ht
  change ∑ k, min ((σ : Fin 2 → ℤ) k) (2 * (σ : Fin 2 → ℤ) k) = 3 * 0 at ht
  simp only [Fin.sum_univ_two] at ht
  fin_cases j <;> simp <;> omega

-- `Winding.flip` drifts if it stops being `r ↦ Σ_j r_j − W r`: at `(2, −1)` the winding of `x ↦ x mod 3` is `0`, its flip
-- `2 − 1 − 0 = 1`, and the flip of that `1 − 1 = 0` (the reversal is an involution).
example : (heightWinding properAlong_one_two).flip.toHom ⟨![2, -1], by decide⟩ = 1 ∧
    (heightWinding properAlong_one_two).flip.flip.toHom ⟨![2, -1], by decide⟩ = 0 := by
  constructor
  · change ∑ j, ![(2 : ℤ), -1] j - (heightWinding properAlong_one_two).toHom ⟨![2, -1], by decide⟩ = 1
    rw [heightWinding_apply]
    decide
  · change ∑ j, ![(2 : ℤ), -1] j - (∑ j, ![(2 : ℤ), -1] j -
      (heightWinding properAlong_one_two).toHom ⟨![2, -1], by decide⟩) = 0
    rw [heightWinding_apply]
    decide

-- `fibre` drifts if it stops being "the box points realizing the winding": along `(1, 2)` the relations are `ℤ·(2, −1)`,
-- the winding of `x ↦ x mod 3` vanishes there, and `2x₀ = x₁` meets `[1/3, 2/3]²` at one point.
example : fibre (heightWinding properAlong_one_two) = {![1 / 3, 2 / 3]} := by
  have h0 : (heightWinding properAlong_one_two).toHom ⟨![2, -1], by decide⟩ = 0 := by
    rw [heightWinding_apply]; decide
  have hrel : ∀ r : (relMap ![(1 : ℤ), 2]).ker,
      r = (-(r : Fin 2 → ℤ) 1) • (⟨![2, -1], by decide⟩ : (relMap ![(1 : ℤ), 2]).ker) := by
    intro r
    have h := r.2
    change ∑ k, (r : Fin 2 → ℤ) k • ![(1 : ℤ), 2] k = 0 at h
    simp only [Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one, smul_eq_mul] at h
    apply Subtype.ext
    funext j
    fin_cases j
    · simp; linarith
    · simp
  have hW : ∀ r : (relMap ![(1 : ℤ), 2]).ker, (heightWinding properAlong_one_two).toHom r = 0 := fun r => by
    rw [hrel r, map_zsmul, h0, smul_zero]
  ext x
  constructor
  · rintro ⟨hbox, hr⟩
    have e := hr ⟨![2, -1], by decide⟩
    rw [hW] at e
    simp only [Fin.sum_univ_two] at e
    have hb0 := hbox 0
    have hb1 := hbox 1
    simp only [Set.mem_Icc] at hb0 hb1
    norm_num at e
    rw [Set.mem_singleton_iff]
    funext j
    fin_cases j <;> simp <;> linarith
  · rintro rfl
    refine ⟨fun j => by fin_cases j <;> norm_num, fun r => ?_⟩
    rw [hW r, hrel r]
    simp [Fin.sum_univ_two]
    ring

-- `coloringOneTwo` drifts if it stops being `x ↦ x mod 3`: `5 ↦ 2`, `−1 ↦ 2`, `3 ↦ 0`.
example : coloringOneTwo 5 = 2 ∧ coloringOneTwo (-1) = 2 ∧ coloringOneTwo 3 = 0 := by decide

end HadwigerNelson.CayleyThree
