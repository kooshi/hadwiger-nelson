import Proofs.HadwigerNelson.EdgeList

/-!
# The distance graph of a metric space for a set of forbidden distances

`unitDistance V` joins two points at distance exactly `1`. The Hadwiger–Nelson programme's
two-distance variants — colour the plane so that no two points at distance `1` *or* at distance
`d` agree — are the same graph with a *set* of forbidden distances, and this file is that graph:
`distanceGraph V D` joins `x` and `y` when `x ≠ y` and `dist x y ∈ D`.

## Why a separate module, and why this shape

`UnitDistance.lean` is imported by every certificate in the repository; a declaration added there
rebuilds all of them (hours). Nothing here changes `unitDistance` — the bridge is the equality
`unitDistance_eq_distanceGraph_singleton`, so every unit-distance theorem is a `D = {1}` instance
of the ones below and no consumer is disturbed.

The `x ≠ y` conjunct is intrinsic, not defensive: a `SimpleGraph` is loopless whatever `D`
contains, and `dist x x = 0` may well lie in `D`. It is the one place `D` leaks a side condition —
the edge-list reduction below asks `(0 : ℝ) ∉ D` so that a listed pair at a listed distance is a
pair of *distinct* points — discharged by `norm_num` once per `D`.

## What this buys

* `add_one_le_chromaticNumber_distanceGraph_edgeList` — the reduction, in the certificate's own
  vocabulary: a finite graph whose listed edges are realized at listed distances, and a refutation,
  give a lower bound on the *distance graph's* chromatic number. Consumed by the certified `{1,2}`
  six-forcer (`Instances/OneTwo`) and, for free, by the hexagonal shell: its seven points are a
  clique of the `{1, √3, 2}` graph, so `χ(ℝ²; {1,√3,2}) ≥ 7` — stated until now only as prose in
  `hexShell_plane6`'s docstring.
* `distanceGraphHom` — the homomorphism from an edge-list graph, the piece `Forces.plane` and
  `Separated.plane` travel; and `Isometry.distanceGraphHom` — an isometry is an endomorphism of
  every distance graph, which is all homogeneity (`Homogeneous.lean`) needs.
* `chromaticNumber_unitDistance_le_distanceGraph` — the honest direction of comparison: any bound
  on a distance graph containing `1` is a *weaker* statement than the same bound for the plane.
-/

namespace HadwigerNelson

open SimpleGraph

variable {V W ι : Type*}

/-! ## The graph -/

/-- The distance graph of `V` for the set `D` of forbidden distances: two *distinct* points are
adjacent exactly when their distance lies in `D`. `unitDistance V` is the case `D = {1}`
(`unitDistance_eq_distanceGraph_singleton`).

Reason about it through `distanceGraph_adj`; the definition is not promised. -/
def distanceGraph (V : Type*) [MetricSpace V] (D : Set ℝ) : SimpleGraph V where
  Adj x y := x ≠ y ∧ dist x y ∈ D
  symm := ⟨fun _ _ h => ⟨h.1.symm, by rw [dist_comm]; exact h.2⟩⟩
  loopless := ⟨fun _ h => h.1 rfl⟩

/-- Adjacency in `distanceGraph`, the reasoning surface. `@[simp]` toward metric vocabulary, as
`unitDistance_adj`. -/
@[simp]
theorem distanceGraph_adj [MetricSpace V] {D : Set ℝ} {x y : V} :
    (distanceGraph V D).Adj x y ↔ x ≠ y ∧ dist x y ∈ D := Iff.rfl

/-- **The unit-distance graph is the distance graph of `{1}`.** The bridge that makes every
`unitDistance` theorem a `D = {1}` instance of the ones in this file. -/
theorem unitDistance_eq_distanceGraph_singleton [MetricSpace V] :
    unitDistance V = distanceGraph V {1} := by
  ext x y
  simp only [unitDistance_adj, distanceGraph_adj, Set.mem_singleton_iff]
  constructor
  · intro h
    refine ⟨fun hxy => ?_, h⟩
    rw [hxy, dist_self] at h
    exact zero_ne_one h
  · exact fun h => h.2

