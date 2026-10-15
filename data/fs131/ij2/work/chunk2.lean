
/-- `t (a + b) = t a · t b`, in `ℂ`. -/
private theorem coe_char_add (t : Dual F) (a b : unitRing F) :
    ((t (a + b) : Circle) : ℂ) = (t a : ℂ) * (t b : ℂ) := by
  rw [AddChar.map_add_eq_mul, Circle.coe_mul]

/-! ### Private helpers: the measure side -/

section MeasureSide

variable (σ : Measure (Dual F)) [IsFiniteMeasure σ]

private theorem integrable_eval (y : unitRing F) : Integrable (fun χ : Dual F => (χ y : ℂ)) σ :=
  Integrable.of_bound (measurable_evalChar y).aestronglyMeasurable 1
    (Eventually.of_forall fun χ => by rw [Circle.norm_coe])

private theorem integrable_eval_mul (y : unitRing F) {V : Dual F → ℝ} (hV : Measurable V) (hV0 : ∀ χ, 0 ≤ V χ)
    (hV1 : ∀ χ, V χ ≤ 1) : Integrable (fun χ : Dual F => (χ y : ℂ) * (V χ : ℂ)) σ :=
  Integrable.of_bound ((measurable_evalChar y).mul (Complex.measurable_ofReal.comp hV)).aestronglyMeasurable 1
    (Eventually.of_forall fun χ => by
      rw [norm_mul, Circle.norm_coe, one_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (hV0 χ)]
      exact hV1 χ)

private theorem integrable_real {V : Dual F → ℝ} (hV : Measurable V) (hV0 : ∀ χ, 0 ≤ V χ) (hV1 : ∀ χ, V χ ≤ 1) :
    Integrable V σ :=
  Integrable.of_bound hV.aestronglyMeasurable 1
    (Eventually.of_forall fun χ => by rw [Real.norm_eq_abs, abs_of_nonneg (hV0 χ)]; exact hV1 χ)

/-- **A bounded non-negative weight on a finite measure, twisted by a character, has a positive-definite
transform.** -/
private theorem posDef_twisted (V : Dual F → ℝ) (hV : Measurable V) (hV0 : ∀ χ, 0 ≤ V χ) (hV1 : ∀ χ, V χ ≤ 1)
    (t : Dual F) :
    PosDef fun y => (starRingEnd ℂ) (t y : ℂ) * ∫ χ, (χ y : ℂ) * (V χ : ℂ) ∂σ := by
  intro s z
  set S : Dual F → ℂ := fun χ => ∑ a ∈ s, z a * (starRingEnd ℂ) (t a : ℂ) * (χ a : ℂ) with hS
  have hpt : ∀ χ : Dual F, (∑ a ∈ s, ∑ b ∈ s, z a * star (z b) *
      ((starRingEnd ℂ) (t (a - b) : ℂ) * ((χ (a - b) : ℂ) * (V χ : ℂ)))) =
      (((Complex.normSq (S χ) * V χ : ℝ)) : ℂ) := by
    intro χ
    rw [Complex.ofReal_mul, ← Complex.mul_conj, hS, map_sum, Finset.sum_mul_sum, Finset.sum_mul]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.sum_mul]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [coe_char_sub, coe_char_sub]
    simp only [map_mul, Complex.conj_conj, Complex.star_def]
    ring
  have hint : ∀ a b : unitRing F, Integrable (fun χ : Dual F => (χ (a - b) : ℂ) * (V χ : ℂ)) σ :=
    fun a b => integrable_eval_mul σ (a - b) hV hV0 hV1
  have hsum : (∑ a ∈ s, ∑ b ∈ s, z a * star (z b) *
      ((starRingEnd ℂ) (t (a - b) : ℂ) * ∫ χ, (χ (a - b) : ℂ) * (V χ : ℂ) ∂σ)) =
      ∫ χ, (((Complex.normSq (S χ) * V χ : ℝ)) : ℂ) ∂σ := by
    rw [← integral_congr_ae (Eventually.of_forall hpt),
      integral_finsetSum _ fun a _ => integrable_finsetSum _ fun b _ => ((hint a b).const_mul _).const_mul _]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [integral_finsetSum _ fun b _ => ((hint a b).const_mul _).const_mul _]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [integral_const_mul, integral_const_mul]
  dsimp only
  rw [hsum, integral_complex_ofReal]
  exact ⟨Complex.ofReal_im _, by
    rw [Complex.ofReal_re]
    exact integral_nonneg fun χ => mul_nonneg (Complex.normSq_nonneg _) (hV0 χ)⟩

