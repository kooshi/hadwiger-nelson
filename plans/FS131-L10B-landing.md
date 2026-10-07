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

## Stage 2 — SAVED (FS131-L10B): the two merges; the joined tree builds with no warning

### 2.1 The merges, each its own commit

Each was made with `git -c merge.conflictStyle=diff3 merge --no-ff --no-commit <hash>`, resolved, checked, and then committed as a
merge (two parents each). The trial of each was repeated on the commit it was merged into (`data/fs131/l10b/merge-trial-main.txt`,
`merge-trial-wf1.txt`).

| merge | commit | conflicts | merged by itself, both sides having changed it |
|---|---|---|---|
| `main` at `615c715c` into `2658107c` | **`214b30d5`** | `scripts/Axioms.lean` (one hunk, two adjacent additions, no base) | `ARCHITECTURE.md`, `Proofs.lean` |
| `fs131-wf1` at `a61f0d14` into `74814a95` | **`6f3053dc`** | `ARCHITECTURE.md` (one hunk), `scripts/Axioms.lean` (one hunk) — the two the brief foresaw | `Proofs.lean`; and two sentences of `scripts/Axioms.lean`'s prose that only `fs131-wf1` had touched |

**`origin/main` moved while the first merge was being made** (another session's fetch; the worktrees share refs): from `615c715c` to
`996ab3ff`, three commits under `plans/` and `data/` (`git diff --name-only 615c715c 996ab3ff`: `data/` 1, `plans/` 2). The merge is
of `615c715c`, named by hash; the rest is merged at the landing (Stage 6).

- **The merge of `main`.** `scripts/Axioms.lean`: `main`'s eight wave-6 blocks in their place, this line's five blocks (FS131-K10b,
  -I10D, -I10E, -I10F, -K10c) after them, above the `=== PURCHASED ===` banner (`tools/fs131_l10b_keepboth.py resolve
  --theirs-first`). The three-way check on every path both sides changed, the two that merged by themselves included
  (`tools/fs131_l10b_keepboth.py --self-test <file> HEAD 615c715c c20b57a0 <path>`; `keepboth-main.txt`, each exit 0): no marker;
  every line stands exactly `ours + theirs − base` times — `scripts/Axioms.lean` 7,085 non-blank lines with `#print axioms` lines
  **6,313 = this line's 5,948 + `main`'s 6,174 − the base's 5,809**, no name printed twice; `ARCHITECTURE.md` 737; `Proofs.lean` 275.
  Its plants fire on each file (a line of theirs dropped: LOST; doubled: EXTRA; a marker left in: MARKER; in the file of records, a
  record doubled: TWICE, and one dropped: COUNT). Against `main`'s files the merge is additions only (`git diff --numstat 615c715c`:
  `ARCHITECTURE.md` 12 added, 0 removed; `Proofs.lean` 11, 0; `scripts/Axioms.lean` 154, 0).
