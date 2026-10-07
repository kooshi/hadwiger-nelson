import OAI.Geometry.PlaneColoring.Five
/-! EXT-OAI1, stage 8 — the read-back of the import, by the kernel, at the RELEASE's pin: the definitions and the two
statements exactly as `ImportSkeleton.lean` declares them at lean-dir's pin (same text, same namespace), each definition
equal to the release's by `rfl`, each statement closed by the release's theorem. -/
open MeasureTheory
namespace HadwigerNelson.Outside.OAI158
def ProperColoring (k : ℕ) (c : ℂ → Fin k) : Prop :=
  ∀ x y : ℂ, ‖x - y‖ = 1 → c x ≠ c y
scoped instance anglePeriodPositive : Fact (0 < 2*Real.pi) := ⟨by positivity⟩
abbrev Angles := AddCircle (2*Real.pi)
noncomputable def angularMeasure : Measure Angles := AddCircle.haarAddCircle
noncomputable def direction (t : Angles) : ℂ := AddCircle.toCircle t
def WeakColoring (k : ℕ) (c : ℂ → Fin k) : Prop :=
  AEMeasurable c (volume : Measure ℂ) ∧ ∀ᵐ p ∂(volume : Measure ℂ).prod angularMeasure,
    c p.1 ≠ c (p.1+direction p.2)

example : @ProperColoring = @OAI.EuclideanFiveColor.ProperColoring := rfl
example : angularMeasure = OAI.EuclideanFiveColor.angularMeasure := rfl
example : @direction = @OAI.EuclideanFiveColor.direction := rfl
example : @WeakColoring = @OAI.EuclideanFiveColor.WeakColoring := rfl

/-- H, as the skeleton states it. -/
theorem no_proper_five_coloring : ¬ ∃ c : ℂ → Fin 5, ProperColoring 5 c :=
  OAI.EuclideanFiveColor.no_proper_five_coloring
/-- T, as the skeleton states it. -/
theorem proper_to_borel_weak {k : ℕ} [NeZero k] {c : ℂ → Fin k} (hc : ProperColoring k c) :
    ∃ d : ℂ → Fin k, Measurable d ∧ WeakColoring k d :=
  OAI.EuclideanFiveColor.proper_to_borel_weak hc
end HadwigerNelson.Outside.OAI158
#print axioms HadwigerNelson.Outside.OAI158.no_proper_five_coloring
#print axioms HadwigerNelson.Outside.OAI158.proper_to_borel_weak
