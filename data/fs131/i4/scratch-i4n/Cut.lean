import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Engine 3: the cut of an open sub-arc of a unit circle out of a map's arcs -/

/-! ## The bends' geometry: polar form about a direction, the lens profile, arcs cut by a half-plane -/

/-- `cos a − cos h ≤ h − a` for `0 ≤ a ≤ h ≤ π`. -/
theorem cos_sub_cos_le_sub {a h : ℝ} (ha : 0 ≤ a) (hah : a ≤ h) (hh : h ≤ π) : Real.cos a - Real.cos h ≤ h - a := by
  rw [Real.cos_sub_cos]
  have h1 : Real.sin ((a - h) / 2) = - Real.sin ((h - a) / 2) := by rw [← Real.sin_neg]; ring_nf
  rw [h1]
  have h2 : Real.sin ((h - a) / 2) ≤ (h - a) / 2 := Real.sin_le (by linarith)
  have h3 : 0 ≤ Real.sin ((h - a) / 2) := Real.sin_nonneg_of_nonneg_of_le_pi (by linarith) (by linarith)
  have h4 : Real.sin ((a + h) / 2) ≤ 1 := Real.sin_le_one _
  nlinarith

/-- A cosine at least `cos h`, `0 ≤ h ≤ π`, puts an angle of `(−π, π]` within `h` of `0`. -/
theorem abs_le_of_cos_le {a h : ℝ} (ha : |a| ≤ π) (hh : 0 ≤ h) (hc : Real.cos h ≤ Real.cos a) : |a| ≤ h := by
  by_contra hlt
  push Not at hlt
  have := Real.cos_lt_cos_of_nonneg_of_le_pi hh ha hlt
  rw [Real.cos_abs] at this
  linarith

/-- The strict form. -/
theorem abs_lt_of_cos_lt {a h : ℝ} (ha : |a| ≤ π) (hh : 0 ≤ h) (hc : Real.cos h < Real.cos a) : |a| < h := by
  by_contra hle
  push Not at hle
  have := Real.cos_le_cos_of_nonneg_of_le_pi hh ha hle
  rw [Real.cos_abs] at this
  linarith

/-- **The toward lens profile in polar form**: a point `w`, `‖w‖ ≤ 1`, with `1 − ‖w‖² ≤ 2d(Re w − cos h)` has `|arg w| ≤ h` and radial
depth `1 − ‖w‖ ≤ 2d(h − |arg w|)`. -/
theorem polar_toward {d h : ℝ} (hd : 0 < d) (hh : 0 < h) (hh2 : h < π / 2) {w : ℂ} (hw1 : ‖w‖ ≤ 1)
    (hK : 1 - ‖w‖ ^ 2 ≤ 2 * d * (w.re - Real.cos h)) :
    0 < w.re ∧ |arg w| ≤ h ∧ 1 - ‖w‖ ≤ 2 * d * (h - |arg w|) := by
  have hcos : 0 < Real.cos h := Real.cos_pos_of_mem_Ioo ⟨by linarith, hh2⟩
  have hn0 := norm_nonneg w
  have hre : Real.cos h ≤ w.re := by
    by_contra hlt; push Not at hlt; nlinarith
  have hre0 : 0 < w.re := hcos.trans_le hre
  have hw0 : w ≠ 0 := fun h0 => by rw [h0, Complex.zero_re] at hre0; exact lt_irrefl _ hre0
  have hnpos : 0 < ‖w‖ := norm_pos_iff.mpr hw0
  have hca : Real.cos (arg w) = w.re / ‖w‖ := Complex.cos_arg hw0
  have hge : w.re ≤ Real.cos (arg w) := by rw [hca, le_div_iff₀ hnpos]; nlinarith
  have habs := abs_le_of_cos_le (Complex.abs_arg_le_pi w) hh.le (hre.trans hge)
  refine ⟨hre0, habs, ?_⟩
  have hsub := cos_sub_cos_le_sub (abs_nonneg (arg w)) habs (by linarith [Real.pi_pos])
  rw [Real.cos_abs] at hsub
  have hre' : w.re = ‖w‖ * Real.cos (arg w) := by rw [hca]; field_simp
  have : w.re ≤ Real.cos (arg w) := hge
  nlinarith

/-- The strict form: strictly inside the angle, strictly thinner than the profile. -/
theorem polar_toward_strict {d h : ℝ} (hd : 0 < d) (hh : 0 < h) (hh2 : h < π / 2) {w : ℂ} (hw1 : ‖w‖ ≤ 1)
    (hK : 1 - ‖w‖ ^ 2 < 2 * d * (w.re - Real.cos h)) : |arg w| < h ∧ 1 - ‖w‖ < 2 * d * (h - |arg w|) := by
  obtain ⟨hre0, -, -⟩ := polar_toward hd hh hh2 hw1 hK.le
  have hn0 := norm_nonneg w
  have hre : Real.cos h < w.re := by
    by_contra hle; push Not at hle; nlinarith
  have hw0 : w ≠ 0 := fun h0 => by rw [h0, Complex.zero_re] at hre0; exact lt_irrefl _ hre0
  have hnpos : 0 < ‖w‖ := norm_pos_iff.mpr hw0
  have hca : Real.cos (arg w) = w.re / ‖w‖ := Complex.cos_arg hw0
  have hge : w.re ≤ Real.cos (arg w) := by rw [hca, le_div_iff₀ hnpos]; nlinarith
  have habs := abs_lt_of_cos_lt (Complex.abs_arg_le_pi w) hh.le (hre.trans_le hge)
  refine ⟨habs, ?_⟩
  have hsub := cos_sub_cos_le_sub (abs_nonneg (arg w)) habs.le (by linarith [Real.pi_pos])
  rw [Real.cos_abs] at hsub
  nlinarith

/-- **The away lens profile in polar form**: a point `w`, `‖w‖ ≥ 1`, with `‖w‖² − 1 ≤ 2d(Re w − cos h)`, `d ≤ 1/2`, has
`|arg w| ≤ h` and radial height `‖w‖ − 1 ≤ 2d(h − |arg w|)`. -/
theorem polar_away {d h : ℝ} (hd : 0 < d) (hd2 : d ≤ 1 / 2) (hh : 0 < h) (hh2 : h < π / 2) {w : ℂ} (hw1 : 1 ≤ ‖w‖)
    (hK : ‖w‖ ^ 2 - 1 ≤ 2 * d * (w.re - Real.cos h)) :
    0 < w.re ∧ |arg w| ≤ h ∧ ‖w‖ - 1 ≤ 2 * d * (h - |arg w|) := by
  have hcos : 0 < Real.cos h := Real.cos_pos_of_mem_Ioo ⟨by linarith, hh2⟩
  have hcos1 : Real.cos h ≤ 1 := Real.cos_le_one h
  have hre : ‖w‖ * Real.cos h ≤ w.re := by
    nlinarith [mul_nonneg (sub_nonneg.mpr hw1) (show 0 ≤ ‖w‖ + 1 - 2 * d * Real.cos h by nlinarith)]
  have hre0 : 0 < w.re := lt_of_lt_of_le (by positivity) hre
  have hw0 : w ≠ 0 := fun h0 => by rw [h0, Complex.zero_re] at hre0; exact lt_irrefl _ hre0
  have hnpos : 0 < ‖w‖ := norm_pos_iff.mpr hw0
  have hca : Real.cos (arg w) = w.re / ‖w‖ := Complex.cos_arg hw0
  have hge : Real.cos h ≤ Real.cos (arg w) := by rw [hca, le_div_iff₀ hnpos]; linarith
  have habs := abs_le_of_cos_le (Complex.abs_arg_le_pi w) hh.le hge
  refine ⟨hre0, habs, ?_⟩
  have hsub := cos_sub_cos_le_sub (abs_nonneg (arg w)) habs (by linarith [Real.pi_pos])
  rw [Real.cos_abs] at hsub
  have hre' : w.re = ‖w‖ * Real.cos (arg w) := by rw [hca]; field_simp
  have hc1 : Real.cos (arg w) ≤ 1 := Real.cos_le_one _
  have hm1 : d * (Real.cos (arg w) - Real.cos h) ≤ d * (h - |arg w|) := mul_le_mul_of_nonneg_left hsub hd.le
  have hm2 : d * (‖w‖ - 1) * Real.cos (arg w) ≤ d * (‖w‖ - 1) :=
    mul_le_of_le_one_right (mul_nonneg hd.le (by linarith)) hc1
  have hstep : (‖w‖ - 1) * (2 - 2 * d) ≤ 2 * d * (h - |arg w|) := by nlinarith
  have hΔ : 0 ≤ h - |arg w| := by linarith
  nlinarith

/-- The strict form of `polar_away`. -/
theorem polar_away_strict {d h : ℝ} (hd : 0 < d) (hd2 : d ≤ 1 / 2) (hh : 0 < h) (hh2 : h < π / 2) {w : ℂ}
    (hw1 : 1 ≤ ‖w‖) (hK : ‖w‖ ^ 2 - 1 < 2 * d * (w.re - Real.cos h)) :
    |arg w| < h ∧ ‖w‖ - 1 < 2 * d * (h - |arg w|) := by
  obtain ⟨hre0, -, -⟩ := polar_away hd hd2 hh hh2 hw1 hK.le
  have hcos : 0 < Real.cos h := Real.cos_pos_of_mem_Ioo ⟨by linarith, hh2⟩
  have hre : ‖w‖ * Real.cos h < w.re := by
    nlinarith [mul_nonneg (sub_nonneg.mpr hw1) (show 0 ≤ ‖w‖ + 1 - 2 * d * Real.cos h by nlinarith [Real.cos_le_one h])]
  have hw0 : w ≠ 0 := fun h0 => by rw [h0, Complex.zero_re] at hre0; exact lt_irrefl _ hre0
  have hnpos : 0 < ‖w‖ := norm_pos_iff.mpr hw0
  have hca : Real.cos (arg w) = w.re / ‖w‖ := Complex.cos_arg hw0
  have hge : Real.cos h < Real.cos (arg w) := by rw [hca, lt_div_iff₀ hnpos]; linarith
  have habs := abs_lt_of_cos_lt (Complex.abs_arg_le_pi w) hh.le hge
  refine ⟨habs, ?_⟩
  have hsub := cos_sub_cos_le_sub (abs_nonneg (arg w)) habs.le (by linarith [Real.pi_pos])
  rw [Real.cos_abs] at hsub
  have hre' : w.re = ‖w‖ * Real.cos (arg w) := by rw [hca]; field_simp
  have hc1 : Real.cos (arg w) ≤ 1 := Real.cos_le_one _
  have hm1 : d * (Real.cos (arg w) - Real.cos h) ≤ d * (h - |arg w|) := mul_le_mul_of_nonneg_left hsub hd.le
  have hm2 : d * (‖w‖ - 1) * Real.cos (arg w) ≤ d * (‖w‖ - 1) :=
    mul_le_of_le_one_right (mul_nonneg hd.le (by linarith)) hc1
  have hstep : (‖w‖ - 1) * (2 - 2 * d) < 2 * d * (h - |arg w|) := by nlinarith
  nlinarith

/-- **An arc cut from a circle by a half-plane**: for `|τ| ≤ R`, the arc `circ C R (φ − arccos(τ/R)) (φ + arccos(τ/R))` is the set of
points of the circle whose component along `e φ` from the centre is at least `τ`. -/
theorem carrier_circ_arccos {C : ℂ} {R φ τ : ℝ} (hR : 0 < R) (hτ : |τ| ≤ R) :
    (Arc.circ C R (φ - Real.arccos (τ / R)) (φ + Real.arccos (τ / R))).carrier =
      {z | dist z C = R ∧ τ ≤ ((z - C) * starRingEnd ℂ (e φ)).re} := by
  have hτR : -1 ≤ τ / R ∧ τ / R ≤ 1 := by
    rw [abs_le] at hτ
    exact ⟨by rw [le_div_iff₀ hR]; linarith, by rw [div_le_one hR]; linarith⟩
  have hcosγ : Real.cos (Real.arccos (τ / R)) = τ / R := Real.cos_arccos hτR.1 hτR.2
  have hγ0 := Real.arccos_nonneg (τ / R)
  have hγπ := Real.arccos_le_pi (τ / R)
  ext z
  simp only [Arc.carrier, mem_image, mem_setOf_eq]
  constructor
  · rintro ⟨θ, hθ, rfl⟩
    refine ⟨by rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos hR], ?_⟩
    rw [add_sub_cancel_left, mul_assoc, Complex.re_ofReal_mul, ArcMap.re_e_mul_conj_e]
    have habs : |θ - φ| ≤ Real.arccos (τ / R) := abs_le.mpr ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
    have hc : Real.cos (Real.arccos (τ / R)) ≤ Real.cos |θ - φ| :=
      Real.cos_le_cos_of_nonneg_of_le_pi (abs_nonneg _) hγπ habs
    rw [Real.cos_abs, hcosγ] at hc
    rw [div_le_iff₀ hR] at hc
    linarith
  · rintro ⟨hd, hτq⟩
    set q := (z - C) * starRingEnd ℂ (e φ) with hq
    have hqn : ‖q‖ = R := by rw [hq, norm_mul, RCLike.norm_conj, norm_e, mul_one, ← dist_eq_norm, hd]
    have hq0 : q ≠ 0 := fun h0 => by rw [h0, norm_zero] at hqn; linarith
    have hzq : z = C + q * e φ := by
      rw [hq, mul_assoc, mul_comm (starRingEnd ℂ (e φ)), e_mul_conj_e, mul_one]; ring
    have hca : Real.cos (arg q) = q.re / R := by rw [Complex.cos_arg hq0, hqn]
    have hc : Real.cos (Real.arccos (τ / R)) ≤ Real.cos (arg q) := by
      rw [hcosγ, hca]; exact div_le_div_of_nonneg_right hτq hR.le
    have habs := abs_le_of_cos_le (Complex.abs_arg_le_pi q) hγ0 hc
    refine ⟨φ + arg q, ⟨by linarith [(abs_le.mp habs).1], by linarith [(abs_le.mp habs).2]⟩, ?_⟩
    have hqe : q = (R : ℂ) * e (arg q) := by rw [← hqn]; exact eq_norm_mul_e_arg
    symm
    calc z = C + q * e φ := hzq
      _ = C + (R : ℂ) * e (arg q) * e φ := by rw [← hqe]
      _ = C + R * e (φ + arg q) := by rw [e_add]; ring

/-- The frame along `e φ` at `P`: `w = (z − P) e(φ)‾` has `‖w‖ = |z − P|`. -/
theorem norm_frameDir (P z : ℂ) (φ : ℝ) : ‖(z - P) * starRingEnd ℂ (e φ)‖ = dist z P := by
  rw [norm_mul, RCLike.norm_conj, norm_e, mul_one, dist_eq_norm]

/-- `z = P + |z − P| e(φ + arg w)`, `w = (z − P) e(φ)‾`. -/
theorem eq_polar_frameDir (P z : ℂ) (φ : ℝ) :
    z = P + (dist z P : ℂ) * e (φ + arg ((z - P) * starRingEnd ℂ (e φ))) := by
  set w := (z - P) * starRingEnd ℂ (e φ) with hw
  have hzw : z - P = w * e φ := by rw [hw, mul_assoc, mul_comm (starRingEnd ℂ (e φ)), e_mul_conj_e, mul_one]
  have h1 : w = (‖w‖ : ℂ) * e (arg w) := eq_norm_mul_e_arg
  rw [← norm_frameDir P z φ, ← hw, e_add]
  calc z = P + w * e φ := by rw [← hzw]; ring
    _ = P + (‖w‖ : ℂ) * e (arg w) * e φ := by rw [← h1]
    _ = _ := by ring

