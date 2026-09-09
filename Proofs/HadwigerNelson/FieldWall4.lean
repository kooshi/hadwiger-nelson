import Proofs.HadwigerNelson.Ladder
import Proofs.HadwigerNelson.ResidueColouring
import Proofs.HadwigerNelson.SpareColour
import Proofs.HadwigerNelson.FieldWall
import Proofs.HadwigerNelson.Instances.SpindleBound

/-!
# The field wall: `χ(ℚ(√3, √11)²) = 4`

Colour the plane over `K = ℚ(√3, √11)` — the complex numbers whose real and imaginary parts are
ℚ-combinations of `1, √3, √11, √33` — so that no two points one unit apart share a colour. Four
colours suffice, and four are needed: the Moser spindle can be drawn in `K²`, and `K` is the
smallest field in which it can be drawn at all. So `χ(K²) = 4` exactly.

This is Theorem B of `plans/FIELD-WALL-THEOREM.md` §5, hand-proved 2026-09-05 by the session that
was asked to write the conjecture up for a stranger and proved it instead. It is the theorem that
halted the M53 descent: a construction confined to `K²` is 4-colourable, so by the spare-colour
lemma it can never force a pair at five colours, so it can never terminate
(`not_forces_five_of_subset_seamPlane` below).

## The mechanism, in one paragraph

Colour a point by its residue modulo a prime above `2` — Woodall's 2-colouring of `ℚ²`, one field
up. Concretely, let `O = ℤ[ω, i, T]` with `ω = ζ₃` and `T = (1+√33)/2`: a free ℤ-module of rank
eight, and the order this file colours by. It carries two ring homomorphisms onto the four-element
field `𝔽₄` (`psiZero`, `psiOne`: `ω ↦ Ω`, `i ↦ 1`, `T ↦ 0` resp. `1`) — the two primes above `2`.
Complex conjugation of the order induces Frobenius on `𝔽₄` (`psi_comp_conj`), so a unit vector
`u` — one with `u·ū = 1` — has an odd denominator over `O` (`mem_oddDenom_of_unit`): if the
denominator were even, both residue maps would kill the numerator, and the numerator would be
divisible by `(1+i)² = 2i`, halving the denominator. On the subring `A = O[1/odd]` the residue
descends (`psiA`), a unit vector is a unit of `A` and so has nonzero residue, and every unit step
stays inside one coset of `A`. Choosing a representative per coset gives the colouring
(`residueColouring`), which is proper on the whole plane over `K` with no finiteness hypothesis.

**The last two sentences are not proved here.** They are
`Proofs/HadwigerNelson/ResidueColouring.lean` — the residue colouring in general, of which this file
is one instance: the arithmetic below (the order, the two residue maps, the parity descent, the
Moser spindle in the order) is everything that is specific to `K`, and the colouring itself,
its properness, and the unit-is-a-unit step are the general theorem applied at `A = oddDenom`,
`ψ = psiA`.

## Why this shape

The hand proof runs through the localization of `O` at a prime above `2`, proves that local ring
is a discrete valuation ring, and concludes that every unit vector or its inverse is integral. None
of that is needed. In the basis `{1, ω} × {1, i} × {1, T}` the joint kernel of the two residue maps
is *visibly* `(1+i)·O`: writing `z = p + q·i`, the two conditions say exactly that `p` and `q` agree
modulo `2` in all four coordinates, and then `z/(1+i) = (p+q)/2 + ((q−p)/2)·i` has integer
coordinates (`exists_mul_onePlusI`). No ideal, no localization, no valuation.

`T` is what makes the order maximal at `2`, and it is load-bearing: the Moser twist
`ρ = (5 + i√11)/6` is `(7 − ω + T + 2ωT)/9`, which has no integer coordinates without it, and in
the smaller order `ℤ[ζ₁₂, √33]` the descent fails outright (`1 + √33 = 2T` satisfies its hypothesis
and not its conclusion). `𝔽₄` is forced too: `Φ₁₂` has no root in `ℤ/4` or in `𝔽₂[ε]/(ε²)`.

## Two tables that look like they disagree

`plans/FIELD-WALL-THEOREM.md` §5.3 lists `ζ₆ ↦ ω², ρ ↦ ω, σ ↦ ω², τ₅ ↦ ω²`; the spec section below
gets `ζ₆ ↦ Ω², ρ ↦ Ω², σ ↦ Ω², τ₅ ↦ Ω`. They are the **two different primes**: the write-up fixes
its 2-adic embedding by `√33 ↦ s ≡ 17 (mod 256)`, so its `T = (1+s)/2 ≡ 9 ≡ 1` and its prime is
this file's `psiOne`. Either prime colours; `psiZero` is the one used.

## Using this file

* `four_colorable_of_seam_field` — the headline; `colorable_four_of_subset_seamPlane` for any subset
  of `K²`, and `chromaticNumber_seamPlane` for the exact value.
* To certify that a point lies in `K²`: `mem_seamPlane_iff`, `mem_seamField_iff`, and the generators
  `sqrt3_mem`, `sqrt11_mem`, `sqrt33_mem` — after which the whole `Subfield` API (`add_mem`,
  `mul_mem`, `inv_mem`, `ratCast_mem`, …) applies. A worked example is in the spec section.
* `residueColouring` is the colouring itself, with `residueColouring_ne_of_dist_one` its properness
  and `residueColouring_eq_of_dist_two` the reason no version of this theorem holds for the
  `{1, 2}`-distance graph — Exoo–Ismailescu's 6-chromatic `{1, 2}`-graph has all its coordinates
  in `K`.
* To colour a plane over a *different* field, do not copy this file: supply a conjugation-stable
  subring, a ring homomorphism to a finite nontrivial ring, and a proof that unit-distance
  differences land in the subring, and call
  `ResidueColouring.colorable_unitDistance_induce_of_residue`. What is specific to `K` here is
  `conj_mem_oddDenom`, `psiA`, and `mem_oddDenom_of_unit` — three inputs, nothing else.

## Attribution

The residue-colouring method is Woodall's (1973) and Fischer's (1990); Theorem B, the location of
the wall at `2`, and this proof's outline are the write-up's. Ours is the formalization, the
parity descent that replaces the valuation theory, and the reading of the Moser spindle as an
identity in the order.
-/

namespace HadwigerNelson
namespace FieldWall4

open Complex

/-! ## §1 `F4`, the four-element field

`𝔽₄ = 𝔽₂[Ω]/(Ω² + Ω + 1)`, concrete rather than `GaloisField 2 2`: every fact below is a four- or
sixteen-case `decide`, and `u + v·Ω = 0 → u = 0 ∧ v = 0` — the step the descent of §5 turns on —
is componentwise by construction. -/

/-- `F4 = 𝔽₂[Ω]/(Ω² + Ω + 1)`: the element `u + v·Ω`. -/
@[ext] structure F4 where
  /-- The `Ω`-free component. -/
  u : ZMod 2
  /-- The coefficient of `Ω`. -/
  v : ZMod 2
deriving DecidableEq, Fintype, Repr

namespace F4

instance : Zero F4 := ⟨⟨0, 0⟩⟩
instance : One F4 := ⟨⟨1, 0⟩⟩
instance : Add F4 := ⟨fun x y => ⟨x.u + y.u, x.v + y.v⟩⟩
instance : Neg F4 := ⟨fun x => x⟩
instance : Sub F4 := ⟨fun x y => ⟨x.u + y.u, x.v + y.v⟩⟩
instance : Mul F4 := ⟨fun x y => ⟨x.u * y.u + x.v * y.v, x.u * y.v + x.v * y.u + x.v * y.v⟩⟩
instance : NatCast F4 := ⟨fun n => ⟨(n : ZMod 2), 0⟩⟩
instance : IntCast F4 := ⟨fun n => ⟨(n : ZMod 2), 0⟩⟩

@[simp] theorem zero_u : (0 : F4).u = 0 := rfl
@[simp] theorem zero_v : (0 : F4).v = 0 := rfl
@[simp] theorem one_u : (1 : F4).u = 1 := rfl
@[simp] theorem one_v : (1 : F4).v = 0 := rfl
@[simp] theorem add_u (x y : F4) : (x + y).u = x.u + y.u := rfl
@[simp] theorem add_v (x y : F4) : (x + y).v = x.v + y.v := rfl
/-- Characteristic two: negation is the identity. -/
@[simp] theorem neg_eq (x : F4) : -x = x := rfl
@[simp] theorem natCast_u (n : ℕ) : ((n : F4)).u = (n : ZMod 2) := rfl
@[simp] theorem natCast_v (n : ℕ) : ((n : F4)).v = 0 := rfl
@[simp] theorem intCast_u (n : ℤ) : ((n : F4)).u = (n : ZMod 2) := rfl
@[simp] theorem intCast_v (n : ℤ) : ((n : F4)).v = 0 := rfl
theorem mul_u (x y : F4) : (x * y).u = x.u * y.u + x.v * y.v := rfl
theorem mul_v (x y : F4) : (x * y).v = x.u * y.v + x.v * y.u + x.v * y.v := rfl

instance instCommRing : CommRing F4 where
  add_assoc := by decide
  zero_add := by decide
  add_zero := by decide
  add_comm := by decide
  neg_add_cancel := by decide
  mul_assoc := by decide
  one_mul := by decide
  mul_one := by decide
  left_distrib := by decide
  right_distrib := by decide
  mul_comm := by decide
  zero_mul := by decide
  mul_zero := by decide
  sub_eq_add_neg := by decide
  natCast_zero := by ext <;> simp
  natCast_succ := fun n => by ext <;> simp
  intCast_ofNat := fun n => by ext <;> simp
  intCast_negSucc := fun n => by
    ext
    · show ((Int.negSucc n : ℤ) : ZMod 2) = _
      simp [Int.negSucc_eq, CharTwo.neg_eq]; ring
    · rfl
  nsmul := nsmulRec
  zsmul := zsmulRec

/-- The primitive cube root of unity, `Ω`. -/
def om : F4 := ⟨0, 1⟩

@[simp] theorem om_u : om.u = 0 := rfl
@[simp] theorem om_v : om.v = 1 := rfl

instance : Nontrivial F4 := ⟨0, 1, by decide⟩

/-- `𝔽₄` has no zero divisors — sixteen cases. This is what lets `ResidueColouring`'s
`map_mul_conj_eq_zero_iff` be instantiated here: the general statement spends primality of the
residue map's kernel, and an instance is how a caller pays for it without a hypothesis. -/
instance : NoZeroDivisors F4 where
  eq_zero_or_eq_zero_of_mul_eq_zero := by decide

theorem card_eq_four : Fintype.card F4 = 4 := by decide

/-- `𝔽₄` is a field, in the one form §5 consumes. -/
theorem eq_zero_of_cube_eq_zero {x : F4} (h : x * (x * x) = 0) : x = 0 := by
  revert h; revert x; decide

/-- **Frobenius.** Squaring is a ring homomorphism, because the characteristic is two. It is what
conjugation of the order induces on the residue field (`psi_comp_conj`). -/
def sq : F4 →+* F4 where
  toFun x := x * x
  map_one' := by decide
  map_mul' := by decide
  map_zero' := by decide
  map_add' := by decide

@[simp] theorem sq_apply (x : F4) : sq x = x * x := rfl

private theorem zmod2_sq (a : ZMod 2) : a * a = a := by revert a; decide

private theorem two_zmod2 : ((2 : ℤ) : ZMod 2) = 0 := by decide

