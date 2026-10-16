import Proofs.HadwigerNelson.Rigidity.CountCompletion
import Mathlib.GroupTheory.FiniteAbelian.Duality
import Mathlib.RingTheory.RootsOfUnity.AlgebraicallyClosed

/-!
# Thickness: the mixing constant of every stable place, and of every level of the completion (FS-131, job FS131-KCL1; module C1)

**Read aloud, against the informal claim** (`LEDGER.md` row 128: "every stable place 6-thick (`λ*_v < 1/5` at every level,
both signs)"; D-GV and D-THK (c) of `data/fs103/claims.md` § 0). For a stable prime `P` of `L = F(i)` and a level `m ≥ 1`, the
residue target is the Cayley graph of `𝓞 ⧸ P^m` on its norm-one elements (`Rigidity.Counting.normOneQ`). Its normalised
eigenvalues are the averages of the additive characters over the norm-one set; the **mixing constant** of the place is their
largest modulus over the non-trivial characters and every level. `ThickAt P c` says it is at most `c`; `Thick F c` says so at
every stable prime — **uniformly**, one constant for all.

* `thickAt_weil` — **level one by Weil, every level by Lemma P** (V1-L7; X26B-L1): at a stable prime not above `2` with
  `|𝓞 ⧸ P| = Q²`, the constant `2√Q/(Q + 1)`.
* `thick_of_card` — **the Weil route to uniform thickness**: if no stable prime lies above `2` and every residue size is `Q²`
  with `Q ≥ B`, then `Thick F (2√B/(B + 1))`.
* `thick_of_forall_thickAt` — **row 128's per-place form gives the uniform one**: if every stable prime is `c_P`-thick with
  `c_P < c₀`, one constant below `c₀` serves all (Weil makes the tail small; finitely many primes below any norm).
* `not_isRamified_of_thickAt` — a place thicker than `1` is not ramified (at a ramified stable prime the norm-one residues
  at level one are `{1}`), so a thick field is outside row 100's exception.
* `levelThick` — **from places to the levels of the completion**: the image of `R` at level `k` is a finite group, the image
  of the unit vectors is the product of the norm-one sets (`[S9]`, `image_levR_unitVectors_of_unramified`), and every
  non-trivial character of the level group averages over it to at most `c` in modulus (a character of a subgroup extends,
  `exists_addChar_extend`; a character of a product sums over a product set as the product of the sums,
  `norm_sum_piFinset_le`).

**Models.** `Thick F c` at `c < 1/5` holds at `ℚ(√635087)` (`Collapse/Headline`, `thick_sqrt635087`); it fails at `ℚ`, whose
stable prime above `2` is ramified (`not_thick_bot`). `ThickAt P 1` holds at every `P` (`thickAt_one`).
-/

namespace HadwigerNelson.Collapse

open SpectralChain NumberField Rigidity Rigidity.Counting

noncomputable section

variable {F : Subfield ℝ} [NumberField F]

/-- **`P` is `c`-thick**: at every level `m ≥ 1`, every non-trivial additive character of `𝓞 ⧸ P^m` sums over the norm-one
elements to at most `c` times their number, in modulus — the residue target's normalised eigenvalues, both signs. -/
def ThickAt (P : StablePrime F) (c : ℝ) : Prop :=
  ∀ m : ℕ, 1 ≤ m → ∀ (hfin : (normOneQ P m).Finite) (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ m) ℂ), ψ ≠ 1 →
    ‖∑ s ∈ hfin.toFinset, ψ s‖ ≤ c * hfin.toFinset.card

variable (F) in
/-- **`F` is uniformly `c`-thick**: every stable prime is `c`-thick, with one constant `c`. -/
def Thick (c : ℝ) : Prop := ∀ P : StablePrime F, ThickAt P c

omit [NumberField F] in
/-- Thickness is monotone in the constant. -/
theorem ThickAt.mono {P : StablePrime F} {a b : ℝ} (h : ThickAt P a) (hab : a ≤ b) : ThickAt P b :=
  fun m hm hfin ψ hψ => (h m hm hfin ψ hψ).trans (mul_le_mul_of_nonneg_right hab (Nat.cast_nonneg _))