/-- The squared distance to `P − d e(φ)`: `|z − P|² + 2d Re w + d²`. -/
theorem dist_sq_sub_dir (P z : ℂ) (φ d : ℝ) :
    dist z (P - d * e φ) ^ 2 = dist z P ^ 2 + 2 * d * ((z - P) * starRingEnd ℂ (e φ)).re + d ^ 2 := by
  set w := (z - P) * starRingEnd ℂ (e φ) with hw
  have hzw : z - P = w * e φ := by rw [hw, mul_assoc, mul_comm (starRingEnd ℂ (e φ)), e_mul_conj_e, mul_one]
  have h1 : z - (P - d * e φ) = (w + d) * e φ := by rw [add_mul, ← hzw]; ring
  rw [dist_eq_norm, h1, norm_mul, norm_e, mul_one, ← norm_frameDir P z φ, ← hw, Complex.sq_norm, Complex.sq_norm,
    Complex.normSq_apply, Complex.normSq_apply]
  simp only [Complex.add_re, Complex.ofReal_re, Complex.add_im, Complex.ofReal_im, add_zero]
  ring

/-- The squared distance to `P + d e(φ)`: `|z − P|² − 2d Re w + d²`. -/
theorem dist_sq_add_dir (P z : ℂ) (φ d : ℝ) :
    dist z (P + d * e φ) ^ 2 = dist z P ^ 2 - 2 * d * ((z - P) * starRingEnd ℂ (e φ)).re + d ^ 2 := by
  have := dist_sq_sub_dir P z φ (-d)
  rw [show P - ((-d : ℝ) : ℂ) * e φ = P + d * e φ by push_cast; ring] at this
  rw [this]; ring

/-- For a point `r(θ)` of `ω(P)`, `Re w = cos(θ − φ)`. -/
theorem re_frameDir_ringPt (P : ℂ) (θ φ : ℝ) : ((ringPt P θ - P) * starRingEnd ℂ (e φ)).re = Real.cos (θ - φ) := by
  rw [ringPt, add_sub_cancel_left, ArcMap.re_e_mul_conj_e]

/-- `min (h + a) (h − a) = h − |a|`. -/
theorem min_add_sub_eq (h a : ℝ) : min (h + a) (h - a) = h - |a| := by
  rcases le_total 0 a with ha | ha
  · rw [abs_of_nonneg ha, min_eq_right (by linarith)]
  · rw [abs_of_nonpos ha, min_eq_left (by linarith)]; ring

/-- The distance from `P + ρ e(φ)` to `r(φ)` is `|1 − ρ|`. -/
theorem dist_polar_ringPt (P : ℂ) (ρ φ : ℝ) : dist (P + (ρ : ℂ) * e φ) (ringPt P φ) = |1 - ρ| := by
  rw [dist_eq_norm, ringPt, show P + (ρ : ℂ) * e φ - (P + e φ) = ((ρ - 1 : ℝ) : ℂ) * e φ by push_cast; ring, norm_mul, norm_e,
    mul_one, Complex.norm_real, Real.norm_eq_abs, abs_sub_comm]

/-- An inequality on the open interval passes to the closed one (by continuity). -/
theorem le_on_Icc_of_Ioo {f : ℝ → ℝ} (hf : Continuous f) {a b c : ℝ} (hab : a < b) (h : ∀ θ ∈ Ioo a b, f θ ≤ c) :
    ∀ θ ∈ Icc a b, f θ ≤ c := by
  have : Icc a b ⊆ {θ | f θ ≤ c} := by
    rw [← closure_Ioo hab.ne]; exact closure_minimal h (isClosed_le hf continuous_const)
  exact fun θ hθ => this hθ

/-- The same, from below. -/
theorem ge_on_Icc_of_Ioo {f : ℝ → ℝ} (hf : Continuous f) {a b c : ℝ} (hab : a < b) (h : ∀ θ ∈ Ioo a b, c ≤ f θ) :
    ∀ θ ∈ Icc a b, c ≤ f θ := by
  have : Icc a b ⊆ {θ | c ≤ f θ} := by
    rw [← closure_Ioo hab.ne]; exact closure_minimal h (isClosed_le continuous_const hf)
  exact fun θ hθ => this hθ

/-- **The toward lens in polar form**: a point of `B̄(P, 1)` outside or on the circle about `P − d e(φ)` of squared radius
`1 + 2d cos h + d²` is `P + |z − P| e(φ + a)`, `a = arg w`, with `|a| ≤ h` and depth `1 − |z − P| ≤ 2d(h − |a|)`. -/
theorem toward_polar {P z : ℂ} {φ h d : ℝ} (hd : 0 < d) (hh : 0 < h) (hh2 : h < π / 2) (hz1 : dist z P ≤ 1)
    (hzC : 1 + 2 * d * Real.cos h + d ^ 2 ≤ dist z (P - d * e φ) ^ 2) :
    |arg ((z - P) * starRingEnd ℂ (e φ))| ≤ h ∧
      1 - dist z P ≤ 2 * d * (h - |arg ((z - P) * starRingEnd ℂ (e φ))|) := by
  have hK : 1 - ‖(z - P) * starRingEnd ℂ (e φ)‖ ^ 2 ≤ 2 * d * (((z - P) * starRingEnd ℂ (e φ)).re - Real.cos h) := by
    rw [norm_frameDir]; rw [dist_sq_sub_dir] at hzC; linarith
  obtain ⟨-, h1, h2⟩ := polar_toward hd hh hh2 (by rw [norm_frameDir]; exact hz1) hK
  rw [norm_frameDir] at h2
  exact ⟨h1, h2⟩

/-- The strict form: strictly outside the circle, strictly inside the angle and the profile. -/
theorem toward_polar_strict {P z : ℂ} {φ h d : ℝ} (hd : 0 < d) (hh : 0 < h) (hh2 : h < π / 2) (hz1 : dist z P ≤ 1)
    (hzC : 1 + 2 * d * Real.cos h + d ^ 2 < dist z (P - d * e φ) ^ 2) :
    |arg ((z - P) * starRingEnd ℂ (e φ))| < h ∧
      1 - dist z P < 2 * d * (h - |arg ((z - P) * starRingEnd ℂ (e φ))|) := by
  have hK : 1 - ‖(z - P) * starRingEnd ℂ (e φ)‖ ^ 2 < 2 * d * (((z - P) * starRingEnd ℂ (e φ)).re - Real.cos h) := by
    rw [norm_frameDir]; rw [dist_sq_sub_dir] at hzC; linarith
  have h := polar_toward_strict hd hh hh2 (by rw [norm_frameDir]; exact hz1) hK
  rw [norm_frameDir] at h
  exact h

