import Proofs.HadwigerNelson.Arith.StandingFive
import Mathlib.FieldTheory.Finite.Basic
import Mathlib.NumberTheory.LegendreSymbol.QuadraticChar.Basic
import Mathlib.Dynamics.PeriodicPts.Defs

namespace HadwigerNelson.StandingFive

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


-- NEGATIVE CONTROL (scratch only): must fail
-- theorem usableBelow_348 : usableBelow 348 = true := by decide +kernel

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

end HadwigerNelson.StandingFive
