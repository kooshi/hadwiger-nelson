import sys
p=sys.argv[1]
s=open(p).read()
def rep(old,new):
    global s
    assert s.count(old)==1, old[:100]
    s=s.replace(old,new)
rep("""theorem exists_prime_mod_four_eq_three_dvd {N : ℕ} (hN : N % 4 = 3) : ∃ q : ℕ, q.Prime ∧ q % 4 = 3 ∧ q ∣ N := by
  sorry""","""theorem exists_prime_mod_four_eq_three_dvd {N : ℕ} (hN : N % 4 = 3) : ∃ q : ℕ, q.Prime ∧ q % 4 = 3 ∧ q ∣ N := by
  induction N using Nat.strong_induction_on with
  | _ N ih =>
    have hN1 : N ≠ 1 := by omega
    have hpp : N.minFac.Prime := Nat.minFac_prime hN1
    obtain ⟨k, hk⟩ := Nat.minFac_dvd N
    by_cases h3 : N.minFac % 4 = 3
    · exact ⟨N.minFac, hpp, h3, Nat.minFac_dvd N⟩
    have hmod : N.minFac % 4 * (k % 4) % 4 = 3 := by rw [← Nat.mul_mod, ← hk]; exact hN
    have hcase : N.minFac % 4 = 1 ∧ k % 4 = 3 := by
      rcases (by omega : N.minFac % 4 = 0 ∨ N.minFac % 4 = 1 ∨ N.minFac % 4 = 2 ∨ N.minFac % 4 = 3) with h | h | h | h <;>
      rcases (by omega : k % 4 = 0 ∨ k % 4 = 1 ∨ k % 4 = 2 ∨ k % 4 = 3) with h' | h' | h' | h' <;>
      simp only [h, h'] at hmod <;> omega
    have hkN : k < N := by
      have h2 := hpp.two_le
      have hk0 : 0 < k := by omega
      have : k < N.minFac * k := by nlinarith
      omega
    obtain ⟨q, hq, hq4, hqk⟩ := ih k hkN hcase.2
    exact ⟨q, hq, hq4, hqk.trans ⟨N.minFac, by rw [hk, mul_comm]⟩⟩""")
rep("""    ∃ a b : ℝ, a < b ∧ ∀ y ∈ Set.Ioo a b, aeval y f < 0 := by
  sorry""","""    ∃ a b : ℝ, a < b ∧ ∀ y ∈ Set.Ioo a b, aeval y f < 0 := by
  set g : ℝ[X] := f.map (algebraMap ℤ ℝ) with hg
  have hev : ∀ y : ℝ, aeval y f = g.eval y := fun y => (eval_map_algebraMap f y).symm
  have hroot : g.IsRoot θ := by rw [IsRoot, ← hev, hθ]
  set h : ℝ[X] := g /ₘ (X - C θ) with hh
  have hfac : (X - C θ) * h = g := mul_divByMonic_eq_iff_isRoot.2 hroot
  have hhθ : h.eval θ ≠ 0 := by
    have hd : (derivative g).eval θ = h.eval θ := by
      rw [← hfac, derivative_mul, derivative_sub, derivative_X, derivative_C, sub_zero, one_mul, eval_add, eval_mul,
        eval_sub, eval_X, eval_C, sub_self, zero_mul, add_zero]
    rw [← hd, hg, derivative_map, eval_map_algebraMap]
    exact hθ'
  have hval : ∀ y, aeval y f = (y - θ) * h.eval y := fun y => by
    rw [hev, ← hfac, eval_mul, eval_sub, eval_X, eval_C]
  have hcont : ContinuousAt (fun y => h.eval y) θ := h.continuous.continuousAt
  rcases lt_or_gt_of_ne hhθ with hneg | hpos
  · obtain ⟨ε, hε, hball⟩ := Metric.eventually_nhds_iff.1 (hcont.eventually (gt_mem_nhds hneg))
    refine ⟨θ, θ + ε, by linarith, fun y hy => ?_⟩
    have hyh : h.eval y < 0 := hball (by rw [Real.dist_eq, abs_lt]; constructor <;> linarith [hy.1, hy.2])
    rw [hval]
    exact mul_neg_of_pos_of_neg (by linarith [hy.1]) hyh
  · obtain ⟨ε, hε, hball⟩ := Metric.eventually_nhds_iff.1 (hcont.eventually (lt_mem_nhds hpos))
    refine ⟨θ - ε, θ, by linarith, fun y hy => ?_⟩
    have hyh : 0 < h.eval y := hball (by rw [Real.dist_eq, abs_lt]; constructor <;> linarith [hy.1, hy.2])
    rw [hval]
    exact mul_neg_of_neg_of_pos (by linarith [hy.2]) hyh""")