/-- The squared distance between two points in polar form about `P`. -/
theorem dist_polar_polar_sq (P : ℂ) (ρ ρ' b b' : ℝ) :
    dist (P + (ρ : ℂ) * e b) (P + (ρ' : ℂ) * e b') ^ 2 = ρ ^ 2 + ρ' ^ 2 - 2 * ρ * ρ' * Real.cos (b - b') := by
  rw [dist_eq_norm, add_sub_add_left_eq_sub, Complex.sq_norm, Complex.normSq_apply]
  simp only [Complex.sub_re, Complex.sub_im, Complex.re_ofReal_mul, Complex.im_ofReal_mul, re_e, im_e]
  rw [Real.cos_sub]
  nlinarith [Real.cos_sq_add_sin_sq b, Real.cos_sq_add_sin_sq b']

/-- **Two points of the toward lens are never at distance `1`** (half-length `h ≤ 30°`): in polar form both lie within `h` of the
middle direction and within the unit disc, so `|z − z'|² < ρ² + ρ'² − ρρ' ≤ 1`. -/
theorem toward_pairs {P z z' : ℂ} {φ h d : ℝ} (hd : 0 < d) (hh : 0 < h) (hh6 : h ≤ π / 6)
    (hz1 : dist z P ≤ 1) (hzC : 1 + 2 * d * Real.cos h + d ^ 2 < dist z (P - d * e φ) ^ 2)
    (hz1' : dist z' P ≤ 1) (hzC' : 1 + 2 * d * Real.cos h + d ^ 2 < dist z' (P - d * e φ) ^ 2) : dist z z' ≠ 1 := by
  have hπ := Real.pi_pos
  have hh2 : h < π / 2 := by linarith
  set a := arg ((z - P) * starRingEnd ℂ (e φ))
  set a' := arg ((z' - P) * starRingEnd ℂ (e φ))
  obtain ⟨ha, -⟩ := toward_polar_strict hd hh hh2 hz1 hzC
  obtain ⟨ha', -⟩ := toward_polar_strict hd hh hh2 hz1' hzC'
  -- the radii are positive: the lens misses `P`
  have hcosh : 0 < Real.cos h := Real.cos_pos_of_mem_Ioo ⟨by linarith, hh2⟩
  have hoff : ∀ x : ℂ, 1 + 2 * d * Real.cos h + d ^ 2 < dist x (P - d * e φ) ^ 2 → 0 < dist x P := by
    intro x hx
    by_contra h0; push Not at h0
    have hxP : x = P := dist_le_zero.mp h0
    rw [hxP, dist_eq_norm, show P - (P - (d : ℂ) * e φ) = (d : ℂ) * e φ by ring, norm_mul, norm_e, mul_one,
      Complex.norm_real, Real.norm_eq_abs, sq_abs] at hx
    nlinarith
  have hρ := hoff z hzC
  have hρ' := hoff z' hzC'
  have hcos : 1 / 2 < Real.cos (a - a') := by
    have h1 : |a - a'| < π / 3 := by
      have := abs_sub (a) (a'); linarith [abs_sub_le_iff.mp (le_refl |a - a'|)]
    have := Real.cos_lt_cos_of_nonneg_of_le_pi (abs_nonneg (a - a')) (by linarith) h1
    rw [Real.cos_abs, Real.cos_pi_div_three] at this
    exact this
  have hsq : dist z z' ^ 2 = dist z P ^ 2 + dist z' P ^ 2 - 2 * dist z P * dist z' P * Real.cos (a - a') := by
    have hz := eq_polar_frameDir P z φ
    have hz' := eq_polar_frameDir P z' φ
    have : dist z z' = dist (P + (dist z P : ℂ) * e (φ + a)) (P + (dist z' P : ℂ) * e (φ + a')) := by
      rw [← hz, ← hz']
    rw [this, dist_polar_polar_sq, show φ + a - (φ + a') = a - a' by ring]
  intro h1
  have : dist z P ^ 2 + dist z' P ^ 2 - 2 * dist z P * dist z' P * Real.cos (a - a') < 1 := by
    nlinarith [mul_pos hρ hρ', mul_nonneg (sub_nonneg.mpr hz1) (show 0 ≤ dist z P + 1 - dist z' P by linarith),
      mul_nonneg hρ'.le (sub_nonneg.mpr hz1')]
  rw [← hsq, h1] at this
  norm_num at this

/-- The component of `z − (P − d e(φ))` along `e φ` is `Re w + d`. -/
theorem re_frameDir_sub_dir (P z : ℂ) (φ d : ℝ) :
    ((z - (P - d * e φ)) * starRingEnd ℂ (e φ)).re = ((z - P) * starRingEnd ℂ (e φ)).re + d := by
  rw [show z - (P - d * e φ) = (z - P) + d * e φ by ring, add_mul, mul_assoc, e_mul_conj_e, mul_one, Complex.add_re,
    Complex.ofReal_re]

/-- **The toward bend's new arc**: the arc of the circle about `P − d e(φ)` of squared radius `1 + 2d cos h + d²` cut by the
half-plane `Re((z − C) e(φ)‾) ≥ d + cos h` is exactly that circle's part in `B̄(P, 1)`. -/
theorem toward_carrier (P : ℂ) {φ h d : ℝ} (hd : 0 < d) (hcos : 0 < Real.cos h) :
    (Arc.circ (P - d * e φ) √(1 + 2 * d * Real.cos h + d ^ 2)
      (φ - Real.arccos ((d + Real.cos h) / √(1 + 2 * d * Real.cos h + d ^ 2)))
      (φ + Real.arccos ((d + Real.cos h) / √(1 + 2 * d * Real.cos h + d ^ 2)))).carrier =
      {z | dist z (P - d * e φ) = √(1 + 2 * d * Real.cos h + d ^ 2) ∧ dist z P ≤ 1} := by
  have hpos : 0 < 1 + 2 * d * Real.cos h + d ^ 2 := by positivity
  set R := √(1 + 2 * d * Real.cos h + d ^ 2) with hRdef
  have hRsq : R ^ 2 = 1 + 2 * d * Real.cos h + d ^ 2 := Real.sq_sqrt hpos.le
  have hR : 0 < R := Real.sqrt_pos.2 hpos
  have hτ : |d + Real.cos h| ≤ R := by
    rw [abs_of_pos (by positivity)]
    refine Real.le_sqrt_of_sq_le ?_
    nlinarith [Real.cos_sq_le_one h]
  rw [carrier_circ_arccos hR hτ]
  ext z
  simp only [mem_setOf_eq, re_frameDir_sub_dir]
  have hd2 := dist_sq_sub_dir P z φ d
  constructor <;> rintro ⟨hzc, h2⟩ <;> refine ⟨hzc, ?_⟩
  · rw [hzc, hRsq] at hd2
    have : dist z P ^ 2 ≤ 1 := by nlinarith
    nlinarith [dist_nonneg (x := z) (y := P)]
  · rw [hzc, hRsq] at hd2
    have : dist z P ^ 2 ≤ 1 := by nlinarith [dist_nonneg (x := z) (y := P)]
    nlinarith

/-- The component of `z − (P + d e(φ))` along `e φ` is `Re w − d`. -/
theorem re_frameDir_add_dir (P z : ℂ) (φ d : ℝ) :
    ((z - (P + d * e φ)) * starRingEnd ℂ (e φ)).re = ((z - P) * starRingEnd ℂ (e φ)).re - d := by
  have := re_frameDir_sub_dir P z φ (-d)
  rw [show P - ((-d : ℝ) : ℂ) * e φ = P + d * e φ by push_cast; ring] at this
  rw [this]; ring

/-- **The away lens in polar form**: a point outside `B(P, 1)` inside or on the circle about `P + d e(φ)` of squared radius
`1 − 2d cos h + d²` (`d ≤ 1/2`) is `P + |z − P| e(φ + a)` with `|a| ≤ h` and height `|z − P| − 1 ≤ 2d(h − |a|)`. -/
theorem away_polar {P z : ℂ} {φ h d : ℝ} (hd : 0 < d) (hd2 : d ≤ 1 / 2) (hh : 0 < h) (hh2 : h < π / 2)
    (hz1 : 1 ≤ dist z P) (hzC : dist z (P + d * e φ) ^ 2 ≤ 1 - 2 * d * Real.cos h + d ^ 2) :
    |arg ((z - P) * starRingEnd ℂ (e φ))| ≤ h ∧
      dist z P - 1 ≤ 2 * d * (h - |arg ((z - P) * starRingEnd ℂ (e φ))|) := by
  have hK : ‖(z - P) * starRingEnd ℂ (e φ)‖ ^ 2 - 1 ≤ 2 * d * (((z - P) * starRingEnd ℂ (e φ)).re - Real.cos h) := by
    rw [norm_frameDir]; rw [dist_sq_add_dir] at hzC; linarith
  obtain ⟨-, h1, h2⟩ := polar_away hd hd2 hh hh2 (by rw [norm_frameDir]; exact hz1) hK
  rw [norm_frameDir] at h2
  exact ⟨h1, h2⟩

/-- The strict form of `away_polar`. -/
theorem away_polar_strict {P z : ℂ} {φ h d : ℝ} (hd : 0 < d) (hd2 : d ≤ 1 / 2) (hh : 0 < h) (hh2 : h < π / 2)
    (hz1 : 1 ≤ dist z P) (hzC : dist z (P + d * e φ) ^ 2 < 1 - 2 * d * Real.cos h + d ^ 2) :
    |arg ((z - P) * starRingEnd ℂ (e φ))| < h ∧
      dist z P - 1 < 2 * d * (h - |arg ((z - P) * starRingEnd ℂ (e φ))|) := by
  have hK : ‖(z - P) * starRingEnd ℂ (e φ)‖ ^ 2 - 1 < 2 * d * (((z - P) * starRingEnd ℂ (e φ)).re - Real.cos h) := by
    rw [norm_frameDir]; rw [dist_sq_add_dir] at hzC; linarith
  have h := polar_away_strict hd hd2 hh hh2 (by rw [norm_frameDir]; exact hz1) hK
  rw [norm_frameDir] at h
  exact h

/-- **The away bend's new arc**: the arc of the circle about `P + d e(φ)` of squared radius `1 − 2d cos h + d²` cut by the
half-plane `Re((z − C) e(φ)‾) ≥ cos h − d` is exactly that circle's part outside `B(P, 1)`. -/
theorem away_carrier (P : ℂ) {φ h d : ℝ} (hd : 0 < d) (hpos : 0 < 1 - 2 * d * Real.cos h + d ^ 2) :
    (Arc.circ (P + d * e φ) √(1 - 2 * d * Real.cos h + d ^ 2)
      (φ - Real.arccos ((Real.cos h - d) / √(1 - 2 * d * Real.cos h + d ^ 2)))
      (φ + Real.arccos ((Real.cos h - d) / √(1 - 2 * d * Real.cos h + d ^ 2)))).carrier =
      {z | dist z (P + d * e φ) = √(1 - 2 * d * Real.cos h + d ^ 2) ∧ 1 ≤ dist z P} := by
  set R := √(1 - 2 * d * Real.cos h + d ^ 2) with hRdef
  have hRsq : R ^ 2 = 1 - 2 * d * Real.cos h + d ^ 2 := Real.sq_sqrt hpos.le
  have hR : 0 < R := Real.sqrt_pos.2 hpos
  have hτ : |Real.cos h - d| ≤ R := by
    refine Real.abs_le_sqrt ?_
    nlinarith [Real.cos_sq_le_one h]
  rw [carrier_circ_arccos hR hτ]
  ext z
  simp only [mem_setOf_eq, re_frameDir_add_dir]
  have hd2 := dist_sq_add_dir P z φ d
  constructor <;> rintro ⟨hzc, h2⟩ <;> refine ⟨hzc, ?_⟩
  · rw [hzc, hRsq] at hd2
    have h3 : 0 ≤ d * (((z - P) * starRingEnd ℂ (e φ)).re - Real.cos h) := mul_nonneg hd.le (by linarith)
    have : 1 ≤ dist z P ^ 2 := by nlinarith
    nlinarith [dist_nonneg (x := z) (y := P)]
  · rw [hzc, hRsq] at hd2
    have : 1 ≤ dist z P ^ 2 := by nlinarith [dist_nonneg (x := z) (y := P)]
    have h3 : 0 ≤ d * (((z - P) * starRingEnd ℂ (e φ)).re - Real.cos h) := by nlinarith
    have h4 := (mul_nonneg_iff_of_pos_left hd).mp h3
    linarith

/-- `1 + 2dy ≤ 2 cos(π/3 − y)` for `0 ≤ y ≤ π/3`, `d ≤ 1/10`. -/
theorem one_add_le_two_cos {d y : ℝ} (hd1 : d ≤ 1 / 10) (hy : 0 ≤ y) (hy3 : y ≤ π / 3) :
    1 + 2 * d * y ≤ 2 * Real.cos (π / 3 - y) := by
  have hπ := Real.pi_pos
  have hπ4 := Real.pi_lt_d2
  rw [Real.cos_sub, Real.cos_pi_div_three, Real.sin_pi_div_three]
  have hc : 1 - y ^ 2 / 2 ≤ Real.cos y := Real.one_sub_sq_div_two_le_cos
  have hs : 2 / π * y ≤ Real.sin y := Real.mul_le_sin hy (by linarith)
  have hs' : y / 2 ≤ Real.sin y := by
    refine le_trans ?_ hs
    rw [div_mul_eq_mul_div, le_div_iff₀ hπ]; nlinarith
  have h3 : (17 / 10 : ℝ) ≤ √3 := Real.le_sqrt_of_sq_le (by norm_num)
  have hsy : 0 ≤ Real.sin y := le_trans (by linarith) hs'
  nlinarith [mul_le_mul_of_nonneg_right h3 hsy]

/-- **A point of the away lens lies in `B̄(A, 1) ∩ B̄(B, 1)`**: at `P + ρ e(φ + b)`, `|b| < h ≤ 30°`, with height
`ρ − 1 ≤ 2d(h − |b|)`, `d ≤ 1/10`, both ends are within `1`. -/
theorem away_mem_lens {P : ℂ} {φ h d ρ b : ℝ} (hd : 0 ≤ d) (hd1 : d ≤ 1 / 10) (hh6 : h ≤ π / 6) (hb : |b| ≤ h)
    (hρ1 : 1 ≤ ρ) (hρ : ρ - 1 ≤ 2 * d * (h - |b|)) :
    dist (P + (ρ : ℂ) * e (φ + b)) (ringPt P (φ - h)) ≤ 1 ∧ dist (P + (ρ : ℂ) * e (φ + b)) (ringPt P (φ + h)) ≤ 1 := by
  have hπ := Real.pi_pos
  have key : ∀ β' y : ℝ, 0 ≤ y → |φ + b - β'| + y ≤ π / 3 → ρ ≤ 1 + 2 * d * y →
      dist (P + (ρ : ℂ) * e (φ + b)) (ringPt P β') ≤ 1 := by
    intro β' y hy hxy hρy
    have hcx : Real.cos (π / 3 - y) ≤ Real.cos |φ + b - β'| :=
      Real.cos_le_cos_of_nonneg_of_le_pi (abs_nonneg _) (by linarith) (by linarith)
    rw [Real.cos_abs] at hcx
    have h2 := one_add_le_two_cos hd1 hy (by linarith [abs_nonneg (φ + b - β')])
    have hr : ringPt P β' = P + ((1 : ℝ) : ℂ) * e β' := by rw [ringPt, Complex.ofReal_one, one_mul]
    rw [hr, ← sq_le_one_iff₀ dist_nonneg, dist_polar_polar_sq]
    nlinarith
  have hab := abs_le.mp hb
  refine ⟨key _ (h - b) (by linarith) ?_ (by nlinarith [le_abs_self b]), key _ (h + b) (by linarith) ?_
    (by nlinarith [neg_abs_le b])⟩
  · rw [show φ + b - (φ - h) = h + b by ring, abs_of_nonneg (by linarith)]; linarith
  · rw [show φ + b - (φ + h) = -(h - b) by ring, abs_neg, abs_of_nonneg (by linarith)]; linarith

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- The lower end of the `m`-th piece of the arc `circ P 1 θa θb` off the open sub-arc `r((θ₁, θ₂))`. -/
noncomputable def cutLo (θ₂ θa : ℝ) (m : ℤ) : ℝ := max θa (θ₂ + m * (2 * π))

/-- The upper end of the `m`-th piece. -/
noncomputable def cutHi (θ₁ θb : ℝ) (m : ℤ) : ℝ := min θb (θ₁ + (m + 1) * (2 * π))

/-- **Engine 3, the cut** (`plans/FS131-w4-kernel-plan.md` § 13.1): the arcs of `F` with the open sub-arc `r((θ₁, θ₂))` of `ω(P)`
removed — every arc that is not an arc `circ P 1 θa θb` of `ω(P)` kept whole, each arc of `ω(P)` replaced by its non-degenerate
pieces over the parameter intervals `[θ₂ + 2πm, θ₁ + 2π(m + 1)]` that miss the sub-arc. -/
def cutArcs (P : ℂ) (θ₁ θ₂ : ℝ) : Set Arc :=
  {a | a ∈ F.arcs ∧ ∀ θa θb, a ≠ .circ P 1 θa θb} ∪
    {b | ∃ θa θb, Arc.circ P 1 θa θb ∈ F.arcs ∧ ∃ m : ℤ, cutLo θ₂ θa m < cutHi θ₁ θb m ∧
      b = .circ P 1 (cutLo θ₂ θa m) (cutHi θ₁ θb m)}

/-- The carrier of an arc of `ω(P)`: its points are `r(t)`. -/
theorem carrier_circ_one (P : ℂ) (θa θb : ℝ) : (Arc.circ P 1 θa θb).carrier = ringPt P '' Icc θa θb := by
  ext z
  simp only [Arc.carrier, mem_image, ringPt, Complex.ofReal_one, one_mul]

/-- The pieces of the cut are non-degenerate arcs. -/
theorem cutArcs_nondegenerate {P : ℂ} {θ₁ θ₂ : ℝ} : ∀ b ∈ F.cutArcs P θ₁ θ₂, b.Nondegenerate := by
  rintro b (⟨hb, -⟩ | ⟨θa, θb, ha, m, hlt, rfl⟩)
  · exact F.nondegenerate b hb
  · obtain ⟨-, h1, h2⟩ := F.nondegenerate _ ha
    refine ⟨one_pos, hlt, ?_⟩
    have := le_max_left θa (θ₂ + m * (2 * π))
    have := min_le_left θb (θ₁ + (m + 1) * (2 * π))
    simp only [cutLo, cutHi] at *
    linarith

/-- Each arc of the cut lies in an arc of `F`. -/
theorem cutArcs_subset {P : ℂ} {θ₁ θ₂ : ℝ} :
    ∀ b ∈ F.cutArcs P θ₁ θ₂, ∃ a ∈ F.arcs, b.carrier ⊆ a.carrier := by
  rintro b (⟨hb, -⟩ | ⟨θa, θb, ha, m, hlt, rfl⟩)
  · exact ⟨b, hb, subset_rfl⟩
  · refine ⟨_, ha, ?_⟩
    rw [carrier_circ_one, carrier_circ_one]
    exact image_mono (Icc_subset_Icc (le_max_left _ _) (min_le_left _ _))

/-- An arc of `ω(P)` has finitely many pieces. -/
theorem finite_cut_pieces (θ₁ θ₂ θa θb : ℝ) :
    {m : ℤ | cutLo θ₂ θa m < cutHi θ₁ θb m}.Finite := by
  have hπ := Real.pi_pos
  refine (Set.finite_Icc (⌊(θa - θ₁) / (2 * π)⌋ - 1) ⌈(θb - θ₂) / (2 * π)⌉).subset ?_
  intro m hm
  simp only [mem_setOf_eq, cutLo, cutHi, lt_min_iff, max_lt_iff] at hm
  obtain ⟨⟨-, h1⟩, h2, -⟩ := hm
  constructor
  · have : (θa - θ₁) / (2 * π) < (m : ℝ) + 1 := by
      rw [div_lt_iff₀ (by positivity)]; linarith
    have h3 : ⌊(θa - θ₁) / (2 * π)⌋ < m + 1 := by
      rw [Int.floor_lt]; push_cast; exact this
    omega
  · have : (m : ℝ) < (θb - θ₂) / (2 * π) := by
      rw [lt_div_iff₀ (by positivity)]; linarith
    exact_mod_cast this.le.trans (Int.le_ceil _)

/-- The cut's arcs are locally finite on the domain. -/
theorem cutArcs_locallyFinite {P : ℂ} {θ₁ θ₂ : ℝ} :
    ∀ x ∈ F.dom, ∃ t ∈ 𝓝 x, {b | b ∈ F.cutArcs P θ₁ θ₂ ∧ (b.carrier ∩ t).Nonempty}.Finite := by
  intro x hx
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite x hx
  refine ⟨t, ht, ?_⟩
  set S := {a | a ∈ F.arcs ∧ (a.carrier ∩ t).Nonempty}
  have hpieces : ∀ θa θb : ℝ, {b | ∃ m : ℤ, cutLo θ₂ θa m < cutHi θ₁ θb m ∧
      b = Arc.circ P 1 (cutLo θ₂ θa m) (cutHi θ₁ θb m)}.Finite := fun θa θb =>
    ((finite_cut_pieces θ₁ θ₂ θa θb).image fun m => Arc.circ P 1 (cutLo θ₂ θa m) (cutHi θ₁ θb m)).subset
      fun b ⟨m, hm, hb⟩ => ⟨m, hm, hb.symm⟩
  set pieces : Arc → Set Arc := fun a => {b | ∃ θa θb, a = Arc.circ P 1 θa θb ∧ ∃ m : ℤ, cutLo θ₂ θa m < cutHi θ₁ θb m ∧
      b = Arc.circ P 1 (cutLo θ₂ θa m) (cutHi θ₁ θb m)} with hpdef
  have hS : (S ∩ {a | ∃ θa θb, a = Arc.circ P 1 θa θb}).Finite := hfin.subset inter_subset_left
  have hfp : ∀ a ∈ S ∩ {a | ∃ θa θb, a = Arc.circ P 1 θa θb}, (pieces a).Finite := by
    rintro a ⟨-, θa, θb, rfl⟩
    refine (hpieces θa θb).subset ?_
    rintro b ⟨θa', θb', heq, m, hm, rfl⟩
    simp only [Arc.circ.injEq, true_and] at heq
    obtain ⟨rfl, rfl⟩ := heq
    exact ⟨m, hm, rfl⟩
  refine (hfin.union (hS.biUnion hfp)).subset ?_
  rintro b ⟨⟨hb, -⟩ | ⟨θa, θb, ha, m, hm, rfl⟩, hbt⟩
  · exact Or.inl ⟨hb, hbt⟩
  · refine Or.inr (mem_iUnion₂.mpr ⟨Arc.circ P 1 θa θb, ⟨⟨ha, ?_⟩, θa, θb, rfl⟩, θa, θb, rfl, m, hm, rfl⟩)
    obtain ⟨z, hz, hzt⟩ := hbt
    refine ⟨z, ?_, hzt⟩
    rw [carrier_circ_one] at hz ⊢
    exact image_mono (Icc_subset_Icc (le_max_left _ _) (min_le_left _ _)) hz

/-- A point `r(t)` lies on the open sub-arc `r((θ₁, θ₂))` exactly when some `t − 2πn` lies in `(θ₁, θ₂)`. -/
theorem ringPt_mem_openArc_iff (P : ℂ) {θ₁ θ₂ t : ℝ} :
    ringPt P t ∈ ringPt P '' Ioo θ₁ θ₂ ↔ ∃ n : ℤ, t - n * (2 * π) ∈ Ioo θ₁ θ₂ := by
  constructor
  · rintro ⟨u, hu, heq⟩
    have he : e u = e t := by simpa [ringPt] using heq
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp he.symm
    exact ⟨n, by rw [hn]; simpa using hu⟩
  · rintro ⟨n, hn⟩
    refine ⟨t - n * (2 * π), hn, ?_⟩
    have := e_eq_e_iff.mpr ⟨n, (sub_add_cancel t _).symm⟩
    simp only [ringPt, this]

/-- The cut's pieces miss the open sub-arc. -/
theorem disjoint_piece_openArc {P : ℂ} {θ₁ θ₂ θa θb : ℝ} (m : ℤ) :
    Disjoint (Arc.circ P 1 (cutLo θ₂ θa m) (cutHi θ₁ θb m)).carrier (ringPt P '' Ioo θ₁ θ₂) := by
  rw [carrier_circ_one, Set.disjoint_left]
  rintro _ ⟨t, ht, rfl⟩ hmem
  obtain ⟨n, hn1, hn2⟩ := (ringPt_mem_openArc_iff P).mp hmem
  have hlo : θ₂ + m * (2 * π) ≤ t := (le_max_right _ _).trans ht.1
  have hhi : t ≤ θ₁ + (m + 1) * (2 * π) := ht.2.trans (min_le_right _ _)
  have hπ := Real.pi_pos
  rcases le_or_gt n m with h | h
  · have : (n : ℝ) ≤ m := by exact_mod_cast h
    nlinarith
  · have : (m : ℝ) + 1 ≤ n := by exact_mod_cast h
    nlinarith

/-- **The cut covers what it should**: a point of an arc `circ P 1 θa θb` of `F` off the open sub-arc and off its two ends lies on a
piece. -/
theorem mem_cut_of_mem_circ {P : ℂ} {θ₁ θ₂ θa θb : ℝ} (ha : Arc.circ P 1 θa θb ∈ F.arcs) {x : ℂ}
    (hx : x ∈ (Arc.circ P 1 θa θb).carrier) (hO : x ∉ ringPt P '' Ioo θ₁ θ₂) (hA : x ≠ ringPt P θ₁)
    (hB : x ≠ ringPt P θ₂) : x ∈ ⋃ b ∈ F.cutArcs P θ₁ θ₂, b.carrier := by
  rw [carrier_circ_one] at hx
  obtain ⟨t, ht, rfl⟩ := hx
  have hπ := Real.pi_pos
  set m := ⌊(t - θ₂) / (2 * π)⌋ with hm
  have h1 : (m : ℝ) ≤ (t - θ₂) / (2 * π) := Int.floor_le _
  have h2 : (t - θ₂) / (2 * π) < m + 1 := Int.lt_floor_add_one _
  have h1' : θ₂ + m * (2 * π) ≤ t := by rw [le_div_iff₀ (by positivity)] at h1; linarith
  have h2' : t < θ₂ + (m + 1) * (2 * π) := by rw [div_lt_iff₀ (by positivity)] at h2; linarith
  have h3 : t ≤ θ₁ + (m + 1) * (2 * π) := by
    by_contra h
    push Not at h
    refine hO ((ringPt_mem_openArc_iff P).mpr ⟨m + 1, ?_, ?_⟩) <;> push_cast <;> linarith
  have hlo : cutLo θ₂ θa m ≤ t := max_le ht.1 h1'
  have hhi : t ≤ cutHi θ₁ θb m := le_min ht.2 h3
  rcases lt_or_eq_of_le (hlo.trans hhi) with hlt | heq
  · exact mem_iUnion₂.mpr ⟨_, Or.inr ⟨θa, θb, ha, m, hlt, rfl⟩, by
      rw [carrier_circ_one]; exact ⟨t, ⟨hlo, hhi⟩, rfl⟩⟩
  · exfalso
    have hlo' : cutLo θ₂ θa m = t := le_antisymm hlo (heq ▸ hhi)
    have hhi' : cutHi θ₁ θb m = t := le_antisymm (heq ▸ hlo) hhi
    obtain ⟨-, hab, -⟩ := F.nondegenerate _ ha
    rcases max_choice θa (θ₂ + m * (2 * π)) with h | h <;> rw [cutLo, h] at hlo' <;>
      rcases min_choice θb (θ₁ + (m + 1) * (2 * π)) with h' | h' <;> rw [cutHi, h'] at hhi'
    · linarith
    · exact hA (by rw [← hhi']; simpa [ringPt] using (e_add_int_mul_two_pi θ₁ (m + 1)))
    · exact hB (by rw [← hlo']; simpa [ringPt] using (e_add_int_mul_two_pi θ₂ m))
    · exact hB (by rw [← hlo']; simpa [ringPt] using (e_add_int_mul_two_pi θ₂ m))

/-- Off the open sub-arc and its two ends, the cut's arcs and `F`'s cover the same points. -/
theorem mem_cutArcs_iff {P : ℂ} {θ₁ θ₂ : ℝ} {x : ℂ} (hO : x ∉ ringPt P '' Ioo θ₁ θ₂) (hA : x ≠ ringPt P θ₁)
    (hB : x ≠ ringPt P θ₂) : x ∈ ⋃ b ∈ F.cutArcs P θ₁ θ₂, b.carrier ↔ x ∈ ⋃ a ∈ F.arcs, a.carrier := by
  constructor
  · intro h
    obtain ⟨b, hb, hxb⟩ := mem_iUnion₂.mp h
    obtain ⟨a, ha, hsub⟩ := F.cutArcs_subset b hb
    exact mem_iUnion₂.mpr ⟨a, ha, hsub hxb⟩
  · intro h
    obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp h
    by_cases hc : ∃ θa θb, a = Arc.circ P 1 θa θb
    · obtain ⟨θa, θb, rfl⟩ := hc
      exact F.mem_cut_of_mem_circ ha hxa hO hA hB
    · push Not at hc
      exact mem_iUnion₂.mpr ⟨a, Or.inl ⟨ha, hc⟩, hxa⟩

/-- On the open sub-arc, a point of the cut's arcs lies on an arc of `F` that is not an arc of `ω(P)`. -/
theorem exists_kept_of_mem_openArc {P : ℂ} {θ₁ θ₂ : ℝ} {x : ℂ} (hO : x ∈ ringPt P '' Ioo θ₁ θ₂)
    (hx : x ∈ ⋃ b ∈ F.cutArcs P θ₁ θ₂, b.carrier) : ∃ a ∈ F.arcs, (∀ θa θb, a ≠ .circ P 1 θa θb) ∧ x ∈ a.carrier := by
  obtain ⟨b, hb, hxb⟩ := mem_iUnion₂.mp hx
  rcases hb with ⟨hb, hnot⟩ | ⟨θa, θb, -, m, -, rfl⟩
  · exact ⟨b, hb, hnot, hxb⟩
  · exact absurd hO (Set.disjoint_left.mp (disjoint_piece_openArc m) hxb)

/-! ## The bend: the cut, one new arc, and a lens recoloured -/

/-- Off a locally finite family of arcs, a point has a neighbourhood off the family. -/
theorem eventually_not_mem_arcs {A : Set Arc} {x : ℂ} (hlf : ∃ t ∈ 𝓝 x, {a | a ∈ A ∧ (a.carrier ∩ t).Nonempty}.Finite)
    (hx : x ∉ ⋃ a ∈ A, a.carrier) : ∀ᶠ y in 𝓝 x, y ∉ ⋃ a ∈ A, a.carrier := by
  obtain ⟨t, ht, hfin⟩ := hlf
  have hcl : IsClosed (⋃ a ∈ {a | a ∈ A ∧ (a.carrier ∩ t).Nonempty}, a.carrier) :=
    hfin.isClosed_biUnion fun a _ => a.isClosed_carrier
  have hxn : x ∉ ⋃ a ∈ {a | a ∈ A ∧ (a.carrier ∩ t).Nonempty}, a.carrier := fun h => by
    obtain ⟨a, ⟨ha, -⟩, hxa⟩ := mem_iUnion₂.mp h
    exact hx (mem_iUnion₂.mpr ⟨a, ha, hxa⟩)
  filter_upwards [ht, hcl.isOpen_compl.mem_nhds hxn] with y hyt hyc hy
  obtain ⟨a, ha, hya⟩ := mem_iUnion₂.mp hy
  exact hyc (mem_iUnion₂.mpr ⟨a, ⟨ha, y, hya, hyt⟩, hya⟩)

/-- The bend's arcs (the cut and one new arc) are locally finite on the domain. -/
theorem bendArcs_locallyFinite {P : ℂ} {θ₁ θ₂ : ℝ} (a : Arc) :
    ∀ x ∈ F.dom, ∃ t ∈ 𝓝 x, {b | b ∈ F.cutArcs P θ₁ θ₂ ∪ {a} ∧ (b.carrier ∩ t).Nonempty}.Finite := by
  intro x hx
  obtain ⟨t, ht, hfin⟩ := F.cutArcs_locallyFinite (P := P) (θ₁ := θ₁) (θ₂ := θ₂) x hx
  refine ⟨t, ht, (hfin.union (finite_singleton a)).subset ?_⟩
  rintro b ⟨hb | hb, hbt⟩
  · exact Or.inl ⟨hb, hbt⟩
  · exact Or.inr hb

/-- The bend's colouring: `j` on the lens `L`, `F`'s elsewhere. -/
noncomputable def bendCol (L : Set ℂ) (j : Fin k) : ℂ → Fin k := by
  classical
  exact fun y => if y ∈ L then j else F.col y

theorem bendCol_of_mem {L : Set ℂ} {j : Fin k} {y : ℂ} (hy : y ∈ L) : F.bendCol L j y = j := by
  simp [bendCol, hy]

theorem bendCol_of_not_mem {L : Set ℂ} {j : Fin k} {y : ℂ} (hy : y ∉ L) : F.bendCol L j y = F.col y := by
  simp [bendCol, hy]

/-- **The bend's colouring is locally constant off its arcs**: inside the lens off `ω(P)` by openness; at a point of the open
sub-arc, the lens on one side and `F`'s class of `j` on the other (`hside`, `hcol`); off the lens, `F`'s. -/
theorem bend_hlc {P : ℂ} {θ₁ θ₂ : ℝ} {a : Arc} {L S : Set ℂ} {j : Fin k} (hOL : ringPt P '' Ioo θ₁ θ₂ ⊆ L)
    (hAa : ringPt P θ₁ ∈ a.carrier) (hBa : ringPt P θ₂ ∈ a.carrier) (hcl : closure L ⊆ L ∪ a.carrier)
    (hLsph : ∀ x ∈ L, x ∈ sphere P 1 → x ∈ ringPt P '' Ioo θ₁ θ₂) (hLopen : ∀ x ∈ L, x ∉ sphere P 1 → L ∈ 𝓝 x)
    (hS : Disjoint S (sphere P 1)) (hside : ∀ x ∈ ringPt P '' Ioo θ₁ θ₂, ∀ᶠ y in 𝓝 x, y ∈ L ∨ y ∈ S)
    (hcol : ∀ x ∈ ringPt P '' Ioo θ₁ θ₂, ∀ i, i ≠ j → x ∉ closure (F.region i ∩ S)) :
    ∀ x ∈ F.dom, x ∉ ⋃ b ∈ F.cutArcs P θ₁ θ₂ ∪ {a}, b.carrier → ∀ᶠ y in 𝓝 x, F.bendCol L j y = F.bendCol L j x := by
  intro x hx hxA
  have hev := eventually_not_mem_arcs (F.bendArcs_locallyFinite a x hx) hxA
  have hxa : x ∉ a.carrier := fun h => hxA (mem_iUnion₂.mpr ⟨a, Or.inr rfl, h⟩)
  have hxcut : x ∉ ⋃ b ∈ F.cutArcs P θ₁ θ₂, b.carrier := fun h => by
    obtain ⟨b, hb, hxb⟩ := mem_iUnion₂.mp h
    exact hxA (mem_iUnion₂.mpr ⟨b, Or.inl hb, hxb⟩)
  by_cases hxL : x ∈ L
  · rw [F.bendCol_of_mem hxL]
    by_cases hsph : x ∈ sphere P 1
    · have hxO := hLsph x hxL hsph
      have hfin : ∀ᶠ y in 𝓝 x, ∀ i, i ≠ j → y ∉ F.region i ∩ S := by
        rw [eventually_all]
        intro i
        by_cases hij : i = j
        · exact Filter.Eventually.of_forall fun _ h => absurd hij h
        · filter_upwards [isClosed_closure.isOpen_compl.mem_nhds (hcol x hxO i hij)] with y hy _ hyR
          exact hy (subset_closure hyR)
      filter_upwards [hev, hside x hxO, hfin, F.isOpen_dom.mem_nhds hx] with y hyA hyLS hyR hyd
      by_cases hyL : y ∈ L
      · exact F.bendCol_of_mem hyL
      · have hyS : y ∈ S := hyLS.resolve_left hyL
        rw [F.bendCol_of_not_mem hyL]
        have hyF : y ∉ ⋃ b ∈ F.arcs, b.carrier := by
          intro h
          obtain ⟨b, hb, hyb⟩ := mem_iUnion₂.mp h
          by_cases hc : ∃ θa θb, b = Arc.circ P 1 θa θb
          · obtain ⟨θa, θb, rfl⟩ := hc
            rw [carrier_circ_one] at hyb
            obtain ⟨t, -, rfl⟩ := hyb
            exact Set.disjoint_left.mp hS hyS (ringPt_mem_sphere P t)
          · push Not at hc
            exact hyA (mem_iUnion₂.mpr ⟨b, Or.inl (Or.inl ⟨hb, hc⟩), hyb⟩)
        by_contra hne
        exact hyR (F.col y) hne ⟨⟨⟨hyd, hyF⟩, rfl⟩, hyS⟩
    · filter_upwards [hLopen x hxL hsph] with y hy
      exact F.bendCol_of_mem hy
  · have hxcl : x ∉ closure L := fun h => (hcl h).elim hxL hxa
    have hxF : x ∉ ⋃ b ∈ F.arcs, b.carrier := by
      intro h
      refine hxcut ((F.mem_cutArcs_iff (fun h' => hxL (hOL h')) (fun h' => hxa (h' ▸ hAa))
        (fun h' => hxa (h' ▸ hBa))).mpr h)
    filter_upwards [F.locallyConstant x hx hxF, isClosed_closure.isOpen_compl.mem_nhds hxcl] with y hy hyL
    have hyL' : y ∉ L := fun h => hyL (subset_closure h)
    rw [F.bendCol_of_not_mem hyL', F.bendCol_of_not_mem hxL, hy]

/-- **The bent map**: `F`'s domain, the cut of the open sub-arc `r((θ₁, θ₂))` of `ω(P)` together with one new arc `a`, and the
colour `j` on the lens `L`. -/
noncomputable def bendMap (P : ℂ) (θ₁ θ₂ : ℝ) (a : Arc) (L : Set ℂ) (j : Fin k) (ha : a.Nondegenerate)
    (hlc : ∀ x ∈ F.dom, x ∉ ⋃ b ∈ F.cutArcs P θ₁ θ₂ ∪ {a}, b.carrier → ∀ᶠ y in 𝓝 x, F.bendCol L j y = F.bendCol L j x) :
    ArcMap k where
  dom := F.dom
  isOpen_dom := F.isOpen_dom
  arcs := F.cutArcs P θ₁ θ₂ ∪ {a}
  nondegenerate := by
    rintro b (hb | hb)
    · exact F.cutArcs_nondegenerate b hb
    · rw [mem_singleton_iff.mp hb]; exact ha
  locallyFinite := F.bendArcs_locallyFinite a
  col := F.bendCol L j
  locallyConstant := hlc

section BendMap

variable {F} {P : ℂ} {θ₁ θ₂ : ℝ} {a : Arc} {L : Set ℂ} {j : Fin k} {ha : a.Nondegenerate}
  {hlc : ∀ x ∈ F.dom, x ∉ ⋃ b ∈ F.cutArcs P θ₁ θ₂ ∪ {a}, b.carrier → ∀ᶠ y in 𝓝 x, F.bendCol L j y = F.bendCol L j x}

/-- The bent map's interior points off the lens are `F`'s, with `F`'s colours. -/
theorem bendMap_interiorPts (hOL : ringPt P '' Ioo θ₁ θ₂ ⊆ L) (hAa : ringPt P θ₁ ∈ a.carrier)
    (hBa : ringPt P θ₂ ∈ a.carrier) {z : ℂ} (hz : z ∈ (F.bendMap P θ₁ θ₂ a L j ha hlc).interiorPts) (hzL : z ∉ L) :
    z ∈ F.interiorPts ∧ (F.bendMap P θ₁ θ₂ a L j ha hlc).col z = F.col z := by
  obtain ⟨hzd, hzA⟩ := hz
  have hza : z ∉ a.carrier := fun h => hzA (mem_iUnion₂.mpr ⟨a, Or.inr rfl, h⟩)
  have hzcut : z ∉ ⋃ b ∈ F.cutArcs P θ₁ θ₂, b.carrier := fun h => by
    obtain ⟨b, hb, hzb⟩ := mem_iUnion₂.mp h
    exact hzA (mem_iUnion₂.mpr ⟨b, Or.inl hb, hzb⟩)
  refine ⟨⟨hzd, fun h => hzcut ((F.mem_cutArcs_iff (fun h' => hzL (hOL h')) (fun h' => hza (h' ▸ hAa))
    (fun h' => hza (h' ▸ hBa))).mpr h)⟩, F.bendCol_of_not_mem hzL⟩

/-- **The bent map agrees with `F` off `U`** when the lens, the new arc and the closed arc lie in `U`. -/
theorem bendMap_agreesOff (h12 : θ₁ < θ₂) {U : Set ℂ} (hLU : L ⊆ U) (haU : a.carrier ⊆ U) (hαU : ringArc P θ₁ θ₂ ⊆ U) :
    (F.bendMap P θ₁ θ₂ a L j ha hlc).AgreesOff F U := by
  refine ⟨rfl, fun z hz => ⟨?_, (F.bendCol_of_not_mem fun h => hz (hLU h)).symm⟩⟩
  have hzO : z ∉ ringPt P '' Ioo θ₁ θ₂ := fun h => hz (hαU (image_mono Ioo_subset_Icc_self h))
  have hzA : z ≠ ringPt P θ₁ := by rintro rfl; exact hz (hαU ⟨θ₁, ⟨le_rfl, h12.le⟩, rfl⟩)
  have hzB : z ≠ ringPt P θ₂ := by rintro rfl; exact hz (hαU ⟨θ₂, ⟨h12.le, le_rfl⟩, rfl⟩)
  have hza : z ∉ a.carrier := fun h => hz (haU h)
  have key := F.mem_cutArcs_iff hzO hzA hzB
  show z ∈ F.dom \ _ ↔ z ∈ F.dom \ _
  refine ⟨fun ⟨hd, hn⟩ => ⟨hd, fun h => ?_⟩, fun ⟨hd, hn⟩ => ⟨hd, fun h => hn ?_⟩⟩
  · obtain ⟨b, hb | hb, hzb⟩ := mem_iUnion₂.mp h
    · exact hn (key.mp (mem_iUnion₂.mpr ⟨b, hb, hzb⟩))
    · exact hza (mem_singleton_iff.mp hb ▸ hzb)
  · obtain ⟨b, hb, hzb⟩ := mem_iUnion₂.mp (key.mpr h)
    exact mem_iUnion₂.mpr ⟨b, Or.inl hb, hzb⟩

/-- **The bent map creates no unit arc** (engine 2): its `Γ` lies in `F`'s and the new arc, which is not a unit arc. -/
theorem bendMap_ringArcsWithin (hau : ¬ a.IsUnitArc) : (F.bendMap P θ₁ θ₂ a L j ha hlc).RingArcsWithin F := by
  refine ringArcsWithin_of_Γ_subset rfl (A' := {a}) (fun b hb => mem_singleton_iff.mp hb ▸ ha)
    (fun x _ => ⟨univ, univ_mem, (finite_singleton a).subset fun b hb => hb.1⟩)
    (fun b hb => mem_singleton_iff.mp hb ▸ hau) ?_
  rintro z ⟨hzd, hz⟩
  obtain ⟨b, hb | hb, hzb⟩ := mem_iUnion₂.mp hz
  · obtain ⟨a', ha', hsub⟩ := F.cutArcs_subset b hb
    exact Or.inl ⟨hzd, mem_iUnion₂.mpr ⟨a', ha', hsub hzb⟩⟩
  · exact Or.inr (mem_iUnion₂.mpr ⟨a, rfl, mem_singleton_iff.mp hb ▸ hzb⟩)

/-- **The bent map is valid** (engine 1) when the lens is clear for `j` in `F` and holds no unit pair. -/
theorem bendMap_valid (hF : F.Valid) (h12 : θ₁ < θ₂) {U : Set ℂ} (hLU : L ⊆ U) (haU : a.carrier ⊆ U)
    (hαU : ringArc P θ₁ θ₂ ⊆ U) (hOL : ringPt P '' Ioo θ₁ θ₂ ⊆ L) (hAa : ringPt P θ₁ ∈ a.carrier)
    (hBa : ringPt P θ₂ ∈ a.carrier) (hclear : ∀ z ∈ L, F.IsClear j z) (hLL : ∀ z ∈ L, ∀ z' ∈ L, dist z z' ≠ 1) :
    (F.bendMap P θ₁ θ₂ a L j ha hlc).Valid := by
  set F' := F.bendMap P θ₁ θ₂ a L j ha hlc
  have hjL : ∀ z ∈ L, F'.col z = j := fun z hz => F.bendCol_of_mem hz
  have hoff : ∀ {z}, z ∈ (F.bendMap P θ₁ θ₂ a L j ha hlc).interiorPts → z ∉ L →
      z ∈ F.interiorPts ∧ (F.bendMap P θ₁ θ₂ a L j ha hlc).col z = F.col z :=
    fun hz hzL => bendMap_interiorPts hOL hAa hBa hz hzL
  refine Valid.of_agreesOff hF (bendMap_agreesOff h12 hLU haU hαU) (fun z ⟨_, hz⟩ => ?_) ?_
  · by_cases hzL : z ∈ L
    · rw [hjL z hzL]; exact hclear z hzL
    · obtain ⟨hzi, hzc⟩ := hoff hz hzL
      rw [hzc]
      intro y hy hzy
      exact hF z hzi y hy.1 hzy hy.2.symm
  · rintro z ⟨_, hz⟩ y ⟨_, hy⟩ hzy hcol
    by_cases hzL : z ∈ L <;> by_cases hyL : y ∈ L
    · exact hLL z hzL y hyL hzy
    · obtain ⟨hyi, hyc⟩ := hoff hy hyL
      refine hclear z hzL y ⟨hyi, ?_⟩ hzy
      show F.col y = j
      rw [← hyc, ← hcol, hjL z hzL]
    · obtain ⟨hzi, hzc⟩ := hoff hz hzL
      refine hclear y hyL z ⟨hzi, ?_⟩ (by rw [dist_comm]; exact hzy)
      show F.col z = j
      rw [← hzc, hcol, hjL y hyL]
    · obtain ⟨hzi, hzc⟩ := hoff hz hzL
      obtain ⟨hyi, hyc⟩ := hoff hy hyL
      exact hF z hzi y hyi hzy (by rw [← hzc, ← hyc]; exact hcol)

/-- The bent map's classes: no colour but `j` gains points, and `j` only on the lens. -/
theorem bendMap_region (hOL : ringPt P '' Ioo θ₁ θ₂ ⊆ L) (hAa : ringPt P θ₁ ∈ a.carrier)
    (hBa : ringPt P θ₂ ∈ a.carrier) :
    (∀ i, i ≠ j → (F.bendMap P θ₁ θ₂ a L j ha hlc).region i ⊆ F.region i) ∧
      (F.bendMap P θ₁ θ₂ a L j ha hlc).region j ⊆ F.region j ∪ L := by
  have hoff : ∀ {z}, z ∈ (F.bendMap P θ₁ θ₂ a L j ha hlc).interiorPts → z ∉ L →
      z ∈ F.interiorPts ∧ (F.bendMap P θ₁ θ₂ a L j ha hlc).col z = F.col z :=
    fun hz hzL => bendMap_interiorPts hOL hAa hBa hz hzL
  refine ⟨fun i hij z ⟨hz, hzc⟩ => ?_, fun z ⟨hz, hzc⟩ => ?_⟩
  · have hzL : z ∉ L := fun h => hij (by rw [← (show _ = i from hzc)]; exact F.bendCol_of_mem h)
    obtain ⟨hzi, hcz⟩ := hoff hz hzL
    exact ⟨hzi, by show F.col z = i; rw [← hcz]; exact hzc⟩
  · by_cases hzL : z ∈ L
    · exact Or.inr hzL
    · obtain ⟨hzi, hcz⟩ := hoff hz hzL
      exact Or.inl ⟨hzi, by show F.col z = j; rw [← hcz]; exact hzc⟩

/-- **The open sub-arc leaves `ω(P)`'s arcs**: in the bent map no point of `r((θ₁, θ₂))` lies on an arc of `Γ` on `ω(P)` — near it
the cut leaves only arcs of `F` that are not arcs of `ω(P)`, finitely many, each meeting `ω(P)` finitely often. -/
theorem bendMap_not_onRingArc (hdom : ringPt P '' Ioo θ₁ θ₂ ⊆ F.dom)
    (haO : Disjoint a.carrier (ringPt P '' Ioo θ₁ θ₂)) :
    ∀ θ ∈ Ioo θ₁ θ₂, ¬ (F.bendMap P θ₁ θ₂ a L j ha hlc).OnRingArc P (ringPt P θ) := by
  rintro θ hθ ⟨a', b', hab, ⟨t₀, ht₀, heq⟩, hsub⟩
  have hπ := Real.pi_pos
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite _ (hdom ⟨θ, hθ, rfl⟩)
  obtain ⟨r, hr, hrt⟩ := Metric.mem_nhds_iff.mp ht
  obtain ⟨n, hn⟩ := e_eq_e_iff.mp (show e t₀ = e θ by simpa [ringPt] using heq)
  set η := min r (min (θ₂ - θ) (θ - θ₁)) with hη
  have hη0 : 0 < η := lt_min hr (lt_min (by linarith [hθ.2]) (by linarith [hθ.1]))
  -- a sub-interval of `[a', b']` within `η` of `t₀`
  obtain ⟨lo, hi, hlh, hJ⟩ : ∃ lo hi, lo < hi ∧ Icc lo hi ⊆ Icc a' b' ∩ Ioo (t₀ - η) (t₀ + η) := by
    rcases lt_or_eq_of_le ht₀.2 with h | h
    · refine ⟨t₀, min b' (t₀ + η / 2), lt_min h (by linarith), fun u hu => ⟨⟨by linarith [ht₀.1, hu.1], ?_⟩, by linarith [hu.1], ?_⟩⟩
      · linarith [hu.2, min_le_left b' (t₀ + η / 2)]
      · linarith [hu.2, min_le_right b' (t₀ + η / 2)]
    · refine ⟨max a' (t₀ - η / 2), t₀, max_lt (by linarith) (by linarith), fun u hu => ⟨⟨?_, by linarith [hu.2]⟩, ?_, by linarith [hu.2]⟩⟩
      · linarith [hu.1, le_max_left a' (t₀ - η / 2)]
      · linarith [hu.1, le_max_right a' (t₀ - η / 2)]
  -- the finitely many points of `ω(P)` on the arcs of `F` near `r(θ)` that are not arcs of `ω(P)`
  set Cf := ⋃ b ∈ {b | b ∈ F.arcs ∧ (b.carrier ∩ t).Nonempty ∧ ∀ θa θb, b ≠ Arc.circ P 1 θa θb}, b.carrier ∩ sphere P 1
  have hCf : Cf.Finite := by
    refine (hfin.subset fun b hb => ⟨hb.1, hb.2.1⟩).biUnion fun b hb => ?_
    rcases Arc.finite_inter_sphere_or_eq_circ b (F.nondegenerate b hb.1) P with h | ⟨θa, θb, h⟩
    · exact h
    · exact absurd h (hb.2.2 θa θb)
  have hy0 : ringPt P lo ∈ ringArc P lo hi := ⟨lo, ⟨le_rfl, hlh.le⟩, rfl⟩
  have hne : (ringArc P lo hi \ Cf).Nonempty := by
    by_contra h
    rw [not_nonempty_iff_eq_empty] at h
    have := mem_closure_ringArc_diff_finite hlh hCf hy0
    rw [h, closure_empty] at this
    exact this
  obtain ⟨_, ⟨u, hu, rfl⟩, huC⟩ := hne
  have huJ := hJ hu
  have huO : ringPt P u ∈ ringPt P '' Ioo θ₁ θ₂ := by
    refine (ringPt_mem_openArc_iff P).mpr ⟨n, ?_, ?_⟩
    · have := huJ.2.1; have := min_le_right r (min (θ₂ - θ) (θ - θ₁)); have := min_le_right (θ₂ - θ) (θ - θ₁); linarith
    · have := huJ.2.2; have := min_le_right r (min (θ₂ - θ) (θ - θ₁)); have := min_le_left (θ₂ - θ) (θ - θ₁); linarith
  have huΓ := hsub ⟨u, huJ.1, rfl⟩
  obtain ⟨b, hb | hb, hub⟩ := mem_iUnion₂.mp huΓ.2
  · obtain ⟨a₁, ha₁, hnot, hua₁⟩ := F.exists_kept_of_mem_openArc huO (mem_iUnion₂.mpr ⟨b, hb, hub⟩)
    have hut : ringPt P u ∈ t := by
      refine hrt ?_
      rw [mem_ball, dist_eq_norm, ringPt, ringPt, show P + e u - (P + e θ) = e u - e θ by ring]
      have h1 : e θ = e t₀ := by simpa [ringPt] using heq.symm
      rw [h1]
      calc ‖e u - e t₀‖ ≤ |u - t₀| := norm_e_sub_e_le u t₀
        _ < η := by rw [abs_lt]; constructor <;> linarith [huJ.2.1, huJ.2.2]
        _ ≤ r := min_le_left _ _
    exact huC (mem_iUnion₂.mpr ⟨a₁, ⟨ha₁, ⟨_, hua₁, hut⟩, hnot⟩, hua₁, ringPt_mem_sphere P u⟩)
  · exact Set.disjoint_left.mp haO (mem_singleton_iff.mp hb ▸ hub) huO

end BendMap

/-- A point `P + ρ e(β)` with `β ∈ [θ₁, θ₂]` and `|1 − ρ| < ε` lies within `ε` of the closed arc. -/
theorem mem_thickening_ringArc_of_polar {P z : ℂ} {θ₁ θ₂ β ρ ε : ℝ} (hβ : β ∈ Icc θ₁ θ₂) (hz : z = P + (ρ : ℂ) * e β)
    (hρ : |1 - ρ| < ε) : z ∈ thickening ε (ringArc P θ₁ θ₂) := by
  rw [Metric.mem_thickening_iff]
  exact ⟨ringPt P β, ⟨β, hβ, rfl⟩, by rw [hz, dist_polar_ringPt]; exact hρ⟩

/-- **The toward lens point is clear for the outer colour** (N2-TOWARD's clearness): a point `P + (1 − s) e(φ)` of the lens profile
`0 < s ≤ ψ Δ(φ)` is at distance `≠ 1` from the outer class — a near point of the class (inside a unit disc about the arc) lies in
`B̄(A, 1) ∩ B̄(B, 1)` (N2-SIGN), within `< 1` of the lens point (N2-ENV near); a far one lies, by N2-ENV toward, in `B(P, r)`, which
the class misses. -/
theorem toward_clear (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') {r ψ₁ ψ₂ : ℝ}
    (hr : ∀ y ∈ F.region c', r ≤ dist y P)
    (henv : ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ₁ * min (φ - θ₁) (θ₂ - φ) →
      closedBall (P + (1 - s) * e φ) 1 \ ⋃ θ ∈ Icc θ₁ θ₂, ball (ringPt P θ) 1 ⊆ ball P r)
    (hnear : ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ₂ * min (φ - θ₁) (θ₂ - φ) →
      ∀ p ∈ closedBall (ringPt P θ₁) 1 ∩ closedBall (ringPt P θ₂) 1, dist p (P + (1 - s) * e φ) < 1)
    {φ s : ℝ} (hφ : φ ∈ Ioo θ₁ θ₂) (hs : 0 < s) (hsψ₁ : s ≤ ψ₁ * min (φ - θ₁) (θ₂ - φ))
    (hsψ₂ : s ≤ ψ₂ * min (φ - θ₁) (θ₂ - φ)) :
    F.IsClear c' (P + (1 - s) * e φ) := by
  intro y hy hzy
  have h12 : θ₁ < θ₂ := hA.1
  have hcont : Continuous fun θ : ℝ => dist y (ringPt P θ) := by unfold ringPt e; fun_prop
  by_cases hU : y ∈ ⋃ θ ∈ Icc θ₁ θ₂, ball (ringPt P θ) 1
  · obtain ⟨θ₀, hθ₀, hy0⟩ := mem_iUnion₂.mp hU
    rw [mem_ball] at hy0
    rcases n2_sign hF hA (Or.inr rfl) hy with hlt | hgt
    · have hle := le_on_Icc_of_Ioo hcont h12 fun θ hθ => (hlt θ hθ).le
      have := hnear φ hφ s hs hsψ₂ y ⟨mem_closedBall.mpr (hle θ₁ ⟨le_rfl, h12.le⟩),
        mem_closedBall.mpr (hle θ₂ ⟨h12.le, le_rfl⟩)⟩
      rw [dist_comm] at this; linarith
    · have hge := ge_on_Icc_of_Ioo hcont h12 fun θ hθ => (hgt θ hθ).le
      linarith [hge θ₀ hθ₀]
  · have hyb : y ∈ closedBall (P + (1 - s) * e φ) 1 := by rw [mem_closedBall, dist_comm]; exact hzy.le
    have := henv φ hφ s hs hsψ₁ ⟨hyb, hU⟩
    rw [mem_ball] at this
    linarith [hr y hy]

/-- **FS112-N2-BENDS**, the toward bend (scratch copy). -/
theorem bend_toward' (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hout : c' ∉ F.coloursAt P) {ε : ℝ} (hε : 0 < ε) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (thickening ε (ringArc P θ₁ θ₂)) ∧ F'.RingArcsWithin F ∧
      (∀ θ ∈ Ioo θ₁ θ₂, ¬ F'.OnRingArc P (ringPt P θ)) ∧ (∀ j, j ≠ c' → F'.region j ⊆ F.region j) ∧
      F'.region c' ⊆ F.region c' ∪ (thickening ε (ringArc P θ₁ θ₂) ∩ closedBall P 1) := by
  have h12 : θ₁ < θ₂ := hA.1
  have hℓ := l60_le hF hA
  have hπ := Real.pi_pos
  set φ := (θ₁ + θ₂) / 2 with hφdef
  set h := (θ₂ - θ₁) / 2 with hhdef
  have hh : 0 < h := by rw [hhdef]; linarith
  have hh6 : h ≤ π / 6 := by rw [hhdef]; linarith
  have hh2 : h < π / 2 := by linarith
  have hcosh : 0 < Real.cos h := Real.cos_pos_of_mem_Ioo ⟨by linarith, hh2⟩
  -- the outer class keeps a positive distance from `P`
  obtain ⟨r, hr, hrc⟩ : ∃ r > 0, ∀ y ∈ F.region c', r ≤ dist y P := by
    have : P ∉ closure (F.region c') := hout
    rw [Metric.mem_closure_iff] at this
    push Not at this
    obtain ⟨r, hr, hr'⟩ := this
    exact ⟨r, hr, fun y hy => by rw [dist_comm]; exact hr' y hy⟩
  obtain ⟨ψ₁, hψ₁, henv⟩ := n2_env_toward P h12 hℓ hr
  obtain ⟨ψ₂, hψ₂, hnear⟩ := n2_env_near P h12 hℓ
  set d := min (min ψ₁ ψ₂) ε / 4 with hddef
  have hd : 0 < d := by positivity
  have hd1 : 2 * d ≤ ψ₁ := by have := min_le_left (min ψ₁ ψ₂) ε; have := min_le_left ψ₁ ψ₂; rw [hddef]; linarith
  have hd2 : 2 * d ≤ ψ₂ := by have := min_le_left (min ψ₁ ψ₂) ε; have := min_le_right ψ₁ ψ₂; rw [hddef]; linarith
  have hdε : 2 * d * h < ε := by
    have := min_le_right (min ψ₁ ψ₂) ε
    have h1 : 2 * d ≤ ε / 2 := by rw [hddef]; linarith
    have h2 : h < 1 := by linarith [Real.pi_lt_four]
    nlinarith
  set C := P - (d : ℂ) * e φ with hCdef
  set L : Set ℂ := {z | dist z P ≤ 1 ∧ 1 + 2 * d * Real.cos h + d ^ 2 < dist z C ^ 2} with hLdef
  set R := √(1 + 2 * d * Real.cos h + d ^ 2) with hRdef
  have hRsq : R ^ 2 = 1 + 2 * d * Real.cos h + d ^ 2 := Real.sq_sqrt (by positivity)
  set a := Arc.circ C R (φ - Real.arccos ((d + Real.cos h) / R)) (φ + Real.arccos ((d + Real.cos h) / R)) with hadef
  have hcar : a.carrier = {z | dist z C = R ∧ dist z P ≤ 1} := toward_carrier P hd hcosh
  set O := ringPt P '' Ioo θ₁ θ₂ with hOdef
  set U := thickening ε (ringArc P θ₁ θ₂) with hUdef
  -- the arc's points against the bending circle
  have hring : ∀ θ, dist (ringPt P θ) C ^ 2 = 1 + 2 * d * Real.cos (θ - φ) + d ^ 2 := by
    intro θ; rw [hCdef, dist_sq_sub_dir, re_frameDir_ringPt, dist_ringPt]; ring
  have hOL : O ⊆ L := by
    rintro _ ⟨θ, hθ, rfl⟩
    refine ⟨(dist_ringPt P θ).le, ?_⟩
    rw [hring]
    have habs : |θ - φ| < h := abs_lt.mpr ⟨by rw [hφdef, hhdef]; linarith [hθ.1], by rw [hφdef, hhdef]; linarith [hθ.2]⟩
    have := Real.cos_lt_cos_of_nonneg_of_le_pi (abs_nonneg _) (by linarith) habs
    rw [Real.cos_abs] at this
    nlinarith
  have hend : ∀ θ, (θ = θ₁ ∨ θ = θ₂) → ringPt P θ ∈ a.carrier := by
    intro θ hθ
    rw [hcar]
    refine ⟨?_, (dist_ringPt P θ).le⟩
    have hc : Real.cos (θ - φ) = Real.cos h := by
      rcases hθ with h1 | h1 <;> rw [h1]
      · rw [show θ₁ - φ = -h by rw [hφdef, hhdef]; ring, Real.cos_neg]
      · rw [show θ₂ - φ = h by rw [hφdef, hhdef]; ring]
    have := hring θ
    rw [hc, ← hRsq] at this
    exact (pow_left_inj₀ dist_nonneg (Real.sqrt_nonneg _) two_ne_zero).mp this
  -- polar forms
  have hpolI : ∀ z, |arg ((z - P) * starRingEnd ℂ (e φ))| ≤ h →
      φ + arg ((z - P) * starRingEnd ℂ (e φ)) ∈ Icc θ₁ θ₂ := fun z hb =>
    ⟨by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_le.mp hb).1], by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_le.mp hb).2]⟩
  have hpolO : ∀ z, |arg ((z - P) * starRingEnd ℂ (e φ))| < h →
      φ + arg ((z - P) * starRingEnd ℂ (e φ)) ∈ Ioo θ₁ θ₂ := fun z hb =>
    ⟨by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_lt.mp hb).1], by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_lt.mp hb).2]⟩
  have hU1 : ∀ z, dist z P ≤ 1 → |arg ((z - P) * starRingEnd ℂ (e φ))| ≤ h →
      1 - dist z P ≤ 2 * d * (h - |arg ((z - P) * starRingEnd ℂ (e φ))|) → z ∈ U := by
    intro z hz1 hb hs
    refine mem_thickening_ringArc_of_polar (hpolI z hb) (eq_polar_frameDir P z φ) ?_
    rw [abs_of_nonneg (by linarith)]
    have : 0 ≤ |arg ((z - P) * starRingEnd ℂ (e φ))| := abs_nonneg _
    nlinarith
  have hLU : L ⊆ U := fun z hz => by
    obtain ⟨hb, hs⟩ := toward_polar_strict hd hh hh2 hz.1 hz.2
    exact hU1 z hz.1 hb.le hs.le
  have haU : a.carrier ⊆ U := fun z hz => by
    rw [hcar] at hz
    obtain ⟨hb, hs⟩ := toward_polar hd hh hh2 hz.2 (by rw [hz.1, hRsq])
    exact hU1 z hz.2 hb hs
  have hαU : ringArc P θ₁ θ₂ ⊆ U := self_subset_thickening hε _
  have haO : Disjoint a.carrier O := by
    rw [Set.disjoint_left]
    intro z hz hzO
    rw [hcar] at hz
    have := (hOL hzO).2
    rw [hz.1, hRsq] at this
    exact lt_irrefl _ this
  have hcl : closure L ⊆ L ∪ a.carrier := by
    have hK : IsClosed {z : ℂ | dist z P ≤ 1 ∧ 1 + 2 * d * Real.cos h + d ^ 2 ≤ dist z C ^ 2} :=
      (isClosed_le (continuous_id.dist continuous_const) continuous_const).inter
        (isClosed_le continuous_const ((continuous_id.dist continuous_const).pow 2))
    intro z hz
    obtain ⟨hz1, hz2⟩ := closure_minimal (show L ⊆ {z : ℂ | dist z P ≤ 1 ∧ 1 + 2 * d * Real.cos h + d ^ 2 ≤ dist z C ^ 2}
      from fun y hy => ⟨hy.1, hy.2.le⟩) hK hz
    rcases lt_or_eq_of_le hz2 with hlt | heq
    · exact Or.inl ⟨hz1, hlt⟩
    · refine Or.inr ?_
      rw [hcar]
      refine ⟨?_, hz1⟩
      rw [← hRsq] at heq
      exact (pow_left_inj₀ dist_nonneg (Real.sqrt_nonneg _) two_ne_zero).mp heq.symm
  have hLsph : ∀ x ∈ L, x ∈ sphere P 1 → x ∈ O := by
    intro x hx hsph
    rw [mem_sphere] at hsph
    obtain ⟨hb, -⟩ := toward_polar_strict hd hh hh2 hx.1 hx.2
    refine ⟨_, hpolO x hb, ?_⟩
    have := eq_polar_frameDir P x φ
    rw [hsph, Complex.ofReal_one, one_mul] at this
    rw [ringPt, ← this]
  have hLopen : ∀ x ∈ L, x ∉ sphere P 1 → L ∈ 𝓝 x := by
    intro x hx hsph
    have hlt : dist x P < 1 := lt_of_le_of_ne hx.1 hsph
    have hopen : IsOpen {z : ℂ | dist z P < 1 ∧ 1 + 2 * d * Real.cos h + d ^ 2 < dist z C ^ 2} :=
      (isOpen_lt (continuous_id.dist continuous_const) continuous_const).inter
        (isOpen_lt continuous_const ((continuous_id.dist continuous_const).pow 2))
    exact Filter.mem_of_superset (hopen.mem_nhds ⟨hlt, hx.2⟩) fun z hz => ⟨hz.1.le, hz.2⟩
  have hS : Disjoint (closedBall P 1)ᶜ (sphere P 1) :=
    Set.disjoint_left.mpr fun z hz hs => hz (sphere_subset_closedBall hs)
  have hside : ∀ x ∈ O, ∀ᶠ y in 𝓝 x, y ∈ L ∨ y ∈ (closedBall P 1)ᶜ := by
    intro x hx
    have hopen : IsOpen {z : ℂ | 1 + 2 * d * Real.cos h + d ^ 2 < dist z C ^ 2} :=
      isOpen_lt continuous_const ((continuous_id.dist continuous_const).pow 2)
    filter_upwards [hopen.mem_nhds (hOL hx).2] with y hy
    by_cases hy1 : dist y P ≤ 1
    · exact Or.inl ⟨hy1, hy⟩
    · exact Or.inr fun h' => hy1 (mem_closedBall.mp h')
  have hcol : ∀ x ∈ O, ∀ i, i ≠ c' → x ∉ closure (F.region i ∩ (closedBall P 1)ᶜ) := by
    rintro _ ⟨θ, hθ, rfl⟩ i hi hcl'
    have hout' := (hA.2.2 θ hθ).2
    have : i ∈ F.outerColours P (ringPt P θ) := by rw [outerColours, mem_setOf_eq, Set.sdiff_eq]; exact hcl'
    rw [hout'] at this
    exact hi this
  have hclear : ∀ z ∈ L, F.IsClear c' z := by
    intro z hz
    by_cases hsph : dist z P = 1
    · obtain ⟨θ, hθ, rfl⟩ := hLsph z hz (mem_sphere.mpr hsph)
      have hcl' : ringPt P θ ∈ closure (F.region c') := by
        have : c' ∈ F.outerColours P (ringPt P θ) := by rw [(hA.2.2 θ hθ).2]; rfl
        exact closure_mono sdiff_subset this
      intro y hy hzy
      exact ne1_region hF hcl' hy (by rw [dist_comm]; exact hzy)
    · obtain ⟨hb, hs⟩ := toward_polar_strict hd hh hh2 hz.1 hz.2
      set b := arg ((z - P) * starRingEnd ℂ (e φ)) with hbdef
      have hs0 : 0 < 1 - dist z P := by have := lt_of_le_of_ne hz.1 hsph; linarith
      have hmin : min (φ + b - θ₁) (θ₂ - (φ + b)) = h - |b| := by
        rw [show φ + b - θ₁ = h + b by rw [hφdef, hhdef]; ring, show θ₂ - (φ + b) = h - b by rw [hφdef, hhdef]; ring]
        exact min_add_sub_eq h b
      have hzeq : z = P + (1 - ((1 - dist z P : ℝ) : ℂ)) * e (φ + b) := by
        have := eq_polar_frameDir P z φ
        rw [← hbdef] at this
        calc z = P + (dist z P : ℂ) * e (φ + b) := this
          _ = _ := by push_cast; ring
      have hΔ : 0 ≤ h - |b| := by linarith
      rw [hzeq]
      refine F.toward_clear hF hA hrc henv hnear (hpolO z hb) hs0 ?_ ?_ <;> rw [hmin]
      · exact (hs.trans_le (mul_le_mul_of_nonneg_right hd1 hΔ)).le
      · exact (hs.trans_le (mul_le_mul_of_nonneg_right hd2 hΔ)).le
  have hLL : ∀ z ∈ L, ∀ z' ∈ L, dist z z' ≠ 1 := fun z hz z' hz' => toward_pairs hd hh hh6 hz.1 hz.2 hz'.1 hz'.2
  have hdom : O ⊆ F.dom := fun x hx => (hA.2.1 (image_mono Ioo_subset_Icc_self hx)).1
  have hRpos : 0 < R := Real.sqrt_pos.2 (by positivity)
  have hκ : (d + Real.cos h) / R < 1 := by
    rw [div_lt_one hRpos]
    refine Real.lt_sqrt_of_sq_lt ?_
    have : Real.cos h ^ 2 < 1 := by
      have hsin : 0 < Real.sin h := Real.sin_pos_of_pos_of_lt_pi hh (by linarith)
      nlinarith [Real.sin_sq_add_cos_sq h]
    nlinarith
  have ha : a.Nondegenerate := ⟨hRpos, by have := Real.arccos_pos.mpr hκ; linarith,
    by have := Real.arccos_le_pi ((d + Real.cos h) / R); linarith⟩
  have hau : ¬ a.IsUnitArc := by
    intro h1
    change R = 1 at h1
    have : R ^ 2 = 1 := by rw [h1]; norm_num
    rw [hRsq] at this
    nlinarith
  have hlc := F.bend_hlc (a := a) (L := L) (S := (closedBall P 1)ᶜ) (j := c') hOL (hend θ₁ (Or.inl rfl))
    (hend θ₂ (Or.inr rfl)) hcl hLsph hLopen hS hside hcol
  refine ⟨F.bendMap P θ₁ θ₂ a L c' ha hlc, bendMap_valid hF h12 hLU haU hαU hOL (hend θ₁ (Or.inl rfl))
    (hend θ₂ (Or.inr rfl)) hclear hLL, bendMap_agreesOff h12 hLU haU hαU, bendMap_ringArcsWithin hau,
    bendMap_not_onRingArc hdom haO, (bendMap_region hOL (hend θ₁ (Or.inl rfl)) (hend θ₂ (Or.inr rfl))).1, fun z hz => ?_⟩
  rcases (bendMap_region hOL (hend θ₁ (Or.inl rfl)) (hend θ₂ (Or.inr rfl))).2 hz with h1 | h1
  · exact Or.inl h1
  · exact Or.inr ⟨hLU h1, mem_closedBall.mpr h1.1⟩


/-- **The away lens point is clear for the inner colour** (N2-AWAY's clearness): a point `P + (1 + s) e(φ)` of the lens profile is
at distance `≠ 1` from the inner class — a near point of the class lies in `B̄(A, 1) ∩ B̄(B, 1)` (N2-SIGN), off `B(P, r)` (which
the class misses) within `< 1` of the lens point (N2-ENV near, away); a far one lies, by N2-ENV away, within `r` of `R₂(ᾱ)`, which
the class misses. -/
theorem away_clear (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') {r ψ₁ ψ₂ : ℝ}
    (hr : ∀ y ∈ F.region c, r ≤ dist y P) (hr2 : ∀ y ∈ F.region c, y ∉ thickening r (radiusTwoArc P θ₁ θ₂))
    (henv : ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ₁ * min (φ - θ₁) (θ₂ - φ) →
      closedBall (P + (1 + s) * e φ) 1 \ ⋃ θ ∈ Icc θ₁ θ₂, ball (ringPt P θ) 1 ⊆ thickening r (radiusTwoArc P θ₁ θ₂))
    (hnear : ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ₂ * min (φ - θ₁) (θ₂ - φ) →
      ∀ p ∈ (closedBall (ringPt P θ₁) 1 ∩ closedBall (ringPt P θ₂) 1) \ ball P r, dist p (P + (1 + s) * e φ) < 1)
    {φ s : ℝ} (hφ : φ ∈ Ioo θ₁ θ₂) (hs : 0 < s) (hsψ₁ : s ≤ ψ₁ * min (φ - θ₁) (θ₂ - φ))
    (hsψ₂ : s ≤ ψ₂ * min (φ - θ₁) (θ₂ - φ)) :
    F.IsClear c (P + (1 + s) * e φ) := by
  intro y hy hzy
  have h12 : θ₁ < θ₂ := hA.1
  have hcont : Continuous fun θ : ℝ => dist y (ringPt P θ) := by unfold ringPt e; fun_prop
  by_cases hU : y ∈ ⋃ θ ∈ Icc θ₁ θ₂, ball (ringPt P θ) 1
  · obtain ⟨θ₀, hθ₀, hy0⟩ := mem_iUnion₂.mp hU
    rw [mem_ball] at hy0
    rcases n2_sign hF hA (Or.inl rfl) hy with hlt | hgt
    · have hle := le_on_Icc_of_Ioo hcont h12 fun θ hθ => (hlt θ hθ).le
      have hyP : y ∉ ball P r := fun h' => by rw [mem_ball] at h'; linarith [hr y hy]
      have := hnear φ hφ s hs hsψ₂ y ⟨⟨mem_closedBall.mpr (hle θ₁ ⟨le_rfl, h12.le⟩),
        mem_closedBall.mpr (hle θ₂ ⟨h12.le, le_rfl⟩)⟩, hyP⟩
      rw [dist_comm] at this; linarith
    · have hge := ge_on_Icc_of_Ioo hcont h12 fun θ hθ => (hgt θ hθ).le
      linarith [hge θ₀ hθ₀]
  · have hyb : y ∈ closedBall (P + (1 + s) * e φ) 1 := by rw [mem_closedBall, dist_comm]; exact hzy.le
    exact hr2 y hy (henv φ hφ s hs hsψ₁ ⟨hyb, hU⟩)

/-- **The away lens is clear for the inner colour**: on `ω(P)` by `ne1_region`, off it by `away_clear` at the lens profile. -/
theorem away_lens_clear (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') {r ψ₁ ψ₂ d : ℝ}
    (hd : 0 < d) (hd10 : d ≤ 1 / 10)
    (hr : ∀ y ∈ F.region c, r ≤ dist y P) (hr2 : ∀ y ∈ F.region c, y ∉ thickening r (radiusTwoArc P θ₁ θ₂))
    (henv : ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ₁ * min (φ - θ₁) (θ₂ - φ) →
      closedBall (P + (1 + s) * e φ) 1 \ ⋃ θ ∈ Icc θ₁ θ₂, ball (ringPt P θ) 1 ⊆ thickening r (radiusTwoArc P θ₁ θ₂))
    (hnear : ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ₂ * min (φ - θ₁) (θ₂ - φ) →
      ∀ p ∈ (closedBall (ringPt P θ₁) 1 ∩ closedBall (ringPt P θ₂) 1) \ ball P r, dist p (P + (1 + s) * e φ) < 1)
    (hd1 : 2 * d ≤ ψ₁) (hd2 : 2 * d ≤ ψ₂) {z : ℂ} (hz1 : 1 ≤ dist z P)
    (hzC : dist z (P + d * e ((θ₁ + θ₂) / 2)) ^ 2 < 1 - 2 * d * Real.cos ((θ₂ - θ₁) / 2) + d ^ 2) :
    F.IsClear c z := by
  have h12 : θ₁ < θ₂ := hA.1
  have hℓ := l60_le hF hA
  have hπ := Real.pi_pos
  set φ := (θ₁ + θ₂) / 2 with hφdef
  set h := (θ₂ - θ₁) / 2 with hhdef
  have hh : 0 < h := by rw [hhdef]; linarith
  have hh2 : h < π / 2 := by rw [hhdef]; linarith
  obtain ⟨hb, hs⟩ := away_polar_strict hd (by linarith) hh hh2 hz1 hzC
  set b := arg ((z - P) * starRingEnd ℂ (e φ)) with hbdef
  have hpolO : φ + b ∈ Ioo θ₁ θ₂ :=
    ⟨by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_lt.mp hb).1], by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_lt.mp hb).2]⟩
  by_cases hsph : dist z P = 1
  · have hz := eq_polar_frameDir P z φ
    rw [← hbdef, hsph, Complex.ofReal_one, one_mul] at hz
    have hcl' : z ∈ closure (F.region c) := by
      have : c ∈ F.innerColours P (ringPt P (φ + b)) := by rw [(hA.2.2 _ hpolO).1]; rfl
      rw [hz]; exact closure_mono inter_subset_left this
    intro y hy hzy
    exact ne1_region hF hcl' hy (by rw [dist_comm]; exact hzy)
  · have hs0 : 0 < dist z P - 1 := by have := lt_of_le_of_ne hz1 (Ne.symm hsph); linarith
    have hmin : min (φ + b - θ₁) (θ₂ - (φ + b)) = h - |b| := by
      rw [show φ + b - θ₁ = h + b by rw [hφdef, hhdef]; ring, show θ₂ - (φ + b) = h - b by rw [hφdef, hhdef]; ring]
      exact min_add_sub_eq h b
    have hzeq : z = P + (1 + ((dist z P - 1 : ℝ) : ℂ)) * e (φ + b) := by
      have := eq_polar_frameDir P z φ
      rw [← hbdef] at this
      calc z = P + (dist z P : ℂ) * e (φ + b) := this
        _ = _ := by push_cast; ring
    have hΔ : 0 ≤ h - |b| := by linarith
    rw [hzeq]
    refine F.away_clear hF hA hr hr2 henv hnear hpolO hs0 ?_ ?_ <;> rw [hmin]
    · exact (hs.trans_le (mul_le_mul_of_nonneg_right hd1 hΔ)).le
    · exact (hs.trans_le (mul_le_mul_of_nonneg_right hd2 hΔ)).le

/-- **Two points of the away lens are never at distance `1`**: if one is off `ω(P)` it is a lens point of the profile and the other
lies in `B̄(A, 1) ∩ B̄(B, 1)` off `B(P, r)` (`away_mem_lens`), so N2-ENV's near clause puts them within `< 1`; two points of `ω(P)`
within `2h ≤ 60°` of each other are within `< 1`. -/
theorem away_pairs {P : ℂ} {θ₁ θ₂ d r ψ : ℝ} (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) (hd : 0 < d) (hd10 : d ≤ 1 / 10)
    (hr : r ≤ 1 / 2) (hdψ : 2 * d ≤ ψ)
    (hnear : ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ * min (φ - θ₁) (θ₂ - φ) →
      ∀ p ∈ (closedBall (ringPt P θ₁) 1 ∩ closedBall (ringPt P θ₂) 1) \ ball P r, dist p (P + (1 + s) * e φ) < 1)
    {z z' : ℂ} (hz1 : 1 ≤ dist z P)
    (hzC : dist z (P + d * e ((θ₁ + θ₂) / 2)) ^ 2 < 1 - 2 * d * Real.cos ((θ₂ - θ₁) / 2) + d ^ 2)
    (hz1' : 1 ≤ dist z' P)
    (hzC' : dist z' (P + d * e ((θ₁ + θ₂) / 2)) ^ 2 < 1 - 2 * d * Real.cos ((θ₂ - θ₁) / 2) + d ^ 2) :
    dist z z' ≠ 1 := by
  have hπ := Real.pi_pos
  set φ := (θ₁ + θ₂) / 2 with hφdef
  set h := (θ₂ - θ₁) / 2 with hhdef
  have hh : 0 < h := by rw [hhdef]; linarith
  have hh6 : h ≤ π / 6 := by rw [hhdef]; linarith
  have hh2 : h < π / 2 := by linarith
  have hdh : d ≤ 1 / 2 := by linarith
  have hθ₁ : φ - h = θ₁ := by rw [hφdef, hhdef]; ring
  have hθ₂ : φ + h = θ₂ := by rw [hφdef, hhdef]; ring
  have hinI : ∀ x : ℂ, 1 ≤ dist x P → dist x (P + d * e φ) ^ 2 < 1 - 2 * d * Real.cos h + d ^ 2 →
      x ∈ (closedBall (ringPt P θ₁) 1 ∩ closedBall (ringPt P θ₂) 1) \ ball P r := by
    intro x hx1 hxC
    obtain ⟨hb, hs⟩ := away_polar_strict hd hdh hh hh2 hx1 hxC
    have hx' := eq_polar_frameDir P x φ
    have := away_mem_lens (P := P) (φ := φ) hd.le hd10 hh6 hb.le hx1 hs.le
    rw [← hx', hθ₁, hθ₂] at this
    refine ⟨⟨mem_closedBall.mpr this.1, mem_closedBall.mpr this.2⟩, fun h' => ?_⟩
    rw [mem_ball] at h'
    linarith
  have hoff1 : ∀ x x' : ℂ, 1 ≤ dist x P → dist x (P + d * e φ) ^ 2 < 1 - 2 * d * Real.cos h + d ^ 2 →
      1 ≤ dist x' P → dist x' (P + d * e φ) ^ 2 < 1 - 2 * d * Real.cos h + d ^ 2 → dist x P ≠ 1 → dist x x' ≠ 1 := by
    intro x x' hx1 hxC hx1' hxC' hsph
    obtain ⟨hb, hs⟩ := away_polar_strict hd hdh hh hh2 hx1 hxC
    set b := arg ((x - P) * starRingEnd ℂ (e φ)) with hbdef
    have hpolO : φ + b ∈ Ioo θ₁ θ₂ :=
      ⟨by rw [← hθ₁]; linarith [(abs_lt.mp hb).1], by rw [← hθ₂]; linarith [(abs_lt.mp hb).2]⟩
    have hs0 : 0 < dist x P - 1 := by have := lt_of_le_of_ne hx1 (Ne.symm hsph); linarith
    have hmin : min (φ + b - θ₁) (θ₂ - (φ + b)) = h - |b| := by
      rw [← hθ₁, ← hθ₂, show φ + b - (φ - h) = h + b by ring, show φ + h - (φ + b) = h - b by ring]
      exact min_add_sub_eq h b
    have hxeq : x = P + (1 + ((dist x P - 1 : ℝ) : ℂ)) * e (φ + b) := by
      have := eq_polar_frameDir P x φ
      rw [← hbdef] at this
      calc x = P + (dist x P : ℂ) * e (φ + b) := this
        _ = _ := by push_cast; ring
    have hΔ : 0 ≤ h - |b| := by linarith
    have := hnear (φ + b) hpolO (dist x P - 1) hs0
      (by rw [hmin]; exact (hs.trans_le (mul_le_mul_of_nonneg_right hdψ hΔ)).le) x' (hinI x' hx1' hxC')
    rw [← hxeq, dist_comm] at this
    exact ne_of_lt this
  by_cases h1 : dist z P = 1
  · by_cases h1' : dist z' P = 1
    · obtain ⟨hb, -⟩ := away_polar_strict hd hdh hh hh2 hz1 hzC
      obtain ⟨hb', -⟩ := away_polar_strict hd hdh hh hh2 hz1' hzC'
      set b := arg ((z - P) * starRingEnd ℂ (e φ))
      set b' := arg ((z' - P) * starRingEnd ℂ (e φ))
      have hcos : 1 / 2 < Real.cos (b - b') := by
        have h3 : |b - b'| < π / 3 := by have := abs_sub b b'; linarith
        have := Real.cos_lt_cos_of_nonneg_of_le_pi (abs_nonneg _) (by linarith) h3
        rw [Real.cos_abs, Real.cos_pi_div_three] at this
        exact this
      have hz₀ := eq_polar_frameDir P z φ
      have hz₀' := eq_polar_frameDir P z' φ
      have hd' : dist z z' = dist (P + (dist z P : ℂ) * e (φ + b)) (P + (dist z' P : ℂ) * e (φ + b')) := by
        rw [← hz₀, ← hz₀']
      intro h2
      have := dist_polar_polar_sq P (dist z P) (dist z' P) (φ + b) (φ + b')
      rw [← hd', h2, h1, h1', show φ + b - (φ + b') = b - b' by ring] at this
      nlinarith
    · rw [dist_comm]; exact hoff1 z' z hz1' hzC' hz1 hzC h1'
  · exact hoff1 z z' hz1 hzC hz1' hzC' h1

/-- The away bend's circle: positive squared radius `1 − 2d cos h + d²`, its half-plane threshold below the radius (so the arc is
non-degenerate), and radius `≠ 1` (so it is not a unit arc), for `0 < d ≤ 1/10`, `0 < h ≤ 30°`. -/
theorem away_circle_facts {d h : ℝ} (hd : 0 < d) (hd10 : d ≤ 1 / 10) (hh : 0 < h) (hh6 : h ≤ π / 6) :
    0 < 1 - 2 * d * Real.cos h + d ^ 2 ∧ (Real.cos h - d) / √(1 - 2 * d * Real.cos h + d ^ 2) < 1 ∧
      √(1 - 2 * d * Real.cos h + d ^ 2) ≠ 1 := by
  have hπ := Real.pi_pos
  have hc1 := Real.cos_le_one h
  have hcosh2 : 1 / 2 < Real.cos h := by
    have := Real.cos_lt_cos_of_nonneg_of_le_pi hh.le (by linarith) (show h < π / 3 by linarith)
    rwa [Real.cos_pi_div_three] at this
  have hpos : 0 < 1 - 2 * d * Real.cos h + d ^ 2 := by nlinarith
  refine ⟨hpos, ?_, ?_⟩
  · rw [div_lt_one (Real.sqrt_pos.2 hpos)]
    refine Real.lt_sqrt_of_sq_lt ?_
    have : Real.cos h ^ 2 < 1 := by
      have hsin : 0 < Real.sin h := Real.sin_pos_of_pos_of_lt_pi hh (by linarith)
      nlinarith [Real.sin_sq_add_cos_sq h]
    nlinarith
  · intro h1
    have : (√(1 - 2 * d * Real.cos h + d ^ 2)) ^ 2 = 1 := by rw [h1]; norm_num
    rw [Real.sq_sqrt hpos.le] at this
    nlinarith

/-- **FS112-N2-BENDS**, the away bend as the row states it (scratch copy, proved directly). -/
theorem bend_away_whole' (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hin : c ∉ F.coloursAt P) (hR2 : Disjoint (radiusTwoArc P θ₁ θ₂) (closure (F.region c))) {ε : ℝ} (hε : 0 < ε) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (thickening ε (ringArc P θ₁ θ₂)) ∧ F'.RingArcsWithin F ∧
      (∀ θ ∈ Ioo θ₁ θ₂, ¬ F'.OnRingArc P (ringPt P θ)) ∧ (∀ j, j ≠ c → F'.region j ⊆ F.region j) ∧
      F'.region c ⊆ F.region c ∪ (thickening ε (ringArc P θ₁ θ₂) \ ball P 1) := by
  have h12 : θ₁ < θ₂ := hA.1
  have hℓ := l60_le hF hA
  have hπ := Real.pi_pos
  set φ := (θ₁ + θ₂) / 2 with hφdef
  set h := (θ₂ - θ₁) / 2 with hhdef
  have hh : 0 < h := by rw [hhdef]; linarith
  have hh6 : h ≤ π / 6 := by rw [hhdef]; linarith
  have hh2 : h < π / 2 := by linarith
  have hcosh : 0 < Real.cos h := Real.cos_pos_of_mem_Ioo ⟨by linarith, hh2⟩
  have hcosh2 : 1 / 2 < Real.cos h := by
    have := Real.cos_lt_cos_of_nonneg_of_le_pi hh.le (by linarith) (show h < π / 3 by linarith)
    rwa [Real.cos_pi_div_three] at this
  -- the inner class keeps a positive distance from `P` and from `R₂(ᾱ)`
  obtain ⟨r₁, hr₁, hr₁c⟩ : ∃ r > 0, ∀ y ∈ F.region c, r ≤ dist y P := by
    have : P ∉ closure (F.region c) := hin
    rw [Metric.mem_closure_iff] at this
    push Not at this
    obtain ⟨r, hr, hr'⟩ := this
    exact ⟨r, hr, fun y hy => by rw [dist_comm]; exact hr' y hy⟩
  have hK : IsCompact (radiusTwoArc P θ₁ θ₂) := isCompact_Icc.image (by unfold e; fun_prop)
  obtain ⟨r₂, hr₂, hr₂c⟩ := hK.exists_thickening_subset_open isClosed_closure.isOpen_compl
    (fun x hx hcl => Set.disjoint_left.mp hR2 hx hcl)
  set r := min (min r₁ r₂) (1 / 2) with hrdef
  have hr : 0 < r := by positivity
  have hrc : ∀ y ∈ F.region c, r ≤ dist y P := fun y hy =>
    le_trans (le_trans (min_le_left _ _) (min_le_left _ _)) (hr₁c y hy)
  have hr2c : ∀ y ∈ F.region c, y ∉ thickening r (radiusTwoArc P θ₁ θ₂) := fun y hy hyt =>
    hr₂c (thickening_mono (le_trans (min_le_left _ _) (min_le_right _ _)) _ hyt) (subset_closure hy)
  obtain ⟨ψ₁, hψ₁, henv⟩ := n2_env_away P h12 hℓ hr
  obtain ⟨ψ₂, hψ₂, hnear⟩ := n2_env_near_away P h12 hℓ hr
  set d := min (min (min ψ₁ ψ₂) ε) (1 / 2) / 5 with hddef
  have hd : 0 < d := by positivity
  have hm1 := min_le_left (min (min ψ₁ ψ₂) ε) (1 / 2)
  have hm2 := min_le_right (min (min ψ₁ ψ₂) ε) (1 / 2)
  have hm3 := min_le_left (min ψ₁ ψ₂) ε
  have hm4 := min_le_right (min ψ₁ ψ₂) ε
  have hd1 : 2 * d ≤ ψ₁ := by have := min_le_left ψ₁ ψ₂; rw [hddef]; linarith
  have hd2 : 2 * d ≤ ψ₂ := by have := min_le_right ψ₁ ψ₂; rw [hddef]; linarith
  have hd10 : d ≤ 1 / 10 := by rw [hddef]; linarith
  have hdh : d ≤ 1 / 2 := by linarith
  have hdε : 2 * d * h < ε := by
    have h1 : 2 * d ≤ ε / 2 := by rw [hddef]; linarith
    have h2 : h < 1 := by linarith [Real.pi_lt_four]
    nlinarith
  obtain ⟨hpos, hκ, hR1⟩ := away_circle_facts hd hd10 hh hh6
  set C := P + (d : ℂ) * e φ with hCdef
  set L : Set ℂ := {z | 1 ≤ dist z P ∧ dist z C ^ 2 < 1 - 2 * d * Real.cos h + d ^ 2} with hLdef
  set R := √(1 - 2 * d * Real.cos h + d ^ 2) with hRdef
  have hRsq : R ^ 2 = 1 - 2 * d * Real.cos h + d ^ 2 := Real.sq_sqrt hpos.le
  set a := Arc.circ C R (φ - Real.arccos ((Real.cos h - d) / R)) (φ + Real.arccos ((Real.cos h - d) / R)) with hadef
  have hcar : a.carrier = {z | dist z C = R ∧ 1 ≤ dist z P} := away_carrier P hd hpos
  set O := ringPt P '' Ioo θ₁ θ₂ with hOdef
  set U := thickening ε (ringArc P θ₁ θ₂) with hUdef
  have hring : ∀ θ, dist (ringPt P θ) C ^ 2 = 1 - 2 * d * Real.cos (θ - φ) + d ^ 2 := by
    intro θ; rw [hCdef, dist_sq_add_dir, re_frameDir_ringPt, dist_ringPt]; ring
  have hOL : O ⊆ L := by
    rintro _ ⟨θ, hθ, rfl⟩
    refine ⟨(dist_ringPt P θ).ge, ?_⟩
    rw [hring]
    have habs : |θ - φ| < h := abs_lt.mpr ⟨by rw [hφdef, hhdef]; linarith [hθ.1], by rw [hφdef, hhdef]; linarith [hθ.2]⟩
    have := Real.cos_lt_cos_of_nonneg_of_le_pi (abs_nonneg _) (by linarith) habs
    rw [Real.cos_abs] at this
    nlinarith
  have hend : ∀ θ, (θ = θ₁ ∨ θ = θ₂) → ringPt P θ ∈ a.carrier := by
    intro θ hθ
    rw [hcar]
    refine ⟨?_, (dist_ringPt P θ).ge⟩
    have hc : Real.cos (θ - φ) = Real.cos h := by
      rcases hθ with h1 | h1 <;> rw [h1]
      · rw [show θ₁ - φ = -h by rw [hφdef, hhdef]; ring, Real.cos_neg]
      · rw [show θ₂ - φ = h by rw [hφdef, hhdef]; ring]
    have := hring θ
    rw [hc, ← hRsq] at this
    exact (pow_left_inj₀ dist_nonneg (Real.sqrt_nonneg _) two_ne_zero).mp this
  have hpolI : ∀ z, |arg ((z - P) * starRingEnd ℂ (e φ))| ≤ h →
      φ + arg ((z - P) * starRingEnd ℂ (e φ)) ∈ Icc θ₁ θ₂ := fun z hb =>
    ⟨by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_le.mp hb).1], by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_le.mp hb).2]⟩
  have hpolO : ∀ z, |arg ((z - P) * starRingEnd ℂ (e φ))| < h →
      φ + arg ((z - P) * starRingEnd ℂ (e φ)) ∈ Ioo θ₁ θ₂ := fun z hb =>
    ⟨by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_lt.mp hb).1], by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_lt.mp hb).2]⟩
  have hU1 : ∀ z, 1 ≤ dist z P → |arg ((z - P) * starRingEnd ℂ (e φ))| ≤ h →
      dist z P - 1 ≤ 2 * d * (h - |arg ((z - P) * starRingEnd ℂ (e φ))|) → z ∈ U := by
    intro z hz1 hb hs
    refine mem_thickening_ringArc_of_polar (hpolI z hb) (eq_polar_frameDir P z φ) ?_
    rw [abs_sub_comm, abs_of_nonneg (by linarith)]
    have : 0 ≤ |arg ((z - P) * starRingEnd ℂ (e φ))| := abs_nonneg _
    nlinarith
  have hLU : L ⊆ U := fun z hz => by
    obtain ⟨hb, hs⟩ := away_polar_strict hd hdh hh hh2 hz.1 hz.2
    exact hU1 z hz.1 hb.le hs.le
  have haU : a.carrier ⊆ U := fun z hz => by
    rw [hcar] at hz
    obtain ⟨hb, hs⟩ := away_polar hd hdh hh hh2 hz.2 (by rw [hz.1, hRsq])
    exact hU1 z hz.2 hb hs
  have hαU : ringArc P θ₁ θ₂ ⊆ U := self_subset_thickening hε _
  have haO : Disjoint a.carrier O := by
    rw [Set.disjoint_left]
    intro z hz hzO
    rw [hcar] at hz
    have := (hOL hzO).2
    rw [hz.1, hRsq] at this
    exact lt_irrefl _ this
  have hcl : closure L ⊆ L ∪ a.carrier := by
    have hK' : IsClosed {z : ℂ | 1 ≤ dist z P ∧ dist z C ^ 2 ≤ 1 - 2 * d * Real.cos h + d ^ 2} :=
      (isClosed_le continuous_const (continuous_id.dist continuous_const)).inter
        (isClosed_le ((continuous_id.dist continuous_const).pow 2) continuous_const)
    intro z hz
    obtain ⟨hz1, hz2⟩ := closure_minimal (show L ⊆ {z : ℂ | 1 ≤ dist z P ∧ dist z C ^ 2 ≤ 1 - 2 * d * Real.cos h + d ^ 2}
      from fun y hy => ⟨hy.1, hy.2.le⟩) hK' hz
    rcases lt_or_eq_of_le hz2 with hlt | heq
    · exact Or.inl ⟨hz1, hlt⟩
    · refine Or.inr ?_
      rw [hcar]
      refine ⟨?_, hz1⟩
      rw [← hRsq] at heq
      exact (pow_left_inj₀ dist_nonneg (Real.sqrt_nonneg _) two_ne_zero).mp heq
  have hLsph : ∀ x ∈ L, x ∈ sphere P 1 → x ∈ O := by
    intro x hx hsph
    rw [mem_sphere] at hsph
    obtain ⟨hb, -⟩ := away_polar_strict hd hdh hh hh2 hx.1 hx.2
    refine ⟨_, hpolO x hb, ?_⟩
    have := eq_polar_frameDir P x φ
    rw [hsph, Complex.ofReal_one, one_mul] at this
    rw [ringPt, ← this]
  have hLopen : ∀ x ∈ L, x ∉ sphere P 1 → L ∈ 𝓝 x := by
    intro x hx hsph
    have hlt : 1 < dist x P := lt_of_le_of_ne hx.1 (Ne.symm hsph)
    have hopen : IsOpen {z : ℂ | 1 < dist z P ∧ dist z C ^ 2 < 1 - 2 * d * Real.cos h + d ^ 2} :=
      (isOpen_lt continuous_const (continuous_id.dist continuous_const)).inter
        (isOpen_lt ((continuous_id.dist continuous_const).pow 2) continuous_const)
    exact Filter.mem_of_superset (hopen.mem_nhds ⟨hlt, hx.2⟩) fun z hz => ⟨hz.1.le, hz.2⟩
  have hS : Disjoint (ball P 1) (sphere P 1) :=
    Set.disjoint_left.mpr fun z hz hs => by rw [mem_ball] at hz; rw [mem_sphere] at hs; linarith
  have hside : ∀ x ∈ O, ∀ᶠ y in 𝓝 x, y ∈ L ∨ y ∈ ball P 1 := by
    intro x hx
    have hopen : IsOpen {z : ℂ | dist z C ^ 2 < 1 - 2 * d * Real.cos h + d ^ 2} :=
      isOpen_lt ((continuous_id.dist continuous_const).pow 2) continuous_const
    filter_upwards [hopen.mem_nhds (hOL hx).2] with y hy
    by_cases hy1 : 1 ≤ dist y P
    · exact Or.inl ⟨hy1, hy⟩
    · exact Or.inr (mem_ball.mpr (not_le.mp hy1))
  have hcol : ∀ x ∈ O, ∀ i, i ≠ c → x ∉ closure (F.region i ∩ ball P 1) := by
    rintro _ ⟨θ, hθ, rfl⟩ i hi hcl'
    have hin' := (hA.2.2 θ hθ).1
    have : i ∈ F.innerColours P (ringPt P θ) := hcl'
    rw [hin'] at this
    exact hi this
  have hclear : ∀ z ∈ L, F.IsClear c z := fun z hz =>
    F.away_lens_clear hF hA hd hd10 hrc hr2c henv hnear hd1 hd2 hz.1 hz.2
  have hLL : ∀ z ∈ L, ∀ z' ∈ L, dist z z' ≠ 1 := fun z hz z' hz' =>
    away_pairs h12 hℓ hd hd10 (min_le_right _ _) hd2 hnear hz.1 hz.2 hz'.1 hz'.2
  have hdom : O ⊆ F.dom := fun x hx => (hA.2.1 (image_mono Ioo_subset_Icc_self hx)).1
  have hRpos : 0 < R := Real.sqrt_pos.2 hpos
  have ha : a.Nondegenerate := ⟨hRpos, by have := Real.arccos_pos.mpr hκ; linarith,
    by have := Real.arccos_le_pi ((Real.cos h - d) / R); linarith⟩
  have hau : ¬ a.IsUnitArc := fun h1 => hR1 h1
  have hlc := F.bend_hlc (a := a) (L := L) (S := ball P 1) (j := c) hOL (hend θ₁ (Or.inl rfl))
    (hend θ₂ (Or.inr rfl)) hcl hLsph hLopen hS hside hcol
  refine ⟨F.bendMap P θ₁ θ₂ a L c ha hlc, bendMap_valid hF h12 hLU haU hαU hOL (hend θ₁ (Or.inl rfl))
    (hend θ₂ (Or.inr rfl)) hclear hLL, bendMap_agreesOff h12 hLU haU hαU, bendMap_ringArcsWithin hau,
    bendMap_not_onRingArc hdom haO, (bendMap_region hOL (hend θ₁ (Or.inl rfl)) (hend θ₂ (Or.inr rfl))).1, fun z hz => ?_⟩
  rcases (bendMap_region hOL (hend θ₁ (Or.inl rfl)) (hend θ₂ (Or.inr rfl))).2 hz with h1 | h1
  · exact Or.inl h1
  · exact Or.inr ⟨hLU h1, fun h' => by rw [mem_ball] at h'; linarith [h1.1]⟩

end ArcMap

end HadwigerNelson.Plane

#print axioms HadwigerNelson.Plane.ArcMap.bend_toward'
#print axioms HadwigerNelson.Plane.ArcMap.bend_away_whole'
