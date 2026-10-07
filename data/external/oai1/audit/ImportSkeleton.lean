import Proofs.HadwigerNelson.Instances.Interval
import Proofs.HadwigerNelson.Plane.AeColouring
import Mathlib.Analysis.Fourier.AddCircle
/-! EXT-OAI1, stage 8 — THE IMPORT, AS A PLANNER'S SKELETON. Not a module of `Proofs`; checked with `lake env lean`
at this repository's pin. Two outside theorems of `[OAIMath2026]` (github.com/openai/math at commit
`adc7f1241b42e322a6451854ab7e4b4c146bf78a`), each stated in the release's own form over the release's own
definitions, copied; then the forms this library uses, derived. One leaf is `sorry` (the measure bridge), with its
plan in `plans/EXT-OAI1-audit.md` stage 8. N-EASY (`Plane.chromaticNumber_plane_le_chiM0`, `Plane/YesLimit.lean:105` on
`main`) enters as the hypothesis `hNEASY` only because that module's olean was not built in this tree when this was
checked; the implementer imports `Plane.YesLimit` and drops the binder. -/

open MeasureTheory

namespace HadwigerNelson.Outside.OAI158

/-! ## The release's definitions, copied (`lean/OAI/Geometry/PlaneColoring/Coloring.lean`, lines 7–8 and 15–29) -/

/-- `[OAIMath2026]` `Coloring.lean:7–8`: `OAI.EuclideanFiveColor.ProperColoring`. -/
def ProperColoring (k : ℕ) (c : ℂ → Fin k) : Prop :=
  ∀ x y : ℂ, ‖x - y‖ = 1 → c x ≠ c y

/-- `[OAIMath2026]` `Coloring.lean:15` (there a global instance; here scoped). -/
scoped instance anglePeriodPositive : Fact (0 < 2*Real.pi) := ⟨by positivity⟩
/-- `[OAIMath2026]` `Coloring.lean:16`. -/
abbrev Angles := AddCircle (2*Real.pi)
/-- `[OAIMath2026]` `Coloring.lean:17`: normalized Haar measure on the circle of angles. -/
noncomputable def angularMeasure : Measure Angles := AddCircle.haarAddCircle
/-- `[OAIMath2026]` `Coloring.lean:18`: the unit vector at an angle. -/
noncomputable def direction (t : Angles) : ℂ := AddCircle.toCircle t
/-- `[OAIMath2026]` `Coloring.lean:27–29`: `OAI.EuclideanFiveColor.WeakColoring`. -/
def WeakColoring (k : ℕ) (c : ℂ → Fin k) : Prop :=
  AEMeasurable c (volume : Measure ℂ) ∧ ∀ᵐ p ∂(volume : Measure ℂ).prod angularMeasure,
    c p.1 ≠ c (p.1+direction p.2)

/-! ## The two outside theorems, in the release's form -/

/-- **Outside theorem H** — `[OAIMath2026]` family 158, `lean/OAI/Geometry/PlaneColoring/Five.lean:124`,
`OAI.EuclideanFiveColor.no_proper_five_coloring`. external. -/
axiom no_proper_five_coloring : ¬ ∃ c : ℂ → Fin 5, ProperColoring 5 c

/-- **Outside theorem T** — `[OAIMath2026]` family 158, `lean/OAI/Geometry/PlaneColoring/BorelTransfer.lean:436–437`,
`OAI.EuclideanFiveColor.proper_to_borel_weak`. external. -/
axiom proper_to_borel_weak {k : ℕ} [NeZero k] {c : ℂ → Fin k} (hc : ProperColoring k c) :
    ∃ d : ℂ → Fin k, Measurable d ∧ WeakColoring k d

/-! ## Models of the hypotheses (LEAN.md § Assumptions, item 3) -/

