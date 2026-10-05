# FS131-RL1 — the boundary walk of a filled tile (RING-LIST): the plan for `filledGraph_ringList`

*de Bruijn, the planner; brief `data/fs131/briefs/FS131-RL1-ringlist.md` (on `main`); branch `fs131-w5p`, worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p`. Nothing in this milestone is fenced (inventory ruling 1).*

## Theorems this phase proved

All **[kernel]**, on the standard three axioms (receipt `data/fs131/rl/axioms-rl1.txt`):
- `isPreconnected_diff_ball` — `MapTopology` § F (a preconnected set stays preconnected off a disc whose circle it meets in a nonempty
  preconnected set).
- `inter_nonempty_of_interleaved_exterior` — `MapTopology` § F (the crossing lemma outside a disc).
- `ArcMap.IsBoundaryWalk.cons` — `MapGraph` (clause 2 of the ring from a boundary walk's hinges).
- Reductions, proved over `sorry` children: `IsBoundaryWalk.isRing` (over SEP), `filledGraph_ringList` (over WALK and SEP).

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

Each quoted line checked by eye against its source on disk at `b6f9e761` (branch files) and on `main` (the inventory):

| quotation | source | verdict |
|---|---|---|
| `filledGraph_ringList`'s docstring opening ("**The boundary walk of a filled tile** (F-RING's remaining child; …") | `MapGraph.lean` l. 1301 | exact |
| `theorem filledGraph_ringList (hF : F.Valid) (hP : F.IsPlaneMap) (x : {T : Set ℂ // F.IsOuterTile T}) :` | `MapGraph.lean` l. 1310 | exact |
| `def IsRing (x : V) (r : List V) : Prop :=` | `Thomassen.lean` l. 60 | exact |
| IP5's "**Measured from its first child** …" and "**The ring field is weaker than its docstring reads** …" | `plans/FS131-planar-implementation.md` § 19.2 | exact |
| items 332, 333, 277, 309 (opening lines) | `plans/FS131-close-inventory.md` (main) l. 2762, 2788, 2040, 2461 | exact |
| KP's "**May:** add children (with spec examples; …" | `plans/FS131-planar-kernel-plan.md` § 5.2 | exact |

No mismatch.

### 1.2 What I am planning, and what I may change

The statement, read back: `filledGraph_ringList` asks, for every outer tile `x` of a valid plane map, a list `r` of outer tiles with
`Thomassen.IsRing F.filledGraph x r`: (1) `y ∈ r ↔ Adj x y` — the entries are exactly `x`'s neighbours in `M̂` (outer tiles whose *filled
closures* meet `cl x̂`, so touching at one point counts); (2) cyclically consecutive entries are equal or adjacent; (3) for two positions
`i < j` holding the same `y`, every entry strictly between and every entry strictly outside, both other than `x`, `y`, lie in different
components of `M̂ − x − y`. Clause (3) speaks only of repeated entries: a ring that lists each neighbour once owes no separation at all.

I plan the leaf into named children with `sorry`, read each back, plan each with a price, run the obligation pass, and write the handoff.
**May** (brief, KP § 5.2, ruling 333 (b)): add children in `MapGraph` beside the leaf, pure-topology children in `MapTopology` /
`CurveGraph`, a new module upstream of `MapGraph`; change imports with `ARCHITECTURE.md` and the FS131-KP block of `scripts/Axioms.lean`;
`PlanarLike`'s docstring (ruling 333 (c)). **May not**: change `filledGraph_ringList`, `IsRing`, `PlanarLike`, `fill`, `IsHoleOf`,
`filledGraph`, any statement in `Thomassen`, `PlaneTopology`, `BaseWalk`, `BaseDense`; move the leaf to another module; add an `axiom` or
`native_decide`.

### 1.3 The as-given build

`b6f9e761`, under the slot (40 GiB, 8 cpus, `BATCH=4`): **OK — all 1755 modules up to date, 9 with warnings (every one `sorry`), exit 0**
(`build/gate/build/20261005T053645Z-1699211.log`; driver log `data/fs131/rl/build-asgiven.log`).

## Stage 2 — SAVED: the route

### 2.1 What the ring needs, and two traps a naive walk falls into

The topology of `x̂`: `K = cl x̂` is a continuum without holes (`isPreconnected_closure_fill`, `not_isHoleOf_closure_fill`), so `Kᶜ` is the
unbounded component `W₀` and finitely many bounded *pockets* (complementary components that are no hole: I5b's chain), their closures
chained; `C = ∂K` is compact, and **connected** (unicoherence on `K ∪ cl Kᶜ = ℂ`, with `cl Kᶜ` connected because `K` has no hole). Every
point of `C` lies in `cl x` (a hole's frontier lies in `cl x`), so every tile of `Kᶜ` whose closure meets `C` is outer (a tile inside a hole
of another tile `T'` has its closure off `cl x`, since `x` lies in the rest of `(cl T')ᶜ`), and it is a neighbour of `x`. Conversely a
neighbour's own closure meets `cl x` (child **ADJ**). At a point of `C` the sector chart's branches split three ways: *rays of `C`*
(`x` on one side — never a hole tile of `x`, whose closure misses the rest of the complement — and a tile of `Kᶜ` on the other), inner
branches (both sides in `x̂`), outer branches (both sides in `Kᶜ`); so `C` is near each point a star of curve rays.

**Trap 1 — vertex contacts.** The walk that lists, at every vertex, every tile of the outer angle is not a ring. Adversary (paper): at a
vertex `v` with sectors, counter-clockwise, `x | y | m | y | c`, where `m` sits in a notch of `y` at `v` and `c` is outside — the walk lists
`y, m, y, c`; `y` repeats with `m` between and `c` outside, but `m` and `c` both contain `v`, so they are adjacent in `M̂ − x − y`. This is
exactly Thomassen's rule ("we list only those appearances such that `C_{x_i}` and `C_x` share an edge"), and `IsRing`'s docstring says so.
The repair: keep a tile's **edge** appearances; a tile with no edge appearance keeps one vertex appearance. Dropping a vertex appearance
keeps clause 2, because every tile of one angle contains its vertex.

**Trap 2 — merging walks at a pinch.** Pockets and `W₀` give separate closed walks (one per cycle of the boundary structure below), joined
at shared vertices. Swapping successors at two darts of one vertex (the permutation-merge) splits an edge: the edge's tile `t` then appears
before and after the inserted walk, and the other tiles of the angle at `v` (outside) touch the inserted pocket's tiles at `v` (between) —
separation fails. The repair: **insert one walk inside an angle of the other**, between two consecutive tiles of that angle (both contain
`v`), cutting the inserted cyclic walk inside one of its own angles at `v`; when an angle has one sector, its tile is listed twice, once for
each of its two edges (distinct edges unless the cycle is a single angle with a loop edge, whose block has nothing inside). No edge is
split, and every repeat stays an edge appearance.

Adversaries checked on paper against the statement (both hold): **a neighbour appearing twice** — `y` sharing edges `e₁`, `e₂` with `x`,
a tile `a` in the pocket between and `b` outside: the ring `a, y, b, y` is the only shape (`a`–`b` is not an edge), and the separation of
`a` from `b` in `M̂ − x − y` is the pocket being a hole of `cl x̂ ∪ cl ŷ`; **a non-hole pocket** — the crescent (`x` between a circle and an
internally tangent one, touching at `v`): `W₀`'s walk and the pocket's walk share only `v` (two components of `Kᶜ` touch at most once,
else a closed curve through both would split `x`), and the inserted ring is `s, t, …, t′, s′, …` with no new repeat.

### 2.2 The route: a boundary walk, then the crossing lemma outside a disc

The leaf is cut at one interface, **`IsBoundaryWalk`** (stated in `MapGraph`): a cyclic list of outer tiles with a *hinge* after each entry
(a point in both closures — clause 2 follows), the *edge entries* each carrying an **edge** `IsEdgeOf` (a closed connected piece of
`cl x ∩ cl y` from the previous hinge to its own, with a *pure point* `p` and radius `ρ`: `B(p, ρ)` holds only `x`, `y` and the edge, whose
circle points interleave with points of `x ∪ y`), a tile listed twice only at edge entries, and each pure point's closed disc missing every
other edge. Two halves, independent:

1. **WALK** (`exists_boundaryWalk`): the construction (§ 3's children C1–C9). It reads the finite boundary graph of `C`: `CurveGraph`'s
   `port_pair` gives the edges (each a component of `C` off small vertex discs, plus its two radial ends), each with one outer tile
   (locally constant along it); the *angles* at a vertex are the runs of outer sectors between consecutive rays of `C`. Each port ends one
   edge and one angle, so edges and angles form a **2-regular structure** — two fixed-point-free involutions on the ports, `πE` (the other
   end of the edge) and `πA` (the other end of the angle) — whose cycles, read in one direction (`φ = πA ∘ πE`; `πE` conjugates `φ` to
   `φ⁻¹`, so orbits come in reversed pairs, one chosen from each), are closed walks. **No orientation lemma is needed** (the facial walk's
   usual "the outer side reverses along an edge" is replaced by the pairing of orbits). The cycles' vertex-sharing graph is connected because
   `C` is (the edges of two classes would be disjoint closed sets covering `C`). Merging by in-angle insertion and dropping vertex appearances
   finish it.
2. **SEP** (`IsBoundaryWalk.sep`): two positions of `y` are edge entries; with `a` after appearance `s` and `b` after `t ≠ s` (cyclic arcs),
   and `S` the continuum of filled closures of a chain `a ⇝ b` in `M̂ − x − y`, take at the pure point `p s`: `K₂` = the near piece of `E s`,
   the entries from its far hinge to `a`, `S`, the entries from `b` onward to the near hinge (crossing later appearances of `y` along their
   *edges*, never their tile), the far piece — closed, bounded, connected, off `x ∪ y`, off the disc, missing `p t`; and `K₁` =
   `(x ∖ B) ∪ (y ∖ B) ∪ {p t}`, connected (`isPreconnected_diff_ball`, `p t ∈ cl x ∩ cl y` and off the closed disc). They are disjoint and join
   interleaved circle points: against **`inter_nonempty_of_interleaved_exterior`** (the crossing lemma, inverted). For non-adjacent arcs
   the chain from `b` crosses intermediate appearances through their edges, which is why `K₁` uses the second pure point `p t` and not any
   point of `y`'s contact: `K₂` may pass every other edge of `y`.

**Against the docstring's planned route** (`isPreconnected_frontier_connectedComponentIn` + the crossing lemma; IP4's `orient`): the
crossing lemma there is for a round disc around `u` and continua *inside* it; the walk lives outside `K`, and no held lemma relates the
walk's order to a round circle. The route here uses the crossing lemma *outside a small disc at a pure point*, which sees only the local
order `e⁻, x, e⁺, y` there, and the global order through the walk's chains. `orient` is not needed; nor is any Jordan-type theorem.

### 2.3 What is held, confirmed

Held and read: `port_pair`, `even_sum_deg`, `hasCurveStar_of_branches`, `HasCurveStar.connectedComponentIn` (`CurveGraph`, `MapTopology`
§ D); `localSectors`, `IsSectorChart` (`LocalStructure` l. 4491, 4606); `inter_nonempty_of_interleaved_radius` (`MapTopology` § E);
`isPreconnected_inter_of_union_eq_univ`, `isPreconnected_frontier_connectedComponentIn` (`PlaneTopology`); `not_isHoleOf_closure_fill`,
`isPreconnected_closure_fill`, `IsOuterTile.disjoint_closure_fill`, `eq_or_subset_hole_of_inter`, `subset_fill_of_inter`,
`finite_tiles_closure_inter`, `IsHoleOf.isOpen` (`MapGraph`). Mathlib (grep at the pin): `Equiv.Perm.toList`, `nodup_toList`,
`next_toList_eq_apply`, `mem_toList_iff` (`GroupTheory/Perm/Cycle/Concrete`), `Function.minimalPeriod`, `iterate_minimalPeriod`
(`Dynamics/PeriodicPts/Defs`), `isPreconnected_iff_subset_of_disjoint_closed` (`Topology/Connected/Clopen`); **no planar graph theory**
(no rotation systems, faces or Jordan curve theorem). The two topology children below are proved, so their Mathlib uses are confirmed by
elaboration.

## Stage 3 — SAVED: the skeleton

`filledGraph_ringList` is now proved, in two lines, over two children; everything new (statements read back in their docstrings):

| declaration | module | status | read back |
|---|---|---|---|
| `isPreconnected_diff_ball` | `MapTopology` § F | **proved** (no openness needed: a closed split of `U ∖ B` with the circle's part on one side extends by `B̄` to a closed split of `U`) | `U` preconnected, `U ∩ sphere c r` preconnected and nonempty ⟹ `U ∖ ball c r` preconnected — exact |
| `inter_nonempty_of_interleaved_exterior` | `MapTopology` § F | **proved** (inversion `z ↦ u + R²/conj(z − u)`, then `inter_nonempty_of_interleaved_radius`) | `K` closed bounded preconnected, `K'` preconnected, both off `B(u, R)`, through interleaved circle points ⟹ they meet — exact |
| `IsEdgeOf` (def) + spec example (`¬ IsEdgeOf … 0`) | `MapGraph` | stated | § 2.2 |
| `IsBoundaryWalk` (structure; five fields `mem`, `hinge`, `edgeOf`, `rep`, `apart`) | `MapGraph` | stated | § 2.2; inhabitant note: `exists_boundaryWalk` |
| `filledGraph_adj_iff` (**ADJ**) | `MapGraph` | `sorry` | `Adj x y ↔ x ≠ y ∧ (cl x ∩ cl y).Nonempty` for outer tiles of a plane map |
| `IsBoundaryWalk.cons` (**CONS**) | `MapGraph` | **proved** | clause 2 of `IsRing` from `hinge` |
| `IsBoundaryWalk.sep` (**SEP**) | `MapGraph` | `sorry` | clause 3 of `IsRing`, verbatim, for the walk's list |
| `IsBoundaryWalk.isRing` | `MapGraph` | **proved** | `⟨mem, cons, sep⟩` |
| `exists_boundaryWalk` (**WALK**) | `MapGraph` | `sorry` | every outer tile of a valid plane map has a boundary walk |
| `filledGraph_ringList` | `MapGraph` | **proved over WALK and SEP** | statement unchanged; docstring's route paragraph rewritten to this route |

`Thomassen.PlanarLike`'s docstring gains the note of ruling 333 (c) (the ring field's second part constrains non-neighbours only;
docstring only). `scripts/Axioms.lean`'s FS131-KP block gains the seven new theorems under "-- FS131-RL1's children". No import changed:
`tools/check_architecture.py` exit 0, `ARCHITECTURE.md` untouched (no module added). No `axiom`, no `native_decide`.

## Stage 4 — SAVED: the plan per child, the obligation pass, the handoff

### 4.1 The obligation pass (`debruijn-obligation-modeling`, invoked fresh, scoped to ADJ, SEP, WALK)

- **Are `IsEdgeOf` / `IsBoundaryWalk` the statements SEP derives from?** Yes, field by field: SEP's `K₂` reads `hinge` (consecutive
  pieces meet), `edgeOf` (closedness, `E₁`/`E₂` with the hinges and circle points, `E` preconnected through both hinges for crossing an
  intermediate appearance, `E ⊆ cl x ∩ cl y` and `Disjoint E (x ∪ y)` to keep `K₂` off `x ∪ y` and off the discs), `rep` (both repeated
  positions are edges), `apart` (`p t` off the disc at `p s`; other edges off the disc). `K₁` reads the sphere arcs and `p t ∈ cl x ∩ cl y`.
  Every field is read; mutation (drop `ball p ρ ⊆ x ∪ y ∪ E`) lets a foreign tile reach the disc and the interleaving go fake. `u ∈ E`,
  `w ∈ E` are derivable from `E₁`, `E₂` and kept for convenience.
- **SEP's space** is the cyclic arcs between consecutive appearances of `y`; the mod-`n` indexing is the incidental structure. Strengthen
  by a **rotation lemma** — a boundary walk rotated (hinges, edges, pure points, radii and `edge` shifted with it) is a boundary walk — so the
  appearance `s` before `a`'s arc is the last entry and nothing wraps; then the chain is an **induction on interval length** with a two-line
  step (consecutive pieces share a hinge). Children: **SEP-ROT** (`IsBoundaryWalk.rotate`), **SEP-CHAIN** (for `l₁ ≤ l₂ < n`, the union over
  `[l₁, l₂]` of `cl r[l]` — or `E l` where `r[l] = y` and `edge l` — is closed, bounded, preconnected, holds `z (l₁ − 1)` (for `l₁ ≥ 1`) and
  `z l₂`, misses `x ∪ y`, and misses the open disc at `p j` and the point `p j` for every edge index `j ∉ [l₁, l₂]` with `r[j] = y`),
  **SEP-S** (a chain in `M̂ − x − y` gives a closed bounded preconnected `S ⊇ cl a ∪ cl b` off `x ∪ y` and off every pure disc of `x`'s
  edges with `y`: `fill` is open, misses `x` and `y`, and cannot meet an edge without meeting `x`), **SEP-K1** (`K₁` preconnected, off the
  disc, missing `K₂`), **SEP-CORE** (the contradiction, rotated configuration), **SEP-REDUCE** (from `IsRing`'s `i < m < j`, `n ∉ [i, j]` to
  the arcs: `s` = last appearance at or before `m`, `t` = last appearance before `n` cyclically; `s ≠ t` because an arc between
  consecutive appearances lies inside `(i, j)` or outside `[i, j]`). Measure: each is a separate local obligation; SEP-CHAIN's induction
  descends on `l₂ − l₁`.
- **WALK's space** is generated by the 2-regular structure, and its merge is an induction on the number of cycles still unmerged; the
  statement that carries it (strengthened from "a ring") is the **partial walk**: a cyclic list of entries with hinges, each edge entry
  (one per edge — *no traversal pairs*) carrying its edge from its previous hinge to its own, each vertex entry (an angle's interior
  tile) having both hinges equal to its vertex. In this form an angle's tiles are "edge-in entry, interior entries, edge-out entry", all
  consecutive pairs hinged at the vertex, so **insertion at any hinge value `v` shared by two partial walks** (`r₁.take (k₁+1) ++
  r₂.rotate (k₂+1) ++ r₁.drop (k₁+1)`, hinges spliced, both new hinges `= v`) **preserves every field and needs no duplication** — the
  single-sector case of § 2.1 disappears; and dropping a vertex entry keeps its neighbours hinged at `v`. Measures: MERGE by the card of the
  unmerged cycles (the next one chosen hinge-adjacent to the merged set, by W-CONN); DROP by list length.

### 4.2 The plan per child (price in implementer sessions, Opus; to be re-priced from the first two leaves)

**ADJ `filledGraph_adj_iff`** (E–M, 0.2). `←`: `cl x ⊆ cl x̂` (`subset_fill`). `→`: `z ∈ cl x̂ ∩ cl ŷ`. A hole `H` of `y` is open and misses
`x̂`: `x` is connected in `(cl y)ᶜ` and not inside `H` (outer), so it lies in the rest, `cl x ∩ cl H = ∅`; a hole of `x` meeting `H` would hold
a tile of `H` (open, `exists_tile_inter_of_isOpen`) inside a hole of both, against `fill_subset_hole`/`hole_subset_hole` and outerness. So
`z ∉ H`, `z ∈ frontier H ⊆ cl y` (frontier of a hole lies in the tile's closure: its closure misses the rest). Symmetrically `z ∈ cl x`.
Uses `IsHoleOf.isOpen`, `IsHoleOf.connectedComponentIn_subset`, `hole_subset_hole`, `disjoint_closure_sUnion_holes`.

**SEP** (M–H, 1.2–1.5 over its six children, § 4.1). Uses `inter_nonempty_of_interleaved_exterior` and `isPreconnected_diff_ball`
(proved here), `IsOuterTile.disjoint_closure_fill` (with `X := v`, `S := x`: `x ∩ cl v̂ = ∅`), `IsHoleOf.isOpen` (`fill` open),
`IsTile.isOpen`, `IsTile.isPreconnected`, `isClosed_closure`, `IsPreconnected.union` / `isPreconnected_of_forall`,
`Bornology.IsBounded.union`, `closure_fill_subset_closedBall`. The hard part is SEP-CHAIN's bookkeeping, which the rotation removes.

**WALK** (H, 4–6). Children, each to be stated by the implementer before proving (statements fixed here in words):
- **C1 `frontier_closure_fill_subset`**: `frontier (cl x̂) ⊆ cl x` (a hole's frontier lies in `cl x`; `disjoint_closure_sUnion_holes`). 0.2.
- **C2 `isPreconnected_frontier_closure_fill`**: `frontier (cl x̂)` preconnected — `isPreconnected_inter_of_union_eq_univ` on `cl x̂` and
  `cl (cl x̂)ᶜ` (the latter connected: a closed split would give a hole of `cl x̂`, against `not_isHoleOf_closure_fill`). 0.3.
- **C3 local structure at `z ∈ C`**: the sector chart's branches are rays of `C` (`x` on one side, an outer tile of `(cl x̂)ᶜ` on the other),
  inner or outer; `C ∩ ball z r = insert z (rays)`; hence `HasCurveStar C z n` (`hasCurveStar_of_branches`); the outer tiles at `z` are
  neighbours of `x` (C1, outerness argument of § 2.1). 0.8.
- **C4 vertices**: `N` = points of `C` where `Γ` is not regular, plus one point if `N = ∅`; finite (the argument of `finite_nonRegular` on
  `C`, with charts of `Γ`); off `N`, `C` and `Γ` agree near each point. 0.4.
- **C5 the boundary structure**: ports at radius `ρ` (`port_pair` with `hreg`, `hP`, `hray`, `hsep` exactly as in `even_sum_deg`'s proof),
  `πE`; each edge's outer tile constant along it (locally constant on the connected component, sector charts at its points); the edge set
  `E` = the component of `C'` plus its two radial ends, with a pure point (any point of the component; ρ below its chart radius) and the
  `IsEdgeOf` clauses (the circle points from the chart's two branches; `E₁`, `E₂` = the two sides of `E` off the disc — the component is an
  arc of one curve, `IsCurve.exists_param`); angles at each vertex as runs of outer sectors between consecutive rays of `C`, `πA`, their
  interior tile lists. **The longest child**: 1.5–2.
- **C6 cycles**: `φ = πA ∘ πE` as an `Equiv.Perm` of the ports; orbits (`Function.minimalPeriod`, or `Equiv.Perm.toList` with fixed points
  handled); `πE φ πE = φ⁻¹` so orbits pair off, never self-paired (`O ∩ πE O = ∅`); one chosen per pair; each chosen orbit read as a
  partial walk (edge entry of `h`'s edge, then the interior tiles of the angle at `πE h`'s vertex, …); every edge and every angle in exactly
  one chosen walk. 0.7.
- **C7 W-CONN**: the chosen walks' "share a hinge value" graph is connected — else the union of the edges of one class and that of the rest
  are disjoint nonempty closed sets covering `C` (C2). 0.4.
- **C8 W-MERGE** (pure list surgery, § 4.1) and **C9 W-DROP** (filter vertex entries of tiles with an edge entry; for vertex-only tiles keep
  the first). 0.6 together.
- **C10 W-COVER and W-APART**: every neighbour of `x` is an entry (ADJ gives `z ∈ cl x ∩ cl y ⊆ C`; `y`'s sector at `z` is in some angle or
  along some edge); entries are neighbours (C3); `rep` (after C9 only edge entries repeat); `apart` (two distinct edges meet only at vertices,
  off every pure disc). 0.5.

Total: ADJ 0.2 + SEP 1.5 + WALK 5–6 ≈ **7–8 implementer sessions**, before re-pricing from the first two leaves (`LEAN.md`: plan-table
prices run high; this one has no measured leaf yet beyond the two topology children here, which took about 20 minutes together).

### 4.3 Inhabitants and vacuity

`IsBoundaryWalk`'s readers take `exists_boundaryWalk` as their model (docstring note). `IsEdgeOf` carries a spec example. The two topology
lemmas are generic (`GENERIC`). `filledGraph_ringList` and `exists_boundaryWalk` read only `Valid` and `IsPlaneMap` (inhabited by
`sevenBrickMap` at `k = 7`, as `cvb_thom_reduced`'s note says).

### 4.4 The handoff to the implementer

**Where.** Branch `fs131-w5p`, worktree as above; build `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G
BATCH=4 ./scripts/build.sh` from inside the worktree; iterate with `lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false`.
**Leaves**: ADJ, SEP, WALK in `MapGraph` (§ "The boundary walk"), their children beside them; pure-topology children in `MapTopology` § F.
**Order**: ADJ (warm-up, measure it); SEP's six children (SEP-ROT and SEP-CHAIN first — they fix the bookkeeping; re-price after them);
WALK: C1, C2, C3, C4 (local, measure), then C5 (the long one), C6–C10.
**May**: add children (statements of § 4.2, with spec examples), add fields to `IsBoundaryWalk` or clauses to `IsEdgeOf` **if** the
construction cannot meet them as stated and SEP does not need them — a change inside this job's vocabulary, to be reported; change
imports with `ARCHITECTURE.md` and the FS131-KP block. **May not**: change `filledGraph_ringList`, `IsRing`, `PlanarLike`, any statement
outside this job; weaken `IsBoundaryWalk.sep`'s conclusion; add an `axiom`. Watched points: C5's `IsEdgeOf` construction (the two sides of
an edge off the disc, from the curve parametrization) and C6's orbit pairing.
**Second implementer**: yes, disjointly — **one implementer on SEP** (its six children, and ADJ), **one on WALK** (C1–C10). SEP reads only
`IsBoundaryWalk`'s fields, never the construction; WALK produces them. Their hunks in `MapGraph` are disjoint (SEP's children before
`IsBoundaryWalk.sep`, WALK's before `exists_boundaryWalk`); if run on two branches cut from this one, the merge conflicts only in the
FS131-KP block of `scripts/Axioms.lean` (append-only). Price per lane: SEP ≈ 1.5–2, WALK ≈ 5–6.

### 4.5 The skeleton's build and receipt

Under the slot (40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 6 modules rebuilt (`Thomassen` 6.3 s — the docstring —,
`MapTopology` 13 s, `BaseWalk` 2.0 s, `MapGraph` 18 s, `BaseDense`, `Proofs`), 9 modules with warnings, every warning `declaration uses
'sorry'`; `MapGraph`'s three `sorry` declarations are `filledGraph_adj_iff` (l. 1349), `IsBoundaryWalk.sep` (l. 1372),
`exists_boundaryWalk` (l. 1392); exit 0** (`build/gate/build/20261005T054411Z-1735164.log`; driver log `data/fs131/rl/build-skeleton.log`;
the two `error: target is out-of-date` lines are Lake's `--no-build` probe). Axioms (`data/fs131/rl/AxiomsRL1.lean` →
`data/fs131/rl/axioms-rl1.txt`): `isPreconnected_diff_ball`, `inter_nonempty_of_interleaved_exterior`, `IsBoundaryWalk.cons` on the standard
three; `filledGraph_adj_iff`, `IsBoundaryWalk.sep`, `IsBoundaryWalk.isRing`, `exists_boundaryWalk`, `filledGraph_ringList` on `sorryAx`
(the controls). `tools/check_architecture.py`: exit 0.
