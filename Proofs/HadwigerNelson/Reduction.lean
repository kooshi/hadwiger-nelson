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

One call, and the numeral works out on its own — `((4 + 1 : ℕ) : ℕ∞)` is defeq to `5`, so no
`norm_num at h; exact h` dance is needed:

```lean
theorem myGraph_bound : (5 : ℕ∞) ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  myCert.add_one_le_chromaticNumber_plane_of_cubes myCert_valid myCubeVertices myCubes rfl
    (by intro cb hcb; fin_cases hcb; exacts [cube₀_unsat, cube₁_unsat, …])
```

`c.denom ≠ 0` and `0 < k` are `autoParam`s (`by decide`, `by norm_num`), so the two side conditions
every real certificate satisfies cost nothing to say. Pass them explicitly as `(hd := …)` /
`(hk := …)` if a symbolic denominator or colour count ever shows up.

**The cube list is supplied literally and tied down by `rfl`.** That is what makes a misfiled
certificate report `Q [(0, 2), (1, 1)]` vs `Q [(0, 1), (1, 1)]` instead of an unreduced fragment of
`allCubes`' implementation — see `not_colorable_of_cubes`. Past ~100 cubes prefer
`List.forall_iff_forall_mem.mp ⟨c₀, …⟩` to `fin_cases`: no tactic search, and it reports every
mismatched entry rather than the first.
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
theorem UDCert.add_one_le_chromaticNumber_plane_of_valid (c : UDCert n)
    (hv : c.Valid = true) (hG : ¬ (edgeGraph n c.edges).Colorable k)
    (hd : c.denom ≠ 0 := by decide) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber := sorry

/-- **The composite.** A valid certificate whose CNF encoding is unsatisfiable pushes the chromatic
number of the plane above `k`.

Both hypotheses are certificates in the technical sense: `hv` is decided by the kernel, `hu` comes
from an LRAT proof and **carries a native-evaluation axiom** — see `Sat/Lrat.lean`. Anything proved
through this theorem inherits that purchase; anything proved through
`add_one_le_chromaticNumber_plane_of_valid` with a hand proof of `hG` does not. -/
theorem UDCert.add_one_le_chromaticNumber_plane_of_unsat (c : UDCert n)
    (hv : c.Valid = true) (hu : (coloringCNF k n c.edges).Unsat)
    (hd : c.denom ≠ 0 := by decide) (hk : 0 < k := by norm_num) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  c.add_one_le_chromaticNumber_plane_of_valid hv (not_colorable_of_unsat hu hk) hd

/-- **The composite, split.** The form M05 calls: the unsatisfiability obligation is discharged one
cube at a time, since the monolithic instance is out of reach for the solver. Carries the native
axiom, once per cube. -/
theorem UDCert.add_one_le_chromaticNumber_plane_of_cubes (c : UDCert n)
    (hv : c.Valid = true) (W : List (Fin n)) (cubes : List (Cube n k))
    (hcover : allCubes k n W = cubes)
    (hu : ∀ cb ∈ cubes, (coloringCNF k n c.edges ++ cubeCNF k n cb).Unsat)
    (hd : c.denom ≠ 0 := by decide) (hk : 0 < k := by norm_num) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  c.add_one_le_chromaticNumber_plane_of_valid hv (not_colorable_of_cubes W cubes hcover hu hk) hd

end HadwigerNelson
