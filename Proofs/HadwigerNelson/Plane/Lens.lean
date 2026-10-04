import Proofs.HadwigerNelson.Plane.Chord
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Slope
import Mathlib.Analysis.Calculus.ContDiff.Defs
import Mathlib.Analysis.InnerProductSpace.Calculus

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

/-! ## The algebra of the exit, in the frame of `e b` -/

/-- Step A of EXIT's core: a unit vector `d` (the exit point relative to `e b`, in the frame of `e b`) lying in the lens (so
within `1` of the other centre, `n' = (1 − C, S)`) lies strictly left of the direction `e(120°)`. -/
theorem lens_stepA {C S r3 d1 d2 : ℝ} (hr3 : r3 ^ 2 = 3) (hr3p : 0 < r3) (hC : C < 1 / 2) (hS : 0 < S)
    (hCS : C ^ 2 + S ^ 2 = 1) (hd : d1 ^ 2 + d2 ^ 2 = 1) (hF : (d1 + 1 - C) ^ 2 + (d2 + S) ^ 2 ≤ 1) :
    d2 + r3 * d1 < 0 := by
  obtain ⟨u1, hu1⟩ : ∃ u1, u1 = 1 - C := ⟨_, rfl⟩
  obtain ⟨u2, hu2⟩ : ∃ u2, u2 = S := ⟨_, rfl⟩
  have hu1p : 0 < u1 := by rw [hu1]; linarith
  have hu2p : 0 < u2 := by rw [hu2]; exact hS
  have huu : u1 ^ 2 + u2 ^ 2 = 2 * u1 := by rw [hu1, hu2]; nlinarith only [hCS]
  have hlin : d1 * u1 + d2 * u2 + u1 ≤ 0 := by
    have : (d1 + u1) ^ 2 + (d2 + u2) ^ 2 ≤ 1 := by rw [hu1, hu2]; convert hF using 3; ring
    nlinarith only [this, hd, huu]
  by_contra hcon
  have hcon' : 0 ≤ d2 + r3 * d1 := not_lt.mp hcon
  have hQ1 : (-u1 + r3 * u2) / 2 < u1 := by
    have : u2 < r3 * u1 := by
      have h1 : u2 ^ 2 < (r3 * u1) ^ 2 := by
        have h3 : (r3 * u1) ^ 2 = 3 * u1 ^ 2 := by rw [mul_pow, hr3]
        rw [h3, hu1, hu2]; nlinarith only [hCS, hC]
      exact lt_of_pow_lt_pow_left₀ 2 (by positivity) h1
    have h4 := mul_lt_mul_of_pos_left this hr3p
    have h5 : r3 * (r3 * u1) = 3 * u1 := by rw [← mul_assoc, ← sq, hr3]
    linarith only [h4, h5]
  have hQ2 : -u1 < (-u1 + r3 * u2) / 2 := by nlinarith only [mul_pos hr3p hu2p, hu1p]
  have hab : ((r3 * d1 + d2) / 2) ^ 2 + ((-d1 + r3 * d2) / 2) ^ 2 = 1 := by
    have : ((r3 * d1 + d2) / 2) ^ 2 + ((-d1 + r3 * d2) / 2) ^ 2 = (r3 ^ 2 + 1) / 4 * (d1 ^ 2 + d2 ^ 2) := by ring
    rw [this, hr3, hd]; norm_num
  have ha0 : 0 ≤ (r3 * d1 + d2) / 2 := by linarith only [hcon']
  have hP0 : 0 < (r3 * u1 + u2) / 2 := by positivity
  have hdu : d1 * u1 + d2 * u2 = (r3 * d1 + d2) / 2 * ((r3 * u1 + u2) / 2)
      + (-d1 + r3 * d2) / 2 * ((-u1 + r3 * u2) / 2) := by
    have : (r3 * d1 + d2) / 2 * ((r3 * u1 + u2) / 2) + (-d1 + r3 * d2) / 2 * ((-u1 + r3 * u2) / 2)
        = (r3 ^ 2 + 1) / 4 * (d1 * u1 + d2 * u2) := by ring
    rw [this, hr3]; ring
  have hb1 : |(-d1 + r3 * d2) / 2| ≤ 1 := by
    rw [← sq_le_one_iff_abs_le_one]; nlinarith only [sq_nonneg ((r3 * d1 + d2) / 2), hab]
  have hbQ : -u1 < (-d1 + r3 * d2) / 2 * ((-u1 + r3 * u2) / 2) := by
    have hQabs : |(-u1 + r3 * u2) / 2| < u1 := abs_lt.mpr ⟨hQ2, hQ1⟩
    have : |(-d1 + r3 * d2) / 2 * ((-u1 + r3 * u2) / 2)| < u1 := by
      rw [abs_mul]
      calc |(-d1 + r3 * d2) / 2| * |(-u1 + r3 * u2) / 2| ≤ 1 * |(-u1 + r3 * u2) / 2| := by gcongr
        _ < u1 := by rw [one_mul]; exact hQabs
    exact (abs_lt.mp this).1
  linarith only [mul_nonneg ha0 hP0.le, hdu, hbQ, hlin]

/-- Step B of EXIT's core: with `d` strictly left of `e(120°)`, a unit `n` turned counter-clockwise from `d` (by at most
`180°`) with `d + n` within `1` of `e(120°)` is `−d`. -/
theorem lens_stepB {r3 d1 d2 n1 n2 : ℝ} (hr3 : r3 ^ 2 = 3) (hd : d1 ^ 2 + d2 ^ 2 = 1) (hn : n1 ^ 2 + n2 ^ 2 = 1)
    (hA : d2 + r3 * d1 < 0) (hcr : 0 ≤ d1 * n2 - d2 * n1)
    (hP : (d1 + n1 + 1 / 2) ^ 2 + (d2 + n2 - r3 / 2) ^ 2 ≤ 1) : n1 = -d1 ∧ n2 = -d2 := by
  have hE : 1 - (-d1 + r3 * d2) / 2 + (d1 * n1 + d2 * n2) - (-n1 + r3 * n2) / 2 ≤ 0 := by
    nlinarith only [hd, hn, hr3, hP]
  have hid : 1 - (-d1 + r3 * d2) / 2 + (d1 * n1 + d2 * n2) - (-n1 + r3 * n2) / 2
      = (1 + (d1 * n1 + d2 * n2)) * (1 - (-d1 + r3 * d2) / 2) + ((-d2 - r3 * d1) / 2) * (d1 * n2 - d2 * n1) := by
    linear_combination ((-n1 + r3 * n2) / 2) * hd
  have hσ : 0 < (-d2 - r3 * d1) / 2 := by linarith only [hA]
  have hsq : ((-d1 + r3 * d2) / 2) ^ 2 + ((-d2 - r3 * d1) / 2) ^ 2 = 1 := by
    have : ((-d1 + r3 * d2) / 2) ^ 2 + ((-d2 - r3 * d1) / 2) ^ 2 = (1 + r3 ^ 2) / 4 * (d1 ^ 2 + d2 ^ 2) := by ring
    rw [this, hr3, hd]; norm_num
  have hdm : 0 < 1 - (-d1 + r3 * d2) / 2 := by
    by_contra hcon
    have h1 : 1 ≤ (-d1 + r3 * d2) / 2 := by linarith only [not_lt.mp hcon]
    have h2 : (1 : ℝ) * 1 ≤ (-d1 + r3 * d2) / 2 * ((-d1 + r3 * d2) / 2) :=
      mul_le_mul h1 h1 zero_le_one (by linarith only [h1])
    have h3 := mul_pos hσ hσ
    nlinarith only [h2, h3, hsq]
  have hdn : 0 ≤ 1 + (d1 * n1 + d2 * n2) := by
    nlinarith only [sq_nonneg (d1 + n1), sq_nonneg (d2 + n2), hd, hn]
  have hprod : (1 + (d1 * n1 + d2 * n2)) * (1 - (-d1 + r3 * d2) / 2) ≤ 0 := by
    have := mul_nonneg hσ.le hcr
    linarith only [hid, hE, this]
  have hzero : 1 + (d1 * n1 + d2 * n2) ≤ 0 := by
    by_contra hcon
    exact absurd hprod (not_le.mpr (mul_pos (not_le.mp hcon) hdm))
  have hsum : (d1 + n1) ^ 2 + (d2 + n2) ^ 2 = 0 := by nlinarith only [hd, hn, hzero, hdn]
  have h1 : d1 + n1 = 0 := by nlinarith only [sq_nonneg (d1 + n1), sq_nonneg (d2 + n2), hsum]
  have h2 : d2 + n2 = 0 := by nlinarith only [sq_nonneg (d1 + n1), sq_nonneg (d2 + n2), hsum]
  exact ⟨by linarith only [h1], by linarith only [h2]⟩

