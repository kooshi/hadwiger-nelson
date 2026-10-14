import Proofs.HadwigerNelson.Arith.ThreeColourCharacter

namespace HadwigerNelson.TorsionExtraction

open HadwigerNelson.CharacterColouring HadwigerNelson.SpectralChain HadwigerNelson.SquareClass SimpleGraph

theorem layer_dichotomy {a b : ℤ → ℝ} (ha : ∀ m, |a m| ≤ 1 / 6) (hb : ∀ m, |b m| ≤ 1 / 6)
    (h1 : ∀ m, ∃ n : ℤ, 2 * a (m + 1) - b (m + 1) - 2 * a m - b m = n)
    (h2 : ∀ m, ∃ n : ℤ, a (m + 1) + 2 * b (m + 1) + a m - 2 * b m = n) :
    (∀ m, a (m + 1) = (3 * a m + 4 * b m) / 5 ∧ b (m + 1) = (-4 * a m + 3 * b m) / 5) ∨
      (∀ m, |a m| = 1 / 6 ∧ |b m| = 1 / 6) := by
  sorry

variable {F : Subfield ℝ}

/-- `1/5 = w + w⁻¹ − 1` as an element of `ℤ[U_F]`. -/
noncomputable def inv5 (F : Subfield ℝ) : unitRing F := ⟨(5 : ℂ)⁻¹, unitRing_mono bot_le inv_five_mem_Qring⟩

@[simp] theorem coe_inv5 (F : Subfield ℝ) : ((inv5 F : unitRing F) : ℂ) = (5 : ℂ)⁻¹ := rfl

