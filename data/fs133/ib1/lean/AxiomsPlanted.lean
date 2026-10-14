import Proofs.HadwigerNelson.Plane.OneClass.InvariantLaw
import Proofs.HadwigerNelson.Plane.OneClass.SectionDensity
-- FS133-IB1: the axioms of every public declaration of this job's two modules, from the built tree.
#print axioms HadwigerNelson.OneClass.countable_algPlane
#print axioms HadwigerNelson.OneClass.exists_foelner_finset
#print axioms HadwigerNelson.OneClass.exists_invariant_of_closed
#print axioms HadwigerNelson.OneClass.exists_isInvariantLaw
#print axioms HadwigerNelson.OneClass.exists_isInvariantLaw_unitDistance
#print axioms HadwigerNelson.OneClass.exists_shiftInvariant_of_foelner
#print axioms HadwigerNelson.OneClass.exists_turnInvariant
#print axioms HadwigerNelson.OneClass.norm_kCoeff_mul
#print axioms HadwigerNelson.OneClass.unitDistance_algPlane_eq_circulantGraph
#print axioms HadwigerNelson.OneClass.IsShiftInvariantLaw.measure_origin_le
#print axioms HadwigerNelson.Plane.exists_mem_le_sectionDensity
#print axioms HadwigerNelson.Plane.le_lintegral_sectionDensity
#print axioms HadwigerNelson.Plane.measurable_sectionDensity
#print axioms HadwigerNelson.Plane.measure_le_sectionDensity_pos
#print axioms HadwigerNelson.Plane.ofReal_integral_le_measure_pos
#print axioms HadwigerNelson.Plane.sectionDensity
#print axioms HadwigerNelson.Plane.sectionDensity_empty
#print axioms HadwigerNelson.Plane.sectionDensity_setOf_pos
#print axioms HadwigerNelson.Plane.sectionDensity_univ
-- planted (FS133-IB1 control): a record on `sorryAx`, which the reader must report
theorem fs133IB1PlantedRecord : HadwigerNelson.Plane.sectionDensity (X := ℕ) (Ω := ℕ) (MeasureTheory.Measure.count) (fun _ => Set.univ) ∅ 0 = 0 := sorry
#print axioms fs133IB1PlantedRecord
