import Proofs.HadwigerNelson.Arith.TorsionExtraction
import Proofs.HadwigerNelson.Arith.WeilKloosterman
open HadwigerNelson HadwigerNelson.CharacterColouring HadwigerNelson.SpectralChain HadwigerNelson.StandingFive
#check @FiniteField.sum_subgroup_units_eq_zero
#check @IsArtinianRing.quotNilradicalEquivPi
#check @IsArtinianRing.isNilpotent_nilradical
#check @Ideal.quotientMap
#check @Ideal.quotientMap_mk
#check @iterateFrobenius
#check @iterateFrobenius_def
#check @CharP.ringChar_of_prime_eq_zero
#check @ringChar.of_eq
#check @AddMonoidHom.liftOfRightInverse
#check @Function.apply_update
#check @Finset.sum_update_of_mem
#check @UnitRing.exists_sum_eq_of_mem_unitRingOver
#check @ZMod.toAddCircle
#check @ZMod.toAddCircle_injective
#check @ZMod.toAddCircle_intCast
#check @ZMod.toAddCircle_natCast
#check @LinearMap.exists_leftInverse_of_injective
#check @LinearIndependent.iff_fractionRing
#check @rank_le
#check @AddCommGroup.zmodModule
#check @Module.finite_of_finite
#check @Submodule.finite_quotient_smul
#check @Ideal.finite_quotient_pow
#check @DoubleQuot.quotQuotEquivQuotOfLE
#check @RingHom.quotientKerEquivOfSurjective
#check @Ideal.comap_isMaximal_of_surjective
#check @Ideal.isMaximal_iff
#check @Subgroup.card_subgroup_dvd_card
#check @FiniteField.even_card_of_char_two
#check @UnitRing.unitRingOver_le_planeOverSubring
#check @UnitRing.conj_mem_planeOverSubfield
#check @IsArtinianRing.isUnit_iff_isNilpotent
#check @LinearIndependent.fintype_card_le_finrank
#check @Module.rank_lt_aleph0_iff
#check @isUnit_iff_forall_dvd
#check @Ideal.exists_le_maximal
#check @MaximalSpectrum
example (F : Subfield ℝ) [NumberField F] : NumberField (fieldI F) := inferInstance
example (A : Type) [CommRing A] [Finite A] (I : Ideal A) : Finite (A ⧸ I) := inferInstance
example (A : Type) [CommRing A] [Finite A] : Finite (MaximalSpectrum A) := inferInstance
example (A : Type) [CommRing A] [CharP A 3] : ExpChar A 3 := inferInstance
