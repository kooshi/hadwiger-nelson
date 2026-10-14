import Proofs.HadwigerNelson.Arith.PlaceHom
import Proofs.HadwigerNelson.SpectralChain
import Proofs.HadwigerNelson.TwoColourResidue
import Mathlib.RingTheory.DedekindDomain.AdicValuation
import Mathlib.NumberTheory.Padics.Hensel
import Mathlib.NumberTheory.Padics.RingHoms
import Mathlib.FieldTheory.Extension

-- FS131-KN2: the names the per-leaf plan cites, under the union of the three modules' imports.
open HadwigerNelson SimpleGraph NumberField IsDedekindDomain
#check @IsUnit.of_mul_eq_one
#check @Ideal.Quotient.eq
#check @Ideal.Quotient.eq_zero_iff_mem
#check @IsLocalization.ringHom_ext
#check @ValuationSubring.mem_nonunits_iff_exists_mem_maximalIdeal
#check @IsLocalization.AtPrime.to_map_mem_maximal_iff
#check @HeightOneSpectrum.valuationSubringAtPrime_eq_valuationSubring
#check @Submodule.exists_mem_ne_zero_of_ne_bot
#check @Subring.equivMapOfInjective
#check @Ideal.Quotient.nontrivial_iff
#check @Ideal.pow_le_self
#check @Ideal.Quotient.field
#check @CharTwo.of_one_ne_zero_of_two_eq_zero
#check @Ideal.Quotient.ringHom_ext
#check @RingOfIntegers.isIntegral_coe
#check @Ideal.comap_isPrime
#check @IsFractionRing.div_surjective
#check @Ideal.IsPrime.isMaximal
#check @ValuationSubring.eq_of_le_of_ne_top
#check @UnitRing.inv_natCast_mem_unitRingOver_iff
#check @isIntegral_algebraMap
#check @Module.Finite.of_injective
#check @ZMod.natCast_zmod_surjective
#check @ZMod.intCast_zmod_eq_zero_iff_dvd
#check @Polynomial.map_dvd
#check @Subfield.closure_empty
#check @SimpleGraph.two_le_chromaticNumber_of_adj
#check @Ideal.exists_le_maximal
#check @colorable_two_unitDistance_induce_of_valuationSubring
#check @ValuationSubring.mem_nonunits_iff_or
#check @RingOfIntegers.coe_injective
#check @Subfield.closure_induction
#check @Padic.valuation_mul
#check @SubfieldClass.ratCast_mem
#check @Ideal.IsMaximal.exists_inv_pow
example (K : Type*) [Field K] (A : ValuationSubring K) : IsFractionRing A K := inferInstance
example (K : Type*) [Field K] (A : ValuationSubring K) : IsIntegrallyClosed A := inferInstance

-- Q4, typed: the kernel of a ring homomorphism to `ZMod p` is maximal with `p` elements in the quotient.
example {R : Type*} [CommRing R] {p : ℕ} (hp : p.Prime) (f : R →+* ZMod p) :
    (RingHom.ker f).IsMaximal ∧ Nat.card (R ⧸ RingHom.ker f) = p := by
  haveI : Fact p.Prime := ⟨hp⟩
  have hs := ZMod.ringHom_surjective f
  exact ⟨RingHom.ker_isMaximal_of_surjective f hs,
    by rw [Nat.card_congr (RingHom.quotientKerEquivOfSurjective hs).toEquiv, Nat.card_zmod]⟩
