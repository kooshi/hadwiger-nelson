import Proofs.HadwigerNelson.Ladder
import Proofs.HadwigerNelson.FieldWall
import Proofs.HadwigerNelson.Instances.SpindleBound

/-!
# The field wall: `χ(ℚ(√3, √11)²) = 4`

Skeleton (B1 subplan `plans/B1-field-wall-kernel.md`, after the domain-modeling pass §6).
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
instance : NatCast F4 := ⟨fun n => ⟨(n : ZMod 2), 0⟩⟩
instance : IntCast F4 := ⟨fun n => ⟨(n : ZMod 2), 0⟩⟩

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
  natCast_zero := by sorry
  natCast_succ := by sorry
  intCast_ofNat := by sorry
  intCast_negSucc := by sorry
  nsmul := nsmulRec
  zsmul := zsmulRec

/-- The primitive cube root of unity. -/
def om : F4 := ⟨0, 1⟩

theorem card_eq_four : Fintype.card F4 = 4 := by sorry

theorem eq_zero_of_cube_eq_zero {x : F4} (h : x * (x * x) = 0) : x = 0 := by sorry

/-- **Frobenius.** Squaring is a ring homomorphism, because the characteristic is two. -/
def sq : F4 →+* F4 where
  toFun x := x * x
  map_one' := by sorry
  map_mul' := by sorry
  map_zero' := by sorry
  map_add' := by sorry

@[simp] theorem sq_apply (x : F4) : sq x = x * x := rfl

theorem intCast_sq (n : ℤ) : ((n : ℤ) : F4) * ((n : ℤ) : F4) = ((n : ℤ) : F4) := by sorry

theorem intCast_odd {n : ℤ} (h : Odd n) : (n : F4) = 1 := by sorry

theorem intCast_even {n : ℤ} (h : Even n) : (n : F4) = 0 := by sorry

end F4

/-! ## §2 The generic quadratic layer -/

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

/-! ### The universal property -/

/-- The base ring sits inside the layer. -/
def incl : R →+* Quad b c R where
  toFun r := ⟨r, 0⟩
  map_one' := rfl
  map_mul' := by sorry
  map_zero' := rfl
  map_add' := by sorry

/-- The adjoined root. -/
def theta : Quad b c R := ⟨0, 1⟩

@[simp] theorem incl_apply (r : R) : (incl r : Quad b c R) = ⟨r, 0⟩ := rfl

theorem theta_sq : (theta : Quad b c R) * theta = (b : Quad b c R) * theta + (c : Quad b c R) := by
  sorry

/-- Every element is `re + im·θ` — the decomposition `hom_ext` runs on. -/
theorem decomp (x : Quad b c R) : x = incl x.re + incl x.im * theta := by sorry

/-- **Two ring homomorphisms out of the layer agree as soon as they agree on the base and on
`θ`.** The recursor this file's compatibility lemmas live inside. -/
theorem hom_ext {S : Type*} [CommRing S] {f g : Quad b c R →+* S}
    (hbase : f.comp incl = g.comp incl) (hθ : f theta = g theta) : f = g := by sorry

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

@[simp] theorem lift_theta {S : Type*} [CommRing S] (f : R →+* S) (θ : S)
    (hθ : θ * θ = (b : S) * θ + (c : S)) : lift f θ hθ theta = θ := by sorry

@[simp] theorem lift_comp_incl {S : Type*} [CommRing S] (f : R →+* S) (θ : S)
    (hθ : θ * θ = (b : S) * θ + (c : S)) : (lift f θ hθ).comp incl = f := by sorry

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

@[simp] theorem conjSwap_comp_incl (g : R →+* R) :
    (conjSwap (b := b) (c := c) g).comp incl = incl.comp g := by sorry
@[simp] theorem conjBase_comp_incl (g : R →+* R) :
    (conjBase (b := b) (c := c) g).comp incl = incl.comp g := by sorry
@[simp] theorem conjSwap_theta (g : R →+* R) :
    conjSwap (b := b) (c := c) g theta = (b : Quad b c R) - theta := by sorry
@[simp] theorem conjBase_theta (g : R →+* R) :
    conjBase (b := b) (c := c) g theta = theta := by sorry

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

theorem denE_comp_conjE : denE.comp conjE = (starRingEnd ℂ).comp denE := by sorry
theorem denET_comp_conjET : denET.comp conjET = (starRingEnd ℂ).comp denET := by sorry
theorem den_comp_conj : den.comp conj = (starRingEnd ℂ).comp den := by sorry

theorem den_conj (x : SeamOrder) : den (conj x) = (starRingEnd ℂ) (den x) := by sorry

/-! ### The two residue maps -/

theorem om_rel : F4.om * F4.om = ((-1 : ℤ) : F4) * F4.om + ((-1 : ℤ) : F4) := by sorry

/-- `ℤ[ω] → 𝔽₄`, `ω ↦ Ω`. -/
def psiE : Eis →+* F4 := Quad.lift (Int.castRingHom F4) F4.om om_rel

theorem one_rel : (1 : F4) * 1 = ((0 : ℤ) : F4) * 1 + ((-1 : ℤ) : F4) := by sorry

/-- The residue map of the order at one of the two primes above `2`: `ω ↦ Ω`, `i ↦ 1`, `T ↦ s`,
for either idempotent `s ∈ {0, 1}`. -/
def psi (s : F4) (hs : s * s = ((1 : ℤ) : F4) * s + ((8 : ℤ) : F4)) : SeamOrder →+* F4 :=
  Quad.lift (Quad.lift psiE s hs) 1 one_rel

