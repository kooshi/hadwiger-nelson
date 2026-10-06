# FS131-L10A — wave 10's first landing: the four proved files joined, the unread arguments dropped, `main` merged, the gate (de Bruijn, the implementer)

*Brief: `data/fs131/briefs/FS131-L10A-wave10-land.md` (on `main`). Branch `fs131-w10l`, worktree `.claude/worktrees/fs131-w10l`, cut from
`fs131-w10` at `ace98a35`. Started 2026-10-06 14:05 UTC. Logs and working files: `data/fs131/l10a/`.*

## Theorems this phase proved

*Filled at each saved stage; the final list is the section "Theorems this phase proved, final" at the end of this file.*

## Stage 1 — SAVED (FS131-L10A): the readback, the build as given

### 1.1 The brief's quotations (standing rule 3)

By script, `tools/fs131_l10a_quotes.py --self-test <brief> <main's tree>`: it reads every `> quote` / `> — source:` pair of the brief and
counts the quote's verbatim occurrences in the named file. **Fifteen of fifteen pairs match, each exactly once**
(`data/fs131/l10a/quotations.txt`, exit 0): `CLAUDE.md` § The standard of evidence (1) and § The gate's count line (1), read from disk on
`main`; `plans/FS131-close-inventory.md` items 493, 494, 506, 507, 519, 520, 509, 496 (8); `SpectralInputs.lean` on this branch, `sp_if` and
`spectral_carried_iff` (2); `StationaryRatio.lean` on `fs131-w10b`, `ratio_prod_le` and `ratio_prod_le_iSup_levels` (2); `StandingFive.lean`
on `fs131-w10c`, `seven_le_localBound` (1). The script's two plants fire beside the faithful run: one character of a quote changed reads
MISSING; a source that does not exist reads NO-SOURCE. **No mismatch.**

One thing the readback shows that is not a mismatch: the copy of `CLAUDE.md` my session was given at launch reads the gate's counts as
they stood before the example maps' landing (12,999 declarations, 5,196 clean); the file on disk on `main` reads the brief's line (13,386;
5,525 clean, 5,550 records). The counts I reconcile against are the file's on disk.

### 1.2 What was read, and how far

- The brief; `plans/STANDING-RULES.md`; `LEAN.md` (on `main`) whole; `RUNNING.md` § Building and § Make the gate fail, whole.
- The three implementers' records, whole: `plans/FS131-I10A-implementation.md` (this branch), `plans/FS131-I10B-implementation.md`
  (`fs131-w10b`), `plans/FS131-I10C-implementation.md` (`fs131-w10c`) — each to its drafts and what the join must know.
- The planner's record `plans/FS131-w10-kernel-plan.md` (this branch), whole: Stages 1–5, the § 5.5 table of named hypotheses.
- The last landing's record `plans/FS131-MC1-landing.md` (on `main`): Stages 1–2 and 4–5, the drafts and the theorem list, in full; Stage 3
  by its headings. Its runners `data/fs131/mc/run-build.sh`, `run-gate.sh`, `run-pass.sh`, `run-final.sh`, read whole: the gate's order.
- Inventory items 493, 494, 496, 497, 506, 507, 509, 510, 519, 520, 521, each whole.

### 1.3 The branch tips, as fetched (2026-10-06 14:05 UTC)