/-- **The orbit of a unit vector under `w = (3 + 4i)/5`**, with the three relations the layer argument reads:
`g m = wᵐ b` and `J = i` in `ℤ[U_F]`; `(2 − i) w = 2 + i` at `g m`, its multiple by `i`, and
`g m / 5 = g (m + 1) + g (m − 1) − g m` (`1/5 = w + w⁻¹ − 1`). -/
private theorem exists_orbit {b : unitRing F} (hb : b ∈ unitSet F) :
    ∃ (g : ℤ → unitRing F) (J : unitRing F), g 0 = b ∧ (∀ m, g m ∈ unitSet F) ∧ (∀ m, J * g m ∈ unitSet F) ∧
      (∀ m, g (m + 1) + g (m + 1) - J * g (m + 1) - g m - g m - J * g m = 0) ∧
      (∀ m, g (m + 1) + J * g (m + 1) + J * g (m + 1) + g m - J * g m - J * g m = 0) ∧
      (∀ m, inv5 F * g m = g (m + 1) + g (m - 1) - g m) := by
  have hq : ∀ q : ℚ, (q : ℝ) ∈ F := fun q => SubfieldClass.ratCast_mem F q
  obtain ⟨w, hw⟩ : ∃ w : ℂ, w = ⟨3 / 5, 4 / 5⟩ := ⟨_, rfl⟩
  have hwF : w ∈ unitVectors F := by
    rw [hw]
    refine ⟨⟨by simpa using hq (3 / 5), by simpa using hq (4 / 5)⟩, ?_⟩
    rw [Complex.norm_eq_sqrt_sq_add_sq]
    norm_num
  have hw0 : w ≠ 0 := fun h => by
    have := hwF.2
    rw [h, norm_zero] at this
    exact zero_ne_one this
  have hI : Complex.I ∈ unitVectors F :=
    ⟨⟨by rw [Complex.I_re]; exact F.zero_mem, by rw [Complex.I_im]; exact F.one_mem⟩, Complex.norm_I⟩
  have hrel : (2 - Complex.I) * w = 2 + Complex.I := by
    rw [hw]
    apply Complex.ext
    · simp only [Complex.mul_re, Complex.sub_re, Complex.re_ofNat, Complex.I_re, sub_zero, Complex.sub_im,
        Complex.im_ofNat, Complex.I_im, zero_sub, neg_mul, one_mul, sub_neg_eq_add, Complex.add_re, add_zero]
      norm_num
    · simp only [Complex.mul_im, Complex.sub_re, Complex.re_ofNat, Complex.I_re, sub_zero, Complex.sub_im,
        Complex.im_ofNat, Complex.I_im, zero_sub, neg_mul, one_mul, Complex.add_im, zero_add]
      norm_num
  have hwinv : w⁻¹ = ⟨3 / 5, -(4 / 5)⟩ := by
    refine inv_eq_of_mul_eq_one_right ?_
    rw [hw]
    apply Complex.ext
    · simp only [Complex.mul_re, mul_neg, sub_neg_eq_add, Complex.one_re]
      norm_num
    · simp only [Complex.mul_im, mul_neg, Complex.one_im]
      norm_num
  have hinv : w + w⁻¹ - 1 = 5⁻¹ := by
    rw [hwinv, hw]
    apply Complex.ext
    · simp only [Complex.sub_re, Complex.add_re, Complex.one_re, Complex.inv_re, Complex.re_ofNat,
        Complex.normSq_ofNat, div_self_mul_self']
      norm_num
    · simp
  have hmem : ∀ m : ℤ, w ^ m * (b : ℂ) ∈ unitVectors F := fun m =>
    ⟨(UnitRing.planeOverSubfield F).mul_mem (zpow_mem (show w ∈ UnitRing.planeOverSubfield F from hwF.1) m) hb.1, by
      rw [norm_mul, norm_zpow, hwF.2, one_zpow, one_mul]
      exact hb.2⟩
  refine ⟨fun m => ⟨w ^ m * b, unitVectors_subset_unitRing F (hmem m)⟩, ⟨Complex.I, unitVectors_subset_unitRing F hI⟩,
    Subtype.ext (show w ^ (0 : ℤ) * (b : ℂ) = b by rw [zpow_zero, one_mul]), hmem, fun m => ?_, fun m => ?_, fun m => ?_,
    fun m => ?_⟩
  · exact ⟨(UnitRing.planeOverSubfield F).mul_mem hI.1 (hmem m).1, by
      show ‖Complex.I * (w ^ m * (b : ℂ))‖ = 1
      rw [norm_mul, Complex.norm_I, (hmem m).2, one_mul]⟩
  · apply Subtype.ext
    show w ^ (m + 1) * (b : ℂ) + w ^ (m + 1) * b - Complex.I * (w ^ (m + 1) * b) - w ^ m * b - w ^ m * b -
      Complex.I * (w ^ m * b) = 0
    rw [zpow_add_one₀ hw0]
    linear_combination (w ^ m * b) * hrel
  · apply Subtype.ext
    show w ^ (m + 1) * (b : ℂ) + Complex.I * (w ^ (m + 1) * b) + Complex.I * (w ^ (m + 1) * b) + w ^ m * b -
      Complex.I * (w ^ m * b) - Complex.I * (w ^ m * b) = 0
    rw [zpow_add_one₀ hw0]
    linear_combination (w ^ m * b * Complex.I) * hrel + (w ^ m * w * b + w ^ m * b) * Complex.I_sq
  · apply Subtype.ext
    show (5 : ℂ)⁻¹ * (w ^ m * (b : ℂ)) = w ^ (m + 1) * b + w ^ (m - 1) * b - w ^ m * b
    rw [zpow_add_one₀ hw0, zpow_sub_one₀ hw0]
    linear_combination (-(w ^ m * b)) * hinv

/-- A point of `band 3 = [1/3, 2/3]` is `1/2 + x` with `|x| ≤ 1/6`. -/
private theorem exists_lift_of_mem_band_three {t : UnitAddCircle} (h : t ∈ band 3) :
    ∃ x : ℝ, |x| ≤ 1 / 6 ∧ t = ((1 / 2 + x : ℝ) : UnitAddCircle) := by
  obtain ⟨y, ⟨hy1, hy2⟩, rfl⟩ := h
  push_cast at hy1 hy2
  refine ⟨y - 1 / 2, abs_le.mpr ⟨by linarith, by linarith⟩, ?_⟩
  show (y : UnitAddCircle) = ((1 / 2 + (y - 1 / 2) : ℝ) : UnitAddCircle)
  congr 1
  ring

/-- **A rotation layer along `5⁻ᵏ`**: `θ(5⁻ᵏ g_m) = 1/2 + a_m / 5ᵏ`. (Induction on the depth `k`, the layer index `m`
inside: the step reads `m ± 1`, and `a_{m+1} + a_{m−1} = (6/5) a_m` on a rotation orbit.) -/
private theorem rotation_layer {θ : unitRing F →+ UnitAddCircle} {g : ℤ → unitRing F} {a bb : ℤ → ℝ}
    (hg : ∀ m, inv5 F * g m = g (m + 1) + g (m - 1) - g m)
    (ha : ∀ m, θ (g m) = ((1 / 2 + a m : ℝ) : UnitAddCircle))
    (hrot : ∀ m, a (m + 1) = (3 * a m + 4 * bb m) / 5 ∧ bb (m + 1) = (-4 * a m + 3 * bb m) / 5) (k : ℕ) (m : ℤ) :
    θ (inv5 F ^ k * g m) = ((1 / 2 + a m / 5 ^ k : ℝ) : UnitAddCircle) := by
  induction k generalizing m with
  | zero => rw [pow_zero, one_mul, pow_zero, div_one]; exact ha m
  | succ k ih =>
    have hsum : a (m + 1) + a (m - 1) - a m = a m / 5 := by
      have h1 := hrot m
      have h2 := hrot (m - 1)
      rw [sub_add_cancel] at h2
      linarith [h1.1, h2.1, h2.2]
    have hreal : a m / 5 ^ (k + 1) = (a (m + 1) + a (m - 1) - a m) / 5 ^ k := by
      rw [hsum, pow_succ]
      field_simp
    rw [pow_succ, mul_assoc, hg m, mul_sub, mul_add, map_sub, map_add, ih, ih, ih, ← AddCircle.coe_add,
      ← AddCircle.coe_sub, hreal]
    congr 1
    ring

/-- **A corner layer along `5⁻ᵏ`**: `3 • θ(5⁻ᵏ g_m) = 0` at every depth, by the same induction. -/
private theorem corner_layer {θ : unitRing F →+ UnitAddCircle} {g : ℤ → unitRing F}
    (hg : ∀ m, inv5 F * g m = g (m + 1) + g (m - 1) - g m) (h3 : ∀ m, 3 • θ (g m) = 0) (k : ℕ) (m : ℤ) :
    3 • θ (inv5 F ^ k * g m) = 0 := by
  induction k generalizing m with
  | zero => rw [pow_zero, one_mul]; exact h3 m
  | succ k ih =>
    rw [pow_succ, mul_assoc, hg m, mul_sub, mul_add, map_sub, map_add, smul_sub, smul_add, ih, ih, ih, add_zero,
      sub_zero]

theorem tendsto_layer {θ : unitRing F →+ UnitAddCircle} (hθ : θ ∈ fieldBandSet F (band 3)) {b : unitRing F}
    (hb : b ∈ unitSet F) :
    ∃ t : UnitAddCircle, (t = ((1 / 2 : ℝ) : UnitAddCircle) ∨ t = ((1 / 3 : ℝ) : UnitAddCircle) ∨
        t = ((2 / 3 : ℝ) : UnitAddCircle)) ∧
      Filter.Tendsto (fun n : ℕ => θ (inv5 F ^ (2 * n) * b)) Filter.atTop (nhds t) := by
  obtain ⟨g, J, hg0, hgU, hJU, hr1, hr2, hg⟩ := exists_orbit hb
  -- lifts of `θ(g m) − 1/2` and `θ(i g m) − 1/2` to `[−1/6, 1/6]`
  choose a ha ha' using fun m => exists_lift_of_mem_band_three (hθ _ (hgU m))
  choose bb hbb hbb' using fun m => exists_lift_of_mem_band_three (hθ _ (hJU m))
  -- the two relations, read through `θ`
  have h1 : ∀ m, ∃ n : ℤ, 2 * a (m + 1) - bb (m + 1) - 2 * a m - bb m = n := by
    intro m
    have h := congrArg θ (hr1 m)
    simp only [map_sub, map_add, map_zero, ha', hbb', ← AddCircle.coe_add, ← AddCircle.coe_sub] at h
    obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff (1 : ℝ)).mp h
    rw [zsmul_one] at hn
    refine ⟨n + 1, ?_⟩
    push_cast
    linarith
  have h2 : ∀ m, ∃ n : ℤ, a (m + 1) + 2 * bb (m + 1) + a m - 2 * bb m = n := by
    intro m
    have h := congrArg θ (hr2 m)
    simp only [map_sub, map_add, map_zero, ha', hbb', ← AddCircle.coe_add, ← AddCircle.coe_sub] at h
    obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff (1 : ℝ)).mp h
    rw [zsmul_one] at hn
    refine ⟨n - 1, ?_⟩
    push_cast
    linarith
  rcases layer_dichotomy ha hbb h1 h2 with hrot | hcor
  · -- a rotation layer: `θ(25⁻ⁿ b) = 1/2 + a 0 / 25ⁿ → 1/2`
    refine ⟨((1 / 2 : ℝ) : UnitAddCircle), Or.inl rfl, ?_⟩
    have hval : ∀ n : ℕ, θ (inv5 F ^ (2 * n) * b) = ((1 / 2 + a 0 * (1 / 25) ^ n : ℝ) : UnitAddCircle) := by
      intro n
      rw [← hg0, rotation_layer hg ha' hrot (2 * n) 0]
      congr 2
      rw [pow_mul, div_eq_mul_inv, ← inv_pow]
      norm_num
    have hlim : Filter.Tendsto (fun n : ℕ => (1 / 2 + a 0 * (1 / 25 : ℝ) ^ n)) Filter.atTop (nhds (1 / 2 + a 0 * 0)) :=
      tendsto_const_nhds.add ((tendsto_pow_atTop_nhds_zero_of_lt_one (by norm_num) (by norm_num)).const_mul (a 0))
    rw [mul_zero, add_zero] at hlim
    simp only [hval]
    exact ((AddCircle.continuous_mk' (1 : ℝ)).tendsto _).comp hlim
  · -- a corner layer: `3 • θ(5⁻ᵏ b) = 0`, so `θ(25⁻ⁿ b)` is constant at `θ b = 1/2 ± 1/6`
    have h3 : ∀ m, 3 • θ (g m) = 0 := by
      intro m
      rw [ha', ← AddCircle.coe_nsmul, AddCircle.coe_eq_zero_iff]
      rcases (abs_eq (by norm_num : (0 : ℝ) ≤ 1 / 6)).mp (hcor m).1 with h | h
      · exact ⟨2, by rw [h]; norm_num⟩
      · exact ⟨1, by rw [h]; norm_num⟩
    have hconst : ∀ n : ℕ, θ (inv5 F ^ (2 * n) * b) = θ b := by
      intro n
      induction n with
      | zero => rw [mul_zero, pow_zero, one_mul]
      | succ n ih =>
        have h25 : inv5 F ^ (2 * n) * b = 25 • (inv5 F ^ (2 * (n + 1)) * b) := by
          apply Subtype.ext
          rw [nsmul_eq_mul, mul_add, mul_one, pow_add]
          simp only [Subring.coe_mul, Subring.coe_pow, coe_inv5, Subring.coe_natCast]
          push_cast
          ring
        have h3' := corner_layer hg h3 (2 * (n + 1)) 0
        rw [hg0] at h3'
        rw [← ih, h25, map_nsmul, show (25 : ℕ) = 1 + 8 * 3 by norm_num, add_smul, one_smul, mul_smul, h3', smul_zero,
          add_zero]
    have hb0 : θ b = ((1 / 2 + a 0 : ℝ) : UnitAddCircle) := by rw [← hg0, ha']
    simp only [hconst]
    rcases (abs_eq (by norm_num : (0 : ℝ) ≤ 1 / 6)).mp (hcor 0).1 with h | h
    · refine ⟨((2 / 3 : ℝ) : UnitAddCircle), Or.inr (Or.inr rfl), ?_⟩
      rw [hb0, h, show (1 / 2 + 1 / 6 : ℝ) = 2 / 3 by norm_num]
      exact tendsto_const_nhds
    · refine ⟨((1 / 3 : ℝ) : UnitAddCircle), Or.inr (Or.inl rfl), ?_⟩
      rw [hb0, h, show (1 / 2 + -(1 / 6) : ℝ) = 1 / 3 by norm_num]
      exact tendsto_const_nhds

end HadwigerNelson.TorsionExtraction
