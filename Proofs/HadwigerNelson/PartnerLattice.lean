import Proofs.HadwigerNelson.Glue

/-! # The partner lattice is complete for unit pairs (M50)

The kill engine (`tools/killengine.py`, M49 §R8) enumerates candidate points for unit-distance
halos as intersections of unit circles about pairs of object points — the *partner lattice* — and
its census claims lean on one fact: **a point at unit distance from two distinct points has
nowhere else to be**. This module is that fact as a theorem, the depth-one completeness the
engine's "in any field" claims cite.

The statement is pointwise, and that is where the hypotheses vanish (M50 §Bʹ): both annulus bounds
of `Glue.sphere_inter_sphere` are derivable from the witness itself — `|r₁ − r₂| ≤ dist x y` by the
reverse triangle inequality, and `dist x y ≤ dist x p + dist p y = r₁ + r₂` by the triangle
inequality through `p` — so only `x ≠ y` remains, and it is genuinely load-bearing (at `x = y` the
intersection is a whole circle). At `dist x y = r₁ + r₂` the glue point and its mirror coincide and
the disjunction holds degenerately.

**The radii are arbitrary** (consolidation, 2026-09-09). `eq_gluePoint_of_dist_pair` is the general
form and `eq_gluePoint_of_unit_pair` its `(1, 1)` corollary — the widening is free, because the
derivation above never used the value `1`. What it buys is downstream: `CriticalSet.lean`'s plane
corollary drops its unit-edge hypothesis entirely, since the radii can simply be read off the
point, so it now covers the `{1, d}` two-distance objects of the descent as well as unit-distance
drawings.

The finiteness corollary is the census's consumer shape: over a finite vertex set, only finitely
many points of the plane have two distinct unit neighbours in it (at most two per pair — the bound
stays prose; finiteness is what the claims cite).
-/

namespace HadwigerNelson
namespace Glue

/-- **Depth-one completeness, pointwise, at any pair of radii.** A point at distances `r₁` and `r₂`
from two DISTINCT points is the glue point of those two circles or its mirror — and there is no
other hypothesis, because **both annulus bounds of `Glue.sphere_inter_sphere` are derived from the
witness itself**: `dist x y ≤ dist x p + dist p y = r₁ + r₂` by the triangle inequality through `p`,
and `|r₁ − r₂| = |dist x p − dist y p| ≤ dist x y` by the reverse one. So the generalized statement
carries no more hypotheses than the unit-radius one it replaces, and `x ≠ y` is the only thing it
asks — genuinely load-bearing, since at `x = y` the intersection is a whole circle.

Nor is radius non-negativity needed here, where `sphere_inter_sphere` had to derive it: `hx` and
`hy` supply it. Calling with `rfl, rfl` reads the radii off the point, which is the form
`CriticalSet.lean`'s plane corollary uses to drop its unit-edge hypothesis altogether. The kill
engine's "single-point kills live in the partner lattice, in any field" as a theorem. -/
theorem eq_gluePoint_of_dist_pair {p x y : ℂ} (hne : x ≠ y) {r₁ r₂ : ℝ}
    (hx : dist p x = r₁) (hy : dist p y = r₂) :
    p = gluePoint x y r₁ r₂ ∨ p = reflAxis x y (gluePoint x y r₁ r₂) := by
  have hhi : dist x y ≤ r₁ + r₂ := by
    calc dist x y ≤ dist x p + dist p y := dist_triangle x p y
    _ = r₁ + r₂ := by rw [dist_comm x p, hx, hy]
  have hlo : |r₁ - r₂| ≤ dist x y := by
    have := abs_dist_sub_le x y p
    rwa [dist_comm x p, dist_comm y p, hx, hy] at this
  have hmem : p ∈ Metric.sphere x r₁ ∩ Metric.sphere y r₂ :=
    ⟨Metric.mem_sphere.mpr hx, Metric.mem_sphere.mpr hy⟩
  rw [sphere_inter_sphere hne hlo hhi] at hmem
  simpa using hmem

/-- **Depth-one completeness at unit radii** — the `r₁ = r₂ = 1` reading of
`eq_gluePoint_of_dist_pair`, and the form the kill engine's census consumes. -/
theorem eq_gluePoint_of_unit_pair {p x y : ℂ} (hne : x ≠ y)
    (hx : dist p x = 1) (hy : dist p y = 1) :
    p = gluePoint x y 1 1 ∨ p = reflAxis x y (gluePoint x y 1 1) :=
  eq_gluePoint_of_dist_pair hne hx hy

/-- **The depth-one candidate space over a finite set is finite**: only finitely many points of
the plane have two distinct unit neighbours in `V` — the census's "the whole single-point kill
space is enumerable" as a theorem (each candidate is one of the two glue points of a pair). -/
theorem finite_two_unit_neighbors (V : Finset ℂ) :
    {p : ℂ | ∃ x ∈ V, ∃ y ∈ V, x ≠ y ∧ dist p x = 1 ∧ dist p y = 1}.Finite := by
  refine Set.Finite.subset (Set.Finite.biUnion (V ×ˢ V).finite_toSet
    (fun z _ => (Set.finite_singleton (reflAxis z.1 z.2 (gluePoint z.1 z.2 1 1))).insert
      (gluePoint z.1 z.2 1 1))) ?_
  rintro p ⟨x, hxV, y, hyV, hne, hx, hy⟩
  have hz : (x, y) ∈ ((V ×ˢ V : Finset (ℂ × ℂ)) : Set (ℂ × ℂ)) := by
    simpa using Finset.mk_mem_product hxV hyV
  exact Set.mem_biUnion hz (by simpa using eq_gluePoint_of_unit_pair hne hx hy)

/-- Red control (the adversarial member): two points at distance `> 2` have NO common unit
neighbour — beyond the annulus the candidate space is empty, not merely unclassified. -/
example : ¬ ∃ p : ℂ, dist p 0 = 1 ∧ dist p 3 = 1 := by
  rintro ⟨p, h0, h3⟩
  have : dist (0 : ℂ) 3 ≤ 1 + 1 := by
    calc dist (0 : ℂ) 3 ≤ dist 0 p + dist p 3 := dist_triangle 0 p 3
    _ = 1 + 1 := by rw [dist_comm 0 p, h0, h3]
  simp [Complex.dist_eq] at this
  norm_num at this

end Glue
end HadwigerNelson
