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

## Stage 2 — SAVED (FS131-L6A): the three merges; the first half is whole — no declaration rests on `sorryAx`

### 2.1 The merges, each its own commit

Each was made with `git -c merge.conflictStyle=diff3 merge --no-ff --no-commit`, resolved, checked, and then committed as a merge
(two parents each). The trial of each was repeated on the commit it was merged into (`data/fs131/l6a/merge-trial-fs131-w6{f,p,m}.txt`).

| merge | commit | conflicts | merged by itself, both sides having changed it |
|---|---|---|---|
| `origin/fs131-w6f` (`8e81fedd`) into `361a891b` | **`c4bda502`** | `ARCHITECTURE.md` (one hunk, not adjacent additions: § 1.5), `scripts/Axioms.lean` (one hunk, adjacent blocks) | **`FanBridge.lean`** |
| `origin/fs131-w6p` (`43ea4886`) into `0fbdce04` | **`aa8f9312`** | `scripts/Axioms.lean` (one hunk; on the first merge's commit the block FS131-I6D stands at the anchor, so the clean merge of § 1.5's trial is a conflict here) | — |
| `origin/fs131-w6m` (`2e55a2d6`) into `d55f872d` | **`89abcd1c`** | `ARCHITECTURE.md` (one hunk: nine rows of this line after `MapColouring`'s row, theirs' two rows before it and its rewriting), `scripts/Axioms.lean` (one hunk) | `Proofs.lean` |

- **The resolutions, by script** (`tools/fs131_l6a_keepboth.py resolve`): a hunk with no base is two adjacent blocks — ours, a blank
  line, theirs; a hunk with a base is resolved by key (a row of `ARCHITECTURE.md` by its first cell): theirs' order, ours' line where
  theirs left the base's alone, theirs' line where ours did, refused where both changed one row (none was). `scripts/Axioms.lean`'s
  blocks now stand in the order FS131-K6, -K6b, -I6C, -I6E, -I6D, -I6A, -I6B, above the `=== PURCHASED ===` banner; `ARCHITECTURE.md`'s
  fourteen rows in the order `Basic`, `Pinch`, `MapEdge`, `Sq9Map`, `MapColouring`, `Fan`, `FanExamples`, `Curve`, `CurveArc`,
  `ArcContinuation`, `FanArcs`, `FanBuild`, `LocalGraph`, `FanBridge`; `Proofs.lean` holds the fourteen imports in that order.
- **The check, on every path both sides changed — the ones that merged by themselves included**
  (`tools/fs131_l6a_keepboth.py --self-test <file> HEAD <theirs> <base> <path>`; `data/fs131/l6a/keepboth-w6{f,p,m}.txt`, each exit 0):
  no marker; every line stands exactly `ours + theirs − base` times; in `scripts/Axioms.lean` the `#print axioms` lines number
  ours + theirs − base and no name is printed twice.

  | merge | path | non-blank lines | `#print axioms` lines |
  |---|---|---|---|
  | `fs131-w6f` | `ARCHITECTURE.md` | 714 | — |
  | | `scripts/Axioms.lean` | 6,137 | 5,433 = 5,392 + 5,331 − 5,290 |
  | | **`FanBridge.lean`** | 1,381 | — |
  | `fs131-w6p` | `scripts/Axioms.lean` | 6,175 | 5,470 = 5,433 + 5,292 − 5,255 |
  | `fs131-w6m` | `ARCHITECTURE.md` | 716 | — |
  | | `scripts/Axioms.lean` | 6,222 | 5,516 = 5,470 + 5,301 − 5,255 |
  | | `Proofs.lean` | 255 | — |

  Its plants fire on each file beside the faithful run: a line of theirs dropped (LOST), doubled (EXTRA), a marker left in
  (MARKER); on `ARCHITECTURE.md` and `FanBridge.lean` at the first merge, **the base's line put back beside this line's rewriting
  (EXTRA)** — the stale row a plain keep-both would have kept; on `scripts/Axioms.lean`, a record doubled (TWICE) and one dropped
  (COUNT).
