import Proofs.HadwigerNelson.ThreeColour
import Proofs.HadwigerNelson.Arith.CharacterColouring
import Mathlib.Analysis.LocallyConvex.Separation
import Mathlib.Topology.Algebra.Group.Compact
/-! FS131-IC1: the library names the routes read, checked under the module's own imports. -/
open HadwigerNelson
-- C3
#check @LinearMap.continuous_of_finiteDimensional
#check @Rat.denseRange_cast
#check @DenseRange.exists_mem_open
#check @isOpen_iInter_of_finite
#check @isOpen_lt
#check @DenseRange.piMap
#check @Rat.mul_den_eq_num
#check @Rat.den_pos
#check @Finset.dvd_prod_of_mem
-- L1.1
#check @geometric_hahn_banach_closed_point
#check @LinearMap.pi_apply_eq_sum_univ
#check @Convex.linear_image
#check @convex_pi
#check @convex_Icc
#check @IsCompact.image
#check @isCompact_univ_pi
#check @isCompact_Icc
#check (inferInstance : IsNoetherian ℤ (Fin 3 → ℤ))
#check @AddSubgroup.toIntSubmodule
#check @Submodule.fg_iff_exists_fin_generating_family
#check @Submodule.mem_span_range_iff_exists_fun
#check @Matrix.toLin'
#check @Matrix.mulVecLin
-- L1.2
#check @AddMonoidHom.liftOfSurjective
#check @AddMonoidHom.liftOfRightInverse_comp_apply
#check @AddMonoidHom.rangeRestrict_surjective
#check @Module.Baer.of_divisible
#check @Module.Baer.extension_property_addMonoidHom
#check (inferInstance : DivisibleBy UnitAddCircle ℤ)
#check @AddCircle.coe_eq_zero_iff
#check @QuotientAddGroup.lift
#check @QuotientAddGroup.quotientKerEquivRange
-- L1.4, L1.5
#check @AddCircle.continuous_mk'
#check (inferInstance : T2Space UnitAddCircle)
#check (inferInstance : CompactSpace (ℤ → UnitAddCircle))
#check @AddMonoidHom.isClosed_range_coe
#check @IsCompact.inter_iInter_nonempty
#check @IsCompact.nonempty_iInter_of_directed_nonempty_isCompact_isClosed
#check @AddMonoidHom.mk'
-- L1.6, L1.7
#check @Finset.equivFin
#check @UnitRing.unitRingOver_le_planeOverSubring
#check @unitDistance_adj
#check @SimpleGraph.comap_adj
#check @SimpleGraph.induce
#check @ThreeColour.nonempty_winding
#check @SpectralChain.unitVectors
#check @planeOverSubring
