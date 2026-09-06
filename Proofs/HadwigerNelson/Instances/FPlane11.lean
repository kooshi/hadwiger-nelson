import Proofs.HadwigerNelson.FPlane
import Proofs.HadwigerNelson.Instances.Heule510.Bound

/-!
# `χ(UD(𝔽₁₁, 2)) = 5`, and `χ(Heule-510) = 5` exactly

The first exact chromatic number of a finite Euclidean plane above Vinh's `p = 7`, kernel-checked with
**no new refutation certificate**: the lower half is Heule-510's certified refusal of four colours
(`Instances/Heule510/Bound.lean`) pushed through the reduction homomorphism, the upper half is a
121-entry colouring table (`data/fplane/chi-p11.json`) decided proper. The same homomorphism pulls the
table back to Heule-510 — the kernel's first UPPER bound on a certified 5-chromatic witness — so
`χ(edgeGraph 510 heule510.edges) = 5` exactly.

## The `√7` problem, and its resolution

`7` is not a square modulo `11`, so no ring hom `Q4 →+* ZMod 11` exists. Heule's coordinates live in
`ℚ(√3, √5, √11)`, a subfield of the M02 tower whose `√7`-parts are identically zero (`Heule510.lean`'s
module doc says so; here the kernel checks it, `heule510_sevenFree`). The residue map `Q4.res11` sends
`√3 ↦ 5, √5 ↦ 4, √11 ↦ 0` and forgets the `√7`-part; it is multiplicative on `√7`-free elements
(`res11_mul`), which is all the reduction theorem needs.

## What a consumer may conclude

`chromaticNumber_fplane11`: the plane's value, on the standard three axioms. Through
`reference/Chat-analysis/VERIFICATION.md` §1 (a hand proof, NOT formalized) it bounds
`χ(ℚ(√3, √5, √11)²) ≤ 5`; the kernel statement here is the certificate-level one.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ### `√7`-free elements of the tower -/

/-- `√7`-free: both `√7`-coefficients vanish. The tower is `Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))`,
so the `√7`-part of `x` is the inner `.im` of each `√11`-component. -/
def Q4.SevenFree (x : Q4) : Prop := x.re.im = 0 ∧ x.im.im = 0

instance : DecidablePred Q4.SevenFree := fun x => inferInstanceAs (Decidable (_ ∧ _))

/-- The residue map at `11` on `ℚ(√3, √5)`: a genuine ring hom (`5² = 3`, `4² = 5` in `ZMod 11`). -/
def Q2.res11 : Adjoin 5 (Adjoin 3 ℤ) →+* ZMod 11 :=
  Adjoin.evalHom (Adjoin.evalHom (Int.castRingHom (ZMod 11)) 5 (by decide)) 4 (by decide)

/-- **The residue map at `11`**: `√11 ↦ 0` (ramified), the `√7`-part forgotten. NOT a ring hom on `Q4`;
multiplicative on `√7`-free elements (`res11_mul`), which is what the reduction uses. -/
def Q4.res11 (x : Q4) : ZMod 11 := Q2.res11 x.re.re

theorem Q4.res11_intCast (m : ℤ) : Q4.res11 (m : Q4) = (m : ZMod 11) := by sorry

theorem Q4.res11_sub (x y : Q4) : Q4.res11 (x - y) = Q4.res11 x - Q4.res11 y := by sorry

theorem Q4.res11_add (x y : Q4) : Q4.res11 (x + y) = Q4.res11 x + Q4.res11 y := by sorry

theorem Q4.SevenFree.sub {x y : Q4} (hx : x.SevenFree) (hy : y.SevenFree) : (x - y).SevenFree := by
  sorry

/-- Multiplicativity, on `√7`-free elements: the `√11`-cross terms carry a factor `11 = 0`. -/
theorem Q4.res11_mul {x y : Q4} (hx : x.SevenFree) (hy : y.SevenFree) :
    Q4.res11 (x * y) = Q4.res11 x * Q4.res11 y := by
  sorry

theorem Q4.res11_sq {x : Q4} (hx : x.SevenFree) : Q4.res11 (FastSq.sq x) = Q4.res11 x ^ 2 := by
  sorry

/-! ### The reduction at `11` -/

/-- A stored point is `√7`-free when both coordinates are. -/
def Pt.SevenFree (q : Pt) : Prop := q.x.SevenFree ∧ q.y.SevenFree

instance : DecidablePred Pt.SevenFree := fun q => inferInstanceAs (Decidable (_ ∧ _))

namespace UDCert

variable {n : ℕ}

/-- Every vertex `√7`-free — decidable over `Fin n`. -/
def SevenFree (c : UDCert n) : Prop := ∀ i, (c.verts i).SevenFree

instance (c : UDCert n) : Decidable c.SevenFree := inferInstanceAs (Decidable (∀ i, _))

/-- The residue of a stored point at `11`, divided by the residue of the denominator. -/
def reduce11 (c : UDCert n) (i : Fin n) : ZMod 11 × ZMod 11 :=
  (Q4.res11 (c.verts i).x * (Q4.res11 (c.denom : Q4))⁻¹,
   Q4.res11 (c.verts i).y * (Q4.res11 (c.denom : Q4))⁻¹)

/-- **The reduction theorem at `11`, one edge** — `FPlane.reduce_adj` with the hom hypothesis replaced
by `√7`-freeness. -/
theorem reduce11_adj (c : UDCert n) (hv : c.Valid = true) (h7 : c.SevenFree)
    (hD : Q4.res11 (c.denom : Q4) ≠ 0) {i j : Fin n} (h : (edgeGraph n c.edges).Adj i j) :
    (fplane 11).Adj (c.reduce11 i) (c.reduce11 j) := by
  sorry

