import Proofs.HadwigerNelson.Arith.WeilKloosterman
import Proofs.HadwigerNelson.Rigidity.ChainAtTA

/-!
# CLS: a local bound of at least five gives T-C(A) at `S = ∅`; the uniform tail (FS-131, job FS131-KR1; module M13; skeleton)

**Read aloud, against the informal claim.** `RatioAtMost P c` says that at the stable prime `P` every independent set of
every level's residue target `levelTarget P m` (`m ≥ 1`) holds at most the fraction `c` of `𝓞 ⧸ P^m`; T-C(A) at `S = ∅`,
the library's `SpectralChain.TCA`, is "every stable prime has some `c < 1/4`" (`tca_iff`, by `Iff.rfl`). Then:

* `ratioAtMost_of_five_le_chromaticNumber` — **a stable prime whose level-one target needs five colours has an all-levels
  ratio below `1/4`** (FS100-CLS, -DLP, -G27; X26B-L1; EN1-UQ4): the residue sizes the hypothesis leaves are odd inert
  `q ∉ {3, 7}` and dyadic inert `Q ≥ 64` (a stable prime ramified in `F(i)/F` is dyadic and its level-one target is
  two-colourable, `colorable_two_levelTarget_one_of_isRamified`); Lemma P carries level one to every level; level one by Weil
  for `q ≥ 37` (the declared import `kloosterman_bound`), exact spectra at 23, 27, 31 and 64, `Floor128` at 128, the
  fourth-moment count EN1-UQ4 for `Q ≥ 256`, and FS-66's fibre-share bound with its certificates at 11 and 19.
* `tca_of_five_le_localBound` — **CLS**, the headline's `hCLS`: composed here from the per-prime statement.
* `exists_uniform_tail` — **one constant for all but finitely many stable primes**: every stable prime of absolute norm
  above some `B` has all-levels ratio at most one `c < 1/4` (Weil and Lemma P; R88-J28V-3's tail). And `tca_uniform`: T-C(A)
  with **one** constant for every stable prime — the form the count reads (module M12: the product of the stable factors has
  ratio `sup_P c_P`, which `TCA F` alone does not bound below `1/4`). Placed here, upstream of both M12 and M13, by the
  coordinator's ruling of 2026-10-14 on FS131-KR1's notice.

**Models.** `5 ≤ localBound F` holds at `ℚ(√47)` (module M15, `plans/FS131-KR1-chain-map.md` § 2.7) and at the standing
field (`StandingFive.le_localBound`, at seven); it fails at `ℚ`, whose prime `(1 + i)` is ramified. `RatioAtMost P 1` holds
at every `P` (an independent set is a subset), and `RatioAtMost P c` fails for `c < 1/2` at a ramified stable prime.
-/

namespace HadwigerNelson.Rigidity

open SpectralChain NumberField

noncomputable section

variable {F : Subfield ℝ}

/-- **The all-levels ratio at a stable prime is at most `c`.** -/
def RatioAtMost (P : StablePrime F) (c : ℝ) : Prop :=
  ∀ m : ℕ, 1 ≤ m → ∀ s : Finset (𝓞 (fieldI F) ⧸ P.P ^ m),
    (levelTarget P m).IsIndepSet (s : Set _) → (s.card : ℝ) ≤ c * Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m)

variable (F) in
/-- T-C(A) at `S = ∅`, read through `RatioAtMost`. -/
theorem tca_iff : TCA F ↔ ∀ P : StablePrime F, ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := Iff.rfl

-- FS131-ICM1: the road, as private helpers. `levelSet P m` is the connection set of `levelTarget P m`; `CharBound P m κ`
-- says every non-trivial additive character of `𝓞 ⧸ P^m` sums to real part at least `−κ·|S_m|` over it. The ratio bound
-- (`RatioBound.card_mul_le_of_indep`) turns a bound at every level into `RatioAtMost P (κ/(1 + κ))`; Weil gives level one
-- at an odd stable prime (`κ = 2√Q/(Q + 1)`, `|𝓞 ⧸ P| = Q²`); Lemma P carries any level-one bound `κ ≥ 2/(Q + 1)` to every
-- level (`charBound_of_charBound_one`, a named leaf).

-- FS131-ICM1: a larger constant bounds the ratio as well.
private theorem ratioAtMost_mono {P : StablePrime F} {c c' : ℝ} (h : RatioAtMost P c) (hc : c ≤ c') :
    RatioAtMost P c' := fun m hm s hs =>
  (h m hm s hs).trans (mul_le_mul_of_nonneg_right hc (Nat.cast_nonneg _))

-- FS131-ICM1: the residue rings of a stable prime are finite.
private theorem finite_quot_pow [NumberField F] (P : StablePrime F) (m : ℕ) : Finite (𝓞 (fieldI F) ⧸ P.P ^ m) :=
  Ideal.finiteQuotientOfFreeOfNeBot _ (pow_ne_zero m P.heightOne.ne_bot)