/-- More forbidden distances, more edges. -/
theorem distanceGraph_mono [MetricSpace V] {D₁ D₂ : Set ℝ} (h : D₁ ⊆ D₂) :
    distanceGraph V D₁ ≤ distanceGraph V D₂ :=
  fun _ _ hxy => ⟨hxy.1, h hxy.2⟩

/-- **A bound for a distance graph containing `1` is a weaker statement than the same bound for the
unit-distance graph** — the honest reading of every two-distance result: `χ(V; D) ≥ χ(V)`. -/
theorem chromaticNumber_unitDistance_le_distanceGraph [MetricSpace V] {D : Set ℝ}
    (h1 : (1 : ℝ) ∈ D) :
    (unitDistance V).chromaticNumber ≤ (distanceGraph V D).chromaticNumber := by
  rw [unitDistance_eq_distanceGraph_singleton]
  exact chromaticNumber_mono _ (distanceGraph_mono (Set.singleton_subset_iff.mpr h1))

/-! ## Homomorphisms into a distance graph -/

/-- **An isometry is an endomorphism of every distance graph** — it preserves distances and, being
injective, distinctness. The whole of homogeneity rests on this one line. -/
def Isometry.distanceGraphHom [MetricSpace V] {D : Set ℝ} {g : V → V} (hg : Isometry g) :
    distanceGraph V D →g distanceGraph V D where
  toFun := g
  map_rel' := fun {x y} h => ⟨fun hxy => h.1 (hg.injective hxy), by rw [hg.dist_eq]; exact h.2⟩

/-- **A realization at listed distances is a homomorphism.** The hypothesis is what a certificate
produces — one distance fact per adjacency — together with `(0 : ℝ) ∉ D`, which is what makes a
realized adjacency a pair of *distinct* points. The analogue of `unitDistanceHom`. -/
def distanceGraphHom [MetricSpace V] {D : Set ℝ} (G : SimpleGraph ι) (p : ι → V)
    (hp : ∀ i j, G.Adj i j → dist (p i) (p j) ∈ D) (h0 : (0 : ℝ) ∉ D) :
    G →g distanceGraph V D where
  toFun := p
  map_rel' := fun {i j} h => ⟨fun heq => h0 (by simpa [heq] using hp i j h), hp i j h⟩

/-- **The reduction, in the certificate's own vocabulary.** A finite graph presented by an edge
list, every listed pair realized at a distance in `D`, and not `k`-colourable: the distance graph
needs at least `k + 1` colours. The exact analogue of
`add_one_le_chromaticNumber_unitDistance_edgeList`, and it specializes to it at `D = {1}`. -/
theorem add_one_le_chromaticNumber_distanceGraph_edgeList [MetricSpace V] {n k : ℕ}
    {D : Set ℝ} (E : List (Fin n × Fin n)) (p : Fin n → V)
    (hp : ∀ e ∈ E, dist (p e.1) (p e.2) ∈ D) (h0 : (0 : ℝ) ∉ D)
    (hG : ¬ (edgeGraph n E).Colorable k) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (distanceGraph V D).chromaticNumber := by
  rw [add_one_le_chromaticNumber_iff_not_colorable]
  intro hc
  refine hG (hc.of_hom (distanceGraphHom (edgeGraph n E) p ?_ h0))
  rintro i j ⟨-, hij | hji⟩
  · exact hp (i, j) hij
  · rw [dist_comm]; exact hp (j, i) hji

/-! ## Specification — the definitions say what they mean -/

-- The unit case really is a special case: on the real line, `{1}` joins `0` and `1`, and `{0}` joins
-- nothing to anything — the `x ≠ y` conjunct is load-bearing exactly when `0 ∈ D`, and without it
-- the definition would not be a `SimpleGraph` at all.
example : (distanceGraph ℝ {1}).Adj 0 1 := by
  simp only [distanceGraph_adj, Set.mem_singleton_iff, Real.dist_eq, ne_eq, zero_ne_one,
    not_false_eq_true, true_and]
  norm_num
example : distanceGraph ℝ {0} = ⊥ := by
  ext x y
  simp only [distanceGraph_adj, Set.mem_singleton_iff, dist_eq_zero, SimpleGraph.bot_adj, iff_false,
    not_and, ne_eq]
  exact fun h h' => h h'

end HadwigerNelson
