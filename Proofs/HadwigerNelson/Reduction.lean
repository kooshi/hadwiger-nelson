import Proofs.HadwigerNelson.Certificate
import Proofs.HadwigerNelson.Sat.Encoding

/-!
# The composite — certificate plus certificate, to a bound on χ(ℝ²)

The two certified computations meet here. `Certificate.lean` turns an exact integer identity into
real unit distances; `Sat/Encoding.lean` turns an unsatisfiable formula into non-colourability;
this module composes them into the single theorem an instance module calls.

`UnitDistance.lean` holds *the* reduction — geometry to chromatic number, over an arbitrary metric
space. This file holds the call site: everything specialised to a `UDCert`, to the CNF encoding of
its own edge list, and to the plane in the shape a reader expects.

## Using this file

```lean
theorem myGraph_bound : (5 : ℕ∞) ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  myCert.add_one_le_chromaticNumber_plane_of_cubes (by decide) myCert_valid (by norm_num)
    myCubeVertices (by intro cb hcb; fin_cases hcb; exacts [cube₀_unsat, cube₁_unsat, …])
```
-/

namespace HadwigerNelson

open SimpleGraph

variable {n k : ℕ}

/-- The two models of the plane give the same chromatic number: `ℂ`, where the geometry is built
because rotation is multiplication and a point is a pair, and `EuclideanSpace ℝ (Fin 2)`, where a
reader expects the theorem.

Stated as an **equality** rather than as the one implication M03 happens to need. That is what
`chromaticNumber_unitDistance_congr` actually gives, it is one line either way, and it hands the
upper-bound direction to any later milestone that wants it (rung C's fractional and shrinking work
needs `≤` the other way). A one-directional version would have been weaker than the truth. -/
theorem chromaticNumber_plane_eq_complex :
    (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber = (unitDistance ℂ).chromaticNumber :=
  sorry

/-- **The primitive.** Exact geometry plus non-colourability, however obtained, gives a bound on the
plane. The two flavours below are this theorem composed with the two producers of `¬ Colorable`, and
`Instances/SpindleBound.lean` calls it directly for its brute-force route — three consumers, one
place where the isometry is crossed. -/
theorem UDCert.add_one_le_chromaticNumber_plane_of_valid (c : UDCert n) (hd : c.denom ≠ 0)
    (hv : c.Valid = true) (hG : ¬ (edgeGraph n c.edges).Colorable k) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber := sorry

/-- **The composite.** A valid certificate whose CNF encoding is unsatisfiable pushes the chromatic
number of the plane above `k`.

Both hypotheses are certificates in the technical sense: `hv` is decided by the kernel, `hu` comes
from an LRAT proof and carries the axiom described in `Sat/Lrat.lean`. -/
theorem UDCert.add_one_le_chromaticNumber_plane_of_unsat (c : UDCert n) (hd : c.denom ≠ 0)
    (hv : c.Valid = true) (hk : 0 < k) (hu : (colouringCNF k n c.edges).Unsat) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  c.add_one_le_chromaticNumber_plane_of_valid hd hv (not_colorable_of_unsat hk hu)

/-- **The composite, split.** The form M05 calls: the unsatisfiability obligation is discharged one
cube at a time, since the monolithic instance is out of reach for the solver. -/
theorem UDCert.add_one_le_chromaticNumber_plane_of_cubes (c : UDCert n) (hd : c.denom ≠ 0)
    (hv : c.Valid = true) (hk : 0 < k) (W : List (Fin n))
    (hu : ∀ cb ∈ allCubes k W, (colouringCNF k n c.edges ++ cubeCNF k cb).Unsat) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  c.add_one_le_chromaticNumber_plane_of_valid hd hv (not_colorable_of_cubes hk W hu)

end HadwigerNelson