/-- Integer residues lie in the prime field, where every element is idempotent. -/
theorem intCast_sq (n : ℤ) : ((n : ℤ) : F4) * ((n : ℤ) : F4) = ((n : ℤ) : F4) := by
  ext <;> simp [mul_u, mul_v, zmod2_sq]

theorem intCast_odd {n : ℤ} (h : Odd n) : (n : F4) = 1 := by
  obtain ⟨k, rfl⟩ := h
  ext
  · show (((2 * k + 1 : ℤ)) : ZMod 2) = 1
    push_cast [two_zmod2]; ring_nf; rw [show ((2 : ZMod 2)) = 0 from rfl]; ring
  · rfl

theorem intCast_even {n : ℤ} (h : Even n) : (n : F4) = 0 := by
  obtain ⟨k, rfl⟩ := h
  ext
  · show (((k + k : ℤ)) : ZMod 2) = 0
    have : ((k + k : ℤ) : ZMod 2) = ((2 : ℤ) : ZMod 2) * (k : ZMod 2) := by push_cast; ring
    rw [this, two_zmod2, zero_mul]
  · rfl

/-- Characteristic two, in the form the descent reads the residue conditions with. -/
theorem eq_of_add_eq_zero {x y : F4} (h : x + y = 0) : x = y := by revert h; revert x y; decide

end F4

/-! ## §2 The generic quadratic layer

One structure, instantiated three times in §3. Its universal property (`hom_ext`) is what makes
every compatibility fact below two generator checks rather than an eight-coordinate computation. -/

/-- `R[θ]` with `θ² = b·θ + c`: the element `re + im·θ`. -/
@[ext] structure Quad (b c : ℤ) (R : Type*) where
  /-- The `θ`-free component. -/
  re : R
  /-- The coefficient of `θ`. -/
  im : R
deriving DecidableEq

namespace Quad

variable {b c : ℤ} {R : Type*} [CommRing R]

/-- Additive identity. -/
def zero : Quad b c R := ⟨0, 0⟩
/-- Multiplicative identity. -/
def one : Quad b c R := ⟨1, 0⟩
/-- Componentwise addition. -/
def add (x y : Quad b c R) : Quad b c R := ⟨x.re + y.re, x.im + y.im⟩
/-- Componentwise negation. -/
def neg (x : Quad b c R) : Quad b c R := ⟨-x.re, -x.im⟩
/-- Componentwise subtraction. -/
def sub (x y : Quad b c R) : Quad b c R := ⟨x.re - y.re, x.im - y.im⟩
/-- `ℕ` in the `θ`-free part. -/
def natCast (n : ℕ) : Quad b c R := ⟨(n : R), 0⟩
/-- `ℤ` in the `θ`-free part. -/
def intCast (n : ℤ) : Quad b c R := ⟨(n : R), 0⟩
/-- `(p + qθ)(r + sθ) = (pr + c·qs) + (ps + qr + b·qs)θ`. -/
def mul (x y : Quad b c R) : Quad b c R :=
  ⟨x.re * y.re + (c : R) * (x.im * y.im),
    x.re * y.im + x.im * y.re + (b : R) * (x.im * y.im)⟩

/-! ### The ring axioms, stated about the definitions

Proved about the plain `def`s rather than inline, because inside the `CommRing` declaration the
goals are phrased in the notation of the instance being built and `simp` has nothing to unfold —
the `Field/Quadratic.lean` pattern, for the same reason. -/

section Axioms
private theorem add_assoc' (x y z : Quad b c R) : add (add x y) z = add x (add y z) := by
  ext <;> simp [add] <;> ring
private theorem zero_add' (x : Quad b c R) : add zero x = x := by ext <;> simp [add, zero]
private theorem add_zero' (x : Quad b c R) : add x zero = x := by ext <;> simp [add, zero]
private theorem add_comm' (x y : Quad b c R) : add x y = add y x := by ext <;> simp [add] <;> ring
private theorem neg_add_cancel' (x : Quad b c R) : add (neg x) x = zero := by
  ext <;> simp [add, neg, zero]
private theorem sub_eq_add_neg' (x y : Quad b c R) : sub x y = add x (neg y) := by
  ext <;> simp [sub, add, neg] <;> ring
private theorem natCast_zero' : (natCast 0 : Quad b c R) = zero := by ext <;> simp [natCast, zero]
private theorem natCast_succ' (n : ℕ) :
    (natCast (n + 1) : Quad b c R) = add (natCast n) one := by ext <;> simp [natCast, add, one]
private theorem intCast_ofNat' (n : ℕ) : (intCast n : Quad b c R) = natCast n := by
  ext <;> simp [intCast, natCast]
private theorem intCast_negSucc' (n : ℕ) :
    (intCast (Int.negSucc n) : Quad b c R) = neg (natCast (n + 1)) := by
  ext <;> simp [intCast, natCast, neg]
private theorem left_distrib' (x y z : Quad b c R) : mul x (add y z) = add (mul x y) (mul x z) := by
  ext <;> simp [mul, add] <;> ring
private theorem right_distrib' (x y z : Quad b c R) :
    mul (add x y) z = add (mul x z) (mul y z) := by
  ext <;> simp [mul, add] <;> ring
private theorem zero_mul' (x : Quad b c R) : mul zero x = zero := by ext <;> simp [mul, zero]
private theorem mul_zero' (x : Quad b c R) : mul x zero = zero := by ext <;> simp [mul, zero]
private theorem mul_assoc' (x y z : Quad b c R) : mul (mul x y) z = mul x (mul y z) := by
  ext <;> simp [mul] <;> ring
private theorem one_mul' (x : Quad b c R) : mul one x = x := by ext <;> simp [mul, one]
private theorem mul_one' (x : Quad b c R) : mul x one = x := by ext <;> simp [mul, one]
private theorem mul_comm' (x y : Quad b c R) : mul x y = mul y x := by ext <;> simp [mul] <;> ring
end Axioms

instance commRing : CommRing (Quad b c R) where
  zero := zero
  one := one
  add := add
  mul := mul
  neg := neg
  sub := sub
  natCast := natCast
  intCast := intCast
  nsmul := @nsmulRec (Quad b c R) ⟨zero⟩ ⟨add⟩
  zsmul := @zsmulRec (Quad b c R) ⟨zero⟩ ⟨add⟩ ⟨neg⟩ (@nsmulRec (Quad b c R) ⟨zero⟩ ⟨add⟩)
  npow := @npowRec (Quad b c R) ⟨one⟩ ⟨mul⟩
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

@[simp] theorem add_re (x y : Quad b c R) : (x + y).re = x.re + y.re := rfl
@[simp] theorem add_im (x y : Quad b c R) : (x + y).im = x.im + y.im := rfl
@[simp] theorem neg_re (x : Quad b c R) : (-x).re = -x.re := rfl
@[simp] theorem neg_im (x : Quad b c R) : (-x).im = -x.im := rfl
@[simp] theorem sub_re (x y : Quad b c R) : (x - y).re = x.re - y.re := rfl
@[simp] theorem sub_im (x y : Quad b c R) : (x - y).im = x.im - y.im := rfl
@[simp] theorem zero_re : (0 : Quad b c R).re = 0 := rfl
@[simp] theorem zero_im : (0 : Quad b c R).im = 0 := rfl
@[simp] theorem one_re : (1 : Quad b c R).re = 1 := rfl
@[simp] theorem one_im : (1 : Quad b c R).im = 0 := rfl
@[simp] theorem natCast_re (n : ℕ) : ((n : Quad b c R)).re = (n : R) := rfl
@[simp] theorem natCast_im (n : ℕ) : ((n : Quad b c R)).im = 0 := rfl
@[simp] theorem intCast_re (n : ℤ) : ((n : Quad b c R)).re = (n : R) := rfl
@[simp] theorem intCast_im (n : ℤ) : ((n : Quad b c R)).im = 0 := rfl
theorem mul_re (x y : Quad b c R) : (x * y).re = x.re * y.re + (c : R) * (x.im * y.im) := rfl
theorem mul_im (x y : Quad b c R) :
    (x * y).im = x.re * y.im + x.im * y.re + (b : R) * (x.im * y.im) := rfl

/-! ### The universal property -/

/-- The base ring sits inside the layer. -/
def incl : R →+* Quad b c R where
  toFun r := ⟨r, 0⟩
  map_one' := rfl
  map_mul' := by intro x y; ext <;> simp [mul_re, mul_im]
  map_zero' := rfl
  map_add' := by intro x y; ext <;> simp

/-- The adjoined root. -/
def theta : Quad b c R := ⟨0, 1⟩

@[simp] theorem incl_apply (r : R) : (incl r : Quad b c R) = ⟨r, 0⟩ := rfl
@[simp] theorem theta_re : (theta : Quad b c R).re = 0 := rfl
@[simp] theorem theta_im : (theta : Quad b c R).im = 1 := rfl

theorem theta_sq : (theta : Quad b c R) * theta = (b : Quad b c R) * theta + (c : Quad b c R) := by
  ext <;> simp [mul_re, mul_im]

/-- Every element is `re + im·θ` — the decomposition `hom_ext` runs on. -/
theorem decomp (x : Quad b c R) : x = incl x.re + incl x.im * theta := by
  ext <;> simp [mul_re, mul_im]

/-- **Two ring homomorphisms out of the layer agree as soon as they agree on the base and on `θ`.**
The recursor every compatibility lemma of §3 lives inside. -/
theorem hom_ext {S : Type*} [CommRing S] {f g : Quad b c R →+* S}
    (hbase : f.comp incl = g.comp incl) (hθ : f theta = g theta) : f = g := by
  ext x
  rw [decomp x, map_add, map_add, map_mul, map_mul, hθ]
  have hre : f (incl x.re) = g (incl x.re) := congrArg (fun h : R →+* S => h x.re) hbase
  have him : f (incl x.im) = g (incl x.im) := congrArg (fun h : R →+* S => h x.im) hbase
  rw [hre, him]

/-- A ring homomorphism out of the base, plus a root of `X² − bX − c` in the target, extends. -/
def lift {S : Type*} [CommRing S] (f : R →+* S) (t : S) (ht : t * t = (b : S) * t + (c : S)) :
    Quad b c R →+* S where
  toFun x := f x.re + f x.im * t
  map_one' := by simp
  map_mul' := by
    intro x y
    simp only [mul_re, mul_im, map_add, map_mul, map_intCast]
    linear_combination (-(f x.im * f y.im)) * ht
  map_zero' := by simp
  map_add' := by intro x y; simp; ring

@[simp] theorem lift_apply {S : Type*} [CommRing S] (f : R →+* S) (t : S)
    (ht : t * t = (b : S) * t + (c : S)) (x : Quad b c R) :
    lift f t ht x = f x.re + f x.im * t := rfl

theorem lift_theta {S : Type*} [CommRing S] (f : R →+* S) (t : S)
    (ht : t * t = (b : S) * t + (c : S)) : lift f t ht theta = t := by simp

@[simp] theorem lift_comp_incl {S : Type*} [CommRing S] (f : R →+* S) (t : S)
    (ht : t * t = (b : S) * t + (c : S)) : (lift f t ht).comp incl = f := by
  ext r; simp

theorem lift_incl {S : Type*} [CommRing S] (f : R →+* S) (t : S)
    (ht : t * t = (b : S) * t + (c : S)) (r : R) : lift f t ht (incl r) = f r := by simp