rep("""    ∃ (e : ℕ) (t : ℤ), 1 ≤ e ∧ a < ((1 + D * t : ℤ) : ℝ) / (D : ℝ) ^ e ∧ ((1 + D * t : ℤ) : ℝ) / (D : ℝ) ^ e < b := by
  sorry""","""    ∃ (e : ℕ) (t : ℤ), 1 ≤ e ∧ a < ((1 + D * t : ℤ) : ℝ) / (D : ℝ) ^ e ∧ ((1 + D * t : ℤ) : ℝ) / (D : ℝ) ^ e < b := by
  have hD1 : (1 : ℝ) < D := by exact_mod_cast hD
  have hDpos : (0 : ℝ) < D := by linarith
  have hba : 0 < b - a := by linarith
  obtain ⟨n, hn⟩ := pow_unbounded_of_one_lt ((D : ℝ) / (b - a)) hD1
  set K : ℝ := (D : ℝ) ^ (n + 1) with hK
  have hKpos : 0 < K := pow_pos hDpos _
  have hKD : (D : ℝ) < (b - a) * K := by
    have h1 : (D : ℝ) / (b - a) < K := hn.trans_le (pow_le_pow_right₀ hD1.le (Nat.le_succ n))
    rw [div_lt_iff₀ hba] at h1
    linarith
  set x : ℝ := (a * K - 1) / D with hx
  have hfl1 : a * K - 1 < (↑⌊x⌋ + 1) * D := (div_lt_iff₀ hDpos).1 (Int.lt_floor_add_one x)
  have hfl2 : ↑⌊x⌋ * (D : ℝ) ≤ a * K - 1 := (le_div_iff₀ hDpos).1 (Int.floor_le x)
  refine ⟨n + 1, ⌊x⌋ + 1, by omega, ?_, ?_⟩
  · rw [lt_div_iff₀ hKpos]
    push_cast
    linarith
  · rw [div_lt_iff₀ hKpos]
    push_cast
    linarith""")
rep("""    (((f.scaleRoots k).eval x : ℤ) : ℝ) = (k : ℝ) ^ f.natDegree * aeval ((x : ℝ) / k) f := by
  sorry""","""    (((f.scaleRoots k).eval x : ℤ) : ℝ) = (k : ℝ) ^ f.natDegree * aeval ((x : ℝ) / k) f := by
  have hk' : (k : ℝ) ≠ 0 := by exact_mod_cast hk
  have h := scaleRoots_eval₂_mul (p := f) (Int.castRingHom ℝ) ((x : ℝ) / k) k
  simp only [Int.coe_castRingHom] at h
  rw [mul_div_cancel₀ _ hk', eval₂_at_intCast, Int.cast_id, Int.coe_castRingHom] at h
  rw [h, aeval_def, algebraMap_int_eq]""")
rep("""    k ∣ (f.scaleRoots k).eval x - x ^ f.natDegree := by
  sorry""","""    k ∣ (f.scaleRoots k).eval x - x ^ f.natDegree := by
  rw [eval_eq_sum_range, natDegree_scaleRoots, Finset.sum_range_succ, coeff_scaleRoots, Nat.sub_self, pow_zero,
    mul_one, hf.coeff_natDegree, one_mul, add_sub_cancel_right]
  refine Finset.dvd_sum fun i hi => ?_
  rw [coeff_scaleRoots]
  have hi' : f.natDegree - i ≠ 0 := by have := Finset.mem_range.1 hi; omega
  exact Dvd.dvd.mul_right (Dvd.dvd.mul_left (dvd_pow_self k hi') _) _""")
