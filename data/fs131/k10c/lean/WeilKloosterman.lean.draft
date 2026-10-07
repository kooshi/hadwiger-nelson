import Proofs.HadwigerNelson.Arith.TargetFloors
import Mathlib.Analysis.SpecialFunctions.Complex.CircleAddChar

/-!
# Weil's bound for Kloosterman sums, imported; and the finite-target floor on it (FS-131 wave 10, third pass)

**The one outside theorem of wave 10.** `StandingFive.kloosterman_bound` is an `axiom`: the second displayed inequality of
`[Weil1948]` p. 207, in the page's own form. Everything between it and the floor is kernel-checked: the passage to the
hypothesis `KloostermanBound F` the floor's modules were proved over (`kloostermanBound_of_ringChar_ne_two`), the
completion from a circle sum to a Kloosterman sum (`Arith/FloorPlanes`), the norm-one set of `𝔽_{Q²}` as a circle
(`Arith/NormOneTarget`), the ratio bound (`Arith/RatioBound`), and the target at 128 (`Arith/Floor128`, no outside theorem).

**Read aloud, against the page** (the read-back, clause by clause, is `plans/FS131-w10-kernel-plan.md` Stage 12).
`[Weil1948]`, p. 204: "Let `k` be a finite field of `q` elements"; p. 206: "where `ψ` is a character of the additive group of
`k`, not everywhere equal to 1 … If the characteristic `p` of `k` is not 2, we have `d = 2` for `R_𝔡(t) = t² − a`, `a ≠ 0`;
hence, in that case," p. 207: "`|Σψ(x)χ(x² − a)| ≤ 2√q`. If, in this, we take for `χ` the character of `k*` of order 2 …, an
elementary transformation shows that the sum in the left-hand side is identical with the so-called Kloosterman sum
`Σψ(cx + dx⁻¹)`, for `4cd = a`; hence `|Σ_{x≠0} ψ(cx + dx⁻¹)| ≤ 2√q`". The axiom is that sentence: a finite field of
characteristic not 2, an additive character with a value other than 1, `4cd = a ≠ 0`, the sum over `x ≠ 0`, the bound `2√q`
with `q` the number of elements. Prime powers are inside it (the page's prime case is displayed after it, as a special case).

**What the axiom does not say.** Nothing at characteristic 2 (the page's hypothesis; the floor reads the bound only at
fields of `q ≡ 3 (mod 4)` elements); nothing when `c = 0` or `d = 0` (`4cd = a ≠ 0` forces both non-zero in odd
characteristic: `four_mul_mul_ne_zero_iff`); nothing for the trivial character.

**Inhabitant of its hypotheses, where its conclusion is a theorem** (`kloosterman_bound_model`): the field `ZMod 3`, the
standard character, `c = d = a = 1` satisfy every hypothesis, and there the conclusion holds with no axiom (two terms of
absolute value 1 against `2√3`). Exact arithmetic checks the sentence at every character and every pair `c, d ≠ 0` of the
fields of 3, 5, 7, 9, 11, 13, 25, 27 and 49 elements (`tools/fs131_k10c_kloosterman.py`, no floats; [tools]).

**The floor, on the import alone.** `standingFloor_seven_weil : StandingFloor 7`, `seven_le_localBound_weil`
(TC1-STANDING-FIVE's "so `L(F) ≥ 7`"), `five_le_chromaticNumber_weil` (its MR clause, over row 123's chain as a named
hypothesis), the planes' floors `targetFloor_seven_weil` (`Q ≥ 98`) and `targetFloor_six_weil` (`Q ≥ 62`), and the
circle-sum bound `circle_sum_le_weil` (`[MMST1996]` Theorem 3 at `n = 2`, with the condition its print omits). Each rests on
the standard three axioms and `StandingFive.kloosterman_bound`, nothing else.
-/

namespace HadwigerNelson.StandingFive

open Finset

/-- **IMPORTED: Weil's bound for Kloosterman sums over a finite field of odd characteristic** — `[Weil1948]` (A. Weil, *On
some exponential sums*, Proc. Nat. Acad. Sci. USA 34 (1948) 204–207; the note has no sections), **p. 207, the second
displayed inequality**, with its hypotheses from p. 204 (last two lines: `k` a finite field of `q` elements) and p. 206
(last five lines: `ψ` a character of the additive group of `k`, not everywhere equal to 1; the characteristic not 2;
`a ≠ 0`), and `4cd = a` from p. 207: `|Σ_{x≠0} ψ(cx + dx⁻¹)| ≤ 2√q`.

