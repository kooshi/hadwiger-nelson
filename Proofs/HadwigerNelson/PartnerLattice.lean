import Proofs.HadwigerNelson.Glue

/-! # The partner lattice is complete for unit pairs (M50)

The kill engine (`tools/killengine.py`, M49 §R8) enumerates candidate points for unit-distance
halos as intersections of unit circles about pairs of object points — the *partner lattice* — and
its census claims lean on one fact: **a point at unit distance from two distinct points has
nowhere else to be**. This module is that fact as a theorem, the depth-one completeness the
engine's "in any field" claims cite.

The statement is pointwise, and that is where the hypotheses vanish (M50 §Bʹ): both annulus bounds
of `Glue.sphere_inter_sphere` are derivable from the witness itself — `|1 − 1| = 0 ≤ dist x y`
always, and `dist x y ≤ dist x p + dist p y = 2` by the triangle inequality through `p` — so only
`x ≠ y` remains, and it is genuinely load-bearing (at `x = y` the intersection is a whole circle).
At `dist x y = 2` the glue point and its mirror coincide and the disjunction holds degenerately.

The finiteness corollary is the census's consumer shape: over a finite vertex set, only finitely
many points of the plane have two distinct unit neighbours in it (at most two per pair — the bound
stays prose; finiteness is what the claims cite).
-/

namespace HadwigerNelson
namespace Glue

/-- **Depth-one completeness, pointwise.** A point at unit distance from two DISTINCT points is
the glue point of their unit circles or its mirror — no other hypothesis: both annulus bounds are
derived from the witness (`0 ≤ dist x y` and, through `p`, `dist x y ≤ 2`). The kill engine's
"single-point kills live in the partner lattice, in any field" as a theorem. -/
theorem eq_gluePoint_of_unit_pair {p x y : ℂ} (hne : x ≠ y)
    (hx : dist p x = 1) (hy : dist p y = 1) :
    p = gluePoint x y 1 1 ∨ p = reflAxis x y (gluePoint x y 1 1) := by
  have h2 : dist x y ≤ 1 + 1 := by
    calc dist x y ≤ dist x p + dist p y := dist_triangle x p y
    _ = 1 + 1 := by rw [dist_comm x p, hx, hy]
  have h0 : |(1 : ℝ) - 1| ≤ dist x y := by simp [dist_nonneg]
  have hmem : p ∈ Metric.sphere x 1 ∩ Metric.sphere y 1 :=
    ⟨Metric.mem_sphere.mpr hx, Metric.mem_sphere.mpr hy⟩
  rw [sphere_inter_sphere hne h0 h2] at hmem
  simpa using hmem

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
