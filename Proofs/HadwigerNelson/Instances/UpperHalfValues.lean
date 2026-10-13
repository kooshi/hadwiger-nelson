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
  have h : fieldOfRadicands ∅ = ⊥ := by
    unfold fieldOfRadicands
    rw [Set.image_empty, Subfield.closure_empty]
  exact h ▸ QuadraticPrime.numberField_fieldOfRadicands Set.finite_empty

/-- The instance the statements about `𝓞 (ℚ(i))` read; global and named (`LEAN.md` § The gate). -/
instance instNumberFieldBot : NumberField (⊥ : Subfield ℝ) := numberField_bot

/-- **Every plane over a field needs two colours**: `0` and `1` are a unit apart. -/
theorem two_le_chromaticNumber_planeOver (F : Subfield ℝ) :
    2 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  have h0 : (0 : ℂ) ∈ planeOver F := ⟨by simp [zero_mem], by simp [zero_mem]⟩
  have h1 : (1 : ℂ) ∈ planeOver F := ⟨by simp [one_mem], by simp [zero_mem]⟩
  refine SimpleGraph.two_le_chromaticNumber_of_adj (u := ⟨0, h0⟩) (v := ⟨1, h1⟩) ?_
  show dist (0 : ℂ) 1 = 1
  simp

/-- A rational number that is an algebraic integer of `ℂ` is an integer (`ℤ` is integrally closed in `ℚ`). -/
private theorem exists_intCast_eq_of_isIntegral {q : ℚ} (h : IsIntegral ℤ (q : ℂ)) : ∃ n : ℤ, (n : ℚ) = q := by
  have h' : IsIntegral ℤ q :=
    (isIntegral_algebraMap_iff (R := ℤ) (A := ℚ) (B := ℂ) (algebraMap ℚ ℂ).injective).mp (by simpa using h)
  obtain ⟨n, hn⟩ := IsIntegrallyClosed.isIntegral_iff.mp h'
  exact ⟨n, by simpa using hn⟩

/-- **The real part of an integer of `ℚ(i)` is an integer.** For `z = a + bi` integral over `ℤ` with `a b : ℚ`:
`t = z + z̄ = 2a`, `s = (z̄ − z)·i = 2b` and `n = z·z̄ = a² + b²` are rational algebraic integers, so integers, and
`t² + s² = 4n` forces `t` even (squares are `0, 1` modulo 4). The half of `𝓞 (ℚ(i)) = ℤ[i]` that the stable prime above 2
reads. -/
private theorem exists_intCast_eq_re_of_isIntegral {z : ℂ} (hz : IsIntegral ℤ z) {a b : ℚ} (ha : z.re = a)
    (hb : z.im = b) : ∃ m : ℤ, (m : ℚ) = a := by
  have hzc : IsIntegral ℤ ((starRingEnd ℂ) z) := map_isIntegral_int (starRingEnd ℂ) hz
  have hI : IsIntegral ℤ Complex.I :=
    IsIntegral.of_pow (n := 2) (by norm_num) (by rw [Complex.I_sq]; exact isIntegral_one.neg)
  obtain ⟨t, ht⟩ := exists_intCast_eq_of_isIntegral (q := 2 * a) (by
    have e : ((2 * a : ℚ) : ℂ) = z + (starRingEnd ℂ) z := by
      rw [Complex.add_conj, ha]
      norm_cast
    rw [e]; exact hz.add hzc)
  obtain ⟨s, hs⟩ := exists_intCast_eq_of_isIntegral (q := 2 * b) (by
    have e : ((2 * b : ℚ) : ℂ) = ((starRingEnd ℂ) z - z) * Complex.I := by
      rw [← neg_sub, Complex.sub_conj, hb]
      push_cast
      linear_combination (2 * (b : ℂ)) * Complex.I_sq
    rw [e]; exact (hzc.sub hz).mul hI)
  obtain ⟨n, hn⟩ := exists_intCast_eq_of_isIntegral (q := a ^ 2 + b ^ 2) (by
    have e : ((a ^ 2 + b ^ 2 : ℚ) : ℂ) = z * (starRingEnd ℂ) z := by
      rw [Complex.mul_conj, Complex.normSq_apply, ha, hb]
      push_cast
      ring
    rw [e]; exact hz.mul hzc)
  have h4 : t ^ 2 + s ^ 2 = 4 * n := by
    have h : ((t ^ 2 + s ^ 2 : ℤ) : ℚ) = ((4 * n : ℤ) : ℚ) := by push_cast; rw [ht, hs, hn]; ring
    exact_mod_cast h
  obtain ⟨m, rfl | rfl⟩ := Int.even_or_odd' t
  · exact ⟨m, by push_cast at ht; linarith⟩
  · exfalso
    obtain ⟨k, rfl | rfl⟩ := Int.even_or_odd' s
    · have e : (2 * m + 1) ^ 2 + (2 * k) ^ 2 = 4 * (m ^ 2 + m + k ^ 2) + 1 := by ring
      omega
    · have e : (2 * m + 1) ^ 2 + (2 * k + 1) ^ 2 = 4 * (m ^ 2 + m + k ^ 2 + k) + 2 := by ring
      omega