/-- A proper colouring in the release's sense is a colouring of this library's `unitDistance ℂ`, and conversely. -/
theorem properColoring_iff_colorable {k : ℕ} : (∃ c : ℂ → Fin k, ProperColoring k c) ↔ (unitDistance ℂ).Colorable k :=
  ⟨fun ⟨c, hc⟩ => ⟨SimpleGraph.Coloring.mk c fun {x y} hxy => hc x y (by rw [← dist_eq_norm]; exact unitDistance_adj.mp hxy)⟩,
   fun ⟨C⟩ => ⟨C, fun x y hxy => C.valid (unitDistance_adj.mpr (by rw [dist_eq_norm, hxy]))⟩⟩

/-- **Model of T's hypothesis**: a proper seven-colouring exists (row 33's upper end). H has no hypothesis. -/
theorem exists_properColoring_seven : ∃ c : ℂ → Fin 7, ProperColoring 7 c := by
  rw [properColoring_iff_colorable, ← SimpleGraph.chromaticNumber_le_iff_colorable, ← chromaticNumber_plane_eq_complex]
  exact chromaticNumber_plane_interval.2

/-! ## The forms this library uses, derived -/

/-- **`6 ≤ χ(ℝ²)`**, row 33's form. -/
theorem six_le_chromaticNumber_plane : 6 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber := by
  rw [chromaticNumber_plane_eq_complex]
  have h6 := (add_one_le_chromaticNumber_iff_not_colorable (G := unitDistance ℂ) (n := 5)).mpr
    fun h => no_proper_five_coloring (properColoring_iff_colorable.mpr h)
  exact_mod_cast h6

/-- **`6 ≤ χ(ℝ²) ≤ 7`**: row 33 with its lower end moved. -/
theorem chromaticNumber_plane_six_or_seven :
    6 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber ∧
      (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber ≤ 7 :=
  ⟨six_le_chromaticNumber_plane, chromaticNumber_plane_interval.2⟩

/-- **LEAF (the measure bridge)**: the release's weak colourings are this library's `AeColouring`s. Plan: stage 8. -/
theorem nonempty_aeColouring_of_weak {k : ℕ} {d : ℂ → Fin k} (hd : Measurable d) (hw : WeakColoring k d) :
    Nonempty (Plane.AeColouring k) := by
  sorry

/-- **`χ_m⁰(ℝ²) ≤ χ(ℝ²)`** — the half of row 130's collapse that was given MR. -/
theorem chiM0_le_chromaticNumber_plane : Plane.chiM0 ≤ (unitDistance ℂ).chromaticNumber := by
  rw [SimpleGraph.chromaticNumber]
  refine le_iInf₂ fun k hk => ?_
  obtain ⟨c, hc⟩ := properColoring_iff_colorable.mpr hk
  haveI : NeZero k := ⟨fun h => by subst h; exact (c 0).elim0⟩
  obtain ⟨d, hd, hw⟩ := proper_to_borel_weak hc
  obtain ⟨a⟩ := nonempty_aeColouring_of_weak hd hw
  exact Plane.chiM0_le a

/-- **Row 130's collapse, with no MR**: `χ(ℝ²) = χ_m⁰(ℝ²)`. On branch `fs131-w9` this is `Row130Collapse` by definition. -/
theorem chromaticNumber_plane_eq_chiM0 (hNEASY : (unitDistance ℂ).chromaticNumber ≤ Plane.chiM0) :
    (unitDistance ℂ).chromaticNumber = Plane.chiM0 :=
  le_antisymm hNEASY chiM0_le_chromaticNumber_plane

/-- **`6 ≤ χ_m⁰(ℝ²)`** (FS-104's question), from H and N-EASY alone. -/
theorem six_le_chiM0 (hNEASY : (unitDistance ℂ).chromaticNumber ≤ Plane.chiM0) : 6 ≤ Plane.chiM0 := by
  have h := six_le_chromaticNumber_plane
  rw [chromaticNumber_plane_eq_complex] at h
  exact h.trans hNEASY

end HadwigerNelson.Outside.OAI158

#print axioms HadwigerNelson.Outside.OAI158.chromaticNumber_plane_six_or_seven
#print axioms HadwigerNelson.Outside.OAI158.exists_properColoring_seven
#print axioms HadwigerNelson.Outside.OAI158.chromaticNumber_plane_eq_chiM0
#print axioms HadwigerNelson.Outside.OAI158.six_le_chiM0
