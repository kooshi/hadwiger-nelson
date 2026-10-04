# FS131-KP — the planar infrastructure: wave 5's seven planar leaves, and `IsHoleOf`

*de Bruijn, the planner (FS131-KP), 2026-10-04. Brief: `data/fs131/briefs/FS131-KP-planar.md` (main tree). Branch `fs131-w5p` (worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p`), cut from `fs131-w5` at `0db34854`. The form this record follows is `plans/FS131-kernel-plan.md`
§ 6; wave 5's vocabulary is `plans/FS131-w5-kernel-plan.md` §§ 2, 8, 10 and `plans/FS131-w5base-kernel-plan.md`.*

## Theorems this phase proved

None so far: a planning job. (Updated at each stage.)

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

Checked by `grep -F` of each quotation's full text (a planted absent string reported `MISS`, the control):

| quotation in the brief | source | result |
|---|---|---|
| inventory item 239 (truncated at "`exists_eleventh`,") | `plans/FS131-close-inventory.md` (**main tree**; this branch's copy is older) | verbatim |
| inventory item 242 (truncated at "Choice: defer") | same | verbatim |
| inventory item 274 (truncated at "a definition") | same | verbatim |
| "def IsHoleOf (T Hc : Set ℂ) : Prop :=" | `Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean` (branch) | verbatim |
| I5b's defect paragraph (truncated at "a bounded component of") | `plans/FS131-I5-implementation.md` Stage 8 (branch) | verbatim |
| I5b on `cvb_pinch_connected` (truncated at "the uniqueness of the unbounded") | same | verbatim |
| QA3's note f (truncated at "at every CVB") | `plans/FS131-QA3-audit.md` § 2.4 (main tree) | verbatim |
| CVB § 1.9's frame (truncated at "a pair at distance") | `plans/FS114-CVB-verification.md` § 1.9 | verbatim |
| Kooshi on pricing | `CLAUDE.md` § Counter-priors | verbatim |

No mismatch. Read in full: inventory items 239, 241, 242, 247, 274 and ruling 1; I5b's Stage 8; CVB § 1.9 (B1, B2 steps 1–4); QA3 § 2.4;
`plans/FS131-w5-kernel-plan.md` §§ 3.2, 8.1–8.4, 9.1–9.2; `plans/FS131-w5base-kernel-plan.md` (all); `plans/FS131-E4-derivation.md` §§ 2.2–2.4 and
stage 3's arguments (E4-RIM, E4-OUTERMOST — the hand proofs of `exists_eleventh` and `exists_unenclosed_or_bad`); `[Thomassen1999]` pp. 851–852
(`library/papers/Thomassen-1999-…txt`, ll. 100–194).

### 1.2 What I am planning, and what I may change

**Planning:** (1) the faithful `IsHoleOf`; (2) the plane topology the seven leaves read, as named shared lemmas in new modules under
`Proofs/HadwigerNelson/Plane/`; (3) a skeleton reducing `cvb_thom_reduced`, `cvb_pinch_connected`, `cvb_hole_disconnected` (`MapGraph`),
`BaseCtx.retArcs_nested`, `BaseCtx.exists_endpoint`, `BaseCtx.exists_eleventh` (`BaseWalk`) and `exists_unenclosed_or_bad` (`BaseDense`) to those
lemmas and named children, `sorry` at every leaf; (4) a plan per leaf, the obligation pass, the implementer's handoff.

**I may change:** in `MapGraph` only `IsHoleOf`, `fill`, `IsOuterTile`, `filledGraph` and the three `cvb_*` leaves, with children beside them (the
definition only after a message to Keryx); in `BaseWalk` only the three leaves named; in `BaseDense` only `exists_unenclosed_or_bad`; new modules;
`Proofs.lean`, `ARCHITECTURE.md`, my block of `scripts/Axioms.lean`, this record, `tools/fs131_kp_*.py`, `data/fs131/kp/`. **I may not change** any
other statement. One edit outside the named declarations is needed and is flagged for the merge: an `import` line at the head of `BaseWalk` (the
new topology module), since the three `BaseWalk` leaves must read it.

### 1.3 The as-given build

`0db34854` under the slot (40 GiB, 8 cpus, `BATCH=4`), queued at stage 1; the slot held it (`ledger 80 + 40 > budget 90 GiB`: two other agents
building). Result recorded at the stage that sees it land (§ 1.4). Mathlib names for the topology core confirmed by `#check` at the pin
(`data/fs131/kp/KPChecks.lean`, output `KPChecks.out`): `IsCoveringMap.existsUnique_continuousMap_lifts` (the simply-connected form,
`Topology/Homotopy/Lifting.lean` l. 469), `Circle.isCoveringMap_exp`, `SimplyConnectedSpace ℂ` and `LocallyPathConnectedSpace ℂ` by instance,
`isPreconnected_closed_iff`, `isPreconnected_iff_subset_of_disjoint_closed`, `IsPreconnected.union`, `isPreconnected_sUnion`,
`IsOpen.connectedComponentIn`, `isPreconnected_connectedComponentIn`, `IsPreconnected.subset_connectedComponentIn`, `connectedComponentIn_eq`,
`IsCompact.elim_finite_subcover`, `Set.Finite.isClosed_biUnion`, `SimpleGraph.even_card_odd_degree_vertices`, `Continuous.piecewise`,
`Metric.infDist`. (Not found under the names tried: `IsClosed.biUnion`, `ContinuousMap.piecewise`; the graph names failed only for want of an import
and are confirmed in `MapGraph` itself.)

## Stage 2 — SAVED: `IsHoleOf` settled (message to Keryx sent before the change; adopted, inventory item 277)

### 2.1 The choice

```lean
def IsHoleOf (T Hc : Set ℂ) : Prop :=
  Hc.Nonempty ∧ Hc ⊆ (closure T)ᶜ ∧ Bornology.IsBounded Hc ∧ Disjoint (closure Hc) (closure ((closure T)ᶜ \ Hc))
```

A hole is a nonempty bounded part of `O := (cl T)ᶜ` whose closure misses the closure of `O ∖ Hc`. The separation clause makes `Hc` open
(`Hc = O ∖ cl (O ∖ Hc)`) and a union of whole components of `O` closed under "closures touch"; boundedness excludes the unbounded component
(unique: `cl T` is bounded, a tile having diameter at most 1, and the complement of a large closed ball is connected). Not required to be one
cluster: `fill` reads holes through their union, `IsOuterTile` through "lies inside one", the `cvb_*` leaves through existence; each is the same
whether a hole is one cluster or a union of clusters.

### 2.2 Read against CVB § 1.9 and every consumer, bound both ways (QA3's note f)

- **Every CVB hole is counted.** In CVB's frame (every arc separates two colours, so `∂x = ∂(cl x)`), a boundary component `C` disjoint from
  the outer one is the frontier of the union `Hc` of the complementary components whose frontiers lie in `C` (each component's frontier is
  connected — `PlaneTopology`'s frontier lemma — so it lies in one boundary component); `cl Hc ∖ Hc ⊆ C` and `cl (O ∖ Hc)` misses `C`. Item 242's
  cluster (two touching discs inside, missing the outer boundary) is one hole: `isHoleOf_cluster`.
- **Nothing else is counted.** A bounded part chained by touching closures to the unbounded component is never separated: FS131-I5b's chain
  (`D₁` touching `D₂` touching the outer circle) is no hole: `not_isHoleOf_chain`, the adversary.
- **The exact characterization** (the reason the two `cvb_*` leaves are true): `T` has no hole ⟺ the graph on the components of `O`, joined
  when their closures meet, is connected ⟺ `mapGraph − T` is connected. Proved through the separation directly (§ 4, leaf `cvb_pinch_connected`),
  with local finiteness read only at one point of `cl T` — so Keryx's caveat (infinitely many complementary components) does not arise; in fact
  finitely many components exist (finitely many tiles meet the compact `cl T`'s neighbourhood), but no proof reads it.
- **CVB's own words are not the definition for `ArcMap`** (finding, sent): "a boundary component of `x` disjoint from its outer one" assumes
  CVB's WLOG frame. `ArcMap` admits phantom arcs (QA3 note a): an annulus tile cut by a phantom radial slit has connected `∂T` (no hole in
  CVB's words) yet `cl T` is the closed annulus and `mapGraph − T` is disconnected. A boundary-component definition would make
  `cvb_pinch_connected` false there. The closure's complement is the right object; the definition reads it. (Keryx: errata for CVB's frame.)
- **Alternative weighed:** I5b's repair (the last clause over every other component): misses clusters, so `cvb_pinch_connected` fails at
  item 242's configuration. Rejected.
- **Statements changed:** none. `fill`, `IsOuterTile`, `filledGraph`, the three `cvb_*` leaves keep their text. `exists_holed_valid_fragment`'s
  statement is unchanged; the tail of its proof (the old last clause) is rewritten: `ball 0 (1/4)` lies in the hole, the rest of the
  complement beyond `1/2` (touch granted by Keryx, item 277).

### 2.3 Inhabitant and adversaries

- **Inhabitant** (every clause exercised): `exists_holed_valid_fragment` — `holedFrag`'s annulus `A` and the hole `connectedComponentIn (cl A)ᶜ 0`:
  nonempty (`0`), inside `(cl A)ᶜ`, bounded, separated (closure in `B̄(0, 1/4)`, the rest's closure in `|w| ≥ 1/2`). **Proved** (iteration-green).
- **`isHoleOf_cluster`** (stated, `sorry`, the implementer's): two touching discs `B(±1/4, 1/4)` inside the unit disc form a hole, and one of
  them alone does not — the cluster clause exercised.
- **`not_isHoleOf_chain`** (stated, `sorry`): the chain configuration has no hole. Plan for both: `(cl T)ᶜ` is the union of the three (two)
  open pieces (`⊇`: `T` lies in the closed complement; `⊆`: points of the closed region are limits of `T`, by radial pushes off the small
  circles and the touching points handled by a segment); each piece preconnected (balls; the outside by polar coordinates, as
  `isPreconnected_holedAnnulus`), so a separated `Hc` contains or misses each; touching points transfer membership. **M** each.
- The old adversary (`univ` has no hole) is kept, re-proved for the new clauses.

Iteration (`lake env lean` on `MapGraph`): exit 0, only the `sorry` warnings of `cvb_thom_reduced`, `cvb_pinch_connected`,
`cvb_hole_disconnected`, `not_isHoleOf_chain`, `isHoleOf_cluster`.

### 1.4 The as-given build — not obtained separately (a slip, logged; KB's and K5's, for the same reason)

The slot admitted the build at about 18:16, after stage 2's edit to `MapGraph` was on disk, so the build that ran covers this stage's tree.
Its result is recorded with stage 4's build.

## Stage 3 — SAVED: the route and the shared lemmas

### 3.1 Which plane topology the seven leaves read

Not one topology but three, and the cheapest adequate route for each:

| leaves | what they read | route |
|---|---|---|
| `cvb_hole_disconnected`, `cvb_pinch_connected` | tiles sorted by the components of `(cl T)ᶜ`; chains of touching tiles inside an open connected set; local finiteness at one point | **no Jordan-type theorem** under the repaired `IsHoleOf` (§ 2): `MapTopology` § A only |
| `exists_eleventh`, `exists_unenclosed_or_bad` | **a plane continuum's outer frontier is connected** (FS131-E4's home theorem), plus the last exit | **unicoherence of `ℂ`**, formalized (`PlaneTopology`), then E4-RIM / E4-OUTERMOST step by step (`MapTopology` §§ B–C) |
| `retArcs_nested` | two continua in a disc joining interleaved circle points meet | **the crossing lemma** (`inter_nonempty_of_interleaved`), from unicoherence through the Phragmén–Brouwer property |
| `exists_endpoint` | the common boundary of two tiles from a circle point has a far end | **a finite plane graph's handshake**: the finite boundary graph of `F` in `B̄(u, 1)` and `SimpleGraph.even_card_odd_degree_vertices` |
| `cvb_thom_reduced` | boundary walks (rings) of filled tiles, their separation, one infinite component of `M̂ − x − y` | **graph theory over an abstract `PlanarLike`** (pure, Thomassen pp. 851–852) **+ the planar construction** (`filledGraph_planarLike`: four leaves of `MapTopology` § A kind, one boundary-walk leaf over the finite boundary graph) |

The decisive observation: **unicoherence of `ℂ` is within reach in Lean**, so FS131-E4's "read, not proved" home theorem is formalized,
not imported. Mathlib has `IsCoveringMap.existsUnique_continuousMap_lifts` (maps from a simply connected, locally path-connected space lift
through a covering), `Circle.isCoveringMap_exp`, and `SimplyConnectedSpace ℂ` by instance (all `#check`ed, § 1.3). Unicoherence is then the
ten-line classical argument (the Urysohn angle on `A`, `1` on `B`, lift, compare integer constants on `A` and `B`). **No `axiom` is planned;
nothing enters `ARCHITECTURE.md` § Trust.** Mathlib has no unicoherence, Janiszewski, Jordan curve, Brouwer fixed point or winding-number
lemma at the pin (grep; E4's grep agrees).

### 3.2 The shared lemmas, read back

`Proofs/HadwigerNelson/Plane/PlaneTopology.lean` (pure `ℂ`, imports Mathlib and `Plane/Basic`):

| declaration | statement (read back) | the source it formalizes |
|---|---|---|
| `isPreconnected_inter_of_union_eq_univ` | closed preconnected `A`, `B` with `A ∪ B = univ` ⟹ `A ∩ B` preconnected | unicoherence of the plane (classical; Kuratowski's definition) — exact |
| `isPreconnected_compl_connectedComponentIn` | `K` closed preconnected ⟹ the complement of any component of `Kᶜ` is preconnected | the filled continuum is a continuum — exact |
| `isPreconnected_frontier_connectedComponentIn` | `K` closed preconnected ⟹ `frontier` of any component of `Kᶜ` preconnected | E4's "the frontier of each component of the complement of a continuum is connected" — **wider** (no compactness; any component) |
| `isBounded_connectedComponentIn_of_frontier_subset` | `K` closed bounded, `W` an unbounded component of `Kᶜ` with `frontier W ⊆ R` (`R` closed) ⟹ every point off `W` and `R` is in a bounded component of `Rᶜ` | E4-RIM step 3's and E4-OUTERMOST step 3's "last exit" — exact |
| `connectedComponentIn_eq_of_not_isBounded` | `K` bounded ⟹ two unbounded components of `Kᶜ` coincide | "one unbounded component" — exact |
| `exists_inter_of_finite_closed_cover` | preconnected `S` covered by finitely many closed `C i`, two distinct indices meeting `S` ⟹ two distinct indices meet in `S` | E4-RIM step 4 — exact (any space) |
| `isPreconnected_compl_closedBall` | `(B̄(c, R))ᶜ` preconnected | — |
| `inter_nonempty_of_interleaved` | closed preconnected `K`, `K'` in `B̄(u, 1)`, `r(s), r(t) ∈ K`, `r(s'), r(t') ∈ K'`, `s < s' < t < t' < s + 2π` ⟹ `K ∩ K' ≠ ∅` | CB D5 item 1's "paths do not cross", for continua — exact. **Closed** is assumed (the classical form is for continua; not claimed for non-closed connected sets); `retArcs_nested` passes `closure K`, still connected and inside `cl T₁ ∩ cl T₂ ∩ B̄(u, 1)` |

`Proofs/HadwigerNelson/Plane/ValidMap/MapTopology.lean` (imports `HexRing`, `Tiles`, `PlaneTopology`; upstream of `MapGraph`, `BaseWalk`,
`BaseDense`): § A `IsTile.subset_compl_closure`, `IsTile.subset_or_subset_of_separated`, `exists_tile_inter_of_isOpen`,
`exists_tile_mem_closure_of_mem_closure`, `mem_of_touch_closed`, `finite_tiles_closure_inter` (each read back in its docstring; all generic in
`k`, over `F.dom`, no validity except where named); § B `outerDom`, `EnclosesTile` (with `Unenclosed v ⟺ ∀ T S, IsTile T → IsTile S → v ∈ cl S
→ ¬ EnclosesTile T S`, by unfolding), `exists_outermost` (E4-OUTERMOST steps 1–2 — same), `exists_rim_vertex` (step 3 — **narrower in its
hypotheses than E4 needs**: no "no bad point" hypothesis, since the one-tile case closes by the last exit alone), `isCubicTrichromatic_of_three_tiles`
(step 4 — same), `unenclosed_of_rim_vertex` (step 5 — same); § C `tileOf_subset_ball` (Lemma H(a), any `k` — same), `exists_eleventh_of`
(E4-RIM, all steps, the fields of `BaseCtx` it reads as hypotheses: `Valid`, `Covers u 2`, cubic, `BaseHyp`, `UnenclosedC` — **`NoInertNear` not
read**, as E4 says); § D `exists_far_end` (the handshake step of CD Lemma E), `GermPseudo.eq_of_cw`, `ringArc_cases`.

`MapGraph` gains (namespace `Thomassen`, pure graph theory): `IsRing` (a ring at `x`: entries exactly the neighbours, cyclic consecutive
entries equal or adjacent, two appearances of `y` separate the entries between from those outside in `G − x − y`), `TwiceApart`,
`PlanarLike` (locally finite, connected, infinite, rings with "`G − x − y` connected unless `y` twice apart", exactly one infinite component of
`G − x − y`), `reduced_props_of_planarLike` (Thomassen pp. 851–852 as graph theory); and on maps `filledGraph_locallyFinite`, `_connected`,
`_infinite`, `_rings`, `_oneInf`, `filledGraph_planarLike`. **Read-back of `IsRing` against Thomassen:** his sequence lists every neighbour in
boundary order and keeps a repeated neighbour only at its edge contacts ("we list only those appearances such that `C_{x_i}` and `C_x` share an
edge"); `IsRing`'s separation clause holds exactly for such appearances (at a vertex contact the tiles on the two sides share the vertex and are
adjacent in `M`, so separation fails — which is why the rule exists). His "consecutive vertices are neighbours" is the second clause; "`M − x − y`
is connected unless `y` appears twice" is `PlanarLike.ring`'s second part; CVB step 2's "precisely one" is `oneInf`. **Same**, with Thomassen's
finite-diameter contradictions replaced by `inf` and `oneInf` (CVB step 3).

### 3.3 What is formalized here, what may be its own job

Everything above is planned for formalization in this repository on the standard three axioms. Two pieces are large enough that the
implementer should measure them from their first child and report (Keryx's call to split): **the crossing lemma** (Phragmén–Brouwer from
unicoherence, then the corollary), and **the finite boundary graph of an `ArcMap` in a compact disc** (shared by `exists_far_end` and
`filledGraph_rings`: vertices the arc ends, crossings and circle points in the disc — finitely many, from `locallyFinite`, compactness and
`Arc.finite_inter_sphere_or_eq_circ`; edges the arc pieces between them, subdivided to make a simple graph; degrees from the sector charts,
`localSectors`).