/-- `Re u ≥ 1 − ‖u − 1‖`. -/
private theorem one_sub_norm_le_re (u : ℂ) : 1 - ‖u - 1‖ ≤ u.re := by
  have h := Complex.abs_re_le_norm (u - 1)
  rw [Complex.sub_re, Complex.one_re] at h
  linarith [neg_abs_le (u.re - 1)]

/-- `∫ Re χ(w) ≥ σ(univ) − ∫ ‖χ(w) − 1‖`. -/
private theorem re_integral_ge (w : unitRing F) :
    σ.real Set.univ - ∫ χ, ‖(χ w : ℂ) - 1‖ ∂σ ≤ (∫ χ, (χ w : ℂ) ∂σ).re := by
  have hre : ∫ χ, (χ w : ℂ).re ∂σ = (∫ χ, (χ w : ℂ) ∂σ).re := integral_re (integrable_eval σ w)
  rw [← hre]
  have h1 : Integrable (fun χ : Dual F => ‖(χ w : ℂ) - 1‖) σ := ((integrable_eval σ w).sub (integrable_const 1)).norm
  have h2 : ∫ χ, (1 - ‖(χ w : ℂ) - 1‖) ∂σ ≤ ∫ χ, (χ w : ℂ).re ∂σ :=
    integral_mono ((integrable_const (1 : ℝ)).sub h1) (integrable_eval σ w).re fun χ => one_sub_norm_le_re (χ w : ℂ)
  rw [integral_sub (integrable_const _) h1, integral_const, smul_eq_mul, mul_one] at h2
  exact h2

