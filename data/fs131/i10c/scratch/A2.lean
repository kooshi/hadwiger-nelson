import Proofs.HadwigerNelson.Arith.StandingFive
import Mathlib.FieldTheory.IntermediateField.Adjoin.Basic
import Mathlib.Tactic.ComputeDegree
import Mathlib.Topology.Order.IntermediateValue

namespace HadwigerNelson.StandingFive
open Polynomial

axiom g_eta : eta ^ 7 + eta ^ 6 - 12 * eta ^ 5 - 7 * eta ^ 4 + 28 * eta ^ 3 + 14 * eta ^ 2 - 9 * eta + 1 = 0
noncomputable def gPoly : ℤ[X] := X ^ 7 + X ^ 6 - 12 * X ^ 5 - 7 * X ^ 4 + 28 * X ^ 3 + 14 * X ^ 2 - 9 * X + 1
theorem gPoly_monic : gPoly.Monic := by unfold gPoly; monicity!
theorem gPoly_natDegree : gPoly.natDegree = 7 := by unfold gPoly; compute_degree!
theorem aeval_gPoly {A : Type*} [CommRing A] (x : A) :
    aeval x gPoly = x ^ 7 + x ^ 6 - 12 * x ^ 5 - 7 * x ^ 4 + 28 * x ^ 3 + 14 * x ^ 2 - 9 * x + 1 := by
  simp [gPoly, map_ofNat]

theorem aeval_gPoly_map {A B : Type*} [CommRing A] [CommRing B] (f : A →+* B) (x : A) :
    aeval (f x) gPoly = f (aeval x gPoly) := aeval_algHom_apply f.toIntAlgHom x gPoly

/-- The three generators as elements of `F`, with their relations. -/
noncomputable def s3F : standingField := ⟨Real.sqrt 3, sqrt_three_mem⟩
noncomputable def s11F : standingField := ⟨Real.sqrt 11, sqrt_eleven_mem⟩
noncomputable def etaF : standingField := ⟨eta, eta_mem⟩

theorem s3F_sq : s3F ^ 2 = 3 :=
  standingField.subtype_injective (by rw [map_pow, map_ofNat]; exact Real.sq_sqrt (by norm_num))

theorem s11F_sq : s11F ^ 2 = 11 :=
  standingField.subtype_injective (by rw [map_pow, map_ofNat]; exact Real.sq_sqrt (by norm_num))

theorem aeval_etaF : aeval etaF gPoly = 0 :=
  standingField.subtype_injective (by
    rw [← aeval_gPoly_map, map_zero, aeval_gPoly]; exact g_eta)

/-! ### Totally real: `g` has seven real roots -/

/-- A sign change of `g` on `[a, b]` gives a root strictly inside. -/
theorem exists_root_gPoly_of_sign {a b : ℝ} (hab : a ≤ b) (h : aeval a gPoly * aeval b gPoly < 0) :
    ∃ x : ℝ, a < x ∧ x < b ∧ aeval x gPoly = 0 := by
  have hc : ContinuousOn (fun x : ℝ => aeval x gPoly) (Set.Icc a b) := by
    simp only [aeval_gPoly]; fun_prop
  have hx : ∃ x ∈ Set.Icc a b, aeval x gPoly = 0 := by
    rcases lt_or_ge (aeval a gPoly) 0 with ha | ha
    · have hb : 0 < aeval b gPoly := pos_of_mul_neg_right h ha.le
      exact intermediate_value_Icc hab hc ⟨ha.le, hb.le⟩
    · have hb : aeval b gPoly < 0 := neg_of_mul_neg_right h ha
      exact intermediate_value_Icc' hab hc ⟨hb.le, ha⟩
  obtain ⟨x, ⟨hax, hxb⟩, hx0⟩ := hx
  refine ⟨x, lt_of_le_of_ne hax ?_, lt_of_le_of_ne hxb ?_, hx0⟩
  · rintro rfl; rw [hx0, zero_mul] at h; exact lt_irrefl _ h
  · rintro rfl; rw [hx0, mul_zero] at h; exact lt_irrefl _ h

