# FS131-RL1 — the boundary walk of a filled tile (RING-LIST): the plan for `filledGraph_ringList`

*de Bruijn, the planner; brief `data/fs131/briefs/FS131-RL1-ringlist.md` (on `main`); branch `fs131-w5p`, worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p`. Nothing in this milestone is fenced (inventory ruling 1).*

## Theorems this phase proved

None yet (a planning job; any child proved here is listed in the stage that proves it).

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
