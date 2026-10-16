# FS131-IRU2 — the ring of unit vectors: `main` merged, every landing's gate inputs kept, the full gate once

*de Bruijn, the implementer (successor to FS131-IRU1). Brief: `data/fs131/briefs/FS131-IRU2-ring.md` (on `main` at `d9959820f`).
Worktree `.claude/worktrees/il5`, branch `fs131-kru1`, starting at `5a22b1a34` (the predecessor's gate commit `ddb765bac` plus its
record and report). Working files: `data/fs131/iru2/`. Nothing in this milestone is blind.*

## Theorems this phase proved

None. This job proves no theorem and changes no proof or statement: it merges `main` into the branch, reconciles the gate's
input files, and runs the full gate once on the merge. The 40 kernel theorems of the ring of unit vectors are FS131-IRU1's (its
record, `plans/FS131-IRU1-ring.md` § Theorems this phase proved); this job's gate re-checks them on the merged tree.

## Stage 1 — SAVED: the readback

### 1.1 The quotations

`data/fs131/iru2/quote_check.py` (a copy of FS131-IFR2's checker) reads every block quotation of the brief and looks for it,
verbatim, in its named source. The brief has three, all from `plans/FS131-close-inventory.md` (items 1065, 1063, 1025), checked
against `main`'s tree at `d9959820f`: **all three VERBATIM** (2,155, 2,701 and 2,276 characters; `data/fs131/iru2/quote_check.out`,
exit 0). Control: `--plant` changes one character of the first and the check reports `MISMATCHES: 1`, exit 1, the other two still
VERBATIM (`data/fs131/iru2/quote_check_plant.out`).

**One figure of the brief is a slip, not a quotation:** `touches:` says the worktree's `.lake/build` "is the predecessor's gated
build of `e849029c3`". `e849029c3` is FS131-IFR1's commit (the density branch's vacuity header, an old hash from before that
branch's rewrite; no branch holds it now). The worktree's build is FS131-IRU1's gated build of `ddb765bac` (its build 3, on
`45de7612d`, record § 3.1): `lake build --no-build Proofs` under the slot reads "All targets up-to-date (6535 jobs)", exit 0
(`data/fs131/iru2/uptodate-premerge.log`), and `5a22b1a34` changes nothing under `Proofs/`, `Proofs.lean`, `scripts/` or the
package files after `ddb765bac` (`git diff --stat`: empty). Nothing in the work depends on it.

### 1.2 Where the trees stand

- **The branch** `fs131-kru1` at `5a22b1a34`, 20 commits ahead of the merge base `93d1914b8` (inventory item 1044, on `main`).
- **`main`** at `d9959820f`: since the base it brought two landings — the five colours by field and by class (FS131-KCS1,
  FS131-ICS1) and the density form of the collapse (FS131-KFR1, FS131-IFR1, FS131-IFR2; gated on `b8cef1f36`, merged as
  `dfba6bc68`) — and coordinator commits. Its gated build is in the main tree.
- **Files changed on both sides** since the base: `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean`,
  `scripts/Assumptions.lean`, `scripts/vacuity-baseline.txt` (and the predecessor's record and report, which the coordinator copied
  to `main` unchanged). **No proof file is changed on both sides.** `scripts/Assumptions.lean`: both sides delete the same line,
  the `.condition` entry for `Arith.IsUsablePrime` (the branch because `Rigidity.exists_isUsablePrime` concludes it, `main` because
  FS131-ICS1's `SqrtTwentyThreeCbrtTwo.exists_usablePrime_eleven_F23` does), so it stays retired with no conflict.
  `scripts/axioms-controls.txt` and `scripts/assumptions-ledger.txt` changed on `main` only.
- **Names.** The three lemmas the branch made public in `Rigidity/AdmissiblePrime` (`exists_integral_primitive`,
  `exists_dvd_of_dvd_exponent`, `nonempty_residueHom`) are named nowhere on `main` outside that module (`git grep` over `Proofs/`
  and `scripts/` of `main`), and no `open private` of that module exists there. A full name intersection of the two lines'
  compiled constants is taken before the first build (stage 2).

### 1.3 What the merge must keep (the predecessor's record § 3.5 and its report's last held item)

1. `scripts/Axioms.lean`: this branch's CLEAN block (FS131-IRU1, 45 records) **and** `main`'s blocks (FS131-ICS1's and FS131-IFR1's,
   CLEAN and IMPORTED). The predecessor's aborted merge showed one conflict here, at the end of the CLEAN section: keep both.
   Check after: the coverage of the audit over this branch's records (`tools/fs131_iru1_audit_block.py --coverage` on a print
   from the merged build), and the other landings' coverage by their generators.
2. `scripts/Assumptions.lean`: the `.condition` entry for `Arith.IsUsablePrime` stays retired (both sides agree).
3. `scripts/axioms-controls.txt`: `main`'s state controls (`imported=120`, `121`) unchanged — this branch adds no imported record.
4. `scripts/assumptions-ledger.txt`: rewritten whole by `./scripts/assumptions.sh --write-ledger` on the merged build; this branch
   adds no `RESTS` or `TAKES` row, so `main`'s rows are expected unchanged.