/-- Every stable prime is `1`-thick: a character into `ℂ` of a finite group has values of modulus one. -/
theorem thickAt_one (P : StablePrime F) : ThickAt P 1 := by
  intro m _ hfin ψ _
  refine (norm_sum_le _ _).trans ?_
  simp only [AddChar.norm_apply, Finset.sum_const, nsmul_eq_mul, mul_one, one_mul, le_refl]

-- FS131-ICO1: the residue ring at a level `m ≥ 1` is not zero.
omit [NumberField F] in
private theorem one_ne_zero_quot (P : StablePrime F) {m : ℕ} (hm : 1 ≤ m) : (1 : 𝓞 (fieldI F) ⧸ P.P ^ m) ≠ 0 := by
  intro h1
  have hmem : (1 : 𝓞 (fieldI F)) ∈ P.P ^ m := by
    rw [← Ideal.Quotient.eq_zero_iff_mem, map_one]
    exact h1
  exact P.isMaximal.ne_top ((Ideal.eq_top_iff_one _).2 (Ideal.pow_le_self (by omega) hmem))

-- FS131-ICO1: `1` has norm one at every level.
omit [NumberField F] in
private theorem one_mem_normOneQ (P : StablePrime F) (m : ℕ) : (1 : 𝓞 (fieldI F) ⧸ P.P ^ m) ∈ normOneQ P m := by
  show 1 * Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) 1 = 1
  rw [map_one, one_mul]

-- FS131-ICO1: **a thickness constant is not negative**: at a level `m ≥ 1` some character is non-trivial, and its sum over
-- the (non-empty) norm-one set has modulus at least `0`.
private theorem nonneg_of_thickAt {P : StablePrime F} {c : ℝ} (h : ThickAt P c) : 0 ≤ c := by
  obtain ⟨ψ, hψ⟩ := (AddChar.exists_apply_ne_zero (a := (1 : 𝓞 (fieldI F) ⧸ P.P ^ 1))).mpr
    (one_ne_zero_quot P le_rfl)
  have hψ1 : ψ ≠ 1 := fun h' => hψ (by rw [h']; rfl)
  have hfin : (normOneQ P 1).Finite := Set.toFinite _
  have hb := h 1 le_rfl hfin ψ hψ1
  have hpos : (0 : ℝ) < hfin.toFinset.card := by
    exact_mod_cast Finset.card_pos.2 ⟨1, hfin.mem_toFinset.2 (one_mem_normOneQ P 1)⟩
  by_contra hc
  push Not at hc
  have := mul_neg_of_neg_of_pos hc hpos
  linarith [norm_nonneg (∑ s ∈ hfin.toFinset, ψ s)]

/-! ## Weil and Lemma P -/

/-- **Level one by Weil, every level by Lemma P** (V1-L7, I-WEIL; X26B-L1): at a stable prime not above `2` with
`|𝓞 ⧸ P| = Q²`, every non-trivial character at every level sums over the norm-one set to at most `2√Q/(Q + 1)` of its size.
Rests on `StandingFive.kloosterman_bound` (through `circle_sum_le_weil`). -/
theorem thickAt_weil (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hQ1 : 1 ≤ Q) :
    ThickAt P (2 * Real.sqrt Q / ((Q : ℝ) + 1)) := fun _ hm hfin ψ hψ =>
  Rigidity.norm_charSum_le_weil P h2 hQ hQ1 hm hfin ψ hψ