/-- The nontrivial involution: `θ ↦ b − θ`, with the base conjugated by `g`. -/
def conjSwap (g : R →+* R) : Quad b c R →+* Quad b c R where
  toFun x := ⟨g x.re + (b : R) * g x.im, -g x.im⟩
  map_one' := by ext <;> simp
  map_mul' := by intro x y; ext <;> simp [mul_re, mul_im] <;> ring
  map_zero' := by ext <;> simp
  map_add' := by intro x y; ext <;> simp <;> ring

/-- The involution that fixes `θ` and conjugates the base by `g`. -/
def conjBase (g : R →+* R) : Quad b c R →+* Quad b c R where
  toFun x := ⟨g x.re, g x.im⟩
  map_one' := by ext <;> simp
  map_mul' := by intro x y; ext <;> simp [mul_re, mul_im]
  map_zero' := by ext <;> simp
  map_add' := by intro x y; ext <;> simp

@[simp] theorem conjSwap_apply (g : R →+* R) (x : Quad b c R) :
    conjSwap g x = ⟨g x.re + (b : R) * g x.im, -g x.im⟩ := rfl
@[simp] theorem conjBase_apply (g : R →+* R) (x : Quad b c R) :
    conjBase g x = ⟨g x.re, g x.im⟩ := rfl

theorem conjSwap_incl (g : R →+* R) (r : R) :
    conjSwap (b := b) (c := c) g (incl r) = incl (g r) := by ext <;> simp
theorem conjBase_incl (g : R →+* R) (r : R) :
    conjBase (b := b) (c := c) g (incl r) = incl (g r) := by ext <;> simp

@[simp] theorem conjSwap_comp_incl (g : R →+* R) :
    (conjSwap (b := b) (c := c) g).comp incl = incl.comp g := by
  ext r <;> simp [RingHom.comp_apply]
@[simp] theorem conjBase_comp_incl (g : R →+* R) :
    (conjBase (b := b) (c := c) g).comp incl = incl.comp g := by
  ext r <;> simp [RingHom.comp_apply]
theorem conjSwap_theta (g : R →+* R) :
    conjSwap (b := b) (c := c) g theta = (b : Quad b c R) - theta := by ext <;> simp
theorem conjBase_theta (g : R →+* R) :
    conjBase (b := b) (c := c) g theta = theta := by ext <;> simp

end Quad

/-! ## §3 The order `O = ℤ[ω, i, T]`

`ω = ζ₃`, `T = (1+√33)/2`; the basis is `{1, ω} × {1, i} × {1, T}` and the order is maximal at `2`
— which is what `T` buys. Dropping it (working in `ℤ[ζ₁₂, √33]`) breaks the descent of §5: the
Moser twist `ρ = (5 + i√11)/6` is `(7 − ω + T + 2ωT)/9` and needs `T` to have integer
coordinates. -/

/-- `ℤ[ω]`, `ω = ζ₃`, `ω² = −ω − 1`. -/
abbrev Eis := Quad (-1) (-1) ℤ
/-- `ℤ[ω, T]`, `T = (1+√33)/2`, `T² = T + 8`. -/
abbrev EisT := Quad 1 8 Eis
/-- `O = ℤ[ω, i, T]`, `i² = −1` — the order this file colours by. -/
abbrev SeamOrder := Quad 0 (-1) EisT

/-- `ω = ζ₃ = (−1 + i√3)/2`. -/
noncomputable def omega3 : ℂ := ⟨-1/2, Real.sqrt 3 / 2⟩
/-- `T = (1 + √33)/2`. -/
noncomputable def tau : ℂ := ⟨(1 + Real.sqrt 33) / 2, 0⟩

private theorem sq_sqrt3 : Real.sqrt 3 * Real.sqrt 3 = 3 :=
  Real.mul_self_sqrt (by norm_num)
private theorem sq_sqrt33 : Real.sqrt 33 * Real.sqrt 33 = 33 :=
  Real.mul_self_sqrt (by norm_num)

theorem omega3_sq : omega3 * omega3 = ((-1 : ℤ) : ℂ) * omega3 + ((-1 : ℤ) : ℂ) := by
  apply Complex.ext <;>
    simp [omega3, Complex.mul_re, Complex.mul_im] <;> nlinarith [sq_sqrt3]

theorem tau_sq : tau * tau = ((1 : ℤ) : ℂ) * tau + ((8 : ℤ) : ℂ) := by
  apply Complex.ext <;> simp [tau, Complex.mul_re, Complex.mul_im]
  nlinarith [sq_sqrt33]

theorem I_sq : Complex.I * Complex.I = ((0 : ℤ) : ℂ) * Complex.I + ((-1 : ℤ) : ℂ) := by
  simp [Complex.I_mul_I]

/-- `ℤ[ω] → ℂ`. -/
noncomputable def denE : Eis →+* ℂ := Quad.lift (Int.castRingHom ℂ) omega3 omega3_sq
/-- `ℤ[ω, T] → ℂ`. -/
noncomputable def denET : EisT →+* ℂ := Quad.lift denE tau tau_sq
/-- `O → ℂ` — the drawing of the order in the plane. -/
noncomputable def den : SeamOrder →+* ℂ := Quad.lift denET Complex.I I_sq

@[simp] theorem denE_apply (x : Eis) : denE x = (x.re : ℂ) + (x.im : ℂ) * omega3 := rfl
@[simp] theorem denET_apply (x : EisT) : denET x = denE x.re + denE x.im * tau := rfl
@[simp] theorem den_apply (x : SeamOrder) : den x = denET x.re + denET x.im * Complex.I := rfl

/-- Complex conjugation on `ℤ[ω]`: `ω ↦ −1 − ω`. -/
def conjE : Eis →+* Eis := Quad.conjSwap (RingHom.id ℤ)
/-- Complex conjugation on `ℤ[ω, T]`: `T` is real. -/
def conjET : EisT →+* EisT := Quad.conjBase conjE
/-- Complex conjugation on `O`: `i ↦ −i`. -/
def conj : SeamOrder →+* SeamOrder := Quad.conjSwap conjET

private theorem denE_conj (x : Eis) : denE (conjE x) = (starRingEnd ℂ) (denE x) := by
  have : denE.comp conjE = (starRingEnd ℂ).comp denE := by
    refine Quad.hom_ext (RingHom.ext_int _ _) ?_
    show denE (conjE Quad.theta) = (starRingEnd ℂ) (denE Quad.theta)
    rw [conjE, Quad.conjSwap_theta]
    apply Complex.ext <;> simp [omega3]
    ring
  exact congrArg (fun h : Eis →+* ℂ => h x) this

private theorem denET_conj (x : EisT) : denET (conjET x) = (starRingEnd ℂ) (denET x) := by
  have : denET.comp conjET = (starRingEnd ℂ).comp denET := by
    refine Quad.hom_ext (RingHom.ext fun p => ?_) ?_
    · show denET (conjET (Quad.incl p)) = (starRingEnd ℂ) (denET (Quad.incl p))
      simp only [conjET, Quad.conjBase_incl, denET, Quad.lift_incl]
      exact denE_conj p
    · show denET (conjET Quad.theta) = (starRingEnd ℂ) (denET Quad.theta)
      rw [conjET, Quad.conjBase_theta]
      apply Complex.ext <;> simp [tau]
  exact congrArg (fun h : EisT →+* ℂ => h x) this

/-- **The drawing intertwines the order's conjugation with the plane's.** -/
theorem den_conj (x : SeamOrder) : den (conj x) = (starRingEnd ℂ) (den x) := by
  have : den.comp conj = (starRingEnd ℂ).comp den := by
    refine Quad.hom_ext (RingHom.ext fun p => ?_) ?_
    · show den (conj (Quad.incl p)) = (starRingEnd ℂ) (den (Quad.incl p))
      simp only [conj, Quad.conjSwap_incl, den, Quad.lift_incl]
      exact denET_conj p
    · show den (conj Quad.theta) = (starRingEnd ℂ) (den Quad.theta)
      rw [conj, Quad.conjSwap_theta]
      simp [den]
  exact congrArg (fun h : SeamOrder →+* ℂ => h x) this

/-- `ω` inside the order. -/
def ordOmega : SeamOrder := Quad.incl (Quad.incl Quad.theta)
/-- `T` inside the order. -/
def ordTau : SeamOrder := Quad.incl Quad.theta
/-- `i` inside the order. -/
def ordI : SeamOrder := Quad.theta

theorem den_ordOmega : den ordOmega = omega3 := by simp [ordOmega, den, denET, denE]
theorem den_ordTau : den ordTau = tau := by simp [ordTau, den, denET]
theorem den_ordI : den ordI = Complex.I := by simp [ordI, den]

/-! ### The two residue maps

`ψ` sends `ω ↦ Ω`, `i ↦ 1` and `T ↦ s` for either idempotent `s ∈ {0, 1}` of `𝔽₄`. The two choices
are the two primes above `2`; their joint kernel is `(1+i)·O` (§5), and each alone is a proper
4-colouring of the order. -/

theorem om_rel : F4.om * F4.om = ((-1 : ℤ) : F4) * F4.om + ((-1 : ℤ) : F4) := by decide

/-- `ℤ[ω] → 𝔽₄`, `ω ↦ Ω`. -/
def psiE : Eis →+* F4 := Quad.lift (Int.castRingHom F4) F4.om om_rel

theorem one_rel : (1 : F4) * 1 = ((0 : ℤ) : F4) * 1 + ((-1 : ℤ) : F4) := by decide

/-- The residue map of the order at one of the two primes above `2`. -/
def psi (s : F4) (hs : s * s = ((1 : ℤ) : F4) * s + ((8 : ℤ) : F4)) : SeamOrder →+* F4 :=
  Quad.lift (Quad.lift psiE s hs) 1 one_rel

theorem hs_zero : (0 : F4) * 0 = ((1 : ℤ) : F4) * 0 + ((8 : ℤ) : F4) := by decide
theorem hs_one : (1 : F4) * 1 = ((1 : ℤ) : F4) * 1 + ((8 : ℤ) : F4) := by decide

/-- The residue map at the prime with `T ↦ 0` — the one that colours. -/
def psiZero : SeamOrder →+* F4 := psi 0 hs_zero
/-- The residue map at the other prime, `T ↦ 1`. -/
def psiOne : SeamOrder →+* F4 := psi 1 hs_one

@[simp] theorem psiE_apply (x : Eis) : psiE x = ((x.re : ℤ) : F4) + ((x.im : ℤ) : F4) * F4.om :=
  rfl

theorem psi_apply (s : F4) (hs : s * s = ((1 : ℤ) : F4) * s + ((8 : ℤ) : F4)) (x : SeamOrder) :
    psi s hs x = (psiE x.re.re + psiE x.re.im * s) + (psiE x.im.re + psiE x.im.im * s) := by
  simp [psi]

private theorem psiE_comp_conjE : psiE.comp conjE = F4.sq.comp psiE := by
  refine Quad.hom_ext (RingHom.ext_int _ _) ?_
  show psiE (conjE Quad.theta) = F4.sq (psiE Quad.theta)
  rw [conjE, Quad.conjSwap_theta]
  simp only [map_sub, map_intCast, Quad.lift_theta, psiE, F4.sq_apply]
  decide

private theorem psiE_conj (x : Eis) : psiE (conjE x) = psiE x * psiE x :=
  congrArg (fun h : Eis →+* F4 => h x) psiE_comp_conjE

