import Proofs.HadwigerNelson.PadicPlane.Basic
import Proofs.HadwigerNelson.Rigidity.ClassRatio
import Proofs.HadwigerNelson.Instances.UpperHalfValues

/-!
# The residue tower at `p` is the stable prime of `ℚ(i)` above `p`: the tower ratio from Weil and from certificates (FS131-KPA1, proved by FS131-IQP1)

**Read aloud.** At `p ≡ 3 (mod 4)` the prime `p` stays prime in `ℚ(i)`: there is a stable prime `P` of `ℚ(i)` (the library's
`StablePrime ⊥`) holding `p`, not holding `2`, with `p²` residues (`exists_stablePrime_above`). Its level-`k` residue target
`levelTarget P k` is `UD(ℤ/p^k, 2)`: `(a, b) ↦ a + b·i` embeds `(ℤ/p^k)²` into `𝓞 ⧸ P^k`, injectively and reflecting
adjacency (`exists_levelEmbedding`; the residue ring has characteristic `p^k` because `p^{k−1} ∉ P^k`, by the absolute norm).
So every all-levels bound the library holds at stable primes is a tower ratio at `p` (`towerRatio_of_ratioAtMost`):

* `towerRatio_of_charSum` — **the bound at every level, from level one** (FS-66's L1 with Hoffman's ratio bound): if every
  non-trivial character of `(ℤ/p)²` sums over the circle to real part at least `−κ`, `κ ≥ 2`, then
  `TowerRatio p (κ/(p + 1 + κ))`. Lemma P at the stable prime (`ratioAtMost_of_charSum_levelOne`) carries level one up.
* `charSum_unitCircle_ge_weil`, `towerRatio_weil` — Weil's bound at level one (the declared import
  `StandingFive.kloosterman_bound`): `κ = 2√p`, so `TowerRatio p (2√p/(p + 1 + 2√p))`.
* `towerRatio_of_fibreShareBound` — FS-66's L2 and L6 (`CertLink.card_le_of_fibreShareBound`): a bound `Σφ ≤ U` on FS-66's
  region gives `TowerRatio p (U/p²)`.

`ratioAtMost_of_charSum_levelOne` is stated here, over the library's public vocabulary, as what `Rigidity/ClassRatio`'s
private `charBound_of_charBound_oneT` and `ratioAtMost_of_charBound` give; the visibility edit is drafted in
`plans/FS131-KPA1-padic-plan.md` and is not made on this branch (the coordinator's ruling, inventory item 997).

**Models.** `exists_stablePrime_above` is inhabited at `p = 3` (and every `p ≡ 3 (mod 4)`). The hypothesis of
`towerRatio_of_charSum` holds at `κ = 2√p` (`charSum_unitCircle_ge_weil`) and at `κ = p + 1` (every character sum over
`p + 1` points); that of `towerRatio_of_fibreShareBound` at `p = 11` (`CertLink.fibreShareBound_eleven`), `p = 19`
(`FibreCertSound.sum_le_nineteen`) and `p = 3` (`FibreCertSound.sum_le_of_certOK` at `cert3`).
-/

namespace HadwigerNelson.PadicPlane

open SpectralChain NumberField SimpleGraph

/-! ## Lemma P with Hoffman's ratio bound, at any stable prime -/

/-- At a stable prime not above `2` with `|𝓞 ⧸ P| = Q²`, the norm-one residues at level one are the solutions of
`u^(Q + 1) = 1` (conjugation is the `Q`-th power map of the residue field, `StandingFive.involution_eq_pow`). -/
private theorem normOne_iff_pow {F : Subfield ℝ} [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P)
    {Q : ℕ} (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (u : 𝓞 (fieldI F) ⧸ P.P ^ 1) :
    u ∈ CertLink.normOneSet P 1 ↔ u ^ (Q + 1) = 1 := by
  classical
  haveI hmax : (P.P ^ 1).IsMaximal := by rw [pow_one]; exact P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P ^ 1) := Ideal.Quotient.field (P.P ^ 1)
  haveI := CertLink.finite_quotient_pow P 1
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ 1) := Fintype.ofFinite _
  set σ : (𝓞 (fieldI F) ⧸ P.P ^ 1) →+* (𝓞 (fieldI F) ⧸ P.P ^ 1) :=
    Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) with hσdef
  have hσmk : ∀ x, σ (Ideal.Quotient.mk (P.P ^ 1) x) = Ideal.Quotient.mk (P.P ^ 1) (conjO F x) := fun x =>
    Ideal.quotientMap_mk
  have hσ : ∀ x, σ (σ x) = x := fun x => by
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
    rw [hσmk, hσmk, UpperHalf.conjO_conjO]
  obtain ⟨i, hi2, hci⟩ := UpperHalf.exists_I_integer (F := F)
  have h2k : (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1) ≠ 0 := by
    rw [← map_ofNat (Ideal.Quotient.mk (P.P ^ 1)) 2, Ne, Ideal.Quotient.eq_zero_iff_mem, pow_one]; exact h2
  have hι : Ideal.Quotient.mk (P.P ^ 1) i ^ 2 = -1 := by rw [← map_pow, hi2, map_neg, map_one]
  have hσι : σ (Ideal.Quotient.mk (P.P ^ 1) i) = -Ideal.Quotient.mk (P.P ^ 1) i := by rw [hσmk, hci, map_neg]
  have hne : σ ≠ RingHom.id _ := by
    intro h
    have h1 : σ (Ideal.Quotient.mk (P.P ^ 1) i) = Ideal.Quotient.mk (P.P ^ 1) i := by rw [h]; rfl
    rw [hσι] at h1
    have hz : (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1) * Ideal.Quotient.mk (P.P ^ 1) i = 0 := by linear_combination -h1
    rcases mul_eq_zero.1 hz with h0 | h0
    · exact h2k h0
    · have : (Ideal.Quotient.mk (P.P ^ 1) i) ^ 2 = 0 := by rw [h0]; ring
      rw [hι] at this
      exact one_ne_zero (neg_eq_zero.1 this)
  have hcardk : Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1) = Q ^ 2 := by
    rw [← Nat.card_eq_fintype_card, ← hQ, pow_one]
  have hpow := StandingFive.involution_eq_pow σ hσ hne hcardk
  show u * σ u = 1 ↔ u ^ (Q + 1) = 1
  rw [hpow, ← pow_succ']

/-- At a stable prime not above `2` with `|𝓞 ⧸ P| = Q²`, there are `Q + 1` norm-one residues at level one. -/
private theorem card_normOneSet_one {F : Subfield ℝ} [NumberField F] (P : StablePrime F)
    (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ} (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2)
    (hfin : (CertLink.normOneSet P 1).Finite) : hfin.toFinset.card = Q + 1 := by
  classical
  haveI hmax : (P.P ^ 1).IsMaximal := by rw [pow_one]; exact P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P ^ 1) := Ideal.Quotient.field (P.P ^ 1)
  haveI := CertLink.finite_quotient_pow P 1
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ 1) := Fintype.ofFinite _
  have hcardk : Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1) = Q ^ 2 := by
    rw [← Nat.card_eq_fintype_card, ← hQ, pow_one]
  have hS : hfin.toFinset = Finset.univ.filter fun u : 𝓞 (fieldI F) ⧸ P.P ^ 1 => u ^ (Q + 1) = 1 := by
    ext u
    rw [Set.Finite.mem_toFinset, Finset.mem_filter]
    simp only [Finset.mem_univ, true_and]
    exact normOne_iff_pow P h2 hQ u
  rw [hS]
  exact StandingFive.card_normOne hcardk

