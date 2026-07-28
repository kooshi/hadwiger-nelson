import Mathlib.Analysis.SpecialFunctions.Pow.NNReal
import Mathlib.Analysis.SpecialFunctions.Sqrt

/-!
# The multiquadratic tower `ℚ(√3,√5,√7,√11)` as a kernel-computable ℤ-algebra

De Grey's construction lives in `ℚ(√3,√5,√7,√11)`. Over `ℝ` with `Real.sqrt`, checking "this edge
has length 1" is an `nlinarith` obligation per edge — hopeless at 7877 edges. Here it becomes an
equality of integers the kernel decides by reduction.

`Adjoin d K` is `K[√d]`: `re` is the `√d`-free part, `im` the coefficient of `√d`. The tower is
`Q4 := Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))`, sixteen ℤ leaves.

## Why not Mathlib's quadratic extensions

`Zsqrtd d` has ℤ components and does not tower. `AdjoinRoot f` is `R[X] ⧸ span {f}` — a **quotient**,
and `decide` cannot reduce through `Quotient.mk`. The right mathematics is the wrong representation
when the point is kernel computation, so `Adjoin` is concrete.

The *construction* still comes from Mathlib: this file follows `Zsqrtd`'s pattern exactly — declare
the arithmetic as plain data instances, then build `CommRing` from them with `refine { … with … }`,
so the ring's `*` **is** the fast `Mul` definitionally. One layer, not two: proofs reason with the
ring structure and the kernel reduces the same operations.

## The radicand is a scalar, not a ring element

`Adjoin d K` is a free `K`-module of rank 2 whose multiplication law uses `d` as a *scalar*.
Writing that law as `x.re * y.re + (d : K) * (x.im * y.im)` treats `d` as a full tower element that
is zero in 15 of its 16 components, turning each level's 4 sub-multiplications into 5: the leaf-mult
count per `Q4` product goes `4⁴ = 256` → `5⁴ = 625`. Measured on 99 de Grey edges, kernel `decide`
went **23.1 s → 13.8 s** when the cast was replaced by `NatScalar.smul`. Hence the class below,
which bundles the fast action with the proof that it agrees with the cast so the two cannot drift.

## The one thing that matters about `eval`

`eval : Q4 →+* ℝ` is a **ring homomorphism**, and we never need it injective. `distSq` is a
polynomial in the coordinates, so a ring hom commutes with it; one `Real.sq_sqrt` per generator is
the whole story. No basis independence, no minimal polynomials.
-/

namespace HadwigerNelson

/-- `K[√d]`: `re + im · √d`. The radicand `d` is a type index — `K[√3]` and `K[√5]` are genuinely
different rings and `Mul` must dispatch on it, so a field would make multiplication between
mismatched radicands representable. `√d` itself is realised only by `eval`. -/
@[ext]
structure Adjoin (d : ℕ) (K : Type*) where
  re : K
  im : K
deriving DecidableEq, Repr

/-- A ℕ-scalar action that computes, bundled with the proof that it agrees with the ring cast.

Carrying the law in the class is the point: `smul` is what the kernel reduces (straight to the ℤ
leaves) and `smul_eq` is what the ring proofs rewrite with, so the two can never drift. -/
class NatScalar (K : Type*) [NatCast K] [Mul K] where
  smul : ℕ → K → K
  smul_eq : ∀ (n : ℕ) (x : K), smul n x = (n : K) * x

/-- The ℤ leaf's scalar action: ordinary integer multiplication. -/
instance : NatScalar ℤ where
  smul n x := (n : ℤ) * x
  smul_eq _ _ := rfl

namespace Adjoin

variable {d : ℕ} {K : Type*} [CommRing K]

/-! ### Arithmetic — the data instances the kernel reduces -/

instance : Zero (Adjoin d K) := ⟨⟨0, 0⟩⟩
instance : One (Adjoin d K) := ⟨⟨1, 0⟩⟩
instance : Add (Adjoin d K) := ⟨fun x y => ⟨x.re + y.re, x.im + y.im⟩⟩
instance : Neg (Adjoin d K) := ⟨fun x => ⟨-x.re, -x.im⟩⟩
instance : Sub (Adjoin d K) := ⟨fun x y => ⟨x.re - y.re, x.im - y.im⟩⟩
instance : NatCast (Adjoin d K) := ⟨fun n => ⟨(n : K), 0⟩⟩
instance : IntCast (Adjoin d K) := ⟨fun n => ⟨(n : K), 0⟩⟩

