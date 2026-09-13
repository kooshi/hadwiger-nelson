import Proofs.HadwigerNelson.ResidueObstruction
import Proofs.HadwigerNelson.LocalGlobal

/-!
# The 2-adic residue tower of the seam field, level by level, ring-free

`K = ℚ(√3, √11)`; at a prime `𝔓` of `K(i)` above `2` the completion is `ℚ₂(√3, ζ₃)` with integers `O = ℤ₂[ω][√3]`,
`ω² = −1 − ω`, uniformiser `π = 1 + √3`, `𝔓² = (2)`, residue field `𝔽₄`. The **level-`m` residue plane** is the Cayley
graph `P_m = Cay(O/𝔓^m, S_m)`, `S_m = {z : z·z̄ = 1}` — the COMPLEX form (Theorem B's `K₄` at level one), because at `2`
the coordinates of a unit vector are not integral, only `z = x + iy` is.

**The representation (FS-38 §S3, [hand 1]).** `O/𝔓^m ≅ (ℤ/2^⌈m/2⌉)[ω] ⊕ π·(ℤ/2^⌊m/2⌋)[ω]` as additive groups —
`z = A + πB`, `A = a + bω`, `B = c + dω` — from `π² = 2 + 2π`; the norm is the integer form
`N(z) = (a² − ab + b² + 2(c² − cd + d²)) + π·(2ac − ad − bc + 2bd + 2(c² − cd + d²))`. So the circle is a decidable
predicate on a product of `ZMod`s and the graph is Mathlib's `addCayley` — no ring is built. The identification with the
ring `O/𝔓^m` is a hand derivation recorded in the plan; validated at `m = 1..7` by `|S_m| = 3·2^{m−1}`, by two
perturbations of the formula that break the count, and — the discriminating control — by coincidence with an
independently built graph at levels `4` and `5`. Conjugation and multiplication by `ω` are additive automorphisms
preserving the circle; the level map `m + 1 → m` reduces both components.

**What is stated here** is structure only; the colourings are in `Instances/TwoAdicFour.lean` (level 4 is pairwise free,
a short list of tables) and `Instances/TwoAdicFive.lean` (level 5 forces exactly the kernel of the level map, one
LRAT refusal plus the `ω`-orbit). **[hand 2]**: that a `K`-certificate translated to the origin draws into `P_m` is the
`𝔓`-integrality of `z` for unit vectors, row 57's gap; nothing here draws a certificate.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ### The additive group of a level -/

/-- `O/𝔓^m` as an additive group: `((a, b), (c, d))` for `(a + bω) + π(c + dω)`, `a, b` modulo `2^⌈m/2⌉` and `c, d`
modulo `2^⌊m/2⌋`. -/
abbrev TwoAdicLevel (m : ℕ) : Type :=
  (ZMod (2 ^ ((m + 1) / 2)) × ZMod (2 ^ ((m + 1) / 2))) × (ZMod (2 ^ (m / 2)) × ZMod (2 ^ (m / 2)))

example : TwoAdicLevel 1 = ((ZMod 2 × ZMod 2) × (ZMod 1 × ZMod 1)) := rfl
example : TwoAdicLevel 4 = ((ZMod 4 × ZMod 4) × (ZMod 4 × ZMod 4)) := rfl
example : TwoAdicLevel 5 = ((ZMod 8 × ZMod 8) × (ZMod 4 × ZMod 4)) := rfl

/-- The real part of the norm, `a² − ab + b² + 2(c² − cd + d²)`, on canonical representatives. -/
def twoAdicNormRe (m : ℕ) (z : TwoAdicLevel m) : ℤ :=
  let a : ℤ := z.1.1.val
  let b : ℤ := z.1.2.val
  let c : ℤ := z.2.1.val
  let d : ℤ := z.2.2.val
  a * a - a * b + b * b + 2 * (c * c - c * d + d * d)

/-- The `π`-part of the norm, `2ac − ad − bc + 2bd + 2(c² − cd + d²)`. -/
def twoAdicNormPi (m : ℕ) (z : TwoAdicLevel m) : ℤ :=
  let a : ℤ := z.1.1.val
  let b : ℤ := z.1.2.val
  let c : ℤ := z.2.1.val
  let d : ℤ := z.2.2.val
  2 * a * c - a * d - b * c + 2 * b * d + 2 * (c * c - c * d + d * d)

/-- **The circle `S_m`**: norm `≡ 1 (mod 𝔓^m)`, i.e. real part `≡ 1` modulo `2^⌈m/2⌉` and `π`-part `≡ 0` modulo
`2^⌊m/2⌋`. -/
def twoAdicCircle (m : ℕ) : Set (TwoAdicLevel m) :=
  {z | twoAdicNormRe m z % ((2 : ℤ) ^ ((m + 1) / 2)) = 1 ∧ twoAdicNormPi m z % ((2 : ℤ) ^ (m / 2)) = 0}

instance (m : ℕ) : DecidablePred (· ∈ twoAdicCircle m) := fun z =>
  inferInstanceAs (Decidable (twoAdicNormRe m z % ((2 : ℤ) ^ ((m + 1) / 2)) = 1 ∧
    twoAdicNormPi m z % ((2 : ℤ) ^ (m / 2)) = 0))

/-- **The level-`m` residue plane** `P_m = Cay(O/𝔓^m, S_m)`. -/
def twoAdicPlane (m : ℕ) : SimpleGraph (TwoAdicLevel m) := addCayley (twoAdicCircle m)

instance (m : ℕ) : DecidableRel (twoAdicPlane m).Adj :=
  inferInstanceAs (DecidableRel (addCayley (twoAdicCircle m)).Adj)

/-- `|S_m| = 3·2^{m−1}`, the spec check at the levels the kernel decides cheaply. -/
example : (Finset.univ.filter (· ∈ twoAdicCircle 1)).card = 3 := by decide
example : (Finset.univ.filter (· ∈ twoAdicCircle 2)).card = 6 := by decide
example : (Finset.univ.filter (· ∈ twoAdicCircle 3)).card = 12 := by decide

/-- `|S_4| = 24`, `|S_5| = 48`: the same count at the two levels the instance modules use. -/
theorem twoAdicCircle_four_card : (Finset.univ.filter (· ∈ twoAdicCircle 4)).card = 24 := by
  sorry

theorem twoAdicCircle_five_card : (Finset.univ.filter (· ∈ twoAdicCircle 5)).card = 48 := by
  sorry

/-! ### Symmetries -/

/-- Conjugation `ω ↦ −1 − ω`, `π ↦ π`: `((a, b), (c, d)) ↦ ((a − b, −b), (c − d, −d))`. -/
def twoAdicConj (m : ℕ) : TwoAdicLevel m →+ TwoAdicLevel m where
  toFun z := ((z.1.1 - z.1.2, -z.1.2), (z.2.1 - z.2.2, -z.2.2))
  map_zero' := by simp
  map_add' x y := by ext <;> simp <;> ring

/-- Multiplication by the unit `ω`: `((a, b), (c, d)) ↦ ((−b, a − b), (−d, c − d))`. -/
def twoAdicOmega (m : ℕ) : TwoAdicLevel m →+ TwoAdicLevel m where
  toFun z := ((-z.1.2, z.1.1 - z.1.2), (-z.2.2, z.2.1 - z.2.2))
  map_zero' := by simp
  map_add' x y := by ext <;> simp <;> ring

theorem twoAdicOmega_mem_circle (m : ℕ) {z : TwoAdicLevel m} (h : z ∈ twoAdicCircle m) :
    twoAdicOmega m z ∈ twoAdicCircle m := by
  sorry

theorem twoAdicConj_mem_circle (m : ℕ) {z : TwoAdicLevel m} (h : z ∈ twoAdicCircle m) :
    twoAdicConj m z ∈ twoAdicCircle m := by
  sorry

/-- Multiplication by `ω` as a graph endomorphism (an automorphism; `Forces.map` consumes it). -/
def twoAdicOmegaHom (m : ℕ) : twoAdicPlane m →g twoAdicPlane m where
  toFun := twoAdicOmega m
  map_rel' := by
    sorry

/-! ### The level maps -/

/-- The reduction `O/𝔓^{m+1} → O/𝔓^m`: both components cast down. -/
def twoAdicLevelMap (m : ℕ) : TwoAdicLevel (m + 1) →+ TwoAdicLevel m :=
  ((ZMod.castHom (pow_dvd_pow 2 (by omega : (m + 1) / 2 ≤ (m + 1 + 1) / 2)) (ZMod (2 ^ ((m + 1) / 2)))).toAddMonoidHom.prodMap
    (ZMod.castHom (pow_dvd_pow 2 (by omega : (m + 1) / 2 ≤ (m + 1 + 1) / 2)) (ZMod (2 ^ ((m + 1) / 2)))).toAddMonoidHom).prodMap
  ((ZMod.castHom (pow_dvd_pow 2 (by omega : m / 2 ≤ (m + 1) / 2)) (ZMod (2 ^ (m / 2)))).toAddMonoidHom.prodMap
    (ZMod.castHom (pow_dvd_pow 2 (by omega : m / 2 ≤ (m + 1) / 2)) (ZMod (2 ^ (m / 2)))).toAddMonoidHom)

/-- The circle reduces into the circle: `S_{m+1} → S_m`. -/
theorem twoAdicLevelMap_mem_circle (m : ℕ) {z : TwoAdicLevel (m + 1)} (h : z ∈ twoAdicCircle (m + 1)) :
    twoAdicLevelMap m z ∈ twoAdicCircle m := by
  sorry

/-- **The level map is a graph homomorphism** `P_{m+1} →g P_m` — the tower's structure maps; no fibre carries an
edge (a difference in `𝔓^m` has norm in `𝔓^{2m}`, never `1`). -/
def twoAdicLevelHom (m : ℕ) : twoAdicPlane (m + 1) →g twoAdicPlane m where
  toFun := twoAdicLevelMap m
  map_rel' := by
    sorry

/-! ### Level one is the clique, and it has no gap -/

/-- **Level one is `K₄` and has no gap at four colours**: every proper 4-colouring of `P₁` shows all three other
colours on every neighbourhood — the 2-adic side of the dichotomy at level one (`decide` over the 256 functions). -/
theorem twoAdicPlane_one_no_fanGap :
    ∀ f : TwoAdicLevel 1 → Fin 4, (∀ u v, (twoAdicPlane 1).Adj u v → f u ≠ f v) →
      ∀ γ : Fin 4, ¬ (γ ≠ f 0 ∧ ∀ w, (twoAdicPlane 1).Adj 0 w → f w ≠ γ) := by
  sorry

end HadwigerNelson