/-- **Lemma P with Hoffman's ratio bound**: at a stable prime not above `2` with `|𝓞 ⧸ P| = Q²`, a lower bound `−κ`,
`κ ≥ 2`, on the real parts of the non-trivial character sums over the norm-one residues at level one gives the all-levels
ratio `κ/(Q + 1 + κ)`. (`Rigidity/ClassRatio`'s private `charBound_of_charBound_oneT` at `κ/(Q + 1)` and
`ratioAtMost_of_charBound`; or from the public `CertLink.HenselCount`, `CertLink.NewCharBound` (Lemma P's two theorems,
`Rigidity.henselCount_of_two_notMem`, `newCharBound_of_two_notMem`), the descent `FibreShare.exists_eq_compAddMonoidHom`
and `RatioBound.card_mul_le_of_indep` at each level.) -/
theorem ratioAtMost_of_charSum_levelOne {F : Subfield ℝ} [NumberField F] (P : StablePrime F)
    (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ} (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) {κ : ℝ} (hκ : 2 ≤ κ)
    (h1 : ∀ (hfin : (CertLink.normOneSet P 1).Finite) (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ 1) ℂ), ψ ≠ 1 →
      -κ ≤ (∑ s ∈ hfin.toFinset, ψ s).re) :
    Rigidity.RatioAtMost P (κ / ((Q : ℝ) + 1 + κ)) := by
  classical
  intro m hm s hs
  obtain ⟨n, rfl⟩ : ∃ n, m = n + 1 := ⟨m - 1, by omega⟩
  haveI := CertLink.finite_quotient_pow P (n + 1)
  haveI := CertLink.finite_quotient_pow P 1
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) := Fintype.ofFinite _
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ 1) := Fintype.ofFinite _
  have hfin : (CertLink.normOneSet P (n + 1)).Finite := Set.toFinite _
  have hfin1 : (CertLink.normOneSet P 1).Finite := Set.toFinite _
  have hH := Rigidity.henselCount_of_two_notMem P h2 hQ
  have hL := Rigidity.newCharBound_of_two_notMem P h2 hQ
  set S := hfin.toFinset with hSdef
  set π : (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) →+ (𝓞 (fieldI F) ⧸ P.P ^ 1) :=
    (CertLink.toLevelOne P n).toAddMonoidHom with hπdef
  have hπ : ∀ x, π x = CertLink.toLevelOne P n x := fun _ => rfl
  have hπs : Function.Surjective π := CertLink.toLevelOne_surjective P n
  have hmaps : ∀ x ∈ S, CertLink.toLevelOne P n x ∈ hfin1.toFinset := fun x hx =>
    hfin1.mem_toFinset.2 (CertLink.toLevelOne_mem_normOneSet P n (hfin.mem_toFinset.1 hx))
  -- `Q ≥ 1`: the residue field is not empty
  have hQ0 : 0 < Q := by
    haveI : Finite (𝓞 (fieldI F) ⧸ P.P) := Ideal.finiteQuotientOfFreeOfNeBot _ P.heightOne.ne_bot
    have h := Nat.card_pos (α := 𝓞 (fieldI F) ⧸ P.P)
    rw [hQ] at h
    exact Nat.pos_of_ne_zero fun h0 => by rw [h0] at h; norm_num at h
  have hQn : (0 : ℝ) < (Q : ℝ) ^ n := pow_pos (Nat.cast_pos.2 hQ0) n
  -- `|S_{n+1}| = Q^n (Q + 1)`: Hensel's count over the `Q + 1` norm-one residues of level one
  have hScard : (S.card : ℝ) = (Q : ℝ) ^ n * ((Q : ℝ) + 1) := by
    rw [Finset.card_eq_sum_card_fiberwise hmaps,
      Finset.sum_congr rfl fun t ht => hH n hfin (hfin1.mem_toFinset.1 ht), Finset.sum_const, smul_eq_mul,
      card_normOneSet_one P h2 hQ hfin1]
    push_cast
    ring
  -- every non-trivial character at level `n + 1` has real part at least `−κ Q^n` over `S_{n+1}`
  have hS : ∀ ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) ℂ, ψ ≠ 1 →
      -(κ * (Q : ℝ) ^ n) ≤ (∑ x ∈ S, ψ x).re := by
    intro ψ hψ
    by_cases hK : ∀ e, π e = 0 → ψ e = 1
    · -- descended from level one: `Q^n` times a level-one sum
      obtain ⟨χ, hχ⟩ := FibreShare.exists_eq_compAddMonoidHom π hπs ψ hK
      have hχ1 : χ ≠ 1 := by
        rintro rfl
        apply hψ
        rw [← hχ]
        exact DFunLike.ext _ _ fun x => by simp
      have hsum : ∑ x ∈ S, ψ x = (((Q : ℝ) ^ n : ℝ) : ℂ) * ∑ t ∈ hfin1.toFinset, χ t := by
        rw [← Finset.sum_fiberwise_of_maps_to hmaps, Finset.mul_sum]
        refine Finset.sum_congr rfl fun t ht => ?_
        have hc : ∀ x ∈ S.filter (fun x => CertLink.toLevelOne P n x = t), ψ x = χ t := fun x hx => by
          rw [← hχ, AddChar.compAddMonoidHom_apply, hπ, (Finset.mem_filter.1 hx).2]
        rw [Finset.sum_congr rfl hc, Finset.sum_const, hH n hfin (hfin1.mem_toFinset.1 ht), nsmul_eq_mul]
        push_cast
        ring
      have hb := h1 hfin1 χ hχ1
      rw [hsum, Complex.re_ofReal_mul]
      nlinarith
    · -- new above level one: FS-66's L1, `‖Σ‖ ≤ 2Q^n ≤ κQ^n`
      push Not at hK
      obtain ⟨e, he, hψe⟩ := hK
      have hb := hL n hfin ψ ⟨e, he, hψe⟩
      have hre := Complex.abs_re_le_norm (∑ x ∈ S, ψ x)
      have : 2 * (Q : ℝ) ^ n ≤ κ * (Q : ℝ) ^ n := mul_le_mul_of_nonneg_right hκ hQn.le
      linarith [neg_abs_le (∑ x ∈ S, ψ x).re]
  -- independence: no difference of `s` is of norm one
  have hI : ∀ x ∈ s, ∀ y ∈ s, x - y ∉ S := by
    intro x hx y hy hxy
    rw [hSdef, Set.Finite.mem_toFinset] at hxy
    by_cases hne : x = y
    · rw [hne, sub_self] at hxy
      exact CertLink.zero_notMem_normOneSet P (by omega) hxy
    · exact hs hx hy hne ((SimpleGraph.fromRel_adj _ _ _).2 ⟨hne, Or.inl hxy⟩)
  -- Hoffman's ratio bound at level `n + 1`
  have hkey := RatioBound.card_mul_le_of_indep S (mul_nonneg (by linarith) hQn.le) hS s hI
  rw [hScard] at hkey
  rw [Nat.card_eq_fintype_card, div_mul_eq_mul_div, le_div_iff₀ (by linarith)]
  have e1 : (s.card : ℝ) * ((Q : ℝ) ^ n * ((Q : ℝ) + 1) + κ * (Q : ℝ) ^ n) =
      (Q : ℝ) ^ n * ((s.card : ℝ) * ((Q : ℝ) + 1 + κ)) := by ring
  have e2 : κ * (Q : ℝ) ^ n * (Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) : ℝ) =
      (Q : ℝ) ^ n * (κ * Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ (n + 1))) := by ring
  rw [e1, e2] at hkey
  exact le_of_mul_le_mul_left hkey hQn

