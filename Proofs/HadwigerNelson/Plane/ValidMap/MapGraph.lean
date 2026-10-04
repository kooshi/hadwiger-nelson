import Proofs.HadwigerNelson.Plane.SVMap
import Mathlib.Combinatorics.SimpleGraph.Paths
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected

/-!
# Thomassen's steps on valid maps: the map graph, filled holes, 2-separators, the reduced graph `H`, and Lemma 1

Wave 5's skeleton (`plans/FS131-w5-kernel-plan.md` § 8) for **FS114-CVB-THOM** with **FS114-CVB-PINCH** (`plans/FS114-CVB-verification.md`
§ 1.9, B1–B2): `[Thomassen1999]`'s steps other than the rainbow step hold for every valid map, Siamese pairs allowed — fill holes, read facial
cycles as boundary walks, replace the count in `int(R)` by local finiteness — and the reduced map graph `H` has a vertex of degree at least `6`.

**Pure graph theory** (namespace `HadwigerNelson.Thomassen`, over Mathlib's `SimpleGraph`):

* `LocallyHamiltonian G` — `[Thomassen1999]` p. 850: "for each `x` in `V(G)`, `G` has a cycle with vertex set `D₁(x)`";
* `lemma1` — Thomassen's Lemma 1 (p. 850): a connected, locally finite, locally Hamiltonian graph with at least `13` vertices has a vertex of
  degree at least `6`. **Formalized here** (a page of counting over the distance layers `D₁, …, D₄`), not imported;
* `twoSepInterior G x y` — CVB's `int(M, x, y)` (B2 step 2): the vertices of the finite components of `G − x − y`; `IsTwoSep`,
  `IsMaximalTwoSep` (Thomassen p. 852: "no 2-separator `{u, v}` with `x` or `y` in `int(M, u, v)`"); `reducedVerts`, `reduced` — `H`, the graph
  with every maximal 2-separator's interior deleted.

**On a map** (`ArcMap`): `mapGraph` (tiles, adjacent when their closures meet), `IsHoleOf` (a bounded component of the complement of a tile's
closure whose closure misses every unbounded one: "a boundary component of `x` disjoint from its outer one"), `fill` (a tile with its holes),
`IsOuterTile` (a tile inside no hole of another tile), `filledGraph` (the filled map's graph: outer tiles, adjacent when their filled closures
meet).

Rows: `cvb_thom_reduced` (B2 steps 1–3: `H` connected, locally finite, locally Hamiltonian, infinite), `cvb_thom` (B2 step 4: a vertex of
`H`-degree at least `6`), `cvb_pinch_connected` and `cvb_hole_disconnected` (B1), `exists_holed_valid_fragment` (B1's "holes are locally
consistent with validity"). Not claimed (the row's own line): the rainbow step on valid maps; the 2-separator criterion at pinches as more
than a sketch.
-/

namespace HadwigerNelson.Thomassen

variable {V : Type*} (G : SimpleGraph V)

/-- **Locally Hamiltonian** (`[Thomassen1999]` p. 850): for each vertex `x`, `G` has a cycle whose vertex set is the neighbourhood
`D₁(x)`. -/
def LocallyHamiltonian : Prop :=
  ∀ x, ∃ (a : V) (p : G.Walk a a), p.IsCycle ∧ ∀ y, y ∈ p.support ↔ G.Adj x y

/-- The vertices other than `x` and `y`. -/
def offTwo (x y : V) : Set V := {v | v ≠ x ∧ v ≠ y}

/-- **`int(G, x, y)`** (CVB B2 step 2, in place of Thomassen's curve `R`): the vertices of the finite connected components of `G − x − y`. -/
def twoSepInterior (x y : V) : Set V :=
  {v | ∃ hv : v ∈ offTwo x y, ((G.induce (offTwo x y)).connectedComponentMk ⟨v, hv⟩).supp.Finite}

/-- **A 2-separator** `{x, y}`: two distinct vertices whose removal leaves a finite component. -/
def IsTwoSep (x y : V) : Prop := x ≠ y ∧ (twoSepInterior G x y).Nonempty

/-- **A maximal 2-separator** (`[Thomassen1999]` p. 852): a 2-separator `{x, y}` such that no 2-separator `{u, v}` has `x` or `y` in its
interior. -/
def IsMaximalTwoSep (x y : V) : Prop :=
  IsTwoSep G x y ∧ ∀ u v, IsTwoSep G u v → x ∉ twoSepInterior G u v ∧ y ∉ twoSepInterior G u v

/-- The vertices of **`H`**: those in the interior of no maximal 2-separator. -/
def reducedVerts : Set V := {v | ∀ x y, IsMaximalTwoSep G x y → v ∉ twoSepInterior G x y}

/-- **`H`** (`[Thomassen1999]` p. 852): `G` with the interior of every maximal 2-separator deleted. -/
def reduced : SimpleGraph (reducedVerts G) := G.induce (reducedVerts G)

/-- **Thomassen's Lemma 1** (`[Thomassen1999]` p. 850): a connected, locally finite, locally Hamiltonian graph with at least `13` vertices
has a vertex of degree at least `6`. Pure graph theory, formalized here (the planner's decision, plan § 8.3: under the hour-of-agent-work
line, and "when unsure, formalize"). Model of the hypotheses: the triangular lattice (`triLattice`, infinite, every neighbourhood a
hexagon). -/
theorem lemma1 (hfin : ∀ x, (G.neighborSet x).Finite) (hc : G.Connected) (hH : LocallyHamiltonian G)
    (h13 : 13 ≤ ENat.card V) : ∃ x, 6 ≤ (G.neighborSet x).encard := by
  sorry

/-- The triangular lattice on `ℤ × ℤ`: `(a, b)` and `(c, d)` adjacent when their difference is `±(1, 0)`, `±(0, 1)` or `±(1, −1)`. -/
def triLattice : SimpleGraph (ℤ × ℤ) where
  Adj p q := (q.1 - p.1, q.2 - p.2) ∈ ({(1, 0), (-1, 0), (0, 1), (0, -1), (1, -1), (-1, 1)} : Set (ℤ × ℤ))
  symm := ⟨fun p q h => by
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff, Prod.mk.injEq] at h ⊢
    omega⟩
  loopless := ⟨fun p h => by
    simp only [sub_self, Set.mem_insert_iff, Set.mem_singleton_iff, Prod.mk.injEq] at h
    omega⟩

/-- **The inhabitant of `lemma1`'s hypotheses**: the triangular lattice is locally finite, connected and locally Hamiltonian (each
neighbourhood is a hexagon), and infinite. -/
theorem triLattice_hyps :
    (∀ x, (triLattice.neighborSet x).Finite) ∧ triLattice.Connected ∧ LocallyHamiltonian triLattice ∧ 13 ≤ ENat.card (ℤ × ℤ) := by
  sorry

/-- A spec example for `triLattice`: `(0, 0)` and `(1, −1)` are adjacent, `(0, 0)` and `(1, 1)` are not. -/
example : triLattice.Adj (0, 0) (1, -1) ∧ ¬ triLattice.Adj (0, 0) (1, 1) := by
  constructor
  · simp [triLattice]
  · simp [triLattice]

end HadwigerNelson.Thomassen

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- **The map graph `M`** (CVB § 1.9's frame): the tiles, two distinct tiles adjacent when their closures meet. -/
def mapGraph : SimpleGraph {T : Set ℂ // F.IsTile T} where
  Adj T T' := T ≠ T' ∧ (closure T.1 ∩ closure T'.1).Nonempty
  symm := ⟨fun T T' h => ⟨h.1.symm, by rw [inter_comm]; exact h.2⟩⟩
  loopless := ⟨fun T h => h.1 rfl⟩

/-- **`Hc` is a hole of `T`** (CVB B1: "a boundary component of `x` disjoint from its outer one"): a bounded connected component of the
complement of `T`'s closure whose closure misses the closure of every unbounded component. -/
def IsHoleOf (T Hc : Set ℂ) : Prop :=
  (∃ z ∈ (closure T)ᶜ, Hc = connectedComponentIn (closure T)ᶜ z) ∧ Bornology.IsBounded Hc ∧
    ∀ z ∈ (closure T)ᶜ, ¬ Bornology.IsBounded (connectedComponentIn (closure T)ᶜ z) →
      Disjoint (closure Hc) (closure (connectedComponentIn (closure T)ᶜ z))

/-- **The filled tile** `x̂` (CVB B2 step 1): the tile with its holes. -/
def fill (T : Set ℂ) : Set ℂ := T ∪ ⋃₀ {Hc | IsHoleOf T Hc}

/-- **An outer tile**: a tile lying in no hole of another tile (the tiles the filled map keeps). -/
def IsOuterTile (T : Set ℂ) : Prop := F.IsTile T ∧ ∀ T' Hc, F.IsTile T' → IsHoleOf T' Hc → ¬ T ⊆ Hc

/-- **The filled map's graph** (CVB B2 step 1: "its map graph is `M` minus the hole contents"): the outer tiles, two distinct ones adjacent
when the closures of their filled tiles meet. -/
def filledGraph : SimpleGraph {T : Set ℂ // F.IsOuterTile T} where
  Adj T T' := T ≠ T' ∧ (closure (fill T.1) ∩ closure (fill T'.1)).Nonempty
  symm := ⟨fun T T' h => ⟨h.1.symm, by rw [inter_comm]; exact h.2⟩⟩
  loopless := ⟨fun T h => h.1 rfl⟩

end ArcMap

/-! ### Spec examples -/

section Spec

/-- A tile of the one-colour plane is the plane (a spec example for `mapGraph`: the one-colour plane's map graph has one vertex, so no
edge). -/
example (j : Fin 2) (T T' : {T : Set ℂ // (ArcMap.const univ isOpen_univ j).IsTile T}) :
    ¬ (ArcMap.const univ isOpen_univ j).mapGraph.Adj T T' := by
  rintro ⟨hne, -⟩
  apply hne
  obtain ⟨T, x, hx, rfl⟩ := T
  obtain ⟨T', y, hy, rfl⟩ := T'
  have hU : (ArcMap.const univ isOpen_univ j).interiorPts = univ := by simp
  apply Subtype.ext
  simp only [hU, connectedComponentIn_univ, PreconnectedSpace.connectedComponent_eq_univ]

/-- **Adversary**: a set with empty closure-complement has no hole (a spec example for `IsHoleOf`: the plane is no tile's hole-maker). -/
example (Hc : Set ℂ) : ¬ ArcMap.IsHoleOf (univ : Set ℂ) Hc := by
  rintro ⟨⟨z, hz, -⟩, -⟩
  simp at hz

end Spec

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS114-CVB-THOM -/

/-- **FS114-CVB-THOM, B2 steps 1–3** (`plans/FS114-CVB-verification.md` § 1.9): for every valid map of the plane, Siamese pairs allowed, the
reduced filled map graph `H` is connected, locally finite, locally Hamiltonian and infinite — `[Thomassen1999]`'s steps other than the
rainbow step, with holes filled, facial cycles read as boundary walks, and the count in `int(R)` replaced by local finiteness. Colour-free
(CVB: "indeed every locally finite plane map with bounded connected tiles"); validity enters only through the tiles' diameter `≤ 1`
(`dist_lt_one_of_forall_dist_ne_one`). Every `k`. Model of the hypotheses: `sevenBrickMap` (valid, of the plane, `k = 7`). -/
theorem cvb_thom_reduced (hF : F.Valid) (hP : F.IsPlaneMap) :
    (Thomassen.reduced F.filledGraph).Connected ∧ (∀ x, ((Thomassen.reduced F.filledGraph).neighborSet x).Finite) ∧
      Thomassen.LocallyHamiltonian (Thomassen.reduced F.filledGraph) ∧ Infinite (Thomassen.reducedVerts F.filledGraph) := by
  sorry

/-- **FS114-CVB-THOM** (B2 step 4): every valid map of the plane, Siamese pairs allowed, has an outer tile of degree at least `6` in the reduced
filled map graph `H` (`cvb_thom_reduced` and `Thomassen.lemma1`). The rainbow step — that such a tile's neighbours carry six colours — is not
claimed (it fails on valid maps: FS114-N114-RD's types (A) and (B)). Model of the hypotheses: `sevenBrickMap` (`k = 7`; its bricks have six
neighbours each). -/
theorem cvb_thom (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ x, 6 ≤ ((Thomassen.reduced F.filledGraph).neighborSet x).encard := by
  sorry

/-- **FS114-CVB-PINCH, the pinch clause** (B1): in the map graph of a valid map of the plane, removing a tile with no hole leaves the graph
connected — at a pinched tile (its boundary walk visits a vertex twice) as at a simple one. Read at the class the argument reads (every tile
with no hole; Thomassen's own case is the unpinched one). Model of the hypotheses: a brick of `sevenBrickMap`. -/
theorem cvb_pinch_connected (hF : F.Valid) (hP : F.IsPlaneMap) {T : Set ℂ} (hT : F.IsTile T) (hno : ∀ Hc, ¬ IsHoleOf T Hc) :
    (F.mapGraph.induce {T' | T' ≠ ⟨T, hT⟩}).Connected := by
  sorry

/-- **FS114-CVB-PINCH, the hole clause** (B1): in the map graph of a valid map of the plane, removing a tile with a hole disconnects the graph
(the tiles inside the hole from those outside). Whether a valid plane map with a holed tile exists is not claimed (the row: "every valid map
cannot be refuted by an object"); the local configuration is `exists_holed_valid_fragment`. `GENERIC` on plane maps. -/
theorem cvb_hole_disconnected (hF : F.Valid) (hP : F.IsPlaneMap) {T Hc : Set ℂ} (hT : F.IsTile T) (hH : IsHoleOf T Hc) :
    ¬ (F.mapGraph.induce {T' | T' ≠ ⟨T, hT⟩}).Connected := by
  sorry

end ArcMap

/-- **Holes are locally consistent with validity** (FS114-CVB-PINCH's last clause, CVB B1's counterexample configuration): there is a valid
six-coloured fragment covering `B̄(0, 1/2)` with a tile that has a hole — the annulus `1/4 < |z| < 1/2` of colour `1` about the disc
`|z| < 1/4` of colour `2`, ringed by four quarter-annuli `1/2 < |z| < 0.55` of colours `3, 4, 5, 6`. -/
theorem exists_holed_valid_fragment :
    ∃ F : ArcMap 6, F.Valid ∧ F.Covers 0 (1 / 2) ∧ ∃ T Hc, F.IsTile T ∧ ArcMap.IsHoleOf T Hc := by
  sorry

end HadwigerNelson.Plane
