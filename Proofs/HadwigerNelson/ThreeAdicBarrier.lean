import Mathlib.Combinatorics.SimpleGraph.Cayley
import Mathlib.Algebra.Field.ZMod
import Proofs.HadwigerNelson.ResidueColouring
import Proofs.HadwigerNelson.Field.Quadratic

/-!
# The 3-adic barrier: the plane over `ℚ(√d)`, `d ≡ 2 (mod 3)`, with 3-integral directions is 3-colourable

FS-58 (`plans/FS58-four-colours.md` §2 D1; found for `d = 167` in `plans/FS58-prelude-seven-cycle-gadget.md` §4).

**The model.** A point of the plane over `ℚ(√d)` is a pair of `Adjoin d ℚ` — coordinates `re + im·√d` held as data, so each
point has exactly one representation and no map out of the plane needs `√d` to be irrational. The graph is `integralDirectionPlane d`,
the Cayley graph of that group on the unit vectors whose four rational coordinates have denominators prime to 3. Every
unit-distance graph over `ℚ(√d)` whose edge vectors are 3-integral is, up to translating each component, a subgraph of it.
When `d` is not a square (every `d ≡ 2 mod 3`) evaluation at `√d` identifies `Plane d` with `ℚ(√d)²` and this graph with the
unit-distance graph there restricted to those directions; that transfer to `ℂ` is not stated here, because nothing consumes it
(a colouring transfers only along an injective map, and the injectivity is the irrationality this model avoids buying).

**Why it is true.** When `d ≡ 2 (mod 3)`, reducing the coordinates modulo 3 sends `ℤ₍₃₎[√d]` onto `𝔽₉ = 𝔽₃[t]/(t² + 1)` with
`√d ↦ t`. A 3-integral unit vector `(a + b√d, c + e√d)` reduces to a point of the eight-point circle of `𝔽₉²`, and on that
circle `a + b + c` never vanishes (`circle_kappa_ne_zero`, 81 cases). So `kappa` — the additive map `(a + b + c) mod 3` on the
3-integral vectors — is nonzero on every edge vector, and Theorem A (`colorable_of_residue`) three-colours the graph, at every
size and with no solver. **Consequence (FS-58):** a four-chromatic unit-distance graph over such a field has an edge whose
direction has 3 in a denominator.

SKELETON (WORKFLOW step 3): statements only; every `sorry` is a tracked leaf of FS-58 phase D.
-/

namespace HadwigerNelson.ThreeAdicBarrier

open SimpleGraph

/-- `ℚ`'s scalar action for `Adjoin d ℚ`: ordinary multiplication, as for `ℤ` (`Field/Quadratic.lean`). Declared here, in
a leaf module, so that `Field/Quadratic.lean` — which the certificates import — is not touched. -/
instance : NatScalar ℚ where
  smul n x := (n : ℚ) * x
  smul_eq _ _ := rfl

/-- **The plane over `ℚ(√d)`**, coordinates as data. -/
abbrev Plane (d : ℕ) : Type := Adjoin d ℚ × Adjoin d ℚ

/-- A rational is **3-integral** when its denominator is prime to 3, i.e. nonzero in `ZMod 3`. -/
def IsThreeIntegral (q : ℚ) : Prop := ((q.den : ℕ) : ZMod 3) ≠ 0

/-- **The 3-integral rationals** `ℤ₍₃₎`, a subring: denominators of sums and products divide products of denominators
(`Rat.add_den_dvd`, `Rat.mul_den_dvd`). -/
def threeIntegralRat : Subring ℚ where
  carrier := {q | IsThreeIntegral q}
  add_mem' := sorry
  mul_mem' := sorry
  zero_mem' := sorry
  one_mem' := sorry
  neg_mem' := sorry

/-- **Reduction modulo 3** on `ℤ₍₃₎`: `Rat.cast` into the field `ZMod 3`, a ring homomorphism there because the casts of
sums and products agree once denominators do not vanish (`Rat.cast_add_of_ne_zero`, `Rat.cast_mul_of_ne_zero`). -/
noncomputable def toZModThree : threeIntegralRat →+* ZMod 3 := sorry

/-- The reduction is the cast. -/
@[simp] theorem toZModThree_apply (q : threeIntegralRat) : toZModThree q = ((q : ℚ) : ZMod 3) := sorry

/-- **The 3-integral vectors**: all four rational coordinates 3-integral. -/
def threeIntegral (d : ℕ) : AddSubgroup (Plane d) where
  carrier := {v | IsThreeIntegral v.1.re ∧ IsThreeIntegral v.1.im ∧ IsThreeIntegral v.2.re ∧ IsThreeIntegral v.2.im}
  add_mem' := sorry
  zero_mem' := sorry
  neg_mem' := sorry

/-- **The linear rule** `a + b + c (mod 3)` for `v = (a + b√d, c + e√d)`, each rational reduced by `toZModThree`. -/
noncomputable def kappa (d : ℕ) : threeIntegral d →+ ZMod 3 := sorry