open scoped Classical in
/-- **The modulus of the transform at `M·R ∩ B_δ`**: from `τ′_∅`-continuity, `∫ ‖χ(w) − 1‖ dσ` is small on
`M·R ∩ B_δ` for some `M ≠ 0` and `δ > 0` (`‖u − 1‖ ≤ η + (2 − 2 Re u)/η` on the circle). -/
private theorem exists_E_small [NumberField F]
    (h : @Continuous (unitRing F) ℂ (tauPrime F) _ fun y => ∫ χ, (χ y : ℂ) ∂σ) {ε : ℝ} (hε : 0 < ε) :
    ∃ M : ℕ, M ≠ 0 ∧ ∃ δ > 0, ∀ s : unitRing F, ‖archHom F (M • s)‖ < δ →
      ∫ χ, ‖(χ (M • s) : ℂ) - 1‖ ∂σ < ε := by
  set m := σ.real Set.univ with hm
  set φ : unitRing F → ℂ := fun y => ∫ χ, (χ y : ℂ) ∂σ with hφ
  have hm0 : 0 ≤ m := measureReal_nonneg
  set η : ℝ := ε / (2 * (m + 1)) with hη
  have hη0 : 0 < η := by positivity
  have hct := @Continuous.tendsto _ _ (tauPrime F) _ φ h 0
  have hev : ∀ᶠ w in @nhds _ (tauPrime F) 0, ‖φ w - φ 0‖ < η * ε / 4 := by
    have := (Metric.tendsto_nhds.1 hct) (η * ε / 4) (by positivity)
    simpa [dist_eq_norm] using this
  rw [nhds_inf (t₁ := profTop F) (t₂ := archTop F)] at hev
  obtain ⟨t₁, ht₁, t₂, ht₂, hsub⟩ := Filter.mem_inf_iff_superset.1 hev
  obtain ⟨M, hM, hMt⟩ := exists_nsmul_mem_of_mem_nhds_profTop F ht₁
  obtain ⟨δ, hδ, hδt⟩ := (eventually_archTop F (p := fun r => r ∈ t₂)).1 ht₂
  refine ⟨M, hM, δ, hδ, fun s hs => ?_⟩
  have hw : ‖φ (M • s) - φ 0‖ < η * ε / 4 := hsub ⟨hMt s, hδt _ hs⟩
  have hφ0 : φ 0 = (m : ℂ) := by
    simp only [hφ, AddChar.map_zero_eq_one, Circle.coe_one, integral_const, Complex.real_smul, mul_one, hm]
  have hpt : ∀ χ : Dual F, ‖(χ (M • s) : ℂ) - 1‖ ≤ (η + 2 / η) - (2 / η) * (χ (M • s) : ℂ).re := by
    intro χ
    set u : ℂ := (χ (M • s) : ℂ)
    have hu : ‖u‖ = 1 := Circle.norm_coe _
    have hsq : ‖u - 1‖ ^ 2 = 2 - 2 * u.re := by
      have h1 := Complex.normSq_eq_norm_sq (u - 1)
      have h2 := Complex.normSq_eq_norm_sq u
      rw [hu, Complex.normSq_apply] at h2
      rw [← h1, Complex.normSq_apply]
      simp only [Complex.sub_re, Complex.one_re, Complex.sub_im, Complex.one_im, sub_zero]
      nlinarith
    have hfin : (η + 2 / η) - (2 / η) * u.re = η + (2 - 2 * u.re) / η := by ring
    rw [hfin, ← hsq]
    by_cases hle : ‖u - 1‖ ≤ η
    · have : 0 ≤ ‖u - 1‖ ^ 2 / η := by positivity
      linarith
    · push Not at hle
      have : ‖u - 1‖ ≤ ‖u - 1‖ ^ 2 / η := by
        rw [le_div_iff₀ hη0, sq]
        exact mul_le_mul_of_nonneg_left hle.le (norm_nonneg _)
      linarith
  have hint1 : Integrable (fun χ : Dual F => ‖(χ (M • s) : ℂ) - 1‖) σ :=
    ((integrable_eval σ (M • s)).sub (integrable_const 1)).norm
  have hintre : Integrable (fun χ : Dual F => (χ (M • s) : ℂ).re) σ := (integrable_eval σ (M • s)).re
  have hint2 : Integrable (fun χ : Dual F => (η + 2 / η) - (2 / η) * (χ (M • s) : ℂ).re) σ :=
    (integrable_const _).sub (hintre.const_mul _)
  have hre : ∫ χ, (χ (M • s) : ℂ).re ∂σ = (φ (M • s)).re := integral_re (integrable_eval σ (M • s))
  have hgap : m - (φ (M • s)).re < η * ε / 4 := by
    have := Complex.abs_re_le_norm (φ (M • s) - φ 0)
    rw [Complex.sub_re, hφ0, Complex.ofReal_re] at this
    rw [hφ0] at hw
    linarith [neg_abs_le ((φ (M • s)).re - m)]
  calc ∫ χ, ‖(χ (M • s) : ℂ) - 1‖ ∂σ ≤ ∫ χ, ((η + 2 / η) - (2 / η) * (χ (M • s) : ℂ).re) ∂σ :=
        integral_mono hint1 hint2 hpt
    _ = η * m + (2 / η) * (m - (φ (M • s)).re) := by
        rw [integral_sub (integrable_const _) (hintre.const_mul _), integral_const, integral_const_mul, hre,
          smul_eq_mul, ← hm]
        ring
    _ < ε / 2 + (2 / η) * (η * ε / 4) := by
        have h1 : η * m < ε / 2 := by
          rw [hη, div_mul_eq_mul_div, div_lt_div_iff₀ (by positivity) (by norm_num)]
          nlinarith
        have h2 : (2 / η) * (m - (φ (M • s)).re) < (2 / η) * (η * ε / 4) :=
          mul_lt_mul_of_pos_left hgap (by positivity)
        linarith
    _ = ε := by field_simp; ring

