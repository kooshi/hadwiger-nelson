import Proofs.HadwigerNelson.Outside.OAI158
open HadwigerNelson HadwigerNelson.Outside.OAI158
-- FS132-L1: every statement of the module as the kernel holds it, on the built module. The first seventeen lines are
-- the import's own list (data/fs132/i1/checks.lean, unchanged, so the two outputs can be compared line for line); the
-- eighteenth is the landing's theorem, with its axioms and those of the two theorems it is two lines from.
#check @no_proper_five_coloring
#check @proper_to_borel_weak
#check @properColoring_iff_colorable
#check @weakColoring_iff_unitPairsNull
#check @nonempty_aeColouring_of_weak
#check @weakColoring_of_aeColouring
#check @exists_weakColoring_iff_nonempty_aeColouring
#check @proper_to_borel_weak_model
#check @not_colorable_five
#check @six_le_chromaticNumber_plane
#check @chromaticNumber_plane_six_or_seven
#check @nonempty_aeColouring_of_colorable
#check @colorable_iff_nonempty_aeColouring
#check @chiM0_le_chromaticNumber_plane
#check @chromaticNumber_plane_eq_chiM0
#check @six_le_chiM0
#check @chiM0_six_or_seven
#check @seven_le_chromaticNumber_plane_iff
set_option pp.fullNames true
#print axioms seven_le_chromaticNumber_plane_iff
#print axioms chromaticNumber_plane_eq_chiM0
#print axioms Plane.seven_le_chiM0_iff
-- the statement with nothing hidden: every constant by its full name, the bounded supremum unfolded
set_option pp.notation false in
#check @seven_le_chromaticNumber_plane_iff
-- the two readings the docstring leans on, as terms the kernel checks here (iteration only: not library theorems)
example : (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber = (unitDistance ℂ).chromaticNumber :=
  chromaticNumber_plane_eq_complex
example : Filter.Tendsto (Plane.mu 6) (nhdsWithin 0 (Set.Ioi 0)) (nhds (Plane.muZero 6)) := Plane.tendsto_mu 6
example : Antitone (Plane.mu 6) := Plane.antitone_mu 6
example (ε : ℝ) : Plane.mu 6 ε ≤ 1 := Plane.mu_le_one 6 ε
example (ε : ℝ) : Plane.muPer 6 ε ≤ Plane.muTile 6 ε := Plane.muPer_le_muTile 6 ε
example (ε : ℝ) : Plane.muTile 6 ε ≤ Plane.mu 6 ε := Plane.muTile_le_mu 6 ε
example : Filter.Tendsto (Plane.muPer 6) (nhdsWithin 0 (Set.Ioi 0)) (nhds (Plane.muZero 6)) := Plane.tendsto_muPer 6
example : Filter.Tendsto (Plane.muTile 6) (nhdsWithin 0 (Set.Ioi 0)) (nhds (Plane.muZero 6)) := Plane.tendsto_muTile 6
example {A : Set ℂ} {ε : ℝ} (h : Plane.BandFree A ε) : Plane.BandNull A ε := Plane.bandNull_of_bandFree h
-- the answer in both directions, from the module's theorems: seven exactly when the limit is below one, six otherwise
example : (unitDistance ℂ).chromaticNumber = 7 ↔ (⨆ ε > (0 : ℝ), Plane.mu 6 ε) < 1 := by
  rw [← seven_le_chromaticNumber_plane_iff]
  have h7 : (unitDistance ℂ).chromaticNumber ≤ 7 := by
    rw [← chromaticNumber_plane_eq_complex]; exact chromaticNumber_plane_interval.2
  exact ⟨fun h => h.ge, fun h => le_antisymm h7 h⟩