/-- The Weil constant `2√Q/(Q + 1)` decreases from `Q = 1` on. -/
theorem weil_const_anti {B Q : ℕ} (hB : 1 ≤ B) (hBQ : B ≤ Q) :
    2 * Real.sqrt Q / ((Q : ℝ) + 1) ≤ 2 * Real.sqrt B / ((B : ℝ) + 1) := by
  have hB1 : (1 : ℝ) ≤ B := by exact_mod_cast hB
  have hBQ' : (B : ℝ) ≤ Q := by exact_mod_cast hBQ
  have hx1 : 1 ≤ Real.sqrt B := by
    rw [show (1 : ℝ) = Real.sqrt 1 from Real.sqrt_one.symm]
    exact Real.sqrt_le_sqrt hB1
  have hxy : Real.sqrt B ≤ Real.sqrt Q := Real.sqrt_le_sqrt hBQ'
  have hxx := Real.sq_sqrt (show (0 : ℝ) ≤ B by positivity)
  have hyy := Real.sq_sqrt (show (0 : ℝ) ≤ Q by positivity)
  rw [div_le_div_iff₀ (by positivity) (by positivity)]
  have key : 0 ≤ (Real.sqrt Q - Real.sqrt B) * (Real.sqrt B * Real.sqrt Q - 1) :=
    mul_nonneg (by linarith) (by nlinarith)
  nlinarith [key]

/-- **The Weil route to uniform thickness**: no stable prime above `2`, and every residue size `Q²` with `Q ≥ B`. -/
theorem thick_of_card {B : ℕ} (hB : 1 ≤ B)
    (h : ∀ P : StablePrime F, (2 : 𝓞 (fieldI F)) ∉ P.P ∧ ∃ Q : ℕ, B ≤ Q ∧ Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) :
    Thick F (2 * Real.sqrt B / ((B : ℝ) + 1)) := fun P => by
  obtain ⟨h2, Q, hBQ, hQ⟩ := h P
  exact (thickAt_weil P h2 hQ (hB.trans hBQ)).mono (weil_const_anti hB hBQ)

-- FS131-ICO1: at a stable prime not above `2` the residue field has `Q²` elements, `Q ≡ 3 (mod 4)` (`Rigidity`'s private
-- `exists_card_sq`, copied: `StandingFive.card_fixed_of_involution` at the residue of `i`).
private theorem exists_card_sq' (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) :
    ∃ Q : ℕ, Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2 ∧ Q % 4 = 3 := by
  haveI := P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P) := Ideal.Quotient.field P.P
  haveI : Finite (𝓞 (fieldI F) ⧸ P.P) := Ideal.finiteQuotientOfFreeOfNeBot _ P.heightOne.ne_bot
  let σ : (𝓞 (fieldI F) ⧸ P.P) →+* (𝓞 (fieldI F) ⧸ P.P) := Ideal.quotientMap P.P (conjO F) P.comap_conj.ge
  have hσmk : ∀ x, σ (Ideal.Quotient.mk P.P x) = Ideal.Quotient.mk P.P (conjO F x) := fun x => Ideal.quotientMap_mk
  have hσ : ∀ x, σ (σ x) = x := fun x => by
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
    rw [hσmk, hσmk, UpperHalf.conjO_conjO]
  obtain ⟨i, hi2, hci⟩ := UpperHalf.exists_I_integer (F := F)
  have h2k : (2 : 𝓞 (fieldI F) ⧸ P.P) ≠ 0 := by
    rw [← map_ofNat (Ideal.Quotient.mk P.P) 2, Ne, Ideal.Quotient.eq_zero_iff_mem]; exact h2
  obtain ⟨hcard, hmod⟩ := StandingFive.card_fixed_of_involution σ hσ (ι := Ideal.Quotient.mk P.P i)
    (by rw [← map_pow, hi2, map_neg, map_one]) (by rw [hσmk, hci, map_neg]) h2k
  exact ⟨_, hcard, hmod⟩

