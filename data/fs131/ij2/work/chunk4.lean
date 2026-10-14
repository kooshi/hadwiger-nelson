
/-- A character of `R ⧸ N·R`, read on `R`, kills `N·R`. -/
private theorem liftChar_eq_one {N : ℕ} [Finite (unitRing F ⧸ nR F N)] (ψ : AddChar (unitRing F ⧸ nR F N) ℂ)
    {w : unitRing F} (hw : w ∈ nR F N) : liftChar ψ w = 1 :=
  Circle.ext (by
    rw [coe_liftChar, (QuotientAddGroup.eq_zero_iff w).2 hw, AddChar.map_zero_eq_one, Circle.coe_one])

private theorem nR_mono {N N' : ℕ} (h : N ∣ N') : nR F N' ≤ nR F N := by
  rintro w ⟨s, rfl⟩
  obtain ⟨k, rfl⟩ := h
  exact ⟨k • s, by rw [nsmulAddMonoidHom_apply, nsmulAddMonoidHom_apply, mul_nsmul']⟩

end TwistedHelpers

open scoped Classical in
/-- **The twisted parts** (the profinite step; the hard leaf of M2b): a finite measure on `R̂` with `τ′_∅`-continuous transform
`φ` has `φ = Σ_{t ∈ T} ψ_t` pointwise, with each `t̄·ψ_t` positive-definite and continuous for `archTop`, and the masses
`ψ_t 0` summable. `ψ_t(y) = lim_{N′} |R ⧸ N′R|⁻¹ Σ_c t̄(x_c) φ(y + x_c)` over arch-small representatives `x_c`. -/
theorem exists_twisted_parts [NumberField F] (σ : Measure (Dual F)) [IsFiniteMeasure σ]
    (h : @Continuous (unitRing F) ℂ (tauPrime F) _ fun y => ∫ χ, (χ y : ℂ) ∂σ) :
    ∃ ψ : torsionChars (unitRing F) → unitRing F → ℂ,
      (∀ t : torsionChars (unitRing F), PosDef fun y => (starRingEnd ℂ) ((t : Dual F) y : ℂ) * ψ t y) ∧
      (∀ t : torsionChars (unitRing F),
        @Continuous (unitRing F) ℂ (archTop F) _ fun y => (starRingEnd ℂ) ((t : Dual F) y : ℂ) * ψ t y) ∧
      Summable (fun t => (ψ t 0).re) ∧ ∀ y, HasSum (fun t => ψ t y) (∫ χ, (χ y : ℂ) ∂σ) := by
  set m := σ.real Set.univ with hm
  set φ : unitRing F → ℂ := fun y => ∫ χ, (χ y : ℂ) ∂σ with hφ
  -- the levels `(n + 1)!` and their small representatives
  have hNn0 : ∀ n : ℕ, (n + 1).factorial ≠ 0 := fun n => Nat.factorial_ne_zero _
  have hdvd : ∀ M : ℕ, M ≠ 0 → ∀ n : ℕ, M ≤ n + 1 → M ∣ (n + 1).factorial := fun M hM n hn =>
    Nat.dvd_factorial (Nat.pos_of_ne_zero hM) hn
  letI hfin : ∀ n : ℕ, Fintype (unitRing F ⧸ nR F (n + 1).factorial) := fun n =>
    @Fintype.ofFinite _ (finite_quotient_nsmul F _ (hNn0 n))
  have hrep := fun n : ℕ => exists_reps F ((n + 1).factorial) (hNn0 n) (δ := 1 / ((n : ℝ) + 1)) (by positivity)
  choose x hx hxr using hrep
  have hsmallr : ∀ η > 0, ∀ᶠ n : ℕ in atTop, 2 * (1 / ((n : ℝ) + 1)) < η := by
    intro η hη
    have h0 : Tendsto (fun n : ℕ => 2 * (1 / ((n : ℝ) + 1))) atTop (𝓝 0) := by
      simpa using tendsto_one_div_add_atTop_nhds_zero_nat.const_mul (2 : ℝ)
    exact h0.eventually (gt_mem_nhds hη)
  -- every torsion character is trivial on `(n + 1)!·R` from some level on
  have htriv : ∀ t : torsionChars (unitRing F), ∀ᶠ n : ℕ in atTop,
      ∀ w ∈ nR F (n + 1).factorial, (t : Dual F) w = 1 := by
    rintro ⟨t, N₀, hN₀, ht⟩
    filter_upwards [eventually_ge_atTop N₀] with n hn
    rintro w ⟨s, rfl⟩
    obtain ⟨k, hk⟩ := hdvd N₀ hN₀ n (by omega)
    show t (((n + 1).factorial) • s) = 1
    rw [hk, mul_nsmul', AddChar.map_nsmul_eq_pow, ← AddChar.pow_apply, ht, AddChar.one_apply]
  -- the parts at level `n`
  set P : ℕ → torsionChars (unitRing F) → unitRing F → ℂ := fun n t y =>
    if ∀ w ∈ nR F (n + 1).factorial, (t : Dual F) w = 1 then twK σ (x n) t y else 0 with hP
  have hPb : ∀ n t y, ‖P n t y‖ ≤ m := by
    intro n t y
    simp only [hP]
    split_ifs
    · exact norm_twK_le σ (x n) t y
    · rw [norm_zero]
      exact measureReal_nonneg
  -- an ultrafilter limit of the parts
  set U : Ultrafilter ℕ := Ultrafilter.of atTop with hUdef
  have hU : (U : Filter ℕ) ≤ atTop := Ultrafilter.of_le atTop
  have hlim : ∀ t y, ∃ L, Tendsto (fun n => P n t y) (U : Filter ℕ) (𝓝 L) := by
    intro t y
    obtain ⟨L, -, hL⟩ := (isCompact_closedBall (0 : ℂ) m).ultrafilter_le_nhds (U.map fun n => P n t y) (by
      rw [Ultrafilter.coe_map]
      exact Filter.le_principal_iff.2 (Filter.mem_map.2 (Filter.univ_mem' fun n =>
        mem_closedBall_zero_iff.2 (hPb n t y))))
    exact ⟨L, by rw [Ultrafilter.coe_map] at hL; exact hL⟩
  choose ψ hψ using hlim
  have hev : ∀ t : torsionChars (unitRing F), ∀ᶠ n in (U : Filter ℕ), P n t = twK σ (x n) t := fun t =>
    (hU (htriv t)).mono fun n hn => funext fun y => by simp only [hP, if_pos hn]
  -- (1) each `t̄·ψ_t` is positive-definite: a limit of positive-definite functions
  have hPD : ∀ t : torsionChars (unitRing F), PosDef fun y => (starRingEnd ℂ) ((t : Dual F) y : ℂ) * ψ t y := by
    intro t s z
    set Q : ℕ → ℂ := fun n => ∑ a ∈ s, ∑ b ∈ s, z a * star (z b) *
      ((starRingEnd ℂ) ((t : Dual F) (a - b) : ℂ) * P n t (a - b)) with hQ
    have hQt : Tendsto Q (U : Filter ℕ) (𝓝 (∑ a ∈ s, ∑ b ∈ s, z a * star (z b) *
        ((starRingEnd ℂ) ((t : Dual F) (a - b) : ℂ) * ψ t (a - b)))) :=
      tendsto_finsetSum _ fun a _ => tendsto_finsetSum _ fun b _ => ((hψ t (a - b)).const_mul _).const_mul _
    have hQev : ∀ᶠ n in (U : Filter ℕ), (Q n).im = 0 ∧ 0 ≤ (Q n).re := (hev t).mono fun n hn => by
      have h1 := posDef_twK σ (x n) (t : Dual F) s z
      simp only [hQ, hn]
      exact h1
    have him := (Complex.continuous_im.tendsto _).comp hQt
    have hre := (Complex.continuous_re.tendsto _).comp hQt
    exact ⟨tendsto_nhds_unique him (tendsto_const_nhds.congr' (hQev.mono fun n hn => hn.1.symm)),
      ge_of_tendsto hre (hQev.mono fun n hn => hn.2)⟩
  -- (2) each `t̄·ψ_t` is continuous for `archTop`: the level estimate passes to the limit
  have hcont : ∀ t : torsionChars (unitRing F),
      @Continuous (unitRing F) ℂ (archTop F) _ fun y => (starRingEnd ℂ) ((t : Dual F) y : ℂ) * ψ t y := by
    intro t
    refine (@continuous_iff_continuousAt _ _ (archTop F) _ _).2 fun y => ?_
    show Tendsto _ (@nhds _ (archTop F) y) _
    rw [archTop_eq, nhds_induced, Metric.tendsto_nhds]
    intro ε hε
    obtain ⟨M, hM, δ, hδ, hE⟩ := exists_E_small σ h (half_pos hε)
    have hball : (archHom F) ⁻¹' Metric.ball (archHom F y) (δ / 2) ∈
        Filter.comap (archHom F) (𝓝 (archHom F y)) :=
      Filter.preimage_mem_comap (Metric.ball_mem_nhds _ (half_pos hδ))
    filter_upwards [hball] with y' hy'
    rw [Set.mem_preimage, Metric.mem_ball, dist_eq_norm] at hy'
    have hyz : y + (y' - y) = y' := by abel
    have hzn : ‖archHom F (y' - y)‖ < δ / 2 := by rw [map_sub]; exact hy'
    have hlev : ∀ᶠ n in (U : Filter ℕ), ‖(starRingEnd ℂ) ((t : Dual F) y' : ℂ) * P n t y' -
        (starRingEnd ℂ) ((t : Dual F) y : ℂ) * P n t y‖ ≤ ε / 2 := by
      filter_upwards [hev t, hU (htriv t), hU (eventually_ge_atTop M), hU (hsmallr (δ / 2) (half_pos hδ))]
        with n hn hn1 hn2 hn3
      rw [hn, ← hyz]
      exact twK_cont σ (x n) (hx n) (hxr n) hn1 (hdvd M hM n (by omega)) hE y (y' - y) (by linarith)
    have hl := (((hψ t y').const_mul ((starRingEnd ℂ) ((t : Dual F) y' : ℂ))).sub
      ((hψ t y).const_mul ((starRingEnd ℂ) ((t : Dual F) y : ℂ)))).norm
    have := le_of_tendsto hl hlev
    rw [dist_eq_norm]
    linarith
  -- the remainder at level `n`, for a finite set of torsion characters
  have hlevS : ∀ n (S : Finset (torsionChars (unitRing F))) y,
      ‖φ y - ∑ t ∈ S, P n t y‖ ≤ m - ∑ t ∈ S, (P n t 0).re := by
    intro n S y
    set S' : Finset (Dual F) := (S.filter fun t => ∀ w ∈ nR F (n + 1).factorial, (t : Dual F) w = 1).map
      (Function.Embedding.subtype _) with hS'
    have hS'triv : ∀ t ∈ S', ∀ w ∈ nR F (n + 1).factorial, t w = 1 := by
      intro t ht
      rw [hS', Finset.mem_map] at ht
      obtain ⟨t', ht', rfl⟩ := ht
      exact (Finset.mem_filter.1 ht').2
    have hsum : ∀ y, ∑ t ∈ S, P n t y = ∑ t ∈ S', twK σ (x n) t y := by
      intro y
      rw [hS', Finset.sum_map, Finset.sum_filter]
      rfl
    have hsum0 : ∑ t ∈ S, (P n t 0).re = ∑ t ∈ S', ∫ χ, twW (x n) t χ ∂σ := by
      rw [← Complex.re_sum, hsum 0, Complex.re_sum]
      refine Finset.sum_congr rfl fun t _ => ?_
      rw [twK_zero, Complex.ofReal_re]
    rw [hsum y, hsum0]
    exact norm_sub_sum_twK_le σ (x n) (hx n) S' hS'triv y
  -- (3) the masses: non-negative, with partial sums at most `σ(univ)`
  have hre0 : ∀ t, 0 ≤ (ψ t 0).re := fun t =>
    ge_of_tendsto ((Complex.continuous_re.tendsto _).comp (hψ t 0)) (Eventually.of_forall fun n => by
      simp only [Function.comp, hP]
      split_ifs
      · rw [twK_zero, Complex.ofReal_re]
        exact integral_nonneg fun χ => twW_nonneg _ _ _
      · rw [Complex.zero_re])
  have hpart : ∀ (S : Finset (torsionChars (unitRing F))) y,
      ‖φ y - ∑ t ∈ S, ψ t y‖ ≤ m - ∑ t ∈ S, (ψ t 0).re := by
    intro S y
    have h1 : Tendsto (fun n => ‖φ y - ∑ t ∈ S, P n t y‖) (U : Filter ℕ) (𝓝 ‖φ y - ∑ t ∈ S, ψ t y‖) :=
      (tendsto_const_nhds.sub (tendsto_finsetSum _ fun t _ => hψ t y)).norm
    have h2 : Tendsto (fun n => m - ∑ t ∈ S, (P n t 0).re) (U : Filter ℕ) (𝓝 (m - ∑ t ∈ S, (ψ t 0).re)) :=
      tendsto_const_nhds.sub (tendsto_finsetSum _ fun t _ => (Complex.continuous_re.tendsto _).comp (hψ t 0))
    exact le_of_tendsto_of_tendsto' h1 h2 fun n => hlevS n S y
  have hsummable : Summable fun t => (ψ t 0).re := summable_of_sum_le (fun t => hre0 t) fun S => by
    have := hpart S 0
    linarith [norm_nonneg (φ 0 - ∑ t ∈ S, ψ t 0)]
  -- (4) concentration on the characters of one finite level
  have hconc : ∀ ε > 0, ∃ S₀ : Finset (torsionChars (unitRing F)), m - ε ≤ ∑ t ∈ S₀, (ψ t 0).re := by
    intro ε hε
    obtain ⟨M, hM, δ, hδ, hE⟩ := exists_E_small σ h hε
    have hMN₀ : M ∣ (M + 1).factorial := hdvd M hM M (by omega)
    let lt : AddChar (unitRing F ⧸ nR F (M + 1).factorial) ℂ → torsionChars (unitRing F) := fun ψ' =>
      ⟨liftChar ψ', (M + 1).factorial, hNn0 M, AddChar.ext _ _ fun r => by
        rw [AddChar.pow_apply, ← AddChar.map_nsmul_eq_pow, AddChar.one_apply]
        exact liftChar_eq_one ψ' ⟨r, rfl⟩⟩
    have hlt_inj : Function.Injective lt := fun a b hab => liftChar_injective (congrArg Subtype.val hab)
    refine ⟨Finset.univ.image lt, ?_⟩
    rw [Finset.sum_image fun a _ b _ hab => hlt_inj hab]
    have hlev : ∀ᶠ n in (U : Filter ℕ), m - ε ≤ ∑ ψ' : AddChar (unitRing F ⧸ nR F (M + 1).factorial) ℂ,
        (P n (lt ψ') 0).re := by
      filter_upwards [hU (eventually_ge_atTop M), hU (hsmallr δ hδ)] with n hn1 hn2
      have hdiv : (M + 1).factorial ∣ (n + 1).factorial := Nat.factorial_dvd_factorial (by omega)
      have htr : ∀ ψ' : AddChar (unitRing F ⧸ nR F (M + 1).factorial) ℂ,
          ∀ w ∈ nR F (n + 1).factorial, ((lt ψ' : torsionChars (unitRing F)) : Dual F) w = 1 :=
        fun ψ' w hw => liftChar_eq_one ψ' (nR_mono hdiv hw)
      have hval : ∀ ψ', (P n (lt ψ') 0).re = ∫ χ, twW (x n) (liftChar ψ') χ ∂σ := fun ψ' => by
        simp only [hP, if_pos (htr ψ')]
        rw [twK_zero, Complex.ofReal_re]
      simp only [hval]
      exact concentration σ (x n) (hxr n) hMN₀ hn2.le hE
    exact ge_of_tendsto (tendsto_finsetSum _ fun ψ' _ => (Complex.continuous_re.tendsto _).comp (hψ (lt ψ') 0))
      hlev
  refine ⟨ψ, hPD, hcont, hsummable, fun y => ?_⟩
  unfold HasSum
  rw [SummationFilter.unconditional_filter, Metric.tendsto_atTop]
  intro ε hε
  obtain ⟨S₀, hS₀⟩ := hconc (ε / 2) (half_pos hε)
  refine ⟨S₀, fun S hS => ?_⟩
  have h1 := hpart S y
  have h2 : ∑ t ∈ S₀, (ψ t 0).re ≤ ∑ t ∈ S, (ψ t 0).re :=
    Finset.sum_le_sum_of_subset_of_nonneg hS fun t _ _ => hre0 t
  rw [dist_eq_norm, norm_sub_rev]
  linarith
