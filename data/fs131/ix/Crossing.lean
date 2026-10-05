import Proofs.HadwigerNelson.Plane.PlaneTopology
import Mathlib.Topology.MetricSpace.Thickening

namespace HadwigerNelson.Plane

open Complex Real Set Topology Metric

theorem e_mul_e_neg (θ : ℝ) : e θ * e (-θ) = 1 := by
  rw [← e_add, add_neg_cancel]; simp [e]

theorem arg_one_sub_e {x : ℝ} (h0 : 0 < x) (h1 : x < 2 * π) : arg (1 - e x) = (x - π) / 2 := by
  set θ := (x - π) / 2 with hθ
  have hx : x = 2 * θ + π := by rw [hθ]; ring
  have hc : 0 < Real.cos θ := Real.cos_pos_of_mem_Ioo ⟨by rw [hθ]; linarith, by rw [hθ]; linarith⟩
  have key : 1 - e x = ((2 * Real.cos θ : ℝ) : ℂ) * (Complex.cos θ + Complex.sin θ * I) := by
    rw [hx, e_eq, Real.cos_add_pi, Real.sin_add_pi, Real.cos_two_mul, Real.sin_two_mul]
    push_cast; ring
  rw [key, Complex.arg_mul_cos_add_sin_mul_I (by linarith)
    ⟨by rw [hθ]; linarith [Real.pi_pos], by rw [hθ]; linarith⟩]

theorem arg_one_sub_e_of_neg {x : ℝ} (h0 : -(2 * π) < x) (h1 : x < 0) : arg (1 - e x) = (x + π) / 2 := by
  rw [← e_add_two_pi, arg_one_sub_e (by linarith) (by linarith)]; ring

theorem re_pos_of_mem_closedBall {u z : ℂ} (hz : z ∈ closedBall u 1) {θ : ℝ} (hne : z ≠ ringPt u θ) :
    0 < ((ringPt u θ - z) * e (-θ)).re := by
  set w := (z - u) * e (-θ) with hw
  have hwn : ‖w‖ ≤ 1 := by
    rw [hw, norm_mul, norm_e, mul_one, ← dist_eq_norm]; exact hz
  have heq : (ringPt u θ - z) * e (-θ) = 1 - w := by
    rw [hw, ringPt, ← e_mul_e_neg θ]; ring
  rw [heq, sub_re, one_re, sub_pos]
  by_contra hge
  push Not at hge
  have hre : w.re = ‖w‖ := le_antisymm (re_le_norm w) (by linarith)
  have him : w.im = 0 := by
    by_contra h
    have := Complex.abs_re_lt_norm.mpr h
    rw [abs_of_nonneg (by linarith)] at this
    linarith
  have hw1 : w = 1 := Complex.ext (by simp; linarith [re_le_norm w]) (by simp [him])
  apply hne
  have : z - u = e θ := by
    have h2 : (z - u) * e (-θ) * e θ = e θ := by rw [← hw, hw1, one_mul]
    rwa [mul_assoc, mul_comm (e (-θ)), e_mul_e_neg, mul_one] at h2
  rw [ringPt, ← this]; ring

theorem ringPt_sub_ringPt_mul_e_neg (u : ℂ) (a b : ℝ) : (ringPt u a - ringPt u b) * e (-a) = 1 - e (b - a) := by
  rw [ringPt, ringPt, sub_eq_add_neg b a, e_add, ← e_mul_e_neg a]; ring

