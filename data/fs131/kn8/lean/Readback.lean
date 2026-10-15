import Proofs.HadwigerNelson.Rigidity.ChainAtTA
import Proofs.HadwigerNelson.Rigidity.PositiveEntropy
import Proofs.HadwigerNelson.Rigidity.HaarMultiple
import Mathlib

/-! FS131-KN8 stage 1: the declared theorem, the split and its consumer as the kernel prints them (default printing,
with the open lines of their files); then the Mathlib names the plan of this job leans on, checked at the pin. -/

namespace HadwigerNelson.Rigidity
open MeasureTheory SimpleGraph SpectralChain SpectralInputs NumberField
open scoped Pointwise ENNReal

#check @positive_entropy_rigidity
#print EntropySplit
#print ZeroEntropyCarried
#check @mrPlus_of_split_of_carried
#check @haar_or_zero_entropy
#print axioms mrPlus_of_split_of_carried
#print RotInv
#print IsHaarFourier
#check @ext_of_fourier
#check @exists_isHaarFourier
#check @IsHaarFourier.map_mulRight
#check @maxMultiple
#check @map_sub_maxMultiple
#check @not_smul_le_sub_maxMultiple
#check @ksEntropy
#check @ksEntropyOn
#check @ksEntropy_eq_iSup_ksEntropyOn
#check @ksEntropy_bind_eq_zero
#check @ksEntropy_dirac
#check @ksEntropy_map
#check @SpectralChain.measurable_rot
#check @planeOver
#check @planeOverSubring

end HadwigerNelson.Rigidity

-- Mathlib, at the pin
#check @MeasureTheory.ext_of_forall_mem_subalgebra_integral_eq_of_polish
#check @borel_comap
#check @Pi.borelSpace
#check @PolishSpace.pi_countable
#check @Topology.IsClosedEmbedding.polishSpace
#check @CharacterModule.exists_character_apply_ne_zero_of_ne_zero
#check @MeasureTheory.Measure.haarMeasure
#check @MeasureTheory.Measure.haarMeasure_self
#check @MeasureTheory.Measure.isHaarMeasure_eq_of_isProbabilityMeasure
#check @MeasureTheory.Measure.IsHaarMeasure
#check @MeasureTheory.Measure.IsAddHaarMeasure
#check @TopologicalSpace.PositiveCompacts
#check (inferInstance : TopologicalSpace (Additive Circle))
#check (inferInstance : MeasurableSpace (Additive Circle))
#check (inferInstance : IsTopologicalAddGroup (Additive Circle))
#check (inferInstance : BorelSpace (Additive Circle))
#check @StandardBorelSpace
#check (inferInstance : CommGroup (AddChar ℤ Circle))
#check @AddChar.compAddMonoidHom
#check @AddCircle.toCircle
#check @ErgodicSMul
#check @MeasureTheory.condExpKernel
#check @MeasureTheory.Measure.sub_add_cancel_of_le
#check @Subgroup.closure
#check @ContinuousMap.starSubalgebra_topologicalClosure_eq_top_of_separatesPoints
#check @BoundedContinuousFunction.toContinuousMapStarₐ
#check @Algebra.adjoin_eq_span
#check @AddChar.coe_mul
#check @Subgroup.instMulAction
#check @Set.Countable.measurableSet
#check @MeasurableSpace.comap_generateFrom
#check @Topology.IsInducing.secondCountableTopology
#check @Topology.IsEmbedding.t2Space
#check @Topology.IsClosedEmbedding.compactSpace
#check @isCompact_univ_pi
#check @AddChar.map_zero_eq_one
#check @PontryaginDual
#check @MeasureTheory.Measure.map_map
#check @MeasureTheory.MeasurePreserving
