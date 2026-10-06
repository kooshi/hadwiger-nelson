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

## Stage 2 — SAVED (FS131-M7): `origin/fs131-w5y` (`3f8270c0`) merged — the arc step's line

### 2.1 The tools (this job's copies; standing rule 7 bars editing another job's)

- `tools/fs131_m7_merge_check.py BASE OURS THEIRS [--rev MERGED] [--self-test]` — every file of the merged tree is the side it should
  be, byte for byte; a file changed by both sides is allowed only in KEEP_BOTH (`Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`,
  `plans/FS131-I5-implementation.md`), where the merged lines must be ours + theirs − base as a multiset, no import, axioms record or
  table row twice. A copy of FS131-IA1's with the refs required (no default: this job checks two merges with different bases) and
  plants that choose their targets from the three trees and raise if none exists.
- `tools/fs131_m7_dupes.py` — FS131-IA1's duplicate check with its parsing core copied byte for byte, a `--plant` that picks its
  target from the refs given, and a `--whole <dir> <fork>` mode for the joined tree (names declared twice; statements under two names).
- Written, not yet run (their inputs exist only after the second merge): `tools/fs131_m7_stmt_check.py`,
  `tools/fs131_m7_away_clause.py`, `tools/fs131_m7_place.py`. Each has a self-test; none is evidence of anything until run.

### 2.2 The merge

