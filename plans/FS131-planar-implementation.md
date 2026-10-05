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