Read back against the page's wording in `plans/FS131-w10-kernel-plan.md` Stage 12 (FS131-K10c); a model of the hypotheses
is `kloosterman_bound_model` below; declared in `ARCHITECTURE.md` § Trust. `[DecidableEq F]` only forms the range of
summation and carries no content. -/
axiom kloosterman_bound.{u} (F : Type u) [Field F] [Fintype F] [DecidableEq F] (hp : ringChar F ≠ 2)
    (ψ : AddChar F ℂ) (hψ : ∃ x, ψ x ≠ 1) (c d a : F) (h4 : 4 * c * d = a) (ha : a ≠ 0) :
    ‖∑ x ∈ univ.filter (fun x : F => x ≠ 0), ψ (c * x + d * x⁻¹)‖ ≤ 2 * Real.sqrt (Fintype.card F)

/-! ### The page's form against `KloostermanBound` (no axiom below this line until `kloostermanBound_of_ringChar_ne_two`) -/

/-- A sum over the units of a field is the sum over its non-zero elements. -/
theorem sum_units_eq_sum_ne_zero {F M : Type*} [Field F] [Fintype F] [DecidableEq F] [AddCommMonoid M] (g : F → M) :
    ∑ x : Fˣ, g (x : F) = ∑ x ∈ univ.filter (fun x : F => x ≠ 0), g x := by
  rw [Finset.sum_subtype (univ.filter fun x : F => x ≠ 0) (p := fun x => x ≠ 0) (by simp) g]
  exact Fintype.sum_equiv unitsEquivNeZero _ _ fun _ => rfl

/-- **The page's condition on the coefficients is the Lean statement's**: in characteristic not 2, `4cd ≠ 0` exactly when
`c ≠ 0` and `d ≠ 0`. -/
theorem four_mul_mul_ne_zero_iff {F : Type*} [Field F] (hp : ringChar F ≠ 2) (c d : F) :
    4 * c * d ≠ 0 ↔ c ≠ 0 ∧ d ≠ 0 := by
  have h2 : (2 : F) ≠ 0 := Ring.two_ne_zero hp
  have h4 : (4 : F) ≠ 0 := by
    have : (4 : F) = 2 * 2 := by norm_num
    rw [this]
    exact mul_ne_zero h2 h2
  constructor
  · intro h
    refine ⟨fun hc => h (by rw [hc]; ring), fun hd => h (by rw [hd]; ring)⟩
  · rintro ⟨hc, hd⟩
    exact mul_ne_zero (mul_ne_zero h4 hc) hd

/-- **The page's sentence follows from `KloostermanBound`** (no axiom): the hypothesis the floor's modules were proved
over loses nothing of `[Weil1948]` p. 207 in characteristic not 2. With `kloostermanBound_of_ringChar_ne_two` the two forms
are equivalent there. -/
theorem kloosterman_page_of_kloostermanBound {F : Type*} [Field F] [Fintype F] [DecidableEq F] (hK : KloostermanBound F)
    (hp : ringChar F ≠ 2) (ψ : AddChar F ℂ) (hψ : ∃ x, ψ x ≠ 1) (c d a : F) (h4 : 4 * c * d = a) (ha : a ≠ 0) :
    ‖∑ x ∈ univ.filter (fun x : F => x ≠ 0), ψ (c * x + d * x⁻¹)‖ ≤ 2 * Real.sqrt (Fintype.card F) := by
  obtain ⟨hc, hd⟩ := (four_mul_mul_ne_zero_iff hp c d).mp (h4 ▸ ha)
  have h := hK ψ (AddChar.ne_one_iff.mpr hψ) c d hc hd
  rw [← sum_units_eq_sum_ne_zero fun x : F => ψ (c * x + d * x⁻¹)]
  simpa only [Units.val_inv_eq_inv_val] using h

/-- **A model of the import's hypotheses, where its conclusion is a theorem with no axiom**: the field of three elements,
its standard character, `c = d = a = 1`. Every hypothesis of `kloosterman_bound` holds there, and so does its conclusion,
by `kloostermanBound_of_card_le_five`. -/
theorem kloosterman_bound_model :
    ringChar (ZMod 3) ≠ 2 ∧ (∃ x : ZMod 3, ZMod.stdAddChar (N := 3) x ≠ 1) ∧ (4 * 1 * 1 = (1 : ZMod 3)) ∧
      (1 : ZMod 3) ≠ 0 ∧
      ‖∑ x ∈ univ.filter (fun x : ZMod 3 => x ≠ 0), ZMod.stdAddChar (N := 3) (1 * x + 1 * x⁻¹)‖ ≤
        2 * Real.sqrt (Fintype.card (ZMod 3)) := by
  have hp : ringChar (ZMod 3) ≠ 2 := by
    rw [ZMod.ringChar_zmod_n]
    norm_num
  have hψ : ∃ x : ZMod 3, ZMod.stdAddChar (N := 3) x ≠ 1 :=
    ⟨1, fun h => by
      have h0 : ZMod.stdAddChar (N := 3) 1 = ZMod.stdAddChar (N := 3) 0 := by rw [h, AddChar.map_zero_eq_one]
      exact absurd (ZMod.injective_stdAddChar h0) (by decide)⟩
  have h4 : 4 * 1 * 1 = (1 : ZMod 3) := by decide
  have h1 : (1 : ZMod 3) ≠ 0 := by decide
  exact ⟨hp, hψ, h4, h1,
    kloosterman_page_of_kloostermanBound (kloostermanBound_of_card_le_five (by rw [ZMod.card]; norm_num)) hp _ hψ 1 1 1
      h4 h1⟩

