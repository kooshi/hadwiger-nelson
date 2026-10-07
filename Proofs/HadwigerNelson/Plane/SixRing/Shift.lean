import Proofs.HadwigerNelson.Plane.SixRing.Chart
import Proofs.HadwigerNelson.Plane.Chord
import Mathlib.Analysis.SpecialFunctions.Trigonometric.InverseDeriv

/-!
# The unit-pair relation between two adjacent hubs: the shift (FS-132, C132-M-ORBIT step M7)

Calculus on one explicit function. `shift d d' = arccos((r² + r'² − 1)/(2 r r')) − π/3 − (d + d')/2`, with
`r = ringRadius d = 2 cos(π/3 + d/2)`, is the derivation's `ε(d, d')`: the chart points `chart p α d` (near one hub)
and `chart p (α + ε + d' + π/3) d'` (near the next) are at distance `1`. No colouring and no measure, except
`measurable_shift`.

The leaves, and `exists_shiftBounds` proved from them: the constants of the derivation's display
"`0 < ε ≤ min(d, d')/16` and `|∇ε| ≤ 1/32`" on a square `(0, κ₁)²`. The bound by `min(d, d')/16` needs no expansion:
`ε` vanishes on both axes and is `1/32`-Lipschitz in each variable on the closed square. Positivity is the straddle
identity of row 148 (FS129-SR1-TWOCIRC, the library's `Plane.twoCirc_identity`) at zero shift, proved here in the
chart's own variables as `shift_sign_identity`. `plans/FS132-kernel-plan.md` stage 5 has the plan per leaf.

**How the leaves are proved** (`plans/FS132-I3-implementation.md`). The unit-pair relation is the law of cosines in
the chart's polar form (`chart_eq_polar` of `Plane/SixRing/Chart`, `norm_sq_polar_sub`) with `cos (arccos Q) = Q`. The sign compares
`Q` with `cos(π/3 + (d + d')/2)` by `shift_sign_identity` and uses that `arccos` is strictly decreasing. The Lipschitz
bound differentiates nothing by hand: the shift is continuously differentiable at the origin (a composition:
`Real.contDiffAt_arccos` at `Q = 1/2`), it vanishes on both positive axes, so its derivative there is zero, and a
continuously differentiable function is `K`-Lipschitz near a point for every `K` above the norm of its derivative
(`ContDiffAt.exists_lipschitzOnWith_of_nnnorm_lt`). The square `[0, κ]²` this gives is not explicit: the statement
asks for some `κ ∈ (0, 1/4]`.
-/

namespace HadwigerNelson.SixRing

open Real
open scoped Topology

/-- `r(d) = cos(d/2) − √3 sin(d/2)`: the radius with the angle `π/3` expanded. -/
theorem ringRadius_eq (d : ℝ) : ringRadius d = cos (d / 2) - √3 * sin (d / 2) := by
  rw [ringRadius, cos_add, cos_pi_div_three, sin_pi_div_three]
  ring

/-- On `[0, 1/4]` the radius `r(d) = 2 cos(π/3 + d/2)` lies in `(1/2, 1]`: the triangle with sides `r(d)`, `r(d')`,
`1` is non-degenerate. -/
theorem ringRadius_mem {d : ℝ} (h0 : 0 ≤ d) (h1 : d ≤ 1 / 4) : 1 / 2 < ringRadius d ∧ ringRadius d ≤ 1 := by
  rw [ringRadius_eq]
  have h3 : √3 ^ 2 = 3 := sq_sqrt (by norm_num)
  have h3pos : 0 < √3 := sqrt_pos.mpr (by norm_num)
  have h3lt : √3 < 2 := by nlinarith
  have hs0 : 0 ≤ sin (d / 2) := sin_nonneg_of_nonneg_of_le_pi (by linarith) (by linarith [pi_gt_three])
  have hs1 : sin (d / 2) ≤ d / 2 := sin_le (by linarith)
  have hc0 : 1 - (d / 2) ^ 2 / 2 ≤ cos (d / 2) := one_sub_sq_div_two_le_cos
  have hc1 : cos (d / 2) ≤ 1 := cos_le_one _
  constructor
  · nlinarith
  · nlinarith

/-- The shift is symmetric. -/
theorem shift_comm (d d' : ℝ) : shift d d' = shift d' d := by
  simp only [shift]
  ring_nf

/-- **M7, "for `d′ = 0` … `ε(d, 0) = 0`"**: the shift vanishes on the first axis. -/
theorem shift_zero_right {d : ℝ} (h0 : 0 ≤ d) (h1 : d ≤ 1 / 4) : shift d 0 = 0 := by
  obtain ⟨hr, -⟩ := ringRadius_mem h0 h1
  have hr0 : ringRadius 0 = 1 := by
    simp only [ringRadius, zero_div, add_zero, cos_pi_div_three]
    norm_num
  have hQ : (ringRadius d ^ 2 + ringRadius 0 ^ 2 - 1) / (2 * ringRadius d * ringRadius 0) =
      cos (π / 3 + d / 2) := by
    have hne : ringRadius d ≠ 0 := by linarith
    have hdef : cos (π / 3 + d / 2) = ringRadius d / 2 := by
      rw [ringRadius]
      ring
    rw [hr0, hdef]
    field_simp
    ring
  rw [shift, hQ, arccos_cos (by positivity) (by linarith [pi_gt_three])]
  ring

/-- **M7, "for `d = 0` … `ε(0, d′) = 0`"**: the shift vanishes on the second axis. -/
theorem shift_zero_left {d' : ℝ} (h0 : 0 ≤ d') (h1 : d' ≤ 1 / 4) : shift 0 d' = 0 := by
  rw [shift_comm]; exact shift_zero_right h0 h1

/-- The law of cosines for two points given in polar form about one centre. -/
theorem norm_sq_polar_sub (r r' β β' : ℝ) :
    ‖(r : ℂ) * Plane.e β - (r' : ℂ) * Plane.e β'‖ ^ 2 = r ^ 2 + r' ^ 2 - 2 * r * r' * cos (β' - β) := by
  rw [Complex.sq_norm, Complex.normSq_apply, Plane.e_eq, Plane.e_eq, cos_sub]
  simp only [Complex.sub_re, Complex.sub_im, Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.ofReal_re, Complex.ofReal_im, Complex.I_re, Complex.I_im, mul_zero, mul_one, zero_mul, sub_zero,
    add_zero, zero_add]
  linear_combination r ^ 2 * cos_sq_add_sin_sq β + r' ^ 2 * cos_sq_add_sin_sq β'

/-- For radii in `(1/2, 1]` the triangle with sides `r`, `r'`, `1` exists: the cosine of its angle at the centre is
in `[−1, 1]`. -/
theorem shiftCos_mem {r r' : ℝ} (hr : 1 / 2 < r) (hr1 : r ≤ 1) (hr' : 1 / 2 < r') (hr1' : r' ≤ 1) :
    -1 ≤ (r ^ 2 + r' ^ 2 - 1) / (2 * r * r') ∧ (r ^ 2 + r' ^ 2 - 1) / (2 * r * r') ≤ 1 := by
  have hpos : 0 < 2 * r * r' := by nlinarith
  constructor
  · rw [le_div_iff₀ hpos]
    nlinarith
  · rw [div_le_iff₀ hpos]
    nlinarith

/-- **The squared distance at zero shift** (row 148's straddle identity, FS129-SR1-TWOCIRC, in the chart's own
variables): `r² + r'² − 1 − 2 r r' cos(π/3 + (d + d')/2) = −8 sin(d/2) sin(d'/2) cos((d + d')/2)`. A polynomial
identity in the sines and cosines of `d/2`, `d'/2` and in `√3`, modulo the three Pythagorean relations; the
multipliers are printed by `data/fs132/i3/shift_identity.py`. -/
theorem shift_sign_identity (d d' : ℝ) :
    ringRadius d ^ 2 + ringRadius d' ^ 2 - 1 - 2 * ringRadius d * ringRadius d' * cos (π / 3 + (d + d') / 2) =
      -8 * sin (d / 2) * sin (d' / 2) * cos ((d + d') / 2) := by
  have h3 : √3 ^ 2 = 3 := sq_sqrt (by norm_num)
  have h1 := cos_sq_add_sin_sq (d / 2)
  have h2 := cos_sq_add_sin_sq (d' / 2)
  have hsplit : (d + d') / 2 = d / 2 + d' / 2 := by ring
  rw [ringRadius_eq, ringRadius_eq, hsplit, cos_add (π / 3), cos_pi_div_three, sin_pi_div_three, cos_add, sin_add]
  linear_combination
    (-cos (d' / 2) ^ 2 + 2 * cos (d' / 2) * √3 * sin (d' / 2) - √3 ^ 2 * sin (d' / 2) ^ 2 + 1) * h1 +
    (2 * cos (d / 2) * √3 * sin (d / 2) - √3 ^ 2 * sin (d / 2) ^ 2 + sin (d / 2) ^ 2) * h2 +
    (-3 * cos (d / 2) * cos (d' / 2) * sin (d / 2) * sin (d' / 2) +
      cos (d / 2) * √3 * sin (d / 2) * sin (d' / 2) ^ 2 +
      cos (d' / 2) * √3 * sin (d / 2) ^ 2 * sin (d' / 2) + 3 * sin (d / 2) ^ 2 * sin (d' / 2) ^ 2) * h3

/-- **M7, the unit-pair relation**: "`|z − z′| = 1` holds on `α′ = α + π/3 + d′ + ε(d, d′)`, independent of `α`". For
`0 ≤ d, d' ≤ 1/4` the chart points `Z(α, d)` and `Z(α + ε + d' + π/3, d')` are at distance `1`. -/
theorem dist_chart_chart_shift (p : ℂ) (α : ℝ) {d d' : ℝ} (hd : 0 ≤ d) (hd1 : d ≤ 1 / 4) (hd' : 0 ≤ d')
    (hd1' : d' ≤ 1 / 4) : dist (chart p α d) (chart p (α + shift d d' + d' + π / 3) d') = 1 := by
  obtain ⟨hr, hr1⟩ := ringRadius_mem hd hd1
  obtain ⟨hr', hr1'⟩ := ringRadius_mem hd' hd1'
  obtain ⟨hQ1, hQ2⟩ := shiftCos_mem hr hr1 hr' hr1'
  have hang : (α + shift d d' + d' + π / 3 - π / 3 - d' / 2) - (α - π / 3 - d / 2) =
      arccos ((ringRadius d ^ 2 + ringRadius d' ^ 2 - 1) / (2 * ringRadius d * ringRadius d')) := by
    simp only [shift]
    ring
  have hsq : dist (chart p α d) (chart p (α + shift d d' + d' + π / 3) d') ^ 2 = 1 := by
    rw [dist_eq_norm, chart_eq_polar, chart_eq_polar, add_sub_add_left_eq_sub, norm_sq_polar_sub, hang,
      cos_arccos hQ1 hQ2]
    have hne : ringRadius d ≠ 0 := by linarith
    have hne' : ringRadius d' ≠ 0 := by linarith
    field_simp
    ring
  rw [← sqrt_sq dist_nonneg, hsq, sqrt_one]

/-- **M7, the sign**: "`0 < ε(d, d′)`" for `0 < d, d' ≤ 1/4`. At zero shift the two chart points are nearer than `1`
(`shift_sign_identity`, which is `Plane.twoCirc_identity` in the chart's variables: the squared distance is
`1 − 8 sin(d/2) sin(d'/2) cos((d + d')/2)`), and the squared distance increases with the shift: the cosine of the
angle at the centre is below `cos(π/3 + (d + d')/2)`, and `arccos` is strictly decreasing. -/
theorem shift_pos {d d' : ℝ} (hd : 0 < d) (hd1 : d ≤ 1 / 4) (hd' : 0 < d') (hd1' : d' ≤ 1 / 4) :
    0 < shift d d' := by
  obtain ⟨hr, hr1⟩ := ringRadius_mem hd.le hd1
  obtain ⟨hr', hr1'⟩ := ringRadius_mem hd'.le hd1'
  obtain ⟨hQ1, hQ2⟩ := shiftCos_mem hr hr1 hr' hr1'
  have hpos : 0 < 2 * ringRadius d * ringRadius d' := by nlinarith
  -- at zero shift the two chart points are nearer than `1`
  have hsin : 0 < sin (d / 2) := sin_pos_of_pos_of_lt_pi (by linarith) (by linarith [pi_gt_three])
  have hsin' : 0 < sin (d' / 2) := sin_pos_of_pos_of_lt_pi (by linarith) (by linarith [pi_gt_three])
  have hcos : 0 < cos ((d + d') / 2) :=
    cos_pos_of_mem_Ioo ⟨by linarith [pi_gt_three], by linarith [pi_gt_three]⟩
  have hid := shift_sign_identity d d'
  have hprod : 0 < sin (d / 2) * sin (d' / 2) * cos ((d + d') / 2) := by positivity
  have hQ : (ringRadius d ^ 2 + ringRadius d' ^ 2 - 1) / (2 * ringRadius d * ringRadius d') <
      cos (π / 3 + (d + d') / 2) := by
    rw [div_lt_iff₀ hpos]
    linarith
  -- so the angle at the centre is larger than `π/3 + (d + d')/2`
  have harc := strictAntiOn_arccos ⟨hQ1, hQ2⟩ ⟨neg_one_le_cos _, cos_le_one _⟩ hQ
  rw [arccos_cos (by positivity) (by linarith [pi_gt_three])] at harc
  simp only [shift]
  linarith

/-- **M7, "`|∇ε| ≤ 1/32`"**, in the first variable, on a closed square `[0, κ]²` with `κ ≤ 1/4`: the shift is
continuously differentiable near the origin and its gradient vanishes there. -/
theorem exists_shift_lipschitz : ∃ κ : ℝ, 0 < κ ∧ κ ≤ 1 / 4 ∧
    ∀ d₁ d₂ d' : ℝ, 0 ≤ d₁ → d₁ ≤ κ → 0 ≤ d₂ → d₂ ≤ κ → 0 ≤ d' → d' ≤ κ →
      |shift d₁ d' - shift d₂ d'| ≤ |d₁ - d₂| / 32 := by
  -- the shift is continuously differentiable at the origin
  have hcd : ContDiffAt ℝ 1 (fun x : ℝ × ℝ => shift x.1 x.2) (0, 0) := by
    have hQ : ContDiffAt ℝ 1 (fun x : ℝ × ℝ => (ringRadius x.1 ^ 2 + ringRadius x.2 ^ 2 - 1) /
        (2 * ringRadius x.1 * ringRadius x.2)) (0, 0) := by
      refine ContDiffAt.div ?_ ?_ ?_
      · unfold ringRadius
        fun_prop
      · unfold ringRadius
        fun_prop
      · simp [ringRadius, cos_pi_div_three]
    have hQ0 : (ringRadius (0 : ℝ) ^ 2 + ringRadius (0 : ℝ) ^ 2 - 1) / (2 * ringRadius 0 * ringRadius 0) = 1 / 2 := by
      simp only [ringRadius, zero_div, add_zero, cos_pi_div_three]
      norm_num
    have harc : ContDiffAt ℝ 1 arccos ((fun x : ℝ × ℝ => (ringRadius x.1 ^ 2 + ringRadius x.2 ^ 2 - 1) /
        (2 * ringRadius x.1 * ringRadius x.2)) (0, 0)) := by
      show ContDiffAt ℝ 1 arccos ((ringRadius (0 : ℝ) ^ 2 + ringRadius (0 : ℝ) ^ 2 - 1) /
        (2 * ringRadius 0 * ringRadius 0))
      rw [hQ0]
      exact contDiffAt_arccos (by norm_num) (by norm_num)
    have hlin : ContDiffAt ℝ 1 (fun x : ℝ × ℝ => (x.1 + x.2) / 2) (0, 0) := by fun_prop
    exact ((harc.comp (0, 0) hQ).sub contDiffAt_const).sub hlin
  -- it vanishes on both positive axes, so its derivative at the origin is zero
  have hF := (hcd.differentiableAt one_ne_zero).hasFDerivAt
  have haxis : ∀ v : ℝ × ℝ, (∀ᶠ s in 𝓝[≥] (0 : ℝ), shift (s • v).1 (s • v).2 = 0) →
      fderiv ℝ (fun x : ℝ × ℝ => shift x.1 x.2) (0, 0) v = 0 := by
    intro v hv
    have hline : HasDerivAt (fun s : ℝ => s • v) v 0 := by
      simpa using (hasDerivAt_id (0 : ℝ)).smul_const v
    have hcomp := (hF.comp_hasDerivAt_of_eq (0 : ℝ) hline (by simp)).hasDerivWithinAt (s := Set.Ici 0)
    have hzero : HasDerivWithinAt (fun _ : ℝ => (0 : ℝ)) 0 (Set.Ici 0) 0 := hasDerivWithinAt_const _ _ _
    have hcongr := hzero.congr_of_eventuallyEq (f₁ := (fun x : ℝ × ℝ => shift x.1 x.2) ∘ fun s : ℝ => s • v) hv
      (by simpa using hv.self_of_nhdsWithin Set.self_mem_Ici)
    exact (uniqueDiffWithinAt_Ici (0 : ℝ)).eq_deriv _ hcomp hcongr
  have hsmall : ∀ᶠ s in 𝓝[≥] (0 : ℝ), 0 ≤ s ∧ s ≤ 1 / 4 :=
    Filter.eventually_of_mem (Icc_mem_nhdsGE (by norm_num : (0 : ℝ) < 1 / 4)) fun s hs => hs
  have h10 := haxis (1, 0) (hsmall.mono fun s hs => by simpa using shift_zero_right hs.1 hs.2)
  have h01 := haxis (0, 1) (hsmall.mono fun s hs => by simpa using shift_zero_left hs.1 hs.2)
  have hD0 : fderiv ℝ (fun x : ℝ × ℝ => shift x.1 x.2) (0, 0) = 0 := by
    refine ContinuousLinearMap.ext fun v => ?_
    have hv : v = v.1 • ((1 : ℝ), (0 : ℝ)) + v.2 • ((0 : ℝ), (1 : ℝ)) := by
      ext <;> simp
    rw [hv, map_add, map_smul, map_smul, h10, h01]
    simp
  -- so it is `1/32`-Lipschitz on a ball about the origin (in the sup norm: a square)
  obtain ⟨t, ht, hlip⟩ := hcd.exists_lipschitzOnWith_of_nnnorm_lt (1 / 32 : NNReal) (by rw [hD0]; simp)
  obtain ⟨δ, hδ, hball⟩ := Metric.mem_nhds_iff.mp ht
  refine ⟨min (δ / 2) (1 / 4), lt_min (by linarith) (by norm_num), min_le_right _ _, ?_⟩
  intro d₁ d₂ d' h1 h1' h2 h2' h3 h3'
  have hκδ : min (δ / 2) (1 / 4) < δ := (min_le_left _ _).trans_lt (by linarith)
  have hmem : ∀ x : ℝ, 0 ≤ x → x ≤ min (δ / 2) (1 / 4) → ((x, d') : ℝ × ℝ) ∈ t := fun x hx hx' => by
    refine hball ?_
    rw [Metric.mem_ball, Prod.dist_eq, max_lt_iff, Real.dist_eq, Real.dist_eq, sub_zero, sub_zero,
      abs_of_nonneg hx, abs_of_nonneg h3]
    exact ⟨hx'.trans_lt hκδ, h3'.trans_lt hκδ⟩
  have h := hlip.dist_le_mul (d₁, d') (hmem d₁ h1 h1') (d₂, d') (hmem d₂ h2 h2')
  have h32 : (((1 / 32 : NNReal) : ℝ)) = 1 / 32 := by norm_num
  rw [Real.dist_eq, Prod.dist_eq, dist_self, Real.dist_eq, max_eq_left (abs_nonneg _), h32] at h
  linarith

/-- The shift is a measurable function of the pair (it is a composition of measurable functions; no continuity is
claimed where a radius vanishes). -/
theorem measurable_shift : Measurable fun x : ℝ × ℝ => shift x.1 x.2 := by
  unfold shift ringRadius
  fun_prop

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

/-! ## Drift checks -/

/-- `shift`: no shift at the ring itself. -/
example : shift 0 0 = 0 := shift_zero_right le_rfl (by norm_num)

/-- `shift`: positive inside the ring, at the corner of the square `[0, 1/4]²`. -/
example : 0 < shift (1 / 4) (1 / 4) := shift_pos (by norm_num) le_rfl (by norm_num) le_rfl

/-- `shift` and `chart`: the unit pair at the corner of the square, about the origin. -/
example : dist (chart 0 0 (1 / 4)) (chart 0 (0 + shift (1 / 4) (1 / 4) + 1 / 4 + π / 3) (1 / 4)) = 1 :=
  dist_chart_chart_shift 0 0 (by norm_num) le_rfl (by norm_num) le_rfl

end HadwigerNelson.SixRing