- **The merge of `fs131-wf1`: the joined state, not a side** (`data/fs131/l10b/resolve_wf1.py`: exact replacements, each refused
  unless it matches once and the hunk has the shape expected).
  - `scripts/Axioms.lean`, IMPORTED: Falconer's `declareImport` line and its four records are gone from the section (theirs deleted
    them); Weil's `declareImport` line and its eight records stay (ours added them). Falconer's four, `falconer_lemma2_nonempty`
    itself and `MetricalBoundary`'s fifteen are under CLEAN, beside wave 2's `FalconerReduction` records, where `fs131-wf1` entered
    them. The section's sentence of current state — which `fs131-wf1` had rewritten to "The library declares no import at present …
    so this section is empty", and which merged by itself — now reads: "The library declares one import at present, wave 10's
    `StandingFive.kloosterman_bound` (`[Weil1948]` p. 207, FS131-K10c), with eight records below; its first, wave 2's
    `falconer_lemma2_nonempty`, is a theorem since FS131-IF1 (FS131-L10B's join)."
  - `ARCHITECTURE.md` § 5, "Imported outside theorems": Falconer's row gone, Weil's row alone; `fs131-wf1`'s line "None at present:
    the library declares no `axiom`. …" now reads "One at present. The library's first import, `[Falconer1981]` Lemma 2 (i)
    (FS131-K2c), is a theorem since FS131-IF1 — `falconer_lemma2_nonempty`, proved in `Plane/MetricalBoundary` — and is no longer
    in this table."
  - **The check** (`tools/fs131_l10b_joined.py --self-test HEAD a61f0d14 ca598960`, new, this job's; `joined-wf1.txt`, exit 0):
    (1) over `scripts/Axioms.lean`, `ARCHITECTURE.md` and `Proofs.lean` the three-way rule's faults are exactly the rewrites named
    above (the lines of theirs rewritten read LOST, their rewritings EXTRA; six lines in all) and nothing else; (2) the
    `declareImport` commands are exactly one, `HadwigerNelson.StandingFive.kloosterman_bound`; (3) the records between the IMPORTED
    and CLEAN banners are exactly the eight; (4) `falconer_lemma2_nonempty` and the four that rested on it are each printed once,
    under CLEAN; (5) the table has one row, and the section says neither "None at present" nor "declares no `axiom`". Six plants,
    each fired with its word: Falconer's `declareImport` put back (DECLARE); one of Falconer's four put under IMPORTED (IMPORTED);
    one of Weil's eight moved under CLEAN (IMPORTED); Falconer's row put back (ARCH); "None at present" put back (ARCH); a line of
    theirs dropped from `Proofs.lean` (THREE-WAY). The check's first run read the `declareImport` line quoted as an example inside
    the section's docstring as a second declaration — its fault, repaired (commands are read outside `/- … -/` blocks) before any
    result was taken from it.
  - `#print axioms` lines after it: **6,329 = 6,313 + `fs131-wf1`'s 5,825 − its base's 5,809**.
  - `scripts/axioms-controls.txt` merged with no conflict and is `fs131-wf1`'s file whole (`git diff --quiet a61f0d14`): it expects
    no declared import, and so describes neither `main` nor the joined tree. Its edit to the joined state is Stage 3's, red before
    and green after.
- **The index held the merge and nothing else** (`tools/fs131_l10b_mergeindex.py <hash> <the paths both sides changed>`;
  `mergeindex-main.txt`, `mergeindex-wf1.txt`): `MERGE_HEAD` the named commit; no path unmerged; the staged paths exactly those
  theirs changed since the base (326; 31); every one but the named paths taken whole from theirs (323; 28); the working tree equal
  to the index. Controls run live at each merge, each exit 1 before the faithful run's exit 0: the resolved path not yet staged
  (UNMERGED, DIRTY: `mergeindex-*-control-unstaged.txt`); the paths that merged by themselves not named (`BOTH sides changed, merged
  unread: ARCHITECTURE.md`, `Proofs.lean`: `mergeindex-*-control-unnamed.txt`) — so no such path was committed without the
  three-way check having read it.
- A merge cannot be committed by path; each was committed whole after that check, and this job's logs went in commits of their
  own by path (`74814a95`, `66b1b471`).

### 2.2 No statement of any side changed

No Lean file is changed by two sides (§ 1.3), so every Lean file of the joined tree is one side's file whole, shown by
`git diff --quiet`: the fifteen files of `Arith/` this line holds (its eleven new modules, and `CharacterColouring`,
`SpectralInputs`, `StationaryRatio`, `StandingFive`) equal `248f8f4f`'s; `Plane/FalconerReduction` and `Plane/MetricalBoundary`
equal `a61f0d14`'s; and `git diff --name-only 615c715c HEAD -- Proofs Proofs.lean lakefile.toml lake-manifest.json lean-toolchain`
names `Proofs.lean`, the eleven and the two and nothing else — every other Lean file is `main`'s. Byte-identity is stronger than a
comparison of statements, and it is still a comparison of text: what the kernel holds of each head is Stage 4's.

### 2.3 The build of the joined line

`main`'s compiled modules were copied in from the last landing's idle worktree before the build (`rsync -a --update
../fs131-w6j/.lake/build/ .lake/build/`; `data/fs131/l10b/rsync-w6j-build.txt`: 15 `.olean` files among those written, the fourteen
of `Plane/Saturated/` and `Proofs`; that tree is at `e618ee65`, clean, its Lean inputs `main`'s; no process had its working
directory there; the exit status that log prints is its filter's, not `rsync`'s — a slip of the runner, harmless: Lake checks every
module's trace by hash, and it rebuilt all fourteen anyway, because `FalconerReduction`, which they depend on through `Plane/Slack`,
changed). `.lake/build` stays this worktree's own directory.

`data/fs131/l10b/build-merges.log` (`HEAD=66b1b471`, whose Lean sources are `6f3053dc`'s; no tracked file modified): **`build: OK —
471 of 471 batches, 23 module(s) rebuilt, 0 module(s) with warnings, 11m17s`, `exit=0`**. The full log (`build-merges-full.log`)
holds **0 `warning` lines** and ends "Build completed successfully (5932 jobs)". Rebuilt: `Plane/MetricalBoundary`,
`Plane/FalconerReduction` and its dependents (`Plane/Slack`, `Plane/CoverExamples`, `Plane/YesLimit`, `Plane/ValidMap/Dense`, the
fourteen of `Plane/Saturated/`, …), and `Proofs`. One build after the two merges: they change disjoint Lean files, and each merge
was checked by script before the next was made. **This is the first tree to hold wave 6's first half, the second pass of wave 10
with its import, and the proof of Falconer's lemma together, and the kernel accepts it** — no wave-10 module depends on
`FalconerReduction`, and none of `Plane/Saturated/` on `Arith/`'s new modules.

## Stage 2 — SAVED (FS131-L10B)

## Stage 3 — SAVED (FS131-L10B): the audit's controls at the joined state; the ruled tidies — one statement changed, one word of an instance, the docstrings

### 3.1 `scripts/axioms-controls.txt`: red before, at exactly the three controls that read the library's state

On the joined tree as merged (the controls file `fs131-wf1`'s: no declared import), `./scripts/axioms.sh --self-test`
(`data/fs131/l10b/axioms-selftest-red-before.log`, exit 1; the complete output `receipt-axioms-self-test-red-before.log`): **"FAIL — 3
of 23 control(s) did not behave as designed"** — `baseline` ("passed; expected COUNTS imported=0 … declared=0 … library=0"),
`imported_declared` (expected `1 / 1 / 1`), `banner_dropped` ("failed (10 FAIL line(s))": with eight records in the section,
dropping its banner strands them and their declaration, consequences the control did not expect). The other twenty behaved. The
edit (`data/fs131/l10b/controls-edit.py`, five exact replacements, the pattern of `082f86c9`): `baseline` expects `imported=8
declared=1 library=1` and its `old` digest "… and the audit has 8 imported"; `imported_declared` expects `9 / 2 / 2` and "… has 9
imported"; `banner_dropped` gains `expect FAIL outside-banners kloostermanBound_of_ringChar_ne_two` and `expect FAIL
stale-declaration kloosterman_bound`; the header's paragraph says the state it reads (one declared import,
`StandingFive.kloosterman_bound`, eight records). **Green after** is the gate's own run on the gated commit (Stage 5).

`./scripts/dupnames.sh` on the joined tree, before anything else read an axiom list (`dupnames-joined.log`, exit 0): **"dupnames: OK
— no name is declared by two modules (23 generated on demand, listed above)"** — `main`'s own count of generated names. The join of
this line, `main` and `fs131-wf1` made no doubled name.

### 3.2 What was ruled, and what changed (the brief's item 3)

Every edit is an exact text replacement that must match once (`data/fs131/l10b/tidy.py`: `--check` first, then the write;
`tidy-applied.txt`: 25 edits in 7 files, 0 refused; the whole diff of the Lean files is `tidy-diff.txt`). All went through as ruled;
none is deferred. Commit `3c4172e2`, on Stage 2's tip `53f4cde5`.

**(i) The one statement change (ruling 542).** `MajorityVote.ae_eq_measurable_of_majority` loses `(hG : Measurable G)` and
`(hc : ∀ x, Measurable (c x))`, and `[Finite K]` is `[Countable K]`; the name stays. In its proof, the three lines that only read
the dropped hypotheses (`have _hG := hG`, `have _hc := hc` and their comment) and the line that derived countability
(`haveI : Countable K := Finite.to_countable`) are gone; nothing else of the proof moved. **Its callers: one, the spec example of
its own file** (`git grep`: no other use under `Proofs/`). The example's call line loses the two arguments; and the example's own
binder `(hG : Measurable G)`, which existed only to be passed to the lemma, is dropped with them (left in, it is an unused variable
and a build warning) — its conclusion is unchanged. *Reported to the coordinator mid-job and ratified* ("the caller's line adjusted
and nothing more"). The docstrings say what is now held: the theorem's ("A `G` with values in a countable type … Neither `G` nor the
`c x` is assumed measurable"), and the module's paragraph that said "The argument reads less than the statement carries" now says
"The statement is at the class the argument reads (inventory ruling 542 …)".

**(ii) The instance.** `StandingFive`: `local instance instNumberFieldStanding` is `instance instNumberFieldStanding` — one word —
and its docstring's "local to this file" reads "Global since wave 10's second landing, so that no module downstream declares its
own: two anonymous instances of one proposition merge in silence".

**(iii) Docstrings, base text otherwise intact.**

| where | was | now |
|---|---|---|
| `involution_eq_pow` (`NormOneTarget`; ruling 538 (b)) | the fixed-field sketch ("Its fixed field `k₀` has `Q` elements (`[k : k₀] = 2`, Artin) …") | the proof the kernel holds: `σ` a power `y ↦ y ^ p ^ j` of the Frobenius over the prime field (`FiniteField.bijective_frobeniusAlgHom_pow`); `σ ∘ σ = id` gives `n ∣ 2j`, `σ ≠ id` gives `j ≠ 0`, so `2j = n`, `Q = p ^ j` |
| `sp_if` (`SpectralInputs`; ruling 547 (a)) | "**`hcirc : I.NegCircle` has no Lean model on file** … until it lands this theorem is an open gate item …" | "MODEL: given `hBH`, every other hypothesis holds at once at `F = ℚ` with `Interface.trivial` (`sp_if_hypotheses_trivial_bot` …). **One named classical hypothesis is still assumed**: `hBH` is the Herglotz–Bochner theorem for the countable discrete group `unitRing ⊥` … Until it is proved this theorem stays an open gate item … open by one classical theorem." (the planner's § 15.4 wording) |
| `si4`, `spectral_carried_iff`, `contChars_haar_null` (`SpectralInputs`; the planner's § 16.2) | no inhabitant note | each gains the planner's note, marked "MODEL (the planner's note, `plans/FS131-w10-kernel-plan.md` § 16.2; described, **not a Lean declaration**)", and the sentence that until the model is a declaration the theorem is an open gate item |
| `si4_equivariant` (`SpectralInputs`; § 16.2) | no inhabitant note | "MODEL: any additive action with `T 0 = id`, `𝒜` its factor σ-algebra — `comap_factorSigma_eq_of_action` supplies `hS𝒜`, and `si4_equivariant_factorSigma` is this theorem there (`Arith/FactorAction`)" — both are landed theorems |
| `Floor128`, module docstring; `bezout4`, `bezout128` (§ 15.2) | "**`bezout4` and `bezout128` are not read**" | "… are not read by the bridge … They stay as an independent witness of `P`'s irreducibility …"; each identity's docstring gains "Not read by the bridge: an independent witness of `P`'s irreducibility (… Rabin's test)" |
| `FloorPlanes`, module docstring; `KloostermanBound` | "(ruled mid-job: no `axiom` until a held source's page is read back against it)"; "`[Weil1948]` … (not held; its row states the bound at a prime)"; "neither held, so this is a `Prop`, never an `axiom`, until a page is read back against it" | "`[Weil1948]` p. 207 … held and read back …: **the import is `StandingFive.kloosterman_bound` (`Arith/WeilKloosterman`), at characteristic not 2**, and `kloostermanBound_of_ringChar_ne_two` proves `KloostermanBound F` from it"; the definition's docstring says it is the hypothesis form and names the import |
| `ARCHITECTURE.md`, rows `Arith/NormOneTarget`, `FloorPlanes`, `ProductFactor`, `MajorityVote`, `NegCircleModel` | "**FS-131 wave 10 (FS131-K10b), skeleton.**" | "(FS131-K10b; every leaf proved by FS131-I10D / -I10F, no `sorry`)", with the theorems the implementers added; `FloorPlanes`' row no longer says "never an `axiom`" and says its object: the norm-one target of `𝔽_{Q²}` (`TargetFloor 7 Q`), "G56's `χ(Γ_Q) ≥ 7` once the target is linked to the plane `Γ_Q`, which no declaration does yet"; `MajorityVote`'s row says the class of ruling 542 |

The three notes marked "not a Lean declaration" are the planner's reading, one mind, not kernel-checked; the docstrings say so, and
the three theorems are listed as open gate items below (drafts, item 7). The planner's § 16.2 priced two of the models at about 55
lines "to state and prove at the landing"; the brief's item 3 (iv) is "nothing else", so they are not stated here.

**(iv) Nothing else.** `StandingFive.seven_le_localBound` and `five_le_chromaticNumber` keep their hypothesis forms beside the new
heads; no hypothesis a ruling kept unread was touched; `FloorPlanes`' first paragraph, which reads G56's sentence as "the plane
`Γ_Q = UD(𝔽_Q, 2)` is the level-one target of `𝔽_{Q²}`", is left as the planner wrote it (it is the informal claim being read
against; the kernel holds no such link — listed in the report for the coordinator).

### 3.3 Exactly the ruled changes, by script

- **`tools/fs131_l10b_tidyshape.py --self-test 53f4cde5`** (new; `data/fs131/l10b/tidyshape.txt`, exit 0): (a) the Lean files that
  differ from Stage 2's tip are exactly six (`MajorityVote`, `StandingFive`, `NormOneTarget`, `SpectralInputs`, `FloorPlanes`,
  `Floor128`); (b) with every comment and docstring blanked, **the code lines removed are eight and the lines added five, in two
  files** — the majority vote's two statement lines, its four proof lines, the example's signature and call; the one instance
  line — and no other code line of any file changed: the other four files differ in comments and docstrings only; (c) the
  majority vote's statement is the old one with exactly ` (hG : Measurable G)` and ` (hc : ∀ x, Measurable (c x))` deleted and
  `[Finite K]` replaced by `[Countable K]`; (d) the instance line is the old one with `local ` deleted. Four plants, each fired
  with its word: a proof line changed in another file (CODE), a hypothesis of another theorem dropped (CODE), the majority vote's
  conclusion changed (SHAPE), a file outside the list touched in a comment only (FILES).
- **`tools/fs131_l10b_statements.py delta 53f4cde5 --changed … --docs …`** over the fifteen files of `Arith/` and the two of the
  Falconer line (`statements-tidies.txt`, exit 0): 525 declarations before, 525 after; **statements changed: exactly two —
  `MajorityVote.ae_eq_measurable_of_majority` and `StandingFive.instNumberFieldStanding` (its whole declaration is its statement:
  the word `local`); removed: none; added: none; a docstring changed with its statement unchanged: exactly nine** —
  `involution_eq_pow`, `sp_if`, `si4`, `si4_equivariant`, `spectral_carried_iff`, `contChars_haar_null`, `KloostermanBound`,
  `bezout4`, `bezout128`. Its self-test on `WeilKloosterman.lean`: five plants fired (`statements-selftest.txt`, exit 0; on
  `TargetFloors.lean`, tried first, one plant could not be planted and the self-test said so and failed — the file's shape, not a
  finding).
- **`data/fs131/l10b/archrows.py --self-test`** (`arch-rows.txt`, exit 0): the five rewritten rows exist once each, none says
  "skeleton", and each of the 34 backticked declaration names they cite is declared under `Proofs/`. Two plants fired (a cited
  name misspelt: MISSING; a row saying "skeleton": SKELETON). Its first run read three backticked letters of a formula of mine as
  names (MISSING) — the row was reworded, not the check. `tools/check_architecture.py`: `RESULT: PASS`, exit 0 (`arch-tidy.txt`).
- **Iteration, before the commit**: the tidied `MajorityVote.lean`, on a scratch copy, elaborates with both auto-implicit options
  off and the unused-variable linter on (`lake env lean` under the slot: exit 0, no message; `iter-majorityvote-tidy.log`).
  Iteration, not evidence.

### 3.4 The build of the tidied tree

`data/fs131/l10b/build-tidies.log` (`HEAD=3c4172e2`; no tracked file modified): **`build: OK — 471 of 471 batches, 12 module(s)
rebuilt, 0 module(s) with warnings, 8m51s`, `exit=0`**; the full log (`build-tidies-full.log`) holds **0 `warning` lines** and ends
"Build completed successfully (5932 jobs)". Rebuilt: `MajorityVote`, `SpectralInputs`, `StandingFive`, `FactorAction`,
`NormOneTarget`, `ProductFactor`, `NegCircleModel`, `FloorPlanes`, `Floor128`, `TargetFloors`, `WeilKloosterman`, `Proofs` — the
six tidied modules, their dependents and the import surface. So the global instance breaks no module downstream of
`StandingFive`, and the majority vote's one caller compiles against the new statement.

## Stage 3 — SAVED (FS131-L10B)

## Stage 4 — SAVED (FS131-L10B): every head's statement, read from the kernel

**Verdict: no head lacks a hypothesis its file shows.** For every theorem of the landing — not only the heads — the kernel's
statement holds every binder of the declaration's own signature; the section variables it does not hold are, each one, a bare
measure, σ-algebra or ring element that the statement does not mention.

- **The instrument** (new, this job's; inventory item 556's class). `data/fs131/l10b/kernel-sigs.lean` prints, from each
  constant's **stored type**, the signature `#check` shows and every `∀`-binder with its kind (explicit, implicit, instance) and
  sort (a proposition or data), for every theorem and axiom of the twelve new modules and for sixteen named heads of modules
  landed earlier (the Falconer line's five; `sp_if`, `si4`, `si4_equivariant`, `spectral_carried_iff`, `contChars_haar_null`;
  `numberField_standingField`, `instNumberFieldStanding`, `seven_le_localBound`, `five_le_chromaticNumber`, `usable_card_ge`,
  `no_small_usable`); a head that is no constant fails its elaboration. `tools/fs131_l10b_kernelsig.py` compares each record with
  the file: the declaration's own binder groups, and every typed `variable` in scope at it (sections and namespaces tracked,
  `variable … in`, `include`, `omit … in` read).
- **Run on the tidied tree** (`lake env lean` under the slot; `kernel-sigs-tidies.out`, exit 0; the reading
  `kernel-sigs-tidies-read.txt`, exit 0; one block per declaration with the kernel's signature beside the file's,
  `kernel-sigs-tidies-table.txt`; run again on the gated commit by the pass, `kernel-sigs-first-*`): **193 records — 192
  theorems and one axiom**; 17 generated by Lean (`eq_1`, `eq_def`, `congr_simp`: no text in a file, counted, not compared); **176
  compared with their files; MISSING-BINDER 0; NOT-FOUND 0; NO-RECORD 0 of the 68 names of `heads-all.txt`** (the 48 heads on the
  standard three and the 8 on the import that the brief, the three reports and the planner's lists name; the axiom; 11 landed heads).
  Section variables in scope: **378 read INCLUDED**; 7 OMITTED by the file's own `omit … in` (`[BorelSpace E]` three times in
  `MetricalBoundary`, `[MeasurableSpace Ω₃]` three times in `ProductFactor`, `[DecidableEq G]` once in `RatioBound`); 17
  type binders absent (no content); **27 instance or term binders ABSENT, in 17 theorems, every one reviewed**
  (`kernel-sigs-reviewed.txt`, written by `mk-reviewed.py` only for the classes read by eye and only where the kernel's statement
  does not mention the variable at all): `(t : R)` in three lemmas of `Floor128` that speak of `X` or of a root `g`; a bare
  measure (`{μX : Measure X}`, `{μ₃ : Measure Ω₃}`, `{μ' : Measure Ω'}`) or a σ-algebra on a type the statement does not mention,
  in thirteen set-theoretic or one-measure lemmas of `ProductFactor`; `[MeasurableSpace Ω]` and `{μ : Measure Ω}` in
  `contChars_haar_null`, whose statement is about a measure on the dual group. **None is a structure that bundles a hypothesis**
  (the case of item 556 was `(C : CountData M k)`); none is a `Prop`.
- **Its controls** (`kernel-sigs-tidies-selftest.txt`, exit 0): a `Prop` binder dropped from the kernel's record of a theorem whose
  file names it reads MISSING-BINDER; **a hypothesis `variable (hplant : (1 : Nat) = 1)` planted in scope of `NormOneTarget`'s
  theorems reads ABSENT on four of four** — the file's reader sees a hypothesis the kernel lacks, the class itself; a head with no
  record reads NO-RECORD; and the partner: `Floor128`'s `(t : R)` reads INCLUDED in ten theorems and ABSENT in three, so neither
  verdict is a blanket one. A slip of mine in the tool's first self-test, repaired before any result was taken: its partner named
  `si4`, which writes every binder in its own signature and has no section variable to read.
- **The one ruled change, in the kernel's words.** Before (`kernel-sigs-asgiven.out`): `… [Infinite I] [Finite K]
  [MeasurableSpace K] [MeasurableSingletonClass K] (G : Ω → K) (hG : Measurable G) (c : I → Ω → K) (hc : ∀ (x : I), Measurable (c x))
  (E : I → Set Ω) …`. After: `… [Infinite I] [Countable K] [MeasurableSpace K] [MeasurableSingletonClass K] (G : Ω → K)
  (c : I → Ω → K) (E : I → Set Ω) (hE : ∀ (x : I), MeasurableSet (E x)) {p : ℝ} (hp : p < 1 / 2) (hEp : ∀ (x : I), μ.real (E x) ≤ p)
  (hindep : ∀ (x y : I), x ≠ y → μ (E x ∩ E y) = μ (E x) * μ (E y)) (hGc : ∀ (x : I), ∀ᵐ (ω : Ω) ∂μ, c x ω ≠ G ω → ω ∈ E x) :
  ∃ g, Measurable g ∧ G =ᵐ[μ] g` (the σ-algebra of `Measurable g` is the one the `c x` generate; the printer hides it).
- **By eye, each of the brief's heads against the line the brief quotes** (the table's `kernel:` lines): `kloosterman_bound` —
  `(F : Type u) [Field F] [Fintype F] [DecidableEq F] (hp : ringChar F ≠ 2) (ψ : AddChar F ℂ) (hψ : ∃ x, ψ x ≠ 1) (c d a : F)
  (h4 : 4 * c * d = a) (ha : a ≠ 0) : ‖∑ x with x ≠ 0, ψ (c * x + d * x⁻¹)‖ ≤ 2 * √↑(Fintype.card F)`, the axiom as ruled, clause
  for clause; `standingFloor_seven_weil : StandingFloor 7`, `seven_le_localBound_weil : 7 ≤ localBound standingField` and
  `Floor128.targetFloor_eight_128 : TargetFloor 8 128` — no binder at all; `targetFloor_six_weil {Q : ℕ} (hQ4 : Q % 4 = 3)
  (hQ : 62 ≤ Q) : TargetFloor 6 Q`; `sp_if` — its file's binders, `hBH`, `hmul`, `hcirc`, `hm` among them;
  `falconer_lemma2_nonempty {S : Set ℂ} (hS : MeasurableSet S) (h1 : volume S ≠ 0) (h2 : volume Sᶜ ≠ 0)`;
  `exists_not_tendsto_ratio_and_compl` — `E` finite-dimensional normed, Borel, `(μ : Measure E) [μ.IsAddHaarMeasure]`,
  `(hS : NullMeasurableSet S μ) (h1 : μ S ≠ 0) (h2 : μ Sᶜ ≠ 0)`. And one the brief does not quote:
  `five_le_chromaticNumber_weil (hRow123 : min (localBound standingField) 5 ≤ χ(F²)) : 5 ≤ χ(F²)` — one hypothesis, a closed
  proposition (drafts, item 6).
- **What this stage does not show**: that a statement says its row's sentence — the planner's and the implementers' read-backs
  (their §§ 12–15 and reports), which the kernel's binders now agree with; and anything about a theorem outside the 193.

## Stage 4 — SAVED (FS131-L10B)

## Stage 5 — SAVED (FS131-L10B): the full gate — red at the lint on `e80221d3`, repaired on the coordinator's word, green at every step on `f0cc3018`

**The gated commit is `f0cc3018`.** Two whole passes were run (runner `data/fs131/l10b/run-pass.sh <tag>`: the build, the kernel's
list, `run-gate.sh`, the records check, the kernel-signature read, the two reconciliations against `main`'s gated receipts
`data/fs131/l6a/*-first.*`, the digests — each step under the slot, each log ending in its exit status).

### 5.1 The first pass, on `e80221d3` (tag `first`): one step red

Every step exit 0 but **the guarded lint, exit 1** (`lint-first.log`): "`@HadwigerNelson.SpectralInputs.fibre_mem_factorSets` 1
unused argument: argument 11: `[MeasurableSingletonClass Ω₁]`" (`ProductFactor.lean:393`; "Found 1 error in 12628 declarations",
thirteen linters passed) — FS131-I10F's own child lemma under `contVec_prod_eq`, whose proof does not read the instance; the
build's linters do not report an unused anonymous instance binder, and no branch of the second pass had run the lint on that
file. The repair is a statement change, so it was **a message to the coordinator, with three options; ruled (a)**: "delete the
one binder … It is the pattern of rulings 494 (a) and 507 (a) … exactly one declaration changes, by exactly that binder; its
caller's text and the callers' own `[MeasurableSingletonClass Ω₁]` binders are untouched". Made as ruled (`f0cc3018`): one line
of `ProductFactor.lean`. Checked: on a scratch copy the file elaborates with the binder gone (`iter-productfactor-binder.log`,
exit 0, no message); `tools/fs131_l10b_tidyshape.py --self-test 53f4cde5` with that one line added to its lists (`tidyshape.txt`,
exit 0: **code lines removed nine, added six, in three files**; four plants fired); `tools/fs131_l10b_statements.py delta`
(`statements-tidies.txt`: statements changed exactly three — the majority vote, the instance, `fibre_mem_factorSets` — removed 0,
added 0, nine docstrings alone); the kernel's signature of `fibre_mem_factorSets` on the gated commit holds no
`MeasurableSingletonClass` (`kernel-sigs-final-table.txt`); the lint then reports no second line. Build
(`build-binder.log`, `HEAD=f0cc3018`): **`build: OK — 471 of 471 batches, 2 module(s) rebuilt, 0 module(s) with warnings`**
(`ProductFactor`, `Proofs`), 0 `warning` lines, "Build completed successfully (5932 jobs)".

### 5.2 What this job registered, by the gate's own procedures (commit `e80221d3`)

- **`scripts/Axioms.lean`**: a block "FS131-L10B" of **5 records** — the hand-written theorems of the landing no block listed
  (`measurePreserving_prodMap₃`, `RatioBound.fourier_sq_mul_charSum`, `standingFloor_seven`, `standingFloor_five`,
  `seven_le_localBound_of_kloosterman`), read from the kernel's own list (`tools/fs131_l10b_register.py` on
  `data/fs131/l5/count-modules.lean`'s two outputs; `register-before.txt`, `register-after.txt`: MISSING 5 → 0, STALE 0,
  FOREIGN-MODULE 0; its self-test: a record removed reads MISSING, a record naming nothing reads STALE). `#print axioms` lines:
  6,329 + 5 = **6,334** = `main`'s 6,174 + the landing's 160 hand-written theorems.
- **`scripts/Vacuity.lean`**: the entry "Wave 10's second pass, its import, and Falconer's lemma proved (FS131-L10B …)". **No
  new carrier IN**; no name added to `trackedProps`, no control planted; `scripts/vacuity-controls.lean` and `scripts/vacuity.sh`
  untouched. The census (`data/fs131/l10b/census.lean`, wave 5's with its scope changed; `census.out`) lists **two
  hypothesis-formers** in the twelve new modules, `StandingFive.KloostermanBound` and `GapSeven.Gapped`: `refut=0`, `isEmpty=0`,
  `closedSites=0` on both — so for neither could step (3)'s `VACUOUS` control be planted; both OUT, each with its inhabitant
  named in the entry.
- **`scripts/vacuity-baseline.txt`**: the header's counts, from `scripts/gate_report.py header`, **on the coordinator's word**
  ("update the two count lines … no entry added, removed or reworded"). **One line changes, not two**: the second line's six
  counts did not move. The file's diff (`vacuity-baseline.diff`):
  ```
  -#   declarations=14299  refutations-skipped=199  sites=1269
  +#   declarations=14501  refutations-skipped=199  sites=1269
  ```
  Made after a probe scan (`vacuity-probe.log`) and confirmed by the gated pass, whose digest reads the header "match (9 of 9
  compared)" — the scan's final run on the commit that lands.
- **`scripts/axioms-controls.txt`**: Stage 3's edit. `ARCHITECTURE.md`, `Proofs.lean`: the merges' and Stage 3's.

### 5.3 The second pass, on `f0cc3018` (tag `final`): every step exit 0

`run-gate-final.head` records `HEAD=f0cc3018…` and **no tracked file modified**; `run-pass-final.out` reads exit 0 at every step.

| step | result | log (`data/fs131/l10b/`) |
|---|---|---|
| build | `build: OK — all 1831 modules already up to date, nothing built, 0 module(s) with warnings`, exit 0; the full builds of these Lean sources are Stage 3's and § 5.1's: 471 of 471 batches, **0 `warning` lines** in each | `build-final.log`; `build-tidies-full.log`, `build-binder-full.log` |
| `sorry` | narrow pattern: **0** lines; `\bsorry\b`: 8, all prose, the eight `main` holds (`Packed` l. 266, `Plane/Cover` l. 33, `Plane/CoverExamples` l. 13 and 6541, `BendStep` l. 345, and `Pinch`, `LocalGraph`, `FanBridge`'s "no `sorry`") — none in a file of this landing | `sorry-narrow-final.txt`, `sorry-wide-final.txt` |
| doubled names, **before the audit** | **"dupnames: OK — no name is declared by two modules (23 generated on demand, listed above)"** | `dupnames-final.log`, `receipt-dupnames-final.log` |
| its self-test | "OK — all 15 controls behaved: every planted fault fired, and every partner passed." | `dupnames-selftest-final.log` |
| axioms | **"axioms: OK — 6304 clean, 17 axiom-free, 8 imported, 5 declared purchase(s)"**; "audited: 6334 records"; "declared imports (1): HadwigerNelson.StandingFive.kloosterman_bound"; "library axioms other than native auxiliaries (1): HadwigerNelson.StandingFive.kloosterman_bound; native auxiliaries: 10" | `axioms-final.log`, `receipt-axioms-final.log` |
| its self-test — **green after** Stage 3's edit | "OK — every planted fault fired, and every partner passed." (23 controls) | `axioms-selftest-final.log` |
| vacuity | **"vacuity: OK"**; `declarations=14501 refutations-skipped=199`, `sites=1269 vacuous=0 stale=0 declared=3 witnessed=38 generic=1226 unknown=2`; baseline header "match (9 of 9 compared)" | `vacuity-final.log`, `receipt-vacuity-final.log` |
| its self-test | "OK — all 65 controls behaved: every one fired, and the silent ones stayed silent." | `vacuity-selftest-final.log` |
| architecture | "RESULT: PASS", exit 0 | `arch-final.txt` |
| guarded lint (`lake lint --no-build -- --no-build --trace`, `--mem 8`) | exit 0, "-- Linting passed for Proofs.", 14 linters each "(2/2) Passed!" | `lint-final.log` |
| notes | `notes read: 196 LOCAL-SAID=31 NO-OBJECT=48 NONE-SAID=59 no-conflict=58`, **0 CONFLICT** — `main`'s own count: the check reads the audited modules of `Plane/ValidMap` and their kin and none of this landing's; `tools/fs131_qa4_notes.py --self-test`: "OK (6 controls, 1 planted)" | `notes-final.txt`, `notes-qa4-selftest-final.txt` |
| records, against the kernel's own list | **PASS** (§ 5.4) | `records-final.txt` |
| every head from the kernel | **PASS**: 193 records, 176 compared, no MISSING-BINDER, 27 absent data variables all reviewed (Stage 4) | `kernel-sigs-final.out`, `-read.txt`, `-table.txt` |

### 5.4 The axioms, reconciled

- **Every theorem of the landing is audited** (`tools/fs131_l10b_records.py`, new — `tools/fs131_l5_records.py` with the import's
  eight read as IMPORTED; on `count-modules-final.out` against `data/fs131/l6a/count-modules-first.out`): the library holds
  9,513 theorems against `main`'s 9,336 — **177 new, 0 gone**; 17 are generated by Lean (`congr_simp` 3, `eq_1` 8, `eq_2` 3,
  `eq_def` 3); **the 160 hand-written each have exactly one record: 152 under CLEAN — 135 on exactly the three, 9 on `[propext,
  Quot.sound]`, 8 on `[propext]` — and 8 under IMPORTED, each on exactly the three and `StandingFive.kloosterman_bound`.** By
  module: `FactorAction` 3, `Floor128` 48, `FloorPlanes` 17, `GapSeven` 8, `MajorityVote` 6, `NegCircleModel` 11,
  `NormOneTarget` 4, `ProductFactor` 23, `RatioBound` 5, `TargetFloors` 5, `WeilKloosterman` 14, `Plane/MetricalBoundary` 15,
  `Plane/FalconerReduction` 1 (`falconer_lemma2_nonempty`, an axiom on `main`, a theorem here).
- **Over the whole log, not only the landing's records**: records under IMPORTED **8**, exactly the eight; records carrying the
  import **8**; **records listing `falconer_lemma2_nonempty` as an axiom: 0**. The four that rested on it
  (`falconer_reduction`, `le_chiM_of_falconerFan`, `exists_mem_falconerE`, `fan_tip_ae_mem`) are under CLEAN on the three.
- **The heads**: the 48 of `heads.txt`, each "exactly the standard three"; the 8 of `import-heads.txt`, each "exactly the
  standard three and StandingFive.kloosterman_bound". **No record of the landing prints `sorryAx`.**
- **Against `main`'s gated audit** (6,174 records): 6,334 − 6,174 = 160 added; clean 6,148 → 6,304 (+152 new, +4 moved from
  IMPORTED); imported 4 → 8; axiom-free 17 and purchases 5 unchanged (`digest-axioms-final.txt`). The landing has no
  `native_decide`.

### 5.5 The vacuity counts, reconciled — the scan reads no new site

`tools/fs131_l5_vacdiff.py` (`vacdiff-final.txt`, PASS): the counter agrees with both scans; `declarations` 14,299 → 14,501
(**+202, all in the twelve new modules**: `FactorAction` 3, `Floor128` 75, `FloorPlanes` 18, `GapSeven` 13, `MajorityVote` 6,
`NegCircleModel` 11, `NormOneTarget` 5, `ProductFactor` 31, `RatioBound` 5, `TargetFloors` 5, `WeilKloosterman` 15,
`MetricalBoundary` 15; no count of a module of `main` changed — the axiom that became a theorem is still one declaration);
`refutations-skipped` 199 → 199. **Row for row against `main`'s gated scan (1,350 rows): 0 lost, 0 added.** `sites` 1,269,
`generic` 1,226, `witnessed` 38, `declared` 3, `unknown` 2: all unchanged. **No new site, so none reads `VACUOUS`, `STALE` or
`UNKNOWN`; nothing asks for a baseline entry.** The probe scan before any registration text read the same nine counts
(`vacdiff-probe.txt`). What the scan does not read of the landing: its two formers left OUT; hypothesis sets that hold together
on no object of the library — the open gate items of the drafts' item 7.

### 5.6 Each check's negative control, watched

| check | the plant | what went red |
|---|---|---|
| build's warning count; lint | the first pass: one unused instance argument (not a plant — § 5.1) | lint exit 1, naming the declaration and the argument; exit 0 after the repair |
| `sorry` scan | the third pass's tip `e09209e4`, which this landing does not merge (`git grep` there: `LevelGraph` 2, `UsablePlace` 1 — inventory item 555's receipt) | 3 lines, against 0 here |
| doubled names | its 15 controls | each fired |
| axioms | its 23 controls — **three of them red before Stage 3's edit and green after**; the records check's eight plants on this pass's log (`records-plant.txt`, exit 1, "plants fired: 8 of 8": `sorryAx` on a head, a record dropped, doubled, moved under PURCHASED, a head on fewer axioms, one of the eight stripped of the import, a CLEAN record given the import, a record given Falconer's lemma as an axiom) | named each |
| vacuity | its 65 controls; the row check's plants (`vacdiff-plant.txt`, exit 1) | named each |
| architecture | the row check's two plants (Stage 3); FS131-IF1's two on copies (its record) | fired |
| notes | its self-test | fired |
| the merges | the three-way check's plants on every both-changed path; the joined-state check's six; the merge index's live controls (Stage 2) | each fired |
| this job's tools | `tools/fs131_l10b_quotes.py`, `_keepboth.py`, `_joined.py`, `_statements.py`, `_tidyshape.py`, `_register.py`, `_kernelsig.py` `--self-test`; `_records.py --plant`; `_mergeindex.py` by live controls | each plant fired beside a faithful run |

### 5.7 The drafts, checked by the digest

Drafts 1 and 2 below, applied to a scratch copy of `CLAUDE.md`, are read by `scripts/gate_report.py` against this pass's logs:
§ Trust ledger "match (clean, purchases and imported compared)" (`digest-axioms-draft.txt`); § The gate "match (9 of 9
compared)" (`digest-vacuity-draft.txt`). The unedited `CLAUDE.md` is flagged STALE by both digests until the filing (6148 →
6304, 4 imported → 8; declarations 14299 → 14501).

### 5.8 Read against the informal statement, aloud

The planner and the implementers read each statement against its row (the plan's Stages 12–15; the three reports; FS131-IF1's
Stage 5); this landing changed two statements, both by dropping what the proof did not read. The statements the front page will
quote, read here once more on the joined tree from the kernel's signatures, with what each is not:

- `StandingFive.kloosterman_bound` — the **axiom**: "for a finite field `F` of characteristic not 2, an additive character `ψ`
  with some value other than 1, and `c, d, a` with `4cd = a ≠ 0`: `‖Σ_{x ≠ 0} ψ(cx + dx⁻¹)‖ ≤ 2√|F|`" — `[Weil1948]` p. 207's
  second display, clause for clause (the planner's Stage 12; the coordinator's own reading, item 554). Not assumed: anything at
  characteristic 2. Its model in the file: `ZMod 3`, where the conclusion is a theorem with no axiom.
- `standingFloor_seven_weil : StandingFloor 7` — "every field of `128²` elements, and every field of `Q²` elements with `Q ≡ 3
  (mod 4)`, `Q ≥ 347`, with a non-trivial involution `σ`, has `χ(Cay(k, {x : x·σ(x) = 1})) ≥ 7`"; over the import and nothing
  else. `seven_le_localBound_weil : 7 ≤ localBound standingField` — TC1-STANDING-FIVE's "so `L(F) ≥ 7`", `F = K·E₇`. **Not** a
  statement about `χ` of `F`'s plane, of any finite plane `Γ_Q`, or of `ℝ²`.
- `targetFloor_six_weil {Q} (hQ4 : Q % 4 = 3) (hQ : 62 ≤ Q) : TargetFloor 6 Q` — "the norm-one target of every field of `Q²`
  elements needs six colours"; stated for every `Q`, empty of content where `Q` is no prime power; over the import.
- `Floor128.targetFloor_eight_128 : TargetFloor 8 128` — "every field of `2¹⁴` elements with a non-trivial involution has
  `χ(normOneCayley) ≥ 8`"; the standard three, no import, run in its file at `GaloisField 2 14`. G56's "`U₁₂₈`'s Hoffman floor
  is 8"; the exact spectrum is not in the kernel.
- `MajorityVote.ae_eq_measurable_of_majority` — FS131-E8-SI5C at the class of ruling 542: values in a countable type, no
  measurability of `G` or the `c x`, events of probability at most `p < 1/2`, pairwise independent, over an infinite index set.
- `Plane.falconer_lemma2_nonempty` — `[Falconer1981]` p. 185, Lemma 2 (i) at `n = 2` for Borel `S`: now a theorem;
  `Plane.exists_not_tendsto_ratio_and_compl` — the same in every finite dimension, for an additive Haar measure and a
  null-measurable set.
- `sp_if` — J45-SP-if over an interface; still over `BochnerHerglotz`.
- What none of these is: a new value or bound of `χ(ℝ²)` or of any field's plane; a proof of Weil's bound.

## Stage 5 — SAVED (FS131-L10B)

## Stage 6 — SAVED (FS131-L10B): the landing — `main` fast-forwarded to `3b2e9848`

`origin/main` had moved after the gated merge, from `615c715c` to `fd855acb` — eleven commits; `data/fs131/l10b/main-since-gate.txt`:
nine paths under `data/`, two under `plans/`, **nothing else**, so by the brief's item 7 the gate was not run again. Merged as
`3b2e9848` (`git merge --no-ff`, by hash, no conflict; the index checked, `mergeindex-main2.txt`: 11 paths, none changed by both
sides, each taken whole from `main`). Checked before the push, at `3b2e9848` (`data/fs131/l10b/pre-push.txt`): `origin/main`
(`fd855acb`) an ancestor of `HEAD`; the branch as given (`248f8f4f`), `fs131-wf1`'s tip (`a61f0d14`), the first merge's `main`
(`615c715c`), the first pass's commit (`e80221d3`) and the gated commit (`f0cc3018`) ancestors of `HEAD` — no line was rewritten;
`git diff --name-only f0cc3018 HEAD -- . ':!plans' ':!data'` names **nothing** — the gate's inputs are the gated commit's; no
tracked file modified; `sorry` under `Proofs/` by the gate's narrow pattern: 0; none of the third pass's three row modules is in
the tree. **`git push origin HEAD:main`: `fd855acb..3b2e9848`, a fast-forward** (`data/fs131/l10b/push-main.txt`); after it
`origin/main` = `origin/fs131-w10m` = `3b2e9848`. No background process is left running: every build and pass ran under the slot
and exited.

**What is on `main` now**: wave 10's second pass — the eleven new modules of `Arith/` and the import's module among them — and
`Plane/MetricalBoundary` with Falconer's lemma proved: 160 hand-written theorems, 0 `sorry`, each with one audit record, 152
within the standard three and 8 on the standard three and `StandingFive.kloosterman_bound`; **one declared outside axiom**; the
ruled tidies; the scan's entry in `scripts/Vacuity.lean` and the baseline header's count; the audit's controls at the joined
state; the planners', the implementers' and this job's records, tools and logs through Stage 5. **What `main` does not hold**:
this stage, the drafts below, the final lists and the report — they are on `fs131-w10m` after `3b2e9848`, under `plans/` and
`data/` alone; the brief gives this job one push to `main`, and it was the landing's. **What `main`'s front page does not say
yet**: `CLAUDE.md` § Trust ledger and § The gate hold the last landing's counts until drafts 1 and 2 are filed; both gates'
digests flag them STALE and name the new numbers.

## Stage 6 — SAVED (FS131-L10B)

## Drafts for the front page (FS131-L10B)

The gated commit is `f0cc3018`; the landed tip differs from it in `plans/` and `data/` alone (Stage 6). The saved gate logs are in this
worktree under `build/gate/`; the copies are committed under `data/fs131/l10b/`: `receipt-axioms-final.log`,
`receipt-vacuity-final.log`, `receipt-dupnames-final.log`, the three self-tests' (`receipt-<gate>-self-test-final.log`), and the
full builds `build-tidies-full.log`, `build-binder-full.log`. To re-read: `python3 scripts/gate_report.py axioms
data/fs131/l10b/receipt-axioms-final.log data/fs131/l6a/receipt-axioms-first.log CLAUDE.md` and `python3 scripts/gate_report.py
vacuity data/fs131/l10b/receipt-vacuity-final.log data/fs131/l6a/receipt-vacuity-first.log scripts/vacuity-baseline.txt CLAUDE.md`.

**1. `CLAUDE.md` § Trust ledger** — replaces "the current audit reads 6148 clean and 5 declared purchases, and 4 imported (and 17
axiom-free; 6,174 records at wave 6's first landing, FS131-L6A, 2026-10-06)". From `axioms-final.log` l. 3 ("audited: 6334 records —
6304 clean on the standard axioms, 17 axiom-free, 8 imported (resting on a declared outside theorem), 5 declared purchase(s)"):

> the current audit reads 6304 clean and 5 declared purchases, and 8 imported (and 17 axiom-free; 6,334 records at wave 10's second
> landing, FS131-L10B, 2026-10-06)

and, after the sentence's clause "an imported record rests on a declared outside theorem (`LEAN.md` § Trust ledger)", one new
sentence (from the same log, l. 16: "declared imports (1): HadwigerNelson.StandingFive.kloosterman_bound"; l. 26: "library axioms
other than native auxiliaries (1)"):

> The library declares one outside axiom, `StandingFive.kloosterman_bound` — Weil's bound for Kloosterman sums, `[Weil1948]`
> p. 207, read against its page by two readers — and the eight imported records are the theorems that rest on it; its first
> import, `[Falconer1981]` Lemma 2 (i), is a theorem since FS131-IF1.

**The imported count is of records, not of axioms**: 8 records, 1 axiom. Against `main`: clean 6148 → 6304 (+156: Falconer's four
moved from IMPORTED, and 152 new records), imported 4 → 8 (−4 on Falconer's lemma, +8 on Weil's bound), axiom-free 17, purchases
5, records 6174 → 6334 (+160).

**2. `CLAUDE.md` § The gate**, the two count lines — replace "`declarations=14299 refutations-skipped=199 sites=1269`, `vacuous=0
stale=0 declared=3 witnessed=38 generic=1226 unknown=2`" by (from `vacuity-final.log`, "scanned:" and "sites:"):

> `declarations=14501 refutations-skipped=199 sites=1269`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1226 unknown=2`.

Only `declarations` moves (+202, the twelve new modules). The baseline's two entries are unchanged.

**3. `tools/claude_md_fact_audit.py`, `GATE_CHANGES`** — one entry after the last:

```
    (("6148", "5"), ("6304", "5")): "FS-131, wave 10's second landing (FS131-L10B; copy data/fs131/l10b/receipt-axioms-final.log, gated commit f0cc3018): 6,334 records, 6,304 clean, 17 axiom-free, 8 imported, 5 purchases",
```

**4. `LEAN.md`.**
- § Assumptions, after item 2 of "An imported theorem carries four things" (the planner's § 16.7, ruling 555 (e)): "State the
  axiom in the paper's own form and derive the form the library uses: the translation is then kernel-checked and the read-back is
  symbol against symbol (`StandingFive.kloosterman_bound`, with `kloostermanBound_of_ringChar_ne_two` and
  `kloosterman_page_of_kloostermanBound`)."
- § The kernel's cost model, the bullet on a closed `Nat` term: delete ", on branch `fs131-w10e` until wave 10's second landing" —
  `data/fs131/i10e/lean/closed-term/` is on `main` with this landing.
- § Searching — Lean, after the bullet "A section `variable` enters a theorem only if …": "`data/fs131/l10b/kernel-sigs.lean` with
  `tools/fs131_l10b_kernelsig.py` is that reading for a list of modules: the binders of each stored type against the file's own
  signature and every `variable` in scope (FS131-L10B)." And FS131-IF1's `ENNReal` bullet (its Drafts item 6), unchanged.
- § The gate: the counts it quotes ("23 planted faults", "sixty-five controls", "fifteen controls") are unchanged.

**5. `BIBLIOGRAPHY.md`** (rows by their keys; line numbers on `main` today).
- **`[Weil1948]`** (l. 165), from the planner's § 16.7, corrected for the landing: read status "read: pp. 204–207 (FS131-K10c,
  2026-10-06; pp. 206–207 at 300 dpi), read back against the Lean statement in `plans/FS131-w10-kernel-plan.md` Stage 12; the
  displayed sentence read again by the coordinator (inventory item 554)". Replace "It is the import ruled for FS-131's floor …"
  by "**It is imported**: `StandingFive.kloosterman_bound` (`Arith/WeilKloosterman`), on `main` since FS131-L10B — the second
  display of p. 207 in the page's form, characteristic not 2; the library's one outside axiom, with eight theorems resting on
  it". Add: "a slip in print on p. 206: `ω(1 + x₁T + …) = −ψ(x₁)`, read `ψ(−x₁)`; it does not touch the displayed bound". And
  "`> 5` for `p ≥ 62`" is `targetFloor_six_weil` [kernel over the import] — **as a statement about the norm-one Cayley graph
  of `𝔽_{p²}`**, not yet about the plane `UD(𝔽_p, 2)` (no declaration links the two).
- **`[MMST1996]`** (l. 158), the planner's § 15.1 sentence (ruling 538 (a), met): "Theorem 3 (p. 231) at `n = 2` holds exactly
  when `a ≠ 0` or `b` is anisotropic (`circle_sum_le_weil`, [kernel] over the import `[Weil1948]`), and fails at `a = 0`, `b ≠ 0`
  isotropic, `q ≥ 9`, where the sum is `q − 1` (`−1` a square) (`circle_sum_zero_of_isotropic`, `two_sqrt_lt_circle_sum_zero`,
  [kernel], no axiom)"; and its "verified numerically here" for (11) at `n = 2` becomes "`circle_sum_eq_kloosterman` [kernel]".
- **`[Falconer1981]`** (l. 171) and **the Croft debt row** (l. 884): FS131-IF1's Drafts item 5, word for word; with the join its
  first sentence stays true — the lemma "is no longer assumed" — and the library is not axiom-free: say "the library's one
  remaining import is `[Weil1948]`'s" where IF1's other drafts say "the library declares no axiom".
- No new row: nothing was read by this job; the planner's and IF1's reading statuses are theirs.

**6. The named hypotheses each landed theorem rests on, by name** — written so the gate's assumptions step (FS131-T5's, landing
after this) can declare from it. From the kernel's binders (`kernel-sigs-final.out`: every `Prop` binder whose type mentions a
former below), not from the text.

| hypothesis (full name, or theorem and binder) | kind | source | theorems of this landing that take it |
|---|---|---|---|
| `HadwigerNelson.StandingFive.KloostermanBound` (a named former, `Arith/FloorPlanes`) | an outside theorem — **and now also provable from the declared import at characteristic not 2** (`kloostermanBound_of_ringChar_ne_two`), so for T5's step: the axiom `StandingFive.kloosterman_bound` is the import (`ref=bib:Weil1948`), and this former is a hypothesis form concluded by a theorem only over that axiom | `[Weil1948]` p. 207 | nine: `circle_sum_le`, `circle_sum_le_of_ne`, `kloosterman_page_of_kloostermanBound` (at one field `F`); `normOne_charSum_ge`, `targetFloor_seven_of_kloosterman`, `targetFloor_six_of_kloosterman` (at every field of `Q` elements); `standingFloor_seven`, `standingFloor_five`, `seven_le_localBound_of_kloosterman` (at every field of `q ≡ 3 (mod 4)`, `q ≥ 347` elements) |
| the axiom `HadwigerNelson.StandingFive.kloosterman_bound` | an outside theorem, as an `axiom` | `[Weil1948]` p. 207 | eight (the IMPORTED records): `kloostermanBound_of_ringChar_ne_two`, `targetFloor_seven_weil`, `targetFloor_six_weil`, `circle_sum_le_weil`, `standingFloor_seven_weil`, `standingFloor_five_weil`, `seven_le_localBound_weil`, `five_le_chromaticNumber_weil` |
| `HadwigerNelson.SpectralChain.BochnerHerglotz` (named, landed earlier) | an outside theorem (Herglotz–Bochner for a countable discrete group) | as FS131-T5 declares it on `fs131-t5` (inventory item 562: one of its five outside hypotheses on `main`; its bibliography row filed, not read) — not re-read by me | of this landing: `sp_if_hypotheses_trivial_bot` (at `unitRing ⊥`). On `main` already: `sp_if`, `contChars_haar_null` and their kin |
| `five_le_chromaticNumber_weil`, binder `hRow123 : min (localBound standingField) 5 ≤ χ(F²)` — **written out in a binder, a closed proposition** (no variable of the theorem occurs in it) | a hand result of ours ([hand], given MR — measure rigidity, an outside theorem, is inside it and is not imported) | `LEDGER.md` row 123: the conclusion of `SpectralChain.min_localBound_five_le_chromaticNumber` at the standing field (the theorem's docstring) | `five_le_chromaticNumber_weil` (and, landed earlier, `five_le_chromaticNumber`) |
| `HadwigerNelson.StandingFive.StandingFloor` (named, landed earlier) | a hand result of ours, **discharged by this landing over the import**: `standingFloor_seven_weil : StandingFloor 7`, `standingFloor_five_weil` | TC1-STANDING-FIVE | none of this landing takes it; the landed `seven_le_localBound`, `five_le_chromaticNumber`, `standingFloor_mono` do. For T5's step: a former concluded by a theorem with no hypothesis — but over an axiom — is its `discharged` case to rule on |
| `HadwigerNelson.SpectralInputs.BochnerOn` (named, landed earlier) | an outside theorem (Bochner's theorem, for the topology `t`) | as FS131-T5 declares it on `fs131-t5` (inventory item 562) — not re-read by me | none of this landing; the landed `spectral_carried_iff`, whose docstring this landing edits |

**A hand result written out over a theorem's own variables: this landing has none.** Every other `Prop` binder of its 160
theorems is a condition of the statement (a measurability, an independence, a bound on a character sum that the consumers in the
same modules discharge — `targetFloor_of_charSum`'s `hchar` is discharged by `charSum_128_ge` and `normOne_charSum_ge`), read by
me in the table of signatures; the one inline assumption, `hRow123`, is closed and so of the shape the step finds by itself.

**7. The open gate items at this landing** (a theorem whose hypotheses no Lean object on `main` satisfies at once, or that still
assumes a named hypothesis).
- **`sp_if`** — open by one classical theorem: given `BochnerHerglotz (unitRing ⊥)` every other hypothesis holds at once
  (`sp_if_hypotheses_trivial_bot`, landed here, with `negCircle_trivial_bot`); `BochnerHerglotz` is assumed.
- **`contChars_haar_null`**, **`spectral_carried_iff`**, **`si4`** — no model of all hypotheses at once is a declaration; each
  docstring now carries the planner's described model and says it is not a Lean declaration (the planner prices the two cheap
  ones at about 55 lines; `contChars_haar_null`'s needs `BochnerHerglotz`). `si4_equivariant` is met by landed theorems.
- **`usable_card_ge`, `no_small_usable`** (landed earlier) — still bound a family the kernel does not know non-empty: the usable
  place of the standing field is the third pass's leaf `exists_usable_place`, on `fs131-w10k`, not in this landing.
- **The eight on the import** assume `[Weil1948]` p. 207 and nothing else outside the standard three; `five_le_chromaticNumber_weil`
  also row 123's chain.
- **Not a gate item, a reading**: "every usable plane `Γ_Q` refuses six" is not a kernel sentence. The kernel's floors
  (`TargetFloor`, `StandingFloor`, `localBound`) are about the norm-one Cayley graph of `𝔽_{Q²}`; no declaration relates
  `normOneCayley` to `finitePlane` (the planner's § 15.1). `FloorPlanes`' module docstring still reads G56's sentence that way
  in its first paragraph.

**8. Generalizations the wave's reports found — for the errata.**
- FS131-I10F / ruling 542: `ae_eq_measurable_of_majority` at `[Countable K]` with no measurability of `G` or the `c x` — **landed
  here as the row's statement**.
- FS131-L10B (the lint; ruled mid-job): `fibre_mem_factorSets` does not read `[MeasurableSingletonClass Ω₁]` — **landed**.
- FS131-I10D: `circle_sum_le_of_ne` (the bound needs `a ≠ 0` **or** `b` anisotropic; `circle_sum_le` its special case) — landed
  as a theorem beside the row; and, available, the floor at six from `Q ≥ 62` — since stated by the planner and landed
  (`targetFloor_six_of_kloosterman`, `targetFloor_six_weil`).
- FS131-I10E: the bridge at `Q = 64` (`TargetFloor 6 64`) with the constants made parameters — not stated (a stub at the filing,
  ruling 555 (d)).
- FS131-IF1: Falconer's Lemma 2 (i) in every finite dimension, any norm, any additive Haar measure, null-measurable sets
  (`exists_not_tendsto_ratio_and_compl`), and the quantitative form `exists_ratio_ge_and_compl_ge` — landed.
- FS131-K10c (§ 14.4; on `fs131-w10k`, not in this landing): the level row with no symmetry and no `ν(K) = 0`; J45-N1 (a), (b)'s
  readers need two facts of a filter.

**9. `LEDGER.md`, `plans/LEAN-BACKLOG.md`, `plans/FS131-kernel-plan.md` § 7.4, the Frontier, the atlas** — the planner's § 16.7
and FS131-IF1's Drafts items 3–4 and 8, corrected for the join:
- **`LEDGER.md` row 53 and G56's row** (the planner's draft; ruling 555's correction owed): "the floor at seven for `Q ≡ 3
  (mod 4)`, `Q ≥ 98` (`StandingFive.targetFloor_seven_weil`), at six from `Q ≥ 62` (`targetFloor_six_weil`), and `χ(U₁₂₈) ≥ 8`
  (`Floor128.targetFloor_eight_128`) are [kernel] — the first two over one import (`StandingFive.kloosterman_bound`,
  `[Weil1948]` p. 207), the third on the standard three with no import — **as statements about the norm-one Cayley graph of
  `𝔽_{Q²}`** (`normOneCayley k σ`, every field `k` of `Q²` elements with a non-trivial involution `σ`); 'the plane `Γ_Q`' waits
  for the link `normOneCayley ≃g unitQuadrance`, not stated". **§ B row FS91-J10-T9** ("`U₁₂₈`'s Hoffman floor is 8"):
  [kernel], `Floor128.targetFloor_eight_128`, `[propext, Classical.choice, Quot.sound]`, no assumption; the exact spectrum
  `−19, …, 21` stays [tools].
- **TC1-STANDING-FIVE**: "so `L(F) ≥ 7`" — [kernel over one import], `StandingFive.seven_le_localBound_weil : 7 ≤ localBound
  standingField`, resting on `StandingFive.kloosterman_bound` and nothing else outside the standard three; "and given MR,
  `χ(F²) ≥ 5`" — `five_le_chromaticNumber_weil`, over the same import **and** the hypothesis `hRow123` (row 123's chain).
- **FS-20's item R4** (`plans/STUB-theorem-B-writeup.md` § 5; FS131-I10D's draft): "a circle sum is a Kloosterman sum" is
  `StandingFive.circle_sum_eq_kloosterman` [kernel], standard three, every finite field of odd characteristic, every radius.
- **`LEDGER.md` row 152**, its FALC-RED clause (FS131-IF1's Drafts item 4): [kernel], `Plane.falconer_reduction`,
  `Plane.le_chiM_of_falconerFan`, `[propext, Classical.choice, Quot.sound]`, resting on no import and no named hypothesis.
- **`plans/LEAN-BACKLOG.md`**: FS131-E8-SI5C — landed, at the wider class (ruling 542); J45-SI-J — `contVec_prod_eq` landed,
  with its model; J45-SP-if — its model landed, open by `BochnerHerglotz`; TC1-STANDING-FIVE — as above; the level row, J45-N1
  (a)(b)'s interface and the usable place — on `fs131-w10k`, not landed; J45-SI-5, -SI-C — not stated.
- **`plans/FS131-kernel-plan.md` § 7.4**: `KloostermanBound` leaves the table of named hypotheses from outside (it is the import,
  in `ARCHITECTURE.md` § Trust); `StandingFloor` is discharged over the import.
- **`CLAUDE.md` § Frontier, "What the kernel holds"** — one clause: "**wave 10's floors** — `7 ≤ L(F)` at the standing field and
  the floors at seven (`Q ≥ 98`) and six (`Q ≥ 62`) of the norm-one targets at `Q ≡ 3 (mod 4)`, over one declared import, Weil's
  bound for Kloosterman sums; `χ(U₁₂₈) ≥ 8` with no import; `[Falconer1981]` Lemma 2 (i) proved, so Falconer's reduction reads the
  standard three". No value of `χ` of the plane moves.
- **The Proof Atlas**: `falconer_lemma2_nonempty` changes kind (axiom → theorem) and its four consumers lose their dependence on
  an import; one new axiom node, `kloosterman_bound`, with eight theorems on it; twelve new modules, 160 hand-written theorems.
- **`ARCHITECTURE.md`**: edited on this branch — the five rows of Stage 3, § 5's table (Stage 2).

## Theorems this phase proved, final

**This job proved no theorem of its own**: it joined three lines, made the ruled tidies and gated the result. What it landed,
each [kernel] on the gated commit `f0cc3018`, axioms read from the gate's saved log (`data/fs131/l10b/receipt-axioms-final.log`;
the reading `records-final.txt`); all 160 with their axioms are in that log, the heads here.

- **On the standard three and one import, `StandingFive.kloosterman_bound` (`[Weil1948]` p. 207), and nothing else** (the eight
  IMPORTED records; `Proofs/HadwigerNelson/Arith/WeilKloosterman.lean`): `kloostermanBound_of_ringChar_ne_two`,
  `standingFloor_seven_weil : StandingFloor 7`, `standingFloor_five_weil`, `seven_le_localBound_weil : 7 ≤ localBound
  standingField` (TC1-STANDING-FIVE), `five_le_chromaticNumber_weil` (also over `hRow123`), `targetFloor_seven_weil` (`Q ≥ 98`),
  `targetFloor_six_weil` (`Q ≥ 62`), `circle_sum_le_weil`.
- **On `[propext, Classical.choice, Quot.sound]`, no import** (each "exactly the standard three" in the records check):
  - `Floor128.targetFloor_eight_128 : TargetFloor 8 128`, `targetFloor_seven_128`, `charSum_128_ge`, `exists_root`,
    `exists_root_pow_eq`, `class_le`, `normOne_eq_image`, `exists_addChar` (`Arith/Floor128.lean`);
  - `StandingFive.involution_eq_pow`, `card_normOne`, `targetFloor_of_charSum` (`Arith/NormOneTarget.lean`);
    `sum_quadratic_eq`, `circle_sum_eq_kloosterman` (FS-20's item R4), `circle_sum_le`, `circle_sum_le_of_ne`,
    `circle_sum_zero_of_isotropic`, `two_sqrt_lt_circle_sum_zero`, `normOne_charSum_ge`, `targetFloor_seven_of_kloosterman`,
    `kloostermanBound_of_card_le_five` (`Arith/FloorPlanes.lean`); `standingFloor_seven`, `standingFloor_five`,
    `seven_le_localBound_of_kloosterman` (`Arith/TargetFloors.lean`; hypothesis forms over `KloostermanBound`);
    `kloosterman_page_of_kloostermanBound`, `kloosterman_bound_model`, `four_mul_mul_ne_zero_iff`, `sum_units_eq_sum_ne_zero`,
    `ringChar_ne_two_of_card_mod_four`, `targetFloor_six_of_kloosterman` (`Arith/WeilKloosterman.lean`);
  - `RatioBound.card_mul_le_of_indep`, `le_chromaticNumber_of_charSum` (`Arith/RatioBound.lean`);
  - `MajorityVote.ae_eq_measurable_of_majority` (FS131-E8-SI5C, at the class of ruling 542; `Arith/MajorityVote.lean`);
  - `SpectralInputs.contVec_prod_eq` (J45-SI-J), `contVec_prod_eq_coin`, `fibre_mem_factorSets` (`Arith/ProductFactor.lean`);
    `exists_parityHom`, `negCircle_trivial_bot`, `sp_if_hypotheses_trivial_bot` (over `BochnerHerglotz`;
    `Arith/NegCircleModel.lean`); `comap_factorSigma_eq`, `comap_factorSigma_eq_of_action`, `si4_equivariant_factorSigma`
    (`Arith/FactorAction.lean`);
  - `Plane.exists_not_tendsto_ratio_and_compl`, `exists_ratio_ge_and_compl_ge` (`Plane/MetricalBoundary.lean`);
    `Plane.falconer_lemma2_nonempty` (the axiom, now a theorem), and, moved from IMPORTED to CLEAN, `falconer_reduction`,
    `le_chiM_of_falconerFan`, `exists_mem_falconerE`, `fan_tip_ae_mem` (`Plane/FalconerReduction.lean`).
- On a proper subset of the three: 17 records of `Floor128` and `GapSeven` (the `decide +kernel` certificates: 9 on `[propext,
  Quot.sound]`, 8 on `[propext]`).
- **The axiom**: `StandingFive.kloosterman_bound` — not a theorem; the library's one outside assumption declared as an axiom.

## Slips, my own

1. My first message to the coordinator named the tidies' commit by a placeholder that is no hash; the commit is `3c4172e2`.
2. Four of this job's new checks were wrong on their first run and repaired before any result was taken from them: the
   joined-state check read a `declareImport` line quoted in a docstring as a declaration; the kernel-signature reader's
   self-test named a partner with no section variable; the row check read three letters of a formula of mine as declaration
   names (I reworded the row); the shape check's plant could not be planted after its lists were extended. Each is said where
   its result is recorded.
3. `rsync-w6j-build.txt` prints its filter's exit status under the label of `rsync`'s; the copy was moot (Lake rebuilt all
   fourteen modules).
4. Stage 2's commit took two logs that were still being written (`dupnames-joined.log`, the red-before self-test's); both were
   committed complete with Stage 3. `dupnames-joined.log`'s head names the commit before a `plans/`-only commit made while it
   waited for a slot; the Lean sources are the same.
5. The statement checker's self-test was first run on a file where one plant cannot be planted, and failed for that reason; it
   passes on `WeilKloosterman.lean` with all five.
6. My token counts are estimates: this session has no instrument for the harness's count.
7. Not run, and not claimed: `lean4checker` (a publication gate); the Proof Atlas rebuild (the coordinator's); FS131-T5's step.
