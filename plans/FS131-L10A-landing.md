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

## Stage 4 — SAVED (FS131-L10A): `main` merged in (`f036f563`); the joined tree builds; no doubled name

- **The trial, before the merge** (`git merge-tree --write-tree --name-only HEAD origin/main` on Stage 3's tip `56e7456b`;
  `data/fs131/l10a/merge-trial-main.txt`; `origin/main` at `294603ae`, merge base `ff377526`): **one conflict,
  `scripts/Axioms.lean`**; `ARCHITECTURE.md` and `Proofs.lean`, which both sides changed, merge by themselves. Those three are the
  only paths both sides changed since the base — the three the brief foresaw. `main` changed 52 paths under `Proofs/` since the base,
  this line the four wave files and `Proofs.lean`; no Lean file under `Proofs/` conflicts.
- **The merge `f036f563`** (`git merge --no-ff --no-commit`, resolved, checked, committed; two parents).
  `scripts/Axioms.lean`, keep-both with **`main`'s blocks in their place and wave 10's four blocks after them**, above the
  `=== PURCHASED ===` banner (`tools/fs131_l10a_keepboth.py resolve --theirs-first`; `data/fs131/l10a/keepboth-main.txt`, exit 0):
  `#print axioms` lines **5,681 = this line's 4,043 + `main`'s 5,550 − the base's 3,912**; `git diff --numstat origin/main --
  scripts/Axioms.lean` reads 145 added, 0 removed; no name printed twice; the three plants fire.
  - **Three records of this line are gone, by `main`'s deletion and not by the resolution** — the check lists each as a note:
    `Plane.sq_norm_re_im`, `Plane.ArcMap.sq_norm_eq_re_im`, `Plane.ArcMap.HasDegree.eq`. This line held them unchanged from the base;
    wave 5's remedy pass on `main` deleted those declarations (`git grep` on `294603ae`: none of the three is declared; `main`'s
    `scripts/Axioms.lean` l. 6172 names the fold), so their records went with them. My first form of the check called these LOST;
    it now tells a line the other side deleted since the base from a line the resolution dropped, and still fails on the second.
  - **`Plane.conj_e`**: declared twice on this line (`Plane/SixFragment` l. 342, `Plane/Chord` l. 276), once on `main`
    (`Plane/Basic` l. 47). This line never changed those files, so the merge took `main`'s: after it `rg 'theorem conj_e\b' Proofs`
    finds the one declaration in `Plane/Basic`.
- **The index held the merge and nothing else** (`tools/fs131_l10a_mergeindex.py 294603ae scripts/Axioms.lean ARCHITECTURE.md
  Proofs.lean`; `data/fs131/l10a/mergeindex-main.txt`): 1,542 staged paths, 3 changed by both sides, 1,539 taken whole from `main`;
  PASS. Its control on this merge: with only the conflict path named it reports the two paths that merged by themselves (`BOTH sides
  changed, merged unread`), exit 1. Those two were then read against `main` (same log): `Proofs.lean` is `main`'s plus the four
  `Arith` imports (numstat 4, 0); `ARCHITECTURE.md` is `main`'s plus the four rows (4, 0). A wrinkle, said: my own tool
  `tools/fs131_l10a_keepboth.py` was edited for this merge and so differed from the index (the check's `DIRTY`); a merge cannot be
  committed by path, so I set the edited tool aside, ran the check clean, committed the merge, and committed the tool by path after
  it (`e7f2f833`).
- **After the merge the Lean tree is `main`'s plus the wave**: `git diff --name-only 294603ae HEAD -- Proofs Proofs.lean
  lakefile.toml lake-manifest.json lean-toolchain` names `Proofs.lean` and the four wave files and nothing else; the four wave files
  are unchanged from Stage 3's tip.
- **The build tree.** `main`'s compiled modules were copied in from the idle landing worktree of the example maps before the build
  (`rsync -a --update .claude/worktrees/fs131-wmb/.lake/build/ .lake/build/`; `data/fs131/l10a/rsync-wmb-build.txt`: 648 files
  written, 81 of them `.olean`, 29 new; that tree is at `4b46d755`, whose Lean inputs are `main`'s — `git diff --name-only
  4b46d755 294603ae -- Proofs Proofs.lean lakefile.toml lake-manifest.json lean-toolchain` is empty — and no `lean` or `lake` process
  was running in it). `.lake/build` stays this worktree's own directory. Lake checks each module's trace by hash, so a copied file
  that did not match its source would have been rebuilt.
- **The build of the joined tree** (`data/fs131/l10a/build-main.log`, `HEAD=e7f2f833`, no tracked file modified): **`build: OK — 467
  of 467 batches, 1 module(s) rebuilt, 0 module(s) with warnings, 8m22s`, `exit=0`**; the full log (`build-main-full.log`) holds 0
  `warning` lines and ends "Build completed successfully (5814 jobs)". The one rebuilt is `Proofs` (the import surface): the four
  wave modules import `SpectralChain` and Mathlib, which `main` did not change, so their compiled files stood.
- **`./scripts/dupnames.sh` on the joined tree, before anything else** (`data/fs131/l10a/dupnames-joined.log`, `exit=0`):
  **"dupnames: OK — no name is declared by two modules (23 generated on demand, listed above)"** — `main`'s own count of generated
  names. Before the merge this line would have failed it at `Plane.conj_e` (the planner's and the second planner's reports say so).
- **The kernel's own list** (`data/fs131/l5/count-modules.lean` on the joined library; `data/fs131/l10a/count-modules-joined.out`):
  `TOTAL declarations=13767 refutations=192 modules=1803 theorems=8956` — `main`'s 13,386 declarations and 8,677 theorems
  (`data/fs131/mc/count-modules-final2.out`) plus the wave's four modules: `CharacterColouring` 39 declarations and 25 theorems,
  `SpectralInputs` 100 and 83, `StandingFive` 161 and 121, `StationaryRatio` 81 and 50 — **381 declarations, 279 theorems, and no
  refutation**.

## Stage 4 — SAVED (FS131-L10A)

## Stage 5 — SAVED (FS131-L10A): the full gate on `999cde4a` — green at every step

**The gated commit is `999cde4a`**: Stage 4's tree (`main` at `294603ae` merged in) with the registrations of § 5.1. Runner
`data/fs131/l10a/run-pass.sh first` → the build, the kernel's list, `run-gate.sh first` (FS131-MC1's runner with its log directory
changed), then the two reconciliations and the digests — each step under the slot, each driver log ending in its exit status.
`data/fs131/l10a/run-gate-first.head` records `HEAD=999cde4a…` and **no tracked file modified**; `run-pass-first.out` reads exit 0
at every step. One pass: nothing was repaired between a red and a green.

### 5.1 What this job registered, by the gate's own procedures

- **`scripts/Axioms.lean`**: a block "FS131-L10A" of **128 records** — every theorem of the four modules that the planner's and
  the three implementers' blocks did not list (`CharacterColouring` 11, `SpectralInputs` 43, `StandingFive` 74; `StationaryRatio`
  none). The list is read from the kernel's own list of the library's theorems, not from the source
  (`tools/fs131_l10a_register.py` on `data/fs131/l5/count-modules.lean`'s two outputs; `data/fs131/l10a/register-before.txt`,
  `register-after.txt`: MISSING 128 → 0, STALE 0; its self-test: a record removed reads MISSING, a record naming nothing reads
  STALE). 5,809 `#print axioms` lines = `main`'s 5,550 + the wave's 259.
