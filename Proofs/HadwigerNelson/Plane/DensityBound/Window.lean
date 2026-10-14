import Proofs.HadwigerNelson.Plane.DensityBound.Pattern
import Proofs.HadwigerNelson.Plane.OneAvoidingDensity

/-!
# Proposition 1 in finite-window form, and the composition proving `OneAvoidingDensityBound` (FS-131, FS131-KDB1; skeleton)

Any dual certificate `C` (valid) with a `w₀` and `µ < 1` such that `ϕ(t) ≥ 1 − µ` for all `t ≥ 0` bounds the upper density
of every Lebesgue-measurable 1-avoiding planar set by `C.bound / (1 − µ)`, at every centre. With `[AmbrusEtAl2023]`'s
certificate (`X₂₃`, `g23.csv`; the instance module `Plane/DensityBound/X23`, a lane of its own) this is Theorem 1.
Plan: `plans/FS131-KDB1-density-bound.md` § 3.
-/

namespace HadwigerNelson.DensityBound

open Real MeasureTheory Set Metric Filter
open scoped ENNReal

namespace DualCert

variable {n : ℕ} (C : DualCert n)

/-- **One window**: `(1 − µ) vol E ≤ bound · vol B(x₀, R + D)` for a bounded Borel 1-avoiding `E ⊆ B(x₀, R)`. -/
theorem window_le (hC : C.Valid) {w0 mu : ℝ} (hW : ∀ t : ℝ, 0 ≤ t → 1 - mu ≤ C.phi w0 t) {E : Set ℂ}
    (hE : MeasurableSet E) (h1 : ∀ a ∈ E, ∀ b ∈ E, dist a b ≠ 1) {x₀ : ℂ} {R D : ℝ} (hER : E ⊆ ball x₀ R)
    (hD : ∀ i, ‖C.X i‖ ≤ D) :
    (1 - mu) * (volume E).toReal ≤ C.bound * (volume (ball x₀ (R + D))).toReal := by
  sorry

/-- **Proposition 1, finite-window form**, on the library's plane `ℂ`, at every centre. -/
theorem limsup_le (hC : C.Valid) {w0 mu : ℝ} (hmu : mu < 1) (hW : ∀ t : ℝ, 0 ≤ t → 1 - mu ≤ C.phi w0 t)
    {A : Set ℂ} (hA : NullMeasurableSet A volume) (h1 : ∀ a ∈ A, ∀ b ∈ A, dist a b ≠ 1) (x₀ : ℂ) :
    limsup (fun R : ℝ => volume (A ∩ ball x₀ R) / volume (ball x₀ R)) atTop ≤
      ENNReal.ofReal (C.bound / (1 - mu)) := by
  sorry

/-- **The composition**: a valid certificate with `C.bound / (1 − µ) ≤ 0.2470` proves `Plane.OneAvoidingDensityBound`
(the paper's form on `EuclideanSpace ℝ (Fin 2)`, through the volume-preserving isometry with `ℂ`). -/
theorem oneAvoidingDensityBound_of (hC : C.Valid) {w0 mu : ℝ} (hmu : mu < 1)
    (hW : ∀ t : ℝ, 0 ≤ t → 1 - mu ≤ C.phi w0 t) (hβ : C.bound / (1 - mu) ≤ 0.2470) :
    Plane.OneAvoidingDensityBound := by
  sorry

end DualCert

end HadwigerNelson.DensityBound
