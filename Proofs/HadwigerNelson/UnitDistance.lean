import Mathlib.Combinatorics.SimpleGraph.Coloring.Vertex
import Mathlib.Topology.MetricSpace.Isometry

/-!
# Unit-distance graphs and the chromatic number of a metric space

The reduction at the heart of the Hadwiger–Nelson project: a finite graph that embeds into a
metric space with all edges of length exactly `1` transfers its chromatic number upward to the
space's unit-distance graph. Every later milestone produces such an embedding and a
non-colourability fact; this file is what turns them into a statement about the plane.

Nothing here mentions the plane, `ℝ²`, or any particular graph — that is deliberate. The
milestone's own model of these hypotheses is the unit equilateral triangle, in
`Proofs.HadwigerNelson.Instances.Triangle`.

## Shape notes

* `unitDistance` is built by `SimpleGraph.mk` rather than `SimpleGraph.fromRel`: symmetry of
  `dist` and `dist x x = 0 ≠ 1` make `fromRel`'s two extra conjuncts redundant, so `Adj` is
  *definitionally* `dist x y = 1` and `unitDistance_adj_iff` is `Iff.rfl`.
* The chromatic bound's primitive form is the strict, arithmetic-free `(n : ℕ∞) < χ` — the exact
  contrapositive of `chromaticNumber_le_iff_colorable`. Numerals appear only at headlines, via
  `ENat.coe_add_one_le_iff`.
-/

namespace Proofs.HadwigerNelson

open SimpleGraph

variable {V W ι : Type*}

/-! ## The unit-distance graph -/

/-- The unit-distance graph on a metric space: `x` and `y` are adjacent exactly when they lie at
distance `1`. The distance is *exactly* `1`, not "at most" — this is the Hadwiger–Nelson
adjacency. -/
def unitDistance (V : Type*) [MetricSpace V] : SimpleGraph V where
  Adj x y := dist x y = 1
  symm := ⟨fun _ _ h => by rwa [dist_comm]⟩
  loopless := ⟨fun x h => by rw [dist_self] at h; exact zero_ne_one h⟩

/-- Adjacency in `unitDistance` is exactly unit distance. True by `rfl`, but stated and tagged so
that no downstream proof ever unfolds `Adj`. -/
@[simp]
theorem unitDistance_adj_iff [MetricSpace V] {x y : V} :
    (unitDistance V).Adj x y ↔ dist x y = 1 := Iff.rfl

/-! ## The chromatic bound -/

/-- Not being `n`-colourable puts the chromatic number strictly above `n`. The primitive form:
no `ℕ∞` arithmetic, just the contrapositive of `chromaticNumber_le_iff_colorable`. -/
theorem lt_chromaticNumber_of_not_colorable {G : SimpleGraph W} {n : ℕ}
    (h : ¬ G.Colorable n) : (n : ℕ∞) < G.chromaticNumber := by
  sorry

/-- Numeral form of the bound, for headlines. Derived once here so the `ℕ∞` arithmetic does not
recur at every call site. -/
theorem add_one_le_chromaticNumber_of_not_colorable {G : SimpleGraph W} {n : ℕ}
    (h : ¬ G.Colorable n) : ((n + 1 : ℕ) : ℕ∞) ≤ G.chromaticNumber := by
  sorry

/-! ## The reduction -/

/-- A vertex map sending edges to unit-distance pairs is a graph homomorphism into the
unit-distance graph. -/
def unitDistanceHom [MetricSpace V] (G : SimpleGraph ι) (p : ι → V)
    (hp : ∀ i j, G.Adj i j → dist (p i) (p j) = 1) : G →g unitDistance V where
  toFun := p
  map_rel' := by sorry

/-- **The reduction.** A finite witness — any graph `G` drawn in `V` with unit-length edges and no
`n`-colouring — forces the whole space to need more than `n` colours.

This is the only theorem M04 and M05 need: they supply `p` and `hp` (exact geometry) and `hG`
(a verified LRAT certificate), and this returns the bound on the plane. -/
theorem lt_chromaticNumber_unitDistance [MetricSpace V] {G : SimpleGraph ι} {n : ℕ}
    (p : ι → V) (hp : ∀ i j, G.Adj i j → dist (p i) (p j) = 1) (hG : ¬ G.Colorable n) :
    (n : ℕ∞) < (unitDistance V).chromaticNumber := by
  sorry

/-- Numeral form of the reduction — what the three headlines call. -/
theorem add_one_le_chromaticNumber_unitDistance [MetricSpace V] {G : SimpleGraph ι} {n : ℕ}
    (p : ι → V) (hp : ∀ i j, G.Adj i j → dist (p i) (p j) = 1) (hG : ¬ G.Colorable n) :
    ((n + 1 : ℕ) : ℕ∞) ≤ (unitDistance V).chromaticNumber := by
  sorry

/-- The bound does not see which model of the plane we chose. Lets the construction live in `ℂ`,
where rotation is multiplication, while the headline is stated in `EuclideanSpace ℝ (Fin 2)`. -/
theorem chromaticNumber_unitDistance_congr [MetricSpace V] [MetricSpace W] (e : V ≃ᵢ W) :
    (unitDistance V).chromaticNumber = (unitDistance W).chromaticNumber := by
  sorry

end Proofs.HadwigerNelson