`origin/fs131-w10l` = `origin/fs131-w10` = `ace98a35` (this tree's `HEAD`); `origin/fs131-w10b` = `423cd8e8`; `origin/fs131-w10c` =
`8ee0d85b` — the three the brief names. `origin/main` = `4e5e3780`. Merge bases: with each of the two implementers' branches `f919973e`
(the planner's tip); with `main`, `ff377526`.

What each side changed since `f919973e`, outside `plans/` and `data/` (`git diff --name-only`): this line — `CharacterColouring.lean`,
`SpectralInputs.lean`, `scripts/Axioms.lean`, `tools/fs131_i10a_statements.py`; `fs131-w10b` — `StationaryRatio.lean`,
`scripts/Axioms.lean`, `tools/fs131_i10b_statements.py`; `fs131-w10c` — `StandingFive.lean`, `scripts/Axioms.lean`,
`tools/fs131_i10c_data.py`, `tools/fs131_i10c_statements.py`. **No Lean file is changed by two sides.**

### 1.4 The build as given

`data/fs131/l10a/build-asgiven.log` (runner `data/fs131/l10a/run-build.sh asgiven`; `HEAD=ace98a35`, no tracked file modified): `build: OK
— all 1771 modules already up to date, nothing built, 2 module(s) with warnings`, `exit=0`. The warnings replayed are twelve, every one
`declaration uses 'sorry'`: `StationaryRatio.lean` 3 (lines 100, 107, 121), `StandingFive.lean` 9 — the two files proved on the other two
branches. `grep -c sorry`: `CharacterColouring` 0, `SpectralInputs` 0, `StationaryRatio` 3, `StandingFive` 9.

### 1.5 The trial merges, before any is made

`git merge-tree --write-tree --name-only HEAD origin/fs131-w10b` (`data/fs131/l10a/merge-trial-w10b.txt`) and the same for
`origin/fs131-w10c` on this tip (`merge-trial-w10c-on-tip.txt`): **one conflict each, `scripts/Axioms.lean`**, as the brief says. The
second is tried again on the first merge's commit before it is made (Stage 2).

### 1.6 What I may and may not change

Mine: the merges' files; in the four files of `Proofs/HadwigerNelson/Arith/` the wave's first pass wrote, the ruled tidies (rulings 494
(a), 507 (a)) with their docstring lines and any caller; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`,
`scripts/axioms-controls.txt`, `scripts/Vacuity.lean` with its controls and `scripts/vacuity-baseline.txt`, as the gate's own procedures
ask; this record; `tools/fs131_l10a_*.py`; `data/fs131/l10a/`; the report; `main` by the final fast-forward push alone. Not mine: any
statement beyond the ruled ones; `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `BIBLIOGRAPHY.md` (drafted here, filed by the coordinator); anything
of the wave's second pass (`fs131-w10k` and the three branches cut from it); a new `axiom`; `native_decide`.

## Stage 1 — SAVED (FS131-L10A)

## Stage 2 — SAVED (FS131-L10A): the two merges; the first pass is whole

### 2.1 The merges, each its own commit

| merge | commit | conflict | resolution |
|---|---|---|---|
| `origin/fs131-w10b` (`423cd8e8`) into `f51c1f4e` | **`a0864d87`** (two parents) | `scripts/Axioms.lean`, one hunk at one anchor | keep both: this line's block "FS131-I10A", a blank line, the block "FS131-I10B" |
| `origin/fs131-w10c` (`8ee0d85b`) into `14a27a4a` | **`ee5a662a`** (two parents) | `scripts/Axioms.lean`, one hunk at the same anchor | keep both: the blocks in the order FS131-I10A, FS131-I10B, FS131-I10C, above the `=== PURCHASED ===` banner |

No other path conflicted (trial of the second on the first merge's commit: `data/fs131/l10a/merge-trial-w10c.txt`). Each merge was made
with `--no-ff --no-commit`, resolved, checked, and then committed as a merge.

- **The resolution, by script** (`tools/fs131_l10a_keepboth.py resolve`, then `--self-test`; `data/fs131/l10a/keepboth-w10b.txt`,
  `keepboth-w10c.txt`, each exit 0): the resolved file holds no marker; every non-blank line of both sides is in it with its multiplicity;
  its `#print axioms` lines number ours + theirs − base — **4,015 = 3,964 + 3,982 − 3,931** after the first merge, **4,046 = 4,015 + 3,962 −
  3,931** after the second; no name is printed twice. Its three plants fire beside the faithful run: a record of theirs dropped (LOST), a
  record doubled (TWICE), a marker left in (MARKER).
- **The index holds the merge and nothing else** (`tools/fs131_l10a_mergeindex.py <theirs> scripts/Axioms.lean`;
  `mergeindex-w10b.txt`, `mergeindex-w10c.txt`): `MERGE_HEAD` is the named tip; no path unmerged; the staged paths are exactly the
  paths theirs changed since the base (30 and 23); every one but `scripts/Axioms.lean` is taken whole from theirs, and
  `scripts/Axioms.lean` is the one path both sides changed; the working tree equals the index. Two controls run live on the first
  merge, each exit 1 before the faithful run's exit 0: the conflict path resolved and not yet staged (UNMERGED, DIRTY), and a file of
  this job's staged beside the merge (EXTRA, NOT-THEIRS; taken out of the index again before the commit).
- A merge cannot be committed by path (git refuses a partial commit during a merge), so each was committed whole after that check;
  this job's own files went in separate commits by path (`14a27a4a`, `2a6bf3f2`).

### 2.2 No statement of any side changed

- **The four files are byte-identical to their owners' tips**: `git diff --quiet` of `CharacterColouring.lean` and
  `SpectralInputs.lean` against `origin/fs131-w10`, of `StationaryRatio.lean` against `origin/fs131-w10b`, of `StandingFive.lean`
  against `origin/fs131-w10c` — exit 0 each. Against each tip, the only paths under `Proofs/`, `Proofs.lean`, the lakefile, the
  manifest and the toolchain that differ from the merged tree are the wave files that tip did not prove.
- **By script, against each branch's tip and the planner's** (`tools/fs131_l10a_statements.py present <ref> <the four files>`;
  `data/fs131/l10a/statements-merges.txt`): every declaration of each of `origin/fs131-w10` (36, 93, 11, 24 declarations in the four
  files), `origin/fs131-w10b` (33, 24, 59, 24), `origin/fs131-w10c` (33, 24, 11, 132) and `f919973e` (33, 24, 11, 24) appears
  verbatim in the merged tree — a theorem's text to its first ` :=` followed by ` :=`, anything else whole, docstrings included. **0
  flagged in all sixteen comparisons.** The tool's self-test, on each of the four files: five plants, each fired (one character of a
  statement; a disjunct appended to a conclusion; a declaration renamed away; one added; a docstring edited).

### 2.3 The build of the joined line

`data/fs131/l10a/build-merges.log` (`HEAD=2a6bf3f2`, whose Lean sources are `ee5a662a`'s; no tracked file modified): **`build: OK — 451
of 451 batches, 3 module(s) rebuilt, 0 module(s) with warnings, 10m5s`, `exit=0`**. The full log (`build-merges-full.log`) holds **0
`warning` lines** and ends "Build completed successfully (5756 jobs)"; the three rebuilt are `Arith.StationaryRatio` (4.1 s),
`Arith.StandingFive` (13 s) and `Proofs`. One build after both merges, not one after each: the two merges change disjoint Lean files
(§ 1.3), so a failure would have named its side.

### 2.4 The receipt that the first pass is whole

- **Zero `sorry`**: `grep -c sorry` reads 0 in each of the four files; the gate's narrow pattern over `Proofs/` and `Proofs.lean`
  reads 0 lines. Its control is Stage 1's tree: twelve `sorry` warnings and `grep -c` 3 and 9.
- **Every leaf on exactly the standard three** (`tools/fs131_l10a_leaves.py`; `data/fs131/l10a/axioms-leaves.lean`, its output
  `axioms-leaves-merges.log`, the reading `leaves-merges.txt`, exit 0). The leaf list is not written by hand: it is every declaration
  of the four files at the planner's tip `f919973e` whose text holds `sorry` — **21: `CharacterColouring` 1, `SpectralInputs` 8,
  `StationaryRatio` 3, `StandingFive` 9**, the count the planner and the three implementers report — with the three compositions the
  planner proved over leaves (`no_small_usable`, `seven_le_localBound`, `five_le_chromaticNumber`). **All 24 print
  `[propext, Classical.choice, Quot.sound]`, none a proper subset, none anything else.** The control is in the same file: a theorem
  proved by `sorry`, whose print shows `sorryAx`. The reader's three plants fire: a leaf's print given `sorryAx` (BAD-AXIOM), a leaf's
  print dropped (NO-PRINT), the control's print made clean (CONTROL). This is iteration's evidence (`lake env lean` on the built
  tree); the audit of every record of the wave is the gate's, after the doubled-name check (Stage 5).

## Stage 2 — SAVED (FS131-L10A)
