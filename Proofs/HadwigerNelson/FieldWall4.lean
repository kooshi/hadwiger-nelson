import Proofs.HadwigerNelson.Ladder
import Proofs.HadwigerNelson.FieldWall
import Proofs.HadwigerNelson.Instances.SpindleBound

/-!
# The field wall: `χ(ℚ(√3, √11)²) = 4`

Skeleton (B1 subplan `plans/B1-field-wall-kernel.md`). Statements first, proofs after.
-/

namespace HadwigerNelson
namespace FieldWall4

open Complex

/-! ## §1 `F4`, the four-element field -/

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

instance instCommRing : CommRing F4 where
  add_assoc := by sorry
  zero_add := by sorry
  add_zero := by sorry
  add_comm := by sorry
  neg_add_cancel := by sorry
  mul_assoc := by sorry
  one_mul := by sorry
  mul_one := by sorry
  left_distrib := by sorry
  right_distrib := by sorry
  mul_comm := by sorry
  zero_mul := by sorry
  mul_zero := by sorry
  sub_eq_add_neg := by sorry
  nsmul := nsmulRec
  zsmul := zsmulRec

/-- The primitive cube root of unity. -/
def om : F4 := ⟨0, 1⟩

theorem om_sq : om * om = om + 1 := by sorry

theorem card_eq_four : Fintype.card F4 = 4 := by sorry

theorem eq_zero_of_cube_eq_zero {x : F4} (h : x * x * x = 0) : x = 0 := by sorry

/-- The prime field `𝔽₂ ↪ F4`. -/
def emb : ZMod 2 →+* F4 where
  toFun x := ⟨x, 0⟩
  map_one' := rfl
  map_mul' := by sorry
  map_zero' := rfl
  map_add' := by sorry

theorem intCast_eq (n : ℤ) : (n : F4) = emb (n : ZMod 2) := by sorry

theorem intCast_sq (n : ℤ) : ((n : F4)) * (n : F4) = (n : F4) := by sorry

theorem intCast_odd {n : ℤ} (h : Odd n) : (n : F4) = 1 := by sorry

theorem intCast_even {n : ℤ} (h : Even n) : (n : F4) = 0 := by sorry

/-- Characteristic two, in the form the layer proofs rewrite with. -/
theorem neg_eq (x : F4) : -x = x := rfl

end F4

/-! ## §2 The generic quadratic layer -/

/-- `R[θ]` with `θ² = b·θ + c`: the element `re + im·θ`. -/
@[ext] structure Quad (b c : ℤ) (R : Type*) where
  /-- The `θ`-free component. -/
  re : R
  /-- The coefficient of `θ`. -/
  im : R

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
  add_assoc := by sorry
  zero_add := by sorry
  add_zero := by sorry
  add_comm := by sorry
  neg_add_cancel := by sorry
  sub_eq_add_neg := by sorry
  natCast_zero := by sorry
  natCast_succ := by sorry
  intCast_ofNat := by sorry
  intCast_negSucc := by sorry
  left_distrib := by sorry
  right_distrib := by sorry
  zero_mul := by sorry
  mul_zero := by sorry
  mul_assoc := by sorry
  one_mul := by sorry
  mul_one := by sorry
  mul_comm := by sorry

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
@[simp] theorem intCast_re (n : ℤ) : ((n : Quad b c R)).re = (n : R) := rfl
@[simp] theorem intCast_im (n : ℤ) : ((n : Quad b c R)).im = 0 := rfl
theorem mul_re (x y : Quad b c R) :
    (x * y).re = x.re * y.re + (c : R) * (x.im * y.im) := rfl
theorem mul_im (x y : Quad b c R) :
    (x * y).im = x.re * y.im + x.im * y.re + (b : R) * (x.im * y.im) := rfl

/-- A ring homomorphism out of the base, plus a root of `X² − bX − c` in the target, extends. -/
def lift {S : Type*} [CommRing S] (f : R →+* S) (θ : S) (hθ : θ * θ = (b : S) * θ + (c : S)) :
    Quad b c R →+* S where
  toFun x := f x.re + f x.im * θ
  map_one' := by sorry
  map_mul' := by sorry
  map_zero' := by sorry
  map_add' := by sorry

