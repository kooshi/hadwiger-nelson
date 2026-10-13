import Proofs.HadwigerNelson.Arith.TorsionExtraction
/-! FS131-KN5: every library name the plan of § Stage 5 and the amended leaves cite, checked under the imports of
`Arith/DyadicQuadratic` (its one import). An unknown name is an error line in the log. -/
open HadwigerNelson
-- the residue colouring at the plane (DQ.1')
#check @ResidueColouring.colorable_of_residue
#check @ResidueColouring.cosetResidue_apply_of_mem
#check @Nat.card_eq_fintype_card
#check @Fintype.ofFinite
#check @unitDistance_adj
#check @Complex.dist_eq
-- coordinates in ℚ(√m)
#check @Subfield.closure_induction
#check @Real.mul_self_sqrt
#check @irrational_sqrt_natCast_iff
#check @Irrational.ne_rat
#check @irrational_iff_ne_rational
-- the shape lemmas: transfer to ZMod 8 / ZMod 16
#check @ZMod.val_intCast
#check @ZMod.natCast_mod
#check @ZMod.intCast_cast
#check @Int.odd_iff
#check @Int.even_iff
#check @Int.emod_emod_of_dvd
-- the lattice and its map
#check @Rat.cast_add_of_ne_zero
#check @Rat.cast_sub_of_ne_zero
#check @Rat.cast_mul_of_ne_zero
#check @Rat.add_den_dvd
#check @Rat.num_div_den
#check @AddMonoidHom.mk'
#check @AddMonoidHom.prod
-- DQ.2's composition
#check @SimpleGraph.Colorable.of_hom
#check @SimpleGraph.induceHomOfLE
#check @Subfield.closure_le
#check @Real.sqrt_one
#check @Nat.isUnit_iff
#check @SquareClass.fieldOfRadicands_mono
-- the two-colour end (D-2) and the helper (D-4)
#check @Ideal.isMaximal_iff
#check @Submodule.span_induction
#check @Ideal.subset_span
#check @UnitRing.exists_sum_eq_of_mem_unitRingOver
#check @ZMod.toAddCircle
#check @ZMod.toAddCircle_injective
#check @ZMod.toAddCircle_intCast
#check @AddCircle.coe_eq_zero_iff
-- C3 (finitely many strict linear inequalities)
#check @LinearMap.continuous_of_finiteDimensional
#check @Rat.denseRange_cast
#check @DenseRange.exists_mem_open
#check @isOpen_iInter_of_finite
#check @isOpen_lt
#check @DenseRange.piMap
