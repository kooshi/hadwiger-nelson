import Proofs.HadwigerNelson.Rigidity.ContinuityGroup
import Proofs.HadwigerNelson.Rigidity.Herglotz

namespace HadwigerNelson.Rigidity

open MeasureTheory SpectralChain SpectralInputs NumberField

noncomputable section

variable (F : Subfield ℝ)

/-- The inclusion `R → L`, additive. -/
private def toFieldI : unitRing F →+ fieldI F where
  toFun r := ⟨(r : ℂ), UnitRing.unitRingOver_le_planeOverSubring F r.2⟩
  map_zero' := rfl
  map_add' _ _ := rfl

private theorem toFieldI_injective : Function.Injective (toFieldI F) := fun _ _ h =>
  Subtype.ext (congrArg (fun z : fieldI F => (z : ℂ)) h)

theorem finite_quotient_nsmul [NumberField F] (N : ℕ) (hN : N ≠ 0) :
    Finite (unitRing F ⧸ (nsmulAddMonoidHom (α := unitRing F) N).range) := by
  classical
  haveI : NeZero N := ⟨hN⟩
  set H := (nsmulAddMonoidHom (α := unitRing F) N).range with hH
  set d := Module.finrank ℚ (fieldI F) with hd
  by_contra hfin
  rw [not_finite_iff_infinite] at hfin
  obtain ⟨s, hs⟩ := Infinite.exists_subset_card_eq (unitRing F ⧸ H) (N ^ d + 1)
  -- lifts of the members of `s`, and the finitely generated group `B` they span
  let lift : s → unitRing F := fun g => Quotient.out (g : unitRing F ⧸ H)
  have hlift : ∀ g : s, ((lift g : unitRing F) : unitRing F ⧸ H) = g := fun g => QuotientAddGroup.out_eq' _
  let B : Submodule ℤ (unitRing F) := Submodule.span ℤ (Set.range lift)
  haveI : Module.Finite ℤ B := Module.Finite.span_of_finite ℤ (Set.finite_range lift)
  haveI : Module.Free ℤ B := Module.free_of_finite_type_torsion_free'
  set r := Module.finrank ℤ B with hr
  let bB := Module.finBasis ℤ B
  -- the rank of `B` is at most `[L : ℚ]`
  have hrd : r ≤ d := by
    let f : B →ₗ[ℤ] fieldI F := (toFieldI F).toIntLinearMap.comp B.subtype
    have hf : LinearMap.ker f = ⊥ := LinearMap.ker_eq_bot.2 fun a b hab =>
      Subtype.ext (toFieldI_injective F hab)
    have hli : LinearIndependent ℤ (f ∘ bB) := bB.linearIndependent.map' f hf
    have := ((LinearIndependent.iff_fractionRing ℤ ℚ).mp hli).fintype_card_le_finrank
    simpa using this
  -- the coordinates modulo `N`: two members of `s` agree, so they are equal
  let mem : ∀ g : s, lift g ∈ B := fun g => Submodule.subset_span ⟨g, rfl⟩
  let co : s → (Fin r → ZMod N) := fun g i => ((bB.repr ⟨lift g, mem g⟩ i : ℤ) : ZMod N)
  have hcard : Fintype.card (Fin r → ZMod N) < Fintype.card s := by
    rw [Fintype.card_fun, ZMod.card, Fintype.card_fin, Fintype.card_coe, hs]
    have : N ^ r ≤ N ^ d := Nat.pow_le_pow_right (Nat.pos_of_ne_zero hN) hrd
    omega
  obtain ⟨g₁, g₂, hne, heq⟩ := Fintype.exists_ne_map_eq_of_card_lt co hcard
  apply hne
  -- the difference has coordinates divisible by `N`
  have hdiv : ∀ i, ∃ e : ℤ, bB.repr (⟨lift g₁, mem g₁⟩ - ⟨lift g₂, mem g₂⟩) i = N * e := by
    intro i
    have h := congrFun heq i
    rw [map_sub, Finsupp.sub_apply]
    have h' : (((bB.repr ⟨lift g₁, mem g₁⟩ i - bB.repr ⟨lift g₂, mem g₂⟩ i : ℤ)) : ZMod N) = 0 := by
      push_cast
      exact sub_eq_zero.2 h
    exact (ZMod.intCast_zmod_eq_zero_iff_dvd _ N).1 h'
  choose e he using hdiv
  have hv : (⟨lift g₁, mem g₁⟩ - ⟨lift g₂, mem g₂⟩ : B) = (N : ℤ) • ∑ i, e i • bB i := by
    rw [← bB.sum_repr (⟨lift g₁, mem g₁⟩ - ⟨lift g₂, mem g₂⟩), Finset.smul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [he i, smul_smul]
  have hmem : -lift g₁ + lift g₂ ∈ H := by
    have h2 := congrArg (fun v : B => (v : unitRing F)) hv
    simp only [Submodule.coe_sub, Submodule.coe_smul] at h2
    refine ⟨-((∑ i, e i • bB i : B) : unitRing F), ?_⟩
    rw [nsmulAddMonoidHom_apply, smul_neg, ← natCast_zsmul, ← h2]
    abel
  apply Subtype.ext
  rw [← hlift g₁, ← hlift g₂]
  exact QuotientAddGroup.eq.2 hmem

end

end HadwigerNelson.Rigidity
