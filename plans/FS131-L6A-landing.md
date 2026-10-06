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

## Stage 3 — SAVED (FS131-L6A): the ruled tidies — two duplicate lemmas folded into their twins, twenty records entered, the stale sentences corrected

### 3.1 What was ruled, and what changed (the brief's item 3; rulings 544, 540 (a), 517 (b))

Every edit is an exact text replacement that must match once (`data/fs131/l6a/tidy.py`: `--check` first, then the write;
`tidy-applied.txt`), with one more of the same kind after it (`tidy2.txt`). All went through as ruled; none is deferred. Commit
`06568a43`, on Stage 2's tip `17657aaf`.

**(i) The duplicate.** `polarRegion_isOpen` and `polarRegion_isPreconnected` (FS131-I6E's, `FanBridge`) are deleted — 34 lines, the
two theorems with their docstrings — and their three uses now cite FS131-I6D's `isOpen_polarRegion`, `isPreconnected_polarRegion`
(`FanBuild`, which `FanBridge` imports since the first merge): in `Fan.isOpen_cell`, `Fan.isPreconnected_polarRegion_of_le`,
`Fan.exists_isOpen_subset_cells`. Their two audit records are gone from block "FS131-I6E". No branch of the wave's later modules
cites either name (`git grep` on `origin/fs131-w6`, `-w6l`, `-w6z`, `-w6k`: none).

**(ii) The records.** Appended to their blocks of `scripts/Axioms.lean`, each under a `--` line saying over what it was proved:
FS131-I6C's six (`HasTwoDiscsAt.one_le_norm_sub`, `.norm_sub_le`, `.normal_unique`, `local_graph`, `AeColouring.local_graph`,
`sq9_exists_isInterfaceChart`) and FS131-I6E's fourteen (`Fan.exists_unitCurve_branch`, `.exists_twoColourNhd_branch`,
`.dist_eq_one_of_common_contact`, `.contacts_of_no_common`, `.branch_outside_discs`, `.branch_contacts`,
`.exists_contact_nextDir`, `.exists_contact_dir`, `.sector_constraints`, `.horn_false`, `.false_of_horn_next`,
`.false_of_horn_dir`, `.sector_alone`, `.sector_unique`). `#print axioms` lines: 5,516 − 2 + 20 = **5,534**. Three block
headings say what is now true: FS131-I6E's ("the fourteen records … are the block's last section, entered at the join"),
FS131-I6D's ("re-read at the join, FS131-L6A: nothing beneath them is open", in place of "until `fs131-w6c` joins, the records
that read `Curve`'s or `LocalGraph`'s leaves print `sorryAx` on this branch"). FS131-I6D's forty-one records were re-read in
Stage 2's receipt: each on exactly the three.