/-- **Every complex root of `g` is real**: `g` changes sign seven times, at `−4, −2, −5/4, 0, 1/5, 1, 2, 3`. -/
theorem im_eq_zero_of_aeval_gPoly {z : ℂ} (hz : aeval z gPoly = 0) : z.im = 0 := by
  obtain ⟨r1, h1a, h1b, hr1⟩ := exists_root_gPoly_of_sign (a := -4) (b := -2) (by norm_num) (by rw [aeval_gPoly, aeval_gPoly]; norm_num)
  obtain ⟨r2, h2a, h2b, hr2⟩ := exists_root_gPoly_of_sign (a := -2) (b := -5/4) (by norm_num) (by rw [aeval_gPoly, aeval_gPoly]; norm_num)
  obtain ⟨r3, h3a, h3b, hr3⟩ := exists_root_gPoly_of_sign (a := -5/4) (b := 0) (by norm_num) (by rw [aeval_gPoly, aeval_gPoly]; norm_num)
  obtain ⟨r4, h4a, h4b, hr4⟩ := exists_root_gPoly_of_sign (a := 0) (b := 1/5) (by norm_num) (by rw [aeval_gPoly, aeval_gPoly]; norm_num)
  obtain ⟨r5, h5a, h5b, hr5⟩ := exists_root_gPoly_of_sign (a := 1/5) (b := 1) (by norm_num) (by rw [aeval_gPoly, aeval_gPoly]; norm_num)
  obtain ⟨r6, h6a, h6b, hr6⟩ := exists_root_gPoly_of_sign (a := 1) (b := 2) (by norm_num) (by rw [aeval_gPoly, aeval_gPoly]; norm_num)
  obtain ⟨r7, h7a, h7b, hr7⟩ := exists_root_gPoly_of_sign (a := 2) (b := 3) (by norm_num) (by rw [aeval_gPoly, aeval_gPoly]; norm_num)
  set P : ℂ[X] := gPoly.map (algebraMap ℤ ℂ) with hP
  have hPm : P.Monic := gPoly_monic.map _
  have hP0 : P ≠ 0 := hPm.ne_zero
  have hPd : P.natDegree = 7 := by rw [hP, gPoly_monic.natDegree_map, gPoly_natDegree]
  have hroot : ∀ x : ℝ, aeval x gPoly = 0 → (x : ℂ) ∈ P.roots.toFinset := fun x hx => by
    rw [Multiset.mem_toFinset, mem_roots hP0, IsRoot.def, hP, eval_map_algebraMap]
    have : aeval ((algebraMap ℝ ℂ) x) gPoly = (algebraMap ℝ ℂ) (aeval x gPoly) := aeval_algebraMap_apply ℂ x gPoly
    rw [Complex.coe_algebraMap] at this
    rw [this, hx, Complex.ofReal_zero]
  let r : Fin 7 → ℝ := ![r1, r2, r3, r4, r5, r6, r7]
  have hr : ∀ i, aeval (r i) gPoly = 0 := by
    intro i; fin_cases i <;> assumption
  have hmono : StrictMono r := by
    rw [Fin.strictMono_iff_lt_succ]
    intro i; fin_cases i <;> simp [r] <;> linarith
  let S : Finset ℂ := Finset.univ.image fun i => (r i : ℂ)
  have hS7 : S.card = 7 := by
    have hinj : Function.Injective fun i => (r i : ℂ) := Complex.ofReal_injective.comp hmono.injective
    rw [Finset.card_image_of_injective _ hinj, Finset.card_univ, Fintype.card_fin]
  have hsub : S ⊆ P.roots.toFinset := by
    intro w hw
    obtain ⟨i, -, rfl⟩ := Finset.mem_image.mp hw
    exact hroot _ (hr i)
  have hcard : P.roots.toFinset.card ≤ S.card := by
    rw [hS7, ← hPd]; exact (Multiset.toFinset_card_le _).trans (card_roots' P)
  have hzS : z ∈ S := by
    rw [Finset.eq_of_subset_of_card_le hsub hcard, Multiset.mem_toFinset, mem_roots hP0, IsRoot.def, hP, eval_map_algebraMap]
    exact hz
  obtain ⟨i, -, rfl⟩ := Finset.mem_image.mp hzS
  exact Complex.ofReal_im _

/-- **`F` is totally real**, in the form the leaf states. -/
theorem isTotallyReal_aux (φ : standingField →+* ℂ) : ∀ (x : ℝ) (hx : x ∈ standingField), (φ ⟨x, hx⟩).im = 0 := by
  have hsq : ∀ (w : ℂ) (t : ℝ), 0 ≤ t → w ^ 2 = t → w.im = 0 := fun w t ht hw => by
    have h0 : (w - (Real.sqrt t : ℂ)) * (w + (Real.sqrt t : ℂ)) = 0 := by
      have : ((Real.sqrt t : ℝ) : ℂ) ^ 2 = t := by rw [← Complex.ofReal_pow, Real.sq_sqrt ht]
      linear_combination hw - this
    rcases mul_eq_zero.mp h0 with h | h
    · rw [sub_eq_zero.mp h]; exact Complex.ofReal_im _
    · rw [eq_neg_of_add_eq_zero_left h]; simp
  intro x hx
  refine Subfield.closure_induction (p := fun x hx => (φ ⟨x, hx⟩).im = 0) ?_ ?_ ?_ ?_ ?_ ?_ hx
  · rintro y (rfl | rfl | rfl)
    · refine hsq _ 3 (by norm_num) ?_
      show φ s3F ^ 2 = _
      rw [← map_pow, s3F_sq, map_ofNat]; norm_num
    · refine hsq _ 11 (by norm_num) ?_
      show φ s11F ^ 2 = _
      rw [← map_pow, s11F_sq, map_ofNat]; norm_num
    · refine im_eq_zero_of_aeval_gPoly ?_
      show aeval (φ etaF) gPoly = 0
      rw [aeval_gPoly_map, aeval_etaF, map_zero]
  · show (φ 1).im = 0
    rw [map_one]; rfl
  · intro a b ha hb h1 h2
    show (φ (⟨a, ha⟩ + ⟨b, hb⟩)).im = 0
    rw [map_add, Complex.add_im, h1, h2, add_zero]
  · intro a ha h1
    show (φ (-⟨a, ha⟩)).im = 0
    rw [map_neg, Complex.neg_im, h1, neg_zero]
  · intro a ha h1
    show (φ (⟨a, ha⟩⁻¹)).im = 0
    rw [map_inv₀, Complex.inv_im, h1, neg_zero, zero_div]
  · intro a b ha hb h1 h2
    show (φ (⟨a, ha⟩ * ⟨b, hb⟩)).im = 0
    rw [map_mul, Complex.mul_im, h1, h2, mul_zero, zero_mul, add_zero]

end HadwigerNelson.StandingFive
