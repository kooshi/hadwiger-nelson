import Mathlib.NumberTheory.FLT.Polynomial
import Mathlib.RingTheory.Polynomial.RationalRoot
import Proofs.HadwigerNelson.Transcendental

/-!
# No rational parametrisation of `y² = x³ − x` (Lemma NP), and Fischer's Remark 1 refuted in one variable

`plans/M2-S1D-bridge.md` §2.3, Lemma NP: *"There is no nonconstant `a ∈ ℂ(t)` for which `a³ − a` is a square in
`ℂ(t)`."* Here for every field `k` with `2 ≠ 0` (`not_isSquare_cube_sub_self`), which is what the one-variable C3 needs
(`k` a subfield of `ℝ`, not `ℂ`).

**The proof.** Write `a = p/q` in lowest terms. If `b² = a³ − a`, then `(b·q²)² = p·q·(p² − q²)`, a polynomial, so
`b·q²` is a polynomial `g` (`k[X]` is integrally closed). The three factors `p`, `q`, `p² − q²` are pairwise coprime, so
each is a unit times a square: `p = r₁α²`, `q = r₂β²`, `p² − q² = r₃γ²`. Then

    r₁²·α⁴ − r₂²·β⁴ − r₃·γ² = 0,

a Fermat–Catalan equation of signature `(4, 4, 2)`. Since `1/4 + 1/4 + 1/2 ≤ 1`, Mathlib's `Polynomial.flt_catalan`
(Mason–Stothers, `Polynomial.abc`) makes `α` and `β` constant, so `a` is constant. The hand proof's `(p − q)(p + q)` split
and its degree count are not needed: `p² − q²` enters as one factor, and the degree count is `flt_catalan`'s.

**Where the genus enters.** The signature condition `qr + rp + pq ≤ pqr` is the curve's genus. On the genus-0 twin
`a² − 1` the same route reaches the signature `(2, 2, 1)`, where it fails (`8 ≤ 4`), and the twin is false:
`a = (X² + 1)/(2X)` (`isSquare_twin_sq_sub_one`). In characteristic 2 NP itself is false: `a = X²`
(`isSquare_cube_sub_self_X_sq_zmod_two`).

