
/-! ### Private helpers: concentration on a fixed finite level, and continuity -/

section MeasureSide3

variable (σ : Measure (Dual F)) [IsFiniteMeasure σ]

/-- `|G|² ≤ |G₀| · #{(c, c') : π c = π c'}` (Cauchy–Schwarz on the fibre sizes). -/
private theorem card_sq_le_pairs {G G₀ : Type*} [Fintype G] [Fintype G₀] [DecidableEq G₀] (π : G → G₀) :
    ((Fintype.card G : ℝ)) ^ 2 ≤ Fintype.card G₀ * ∑ c : G, ∑ c' : G, if π c = π c' then (1 : ℝ) else 0 := by
  set f : G₀ → ℝ := fun g => ((Finset.univ.filter fun c => π c = g).card : ℝ) with hf
  have h1 : ∑ g, f g = Fintype.card G := by
    have := Finset.card_eq_sum_card_fiberwise (s := (Finset.univ : Finset G)) (t := (Finset.univ : Finset G₀))
      (f := π) fun _ _ => Finset.mem_coe.2 (Finset.mem_univ _)
    rw [Finset.card_univ] at this
    rw [hf]
    exact_mod_cast this.symm
  have h2 : ∑ c : G, ∑ c' : G, (if π c = π c' then (1 : ℝ) else 0) = ∑ g, f g ^ 2 := by
    have hc : ∀ c : G, ∑ c' : G, (if π c = π c' then (1 : ℝ) else 0) = f (π c) := by
      intro c
      rw [Finset.sum_boole, hf]
      congr 2
      ext c'
      simp only [Finset.mem_filter, Finset.mem_univ, true_and, eq_comm]
    simp only [hc]
    rw [← Finset.sum_fiberwise (s := Finset.univ) (g := π) (f := fun c => f (π c))]
    refine Finset.sum_congr rfl fun g _ => ?_
    rw [Finset.sum_congr rfl fun c hc => by rw [(Finset.mem_filter.1 hc).2], Finset.sum_const, nsmul_eq_mul, sq]
  rw [h2, ← h1]
  have := sq_sum_le_card_mul_sum_sq (s := (Finset.univ : Finset G₀)) (f := f)
  rwa [Finset.card_univ] at this

