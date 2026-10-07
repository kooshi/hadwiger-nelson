import Proofs.HadwigerNelson.Instances.Interval
/-! EXT-OAI1, stage 7 — DRAFTED AND ADDED NOWHERE. What the outside theorem would say in this library's
vocabulary, with the outside theorem as a hypothesis in Mathlib's vocabulary (its unfolded statement,
`audit_unfolded` in `Statement.lean`). Checked with `lake env lean` at this repository's pin; not a module
of `Proofs`, not built, not imported. -/

namespace HadwigerNelson

/-- If no map `ℂ → Fin 5` separates every unit pair, the plane needs six colours. -/
theorem six_le_chromaticNumber_plane_of_no_proper_five
    (h : ¬ ∃ c : ℂ → Fin 5, ∀ x y : ℂ, ‖x - y‖ = 1 → c x ≠ c y) :
    6 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber := by
  rw [chromaticNumber_plane_eq_complex]
  have h6 := (add_one_le_chromaticNumber_iff_not_colorable (G := unitDistance ℂ) (n := 5)).mpr
    fun ⟨C⟩ => h ⟨C, fun x y hxy => C.valid (unitDistance_adj.mpr (by rw [dist_eq_norm, hxy]))⟩
  exact_mod_cast h6

/-- Row 33's interval with its lower end moved: `6 ≤ χ(ℝ²) ≤ 7`, given the outside theorem. -/
theorem chromaticNumber_plane_six_or_seven_of_no_proper_five
    (h : ¬ ∃ c : ℂ → Fin 5, ∀ x y : ℂ, ‖x - y‖ = 1 → c x ≠ c y) :
    6 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber ∧
      (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber ≤ 7 :=
  ⟨six_le_chromaticNumber_plane_of_no_proper_five h, chromaticNumber_plane_interval.2⟩

/-- The converse reading, so the hypothesis is exactly the bound and nothing more: six colours needed
means no proper five-colouring of `ℂ`. -/
theorem no_proper_five_of_six_le_chromaticNumber_plane
    (h6 : 6 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber) :
    ¬ ∃ c : ℂ → Fin 5, ∀ x y : ℂ, ‖x - y‖ = 1 → c x ≠ c y := by
  rintro ⟨c, hc⟩
  rw [chromaticNumber_plane_eq_complex] at h6
  have h6' : ((5 + 1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := by exact_mod_cast h6
  exact (add_one_le_chromaticNumber_iff_not_colorable.mp h6')
    ⟨SimpleGraph.Coloring.mk c fun {x y} hxy => hc x y (by rw [← dist_eq_norm]; exact unitDistance_adj.mp hxy)⟩

end HadwigerNelson

#print axioms HadwigerNelson.six_le_chromaticNumber_plane_of_no_proper_five
#print axioms HadwigerNelson.chromaticNumber_plane_six_or_seven_of_no_proper_five
#print axioms HadwigerNelson.no_proper_five_of_six_le_chromaticNumber_plane
