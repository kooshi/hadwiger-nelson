# FS131-L5 — wave 5's landing (de Bruijn, the implementer)

*Brief: `data/fs131/briefs/FS131-L5-wave5-land.md` (on `main`). Branch `fs131-w5c`, from `8f2280d0`. Working files: `data/fs131/l5/`.
Tools: `tools/fs131_l5_*.py`. Report: `data/fs131/reports/FS131-L5.md`.*

## Theorems this phase proved

This job proves no new theorem: it joins the branch that holds the proved outward bend to wave 5's line, makes the ruled tidies, and
takes the whole wave through the gate. The wave's heads and their axioms, read from the gate's saved log, are listed at the stage that
ran the gate.

## Stage 1 — SAVED (FS131-L5): the readback, the tree as given, the trial merges

### 1.1 The brief's quotations (standing rule 3)

`python3 tools/fs131_l5_quotes.py <brief> --root /home/kooshi/source/lean-dir` — **16 quotations, 0 mismatches**
(`data/fs131/l5/quotes.txt`): Kooshi's line in `CLAUDE.md` § The standard of evidence (l. 412); eleven inventory items on `main`
(468, 469, 464, 465, 458, 459, 462, 455, 415, 419, 427), each then read whole, with 454, 456, 457, 460, 461, 463, 466, 467 beside
them; the three statements in this tree (`exists_terminalMap`, `Procedure` l. 3340; `exists_terminal`, `Terminal` l. 3816;
`bend_away_part`, `BendStep` l. 346); the gate's recorded counts (`CLAUDE.md` l. 504). A relative source is read under `main`'s
checkout, where the brief was written. `--self-test` (`quotes-selftest.txt`): four plants, each refused — a changed character, a
wrong source, an empty quotation (which must not match every line), a brief with no quotation (exit 2, never 0).

Read besides: `plans/STANDING-RULES.md`; `LEAN.md` in full, **from `main`'s checkout** (21,291 bytes; this tree's copy is the
branch point's, 17,045 bytes, without the doubled-name bullet); `RUNNING.md` § Building and § Make the gate fail, and watch it fail;
FS131-RP1's report and record whole; FS131-M7's report, its last two sections; FS131-BA3's report (in `fs131-w5z`'s tree);
FS131-OL1's Stages 16–20 and drafts in `plans/FS131-IO-implementation.md` (on `main`; this tree's copy ends at Stage 15).

### 1.2 The tree as given

`8f2280d0`, equal to `origin/fs131-w5c`, clean. Build under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; driver `data/fs131/l5/build-asgiven.log`, full log `build/gate/build/20261006T085527Z-2764942.log`, copy
`data/fs131/l5/build-asgiven-full.log`): **exit 0, "all 1796 modules already up to date, nothing built, 7 module(s) with warnings"**
— the oleans are FS131-RP1's final build's. 36 warning lines, every one `declaration uses sorry` (0 of another kind): `BendAway` 6,
`LensOut` 7, `CollarMapOut` 7, `R2Cap` 3, `HornChart` 4, `BendGap` 8, `BendStep` 1 — RP1's count.

### 1.3 The trial merges, on this tip (nothing written to a ref or to the tree)

- **`origin/fs131-w5z` at `d4f04ff3`** (one merge base, `dd8c2c33`), `git merge-tree --write-tree --name-only HEAD origin/fs131-w5z`
  (`data/fs131/l5/trial-merge-w5z.txt`): **one conflict, `scripts/Axioms.lean`** — the end of the CLEAN section, where this line's
  two blocks (FS131-M7, FS131-RP1) and that line's three (FS131-BA1, BA2, BA3) were each appended after FS131-KA1's block; keep
  both. `ARCHITECTURE.md` does not conflict: `fs131-w5z` did not change it. The files that line changed outside `plans/` and
  `data/`: seven Lean modules (`BendAway`, `BendGap`, `BendStep`, `CollarMapOut`, `HornChart`, `LensOut`, `R2Cap`),
  `scripts/Axioms.lean`, six tools of its own; of these only `scripts/Axioms.lean` was changed on this line too. `BendStep`
  differs between the two tips in three places, all that line's: the horn child's docstring line, its proof in place of `sorry`,
  and `AwayBend.idle`'s call (ruling 446 (b)).
