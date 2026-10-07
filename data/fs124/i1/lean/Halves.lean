import Proofs.HadwigerNelson.Plane.RadiusOutside
/-!
FS124-I1 — which half of each join theorem rests on the import: the two halves proved here, outside the library,
each from the lemma the join theorem's docstring names, and their axioms printed.  A half proved through the
`iff` itself would print the import whichever half it is: `#print axioms` reads the whole theorem's list.
-/
open HadwigerNelson HadwigerNelson.Plane Metric
set_option pp.fullNames true

namespace FS124I1Halves

/-- `colorable_iff_forall_ball`, `←`: C124-RADIUS-UP. -/
theorem colorable_of_forall_ball {k : ℕ}
    (h : ∀ R > (0 : ℝ), ∃ c : ℂ → Fin k, IsWeakColouringOn (ball (0 : ℂ) R) c) : (unitDistance ℂ).Colorable k :=
  SimpleGraph.chromaticNumber_le_iff_colorable.mp (radius_up h).2

/-- `colorable_iff_forall_ball`, `→`: C124-RADIUS-DOWN. -/
theorem forall_ball_of_colorable {k : ℕ} (h : (unitDistance ℂ).Colorable k) :
    ∀ R > (0 : ℝ), ∃ c : ℂ → Fin k, IsWeakColouringOn (ball (0 : ℂ) R) c :=
  fun _ _ => radius_down (SimpleGraph.chromaticNumber_le_iff_colorable.mpr h) _ isOpen_ball

/-- `seven_le_chromaticNumber_plane_iff_exists_ball`, `→`: seven gives a disc with no weak six-colouring. -/
theorem exists_ball_of_seven_le (h : 7 ≤ (unitDistance ℂ).chromaticNumber) :
    ∃ R > (0 : ℝ), ¬ ∃ c : ℂ → Fin 6, IsWeakColouringOn (ball (0 : ℂ) R) c := by
  have h6 : ¬ (unitDistance ℂ).Colorable 6 :=
    (add_one_le_chromaticNumber_iff_not_colorable (G := unitDistance ℂ) (n := 6)).mp h
  obtain ⟨R, hR, hRp⟩ := exists_radius_of_not_colorable h6
  exact ⟨R, hR, fun ⟨c, hc⟩ => hRp 0 c hc.aeProperOn⟩

/-- `seven_le_chromaticNumber_plane_iff_exists_ball`, `←`: a disc with no weak six-colouring gives seven. -/
theorem seven_le_of_exists_ball (h : ∃ R > (0 : ℝ), ¬ ∃ c : ℂ → Fin 6, IsWeakColouringOn (ball (0 : ℂ) R) c) :
    7 ≤ (unitDistance ℂ).chromaticNumber := by
  refine (add_one_le_chromaticNumber_iff_not_colorable (G := unitDistance ℂ) (n := 6)).mpr fun hcol => ?_
  obtain ⟨R, -, hR⟩ := h
  exact hR (radius_down (SimpleGraph.chromaticNumber_le_iff_colorable.mpr hcol) _ isOpen_ball)

end FS124I1Halves

#print axioms FS124I1Halves.colorable_of_forall_ball
#print axioms FS124I1Halves.forall_ball_of_colorable
#print axioms FS124I1Halves.exists_ball_of_seven_le
#print axioms FS124I1Halves.seven_le_of_exists_ball
