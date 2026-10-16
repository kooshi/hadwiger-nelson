import Proofs.HadwigerNelson.Rigidity.SqrtClassFive

/-!
# CLS in full: the stable places whose level-one target is four-colourable (FS-131, job FS131-KCS1; skeleton)

**Read aloud, against the informal claim** (`LEDGER.md` row 123; FS100-CLS: "every stable place has `r_v < 1/4` ⟺ no
stable level-one target has `χ ≤ 4` ⟺ `L(F) ≥ 5` (level-one or all-levels reading of `L`). The places with `r_v ≥ 1/4` are
exactly `q ∈ {3, 7}`, dyadic inert `Q ≤ 32`, and dyadic ramified in `L/F`"). For a real number field `F` and a stable prime
`P` of `F(i)`:

* `IsFourColourPlace P` — **the list**: `P` is ramified over `F` (conjugation trivial on `𝓞 ⧸ P`; such a `P` is dyadic,
  `UpperHalf.two_mem_of_conj_trivial`), or `|𝓞 ⧸ P| = Q²` with `Q ∈ {2, 3, 4, 7, 8, 16, 32}`. At an unramified stable
  prime `Q` is the size of `F`'s residue field (the fixed field of conjugation), so `Q ∈ {3, 7}` is "residue field `𝔽₃` or
  `𝔽₇`" and `Q = 2^f ≤ 32` is "dyadic inert of norm at most 32".
* `colorable_four_levelTarget_one_iff` — **a level-one target is four-colourable exactly at the listed places**;
  `exists_ratioAtMost_lt_quarter_iff` — **the all-levels ratio is below `1/4` exactly off the list**.
* `five_le_localBound_iff`, `tca_iff_forall_not_isFourColourPlace` — **CLS, field form**: `L(F) ≥ 5` ⟺ T-C(A) at `S = ∅`
  ⟺ no stable place is listed.
* `localBoundAllLevels`, `five_le_localBoundAllLevels_iff`, `min_localBoundAllLevels_five` — **the all-levels reading of
  `L`** agrees with the library's level-one `localBound` from five down.

**Not claimed:** anything at six colours; that the list is new mathematics (FS100-CLS: the real-quadratic case is row 117,
the general statement not found in print by X24R, who did not search it by name).

**Inhabitants.** `StablePrime` is inhabited at `ℚ` (`UpperHalf.exists_stablePrime_rat`, ramified, so listed) and at
`ℚ(√47)` above 11 (`SqrtFortySeven.exists_stablePrime_eleven`, `|𝓞 ⧸ P| = 11²`, not listed).
-/

namespace HadwigerNelson.Rigidity

open SpectralChain NumberField SimpleGraph

noncomputable section

variable {F : Subfield ℝ}

/-- **The places CLS lists** (FS100-CLS): `P` ramified over `F`, or `|𝓞 (F(i)) ⧸ P| = Q²` with
`Q ∈ {2, 3, 4, 7, 8, 16, 32}` — residue field `𝔽₃` or `𝔽₇`, or dyadic inert of norm at most 32. -/
def IsFourColourPlace (P : StablePrime F) : Prop :=
  IsRamified P ∨ ∃ Q ∈ ({2, 3, 4, 7, 8, 16, 32} : Finset ℕ), Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2

-- A four-colourable graph does not need five colours.
private theorem not_five_le_of_colorable_four {V : Type*} {G : SimpleGraph V} (h : G.Colorable 4) :
    ¬ 5 ≤ G.chromaticNumber := fun h5 => absurd (h5.trans h.chromaticNumber_le) (by norm_num)

-- A stable prime that is not ramified is moved by conjugation somewhere.
private theorem exists_conj_sub_notMem_of_not_isRamified {P : StablePrime F} (h : ¬ IsRamified P) :
    ∃ a : 𝓞 (fieldI F), conjO F a - a ∉ P.P := by
  by_contra hcon
  push Not at hcon
  exact h hcon

/-- **A listed place has a four-colourable level-one target**: two colours when ramified
(`colorable_two_levelTarget_one_of_isRamified`), `Γ₃`, `Γ₇` at `Q ∈ {3, 7}`, `U_Q` at `Q = 2^f ≤ 32`. -/
theorem colorable_four_levelTarget_one_of_isFourColourPlace [NumberField F] (P : StablePrime F)
    (h : IsFourColourPlace P) : (levelTarget P 1).Colorable 4 := by
  by_cases hram : IsRamified P
  · exact (colorable_two_levelTarget_one_of_isRamified hram).mono (by norm_num)
  obtain ⟨a, ha⟩ := exists_conj_sub_notMem_of_not_isRamified hram
  rcases h with h | ⟨Q, hQmem, hQ⟩
  · exact absurd h hram
  have hQmem' : Q = 2 ∨ Q = 3 ∨ Q = 4 ∨ Q = 7 ∨ Q = 8 ∨ Q = 16 ∨ Q = 32 := by simpa using hQmem
  rw [← chromaticNumber_le_iff_colorable]
  by_cases h2 : (2 : 𝓞 (fieldI F)) ∈ P.P
  · -- dyadic: `Q = 2^f` with `f ≤ 5`
    obtain ⟨f, hf⟩ := exists_card_two_pow_sq P h2 ha
    have hQf : Q = 2 ^ f := Nat.pow_left_injective two_ne_zero (hQ.symm.trans hf)
    have hf5 : f ≤ 5 := by
      by_contra hf6
      have h64 : 2 ^ 6 ≤ 2 ^ f := Nat.pow_le_pow_right (by norm_num) (by omega)
      omega
    exact_mod_cast chromaticNumber_le_four_dyadic P ha hf hf5
  · -- odd: `Q` is a power of an odd prime, so `Q ∈ {3, 7}`
    obtain ⟨p, n, hp, hp4, -, -, hcard, -⟩ := stablePrime_card_of_two_notMem P h2
    have hQp : Q = p ^ n := Nat.pow_left_injective two_ne_zero (hQ.symm.trans hcard)
    have hodd : Q % 2 = 1 := by
      rw [hQp, ← Nat.odd_iff]
      exact Odd.pow (Nat.odd_iff.2 (by omega))
    have hQ37 : Q = 3 ∨ Q = 7 := by omega
    exact_mod_cast chromaticNumber_le_four_of_small P h2 hQ hQ37

/-- **Off the list the all-levels ratio is below `1/4`**: odd by `ratioAtMost_of_two_notMem`, dyadic inert with
`Q = 2^f ≥ 64` by the large-dyadic branch of `ClassRatio`. -/
theorem exists_ratioAtMost_of_not_isFourColourPlace [NumberField F] (P : StablePrime F)
    (h : ¬ IsFourColourPlace P) : ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := by
  by_cases h2 : (2 : 𝓞 (fieldI F)) ∈ P.P
  · obtain ⟨a, ha⟩ := exists_conj_sub_notMem_of_not_isRamified fun hr => h (Or.inl hr)
    obtain ⟨f, hf⟩ := exists_card_two_pow_sq P h2 ha
    by_cases hf6 : 6 ≤ f
    · exact ratioAtMost_dyadic_of_six_le P ha hf hf6
    exfalso
    rcases (show f = 0 ∨ (1 ≤ f ∧ f ≤ 5) by omega) with rfl | ⟨hf1, hf5⟩
    · -- one residue: not a field
      haveI : Finite (𝓞 (fieldI F) ⧸ P.P) := Ideal.finiteQuotientOfFreeOfNeBot _ P.heightOne.ne_bot
      haveI : Nontrivial (𝓞 (fieldI F) ⧸ P.P) := Ideal.Quotient.nontrivial_iff.2 P.isMaximal.ne_top
      have h1 := Finite.one_lt_card (α := 𝓞 (fieldI F) ⧸ P.P)
      rw [hf] at h1
      norm_num at h1
    · refine h (Or.inr ⟨2 ^ f, ?_, hf⟩)
      interval_cases f <;> decide
  · refine ratioAtMost_of_two_notMem P h2 (fun e => h (Or.inr ⟨3, by decide, e.trans (by norm_num)⟩))
      (fun e => h (Or.inr ⟨7, by decide, e.trans (by norm_num)⟩))

/-- **CLS per place, colour form**: the level-one target at a stable prime is four-colourable exactly when the place is
listed. -/
theorem colorable_four_levelTarget_one_iff [NumberField F] (P : StablePrime F) :
    (levelTarget P 1).Colorable 4 ↔ IsFourColourPlace P := by
  refine ⟨fun hc => ?_, colorable_four_levelTarget_one_of_isFourColourPlace P⟩
  by_contra h
  obtain ⟨c, hc4, hr⟩ := exists_ratioAtMost_of_not_isFourColourPlace P h
  exact not_five_le_of_colorable_four hc (five_le_chromaticNumber_of_ratioAtMost P hc4 hr)

/-- **CLS per place, ratio form**: the all-levels four-colour ratio is below `1/4` exactly off the list. -/
theorem exists_ratioAtMost_lt_quarter_iff [NumberField F] (P : StablePrime F) :
    (∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c) ↔ ¬ IsFourColourPlace P :=
  ⟨fun ⟨_, hc, hr⟩ hl => not_five_le_of_colorable_four (colorable_four_levelTarget_one_of_isFourColourPlace P hl)
      (five_le_chromaticNumber_of_ratioAtMost P hc hr),
    exists_ratioAtMost_of_not_isFourColourPlace P⟩

/-- **CLS per place, chromatic form**: the level-one target needs five colours exactly off the list. -/
theorem five_le_chromaticNumber_levelTarget_one_iff [NumberField F] (P : StablePrime F) :
    5 ≤ (levelTarget P 1).chromaticNumber ↔ ¬ IsFourColourPlace P :=
  ⟨fun h5 hl => not_five_le_of_colorable_four (colorable_four_levelTarget_one_of_isFourColourPlace P hl) h5,
    fun h => let ⟨_, hc, hr⟩ := exists_ratioAtMost_of_not_isFourColourPlace P h
      five_le_chromaticNumber_of_ratioAtMost P hc hr⟩

variable (F) in
/-- **CLS in full, field form** (row 123): `L(F) ≥ 5` exactly when no stable place of `F(i)` is listed — none has residue
field `𝔽₃` or `𝔽₇`, none is dyadic inert of norm at most 32, none is ramified over `F`. -/
theorem five_le_localBound_iff [NumberField F] :
    5 ≤ localBound F ↔ ∀ P : StablePrime F, ¬ IsFourColourPlace P :=
  (le_iInf_iff (f := fun P : StablePrime F => (levelTarget P 1).chromaticNumber)).trans
    (forall_congr' fun P => five_le_chromaticNumber_levelTarget_one_iff P)

variable (F) in
/-- **CLS in full, T-C(A) form**: T-C(A) at `S = ∅` exactly when no stable place is listed. -/
theorem tca_iff_forall_not_isFourColourPlace [NumberField F] :
    TCA F ↔ ∀ P : StablePrime F, ¬ IsFourColourPlace P :=
  (tca_iff_five_le_localBound F).trans (five_le_localBound_iff F)

/-! ### The all-levels reading of `L` -/

variable (F) in
/-- **`L(F)`, all-levels reading**: the least chromatic number among the residue targets `levelTarget P m`, every stable
prime `P` and every level `m ≥ 1`. The library's `localBound` reads level one (`CLAUDE.md` § Notation). -/
def localBoundAllLevels : ℕ∞ := ⨅ (P : StablePrime F) (m : ℕ) (_ : 1 ≤ m), (levelTarget P m).chromaticNumber

variable (F) in
/-- The all-levels bound is at most the level-one bound. -/
theorem localBoundAllLevels_le_localBound : localBoundAllLevels F ≤ localBound F :=
  le_iInf fun P => (iInf_le _ P).trans ((iInf_le _ 1).trans (iInf_le _ le_rfl))

variable (F) in
/-- **The upper half at every level**: `χ(F²) ≤ L_all(F)` (`UpperHalf.chromaticNumber_planeOver_le_levelTarget`). -/
theorem chromaticNumber_planeOver_le_localBoundAllLevels [NumberField F] :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ≤ localBoundAllLevels F :=
  le_iInf fun P => le_iInf fun _ => le_iInf fun hm => UpperHalf.chromaticNumber_planeOver_le_levelTarget P hm

/-- **A ratio below `1/4` needs five colours at every level** (`five_le_chromaticNumber_of_ratioAtMost` at level `m`). -/
theorem five_le_chromaticNumber_levelTarget_of_ratioAtMost [NumberField F] (P : StablePrime F) {c : ℝ}
    (hc : c < 1 / 4) (h : RatioAtMost P c) {m : ℕ} (hm : 1 ≤ m) : 5 ≤ (levelTarget P m).chromaticNumber := by
  classical
  haveI : Finite (𝓞 (fieldI F) ⧸ P.P ^ m) := Ideal.finiteQuotientOfFreeOfNeBot _ (pow_ne_zero m P.heightOne.ne_bot)
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ m) := Fintype.ofFinite _
  have hN : (0 : ℝ) < Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) := by
    haveI : Nonempty (𝓞 (fieldI F) ⧸ P.P ^ m) := ⟨0⟩
    exact_mod_cast Nat.card_pos
  -- the empty set is independent, so `c·N ≥ 0`
  have hcN : 0 ≤ c * Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) := by
    simpa using h m hm ∅ (by simp)
  have h4 : ¬ (levelTarget P m).Colorable 4 := by
    refine not_colorable_of_mul_lt (a := ⌊c * Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m)⌋₊)
      (fun s hs => Nat.le_floor (h m hm s hs)) ?_
    have hfl := Nat.floor_le hcN
    have hlt : ((4 * ⌊c * Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m)⌋₊ : ℕ) : ℝ) < Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ m) := by
      rw [← Nat.card_eq_fintype_card]
      push_cast
      nlinarith
    exact_mod_cast hlt
  exact_mod_cast (add_one_le_chromaticNumber_iff_not_colorable (n := 4)).mpr h4