- **The index held the merge and nothing else** (`tools/fs131_l6a_mergeindex.py <theirs> <the paths both sides changed>`;
  `mergeindex-w6{f,p,m}.txt`): `MERGE_HEAD` the named tip; no path unmerged; the staged paths exactly those theirs changed since the
  base (23, 32, 28); every one but the named paths taken whole from theirs; the working tree equal to the index. Controls run live,
  each exit 1 before the faithful run's exit 0: the resolved paths not yet staged (UNMERGED, DIRTY: first and second merge); **the
  path that merged by itself not named** (`BOTH sides changed, merged unread: …FanBridge.lean` at the first merge, `Proofs.lean` at
  the third) — so no such path was committed without the three-way check above having read it.
- A merge cannot be committed by path; each was committed whole after that check, and this job's logs went in commits of their own
  by path (`0fbdce04`, `d55f872d`, `2b72f821`).

### 2.2 No statement of any side changed

- **Thirteen of the fourteen files are byte-identical to their owner's tip** (`git diff --quiet`, 19 comparisons, each exit 0;
  `data/fs131/l6a/statements-merges.txt`): `Pinch` = `fs131-w6p`'s; `MapColouring`, `MapEdge`, `Sq9Map` = `fs131-w6m`'s; `CurveArc`,
  `ArcContinuation`, `FanArcs`, `FanBuild`, `FanExamples` = `fs131-w6f`'s; `Curve`, `LocalGraph` = `fs131-w6g`'s and `fs131-w6c`'s;
  `Basic`, `Fan` = every tip's. The fourteenth, `FanBridge`, is the three-way merge of its two halves, line for line (§ 2.1).
- **By script, against each branch's tip and the two planners' tips** (`tools/fs131_l6a_statements.py present <ref> --doc-owners …`
  over every wave file the ref holds): every declaration of `origin/fs131-w6g` (8 files, 280 declarations), `origin/fs131-w6c` (8,
  216), `origin/fs131-w6f` (12, 244), `origin/fs131-w6p` (3, 108), `origin/fs131-w6m` (5, 129), `32f2ab4c` (8, 176) and `3928644b`
  (3, 81) appears verbatim in the joined tree — a theorem's text to its first ` :=` followed by ` :=`, anything else whole.
  **1,234 comparisons, 0 flagged.** In 44 of them the docstring differs from the ref's while the statement is verbatim; each of
  those is, word for word, the docstring the declaration has at its owner's tip (the implementer who proved a leaf added its
  inhabitant line: `FanBridge` 24 across the two halves, `Pinch` 12, `MapColouring` 6, `Curve` 2) — the tool prints them as
  `DOC-OWNER <ref>` and fails on a docstring no owner holds. Its self-test on two one-owner files (`Pinch` against `fs131-w6p`,
  `FanBuild` against `fs131-w6f`): five plants fired (a character of a statement; a disjunct appended to a conclusion; a declaration
  renamed away; one added; a docstring edited), and the owner rule read both ways (a docstring an owner holds: DOC-OWNER; one no
  owner holds: DOC).

### 2.3 The build of the joined line