/-- The rule, on coordinates. -/
@[simp] theorem kappa_apply {d : ℕ} (v : threeIntegral d) :
    kappa d v = ((v : Plane d).1.re : ZMod 3) + ((v : Plane d).1.im : ZMod 3) + ((v : Plane d).2.re : ZMod 3) := sorry

/-- **The eight-point circle of `𝔽₉²` misses the kernel of the rule**, in the shape the reduction produces: a 3-integral unit
vector `(a + b√d, c + e√d)` has `a² + d·b² + c² + d·e² = 1` and `2ab + 2ce = 0`, which modulo 3 with `d ≡ 2` read as below;
on those 8 of the 81 component tuples `a + b + c ≠ 0`. -/
theorem circle_kappa_ne_zero :
    ∀ a b c e : ZMod 3, a ^ 2 + 2 * b ^ 2 + c ^ 2 + 2 * e ^ 2 = 1 → 2 * a * b + 2 * c * e = 0 → a + b + c ≠ 0 := sorry

/-- **The unit condition reduced**: a 3-integral unit vector's components satisfy the circle equations of `𝔽₉²` in `ZMod 3`
when `d ≡ 2 (mod 3)`. -/
theorem unit_reduce {d : ℕ} (hd : d % 3 = 2) {v : Plane d} (hv : v.1 ^ 2 + v.2 ^ 2 = 1) (h3 : v ∈ threeIntegral d) :
    (v.1.re : ZMod 3) ^ 2 + 2 * (v.1.im : ZMod 3) ^ 2 + (v.2.re : ZMod 3) ^ 2 + 2 * (v.2.im : ZMod 3) ^ 2 = 1 ∧
      2 * (v.1.re : ZMod 3) * (v.1.im : ZMod 3) + 2 * (v.2.re : ZMod 3) * (v.2.im : ZMod 3) = 0 := sorry

/-- **The rule never vanishes on a 3-integral unit vector** when `d ≡ 2 (mod 3)`. -/
theorem kappa_ne_zero {d : ℕ} (hd : d % 3 = 2) {v : Plane d} (hv : v.1 ^ 2 + v.2 ^ 2 = 1) (h3 : v ∈ threeIntegral d) :
    kappa d ⟨v, h3⟩ ≠ 0 := sorry

/-- **The congruence is used** — the adversarial member for `kappa_ne_zero`. At `d = 3` (ramified at 3) the vector
`(−√3/2, 1/2)` is a 3-integral unit vector on which the rule vanishes. (The barrier's *conclusion* still holds at
`d ≡ 0, 1 (mod 3)`, where the whole plane is 3-coloured through its residue plane at 3, `[Moorhouse2010]` Cor. 8.3, by a
different rule; that prior art is not restated here.) -/
def vanishingVectorThree : Plane 3 := (⟨0, -1 / 2⟩, ⟨1 / 2, 0⟩)

/-- `vanishingVectorThree` is 3-integral (every denominator is 1 or 2). -/
theorem vanishingVectorThree_mem : vanishingVectorThree ∈ threeIntegral 3 := sorry

/-- `vanishingVectorThree` is a unit vector: `3/4 + 1/4 = 1`. -/
theorem vanishingVectorThree_unit : vanishingVectorThree.1 ^ 2 + vanishingVectorThree.2 ^ 2 = 1 := sorry

/-- …and the rule vanishes on it: `0 + (−1/2) + 1/2 = 0`. So `kappa_ne_zero` needs `d ≡ 2 (mod 3)`. -/
theorem kappa_vanishingVectorThree : kappa 3 ⟨vanishingVectorThree, vanishingVectorThree_mem⟩ = 0 := sorry

/-- **The plane over `ℚ(√d)` with only its 3-integral directions**: the Cayley graph of `Plane d` on the unit vectors in
`threeIntegral d`. -/
def integralDirectionPlane (d : ℕ) : SimpleGraph (Plane d) :=
  addCayley {v : Plane d | v.1 ^ 2 + v.2 ^ 2 = 1 ∧ v ∈ threeIntegral d}

/-- **The 3-adic barrier.** For `d ≡ 2 (mod 3)`, the plane over `ℚ(√d)` restricted to 3-integral directions is 3-colourable. -/
theorem colorable_three_integralDirectionPlane {d : ℕ} (hd : d % 3 = 2) : (integralDirectionPlane d).Colorable 3 := sorry

/-- A 3-integral unit vector of `ℚ(√167)` outside `ℚ(i)`: a diamond side of the prelude's seven-cycle,
`((−15 − 7√167)/140, (105 − √167)/140)`. -/
def diamond167 : Plane 167 := (⟨-15 / 140, -7 / 140⟩, ⟨105 / 140, -1 / 140⟩)

/-- **The model of the barrier's graph has edges**: `diamond167` is a 3-integral unit vector, so the origin and it are
adjacent in `integralDirectionPlane 167`, and the three colours are spent on a graph that is not empty. -/
theorem integralDirectionPlane_adj_diamond167 : (integralDirectionPlane 167).Adj 0 diamond167 := sorry

end HadwigerNelson.ThreeAdicBarrier
