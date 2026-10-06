# FS131-M7 — wave 5's lines joined on `fs131-w5c`; the arc step proved from the bends

*The record of job FS131-M7 (de Bruijn, the implementer; brief `data/fs131/briefs/FS131-M7-join.md` on `main`). Branch `fs131-w5c`,
worktree `.claude/worktrees/fs131-w5c`. Stages are headed "Stage n — SAVED (FS131-M7)"; working files are under `data/fs131/m7/`.*

## Theorems this phase proved

This job joined three lines; it derived no new mathematics. All in `HadwigerNelson.Plane.ArcMap`, read against the build of
`fa44d637` (`data/fs131/m7/M7AxiomsFinal.out`):

- `IsMaxRingArc.meet` (`Plane/ValidMap/Procedure`) — **[kernel]**, `[propext, Classical.choice, Quot.sound]`. New in the library by
  this job's placement; the statement is FS131-IA1's W5 and **the proof is FS131-IA2's**, copied by script from the file it compiled.
  Read against: "a constant-sided unit arc about `P` whose open arc meets a maximal one's has that arc's sides and lies in it".
- `ArcBend.of_away` (`Plane/ValidMap/ArcStep`) — **[kernel]**, the standard three. FS131-IA2's theorem with its hypothesis `hM`
  changed in one clause by ruling 448 (b) (the last clause in FS131-KA1's pointwise form) and its proof's last step changed with it.
- `exists_arcStep` (`Plane/ValidMap/Procedure`) — **proved from open children; not a kernel theorem on the standard three**:
  `[propext, sorryAx, Classical.choice, Quot.sound]`. Its own `sorry` is replaced by FS131-IA2's proof; it rests, through
  `bend_away_part` and `exists_arcBend_toward`, on the open declarations of the six bend modules and `CollarFit.map_hornCount_le`.
  Statement unchanged (FS131-IR3's restatement under ruling 430).

Moved the other way by the join, until FS131-BA1's proof arrives by merge: `CollarFit.map_localStep` and `LocalStep.of_cutArcs`,
on the standard three on `fs131-w5y`, are through `sorryAx` here (§ 4.4).

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
imports reach `BendAway` (below), so `ArcStep` declares a name its own imports already hold — which Lean rejects while elaborating
the module ("has already been declared"; seen in this job at § 5.1). *Corrected at Stage 6: I first wrote here that "one
environment would hold the name twice", as if that alone were an error. It is not — two modules neither of which imports the
other may declare one theorem with one type and meet silently (§ 6.3); the failure here comes from the import edge.* The brief
sequences it so — the merges, each its own
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

## Stage 4 — SAVED (FS131-M7): the doubled declaration gone, the one ruled edit made; the joined tree builds

### 4.1 The edits (all of them: `ArcStep.lean` and one line of `scripts/Axioms.lean`)

Made by a script that requires each anchor exactly once; the file as it stood is `data/fs131/m7/ArcStep-before-stage4.lean`.
`git diff --stat`: `ArcStep.lean` 7 insertions, 97 deletions (772 → 682 lines) — the deleted block 88 lines, and outside it 9 lines
out, 7 in.

1. **`LocalStep.of_cutArcs` deleted from `ArcStep`** (inventory 448 (a)) — its section header, docstring, statement and proof, 88
   lines; the script asserted the block holds exactly one `theorem`, that one. `ArcStep` reads `BendAway`'s through `BendStep`'s
   imports (§ 3.4); `CollarFit.map_localStep`'s call is unchanged. **What the deletion forfeits**: this was the only *proved* copy in
   the tree (`BendAway`'s is `sorry`; FS131-BA1 is copying the proof there on `fs131-w5a`). The proof is in git at `3f8270c0` and at
   this branch's `8ca92376`, `ArcStep.lean` ll. 584–664, and in the saved copy above.
2. **`ArcBend.of_away`'s hypothesis `hM` follows `bend_away_part`'s conclusion** (448 (b)) — its last clause only:
   ```
   -      (∀ θ ∈ Ioo θ₁ θ₂, M.OnRingArc P (ringPt P θ) →
   -        ∃ a b, a < b ∧ θ ∈ Icc a b ∧ Icc a b ⊆ F.r2Contacts P θ₁ θ₂ c)) :
   +      (∀ θ ∈ Ioo θ₁ θ₂, M.OnRingArc P (ringPt P θ) → P + 2 * e θ ∈ closure (F.region c))) :
   ```
   and the proof where it read the old clause: the last slot of the `refine` is now the term `⟨hout, hin, hleft θ hθ hon⟩` (three
   lines became one); its docstring's last sentence says the clause is the pointwise form. The hypothesis is weaker (the interval
   form gave the point), so the theorem is stronger; it had no caller yet.
3. **Two sentences my own edits would have left false, corrected, and nothing else**: `ArcStep`'s module docstring listed
   `LocalStep.of_cutArcs` among the module's lemmas — it now says the lemma is `Plane/ValidMap/BendAway`'s, read here by
   `CollarFit.map_localStep`. (`CollarFit.map_localStep`'s own docstring cites the lemma by name and stays true: not touched. Any other
   docstring is the remedy pass's.)
4. **`scripts/Axioms.lean`**: this side's doubled record `#print axioms …LocalStep.of_cutArcs` removed from the FS131-IA2 block
   (one line); it stands once, in FS131-KA1's block, the block of the module that declares the name. FS131-IA2's block header (prose:
   "the last two records rest on the open child `CollarFit.map_hornCount_le`") is another job's text and is left; what moved is
   stated in this job's block at Stage 6 and in 4.4 below.

### 4.2 The scripted checks (each tool's first run was here; each with a control that fired)

- **`hM` is `bend_away_part`'s conclusion** (`tools/fs131_m7_away_clause.py`): **EQUAL — 18 clauses, 877 characters after folding
  whitespace** (`data/fs131/m7/away-clause.txt`). Control on the real before-state, the file as it stood at the merge commit:
  **DIFFER at clause 18 of 18**, the interval form against the pointwise form (`away-clause-before.txt`) — so clauses 1–17 already
  agreed (the horn clause was already the weakened one), and the edit is one place, as ruled. `--self-test`: three plants fired, at
  clauses 18, 13 and a clause count of 17 (`away-clause-selftest.txt`).
- **No other statement changed** (`tools/fs131_m7_stmt_check.py 8ca92376`, 36 Lean files of `Plane/ValidMap/`, **2,404 statements
  read**): without allowances exactly three lines — `ArcStep.lean` TOUCHED, `LocalStep.of_cutArcs` MISSING from `ArcStep.lean`,
  `ArcBend.of_away` CHANGED (`stmt-stage4-noallow.txt`); with `--allow ArcBend.of_away --gone ArcStep.lean:LocalStep.of_cutArcs
  --touch ArcStep.lean`: **PASS**, neither allowance stale, none added (`stmt-stage4.txt`). `--self-test`: six plants fired — a
  hypothesis dropped, a declaration renamed and a definition's body changed in `Procedure`; a conclusion and a structure field changed
  in `ArcStep`; an allowance for a statement that did not change (`stmt-selftest-stage4.txt`).
- **What differs from the merge commit in the whole tree**: under `Proofs/`, `ArcStep.lean` alone; `scripts/Axioms.lean` (one line);
  this job's record, tools and outputs. **Nothing in the outward bend's six modules or in `BendStep.lean`.**

### 4.3 The build (the first that can be read since the second merge)

Expectation written before the run: 9 modules rebuilt (the six new, `BendStep`, `ArcStep`, `Proofs`), 1796 modules, 37 distinct
`sorry` sites (the six modules 35 — FS131-KA1's total; `BendStep` 1; `Procedure` 1). **Each met.**
`slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — 459 of 459 batches, 9 modules rebuilt, 8 with
warnings, 8 min 21 s, exit 0** (the status in `data/fs131/m7/build-stage4.rc`, written by the launching command on either outcome;
saved log `build/gate/build/20261006T065635Z-1888387.log`, ending "Build completed successfully (5803 jobs)"; driver log
`build-stage4.log`). No Lean file was modified after the build started (file times against the log's stamp).

- **Rebuilt**: `BendAway`, `LensOut`, `CollarMapOut`, `R2Cap`, `HornChart`, `BendGap` — the skeleton's modules, elaborated in this
  worktree for the first time — `BendStep`, `ArcStep`, `Proofs`. Not `Procedure`, not `Terminal` (they do not reach the bends yet).
- **Warnings: 190 lines, all `declaration uses 'sorry'`, at 37 distinct sites**: `BendAway` 6, `LensOut` 7, `CollarMapOut` 7, `R2Cap`
  3, `HornChart` 4, `BendGap` 8 (35); `BendStep` 1 (l. 290, `CollarFit.map_hornCount_le` — `bend_away_part` no longer warns, being
  proved from children); `Procedure` 1 (`exists_arcStep`). None of another kind. No warning or error names `ArcStep`: it holds no
  `sorry` of its own. (The per-module split is this build's; of FS131-KA1's receipt I compared the total only.)
- The log's three `error:` lines are the pre-check's out-of-date notices again (lines 3, 5, 7, under its header on line 1).
- **`tools/check_architecture.py`: exit 0, PASS** — 259 hand-written modules, 259 rows, missing none, extra none; 259 Imports cells
  compared, 0 mismatches (`arch-stage4.txt`). So the resolution of the `ARCHITECTURE.md` conflict (§ 3.2) agrees with the import
  graph. Controls, on copies of the map outside the tree: `BendGap` dropped from `BendStep`'s Imports cell — exit 1, "imports of
  Plane/ValidMap/BendStep … real-only ['Plane/ValidMap/BendGap']"; `BendAway`'s row removed — exit 1, "missing:
  ['Plane/ValidMap/BendAway']" (`arch-stage4-control-imports.txt`, `-norow.txt`).

### 4.4 The axioms of what this stage touched — and one receipt that moved

`data/fs131/m7/M7Axioms4.lean` (the 31 names of FS131-IA2's block of `scripts/Axioms.lean`, taken by script, with
`LocalStep.of_cutArcs` and `bend_away_part`) → `M7Axioms4.out`, `slot.py --mem 12 --cpus 2 -- lake env lean`, exit 0, against this
build's oleans; read by `tools/fs131_ir_axsum.py` (FS131-IR1's, unchanged). Expectation written before the run, met:
**33 records for 33 print commands — 28 on the standard three or fewer, 5 through `sorryAx`, 0 other** (`M7Axioms4-summary.txt`).

| through `sorryAx` | why |
|---|---|
| `LocalStep.of_cutArcs` | its own `sorry`, in `BendAway` — the only copy now |
| `bend_away_part` | proved from the outward bend's open children |
| `CollarFit.arcBend`, `exists_arcBend_toward` | as on `fs131-w5y` (the horn child), now also through the cut lemma |
| **`CollarFit.map_localStep`** | **moved here from the standard three** by the deletion |

`ArcBend.of_away`, the one statement changed: `[propext, Classical.choice, Quot.sound]`. **Control**: the same output read with
FS131-IA2's expectation (its two names) FAILS, `SORRY-UNEXPECTED CollarFit.map_localStep` among its lines (`M7Axioms4-control.txt`).

**The cost, said plainly.** On `fs131-w5y` `CollarFit.map_localStep` and `LocalStep.of_cutArcs` were kernel theorems on the standard
three; in the joined tree both are through `sorryAx` until FS131-BA1's copy of the proof arrives by merge. It is ruled (448 (a)) and
it loses no mathematics (4.1 item 1), but the joined line holds two standard-three theorems fewer than its parts did, and that is
held for the coordinator with its test: **at the merge of `fs131-w5a`, `LocalStep.of_cutArcs` and `CollarFit.map_localStep` must
print the standard three; if `BendAway`'s copy is still `sorry` then, the proof is restored from `3f8270c0`.** Moving the proof into
`BendAway` here was not open to me: that file is FS131-BA1's while it works, and an edit would collide with its own.

## Stage 4 — SAVED (FS131-M7)

## Stage 5 — SAVED (FS131-M7): the arc step's last lines in `Procedure`; `Procedure` holds no `sorry`

### 5.1 FS131-IA2's text in the joined tree, tried in scratch before `Procedure.lean` was touched (iteration grade)

`lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false`, possible only now (Stage 4's build made the bend modules' oleans).
Not evidence — the build is (5.3).

- **First try, and what it showed** — FS131-IA2's scratch file with its stand-in removed and the call made to `bend_away_part`
  itself: **exit 1, one error, and not in the lines I place.** It is in `exists_procStep'`, FS131-IA2's generated copy of the
  consumer, at `exists_vertexStep hG.valid hG.clean (hGd t)`: on `fs131-w5y` `exists_vertexStep` took `(hv : v ∈ F.dom)`; on this
  line it takes `(hv : F.Covers v 1)`, and the real `exists_procStep` calls it with `covers_of_isPlaneMap hG.plane t 1` (l. 3001 as
  then numbered). **So the third part of FS131-IA2's scratch — the consumer's copy — is stale on this line** (its report's "compile
  … against `Procedure` and `ArcStep`" is true of its branch's older `Procedure`). No bearing on this job: the caller's lines were
  already in place (FS131-IR3's Stage 23) and are not mine to change. I had overwritten that run's output; it is reproduced as
  `data/fs131/m7/LastLinesJoined-withConsumer.lean` → `lastlines-joined-withConsumer.txt`, where it shows the same error at the
  same line **and a second one, "`IsMaxRingArc.meet` has already been declared"** — because the reproduction ran after the placement:
  the built `Procedure` now declares that name. The second error is the reproduction's own, not the first run's.
- **The instrument cut to what is placed** — `data/fs131/m7/LastLinesJoined.lean`: `IsMaxRingArc.meet` and `exists_arcStep'` only.
  **Exit 0, no error line, no warning line**; `IsMaxRingArc.meet` on `[propext, Classical.choice, Quot.sound]`, `exists_arcStep'`
  through `sorryAx` with no `sorry` token of its own (`lastlines-joined.txt`; run at 02:12:16, before the placement at 02:13:32 —
  the order is by file times). **Control**, FS131-IA2's own: the withdrawn degree clause back in the statement — exit 1, one error,
  at l. 83, inside `exists_arcStep'` (`lastlines-joined-control.txt`; FS131-IA2 saw three errors for the same plant on its branch —
  a difference I did not look into).
- **So no line of FS131-IA2's text needed a change to compile here** beyond the substitution it prescribed itself. Its diff against
  the compiled text is one name: `bend_away_part_weak` → `bend_away_part`.

### 5.2 The placement (`tools/fs131_m7_place.py --apply`; every proof line copied by script from the file FS131-IA2 compiled)

`Procedure.lean` 3,403 → 3,465 lines; `git diff --stat`: 82 insertions, 20 deletions, in six hunks (read in place):

1. the import `Proofs.HadwigerNelson.Plane.ValidMap.ArcStep`, after `FlankUA`'s (it brings `BendStep` and the bend modules);
2. **`IsMaxRingArc.meet`** (FS131-IA1's W5), docstring and proof, after `IsMaxRingArc.not_regularAt`;
3. **`exists_arcStep`'s proof** in place of its `sorry` — the 35 lines between FS131-IA2's markers;
4. `exists_arcStep`'s docstring: FS131-IA2's, from its report, **with the last sentence of the docstring it replaces kept** ("Inhabitant:
   no Lean model on file; `l60Frag` cleaned, its whole arc, at [hand] (FS131-QA4 § 6.2, rank 7)") — the one addition to FS131-IA2's
   docstring text, made because `LEAN.md` § The gate asks a theorem over a structure for its inhabitant or a note, and FS131-IR3 had
   put the note there after FS131-IA2 wrote;
5. the module docstring's two passages about the arc step: a collar bend, uncleaned (the bent map of a clean map is clean), read
   through `ArcStep`'s interface, not `UnitArc`'s bends. I first ended the second passage "Both steps are proved here from those
   constructions", and replaced it before the build by "Both steps' proofs are in this module, over those constructions": the first
   reads as a claim that the bends beneath are closed, which they are not, and a status sentence in a docstring goes stale.

**Not touched**: `exists_arcStep`'s statement (the tool refuses to place unless the text between `theorem exists_arcStep` and `:= by`
equals the scratch's `exists_arcStep'` statement) and `exists_procStep` (the caller).

`--check`: **PASS** — W5 and the proof are in `Procedure.lean` byte for byte as compiled, the docstring is the report's with the
note, the import once, the two passages in place, no `sorry` token outside comments (`data/fs131/m7/place-check.txt`).
`--self-test`: **six plants fired** (`place-selftest.txt`). One of them, "a sorry in a proof", fired through the byte-equality
clause and not the sorry-count clause it is named for; that clause tested for itself (`place-sorry-clause.txt`): a `sorry` in an
unrelated proof — fired, "1 `sorry` token(s) outside comments"; the word in a `--` comment and in a docstring — not counted.

**`ARCHITECTURE.md`**, same commit (two rows, one line each; the file as it stood: `data/fs131/m7/ARCHITECTURE-before-stage5.md`):
`Procedure`'s Imports cell gains `Plane/ValidMap/ArcStep`; its holdings name `IsMaxRingArc.meet` and say what the two steps are (the
old parenthesis read "the moves and bends, cleaned; proved after the merge with `main`"); `ArcStep`'s row says `Procedure` imports
it. **And a slip of Stage 4's, found here by reading the row, not by any check**: `ArcStep`'s row still listed
`LocalStep.of_cutArcs` among that module's lemmas, one commit after I deleted it there — at Stage 4 I corrected the matching clause
of the module docstring and did not look at the map. `check_architecture` could not have said so: it compares Imports cells and
coverage with the code, not a row's prose. Corrected: the row cites the lemma as `Plane/ValidMap/BendAway`'s (whose own row holds it).

### 5.3 The build

Expectation written before the run, with the rebuild set computed from the import graph and saved first
(`data/fs131/m7/stage5-expected-rebuild.txt`): 6 modules rebuilt — `Procedure`, `Terminal`, `Dense`, `BaseWalk`, `BaseDense`,
`Proofs`; 36 distinct `sorry` sites, none in `Procedure`; 7 modules with warnings; 1796 modules; 459 batches.
**Met but for the last: 464 batches.**

`slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — 464 of 464 batches, 6 modules rebuilt, 7 with
warnings, 9 min 17 s, exit 0** (`data/fs131/m7/build-stage5.rc`; saved log `build/gate/build/20261006T071443Z-2071643.log`, ending
"Build completed successfully (5803 jobs)"; driver log `build-stage5.log`). No Lean file modified after it started.

- **Rebuilt**: the six expected, compared by `diff` with the saved list — identical. `Procedure` (11 s) with no warning beneath it.
- **Warnings: 399 lines, all `declaration uses 'sorry'`, at 36 distinct sites**: `BendAway` 6, `LensOut` 7, `CollarMapOut` 7, `R2Cap`
  3, `HornChart` 4, `BendGap` 8 (the outward bend's six modules: 35) and `BendStep` 1 (l. 290, `CollarFit.map_hornCount_le`).
  **In `Procedure`, `Terminal`, `ArcStep`, `BaseDense`, `HexRing`, `BendCollar`: 0 each** (each counted by name). None of another kind.
  **Every open leaf of wave 5 is now one of the outward bend's children.**
- **The word "error" occurs once in the log, at line 46**, and it is the pre-check's out-of-date notice for `Procedure` (the
  pre-check section is lines 1–48; it stands lower than in the earlier logs because the pre-check first replays the bend modules'
  cached warnings). No Lean error.
- **The batch count**: 464, not the 459 I wrote. Same 1796 modules, cut differently — Stage 4: 8×1 + 6×2 + 4×3 + 441×4; here
  16×1 + 4×2 + 4×3 + 440×4. The last eight batches are sized 2, 1, 1, 1, 1, 1, 1, 1: with `Procedure` importing `ArcStep`, wave 5's
  tail is a chain — `BendStep`, `ArcStep`, `Procedure`, `Terminal`, `Dense`, `BaseWalk`, `BaseDense`, `Proofs` — one module per
  level. So **`BaseDense` and `BaseWalk`, the density half, are downstream of `Procedure`** and now of every bend module. A fact for
  the re-layout the coordinator has deferred (ruling 450 (d)); it changes no statement.
- **`tools/check_architecture.py`: exit 0, PASS** — 259 modules, 259 rows; 259 Imports cells compared, 0 mismatches, `Procedure`'s new
  import against its new cell among them (`arch-stage5.txt`).

### 5.4 Statements, and no new trust

- `tools/fs131_m7_stmt_check.py dcdeac13 --touch Procedure.lean`, **with no allowance**: **PASS — 2,403 statements read, none changed,
  none missing; added: `IsMaxRingArc.meet`** (`stmt-stage5.txt`). Without `--touch`: one failure, `Procedure.lean` TOUCHED — the only
  Lean file that differs from Stage 4's commit (`stmt-stage5-notouch.txt`).
- **No `axiom`, no `native_decide`**: added by this job's own edits (285 diff lines under `Proofs/`) — 0 and 0; added by the two
  merges (6,864 diff lines) — 0 and 0; in `Plane/ValidMap/` as it stands — none. The patterns shown to match on a text that holds
  both, first (this machine's `grep` under-matches some forms toward a clean negative).

## Stage 5 — SAVED (FS131-M7)

## Stage 6 — SAVED (FS131-M7): the check; what stands twice; what the later merges will meet

No build after Stage 5's: this stage edits no Lean module (`scripts/Axioms.lean` is the receipt, not a module of `Proofs`). I ran no
gate (`scripts/axioms.sh`, `vacuity.sh` are the gate's), touched nothing on `main`, and left no process running.

### 6.1 The axioms print (against the build of `fa44d637`)

Twenty names, each resolved from source to one qualified declaration by script (`data/fs131/m7/final-names.txt`) →
`M7AxiomsFinal.lean` → `M7AxiomsFinal.out` (`slot.py --mem 12 --cpus 2 -- lake env lean`, exit 0, no error line), read by
`tools/fs131_ir_axsum.py` (FS131-IR1's, unchanged). Expectation written before the run, met:
**20 records for 20 print commands — 8 on the standard three, 12 through `sorryAx`, 0 with any other axiom; PASS**
(`M7AxiomsFinal-summary.txt`).

- **`[propext, Classical.choice, Quot.sound]`** (each record read verbatim): `exists_vertexStep`, `stuckRun_ne_univ`,
  `bend_toward_collar`, `exists_preBend`, `bv_l3`, `exists_open` — the brief's six — and `IsMaxRingArc.meet`, `ArcBend.of_away`.
  Four of these were open questions, not formalities: `exists_vertexStep` and `stuckRun_ne_univ` are re-taken against the `HexRing`
  the first merge put under them and a `Procedure` that now imports the bend modules; `exists_preBend` and `bv_l3` are now
  downstream of `Procedure`. None moved. `bv_l3`, `sorry` in this line's `HexRing` at the start, is a kernel theorem in `BaseWalk`.
- **Through `sorryAx`, and nothing else foreign**: `exists_arcStep`, `exists_procStep`, `exists_terminalSeq`, `exists_terminalMap`,
  `exists_red`, `exists_terminal` — the brief's six — and `LocalStep.of_cutArcs`, `CollarFit.map_localStep`, `bend_away_part`,
  `CollarFit.map_hornCount_le`, `exists_arcBend_toward`, `CollarFit.arcBend`.
- **What the print cannot say, and what bounds it**: which open declarations a record rests on. The build's warnings bound it — the
  tree's only `sorry` in wave 5's modules are the six bend modules' 35 and `CollarFit.map_hornCount_le` — and `Procedure` and
  `Terminal` hold none, with `exists_vertexStep` on the standard three; so, as an inference from those two facts, `exists_terminalMap`
  is open through `exists_arcStep` alone among `Procedure`'s own leaves.
- **Controls**: `exists_arcStep` left off the expectation — FAIL, `SORRY-UNEXPECTED …exists_arcStep`; `exists_vertexStep` added to it
  — FAIL, `SORRY-EXPECTED-BUT-STANDARD …exists_vertexStep` (`M7AxiomsFinal-control.txt`, `-control2.txt`); the summarizer's
  `--self-test`: ok (`axsum-selftest.txt`).

### 6.2 The receipt

A block "FS131-M7" in `scripts/Axioms.lean` above `=== PURCHASED ===`: **one record, `IsMaxRingArc.meet`** — the only one of the
twenty names that had none (checked by script). The file holds 5,138 records, none twice. The block alone, with its import,
elaborates (exit 0, its record on the standard three: `data/fs131/m7/M7Block.out`); the whole file's run is the gate's. *A sentence
of the block as I first wrote it said `exists_arcStep`'s record was "in FS131-IR1's block"; the nearest header above that record
names another job. I had written it from assumption; it now says "has its record above (once)".*

### 6.3 What stands twice in the joined tree (for the remedy pass)

`tools/fs131_m7_dupes.py --whole Proofs/HadwigerNelson/Plane a20bb6f5` (`a20bb6f5`: where wave 5 left `main`): 72 files, 4,286
public declarations (`data/fs131/m7/dupes-whole.txt`); its plant fired — a re-declared name NAME-TWICE, its copy STATEMENT-TWICE
(`dupes-whole-plant.txt`). And every hand-written Lean file of the library, names only: 259 files, 7,446 public declarations
(`dupes-names-library.txt`; the generated `Instances/*/(Cnf|HalfA|Critical)/` not scanned).

**One name is declared twice — and it is on `main`, older than this job, and it builds.**
`HadwigerNelson.Plane.conj_e`, `theorem conj_e (θ : ℝ) : (starRingEnd ℂ) (e θ) = e (-θ)`, at `Plane/Chord.lean:276` (commit
`500c4c88`, FS131-I3c) and `Plane/SixFragment.lean:342` (`e0679dd4`, FS131-I3f), both 2026-10-04; present on `origin/main`. Neither
module imports the other. Lean's own account: `SixFragment` alone holds the constant declared in `SixFragment`
(`conj-e-query2.txt`); an environment importing both holds one, reported from `Chord`, with no error (`conj-e-query.txt`); each copy
is on the standard three. **It is the only doubled name in the 259 hand-written modules.** No name was doubled by the join:
`bv_l3` and `LocalStep.of_cutArcs` each stand once.

**Why the build does not see it** — read in the pinned toolchain's source, not recalled: `Lean/Environment.lean` (v4.32.0),
`subsumesInfo`, called where modules are imported: a constant already present is accepted when name, type and universe parameters
agree and both are theorems ("we do not check whether the theorem `value` field match … relies on … proof irrelevance"); only
otherwise `throwAlreadyImported`. **So the build catches a doubled theorem only when one declaring module is upstream of the other**
(then the second is a redeclaration during elaboration). Two sibling modules stating one theorem under one name meet silently, and
which copy a downstream module keeps is decided by import order — harmless here (both proved, same axioms), but with one copy
`sorry` and one proved, **a downstream `#print axioms` could follow either** (read from the importer's code; I did not test such a
pair, and the module a constant is attributed to and the copy kept are held in two maps with different rules). That was the configuration of `LocalStep.of_cutArcs`
at this join (proved in `ArcStep`, `sorry` in `BendAway`), and it was loud only because `ArcStep` happens to import `BendAway`
through `BendStep`; inventory item 443 calls the collision "a loud failure by design", and by Lean's rule it is not guaranteed.

*How I came to it, because the next reader of this tool's output will be tempted the same way.* The tool reported the pair on its
first whole-tree run and I did not believe it, holding that "Lean rejects two declarations of one name in one environment". I tried
three times to fault the instrument — the second site is inside a comment (a scan: no); its olean is stale (git and Lake's hashes:
no); my Lean query is wrong (a second query: no) — before reading the importer. The belief was false as I held it, and I had used
it at Stage 3 (§ 3.4, corrected in place).

**Statements under two or more public names** (at least one new since the fork; read one by one):

| statement | names |
|---|---|
| the degree is unique | `HasDegree.eq` (`OpenMove`) = `HasDegree.unique` (`Pushforward`) |
| the colours at an interior point | `coloursAt_eq_of_mem_interiorPts` (`FlankUA`) = `coloursAt_eq_singleton_of_interior` (`Limit`) |
| `dist²` by coordinates — **one short name in both files**, apart only by namespace | `ArcMap.dist_sq_re_im` (`BaseWalk`) = `dist_sq_re_im` (`SixFragment`) |
| `‖z‖²` by coordinates — **four names** | `ArcMap.norm_sq_eq_re_im` (`HexRing`) = `ArcMap.sq_norm_eq_re_im` (`UnitArc`) = `sq_norm_eq` (`Chord`) = `sq_norm_re_im` (`SixFragment`) |
| a ring arc under whole turns | `ArcMap.ringArc_add_int_mul` (`BaseWalk`) = `ringArc_add_two_pi_mul` (`MapTopology`) |
| a ring point under whole turns | `ArcMap.ringPt_add_int` (`Procedure`) = `ArcMap.ringPt_add_int_mul` (`BaseWalk`) |
| the union of two overlapping ring arcs — word for word | `IsRingArc.union` (`Procedure`) = `IsRingArc.union_of_overlap` (`BaseDense`) |

In the last two, `BaseWalk` and `BaseDense` are downstream of `Procedure` since Stage 5, so their copies are the redundant ones;
`IsMaxRingArc.meet` reads `Procedure`'s. **The import relation of each group, computed from the graph** (I had first ordered the pairs by which
module I took to be older, and was wrong for two): `SixFragment` is upstream of `BaseWalk`, `MapTopology` of `BaseWalk`,
`Procedure` of `BaseWalk` and `BaseDense`; in the four-way `Chord` and `SixFragment` are each upstream of `UnitArc`, itself
upstream of `HexRing`; **`OpenMove`/`Pushforward`, `FlankUA`/`Limit` and `Chord`/`SixFragment` are siblings** — the configuration
in which a doubled name is silent. These pairs differ in name, so they are duplicates, not collisions; `Chord` and `SixFragment`
hold the one collision and a second duplicate (`sq_norm_eq` / `sq_norm_re_im`) between them. **Not duplicates, though a tool line pairs them**: `IsRingArc.degree_openArc` (`ArcStep`)
with `CollarFit.degree_openArc` (`BendCollar`) — the collar-free form and its special case, one conclusion (a generalization:
FS131-IA2's); `CollarFit.map_localStep` with `CollarFitOut.map_localStep` — the two bends' mirrored lemmas.

**A defect of my own tool, not repaired**: its NORM-TWICE class deletes dotted qualifiers, and so equates `F.clean.Valid` with
`F.cleanKeep.Valid` and five models' `X.Valid` with one another — **five of its six lines are false** (read at the statements); the
sixth is the `union` pair above. The class is informational and never fails a run; I did not change the normalizer, since a hasty
fix could hide a true pair. What it would take for a gate: a Lean-side scan of each module's constant names for a name present in
two modules — the kernel-side form, which also sees what a textual scan cannot (instances, derived and macro-made declarations).

### 6.4 What the two later merges will meet (observed 2026-10-06 02:37; both tips move)

Read-only but for one unreferenced commit object made for the two-step trial (no ref moved, no working-tree file changed).

- **`origin/fs131-w5a`** at `74fbdf16` (FS131-BA1, 8 commits past `dd8c2c33`): `BendAway`, `BendStep`, `CollarMapOut`, `LensOut`, its
  record, tools, data, `scripts/Axioms.lean`. **`origin/fs131-w5z`** at `43dfeb6e` (FS131-BA2, 11 commits): `BendGap`, `HornChart`,
  `R2Cap`, `BendStep`, its record — **and it has merged `fs131-w5a` twice** (at `66cb0314` and `4559c106`; 6 of that branch's 8
  commits), so the two tips agree byte for byte on `BendStep.lean` and `BendAway.lean`. The two are not independent merges: `fs131-w5z`
  brings most of `fs131-w5a` with it.
- **Trial merges into this line: each alone clean; both, `fs131-w5a` then `fs131-w5z`, clean.** The only file either shares with this
  line's changes is `scripts/Axioms.lean`, and it merges by itself today. Foreseen as the tips move: `scripts/Axioms.lean` and
  `ARCHITECTURE.md` (their rows for the six modules sit beside `BendStep`'s and `ArcStep`'s, which I edited) — adjacency, keep-both.
  No Lean file of theirs is one I edited; `ArcStep.lean` does not exist on their branches.
- **The statements this line reads from the bends are unchanged on both tips**: `bend_away_part` (its conclusion equal to
  `ArcBend.of_away`'s `hM`, 18 clauses; its whole statement equal), `CollarFit.map_hornCount_le` (still `sorry` on both),
  `LocalStep.of_cutArcs`. Their merge messages name two ruled statement changes on their side, `AwayBend.idle`'s (446 (b)) and
  `dist_lt_one_of_thin`'s — inside the bend modules; I did not read them. **To re-run at each merge**: `python3
  tools/fs131_m7_away_clause.py` (a second), and `tools/fs131_m7_merge_check.py BASE OURS THEIRS`.
- **`LocalStep.of_cutArcs` is proved on `fs131-w5a`'s tip** (its body opens with the first line of the proof deleted here; I read no
  further and ran nothing there). If that holds at the merge, `LocalStep.of_cutArcs` and `CollarFit.map_localStep` return to the
  standard three; the test is the print of those two names.
- **After both, by today's count, wave 5's open leaves would be FS131-BA2's**: `CollarFit.map_hornCount_le` and whatever of `BendGap`,
  `HornChart`, `R2Cap` is still open on its tip — not counted by me.

### 6.5 What the join showed that no line could see from its own branch

1. `HexRing` is upstream of `Limit`, `Procedure`, `Terminal`; the first merge replaced it under them (§ 2.3).
2. `bv_l3` changed files, statement and name unchanged (§ 2.4).
3. "Keep every block" of `scripts/Axioms.lean` doubles the record of a declaration both sides state (§ 3.2).
4. Merging in sequence moves the base, and the second conflict with it, to `ARCHITECTURE.md` (§ 3.2).
5. The join costs two standard-three receipts until FS131-BA1's merge (§ 4.4).
6. FS131-IA2's scratch copy of the consumer does not compile on this line: `exists_vertexStep` was restated here (§ 5.1).
7. With `Procedure` importing `ArcStep`, wave 5's tail is a chain of seven modules, and the density half (`BaseWalk`, `BaseDense`)
   is downstream of `Procedure` and of every bend module (§ 5.3).
8. A doubled theorem name builds silently unless one module imports the other; one such pair is on `main` (§ 6.3).

### 6.6 Slips of mine, in one place

A waiter armed on a command-line pattern, stopped before it decided anything (§ 2.5). A count mislabelled and a cause guessed, both
corrected from the log and the import graph (§ 2.5). `ArcStep`'s row of `ARCHITECTURE.md` left listing a lemma I had deleted, for
one commit, under a passing check (§ 5.2). A job's block named from assumption in the receipt, removed (§ 6.2). A scratch run's
output overwritten, reproduced under its own name (§ 5.1). A batch count predicted wrong (§ 5.3). A false premise about Lean's
importer held through three probes and used at Stage 3 (§ 6.3, § 3.4). The merges were committed with `git commit` and no path, as
a merge must be, the index compared with the merge first (§ 2.2, § 3.3).

## Drafts for the front page

**None for `CLAUDE.md` § The gate or § Trust ledger: no gate ran in this job, and wave 5 is not at its gate.** No ledger row
regrades — `exists_terminalMap` is through `sorryAx`. No Frontier line and no Proof Atlas grade moves. For the filing that follows
the outward bend: this job adds one record to `scripts/Axioms.lean` (`IsMaxRingArc.meet`) and removes one that stood twice
(`LocalStep.of_cutArcs`); the corrections FS131-IA1 and FS131-IA2 listed stand, less the two this job made (`Procedure.lean`'s module
docstring and `exists_arcStep`'s docstring).

For `LEAN.md`, a draft, **slot: § The gate, after the bullet "Every definition has a `#eval`/`example` that would fail if it
drifted"**, new bullet:

> - **A theorem declared under one name by two modules, neither importing the other, builds in silence**: at import Lean accepts a
>   second constant of the same name when both are theorems of the same type (`Lean/Environment.lean`, `subsumesInfo`, v4.32.0), and
>   by that code import order decides which copy a downstream module keeps (read, not tested on a `sorry`/proved pair). The build
>   catches a doubled name only when one module is upstream of the other. A join of two lines checks doubled names by script (`tools/fs131_m7_dupes.py --whole`), never by the build.

## Stage 6 — SAVED (FS131-M7)
