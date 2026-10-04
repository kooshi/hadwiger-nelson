# FS131-KP — the planar infrastructure: wave 5's seven planar leaves, and `IsHoleOf`

*de Bruijn, the planner (FS131-KP), 2026-10-04. Brief: `data/fs131/briefs/FS131-KP-planar.md` (main tree). Branch `fs131-w5p` (worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p`), cut from `fs131-w5` at `0db34854`. The form this record follows is `plans/FS131-kernel-plan.md`
§ 6; wave 5's vocabulary is `plans/FS131-w5-kernel-plan.md` §§ 2, 8, 10 and `plans/FS131-w5base-kernel-plan.md`.*

## Theorems this phase proved

None new: a planning job. `exists_holed_valid_fragment` (`MapGraph`) was re-proved after `IsHoleOf`'s change, its statement unchanged
([kernel] at the stage-6 build, no `sorry`); every other declaration of this job is stated with `sorry`.

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

## Stage 4 — SAVED: the plan per leaf, and the obligation pass (`debruijn-obligation-modeling`, invoked fresh)

*E easy, M moderate, H hard; price in implementer sessions, to be re-priced from the first two leaves (`LEAN.md`). Mathlib names `#check`ed
at § 1.3; library names read in source (`finite_tiles_near` l. 1964, `dense_interiorPts` l. 1429, `mem_closure_tile` l. 1602, `localSectors`
l. 4606, `IsSectorChart` l. 4491 of `Plane/LocalStructure`; `IsTile.closure_subset_closedBall` `Plane/Tiles` l. 82; `IsTile.isOpen`,
`.isPreconnected`, `.nonempty`, `.subset_interiorPts` `Plane/LocalMap`; `noBoth` `ValidMap/UnitArc` l. 450; `isCubicTrichromatic_of_three_of_noRep`
`ValidMap/HexRing` l. 128).*

### 4.1 What the pass decided (statement by statement)

| statement | verdict | decomposition, measure, and what changed |
|---|---|---|
| `isPreconnected_inter_of_union_eq_univ` | derives | by contradiction on a closed split `P ⊔ Q` of `A ∩ B`; children: the Urysohn angle (`Metric.infDist`, continuous, `0` on `P`, `1` on `Q`), the pasted map `C(ℂ, Circle)` (`Continuous.piecewise` over closed `A`, `B`), the lift, integer-valued continuous functions constant on preconnected sets (`IsPreconnected.constant`-type). **M** (≈ 120 lines) |
| `isPreconnected_compl_connectedComponentIn`, `isPreconnected_frontier_connectedComponentIn` | derive | the first: `K ∪` each other component, each meeting `K` in its closure (frontier of a component of an open set lies in `K`, nonempty by connectedness of `ℂ`), `isPreconnected_sUnion`-style with common part `K`; the second: unicoherence with `cl C`, `Cᶜ`. **E–M** |
| `isBounded_connectedComponentIn_of_frontier_subset`, `connectedComponentIn_eq_of_not_isBounded`, `isPreconnected_compl_closedBall`, `exists_inter_of_finite_closed_cover` | derive | as their docstrings; polar image as `isPreconnected_holedAnnulus`. **E** each |
| `inter_nonempty_of_interleaved` | derives (route H) | Phragmén–Brouwer from unicoherence, then the corollary. Closedness of `K`, `K'` assumed (continua); `retArcs_nested` passes closures. **H**, the one topology leaf that may become its own job |
| `MapTopology` § A | derive | each a few lines over the named library lemmas; `mem_of_touch_closed` by the relatively-closed cover of `U` (locally finite unions of closures: `finite_tiles_near`). **E–M** |
| `exists_outermost` | derives, **one child owed** | measure: the finite set of tiles meeting `B̄(x, 1)`; the chain of enclosing tiles has weakly increasing hulls, so a repeat forces equal hulls; child **`not_encloses_of_hull_eq`**: if `T₁` encloses `T₀` their hulls differ (equal hulls put the infinite common outer frontier in `cl T₀ ∩ cl T₁`, and off its finitely many vertices a frontier point has two sectors, one of them in the outer domain). Also child **`compl_outerDom_subset_convexHull`** (the complement of a compact convex set is connected and unbounded). **M–H** |
| `exists_rim_vertex` | derives, **narrower hypotheses than E4** | the one-tile case closes by the last exit (no bad-point hypothesis needed); the finite cover by `finite_tiles_closure_inter` on the compact rim. **M** |
| `isCubicTrichromatic_of_three_tiles`, `unenclosed_of_rim_vertex`, `tileOf_subset_ball` | derive | E4 steps 4, 5; Lemma H(a) as `endpoint_dist_ge`'s argument (`IsPreconnected.prod`, the distance image an interval avoiding `1`). **E–M** |
| `exists_eleventh_of` | derives (E4-RIM) | five children by E4's steps; `NoInertNear` not read (as E4 says). Step 1's "a tile of `u`'s colours touching `R*` is a tile of `R*`" uses `noBoth` at a touching point on `ω(u)`. **M–H** |
| `exists_far_end` | **corrected by this pass** | was "a second point `q ≠ r(θ)` with three colours or on `ω(u)`", **false** when `r(θ)` itself has three colours with its germs along in-contact arcs (colour of `u` inside, the `a|c` branch leaving outward): the component is `{r(θ)}`. Now "a point with three colours (possibly `r(θ)`) or a second point of `ω(u)`" — and then `r(θ)` is V-in, an endpoint. Children: **BG** (the finite boundary graph of `F` in `B̄(u, 1)`, shared with PATH and F-RING) and the degree count; handshake by `SimpleGraph.even_card_odd_degree_vertices`. **H** |
| `BaseCtx.endpoint_of_far_end` | derives **only after a reading** | three-colour cases immediate (V-in on `ω(u)` needs CE R2/R4's argument that the colour of `u` there has a tile meeting `B(u, 1)`); the two-colour exit case must give a returning pair **within `60°`** of `r(θ)` (`IsRetArc`'s bound). This planner has not read CD Lemma E/R or CE R1–R4; the implementer reads them first. If an exit can return farther, the handshake is re-run on the component minus that exit; if that fails, a statement question for Keryx (`IsRetArc`'s bound). **M–H** |
| `retArcs_nested` | derives | `ringArc_cases` (pure angle arithmetic, **M**) then two children. **The pass changed their planned argument**: both rest on child **PATH** — under H the `T₁|T₂` boundary in `B̄(u, 1)` has degree at most `2` inside and `1` at a two-colour change point, so each component is a path or a cycle (two ends at most). `retArcs_not_interleaved`: crossing ⟹ a common point; different tiles ⟹ repeated or fourth colour; same tiles ⟹ one path with four ends. `retArcs_not_abut`: the germs make the second pair `(c, a)` on the same tiles, one path with three ends. (The colour-only argument first planned is insufficient when the two pairs share their tiles.) **M** each over PATH and the crossing lemma |
| `cvb_hole_disconnected` | derives | the in-proof skeleton (four `sorry` joints): `Hc` open; a tile inside; a tile outside (the unbounded part); `SimpleGraph.Walk.exists_boundary_dart` (to confirm by `#check` at implementation; the dart-crossing lemma of `SimpleGraph.Walk`). **M** |
| `cvb_pinch_connected` | derives | through the separation directly (Keryx's caveat: no global count of components is read). **M** |
| `cvb_thom_reduced` | derives over `PlanarLike` | `= reduced_props_of_planarLike (filledGraph_planarLike hF hP)`, proved. Children F-LOC, F-CONN, F-INF, F-ONE (**M** each, `MapTopology` § A–B kind), F-RING (**H**, boundary walks over BG; separation only at edge contacts — Thomassen's rule), T-GRAPH (**H**, pure graph theory). **Risk recorded:** `PlanarLike` is this planner's reading of what Thomassen's pp. 851–852 use ("we use the properties of `M` established previously and forget about `S`"); if T-GRAPH needs one more planar property, `PlanarLike` gains a field and F-RING or F-ONE a clause — a statement change inside this job's vocabulary, no row statement moves |
| `exists_unenclosed_or_bad` | derives | the assembly is written (two `sorry` joints: the rim lies in the hull — `outerDom` open, as a union of components of an open set; `T` misses its outer domain). **E** over § B |

### 4.2 Price

§ A and the small `PlaneTopology` lemmas: one session. Unicoherence and the frontier lemma: half a session. E4-OUTERMOST and E4-RIM (`exists_outermost`, `exists_rim_vertex`, steps 4–5, `exists_eleventh_of`): one session. `cvb_hole_disconnected`, `cvb_pinch_connected`, `filledGraph` F-LOC/CONN/INF/ONE: one session. **BG + PATH + `exists_far_end` + `ringArc_cases` + NEST-X/NEST-A**: one to two sessions. The crossing lemma: one session, possibly its own job. `endpoint_of_far_end`: half a session after reading CD/CE. **F-RING and T-GRAPH: two to three sessions** (the wave's longest; Keryx may split them into their own planner-and-implementer pair). Total: six to nine sessions — to be re-priced from the first two leaves.

### 4.3 Inhabitants and vacuity

`IsHoleOf`: inhabitant `exists_holed_valid_fragment` (proved), plus `isHoleOf_cluster` (stated); adversary `not_isHoleOf_chain`. `PlanarLike`:
**an inhabitant is owed** — the triangular lattice (`triLattice`: rings the six-cycles, no repeats; `G − x − y` connected; one infinite
component), a child `triLattice_planarLike` for the implementer, exercising every field (the vacuity scan reads `reduced_props_of_planarLike`'s
hypothesis structure). `cvb_thom_reduced`, `cvb_pinch_connected`: `sevenBrickMap` at `k = 7` (as before). `cvb_hole_disconnected`: `GENERIC` on
plane maps. `exists_far_end`, `exists_eleventh_of`, `endpoint_of_far_end`, `retArcs_not_*`: steps inside the base's refutation (no model
expected; `BaseCtx` is OUT). `exists_outermost`, `exists_rim_vertex`, `unenclosed_of_rim_vertex`: `sevenBrickMap` (a brick is outermost, its rim
vertex a corner). `PlaneTopology`: unconditional or generic topology; `inter_nonempty_of_interleaved`'s model is two crossing diameters.

## Stage 5 — SAVED: the handoff to the planar implementer (wave 4's plan § 14 form)

### 5.1 Where it is, and how the implementer works

Branch `fs131-w5p`, worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p` (`.lake/packages` a symlink to the main tree's, `.lake/build`
its own copy — never a symlink). Build from inside the worktree: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; iterate with `lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false <file>` under a small slot (8 GiB).

**Modules and leaves.** `Plane/PlaneTopology` (8 `sorry` leaves), `Plane/ValidMap/MapTopology` (15), `Plane/ValidMap/MapGraph` (FS131-KP's: `not_isHoleOf_chain`,
`isHoleOf_cluster`, `reduced_props_of_planarLike`, `filledGraph_locallyFinite`, `_connected`, `_infinite`, `_rings`, `_oneInf`, and the in-proof
joints of `cvb_pinch_connected`, `cvb_hole_disconnected`), `Plane/ValidMap/BaseWalk` (`retArcs_not_interleaved`, `retArcs_not_abut`,
`endpoint_of_far_end`; the three leaves themselves are now reductions), `Plane/ValidMap/BaseDense` (two joints in `exists_unenclosed_or_bad`).

**Work order** (each step unblocks the next; re-price after the first two):
1. `PlaneTopology` small lemmas, then unicoherence and the frontier lemma (`isPreconnected_inter_of_union_eq_univ` first: it is the whole
   wave's foundation — measure it).
2. `MapTopology` § A; then `cvb_hole_disconnected`, `cvb_pinch_connected` (closing two of the seven), `not_isHoleOf_chain`, `isHoleOf_cluster`.
3. § B (with the owed children `not_encloses_of_hull_eq`, `compl_outerDom_subset_convexHull`) — closes `exists_unenclosed_or_bad`; § C — closes
   `exists_eleventh`.
4. `ringArc_cases`; the finite boundary graph **BG** and child **PATH** (add them to `MapTopology` § D, each with a spec example);
   `exists_far_end`; read CD Lemma E/R and CE R1–R4, then `endpoint_of_far_end` — closes `exists_endpoint`.
5. The crossing lemma; `retArcs_not_interleaved`, `retArcs_not_abut` — closes `retArcs_nested`.
6. `filledGraph` F-LOC, F-CONN, F-INF, F-ONE; `triLattice_planarLike` (the inhabitant of `PlanarLike`); F-RING over BG; T-GRAPH — closes
   `cvb_thom_reduced`. Measure F-RING and T-GRAPH from their first children and report: Keryx may give them their own job.

### 5.2 What the implementer may and may not change

**May:** add children (with spec examples; shared ones in `PlaneTopology` / `MapTopology`), change imports (updating `ARCHITECTURE.md`'s
Imports cell and `scripts/Axioms.lean`'s FS131-KP block). **May not:** change any statement of this job (§§ 3.2, 4.1), `IsHoleOf`, `fill`,
`IsOuterTile`, `filledGraph`, `IsRing`, `TwiceApart`, `PlanarLike`, `outerDom`, `EnclosesTile`, or any statement outside this job — a statement
that fails comes back through Keryx. Two watched points: `endpoint_of_far_end`'s exit case (§ 4.1, read CD/CE first) and `PlanarLike`'s
sufficiency for T-GRAPH (§ 4.1 risk).

### 5.3 How `fs131-w5p` merges back into `fs131-w5`

`fs131-w5`'s implementer (FS131-I5c) does not edit the declarations in this job's touches (item 274's fence). The hunks this branch adds or
changes, all disjoint from I5c's: in `MapGraph`, the new `import` line, the `Thomassen` block after `reduced`, the module docstring's `IsHoleOf`
sentence, `IsHoleOf`, the Spec section's adversaries, the `filledGraph` children and the three `cvb_*` leaves, and the tail of
`exists_holed_valid_fragment`'s proof (granted, item 277); in `BaseWalk`, **one `import` line at the head** (outside the three leaves — the leaves
read `MapTopology`; a conflict there, if I5c also adds an import, is a one-line union), the three leaves with their docstrings, and three new
children beside them (`retArcs_not_interleaved`, `retArcs_not_abut`, `endpoint_of_far_end`); in `BaseDense`, `exists_unenclosed_or_bad`'s proof;
two new modules; append-only rows in `Proofs.lean`, `ARCHITECTURE.md` (two new rows; the `MapGraph` and `BaseWalk` rows amended), and the
FS131-KP block of `scripts/Axioms.lean`. Merge with `git merge fs131-w5p` on `fs131-w5` when Keryx says; expected conflicts only in those
append-only files. Nothing with a `sorry` reaches `main`; the branch lands with wave 5 after wave 4.

### 5.4 Notes for Keryx (drafts, each naming its slot)

- **`LEAN.md` § Searching — Lean** (after the last bullet), a draft line: "Unicoherence of `ℂ` and its corollaries (the frontier of a
  complementary component is connected; the last exit) are in `Plane/PlaneTopology` (FS131-KP), planned through
  `IsCoveringMap.existsUnique_continuousMap_lifts` and `Circle.isCoveringMap_exp`; Mathlib has no Jordan curve, Janiszewski or Brouwer
  fixed-point theorem at the pin."
- **CVB's frame erratum** (Keryx has it, item 277): "a boundary component of `x`" presumes no phantom arcs; `ArcMap` reads the closure's
  complement.

## Stage 6 — SAVED: the skeleton builds

- **Stage 2's tree** (the as-given build, admitted after stage 2's edit): **OK, 446 of 446, 8 modules rebuilt, exit 0**
  (`build/gate/build/20261004T231630Z-3347186.log`; driver log `data/fs131/kp/build-stage2.log`).
- **The skeleton, first build: FAIL** on `MapGraph` only — `IsRing`'s and `TwiceApart`'s index binders had no types (`LT ?m` stuck), so
  `IsRing` did not elaborate and its uses failed (`build/gate/build/20261004T233450Z-3489014.log`; `data/fs131/kp/build-stage4.log`). Binders
  annotated (`ℕ`, `V`); `MapGraph` and `BaseWalk` then iterate clean.
- **The skeleton, rebuilt: OK — 446 of 446 batches, 3 modules rebuilt, 11 with warnings, every warning `declaration uses 'sorry'`, exit 0**
  (`build/gate/build/20261004T234604Z-3574873.log`; `data/fs131/kp/build-stage4b.log`). `tools/check_architecture.py`: PASS (exit 0).
  `scripts/Axioms.lean`: block "FS-131 wave 5 (job FS131-KP)", 35 records.

**This job's `sorry` declarations:** `PlaneTopology` 8, `MapTopology` 15, `MapGraph` 10 (`not_isHoleOf_chain`, `isHoleOf_cluster`,
`reduced_props_of_planarLike`, `filledGraph_locallyFinite`, `_connected`, `_infinite`, `_rings`, `_oneInf`, and the in-proof joints of
`cvb_pinch_connected`, `cvb_hole_disconnected`), `BaseWalk` 3 new children, `BaseDense` 1 (`exists_unenclosed_or_bad`'s joints). Of the seven
leaves, four are now `sorry`-free reductions (`cvb_thom_reduced`, `retArcs_nested`, `exists_endpoint`, `exists_eleventh`), and three carry
in-proof joints (`cvb_pinch_connected`, `cvb_hole_disconnected`, `exists_unenclosed_or_bad`).
