import Proofs.HadwigerNelson.SpectralChain
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.RingTheory.RootsOfUnity.Complex
import Mathlib.FieldTheory.Finite.Basic
import Mathlib.NumberTheory.LegendreSymbol.QuadraticChar.Basic
import Mathlib.Dynamics.PeriodicPts.Defs
import Mathlib.FieldTheory.IntermediateField.Adjoin.Basic
import Mathlib.Tactic.ComputeDegree
import Mathlib.Topology.Order.IntermediateValue
import Mathlib.FieldTheory.Minpoly.IsIntegrallyClosed
import Mathlib.NumberTheory.RamificationInertia.Basic
import Mathlib.NumberTheory.NumberField.Ideal.Basic
import Mathlib.RingTheory.Ideal.Int

/-!
# The standing five: `F = K·E₇`, a field containing `K` whose plane needs five colours given MR (FS-131 wave 10; TC1-STANDING-FIVE)

**Read aloud, against the informal claim.** `plans/TC1-derivation.md:60`: "F = K·E₇, with K = ℚ(√3,√11) and E₇ the degree-7
subfield of ℚ(ζ₂₉), is a totally real field of degree 28 containing K; its two places above 2 are inert in F(i), each of norm
128, and none of its places has a usable residue field of size at most 47; so L(F) ≥ 7, and given MR, χ(F²) ≥ 5".

**The field.** `E₇ = ℚ(η)` with `η = ζ + ζ¹² + ζ¹⁷ + ζ²⁸ = 2cos(2π/29) + 2cos(24π/29)`, the Gaussian period of the subgroup
`{1, 12, 17, 28}` of order 4 of `(ℤ/29)ˣ` (`12² ≡ −1`); `standingField = ℚ(√3, √11, η) ⊆ ℝ`.

