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
  /-- The `√d`-free component. -/
  re : K
  /-- The coefficient of `√d`. -/
  im : K
deriving DecidableEq, Repr

/-- A ℕ-scalar action that computes, bundled with the proof that it agrees with the ring cast.

Carrying the law in the class is the point: `smul` is what the kernel reduces (straight to the ℤ
leaves) and `smul_eq` is what the ring proofs rewrite with, so the two can never drift.

The parameter is `[CommRing K]`, not `[NatCast K] [Mul K]`. Instance parameters are matched
syntactically, so a class indexed on the *pieces* only synthesizes where the ambient `NatCast` and
`Mul` happen to be found by the same route that declared the instance — which for a tower is never
reliably true. Indexing on the single bundled structure makes the route unique. -/
class NatScalar (K : Type*) [CommRing K] where
  /-- The fast action: multiply each `ℤ` leaf, never forming the tower element `(n : K)`. -/
  smul : ℕ → K → K
  /-- …and it agrees with the ring cast, so the two can never drift. -/
  smul_eq : ∀ (n : ℕ) (x : K), smul n x = (n : K) * x

/-- The ℤ leaf's scalar action: ordinary integer multiplication. -/
instance : NatScalar ℤ where
  smul n x := (n : ℤ) * x
  smul_eq _ _ := rfl

namespace Adjoin

variable {d : ℕ} {K : Type*} [CommRing K]

/-! ### Arithmetic — the operations the kernel reduces

Plain `def`s, not instances. There is exactly **one** arithmetic instance on `Adjoin` — `commRing`
below — and every `+`, `*`, `-`, cast on the tower resolves through it. Declaring `Add`, `Mul`,
`IntCast` … separately as well is the trap: instance search then picks the raw one for some
operations and the `CommRing` projection for others, the two are defeq but not syntactically equal,
and every Mathlib lemma (`map_add`, `map_intCast`, …) silently fails to match. That failure is not
an error message — it is `ring` refusing a true goal — so the one-path rule is enforced here rather
than debugged later. -/

/-- Additive identity. -/
def zero : Adjoin d K := ⟨0, 0⟩
/-- Multiplicative identity. -/
def one : Adjoin d K := ⟨1, 0⟩
/-- Componentwise addition. -/
def add (x y : Adjoin d K) : Adjoin d K := ⟨x.re + y.re, x.im + y.im⟩
/-- Componentwise negation. -/
def neg (x : Adjoin d K) : Adjoin d K := ⟨-x.re, -x.im⟩
/-- Componentwise subtraction — a primitive rather than `add x (neg y)`, so the kernel walks the
tower once instead of twice. -/
def sub (x y : Adjoin d K) : Adjoin d K := ⟨x.re - y.re, x.im - y.im⟩
/-- `ℕ` in the `√d`-free part. -/
def natCast (n : ℕ) : Adjoin d K := ⟨(n : K), 0⟩
/-- `ℤ` in the `√d`-free part. -/
def intCast (n : ℤ) : Adjoin d K := ⟨(n : K), 0⟩

/-- `(a + b√d)(c + e√d) = (ac + d·be) + (ae + bc)√d`, with `d·` a **scalar** action pushed to the
leaves rather than a ring multiplication by a mostly-zero tower element.

Reason about products through `mul_re` and `mul_im`, never by unfolding this definition: the scalar
action is a computational detail this API does not promise, and `mul_re` already states the product
in the form `ring` accepts. -/
def mul [NatScalar K] (x y : Adjoin d K) : Adjoin d K :=
  ⟨x.re * y.re + NatScalar.smul d (x.im * y.im), x.re * y.im + x.im * y.re⟩

/-! ### The ring axioms, stated about the definitions

Proved here rather than inline in the `CommRing` declaration, because inside that declaration the
goals are phrased in the notation of the instance *being built* — `a + b`, not `Adjoin.add a b` —
so `simp` cannot see the definitions to unfold. Stating each axiom about the plain `def` gives
`simp` something to grip, and each is then accepted as a structure field by defeq.

The proofs are uniform: `ext` into components, unfold, `ring`. That uniformity is the payoff of
choosing a concrete representation — every ring axiom is the corresponding axiom in `K`, twice. -/

section Axioms

private theorem add_assoc' (a b c : Adjoin d K) : add (add a b) c = add a (add b c) := by
  ext <;> simp [add] <;> ring