/-- **Conjugation induces Frobenius on the residue field** — the content of "complex conjugation
fixes each prime above `2`", as one equality of ring homomorphisms. -/
theorem psi_comp_conj (s : F4) (hs : s * s = ((1 : ℤ) : F4) * s + ((8 : ℤ) : F4))
    (hss : s * s = s) : (psi s hs).comp conj = F4.sq.comp (psi s hs) := by
  have hET : ∀ p : EisT,
      (Quad.lift psiE s hs) (conjET p) = F4.sq ((Quad.lift psiE s hs) p) := by
    have h : (Quad.lift psiE s hs).comp conjET = F4.sq.comp (Quad.lift psiE s hs) := by
      refine Quad.hom_ext (RingHom.ext fun q => ?_) ?_
      · show (Quad.lift psiE s hs) (conjET (Quad.incl q)) = F4.sq ((Quad.lift psiE s hs) _)
        simp only [conjET, Quad.conjBase_incl, Quad.lift_incl]
        exact psiE_conj q
      · show (Quad.lift psiE s hs) (conjET Quad.theta) = F4.sq ((Quad.lift psiE s hs) Quad.theta)
        rw [conjET, Quad.conjBase_theta, Quad.lift_theta, F4.sq_apply, hss]
    exact fun p => congrArg (fun h : EisT →+* F4 => h p) h
  refine Quad.hom_ext (RingHom.ext fun p => ?_) ?_
  · show (psi s hs) (conj (Quad.incl p)) = F4.sq ((psi s hs) (Quad.incl p))
    simp only [conj, Quad.conjSwap_incl, psi, Quad.lift_incl]
    exact hET p
  · show (psi s hs) (conj Quad.theta) = F4.sq ((psi s hs) Quad.theta)
    rw [conj, Quad.conjSwap_theta]
    simp only [map_sub, map_intCast, psi, Quad.lift_theta, F4.sq_apply]
    decide

theorem psiZero_conj (x : SeamOrder) : psiZero (conj x) = psiZero x * psiZero x :=
  congrArg (fun h : SeamOrder →+* F4 => h x) (psi_comp_conj 0 hs_zero (by decide))

theorem psiOne_conj (x : SeamOrder) : psiOne (conj x) = psiOne x * psiOne x :=
  congrArg (fun h : SeamOrder →+* F4 => h x) (psi_comp_conj 1 hs_one (by decide))

/-! ## §4 `den` is injective

The eight monomials `{1, ω} × {1, i} × {1, T}` are ℚ-independent, so an element of the order is
determined by its image in the plane. Two consumers: the well-definedness of the residue on `A`
(§7) and the norm equations of §5. The same two coordinate formulas give `den x ∈ K²` in §6. -/

private theorem sqrt3_mul_sqrt33 : Real.sqrt 3 * Real.sqrt 33 = 3 * Real.sqrt 11 := by
  rw [← Real.sqrt_mul (by norm_num), show (3:ℝ) * 33 = 9 * 11 by norm_num,
    Real.sqrt_mul (by norm_num), show (9:ℝ) = 3 ^ 2 by norm_num,
    Real.sqrt_sq (by norm_num)]

/-- The real part of a drawn order element, in the basis `1, √3, √11, √33` of `K`. -/
theorem den_re (a b e f c d g h : ℤ) :
    (den ⟨⟨⟨a, b⟩, ⟨e, f⟩⟩, ⟨⟨c, d⟩, ⟨g, h⟩⟩⟩).re
      = ((a - b/2 + e/2 - f/4 : ℚ) : ℝ) + ((-d/2 - h/4 : ℚ) : ℝ) * Real.sqrt 3
        + ((-3*h/4 : ℚ) : ℝ) * Real.sqrt 11 + ((e/2 - f/4 : ℚ) : ℝ) * Real.sqrt 33 := by
  simp only [den_apply, denET_apply, denE_apply, omega3, tau, Complex.add_re, Complex.mul_re,
    Complex.add_im, Complex.mul_im, Complex.I_re, Complex.I_im, Complex.intCast_re,
    Complex.intCast_im]
  push_cast
  linear_combination (-(h : ℝ)/4) * sqrt3_mul_sqrt33

/-- The imaginary part of a drawn order element, in the same basis. -/
theorem den_im (a b e f c d g h : ℤ) :
    (den ⟨⟨⟨a, b⟩, ⟨e, f⟩⟩, ⟨⟨c, d⟩, ⟨g, h⟩⟩⟩).im
      = ((c - d/2 + g/2 - h/4 : ℚ) : ℝ) + ((b/2 + f/4 : ℚ) : ℝ) * Real.sqrt 3
        + ((3*f/4 : ℚ) : ℝ) * Real.sqrt 11 + ((g/2 - h/4 : ℚ) : ℝ) * Real.sqrt 33 := by
  simp only [den_apply, denET_apply, denE_apply, omega3, tau, Complex.add_re, Complex.mul_re,
    Complex.add_im, Complex.mul_im, Complex.I_re, Complex.I_im, Complex.intCast_re,
    Complex.intCast_im]
  push_cast
  linear_combination ((f : ℝ)/4) * sqrt3_mul_sqrt33

theorem den_injective : Function.Injective den := by
  refine (injective_iff_map_eq_zero den).mpr ?_
  rintro ⟨⟨⟨a, b⟩, ⟨e, f⟩⟩, ⟨⟨c, d⟩, ⟨g, h⟩⟩⟩ hx
  have hre : ((a - b/2 + e/2 - f/4 : ℚ) : ℝ) + ((-d/2 - h/4 : ℚ) : ℝ) * Real.sqrt 3
      + ((-3*h/4 : ℚ) : ℝ) * Real.sqrt 11 + ((e/2 - f/4 : ℚ) : ℝ) * Real.sqrt 33 = 0 := by
    rw [← den_re]; rw [hx]; rfl
  have him : ((c - d/2 + g/2 - h/4 : ℚ) : ℝ) + ((b/2 + f/4 : ℚ) : ℝ) * Real.sqrt 3
      + ((3*f/4 : ℚ) : ℝ) * Real.sqrt 11 + ((g/2 - h/4 : ℚ) : ℝ) * Real.sqrt 33 = 0 := by
    rw [← den_im]; rw [hx]; rfl
  obtain ⟨r1, r3, r11, r33⟩ := Ladder.sqrt_indep hre
  obtain ⟨i1, i3, i11, i33⟩ := Ladder.sqrt_indep him
  have hh : h = 0 := by exact_mod_cast (by linarith : ((h : ℚ)) = 0)
  have hf : f = 0 := by exact_mod_cast (by linarith : ((f : ℚ)) = 0)
  subst hh; subst hf
  have hd : d = 0 := by exact_mod_cast (by linarith : ((d : ℚ)) = 0)
  have hb : b = 0 := by exact_mod_cast (by linarith : ((b : ℚ)) = 0)
  have he : e = 0 := by exact_mod_cast (by linarith : ((e : ℚ)) = 0)
  have hg : g = 0 := by exact_mod_cast (by linarith : ((g : ℚ)) = 0)
  subst hd; subst hb; subst he; subst hg
  have ha : a = 0 := by exact_mod_cast (by linarith : ((a : ℚ)) = 0)
  have hc : c = 0 := by exact_mod_cast (by linarith : ((c : ℚ)) = 0)
  subst ha; subst hc
  rfl

/-! ## §5 The descent

The joint kernel of the two residue maps is `(1 + i)·O`, and seeing it costs no ideal theory:
writing `z = p + q·i`, the two conditions say exactly that `p` and `q` agree modulo `2` in all four
coordinates, and then `z/(1+i) = (p+q)/2 + ((q−p)/2)·i` has integer coordinates. -/

/-- `1 + i` in the order. -/
def onePlusI : SeamOrder := 1 + Quad.theta

theorem den_onePlusI : den onePlusI = 1 + Complex.I := by
  simp [onePlusI, den]

/-- The order has no `2`-torsion — one line, through the drawing. -/
theorem two_mul_cancel {a b : SeamOrder} (h : (2 : SeamOrder) * a = 2 * b) : a = b := by
  refine den_injective ?_
  have h' := congrArg den h
  simp only [map_mul, map_ofNat] at h'
  exact mul_left_cancel₀ (by norm_num : (2 : ℂ) ≠ 0) h'

private theorem psiZero_apply (x : SeamOrder) : psiZero x = psiE x.re.re + psiE x.im.re := by
  simp [psiZero, psi_apply]

private theorem psiOne_apply (x : SeamOrder) :
    psiOne x = psiE x.re.re + psiE x.re.im + (psiE x.im.re + psiE x.im.im) := by
  simp [psiOne, psi_apply]

private theorem two_dvd_add {m n : ℤ} (h : ((m : ZMod 2)) = (n : ZMod 2)) : (2 : ℤ) ∣ m + n := by
  refine (ZMod.intCast_zmod_eq_zero_iff_dvd _ 2).mp ?_
  push_cast
  rw [h, show ((n : ZMod 2)) + (n : ZMod 2) = 2 * (n : ZMod 2) by ring,
    show ((2 : ZMod 2)) = 0 from rfl, zero_mul]

private theorem exists_half_eis {p q : Eis} (h : psiE p = psiE q) : ∃ a : Eis, p + q = a + a := by
  have hu : ((p.re : ZMod 2)) = (q.re : ZMod 2) := by
    have := congrArg F4.u h; simpa [F4.mul_u] using this
  have hv : ((p.im : ZMod 2)) = (q.im : ZMod 2) := by
    have := congrArg F4.v h; simpa [F4.mul_v] using this
  obtain ⟨k, hk⟩ := two_dvd_add hu
  obtain ⟨l, hl⟩ := two_dvd_add hv
  exact ⟨⟨k, l⟩, Quad.ext (by simpa using by omega) (by simpa using by omega)⟩

private theorem exists_half_eisT {p q : EisT} (h0 : psiE p.re = psiE q.re)
    (h1 : psiE p.im = psiE q.im) : ∃ A : EisT, p + q = A + A := by
  obtain ⟨a, ha⟩ := exists_half_eis h0
  obtain ⟨b, hb⟩ := exists_half_eis h1
  exact ⟨⟨a, b⟩, Quad.ext ha hb⟩

/-- **The descent.** An element of the order killed by both residue maps is divisible by `1 + i`. -/
theorem exists_mul_onePlusI {z : SeamOrder} (h0 : psiZero z = 0) (h1 : psiOne z = 0) :
    ∃ w : SeamOrder, w * onePlusI = z := by
  rw [psiZero_apply] at h0
  rw [psiOne_apply] at h1
  have e1 : psiE z.re.re = psiE z.im.re := F4.eq_of_add_eq_zero h0
  have e2 : psiE z.re.im = psiE z.im.im := by
    refine F4.eq_of_add_eq_zero ?_
    linear_combination h1 - h0
  obtain ⟨A, hA⟩ := exists_half_eisT e1 e2
  refine ⟨⟨A, A - z.re⟩, Quad.ext ?_ ?_⟩
  · show A * 1 + ((-1 : ℤ) : EisT) * ((A - z.re) * 1) = z.re
    push_cast; ring
  · show A * 1 + (A - z.re) * 1 + ((0 : ℤ) : EisT) * ((A - z.re) * 1) = z.im
    push_cast; linear_combination -hA

