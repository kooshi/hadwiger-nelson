import Proofs.HadwigerNelson.Arith.UpperHalf
import Proofs.HadwigerNelson.Arith.QuadraticPrime
import Proofs.HadwigerNelson.Instances.SqrtEleven
import Proofs.HadwigerNelson.Instances.SqrtOneSixSeven
import Proofs.HadwigerNelson.Instances.SqrtFortySeven
import Proofs.HadwigerNelson.Instances.PlaneFreedom
import Proofs.HadwigerNelson.Instances.FinitePlane11
import Proofs.HadwigerNelson.CayleyCertificate

/-!
# The values the residue upper half closes (FS-131, NF1-MODULE)

Claims: `data/fs131/claims-NF1.md` (NF1-MODULE). Plan: `plans/FS131-KN2-upper-half-plan.md`.

**Read aloud.** For a finite set `D` of naturals each a nonzero square modulo a prime `p ≡ 3 (mod 4)`, the plane over
`ℚ(√D)` is `k`-colourable whenever `UD(𝔽_p, 2)` is (`colorable_planeOver_fieldOfRadicands`: a degree-one prime above `p`
from `Arith/QuadraticPrime`, then the residue homomorphism of `Arith/UpperHalf`). Its instances:

* **`χ(ℚ(√11)²) = 4`** (`chromaticNumber_planeOver_eleven`): the upper half at `p = 7` (`11 ≡ 2²`) with
  `finitePlane7_colorable_four`; the lower half is `four_le_chromaticNumber_planeOver_eleven` (`LEDGER.md` row 73). The
  upper bound is `[Fischer1990]`'s; the kernel proof of both halves is what is here.
* **`χ(ℚ(√167)²) ≤ 8`** (`chromaticNumber_planeOver_sqrt167_le_eight`): `p = 23` (`167 ≡ 11²`) with
  `CayleyCert.colorable_finitePlane23_eight`.
* **`χ(ℚ(√47)²) ≤ 5` again** (`chromaticNumber_planeOver_sqrt47_le_five_of_prime`): `p = 11` (`47 ≡ 5²`) with
  `chromaticNumber_finitePlane11` — the control against `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five`, which
  reaches the same statement with no ring of integers.
* **`χ(ℚ²) = 2`** (`chromaticNumber_planeOver_rat`; Woodall's value): the two-colour theorem at the stable prime of `ℚ(i)`
  above `2` (`exists_stablePrime_rat`), and one unit edge.

**Not claimed:** that any of these values is new mathematics (`LEDGER.md` § The claim list).
-/

namespace HadwigerNelson.UpperHalf

open HadwigerNelson HadwigerNelson.Arith HadwigerNelson.SpectralChain HadwigerNelson.SquareClass SimpleGraph NumberField

/-- **A colouring of a finite plane colours the plane over a field of square roots**: `D` finite, every radicand a nonzero
square modulo the prime `p ≡ 3 (mod 4)`. -/
theorem colorable_planeOver_fieldOfRadicands (D : Set ℕ) [Finite D] {p : ℕ} (hp : p.Prime) (hp4 : p % 4 = 3)
    (hD : ∀ d ∈ D, (d : ZMod p) ≠ 0 ∧ IsSquare (d : ZMod p)) {k : ℕ} (hk : (finitePlane p).Colorable k) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands D))).Colorable k := by
  obtain ⟨𝔭, hmax, hcard⟩ := QuadraticPrime.exists_maximal_card_eq D hp (by rintro rfl; omega) hD
  exact colorable_planeOver_of_finitePlane _ ⟨hmax, by rw [hcard]; exact hp4⟩ hp hcard hk

/-- **`χ(ℚ(√11)²) = 4`**: the residue plane at 7 above, the certified lower bound below. -/
theorem chromaticNumber_planeOver_eleven :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).chromaticNumber = 4 :=
  le_antisymm
    (colorable_planeOver_fieldOfRadicands {11} (p := 7) (by norm_num) (by norm_num)
      (by rintro d rfl; exact ⟨by decide, ⟨2, by decide⟩⟩) finitePlane7_colorable_four).chromaticNumber_le
    four_le_chromaticNumber_planeOver_eleven