private theorem zero_add' (a : Adjoin d K) : add zero a = a := by ext <;> simp [add, zero]
private theorem add_zero' (a : Adjoin d K) : add a zero = a := by ext <;> simp [add, zero]
private theorem add_comm' (a b : Adjoin d K) : add a b = add b a := by ext <;> simp [add] <;> ring
private theorem neg_add_cancel' (a : Adjoin d K) : add (neg a) a = zero := by
  ext <;> simp [add, neg, zero]
private theorem sub_eq_add_neg' (a b : Adjoin d K) : sub a b = add a (neg b) := by
  ext <;> simp [sub, add, neg] <;> ring
private theorem natCast_zero' : (natCast 0 : Adjoin d K) = zero := by ext <;> simp [natCast, zero]
private theorem natCast_succ' (n : ℕ) : (natCast (n + 1) : Adjoin d K) = add (natCast n) one := by
  ext <;> simp [natCast, add, one]
private theorem intCast_ofNat' (n : ℕ) : (intCast n : Adjoin d K) = natCast n := by
  ext <;> simp [intCast, natCast]
private theorem intCast_negSucc' (n : ℕ) :
    (intCast (Int.negSucc n) : Adjoin d K) = neg (natCast (n + 1)) := by
  ext <;> simp [intCast, natCast, neg]
variable [NatScalar K]

private theorem left_distrib' (a b c : Adjoin d K) :
    mul a (add b c) = add (mul a b) (mul a c) := by
  ext <;> simp [mul, add, NatScalar.smul_eq] <;> ring
private theorem right_distrib' (a b c : Adjoin d K) :
    mul (add a b) c = add (mul a c) (mul b c) := by
  ext <;> simp [mul, add, NatScalar.smul_eq] <;> ring
private theorem zero_mul' (a : Adjoin d K) : mul zero a = zero := by
  ext <;> simp [mul, zero, NatScalar.smul_eq]
private theorem mul_zero' (a : Adjoin d K) : mul a zero = zero := by
  ext <;> simp [mul, zero, NatScalar.smul_eq]
private theorem mul_assoc' (a b c : Adjoin d K) : mul (mul a b) c = mul a (mul b c) := by
  ext <;> simp [mul, NatScalar.smul_eq] <;> ring
private theorem one_mul' (a : Adjoin d K) : mul one a = a := by
  ext <;> simp [mul, one, NatScalar.smul_eq]
private theorem mul_one' (a : Adjoin d K) : mul a one = a := by
  ext <;> simp [mul, one, NatScalar.smul_eq]
private theorem mul_comm' (a b : Adjoin d K) : mul a b = mul b a := by
  ext <;> simp [mul, NatScalar.smul_eq] <;> ring

end Axioms

/-! ### The ring structure

Every data field is pinned to a definition above, so the `CommRing` projections reduce to *them*.
`nsmul`, `zsmul` and `npow` are pinned to the `…Rec` forms deliberately: nothing on the certificate
path ever computes them, and naming them keeps the field from being filled by a route the next
Mathlib bump might change. -/

/-- M02's one genuine proof obligation: everything downstream needs it, because `eval` must be a
`RingHom` and `distSq`'s soundness rides on ring-hom-commutes-with-polynomial. -/
instance commRing [NatScalar K] : CommRing (Adjoin d K) where
  zero := zero
  one := one
  add := add
  mul := mul
  neg := neg
  sub := sub
  natCast := natCast
  intCast := intCast
  nsmul := @nsmulRec (Adjoin d K) ⟨zero⟩ ⟨add⟩
  zsmul := @zsmulRec (Adjoin d K) ⟨zero⟩ ⟨add⟩ ⟨neg⟩ (@nsmulRec (Adjoin d K) ⟨zero⟩ ⟨add⟩)
  npow := @npowRec (Adjoin d K) ⟨one⟩ ⟨mul⟩
  add_assoc := add_assoc'
  zero_add := zero_add'
  add_zero := add_zero'
  add_comm := add_comm'
  neg_add_cancel := neg_add_cancel'
  sub_eq_add_neg := sub_eq_add_neg'
  natCast_zero := natCast_zero'
  natCast_succ := natCast_succ'
  intCast_ofNat := intCast_ofNat'
  intCast_negSucc := intCast_negSucc'
  left_distrib := left_distrib'
  right_distrib := right_distrib'
  zero_mul := zero_mul'
  mul_zero := mul_zero'
  mul_assoc := mul_assoc'
  one_mul := one_mul'
  mul_one := mul_one'
  mul_comm := mul_comm'