**What is unconditional** (leaves of this module): the field is a totally real number field of degree 28 containing `√3` and
`√11`; exactly two primes of `F(i)` lie above 2, both stable, each with residue field of `128²` elements on which conjugation
is not the identity (inert, norm 128); every usable residue field of `F` — a residue field of `𝓞 F` with `q ≡ 3 (mod 4)`
elements — has at least 347 elements (`usable_card_ge`; the row's "at most 47" is `no_small_usable`). The least is 347 by exact
arithmetic on the splitting law (`tools/fs131_k10_usable.py`): 347 splits completely, and the four smaller `p ≡ 3 (mod 4)` with
`p⁴ ≡ 1 (mod 29)` — 59, 191, 307, 331 — have even residue degree in `K`.

**What is not** (the statement defect FS131-K10 reported, inventory items 477–478): "so `L(F) ≥ 7`" needs a lower bound on the
chromatic number of every level-one target of `F` — an infinite family — which the row took from G56 (Weil's bound from 98 up,
`U₁₂₈`'s Hoffman floor) and which is neither in the kernel nor in the backlog. It enters as the named hypothesis
`StandingFloor n`: the floor at `U₁₂₈` and at every `Γ_Q` with `Q ≡ 3 (mod 4)`, `Q ≥ 347` (the Weil range only: no certificate
at 59–83 is an input at this field). The MR clause takes a second named hypothesis, `Row123Chain` in the plan's table: the
conclusion of `SpectralChain.min_localBound_five_le_chromaticNumber`, `min (L(F)) 5 ≤ χ(F²)`.

**Inhabitants.** `TargetFloor 0 Q` holds for every `Q` (`targetFloor_zero`), so `StandingFloor` is satisfiable at `n = 0`; at
`n = 7` it is G56's claim, [tools]/[hand] on Weil. A finite field with an involution of the stated shape exists for every prime
power `Q` (`GaloisField`), so `TargetFloor` does not quantify over an empty domain.
-/

namespace HadwigerNelson.StandingFive

open SpectralChain NumberField SimpleGraph

/-- The Gaussian period `η = ζ + ζ¹² + ζ¹⁷ + ζ²⁸` of conductor 29, as a real number. -/
noncomputable def eta : ℝ := 2 * Real.cos (2 * Real.pi / 29) + 2 * Real.cos (24 * Real.pi / 29)

/-- `E₇ = ℚ(η)`, the degree-7 subfield of `ℚ(ζ₂₉)`. -/
noncomputable def E7 : Subfield ℝ := Subfield.closure {eta}

/-- **`F = K·E₇ = ℚ(√3, √11, η)`.** -/
noncomputable def standingField : Subfield ℝ := Subfield.closure {Real.sqrt 3, Real.sqrt 11, eta}

theorem sqrt_three_mem : Real.sqrt 3 ∈ standingField := Subfield.subset_closure (by simp)

theorem sqrt_eleven_mem : Real.sqrt 11 ∈ standingField := Subfield.subset_closure (by simp)

theorem eta_mem : eta ∈ standingField := Subfield.subset_closure (by simp)

/-- `E₇ ⊆ F`. -/
theorem E7_le : E7 ≤ standingField := Subfield.closure_mono (by simp)

/-- `K = ℚ(√3, √11) ⊆ F`: "containing K". -/
theorem K_le : Subfield.closure {Real.sqrt 3, Real.sqrt 11} ≤ standingField :=
  Subfield.closure_mono (by intro x hx; rcases hx with rfl | rfl <;> simp)

/-! ## The foundation of the leaves (FS131-I10C)

Everything the nine leaves read, in four layers: the period polynomial `g` vanishes at `η` (a certified computation in `ℤ[C₂₉]`);
the finite-field layer (Frobenius orbits, the finite check below 347, a field with an involution); the degree bound and the seven
real roots of `g`; and, after the first leaf, the primes of `𝓞 (F(i))` above 2. -/

/-! ### `g(η) = 0`: Horner's scheme in `ℤ[C₂₉]`

Vectors of length 29 under cyclic convolution model `ℤ[ζ]/(ζ²⁹ − 1)`; evaluation at the character `k ↦ ζᵏ` is multiplicative
(`cev_cconv`); the six Horner steps for `g` at `1_H`, `H = {1, 12, 17, 28}`, are literal vectors checked by `decide`, and the last
is the constant vector 289, which evaluates to `289·(1 + ζ + ⋯ + ζ²⁸) = 0` (`tools/fs131_i10c_data.py` (a)). -/

section Period

open Finset


/-- Cyclic convolution on `ℤ[C₂₉]`, as vectors of length 29. -/
def cconv (v w : Fin 29 → ℤ) : Fin 29 → ℤ := fun m => ∑ j : Fin 29, v j * w (m - j)

/-- Evaluation of a vector of `ℤ[C₂₉]` at a character. -/
noncomputable def cev (χ : Fin 29 → ℂ) (v : Fin 29 → ℤ) : ℂ := ∑ k : Fin 29, (v k : ℂ) * χ k

theorem cev_cconv (χ : Fin 29 → ℂ) (hχ : ∀ j k, χ (j + k) = χ j * χ k) (v w : Fin 29 → ℤ) :
    cev χ (cconv v w) = cev χ v * cev χ w := by
  unfold cev cconv
  calc ∑ m, ((∑ j, v j * w (m - j) : ℤ) : ℂ) * χ m
      = ∑ m, ∑ j, (v j : ℂ) * χ j * ((w (m - j) : ℂ) * χ (m - j)) := by
        refine Finset.sum_congr rfl fun m _ => ?_
        rw [Int.cast_sum, Finset.sum_mul]
        refine Finset.sum_congr rfl fun j _ => ?_
        have hm : χ m = χ j * χ (m - j) := by rw [← hχ, add_sub_cancel]
        rw [hm]; push_cast; ring
    _ = ∑ j, ∑ m, (v j : ℂ) * χ j * ((w (m - j) : ℂ) * χ (m - j)) := Finset.sum_comm
    _ = ∑ j, (v j : ℂ) * χ j * ∑ k, (w k : ℂ) * χ k := by
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [Finset.mul_sum]
        exact Fintype.sum_equiv (Equiv.subRight j) _ _ fun m => rfl
    _ = _ := by rw [Finset.sum_mul]

theorem cev_add (χ : Fin 29 → ℂ) (v w : Fin 29 → ℤ) : cev χ (v + w) = cev χ v + cev χ w := by
  simp [cev, add_mul, Finset.sum_add_distrib]

/-- The integer `n` in `ℤ[C₂₉]`: `n` at the identity, 0 elsewhere. -/
def cdelta (n : ℤ) : Fin 29 → ℤ := fun k => if k = 0 then n else 0

theorem cev_cdelta (χ : Fin 29 → ℂ) (h0 : χ 0 = 1) (n : ℤ) : cev χ (cdelta n) = n := by
  simp [cev, cdelta, h0]

/-- `1_H`, `H = {1, 12, 17, 28}`: the vector of `η`. -/
def hvec : Fin 29 → ℤ := ![0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
/-- Horner step 1: `h + 1` at `h = 1_H`. -/
def tvec1 : Fin 29 → ℤ := ![1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
/-- Horner step 2: `(h + 1)h − 12` at `h = 1_H`. -/
def tvec2 : Fin 29 → ℤ := ![-8, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 2, 1, 2, 0, 0, 2, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1]
/-- Horner step 3: `((h + 1)h − 12)h − 7` at `h = 1_H`. -/
def tvec3 : Fin 29 → ℤ := ![-3, -3, 1, 1, 3, 1, 3, 1, 0, 0, 3, 2, -3, 2, 3, 3, 2, -3, 2, 3, 0, 0, 1, 3, 1, 3, 1, 1, -3]
/-- Horner step 4: `(((h + 1)h − 12)h − 7)h + 28` at `h = 1_H`. -/
def tvec4 : Fin 29 → ℤ := ![16, 2, 4, 7, 4, 4, 7, 7, 4, 4, 4, 0, 2, 0, 7, 7, 0, 2, 0, 4, 4, 4, 7, 7, 4, 4, 7, 4, 2]
/-- Horner step 5: `((((h + 1)h − 12)h − 7)h + 28)h + 14` at `h = 1_H`. -/
def tvec5 : Fin 29 → ℤ := ![22, 20, 20, 19, 15, 20, 18, 19, 19, 19, 15, 15, 20, 15, 18, 18, 15, 20, 15, 15, 19, 19, 19, 18, 20, 15, 19, 20, 20]
/-- Horner step 6: `(((((h + 1)h − 12)h − 7)h + 28)h + 14)h − 9` at `h = 1_H`. -/
def tvec6 : Fin 29 → ℤ := ![71, 72, 72, 72, 73, 72, 72, 72, 72, 72, 73, 73, 72, 73, 72, 72, 73, 72, 73, 73, 72, 72, 72, 72, 72, 73, 72, 72, 72]

theorem horner1 : hvec + cdelta 1 = tvec1 := by decide +kernel
theorem horner2 : cconv tvec1 hvec + cdelta (-12) = tvec2 := by decide +kernel
theorem horner3 : cconv tvec2 hvec + cdelta (-7) = tvec3 := by decide +kernel
theorem horner4 : cconv tvec3 hvec + cdelta 28 = tvec4 := by decide +kernel
theorem horner5 : cconv tvec4 hvec + cdelta 14 = tvec5 := by decide +kernel
theorem horner6 : cconv tvec5 hvec + cdelta (-9) = tvec6 := by decide +kernel
theorem horner7 : cconv tvec6 hvec + cdelta 1 = fun _ => 289 := by decide +kernel


/-- The character `k ↦ ζ^k`, `ζ = e^{2πi/29}`. -/
noncomputable def chi29 (k : Fin 29) : ℂ := Complex.exp (2 * Real.pi * Complex.I / (29 : ℕ)) ^ (k : ℕ)

theorem chi29_add (j k : Fin 29) : chi29 (j + k) = chi29 j * chi29 k := by
  have h1 : Complex.exp (2 * Real.pi * Complex.I / (29 : ℕ)) ^ 29 = 1 :=
    (Complex.isPrimitiveRoot_exp 29 (by norm_num)).pow_eq_one
  rw [chi29, chi29, chi29, ← pow_add, Fin.val_add, ← pow_eq_pow_mod _ h1]

theorem chi29_zero : chi29 0 = 1 := by simp [chi29]

theorem sum_chi29 : ∑ k : Fin 29, chi29 k = 0 := by
  have h := (Complex.isPrimitiveRoot_exp 29 (by norm_num)).geom_sum_eq_zero (by norm_num)
  rw [← Fin.sum_univ_eq_sum_range] at h
  exact h

theorem chi29_eq (k : Fin 29) : chi29 k =
    (Real.cos (2 * Real.pi * (k : ℕ) / 29) : ℂ) + (Real.sin (2 * Real.pi * (k : ℕ) / 29) : ℂ) * Complex.I := by
  rw [chi29, ← Complex.exp_nat_mul, Complex.ofReal_cos, Complex.ofReal_sin, ← Complex.exp_mul_I]
  congr 1
  push_cast
  ring

theorem cev_hvec : cev chi29 hvec = (eta : ℂ) := by
  have h : cev chi29 hvec = chi29 1 + chi29 12 + chi29 17 + chi29 28 := by
    simp [cev, hvec, Fin.sum_univ_succ]
    ring
  rw [h, chi29_eq, chi29_eq, chi29_eq, chi29_eq, eta]
  have c28 : Real.cos (2 * Real.pi * 28 / 29) = Real.cos (2 * Real.pi / 29) := by
    rw [← Real.cos_two_pi_sub]; congr 1; ring
  have s28 : Real.sin (2 * Real.pi * 28 / 29) = -Real.sin (2 * Real.pi / 29) := by
    rw [← Real.sin_two_pi_sub]; congr 1; ring
  have c17 : Real.cos (2 * Real.pi * 17 / 29) = Real.cos (24 * Real.pi / 29) := by
    rw [← Real.cos_two_pi_sub]; congr 1; ring
  have s17 : Real.sin (2 * Real.pi * 17 / 29) = -Real.sin (24 * Real.pi / 29) := by
    rw [← Real.sin_two_pi_sub]; congr 1; ring
  have c12 : (2 * Real.pi * 12 / 29) = (24 * Real.pi / 29) := by ring
  have c1 : (2 * Real.pi * 1 / 29) = (2 * Real.pi / 29) := by ring
  have v12 : ((12 : Fin 29) : ℕ) = 12 := rfl
  have v17 : ((17 : Fin 29) : ℕ) = 17 := rfl
  have v28 : ((28 : Fin 29) : ℕ) = 28 := rfl
  simp only [Fin.val_one, Nat.cast_one, v12, v17, v28, Nat.cast_ofNat]
  rw [c28, s28, c17, s17, c12, c1]
  push_cast
  ring

/-- **`g(η) = 0`**: the period polynomial vanishes at the Gaussian period. -/
theorem g_eta : eta ^ 7 + eta ^ 6 - 12 * eta ^ 5 - 7 * eta ^ 4 + 28 * eta ^ 3 + 14 * eta ^ 2 - 9 * eta + 1 = 0 := by
  have hc := cev_cconv chi29 chi29_add
  have hd := cev_cdelta chi29 chi29_zero
  have e1 : cev chi29 tvec1 = eta + 1 := by rw [← horner1, cev_add, hd, cev_hvec]; norm_num
  have e2 : cev chi29 tvec2 = (eta + 1) * eta - 12 := by rw [← horner2, cev_add, hd, hc, e1, cev_hvec]; push_cast; ring
  have e3 : cev chi29 tvec3 = ((eta + 1) * eta - 12) * eta - 7 := by rw [← horner3, cev_add, hd, hc, e2, cev_hvec]; push_cast; ring
  have e4 : cev chi29 tvec4 = (((eta + 1) * eta - 12) * eta - 7) * eta + 28 := by
    rw [← horner4, cev_add, hd, hc, e3, cev_hvec]; push_cast; ring
  have e5 : cev chi29 tvec5 = ((((eta + 1) * eta - 12) * eta - 7) * eta + 28) * eta + 14 := by
    rw [← horner5, cev_add, hd, hc, e4, cev_hvec]; push_cast; ring
  have e6 : cev chi29 tvec6 = (((((eta + 1) * eta - 12) * eta - 7) * eta + 28) * eta + 14) * eta - 9 := by
    rw [← horner6, cev_add, hd, hc, e5, cev_hvec]; push_cast; ring
  have e7 : cev chi29 (fun _ => 289) = ((((((eta + 1) * eta - 12) * eta - 7) * eta + 28) * eta + 14) * eta - 9) * eta + 1 := by
    rw [← horner7, cev_add, hd, hc, e6, cev_hvec]; push_cast; ring
  have e0 : cev chi29 (fun _ => 289) = 0 := by
    simp only [cev]
    rw [← Finset.mul_sum, sum_chi29, mul_zero]
  have : ((eta ^ 7 + eta ^ 6 - 12 * eta ^ 5 - 7 * eta ^ 4 + 28 * eta ^ 3 + 14 * eta ^ 2 - 9 * eta + 1 : ℝ) : ℂ) = 0 := by
    push_cast
    rw [← e0, e7]; ring
  exact_mod_cast this

end Period

/-! ### The finite-field layer -/

/-- **The period lemma**: if `x ^ p ^ n = x` and `x ^ p ^ m = x` with `m` prime and `x ^ p ≠ x`, then `m ∣ n` (the orbit of `x`
under `y ↦ y ^ p` has exactly `m` points). -/
theorem dvd_of_pow_pow_eq {M : Type*} [Monoid M] {p n m : ℕ} {x : M} (hn : x ^ p ^ n = x) (hx : x ^ p ^ m = x)
    (hm : m.Prime) (hx1 : x ^ p ≠ x) : m ∣ n := by
  let f : M → M := fun y => y ^ p
  have hit : ∀ j (y : M), f^[j] y = y ^ p ^ j := by
    intro j
    induction j with
    | zero => intro y; simp
    | succ j ih => intro y; rw [Function.iterate_succ_apply', ih, pow_succ, pow_mul]
  have hpm : Function.IsPeriodicPt f m x := by rw [Function.IsPeriodicPt, Function.IsFixedPt, hit, hx]
  have hpn : Function.IsPeriodicPt f n x := by rw [Function.IsPeriodicPt, Function.IsFixedPt, hit, hn]
  rcases (Nat.dvd_prime hm).mp hpm.minimalPeriod_dvd with h | h
  · exact absurd (Function.minimalPeriod_eq_one_iff_isFixedPt.mp h) hx1
  · exact h ▸ hpn.minimalPeriod_dvd

/-- In a finite field of `q` elements, `x ^ q = x`. -/
theorem pow_natCard {k : Type*} [Field k] [Finite k] (x : k) : x ^ Nat.card k = x := by
  cases nonempty_fintype k
  rw [Nat.card_eq_fintype_card]; exact FiniteField.pow_card x

/-- **The dyadic residue degree**: a finite field of `2 ^ n` elements holding a root of `g` and a primitive cube root of unity
has `14 ∣ n`. The root of `g` has Frobenius period 7 (`x¹²⁸ ≡ x (mod g, 2)`, and `g(0)`, `g(1)` are odd); `ω` has period 2. -/
theorem fourteen_dvd_of_char_two {k : Type*} [Field k] [Finite k] {n : ℕ} (hcard : Nat.card k = 2 ^ n) (h2 : (2 : k) = 0)
    {a w : k} (ha : a ^ 7 + a ^ 6 - 12 * a ^ 5 - 7 * a ^ 4 + 28 * a ^ 3 + 14 * a ^ 2 - 9 * a + 1 = 0)
    (hw : w ^ 2 + w + 1 = 0) : 14 ∣ n := by
  have hall : ∀ x : k, x ^ 2 ^ n = x := fun x => hcard ▸ pow_natCard x
  have h3 : a ^ 8 = 1 + a ^ 2 + a ^ 4 + a ^ 5 + a ^ 6 := by
    linear_combination ((-1) + a) * ha + ((-5) * a + (11) * a ^ 2 + (7) * a ^ 3 + (-18) * a ^ 4 + (-3) * a ^ 5 + (6) * a ^ 6) * h2
  have h4 : a ^ 16 = a ^ 3 + a ^ 4 + a ^ 5 + a ^ 6 := by
    linear_combination (a ^ 8 + (1 + a ^ 2 + a ^ 4 + a ^ 5 + a ^ 6)) * h3 +
      ((-1) + (143) * a + (7) * a ^ 2 + (14) * a ^ 3 + a ^ 4 + a ^ 5) * ha +
      ((1) + (-76) * a + (648) * a ^ 2 + (-963) * a ^ 3 + (-1991) * a ^ 4 + (303) * a ^ 5 + (686) * a ^ 6) * h2
  have h5 : a ^ 32 = 1 + a ^ 3 + a ^ 5 := by
    linear_combination (a ^ 16 + (a ^ 3 + a ^ 4 + a ^ 5 + a ^ 6)) * h4 +
      ((25) + (141) * a + (9) * a ^ 2 + (14) * a ^ 3 + a ^ 4 + a ^ 5) * ha +
      ((-13) + (42) * a + (455) * a ^ 2 + (-1304) * a ^ 3 + (-1887) * a ^ 4 + (423) * a ^ 5 + (667) * a ^ 6) * h2
  have h6 : a ^ 64 = 1 + a + a ^ 4 + a ^ 5 := by
    linear_combination (a ^ 32 + (1 + a ^ 3 + a ^ 5)) * h5 + ((-20) + (15) * a + (-1) * a ^ 2 + a ^ 3) * ha +
      ((10) + (-98) * a + (208) * a ^ 2 + (171) * a ^ 3 + (-269) * a ^ 4 + (-60) * a ^ 5 + (83) * a ^ 6) * h2
  have h7 : a ^ 2 ^ 7 = a := by
    norm_num only
    linear_combination (a ^ 64 + (1 + a + a ^ 4 + a ^ 5)) * h6 + ((7) + (12) * a + a ^ 2 + a ^ 3) * ha +
      ((-3) + (26) * a + (5) * a ^ 2 + (-178) * a ^ 3 + (-145) * a ^ 4 + (65) * a ^ 5 + (59) * a ^ 6) * h2
  have ha1 : a ^ 2 ≠ a := by
    intro h
    have : (1 : k) = 0 := by
      linear_combination ha - (25 + 11 * a - 17 * a ^ 2 - 10 * a ^ 3 + 2 * a ^ 4 + a ^ 5) * (h) - 8 * a * h2
    exact one_ne_zero this
  have hw4 : w ^ 2 ^ 2 = w := by
    norm_num only
    linear_combination (w ^ 2 - w) * hw
  have hw1 : w ^ 2 ≠ w := by
    intro h
    have : (1 : k) = 0 := by linear_combination hw - h - w * h2
    exact one_ne_zero this
  have d7 : 7 ∣ n := dvd_of_pow_pow_eq (hall a) h7 (by norm_num) ha1
  have d2 : 2 ∣ n := dvd_of_pow_pow_eq (hall w) hw4 (by norm_num) hw1
  exact (Nat.Coprime.mul_dvd_of_dvd_of_dvd (by norm_num) d2 d7 : 2 * 7 ∣ n)

/-! ### The finite check below 347 -/

/-- `∃ c < n, f c`, by structural recursion (kernel-evaluable). -/
def anyBelow (f : ℕ → Bool) : ℕ → Bool
  | 0 => false
  | n + 1 => f n || anyBelow f n

theorem anyBelow_of {f : ℕ → Bool} {n c : ℕ} (hc : c < n) (h : f c = true) : anyBelow f n = true := by
  induction n with
  | zero => omega
  | succ n ih =>
    rw [anyBelow, Bool.or_eq_true]
    rcases Nat.lt_succ_iff_lt_or_eq.mp hc with h' | rfl
    · exact Or.inr (ih h')
    · exact Or.inl h

/-- `t` is a square mod `p`. -/
def sqMod (p t : ℕ) : Bool := anyBelow (fun a => a * a % p == t % p) p

/-- `g` has a root mod `p` (the negative terms moved to the right-hand side). -/
def gRootMod (p : ℕ) : Bool :=
  anyBelow (fun c => (c ^ 7 + c ^ 6 + 28 * c ^ 3 + 14 * c ^ 2 + 1) % p == (12 * c ^ 5 + 7 * c ^ 4 + 9 * c) % p) p

/-- No natural `p < 347`, `p ≡ 3 (mod 4)` — prime or not — has 3 and 11 squares mod `p` and a root of `g` mod `p`. -/
def usableBelow (N : ℕ) : Bool := !anyBelow (fun p => p % 4 == 3 && sqMod p 3 && sqMod p 11 && gRootMod p) N

theorem usableBelow_347 : usableBelow 347 = true := by decide +kernel

/-- At `p = 3` and `p = 7` already the squares fail (11 is not a square mod 3, 3 is not one mod 7). -/
theorem squaresBelow_11 : (!anyBelow (fun p => p % 4 == 3 && sqMod p 3 && sqMod p 11) 11) = true := by decide +kernel


theorem sq_mod_four_ne (m : ℕ) : m ^ 2 % 4 ≠ 3 := by
  rw [Nat.pow_mod]
  have h4 : m % 4 < 4 := Nat.mod_lt _ (by norm_num)
  interval_cases m % 4 <;> decide

theorem pow_mod_four_ne {p : ℕ} (hp : p % 4 ≠ 3) (n : ℕ) : p ^ n % 4 ≠ 3 := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [pow_succ, Nat.mul_mod]
    have h4 : p % 4 < 4 := Nat.mod_lt _ (by norm_num)
    have h4' : p ^ n % 4 < 4 := Nat.mod_lt _ (by norm_num)
    interval_cases p % 4 <;> interval_cases p ^ n % 4 <;> first | decide | exact absurd rfl hp | exact absurd rfl ih

/-- `p ^ n ≡ 3 (mod 4)` forces `p ≡ 3 (mod 4)` and `n` odd. -/
theorem mod_four_of_pow {p n : ℕ} (h : p ^ n % 4 = 3) : p % 4 = 3 ∧ Odd n := by
  refine ⟨by_contra fun hp => pow_mod_four_ne hp n h, ?_⟩
  rcases Nat.even_or_odd n with ⟨j, rfl⟩ | hodd
  · rw [← two_mul, mul_comm, pow_mul] at h
    exact absurd h (sq_mod_four_ne _)
  · exact hodd

/-- An element fixed by `x ↦ x ^ p` in characteristic `p` is the image of a natural number below `p`. -/
theorem exists_natCast_of_pow_eq {k : Type*} [Field k] {p : ℕ} [Fact p.Prime] [CharP k p] {x : k} (hx : x ^ p = x) :
    ∃ c : ℕ, c < p ∧ (c : k) = x := by
  obtain ⟨n, hn⟩ := (mem_bot_iff_intCast p k).mp ((Subfield.mem_bot_iff_pow_eq_self k p).mpr hx)
  have hp : (0 : ℤ) < p := by exact_mod_cast (Fact.out : p.Prime).pos
  refine ⟨(n % p).toNat, ?_, ?_⟩
  · have := Int.emod_lt_of_pos n hp; omega
  · have h1 : (((n % p).toNat : ℤ) : k) = ((n % p : ℤ) : k) := by rw [Int.toNat_of_nonneg (Int.emod_nonneg n hp.ne')]
    have h2 : ((n % p : ℤ) : k) = (n : k) := by
      rw [Int.emod_def]; push_cast; rw [CharP.cast_eq_zero]; ring
    rw [← hn, ← h2, ← h1]; norm_cast

/-- In a finite field of `p ^ n` elements with `n` odd and `p` odd, a square root of a natural number is fixed by Frobenius
(else its orbit has two points and `2 ∣ n`). -/
theorem pow_char_eq_of_sq_natCast {k : Type*} [Field k] [Finite k] {p n : ℕ} [hp : Fact p.Prime] [CharP k p]
    (hcard : Nat.card k = p ^ n) (hn : Odd n) (hp2 : p ≠ 2) {s : k} {t : ℕ} (hs : s ^ 2 = t) : s ^ p = s := by
  by_contra hne
  have hpodd : Odd p := hp.out.odd_of_ne_two hp2
  have ht : (t : k) ^ p = t := by rw [← frobenius_def, map_natCast]
  have hsq : (s ^ p) ^ 2 = s ^ 2 := by rw [← pow_mul, mul_comm, pow_mul, hs, ht]
  have hneg : s ^ p = -s := by
    have h0 : (s ^ p - s) * (s ^ p + s) = 0 := by linear_combination hsq
    rcases mul_eq_zero.mp h0 with h | h
    · exact absurd (sub_eq_zero.mp h) hne
    · exact eq_neg_of_add_eq_zero_left h
  have h2 : s ^ p ^ 2 = s := by rw [pow_two, pow_mul, hneg, Odd.neg_pow hpodd, hneg, neg_neg]
  have hd := dvd_of_pow_pow_eq (hcard ▸ pow_natCard s) h2 Nat.prime_two hne
  exact (Nat.not_even_iff_odd.mpr hn) (even_iff_two_dvd.mpr hd)

/-- **The usable clause on an abstract finite field**: a finite field of `Q ≡ 3 (mod 4)` elements holding square roots of 3 and
11 and a root of `g` has `Q ≥ 347`. -/
theorem card_ge_of_usable {k : Type*} [Field k] [Finite k] (hQ : Nat.card k % 4 = 3) {s3 s11 e : k}
    (h3 : s3 ^ 2 = 3) (h11 : s11 ^ 2 = 11)
    (he : e ^ 7 + e ^ 6 - 12 * e ^ 5 - 7 * e ^ 4 + 28 * e ^ 3 + 14 * e ^ 2 - 9 * e + 1 = 0) : 347 ≤ Nat.card k := by
  cases nonempty_fintype k
  obtain ⟨p, hchar, n, hp, hcard⟩ := FiniteField.card' k
  rw [← Nat.card_eq_fintype_card] at hcard
  haveI := Fact.mk hp
  obtain ⟨hp4, hnodd⟩ := mod_four_of_pow (hcard ▸ hQ)
  by_contra hlt
  rw [not_le] at hlt
  have hp_lt : p < 347 := lt_of_le_of_lt (hcard ▸ Nat.le_self_pow n.ne_zero p) hlt
  have hp2 : p ≠ 2 := by omega
  obtain ⟨a, ha, haa⟩ := exists_natCast_of_pow_eq (pow_char_eq_of_sq_natCast hcard hnodd hp2 (t := 3) (by simpa using h3))
  obtain ⟨b, hb, hbb⟩ := exists_natCast_of_pow_eq (pow_char_eq_of_sq_natCast hcard hnodd hp2 (t := 11) (by simpa using h11))
  have hA : sqMod p 3 = true := anyBelow_of ha (by
    have h : ((a * a : ℕ) : k) = ((3 : ℕ) : k) := by push_cast; rw [haa, ← pow_two, h3]
    simpa [Nat.ModEq] using (CharP.natCast_eq_natCast k p).mp h)
  have hB : sqMod p 11 = true := anyBelow_of hb (by
    have h : ((b * b : ℕ) : k) = ((11 : ℕ) : k) := by push_cast; rw [hbb, ← pow_two, h11]
    simpa [Nat.ModEq] using (CharP.natCast_eq_natCast k p).mp h)
  by_cases hn1 : (n : ℕ) = 1
  · obtain ⟨c, hc, hcc⟩ := exists_natCast_of_pow_eq (x := e) (p := p) (by
      have h := pow_natCard e; rwa [hcard, hn1, pow_one] at h)
    have hC : gRootMod p = true := anyBelow_of hc (by
      have h : ((c ^ 7 + c ^ 6 + 28 * c ^ 3 + 14 * c ^ 2 + 1 : ℕ) : k) = ((12 * c ^ 5 + 7 * c ^ 4 + 9 * c : ℕ) : k) := by
        push_cast; rw [hcc]; linear_combination he
      simpa [Nat.ModEq] using (CharP.natCast_eq_natCast k p).mp h)
    have hall := anyBelow_of (f := fun p => p % 4 == 3 && sqMod p 3 && sqMod p 11 && gRootMod p) hp_lt (by simp [hp4, hA, hB, hC])
    have h347 := usableBelow_347
    rw [usableBelow, hall] at h347
    exact absurd h347 (by decide)
  · have hn3 : 3 ≤ (n : ℕ) := by
      obtain ⟨j, hj⟩ := hnodd
      have := n.pos
      omega
    by_cases hp11 : p < 11
    · have hall := anyBelow_of (f := fun p => p % 4 == 3 && sqMod p 3 && sqMod p 11) hp11 (by simp [hp4, hA, hB])
      have h11' := squaresBelow_11
      rw [hall] at h11'
      exact absurd h11' (by decide)
    · have h1 : 11 ^ 3 ≤ p ^ (n : ℕ) :=
        (Nat.pow_le_pow_left (not_lt.mp hp11) 3).trans (Nat.pow_le_pow_right hp.pos hn3)
      omega

/-- **A finite field with an involution moving a square root of `−1`** (odd characteristic): the fixed field has `Q` elements with
`Q ≡ 3 (mod 4)` and the field has `Q²`. -/
theorem card_fixed_of_involution {k : Type*} [Field k] [Finite k] (σ : k →+* k) (hσ : ∀ x, σ (σ x) = x) {ι : k}
    (hι : ι ^ 2 = -1) (hσι : σ ι = -ι) (h2 : (2 : k) ≠ 0) :
    Nat.card k = Nat.card (σ.eqLocusField (RingHom.id k)) ^ 2 ∧ Nat.card (σ.eqLocusField (RingHom.id k)) % 4 = 3 := by
  set k₀ := σ.eqLocusField (RingHom.id k) with hk₀
  have hmem : ∀ x : k, x ∈ k₀ ↔ σ x = x := fun x => Iff.rfl
  have hι0 : ι ≠ 0 := by
    rintro rfl
    simp at hι
  have hfix : ∀ x : k₀, σ (x : k) = x := fun x => (hmem _).mp x.2
  let φ : k₀ × k₀ → k := fun ab => ab.1 + ι * ab.2
  have hinj : Function.Injective φ := by
    rintro ⟨a, b⟩ ⟨a', b'⟩ h
    simp only [φ] at h
    have hs := congrArg σ h
    simp only [map_add, map_mul, hσι, hfix] at hs
    have ha : (a : k) = a' := mul_left_cancel₀ h2 (by linear_combination h + hs)
    have hb : (b : k) = b' := mul_left_cancel₀ hι0 (by linear_combination h - ha)
    exact Prod.ext (Subtype.ext ha) (Subtype.ext hb)
  have hsurj : Function.Surjective φ := fun x =>
    ⟨(⟨(x + σ x) / 2, (hmem _).mpr (by rw [map_div₀, map_add, hσ, map_ofNat, add_comm])⟩,
      ⟨(x - σ x) / (2 * ι), (hmem _).mpr (by
        rw [map_div₀, map_sub, hσ, map_mul, map_ofNat, hσι]; field_simp; ring)⟩), by
      simp only [φ]; field_simp; ring⟩
  refine ⟨by rw [← Nat.card_eq_of_bijective φ ⟨hinj, hsurj⟩, Nat.card_prod, pow_two], ?_⟩
  cases nonempty_fintype k₀
  rw [Nat.card_eq_fintype_card]
  by_contra hne
  obtain ⟨y, hy⟩ := FiniteField.isSquare_neg_one_iff.mpr hne
  have hy' : ((y : k) - ι) * ((y : k) + ι) = 0 := by
    have : (y : k) * y = -1 := by exact_mod_cast congrArg (Subtype.val) hy.symm
    linear_combination this - hι
  have hyfix := hfix y
  rcases mul_eq_zero.mp hy' with h | h
  · rw [sub_eq_zero.mp h, hσι] at hyfix
    exact hι0 (mul_left_cancel₀ h2 (by linear_combination -hyfix))
  · rw [eq_neg_of_add_eq_zero_left h, map_neg, hσι] at hyfix
    exact hι0 (mul_left_cancel₀ h2 (by linear_combination hyfix))

/-! ### The field: a number field of degree at most 28, with seven real roots of `g` -/

section Field

open Polynomial


/-- The period polynomial `g` over `ℤ`. -/
noncomputable def gPoly : ℤ[X] := X ^ 7 + X ^ 6 - 12 * X ^ 5 - 7 * X ^ 4 + 28 * X ^ 3 + 14 * X ^ 2 - 9 * X + 1

theorem gPoly_monic : gPoly.Monic := by unfold gPoly; monicity!

theorem gPoly_natDegree : gPoly.natDegree = 7 := by unfold gPoly; compute_degree!

theorem aeval_gPoly {A : Type*} [CommRing A] (x : A) :
    aeval x gPoly = x ^ 7 + x ^ 6 - 12 * x ^ 5 - 7 * x ^ 4 + 28 * x ^ 3 + 14 * x ^ 2 - 9 * x + 1 := by
  simp [gPoly, map_ofNat]

theorem isIntegral_eta : IsIntegral ℤ eta := ⟨gPoly, gPoly_monic, by rw [← aeval_def, aeval_gPoly, g_eta]⟩

theorem isIntegral_sqrt_three : IsIntegral ℤ (Real.sqrt 3) :=
  ⟨X ^ 2 - C 3, monic_X_pow_sub_C _ (by norm_num), by simp⟩

theorem isIntegral_sqrt_eleven : IsIntegral ℤ (Real.sqrt 11) :=
  ⟨X ^ 2 - C 11, monic_X_pow_sub_C _ (by norm_num), by simp⟩

/-- The three generators as an intermediate field of `ℝ/ℚ`. -/
noncomputable def standingIF : IntermediateField ℚ ℝ := IntermediateField.adjoin ℚ {Real.sqrt 3, Real.sqrt 11, eta}

theorem standingField_eq : standingField = standingIF.toSubfield := by
  rw [standingIF, IntermediateField.adjoin_toSubfield]
  refine le_antisymm (Subfield.closure_mono Set.subset_union_right) ((Subfield.closure_le).mpr ?_)
  rintro x (⟨q, rfl⟩ | hx)
  · exact SubfieldClass.ratCast_mem _ q
  · exact Subfield.subset_closure hx

theorem finrank_simple_le {x : ℝ} {p : ℤ[X]} (hp : p.Monic) (hx : aeval x p = 0) :
    Module.finrank ℚ (IntermediateField.adjoin ℚ ({x} : Set ℝ)) ≤ p.natDegree := by
  have hint : IsIntegral ℚ x := (show IsIntegral ℤ x from ⟨p, hp, by rwa [← aeval_def]⟩).tower_top
  rw [IntermediateField.adjoin.finrank hint]
  have hq : (p.map (Int.castRingHom ℚ)).Monic := hp.map _
  have h0 : aeval x (p.map (Int.castRingHom ℚ)) = 0 := by rw [← hx]; exact aeval_map_algebraMap ℚ x p
  calc (minpoly ℚ x).natDegree ≤ (p.map (Int.castRingHom ℚ)).natDegree :=
        natDegree_le_natDegree (minpoly.min ℚ x hq h0)
    _ = p.natDegree := hp.natDegree_map _

theorem finrank_standingIF_le : Module.finrank ℚ standingIF ≤ 28 := by
  have h3 : Module.finrank ℚ (IntermediateField.adjoin ℚ ({Real.sqrt 3} : Set ℝ)) ≤ 2 := by
    have h := finrank_simple_le (x := Real.sqrt 3) (p := X ^ 2 - C 3) (monic_X_pow_sub_C _ (by norm_num)) (by simp [map_ofNat])
    rwa [natDegree_X_pow_sub_C] at h
  have h11 : Module.finrank ℚ (IntermediateField.adjoin ℚ ({Real.sqrt 11} : Set ℝ)) ≤ 2 := by
    have h := finrank_simple_le (x := Real.sqrt 11) (p := X ^ 2 - C 11) (monic_X_pow_sub_C _ (by norm_num)) (by simp [map_ofNat])
    rwa [natDegree_X_pow_sub_C] at h
  have h7 : Module.finrank ℚ (IntermediateField.adjoin ℚ ({eta} : Set ℝ)) ≤ 7 := by
    simpa [gPoly_natDegree] using finrank_simple_le (x := eta) gPoly_monic (by rw [aeval_gPoly, g_eta])
  have hS : ({Real.sqrt 3, Real.sqrt 11, eta} : Set ℝ) = {Real.sqrt 3} ∪ ({Real.sqrt 11} ∪ {eta}) := by
    rw [Set.insert_eq, Set.insert_eq]
  rw [standingIF, hS, IntermediateField.adjoin_union, IntermediateField.adjoin_union]
  calc _ ≤ _ * _ := IntermediateField.finrank_sup_le _ _
    _ ≤ 2 * (2 * 7) := Nat.mul_le_mul h3 ((IntermediateField.finrank_sup_le _ _).trans (Nat.mul_le_mul h11 h7))

instance instFiniteDimensionalStandingIF : FiniteDimensional ℚ standingIF :=
  IntermediateField.finiteDimensional_adjoin (by
    rintro x (rfl | rfl | rfl)
    · exact isIntegral_sqrt_three.tower_top
    · exact isIntegral_sqrt_eleven.tower_top
    · exact isIntegral_eta.tower_top)

/-- The inclusion `F → ℚ(√3, √11, η)` as a ring homomorphism (the two are one set). -/
noncomputable def toStandingIF : standingField →+* standingIF where
  toFun x := ⟨x.1, standingField_eq.le x.2⟩
  map_one' := rfl
  map_mul' _ _ := rfl
  map_zero' := rfl
  map_add' _ _ := rfl

theorem toStandingIF_injective : Function.Injective toStandingIF := fun _ _ h =>
  Subtype.ext (congrArg (fun z : standingIF => (z : ℝ)) h)

theorem finrank_standingField_le : Module.finrank ℚ standingField ≤ 28 :=
  (LinearMap.finrank_le_finrank_of_injective (f := toStandingIF.toRatAlgHom.toLinearMap) toStandingIF_injective).trans
    finrank_standingIF_le

theorem aeval_gPoly_map {A B : Type*} [CommRing A] [CommRing B] (f : A →+* B) (x : A) :
    aeval (f x) gPoly = f (aeval x gPoly) := aeval_algHom_apply f.toIntAlgHom x gPoly

/-- `√3` as an element of `F` (the three generators as elements of `F`, with their relations). -/
noncomputable def s3F : standingField := ⟨Real.sqrt 3, sqrt_three_mem⟩
/-- `√11` as an element of `F`. -/
noncomputable def s11F : standingField := ⟨Real.sqrt 11, sqrt_eleven_mem⟩
/-- `η` as an element of `F`. -/
noncomputable def etaF : standingField := ⟨eta, eta_mem⟩

theorem s3F_sq : s3F ^ 2 = 3 :=
  standingField.subtype_injective (by rw [map_pow, map_ofNat]; exact Real.sq_sqrt (by norm_num))

theorem s11F_sq : s11F ^ 2 = 11 :=
  standingField.subtype_injective (by rw [map_pow, map_ofNat]; exact Real.sq_sqrt (by norm_num))

theorem aeval_etaF : aeval etaF gPoly = 0 :=
  standingField.subtype_injective (by
    rw [← aeval_gPoly_map, map_zero, aeval_gPoly]; exact g_eta)

/-! ### Totally real: `g` has seven real roots -/

/-- A sign change of `g` on `[a, b]` gives a root strictly inside. -/
theorem exists_root_gPoly_of_sign {a b : ℝ} (hab : a ≤ b) (h : aeval a gPoly * aeval b gPoly < 0) :
    ∃ x : ℝ, a < x ∧ x < b ∧ aeval x gPoly = 0 := by
  have hc : ContinuousOn (fun x : ℝ => aeval x gPoly) (Set.Icc a b) := by
    simp only [aeval_gPoly]; fun_prop
  have hx : ∃ x ∈ Set.Icc a b, aeval x gPoly = 0 := by
    rcases lt_or_ge (aeval a gPoly) 0 with ha | ha
    · have hb : 0 < aeval b gPoly := pos_of_mul_neg_right h ha.le
      exact intermediate_value_Icc hab hc ⟨ha.le, hb.le⟩
    · have hb : aeval b gPoly < 0 := neg_of_mul_neg_right h ha
      exact intermediate_value_Icc' hab hc ⟨hb.le, ha⟩
  obtain ⟨x, ⟨hax, hxb⟩, hx0⟩ := hx
  refine ⟨x, lt_of_le_of_ne hax ?_, lt_of_le_of_ne hxb ?_, hx0⟩
  · rintro rfl; rw [hx0, zero_mul] at h; exact lt_irrefl _ h
  · rintro rfl; rw [hx0, mul_zero] at h; exact lt_irrefl _ h

/-- **Every complex root of `g` is real**: `g` changes sign seven times, at `−4, −2, −5/4, 0, 1/5, 1, 2, 3`. -/
theorem im_eq_zero_of_aeval_gPoly {z : ℂ} (hz : aeval z gPoly = 0) : z.im = 0 := by
  obtain ⟨r1, h1a, h1b, hr1⟩ := exists_root_gPoly_of_sign (a := -4) (b := -2) (by norm_num) (by rw [aeval_gPoly, aeval_gPoly]; norm_num)
  obtain ⟨r2, h2a, h2b, hr2⟩ := exists_root_gPoly_of_sign (a := -2) (b := -5/4) (by norm_num) (by rw [aeval_gPoly, aeval_gPoly]; norm_num)
  obtain ⟨r3, h3a, h3b, hr3⟩ := exists_root_gPoly_of_sign (a := -5/4) (b := 0) (by norm_num) (by rw [aeval_gPoly, aeval_gPoly]; norm_num)
  obtain ⟨r4, h4a, h4b, hr4⟩ := exists_root_gPoly_of_sign (a := 0) (b := 1/5) (by norm_num) (by rw [aeval_gPoly, aeval_gPoly]; norm_num)
  obtain ⟨r5, h5a, h5b, hr5⟩ := exists_root_gPoly_of_sign (a := 1/5) (b := 1) (by norm_num) (by rw [aeval_gPoly, aeval_gPoly]; norm_num)
  obtain ⟨r6, h6a, h6b, hr6⟩ := exists_root_gPoly_of_sign (a := 1) (b := 2) (by norm_num) (by rw [aeval_gPoly, aeval_gPoly]; norm_num)
  obtain ⟨r7, h7a, h7b, hr7⟩ := exists_root_gPoly_of_sign (a := 2) (b := 3) (by norm_num) (by rw [aeval_gPoly, aeval_gPoly]; norm_num)
  set P : ℂ[X] := gPoly.map (algebraMap ℤ ℂ) with hP
  have hPm : P.Monic := gPoly_monic.map _
  have hP0 : P ≠ 0 := hPm.ne_zero
  have hPd : P.natDegree = 7 := by rw [hP, gPoly_monic.natDegree_map, gPoly_natDegree]
  have hroot : ∀ x : ℝ, aeval x gPoly = 0 → (x : ℂ) ∈ P.roots.toFinset := fun x hx => by
    rw [Multiset.mem_toFinset, mem_roots hP0, IsRoot.def, hP, eval_map_algebraMap]
    have : aeval ((algebraMap ℝ ℂ) x) gPoly = (algebraMap ℝ ℂ) (aeval x gPoly) := aeval_algebraMap_apply ℂ x gPoly
    rw [Complex.coe_algebraMap] at this
    rw [this, hx, Complex.ofReal_zero]
  let r : Fin 7 → ℝ := ![r1, r2, r3, r4, r5, r6, r7]
  have hr : ∀ i, aeval (r i) gPoly = 0 := by
    intro i; fin_cases i <;> assumption
  have hmono : StrictMono r := by
    rw [Fin.strictMono_iff_lt_succ]
    intro i; fin_cases i <;> simp [r] <;> linarith
  let S : Finset ℂ := Finset.univ.image fun i => (r i : ℂ)
  have hS7 : S.card = 7 := by
    have hinj : Function.Injective fun i => (r i : ℂ) := Complex.ofReal_injective.comp hmono.injective
    rw [Finset.card_image_of_injective _ hinj, Finset.card_univ, Fintype.card_fin]
  have hsub : S ⊆ P.roots.toFinset := by
    intro w hw
    obtain ⟨i, -, rfl⟩ := Finset.mem_image.mp hw
    exact hroot _ (hr i)
  have hcard : P.roots.toFinset.card ≤ S.card := by
    rw [hS7, ← hPd]; exact (Multiset.toFinset_card_le _).trans (card_roots' P)
  have hzS : z ∈ S := by
    rw [Finset.eq_of_subset_of_card_le hsub hcard, Multiset.mem_toFinset, mem_roots hP0, IsRoot.def, hP, eval_map_algebraMap]
    exact hz
  obtain ⟨i, -, rfl⟩ := Finset.mem_image.mp hzS
  exact Complex.ofReal_im _

/-- **`F` is totally real**, in the form the leaf states. -/
theorem isTotallyReal_aux (φ : standingField →+* ℂ) : ∀ (x : ℝ) (hx : x ∈ standingField), (φ ⟨x, hx⟩).im = 0 := by
  have hsq : ∀ (w : ℂ) (t : ℝ), 0 ≤ t → w ^ 2 = t → w.im = 0 := fun w t ht hw => by
    have h0 : (w - (Real.sqrt t : ℂ)) * (w + (Real.sqrt t : ℂ)) = 0 := by
      have : ((Real.sqrt t : ℝ) : ℂ) ^ 2 = t := by rw [← Complex.ofReal_pow, Real.sq_sqrt ht]
      linear_combination hw - this
    rcases mul_eq_zero.mp h0 with h | h
    · rw [sub_eq_zero.mp h]; exact Complex.ofReal_im _
    · rw [eq_neg_of_add_eq_zero_left h]; simp
  intro x hx
  refine Subfield.closure_induction (p := fun x hx => (φ ⟨x, hx⟩).im = 0) ?_ ?_ ?_ ?_ ?_ ?_ hx
  · rintro y (rfl | rfl | rfl)
    · refine hsq _ 3 (by norm_num) ?_
      show φ s3F ^ 2 = _
      rw [← map_pow, s3F_sq, map_ofNat]; norm_num
    · refine hsq _ 11 (by norm_num) ?_
      show φ s11F ^ 2 = _
      rw [← map_pow, s11F_sq, map_ofNat]; norm_num
    · refine im_eq_zero_of_aeval_gPoly ?_
      show aeval (φ etaF) gPoly = 0
      rw [aeval_gPoly_map, aeval_etaF, map_zero]
  · show (φ 1).im = 0
    rw [map_one]; rfl
  · intro a b ha hb h1 h2
    show (φ (⟨a, ha⟩ + ⟨b, hb⟩)).im = 0
    rw [map_add, Complex.add_im, h1, h2, add_zero]
  · intro a ha h1
    show (φ (-⟨a, ha⟩)).im = 0
    rw [map_neg, Complex.neg_im, h1, neg_zero]
  · intro a ha h1
    show (φ (⟨a, ha⟩⁻¹)).im = 0
    rw [map_inv₀, Complex.inv_im, h1, neg_zero, zero_div]
  · intro a b ha hb h1 h2
    show (φ (⟨a, ha⟩ * ⟨b, hb⟩)).im = 0
    rw [map_mul, Complex.mul_im, h1, h2, mul_zero, zero_mul, add_zero]

end Field

/-! ### Integers: `√3`, `√11`, `η` in `𝓞 F` -/

section Integers

open Polynomial

theorem isIntegral_of_sq_add {K : Type*} [Field K] {x : K} (b c : ℤ) (h : x ^ 2 + b * x + c = 0) : IsIntegral ℤ x :=
  ⟨X ^ 2 + C b * X + C c, by monicity!, by
    rw [← aeval_def, map_add, map_add, map_pow, map_mul, aeval_X, aeval_C, aeval_C]
    simpa using h⟩

theorem isIntegral_of_aeval_gPoly {K : Type*} [Field K] {x : K} (h : aeval x gPoly = 0) : IsIntegral ℤ x :=
  ⟨gPoly, gPoly_monic, by rwa [← aeval_def]⟩

/-- `√3` in `𝓞 F`. -/
noncomputable def s3I : 𝓞 standingField := ⟨s3F, isIntegral_of_sq_add 0 (-3) (by rw [s3F_sq]; norm_num)⟩

/-- `√11` in `𝓞 F`. -/
noncomputable def s11I : 𝓞 standingField := ⟨s11F, isIntegral_of_sq_add 0 (-11) (by rw [s11F_sq]; norm_num)⟩

/-- `η` in `𝓞 F`. -/
noncomputable def etaI : 𝓞 standingField := ⟨etaF, isIntegral_of_aeval_gPoly aeval_etaF⟩

theorem s3I_sq : s3I ^ 2 = 3 := RingOfIntegers.coe_injective (by rw [map_pow, map_ofNat]; exact s3F_sq)

theorem s11I_sq : s11I ^ 2 = 11 := RingOfIntegers.coe_injective (by rw [map_pow, map_ofNat]; exact s11F_sq)

theorem aeval_etaI : aeval etaI gPoly = 0 :=
  RingOfIntegers.coe_injective (by rw [← aeval_gPoly_map, map_zero]; exact aeval_etaF)

end Integers

/-! ### The unconditional clauses -/

/-- `F` is a number field. -/
theorem numberField_standingField : NumberField standingField :=
  { to_finiteDimensional := Module.Finite.of_injective toStandingIF.toRatAlgHom.toLinearMap toStandingIF_injective }

/-- `F` is a number field: the instance the Dedekind-domain lemmas below read, local to this file. -/
local instance instNumberFieldStanding : NumberField standingField := numberField_standingField

local notation "𝓞L" => 𝓞 (fieldI standingField)

/-! ### The integers of `F(i)`: `i`, `ω`, `θ`, and conjugation on them -/

section FieldI

open Polynomial

/-- `F → F(i)`, as a ring homomorphism. -/
noncomputable def toL : standingField →+* fieldI standingField :=
  (Complex.ofRealHom.comp standingField.subtype).codRestrict (fieldI standingField) fun x =>
    ⟨by simp, by simp [zero_mem]⟩

/-- `i` in `F(i)`. -/
noncomputable def iL : fieldI standingField := ⟨Complex.I, by simp [zero_mem], by simp [one_mem]⟩

theorem iL_sq : iL ^ 2 = -1 := Subtype.ext (by simp [iL])

/-- `ω = (−1 + √3·i)/2` in `F(i)`. -/
noncomputable def omL : fieldI standingField := (-1 + toL s3F * iL) / 2

/-- `θ = (1 + √33)/2` in `F`. -/
noncomputable def thetaF : standingField := (1 + s3F * s11F) / 2

theorem omL_rel : omL ^ 2 + omL + 1 = 0 := by
  have hs : toL s3F ^ 2 = 3 := by rw [← map_pow, s3F_sq, map_ofNat]
  rw [omL]
  linear_combination (iL ^ 2 / 4) * hs + (3 / 4 : fieldI standingField) * iL_sq

theorem thetaF_rel : thetaF ^ 2 - thetaF - 8 = 0 := by
  rw [thetaF]
  linear_combination (s11F ^ 2 / 4) * s3F_sq + (3 / 4 : standingField) * s11F_sq

/-- `θ` in `𝓞 F`. -/
noncomputable def thetaI : 𝓞 standingField :=
  ⟨thetaF, isIntegral_of_sq_add (-1) (-8) (by push_cast; linear_combination thetaF_rel)⟩

theorem thetaI_rel : thetaI ^ 2 - thetaI - 8 = 0 :=
  RingOfIntegers.coe_injective (by
    rw [map_sub, map_sub, map_pow, map_ofNat, map_zero]; exact thetaF_rel)

/-- `𝓞 F → 𝓞 (F(i))`. -/
noncomputable def up : 𝓞 standingField →+* 𝓞 (fieldI standingField) := RingOfIntegers.mapRingHom toL

/-- `i` in `𝓞 (F(i))`. -/
noncomputable def iO : 𝓞 (fieldI standingField) :=
  ⟨iL, isIntegral_of_sq_add 0 1 (by push_cast; linear_combination iL_sq)⟩

/-- `ω` in `𝓞 (F(i))`. -/
noncomputable def omO : 𝓞 (fieldI standingField) :=
  ⟨omL, isIntegral_of_sq_add 1 1 (by push_cast; linear_combination omL_rel)⟩

theorem iO_sq : iO ^ 2 = -1 :=
  RingOfIntegers.coe_injective (by rw [map_pow, map_neg, map_one]; exact iL_sq)

theorem omO_rel : omO ^ 2 + omO + 1 = 0 :=
  RingOfIntegers.coe_injective (by rw [map_add, map_add, map_pow, map_one, map_zero]; exact omL_rel)

theorem conjOn_toL (x : standingField) : conjOn (fieldI_conj standingField) (toL x) = toL x :=
  Subtype.ext (Complex.conj_ofReal _)

theorem conjOn_iL : conjOn (fieldI_conj standingField) iL = -iL := Subtype.ext Complex.conj_I

theorem conjO_up (x : 𝓞 standingField) : conjO standingField (up x) = up x :=
  RingOfIntegers.ext (conjOn_toL _)

theorem conjO_iO : conjO standingField iO = -iO :=
  RingOfIntegers.coe_injective (by rw [map_neg]; exact conjOn_iL)

theorem conjO_conjO (x : 𝓞 (fieldI standingField)) : conjO standingField (conjO standingField x) = x :=
  RingOfIntegers.ext (conjOn_conjOn (fieldI_conj standingField) _)

/-- `ω̄ − ω = −√3·i`. -/
theorem conjO_omO : conjO standingField omO - omO = -(up s3I * iO) :=
  RingOfIntegers.coe_injective (by
    rw [map_sub, map_neg, map_mul]
    show conjOn (fieldI_conj standingField) omL - omL = -(toL s3F * iL)
    rw [omL, map_div₀, map_add, map_neg, map_one, map_mul, conjOn_toL, conjOn_iL, map_ofNat]
    ring)

theorem up_s3I_sq : up s3I ^ 2 = 3 := by rw [← map_pow, s3I_sq, map_ofNat]

theorem up_s11I_sq : up s11I ^ 2 = 11 := by rw [← map_pow, s11I_sq, map_ofNat]

theorem aeval_up_etaI : aeval (up etaI) gPoly = 0 := by rw [aeval_gPoly_map, aeval_etaI, map_zero]

end FieldI

/-! ### The primes of `𝓞 (F(i))` above 2 -/

section Dyadic

open Polynomial Ideal

/-- No algebraic integer of a field of characteristic 0 is a root of `2x² − x − 4` (whose roots are `(1 ± √33)/4`): its minimal
polynomial over `ℤ` would divide `2x² − x − 4` in `ℤ[x]`. -/
theorem two_sq_ne_of_isIntegral {K : Type*} [Field K] [CharZero K] {x : K} (hx : IsIntegral ℤ x) :
    2 * x ^ 2 - x - 4 ≠ 0 := by
  intro h
  set q : ℤ[X] := C 2 * X ^ 2 - X - C 4 with hq
  have hqx : aeval x q = 0 := by
    rw [hq, map_sub, map_sub, map_mul, map_pow, aeval_X, aeval_C, aeval_C]
    simpa using h
  have hqd : q.natDegree = 2 := by rw [hq]; compute_degree!
  have hq0 : q ≠ 0 := fun h0 => by rw [h0] at hqd; simp at hqd
  have hq1 : q.coeff 1 = -1 := by simp [hq, coeff_X]
  have hq2 : q.coeff 2 = 2 := by simp [hq, coeff_X]
  obtain ⟨c, hc⟩ := minpoly.isIntegrallyClosed_dvd hx hqx
  have hm : (minpoly ℤ x).Monic := minpoly.monic hx
  have hc0 : c ≠ 0 := by rintro rfl; rw [mul_zero] at hc; exact hq0 hc
  have hdeg : (minpoly ℤ x).natDegree + c.natDegree = 2 := by rw [← hm.natDegree_mul' hc0, ← hc, hqd]
  obtain hd | hd | hd : (minpoly ℤ x).natDegree = 0 ∨ (minpoly ℤ x).natDegree = 1 ∨ (minpoly ℤ x).natDegree = 2 := by
    omega
  · have h1 := hm.natDegree_eq_zero.mp hd
    have h2 := minpoly.aeval ℤ x
    rw [h1] at h2
    simp at h2
  · have h1 := eq_X_add_C_of_natDegree_le_one (p := minpoly ℤ x) (by omega)
    have hc1 : (minpoly ℤ x).coeff 1 = 1 := by rw [← hd]; exact hm
    rw [hc1] at h1
    set a := (minpoly ℤ x).coeff 0 with ha
    have hx' : x = -(a : K) := by
      have h2 := minpoly.aeval ℤ x
      rw [h1] at h2
      simp at h2
      linear_combination h2
    have hz : 2 * a ^ 2 + a - 4 = 0 := by
      have h3 : ((2 * a ^ 2 + a - 4 : ℤ) : K) = 0 := by
        push_cast; rw [hx'] at h; linear_combination h
      exact_mod_cast h3
    have hdvd : a ∣ 4 := ⟨2 * a + 1, by linarith⟩
    have hle : a ≤ 4 := Int.le_of_dvd (by norm_num) hdvd
    have hge : -a ≤ 4 := Int.le_of_dvd (by norm_num) ((neg_dvd).mpr hdvd)
    have hge' : -4 ≤ a := by omega
    interval_cases a <;> omega
  · have hcd : c.natDegree = 0 := by omega
    have hcC := eq_C_of_natDegree_eq_zero hcd
    rw [hcC] at hc
    have e2 := congrArg (fun p => p.coeff 2) hc
    have e1 := congrArg (fun p => p.coeff 1) hc
    simp only [coeff_mul_C, hq1, hq2] at e1 e2
    have hm2 : (minpoly ℤ x).coeff 2 = 1 := by rw [← hd]; exact hm
    rw [hm2, one_mul] at e2
    rw [← e2] at e1
    omega

/-- The image of `θ` in `𝓞 (F(i))`, and `θ' = 1 − θ`: `θ·θ' = −8`. -/
theorem up_thetaI_mul : up thetaI * (1 - up thetaI) = -8 := by
  have h : up thetaI ^ 2 - up thetaI - 8 = 0 := by
    rw [← map_pow, ← map_sub, ← map_ofNat up 8, ← map_sub, thetaI_rel, map_zero]
  linear_combination -h

/-- `(2) ⊂ ℤ`, in the form Mathlib's ramification lemmas read. -/
abbrev twoZ : Ideal ℤ := Ideal.span {((2 : ℕ) : ℤ)}

theorem twoZ_ne_bot : twoZ ≠ ⊥ := by
  rw [Ne, Ideal.span_singleton_eq_bot]; norm_num

theorem liesOver_two {P : Ideal 𝓞L} (hP : P.IsMaximal) (h2 : (2 : 𝓞L) ∈ P) : P.LiesOver twoZ := by
  refine ⟨Ideal.IsMaximal.eq_of_le (Int.ideal_span_isMaximal_of_prime 2) (Ideal.comap_ne_top _ hP.ne_top) ?_⟩
  rw [Ideal.span_le, Set.singleton_subset_iff]
  show algebraMap ℤ 𝓞L ((2 : ℕ) : ℤ) ∈ P
  simpa using h2

theorem card_quot_eq_two_pow {P : Ideal 𝓞L} (hP : P.IsMaximal) (h2 : (2 : 𝓞L) ∈ P) :
    Nat.card (𝓞L ⧸ P) = 2 ^ twoZ.inertiaDeg' P := by
  haveI := liesOver_two hP h2
  have h := Ideal.absNorm_eq_pow_inertiaDeg' P Nat.prime_two
  rwa [Ideal.absNorm_apply, Submodule.cardQuot_apply] at h

theorem fourteen_dvd_inertiaDeg {P : Ideal 𝓞L} (hP : P.IsMaximal) (h2 : (2 : 𝓞L) ∈ P) : 14 ∣ twoZ.inertiaDeg' P := by
  haveI := hP
  letI : Field (𝓞L ⧸ P) := Ideal.Quotient.field P
  refine fourteen_dvd_of_char_two (card_quot_eq_two_pow hP h2) ?_ (a := Ideal.Quotient.mk P (up etaI))
    (w := Ideal.Quotient.mk P omO) ?_ ?_
  · rw [← map_ofNat (Ideal.Quotient.mk P) 2]; exact Ideal.Quotient.eq_zero_iff_mem.mpr h2
  · rw [← aeval_gPoly, aeval_gPoly_map, aeval_up_etaI, map_zero]
  · rw [← map_pow, ← map_add, ← map_one (Ideal.Quotient.mk P), ← map_add, omO_rel, map_zero]

theorem two_le_ramificationIdx {P : Ideal 𝓞L} (hP : P.IsMaximal) (h2 : (2 : 𝓞L) ∈ P) : 2 ≤ twoZ.ramificationIdx' P := by
  have hmap : Ideal.map (algebraMap ℤ 𝓞L) twoZ = Ideal.span {(2 : 𝓞L)} := by
    rw [Ideal.map_span, Set.image_singleton]; simp
  have hne : Ideal.map (algebraMap ℤ 𝓞L) twoZ ≠ ⊥ := by
    rw [hmap, Ne, Ideal.span_singleton_eq_bot]; norm_num
  have h1 : (1 + iO) ∈ P := hP.isPrime.mem_of_pow_mem 2 (by
    have h : (1 + iO) ^ 2 = 2 * iO := by linear_combination iO_sq
    rw [h]; exact P.mul_mem_right _ h2)
  have h22 : (2 : 𝓞L) ∈ P ^ 2 := by
    have h : (2 : 𝓞L) = (1 + iO) ^ 2 * (-iO) := by linear_combination (2 + iO) * iO_sq
    rw [h]; exact Ideal.mul_mem_right _ _ (Ideal.pow_mem_pow h1 2)
  rw [Ideal.IsDedekindDomain.ramificationIdx'_eq_multiplicity hne hP.isPrime]
  refine FiniteMultiplicity.le_multiplicity_of_pow_dvd (FiniteMultiplicity.of_not_isUnit ?_ hne) ?_
  · rw [Ideal.isUnit_iff]; exact hP.ne_top
  · rw [Ideal.dvd_iff_le, hmap, Ideal.span_le, Set.singleton_subset_iff]; exact h22

theorem twentyeight_le {P : Ideal 𝓞L} (hP : P.IsMaximal) (h2 : (2 : 𝓞L) ∈ P) :
    28 ≤ twoZ.ramificationIdx' P * twoZ.inertiaDeg' P := by
  haveI := liesOver_two hP h2
  have hpos : 0 < twoZ.inertiaDeg' P := Ideal.inertiaDeg'_pos' twoZ P
  exact Nat.mul_le_mul (two_le_ramificationIdx hP h2) (Nat.le_of_dvd hpos (fourteen_dvd_inertiaDeg hP h2))

theorem mem_primesOver_two_iff {P : Ideal 𝓞L} :
    P ∈ IsDedekindDomain.primesOverFinset twoZ 𝓞L ↔ P.IsMaximal ∧ (2 : 𝓞L) ∈ P := by
  rw [IsDedekindDomain.mem_primesOverFinset_iff twoZ_ne_bot]
  constructor
  · rintro ⟨hprime, hover⟩
    have h2 : (2 : 𝓞L) ∈ P := by
      have h : ((2 : ℕ) : ℤ) ∈ P.under ℤ := by rw [← hover.over]; exact Ideal.mem_span_singleton_self _
      simpa [Ideal.under] using h
    exact ⟨hprime.isMaximal (by rintro rfl; simp at h2), h2⟩
  · rintro ⟨hP, h2⟩
    exact ⟨hP.isPrime, liesOver_two hP h2⟩

theorem finrank_fieldI_le : Module.finrank ℚ (fieldI standingField) ≤ 2 * Module.finrank ℚ standingField := by
  have h := LinearMap.finrank_le_finrank_of_surjective (toFieldI_surjective standingField)
  rwa [Module.finrank_prod, ← two_mul] at h

/-- If `t + t' = 1` and `t·t' = −8` in `𝓞 (F(i))`, some prime above 2 contains `t`: else `t' = 2y` and `y` is an integral root of
`2x² − x − 4`. -/
theorem span_two_ne_top {t t' : 𝓞L} (hsum : t + t' = 1) (hmul : t * t' = -8) : Ideal.span {(2 : 𝓞L), t} ≠ ⊤ := by
  intro h
  obtain ⟨a, b, hab⟩ := Ideal.mem_span_pair.mp (h ▸ Submodule.mem_top : (1 : 𝓞L) ∈ Ideal.span {(2 : 𝓞L), t})
  set y := a * t' - 4 * b with hy
  have h1 : t' = 2 * y := by linear_combination (-t') * hab + b * hmul
  have h3 : (2 * y) ^ 2 - 2 * y - 8 = 0 := by rw [← h1]; linear_combination t' * hsum - hmul
  have h4 : 2 * y ^ 2 - y - 4 = 0 :=
    mul_left_cancel₀ (two_ne_zero (α := 𝓞L)) (by linear_combination h3)
  refine two_sq_ne_of_isIntegral (x := (y : fieldI standingField)) (RingOfIntegers.isIntegral_coe y) ?_
  have h5 := congrArg (algebraMap 𝓞L (fieldI standingField)) h4
  rw [map_sub, map_sub, map_mul, map_pow, map_ofNat, map_ofNat, map_zero] at h5
  exact h5

theorem exists_two_primes : ∃ M₁ M₂ : Ideal 𝓞L, M₁.IsMaximal ∧ M₂.IsMaximal ∧ (2 : 𝓞L) ∈ M₁ ∧ (2 : 𝓞L) ∈ M₂ ∧
    up thetaI ∈ M₁ ∧ 1 - up thetaI ∈ M₂ ∧ M₁ ≠ M₂ := by
  obtain ⟨M₁, hM₁, h1⟩ := Ideal.exists_le_maximal _ (span_two_ne_top (t := up thetaI) (t' := 1 - up thetaI) (by ring)
    up_thetaI_mul)
  obtain ⟨M₂, hM₂, h2⟩ := Ideal.exists_le_maximal _ (span_two_ne_top (t := 1 - up thetaI) (t' := up thetaI) (by ring)
    (by rw [mul_comm]; exact up_thetaI_mul))
  have a1 : (2 : 𝓞L) ∈ M₁ := h1 (Ideal.subset_span (by simp))
  have b1 : up thetaI ∈ M₁ := h1 (Ideal.subset_span (by simp))
  have a2 : (2 : 𝓞L) ∈ M₂ := h2 (Ideal.subset_span (by simp))
  have b2 : 1 - up thetaI ∈ M₂ := h2 (Ideal.subset_span (by simp))
  refine ⟨M₁, M₂, hM₁, hM₂, a1, a2, b1, b2, ?_⟩
  rintro rfl
  exact hM₁.ne_top ((Ideal.eq_top_iff_one _).mpr (by simpa using M₁.add_mem b1 b2))

/-- **The dyadic count.** Exactly two primes of `𝓞 (F(i))` lie above 2, told apart by `θ`; each has residue field of `2¹⁴`
elements; and `[F(i):ℚ] = 56`. From `e ≥ 2`, `14 ∣ f` at each, two of them, and `Σ e·f = [F(i):ℚ] ≤ 56`. -/
theorem dyadic_summary : ∃ M₁ M₂ : Ideal 𝓞L, M₁ ≠ M₂ ∧ up thetaI ∈ M₁ ∧ 1 - up thetaI ∈ M₂ ∧
    (∀ P : Ideal 𝓞L, P.IsMaximal ∧ (2 : 𝓞L) ∈ P ↔ P = M₁ ∨ P = M₂) ∧
    (∀ P : Ideal 𝓞L, P.IsMaximal → (2 : 𝓞L) ∈ P → Nat.card (𝓞L ⧸ P) = 2 ^ 14) ∧
    Module.finrank ℚ (fieldI standingField) = 56 := by
  classical
  obtain ⟨M₁, M₂, hM₁, hM₂, h21, h22, ht1, ht2, hne⟩ := exists_two_primes
  set s := IsDedekindDomain.primesOverFinset twoZ 𝓞L with hs
  set w : Ideal 𝓞L → ℕ := fun P => twoZ.ramificationIdx' P * twoZ.inertiaDeg' P with hw
  have hmem : ∀ P, P ∈ s ↔ P.IsMaximal ∧ (2 : 𝓞L) ∈ P := fun P => mem_primesOver_two_iff
  have hw28 : ∀ P ∈ s, 28 ≤ w P := fun P hP => twentyeight_le ((hmem P).mp hP).1 ((hmem P).mp hP).2
  have hsum : ∑ P ∈ s, w P = Module.finrank ℚ (fieldI standingField) :=
    Ideal.sum_ramification_inertia 𝓞L ℚ (fieldI standingField) twoZ_ne_bot
  have h56 : Module.finrank ℚ (fieldI standingField) ≤ 56 :=
    finrank_fieldI_le.trans (by have := finrank_standingField_le; omega)
  have hcard : s.card ≤ 2 := by
    have h := Finset.card_nsmul_le_sum s w 28 hw28
    rw [smul_eq_mul, hsum] at h
    omega
  have hsub : ({M₁, M₂} : Finset (Ideal 𝓞L)) ⊆ s := by
    intro P hP
    simp only [Finset.mem_insert, Finset.mem_singleton] at hP
    rcases hP with rfl | rfl
    · exact (hmem _).mpr ⟨hM₁, h21⟩
    · exact (hmem _).mpr ⟨hM₂, h22⟩
  have hseq : ({M₁, M₂} : Finset (Ideal 𝓞L)) = s :=
    Finset.eq_of_subset_of_card_le hsub (by rw [Finset.card_pair hne]; exact hcard)
  have hsum2 : w M₁ + w M₂ = Module.finrank ℚ (fieldI standingField) := by
    rw [← hsum, ← hseq, Finset.sum_pair hne]
  have hw1 := hw28 M₁ (hsub (by simp))
  have hw2 := hw28 M₂ (hsub (by simp))
  have hall : ∀ P : Ideal 𝓞L, P.IsMaximal ∧ (2 : 𝓞L) ∈ P ↔ P = M₁ ∨ P = M₂ := by
    intro P
    rw [← hmem, ← hseq]
    simp
  refine ⟨M₁, M₂, hne, ht1, ht2, hall, ?_, by omega⟩
  intro P hP h2
  have hwP : w P = 28 := by
    rcases (hall P).mp ⟨hP, h2⟩ with rfl | rfl <;> omega
  have he := two_le_ramificationIdx hP h2
  obtain ⟨j, hj⟩ := fourteen_dvd_inertiaDeg hP h2
  have hf : twoZ.inertiaDeg' P = 14 := by
    simp only [hw] at hwP
    rw [hj] at hwP ⊢
    have hj1 : j = 1 := by nlinarith
    rw [hj1]
  rw [card_quot_eq_two_pow hP h2, hf]

end Dyadic

/-- "of degree 28". -/
theorem finrank_standingField : Module.finrank ℚ standingField = 28 := by
  obtain ⟨_, _, _, _, _, _, _, h56⟩ := dyadic_summary
  have h1 := finrank_fieldI_le
  have h2 := finrank_standingField_le
  omega

/-- "a totally real field": every embedding of `F` into `ℂ` is real (`F/ℚ` is Galois and `F ⊆ ℝ`). -/
theorem isTotallyReal_standingField (φ : standingField →+* ℂ) (x : standingField) : (φ x).im = 0 :=
  isTotallyReal_aux φ x.1 x.2

/-- "its two places above 2": exactly two primes of `F(i)` lie above 2. -/
theorem ncard_primes_above_two :
    Set.ncard {P : Ideal (𝓞 (fieldI standingField)) | P.IsMaximal ∧ (2 : 𝓞 (fieldI standingField)) ∈ P} = 2 := by
  obtain ⟨M₁, M₂, hne, -, -, hall, -, -⟩ := dyadic_summary
  have h : {P : Ideal 𝓞L | P.IsMaximal ∧ (2 : 𝓞L) ∈ P} = {M₁, M₂} := by
    ext P
    simpa using hall P
  rw [h, Set.ncard_pair hne]

/-- "are inert in F(i)", first half: every prime of `F(i)` above 2 is fixed by conjugation (a place of `F` not split). -/
theorem comap_conj_of_two_mem (P : Ideal (𝓞 (fieldI standingField))) (hP : P.IsMaximal)
    (h2 : (2 : 𝓞 (fieldI standingField)) ∈ P) : P.comap (conjO standingField) = P := by
  obtain ⟨M₁, M₂, hne, ht1, ht2, hall, -, -⟩ := dyadic_summary
  have hsurj : Function.Surjective (conjO standingField) := fun x => ⟨conjO standingField x, conjO_conjO x⟩
  haveI := hP
  have hmax : (P.comap (conjO standingField)).IsMaximal := Ideal.comap_isMaximal_of_surjective _ hsurj
  have h2' : (2 : 𝓞L) ∈ P.comap (conjO standingField) := by rw [Ideal.mem_comap, map_ofNat]; exact h2
  have key : up thetaI ∈ P.comap (conjO standingField) ↔ up thetaI ∈ P := by rw [Ideal.mem_comap, conjO_up]
  have hM₂ : M₂ ≠ ⊤ := ((hall M₂).mpr (Or.inr rfl)).1.ne_top
  have hno : up thetaI ∉ M₂ := fun h =>
    hM₂ ((Ideal.eq_top_iff_one _).mpr (by simpa using M₂.add_mem h ht2))
  rcases (hall _).mp ⟨hmax, h2'⟩ with h | h <;> rcases (hall P).mp ⟨hP, h2⟩ with h' | h'
  · rw [h, h']
  · exact absurd (h' ▸ key.mp (h ▸ ht1)) hno
  · exact absurd (h ▸ key.mpr (h' ▸ ht1)) hno
  · rw [h, h']

/-- "inert in F(i), each of norm 128": at a stable prime above 2 the residue field has `128²` elements and conjugation is not the
identity on it — so its fixed field, the residue field of `F`, has 128. -/
theorem card_quotient_of_two_mem (P : StablePrime standingField) (h2 : (2 : 𝓞 (fieldI standingField)) ∈ P.P) :
    Nat.card (𝓞 (fieldI standingField) ⧸ P.P) = 128 ^ 2 ∧
      ∃ x : 𝓞 (fieldI standingField), conjO standingField x - x ∉ P.P := by
  obtain ⟨-, -, -, -, -, -, hcard, -⟩ := dyadic_summary
  refine ⟨by rw [hcard P.P P.isMaximal h2]; norm_num, omO, fun hmem => ?_⟩
  have hsq : (conjO standingField omO - omO) ^ 2 = -3 := by
    rw [conjO_omO]; linear_combination iO ^ 2 * up_s3I_sq + 3 * iO_sq
  have h3 : (3 : 𝓞L) ∈ P.P := by
    have h := Ideal.pow_mem_of_mem P.P hmem 2 (by norm_num)
    rw [hsq] at h
    simpa using P.P.neg_mem h
  have h1 : (1 : 𝓞L) ∈ P.P := by
    have h := P.P.sub_mem h3 h2
    have e : (3 : 𝓞L) - 2 = 1 := by norm_num
    rwa [e] at h
  exact P.isMaximal.ne_top ((Ideal.eq_top_iff_one _).mpr h1)

/-- **Every usable residue field of `F` has at least 347 elements** (the row's clause, sharpened to the least value). -/
theorem usable_card_ge (w : Ideal (𝓞 standingField)) (hw : w.IsMaximal)
    (h : Nat.card (𝓞 standingField ⧸ w) % 4 = 3) : 347 ≤ Nat.card (𝓞 standingField ⧸ w) := by
  haveI := hw
  letI : Field (𝓞 standingField ⧸ w) := Ideal.Quotient.field w
  haveI : Finite (𝓞 standingField ⧸ w) := Nat.finite_of_card_ne_zero (by omega)
  refine card_ge_of_usable h (s3 := Ideal.Quotient.mk w s3I) (s11 := Ideal.Quotient.mk w s11I)
    (e := Ideal.Quotient.mk w etaI) ?_ ?_ ?_
  · rw [← map_pow, s3I_sq, map_ofNat]
  · rw [← map_pow, s11I_sq, map_ofNat]
  · rw [← aeval_gPoly, aeval_gPoly_map, aeval_etaI, map_zero]

/-- "none of its places has a usable residue field of size at most 47" — the row's words. -/
theorem no_small_usable (w : Ideal (𝓞 standingField)) (hw : w.IsMaximal)
    (h : Nat.card (𝓞 standingField ⧸ w) % 4 = 3) : 47 < Nat.card (𝓞 standingField ⧸ w) :=
  lt_of_lt_of_le (by norm_num) (usable_card_ge w hw h)

/-- **A stable prime above 2 exists** — the inhabitant of `card_quotient_of_two_mem`'s hypotheses, and of `StablePrime F`. -/
theorem exists_stablePrime_two : ∃ P : StablePrime standingField, (2 : 𝓞 (fieldI standingField)) ∈ P.P := by
  obtain ⟨M₁, -, hM₁, -, h2, -⟩ := exists_two_primes
  exact ⟨⟨M₁, hM₁, comap_conj_of_two_mem M₁ hM₁ h2⟩, h2⟩

/-- Conjugation is not the identity modulo any stable prime: `ω` moves at a dyadic one, `i` at an odd one. -/
theorem exists_conjO_sub_notMem (P : StablePrime standingField) :
    ∃ x : 𝓞 (fieldI standingField), conjO standingField x - x ∉ P.P := by
  by_cases h2 : (2 : 𝓞L) ∈ P.P
  · exact (card_quotient_of_two_mem P h2).2
  · refine ⟨iO, fun hmem => ?_⟩
    have h : (2 : 𝓞L) * iO ∈ P.P := by
      have e : conjO standingField iO - iO = -(2 * iO) := by rw [conjO_iO]; ring
      rw [e] at hmem
      simpa using P.P.neg_mem hmem
    rcases P.isMaximal.isPrime.mem_or_mem h with h | h
    · exact h2 h
    · have h1 : (1 : 𝓞L) ∈ P.P := by
        have h' := P.P.neg_mem (Ideal.pow_mem_of_mem P.P h 2 (by norm_num))
        rwa [iO_sq, neg_neg] at h'
      exact P.isMaximal.ne_top ((Ideal.eq_top_iff_one _).mpr h1)

/-- The same on the stable primes of `F(i)`, the form `localBound` reads: a stable prime is dyadic of residue size `128²`, or
its residue field has `Q²` elements with `Q ≡ 3 (mod 4)`, `Q ≥ 347`. -/
theorem stablePrime_card (P : StablePrime standingField) :
    Nat.card (𝓞 (fieldI standingField) ⧸ P.P) = 128 ^ 2 ∨
      ∃ Q : ℕ, Q % 4 = 3 ∧ 347 ≤ Q ∧ Nat.card (𝓞 (fieldI standingField) ⧸ P.P) = Q ^ 2 := by
  by_cases h2 : (2 : 𝓞L) ∈ P.P
  · exact Or.inl (card_quotient_of_two_mem P h2).1
  · right
    haveI := P.isMaximal
    letI : Field (𝓞L ⧸ P.P) := Ideal.Quotient.field P.P
    let σ : (𝓞L ⧸ P.P) →+* (𝓞L ⧸ P.P) := Ideal.quotientMap P.P (conjO standingField) P.comap_conj.ge
    have hσmk : ∀ x, σ (Ideal.Quotient.mk P.P x) = Ideal.Quotient.mk P.P (conjO standingField x) := fun x =>
      Ideal.quotientMap_mk
    have hσ : ∀ x, σ (σ x) = x := fun x => by
      obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
      rw [hσmk, hσmk, conjO_conjO]
    have h2k : (2 : 𝓞L ⧸ P.P) ≠ 0 := by
      rw [← map_ofNat (Ideal.Quotient.mk P.P) 2, Ne, Ideal.Quotient.eq_zero_iff_mem]; exact h2
    obtain ⟨hcard, hmod⟩ := card_fixed_of_involution σ hσ (ι := Ideal.Quotient.mk P.P iO)
      (by rw [← map_pow, iO_sq, map_neg, map_one]) (by rw [hσmk, conjO_iO, map_neg]) h2k
    refine ⟨Nat.card (σ.eqLocusField (RingHom.id _)), hmod, ?_, hcard⟩
    have hfix : ∀ x : 𝓞 standingField, σ (Ideal.Quotient.mk P.P (up x)) = Ideal.Quotient.mk P.P (up x) := fun x => by
      rw [hσmk, conjO_up]
    refine card_ge_of_usable hmod (s3 := ⟨Ideal.Quotient.mk P.P (up s3I), hfix _⟩)
      (s11 := ⟨Ideal.Quotient.mk P.P (up s11I), hfix _⟩) (e := ⟨Ideal.Quotient.mk P.P (up etaI), hfix _⟩) ?_ ?_ ?_
    · refine Subfield.subtype_injective _ ?_
      rw [map_pow, map_ofNat]
      show Ideal.Quotient.mk P.P (up s3I) ^ 2 = 3
      rw [← map_pow, up_s3I_sq, map_ofNat]
    · refine Subfield.subtype_injective _ ?_
      rw [map_pow, map_ofNat]
      show Ideal.Quotient.mk P.P (up s11I) ^ 2 = 11
      rw [← map_pow, up_s11I_sq, map_ofNat]
    · rw [← aeval_gPoly]
      refine Subfield.subtype_injective _ ?_
      rw [← aeval_gPoly_map, map_zero]
      exact (aeval_gPoly_map (Ideal.Quotient.mk P.P) (up etaI)).trans (by rw [aeval_up_etaI, map_zero])

/-! ### The floor, a named hypothesis from outside the backlog, and the two conditional clauses -/

/-- The level-one residue target of a field `k` with an involution `σ`: `Cay(k, {x : x·σ(x) = 1})` — `Γ_Q` when `k = 𝔽_{Q²}`
with `Q ≡ 3 (mod 4)`, `U_Q` when `Q` is a power of 2. -/
def normOneCayley (k : Type*) [Field k] (σ : k →+* k) : SimpleGraph k :=
  SimpleGraph.fromRel fun x y => (x - y) * σ (x - y) = 1

/-- **The floor at one residue size**: every field of `Q²` elements with a non-trivial involution has a level-one target
needing at least `n` colours. -/
def TargetFloor (n Q : ℕ) : Prop :=
  ∀ (k : Type) [Field k] [Finite k] (σ : k →+* k), (∀ x, σ (σ x) = x) → σ ≠ RingHom.id k → Nat.card k = Q ^ 2 →
    (n : ℕ∞) ≤ (normOneCayley k σ).chromaticNumber

/-- **The floor this field reads — a named hypothesis from outside the backlog (G56).** At `n = 7`: `χ(U₁₂₈) ≥ 7` ("U₁₂₈'s
Hoffman floor is 8") and `χ(Γ_Q) ≥ 7` for every `Q ≡ 3 (mod 4)`, `Q ≥ 347` ("by Weil from 98"). [tools]/[hand], not kernel. -/
def StandingFloor (n : ℕ) : Prop :=
  TargetFloor n 128 ∧ ∀ Q : ℕ, Q % 4 = 3 → 347 ≤ Q → TargetFloor n Q

theorem targetFloor_zero (Q : ℕ) : TargetFloor 0 Q := fun _ _ _ _ _ _ _ => by simp

/-- **"so `L(F) ≥ n`", given the floor at `n`.** -/
theorem le_localBound (n : ℕ) (hFloor : StandingFloor n) : (n : ℕ∞) ≤ localBound standingField := by
  refine le_iInf fun P => ?_
  haveI hmax : (P.P ^ 1).IsMaximal := by rw [pow_one]; exact P.isMaximal
  letI : Field (𝓞L ⧸ P.P ^ 1) := Ideal.Quotient.field (P.P ^ 1)
  let σ : (𝓞L ⧸ P.P ^ 1) →+* (𝓞L ⧸ P.P ^ 1) := Ideal.quotientMap (P.P ^ 1) (conjO standingField) (P.le_comap 1)
  have hσmk : ∀ x, σ (Ideal.Quotient.mk (P.P ^ 1) x) = Ideal.Quotient.mk (P.P ^ 1) (conjO standingField x) := fun x =>
    Ideal.quotientMap_mk
  have hσ : ∀ x, σ (σ x) = x := fun x => by
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
    rw [hσmk, hσmk, conjO_conjO]
  have hne : σ ≠ RingHom.id _ := by
    obtain ⟨x, hx⟩ := exists_conjO_sub_notMem P
    intro h
    have h1 : σ (Ideal.Quotient.mk (P.P ^ 1) x) = Ideal.Quotient.mk (P.P ^ 1) x := by rw [h]; rfl
    rw [hσmk, ← sub_eq_zero, ← map_sub, Ideal.Quotient.eq_zero_iff_mem, pow_one] at h1
    exact hx h1
  have hcard : Nat.card (𝓞L ⧸ P.P ^ 1) = Nat.card (𝓞L ⧸ P.P) := by rw [pow_one]
  have hgraph : levelTarget P 1 = normOneCayley (𝓞L ⧸ P.P ^ 1) σ := rfl
  rw [hgraph]
  rcases stablePrime_card P with h | ⟨Q, hQ4, hQ, h⟩
  · exact hFloor.1 _ σ hσ hne (hcard.trans h)
  · exact hFloor.2 Q hQ4 hQ _ σ hσ hne (hcard.trans h)

/-- **"so L(F) ≥ 7"**, given the floor (G56) as a named hypothesis. -/
theorem seven_le_localBound (hFloor : StandingFloor 7) : 7 ≤ localBound standingField :=
  le_localBound 7 hFloor

/-- **"and given MR, χ(F²) ≥ 5"**: from the floor at five and row 123's chain (`hRow123`, the conclusion of
`SpectralChain.min_localBound_five_le_chromaticNumber`; MR is inside it and is never imported here). -/
theorem five_le_chromaticNumber (hFloor : StandingFloor 5)
    (hRow123 : min (localBound standingField) 5 ≤ ((unitDistance ℂ).induce (planeOver standingField)).chromaticNumber) :
    5 ≤ ((unitDistance ℂ).induce (planeOver standingField)).chromaticNumber := by
  have h5 : (5 : ℕ∞) ≤ localBound standingField := le_localBound 5 hFloor
  rwa [min_eq_right h5] at hRow123

/-! ## Spec -/

-- the period is real and built from two cosines: `η = 2cos(2π/29) + 2cos(24π/29)`.
example : eta = 2 * Real.cos (2 * Real.pi / 29) + 2 * Real.cos (24 * Real.pi / 29) := rfl
-- `{1, 12, 17, 28}` is the subgroup of fourth roots of unity mod 29, and `2` generates `(ℤ/29)ˣ` (so `f = 7` in `E₇`).
example : ∀ h ∈ ([1, 12, 17, 28] : List (ZMod 29)), h ^ 4 = 1 := by decide
example : orderOf (2 : ZMod 29) = 28 := by
  rw [orderOf_eq_iff (by norm_num)]
  exact ⟨by decide, by decide⟩
-- `normOneCayley` on `ℂ` with conjugation is the unit-distance relation: `1` and `0` are adjacent.
example : (normOneCayley ℂ (starRingEnd ℂ)).Adj 1 0 := by
  simp [normOneCayley, SimpleGraph.fromRel_adj]

-- the abstract usable clause is attained at 347: `ZMod 347` holds square roots of 3 and 11 and a root of `g`, and `347 ≡ 3 (mod 4)`
-- (so `card_ge_of_usable`'s hypotheses have a model, and its bound is the least).
example : (95 : ZMod 347) ^ 2 = 3 ∧ (59 : ZMod 347) ^ 2 = 11 ∧
    (8 : ZMod 347) ^ 7 + 8 ^ 6 - 12 * 8 ^ 5 - 7 * 8 ^ 4 + 28 * 8 ^ 3 + 14 * 8 ^ 2 - 9 * 8 + 1 = 0 ∧ 347 % 4 = 3 := by decide
-- the finite check: below 347 nothing passes, and 347 itself does (the bound in `usableBelow_347` cannot be raised).
example : usableBelow 347 = true ∧ usableBelow 348 = false := by decide +kernel
-- cyclic convolution: `ζ · ζ²⁸ = 1` in `ℤ[C₂₉]`.
example : cconv (fun k => if k = 1 then 1 else 0) (fun k => if k = 28 then 1 else 0) = cdelta 1 := by decide +kernel
-- `anyBelow`, `sqMod`, `gRootMod` on small inputs: 3 is a square mod 11 (5² = 25), not mod 7; `g(8) ≡ 0 (mod 347)`.
example : anyBelow (fun c => c == 3) 4 = true ∧ anyBelow (fun c => c == 3) 3 = false := by decide
example : sqMod 11 3 = true ∧ sqMod 7 3 = false ∧ gRootMod 347 = true ∧ gRootMod 2 = false := by decide +kernel
-- `gPoly` is the period polynomial: its value at 1 is 17 and at 2 is −41 (two of the sign points).
example : Polynomial.aeval (1 : ℤ) gPoly = 17 ∧ Polynomial.aeval (2 : ℤ) gPoly = -41 := by
  rw [aeval_gPoly, aeval_gPoly]; norm_num
-- the elements of `F` and `F(i)` are what their names say.
example : (s3F : ℝ) = Real.sqrt 3 ∧ (s11F : ℝ) = Real.sqrt 11 ∧ (etaF : ℝ) = eta := ⟨rfl, rfl, rfl⟩
example : ((iL : fieldI standingField) : ℂ) = Complex.I := rfl
example : ((toL s3F : fieldI standingField) : ℂ) = (Real.sqrt 3 : ℝ) := rfl
example : twoZ = Ideal.span {(2 : ℤ)} := rfl

end HadwigerNelson.StandingFive
