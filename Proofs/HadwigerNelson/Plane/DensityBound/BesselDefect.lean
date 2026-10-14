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

/-- `J` solves its own system at `x ≠ 0` (used by the comparison lemma; `hasDerivAt_Jc` restates it). -/
private theorem hasDerivAt_Jc_aux {x : ℝ} (hx : x ≠ 0) : HasDerivAt Jc (besselField x (Jc x)) x := by
  have h := ((hasDerivAt_J0 x).ofReal_comp).add (((hasDerivAt_J1 hx).ofReal_comp).mul_const Complex.I)
  have e1 : Jc = fun y => ((J0 y : ℝ) : ℂ) + ((J1 y : ℝ) : ℂ) * Complex.I := by
    funext y; exact Complex.mk_eq_add_mul_I _ _
  have e2 : besselField x (Jc x) = ((-J1 x : ℝ) : ℂ) + ((J0 x - J1 x / x : ℝ) : ℂ) * Complex.I := by
    apply Complex.ext <;> simp [besselField, Jc]
  rw [e2, e1]
  exact h

/-- **The comparison lemma.** If `p : ℝ → ℂ` has derivative `q` on `[a, b]` (`0 ≤ a`) and its defect
`‖q x − besselField x (p x)‖` is at most `D` on `(a, b)`, then `‖J(x) − p(x)‖ ≤ ‖J(a) − p(a)‖ + (x − a)D` on `[a, b]`. -/
theorem norm_Jc_sub_le_of_defect {a b D : ℝ} (ha : 0 ≤ a) {p q : ℝ → ℂ}
    (hp : ∀ x ∈ Icc a b, HasDerivAt p (q x) x) (hδ : ∀ x ∈ Ioo a b, ‖q x - besselField x (p x)‖ ≤ D)
    {x : ℝ} (hx : x ∈ Icc a b) :
    ‖Jc x - p x‖ ≤ ‖Jc a - p a‖ + (x - a) * D := by
  rcases eq_or_lt_of_le (hx.1.trans hx.2) with hab | hab
  · have hxa : x = a := le_antisymm (hab ▸ hx.2) hx.1
    subst hxa
    simp
  have hD : 0 ≤ D := (norm_nonneg _).trans (hδ ((a + b) / 2) ⟨by linarith, by linarith⟩)
  have hJc : Continuous Jc := by
    have e : Jc = fun y => ((J0 y : ℝ) : ℂ) + ((J1 y : ℝ) : ℂ) * Complex.I := by
      funext y; exact Complex.mk_eq_add_mul_I _ _
    rw [e]
    exact (Complex.continuous_ofReal.comp continuous_J0).add
      ((Complex.continuous_ofReal.comp continuous_J1).mul continuous_const)
  have hpc : ContinuousOn p (Icc a b) := fun y hy => (hp y hy).continuousAt.continuousWithinAt
  -- the error `e = Jc − p` and its derivative on `(a, b)`
  have hde : ∀ y ∈ Ioo a b, HasDerivAt (fun y => Jc y - p y)
      (besselField y (Jc y - p y) - (q y - besselField y (p y))) y := by
    intro y hy
    have hy0 : y ≠ 0 := (ha.trans_lt hy.1).ne'
    refine ((hasDerivAt_Jc_aux hy0).sub (hp y (Ioo_subset_Icc_self hy))).congr_deriv ?_
    simp only [besselField, Complex.sub_im, Complex.ofReal_sub, Complex.ofReal_div]
    ring
  -- the contraction: `⟪w, F(y, w)⟫ = −w₁²/y ≤ 0`
  have hinner : ∀ y > 0, ∀ w : ℂ, inner ℝ w (besselField y w) ≤ 0 := by
    intro y hy w
    have e : inner ℝ w (besselField y w) = -(w.im ^ 2 / y) := by
      simp [Complex.inner, besselField]
      field_simp
      ring
    rw [e]
    have : 0 ≤ w.im ^ 2 / y := div_nonneg (sq_nonneg _) hy.le
    linarith
  have key : ∀ κ > 0, ‖Jc x - p x‖ ≤ ‖Jc a - p a‖ + (x - a) * D + κ := by
    intro κ hκ
    set f : ℝ → ℝ := fun y => √(‖Jc y - p y‖ ^ 2 + κ ^ 2) with hf
    have hpos : ∀ y, 0 < ‖Jc y - p y‖ ^ 2 + κ ^ 2 := fun y => by positivity
    have hfc : ContinuousOn f (Icc a b) :=
      (((hJc.continuousOn.sub hpc).norm.pow 2).add continuousOn_const).sqrt
    have hfd : ∀ y ∈ Ioo a b, HasDerivAt f
        (2 * inner ℝ (Jc y - p y) (besselField y (Jc y - p y) - (q y - besselField y (p y))) /
          (2 * f y)) y := by
      intro y hy
      exact (((hde y hy).norm_sq).add_const (κ ^ 2)).sqrt (hpos y).ne'
    have hfle : ∀ y ∈ interior (Icc a b), deriv f y ≤ D := by
      intro y hy
      rw [interior_Icc] at hy
      rw [(hfd y hy).deriv]
      have hy0 : 0 < y := ha.trans_lt hy.1
      have hfy : 0 < f y := Real.sqrt_pos.2 (hpos y)
      have hn : ‖Jc y - p y‖ ≤ f y := by
        rw [hf]; exact Real.le_sqrt_of_sq_le (by nlinarith [sq_nonneg κ])
      have h1 : inner ℝ (Jc y - p y) (besselField y (Jc y - p y) - (q y - besselField y (p y))) ≤
          ‖Jc y - p y‖ * D := by
        rw [inner_sub_right]
        have h2 := hinner y hy0 (Jc y - p y)
        have h3 := real_inner_le_norm (Jc y - p y) (-(q y - besselField y (p y)))
        rw [inner_neg_right, norm_neg] at h3
        have h4 : ‖Jc y - p y‖ * ‖q y - besselField y (p y)‖ ≤ ‖Jc y - p y‖ * D :=
          mul_le_mul_of_nonneg_left (hδ y hy) (norm_nonneg _)
        linarith
      rw [div_le_iff₀ (by positivity)]
      nlinarith
    have hmvt := (convex_Icc a b).image_sub_le_mul_sub_of_deriv_le hfc
      (fun y hy => (hfd y (by rwa [interior_Icc] at hy)).differentiableAt.differentiableWithinAt) hfle
      a ⟨le_rfl, hab.le⟩ x hx hx.1
    have hfx : ‖Jc x - p x‖ ≤ f x := by
      rw [hf]; exact Real.le_sqrt_of_sq_le (by nlinarith [sq_nonneg κ])
    have hfa : f a ≤ ‖Jc a - p a‖ + κ := by
      rw [hf, Real.sqrt_le_left (by positivity)]
      nlinarith [norm_nonneg (Jc a - p a)]
    nlinarith
  exact le_of_forall_pos_le_add fun κ hκ => by simpa [add_assoc] using key κ hκ