open scoped Classical in
/-- **Concentration on a fixed level**: at any finer level whose representatives are small, the characters of
`R ⧸ N₀·R` carry weight at least `σ(univ) − ε`, once `∫ ‖χ(w) − 1‖ < ε` on `M·R ∩ B_δ` with `M ∣ N₀`. -/
private theorem concentration [NumberField F] {N N₀ : ℕ} [Fintype (unitRing F ⧸ nR F N)]
    [Fintype (unitRing F ⧸ nR F N₀)] (x : unitRing F ⧸ nR F N → unitRing F) {r : ℝ}
    (hr : ∀ c, ‖archHom F (x c)‖ < r) {M : ℕ} (hM : M ∣ N₀) {δ ε : ℝ} (hrδ : 2 * r ≤ δ)
    (hE : ∀ s, ‖archHom F (M • s)‖ < δ → ∫ χ, ‖(χ (M • s) : ℂ) - 1‖ ∂σ < ε) :
    σ.real Set.univ - ε ≤ ∑ ψ : AddChar (unitRing F ⧸ nR F N₀) ℂ, ∫ χ, twW x (liftChar ψ) χ ∂σ := by
  set m := σ.real Set.univ with hm
  set π : unitRing F ⧸ nR F N → unitRing F ⧸ nR F N₀ := fun c => ((x c : unitRing F) : unitRing F ⧸ nR F N₀)
    with hπ
  have hcard : (0 : ℝ) < Fintype.card (unitRing F ⧸ nR F N) := by exact_mod_cast Fintype.card_pos
  have hcard₀ : (0 : ℝ) < Fintype.card (unitRing F ⧸ nR F N₀) := by exact_mod_cast Fintype.card_pos
  -- the pairs in one fibre are close in `N₀·R ∩ B_δ`
  have hpair : ∀ c c', π c = π c' → m - ε ≤ (∫ χ, (χ (x c - x c') : ℂ) ∂σ).re := by
    intro c c' h
    have hmem : x c - x c' ∈ nR F N₀ := by
      have h' := QuotientAddGroup.eq.1 h
      have e : x c - x c' = -(-x c + x c') := by abel
      rw [e]
      exact (nR F N₀).neg_mem h'
    obtain ⟨s, hs⟩ := hmem
    obtain ⟨k, hk⟩ := hM
    have hw : x c - x c' = M • (k • s) := by
      rw [← hs, nsmulAddMonoidHom_apply, hk, mul_nsmul']
    have hsmall : ‖archHom F (M • (k • s))‖ < δ := by
      rw [← hw, map_sub]
      calc ‖archHom F (x c) - archHom F (x c')‖ ≤ ‖archHom F (x c)‖ + ‖archHom F (x c')‖ := norm_sub_le _ _
        _ < r + r := add_lt_add (hr c) (hr c')
        _ = 2 * r := by ring
        _ ≤ δ := hrδ
    have h1 := hE (k • s) hsmall
    rw [← hw] at h1
    have h2 := re_integral_ge σ (x c - x c')
    linarith
  -- the weights of the level-`N₀` characters, as a double sum over the pairs in one fibre
  have hC : ∀ χ : Dual F, ((∑ ψ : AddChar (unitRing F ⧸ nR F N₀) ℂ, twW x (liftChar ψ) χ : ℝ) : ℂ) =
      ((Fintype.card (unitRing F ⧸ nR F N) : ℂ) ^ 2)⁻¹ * ∑ c, ∑ c',
        (if π c = π c' then (Fintype.card (unitRing F ⧸ nR F N₀) : ℂ) else 0) * (χ (x c - x c') : ℂ) := by
    intro χ
    rw [Complex.ofReal_sum]
    simp only [twW_eq, coe_liftChar]
    rw [← Finset.mul_sum, Finset.sum_comm]
    congr 1
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun c' _ => ?_
    rw [← Finset.sum_mul, sum_conj_addChar, QuotientAddGroup.mk_sub]
    simp only [hπ, sub_eq_zero]
  have hintW : ∀ ψ : AddChar (unitRing F ⧸ nR F N₀) ℂ, Integrable (twW x (liftChar ψ)) σ := fun ψ =>
    integrable_real σ (measurable_twW x _) (twW_nonneg x _) (twW_le_one x _)
  rw [← integral_finsetSum _ fun ψ _ => hintW ψ]
  set I := ∫ χ, ∑ ψ : AddChar (unitRing F ⧸ nR F N₀) ℂ, twW x (liftChar ψ) χ ∂σ with hI
  have hI0 : 0 ≤ I := integral_nonneg fun χ => Finset.sum_nonneg fun ψ _ => twW_nonneg x _ χ
  have hIC : (I : ℂ) = ((Fintype.card (unitRing F ⧸ nR F N) : ℂ) ^ 2)⁻¹ * ∑ c, ∑ c',
      (if π c = π c' then (Fintype.card (unitRing F ⧸ nR F N₀) : ℂ) else 0) * ∫ χ, (χ (x c - x c') : ℂ) ∂σ := by
    rw [hI, ← integral_complex_ofReal, integral_congr_ae (Eventually.of_forall hC), integral_const_mul,
      integral_finsetSum _ fun c _ => integrable_finsetSum _ fun c' _ => (integrable_eval σ _).const_mul _]
    congr 1
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [integral_finsetSum _ fun c' _ => (integrable_eval σ _).const_mul _]
    refine Finset.sum_congr rfl fun c' _ => ?_
    rw [integral_const_mul]
  have hIre : I = ((Fintype.card (unitRing F ⧸ nR F N) : ℝ) ^ 2)⁻¹ * ∑ c, ∑ c',
      (if π c = π c' then (Fintype.card (unitRing F ⧸ nR F N₀) : ℝ) * (∫ χ, (χ (x c - x c') : ℂ) ∂σ).re else 0) := by
    have := congrArg Complex.re hIC
    rw [Complex.ofReal_re] at this
    rw [this]
    have e : ((Fintype.card (unitRing F ⧸ nR F N) : ℂ) ^ 2)⁻¹ =
        (((Fintype.card (unitRing F ⧸ nR F N) : ℝ) ^ 2)⁻¹ : ℝ) := by push_cast; rfl
    rw [e, Complex.re_ofReal_mul, Complex.re_sum]
    congr 1
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [Complex.re_sum]
    refine Finset.sum_congr rfl fun c' _ => ?_
    split_ifs
    · rw [← Complex.ofReal_natCast, Complex.re_ofReal_mul]
    · rw [zero_mul, Complex.zero_re]
  by_cases hme : m - ε ≤ 0
  · linarith
  push Not at hme
  have hlow : ((Fintype.card (unitRing F ⧸ nR F N₀) : ℝ) * (m - ε)) *
      (∑ c, ∑ c', if π c = π c' then (1 : ℝ) else 0) ≤
      ∑ c, ∑ c', (if π c = π c' then (Fintype.card (unitRing F ⧸ nR F N₀) : ℝ) *
        (∫ χ, (χ (x c - x c') : ℂ) ∂σ).re else 0) := by
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun c _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun c' _ => ?_
    split_ifs with h
    · rw [mul_one]
      exact mul_le_mul_of_nonneg_left (hpair c c' h) hcard₀.le
    · rw [mul_zero]
  have hcs := card_sq_le_pairs π
  rw [hIre]
  rw [← div_eq_inv_mul, le_div_iff₀ (pow_pos hcard 2)]
  nlinarith

open scoped Classical in
/-- **Continuity at one level**: the twisted part moves by at most `ε` under a shift `z` with
`‖z‖ + 2r < δ`, once `∫ ‖χ(w) − 1‖ < ε` on `M·R ∩ B_δ` with `M ∣ N` (reindex the cosets by `c ↦ c + [z]`). -/
private theorem twK_cont [NumberField F] {N : ℕ} [Fintype (unitRing F ⧸ nR F N)]
    (x : unitRing F ⧸ nR F N → unitRing F) (hx : ∀ c, (x c : unitRing F ⧸ nR F N) = c) {r : ℝ}
    (hr : ∀ c, ‖archHom F (x c)‖ < r) {t : Dual F} (ht : ∀ w ∈ nR F N, t w = 1) {M : ℕ} (hMN : M ∣ N)
    {δ ε : ℝ} (hE : ∀ s, ‖archHom F (M • s)‖ < δ → ∫ χ, ‖(χ (M • s) : ℂ) - 1‖ ∂σ < ε)
    (y z : unitRing F) (hz : ‖archHom F z‖ + 2 * r < δ) :
    ‖(starRingEnd ℂ) (t (y + z) : ℂ) * twK σ x t (y + z) - (starRingEnd ℂ) (t y : ℂ) * twK σ x t y‖ ≤ ε := by
  set G := unitRing F ⧸ nR F N
  have hcard : (0 : ℝ) < Fintype.card G := by exact_mod_cast Fintype.card_pos
  set zq : G := (z : G) with hzq
  set w : G → unitRing F := fun c => z + x c - x (c + zq) with hw
  have hwmem : ∀ c, w c ∈ nR F N := by
    intro c
    rw [← QuotientAddGroup.eq_zero_iff, hw]
    simp only [QuotientAddGroup.mk_sub, QuotientAddGroup.mk_add, hx, hzq]
    abel
  have hwE : ∀ c, ∫ χ, ‖(χ (w c) : ℂ) - 1‖ ∂σ < ε := by
    intro c
    obtain ⟨s, hs⟩ := hwmem c
    obtain ⟨k, hk⟩ := hMN
    have hw' : w c = M • (k • s) := by rw [← hs, nsmulAddMonoidHom_apply, hk, mul_nsmul']
    rw [hw']
    refine hE (k • s) ?_
    rw [← hw', hw, map_sub, map_add]
    calc ‖archHom F z + archHom F (x c) - archHom F (x (c + zq))‖
        ≤ ‖archHom F z‖ + ‖archHom F (x c)‖ + ‖archHom F (x (c + zq))‖ := by
          refine (norm_sub_le _ _).trans ?_
          gcongr
          exact norm_add_le _ _
      _ < ‖archHom F z‖ + r + r := by linarith [hr c, hr (c + zq)]
      _ < δ := by linarith
  -- pointwise: `‖t̄(z)χ(z) − 1‖ · twW ≤ |G|⁻¹ Σ_c ‖χ(w_c) − 1‖`
  have hpt : ∀ χ : Dual F, ‖(starRingEnd ℂ) (t z : ℂ) * (χ z : ℂ) - 1‖ * twW x t χ ≤
      (Fintype.card G : ℝ)⁻¹ * ∑ c, ‖(χ (w c) : ℂ) - 1‖ := by
    intro χ
    set a : G → ℂ := fun c => (starRingEnd ℂ) (t (x c) : ℂ) * (χ (x c) : ℂ) with ha
    have hna : ∀ c, ‖a c‖ = 1 := fun c => by
      rw [ha, norm_mul, RCLike.norm_conj, Circle.norm_coe, Circle.norm_coe, one_mul]
    set v : ℂ := (starRingEnd ℂ) (t z : ℂ) * (χ z : ℂ) with hv
    have hA : twSum x t χ = ∑ c, a c := rfl
    have hshift : ∑ c, a c = ∑ c, a (c + zq) := (Equiv.addRight zq).sum_comp a |>.symm
    have hva : ∀ c, v * a c = a (c + zq) * (χ (w c) : ℂ) := by
      intro c
      have e : z + x c = x (c + zq) + w c := by rw [hw]; abel
      have htw : ((t (w c) : Circle) : ℂ) = 1 := by rw [ht _ (hwmem c), Circle.coe_one]
      have h1 : v * a c = (starRingEnd ℂ) (t (z + x c) : ℂ) * (χ (z + x c) : ℂ) := by
        rw [hv, ha, coe_char_add, coe_char_add, map_mul]
        ring
      rw [h1, e, coe_char_add, coe_char_add, map_mul, htw, map_one, ha]
      ring
    have hdiff : ‖v * twSum x t χ - twSum x t χ‖ ≤ ∑ c, ‖(χ (w c) : ℂ) - 1‖ := by
      rw [hA, Finset.mul_sum, Finset.sum_congr rfl fun c _ => hva c, hshift, ← Finset.sum_sub_distrib]
      refine (norm_sum_le _ _).trans (Finset.sum_le_sum fun c _ => ?_)
      rw [← mul_sub_one, norm_mul, hna, one_mul]
    have hnA := norm_twSum_le x t χ
    have hkey : ‖v - 1‖ * ‖twSum x t χ‖ ≤ ∑ c, ‖(χ (w c) : ℂ) - 1‖ := by
      rw [← norm_mul, sub_one_mul]
      exact hdiff
    unfold twW
    rw [mul_div_assoc', div_le_iff₀ (by positivity)]
    have hS0 : 0 ≤ ∑ c, ‖(χ (w c) : ℂ) - 1‖ := Finset.sum_nonneg fun c _ => norm_nonneg _
    calc ‖v - 1‖ * ‖twSum x t χ‖ ^ 2 = (‖v - 1‖ * ‖twSum x t χ‖) * ‖twSum x t χ‖ := by ring
      _ ≤ (∑ c, ‖(χ (w c) : ℂ) - 1‖) * Fintype.card G :=
          mul_le_mul hkey hnA (norm_nonneg _) hS0
      _ = (Fintype.card G : ℝ)⁻¹ * (∑ c, ‖(χ (w c) : ℂ) - 1‖) * (Fintype.card G : ℝ) ^ 2 := by
          field_simp
  -- integrate
  have hint : ∀ u : unitRing F, Integrable (fun χ : Dual F => (χ u : ℂ) * (twW x t χ : ℂ)) σ := fun u =>
    integrable_eval_mul σ u (measurable_twW x t) (twW_nonneg x t) (twW_le_one x t)
  have hdiffK : (starRingEnd ℂ) (t (y + z) : ℂ) * twK σ x t (y + z) - (starRingEnd ℂ) (t y : ℂ) * twK σ x t y =
      ∫ χ, ((starRingEnd ℂ) (t y : ℂ) * (χ y : ℂ)) * (((starRingEnd ℂ) (t z : ℂ) * (χ z : ℂ) - 1) *
        (twW x t χ : ℂ)) ∂σ := by
    rw [twK, twK, ← integral_const_mul, ← integral_const_mul, ← integral_sub ((hint _).const_mul _)
      ((hint _).const_mul _)]
    refine integral_congr_ae (Eventually.of_forall fun χ => ?_)
    simp only [coe_char_add, map_mul]
    ring
  rw [hdiffK]
  have hintS : Integrable (fun χ : Dual F => (Fintype.card G : ℝ)⁻¹ * ∑ c, ‖(χ (w c) : ℂ) - 1‖) σ :=
    (integrable_finsetSum _ fun c _ => ((integrable_eval σ (w c)).sub (integrable_const 1)).norm).const_mul _
  calc ‖∫ χ, ((starRingEnd ℂ) (t y : ℂ) * (χ y : ℂ)) * (((starRingEnd ℂ) (t z : ℂ) * (χ z : ℂ) - 1) *
        (twW x t χ : ℂ)) ∂σ‖
      ≤ ∫ χ, (Fintype.card G : ℝ)⁻¹ * ∑ c, ‖(χ (w c) : ℂ) - 1‖ ∂σ := by
        refine norm_integral_le_of_norm_le hintS (Eventually.of_forall fun χ => ?_)
        rw [norm_mul, norm_mul, norm_mul, RCLike.norm_conj, Circle.norm_coe, Circle.norm_coe, one_mul, one_mul,
          Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (twW_nonneg x t χ)]
        exact hpt χ
    _ = (Fintype.card G : ℝ)⁻¹ * ∑ c, ∫ χ, ‖(χ (w c) : ℂ) - 1‖ ∂σ := by
        rw [integral_const_mul, integral_finsetSum _ fun c _ =>
          ((integrable_eval σ (w c)).sub (integrable_const 1)).norm]
    _ ≤ (Fintype.card G : ℝ)⁻¹ * ∑ _c : G, ε := by
        gcongr with c
        exact (hwE c).le
    _ = ε := by
        rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
        field_simp

end MeasureSide3
