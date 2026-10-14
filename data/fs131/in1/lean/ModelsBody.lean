
/-! FS131-IN1 — models of the hypotheses of the three statements widened by ruling and of the two-part, kernel-checked
(`data/fs131/in1/models.sh`): each `example` applies the module's theorem at a named object, so every hypothesis is
exhibited at once. Not part of the library. -/
namespace FS131IN1Models
open HadwigerNelson.ThreeColourCriterion

/-- Complex conjugation is not the identity. -/
theorem conj_ne_id : starRingEnd ℂ ≠ RingHom.id ℂ := fun h => by
  have h1 := RingHom.congr_fun h Complex.I
  rw [Complex.conj_I, RingHom.id_apply] at h1
  have h2 := congrArg Complex.im h1
  simp at h2
  norm_num at h2

-- Hilbert 90 at a field that is not finite: `ℂ` with conjugation, `t = i` (`i·ī = 1`).
example : ∃ y : ℂˣ, (y : ℂ) * (starRingEnd ℂ) ((y⁻¹ : ℂˣ) : ℂ) = Complex.I :=
  exists_mul_conj_inv_eq_of_mul_conj_eq_one (starRingEnd ℂ) Complex.conj_conj conj_ne_id (by simp)

-- The two-part at `𝔽₂`, the identity, `l = id` (the module's own spec example is its last hypothesis).
example : ∃ 𝔪 : Ideal (ZMod 2), 𝔪.IsMaximal ∧ ∀ x, (RingHom.id (ZMod 2)) x - x ∈ 𝔪 :=
  exists_maximal_conj_trivial (RingHom.id (ZMod 2)) (fun 𝔪 _ => Ideal.comap_id 𝔪) (AddMonoidHom.id (ZMod 2)) (by decide)

/-- The Frobenius of `𝔽₄` is not the identity: every element would be `0` or `1`, and there are four. -/
theorem frobenius_ne_id : frobenius (GaloisField 2 2) 2 ≠ RingHom.id _ := fun h => by
  classical
  have hx : ∀ x : GaloisField 2 2, x = 0 ∨ x = 1 := fun x => by
    have h1 := RingHom.congr_fun h x
    rw [frobenius_def, RingHom.id_apply] at h1
    have h2 : x * (x - 1) = 0 := by linear_combination h1
    rcases mul_eq_zero.mp h2 with h0 | h0
    · exact Or.inl h0
    · exact Or.inr (sub_eq_zero.mp h0)
  haveI : Fintype (GaloisField 2 2) := Fintype.ofFinite _
  have hsub : (Finset.univ : Finset (GaloisField 2 2)) ⊆ {0, 1} := fun x _ => by
    rcases hx x with rfl | rfl <;> simp
  have h2 := (Finset.card_le_card hsub).trans Finset.card_le_two
  rw [Finset.card_univ, ← Nat.card_eq_fintype_card, GaloisField.card 2 2 (by norm_num)] at h2
  norm_num at h2

-- The field case at 2 at `𝔽₄ = GaloisField 2 2` with its Frobenius — an endomorphism that is not the identity —, the zero
-- functional and `e = 0`.
example : (0 : ZMod 2) = 0 :=
  eq_zero_of_forall_normOne_eq (frobenius (GaloisField 2 2) 2) frobenius_ne_id 0 fun _ => rfl

-- `finite_quotient_span_natCast` at a number field the kernel holds — the standing field `ℚ(√3, √11, η)`
-- (`StandingFive.instNumberFieldStanding`) — and `N = 2`.
example : Finite (HadwigerNelson.SpectralChain.unitRing HadwigerNelson.StandingFive.standingField ⧸
    Ideal.span {((2 : ℕ) : HadwigerNelson.SpectralChain.unitRing HadwigerNelson.StandingFive.standingField)}) :=
  finite_quotient_span_natCast _ (by norm_num)

-- Every theorem above, and the module's headlines, with their axioms.
#print axioms FS131IN1Models.conj_ne_id
#print axioms FS131IN1Models.frobenius_ne_id

end FS131IN1Models

