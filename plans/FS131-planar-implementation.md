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

**FS131-IP2 (stages 6–)**, all [kernel] (stage-7 build `f0e0c249`, `build/gate/build/20261005T012057Z-111415.log`), each on exactly the standard three
(`data/fs131/ip/axioms-ip2-stage7.txt`, checked by `tools/fs131_ip_axioms.py`):

- `ArcMap.exists_unenclosed_or_bad` — **FS131-E4's E4-OUTERMOST, whole** (`Plane/ValidMap/BaseDense`; its last two leaves below)
- `ArcMap.exists_outermost` — E4-OUTERMOST steps 1–2 (`Plane/ValidMap/MapTopology`)
- `ArcMap.unenclosed_of_rim_vertex` — E4-OUTERMOST step 5 (`Plane/ValidMap/MapTopology`)
- `ArcMap.not_encloses_of_hull_eq` — enclosure strictly grows hulls (KP's owed child) (`Plane/ValidMap/MapTopology`)
- `ArcMap.exists_ball_two_tiles` — points with three tiles in their closure are isolated (`Plane/ValidMap/MapTopology`)
- children `ArcMap.outerDom_subset_of_encloses`, `ArcMap.compl_outerDom_subset_closedBall`, `ArcMap.IsSectorChart.exists_sector_mem_closure`,
  `BranchGerms.exists_far_side`, `BranchGerms.eventually_dir_lt_nextDir`, `BranchGerms.dir_lt_dir`, `BranchGerms.dir_le_dir`,
  `BranchGerms.dir_lt_dir_zero_add`, `BranchGerms.next_injective` (`Plane/ValidMap/MapTopology`)

- `ArcMap.exists_isRingArc_of_touch` — at a cubic touch point on `ω(u)`, a tile inside `B(u, 1)` and one off `B̄(u, 1)` bound an arc of `Γ` on `ω(u)`
  (`Plane/ValidMap/MapTopology`); children `BranchGerms.branchPt_mem_closure_sector`, `BranchGerms.eq_or_next_eq_of_mem_closure_sector` (stage 8)
- `ArcMap.exists_eleventh_of` — **FS131-E4's E4-RIM** (`Plane/ValidMap/MapTopology`), hence `BaseCtx.exists_eleventh`: proved, **on `sorryAx` through
  `noBoth`** (FS112-N3-NOBOTH, `ValidMap/UnitArc`, wave 4's leaf, `sorry` at the pin, used by statement); it lands on the standard three when `noBoth`
  does

**FS131-IP3 (stages 9–)**, all [kernel] (stage-11 build, `build/gate/build/20261005T023343Z-612010.log`), each on exactly the standard three
(`data/fs131/ip/axioms-ip3-stage11.txt`, checked by `tools/fs131_ip_axioms.py`: 35 clean, the 2 controls `endpoint_of_far_end`, `exists_endpoint` on `sorryAx`):

- `ArcMap.exists_far_end` — **the `a|c` boundary's far end** (FS110-CD Lemma E's planar parity step), as stated (`Plane/ValidMap/MapTopology`)
- `even_sum_deg`, `exists_finset_even_sum_deg` — **the boundary graph's handshake (BG)**: in a compact set with a curve star at each point, the degrees at the
  non-regular points have an even sum (`Plane/CurveGraph`, new module)
- `port_pair` — each port of the cut-out vertices has exactly one partner, the other end of its arc (`Plane/CurveGraph`)
- `IsCurve.eq_of_three`, `IsCurve.exists_param`, `HasCurveStar.isRegularAt`, `finite_nonRegular`, `branch_locally_curve`, `HasCurveStar.connectedComponentIn`,
  `not_isRegularAt_of_hasCurveStar_one`, `IsCurve.exists_two_mem_sphere`, and 13 more children (`Plane/CurveGraph`); inhabitant `halfLine_hasCurveStar`
- `ArcMap.exists_inner_branch` — at a two-colour change point of `ω(u)` one branch enters the disc and the other leaves it (`MapTopology` § D)
- `ArcMap.IsSectorChart.eq_two`, `.inter_closure_two`, `.hasRepeatedColour_of_col_eq`, `.col_mem_coloursAt`, `.col_eq_of_mem_sector`,
  `ArcMap.hasCurveStar_of_branches`, `ArcMap.coloursAt_subset_of_mem_interiorPts`, `ArcMap.fin_two_eq_of_ne` (`MapTopology` § D)

**FS131-IP4 (stages 12–)**, all [kernel] (stage-14 build `build/gate/build/20261005T032249Z-941152.log`, stage-15 build
`build/gate/build/20261005T040047Z-1228628.log`), on the standard three except where `sorryAx` is named (`data/fs131/ip/axioms-ip4-stage14.txt`,
`data/fs131/ip/axioms-ip4-stage15.txt`, checked by `tools/fs131_ip_axioms.py`):

- `ArcMap.BaseCtx.retArcs_not_abut` — **NEST-A**, as stated (`Plane/ValidMap/BaseWalk`); standard three
- `ArcMap.BaseCtx.retArcs_not_interleaved` — **NEST-X**, as stated (`Plane/ValidMap/BaseWalk`); `sorryAx` only through `cor3` (wave 5's leaf, used by
  statement); so `retArcs_nested` rests on `cor3` alone
- `ArcMap.BaseCtx.endpoint_of_far_end` — **END-C**, as stated (`Plane/ValidMap/BaseWalk`), hence `exists_endpoint` (FS110-CD Lemma E with CE R1–R4);
  `sorryAx` only through `pseudo_finite`, `pair_ii`, `noBoth`, `cor3` (waves 4–5's leaves, used by statement)
- `orient_aux`, `orient` — **one-sidedness**: a continuum in `B̄(u, 1)` with an open set one-sided along it cannot have that set on the counter-clockwise side of
  two of its circle points (`Plane/ValidMap/MapTopology` § E); `ArcMap.BaseCtx.orient_pair` (`BaseWalk`)
- `ArcMap.circ_local` — the common boundary of two tiles at a point of `ω(u)`: a star of at most two rays in the closed disc, one exactly at a change point
  (`MapTopology`)
- children `inter_nonempty_of_interleaved_radius`, `polarPt_ne_of_sub`, `ringPt_eq_polarPt`, `branch_side`, `hasCurveStar_zero`, `exists_annular_out`,
  `exists_annular_in`, `subset_or_subset_of_closed`, `side_contra`, `exists_Ico_ringPt`, `disjoint_closedBall_of_isOpen`, `BranchGerms.shared_germ3`,
  `ArcMap.tile_side`, `ArcMap.germ_side`, `ArcMap.germ_side_cw`, `ArcMap.germPseudo_of_side`, `ArcMap.inner_star`, `ArcMap.coloursAt_subset_near`,
  `ArcMap.IsSectorChart.sector_subset_tile_of_mem`, `.tile_inter_ball_eq`, `.mem_closure_some_sector`, `ArcMap.TileOf.eq_colour`,
  `ArcMap.GermPseudo.congr_e`, `.eq_of_same` (`MapTopology`); `ArcMap.BaseCtx.colours_sub` (`BaseWalk`; `sorryAx` through `cor3`)

IP1's thirty-two declarations and IP2's seventeen (plus `exists_eleventh_of`, conditional on `noBoth`). `exists_unenclosed_or_bad`'s three joints are closed; the leaf itself still rests on `exists_outermost` and
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

## Stage 7 — SAVED: `unenclosed_of_rim_vertex`, `exists_outermost`; `exists_unenclosed_or_bad` closed

### 7.1 Proved

- **`unenclosed_of_rim_vertex`.** The chart at the cubic `v` has three germs (`HasDegree v 3` against `IsSectorChart.hasDegree`); below some radius
  the germs are strictly ordered (new child `BranchGerms.eventually_dir_lt_nextDir`: a direction gap persists by continuity, germs of one direction
  are ordered by curvature at every distance). `T`, `X`, `Y` hold three distinct sectors, so they are the only tiles at `v`. For `S = X` (or `Y`)
  and a tile `T'`: `T' = T` is `X ⊆ outerDom T`; `v ∉ cl T'` joins `X` to `T` by a small disc; `v ∈ cl T'` forces `T' = Y`, and then `X` and `T`
  both meet **the far side of `Y`'s sector** (new child `BranchGerms.exists_far_side`: the second sector of the two-germ chart of `Y`'s bounding
  germs — open, connected, missing `Y`'s sector, holding every other sector and every other germ's branch points; built from the library's
  `isOpen_sector`, `isPreconnected_sector`, `sector_disjoint` on a `BranchGerms 2`). Either way `X`'s point and a point of `T` share a component of
  `(cl T')ᶜ`, unbounded by `hno`. IP1's case "`T' = Y`" was the only geometry, as priced.
- **`exists_outermost`.** Candidates: tiles with `x` in the hull. A disc holding a closure holds the hull (child `compl_outerDom_subset_closedBall`);
  a tile's closure lies within `1` of each of its points, so `x` in the hull puts the closure, then the hull, in `B̄(x, 1)` — **no convex hulls
  needed** (KP's `compl_outerDom_subset_convexHull` is not used). Finitely many candidates (`finite_tiles_closure_inter`); one with a maximal hull
  (`Set.Finite.exists_maximalFor`); enclosure grows hulls (child `outerDom_subset_of_encloses`, record § 5.4's paper argument) and strictly
  (`not_encloses_of_hull_eq`).
- **`not_encloses_of_hull_eq` — the route.** Strictness is **false for open connected sets in general** (two of Wada's lakes have one outer
  frontier and enclose each other), so it must read the map's regularity. IP1's sketch read "finitely many vertices in a compact disc", which
  nothing here holds yet. The route taken: **points with three tiles in their closure are isolated** (`exists_ball_two_tiles`: in a chart ball, a
  point off the centre is interior, or on one branch, whose closure meets only the two sectors that branch bounds — `exists_far_side` again; child
  `IsSectorChart.exists_sector_mem_closure`). Were the hulls equal, every point of the common rim would carry `T`, `T'` and a tile of the outer domain;
  the rim is preconnected, so isolation makes it one point, and a one-point rim would split `ℂ ∖ {p}` (Mathlib's
  `isConnected_compl_singleton_of_one_lt_rank`; new import `Mathlib.Analysis.Normed.Module.Connected` in `MapTopology`, no project import changed).
- **`exists_unenclosed_or_bad`** (`BaseDense`) needs nothing more: its three joints (IP1), `exists_rim_vertex`, `isCubicTrichromatic_of_three_tiles`
  and the two leaves above. **E4-OUTERMOST is [kernel]** on the standard three. (`localDense`, its consumer, still rests on `n3_base`, wave 5's lane.)
- Spec example: the straight three-germ chart satisfies `exists_far_side`'s hypothesis (an `example` beside it).

### 7.2 The stage-7 build and the receipt

`f0e0c249` under the slot (40 GiB, 8 cpus, `BATCH=4`): **OK — 446 of 446 batches, 5 modules rebuilt (`MapTopology` 4.1 s, `BaseWalk`, `MapGraph`,
`BaseDense`, `Proofs`), 11 modules with warnings, every warning `declaration uses 'sorry'`, exit 0** (`build/gate/build/20261005T012057Z-111415.log`;
`data/fs131/ip/build-stage7.log`; grep for `warning|error` minus `sorry` lines leaves only Lake's `--no-build` probe line). Axioms
(`data/fs131/ip/AxiomsIP2.lean` → `data/fs131/ip/axioms-ip2-stage7.txt`): **14 records on the standard three, the 2 partners (`exists_eleventh_of`,
`localDense`) on `sorryAx`**, checked by the new `tools/fs131_ip_axioms.py` (fails on a record off the standard three, a control without `sorryAx`, a
missing record, or an unexpected record). Planted faults, both watched to fire: a `sorry` control listed as clean → `NOT CLEAN`, exit 1; a clean
record listed as a control → `CONTROL SHOWS NO sorryAx`, exit 1. `scripts/Axioms.lean`'s FS131-KP block gains IP2's eleven children (under "--
FS131-IP2's added children"). `sorry` declarations left in `MapTopology`: `exists_eleventh_of`, `exists_far_end`.

### 7.3 Re-priced after the first two leaves

Both leaves closed on iteration in well under a session's tenth each once the shared child (`exists_far_side`) existed; the child itself (≈ 130
lines with its index lemmas) was most of the cost. **The sector chart is now the reusable engine**: `exists_far_side` and `exists_ball_two_tiles`
answer, from any chart, "which sectors does this point touch". Re-price of what is left (implementer sessions): `exists_eleventh_of` 0.3 — its
plan is written (§ 7.5), the one new geometric child being the ring arc at a touch point on `ω(u)`; F-LOC/CONN/INF/ONE 0.4; the adversaries 0.3;
**BG + PATH 0.6–1** (cheaper than KP's table: the vertex set of a compact disc is finite by `exists_ball_two_tiles` and compactness, which is BG's
hardest finiteness); `exists_far_end` 0.3 over BG; `endpoint_of_far_end` **1 or more** (§ 7.4: it needs the orientation of the boundary at an exit,
a Jordan-type step); `retArcs_not_abut`, `retArcs_not_interleaved` 0.5 over PATH; F-RING 1–2 (not measured).

### 7.4 The 60° question (brief, done-means 3), read before `endpoint_of_far_end`

Read: FS110-CD § 2.3 (the inward continuation, Lemma E), § 2.4 (Lemma R), § 3.0 items 1–3; FS110-CE § E3 (D5 items 1–2, R1–R4), `plans/FS110-derivation.md`
FS110-CE3, -CE4, -CE6. **Answer: yes — a two-colour exit that is a return returns within 60° of `r(θ)`.** CD Lemma R step 1: "`|b − b′| < 1`: both lie in
the closure of the `a`-region along `β` (F3 gives `≤ 1`), and `= 1` would put two `{a,c}` circle points at unit distance (bi–bi)"; CB D5 item 1 as CE
quotes it: "Its ends are < 1 apart (the a-tile along it has diameter ≤ 1; = 1 is (P′)) … their arcs (< 60°) nest or are disjoint". A chord below `1` is
an angle below `60°`, which is `IsRetArc`'s bound. So the leaf is not stopped; no message sent.

**Two route findings for `endpoint_of_far_end` (not statement defects; for the coordinator):**
1. `exists_far_end`'s second disjunct, `q ≠ r(θ) ∧ dist q u = 1`, also admits **spike touches** (CE's SPIKE and spike corners: the `a|c` boundary
   touches `ω(u)` from inside and the circle does not change colour, CE3), where no returning pair exists (CE R1: the path continues), and three-colour
   V-out vertices of `ω(u)`. From such a `q` no endpoint follows. `endpoint_of_far_end`'s conclusion does not mention `q`, so the statement stays true
   (it is `exists_endpoint`'s conclusion), but its proof must **re-select** the far end: the handshake's odd vertices on `ω(u)` are exactly the points
   where one branch of the `T₁|T₂` boundary lies in the closed disc (a spike touch has two, even). Plan: a strong child of `exists_far_end` returning
   an odd vertex, used by both leaves.
2. At a genuine exit `q = r(φ)`, `IsRetArc` needs the germs' pseudo-colours in the right orientation (`c` inside `[θ, φ]` at both ends): CD's step 2
   ("`β ∪ I` bounds a region `Q`", tightened in § 3.0 item 1 by pushing `β` off `ω(u)`) — a Jordan-type step. It may follow from the crossing lemma
   (two continua in the disc joining interleaved circle points meet), applied to the `c`-tile's side and the `a`-tile's side; not yet worked.

### 7.5 `exists_eleventh_of`, planned (for whoever takes it next, if I do not finish it)

E4-RIM over the pieces now held: (i) each colour of `u` has a tile at `u` (`exists_mem_closure_of_mem_closure_biUnion` over the tiles of that
colour); (ii) a tile of a colour of `u` meeting `B̄(u, 1)` lies in `B(u, 1)` (`tileOf_subset_ball`, `closure_ball`); (iii) `𝒯` = tiles of `u`'s
colours meeting `B(u, 1)`, finite; `K₀` the union of their closures, `R*` the component of `u` (closed: its closure is preconnected in `K₀`); a
member whose closure meets `R*` has its closure in `R*`; (iv) `W` the component of `R*ᶜ` through `u + 2` (holds `(B̄(u, 1))ᶜ`), `Φ = frontier W`,
preconnected, compact, nonempty; (v) one member alone on `Φ` would enclose a tile at `u` of another colour (the last exit) against `UnenclosedC u`;
two meet at `q ∈ Φ` (`exists_inter_of_finite_closed_cover`); (vi) a tile `Y` at `q` meets `W` (`exists_tile_mem_closure_of_mem_closure`), so `Y` is
neither member; `q` is cubic trichromatic (`isCubicTrichromatic_of_three_tiles`, H at `q`); (vii) `Y` has no colour of `u`: if it met `B(u, 1)` it
would be a member inside `R*`; else `Y` misses `B̄(u, 1)` and touches the member `T₀ ⊆ B(u, 1)` at `q ∈ ω(u)` — **the one new child**: at a cubic
`q`, a tile inside `B(u, 1)` and a tile off `B̄(u, 1)` touching there are adjacent sectors whose common branch lies on `ω(u)`, and a short arc of it is
an `IsRingArc u θ₁ θ₂ a c` (branch points are closure points of both sectors and of no other — `exists_far_side`; the angle about `u` is
`arg ((p s − u)/(q − u))`, continuous since the chord stays below `1`, injective, so its image holds an interval); then `BothKind` and `noBoth`
(wave 4's leaf, `sorry` at the pin, used by statement) give a bad point at `u`, against H; (viii) the colours: `{a, b, c}` with `c ∉ P_cl(u)`,
two in common, and a second tile of `a` at `q` would be a repeated colour. `exists_eleventh_of` will carry `sorryAx` through `noBoth` until that
leaf lands.

## Stage 8 — SAVED: `exists_eleventh_of` (E4-RIM), over one new child and `noBoth`

### 8.1 Proved

`exists_eleventh_of` as planned in § 7.5, steps (i)–(viii), with one new geometric child, **`exists_isRingArc_of_touch`**: at a cubic `q` the chart
has three germs, any two of its sectors are adjacent (`decide` on `Fin 3`), so the sectors of `A` (inside `B(u, 1)`) and `Y` (off `B̄(u, 1)`) share a
germ `m`; its branch points are closure points of both sectors (child `BranchGerms.branchPt_mem_closure_sector`, by directions just inside) and of no
other (child `BranchGerms.eq_or_next_eq_of_mem_closure_sector`, over `exists_far_side`), so they lie on `ω(u)` and their side colours are `a` inside and
`c` outside; the angle `arg ((p s − u)/(q − u))` is continuous (the chord to `q` stays below `1/2`, so the quotient stays off the negative axis) and
injective, so two radii give `θ₁ < θ₂` and the IVT fills `[θ₁, θ₂]` with branch points, all in `Γ` (the chart's `branches`). Then `BothKind u θ₁ θ₂` and
`noBoth` give a bad point at `u`, against H. **`exists_eleventh_of` carries `sorryAx` only through `noBoth`** (its other inputs are proved: the module's
one remaining `sorry` is `exists_far_end`, which it does not use); it lands with `noBoth`.

### 8.2 The stage-8 build and the receipt

`733729a6` under the slot: **OK — 446 of 446 batches, 5 modules rebuilt, 11 modules with warnings, every warning `declaration uses 'sorry'`, exit 0**
(`build/gate/build/20261005T013504Z-210720.log`; `data/fs131/ip/build-stage8.log`; nothing but `sorry` lines and Lake's probe line). Axioms
(`data/fs131/ip/axioms-ip2-stage8.txt`, `tools/fs131_ip_axioms.py`): **17 records on the standard three; the 3 partners (`noBoth`,
`exists_eleventh_of`, `localDense`) on `sorryAx`**. `scripts/Axioms.lean`'s FS131-KP block gains the three stage-8 children. `MapTopology` has one
`sorry` left: `exists_far_end`.

### 8.3 Where this hands off (ruling 293 (b)'s order)

Done: `unenclosed_of_rim_vertex`, `exists_outermost`, `exists_eleventh_of` (closing `exists_unenclosed_or_bad` outright and `exists_eleventh` up to
`noBoth`). **Left, in the ruled order**: BG with PATH, `exists_far_end`, `endpoint_of_far_end` (route findings § 7.4: re-select the far end as an
odd vertex; the orientation at an exit is a Jordan-type step); F-LOC/CONN/INF/ONE; `not_isHoleOf_chain`, `isHoleOf_cluster`; F-RING after BG;
`retArcs_not_abut`, `retArcs_not_interleaved`. **For the coordinator** (done-means 5): BG does not exist yet, so whether the crossing lemma's route (b)
is cheap through it is not measured; what is held now that bears on it is `exists_ball_two_tiles` (vertices of a compact disc are finitely many, by
isolation and compactness), BG's hardest finiteness. F-RING not reached, not measured.

## Stage 9 — SAVED: FS131-IP3's readback (the third implementer, from IP2's Stage 8)

*de Bruijn, the implementer (FS131-IP3), 2026-10-05. Brief: `data/fs131/briefs/FS131-IP3-planar.md` (main tree). Same branch and worktree; I append
stages from here. Read in full at launch: the brief, `plans/STANDING-RULES.md`, `LEAN.md`, `RUNNING.md` § Building and § Make the gate fail, this record
(stages 1–8), KP's plan (all six stages, §§ 3–5 among them), inventory items 277, 293, 300, 301.*

### 9.1 The brief's quotations against their sources (standing rule 3)

Checked by `grep -F` of each quotation's full text (planted absent string `ABSENT-CONTROL-STRING-xyzzy` reported `MISS`, the control):

| quotation in the brief | source | result |
|---|---|---|
| inventory item 300 (truncated at "Stages 6–8;") | `plans/FS131-close-inventory.md` (main tree) l. 2350 | verbatim |
| inventory item 301 (truncated at "BG with PATH,") | same, l. 2371 | verbatim |
| inventory item 293 (truncated at "a binder name is not part") | same, l. 2240 | verbatim |
| "Both leaves closed on iteration in well under a session's tenth each … (≈ 130" | this record § 7.3 | verbatim |
| finding 1 ("1. `exists_far_end`'s second disjunct, … the `a|c` boundary") | this record § 7.4 | verbatim |
| finding 2 ("2. At a genuine exit `q = r(φ)`, … CD's step 2") | this record § 7.4 | verbatim |
| "**Work order** (each step unblocks the next; re-price after the first two):" | KP's plan § 5.1 | verbatim |
| "**May:** add children (with spec examples; …), change imports (updating `ARCHITECTURE.md`'s" | KP's plan § 5.2 | verbatim |
| inventory item 277 (truncated at "KP's") | `plans/FS131-close-inventory.md` l. 2040 | verbatim |
| Kooshi on pricing ("Do not consider Lean formalization a cost. …") | `CLAUDE.md` § Counter-priors | verbatim |

No mismatch.

### 9.2 What I may and may not change (the brief's touches, ruling 301, ruling 293 (b), KP's plan § 5.2)

**May:** prove the `sorry`s left at `02e85433` in the files my touches name — `MapTopology`'s `exists_far_end`; in `MapGraph` outside the
`namespace HadwigerNelson.Thomassen` block: `not_isHoleOf_chain`, `isHoleOf_cluster`, `filledGraph_locallyFinite`, `_connected`, `_infinite`, `_rings`,
`_oneInf`; in `BaseWalk` `endpoint_of_far_end`, `retArcs_not_abut`, `retArcs_not_interleaved` (the last over the crossing lemma as given, carrying `sorryAx`
until FS131-IX1 merges) — adding children beside them with spec examples (BG and PATH where I choose: `MapTopology` § D, `MapGraph` outside the
`Thomassen` block, or a new module importing nothing under `Plane/PlaneTopology` beyond what `MapTopology` imports); imports (with `ARCHITECTURE.md`'s
Imports cell and `scripts/Axioms.lean`'s FS131-KP block above `=== PURCHASED ===`); `Proofs.lean`, this record, `tools/fs131_ip_*.py`, `data/fs131/ip/`,
`data/fs131/reports/FS131-IP3.md`. A later leaf of ruling 301's order may go first when cheaper, said here.

**May not:** change any statement of KP's job (plan §§ 3.2, 4.1) or any definition they use (`IsHoleOf`, `fill`, `IsOuterTile`, `filledGraph`, `IsRing`,
`TwiceApart`, `PlanarLike`, `outerDom`, `EnclosesTile`), nor any statement outside this job; no new `axiom`, no `native_decide`; nothing in
`Plane/PlaneTopology` (FS131-IX1's) or inside the `HadwigerNelson.Thomassen` block (T-GRAPH's later job); not KP's plan file; not the other `sorry`s in
`BaseWalk`/`BaseDense` (wave 5's lane, `fs131-w5`); no merge into `fs131-w5`, no taking `main`, no gate run, nothing on `main`; no file edited while a build
of it runs. A leaf that cannot be proved as written goes to Keryx at once.

### 9.3 The as-given build (`02e85433`, before any edit)

Under the slot (40 GiB, 8 cpus, `BATCH=4`): **OK — all 1753 modules already up to date, nothing built, 11 modules with warnings, every warning
`declaration uses 'sorry'`, exit 0** (`build/gate/build/20261005T014928Z-325388.log`; driver log `data/fs131/ip/build-ip3-asgiven.log`).

## Stage 10 — SAVED: `fs131-w5x` merged (the crossing lemma, held), as the brief's amendment rules

The brief's amendment (2026-10-05, inventory items 302–303; ruling 303 quoted there and checked verbatim against `plans/FS131-close-inventory.md`, main
tree, by `grep -F`): at the next saved stage, merge `fs131-w5x` into `fs131-w5p`, build, record it as its own stage.

- **Merge**: `git merge origin/fs131-w5x` (`6db4fe3d`, FS131-IX1's report) at `c0d12324` → merge commit `99b47e9f`. **No conflict**: Git's own merge kept
  both sides in `scripts/Axioms.lean` (the FS131-KP block at l. 3019 and the new FS131-IX1 block at l. 3103, both above `=== PURCHASED ===` at l. 3119)
  and in `ARCHITECTURE.md`. `Plane/PlaneTopology` now has no `sorry`: `inter_nonempty_of_interleaved` (both continua closed) and
  `inter_nonempty_of_interleaved_of_isClosed_left` (one closed) are held, with IX1's 13 children. Not edited by me.
- **Build** (the merged tree, under the slot, 40 GiB, 8 cpus, `BATCH=4`): **OK — 446 of 446 batches, 6 modules rebuilt (`PlaneTopology` 3.6 s,
  `MapTopology` 5.6 s, `BaseWalk` 1.9 s, `MapGraph` 9.4 s, `BaseDense` 1.6 s, `Proofs`), 10 modules with warnings (one fewer: `PlaneTopology`), every
  warning `declaration uses 'sorry'`, exit 0** (`build/gate/build/20261005T015706Z-359162.log`; `data/fs131/ip/build-ip3-merge-w5x.log`; grep for
  `warning|error` minus the `sorry` lines leaves only Lake's `--no-build` probe line).
- Where my order reads the crossing (`retArcs_not_interleaved`), I cite `inter_nonempty_of_interleaved` as held.

## Stage 11 — SAVED: the boundary graph BG (its handshake), and `exists_far_end`

### 11.1 Proved

- **`Plane/CurveGraph`** (new module, imports `Plane/LocalStructure`; `ARCHITECTURE.md` row added, `Proofs.lean` import added; `MapTopology` now imports it,
  the `MapTopology` row's Imports cell gains `Plane/CurveGraph` — `tools/check_architecture.py`: FAIL before that edit (real-only `Plane/CurveGraph`, the check firing), PASS after, `data/fs131/ip/check-architecture-ip3.txt`). BG is built as **the handshake for compact sets made of lines and circles**,
  not as a `SimpleGraph`: a compact `C` with a *curve star* at each point (finitely many rays leaving the point, each a continuous graph over the distance,
  pairwise disjoint, each locally a piece of a line or circle) has finitely many non-regular points (`finite_nonRegular`: off its centre a star is regular),
  and their degrees have an even sum (`even_sum_deg`). The proof cuts each vertex out by a disc of radius `ρ`; the rays' points on the circles are the
  *ports* (`∑ deg v` of them); the component of the rest through a port lies in one curve (two curves sharing three points are equal), is an arc of it
  (`IsCurve.exists_param`: a parameter interval `[a, b]`), and holds exactly two ports, its ends (`port_pair`); the pairing is a fixed-point-free
  involution (`Finset.sum_involution` in `ZMod 2`). No Jordan-type theorem, no `SimpleGraph`. A sector chart's branches are curve rays
  (`branch_locally_curve`, through the library's `curveGerm`); stars pass to components; a one-ray star is not regular.
- **`MapTopology` § D**: at a point in the closures of two distinct tiles, with two colours and no repeated colour, a chart has exactly two germs
  (`IsSectorChart.eq_two`) and the common boundary of the two tiles near it is the point and both branches (`IsSectorChart.inter_closure_two`); at a two-colour
  change point `r(θ)` of `ω(u)` one branch enters the disc and the other leaves it (`exists_inner_branch`: the clockwise germ lies in the `a`-sector, the
  counter-clockwise one in the `c`-sector, so arcs of the circles of radius `1 ∓ η` about `u` near `r(θ)` each cross a branch, and no branch meets `ω(u)` near
  `r(θ)`, whose points there carry one pseudo-colour).
- **`exists_far_end`**, statement unchanged: if `r(θ)` has three colours it is its own far end; otherwise, were every point of the component `C` of `r(θ)` in
  `cl T₁ ∩ cl T₂ ∩ B̄(u, 1)` two-coloured and off `ω(u)` but for `r(θ)`, `C` would have a curve star of two rays at each point but `r(θ)`, of one ray there
  (H gives two germs at each), so its degrees at non-regular points would sum to `1 + 2m` — against the handshake.
- **Binder renamed, type unchanged** (for Keryx, ruling 293 (a)'s reasons): `exists_far_end`'s `hF : F.Valid` is never read (the unused-variables linter
  fired), renamed `_hF`; its one caller (`exists_endpoint`) passes it positionally. **Generalization**: the far end exists for any six-coloured fragment
  covering `B̄(u, 2)` under H — validity is not needed.

### 11.2 The stage-11 build and the receipt

`29004f08` + this stage's edits, under the slot (40 GiB, 8 cpus, `BATCH=4`): **OK — 446 of 446 batches, 6 modules rebuilt (`CurveGraph` 5.3 s, `MapTopology`
6.5 s, `BaseWalk`, `MapGraph` 9.6 s, `BaseDense`, `Proofs`), 9 modules with warnings (one fewer: `MapTopology` now has no `sorry`), every warning `declaration
uses 'sorry'`, exit 0** (`build/gate/build/20261005T023343Z-612010.log`; `data/fs131/ip/build-ip3-stage11.log`; grep for `warning|error` minus the `sorry`
lines leaves only Lake's `--no-build` probe line). Axioms: `data/fs131/ip/AxiomsIP3.lean` → `data/fs131/ip/axioms-ip3-stage11.txt`, checked by
`tools/fs131_ip_axioms.py` against `data/fs131/ip/axioms-ip3-names.txt`: **35 records on the standard three, the 2 controls on `sorryAx`**; planted fault (a
`sorry` control listed as clean) → `NOT CLEAN …`, exit 1. `scripts/Axioms.lean`'s FS131-KP block gains IP3's 34 children (under "-- FS131-IP3's added
children"; `exists_far_end` was already there).

### 11.3 Re-priced after the first two leaves (BG, `exists_far_end`)

Wall clock from stage 10's commit (02:06Z) to this stage (02:44Z): about 40 minutes, about 1,770 lines (`CurveGraph` 1,199, `MapTopology` + 572), one
build. KP priced BG + PATH + `exists_far_end` at one to two sessions, IP2 at about one; BG and `exists_far_end` took about a third of this session's
context. **What made it cheap**: the arcs are lines and circles, so every regular stretch of the boundary is an interval of one curve's parameter, and the
handshake needs only "two distinct curves share at most two points" and the order of `ℝ` — no general 1-manifold theory. **Re-price of what is left**
(implementer sessions): **PATH** 0.3 (max degree two plus connectedness: the ports' pairing as a multigraph, connected because the union of the stars and arcs
reachable from a vertex is clopen; then `|E| ≥ |V| − 1`); **the strong child** of `exists_far_end` (an odd vertex) 0.3 — the handshake gives it at once once
stars exist at every point of `ω(u)` (branches along `ω(u)`, inside, outside, tangent: the D-cut at a general circle point); `retArcs_not_interleaved` 0.2
(over the crossing lemma, held: different tiles close by H and `cor3_base` — three tiles of the two pairs carry three pseudo-colours, disjoint from `u`'s,
within `1` of `u`; same tiles need PATH); `retArcs_not_abut` 0.2 over PATH; **`endpoint_of_far_end` 1** — besides the strong child it needs IP2's finding 2
(the orientation at an exit, a Jordan-type step: the crossing lemma does not give it directly — the natural crossing continua are subsets of the tiles,
which may leave the disc; a route through PATH's parametrized boundary path, where "the `a`-tile on the left" propagates along the path by continuity, is
the one I would try) and the bi–bi exclusion of a chord exactly `1`; F-LOC/CONN/INF/ONE 0.4; the adversaries 0.3; F-RING 1–2 (not measured).

### 11.4 For the coordinator (done-means 4)

- **The crossing lemma's route (b) through BG**: moot — the crossing lemma is held (stage 10). For the record: BG as built is a *parity* tool; it gives no
  separation, so route (b) would still have needed an orientation or separation step of its own. Not measured further.
- **F-RING**: not reached, not measured.

### 11.5 Leaves left (named), in ruling 301's order

`endpoint_of_far_end` (strong child, orientation step, bi–bi — § 11.3); PATH; F-LOC, F-CONN, F-INF, F-ONE; `not_isHoleOf_chain`, `isHoleOf_cluster`; F-RING;
`retArcs_not_abut`, `retArcs_not_interleaved`. All in this branch's files as before; `MapTopology` has none left.

## Stage 12 — SAVED: FS131-IP4's readback (the fourth implementer, from IP3's Stage 11)

*de Bruijn, the implementer (FS131-IP4), 2026-10-05. Brief: `data/fs131/briefs/FS131-IP4-planar.md` (main tree). Same branch and worktree; I append
stages from here. Read in full at launch: the brief, `plans/STANDING-RULES.md`, `LEAN.md`, `RUNNING.md` § Building and § Make the gate fail, this record
(stages 1–11; 6–11 closely), KP's plan §§ 3–6, inventory items 277, 300, 309, 312, 313; for `endpoint_of_far_end`, FS110-CD §§ 2.0–2.4 and § 3.0, FS110-CE
§ E3 (R1–R4).*

### 12.1 The brief's quotations against their sources (standing rule 3)

Checked by script (each `>` block's text, joined, against the source's text with its lines' indentation joined; planted absent string
`ABSENT-CONTROL-STRING-xyzzy` reported `MISS`, the control):

| quotation in the brief | source | result |
|---|---|---|
| inventory item 312 (truncated at "record") | `plans/FS131-close-inventory.md` (main tree) l. 2493 | verbatim |
| inventory item 313 (truncated at "FS131-IP4 on") | same, l. 2510 | verbatim |
| "Wall clock from stage 10's commit (02:06Z) … one" | this record § 11.3 | verbatim |
| finding 2 ("2. At a genuine exit `q = r(φ)`, … CD's step 2") | this record § 7.4 | verbatim |
| inventory item 300 (truncated at "Stages 6–8;") | `plans/FS131-close-inventory.md` l. 2350 | verbatim |
| inventory item 309 (truncated at "if T-GRAPH") | same, l. 2461 | verbatim |
| "**Work order** (each step unblocks the next; re-price after the first two):" | KP's plan § 5.1 | verbatim |
| "**May:** add children (with spec examples; …), change imports (updating `ARCHITECTURE.md`'s" | KP's plan § 5.2 | verbatim |
| inventory item 277 (truncated at "KP's") | `plans/FS131-close-inventory.md` l. 2040 | verbatim |
| Kooshi on pricing ("Do not consider Lean formalization a cost. …") | `CLAUDE.md` § Counter-priors | verbatim |

No mismatch.

### 12.2 What I may and may not change (the brief's touches, ruling 313 (b), ruling 309, KP's plan § 5.2)

**May:** prove the `sorry`s left at `7b5e8ed6` in the files my touches name — in `BaseWalk` `endpoint_of_far_end`, `retArcs_not_interleaved`,
`retArcs_not_abut` (KP's plan § 5.1's three; not the other twelve, wave 5's lane); in `MapGraph` outside the `namespace HadwigerNelson.Thomassen` block:
`not_isHoleOf_chain`, `isHoleOf_cluster`, `filledGraph_locallyFinite`, `_connected`, `_infinite`, `_rings`, `_oneInf` — adding children beside them with
spec examples (PATH and the strong child of `exists_far_end` in `MapTopology` § D or `Plane/CurveGraph`, my choice); imports (with `ARCHITECTURE.md`'s Imports
cell and `scripts/Axioms.lean`'s FS131-KP block above `=== PURCHASED ===`); `Proofs.lean`, this record, `tools/fs131_ip_*.py`, `data/fs131/ip/`,
`data/fs131/reports/FS131-IP4.md`. A later leaf of item 313 (b)'s order may go first when cheaper, said here.

**May not:** change any statement of KP's job (plan §§ 3.2, 4.1) or any definition they use (`IsHoleOf`, `fill`, `IsOuterTile`, `filledGraph`, `IsRing`,
`TwiceApart`, `PlanarLike`, `outerDom`, `EnclosesTile`, and `IsRetArc`, `IsEndpoint`, `VIn`, `BaseCtx`), nor any statement outside this job; no new
`axiom`, no `native_decide`; nothing in `Plane/PlaneTopology`, inside the `HadwigerNelson.Thomassen` block, or between `filledGraph_oneInf` and
`filledGraph_planarLike` (IT1 adds `filledGraph_finSep` there on `fs131-w5t`; not mine to prove); not KP's plan file; no merge into `fs131-w5`, no taking
`main`, no gate run, nothing on `main`; no file edited while a build of it runs. A leaf that cannot be proved as written goes to Keryx at once.

### 12.3 The as-given build (`7b5e8ed6`, before any edit)

Under the slot (40 GiB, 8 cpus, `BATCH=4`): **OK — all 1754 modules already up to date, nothing built, 9 modules with warnings, every warning
`declaration uses 'sorry'`, exit 0** (`build/gate/build/20261005T025209Z-771307.log`; driver log `data/fs131/ip/build-ip4-asgiven.log`).

## Stage 13 — SAVED: `fs131-w5t` merged (T-GRAPH, held), as the brief's amendment rules

The brief's amendment (2026-10-05, inventory items 314–315; ruling 315 (a) quoted there and checked verbatim against `plans/FS131-close-inventory.md`, main
tree, l. 2535, by script): at the next saved stage, merge `fs131-w5t` (at `5604b532`) into `fs131-w5p`, fix `MapGraph`'s module docstring line, build, record
it as its own stage. No tracked file had been edited since stage 12, so this is that stage.

- **Merge**: `git merge origin/fs131-w5t` (`5604b532`, FS131-IT1's report) at `bf27d9a4`. Two conflicts, both append-only: `ARCHITECTURE.md` (resolved to IP3's
  `MapTopology` row — Imports with `Plane/CurveGraph` — then IT1's new `Thomassen` row and IT1's amended `MapGraph` row, Imports with `Thomassen`) and
  `scripts/Axioms.lean` (both blocks kept: FS131-IX1's, then FS131-IT1's, both above `=== PURCHASED ===`). `MapGraph.lean` and `Proofs.lean` merged
  without conflict (IT1's import line, the moved block's deletion, `filledGraph_finSep` and its constructor line; one `import Proofs.HadwigerNelson.Thomassen`).
- **`MapGraph`'s module docstring**: "**Pure graph theory** (namespace `HadwigerNelson.Thomassen`, over Mathlib's `SimpleGraph`):" replaced by "**Pure
  graph theory** — not in this file: module `Thomassen` (`Proofs/HadwigerNelson/Thomassen.lean`, namespace `HadwigerNelson.Thomassen`, over Mathlib's
  `SimpleGraph`; moved there verbatim by job FS131-IT1), which this file imports and reads:" (the bullets that follow describe what it reads).
- `tools/check_architecture.py`: PASS (`data/fs131/ip/check-architecture-ip4-merge.txt`).
- **Build** (the merged tree, under the slot, 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 3 modules rebuilt (`Thomassen` 6.5 s, `MapGraph`
  6.9 s, `Proofs`), 9 modules with warnings, every warning `declaration uses 'sorry'`, exit 0** (`build/gate/build/20261005T031127Z-886054.log`;
  `data/fs131/ip/build-ip4-merge-w5t.log`; grep for `warning|error` minus the `sorry` lines leaves only Lake's `--no-build` probe line).
- F-SEP (`filledGraph_finSep`) joins my order beside F-LOC/CONN/INF/ONE.

## Stage 14 — SAVED: one-sidedness (`orient`), and both `retArcs` leaves closed — PATH not needed

### 14.1 The order, and why PATH was replaced

Item 313 (b) put PATH (each component of the `T₁|T₂` boundary in the disc is a path) first, as the shared child of `endpoint_of_far_end`'s orientation
step and of both `retArcs`. Working the orientation step (IP2's finding 2, IP3's route note) showed that what all three leaves read is not that the
component is a path but that **its one side is one class**: a continuum `C` joining two circle points, with a tile `T` on one side along all of `C`, cannot
have that tile on the counter-clockwise side at both ends. That is provable from the crossing lemma (held) with no parametrization and no Jordan-type
theorem, so I proved it first (`orient`) and took the two `retArcs` — now the cheapest leaves — before `endpoint_of_far_end` (the brief allows a later
leaf first when cheaper). PATH is not built and, as far as these three leaves go, not needed (F-RING not examined yet).

### 14.2 Proved

- **`orient_aux` / `orient`** (`MapTopology` § E, pure topology over `inter_nonempty_of_interleaved_of_isClosed_left`): `C ⊆ B̄(u, 1)` closed and
  preconnected, `T` open, `C ∩ T = ∅`, `C ⊆ cl T`, `T ∩ B(z, r)` preconnected for small `r` at every `z ∈ C`; then two distinct points `r(θ)`, `r(φ)` of `C`
  cannot both have the counter-clockwise germ of `ω(u)` in `cl T ∖ C` and the clockwise germ off `cl T`. The proof: extend `C` by each point's clockwise
  germ and a radial segment out to `ω(u, R)`, `R = 1 + η` (so the extension `C'` misses `T`); the counter-clockwise germ and a radial segment join the
  `T`-side near each point to `ω(u, R)` at angle `θ + t₀`, resp. `φ + t₀`, off `C'`; those two points are not joined off `C'` (the crossing lemma at radius
  `R`: `θ − t₀ < θ + t₀ < φ − t₀ < φ + t₀`); but `{z ∈ C : the T-side near z is joined to the first}` and its complement in `C` are both open (one-sidedness),
  so `C` would be split. Children: `inter_nonempty_of_interleaved_radius` (the crossing lemma moved by a homothety; model: two crossing diameters of the
  disc of radius `2`), `polarPt_ne_of_sub`, `ringPt_eq_polarPt`; `ArcMap.tile_side` (with no repeated colour, a tile is one sector near a point of its
  closure, the only tile of its colour there), `ArcMap.germ_side` (at a change point `a → c` the counter-clockwise germ is in `cl T₂ ∖ cl T₁`, the clockwise
  one off `cl T₂`), `ArcMap.IsSectorChart.sector_subset_tile_of_mem`, `ArcMap.TileOf.eq_colour`, `ArcMap.GermPseudo.congr_e`, `ArcMap.GermPseudo.eq_of_same`.
- **`BaseCtx.orient_pair`** (`BaseWalk`, beside the leaves): in the base's context, a closed preconnected `C ⊆ cl T₁ ∩ cl T₂ ∩ B̄(u, 1)` holds no two
  distinct change points both from `a` (clockwise) to `c` (counter-clockwise).
- **`retArcs_not_interleaved`** (statement unchanged): the closures of the two joining continua meet (the crossing lemma); if a tile of the second pair is
  neither tile of the first, the meeting point carries three tiles, so it is cubic trichromatic with three pseudo-colours, disjoint from `u`'s and within `1`
  of `u` — `cor3` puts a four-colour point in `B̄(u, 2)`, against H (inlined: `cor3_base` stands later in the file, so it is not cited); if the pairs share
  their tiles, in the same order `r(s′)` and in the swapped order `r(t′)` is a second change point `a → c` on `cl K ∪ cl K′` — `orient_pair`.
- **`retArcs_not_abut`** (statement unchanged): at the common end the germs make the second pair `(c, a)` (`GermPseudo.eq_of_same`), its tiles the first
  pair's swapped (no repeated colour), and `r(s)`, `r(t′)` are two change points `a → c` on `cl K ∪ cl K′` — `orient_pair`. **On the standard three.**
- `retArcs_nested` now rests only on these two (and `ringArc_cases`).

### 14.3 The stage-14 build and the receipt

Under the slot (40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 5 modules rebuilt (`MapTopology` 12 s, `BaseWalk` 2.6 s, `MapGraph`, `BaseDense`,
`Proofs`), 9 modules with warnings, every warning `declaration uses 'sorry'`; `MapTopology` built with no warning; exit 0**
(`build/gate/build/20261005T032249Z-941152.log`; `data/fs131/ip/build-ip4-s14a.log`). Axioms: `data/fs131/ip/AxiomsIP4.lean` →
`data/fs131/ip/axioms-ip4-stage14.txt`, checked by `tools/fs131_ip_axioms.py` against `data/fs131/ip/axioms-ip4-names.txt`: **13 records on the standard
three (the 12 children and `retArcs_not_abut`); the 4 controls on `sorryAx`: `retArcs_not_interleaved` and `retArcs_nested` (through `cor3`, wave 5's leaf,
printed beside them as the source), `endpoint_of_far_end` (open), `cor3`**; planted fault (`retArcs_not_interleaved` listed as clean) → `NOT CLEAN …`, exit 1.
`scripts/Axioms.lean`'s FS131-KP block gains the 12 children (under "-- FS131-IP4's added children").

### 14.4 Re-priced after the first two leaves

Wall clock from stage 12's commit (≈ 02:55Z) to this stage (03:41Z), with stage 13's merge build inside it: about 45 minutes, about 650 lines, one build.
**Re-price of what is left** (implementer sessions): `endpoint_of_far_end` 0.5 (its local case list at circle points is written, `circ_local` iteration-green
but for its last case split; then the handshake, the distance bound and the assembly); F-LOC/CONN/INF/ONE and F-SEP 0.5; the adversaries 0.2; F-RING
unmeasured (whether `orient`'s class argument replaces boundary walks there is the first thing to look at).

## Stage 15 — SAVED: `endpoint_of_far_end` proved — the far end re-selected as an odd vertex, its orientation by `orient_pair`

### 15.1 Proved

- **`endpoint_of_far_end`** (statement unchanged; it now closes `exists_endpoint`, FS110-CD Lemma E with CE's R1–R4). By contradiction, with no endpoint:
  every point of `K = cl T₁ ∩ cl T₂ ∩ B̄(u, 1)` carries `a`, `c` and colours of `u` (`colours_sub`: a third colour off `u`'s is `cor3`'s configuration);
  a third tile at a point of `K` misses `B̄(u, 1)` (else the point is an endpoint — inside, or V-in); the points of `ω(u)` in `cl T₁ ∩ cl T₂` are finitely
  many (`pseudo_finite`, used by statement), so isolated. On the component `C` of `r(θ)` in `K` every point has a curve star: two rays inside the disc
  (`inner_star`), and at a point of `ω(u)` a star of `d ≤ 2` rays with `d = 1` exactly when the two germs of `ω(u)` lie in different tiles' closures
  (`circ_local`). At `r(θ)` the germs differ (`germ_side`, `germ_side_cw`), so `d = 1`; the handshake (`exists_finset_even_sum_deg`, IP3's BG) gives a
  second odd vertex `q′`, on `ω(u)`, a change point between `a` and `c` (IP2's finding 1: the far end re-selected as an odd vertex, so spikes and V-out
  touches never arise). Its germs' pseudo-colours (`germPseudo_of_side`): if `q′` runs `a → c` like `r(θ)`, `orient_pair` refutes it; so it runs `c → a`.
  `|r(θ) − q′| ≤ 1` (one `a`-tile's closure), and `= 1` is FS112-N3-PAIRS (ii) (`pair_ii`) with `noBoth` (the bi–bi exclusion), so the angle is below `60°`
  (`dist_ringPt_ringPt_cmp_one`), and `(r(θ), q′)` with the continuum `C` is a returning pair whose arc holds `r(θ)` — against `hout`. The given far end `q`
  is used only for the shortcut "three colours inside the disc is an endpoint at once" (its other cases need no `q`).
- **`circ_local`** (`MapTopology`, the D-cut at a general circle point; FS110-CD § 2.3's case list): at `r(φ)` in the closures of an `a`-tile and a `c`-tile,
  no repeated colour, at most three colours, every other tile there off `B̄(u, 1)`, no other point of `ω(u) ∩ cl T₁ ∩ cl T₂` nearby: the common boundary in
  the closed disc is a star of `d ≤ 2` rays, and `d = 1` iff the germs lie in different closures. Two germs (two colours) or three (three colours, via the
  shared germs of `shared_germ3`); each branch strictly inside or outside (`branch_side`: `‖b(s) − u‖² − 1 = s(s + 2Re(conj(z − u) e(β + arcsin(κs/2))))`,
  exactly `s²(1 − κ Im P)` when tangent); a germ of `ω(u)` lies in one closure (`subset_or_subset_of_closed`); "same germs" is refuted at `d = 1` by
  `side_contra` (a tile's one sector near `z`, missing `ω(u)`, cannot reach both sides) and forced at `d ∈ {0, 2}` by a thin annular sector inside or outside
  (`exists_annular_in`, `exists_annular_out`). Children: `hasCurveStar_zero`, `exists_Ico_ringPt`, `disjoint_closedBall_of_isOpen`,
  `IsSectorChart.tile_inter_ball_eq`, `IsSectorChart.mem_closure_some_sector`, `coloursAt_subset_near`; in `BaseWalk` `BaseCtx.colours_sub`.
- **Generalization** (for the record): `circ_local` and `orient` are pure statements about an `ArcMap` with any number of colours; nothing of the base
  enters them.

### 15.2 The stage-15 build and the receipt

Under the slot (40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 5 modules rebuilt (`MapTopology` 13 s, `BaseWalk` 2.0 s, `MapGraph`, `BaseDense`,
`Proofs`), 9 modules with warnings, every warning `declaration uses 'sorry'`; `MapTopology` built with no warning; `BaseWalk`'s 12 `sorry` declarations are
all wave 5's lane's (`reduce`, `select`, `pseudo_*`, `exists_pseudoCircle`, `retArc_partner`, `retArcs_finite`, `vin_antipodal`, `eleventh_antipodal`,
`l3_base`, `hex_base`); exit 0** (`build/gate/build/20261005T040047Z-1228628.log`; `data/fs131/ip/build-ip4-s15.log`; grep for `warning|error` minus the
`sorry` lines leaves only Lake's `--no-build` probe line). `tools/check_architecture.py`: PASS (`data/fs131/ip/check-architecture-ip4-s15.txt`; the
`MapTopology` and `BaseWalk` rows' descriptions gain IP4's sentences, no Imports cell changed).

Axioms: `data/fs131/ip/AxiomsIP4b.lean` → `data/fs131/ip/axioms-ip4-stage15.txt`, checked by `tools/fs131_ip_axioms.py` against
`data/fs131/ip/axioms-ip4b-names.txt`: **17 records on the standard three (the 16 new `MapTopology` children and `retArcs_not_abut`); 8 controls on
`sorryAx`: `colours_sub` (through `cor3`), `endpoint_of_far_end` and `exists_endpoint` (through `pseudo_finite`, `pair_ii`, `noBoth`, `cor3`, all used by
statement), `retArcs_nested`, and the four sources themselves printed beside them**; planted fault (`endpoint_of_far_end` listed as clean) → `NOT CLEAN …`,
exit 1. `scripts/Axioms.lean`'s FS131-KP block gains the 17 children. So **every `sorryAx` left under the three leaves comes from wave 4's or wave 5's own
leaves used by statement** (`pseudo_finite`, `pair_ii`, `noBoth`, `cor3`); the planar chain adds none.

### 15.3 Leaves left (named), and for the coordinator (done-means 4)

Left in this branch's files: **F-LOC, F-CONN, F-INF, F-ONE, F-SEP** (`MapGraph`), **`not_isHoleOf_chain`, `isHoleOf_cluster`**, **F-RING**. Worked on paper,
for the successor (not formalized):
- **F-INF and F-CONN** read one lemma: *every point of the plane lies in the closure of an outer tile*. `exists_outermost` (E4-OUTERMOST steps 1–2, held)
  gives, at any point, a tile there enclosed by no tile; a tile inside a hole `Hc` of `T′` is enclosed by `T′` (its component in `(cl T′)ᶜ` lies in the
  separated, bounded `Hc`), so that tile is outer. Then F-INF: outer fills are bounded (`fill T ⊆ (outerDom T)ᶜ ⊆ B̄(p, 1)`: a hole misses the unbounded
  component, which is connected and so lies on one side of the separation), and they cover the plane. F-CONN: `mem_of_touch_closed` on `ℂ` with the outer
  tiles' closures.
- **F-LOC**: `fill x ⊆ B̄(p, 1)` (as above), so a neighbour's filled closure meets `B̄(p, 1)` and its tile meets `B̄(p, 3)`; `finite_tiles_closure_inter`.
- **The two adversaries** both need `(cl T)ᶜ ⊆ (B̄(0,1))ᶜ ∪ B(c₁, ¼) ∪ B(c₂, ¼)` for `T = B(0, 1) ∖ (B̄(c₁, ¼) ∪ B̄(c₂, ¼))` (every other point is a limit of
  `T`: outward along the radius from a small disc's centre, or `1 − δ + i√δ` at the touching point `1`); then a separated part of `(cl T)ᶜ` is a union of
  those three connected open pieces, and the touching points decide.
- **F-RING: not reached, not measured** (done-means 4 asks for a measurement from its first child; I have none to give). One observation for the
  coordinator's call: the class argument of `orient` (a tile's side of a separating continuum is one class off it, by the crossing lemma) is the tool
  F-RING's separation clause ("`M̂ − x − y` is connected unless `y` appears twice apart") most plausibly needs; boundary walks may not.

### 15.4 Measured cost

Wall clock from stage 14's commit (03:41Z) to this stage (04:12Z): about 30 minutes of writing plus one 9-minute build, about 1,050 lines (`MapTopology` + ≈ 820, `BaseWalk` + ≈ 230), one build.
`circ_local` (≈ 520 lines) was most of it; `endpoint_of_far_end`'s assembly over it took one iteration.

### 15.5 Hand-back

By the session's token counter I am at about 660k, past the brief's 500k line (I noticed at this stage; the line was crossed inside `circ_local`'s
iterations, with no stage then saveable). I hand back here, at a saved stage, with the leaves of § 15.3 named. Slip, mine: the line passed unwatched.

## Stage 16 — SAVED: FS131-IP5's readback (the fifth implementer, from IP4's Stage 15)

*de Bruijn, the implementer (FS131-IP5), 2026-10-05. Brief: `data/fs131/briefs/FS131-IP5-planar.md` (main tree). Same branch and worktree; I append
stages from here. Read in full at launch: the brief, `plans/STANDING-RULES.md`, `LEAN.md`, `RUNNING.md` § Building and § Make the gate fail, this record
(stages 12–15 closely), KP's plan §§ 2–6, inventory items 277, 309, 324, 325.*

### 16.1 The brief's quotations against their sources (standing rule 3)

Checked by script (each `>` block's text, whitespace-normalized, searched in the main tree's `plans/FS131-close-inventory.md` and `CLAUDE.md` and this
branch's record and KP's plan; a planted control string, fresh per run, reported `MISS` — a first control string, `ABSENT-CONTROL-STRING-xyzzy`, reported
`OK` because earlier stages of this record quote it, so it was replaced: a control already present is no control):

| quotation in the brief | source | result |
|---|---|---|
| Kooshi on pricing ("Do not consider Lean formalization a cost. …") | `CLAUDE.md` § Counter-priors | verbatim |
| inventory item 324 (truncated at "named it") | `plans/FS131-close-inventory.md` l. 2646 | verbatim |
| inventory item 325 (truncated at "Queue for") | same, l. 2672 | verbatim |
| "F-INF and F-CONN read one lemma: … (E4-OUTERMOST steps 1–2, held)" | this record § 15.3 | verbatim |
| "F-LOC: `fill x ⊆ B̄(p, 1)` … `finite_tiles_closure_inter`." | this record § 15.3 | verbatim |
| "The two adversaries both need … (every other point is a limit of" | this record § 15.3 | verbatim |
| "F-RING: not reached, not measured (done-means 4 asks for a measurement from its first child; I have none to give). One observation for the" | this record § 15.3 | verbatim |
| inventory item 309 (truncated at "if T-GRAPH") | `plans/FS131-close-inventory.md` l. 2461 | verbatim |
| inventory item 277 (truncated at "KP's") | same, l. 2040 | verbatim |
| "**Work order** (each step unblocks the next; re-price after the first two):" | KP's plan § 5.1 | verbatim |
| "**May:** add children (with spec examples; …), change imports (updating `ARCHITECTURE.md`'s" | KP's plan § 5.2 | verbatim |

No mismatch. The eight `sorry` declarations the brief names are exactly `MapGraph`'s at `aa753bb1` (`grep -n sorry`: lines 104, 113, 128, 133, 137, 148,
155, 163 — `not_isHoleOf_chain`, `isHoleOf_cluster`, F-LOC, F-CONN, F-INF, F-RING, F-ONE, F-SEP).

### 16.2 What I may and may not change (the brief's touches, KP's plan § 5.2, rulings 277 and 309)

**May:** prove the eight `sorry`s of `MapGraph` named above, adding children beside them with spec examples (shared ones in `MapTopology` or
`Plane/CurveGraph`); fix the three `BaseWalk` docstrings item 324 names (docstrings only — no statement, no proof); imports (with `ARCHITECTURE.md`'s
Imports cell and `scripts/Axioms.lean`'s FS131-KP block above `=== PURCHASED ===`); `Proofs.lean`, this record, `tools/fs131_ip_*.py`, `data/fs131/ip/`,
`data/fs131/reports/FS131-IP5.md`. A later leaf of item 325's order may go first when cheaper, said here.

**May not:** change any statement of KP's job (plan §§ 3.2, 4.1) or any definition they use (`IsHoleOf`, `fill`, `IsOuterTile`, `filledGraph`,
`mapGraph`, `outerDom`, `EnclosesTile`, and in `Thomassen` `IsRing`, `TwiceApart`, `offTwo`, `twoSepInterior`, `PlanarLike`), nor any statement outside
this job; no new `axiom`, no `native_decide`; nothing in `Plane/PlaneTopology`, `Thomassen` or `Plane/ValidMap/BaseDense`; not KP's plan file; no merge
into `fs131-w5`, no taking `main`, no gate run, nothing on `main`; no file edited while a build of it runs. A leaf that cannot be proved as written goes to
Keryx at once.

### 16.3 The as-given build (`aa753bb1`, before any edit)

Under the slot (40 GiB, 8 cpus, `BATCH=4`): **OK — all 1755 modules already up to date, nothing built, 9 modules with warnings, every warning
`declaration uses 'sorry'`, exit 0** (`build/gate/build/20261005T042332Z-1339005.log`; driver log `data/fs131/ip/build-ip5-asgiven.log`).

### 16.4 The three `BaseWalk` docstrings (item 324's correction), edited after the as-given build

`retArcs_not_interleaved` and `retArcs_not_abut` now describe the route taken (the crossing lemma, `cor3` for a third tile, `orient_pair` when the pairs
share their tiles; PATH not needed), `endpoint_of_far_end` the proof done (stars by `inner_star` and `circ_local`, the handshake's second odd vertex,
`orient_pair`, `pair_ii` with `noBoth` for the `60°` bound) in place of the "owed before proving" reading. Docstrings only: the diff touches no statement
or proof line. They are built with stage 17's first build.

## Stage 17 — SAVED: F-INF, F-CONN and F-LOC proved, over one lemma — every tile lies in an outer tile's fill

### 17.1 Proved (statements unchanged)

- **`exists_outer_fill`** (the shared lemma; IP4's route sharpened): every tile `S` of a valid plane map lies in the fill of an outer tile. IP4's sketch
  ("`exists_outermost` gives, at any point, a tile there enclosed by no tile") does not reach the fill: a point can lie in a bounded complementary
  component of a tile that is no hole (FS131-I5b's chain), so being in the outermost tile's hull does not put it in that tile's fill. The proof used
  instead: among the tiles whose fill holds `S` (finitely many — their closures meet `B̄(s, 1)`), take one with a maximal hull; if it lay in a hole of
  another tile, that hole would hold its whole fill (`fill_subset_hole`) and that tile would enclose it, strictly growing the hull
  (`not_encloses_of_hull_eq`). Child **`hole_subset_hole`** (nested holes): if `T₁` lies in a hole `Hc₂` of `T₂`, every hole of `T₁` lies in `Hc₂` —
  `T₂` is not in a hole of `T₁` (else each encloses the other and their hulls coincide), so the holes of `T₁` miss `cl T₂`, and each component of
  such a hole is on the side of `Hc₂`'s separation that its frontier point in `cl T₁ ⊆ cl Hc₂` dictates.
- **`filledGraph_infinite`** (F-INF): finitely many outer tiles would have their filled closures in one disc (`closure_fill_subset_closedBall`: a filled
  closure lies within `1` of each point of the tile's closure, through the hull), but a point outside it is in a tile's closure, inside an outer fill.
- **`filledGraph_connected`** (F-CONN): `mem_of_touch_closed` on `U = ℂ` with `P` the tiles inside the fill of an outer tile joined to a fixed one;
  a tile touching a member lies in some outer fill (`exists_outer_fill`), and two outer tiles whose filled closures meet are joined
  (`filledGraph_reachable_of_inter`).
- **`filledGraph_locallyFinite`** (F-LOC): a neighbour's filled closure meets `B̄(p, 1)` (`p` in the tile), so its tile's closure meets `B̄(p, 2)`;
  `finite_tiles_closure_inter`.
- Children (`MapGraph`, before the leaves): `IsHoleOf.isOpen`, `IsHoleOf.isOpen_diff`, `IsHoleOf.connectedComponentIn_subset`,
  `IsHoleOf.subset_compl_outerDom`, `fill_subset_compl_outerDom`, `subset_fill`, `closure_fill_subset_closedBall`, `encloses_of_subset_hole`,
  `hole_subset_hole`, `fill_subset_hole`, `exists_outer_fill`, `filledGraph_reachable_of_inter`, `filledGraph_reachable_of_subset`.

### 17.2 The stage-17 build and the receipt

Under the slot (40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 4 modules rebuilt (`BaseWalk` 2.0 s — the three docstrings of § 16.4 —,
`MapGraph` 7.1 s, `BaseDense`, `Proofs`), 9 modules with warnings, every warning `declaration uses 'sorry'`; `MapGraph`'s five `sorry` declarations
are `not_isHoleOf_chain`, `isHoleOf_cluster`, `filledGraph_rings`, `filledGraph_oneInf`, `filledGraph_finSep`; exit 0**
(`build/gate/build/20261005T043543Z-1369788.log`; `data/fs131/ip/build-ip5-s17.log`; grep for `warning|error` minus the `sorry` lines leaves only Lake's
`--no-build` probe lines).

Axioms: `data/fs131/ip/AxiomsIP5a.lean` (importing `MapGraph` alone) → `data/fs131/ip/axioms-ip5-stage17.txt`, checked by `tools/fs131_ip_axioms.py`
against `data/fs131/ip/axioms-ip5a-names.txt`: **16 records on the standard three (the 13 children and F-LOC, F-CONN, F-INF); 5 controls on `sorryAx`
(`filledGraph_oneInf`, `_rings`, `_finSep`, `filledGraph_planarLike`, `cvb_thom_reduced`)**; planted fault (`filledGraph_oneInf` listed as clean) →
`NOT CLEAN …`, exit 1. `scripts/Axioms.lean`'s FS131-KP block gains the 13 children (under "-- FS131-IP5's added children").

### 17.3 Re-priced after the first two leaves

Wall clock from stage 16's commit (04:28Z) to this stage (04:45Z): about 17 minutes, about 200 lines, one build (8.5 minutes of it the build's walk
over 447 batches). F-LOC came free with the shared lemma. **Re-price of what is left** (implementer sessions): F-ONE 0.1 (drafted: the far side is one
class); F-SEP 0.3 — it needs, beside F-ONE's far-side lemma, that a pair whose interior holds a tile has meeting filled closures, which is F-RING's
non-neighbour clause: `M̂ − x − y` is connected when `cl x̂ ∩ cl ŷ = ∅`. That clause is Janiszewski's theorem for holes (two disjoint continua
without holes have none together), drafted over unicoherence (§ 18); the adversaries 0.2; F-RING's ring list (the boundary walk) unmeasured.