theorem im_sub_eq_arg_sub {f v : ℝ → ℂ} (hf : ContinuousOn f (Icc 0 1)) (hv : ContinuousOn v (Icc 0 1))
    (hpos : ∀ x ∈ Icc (0 : ℝ) 1, 0 < (v x).re) {κ : ℂ} (hexp : ∀ x ∈ Icc (0 : ℝ) 1, Complex.exp (f x) = κ * v x) :
    (f 1 - f 0).im = arg (v 1) - arg (v 0) := by
  have h0 : (0 : ℝ) ∈ Icc (0 : ℝ) 1 := ⟨le_rfl, zero_le_one⟩
  have h1 : (1 : ℝ) ∈ Icc (0 : ℝ) 1 := ⟨zero_le_one, le_rfl⟩
  have hκ : κ ≠ 0 := by
    rintro rfl
    exact Complex.exp_ne_zero (f 0) (by rw [hexp 0 h0, zero_mul])
  have hv0 : ∀ x ∈ Icc (0 : ℝ) 1, v x ≠ 0 := fun x hx h => by
    have := hpos x hx; rw [h, zero_re] at this; exact lt_irrefl 0 this
  have hslit : ∀ x ∈ Icc (0 : ℝ) 1, v x ∈ slitPlane := fun x hx => mem_slitPlane_iff.mpr (Or.inl (hpos x hx))
  set g : ℝ → ℝ := fun x => (f x - Complex.log (v x) - Complex.log κ).im / (2 * π) with hg
  have hgc : ContinuousOn g (Icc 0 1) := by
    refine ContinuousOn.div_const ?_ _
    exact (Complex.continuous_im.comp_continuousOn ((hf.sub (hv.clog hslit)).sub continuousOn_const))
  have hgint : ∀ x ∈ Icc (0 : ℝ) 1, ∃ n : ℤ, g x = n := by
    intro x hx
    have he : Complex.exp (f x) = Complex.exp (Complex.log κ + Complex.log (v x)) := by
      rw [hexp x hx, Complex.exp_add, Complex.exp_log hκ, Complex.exp_log (hv0 x hx)]
    obtain ⟨n, hn⟩ := Complex.exp_eq_exp_iff_exists_int.mp he
    refine ⟨n, ?_⟩
    simp only [hg, hn]
    have : (Complex.log κ + Complex.log (v x) + ↑n * (2 * ↑π * I) - Complex.log (v x) - Complex.log κ).im
        = n * (2 * π) := by simp; ring
    rw [this]; field_simp
  have := eq_of_intValued_of_isPreconnected isPreconnected_Icc hgc hgint h1 h0
  simp only [hg] at this
  have hπ : (2 * π) ≠ 0 := by positivity
  rw [div_left_inj' hπ] at this
  simp only [sub_im, Complex.log_im] at this
  rw [sub_im]
  linarith

theorem exists_eq_of_interleaved_paths {u : ℂ} {s s' t t' : ℝ} (h₁ : s < s') (h₂ : s' < t) (h₃ : t < t')
    (h₄ : t' < s + 2 * π) (γ : Path (ringPt u s) (ringPt u t)) (γ' : Path (ringPt u s') (ringPt u t'))
    (hγ : ∀ x, γ x ∈ closedBall u 1) (hγ' : ∀ y, γ' y ∈ closedBall u 1) : ∃ x y, γ x = γ' y := by
  by_contra hne
  push Not at hne
  have hext : ∀ r : ℝ, ∃ x, γ x = γ.extend r := fun r => by
    have h : γ.extend r ∈ range γ := γ.extend_range ▸ mem_range_self r
    exact h
  have hext' : ∀ r : ℝ, ∃ y, γ' y = γ'.extend r := fun r => by
    have h : γ'.extend r ∈ range γ' := γ'.extend_range ▸ mem_range_self r
    exact h
  have hD : ∀ r, γ.extend r ∈ closedBall u 1 := fun r => by obtain ⟨x, hx⟩ := hext r; rw [← hx]; exact hγ x
  have hD' : ∀ r, γ'.extend r ∈ closedBall u 1 := fun r => by
    obtain ⟨y, hy⟩ := hext' r; rw [← hy]; exact hγ' y
  have hne' : ∀ r r', γ.extend r ≠ γ'.extend r' := fun r r' => by
    obtain ⟨x, hx⟩ := hext r; obtain ⟨y, hy⟩ := hext' r'; rw [← hx, ← hy]; exact hne x y
  set Ψ : ℂ → ℂ := fun z => γ.extend z.re - γ'.extend z.im with hΨ
  have hΨc : Continuous Ψ :=
    (γ.extend.continuous.comp Complex.continuous_re).sub (γ'.extend.continuous.comp Complex.continuous_im)
  have hΨ0 : ∀ z, Ψ z ≠ 0 := fun z => sub_ne_zero.mpr (hne' _ _)
  let f : C(ℂ, {z : ℂ // z ≠ 0}) := ⟨fun z => ⟨Ψ z, hΨ0 z⟩, hΨc.subtype_mk _⟩
  obtain ⟨F, ⟨-, hF⟩, -⟩ := Complex.isCoveringMap_exp.existsUnique_continuousMap_lifts f 0 (Complex.log (Ψ 0))
    (by ext; simp [f, Complex.exp_log (hΨ0 0)])
  have hFexp : ∀ z, Complex.exp (F z) = Ψ z := by
    intro z
    have := congrArg Subtype.val (congrFun hF z)
    simpa [f] using this
  have hΨpt : ∀ x y : ℝ, Ψ (↑x + ↑y * I) = γ.extend x - γ'.extend y := fun x y => by simp [hΨ]
  -- edge 1: `y = 0`, `x` from `0` to `1`
  have e1 := im_sub_eq_arg_sub (f := fun x : ℝ => F (↑x + ↑(0 : ℝ) * I))
    (v := fun x => (ringPt u s' - γ.extend x) * e (-s')) (κ := -e s')
    (F.continuous.comp (by fun_prop)).continuousOn
    ((continuous_const.sub γ.extend.continuous).mul continuous_const).continuousOn
    (fun x _ => re_pos_of_mem_closedBall (hD x) (by rw [← γ'.extend_zero]; exact hne' x 0))
    (fun x _ => by
      rw [hFexp, hΨpt, γ'.extend_zero,
        show -e s' * ((ringPt u s' - γ.extend x) * e (-s')) = -(ringPt u s' - γ.extend x) * (e s' * e (-s')) by ring,
        e_mul_e_neg]; ring)
  -- edge 2: `x = 1`, `y` from `0` to `1`
  have e2 := im_sub_eq_arg_sub (f := fun y : ℝ => F (↑(1 : ℝ) + ↑y * I))
    (v := fun y => (ringPt u t - γ'.extend y) * e (-t)) (κ := e t)
    (F.continuous.comp (by fun_prop)).continuousOn
    ((continuous_const.sub γ'.extend.continuous).mul continuous_const).continuousOn
    (fun y _ => re_pos_of_mem_closedBall (hD' y) (by rw [← γ.extend_one]; exact (hne' 1 y).symm))
    (fun y _ => by
      rw [hFexp, hΨpt, γ.extend_one,
        show e t * ((ringPt u t - γ'.extend y) * e (-t)) = (ringPt u t - γ'.extend y) * (e t * e (-t)) by ring,
        e_mul_e_neg]; ring)
  -- edge 3: `y = 1`, `x` from `0` to `1`
  have e3 := im_sub_eq_arg_sub (f := fun x : ℝ => F (↑x + ↑(1 : ℝ) * I))
    (v := fun x => (ringPt u t' - γ.extend x) * e (-t')) (κ := -e t')
    (F.continuous.comp (by fun_prop)).continuousOn
    ((continuous_const.sub γ.extend.continuous).mul continuous_const).continuousOn
    (fun x _ => re_pos_of_mem_closedBall (hD x) (by rw [← γ'.extend_one]; exact hne' x 1))
    (fun x _ => by
      rw [hFexp, hΨpt, γ'.extend_one,
        show -e t' * ((ringPt u t' - γ.extend x) * e (-t')) = -(ringPt u t' - γ.extend x) * (e t' * e (-t')) by ring,
        e_mul_e_neg]; ring)
  -- edge 4: `x = 0`, `y` from `0` to `1`
  have e4 := im_sub_eq_arg_sub (f := fun y : ℝ => F (↑(0 : ℝ) + ↑y * I))
    (v := fun y => (ringPt u s - γ'.extend y) * e (-s)) (κ := e s)
    (F.continuous.comp (by fun_prop)).continuousOn
    ((continuous_const.sub γ'.extend.continuous).mul continuous_const).continuousOn
    (fun y _ => re_pos_of_mem_closedBall (hD' y) (by rw [← γ.extend_zero]; exact (hne' 0 y).symm))
    (fun y _ => by
      rw [hFexp, hΨpt, γ.extend_zero,
        show e s * ((ringPt u s - γ'.extend y) * e (-s)) = (ringPt u s - γ'.extend y) * (e s * e (-s)) by ring,
        e_mul_e_neg]; ring)
  simp only [γ.extend_zero, γ.extend_one, γ'.extend_zero, γ'.extend_one, ringPt_sub_ringPt_mul_e_neg] at e1 e2 e3 e4
  rw [arg_one_sub_e (by linarith) (by linarith), arg_one_sub_e_of_neg (by linarith) (by linarith)] at e1
  rw [arg_one_sub_e (by linarith) (by linarith), arg_one_sub_e_of_neg (by linarith) (by linarith)] at e2
  rw [arg_one_sub_e_of_neg (by linarith) (by linarith), arg_one_sub_e_of_neg (by linarith) (by linarith)] at e3
  rw [arg_one_sub_e (by linarith) (by linarith), arg_one_sub_e (by linarith) (by linarith)] at e4
  simp only [sub_im] at e1 e2 e3 e4
  linarith [Real.pi_pos]

end HadwigerNelson.Plane
