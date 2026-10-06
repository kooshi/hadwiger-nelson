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