/-- The reduction at `11` as a graph homomorphism. -/
def reduce11Hom (c : UDCert n) (hv : c.Valid = true) (h7 : c.SevenFree)
    (hD : Q4.res11 (c.denom : Q4) ≠ 0) : edgeGraph n c.edges →g fplane 11 where
  toFun := c.reduce11
  map_rel' h := c.reduce11_adj hv h7 hD h

end UDCert

/-! ### Heule-510 reduces -/

/-- **P8**: the certified table is `√7`-free at all 510 points — the module doc's claim, now checked. -/
theorem heule510_sevenFree : heule510.SevenFree := by sorry

/-- `96 ↦ 8 ≠ 0` in `ZMod 11`. -/
theorem heule510_denom_res11 : Q4.res11 (heule510.denom : Q4) ≠ 0 := by sorry

/-- The reduction of Heule-510 into the plane at `11`. -/
def heule510Reduce : edgeGraph 510 heule510.edges →g fplane 11 :=
  heule510.reduce11Hom heule510_valid heule510_sevenFree heule510_denom_res11

/-! ### The plane's colouring -/

/-- The 5-colouring of `𝔽₁₁²` found by SAT and verified (`data/fplane/chi-p11.json`), row `x`,
column `y`. Untrusted data; `fplane11_colouring_proper` is the check. -/
def fplane11Rows : List (List (Fin 5)) :=
  [[0,1,4,0,2,0,1,4,0,3,2], [2,4,1,3,0,1,4,1,3,0,1], [4,3,2,0,1,4,3,4,0,3,0], [3,0,1,2,4,1,4,0,2,1,4],
   [2,3,2,1,3,4,0,3,0,4,3], [1,0,1,4,2,1,2,4,1,3,0], [2,1,4,3,0,2,4,3,4,0,3], [1,4,2,1,2,4,1,4,0,2,0],
   [4,0,3,2,1,3,4,3,2,1,3], [3,2,0,1,2,4,0,2,0,2,4], [2,0,2,4,1,3,2,1,3,4,0]]

/-- The colouring as a function on the plane. -/
def fplane11Colouring (v : ZMod 11 × ZMod 11) : Fin 5 :=
  ((fplane11Rows.getD v.1.val []).getD v.2.val 0)

/-- Proper: decided over all `121 × 121` pairs. -/
theorem fplane11_colouring_proper :
    ∀ {u v : ZMod 11 × ZMod 11}, (fplane 11).Adj u v → fplane11Colouring u ≠ fplane11Colouring v := by
  sorry

/-- **`χ(UD(𝔽₁₁, 2)) ≤ 5`**, by the verified table. -/
theorem fplane11_colorable_five : (fplane 11).Colorable 5 :=
  ⟨Coloring.mk fplane11Colouring fplane11_colouring_proper⟩

/-- **`χ(UD(𝔽₁₁, 2)) > 4`**: a 4-colouring of the plane would pull back to Heule-510. No solver. -/
theorem fplane11_not_colorable_four : ¬ (fplane 11).Colorable 4 :=
  fun h => heule510_not_colorable_four (Colorable.of_hom heule510Reduce h)

/-- **`χ(UD(𝔽₁₁, 2)) = 5`.** -/
theorem chromaticNumber_fplane11 : (fplane 11).chromaticNumber = 5 :=
  chromaticNumber_eq_iff_colorable_not_colorable.mpr ⟨fplane11_colorable_five, fplane11_not_colorable_four⟩

/-! ### Heule-510 exactly -/

/-- **`χ(Heule-510) ≤ 5`**, the plane's colouring pulled back — the first certified upper bound on a
certified 5-chromatic witness. -/
theorem heule510_colorable_five : (edgeGraph 510 heule510.edges).Colorable 5 :=
  Colorable.of_hom heule510Reduce fplane11_colorable_five

/-- **`χ(Heule-510) = 5` exactly.** -/
theorem chromaticNumber_heule510 : (edgeGraph 510 heule510.edges).chromaticNumber = 5 :=
  chromaticNumber_eq_iff_colorable_not_colorable.mpr ⟨heule510_colorable_five, heule510_not_colorable_four⟩

/-! ### The plane at `131`, through the general hom (a spec of `FPlane.lean` used twice)

All four radicands are residues mod `131` (`38² = 3`, `23² = 5`, `20² = 7`, `50² = 11`), so the full
tower hom exists and Heule-510 reduces with no `√7` argument: `χ(UD(𝔽₁₃₁, 2)) ≥ 5` in the kernel.
(The spectral bound says `≥ 8`; this is the free kernel floor.) -/

instance : Fact (Nat.Prime 131) := ⟨by decide⟩

/-- The residue hom at `131`. -/
def Q4.res131 : Q4 →+* ZMod 131 := Q4.resHom 131 38 23 20 50 (by decide) (by decide) (by decide) (by decide)

theorem five_le_chromaticNumber_fplane131 : 5 ≤ (fplane 131).chromaticNumber :=
  heule510.add_one_le_chromaticNumber_fplane Q4.res131 heule510_valid (by sorry) heule510_not_colorable_four

/-! ### Reds -/

/-- A wrong root refuses the root hypothesis: `4² = 5 ≠ 3` in `ZMod 11` (the planted control of
`fplane.py self-test`, kernel side). -/
example : ¬ ((4 : ZMod 11) ^ 2 = 3) := by decide

/-- A corrupted table is refused: swap one entry and a monochromatic edge appears. -/
example : ∃ u v : ZMod 11 × ZMod 11, (fplane 11).Adj u v ∧
    (Function.update fplane11Colouring (0, 0) 1) u = (Function.update fplane11Colouring (0, 0) 1) v := by
  sorry

end HadwigerNelson
