import Proofs.HadwigerNelson.Plane.OneClass.Fractional
import Proofs.HadwigerNelson.Plane.OneClass.Pair
/-!
FS133-LD1 — the headlines of FS-133 as the kernel stores them, printed for the read-aloud (read-only): each headline's
statement with every binder (`#check @…`), its axioms, and every definition the statements name, with its value.
  lake env lean data/fs133/ld1/lean/ReadAloud.lean
-/
open HadwigerNelson HadwigerNelson.OneClass HadwigerNelson.Plane

set_option pp.fullNames true
-- K133-ONE, first line
#check @HadwigerNelson.OneClass.finIndepRatio_plane_eq_mOne
#check @HadwigerNelson.OneClass.finIndepRatio_algPlane_eq_mOne
-- K133-ONE, second line
#check @HadwigerNelson.OneClass.iSup_fractionalChromaticNumber_plane
#check @HadwigerNelson.OneClass.fractionalChromaticNumber_plane
#check @HadwigerNelson.OneClass.fractionalChromaticNumber_algPlane
-- K133-FN
#check @HadwigerNelson.OneClass.tendsto_minIndepNum_div
-- K133-PAIR, both clauses, and the two directions they are assembled from
#check @HadwigerNelson.OneClass.exists_admissibleOn_univ_iff_ae
#check @HadwigerNelson.OneClass.exists_admissibleOn_univ_iff_algPlane
#check @HadwigerNelson.OneClass.exists_measurable_admissibleAe
#check @HadwigerNelson.OneClass.exists_admissibleOn_of_ae
-- the one value claimed
#check @HadwigerNelson.OneClass.one_seventh_le_mOne
-- the definitions the statements name
#print SimpleGraph.finIndepRatio
#print HadwigerNelson.Plane.mOne
#print HadwigerNelson.Plane.minIndepNum
#print HadwigerNelson.OneClass.AdmissibleOn
#print HadwigerNelson.OneClass.AdmissibleAe
#print HadwigerNelson.OneClass.IsAlgPattern
#print HadwigerNelson.Outside.OAI158.Spectral.E
#print SimpleGraph.fractionalChromaticNumber
#print HadwigerNelson.Plane.upperDensity
#print axioms HadwigerNelson.OneClass.finIndepRatio_plane_eq_mOne
#print axioms HadwigerNelson.OneClass.finIndepRatio_algPlane_eq_mOne
#print axioms HadwigerNelson.OneClass.iSup_fractionalChromaticNumber_plane
#print axioms HadwigerNelson.OneClass.fractionalChromaticNumber_plane
#print axioms HadwigerNelson.OneClass.fractionalChromaticNumber_algPlane
#print axioms HadwigerNelson.OneClass.tendsto_minIndepNum_div
#print axioms HadwigerNelson.OneClass.exists_admissibleOn_univ_iff_ae
#print axioms HadwigerNelson.OneClass.exists_admissibleOn_univ_iff_algPlane
#print axioms HadwigerNelson.OneClass.one_seventh_le_mOne