rep("""    (hdvd : (q : ℤ) ∣ (f.scaleRoots k).eval x) : ∃ t : ℤ, (q : ℤ) ∣ f.eval t := by
  sorry""","""    (hdvd : (q : ℤ) ∣ (f.scaleRoots k).eval x) : ∃ t : ℤ, (q : ℤ) ∣ f.eval t := by
  haveI : Fact q.Prime := ⟨hq⟩
  have hk' : (k : ZMod q) ≠ 0 := fun h => hk ((ZMod.intCast_zmod_eq_zero_iff_dvd k q).1 h)
  set r : ZMod q := (x : ZMod q) * (k : ZMod q)⁻¹ with hr
  have h0 : eval₂ (Int.castRingHom (ZMod q)) r f = 0 := by
    have hz : (((f.scaleRoots k).eval x : ℤ) : ZMod q) = 0 := (ZMod.intCast_zmod_eq_zero_iff_dvd _ q).2 hdvd
    have h1 := scaleRoots_eval₂_mul (p := f) (Int.castRingHom (ZMod q)) r k
    simp only [Int.coe_castRingHom] at h1
    rw [hr, mul_inv_cancel_left₀ hk', eval₂_at_intCast, Int.cast_id, Int.coe_castRingHom, hz] at h1
    rcases mul_eq_zero.1 h1.symm with h2 | h2
    · exact absurd (pow_eq_zero_iff'.1 h2).1 hk'
    · exact h2
  refine ⟨(r.val : ℤ), (ZMod.intCast_zmod_eq_zero_iff_dvd _ q).1 ?_⟩
  have h3 := eval₂_at_intCast (p := f) (Int.castRingHom (ZMod q)) (r.val : ℤ)
  rw [Int.cast_natCast, ZMod.natCast_zmod_val, h0, Int.cast_id, Int.coe_castRingHom] at h3
  exact h3.symm""")
rep("""    ∃ q : ℕ, q.Prime ∧ q % 4 = 3 ∧ ¬ q ∣ M ∧ ∃ t : ℤ, (q : ℤ) ∣ f.eval t := by
  sorry""","""    ∃ q : ℕ, q.Prime ∧ q % 4 = 3 ∧ ¬ q ∣ M ∧ ∃ t : ℤ, (q : ℤ) ∣ f.eval t := by
  obtain ⟨a, b, hab, hneg⟩ := exists_Ioo_aeval_neg f hθ hθ'
  set D : ℕ := 4 * M with hD
  have hD2 : 2 ≤ D := by omega
  obtain ⟨e, t, he, h1, h2⟩ := exists_one_add_mul_div_pow_mem_Ioo hD2 hab
  set x : ℤ := 1 + D * t with hx
  set k : ℤ := (D : ℤ) ^ e with hk
  have hD0 : (D : ℤ) ≠ 0 := by exact_mod_cast (show D ≠ 0 by omega)
  have hk0 : k ≠ 0 := pow_ne_zero _ hD0
  have hkR : (k : ℝ) = (D : ℝ) ^ e := by rw [hk]; push_cast; ring
  set V : ℤ := (f.scaleRoots k).eval x with hV
  have hVneg : V < 0 := by
    have h := scaleRoots_eval_eq f x hk0
    have hy : (x : ℝ) / k ∈ Set.Ioo a b := by rw [hkR]; exact ⟨h1, h2⟩
    have hpos : (0 : ℝ) < (k : ℝ) ^ f.natDegree := by rw [hkR]; positivity
    have hR : ((V : ℤ) : ℝ) < 0 := by rw [hV, h]; exact mul_neg_of_pos_of_neg hpos (hneg _ hy)
    exact_mod_cast hR
  -- `V ≡ xⁿ ≡ 1 (mod D)`
  have hDk : (D : ℤ) ∣ k := by rw [hk]; exact dvd_pow_self _ (by omega)
  have hVmod : (D : ℤ) ∣ V - 1 := by
    have h5 := dvd_scaleRoots_eval_sub_pow hf x k
    have h6 : (D : ℤ) ∣ x ^ f.natDegree - 1 := by
      have h7 := sub_dvd_pow_sub_pow x 1 f.natDegree
      rw [one_pow] at h7
      exact (show (D : ℤ) ∣ x - 1 from ⟨t, by rw [hx]; ring⟩).trans h7
    have h8 := dvd_add (hDk.trans h5) h6
    rwa [sub_add_sub_cancel] at h8
  set N : ℕ := (-V).toNat with hN
  have hNV : (N : ℤ) = -V := Int.toNat_of_nonneg (by omega)
  have hN4 : N % 4 = 3 := by
    have h4 : (4 : ℤ) ∣ V - 1 := (show (4 : ℤ) ∣ (D : ℤ) from ⟨M, by rw [hD]; push_cast; ring⟩).trans hVmod
    omega
  obtain ⟨q, hq, hq4, hqN⟩ := exists_prime_mod_four_eq_three_dvd hN4
  have hqV : (q : ℤ) ∣ V := by
    have h9 : (q : ℤ) ∣ (N : ℤ) := Int.natCast_dvd_natCast.2 hqN
    rw [hNV] at h9
    exact dvd_neg.1 h9
  have hqD : ¬ (q : ℤ) ∣ D := fun hqD => by
    have h10 : (q : ℤ) ∣ 1 := by
      have h11 := dvd_sub hqV (hqD.trans hVmod)
      rwa [sub_sub_cancel] at h11
    have h12 := Int.eq_one_of_dvd_one (by positivity) h10
    exact hq.one_lt.ne' (by exact_mod_cast h12)
  refine ⟨q, hq, hq4, fun hqM => hqD ?_, exists_dvd_eval_of_dvd_scaleRoots_eval f hq (fun hqk => hqD ?_) hqV⟩
  · exact Int.natCast_dvd_natCast.2 (hqM.trans ⟨4, by rw [hD]; ring⟩)
  · rw [hk] at hqk
    exact Int.Prime.dvd_pow' hq hqk""")