5. `scripts/vacuity-baseline.txt`: the header's count line, from the merged gate's digest.
6. `ARCHITECTURE.md` and `Proofs.lean`: both sides' rows and import lines (the predecessor's aborted merge: no conflict there).

**The expected counts**, if each landing's records add independently: against the density gate (FS131-IFR2 on `b8cef1f36`,
`data/fs131/ifr2/gate/`), audit records 11,698 + 45 = **11,743**, clean 10,998 + 45 = **11,043**, axiom-free 575, imported 120,
purchases 5; vacuity `declarations=22683+45=22728`, `refutations-skipped=245+1=246`, `sites=1465` and its verdicts unchanged;
assumptions' nine counts `main`'s (`rests=168`), unchanged; dupnames' generated-on-demand count 31, unless the join makes a
shared `eq_n` or `congr_simp`. A difference from these is explained, not absorbed.

### 1.4 The order of work

1. **The merge**: `git merge main`; each gate-input conflict resolved keeping both sides; a conflict in a proof or a statement goes
   to the coordinator first. Commit the merge.
2. **The build**: before it, the name intersection of the two lines' compiled constants; the module cones of each side's changes,
   to choose which of `main`'s build files to copy (`main`'s compiled files are right for a module whose import closure holds no
   module this branch changed; this branch changed `Rigidity/AdmissiblePrime`, so the full copy would replace its build and its
   cone by builds of `main`'s private version — LEAN.md § Building, FS131-ICS1's line); the copy by checksum, a dry run first,
   checksum listings before and after; the build under the slot; a saved stage.
3. **The gate inputs** brought to the merged library (the audit block's coverage, `--write-ledger`, the vacuity header); the
   statement and axiom comparisons against the predecessor's gated prints and `main`'s; then the full gate
   (`data/fs131/iru2/run-gate.sh`, the steps of `data/fs131/clone1/run-gate.sh`) on one commit; `#print axioms` of the head
   statements. A saved stage.
4. **The drafts' counts.** A saved stage. The report.

## Stage 2 — SAVED: the merge and the build

### 2.1 The merge

`git merge main` at `2b53bc133` (`main` had moved past the brief's `5ac6f3ef9`/`d9959820f` by coordinator commits only; later
to `1d37b4177`, none touching `Proofs/`, `Proofs.lean`, `scripts/` or the package files: `git diff --stat b8cef1f36 1d37b4177`
over those paths is empty), committed as **`407d720ac`** (`data/fs131/iru2/merge.log`). Git merged `ARCHITECTURE.md`,
`Proofs.lean` and `scripts/Assumptions.lean` with no conflict: the merged `Proofs.lean` is `main`'s plus this branch's five import
lines, the merged `ARCHITECTURE.md` `main`'s plus this branch's six rows (five new, `Rigidity/AdmissiblePrime` amended), and in
`scripts/Assumptions.lean` both sides had deleted the same `.condition` line. **No proof or statement was in conflict.** Two gate
inputs were, each resolved keeping both sides:

| file | conflict | resolution |
|---|---|---|
| `scripts/Axioms.lean` | one hunk, end of CLEAN: `main`'s FS131-ICS1 and FS131-IFR1 blocks (126 lines) against FS131-IRU1's (50 lines) | both, `main`'s first (`data/fs131/iru2/resolve_both.py`, `resolve-axioms.out`). Insertions only against both parents: the merged file is the branch + 172 lines and `main` + 51; its `#print axioms` lines 11,743 = 11,547 (the base) + 45 (this branch) + 151 (`main`'s two landings) |
| `scripts/vacuity-baseline.txt` | the header's count line (`22564`/`244` against `22683`/`245`) | the expected join, `declarations=22728 refutations-skipped=246 sites=1465` (`main`'s plus this branch's +45 and +1), to be confirmed by the gate's digest |

### 2.2 Names the two lines declare

Before the first build (LEAN.md § Searching — Lean, FS131-LDB1's line): every constant of each line's compiled library, by
module and name (`data/fs131/iru2/lean/AllNames.lean`, run against this branch's build and against `main`'s gated build in the
main tree: 36,678 and 37,101 constants, `names-branch.txt.gz`, `names-main.txt.gz`), intersected by name
(`data/fs131/iru2/collisions.py`): **0 collisions** — no name is declared by a module on one line and by a different module on
the other (`collisions.out`). Each side's within-library doubles are the same 27 generated-on-demand names (`f.eq_1`,
`f.congr_simp`), the join adds none. Modules only on the branch: its five; only on `main`: its eight. Control (`--plant`: a
constant of `Collapse/Density/Headline` added to the branch side under `Rigidity/UsablePrime`): `COLLISION` reported, exit 1
(`collisions-plant.out`).

### 2.3 Which compiled files to copy

`data/fs131/iru2/cone.py` (FS131-IFR2's) on the merged tree: `main`'s changes (`Rigidity/ClassRatio`, `Collapse/Headline` and
its eight new modules) have 30 modules in their cone with the root; this branch's changes (`Rigidity/AdmissiblePrime` — three
lemmas made public, docstrings — and its five new modules) have 29. `main`'s compiled file is right for a module of the first
cone only if the module is outside the second, and this branch's only if it is outside the first:

