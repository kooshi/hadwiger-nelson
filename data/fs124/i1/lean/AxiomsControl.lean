import Proofs.HadwigerNelson.Plane.RadiusOutside
/-!
FS124-I1 — the control of `data/fs124/i1/axioms_check.py`: three planted faults and one partner that must pass.
Nothing here is in the library.  The `sorry` below is the planted fault; its warning is expected.
-/
open HadwigerNelson HadwigerNelson.Plane Metric
set_option pp.fullNames true

namespace FS124I1Control

/-- Planted: expected clean, proved by `sorry`. -/
theorem clean_but_sorry : rigidMotion (0, 0) 1 = 1 := by sorry

/-- Planted: expected clean, rests on `no_proper_five_coloring`. -/
theorem clean_but_imported : ∃ R > (0 : ℝ), ∀ p : ℂ, ¬ ∃ c : ℂ → Fin 5, IsWeakColouringOn (ball p R) c :=
  radius_five

/-- Planted: expected on the transfer alone, rests on both imports. -/
theorem transfer_but_both : (∃ R > (0 : ℝ), ∀ p : ℂ, ¬ ∃ c : ℂ → Fin 5, IsWeakColouringOn (ball p R) c) ∧
    ((unitDistance ℂ).Colorable 7 ↔ ∀ R > (0 : ℝ), ∃ c : ℂ → Fin 7, IsWeakColouringOn (ball (0 : ℂ) R) c) :=
  ⟨radius_five, colorable_iff_forall_ball⟩

/-- Partner: expected clean, and clean. -/
theorem clean_partner : rigidMotion (0, 0) 1 = 1 := by simp [rigidMotion, e]

end FS124I1Control

#print axioms FS124I1Control.clean_but_sorry
#print axioms FS124I1Control.clean_but_imported
#print axioms FS124I1Control.transfer_but_both
#print axioms FS124I1Control.clean_partner
