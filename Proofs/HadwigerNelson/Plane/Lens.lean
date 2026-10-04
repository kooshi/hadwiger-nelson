import Proofs.HadwigerNelson.Plane.Basic
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.ContDiff.Defs

/-!
# FS116-S1-EXIT: a curve leaving a two-disc lens, against two unit circles

A lemma on curves and four points (`plans/FS116-S1-proof.md` § 2.4), no colouring. For `30° < b < 90°` and
`−90° < a < −30°` put `y_b = e(b)`, `y_a = e(a)`, `y_3 = e(b + 60°)`, `y_5 = e(a − 60°)` and `Λ = B(y_a, 1) ∩ B(y_b, 1)` (the
lens with a corner at `0`). A curve inside `Λ` just before `t_e`, leaving it at `t_e` at a point other than `0`, with left
unit normal `ν`, which at `t_e` has `γ + ν ∈ B̄(y_3, 1)`, `γ − ν ∈ B̄(y_5, 1)`, `|γ − y_3| ≥ 1` and `|γ − y_5| ≥ 1`, exits
with `γ + ν = y_b` or `γ − ν = y_a`.

Stated at the class its argument reads (`exit_lens`): only the left derivative at `t_e` and `γ ∈ Λ` just before `t_e` are
used; the row's `γ(0) = 0`, `γ(t) ∈ Λ` on all of `(0, t_e)` and `C¹` are idle. The row's form is `exit_lens_row`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- The left unit normal of a nonzero velocity `v`: the unit tangent turned by `+90°`. -/
noncomputable def leftNormal (v : ℂ) : ℂ := I * (v / (‖v‖ : ℂ))

/-- Spec example: the left unit normal of the velocity `2` (heading east) is `i` (north). -/
example : leftNormal 2 = I := by
  simp [leftNormal]

/-- The lens `Λ = B(e(a), 1) ∩ B(e(b), 1)`. -/
def lensΛ (a b : ℝ) : Set ℂ := ball (e a) 1 ∩ ball (e b) 1

/-- **FS116-S1-EXIT** at the class its argument reads: with `30° < b < 90°`, `−90° < a < −30°`, a curve with left derivative
`γ' ≠ 0` at `t_e`, inside `Λ` just before `t_e` and on its frontier at `t_e` other than `0`, whose left unit normal `ν` at
`t_e` meets the four distance conditions, exits with `γ(t_e) + ν = e(b)` or `γ(t_e) − ν = e(a)`. -/
theorem exit_lens {a b : ℝ} (hb₁ : π / 6 < b) (hb₂ : b < π / 2) (ha₁ : -(π / 2) < a) (ha₂ : a < -(π / 6))
    {γ : ℝ → ℂ} {γ' : ℂ} {te : ℝ} (hγ : HasDerivWithinAt γ γ' (Iic te) te) (hγ' : γ' ≠ 0)
    (hin : ∀ᶠ t in 𝓝[<] te, γ t ∈ lensΛ a b) (hexit : γ te ∈ frontier (lensΛ a b)) (hne : γ te ≠ 0)
    (h3 : dist (γ te + leftNormal γ') (e (b + π / 3)) ≤ 1) (h5 : dist (γ te - leftNormal γ') (e (a - π / 3)) ≤ 1)
    (h3' : 1 ≤ dist (γ te) (e (b + π / 3))) (h5' : 1 ≤ dist (γ te) (e (a - π / 3))) :
    γ te + leftNormal γ' = e b ∨ γ te - leftNormal γ' = e a := by
  sorry

/-- **FS116-S1-EXIT**, the row's form: a `C¹` curve on `[0, t_e]` with nonvanishing velocity, `γ(0) = 0`, `γ(t) ∈ Λ` for
`0 < t < t_e` and `γ(t_e) ∈ ∂Λ \ {0}`, meeting the four conditions at `t_e` with its left unit normal, exits with
`γ(t_e) + ν(t_e) = y_b` or `γ(t_e) − ν(t_e) = y_a`. -/
theorem exit_lens_row {a b : ℝ} (hb₁ : π / 6 < b) (hb₂ : b < π / 2) (ha₁ : -(π / 2) < a) (ha₂ : a < -(π / 6))
    {γ : ℝ → ℂ} {te : ℝ} (hte : 0 < te) (hC1 : ContDiffOn ℝ 1 γ (Icc 0 te))
    (hreg : ∀ t ∈ Icc 0 te, derivWithin γ (Icc 0 te) t ≠ 0) (h0 : γ 0 = 0)
    (hin : ∀ t ∈ Ioo 0 te, γ t ∈ lensΛ a b) (hexit : γ te ∈ frontier (lensΛ a b)) (hne : γ te ≠ 0)
    (h3 : dist (γ te + leftNormal (derivWithin γ (Icc 0 te) te)) (e (b + π / 3)) ≤ 1)
    (h5 : dist (γ te - leftNormal (derivWithin γ (Icc 0 te) te)) (e (a - π / 3)) ≤ 1)
    (h3' : 1 ≤ dist (γ te) (e (b + π / 3))) (h5' : 1 ≤ dist (γ te) (e (a - π / 3))) :
    γ te + leftNormal (derivWithin γ (Icc 0 te) te) = e b ∨
      γ te - leftNormal (derivWithin γ (Icc 0 te) te) = e a := by
  sorry

end HadwigerNelson.Plane