/-- A residue map compatible with conjugation kills any element of even norm. -/
theorem eq_zero_of_even_norm {f : SeamOrder →+* F4} (hf : ∀ x, f (conj x) = f x * f x)
    {z : SeamOrder} {N : ℤ} (hN : Even N) (h : z * conj z = (N : SeamOrder)) : f z = 0 := by
  refine F4.eq_zero_of_cube_eq_zero ?_
  have : f z * f (conj z) = ((N : ℤ) : F4) := by rw [← map_mul, h, map_intCast]
  rw [hf z] at this
  rw [this, F4.intCast_even hN]

/-! ## §6 The seam field and its plane

`K = ℚ(√3, √11)` is the ℚ-span of `1, √3, √11, √33`. The span is the primitive — it is what the
proof clears denominators against — and the `Subfield` structure sits beside it, so a reader sees a
field where the argument uses only an additive group. -/

/-- The ℚ-span of `1, √3, √11, √33`. -/
def seamSpan : Set ℝ :=
  {x | ∃ a b c d : ℚ, x = a + b * Real.sqrt 3 + c * Real.sqrt 11 + d * Real.sqrt 33}

private theorem sq_sqrt11 : Real.sqrt 11 * Real.sqrt 11 = 11 := Real.mul_self_sqrt (by norm_num)

private theorem sqrt3_mul_sqrt11 : Real.sqrt 3 * Real.sqrt 11 = Real.sqrt 33 := by
  rw [← Real.sqrt_mul (by norm_num)]; norm_num

private theorem sqrt11_mul_sqrt33 : Real.sqrt 11 * Real.sqrt 33 = 11 * Real.sqrt 3 := by
  rw [← Real.sqrt_mul (by norm_num), show (11:ℝ) * 33 = 11 ^ 2 * 3 by norm_num,
    Real.sqrt_mul (by positivity), Real.sqrt_sq (by norm_num)]

private theorem mem_seamSpan_add {x y : ℝ} (hx : x ∈ seamSpan) (hy : y ∈ seamSpan) :
    x + y ∈ seamSpan := by
  obtain ⟨a, b, c, d, rfl⟩ := hx
  obtain ⟨a', b', c', d', rfl⟩ := hy
  exact ⟨a + a', b + b', c + c', d + d', by push_cast; ring⟩

private theorem mem_seamSpan_neg {x : ℝ} (hx : x ∈ seamSpan) : -x ∈ seamSpan := by
  obtain ⟨a, b, c, d, rfl⟩ := hx
  exact ⟨-a, -b, -c, -d, by push_cast; ring⟩