theorem hs_zero : (0 : F4) * 0 = ((1 : ℤ) : F4) * 0 + ((8 : ℤ) : F4) := by sorry
theorem hs_one : (1 : F4) * 1 = ((1 : ℤ) : F4) * 1 + ((8 : ℤ) : F4) := by sorry

/-- The residue map at the prime with `T ↦ 0` — the one that colours. -/
def psiZero : SeamOrder →+* F4 := psi 0 hs_zero
/-- The residue map at the other prime, `T ↦ 1`. -/
def psiOne : SeamOrder →+* F4 := psi 1 hs_one

/-- **Conjugation induces Frobenius on the residue field** — the whole content of "complex
conjugation fixes each prime above `2`". -/
theorem psi_comp_conj (s : F4) (hs : s * s = ((1 : ℤ) : F4) * s + ((8 : ℤ) : F4))
    (hss : s * s = s) : (psi s hs).comp conj = F4.sq.comp (psi s hs) := by sorry

theorem psiZero_conj (x : SeamOrder) : psiZero (conj x) = psiZero x * psiZero x := by sorry
theorem psiOne_conj (x : SeamOrder) : psiOne (conj x) = psiOne x * psiOne x := by sorry

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

theorem seamPlane_sub {z w : ℂ} (hz : z ∈ seamPlane) (hw : w ∈ seamPlane) :
    z - w ∈ seamPlane := by sorry

theorem den_mem_seamPlane (x : SeamOrder) : den x ∈ seamPlane := by sorry

theorem seamPlane_ratMul {z : ℂ} (hz : z ∈ seamPlane) (q : ℚ) : (q : ℂ) * z ∈ seamPlane := by sorry

/-- Every point of `K²` has a nonzero integer multiple in the order. -/
theorem exists_nat_mul_mem_range {z : ℂ} (hz : z ∈ seamPlane) :
    ∃ n : ℕ, 0 < n ∧ ∃ x : SeamOrder, (n : ℂ) * z = den x := by sorry

/-! ## §7 Unit vectors lie in the order with odd denominator -/

/-- `A = O[1/odd]`: a point with an odd integer multiple in the order. -/
def IsAodd (z : ℂ) : Prop := ∃ x : SeamOrder, ∃ m : ℤ, Odd m ∧ (m : ℂ) * z = den x

/-- `A`, as a subring of the plane. -/
def Aodd : Subring ℂ where
  carrier := {z | IsAodd z}
  zero_mem' := by sorry
  one_mem' := by sorry
  add_mem' := by sorry
  neg_mem' := by sorry
  mul_mem' := by sorry

theorem mem_Aodd_iff {z : ℂ} : z ∈ Aodd ↔ IsAodd z := Iff.rfl

/-- **Every unit vector of `K(i)` lies in `A`** — the theorem's engine. -/
theorem mem_Aodd_of_unit {u : ℂ} (hu : u ∈ seamPlane) (h1 : normSq u = 1) : u ∈ Aodd := by sorry

/-- The residue of a point of `A`, as a total function. Sealed: reason through `psiOf_eq`. -/
noncomputable def psiOf (z : ℂ) : F4 :=
  open Classical in if h : IsAodd z then psiZero h.choose else 0

theorem psiOf_eq {z : ℂ} {m : ℤ} {x : SeamOrder} (hm : Odd m) (hx : (m : ℂ) * z = den x) :
    psiOf z = psiZero x := by sorry

theorem psiOf_sub {z w : ℂ} (hz : z ∈ Aodd) (hw : w ∈ Aodd) :
    psiOf (z - w) = psiOf z - psiOf w := by sorry

theorem psiOf_ne_zero_of_unit {u : ℂ} (hu : u ∈ Aodd) (h1 : normSq u = 1) : psiOf u ≠ 0 := by sorry

/-! ## §8 The colouring -/

/-- A chosen representative of each coset of `A` in the plane. -/
noncomputable def base (z : ℂ) : ℂ :=
  Quotient.out (QuotientAddGroup.mk' Aodd.toAddSubgroup z)

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

/-- The subset form: any set of points with coordinates in `K` is 4-colourable. -/
theorem colorable_four_of_subset_seamPlane (S : Set ℂ) (hS : S ⊆ seamPlane) :
    ((unitDistance ℂ).induce S).Colorable 4 := by sorry

/-! ### The lower bound: the Moser spindle is an identity in the order -/

namespace FieldWall4

/-- `ω` inside the order. -/
def w : SeamOrder := Quad.incl (Quad.incl Quad.theta)
/-- `T` inside the order. -/
def tt : SeamOrder := Quad.incl Quad.theta

/-- `9ρ`, where `ρ = (5 + i√11)/6` is the Moser twist: `9ρ = 7 − ω + T + 2ωT`. -/
def rho9 : SeamOrder := 7 - w + tt + 2 * w * tt

/-- The seven Moser-spindle points, scaled by `9` into the order: the rhombus is
`{0, 1+ω, ω, 1+2ω}` and its image under the twist. -/
def spindleOrd : Fin 7 → SeamOrder :=
  ![0, 9 * (1 + w), 9 * w, 9 * (1 + 2 * w),
    rho9 * (1 + w), rho9 * w, rho9 * (1 + 2 * w)]

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
