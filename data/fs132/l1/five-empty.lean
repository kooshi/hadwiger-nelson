import Proofs.HadwigerNelson.Outside.OAI158
import Proofs.HadwigerNelson.Instances.HexShell
open HadwigerNelson HadwigerNelson.Outside.OAI158
-- FS132-L1: what the import does to three older statements, as terms the kernel checks (`lake env lean`, iteration:
-- NOT library theorems — the coordinator's ruling R1 keeps every such statement out of the library at this landing).
set_option pp.fullNames true

/-- The carrier of `hexShell_plane5` is empty given the import. -/
theorem l1_isEmpty_plane5 : IsEmpty ((unitDistance ℂ).Coloring (Fin 5)) :=
  ⟨fun C => not_colorable_five ⟨C⟩⟩
#print axioms l1_isEmpty_plane5

/-- `inline:SixTarget`'s two binders hold with nothing to prove, given the import. -/
theorem l1_sixTarget_h3 : ∀ (C : (unitDistance ℂ).Coloring (Fin 5)) (x y : ℂ), dist x y = Real.sqrt 3 → C x ≠ C y :=
  fun C => (not_colorable_five ⟨C⟩).elim
theorem l1_sixTarget_h2 : ∀ (C : (unitDistance ℂ).Coloring (Fin 5)) (x y : ℂ), dist x y = 2 → C x ≠ C y :=
  fun C => (not_colorable_five ⟨C⟩).elim
#print axioms l1_sixTarget_h3
-- and the two theorems that take them then conclude the import's own statements
example : ¬ (unitDistance ℂ).Colorable 5 := not_colorable_five_of_forced_pairs l1_sixTarget_h3 l1_sixTarget_h2
example : 6 ≤ (unitDistance ℂ).chromaticNumber := six_le_chromaticNumber_plane_of_forced_pairs l1_sixTarget_h3 l1_sixTarget_h2

/-- `inline:SixTargetOneTwo`'s binder ranges over five-colourings of the `{1, 2}`-distance graph of the plane; each is a
five-colouring of the unit-distance graph, so given the import there is none. -/
theorem l1_not_colorable_oneTwo_five : ¬ (distanceGraph ℂ {1, 2}).Colorable 5 := fun h => by
  have h1 : (unitDistance ℂ).chromaticNumber ≤ (distanceGraph ℂ {1, 2}).chromaticNumber :=
    chromaticNumber_unitDistance_le_distanceGraph (by simp)
  have h5 : (distanceGraph ℂ {1, 2}).chromaticNumber ≤ 5 := SimpleGraph.chromaticNumber_le_iff_colorable.mpr h
  exact not_colorable_five (SimpleGraph.chromaticNumber_le_iff_colorable.mp (h1.trans h5))
theorem l1_sixTargetOneTwo_h3 : ∀ (C : (distanceGraph ℂ {1, 2}).Coloring (Fin 5)) (x y : ℂ),
    dist x y = Real.sqrt 3 → C x ≠ C y :=
  fun C => (l1_not_colorable_oneTwo_five ⟨C⟩).elim
#print axioms l1_sixTargetOneTwo_h3
example : 6 ≤ (distanceGraph ℂ {1, 2}).chromaticNumber := six_le_chromaticNumber_oneTwo_of_forced_sqrt3 l1_sixTargetOneTwo_h3

-- the partner is data/fs132/l1/five-empty-control.lean: the same term at SIX colours must NOT elaborate (the
-- seven-target stays open: the import says nothing at six).
