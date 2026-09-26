import Proofs.HadwigerNelson.Transcendental
import Proofs.HadwigerNelson.Instances.FinitePlane11
import Proofs.HadwigerNelson.SpectralChain

/-!
# `χ(ℚ(√47)²) ≤ 5`: Theorem A at the prime 11, by an elementary descent

The upper half of the five-colour clause at `ℚ(√47)` (`plans/FS100-K-kernel-47.md` §D, node U; X11K2 stage 1).

**Why it is true.** `47 ≡ 3 ≡ 5² (mod 11)` and `11 ≡ 3 (mod 4)`: the prime 11 splits in `ℚ(√47)` with residue field `𝔽₁₁`,
where `−1` is not a square. Every element of `ℚ(√47)` is `a + b√47` with `a, b ∈ ℚ`, uniquely (`coords_unique`, from the
irrationality of `√47`). On the subring `A` of elements whose two coordinates have denominators prime to 11, reduction
`a + b√47 ↦ a + 5b` is a ring map onto `ZMod 11` (`phi`; `5² = 25 ≡ 47`). Every unit vector of `ℚ(√47)²` lies in `A²`
(`unit_mem_A`): clearing denominators, `A² + 47B² + C² + 47E² = n²` and `AB + CE = 0`, and if `11 ∣ n` then
`(A ± 5B)² + (C ± 5E)² ≡ 0 (mod 11)` forces `A ≡ B ≡ C ≡ E ≡ 0`, so all five divide by 11 and the denominator drops
(`int_descent`, strong induction on `n`). The kernel's coset step (`RouteC.unitQuadrance_colorable_of_subring`) then pulls the
five-colouring of `Γ₁₁` (`chromaticNumber_finitePlane11`) back to the whole plane.

