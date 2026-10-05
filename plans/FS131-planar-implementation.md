# FS131-IP1 — the planar infrastructure, implemented

*de Bruijn, the implementer (FS131-IP1), 2026-10-04/05. Brief: `data/fs131/briefs/FS131-IP1-planar.md` (main tree). Branch `fs131-w5p`, worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p`. The plan this record executes: `plans/FS131-planar-kernel-plan.md` (FS131-KP), § 5.1's work order.*

## Theorems this phase proved

All [kernel] (stage-5 build `146a8d63`, `build/gate/build/20261005T004641Z-4048849.log`), each on exactly `[propext, Classical.choice,
Quot.sound]` (`data/fs131/ip/axioms-stage5.txt`). Namespace `HadwigerNelson.Plane`; `ArcMap.` where shown.

- `isPreconnected_inter_of_union_eq_univ` — **the plane is unicoherent** (`Plane/PlaneTopology`)
- `isPreconnected_frontier_connectedComponentIn` — the frontier of a component of the complement of a closed preconnected set is preconnected (`Plane/PlaneTopology`)
- `isPreconnected_compl_connectedComponentIn` — the complement of such a component is preconnected (`Plane/PlaneTopology`)
- `isBounded_connectedComponentIn_of_frontier_subset` — the last exit (`Plane/PlaneTopology`)
- `connectedComponentIn_eq_of_not_isBounded` — one unbounded complementary component (`Plane/PlaneTopology`)
- `exists_inter_of_finite_closed_cover` — two of finitely many closed sets meet on a preconnected set they cover (`Plane/PlaneTopology`)
- `isPreconnected_compl_closedBall` (`Plane/PlaneTopology`)
- children `eq_of_intValued_of_isPreconnected`, `inter_frontier_nonempty_of_isPreconnected`, `frontier_connectedComponentIn_subset`, `compl_closedBall_subset_connectedComponentIn` (`Plane/PlaneTopology`)
- `ArcMap.cvb_pinch_connected` — FS114-CVB-PINCH's pinch clause (`Plane/ValidMap/MapGraph`)
- `ArcMap.cvb_hole_disconnected` — FS114-CVB-PINCH's hole clause (`Plane/ValidMap/MapGraph`)
- `ArcMap.IsTile.subset_compl_closure`, `ArcMap.IsTile.subset_or_subset_of_separated`, `ArcMap.exists_tile_inter_of_isOpen`, `ArcMap.exists_tile_mem_closure_of_mem_closure`, `ArcMap.mem_of_touch_closed`, `ArcMap.finite_tiles_closure_inter` — § A (`Plane/ValidMap/MapTopology`)
- `ArcMap.exists_rim_vertex` — E4-OUTERMOST step 3 (`Plane/ValidMap/MapTopology`)
- `ArcMap.isCubicTrichromatic_of_three_tiles` — E4-OUTERMOST step 4, E4-RIM step 5 (`Plane/ValidMap/MapTopology`)
- `ArcMap.tileOf_subset_ball` — Lemma H(a), any `k` (`Plane/ValidMap/MapTopology`)
- `ArcMap.GermPseudo.eq_of_cw`, `ringArc_cases` (`Plane/ValidMap/MapTopology`)
- children `ArcMap.exists_mem_closure_of_mem_closure_biUnion`, `ArcMap.isOpen_outerDom`, `ArcMap.outerDom_eq_connectedComponentIn`, `ArcMap.IsTile.closure_subset_closedBall_zero`, `ArcMap.exists_not_mem_closedBall_zero`, `ArcMap.IsSectorChart.exists_sector_subset_tile`, `ArcMap.hasRepeatedColour_of_two_tiles`, `ringArc_add_two_pi_mul` (`Plane/ValidMap/MapTopology`)

Thirty-two declarations in all. `exists_unenclosed_or_bad`'s three joints are closed; the leaf itself still rests on `exists_outermost` and
`unenclosed_of_rim_vertex`.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

Checked by `grep -F` of each quotation's full text (a planted absent string, `ABSENT-CONTROL-STRING-xyzzy`, reported `MISS`, the control):

| quotation in the brief | source | result |
|---|---|---|
| Kooshi on pricing ("Do not consider Lean formalization a cost. …") | `CLAUDE.md` § Counter-priors | verbatim |
| "**Work order** (each step unblocks the next; re-price after the first two):" | `plans/FS131-planar-kernel-plan.md` § 5.1 (branch) | verbatim |
| "**May:** add children (with spec examples; …), change imports (updating `ARCHITECTURE.md`'s" | same, § 5.2 | verbatim |
| inventory item 282 (truncated at "`397a89de` …") | `plans/FS131-close-inventory.md` (main tree) l. 2096 | verbatim (the source itself carries the ellipsis) |
| inventory item 283 (truncated at "plan § 5.1's") | same, l. 2115 | verbatim |
| inventory item 277 (truncated at "KP's") | same, l. 2040 | verbatim |

No mismatch. Read in full: KP's plan (all six stages); inventory items 277–283; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and
§ Make the gate fail, and watch it fail.

### 1.2 What I may and may not change (KP's plan § 5.2, the brief's touches)

**May:** prove every `sorry` FS131-KP left — `Plane/PlaneTopology` (8), `Plane/ValidMap/MapTopology` (15), in `MapGraph` `not_isHoleOf_chain`,
`isHoleOf_cluster`, `reduced_props_of_planarLike`, `filledGraph_locallyFinite`, `_connected`, `_infinite`, `_rings`, `_oneInf` and the in-proof joints of
`cvb_pinch_connected` and `cvb_hole_disconnected`; in `BaseWalk` `retArcs_not_interleaved`, `retArcs_not_abut`, `endpoint_of_far_end`; in `BaseDense` the
three joints of `exists_unenclosed_or_bad` — adding children beside them (with spec examples; shared ones in `PlaneTopology` / `MapTopology`), changing
imports (with `ARCHITECTURE.md`'s Imports cell and `scripts/Axioms.lean`'s FS131-KP block). Also `Proofs.lean`, this record, `tools/fs131_ip_*.py`,
`data/fs131/ip/`, `data/fs131/reports/FS131-IP1.md`.

**May not:** change any statement of FS131-KP's job (plan §§ 3.2, 4.1), nor `IsHoleOf`, `fill`, `IsOuterTile`, `filledGraph`, `IsRing`, `TwiceApart`,
`PlanarLike`, `outerDom`, `EnclosesTile`, nor any statement outside this job; no new `axiom`, no `native_decide`; not KP's plan file; not the other `sorry`s
in `BaseWalk`/`BaseDense` (FS131-I5c's leaves); no merge into `fs131-w5`, no gate run, nothing on `main`. A statement that fails goes to Keryx at once.
Watched: `endpoint_of_far_end`'s exit case (read FS110-CD Lemma E/R and FS110-CE R1–R4 first; message Keryx if a two-colour exit can return farther than
`60°` from `r(θ)`), and `PlanarLike`'s sufficiency for T-GRAPH.

### 1.3 The as-given build (`d0868ff5`, before any edit)

Under the slot (40 GiB, 8 cpus, `BATCH=4`), queued about 6 minutes behind two other builds: **OK — all 1753 modules already up to date, nothing built,
11 modules with warnings, every warning `declaration uses 'sorry'` (119 lines), exit 0** (`build/gate/build/20261005T000606Z-3729272.log`; driver log
`data/fs131/ip/build-asgiven.log`).

### 1.4 Iteration while the build queued (no tracked file edited)

The foundation leaf was developed in a scratch file `data/fs131/ip/Unico.lean` (imports `PlaneTopology`'s Mathlib modules plus
`Topology.UrysohnsLemma`, `Topology.Homotopy.Contractible`, `Analysis.Convex.Contractible` — the last two supply `SimplyConnectedSpace ℂ`, which
`PlaneTopology`'s present imports do not). `isPreconnected_inter_of_union_eq_univ` iterates clean there (stage 2).

## Stage 2 — SAVED: the foundation (`PlaneTopology`), measured

### 2.1 Proved (iteration-green; the stage build is recorded in § 3.1)

Seven of `PlaneTopology`'s eight leaves, statements byte-identical to KP's (checked by `tools/fs131_ip_splice.py --check-only`, which compares
each module statement with the scratch statement whose proof is spliced; planted control: a scratch copy with `A ∩ B` changed to `A ∪ B` in
unicoherence's conclusion → `REFUSED: isPreconnected_inter_of_union_eq_univ: STATEMENT DIFFERS`, exit 2, while the unplanted
`isPreconnected_compl_closedBall` in the same run passed):

| leaf | how | lines |
|---|---|---|
| `isPreconnected_inter_of_union_eq_univ` (**unicoherence**) | KP's route with one change: lift through `Complex.isCoveringMap_exp : ℂ → ℂ ∖ {0}` instead of `Circle.exp` (no `Circle` coercions); Urysohn by `exists_continuous_zero_one_of_isClosed`; the pasted map by `Continuous.if` (the frontier of `A` lies in `A ∩ B`); constancy of integer-valued functions by the child `eq_of_intValued_of_isPreconnected` (intermediate value `n + 1/2`) | ≈ 95 |
| `isPreconnected_compl_connectedComponentIn` | `isPreconnected_of_forall` from a point of `K`: each other component `D` with a frontier point `p ∈ K` (`nonempty_frontier_iff`, child `frontier_connectedComponentIn_subset`), `insert p D` preconnected (`subset_closure`), then `∪ K` | 33 |
| `isPreconnected_frontier_connectedComponentIn` | unicoherence on `closure C`, `Cᶜ` (`IsOpen.frontier_eq`) | 10 |
| `exists_inter_of_finite_closed_cover` | `isPreconnected_closed_iff` on `C i` and the finite union of the others (`Set.Finite.isClosed_biUnion`) — direct, no contradiction | 18 |
| `isPreconnected_compl_closedBall` | polar image of `Ioi R × univ` (as `isPreconnected_holedAnnulus`); `R < 0` is `univ` | 24 |
| `isBounded_connectedComponentIn_of_frontier_subset` (**the last exit**) | child `compl_closedBall_subset_connectedComponentIn` and child `inter_frontier_nonempty_of_isPreconnected` (Mathlib has no `IsPreconnected.inter_frontier_nonempty` at the pin: KP's docstring named it; grep finds nothing) | 14 |
| `connectedComponentIn_eq_of_not_isBounded` | both components hold the complement of a large disc | 12 |

New children (shared, in `PlaneTopology`): `eq_of_intValued_of_isPreconnected`, `inter_frontier_nonempty_of_isPreconnected`,
`frontier_connectedComponentIn_subset`, `compl_closedBall_subset_connectedComponentIn`. New imports: `Mathlib.Topology.UrysohnsLemma`,
`Mathlib.Topology.Homotopy.Contractible`, `Mathlib.Analysis.Convex.Contractible` (the last two give `SimplyConnectedSpace ℂ`); no project import
changes, so `ARCHITECTURE.md`'s Imports cell stands.

**Binder renamed, type unchanged** (for Keryx): the last exit never reads `hK : IsClosed K` or `hR : IsClosed R`; the unused-variables linter
fires on both, and the gate wants linters silent. I renamed them `_hK`, `_hR` (inventory ruling 281 (a)'s reasons: a binder name is not part of
the type; no caller passes them by name). **Generalization**: the last exit holds for any bounded `K` and any `R`.

### 2.2 Measured, and the chain re-priced from the first two leaves

Unicoherence: about 20 minutes of wall clock from first draft to iteration-green (three iterations, each 2–3 s of `lake env lean`), ≈ 95 lines
against the plan's "M (≈ 120 lines)". The frontier lemma with the five small lemmas and four children: about 15 minutes, four iterations. KP's
§ 4.2 priced "§ A and the small `PlaneTopology` lemmas: one session; unicoherence and the frontier lemma: half a session" — together they took
under a fifth of a session. **Re-price**: the topology that has a textbook proof over Mathlib's connectedness API runs three to five times
under KP's table; I expect § A and the two `cvb_*` pinch/hole leaves in about a third of a session, §§ B–C in about half. The crossing lemma
is the exception (§ 2.3): its price depends on a proof route not yet in hand.

### 2.3 The crossing lemma — a route question, not a statement question

`inter_nonempty_of_interleaved` (KP's H) is left for step 5. KP's sketch ("Phragmén–Brouwer from unicoherence … a line from infinity to
infinity separates its two sides") needs, at its last step, a *separation* fact about a wild set (that `K ∪` two rays separates its two
sides), which unicoherence alone does not give: every unicoherence argument refutes by showing a frontier disconnected, and a connected
separator never yields that. The Phragmén–Brouwer property itself is provable here in about 60 lines (the complement-of-a-component lemma above
does the work), but applying it to the crossing needs `A ∪ B` to separate two points, which for `A ⊇ K`, `B ⊇ K'` is the crossing again. Routes
to weigh at step 5: (a) no-retraction (`D̄ → ∂D` with degree one cannot exist, provable with the same lifting theorem on `ℂ`) plus a
Poincaré–Miranda-type construction from disjoint `K`, `K'`; (b) the boundary graph BG (step 4) making both continua unions of arc pieces, where
the crossing becomes a finite planar-graph fact. Recorded here so step 5 starts from it.