/-- **`χ(ℚ(√167)²) ≤ 8`**: the residue plane at 23. -/
theorem chromaticNumber_planeOver_sqrt167_le_eight :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {167}))).chromaticNumber ≤ 8 :=
  (colorable_planeOver_fieldOfRadicands {167} (p := 23) (by norm_num) (by norm_num)
    (by rintro d rfl; exact ⟨by decide, ⟨11, by decide⟩⟩) CayleyCert.colorable_finitePlane23_eight).chromaticNumber_le

/-- **`χ(ℚ(√47)²) ≤ 5`, through the prime above 11** — the control: the same statement as
`SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five`, by the general route. -/
theorem chromaticNumber_planeOver_sqrt47_le_five_of_prime :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {47}))).chromaticNumber ≤ 5 :=
  (colorable_planeOver_fieldOfRadicands {47} (p := 11) (by norm_num) (by norm_num)
    (by rintro d rfl; exact ⟨by decide, ⟨5, by decide⟩⟩)
    (chromaticNumber_le_iff_colorable.mp chromaticNumber_finitePlane11.le)).chromaticNumber_le

/-! ## `ℚ` -/

/-- `ℚ ⊂ ℝ`, the least subfield, is a number field. -/
theorem numberField_bot : NumberField (⊥ : Subfield ℝ) := by
  sorry

/-- The instance the statements about `𝓞 (ℚ(i))` read; global and named (`LEAN.md` § The gate). -/
instance instNumberFieldBot : NumberField (⊥ : Subfield ℝ) := numberField_bot

/-- **Every plane over a field needs two colours**: `0` and `1` are a unit apart. -/
theorem two_le_chromaticNumber_planeOver (F : Subfield ℝ) :
    2 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  sorry

/-- **The stable prime of `ℚ(i)` above 2**: a maximal ideal of `𝓞 (ℚ(i))` holding `2`, fixed by conjugation, modulo which
conjugation is the identity (the ideal `(1 + i)`; `x̄ − x = −2·Im(x)·i` and `Im(x) ∈ ℤ` for an integer `x` of `ℚ(i)`). The
inhabitant of `StablePrime` and of `colorable_two_planeOver_of_ramified`'s hypothesis. -/
theorem exists_stablePrime_rat :
    ∃ P : StablePrime (⊥ : Subfield ℝ), (2 : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P.P ∧
      ∀ x : 𝓞 (fieldI (⊥ : Subfield ℝ)), conjO ⊥ x - x ∈ P.P := by
  sorry

/-- **`χ(ℚ²) = 2`** (Woodall's value): two colours from the ramified stable prime above 2, and one unit edge. -/
theorem chromaticNumber_planeOver_rat : ((unitDistance ℂ).induce (planeOver ⊥)).chromaticNumber = 2 :=
  le_antisymm
    (let ⟨P, _, hram⟩ := exists_stablePrime_rat
     (colorable_two_planeOver_of_ramified P hram).chromaticNumber_le)
    (two_le_chromaticNumber_planeOver ⊥)

/-! ## Spec -/

-- The upper half at `ℚ`: `χ(ℚ²) ≤ L(ℚ)`, and `L(ℚ)` is a number (a stable prime exists).
example : ((unitDistance ℂ).induce (planeOver ⊥)).chromaticNumber ≤ localBound ⊥ :=
  chromaticNumber_planeOver_le_localBound ⊥

example : Nonempty (StablePrime (⊥ : Subfield ℝ)) := let ⟨P, _⟩ := exists_stablePrime_rat; ⟨P⟩

-- A usable prime, exhibited: `ℚ(√11)` at 7.
example : ∃ 𝔭 : Ideal (𝓞 (fieldOfRadicands {11})), IsUsablePrime 𝔭 ∧ Nat.card (𝓞 (fieldOfRadicands {11}) ⧸ 𝔭) = 7 :=
  let ⟨𝔭, hmax, hcard⟩ := QuadraticPrime.exists_maximal_card_eq {11} (p := 7) (by norm_num) (by norm_num)
    (by rintro d rfl; exact ⟨by decide, ⟨2, by decide⟩⟩)
  ⟨𝔭, ⟨hmax, by rw [hcard]⟩, hcard⟩

end HadwigerNelson.UpperHalf