/-- The level-`n` twisted part `∫ χ(y) · twW(t, χ) dσ`. -/
private def twK {G : Type*} [Fintype G] (x : G → unitRing F) (t : Dual F) (y : unitRing F) : ℂ :=
  ∫ χ, (χ y : ℂ) * (twW x t χ : ℂ) ∂σ

section Level2

variable {G : Type*} [Fintype G] [Nonempty G]

omit [IsFiniteMeasure σ] [Nonempty G] in
private theorem twK_zero (x : G → unitRing F) (t : Dual F) :
    twK σ x t 0 = ((∫ χ, twW x t χ ∂σ : ℝ) : ℂ) := by
  simp only [twK, AddChar.map_zero_eq_one, Circle.coe_one, one_mul, integral_complex_ofReal]

private theorem norm_twK_le (x : G → unitRing F) (t : Dual F) (y : unitRing F) :
    ‖twK σ x t y‖ ≤ σ.real Set.univ := by
  have h := norm_integral_le_of_norm_le_const (μ := σ) (f := fun χ : Dual F => (χ y : ℂ) * (twW x t χ : ℂ))
    (C := 1) (Eventually.of_forall fun χ => by
      rw [norm_mul, Circle.norm_coe, one_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (twW_nonneg _ _ _)]
      exact twW_le_one _ _ _)
  rw [one_mul] at h
  exact h

private theorem posDef_twK (x : G → unitRing F) (t : Dual F) :
    PosDef fun y => (starRingEnd ℂ) (t y : ℂ) * twK σ x t y :=
  posDef_twisted σ (twW x t) (measurable_twW x t) (twW_nonneg x t) (twW_le_one x t) t

end Level2

section Level3

variable {N : ℕ} [Fintype (unitRing F ⧸ nR F N)]