- **`origin/main` at `28ac525a`** (one merge base, `a20bb6f5`), the same trial (`trial-merge-main-pre.txt`): clean. **What `main`
  changed since this branch last had it**, outside `plans/` and `data/`: `.claude/` (2), `BIBLIOGRAPHY.md`, `CLAUDE.md`, `LEAN.md`,
  `ARCHITECTURE.md` (one row, `OpenMove`'s), `scripts/Vacuity.lean` (a comment: OPEN's carriers), `scripts/vacuity-baseline.txt`
  (the header's two count lines), FS131-T4's three new files under `scripts/`, ten files under `tools/`. **No file under
  `Proofs/`.** The brief's expectation named `plans/`, `data/`, `.claude/`, `BIBLIOGRAPHY.md` and T4's new files; the rest is
  FS131-OL1's landing and its filing — recorded at the stage that makes the merge.

### 1.4 Read before the tidies (step 3), on the two tips

- `hF` in the toward `CollarFit.sides_end`, `sides_eq`, `map_R1`, `map_R2` (`BendCollar` l. 1014–1282): read by none — `sides_end`
  holds `have _ := hF`; `sides_eq` and `map_R1` pass it to `sides_end` only; `map_R2` passes it to `sides_eq` only. Their callers:
  `CollarFit.map_inert` and `bend_toward_collar` (`BendCollar`), `CollarFit.map_isR2Arc` (`BendStep`), `CollarFit.arcBend`
  (`ArcStep`); each of these reads `hF` elsewhere (`side_ne_inner_of_mem_lens`, `map_valid`, `isR2Arc_of_fixed`), so none loses
  its own.
- `CollarFit.map_hornCount_le` (`BendStep`, proved on `fs131-w5z`): `have _ := hF`; one caller, `CollarFit.arcBend`.
- `ringPt_inj_of_abs_sub_lt` (`BendAway`, namespace `Plane`) and `ArcMap.ringPt_ne_of_abs_sub_lt` (`BaseDense`, three uses, all
  in `BaseDense`): on the joined line `BendAway` is upstream of `BaseDense` (through `Terminal`, `Procedure`, `ArcStep`,
  `BendStep`, `BendGap`), so the upstream one is the one to keep.

## Stage 1 — SAVED (FS131-L5)

## Stage 2 — SAVED (FS131-L5): `fs131-w5z` merged (`f1117627`); the build green with no warning; the wave whole

### 2.1 The merge

`git merge --no-ff --no-commit origin/fs131-w5z` at `d4f04ff3` (re-fetched: unmoved since the trial), parents `5d3a739f` and
`d4f04ff3`, committed as **`f1117627`**. One conflict, as trialled: `scripts/Axioms.lean`, resolved keep-both — this line's blocks
(FS131-M7, FS131-RP1), then that line's (FS131-BA1, BA2, BA3), one blank line between; 5,221 `#print axioms` records
(5,129 + 33 + 52 + 7), none twice.

- **File by file** (`python3 tools/fs131_m7_merge_check.py dd8c2c33 HEAD origin/fs131-w5z`, on the staged merge;
  `data/fs131/l5/merge-check.txt`): **16,339 files, 1 changed by both sides, 0 failures, PASS**.
- **Its negative controls.** M7's `--self-test` cannot run on this merge: its third plant needs an import line of `Proofs.lean`
  that THEIRS added, and `fs131-w5z` adds none ("PLANT TARGET ABSENT", `merge-check-selftest.txt`; the tool is another job's
  and is not edited). `tools/fs131_l5_merge_plants.py` plants on TREES built from the staged merge through a scratch index (no
  ref, no working-tree file, not the real index) and runs the same check with `--rev` (`merge-plants.txt`): the staged merge
  passes; `BendGap.lean` set to this line's blob, `BendCollar.lean` set to that line's blob, a record of `scripts/Axioms.lean`
  dropped, the same record doubled — each **fails naming its file**.
- **The index held the merge and nothing else**: against the trial's tree (`5b7c1adf`) the staged tree differed in Stage 1's own
  nine files and the resolved `scripts/Axioms.lean`; no tracked file was modified outside the index.
- **`ArcBend.of_away`'s hypothesis is `bend_away_part`'s conclusion** (`python3 tools/fs131_m7_away_clause.py`,
  `away-clause.txt`): EQUAL, 18 clauses; `--self-test`: three plants fired (`away-clause-selftest.txt`).
- **The names FS131-RP1 removed**: no use under `Proofs/` (eleven names; six hits, all in comments that record a removal).
- **Doubled names and statements, by M7's text scanner** (`python3 tools/fs131_m7_dupes.py --whole Proofs/HadwigerNelson/Plane
  a20bb6f5`, `dupes-whole-merge.txt`): 72 files, 4,371 public declarations; **0 NAME-TWICE, 0 STATEMENT-TWICE**, 5 NORM-TWICE
  (the tool's known artefacts). The gate's own check is the kernel-side scan, Stage 5.

### 2.2 The build of `f1117627`

Under the slot (driver `data/fs131/l5/build-merge.log`; full log `build/gate/build/20261006T085723Z-2775704.log`, copy
`data/fs131/l5/build-merge-full.log`): **exit 0, "464 of 464 batches, 14 module(s) rebuilt, 0 module(s) with warnings, 10m0s",
"Build completed successfully (5803 jobs)"**. Rebuilt: `LensOut`, `CollarMapOut`, `HornChart`, `BendAway`, `R2Cap`, `BendGap`,
`BendStep`, `ArcStep`, `Procedure`, `Terminal`, `Dense`, `BaseWalk`, `BaseDense`, `Proofs`. **`warning` lines: 0** (`grep -c`; the
as-given log of Stage 1 holds 36, the control on the count). The log's three `error` lines are its lines 3, 5, 7, the up-to-date
probe's "target is out-of-date and needs to be rebuilt", which starts the walk.

A number I stopped on: the log gives `BendGap` 8.4 s and `Terminal` 17 s, against builds of ten minutes and more in the earlier
records. Measured: `lake env lean` on `BendGap.lean` alone takes 10.9 s of wall clock (31.7 s of CPU); the ten minutes are the
walk over 464 batches. The times are real.

### 2.3 The receipt that the wave is whole

- **`sorry`**: `grep -rnP '^\s*sorry\s*$|:= sorry|by sorry' --include='*.lean' Proofs/ Proofs.lean`: **0**. The wider `\bsorry\b`
  finds five lines, all prose (`data/fs131/l5/sorry-merge.txt`): `main`'s four (`Packed` l. 266, `Plane/Cover` l. 33,
  `Plane/CoverExamples` l. 13 and l. 6541) and `BendStep` l. 347, a docstring's remark on a wave-4 branch.
- **Axioms** (`data/fs131/l5/L5Axioms.lean` → `L5Axioms.out`, read by `tools/fs131_l5_axioms.py`, which asks for EXACTLY the
  standard three; `L5Axioms-read.txt`): **17 of 17 on exactly `[propext, Classical.choice, Quot.sound]`** —
  `LocalStep.of_cutArcs`, `CollarFit.map_localStep`, `bend_away_part`, `exists_arcStep`, `exists_terminalMap`, `exists_red`,
  `exists_terminal` (the brief's seven); `exists_procStep`, `exists_terminalSeq`, `CollarFit.map_hornCount_le`,
  `exists_arcBend_toward`, `CollarFit.arcBend`; `bend_away_gap`, `bend_away_subdiv`, `CollarFitOut.awayBend`,
  `CollarFitOut.map_R1`, `CollarFitOut.map_R2`.
- **The control that fires**: the same reader on FS131-M7's print of the line before the merge
  (`data/fs131/m7/M7AxiomsFinal.out`) fails on each of the brief's seven, naming `sorryAx`. `--self-test`: five plants on the
  new print, each fired naming its record — a record deleted, given `sorryAx`, given a native axiom, with `Quot.sound` removed (a
  subset is not "exactly"), doubled (`L5Axioms-selftest.txt`).
- These prints are `lake env lean` against the build's oleans: a receipt for this stage. The gate's audit is Stage 5.

### 2.4 Instruments prepared for the gate, and their first controls

- `data/fs131/l5/count-modules.lean`: the declarations of every module as the vacuity scan counts them (`isOurs`,
  `isRefutation`, `isNegationConcl`, `isGeneratedDecl` copied verbatim from `scripts/Vacuity.lean`). **Run against `main`'s built
  library** (the worktree `fs131-wop`, whose `Proofs/` is `origin/main`'s; read only): `TOTAL declarations=11173
  refutations=118` — `main`'s gated scan line, count for count (`count-modules-main.out`). So the counter reproduces the scan.
- `data/fs131/l5/census.lean`: for every predicate or structure of the `Plane` modules a theorem may take as a hypothesis, what
  the library holds about it (binder sites, closed refutations, closed witnesses), for `scripts/Vacuity.lean`'s IN/OUT procedure.
  Not run yet.
- `data/fs131/l5/tidy_edits.py`: Stage 3's edits as data; `--dry` on the merged tree: 52 of 52 match once. Not applied.

## Stage 2 — SAVED (FS131-L5)

## Stage 3 — SAVED (FS131-L5): the tidies that waited for the merge — made as ruled, exactly those by script, one build

*Rulings 457 (b), 465 (a), (b); FS131-RP1's closing list. The edits are data: `data/fs131/l5/tidy_edits.py`, 52 entries in 12
files, each refused unless its old text stands exactly once (`--dry` on the merged tree: 52 of 52; then applied).*

### 3.1 What was done

- **A. The unread `hF : F.Valid`, out of seven lemmas**, each with its callers (20 entries):
  - the toward four, `CollarFit.sides_end`, `sides_eq`, `map_R1`, `map_R2` (`BendCollar`) — `sides_end` held `have _ := hF`;
    `sides_eq` and `map_R1` passed it to `sides_end` alone, `map_R2` to `sides_eq` alone. Callers re-pointed: `CollarFit.map_inert`
    and `bend_toward_collar` (`BendCollar`), `CollarFit.map_isR2Arc` (`BendStep`), `CollarFit.arcBend` (`ArcStep`);
  - `CollarFit.map_hornCount_le` (`BendStep`; `have _ := hF`), one caller, `CollarFit.arcBend`;
  - the outward `CollarFitOut.map_R1`, `map_R2` (`BendGap`; `have _ := hF` each), two calls in `CollarFitOut.awayBend`.
  No caller surprised: each keeps an `hF` it reads elsewhere (`side_ne_inner_of_mem_lens`, `map_valid`, `isR2Arc_of_fixed`), so
  no statement beyond the seven moved. All seven are strictly stronger (for the errata, ruling 419 (a)'s form).
- **B. `ringPt_ne_of_abs_sub_lt` and `ringPt_inj_of_abs_sub_lt` made one** (6 entries): the upstream one is kept
  (`Plane.ringPt_inj_of_abs_sub_lt`, `BendAway`); `ArcMap.ringPt_ne_of_abs_sub_lt` (`BaseDense`) is removed with its audit record,
  and its three uses, all in `BaseDense`, read the kept lemma (`have hψne : … ≠ …` then `refine hψne (ringPt_inj_of_abs_sub_lt …)`,
  the remaining goal unchanged). The kept lemma's docstring no longer names the removed one.
- **C. The stale "skeleton" and "open" lines** (26 entries): the six bend modules' title lines ("FS131-KA1's skeleton" → "FS131-KA1's
  plan, proved by FS131-BA1 / BA2 / BA2 and BA3"); `BendStep`'s header line, section title and `bend_away_part`'s "**Proved from open
  children**", and its "none in Lean on this branch" → "none in Lean yet"; three lines of `ArcStep` that called
  `CollarFit.map_hornCount_le` an open child (the same kind, not on RP1's list); in `scripts/Axioms.lean` the headers of FS131-IA1's,
  IA2's, KA1's and M7's blocks, which said the gate fails on their records; in `ARCHITECTURE.md` the rows of `BendAway`, `LensOut`,
  `HornChart`, `CollarMapOut`, `R2Cap`, `BendGap`, `BendStep`, `ArcStep` ("**Open children (`sorry`)**" → "**Proved (FS131-BAn)**";
  `BendAway`'s row named `AwayBend.r2_of_onRingArc`, which no file declares — the row now names `AwayBend.contact_of_onRingArc`) and
  `Terminal`'s row ("skeleton" dropped, ruling 432 (b): `exists_arcStep` is on the standard three).

### 3.2 The checks

- **Statements** (`python3 tools/fs131_rp_stmt.py f1117627 data/fs131/l5/stmt-expected.json`, FS131-RP1's tool with this job's
  manifest; `data/fs131/l5/stmt-tidy.txt`): 11,343 declarations in 1,796 files at the merge commit; **changed 7, gone 1, added 0 —
  the manifest exactly, 0 deviations**. Before the edits the same tool with an empty manifest read 0 changes. Its `--self-test` on
  this manifest (`stmt-selftest.txt`): five plants fire by name (an unruled change, deletion, addition, a change in a file the
  manifest does not name, a manifest entry that did not happen); the sixth, "a moved statement altered", is written for a manifest
  with a `moved` entry and reports SILENT on this one, which has none — the planted change is still refused, as UNRULED-CHANGED.
  So the tool's exit status for the self-test is 1 here, for a plant that does not apply; said, not hidden.
- **Iteration before the build** (never evidence): `BendCollar`, `BendGap`, `BaseDense`, `BendAway` under `lake env lean`, each
  exit 0 with no output — the four whose upstream statements the oleans on disk still matched. `BendStep` and `ArcStep` call the
  changed `BendCollar` lemmas and were left to the build (FS131-RP1's lesson: a stale olean reads green).
- **The build** (driver `data/fs131/l5/build-tidy.log`; `build/gate/build/20261006T091411Z-2877053.log`, copy
  `build-tidy-full.log`): **exit 0, "464 of 464 batches, 15 module(s) rebuilt, 0 module(s) with warnings, 10m19s", "Build completed
  successfully (5803 jobs)"; 0 `warning` lines.** Rebuilt: `LensOut`, `CollarMapOut`, `BendCollar`, `HornChart`, `BendAway`,
  `R2Cap`, `BendGap`, `BendStep`, `ArcStep`, `Procedure`, `Terminal`, `Dense`, `BaseWalk`, `BaseDense`, `Proofs`.
- **Axioms** (`data/fs131/l5/L5AxiomsTidy.lean` → `.out`, `L5AxiomsTidy-read.txt`): **21 of 21 on exactly the standard three** —
  the seven changed, five callers (`CollarFit.map_inert`, `bend_toward_collar`, `CollarFit.map_isR2Arc`, `CollarFit.arcBend`,
  `CollarFitOut.awayBend`), `ringPt_inj_of_abs_sub_lt`, the brief's seven heads, `row134BaseUA` (`BaseDense`).
- **The removed lemma is gone**: `#check @…ArcMap.ringPt_ne_of_abs_sub_lt` against the new oleans: "Unknown constant", exit 1
  (`GoneCheck.out`). `scripts/Axioms.lean`: 5,220 records, none twice.
- `tools/check_architecture.py`: PASS, exit 0 (`arch-tidy.txt`). `tools/fs131_m7_away_clause.py`: PASS. The notes check over the
  tree with the bend's modules read (`tools/fs131_l5_notes.py`, FS131-RP1's wrapper with `EXTRA` extended to `ArcStep`, `BendStep`
  and the six bend modules; `notes-tidy.txt`): **193 notes read, 0 CONFLICT** (RP1 read 175 without those seven).

