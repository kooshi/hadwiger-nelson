import Proofs.HadwigerNelson.Plane.ValidMap.Sectors

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- `e(β + π/2) − e(β + π/2 + 2a) = 2 sin a · e(β + a)`: the chord from the start of a circle through `v` to its point at angle
`2a` further on. -/
theorem e_sub_e_two_mul (β a : ℝ) :
    e (β + π / 2) - e (β + π / 2 + 2 * a) = ((2 * Real.sin a : ℝ) : ℂ) * e (β + a) := by
  apply Complex.ext
  · simp only [Complex.sub_re, re_e, Complex.re_ofReal_mul, Real.sin_add, Real.cos_add, Real.cos_pi_div_two,
      Real.sin_pi_div_two, Real.sin_two_mul, Real.cos_two_mul]
    linear_combination (2 * Real.sin β) * Real.sin_sq_add_cos_sq a
  · simp only [Complex.sub_im, im_e, Complex.im_ofReal_mul, Real.sin_add, Real.cos_add, Real.cos_pi_div_two,
      Real.sin_pi_div_two, Real.sin_two_mul, Real.cos_two_mul]
    linear_combination (-2 * Real.cos β) * Real.sin_sq_add_cos_sq a

/-- **A branch point on its circle**: for `κ ≠ 0` the branch point at distance `s` is the point of the circle of radius `1/|κ|` about
`v + n/κ` at the angle `2 arcsin(κ s/2)` past `v`, written as `v + (1/κ)(e(β + π/2) − e(β + π/2 + 2 arcsin(κ s/2)))`. -/
theorem branchPt_eq_circle (v : ℂ) (β : ℝ) {κ s : ℝ} (hκ : κ ≠ 0) (hs : |κ * s / 2| ≤ 1) :
    branchPt v β κ s = v + ((1 / κ : ℝ) : ℂ) * (e (β + π / 2) - e (β + π / 2 + 2 * Real.arcsin (κ * s / 2))) := by
  rw [e_sub_e_two_mul, Real.sin_arcsin (abs_le.mp hs).1 (abs_le.mp hs).2, branchPt, ← mul_assoc, ← Complex.ofReal_mul]
  congr 3
  field_simp

/-- **The arc of a branch germ**: the segment `[v, v + ρ e β]` for `κ = 0`, otherwise the arc of the circle of radius `1/|κ|` about
`v + n/κ` from `v` through the angle `2 arcsin(κρ/2)` (counter-clockwise for `κ > 0`, clockwise for `κ < 0`). Its carrier is the
branch `branchPt v β κ '' [0, ρ]` (`carrier_germArc`). -/
noncomputable def germArc (v : ℂ) (β κ ρ : ℝ) : Arc :=
  if κ = 0 then .seg v (v + (ρ : ℂ) * e β)
  else if 0 < κ then
    .circ (v + ((1 / κ : ℝ) : ℂ) * e (β + π / 2)) (1 / κ) (β - π / 2) (β - π / 2 + 2 * Real.arcsin (κ * ρ / 2))
  else .circ (v + ((1 / κ : ℝ) : ℂ) * e (β + π / 2)) (-(1 / κ)) (β + π / 2 + 2 * Real.arcsin (κ * ρ / 2)) (β + π / 2)

/-- `κ s / 2 ∈ [−1, 1]` on `[0, ρ]` when `|κ| ρ ≤ 2`. -/
theorem abs_half_le_one {κ ρ s : ℝ} (hκρ : |κ| * ρ ≤ 2) (hs : s ∈ Icc 0 ρ) : |κ * s / 2| ≤ 1 := by
  have := half_curv_mem_Icc hκρ hs.1 hs.2
  exact abs_le.mpr this

