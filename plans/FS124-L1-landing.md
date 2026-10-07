# FS124-L1 — the landing: the disc criterion, through the gate and onto `main`

*Record of the landing implementer (de Bruijn, Opus 5.5). Brief: `data/fs124/briefs/FS124-L1-landing.md` on `main` at
`910cb176`. Branch `fs124-wl1`, worktree `.claude/worktrees/fs124-wl1`, cut from `fs124-wk1` at `80ee1983`. Working
files: `data/fs124/l1/`. Tools: `tools/fs124_l1_*.py`; other jobs' tools are run, never edited. The record is written
in stages; each is committed before the next starts.*

## Theorems this phase proved

*The final list, with the gated commit and the axioms as the gate printed them, is at the end of this record
("Theorems this phase proved, final").* This job proves no theorem of its own: it gates and lands FS124-K1's
statements (planner) with FS124-I1's proofs (implementer) — the 57 theorems of `Plane/WeakColouringOn`, `Plane/Radius`
and `Plane/RadiusOutside`, listed one per line with their axioms in `plans/FS124-I1-implementation.md` § Theorems this
phase proved.

## Stage 1 — SAVED (FS124-L1): the readback, what was read, the branch built as given

### The brief's quotations

`tools/fs132_i1_quotes.py` (FS132-I1's checker, run unedited) on the brief, relative sources read under `main`'s
checkout (`--root /home/kooshi/source/lean-dir`, at `910cb176`) and absolute ones as given: **16 quotations, 0
mismatches**, exit 0 (`data/fs124/l1/quotes.out`). By source: `Plane/Radius.lean` 2, `Plane/RadiusOutside.lean` 4,
`Plane/WeakColouringOn.lean` 1 (the three in this worktree), `CLAUDE.md` 4, `LEDGER.md` 1 (row 161, whole),
`plans/FS124-close-inventory.md` 2, `plans/FS132-close-inventory.md` 1, the request file 1. Its self-test plants a
changed word, a wrong source and an empty quotation: each **FIRED**, exit 0 (`data/fs124/l1/quotes-selftest.out`). No
finding about a quotation.

**Two notes on the brief** (neither changes the job):
1. `main` has moved since the brief was written: `1f22daba` → `910cb176` (the brief's own commit) → `20b759b4` at
   16:16 UTC — four commits, `plans/` 4 paths and `data/` 3, nothing else.
2. The brief says the import module "copies ten declarations of the release". The module's own header counts "the
   eight declarations below — the six copied and the two statements"; its docstrings mark seven copied declarations
   (`ProperColoring`, `anglePeriodPositive`, `Angles`, `angularMeasure`, `direction`, the anonymous probability
   instance, `WeakColoring`) and the two axioms' statements. Three counts of one file, by what is counted; the licence
   sentence of stage 4 names no count.

### What was read

Whole: the brief; `plans/STANDING-RULES.md`; `LEAN.md` as on `main` (`910cb176`); `RUNNING.md` § Building and § Make
the gate fail, and watch it fail (to its line 275); the planner's record `plans/FS124-kernel-plan.md` (all five
stages); the implementer's record `plans/FS124-I1-implementation.md` (four stages, twelve drafts); the last landing's
record `plans/FS132-L2-landing.md` (ten stages, its drafts, its slips) and its runner `data/fs132/l2/run-gate.sh`;
inventory items 19 and 24 (`plans/FS124-close-inventory.md`) and 51 (`plans/FS132-close-inventory.md`); the theorem
record's entries C124-RADIUS-GRAPH, -COUNTABLE, -UP, -DOWN, -FIVE and C124-EVERY-DIRECTION
(`plans/FS124-derivation.md` § 1, on `main`); row 161 as the brief quotes it; the three modules of the landing with
every docstring; `CLAUDE.md` § Trust ledger and § The gate **from disk on `main`** (the copy loaded at launch is an
older snapshot: it reads 6533 clean; the disk reads 6910); the header of `Outside/OAI158.lean` (lines 1–90); the
tools this job runs or builds on — `tools/fs132_l2_records.py`, `tools/fs132_l1_records.py`, `tools/fs132_l1_block.py`,
`data/fs132/l2/decls.lean`, `checks.lean`, `run-readback-import.sh`; `scripts/Axioms.lean`'s IMPORTED section on
`main` (lines 156–232).

### The branch as given

`./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`, at `80ee1983`: **exit 0** —
"build: OK — 476 of 476 batches, 4 module(s) rebuilt, 0 module(s) with warnings, 8m51s"; no `declaration uses sorry`
line; the one line of the log holding "warning" is that sentence (`data/fs124/l1/build-0-as-given.log`). The four
rebuilt are the three modules of the landing and the root: the worktree's build is a copy of the last landing's tree,
which holds every other module of this branch and not these.

### The merge, tried before it is made

`git merge-tree --write-tree --name-only` of the branch tip against `origin/main` at `6a721c6a`
(`data/fs124/l1/merge-trial.out`): **exit 1, one conflict — `Proofs.lean`** (each side added import lines after the
same line: `main` the twenty-two of FS-132's landing, the branch its three). `ARCHITECTURE.md` and `scripts/Axioms.lean`
merge automatically. **No conflict in a file under `Proofs/`**, as the brief expected. Since the merge base `596100d4`
`main` changes 23 paths under `Proofs/` (the last landing's modules and its licence copy), `Proofs.lean`, 3 under
`scripts/`, 7 under `tools/`, `ARCHITECTURE.md`, and the files of the coordinator; the branch changes 3 under
`Proofs/`, `Proofs.lean`, `scripts/Axioms.lean`, `ARCHITECTURE.md`, `data/` and `plans/`.

### Built for the later stages (nothing run yet)

`data/fs124/l1/decls.lean` (the kernel's list of the three modules' constants; after FS132-L2's dumper);
`tools/fs124_l1_records.py` (every declaration of the landing in a block, each filed on what it rests on, with
fifteen plants; after FS132-L2's, whose claim was the other kind — no record on an import);
`data/fs124/l1/checks.lean` (the statements as stored, their axioms, the halves proved apart, the models as terms);
`data/fs124/l1/run-readback-import.sh` (FS132-L1's runner as FS132-L2 ran it, the output directory changed);
`data/fs124/l1/run-gate.sh` (the pass, after FS132-L2's runner).

## Stage 2 — SAVED (FS124-L1): `main` merged in

**Tried again on the committed tree** (`data/fs124/l1/merge-trial-2.out`, `f8917640` against `origin/main` at
`98738509`, which had moved once more — FS-136's and the inventory's commits, `plans/` and `data/` only): the same one
conflict, `Proofs.lean`.

**Made**: `git merge --no-ff --no-commit 987385099934894359bc9203dfca0b9c7a582368` (the hash, never the ref;
`data/fs124/l1/merge.out`) — `ARCHITECTURE.md` and `scripts/Axioms.lean` merged automatically; **one conflict,
`Proofs.lean`, resolved by keeping both sides' import lines**: `main`'s twenty-two (the last landing's modules), then
the branch's three. Checked: the resolved file differs from `main`'s by exactly the three added lines and from the
branch's by exactly the twenty-two; 308 import lines, none twice. **No conflict in a file under `Proofs/`.** Merge
commit **`eadcf27b`** (parents `f8917640`, `98738509`).

**The two files git merged by itself, read**: `ARCHITECTURE.md` — `main`'s rows of the last landing stand in § 3.11
and § 3.12, the branch's § 3.13 after them, no heading twice; `scripts/Axioms.lean` — under IMPORTED the branch's five
records follow FS132-I1's ten; under CLEAN the branch's block of 52 follows FS131-L8A's and `main`'s four blocks of the
last landing follow it; 7,010 `#print axioms` lines = `main`'s 6,953 + 57.

**Built** (`data/fs124/l1/build-1-merged.log`): **exit 0** — "build: OK — 480 of 480 batches, 1 module(s) rebuilt, 0
module(s) with warnings, 9m6s" (the root: its import list changed; every other module's compiled file is the one the
last landing's tree or stage 1's build made).
