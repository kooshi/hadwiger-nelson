import Proofs.HadwigerNelson.Ladder
import Proofs.HadwigerNelson.SpareColour
import Proofs.HadwigerNelson.FieldWall
import Proofs.HadwigerNelson.Instances.SpindleBound

/-!
# The field wall: `χ(ℚ(√3, √11)²) = 4`

Skeleton (B1 subplan `plans/B1-field-wall-kernel.md`, after the domain-modeling pass §6).
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

@[simp] theorem lift_theta {S : Type*} [CommRing S] (f : R →+* S) (t : S)
    (ht : t * t = (b : S) * t + (c : S)) : lift f t ht theta = t := by simp

@[simp] theorem lift_comp_incl {S : Type*} [CommRing S] (f : R →+* S) (t : S)
    (ht : t * t = (b : S) * t + (c : S)) : (lift f t ht).comp incl = f := by
  ext r; simp

@[simp] theorem lift_incl {S : Type*} [CommRing S] (f : R →+* S) (t : S)
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

@[simp] theorem conjSwap_incl (g : R →+* R) (r : R) :
    conjSwap (b := b) (c := c) g (incl r) = incl (g r) := by ext <;> simp
@[simp] theorem conjBase_incl (g : R →+* R) (r : R) :
    conjBase (b := b) (c := c) g (incl r) = incl (g r) := by ext <;> simp

@[simp] theorem conjSwap_comp_incl (g : R →+* R) :
    (conjSwap (b := b) (c := c) g).comp incl = incl.comp g := by
  ext r <;> simp [RingHom.comp_apply]
@[simp] theorem conjBase_comp_incl (g : R →+* R) :
    (conjBase (b := b) (c := c) g).comp incl = incl.comp g := by
  ext r <;> simp [RingHom.comp_apply]
@[simp] theorem conjSwap_theta (g : R →+* R) :
    conjSwap (b := b) (c := c) g theta = (b : Quad b c R) - theta := by ext <;> simp
@[simp] theorem conjBase_theta (g : R →+* R) :
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

/-! ## §4 `den` is injective -/

theorem den_injective : Function.Injective den := by sorry

/-! ## §5 The descent -/

/-- `1 + i` in the order. -/
def onePlusI : SeamOrder := 1 + Quad.theta

theorem den_onePlusI : den onePlusI = 1 + Complex.I := by sorry

/-- **The descent.** An element of the order killed by both residue maps is divisible by `1 + i`:
writing `z = p + qi`, the two conditions say exactly `p ≡ q` mod `2` in all four coordinates, and
then `z/(1+i) = (p+q)/2 + ((q−p)/2)·i` has integer coordinates. -/
theorem exists_mul_onePlusI {z : SeamOrder} (h0 : psiZero z = 0) (h1 : psiOne z = 0) :
    ∃ w : SeamOrder, w * onePlusI = z := by sorry

/-- A residue map compatible with conjugation kills any element of even norm. -/
theorem eq_zero_of_even_norm {f : SeamOrder →+* F4} (hf : ∀ x, f (conj x) = f x * f x)
    {z : SeamOrder} {N : ℤ} (hN : Even N) (h : z * conj z = (N : SeamOrder)) : f z = 0 := by sorry

/-! ## §6 The seam field and its plane -/

/-- The ℚ-span of `1, √3, √11, √33`. -/
def seamSpan : Set ℝ :=
  {x | ∃ a b c d : ℚ, x = a + b * Real.sqrt 3 + c * Real.sqrt 11 + d * Real.sqrt 33}

/-- `K = ℚ(√3, √11)`, as a subfield of `ℝ`. -/
noncomputable def seamField : Subfield ℝ where
  carrier := seamSpan
  zero_mem' := by sorry
  one_mem' := by sorry
  add_mem' := by sorry
  neg_mem' := by sorry
  mul_mem' := by sorry
  inv_mem' := by sorry

@[simp] theorem seamField_carrier : (seamField : Set ℝ) = seamSpan := rfl

/-- `K²`: the complex numbers with both coordinates in `K`. -/
def seamPlane : Set ℂ := {z | z.re ∈ seamSpan ∧ z.im ∈ seamSpan}

