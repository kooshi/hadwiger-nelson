import Proofs.HadwigerNelson.Arith.NormOneTarget
import Mathlib.NumberTheory.LegendreSymbol.QuadraticChar.GaussSum
import Mathlib.FieldTheory.Finite.GaloisField

/-!
# The planes' floor: `χ(Γ_Q) ≥ 7` for `Q ≡ 3 (mod 4)`, `Q ≥ 98`, over Weil's bound for Kloosterman sums (FS-131 wave 10)

**Read aloud, against the informal claim.** G56's "every usable plane refuses six by Weil from 98": for a prime power
`Q ≡ 3 (mod 4)` the plane `Γ_Q = UD(𝔽_Q, 2)` is the level-one target of `𝔽_{Q²} = 𝔽_Q(i)`; its non-trivial eigenvalues are
the circle sums `Σ_{s₁² + s₂² = 1} ψ(b₁s₁ + b₂s₂)`, each **minus a Kloosterman sum** of `𝔽_Q`
(`circle_sum_eq_kloosterman`, the completion of `[MMST1996]` (7)–(11); it is FS-20's open item R4, here a theorem), hence
at least `−2√Q` by Weil's bound; the ratio bound then gives `χ ≥ 1 + (Q + 1)/(2√Q) > 6` from `Q = 98` on.

**The one outside theorem, a named hypothesis in this module** (its import is in `Arith/WeilKloosterman`, below):
`KloostermanBound F` — for every non-trivial additive character `ψ` of the finite field `F` and
`a, b ≠ 0`, `|Σ_{x ≠ 0} ψ(a x + b x⁻¹)| ≤ 2√|F|`. The floor reads it at the fields of `Q` elements, `Q ≡ 3 (mod 4)` a prime
power — so at **prime powers** `p^f` with `p ≡ 3 (mod 4)`, `f` odd, not only at primes. `[Weil1948]` p. 207 is the classical
source, held and read back against the Lean statement by wave 10's third planning pass: **the import is
`StandingFive.kloosterman_bound` (`Arith/WeilKloosterman`), at characteristic not 2**, and
`kloostermanBound_of_ringChar_ne_two` proves `KloostermanBound F` from it there; the theorems of this module keep the
hypothesis form. `[MMST1996]` Theorem 3 (p. 231, held and read) states the circle-sum bound directly but is **false as
printed at `a = 0`** and is not what is assumed here.

**Inhabitants.** `KloostermanBound F` holds for every field of at most five elements by the triangle inequality
(`kloostermanBound_of_card_le_five`), so it is satisfiable; at larger fields it is Weil's theorem. A field of `Q²` elements
exists for every prime power `Q` (`GaloisField`), so `targetFloor_seven_of_kloosterman` does not quantify over an empty
domain at prime powers, and is empty of content (not false) at a `Q` that is no prime power.
-/

namespace HadwigerNelson.StandingFive

open Finset

/-- **Weil's bound for Kloosterman sums over the finite field `F` — a named classical hypothesis.** For every non-trivial
additive character `ψ` of `F` and `a, b ≠ 0`: `|Σ_{x ∈ Fˣ} ψ(a x + b x⁻¹)| ≤ 2√|F|`. (`[Weil1948]` p. 207; for a general
finite field the textbook form is Lidl–Niederreiter, *Finite Fields*, Theorem 5.45, not held. This `Prop` is the hypothesis
form the floor's modules were proved over; the import is `StandingFive.kloosterman_bound` (`Arith/WeilKloosterman`), at
characteristic not 2, and `kloostermanBound_of_ringChar_ne_two` proves this `Prop` from it.) -/
def KloostermanBound (F : Type*) [Field F] [Fintype F] [DecidableEq F] : Prop :=
  ∀ ψ : AddChar F ℂ, ψ ≠ 1 → ∀ a b : F, a ≠ 0 → b ≠ 0 →
    ‖∑ x : Fˣ, ψ (a * (x : F) + b * ((x⁻¹ : Fˣ) : F))‖ ≤ 2 * Real.sqrt (Fintype.card F)

/-- The model: at a field of at most five elements the bound is the triangle inequality (`q − 1 ≤ 2√q`). -/
theorem kloostermanBound_of_card_le_five {F : Type*} [Field F] [Fintype F] [DecidableEq F] (h : Fintype.card F ≤ 5) :
    KloostermanBound F := by
  intro ψ _ a b _ _
  have h1 : ‖∑ x : Fˣ, ψ (a * (x : F) + b * ((x⁻¹ : Fˣ) : F))‖ ≤ ∑ _x : Fˣ, (1 : ℝ) :=
    norm_sum_le_of_le _ fun x _ => (AddChar.norm_apply ψ _).le
  rw [sum_const, card_univ, Fintype.card_units, nsmul_eq_mul, mul_one] at h1
  have hq1 : 1 ≤ Fintype.card F := Fintype.card_pos
  have h2 : ((Fintype.card F - 1 : ℕ) : ℝ) = (Fintype.card F : ℝ) - 1 := by
    rw [Nat.cast_sub hq1, Nat.cast_one]
  rw [h2] at h1
  refine h1.trans ?_
  have hq1' : (1 : ℝ) ≤ Fintype.card F := by exact_mod_cast hq1
  have hq5 : (Fintype.card F : ℝ) ≤ 5 := by exact_mod_cast h
  have hs0 := Real.sqrt_nonneg (Fintype.card F : ℝ)
  have hs2 := Real.sq_sqrt (show (0 : ℝ) ≤ Fintype.card F by positivity)
  by_contra hlt
  push Not at hlt
  nlinarith [mul_pos (sub_pos.mpr hlt)
      (show (0 : ℝ) < (Fintype.card F : ℝ) - 1 + 2 * Real.sqrt (Fintype.card F) by linarith),
    mul_nonneg (sub_nonneg.mpr hq1') (sub_nonneg.mpr hq5)]

/-! ### The completion: a circle sum is a Kloosterman sum (`[MMST1996]` (7)–(11) at `n = 2`; FS-20's item R4) -/

/-- Orthogonality in the form the completion reads: `Σ_y ψ(c y)` is `|F|` at `c = 0` and `0` otherwise. -/
theorem sum_addChar_mul_left {F : Type*} [Field F] [Fintype F] [DecidableEq F] (ψ : AddChar F ℂ) (hψ : ψ ≠ 1) (c : F) :
    ∑ y : F, ψ (c * y) = if c = 0 then (Fintype.card F : ℂ) else 0 := by
  rw [show ∑ y : F, ψ (c * y) = ∑ y : F, ψ (y * c) from sum_congr rfl fun y _ => by rw [mul_comm],
    AddChar.sum_mulShift c (AddChar.IsPrimitive.of_ne_one hψ)]
  split_ifs <;> simp

/-- A sum over a finite field splits off its term at `0`; the rest is the sum over the units. -/
theorem sum_eq_zero_add_sum_units {F : Type*} [Field F] [Fintype F] [DecidableEq F] {M : Type*} [AddCommMonoid M]
    (g : F → M) : ∑ r : F, g r = g 0 + ∑ x : Fˣ, g (x : F) := by
  rw [← Finset.add_sum_erase univ g (mem_univ 0)]
  congr 1
  refine (Finset.sum_bij (fun (x : Fˣ) _ => (x : F)) (fun x _ => ?_) (fun x _ y _ h => Units.ext h)
    (fun r hr => ?_) (fun _ _ => rfl)).symm
  · exact mem_erase.mpr ⟨x.ne_zero, mem_univ _⟩
  · exact ⟨Units.mk0 r (mem_erase.mp hr).1, mem_univ _, rfl⟩

/-- The Kloosterman sum with one coefficient zero: `Σ_{x ≠ 0} ψ(c x) = −1` for `c ≠ 0`. -/
theorem sum_units_addChar_mul {F : Type*} [Field F] [Fintype F] [DecidableEq F] (ψ : AddChar F ℂ) (hψ : ψ ≠ 1) {c : F}
    (hc : c ≠ 0) : ∑ x : Fˣ, ψ (c * (x : F)) = -1 := by
  have h := sum_eq_zero_add_sum_units (fun r : F => ψ (c * r))
  rw [sum_addChar_mul_left ψ hψ, if_neg hc, mul_zero, AddChar.map_zero_eq_one] at h
  linear_combination -h

/-- **The quadratic Gauss sum**: `Σ_y ψ(r y²) = χ(r) · G` for `r ≠ 0` (count the square roots of each `x` by
`1 + χ(x)`, then shift the Gauss sum by `r`). -/
theorem sum_addChar_mul_sq {F : Type*} [Field F] [Fintype F] [DecidableEq F] (hodd : ringChar F ≠ 2) (ψ : AddChar F ℂ)
    (hψ : ψ ≠ 1) {r : F} (hr : r ≠ 0) :
    ∑ y : F, ψ (r * y ^ 2) =
      ((quadraticChar F r : ℤ) : ℂ) * gaussSum ((quadraticChar F).ringHomComp (Int.castRingHom ℂ)) ψ := by
  set χ' : MulChar F ℂ := (quadraticChar F).ringHomComp (Int.castRingHom ℂ) with hχ'
  have hχr : χ' r = ((quadraticChar F r : ℤ) : ℂ) := rfl
  -- the fibres of `y ↦ y²`
  have hfib : ∀ x : F, ∑ y ∈ univ.filter (fun y : F => y ^ 2 = x), ψ (r * y ^ 2) = (χ' x + 1) * ψ (r * x) := by
    intro x
    have hc : ((univ.filter fun y : F => y ^ 2 = x).card : ℂ) = χ' x + 1 := by
      have h := quadraticChar_card_sqrts hodd x
      rw [Set.toFinset_setOf] at h
      have h' : (((univ.filter fun y : F => y ^ 2 = x).card : ℤ) : ℂ) = ((quadraticChar F x + 1 : ℤ) : ℂ) := by
        rw [h]
      push_cast at h'
      exact h'
    rw [sum_congr rfl fun y hy => by rw [(mem_filter.mp hy).2], sum_const, nsmul_eq_mul, hc]
  have h0 : ∑ x : F, ψ (r * x) = 0 := by
    rw [sum_addChar_mul_left ψ hψ, if_neg hr]
  have hG : ∑ x : F, χ' x * ψ (r * x) = χ' r * gaussSum χ' ψ := by
    have h := gaussSum_mulShift χ' ψ (Units.mk0 r hr)
    have hsq : χ' r * χ' r = 1 := by
      rw [hχr, ← Int.cast_mul, ← pow_two, quadraticChar_sq_one hr, Int.cast_one]
    have hsum : gaussSum χ' (AddChar.mulShift ψ r) = ∑ x : F, χ' x * ψ (r * x) := by
      simp only [gaussSum, AddChar.mulShift_apply]
    rw [← hsum]
    simp only [Units.val_mk0] at h
    rw [← h, ← mul_assoc, hsq, one_mul]
  rw [← Finset.sum_fiberwise univ (fun y : F => y ^ 2) (fun y => ψ (r * y ^ 2)), sum_congr rfl fun x _ => hfib x]
  simp only [add_mul, one_mul, sum_add_distrib, h0, add_zero]
  exact hG

/-- **Completing the square**: for `r ≠ 0` in a finite field of odd characteristic,
`Σ_y ψ(r y² + c y) = ψ(−c²/(4r)) · χ(r) · G`, with `χ` the quadratic character and `G = Σ_y χ(y) ψ(y)` its Gauss sum. -/
theorem sum_quadratic_eq {F : Type*} [Field F] [Fintype F] [DecidableEq F] (hodd : ringChar F ≠ 2) (ψ : AddChar F ℂ)
    (hψ : ψ ≠ 1) {r : F} (hr : r ≠ 0) (c : F) :
    ∑ y : F, ψ (r * y ^ 2 + c * y) =
      ψ (-(c ^ 2 / (4 * r))) * ((quadraticChar F r : ℤ) : ℂ) *
        gaussSum ((quadraticChar F).ringHomComp (Int.castRingHom ℂ)) ψ := by
  have h2 : (2 : F) ≠ 0 := Ring.two_ne_zero hodd
  have h4 : (4 : F) ≠ 0 := by
    have : (4 : F) = 2 * 2 := by norm_num
    rw [this]
    exact mul_ne_zero h2 h2
  -- `r y² + c y = r (y + c/(2r))² − c²/(4r)`; re-index by `y ↦ y + c/(2r)`
  rw [mul_assoc, ← sum_addChar_mul_sq hodd ψ hψ hr, mul_sum]
  refine Fintype.sum_equiv (Equiv.addRight (c / (2 * r))) _ _ fun y => ?_
  rw [← AddChar.map_add_eq_mul, Equiv.coe_addRight]
  congr 1
  field_simp
  ring

/-- The sum over the plane of `ψ(r(s₁² + s₂² − a) + b·s)` factors into two one-variable quadratic sums. -/
theorem sum_plane_quadratic {F : Type*} [Field F] [Fintype F] (ψ : AddChar F ℂ) (a r : F) (b : F × F) :
    ∑ s : F × F, ψ (r * (s.1 ^ 2 + s.2 ^ 2 - a)) * ψ (b.1 * s.1 + b.2 * s.2) =
      ψ (-(r * a)) * ((∑ y : F, ψ (r * y ^ 2 + b.1 * y)) * ∑ y : F, ψ (r * y ^ 2 + b.2 * y)) := by
  rw [Fintype.sum_prod_type, Finset.sum_mul_sum, Finset.mul_sum]
  refine sum_congr rfl fun y _ => ?_
  rw [Finset.mul_sum]
  refine sum_congr rfl fun z _ => ?_
  rw [← AddChar.map_add_eq_mul, ← AddChar.map_add_eq_mul, ← AddChar.map_add_eq_mul]
  congr 1
  ring

/-- **A circle sum is a Kloosterman sum** (`[MMST1996]` formula (11) at `n = 2`): for a non-trivial `ψ`, any `a`, and
`b ≠ 0`, `Σ_{s₁² + s₂² = a} ψ(b₁s₁ + b₂s₂) = χ(−1) · Σ_{x ≠ 0} ψ(−a x − ((b₁² + b₂²)/4) x⁻¹)`. At `a = 1`,
`|F| ≡ 3 (mod 4)` this is `λ(c) = −K(1, c/4)`, the identity M58 checked numerically. **Proved here: this is the kernel form
of an identity the project had only ever checked numerically** (M58 §R1, in floats at the primes `p ≡ 3 (mod 4)` below 600;
FS-20's open item R4) — at every finite field of odd characteristic, prime powers included, and at every radius `a`, zero
included. -/
theorem circle_sum_eq_kloosterman {F : Type*} [Field F] [Fintype F] [DecidableEq F] (hodd : ringChar F ≠ 2)
    (ψ : AddChar F ℂ) (hψ : ψ ≠ 1) (a : F) (b : F × F) (hb : b ≠ 0) :
    ∑ s ∈ univ.filter (fun s : F × F => s.1 ^ 2 + s.2 ^ 2 = a), ψ (b.1 * s.1 + b.2 * s.2) =
      ((quadraticChar F (-1) : ℤ) : ℂ) *
        ∑ x : Fˣ, ψ (-a * (x : F) + -((b.1 ^ 2 + b.2 ^ 2) / 4) * ((x⁻¹ : Fˣ) : F)) := by
  have hprim : ψ.IsPrimitive := AddChar.IsPrimitive.of_ne_one hψ
  have hq : (Fintype.card F : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr Fintype.card_ne_zero
  have h2 : (2 : F) ≠ 0 := Ring.two_ne_zero hodd
  have h4 : (4 : F) ≠ 0 := by
    have : (4 : F) = 2 * 2 := by norm_num
    rw [this]
    exact mul_ne_zero h2 h2
  set χ' : MulChar F ℂ := (quadraticChar F).ringHomComp (Int.castRingHom ℂ) with hχ'
  have hχne : χ' ≠ 1 := (MulChar.ringHomComp_ne_one_iff Int.cast_injective).mpr (quadraticChar_ne_one hodd)
  have hχq : χ'.IsQuadratic := (quadraticChar_isQuadratic F).comp _
  have hG : gaussSum χ' ψ ^ 2 = ((quadraticChar F (-1) : ℤ) : ℂ) * (Fintype.card F : ℂ) := gaussSum_sq hχne hχq hprim
  apply mul_left_cancel₀ hq
  -- the indicator of the circle by orthogonality: `q · 1[t = 0] = Σ_r ψ(r t)`
  have hL : (Fintype.card F : ℂ) *
        ∑ s ∈ univ.filter (fun s : F × F => s.1 ^ 2 + s.2 ^ 2 = a), ψ (b.1 * s.1 + b.2 * s.2) =
      ∑ r : F, ∑ s : F × F, ψ (r * (s.1 ^ 2 + s.2 ^ 2 - a)) * ψ (b.1 * s.1 + b.2 * s.2) := by
    rw [Finset.sum_comm, Finset.sum_filter, Finset.mul_sum]
    refine sum_congr rfl fun s _ => ?_
    rw [← Finset.sum_mul, show ∑ r : F, ψ (r * (s.1 ^ 2 + s.2 ^ 2 - a)) = ∑ r : F, ψ ((s.1 ^ 2 + s.2 ^ 2 - a) * r) from
      sum_congr rfl fun r _ => by rw [mul_comm], sum_addChar_mul_left ψ hψ]
    by_cases h : s.1 ^ 2 + s.2 ^ 2 = a
    · rw [if_pos h, if_pos (sub_eq_zero.mpr h)]
    · rw [if_neg h, if_neg (sub_ne_zero.mpr h), mul_zero, zero_mul]
  -- `r = 0`: one of the two linear sums vanishes, because `b ≠ 0`
  have h0 : ∑ s : F × F, ψ ((0 : F) * (s.1 ^ 2 + s.2 ^ 2 - a)) * ψ (b.1 * s.1 + b.2 * s.2) = 0 := by
    rw [sum_plane_quadratic]
    have hlin : ∀ c : F, ∑ y : F, ψ (0 * y ^ 2 + c * y) = if c = 0 then (Fintype.card F : ℂ) else 0 := by
      intro c
      rw [← sum_addChar_mul_left ψ hψ c]
      refine sum_congr rfl fun y _ => ?_
      rw [zero_mul, zero_add]
    have hb' : b.1 ≠ 0 ∨ b.2 ≠ 0 := by
      by_contra hcon
      push Not at hcon
      exact hb (Prod.ext hcon.1 hcon.2)
    rw [hlin, hlin]
    rcases hb' with h | h
    · simp [h]
    · simp [h]
  -- `r ≠ 0`: two completed squares, `χ(r)² = 1` and `G² = χ(−1) q`
  have hunit : ∀ x : Fˣ, ∑ s : F × F, ψ ((x : F) * (s.1 ^ 2 + s.2 ^ 2 - a)) * ψ (b.1 * s.1 + b.2 * s.2) =
      (Fintype.card F : ℂ) * (((quadraticChar F (-1) : ℤ) : ℂ) *
        ψ (-a * (x : F) + -((b.1 ^ 2 + b.2 ^ 2) / 4) * ((x⁻¹ : Fˣ) : F))) := by
    intro x
    have hx : (x : F) ≠ 0 := x.ne_zero
    have hsq : ((quadraticChar F (x : F) : ℤ) : ℂ) * ((quadraticChar F (x : F) : ℤ) : ℂ) = 1 := by
      rw [← Int.cast_mul, ← pow_two, quadraticChar_sq_one hx, Int.cast_one]
    rw [sum_plane_quadratic, sum_quadratic_eq hodd ψ hψ hx, sum_quadratic_eq hodd ψ hψ hx]
    have harg : ψ (-a * (x : F) + -((b.1 ^ 2 + b.2 ^ 2) / 4) * ((x⁻¹ : Fˣ) : F)) =
        ψ (-((x : F) * a)) * (ψ (-(b.1 ^ 2 / (4 * (x : F)))) * ψ (-(b.2 ^ 2 / (4 * (x : F))))) := by
      rw [← AddChar.map_add_eq_mul, ← AddChar.map_add_eq_mul, Units.val_inv_eq_inv_val]
      congr 1
      field_simp
      ring
    rw [harg]
    calc ψ (-((x : F) * a)) * (ψ (-(b.1 ^ 2 / (4 * (x : F)))) * ((quadraticChar F (x : F) : ℤ) : ℂ) * gaussSum χ' ψ *
          (ψ (-(b.2 ^ 2 / (4 * (x : F)))) * ((quadraticChar F (x : F) : ℤ) : ℂ) * gaussSum χ' ψ))
        = ψ (-((x : F) * a)) * (ψ (-(b.1 ^ 2 / (4 * (x : F)))) * ψ (-(b.2 ^ 2 / (4 * (x : F))))) *
            (((quadraticChar F (x : F) : ℤ) : ℂ) * ((quadraticChar F (x : F) : ℤ) : ℂ)) * gaussSum χ' ψ ^ 2 := by ring
      _ = _ := by rw [hsq, hG]; ring
  rw [hL, sum_eq_zero_add_sum_units, h0, zero_add, sum_congr rfl fun x _ => hunit x, ← Finset.mul_sum,
    ← Finset.mul_sum]

/-- **The circle-sum bound at the class the argument reads**: radius `a ≠ 0` **or** `b` anisotropic — over Weil's bound at
`F`. With exactly one of `a`, `b₁² + b₂²` zero the Kloosterman sum degenerates to `−1`. -/
theorem circle_sum_le_of_ne {F : Type*} [Field F] [Fintype F] [DecidableEq F] (hodd : ringChar F ≠ 2)
    (hK : KloostermanBound F) (ψ : AddChar F ℂ) (hψ : ψ ≠ 1) (a : F) (b : F × F) (hb : b ≠ 0)
    (h : a ≠ 0 ∨ b.1 ^ 2 + b.2 ^ 2 ≠ 0) :
    ‖∑ s ∈ univ.filter (fun s : F × F => s.1 ^ 2 + s.2 ^ 2 = a), ψ (b.1 * s.1 + b.2 * s.2)‖ ≤
      2 * Real.sqrt (Fintype.card F) := by
  have hχ : ‖((quadraticChar F (-1) : ℤ) : ℂ)‖ = 1 := by
    rcases quadraticChar_dichotomy (neg_ne_zero.mpr (one_ne_zero (α := F))) with h | h <;> simp [h]
  have h1 : (1 : ℝ) ≤ 2 * Real.sqrt (Fintype.card F) := by
    have : (1 : ℝ) ≤ Real.sqrt (Fintype.card F) := by
      rw [Real.one_le_sqrt]
      exact_mod_cast Fintype.card_pos
    linarith
  have h4 : (4 : F) ≠ 0 := by
    have h2 : (2 : F) ≠ 0 := Ring.two_ne_zero hodd
    have : (4 : F) = 2 * 2 := by norm_num
    rw [this]
    exact mul_ne_zero h2 h2
  rw [circle_sum_eq_kloosterman hodd ψ hψ a b hb, norm_mul, hχ, one_mul]
  by_cases ha : a = 0
  · -- `a = 0`, `b` anisotropic: `Σ_{x ≠ 0} ψ(−c x⁻¹) = −1`
    have hc : -((b.1 ^ 2 + b.2 ^ 2) / 4) ≠ 0 := neg_ne_zero.mpr (div_ne_zero (h.resolve_left (not_not.mpr ha)) h4)
    have hsum : ∑ x : Fˣ, ψ (-a * (x : F) + -((b.1 ^ 2 + b.2 ^ 2) / 4) * ((x⁻¹ : Fˣ) : F)) = -1 := by
      rw [← sum_units_addChar_mul ψ hψ hc]
      refine Fintype.sum_equiv (Equiv.inv Fˣ) _ _ fun x => ?_
      rw [ha, neg_zero, zero_mul, zero_add, Equiv.inv_apply]
    rw [hsum, norm_neg, norm_one]
    exact h1
  · by_cases hc : (b.1 ^ 2 + b.2 ^ 2) / 4 = 0
    · -- `a ≠ 0`, `b` isotropic: `Σ_{x ≠ 0} ψ(−a x) = −1`
      have hsum : ∑ x : Fˣ, ψ (-a * (x : F) + -((b.1 ^ 2 + b.2 ^ 2) / 4) * ((x⁻¹ : Fˣ) : F)) = -1 := by
        rw [← sum_units_addChar_mul ψ hψ (neg_ne_zero.mpr ha)]
        refine sum_congr rfl fun x _ => ?_
        rw [hc, neg_zero, zero_mul, add_zero]
      rw [hsum, norm_neg, norm_one]
      exact h1
    · exact hK ψ hψ (-a) (-((b.1 ^ 2 + b.2 ^ 2) / 4)) (neg_ne_zero.mpr ha) (neg_ne_zero.mpr hc)

/-- **The circle-sum bound** (`[MMST1996]` Theorem 3 at `n = 2`, with the restriction `a ≠ 0` its printed statement
omits): over Weil's bound at `F`. When `b₁² + b₂² = 0` the Kloosterman sum degenerates to `−1`. -/
theorem circle_sum_le {F : Type*} [Field F] [Fintype F] [DecidableEq F] (hodd : ringChar F ≠ 2) (hK : KloostermanBound F)
    (ψ : AddChar F ℂ) (hψ : ψ ≠ 1) {a : F} (ha : a ≠ 0) (b : F × F) (hb : b ≠ 0) :
    ‖∑ s ∈ univ.filter (fun s : F × F => s.1 ^ 2 + s.2 ^ 2 = a), ψ (b.1 * s.1 + b.2 * s.2)‖ ≤
      2 * Real.sqrt (Fintype.card F) :=
  circle_sum_le_of_ne hodd hK ψ hψ a b hb (Or.inl ha)

/-- **The one case the bound does not cover**: radius zero and `b ≠ 0` isotropic — the circle sum is `χ(−1)·(|F| − 1)`.
(`[MMST1996]` Theorem 3 at `n = 2`, printed with no restriction on the radius, is false here from `|F| ≥ 6` on —
`two_sqrt_lt_circle_sum_zero` — and, given Weil's bound, in no other case — `circle_sum_le_of_ne`.) -/
theorem circle_sum_zero_of_isotropic {F : Type*} [Field F] [Fintype F] [DecidableEq F] (hodd : ringChar F ≠ 2)
    (ψ : AddChar F ℂ) (hψ : ψ ≠ 1) (b : F × F) (hb : b ≠ 0) (hiso : b.1 ^ 2 + b.2 ^ 2 = 0) :
    ∑ s ∈ univ.filter (fun s : F × F => s.1 ^ 2 + s.2 ^ 2 = 0), ψ (b.1 * s.1 + b.2 * s.2) =
      ((quadraticChar F (-1) : ℤ) : ℂ) * ((Fintype.card F : ℂ) - 1) := by
  rw [circle_sum_eq_kloosterman hodd ψ hψ 0 b hb]
  congr 1
  rw [sum_congr rfl fun x _ => by rw [hiso, zero_div, neg_zero, zero_mul, zero_mul, add_zero, AddChar.map_zero_eq_one],
    sum_const, card_univ, Fintype.card_units, nsmul_eq_mul, mul_one, Nat.cast_sub Fintype.card_pos, Nat.cast_one]

/-- At radius zero and `b ≠ 0` isotropic the circle sum **exceeds** `2√|F|` as soon as `|F| ≥ 6`: the printed
`[MMST1996]` Theorem 3 is false at every such field (an isotropic `b ≠ 0` exists exactly when `−1` is a square). -/
theorem two_sqrt_lt_circle_sum_zero {F : Type*} [Field F] [Fintype F] [DecidableEq F] (hodd : ringChar F ≠ 2)
    (ψ : AddChar F ℂ) (hψ : ψ ≠ 1) (b : F × F) (hb : b ≠ 0) (hiso : b.1 ^ 2 + b.2 ^ 2 = 0)
    (hq : 6 ≤ Fintype.card F) :
    2 * Real.sqrt (Fintype.card F) <
      ‖∑ s ∈ univ.filter (fun s : F × F => s.1 ^ 2 + s.2 ^ 2 = 0), ψ (b.1 * s.1 + b.2 * s.2)‖ := by
  have hχ : ‖((quadraticChar F (-1) : ℤ) : ℂ)‖ = 1 := by
    rcases quadraticChar_dichotomy (neg_ne_zero.mpr (one_ne_zero (α := F))) with h | h <;> simp [h]
  have hn : ‖(Fintype.card F : ℂ) - 1‖ = (Fintype.card F : ℝ) - 1 := by
    rw [← Nat.cast_one (R := ℂ), ← Nat.cast_sub Fintype.card_pos, Complex.norm_natCast, Nat.cast_sub Fintype.card_pos,
      Nat.cast_one]
  rw [circle_sum_zero_of_isotropic hodd ψ hψ b hb hiso, norm_mul, hχ, one_mul, hn]
  have hq' : (6 : ℝ) ≤ Fintype.card F := by exact_mod_cast hq
  have hs0 := Real.sqrt_nonneg (Fintype.card F : ℝ)
  have hs2 := Real.sq_sqrt (show (0 : ℝ) ≤ Fintype.card F by positivity)
  nlinarith

/-! ### From the field with an involution to the circle -/

/-- In a field of `Q²` elements the `Q`-th power map is a ring homomorphism (`Q` is a power of the characteristic). -/
theorem exists_ringHom_pow {k : Type*} [Field k] [Fintype k] {Q : ℕ} (hcard : Fintype.card k = Q ^ 2) :
    ∃ τ : k →+* k, ∀ x, τ x = x ^ Q := by
  obtain ⟨p, hp⟩ := CharP.exists k
  have hprime : p.Prime := CharP.char_is_prime k p
  haveI : Fact p.Prime := ⟨hprime⟩
  obtain ⟨n, -, hn⟩ := FiniteField.card k p
  have hdvd : Q ∣ p ^ (n : ℕ) := by
    rw [← hn, hcard]
    exact Dvd.intro_left Q (pow_two Q).symm
  obtain ⟨m, -, rfl⟩ := (Nat.dvd_prime_pow hprime).mp hdvd
  exact ⟨iterateFrobenius k p m, fun x => iterateFrobenius_def ..⟩

/-- The fixed points of the `Q`-th power map of a field of `Q²` elements: exactly `Q` (zero, and the `Q − 1` solutions
of `x ^ (Q − 1) = 1`). -/
theorem card_filter_pow_eq_self {k : Type*} [Field k] [Fintype k] [DecidableEq k] {Q : ℕ}
    (hcard : Fintype.card k = Q ^ 2) : (univ.filter fun x : k => x ^ Q = x).card = Q := by
  have hQ2 : 2 ≤ Q := by
    by_contra h
    have h1 : 1 < Fintype.card k := Fintype.one_lt_card
    have h2 : Q ^ 2 ≤ 1 := by nlinarith
    omega
  have hQ : Q - 1 + 1 = Q := by omega
  have hset : (univ.filter fun x : k => x ^ Q = x) = insert 0 (univ.filter fun x : k => x ^ (Q - 1) = 1) := by
    ext x
    simp only [mem_filter, mem_univ, true_and, mem_insert]
    constructor
    · intro h
      by_cases hx : x = 0
      · exact Or.inl hx
      · right
        have h' : x ^ (Q - 1) * x = 1 * x := by rw [← pow_succ, hQ, h, one_mul]
        exact mul_right_cancel₀ hx h'
    · rintro (rfl | h)
      · exact zero_pow (by omega)
      · calc x ^ Q = x ^ (Q - 1) * x := by rw [← pow_succ, hQ]
          _ = x := by rw [h, one_mul]
  have h0 : (0 : k) ∉ univ.filter fun x : k => x ^ (Q - 1) = 1 := by
    simp only [mem_filter, mem_univ, true_and]
    rw [zero_pow (by omega)]
    exact zero_ne_one
  rw [hset, card_insert_of_notMem h0, card_filter_pow_eq_one (by omega), hQ]
  rw [hcard]
  refine ⟨Q + 1, ?_⟩
  exact Nat.sub_eq_of_eq_add (by
    have : (Q - 1) * (Q + 1) + 1 = Q ^ 2 := by
      obtain ⟨n, rfl⟩ : ∃ n, Q = n + 1 := ⟨Q - 1, by omega⟩
      simp only [Nat.add_sub_cancel]
      ring
    exact this.symm)

/-- Every additive character of a finite field is a multiplicative shift of a fixed non-trivial one (the shifts are
injective, and there are as many characters as elements). -/
theorem exists_mulShift_eq {F : Type*} [Field F] [Finite F] (ψ₀ : AddChar F ℂ) (hψ₀ : ψ₀ ≠ 1) (φ : AddChar F ℂ) :
    ∃ b : F, ψ₀.mulShift b = φ := by
  have := Fintype.ofFinite F
  refine (Function.Injective.bijective_of_nat_card_le
    (AddChar.to_mulShift_inj_of_isPrimitive (AddChar.IsPrimitive.of_ne_one hψ₀)) ?_).2 φ
  rw [Nat.card_eq_fintype_card, Nat.card_eq_fintype_card, AddChar.card_eq]

/-- **The character sums of the norm-one set of `𝔽_{Q²}`, `Q ≡ 3 (mod 4)`, two-sided**: every non-trivial additive
character sums to modulus at most `2√Q` over `{u : u ^ (Q + 1) = 1}`, given Weil's bound at the fields of `Q` elements.
(The subfield `k₀ = {x : x ^ Q = x}` has `Q` elements; `−1` is a square in `k` and not in `k₀`, so `k = k₀ ⊕ k₀·i`,
`u ^ (Q + 1) = u₁² + u₂²`, and `ψ(u₁ + u₂ i) = ψ₀(b₁u₁ + b₂u₂)` for a non-trivial `ψ₀` of `k₀` and some `b ≠ 0`; then
`circle_sum_le` at radius `1`.) -/
theorem norm_normOne_charSum_le {k : Type} [Field k] [Fintype k] [DecidableEq k] {Q : ℕ} (hQ4 : Q % 4 = 3)
    (hcard : Fintype.card k = Q ^ 2)
    (hK : ∀ (F : Type) [Field F] [Fintype F] [DecidableEq F], Fintype.card F = Q → KloostermanBound F) (ψ : AddChar k ℂ)
    (hψ : ψ ≠ 1) : ‖∑ u ∈ univ.filter (fun u : k => u ^ (Q + 1) = 1), ψ u‖ ≤ 2 * Real.sqrt Q := by
  -- the subfield `k₀` fixed by the `Q`-th power map, with `Q` elements
  obtain ⟨τ, hτ⟩ := exists_ringHom_pow hcard
  let k₀ : Subfield k := τ.eqLocusField (RingHom.id k)
  have hmem : ∀ x : k, x ∈ k₀ ↔ x ^ Q = x := fun x => by rw [← hτ]; exact Iff.rfl
  haveI : DecidablePred (· ∈ k₀) := fun x => decidable_of_iff _ (hmem x).symm
  have hcard₀ : Fintype.card k₀ = Q := by
    rw [Fintype.card_subtype, ← card_filter_pow_eq_self hcard]
    exact congrArg card (filter_congr fun x _ => hmem x)
  have hfix : ∀ y : k₀, (y : k) ^ Q = y := fun y => (hmem _).mp y.2
  have hodd₀ : ringChar k₀ ≠ 2 := by
    rw [Ne, FiniteField.even_card_iff_char_two, hcard₀]
    omega
  have h2 : (2 : k) ≠ 0 := by
    refine Ring.two_ne_zero ?_
    rw [Ne, FiniteField.even_card_iff_char_two, hcard, Nat.pow_mod]
    have : Q % 2 = 1 := by omega
    rw [this]
    norm_num
  -- a square root `ι` of `−1`, moved to `−ι` by the `Q`-th power map (`Q = 4t + 3`)
  obtain ⟨ι, hι⟩ : IsSquare (-1 : k) := by
    rw [FiniteField.isSquare_neg_one_iff, hcard, Nat.pow_mod, hQ4]
    norm_num
  have hι0 : ι ≠ 0 := by
    rintro rfl
    simp at hι
  have hιQ : ι ^ Q = -ι := by
    have hQ : Q = 4 * (Q / 4) + 3 := by omega
    have h4 : ι ^ 4 = 1 := by
      rw [show ι ^ 4 = (ι * ι) * (ι * ι) by ring, ← hι]
      norm_num
    rw [hQ, pow_add, pow_mul, h4, one_pow, one_mul, show ι ^ 3 = (ι * ι) * ι by ring, ← hι]
    ring
  -- coordinates: `k = k₀ ⊕ k₀·ι`
  let φ : k₀ × k₀ → k := fun s => (s.1 : k) + (s.2 : k) * ι
  have hφQ : ∀ s : k₀ × k₀, φ s ^ Q = (s.1 : k) - (s.2 : k) * ι := by
    intro s
    rw [← hτ, map_add, map_mul, hτ, hτ, hτ, hfix, hfix, hιQ]
    ring
  have hinj : Function.Injective φ := by
    intro s t hst
    have hQ' : (s.1 : k) - (s.2 : k) * ι = (t.1 : k) - (t.2 : k) * ι := by rw [← hφQ, ← hφQ, hst]
    have hst' : (s.1 : k) + (s.2 : k) * ι = (t.1 : k) + (t.2 : k) * ι := hst
    have e1 : (s.1 : k) = t.1 := by
      have : (2 : k) * s.1 = 2 * t.1 := by linear_combination hst' + hQ'
      exact mul_left_cancel₀ h2 this
    have e2 : (s.2 : k) = t.2 := by
      have : (2 * ι) * (s.2 : k) = (2 * ι) * t.2 := by linear_combination hst' - hQ'
      exact mul_left_cancel₀ (mul_ne_zero h2 hι0) this
    exact Prod.ext (Subtype.ext e1) (Subtype.ext e2)
  have hbij : Function.Bijective φ := by
    rw [Fintype.bijective_iff_injective_and_card]
    refine ⟨hinj, ?_⟩
    rw [Fintype.card_prod, hcard₀, hcard, pow_two]
  -- the norm in coordinates: `u ^ (Q + 1) = u₁² + u₂²`
  have hnorm : ∀ s : k₀ × k₀, φ s ^ (Q + 1) = 1 ↔ s.1 ^ 2 + s.2 ^ 2 = 1 := by
    intro s
    have h : φ s ^ (Q + 1) = ((s.1 ^ 2 + s.2 ^ 2 : k₀) : k) := by
      rw [pow_succ, hφQ]
      push_cast
      linear_combination (s.2 : k) ^ 2 * hι
    rw [h]
    exact ⟨fun h1 => Subtype.ext h1, fun h1 => by rw [h1]; rfl⟩
  -- the character in coordinates: `ψ(u₁ + u₂ ι) = ψ₀(b₁u₁ + b₂u₂)` for a non-trivial `ψ₀` of `k₀` and `b ≠ 0`
  obtain ⟨ψ₀, hψ₀⟩ := (AddChar.exists_apply_ne_zero (a := (1 : k₀))).mpr one_ne_zero
  have hψ₀' : ψ₀ ≠ 1 := fun h => hψ₀ (by rw [h]; rfl)
  obtain ⟨b₁, hb₁⟩ := exists_mulShift_eq ψ₀ hψ₀' (ψ.compAddMonoidHom k₀.subtype.toAddMonoidHom)
  obtain ⟨b₂, hb₂⟩ := exists_mulShift_eq ψ₀ hψ₀' ((ψ.mulShift ι).compAddMonoidHom k₀.subtype.toAddMonoidHom)
  have hψφ : ∀ s : k₀ × k₀, ψ (φ s) = ψ₀ (b₁ * s.1 + b₂ * s.2) := by
    intro s
    have e1 : ψ₀ (b₁ * s.1) = ψ (s.1 : k) := by
      rw [← AddChar.mulShift_apply, hb₁]
      rfl
    have e2 : ψ₀ (b₂ * s.2) = ψ ((s.2 : k) * ι) := by
      rw [← AddChar.mulShift_apply, hb₂, mul_comm]
      rfl
    rw [AddChar.map_add_eq_mul, AddChar.map_add_eq_mul, e1, e2]
  have hb : ((b₁, b₂) : k₀ × k₀) ≠ 0 := by
    intro h0
    have hb1 : b₁ = 0 := congrArg Prod.fst h0
    have hb2 : b₂ = 0 := congrArg Prod.snd h0
    apply hψ
    ext u
    obtain ⟨s, rfl⟩ := hbij.2 u
    rw [hψφ, hb1, hb2, zero_mul, zero_mul, add_zero, AddChar.map_zero_eq_one, AddChar.one_apply]
  -- re-index the sum by the coordinates; the circle-sum bound at radius 1
  have hsum : ∑ u ∈ univ.filter (fun u : k => u ^ (Q + 1) = 1), ψ u =
      ∑ s ∈ univ.filter (fun s : k₀ × k₀ => s.1 ^ 2 + s.2 ^ 2 = 1), ψ₀ ((b₁, b₂).1 * s.1 + (b₁, b₂).2 * s.2) := by
    rw [sum_filter, sum_filter, ← hbij.sum_comp]
    refine sum_congr rfl fun s _ => ?_
    by_cases h : s.1 ^ 2 + s.2 ^ 2 = 1
    · rw [if_pos h, if_pos ((hnorm s).mpr h), hψφ]
    · rw [if_neg h, if_neg fun h' => h ((hnorm s).mp h')]
  have hle := circle_sum_le hodd₀ (hK k₀ hcard₀) ψ₀ hψ₀' (a := 1) one_ne_zero (b₁, b₂) hb
  rw [hcard₀, ← hsum] at hle
  exact hle

/-- **The character sums of the norm-one set of `𝔽_{Q²}`, `Q ≡ 3 (mod 4)`**: every non-trivial additive character sums to
real part at least `−2√Q` over `{u : u ^ (Q + 1) = 1}`, given Weil's bound at the fields of `Q` elements — the real part
of the two-sided bound `norm_normOne_charSum_le`. -/
theorem normOne_charSum_ge {k : Type} [Field k] [Fintype k] [DecidableEq k] {Q : ℕ} (hQ4 : Q % 4 = 3)
    (hcard : Fintype.card k = Q ^ 2)
    (hK : ∀ (F : Type) [Field F] [Fintype F] [DecidableEq F], Fintype.card F = Q → KloostermanBound F) (ψ : AddChar k ℂ)
    (hψ : ψ ≠ 1) : -(2 * Real.sqrt Q) ≤ (∑ u ∈ univ.filter (fun u : k => u ^ (Q + 1) = 1), ψ u).re :=
  neg_le_of_abs_le ((Complex.abs_re_le_norm _).trans (norm_normOne_charSum_le hQ4 hcard hK ψ hψ))

/-- **The planes' floor**: `χ(Γ_Q) ≥ 7` for `Q ≡ 3 (mod 4)`, `Q ≥ 98`, over Weil's bound at the fields of `Q` elements
(`1 + (Q + 1)/(2√Q) > 6` exactly when `Q ≥ 98`). -/
theorem targetFloor_seven_of_kloosterman {Q : ℕ} (hQ4 : Q % 4 = 3) (hQ : 98 ≤ Q)
    (hK : ∀ (F : Type) [Field F] [Fintype F] [DecidableEq F], Fintype.card F = Q → KloostermanBound F) : TargetFloor 7 Q := by
  have hQr : (98 : ℝ) ≤ Q := by exact_mod_cast hQ
  have hs : Real.sqrt Q < ((Q : ℝ) + 1) / 10 := by
    rw [Real.sqrt_lt' (by linarith)]
    nlinarith [mul_nonneg (show (0 : ℝ) ≤ Q by linarith) (show (0 : ℝ) ≤ (Q : ℝ) - 98 by linarith)]
  refine targetFloor_of_charSum 7 Q (m := 2 * Real.sqrt Q)
    (mul_pos two_pos (Real.sqrt_pos.mpr (by linarith))) ?_
    fun k _ _ _ hcard ψ hψ => normOne_charSum_ge hQ4 hcard hK ψ hψ
  norm_num
  linarith

/-! ## Spec -/

-- `KloostermanBound` has a model: the field of three elements.
example : KloostermanBound (ZMod 3) :=
  kloostermanBound_of_card_le_five (by rw [ZMod.card]; norm_num)

-- the threshold is sharp for the argument: at `Q = 97`, `10·√97 > 98`, so the ratio bound stops at six.
example : (97 : ℝ) + 1 < 10 * Real.sqrt 97 := by
  have h : (9.8 : ℝ) < Real.sqrt 97 := by
    rw [Real.lt_sqrt (by norm_num)]
    norm_num
  linarith

-- `circle_sum_le` at a model of all its hypotheses: `ZMod 3`, where Weil's bound is the triangle inequality.
example (ψ : AddChar (ZMod 3) ℂ) (hψ : ψ ≠ 1) (b : ZMod 3 × ZMod 3) (hb : b ≠ 0) :
    ‖∑ s ∈ univ.filter (fun s : ZMod 3 × ZMod 3 => s.1 ^ 2 + s.2 ^ 2 = 1), ψ (b.1 * s.1 + b.2 * s.2)‖ ≤
      2 * Real.sqrt (Fintype.card (ZMod 3)) :=
  circle_sum_le (by rw [ZMod.ringChar_zmod_n]; norm_num) (kloostermanBound_of_card_le_five (by rw [ZMod.card]; norm_num))
    ψ hψ one_ne_zero b hb

-- `circle_sum_le_of_ne` on its second branch, radius zero and an anisotropic `b`: `ZMod 3`, `b = (1, 0)`.
example (ψ : AddChar (ZMod 3) ℂ) (hψ : ψ ≠ 1) :
    ‖∑ s ∈ univ.filter (fun s : ZMod 3 × ZMod 3 => s.1 ^ 2 + s.2 ^ 2 = 0),
        ψ (((1, 0) : ZMod 3 × ZMod 3).1 * s.1 + ((1, 0) : ZMod 3 × ZMod 3).2 * s.2)‖ ≤
      2 * Real.sqrt (Fintype.card (ZMod 3)) :=
  circle_sum_le_of_ne (by rw [ZMod.ringChar_zmod_n]; norm_num)
    (kloostermanBound_of_card_le_five (by rw [ZMod.card]; norm_num)) ψ hψ 0 (1, 0) (by decide) (Or.inr (by decide))

-- the printed theorem's failing case at the planner's numbers: `q = 13`, radius 0, `b = (1, 5)` (`1 + 25 = 26`): the
-- sum has norm `12 > 2√13`. (`circle_sum_le` would be false without `a ≠ 0`; `circle_sum_le_of_ne` stops exactly here.)
example [Fact (Nat.Prime 13)] (ψ : AddChar (ZMod 13) ℂ) (hψ : ψ ≠ 1) :
    2 * Real.sqrt (Fintype.card (ZMod 13)) <
      ‖∑ s ∈ univ.filter (fun s : ZMod 13 × ZMod 13 => s.1 ^ 2 + s.2 ^ 2 = 0),
        ψ (((1, 5) : ZMod 13 × ZMod 13).1 * s.1 + ((1, 5) : ZMod 13 × ZMod 13).2 * s.2)‖ :=
  two_sqrt_lt_circle_sum_zero (by rw [ZMod.ringChar_zmod_n]; norm_num) ψ hψ (1, 5)
    (fun h => one_ne_zero (congrArg Prod.fst h))
    (by
      have h : ((26 : ℕ) : ZMod 13) = 0 := (ZMod.natCast_eq_zero_iff 26 13).mpr ⟨2, rfl⟩
      rw [← h]
      norm_num)
    (by rw [ZMod.card]; norm_num)

-- `normOne_charSum_ge` at a model of all its hypotheses: `Q = 3`, the field of nine elements, Weil's bound at the fields
-- of three elements by the triangle inequality — so at `𝔽₉` the bound `−2√3` is unconditional.
example [Fintype (GaloisField 3 2)] [DecidableEq (GaloisField 3 2)] (ψ : AddChar (GaloisField 3 2) ℂ) (hψ : ψ ≠ 1) :
    -(2 * Real.sqrt (3 : ℕ)) ≤ (∑ u ∈ univ.filter (fun u : GaloisField 3 2 => u ^ (3 + 1) = 1), ψ u).re :=
  normOne_charSum_ge (by norm_num) (by rw [← Nat.card_eq_fintype_card, GaloisField.card 3 2 two_ne_zero])
    (fun F _ _ _ hF => kloostermanBound_of_card_le_five (by omega)) ψ hψ

end HadwigerNelson.StandingFive
