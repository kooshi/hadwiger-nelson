import Proofs.HadwigerNelson.UnitQuadrance
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
module doc says so; here the kernel checks it, `heule510_sevenFree`). The `√7`-free elements are the
subring `Q4.sevenFree ≅ Q3 = ℤ[√3, √5, √11]`, and the residue hom `Q3 →+* ZMod 11` exists:
`√3 ↦ 5, √5 ↦ 4, √11 ↦ 0` (`5² = 3`, `4² = 5`, `0² = 0 = 11`).

## What the kernel computes here, and what it does not

Two `decide`s: the table's 510 points are `√7`-free, and the 121-entry colouring is proper on the plane.
**No edge of Heule-510 is re-examined**: the homomorphism comes from `heule510_valid` through
`UDCert.drawing_adj`, so the 2,504 exact unit distances certified at M09 do the work a second time.

## What a consumer may conclude

`chromaticNumber_finitePlane11`: the plane's value, on the standard three axioms. Through
`reference/Chat-analysis/VERIFICATION.md` §1 (a hand proof, NOT formalized) it bounds
`χ(ℚ(√3, √5, √11)²) ≤ 5`; the kernel statement here is the certificate-level one — every `Valid`,
`√7`-free tower certificate with `11 ∤ D` is 5-colourable (`UDCert.colorable_of_unitQuadrance`).
-/

set_option maxRecDepth 100000

namespace HadwigerNelson

open SimpleGraph

/-! ### The residue hom at `11`, on the `√7`-free subring -/

instance : Fact (1 < 11) := ⟨by decide⟩

/-- `√3 ↦ 5, √5 ↦ 4, √11 ↦ 0` on `Q3`, then along `Q4.sevenFree ≅ Q3`. -/
def res11 : Q4.sevenFree →+* ZMod 11 :=
  (Q3.lift (R := ZMod 11) 5 4 0 (by decide) (by decide) (by decide)).comp Q4.sevenFree.toQ3

/-! ### Heule-510 reduces -/

/-- **P8**: the certified table is `√7`-free at all 510 points — the module doc's claim, now checked. -/
theorem heule510_sevenFree : heule510.CoordsIn Q4.sevenFree := by decide +kernel

/-- `7 · 96 = 672 = 61 · 11 + 1`: the denominator's inverse mod `11`. -/
theorem heule510_denom_inv : (7 : ZMod 11) * heule510.denom = 1 := by decide

/-- The reduction of Heule-510 into the plane at `11`. -/
def heule510Reduce : edgeGraph 510 heule510.edges →g unitQuadrance (ZMod 11) :=
  heule510.drawingHom res11 heule510_sevenFree heule510_denom_inv heule510_valid

/-! ### The plane's colouring -/

/-- The 5-colouring of `𝔽₁₁²` found by SAT and verified (`data/fplane/chi-p11.json`): row `x`, column
`y`. Untrusted data; `finitePlane11_colouring_proper` is the check. A literal, so a lookup is a walk of
depth ≤ 11 and never a rebuild. -/
def finitePlane11Table : Fin 11 → Fin 11 → Fin 5 :=
  ![![0,1,4,0,2,0,1,4,0,3,2], ![2,4,1,3,0,1,4,1,3,0,1], ![4,3,2,0,1,4,3,4,0,3,0],
    ![3,0,1,2,4,1,4,0,2,1,4], ![2,3,2,1,3,4,0,3,0,4,3], ![1,0,1,4,2,1,2,4,1,3,0],
    ![2,1,4,3,0,2,4,3,4,0,3], ![1,4,2,1,2,4,1,4,0,2,0], ![4,0,3,2,1,3,4,3,2,1,3],
    ![3,2,0,1,2,4,0,2,0,2,4], ![2,0,2,4,1,3,2,1,3,4,0]]

/-- The colouring as a function on the plane (`ZMod 11` is `Fin 11`). -/
def finitePlane11Colouring (v : ZMod 11 × ZMod 11) : Fin 5 := finitePlane11Table v.1 v.2