section Scalar
variable [NatScalar K]

/-! ### Component simp lemmas — the reasoning surface

**The simp destination is components.** These drive any goal about `Adjoin` arithmetic out of the
tower and into `K`, where `ring` closes it. Nothing downstream should ever require unfolding a
definition or a projection.

All are `rfl` except `mul_re`, which is the one lemma that *changes* the term: it trades the fast
`NatScalar.smul` for `(d : K) * _`, the form `ring` understands. That asymmetry is safe because the
computational path never consults `simp` — `Valid` is discharged by `decide`, i.e. by kernel
reduction of the definitions, so the simp set is free to normalise toward provability while the
kernel reduces toward speed. -/

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
@[simp] theorem natCast_re (n : ℕ) : (n : Adjoin d K).re = (n : K) := rfl
@[simp] theorem natCast_im (n : ℕ) : (n : Adjoin d K).im = 0 := rfl
@[simp] theorem intCast_re (n : ℤ) : (n : Adjoin d K).re = (n : K) := rfl
@[simp] theorem intCast_im (n : ℤ) : (n : Adjoin d K).im = 0 := rfl

/-- Multiplication's real part, with the scalar action already rewritten to the cast — the form
`ring` can work with. -/
@[simp] theorem mul_re (x y : Adjoin d K) :
    (x * y).re = x.re * y.re + (d : K) * (x.im * y.im) :=
  congrArg (x.re * y.re + ·) (NatScalar.smul_eq d (x.im * y.im))

@[simp] theorem mul_im (x y : Adjoin d K) :
    (x * y).im = x.re * y.im + x.im * y.re := rfl

/-- The tower level's own scalar action: recurse into both components. -/
instance : NatScalar (Adjoin d K) where
  smul n x := ⟨NatScalar.smul n x.re, NatScalar.smul n x.im⟩
  smul_eq n x := by ext <;> simp [NatScalar.smul_eq]

/-- Evaluate into `ℝ`: given a base evaluation and a real square root `r` of `d`, send
`⟨a,b⟩ ↦ evalBase a + evalBase b · r`.

A `RingHom` precisely because `r² = d`: `map_mul'` needs the cross terms to agree, and they do
exactly when `r²` and `d` coincide. `hr` carries no underscore because it is load-bearing — without
it this is not multiplicative. -/
def eval (evalBase : K →+* ℝ) (r : ℝ) (hr : r ^ 2 = d) : Adjoin d K →+* ℝ where
  toFun x := evalBase x.re + evalBase x.im * r
  map_one' := by simp
  map_mul' x y := by
    simp only [mul_re, mul_im, map_add, map_mul, map_natCast]
    linear_combination (-(evalBase x.im * evalBase y.im)) * hr
  map_zero' := by simp
  map_add' x y := by simp only [add_re, add_im, map_add]; ring

end Scalar

end Adjoin

/-! ## The concrete tower -/

/-- `ℚ(√3,√5,√7,√11)` as a kernel-computable ℤ-algebra: sixteen ℤ leaves. -/
abbrev Q4 : Type := Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))

/-- `Q4 →+* ℝ`, the four generators sent to `√3, √5, √7, √11`.

Reason about it through the `RingHom` API — `map_add`, `map_sub`, `map_mul`, `map_intCast` — never
by unfolding. That it is a ring hom is the *only* property anything downstream needs; in particular
it is **not** injective as far as this development is concerned, and no proof may assume it is. -/
noncomputable def Q4.eval : Q4 →+* ℝ :=
  Adjoin.eval (Adjoin.eval (Adjoin.eval (Adjoin.eval (Int.castRingHom ℝ)
    (Real.sqrt 3) (by rw [Real.sq_sqrt] <;> norm_num))
    (Real.sqrt 5) (by rw [Real.sq_sqrt] <;> norm_num))
    (Real.sqrt 7) (by rw [Real.sq_sqrt] <;> norm_num))
    (Real.sqrt 11) (by rw [Real.sq_sqrt] <;> norm_num)

end HadwigerNelson
