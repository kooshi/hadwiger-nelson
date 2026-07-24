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

## Using this file

Two entry points, and you almost certainly want the second:

* `lt_chromaticNumber_unitDistance` — the primitive, strict and arithmetic-free.
* `add_one_le_chromaticNumber_unitDistance` — the numeral form, which is what a headline states.
  Its edge-list flavour, `add_one_le_chromaticNumber_unitDistance_edgeList`, lives in
  `EdgeList.lean` and takes the hypothesis in exactly the shape a certificate produces.
-/

namespace HadwigerNelson

open SimpleGraph

variable {V W ι : Type*}

/-! ## The unit-distance graph -/

/-- The unit-distance graph on a metric space: `x` and `y` are adjacent exactly when they lie at
distance `1`. The distance is *exactly* `1`, not "at most" — this is the Hadwiger–Nelson
adjacency.

Reason about it through `unitDistance_adj`, never by unfolding: `Adj` happens to be
definitionally `dist x y = 1`, but that is an implementation detail this API does not promise. -/
def unitDistance (V : Type*) [MetricSpace V] : SimpleGraph V where
  Adj x y := dist x y = 1
  symm := ⟨fun _ _ h => by rwa [dist_comm]⟩
  loopless := ⟨fun x h => by rw [dist_self] at h; exact zero_ne_one h⟩

/-- Adjacency in `unitDistance` is exactly unit distance.

`@[simp]` because the destination is deliberate: it drives goals out of graph vocabulary and into
metric vocabulary, where `norm_num`, `positivity` and the `dist` lemmas live. The rewrite
terminates trivially — the right-hand side mentions no `Adj`. -/
@[simp]
theorem unitDistance_adj [MetricSpace V] {x y : V} :
    (unitDistance V).Adj x y ↔ dist x y = 1 := Iff.rfl

/-! ## The chromatic bound -/

/-- Needing more than `n` colours and not being `n`-colourable are the same statement. The
primitive form: no `ℕ∞` arithmetic, just the contrapositive of
`SimpleGraph.chromaticNumber_le_iff_colorable`.

Stated as an `iff` because both directions get used — the `←` direction turns a certificate into a
bound, and the `→` direction lets a proven bound rule out colourings. -/
theorem lt_chromaticNumber_iff_not_colorable {G : SimpleGraph W} {n : ℕ} :
    (n : ℕ∞) < G.chromaticNumber ↔ ¬ G.Colorable n := by
  sorry

/-- Numeral form of the bound — what a headline states. Derived once here so that the `ℕ∞`
arithmetic does not recur at every call site; arithmetic stays in `ℕ` and `ℕ∞` sees only the
coercion and the order. -/
theorem add_one_le_chromaticNumber_iff_not_colorable {G : SimpleGraph W} {n : ℕ} :
    ((n + 1 : ℕ) : ℕ∞) ≤ G.chromaticNumber ↔ ¬ G.Colorable n := by
  sorry

/-! ## The reduction -/

/-- A vertex map sending edges to unit-distance pairs is a graph homomorphism into the
unit-distance graph. -/
def unitDistanceHom [MetricSpace V] (G : SimpleGraph ι) (p : ι → V)
    (hp : ∀ i j, G.Adj i j → dist (p i) (p j) = 1) : G →g unitDistance V where
  toFun := p
  map_rel' := by sorry

/-- **The reduction.** A finite witness — any graph `G` drawn in `V` with unit-length edges and no
`n`-colouring — forces the whole space to need more than `n` colours. -/
theorem lt_chromaticNumber_unitDistance [MetricSpace V] {G : SimpleGraph ι} {n : ℕ}
    (p : ι → V) (hp : ∀ i j, G.Adj i j → dist (p i) (p j) = 1) (hG : ¬ G.Colorable n) :
    (n : ℕ∞) < (unitDistance V).chromaticNumber := by
  sorry

/-- **The reduction, numeral form.** This is the theorem M04 and M05 call: supply `p` and `hp`
(exact geometry) and `hG` (a verified LRAT certificate), and it returns the bound on the plane. -/
theorem add_one_le_chromaticNumber_unitDistance [MetricSpace V] {G : SimpleGraph ι} {n : ℕ}
    (p : ι → V) (hp : ∀ i j, G.Adj i j → dist (p i) (p j) = 1) (hG : ¬ G.Colorable n) :
    ((n + 1 : ℕ) : ℕ∞) ≤ (unitDistance V).chromaticNumber := by
  sorry

/-- The bound does not see which model of the plane we chose. Lets the construction live in `ℂ`,
where rotation is multiplication, while the headline is stated in `EuclideanSpace ℝ (Fin 2)`. -/
theorem chromaticNumber_unitDistance_congr [MetricSpace V] [MetricSpace W] (e : V ≃ᵢ W) :
    (unitDistance V).chromaticNumber = (unitDistance W).chromaticNumber := by
  sorry

end HadwigerNelson