/-- **Row 128's per-place thickness gives the uniform one** (V1-L7's "the sup is a maximum over finitely many places"):
if every stable prime is `c_P`-thick for some `c_P < c₀`, one `c < c₀` serves every stable prime. Weil puts all but finitely
many below any positive constant; there are finitely many stable primes below any absolute norm. -/
theorem thick_of_forall_thickAt {c₀ : ℝ} (h : ∀ P : StablePrime F, ∃ c < c₀, ThickAt P c) :
    ∃ c < c₀, Thick F c := by
  classical
  by_cases hc₀ : c₀ ≤ 0
  · -- no stable prime is thick below `0`, so there is none, and any constant serves
    refine ⟨c₀ - 1, by linarith, fun P => ?_⟩
    obtain ⟨c, hc, hP⟩ := h P
    exact absurd (nonneg_of_thickAt hP) (by linarith)
  push Not at hc₀
  -- a residue size past which Weil's constant is below `c₀`
  obtain ⟨B, hB1, hBc⟩ : ∃ B : ℕ, 1 ≤ B ∧ 2 * Real.sqrt B / ((B : ℝ) + 1) < c₀ := by
    refine ⟨⌈4 / c₀ ^ 2⌉₊ + 1, by omega, ?_⟩
    set B : ℕ := ⌈4 / c₀ ^ 2⌉₊ + 1
    have hB : 4 / c₀ ^ 2 < B := by
      have := Nat.le_ceil (4 / c₀ ^ 2)
      push_cast [B]
      linarith
    have hB4 : 4 < c₀ ^ 2 * B := by
      rw [div_lt_iff₀ (by positivity)] at hB
      linarith
    have hs0 := Real.sqrt_nonneg (B : ℝ)
    have hss := Real.sq_sqrt (show (0 : ℝ) ≤ B by positivity)
    have hcs : 2 < c₀ * Real.sqrt B := by
      by_contra hle
      push Not at hle
      have h0 : 0 ≤ c₀ * Real.sqrt B := by positivity
      have h1 : (c₀ * Real.sqrt B) ^ 2 ≤ 4 := by nlinarith
      have h2 : (c₀ * Real.sqrt B) ^ 2 = c₀ ^ 2 * B := by rw [mul_pow, hss]
      linarith
    rw [div_lt_iff₀ (by positivity)]
    nlinarith
  -- the finitely many primes above `2` or of small residue size
  set N := max (Ideal.absNorm (Ideal.span {(2 : 𝓞 (fieldI F))})) (B ^ 2) with hN
  choose cP hcP hthP using h
  obtain ⟨m, hm, hmle⟩ : ∃ m < c₀, ∀ P ∈ level F N, cP P ≤ m := by
    rcases (level F N).eq_empty_or_nonempty with he | hne
    · exact ⟨0, hc₀, fun P hP => by rw [he] at hP; exact absurd hP (Finset.notMem_empty P)⟩
    · obtain ⟨P₀, hP₀, hmax⟩ := (level F N).exists_max_image cP hne
      exact ⟨cP P₀, hcP P₀, hmax⟩
  refine ⟨max m (2 * Real.sqrt B / ((B : ℝ) + 1)), max_lt hm hBc, fun P => ?_⟩
  by_cases hPN : P ∈ level F N
  · exact (hthP P).mono ((hmle P hPN).trans (le_max_left _ _))
  rw [mem_level] at hPN
  push Not at hPN
  have h2 : (2 : 𝓞 (fieldI F)) ∉ P.P := by
    intro h2
    have hle : Ideal.span {(2 : 𝓞 (fieldI F))} ≤ P.P := (Ideal.span_singleton_le_iff_mem _).2 h2
    have hd := Ideal.absNorm_dvd_absNorm_of_le hle
    have hne : Ideal.absNorm (Ideal.span {(2 : 𝓞 (fieldI F))}) ≠ 0 := by
      rw [Ne, Ideal.absNorm_eq_zero_iff, Ideal.span_singleton_eq_bot]
      exact two_ne_zero
    exact absurd hPN (not_lt.2 ((Nat.le_of_dvd (Nat.pos_of_ne_zero hne) hd).trans (le_max_left _ _)))
  obtain ⟨Q, hQ, hQ4⟩ := exists_card_sq' P h2
  have hBQ : B ≤ Q := by
    by_contra hlt
    push Not at hlt
    have hn : Ideal.absNorm P.P = Q ^ 2 := by rw [← hQ, Ideal.absNorm_apply, Submodule.cardQuot_apply]
    rw [hn] at hPN
    exact absurd hPN (not_lt.2 ((Nat.pow_le_pow_left hlt.le 2).trans (le_max_right _ _)))
  exact (thickAt_weil P h2 hQ (by omega)).mono ((weil_const_anti hB1 hBQ).trans (le_max_right _ _))