theorem mem_seamPlane_iff {z : ℂ} : z ∈ seamPlane ↔ z.re ∈ seamField ∧ z.im ∈ seamField := Iff.rfl

/-- Membership in `K`, spelled out. With this and the three generators below, the whole `Subfield`
API (`add_mem`, `mul_mem`, `inv_mem`, `ratCast_mem`, …) certifies a point of `K²`. -/
theorem mem_seamField_iff {x : ℝ} :
    x ∈ seamField ↔ ∃ a b c d : ℚ, x = a + b * Real.sqrt 3 + c * Real.sqrt 11 + d * Real.sqrt 33 :=
  Iff.rfl

theorem sqrt3_mem : Real.sqrt 3 ∈ seamField := by sorry
theorem sqrt11_mem : Real.sqrt 11 ∈ seamField := by sorry
theorem sqrt33_mem : Real.sqrt 33 ∈ seamField := by sorry

theorem seamPlane_sub {z w : ℂ} (hz : z ∈ seamPlane) (hw : w ∈ seamPlane) :
    z - w ∈ seamPlane := by sorry

theorem den_mem_seamPlane (x : SeamOrder) : den x ∈ seamPlane := by sorry

theorem seamPlane_ratMul {z : ℂ} (hz : z ∈ seamPlane) (q : ℚ) : (q : ℂ) * z ∈ seamPlane := by sorry

/-- Every point of `K²` has a nonzero integer multiple in the order. -/
theorem exists_nat_mul_mem_range {z : ℂ} (hz : z ∈ seamPlane) :
    ∃ n : ℕ, 0 < n ∧ ∃ x : SeamOrder, (n : ℂ) * z = den x := by sorry

/-! ## §7 Unit vectors lie in the order with odd denominator -/

/-- `A = O[1/odd]`: a point with an odd integer multiple in the order. -/
def IsOddDenom (z : ℂ) : Prop := ∃ x : SeamOrder, ∃ m : ℤ, Odd m ∧ (m : ℂ) * z = den x

/-- `A`, as a subring of the plane. -/
def oddDenom : Subring ℂ where
  carrier := {z | IsOddDenom z}
  zero_mem' := by sorry
  one_mem' := by sorry
  add_mem' := by sorry
  neg_mem' := by sorry
  mul_mem' := by sorry

theorem mem_oddDenom_iff {z : ℂ} : z ∈ oddDenom ↔ IsOddDenom z := Iff.rfl

/-- **Every unit vector of `K(i)` lies in `A`** — the theorem's engine. -/
theorem mem_oddDenom_of_unit {u : ℂ} (hu : u ∈ seamPlane) (h1 : normSq u = 1) : u ∈ oddDenom := by sorry

/-- The residue of a point of `A`, as a total function. Sealed: reason through `psiOf_eq`. -/
noncomputable def psiOf (z : ℂ) : F4 :=
  open Classical in if h : IsOddDenom z then psiZero h.choose else 0

theorem psiOf_eq {z : ℂ} {m : ℤ} {x : SeamOrder} (hm : Odd m) (hx : (m : ℂ) * z = den x) :
    psiOf z = psiZero x := by sorry

theorem psiOf_sub {z w : ℂ} (hz : z ∈ oddDenom) (hw : w ∈ oddDenom) :
    psiOf (z - w) = psiOf z - psiOf w := by sorry

theorem psiOf_ne_zero_of_unit {u : ℂ} (hu : u ∈ oddDenom) (h1 : normSq u = 1) : psiOf u ≠ 0 := by sorry

/-! ## §8 The colouring -/