/-- Proper: decided over every pair of points of the plane. -/
theorem finitePlane11_colouring_proper :
    ∀ {u v : ZMod 11 × ZMod 11}, (unitQuadrance (ZMod 11)).Adj u v →
      finitePlane11Colouring u ≠ finitePlane11Colouring v := by
  decide +kernel

/-- **`χ(UD(𝔽₁₁, 2)) ≤ 5`**, by the verified table. -/
theorem finitePlane11_colorable_five : (unitQuadrance (ZMod 11)).Colorable 5 :=
  ⟨Coloring.mk finitePlane11Colouring finitePlane11_colouring_proper⟩

/-- **`χ(UD(𝔽₁₁, 2)) > 4`**: a 4-colouring of the plane would pull back to Heule-510. No solver. -/
theorem finitePlane11_not_colorable_four : ¬ (unitQuadrance (ZMod 11)).Colorable 4 :=
  fun h => heule510_not_colorable_four (Colorable.of_hom heule510Reduce h)

/-- **`χ(UD(𝔽₁₁, 2)) = 5`.** -/
theorem chromaticNumber_finitePlane11 : (unitQuadrance (ZMod 11)).chromaticNumber = 5 :=
  chromaticNumber_eq_iff_colorable_not_colorable.mpr
    ⟨finitePlane11_colorable_five, finitePlane11_not_colorable_four⟩

/-! ### Heule-510 exactly -/

/-- **`χ(Heule-510) ≤ 5`**, the plane's colouring pulled back — the first certified upper bound on a
certified 5-chromatic witness. -/
theorem heule510_colorable_five : (edgeGraph 510 heule510.edges).Colorable 5 :=
  Colorable.of_hom heule510Reduce finitePlane11_colorable_five

/-- **`χ(Heule-510) = 5` exactly.** -/
theorem chromaticNumber_heule510 : (edgeGraph 510 heule510.edges).chromaticNumber = 5 :=
  chromaticNumber_eq_iff_colorable_not_colorable.mpr
    ⟨heule510_colorable_five, heule510_not_colorable_four⟩

/-! ### The plane at `131`, through the whole tower (the general theorem used twice)

All four radicands are residues mod `131`, so `Q4.lift` exists and Heule-510 reduces with no `√7`
argument: `χ(UD(𝔽₁₃₁, 2)) ≥ 5` in the kernel. (The spectral bound says `≥ 8`; this is the free kernel
floor, and the second instance of one theorem.) -/

/-- `116 · 96 = 11136 = 85 · 131 + 1`: the denominator's inverse mod `131`. -/
theorem heule510_denom_inv131 : (116 : ZMod 131) * heule510.denom = 1 := by decide

theorem five_le_chromaticNumber_finitePlane131 : 5 ≤ (unitQuadrance (ZMod 131)).chromaticNumber :=
  heule510.add_one_le_chromaticNumber_unitQuadrance Q4.res131 heule510.coordsIn_top
    heule510_denom_inv131 heule510_valid heule510_not_colorable_four

/-! ### Reds -/

/-- A wrong root refuses the root hypothesis: `4² = 5 ≠ 3` in `ZMod 11` (the planted control of
`fplane.py self-test`, kernel side). -/
example : ¬ ((4 : ZMod 11) ^ 2 = 3) := by decide

/-- A corrupted table is refused: paint the origin with colour `1`, and its neighbour `(0, 1)` — already
colour `1` — becomes a monochromatic edge. -/
example : ∃ u v : ZMod 11 × ZMod 11, (unitQuadrance (ZMod 11)).Adj u v ∧
    Function.update finitePlane11Colouring (0, 0) 1 u = Function.update finitePlane11Colouring (0, 0) 1 v :=
  ⟨(0, 0), (0, 1), by decide, by decide⟩

end HadwigerNelson