`git merge --no-commit --no-ff origin/fs131-w5y`, base `ebb0b292`, ours `002b911f` (this job's tools commit), theirs `3f8270c0`.
Before it, the pairwise duplicate check (`fs131_m7_dupes.py HEAD origin/fs131-w5y ebb0b292`): **0 NAME or STATEMENT pairs** — 3 own
files, 59 own declarations against 10,359 names (`data/fs131/m7/dupes-merge1-pre.txt`; 10 CONCL lines, informational: the vertex
step's cases share `exists_vertexStep`'s conclusion); its plant, on `IsRingArc.coloursAt_openArc` (new in `ArcStep`): **fired**,
exactly the three planted pairs, the docstring line not reported (`dupes-merge1-plant.txt`).

**Two conflicts, the two the brief named, both keep-both** (`data/fs131/m7/merge1-git.txt`):
- `scripts/Axioms.lean` — this line's block (FS131-IR2, IR3; 79 lines), then the other side's (FS131-CC1 … FS131-IA2; 123 lines), one
  blank line between;
- `plans/FS131-I5-implementation.md` — stages in number order: the other side's 56–59, then this line's 60–62.
`ARCHITECTURE.md` merged by itself.

**The check** (`fs131_m7_merge_check.py ebb0b292 002b911f 3f8270c0`, on the index, the working tree equal to it): **16,070 files, 3
changed by both sides, 0 failures, PASS** (`merge1-check.txt`); `--self-test`: **five plants fired** — a byte of `ArcStep.lean`
(theirs only), a line added to `HornShadow.lean` (ours only), `Proofs.lean`'s `RadialPush` import dropped, a doubled axioms record, a
file changed by both outside KEEP_BOTH — and the unplanted run passed (`merge1-check-selftest.txt`). **The index held the merge and
nothing else**: 189 staged paths, the 189 paths the other side changed since the base; no unstaged change; no unmerged path;
`MERGE_HEAD` = `3f8270c0`; my three check outputs untracked. Committed as a merge (a merge cannot be committed by path): **`b7a1bd08`**,
parents `002b911f` and `3f8270c0`; the same check on the commit (`--rev HEAD`): PASS (`merge1-check-rev.txt`). Pushed.

### 2.3 The build of the merged tree (`b7a1bd08`)

`slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — 457 of 457 batches, 16 modules rebuilt, 2 with
warnings, 10 min 20 s, exit 0** (the build's own status, written by the launching command before any pipe; saved log
`build/gate/build/20261006T063228Z-1716745.log`, which ends "Build completed successfully (5797 jobs)"; driver log
`data/fs131/m7/build-stage2-merge1.log`). 1790 modules, five more than as given: the five imports the merge added to `Proofs.lean`
(`RadialPush`, `Pushforward`, `CollarMap`, `BendStep`, `ArcStep`).

- **Warnings: 12 lines, all `declaration uses 'sorry'`, at 3 distinct sites** — `BendStep` l. 285 (`CollarFit.map_hornCount_le`) and
  l. 307 (`bend_away_part`, FS131-IA1's skeleton: the second merge replaces it), each printed 3 times; `Procedure` l. 2748
  (`exists_arcStep`), printed 6 times. No warning of another kind. This line's five stale `sorry` (`BaseDense` 3, `BendCollar` 1,
  `HexRing` 1) are gone with the copies that held them.
- **The log holds three lines reading `error:`; none is a Lean error.** They are lines 3, 5, 7, inside "### up-to-date check, lake
  build --no-build over 1790 modules: exit 3": `scripts/build.sh`'s pre-check reporting `Pushforward`, `RadialPush` and `HexRing`
  out of date, after which the walk built them.
- **Of the 16 rebuilt, nine are modules the merge changed** (`ArcStep`, `BaseDense`, `BaseWalk`, `BendCollar`, `BendStep`,
  `CollarMap`, `HexRing`, `Pushforward`, `RadialPush`), `Proofs`, and **six are byte-identical across the merge**: `MapTopology`,
  `MapGraph`, `Limit`, `Dense`, `Procedure`, `Terminal`. The cause, read off the import graph (each one's transitive imports
  intersected with the nine): **`HexRing` alone** — `MapTopology` imports it, and the other five reach it. So `HexRing` is not a
  leaf beside `Procedure`: it is upstream of `Limit`, `Procedure` and `Terminal`, and this merge replaced it under all three. They
  elaborate against the new one.

### 2.4 What the merge did to `HexRing`: `bv_l3` changed files, its statement did not

`git diff 002b911f b7a1bd08 -- …/HexRing.lean`, read whole (18 lines): the theorem `bv_l3` — `sorry` on this line, the one `HexRing`
warning of the as-given build — leaves `HexRing`, and two lines of prose say so; nothing else. In the merged tree it is declared once,
in `BaseWalk` (l. 4001; FS131-I5q's move under ruling 370 (a)), in the same namespace, so its qualified name
`HadwigerNelson.Plane.ArcMap.bv_l3` is unchanged; **its statement before and after is identical** (whitespace folded; compared by
script, this stage). No other declaration of `HexRing` changed, so nothing `Procedure` or `Terminal` reads changed its statement.
Two things this fixes for the later stages: (1) FS131-IR3's standard-three receipts for `exists_vertexStep` and `stuckRun_ne_univ`
were taken against the old `HexRing` and are **re-taken at the final check, not copied**; (2) a declaration that changes files is
invisible to a file-by-file merge check and to a pairwise duplicate check keyed on the files one side changed — the whole-tree mode
(`fs131_m7_dupes.py --whole`) is the instrument, and `bv_l3` must stand exactly once there.

### 2.5 Slips of mine in this stage, and two readings I corrected

- **A waiter armed on a command-line pattern** (`RUNNING.md` § Make the gate fail: never let a pattern that can match the matching
  shell decide anything). While the build ran I started a background loop `until ! kill -0 $(pgrep -f -o "scripts/build.sh" …)`,
  described only as "placeholder". Two other implementers were building in other worktrees, so the pattern could have followed
  another job's build, or its own shell. It sent no signal (`kill -0` tests existence), and it decided nothing: I stopped it by its
  task id within the minute, confirmed by effect that my build was still advancing (the log's last timestamp equal to the clock; my
  slot's wrapper alive by PID), and waited on that PID instead. It was also redundant — the build's own background task reports
  its exit.
- **A count I mislabelled**: my first table of warnings printed "6 and 6" under "distinct sorry warnings by file"; those were
  repeated lines, not sites. The sites are 3 (above), and the build's own digest ("2 modules with warnings") agrees.
- **A cause I guessed wrong**: I first took the six unchanged rebuilt modules to mean the other side had changed `MapTopology` or
  `Limit`. The diff says it changed neither; the import graph gives `HexRing`. Recorded because the same log will be read again.
- **A third conflict foreseen for the second merge**, beyond the brief's two: `ARCHITECTURE.md` (the trial `git merge-tree HEAD
  dd8c2c33`, `data/fs131/m7/merge2-trial.txt`; `plans/FS131-I5-implementation.md` does not conflict in this order). Sent to the
  coordinator by message, with the resolution I am taking; it is Stage 3's.

## Stage 2 — SAVED (FS131-M7)

## Stage 3 — SAVED (FS131-M7): `dd8c2c33` merged — the outward bend's skeleton; a commit that does not build until Stage 4

### 3.1 Before the merge

The pinned commit `dd8c2c33`, not `origin/fs131-w5a`'s moving tip; base `78eba0b4` (the first merge moved it there), ours `26a6446c`.
The tree free of builds first: no slot of mine in the ledger, no `lean` process with this worktree as its working directory (found
by `/proc/<pid>/cwd`, not by a command line).

**The pairwise duplicate check** (`fs131_m7_dupes.py HEAD dd8c2c33 78eba0b4`; expectation written before the run: one NAME pair, the
named one, and nothing else): **exactly one pair** — `NAME HadwigerNelson.Plane.ArcMap.LocalStep.of_cutArcs`, this side's
`ArcStep.lean:584` against the skeleton's `BendAway.lean:97`; no STATEMENT pair, no STATEMENT-NORM pair; 4 own files, 92 own
declarations (59 + `ArcStep`'s 33) against 10,382 names (`data/fs131/m7/dupes-merge2-pre.txt`, exit 1 as it must be). **No name is
declared by both sides other than the one the brief names.** Its plant at these refs, on `R2Subdiv.lt` (new in `BendAway`): **fired**,
the three planted pairs beyond the one real pair, the docstring line not reported (`dupes-merge2-plant.txt`). Two of its
informational conclusion-matches are new and go to the remedy pass's list (Stage 6): `IsRingArc.degree_openArc` (`ArcStep`) with
`CollarFit.degree_openArc` (`BendCollar`) — the collar-free form and its special case; `CollarFit.map_localStep` (`ArcStep`) with
`CollarFitOut.map_localStep` (`BendGap`) — the two bends' mirrored lemmas, two theorems over two structures.

### 3.2 The merge: two conflicts, one of them not the brief's

`git merge --no-commit --no-ff dd8c2c33` (`data/fs131/m7/merge2-git.txt`): conflicts in `scripts/Axioms.lean` (named) and
**`ARCHITECTURE.md` (not named)**; `Proofs.lean` merged by itself; `plans/FS131-I5-implementation.md` does not conflict in this order —
the first merge settled it. The brief's trial merged each ref against this branch's tip separately; in sequence the base moves and the
conflict moves with it. Sent to the coordinator by message before the merge, with the resolution I was taking. **No reply had come
when I went on, and none is recorded here as agreement**: the resolution is mechanical and checked (3.3; `check_architecture` at
Stage 4), and it is held for the coordinator in the report.

- **`ARCHITECTURE.md`** — adjacency only, in the module table: after `BendStep`'s row this side had added `ArcStep`'s; at the same
  place the skeleton inserted six rows and rewrote `BendStep`'s. `BendStep`'s row is changed by the skeleton alone (this side's is the
  base's — my first comparison by `grep` said otherwise, because `ArcStep`'s row names `BendStep` in its Imports cell and matched
  too; read sentence by sentence, the difference was that second row). Resolved: the skeleton's seven rows as they stand, then this
  side's `ArcStep` row; the row keys asserted by the resolving script (`BendAway`, `LensOut`, `HornChart`, `CollarMapOut`, `R2Cap`,
  `BendGap`, `BendStep`, `ArcStep`).
- **`scripts/Axioms.lean`** — this side's block (FS131-IA2, 37 lines), a blank line, the skeleton's (FS131-KA1, 50 lines). **Literal
  keep-both leaves one record twice**: `#print axioms HadwigerNelson.Plane.ArcMap.LocalStep.of_cutArcs` is in both blocks (ll. 6105,
  6129), because both sides declare the name. Kept so in the merge commit, which then holds the two sides and nothing of mine; this
  side's line leaves in Stage 4 with the declaration it prints. (The alternative weighed: drop it in the resolution. Not taken — it
  hides a judgement inside a conflict, and the check then flags a missing line instead of a doubled one.)

