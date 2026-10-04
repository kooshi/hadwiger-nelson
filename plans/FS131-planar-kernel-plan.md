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
