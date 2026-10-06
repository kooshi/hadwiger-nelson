import Proofs.HadwigerNelson.Arith.NormOneTarget
import Mathlib.NumberTheory.LegendreSymbol.QuadraticChar.GaussSum

/-!
# The planes' floor: `χ(Γ_Q) ≥ 7` for `Q ≡ 3 (mod 4)`, `Q ≥ 98`, over Weil's bound for Kloosterman sums (FS-131 wave 10)

**Read aloud, against the informal claim.** G56's "every usable plane refuses six by Weil from 98": for a prime power
`Q ≡ 3 (mod 4)` the plane `Γ_Q = UD(𝔽_Q, 2)` is the level-one target of `𝔽_{Q²} = 𝔽_Q(i)`; its non-trivial eigenvalues are
the circle sums `Σ_{s₁² + s₂² = 1} ψ(b₁s₁ + b₂s₂)`, each **minus a Kloosterman sum** of `𝔽_Q`
(`circle_sum_eq_kloosterman`, the completion of `[MMST1996]` (7)–(11); it is FS-20's open item R4, here a theorem), hence
at least `−2√Q` by Weil's bound; the ratio bound then gives `χ ≥ 1 + (Q + 1)/(2√Q) > 6` from `Q = 98` on.

**The one outside theorem, a named hypothesis in this pass** (ruled mid-job: no `axiom` until a held source's page is read
back against it): `KloostermanBound F` — for every non-trivial additive character `ψ` of the finite field `F` and
`a, b ≠ 0`, `|Σ_{x ≠ 0} ψ(a x + b x⁻¹)| ≤ 2√|F|`. The floor reads it at the fields of `Q` elements, `Q ≡ 3 (mod 4)` a prime
power — so at **prime powers** `p^f` with `p ≡ 3 (mod 4)`, `f` odd, not only at primes. `[Weil1948]` is the classical
source (not held; its row states the bound at a prime); `[MMST1996]` Theorem 3 (p. 231, held and read) states the
circle-sum bound directly but is **false as printed at `a = 0`** and is not what is assumed here.

**Inhabitants.** `KloostermanBound F` holds for every field of at most five elements by the triangle inequality
(`kloostermanBound_of_card_le_five`), so it is satisfiable; at larger fields it is Weil's theorem. A field of `Q²` elements
exists for every prime power `Q` (`GaloisField`), so `targetFloor_seven_of_kloosterman` does not quantify over an empty
domain at prime powers, and is empty of content (not false) at a `Q` that is no prime power.
-/

namespace HadwigerNelson.StandingFive

open Finset

/-- **Weil's bound for Kloosterman sums over the finite field `F` — a named classical hypothesis.** For every non-trivial
additive character `ψ` of `F` and `a, b ≠ 0`: `|Σ_{x ∈ Fˣ} ψ(a x + b x⁻¹)| ≤ 2√|F|`. (`[Weil1948]`; for a general finite
field the textbook form is Lidl–Niederreiter, *Finite Fields*, Theorem 5.45 — neither held, so this is a `Prop`, never an
`axiom`, until a page is read back against it.) -/
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

/-- **Completing the square**: for `r ≠ 0` in a finite field of odd characteristic,
`Σ_y ψ(r y² + c y) = ψ(−c²/(4r)) · χ(r) · G`, with `χ` the quadratic character and `G = Σ_y χ(y) ψ(y)` its Gauss sum. -/
theorem sum_quadratic_eq {F : Type*} [Field F] [Fintype F] [DecidableEq F] (hodd : ringChar F ≠ 2) (ψ : AddChar F ℂ)
    (hψ : ψ ≠ 1) {r : F} (hr : r ≠ 0) (c : F) :
    ∑ y : F, ψ (r * y ^ 2 + c * y) =
      ψ (-(c ^ 2 / (4 * r))) * ((quadraticChar F r : ℤ) : ℂ) *
        gaussSum ((quadraticChar F).ringHomComp (Int.castRingHom ℂ)) ψ := by
  sorry

/-- **A circle sum is a Kloosterman sum** (`[MMST1996]` formula (11) at `n = 2`): for a non-trivial `ψ`, any `a`, and
`b ≠ 0`, `Σ_{s₁² + s₂² = a} ψ(b₁s₁ + b₂s₂) = χ(−1) · Σ_{x ≠ 0} ψ(−a x − ((b₁² + b₂²)/4) x⁻¹)`. At `a = 1`,
`|F| ≡ 3 (mod 4)` this is `λ(c) = −K(1, c/4)`, the identity M58 checked numerically. -/
theorem circle_sum_eq_kloosterman {F : Type*} [Field F] [Fintype F] [DecidableEq F] (hodd : ringChar F ≠ 2)
    (ψ : AddChar F ℂ) (hψ : ψ ≠ 1) (a : F) (b : F × F) (hb : b ≠ 0) :
    ∑ s ∈ univ.filter (fun s : F × F => s.1 ^ 2 + s.2 ^ 2 = a), ψ (b.1 * s.1 + b.2 * s.2) =
      ((quadraticChar F (-1) : ℤ) : ℂ) *
        ∑ x : Fˣ, ψ (-a * (x : F) + -((b.1 ^ 2 + b.2 ^ 2) / 4) * ((x⁻¹ : Fˣ) : F)) := by
  sorry

/-- **The circle-sum bound** (`[MMST1996]` Theorem 3 at `n = 2`, with the restriction `a ≠ 0` its printed statement
omits): over Weil's bound at `F`. When `b₁² + b₂² = 0` the Kloosterman sum degenerates to `−1`. -/
theorem circle_sum_le {F : Type*} [Field F] [Fintype F] [DecidableEq F] (hodd : ringChar F ≠ 2) (hK : KloostermanBound F)
    (ψ : AddChar F ℂ) (hψ : ψ ≠ 1) {a : F} (ha : a ≠ 0) (b : F × F) (hb : b ≠ 0) :
    ‖∑ s ∈ univ.filter (fun s : F × F => s.1 ^ 2 + s.2 ^ 2 = a), ψ (b.1 * s.1 + b.2 * s.2)‖ ≤
      2 * Real.sqrt (Fintype.card F) := by
  sorry

/-! ### From the field with an involution to the circle -/

/-- **The character sums of the norm-one set of `𝔽_{Q²}`, `Q ≡ 3 (mod 4)`**: every non-trivial additive character sums to
real part at least `−2√Q` over `{u : u ^ (Q + 1) = 1}`, given Weil's bound at the fields of `Q` elements. (The subfield
`k₀ = {x : x ^ Q = x}` has `Q` elements; `−1` is a square in `k` and not in `k₀`, so `k = k₀ ⊕ k₀·i`, `u ^ (Q + 1) =
u₁² + u₂²`, and `ψ(u₁ + u₂ i) = ψ₀(b₁u₁ + b₂u₂)` for a non-trivial `ψ₀` of `k₀` and some `b ≠ 0`.) -/
theorem normOne_charSum_ge {k : Type} [Field k] [Fintype k] [DecidableEq k] {Q : ℕ} (hQ4 : Q % 4 = 3)
    (hcard : Fintype.card k = Q ^ 2)
    (hK : ∀ (F : Type) [Field F] [Fintype F] [DecidableEq F], Fintype.card F = Q → KloostermanBound F) (ψ : AddChar k ℂ)
    (hψ : ψ ≠ 1) : -(2 * Real.sqrt Q) ≤ (∑ u ∈ univ.filter (fun u : k => u ^ (Q + 1) = 1), ψ u).re := by
  sorry

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

end HadwigerNelson.StandingFive