## Stage 3 — SAVED: `MapTopology` § A, and two of the seven planar leaves closed (`cvb_hole_disconnected`, `cvb_pinch_connected`)

### 3.1 The stage-2/3 build

`1779e981` under the slot (40 GiB, 8 cpus, `BATCH=4`, queued about 15 minutes behind two builds): **OK — 446 of 446 batches, 6 modules
rebuilt (`PlaneTopology` 2.2 s, `MapTopology` 1.6 s, `BaseWalk` 1.9 s, `MapGraph` 9.4 s, `BaseDense` 1.5 s, `Proofs`), 11 modules with
warnings, every warning `declaration uses 'sorry'`, exit 0** (`build/gate/build/20261005T002316Z-3863003.log`; driver log
`data/fs131/ip/build-stage3.log`).

### 3.2 Proved

- **`MapTopology` § A, all six leaves**: `IsTile.subset_compl_closure` (open and disjoint, `Disjoint.closure_right`),
  `IsTile.subset_or_subset_of_separated` (`isPreconnected_closed_iff` on the two closures), `exists_tile_inter_of_isOpen`
  (`dense_interiorPts`), `exists_tile_mem_closure_of_mem_closure` and `mem_of_touch_closed` (both over the new shared child
  **`exists_mem_closure_of_mem_closure_biUnion`**: a closure point in the domain of the union of the closures of any family of tiles is a
  closure point of one of them — `finite_tiles_near`, the only place local finiteness enters), `finite_tiles_closure_inter`
  (`IsCompact.elim_nhds_subcover`).