- **13 modules taken from `main`'s build** (in `main`'s cone, outside this branch's): `Arith/StableAboveUsable`,
  `Plane/TriangularPacking`, `Rigidity/ClassRatio`, `Collapse/Mixing`, `Collapse/Thick`, `PadicPlane/Tower`, `PadicPlane/Values`,
  `Rigidity/CertLinkModels`, `CountCompletion`, `CountDescent`, `CountExtension`, `CountModels`, `CountResidue`
  (`copy-modules.txt`);
- **17 to recompile** (in both cones), predicted: the root, `Collapse/Density/Defs`, `Upper`, `Headline`, `Collapse/Headline`,
  `Selection`, `Slice`, `Instances/SqrtClassValues`, `SqrtFiveClass`, `SqrtFortySevenFive`, `SqrtTwentyThreeCbrtTwo`,
  `UnitRingModels`, `Rigidity/ChainHeadline`, `FourColourPlaces`, `MainClauseFive`, `SqrtClassFive`, `UnitRingEq`
  (`recompile-expected.txt`) — most of `main`'s new modules import `Rigidity/AdmissiblePrime`, so `main`'s builds of them are of
  the private version;
- **9 kept from this branch's build** (this branch's cone only): `Rigidity/AdmissiblePrime`, `NormOneGen`, `UsablePrime`,
  `PlaneComponents`, `Pieces`, `UnitCircle`, `EntropySplitMax`, `ZeroEntropyClosed`, `Collapse/Dichotomy`.

An unrestricted `rsync -a --checksum` (dry run only, `copy-dryrun-full.txt`) would write 139 files of 34 modules: the 28 of
`main`'s cone that `main` has built, and six of this branch's cone (`AdmissiblePrime`, `Pieces`, `UnitCircle`,
`EntropySplitMax`, `ZeroEntropyClosed`, `Dichotomy`), whose replacement by builds of the old source would only force them to
recompile; no file outside the two cones differs in content (133 lines of time-only changes). The copy was restricted to the 13
modules' files (`data/fs131/iru2/copy_build.sh`, LEAN.md § Building, FS131-ICS1's line): `rsync -a --checksum --files-from`, no
`--delete`; dry run 39 files (16 new, 23 changed), the real copy itemized the same 39; the source's SHA-256 over the 39 equal
before and after the copy, and the copies equal to the source (`copy-real.out`, `copy-*.sha`, `copy-rsync.txt`).

### 2.4 The build

The brief's command line (`--mem 8 --cpus 5`, `MEMMAX=8G BATCH=3`; `data/fs131/iru2/build1.sh`): exit 0, "build: OK — 743 of
743 batches, **17 module(s) rebuilt, 0 module(s) with warnings, 18m4s**" (`build1-full.log`, `build1.exit`; Lean's log
`build1-lean.log`). The 17 rebuilt are exactly the predicted 17 (`build1-rebuilt.txt` against `recompile-expected.txt`). The
sources were the same after the build as before it (`build1.sources.md5`, 2,186 files). Then `lake build --no-build Proofs`:
exit 0, "All targets up-to-date (6543 jobs)" (`uptodate-postbuild.log`).

### 2.5 What the merged build holds, read against both gated builds

- **Stored statements** (`tools/fs131_iru2_statements.py`, a copy of FS131-IFR2's comparator with its sides and plants
  replaced; the merged print `data/fs131/iru2/statements-merged.txt.gz` from `data/fs131/iru2/lean/StatementDump.lean`, 33
  modules, FS131-ICO2's dumper with the module list replaced): every constant of FS131-IRU1's gated print (six modules,
  `data/fs131/iru1/statements-after-build3.txt.gz`) and of `main`'s (FS131-IFR2's print of `main`'s gated build, 27 modules,
  `data/fs131/ifr2/statements-merged.txt.gz`) that is not internal is in the merged build with the same kind, flags, stored type
  and, for a definition, the same value with proofs erased: **VERDICT CLEAN, 731 SAME**, 0 PUBLICIZED, 0 VALUE-MOVED, 0
  GENERATED-ADDED (`statements.out`). Stronger: the merged print, every line of it internal constants and full values included,
  is the union of the two gated prints line for line (`statements-fulltext.diff`, empty), and each module's constant count equals
  its gated print's. Six plants, all fired (`statements.out`): a stored type in `Rigidity/UnitRingEq` changed, a constant of
  `Rigidity/UsablePrime` dropped, an unlisted public added to `Instances/UnitRingModels`, a stored type in
  `Collapse/Density/Headline` changed, a constant of `Rigidity/FourColourPlaces` dropped, FS131-IRU1's publicization of
  `exists_integral_primitive` undone (reported as MISSING and, the private copy being new, ADDED). The comparator was first run on
  a synthetic union of the two gated prints: clean, its plants firing (`statements-synthetic.out`).