variable (F) in
/-- **CLS's "level-one or all-levels reading"**: `L_all(F) ≥ 5` exactly when `L(F) ≥ 5`. -/
theorem five_le_localBoundAllLevels_iff [NumberField F] : 5 ≤ localBoundAllLevels F ↔ 5 ≤ localBound F := by
  refine ⟨fun h => h.trans (localBoundAllLevels_le_localBound F), fun h => ?_⟩
  have htca := tca_of_five_le_localBound F h
  refine le_iInf fun P => le_iInf fun _ => le_iInf fun hm => ?_
  obtain ⟨c, hc, hr⟩ := (tca_iff F).1 htca P
  exact five_le_chromaticNumber_levelTarget_of_ratioAtMost P hc hr hm

variable (F) in
/-- **The two readings of `L` agree through five**: `min(L_all(F), 5) = min(L(F), 5)`. Rests on the headline's two
declared outside theorems. -/
theorem min_localBoundAllLevels_five [NumberField F] : min (localBoundAllLevels F) 5 = min (localBound F) 5 :=
  le_antisymm (min_le_min_right 5 (localBoundAllLevels_le_localBound F))
    (le_min ((min_localBound_five_le_chromaticNumber F).trans (chromaticNumber_planeOver_le_localBoundAllLevels F))
      (min_le_right _ _))

/-! ## Spec -/

-- The list's residue sizes: `Q²` for `Q ∈ {2, 3, 4, 7, 8, 16, 32}`, and `11² = 121` is not among them.
example : (({2, 3, 4, 7, 8, 16, 32} : Finset ℕ).image (· ^ 2)) = {4, 9, 16, 49, 64, 256, 1024} := by decide
example : ∀ Q ∈ ({2, 3, 4, 7, 8, 16, 32} : Finset ℕ), Q ^ 2 ≠ 121 := by decide

end

end HadwigerNelson.Rigidity
