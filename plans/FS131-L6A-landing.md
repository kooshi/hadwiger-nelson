# FS131-L6A — wave 6's first landing: the five proved branches joined, the ruled tidies, `main` merged, the gate (de Bruijn, the implementer)

*Brief: `data/fs131/briefs/FS131-L6A-wave6-land.md` (on `main`). Branch `fs131-w6j`, worktree `.claude/worktrees/fs131-w6j`, cut from
`fs131-w6g` at `b3b67f23`. Started 2026-10-06 17:20 UTC. Logs and working files: `data/fs131/l6a/`.*

## Theorems this phase proved

*Filled at each saved stage; the final list is the section "Theorems this phase proved, final" at the end of this file.*

## Stage 1 — SAVED (FS131-L6A): the readback, the build as given

### 1.1 The brief's quotations (standing rule 3)

By script, `tools/fs131_l6a_quotes.py --self-test <brief> <main's tree>` (the last landing's reader under this job's name): it reads every
`> quote` / `> — source:` pair of the brief and counts the quote's verbatim occurrences in the named file. **Seventeen of seventeen pairs
match, each exactly once** (`data/fs131/l6a/quotations.txt`, exit 0): `CLAUDE.md` § The standard of evidence (1) and § The gate's count
line (1), read from disk on `main`; `plans/FS131-close-inventory.md` items 516, 517, 530, 539, 540, 544, 491, 492, 535 (9); `Pinch.lean` on
`fs131-w6p`, `pinch`; `MapColouring.lean` on `fs131-w6m`, `sat_inP`; `LocalGraph.lean` on this branch, `local_graph`; `FanBridge.lean` on
`fs131-w6f`, `fan_of_isolated` and `regJFan_of_saturated`; `FanBridge.lean` on this branch, `sector_alone` (6). The script's two plants
fire beside the faithful run: one character of a quote changed reads MISSING; a source that does not exist reads NO-SOURCE. **No mismatch.**

As the launch line said: the copy of `CLAUDE.md` my session was given reads the gate's counts as they stood two landings ago (13,386
declarations, 5,525 clean); the file on disk on `main` reads the brief's line (13,767; 5,783 clean, 5,809 records). The counts I reconcile
against are the file's on disk.

### 1.2 What was read, and how far

- The brief; `plans/STANDING-RULES.md`; `LEAN.md` (on `main`) whole; `RUNNING.md` § Building and § Make the gate fail, whole.
- Inventory items 516, 517, 530, 531, 539, 540, 544, 545, 491, 492, 419, 535, each whole.
- The five implementers' reports, each whole: `data/fs131/reports/FS131-I6C.md`, `-I6E.md` (this branch), `-I6D.md` (`fs131-w6f`), `-I6A.md`
  (`fs131-w6p`), `-I6B.md` (`fs131-w6m`). Of their records: the theorem lists, the last stage and the drafts of each — I6E's
  (`plans/FS131-I6E-implementation.md`: its list, Stage 6, Drafts), I6C's (Drafts; What is left), I6D's (Stage 4; What is left; Drafts),
  I6A's (Drafts), I6B's (§ 2.6 names; Drafts). Their middle stages by headings only.
- The planners' record `plans/FS131-w6-kernel-plan.md` (this branch): its theorem list, Stage 7 (the hand-off, § 7.3 vacuity and
  inhabitants), Stage 12 (the split by file, § 12.2 vacuity and inhabitants, § 12.4, § 12.5), in full; Stages 1–6 and 8–11 by headings,
  and by section where a draft below cites one.
- The last landing's record `plans/FS131-L10A-landing.md` (on `main`), whole, with its three runners `data/fs131/l10a/run-build.sh`,
  `run-gate.sh`, `run-pass.sh` and the tools it names (`tools/fs131_l10a_*.py`, `tools/fs131_l5_records.py`, `data/fs131/l5/count-modules.lean`).

### 1.3 The branch tips, as fetched (2026-10-06 17:25 UTC)