/-- **The carrier of a germ's arc is its branch**: `(germArc v β κ ρ).carrier = branchPt v β κ '' [0, ρ]` for `0 ≤ ρ`, `|κ| ρ ≤ 2`. -/
theorem carrier_germArc (v : ℂ) (β : ℝ) {κ ρ : ℝ} (hρ : 0 ≤ ρ) (hκρ : |κ| * ρ ≤ 2) :
    (germArc v β κ ρ).carrier = branchPt v β κ '' Icc 0 ρ := by
  have hπ := Real.pi_pos
  unfold germArc
  split_ifs with h0 hpos
  · -- the segment
    subst h0
    have hb : ∀ s, branchPt v β 0 s = v + (s : ℂ) * e β := fun s => by simp [branchPt]
    simp only [Arc.carrier, hb]
    rw [segment_eq_image']
    ext z
    simp only [mem_image, mem_Icc]
    constructor
    · rintro ⟨t, ⟨ht0, ht1⟩, rfl⟩
      refine ⟨t * ρ, ⟨by positivity, by nlinarith⟩, ?_⟩
      simp only [add_sub_cancel_left, Complex.real_smul]; push_cast; ring
    · rintro ⟨s, ⟨hs0, hsρ⟩, rfl⟩
      rcases hρ.lt_or_eq with hρ' | hρ'
      · refine ⟨s / ρ, ⟨by positivity, (div_le_one hρ').mpr hsρ⟩, ?_⟩
        simp only [add_sub_cancel_left, Complex.real_smul]; push_cast
        have hρc : (ρ : ℂ) ≠ 0 := by exact_mod_cast hρ'.ne'
        field_simp
      · subst hρ'
        have : s = 0 := le_antisymm hsρ hs0
        subst this
        exact ⟨0, ⟨le_rfl, zero_le_one⟩, by simp⟩
  · -- `κ > 0`: the angle `β − π/2 + 2 arcsin(κ s/2)`
    have hb : ∀ s ∈ Icc 0 ρ, branchPt v β κ s =
        (v + ((1 / κ : ℝ) : ℂ) * e (β + π / 2)) + ((1 / κ : ℝ) : ℂ) * e (β - π / 2 + 2 * Real.arcsin (κ * s / 2)) := by
      intro s hs
      have hnp : ∀ x, e (x + -π) = -e x := fun x => by
        rw [e_add, show e (-π) = -1 by rw [e_eq]; simp]; ring
      rw [branchPt_eq_circle v β h0 (abs_half_le_one hκρ hs),
        show β - π / 2 + 2 * Real.arcsin (κ * s / 2) = (β + π / 2 + 2 * Real.arcsin (κ * s / 2)) + -π by ring, hnp]
      ring
    have hA : Real.arcsin (κ * ρ / 2) ≤ π / 2 := Real.arcsin_le_pi_div_two _
    ext z
    simp only [Arc.carrier, mem_image, mem_Icc]
    constructor
    · rintro ⟨θ, ⟨h1, h2⟩, rfl⟩
      set t := (θ - (β - π / 2)) / 2 with ht
      have ht0 : 0 ≤ t := by rw [ht]; linarith
      have htA : t ≤ Real.arcsin (κ * ρ / 2) := by rw [ht]; linarith
      have htπ : t ≤ π / 2 := htA.trans hA
      refine ⟨2 * Real.sin t / κ, ⟨by have := Real.sin_nonneg_of_nonneg_of_le_pi ht0 (by linarith); positivity, ?_⟩, ?_⟩
      · rw [div_le_iff₀ hpos]
        have hsin : Real.sin t ≤ κ * ρ / 2 := by
          have hk : κ * ρ / 2 ∈ Icc (-1 : ℝ) 1 := half_curv_mem_Icc hκρ hρ le_rfl
          calc Real.sin t ≤ Real.sin (Real.arcsin (κ * ρ / 2)) :=
                Real.sin_le_sin_of_le_of_le_pi_div_two (by linarith) (Real.arcsin_le_pi_div_two _) htA
            _ = κ * ρ / 2 := Real.sin_arcsin hk.1 hk.2
        linarith
      · have hs : 2 * Real.sin t / κ ∈ Icc 0 ρ := ⟨by
            have := Real.sin_nonneg_of_nonneg_of_le_pi ht0 (by linarith); positivity, by
            rw [div_le_iff₀ hpos]
            have hk : κ * ρ / 2 ∈ Icc (-1 : ℝ) 1 := half_curv_mem_Icc hκρ hρ le_rfl
            have := Real.sin_le_sin_of_le_of_le_pi_div_two (by linarith) (Real.arcsin_le_pi_div_two _) htA
            rw [Real.sin_arcsin hk.1 hk.2] at this
            linarith⟩
        rw [hb _ hs]
        have harc : Real.arcsin (κ * (2 * Real.sin t / κ) / 2) = t := by
          rw [show κ * (2 * Real.sin t / κ) / 2 = Real.sin t by field_simp]
          exact Real.arcsin_sin (by linarith) htπ
        rw [harc, ht]
        congr 2
        ring_nf
    · rintro ⟨s, hs, rfl⟩
      refine ⟨β - π / 2 + 2 * Real.arcsin (κ * s / 2), ⟨?_, ?_⟩, (hb s hs).symm⟩
      · have : 0 ≤ Real.arcsin (κ * s / 2) := Real.arcsin_nonneg.mpr (by have := hs.1; positivity)
        linarith
      · have : Real.arcsin (κ * s / 2) ≤ Real.arcsin (κ * ρ / 2) :=
          Real.arcsin_le_arcsin (by nlinarith [hs.2])
        linarith
  · -- `κ < 0`: the angle `β + π/2 + 2 arcsin(κ s/2)`, decreasing in `s`
    have hneg : κ < 0 := lt_of_le_of_ne (not_lt.mp hpos) h0
    have hb : ∀ s ∈ Icc 0 ρ, branchPt v β κ s =
        (v + ((1 / κ : ℝ) : ℂ) * e (β + π / 2)) + ((-(1 / κ) : ℝ) : ℂ) * e (β + π / 2 + 2 * Real.arcsin (κ * s / 2)) := by
      intro s hs
      rw [branchPt_eq_circle v β h0 (abs_half_le_one hκρ hs)]
      push_cast
      ring
    have hA : -(π / 2) ≤ Real.arcsin (κ * ρ / 2) := Real.neg_pi_div_two_le_arcsin _
    ext z
    simp only [Arc.carrier, mem_image, mem_Icc]
    constructor
    · rintro ⟨θ, ⟨h1, h2⟩, rfl⟩
      set t := (θ - (β + π / 2)) / 2 with ht
      have ht0 : t ≤ 0 := by rw [ht]; linarith
      have htA : Real.arcsin (κ * ρ / 2) ≤ t := by rw [ht]; linarith
      have htπ : -(π / 2) ≤ t := hA.trans htA
      have hsin0 : Real.sin t ≤ 0 := Real.sin_nonpos_of_nonpos_of_neg_pi_le ht0 (by linarith)
      have hk : κ * ρ / 2 ∈ Icc (-1 : ℝ) 1 := half_curv_mem_Icc hκρ hρ le_rfl
      have hsinA : κ * ρ / 2 ≤ Real.sin t := by
        have := Real.sin_le_sin_of_le_of_le_pi_div_two hA (by linarith) htA
        rwa [Real.sin_arcsin hk.1 hk.2] at this
      have hs : 2 * Real.sin t / κ ∈ Icc 0 ρ := by
        refine ⟨div_nonneg_of_nonpos (by linarith) hneg.le, ?_⟩
        rw [div_le_iff_of_neg hneg]
        linarith
      refine ⟨2 * Real.sin t / κ, hs, ?_⟩
      rw [hb _ hs]
      have harc : Real.arcsin (κ * (2 * Real.sin t / κ) / 2) = t := by
        rw [show κ * (2 * Real.sin t / κ) / 2 = Real.sin t by field_simp]
        exact Real.arcsin_sin htπ (by linarith)
      rw [harc, ht]
      congr 2
      ring_nf
    · rintro ⟨s, hs, rfl⟩
      refine ⟨β + π / 2 + 2 * Real.arcsin (κ * s / 2), ⟨?_, ?_⟩, (hb s hs).symm⟩
      · have : Real.arcsin (κ * ρ / 2) ≤ Real.arcsin (κ * s / 2) :=
          Real.arcsin_le_arcsin (by nlinarith [hs.2])
        linarith
      · have : Real.arcsin (κ * s / 2) ≤ 0 := Real.arcsin_nonpos.mpr (by nlinarith [hs.1])
        linarith

/-- A germ's arc out to a positive distance is non-degenerate. -/
theorem germArc_nondegenerate (v : ℂ) (β κ : ℝ) {ρ : ℝ} (hρ : 0 < ρ) :
    (germArc v β κ ρ).Nondegenerate := by
  have hπ := Real.pi_pos
  unfold germArc
  split_ifs with h0 hpos
  · show v ≠ v + (ρ : ℂ) * e β
    intro h
    have := congrArg (fun z => ‖z - v‖) h
    simp at this
    rw [abs_of_pos hρ] at this
    linarith
  · refine ⟨by positivity, ?_, ?_⟩
    · have : 0 < Real.arcsin (κ * ρ / 2) := Real.arcsin_pos.mpr (by positivity)
      linarith
    · have := Real.arcsin_le_pi_div_two (κ * ρ / 2)
      linarith
  · have hneg : κ < 0 := lt_of_le_of_ne (not_lt.mp hpos) h0
    refine ⟨by have : 1 / κ < 0 := by rw [one_div]; exact inv_lt_zero.mpr hneg
               linarith, ?_, ?_⟩
    · have : Real.arcsin (κ * ρ / 2) < 0 := Real.arcsin_lt_zero.mpr (by nlinarith)
      linarith
    · have := Real.neg_pi_div_two_le_arcsin (κ * ρ / 2)
      linarith

/-- A germ's arc is a unit arc exactly when its curvature is `±1`. -/
theorem germArc_isUnitArc_iff (v : ℂ) (β κ ρ : ℝ) : (germArc v β κ ρ).IsUnitArc ↔ |κ| = 1 := by
  unfold germArc
  split_ifs with h0 hpos
  · subst h0; simp [Arc.IsUnitArc]
  · show 1 / κ = 1 ↔ |κ| = 1
    rw [abs_of_pos hpos, div_eq_one_iff_eq hpos.ne', eq_comm]
  · have hneg : κ < 0 := lt_of_le_of_ne (not_lt.mp hpos) h0
    show -(1 / κ) = 1 ↔ |κ| = 1
    rw [abs_of_neg hneg]
    constructor
    · intro h; field_simp at h; linarith
    · intro h; have : κ = -1 := by linarith
      subst this; norm_num

/-- Spec: the germ of curvature `1` along `e 0` at `0` out to `1` is a unit arc, its carrier holds `branchPt 0 0 1 1`; the straight germ is
no unit arc. -/
example : (germArc 0 0 1 1).IsUnitArc ∧ ¬ (germArc 0 0 0 1).IsUnitArc ∧
    branchPt 0 0 1 1 ∈ (germArc 0 0 1 1).carrier := by
  refine ⟨(germArc_isUnitArc_iff _ _ _ _).mpr (by norm_num), fun h => by
    rw [germArc_isUnitArc_iff] at h; norm_num at h, ?_⟩
  rw [carrier_germArc 0 0 zero_le_one (by norm_num)]
  exact ⟨1, ⟨zero_le_one, le_rfl⟩, rfl⟩

end HadwigerNelson.Plane
