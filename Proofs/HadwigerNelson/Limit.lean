import Proofs.HadwigerNelson.UnitDistance
import Proofs.HadwigerNelson.Reduction
import Mathlib.Topology.Sequences
import Mathlib.Data.Fintype.Pigeonhole

/-!
# The limit of approximate drawings

`UnitDistance.lean` turns a finite graph drawn with edges of length *exactly* `1` into a lower
bound on a metric space's chromatic number. This file removes the "exactly": a graph that can be
drawn inside one fixed compact region with edges of length *within `ε` of* `1`, **for every
`ε > 0`**, can be drawn there with edges of length exactly `1` — so the same bound follows.

Why this is worth a file. Milestones M39–M43 measured a one-parameter family of finite graphs
whose colourings are the plane colourings constant on the cells of a triangular grid at scale
`p`. Constancy on cells at scale `p` forbids a whole interval of distances around `1`, and that
interval shrinks with `p`, so the family is a *deformation* whose limit at `p → 0` is the
unit-distance problem itself. The theorems here are what make that limit statement mean
something: `add_one_le_chromaticNumber_of_bounded_family` says that if the *size* of the forcing
configurations stays bounded as the tolerance shrinks, the bound transfers to the space. Its
contrapositive is the milestone's headline — the growth of that size is a necessary condition for
the plane needing fewer than seven colours.

## Attribution

The argument is a compactness argument of a kind any specialist would produce on request, and no
novelty is claimed for it. What it earns here is a precise, kernel-checked statement of the
obstruction that the measurement campaign is measuring.

## Using this file

* `exists_unitDist_drawing_of_approx` — the geometric content, with no mention of colouring.
* `add_one_le_chromaticNumber_of_approx` — one fixed graph, drawable ever more accurately.
* `add_one_le_chromaticNumber_of_bounded_family` — the graph may *differ* at each tolerance, and
  only its vertex count is fixed. This is the one the measurement consumes.
* `seven_le_chromaticNumber_plane_of_bounded_family` — the plane instance at six colours.
-/

namespace HadwigerNelson

open SimpleGraph Filter Topology Metric

variable {V ι : Type*} [MetricSpace V] [Fintype ι]

/-! ## The geometric content -/

/-- **The limit of approximate drawings.** If a finite graph can be drawn inside one fixed
compact set with every edge's length within `ε` of `1`, for *every* `ε > 0`, then it can be drawn
with every edge's length exactly `1`.

The hypothesis is stated as `∀ ε > 0` rather than along a sequence on purpose: a caller has a
family indexed by whatever its construction is indexed by, and should not have to manufacture a
sequence and a `Tendsto` proof. The sequence appears inside the proof, where it belongs.

Compactness is taken as a hypothesis rather than derived from a bound and `ProperSpace`, because
compactness is the whole of what the argument uses; `isCompact_closedBall` recovers the bounded
form in one step at the call site. -/
theorem exists_unitDist_drawing_of_approx {G : SimpleGraph ι} {K : Set V} (hK : IsCompact K)
    (h : ∀ ε > 0, ∃ z : ι → V, (∀ i, z i ∈ K) ∧
          ∀ i j, G.Adj i j → |dist (z i) (z j) - 1| ≤ ε) :
    ∃ q : ι → V, ∀ i j, G.Adj i j → dist (q i) (q j) = 1 := by
  sorry

/-! ## The chromatic bounds -/

/-- **The limit lemma.** A fixed finite graph with no `k`-colouring, drawable in a fixed compact
region with edge lengths approaching `1`, forces the space past `k` colours. -/
theorem add_one_le_chromaticNumber_of_approx {G : SimpleGraph ι} {k : ℕ} {K : Set V}
    (hK : IsCompact K)
    (h : ∀ ε > 0, ∃ z : ι → V, (∀ i, z i ∈ K) ∧
          ∀ i j, G.Adj i j → |dist (z i) (z j) - 1| ≤ ε)
    (hG : ¬ G.Colorable k) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance V).chromaticNumber := by
  sorry

/-- **The headline.** The graph is allowed to *differ* at each tolerance — only its vertex count
and the region are fixed. This is what a measurement campaign produces: a sequence of witnesses,
each its own graph, of bounded size and shrinking edge-length error.

The proof is the pigeonhole the extra generality costs: there are only finitely many graphs on a
fixed finite vertex type, so one of them recurs at arbitrarily small tolerance, and that one
satisfies the fixed-graph hypothesis. -/
theorem add_one_le_chromaticNumber_of_bounded_family {k N : ℕ} {K : Set V} (hK : IsCompact K)
    (h : ∀ ε > 0, ∃ (G : SimpleGraph (Fin N)) (z : Fin N → V),
          ¬ G.Colorable k ∧ (∀ i, z i ∈ K) ∧
          ∀ i j, G.Adj i j → |dist (z i) (z j) - 1| ≤ ε) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance V).chromaticNumber := by
  sorry

/-- **The plane instance.** If configurations of at most `N` points, inside one fixed disc, refuse
six colours at every edge-length tolerance, then the plane needs seven. -/
theorem seven_le_chromaticNumber_plane_of_bounded_family {N : ℕ} {c : ℂ} {D : ℝ}
    (h : ∀ ε > 0, ∃ (G : SimpleGraph (Fin N)) (z : Fin N → ℂ),
          ¬ G.Colorable 6 ∧ (∀ i, z i ∈ closedBall c D) ∧
          ∀ i j, G.Adj i j → |dist (z i) (z j) - 1| ≤ ε) :
    (7 : ℕ∞) ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber := by
  sorry

end HadwigerNelson