- **Every record's axioms** (`tools/fs131_iru2_axioms_diff.py`, a copy of FS131-IFR2's; the merged print
  `data/fs131/iru2/axioms-all.txt` from `data/fs131/iru2/lean/AxiomsAll.lean`, sixteen modules, 457 records, no `sorryAx`): every
  record of FS131-IRU1's print (72) and of FS131-IFR2's print of `main` (385) has the same axiom set in the merged build, nothing
  added or missing: **VERDICT CLEAN** (`axioms-diff.out`); every `AXIOMS` line of the merged print is a line of one of the two
  gated prints. Four plants fired: an axiom set changed (`UnitRingEq`), a record dropped (`UsablePrime`), a record added
  (`UnitRingModels`), a `sorryAx` (`Density/Headline`).
- **The audit's coverage**: FS131-IRU1's generator (`tools/fs131_iru1_audit_block.py --coverage`) on the merged print of its six
  modules against the merged `scripts/Axioms.lean`: "COVERAGE OK: every one of the 47 public records is filed under its class"
  (`coverage-iru1gen.out`); FS131-IFR1's and FS131-ICS1's generators on the whole merged print: "COVERAGE OK … 229 public
  records" each (`coverage-ifr1gen.out`, `coverage-ics1gen.out`). Controls: the same coverage run against `main`'s audit file
  (`git show main:scripts/Axioms.lean`) reports this branch's 45 records UNFILED, "STOP: 45 record(s)", exit 1
  (`coverage-plant-mainfile.out`); against that file the generator regenerates exactly the predecessor's 45-record block
  (`audit/regen.out`; its `#print` lines equal `data/fs131/iru1/audit.clean.lean`'s); and its `--plant` on the merged file reports
  BAD, IMPORTED, MISFILED and OPEN, exit 1 (`audit-plant.out`).
- **The head statements**: the predecessor's read-aloud (`data/fs131/iru2/lean/ReadAloud.lean`, its run line changed) on the merged
  build prints exactly what it printed on the gated build 3 — every stored type, and nineteen axiom lists, each
  `[propext, Classical.choice, Quot.sound]` — the files differing only in the slot's admission line (`readaloud.txt` against
  `data/fs131/iru1/readaloud.txt`).
- **The assumptions ledger**: `./scripts/assumptions.sh --write-ledger` under the slot (`write-ledger.log`): exit 0, 279 rows,
  "rows the ledger gains (+) and loses (-)": none; the file equals both the branch's parent and `main`'s.

**A slip, logged as mine**: while checking the rebuilt list (§ 2.4) one command wrote a short list of module names to a file in
`/tmp` and deleted it in the same command (unused; standing rule 2 sends every working file under `data/fs131/iru2/`). Nothing
was lost or read by another job.

## Stage 3 — SAVED: the gate, on `b261d0f12`

### 3.1 The run

`data/fs131/iru2/run-gate.sh` (the steps of `data/fs131/clone1/run-gate.sh`, its log directory and step names changed), run from a
snapshot at `build/iru2/snap/run-gate.sh`, 2026-10-16 23:15:57–23:29:34 UTC, on **`b261d0f12`** — the merge `407d720ac` plus the
stage-2 commit, which adds this job's tools, prints and record and changes no gate input. Logs in `data/fs131/iru2/gate/`, each
with its exit on its last line. The header reads `HEAD=b261d0f12… tracked-modified=0`; at the end "tracked files modified after
the pass: 0". **Every step exit 0:**