-- FS131-ICM1: a stable prime is determined by its ideal.
private theorem stablePrime_ext {P P' : StablePrime F} (h : P.P = P'.P) : P = P' := by
  cases P
  cases P'
  cases h
  rfl

-- FS131-ICM1: finitely many stable primes have norm at most `B`.
private theorem finite_stablePrime_absNorm_le [NumberField F] (B : ℕ) :
    {P : StablePrime F | Ideal.absNorm P.P ≤ B}.Finite := by
  refine Set.Finite.of_finite_image ((Ideal.finite_setOf_absNorm_le (S := 𝓞 (fieldI F)) B).subset ?_)
    fun P _ P' _ h => stablePrime_ext h
  rintro _ ⟨P, hP, rfl⟩
  exact hP

/-- The connection set of the level-`m` target. -/
private def levelSet (P : StablePrime F) (m : ℕ) : Set (𝓞 (fieldI F) ⧸ P.P ^ m) :=
  {x | x * Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) x = 1}

/-- **The character bound at level `m`**: every non-trivial additive character sums to real part at least `−κ·|S_m|`. -/
private def CharBound (P : StablePrime F) (m : ℕ) (κ : ℝ) : Prop :=
  ∀ (hfin : (levelSet P m).Finite) (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ m) ℂ), ψ ≠ 1 →
    -(κ * hfin.toFinset.card) ≤ (∑ s ∈ hfin.toFinset, ψ s).re

-- FS131-ICM1: the ratio bound at every level (Hoffman, `RatioBound.card_mul_le_of_indep`).
private theorem ratioAtMost_of_charBound [NumberField F] (P : StablePrime F) {κ : ℝ} (hκ : 0 ≤ κ)
    (h : ∀ m : ℕ, 1 ≤ m → CharBound P m κ) : RatioAtMost P (κ / (1 + κ)) := by
  classical
  intro m hm s hs
  haveI := finite_quot_pow P m
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ m) := Fintype.ofFinite _
  have hfin : (levelSet P m).Finite := Set.toFinite _
  set S := hfin.toFinset with hSdef
  -- the residue ring at `m ≥ 1` is not zero
  have hne : (1 : 𝓞 (fieldI F) ⧸ P.P ^ m) ≠ 0 := by
    intro h1
    have hmem : (1 : 𝓞 (fieldI F)) ∈ P.P ^ m := by
      rw [← Ideal.Quotient.eq_zero_iff_mem, map_one]
      exact h1
    exact P.isMaximal.ne_top ((Ideal.eq_top_iff_one _).2 (Ideal.pow_le_self (by omega) hmem))
  have hone : (1 : 𝓞 (fieldI F) ⧸ P.P ^ m) ∈ S := by
    rw [hSdef, Set.Finite.mem_toFinset]
    show 1 * Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) 1 = 1
    rw [map_one, one_mul]
  have hSpos : (0 : ℝ) < S.card := by exact_mod_cast Finset.card_pos.2 ⟨1, hone⟩
  have hI : ∀ x ∈ s, ∀ y ∈ s, x - y ∉ S := by
    intro x hx y hy hxy
    rw [hSdef, Set.Finite.mem_toFinset] at hxy
    have hxy' : (x - y) * Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) (x - y) = 1 := hxy
    have hneq : x ≠ y := by
      rintro rfl
      rw [sub_self, zero_mul] at hxy'
      exact hne hxy'.symm
    exact hs hx hy hneq ((SimpleGraph.fromRel_adj _ _ _).2 ⟨hneq, Or.inl hxy'⟩)
  have hkey := RatioBound.card_mul_le_of_indep S (mul_nonneg hκ hSpos.le) (h m hm hfin) s hI
  rw [Nat.card_eq_fintype_card]
  have h1κ : 0 < 1 + κ := by linarith
  rw [div_mul_eq_mul_div, le_div_iff₀ h1κ]
  have e : (s.card : ℝ) * (S.card + κ * S.card) = (s.card * (1 + κ)) * S.card := by ring
  have e2 : κ * S.card * (Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ m) : ℝ) =
      (κ * Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ m)) * S.card := by ring
  rw [e, e2] at hkey
  exact le_of_mul_le_mul_right hkey hSpos