@[simp] theorem lift_apply {S : Type*} [CommRing S] (f : R →+* S) (θ : S)
    (hθ : θ * θ = (b : S) * θ + (c : S)) (x : Quad b c R) :
    lift f θ hθ x = f x.re + f x.im * θ := rfl

/-- The nontrivial involution: `θ ↦ b − θ`, with the base conjugated by `g`. -/
def conjSwap (g : R →+* R) : Quad b c R →+* Quad b c R where
  toFun x := ⟨g x.re + (b : R) * g x.im, -g x.im⟩
  map_one' := by sorry
  map_mul' := by sorry
  map_zero' := by sorry
  map_add' := by sorry

/-- The involution that fixes `θ` and conjugates the base by `g`. -/
def conjBase (g : R →+* R) : Quad b c R →+* Quad b c R where
  toFun x := ⟨g x.re, g x.im⟩
  map_one' := by sorry
  map_mul' := by sorry
  map_zero' := by sorry
  map_add' := by sorry

@[simp] theorem conjSwap_apply (g : R →+* R) (x : Quad b c R) :
    conjSwap g x = ⟨g x.re + (b : R) * g x.im, -g x.im⟩ := rfl
@[simp] theorem conjBase_apply (g : R →+* R) (x : Quad b c R) :
    conjBase g x = ⟨g x.re, g x.im⟩ := rfl

/-- Frobenius through a swapping conjugation. -/
theorem lift_conjSwap_sq (f : R →+* F4) (g : R →+* R) (s : F4)
    (hs : s * s = (b : F4) * s + (c : F4)) (hb : (b : F4) + s = s * s)
    (hf : ∀ y : R, f (g y) = f y * f y) (x : Quad b c R) :
    lift f s hs (conjSwap g x) = lift f s hs x * lift f s hs x := by sorry

/-- Frobenius through a base-fixing conjugation, when `θ` is idempotent in the target. -/
theorem lift_conjBase_sq (f : R →+* F4) (g : R →+* R) (s : F4)
    (hs : s * s = (b : F4) * s + (c : F4)) (hss : s * s = s)
    (hf : ∀ y : R, f (g y) = f y * f y) (x : Quad b c R) :
    lift f s hs (conjBase g x) = lift f s hs x * lift f s hs x := by sorry

end Quad

/-! ## §3 The order `O = ℤ[ω, i, T]` -/

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

theorem omega3_sq : omega3 * omega3 = ((-1 : ℤ) : ℂ) * omega3 + ((-1 : ℤ) : ℂ) := by sorry
theorem tau_sq : tau * tau = ((1 : ℤ) : ℂ) * tau + ((8 : ℤ) : ℂ) := by sorry
theorem I_sq : Complex.I * Complex.I = ((0 : ℤ) : ℂ) * Complex.I + ((-1 : ℤ) : ℂ) := by sorry

/-- `ℤ[ω] → ℂ`. -/
noncomputable def denE : Eis →+* ℂ := Quad.lift (Int.castRingHom ℂ) omega3 omega3_sq
/-- `ℤ[ω, T] → ℂ`. -/
noncomputable def denET : EisT →+* ℂ := Quad.lift denE tau tau_sq
/-- `O → ℂ` — the drawing of the order in the plane. -/
noncomputable def den : SeamOrder →+* ℂ := Quad.lift denET Complex.I I_sq

/-- Complex conjugation on `ℤ[ω]`: `ω ↦ −1 − ω`. -/
def conjE : Eis →+* Eis := Quad.conjSwap (RingHom.id ℤ)
/-- Complex conjugation on `ℤ[ω, T]`: `T` is real. -/
def conjET : EisT →+* EisT := Quad.conjBase conjE
/-- Complex conjugation on `O`: `i ↦ −i`. -/
def conj : SeamOrder →+* SeamOrder := Quad.conjSwap conjET

theorem den_conj (x : SeamOrder) : den (conj x) = (starRingEnd ℂ) (den x) := by sorry

/-! ### The two residue maps -/