| step | result | wall |
|---|---|---|
| uptodate (`lake build --no-build Proofs`) | exit 0 | 4 s |
| `sorry` (narrow scan) | 0 lines | — |
| line-initial `axiom` | 5 lines, as on `main`: the three declared imports and two inside doc comments (`Rigidity/Entropy`, `Sat/Lrat`) | — |
| dupnames / self-test | exit 0, "no name is declared by two modules (31 generated on demand)" / exit 0, all 15 controls | 4 s / 23 s |
| axioms / self-test | exit 0, "11043 clean, 575 axiom-free, 120 imported, 5 declared purchase(s)" / exit 0, every planted fault fired and every partner passed (23 controls; `baseline` and `imported_declared` at `main`'s `imported=120`, `121`, unmoved) | 11 s / 243 s |
| vacuity / self-test | exit 0, `declarations=22728 refutations-skipped=246`, `sites=1465 vacuous=0 stale=0 declared=3 witnessed=40 generic=1420 unknown=2` / exit 0, all 65 controls | 131 s / 128 s |
| assumptions / self-test | exit 0, `axioms=3 rests=168 named=19 inline=14 outside=7 ours=21 open=5 takes=109 mentions=2`, `conditions=40 fails=0` / exit 0, all 33 checks | 123 s / 128 s |
| architecture (`tools/check_architecture.py`) | exit 0, `RESULT: PASS` | — |
| lint (`lake lint --no-build -- --no-build --trace`) | exit 0, 14 linters `(2/2) Passed!`, "Linting passed for Proofs." | 14 s |
| digests (axioms, vacuity, assumptions) | exit 0; the vacuity baseline's header and the assumptions ledger's header **match** (9 of 9 each); stale flags only for the counts recorded in this tree's `CLAUDE.md` (`main`'s, before the density landing's filing: "10914 clean → 11043, 99 imported → 120", "declarations 22566 → 22728, refutations-skipped 243 → 246", "rests 128 → 168") | — |

### 3.2 The counts, against the density gate (FS131-IFR2's, on `b8cef1f36`; `data/fs131/ifr2/gate/`)

Each change is this branch's own, as the predecessor's gate measured it against its base (FS131-ICT3's three-colour gate,
`data/fs131/ict3/gate/`, to `data/fs131/iru1/gate/`): the two lines add independently, nothing lost and nothing counted twice.

| count | density gate (`main`) | this gate | change | the ring's own change (ICT3 → IRU1) |
|---|---|---|---|---|
| audit records | 11,698 | 11,743 | +45 | +45 |
| clean | 10,998 | 11,043 | +45 | +45 |
| axiom-free | 575 | 575 | 0 | 0 |
| imported | 120 | 120 | 0 | 0 |
| declared purchases | 5 | 5 | 0 | 0 |
| assumptions' nine counts | `axioms=3 rests=168 named=19 inline=14 outside=7 ours=21 open=5 takes=109 mentions=2` | the same | 0 | 0 |
| assumptions `conditions` | 40 | 40 | 0 | −1 (`Arith.IsUsablePrime`'s entry, which `main` had already retired: § 2.1) |
| assumptions scan: constants, theorems, formers, hypotheses, unseen | 22,548, 16,593, 461, 27,166, 21,834 | 22,593, 16,637, 461, 27,251, 21,894 | +45, +44, 0, +85, +60 | +45, +44, 0, +85, +60 |
| vacuity `declarations` | 22,683 | 22,728 | +45 | +45 |
| vacuity `refutations-skipped` | 245 | 246 | +1 | +1 (`UnitRingModels.noRamifiedStableDyadic_sqrt47`) |
| vacuity sites, verdicts | `sites=1465`, `vacuous=0 stale=0 declared=3 witnessed=40 generic=1420 unknown=2` | the same | 0 | 0 |
| dupnames | 31 generated on demand | 31 | 0 | 0 |
| lint | 14 linters passed | 14 | — | — |

The vacuity receipts of the two gates differ in their `SCANNED` line alone (every `SITE`, `EVIDENCE`, `DECLARED` and `UNKNOWN`
row equal). The predecessor's count of the six modules' declarations, rerun on the merged build
(`data/fs131/iru2/lean/VacuityNew.lean` → `vacuity-new.txt`), is its own line for line: 47 declarations in the six modules, two of
them `Rigidity/AdmissiblePrime`'s before the branch (so +45), and the one refutation. The audit's records: the merged
`scripts/Axioms.lean` prints 11,743, the base's 11,547 plus this branch's 45 and `main`'s 151, and the audit classes them
11,043 + 575 + 120 + 5.

### 3.3 The head statements' axioms

`#print axioms` on the merged build of every head statement, the ruled drop and the models (`data/fs131/iru2/readaloud.txt`,
§ 2.5): each `[propext, Classical.choice, Quot.sound]` — `unitRing_eq_stableIntegers`, `exists_two_pow_mul_mem_unitRing`,
`exists_eq_add_mul_of_mem_stableIntegers`, `resPi_surjective`, `closure_normOne_eq_top`, `exists_isUsablePrime`,
`nonempty_stablePrime`, `localBound_lt_top`, `reachable_iff_sub_mem_unitRingOver`, `connected_or_infinite_planeOver`,
`connected_planeOver_iff_isEmpty_stablePrime`, `infinite_connectedComponent_planeOver`, `not_connected_planeOver`,
`not_isRamified_of_odd_mem`, `exists_model_galoisField`, and the four `UnitRingModels` theorems — as the predecessor printed
them, the file the same but for the slot's line. Every record of the sixteen modules the two lines brought or changed has the
axiom set its own landing's gate printed (§ 2.5), `main`'s head statements among them.

### 3.4 Negative controls watched red

- The quotation checker's plant (stage 1); the name intersection's plant (§ 2.2).
- The statement comparator's six plants and the axiom comparator's four (§ 2.5), each first on a synthetic union of the two
  gated prints.
- The audit-block generator: coverage against `main`'s audit file, 45 UNFILED, exit 1; its `--plant`, four STOPs (§ 2.5).
- Each self-test's own planted controls in the gate: dupnames 15, axioms 23, vacuity 65, assumptions 33 checks.
- **The vacuity header, planted stale** in two copies (`data/fs131/iru2/plants/`): with `main`'s `22683`/`245` and with the branch's
  `22564`/`244`, each read by `scripts/gate_report.py` against this gate's receipt: both flagged, "RECORDED COUNTS ARE STALE in
  …'s header — update it: declarations 22683 → 22728, refutations-skipped 245 → 246" (and `22564 → 22728`, `244 → 246`). The
  digest flags and does not fail; that is its design.
- Not run: a planted lint fault (as at FS131-IFR2, FS131-IFR1 and FS131-ICO2; the driver's control was watched at FS131-LGT1);
  the audit's state controls planted red (FS131-IFR2 watched them at these same totals, `imported=120`, `121`, which this merge
  does not move).

### 3.5 For the landing

`main` after merging `fs131-kru1` equals `b261d0f12` in `Proofs/`, `Proofs.lean`, `scripts/` and the package files as long as
`main` changes none of them before then (`main` at `1d37b4177` had changed none since `b8cef1f36`). This worktree's
`.lake/build` is the gated build of `b261d0f12`; moving it into the main tree for the landing is the coordinator's.

## Stage 4 — SAVED: the drafts' counts

### Drafts for the front page

FS131-IRU1's drafts (its record § Drafts for the front page), restated against their slots as the slots read on `main` at
`0b7148993` (after the density landing's filing) and with this gate's counts (on `b261d0f12`, `data/fs131/iru2/gate/`). Every slot
quoted below occurs exactly once in its file there, whitespace collapsed (`data/fs131/iru2/drafts_slots.py` → `drafts-slots.out`:
14 of 14; its plant, one digit of the first slot changed, reads 0 and exits 1, `drafts-slots-plant.out`). D1, D2 and D8 carry
this gate's counts, its commit and the slots as they now read; D3–D7 and D9–D11 are the predecessor's text, copied verbatim by
script, their slots unmoved. Nothing else in them is changed.

**D1 — `CLAUDE.md` § Trust ledger**, the sentence "the current audit reads 10998 clean and 5 declared purchases, and 120 imported
(and 575 axiom-free; 11,698 records at FS131-IFR1, the density form of the collapse, 2026-10-16)": replace by

> the current audit reads 11043 clean and 5 declared purchases, and 120 imported (and 575 axiom-free; 11,743 records at
> FS131-IRU1, the ring of unit vectors, 2026-10-16)

This job adds **45 CLEAN records** and nothing else (no purchase, no import, no axiom-free record), so the per-import counts in the
same paragraph do not move. The assumptions step's nine counts are unchanged, `axioms=3 rests=168 named=19 inline=14 outside=7
ours=21 open=5 takes=109 mentions=2` (the slot, present once, stays as it is): the job declares no hypothesis and adds no taker;
the `.condition` entry it retired (`Arith.IsUsablePrime`, concluded by `Rigidity.exists_isUsablePrime`) was retired on `main` too
(FS131-ICS1), and none of the nine counts it.

**D2 — `CLAUDE.md` § The gate**, the vacuity scan's counts: `declarations=22683 refutations-skipped=245 sites=1465` becomes
`declarations=22728 refutations-skipped=246 sites=1465`; the second part stays `vacuous=0 stale=0 declared=3 witnessed=40
generic=1420 unknown=2`. This job's deltas: **declarations +45, refutations-skipped +1, sites +0** (`data/fs131/iru2/vacuity-new.txt`;
the skipped one is `UnitRingModels.noRamifiedStableDyadic_sqrt47`). `scripts/vacuity-baseline.txt`'s header already reads so on
this branch.

**D3 — `LEDGER.md` row 100** (regraded in part; CLG stays [hand]):
- in the **Not claimed** field, replace "whether CLG-g's exception is ever realised; a kernel proof." by "whether CLG-g's exception
  is ever realised; a kernel proof of CLG or of Lemma C.";
- after the **Not claimed** field, before **Prior art**, add: "**Kernel** (since <landing>, on the standard three axioms, no
  hypothesis beyond the scope): Lemma C′ as typed, `Rigidity.unitRing_eq_stableIntegers` (`Rigidity/UnitRingEq`: `R = O′` when
  no stable dyadic prime is ramified); its odd part at every real number field, no scope, `Rigidity.exists_two_pow_mul_mem_unitRing`
  (`2^a·x ∈ R` for every `x ∈ O′`); the onto half of `R/nR ≅ O′/nO′` wherever no stable prime holding `n` is ramified,
  `Rigidity.exists_eq_add_mul_of_mem_stableIntegers`; the local step as a lemma on finite rings,
  `Rigidity.closure_normOne_eq_top` (a finite commutative ring with an involution moving some `θ` by a unit, `θ` plus every fixed
  element a unit, is generated by its norm-one elements; through the Cayley elements, with no counting and no Hensel); the
  model `UnitRingModels.unitRing_eq_stableIntegers_sqrt47`, not trivial there (`stableIntegers_sqrt47_ne_top`)."
- in the **Prior art** field, FS131-PAS1's § 5.4 item 1 (held for this landing by item 1052), unchanged.

**D4 — `LEDGER.md` row 105**, replace "That statement ranges over a type the kernel does not show to be non-empty (a stable prime
exists by Chebotarev), and the splitting itself is not stated" by "That statement's type is non-empty at every real number field
(`Rigidity.nonempty_stablePrime`, [kernel] since <landing>, on the standard three: a usable prime of degree one —
`Rigidity.exists_isUsablePrime`, a prime `q ∤ M`, `q ≡ 3 (mod 4)`, and a maximal ideal of `𝓞 F` with `q` residues, for every
`M ≠ 0` — from the sign change of the minimal polynomial of an integral primitive element at its real root and Kummer–Dedekind,
and the prime inversion above for the stable prime over it, with no Chebotarev and no outside theorem — classical: `[Nagell1969]`
Théorème 3 (every polynomial with a real zero has infinitely many prime divisors `≢ 1 (mod n)`, every `n ≥ 3`; proved in
`[Nagell1951]` Thm 97, after `[Bauer1916]`), at `n = 4`), and the splitting itself is not stated" — the second clause is
FS131-PAS1's § 6.4 item 1, folded in at the place it names; whether Nagell's route is the sign change is not read.

**D5 — `LEDGER.md`, a new row** (number Keryx's; or the same text appended to row 105 if a row is not wanted): "**The components
of the plane over a real number field, in the kernel: for every subfield `F ⊆ ℝ` the unit-distance graph on `F²` is connected or
has infinitely many connected components; over a real number field it is connected exactly when `F(i)` has no stable prime, so,
every real number field having one, it has infinitely many components; and `L(F) < ∞` at every real number field**
(FS-131; FS131-KRU1's plan § 1.3 F2, F7; FS131-IRU1). **[kernel]** on the standard three: `Rigidity.connected_or_infinite_planeOver`,
`Rigidity.connected_planeOver_iff_isEmpty_stablePrime`, `Rigidity.infinite_connectedComponent_planeOver`,
`Rigidity.not_connected_planeOver`, `Rigidity.localBound_lt_top`; the component lemma `Rigidity.reachable_iff_sub_mem_unitRingOver`
(two points of `F²` are joined by a path of unit steps iff their difference lies in `ℤ[U]`, `[Fischer1990b]` §§ 2–3 "stated in
passing"). **Not claimed:** the shape of a component beyond being a coset of `ℤ[U]`; which alternative holds at a subfield of `ℝ`
that is not a number field. **Prior art:** C8's components clause for multiquadratic fields is `[Fischer1990b]`'s Corollary; the
stable prime at every real number field is classical through `[Nagell1969]` Thm 3 (row 105); the dichotomy and the equivalence
with the existence of a stable prime: prior art not yet searched. | `Rigidity/PlaneComponents.lean`, `Rigidity/UsablePrime.lean` |
FS-131 |"

**D6 — `ROADMAP.md` § 3**, delete item 2 ("**Lemma C′** (row 100): … `data/fs131/lch1/ring-scope-lemma-c-prime.lean`.") from the
list of what is left, and add to the section's opening paragraph, after "with its form that takes no hypothesis, `min(χ(F²), 5) =
min(L(F), 5)` (`Rigidity.min_chromaticNumber_five_eq_min_localBound_five`).": "It holds Lemma C′ as typed
(`Rigidity.unitRing_eq_stableIntegers`, row 100), its odd part at every real number field, and the components clause: the plane
over every real number field has infinitely many components (`Rigidity.infinite_connectedComponent_planeOver`), through a stable
prime at every real number field with no Chebotarev (`Rigidity.nonempty_stablePrime`, row 105); so `L(F) < ∞` everywhere
(`Rigidity.localBound_lt_top`)." The appendix's row 100 entry stays (CLG is [hand]); row 105, if listed there for its Chebotarev
clause, leaves it.

**D7 — Proof Atlas grade changes**: row 100, Lemma C′ and its odd form [hand, three derivations] → [kernel]; row 105's existence
clause [hand: "by Chebotarev"] → [kernel] (no Chebotarev); C8's components clause [hand] → [kernel]; `L(F) < ∞` [derived] →
[kernel].

**D8 — `CLAUDE.md` § Frontier**, the "Last updated" line. Replace "Last filed: **the density form of the collapse** (FS131-KFR1,
FS131-IFR1, FS131-IFR2, 2026-10-16: four modules through the gate on `b8cef1f36`, among them `α₁(F²) = max(m₁(ℝ²), ⨆_P r_P)` at
every real number field with no hypothesis, `χ_f(F²) = 1/α_loc(F)`, the fractional collapse, and a finite triangle-free
six-chromatic unit-distance graph. This is row 129's field clause; no value of `χ(ℝ²)` moved.); before it," with the
predecessor's line, its commit and date filled, and the density entry moved to the head of the "before it" list:

> Last filed: **the ring of unit vectors** (FS131-KRU1, FS131-IRU1, FS131-IRU2, 2026-10-16: five modules through the gate on
> `b261d0f12` — Lemma C′ as typed, `R = O′` with no ramified stable dyadic prime, and `2^a·O′ ⊆ R` at every real number field; a
> stable prime at every real number field with no Chebotarev, so the plane over every real number field has infinitely many
> components; on the standard three; rows 100, 105; no value of `χ(ℝ²)` moved); before it, **the density form of the collapse**
> (FS131-KFR1, FS131-IFR1, FS131-IFR2),

(The gate commit is this job's merge, not the predecessor's `ddb765bac`; FS131-IRU2 added to the job list.) **The second half's
slot has moved**: "What the kernel holds, beyond the interval" is now `plans/KERNEL-HOLDS.md`, and the slot
"(`QuadraticPrime.exists_maximal_card_eq`, `…_of_ramified`)" is present once there, followed by "; and with them `χ(ℚ²) = 2`"
as it was in `CLAUDE.md`. The insertion after it is the predecessor's, unchanged: "; **every real number field has a stable
prime** (`Rigidity.nonempty_stablePrime`, no Chebotarev: a usable prime of degree one, classical through `[Nagell1969]` Thm 3), so
`L(F) < ∞` (`Rigidity.localBound_lt_top`) and the plane over it has infinitely many components
(`Rigidity.infinite_connectedComponent_planeOver`, with the dichotomy at every subfield of `ℝ`); **Lemma C′** — the ring the unit
vectors generate is the ring integral at the stable primes when no stable dyadic prime is ramified, and after a power of 2 at every
real number field (`Rigidity.unitRing_eq_stableIntegers`, `…exists_two_pow_mul_mem_unitRing`; row 100; prior art: the general
form not found in print, FS131-PAS1)". `CLAUDE.md` § Where the problem stands keeps a one-line "In short:" list of what
`plans/KERNEL-HOLDS.md` holds; whether this landing gets a clause there (its slot would be after "the collapse, `χ(F²) = χ(ℝ²)` at
uniformly thick fields, ℚ(√635087) and de Grey's field (row 128);", present once) is the coordinator's adaptation, as item 1057
did for the README.

**D9 — `LEAN.md` § Searching — Lean**, new lines (FS131-IRU1):
- "A term-mode `let ⟨P⟩ := h` in a theorem's value stores a public matcher `<thm>.match_1_1` that the vacuity scan counts as a
  declaration (its `isInternal` does not skip it) while a statement dump marks it internal; `h.elim f` stores none
  (`Rigidity.infinite_connectedComponent_planeOver`, FS131-IRU1)."
- "At the pin `Ideal.finiteQuotientOfFreeOfNeBot` is outside the import closure of `Rigidity/AdmissiblePrime` +
  `Arith/PlaceHom` + `Arith/UpperHalf`, and Mathlib's `Finite (𝓞 K ⧸ I)` for maximal `I` (`NumberTheory/NumberField/Ideal/Basic`)
  too; `Nat.finite_of_card_ne_zero` with `← Submodule.cardQuot_apply, ← Ideal.absNorm_apply` and `Ideal.absNorm_eq_zero_iff`
  gives `Finite (𝓞 L ⧸ P ^ m)` with no import (`Rigidity.localBound_lt_top`, FS131-IRU1)."
- "A sign change of an integer polynomial at a simple real root needs no derivative theorem: `g = (X − θ)·h`
  (`mul_divByMonic_eq_iff_isRoot`), `g′(θ) = h(θ)` by `derivative_mul`, and `h`'s sign near `θ` by
  `(h.continuous.continuousAt).eventually (gt_mem_nhds _)` with `Metric.eventually_nhds_iff` (`Rigidity.exists_Ioo_aeval_neg`,
  FS131-IRU1)."
- "`Polynomial.scaleRoots_eval₂_mul` at `Int.castRingHom R` gives the homogeneous value `kⁿ f(x/k)`; `rw [eq_intCast]` (not
  `simp only [Int.coe_castRingHom]`, which leaves a β-redex `(fun x => ↑x) …` that `rw` cannot see) turns the applied cast hom into
  the cast (`Rigidity.scaleRoots_eval_eq`, FS131-IRU1)."
- "The planner's § 3.7 item 6 line (`Mathlib.Data.Fintype.Units` deprecated for `Mathlib.Algebra.GroupWithZero.Units.Fintype`) stands
  as drafted."

**D10 — `plans/POROS-2026-10-13-number-field-findings.md` § 3.3 (C8)**, the planner's § 3.7 item 7, brought to what is proved: "C8
is in the kernel (FS131-IRU1): Lemma C′ as typed and its odd form; the components clause at every real number field, which is
equivalent there to the existence of a stable prime, and that existence is classical (`[Nagell1969]` Thm 3) and kernel-checked with
no Chebotarev."

**D11 — `plans/FS131-KCS1-class-plan.md` § 2.6** (superseded, item 1044's logged correction): a banner "Superseded by
`plans/FS131-KRU1-ring-plan.md` and proved by FS131-IRU1; the map here priced three leaves that were held (FS131-KRU1 § 1.3 F1)."

**The gate's counts for `CLAUDE.md` § The gate and § Trust ledger**, in one place: audit `11743` records, `11043` clean, `575`
axiom-free, `120` imported, `5` declared purchases; assumptions `axioms=3 rests=168 named=19 inline=14 outside=7 ours=21 open=5
takes=109 mentions=2`; vacuity `declarations=22728 refutations-skipped=246 sites=1465`,
`vacuous=0 stale=0 declared=3 witnessed=40 generic=1420 unknown=2`.

### A draft for `LEAN.md` § Building (one line, its slot: after FS131-ICS1's line "A landing whose branch changed a module that
main's newer modules do not import copies only those new modules' build files …")

> - When `main`'s newer modules **do** import the module the branch changed (FS131-IRU2: most of the five-colour and density
>   modules import `Rigidity/AdmissiblePrime`, three lemmas of which the branch made public), take `main`'s compiled files only for
>   the modules in `main`'s changed cone and outside the branch's (13 here), keep the branch's for its own cone (9), and let the
>   build recompile the intersection (17, predicted by `data/fs131/iru2/cone.py` and rebuilt exactly, 18 m 4 s at `BATCH=3` on the
>   laptop); an unrestricted `rsync --checksum` would also have replaced six of the branch's correct builds by builds of the old
>   source (`data/fs131/iru2/copy_build.sh`, `--files-from`). The merged statement print is then the union of the two gated prints
>   line for line (`tools/fs131_iru2_statements.py`; FS131-IRU2).