### 3.3 The check, and an allowance made before the result

`tools/fs131_m7_merge_check.py` gained `--allow-twice LINE` **before it was run on this merge**, for the reason in 3.2 (read off the
conflict's text): one keyed line may stand twice, once from each side; every allowance used is printed; one not used fails (STALE
ALLOWANCE); the self-test doubles a record chosen among the lines not allowed and raises if there is none. Run on the index, the
working tree equal to it (the patched tool run from a copy outside the tree, so that the index held no change of mine; the copy and
the tool now in `tools/` are byte-identical, `cmp` exit 0). Expectations written before the three runs; each met:

| run | result |
|---|---|
| no allowance | **FAIL, exactly one failure**: `scripts/Axioms.lean: twice after the merge: […LocalStep.of_cutArcs]` — 16,105 files, 3 changed by both sides (`merge2-check-noallow.txt`) |
| that line allowed | **PASS**, the allowance printed (`merge2-check.txt`) |
| a wrong line allowed (`ArcBend.of_away`'s record) | **FAIL twice**: the doubling unexcused, and STALE ALLOWANCE (`merge2-check-wrongallow.txt`) |

So one deviation from "each file the side it should be", the expected one, and nothing else in 16,105 files; the three KEEP_BOTH files
are ours + theirs − base line for line. `--self-test` at these refs, the allowance in force: **five plants fired** — a byte of
`BendAway.lean` (theirs only), a line added to `ArcStep.lean` (ours only), `Proofs.lean`'s `BendAway` import dropped (caught by the
multiset rule here, `Proofs.lean` being changed by both sides in this merge), a doubled record (`falconer_reduction`'s, not the
allowed line), a file changed by both outside KEEP_BOTH (`merge2-check-selftest.txt`). **The index held the merge and nothing else**:
the 30 staged paths are exactly the 30 paths the skeleton changed since the base (compared as sets, both differences empty); no
unstaged change; no unmerged path; `MERGE_HEAD` = `dd8c2c33`. Committed as a merge: **`8ca92376`**, parents `26a6446c` and `dd8c2c33`;
the same check on the commit: PASS (`merge2-check-rev.txt`).

