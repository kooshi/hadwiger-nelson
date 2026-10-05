import Proofs.HadwigerNelson.Plane.SVMap
import Proofs.HadwigerNelson.Plane.ValidMap.MapTopology
import Mathlib.Combinatorics.SimpleGraph.Paths
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Subgraph
import Mathlib.Combinatorics.SimpleGraph.Metric
import Mathlib.Combinatorics.Enumerative.DoubleCounting
import Proofs.HadwigerNelson.Thomassen

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

**On a map** (`ArcMap`): `mapGraph` (tiles, adjacent when their closures meet), `IsHoleOf` (a nonempty bounded part of the complement of a tile's
closure separated from the rest of it — "a boundary component of `x` disjoint from its outer one", read through the closure; FS131-KP), `fill` (a tile with its holes),
`IsOuterTile` (a tile inside no hole of another tile), `filledGraph` (the filled map's graph: outer tiles, adjacent when their filled closures
meet).

Rows: `cvb_thom_reduced` (B2 steps 1–3: `H` connected, locally finite, locally Hamiltonian, infinite), `cvb_thom` (B2 step 4: a vertex of
`H`-degree at least `6`), `cvb_pinch_connected` and `cvb_hole_disconnected` (B1), `exists_holed_valid_fragment` (B1's "holes are locally
consistent with validity"). Not claimed (the row's own line): the rainbow step on valid maps; the 2-separator criterion at pinches as more
than a sketch.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- **The map graph `M`** (CVB § 1.9's frame): the tiles, two distinct tiles adjacent when their closures meet. -/
def mapGraph : SimpleGraph {T : Set ℂ // F.IsTile T} where
  Adj T T' := T ≠ T' ∧ (closure T.1 ∩ closure T'.1).Nonempty
  symm := ⟨fun T T' h => ⟨h.1.symm, by rw [inter_comm]; exact h.2⟩⟩
  loopless := ⟨fun T h => h.1 rfl⟩

/-- **`Hc` is a hole of `T`** (CVB B1: "a boundary component of `x` disjoint from its outer one"; FS131-KP's repair, plan § 2): a nonempty
bounded part of the complement of `T`'s closure whose closure misses the closure of the rest of that complement. The separation makes `Hc` a
union of whole clusters of complementary components (components chained by touching closures) not containing the unbounded one; so `T` has a
hole exactly when the complementary components, joined when their closures touch, are not one cluster — exactly when `mapGraph − T` is
disconnected. It reads the complement of the closure, not the components of `∂T`: a phantom slit can join `∂T`'s components while `cl T`
still separates (plan § 2.2). Not required to be one cluster: `fill`, `IsOuterTile` and the `cvb_*` leaves read holes only through their union
or their existence. -/
def IsHoleOf (T Hc : Set ℂ) : Prop :=
  Hc.Nonempty ∧ Hc ⊆ (closure T)ᶜ ∧ Bornology.IsBounded Hc ∧ Disjoint (closure Hc) (closure ((closure T)ᶜ \ Hc))

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
  rintro ⟨⟨z, hz⟩, hsub, -⟩
  simpa using hsub hz

/-- **Adversary: a chain to the outside is no hole** (FS131-I5b's counterexample to the old definition, as a plane set; plan § 2.3): the
unit disc minus the closed discs of radius `1/4` about `1/4` and `3/4` — the first touches the second at `1/2`, the second touches the unit
circle at `1`. A separated part of the complement holding either small disc holds the other, then the outside, so it is unbounded. (Under the
old definition the disc about `1/4` was a hole, and `cvb_hole_disconnected` was false.) -/
theorem not_isHoleOf_chain (Hc : Set ℂ) :
    ¬ ArcMap.IsHoleOf (ball 0 1 \ (closedBall (1 / 4 : ℂ) (1 / 4) ∪ closedBall (3 / 4 : ℂ) (1 / 4))) Hc := by
  sorry

/-- **A cluster is one hole** (item 242's case; plan § 2.3): the unit disc minus the closed discs of radius `1/4` about `±1/4`, which touch at
`0` and miss the unit circle; the two open small discs together are a hole (neither alone is: their closures touch). Exercises the separation
clause on a hole of two components. -/
theorem isHoleOf_cluster :
    ArcMap.IsHoleOf (ball 0 1 \ (closedBall (-1 / 4 : ℂ) (1 / 4) ∪ closedBall (1 / 4 : ℂ) (1 / 4)))
      (ball (-1 / 4 : ℂ) (1 / 4) ∪ ball (1 / 4 : ℂ) (1 / 4)) ∧
    ¬ ArcMap.IsHoleOf (ball 0 1 \ (closedBall (-1 / 4 : ℂ) (1 / 4) ∪ closedBall (1 / 4 : ℂ) (1 / 4))) (ball (1 / 4 : ℂ) (1 / 4)) := by
  sorry

end Spec

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS114-CVB-THOM -/

/-- The filled map graph is locally finite (FS131-KP plan § 4, leaf F-LOC): a filled tile lies in its hull, inside `B̄(x, 1)` for any `x` in
its closure (`IsTile.closure_subset_closedBall`, `exists_outermost`'s hull bound), so the tiles whose filled closures meet it have closures
meeting a compact set (`finite_tiles_closure_inter`). -/
theorem filledGraph_locallyFinite (hF : F.Valid) (hP : F.IsPlaneMap) (x : {T : Set ℂ // F.IsOuterTile T}) :
    (F.filledGraph.neighborSet x).Finite := by
  sorry

/-- The filled map graph is connected (leaf F-CONN): the filled outer tiles' closures cover the plane (every tile lies in an outer tile's
fill: the enclosure chain stops, as in `exists_outermost`), so `mem_of_touch_closed` on `U = ℂ` with the touching relation of the fills. -/
theorem filledGraph_connected (hF : F.Valid) (hP : F.IsPlaneMap) : F.filledGraph.Connected := by
  sorry

/-- The filled map graph is infinite (leaf F-INF): the plane is unbounded and every filled tile bounded. -/
theorem filledGraph_infinite (hF : F.Valid) (hP : F.IsPlaneMap) : Infinite {T : Set ℂ // F.IsOuterTile T} := by
  sorry

/-- **Rings from boundary walks** (leaf F-RING, the planar heart of CVB B2 step 2): every filled outer tile `x̂` has a ring — the outer
boundary walk of `x̂` (`frontier (outerDom x)`, preconnected), listing the tiles met at each pass (sector charts), each repeated tile only at
its edge contacts — and `M̂ − x − y` is connected unless `y` appears twice apart (a bounded component of `ℂ ∖ (cl x̂ ∪ cl ŷ)` is enclosed by
edges of both; CVB's sketch, one mind). Plan § 4: the boundary walk is built over the finite boundary graph of `F` near `cl x̂` (the same
graph as `exists_far_end`'s); separation by `isPreconnected_frontier_connectedComponentIn` and `inter_nonempty_of_interleaved`. **H**, the
wave's longest leaf; may be its own job (Keryx's call after the implementer's measurement). -/
theorem filledGraph_rings (hF : F.Valid) (hP : F.IsPlaneMap) (x : {T : Set ℂ // F.IsOuterTile T}) :
    ∃ r, Thomassen.IsRing F.filledGraph x r ∧
      ∀ y, y ≠ x → ¬ Thomassen.TwiceApart r y → (F.filledGraph.induce (Thomassen.offTwo x y)).Connected := by
  sorry

/-- **One infinite component** (leaf F-ONE, CVB B2 step 2): for distinct outer tiles `x`, `y`, `M̂ − x − y` has exactly one infinite
component — the tiles of the unbounded component of `ℂ ∖ (cl x̂ ∪ cl ŷ)` are chained (`mem_of_touch_closed`) and infinitely many, those of
bounded components finitely many (`finite_tiles_closure_inter` on the hull), and every component meeting no unbounded tile is among them. -/
theorem filledGraph_oneInf (hF : F.Valid) (hP : F.IsPlaneMap) (x y : {T : Set ℂ // F.IsOuterTile T}) (hxy : x ≠ y) :
    ∃ c : (F.filledGraph.induce (Thomassen.offTwo x y)).ConnectedComponent, ¬ c.supp.Finite ∧ ∀ c', ¬ c'.supp.Finite → c' = c := by
  sorry

/-- **Finitely many pairs enclose a tile** (leaf F-SEP, inventory item 309; FS131-IT1's sketch, one mind): a filled outer tile `v` lies in the
interior of finitely many pairs of `M̂`. If `v ∈ int(x, y)` then `{x, y}` is a 2-separator, so `x̂` and `ŷ` touch (the rings), and `v̂` lies in a
bounded component of `ℂ ∖ (cl x̂ ∪ cl ŷ)`, inside that compact set's convex hull, so `cl x̂` and `cl ŷ` meet `B̄(p, 3)` for any `p ∈ cl v̂` (filled
tiles of diameter at most `1`), and only finitely many tiles do (`finite_tiles_closure_inter`). -/
theorem filledGraph_finSep (hF : F.Valid) (hP : F.IsPlaneMap) (v : {T : Set ℂ // F.IsOuterTile T}) :
    {p : {T : Set ℂ // F.IsOuterTile T} × {T : Set ℂ // F.IsOuterTile T} | v ∈ Thomassen.twoSepInterior F.filledGraph p.1 p.2}.Finite := by
  sorry

/-- **The filled map graph of a valid plane map has Thomassen's planar properties** (CVB B2 steps 1–3; the six leaves above). -/
theorem filledGraph_planarLike (hF : F.Valid) (hP : F.IsPlaneMap) : Thomassen.PlanarLike F.filledGraph :=
  ⟨filledGraph_locallyFinite hF hP, filledGraph_connected hF hP, filledGraph_infinite hF hP, filledGraph_rings hF hP,
    filledGraph_oneInf hF hP, filledGraph_finSep hF hP⟩

/-- **FS114-CVB-THOM, B2 steps 1–3** (`plans/FS114-CVB-verification.md` § 1.9): for every valid map of the plane, Siamese pairs allowed, the
reduced filled map graph `H` is connected, locally finite, locally Hamiltonian and infinite — `[Thomassen1999]`'s steps other than the
rainbow step, with holes filled, facial cycles read as boundary walks, and the count in `int(R)` replaced by local finiteness. Colour-free
(CVB: "indeed every locally finite plane map with bounded connected tiles"); validity enters only through the tiles' diameter `≤ 1`
(`dist_lt_one_of_forall_dist_ne_one`). Every `k`. Model of the hypotheses: `sevenBrickMap` (valid, of the plane, `k = 7`). -/
theorem cvb_thom_reduced (hF : F.Valid) (hP : F.IsPlaneMap) :
    (Thomassen.reduced F.filledGraph).Connected ∧ (∀ x, ((Thomassen.reduced F.filledGraph).neighborSet x).Finite) ∧
      Thomassen.LocallyHamiltonian (Thomassen.reduced F.filledGraph) ∧ Infinite (Thomassen.reducedVerts F.filledGraph) :=
  Thomassen.reduced_props_of_planarLike _ (filledGraph_planarLike hF hP)

/-- **FS114-CVB-THOM** (B2 step 4): every valid map of the plane, Siamese pairs allowed, has an outer tile of degree at least `6` in the reduced
filled map graph `H` (`cvb_thom_reduced` and `Thomassen.lemma1`). The rainbow step — that such a tile's neighbours carry six colours — is not
claimed (it fails on valid maps: FS114-N114-RD's types (A) and (B)). Model of the hypotheses: `sevenBrickMap` (`k = 7`; its bricks have six
neighbours each). -/
theorem cvb_thom (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ x, 6 ≤ ((Thomassen.reduced F.filledGraph).neighborSet x).encard := by
  obtain ⟨hc, hfin, hH, hinf⟩ := cvb_thom_reduced hF hP
  exact Thomassen.lemma1 _ hfin hc hH (by rw [ENat.card_eq_top_of_infinite]; exact le_top)

/-- **FS114-CVB-PINCH, the pinch clause** (B1): in the map graph of a valid map of the plane, removing a tile with no hole leaves the graph
connected — at a pinched tile (its boundary walk visits a vertex twice) as at a simple one. Read at the class the argument reads (every tile
with no hole; Thomassen's own case is the unpinched one). Model of the hypotheses: a brick of `sevenBrickMap`. -/
theorem cvb_pinch_connected (hF : F.Valid) (hP : F.IsPlaneMap) {T : Set ℂ} (hT : F.IsTile T) (hno : ∀ Hc, ¬ IsHoleOf T Hc) :
    (F.mapGraph.induce {T' | T' ≠ ⟨T, hT⟩}).Connected := by
  -- FS131-KP plan § 4, leaf PINCH: through the separation, with local finiteness read at one point only
  set O := (closure T)ᶜ with hO
  have hOo : IsOpen O := isClosed_closure.isOpen_compl
  have hdom : ∀ S : Set ℂ, S ⊆ F.dom := fun S => by rw [hP]; exact subset_univ _
  have hTne : ∀ A, F.IsTile A → (A ∩ O).Nonempty → A ≠ T := by
    rintro A - ⟨z, hzA, hzO⟩ rfl
    exact hzO (subset_closure hzA)
  -- `cl T` is bounded (`IsTile.closure_subset_closedBall`)
  obtain ⟨x, hx⟩ := hT.nonempty
  have hTR : closure T ⊆ closedBall 0 (‖x‖ + 1) := by
    intro z hz
    have := hT.closure_subset_closedBall hF (subset_closure hx) hz
    rw [mem_closedBall, dist_zero_right]; rw [mem_closedBall] at this
    linarith [norm_le_norm_add_norm_sub' z x, dist_eq_norm z x]
  set R := ‖x‖ + 1
  have hfarO : (closedBall (0 : ℂ) R)ᶜ ⊆ O := fun z hz h => hz (hTR h)
  have hfarne : ((closedBall (0 : ℂ) R)ᶜ).Nonempty :=
    ⟨((|R| + 1 : ℝ) : ℂ), by
      rw [mem_compl_iff, mem_closedBall, dist_zero_right, Complex.norm_real, Real.norm_of_nonneg (by positivity), not_le]
      linarith [le_abs_self R]⟩
  -- a tile other than `T` lies off `cl T`, inside the component of `O` of any of its points
  have hsubC : ∀ A, F.IsTile A → A ≠ T → ∀ a ∈ A, A ⊆ connectedComponentIn O a := fun A hA hAT a ha =>
    hA.isPreconnected.subset_connectedComponentIn ha (IsTile.subset_compl_closure hT hA hAT)
  -- the vertices of `M − T`, and the tiles reachable from a fixed one `A`
  set G := F.mapGraph.induce {T' | T' ≠ ⟨T, hT⟩} with hG
  let mk : ∀ A, F.IsTile A → A ≠ T → {T' : {T : Set ℂ // F.IsTile T} // T' ∈ {T' | T' ≠ ⟨T, hT⟩}} :=
    fun A hA hAT => ⟨⟨A, hA⟩, fun h => hAT (congrArg Subtype.val h)⟩
  -- `M − T` has a vertex: a tile meeting the complement of a large disc
  obtain ⟨A, hA, a, haA, haW⟩ := exists_tile_inter_of_isOpen isClosed_closedBall.isOpen_compl (hdom _) hfarne
  have hAT : A ≠ T := hTne A hA ⟨a, haA, hfarO haW⟩
  set vA := mk A hA hAT
  set P : Set (Set ℂ) := {S | ∃ (hS : F.IsTile S) (hST : S ≠ T), G.Reachable vA (mk S hS hST)} with hPdef
  have hAP : A ∈ P := ⟨hA, hAT, SimpleGraph.Reachable.refl (G := G) _⟩
  -- every tile in a component of `O` that holds a tile of `P` is in `P` (`mem_of_touch_closed`)
  have hcomp : ∀ w ∈ O, (∃ S ∈ P, (S ∩ connectedComponentIn O w).Nonempty) →
      ∀ S, F.IsTile S → S ⊆ connectedComponentIn O w → S ∈ P := by
    intro w hw ⟨S₀, hS₀P, hS₀w⟩
    set U := connectedComponentIn O w
    have hUo : IsOpen U := hOo.connectedComponentIn
    have hin : ∀ S, F.IsTile S → (S ∩ U).Nonempty → S ⊆ U := by
      rintro S hS ⟨z, hzS, hzU⟩
      have hST := hTne S hS ⟨z, hzS, connectedComponentIn_subset _ _ hzU⟩
      rw [show U = connectedComponentIn O z from connectedComponentIn_eq hzU]
      exact hsubC S hS hST z hzS
    have key := mem_of_touch_closed hUo isPreconnected_connectedComponentIn (hdom _) hin {S | S ∈ P ∧ S ⊆ U}
      (fun S hS => ⟨hS.1.1, hS.2⟩) ⟨S₀, hS₀P, hin S₀ hS₀P.1 hS₀w⟩ (by
        rintro S ⟨⟨hS, hST, hreach⟩, hSU⟩ S' hS' hS'U hcl
        refine ⟨?_, hS'U⟩
        by_cases hSS' : S = S'
        · exact hSS' ▸ ⟨hS, hST, hreach⟩
        · obtain ⟨z, hz⟩ := hS'.nonempty
          have hS'T := hTne S' hS' ⟨z, hz, connectedComponentIn_subset _ _ (hS'U hz)⟩
          refine ⟨hS', hS'T, hreach.trans (SimpleGraph.Adj.reachable ?_)⟩
          exact ⟨fun h => hSS' (congrArg Subtype.val h), hcl⟩)
    intro S hS hSU
    exact (key S hS hSU).1
  -- `Y`: the union of the components of `O` holding a tile of `P`; `Hc` the rest of `O`
  set Y := {z | z ∈ O ∧ ∃ S ∈ P, (S ∩ connectedComponentIn O z).Nonempty} with hYdef
  set Hc := O \ Y with hHcdef
  have hYsat : ∀ z ∈ O, ∀ w ∈ connectedComponentIn O z, (w ∈ Y ↔ z ∈ Y) := by
    intro z hz w hw
    rw [hYdef, mem_setOf_eq, mem_setOf_eq, ← connectedComponentIn_eq hw]
    exact ⟨fun h => ⟨hz, h.2⟩, fun h => ⟨connectedComponentIn_subset _ _ hw, h.2⟩⟩
  have hYo : IsOpen Y := by
    rw [isOpen_iff_forall_mem_open]
    intro z hz
    exact ⟨connectedComponentIn O z, fun w hw => (hYsat z hz.1 w hw).mpr hz, hOo.connectedComponentIn,
      mem_connectedComponentIn hz.1⟩
  have hHo : IsOpen Hc := by
    rw [isOpen_iff_forall_mem_open]
    intro z hz
    exact ⟨connectedComponentIn O z, fun w hw => ⟨connectedComponentIn_subset _ _ hw,
      fun hwY => hz.2 ((hYsat z hz.1 w hw).mp hwY)⟩, hOo.connectedComponentIn, mem_connectedComponentIn hz.1⟩
  have hOY : O \ Hc = Y := by
    ext z; constructor
    · rintro ⟨hzO, hzH⟩; by_contra hzY; exact hzH ⟨hzO, hzY⟩
    · intro hz; exact ⟨hz.1, fun h => h.2 hz⟩
  have hOH : O \ Y = Hc := rfl
  -- a tile meeting `Y` is in `P`
  have hYP : ∀ S, F.IsTile S → (S ∩ Y).Nonempty → S ∈ P := by
    rintro S hS ⟨z, hzS, hzY⟩
    exact hcomp z hzY.1 hzY.2 S hS (hsubC S hS (hTne S hS ⟨z, hzS, hzY.1⟩) z hzS)
  -- `Hc` and `Y` are separated: a common closure point lies in `cl T`, where tiles of both touch
  have hsep : Disjoint (closure Hc) (closure Y) := by
    rw [Set.disjoint_left]
    intro z hzH hzY
    obtain ⟨X, hX, ⟨x', hx'X, hx'H⟩, hzX⟩ := exists_tile_mem_closure_of_mem_closure hHo (hdom _ (mem_univ z)) hzH
    obtain ⟨W, hW, ⟨w, hwW, hwY⟩, hzW⟩ := exists_tile_mem_closure_of_mem_closure hYo (hdom _ (mem_univ z)) hzY
    have hWP := hYP W hW ⟨w, hwW, hwY⟩
    have hXT := hTne X hX ⟨x', hx'X, hx'H.1⟩
    have hXP : X ∈ P := by
      by_cases hXW : X = W
      · exact hXW ▸ hWP
      · obtain ⟨hW', hWT, hreach⟩ := hWP
        exact ⟨hX, hXT, hreach.trans (SimpleGraph.Adj.reachable ⟨fun h => hXW (congrArg Subtype.val h).symm, z, hzW, hzX⟩)⟩
    exact hx'H.2 ⟨hx'H.1, X, hXP, x', hx'X, mem_connectedComponentIn hx'H.1⟩
  -- the far part lies in `Y` (it holds `a`), so `Hc` is bounded: empty, or a hole
  have haY : a ∈ Y := ⟨hfarO haW, A, hAP, a, haA, mem_connectedComponentIn (hfarO haW)⟩
  have hfarY : (closedBall (0 : ℂ) R)ᶜ ⊆ Y :=
    (isPreconnected_compl_closedBall (0 : ℂ) R).subset_left_of_subset_union hYo hHo
      (Set.disjoint_left.mpr fun z hzY hzH => hzH.2 hzY) (fun z hz => by
        by_cases hzY : z ∈ Y
        · exact Or.inl hzY
        · exact Or.inr ⟨hfarO hz, hzY⟩) ⟨a, haW, haY⟩
  have hHc : Hc = ∅ := by
    by_contra hne'
    apply hno Hc
    refine ⟨nonempty_iff_ne_empty.mpr hne', fun z hz => hz.1, (isBounded_closedBall (x := (0 : ℂ)) (r := R)).subset ?_, ?_⟩
    · intro z hz
      by_contra hzR
      exact hz.2 (hfarY hzR)
    · rw [hOY]; exact hsep
  -- so every tile other than `T` is in `P`: `M − T` is connected
  have hall : ∀ S, F.IsTile S → S ≠ T → S ∈ P := by
    intro S hS hST
    obtain ⟨z, hz⟩ := hS.nonempty
    have hzO : z ∈ O := IsTile.subset_compl_closure hT hS hST hz
    have hzY : z ∈ Y := by
      by_contra hzY
      have : z ∈ Hc := ⟨hzO, hzY⟩
      rw [hHc] at this
      exact this
    exact hYP S hS ⟨z, hz, hzY⟩
  haveI : Nonempty {T' : {T : Set ℂ // F.IsTile T} // T' ∈ {T' | T' ≠ ⟨T, hT⟩}} := ⟨vA⟩
  refine ⟨fun v w => ?_⟩
  obtain ⟨⟨S, hS⟩, hSv⟩ := v
  obtain ⟨⟨S', hS'⟩, hS'v⟩ := w
  have hST : S ≠ T := fun h => hSv (Subtype.ext h)
  have hS'T : S' ≠ T := fun h => hS'v (Subtype.ext h)
  obtain ⟨h1S, h1T, h1⟩ := hall S hS hST
  obtain ⟨h2S, h2T, h2⟩ := hall S' hS' hS'T
  exact h1.symm.trans h2

/-- **FS114-CVB-PINCH, the hole clause** (B1): in the map graph of a valid map of the plane, removing a tile with a hole disconnects the graph
(the tiles inside the hole from those outside). Whether a valid plane map with a holed tile exists is not claimed (the row: "every valid map
cannot be refuted by an object"); the local configuration is `exists_holed_valid_fragment`. `GENERIC` on plane maps. -/
theorem cvb_hole_disconnected (hF : F.Valid) (hP : F.IsPlaneMap) {T Hc : Set ℂ} (hT : F.IsTile T) (hH : IsHoleOf T Hc) :
    ¬ (F.mapGraph.induce {T' | T' ≠ ⟨T, hT⟩}).Connected := by
  -- FS131-KP plan § 4, leaf HOLE: no Jordan curve theorem, only the separation clause
  obtain ⟨hne, hsub, hb, hsep⟩ := hH
  set O := (closure T)ᶜ with hO
  -- `Hc` and the rest of `(cl T)ᶜ` are open (`Hc = (cl T)ᶜ \ cl ((cl T)ᶜ \ Hc)`)
  have hHeq : Hc = O \ closure (O \ Hc) := by
    ext z
    constructor
    · intro hz
      exact ⟨hsub hz, fun h => Set.disjoint_left.mp hsep (subset_closure hz) h⟩
    · rintro ⟨hzO, hzn⟩
      by_contra hzH
      exact hzn (subset_closure ⟨hzO, hzH⟩)
  have hHo : IsOpen Hc := by
    rw [hHeq]; exact isClosed_closure.isOpen_compl.sdiff isClosed_closure
  -- a tile other than `T` lies inside `Hc` or inside the rest
  have hside : ∀ A, F.IsTile A → A ≠ T → A ⊆ Hc ∨ A ⊆ O \ Hc := by
    intro A hA hAT
    refine hA.subset_or_subset_of_separated hsep fun z hz => ?_
    by_cases hzH : z ∈ Hc
    · exact Or.inl hzH
    · exact Or.inr ⟨IsTile.subset_compl_closure hT hA hAT hz, hzH⟩
  have hTne : ∀ A, F.IsTile A → (A ∩ O).Nonempty → A ≠ T := by
    rintro A - ⟨z, hzA, hzO⟩ rfl
    exact hzO (subset_closure hzA)
  -- a tile inside the hole (`exists_tile_inter_of_isOpen`, `IsTile.subset_compl_closure`, `IsTile.subset_or_subset_of_separated`)
  have hin : ∃ A, F.IsTile A ∧ A ⊆ Hc := by
    obtain ⟨A, hA, z, hzA, hzH⟩ := exists_tile_inter_of_isOpen hHo (by rw [hP]; exact subset_univ _) hne
    have hAT := hTne A hA ⟨z, hzA, hsub hzH⟩
    refine ⟨A, hA, (hside A hA hAT).resolve_right fun h => (h hzA).2 hzH⟩
  -- a tile outside it: the rest holds the complement of a large disc
  have hout : ∃ B, F.IsTile B ∧ B ≠ T ∧ B ⊆ (closure T)ᶜ \ Hc := by
    obtain ⟨x, hx⟩ := hT.nonempty
    obtain ⟨R₁, hR₁⟩ := hb.subset_closedBall 0
    have hTR : closure T ⊆ closedBall 0 (‖x‖ + 1) := by
      intro z hz
      have := hT.closure_subset_closedBall hF (subset_closure hx) hz
      rw [mem_closedBall, dist_zero_right]; rw [mem_closedBall] at this
      linarith [norm_le_norm_add_norm_sub' z x, dist_eq_norm z x]
    set R := max R₁ (‖x‖ + 1)
    have hW : (closedBall (0 : ℂ) R)ᶜ ⊆ O \ Hc := fun z hz =>
      ⟨fun h => hz (closedBall_subset_closedBall (le_max_right _ _) (hTR h)),
        fun h => hz (closedBall_subset_closedBall (le_max_left _ _) (hR₁ h))⟩
    obtain ⟨B, hB, z, hzB, hzW⟩ := exists_tile_inter_of_isOpen isClosed_closedBall.isOpen_compl
      (by rw [hP]; exact subset_univ _) (show ((closedBall (0 : ℂ) R)ᶜ).Nonempty from
        ⟨((|R| + 1 : ℝ) : ℂ), by
          rw [mem_compl_iff, mem_closedBall, dist_zero_right, Complex.norm_real,
            Real.norm_of_nonneg (by positivity), not_le]
          linarith [le_abs_self R]⟩)
    have hBT := hTne B hB ⟨z, hzB, (hW hzW).1⟩
    exact ⟨B, hB, hBT, (hside B hB hBT).resolve_left fun h => (hW hzW).2 (h hzB)⟩
  -- a walk of `M − T` from `A` to `B` has a dart leaving the tiles inside `Hc`; the dart's two tiles have closures in `cl Hc` and
  -- `cl ((cl T)ᶜ \ Hc)`, disjoint by `hsep`, yet adjacent
  intro hconn
  obtain ⟨A, hA, hAH⟩ := hin
  obtain ⟨B, hB, hBT, hBH⟩ := hout
  obtain ⟨a, haA⟩ := hA.nonempty
  have hAT : A ≠ T := hTne A hA ⟨a, haA, hsub (hAH haA)⟩
  let vA : {T' : {T : Set ℂ // F.IsTile T} // T' ∈ {T' | T' ≠ ⟨T, hT⟩}} := ⟨⟨A, hA⟩, fun h => hAT (congrArg Subtype.val h)⟩
  let vB : {T' : {T : Set ℂ // F.IsTile T} // T' ∈ {T' | T' ≠ ⟨T, hT⟩}} := ⟨⟨B, hB⟩, fun h => hBT (congrArg Subtype.val h)⟩
  obtain ⟨p⟩ := hconn.preconnected vA vB
  obtain ⟨d, -, hd1, hd2⟩ := p.exists_boundary_dart {v | v.1.1 ⊆ Hc} hAH (fun h => by
    obtain ⟨b, hb'⟩ := hB.nonempty
    exact (hBH hb').2 (h hb'))
  obtain ⟨hne', w, hw1, hw2⟩ := d.adj
  have hY : d.snd.1.1 ⊆ O \ Hc :=
    (hside _ d.snd.1.2 fun h => d.snd.2 (Subtype.ext h)).resolve_left hd2
  exact Set.disjoint_left.mp hsep (closure_mono hd1 hw1) (closure_mono hY hw2)

end ArcMap

/-! ### The holed fragment (`exists_holed_valid_fragment`'s object) -/

/-- A preconnected set whose norms avoid `[a, b]` lies on one side of it, the side of any of its points. -/
theorem norm_side_of_isPreconnected {S : Set ℂ} (hS : IsPreconnected S) {a b : ℝ} (hab : a ≤ b)
    (havoid : ∀ z ∈ S, ‖z‖ < a ∨ b < ‖z‖) {z₀ : ℂ} (hz₀ : z₀ ∈ S) :
    (‖z₀‖ < a → ∀ z ∈ S, ‖z‖ < a) ∧ (b < ‖z₀‖ → ∀ z ∈ S, b < ‖z‖) := by
  have hI := hS.image (fun z : ℂ => ‖z‖) continuous_norm.continuousOn
  constructor
  · intro h0 z hz
    by_contra hz'
    push Not at hz'
    obtain ⟨w, hw, hwa⟩ := hI.Icc_subset (mem_image_of_mem _ hz₀) (mem_image_of_mem _ hz) ⟨h0.le, hz'⟩
    rcases havoid w hw with h | h <;> simp only at hwa <;> linarith
  · intro h0 z hz
    by_contra hz'
    push Not at hz'
    obtain ⟨w, hw, hwb⟩ := hI.Icc_subset (mem_image_of_mem _ hz) (mem_image_of_mem _ hz₀) ⟨hz', h0.le⟩
    rcases havoid w hw with h | h <;> simp only at hwb <;> linarith

/-- A point of norm `ρ > 0` lies on the full circle `circ 0 ρ 0 (2π)`. -/
theorem mem_carrier_circ_of_norm {ρ : ℝ} {z : ℂ} (hz : ‖z‖ = ρ) : z ∈ (Arc.circ 0 ρ 0 (2 * π)).carrier := by
  have hpol : z = (ρ : ℂ) * e (Complex.arg z) := by
    rw [← hz]; exact (Complex.norm_mul_exp_arg_mul_I z).symm
  rcases le_or_gt 0 (Complex.arg z) with h | h
  · exact ⟨Complex.arg z, ⟨h, by linarith [Complex.arg_le_pi z, Real.pi_pos]⟩, by
      show (0 : ℂ) + (ρ : ℂ) * e (Complex.arg z) = z; rw [zero_add, ← hpol]⟩
  · refine ⟨Complex.arg z + 2 * π, ⟨by linarith [Complex.neg_pi_lt_arg z], by linarith⟩, ?_⟩
    show (0 : ℂ) + (ρ : ℂ) * e (Complex.arg z + 2 * π) = z
    rw [zero_add, e_add_two_pi, ← hpol]

/-- The points of `circ 0 ρ θ₀ θ₁` have norm `ρ` (`ρ ≥ 0`). -/
theorem norm_of_mem_carrier_circ {ρ θ₀ θ₁ : ℝ} (hρ : 0 ≤ ρ) {z : ℂ} (hz : z ∈ (Arc.circ 0 ρ θ₀ θ₁).carrier) : ‖z‖ = ρ := by
  obtain ⟨θ, -, rfl⟩ := hz
  show ‖(0 : ℂ) + (ρ : ℂ) * e θ‖ = ρ
  rw [zero_add, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg hρ]

/-- The points of the radial segment `seg (u/2) (3u/5)` (`‖u‖ = 1`) have norm in `[1/2, 3/5]`. -/
theorem norm_of_mem_carrier_radial {u z : ℂ} (hu : ‖u‖ = 1) (hz : z ∈ (Arc.seg ((1 / 2 : ℝ) * u) ((3 / 5 : ℝ) * u)).carrier) :
    1 / 2 ≤ ‖z‖ := by
  obtain ⟨a, b, ha, hb, hab, rfl⟩ := hz
  have : a • ((1 / 2 : ℝ) * u) + b • ((3 / 5 : ℝ) * u) = ((a / 2 + 3 * b / 5 : ℝ) : ℂ) * u := by
    simp only [Complex.real_smul]; push_cast; ring
  rw [this, norm_mul, hu, mul_one, Complex.norm_real, Real.norm_of_nonneg (by positivity)]
  linarith

/-- A point `t u` with `‖u‖ = 1`, `t ∈ [1/2, 3/5]`, lies on the radial segment `seg (u/2) (3u/5)`. -/
theorem mem_carrier_radial {u : ℂ} {t : ℝ} (ht : 1 / 2 ≤ t) (ht' : t ≤ 3 / 5) :
    (t : ℂ) * u ∈ (Arc.seg ((1 / 2 : ℝ) * u) ((3 / 5 : ℝ) * u)).carrier := by
  refine ⟨(3 / 5 - t) * 10, (t - 1 / 2) * 10, by linarith, by linarith, by ring, ?_⟩
  simp only [Complex.real_smul]; push_cast; ring

/-- The holed fragment's arcs: the circles of radii `1/4` and `1/2` about `0`, and four radial segments from radius `1/2` to `3/5` on the
axes. -/
noncomputable def holedArcs : Set Arc :=
  {.circ 0 (1 / 4) 0 (2 * π), .circ 0 (1 / 2) 0 (2 * π), .seg ((1 / 2 : ℝ) * 1) ((3 / 5 : ℝ) * 1),
    .seg ((1 / 2 : ℝ) * (-1)) ((3 / 5 : ℝ) * (-1)), .seg ((1 / 2 : ℝ) * I) ((3 / 5 : ℝ) * I),
    .seg ((1 / 2 : ℝ) * (-I)) ((3 / 5 : ℝ) * (-I))}

/-- The holed fragment's colour: `2` on the disc `|z| < 1/4`, `1` on the annulus `1/4 ≤ |z| < 1/2`, and outside it one colour per open
quadrant (`3`, `4`, `5`, `0`). -/
noncomputable def holedCol (z : ℂ) : Fin 6 :=
  if ‖z‖ < 1 / 4 then 2 else if ‖z‖ < 1 / 2 then 1 else
    if 0 < z.re then (if 0 < z.im then 3 else 0) else (if 0 < z.im then 4 else 5)

/-- A spec example for `holedCol`: the centre has colour `2`, the point `3/8` colour `1`. -/
example : holedCol 0 = 2 ∧ holedCol (3 / 8) = 1 := by
  constructor
  · simp [holedCol]
  · have h : ‖(3 / 8 : ℂ)‖ = 3 / 8 := by
      rw [show (3 / 8 : ℂ) = ((3 / 8 : ℝ) : ℂ) by push_cast; ring, Complex.norm_real, Real.norm_of_nonneg (by norm_num)]
    simp only [holedCol, h]; norm_num

/-- Membership in the holed fragment's arcs, by norm: a point on an arc has norm `1/4` or at least `1/2`. -/
theorem norm_of_mem_holedArcs {z : ℂ} (hz : z ∈ ⋃ a ∈ holedArcs, a.carrier) : ‖z‖ = 1 / 4 ∨ 1 / 2 ≤ ‖z‖ := by
  simp only [mem_iUnion, holedArcs, mem_insert_iff, mem_singleton_iff, exists_prop] at hz
  obtain ⟨a, ha, hza⟩ := hz
  rcases ha with rfl | rfl | rfl | rfl | rfl | rfl
  · exact Or.inl (norm_of_mem_carrier_circ (by norm_num) hza)
  · exact Or.inr (norm_of_mem_carrier_circ (by norm_num) hza).ge
  · exact Or.inr (norm_of_mem_carrier_radial (by simp) hza)
  · exact Or.inr (norm_of_mem_carrier_radial (by simp) hza)
  · exact Or.inr (norm_of_mem_carrier_radial (by simp) hza)
  · exact Or.inr (norm_of_mem_carrier_radial (by simp) hza)

/-- Off the holed fragment's arcs, within `3/5`: the norm is not `1/4` or `1/2`, and beyond `1/2` neither coordinate vanishes. -/
theorem holed_off_arcs {z : ℂ} (hd : ‖z‖ < 3 / 5) (hz : z ∉ ⋃ a ∈ holedArcs, a.carrier) :
    ‖z‖ ≠ 1 / 4 ∧ ‖z‖ ≠ 1 / 2 ∧ (1 / 2 < ‖z‖ → z.re ≠ 0 ∧ z.im ≠ 0) := by
  have hmem : ∀ a ∈ holedArcs, z ∉ a.carrier := fun a ha h => hz (mem_biUnion ha h)
  refine ⟨fun h => hmem _ (by simp [holedArcs]) (mem_carrier_circ_of_norm h),
    fun h => hmem _ (by simp [holedArcs]) (mem_carrier_circ_of_norm h), fun h => ⟨fun hre => ?_, fun him => ?_⟩⟩
  · -- on the imaginary axis
    obtain ⟨t, rfl⟩ : ∃ t : ℝ, z = (t : ℂ) * I := ⟨z.im, by apply Complex.ext <;> simp [hre]⟩
    have hn : ‖(t : ℂ) * I‖ = |t| := by rw [norm_mul, Complex.norm_I, mul_one, Complex.norm_real, Real.norm_eq_abs]
    rw [hn] at h hd
    rcases le_or_gt 0 t with h0 | h0
    · rw [abs_of_nonneg h0] at h hd
      exact hmem _ (by simp [holedArcs]) (mem_carrier_radial (u := I) (by linarith) (by linarith))
    · rw [abs_of_neg h0] at h hd
      have : (t : ℂ) * I = ((-t : ℝ) : ℂ) * (-I) := by push_cast; ring
      rw [this] at hmem
      exact hmem _ (by simp [holedArcs]) (mem_carrier_radial (u := -I) (by linarith) (by linarith))
  · -- on the real axis
    obtain ⟨t, rfl⟩ : ∃ t : ℝ, z = (t : ℂ) * 1 := ⟨z.re, by apply Complex.ext <;> simp [him]⟩
    have hn : ‖(t : ℂ) * 1‖ = |t| := by rw [mul_one, Complex.norm_real, Real.norm_eq_abs]
    rw [hn] at h hd
    rcases le_or_gt 0 t with h0 | h0
    · rw [abs_of_nonneg h0] at h hd
      exact hmem _ (by simp [holedArcs]) (mem_carrier_radial (u := 1) (by linarith) (by linarith))
    · rw [abs_of_neg h0] at h hd
      have : (t : ℂ) * 1 = ((-t : ℝ) : ℂ) * (-1) := by push_cast; ring
      rw [this] at hmem
      exact hmem _ (by simp [holedArcs]) (mem_carrier_radial (u := -1) (by linarith) (by linarith))

/-- **The holed fragment** (CVB B1's configuration): the disc `|z| < 1/4` of colour `2` inside the annulus `1/4 < |z| < 1/2` of colour `1`,
ringed by four quarter-annuli `1/2 < |z| < 3/5` of colours `3`, `4`, `5`, `0`; domain `B(0, 3/5)`. -/
noncomputable def holedFrag : ArcMap 6 where
  dom := ball 0 (3 / 5)
  isOpen_dom := isOpen_ball
  arcs := holedArcs
  nondegenerate := by
    intro a ha
    simp only [holedArcs, mem_insert_iff, mem_singleton_iff] at ha
    rcases ha with rfl | rfl | rfl | rfl | rfl | rfl <;> simp only [Arc.Nondegenerate]
    · exact ⟨by norm_num, by positivity, by linarith⟩
    · exact ⟨by norm_num, by positivity, by linarith⟩
    all_goals
      intro h
      have := congrArg (fun w : ℂ => ‖w‖) h
      simp only [norm_mul, Complex.norm_real, norm_neg, Complex.norm_I, norm_one] at this
      norm_num at this
  locallyFinite := by
    intro x _
    refine ⟨univ, univ_mem, ?_⟩
    refine Set.Finite.subset ?_ (fun a ha => ha.1)
    simp only [holedArcs]
    exact ((((((Set.finite_singleton _).insert _).insert _).insert _).insert _).insert _)
  col := holedCol
  locallyConstant := by
    intro x hx hxa
    have hd : ‖x‖ < 3 / 5 := by simpa using hx
    obtain ⟨h4, h2, hax⟩ := holed_off_arcs hd hxa
    have hcn := continuous_norm.tendsto x
    rcases lt_or_gt_of_ne h4 with hlt | hgt
    · filter_upwards [hcn.eventually (gt_mem_nhds hlt)] with y hy
      simp only [holedCol, if_pos hy, if_pos hlt]
    rcases lt_or_gt_of_ne h2 with hlt2 | hgt2
    · filter_upwards [hcn.eventually (lt_mem_nhds hgt), hcn.eventually (gt_mem_nhds hlt2)] with y hy hy'
      simp only [holedCol, if_neg (not_lt.mpr hy.le), if_pos hy', if_neg (not_lt.mpr hgt.le), if_pos hlt2]
    obtain ⟨hre, him⟩ := hax hgt2
    have hre' : ∀ᶠ y in 𝓝 x, (0 < y.re ↔ 0 < x.re) := by
      rcases lt_or_gt_of_ne hre with h | h
      · filter_upwards [(Complex.continuous_re.tendsto x).eventually (gt_mem_nhds h)] with y hy
        exact ⟨fun h' => by linarith, fun h' => by linarith⟩
      · filter_upwards [(Complex.continuous_re.tendsto x).eventually (lt_mem_nhds h)] with y hy
        exact ⟨fun _ => h, fun _ => hy⟩
    have him' : ∀ᶠ y in 𝓝 x, (0 < y.im ↔ 0 < x.im) := by
      rcases lt_or_gt_of_ne him with h | h
      · filter_upwards [(Complex.continuous_im.tendsto x).eventually (gt_mem_nhds h)] with y hy
        exact ⟨fun h' => by linarith, fun h' => by linarith⟩
      · filter_upwards [(Complex.continuous_im.tendsto x).eventually (lt_mem_nhds h)] with y hy
        exact ⟨fun _ => h, fun _ => hy⟩
    filter_upwards [hcn.eventually (lt_mem_nhds hgt2), hre', him'] with y hy hyr hyi
    have h1 : ¬ ‖y‖ < 1 / 4 := by linarith
    have h1' : ¬ ‖y‖ < 1 / 2 := by linarith
    have h3 : ¬ ‖x‖ < 1 / 4 := by linarith
    have h3' : ¬ ‖x‖ < 1 / 2 := by linarith
    simp only [holedCol, if_neg h1, if_neg h1', if_neg h3, if_neg h3', hyr, hyi]

/-- Two points of norm below `3/5` whose coordinates agree in sign (weakly) are less than `1` apart. -/
theorem dist_lt_one_of_same_quadrant {x y : ℂ} (hx : ‖x‖ < 3 / 5) (hy : ‖y‖ < 3 / 5) (hre : 0 ≤ x.re * y.re)
    (him : 0 ≤ x.im * y.im) : dist x y < 1 := by
  have hx2 : x.re ^ 2 + x.im ^ 2 < 9 / 25 := by
    have := Complex.sq_norm x; rw [Complex.normSq_apply] at this; nlinarith [norm_nonneg x]
  have hy2 : y.re ^ 2 + y.im ^ 2 < 9 / 25 := by
    have := Complex.sq_norm y; rw [Complex.normSq_apply] at this; nlinarith [norm_nonneg y]
  have hd : dist x y ^ 2 = (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 := by
    rw [dist_eq_norm, Complex.sq_norm, Complex.normSq_apply]; simp only [Complex.sub_re, Complex.sub_im]; ring
  nlinarith [dist_nonneg (x := x) (y := y)]

/-- The holed fragment is valid: each colour class is one piece of diameter below `1`. -/
theorem holedFrag_valid : holedFrag.Valid := by
  intro x hx y hy hxy hcol
  have hxd : ‖x‖ < 3 / 5 := by simpa [holedFrag] using hx.1
  have hyd : ‖y‖ < 3 / 5 := by simpa [holedFrag] using hy.1
  change holedCol x = holedCol y at hcol
  have hlt : dist x y < 1 := by
    unfold holedCol at hcol
    split_ifs at hcol with a1 a2 a3 a4 b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 <;>
      first
      | exact absurd hcol (by decide)
      | (rw [dist_eq_norm]; linarith [norm_sub_le x y, norm_neg y])
      | (apply dist_lt_one_of_same_quadrant hxd hyd <;> nlinarith)
  linarith

/-- A spec example for `holedArcs` and `holedFrag`: the inner circle is an arc, the centre has colour `2`, the domain is `B(0, 3/5)`. -/
example : Arc.circ 0 (1 / 4) 0 (2 * π) ∈ holedArcs ∧ holedFrag.col 0 = 2 ∧ holedFrag.dom = ball 0 (3 / 5) :=
  ⟨by simp [holedArcs], by simp [holedFrag, holedCol], rfl⟩

/-- The open annulus `1/4 < |z| < 1/2` is preconnected (the image of a band under polar coordinates). -/
theorem isPreconnected_holedAnnulus : IsPreconnected {z : ℂ | 1 / 4 < ‖z‖ ∧ ‖z‖ < 1 / 2} := by
  have h : {z : ℂ | 1 / 4 < ‖z‖ ∧ ‖z‖ < 1 / 2} = (fun p : ℝ × ℝ => (p.1 : ℂ) * e p.2) '' (Ioo (1 / 4) (1 / 2) ×ˢ univ) := by
    ext z
    constructor
    · rintro ⟨h1, h2⟩
      exact ⟨(‖z‖, Complex.arg z), ⟨⟨h1, h2⟩, mem_univ _⟩, Complex.norm_mul_exp_arg_mul_I z⟩
    · rintro ⟨⟨r, θ⟩, ⟨⟨h1, h2⟩, -⟩, rfl⟩
      have : ‖(r : ℂ) * e θ‖ = r := by rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg (by linarith)]
      simp only [mem_setOf_eq, this]; exact ⟨h1, h2⟩
  rw [h]
  exact (isPreconnected_Ioo.prod isPreconnected_univ).image _ (by unfold e; fun_prop)

/-- **Holes are locally consistent with validity** (FS114-CVB-PINCH's last clause, CVB B1's counterexample configuration): there is a valid
six-coloured fragment covering `B̄(0, 1/2)` with a tile that has a hole — the annulus `1/4 < |z| < 1/2` of colour `1` about the disc
`|z| < 1/4` of colour `2`, ringed by four quarter-annuli `1/2 < |z| < 3/5` of colours `3, 4, 5, 6 = 0` (`holedFrag`). -/
theorem exists_holed_valid_fragment :
    ∃ F : ArcMap 6, F.Valid ∧ F.Covers 0 (1 / 2) ∧ ∃ T Hc, F.IsTile T ∧ ArcMap.IsHoleOf T Hc := by
  set A : Set ℂ := {z : ℂ | 1 / 4 < ‖z‖ ∧ ‖z‖ < 1 / 2} with hA
  have hint : ∀ z ∈ holedFrag.interiorPts, ‖z‖ ≠ 1 / 4 ∧ ‖z‖ ≠ 1 / 2 := by
    intro z hz
    have hd : ‖z‖ < 3 / 5 := by simpa [holedFrag] using hz.1
    obtain ⟨h1, h2, -⟩ := holed_off_arcs hd hz.2
    exact ⟨h1, h2⟩
  have hAint : A ⊆ holedFrag.interiorPts := by
    rintro z ⟨h1, h2⟩
    refine ⟨show z ∈ ball (0 : ℂ) (3 / 5) by rw [mem_ball, dist_zero_right]; linarith, fun hz => ?_⟩
    rcases norm_of_mem_holedArcs hz with h | h <;> linarith
  have h38 : (3 / 8 : ℂ) ∈ A := by
    have : ‖(3 / 8 : ℂ)‖ = 3 / 8 := by
      rw [show (3 / 8 : ℂ) = ((3 / 8 : ℝ) : ℂ) by push_cast; ring, Complex.norm_real, Real.norm_of_nonneg (by norm_num)]
    simp only [hA, mem_setOf_eq, this]; norm_num
  have hn38 : ‖(3 / 8 : ℂ)‖ = 3 / 8 := by
    rw [show (3 / 8 : ℂ) = ((3 / 8 : ℝ) : ℂ) by push_cast; ring, Complex.norm_real, Real.norm_of_nonneg (by norm_num)]
  -- the tile through `3/8` is the annulus
  have hT : A = connectedComponentIn holedFrag.interiorPts (3 / 8) := by
    apply Set.Subset.antisymm (isPreconnected_holedAnnulus.subset_connectedComponentIn h38 hAint)
    intro z hz
    have hC := isPreconnected_connectedComponentIn (x := (3 / 8 : ℂ)) (F := holedFrag.interiorPts)
    have hCsub := connectedComponentIn_subset holedFrag.interiorPts (3 / 8 : ℂ)
    have hmem := mem_connectedComponentIn (hAint h38)
    have hlo := (norm_side_of_isPreconnected hC le_rfl (a := 1 / 4) (fun w hw => lt_or_gt_of_ne (hint w (hCsub hw)).1)
      hmem).2 (by rw [hn38]; norm_num) z hz
    have hhi := (norm_side_of_isPreconnected hC le_rfl (a := 1 / 2) (fun w hw => lt_or_gt_of_ne (hint w (hCsub hw)).2)
      hmem).1 (by rw [hn38]; norm_num) z hz
    exact ⟨hlo, hhi⟩
  -- the closure of the annulus is the closed annulus
  have hclsub : closure A ⊆ {z : ℂ | 1 / 4 ≤ ‖z‖ ∧ ‖z‖ ≤ 1 / 2} :=
    closure_minimal (fun z hz => ⟨hz.1.le, hz.2.le⟩)
      ((isClosed_le continuous_const continuous_norm).inter (isClosed_le continuous_norm continuous_const))
  have hclsup : ∀ z : ℂ, 1 / 4 ≤ ‖z‖ → ‖z‖ ≤ 1 / 2 → z ∈ closure A := by
    intro z h1 h2
    rw [Metric.mem_closure_iff]
    intro ε hε
    set s := min 1 ε with hs
    have hs0 : 0 < s := lt_min one_pos hε
    have hs1 : s ≤ 1 := min_le_left _ _
    have hsε : s ≤ ε := min_le_right _ _
    have hz0 : 0 < ‖z‖ := by linarith
    set c : ℝ := 1 - s + 3 * s / (8 * ‖z‖) with hc
    have hc0 : 0 < c := by
      have : 0 < 3 * s / (8 * ‖z‖) := by positivity
      rw [hc]; linarith
    have hnb : ‖(c : ℂ) * z‖ = (1 - s) * ‖z‖ + 3 * s / 8 := by
      rw [norm_mul, Complex.norm_real, Real.norm_of_nonneg hc0.le, hc]; field_simp
    refine ⟨(c : ℂ) * z, ⟨?_, ?_⟩, ?_⟩
    · rw [hnb]; nlinarith
    · rw [hnb]; nlinarith
    · have : dist z ((c : ℂ) * z) = |1 - c| * ‖z‖ := by
        rw [dist_eq_norm, show z - (c : ℂ) * z = ((1 - c : ℝ) : ℂ) * z by push_cast; ring, norm_mul, Complex.norm_real,
          Real.norm_eq_abs]
      have h8 : (1 - c) * ‖z‖ = s * (‖z‖ - 3 / 8) := by rw [hc]; field_simp; ring
      rw [this, show |1 - c| * ‖z‖ = |(1 - c) * ‖z‖| by rw [abs_mul, abs_of_pos hz0], h8, abs_mul, abs_of_pos hs0]
      have hab : |‖z‖ - 3 / 8| ≤ 1 / 8 := abs_le.mpr ⟨by linarith, by linarith⟩
      nlinarith [abs_nonneg (‖z‖ - 3 / 8)]
  -- the complement of the closed annulus, and its components
  have havoid : ∀ z ∈ (closure A)ᶜ, ‖z‖ < 1 / 4 ∨ 1 / 2 < ‖z‖ := by
    intro z hz
    by_contra h
    push Not at h
    exact hz (hclsup z h.1 h.2)
  have hside : ∀ z ∈ (closure A)ᶜ, (‖z‖ < 1 / 4 → connectedComponentIn (closure A)ᶜ z ⊆ ball 0 (1 / 4)) ∧
      (1 / 2 < ‖z‖ → connectedComponentIn (closure A)ᶜ z ⊆ {w | 1 / 2 < ‖w‖}) := by
    intro z hz
    have hsub := connectedComponentIn_subset (closure A)ᶜ z
    obtain ⟨h1, h2⟩ := norm_side_of_isPreconnected isPreconnected_connectedComponentIn (by norm_num : (1 / 4 : ℝ) ≤ 1 / 2)
      (fun w hw => havoid w (hsub hw)) (mem_connectedComponentIn hz)
    exact ⟨fun h w hw => by rw [mem_ball, dist_zero_right]; exact h1 h w hw, fun h w hw => h2 h w hw⟩
  have h0 : (0 : ℂ) ∈ (closure A)ᶜ := fun h => by have := (hclsub h).1; simp at this; linarith
  have hHc := (hside 0 h0).1 (by simp)
  -- the disc `|z| < 1/4` lies in the hole (preconnected, off `cl A`, through `0`)
  have hball : ball (0 : ℂ) (1 / 4) ⊆ connectedComponentIn (closure A)ᶜ 0 :=
    (convex_ball (0 : ℂ) (1 / 4)).isPreconnected.subset_connectedComponentIn (mem_ball_self (by norm_num))
      (fun w hw hwA => by
        have := (hclsub hwA).1
        rw [mem_ball, dist_zero_right] at hw
        linarith)
  -- the rest of the complement lies beyond `1/2`
  have hrest : (closure A)ᶜ \ connectedComponentIn (closure A)ᶜ 0 ⊆ {w : ℂ | 1 / 2 < ‖w‖} := by
    rintro w ⟨hw, hwn⟩
    rcases havoid w hw with h | h
    · exact absurd (hball (by rw [mem_ball, dist_zero_right]; exact h)) hwn
    · exact h
  refine ⟨holedFrag, holedFrag_valid, fun z hz => ?_, A, connectedComponentIn (closure A)ᶜ 0, ⟨3 / 8, hAint h38, hT⟩,
    ⟨0, mem_connectedComponentIn h0⟩, connectedComponentIn_subset _ _, Metric.isBounded_ball.subset hHc, ?_⟩
  · show z ∈ ball (0 : ℂ) (3 / 5)
    rw [mem_closedBall] at hz; rw [mem_ball]; linarith
  · have hc1 : closure (connectedComponentIn (closure A)ᶜ 0) ⊆ closedBall 0 (1 / 4) :=
      (closure_mono hHc).trans (closure_ball_subset_closedBall)
    have hc2 : closure ((closure A)ᶜ \ connectedComponentIn (closure A)ᶜ 0) ⊆ {w : ℂ | 1 / 2 ≤ ‖w‖} :=
      closure_minimal (fun w hw => show 1 / 2 ≤ ‖w‖ from (show 1 / 2 < ‖w‖ from hrest hw).le)
        (isClosed_le continuous_const continuous_norm)
    refine Set.disjoint_left.mpr fun w hw1 hw2 => ?_
    have := hc1 hw1
    have := hc2 hw2
    simp only [mem_closedBall, dist_zero_right, mem_setOf_eq] at *
    linarith

end HadwigerNelson.Plane