**C3, one-variable form.** For `F : Subfield ℝ` with every element algebraic over `ℚ` and `t` transcendental over `F`,
`x := 2 + L` (`L` Liouville's constant) and `√(x³ − x)` do not both lie in `F(t)`
(`not_mem_adjoinTranscendental_liouville`): `F(t) ≅ F(X)`, and NP over `F` would make `x` a constant, i.e. in `F`,
hence algebraic.
-/

set_option autoImplicit false

namespace HadwigerNelson
namespace NoParam

open Polynomial

section Core

variable {k : Type*} [Field k]

/-- A factor coprime to its cofactor in a square is a unit times a square. -/
theorem exists_eq_C_mul_sq_of_mul_eq_sq {x y g : k[X]} (hxy : IsCoprime x y) (h : x * y = g ^ 2) :
    ∃ (r : k) (α : k[X]), r ≠ 0 ∧ α ^ 2 * C r = x := by
  sorry

/-- **The polynomial core of Lemma NP.** If `p` and `q` are coprime and `p·q·(p² − q²)` is a square, then `p` and `q`
are constants (for `2 ≠ 0` in `k`). -/
theorem natDegree_eq_zero_of_mul_mul_sub_eq_sq (h2 : (2 : k) ≠ 0) {p q g : k[X]} (hpq : IsCoprime p q)
    (hg : p * q * (p ^ 2 - q ^ 2) = g ^ 2) : p.natDegree = 0 ∧ q.natDegree = 0 := by
  sorry

/-- A rational function whose square is a polynomial is a polynomial (`k[X]` is integrally closed). -/
theorem exists_algebraMap_eq_of_sq_eq {B : RatFunc k} {P : k[X]} (h : B ^ 2 = algebraMap k[X] (RatFunc k) P) :
    ∃ g : k[X], algebraMap k[X] (RatFunc k) g = B := by
  sorry

/-- **Lemma NP** (`plans/M2-S1D-bridge.md` §2.3), over every field with `2 ≠ 0`: no nonconstant rational function `a`
has `a³ − a` a square. -/
theorem not_isSquare_cube_sub_self (h2 : (2 : k) ≠ 0) {a : RatFunc k}
    (ha : a ∉ Set.range (RatFunc.C (K := k))) : ¬ IsSquare (a ^ 3 - a) := by
  sorry

/-- Lemma NP in the brief's form: characteristic zero. -/
theorem not_isSquare_cube_sub_self_of_charZero [CharZero k] {a : RatFunc k}
    (ha : a ∉ Set.range (RatFunc.C (K := k))) : ¬ IsSquare (a ^ 3 - a) :=
  not_isSquare_cube_sub_self two_ne_zero ha

end Core

/-! ### The controls: the genus-0 twin, and characteristic 2 -/

section Controls

variable (k : Type*) [Field k]

/-- The twin's witness `(X² + 1)/(2X)`. -/
noncomputable def twin : RatFunc k := (RatFunc.X ^ 2 + 1) / (2 * RatFunc.X)

/-- The twin's witness is not constant. -/
theorem twin_not_mem_range_C (h2 : (2 : k) ≠ 0) : twin k ∉ Set.range (RatFunc.C (K := k)) := by
  sorry

/-- **The genus-0 twin of NP is false**: `a² − 1` is a square at the nonconstant `a = (X² + 1)/(2X)`, since
`a² − 1 = ((X² − 1)/(2X))²`. -/
theorem isSquare_twin_sq_sub_one (h2 : (2 : k) ≠ 0) : IsSquare (twin k ^ 2 - 1) := by
  sorry

/-- `X²` is not constant. -/
theorem X_sq_not_mem_range_C : (RatFunc.X : RatFunc k) ^ 2 ∉ Set.range (RatFunc.C (K := k)) := by
  sorry

/-- **NP is false in characteristic 2**: over `𝔽₂`, `a = X²` has `a³ − a = (X(X² + 1))²`. The hypothesis `2 ≠ 0` of
`not_isSquare_cube_sub_self` is not idle. -/
theorem isSquare_cube_sub_self_X_sq_zmod_two :
    IsSquare (((RatFunc.X : RatFunc (ZMod 2)) ^ 2) ^ 3 - RatFunc.X ^ 2) := by
  sorry

end Controls

/-! ### C3, one-variable containment form -/

open RouteC

/-- **The containment core.** For `F ⊆ ℝ`, `t` transcendental over `F`, and `x ∉ F`, no `y` with `y² = x³ − x` lies in
`F(t)` together with `x`: under `F(t) ≅ F(X)`, NP makes the image of `x` a constant, hence `x ∈ F`. -/
theorem not_mem_adjoinTranscendental_of_sq_eq (F : Subfield ℝ) {t : ℝ} (ht : Transcendental F t) {x y : ℝ}
    (hx : x ∉ F) (hxy : y ^ 2 = x ^ 3 - x) :
    ¬ (x ∈ adjoinTranscendental F t ∧ y ∈ adjoinTranscendental F t) := by
  sorry

/-- `2 + L` is transcendental over `ℚ` (`L` Liouville's constant). -/
theorem transcendental_two_add_liouvilleNumber : Transcendental ℚ (2 + liouvilleNumber 10) := by
  sorry

/-- **C3, one-variable containment form** (J17-T5's kernel form): for `F : Subfield ℝ` with every element algebraic
over `ℚ` and `t` transcendental over `F`, the reals `x := 2 + L` and `√(x³ − x)` do not both lie in `F(t)`. -/
theorem not_mem_adjoinTranscendental_liouville (F : Subfield ℝ) (hF : ∀ z ∈ F, IsAlgebraic ℚ z) {t : ℝ}
    (ht : Transcendental F t) :
    ¬ (2 + liouvilleNumber 10 ∈ adjoinTranscendental F t ∧
      Real.sqrt ((2 + liouvilleNumber 10) ^ 3 - (2 + liouvilleNumber 10)) ∈ adjoinTranscendental F t) := by
  sorry

end NoParam
end HadwigerNelson
