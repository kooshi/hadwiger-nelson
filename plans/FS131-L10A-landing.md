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