private theorem mem_seamSpan_mul {x y : ℝ} (hx : x ∈ seamSpan) (hy : y ∈ seamSpan) :
    x * y ∈ seamSpan := by
  obtain ⟨a, b, c, d, rfl⟩ := hx
  obtain ⟨a', b', c', d', rfl⟩ := hy
  refine ⟨a*a' + 3*(b*b') + 11*(c*c') + 33*(d*d'), a*b' + b*a' + 11*(c*d' + d*c'),
    a*c' + c*a' + 3*(b*d' + d*b'), a*d' + d*a' + b*c' + c*b', ?_⟩
  push_cast
  linear_combination ((b:ℝ)*b') * sq_sqrt3 + ((c:ℝ)*c') * sq_sqrt11 + ((d:ℝ)*d') * sq_sqrt33
    + ((b:ℝ)*c' + (c:ℝ)*b') * sqrt3_mul_sqrt11 + ((b:ℝ)*d' + (d:ℝ)*b') * sqrt3_mul_sqrt33
    + ((c:ℝ)*d' + (d:ℝ)*c') * sqrt11_mul_sqrt33

private theorem mem_seamSpan_ratCast (q : ℚ) : (q : ℝ) ∈ seamSpan :=
  ⟨q, 0, 0, 0, by push_cast; ring⟩

/-- The four sign-conjugates of a span element: `x`, and the images under `√3 ↦ −√3`,
`√11 ↦ −√11`. Their product is rational, which is what makes the span closed under inverse. -/
private theorem mem_seamSpan_inv {x : ℝ} (hx : x ∈ seamSpan) : x⁻¹ ∈ seamSpan := by
  rcases eq_or_ne x 0 with rfl | hx0
  · simpa using mem_seamSpan_ratCast 0
  obtain ⟨a, b, c, d, rfl⟩ := hx
  set s3 := Real.sqrt 3 with hs3
  set s11 := Real.sqrt 11 with hs11
  set s33 := Real.sqrt 33 with hs33
  -- the coefficient tuple is nonzero
  have hcoeff : ¬ (a = 0 ∧ b = 0 ∧ c = 0 ∧ d = 0) := by
    rintro ⟨rfl, rfl, rfl, rfl⟩; exact hx0 (by push_cast; ring)
  have hzero : ∀ p q r t : ℚ, ((p : ℝ) + q * s3 + r * s11 + t * s33 = 0) →
      (p = 0 ∧ q = 0 ∧ r = 0 ∧ t = 0) := fun p q r t h => Ladder.sqrt_indep h
  set x1 : ℝ := (a : ℝ) - b * s3 - c * s11 + d * s33 with hx1def
  set x2 : ℝ := (a : ℝ) + b * s3 - c * s11 - d * s33 with hx2def
  set x3 : ℝ := (a : ℝ) - b * s3 + c * s11 - d * s33 with hx3def
  set P : ℚ := a^2 + 33*d^2 - 3*b^2 - 11*c^2 with hP
  set Q : ℚ := 2*a*d - 2*b*c with hQ
  set N : ℚ := P^2 - 33*Q^2 with hN
  have h1 : ((a : ℝ) + b * s3 + c * s11 + d * s33) * x1 = (P : ℝ) + Q * s33 := by
    rw [hx1def, hP, hQ]; push_cast
    linear_combination (-(b:ℝ)^2) * sq_sqrt3 + (-(c:ℝ)^2) * sq_sqrt11 + ((d:ℝ)^2) * sq_sqrt33
      + (-2*(b:ℝ)*c) * sqrt3_mul_sqrt11
  have h2 : x2 * x3 = (P : ℝ) - Q * s33 := by
    rw [hx2def, hx3def, hP, hQ]; push_cast
    linear_combination (-(b:ℝ)^2) * sq_sqrt3 + (-(c:ℝ)^2) * sq_sqrt11 + ((d:ℝ)^2) * sq_sqrt33
      + (2*(b:ℝ)*c) * sqrt3_mul_sqrt11
  have hprod : ((a : ℝ) + b * s3 + c * s11 + d * s33) * (x1 * (x2 * x3)) = (N : ℝ) := by
    rw [hN]; push_cast
    calc ((a : ℝ) + b * s3 + c * s11 + d * s33) * (x1 * (x2 * x3))
        = (((a : ℝ) + b * s3 + c * s11 + d * s33) * x1) * (x2 * x3) := by ring
      _ = ((P : ℝ) + Q * s33) * ((P : ℝ) - Q * s33) := by rw [h1, h2]
      _ = (P : ℝ)^2 - 33 * (Q : ℝ)^2 := by
            linear_combination (-(Q:ℝ)^2) * sq_sqrt33
  have hx1 : x1 ≠ 0 := by
    intro h
    have := hzero a (-b) (-c) d (by rw [hx1def] at h; push_cast; linarith [h])
    exact hcoeff ⟨this.1, by linarith [this.2.1], by linarith [this.2.2.1], this.2.2.2⟩
  have hx2 : x2 ≠ 0 := by
    intro h
    have := hzero a b (-c) (-d) (by rw [hx2def] at h; push_cast; linarith [h])
    exact hcoeff ⟨this.1, this.2.1, by linarith [this.2.2.1], by linarith [this.2.2.2]⟩
  have hx3 : x3 ≠ 0 := by
    intro h
    have := hzero a (-b) c (-d) (by rw [hx3def] at h; push_cast; linarith [h])
    exact hcoeff ⟨this.1, by linarith [this.2.1], this.2.2.1, by linarith [this.2.2.2]⟩
  have hNne : (N : ℝ) ≠ 0 := by
    rw [← hprod]
    exact mul_ne_zero hx0 (mul_ne_zero hx1 (mul_ne_zero hx2 hx3))
  have hNq : N ≠ 0 := fun h => hNne (by rw [h]; norm_num)
  have hinv : ((a : ℝ) + b * s3 + c * s11 + d * s33)⁻¹ = ((N⁻¹ : ℚ) : ℝ) * (x1 * (x2 * x3)) := by
    refine inv_eq_of_mul_eq_one_right ?_
    rw [show (((N⁻¹ : ℚ)) : ℝ) = ((N : ℝ))⁻¹ by push_cast; ring,
      show ((a : ℝ) + b * s3 + c * s11 + d * s33) * (((N : ℝ))⁻¹ * (x1 * (x2 * x3)))
        = ((N : ℝ))⁻¹ * (((a : ℝ) + b * s3 + c * s11 + d * s33) * (x1 * (x2 * x3))) by ring,
      hprod, inv_mul_cancel₀ hNne]
  rw [hinv]
  refine mem_seamSpan_mul (mem_seamSpan_ratCast _) (mem_seamSpan_mul ?_ (mem_seamSpan_mul ?_ ?_))
  · exact ⟨a, -b, -c, d, by rw [hx1def]; push_cast; ring⟩
  · exact ⟨a, b, -c, -d, by rw [hx2def]; push_cast; ring⟩
  · exact ⟨a, -b, c, -d, by rw [hx3def]; push_cast; ring⟩

/-- `K = ℚ(√3, √11)`, as a subfield of `ℝ`. -/
noncomputable def seamField : Subfield ℝ where
  carrier := seamSpan
  zero_mem' := ⟨0, 0, 0, 0, by norm_num⟩
  one_mem' := ⟨1, 0, 0, 0, by norm_num⟩
  add_mem' := mem_seamSpan_add
  neg_mem' := mem_seamSpan_neg
  mul_mem' := mem_seamSpan_mul
  inv_mem' := fun _ hx => mem_seamSpan_inv hx

@[simp] theorem seamField_carrier : (seamField : Set ℝ) = seamSpan := rfl

/-- `K²`: the complex numbers with both coordinates in `K`. -/
def seamPlane : Set ℂ := {z | z.re ∈ seamSpan ∧ z.im ∈ seamSpan}

theorem mem_seamPlane_iff {z : ℂ} : z ∈ seamPlane ↔ z.re ∈ seamField ∧ z.im ∈ seamField := Iff.rfl

/-- Membership in `K`, spelled out. With this and the three generators below, the whole `Subfield`
API (`add_mem`, `mul_mem`, `inv_mem`, `ratCast_mem`, …) certifies a point of `K²`. -/
theorem mem_seamField_iff {x : ℝ} :
    x ∈ seamField ↔ ∃ a b c d : ℚ, x = a + b * Real.sqrt 3 + c * Real.sqrt 11 + d * Real.sqrt 33 :=
  Iff.rfl

theorem sqrt3_mem : Real.sqrt 3 ∈ seamField := ⟨0, 1, 0, 0, by push_cast; ring⟩
theorem sqrt11_mem : Real.sqrt 11 ∈ seamField := ⟨0, 0, 1, 0, by push_cast; ring⟩
theorem sqrt33_mem : Real.sqrt 33 ∈ seamField := ⟨0, 0, 0, 1, by push_cast; ring⟩

theorem seamPlane_sub {z w : ℂ} (hz : z ∈ seamPlane) (hw : w ∈ seamPlane) :
    z - w ∈ seamPlane :=
  ⟨mem_seamSpan_add hz.1 (mem_seamSpan_neg hw.1), mem_seamSpan_add hz.2 (mem_seamSpan_neg hw.2)⟩

theorem den_mem_seamPlane (x : SeamOrder) : den x ∈ seamPlane := by
  obtain ⟨⟨⟨a, b⟩, ⟨e, f⟩⟩, ⟨⟨c, d⟩, ⟨g, h⟩⟩⟩ := x
  refine ⟨⟨_, _, _, _, den_re a b e f c d g h⟩, ⟨_, _, _, _, den_im a b e f c d g h⟩⟩

theorem seamPlane_ratMul {z : ℂ} (hz : z ∈ seamPlane) (q : ℚ) : (q : ℂ) * z ∈ seamPlane := by
  refine ⟨?_, ?_⟩
  · rw [show ((q : ℂ) * z).re = (q : ℝ) * z.re by simp]
    exact mem_seamSpan_mul (mem_seamSpan_ratCast q) hz.1
  · rw [show ((q : ℂ) * z).im = (q : ℝ) * z.im by simp]
    exact mem_seamSpan_mul (mem_seamSpan_ratCast q) hz.2

/-! ### Clearing denominators -/

/-- The points with *some* nonzero integer multiple in the order. -/
private def Cl : Set ℂ := {z | ∃ n : ℕ, 0 < n ∧ ∃ x : SeamOrder, (n : ℂ) * z = den x}

private theorem Cl_add {z w : ℂ} (hz : z ∈ Cl) (hw : w ∈ Cl) : z + w ∈ Cl := by
  obtain ⟨n, hn, x, hx⟩ := hz
  obtain ⟨m, hm, y, hy⟩ := hw
  refine ⟨n * m, Nat.mul_pos hn hm, (m : SeamOrder) * x + (n : SeamOrder) * y, ?_⟩
  push_cast
  rw [map_add, map_mul, map_mul, map_natCast, map_natCast, ← hx, ← hy]
  ring

private theorem Cl_mul {z w : ℂ} (hz : z ∈ Cl) (hw : w ∈ Cl) : z * w ∈ Cl := by
  obtain ⟨n, hn, x, hx⟩ := hz
  obtain ⟨m, hm, y, hy⟩ := hw
  refine ⟨n * m, Nat.mul_pos hn hm, x * y, ?_⟩
  push_cast
  rw [map_mul, ← hx, ← hy]
  ring

private theorem Cl_ratMul {z : ℂ} (hz : z ∈ Cl) (q : ℚ) : (q : ℂ) * z ∈ Cl := by
  obtain ⟨n, hn, x, hx⟩ := hz
  refine ⟨n * q.den, Nat.mul_pos hn q.pos, (q.num : SeamOrder) * x, ?_⟩
  have hq : (q : ℂ) * (q.den : ℂ) = (q.num : ℂ) := by
    exact_mod_cast congrArg (fun r : ℚ => ((r : ℂ))) (Rat.mul_den_eq_num q)
  push_cast
  rw [map_mul, map_intCast, ← hx]
  linear_combination ((n : ℂ) * z) * hq

private theorem Cl_one : (1 : ℂ) ∈ Cl := ⟨1, one_pos, 1, by simp⟩
private theorem Cl_I : Complex.I ∈ Cl := ⟨1, one_pos, ordI, by simp [ordI, den]⟩

private theorem Cl_sqrt33 : ((Real.sqrt 33 : ℝ) : ℂ) ∈ Cl := by
  refine ⟨1, one_pos, 2 * ordTau - 1, ?_⟩
  rw [map_sub, map_mul, map_one, map_ofNat, den_ordTau]
  apply Complex.ext <;> simp [tau]
  ring

private theorem Cl_I_sqrt3 : Complex.I * ((Real.sqrt 3 : ℝ) : ℂ) ∈ Cl := by
  refine ⟨1, one_pos, 1 + 2 * ordOmega, ?_⟩
  rw [map_add, map_mul, map_one, map_ofNat, den_ordOmega]
  apply Complex.ext <;> simp [omega3] <;> ring

private theorem Cl_sqrt3 : ((Real.sqrt 3 : ℝ) : ℂ) ∈ Cl := by
  have h : ((Real.sqrt 3 : ℝ) : ℂ) = (-1 : ℚ) * (Complex.I * (Complex.I * (Real.sqrt 3 : ℝ))) := by
    push_cast
    linear_combination ((Real.sqrt 3 : ℝ) : ℂ) * Complex.I_sq
  rw [h]
  exact Cl_ratMul (Cl_mul Cl_I Cl_I_sqrt3) _

private theorem Cl_sqrt11 : ((Real.sqrt 11 : ℝ) : ℂ) ∈ Cl := by
  have h : ((Real.sqrt 11 : ℝ) : ℂ)
      = ((1/3 : ℚ)) * (((Real.sqrt 3 : ℝ) : ℂ) * ((Real.sqrt 33 : ℝ) : ℂ)) := by
    rw [← Complex.ofReal_mul, sqrt3_mul_sqrt33]; push_cast; ring
  rw [h]
  exact Cl_ratMul (Cl_mul Cl_sqrt3 Cl_sqrt33) _

private theorem Cl_of_seamSpan {x : ℝ} (hx : x ∈ seamSpan) : ((x : ℝ) : ℂ) ∈ Cl := by
  obtain ⟨a, b, c, d, rfl⟩ := hx
  push_cast
  refine Cl_add (Cl_add (Cl_add ?_ ?_) ?_) ?_
  · simpa using Cl_ratMul Cl_one a
  · simpa using Cl_ratMul Cl_sqrt3 b
  · simpa using Cl_ratMul Cl_sqrt11 c
  · simpa using Cl_ratMul Cl_sqrt33 d

/-- Every point of `K²` has a positive integer multiple in the order. -/
theorem exists_nat_mul_mem_range {z : ℂ} (hz : z ∈ seamPlane) :
    ∃ n : ℕ, 0 < n ∧ ∃ x : SeamOrder, (n : ℂ) * z = den x := by
  have : z = ((z.re : ℝ) : ℂ) + ((z.im : ℝ) : ℂ) * Complex.I := by
    apply Complex.ext <;> simp
  rw [this]
  exact Cl_add (Cl_of_seamSpan hz.1) (Cl_mul (Cl_of_seamSpan hz.2) Cl_I)

/-! ## §7 Unit vectors lie in the order, with an odd denominator

The engine. A unit vector's denominator over the order is odd: if it were even, both residue maps
would kill the numerator, two descents would divide it by `(1+i)² = 2i`, and the denominator would
halve. -/

/-- `A = O[1/odd]`: a point with an odd integer multiple in the order. -/
def IsOddDenom (z : ℂ) : Prop := ∃ x : SeamOrder, ∃ m : ℤ, Odd m ∧ (m : ℂ) * z = den x

/-- `A`, as a subring of the plane. -/
def oddDenom : Subring ℂ where
  carrier := {z | IsOddDenom z}
  zero_mem' := ⟨0, 1, odd_one, by simp⟩
  one_mem' := ⟨1, 1, odd_one, by simp⟩
  add_mem' := by
    rintro z w ⟨x, m, hm, hx⟩ ⟨y, n, hn, hy⟩
    refine ⟨(n : SeamOrder) * x + (m : SeamOrder) * y, m * n, hm.mul hn, ?_⟩
    rw [map_add, map_mul, map_mul, map_intCast, map_intCast, ← hx, ← hy]
    push_cast; ring
  neg_mem' := by
    rintro z ⟨x, m, hm, hx⟩
    exact ⟨-x, m, hm, by rw [map_neg, ← hx]; ring⟩
  mul_mem' := by
    rintro z w ⟨x, m, hm, hx⟩ ⟨y, n, hn, hy⟩
    refine ⟨x * y, m * n, hm.mul hn, ?_⟩
    rw [map_mul, ← hx, ← hy]; push_cast; ring

theorem mem_oddDenom_iff {z : ℂ} : z ∈ oddDenom ↔ IsOddDenom z := Iff.rfl

private theorem onePlusI_mul_conj : onePlusI * conj onePlusI = (2 : SeamOrder) := by decide

private theorem onePlusI_sq : onePlusI * onePlusI = 2 * ordI := by decide

/-- The norm equation an order element inherits from a unit vector with denominator `n`. -/
private theorem norm_eq_of_den {u : ℂ} {x : SeamOrder} {n : ℤ}
    (hu : u * (starRingEnd ℂ) u = 1) (hx : (n : ℂ) * u = den x) :
    x * conj x = ((n ^ 2 : ℤ) : SeamOrder) := by
  refine den_injective ?_
  rw [map_mul, den_conj, map_intCast, ← hx]
  push_cast
  rw [map_mul, map_intCast]
  calc ((n : ℂ) * u) * ((n : ℂ) * (starRingEnd ℂ) u)
      = (n : ℂ) ^ 2 * (u * (starRingEnd ℂ) u) := by ring
    _ = (n : ℂ) ^ 2 := by rw [hu, mul_one]

private theorem oddDenom_aux : ∀ n : ℕ, ∀ (u : ℂ) (x : SeamOrder), 0 < n →
    u * (starRingEnd ℂ) u = 1 → (n : ℂ) * u = den x → IsOddDenom u := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    intro u x hn hu hx
    rcases Nat.even_or_odd n with he | ho
    · -- the denominator is even: descend twice and halve it
      obtain ⟨k, hk⟩ := he
      have hk0 : 0 < k := by omega
      have hkn : k < n := by omega
      have hxc : x * conj x = (((n : ℤ) ^ 2 : ℤ) : SeamOrder) :=
        norm_eq_of_den hu (by exact_mod_cast hx)
      have hEven : Even ((n : ℤ) ^ 2) := by
        refine ⟨2 * (k : ℤ) ^ 2, ?_⟩
        have : (n : ℤ) = 2 * k := by exact_mod_cast (by omega : n = 2 * k)
        rw [this]; ring
      obtain ⟨w, hw⟩ := exists_mul_onePlusI
        (eq_zero_of_even_norm psiZero_conj hEven hxc)
        (eq_zero_of_even_norm psiOne_conj hEven hxc)
      have hww : (2 : SeamOrder) * (w * conj w) = (((n : ℤ) ^ 2 : ℤ) : SeamOrder) := by
        rw [← hxc, ← hw, map_mul]
        rw [show (w * onePlusI) * (conj w * conj onePlusI)
            = (w * conj w) * (onePlusI * conj onePlusI) by ring, onePlusI_mul_conj]
        ring
      have hww2 : w * conj w = ((2 * (k : ℤ) ^ 2 : ℤ) : SeamOrder) := by
        refine two_mul_cancel ?_
        rw [hww]
        have : (n : ℤ) = 2 * k := by exact_mod_cast (by omega : n = 2 * k)
        rw [this]
        push_cast
        ring
      have hEven2 : Even (2 * (k : ℤ) ^ 2) := ⟨(k : ℤ) ^ 2, by ring⟩
      obtain ⟨v, hv⟩ := exists_mul_onePlusI
        (eq_zero_of_even_norm psiZero_conj hEven2 hww2)
        (eq_zero_of_even_norm psiOne_conj hEven2 hww2)
      have hxv : x = v * (2 * ordI) := by rw [← onePlusI_sq, ← hw, ← hv]; ring
      have hku : (k : ℂ) * u = den (ordI * v) := by
        have h2 : (2 : ℂ) * ((k : ℂ) * u) = 2 * den (ordI * v) := by
          have hn2 : (n : ℂ) = 2 * (k : ℂ) := by exact_mod_cast (by omega : n = 2 * k)
          rw [← mul_assoc, ← hn2, hx, hxv]
          rw [map_mul, map_mul, map_ofNat, map_mul]
          ring
        exact mul_left_cancel₀ (by norm_num : (2 : ℂ) ≠ 0) h2
      exact ih k hkn u (ordI * v) hk0 hu hku
    · exact ⟨x, (n : ℤ), by exact_mod_cast ho, by exact_mod_cast hx⟩

/-- **Every unit vector of `K(i)` lies in `A`** — the theorem's engine. -/
theorem mem_oddDenom_of_unit {u : ℂ} (hu : u ∈ seamPlane) (h1 : normSq u = 1) : u ∈ oddDenom := by
  obtain ⟨n, hn, x, hx⟩ := exists_nat_mul_mem_range hu
  exact oddDenom_aux n u x hn (mem_normOne.mp (mem_normOne_conj_iff.mpr h1)) hx

/-- **`A` is stable under conjugation** — the order is (`den_conj`), and the denominators are
rational, so conjugation fixes them. -/
theorem conj_mem_oddDenom : ∀ z ∈ oddDenom, (starRingEnd ℂ) z ∈ oddDenom := by
  rintro z ⟨x, m, hm, hx⟩
  refine ⟨conj x, m, hm, ?_⟩
  rw [den_conj, ← hx, map_mul, map_intCast]

/-- The residue of a point of `A`, before bundling. Sealed: reason through `psiA_eq`. -/
private noncomputable def psiAFun (z : oddDenom) : F4 := psiZero z.2.choose

/-- The residue is read off any witness: if `m·z` is `x` in the order with `m` odd, the choice the
definition made has the same residue as `x`. -/
private theorem psiAFun_eq (z : oddDenom) {m : ℤ} {x : SeamOrder} (hm : Odd m)
    (hx : (m : ℂ) * (z : ℂ) = den x) : psiAFun z = psiZero x := by
  obtain ⟨m', hm', hx'⟩ := z.2.choose_spec
  have key : ((m' : SeamOrder)) * x = (m : SeamOrder) * z.2.choose := by
    refine den_injective ?_
    rw [map_mul, map_mul, map_intCast, map_intCast, ← hx, ← hx']
    ring
  have hpsi := congrArg psiZero key
  rw [map_mul, map_mul, map_intCast, map_intCast, F4.intCast_odd hm', F4.intCast_odd hm,
    one_mul, one_mul] at hpsi
  exact hpsi.symm

/-- **The residue map of `A = O[1/odd]`**, as a ring homomorphism onto `𝔽₄`: a point `z` with
`m·z = x` in the order and `m` odd has residue `psiZero x`, which `psiA_eq` says does not depend on
the witness. It is a *ring* homomorphism, which is what makes a unit vector's residue nonzero. -/
noncomputable def psiA : oddDenom →+* F4 where
  toFun := psiAFun
  map_one' := by
    rw [psiAFun_eq 1 odd_one (x := 1) (by simp), map_one]
  map_mul' x y := by
    obtain ⟨a, m, hm, hx⟩ := x.2
    obtain ⟨b, n, hn, hy⟩ := y.2
    have key : ((m * n : ℤ) : ℂ) * ((x * y : oddDenom) : ℂ) = den (a * b) := by
      rw [map_mul, ← hx, ← hy]
      push_cast
      ring
    rw [psiAFun_eq (x * y) (hm.mul hn) key, psiAFun_eq x hm hx, psiAFun_eq y hn hy, map_mul]
  map_zero' := by
    rw [psiAFun_eq 0 odd_one (x := 0) (by simp), map_zero]
  map_add' x y := by
    obtain ⟨a, m, hm, hx⟩ := x.2
    obtain ⟨b, n, hn, hy⟩ := y.2
    have key : ((m * n : ℤ) : ℂ) * ((x + y : oddDenom) : ℂ)
        = den ((n : SeamOrder) * a + (m : SeamOrder) * b) := by
      rw [map_add, map_mul, map_mul, map_intCast, map_intCast, ← hx, ← hy]
      push_cast
      ring
    rw [psiAFun_eq (x + y) (hm.mul hn) key, psiAFun_eq x hm hx, psiAFun_eq y hn hy,
      map_add, map_mul, map_mul, map_intCast, map_intCast, F4.intCast_odd hm, F4.intCast_odd hn,
      one_mul, one_mul]

/-- The residue is read off any witness — the reasoning surface of `psiA`. -/
theorem psiA_eq {z : ℂ} (hz : z ∈ oddDenom) {m : ℤ} {x : SeamOrder} (hm : Odd m)
    (hx : (m : ℂ) * z = den x) : psiA ⟨z, hz⟩ = psiZero x := psiAFun_eq ⟨z, hz⟩ hm hx

/-! ## §8 The colouring

Every unit step stays inside one coset of `A`, so the general residue colouring of
`Proofs/HadwigerNelson/ResidueColouring.lean` applies at `A = oddDenom`, `ψ = psiA`: choose a
representative per coset and read the residue of the offset. No finiteness hypothesis anywhere. -/

/-- **The residue colouring of the plane over `K`.** The general `cosetResidue` map at this file's
subring and residue map — on each coset of `A` it is `psiZero`, and the coset representative is
chosen once, by `Classical.choice`. -/
noncomputable def residueColouring (z : ℂ) : F4 :=
  cosetResidue (A := oddDenom.toAddSubgroup) psiA.toAddMonoidHom z

/-- Adjacent points of `K²` get different colours — the properness of the colouring. A unit vector
is a unit of `A` (`conj_mem_oddDenom` gives its inverse), so its residue is nonzero. -/
theorem residueColouring_ne_of_dist_one {z w : ℂ} (hz : z ∈ seamPlane) (hw : w ∈ seamPlane)
    (h : dist z w = 1) : residueColouring z ≠ residueColouring w :=
  have hone : z - w ∈ normOne (starRingEnd ℂ) := sub_mem_normOne_conj_iff.mpr h
  cosetResidue_ne_of_mem_normOne conj_mem_oddDenom psiA
    (mem_oddDenom_of_unit (seamPlane_sub hz hw) (mem_normOne_conj_iff.mp hone)) hone

/-- **Distance `2` is monochromatic**, because `2` lies in the prime: a pair at distance `2` is
`2 ·` a unit vector and the residue field has characteristic two. The honest form of "a version of
this theorem for the `{1, 2}`-distance graph would be false" — Exoo–Ismailescu's 6-chromatic
`{1, 2}`-graph has all its coordinates in `K`. -/
theorem residueColouring_eq_of_dist_two {z w : ℂ} (hz : z ∈ seamPlane) (hw : w ∈ seamPlane)
    (h : dist z w = 2) : residueColouring z = residueColouring w := by
  set v : ℂ := (1/2 : ℚ) * (z - w) with hv
  have hvmem : v ∈ seamPlane := seamPlane_ratMul (seamPlane_sub hz hw) _
  have hnorm : normSq v = 1 := by
    have hzw : ‖z - w‖ = 2 := by rwa [← Complex.dist_eq]
    have hns : normSq (z - w) = 4 := by
      have h2 := congrArg (fun t : ℝ => t ^ 2) hzw
      simp only [Complex.sq_norm] at h2
      rw [h2]; norm_num
    rw [hv, show ((1/2 : ℚ) : ℂ) = (1/2 : ℂ) by push_cast; ring, map_mul, hns]
    rw [show normSq (1/2 : ℂ) = 1/4 by simp; norm_num]
    norm_num
  have hvA : v ∈ oddDenom := mem_oddDenom_of_unit hvmem hnorm
  have h2A : (2 : ℂ) ∈ oddDenom := ⟨2, 1, odd_one, by rw [map_ofNat]; push_cast; ring⟩
  have hfac : z - w = (2 : ℂ) * v := by rw [hv]; push_cast; ring
  have hmem : z - w ∈ oddDenom := hfac ▸ oddDenom.mul_mem h2A hvA
  refine (cosetResidue_eq_iff_map psiA hmem).mpr ?_
  rw [show (⟨z - w, hmem⟩ : oddDenom) = ⟨(2 : ℂ) * v, oddDenom.mul_mem h2A hvA⟩ from
      Subtype.ext hfac,
    map_mul_normOne_eq_zero_iff conj_mem_oddDenom psiA h2A hvA (mem_normOne_conj_iff.mpr hnorm),
    psiA_eq h2A odd_one (x := 2) (by rw [map_ofNat]; push_cast; ring)]
  decide

end FieldWall4

export FieldWall4 (seamSpan seamField seamPlane residueColouring)

open FieldWall4 SimpleGraph Complex

/-- Any set of points with coordinates in `K` is 4-colourable. -/
theorem colorable_four_of_subset_seamPlane (S : Set ℂ) (hS : S ⊆ seamPlane) :
    ((unitDistance ℂ).induce S).Colorable 4 := by
  have h := colorable_unitDistance_induce_of_residue FieldWall4.conj_mem_oddDenom FieldWall4.psiA
    (S := S) fun z hz w hw hd =>
      FieldWall4.mem_oddDenom_of_unit (FieldWall4.seamPlane_sub (hS hz) (hS hw))
        (mem_normOne_conj_iff.mp (sub_mem_normOne_conj_iff.mpr hd))
  rwa [FieldWall4.F4.card_eq_four] at h

/-- **Theorem B.** Every unit-distance graph drawn in `ℚ(√3, √11)²` is 4-colourable. -/
theorem four_colorable_of_seam_field :
    ((unitDistance ℂ).induce seamPlane).Colorable 4 :=
  colorable_four_of_subset_seamPlane seamPlane (subset_refl _)

/-! ### The consequence that stopped a campaign

A `K`-point unit-distance graph is 4-colourable, so by the spare-colour lemma it carries no pair
compulsion at five colours — in either polarity. This is why a descent confined to `K` can never
terminate (`plans/M53-iteration-5.md`, halted 2026-09-05). -/

/-- **No forced-equal pair at five colours over `K`.** -/
theorem not_forces_five_of_subset_seamPlane {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S}
    (hpq : p ≠ q) : ¬ Forces ((unitDistance ℂ).induce S) 5 p q :=
  not_forces_of_colorable (colorable_four_of_subset_seamPlane S hS) hpq

/-- **No virtual edge at five colours over `K`.** -/
theorem not_separated_five_of_subset_seamPlane {S : Set ℂ} (hS : S ⊆ seamPlane) {p q : S}
    (hadj : ¬ ((unitDistance ℂ).induce S).Adj p q) :
    ¬ Separated ((unitDistance ℂ).induce S) 5 p q :=
  not_separated_of_colorable (colorable_four_of_subset_seamPlane S hS) hadj

/-! ### The lower bound: the Moser spindle is an identity in the order

`ζ₆ = 1 + ω`, `ζ₃ = ω`, `i√3 = 1 + 2ω`, and `9ρ = 7 − ω + T + 2ωT` for the Moser twist
`ρ = (5 + i√11)/6`. So all seven spindle points are `den x / 9` for explicit `x : SeamOrder`, and
because `den` is a ring homomorphism intertwining the two conjugations, each of the eleven unit
distances is the single identity `(xᵢ − xⱼ) · conj (xᵢ − xⱼ) = 81` in the order — eight integers,
decided by the kernel. No `Real.sqrt` manipulation appears in this section at all. -/

namespace FieldWall4

open Complex

/-- `9ρ`, where `ρ = (5 + i√11)/6` is the Moser twist: `9ρ = 7 − ω + T + 2ωT`. -/
def rho9 : SeamOrder := 7 - ordOmega + ordTau + 2 * ordOmega * ordTau

/-- The seven Moser-spindle points, scaled by `9` into the order: the rhombus is
`{0, 1+ω, ω, 1+2ω}` and its image under the twist. -/
def spindleOrd : Fin 7 → SeamOrder :=
  ![0, 9 * (1 + ordOmega), 9 * ordOmega, 9 * (1 + 2 * ordOmega),
    rho9 * (1 + ordOmega), rho9 * ordOmega, rho9 * (1 + 2 * ordOmega)]

/-- The seven points themselves. -/
noncomputable def spindlePt (i : Fin 7) : ℂ := ((1/9 : ℚ) : ℂ) * den (spindleOrd i)

/-- The twist really is `(5 + i√11)/6` — the spec check that pins `rho9`. -/
theorem den_rho9 : den rho9 = 9 * FieldWall.moserTwist := by
  rw [rho9]
  simp only [map_add, map_sub, map_mul, map_ofNat, den_ordOmega, den_ordTau]
  apply Complex.ext <;>
    simp [omega3, tau, FieldWall.moserTwist, Complex.mul_re, Complex.mul_im] <;>
    nlinarith [sq_sqrt3, sq_sqrt33, sqrt3_mul_sqrt33, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 11)]

private theorem spindleOrd_norm_aux : ∀ i j : Fin 7,
    (i ≠ j ∧ ((i, j) ∈ moserSpindleEdges ∨ (j, i) ∈ moserSpindleEdges)) →
      (spindleOrd i - spindleOrd j) * conj (spindleOrd i - spindleOrd j) = (81 : SeamOrder) := by
  decide

/-- **The eleven unit distances, as one identity in the order.** -/
theorem spindleOrd_norm (i j : Fin 7) (h : (edgeGraph 7 moserSpindleEdges).Adj i j) :
    (spindleOrd i - spindleOrd j) * conj (spindleOrd i - spindleOrd j) = (81 : SeamOrder) :=
  spindleOrd_norm_aux i j h

theorem spindlePt_mem (i : Fin 7) : spindlePt i ∈ seamPlane :=
  seamPlane_ratMul (den_mem_seamPlane _) _

theorem spindlePt_dist (i j : Fin 7) (h : (edgeGraph 7 moserSpindleEdges).Adj i j) :
    dist (spindlePt i) (spindlePt j) = 1 := by
  refine sub_mem_normOne_conj_iff.mp (mem_normOne_conj_iff.mpr ?_)
  set u : SeamOrder := spindleOrd i - spindleOrd j with hu
  have hden : normSq (den u) = 81 := by
    have h1 : den u * (starRingEnd ℂ) (den u) = (81 : ℂ) := by
      rw [← den_conj, ← map_mul, hu, spindleOrd_norm i j h, map_ofNat]
    rw [Complex.mul_conj] at h1
    exact_mod_cast h1
  have hsub : spindlePt i - spindlePt j = ((1/9 : ℚ) : ℂ) * den u := by
    rw [spindlePt, spindlePt, hu, map_sub]; ring
  rw [hsub, map_mul, hden]
  rw [show normSq (((1/9 : ℚ) : ℂ)) = 1/81 by
    rw [show (((1/9 : ℚ)) : ℂ) = (1/9 : ℂ) by push_cast; ring]; simp; norm_num]
  norm_num

end FieldWall4

theorem four_le_chromaticNumber_seamPlane :
    4 ≤ ((unitDistance ℂ).induce seamPlane).chromaticNumber := by
  have hom : (edgeGraph 7 moserSpindleEdges) →g ((unitDistance ℂ).induce seamPlane) :=
    { toFun := fun i => ⟨FieldWall4.spindlePt i, FieldWall4.spindlePt_mem i⟩
      map_rel' := fun {i j} h => FieldWall4.spindlePt_dist i j h }
  have hmono := chromaticNumber_mono_of_hom hom
  have hlt : (3 : ℕ∞) < (edgeGraph 7 moserSpindleEdges).chromaticNumber :=
    lt_chromaticNumber_iff_not_colorable.mpr moserSpindle_not_colorable_three
  have : (3 : ℕ∞) < ((unitDistance ℂ).induce seamPlane).chromaticNumber := lt_of_lt_of_le hlt hmono
  rwa [show (4 : ℕ∞) = (3 : ℕ∞) + 1 by rfl, ENat.add_one_le_iff (by decide)]

/-- **`χ(ℚ(√3, √11)²) = 4` exactly.** -/
theorem chromaticNumber_seamPlane :
    ((unitDistance ℂ).induce seamPlane).chromaticNumber = 4 :=
  le_antisymm (chromaticNumber_le_iff_colorable.mpr four_colorable_of_seam_field)
    four_le_chromaticNumber_seamPlane


/-! ## Spec — what would go red if the model drifted

These are the checks that catch a wrong *statement*, which no amount of green elaboration can. `#guard` runs interpreted at elaboration and
buys no axioms. -/

namespace FieldWall4

section Spec

open Complex

/-! ### The residue table

The four residues of `ζ₆ = 1 + ω`, the Moser twist `ρ` (through `9ρ = rho9`), the seam rotation
`σ = (√3 + i√33)/6` (through `3σ`) and `τ₅ = (49 + 3i√11)/50` (through `25τ₅`) — the write-up's
§5.3 table at this file's prime. Each order element is pinned to its complex value first, so the
residues are residues *of the right numbers*. -/

/-- `3σ`, where `σ = (√3 + i√33)/6` is the seam rotation. -/
def sigma3 : SeamOrder := -ordI - ordOmega * ordI + ordI * ordTau

/-- `25τ₅`, where `τ₅ = (49 + 3i√11)/50` is the rotation of the distance-5 spindle. -/
def tauFive25 : SeamOrder := 24 - ordOmega + ordTau + 2 * ordOmega * ordTau

theorem den_sigma3 : den sigma3 = ⟨Real.sqrt 3 / 2, Real.sqrt 33 / 2⟩ := by
  rw [sigma3]
  simp only [map_add, map_sub, map_mul, map_neg, den_ordOmega, den_ordTau, den_ordI]
  apply Complex.ext <;> simp [omega3, tau, Complex.mul_re, Complex.mul_im]
  ring

theorem den_tauFive25 : den tauFive25 = ⟨49 / 2, 3 * Real.sqrt 11 / 2⟩ := by
  rw [tauFive25]
  simp only [map_add, map_sub, map_mul, map_ofNat, den_ordOmega, den_ordTau]
  apply Complex.ext <;>
    simp [omega3, tau, Complex.mul_re, Complex.mul_im] <;>
    nlinarith [sq_sqrt3, sq_sqrt33, sqrt3_mul_sqrt33]

-- `ζ₆ ↦ Ω²`, `ρ ↦ Ω²`, `σ ↦ Ω²`, `τ₅ ↦ Ω`. See the module docstring on why the write-up's table
-- reads differently: it fixes the other prime.
#guard psiZero (1 + ordOmega) == (⟨1, 1⟩ : F4)
#guard psiZero rho9 == (⟨1, 1⟩ : F4)
#guard psiZero sigma3 == (⟨1, 1⟩ : F4)
#guard psiZero tauFive25 == (⟨0, 1⟩ : F4)

-- The other prime disagrees on `ρ` and `τ₅` — the two maps are genuinely different.
#guard psiOne rho9 == (⟨0, 1⟩ : F4)
#guard psiOne tauFive25 == (⟨1, 1⟩ : F4)

/-! ### The spindle, coloured

The seven Moser-spindle points get residues `0, Ω², Ω, 1, Ω, 1, Ω²`; all four colours appear, and
adjacent points differ. This is the colouring doing its job on the object that forces four. -/

#guard ((List.finRange 7).map fun i => psiZero (spindleOrd i))
  == [(⟨0, 0⟩ : F4), ⟨1, 1⟩, ⟨0, 1⟩, ⟨1, 0⟩, ⟨0, 1⟩, ⟨1, 0⟩, ⟨1, 1⟩]

#guard (((List.finRange 7).map fun i => psiZero (spindleOrd i)).dedup).length == 4

/-- The eleven edges of the spindle get distinct residues. -/
example : ∀ i j : Fin 7, (i ≠ j ∧ ((i, j) ∈ moserSpindleEdges ∨ (j, i) ∈ moserSpindleEdges)) →
    psiZero (spindleOrd i) ≠ psiZero (spindleOrd j) := by decide

/-! ### Certifying a point of `K²`

The path a consumer walks: `mem_seamPlane_iff`, then the `Subfield` API over the three generators. -/

example : (⟨1/2, Real.sqrt 3 / 2⟩ : ℂ) ∈ seamPlane := by
  have h2 : (2 : ℝ) ∈ seamField := by
    have h := seamField.add_mem seamField.one_mem seamField.one_mem
    rwa [show (1 : ℝ) + 1 = 2 by norm_num] at h
  have hhalf : (2 : ℝ)⁻¹ ∈ seamField := seamField.inv_mem h2
  refine mem_seamPlane_iff.mpr ⟨?_, ?_⟩
  · show (1/2 : ℝ) ∈ seamField
    rw [one_div]; exact hhalf
  · show (Real.sqrt 3 / 2 : ℝ) ∈ seamField
    rw [div_eq_mul_inv]; exact seamField.mul_mem sqrt3_mem hhalf

/-! ### Negative controls

Each of these is a mutation of a load-bearing statement, and each must be *false*. -/

-- The descent's hypothesis is not vacuous: `1` is not killed by the residue map, so
-- `exists_mul_onePlusI` does not apply to it.
#guard psiZero 1 != (0 : F4)

-- The norm identity is exact: `80` is refuted where `81` is proved.
example : (spindleOrd 0 - spindleOrd 1) * conj (spindleOrd 0 - spindleOrd 1) ≠ (80 : SeamOrder) := by
  decide

-- `F4` really has four elements and characteristic two — the two facts the whole argument turns on.
#guard Fintype.card F4 == 4
example : (2 : F4) = 0 := by decide

-- The order is not the whole plane: `1/2` has an even denominator, so the coset machinery is not
-- dead code. (`m · (1/2) = den x` with `m` odd would put a half-integer coordinate in `ℤ`.)
example : ((1/2 : ℚ) : ℂ) ∈ seamPlane :=
  ⟨⟨1/2, 0, 0, 0, by simp⟩, ⟨0, 0, 0, 0, by simp⟩⟩

end Spec

end FieldWall4

/-! ### The distance-2 red, on the plane

A pair at distance `2` gets **one** colour, so the same construction cannot 4-colour the
`{1, 2}`-distance graph — which is as it must be: Exoo–Ismailescu's 6-chromatic `{1, 2}`-graph has
all of its coordinates in `K`. -/

example : residueColouring 0 = residueColouring 2 := by
  refine FieldWall4.residueColouring_eq_of_dist_two ?_ ?_ ?_
  · exact ⟨⟨0, 0, 0, 0, by norm_num⟩, ⟨0, 0, 0, 0, by norm_num⟩⟩
  · exact ⟨⟨2, 0, 0, 0, by norm_num⟩, ⟨0, 0, 0, 0, by norm_num⟩⟩
  · rw [Complex.dist_eq]; norm_num

end HadwigerNelson