/-! ### From the import to the hypothesis the floor was proved over -/

/-- **`KloostermanBound F` at every finite field of characteristic not 2** — from the import, `[Weil1948]` p. 207. -/
theorem kloostermanBound_of_ringChar_ne_two (F : Type*) [Field F] [Fintype F] [DecidableEq F] (hp : ringChar F ≠ 2) :
    KloostermanBound F := by
  intro ψ hψ a b ha hb
  have h := kloosterman_bound F hp ψ (AddChar.ne_one_iff.mp hψ) a b (4 * a * b) rfl
    ((four_mul_mul_ne_zero_iff hp a b).mpr ⟨ha, hb⟩)
  rw [← sum_units_eq_sum_ne_zero fun x : F => ψ (a * x + b * x⁻¹)] at h
  simpa only [Units.val_inv_eq_inv_val] using h

/-- A finite field with `q ≡ 3 (mod 4)` elements has characteristic not 2. -/
theorem ringChar_ne_two_of_card_mod_four {F : Type*} [Field F] [Fintype F] (h : Fintype.card F % 4 = 3) :
    ringChar F ≠ 2 := by
  intro h2
  have := FiniteField.even_card_of_char_two h2
  omega

/-! ### The floors, on the import alone -/

/-- **The planes' floor at seven** (G56's "every usable plane refuses six by Weil from 98"): for `Q ≡ 3 (mod 4)`, `Q ≥ 98`,
every field of `Q²` elements with a non-trivial involution has a level-one target needing 7 colours. Rests on the import. -/
theorem targetFloor_seven_weil {Q : ℕ} (hQ4 : Q % 4 = 3) (hQ : 98 ≤ Q) : TargetFloor 7 Q :=
  targetFloor_seven_of_kloosterman hQ4 hQ fun F _ _ _ hF =>
    kloostermanBound_of_ringChar_ne_two F (ringChar_ne_two_of_card_mod_four (by rw [hF]; exact hQ4))

