import Proofs.HadwigerNelson.Plane.SixRing.Basic
import Proofs.HadwigerNelson.Plane.Chord

/-!
# The unit-pair relation between two adjacent hubs: the shift (FS-132, C132-M-ORBIT step M7) — SKELETON

Calculus on one explicit function. `shift d d' = arccos((r² + r'² − 1)/(2 r r')) − π/3 − (d + d')/2`, with
`r = ringRadius d = 2 cos(π/3 + d/2)`, is the derivation's `ε(d, d')`: the chart points `chart p α d` (near one hub)
and `chart p (α + ε + d' + π/3) d'` (near the next) are at distance `1`. No colouring and no measure, except
`measurable_shift`.

The leaves, and `exists_shiftBounds` proved from them: the constants of the derivation's display
"`0 < ε ≤ min(d, d')/16` and `|∇ε| ≤ 1/32`" on a square `(0, κ₁)²`. The bound by `min(d, d')/16` needs no expansion:
`ε` vanishes on both axes and is `1/32`-Lipschitz in each variable on the closed square. Positivity is the library's
`Plane.twoCirc_identity` (FS129-SR1-TWOCIRC, the straddle identity of row 148) at zero shift.
`plans/FS132-kernel-plan.md` stage 5 has the plan per leaf.
-/

namespace HadwigerNelson.SixRing

open Real

/-- On `[0, 1/4]` the radius `r(d) = 2 cos(π/3 + d/2)` lies in `(1/2, 1]`: the triangle with sides `r(d)`, `r(d')`,
`1` is non-degenerate. -/
theorem ringRadius_mem {d : ℝ} (h0 : 0 ≤ d) (h1 : d ≤ 1 / 4) : 1 / 2 < ringRadius d ∧ ringRadius d ≤ 1 := by
  sorry

/-- The shift is symmetric. -/
theorem shift_comm (d d' : ℝ) : shift d d' = shift d' d := by
  sorry

/-- **M7, "for `d′ = 0` … `ε(d, 0) = 0`"**: the shift vanishes on the first axis. -/
theorem shift_zero_right {d : ℝ} (h0 : 0 ≤ d) (h1 : d ≤ 1 / 4) : shift d 0 = 0 := by
  sorry

/-- **M7, "for `d = 0` … `ε(0, d′) = 0`"**: the shift vanishes on the second axis. -/
theorem shift_zero_left {d' : ℝ} (h0 : 0 ≤ d') (h1 : d' ≤ 1 / 4) : shift 0 d' = 0 := by
  rw [shift_comm]; exact shift_zero_right h0 h1

/-- **M7, the unit-pair relation**: "`|z − z′| = 1` holds on `α′ = α + π/3 + d′ + ε(d, d′)`, independent of `α`". For
`0 ≤ d, d' ≤ 1/4` the chart points `Z(α, d)` and `Z(α + ε + d' + π/3, d')` are at distance `1`. -/
theorem dist_chart_chart_shift (p : ℂ) (α : ℝ) {d d' : ℝ} (hd : 0 ≤ d) (hd1 : d ≤ 1 / 4) (hd' : 0 ≤ d')
    (hd1' : d' ≤ 1 / 4) : dist (chart p α d) (chart p (α + shift d d' + d' + π / 3) d') = 1 := by
  sorry

/-- **M7, the sign**: "`0 < ε(d, d′)`" for `0 < d, d' ≤ 1/4`. At zero shift the two chart points are nearer than `1`
(`Plane.twoCirc_identity`: the squared distance is `1 − 8 sin(d/2) sin(d'/2) cos((d + d')/2)`), and the squared
distance increases with the shift. -/
theorem shift_pos {d d' : ℝ} (hd : 0 < d) (hd1 : d ≤ 1 / 4) (hd' : 0 < d') (hd1' : d' ≤ 1 / 4) :
    0 < shift d d' := by
  sorry

/-- **M7, "`|∇ε| ≤ 1/32`"**, in the first variable, on a closed square `[0, κ]²` with `κ ≤ 1/4`: the shift is
continuously differentiable near the origin and its gradient vanishes there. -/
theorem exists_shift_lipschitz : ∃ κ : ℝ, 0 < κ ∧ κ ≤ 1 / 4 ∧
    ∀ d₁ d₂ d' : ℝ, 0 ≤ d₁ → d₁ ≤ κ → 0 ≤ d₂ → d₂ ≤ κ → 0 ≤ d' → d' ≤ κ →
      |shift d₁ d' - shift d₂ d'| ≤ |d₁ - d₂| / 32 := by
  sorry

/-- The shift is a measurable function of the pair (it is a composition of measurable functions; no continuity is
claimed where a radius vanishes). -/
theorem measurable_shift : Measurable fun x : ℝ × ℝ => shift x.1 x.2 := by
  sorry

/-- **M7's display**: there is `κ₁ ∈ (0, 1/4]` with `0 < ε(d, d') ≤ min(d, d')/16` and `ε` `1/32`-Lipschitz in each
variable, for `0 < d, d' < κ₁`. From the leaves above. -/
theorem exists_shiftBounds : ∃ κ : ℝ, 0 < κ ∧ κ ≤ 1 / 4 ∧ ShiftBounds shift κ := by
  obtain ⟨κ, hκ, hκ4, hlip⟩ := exists_shift_lipschitz
  have hlip' : ∀ d d'₁ d'₂ : ℝ, 0 ≤ d → d ≤ κ → 0 ≤ d'₁ → d'₁ ≤ κ → 0 ≤ d'₂ → d'₂ ≤ κ →
      |shift d d'₁ - shift d d'₂| ≤ |d'₁ - d'₂| / 32 := fun d d'₁ d'₂ h1 h2 h3 h4 h5 h6 => by
    rw [shift_comm d d'₁, shift_comm d d'₂]
    exact hlip d'₁ d'₂ d h3 h4 h5 h6 h1 h2
  refine ⟨κ, hκ, hκ4, ⟨?_, ?_, ?_, ?_, ?_⟩⟩
  · intro d d' h1 h2 h3 h4
    exact shift_pos h1 (h2.le.trans hκ4) h3 (h4.le.trans hκ4)
  · intro d d' h1 h2 h3 h4
    have h := hlip d 0 d' h1.le h2.le le_rfl hκ.le h3.le h4.le
    rw [shift_zero_left h3.le (h4.le.trans hκ4), sub_zero, sub_zero, abs_of_pos h1] at h
    have := le_abs_self (shift d d')
    linarith
  · intro d d' h1 h2 h3 h4
    have h := hlip' d d' 0 h1.le h2.le h3.le h4.le le_rfl hκ.le
    rw [shift_zero_right h1.le (h2.le.trans hκ4), sub_zero, sub_zero, abs_of_pos h3] at h
    have := le_abs_self (shift d d')
    linarith
  · intro d₁ d₂ d' h1 h2 h3 h4 h5 h6
    exact hlip d₁ d₂ d' h1.le h2.le h3.le h4.le h5.le h6.le
  · intro d d'₁ d'₂ h1 h2 h3 h4 h5 h6
    exact hlip' d d'₁ d'₂ h1.le h2.le h3.le h4.le h5.le h6.le

end HadwigerNelson.SixRing
