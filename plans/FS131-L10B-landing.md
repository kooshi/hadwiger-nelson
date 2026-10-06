# FS131-L10B — wave 10's second landing: the proved second pass and the import of Weil's bound joined with `main` and with the proof of Falconer's lemma, the ruled tidies, the gate (de Bruijn, the implementer)

*Brief: `data/fs131/briefs/FS131-L10B-wave10-land.md` (on `main`). Branch `fs131-w10m`, worktree `.claude/worktrees/fs131-w10m`, cut from
`fs131-w10k`'s history at `248f8f4f`. Started 2026-10-06 19:05 UTC. Logs and working files: `data/fs131/l10b/`.*

## Theorems this phase proved

*Filled at each saved stage; the final list is the section "Theorems this phase proved, final" at the end of this file.*

## Stage 1 — SAVED (FS131-L10B): the readback, the build as given

### 1.1 The brief's quotations (standing rule 3)

By script, `tools/fs131_l10b_quotes.py --self-test <brief> <main's tree>` (the last landing's reader under this job's name): it reads
every `> quote` / `> — source:` pair of the brief and counts the quote's verbatim occurrences in the named file. **Twenty-three of
twenty-three pairs match, each exactly once** (`data/fs131/l10b/quotations.txt`, exit 0): `CLAUDE.md` § The standard of evidence (1),
§ Trust ledger (1) and § The gate (1), read from disk on `main`; `plans/FS131-close-inventory.md` items 551, 535, 538, 542, 547, 554,
555, 559, 556 (9); the third planner's § 16.6 on `fs131-w10k` (2); `MajorityVote.lean`, `WeilKloosterman.lean` (4 heads),
`Floor128.lean`, `SpectralInputs.lean` on this branch (7); `FalconerReduction.lean` and `MetricalBoundary.lean` on `fs131-wf1` (2). The
script's two plants fire beside the faithful run: one character of a quote changed reads MISSING; a source that does not exist reads
NO-SOURCE. **No mismatch.**

### 1.2 What was read, and how far

- The brief; `plans/STANDING-RULES.md`; `LEAN.md` (on `main`) whole; `RUNNING.md` § Building and § Make the gate fail, whole.
- Inventory items 535, 538, 542, 547, 551, 554, 555, 556, 559, 562, each whole.
- The third planner's record on `fs131-w10k`, `plans/FS131-w10-kernel-plan.md`: its theorem lists (FS131-K10b's and -K10c's) and
  Stages 10–16 whole (§§ 15.2–15.4, 16.2, 16.6, 16.7 among them); Stage 17 to its first two bullets; Stages 1–9 by headings.
- The three second-pass implementers' reports on this branch, each whole: `data/fs131/reports/FS131-I10D.md`, `-I10E.md`, `-I10F.md`.
- The Falconer job: its report `data/fs131/reports/FS131-IF1.md` (on `fs131-wf1`) whole; of its record
  `plans/FS131-IF1-implementation.md`, Stages 4–5, "Drafts for the front page" and its theorem list whole, Stages 1–3 by headings.
- FS131-T5's record on `fs131-t5`, the section "What is on its way", whole (the rest by headings).
- The last landing's record `plans/FS131-L6A-landing.md` (on `main`): Stages 1–6 whole, the drafts' head; its three runners
  `data/fs131/l6a/run-build.sh`, `run-gate.sh`, `run-pass.sh`, and the tools it names (`tools/fs131_l6a_*.py`, `tools/fs131_l5_records.py`,
  `_vacdiff.py`, `_notes.py`, `data/fs131/l5/count-modules.lean`) by their docstrings, `_keepboth.py` and `_quotes.py` whole.
- Commit `082f86c9`'s edit of `scripts/axioms-controls.txt`, and `fs131-wf1`'s edit of the same file — the pattern for step 2.

### 1.3 The branch tips, as fetched (2026-10-06 19:10 UTC)

