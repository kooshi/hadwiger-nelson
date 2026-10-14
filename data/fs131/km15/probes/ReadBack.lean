import Proofs.HadwigerNelson.Rigidity.ChainHeadline
import Proofs.HadwigerNelson.Instances.SqrtFortySeven
import Proofs.HadwigerNelson.Arith.UpperHalf
import Proofs.HadwigerNelson.Arith.TargetFloors

-- FS131-KM15 stage 1: the four objects the brief names, from the kernel, and the names the route reads.
open HadwigerNelson SpectralChain NumberField

set_option pp.fullNames true in
#check @HadwigerNelson.Rigidity.min_localBound_five_le_chromaticNumber
#print HadwigerNelson.SpectralChain.localBound
#print HadwigerNelson.SpectralChain.StablePrime
#print HadwigerNelson.SpectralChain.levelTarget
#print HadwigerNelson.SqrtFortySeven.F47
#check @HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five
#check @HadwigerNelson.Rigidity.RatioAtMost
#check @HadwigerNelson.Rigidity.ratioAtMost_of_five_le_chromaticNumber
#check @HadwigerNelson.Rigidity.tca_of_five_le_localBound
#check @HadwigerNelson.Plane.OneAvoidingDensityBound
#print axioms HadwigerNelson.Rigidity.min_localBound_five_le_chromaticNumber
-- NumberField for F47: the library's instance
example : NumberField SqrtFortySeven.F47 := inferInstance
#synth NumberField SqrtFortySeven.F47
-- library API the route reads
#check @HadwigerNelson.StandingFive.card_fixed_of_involution
#check @HadwigerNelson.StandingFive.isIntegral_of_sq_add
#check @HadwigerNelson.StandingFive.pow_char_eq_of_sq_natCast
#check @HadwigerNelson.StandingFive.exists_natCast_of_pow_eq
#check @HadwigerNelson.StandingFive.mod_four_of_pow
#check @HadwigerNelson.StandingFive.pow_natCard
#check @HadwigerNelson.UpperHalf.conjO_mem_iff
#check @HadwigerNelson.UpperHalf.conjO_conjO
#check @HadwigerNelson.UpperHalf.coe_conjO
#check @HadwigerNelson.coe_conjOn
#check @HadwigerNelson.SqrtFortySeven.sqrt47_mem
#check @HadwigerNelson.SpectralChain.toFieldI_surjective
-- Mathlib at the pin
#check @Ideal.absNorm_span_natCast
#check @Ideal.absNorm_dvd_absNorm_of_le
#check @Ideal.absNorm_apply
#check @Submodule.cardQuot_apply
#check @NumberField.RingOfIntegers.rank
#check @card_nsmul_eq_zero'
#check @FiniteField.card'
#check @CharP.natCast_eq_natCast
#check @RingHom.eqLocusField
#check @Nat.pow_dvd_pow_iff_le_right
#check @Nat.dvd_prime_pow
#check @Finset.exists_le_card_fiber_of_mul_le_card_of_maps_to
#check @SimpleGraph.Coloring.colorClass
#check @SimpleGraph.Coloring.color_classes_independent
#check @add_one_le_chromaticNumber_iff_not_colorable
#check @SimpleGraph.Colorable.chromaticNumber_le
#check @Ideal.Quotient.eq_zero_iff_mem
#check @Ideal.IsPrime.mem_or_mem
#check @NumberField.RingOfIntegers.coe_injective
#check @Subfield.subtype_injective
#check @Ideal.quotientMap_mk
#check @LinearMap.finrank_le_finrank_of_surjective
#check @Module.finrank_prod
#check @Ideal.span_le
#check @CharP.cast_eq_zero_iff
#check @FiniteField.pow_card