/-- A chosen representative of each coset of `A` in the plane. -/
noncomputable def base (z : ℂ) : ℂ :=
  Quotient.out (QuotientAddGroup.mk' oddDenom.toAddSubgroup z)

theorem sub_base_mem (z : ℂ) : z - base z ∈ oddDenom := by sorry

theorem base_eq_of_sub_mem {z w : ℂ} (h : z - w ∈ oddDenom) : base z = base w := by sorry

/-- **The residue colouring of the plane over `K`.** On each coset of `oddDenom` it is the
residue map `psiZero` of §3; the coset representative is chosen once, by `Classical.choice`. -/
noncomputable def residueColouring (z : ℂ) : F4 := psiOf (z - base z)

/-- Adjacent points of `K²` get different colours — the properness of the colouring. -/
theorem residueColouring_ne_of_dist_one {z w : ℂ} (hz : z ∈ seamPlane) (hw : w ∈ seamPlane)
    (h : dist z w = 1) : residueColouring z ≠ residueColouring w := by sorry

/-- **Distance `2` is monochromatic**, because `2` lies in the prime: a pair at distance `2` is
`2 ·` a unit vector and the residue field has characteristic two. The honest form of "a version of
this theorem for the `{1, 2}`-distance graph would be false" — Exoo–Ismailescu's 6-chromatic
`{1, 2}`-graph has all its coordinates in `K`. -/
theorem residueColouring_eq_of_dist_two {z w : ℂ} (hz : z ∈ seamPlane) (hw : w ∈ seamPlane)
    (h : dist z w = 2) : residueColouring z = residueColouring w := by sorry

end FieldWall4

export FieldWall4 (seamSpan seamField seamPlane residueColouring)

open FieldWall4

/-- **Theorem B.** Every unit-distance graph drawn in `ℚ(√3, √11)²` is 4-colourable. -/
theorem four_colorable_of_seam_field :
    ((unitDistance ℂ).induce seamPlane).Colorable 4 := by sorry

/-- The subset form: any set of points with coordinates in `K` is 4-colourable. -/
theorem colorable_four_of_subset_seamPlane (S : Set ℂ) (hS : S ⊆ seamPlane) :
    ((unitDistance ℂ).induce S).Colorable 4 := by sorry

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

/-! ### The lower bound: the Moser spindle is an identity in the order -/

namespace FieldWall4

/-- `ω` inside the order. -/
def ordOmega : SeamOrder := Quad.incl (Quad.incl Quad.theta)
/-- `T` inside the order. -/
def ordTau : SeamOrder := Quad.incl Quad.theta

/-- `9ρ`, where `ρ = (5 + i√11)/6` is the Moser twist: `9ρ = 7 − ω + T + 2ωT`. -/
def rho9 : SeamOrder := 7 - ordOmega + ordTau + 2 * ordOmega * ordTau

/-- The seven Moser-spindle points, scaled by `9` into the order: the rhombus is
`{0, 1+ω, ω, 1+2ω}` and its image under the twist. -/
def spindleOrd : Fin 7 → SeamOrder :=
  ![0, 9 * (1 + ordOmega), 9 * ordOmega, 9 * (1 + 2 * ordOmega),
    rho9 * (1 + ordOmega), rho9 * ordOmega, rho9 * (1 + 2 * ordOmega)]

/-- The seven points themselves. -/
noncomputable def spindlePt (i : Fin 7) : ℂ := den (spindleOrd i) * (1 / 9)

/-- The eleven unit distances, as one identity in the order. -/
theorem spindleOrd_norm (i j : Fin 7) (h : (edgeGraph 7 moserSpindleEdges).Adj i j) :
    (spindleOrd i - spindleOrd j) * conj (spindleOrd i - spindleOrd j) = (81 : SeamOrder) := by
  sorry

theorem spindlePt_mem (i : Fin 7) : spindlePt i ∈ seamPlane := by sorry

theorem spindlePt_dist (i j : Fin 7) (h : (edgeGraph 7 moserSpindleEdges).Adj i j) :
    dist (spindlePt i) (spindlePt j) = 1 := by sorry

/-- The twist really is `(5 + i√11)/6` — the spec check that pins `rho9`. -/
theorem den_rho9 : den rho9 = 9 * FieldWall.moserTwist := by sorry

end FieldWall4

theorem four_le_chromaticNumber_seamPlane :
    4 ≤ ((unitDistance ℂ).induce seamPlane).chromaticNumber := by sorry

/-- **`χ(ℚ(√3, √11)²) = 4` exactly.** -/
theorem chromaticNumber_seamPlane :
    ((unitDistance ℂ).induce seamPlane).chromaticNumber = 4 := by sorry

end HadwigerNelson