- **`cvb_hole_disconnected`** (row FS114-CVB-PINCH's hole clause): KP's four joints, then the boundary dart of a walk
  (`SimpleGraph.Walk.exists_boundary_dart`, confirmed at the pin). The skeleton's comment shape is kept; ≈ 75 lines.
- **`cvb_pinch_connected`** (the pinch clause): KP's plan through the separation. `P` = tiles reachable from a far tile `A` in `M − T`;
  `Y` = the union of the components of `(cl T)ᶜ` holding a tile of `P` (open, saturated), `Hc` = the rest; every tile in such a component is
  in `P` (`mem_of_touch_closed` on the component); a common closure point of `Hc` and `Y` gives touching tiles on both sides, so `Hc` and `Y`
  are separated; `Y` holds the complement of a large disc, so `Hc` is bounded — a hole unless empty. Local finiteness is read only through
  `exists_mem_closure_of_mem_closure_biUnion` at one point (KP's claim, confirmed). ≈ 150 lines. KP's two in-proof `have`s (`hbd`, `hne`) are
  absorbed into the restructured proof (in-proof joints, no statement).

## Stage 4 — SAVED: §§ B–D pieces, `exists_unenclosed_or_bad`'s joints

### 4.1 The stage-4 build

`f587bfea`: **OK — 446 of 446 batches, 5 modules rebuilt (`MapTopology` 3.6 s, `BaseWalk`, `MapGraph` 9.7 s, `BaseDense`, `Proofs`), 11 modules
with warnings, every warning `declaration uses 'sorry'`, exit 0** (`build/gate/build/20261005T003356Z-3939265.log`; `data/fs131/ip/build-stage4.log`).

### 4.2 Proved

- **`exists_rim_vertex`** (E4-OUTERMOST step 3, KP's narrower hypotheses): the rim `Φ = frontier (outerDom T)` is preconnected (the frontier
  lemma), compact, in `cl T` and nonempty; the tiles of the outer domain touching it are finitely many and cover it; one alone would enclose `T`
  (the last exit, against `hno`), so two meet on `Φ` (`exists_inter_of_finite_closed_cover`). ≈ 75 lines. New shared children in § B:
  **`isOpen_outerDom`**, **`outerDom_eq_connectedComponentIn`** (for a set whose closure lies in `B̄(0, R)`, the outer domain is the component
  through any point outside it), `IsTile.closure_subset_closedBall_zero`, `exists_not_mem_closedBall_zero`.
- **`tileOf_subset_ball`** (Lemma H(a), any `k`): `endpoint_dist_ge`'s connectedness argument, then openness makes `≤ 1` strict.
- **`GermPseudo.eq_of_cw`**: two germs of positive length share a point.
- **`ringArc_cases`**: shift the second arc by `2πn`, `n = ⌊(s − s' + π)/2π⌋`, to start within `π` of `s`; the eight order cases; disjoint
  real intervals give disjoint arcs because two angles of the two arcs differ by less than `2π` (`e_eq_e_iff`). New child
  `ringArc_add_two_pi_mul`.
- **`exists_unenclosed_or_bad`'s three joints** (`BaseDense`): the rim misses the open outer domain (`IsOpen.inter_frontier_eq`); `T` misses
  its outer domain, so `T ≠ X`, `T ≠ Y`. The leaf itself still rests on `exists_outermost`, `isCubicTrichromatic_of_three_tiles` and
  `unenclosed_of_rim_vertex`.

### 4.3 The axiom check (iteration, against the stage-4 oleans)

`data/fs131/ip/AxiomsIP.lean` (output `data/fs131/ip/axioms-stage4.txt`, `pp.fullNames`): all 29 declarations proved by this job on exactly
`[propext, Classical.choice, Quot.sound]`; the two partners that must show `sorryAx` do (`exists_unenclosed_or_bad`, whose `exists_outermost`
is open, and `inter_nonempty_of_interleaved`) — the check sees a `sorry` when there is one. `scripts/Axioms.lean`'s FS131-KP block gains the
ten new children (a comment line "FS131-IP1's added children" heads them).

### 4.4 The leaves left (named)

| file | leaf | state |
|---|---|---|
| `PlaneTopology` | `inter_nonempty_of_interleaved` (the crossing lemma) | route open (§ 2.3) |
| `MapTopology` § B | `exists_outermost` | owes `not_encloses_of_hull_eq` (sector charts at non-vertex points of the common outer frontier) and the finite-chain argument |
| `MapTopology` § B | `isCubicTrichromatic_of_three_tiles`, `unenclosed_of_rim_vertex` | both need one shared child: a tile whose closure holds `v` contains a sector of `v`'s chart at every small radius, distinct tiles distinct sectors (`IsSectorChart.cover`, `.disjoint`, `.isSector_iff`) — then two tiles of one colour give `HasRepeatedColour`, and a cubic vertex has exactly its three tiles |
| `MapTopology` § C | `exists_eleventh_of` | E4-RIM's five steps; all its topology is now proved (§§ A–B children, the last exit) |
| `MapTopology` § D | `exists_far_end` | BG + PATH (the finite boundary graph) |
| `MapGraph` | `not_isHoleOf_chain`, `isHoleOf_cluster` | concrete geometry (adversaries) |
| `MapGraph` | `filledGraph_locallyFinite`, `_connected`, `_infinite`, `_oneInf` | F-LOC/CONN/INF/ONE, over § A–B |
| `MapGraph` | `filledGraph_rings` (F-RING), `reduced_props_of_planarLike` (T-GRAPH), `triLattice_planarLike` (owed inhabitant) | not started |
| `BaseWalk` | `retArcs_not_interleaved`, `retArcs_not_abut`, `endpoint_of_far_end` | over the crossing lemma, PATH, and the CD/CE reading |

## Stage 5 — SAVED: `isCubicTrichromatic_of_three_tiles`, the stage-5 build, and what is handed on

### 5.1 Proved

**`isCubicTrichromatic_of_three_tiles`**, over two new shared children in `MapTopology` § B: **`IsSectorChart.exists_sector_subset_tile`** (a
tile whose closure holds the chart's point contains a sector of every radius `r ∈ (0, r₀]`: a sector meeting the tile is preconnected inside the
interior points, so inside the tile's component) and **`hasRepeatedColour_of_two_tiles`** (two distinct tiles of one colour at `v` give
`HasRepeatedColour v`: two disjoint nonempty sectors of that colour at every small radius; with no germ the ball is one tile). Then three
distinct tiles at a good point have three distinct colours, `coloursAt` has at most three (not in `fourSet`), and
`isCubicTrichromatic_of_three_of_noRep` finishes. The same child is the first half of `unenclosed_of_rim_vertex` (a cubic vertex's tiles are
exactly the three holding its three sectors).

### 5.2 The stage-5 build and the receipt

`146a8d63`: **OK — 446 of 446 batches, 5 modules rebuilt, 11 modules with warnings, every warning `declaration uses 'sorry'`, exit 0**
(`build/gate/build/20261005T004641Z-4048849.log`; `data/fs131/ip/build-stage5.log`). No warning of any other kind in the saved log (grep for
`warning|error` minus the `sorry` lines and Lake's `--no-build` probe line: empty). Axiom check `data/fs131/ip/axioms-stage5.txt`: 32 records on
exactly the standard three; the two partners on `sorryAx` (`exists_unenclosed_or_bad`, `inter_nonempty_of_interleaved`) show it.
`tools/check_architecture.py`: PASS, exit 0 (`data/fs131/ip/check-architecture.txt`; no project import changed). `sorry` lines left:
`PlaneTopology` 1, `MapTopology` 4.

### 5.3 Measured cost, and the chain re-priced

Wall clock for stages 2–5: about 50 minutes (stage 1's commit at 00:08Z to stage 5's at 00:57Z), of which about 30 were three builds and
their queues, for 32 declarations (≈ 1,100 lines) in about a third of this session's context; two of the seven planar leaves closed
outright (`cvb_pinch_connected`, `cvb_hole_disconnected`) and 15 of the 23 topology leaves (`PlaneTopology` 7 of 8, `MapTopology` 11 of 15)
with `exists_unenclosed_or_bad`'s joints. Every leaf with a textbook proof over Mathlib's connectedness API closed on its first or second
iteration; the price driver is not topology but the map's local structure (sector charts) and the two finite-graph constructions.

| what is left | price (implementer sessions, this job's measured rate) | why |
|---|---|---|
| `unenclosed_of_rim_vertex` | 0.3 | `exists_sector_subset_tile` gives the three tiles; the one case needing geometry is `T' = Y` (the `T|X` branch near `v` misses `cl Y`: the sector of `Y` is bounded by the other two branches) — read `G.sector`'s definition first |
| `exists_outermost` (with `not_encloses_of_hull_eq`, `compl_outerDom_subset_convexHull`) | 0.5–0.8 | hull monotonicity under enclosure is plain topology (worked out on paper below); strictness needs the sector picture at a non-vertex point of the common outer frontier |
| `exists_eleventh_of` | 0.4 | all its topology is now proved; E4-RIM's steps over `tileOf_subset_ball`, `noBoth`, the last exit and the finite cover |
| F-LOC, F-CONN, F-INF, F-ONE | 0.5 | over § A–B as built |
| `not_isHoleOf_chain`, `isHoleOf_cluster` | 0.3–0.5 | concrete norm geometry |
| BG + PATH + `exists_far_end` + `endpoint_of_far_end` (with the CD/CE reading) | 1.5–2 | the finite boundary graph is new infrastructure |
| the crossing lemma, then `retArcs_not_interleaved`, `retArcs_not_abut` | 1–2 | route open (§ 2.3); over PATH once BG exists |
| F-RING, T-GRAPH, `triLattice_planarLike` | 2–3 (not measured) | not started |

Total left: about 6.5–9.5 sessions. The measured pieces (topology over Mathlib's connectedness API) ran about three times under KP's table
(this one session did what KP priced at about 2.5); the unmeasured pieces — BG, the crossing lemma, F-RING, T-GRAPH — keep KP's prices, since
nothing here measured them, and they are where the time now goes. **Not measured, as the brief asked**: F-RING and T-GRAPH from their first
children — I did not reach them; the row above is read from the statements, not measured.

### 5.4 Worked on paper, for the successor (`exists_outermost`)

If `T'` encloses `T` (`y ∈ T \ cl T'` in a bounded component `B'` of `(cl T')ᶜ`), then `T ≠ T'`, `T ⊆ B'`, and the unbounded component `W'`
of `(cl T')ᶜ` misses `cl T` (`W' ∩ B' = ∅`, `W' ∩ cl T' = ∅`, `cl T ⊆ B' ∪ cl T'`), so `W' ⊆ outerDom T` and **hull `T ⊆` hull `T'`**. If the hulls
are equal, `outerDom T = outerDom T'` and its frontier lies in `cl T ∩ cl T'`; it is preconnected (the frontier lemma) with at least two
points (a one-point frontier would split `ℂ ∖ {p}`), so it is infinite and has a point off the finitely many vertices of a compact disc, where
the sector chart has two sectors, one of `T` and one of `T'` — and that point is in the closure of the outer domain, which meets neither tile:
contradiction. Then the finite family of tiles whose closures meet `B̄(x, 1)` (`finite_tiles_closure_inter`), ordered by hull inclusion, has a
maximal member containing `x` in its hull; it is enclosed by none.

### 5.5 For the coordinator

- **F-RING and T-GRAPH: each deserves its own job** (judged from the statements, not measured). T-GRAPH (`reduced_props_of_planarLike`, with
  the owed inhabitant `triLattice_planarLike`) is pure graph theory, with KP's recorded risk that `PlanarLike` may need one more field; F-RING
  needs the boundary graph BG first.
- **What a second implementer could take now, without sharing a file with whoever continues `MapTopology`/`BaseWalk`**: the crossing lemma
  `inter_nonempty_of_interleaved` — the only leaf left in `Plane/PlaneTopology`, which nothing else in this chain will edit (a route
  decision first: § 2.3). T-GRAPH is disjoint from the map-level leaves but lives in `MapGraph`'s `Thomassen` block; it shares a file with
  F-LOC/CONN/INF/ONE and the adversaries unless Keryx moves the `Thomassen` block to its own module.
- **The 60° question** (`endpoint_of_far_end`): not reached; FS110-CD Lemma E/R and FS110-CE R1–R4 not read by this job.
- **Binder renames**: the last exit's `hK`, `hR` → `_hK`, `_hR` (§ 2.1; type unchanged).

## Stage 6 — SAVED: FS131-IP2's readback (the second implementer, from IP1's Stage 5)

*de Bruijn, the implementer (FS131-IP2), 2026-10-05. Brief: `data/fs131/briefs/FS131-IP2-planar.md` (main tree). Same branch and worktree; I append
stages from here. Read in full at launch: the brief, `plans/STANDING-RULES.md`, `LEAN.md`, `RUNNING.md` § Building and § Make the gate fail, this record
(stages 1–5), KP's plan §§ 3–5 (and its Stage 6), inventory items 277, 292, 293.*

### 6.1 The brief's quotations against their sources (standing rule 3)

Checked by `grep -F` of each quotation's full text (planted absent string `ABSENT-CONTROL-STRING-xyzzy` reported `MISS`, the control):

| quotation in the brief | source | result |
|---|---|---|
| inventory item 292 (truncated at "`data/fs131/reports/FS131-IP1.md`;") | `plans/FS131-close-inventory.md` (main tree) l. 2219 | verbatim |
| inventory item 293 (truncated at "a binder name is not part") | same, l. 2240 | verbatim |
| the `unenclosed_of_rim_vertex` price row | this record § 5.3 | verbatim |
| "If `T'` encloses `T` (… the unbounded component `W'`" | this record § 5.4 | verbatim |
| "`inter_nonempty_of_interleaved` (KP's H) is left for step 5. KP's sketch (…" | this record § 2.3 | verbatim |
| Kooshi on pricing ("Do not consider Lean formalization a cost. …") | `CLAUDE.md` § Counter-priors | verbatim |
| "**Work order** (each step unblocks the next; re-price after the first two):" | KP's plan § 5.1 | verbatim |
| "**May:** add children (with spec examples; …), change imports (updating `ARCHITECTURE.md`'s" | KP's plan § 5.2 | verbatim |
| inventory item 277 (truncated at "KP's") | `plans/FS131-close-inventory.md` l. 2040 | verbatim |

No mismatch.

### 6.2 What I may and may not change (the brief's touches, ruling 293 (b), KP's plan § 5.2)

**May:** prove the `sorry`s in `Plane/ValidMap/MapTopology` (`exists_outermost`, `unenclosed_of_rim_vertex`, `exists_eleventh_of`, `exists_far_end`); in
`MapGraph` outside the `namespace HadwigerNelson.Thomassen` block (l. 36–595 at `01011037`): `not_isHoleOf_chain`, `isHoleOf_cluster`,
`filledGraph_locallyFinite`, `_connected`, `_infinite`, `_rings`, `_oneInf`; in `BaseWalk` `endpoint_of_far_end`, `retArcs_not_abut`,
`retArcs_not_interleaved` (the last over the crossing lemma as given, carrying `sorryAx` until FS131-IX1 merges); add children beside them with spec
examples (shared ones in `MapTopology` or `MapGraph` outside the `Thomassen` block; BG and PATH in `MapTopology` § D); change imports (with
`ARCHITECTURE.md`'s Imports cell, `scripts/Axioms.lean`'s FS131-KP block above `=== PURCHASED ===`). Also `Proofs.lean`, this record,
`tools/fs131_ip_*.py`, `data/fs131/ip/`, `data/fs131/reports/FS131-IP2.md`. A later leaf of ruling 293 (b)'s order may go first when cheaper, said here.

**May not:** change any statement of KP's job (plan §§ 3.2, 4.1) or any definition they use (`IsHoleOf`, `fill`, `IsOuterTile`, `filledGraph`, `IsRing`,
`TwiceApart`, `PlanarLike`, `outerDom`, `EnclosesTile`), nor any statement outside this job; no new `axiom`, no `native_decide`; nothing in
`Plane/PlaneTopology` (FS131-IX1's) or inside the `HadwigerNelson.Thomassen` block (T-GRAPH's later job); not KP's plan file; not the other `sorry`s in
`BaseWalk`/`BaseDense` (wave 5's lane); no merge, no gate run, nothing on `main`; no file edited while a build of it runs. A leaf that cannot be
proved as written goes to Keryx at once. The 60° question is answered here before `endpoint_of_far_end`; a no stops that leaf and goes to Keryx.

### 6.3 The as-given build (`01011037`, before any edit)

Under the slot (40 GiB, 8 cpus, `BATCH=4`): **OK — all 1753 modules already up to date, nothing built, 11 modules with warnings, every warning
`declaration uses 'sorry'`, exit 0** (`build/gate/build/20261005T010519Z-4684.log`; driver log `data/fs131/ip/build-ip2-asgiven.log`).