/-- **The stable prime of `ℚ(i)` above 2**: a maximal ideal of `𝓞 (ℚ(i))` holding `2`, fixed by conjugation, modulo which
conjugation is the identity (the ideal `(1 + i)`; `x̄ − x = −2·Im(x)·i` and `Im(x) ∈ ℤ` for an integer `x` of `ℚ(i)`). The
inhabitant of `StablePrime` and of `colorable_two_planeOver_of_ramified`'s hypothesis. -/
theorem exists_stablePrime_rat :
    ∃ P : StablePrime (⊥ : Subfield ℝ), (2 : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P.P ∧
      ∀ x : 𝓞 (fieldI (⊥ : Subfield ℝ)), conjO ⊥ x - x ∈ P.P := by
  -- the least subfield of `ℝ` is the rationals
  have hbot : ∀ r : ℝ, r ∈ (⊥ : Subfield ℝ) → ∃ q : ℚ, (q : ℝ) = r := by
    intro r hr
    rw [Subfield.bot_eq_of_charZero] at hr
    obtain ⟨q, rfl⟩ := hr
    exact ⟨q, rfl⟩
  -- the real part of an integer of `ℚ(i)` is an integer
  have hre : ∀ x : 𝓞 (fieldI (⊥ : Subfield ℝ)), ∃ m : ℤ, (m : ℝ) = ((x : fieldI (⊥ : Subfield ℝ)) : ℂ).re := by
    intro x
    have hx : ((x : fieldI (⊥ : Subfield ℝ)) : ℂ).re ∈ (⊥ : Subfield ℝ) ∧
        ((x : fieldI (⊥ : Subfield ℝ)) : ℂ).im ∈ (⊥ : Subfield ℝ) := (x : fieldI (⊥ : Subfield ℝ)).2
    obtain ⟨a, ha⟩ := hbot _ hx.1
    obtain ⟨b, hb⟩ := hbot _ hx.2
    have hz : IsIntegral ℤ ((x : fieldI (⊥ : Subfield ℝ)) : ℂ) :=
      map_isIntegral_int (fieldI (⊥ : Subfield ℝ)).subtype (RingOfIntegers.isIntegral_coe x)
    obtain ⟨m, hm⟩ := exists_intCast_eq_re_of_isIntegral hz ha.symm hb.symm
    refine ⟨m, ?_⟩
    rw [← ha, ← hm]
    norm_cast
  -- so conjugation is the identity modulo `2`: `x̄ − x = 2 (Re x − x)`
  have hdvd : ∀ x : 𝓞 (fieldI (⊥ : Subfield ℝ)),
      conjO ⊥ x - x ∈ Ideal.span {(2 : 𝓞 (fieldI (⊥ : Subfield ℝ)))} := by
    intro x
    obtain ⟨m, hm⟩ := hre x
    have hT : x + conjO ⊥ x = (m : 𝓞 (fieldI (⊥ : Subfield ℝ))) + m := by
      refine RingOfIntegers.ext (Subtype.ext ?_)
      have h := Complex.add_conj ((x : fieldI (⊥ : Subfield ℝ)) : ℂ)
      simpa [UpperHalf.coe_conjO, ← hm, two_mul] using h
    exact Ideal.mem_span_singleton.mpr ⟨(m : 𝓞 (fieldI (⊥ : Subfield ℝ))) - x, by linear_combination hT⟩
  -- `2` is not a unit: the real part of `1/2` is not an integer
  have h2 : Ideal.span {(2 : 𝓞 (fieldI (⊥ : Subfield ℝ)))} ≠ ⊤ := by
    rw [Ne, Ideal.span_singleton_eq_top]
    intro hu
    obtain ⟨u, hu⟩ := hu.exists_right_inv
    obtain ⟨m, hm⟩ := hre u
    rw [two_mul] at hu
    have h := congrArg (fun w : 𝓞 (fieldI (⊥ : Subfield ℝ)) => ((w : fieldI (⊥ : Subfield ℝ)) : ℂ).re) hu
    have h' : (m : ℝ) + (m : ℝ) = 1 := by rw [hm]; simpa using h
    have h'' : m + m = 1 := by exact_mod_cast h'
    omega
  obtain ⟨P, hP, hle⟩ := Ideal.exists_le_maximal _ h2
  have hram : ∀ x : 𝓞 (fieldI (⊥ : Subfield ℝ)), conjO ⊥ x - x ∈ P := fun x => hle (hdvd x)
  refine ⟨⟨P, hP, Ideal.ext fun x => ?_⟩, hle (Ideal.mem_span_singleton_self 2), hram⟩
  rw [Ideal.mem_comap]
  constructor
  · intro h
    have h' := P.sub_mem h (hram x)
    rwa [sub_sub_cancel] at h'
  · intro h
    have h' := P.add_mem (hram x) h
    rwa [sub_add_cancel] at h'

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