/-- **Parseval at one level**: the weights of the characters of `R ⧸ N·R` sum to `1`. -/
private theorem sum_twW_liftChar (x : unitRing F ⧸ nR F N → unitRing F)
    (hx : ∀ c, (x c : unitRing F ⧸ nR F N) = c) (χ : Dual F) :
    ∑ ψ : AddChar (unitRing F ⧸ nR F N) ℂ, twW x (liftChar ψ) χ = 1 := by
  classical
  apply Complex.ofReal_injective
  rw [Complex.ofReal_sum]
  simp only [twW_eq, coe_liftChar]
  rw [← Finset.mul_sum, Finset.sum_comm]
  have hin : ∀ c : unitRing F ⧸ nR F N, ∑ c', ∑ ψ : AddChar (unitRing F ⧸ nR F N) ℂ,
      (starRingEnd ℂ) (ψ ((x c - x c' : unitRing F) : unitRing F ⧸ nR F N)) * (χ (x c - x c') : ℂ) =
      Fintype.card (unitRing F ⧸ nR F N) := by
    intro c
    simp only [← Finset.sum_mul, sum_conj_addChar, QuotientAddGroup.mk_sub, hx, sub_eq_zero, ite_mul, zero_mul]
    rw [Finset.sum_ite_eq]
    simp
  rw [Finset.sum_congr rfl fun c _ => (Finset.sum_comm.trans (hin c)), Finset.sum_const, Finset.card_univ,
    nsmul_eq_mul, Complex.ofReal_one]
  have hG : (Fintype.card (unitRing F ⧸ nR F N) : ℂ) ≠ 0 := Nat.cast_ne_zero.2 Fintype.card_ne_zero
  field_simp

/-- A character of `R` trivial on `N·R`, unless `false`, read back from the quotient (the descent, or `1`). -/
private def descOr (t : Dual F) : AddChar (unitRing F ⧸ nR F N) ℂ :=
  open Classical in if h : ∀ w ∈ nR F N, t w = 1 then descChar t h else 1

/-- **Bessel at one level**: distinct characters trivial on `N·R` carry total weight at most `1`. -/
private theorem sum_twW_le (x : unitRing F ⧸ nR F N → unitRing F) (hx : ∀ c, (x c : unitRing F ⧸ nR F N) = c)
    (S : Finset (Dual F)) (hS : ∀ t ∈ S, ∀ w ∈ nR F N, t w = 1) (χ : Dual F) :
    ∑ t ∈ S, twW x t χ ≤ 1 := by
  classical
  have hld : ∀ t ∈ S, liftChar (descOr (N := N) t) = t := fun t ht => by
    rw [descOr, dif_pos (hS t ht), liftChar_descChar]
  have hinj : Set.InjOn (descOr (N := N)) (S : Set (Dual F)) := by
    intro a ha b hb hab
    rw [← hld a (Finset.mem_coe.1 ha), ← hld b (Finset.mem_coe.1 hb), hab]
  calc ∑ t ∈ S, twW x t χ = ∑ t ∈ S, twW x (liftChar (descOr (N := N) t)) χ :=
        Finset.sum_congr rfl fun t ht => by rw [hld t ht]
    _ = ∑ ψ ∈ S.image (descOr (N := N)), twW x (liftChar ψ) χ :=
        (Finset.sum_image (f := fun ψ => twW x (liftChar ψ) χ) hinj).symm
    _ ≤ ∑ ψ : AddChar (unitRing F ⧸ nR F N) ℂ, twW x (liftChar ψ) χ :=
        Finset.sum_le_univ_sum_of_nonneg fun ψ => twW_nonneg x _ χ
    _ = 1 := sum_twW_liftChar x hx χ

/-- **The remainder at one level**: `‖φ(y) − Σ_{t ∈ S} K_t(y)‖ ≤ σ(univ) − Σ_{t ∈ S} K_t(0)`. -/
private theorem norm_sub_sum_twK_le (x : unitRing F ⧸ nR F N → unitRing F)
    (hx : ∀ c, (x c : unitRing F ⧸ nR F N) = c) (S : Finset (Dual F)) (hS : ∀ t ∈ S, ∀ w ∈ nR F N, t w = 1)
    (y : unitRing F) :
    ‖(∫ χ, (χ y : ℂ) ∂σ) - ∑ t ∈ S, twK σ x t y‖ ≤ σ.real Set.univ - ∑ t ∈ S, ∫ χ, twW x t χ ∂σ := by
  set V : Dual F → ℝ := fun χ => 1 - ∑ t ∈ S, twW x t χ with hV
  have hV0 : ∀ χ, 0 ≤ V χ := fun χ => sub_nonneg.2 (sum_twW_le x hx S hS χ)
  have hVm : Measurable V := measurable_const.sub (Finset.measurable_sum _ fun t _ => measurable_twW x t)
  have hint : ∀ t ∈ S, Integrable (fun χ : Dual F => (χ y : ℂ) * (twW x t χ : ℂ)) σ := fun t _ =>
    integrable_eval_mul σ y (measurable_twW x t) (twW_nonneg x t) (twW_le_one x t)
  have hintW : ∀ t ∈ S, Integrable (twW x t) σ := fun t _ =>
    integrable_real σ (measurable_twW x t) (twW_nonneg x t) (twW_le_one x t)
  have h1 : (∫ χ, (χ y : ℂ) ∂σ) - ∑ t ∈ S, twK σ x t y = ∫ χ, (χ y : ℂ) * (V χ : ℂ) ∂σ := by
    have : (fun χ : Dual F => (χ y : ℂ) * (V χ : ℂ)) =
        fun χ => (χ y : ℂ) - ∑ t ∈ S, (χ y : ℂ) * (twW x t χ : ℂ) := by
      funext χ
      simp only [hV]
      push_cast
      rw [mul_sub, mul_one, Finset.mul_sum]
    rw [this, integral_sub (integrable_eval σ y) (integrable_finsetSum _ hint), integral_finsetSum _ hint]
    rfl
  rw [h1]
  refine (norm_integral_le_integral_norm _).trans (le_of_eq ?_)
  have h2 : (fun χ : Dual F => ‖(χ y : ℂ) * (V χ : ℂ)‖) = V := by
    funext χ
    rw [norm_mul, Circle.norm_coe, one_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (hV0 χ)]
  rw [h2, hV, integral_sub (integrable_const _) (integrable_finsetSum _ hintW), integral_finsetSum _ hintW,
    integral_const, smul_eq_mul, mul_one]

end Level3

end MeasureSide