### 3.4 This commit does not build, and why that is the right unit

At `8ca92376` `LocalStep.of_cutArcs` is declared at `ArcStep.lean:584` and `BendAway.lean:97`, in one namespace, and `ArcStep`'s
imports reach `BendAway` (below), so one environment would hold the name twice. The brief sequences it so — the merges, each its own
commit, then the doubled declaration — and the commit's message says it in capitals. **So this merge is checked by script here and by
a build only after Stage 4**; the first merge had both. I did not test the prediction with `lake env lean` on `ArcStep`: the six new
modules have no `.olean` in this worktree yet, so it would fail for a missing import — a red for the wrong reason. The import graph
answers the question from source:

- `ArcStep` reaches `BendStep` and all six new modules (`BendAway`, `LensOut`, `CollarMapOut`, `R2Cap`, `HornChart`, `BendGap`); so
  after the deletion it reads `BendAway`'s `LocalStep.of_cutArcs` **through `BendStep`'s imports — no import of its own** (the brief's
  choice, taken this way: one edge fewer, and `ARCHITECTURE.md`'s `ArcStep` row stays true as it stands);
- **no bend module reaches `Procedure` or `Terminal`** (`BendAway`, `LensOut`, `CollarMapOut`, `R2Cap`, `HornChart`, `BendGap`,
  `BendStep`, `ArcStep`, `BendCollar`: none), so `Procedure` importing `ArcStep` (Stage 5) makes no cycle — read on the joined tree.

### 3.5 What the join showed that no line could see from its own branch (so far)

1. `HexRing` is upstream of `Limit`, `Procedure` and `Terminal`, and the first merge replaced it under them (§ 2.3–2.4).
2. `bv_l3` changed files across the first merge, statement and qualified name unchanged (§ 2.4).
3. "Keep every block" of `scripts/Axioms.lean` doubles the record of a declaration both sides state (§ 3.2).
4. Merging in sequence moves the base, and with it the second conflict, from the I5 record to `ARCHITECTURE.md` (§ 3.2).

## Stage 3 — SAVED (FS131-M7)
