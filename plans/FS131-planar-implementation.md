# FS131-IP1 — the planar infrastructure, implemented

*de Bruijn, the implementer (FS131-IP1), 2026-10-04/05. Brief: `data/fs131/briefs/FS131-IP1-planar.md` (main tree). Branch `fs131-w5p`, worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p`. The plan this record executes: `plans/FS131-planar-kernel-plan.md` (FS131-KP), § 5.1's work order.*

## Theorems this phase proved

(Filled stage by stage; each line: declaration, grade, axioms.)

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
