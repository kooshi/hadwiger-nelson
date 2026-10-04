import Proofs.HadwigerNelson.Plane.LocalMap
import Mathlib.Analysis.Real.Pi.Bounds

/-!
# Spec examples and inhabitants for wave 3's foundation (`Plane/LocalMap`)

Each example fails if its definition drifts; the adversaries (`¬ …`) fail if a definition becomes trivially true.
Two small maps carry the ring vocabulary (neither is valid; validity is a separate predicate, and the definitions do
not read it):

* `halfPlane2 : ArcMap 2` — the disc `B(0, 2)` cut along the real axis, colour `1` above and `0` below. About `p = 0`
  its ring meets `Γ` in the two points `±1`: `r(0) = 1` is a **change point** (colour `1` just counter-clockwise, `0`
  just clockwise) and, since the ring carries no arc of `Γ` at all, a **hub**.
* `quadRing : ArcMap 4` — the disc `B(0, 2)` cut by both axes and the unit circle, coloured by quadrant inside the
  circle and by the opposite quadrant outside (the capped strip's midline ring, schematically: four (Q) arcs). About
  `p = 0`, four colours are carried at `p`, the quarter `[0, π/2]` of the ring is an **arc of `Γ` with constant sides**
  (inner colour `0`, outer colour `2`) and a **(Q) arc**; no ring point is a change point (the ring lies in `Γ`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Cones, germs, near and far -/

/-- The unit disc approaches `1` from the left: `π ∈ coneAt (B(0, 1)) 1`. -/
example : π ∈ coneAt (ball (0 : ℂ) 1) 1 := by
  intro ε hε
  set t := min (ε / 2) (1 / 2) with ht
  have ht0 : 0 < t := lt_min (by linarith) (by norm_num)
  have ht1 : t < 1 := lt_of_le_of_lt (min_le_right _ _) (by norm_num)
  refine ⟨1 - t, ?_, ?_, ?_, ?_⟩
  · rw [mem_ball, dist_zero_right]
    rw [show (1 : ℂ) - t = ((1 - t : ℝ) : ℂ) by push_cast; ring, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos (by linarith)]
    linarith
  · intro h
    have := congrArg Complex.re h
    simp at this
    linarith
  · rw [dist_eq_norm, show (1 : ℂ) - t - 1 = ((-t : ℝ) : ℂ) by push_cast; ring, Complex.norm_real,
      Real.norm_eq_abs, abs_neg, abs_of_pos ht0]
    exact lt_of_le_of_lt (min_le_left _ _) (by linarith)
  · have he : e π = -1 := by rw [e_eq, Real.cos_pi, Real.sin_pi]; simp
    have hd : (1 : ℂ) - t - 1 = ((-t : ℝ) : ℂ) := by push_cast; ring
    rw [he, hd, Complex.norm_real, Real.norm_eq_abs, abs_neg, abs_of_pos ht0]
    have : ((-t : ℝ) : ℂ) / ((t : ℝ) : ℂ) = -1 := by
      rw [Complex.ofReal_neg, neg_div, div_self (by exact_mod_cast ht0.ne')]
    rw [this]
    simpa using hε

/-- **Adversary**: the unit disc does not approach `1` from the right: `0 ∉ coneAt (B(0, 1)) 1`. -/
example : (0 : ℝ) ∉ coneAt (ball (0 : ℂ) 1) 1 := by
  intro h
  obtain ⟨z, hz, hne, -, hdir⟩ := h (1 / 2) (by norm_num)
  have hre : z.re < 1 := lt_of_le_of_lt (Complex.re_le_norm z) (by simpa using hz)
  have hpos : 0 < ‖z - 1‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hne)
  have he : e 0 = 1 := by simp [e]
  rw [he] at hdir
  have hre2 : ((z - 1) / (‖z - 1‖ : ℂ)).re = (z.re - 1) / ‖z - 1‖ := by
    rw [Complex.div_ofReal_re, Complex.sub_re, Complex.one_re]
  have hlt : ((z - 1) / (‖z - 1‖ : ℂ)).re < 0 := by
    rw [hre2]; exact div_neg_of_neg_of_pos (by linarith) hpos
  have habs : |((z - 1) / (‖z - 1‖ : ℂ) - 1).re| ≤ ‖(z - 1) / (‖z - 1‖ : ℂ) - 1‖ := Complex.abs_re_le_norm _
  rw [Complex.sub_re, Complex.one_re, abs_of_neg (by linarith)] at habs
  linarith

/-- The germ of the unit circle just counter-clockwise of `r(0) = 1`, of length below `π`, lies in the upper
half-plane. -/
example : germ 0 0 .ccw 1 ⊆ {z : ℂ | 0 < z.im} := by
  rintro _ ⟨t, ⟨ht0, ht1⟩, rfl⟩
  simp only [ringPt, Side.sign, zero_add, one_mul, mem_setOf_eq, e_eq, Complex.add_im, Complex.ofReal_im,
    Complex.mul_im, Complex.ofReal_re, Complex.I_im, Complex.I_re, mul_one, mul_zero, add_zero]
  exact Real.sin_pos_of_pos_of_lt_pi ht0 (by linarith [Real.pi_gt_three])

/-- Two points of a disc of radius `1/3` are near. -/
example : UnitNear (ball (0 : ℂ) (1 / 3)) (ball 0 (1 / 3)) := by
  intro a ha b hb
  rw [mem_ball] at ha hb
  calc dist a b ≤ dist a 0 + dist 0 b := dist_triangle _ _ _
    _ < 1 := by rw [dist_comm 0 b]; linarith

/-- Discs of radius `1/3` three apart are far. -/
example : UnitFar (ball (0 : ℂ) (1 / 3)) (ball 3 (1 / 3)) := by
  intro a ha b hb
  rw [mem_ball] at ha hb
  have : dist (0 : ℂ) 3 = 3 := by simp [dist_eq_norm]
  have := dist_triangle (0 : ℂ) a 3
  have := dist_triangle a b 3
  rw [dist_comm] at ha
  linarith

/-! ## Segments through the origin -/

/-- A point of the segment `[−r, r]` is real. -/
theorem im_eq_zero_of_mem_segment_neg {r : ℝ} {z : ℂ} (hz : z ∈ segment ℝ (-(r : ℂ)) r) : z.im = 0 := by
  obtain ⟨a, b, -, -, -, rfl⟩ := hz
  simp

/-- A real point of absolute value at most `r` lies on `[−r, r]`. -/
theorem mem_segment_neg_of_im_eq_zero {r : ℝ} {z : ℂ} (hz : |z.re| ≤ r) (him : z.im = 0) :
    z ∈ segment ℝ (-(r : ℂ)) r := by
  have hr : 0 ≤ r := le_trans (abs_nonneg _) hz
  have hz' : z = ((z.re : ℝ) : ℂ) := Complex.ext (by simp) (by simp [him])
  have hseg : z.re ∈ segment ℝ (-r) r := by
    rw [segment_eq_Icc (by linarith)]
    exact abs_le.mp hz
  obtain ⟨a, b, ha, hb, hab, h⟩ := hseg
  refine ⟨a, b, ha, hb, hab, ?_⟩
  rw [hz', ← h]
  simp only [Complex.real_smul, smul_eq_mul]
  push_cast
  ring

/-- A point of the segment `[−r i, r i]` is imaginary. -/
theorem re_eq_zero_of_mem_segment_neg_I {r : ℝ} {z : ℂ} (hz : z ∈ segment ℝ (-(r : ℂ) * I) (r * I)) :
    z.re = 0 := by
  obtain ⟨a, b, -, -, -, rfl⟩ := hz
  simp

/-! ## `halfPlane2`: one segment across the ring, a change point and a hub -/

/-- The disc `B(0, 2)` split along the real axis: colour `1` above, `0` below. -/
noncomputable def halfPlane2 : ArcMap 2 where
  dom := ball 0 2
  isOpen_dom := isOpen_ball
  arcs := {Arc.seg (-(2 : ℝ)) (2 : ℝ)}
  nondegenerate := by
    intro a ha
    rw [mem_singleton_iff] at ha
    subst ha
    show (-((2 : ℝ) : ℂ)) ≠ ((2 : ℝ) : ℂ)
    intro h
    have := congrArg Complex.re h
    norm_num at this
  locallyFinite := fun x _ => ⟨univ, univ_mem, (finite_singleton _).subset fun a ha => ha.1⟩
  col := fun z => if 0 < z.im then 1 else 0
  locallyConstant := by
    intro x hx hΓ
    have hx' : ‖x‖ < 2 := by simpa using hx
    have him : x.im ≠ 0 := by
      intro h
      apply hΓ
      refine mem_iUnion₂.mpr ⟨_, rfl, mem_segment_neg_of_im_eq_zero ?_ h⟩
      exact le_of_lt (lt_of_le_of_lt (Complex.abs_re_le_norm x) hx')
    rcases lt_or_gt_of_ne him with h | h
    · filter_upwards [(isOpen_lt Complex.continuous_im continuous_const).mem_nhds h] with y hy
      simp [not_lt.mpr hy.le, not_lt.mpr h.le]
    · filter_upwards [(isOpen_lt continuous_const Complex.continuous_im).mem_nhds h] with y hy
      simp [hy, h]

/-- A point of `B(0, 2)` off the real axis is an interior point of `halfPlane2`. -/
theorem halfPlane2_mem_interiorPts {z : ℂ} (hz : ‖z‖ < 2) (him : z.im ≠ 0) : z ∈ halfPlane2.interiorPts := by
  refine ⟨by show z ∈ ball (0 : ℂ) 2; simpa using hz, fun h => him ?_⟩
  obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
  rw [show halfPlane2.arcs = {Arc.seg (-(2 : ℝ)) (2 : ℝ)} from rfl, mem_singleton_iff] at ha
  subst ha
  exact im_eq_zero_of_mem_segment_neg hza

/-- A point of `halfPlane2`'s `Γ` is real. -/
theorem halfPlane2_im_eq_zero_of_mem_Γ {z : ℂ} (hz : z ∈ halfPlane2.Γ) : z.im = 0 := by
  obtain ⟨-, h⟩ := hz
  obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
  rw [show halfPlane2.arcs = {Arc.seg (-(2 : ℝ)) (2 : ℝ)} from rfl, mem_singleton_iff] at ha
  subst ha
  exact im_eq_zero_of_mem_segment_neg hza

/-- Within any interval of positive length there is an angle whose sine is not zero. -/
theorem exists_sin_ne_zero_of_lt {θ₁ θ₂ : ℝ} (h : θ₁ < θ₂) : ∃ θ ∈ Ioo θ₁ θ₂, Real.sin θ ≠ 0 := by
  set d := min ((θ₂ - θ₁) / 2) (π / 2) with hd
  have hd0 : 0 < d := lt_min (by linarith) (by positivity)
  have hd1 : d ≤ (θ₂ - θ₁) / 2 := min_le_left _ _
  have hd2 : d ≤ π / 2 := min_le_right _ _
  by_contra hall
  push Not at hall
  obtain ⟨m, hm⟩ := Real.sin_eq_zero_iff.mp (hall (θ₁ + d / 2) ⟨by linarith, by linarith⟩)
  obtain ⟨m', hm'⟩ := Real.sin_eq_zero_iff.mp (hall (θ₁ + d) ⟨by linarith, by linarith⟩)
  have hdiff : ((m' - m : ℤ) : ℝ) * π = d / 2 := by push_cast; linarith
  have hpos : (0 : ℝ) < ((m' - m : ℤ) : ℝ) := by
    by_contra hn; push Not at hn; nlinarith [Real.pi_pos]
  have hlt : ((m' - m : ℤ) : ℝ) < 1 := by
    by_contra hn; push Not at hn; nlinarith [Real.pi_pos]
  have h1 : (0 : ℤ) < m' - m := by exact_mod_cast hpos
  have h2 : m' - m < (1 : ℤ) := by exact_mod_cast hlt
  omega

/-- `halfPlane2`'s ring about `0` carries no arc of `Γ`. -/
theorem halfPlane2_not_isRingArc (θ₁ θ₂ : ℝ) (c c' : Fin 2) : ¬ halfPlane2.IsRingArc 0 θ₁ θ₂ c c' := by
  rintro ⟨hlt, hsub, -⟩
  obtain ⟨θ, hθ, hs⟩ := exists_sin_ne_zero_of_lt hlt
  apply hs
  have := halfPlane2_im_eq_zero_of_mem_Γ (hsub ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩)
  simpa [ringPt, e_eq, Complex.sin_ofReal_re, Complex.cos_ofReal_re] using this

/-- `r(0) = 1` is a **change point** of `halfPlane2`'s ring about `0`: colour `1` just counter-clockwise, `0` just
clockwise. -/
theorem halfPlane2_isChangePoint : halfPlane2.IsChangePoint 0 0 1 0 := by
  have hpi : (1 : ℝ) < π := by linarith [Real.pi_gt_three]
  refine ⟨⟨by simp [ringPt, e, halfPlane2], mem_iUnion₂.mpr ⟨_, rfl, ?_⟩⟩, by decide, ⟨1, one_pos, ?_⟩,
    ⟨1, one_pos, ?_⟩⟩
  · simp only [ringPt, e, Complex.ofReal_zero, zero_mul, Complex.exp_zero, zero_add]
    exact mem_segment_neg_of_im_eq_zero (by norm_num) (by simp)
  · rintro _ ⟨t, ⟨ht0, ht1⟩, rfl⟩
    have hs : 0 < Real.sin t := Real.sin_pos_of_pos_of_lt_pi ht0 (by linarith)
    have him : (ringPt 0 (0 + Side.ccw.sign * t)).im = Real.sin t := by
      simp [ringPt, Side.sign, e_eq, Complex.sin_ofReal_re]
    refine ⟨halfPlane2_mem_interiorPts (by simp [ringPt]) (by rw [him]; exact hs.ne'), ?_⟩
    show (if 0 < (ringPt 0 (0 + Side.ccw.sign * t)).im then (1 : Fin 2) else 0) = 1
    rw [him, if_pos hs]
  · rintro _ ⟨t, ⟨ht0, ht1⟩, rfl⟩
    have hs : 0 < Real.sin t := Real.sin_pos_of_pos_of_lt_pi ht0 (by linarith)
    have him : (ringPt 0 (0 + Side.cw.sign * t)).im = -Real.sin t := by
      simp [ringPt, Side.sign, e_eq, Complex.sin_ofReal_re]
    refine ⟨halfPlane2_mem_interiorPts (by simp [ringPt]) (by rw [him]; linarith), ?_⟩
    show (if 0 < (ringPt 0 (0 + Side.cw.sign * t)).im then (1 : Fin 2) else 0) = 0
    rw [him, if_neg (by linarith)]

/-- `r(0)` is a **hub** of `halfPlane2`'s ring: the ring carries no (Q) arc at all. -/
example : halfPlane2.IsHub 0 0 := by
  refine ⟨⟨1, 0, halfPlane2_isChangePoint⟩, fun s => ⟨?_, ?_⟩⟩ <;>
  · rintro ⟨θ₁, θ₂, ⟨c, c', hra, -⟩, -⟩
    exact halfPlane2_not_isRingArc θ₁ θ₂ c c' hra

/-- **Adversary**: no point lies on an arc of `Γ` on `halfPlane2`'s ring about `0`. -/
example (x : ℂ) : ¬ halfPlane2.OnRingArc 0 x := by
  rintro ⟨θ₁, θ₂, hlt, -, hsub⟩
  obtain ⟨θ, hθ, hs⟩ := exists_sin_ne_zero_of_lt hlt
  apply hs
  have := halfPlane2_im_eq_zero_of_mem_Γ (hsub ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩)
  simpa [ringPt, e_eq, Complex.sin_ofReal_re, Complex.cos_ofReal_re] using this

/-- **Adversary**: `r(π/2) = i` is no change point (it is off `Γ`). -/
example (X X' : Fin 2) : ¬ halfPlane2.IsChangePoint 0 (π / 2) X X' := by
  rintro ⟨hΓ, -⟩
  have := halfPlane2_im_eq_zero_of_mem_Γ hΓ
  simp [ringPt, e_eq] at this

/-! ## `quadRing`: the ring in `Γ`, four colours at the centre, a (Q) arc -/

/-- The quadrant index of `z`: `0` for `re > 0, im > 0`, then `1, 2, 3` counter-clockwise. -/
noncomputable def quadrant (z : ℂ) : Fin 4 :=
  if 0 < z.re then (if 0 < z.im then 0 else 3) else (if 0 < z.im then 1 else 2)

/-- The disc `B(0, 2)` cut by both axes and the unit circle; coloured by quadrant inside the circle and by the
opposite quadrant outside. -/
noncomputable def quadRing : ArcMap 4 where
  dom := ball 0 2
  isOpen_dom := isOpen_ball
  arcs := {Arc.seg (-(2 : ℝ)) (2 : ℝ), Arc.seg (-(2 : ℝ) * I) ((2 : ℝ) * I), Arc.circ 0 1 0 (2 * π)}
  nondegenerate := by
    intro a ha
    simp only [mem_insert_iff, mem_singleton_iff] at ha
    rcases ha with rfl | rfl | rfl
    · show (-((2 : ℝ) : ℂ)) ≠ ((2 : ℝ) : ℂ)
      intro h; have := congrArg Complex.re h; norm_num at this
    · show (-((2 : ℝ) : ℂ) * I) ≠ ((2 : ℝ) : ℂ) * I
      intro h; have := congrArg Complex.im h; norm_num at this
    · exact ⟨one_pos, by positivity, by linarith⟩
  locallyFinite := fun x _ => ⟨univ, univ_mem, (toFinite _).subset fun a ha => ha.1⟩
  col := fun z => quadrant z + (if 1 < ‖z‖ then 2 else 0)
  locallyConstant := by
    intro x hx hΓ
    have hre : x.re ≠ 0 := by
      intro h; apply hΓ
      refine mem_iUnion₂.mpr ⟨Arc.seg (-(2 : ℝ) * I) ((2 : ℝ) * I), by simp, ?_⟩
      have hx2 : ‖x‖ < 2 := by simpa using hx
      have him : |x.im| ≤ 2 := le_of_lt (lt_of_le_of_lt (Complex.abs_im_le_norm x) hx2)
      rw [abs_le] at him
      refine ⟨(2 - x.im) / 4, (2 + x.im) / 4, by linarith, by linarith, by ring, ?_⟩
      apply Complex.ext <;> first | (simp [h]; done) | (simp; ring)
    have him : x.im ≠ 0 := by
      intro h; apply hΓ
      refine mem_iUnion₂.mpr ⟨Arc.seg (-(2 : ℝ)) (2 : ℝ), by simp, mem_segment_neg_of_im_eq_zero ?_ h⟩
      exact le_of_lt (lt_of_le_of_lt (Complex.abs_re_le_norm x) (by simpa using hx))
    have hn : ‖x‖ ≠ 1 := by
      intro h; apply hΓ
      refine mem_iUnion₂.mpr ⟨Arc.circ 0 1 0 (2 * π), by simp, ?_⟩
      have hx0 : x ≠ 0 := by rintro rfl; simp at h
      by_cases ha : 0 ≤ x.arg
      · refine ⟨x.arg, ⟨ha, by linarith [Complex.arg_le_pi x, Real.pi_pos]⟩, ?_⟩
        have := Complex.norm_mul_exp_arg_mul_I x
        rw [h, Complex.ofReal_one, one_mul] at this
        simpa [e] using this
      · push Not at ha
        refine ⟨x.arg + 2 * π, ⟨by linarith [Complex.neg_pi_lt_arg x], by linarith⟩, ?_⟩
        have := Complex.norm_mul_exp_arg_mul_I x
        rw [h, Complex.ofReal_one, one_mul] at this
        simp only [zero_add]
        rw [e_add_two_pi]
        simpa [e] using this
    have hq : ∀ᶠ y in 𝓝 x, quadrant y = quadrant x := by
      rcases lt_or_gt_of_ne hre with h1 | h1 <;> rcases lt_or_gt_of_ne him with h2 | h2
      · filter_upwards [(isOpen_lt Complex.continuous_re continuous_const).mem_nhds h1,
          (isOpen_lt Complex.continuous_im continuous_const).mem_nhds h2] with y hy1 hy2
        simp [quadrant, not_lt.mpr hy1.le, not_lt.mpr hy2.le, not_lt.mpr h1.le, not_lt.mpr h2.le]
      · filter_upwards [(isOpen_lt Complex.continuous_re continuous_const).mem_nhds h1,
          (isOpen_lt continuous_const Complex.continuous_im).mem_nhds h2] with y hy1 hy2
        simp [quadrant, not_lt.mpr hy1.le, hy2, not_lt.mpr h1.le, h2]
      · filter_upwards [(isOpen_lt continuous_const Complex.continuous_re).mem_nhds h1,
          (isOpen_lt Complex.continuous_im continuous_const).mem_nhds h2] with y hy1 hy2
        simp [quadrant, hy1, not_lt.mpr hy2.le, h1, not_lt.mpr h2.le]
      · filter_upwards [(isOpen_lt continuous_const Complex.continuous_re).mem_nhds h1,
          (isOpen_lt continuous_const Complex.continuous_im).mem_nhds h2] with y hy1 hy2
        simp [quadrant, hy1, hy2, h1, h2]
    have hr : ∀ᶠ y in 𝓝 x, (1 < ‖y‖ ↔ 1 < ‖x‖) := by
      rcases lt_or_gt_of_ne hn with h | h
      · filter_upwards [(isOpen_lt continuous_norm continuous_const).mem_nhds h] with y hy
        exact ⟨fun h' => absurd h' (not_lt.mpr hy.le), fun h' => absurd h' (not_lt.mpr h.le)⟩
      · filter_upwards [(isOpen_lt continuous_const continuous_norm).mem_nhds h] with y hy
        exact ⟨fun _ => h, fun _ => hy⟩
    filter_upwards [hq, hr] with y h1 h2
    simp only [h1, h2]

/-- A point of `B(0, 2)` off both axes and off the unit circle is an interior point of `quadRing`. -/
theorem quadRing_mem_interiorPts {z : ℂ} (hz : ‖z‖ < 2) (hre : z.re ≠ 0) (him : z.im ≠ 0) (hn : ‖z‖ ≠ 1) :
    z ∈ quadRing.interiorPts := by
  refine ⟨by show z ∈ ball (0 : ℂ) 2; simpa using hz, fun h => ?_⟩
  obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
  rw [show quadRing.arcs = {Arc.seg (-(2 : ℝ)) (2 : ℝ), Arc.seg (-(2 : ℝ) * I) ((2 : ℝ) * I),
    Arc.circ 0 1 0 (2 * π)} from rfl] at ha
  simp only [mem_insert_iff, mem_singleton_iff] at ha
  rcases ha with rfl | rfl | rfl
  · exact him (im_eq_zero_of_mem_segment_neg hza)
  · exact hre (re_eq_zero_of_mem_segment_neg_I hza)
  · obtain ⟨θ, -, rfl⟩ := hza
    exact hn (by simp)

/-- The unit circle lies in `quadRing`'s `Γ`. -/
theorem quadRing_ringPt_mem_Γ {θ : ℝ} (hθ : θ ∈ Icc 0 (2 * π)) : ringPt 0 θ ∈ quadRing.Γ :=
  ⟨by simp [ringPt, quadRing], mem_iUnion₂.mpr ⟨Arc.circ 0 1 0 (2 * π), by simp [quadRing],
    ⟨θ, hθ, by simp [ringPt]⟩⟩⟩

/-- The point `t e(θ)` of the open first quadrant, `0 < t < 2`, `t ≠ 1`, has `quadRing`'s colour `0` inside the
circle and `2` outside. -/
theorem quadRing_col_first {θ t : ℝ} (hθ : θ ∈ Ioo 0 (π / 2)) (ht : 0 < t) :
    quadRing.col (t * e θ) = if 1 < t then 2 else 0 := by
  have hc : 0 < Real.cos θ := Real.cos_pos_of_mem_Ioo ⟨by linarith [hθ.1, Real.pi_pos], hθ.2⟩
  have hs : 0 < Real.sin θ := Real.sin_pos_of_pos_of_lt_pi hθ.1 (by linarith [hθ.2, Real.pi_pos])
  have hre : (↑t * e θ).re = t * Real.cos θ := by simp [e_eq, Complex.cos_ofReal_re]
  have him : (↑t * e θ).im = t * Real.sin θ := by simp [e_eq, Complex.sin_ofReal_re]
  have hnorm : ‖(t : ℂ) * e θ‖ = t := by rw [norm_mul, norm_e, Complex.norm_real, Real.norm_eq_abs,
    abs_of_pos ht, mul_one]
  show quadrant _ + _ = _
  rw [show quadrant (↑t * e θ) = 0 by simp [quadrant, hre, him, mul_pos ht hc, mul_pos ht hs], hnorm]
  split_ifs <;> rfl

/-- Near a point of the open first quadrant every point has positive real and imaginary parts. -/
theorem eventually_first_quadrant {θ : ℝ} (hθ : θ ∈ Ioo 0 (π / 2)) :
    ∃ r > 0, ∀ z ∈ ball (ringPt 0 θ) r, 0 < z.re ∧ 0 < z.im := by
  have hc : 0 < Real.cos θ := Real.cos_pos_of_mem_Ioo ⟨by linarith [hθ.1, Real.pi_pos], hθ.2⟩
  have hs : 0 < Real.sin θ := Real.sin_pos_of_pos_of_lt_pi hθ.1 (by linarith [hθ.2, Real.pi_pos])
  refine ⟨min (Real.cos θ) (Real.sin θ), lt_min hc hs, fun z hz => ?_⟩
  rw [mem_ball, dist_eq_norm, show ringPt 0 θ = (Real.cos θ : ℂ) + (Real.sin θ : ℂ) * I by
    rw [ringPt, zero_add, e_eq]] at hz
  have h1 := Complex.abs_re_le_norm (z - ((Real.cos θ : ℂ) + (Real.sin θ : ℂ) * I))
  have h2 := Complex.abs_im_le_norm (z - ((Real.cos θ : ℂ) + (Real.sin θ : ℂ) * I))
  simp only [Complex.sub_re, Complex.sub_im, Complex.add_re, Complex.add_im,
    Complex.ofReal_re, Complex.ofReal_im, Complex.mul_re, Complex.mul_im, Complex.I_re, Complex.I_im,
    mul_zero, mul_one, sub_zero, zero_add, add_zero] at h1 h2
  have := min_le_left (Real.cos θ) (Real.sin θ)
  have := min_le_right (Real.cos θ) (Real.sin θ)
  constructor
  · have := (abs_lt.mp (lt_of_le_of_lt h1 hz)).1; linarith
  · have := (abs_lt.mp (lt_of_le_of_lt h2 hz)).1; linarith

/-- A point `t e(θ)` of the open first quadrant, `0 < t < 2`, `t ≠ 1`, lies in `quadRing`'s colour class of
colour `0` inside the circle and `2` outside. -/
theorem quadRing_first_mem_region {θ t : ℝ} (hθ : θ ∈ Ioo 0 (π / 2)) (ht0 : 0 < t) (ht2 : t < 2) (ht1 : t ≠ 1) :
    (t : ℂ) * e θ ∈ quadRing.region (if 1 < t then 2 else 0) := by
  have hc : 0 < Real.cos θ := Real.cos_pos_of_mem_Ioo ⟨by linarith [hθ.1, Real.pi_pos], hθ.2⟩
  have hs : 0 < Real.sin θ := Real.sin_pos_of_pos_of_lt_pi hθ.1 (by linarith [hθ.2, Real.pi_pos])
  have hnorm : ‖(t : ℂ) * e θ‖ = t := by rw [norm_mul, norm_e, Complex.norm_real, Real.norm_eq_abs,
    abs_of_pos ht0, mul_one]
  refine ⟨quadRing_mem_interiorPts (by rw [hnorm]; exact ht2) ?_ ?_ (by rw [hnorm]; exact ht1), ?_⟩
  · simp only [e_eq, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, Complex.add_re, Complex.add_im,
      Complex.mul_im, Complex.I_re, Complex.I_im, mul_zero, mul_one, sub_zero, zero_mul, add_zero, zero_add]
    exact (mul_pos ht0 hc).ne'
  · simp only [e_eq, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, Complex.add_re, Complex.add_im,
      Complex.mul_re, Complex.I_re, Complex.I_im, mul_zero, mul_one, sub_zero, zero_mul, add_zero, zero_add]
    exact (mul_pos ht0 hs).ne'
  · exact quadRing_col_first hθ ht0

/-- `|((1 ± η) e θ) − e θ| = η`. -/
theorem dist_scale_e (θ η : ℝ) (hη : 0 ≤ η) (s : ℝ) (hs : s = 1 ∨ s = -1) :
    dist (((1 + s * η : ℝ) : ℂ) * e θ) (ringPt 0 θ) = η := by
  rw [ringPt, zero_add, dist_eq_norm, show ((1 + s * η : ℝ) : ℂ) * e θ - e θ = ((s * η : ℝ) : ℂ) * e θ by
    push_cast; ring, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_mul]
  rcases hs with rfl | rfl <;> simp [abs_of_nonneg hη]

/-- The quarter `[0, π/2]` of `quadRing`'s ring is an **arc of `Γ` with constant sides**: inner colour `0`, outer
colour `2`. -/
theorem quadRing_isRingArc : quadRing.IsRingArc 0 0 (π / 2) 0 2 := by
  refine ⟨by positivity, ?_, fun θ hθ => ⟨?_, ?_⟩⟩
  · rintro _ ⟨θ, hθ, rfl⟩
    exact quadRing_ringPt_mem_Γ ⟨hθ.1, by linarith [hθ.2, Real.pi_pos]⟩
  · obtain ⟨r, hr, hq⟩ := eventually_first_quadrant hθ
    ext d
    simp only [ArcMap.innerColours, mem_setOf_eq, mem_singleton_iff]
    constructor
    · intro hd
      obtain ⟨z, ⟨⟨-, hzc⟩, hzb⟩, hzd⟩ := Metric.mem_closure_iff.mp hd r hr
      have hz := hq z (by rw [mem_ball, dist_comm]; exact hzd)
      have hz1 : ‖z‖ < 1 := by simpa using hzb
      have : quadRing.col z = 0 := by
        show quadrant z + _ = 0
        simp [quadrant, hz.1, hz.2, not_lt.mpr hz1.le]
      exact hzc.symm.trans this
    · rintro rfl
      rw [Metric.mem_closure_iff]
      intro ε hε
      set η := min (ε / 2) (1 / 2) with hη
      have hη0 : 0 < η := lt_min (by linarith) (by norm_num)
      have hη1 : η ≤ 1 / 2 := min_le_right _ _
      have hηε : η < ε := lt_of_le_of_lt (min_le_left _ _) (by linarith)
      have hmem := quadRing_first_mem_region hθ (t := 1 + (-1) * η) (by linarith) (by linarith) (by linarith)
      rw [if_neg (by linarith)] at hmem
      refine ⟨_, ⟨hmem, ?_⟩, ?_⟩
      · rw [mem_ball, dist_zero_right, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs,
          abs_of_pos (by linarith)]
        linarith
      · rw [dist_comm, dist_scale_e θ η hη0.le (-1) (Or.inr rfl)]; exact hηε
  · obtain ⟨r, hr, hq⟩ := eventually_first_quadrant hθ
    ext d
    simp only [ArcMap.outerColours, mem_setOf_eq, mem_singleton_iff]
    constructor
    · intro hd
      obtain ⟨z, ⟨⟨-, hzc⟩, hzb⟩, hzd⟩ := Metric.mem_closure_iff.mp hd r hr
      have hz := hq z (by rw [mem_ball, dist_comm]; exact hzd)
      have hz1 : 1 < ‖z‖ := by simpa using hzb
      have : quadRing.col z = 2 := by
        show quadrant z + _ = 2
        simp [quadrant, hz.1, hz.2, hz1]
      exact hzc.symm.trans this
    · rintro rfl
      rw [Metric.mem_closure_iff]
      intro ε hε
      set η := min (ε / 2) (1 / 2) with hη
      have hη0 : 0 < η := lt_min (by linarith) (by norm_num)
      have hη1 : η ≤ 1 / 2 := min_le_right _ _
      have hηε : η < ε := lt_of_le_of_lt (min_le_left _ _) (by linarith)
      have hmem := quadRing_first_mem_region hθ (t := 1 + 1 * η) (by linarith) (by linarith) (by linarith)
      rw [if_pos (by linarith)] at hmem
      refine ⟨_, ⟨hmem, ?_⟩, ?_⟩
      · rw [mem_closedBall, dist_zero_right, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs,
          abs_of_pos (by linarith)]
        linarith
      · rw [dist_comm, dist_scale_e θ η hη0.le 1 (Or.inl rfl)]; exact hηε

/-- `quadRing` carries all four colours at the centre. -/
theorem quadRing_coloursAt_zero : quadRing.coloursAt 0 = univ := by
  ext j
  simp only [ArcMap.coloursAt, mem_setOf_eq, mem_univ, iff_true]
  rw [Metric.mem_closure_iff]
  intro ε hε
  set t := min (ε / 4) (1 / 4) with ht
  have ht0 : 0 < t := lt_min (by linarith) (by norm_num)
  have ht1 : t ≤ 1 / 4 := min_le_right _ _
  have htε : t ≤ ε / 4 := min_le_left _ _
  -- the point `t (±1 ± i)` of the quadrant of colour `j`
  set a : ℝ := if j = 0 ∨ j = 3 then t else -t
  set b : ℝ := if j = 0 ∨ j = 1 then t else -t
  have ha : |a| = t := by simp only [a]; split_ifs <;> simp [abs_of_pos ht0]
  have hb : |b| = t := by simp only [b]; split_ifs <;> simp [abs_of_pos ht0]
  have hnorm : ‖(⟨a, b⟩ : ℂ)‖ ≤ 2 * t := by
    calc ‖(⟨a, b⟩ : ℂ)‖ ≤ |(⟨a, b⟩ : ℂ).re| + |(⟨a, b⟩ : ℂ).im| := Complex.norm_le_abs_re_add_abs_im _
      _ = 2 * t := by simp [ha, hb]; ring
  have hcol : quadRing.col ⟨a, b⟩ = j := by
    show quadrant _ + _ = j
    rw [if_neg (by linarith)]
    fin_cases j <;> simp [quadrant, a, b, ht0, not_lt.mpr ht0.le]
  refine ⟨⟨a, b⟩, ⟨quadRing_mem_interiorPts (by linarith) ?_ ?_ (by linarith), hcol⟩, ?_⟩
  · intro h; have : |a| = 0 := by simp [show a = 0 from h]
    linarith
  · intro h; have : |b| = 0 := by simp [show b = 0 from h]
    linarith
  · rw [dist_comm, dist_zero_right]; linarith

/-- The quarter `[0, π/2]` is a **(Q) arc** of `quadRing`'s ring about `0`. -/
theorem quadRing_isQArc : quadRing.IsQArc 0 0 (π / 2) :=
  ⟨0, 2, quadRing_isRingArc, by simp [quadRing_coloursAt_zero], by simp [quadRing_coloursAt_zero],
    by rw [quadRing_coloursAt_zero, ncard_univ, Nat.card_eq_fintype_card, Fintype.card_fin]⟩

/-- The germ just counter-clockwise of `r(π/4)` lies on a (Q) arc. -/
example : quadRing.GermOnQ 0 (π / 4) .ccw := by
  refine ⟨0, π / 2, quadRing_isQArc, π / 4, by positivity, ?_⟩
  rintro _ ⟨t, ⟨ht0, ht1⟩, rfl⟩
  exact ⟨π / 4 + Side.ccw.sign * t, ⟨by simp [Side.sign]; linarith [Real.pi_pos], by
    simp [Side.sign]; linarith⟩, rfl⟩

/-- **Adversary**: no ring point of `quadRing` is a change point (the whole ring lies in `Γ`). -/
example (ψ : ℝ) (X X' : Fin 4) : ¬ quadRing.IsChangePoint 0 ψ X X' := by
  rintro ⟨-, -, ⟨δ, hδ, hsub⟩, -⟩
  have hmem := hsub ⟨δ / 2, ⟨by linarith, by linarith⟩, rfl⟩
  have hint := quadRing.region_subset_interiorPts X hmem
  apply hint.2
  refine mem_iUnion₂.mpr ⟨Arc.circ 0 1 0 (2 * π), by simp [quadRing], ?_⟩
  -- every point of the unit circle is on the circular arc
  set z := ringPt 0 (ψ + Side.ccw.sign * (δ / 2))
  have hz1 : ‖z‖ = 1 := by simp [z, ringPt]
  have hx0 : z ≠ 0 := by rintro h; rw [h] at hz1; simp at hz1
  by_cases ha : 0 ≤ z.arg
  · refine ⟨z.arg, ⟨ha, by linarith [Complex.arg_le_pi z, Real.pi_pos]⟩, ?_⟩
    have := Complex.norm_mul_exp_arg_mul_I z
    rw [hz1, Complex.ofReal_one, one_mul] at this
    simpa [e] using this
  · push Not at ha
    refine ⟨z.arg + 2 * π, ⟨by linarith [Complex.neg_pi_lt_arg z], by linarith⟩, ?_⟩
    have := Complex.norm_mul_exp_arg_mul_I z
    rw [hz1, Complex.ofReal_one, one_mul] at this
    simp only [zero_add]
    rw [e_add_two_pi]
    simpa [e] using this

/-- `r(π/4)` lies on an arc of `Γ` on `quadRing`'s ring, and `r(0)` on a closed (Q) arc (its end). -/
example : quadRing.OnRingArc 0 (ringPt 0 (π / 4)) ∧ quadRing.OnQArc 0 (ringPt 0 0) :=
  ⟨⟨0, π / 2, by positivity, ⟨π / 4, ⟨by positivity, by linarith [Real.pi_pos]⟩, rfl⟩, quadRing_isRingArc.2.1⟩,
    ⟨0, π / 2, quadRing_isQArc, ⟨0, ⟨le_rfl, by positivity⟩, rfl⟩⟩⟩

/-! ## Density at a point, restriction, initial pieces -/

/-- The empty set has upper density `0` everywhere. -/
theorem upperDensityAt_empty (x : ℂ) : upperDensityAt ∅ x = 0 := by
  have : densityRatio ∅ x = fun _ => 0 := by funext r; simp [densityRatio]
  rw [upperDensityAt, this, limsup_const]

/-- The plane has upper density `1` everywhere. -/
theorem upperDensityAt_univ (x : ℂ) : upperDensityAt univ x = 1 := by
  rw [upperDensityAt]
  have : densityRatio univ x =ᶠ[𝓝[>] 0] fun _ => 1 := by
    filter_upwards [self_mem_nhdsWithin] with r hr using densityRatio_univ x hr
  rw [limsup_congr this, limsup_const]

/-- The one-colour map of the plane: its essential multicolour is its colour everywhere, so no point is an essential
boundary point, and it is saturated everywhere. -/
example (w : ℂ) :
    (ArcMap.const univ isOpen_univ (0 : Fin 2)).essColours w = {0} ∧
      ¬ (ArcMap.const univ isOpen_univ (0 : Fin 2)).IsEssBoundary w ∧
      (ArcMap.const univ isOpen_univ (0 : Fin 2)).SaturatedAt w := by
  have hreg : ∀ j : Fin 2, (ArcMap.const univ isOpen_univ (0 : Fin 2)).region j = if j = 0 then univ else ∅ := by
    intro j
    ext z
    simp only [ArcMap.region, ArcMap.const_interiorPts, mem_inter_iff, mem_univ, mem_preimage, mem_singleton_iff,
      true_and]
    show (0 : Fin 2) = j ↔ _
    split_ifs with h <;> simp [h, eq_comm]
  have hess : (ArcMap.const univ isOpen_univ (0 : Fin 2)).essColours w = {0} := by
    ext j
    simp only [ArcMap.essColours, mem_setOf_eq, mem_singleton_iff, hreg]
    split_ifs with h
    · simp [h, upperDensityAt_univ]
    · simp [h, upperDensityAt_empty]
  refine ⟨hess, ?_, ?_⟩
  · simp [ArcMap.IsEssBoundary, hess]
  · intro j hj
    rw [hess, mem_singleton_iff] at hj
    subst hj
    rw [hreg, if_pos rfl]
    exact ⟨w + 1, fun r hr => by simpa using measure_ball_pos MeasureTheory.volume (w + 1) hr, by simp⟩

/-- The tiles of the one-colour map of a disc: the disc alone. -/
theorem const_ball_isTile_iff {T : Set ℂ} (j : Fin 2) :
    (ArcMap.const (ball (0 : ℂ) 2) isOpen_ball j).IsTile T ↔ T = ball 0 2 := by
  constructor
  · rintro ⟨x, hx, rfl⟩
    rw [ArcMap.const_interiorPts] at hx ⊢
    exact (convex_ball (0 : ℂ) 2).isPreconnected.connectedComponentIn hx
  · rintro rfl
    refine ⟨0, by simp, ?_⟩
    rw [ArcMap.const_interiorPts]
    exact ((convex_ball (0 : ℂ) 2).isPreconnected.connectedComponentIn (by simp)).symm

/-- The disc is a tile of colour `j` of the one-colour map of the disc. -/
example (j : Fin 2) : (ArcMap.const (ball (0 : ℂ) 2) isOpen_ball j).TileOf j (ball 0 2) :=
  ⟨(const_ball_isTile_iff j).mpr rfl, fun _ _ => rfl⟩

/-- The whole-tile restriction of the one-colour map of `B(0, 2)` about `0` keeps the disc: its one tile meets
`B(0, 1)`, and the interior of its closure is the disc. -/
example (j : Fin 2) : (ArcMap.const (ball (0 : ℂ) 2) isOpen_ball j).wholeDom 0 1 = ball 0 2 := by
  have hfam : {S | ∃ T, (ArcMap.const (ball (0 : ℂ) 2) isOpen_ball j).IsTile T ∧ (T ∩ ball 0 1).Nonempty ∧
      S = closure T} = {closedBall 0 2} := by
    ext S
    simp only [mem_setOf_eq, mem_singleton_iff, const_ball_isTile_iff]
    constructor
    · rintro ⟨T, rfl, -, rfl⟩
      exact closure_ball 0 (by norm_num)
    · rintro rfl
      exact ⟨ball 0 2, rfl, ⟨0, by simp, by simp⟩, (closure_ball 0 (by norm_num)).symm⟩
  rw [ArcMap.wholeDom, hfam, sUnion_singleton, interior_closedBall 0 (by norm_num)]
  exact inter_self _

/-- The segment `[0, 1]` is an initial piece of the segment `[0, 2]` leaving `0` in the direction `0`. -/
example : (Arc.seg 0 2).InitialPiece 0 0 (segment ℝ 0 1) := by
  refine ⟨1, one_pos, by simp [e], ?_⟩
  refine (convex_segment (0 : ℂ) 2).segment_subset (left_mem_segment ℝ 0 2) ?_
  refine ⟨1 / 2, 1 / 2, by norm_num, by norm_num, by norm_num, ?_⟩
  norm_num

/-- **Adversary**: the segment `[0, −1]` is no initial piece of the segment `[0, 2]` (it leaves the wrong way). -/
example : ¬ (Arc.seg 0 2).InitialPiece 0 π (segment ℝ 0 (-1)) := by
  rintro ⟨ε, -, -, hsub⟩
  obtain ⟨a, b, ha, hb, hab, h⟩ := hsub (right_mem_segment ℝ 0 (-1))
  have := congrArg Complex.re h
  simp at this
  linarith

/-- The quarter of the unit circle from `1` to `e(π/4)` is an initial piece of the upper half circle leaving `1` in
the direction `π/2`. -/
example : (Arc.circ 0 1 0 π).InitialPiece 1 (π / 2) ((fun t : ℝ => 0 + 1 * e (0 + 1 * t)) '' Icc 0 (π / 4)) := by
  refine ⟨one_pos, 0, π / 4, 1, Or.inl rfl, by positivity, by simp [e], by simp, rfl, ?_⟩
  rintro _ ⟨t, ⟨ht0, ht1⟩, rfl⟩
  exact ⟨by simpa using ht0, by simp; linarith [Real.pi_pos]⟩

end HadwigerNelson.Plane