rep("""      Nat.card (𝓞 F ⧸ 𝔭) = q := by
  sorry""","""      Nat.card (𝓞 F ⧸ 𝔭) = q := by
  obtain ⟨θ, hθ⟩ := exists_integral_primitive F
  obtain ⟨E, hE0, hE⟩ := exists_dvd_of_dvd_exponent F hθ
  -- the real embedding of `𝓞 F`, as a map of `ℤ`-algebras
  let φ : 𝓞 F →ₐ[ℤ] ℝ := (F.subtype.comp (algebraMap (𝓞 F) F)).toIntAlgHom
  have hφinj : Function.Injective φ := fun a b h => RingOfIntegers.coe_injective (Subtype.ext h)
  have hne₁ : aeval (algebraMap (𝓞 F) F θ) (derivative (minpoly ℚ (algebraMap (𝓞 F) F θ))) ≠ 0 :=
    (Algebra.IsSeparable.isSeparable _ _).aeval_derivative_ne_zero (minpoly.aeval _ _)
  have hne : aeval θ (derivative (minpoly ℤ θ)) ≠ 0 := by
    intro h0
    apply hne₁
    rw [minpoly.isIntegrallyClosed_eq_field_fractions ℚ F θ.isIntegral, derivative_map, aeval_map_algebraMap,
      aeval_algebraMap_apply, h0, map_zero]
  have hroot : aeval (φ θ) (minpoly ℤ θ) = 0 := by rw [aeval_algHom_apply, minpoly.aeval, map_zero]
  have hroot' : aeval (φ θ) (derivative (minpoly ℤ θ)) ≠ 0 := by
    rw [aeval_algHom_apply]
    exact fun h => hne (hφinj (by rw [h, map_zero]))
  obtain ⟨q, hq, hq4, hqME, t, ht⟩ := exists_prime_three_mod_four_dvd_eval (minpoly ℤ θ)
    (minpoly.monic θ.isIntegral) hroot hroot' (M * E) (mul_ne_zero hM hE0)
  haveI : Fact q.Prime := ⟨hq⟩
  have hqE : ¬ q ∣ RingOfIntegers.exponent θ := fun h => hqME (dvd_mul_of_dvd_right (hE q h) M)
  obtain ⟨ψ⟩ := nonempty_residueHom F hqE ht
  have hsurj : Function.Surjective ψ := ZMod.ringHom_surjective ψ
  have hcard : Nat.card (𝓞 F ⧸ RingHom.ker ψ) = q := by
    rw [Nat.card_congr (RingHom.quotientKerEquivOfSurjective hsurj).toEquiv, Nat.card_zmod]
  refine ⟨q, RingHom.ker ψ, hq, fun h => hqME (dvd_mul_of_dvd_left h E),
    ⟨RingHom.ker_isMaximal_of_surjective ψ hsurj, by rw [hcard]; exact hq4⟩, ?_, hcard⟩
  rw [RingHom.mem_ker, map_natCast, ZMod.natCast_self]""")
