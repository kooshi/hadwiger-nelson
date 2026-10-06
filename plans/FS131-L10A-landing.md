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

## Stage 3 — SAVED (FS131-L10A): the ruled tidies — nine arguments dropped, three twins folded into their rows

### 3.1 What was ruled, and what changed (rulings 494 (a), 507 (a))

Every edit is an exact text replacement that must match once (`data/fs131/l10a/tidy.py`; a file other than the one the edits were
read against is refused). All of them went through as ruled; none is deferred.

| statement | before (Stage 2's tip, `77e1f077`) | now |
|---|---|---|
| `SpectralInputs.sp_if` (J45-SP-if) | `(I : Interface F) [Countable (unitRing F)] (hBH : …)` | `[Countable (unitRing F)]` cut; the `have` that consumed it and its comment cut |
| `SpectralInputs.spectral_carried_iff` (J45-N2, spectral half) | `[IsProbabilityMeasure μ] (t : TopologicalSpace R) …` | `[IsProbabilityMeasure μ]` cut; its `have` and comment cut |
| `StationarySet.prob_le_ratio_mul` (X25B-P) | `[MeasurableAdd₂ G] [MeasurableNeg G]`, a one-line corollary of `…_of_symm` | the name is on the general statement (no `MeasurableAdd₂ G`); **`prob_le_ratio_mul_of_symm` deleted** |
| `ratio_prod_le` (X25B-PZ) | `[MeasurableAdd₂ G]`, `[MeasurableAdd₂ H]`, a corollary of `ratio_prod_le_of_symm` | the name is on the general statement; **`ratio_prod_le_of_symm` deleted** |
| `ratio_prod_le_iSup_levels` (X25B-L1) | `[MeasurableAdd₂ X]`, `[T2Space Y]`, `[SigmaFinite νX]`, `[IsFiniteMeasure νY]`, `(K : ℕ → OpenAddSubgroup Y) (hK : Antitone K)`, a corollary of `…_of_shrink` | the name is on the general statement: `{ι X Y : Type*}`, `[SFinite νY]`, `(K : ι → OpenAddSubgroup Y)`, no `hK`; **`ratio_prod_le_iSup_levels_of_shrink` deleted** |

That is the two instance arguments of ruling 494 (a) and the seven of ruling 507 (a) — `[MeasurableAdd₂ _]` four times, `[T2Space Y]`,
`[SigmaFinite νX]`, `(hK : Antitone K)` — with its two weakenings (`[IsFiniteMeasure νY]` to `[SFinite νY]`, the index `ℕ` to any type).

**Callers.** None outside the two files, on this line, on `main`, or on the second pass's four branches (`origin/fs131-w10k`, `-w10d`,
`-w10e`, `-w10f`: `git grep` finds the names only in `NegCircleModel`'s module docstring). Inside `StationaryRatio`: X25B-PZ's proof
calls X25B-P in each factor (two lines, the name alone changed), and two Spec examples instantiated X25B-L1 with an antitone proof
(`antitone_const`, `cantorLevel_antitone`) that the statement no longer takes — both now pass the family alone, and an example
`Antitone cantorLevel := cantorLevel_antitone` keeps the fact that the Cantor levels do decrease. `cantorLevel_antitone` itself stays
a theorem. **`scripts/Axioms.lean`**: the three twins' records deleted (4,046 − 3 = 4,043 `#print axioms` lines) and the block's
heading says the twins were folded.

**Docstring lines** (the brief's item 3, and the reports' "what the join must know"):
- each of the three rows carries its row's words, the class its proof reads, and **the inhabitant of its hypotheses by name**
  (`StationarySet.parity` with `map_neg_dirac_one` and `parity_aeIndependent`; `ZMod 2 × ZMod 2`; `cantorLevel` with
  `exists_cantorLevel_subset`) — each instantiated there in the file's Spec section, which elaborates;
- `StationaryRatio`'s module docstring: the rows are at the class their proofs read; the inhabitants are named as the declarations
  they now are;
- **`sp_if`'s docstring, the sentence `LEAN.md` § The gate asks**: "`hcirc : I.NegCircle` has no Lean model on file:
  `Interface.trivial` meets `MulStable` (its `E` is empty) and, with that point mass for `ν`, the measure hypotheses, and no
  declaration proves `NegCircle` of it or of any interface — one is planned at `F = ℚ` by the parity character
  (`negCircle_trivial_bot`, `Arith/NegCircleModel`, on the wave's second pass and not on this line), and until it lands this theorem
  is an open gate item under the inhabitant rule". The module docstring's inhabitants paragraph says the same in one line;
- `spectral_carried_iff`'s docstring says that `μ` need not be a probability measure.

### 3.2 Exactly the ruled statements changed, by script

- **`tools/fs131_l10a_statements.py delta 77e1f077 --changed <the five> --removed <the three twins>`** over the four files
  (`data/fs131/l10a/statements-tidies.txt`): 320 declarations before, 317 after; **statements changed: exactly the five; removed:
  exactly the three twins; added: none; a docstring changed with its statement unchanged: none.** PASS, exit 0. Three controls on
  the same run, each exit 1: one ruled change left off the list (`CHANGED, not ruled: …sp_if`); a twin not listed as removed
  (`REMOVED, not ruled`); the ruled list given against an unchanged file (`NOT-CHANGED`, `NOT-REMOVED`, eight faults).
- **Each change has the ruled shape** (`tools/fs131_l10a_tidyshape.py --self-test 77e1f077`; `data/fs131/l10a/tidyshape.txt`, exit
  0): each row's statement is now its twin's statement of `77e1f077` with the name alone substituted, and the twin is gone; `sp_if`
  and `spectral_carried_iff` are their old statements with the one instance argument cut and nothing else; none of
  `MeasurableAdd₂`, `T2Space`, `SigmaFinite νX`, `Antitone`, `IsFiniteMeasure νY`, `ℕ → OpenAddSubgroup` is in a row. Three plants,
  each fired: `[T2Space Y]` put back (ARG-KEPT), a row's conclusion changed (ROW-SHAPE), another instance argument put into `sp_if`
  (CUT-SHAPE).

So the proofs of the three rows are the proofs I10B's general forms had — moved, not rewritten — and the proofs of `sp_if` and
`spectral_carried_iff` lost one `have` each.

### 3.3 `ARCHITECTURE.md`

The four rows rewritten (`data/fs131/l10a/arch_rows.py`): `Arith/SpectralInputs`, `Arith/StationaryRatio`, `Arith/StandingFive` read
"**FS-131 wave 10 (FS131-K10; proved by FS131-I10A / -I10B / -I10C), no `sorry`.**" in place of "skeleton", each with what was added
and which named hypotheses it rests on; `Arith/CharacterColouring`'s "Skeleton leaf" clause now says the leaf is proved. Every
backticked declaration name in the four rows is declared in its module (`data/fs131/l10a/arch-rows.txt`: 13, 27, 11, 28 names, 0
missing; the look-up's control, a cited name misspelt, fired). `tools/check_architecture.py`: `RESULT: PASS`, exit 0
(`arch-tidy.txt`).

### 3.4 The build and the checks of this stage

- **Iteration first, on scratch copies** (`data/fs131/l10a/scratch/SR.lean`, `SI.lean`: the two files with `tidy.py` applied,
  elaborated by `lake env lean` with both auto-implicit options off, under the slot — exit 0, no message; with `#lint` appended, "0
  errors in 69 declarations" and "0 errors in 93 declarations", 14 linters). The real files are `cmp`-identical to those copies.
  Iteration, not evidence.
- **The build** (`data/fs131/l10a/build-tidy.log`; the tree was `77e1f077` with this stage's edits uncommitted, as the log's `DIRTY`
  lines say): **`build: OK — 451 of 451 batches, 3 module(s) rebuilt, 0 module(s) with warnings, 9m44s`, `exit=0`**; the full log
  (`build-tidy-full.log`) holds 0 `warning` lines and ends "Build completed successfully (5756 jobs)"; rebuilt:
  `Arith.StationaryRatio`, `Arith.SpectralInputs`, `Proofs`. So no unused-argument or unused-variable warning arose from the cuts.
- **The 24 leaves and compositions again, on the tidied tree** (`axioms-leaves-tidy.log`, `leaves-tidy.txt`): all 24 on exactly the
  standard three; the control shows `sorryAx`.
- `sorry` by the gate's narrow pattern over `Proofs/`: 0 lines.
- **The named hypotheses, read from the signatures** (`tools/fs131_l10a_hyps.py`, `data/fs131/l10a/hyps-tidy.txt`; self-test: a
  binder reads HYP, a conclusion reads CONCL, a docstring mention reads nothing): of the 244 theorems of the four files, **eleven
  take a named hypothesis** — the table is in the drafts (Stage 6).

## Stage 3 — SAVED (FS131-L10A)