/-- `J` solves its own system: `HasDerivAt Jc (besselField x (Jc x)) x` for `x ≠ 0`. -/
theorem hasDerivAt_Jc {x : ℝ} (hx : x ≠ 0) : HasDerivAt Jc (besselField x (Jc x)) x := by
  exact hasDerivAt_Jc_aux hx

/-- `|J₀ x − w.re| ≤ ‖J(x) − w‖`: a cell's bound on the pair bounds `J₀`. -/
theorem abs_J0_sub_re_le (x : ℝ) (w : ℂ) : |J0 x - w.re| ≤ ‖Jc x - w‖ := by
  simpa [Jc] using Complex.abs_re_le_norm (Jc x - w)

/-- **The tail read off one state**: for `x ≥ a ≥ 0`, `|J₀ x| ≤ ‖w‖ + ‖J(a) − w‖` — `‖J‖` is antitone
(`antitoneOn_norm_Jc`) and the state `w` is within `‖J(a) − w‖` of `J(a)`. -/
theorem abs_J0_le_of_le {a x : ℝ} (ha : 0 ≤ a) (hax : a ≤ x) (w : ℂ) : |J0 x| ≤ ‖w‖ + ‖Jc a - w‖ := by
  have h1 : |J0 x| ≤ ‖Jc x‖ := by simpa [Jc] using Complex.abs_re_le_norm (Jc x)
  have h2 : ‖Jc x‖ ≤ ‖Jc a‖ := antitoneOn_norm_Jc ha (ha.trans hax) hax
  have h3 : ‖Jc a‖ ≤ ‖w‖ + ‖Jc a - w‖ := by
    calc ‖Jc a‖ = ‖w + (Jc a - w)‖ := by rw [add_sub_cancel]
      _ ≤ ‖w‖ + ‖Jc a - w‖ := norm_add_le _ _
  linarith

/-- **A model of the comparison lemma's hypotheses** with a nonzero defect: the constant `p = 1` (derivative `0`) on
`[0, 1]` has defect `‖0 − (i·1 − 0)‖ = 1`, so `D = 1`. -/
example : ∀ x ∈ Ioo (0 : ℝ) 1, ‖(0 : ℂ) - besselField x 1‖ ≤ 1 := by
  intro x _
  simp [besselField]

end HadwigerNelson.DensityBound