/-! ## The stable prime of `ℚ(i)` above `p` -/

variable (p : ℕ) [Fact p.Prime]

/-- `ℚ(i)` has degree at most `2` over `ℚ` (`(a, b) ↦ a + bi` from `ℚ × ℚ` is onto), so its ring of integers has rank at
most `2` over `ℤ`. -/
private theorem finrank_int_le_two : Module.finrank ℤ (𝓞 (fieldI (⊥ : Subfield ℝ))) ≤ 2 := by
  rw [RingOfIntegers.rank]
  have hbot : ∀ r : ℝ, r ∈ (⊥ : Subfield ℝ) → ∃ q : ℚ, (q : ℝ) = r := by
    intro r hr
    rw [Subfield.bot_eq_of_charZero] at hr
    obtain ⟨q, rfl⟩ := hr
    exact ⟨q, rfl⟩
  have hsurj : Function.Surjective (Algebra.linearMap ℚ (⊥ : Subfield ℝ)) := by
    intro x
    obtain ⟨q, hq⟩ := hbot _ x.2
    exact ⟨q, Subtype.ext (by simp [hq])⟩
  have h1 : Module.finrank ℚ (⊥ : Subfield ℝ) ≤ 1 := by
    have := LinearMap.finrank_le_finrank_of_surjective hsurj
    rwa [Module.finrank_self] at this
  have h2 := LinearMap.finrank_le_finrank_of_surjective (toFieldI_surjective (⊥ : Subfield ℝ))
  rw [Module.finrank_prod] at h2
  omega