`origin/fs131-w10m` = `248f8f4f` (this tree's `HEAD`, the import's commit); `origin/main` = `615c715c` (the brief was written at
`a17694cf`; the two commits since are under `plans/` and `data/` — Stage 2 names the diff); `origin/fs131-wf1` = `a61f0d14`, the tip the
brief names; `origin/fs131-w10k` = `e09209e4` (the third pass's tip, with its three row modules; not merged here); `origin/fs131-t5` =
`4dd69014` (not merged here). Merge bases with this tip: `main` — `c20b57a0` (the first pass as landed); `fs131-wf1` — `c20b57a0`
(`fs131-wf1` itself was cut from `main` at `ca598960`). `main`'s Lean inputs are the last landing's gated commit's: `git diff
--name-only 7e67af3b origin/main -- . ':!plans' ':!data'` names `BIBLIOGRAPHY.md`, `CLAUDE.md`, `LEAN.md` and
`tools/claude_md_fact_audit.py` and nothing else, so `main`'s gated receipts are FS131-L6A's (`data/fs131/l6a/*-first.*`).

What each side changed since its base, outside `plans/`, `data/` and `tools/`:

| side | Lean files | registry files |
|---|---|---|
| this line since `c20b57a0` | eleven new modules of `Arith/`: `FactorAction`, `Floor128`, `FloorPlanes`, `GapSeven`, `MajorityVote`, `NegCircleModel`, `NormOneTarget`, `ProductFactor`, `RatioBound`, `TargetFloors`, `WeilKloosterman` | `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean` |
| `main` since `c20b57a0` | fourteen new modules of `Plane/Saturated/` | `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean`, `scripts/Vacuity.lean`, `scripts/vacuity-baseline.txt`; `CLAUDE.md`, `LEAN.md`, `BIBLIOGRAPHY.md` |
| `fs131-wf1` since `c20b57a0` | `Plane/FalconerReduction` (changed), `Plane/MetricalBoundary` (new) | `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean`, `scripts/axioms-controls.txt` |

**No Lean file is changed by two sides.** The brief counts "ten more modules" of the second planning pass and the import's: eleven
new files in all on this line.

### 1.4 The build as given

`data/fs131/l10b/build-asgiven.log` (runner `data/fs131/l10b/run-build.sh asgiven`; `HEAD=248f8f4f`, no tracked file modified): **`build:
OK — 469 of 469 batches, 1 module(s) rebuilt, 0 module(s) with warnings, 8m58s`, `exit=0`**; the one rebuilt is `Proofs` (the import
surface; this tree's `.lake/build` is a copy). The full log (`build-asgiven-full.log`) holds **0 `warning` lines** and ends "Build
completed successfully (5917 jobs)". The gate's narrow `sorry` pattern over `Proofs/` and `Proofs.lean`: 0 lines
(`sorry-narrow-asgiven.txt`). So `248f8f4f` holds no `sorry`, as the brief says.

### 1.5 The trial merges, before any is made

`git merge-tree --write-tree --name-only`, nothing checked out (`data/fs131/l10b/merge-trial-*.txt`):

| trial | conflicts | as the brief found |
|---|---|---|
| `origin/main` (`615c715c`) on this tip | `scripts/Axioms.lean` | yes — one hunk, two adjacent additions with no base between them (this line's two blocks FS131-K10b and -K10c; `main`'s wave-6 blocks), above the `=== PURCHASED ===` banner |
| `origin/fs131-wf1` on this tip | `ARCHITECTURE.md`, `scripts/Axioms.lean` | yes |
| `origin/fs131-wf1` on `origin/main` | none | yes |

`ARCHITECTURE.md` and `Proofs.lean` are changed by both this line and `main` and merge by themselves: the three-way check reads them
all the same (Stage 2). Each trial is repeated on the commit it will be merged into, before the merge.

### 1.6 What the joined state is, read from both sides before the merge

- `scripts/Axioms.lean`, IMPORTED: this line appended `declareImport` for `StandingFive.kloosterman_bound` and its eight records
  below Falconer's; `fs131-wf1` deleted Falconer's `declareImport` line and its four records there, re-entered the four under CLEAN
  beside wave 2's `FalconerReduction` records with `falconer_lemma2_nonempty` itself and `MetricalBoundary`'s fifteen, and rewrote
  two sentences of the section's prose to "the library declares no import at present … so this section is empty". **Joined**: one
  `declareImport` (Weil's), eight records under IMPORTED, Falconer's four under CLEAN; the prose says what is then true (one import).
- `ARCHITECTURE.md` § 5: `fs131-wf1` removed Falconer's row and wrote "None at present: the library declares no `axiom`…"; this line
  added Weil's row. **Joined**: Weil's row alone; a line of current state for Falconer's lemma that does not say "none".
- `scripts/axioms-controls.txt`: on this line and on `main` the three library-state controls read one declared import with four
  records (`4 / 1 / 1`, `5 / 2 / 2`, two consequences naming Falconer's); on `fs131-wf1` none (`0 / 0 / 0`, `1 / 1 / 1`, the banner
  alone). **Joined**: one declared import with eight records — `8 / 1 / 1`, `9 / 2 / 2`, and `banner_dropped`'s two consequences
  naming one of Weil's records and `kloosterman_bound`. Shown red before and green after (Stage 2).

### 1.7 The kernel's statements, before anything is changed

`data/fs131/l10b/kernel-sigs.lean` (new, this job's) prints, from each constant's stored type, the signature and every `∀`-binder of
every theorem and axiom of the wave's modules and of sixteen named heads of modules landed earlier; its reader
`tools/fs131_l10b_kernelsig.py` compares them with the binders each file shows — the declaration's own and every `variable` in
scope. On the tree as given (`kernel-sigs-asgiven.out`, exit 0): 178 records (176 theorems, 2 axioms), 17 generated by Lean, 161
compared with their files. This is the instrument of the brief's step 4; its run on the joined tree, its controls and the reading
are Stage 4's. Kept here as the "before" of the one ruled statement change: the kernel holds `ae_eq_measurable_of_majority` with
`[Finite K]`, `(hG : Measurable G)` and `(hc : ∀ (x : I), Measurable (c x))`.

### 1.8 What I may and may not change

Mine: the merges' files; in the wave's modules and the import's, the ruled tidies of the brief's item 3 and their docstring lines and
nothing else; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/axioms-controls.txt`; `scripts/Vacuity.lean`,
`scripts/vacuity-controls.lean`, `scripts/vacuity.sh` as the scan's own procedure asks, `scripts/vacuity-baseline.txt` on the
coordinator's word only; this record; `tools/fs131_l10b_*.py`; `data/fs131/l10b/`; the report; `main` by the fast-forward push alone.
Not mine: any statement but `ae_eq_measurable_of_majority`'s; `StandingFive.seven_le_localBound` and `five_le_chromaticNumber`'s
hypothesis forms; the third pass's three row modules; `fs131-t5`; `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md` (drafted
here); a new `axiom`; `native_decide`.

## Stage 1 — SAVED (FS131-L10B)