-- FS131-ICM1: `i` is an integer of `F(i)`, with `i² = −1` and `ī = −i` (as `UpperHalf`'s private `exists_I_integer`).
private theorem exists_I_int : ∃ i : 𝓞 (fieldI F), i ^ 2 = -1 ∧ conjO F i = -i := by
  let iL : fieldI F := ⟨Complex.I, by simp [zero_mem], by simp [one_mem]⟩
  have hiL : iL ^ 2 = -1 := Subtype.ext Complex.I_sq
  have hint : IsIntegral ℤ iL := IsIntegral.of_pow (n := 2) (by norm_num) (by rw [hiL]; exact isIntegral_one.neg)
  refine ⟨⟨iL, hint⟩, RingOfIntegers.coe_injective ?_, RingOfIntegers.coe_injective ?_⟩
  · rw [map_pow, map_neg, map_one]; exact hiL
  · rw [map_neg]; exact Subtype.ext Complex.conj_I

-- FS131-ICM1: at an odd stable prime the residue field has `Q²` elements, `Q ≡ 3 (mod 4)`
-- (`StandingFive.card_fixed_of_involution` at the residue of `i`).
private theorem exists_card_sq [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) :
    ∃ Q : ℕ, Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2 ∧ Q % 4 = 3 := by
  haveI := P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P) := Ideal.Quotient.field P.P
  haveI : Finite (𝓞 (fieldI F) ⧸ P.P) := Ideal.finiteQuotientOfFreeOfNeBot _ P.heightOne.ne_bot
  let σ : (𝓞 (fieldI F) ⧸ P.P) →+* (𝓞 (fieldI F) ⧸ P.P) := Ideal.quotientMap P.P (conjO F) P.comap_conj.ge
  have hσmk : ∀ x, σ (Ideal.Quotient.mk P.P x) = Ideal.Quotient.mk P.P (conjO F x) := fun x => Ideal.quotientMap_mk
  have hσ : ∀ x, σ (σ x) = x := fun x => by
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
    rw [hσmk, hσmk, UpperHalf.conjO_conjO]
  obtain ⟨i, hi2, hci⟩ := exists_I_int (F := F)
  have h2k : (2 : 𝓞 (fieldI F) ⧸ P.P) ≠ 0 := by
    rw [← map_ofNat (Ideal.Quotient.mk P.P) 2, Ne, Ideal.Quotient.eq_zero_iff_mem]; exact h2
  obtain ⟨hcard, hmod⟩ := StandingFive.card_fixed_of_involution σ hσ (ι := Ideal.Quotient.mk P.P i)
    (by rw [← map_pow, hi2, map_neg, map_one]) (by rw [hσmk, hci, map_neg]) h2k
  exact ⟨_, hcard, hmod⟩

-- FS131-ICM1: no field has `15²` elements (a finite field has a prime-power size).
private theorem card_ne_fifteen_sq [NumberField F] (P : StablePrime F) : Nat.card (𝓞 (fieldI F) ⧸ P.P) ≠ 15 ^ 2 := by
  haveI := P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P) := Ideal.Quotient.field P.P
  haveI : Finite (𝓞 (fieldI F) ⧸ P.P) := Ideal.finiteQuotientOfFreeOfNeBot _ P.heightOne.ne_bot
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P) := Fintype.ofFinite _
  obtain ⟨p, hchar⟩ := CharP.exists (𝓞 (fieldI F) ⧸ P.P)
  obtain ⟨n, hp, hcard⟩ := FiniteField.card (𝓞 (fieldI F) ⧸ P.P) p
  rw [Nat.card_eq_fintype_card, hcard]
  intro h
  have h3 : 3 ∣ p ^ (n : ℕ) := by rw [h]; norm_num
  have hp3 : p = 3 := ((Nat.prime_dvd_prime_iff_eq Nat.prime_three hp).1 (Nat.prime_three.dvd_of_dvd_pow h3)).symm
  have h5 : 5 ∣ p ^ (n : ℕ) := by rw [h]; norm_num
  rw [hp3] at h5
  exact absurd (Nat.prime_five.dvd_of_dvd_pow h5) (by norm_num)

-- FS131-ICM1: the named leaves.

-- FS131-ICM1: the reduction from level `n + 2` to level `n + 1`.
private def red (P : StablePrime F) (n : ℕ) : (𝓞 (fieldI F) ⧸ P.P ^ (n + 2)) →+* (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) :=
  Ideal.Quotient.factor (Ideal.pow_le_pow_right (Nat.le_succ (n + 1)))

private theorem red_mk (P : StablePrime F) (n : ℕ) (a : 𝓞 (fieldI F)) :
    red P n (Ideal.Quotient.mk _ a) = Ideal.Quotient.mk _ a := Ideal.Quotient.factor_mk _ a