**What it avoids.** No valuation subring, no number-field machinery: the field-level gap of Theorem A (row 57's) is not
crossed here, only stepped around for one field, as Theorem B's parity descent does at 2 (`FieldWall4.lean`).

## Main results

* `coords_unique`, `mem_q47_of_mem` — the normal form of `ℚ(√47)`;
* `A`, `phi` — the 11-integral subring and its residue map;
* `int_descent`, `unit_mem_A` — every unit vector is 11-integral;
* `chromaticNumber_planeOver_sqrt47_le_five` — **`χ(ℚ(√47)²) ≤ 5`**, standard three axioms;
* `chromaticNumber_planeOver_sqrt47_eq_five_of_chain` — `χ(ℚ(√47)²) = 5` given SP-Cor's named hypotheses (`SpectralChain`).
-/

namespace HadwigerNelson
namespace SqrtFortySeven

open SimpleGraph RouteC

/-- `ℚ(√47)`, as a subfield of `ℝ`. -/
noncomputable abbrev F47 : Subfield ℝ := SquareClass.fieldOfRadicands {47}

/-- `√47`. -/
noncomputable abbrev s : ℝ := Real.sqrt 47

theorem s_mul_s : s * s = 47 := Real.mul_self_sqrt (by norm_num)

theorem irrational_s : Irrational s := by
  have h := Nat.Prime.irrational_sqrt (show Nat.Prime 47 by norm_num)
  simpa using h

/-! ### The normal form `a + b√47` -/

/-- **Coordinates are unique**: `a + b√47 = c + e√47` with rational `a, b, c, e` forces `a = c` and `b = e`. -/
theorem coords_unique {a b c e : ℚ} (h : (a : ℝ) + b * s = c + e * s) : a = c ∧ b = e := by
  have hbe : b = e := by
    by_contra hne
    apply irrational_s
    have hd : ((b : ℝ) - e) ≠ 0 := sub_ne_zero.mpr (by exact_mod_cast hne)
    refine ⟨(c - a) / (b - e), ?_⟩
    push_cast
    rw [div_eq_iff hd]
    linear_combination -h
  subst hbe
  refine ⟨?_, rfl⟩
  have : (a : ℝ) = c := by linear_combination h
  exact_mod_cast this

/-- The norm form `a² − 47b²` vanishes only at `0`. -/
theorem norm_eq_zero {a b : ℚ} (h : a ^ 2 - 47 * b ^ 2 = 0) : a = 0 ∧ b = 0 := by
  by_cases hb : b = 0
  · subst hb
    exact ⟨by simpa using h, rfl⟩
  · exfalso
    apply irrational_s
    refine ⟨|a / b|, ?_⟩
    have h47 : ((a / b : ℚ) : ℝ) ^ 2 = 47 := by
      have : (a / b) ^ 2 = 47 := by
        rw [div_pow, div_eq_iff (pow_ne_zero 2 hb)]
        linear_combination h
      exact_mod_cast this
    rw [Rat.cast_abs, ← Real.sqrt_sq_eq_abs, h47]

/-- **The field `{a + b√47 : a, b ∈ ℚ}`.** Closed under inverses through the norm form: `(a + b√47)(a − b√47) = a² − 47b²`,
which is nonzero off `0` (`norm_eq_zero`). -/
noncomputable def q47 : Subfield ℝ where
  carrier := {x | ∃ a b : ℚ, x = a + b * s}
  zero_mem' := ⟨0, 0, by simp⟩
  one_mem' := ⟨1, 0, by simp⟩
  add_mem' := by
    rintro _ _ ⟨a, b, rfl⟩ ⟨c, e, rfl⟩
    exact ⟨a + c, b + e, by push_cast; ring⟩
  neg_mem' := by
    rintro _ ⟨a, b, rfl⟩
    exact ⟨-a, -b, by push_cast; ring⟩
  mul_mem' := by
    rintro _ _ ⟨a, b, rfl⟩ ⟨c, e, rfl⟩
    exact ⟨a * c + 47 * b * e, a * e + b * c, by push_cast; linear_combination (b * e : ℝ) * s_mul_s⟩
  inv_mem' := by
    rintro _ ⟨a, b, rfl⟩
    by_cases hD : a ^ 2 - 47 * b ^ 2 = 0
    · obtain ⟨rfl, rfl⟩ := norm_eq_zero hD
      exact ⟨0, 0, by simp⟩
    · refine ⟨a / (a ^ 2 - 47 * b ^ 2), -b / (a ^ 2 - 47 * b ^ 2), ?_⟩
      have hD' : ((a : ℝ) ^ 2 - 47 * b ^ 2) ≠ 0 := by exact_mod_cast hD
      apply inv_eq_of_mul_eq_one_right
      push_cast
      rw [show (a : ℝ) / ((a : ℝ) ^ 2 - 47 * (b : ℝ) ^ 2) + -(b : ℝ) / ((a : ℝ) ^ 2 - 47 * (b : ℝ) ^ 2) * s =
          ((a : ℝ) - b * s) / ((a : ℝ) ^ 2 - 47 * (b : ℝ) ^ 2) by ring, ← mul_div_assoc, div_eq_one_iff_eq hD']
      linear_combination (-(b : ℝ) ^ 2) * s_mul_s

/-- `ℚ(√47) ⊆ {a + b√47}`: the generator `√47` is `0 + 1·√47`. -/
theorem f47_le_q47 : F47 ≤ q47 := by
  refine Subfield.closure_le.mpr ?_
  rintro _ ⟨d, hd, rfl⟩
  rw [Set.mem_singleton_iff] at hd
  subst hd
  exact ⟨0, 1, by simp⟩

/-- **The normal form**: every element of `ℚ(√47)` is `a + b√47`. -/
theorem mem_q47_of_mem (x : F47) : ∃ a b : ℚ, (x : ℝ) = a + b * s := f47_le_q47 x.2

/-- The rational coordinate of `x ∈ ℚ(√47)`. -/
noncomputable def re47 (x : F47) : ℚ := (mem_q47_of_mem x).choose

/-- The `√47`-coordinate of `x ∈ ℚ(√47)`. -/
noncomputable def im47 (x : F47) : ℚ := (mem_q47_of_mem x).choose_spec.choose

theorem coe_eq (x : F47) : (x : ℝ) = re47 x + im47 x * s := (mem_q47_of_mem x).choose_spec.choose_spec

/-- The coordinates are read off any representation. -/
theorem coords_of_eq {x : F47} {a b : ℚ} (h : (x : ℝ) = a + b * s) : re47 x = a ∧ im47 x = b :=
  coords_unique ((coe_eq x).symm.trans h)

theorem coords_add (x y : F47) : re47 (x + y) = re47 x + re47 y ∧ im47 (x + y) = im47 x + im47 y :=
  coords_of_eq (by rw [Subfield.coe_add, coe_eq x, coe_eq y]; push_cast; ring)

theorem coords_neg (x : F47) : re47 (-x) = -re47 x ∧ im47 (-x) = -im47 x :=
  coords_of_eq (by rw [Subfield.coe_neg, coe_eq x]; push_cast; ring)

theorem coords_mul (x y : F47) :
    re47 (x * y) = re47 x * re47 y + 47 * im47 x * im47 y ∧ im47 (x * y) = re47 x * im47 y + im47 x * re47 y :=
  coords_of_eq (by
    rw [Subfield.coe_mul, coe_eq x, coe_eq y]; push_cast
    linear_combination (im47 x * im47 y : ℝ) * s_mul_s)

theorem coords_zero : re47 0 = 0 ∧ im47 0 = 0 := coords_of_eq (by simp)

theorem coords_one : re47 1 = 1 ∧ im47 1 = 0 := coords_of_eq (by simp)

/-! ### The 11-integral rationals and reduction modulo 11 -/

/-- `ZMod 11` is a field. -/
local instance : Fact (Nat.Prime 11) := ⟨by norm_num⟩

/-- A rational is **11-integral** when its denominator is prime to 11. -/
def IsElevenIntegral (q : ℚ) : Prop := ((q.den : ℕ) : ZMod 11) ≠ 0

private theorem isElevenIntegral_of_den_dvd {q : ℚ} {n : ℕ} (h : q.den ∣ n) (hn : (n : ZMod 11) ≠ 0) :
    IsElevenIntegral q := by
  obtain ⟨k, rfl⟩ := h
  intro hq
  exact hn (by rw [Nat.cast_mul, hq, zero_mul])

/-- **The 11-integral rationals** `ℤ₍₁₁₎`. -/
def z11 : Subring ℚ where
  carrier := {q | IsElevenIntegral q}
  add_mem' {q r} hq hr :=
    isElevenIntegral_of_den_dvd (Rat.add_den_dvd q r) (by rw [Nat.cast_mul]; exact mul_ne_zero hq hr)
  mul_mem' {q r} hq hr :=
    isElevenIntegral_of_den_dvd (Rat.mul_den_dvd q r) (by rw [Nat.cast_mul]; exact mul_ne_zero hq hr)
  zero_mem' := by show ((1 : ℕ) : ZMod 11) ≠ 0; decide
  one_mem' := by show ((1 : ℕ) : ZMod 11) ≠ 0; decide
  neg_mem' {q} hq := hq

/-- **Reduction modulo 11** on `ℤ₍₁₁₎`: `Rat.cast` into the field `ZMod 11`, additive and multiplicative once denominators do
not vanish (`Rat.cast_add_of_ne_zero`, `Rat.cast_mul_of_ne_zero`). -/
noncomputable def red : z11 →+* ZMod 11 where
  toFun q := ((q : ℚ) : ZMod 11)
  map_one' := Rat.cast_one
  map_mul' x y := Rat.cast_mul_of_ne_zero x.2 y.2
  map_zero' := Rat.cast_zero
  map_add' x y := Rat.cast_add_of_ne_zero x.2 y.2

/-- `A / n` is 11-integral when `11 ∤ n`: its reduced denominator divides `n`. -/
theorem div_mem_z11 (A : ℤ) {n : ℕ} (hn : ¬ 11 ∣ n) : (A : ℚ) / n ∈ z11 := by
  show (((A : ℚ) / n).den : ZMod 11) ≠ 0
  have h := Rat.den_dvd A n
  rw [← Rat.intCast_div_eq_divInt, Int.cast_natCast] at h
  intro h0
  rw [ZMod.natCast_eq_zero_iff] at h0
  exact hn (Int.natCast_dvd_natCast.mp ((Int.natCast_dvd_natCast.mpr h0).trans h))

/-! ### The subring `A` and the residue map `a + b√47 ↦ a + 5b` -/

/-- **The elements of `ℚ(√47)` with 11-integral coordinates.** -/
noncomputable def A : Subring F47 where
  carrier := {x | re47 x ∈ z11 ∧ im47 x ∈ z11}
  add_mem' {x y} hx hy := by
    rw [Set.mem_setOf_eq, (coords_add x y).1, (coords_add x y).2]
    exact ⟨add_mem hx.1 hy.1, add_mem hx.2 hy.2⟩
  mul_mem' {x y} hx hy := by
    rw [Set.mem_setOf_eq, (coords_mul x y).1, (coords_mul x y).2]
    have h47 : (47 : ℚ) ∈ z11 := by
      show (((47 : ℚ).den : ℕ) : ZMod 11) ≠ 0
      decide
    exact ⟨add_mem (mul_mem hx.1 hy.1) (mul_mem (mul_mem h47 hx.2) hy.2),
      add_mem (mul_mem hx.1 hy.2) (mul_mem hx.2 hy.1)⟩
  zero_mem' := by
    rw [Set.mem_setOf_eq, coords_zero.1, coords_zero.2]
    exact ⟨zero_mem _, zero_mem _⟩
  one_mem' := by
    rw [Set.mem_setOf_eq, coords_one.1, coords_one.2]
    exact ⟨one_mem _, zero_mem _⟩
  neg_mem' {x} hx := by
    rw [Set.mem_setOf_eq, (coords_neg x).1, (coords_neg x).2]
    exact ⟨neg_mem hx.1, neg_mem hx.2⟩

theorem mem_A {x : F47} : x ∈ A ↔ re47 x ∈ z11 ∧ im47 x ∈ z11 := Iff.rfl

/-- The two coordinates of `x ∈ A`, as elements of `ℤ₍₁₁₎`. -/
noncomputable def reA (x : A) : z11 := ⟨re47 x, (mem_A.mp x.2).1⟩

/-- The `√47`-coordinate, in `ℤ₍₁₁₎`. -/
noncomputable def imA (x : A) : z11 := ⟨im47 x, (mem_A.mp x.2).2⟩

/-- `47 ≡ 5² (mod 11)`. -/
theorem forty_seven_eq : (47 : ZMod 11) = 5 ^ 2 := by decide

/-- **The residue map** `a + b√47 ↦ a + 5b`: a ring hom because `5² ≡ 47 (mod 11)`. -/
noncomputable def phi : A →+* ZMod 11 where
  toFun x := red (reA x) + 5 * red (imA x)
  map_one' := by
    have h1 : reA 1 = 1 := Subtype.ext coords_one.1
    have h2 : imA 1 = 0 := Subtype.ext coords_one.2
    rw [h1, h2, map_one, map_zero, mul_zero, add_zero]
  map_mul' x y := by
    have h1 : reA (x * y) = reA x * reA y + 47 * imA x * imA y := Subtype.ext (by
      simp only [reA, imA, Subring.coe_mul, Subring.coe_add]
      rw [(coords_mul x y).1, show ((47 : z11) : ℚ) = 47 from rfl])
    have h2 : imA (x * y) = reA x * imA y + imA x * reA y := Subtype.ext (by
      simp only [reA, imA, Subring.coe_mul, Subring.coe_add]
      rw [(coords_mul x y).2])
    rw [h1, h2]
    simp only [map_add, map_mul, map_ofNat]
    rw [forty_seven_eq]
    ring
  map_zero' := by
    have h1 : reA 0 = 0 := Subtype.ext coords_zero.1
    have h2 : imA 0 = 0 := Subtype.ext coords_zero.2
    rw [h1, h2, map_zero, mul_zero, add_zero]
  map_add' x y := by
    have h1 : reA (x + y) = reA x + reA y := Subtype.ext (coords_add x y).1
    have h2 : imA (x + y) = imA x + imA y := Subtype.ext (coords_add x y).2
    rw [h1, h2, map_add, map_add]
    ring

/-! ### The descent: every unit vector is 11-integral -/

/-- No isotropic vectors modulo 11 (`11 ≡ 3 mod 4`), in the 121 cases. -/
theorem sq_add_sq_eq_zero_mod11 : ∀ x y : ZMod 11, x ^ 2 + y ^ 2 = 0 → x = 0 ∧ y = 0 := by decide

/-- **The circle equations of `𝔽₁₁` at `n ≡ 0`**: `a² + 47b² + c² + 47e² ≡ 0` and `ab + ce ≡ 0` force `a ≡ b ≡ c ≡ e ≡ 0`,
because `(a ± 5b)² + (c ± 5e)² ≡ 0` for both signs. -/
theorem zmod_key (a b c e : ZMod 11) (h1 : a ^ 2 + 47 * b ^ 2 + c ^ 2 + 47 * e ^ 2 = 0) (h2 : a * b + c * e = 0) :
    a = 0 ∧ b = 0 ∧ c = 0 ∧ e = 0 := by
  have h11 : (11 : ZMod 11) = 0 := by decide
  obtain ⟨hp1, hp2⟩ := sq_add_sq_eq_zero_mod11 (a + 5 * b) (c + 5 * e)
    (by linear_combination h1 + 10 * h2 - 2 * (b ^ 2 + e ^ 2) * h11)
  obtain ⟨hm1, hm2⟩ := sq_add_sq_eq_zero_mod11 (a - 5 * b) (c - 5 * e)
    (by linear_combination h1 - 10 * h2 - 2 * (b ^ 2 + e ^ 2) * h11)
  exact ⟨by linear_combination 6 * hp1 + 6 * hm1 - a * h11, by linear_combination -hp1 + hm1 + b * h11,
    by linear_combination 6 * hp2 + 6 * hm2 - c * h11, by linear_combination -hp2 + hm2 + e * h11⟩

/-- **The descent step**: if `11 ∣ n`, the integer circle equations force `11` to divide `A, B, C, E`. -/
theorem eleven_dvd {A B C E n : ℤ} (h1 : A ^ 2 + 47 * B ^ 2 + C ^ 2 + 47 * E ^ 2 = n ^ 2) (h2 : A * B + C * E = 0)
    (hn : (11 : ℤ) ∣ n) : (11 : ℤ) ∣ A ∧ (11 : ℤ) ∣ B ∧ (11 : ℤ) ∣ C ∧ (11 : ℤ) ∣ E := by
  have hn0 : (n : ZMod 11) = 0 := (ZMod.intCast_zmod_eq_zero_iff_dvd n 11).mpr hn
  have k1 := congrArg (Int.cast : ℤ → ZMod 11) h1
  have k2 := congrArg (Int.cast : ℤ → ZMod 11) h2
  push_cast at k1 k2
  rw [hn0] at k1
  obtain ⟨ha, hb, hc, he⟩ := zmod_key _ _ _ _ (by rw [k1]; ring) k2
  exact ⟨(ZMod.intCast_zmod_eq_zero_iff_dvd A 11).mp ha, (ZMod.intCast_zmod_eq_zero_iff_dvd B 11).mp hb,
    (ZMod.intCast_zmod_eq_zero_iff_dvd C 11).mp hc, (ZMod.intCast_zmod_eq_zero_iff_dvd E 11).mp he⟩

/-- **The descent**, by strong induction on the common denominator `n`: a solution of the integer circle equations over `n`
has 11-integral quotients. -/
theorem int_descent (n : ℕ) : 0 < n → ∀ A B C E : ℤ, A ^ 2 + 47 * B ^ 2 + C ^ 2 + 47 * E ^ 2 = (n : ℤ) ^ 2 →
    A * B + C * E = 0 →
    (A : ℚ) / n ∈ z11 ∧ (B : ℚ) / n ∈ z11 ∧ (C : ℚ) / n ∈ z11 ∧ (E : ℚ) / n ∈ z11 := by
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    intro hn A B C E h1 h2
    by_cases h11 : 11 ∣ n
    · obtain ⟨m, rfl⟩ := h11
      obtain ⟨⟨A', rfl⟩, ⟨B', rfl⟩, ⟨C', rfl⟩, ⟨E', rfl⟩⟩ :=
        eleven_dvd h1 h2 (by push_cast; exact dvd_mul_right 11 (m : ℤ))
      have hm : 0 < m := by omega
      have h1' : A' ^ 2 + 47 * B' ^ 2 + C' ^ 2 + 47 * E' ^ 2 = (m : ℤ) ^ 2 := by
        push_cast at h1
        exact mul_left_cancel₀ (show (121 : ℤ) ≠ 0 by norm_num) (by linear_combination h1)
      have h2' : A' * B' + C' * E' = 0 :=
        mul_left_cancel₀ (show (121 : ℤ) ≠ 0 by norm_num) (by linear_combination h2)
      have key := ih m (by omega) hm A' B' C' E' h1' h2'
      have hm' : (m : ℚ) ≠ 0 := by exact_mod_cast hm.ne'
      have e : ∀ X : ℤ, ((11 * X : ℤ) : ℚ) / ((11 * m : ℕ) : ℚ) = (X : ℚ) / m := by
        intro X
        push_cast
        rw [mul_div_mul_left _ _ (by norm_num : (11 : ℚ) ≠ 0)]
      rw [e, e, e, e]
      exact key
    · exact ⟨div_mem_z11 A h11, div_mem_z11 B h11, div_mem_z11 C h11, div_mem_z11 E h11⟩

/-- **The rational descent**: a rational solution of `a² + 47b² + c² + 47e² = 1`, `ab + ce = 0` is 11-integral. -/
theorem rat_descent {a b c e : ℚ} (h1 : a ^ 2 + 47 * b ^ 2 + c ^ 2 + 47 * e ^ 2 = 1) (h2 : a * b + c * e = 0) :
    a ∈ z11 ∧ b ∈ z11 ∧ c ∈ z11 ∧ e ∈ z11 := by
  set N : ℕ := a.den * b.den * c.den * e.den with hN
  have hN0 : 0 < N := by positivity
  have hNq : (N : ℚ) ≠ 0 := by exact_mod_cast hN0.ne'
  obtain ⟨A, hA⟩ : ∃ A : ℤ, (A : ℚ) = a * N :=
    ⟨a.num * (b.den * c.den * e.den : ℕ), by rw [hN]; push_cast; rw [← Rat.mul_den_eq_num]; ring⟩
  obtain ⟨B, hB⟩ : ∃ B : ℤ, (B : ℚ) = b * N :=
    ⟨b.num * (a.den * c.den * e.den : ℕ), by rw [hN]; push_cast; rw [← Rat.mul_den_eq_num]; ring⟩
  obtain ⟨C, hC⟩ : ∃ C : ℤ, (C : ℚ) = c * N :=
    ⟨c.num * (a.den * b.den * e.den : ℕ), by rw [hN]; push_cast; rw [← Rat.mul_den_eq_num]; ring⟩
  obtain ⟨E, hE⟩ : ∃ E : ℤ, (E : ℚ) = e * N :=
    ⟨e.num * (a.den * b.den * c.den : ℕ), by rw [hN]; push_cast; rw [← Rat.mul_den_eq_num]; ring⟩
  have k1 : A ^ 2 + 47 * B ^ 2 + C ^ 2 + 47 * E ^ 2 = (N : ℤ) ^ 2 := by
    have : (A : ℚ) ^ 2 + 47 * B ^ 2 + C ^ 2 + 47 * E ^ 2 = (N : ℚ) ^ 2 := by
      rw [hA, hB, hC, hE]; linear_combination (N : ℚ) ^ 2 * h1
    exact_mod_cast this
  have k2 : A * B + C * E = 0 := by
    have : (A : ℚ) * B + C * E = 0 := by
      rw [hA, hB, hC, hE]; linear_combination (N : ℚ) ^ 2 * h2
    exact_mod_cast this
  have key := int_descent N hN0 A B C E k1 k2
  have back : ∀ (x : ℚ) (X : ℤ), (X : ℚ) = x * N → (X : ℚ) / N = x := by
    intro x X hX
    rw [hX, mul_div_cancel_right₀ _ hNq]
  rw [back a A hA, back b B hB, back c C hC, back e E hE] at key
  exact key

/-- **Every unit vector of `ℚ(√47)²` lies in `A²`.** The unit condition splits by coordinates into
`a² + 47b² + c² + 47e² = 1` and `2(ab + ce) = 0` (`coords_unique`), and the rational descent does the rest. -/
theorem unit_mem_A (v : F47 × F47) (hv : v.1 ^ 2 + v.2 ^ 2 = 1) : v.1 ∈ A ∧ v.2 ∈ A := by
  have hR : ((v.1 : ℝ)) ^ 2 + ((v.2 : ℝ)) ^ 2 = 1 := by
    have := congrArg (fun z : F47 => (z : ℝ)) hv
    simpa using this
  rw [coe_eq v.1, coe_eq v.2] at hR
  set a := re47 v.1
  set b := im47 v.1
  set c := re47 v.2
  set e := im47 v.2
  have hsplit : ((a ^ 2 + 47 * b ^ 2 + c ^ 2 + 47 * e ^ 2 : ℚ) : ℝ) + ((2 * (a * b + c * e) : ℚ) : ℝ) * s =
      ((1 : ℚ) : ℝ) + ((0 : ℚ) : ℝ) * s := by
    push_cast
    linear_combination hR - ((b : ℝ) ^ 2 + e ^ 2) * s_mul_s
  obtain ⟨h1, h2⟩ := coords_unique hsplit
  have h2' : a * b + c * e = 0 := by linarith
  obtain ⟨ha, hb, hc, he⟩ := rat_descent h1 h2'
  exact ⟨mem_A.mpr ⟨ha, hb⟩, mem_A.mpr ⟨hc, he⟩⟩

/-! ### The theorem -/

/-- **Node U4–U6**: a subring of `ℚ(√47)` holding every unit vector's coordinates, with a ring map to `ZMod 11`. -/
theorem exists_residue11 :
    ∃ (A : Subring F47) (_ : A →+* ZMod 11), ∀ v : F47 × F47, v.1 ^ 2 + v.2 ^ 2 = 1 → v.1 ∈ A ∧ v.2 ∈ A :=
  ⟨A, phi, unit_mem_A⟩

/-- **`χ(ℚ(√47)²) ≤ 5`** — Theorem A at 11 for `ℚ(√47)`, through the finite plane `Γ₁₁` (`chromaticNumber_finitePlane11`).
Unconditional: standard three axioms. -/
theorem chromaticNumber_planeOver_sqrt47_le_five :
    ((unitDistance ℂ).induce (planeOver F47)).chromaticNumber ≤ 5 := by
  have h11 : (unitQuadrance (ZMod 11)).Colorable 5 :=
    (chromaticNumber_le_iff_colorable).mp chromaticNumber_finitePlane11.le
  rw [chromaticNumber_planeOver_eq]
  exact (unitQuadrance_colorable_of_subring A unit_mem_A phi h11).chromaticNumber_le

/-! ### Spec -/

/-- `√47 ∈ ℚ(√47)`. -/
theorem sqrt47_mem : s ∈ F47 := by
  have h := SquareClass.sqrt_mem_fieldOfRadicands (D := {47}) (d := 47) rfl
  simpa using h

/-- The generator's coordinates are `(0, 1)`. -/
theorem coords_sqrt47 : re47 ⟨s, sqrt47_mem⟩ = 0 ∧ im47 ⟨s, sqrt47_mem⟩ = 1 := coords_of_eq (by simp)

/-- `√47` is 11-integral. -/
theorem sqrt47_mem_A : (⟨s, sqrt47_mem⟩ : F47) ∈ A :=
  mem_A.mpr ⟨coords_sqrt47.1 ▸ zero_mem _, coords_sqrt47.2 ▸ one_mem _⟩

-- The residue map sends `√47` to `5`, a square root of `47 ≡ 3` in `𝔽₁₁`.
example : phi ⟨⟨s, sqrt47_mem⟩, sqrt47_mem_A⟩ = 5 := by
  have h1 : reA ⟨⟨s, sqrt47_mem⟩, sqrt47_mem_A⟩ = 0 := Subtype.ext coords_sqrt47.1
  have h2 : imA ⟨⟨s, sqrt47_mem⟩, sqrt47_mem_A⟩ = 1 := Subtype.ext coords_sqrt47.2
  show red _ + 5 * red _ = 5
  rw [h1, h2, map_zero, map_one]
  ring

-- `ℤ₍₁₁₎` is proper: `1/11` is not 11-integral, `1/2` is.
example : (1 / 11 : ℚ) ∉ z11 := by
  show ¬ (((1 / 11 : ℚ).den : ℕ) : ZMod 11) ≠ 0
  decide +kernel
example : (1 / 2 : ℚ) ∈ z11 := by
  show (((1 / 2 : ℚ).den : ℕ) : ZMod 11) ≠ 0
  decide +kernel

-- The descent is not vacuous: the unit vector `(1, 0)` and the 11-integral `(3/5, 4/5)` satisfy its hypotheses.
example : (3 / 5 : ℚ) ^ 2 + 47 * 0 ^ 2 + (4 / 5) ^ 2 + 47 * 0 ^ 2 = 1 ∧ (3 / 5 : ℚ) * 0 + 4 / 5 * 0 = 0 := by norm_num

/-! ### The five-colour clause, conditional on SP-Cor's chain -/

/-- `ℚ(√47)` is countable: it lies in `{a + b√47 : a, b ∈ ℚ}`. -/
theorem countable_F47 : Countable F47 := by
  have h : (F47 : Set ℝ) ⊆ Set.range (fun p : ℚ × ℚ => (p.1 : ℝ) + p.2 * s) := fun x hx => by
    obtain ⟨a, b, hab⟩ := f47_le_q47 hx
    exact ⟨(a, b), hab.symm⟩
  exact ((Set.countable_range _).mono h).to_subtype

/-- **`χ(ℚ(√47)²) = 5`, conditional on SP-Cor's chain** (X11K; `SpectralChain`): Herglotz–Bochner on `ℤ[U]`, L1 in its classical
form (`InvariantMeasureOnClosed`), and an interface `(E, T + A, h)` satisfying R-U, A⁺ at `S = ∅`, PE-2 and EF_F⁺. The upper
half is unconditional (`chromaticNumber_planeOver_sqrt47_le_five`). -/
theorem chromaticNumber_planeOver_sqrt47_eq_five_of_chain
    (hBH : SpectralChain.BochnerHerglotz (SpectralChain.unitRing F47))
    (hL1 : SpectralChain.InvariantMeasureOnClosed F47) (I : SpectralChain.Interface F47) (hRU : I.RU) (hA : I.APlus0)
    (hPE : I.PE2) (hEF : I.EFPlus) :
    ((unitDistance ℂ).induce (planeOver F47)).chromaticNumber = 5 := by
  haveI := countable_F47
  haveI : Countable (SpectralChain.unitRing F47) := SpectralChain.countable_unitRing
  exact le_antisymm chromaticNumber_planeOver_sqrt47_le_five (I.five_le_chromaticNumber hBH hL1 hRU hA hPE hEF)

end SqrtFortySeven
end HadwigerNelson
