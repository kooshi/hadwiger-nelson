import Proofs.HadwigerNelson.Arith.PlaceHom
import Proofs.HadwigerNelson.SpectralChain
import Proofs.HadwigerNelson.TwoColourResidue
import Mathlib.RingTheory.DedekindDomain.AdicValuation

open HadwigerNelson NumberField
#check @RingOfIntegers.isIntegral_coe
#check @IsIntegral.tower_top
#check @IsIntegrallyClosed.isIntegral_iff
#check @Ideal.comap_isPrime
#check @Ideal.IsPrime.isMaximal
#check @IsFractionRing.div_surjective
#check @ValuationSubring.eq_of_le_of_ne_top
#check @ValuationSubring.mem_nonunits_iff_or
#check @ValuationSubring.mem_nonunits_iff_exists_mem_maximalIdeal
#check @RingHom.codRestrict
#check @UnitRing.inv_natCast_mem_unitRingOver_iff
#check @Ideal.mem_comap
#check @map_inv₀
#check @RingOfIntegers.coe_eq_zero_iff
#check @ValuationSubring.mem_top
example (K : Type*) [Field K] (V : ValuationSubring K) : IsIntegrallyClosed V := inferInstance
example (K : Type*) [Field K] (V : ValuationSubring K) : IsFractionRing V K := inferInstance
example (K : Type*) [Field K] (V : ValuationSubring K) : IsScalarTower ℤ V K := inferInstance
example (K : Type*) [Field K] [NumberField K] : IsFractionRing (𝓞 K) K := inferInstance
example (K : Type*) [Field K] [NumberField K] : IsDedekindDomain (𝓞 K) := inferInstance
