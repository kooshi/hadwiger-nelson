import Proofs.HadwigerNelson.Plane.DensityBound.Bessel
import Mathlib.Analysis.InnerProductSpace.Calculus

/-!
# The ODE comparison lemma for the Bessel system (FS-131, FS131-KDB1; skeleton)

The kernel certifies `J₀` on an interval by any differentiable pair `p = (p₀, p₁)` whose **defect** against the Bessel
system `J₀′ = −J₁`, `J₁′ = J₀ − J₁/x` is small: the error `e = J − p` satisfies `e′ = A(x)e − δ` with
`⟨e, A(x)e⟩ = −e₁²/x ≤ 0` for `x > 0`, so `|e|` grows at most at rate `|δ|` — errors add, they never compound. This is
what lets one chain of polynomial cells run from `x = 0` to `x = 1833` with a final radius of `10⁻¹⁰`
(`data/fs131/kdb1/proto/`). At `a = 0` the hypothesis is only on the open interval, so the singular coefficient `1/x`
is harmless when `p₁(0) = 0`. Plan: `plans/FS131-KDB1-density-bound.md` § 3.
-/

namespace HadwigerNelson.DensityBound

open Real Set

/-- The Bessel system's right-hand side at `x`, applied to `w = w₀ + i w₁`: `(−w₁) + i(w₀ − w₁/x) = i w − i w₁/x`. -/
noncomputable def besselField (x : ℝ) (w : ℂ) : ℂ := Complex.I * w - ((w.im / x : ℝ) : ℂ) * Complex.I

/-- **The comparison lemma.** If `p : ℝ → ℂ` has derivative `q` on `[a, b]` (`0 ≤ a`) and its defect
`‖q x − besselField x (p x)‖` is at most `D` on `(a, b)`, then `‖J(x) − p(x)‖ ≤ ‖J(a) − p(a)‖ + (x − a)D` on `[a, b]`. -/
theorem norm_Jc_sub_le_of_defect {a b D : ℝ} (ha : 0 ≤ a) {p q : ℝ → ℂ}
    (hp : ∀ x ∈ Icc a b, HasDerivAt p (q x) x) (hδ : ∀ x ∈ Ioo a b, ‖q x - besselField x (p x)‖ ≤ D)
    {x : ℝ} (hx : x ∈ Icc a b) :
    ‖Jc x - p x‖ ≤ ‖Jc a - p a‖ + (x - a) * D := by
  sorry

/-- `J` solves its own system: `HasDerivAt Jc (besselField x (Jc x)) x` for `x ≠ 0`. -/
theorem hasDerivAt_Jc {x : ℝ} (hx : x ≠ 0) : HasDerivAt Jc (besselField x (Jc x)) x := by
  sorry

/-- `|J₀ x − w.re| ≤ ‖J(x) − w‖`: a cell's bound on the pair bounds `J₀`. -/
theorem abs_J0_sub_re_le (x : ℝ) (w : ℂ) : |J0 x - w.re| ≤ ‖Jc x - w‖ := by
  sorry

/-- **The tail read off one state**: for `x ≥ a ≥ 0`, `|J₀ x| ≤ ‖w‖ + ‖J(a) − w‖` — `‖J‖` is antitone
(`antitoneOn_norm_Jc`) and the state `w` is within `‖J(a) − w‖` of `J(a)`. -/
theorem abs_J0_le_of_le {a x : ℝ} (ha : 0 ≤ a) (hax : a ≤ x) (w : ℂ) : |J0 x| ≤ ‖w‖ + ‖Jc a - w‖ := by
  sorry

/-- **A model of the comparison lemma's hypotheses** with a nonzero defect: the constant `p = 1` (derivative `0`) on
`[0, 1]` has defect `‖0 − (i·1 − 0)‖ = 1`, so `D = 1`. -/
example : ∀ x ∈ Ioo (0 : ℝ) 1, ‖(0 : ℂ) - besselField x 1‖ ≤ 1 := by
  intro x _
  simp [besselField]

end HadwigerNelson.DensityBound
