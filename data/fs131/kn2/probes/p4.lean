import Proofs.HadwigerNelson.Instances.UpperHalfValues

-- FS131-KN2: the skeleton's statements as the kernel stores them (binders included), and the axioms of what is proved.
open HadwigerNelson
set_option pp.fullNames false
#check @UpperHalf.chromaticNumber_planeOver_le_unitQuadrance
#check @UpperHalf.chromaticNumber_planeOver_le_finitePlane
#check @UpperHalf.exists_hom_levelTarget
#check @UpperHalf.chromaticNumber_planeOver_le_localBound
#check @UpperHalf.two_mem_of_conj_trivial
#check @UpperHalf.colorable_two_planeOver_of_ramified
#check @UpperHalf.exists_stablePrime_of_valuationSubring
#check @UpperHalf.inv_natCast_mem_unitRingOver_iff_forall_stablePrime
#check @UpperHalf.residue_conj
#check @QuadraticPrime.exists_maximal_card_eq
#check @QuadraticPrime.nonempty_ringHom_zmod_of_ramified_sqrt
#check @QuadraticPrime.exists_maximal_card_eq_of_ramified
#check @UpperHalf.exists_stablePrime_rat
#print axioms UpperHalf.chromaticNumber_planeOver_le_unitQuadrance
#print axioms UpperHalf.chromaticNumber_planeOver_le_finitePlane
#print axioms UpperHalf.colorable_planeOver_of_finitePlane
#print axioms UpperHalf.chromaticNumber_planeOver_le_localBound
#print axioms UpperHalf.chromaticNumber_planeOver_eleven
#print axioms UpperHalf.chromaticNumber_planeOver_rat
