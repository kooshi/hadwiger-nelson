import Mathlib.Analysis.SpecialFunctions.Pow.NNReal
import Mathlib.Analysis.SpecialFunctions.Sqrt

/-!
# The multiquadratic tower `ℚ(√3,√5,√7,√11)` as a kernel-computable ℤ-algebra

De Grey's construction lives in `ℚ(√3,√5,√7,√11)`. Represented naively over `ℝ`, checking
"this edge has length 1" is a `Real.sqrt` obligation per edge — hopeless at 7877 edges. Represented
here, as an iterated quadratic extension with an **ℤ leaf**, that check becomes an equality of
integers the kernel decides by GMP-accelerated reduction (measured: 11 spindle edges in ~4 s, no
`native_decide`).

`Adjoin d K` is `K[√d]`: `re` is the `√d`-free part, `im` the coefficient of `√d`. The tower is

```
Q4 := Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))
```

## The one thing that matters about `eval`

`eval : Q4 →+* ℝ` is a **ring homomorphism**, and we never need it injective. `distSq` is a
polynomial in the coordinates, so a ring hom commutes with it; one `Real.sq_sqrt` per generator is
the whole story. No basis independence, no minimal polynomials.
-/

namespace HadwigerNelson

/-- `K[√d]`: `re + im · √d`. The radicand `d` is a `ℕ` parameter; `√d` is realised only by `eval`. -/
structure Adjoin (d : ℕ) (K : Type*) where
  re : K
  im : K
deriving DecidableEq, Repr

namespace Adjoin

variable {d : ℕ} {K : Type*}

section Instances
variable [CommRing K]

instance : Zero (Adjoin d K) := ⟨⟨0, 0⟩⟩
instance : One (Adjoin d K) := ⟨⟨1, 0⟩⟩
instance : Add (Adjoin d K) := ⟨fun x y => ⟨x.re + y.re, x.im + y.im⟩⟩
instance : Neg (Adjoin d K) := ⟨fun x => ⟨-x.re, -x.im⟩⟩
instance : Sub (Adjoin d K) := ⟨fun x y => ⟨x.re - y.re, x.im - y.im⟩⟩
instance : Mul (Adjoin d K) :=
  ⟨fun x y => ⟨x.re * y.re + (d : K) * (x.im * y.im), x.re * y.im + x.im * y.re⟩⟩

/-- The ring structure. This is M02's one real proof obligation — everything downstream needs it,
because `eval` must be a `RingHom` (both sides rings) and `distSq`'s soundness rides on
ring-hom-commutes-with-polynomial. -/
instance : CommRing (Adjoin d K) := by sorry

/-- Embed the base ring as the `√d`-free part. -/
def ofBase (k : K) : Adjoin d K := ⟨k, 0⟩

end Instances

/-- Evaluate into `ℝ`: given a base evaluation and a real square root `r` of `d`, send
`⟨a,b⟩ ↦ eval_base a + b·r`. A `RingHom` because `r² = d` makes the `√d`-multiplication law hold in
`ℝ`. -/
def eval [CommRing K] (evalBase : K →+* ℝ) (r : ℝ) (_hr : r ^ 2 = d) :
    Adjoin d K →+* ℝ where
  toFun x := evalBase x.re + evalBase x.im * r
  map_one' := by sorry
  map_mul' := by sorry
  map_zero' := by sorry
  map_add' := by sorry

end Adjoin

/-! ## The concrete tower -/

/-- `ℚ(√3,√5,√7,√11)` as a kernel-computable ℤ-algebra. -/
abbrev Q4 : Type := Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))

/-- `Q4 →+* ℝ`, the four generators sent to `√3, √5, √7, √11`. -/
noncomputable def Q4.eval : Q4 →+* ℝ :=
  Adjoin.eval (Adjoin.eval (Adjoin.eval (Adjoin.eval (Int.castRingHom ℝ)
    (Real.sqrt 3) (by sorry)) (Real.sqrt 5) (by sorry)) (Real.sqrt 7) (by sorry))
    (Real.sqrt 11) (by sorry)

end HadwigerNelson