### 3.3 Left, and said

- Not made, of FS131-RP1's "met on the way" list: BA1's ten `CollarFitOut` helpers that re-prove `CollarMap`'s lemmas (item 454;
  no ruling names a form for them); `BendStep`'s l. 29 and l. 289 may name `collarModel_hyps` (they name `collarModel`, which is the
  `CollarFit` inhabitant they speak of: left); `exists_arcStep`'s note waits for `awayModel`.
- `BendStep` l. 347's "wave 4's `bend_away`, `sorry` on `fs131-w4ba`" is a remark on another branch, kept: it is the one line under
  `Proofs/` beyond `main`'s four where the word `sorry` stands.
- Other rows of `ARCHITECTURE.md` and other block headers of `scripts/Axioms.lean` still say "skeleton" or "sorry until … lands"
  for modules that hold no `sorry` (waves 1–5; about twenty-five lines, most on `main` already). They were not on this job's list
  and are not changed: a tidy for after the landing, listed in the report.

## Stage 3 — SAVED (FS131-L5)

## Stage 4 — SAVED (FS131-L5): `main` merged in (`0184efde`, then `1351ebc2`); no file under `Proofs/`

- **What `main` changed since this branch last had it** (`git diff --name-only a20bb6f5 origin/main`, at `28ac525a`;
  `data/fs131/l5/main-since-base.txt`, 592 paths): 562 under `data/`, 9 under `plans/`, and outside them `.claude/` (2),
  `BIBLIOGRAPHY.md`, `CLAUDE.md`, `LEAN.md`, `ARCHITECTURE.md`, `scripts/DupNames.lean`, `scripts/dupnames.sh`,
  `scripts/dupnames-controls.txt` (FS131-T4's, new), `scripts/Vacuity.lean`, `scripts/vacuity-baseline.txt`, and ten files
  under `tools/`. **`git diff --name-only a20bb6f5 origin/main -- Proofs Proofs.lean lakefile.toml lake-manifest.json
  lean-toolchain`: empty.** The brief expected `plans/`, `data/`, `.claude/`, `BIBLIOGRAPHY.md` and T4's new files; the others are
  FS131-OL1's landing registrations (`ARCHITECTURE.md`'s `OpenMove` row, OPEN's carriers in the scan's docstring, the baseline
  header's two count lines) and the coordinator's filings (`CLAUDE.md`, `LEAN.md`, `tools/claude_md_fact_audit.py`, QA4's, LN1's
  and OL1's tools). Two of them are Lean files — `scripts/DupNames.lean`, new, and `scripts/Vacuity.lean`, a docstring paragraph
  — both gate scripts, neither part of the library; read as the brief's "new files under `scripts/`" and OL1's registration, and
  said here rather than by message.
- **The merge** `0184efde` (`git merge --no-ff origin/main`, parents `618b535f` and `28ac525a`; no conflict, `ARCHITECTURE.md`
  merged by itself). File by file (`tools/fs131_m7_merge_check.py a20bb6f5 HEAD origin/main`, `merge-main-check.txt`): 16,963
  files, 1 changed by both sides, 0 failures. Plants (`merge-main-plants.txt`): `scripts/vacuity-baseline.txt` set to this
  line's blob, `SixFragment.lean` to `main`'s, `ARCHITECTURE.md` to this line's — each fails naming its file. The Lean tree is
  Stage 3's: `git diff --name-only 618b535f 0184efde -- Proofs Proofs.lean lakefile.toml` is empty, and the build reads "all 1796
  modules already up to date" (`build-mainmerged.log`).
- **`main` moved again before the gate's final run**, to `5358f6cf`: two commits, `plans/FS131-close-inventory.md`,
  `plans/SESSION-HANDOFF-2026-10-06.md` and two files under `data/fs131/briefs/`. Merged as `1351ebc2` before the final run, so
  the gated commit holds them.

## Stage 4 — SAVED (FS131-L5)

## Stage 5 — SAVED (FS131-L5): the full gate on `1351ebc2` — green at every step

**The gated commit is `1351ebc2`** (parents `ffd899e0`, this line with its registrations, and `5358f6cf`, `main`). Runner
`data/fs131/l5/run-gate.sh final`, each step under the slot, each driver log ending in its exit status;
`data/fs131/l5/run-gate-final.head` records `HEAD=1351ebc2…`, **no tracked file modified**, and each gate's saved log (copies:
`data/fs131/l5/receipt-<gate>-final.log`). A first pass ran on `7edc365d` before the registrations (tag `merged`).

### 5.1 What this job registered, by the gate's own procedures

- **`scripts/Axioms.lean`**: one record, in a block "FS131-L5" — `ArcMap.LocalSeq.limit_dom` (`Limit` l. 613, `@[simp]`, by
  `rfl`), the one hand-written theorem of the wave with no record (found by `tools/fs131_l5_records.py` on the first pass's log,
  which failed naming it: that check's live negative control). 5,221 records.
- **`scripts/Vacuity.lean`**, a docstring entry "Wave 5's carriers (FS131-L5 …)": **no new carrier IN**, so no control is added
  (the last stays 62). The decision rests on a census (`data/fs131/l5/census.lean` → `census.out`, `census.json`): of the 201
  hypothesis-formers of the `Plane` modules and `Thomassen`, 60 are new to `main`; **none of the 60 has an unconditional `¬ P …` at
  a closed instance or an `IsEmpty` instance**, the two shapes the scan's `gather` reads as emptiness, so no `VACUOUS` control
  could be planted for any. The entry names all sixty OUT, by kind, with what inhabits each. **The census's positive control**:
  for the 18 tracked carriers of those modules it reproduces the scan's evidence (one closed refutation each for `IsHorn`,
  `IsStuck`, `Condition5`, `SemiconcaveWith`, `SectorsAt`, `NiceAt`, `WoodallMerged`, `WoodallNormal`; two `IsEmpty` each for
  `AeColouring`, `CPColouring`, `AeProperRegions`).
- **`scripts/vacuity-baseline.txt`**: the header's two count lines, from `scripts/gate_report.py header`. No entry added.
- `scripts/axioms-controls.txt`, `scripts/vacuity-controls.lean`, `scripts/vacuity.sh`: unchanged — the wave declares no axiom
  and enters no carrier, so no expected count moves. `ARCHITECTURE.md`: Stage 3's rows; the wave's 29 modules each have a row.

### 5.2 The steps, each saved log read

| step | result | log |
|---|---|---|
| build | exit 0, "all 1796 modules already up to date, nothing built, 0 module(s) with warnings"; **0 `warning` lines** here and in the full build of these sources (Stage 3: 464 of 464 batches, "Build completed successfully (5803 jobs)") | `build/gate/build/20261006T094556Z-3064490.log` (copy `build-final-full.log`); `20261006T091411Z-2877053.log` (copy `build-tidy-full.log`) |
| `sorry` | narrow pattern: **0** lines; `\bsorry\b`: 5, all prose (`Packed` l. 266, `Plane/Cover` l. 33, `Plane/CoverExamples` l. 13 and 6541, `BendStep` l. 345) | `sorry-narrow-final.txt`, `sorry-wide-final.txt` |
| doubled names | **"dupnames: OK — no name is declared by two modules"**; 7,310 modules scanned, 1,796 the package's against 1,796 source files; 21,020 constants; `TOTALS doubled=0 generated=23 generated-axioms-differ=0` | `build/gate/dupnames/20261006T094558Z-3064636.log` |
| its self-test | "OK — all 15 controls behaved", 15 `ok`, 0 `FAIL` | `build/gate/dupnames-self-test/20261006T094602Z-3064814.log` |
| axioms | **"axioms: OK — 5196 clean, 16 axiom-free, 4 imported, 5 declared purchase(s)"**; "audited: 5221 records"; purchase ledgers agree; 1 declared import, every library axiom declared | `build/gate/axioms/20261006T094617Z-3066074.log` |
| its self-test | "OK — every planted fault fired, and every partner passed", 23 `ok`, 0 `FAIL` | `build/gate/axioms-self-test/20261006T094622Z-3066319.log` |
| vacuity | **"vacuity: OK"**; `declarations=12999 refutations-skipped=182 sites=1130`, `vacuous=0 stale=0 declared=3 witnessed=32 generic=1093 unknown=2`, `untelescoped=0`; baseline header "match (9 of 9 compared)"; the two UNKNOWN are the baseline's `hexShell_plane5`, `hexShell_plane6` | `build/gate/vacuity/20261006T094806Z-3076636.log` |
| its self-test | "OK — all 62 controls behaved", 62 `ok`, 0 `FAIL` | `build/gate/vacuity-self-test/20261006T094916Z-3082560.log` |
| architecture | "RESULT: PASS", exit 0 | `arch-final.txt` |
| guarded lint (`lake lint --no-build -- --no-build --trace`, `--mem 8`) | exit 0, "-- Linting passed for Proofs.", 14 linters each "(2/2) Passed!" | `lint-final.log` |
| notes | 193 notes read (the bend's seven modules and `ArcStep` among them), **0 CONFLICT** | `notes-final.txt` |

### 5.3 The axioms, reconciled

- **Against `main`'s gated audit** (FS131-OL1's `data/fs131/ol/axioms-receipt-landed.log`, 3,912 records) by
  `scripts/gate_report.py axioms` (`axioms-vs-main-final.txt`): **1,312 records added, every one CLEAN; 3 removed; none changed.**
  3,912 − 3 + 1,312 = 5,221. The three removed are second names FS131-RP1 removed that `main` held (`ArcMap.HasDegree.eq`,
  `ArcMap.sq_norm_eq_re_im`, `sq_norm_re_im`). Imported 4 and purchases 5 are unchanged: the wave adds no `axiom` and no
  `native_decide` (no added line of `git diff origin/main -- Proofs` matches either; the pattern matches two planted lines).
- **Every wave-5 theorem is audited** (`tools/fs131_l5_records.py`, `records-final.txt`, PASS). The landing library holds 8,330
  theorems against `main`'s 6,958 (the kernel's own list, `count-modules-*.out`): 1,375 new, 3 gone. Of the 1,375, 66 are
  generated by Lean (51 `eq_1`, 4 `eq_2`, 1 `eq_3`, 1 `eq_def`, 2 `congr_simp`, 2 `mk.inj`, 2 `mk.injEq`, 2 `mk.sizeOf_spec`,
  1 `brecOn`), which the audit has never listed; **the 1,309 hand-written each have exactly one record, under CLEAN: 1,288 on
  exactly `[propext, Classical.choice, Quot.sound]`, 12 on `[propext, Quot.sound]`, 7 on `[propext]`, 2 on none.** The other three
  added records are definitions (`LocalSeq.const`, `LocalSeq.limit`, `pushOutHomeo`).
