import Proofs.HadwigerNelson.Plane.SixRing.ChartMeasure
import Proofs.HadwigerNelson.Plane.SixRing.StepLemma

/-!
# No label tips two adjacent hubs: the analytic core (FS-132, C132-M-ORBIT steps M8, M9) — SKELETON

`chart_step_false` is the derivation's V6-HUG restated ("no label is the tip at two adjacent hubs"), with no
palette in its statement: a weak colouring `c` of **the whole plane** (any number of labels), a measurable set `S`
of angles that changes at `t`, and the two statements `HubColours` at the hub charted about `t` and — with the
state flipped — at the next hub, charted about `t + π/3`. These cannot all hold.

It is proved here from `exists_shiftBounds` (M7), `no_double_change` (M8: the derivation's (†)), `step_lemma`
(Lemma S), `step_at_of_change`, and `step_kill` (M9). `plans/FS132-kernel-plan.md` stage 5 has the plan per leaf.
-/

open MeasureTheory Set

namespace HadwigerNelson.SixRing

open Outside.OAI158 Real

variable {k : ℕ} {c : ℂ → Fin k}

/-- **M8, (†)** ("Almost every point of `W_0(κ_1)` and of `W_1(κ_1)` carries `a`. Properness and `Φ` give: for
almost every `(α, d, d′)` … not both `s(α − d) ≠ s(α)` and `s(α + ε) ≠ s(α + ε + d′)`"): on the box of size `κ'`
with `3κ' ≤ κ`, `κ' ≤ 1/4`. Where a pair is split by `S`, `HubColours` leaves the one label `b`; the two chart
points are a unit pair, and `unitPair_chart_ae` separates almost every one. -/
theorem no_double_change (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ) {b X Y : Fin k} {S : Set ℝ}
    {t κ κ' : ℝ} (hκ' : 0 < κ') (h3 : 3 * κ' ≤ κ) (h4 : κ' ≤ 1 / 4) (hb : ShiftBounds shift κ')
    (h0 : HubColours c p b X Y S t κ)
    (h1 : HubColours c p b X Y {θ : ℝ | θ - π / 3 ∉ S} (t + π / 3) κ) : NoDoubleChange shift S t κ' := by
  sorry

/-- **M9, the kill** (steps (a)–(d)): if `S` is a half-line with end `t` on the interval of radius `κ'/4` about `t`
— a clean step of the state at `t` — then the two regions flanking the hubs just inside the ring carry one outside
label almost everywhere, and they hold a set of unit pairs of positive measure. A step inside a proof by
contradiction: the hypotheses are jointly unsatisfiable, and this theorem is what says so. -/
theorem step_kill (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ) {b X Y : Fin k} {S : Set ℝ}
    (hS : MeasurableSet S) {t κ κ' : ℝ} (hκ' : 0 < κ') (h3 : 3 * κ' ≤ κ) (h4 : κ' ≤ 1 / 4)
    (hb : ShiftBounds shift κ') (h0 : HubColours c p b X Y S t κ)
    (h1 : HubColours c p b X Y {θ : ℝ | θ - π / 3 ∉ S} (t + π / 3) κ)
    (hstep : (∀ᵐ θ : ℝ, |θ - t| < κ' / 4 → (θ ∈ S ↔ θ < t)) ∨
      (∀ᵐ θ : ℝ, |θ - t| < κ' / 4 → (θ ∈ S ↔ t < θ))) : False := by
  sorry

/-- **No label tips two adjacent hubs, in the chart** (the derivation's V6-HUG restated; steps M7–M9 together): for
a weak colouring of the plane with any number of labels, a measurable set `S` of angles every neighbourhood of `t`
meets, with its complement, in positive measure, and labels `b`, `X`, `Y`, the statements `HubColours` at `t` for
`S` and at `t + π/3` for the flipped set cannot both hold.

A refutation. Its hypotheses other than weakness are met by no colouring this library holds; whether a weak
colouring exists at six labels is the open question, and at `k = 7` (`proper_to_borel_weak_model`) the statement
says that the hexagonal colouring has no such pair of hubs. -/
theorem chart_step_false (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ) {b X Y : Fin k} {S : Set ℝ}
    (hS : MeasurableSet S) {t κ : ℝ} (hκ : 0 < κ)
    (hchange : ∀ η : ℝ, 0 < η → 0 < volume (S ∩ Ioo (t - η) (t + η)) ∧ 0 < volume (Sᶜ ∩ Ioo (t - η) (t + η)))
    (h0 : HubColours c p b X Y S t κ)
    (h1 : HubColours c p b X Y {θ : ℝ | θ - π / 3 ∉ S} (t + π / 3) κ) : False := by
  obtain ⟨κ₁, hκ₁, hκ₁4, hb⟩ := exists_shiftBounds
  have hκ'pos : 0 < min (κ / 3) κ₁ := lt_min (by positivity) hκ₁
  have h3 : 3 * min (κ / 3) κ₁ ≤ κ := by
    have := min_le_left (κ / 3) κ₁
    linarith
  have h4 : min (κ / 3) κ₁ ≤ 1 / 4 := (min_le_right _ _).trans hκ₁4
  have hb' : ShiftBounds shift (min (κ / 3) κ₁) := hb.mono (min_le_right _ _)
  have hdc := no_double_change hc hw p hκ'pos h3 h4 hb' h0 h1
  obtain ⟨t', ht'⟩ := step_lemma hκ'pos hb' hS hdc
  have ht : t' = t := step_at_of_change (by positivity) hchange ht'
  rw [ht] at ht'
  exact step_kill hc hw p hS hκ'pos h3 h4 hb' h0 h1 ht'

end HadwigerNelson.SixRing
