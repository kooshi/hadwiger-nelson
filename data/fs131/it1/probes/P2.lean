import Proofs.HadwigerNelson.Arith.ThreeColourCharacter

namespace HadwigerNelson.TorsionExtraction

open HadwigerNelson.CharacterColouring HadwigerNelson.SpectralChain HadwigerNelson.SquareClass SimpleGraph

example : T2Space UnitAddCircle := inferInstance
example : ContinuousAdd UnitAddCircle := inferInstance
example : IsTopologicalAddGroup UnitAddCircle := inferInstance
#check @QuotientAddGroup.mk_surjective
#check @AddCircle.coe_nsmul
#check @AddCircle.coe_add
#check @AddCircle.coe_sub
#check @Complex.norm_add_mul_I
#check @ZMod.card
#check @ofNat_mem
#check @natCast_mem
#check @tendsto_pow_atTop_nhds_zero_of_lt_one
#check @tendsto_nhds_unique
#check @AddCircle.coe_eq_coe_iff_of_mem_Ico
#check @AddCircle.coe_eq_zero_iff
#check @unitDistance
#print unitDistance
#check @Complex.norm_eq_sqrt_sq_add_sq
#check @SimpleGraph.comap_adj
#check @SimpleGraph.induce

theorem exists_zmod_hom_of_mem_torsionBy {M : Type*} [AddCommGroup M] {N : ℕ} [NeZero N] {θ : M →+ UnitAddCircle}
    (h : θ ∈ torsionBy M N) : ∃ l : M →+ ZMod N, ∀ x, θ x = ZMod.toAddCircle (l x) := by
  have hN : (N : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr (NeZero.ne N)
  have hval : ∀ x, ∃ j : ZMod N, θ x = ZMod.toAddCircle j := by
    intro x
    have hx : N • θ x = 0 := by
      have := congrArg (fun f : M →+ UnitAddCircle => f x) (mem_torsionBy.mp h)
      simpa using this
    obtain ⟨t, ht⟩ := QuotientAddGroup.mk_surjective (θ x)
    rw [← ht, ← AddCircle.coe_nsmul, AddCircle.coe_eq_zero_iff] at hx
    obtain ⟨k, hk⟩ := hx
    refine ⟨(k : ZMod N), ?_⟩
    rw [ZMod.toAddCircle_intCast, ← ht]
    congr 1
    rw [zsmul_one, nsmul_eq_mul] at hk
    field_simp
    linarith
  choose l hl using hval
  refine ⟨AddMonoidHom.mk' l fun x y => ?_, hl⟩
  apply ZMod.toAddCircle_injective N
  rw [map_add, ← hl, ← hl, ← hl, map_add]

end HadwigerNelson.TorsionExtraction