theorem om_relE : F4.om * F4.om = ((-1 : ℤ) : F4) * F4.om + ((-1 : ℤ) : F4) := by sorry

/-- `ℤ[ω] → 𝔽₄`, `ω ↦ Ω`. -/
def psiE : Eis →+* F4 := Quad.lift (Int.castRingHom F4) F4.om om_relE

/-- `ℤ[ω, T] → 𝔽₄`, `T ↦ s`, for either idempotent `s`. -/
def psiET (s : F4) (hs : s * s = ((1 : ℤ) : F4) * s + ((8 : ℤ) : F4)) : EisT →+* F4 :=
  Quad.lift psiE s hs

theorem one_relO : (1 : F4) * 1 = ((0 : ℤ) : F4) * 1 + ((-1 : ℤ) : F4) := by sorry

/-- `O → 𝔽₄`, `i ↦ 1`, `ω ↦ Ω`, `T ↦ s`. -/
def psiO (s : F4) (hs : s * s = ((1 : ℤ) : F4) * s + ((8 : ℤ) : F4)) : SeamOrder →+* F4 :=
  Quad.lift (psiET s hs) 1 one_relO

theorem hs_zero : (0 : F4) * 0 = ((1 : ℤ) : F4) * 0 + ((8 : ℤ) : F4) := by sorry
theorem hs_one : (1 : F4) * 1 = ((1 : ℤ) : F4) * 1 + ((8 : ℤ) : F4) := by sorry

/-- The residue map at the prime with `T ↦ 0` — the colouring. -/
def psiZero : SeamOrder →+* F4 := psiO 0 hs_zero
/-- The residue map at the other prime, `T ↦ 1`. -/
def psiOne : SeamOrder →+* F4 := psiO 1 hs_one

theorem psiZero_conj (x : SeamOrder) : psiZero (conj x) = psiZero x * psiZero x := by sorry
theorem psiOne_conj (x : SeamOrder) : psiOne (conj x) = psiOne x * psiOne x := by sorry

/-! ## §4 `den` is injective -/

theorem den_injective : Function.Injective den := by sorry

/-! ## §5 The descent -/

/-- `1 + i` in the order. -/
def onePlusI : SeamOrder := ⟨1, 1⟩

theorem den_onePlusI : den onePlusI = 1 + Complex.I := by sorry

/-- **The descent.** A element of the order killed by both residue maps is divisible by `1 + i`. -/
theorem exists_mul_onePlusI {z : SeamOrder} (h0 : psiZero z = 0) (h1 : psiOne z = 0) :
    ∃ w : SeamOrder, w * onePlusI = z := by sorry

/-- An element whose norm is an even integer is killed by both residue maps. -/
theorem psi_eq_zero_of_even_norm {z : SeamOrder} {N : ℤ} (hN : Even N)
    (h : z * conj z = (N : SeamOrder)) : psiZero z = 0 ∧ psiOne z = 0 := by sorry

/-! ## §6 The seam field and its plane -/

/-- The ℚ-span of `1, √3, √11, √33` — the field `ℚ(√3, √11)`. -/
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

/-- `K²`: the complex numbers with both coordinates in `K`. -/
def seamPlane : Set ℂ := {z | z.re ∈ seamField ∧ z.im ∈ seamField}

theorem seamPlane_sub {z w : ℂ} (hz : z ∈ seamPlane) (hw : w ∈ seamPlane) :
    z - w ∈ seamPlane := by sorry

/-- Every point of `K²` has a nonzero integer multiple in the order. -/
theorem exists_int_mul_mem_range {z : ℂ} (hz : z ∈ seamPlane) :
    ∃ n : ℤ, n ≠ 0 ∧ ∃ x : SeamOrder, (n : ℂ) * z = den x := by sorry

/-! ## §7 Unit vectors lie in the order with odd denominator -/

/-- `A = O[1/odd]`, as an additive subgroup of the plane. -/
def Aodd : AddSubgroup ℂ where
  carrier := {z | ∃ m : ℤ, Odd m ∧ ∃ x : SeamOrder, (m : ℂ) * z = den x}
  zero_mem' := by sorry
  add_mem' := by sorry
  neg_mem' := by sorry

