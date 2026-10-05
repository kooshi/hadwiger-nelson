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