**(iii) The sentences the join makes false**, base text otherwise intact (`data/fs131/l6a/tidy-docdiff.txt` is the whole diff of
the Lean files' doc text):

| where | was | now |
|---|---|---|
| `Fan.lean`, module docstring | "by FS131-E8-BRIDGE ([hand], one mind, until `Plane/Saturated/FanBridge` lands)" | "by FS131-E8-BRIDGE (kernel-checked in `Plane/Saturated/FanBridge`)" |
| `FanBridge.lean`, module docstring | "each entry **[hand], one mind, kernel pending** until this module lands" | "each entry kernel-checked in this module (no `sorry`)" |
| `Fan.sector_alone`, docstring | "by FS131-E8-BRIDGE ([hand], one mind, until `fan_of_isolated` is proved)" | "by FS131-E8-BRIDGE (kernel-checked: `fan_of_isolated`)" |
| `LocalGraph.lean`, module docstring | "§§ 3.1, 3.5 ([hand], one mind, until this module lands)"; "`local_graph` rests on two leaves of `Plane/Saturated/Pinch`" | "§§ 3.1, 3.5 (kernel-checked in this module)"; "… rests on two theorems of `Plane/Saturated/Pinch`" |
| `Pinch.lean`, module docstring (FS131-I6A's correction owed; ruling 517 (b)) | three rows marked "Proved.", silence on the rest | one paragraph added: "**Every row above is proved; the module holds no `sorry`**: …" naming the seven leaves and FS131-I6A |
| `MapEdge.lean`, module docstring | "a second line may hold the same facts under other names until the wave's join" | "giving each one home with the same facts of other modules is a tidy after wave 6's first landing" |

The first three are the three the fourth implementer lists; the fourth is the same phrase in `LocalGraph`, which its list does not
name; no module docstring of the fourteen says "skeleton" (the word stood in `ARCHITECTURE.md`'s rows only).
**`ARCHITECTURE.md`**: the rows of `Pinch`, `Curve`, `LocalGraph` and `FanBridge` read "**FS-131 wave 6** (jobs …: every leaf
proved, no `sorry`)" in place of "**FS-131 wave 6, skeleton**", each with the implementers' drafted clauses (FS131-I6C's Drafts
item 3; FS131-I6E's item 1 without the two deleted names; FS131-I6A's children); "the leaves" and "rests on … leaves" in the rows of
`Curve`, `CurveArc` and `FanArcs` read "proved by FS131-I6C" and "theorems".

**(iv) Nothing else.** `SeparatesAt` keeps its second clause; DELTA's `IsOpen W`, `IsolatedAt.pos` in `gamma` and `beta`, and (H2)'s
unread clauses stay in their statements; `fanAngle` beside `polarAngle` and `MapEdge.isPreconnected_puncturedBall` beside
`isPreconnected_ball_diff_singleton` are left where they are (drafts, item 9).

### 3.2 Exactly the ruled changes, by script

- **`tools/fs131_l6a_tidyshape.py --self-test 17657aaf`** (`data/fs131/l6a/tidyshape.txt`, exit 0): (a) the two deleted lemmas'
  statements at `17657aaf`, the name alone substituted, are `FanBuild`'s two statements — the same binder for binder; (b) neither
  old name occurs under `Proofs/`, in `scripts/Axioms.lean` or in `ARCHITECTURE.md`; (c) outside the deleted block, the code lines
  of `FanBridge` that differ are exactly three, each the old line with the one name replaced, in the three declarations named
  above; (d) no other Lean file of the fourteen has a changed line outside a doc comment; (e) the records changed by the two
  removed and the reports' twenty added, each in its own job's block, none printed twice. Four plants, each fired with its word:
  a use left on the old name (OLD-NAME), a binder changed at the comparison (SHAPE), a proof line changed in another file (CODE),
  a record no report lists (RECORDS).
- **`tools/fs131_l6a_statements.py delta 17657aaf --removed <the two> --docs …Fan.sector_alone`** over the fourteen files
  (`statements-tidies.txt`): 423 declarations before, 421 after; **statements changed: none; removed: exactly the two; added: none;
  a docstring changed with its statement unchanged: exactly `Fan.sector_alone`.** PASS.
- **`tools/fs131_l6a_archrows.py --self-test`** (`arch-rows.txt`, exit 0): the fourteen rows exist, one each; none says
  "skeleton", "leaves" or `sorry` outside "no `sorry`"; every backticked declaration name of a row's description is declared — 218
  in the row's own module, 9 elsewhere in the wave, 7 elsewhere in the library, **0 missing**. Two plants fired (a cited name
  misspelt: MISSING; a row saying "skeleton": SKELETON). The check's first run read five sibling-module names and an abbreviated
  suffix (`_of_im`) as missing declarations — its fault, repaired before any result was read from it — and found one stale word of
  mine to correct (`CurveArc`'s "beyond `Curve`'s leaves"). `tools/check_architecture.py`: `RESULT: PASS`, exit 0 (`arch-tidy.txt`).
- **Iteration, before the commit**: `FanBridge.lean` with the three uses repointed elaborates (`lake env lean`, both
  auto-implicit options off, under the slot: exit 0, no message; `iter-fanbridge-tidy.log`). Iteration, not evidence: the build of
  the tidied files is Stage 4's, with `main` merged — the tidies change three code lines, in one file, and that file was elaborated.

## Stage 3 — SAVED (FS131-L6A)

## Stage 4 — SAVED (FS131-L6A): `main` merged in (`6272aeb2`); the joined tree builds; no doubled name

- **The trial, before the merge** (`git merge-tree --write-tree --name-only HEAD origin/main` on Stage 3's commit;
  `data/fs131/l6a/merge-trial-main.txt`; `origin/main` at `ac2e84ea`, merge base `a917d57f`, wave 5's landing): **three conflicts —
  `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean`** — the three the brief foresaw, and the only paths both sides changed
  since the base. `main` changed 20 files under `Proofs/` since the base (the example maps, wave 10's four, eleven of
  `Plane/ValidMap`), this line the fourteen wave files; **no Lean file under `Proofs/` conflicts**.
- **The merge `6272aeb2`** (`git -c merge.conflictStyle=diff3 merge --no-ff --no-commit`, resolved, checked, committed; two
  parents). All three hunks are adjacent additions with no base. `scripts/Axioms.lean`: `main`'s blocks in their place and wave
  6's seven after them, above the `=== PURCHASED ===` banner (`tools/fs131_l6a_keepboth.py resolve --theirs-first`).
  `ARCHITECTURE.md` and `Proofs.lean`: `main`'s lines, then this line's, **with no blank line between** — the table's rows and the
  import list stay contiguous (`data/fs131/l6a/resolve_join.py`, which refuses a hunk with a base). The three-way check on each
  (`keepboth-main.txt`, each exit 0, its plants fired): `ARCHITECTURE.md` 725 non-blank lines, `Proofs.lean` 264,
  `scripts/Axioms.lean` 6,871 with `#print axioms` lines **6,122 = this line's 5,534 + `main`'s 5,809 − the base's 5,221**; no
  name printed twice. Against `main`'s files (`git diff --numstat ac2e84ea`): `ARCHITECTURE.md` 14 added, 0 removed; `Proofs.lean`
  14, 0; `scripts/Axioms.lean` 323, 0.
- **The index held the merge and nothing else** (`tools/fs131_l6a_mergeindex.py ac2e84ea ARCHITECTURE.md Proofs.lean
  scripts/Axioms.lean`; `mergeindex-main.txt`): 519 staged paths, 3 changed by both sides, 516 taken whole from `main`; PASS. Its
  control on this merge: with `Proofs.lean` not named, `BOTH sides changed, merged unread: Proofs.lean`, exit 1. **One thing the
  check caught that was not a plant**: between two of its runs `origin/main` moved from `ac2e84ea` to `309f4de5` (another
  session's fetch; the worktrees share refs), and the run that named the ref read `WRONG-MERGE` and two `NOT-THEIRS` lines. The
  merge is of `ac2e84ea`; from there the check names the commit by hash. What `main` added after `ac2e84ea` is under `plans/`
  alone (Stage 6 merges it).
- **After the merge the Lean tree is `main`'s plus the wave**: `git diff --name-only ac2e84ea HEAD -- Proofs Proofs.lean
  lakefile.toml lake-manifest.json lean-toolchain` names `Proofs.lean` and the fourteen wave files and nothing else; the wave files
  are unchanged from Stage 3's commit `06568a43`.
- **The build tree.** `main`'s compiled modules were copied in from the idle landing worktree of wave 10 before the build
  (`rsync -a --update ../fs131-w10l/.lake/build/ .lake/build/`; `data/fs131/l6a/rsync-w10l-build.txt`: 304 files written, 38 of
  them `.olean`, 72 new, none under `Plane/Saturated`; that tree is at `b344490e`, clean, its Lean inputs `main`'s — `git diff
  --name-only b344490e ac2e84ea -- Proofs Proofs.lean lakefile.toml lake-manifest.json lean-toolchain` is empty — and no process
  had its working directory there). `.lake/build` stays this worktree's own directory. Lake checks each module's trace by hash, so
  a copied file that did not match its source would have been rebuilt.
- **The build of the joined tree** (`data/fs131/l6a/build-main.log`, `HEAD=78311727`, whose Lean sources are `6272aeb2`'s; no
  tracked file modified): **`build: OK — 469 of 469 batches, 12 module(s) rebuilt, 0 module(s) with warnings, 9m10s`,
  `exit=0`**; the full log (`build-main-full.log`) holds **0 `warning` lines** and ends "Build completed successfully (5828
  jobs)". The twelve rebuilt are the tidied wave modules, their dependents and the import surface: `MapEdge`, `Fan`, `Pinch`,
  `CurveArc`, `FanExamples`, `MapColouring`, `LocalGraph`, `ArcContinuation`, `FanArcs`, `FanBuild`, `FanBridge`, `Proofs`. So
  this is also the build of Stage 3's tidies: `FanBridge` compiles against `FanBuild`'s two lemmas, and no wave module broke under
  `main`'s changes (`Basic`, `Curve`, `Sq9Map` were not rebuilt: nothing upstream of them moved).
- **`./scripts/dupnames.sh` on the joined tree, before anything else** (`data/fs131/l6a/dupnames-joined.log`, `exit=0`):
  **"dupnames: OK — no name is declared by two modules (23 generated on demand, listed above)"** — `main`'s own count of generated
  names. The join of five lines and `main` made no doubled name: the one duplicate pair the lines held was renamed by its
  author before any push and folded in Stage 3.
- **The kernel's own list** (`data/fs131/l5/count-modules.lean` on the joined library; `count-modules-joined.out`): `TOTAL
  declarations=14299 refutations=199 modules=1817 theorems=9336` — `main`'s 13,767 declarations, 192 refutations, 1,803 modules
  and 8,956 theorems (`data/fs131/l10a/count-modules-first.out`) plus the wave's fourteen modules: **532 declarations, 7
  refutations, 380 theorems** (Stage 2's 534 and 382 less the two folded lemmas); no theorem of `main` is gone.

## Stage 4 — SAVED (FS131-L6A)

## Stage 5 — SAVED (FS131-L6A): the full gate on `7e67af3b` — green at every step, in one pass

**The gated commit is `7e67af3b`**: Stage 4's tree (`main` at `ac2e84ea` merged in) with the registrations of § 5.1. Runner
`data/fs131/l6a/run-pass.sh first` → the build, the kernel's list, `run-gate.sh first` (the last landing's runner with its log
directory changed), then the two reconciliations against `main`'s gated receipts (`data/fs131/l10a/*-first.*`) and the digests —
each step under the slot, each driver log ending in its exit status. `data/fs131/l6a/run-gate-first.head` records
`HEAD=7e67af3b…` and **no tracked file modified**; `run-pass-first.out` reads exit 0 at every step. One pass: nothing was repaired
between a red and a green.

### 5.1 What this job registered, by the gate's own procedures

- **`scripts/Axioms.lean`**: a block "FS131-L6A" of **52 records** — every hand-written theorem of the fourteen modules that the
  planners' and the five implementers' blocks did not list (`ArcContinuation` 11, `Basic` 7, `CurveArc` 6, `Fan` 4, `FanArcs` 4,
  `FanBridge` 1, `FanBuild` 6, `FanExamples` 13). The list is read from the kernel's own list of the library's theorems, not from
  the source (`tools/fs131_l6a_register.py` on `data/fs131/l5/count-modules.lean`'s two outputs; `register-before.txt`,
  `register-after.txt`: MISSING 52 → 0, STALE 0, FOREIGN-MODULE 0; its self-test: a record removed reads MISSING, a record naming
  nothing in a wave block reads STALE). `#print axioms` lines: 6,122 + 52 = **6,174** = `main`'s 5,809 + the wave's 365 (363
  hand-written theorems and two definitions that carry proofs, `fanAngle` and `sq9Fan`).
- **`scripts/Vacuity.lean`**: the entry "Wave 6's first half (FS131-L6A …)", by the scan's procedure. **No new carrier IN**; no
  name added to `trackedProps`, no control planted, `scripts/vacuity-controls.lean` and `scripts/vacuity.sh` untouched. The
  census (`data/fs131/l6a/census.lean`, wave 5's with its scope changed; `census.out`) lists **twenty-seven hypothesis-formers** in
  the fourteen modules: none has an unconditional `¬ P …` at a closed instance, none an `IsEmpty`, and none a binder site at a
  closed instance (`refut=0`, `isEmpty=0`, `closedSites=0` on all 27) — so for none could step (3)'s `VACUOUS` control be planted.
  The seven the brief names: `AeColouring.Fan` (51 sites), `IsUnitCurve` (33), `TwoColourOn` (16), `ArcSetting` (12), `IsArcOf`
  (9), `HasArcChart` (1), `IsInterfaceChart` (0: it stands in conclusions only) — each OUT, with its inhabitant named in the entry.
  - **`AeColouring.Fan`, said apart** (asked of the coordinator mid-job; ruled OUT, its reply of 2026-10-06): it is the one former
    of the wave for which "does one exist" is a theorem rather than a construction (`fan_of_isolated`), so step (1)'s first clause
    alone would enter it; no theorem of the library refutes a fan at a concrete point, so no `VACUOUS` control can be planted.
    Entered, it would add 51 `GENERIC` sites and one `WITNESSED` (`sq9Fan`). The entry names `sq9Fan` and says when to register it.
- **`scripts/vacuity-baseline.txt`**: the header's two count lines, from `scripts/gate_report.py header`, **on the coordinator's
  word** (asked mid-job, the brief reserving this file; its reply: "update the two count lines … no entry added, as the last
  landing did"). **No entry added.**
- `scripts/axioms-controls.txt`: unchanged — the landing declares no axiom and no import, so the controls' counts are the
  library's still, and the self-test is green as it stands.
- `ARCHITECTURE.md`, `Proofs.lean`: Stage 3's rows; the merges' fourteen imports.

### 5.2 The steps, each saved log read

| step | result | log (`data/fs131/l6a/`) |
|---|---|---|
| build | `build: OK — all 1819 modules already up to date, nothing built, 0 module(s) with warnings`, exit 0; the full build of these Lean sources is Stage 4's: 469 of 469 batches, "Build completed successfully (5828 jobs)", **0 `warning` lines** | `build-first.log`; `build-main.log`, `build-main-full.log` |
| `sorry` | narrow pattern: **0** lines; `\bsorry\b`: 8, all prose — the five `main` holds (`Packed` l. 266, `Plane/Cover` l. 33, `Plane/CoverExamples` l. 13 and 6541, `BendStep` l. 345) and three module docstrings of the wave that say "no `sorry`" (`Pinch` l. 20, `LocalGraph` l. 34, `FanBridge` l. 9) | `sorry-narrow-first.txt`, `sorry-wide-first.txt` |
| doubled names, **before the audit** | **"dupnames: OK — no name is declared by two modules (23 generated on demand, listed above)"** | `dupnames-first.log`, `receipt-dupnames-first.log` |
| its self-test | "OK — all 15 controls behaved: every planted fault fired, and every partner passed." | `dupnames-selftest-first.log` |
| axioms | **"axioms: OK — 6148 clean, 17 axiom-free, 4 imported, 5 declared purchase(s)"**; "audited: 6174 records" | `axioms-first.log`, `receipt-axioms-first.log` |
| its self-test | "OK — every planted fault fired, and every partner passed." (23 controls) | `axioms-selftest-first.log` |
| vacuity | **"vacuity: OK"**; `declarations=14299 refutations-skipped=199`, `sites=1269 vacuous=0 stale=0 declared=3 witnessed=38 generic=1226 unknown=2`, `untelescoped=0`; baseline header "match (9 of 9 compared)" | `vacuity-first.log`, `receipt-vacuity-first.log` |
| its self-test | "OK — all 65 controls behaved: every one fired, and the silent ones stayed silent." | `vacuity-selftest-first.log` |
| architecture | "RESULT: PASS", exit 0 | `arch-first.txt` |
| guarded lint (`lake lint --no-build -- --no-build --trace`, `--mem 8`) | exit 0, "-- Linting passed for Proofs.", 14 linters each "(2/2) Passed!" | `lint-first.log` |
| notes | `notes read: 196 LOCAL-SAID=31 NO-OBJECT=48 NONE-SAID=59 no-conflict=58`, **0 CONFLICT** — `main`'s own count: the check reads the audited modules of `Plane/ValidMap` and their kin and none of the fourteen, and no docstring of the fourteen names an object it knows (`bowtie`, `cuspFrag`, `l60Frag`, …: `grep`, none); `tools/fs131_qa4_notes.py --self-test`: "OK (6 controls, 1 planted)" | `notes-first.txt` (through `tools/fs131_l5_notes.py`, as the last three landings ran QA4's tool), `notes-qa4-selftest-first.txt` |

### 5.3 The axioms, reconciled

- **Against `main`'s gated audit** (`data/fs131/l10a/receipt-axioms-first.log`, 5,809 records) by `scripts/gate_report.py axioms`
  (`digest-axioms-first.txt`): **365 records added, every one CLEAN; 0 removed; 0 changed.** By axiom set: 364 on exactly
  `[propext, Classical.choice, Quot.sound]`, 1 on `[propext, Quot.sound]` (`sq9_pred_ne`). 5,809 + 365 = 6,174; clean 5,783 + 365 =
  6,148. Axiom-free 17, imported 4 and purchases 5 unchanged: the wave has no `axiom` and no `native_decide`.
- **Every theorem of the landing is audited** (`tools/fs131_l5_records.py` on the kernel's own list, `count-modules-first.out`
  against `data/fs131/l10a/count-modules-first.out`; `records-first.txt`, PASS): the library holds 9,336 theorems against `main`'s
  8,956 — 380 new, 0 gone; 17 are generated by Lean (`eq_1` 14, `mk.inj`, `mk.injEq`, `mk.sizeOf_spec`); **the 363 hand-written
  each have exactly one record under CLEAN: 362 on exactly the three, 1 on `[propext, Quot.sound]`** — `ArcContinuation` 16,
  `Basic` 30, `Curve` 23, `CurveArc` 16, `Fan` 18, `FanArcs` 8, `FanBridge` 79, `FanBuild` 14, `FanExamples` 34, `LocalGraph` 31,
  `MapColouring` 10, `MapEdge` 24, `Pinch` 44, `Sq9Map` 16.
- **The heads**, each "exactly the standard three" in that check — 61 names, `data/fs131/l6a/heads.txt`: the 31 leaves of the
  skeleton (read from `32f2ab4c` by script, Stage 2), the planners' eight compositions over leaves, and the rows the planners and
  the implementers proved outright (`saturated_of_forall_isMUA`, `erosion_diam`, `bound_iff`, `gmap_i`, `gmap_ii`,
  `half_dichotomy`, `ArcMap.bound_of_saturatedOn`, `sq9Map_sat_model`, `sq9_singLocallyFinite`, the three cell lemmas of a fan, …).
  **No record of the landing prints `sorryAx`**: the forty-six that did on their own branches are among the 364.

### 5.4 The vacuity counts, reconciled — and how the scan classes every new site

- **The counter agrees with both scans** (`tools/fs131_l5_vacdiff.py`, `vacdiff-first.txt`, PASS): `declarations` 13,767 →
  14,299 (+532: the fourteen new modules — `ArcContinuation` 40, `Basic` 71, `Curve` 30, `CurveArc` 18, `Fan` 57, `FanArcs` 8,
  `FanBridge` 91, `FanBuild` 14, `FanExamples` 44, `LocalGraph` 46, `MapColouring` 19, `MapEdge` 28, `Pinch` 45, `Sq9Map` 21; no
  count of a module of `main` changed); `refutations-skipped` 192 → 199 (+7: `pinch_not_in_in`, `sat_noPar`,
  `TwoColourOn.false_of_mem_inter`, `false_of_inside_of_outside`, `Fan.horn_false`, `Fan.false_of_horn_next`,
  `Fan.false_of_horn_dir`).
- **Row for row against `main`'s gated scan** (1,254 rows): **0 rows lost; 96 added, every one `SITE GENERIC` on `AeColouring` at a
  variable number of colours** — the binders `(c : AeColouring k)` of the wave's declarations: `Basic` 7, `Fan` 24, `FanArcs` 5,
  `FanBridge` 46, `FanBuild` 4, `LocalGraph` 7, `MapColouring` 2, `Pinch` 1. `sites` 1,173 → 1,269 (+96); `generic` 1,130 →
  1,226 (+96); `witnessed` 38, `declared` 3, `unknown` 2 unchanged. **No new site reads `VACUOUS`, `STALE` or `UNKNOWN`; nothing
  asks for a baseline entry; no new evidence row.** The scan run before any registration text was written read the same nine
  counts and the same 96 rows (`vacuity-probe.log`, `vacdiff-probe.txt`).
- **What the scan does not read of the wave**: the twenty-seven formers left OUT raise no site; the seven refutations are skipped,
  `sat_noPar` among them, which binds `(c : AeColouring 6)` at a concrete number of colours; the named open statement `NoPar`
  (C121-NOPAR) is a hypothesis of two theorems and invisible to it — listed in the drafts.

### 5.5 Each check's negative control, watched

| check | the plant | what went red |
|---|---|---|
| build's warning count | the tree as given (Stage 1) | 15 `declaration uses sorry` warnings, against 0 |
| `sorry` scan | the tree as given (`sorry-narrow-asgiven.txt`) | 15 lines, against 0 |
| doubled names | its 15 controls | each fired |
| axioms | its 23 controls; the records check's five plants on this pass's log (`records-plant.txt`, exit 1: `sorryAx` on a head, a record dropped, doubled, moved under PURCHASED, a head on fewer axioms); the receipt's reader (Stage 2: BAD-AXIOM, NO-PRINT, CONTROL) | named each |
| vacuity | its 65 controls; the row check's four plants (`vacdiff-plant.txt`, exit 1: LOST, NOT NEW, FLAGGED, COUNTER-DISAGREES) | named each |
| architecture | live: `FanBridge`'s row with `Plane/Saturated/FanBuild` taken out of its imports column (`arch-plant-import.txt`) | "FAIL imports of Plane/Saturated/FanBridge: stated-only [], real-only ['Plane/Saturated/FanBuild']", exit 1; restored by `git checkout`, PASS again |
| notes | its self-test, and the wrapper's (`notes-selftest.txt`: a conflicting note planted in `BendGap`, CONFLICT 0 → 1) | fired |
| lint | none at a landing (ruling 419 (b)) | — |
| the merges | the three-way check's plants on every both-changed path; the merge index's live controls (Stages 2, 4) — and one unplanted red: the moved ref of Stage 4 | each fired |
| this job's tools | `tools/fs131_l6a_quotes.py`, `_keepboth.py`, `_statements.py`, `_leaves.py`, `_tidyshape.py`, `_archrows.py`, `_register.py` `--self-test`; `_mergeindex.py` by live controls | each plant fired beside a faithful run |

### 5.6 The drafts, checked by the digest

Drafts 1 and 2 below, applied to a scratch copy of `CLAUDE.md`, are read by `scripts/gate_report.py` against this pass's logs:
§ Trust ledger "match (clean, purchases and imported compared)" (`digest-axioms-draft.txt`); § The gate "match (9 of 9 compared)"
(`digest-vacuity-draft.txt`). The unedited `CLAUDE.md` is flagged STALE by both digests until the filing (5783 → 6148; 13767 →
14299, 192 → 199, 1173 → 1269, 1130 → 1226).

### 5.7 Read against the informal statement, aloud

The five implementers read each leaf against its entry or row (their reports' lists, quoted words and all); every statement of
the landing is verbatim theirs or the planners' (Stage 2, by script; Stage 3 changed none). The statements the front page will
quote, read here once more on the joined tree, with what each is not:

- `fan_of_isolated (c : AeColouring k) {z} {R} (hR : 0 < R) (hS : c.singularSet ∩ ball z R ⊆ {z}) (hsat : SaturatedOn c.cls
  (ball z R \ {z})) : Nonempty (c.Fan z)` — "if `z` is the only possible singular point of a disc about it and the colouring is
  saturated at the essential boundary points of the punctured disc, there is a fan at `z`": a radius, finitely many branches
  `t ↦ z + t e(φᵢ(t))`, each continuous on `(0, r)` with a limit direction at `z`, in counter-clockwise order within one turn; the
  essential boundary of the punctured disc exactly the branches; each region between consecutive branches almost everywhere of
  one colour. FS131-E8-FAN. Not assumed: that `z` is singular; saturation at `z`; a bound on `R`. Not in the structure: any
  curvature bound on a branch (those are the lemmas `Fan.branch_outside_discs`, `Fan.branch_contacts`, under saturation). `Σ` is
  the Lean `singularSet`: the essential boundary points with no two-colour ball **centred there**, and the cusps.
- `regJFan_of_saturated (c) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) : c.RegJFan` — "a saturated colouring whose
  singular set is locally finite has a fan at every singular point". FS131-E8-BRIDGE. `regJFan_iff_singLocallyFinite (c) (hsat) :
  c.RegJFan ↔ c.SingLocallyFinite` — its left-to-right half is a projection (`RegJFan` is defined as "`Σ` locally finite, and a
  fan at each of its points"); the content is the half above.
- `regJLiteral_of_saturated … : c.RegJLiteral` — "under saturation, if `Σ` is locally finite then every point of `Σ` lies in the
  closure of finitely many components of the interface set": the frozen words' second clause from their first.
  `finite_arcs_of_isBounded … (hK : Bornology.IsBounded K) : {interface components meeting K}.Finite` — "a bounded set meets
  finitely many interface arcs". FS131-E8-CLAUSE2.
- `Fan.sector_alone (hsat : SaturatedOn c.cls (ball z F.r \ {z})) (hi : F.dir i < F.nextDir i) (hcol : F.col i = F.col i') : i =
  i'` — "a colour that has a region of positive angle at `z` has no other region there". FS121-V2-SECTOR; `Fan.sector_unique`
  its two-sector case (FS121-DB1-L3, FS111-W-NOREP).
- `local_graph` — "for two sets on a two-colour open set `N` and an open `U ⊆ N` holding no cusp of either, saturated at its
  essential boundary points: every essential boundary point of `U` has a chart in `U`" (an injective unit-speed curve with
  1-Lipschitz tangent angle, the two tangent unit discs at each of its points, one set on each side). FS131-E8-LOCAL = FS111-M-C11
  (ii) **with the hypothesis "no cusp in the neighbourhood"** = FS111-W-NOBEND. For two almost disjoint sets; not for a cover.
- `pinch` — FS111-M-PINCH for two measurable sets with null unit pairs on an open set `N`, at any point of `N`, given contacts:
  split one way or the other, or tangent. `sat_inP (F : ArcMap k) (hF : F.IsPlaneMap) (c) (hc : ∀ j, c.cls j =ᵐ F.region j) (hsat :
  Saturated c.cls) (σ) : InP F.region σ` — FS121-C1-SAT's first clause, at every order of the colours.
- What none of these is: a statement that any colouring but `sq9` (nine colours) satisfies the hypotheses; that the singular set
  of every honest saturated colouring is locally finite (C121-REGJ, open: FS-127); a new value or bound of `χ` of anything.

## Stage 5 — SAVED (FS131-L6A)

## Stage 6 — SAVED (FS131-L6A): the landing — `main` fast-forwarded to `409b0877`

`origin/main` had moved after the gated merge, from `ac2e84ea` to `aed29ad4` — `data/fs131/l6a/main-since-gate.txt`: `LEAN.md`,
three paths under `data/`, two under `plans/`, **nothing else**, so by the brief's item 6 the gate was not run again. Merged as
`d8eace55` (`git merge --no-ff`, by hash, no conflict; the index checked, `mergeindex-main2.txt`: 6 paths, none changed by both
sides, each taken whole from `main`). Checked before the push, at `d8eace55` (`data/fs131/l6a/pre-push.txt`): `origin/main`
(`aed29ad4`) an ancestor of `HEAD`; the branch as given (`b3b67f23`), the four other tips (`d62406a2`, `8e81fedd`, `43ea4886`,
`2e55a2d6`) and the gated commit (`7e67af3b`) ancestors of `HEAD` — no line was rewritten; `git diff --name-only 7e67af3b HEAD --
. ':!plans' ':!data'` names `LEAN.md` alone (`main`'s own filing) and nothing under `Proofs/`, `Proofs.lean`, `scripts/`, the
lakefile, the manifest, the toolchain or `ARCHITECTURE.md` — the gate's inputs are the gated commit's; no tracked file modified;
`sorry` under `Proofs/` by the gate's narrow pattern: 0. **`git push origin HEAD:main`: `aed29ad4..409b0877`, a fast-forward**
(`data/fs131/l6a/push-main.txt`); after it `origin/main` = `origin/fs131-w6j` = `409b0877`. No background process is left
running: every build and pass ran under the slot and exited.

**What is on `main` now**: wave 6's first half — the fourteen modules of `Plane/Saturated/`, 363 hand-written theorems, 0 `sorry`,
each with an audit record within the standard three; their imports in `Proofs.lean`, their rows in `ARCHITECTURE.md`; the scan's
entry in `scripts/Vacuity.lean` (no new carrier) and the baseline header's counts; the planners' and the five implementers'
records, tools and logs, and this job's. **What `main`'s front page does not say yet**: `CLAUDE.md` § Trust ledger and § The gate
hold the counts of the previous landing until drafts 1 and 2 are filed; both gates' digests flag them STALE and name the new numbers.

## Stage 6 — SAVED (FS131-L6A)

## Drafts for the front page (FS131-L6A)

The gated commit is `7e67af3b`; the landed tip differs from it in `plans/`, `data/` and `main`'s `LEAN.md` alone (Stage 6). The
saved gate logs are in this worktree under `build/gate/`; the copies are committed under `data/fs131/l6a/`:
`receipt-axioms-first.log`, `receipt-vacuity-first.log`, `receipt-dupnames-first.log`, the three self-tests'
(`receipt-<gate>-self-test-first.log`), and the full build `build-main-full.log`. To re-read: `python3 scripts/gate_report.py
axioms data/fs131/l6a/receipt-axioms-first.log data/fs131/l10a/receipt-axioms-first.log CLAUDE.md` and `python3
scripts/gate_report.py vacuity data/fs131/l6a/receipt-vacuity-first.log data/fs131/l10a/receipt-vacuity-first.log
scripts/vacuity-baseline.txt CLAUDE.md`.

1. **`CLAUDE.md` § Trust ledger**, the words "the current audit reads 5783 clean and 5 declared purchases, and 4 imported (and 17
   axiom-free; 5,809 records at wave 10's first landing, FS131-L10A, 2026-10-06)" become: "the current audit reads 6148 clean and 5
   declared purchases, and 4 imported (and 17 axiom-free; 6,174 records at wave 6's first landing, FS131-L6A, 2026-10-06)". From
   `data/fs131/l6a/axioms-first.log`: "audited: 6174 records — 6148 clean on the standard axioms, 17 axiom-free, 4 imported
   (resting on a declared outside theorem), 5 declared purchase(s)" and "==> axioms: OK — 6148 clean, 17 axiom-free, 4 imported, 5
   declared purchase(s)". (The log's UTC stamp: `20261006T182241Z`.)
2. **`CLAUDE.md` § The gate**, the two count lines "`declarations=13767 refutations-skipped=192 sites=1173`, `vacuous=0 stale=0
   declared=3 witnessed=38 generic=1130 unknown=2`" become "`declarations=14299 refutations-skipped=199 sites=1269`, `vacuous=0
   stale=0 declared=3 witnessed=38 generic=1226 unknown=2`". From `data/fs131/l6a/vacuity-first.log`: "scanned:
   declarations=14299  refutations-skipped=199" and "sites:   sites=1269  vacuous=0  stale=0  declared=3  witnessed=38
   generic=1226  unknown=2". The baseline's two entries are unchanged (`hexShell_plane5`, `hexShell_plane6`); its header's two
   count lines are already these (Stage 5, on the coordinator's word).
3. **`tools/claude_md_fact_audit.py`'s `GATE_CHANGES`**, after the `(("5525", "5"), ("5783", "5"))` entry:
   `(("5783", "5"), ("6148", "5")): "FS-131, wave 6's first landing (FS131-L6A; .claude/worktrees/fs131-w6j/build/gate/axioms/20261006T182241Z-2171829.log, copy
   data/fs131/l6a/receipt-axioms-first.log, gated commit 7e67af3b): 6,174 records, 6,148 clean, 17 axiom-free, 4 imported, 5 purchases",`
4. **`LEAN.md` § The gate**: no count moves — the self-tests plant 23, 65 and 15 controls, as recorded.
5. **The named hypotheses each landed theorem rests on, by name** (by reading the signatures of the fourteen files: the heads of
   every `(h… : …)` binder were listed by `grep` and sorted — the wave's own formers, Mathlib's, and five of earlier waves,
   `Saturated`, `UnitPairsNull`, `IsContactFor`, `IsAdmissible`, `IsMUA`, `IsPlaneMap`; one mind).
   - **One named open statement is taken as a hypothesis: `NoPar 𝒞`** (`Plane/Saturated/MapColouring`; C121-NOPAR is this at `k =
     6` for the locally finite map colourings — ours, proved nowhere). The theorems that take it: **`gmap_ii`** (FS121-C1-GMAP
     (ii): given `NoPar 𝒞`, `GFin 𝒞 ↔ 7 ≤ χ_m⁰`) and **`sat_noPar`** (FS121-C1-SAT's "so" clause, a refutation). `GFin 𝒞` (G-FIN₆)
     is the other named open statement of that row; it stands on one side of `gmap_ii`'s equivalence and is no hypothesis. Neither
     is an `axiom`: each is a `Prop` argument visible in the statement, and `ARCHITECTURE.md` § Trust gains no purchase.
   - **A regularity hypothesis whose truth for every honest saturated colouring is the open claim C121-REGJ**:
     `c.SingLocallyFinite` — taken by `regJFan_of_saturated`, `regJLiteral_of_saturated`, `finite_arcs_of_isBounded`; satisfied
     by `sq9` (`sq9_singLocallyFinite`). The local form `c.singularSet ∩ ball z R ⊆ {z}` is taken by `fan_of_isolated` and, as
     `IsolatedAt`, by `gamma`, `beta`, `alpha` (`sq9_isolatedAt`).
   - **Resting on no named hypothesis**: every other theorem of the fourteen files — among the rows, FS121-D3-FALLSAT,
     FS121-V2-EROSION-DIAM, FS121-C1-BOUND, FS121-C1-GMAP (i), FS121-C1-SAT's first clause, FS111-M-HALF, FS111-M-PINCH, FS111-M-C11
     (i)–(iii), FS111-W-NOBEND, FS121-V5-OFF, FS121-V5-LOC (i)–(ii), FS121-V2-SECTOR, FS121-DB1-L3 with FS111-W-NOREP, and every
     entry of FS131-E8's bridge.
6. **The open gate items at this landing** — theorems whose hypotheses no Lean object on `main` satisfies at once, and notes the
   gate's rule asks for that are not there. By reading, one mind; the mechanical part is `data/fs131/l6a/gateitems.out` (each of
   the 61 heads' docstrings searched for an inhabitant note: 14 carry one, 7 take no explicit hypothesis, 39 are covered by their
   module docstring's inhabitants paragraph and no head lacks both; one head, `sq9_regJFan`, is itself a model). Read by hand:
   - **`gmap_i`** (FS121-C1-GMAP (i)): **no Lean family is shown `GrundyBound`**, so its hypothesis set (a Grundy-bound family
     almost everywhere equal to a family of open sets with null unit pairs) has no model on file, and neither its docstring nor
     `MapColouring`'s module docstring names one. The expected model is R7's classes with the open hexagons (`r7Cls`; believed, not
     proved here). An inhabitant, or a note, is owed.
   - **`sat_noPar`**: a refutation at six colours whose docstring says that the satisfiability of its hypotheses without `hNoPar`
     at `k = 6` is the open question, and names R7 at `k = 7` in words; the Lean model of those hypotheses is at `k = 9`
     (`sq9Map_sat_model`). By design; listed by name.
   - **Five refutations inside proofs by contradiction carry no note**: `TwoColourOn.false_of_mem_inter` (`LocalGraph`),
     `false_of_inside_of_outside`, `Fan.horn_false`, `Fan.false_of_horn_next`, `Fan.false_of_horn_dir` (`FanBridge`). `LEAN.md`
     § The gate asks each to say that no model is expected and name the theorem that refutes the configuration, or to name the
     model of the hypotheses it does not refute (for the three `Fan` ones: `sq9Fan` with `i' = i`, where the last hypothesis
     fails). Five docstring lines owed; no statement is in question. `pinch_not_in_in` carries its note.
   - **`bound_iff`** (FS121-C1-BOUND): the `example` the first planner's § 7.1 owed ("any open disc of radius `1/3`") was not
     added; its hypotheses are predicates of one set and are instantiated through `sat_inP` on `sq9Map` (the examples after
     `sq9Map_sat_model`). A note or an example of its own is owed.
   - **Models that are words, not declarations** (the module docstring of `Pinch`): HALF's `half_dichotomy` — "any class of `sq9`
     with a contact" (an `example` exists for `half_upperDensity`, none for the dichotomy); EROSION-DIAM — "an open square of side
     `1/2` at a corner" (the file's example checks the bound's numbers, not an instance of the hypotheses).
   - **Not on this list**: every theorem over `Fan` (`sq9Fan`, five examples), over `IsolatedAt` (`sq9_isolatedAt`), over
     `Saturated` with `SingLocallyFinite` (`sq9`, `sq9_regJFan`), `local_graph` (`sq9_exists_isInterfaceChart`), PINCH, C11 (i),
     (iii) and HALF's density clause (six examples on `sq9` at `sqEdgePt` and on a disc), `sat_inP` (`sq9Map_sat_model`),
     FALLSAT (`r7Cls`), the `ArcSetting` family (`arcSetting_of_isolated` at `sq9_isolatedAt`).
   - **Owed before the wave's gate, from the third planner's hand-back** (inventory item 531; not this landing's): R7 as a
     colouring with a fan, `sq9`'s two periods, a chart and a two-branch fan for `sq9`. The model of everything landed here is
     nine-coloured; no model at seven colours is in Lean for the bridge.
7. **The implementers' and the deriver's drafts, gathered, and corrected for what the join changed.** "[kernel]" below means on
   `main` after this landing, audited by the gate on `7e67af3b`, on exactly `[propext, Classical.choice, Quot.sound]`, with no
   assumption beyond the statement's hypotheses unless said.
   - **`plans/FS131-E8-derivation.md`, the `grade:` and `minds:` lines of the entries** (each "grade: hand / minds: 1"), and its
     § 3.8's "[hand], one mind, kernel pending" — **corrected by the join: none is "kernel pending the join" any more**:
     - FS131-E8-LOCAL → [kernel]: `local_graph`, `AeColouring.local_graph` (`Plane/Saturated/LocalGraph`), with the erratum's
       hypothesis "no cusp in the neighbourhood".
     - FS131-E8-DELTA → [kernel]: `AeColouring.ae_one_colour_of_isConnected` (its `IsOpen W` is not read).
     - FS131-E8-GAMMA → [kernel]: `AeColouring.gamma`; -BETA → `IsUnitCurve.exists_polarGraph`, `AeColouring.beta`; -ALPHA →
       `AeColouring.alpha`; -FAN → `AeColouring.fan_of_isolated`; -BRIDGE → `AeColouring.regJFan_of_saturated`,
       `regJFan_iff_singLocallyFinite`; -CLAUSE2 → `AeColouring.regJLiteral_of_saturated`, `AeColouring.finite_arcs_of_isBounded`
       (`Plane/Saturated/FanBridge`, over `FanArcs`, `FanBuild`, `ArcContinuation`, `CurveArc`). FS131-E8-CLAUSE2's "uses only"
       line can lose "FS131-E8-LOCAL (off Σ each interface point has a neighbourhood in one component); compactness" for "a fan
       at every point (FS131-E8-FAN at singular and non-singular points alike); a bounded set is covered by finitely many fans'
       discs" (FS131-I6D's draft).
     - FS131-E8-TWOSIDES → [kernel]: `AeColouring.Fan.two_le_n`, `Fan.col_ne` (no saturation). FS131-E8-OUTSIDE → [kernel]:
       `IsUnitCurve.one_le_dist`, and on a branch `Fan.branch_outside_discs`. FS131-E8-BRANCH → [kernel]:
       `Fan.branch_contacts` (its alternative inclusive).
     - The curve parts (C1, C2, the growth of the distance, the `s²/2` bound) → [kernel] as lemmas: `IsUnitCurve.chord`,
       `.sin_le_inner`, `.strictMonoOn_dist`, `.norm_sub_le`.
   - **`plans/FS121-V2-verification.md`**: FS121-V2-SECTOR → [kernel]: `Fan.sector_alone`; FS121-DB1-L3 with FS111-W-NOREP →
     [kernel]: `Fan.sector_unique` — each for a fan at one point with saturation at its branch points, no local finiteness.
   - **`LEDGER.md` § B, row 140's lines** (l. 1289, 1290, 1291, 1292, 1296; FS131-I6A's draft, corrected):
     - FS111-M-PINCH — **[kernel]**: `pinch`, `pinch_not_in_in`, `pinch_interface` (`Plane/Saturated/Pinch`); at a wider class
       than filed (two measurable sets with null unit pairs on an open set; no colouring, no third class).
     - FS111-M-C11 — **[kernel], all three clauses. Corrected by the join**: FS131-I6A's draft left clause (ii) at [derived]
       "until FS131-E8-LOCAL's module lands"; it has landed — (i) `c11_discs`, `c11_discs_interface`; (ii) `local_graph`, **with
       the added hypothesis "no cusp of either set in the neighbourhood"** (the deriver's erratum; whether it follows from the
       filed hypotheses is not derived); (iii) `c11_split`.
     - FS111-W-NOBEND — [kernel] as FS111-M-C11 (ii): `local_graph` (the curve is `C¹`, its tangent angle 1-Lipschitz).
     - FS111-W-NOREP — [kernel] with FS121-DB1-L3: `Fan.sector_unique`.
     - FS111-M-HALF — **[kernel]**: `half_dichotomy`, `half_sq_norm_le_inner_of_mem_closedBall`,
       `inner_le_half_sq_norm_of_notMem_ball`, `half_upperDensity`; for one measurable set with null unit pairs.
     - Row 140's own text: its grade for the pinch, the two discs, the split arc and — since the join — the `C^{1,1}` clause
       becomes [kernel].
   - **`LEDGER.md` § B, rows 142–144's lines**: FS121-DB1-L3 (l. 1359), FS121-V2-SECTOR (l. 1377) → [kernel] as above;
     FS121-V2-EROSION-DIAM (l. 1368) → [kernel]: `erosion_diam`, `erosion_diam_cot` (no sector read); FS121-D3-FALLSAT (l. 1380)
     → [kernel]: `saturated_of_forall_isMUA`, `AeColouring.saturated_of_idomatic` (no partition read); FS121-C1-BOUND (l. 1391) →
     [kernel]: `bound_iff` (one open set); FS121-C1-GMAP (l. 1392) → (i) [kernel]: `gmap_i`; (ii) **[kernel over the named
     hypothesis `NoPar`]**: `gmap_ii`; FS121-C1-SAT (l. 1393; FS131-I6B's draft) → "[kernel]: `sat_inP`, `sat_noPar`
     (`Plane/Saturated/MapColouring`); wider: `ArcMap.bound_of_saturatedOn` (a family saturated on an open set; no neighbourhood
     free of other colours). Assumptions by name: `sat_noPar` takes C121-NOPAR as the hypothesis `NoPar 𝒞` (a named open
     statement, proved nowhere); `sat_inP` none. Inhabitant: `sq9Map_sat_model`."; FS121-V5-LOC (l. 1412) → clauses (i), (ii)
     [kernel]: `AeColouring.closure_essBdry_subset`, `AeColouring.notMem_essBdry_of_mem_densitySet`, `AeColouring.local_graph`;
     clause (iii) is the third pass's, not landed.
   - **`plans/LEAN-BACKLOG.md`, the rows' `grade` and `handoff` lines**: the same states for rows 25 (FS111-M-HALF), 26
     (FS111-M-PINCH), 27 (FS111-M-C11), 35 (FS111-W-NOBEND) and the FS-121 rows named above; the bridge's entries are FS131-E8's
     and have no row of their own.
   - **`plans/FS131-w6-kernel-plan.md` § 3.3** (FS131-I6B's correction; the third planner made it by a dated line on its own
     branch, inventory item 531): the sentence "would make FS121-C1-SAT false at a vertex where colour `i` has a cusp" is refuted
     for arc maps by `ArcMap.bound_of_saturatedOn`.
   - **`plans/GROKKING-INSTANCES.md` § What compute actually helps** (FS131-I6A's instance, with the four that followed): seven
     leaves priced at 22 agent-hours closed in thirty minutes of wall time; the wave's first two passes priced at about 45
     agent-days by their planners (`Pinch` 22 h, `sat_inP` 2 d, line C 9 d, the bridge's existence half 12 d, the five `Fan`
     lemmas 7 d) were five implementer jobs.
   - **`LEAN.md` § Searching — Lean**: FS131-I6A's two facts are filed (they are on `main`); none is drafted again here.
     **`BIBLIOGRAPHY.md`**: no key is used by the landed files.
8. **The generalizations the five reports found, for the wave's errata** (each kernel-checked where a declaration is named;
   none changed a statement):
   - FS111-M-PINCH: `pinch` reads (H2) only as "within `N` the set is almost everywhere one preconnected set of density points"
     (that (H2)'s set is open and non-empty is never read); the two cells of its table hold with no (H2) and no measurability
     (`isSplitAt_of_in_out`, `hasTwoDiscsAt_of_out_out`; the second reads almost-disjointness, the first does not).
   - `TwoColourOn.essBoundary_inter_eq` never reads (H2). FS111-M-C11 (iii): `c11_split` reads neither `dist x y = 1` nor the
     point `x`, and no measurability (`essBoundary_inter_congr`).
   - FS121-C1-SAT and -GMAP: no proof in `MapColouring` reads the second clause of `SeparatesAt`; `ArcMap.bound_of_saturatedOn`
     holds for a family saturated on an open set, with no colouring, no plane map and no order of the colours (the bound
     FS116-O1-SATPIN's "saturated on a disc" reads). Believed, not proved: `sat_inP` without `hF`.
   - FS131-E8-DELTA does not read "open" (`IsOpen W` kept in the statement, ruling 539 (a)). FS131-E8 §§ 3.2 (1), 3.3: C1, C2 and
     the growth of the distance hold for length at most `π` (`IsUnitCurve.sin_add_sin_le`, `.strictMonoOn_dist_of_le_pi`). § 3.1
     (3)(c): the lens point reads two of (b)'s four inequalities. § 3.1 (4): the chart is a rectangle `(a, b) × (−h, h)` in the
     frame, `h = min(ρ, 1)/32`. `local_graph` reads disjointness at four places through two lemmas, three of them false on a
     cover: a cover's form is a different lemma (ruling 539 (b)).
   - FS131-E8-CLAUSE2: its first clause reads no saturation (`Fan.finite_arcs_meeting_ball`: any fan's disc meets finitely many
     interface arcs, so `RegJFan → RegJLiteral` for every colouring — not stated as a theorem); its second needs no compactness
     off the fans and no chart. FS131-E8-GAMMA is colour-free (`ArcSetting.exists_component_arc`) and reads seven of the chart's
     fields; `gamma` and `beta` do not read `IsolatedAt.pos`; `gamma`'s route uses no Zorn and no gluing of charts.
   - FS131-E8-TWOSIDES reads no saturation. The essential boundary of a measurable set is null (`volume_essBoundary`), which
     replaces "a continuous polar graph is null". `Fan.dist_eq_one_of_common_contact`: a common contact puts the whole branch on a
     unit circle, with no saturation. FS121-V2's Lemma H holds for one set and two pieces (`in_in_or_out_out`); its § 2.2's case
     `θ₁ > π` and the bound `θ₁ ≤ π` are not needed, and § 2.3's three cases are two.
   - The planners' wider classes, as landed: FALLSAT (no partition), EROSION-DIAM (no sector), C1-BOUND (one open set), C1-GMAP
     (any class of open families), C11 (i) (every point of one `N`), E8-LOCAL (no `Σ` read), E8-FAN and E8-GAMMA (no `z ∈ Σ`).
9. **The two tidy moves left for after the landing** (ruling 544 (d); `./scripts/dupnames.sh` passes because the names differ):
   - **`fanAngle`** (`Plane/Saturated/FanBridge`) is `polarAngle` (`Plane/ValidMap/RadialPush`) again, and the same angle is
     inline in `FanBuild`; one home beside `polarPt` in `Plane/LocalStructure` makes one definition (FS131-I6E's report).
   - **`MapEdge.isPreconnected_puncturedBall`** restates `isPreconnected_ball_diff_singleton` (`Plane/ValidMap/Limit` l. 1215,
     not upstream of `Plane/Saturated`); `isConnected_ball_diff_singleton` (`FanBridge`, FS131-I6E) is a third statement of the
     punctured disc; `MapEdge`'s four generic density facts (`MapEdge.densityRatio_congr_ae`, `.essBoundary_congr_ae`,
     `.essSupport_congr_ae`, `.notMem_densitySet_of_disjoint`) and the local `eventually_floor_eq` of `sq9Col_locallyConstant`
     (`Plane/SVMap` l. 871) are the other candidates FS131-I6B lists.
   - With them, from draft 6: the five refutations' notes, `gmap_i`'s and `bound_iff`'s inhabitant.
10. **The front page's draft — REG-J′ as "the singular set is locally finite"** (ruling 492 (a); the deriver's texts,
    `plans/FS131-E8-derivation.md` §§ 4.4, 4.6). The frozen claim C121-REGJ reads (`data/fs121/claims.md` l. 105): "in every honest
    saturated colouring in D-NF, with any number of colours, the singular set Σ is locally finite and each point of Σ meets
    finitely many interface arcs." Each sentence below with the Lean theorem that licenses the change:
    - **`CLAUDE.md` § Where the problem stands, item 31**, the words "at five, given REG-J′₅, the honest existence form of
      C-SAT-T is equivalent to `χ_m⁰(ℝ²) ≥ 6` (row 154)" become "at five, given that a saturated five-colouring's singular set is
      locally finite (REG-J′₅), the honest existence form of C-SAT-T is equivalent to `χ_m⁰(ℝ²) ≥ 6` (row 154)". Licensed by
      `AeColouring.regJLiteral_of_saturated` (under saturation the frozen words' second clause follows from the first) and
      `AeColouring.regJFan_of_saturated` (so does the fan the rows read). **Row 154 itself stays [hand]**: only the wording of
      its hypothesis moves.
    - **`CLAUDE.md` § Grokkings, the theory paragraph**, "off a locally finite singular set its interfaces are segments and arcs
      of integer radius, that finiteness open (rows 140–141, G84, G85; [hand])": **no change** — it already names the first
      clause alone (the deriver's § 4.4), and "integer radius" is FS111-M2-INTRAD, a row of the third pass, not landed.
    - **`CLAUDE.md` § What the kernel holds**, a clause to add: "**the saturated lane's first half (FS-131 wave 6)** — the pinch
      at an interface point with its two tangent discs and split arc, the local `C^{1,1}` graph off the cusps, and the bridge:
      in a saturated colouring a point isolated in the singular set has a fan with end tangents (`fan_of_isolated`), so REG-J′
      is 'the singular set is locally finite' (`regJFan_iff_singLocallyFinite`, `regJLiteral_of_saturated`), a bounded set meets
      finitely many interface arcs (`finite_arcs_of_isBounded`), and at a fan no colour holds a sector and another region
      (`Fan.sector_alone`); model: the nine-colour grid (`sq9_regJFan`)".
    - **`plans/FRONTIER-STUBS.md`, row 8 (FS-127)**, after "is the singular set of every honest saturated colouring of the plane
      locally finite (C121-REGJ)?": "— since FS-131's wave 6 this is all of REG-J′: under saturation its second clause and its
      fan reading follow from the first, in the kernel (`AeColouring.regJLiteral_of_saturated`, `regJFan_iff_singLocallyFinite`,
      `finite_arcs_of_isBounded`)".
    - **`plans/STUB-lateral-extent.md` and `plans/STUB-curved-pencils.md`, the two bearing lines filed from the deriver's § 4.4**:
      "[hand], one mind, kernel pending" becomes "[kernel]: `AeColouring.regJFan_of_saturated`,
      `AeColouring.regJLiteral_of_saturated`, `AeColouring.finite_arcs_of_isBounded`, standard three axioms"; the same in the
      note for `data/fs121/claims.md` ("C121-REGJ's second clause follows from its first") and under G85's replacement words.
      `plans/STUB-top-colour.md` l. 77, "Given REG-J′₅ (FS-127 at five)": "Given that the singular set is locally finite at five
      (REG-J′₅, FS-127 at five)".
    - **What the kernel holds, plainly.** For every `k` and every measurable almost-everywhere-proper `k`-colouring whose classes
      are saturated: (a) at a point with no other singular point in a disc about it, a fan exists (`fan_of_isolated`; saturation is
      read in the punctured disc only); (b) if the singular set is locally finite, every singular point has a fan, every singular
      point lies in the closure of finitely many interface arcs, and every bounded set meets finitely many interface arcs
      (`regJFan_of_saturated`, `regJLiteral_of_saturated`, `finite_arcs_of_isBounded`); (c) at any fan, under saturation in its
      punctured disc: each branch stays outside the two unit discs tangent to its limit direction, its contacts are as FS121-V2's
      Lemma T (ii) says, a singular point has at least two branches with different colours on their two sides, and a colour with
      a sector of positive angle has no other region (`Fan.branch_outside_discs`, `.branch_contacts`, `.two_le_n`, `.col_ne`,
      `.sector_alone`); (d) off the cusps a two-colour interface is locally a `C^{1,1}` graph (`local_graph`). One model satisfies
      every hypothesis at once: the nine-colour grid `sq9` (`sq9_regJFan`).
    - **What it does not hold.** That the singular set of any saturated colouring other than `sq9` is locally finite — **C121-REGJ
      itself is open** (FS-127), and the kernel takes it as a hypothesis; anything at seven colours or fewer beyond what is
      proved for every `k` (no model at `k = 7` is in Lean, and no value or bound of `χ` moved); **the rows of the third planning
      pass, which are not landed** — the outward and inward parallels and their ends (FS121-DB1-L6, -L7, -O1-OUT, -O1-ENDS),
      integer radii (FS111-M2-INTRAD), FS121-V5-LOC (iii), -V3-CPI, -V2-VT-W, -D1-VT, -D1-EROSION, -D1-PENCILWIN, FS111-W-KB-DIR,
      FS121-V5-RAY, the four FS121-D2 rows, -D4-HOLE, FS111-M2-HULLC, and the agreement of the two readings of the singular set
      (thirty-four `sorry` leaves on `fs131-w6`, by inventory item 531); the fragment's six rows, not stated. The Lean singular set
      is the centred-ball reading (ruled, inventory item 495); that it agrees with the other reading under saturation is one of
      those unlanded rows.
11. **The Frontier line and the Proof Atlas.** No value moved and the milestone is not closed by one landing. Grades that move to
    **[kernel]**: FS111-M-PINCH, FS111-M-HALF, FS111-M-C11 (i)–(iii) (the second with its no-cusp hypothesis), FS111-W-NOBEND,
    FS111-W-NOREP, FS121-D3-FALLSAT, FS121-V2-EROSION-DIAM, FS121-C1-BOUND, FS121-C1-GMAP (i), FS121-C1-SAT, FS121-V2-SECTOR,
    FS121-DB1-L3, FS121-V5-OFF, FS121-V5-LOC (i)–(ii), and the eleven entries of FS131-E8's bridge (LOCAL, DELTA, GAMMA, BETA,
    ALPHA, FAN, BRIDGE, CLAUSE2, TWOSIDES, OUTSIDE, BRANCH); to **[kernel over a named hypothesis]**: FS121-C1-GMAP (ii) and
    FS121-C1-SAT's "so" clause, over `NoPar`. For `CLAUDE.md` § Frontier's open-milestones sentence, of this landing: "wave 6's
    first half is on `main` (FS131-L6A): fourteen modules of `Plane/Saturated`, 363 theorems, the bridge among them".
12. **For the tooling lane's question on the scan's procedure** (ruling 535 (a), and the coordinator's reply to this job):
    **`AeColouring.Fan` is the second case, beside `StationaryRatio.StationarySet`, of a hypothesis-former whose existence is a
    theorem, with no `VACUOUS` control plantable.** `StationarySet` exists at every group by construction and is IN by ruling
    (507 (d)); `Fan` exists at a point by a theorem (`fan_of_isolated`), fails to exist at a wild point of some colouring, has no
    refutation in the library, and is OUT by the law as wave 5 applied it. One question for both: does step (1)'s first clause
    ("'does one exist' is a theorem rather than a construction") enter a carrier when step (3)'s `VACUOUS` control cannot be
    planted? The numbers for `Fan`: 51 binder sites, all `GENERIC`; one closed inhabitant, `sq9Fan`.
13. **For the join of the wave's later modules** (`fs131-w6` and the branches cut from it; none was touched). What changes under
    them: `polarRegion_isOpen` and `polarRegion_isPreconnected` are gone (cite `isOpen_polarRegion`, `isPreconnected_polarRegion`,
    `Plane/Saturated/FanBuild`; no code on those branches cites the old names); Stage 3's docstring edits touch four of the
    eight modules those branches hold (`Fan`, `FanBridge`, `LocalGraph`, `Pinch`), so their dependents re-elaborate. `scripts/Axioms.lean`'s wave-6 blocks sit after wave 10's and above
    the `=== PURCHASED ===` banner, where the later blocks will conflict again: keep both. `ARCHITECTURE.md`'s rows and
    `Proofs.lean`'s imports for the four later modules will conflict by adjacency at the end of the `Plane/Saturated` run: keep
    both, with no blank line between (a blank line splits the table). The three cell lemmas of a fan are on `main`
    (`Fan.isPreconnected_cell`, `Fan.cell_subset_densitySet`, `Fan.exists_ray_subset_cell`).

## Theorems this phase proved, final

All **[kernel]**: built by this worktree's `./scripts/build.sh` (`data/fs131/l6a/build-main.log`, then `build-first.log` on the
gated commit), each audited by `scripts/axioms.sh` on `7e67af3b` under CLEAN on the axioms shown
(`data/fs131/l6a/receipt-axioms-first.log`; `records-first.txt`). Addresses are `Proofs/HadwigerNelson/Plane/Saturated/`.

**New in this job: no theorem.** This job proved nothing of its own and changed no statement. It deleted two theorems that
duplicated two others (`polarRegion_isOpen`, `polarRegion_isPreconnected`) and repointed their three uses.

**Landed by this job, proved by FS131-K6, -K6b, -I6A, -I6B, -I6C, -I6D, -I6E** (their records hold the lists and the readings): the
363 hand-written theorems of the fourteen modules — 362 on exactly `[propext, Classical.choice, Quot.sound]`, `sq9_pred_ne` on
`[propext, Quot.sound]`. The heads, each on exactly the three (`records-first.txt`, 61 names), read against their rows by the
implementers and, for the bridge, in § 5.7:
- FS111: `pinch`, `pinch_not_in_in`, `pinch_interface` (M-PINCH); `c11_discs`, `c11_discs_interface`, `c11_split` (M-C11 (i),
  (iii)); `local_graph` (M-C11 (ii) with no cusp, W-NOBEND); `half_dichotomy`, `half_upperDensity` (M-HALF);
  `TwoColourOn.essBoundary_inter_eq`, `TwoColourNhd.mem_essBoundary`;
- FS121: `saturated_of_forall_isMUA`, `AeColouring.saturated_of_idomatic` (D3-FALLSAT); `erosion_diam`, `erosion_diam_cot`
  (V2-EROSION-DIAM); `bound_iff` (C1-BOUND); `gmap_i`, `gmap_ii` (C1-GMAP; the second over `NoPar`); `sat_inP`, `sat_noPar`,
  `ArcMap.bound_of_saturatedOn`, `sat_bound_of_mem_closure` (C1-SAT; `sat_noPar` over `NoPar`); `AeColouring.closure_essBdry_subset`,
  `AeColouring.notMem_essBdry_of_mem_densitySet`, `AeColouring.local_graph` (V5-OFF, V5-LOC (i), (ii)); `Fan.sector_alone`
  (V2-SECTOR); `Fan.sector_unique` (DB1-L3, FS111-W-NOREP);
- FS131-E8, the bridge: `AeColouring.ae_one_colour_of_isConnected` (DELTA); `IsUnitCurve.chord`, `.sin_le_inner`,
  `.strictMonoOn_dist`, `.norm_sub_le`, `.one_le_dist` (OUTSIDE), `lipschitzOnWith_of_chord`, `norm_sub_le_of_discs`;
  `AeColouring.gamma` (GAMMA); `IsUnitCurve.exists_polarGraph`, `AeColouring.beta` (BETA); `AeColouring.alpha` (ALPHA);
  **`AeColouring.fan_of_isolated`** (FAN); **`AeColouring.regJFan_of_saturated`**, `regJFan_iff_singLocallyFinite` (BRIDGE);
  `AeColouring.regJLiteral_of_saturated`, `AeColouring.finite_arcs_of_isBounded` (CLAUSE2); `Fan.two_le_n`, `Fan.col_ne`
  (TWOSIDES); `Fan.branch_outside_discs`, `Fan.branch_contacts` (BRANCH); the three cell lemmas of a fan;
- the models: `sq9_isTangentAt`, `sq9_exists_isInterfaceChart`, `sq9Fan`, `sq9_isolatedAt`, `sq9_singLocallyFinite`, `sq9_regJFan`,
  `sq9Map_sat_model`.

**Not proved, and not claimed**: `NoPar` at any class (C121-NOPAR); that the singular set of every honest saturated colouring is
locally finite (C121-REGJ); a model of the bridge at seven colours; a model of `gmap_i`'s hypotheses; the wave's third pass
(thirty-four leaves on another branch) and the fragment's six rows.

## Slips, my own

- **The first run of my rows check was wrong**: `tools/fs131_l6a_archrows.py` read five sibling-module names and one abbreviated
  suffix as missing declarations. Repaired before any result was read from it (Stage 3).
- **A ref moved under a check**: I named `origin/main` by ref in the merge-index check while another session fetched; the check
  fired on the moved ref. From then on merges and checks name `main` by hash (Stage 4).
- **I wrote an inventory item number I did not know into `scripts/Vacuity.lean`'s entry** ("item 548") and took it out before the
  commit; the entry cites the coordinator's reply by date instead.
- **One build after the three implementers' merges, not one after each**, and **no separate build of the tidied tree before
  `main` was merged**: the tidies' three changed code lines were elaborated in `FanBridge` (iteration) and built with `main`'s
  merge. Said in §§ 2.3, 3.2, Stage 4.
- **The statement tool's self-test does not apply to a file with two owners** (`FanBridge` against one half's tip): I ran it there
  first, read its FAIL, and moved it to two one-owner files. The comparison itself was right.
- **The background commands that ran the builds and the gate pass were launched with the harness's ten-minute ceiling**; each
  ended inside it (the pass in about five minutes). Had one been cut, its steps were separately logged and resumable by step, but
  I did not write the resume command down beforehand.
- I did not read the harness's token count at the saved stages; I have no instrument for it in this session and say so rather
  than give a number I did not read.