/-- **A thick place is not ramified**: at a ramified stable prime the norm-one residues at level one are `{1}`, and a
character with `ψ 1 ≠ 1` sums to modulus `1` over them. -/
theorem not_isRamified_of_thickAt {P : StablePrime F} {c : ℝ} (h : ThickAt P c) (hc : c < 1) : ¬ IsRamified P := by
  intro hram
  have e : P.P ^ 1 = P.P := pow_one _
  haveI : (P.P ^ 1).IsPrime := by rw [e]; exact P.isMaximal.isPrime
  haveI : CharP (𝓞 (fieldI F) ⧸ P.P ^ 1) 2 := by
    refine CharTwo.of_one_ne_zero_of_two_eq_zero one_ne_zero ?_
    have h2 : (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1) = Ideal.Quotient.mk (P.P ^ 1) 2 := (map_ofNat _ 2).symm
    rw [h2, Ideal.Quotient.eq_zero_iff_mem, e]
    exact hram.isDyadic
  have hid : ∀ t, Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) t = t := by
    intro t
    obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective t
    rw [Ideal.quotientMap_mk, Ideal.Quotient.eq, e]
    exact hram a
  -- the norm-one residues at level one are `{1}`
  have hone : ∀ t : 𝓞 (fieldI F) ⧸ P.P ^ 1, t ∈ normOneQ P 1 → t = 1 := by
    intro t ht
    have ht' : t * Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) t = 1 := ht
    rw [hid] at ht'
    exact frobenius_inj _ 2 (by rw [frobenius_def, frobenius_def, one_pow, sq, ht'])
  have hfin : (normOneQ P 1).Finite := Set.toFinite _
  have hS : hfin.toFinset = {1} := by
    ext t
    rw [Set.Finite.mem_toFinset, Finset.mem_singleton]
    exact ⟨hone t, fun ht => ht ▸ one_mem_normOneQ P 1⟩
  obtain ⟨ψ, hψ⟩ := (AddChar.exists_apply_ne_zero (a := (1 : 𝓞 (fieldI F) ⧸ P.P ^ 1))).mpr
    (one_ne_zero_quot P le_rfl)
  have hψ1 : ψ ≠ 1 := fun h' => hψ (by rw [h']; rfl)
  have hb := h 1 le_rfl hfin ψ hψ1
  rw [hS, Finset.sum_singleton, Finset.card_singleton, AddChar.norm_apply] at hb
  push_cast at hb
  linarith

/-! ## From places to the levels of the completion -/