rep("""    (hq : (q : 𝓞 F) ∈ 𝔭) : ∃ P : StablePrime F, (q : 𝓞 (fieldI F)) ∈ P.P := by
  sorry""","""    (hq : (q : 𝓞 F) ∈ 𝔭) : ∃ P : StablePrime F, (q : 𝓞 (fieldI F)) ∈ P.P := by
  obtain ⟨V, φ, -, hunit, -⟩ := placeHom_base F h𝔭
  -- the points of `ℂ` with both coordinates in `V`, a subring
  let S : Subring ℂ :=
    { carrier := {z | z.re ∈ V ∧ z.im ∈ V}
      mul_mem' := by
        rintro z w ⟨h1, h2⟩ ⟨h3, h4⟩
        simp only [Set.mem_setOf_eq, Complex.mul_re, Complex.mul_im]
        exact ⟨V.sub_mem (V.mul_mem h1 h3) (V.mul_mem h2 h4), V.add_mem (V.mul_mem h1 h4) (V.mul_mem h2 h3)⟩
      one_mem' := by simp [V.one_mem, V.zero_mem]
      add_mem' := by
        rintro z w ⟨h1, h2⟩ ⟨h3, h4⟩
        exact ⟨by simpa using V.add_mem h1 h3, by simpa using V.add_mem h2 h4⟩
      zero_mem' := by simp [V.zero_mem]
      neg_mem' := by
        rintro z ⟨h1, h2⟩
        exact ⟨by simpa using V.neg_mem h1, by simpa using V.neg_mem h2⟩ }
  -- every unit vector has both coordinates in `V`, so `ℤ[U] ⊆ S`
  have hle : UnitRing.unitRingOver F ≤ S := by
    refine Subring.closure_le.mpr ?_
    rintro z ⟨⟨hre, him⟩, h1⟩
    have hsq : z.re ^ 2 + z.im ^ 2 = 1 := by
      have h := Complex.sq_norm z
      rw [h1, Complex.normSq_apply] at h
      linear_combination -h
    exact hunit z.re z.im hre him hsq
  -- `1/q ∉ ℤ[U]`: its real coordinate would be a unit of `V` whose residue inverts the residue `0` of `q`
  have hnot : (q : ℂ)⁻¹ ∉ UnitRing.unitRingOver F := by
    intro h
    have hre : ((q : ℂ)⁻¹).re ∈ V := (hle h).1
    have hqR : (q : ℝ) ≠ 0 := Nat.cast_ne_zero.2 hq0
    have hre' : ((q : ℂ)⁻¹).re = (q : ℝ)⁻¹ := by
      rw [Complex.inv_re, Complex.normSq_natCast, Complex.natCast_re]
      field_simp
    rw [hre'] at hre
    have e : (⟨(q : ℝ)⁻¹, hre⟩ : V) * (q : V) = 1 := Subtype.ext (by simp [hqR])
    have h0 : φ (q : V) = 0 := by
      rw [map_natCast, ← map_natCast (Ideal.Quotient.mk 𝔭) q, Ideal.Quotient.eq_zero_iff_mem]
      exact hq
    have h1 := congrArg φ e
    rw [map_mul, h0, mul_zero, map_one] at h1
    have h2 : Ideal.Quotient.mk 𝔭 (1 : 𝓞 F) = 0 := by rw [map_one]; exact h1.symm
    exact h𝔭.1.ne_top ((Ideal.eq_top_iff_one _).2 (Ideal.Quotient.eq_zero_iff_mem.1 h2))
  have h := (UpperHalf.inv_natCast_mem_unitRingOver_iff_forall_stablePrime F hq0).not.mp hnot
  push Not at h
  exact h""")
rep("""theorem nonempty_stablePrime : Nonempty (StablePrime F) := by
  sorry""","""theorem nonempty_stablePrime : Nonempty (StablePrime F) := by
  obtain ⟨q, 𝔭, hq, -, h𝔭, hq𝔭, -⟩ := exists_isUsablePrime F 1 one_ne_zero
  obtain ⟨P, -⟩ := exists_stablePrime_natCast_mem h𝔭 hq.ne_zero hq𝔭
  exact ⟨P⟩""")
rep("""theorem localBound_lt_top : localBound F < ⊤ := by
  sorry""","""theorem localBound_lt_top : localBound F < ⊤ := by
  obtain ⟨P⟩ := nonempty_stablePrime F
  haveI : Finite (𝓞 (fieldI F) ⧸ P.P ^ 1) :=
    Ideal.finiteQuotientOfFreeOfNeBot _ (pow_ne_zero 1 P.heightOne.ne_bot)
  letI := Fintype.ofFinite (𝓞 (fieldI F) ⧸ P.P ^ 1)
  calc localBound F ≤ (levelTarget P 1).chromaticNumber := iInf_le (fun P : StablePrime F => (levelTarget P 1).chromaticNumber) P
    _ ≤ Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1) := SimpleGraph.chromaticNumber_le_card
    _ < ⊤ := ENat.coe_lt_top _""")
open(p,'w').write(s)