/-- **The residue rings of the stable prime above `p` have characteristic `p^k`**: an integer vanishing modulo `P^k`
is a multiple of `p^k`. (Write it `p^j u`, `p ∤ u`; `u` is invertible modulo `p^k`, so `p^j ∈ P^k`, and the absolute
norms `p^{2k} ∣ p^{2j}` give `k ≤ j`.) -/
private theorem charP_quot_pow (P : StablePrime (⊥ : Subfield ℝ))
    (hpP : ((p : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P.P)
    (hQ : Nat.card (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P) = p ^ 2) (k : ℕ) :
    CharP (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P ^ k) (p ^ k) := by
  have hpr : p.Prime := Fact.out
  have hd : Module.finrank ℤ (𝓞 (fieldI (⊥ : Subfield ℝ))) = 2 := by
    have h1 := finrank_int_le_two
    have h := Ideal.absNorm_dvd_absNorm_of_le ((Ideal.span_singleton_le_iff_mem P.P).2 hpP)
    rw [Ideal.absNorm_span_natCast, Ideal.absNorm_apply, Submodule.cardQuot_apply, hQ] at h
    have := (Nat.pow_dvd_pow_iff_le_right hpr.one_lt).1 h
    omega
  have hnorm : ∀ j : ℕ, Ideal.absNorm (Ideal.span {((p ^ j : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ)))}) = p ^ (2 * j) := by
    intro j
    rw [Ideal.absNorm_span_natCast, hd, ← pow_mul, mul_comm]
  have hPk : Ideal.absNorm (P.P ^ k) = p ^ (2 * k) := by
    rw [map_pow, Ideal.absNorm_apply, Submodule.cardQuot_apply, hQ, ← pow_mul]
  refine ⟨fun n => ?_⟩
  rw [← map_natCast (Ideal.Quotient.mk (P.P ^ k)), Ideal.Quotient.eq_zero_iff_mem]
  constructor
  · intro hn
    rcases Nat.eq_zero_or_pos n with rfl | hn0
    · exact dvd_zero _
    obtain ⟨j, u, hu, rfl⟩ := Nat.exists_eq_pow_mul_and_not_dvd hn0.ne' p hpr.ne_one
    by_contra hdiv
    have hjk : j < k := by
      by_contra h
      push Not at h
      exact hdiv (Dvd.dvd.mul_right (pow_dvd_pow p h) u)
    have hcop : IsCoprime ((u : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) ((p ^ k : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) := by
      have hc : Nat.Coprime u (p ^ k) :=
        Nat.Coprime.pow_right k (Nat.coprime_comm.1 ((Nat.Prime.coprime_iff_not_dvd hpr).2 hu))
      have h := (Nat.isCoprime_iff_coprime.2 hc).map (Int.castRingHom (𝓞 (fieldI (⊥ : Subfield ℝ))))
      simpa using h
    obtain ⟨α, β, hαβ⟩ := hcop
    have hpk : ((p ^ k : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P.P ^ k := by
      push_cast
      exact Ideal.pow_mem_pow hpP k
    have hpj : ((p ^ j : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P.P ^ k := by
      have e : ((p ^ j : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) =
          α * ((p ^ j * u : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) +
            (β * ((p ^ j : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ)))) * ((p ^ k : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) := by
        push_cast
        push_cast at hαβ
        linear_combination (-((p : 𝓞 (fieldI (⊥ : Subfield ℝ))) ^ j)) * hαβ
      rw [e]
      exact add_mem (Ideal.mul_mem_left _ _ hn) (Ideal.mul_mem_left _ _ hpk)
    have h := Ideal.absNorm_dvd_absNorm_of_le ((Ideal.span_singleton_le_iff_mem _).2 hpj)
    rw [hPk, hnorm] at h
    have := (Nat.pow_dvd_pow_iff_le_right hpr.one_lt).1 h
    omega
  · rintro ⟨t, rfl⟩
    push_cast
    exact Ideal.mul_mem_right _ _ (Ideal.pow_mem_pow hpP k)

/-- **`p` stays prime in `ℚ(i)`** at `p ≡ 3 (mod 4)`: a stable prime of `ℚ(i)` holding `p`, not holding `2`, with `p²`
residues. (A maximal ideal over `(p)`; `|𝓞 ⧸ P|` divides `absNorm (p) = p²` and is not `p`, since `𝔽_p` holds no square root
of `−1`; two distinct conjugate primes over `p` would have norm `p⁴` dividing `p²`.) -/
theorem exists_stablePrime_above (hp : p % 4 = 3) :
    ∃ P : StablePrime (⊥ : Subfield ℝ), ((p : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P.P ∧
      (2 : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∉ P.P ∧ Nat.card (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P) = p ^ 2 := by
  classical
  have hpr : p.Prime := Fact.out
  have hd2 := finrank_int_le_two
  have hN : Ideal.absNorm (Ideal.span {((p : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ)))}) =
      p ^ Module.finrank ℤ (𝓞 (fieldI (⊥ : Subfield ℝ))) := Ideal.absNorm_span_natCast p
  -- every maximal ideal over `p` has `p²` residues, and the rank is `2`
  have key : ∀ Q : Ideal (𝓞 (fieldI (⊥ : Subfield ℝ))), Q.IsMaximal → ((p : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ Q →
      Ideal.absNorm Q = p ^ 2 ∧ Module.finrank ℤ (𝓞 (fieldI (⊥ : Subfield ℝ))) = 2 := by
    intro Q hQ hpQ
    have hdvd : Ideal.absNorm Q ∣ p ^ Module.finrank ℤ (𝓞 (fieldI (⊥ : Subfield ℝ))) :=
      hN ▸ Ideal.absNorm_dvd_absNorm_of_le ((Ideal.span_singleton_le_iff_mem _).2 hpQ)
    obtain ⟨j, hj, hjeq⟩ := (Nat.dvd_prime_pow hpr).1 hdvd
    have hj0 : j ≠ 0 := by
      rintro rfl
      rw [pow_zero, Ideal.absNorm_eq_one_iff] at hjeq
      exact hQ.ne_top hjeq
    have hj1 : j ≠ 1 := by
      rintro rfl
      have hne : Q ≠ ⊥ := by
        rintro rfl
        rw [Ideal.absNorm_bot, pow_one] at hjeq
        exact hpr.ne_zero hjeq.symm
      letI : Field (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ Q) := Ideal.Quotient.field Q
      haveI : Finite (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ Q) := Ideal.finiteQuotientOfFreeOfNeBot _ hne
      letI : Fintype (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ Q) := Fintype.ofFinite _
      have hcard : Fintype.card (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ Q) = p := by
        rw [← Nat.card_eq_fintype_card, ← Submodule.cardQuot_apply, ← Ideal.absNorm_apply, hjeq, pow_one]
      obtain ⟨i, hi2, -⟩ := UpperHalf.exists_I_integer (F := (⊥ : Subfield ℝ))
      have hsq : IsSquare (-1 : 𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ Q) :=
        ⟨Ideal.Quotient.mk Q i, by rw [← map_mul, ← pow_two, hi2, map_neg, map_one]⟩
      rw [FiniteField.isSquare_neg_one_iff, hcard] at hsq
      exact hsq hp
    exact ⟨by rw [hjeq]; congr 1; omega, by omega⟩
  have hspan : Ideal.span {((p : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ)))} ≠ ⊤ := by
    rw [Ne, ← Ideal.absNorm_eq_one_iff, hN]
    have hd1 : 0 < Module.finrank ℤ (𝓞 (fieldI (⊥ : Subfield ℝ))) := by
      rw [RingOfIntegers.rank]; exact Module.finrank_pos
    exact (Nat.one_lt_pow hd1.ne' hpr.one_lt).ne'
  obtain ⟨P, hP, hle⟩ := Ideal.exists_le_maximal _ hspan
  have hpP : ((p : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P := hle (Ideal.mem_span_singleton_self _)
  -- `P` is fixed by conjugation: two conjugate primes over `p` would have norm `p⁴` dividing `p²`
  have hsurj : Function.Surjective (conjO (⊥ : Subfield ℝ)) := fun x => ⟨conjO ⊥ x, UpperHalf.conjO_conjO x⟩
  have hcomap : P.comap (conjO (⊥ : Subfield ℝ)) = P := by
    by_contra hne
    haveI := hP
    haveI hP' : (P.comap (conjO (⊥ : Subfield ℝ))).IsMaximal := Ideal.comap_isMaximal_of_surjective _ hsurj
    have hpP' : ((p : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P.comap (conjO (⊥ : Subfield ℝ)) := by
      rw [Ideal.mem_comap, map_natCast]
      exact hpP
    have hcop : IsCoprime P (P.comap (conjO (⊥ : Subfield ℝ))) := Ideal.isCoprime_of_isMaximal (Ne.symm hne)
    have hle2 : Ideal.span {((p : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ)))} ≤ P * P.comap (conjO (⊥ : Subfield ℝ)) := by
      rw [Ideal.mul_eq_inf_of_isCoprime hcop]
      exact le_inf hle ((Ideal.span_singleton_le_iff_mem _).2 hpP')
    have h := Ideal.absNorm_dvd_absNorm_of_le hle2
    rw [map_mul, (key P hP hpP).1, (key _ hP' hpP').1, hN, (key P hP hpP).2, ← pow_add] at h
    have := (Nat.pow_dvd_pow_iff_le_right hpr.one_lt).1 h
    omega
  refine ⟨⟨P, hP, hcomap⟩, hpP, fun h2 => ?_, ?_⟩
  · -- `p` is odd, so `2` and `p` generate the unit ideal
    obtain ⟨t, ht⟩ : ∃ t, p = 2 * t + 1 := ⟨p / 2, by omega⟩
    have e : (1 : 𝓞 (fieldI (⊥ : Subfield ℝ))) =
        ((p : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) - (t : 𝓞 (fieldI (⊥ : Subfield ℝ))) * 2 := by
      rw [ht]; push_cast; ring
    exact hP.ne_top ((Ideal.eq_top_iff_one _).2 (e ▸ P.sub_mem hpP (P.mul_mem_left _ h2)))
  · show Nat.card (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P) = p ^ 2
    rw [← Submodule.cardQuot_apply, ← Ideal.absNorm_apply]
    exact (key P hP hpP).1

/-- **`UD(ℤ/p^k, 2)` inside the level-`k` target**: `(a, b) ↦ a + b·i` is an injective additive map
`(ℤ/p^k)² → 𝓞 ⧸ P^k` that reflects adjacency into `levelTarget P k`. -/
theorem exists_levelEmbedding (P : StablePrime (⊥ : Subfield ℝ))
    (hpP : ((p : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P.P) (h2 : (2 : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∉ P.P)
    (hQ : Nat.card (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P) = p ^ 2) (k : ℕ) :
    ∃ f : ZMod (p ^ k) × ZMod (p ^ k) →+ 𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P ^ k, Function.Injective f ∧
      ∀ u v, (levelTarget P k).Adj (f u) (f v) → (unitQuadrance (ZMod (p ^ k))).Adj u v := by
  classical
  haveI := charP_quot_pow p P hpP hQ k
  set θ : ZMod (p ^ k) →+* 𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P ^ k := ZMod.castHom (dvd_refl _) _ with hθdef
  have hθ : Function.Injective θ := ZMod.castHom_injective _
  obtain ⟨i, hi2, hci⟩ := UpperHalf.exists_I_integer (F := (⊥ : Subfield ℝ))
  set σ : (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P ^ k) →+* (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P ^ k) :=
    Ideal.quotientMap (P.P ^ k) (conjO ⊥) (P.le_comap k) with hσdef
  set ι : 𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P ^ k := Ideal.Quotient.mk (P.P ^ k) i with hιdef
  have hι : ι ^ 2 = -1 := by rw [hιdef, ← map_pow, hi2, map_neg, map_one]
  have hσι : σ ι = -ι := by rw [hσdef, hιdef, Ideal.quotientMap_mk, hci, map_neg]
  have hσθ : ∀ a, σ (θ a) = θ a := by
    intro a
    have e : θ a = ((a.val : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P ^ k) := by
      rw [← map_natCast θ, ZMod.natCast_zmod_val]
    rw [e, map_natCast]
  let f : ZMod (p ^ k) × ZMod (p ^ k) →+ 𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P ^ k :=
    { toFun := fun v => θ v.1 + θ v.2 * ι
      map_zero' := by simp
      map_add' := fun v w => by simp only [Prod.fst_add, Prod.snd_add, map_add]; ring }
  have hf : ∀ v, f v = θ v.1 + θ v.2 * ι := fun _ => rfl
  have hnorm : ∀ v, f v * σ (f v) = θ (v.1 ^ 2 + v.2 ^ 2) := by
    intro v
    rw [hf, map_add, map_mul, hσθ, hσθ, hσι, map_add, map_pow, map_pow]
    linear_combination (-(θ v.2) ^ 2) * hι
  -- `2` is invertible modulo `p^k`
  have hp2 : p ≠ 2 := by
    rintro rfl
    exact h2 (by exact_mod_cast hpP)
  obtain ⟨t, ht⟩ : ∃ t, p ^ k + 1 = 2 * t := by
    obtain ⟨r, hr⟩ : Odd (p ^ k) := ((Fact.out : p.Prime).odd_of_ne_two hp2).pow
    exact ⟨r + 1, by omega⟩
  have h2inv : (t : ZMod (p ^ k)) * 2 = 1 := by
    have e : ((2 * t : ℕ) : ZMod (p ^ k)) = 1 := by
      rw [← ht, Nat.cast_add, ZMod.natCast_self, zero_add, Nat.cast_one]
    push_cast at e
    linear_combination e
  have hhalf : ∀ a : ZMod (p ^ k), θ (2 * a) = 0 → a = 0 := by
    intro a ha
    have h2a : 2 * a = 0 := hθ (ha.trans (map_zero θ).symm)
    calc a = (t : ZMod (p ^ k)) * 2 * a := by rw [h2inv, one_mul]
      _ = 0 := by rw [mul_assoc, h2a, mul_zero]
  refine ⟨f, fun v w hvw => ?_, fun u v hadj => ?_⟩
  · have h1 : θ (v - w).1 + θ (v - w).2 * ι = 0 := by rw [← hf, map_sub, hvw, sub_self]
    have h2 : θ (v - w).1 - θ (v - w).2 * ι = 0 := by
      have := congrArg σ h1
      rw [map_add, map_mul, hσθ, hσθ, hσι, map_zero] at this
      linear_combination this
    have ha : (v - w).1 = 0 := hhalf _ (by rw [map_mul, map_ofNat]; linear_combination h1 + h2)
    have hb : (v - w).2 = 0 := hhalf _ (by
      rw [map_mul, map_ofNat]
      linear_combination (-ι) * h1 - (-ι) * h2 + (2 * θ (v - w).2) * hι)
    exact sub_eq_zero.1 (Prod.ext ha hb)
  · obtain ⟨hne, hrel⟩ := (SimpleGraph.fromRel_adj _ _ _).1 hadj
    have key : ∀ w : ZMod (p ^ k) × ZMod (p ^ k), f w * σ (f w) = 1 → w.1 ^ 2 + w.2 ^ 2 = 1 := fun w hw =>
      hθ (by rw [← hnorm, hw, map_one])
    refine unitQuadrance_adj.2 ⟨fun h => hne (by rw [h]), ?_⟩
    rcases hrel with h | h
    · have := key (u - v) (by rw [map_sub]; exact h)
      simpa using this
    · have := key (v - u) (by rw [map_sub]; exact h)
      simp only [Prod.fst_sub, Prod.snd_sub] at this
      linear_combination this

/-- **An all-levels ratio at the stable prime above `p` is a tower ratio at `p`.** -/
theorem towerRatio_of_ratioAtMost (P : StablePrime (⊥ : Subfield ℝ))
    (hpP : ((p : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P.P) (h2 : (2 : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∉ P.P)
    (hQ : Nat.card (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P) = p ^ 2) {c : ℝ} (h : Rigidity.RatioAtMost P c) :
    TowerRatio p c := by
  classical
  intro k hk s hs
  obtain ⟨f, hf, hadj⟩ := exists_levelEmbedding p P hpP h2 hQ k
  have hind : (levelTarget P k).IsIndepSet ((s.image f : Finset _) : Set _) := by
    intro x hx y hy hxy hxy'
    rw [Finset.coe_image] at hx hy
    obtain ⟨u, hu, rfl⟩ := hx
    obtain ⟨v, hv, rfl⟩ := hy
    exact hs hu hv (fun huv => hxy (by rw [huv])) (hadj u v hxy')
  have hb := h k hk _ hind
  rw [Finset.card_image_of_injective _ hf] at hb
  have hcard : Nat.card (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P ^ k) = p ^ (2 * k) := by
    rw [← Submodule.cardQuot_apply, ← Ideal.absNorm_apply, map_pow, Ideal.absNorm_apply, Submodule.cardQuot_apply,
      hQ, ← pow_mul]
  rw [hcard] at hb
  push_cast at hb
  exact hb

/-! ## The tower ratio from level one -/

/-- **Level one in coordinates** (K3, `CertLink.exists_addEquiv_zmod`): a lower bound on the character sums over the circle
of `(ℤ/p)²` is the same bound over the norm-one residues of the stable prime above `p`. -/
theorem charSum_levelOne_of_unitCircle (P : StablePrime (⊥ : Subfield ℝ))
    (h2 : (2 : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∉ P.P)
    (hQ : Nat.card (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P) = p ^ 2) {κ : ℝ}
    (h : ∀ ψ : AddChar (ZMod p × ZMod p) ℂ, ψ ≠ 1 → -κ ≤ (∑ s ∈ FibreCertSound.unitCircle p, ψ s).re)
    (hfin : (CertLink.normOneSet P 1).Finite) (ψ : AddChar (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P ^ 1) ℂ) (hψ : ψ ≠ 1) :
    -κ ≤ (∑ s ∈ hfin.toFinset, ψ s).re := by
  classical
  obtain ⟨e, he⟩ := CertLink.exists_addEquiv_zmod P h2 (Fact.out : p.Prime) hQ
  set ψ' : AddChar (ZMod p × ZMod p) ℂ := ψ.compAddMonoidHom e.symm.toAddMonoidHom with hψ'def
  have hψ'e : ∀ x, ψ' (e x) = ψ x := fun x => by
    rw [hψ'def, AddChar.compAddMonoidHom_apply]
    simp
  have hψ' : ψ' ≠ 1 := by
    intro h
    apply hψ
    exact DFunLike.ext _ _ fun x => by rw [← hψ'e, h, AddChar.one_apply, AddChar.one_apply]
  have hsum : ∑ s ∈ hfin.toFinset, ψ s = ∑ w ∈ FibreCertSound.unitCircle p, ψ' w := by
    refine Finset.sum_nbij' (fun t => e t) (fun w => e.symm w) ?_ ?_ ?_ ?_ ?_
    · intro t ht
      rw [Set.Finite.mem_toFinset] at ht
      rw [FibreCertSound.unitCircle, Finset.mem_filter]
      exact ⟨Finset.mem_univ _, (he t).1 ht⟩
    · intro w hw
      rw [FibreCertSound.unitCircle, Finset.mem_filter] at hw
      rw [Set.Finite.mem_toFinset, he, AddEquiv.apply_symm_apply]
      exact hw.2
    · intro t _
      exact e.symm_apply_apply t
    · intro w _
      exact e.apply_symm_apply w
    · intro t _
      exact (hψ'e t).symm
  rw [hsum]
  exact h ψ' hψ'

/-- **The bound at every level, from level one**: if every non-trivial character of `(ℤ/p)²` sums over the circle
`a² + b² = 1` to real part at least `−κ`, with `κ ≥ 2`, then every level of the tower holds at most `κ/(p + 1 + κ)`. With
`κ = −λ_min(UD(𝔽_p, 2))` this is Hoffman's ratio bound of the finite plane, carried to every level. -/
theorem towerRatio_of_charSum (hp : p % 4 = 3) {κ : ℝ} (hκ : 2 ≤ κ)
    (h : ∀ ψ : AddChar (ZMod p × ZMod p) ℂ, ψ ≠ 1 → -κ ≤ (∑ s ∈ FibreCertSound.unitCircle p, ψ s).re) :
    TowerRatio p (κ / ((p : ℝ) + 1 + κ)) := by
  obtain ⟨P, hpP, h2, hQ⟩ := exists_stablePrime_above p hp
  exact towerRatio_of_ratioAtMost p P hpP h2 hQ
    (ratioAtMost_of_charSum_levelOne P h2 hQ hκ (charSum_levelOne_of_unitCircle p P h2 hQ h))

/-- **Weil's bound on the circle of `(ℤ/p)²`** (the declared import `StandingFive.kloosterman_bound`, through
`StandingFive.normOne_charSum_ge` on the residue field of the stable prime above `p`, carried by K3): every non-trivial
character sums over the `p + 1` points of the circle to real part at least `−2√p`. -/
theorem charSum_unitCircle_ge_weil (hp : p % 4 = 3) (ψ : AddChar (ZMod p × ZMod p) ℂ) (hψ : ψ ≠ 1) :
    -(2 * Real.sqrt p) ≤ (∑ s ∈ FibreCertSound.unitCircle p, ψ s).re := by
  classical
  obtain ⟨P, hpP, h2, hQ⟩ := exists_stablePrime_above p hp
  obtain ⟨e, he⟩ := CertLink.exists_addEquiv_zmod P h2 (Fact.out : p.Prime) hQ
  haveI hmax : (P.P ^ 1).IsMaximal := by rw [pow_one]; exact P.isMaximal
  letI : Field (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P ^ 1) := Ideal.Quotient.field (P.P ^ 1)
  haveI := CertLink.finite_quotient_pow P 1
  letI : Fintype (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P ^ 1) := Fintype.ofFinite _
  have hcardk : Fintype.card (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P ^ 1) = p ^ 2 := by
    rw [← Nat.card_eq_fintype_card, pow_one, hQ]
  set χ : AddChar (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P ^ 1) ℂ := ψ.compAddMonoidHom e.toAddMonoidHom with hχdef
  have hχe : ∀ x, χ x = ψ (e x) := fun x => by rw [hχdef, AddChar.compAddMonoidHom_apply]; rfl
  have hχ : χ ≠ 1 := by
    intro h
    apply hψ
    refine DFunLike.ext _ _ fun w => ?_
    rw [← e.apply_symm_apply w, ← hχe, h, AddChar.one_apply, AddChar.one_apply]
  have hK : ∀ (F' : Type) [Field F'] [Fintype F'] [DecidableEq F'], Fintype.card F' = p →
      StandingFive.KloostermanBound F' := fun F' _ _ _ hF' =>
    StandingFive.kloostermanBound_of_ringChar_ne_two F'
      (StandingFive.ringChar_ne_two_of_card_mod_four (by rw [hF']; exact hp))
  have hW := StandingFive.normOne_charSum_ge hp hcardk hK χ hχ
  have hsum : ∑ u ∈ Finset.univ.filter (fun u : 𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P ^ 1 => u ^ (p + 1) = 1), χ u =
      ∑ w ∈ FibreCertSound.unitCircle p, ψ w := by
    refine Finset.sum_nbij' (fun t => e t) (fun w => e.symm w) ?_ ?_ ?_ ?_ ?_
    · intro t ht
      rw [Finset.mem_filter] at ht
      rw [FibreCertSound.unitCircle, Finset.mem_filter]
      exact ⟨Finset.mem_univ _, (he t).1 ((normOne_iff_pow P h2 hQ t).2 ht.2)⟩
    · intro w hw
      rw [FibreCertSound.unitCircle, Finset.mem_filter] at hw
      rw [Finset.mem_filter]
      refine ⟨Finset.mem_univ _, (normOne_iff_pow P h2 hQ _).1 ?_⟩
      rw [he, AddEquiv.apply_symm_apply]
      exact hw.2
    · intro t _
      exact e.symm_apply_apply t
    · intro w _
      exact e.apply_symm_apply w
    · intro t _
      exact hχe t
  rw [← hsum]
  exact hW

/-- **T7's tower ratio**: at `p ≡ 3 (mod 4)` every independent set of every level `UD(ℤ/p^k, 2)` holds at most the fraction
`2√p/(p + 1 + 2√p)` of its points. -/
theorem towerRatio_weil (hp : p % 4 = 3) :
    TowerRatio p (2 * Real.sqrt p / ((p : ℝ) + 1 + 2 * Real.sqrt p)) :=
  towerRatio_of_charSum p hp (by
    have h1 : (1 : ℝ) ≤ Real.sqrt p := by
      rw [show (1 : ℝ) = Real.sqrt 1 from Real.sqrt_one.symm]
      exact Real.sqrt_le_sqrt (by exact_mod_cast (Fact.out : p.Prime).one_lt.le)
    linarith) (charSum_unitCircle_ge_weil p hp)

/-! ## The tower ratio from a certificate -/

/-- **FS-66's L2 and L6 at `ℚ_p`**: a bound `Σφ ≤ U` on FS-66's region `{φ : (ℤ/p)² → [0, 1], q(φ) ≥ 0}` gives the tower
ratio `U/p²`. -/
theorem towerRatio_of_fibreShareBound (hp : p % 4 = 3) {U : ℝ} (hU : CertLink.FibreShareBound p U) :
    TowerRatio p (U / (p : ℝ) ^ 2) := by
  obtain ⟨P, hpP, h2, hQ⟩ := exists_stablePrime_above p hp
  exact towerRatio_of_ratioAtMost p P hpP h2 hQ fun m hm s hs =>
    CertLink.card_le_of_fibreShareBound P h2 (Fact.out : p.Prime) hQ (Rigidity.henselCount_of_two_notMem P h2 hQ)
      (Rigidity.newCharBound_of_two_notMem P h2 hQ) hU m hm s hs

end HadwigerNelson.PadicPlane
