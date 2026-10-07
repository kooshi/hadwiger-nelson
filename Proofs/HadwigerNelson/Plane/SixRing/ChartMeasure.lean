import Proofs.HadwigerNelson.Plane.SixRing.Chart
import Proofs.HadwigerNelson.Plane.SixRing.Shift
import Proofs.HadwigerNelson.Outside.OAI158PaletteDensity
import Proofs.HadwigerNelson.Outside.OAI158AngularBoundary

/-!
# Null sets through the chart (FS-132, C132-M-ORBIT steps M2, M5, M7, M8) — SKELETON

The derivation's "`Z` is a diffeomorphism … So null sets and sets of positive measure correspond", in the one
direction the argument uses: **the preimage of a null set is null**. Three maps:

* the chart `(α, d) ↦ chart p α d`, from the plane of parameters to the plane (`chart_quasiMeasurePreserving`);
* a shear `(α, d, d') ↦ (α + f(d, d'), d')` (`shear_quasiMeasurePreserving`) — Tonelli and translation invariance;
* the unit-pair chart `(α, d, d') ↦ (z, the direction from z to its partner)`, as the statement it is used for:
  a weak colouring separates almost every such pair (`unitPair_chart_ae`, the derivation's "Properness and `Φ`
  give").

and the consequence of a label not tipping a hub (`ae_ne_of_not_isTip`, inside M5). For a colouring of the whole
plane; any number of labels. `plans/FS132-kernel-plan.md` stage 5 has the plan per leaf.
-/

open MeasureTheory

namespace HadwigerNelson.SixRing

open Outside.OAI158 Real

/-- **M2, "`Z` is a diffeomorphism … onto an annulus"**, as much as is used: the chart pulls null sets of the plane
back to null sets of the parameter plane. (The release's `circleSum_quasiMeasurePreserving`, `CircleMaps.lean:509`,
after the measure-preserving linear change `(α, d) ↦ (α, α − 2π/3 − d)`.) -/
theorem chart_quasiMeasurePreserving (p : ℂ) :
    Measure.QuasiMeasurePreserving (fun x : ℝ × ℝ => chart p x.1 x.2) volume volume := by
  sorry

/-- A shear of the first coordinate by a measurable function of the other two, followed by forgetting the middle
coordinate, pulls null sets back to null sets. -/
theorem shear_quasiMeasurePreserving {f : ℝ × ℝ → ℝ} (hf : Measurable f) :
    Measure.QuasiMeasurePreserving (fun y : ℝ × ℝ × ℝ => (y.1 + f y.2, y.2.2)) volume volume := by
  sorry

/-- **M5, "for an inner `a ∉ Tip(k)` there is `κ` with `A_a` null in `B(0, 1) ∩ N_k(κ)`"**, in the chart: if the
label `i` does not tip the hub `y_n`, then for some `κ > 0` almost no `(α, d)` with `|α − ψ_{n+1}| < κ` and
`0 < d < κ` has colour `i` at `chart p α d`. Any measurable colouring (weakness is not used). -/
theorem ae_ne_of_not_isTip {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) {p : ℂ} {ψ : ℝ} {n : ℤ} {i : Fin k}
    (h : ¬ IsTip c p (hub p ψ n) i) :
    ∃ κ : ℝ, 0 < κ ∧ ∀ᵐ x : ℝ × ℝ, |x.1 - (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3))| < κ → 0 < x.2 → x.2 < κ →
      c (chart p x.1 x.2) ≠ i := by
  sorry

/-- **M7–M8, "Properness and `Φ` give"**: for a weak colouring of the plane, almost every `(α, d, d')` with
`0 < d, d' < 1/4` has different colours at the two chart points `Z(α, d)` and `Z(α + ε + d' + π/3, d')`,
`ε = shift d d'`, which are at distance `1` (`dist_chart_chart_shift`). Any number of labels. Where the hypothesis
holds: `proper_to_borel_weak_model` (`k = 7`). -/
theorem unitPair_chart_ae {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ) :
    ∀ᵐ y : ℝ × ℝ × ℝ, 0 < y.2.1 → y.2.1 < 1 / 4 → 0 < y.2.2 → y.2.2 < 1 / 4 →
      c (chart p y.1 y.2.1) ≠ c (chart p (y.1 + shift y.2.1 y.2.2 + y.2.2 + π / 3) y.2.2) := by
  sorry

end HadwigerNelson.SixRing