- **The heads**, each on exactly the standard three in the gate's log: `exists_terminalMap`, `exists_terminal`, `exists_red`,
  `bend_away_part`, `exists_arcStep`, `LocalStep.of_cutArcs`, `CollarFit.map_localStep`.
- Controls: the tool's `--plant` on the first pass's log (`records-plant.txt`) fails naming `sorryAx` on a head, a record
  dropped, doubled, moved under PURCHASED, and a head on `Quot.sound` alone. **A defect of mine, found by the tool failing toward
  the alarm**: its first version read a record's name as `'[^']+'` and so lost the 21 records whose names end in a prime — four
  false MISSING lines; the name is now `\S+`, and the count of records it reads equals the audit's (5,221).

### 5.4 The vacuity counts, reconciled

- **Predicted before the scan**, by `data/fs131/l5/count-modules.lean` on the landing library: `declarations=12999
  refutations=182`. The scan reads the same. The counter reproduces `main`'s gated line on `main`'s library (11173, 118).
- **By module** (`tools/fs131_l5_vacdiff.py`, `vacdiff-final.txt`, PASS): `declarations` +1,826 = 1,829 new − 3 gone;
  `refutations-skipped` +64; 29 new modules account for +1,827 and five modules of `main` for −1 (`Plane/Basic` +2 and `Chord` −2:
  `conj_e`, `sq_norm_eq` moved; `SixFragment` −1, `UnitArc` −1, `OpenMove` −1: the removed second names; `ValidMap/Basic` +1:
  `HasDegree.unique` moved in). The new declarations: 1,375 theorems, 221 definitions, 18 inductives and structures, 215
  generated. FS131-RP1 predicted "ten lower on this account": on its line, yes; against `main`, three are gone, since seven of
  its eleven removals were of names `main` never held and `conj_e` was counted once on `main`.
- **Row for row against `main`'s gated scan** (FS131-OL1's `vacuity-scan-landed.log`, 859 rows): **0 rows lost; 346 added, every
  one `SITE GENERIC`, every one on a declaration `main` does not hold; no evidence row added (18 emptiness proofs, 57
  witnesses, as on `main`).** By carrier: 194 `Valid`, 62 `IsRingArc`, 58 `IsHorn`, 26 `IsStuck`, 6 `IsQArc`. By module:
  `Terminal` 100, `Procedure` 41, `MapGraph` 24, `FlankUA` 23, `BaseDense` 21, `ArcStep` 19, `BendCollar` 19, `BendStep` 14,
  `BendGap` 13, `HexRing` 13, `HornShadow` 12, `Limit` 11, `Cor3` 8, `MapTopology` 7, `BaseWalk` 6, `BendAway` 5, `R2Cap` 5,
  `Dense` 4, `Chain` 1. **No new site reads VACUOUS, STALE or UNKNOWN; nothing asks for a baseline entry.**
- The scan's full output on the gated commit is **byte-identical** (`cmp`) to the first pass's, taken before the docstring
  entry and the header were written: nothing the scan computes moved.
- **What the scan cannot see, said plainly.** (i) `ArcMap.BaseCtx` is empty at every instance (`BaseCtx.false`), by design: its
  26 binder sites are the steps of `row134BaseUA`'s proof by contradiction, each docstring says so, and the carrier is OUT (the
  planner's decision, `BaseWalk`'s header; the entry records it). (ii) Hypothesis sets that hold together on no map of the
  library: the open gate items of the drafts below. Each binder alone is `GENERIC`.

### 5.5 Each check's negative control, watched

| check | the plant | what went red |
|---|---|---|
| build's warning count | the as-given tree (Stage 1) | 36 `warning` lines, against 0 |
| `sorry` scan | the tree before the merge (`git grep` at `5d3a739f`) | 39 lines by the narrow pattern, against 0 |
| doubled names | its 15 controls; FS131-T4 watched the gate itself fail on `main`'s line at `conj_e` (`data/fs131/t4/logs/gate-on-main-line.log`), which this line no longer holds twice | — |
| axioms | its 23 controls; the records check on the first pass (one record missing) and its five plants; the heads' reader on the print before the merge (Stage 2) | named each |
| vacuity | `ArcMap.IsStuck` misspelt in `trackedProps` (`IsStuckX`), file restored from a copy (`cmp` identical) | the self-test: "FAIL — 3 of 62", exactly `planted_vacuous_stuck`, `planted_generic_stuck`, `planted_unknown_stuck` (`vacuity-selftest-plant-isstuck.log`); the scan: `sites=1097`, and the row check **8 rows LOST**, the wave's 26 `IsStuck` sites gone (`vacdiff-plant-isstuck.txt`, exit 1). The scan itself exits 0 on a misspelt name — the reason the control and the row check exist |
| row check | `--plant` (`vacdiff-plant.txt`) | LOST, NOT NEW, FLAGGED, COUNTER-DISAGREES |
| architecture | `BendGap`'s row removed, restored (`cmp` identical) | "missing: ['Plane/ValidMap/BendGap']", exit 1 (`arch-plant.txt`) |
| notes | RP1's two plants and one of this wrapper's (a conflicting note in `BendGap`) | CONFLICT 0 → 1 each (`notes-selftest.txt`) |
| lint | none at a landing (ruling 419 (b): the close keeps the firing control) | FS131-LN1's measurement is the record that it fires; its three `[NumberField _]` findings are gone, as FS131-RP1 predicted |

### 5.6 The drafts, checked by the digest

The two `CLAUDE.md` drafts below, applied to a scratch copy, are read by `scripts/gate_report.py` against the final logs:
§ Trust ledger "match (clean, purchases and imported compared)"; § The gate "match (9 of 9 compared)". The unedited `CLAUDE.md`
is flagged STALE by both digests (3889 → 5196; 11173 → 12999, 118 → 182, 784 → 1130, 747 → 1093) until the filing.

### 5.7 Read against the informal statement, aloud

- `ArcMap.exists_terminalMap (hF : F.Valid) (hP : F.IsPlaneMap) : ∃ M : ArcMap k, F.IsModification M ∧ M.IsTerminalMap` — "every
  valid map of the plane, at any number of colours, has a modification (the same domain, no unit arc created, the colours of
  every point of at least four colours kept) that is a terminal valid map: valid, of the plane, no MERGE, MERGE-RAY or SHAVE
  available at any point, every constant-sided unit arc (Q) or (R2)". FS112-N2-TERM's construction, at every `k`.
- `ArcMap.exists_red` — the same hypotheses; "a modification that is valid with every unit arc (Q) or (R2)": FS112-N2-RED.
- `ArcMap.exists_terminal {F : ArcMap 6}` — FS112-N2-TERM at six colours, with its clauses 2 and 3: in the terminal
  modification every vertex is cubic trichromatic, carries at least four colours, or is stuck; and every vertex stuck along
  `e α` with at most three colours lies on a run that is not bi-infinite, each end of which is within `1` of a point of a (Q) or
  (R2) arc or of a point of at least four colours, with every horn bound `±1` on the run a (Q) or (R2) arc. Nothing is stated
  about one-sided infinite runs (the docstring's not-claimed clause). **Its hypotheses' satisfiability is the open question**: a
  valid six-map of the plane (FS-114); the class at seven colours is inhabited by `sevenBrickMap`.
- `ArcMap.bend_away_part` — FS112-N2-AWAY with N2-TAN in collar form, as FS131-BA3 read it clause by clause; unchanged here.
- `ArcMap.exists_arcStep` — as FS131-M7 read it; unchanged here.
These are the kernel's statements. What they are not: a statement that a terminal map with a stuck vertex exists, or does not.