- **`scripts/Vacuity.lean`**: the entry "Wave 10's first pass (FS131-L10A …)", by the scan's procedure. The four modules declare
  ten hypothesis-formers (`data/fs131/l10a/census.lean`, wave 5's census with its scope changed; `census.out`); none has an
  unconditional `¬ P` or an `IsEmpty` at a closed instance.
  - **IN, by ruling 507 (d): `StationaryRatio.StationarySet`**, added to `trackedProps`, with its inhabitants named
    (`StationarySet.empty`, `StationarySet.parity`, and `cantorLevel` for X25B-L1's other hypotheses). **The entry says what the
    procedure's own law says of it**: a record that exists at every group by construction, so step (1) alone would leave it OUT,
    and **step (3)'s `VACUOUS` control cannot be planted** — no instance of it is empty. What entering it buys: a theorem taking
    it at a concrete group reads `UNKNOWN` until a closed inhabitant at that group is a declaration.
  - **OUT, nine**: `StationarySet.AEIndependent`; the named hypotheses `OrderBound`, `StandingFloor`, `TargetFloor` (closed
    propositions consumed as such — tracked, `cl2`'s `OrderBound (unitSet ⊥) (band 4) 168` and `StandingFloor 7`, `StandingFloor 5`
    would read `UNKNOWN`, true of a hand result not yet in the kernel and nothing the shrink-only baseline can hold: the `Row130M1`
    precedent); `BochnerOn`, `IsHaarFourier`, `IsSpectralMeasureOf`; `Interface.MulStable`, `Interface.NegCircle`.
- **`scripts/vacuity-controls.lean`, and three `expect` lines in `scripts/vacuity.sh`**: controls 63–65 — `GENERIC` at a variable
  group, `WITNESSED` at `ZMod 2` (by `parity`), `UNKNOWN` at `ℤ` (inhabited by `empty ℤ`, a construction the scan does not read:
  the load-bearing half). The self-test now plants 65.
- **`scripts/vacuity-baseline.txt`**: the header's two count lines, from `scripts/gate_report.py header`. **No entry added.**
- `scripts/axioms-controls.txt`: unchanged — the landing declares no axiom and no import, so the controls' counts (`imported=4`,
  `declared=1`, `library=1`) are the library's still, and the self-test is green as it stands.
- `ARCHITECTURE.md`, `Proofs.lean`: Stage 3's rows; the merge's four imports.

### 5.2 The steps, each saved log read

| step | result | log (`data/fs131/l10a/`) |
|---|---|---|
| build | `build: OK — all 1805 modules already up to date, nothing built, 0 module(s) with warnings`, exit 0; the full build of these Lean sources is Stage 4's: 467 of 467 batches, "Build completed successfully (5814 jobs)", **0 `warning` lines** | `build-first.log`; `build-main.log`, `build-main-full.log` |
| `sorry` | narrow pattern: **0** lines; `\bsorry\b`: 5, all prose, the five `main` holds (`Packed` l. 266, `Plane/Cover` l. 33, `Plane/CoverExamples` l. 13 and 6541, `BendStep` l. 345) | `sorry-narrow-first.txt`, `sorry-wide-first.txt` |
| doubled names, **before the audit** | **"dupnames: OK — no name is declared by two modules (23 generated on demand, listed above)"** | `dupnames-first.log`, `receipt-dupnames-first.log` |
| its self-test | "OK — all 15 controls behaved: every planted fault fired, and every partner passed." | `dupnames-selftest-first.log` |
| axioms | **"axioms: OK — 5783 clean, 17 axiom-free, 4 imported, 5 declared purchase(s)"**; "audited: 5809 records" | `axioms-first.log`, `receipt-axioms-first.log` |
| its self-test | "OK — every planted fault fired, and every partner passed." (23 controls) | `axioms-selftest-first.log` |
| vacuity | **"vacuity: OK"**; `declarations=13767 refutations-skipped=192`, `sites=1173 vacuous=0 stale=0 declared=3 witnessed=38 generic=1130 unknown=2`; baseline header "match (9 of 9 compared)" | `vacuity-first.log`, `receipt-vacuity-first.log` |
| its self-test | "OK — all 65 controls behaved: every one fired, and the silent ones stayed silent." | `vacuity-selftest-first.log` |
| architecture | "RESULT: PASS", exit 0 | `arch-first.txt` |
| guarded lint (`lake lint --no-build -- --no-build --trace`, `--mem 8`) | exit 0, "-- Linting passed for Proofs.", 14 linters each "Passed!" | `lint-first.log` |
| notes | `notes read: 196 LOCAL-SAID=31 NO-OBJECT=48 NONE-SAID=59 no-conflict=58`, **0 CONFLICT** — `main`'s own count: the check reads the plane's audited modules, which this landing does not touch, and none of the four `Arith` files; `tools/fs131_qa4_notes.py --self-test`: "OK (6 controls, 1 planted)" | `notes-first.txt` (through `tools/fs131_l5_notes.py`, as the last two landings ran QA4's tool), `notes-qa4-selftest-first.txt` |

### 5.3 The axioms, reconciled

- **Against `main`'s gated audit** (`data/fs131/mc/receipt-axioms-final2.log`, 5,550 records) by `scripts/gate_report.py axioms`
  (`digest-axioms-draft.txt`): **259 records added, every one CLEAN; 0 removed; 0 changed.** By axiom set: 254 on exactly
  `[propext, Classical.choice, Quot.sound]`, 3 on `[propext, Quot.sound]` (`coe_inclusion_subring`, `anyBelow_of`, `twoZ_ne_bot`),
  1 on `[propext]` (`usableBelow_347`, the `decide +kernel` below 347), 1 on no axiom (`squaresBelow_11`). 5,550 + 259 = 5,809;
  clean 5,525 + 258 = 5,783; axiom-free 16 + 1 = 17. Imported 4 and purchases 5 unchanged: the wave has no `axiom` and no
  `native_decide`.
- **Every theorem of the landing is audited** (`tools/fs131_l5_records.py` on the kernel's own list, `count-modules-first.out`
  against `data/fs131/mc/count-modules-final2.out`; `records-first.txt`, PASS): the library holds 8,956 theorems against `main`'s
  8,677 — 279 new, 0 gone; 26 are generated by Lean (`eq_1` 19, `eq_2`, `eq_def`, `congr_simp` 2, `mk.inj`, `mk.injEq`,
  `mk.sizeOf_spec`); **the 253 hand-written each have exactly one record under CLEAN: 248 on exactly the three, 3 on
  `[propext, Quot.sound]`, 1 on `[propext]`, 1 on none** — `CharacterColouring` 24, `SpectralInputs` 78, `StandingFive` 107,
  `StationaryRatio` 44. The other six of the 259 records are definitions that carry proofs, listed by I10B's block (`StationarySet.nb`,
  `pull`, `couple`, `majority`, `parity`, `cantorLevel`), each on the three.
- **The heads**, each "exactly the standard three" in that check — the 21 leaves of the skeleton (the list read from `f919973e` by
  script, Stage 2), the planner's three compositions over them, and the planner's proved rows with `si4_equivariant`: 32 names,
  `data/fs131/l10a/heads.txt`.

### 5.4 The vacuity counts, reconciled — and how the scan classes every new site

- **The counter agrees with both scans** (`tools/fs131_l5_vacdiff.py … --carriers-in
  HadwigerNelson.StationaryRatio.StationarySet`, `vacdiff-first.txt`, PASS): `declarations` 13,386 → 13,767 (+381:
  `CharacterColouring` 39, `SpectralInputs` 100, `StandingFive` 161, `StationaryRatio` 81 — four new modules, no count of a
  module of `main` changed); `refutations-skipped` 192 → 192 (the wave states no refutation).
- **Row for row against `main`'s gated scan** (1,217 rows): **0 rows lost; 37 added, every one in `Arith/StationaryRatio` and on
  the carrier `StationarySet`**:
  - **35 `SITE GENERIC`** — the 32 binders `(W : StationarySet G)` of the module's declarations, each at a variable group, and
    the three constructions concluding one at a variable group (`StationarySet.empty`, `pull`, `couple`). `generic` 1,095 → 1,130;
  - **1 `SITE WITNESSED`** — `StationarySet.parity : StationarySet (ZMod 2)`, a closed instance, witnessed by itself. `witnessed`
    37 → 38;
  - **1 `EVIDENCE WITNESS`** — `StationarySet.parity`.
  `sites` 1,137 → 1,173 (+36). **No new site reads `VACUOUS`, `STALE` or `UNKNOWN`; nothing asks for a baseline entry.**
- **What the scan does not read of the wave**: the nine hypothesis-formers left OUT raise no site, so the three closed hypotheses
  of hand results (`cl2`'s order bound at band 4; `StandingFloor 7`; `StandingFloor 5`) are invisible to it — they are named in
  the statements and listed in the drafts. A hypothesis set that holds together on no object of the library (`sp_if`'s) is a
  conjunction across binders, which this per-binder scan cannot see.

### 5.5 Each check's negative control, watched

| check | the plant | what went red |
|---|---|---|
| build's warning count | the tree as given (Stage 1) | 12 `declaration uses 'sorry'` warnings, against 0 |
| `sorry` scan | the tree as given (`git grep` at `ace98a35`, `sorry-narrow-asgiven.txt`) | 12 lines, against 0 |
| doubled names | its 15 controls | each fired |
| axioms | its 23 controls; the records check's five plants on this pass's log (`records-plant.txt`, exit 1: `sorryAx` on a head, a record dropped, doubled, moved under PURCHASED, a head on fewer axioms) | named each |
| vacuity | its 65 controls; **live, the carrier's name mistyped in `trackedProps`** (`vacuity-selftest-plant-mistyped.log`, exit 1: "3 of 65 control(s) did not behave" — exactly controls 63–65, each "absent"); the row check's four plants (`vacdiff-plant.txt`, exit 1: LOST, NOT NEW, FLAGGED, COUNTER-DISAGREES) | named each |
| architecture | live: `Arith/StandingFive`'s row with `SpectralChain` taken out of its imports column (`arch-plant-import.txt`) | "FAIL imports of Arith/StandingFive: stated-only [], real-only ['SpectralChain']", exit 1; restored by `git checkout`, PASS again |
| notes | its self-test, and the wrapper's (`notes-selftest.txt`: a conflicting note planted in `BendGap`, CONFLICT 0 → 1) | fired |
| lint | none at a landing (ruling 419 (b)); the wave's own control is I10B's: with the consuming `have`s removed the linter named exactly the seven arguments this landing dropped | — |
| this job's tools | `tools/fs131_l10a_quotes.py`, `_keepboth.py`, `_statements.py`, `_leaves.py`, `_tidyshape.py`, `_hyps.py`, `_register.py` `--self-test`; `_mergeindex.py` by live controls (Stages 2, 4) | each plant fired beside a faithful run |

### 5.6 The drafts, checked by the digest

Drafts 1 and 2 below, applied to a scratch copy of `CLAUDE.md`, are read by `scripts/gate_report.py` against this pass's logs:
§ Trust ledger "match (clean, purchases and imported compared)" (`digest-axioms-draft.txt`); § The gate "match (9 of 9 compared)"
(`digest-vacuity-draft.txt`). The unedited `CLAUDE.md` is flagged STALE by both digests until the filing (5525 → 5783; 13386 →
13767, 1137 → 1173, 37 → 38, 1095 → 1130).

### 5.7 Read against the informal statement, aloud

The three implementers read each of their leaves against its derivation entry (their records' theorem lists, quoted rows and
all); the statements of every leaf but the five tidied ones are verbatim theirs (Stage 2, by script). The five this job changed,
and the standing-five heads the front page will quote:

- `StationarySet.prob_le_ratio_mul [MeasurableNeg G] (W) {ν} [SigmaFinite ν] (hsymm : ν.map Neg.neg = ν) (hW : W.AEIndependent ν)
  : W.P W.B ≤ ratio ν * W.P (W.B ∪ W.nbhd ν)` — "for a stationary random set that is a.e.-independent for a σ-finite symmetric
  connection measure, `P(0 ∈ A) ≤ r · P(0 ∈ N[A])`". The row's (X25B-P's) words; the group needs a measurable negation and no
  measurable addition.
- `ratio_prod_le … (hG : νG.map Neg.neg = νG) (hH : νH.map Neg.neg = νH) : ratio (νG.prod νH) ≤ max (ratio νG) (ratio νH)` — "the
  stationary ratio of a product is at most the larger factor's". X25B-PZ. Not claimed, as in the row: equality. Both symmetry
  hypotheses are read (I10B's `ℤ/3 × ℤ/5` example shows they cannot both go).
- `ratio_prod_le_iSup_levels … (K : ι → OpenAddSubgroup Y) (hK0 : ∀ V ∈ nhds 0, ∃ k, (K k : Set Y) ⊆ V) : ratio (νX.prod νY) ≤
  ⨆ k, ratio (νX.prod (νY ∗ cosetAverage (K k)))` — "for a compact second-countable factor `Y` with open subgroups entering every
  neighbourhood of `0`, the ratio is at most the supremum over the levels". X25B-L1, **with the level pulled back to `X × Y`**: the
  right-hand side is not the ratio of the finite graph on `X × Y/K_k`, and no statement of this landing compares the two (I10B's
  finding 4; a row of the second pass, ruling 507 (b)). The hypothesis forces `ι` non-empty (take `V = univ`).
- `sp_if (I) (hBH : BochnerHerglotz (unitRing F)) (hmul : I.MulStable) (hcirc : I.NegCircle) … (hnh : ∀ a, ν ≠ a • m) : ∃ τ,
  IsFiniteMeasure τ ∧ RotInv F τ ∧ τ I.E = 0 ∧ ∫ χ, (χ 1 : ℂ).re ∂τ < 0` — "if some finite rotation-invariant `E`-null measure is
  not a multiple of Haar, some such measure has negative mean at `1`". J45-SP-if **over three named hypotheses**, one of which
  (`NegCircle`) no Lean object satisfies yet. What it is not: a statement about the arithmetic `E` — `I` is any interface.
- `spectral_carried_iff (t) (ht) (hcount) (hB : BochnerOn t) (T) (hT) (hadd) (hσ : IsSpectralMeasureOf T hT f σ) : σ (contChars t)ᶜ
  = 0 ↔ f ∈ contVec T hT (nhds 0)` — "the spectral measure of `f` is carried by the `t`-continuous characters iff `y ↦ V_y f` is
  `t`-continuous at `0`". J45-N2's first sentence, over `BochnerOn t`; real `L²`; `μ` any measure.
- `usable_card_ge (w) (hw : w.IsMaximal) (h : Nat.card (𝓞 F ⧸ w) % 4 = 3) : 347 ≤ Nat.card (𝓞 F ⧸ w)` — "**every usable residue
  field of `F` has at least 347 elements**". Not: that one has exactly 347 — the kernel exhibits no usable place of `F` at all
  (the attainment is [tools], ruling 520 (a)); the abstract clause's bound is attained at `ZMod 347` (a spec example).
- `seven_le_localBound (hFloor : StandingFloor 7) : 7 ≤ localBound standingField` — "**given the finite-target floor at seven**,
  `L(F) ≥ 7`". An implication from a hand result, not `L(F) ≥ 7`. `localBound` is an infimum over the stable primes of `F(i)`,
  a family the kernel knows non-empty (`exists_stablePrime_two`).
- `five_le_chromaticNumber (hFloor : StandingFloor 5) (hRow123 : min (localBound F) 5 ≤ χ(F²)) : 5 ≤ χ(F²)` — "given the floor
  at five and row 123's chain, `χ(F²) ≥ 5`". Two named hypotheses; MR is inside the second and is not imported here.
- What none of these is: a new value of `χ` of any plane; an unconditional `L(F) ≥ 7`.

## Stage 5 — SAVED (FS131-L10A)

## Drafts for the front page (FS131-L10A)

The gated commit is `999cde4a`; the landed tip differs from it in `plans/` and `data/` alone (Stage 6). The saved gate logs are
in this worktree under `build/gate/`; the copies are committed under `data/fs131/l10a/`: `receipt-axioms-first.log`,
`receipt-vacuity-first.log`, `receipt-dupnames-first.log`, the three self-tests' (`receipt-<gate>-self-test-first.log`), and the
full build `build-main-full.log`. To re-read: `python3 scripts/gate_report.py axioms data/fs131/l10a/receipt-axioms-first.log
data/fs131/mc/receipt-axioms-final2.log CLAUDE.md` and `python3 scripts/gate_report.py vacuity
data/fs131/l10a/receipt-vacuity-first.log data/fs131/mc/receipt-vacuity-final2.log scripts/vacuity-baseline.txt CLAUDE.md`.

1. **`CLAUDE.md` § Trust ledger**, the words "the current audit reads 5525 clean and 5 declared purchases, and 4 imported (and 16
   axiom-free; 5,550 records at the example maps' landing, FS131-MC1, 2026-10-06)" become: "the current audit reads 5783 clean and 5
   declared purchases, and 4 imported (and 17 axiom-free; 5,809 records at wave 10's first landing, FS131-L10A, 2026-10-06)". From
   `data/fs131/l10a/axioms-first.log`: "audited: 5809 records — 5783 clean on the standard axioms, 17 axiom-free, 4 imported
   (resting on a declared outside theorem), 5 declared purchase(s)" and "==> axioms: OK — 5783 clean, 17 axiom-free, 4 imported, 5
   declared purchase(s)". (The logs' UTC date: `20261006T145710Z`.)
2. **`CLAUDE.md` § The gate**, the two count lines "`declarations=13386 refutations-skipped=192 sites=1137`, `vacuous=0 stale=0
   declared=3 witnessed=37 generic=1095 unknown=2`" become "`declarations=13767 refutations-skipped=192 sites=1173`, `vacuous=0
   stale=0 declared=3 witnessed=38 generic=1130 unknown=2`". From `data/fs131/l10a/vacuity-first.log`: "scanned:
   declarations=13767  refutations-skipped=192" and "sites:   sites=1173  vacuous=0  stale=0  declared=3  witnessed=38
   generic=1130  unknown=2". The baseline's two entries are unchanged (`hexShell_plane5`, `hexShell_plane6`).
3. **`tools/claude_md_fact_audit.py`'s `GATE_CHANGES`**, after the `(("5196", "5"), ("5525", "5"))` entry:
   `(("5525", "5"), ("5783", "5")): "FS-131, wave 10's first landing (FS131-L10A; .claude/worktrees/fs131-w10l/build/gate/axioms/20261006T145710Z-778814.log, copy
   data/fs131/l10a/receipt-axioms-first.log, gated commit 999cde4a): 5,809 records, 5,783 clean, 17 axiom-free, 4 imported, 5 purchases",`
4. **`LEAN.md` § The gate**, one count: "`--self-test` plants sixty-two controls" becomes "`--self-test` plants sixty-five controls"
   (`vacuity-selftest-first.log`: "OK — all 65 controls behaved"). The axiom audit's 23 and the doubled-name check's fifteen stand.
5. **The named hypotheses each landed theorem rests on, by name** (read from the signatures by `tools/fs131_l10a_hyps.py`,
   `data/fs131/l10a/hyps-tidy.txt`: of the 244 theorems of the four files, eleven take one; the planner's § 5.5 table checked
   against it — every row of that table has its consumers below, and no theorem takes a named hypothesis the table lacks). None is
   an `axiom`: each is a `Prop` argument, visible in the statement, and `ARCHITECTURE.md` § Trust gains no purchase.

   | named hypothesis | states | whose | the landed theorems that take it | a Lean model on `main` |
   |---|---|---|---|---|
   | `SpectralChain.BochnerHerglotz G` (on `main` since FS-100) | Herglotz–Bochner on a discrete abelian group, with uniqueness | classical (Rudin 1.4.3, 1.3.6; the read-back against the page is owed, the planner's § 5.5) | `SpectralInputs.ext_of_fourier`, `exists_isHaarFourier`, `IsHaarFourier.map_mulRight`, `contChars_haar_null`, `sp_if` | none in the kernel |
   | `SpectralInputs.BochnerOn t` | a measure with `t`-continuous transform is carried by the `t`-continuous characters | classical, for a topology induced from an LCA group | `spectral_carried_iff` | `bochnerOn_bot` (the discrete topology) |
   | `Interface.MulStable` | `m⁻¹(E) ⊆ E` | ours: J45 § 4.2 step 2, on J28V-7 | `sp_if` | true of `Interface.trivial` (empty `E`); not a declaration |
   | `Interface.NegCircle` | a rotation-invariant probability with negative mean at `1`, carried by a set that does not leave `E`ᶜ | ours: J45 § 4.2 step 3 | `sp_if` | **none** (planned: `negCircle_trivial_bot`, second pass) |
   | `CharacterColouring.OrderBound (unitSet ⊥) B N` — the order bound | band characters in `T + A` are in `T_N + A` | ours: FS89-S0A-3 (`k = 4`, `N = 168`, on Weil), J08-11 (5), J08-10 (6) | `gluing_iff_of_orderBound`; `cl2` (at band 4 with 168, and at band 5 with `N₅`) | none |
   | RQ₄, RQ₅ (`cl2`'s `hRQ4`, `hRQ5`) | `Θ_k(ℤ[U_ℚ]) ⊆ T + A`, `k = 4, 5` | ours: FS89-D2-T1, FS89-D5-T2 | `cl2` | none |
   | `StandingFive.StandingFloor n` | the floor at `U₁₂₈` and at every `Γ_Q`, `Q ≡ 3 (mod 4)`, `Q ≥ 347` | ours: G56 ([tools]/[hand], on Weil) | `le_localBound` (any `n`), `seven_le_localBound` (7), `five_le_chromaticNumber` (5) | at `n = 0` only (`targetFloor_zero`); at 7 the second pass states it over `KloostermanBound` and one leaf |
   | `Row123Chain` (`five_le_chromaticNumber`'s `hRow123`) | `min (L(F)) 5 ≤ χ(F²)` at this field | ours: row 123; in the kernel over named hypotheses, `SpectralChain.min_localBound_five_le_chromaticNumber` | `five_le_chromaticNumber` | — |

   **Resting on no named hypothesis**: every other theorem of the four files — among the rows, FS89-S0A-2 (`gluing`,
   `gluing_field`), FS89-S0A-10's uniform form (`gluing_iff_uniform`), the erratum's `A` (`mem_archimedean_unitRing_iff`),
   J45-SP-oi (`sp_only_if`, `sp_only_if_interface`), J45-N2's factor half (`measurableSet_factorSigma_iff`, `contVec_eq_lpMeas`,
   `measurableSet_preimage_factorSigma`, the three `condExpL2` statements), J45-SI-4 (`si4`, `si4_equivariant`), X25B-P, X25B-PZ,
   X25B-L1, and every unconditional clause of TC1-STANDING-FIVE.
6. **The open gate items at this landing** — theorems whose hypotheses no Lean object on `main` satisfies at once. By reading,
   one mind; the mechanical part is `data/fs131/l10a/gateitems.out` (each head's docstring searched for an inhabitant note: 5 of
   the 32 heads carry one, 7 take no explicit hypothesis, 20 carry none of their own — most of those are covered by their module's
   "Inhabitants" paragraph; the ones that are not are below).
   - **`sp_if`** (`Arith/SpectralInputs`): `Interface.NegCircle` has no Lean model; its docstring now says so and names the planned
     one (`negCircle_trivial_bot`, `Arith/NegCircleModel`, FS131-I10F's leaves on the second pass). Closed when that lands
     (ruling 510 (d)). `MulStable` at `Interface.trivial` is true and is no declaration either.
   - **`contChars_haar_null`**: a topology whose continuous characters are measurable, point-separating and proper has no model
     in the file — the discrete topology fails `hproper` — and its docstring carries no inhabitant note. The arithmetic instance
     is J45-N1 (a)–(b), not stated (the third planning pass, ruling 510 (b)).
   - **`spectral_carried_iff`**: `BochnerOn` has `bochnerOn_bot` and the identity family has `contVec_id`, but no declaration
     exhibits an `IsSpectralMeasureOf T hT f σ`, and the docstring carries no note.
   - **`si4`, `si4_equivariant`**: the hypothesis `hdisj` (orthogonal conditional laws across every edge) has no named model; a
     deterministic proper colouring satisfies it on paper. No note in either docstring.
   - **`usable_card_ge`, `no_small_usable`** (`Arith/StandingFive`): **no usable place of `F` is exhibited in the kernel**, so
     "every usable residue field has at least 347 elements" is, to the kernel, a bound over a family not known non-empty. The
     module docstring says where the inhabitant is known ([tools]: 347 splits completely, `tools/fs131_k10_usable.py`); ruling
     520 (a) left the attainment out of the rows. The abstract clause `card_ge_of_usable` has its model (`ZMod 347`, a spec example).
   - **By design, said in the docstring**: `sp_only_if_interface` ("INHABITANT: none known — such a `τ` is the open sign
     problem"); `sp_only_if` is satisfiable.
   - **Hypotheses that are hand results, not structures** — `OrderBound`, RQ₄, RQ₅, `StandingFloor 7` and `5`, `Row123Chain`,
     `BochnerHerglotz` — are draft 5's table: each leaves when discharged (`LEAN.md` § Assumptions).
   - **Not on this list any more**: the three rows of `Arith/StationaryRatio`, each of which now names the inhabitant of its
     hypotheses in its docstring and is instantiated at it in the file's Spec section.
7. **The implementers' drafts, gathered, and corrected for what the join changed.** Each names its slot; "[kernel]" below means
   on `main` after this landing, audited by the gate on `999cde4a` on the axioms shown.
   - **`plans/LEAN-BACKLOG.md`, the rows' state** (replacing "stated, `sorry`" / "Grade as filed"):
     - FS89-S0A-2 — [kernel], at a wider class: `CharacterColouring.gluing` (a ring with an invertible integer `m ≥ 2`, a module
       spanned by a set stable under the base's units, any band), and the row `gluing_field`. Standard three; no hypothesis from
       outside. (FS131-K10.)
     - FS89-S0A-10 — [kernel]: the uniform form `gluing_iff_uniform` unconditional at every band; the row's form
       `gluing_iff_of_orderBound` **over the band's order bound** (`OrderBound`, held at `k ∈ {4, 5, 6}` only). (FS131-K10.)
     - FS89-CL2 — [kernel over named hypotheses]: `cl2` over RQ₄, N₀ (`OrderBound … (band 4) 168`), RQ₅ and J08-11's bound. A
       composition; nothing of the rational statements is proved. (FS131-K10.)
     - The erratum's `A` (C109) — [kernel]: `mem_archimedean_unitRing_iff`, `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`. (FS131-I10A.)
     - J45-SP-oi — [kernel]: `sp_only_if` (at its class: one hypothesis of the row's four is read), `sp_only_if_interface` (the
       row's words). (FS131-K10.)
     - J45-SP-if — [kernel over named hypotheses]: `sp_if` over `SpectralChain.BochnerHerglotz`, `Interface.MulStable`,
       `Interface.NegCircle`. **Corrected by the join**: it no longer takes `[Countable (unitRing F)]`. An open gate item
       (`NegCircle`).
     - J45-N2 — [kernel] whole: `measurableSet_factorSigma_iff`, `contVec_eq_lpMeas`, `measurableSet_preimage_factorSigma`,
       `condExpL2_mem_contVec`, `condExpL2_eq_self_iff`, `inner_sub_condExpL2_eq_zero` with no hypothesis from outside;
       `spectral_carried_iff` over `BochnerOn t`. **Corrected by the join**: `spectral_carried_iff` holds for any measure `μ`.
     - J45-SI-4 — [kernel] whole: `si4`, `si4_equivariant` (almost surely, where the entry says surely: K10b's read-back), no
       hypothesis from outside.
     - J45-N1 — clause (c) [kernel over a named hypothesis]: `contChars_haar_null` over `SpectralChain.BochnerHerglotz`; (a), (b)
       not stated.
     - X25B-PZ — [kernel]: `StationaryRatio.ratio_prod_le`, standard three, no hypothesis from outside Mathlib, with its lemma
       X25B-P (`StationarySet.prob_le_ratio_mul`). **Corrected by the join**: the row itself is now stated at the class its proof
       reads (commutative groups with a σ-algebra and measurable negation, σ-finite symmetric connection measures; no measurable
       addition) — there is no `ratio_prod_le_of_symm` any more.
     - X25B-L1 — [kernel]: `StationaryRatio.ratio_prod_le_iSup_levels`, the same axioms, no hypothesis from outside Mathlib.
       **Corrected by the join**: any family of open subgroups entering every neighbourhood of `0` (no `Antitone`, any index
       type), `ν_Y` s-finite, any `ν_X`; there is no `…_of_shrink` any more. **The levels are the graphs pulled back to `X × Y`**
       (`ν_Y ∗ m_{K_k}`): the comparison with the finite graphs on `X × Y/K_k` is not stated (ruling 507 (b)).
     - TC1-STANDING-FIVE — its unconditional clauses [kernel]; "so `L(F) ≥ 7`" [kernel over `StandingFloor 7`]; "given MR,
       `χ(F²) ≥ 5`" [kernel over `StandingFloor 5` and `Row123Chain`] (I10C's draft 1, below).
   - **`LEDGER.md` § B, row `TC1-STANDING-FIVE`** (l. 1351; the cell "derived (PARI exact); one mind; given MR"), I10C's draft with
     "on `fs131-w10c` (lands with wave 10)" struck: "[kernel]: `F = ℚ(√3, √11, η)`, `η = ζ + ζ¹² + ζ¹⁷ + ζ²⁸`
     (`StandingFive.cev_hvec`), is a number field (`numberField_standingField`) of degree 28 (`finrank_standingField`), totally
     real (`isTotallyReal_standingField`), containing `K` (`K_le`), with `[E₇:ℚ] = 7` (`finrank_E7_and_K`); exactly two primes of
     `F(i)` lie above 2 (`ncard_primes_above_two`), both stable (`comap_conj_of_two_mem`), each with residue field of `128²`
     elements on which conjugation is not the identity (`card_quotient_of_two_mem`); every usable residue field has at least 347
     elements (`usable_card_ge`, `no_small_usable`). **Over the named hypothesis `StandingFloor n`** (G56's floor at `U₁₂₈` and
     at every `Γ_Q`, `Q ≡ 3 (mod 4)`, `Q ≥ 347`; [tools]/[hand] on Weil): `L(F) ≥ n` (`le_localBound`, `seven_le_localBound`);
     **and over `Row123Chain`** (`min (L(F)) 5 ≤ χ(F²)`, row 123, MR inside it): `χ(F²) ≥ 5` (`five_le_chromaticNumber`). Axioms:
     the standard three. That 347 is attained stays [tools]." The row's own words "has L ≥ 7" and "needs five" stay conditional.
   - **`LEDGER.md` § B, row `FS100-TCA`** (l. 972; after "`r(G × H) ≤ max`"), I10B's clause: "— in the kernel in stationary form,
     `StationaryRatio.ratio_prod_le` (X25B-PZ) with its lemma `StationarySet.prob_le_ratio_mul` (X25B-P), standard three axioms".
   - **`LEDGER.md` § B, row `FS89-S0A-2`** (l. 694; grade "hand", hand-off "stub"): "[kernel]: `CharacterColouring.gluing`,
     `gluing_field`; with the erratum's `A` read back as `Hom_ℚ(F(i), ℝ) mod 1` (`mem_archimedean_unitRing_iff`); standard three
     axioms". **A correction to I10A's draft**: its slot words ("after 'with `A(R_F)` they hold'") are not in `LEDGER.md` on
     `main` (`grep -n 'they hold' LEDGER.md`: no line); the clause is offered for this row instead.
   - **`plans/FS131-kernel-plan.md` § 7.4** (the named hypotheses' table): the rows of draft 5; the planner's price for
     `Interface.NegCircle` "an hour" becomes I10A's "a job's stage: the circle measure, its invariance, and `J₀(π) < 0` with a
     margin of 0.04 on the crude bound", beside K10b's cheaper model at `F = ℚ`. Its § 5.6 price rows: I-A 1,550 lines planned,
     about 1,020 written; I-B 1,900 planned, about 660 written; I-C 1,300 planned, 1,283 in the file.
   - **`plans/FS131-w10-kernel-plan.md` § 2.2 item 8** ("To be confirmed by the implementer's first pass"): "confirmed by proofs
     (FS131-I10B): no Haar measure on the group is read; the pigeonhole holds for any probability on any parameter space" — and
     since this landing the rows are stated so.
   - **`data/fs131/k1/dispositions.csv` line 179**, reason (I10C's draft 5, with the branch name struck): "its unconditional
     clauses (the field, degree 28, [E7:Q] = 7, its two places above 2, no usable residue field below 347) in the kernel; 'so L(F)
     >= 7' as an implication from the finite-target floor (StandingFloor, outside the backlog); 'given MR, chi(F^2) >= 5' from
     that floor at five with Row123Chain".
   - **`LEAN.md` § Searching — Lean**: the three implementers' facts and the planner's are filed (inventory items 493–520); none
     is drafted again here.
   - **`BIBLIOGRAPHY.md`**: no new key used by the landed files. The debts stand: Rudin 1.4.3 / 1.3.6 read against the page (for
     `BochnerHerglotz`, `BochnerOn`).
8. **The Frontier line and the Proof Atlas.** No value moved and the milestone is not closed by one wave's landing; what moves is
   grades: FS89-S0A-2, FS89-S0A-10 (uniform form), J45-SP-oi, J45-N2's factor half, J45-SI-4, X25B-PZ, X25B-L1 and the
   unconditional clauses of TC1-STANDING-FIVE from [hand] or [derived] to **[kernel]**; FS89-S0A-10 (the row's form), FS89-CL2,
   J45-SP-if, J45-N2's spectral half, J45-N1 (c), and TC1-STANDING-FIVE's two conditional clauses to **[kernel over named
   hypotheses]**, each by the names of draft 5. `CLAUDE.md` § What the kernel holds may say, of this landing: "wave 10's first
   pass — the gluing of character colourings from `ℚ` to every real field, the stationary ratio of a product and of a profinite
   factor, the spectral inputs of row 123's chain over named classical hypotheses, and the standing-five field `K·E₇` (degree 28,
   two inert places above 2 of norm 128, every usable residue field at least 347), with `L(F) ≥ 7` an implication from the
   finite-target floor".
9. **For the second pass's join** (`fs131-w10k` and the three branches cut from it; none was touched). What changes under it:
   `StationarySet.prob_le_ratio_mul_of_symm`, `ratio_prod_le_of_symm`, `ratio_prod_le_iSup_levels_of_shrink` are gone (the row
   names carry their statements); `ratio_prod_le_iSup_levels` takes no `hK` and its `K` is indexed by any type; `sp_if` and
   `spectral_carried_iff` lost one instance argument each. No code on those four branches calls any of them (`git grep`: only
   `NegCircleModel`'s module docstring names `sp_if`). `scripts/Axioms.lean`'s wave-10 blocks sit above the `=== PURCHASED ===`
   banner, where the second pass's blocks will conflict again: keep both. `StationarySet` is now a tracked carrier: a theorem
   taking one at a concrete group needs a closed inhabitant at that group, and each new binder at a variable group is one more
   `GENERIC` site to reconcile. When `negCircle_trivial_bot` lands, `sp_if`'s docstring sentence and the module docstring's line
   are to be rewritten to name it, and the item leaves draft 6.

## Theorems this phase proved, final

All **[kernel]**: built by this worktree's `./scripts/build.sh` (`data/fs131/l10a/build-main.log`, then `build-first.log` on the
gated commit), each audited by `scripts/axioms.sh` on `999cde4a` under CLEAN on the axioms shown
(`data/fs131/l10a/receipt-axioms-first.log`; `records-first.txt`). Addresses are `Proofs/HadwigerNelson/Arith/`.

**New in this job: no theorem.** This job proved nothing of its own; it changed five statements by ruling, and each of the five is
the theorem its implementer had already proved at that class:

- `StationaryRatio.lean`: `StationarySet.prob_le_ratio_mul` (X25B-P), `ratio_prod_le` (X25B-PZ), `ratio_prod_le_iSup_levels`
  (X25B-L1) — I10B's `…_of_symm` / `…_of_shrink` statements under the rows' names. [kernel], exactly
  `[propext, Classical.choice, Quot.sound]`. Read against: § 5.7.
- `SpectralInputs.lean`: `sp_if` (J45-SP-if; over `BochnerHerglotz`, `Interface.MulStable`, `Interface.NegCircle`),
  `spectral_carried_iff` (J45-N2, spectral half; over `BochnerOn t`) — I10A's proofs less one unread instance argument each.
  [kernel], exactly the three. Read against: § 5.7.

**Landed by this job, proved by FS131-K10, -I10A, -I10B, -I10C** (their records hold the lists and the readings): the 253
hand-written theorems of `CharacterColouring` (24), `SpectralInputs` (78), `StandingFive` (107), `StationaryRatio` (44) — 248 on
exactly the three, `coe_inclusion_subring`, `anyBelow_of`, `twoZ_ne_bot` on `[propext, Quot.sound]`, `usableBelow_347` on
`[propext]`, `squaresBelow_11` on no axiom. The heads, each on exactly the three (`records-first.txt`):
- FS89: `gluing`, `gluing_field` (S0A-2); `gluing_iff_uniform`, `gluing_iff_of_orderBound` (S0A-10); `cl2` (CL2);
  `mem_archimedean_unitRing_iff` (the erratum's `A`);
- J45: `sp_only_if`, `sp_only_if_interface` (SP-oi); `sp_if` (SP-if); `measurableSet_factorSigma_iff`, `contVec_eq_lpMeas`,
  `measurableSet_preimage_factorSigma`, `spectral_carried_iff` (N2); `contChars_haar_null`, `exists_isHaarFourier` (N1 (c));
  `si4`, `si4_equivariant` (SI-4);
- X25B: `StationarySet.prob_le_ratio_mul` (P), `ratio_prod_le` (PZ), `ratio_prod_le_iSup_levels` (L1);
- TC1-STANDING-FIVE: `numberField_standingField`, `finrank_standingField`, `isTotallyReal_standingField`,
  `ncard_primes_above_two`, `comap_conj_of_two_mem`, `card_quotient_of_two_mem`, `usable_card_ge`, `no_small_usable`,
  `stablePrime_card`, `le_localBound`, `seven_le_localBound`, `five_le_chromaticNumber`.

**Not proved, and not claimed**: any named hypothesis of draft 5 — in particular `StandingFloor 7`, so `L(F) ≥ 7` is an
implication; that a usable place of `F` exists, or attains 347; a model of `Interface.NegCircle`; the comparison of X25B-L1's
pulled-back level with the finite quotient graph; J45-N1 (a)–(b), J45-SI-5, J45-SI-J, J45-SI-C (the second and third passes).

## Slips, my own

- **A false alarm in my own check, on its first run against `main`**: `tools/fs131_l10a_keepboth.py` called three records LOST
  that `main` had deleted with their declarations. The count line was right and the three were what the merge should drop; the
  check now lists a line the other side deleted since the base as a note and fails only on a line the resolution lost (Stage 4).
- **I edited one of my tracked tools while a merge was open**, which made the merge-index check read `DIRTY`. I set the edit
  aside, ran the check clean, committed the merge and then the tool. Nothing reached the merge commit but the merge.
- **One build after the two implementers' merges, not one after each.** I read "each checked before the next" as the script
  checks (index, byte-identity with the owner's tip) and built once, the two merges changing disjoint Lean files. Said in § 2.3.
- Two of my tools were wrong on their first run and repaired before any result was read from them: the statements tool's
  rename plant could not be planted on `StationaryRatio` (it used the last component of a dotted name); the registration tool's
  STALE test read 935 older records as stale (it compared short names printed under an `open` with full names) and is now scoped
  to the wave's namespaces.
- **`scripts/vacuity.sh` is not named in my brief's touches**; the scan's procedure, step (3), puts a control's `expect` line
  there, and I added three. Held for the coordinator below.
- The tidied build of Stage 3 ran on a tree with the tidies uncommitted (its log's `DIRTY` lines say so); the gate's own build
  is on the gated commit.
- I did not read the harness's token count at the saved stages; I have no instrument for it in this session and say so rather
  than give a number I did not read.