/-- **A character of a subgroup of a finite abelian group extends** to the group (the restriction map of the duals is onto:
its kernel is the dual of the quotient, and the duals have the groups' sizes, `AddChar.card_eq`). -/
theorem exists_addChar_extend {G : Type*} [AddCommGroup G] [Finite G] (H : AddSubgroup G) (ψ : AddChar H ℂ) :
    ∃ ψ' : AddChar G ℂ, ∀ h : H, ψ' h = ψ h := by
  classical
  let H' : Subgroup (Multiplicative G) := AddSubgroup.toSubgroup H
  haveI : NeZero (Monoid.exponent (Multiplicative G) : ℂ) :=
    ⟨Nat.cast_ne_zero.2 Monoid.exponent_ne_zero_of_finite⟩
  have hne : ∀ x : H, ψ x ≠ 0 := fun x h0 => by
    have := AddChar.norm_apply ψ x
    rw [h0, norm_zero] at this
    exact zero_ne_one this
  let χ : H' →* ℂˣ :=
    { toFun := fun x => Units.mk0 (ψ ⟨Multiplicative.toAdd (x : Multiplicative G), x.2⟩) (hne _)
      map_one' := by
        ext
        simp only [Units.val_mk0, Units.val_one]
        exact ψ.map_zero_eq_one
      map_mul' := fun x y => by
        ext
        simp only [Units.val_mk0, Units.val_mul]
        rw [← AddChar.map_add_eq_mul]
        rfl }
  obtain ⟨χ', hχ'⟩ := MonoidHom.restrict_surjective (G := Multiplicative G) (M := ℂ) H' χ
  refine ⟨AddChar.toMonoidHomEquiv.symm ((Units.coeHom ℂ).comp χ'), fun h => ?_⟩
  have hx : (Multiplicative.ofAdd (h : G) : Multiplicative G) ∈ H' := h.2
  have h1 := congrArg (fun f : H' →* ℂˣ => ((f ⟨Multiplicative.ofAdd (h : G), hx⟩ : ℂˣ) : ℂ)) hχ'
  simp only [MonoidHom.restrictHom_apply, MonoidHom.restrict_apply] at h1
  rw [AddChar.toMonoidHomEquiv_symm_apply, MonoidHom.comp_apply, Units.coeHom_apply, h1]
  rfl

/-- **A character of a finite product sums over a product set as the product of its factors' sums**, so a non-trivial one
is bounded by its non-trivial factor: if every non-trivial character of every factor sums over `S i` to at most `c·|S i|`,
so does every non-trivial character of the product over `∏ S i`. -/
theorem norm_sum_piFinset_le {ι : Type*} [Fintype ι] [DecidableEq ι] {A : ι → Type*} [∀ i, AddCommGroup (A i)]
    [∀ i, Finite (A i)] [∀ i, DecidableEq (A i)] (S : ∀ i, Finset (A i)) {c : ℝ} (hc : 0 ≤ c)
    (hS : ∀ i (φ : AddChar (A i) ℂ), φ ≠ 1 → ‖∑ s ∈ S i, φ s‖ ≤ c * (S i).card) (ψ : AddChar (∀ i, A i) ℂ)
    (hψ : ψ ≠ 1) : ‖∑ s ∈ Fintype.piFinset S, ψ s‖ ≤ c * (Fintype.piFinset S).card := by
  classical
  -- `0 ≤ c` is not read: the trivial factors are bounded by their sizes, the non-trivial one by `hS`
  have _ := hc
  -- the factor characters `φ i = ψ ∘ single i`
  let φ : ∀ i, AddChar (A i) ℂ := fun i => ψ.compAddMonoidHom (AddMonoidHom.single A i)
  have hφ : ∀ i a, φ i a = ψ (Pi.single i a) := fun _ _ => rfl
  have hsum : ∀ (t : Finset ι) (x : ι → ∀ i, A i), ψ (∑ i ∈ t, x i) = ∏ i ∈ t, ψ (x i) := by
    intro t x
    induction t using Finset.induction_on with
    | empty => simp
    | insert a t ha ih => rw [Finset.sum_insert ha, Finset.prod_insert ha, AddChar.map_add_eq_mul, ih]
  have hprod : ∀ s : ∀ i, A i, ψ s = ∏ i, φ i (s i) := fun s => by
    conv_lhs => rw [← Finset.univ_sum_single s]
    rw [hsum]
    exact Finset.prod_congr rfl fun i _ => (hφ i (s i)).symm
  -- some factor is non-trivial
  obtain ⟨i₀, hi₀⟩ : ∃ i₀, φ i₀ ≠ 1 := by
    by_contra hall
    push Not at hall
    apply hψ
    ext s
    rw [hprod, AddChar.one_apply]
    exact Finset.prod_eq_one fun i _ => by rw [hall i, AddChar.one_apply]
  have hS' : ∑ s ∈ Fintype.piFinset S, ψ s = ∏ i, ∑ t ∈ S i, φ i t := by
    rw [Finset.prod_univ_sum]
    exact Finset.sum_congr rfl fun s _ => hprod s
  rw [hS', norm_prod, Fintype.card_piFinset]
  push_cast
  have hb : ∀ i ∈ (Finset.univ : Finset ι), ‖∑ t ∈ S i, φ i t‖ ≤ (if i = i₀ then c else 1) * (S i).card := by
    intro i _
    by_cases hi : i = i₀
    · subst hi
      rw [if_pos rfl]
      exact hS i (φ i) hi₀
    · rw [if_neg hi, one_mul]
      refine (norm_sum_le _ _).trans ?_
      simp only [AddChar.norm_apply, Finset.sum_const, nsmul_eq_mul, mul_one, le_refl]
  refine (Finset.prod_le_prod (fun i _ => norm_nonneg _) hb).trans (le_of_eq ?_)
  rw [Finset.prod_mul_distrib, Finset.prod_ite_eq' Finset.univ i₀ (fun _ => c)]
  simp

/-- **`[S9]` at level `k` over unramified stable primes**: the unit vectors map onto the product of the norm-one sets.
`Rigidity.Counting.image_levR_unitVectors` with its hypothesis `TCA F` read where it is used — "no stable prime is
ramified" — and no further. -/
theorem image_levR_unitVectors_of_unramified (hun : ∀ P : StablePrime F, ¬ IsRamified P) (k : ℕ) :
    levR F k '' {r | (r : ℂ) ∈ unitVectors F} = normOneLev F k := by
  ext d
  constructor
  · rintro ⟨r, hr, rfl⟩ P
    have hx : ofUnitRing F r ∈ normOneL F := (mem_normOneL_iff F).2 hr
    show P.1.residue k (toLocal P.1 r) *
      Ideal.quotientMap (P.1.P ^ k) (conjO F) (P.1.le_comap k) (P.1.residue k (toLocal P.1 r)) = 1
    rw [← UpperHalf.residue_conj, ← map_mul, ← map_one (P.1.residue k)]
    congr 1
    exact Subtype.ext hx
  · intro hd
    obtain ⟨x, hx, hres⟩ := exists_normOneL_residues (level F k) (fun P _ => hun P) k
      (fun P hP => (d : ∀ P : level F k, 𝓞 (fieldI F) ⧸ P.1.P ^ k) ⟨P, hP⟩) (fun P hP => hd ⟨P, hP⟩)
    obtain ⟨r, hrx, hru⟩ := exists_unitRing_of_normOneL hx
    refine ⟨r, hru, funext fun P => ?_⟩
    show P.1.residue k (toLocal P.1 r) = _
    have e : toLocal P.1 r = ⟨x, UpperHalf.mem_localRing_of_mul_conj_eq_one P.1 hx⟩ := Subtype.ext hrx
    rw [e]
    exact hres P.1 P.2

variable (F) in
/-- **The level-`k` group**: the image of `R = ℤ[U]` in `Lev F k = ∏_{P ∈ level k} 𝓞 ⧸ P^k` (the range of `proj k` on the
completion, `Rigidity.Counting.range_proj`). -/
abbrev LevImg (k : ℕ) : AddSubgroup (Lev F k) := (levR F k).range.toAddSubgroup

variable (F) in
/-- **The level-`k` connection set**: the norm-one points of the level group — the image of the unit vectors, where no stable
prime is ramified. -/
def levU (k : ℕ) : Set (LevImg F k) := {d | (d : Lev F k) ∈ normOneLev F k}

theorem finite_levU (k : ℕ) : (levU F k).Finite := Set.toFinite _

/-- **Thickness at the levels of the completion**: over a uniformly `c`-thick field (`c < 1`), every non-trivial character of
the level-`k` group (`k ≥ 1`) averages over the level's connection set to at most `c` in modulus. -/
theorem levelThick {c : ℝ} (hT : Thick F c) (hc : c < 1) {k : ℕ} (hk : 1 ≤ k) (ψ : AddChar (LevImg F k) ℂ)
    (hψ : ψ ≠ 1) : ‖∑ s ∈ (finite_levU (F := F) k).toFinset, ψ s‖ ≤ c * (finite_levU (F := F) k).toFinset.card := by
  classical
  have hun : ∀ P : StablePrime F, ¬ IsRamified P := fun P => not_isRamified_of_thickAt (hT P) hc
  -- `0 ≤ c`: a non-trivial character of the level group needs a stable prime of level `k`
  have hc0 : 0 ≤ c := by
    obtain ⟨x, hx⟩ : ∃ x, ψ x ≠ 1 := by
      by_contra hall
      push Not at hall
      exact hψ (DFunLike.ext _ _ fun x => by rw [hall x, AddChar.one_apply])
    have hx0 : (x : Lev F k) ≠ 0 := fun h0 => hx (by
      have : x = 0 := Subtype.ext h0
      rw [this, AddChar.map_zero_eq_one])
    obtain ⟨P, -⟩ := Function.ne_iff.mp hx0
    exact nonneg_of_thickAt (hT P.1)
  -- extend the character to the whole level ring, a product
  obtain ⟨ψ', hψ'⟩ := exists_addChar_extend (LevImg F k) ψ
  have hψ'1 : ψ' ≠ 1 := fun h1 => hψ (DFunLike.ext _ _ fun x => by
    rw [← hψ' x, h1, AddChar.one_apply, AddChar.one_apply])
  let S : ∀ P : level F k, Finset (𝓞 (fieldI F) ⧸ P.1.P ^ k) := fun P => (Set.toFinite (normOneQ P.1 k)).toFinset
  let f : LevImg F k → (∀ P : level F k, 𝓞 (fieldI F) ⧸ P.1.P ^ k) := fun s => s.1
  -- the connection set is the product set `∏ S P`
  have hmaps : ∀ s ∈ (finite_levU (F := F) k).toFinset, f s ∈ Fintype.piFinset S := by
    intro s hs
    rw [Fintype.mem_piFinset]
    intro P
    rw [Set.Finite.mem_toFinset]
    exact ((finite_levU k).mem_toFinset.1 hs) P
  have hinj : Set.InjOn f (finite_levU (F := F) k).toFinset := fun s _ t _ hst => Subtype.ext hst
  have hsurj : Set.SurjOn f (finite_levU (F := F) k).toFinset (Fintype.piFinset S : Set _) := by
    intro d hd
    have hmem : ∀ P : level F k, d P ∈ normOneQ P.1 k := fun P => by
      have := (Fintype.mem_piFinset.1 (Finset.mem_coe.1 hd)) P
      rwa [Set.Finite.mem_toFinset] at this
    have hd' : (d : Lev F k) ∈ normOneLev F k := hmem
    rw [← image_levR_unitVectors_of_unramified hun k] at hd'
    obtain ⟨r, -, hr⟩ := hd'
    refine ⟨⟨d, ⟨r, hr⟩⟩, ?_, rfl⟩
    rw [Finset.mem_coe, Set.Finite.mem_toFinset]
    exact hmem
  have hsum : ∑ s ∈ (finite_levU (F := F) k).toFinset, ψ s = ∑ d ∈ Fintype.piFinset S, ψ' d :=
    Finset.sum_nbij f hmaps hinj hsurj fun s _ => (hψ' s).symm
  have hcard : (finite_levU (F := F) k).toFinset.card = (Fintype.piFinset S).card :=
    Finset.card_nbij f hmaps hinj hsurj
  rw [hsum, hcard]
  exact norm_sum_piFinset_le (A := fun P : level F k => 𝓞 (fieldI F) ⧸ P.1.P ^ k) S hc0
    (fun P φ hφ => hT P.1 k hk (Set.toFinite _) φ hφ) ψ' hψ'1

/-- The level's connection set is not empty (`1` is a unit vector). -/
theorem levU_nonempty (k : ℕ) : (levU F k).Nonempty :=
  ⟨⟨1, ⟨1, map_one _⟩⟩, fun P => one_mem_normOneQ P.1 k⟩

/-! ## Spec -/

-- `Thick` is `ThickAt` at every stable prime, with one constant.
example (c : ℝ) : Thick F c ↔ ∀ P : StablePrime F, ThickAt P c := Iff.rfl

-- every place is `1`-thick (characters of a finite group have modulus one): the constant `1` is the trivial bound.
example (P : StablePrime F) : ThickAt P 1 := thickAt_one P

end

end HadwigerNelson.Collapse
