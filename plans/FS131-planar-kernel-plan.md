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
