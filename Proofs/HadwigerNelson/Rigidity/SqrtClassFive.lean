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

/-- **A level-one ratio below `1/4` needs five colours**: the colour classes of a four-colouring are independent and one
holds at least a quarter of the residue ring. -/
theorem five_le_chromaticNumber_of_ratioAtMost [NumberField F] (P : StablePrime F) {c : ℝ} (hc : c < 1 / 4)
    (h : RatioAtMost P c) : 5 ≤ (levelTarget P 1).chromaticNumber := by
  sorry

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
  sorry

-- `i` is an integer of `F(i)` with `ī = −i` (the same fact is private in `Arith/UpperHalf` and `Rigidity/ClassRatio`).
private theorem exists_I_integer : ∃ i : 𝓞 (fieldI F), i ^ 2 = -1 ∧ conjO F i = -i := by
  sorry

-- `ω = (1 + i√a)/2` is an integer of `F(i)` when `a ≡ 3 (mod 4)`, with `ω(1 − ω) = (a + 1)/4` and `ω̄ = 1 − ω`.
private theorem exists_omega_integer {a : ℕ} (ha : IsSquare (a : F)) (h4 : a % 4 = 3) :
    ∃ w : 𝓞 (fieldI F), w * (1 - w) = (((a + 1) / 4 : ℕ) : 𝓞 (fieldI F)) ∧ conjO F w = 1 - w := by
  sorry

/-! ### The stable primes -/

/-- **No stable prime above 2 when some `a ≡ 7 (mod 8)` is a square in `F`**. -/
theorem two_notMem_of_isSquare (P : StablePrime F) {a : ℕ} (ha : IsSquare (a : F)) (h8 : a % 8 = 7) :
    (2 : 𝓞 (fieldI F)) ∉ P.P := by
  sorry

/-- **An odd stable prime and its residue field**: `Q²` elements with `Q = pⁿ ≡ 3 (mod 4)`, `n` odd, and every natural
number that is a square in `F` a square modulo `p`. -/
theorem stablePrime_card_of_two_notMem [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) :
    ∃ p n : ℕ, p.Prime ∧ p % 4 = 3 ∧ Odd n ∧ Nat.card (𝓞 (fieldI F) ⧸ P.P) = (p ^ n) ^ 2 ∧
      ∀ d : ℕ, IsSquare (d : F) → IsSquare (d : ZMod p) := by
  sorry

/-- **Every stable prime's level-one target needs five colours** when `F` holds square roots of some `a ≡ 7 (mod 8)`,
some `b ≡ 2 (mod 3)` and some `c` that is not a square modulo 7. -/
theorem five_le_chromaticNumber_of_isSquare [NumberField F] (P : StablePrime F) {a b c : ℕ} (ha : IsSquare (a : F))
    (h8 : a % 8 = 7) (hb : IsSquare (b : F)) (h3 : b % 3 = 2) (hc : IsSquare (c : F))
    (h7 : c % 7 = 3 ∨ c % 7 = 5 ∨ c % 7 = 6) : 5 ≤ (levelTarget P 1).chromaticNumber := by
  sorry

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