-- FS131-ICM1: the reduction carries the norm-one set into the norm-one set.
private theorem red_mem_levelSet (P : StablePrime F) (n : ℕ) {x : 𝓞 (fieldI F) ⧸ P.P ^ (n + 2)}
    (hx : x ∈ levelSet P (n + 2)) : red P n x ∈ levelSet P (n + 1) := by
  obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective x
  have hx' : Ideal.Quotient.mk _ a * Ideal.quotientMap (P.P ^ (n + 2)) (conjO F) (P.le_comap (n + 2))
      (Ideal.Quotient.mk _ a) = 1 := hx
  show red P n (Ideal.Quotient.mk _ a) * Ideal.quotientMap (P.P ^ (n + 1)) (conjO F) (P.le_comap (n + 1))
    (red P n (Ideal.Quotient.mk _ a)) = 1
  rw [Ideal.quotientMap_mk] at hx'
  rw [red_mk, Ideal.quotientMap_mk, ← map_mul, ← red_mk, map_mul, hx', map_one]

-- FS131-ICM1: a character trivial on the kernel of the reduction descends to level `n + 1`.
private theorem exists_addChar_descent (P : StablePrime F) (n : ℕ) (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ (n + 2)) ℂ)
    (hψ : ∀ e, red P n e = 0 → ψ e = 1) :
    ∃ ψ' : AddChar (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) ℂ, ∀ x, ψ x = ψ' (red P n x) := by
  have hsurj : Function.Surjective (red P n) := Ideal.Quotient.factor_surjective _
  have hs : ∀ y, red P n (Function.surjInv hsurj y) = y := Function.surjInv_eq hsurj
  have hker : ∀ x x', red P n x = red P n x' → ψ x = ψ x' := by
    intro x x' h
    have h0 : red P n (x - x') = 0 := by rw [map_sub, h, sub_self]
    calc ψ x = ψ (x - x' + x') := by rw [sub_add_cancel]
      _ = ψ (x - x') * ψ x' := AddChar.map_add_eq_mul ψ _ _
      _ = ψ x' := by rw [hψ _ h0, one_mul]
  refine ⟨{ toFun := fun y => ψ (Function.surjInv hsurj y), map_zero_eq_one' := ?_, map_add_eq_mul' := ?_ },
    fun x => hker _ _ (hs _).symm⟩
  · show ψ (Function.surjInv hsurj 0) = 1
    rw [hker _ 0 (by rw [hs, map_zero]), AddChar.map_zero_eq_one]
  · intro a b
    show ψ (Function.surjInv hsurj (a + b)) = ψ (Function.surjInv hsurj a) * ψ (Function.surjInv hsurj b)
    rw [hker _ (Function.surjInv hsurj a + Function.surjInv hsurj b) (by rw [hs, map_add, hs, hs]),
      AddChar.map_add_eq_mul]

open Classical in
/-- **Hensel at level `n + 2`** (Lemma P's fibre count; KC13 § 5.2 K4): at an odd stable prime with `|𝓞 ⧸ P| = Q²`, every
norm-one residue at level `n + 1` has exactly `Q` norm-one lifts at level `n + 2` — the lifts `x + e`, `e ∈ P^{n+1}/P^{n+2}`,
of one lift `x` are those with `Tr(σ(x)e) = N(x) − 1`, an affine `k₀`-line. -/
private theorem card_fibre [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (n : ℕ) (hfin : (levelSet P (n + 2)).Finite)
    {t : 𝓞 (fieldI F) ⧸ P.P ^ (n + 1)} (ht : t ∈ levelSet P (n + 1)) :
    (hfin.toFinset.filter fun x => red P n x = t).card = Q := by
  sorry

/-- **A character new at level `n + 2`** (Lemma P's bound; X26B-L1): at an odd stable prime with `|𝓞 ⧸ P| = Q²`, a
character non-trivial on the kernel of the reduction sums to at most `2|S_{n+2}|/(Q + 1)` in modulus over `S_{n+2}` —
averaged over the fibres it keeps only the residues `x mod P` whose line `{e : Tr(σ(x)e) = 0}` it kills, and its kernel on
`P^{n+1}/P^{n+2}` holds one `k₀`-line, which is that line for at most two residues of norm one. -/
private theorem norm_charSum_new_le [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (n : ℕ) (hfin : (levelSet P (n + 2)).Finite)
    (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ (n + 2)) ℂ) (hψ : ∃ e, red P n e = 0 ∧ ψ e ≠ 1) :
    ‖∑ s ∈ hfin.toFinset, ψ s‖ ≤ 2 / ((Q : ℝ) + 1) * hfin.toFinset.card := by
  sorry

/-- **Lemma P** (KC13 § 5.2, K4's first half; X26B-L1): at an odd stable prime with `|𝓞 ⧸ P| = Q²`, a level-one character
bound `κ ≥ 2/(Q + 1)` holds at every level — by induction: a character trivial on the kernel of `R_{m+1} → R_m` descends,
and its sum is `Q` times the sum one level down (`card_fibre`); one non-trivial there is bounded by `norm_charSum_new_le`. -/
private theorem charBound_of_charBound_one [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) {κ : ℝ} (hκ : 2 / ((Q : ℝ) + 1) ≤ κ) (h1 : CharBound P 1 κ) {m : ℕ}
    (hm : 1 ≤ m) : CharBound P m κ := by
  classical
  have hκ0 : 0 ≤ κ := le_trans (by positivity) hκ
  obtain ⟨n, rfl⟩ : ∃ n, m = n + 1 := ⟨m - 1, by omega⟩
  clear hm
  induction n with
  | zero => exact h1
  | succ n ih =>
    intro hfin ψ hψ
    haveI := finite_quot_pow P (n + 1)
    have hfin' : (levelSet P (n + 1)).Finite := Set.toFinite _
    have hmaps : ∀ x ∈ hfin.toFinset, red P n x ∈ hfin'.toFinset := fun x hx =>
      hfin'.mem_toFinset.2 (red_mem_levelSet P n (hfin.mem_toFinset.1 hx))
    by_cases hK : ∀ e, red P n e = 0 → ψ e = 1
    · obtain ⟨ψ', hψ'⟩ := exists_addChar_descent P n ψ hK
      have hψ'1 : ψ' ≠ 1 := by
        intro h
        apply hψ
        ext x
        rw [hψ' x, h, AddChar.one_apply, AddChar.one_apply]
      have hsum : ∑ s ∈ hfin.toFinset, ψ s = ((Q : ℝ) : ℂ) * ∑ t ∈ hfin'.toFinset, ψ' t := by
        rw [← Finset.sum_fiberwise_of_maps_to hmaps, Finset.mul_sum]
        refine Finset.sum_congr rfl fun t ht => ?_
        have hc : ∀ x ∈ hfin.toFinset.filter (fun x => red P n x = t), ψ x = ψ' t := fun x hx => by
          rw [hψ' x, (Finset.mem_filter.1 hx).2]
        rw [Finset.sum_congr rfl hc, Finset.sum_const, card_fibre P h2 hQ n hfin (hfin'.mem_toFinset.1 ht),
          nsmul_eq_mul]
        push_cast
        ring
      have hcard : (hfin.toFinset.card : ℝ) = Q * hfin'.toFinset.card := by
        rw [Finset.card_eq_sum_card_fiberwise hmaps,
          Finset.sum_congr rfl fun t ht => card_fibre P h2 hQ n hfin (hfin'.mem_toFinset.1 ht)]
        rw [Finset.sum_const, smul_eq_mul]
        push_cast
        ring
      have hih := ih hfin' ψ' hψ'1
      rw [hsum, Complex.re_ofReal_mul, hcard]
      have hQ0 : (0 : ℝ) ≤ Q := Nat.cast_nonneg _
      have hm := mul_le_mul_of_nonneg_left hih hQ0
      linarith
    · push Not at hK
      obtain ⟨e, he, hψe⟩ := hK
      have hb := norm_charSum_new_le P h2 hQ n hfin ψ ⟨e, he, hψe⟩
      have hre := Complex.abs_re_le_norm (∑ s ∈ hfin.toFinset, ψ s)
      have hc : (0 : ℝ) ≤ hfin.toFinset.card := Nat.cast_nonneg _
      have : 2 / ((Q : ℝ) + 1) * hfin.toFinset.card ≤ κ * hfin.toFinset.card := mul_le_mul_of_nonneg_right hκ hc
      linarith [neg_abs_le (∑ s ∈ hfin.toFinset, ψ s).re]

/-- **Weil at level one** (`StandingFive.normOne_charSum_ge`, over the declared import `kloosterman_bound`): at an odd
stable prime with `|𝓞 ⧸ P| = Q²`, every non-trivial character sums to real part at least `−2√Q` over the `Q + 1` norm-one
residues. -/
private theorem charBound_one_weil [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) : CharBound P 1 (2 * Real.sqrt Q / ((Q : ℝ) + 1)) := by
  classical
  intro hfin ψ hψ
  haveI hmax : (P.P ^ 1).IsMaximal := by rw [pow_one]; exact P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P ^ 1) := Ideal.Quotient.field (P.P ^ 1)
  haveI := finite_quot_pow P 1
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ 1) := Fintype.ofFinite _
  set σ : (𝓞 (fieldI F) ⧸ P.P ^ 1) →+* (𝓞 (fieldI F) ⧸ P.P ^ 1) :=
    Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) with hσdef
  have hσmk : ∀ x, σ (Ideal.Quotient.mk (P.P ^ 1) x) = Ideal.Quotient.mk (P.P ^ 1) (conjO F x) := fun x =>
    Ideal.quotientMap_mk
  have hσ : ∀ x, σ (σ x) = x := fun x => by
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
    rw [hσmk, hσmk, UpperHalf.conjO_conjO]
  obtain ⟨i, hi2, hci⟩ := exists_I_int (F := F)
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
  obtain ⟨hcard0, hmod0⟩ := StandingFive.card_fixed_of_involution σ hσ hι hσι h2k
  have hQ4 : Q % 4 = 3 := by
    have e : Nat.card (σ.eqLocusField (RingHom.id _)) ^ 2 = Q ^ 2 := by
      rw [← hcard0, Nat.card_eq_fintype_card, hcardk]
    rw [← Nat.pow_left_injective two_ne_zero e]
    exact hmod0
  have hpow := StandingFive.involution_eq_pow σ hσ hne hcardk
  have hS : hfin.toFinset = Finset.univ.filter fun u : 𝓞 (fieldI F) ⧸ P.P ^ 1 => u ^ (Q + 1) = 1 := by
    ext u
    rw [Set.Finite.mem_toFinset, Finset.mem_filter]
    simp only [Finset.mem_univ, true_and]
    show u * σ u = 1 ↔ u ^ (Q + 1) = 1
    rw [hpow, ← pow_succ']
  have hK : ∀ (F' : Type) [Field F'] [Fintype F'] [DecidableEq F'], Fintype.card F' = Q →
      StandingFive.KloostermanBound F' := fun F' _ _ _ hF' =>
    StandingFive.kloostermanBound_of_ringChar_ne_two F'
      (StandingFive.ringChar_ne_two_of_card_mod_four (by rw [hF']; exact hQ4))
  have hW := StandingFive.normOne_charSum_ge hQ4 hcardk hK ψ hψ
  rw [hS, StandingFive.card_normOne hcardk]
  have hpos : (0 : ℝ) < (Q : ℝ) + 1 := by positivity
  have e : 2 * Real.sqrt Q / ((Q : ℝ) + 1) * ((Q + 1 : ℕ) : ℝ) = 2 * Real.sqrt Q := by
    push_cast
    field_simp
  rw [e]
  exact hW

/-- **The dyadic branch** (KR1 § 2.6 (c): `Q = 64` exact, `128` by `Floor128`, `Q ≥ 256` by EN1-UQ4): an unramified dyadic
stable prime whose level-one target needs five colours has an all-levels ratio below `1/4`. -/
private theorem ratioAtMost_dyadic [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∈ P.P)
    (hP : ¬ IsRamified P) (h : 5 ≤ (levelTarget P 1).chromaticNumber) : ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := by
  sorry

/-- **The exclusions at `q ∈ {3, 7}`** (KR1 § 2.6 (a)): there the level-one target is four-colourable (`Γ₃`, `Γ₇`). -/
private theorem chromaticNumber_le_four_of_small [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P)
    {Q : ℕ} (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hQ37 : Q = 3 ∨ Q = 7) :
    (levelTarget P 1).chromaticNumber ≤ 4 := by
  sorry

/-- **The certificate branch at `q ∈ {11, 19}`** (KC13 § 5.2: K1 the checks `cert11_ok`, `cert19_ok`; K2
`FibreCertSound.sum_le_of_certOK`, proved on the line `fs131-wc15`; K3 the level-one target as `Cay((ℤ/q)², S)`; K4 the
fibre shares at every level; K5 `U₁₁/121 < 1/4`, `U₁₉/361 < 1/4`): the link to that line, closed when the lines are joined. -/
private theorem ratioAtMost_cert [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hQ1119 : Q = 11 ∨ Q = 19) :
    ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := by
  sorry

/-- **Exact spectra at `q ∈ {23, 27, 31}`** (KC13 § 5.3; FS100-G27 at 27): level one's normalised least eigenvalue is above
`−1/3`, so some level-one bound `κ < 1/3` with `κ ≥ 2/(Q + 1)` holds. -/
private theorem charBound_one_exact [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hQ' : Q = 23 ∨ Q = 27 ∨ Q = 31) :
    ∃ κ : ℝ, κ < 1 / 3 ∧ 2 / ((Q : ℝ) + 1) ≤ κ ∧ CharBound P 1 κ := by
  sorry

-- FS131-ICM1: composed over them.

-- FS131-ICM1: `2√Q ≥ 2` for `Q ≥ 1`, so Weil's level-one constant meets Lemma P's floor.
private theorem two_div_le_weil {Q : ℕ} (hQ : 1 ≤ Q) : 2 / ((Q : ℝ) + 1) ≤ 2 * Real.sqrt Q / ((Q : ℝ) + 1) := by
  have h1 : (1 : ℝ) ≤ Real.sqrt Q := by
    rw [show (1 : ℝ) = Real.sqrt 1 from Real.sqrt_one.symm]
    exact Real.sqrt_le_sqrt (by exact_mod_cast hQ)
  have hpos : (0 : ℝ) < (Q : ℝ) + 1 := by positivity
  exact div_le_div_of_nonneg_right (by linarith) hpos.le

-- FS131-ICM1: **the Weil branch**: at an odd stable prime, ratio at most `κ/(1 + κ)`, `κ = 2√Q/(Q + 1)`.
private theorem ratioAtMost_weil [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hQ1 : 1 ≤ Q) :
    RatioAtMost P (2 * Real.sqrt Q / ((Q : ℝ) + 1) / (1 + 2 * Real.sqrt Q / ((Q : ℝ) + 1))) :=
  ratioAtMost_of_charBound P (by positivity) fun _ hm =>
    charBound_of_charBound_one P h2 hQ (two_div_le_weil hQ1) (charBound_one_weil P h2 hQ) hm

-- FS131-ICM1: the Weil constant is below `1/4` from `Q ≥ 35` (`6√Q < Q + 1`), and at most `2/9` from `Q ≥ 49`.
private theorem weil_ratio_le {Q : ℕ} {c : ℝ} (hQc : 2 * Real.sqrt Q * (1 - c) ≤ c * ((Q : ℝ) + 1)) :
    2 * Real.sqrt Q / ((Q : ℝ) + 1) / (1 + 2 * Real.sqrt Q / ((Q : ℝ) + 1)) ≤ c := by
  have hpos : (0 : ℝ) < (Q : ℝ) + 1 := by positivity
  set κ := 2 * Real.sqrt Q / ((Q : ℝ) + 1) with hκ
  have hκ0 : 0 ≤ κ := by positivity
  have hκQ : κ * ((Q : ℝ) + 1) = 2 * Real.sqrt Q := by rw [hκ]; field_simp
  have e : (κ - c * (1 + κ)) * ((Q : ℝ) + 1) = 2 * Real.sqrt Q * (1 - c) - c * ((Q : ℝ) + 1) := by
    linear_combination (1 - c) * hκQ
  have hle : κ - c * (1 + κ) ≤ 0 := by
    by_contra hcon
    push Not at hcon
    have := mul_pos hcon hpos
    linarith
  rw [div_le_iff₀ (by linarith)]
  linarith

private theorem sqrt_ge_of_sq_le {Q a : ℕ} (h : a ^ 2 ≤ Q) : (a : ℝ) ≤ Real.sqrt Q := by
  rw [Real.le_sqrt (by positivity) (by positivity)]
  exact_mod_cast h

-- FS131-ICM1: **the odd branch at `Q ≥ 35`**.
private theorem ratioAtMost_weil_lt [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hQ35 : 35 ≤ Q) : ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := by
  refine ⟨249 / 1000, by norm_num, ratioAtMost_mono (ratioAtMost_weil P h2 hQ (by omega)) (weil_ratio_le ?_)⟩
  have hs : (59 / 10 : ℝ) ≤ Real.sqrt Q := by
    rw [Real.le_sqrt (by norm_num) (by positivity)]
    have : (35 : ℝ) ≤ Q := by exact_mod_cast hQ35
    linarith
  have hsq := Real.sq_sqrt (show (0 : ℝ) ≤ Q by positivity)
  nlinarith [mul_nonneg (sub_nonneg.2 hs) (sub_nonneg.2 hs)]

/-- **Per prime**: five colours at level one give an all-levels ratio below `1/4`. -/
theorem ratioAtMost_of_five_le_chromaticNumber [NumberField F] (P : StablePrime F)
    (h : 5 ≤ (levelTarget P 1).chromaticNumber) : ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := by
  -- (a) a ramified stable prime has a two-colourable level-one target
  by_cases hram : IsRamified P
  · exfalso
    have h2c := (colorable_two_levelTarget_one_of_isRamified hram).chromaticNumber_le
    have : (5 : ℕ∞) ≤ 2 := h.trans h2c
    exact absurd this (by norm_num)
  by_cases h2 : (2 : 𝓞 (fieldI F)) ∈ P.P
  · exact ratioAtMost_dyadic P h2 hram h
  obtain ⟨Q, hQ, hQ4⟩ := exists_card_sq P h2
  by_cases hQ35 : 35 ≤ Q
  · exact ratioAtMost_weil_lt P h2 hQ hQ35
  have hcases : Q = 3 ∨ Q = 7 ∨ Q = 11 ∨ Q = 15 ∨ Q = 19 ∨ Q = 23 ∨ Q = 27 ∨ Q = 31 := by omega
  -- (b, c) the exact spectra at 23, 27, 31, then Lemma P and the ratio bound
  have hexact : Q = 23 ∨ Q = 27 ∨ Q = 31 → ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := fun hq => by
    obtain ⟨κ, hκ3, hκQ, hκ1⟩ := charBound_one_exact P h2 hQ hq
    have hκ0 : 0 ≤ κ := le_trans (by positivity) hκQ
    refine ⟨κ / (1 + κ), ?_, ratioAtMost_of_charBound P hκ0 fun _ hm => charBound_of_charBound_one P h2 hQ hκQ hκ1 hm⟩
    rw [div_lt_iff₀ (by linarith)]
    linarith
  rcases hcases with hq | hq | hq | hq | hq | hq | hq | hq
  · exact absurd (h.trans (chromaticNumber_le_four_of_small P h2 hQ (Or.inl hq))) (by norm_num)
  · exact absurd (h.trans (chromaticNumber_le_four_of_small P h2 hQ (Or.inr hq))) (by norm_num)
  · exact ratioAtMost_cert P h2 hQ (Or.inl hq)
  · exact absurd (hq ▸ hQ) (card_ne_fifteen_sq P)
  · exact ratioAtMost_cert P h2 hQ (Or.inr hq)
  · exact hexact (Or.inl hq)
  · exact hexact (Or.inr (Or.inl hq))
  · exact hexact (Or.inr (Or.inr hq))

variable (F) in
/-- **CLS** (FS100-CLS): `L(F) ≥ 5` gives T-C(A) at `S = ∅`. -/
theorem tca_of_five_le_localBound [NumberField F] (h : 5 ≤ localBound F) : TCA F := fun P =>
  ratioAtMost_of_five_le_chromaticNumber P (h.trans (iInf_le _ P))

variable (F) in
/-- **The uniform tail**: one `c < 1/4` bounds the all-levels ratio at every stable prime of absolute norm above `B`. -/
theorem exists_uniform_tail [NumberField F] :
    ∃ c : ℝ, c < 1 / 4 ∧ ∃ B : ℕ, ∀ P : StablePrime F, B < Ideal.absNorm P.P → RatioAtMost P c := by
  refine ⟨2 / 9, by norm_num, max (2 ^ Module.finrank ℤ (𝓞 (fieldI F))) 2401, fun P hP => ?_⟩
  -- a stable prime of norm above `2^[L : ℚ]` does not hold `2`
  have h2 : (2 : 𝓞 (fieldI F)) ∉ P.P := by
    intro h2
    have hle : Ideal.span {((2 : ℕ) : 𝓞 (fieldI F))} ≤ P.P := by
      rw [Ideal.span_le, Set.singleton_subset_iff]
      exact_mod_cast h2
    have hdvd := Ideal.absNorm_dvd_absNorm_of_le hle
    rw [Ideal.absNorm_span_natCast] at hdvd
    have := Nat.le_of_dvd (by positivity) hdvd
    omega
  obtain ⟨Q, hQ, -⟩ := exists_card_sq P h2
  have hN : Ideal.absNorm P.P = Q ^ 2 := by rw [Ideal.absNorm_apply, Submodule.cardQuot_apply]; exact hQ
  have hQ49 : 49 ≤ Q := by
    by_contra hlt
    have : Q ^ 2 ≤ 48 ^ 2 := Nat.pow_le_pow_left (by omega) 2
    omega
  refine ratioAtMost_mono (ratioAtMost_weil P h2 hQ (by omega)) (weil_ratio_le ?_)
  have hs : (7 : ℝ) ≤ Real.sqrt Q := by exact_mod_cast sqrt_ge_of_sq_le (a := 7) (by omega)
  have hQr : (49 : ℝ) ≤ Q := by exact_mod_cast hQ49
  nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ Q by positivity), Real.sqrt_nonneg (Q : ℝ)]

variable (F) in
/-- **T-C(A) with one constant** — the form the count reads: the tail's constant and the finitely many primes below `B`
(`Ideal.finite_setOf_absNorm_le`). -/
theorem tca_uniform [NumberField F] (h : TCA F) : ∃ c : ℝ, c < 1 / 4 ∧ ∀ P : StablePrime F, RatioAtMost P c := by
  obtain ⟨c₀, hc₀, B, hB⟩ := exists_uniform_tail F
  have hfin := finite_stablePrime_absNorm_le (F := F) B
  choose cP hcP hRP using (tca_iff F).1 h
  obtain ⟨m, hm, hmle⟩ : ∃ m : ℝ, m < 1 / 4 ∧ ∀ P : StablePrime F, Ideal.absNorm P.P ≤ B → cP P ≤ m := by
    rcases hfin.toFinset.eq_empty_or_nonempty with he | hne
    · refine ⟨0, by norm_num, fun P hP => absurd (hfin.mem_toFinset.2 hP) ?_⟩
      rw [he]
      exact Finset.notMem_empty P
    · obtain ⟨P₀, -, hmax⟩ := hfin.toFinset.exists_max_image cP hne
      exact ⟨cP P₀, hcP P₀, fun P hP => hmax P (hfin.mem_toFinset.2 hP)⟩
  refine ⟨max c₀ m, max_lt hc₀ hm, fun P => ?_⟩
  by_cases hPB : B < Ideal.absNorm P.P
  · exact ratioAtMost_mono (hB P hPB) (le_max_left _ _)
  · exact ratioAtMost_mono (hRP P) ((hmle P (not_lt.1 hPB)).trans (le_max_right _ _))

end

end HadwigerNelson.Rigidity