`origin/fs131-w6j` = `origin/fs131-w6g` = `b3b67f23` (this tree's `HEAD`; it holds `origin/fs131-w6c` = `d62406a2`); `origin/fs131-w6f` =
`8e81fedd`; `origin/fs131-w6p` = `43ea4886`; `origin/fs131-w6m` = `2e55a2d6` — the tips the brief names. `origin/main` = `e79fb1b2`. Merge
bases with this tip: `fs131-w6f` — `32f2ab4c` (the second planner's tip); `fs131-w6p` and `fs131-w6m` — `3928644b` (the second planner's
Stage 9); `main` — `a917d57f` (wave 5's landing). **`main` holds no file under `Proofs/HadwigerNelson/Plane/Saturated/`**: all fourteen
modules arrive with this landing.

What each side changed since its base, outside `plans/` and `data/` (`git diff --name-only`):

| side | Lean files | registry files |
|---|---|---|
| this line since `32f2ab4c` | `Curve`, `LocalGraph`, `FanBridge` | `ARCHITECTURE.md`, `scripts/Axioms.lean` |
| `fs131-w6f` since `32f2ab4c` | `FanBridge`, `FanExamples`; new `CurveArc`, `ArcContinuation`, `FanArcs`, `FanBuild` | `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean` |
| `fs131-w6p` since `3928644b` | `Pinch` | `scripts/Axioms.lean` |
| `fs131-w6m` since `3928644b` | `MapColouring`; new `MapEdge`, `Sq9Map` | `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean` |
| this line since `3928644b` | `Curve`, `Fan`, `FanBridge`, `FanExamples`, `LocalGraph` | `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean` |

**One Lean file is changed by two sides: `FanBridge.lean`** (this line's five `Fan` lemmas, `fs131-w6f`'s seven leaves of the existence
half). Every other Lean file has one owner.

### 1.4 The build as given

`data/fs131/l6a/build-asgiven.log` (runner `data/fs131/l6a/run-build.sh asgiven`; `HEAD=b3b67f23`, no tracked file modified): `build: OK
— all 1804 modules already up to date, nothing built, 3 module(s) with warnings`, `exit=0`. The warnings replayed are fifteen, every one
``declaration uses `sorry` `` (`build-asgiven-full.log`: 15 `warning` lines, 15 of that kind): `FanBridge.lean` 7 (lines 67–136, the
existence half), `Pinch.lean` 7, `MapColouring.lean` 1 — the fifteen leaves the brief counts, each proved on a branch about to be merged.
The gate's narrow pattern over `Proofs/` reads the same fifteen lines (`sorry-narrow-asgiven.txt`).

### 1.5 The trial merges, before any is made

`git merge-tree --write-tree --name-only HEAD origin/<branch>` on this tip, nothing checked out (`data/fs131/l6a/merge-trial-<branch>-on-tip.txt`):

| branch | conflicts on this tip | merged by itself, both sides having changed it |
|---|---|---|
| `fs131-w6f` | `ARCHITECTURE.md`, `scripts/Axioms.lean` | **`FanBridge.lean`** |
| `fs131-w6p` | none | `scripts/Axioms.lean` |
| `fs131-w6m` | `ARCHITECTURE.md` | `Proofs.lean`, `scripts/Axioms.lean` |
| `main` | `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean` | — |

No Lean file under `Proofs/` conflicts, as the brief's trial found. One thing the trial shows that "adjacent additions: keep every side"
does not cover: **the `ARCHITECTURE.md` hunk of `fs131-w6f` is not two adjacent additions.** This line rewrote the row
`Plane/Saturated/LocalGraph` (its imports cell, FS131-I6C); `fs131-w6f` added four rows above it and rewrote the row
`Plane/Saturated/FanBridge` (its imports cell). A plain "ours, then theirs" would leave the two rewritten rows in twice, once stale. The
resolution is by row: the four new rows, this line's `LocalGraph` row, theirs' `FanBridge` row. My check is written for that
(`tools/fs131_l6a_keepboth.py`): a line stands in the merged file exactly `ours + theirs − base` times, so a stale copy of a rewritten row
reads EXTRA. Each trial is repeated on the commit it will be merged into, before the merge.

### 1.6 What I may and may not change

Mine: the merges' files; in the fourteen modules of `Proofs/HadwigerNelson/Plane/Saturated/`, the ruled tidies of the brief's item 3
(two duplicate lemmas deleted and their three uses repointed; the docstring sentences the join makes false) and nothing else;
`Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`; `scripts/Vacuity.lean`, `scripts/vacuity-controls.lean`, `scripts/vacuity.sh`
as the scan's own procedure asks, `scripts/vacuity-baseline.txt` on the coordinator's word only (its header's count lines are the
scan's own procedure); this record; `tools/fs131_l6a_*.py`; `data/fs131/l6a/`; the report; `main` by the fast-forward push alone. Not
mine: any statement; `SeparatesAt`'s second clause; the hypotheses the implementers found unread; `fanAngle` / `polarAngle` and
`MapEdge`'s restated puncture lemma (listed in the drafts, ruling 544 (d)); the wave's four later modules; `CLAUDE.md`, `LEDGER.md`,
`LEAN.md`, `BIBLIOGRAPHY.md` (drafted here); a new `axiom`; `native_decide`.

## Stage 1 — SAVED (FS131-L6A)
