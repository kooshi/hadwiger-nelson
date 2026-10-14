/-! ### Private helpers for `archimedean_support`: coordinates in `R`, the lattices `5^{−k}`, tightness, the limit -/

section ArchSupport

/-- `c·𝓞_L ⊆ R` (`ContinuityGroup`'s private `exists_nat_mul_integers_mem`, restated with its proof). -/
private theorem as_natMul_integers_mem [NumberField F] : ∃ c : ℕ, c ≠ 0 ∧ ∀ a : 𝓞 (fieldI F),
    (c : fieldI F) * (a : fieldI F) ∈ UnitRing.unitRing (conjOn (fieldI_conj F)) := by
  obtain ⟨c, hc, hcO⟩ := exists_mul_stableIntegers_le F
  refine ⟨c, hc, fun a => hcO _ ((mem_stableIntegers F).2 fun P => (UpperHalf.mem_localRing P).2
    ⟨a, 1, fun h => P.isMaximal.ne_top ((Ideal.eq_top_iff_one _).2 h), by simp⟩)⟩

open scoped Classical in
/-- **Rational coordinates along a `ℚ`-basis of `L` lying in `R`**: `q j (b i) = δ_{ij}`, and the coordinates of a point
determine it. (`b i = c·ω_i` for an integral basis `ω` and `c·𝓞_L ⊆ R`.) -/
private theorem as_exists_coords [NumberField F] :
    ∃ (ι : Type) (_ : Fintype ι) (b : ι → unitRing F) (q : ι → unitRing F →+ ℚ),
      (∀ i j, q j (b i) = if i = j then 1 else 0) ∧ Function.Injective (fun y j => q j y) := by
  classical
  obtain ⟨c, hc, hcR⟩ := as_natMul_integers_mem F
  let B := RingOfIntegers.basis (fieldI F)
  let β := integralBasis (fieldI F)
  have hβ : ∀ i, β i = (B i : fieldI F) := fun i => integralBasis_apply _ i
  have hc' : (c : ℚ) ≠ 0 := Nat.cast_ne_zero.2 hc
  let b : Module.Free.ChooseBasisIndex ℤ (𝓞 (fieldI F)) → unitRing F := fun i =>
    ⟨(((c : fieldI F) * (B i : fieldI F) : fieldI F) : ℂ), (UnitRing.coe_mem_unitRingOver_iff _).2 (hcR (B i))⟩
  let q : Module.Free.ChooseBasisIndex ℤ (𝓞 (fieldI F)) → unitRing F →+ ℚ := fun j =>
    AddMonoidHom.mk' (fun y => β.repr (toFieldI F y) j / c) fun y y' => by
      rw [map_add, map_add, Finsupp.add_apply, add_div]
  refine ⟨_, inferInstance, b, q, fun i j => ?_, fun y y' h => ?_⟩
  · have hb : toFieldI F (b i) = (c : ℚ) • β i := by
      rw [Rat.smul_def, Rat.cast_natCast, hβ]
      rfl
    show β.repr (toFieldI F (b i)) j / c = _
    rw [hb, map_smul, β.repr_self, Finsupp.smul_apply, Finsupp.single_apply, smul_eq_mul]
    split_ifs <;> simp [hc']
  · have hr : β.repr (toFieldI F y) = β.repr (toFieldI F y') := by
      ext j
      have := congrFun h j
      simp only [q, AddMonoidHom.mk'_apply] at this
      exact (div_left_inj' hc').1 this
    exact toFieldI_injective F (β.repr.injective hr)

variable {F}

/-- A character of `R` on a finite sum is the product of its values. -/
private theorem as_char_sum {ι : Type} (χ : Dual F) (s : Finset ι) (f : ι → unitRing F) :
    χ (∑ i ∈ s, f i) = ∏ i ∈ s, χ (f i) := by
  classical
  refine Finset.induction_on s (by simp [AddChar.map_zero_eq_one]) ?_
  intro a s ha ih
  rw [Finset.sum_insert ha, Finset.prod_insert ha, AddChar.map_add_eq_mul, ih]

/-- `Circle.exp` of a finite sum is the product. -/
private theorem as_exp_sum {ι : Type} (s : Finset ι) (f : ι → ℝ) :
    Circle.exp (∑ i ∈ s, f i) = ∏ i ∈ s, Circle.exp (f i) := by
  classical
  refine Finset.induction_on s (by simp [Circle.exp_zero]) ?_
  intro a s ha ih
  rw [Finset.sum_insert ha, Finset.prod_insert ha, Circle.exp_add, ih]

open scoped Classical in
/-- **The coordinates of a lattice point**: `5^k · q j (Σ_i z_i • b_i/5^k) = z_j`. -/
private theorem as_q_lat {ι : Type} [Fintype ι] {b : ι → unitRing F} {q : ι → unitRing F →+ ℚ}
    (hqb : ∀ i j, q j (b i) = if i = j then 1 else 0) (k : ℕ) (z : ι → ℤ) (j : ι) :
    (5 : ℚ) ^ k * q j (∑ i, z i • fivePow F k (b i)) = z j := by
  classical
  have h5 : ∀ i, (5 : ℚ) ^ k * q j (fivePow F k (b i)) = if i = j then 1 else 0 := by
    intro i
    rw [← hqb i j]
    conv_rhs => rw [← nsmul_fivePow F k (b i)]
    rw [map_nsmul, nsmul_eq_mul]
    push_cast
    ring
  rw [map_sum, Finset.mul_sum]
  simp only [map_zsmul]
  simp only [zsmul_eq_mul]
  calc ∑ i, (5 : ℚ) ^ k * ((z i : ℚ) * q j (fivePow F k (b i)))
      = ∑ i, (z i : ℚ) * ((5 : ℚ) ^ k * q j (fivePow F k (b i))) :=
        Finset.sum_congr rfl fun i _ => by ring
    _ = z j := by simp only [h5, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]

open scoped Classical in
/-- **A point with integral scaled coordinates is the lattice point** with those coordinates. -/
private theorem as_eq_lat {ι : Type} [Fintype ι] {b : ι → unitRing F} {q : ι → unitRing F →+ ℚ}
    (hqb : ∀ i j, q j (b i) = if i = j then 1 else 0) (hinj : Function.Injective (fun y j => q j y)) (k : ℕ)
    (y : unitRing F) (z : ι → ℤ) (hz : ∀ j, (5 : ℚ) ^ k * q j y = z j) :
    y = ∑ i, z i • fivePow F k (b i) := by
  apply hinj
  funext j
  have h5 : (5 : ℚ) ^ k ≠ 0 := pow_ne_zero _ (by norm_num)
  exact mul_left_cancel₀ h5 ((hz j).trans (as_q_lat hqb k z j).symm)

/-- A character at a lattice point, through the arguments at the scaled basis. -/
private theorem as_char_lat {ι : Type} [Fintype ι] (b : ι → unitRing F) (χ : Dual F) (k : ℕ) (z : ι → ℤ) :
    χ (∑ i, z i • fivePow F k (b i)) =
      Circle.exp (∑ i, (z i : ℝ) * Complex.arg (χ (fivePow F k (b i)) : ℂ)) := by
  rw [as_char_sum, as_exp_sum]
  refine Finset.prod_congr rfl fun i _ => ?_
  rw [AddChar.map_zsmul_eq_zpow, Circle.exp_intCast_mul, Circle.exp_arg]

open scoped Classical in
/-- **The archimedean size is bounded by the coordinates**: `‖ι(y)‖ ≤ Σ_j |q_j(y)|·‖ι(b_j)‖` (a common denominator `N`
makes `N•y` an integral combination of the `b_j`). -/
private theorem as_norm_archHom_le [NumberField F] {ι : Type} [Fintype ι] {b : ι → unitRing F}
    {q : ι → unitRing F →+ ℚ} (hqb : ∀ i j, q j (b i) = if i = j then 1 else 0)
    (hinj : Function.Injective (fun y j => q j y)) (y : unitRing F) :
    ‖archHom F y‖ ≤ ∑ j, |(q j y : ℝ)| * ‖archHom F (b j)‖ := by
  set N : ℕ := ∏ j, (q j y).den with hN
  have hN0 : N ≠ 0 := Finset.prod_ne_zero_iff.2 fun j _ => (q j y).den_nz
  have hdvd : ∀ j, (q j y).den ∣ N := fun j => Finset.dvd_prod_of_mem _ (Finset.mem_univ j)
  let w : ι → ℤ := fun j => ((N / (q j y).den : ℕ) : ℤ) * (q j y).num
  have hw : ∀ j, (w j : ℚ) = N * q j y := by
    intro j
    obtain ⟨m, hm⟩ := hdvd j
    have hmd : N / (q j y).den = m := by
      rw [hm, Nat.mul_div_cancel_left _ (Nat.pos_of_ne_zero (q j y).den_nz)]
    simp only [w, hmd]
    rw [Int.cast_mul, Int.cast_natCast, ← Rat.mul_den_eq_num, hm]
    push_cast
    ring
  have hNy : N • y = ∑ j, w j • b j := by
    apply hinj
    funext j'
    show q j' (N • y) = q j' (∑ j, w j • b j)
    rw [map_nsmul, map_sum, nsmul_eq_mul, ← hw j']
    simp only [map_zsmul, hqb, smul_ite, smul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true, zsmul_eq_mul,
      mul_one]
  have hNpos : (0 : ℝ) < N := Nat.cast_pos.2 (Nat.pos_of_ne_zero hN0)
  have hwj : ∀ j, |(w j : ℝ)| = N * |(q j y : ℝ)| := by
    intro j
    have : (w j : ℝ) = N * (q j y : ℝ) := by exact_mod_cast hw j
    rw [this, abs_mul, Nat.abs_cast]
  have h1 : (N : ℝ) * ‖archHom F y‖ ≤ (N : ℝ) * ∑ j, |(q j y : ℝ)| * ‖archHom F (b j)‖ := by
    rw [← norm_archHom_nsmul, hNy, map_sum, Finset.mul_sum]
    calc ‖∑ j, archHom F (w j • b j)‖ ≤ ∑ j, ‖archHom F (w j • b j)‖ := norm_sum_le _ _
      _ = ∑ j, (N : ℝ) * (|(q j y : ℝ)| * ‖archHom F (b j)‖) := by
          refine Finset.sum_congr rfl fun j _ => ?_
          rw [map_zsmul, ← Int.cast_smul_eq_zsmul ℝ, norm_smul, Real.norm_eq_abs, hwj, mul_assoc]
  exact le_of_mul_le_mul_left h1 hNpos

/-- **The one-variable Dirichlet bound**: for `|θ| ≤ π` and `L·|θ| ≥ 2π`, `Σ_{n<L} (1 − cos nθ) ≥ L/2`
(`|Σ_{n<L} e^{inθ}| ≤ 2/|e^{iθ} − 1| ≤ π/|θ|`). -/
private theorem as_dirichlet {θ : ℝ} (hθ : |θ| ≤ Real.pi) {L : ℕ} (h : 2 * Real.pi ≤ L * |θ|) :
    (L : ℝ) / 2 ≤ ∑ n ∈ Finset.range L, (1 - Real.cos (n * θ)) := by
  have hpi := Real.pi_pos
  have hθ0 : θ ≠ 0 := by
    intro h0
    rw [h0, abs_zero, mul_zero] at h
    linarith
  have habs : 0 < |θ| := abs_pos.2 hθ0
  set w : ℂ := Complex.exp (θ * Complex.I) with hw
  have hsin : 2 * |θ| / Real.pi ≤ ‖w - 1‖ := by
    have hw' : w = Complex.exp (Complex.I * θ) := by rw [hw, mul_comm]
    rw [hw', Complex.norm_exp_I_mul_ofReal_sub_one, norm_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_two]
    have h1 : |Real.sin (θ / 2)| = |Real.sin (|θ| / 2)| := by
      rcases abs_cases θ with ⟨hh, _⟩ | ⟨hh, _⟩
      · rw [hh]
      · rw [hh, neg_div, Real.sin_neg, abs_neg]
    have h2 := Real.mul_le_sin (x := |θ| / 2) (by positivity) (by linarith)
    have key : |θ| / Real.pi ≤ |Real.sin (θ / 2)| := by
      rw [h1]
      calc |θ| / Real.pi = 2 / Real.pi * (|θ| / 2) := by ring
        _ ≤ Real.sin (|θ| / 2) := h2
        _ ≤ |Real.sin (|θ| / 2)| := le_abs_self _
    calc 2 * |θ| / Real.pi = 2 * (|θ| / Real.pi) := by ring
      _ ≤ 2 * |Real.sin (θ / 2)| := by linarith
  have hpos : 0 < 2 * |θ| / Real.pi := by positivity
  have hw1 : w ≠ 1 := by
    intro h1
    rw [h1, sub_self, norm_zero] at hsin
    linarith
  have hre : ∑ n ∈ Finset.range L, Real.cos (n * θ) = (∑ n ∈ Finset.range L, w ^ n).re := by
    rw [Complex.re_sum]
    refine Finset.sum_congr rfl fun n _ => ?_
    rw [hw, ← Complex.exp_nat_mul]
    have : (n : ℂ) * (θ * Complex.I) = ((n * θ : ℝ) : ℂ) * Complex.I := by push_cast; ring
    rw [this, Complex.exp_ofReal_mul_I_re]
  have hgeom : ‖∑ n ∈ Finset.range L, w ^ n‖ ≤ Real.pi / |θ| := by
    rw [geom_sum_eq hw1, norm_div]
    have hwn : ‖w‖ = 1 := by rw [hw]; exact Complex.norm_exp_ofReal_mul_I θ
    have hnum : ‖w ^ L - 1‖ ≤ 2 := by
      calc ‖w ^ L - 1‖ ≤ ‖w ^ L‖ + ‖(1 : ℂ)‖ := norm_sub_le _ _
        _ = 2 := by rw [norm_pow, hwn, one_pow, norm_one]; norm_num
    have hden : 0 < ‖w - 1‖ := lt_of_lt_of_le hpos hsin
    rw [div_le_iff₀ hden]
    calc ‖w ^ L - 1‖ ≤ 2 := hnum
      _ = Real.pi / |θ| * (2 * |θ| / Real.pi) := by field_simp
      _ ≤ Real.pi / |θ| * ‖w - 1‖ := mul_le_mul_of_nonneg_left hsin (by positivity)
  have hL : Real.pi / |θ| ≤ L / 2 := by
    rw [div_le_iff₀ habs]
    linarith
  have hcos : ∑ n ∈ Finset.range L, Real.cos (n * θ) ≤ L / 2 := by
    rw [hre]
    exact (Complex.re_le_norm _).trans (hgeom.trans hL)
  rw [Finset.sum_sub_distrib, Finset.sum_const, Finset.card_range, nsmul_eq_mul, mul_one]
  linarith

/-- Each evaluation is integrable for a finite measure. -/
private theorem as_integrable_eval (σ : Measure (Dual F)) [IsFiniteMeasure σ] (y : unitRing F) :
    Integrable (fun χ : Dual F => (χ y : ℂ)) σ :=
  Integrable.of_bound (measurable_evalChar y).aestronglyMeasurable 1
    (Eventually.of_forall fun χ => by rw [Circle.norm_coe])

/-- `Re χ(n•y) = cos(n · arg χ(y))`. -/
private theorem as_re_char_nsmul (χ : Dual F) (n : ℕ) (y : unitRing F) :
    (χ (n • y) : ℂ).re = Real.cos (n * Complex.arg (χ y : ℂ)) := by
  have e := Circle.exp_arg (χ y)
  rw [AddChar.map_nsmul_eq_pow]
  calc ((χ y ^ n : Circle) : ℂ).re = ((Circle.exp (Complex.arg (χ y : ℂ)) ^ n : Circle) : ℂ).re := by rw [e]
    _ = Real.cos (n * Complex.arg (χ y : ℂ)) := by
        rw [← Circle.exp_natCast_mul, Circle.coe_exp, Complex.exp_ofReal_mul_I_re]

/-- **The mass far out at one coordinate**: if `1 − Re φ(n•y₀) ≤ η` for every `n` below `3π·5^k/M`, the characters
whose argument at `y₀`, scaled by `5^k`, exceeds `M` have mass at most `2η` (`as_dirichlet`, averaged; Markov). -/
private theorem as_measure_far_le (ρ : Measure (Dual F)) [IsProbabilityMeasure ρ] (y₀ : unitRing F) (k : ℕ)
    {M η : ℝ} (hM : 0 < M)
    (hη : ∀ n : ℕ, (n : ℝ) < 3 * Real.pi * 5 ^ k / M → 1 - (∫ χ, (χ (n • y₀) : ℂ) ∂ρ).re ≤ η) :
    ρ.real {χ : Dual F | M < 5 ^ k * |Complex.arg (χ y₀ : ℂ)|} ≤ 2 * η := by
  have hpi := Real.pi_pos
  have h5 : (0 : ℝ) < 5 ^ k := by positivity
  have hη0 : 0 ≤ η := by
    have := hη 0 (by rw [Nat.cast_zero]; positivity)
    simpa [AddChar.map_zero_eq_one] using this
  by_cases hMk : Real.pi * 5 ^ k ≤ M
  · have hE : {χ : Dual F | M < 5 ^ k * |Complex.arg (χ y₀ : ℂ)|} = ∅ := by
      ext χ
      simp only [Set.mem_setOf_eq, Set.mem_empty_iff_false, iff_false, not_lt]
      have := abs_le.2 ⟨(Complex.neg_pi_lt_arg (χ y₀ : ℂ)).le, Complex.arg_le_pi (χ y₀ : ℂ)⟩
      nlinarith
    rw [hE, measureReal_empty]
    linarith
  push Not at hMk
  set L : ℕ := ⌈2 * Real.pi * 5 ^ k / M⌉₊ with hL
  have hLge : 2 * Real.pi * 5 ^ k / M ≤ L := Nat.le_ceil _
  have hLpos : (0 : ℝ) < L := lt_of_lt_of_le (by positivity) hLge
  have hLlt : (L : ℝ) < 3 * Real.pi * 5 ^ k / M := by
    have h1 := Nat.ceil_lt_add_one (by positivity : (0 : ℝ) ≤ 2 * Real.pi * 5 ^ k / M)
    have h2 : (1 : ℝ) < Real.pi * 5 ^ k / M := by rw [lt_div_iff₀ hM]; linarith
    calc (L : ℝ) < 2 * Real.pi * 5 ^ k / M + 1 := h1
      _ < 2 * Real.pi * 5 ^ k / M + Real.pi * 5 ^ k / M := by linarith
      _ = 3 * Real.pi * 5 ^ k / M := by ring
  set f : Dual F → ℝ := fun χ => (2 / L) * ∑ n ∈ Finset.range L, (1 - (χ (n • y₀) : ℂ).re) with hf
  have hterm : ∀ (χ : Dual F) (n : ℕ), 0 ≤ 1 - (χ (n • y₀) : ℂ).re := by
    intro χ n
    have := Complex.re_le_norm (χ (n • y₀) : ℂ)
    rw [Circle.norm_coe] at this
    linarith
  have hf0 : ∀ χ, 0 ≤ f χ := fun χ =>
    mul_nonneg (by positivity) (Finset.sum_nonneg fun n _ => hterm χ n)
  have hre : ∀ n : ℕ, Integrable (fun χ : Dual F => (χ (n • y₀) : ℂ).re) ρ := fun n =>
    (as_integrable_eval ρ (n • y₀)).re
  have hreint : ∀ n : ℕ, ∫ χ, (χ (n • y₀) : ℂ).re ∂ρ = (∫ χ, (χ (n • y₀) : ℂ) ∂ρ).re := fun n =>
    integral_re (as_integrable_eval ρ (n • y₀))
  have hint : ∀ n : ℕ, Integrable (fun χ : Dual F => 1 - (χ (n • y₀) : ℂ).re) ρ := fun n =>
    (integrable_const 1).sub (hre n)
  have hfint : Integrable f ρ := (integrable_finsetSum _ fun n _ => hint n).const_mul _
  have hsub : {χ : Dual F | M < 5 ^ k * |Complex.arg (χ y₀ : ℂ)|} ⊆ {χ | 1 ≤ f χ} := by
    intro χ hχ
    simp only [Set.mem_setOf_eq] at hχ ⊢
    set θ := Complex.arg (χ y₀ : ℂ) with hθ
    have hθπ : |θ| ≤ Real.pi := abs_le.2 ⟨(Complex.neg_pi_lt_arg _).le, Complex.arg_le_pi _⟩
    have hLθ : 2 * Real.pi ≤ L * |θ| := by
      have h1 : 2 * Real.pi * 5 ^ k / M * |θ| ≤ L * |θ| := mul_le_mul_of_nonneg_right hLge (abs_nonneg _)
      have h2 : 2 * Real.pi < 2 * Real.pi * 5 ^ k / M * |θ| := by
        rw [div_mul_eq_mul_div, lt_div_iff₀ hM]
        nlinarith
      linarith
    have hd := as_dirichlet hθπ hLθ
    have hsum : ∑ n ∈ Finset.range L, (1 - (χ (n • y₀) : ℂ).re) = ∑ n ∈ Finset.range L, (1 - Real.cos (n * θ)) :=
      Finset.sum_congr rfl fun n _ => by rw [as_re_char_nsmul]
    show 1 ≤ (2 / L) * ∑ n ∈ Finset.range L, (1 - (χ (n • y₀) : ℂ).re)
    rw [hsum]
    calc (1 : ℝ) = (2 / L) * (L / 2) := by field_simp
      _ ≤ (2 / L) * ∑ n ∈ Finset.range L, (1 - Real.cos (n * θ)) := mul_le_mul_of_nonneg_left hd (by positivity)
  have hmarkov := mul_meas_ge_le_integral_of_nonneg (Eventually.of_forall hf0) hfint 1
  rw [one_mul] at hmarkov
  have hintf : ∫ χ, f χ ∂ρ = (2 / L) * ∑ n ∈ Finset.range L, (1 - (∫ χ, (χ (n • y₀) : ℂ) ∂ρ).re) := by
    rw [hf, integral_const_mul, integral_finsetSum _ fun n _ => hint n]
    congr 1
    refine Finset.sum_congr rfl fun n _ => ?_
    rw [integral_sub (integrable_const _) (hre n), integral_const, probReal_univ, one_smul, hreint n]
  have hbound : (2 / L) * ∑ n ∈ Finset.range L, (1 - (∫ χ, (χ (n • y₀) : ℂ) ∂ρ).re) ≤ 2 * η := by
    have h1 : ∑ n ∈ Finset.range L, (1 - (∫ χ, (χ (n • y₀) : ℂ) ∂ρ).re) ≤ ∑ n ∈ Finset.range L, η :=
      Finset.sum_le_sum fun n hn => hη n (lt_trans (by exact_mod_cast Finset.mem_range.1 hn) hLlt)
    rw [Finset.sum_const, Finset.card_range, nsmul_eq_mul] at h1
    calc (2 / L) * ∑ n ∈ Finset.range L, (1 - (∫ χ, (χ (n • y₀) : ℂ) ∂ρ).re) ≤ (2 / L) * (L * η) :=
          mul_le_mul_of_nonneg_left h1 (by positivity)
      _ = 2 * η := by field_simp
  calc ρ.real {χ : Dual F | M < 5 ^ k * |Complex.arg (χ y₀ : ℂ)|} ≤ ρ.real {χ | 1 ≤ f χ} := measureReal_mono hsub
    _ ≤ ∫ χ, f χ ∂ρ := hmarkov
    _ ≤ 2 * η := by rw [hintf]; exact hbound


/-- The scaled arguments of `χ` at the points `b_j/5^k`: `t_k(χ)_j = 5^k · arg χ(b_j/5^k)`. -/
private def asT {ι : Type} (b : ι → unitRing F) (k : ℕ) (χ : Dual F) : ι → ℝ :=
  fun j => 5 ^ k * Complex.arg (χ (fivePow F k (b j)) : ℂ)

private theorem measurable_asT {ι : Type} (b : ι → unitRing F) (k : ℕ) : Measurable (asT b k) :=
  measurable_pi_lambda _ fun j => measurable_const.mul (Complex.measurable_arg.comp (measurable_evalChar _))

/-- `s ↦ exp(i⟨s, v⟩)` on `ℝ^ι`. -/
private def asEv {ι : Type} [Fintype ι] (v s : ι → ℝ) : ℂ := (Circle.exp (∑ j, s j * v j) : ℂ)

private theorem continuous_asEv {ι : Type} [Fintype ι] (v : ι → ℝ) : Continuous (asEv v) :=
  continuous_subtype_val.comp (Circle.exp.continuous.comp
    (continuous_finsetSum _ fun j _ => (continuous_apply j).mul continuous_const))

private theorem continuous_asEv_left {ι : Type} [Fintype ι] (s : ι → ℝ) : Continuous fun v : ι → ℝ => asEv v s :=
  continuous_subtype_val.comp (Circle.exp.continuous.comp
    (continuous_finsetSum _ fun j _ => continuous_const.mul (continuous_apply j)))

private theorem norm_asEv {ι : Type} [Fintype ι] (v s : ι → ℝ) : ‖asEv v s‖ = 1 := Circle.norm_coe _

open scoped Classical in
/-- **The transform at a lattice point, read through `t_k`**: if `5^k·q(y)` is integral, `χ(y) = exp(i⟨t_k χ, q(y)⟩)`. -/
private theorem as_char_eq_asEv {ι : Type} [Fintype ι] {b : ι → unitRing F} {q : ι → unitRing F →+ ℚ}
    (hqb : ∀ i j, q j (b i) = if i = j then 1 else 0) (hinj : Function.Injective (fun y j => q j y)) (k : ℕ)
    (y : unitRing F) (z : ι → ℤ) (hz : ∀ j, (5 : ℚ) ^ k * q j y = z j) (χ : Dual F) :
    (χ y : ℂ) = asEv (fun j => (q j y : ℝ)) (asT b k χ) := by
  have hy := as_eq_lat hqb hinj k y z hz
  have e1 : (χ y : ℂ) = (Circle.exp (∑ i, (z i : ℝ) * Complex.arg (χ (fivePow F k (b i)) : ℂ)) : ℂ) := by
    conv_lhs => rw [hy]
    rw [as_char_lat]
  rw [e1]
  show (Circle.exp _ : ℂ) = (Circle.exp (∑ j, asT b k χ j * (q j y : ℝ)) : ℂ)
  congr 2
  refine Finset.sum_congr rfl fun j _ => ?_
  have hzj : (5 : ℝ) ^ k * (q j y : ℝ) = z j := by exact_mod_cast hz j
  show (z j : ℝ) * _ = 5 ^ k * _ * (q j y : ℝ)
  rw [← hzj]
  ring

/-- The bound of the tightness step: `n·(a/5^k) < δ` for `n < 3π·5^k/R`, `a ≤ B`, `R = 3π(B + 1)/δ + 1`. -/
private theorem as_aux_lt {n a B δ : ℝ} (k : ℕ) (hn0 : 0 ≤ n) (ha : a ≤ B) (hB : 0 ≤ B) (hδ : 0 < δ)
    (hn : n < 3 * Real.pi * 5 ^ k / (3 * Real.pi * (B + 1) / δ + 1)) : n * (a / 5 ^ k) < δ := by
  have hpi := Real.pi_pos
  have h5 : (0 : ℝ) < 5 ^ k := by positivity
  set R : ℝ := 3 * Real.pi * (B + 1) / δ + 1 with hR
  have hR0 : 0 < R := by positivity
  have h1 : n * (a / 5 ^ k) ≤ n * ((B + 1) / 5 ^ k) :=
    mul_le_mul_of_nonneg_left (div_le_div_of_nonneg_right (by linarith) h5.le) hn0
  have h2 : n * ((B + 1) / 5 ^ k) < (3 * Real.pi * 5 ^ k / R) * ((B + 1) / 5 ^ k) :=
    mul_lt_mul_of_pos_right hn (by positivity)
  have h3 : (3 * Real.pi * 5 ^ k / R) * ((B + 1) / 5 ^ k) = 3 * Real.pi * (B + 1) / R := by
    field_simp
  have h4 : 3 * Real.pi * (B + 1) / R < δ := by
    rw [div_lt_iff₀ hR0]
    have : δ * R = 3 * Real.pi * (B + 1) + δ := by
      rw [hR]
      field_simp
    linarith
  linarith

open scoped Classical in
/-- **Tightness, uniform in `k`**: the push-forwards of `ρ` by the `t_k` put mass at most `ε` outside one closed ball. -/
private theorem as_tight [NumberField F] {ι : Type} [Fintype ι] (b : ι → unitRing F) (ρ : Measure (Dual F))
    [IsProbabilityMeasure ρ] (h : @Continuous (unitRing F) ℂ (archTop F) _ fun y => ∫ χ, (χ y : ℂ) ∂ρ) :
    IsTightMeasureSet {x | ∃ k : ℕ, ρ.map (asT b k) = x} := by
  set φ : unitRing F → ℂ := fun y => ∫ χ, (χ y : ℂ) ∂ρ with hφ
  have hφ0 : φ 0 = 1 := by simp [hφ, AddChar.map_zero_eq_one]
  set Bs : ℝ := ∑ j, ‖archHom F (b j)‖ with hBs
  have hBs0 : 0 ≤ Bs := Finset.sum_nonneg fun j _ => norm_nonneg _
  have hBj : ∀ j, ‖archHom F (b j)‖ ≤ Bs := fun j =>
    Finset.single_le_sum (f := fun j => ‖archHom F (b j)‖) (fun j _ => norm_nonneg _) (Finset.mem_univ j)
  rw [isTightMeasureSet_iff_exists_isCompact_measure_compl_le]
  intro ε hε
  obtain ⟨r, hr0, hrε⟩ : ∃ r : ℝ, 0 < r ∧ ENNReal.ofReal r ≤ ε := by
    by_cases hεt : ε = ⊤
    · exact ⟨1, one_pos, by rw [hεt]; exact le_top⟩
    · exact ⟨ε.toReal, ENNReal.toReal_pos hε.ne' hεt, by rw [ENNReal.ofReal_toReal hεt]⟩
  set η : ℝ := r / (2 * (Fintype.card ι + 1)) with hηdef
  have hη0 : 0 < η := by positivity
  have hct := @Continuous.tendsto _ _ (archTop F) _ φ h 0
  have hev : ∀ᶠ y in @nhds _ (archTop F) 0, ‖φ y - φ 0‖ < η := by
    have := (Metric.tendsto_nhds.1 hct) η hη0
    simpa [dist_eq_norm] using this
  obtain ⟨δ, hδ0, hδ⟩ := (eventually_archTop F (p := fun y => ‖φ y - φ 0‖ < η)).1 hev
  have hsmall : ∀ y : unitRing F, ‖archHom F y‖ < δ → 1 - (φ y).re ≤ η := by
    intro y hy
    have h1 := hδ y hy
    rw [hφ0] at h1
    have h2 := Complex.abs_re_le_norm (φ y - 1)
    rw [Complex.sub_re, Complex.one_re] at h2
    linarith [neg_abs_le ((φ y).re - 1)]
  set R : ℝ := 3 * Real.pi * (Bs + 1) / δ + 1 with hR
  have hR0 : 0 < R := by positivity
  refine ⟨Metric.closedBall 0 R, isCompact_closedBall _ _, ?_⟩
  rintro _ ⟨k, rfl⟩
  rw [Measure.map_apply (measurable_asT b k) Metric.isClosed_closedBall.measurableSet.compl]
  have h5 : (0 : ℝ) < 5 ^ k := by positivity
  have hcover : asT b k ⁻¹' (Metric.closedBall 0 R)ᶜ ⊆
      ⋃ j, {χ : Dual F | R < 5 ^ k * |Complex.arg (χ (fivePow F k (b j)) : ℂ)|} := by
    intro χ hχ
    simp only [Set.mem_preimage, Set.mem_compl_iff, Metric.mem_closedBall, dist_zero_right, not_le] at hχ
    by_contra hno
    simp only [Set.mem_iUnion, Set.mem_setOf_eq, not_exists, not_lt] at hno
    have : ‖asT b k χ‖ ≤ R := (pi_norm_le_iff_of_nonneg hR0.le).2 fun j => by
      show ‖5 ^ k * Complex.arg (χ (fivePow F k (b j)) : ℂ)‖ ≤ R
      rw [Real.norm_eq_abs, abs_mul, abs_of_pos h5]
      exact hno j
    linarith
  have hfar : ∀ j, ρ {χ : Dual F | R < 5 ^ k * |Complex.arg (χ (fivePow F k (b j)) : ℂ)|} ≤
      ENNReal.ofReal (2 * η) := by
    intro j
    rw [← ofReal_measureReal]
    refine ENNReal.ofReal_le_ofReal (as_measure_far_le ρ (fivePow F k (b j)) k hR0 fun n hn => ?_)
    refine hsmall _ ?_
    have hsz : ‖archHom F (fivePow F k (b j))‖ = ‖archHom F (b j)‖ / 5 ^ k := by
      have := norm_archHom_nsmul F (5 ^ k) (fivePow F k (b j))
      rw [nsmul_fivePow] at this
      rw [this]
      push_cast
      field_simp
    rw [norm_archHom_nsmul, hsz]
    exact as_aux_lt k (Nat.cast_nonneg n) (hBj j) hBs0 hδ0 hn
  calc ρ (asT b k ⁻¹' (Metric.closedBall 0 R)ᶜ)
      ≤ ρ (⋃ j, {χ : Dual F | R < 5 ^ k * |Complex.arg (χ (fivePow F k (b j)) : ℂ)|}) := measure_mono hcover
    _ ≤ ∑ j, ρ {χ : Dual F | R < 5 ^ k * |Complex.arg (χ (fivePow F k (b j)) : ℂ)|} :=
        measure_iUnion_fintype_le _ _
    _ ≤ ∑ _j : ι, ENNReal.ofReal (2 * η) := Finset.sum_le_sum fun j _ => hfar j
    _ = ENNReal.ofReal (Fintype.card ι * (2 * η)) := by
        rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul, ENNReal.ofReal_mul (Nat.cast_nonneg _),
          ENNReal.ofReal_natCast]
    _ ≤ ENNReal.ofReal r := by
        refine ENNReal.ofReal_le_ofReal ?_
        have hc : (0 : ℝ) ≤ Fintype.card ι := Nat.cast_nonneg _
        have e : (Fintype.card ι : ℝ) * (2 * η) = r * (Fintype.card ι / (Fintype.card ι + 1)) := by
          rw [hηdef]
          field_simp
        have h1 : (Fintype.card ι : ℝ) / (Fintype.card ι + 1) ≤ 1 := by
          rw [div_le_one (by positivity)]
          linarith
        rw [e]
        calc r * (Fintype.card ι / (Fintype.card ι + 1)) ≤ r * 1 := mul_le_mul_of_nonneg_left h1 hr0.le
          _ = r := mul_one r
    _ ≤ ε := hrε

open scoped Classical in
/-- **A limit point of the push-forwards** (Prokhorov, along an ultrafilter): a probability on `ℝ^ι` whose transform at
`q(y)` is `φ(y)` at every lattice point `y`. -/
private theorem as_exists_limit [NumberField F] {ι : Type} [Fintype ι] {b : ι → unitRing F}
    {q : ι → unitRing F →+ ℚ} (hqb : ∀ i j, q j (b i) = if i = j then 1 else 0)
    (hinj : Function.Injective (fun y j => q j y)) (ρ : Measure (Dual F)) [IsProbabilityMeasure ρ]
    (h : @Continuous (unitRing F) ℂ (archTop F) _ fun y => ∫ χ, (χ y : ℂ) ∂ρ) :
    ∃ μ : ProbabilityMeasure (ι → ℝ), ∀ (K : ℕ) (y : unitRing F) (z : ι → ℤ),
      (∀ j, (5 : ℚ) ^ K * q j y = z j) →
        ∫ s, asEv (fun j => (q j y : ℝ)) s ∂(μ : Measure (ι → ℝ)) = ∫ χ, (χ y : ℂ) ∂ρ := by
  let P : ℕ → ProbabilityMeasure (ι → ℝ) := fun k =>
    ⟨ρ.map (asT b k), Measure.isProbabilityMeasure_map (measurable_asT b k).aemeasurable⟩
  have hset : {x | ∃ μ ∈ Set.range P, (μ : Measure (ι → ℝ)) = x} = {x | ∃ k : ℕ, ρ.map (asT b k) = x} := by
    ext x
    constructor
    · rintro ⟨_, ⟨k, rfl⟩, rfl⟩
      exact ⟨k, rfl⟩
    · rintro ⟨k, rfl⟩
      exact ⟨P k, ⟨k, rfl⟩, rfl⟩
  have hcomp := isCompact_closure_of_isTightMeasureSet (S := Set.range P) (by rw [hset]; exact as_tight b ρ h)
  have hU : ((Ultrafilter.of (atTop : Filter ℕ) : Ultrafilter ℕ) : Filter ℕ) ≤ atTop := Ultrafilter.of_le atTop
  obtain ⟨μ, -, hμ⟩ := hcomp.ultrafilter_le_nhds ((Ultrafilter.of (atTop : Filter ℕ)).map P) (by
    rw [Ultrafilter.coe_map, Filter.le_principal_iff, Filter.mem_map]
    exact Filter.univ_mem' fun k => subset_closure ⟨k, rfl⟩)
  have hlim : Tendsto P (Ultrafilter.of (atTop : Filter ℕ) : Filter ℕ) (𝓝 μ) := by
    rw [Filter.Tendsto, ← Ultrafilter.coe_map]
    exact hμ
  have hconv := (ProbabilityMeasure.tendsto_iff_forall_integral_rclike_tendsto ℂ).1 hlim
  refine ⟨μ, fun K y z hz => ?_⟩
  let g : BoundedContinuousFunction (ι → ℝ) ℂ :=
    BoundedContinuousFunction.ofNormedAddCommGroup (asEv fun j => (q j y : ℝ)) (continuous_asEv _) 1
      fun s => (norm_asEv _ _).le
  have h1 := hconv g
  have h2 : ∀ᶠ k in (Ultrafilter.of (atTop : Filter ℕ) : Filter ℕ),
      ∫ s, g s ∂(P k : Measure (ι → ℝ)) = ∫ χ, (χ y : ℂ) ∂ρ := by
    refine hU (eventually_atTop.2 ⟨K, fun k hk => ?_⟩)
    have hz' : ∀ j, (5 : ℚ) ^ k * q j y = ((5 : ℤ) ^ (k - K) * z j : ℤ) := by
      intro j
      push_cast
      rw [← hz j, ← mul_assoc, ← pow_add, Nat.sub_add_cancel hk]
    show ∫ s, asEv (fun j => (q j y : ℝ)) s ∂(ρ.map (asT b k)) = ∫ χ, (χ y : ℂ) ∂ρ
    rw [integral_map (measurable_asT b k).aemeasurable (continuous_asEv _).aestronglyMeasurable]
    exact integral_congr_ae (Eventually.of_forall fun χ => (as_char_eq_asEv hqb hinj k y _ hz' χ).symm)
  exact tendsto_nhds_unique h1 (tendsto_const_nhds.congr' (h2.mono fun k hk => hk.symm))

open scoped Classical in
/-- **The limit's transform on all of `R`**, from the lattice points by density: `q(d_m) → q(y)` and
`ι(d_m − y) → 0` for `d_m` the lattice point with coordinates `⌊5^m q(y)⌋/5^m`. -/
private theorem as_transform_eq [NumberField F] {ι : Type} [Fintype ι] {b : ι → unitRing F}
    {q : ι → unitRing F →+ ℚ} (hqb : ∀ i j, q j (b i) = if i = j then 1 else 0)
    (hinj : Function.Injective (fun y j => q j y)) (ρ : Measure (Dual F)) [IsProbabilityMeasure ρ]
    (h : @Continuous (unitRing F) ℂ (archTop F) _ fun y => ∫ χ, (χ y : ℂ) ∂ρ) (μ : Measure (ι → ℝ))
    [IsProbabilityMeasure μ]
    (hμ : ∀ (K : ℕ) (y : unitRing F) (z : ι → ℤ), (∀ j, (5 : ℚ) ^ K * q j y = z j) →
      ∫ s, asEv (fun j => (q j y : ℝ)) s ∂μ = ∫ χ, (χ y : ℂ) ∂ρ) (y : unitRing F) :
    ∫ s, asEv (fun j => (q j y : ℝ)) s ∂μ = ∫ χ, (χ y : ℂ) ∂ρ := by
  set φ : unitRing F → ℂ := fun y => ∫ χ, (χ y : ℂ) ∂ρ with hφ
  set Bs : ℝ := ∑ j, ‖archHom F (b j)‖ with hBs
  let z : ℕ → ι → ℤ := fun m j => ⌊(5 : ℚ) ^ m * q j y⌋
  let d : ℕ → unitRing F := fun m => ∑ j, z m j • fivePow F m (b j)
  have hqd : ∀ m j, (5 : ℚ) ^ m * q j (d m) = z m j := fun m j => as_q_lat hqb m (z m) j
  have hcoord : ∀ m j, |(q j (d m) : ℝ) - (q j y : ℝ)| ≤ (1 / 5 : ℝ) ^ m := by
    intro m j
    have h5 : (0 : ℝ) < 5 ^ m := by positivity
    have e1 : (5 : ℝ) ^ m * (q j (d m) : ℝ) = (z m j : ℝ) := by exact_mod_cast hqd m j
    have a1 : ((z m j : ℤ) : ℝ) ≤ (5 : ℝ) ^ m * (q j y : ℝ) := by
      have := Int.floor_le ((5 : ℚ) ^ m * q j y)
      exact_mod_cast this
    have a2 : (5 : ℝ) ^ m * (q j y : ℝ) < ((z m j : ℤ) : ℝ) + 1 := by
      have := Int.lt_floor_add_one ((5 : ℚ) ^ m * q j y)
      exact_mod_cast this
    have e2 : (q j (d m) : ℝ) - (q j y : ℝ) = ((z m j : ℝ) - (5 : ℝ) ^ m * (q j y : ℝ)) / 5 ^ m := by
      rw [← e1]
      field_simp
    rw [e2, abs_div, abs_of_pos h5, div_le_iff₀ h5, one_div_pow, one_pow, one_div_mul_cancel h5.ne', abs_le]
    constructor <;> linarith
  have hpow : Tendsto (fun m : ℕ => (1 / 5 : ℝ) ^ m) atTop (𝓝 0) :=
    tendsto_pow_atTop_nhds_zero_of_lt_one (by norm_num) (by norm_num)
  have hQ : Tendsto (fun m => fun j => (q j (d m) : ℝ)) atTop (𝓝 fun j => (q j y : ℝ)) := by
    refine tendsto_pi_nhds.2 fun j => ?_
    rw [tendsto_iff_norm_sub_tendsto_zero]
    refine squeeze_zero (fun m => norm_nonneg _) (fun m => ?_) hpow
    rw [Real.norm_eq_abs]
    exact hcoord m j
  have hd : Tendsto d atTop (@nhds _ (archTop F) y) := by
    rw [archTop_eq, nhds_induced, tendsto_comap_iff, tendsto_iff_norm_sub_tendsto_zero]
    have hpB : Tendsto (fun m : ℕ => (1 / 5 : ℝ) ^ m * Bs) atTop (𝓝 0) := by
      simpa using hpow.mul_const Bs
    refine squeeze_zero (fun m => norm_nonneg _) (fun m => ?_) hpB
    show ‖archHom F (d m) - archHom F y‖ ≤ (1 / 5 : ℝ) ^ m * Bs
    rw [← map_sub]
    refine (as_norm_archHom_le hqb hinj _).trans ?_
    rw [hBs, Finset.mul_sum]
    refine Finset.sum_le_sum fun j _ => mul_le_mul_of_nonneg_right ?_ (norm_nonneg _)
    rw [map_sub, Rat.cast_sub]
    exact hcoord m j
  have h1 : Tendsto (fun m => φ (d m)) atTop (𝓝 (φ y)) :=
    (@Continuous.tendsto _ _ (archTop F) _ φ h y).comp hd
  have h2 : Tendsto (fun m => ∫ s, asEv (fun j => (q j (d m) : ℝ)) s ∂μ) atTop
      (𝓝 (∫ s, asEv (fun j => (q j y : ℝ)) s ∂μ)) := by
    refine tendsto_integral_of_dominated_convergence (fun _ => (1 : ℝ))
      (fun m => (continuous_asEv _).aestronglyMeasurable) (integrable_const _)
      (fun m => Eventually.of_forall fun s => (norm_asEv _ _).le) (Eventually.of_forall fun s => ?_)
    exact ((continuous_asEv_left s).tendsto _).comp hQ
  have h3 : ∀ m, ∫ s, asEv (fun j => (q j (d m) : ℝ)) s ∂μ = φ (d m) := fun m => hμ m (d m) (z m) (hqd m)
  exact tendsto_nhds_unique (h2.congr h3) h1

open scoped Classical in
/-- **`archimedean_support` for a probability measure**: the limit `μ` pushed to `R̂` by `s ↦ exp(i⟨s, q(·)⟩)` has the
transform of `ρ`, so it is `ρ` (`measure_eq_of_fourier`), and it is carried by the range of that map, a measurable set
of archimedean characters. -/
private theorem as_support_prob [NumberField F] (ρ : Measure (Dual F)) [IsProbabilityMeasure ρ]
    (h : @Continuous (unitRing F) ℂ (archTop F) _ fun y => ∫ χ, (χ y : ℂ) ∂ρ) :
    ρ (archChars (unitRing F))ᶜ = 0 := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  obtain ⟨ι, _, b, q, hqb, hinj⟩ := as_exists_coords F
  obtain ⟨μ, hμ⟩ := as_exists_limit hqb hinj ρ h
  have hall := as_transform_eq hqb hinj ρ h (μ : Measure (ι → ℝ)) hμ
  let e : (ι → ℝ) → Dual F := fun s =>
    { toFun := fun r => Circle.exp (∑ j, s j * (q j r : ℝ))
      map_zero_eq_one' := by simp
      map_add_eq_mul' := fun r r' => by
        rw [← Circle.exp_add, ← Finset.sum_add_distrib]
        congr 1
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [map_add, Rat.cast_add, mul_add] }
  have he : Continuous e := by
    refine continuous_induced_rng.2 (continuous_pi fun r => ?_)
    exact continuous_subtype_val.comp (Circle.exp.continuous.comp
      (continuous_finsetSum _ fun j _ => (continuous_apply j).mul continuous_const))
  have hem : Measurable e := he.measurable
  have hfour : ∀ y : unitRing F, ∫ χ, (χ y : ℂ) ∂ρ = ∫ χ, (χ y : ℂ) ∂((μ : Measure (ι → ℝ)).map e) := by
    intro y
    rw [integral_map hem.aemeasurable (continuous_evalChar (unitRing F) y).aestronglyMeasurable]
    exact (hall y).symm
  have heq : ρ = (μ : Measure (ι → ℝ)).map e := measure_eq_of_fourier hfour
  have hrange : MeasurableSet (Set.range e) := by
    have : Set.range e = ⋃ n : ℕ, e '' Metric.closedBall 0 n := by
      ext χ
      simp only [Set.mem_range, Set.mem_iUnion, Set.mem_image]
      constructor
      · rintro ⟨s, rfl⟩
        obtain ⟨n, hn⟩ := exists_nat_ge ‖s‖
        exact ⟨n, s, mem_closedBall_zero_iff.2 hn, rfl⟩
      · rintro ⟨n, s, -, rfl⟩
        exact ⟨s, rfl⟩
    rw [this]
    exact MeasurableSet.iUnion fun n => ((isCompact_closedBall _ _).image he).isClosed.measurableSet
  have hsub : Set.range e ⊆ archChars (unitRing F) := by
    rintro _ ⟨s, rfl⟩
    refine ⟨AddMonoidHom.mk' (fun r => ∑ j, s j * (q j r : ℝ)) fun r r' => ?_, fun r => rfl⟩
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [map_add, Rat.cast_add, mul_add]
  calc ρ (archChars (unitRing F))ᶜ ≤ ρ (Set.range e)ᶜ := measure_mono (Set.compl_subset_compl.2 hsub)
    _ = 0 := by
      rw [heq, Measure.map_apply hem hrange.compl]
      have : e ⁻¹' (Set.range e)ᶜ = ∅ := by
        ext s
        simp
      rw [this, measure_empty]

end ArchSupport