/-- **The core of EXIT, one circle.** At a point `x` of `ω(e b)` inside `B̄(e a, 1)` (`30° < b < 90°`, `−90° < a < −30°`), a unit
vector `ν` turned counter-clockwise from `x − e b` (by at most `180°`) whose tip `x + ν` lies within `1` of `e(b + 60°)` is
`e b − x`. -/
theorem lens_core {a b : ℝ} (hb₁ : π / 6 < b) (hb₂ : b < π / 2) (ha₁ : -(π / 2) < a) (ha₂ : a < -(π / 6))
    {x ν : ℂ} (hν : ‖ν‖ = 1) (hxb : ‖x - e b‖ = 1) (hxa : ‖x - e a‖ ≤ 1)
    (hcr : 0 ≤ (ν * (starRingEnd ℂ) (x - e b)).im) (hP : ‖x + ν - e (b + π / 3)‖ ≤ 1) : x + ν = e b := by
  have hE0 : e b ≠ 0 := fun h => by simpa [h] using norm_e b
  set δ : ℂ := (x - e b) / e b with hδ
  set ν' : ℂ := ν / e b with hν'
  have hxδ : x - e b = e b * δ := by rw [hδ]; field_simp
  have hνν : ν = e b * ν' := by rw [hν']; field_simp
  have hδ1 : δ.re ^ 2 + δ.im ^ 2 = 1 := by
    rw [← sq_norm_eq, hδ, norm_div, norm_e, div_one, hxb]; norm_num
  have hn1 : ν'.re ^ 2 + ν'.im ^ 2 = 1 := by
    rw [← sq_norm_eq, hν', norm_div, norm_e, div_one, hν]; norm_num
  have hea : e a = e b * e (a - b) := by
    rw [← e_add]; congr 1; ring
  have hxa' : x - e a = e b * (δ + 1 - e (a - b)) := by
    rw [hea]; linear_combination hxδ
  have hF : (δ.re + 1 - Real.cos (b - a)) ^ 2 + (δ.im + Real.sin (b - a)) ^ 2 ≤ 1 := by
    have h1 : ‖δ + 1 - e (a - b)‖ ≤ 1 := by
      have := hxa; rw [hxa', norm_mul, norm_e, one_mul] at this; exact this
    have h2 : ‖δ + 1 - e (a - b)‖ ^ 2 ≤ 1 := by nlinarith only [h1, norm_nonneg (δ + 1 - e (a - b))]
    rw [sq_norm_eq] at h2
    simp only [Complex.sub_re, Complex.add_re, Complex.one_re, Complex.sub_im, Complex.add_im, Complex.one_im,
      re_e, im_e] at h2
    have hc : Real.cos (a - b) = Real.cos (b - a) := by rw [← Real.cos_neg]; congr 1; ring
    have hs : Real.sin (a - b) = -Real.sin (b - a) := by rw [← Real.sin_neg]; congr 1; ring
    rw [hc, hs] at h2
    convert h2 using 2; ring
  have hr3 : (√3) ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hr3p : 0 < √3 := by positivity
  have hP' : (δ.re + ν'.re + 1 / 2) ^ 2 + (δ.im + ν'.im - √3 / 2) ^ 2 ≤ 1 := by
    have heb : e (b + π / 3) = e b * e (π / 3) := e_add _ _
    have hx' : x + ν - e (b + π / 3) = e b * (δ + ν' + 1 - e (π / 3)) := by
      rw [heb]; linear_combination hxδ + hνν
    have h1 : ‖δ + ν' + 1 - e (π / 3)‖ ≤ 1 := by
      have := hP; rw [hx', norm_mul, norm_e, one_mul] at this; exact this
    have h2 : ‖δ + ν' + 1 - e (π / 3)‖ ^ 2 ≤ 1 := by nlinarith only [h1, norm_nonneg (δ + ν' + 1 - e (π / 3))]
    rw [sq_norm_eq] at h2
    simp only [Complex.sub_re, Complex.add_re, Complex.one_re, Complex.sub_im, Complex.add_im, Complex.one_im,
      re_e, im_e, Real.cos_pi_div_three, Real.sin_pi_div_three] at h2
    convert h2 using 2 <;> ring
  have hcr' : 0 ≤ δ.re * ν'.im - δ.im * ν'.re := by
    have : ν * (starRingEnd ℂ) (x - e b) = ν' * (starRingEnd ℂ) δ := by
      rw [hxδ, hνν, map_mul]
      calc e b * ν' * ((starRingEnd ℂ) (e b) * (starRingEnd ℂ) δ)
          = (e b * (starRingEnd ℂ) (e b)) * (ν' * (starRingEnd ℂ) δ) := by ring
        _ = ν' * (starRingEnd ℂ) δ := by rw [e_mul_conj_e, one_mul]
    rw [this] at hcr
    simp only [Complex.mul_im, Complex.conj_re, Complex.conj_im] at hcr
    linarith only [hcr]
  have hba : Real.cos (b - a) < 1 / 2 := by
    rw [← Real.cos_pi_div_three]
    exact Real.cos_lt_cos_of_nonneg_of_le_pi (by positivity) (by linarith [Real.pi_pos]) (by linarith)
  have hbaS : 0 < Real.sin (b - a) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
  have hA := lens_stepA hr3 hr3p hba hbaS (Real.cos_sq_add_sin_sq _) hδ1 hF
  obtain ⟨h1, h2⟩ := lens_stepB hr3 hδ1 hn1 hA hcr' hP'
  have hsum : δ + ν' = 0 := Complex.ext (by simp; linarith) (by simp; linarith)
  have : x + ν = e b + e b * (δ + ν') := by linear_combination hxδ + hνν
  rw [this, hsum]; ring

/-- A real function with a left derivative `g'` at `te` and `g t ≤ g te` just before `te` has `0 ≤ g'`. -/
theorem deriv_nonneg_of_leftmax {g : ℝ → ℝ} {g' te : ℝ} (h : HasDerivWithinAt g g' (Iic te) te)
    (hle : ∀ᶠ t in 𝓝[<] te, g t ≤ g te) : 0 ≤ g' := by
  rw [hasDerivWithinAt_iff_tendsto_slope, Iic_sdiff_right] at h
  refine ge_of_tendsto h ?_
  filter_upwards [hle, self_mem_nhdsWithin] with t ht (ht' : t < te)
  rw [slope_def_field]
  exact div_nonneg_of_nonpos (by linarith) (by linarith)

/-- A curve inside `B(c, 1)` just before `te` and on `ω(c)` at `te` leaves outward: `0 ≤ Re (conj (γ te − c) γ')`. -/
theorem re_conj_mul_nonneg_of_exit {γ : ℝ → ℂ} {γ' c : ℂ} {te : ℝ} (hγ : HasDerivWithinAt γ γ' (Iic te) te)
    (hin : ∀ᶠ t in 𝓝[<] te, ‖γ t - c‖ < 1) (hxc : ‖γ te - c‖ = 1) :
    0 ≤ ((starRingEnd ℂ) (γ te - c) * γ').re := by
  have h1 := (hγ.sub_const c).norm_sq
  have h2 := deriv_nonneg_of_leftmax h1 (by
    filter_upwards [hin] with t ht
    have : ‖γ t - c‖ ^ 2 ≤ 1 := by nlinarith only [ht, norm_nonneg (γ t - c)]
    rw [hxc]; simpa using this)
  have h3 : inner ℝ (γ te - c) γ' = ((starRingEnd ℂ) (γ te - c) * γ').re := by
    rw [Complex.inner]; ring_nf
  rw [h3] at h2
  linarith only [h2]

/-- `Im (ν conj d) = Re (conj d γ') / ‖γ'‖` for the left normal `ν = i γ'/‖γ'‖`. -/
theorem im_leftNormal_mul_conj {γ' d : ℂ} (hγ' : γ' ≠ 0) :
    (leftNormal γ' * (starRingEnd ℂ) d).im = ((starRingEnd ℂ) d * γ').re / ‖γ'‖ := by
  have hn : (‖γ'‖ : ℝ) ≠ 0 := norm_ne_zero_iff.mpr hγ'
  have : leftNormal γ' * (starRingEnd ℂ) d = I * (((starRingEnd ℂ) d * γ') / (‖γ'‖ : ℂ)) := by
    unfold leftNormal; ring
  rw [this, Complex.I_mul_im, Complex.div_ofReal_re]

/-- **FS116-S1-EXIT** at the class its argument reads: with `30° < b < 90°`, `−90° < a < −30°`, a curve with left derivative
`γ' ≠ 0` at `t_e`, inside `Λ` just before `t_e` and on its frontier at `t_e` other than `0`, whose left unit normal `ν` at
`t_e` meets the four distance conditions, exits with `γ(t_e) + ν = e(b)` or `γ(t_e) − ν = e(a)`. -/
theorem exit_lens {a b : ℝ} (hb₁ : π / 6 < b) (hb₂ : b < π / 2) (ha₁ : -(π / 2) < a) (ha₂ : a < -(π / 6))
    {γ : ℝ → ℂ} {γ' : ℂ} {te : ℝ} (hγ : HasDerivWithinAt γ γ' (Iic te) te) (hγ' : γ' ≠ 0)
    (hin : ∀ᶠ t in 𝓝[<] te, γ t ∈ lensΛ a b) (hexit : γ te ∈ frontier (lensΛ a b)) (hne : γ te ≠ 0)
    (h3 : dist (γ te + leftNormal γ') (e (b + π / 3)) ≤ 1) (h5 : dist (γ te - leftNormal γ') (e (a - π / 3)) ≤ 1)
    (h3' : 1 ≤ dist (γ te) (e (b + π / 3))) (h5' : 1 ≤ dist (γ te) (e (a - π / 3))) :
    γ te + leftNormal γ' = e b ∨ γ te - leftNormal γ' = e a := by
  have _ := And.intro (Ne.symm (Ne.symm hne)) (And.intro h3' h5') -- idle: the lens and the two `y₃`, `y₅` tip conditions already pin the exit (§ 6.2's far side is not read)
  set x := γ te with hx
  have hνn : ‖leftNormal γ'‖ = 1 := by
    have hn : (‖γ'‖ : ℝ) ≠ 0 := norm_ne_zero_iff.mpr hγ'
    unfold leftNormal
    rw [norm_mul, Complex.norm_I, norm_div, Complex.norm_real, norm_norm, div_self hn, one_mul]
  have hΛ : IsOpen (lensΛ a b) := isOpen_ball.inter isOpen_ball
  have hcl : x ∈ closedBall (e a) 1 ∩ closedBall (e b) 1 := by
    have : closure (lensΛ a b) ⊆ closedBall (e a) 1 ∩ closedBall (e b) 1 :=
      (closure_inter_subset_inter_closure _ _).trans
        (inter_subset_inter closure_ball_subset_closedBall closure_ball_subset_closedBall)
    exact this (frontier_subset_closure hexit)
  have hnot : x ∉ lensΛ a b := by
    intro h; rw [hΛ.frontier_eq] at hexit; exact hexit.2 h
  have hxa : ‖x - e a‖ ≤ 1 := by simpa [dist_eq_norm] using hcl.1
  have hxb : ‖x - e b‖ ≤ 1 := by simpa [dist_eq_norm] using hcl.2
  have hcases : ‖x - e b‖ = 1 ∨ ‖x - e a‖ = 1 := by
    by_contra hcon
    push Not at hcon
    exact hnot ⟨by simpa [dist_eq_norm] using lt_of_le_of_ne hxa hcon.2,
      by simpa [dist_eq_norm] using lt_of_le_of_ne hxb hcon.1⟩
  have hinb : ∀ᶠ t in 𝓝[<] te, ‖γ t - e b‖ < 1 := by
    filter_upwards [hin] with t ht; simpa [dist_eq_norm] using ht.2
  have hina : ∀ᶠ t in 𝓝[<] te, ‖γ t - e a‖ < 1 := by
    filter_upwards [hin] with t ht; simpa [dist_eq_norm] using ht.1
  have hγn : 0 < ‖γ'‖ := norm_pos_iff.mpr hγ'
  rcases hcases with hb | ha
  · left
    have hout := re_conj_mul_nonneg_of_exit hγ hinb hb
    have hcr : 0 ≤ (leftNormal γ' * (starRingEnd ℂ) (x - e b)).im := by
      rw [im_leftNormal_mul_conj hγ']; positivity
    exact lens_core hb₁ hb₂ ha₁ ha₂ hνn hb hxa hcr (by simpa [dist_eq_norm] using h3)
  · right
    have hout := re_conj_mul_nonneg_of_exit hγ hina ha
    have hcr : 0 ≤ (leftNormal γ' * (starRingEnd ℂ) (x - e a)).im := by
      rw [im_leftNormal_mul_conj hγ']; positivity
    have hconj := conj_e
    have hxa2 : ‖(starRingEnd ℂ) x - e (-a)‖ = 1 := by
      rw [← hconj, ← map_sub, RCLike.norm_conj]; exact ha
    have hxb2 : ‖(starRingEnd ℂ) x - e (-b)‖ ≤ 1 := by
      rw [← hconj, ← map_sub, RCLike.norm_conj]; exact hxb
    have hcr2 : 0 ≤ (-(starRingEnd ℂ) (leftNormal γ') * (starRingEnd ℂ) ((starRingEnd ℂ) x - e (-a))).im := by
      rw [← hconj, ← map_sub, Complex.conj_conj, neg_mul, Complex.neg_im]
      have : (starRingEnd ℂ) (leftNormal γ') * (x - e a)
          = (starRingEnd ℂ) (leftNormal γ' * (starRingEnd ℂ) (x - e a)) := by simp
      rw [this, Complex.conj_im]; linarith only [hcr]
    have hP2 : ‖(starRingEnd ℂ) x + -(starRingEnd ℂ) (leftNormal γ') - e (-a + π / 3)‖ ≤ 1 := by
      have h5' : ‖x - leftNormal γ' - e (a - π / 3)‖ ≤ 1 := by simpa [dist_eq_norm] using h5
      have : (starRingEnd ℂ) x + -(starRingEnd ℂ) (leftNormal γ') - e (-a + π / 3)
          = (starRingEnd ℂ) (x - leftNormal γ' - e (a - π / 3)) := by
        rw [map_sub, map_sub, hconj, show -(a - π / 3) = -a + π / 3 by ring]; ring
      rw [this, RCLike.norm_conj]; exact h5'
    have key := lens_core (a := -b) (b := -a) (by linarith) (by linarith) (by linarith) (by linarith)
      (x := (starRingEnd ℂ) x) (ν := -(starRingEnd ℂ) (leftNormal γ'))
      (by rw [norm_neg, RCLike.norm_conj]; exact hνn) hxa2 hxb2 hcr2 hP2
    have key2 : (starRingEnd ℂ) (x - leftNormal γ') = (starRingEnd ℂ) (e a) := by
      rw [map_sub, hconj]; linear_combination key
    exact (starRingEnd ℂ).injective key2

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
  have _ := h0 -- idle: the row's start `γ 0 = 0` is not read
  have hIcc : Icc 0 te ∈ 𝓝[Iic te] te := by
    have : Icc 0 te = Iic te ∩ Ici 0 := by ext; simp [and_comm]
    rw [this]; exact inter_mem self_mem_nhdsWithin (mem_nhdsWithin_of_mem_nhds (Ici_mem_nhds hte))
  have hdiff : DifferentiableWithinAt ℝ γ (Icc 0 te) te :=
    ((hC1 te ⟨hte.le, le_rfl⟩).differentiableWithinAt (by norm_num))
  have hder : HasDerivWithinAt γ (derivWithin γ (Icc 0 te) te) (Iic te) te :=
    hdiff.hasDerivWithinAt.mono_of_mem_nhdsWithin hIcc
  refine exit_lens hb₁ hb₂ ha₁ ha₂ hder (hreg te ⟨hte.le, le_rfl⟩) ?_ hexit hne h3 h5 h3' h5'
  have : Ioo 0 te ∈ 𝓝[<] te := Ioo_mem_nhdsLT hte
  filter_upwards [this] with t ht using hin t ht

end HadwigerNelson.Plane