/-- **Every unit vector of `K(i)` lies in `A`** — the theorem's engine. -/
theorem mem_Aodd_of_unit {u : ℂ} (hu : u ∈ seamPlane) (h1 : normSq u = 1) : u ∈ Aodd := by sorry

/-- The residue of a point of `A`, as a total function. -/
noncomputable def psiOf (z : ℂ) : F4 :=
  open Classical in
  if h : ∃ x : SeamOrder, ∃ m : ℤ, Odd m ∧ (m : ℂ) * z = den x then psiZero h.choose else 0

theorem psiOf_eq {z : ℂ} {m : ℤ} {x : SeamOrder} (hm : Odd m) (hx : (m : ℂ) * z = den x) :
    psiOf z = psiZero x := by sorry

theorem psiOf_sub {z w : ℂ} (hz : z ∈ Aodd) (hw : w ∈ Aodd) :
    psiOf (z - w) = psiOf z - psiOf w := by sorry

theorem psiOf_ne_zero_of_unit {u : ℂ} (hu : u ∈ Aodd) (h1 : normSq u = 1) : psiOf u ≠ 0 := by sorry

/-! ## §8 The colouring -/

/-- A chosen representative of each coset of `A` in the plane. -/
noncomputable def base (z : ℂ) : ℂ := Quotient.out (QuotientAddGroup.mk' Aodd z)

theorem sub_base_mem (z : ℂ) : z - base z ∈ Aodd := by sorry

theorem base_eq_of_sub_mem {z w : ℂ} (h : z - w ∈ Aodd) : base z = base w := by sorry

/-- The residue colouring of the plane over `K`. -/
noncomputable def colour (z : ℂ) : F4 := psiOf (z - base z)

theorem colour_ne_of_unit {z w : ℂ} (hz : z ∈ seamPlane) (hw : w ∈ seamPlane)
    (h : dist z w = 1) : colour z ≠ colour w := by sorry

end FieldWall4

open FieldWall4

/-- `K = ℚ(√3, √11)`. -/
noncomputable abbrev seamField := FieldWall4.seamField
/-- `K²`, the plane over `K`. -/
abbrev seamPlane := FieldWall4.seamPlane

/-- **Theorem B.** Every unit-distance graph drawn in `ℚ(√3, √11)²` is 4-colourable. -/
theorem four_colorable_of_seam_field :
    ((unitDistance ℂ).induce seamPlane).Colorable 4 := by sorry

/-- The finite/subset form. -/
theorem colorable_four_of_coords_in_seamField (S : Set ℂ) (hS : S ⊆ seamPlane) :
    ((unitDistance ℂ).induce S).Colorable 4 := by sorry

/-! ### The lower bound: the Moser spindle is drawn in `K²` -/

namespace FieldWall4

/-- The seven points of the Moser spindle, all with coordinates in `K`. -/
noncomputable def spindlePt : Fin 7 → ℂ :=
  ![0, ⟨1/2, Real.sqrt 3 / 2⟩, ⟨-1/2, Real.sqrt 3 / 2⟩, ⟨0, Real.sqrt 3⟩,
    FieldWall.moserTwist * ⟨1/2, Real.sqrt 3 / 2⟩, FieldWall.moserTwist * ⟨-1/2, Real.sqrt 3 / 2⟩,
    FieldWall.moserTwist * ⟨0, Real.sqrt 3⟩]

theorem spindlePt_mem (i : Fin 7) : spindlePt i ∈ seamPlane := by sorry

theorem spindlePt_dist (i j : Fin 7) (h : (edgeGraph 7 moserSpindleEdges).Adj i j) :
    dist (spindlePt i) (spindlePt j) = 1 := by sorry

end FieldWall4

theorem four_le_chromaticNumber_seamPlane :
    4 ≤ ((unitDistance ℂ).induce seamPlane).chromaticNumber := by sorry

/-- **`χ(ℚ(√3, √11)²) = 4` exactly.** -/
theorem chromaticNumber_seamPlane :
    ((unitDistance ℂ).induce seamPlane).chromaticNumber = 4 := by sorry

end HadwigerNelson
