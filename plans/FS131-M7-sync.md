# FS131-M7 — wave 5's lines joined on `fs131-w5c`; the arc step proved from the bends

*The record of job FS131-M7 (de Bruijn, the implementer; brief `data/fs131/briefs/FS131-M7-join.md` on `main`). Branch `fs131-w5c`,
worktree `.claude/worktrees/fs131-w5c`. Stages are headed "Stage n — SAVED (FS131-M7)"; working files are under `data/fs131/m7/`.*

## Theorems this phase proved

*(filled at the stage that proves them; none yet)*

## Stage 1 — SAVED (FS131-M7): the readback, the as-given build, what I may change

### 1.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_ir_quotes.py` (FS131-IR1's checker, run unchanged) on the brief as launched (`main`'s
`data/fs131/briefs/FS131-M7-join.md`): **12 quotations, 0 failures** (`data/fs131/m7/quotes.txt`); `--self-test` (one letter planted in
the first quotation): **fired**, 1 failure (`data/fs131/m7/quotes-selftest.txt`). No mismatch. The refs the brief names:
`origin/fs131-w5y` is `3f8270c0` (as said); `dd8c2c33` is an ancestor of `origin/fs131-w5a` (now `79efdf00`, moving) and is the commit
`fs131-w5z` was cut from.

### 1.2 Read for this job

In full: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` §§ Building, Make the gate fail, and watch it fail; inventory
items 443–450 (`main`'s `plans/FS131-close-inventory.md`); FS131-IA2's report whole (`fs131-w5y`, `data/fs131/reports/FS131-IA2.md`)
and its record's Stages 6–8 (`plans/FS131-arcstep-implementation.md`); FS131-IR3's Stages 22–23 in this branch's
`plans/FS131-limit-kernel-plan.md`; the planner's § 3.0 and § 3.1 (`fs131-w5a`, `plans/FS131-bendaway-kernel-plan.md`).

### 1.3 The as-given build (`9f28e42a`)

`/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree,
before any edit: **OK — all 1785 modules already up to date, nothing built, 4 modules with warnings**, exit 0, 2 s
(`build/gate/build/20261006T062257Z-1652532.log`; driver log `data/fs131/m7/build-stage1-asgiven.log`). The 6 distinct warnings are all
`declaration uses 'sorry'`: `Procedure` 1 (l. 2748, `exists_arcStep`); this line's stale copies of the density half — `BaseDense` 3
(l. 356, 430, 480), `BendCollar` 1 (l. 31), `HexRing` 1 (l. 2142). As the brief expected.

### 1.4 What I may and may not change (the brief's `touches`, § Done means, § What is yours to decide)

**May**: the two merges' files (`origin/fs131-w5y` at `3f8270c0`, then the commit `dd8c2c33`), the two named conflicts resolved
keep-both (`scripts/Axioms.lean`; `plans/FS131-I5-implementation.md`, stages in number order); in `Plane/ValidMap/ArcStep.lean` the
deletion of its copy of `LocalStep.of_cutArcs` with its proof (inventory 448 (a)) and the one edit to `ArcBend.of_away`'s hypothesis
`hM` and the place its proof read the old last clause (448 (b)); in `Plane/ValidMap/Procedure.lean` the import of `ArcStep`,
`IsMaxRingArc.meet`, `exists_arcStep`'s docstring and proof, and the module docstring's lines about the arc step; `Proofs.lean`,
`ARCHITECTURE.md`; a block "FS131-M7" in `scripts/Axioms.lean` above `=== PURCHASED ===`; this record; `tools/fs131_m7_*.py`;
`data/fs131/m7/`; the report. The smallest change to FS131-IA2's text that makes it compile in the joined tree, the diff recorded.

**May not**: change the statement of any proved declaration (`exists_arcStep`'s statement and its caller's lines are already the ruled
ones — untouched); edit the outward bend's six modules (`BendAway`, `LensOut`, `CollarMapOut`, `R2Cap`, `HornChart`, `BendGap`) or
`BendStep.lean` beyond what the merges bring (FS131-BA1 and FS131-BA2 are proving their children on `fs131-w5a` and `fs131-w5z`); add
an `axiom` or a `native_decide`; run the gate; touch `main`; begin the remedy pass; edit a file while a build of it runs; start an
agent. A conflict beyond the two named, a name both sides declare other than `LocalStep.of_cutArcs`, a line of the compiled text that
fails for a reason I cannot see, or a statement the join shows false is a message to the coordinator.

## Stage 1 — SAVED (FS131-M7)