`data/fs131/l6a/build-merges.log` (`HEAD=2b72f821`, whose Lean sources are `89abcd1c`'s; no tracked file modified): **`build: OK — 466
of 466 batches, 12 module(s) rebuilt, 0 module(s) with warnings, 9m23s`, `exit=0`**. The full log (`build-merges-full.log`) holds
**0 `warning` lines** and ends "Build completed successfully (5817 jobs)"; its five lines with the word `error` are the build
script's own pre-check (`error: target is out-of-date and needs to be rebuilt`, as FS131-I6E's report describes). Rebuilt: `MapEdge`,
`Sq9Map`, `Pinch`, `CurveArc`, `FanExamples`, `MapColouring`, `LocalGraph`, `ArcContinuation`, `FanArcs`, `FanBuild`, `FanBridge`,
`Proofs`. One build after the three merges, not one after each: the three change disjoint Lean files (§ 1.3), so a failure would
have named its side; each merge was checked by script before the next was made.

**This is the first tree to hold the whole chain, and the kernel accepts it**: `FanBridge`'s two halves elaborate as one file with
no name declared twice in it, and the fifteen `sorry` leaves of Stage 1 are gone with nothing in their place.

### 2.4 The receipt that the first half is whole

- **Zero `sorry`**: the gate's narrow pattern over `Proofs/` and `Proofs.lean` reads 0 lines; `grep -c sorry` reads 0 in thirteen
  of the fourteen files and 1 in `LocalGraph` (the word, in its module docstring: "no `sorry` in this module"). Its control is
  Stage 1's tree: fifteen warnings, fifteen lines.
- **The kernel's own list** (`data/fs131/l5/count-modules.lean` on the joined library; `data/fs131/l6a/count-modules-merges.out`):
  the fourteen modules hold **534 declarations, 382 theorems, 7 refutations** — `ArcContinuation` 40 / 16, `Basic` 71 / 32,
  `Curve` 30 / 23, `CurveArc` 18 / 17, `Fan` 57 / 23, `FanArcs` 8 / 8, `FanBridge` 93 / 83, `FanBuild` 14 / 14, `FanExamples`
  44 / 35, `LocalGraph` 46 / 31, `MapColouring` 19 / 10, `MapEdge` 28 / 27, `Pinch` 45 / 45, `Sq9Map` 21 / 18.
- **Every theorem of the fourteen modules, and every name the reports give, on the standard three or a subset**
  (`tools/fs131_l6a_leaves.py`; `data/fs131/l6a/axioms-wave.lean`, its names `axioms-wave.lean.names`, its output
  `axioms-wave-merges.log`, the reading `leaves-merges.txt`, exit 0). The names are not written by hand; four lists are read:
  - **kernel** — the 382 theorems of the kernel's list above;
  - **leaf** — every declaration of the wave's files at the second planner's tip `32f2ab4c` whose text holds `sorry`: **31**, the
    count the planners report (`Pinch` 7, `MapColouring` 1, `Curve` 6, `LocalGraph` 5, `FanBridge` 12);
  - **block** — the `#print axioms` names of the seven blocks of `scripts/Axioms.lean`: FS131-K6 16, -K6b 53, -I6A 37, -I6B 46,
    -I6C 45, -I6D 41, -I6E 57 (295);
  - **wired** — the names the reports list as proved over another line's leaf: FS131-I6E's fourteen (the `WIRED` section of
    `data/fs131/i6e/I6eAxioms.lean`), FS131-I6C's six (its Drafts item 1), and the planners' eight compositions over leaves
    (`TwoColourNhd.mem_essBoundary`, `pinch_interface`, `c11_discs_interface`, `sat_noPar`, `regJFan_of_saturated`,
    `regJFan_iff_singLocallyFinite`, `Fan.sector_unique`, `sq9_regJFan`); FS131-I6D's twenty-six are inside its block.

  **384 distinct names: 383 print exactly `[propext, Classical.choice, Quot.sound]`, one a proper subset (`sq9_pred_ne`, on
  `[propext, Quot.sound]`), none anything else.** Every leaf (31 of 31), every block record (295 of 295), every wired name (28 of
  28). Two block names are definitions that carry proofs, not theorems of the kernel's list (`fanAngle`, `sq9Fan`), each on the
  three. **Exactly one print of the file holds `sorryAx`: the control**, a theorem of that file proved by `sorry`. The reader's
  three plants fire: a leaf's print given `sorryAx` (BAD-AXIOM), a leaf's print dropped (NO-PRINT), the control's print made clean
  (CONTROL).

  So the forty-six records that printed `sorryAx` on their own branches (FS131-I6D's 26, -I6E's 14, -I6C's 6) print the standard
  three on the joined line, and so do the planners' eight. This is iteration's evidence (`lake env lean` on the built tree); the
  audit of every record is the gate's, after the doubled-name check (Stage 5).
- **What the receipt leaves for the gate's registration**: of the 382 theorems, 293 have a record in a block, 21 are on a wired
  list only, and 68 are on neither — each needs its line in `scripts/Axioms.lean` before the records check can pass (Stages 3, 5).

## Stage 2 — SAVED (FS131-L6A)