/-- **The planes' floor at six, over `KloostermanBound`**: `1 + (Q + 1)/(2√Q) > 5` exactly when `Q ≥ 62` (`[Weil1948]`'s
row in `BIBLIOGRAPHY.md`: "`> 5` for `p ≥ 62` with no computation"). -/
theorem targetFloor_six_of_kloosterman {Q : ℕ} (hQ4 : Q % 4 = 3) (hQ : 62 ≤ Q)
    (hK : ∀ (F : Type) [Field F] [Fintype F] [DecidableEq F], Fintype.card F = Q → KloostermanBound F) :
    TargetFloor 6 Q := by
  have hQr : (62 : ℝ) ≤ Q := by exact_mod_cast hQ
  have hs : Real.sqrt Q < ((Q : ℝ) + 1) / 8 := by
    rw [Real.sqrt_lt' (by linarith)]
    nlinarith [mul_nonneg (show (0 : ℝ) ≤ Q by linarith) (show (0 : ℝ) ≤ (Q : ℝ) - 62 by linarith)]
  refine targetFloor_of_charSum 6 Q (m := 2 * Real.sqrt Q)
    (mul_pos two_pos (Real.sqrt_pos.mpr (by linarith))) ?_
    fun k _ _ _ hcard ψ hψ => normOne_charSum_ge hQ4 hcard hK ψ hψ
  norm_num
  linarith

/-- **The planes' floor at six**, for `Q ≡ 3 (mod 4)`, `Q ≥ 62`. Rests on the import. -/
theorem targetFloor_six_weil {Q : ℕ} (hQ4 : Q % 4 = 3) (hQ : 62 ≤ Q) : TargetFloor 6 Q :=
  targetFloor_six_of_kloosterman hQ4 hQ fun F _ _ _ hF =>
    kloostermanBound_of_ringChar_ne_two F (ringChar_ne_two_of_card_mod_four (by rw [hF]; exact hQ4))

/-- **The circle-sum bound, on the import alone** — `[MMST1996]` Theorem 3 (p. 231) at `n = 2`, in the form that is true:
for a finite field of odd characteristic, a non-trivial `ψ` and `b ≠ 0`, `|Σ_{s₁² + s₂² = a} ψ(b₁s₁ + b₂s₂)| ≤ 2√q` whenever
`a ≠ 0` or `b` is anisotropic. (The printed theorem omits the condition; where both fail the sum is `q − 1`:
`circle_sum_zero_of_isotropic`, `two_sqrt_lt_circle_sum_zero`.) -/
theorem circle_sum_le_weil {F : Type*} [Field F] [Fintype F] [DecidableEq F] (hodd : ringChar F ≠ 2) (ψ : AddChar F ℂ)
    (hψ : ψ ≠ 1) (a : F) (b : F × F) (hb : b ≠ 0) (h : a ≠ 0 ∨ b.1 ^ 2 + b.2 ^ 2 ≠ 0) :
    ‖∑ s ∈ univ.filter (fun s : F × F => s.1 ^ 2 + s.2 ^ 2 = a), ψ (b.1 * s.1 + b.2 * s.2)‖ ≤
      2 * Real.sqrt (Fintype.card F) :=
  circle_sum_le_of_ne hodd (kloostermanBound_of_ringChar_ne_two F hodd) ψ hψ a b hb h

/-- **The finite-target floor at seven** — `χ(U₁₂₈) ≥ 7` (no outside theorem) and `χ(Γ_Q) ≥ 7` for every `Q ≡ 3 (mod 4)`,
`Q ≥ 347` (the import). `StandingFive.StandingFloor 7`, the hypothesis TC1-STANDING-FIVE's "so `L(F) ≥ 7`" hid, with no
hypothesis left. -/
theorem standingFloor_seven_weil : StandingFloor 7 :=
  standingFloor_seven fun F _ _ _ h4 _ => kloostermanBound_of_ringChar_ne_two F (ringChar_ne_two_of_card_mod_four h4)

/-- The floor at five, the form `five_le_chromaticNumber` reads. Rests on the import. -/
theorem standingFloor_five_weil : StandingFloor 5 :=
  standingFloor_five fun F _ _ _ h4 _ => kloostermanBound_of_ringChar_ne_two F (ringChar_ne_two_of_card_mod_four h4)

/-- **TC1-STANDING-FIVE, "so `L(F) ≥ 7`"** for `F = K·E₇`: every level-one residue target of the standing field needs at
least seven colours. Rests on the standard three axioms and the import `kloosterman_bound`. -/
theorem seven_le_localBound_weil : 7 ≤ SpectralChain.localBound standingField :=
  seven_le_localBound standingFloor_seven_weil

/-- **TC1-STANDING-FIVE, "and given MR, `χ(F²) ≥ 5`"**: from the floor and row 123's chain (`hRow123`, the conclusion of
`SpectralChain.min_localBound_five_le_chromaticNumber`, a named hypothesis from outside the backlog; MR is inside it and is
never imported here). Rests on the import. -/
theorem five_le_chromaticNumber_weil
    (hRow123 : min (SpectralChain.localBound standingField) 5 ≤
      ((unitDistance ℂ).induce (planeOver standingField)).chromaticNumber) :
    5 ≤ ((unitDistance ℂ).induce (planeOver standingField)).chromaticNumber :=
  five_le_chromaticNumber standingFloor_five_weil hRow123

/-! ## Spec -/

-- the import's consequence at the model is the theorem already held there: `KloostermanBound (ZMod 3)`.
example : KloostermanBound (ZMod 3) :=
  kloostermanBound_of_ringChar_ne_two (ZMod 3) kloosterman_bound_model.1

-- the page's condition bites: with `c = 0` the "Kloosterman sum" is `Σ_{x≠0} ψ(d/x) = −1`, outside the axiom's range,
-- and `four_mul_mul_ne_zero_iff` refuses it.
example (F : Type*) [Field F] (hp : ringChar F ≠ 2) (d : F) : ¬ (4 * (0 : F) * d ≠ 0) := fun h =>
  ((four_mul_mul_ne_zero_iff hp 0 d).mp h).1 rfl

-- the threshold of the floor at six is sharp for the argument: at `Q = 61`, `8·√61 > 62`.
example : (61 : ℝ) + 1 < 8 * Real.sqrt 61 := by
  have h : (7.76 : ℝ) < Real.sqrt 61 := by
    rw [Real.lt_sqrt (by norm_num)]
    norm_num
  linarith

-- the floor at six at the least usable plane it covers that the floor at seven does not: `Q = 67 ≡ 3 (mod 4)`.
example : TargetFloor 6 67 := targetFloor_six_weil (by norm_num) (by norm_num)

end HadwigerNelson.StandingFive
