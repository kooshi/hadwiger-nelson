import Proofs.HadwigerNelson.Outside.OAI158PaletteTransport

/-!
# A ring filled by two labels changes somewhere (FS-132, C132-M-EXCL's reduction) — SKELETON

The derivation's "Argument — the ring form": if almost every palette at `p` holds `X` or `Y`, some angle has both in
positive measure in each of its neighbourhoods. With `ae_real_of_ae_angles` (a statement almost everywhere on the
circle of angles holds for almost every real angle) this turns the hypothesis of C132-M-EXCL into that of
C132-M-ORBIT. For a colouring of the whole plane; any number of labels.
-/

open MeasureTheory

namespace HadwigerNelson.SixRing

open Outside.OAI158

/-- **A ring filled by two labels has an orbit of the kind C132-M-ORBIT refutes** (no four-cycle enters): if almost
every palette at `p` contains `X` or `Y`, there is an angle `ψ` every neighbourhood of which holds both, in positive
measure. ("The set of `θ` near which `s` is almost everywhere constant is open; were it the whole circle, `s` would
be almost everywhere constant by connectedness", against the flip under `π/3`.) -/
theorem exists_change_of_ae_outside {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ)
    {X Y : Fin k} (hXY : X ≠ Y)
    (h : ∀ᵐ t ∂angularMeasure, X ∈ palette c hc p t ∨ Y ∈ palette c hc p t) :
    ∃ ψ : ℝ, ∀ η : ℝ, 0 < η →
      0 < volume {θ : ℝ | θ ∈ Set.Ioo (ψ - η) (ψ + η) ∧ X ∈ palette c hc p (θ : Angles)} ∧
      0 < volume {θ : ℝ | θ ∈ Set.Ioo (ψ - η) (ψ + η) ∧ Y ∈ palette c hc p (θ : Angles)} := by
  sorry

/-- A statement almost everywhere on the circle of angles holds for almost every real angle. -/
theorem ae_real_of_ae_angles {P : Angles → Prop} (h : ∀ᵐ t ∂angularMeasure, P t) : ∀ᵐ θ : ℝ, P (θ : Angles) := by
  sorry

end HadwigerNelson.SixRing
