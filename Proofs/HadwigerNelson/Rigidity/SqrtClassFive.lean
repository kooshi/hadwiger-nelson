import Proofs.HadwigerNelson.Rigidity.ChainHeadline

/-!
# Five colours at every stable prime when `F` holds the right square roots; D:116's class (FS-131, job FS131-KM15; module M15)

**Read aloud, against the informal claim** (`data/fs131/claims-NF2.md`, NF2-LEAF-23: "`5 ≤ localBound` … every stable
prime of `ℚ(√47, i)` and its target (D:116 …: the class among real quadratic fields is `d ≡ 47, 143, 167 (mod 168)`)").
For a real field `F` and natural numbers that are squares in `F`:

* `two_notMem_of_isSquare` — **if some `a ≡ 7 (mod 8)` is a square in `F`, no stable prime of `F(i)` lies above 2**:
  `ω = (1 + i√a)/2` is an integer with `ω(1 − ω) = (a + 1)/4`, an even number, and `ω̄ = 1 − ω`; a stable prime holding 2
  holds `ω` or `1 − ω`, so both, so 1.
* `stablePrime_card_of_two_notMem` — **at an odd stable prime the residue field has `Q²` elements, `Q = pⁿ ≡ 3 (mod 4)`
  with `n` odd, and every natural number that is a square in `F` is a square modulo `p`**: the residue of `√d` is fixed by
  conjugation, so it lies in the fixed field of `Q` elements, where every element fixed by `x ↦ xᵖ` is a residue of `ℤ`.
* `five_le_chromaticNumber_of_isSquare`, `five_le_localBound_of_isSquare` — **if `F` holds square roots of some
  `a ≡ 7 (mod 8)`, some `b ≡ 2 (mod 3)` and some `c` that is not a square modulo 7, every stable prime's level-one target
  needs five colours, so `5 ≤ L(F)`**: no stable prime is dyadic and no residue field has 9 or 49 elements; M13's ratio at
  every other odd stable prime is below `1/4` (`ratioAtMost_two_notMem_link`), and a level-one ratio below `1/4` excludes a
  four-colouring (`five_le_chromaticNumber_of_ratioAtMost`). The three radicands may differ: at `ℚ(√3, √5)`, `15`, `5`, `3`.
* `five_le_localBound_of_isSquare_class` — **D:116's class**: one `d ≡ 47, 143 or 167 (mod 168)` serves as all three.
* `five_le_chromaticNumber_planeOver_of_five_le_localBound` — **`L(F) ≥ 5` gives `χ(F²) ≥ 5`**, given `[AmbrusEtAl2023]`
  Theorem 1 as printed (`Plane.OneAvoidingDensityBound`, the headline's `hOA`): the chain's headline, whose row-99
  hypothesis is idle at `L ≥ 5`.
* `tca_iff_five_le_localBound` — **CLS is an equivalence**: T-C(A) at `S = ∅` holds exactly when `L(F) ≥ 5`.

**What rests on what.** `ratioAtMost_two_notMem_link` is the one `sorry` of this module: the link to M13's line, where
`Rigidity.ratioAtMost_of_two_notMem` (the odd branch of `ratioAtMost_of_five_le_chromaticNumber`, its chromatic hypothesis
replaced by the two residue sizes it excludes) is added to `Rigidity/ClassRatio` with this statement (the coordinator's
ruling of 2026-10-14 on FS131-KM15's notice). The join deletes the link and its one reader reads that name.

**Not claimed:** the converse of any implication here but CLS's; that `L(F) = 5`; anything at a `d` outside the class;
that any statement is new mathematics.

**Inhabitants.** The hypotheses that are structures are a stable prime and a number field: a stable prime of `ℚ(√47)`
above 11 is `SqrtFortySeven.exists_stablePrime_eleven` (`Instances/SqrtFortySevenFive`), where `47` is a square serving as
`a`, `b` and `c` at once. `d = 47, 143, 167, 311, 335` are in the class (the spec below). `Plane.OneAvoidingDensityBound`: `Plane.oneAvoidingDensityBound_model` models its clause; the
statement is an outside theorem.
-/

namespace HadwigerNelson.Rigidity

open SpectralChain NumberField SimpleGraph

noncomputable section

variable {F : Subfield ℝ}

/-! ### Level one: a ratio below a quarter needs five colours -/

-- A finite graph whose independent sets hold at most the fraction `c` of its vertices, `k·c < 1`, is not `k`-colourable:
-- the `k` colour classes are independent and cover the vertices.
private theorem add_one_le_chromaticNumber_of_indep_le {V : Type*} [Finite V] [Nonempty V] (G : SimpleGraph V) {c : ℝ}
    {k : ℕ} (hk : k * c < 1) (h : ∀ s : Finset V, G.IsIndepSet (s : Set V) → (s.card : ℝ) ≤ c * Nat.card V) :
    ((k + 1 : ℕ) : ℕ∞) ≤ G.chromaticNumber := by
  classical
  refine add_one_le_chromaticNumber_iff_not_colorable.mpr fun ⟨C⟩ => ?_
  letI : Fintype V := Fintype.ofFinite V
  have hN : (0 : ℝ) < Nat.card V := by exact_mod_cast Nat.card_pos
  have hsum : (Finset.univ : Finset V).card = ∑ j : Fin k, (Finset.univ.filter fun v => C v = j).card :=
    Finset.card_eq_sum_card_fiberwise fun v _ => Finset.mem_univ (C v)
  have hle : ∀ j : Fin k, ((Finset.univ.filter fun v => C v = j).card : ℝ) ≤ c * Nat.card V := fun j => by
    refine h _ ?_
    have e : ((Finset.univ.filter fun v => C v = j : Finset V) : Set V) = C.colorClass j := by
      ext v
      simp [SimpleGraph.Coloring.colorClass]
    rw [e]
    exact C.isIndepSet_colorClass j
  have hNs : (Nat.card V : ℝ) = ∑ j : Fin k, ((Finset.univ.filter fun v => C v = j).card : ℝ) := by
    rw [Nat.card_eq_fintype_card, ← Finset.card_univ, hsum]
    push_cast
    rfl
  have hNk : (Nat.card V : ℝ) ≤ k * (c * Nat.card V) := by
    calc (Nat.card V : ℝ) = ∑ j : Fin k, ((Finset.univ.filter fun v => C v = j).card : ℝ) := hNs
      _ ≤ ∑ _j : Fin k, c * Nat.card V := Finset.sum_le_sum fun j _ => hle j
      _ = k * (c * Nat.card V) := by rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  have hlt := mul_lt_mul_of_pos_right hk hN
  nlinarith

/-- **A level-one ratio below `1/4` needs five colours**: the colour classes of a four-colouring are independent and one
holds at least a quarter of the residue ring. -/
theorem five_le_chromaticNumber_of_ratioAtMost [NumberField F] (P : StablePrime F) {c : ℝ} (hc : c < 1 / 4)
    (h : RatioAtMost P c) : 5 ≤ (levelTarget P 1).chromaticNumber := by
  haveI : Finite (𝓞 (fieldI F) ⧸ P.P ^ 1) := Ideal.finiteQuotientOfFreeOfNeBot _ (pow_ne_zero 1 P.heightOne.ne_bot)
  haveI : Nonempty (𝓞 (fieldI F) ⧸ P.P ^ 1) := ⟨0⟩
  have h5 := add_one_le_chromaticNumber_of_indep_le (levelTarget P 1) (k := 4) (c := c) (by push_cast; linarith) (h 1 le_rfl)
  exact_mod_cast h5

variable (F) in
/-- **T-C(A) gives `L(F) ≥ 5`**: CLS's converse. -/
theorem five_le_localBound_of_tca [NumberField F] (h : TCA F) : 5 ≤ localBound F :=
  le_iInf fun P => by
    obtain ⟨c, hc, hP⟩ := h P
    exact five_le_chromaticNumber_of_ratioAtMost P hc hP

variable (F) in
/-- **CLS is an equivalence**: T-C(A) at `S = ∅` exactly when `L(F) ≥ 5`. -/
theorem tca_iff_five_le_localBound [NumberField F] : TCA F ↔ 5 ≤ localBound F :=
  ⟨five_le_localBound_of_tca F, tca_of_five_le_localBound F⟩

/-- **The link to M13's line** (`Rigidity.ratioAtMost_of_two_notMem`, added to `Rigidity/ClassRatio` with this statement
on that line, by the coordinator's ruling of 2026-10-14): at an odd stable prime whose residue field has neither 9 nor 49
elements, the all-levels ratio is below `1/4`. Deleted at the join; its one reader then reads M13's name. -/
private theorem ratioAtMost_two_notMem_link [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P)
    (h9 : Nat.card (𝓞 (fieldI F) ⧸ P.P) ≠ 9) (h49 : Nat.card (𝓞 (fieldI F) ⧸ P.P) ≠ 49) :
    ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := by
  sorry

/-- **The floor at an odd stable prime**: unless the residue field has 9 or 49 elements, the level-one target needs five
colours. -/
theorem five_le_chromaticNumber_of_two_notMem [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P)
    (h9 : Nat.card (𝓞 (fieldI F) ⧸ P.P) ≠ 9) (h49 : Nat.card (𝓞 (fieldI F) ⧸ P.P) ≠ 49) :
    5 ≤ (levelTarget P 1).chromaticNumber := by
  obtain ⟨c, hc, hP⟩ := ratioAtMost_two_notMem_link P h2 h9 h49
  exact five_le_chromaticNumber_of_ratioAtMost P hc hP

/-! ### Three integers of `F(i)` when `d` is a square in `F` -/

-- A square root `r ∈ F` of `d` is an integer of `F(i)` fixed by conjugation.
private theorem exists_sqrt_integer {d : ℕ} (hd : IsSquare (d : F)) :
    ∃ s : 𝓞 (fieldI F), s ^ 2 = (d : 𝓞 (fieldI F)) ∧ conjO F s = s := by
  obtain ⟨r, hr⟩ := hd
  have hrR : (d : ℝ) = (r : ℝ) * r := by simpa using congrArg (fun x : F => (x : ℝ)) hr
  let sL : fieldI F := ⟨((r : ℝ) : ℂ), by simp, by simp [zero_mem]⟩
  have hsL : sL ^ 2 = (d : fieldI F) := Subtype.ext (by
    show ((r : ℝ) : ℂ) ^ 2 = ((d : ℂ))
    rw [show ((d : ℂ)) = ((d : ℝ) : ℂ) by push_cast; rfl, hrR]
    push_cast
    ring)
  have hint : IsIntegral ℤ sL := StandingFive.isIntegral_of_sq_add 0 (-(d : ℤ)) (by rw [hsL]; push_cast; ring)
  refine ⟨⟨sL, hint⟩, RingOfIntegers.coe_injective ?_, RingOfIntegers.coe_injective ?_⟩
  · rw [map_pow, map_natCast]
    exact hsL
  · show ((conjO F ⟨sL, hint⟩ : 𝓞 (fieldI F)) : fieldI F) = sL
    rw [UpperHalf.coe_conjO]
    exact Subtype.ext (by rw [coe_conjOn]; exact Complex.conj_ofReal _)

-- `i` is an integer of `F(i)` with `ī = −i` (the same fact is private in `Arith/UpperHalf` and `Rigidity/ClassRatio`).
private theorem exists_I_integer : ∃ i : 𝓞 (fieldI F), i ^ 2 = -1 ∧ conjO F i = -i := by
  let iL : fieldI F := ⟨Complex.I, by simp [zero_mem], by simp [one_mem]⟩
  have hiL : iL ^ 2 = -1 := Subtype.ext Complex.I_sq
  have hint : IsIntegral ℤ iL := IsIntegral.of_pow (n := 2) (by norm_num) (by rw [hiL]; exact isIntegral_one.neg)
  refine ⟨⟨iL, hint⟩, RingOfIntegers.coe_injective ?_, RingOfIntegers.coe_injective ?_⟩
  · rw [map_pow, map_neg, map_one]; exact hiL
  · rw [map_neg]; exact Subtype.ext Complex.conj_I

-- `ω = (1 + i√a)/2` is an integer of `F(i)` when `a ≡ 3 (mod 4)`, with `ω(1 − ω) = (a + 1)/4` and `ω̄ = 1 − ω`.
private theorem exists_omega_integer {a : ℕ} (ha : IsSquare (a : F)) (h4 : a % 4 = 3) :
    ∃ w : 𝓞 (fieldI F), w * (1 - w) = (((a + 1) / 4 : ℕ) : 𝓞 (fieldI F)) ∧ conjO F w = 1 - w := by
  obtain ⟨r, hr⟩ := ha
  have hrR : (a : ℝ) = (r : ℝ) * r := by simpa using congrArg (fun x : F => (x : ℝ)) hr
  let sL : fieldI F := ⟨((r : ℝ) : ℂ), by simp, by simp [zero_mem]⟩
  let iL : fieldI F := ⟨Complex.I, by simp [zero_mem], by simp [one_mem]⟩
  have hs : sL ^ 2 = (a : fieldI F) := Subtype.ext (by
    show ((r : ℝ) : ℂ) ^ 2 = ((a : ℂ))
    rw [show ((a : ℂ)) = ((a : ℝ) : ℂ) by push_cast; rfl, hrR]
    push_cast
    ring)
  have hi : iL ^ 2 = -1 := Subtype.ext Complex.I_sq
  have hcs : conjOn (fieldI_conj F) sL = sL := Subtype.ext (by rw [coe_conjOn]; exact Complex.conj_ofReal _)
  have hci : conjOn (fieldI_conj F) iL = -iL := Subtype.ext (by rw [coe_conjOn]; exact Complex.conj_I)
  set k := (a + 1) / 4 with hkdef
  have hk : 4 * (k : fieldI F) = a + 1 := by
    have : 4 * k = a + 1 := by omega
    exact_mod_cast this
  let wL : fieldI F := (1 + iL * sL) / 2
  have hw : wL * (1 - wL) = k := by
    simp only [wL]
    linear_combination (-(sL ^ 2) / 4) * hi + (1 / 4 : fieldI F) * hs - (1 / 4 : fieldI F) * hk
  have hint : IsIntegral ℤ wL := StandingFive.isIntegral_of_sq_add (-1) (k : ℤ) (by
    push_cast
    linear_combination -hw)
  have hcw : conjOn (fieldI_conj F) wL = 1 - wL := by
    simp only [wL, map_div₀, map_add, map_mul, map_one, map_ofNat, hcs, hci]
    ring
  refine ⟨⟨wL, hint⟩, RingOfIntegers.coe_injective ?_, RingOfIntegers.coe_injective ?_⟩
  · rw [map_mul, map_sub, map_one, map_natCast]
    exact hw
  · show ((conjO F ⟨wL, hint⟩ : 𝓞 (fieldI F)) : fieldI F) = 1 - wL
    rw [UpperHalf.coe_conjO]
    exact hcw

/-! ### The stable primes -/

/-- **No stable prime above 2 when some `a ≡ 7 (mod 8)` is a square in `F`**. -/
theorem two_notMem_of_isSquare (P : StablePrime F) {a : ℕ} (ha : IsSquare (a : F)) (h8 : a % 8 = 7) :
    (2 : 𝓞 (fieldI F)) ∉ P.P := by
  intro h2
  obtain ⟨w, hw, hcw⟩ := exists_omega_integer ha (by omega)
  have hk : (a + 1) / 4 = 2 * ((a + 1) / 8) := by omega
  have hmem : w * (1 - w) ∈ P.P := by
    rw [hw, hk, Nat.cast_mul, Nat.cast_ofNat]
    exact P.P.mul_mem_right _ h2
  have hboth : w ∈ P.P ∧ 1 - w ∈ P.P := by
    rcases P.isMaximal.isPrime.mem_or_mem hmem with h | h
    · exact ⟨h, by rw [← hcw]; exact (UpperHalf.conjO_mem_iff P).2 h⟩
    · exact ⟨by rw [← UpperHalf.conjO_mem_iff P, hcw]; exact h, h⟩
  have h1 : (1 : 𝓞 (fieldI F)) ∈ P.P := by
    have e : w + (1 - w) = 1 := by ring
    rw [← e]
    exact P.P.add_mem hboth.1 hboth.2
  exact P.isMaximal.ne_top ((Ideal.eq_top_iff_one _).2 h1)

/-- **An odd stable prime and its residue field**: it lies above a prime `p ≡ 3 (mod 4)`, its residue field has `Q²`
elements with `Q = pⁿ`, `n` odd, and every natural number that is a square in `F` is a square modulo `p`. -/
theorem stablePrime_card_of_two_notMem [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) :
    ∃ p n : ℕ, p.Prime ∧ p % 4 = 3 ∧ Odd n ∧ (p : 𝓞 (fieldI F)) ∈ P.P ∧
      Nat.card (𝓞 (fieldI F) ⧸ P.P) = (p ^ n) ^ 2 ∧ ∀ d : ℕ, IsSquare (d : F) → IsSquare (d : ZMod p) := by
  classical
  haveI := P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P) := Ideal.Quotient.field P.P
  haveI : Finite (𝓞 (fieldI F) ⧸ P.P) := Ideal.finiteQuotientOfFreeOfNeBot _ P.heightOne.ne_bot
  -- (a) conjugation on the residue field, an involution
  let σ : (𝓞 (fieldI F) ⧸ P.P) →+* (𝓞 (fieldI F) ⧸ P.P) := Ideal.quotientMap P.P (conjO F) P.comap_conj.ge
  have hσmk : ∀ x, σ (Ideal.Quotient.mk P.P x) = Ideal.Quotient.mk P.P (conjO F x) := fun x => Ideal.quotientMap_mk
  have hσ : ∀ x, σ (σ x) = x := fun x => by
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
    rw [hσmk, hσmk, UpperHalf.conjO_conjO]
  -- (b) it moves the residue of `i`, and `2 ≠ 0`
  obtain ⟨i, hi2, hci⟩ := exists_I_integer (F := F)
  have h2k : (2 : 𝓞 (fieldI F) ⧸ P.P) ≠ 0 := by
    rw [← map_ofNat (Ideal.Quotient.mk P.P) 2, Ne, Ideal.Quotient.eq_zero_iff_mem]; exact h2
  -- (c) the fixed field `K₀` has `Q` elements, `Q ≡ 3 (mod 4)`, and the residue field `Q²`
  obtain ⟨hcard, hmod⟩ := StandingFive.card_fixed_of_involution σ hσ (ι := Ideal.Quotient.mk P.P i)
    (by rw [← map_pow, hi2, map_neg, map_one]) (by rw [hσmk, hci, map_neg]) h2k
  set K₀ := σ.eqLocusField (RingHom.id _) with hK₀
  letI : Fintype K₀ := Fintype.ofFinite _
  -- (d) `Q = pⁿ`
  obtain ⟨p, hchar, n, hp, hcardp⟩ := FiniteField.card' K₀
  haveI := Fact.mk hp
  have hcardp' : Nat.card K₀ = p ^ (n : ℕ) := by rw [Nat.card_eq_fintype_card]; exact hcardp
  obtain ⟨hp4, hn⟩ := StandingFive.mod_four_of_pow (hcardp' ▸ hmod)
  refine ⟨p, n, hp, hp4, hn, ?_, by rw [hcard, hcardp'], ?_⟩
  · -- `P` lies above `p`: `p = 0` in `K₀`
    have h0 : ((p : K₀) : 𝓞 (fieldI F) ⧸ P.P) = 0 := by rw [CharP.cast_eq_zero K₀ p]; rfl
    rw [← Ideal.Quotient.eq_zero_iff_mem, map_natCast, ← map_natCast K₀.subtype p]
    exact h0
  · -- (e) the residue of a square root of `d` lies in `K₀` and is fixed by `x ↦ xᵖ`
    intro d hd
    obtain ⟨s, hs2, hcs⟩ := exists_sqrt_integer hd
    let r : K₀ := ⟨Ideal.Quotient.mk P.P s, by show σ _ = RingHom.id _ _; rw [hσmk, hcs]; rfl⟩
    have hr2 : r ^ 2 = (d : K₀) := Subtype.ext (by
      show (Ideal.Quotient.mk P.P s) ^ 2 = ((d : K₀) : 𝓞 (fieldI F) ⧸ P.P)
      rw [← map_pow, hs2, map_natCast]
      exact_mod_cast rfl)
    have hrp := StandingFive.pow_char_eq_of_sq_natCast hcardp' hn (by omega) hr2
    obtain ⟨c, -, hc⟩ := StandingFive.exists_natCast_of_pow_eq hrp
    have hcc : ((c * c : ℕ) : K₀) = (d : K₀) := by push_cast; rw [hc, ← pow_two, hr2]
    refine ⟨(c : ZMod p), ?_⟩
    rw [← Nat.cast_mul]
    exact ((ZMod.natCast_eq_natCast_iff _ _ _).mpr ((CharP.natCast_eq_natCast K₀ p).mp hcc)).symm

/-- **Every stable prime's level-one target needs five colours** when `F` holds square roots of some `a ≡ 7 (mod 8)`,
some `b ≡ 2 (mod 3)` and some `c` that is not a square modulo 7. -/
theorem five_le_chromaticNumber_of_isSquare [NumberField F] (P : StablePrime F) {a b c : ℕ} (ha : IsSquare (a : F))
    (h8 : a % 8 = 7) (hb : IsSquare (b : F)) (h3 : b % 3 = 2) (hc : IsSquare (c : F))
    (h7 : c % 7 = 3 ∨ c % 7 = 5 ∨ c % 7 = 6) : 5 ≤ (levelTarget P 1).chromaticNumber := by
  have h2 := two_notMem_of_isSquare P ha h8
  obtain ⟨p, n, hp, -, hn, -, hcard, hsq⟩ := stablePrime_card_of_two_notMem P h2
  -- a residue field of `q²` elements, `q` prime, lies above `q`
  have hpq : ∀ q : ℕ, q.Prime → Nat.card (𝓞 (fieldI F) ⧸ P.P) = q ^ 2 → p = q := by
    intro q hq h
    have h1 : p ^ n = q := Nat.pow_left_injective two_ne_zero (hcard.symm.trans h)
    have hn0 : n ≠ 0 := by obtain ⟨j, rfl⟩ := hn; omega
    exact (Nat.prime_dvd_prime_iff_eq hp hq).1 (h1 ▸ dvd_pow_self p hn0)
  refine five_le_chromaticNumber_of_two_notMem P h2 (fun h9 => ?_) (fun h49 => ?_)
  · obtain rfl := hpq 3 Nat.prime_three (by rw [h9]; norm_num)
    have hb' := hsq b hb
    rw [← ZMod.natCast_mod, h3] at hb'
    revert hb'
    decide
  · obtain rfl := hpq 7 (by norm_num) (by rw [h49]; norm_num)
    have hc' := hsq c hc
    rw [← ZMod.natCast_mod] at hc'
    rcases h7 with h | h | h <;> rw [h] at hc' <;> revert hc' <;> decide

variable (F) in
/-- **`L(F) ≥ 5`** for every real number field holding square roots of some `a ≡ 7 (mod 8)`, some `b ≡ 2 (mod 3)` and
some `c` that is not a square modulo 7. -/
theorem five_le_localBound_of_isSquare [NumberField F] {a b c : ℕ} (ha : IsSquare (a : F)) (h8 : a % 8 = 7)
    (hb : IsSquare (b : F)) (h3 : b % 3 = 2) (hc : IsSquare (c : F)) (h7 : c % 7 = 3 ∨ c % 7 = 5 ∨ c % 7 = 6) :
    5 ≤ localBound F :=
  le_iInf fun P => five_le_chromaticNumber_of_isSquare P ha h8 hb h3 hc h7

variable (F) in
/-- **D:116's class**: `L(F) ≥ 5` when `F` holds `√d`, `d ≡ 47, 143, 167 (mod 168)` — `d` is `7 (mod 8)`, `2 (mod 3)` and
a non-square modulo 7. -/
theorem five_le_localBound_of_isSquare_class [NumberField F] {d : ℕ} (hd : IsSquare (d : F))
    (hcl : d % 168 = 47 ∨ d % 168 = 143 ∨ d % 168 = 167) : 5 ≤ localBound F :=
  five_le_localBound_of_isSquare F hd (by omega) hd (by omega) hd (by omega)

variable (F) in
/-- **`χ(F²) ≥ 5`** for every real number field with `L(F) ≥ 5`, given `[AmbrusEtAl2023]` Theorem 1 as printed: the
chain's headline, whose row-99 hypothesis is idle there. -/
theorem five_le_chromaticNumber_planeOver_of_five_le_localBound [NumberField F] (hOA : Plane.OneAvoidingDensityBound)
    (h5 : 5 ≤ localBound F) : 5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  have h := min_localBound_five_le_chromaticNumber F hOA fun h4 => absurd (h5.trans h4) (by decide)
  rwa [min_eq_right h5] at h

/-! ## Spec -/

-- The class: `47`, `143`, `167`, `311`, `335` are in it, and `d ≡ 7 (mod 8)`, `2 (mod 3)`, non-square mod 7 there.
example : ∀ d ∈ ([47, 143, 167, 311, 335] : List ℕ), d % 168 = 47 ∨ d % 168 = 143 ∨ d % 168 = 167 := by decide
example (d : ℕ) (hd : d % 168 = 47 ∨ d % 168 = 143 ∨ d % 168 = 167) :
    d % 8 = 7 ∧ d % 3 = 2 ∧ (d % 7 = 3 ∨ d % 7 = 5 ∨ d % 7 = 6) := by
  omega
-- `(47 + 1)/4 = 12` is even, and `47` is no square modulo 3 or 7.
example : (47 + 1) / 4 = 12 ∧ ∀ c < 3, c * c % 3 ≠ 47 % 3 := by decide
example : ∀ c < 7, c * c % 7 ≠ 47 % 7 := by decide

end

end HadwigerNelson.Rigidity