/-! ### Component simp lemmas — the reasoning surface

Every ring axiom is proved by `ext`-ing to components and calling `ring`, so these are what make
that one-liner work. All true by `rfl` except `mul_re`, which trades the scalar action for the
cast. -/

@[simp] theorem add_re (x y : Adjoin d K) : (x + y).re = x.re + y.re := rfl
@[simp] theorem add_im (x y : Adjoin d K) : (x + y).im = x.im + y.im := rfl
@[simp] theorem sub_re (x y : Adjoin d K) : (x - y).re = x.re - y.re := rfl
@[simp] theorem sub_im (x y : Adjoin d K) : (x - y).im = x.im - y.im := rfl
@[simp] theorem neg_re (x : Adjoin d K) : (-x).re = -x.re := rfl
@[simp] theorem neg_im (x : Adjoin d K) : (-x).im = -x.im := rfl
@[simp] theorem zero_re : (0 : Adjoin d K).re = 0 := rfl
@[simp] theorem zero_im : (0 : Adjoin d K).im = 0 := rfl
@[simp] theorem one_re : (1 : Adjoin d K).re = 1 := rfl
@[simp] theorem one_im : (1 : Adjoin d K).im = 0 := rfl

section Scalar
variable [NatScalar K]

/-- `(a + b√d)(c + e√d) = (ac + d·be) + (ae + bc)√d`, with `d·` a **scalar** action pushed to the
leaves rather than a ring multiplication by a mostly-zero tower element. -/
instance : Mul (Adjoin d K) :=
  ⟨fun x y => ⟨x.re * y.re + NatScalar.smul d (x.im * y.im), x.re * y.im + x.im * y.re⟩⟩

/-- The tower level's own scalar action: recurse into both components. -/
instance : NatScalar (Adjoin d K) where
  smul n x := ⟨NatScalar.smul n x.re, NatScalar.smul n x.im⟩
  smul_eq := by sorry

/-- Multiplication's real part, with the scalar action already rewritten to the cast — the form
`ring` can work with. -/
@[simp] theorem mul_re (x y : Adjoin d K) :
    (x * y).re = x.re * y.re + (d : K) * (x.im * y.im) := by
  sorry

@[simp] theorem mul_im (x y : Adjoin d K) :
    (x * y).im = x.re * y.im + x.im * y.re := rfl

/-! ### The ring structure -/

instance addCommGroup : AddCommGroup (Adjoin d K) := by sorry

/-- M02's one genuine proof obligation: everything downstream needs it, because `eval` must be a
`RingHom` and `distSq`'s soundness rides on ring-hom-commutes-with-polynomial. -/
instance commRing : CommRing (Adjoin d K) := by sorry

/-- Evaluate into `ℝ`: given a base evaluation and a real square root `r` of `d`, send
`⟨a,b⟩ ↦ evalBase a + evalBase b · r`.

A `RingHom` precisely because `r² = d`: `map_mul'` needs the cross terms to agree, and they do
exactly when `r²` and `d` coincide. `hr` carries no underscore because it is load-bearing — without
it this is not multiplicative. -/
def eval (evalBase : K →+* ℝ) (r : ℝ) (hr : r ^ 2 = d) : Adjoin d K →+* ℝ where
  toFun x := evalBase x.re + evalBase x.im * r
  map_one' := by sorry
  map_mul' := by sorry
  map_zero' := by sorry
  map_add' := by sorry

end Scalar

end Adjoin

/-! ## The concrete tower -/

/-- `ℚ(√3,√5,√7,√11)` as a kernel-computable ℤ-algebra: sixteen ℤ leaves. -/
abbrev Q4 : Type := Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))

/-- `Q4 →+* ℝ`, the four generators sent to `√3, √5, √7, √11`. -/
noncomputable def Q4.eval : Q4 →+* ℝ :=
  Adjoin.eval (Adjoin.eval (Adjoin.eval (Adjoin.eval (Int.castRingHom ℝ)
    (Real.sqrt 3) (by sorry)) (Real.sqrt 5) (by sorry)) (Real.sqrt 7) (by sorry))
    (Real.sqrt 11) (by sorry)

end HadwigerNelson
