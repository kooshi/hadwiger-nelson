# FS131-LJ1 — the landing of the three-and-four-colours line: six files through the gate

*Job record of FS131-LJ1 (brief: `data/fs131/briefs/FS131-LJ1-landing.md`; de Bruijn, the implementer, as the lander of
one finished line of six files; branch `fs131-wj1`, worktree `.claude/worktrees/fs131-wrc`; the laptop: 12 cores,
31 GB). The line is FS131-KN4's statements (passes FS131-KN5) with the leaves proved by FS131-IC1
(`Proofs/HadwigerNelson/Arith/ThreeColourCharacter.lean`), FS131-IT1 (`Arith/TorsionExtraction.lean`), FS131-IN1
(`Arith/ThreeColourCriterion.lean`), FS131-ID1 (`Arith/DyadicQuadratic.lean`) and joined, extended and proved by
FS131-KJ1 (`Arith/ThreeFourColours.lean`, `Instances/UpperHalfCorollaries.lean`; record
`plans/FS131-KJ1-joining-module.md`). This job proves nothing and changes no statement: it takes the line through the
gate. Working files: `data/fs131/lj1/` (this job's scripts are there, not under `tools/`: the brief's list of what the
job touches names that directory and not `tools/`). Times are UTC.*

## Theorems this phase proved

*The gate is green on one commit, `def7c07f8` (stage 8). This job proved no theorem of the library: it landed the line's
six files — 94 theorems and 2 definitions, each [kernel]. 84 records are on the standard three axioms or fewer, and 12
are on those and the declared outside theorem `StandingFive.kloosterman_bound` (Weil's bound). The list, one line per
declaration with its banner and its axioms as the audit printed them, is § "Theorems this phase proved, final". In
short: the table for real quadratic fields (`ThreeFourColours.chromaticNumber_planeOver_sqrt_table`) and clause (c)
(`TorsionExtraction.four_le_chromaticNumber_planeOver_of_inv_three_mem`) are on the standard three; clause (b)
(`ThreeFourColours.chromaticNumber_planeOver_eq_three_iff`) and row 99's three sentences are on Weil's bound. The
values 2 and 3 and every upper bound are prior art.*

## Stage 1 — SAVED (FS131-LJ1): the readback, what was read, `main` merged, the six modules dumped before any edit

### The brief's quotations

`data/fs131/lj1/readback_check.py` (FS131-LU1's script pointed at this brief; every block quote must occur character
for character in the file its source line names), read as `git show main:…` at `16b181f48` because the brief itself
reached this tree only with the merge: **5 of 5 MATCH** (`readback.out`) — Kooshi's word W2 against
`data/fs131/REQUEST-2026-10-13.md`; NF4-THEOREM, NF4-NC and the dated line of the joining job against
`data/fs131/claims-NF4.md`; inventory item 720 against `plans/FS131-close-inventory.md`. With `--fault` (one character
of each altered): **5 of 5 MISMATCH** (`readback-fault.out`), so the check can fire. No finding about the brief's
quotations. **One fact of the brief that had moved**: it names `main` at `0b56f33ee`; `main` stood at `16b181f48`, one
commit later, and that commit adds the brief and nothing else (`git diff --stat 0b56f33ee 16b181f48`: one file).

### What was read

The brief and `plans/STANDING-RULES.md` in full; `LEAN.md` in full as it stands on `main`; `RUNNING.md` § Building and
§ Make the gate fail, and watch it fail; the joining job's record in full; the last landing's record
(`plans/FS131-LU1-landing.md`): its head, stages 1 to 5, 7 and 8 and the first five drafts in full, **its stage 6, the
rest of its drafts, its open gate items and its slips by their headings only**; that landing's scripts under
`data/fs131/lu1/` (the runner, the two wrappers, the dump, the lister, the text check, the readback), each of which this
job's is a copy or an adaptation of and says so in its first lines. **Of the six modules**: the joining module's head
and its lines 536–800 and 858–925 (clause (b), row 99, the table, the two dyadic statements, the spec section) line by
line; `Arith/ThreeColourCriterion`'s module docstring; the head (statement up to `:=`) of every public declaration of
all six (`data/fs131/kj1/heads.py`); the docstrings of the dictionary statements J1–J4. **Not read: the proofs** — the
kernel read them — and the docstrings of the four proved modules beyond the heads (the joining job read each credit in
them against the paper, its stage 4).

### `main` merged

Trial first (`git merge-tree --write-tree HEAD main`, `data/fs131/lj1/merge-trial.out`): exit 0, **no conflict
named**. Since this branch's last merge of `main` (`39fee2edb`), `main` changed four files outside `data/` and
`plans/` — `CLAUDE.md`, `LEAN.md`, `LEDGER.md` and `tools/claude_md_fact_audit.py`, the last landing's filing — and
nothing under `Proofs/` or `scripts/`. Merged by hash, automatic: `fb76f2890` (`merge-main.out`). Both sides kept,
checked: against `main` the branch differs under `Proofs/`, `Proofs.lean`, `scripts/`, `tools/`, `ARCHITECTURE.md`, the
lakefile, the toolchain, the manifest, `CLAUDE.md`, `LEAN.md` and `LEDGER.md` by **the six modules (3,734 lines), six
import lines and six rows of the map, and nothing else**.

### The build — current as given, and still current after the merge; nothing copied

`lake build --no-build Proofs` under the slot's cap, on the tree as given (`dec3b73ce`;
`probes/uptodate-given.log`): exit 0, "All targets up-to-date (6005 jobs)", 3.7 s. Again after the merge: the same
line — the merge brought no Lean source. **No compiled file was copied from another tree by this job** (the joining
job's copy from `fs131-wnf` is in its record, stage 2). The first build of this job is stage 2's, for the docstrings.

### Before any edit and before the merge: the six modules as the kernel held them

On the tree as given (`dec3b73ce`; `statements/before.commit`): `data/fs131/lj1/StatementDump.lean` (FS131-LU1's with
the module list changed) prints every constant of the six modules' compiled data — 22 + 52 + 44 + 131 + 73 + 4 = **326
constants** — kept compact as `data/fs131/lj1/statements/before.compact` (`tools/fs124_l2_statements.py compact`; the
raw print, 8.4 MB, SHA-256 `211a30c8…1fd9f0dd` with the slot's line and the exit line, is not kept:
`probes/statements-before.note`). **96 of the 326 are not internal** — the joining job's count of public records.
`data/fs131/lj1/decls.lean` on the merged tree (`probes/decls-given.log`): 96 constants that are not internal — 11, 20,
17, 13, 31 and 4 by module — **every one a declaration a person typed: 94 theorems and 2 definitions**
(`ThreeColourCriterion.conjR`, `TorsionExtraction.inv5`); none is the elaborator's. The private helpers have internal
names and are in neither count (the joining job's `data/fs131/kj1/logs/axioms-final.txt` has theirs: 232 rows over
nine files).

### The tree as merged and built, before any registration

*Every step under the slot with this machine's budget (`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6`), through
`data/fs131/lj1/m.sh` and `in-scope.sh` (FS131-LC1's wrappers through FS131-LU1: each step's exit status, wall time,
the scope's charged `memory.peak` and the largest single process's resident set, appended to
`data/fs131/lj1/probes/measure.txt`), from a snapshot copy of `data/fs131/lj1/probe-given.sh`, on the merge commit
`fb76f2890` with `scripts/` as on `main`.*

| step | result | wall | peak (charged) | max-rss |
|---|---|---|---|---|
| is the build current? `lake build --no-build Proofs` | exit 0, "All targets up-to-date (6005 jobs)" | 3.7 s | 0.21 GiB | 0.87 GiB |
| the six modules' constants as stored (`StatementDump.lean`) | 326 constants, 96 not internal | 5.2 s | 0.57 GiB | 4.39 GiB |
| the six modules' declarations (`decls.lean`) | 96 not internal; 94 theorems, 2 definitions, all typed | 64.8 s | 0.55 GiB | 4.38 GiB |
| `./scripts/dupnames.sh` | "dupnames: OK — no name is declared by two modules (24 generated on demand, listed above)" — **the join made no doubled name** | 5.0 s | 0.53 GiB | 4.36 GiB |
| `./scripts/assumptions.sh --self-test` | "OK — all 33 checks behaved: every planted fault fired, and every partner stayed silent" | 128 s | 0.68 GiB | 4.58 GiB |
| `./scripts/assumptions.sh`, `./scripts/vacuity.sh` | stages 4 and 5 | | | |

## Stage 2 — SAVED (FS131-LJ1): the docstring corrections and the first build

### What the joining job's record left for the landing, and what was edited

The joining job's record leaves the landing no docstring of the six files (its stage 3 made the implementers' drafted
docstrings itself, in modules it recompiled), and four rows of `ARCHITECTURE.md` (its D4). Reading the six files'
heads and the joining module's headline section, **five places in two files** say less than the built modules hold or
name a branch; each is a docstring or a module docstring, in a file this landing compiles anyway:
- `Arith/ThreeColourCriterion`, module docstring: "reads `UpperHalf.exists_stablePrime_of_valuationSubring`, which lives
  on another line (`fs131-wnf`)" — now "the residue module's (`Arith/UpperHalf`, which this module does not import)", and
  the clause's address `chromaticNumber_planeOver_eq_three_iff` added; and § Inhabitants, "`exists_maximal_card_nine_of_colorable_three`
  at `F = ℚ(√3)` …, which no declaration on this line exhibits" — the joined tree exhibits it downstream
  (`ThreeFourColours.exists_maximal_card_nine_sqrt_three`), and the two-colour end's model is
  `ThreeFourColours.exists_maximal_conj_trivial_sqrt_two`; both named.
- `Arith/ThreeFourColours`, module docstring's read-aloud: it named clause (b), the table by rows and row 99 — now also
  the table as one statement, that the lower bound at four needs no squarefreeness, **clause (c) and where it is**
  (`TorsionExtraction.four_le_chromaticNumber_planeOver_of_inv_three_mem`, with the two translations: "an integer
  combination of unit vectors" is `(3 : ℂ)⁻¹ ∈ unitRing F`, "has an odd cycle" is `¬ Colorable 2`), and row 99's two
  sentences; and a paragraph **"Rests on"**: the seven public statements of the module on Weil's bound, by name, and
  that the table, the dictionary J1–J4, the two level-target colourings, the dyadic primes and clause (b) from the prime
  to the colouring are on the standard three. (The seven are the audit's: stage 3.)
- `localBound_le_chromaticNumber_or_four_le` did not say it rests on Weil's bound — now it does, and which case reads it;
  `localBound_le_chromaticNumber_of_le_four` said only "`hRow99` … discharged" — now it states the binder in words, that
  its type is the binder's term for term (stage 4's terms check it), and that it rests on Weil's bound, so a statement
  feeding the binder with it is an imported record.
- `exists_maximal_card_nine_sqrt_three`: a note that `exists_stablePrime_card_nine` applied to it is a stable prime of
  `ℚ(√3)(i)` with nine elements — the hypothesis of `levelTarget_colorable_three_of_card_nine` and
  `exists_maximal_card_three_of_stablePrime_card_nine` — "a composition, stated by no declaration" (the joining job's
  D3; the composition is a kernel-checked term of this job's, `FS131LJ1.stablePrime_nine_sqrt_three`, stage 5).

**`ARCHITECTURE.md`**, the joining job's D4 as drafted, each checked against the built modules: the four rows that still
called their modules skeletons now say whose the proofs are, "no `sorry`" and "landed by FS131-LJ1", with the statements
the joining job added (`fieldBandSet_three_nonempty_of_colorable_unitRing`, `bandSet_three_nonempty_zmod_five`;
`colorable_two_of_fieldBandSet_three_nonempty`, `fieldBandSet_three_eq_empty_of_sqrt_mem`;
`colorable_two_planeOver_sqrt_of_mod_four`, `mod_four_of_squarefree`) and `DyadicQuadratic`'s "the lattice and its map by
class" replaced by its drafted words; § Trust, the import's row: its consumers now include the twelve, "twenty imported
records in all". `tools/check_architecture.py`: "RESULT: PASS" (`probes/arch-probe.out`).

**No statement changed, in text** (`data/fs131/lj1/code_only_diff.py`, FS131-LC1's through FS131-LU1: every block
comment removed, against the merge commit `fb76f2890`): the six files' code is 14,113, 28,763, 38,699, 28,609, 42,479 and
2,257 characters before and after — "SAME" six times (`code-only.out`); its plant, one code character altered, reads
"DIFFERS" six times (`code-only-plant.out`). The two edited files elaborate alone with the lakefile's options and no
message (`probes/syntax-criterion.log`, `syntax-threefour.log`, 13 s each). From the kernel's side the comparison is the
pass's: the dump made before the merge (`statements/before.compact`) against the dump after the last build.

### The build

`data/fs131/lj1/run-build.sh 1 10 4 8` — `./scripts/build.sh` under the slot, `--mem 10 --cpus 4`, `MEMMAX=10G
BATCH=8`, on the committed text `e81f7c5bf` (`data/fs131/lj1/build-1.log`; Lake's full output
`build/gate/build/20261014T025721Z-1270896.log`, 0 lines holding "warning"; 02:57:20–03:04:27):

> ==> build: OK — 249 of 249 batches, 3 module(s) rebuilt, 0 module(s) with warnings, 6m56s

Rebuilt: `Arith.ThreeColourCriterion`, `Arith.ThreeFourColours` (9.6 s) and the root — the two edited files and what
imports them; none of the four other modules of the line, nothing else. Largest compiler 3.9 GiB resident
(`Arith/ThreeFourColours`; `build-1.rss`). Had it died: the same command again; the redo is the batch in flight and the
walk.

## Stage 3 — SAVED (FS131-LJ1): the registrations

**What the landing brings, as the kernel lists it** (stage 1): 96 declarations a person typed, 94 theorems and 2
definitions, in six modules (11, 20, 17, 13, 31, 4). The private helpers are not nameable in the script; each is read by
a public record (the joining job's print has every one: 232 rows over nine files, none on `sorryAx`).

**Ninety-six records in `scripts/Axioms.lean`, as one block of this job's in two parts** — the lines are the joining
job's block (`data/fs131/kj1/audit-block.txt`, made from the compiled modules), filed by a script that refuses a name
already in the file:
- **under IMPORTED, twelve**, below the eight earlier records on `kloosterman_bound` (the import is declared already; no
  `declareImport` line is added): `ThreeColourCriterion.targetFloor_four_weil`, `exists_normOne_zero_of_card_ne_nine`,
  `exists_maximal_card_nine`, `exists_maximal_of_torsion`, `exists_maximal_card_nine_of_colorable_three`;
  `ThreeFourColours.colorable_three_planeOver_iff`, `chromaticNumber_planeOver_eq_three_iff`,
  `localBound_le_chromaticNumber_or_four_le`, `localBound_le_chromaticNumber_of_le_four`,
  `chromaticNumber_planeOver_eq_localBound_of_le_four`, `chromaticNumber_planeOver_le_three_iff`,
  `exists_maximal_card_nine_sqrt_three`;
- **under CLEAN, eighty-four**, just above the PURCHASED banner, headed "FS131-LJ1" with one sub-banner per file.

`lj1_records.py … --unfiled` (before the audit): "declarations the landing brings: 96 (of 96 constants in 6 modules);
with one line: 96; unfiled: 0; doubled: 0; `#print axioms` lines in the script: 7602, names twice: 0".

**The audit on the registered tree** (`./scripts/axioms.sh`; `probes/axioms-probe.log`, 7.6 s): exit 0 —

> audited: 7602 records — 7531 clean on the standard axioms, 28 axiom-free, 38 imported (resting on a declared outside theorem), 5 declared purchase(s)

Against `main` (7,506 records, 7447 clean, 28 axiom-free, 26 imported, 5 purchases): **records +96, clean +84, imported
+12; axiom-free and purchases do not move — the brief's arithmetic, each count.** The digest reads `CLAUDE.md` § Trust
ledger stale, "7447 clean → 7531, 26 imported → 38", as it must until refiled.

**Each filed on what it rests on, read from the audit's own output** (`data/fs131/lj1/lj1_records.py`, after
FS131-LU1's `lu1_records.py`; it loads FS131-LC1's `records.py` by path for the twenty-six earlier imported records and
the log reader; `probes/records-probe.txt`): "records: PASS" — landing records "on exactly the three: 83", "on fewer:
[Quot.sound, propext]: 1", "on the three and Weil's bound: 12"; headlines "under CLEAN on the standard three: 39 of 39",
"under IMPORTED on the three and Weil's bound: 12 of 12"; over the whole log "records carrying kloosterman_bound: 20
(filed: 20); of the landing's: 12", the two OAI158 imports 6 and 12 with none of the landing's, "records under IMPORTED
38; carrying two imports 0; carrying sorryAx 0". **Sixteen plants, in memory, one at a time, every one fired**
(`probes/records-plant-probe.txt`): a record dropped; doubled; `sorryAx` under one; a clean record on Weil's bound; one
filed under IMPORTED on the transfer; one under PURCHASED; a native auxiliary; **the table resting on Weil's bound**;
**clause (c) under IMPORTED**; **clause (b) read as needing no import**; **the theorem that discharges `hRow99` with its
import stripped**; an imported record carrying a second import; a theorem with no record; an earlier imported record
stripped of its import; a module absent from the dump; a declaration absent from the kernel's list.

**The audit's self-test, and its two controls that read the library's state.** Run with the block filed and the controls
as on `main` (`probes/axioms-selftest-red.log`): **exit 1, "FAIL — 2 of 23 control(s) did not behave as designed"** —
`baseline`: "expected COUNTS imported=26 digest 'old' … the audit has 26 imported"; `imported_declared`: "expected
COUNTS imported=27 … 27 imported". Red for the reason the file names: "a later record resting on a declared import moves
them again — … `imported` by its records, the `old` digests' texts follow". Moved by that rule and no other way
(`scripts/axioms-controls.txt`): `imported=26 → 38`, `27 → 39`, the two `old` digest texts with them, and the header's
description of the state ("with twenty IMPORTED records — eight at that join and twelve of the three-colour criterion
…"; "thirty-eight IMPORTED records"). `banner_dropped` names one record per import and does not move. Again
(`probes/axioms-selftest-probe.log`, 200 s): **exit 0, "axioms self-test: OK — every planted fault fired, and every
partner passed"** (23 of 23).

**The doubled-name check on the merged tree** (stage 1): "dupnames: OK — no name is declared by two modules (24
generated on demand)". **`tools/check_architecture.py`**: PASS (stage 2).

| step, this machine | wall | peak (charged) | max-rss |
|---|---|---|---|
| `./scripts/axioms.sh` (7,602 records) | 7.6 s | 0.98 GiB | 4.75 GiB |
| `./scripts/axioms.sh --self-test` (23 controls) | 188–200 s | 1.19–1.24 GiB | 4.96–4.98 GiB |

## Stage 4 — SAVED (FS131-LJ1): what the library assumes — `hRow99` retired on the landing's reading

`./scripts/assumptions.sh --self-test` first (stage 1, `probes/assumptions-selftest-first.log`): exit 0, "OK — all 33
checks behaved".

### What the step said before any edit of it — and what it did not say

On the merged, built tree with `scripts/` as on `main` (`probes/assumptions-given.log`; full output
`probes/receipt-assumptions-given.log`; the tree's compiled modules the pre-docstring ones, which hold the same
statements): **exit 1, thirteen failures, one kind** — `FAIL unlisted-consumer <theorem> :: the scan finds 'RESTS
HadwigerNelson.StandingFive.kloosterman_bound <theorem>' and the ledger does not list it`, for the twelve imported
records and one private helper, `ThreeColourCriterion.exists_maximal_card_nine_of_quotient`. **No failure names
`inline:Row99`**: its receipt still reads `ASSUMPTION inline:Row99 form=inline kind=ours ref=row:99 consumers=4` and the
four `SITE` rows. The step reports a discharged hypothesis only when the hypothesis is a named one (`LEAN.md` § The
gate; FS131-LU1's stage 4), and `hRow99` is written out in a binder — as the brief says it would.

### The reading, and the edit

The four theorems that take `hRow99` — `SpectralChain.min_localBound_five_le_chromaticNumber`,
`min_localBound_five_le_chromaticNumber_of_totallyReal`, `chromaticNumber_eq_localBound` and
`UpperHalf.chromaticNumber_eq_localBound_of_chain` — each have the binder
`hRow99 : localBound F ≤ 4 → localBound F ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber`
(`SpectralChain.lean:598, :619, :629`; `Arith/UpperHalf.lean:305`). The line proves exactly that:
`ThreeFourColours.localBound_le_chromaticNumber_of_le_four (F) [NumberField F] (h : localBound F ≤ 4) : localBound F ≤ …`.
**Kernel-checked, not read by eye**: `data/fs131/lj1/checks.lean` states `row99_binder` with the binder's text as its
type and the theorem as its proof, and applies each of the four takers to it (`site_min`, `site_min_totallyReal`,
`site_eq`, `site_chain`) — these elaborate only if the binder's type is the theorem's (`probes/checks-probe.log`: no
error, no warning). **Their axioms**: each of the five prints `[propext, Classical.choice, Quot.sound,
HadwigerNelson.StandingFive.kloosterman_bound]`; the four takers themselves, binder still in each statement, print the
standard three.

**What the entry becomes: a hand result of ours discharged, by a theorem that rests on a declared outside theorem.**
Row 99's lower half through four was `[hand]`; it is now `ThreeFourColours.localBound_le_chromaticNumber_of_le_four`,
an IMPORTED record on Weil's bound (`[Weil1948]` p. 207). So it leaves the list of what the library assumes in
hypothesis form, and what it costs moves to the channel the kernel sees: the `RESTS` row of `kloosterman_bound` for that
theorem, and the axiom list of any statement that feeds the binder with it (as `site_chain` shows, the chain's headline
restated without the binder would be an imported record). This is FS131-LT5's ruling for `StandingFive.StandingFloor`,
proved over the import and left out of the list, applied to a binder.

In `scripts/Assumptions.lean`, `AssumptionAudit.declared`: **out**, the four `.site … `hRow99 "Row99" .ours "row 99 (χ(F²)
= L(F) at L(F) ≤ 4)"` lines — the label's only sites, so the inline hypothesis `Row99` leaves with them; a six-line `--`
comment stands where they were and says why. **Nothing in**: the six modules take no hypothesis that is an assumption
(below).

**With the list edited and the ledger not yet written** (`probes/assumptions-edited.log`): exit 1, **seventeen failures,
the ledger comparison red in both directions** — the thirteen `unlisted-consumer` and four `stale-consumer` ("the ledger
lists 'TAKES inline:Row99 …' and the scan does not find it", one per taker).

**The ledger, written with the script's own flag** (`./scripts/assumptions.sh --write-ledger`;
`probes/assumptions-write-ledger.log`: "ledger written (142 rows) — read the rows above; a row is a theorem that is
conditional"). `git diff scripts/assumptions-ledger.txt`: **thirteen rows gained, four lost**, and the header's count line:

```
-#   axioms=3 rests=26 named=19 inline=15 outside=7 ours=22 open=5 takes=106 mentions=1
+#   axioms=3 rests=39 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1
+RESTS HadwigerNelson.StandingFive.kloosterman_bound HadwigerNelson.ThreeColourCriterion.exists_maximal_card_nine   (… twelve more RESTS rows: the eleven other
     imported records and _private.….ThreeColourCriterion.exists_maximal_card_nine_of_quotient)
-TAKES inline:Row99 HadwigerNelson.SpectralChain.chromaticNumber_eq_localBound   (… and the three other takers)
```

Each row read: the thirteen gained say that thirteen theorems of the line rest on Weil's bound — twelve public, one
private helper; the four lost say that the chain's four theorems no longer list row 99 as an assumption: their binder is
a condition a library theorem discharges, over the import.

After it (`probes/assumptions-second.log`; full output `probes/receipt-assumptions-second.log`): **exit 0** —
"assumptions: OK — 3 outside theorem(s) as axioms, with 39 theorem(s) resting on them; 19 named and 14 inline hypotheses
(7 outside, 21 ours, 5 open), taken by 102 statement(s) and mentioned by 1"; the ledger's header "match (9 of 9
compared)"; `CLAUDE.md` § Trust ledger flagged stale, "rests 26 → 39, inline 15 → 14, ours 22 → 21, takes 106 → 102".

### The nine counts beside the front page's, each difference by name

| | the front page (`CLAUDE.md` § Trust ledger, on `main`) | the step, after the edits |
|---|---|---|
| the nine | axioms=3 rests=26 named=19 inline=15 outside=7 ours=22 open=5 takes=106 mentions=1 | **axioms=3 rests=39 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1** |

- **`rests` 26 → 39**: thirteen theorems whose stored axiom lists hold `kloosterman_bound` — the twelve imported records
  and the private `exists_maximal_card_nine_of_quotient`. (The audit counts records, which name public declarations
  only: its imported count is 38. Before this landing no private helper rested on an import, and the two counts were
  both 26.)
- **`inline` 15 → 14, `ours` 22 → 21**: the entry `inline:Row99` retired.
- **`takes` 106 → 102**: its four (hypothesis, statement) pairs. The statements that take a declared hypothesis stay
  **52** (counted from the ledger's `TAKES` rows before and after: each of the four takers takes others).
- `axioms`, `named`, `outside`, `open`, `mentions` do not move: no axiom, no named hypothesis, no outside theorem in
  hypothesis form, no open question enters or leaves.

In words: thirty-three hypotheses, nineteen named and fourteen written out in a binder — seven standing for outside
theorems, twenty-one for hand results of ours and five declared as open questions — taken in 102 (hypothesis,
statement) pairs by 52 statements; three outside theorems as axioms, with thirty-nine theorems resting on them.

| | the merged tree before the edit | after |
|---|---|---|
| `TOTALS` (the rest) | sites=31 … cohyp=60 … unseen=17824 fails=13 | sites=27 … cohyp=64 … unseen=17824 fails=0 |

**The hypotheses the step counts and cannot decide, read by hand.** `cohyp` 60 → 64: the four `hRow99` binders, now
undeclared — conditions a library theorem meets (the four `COHYP` rows added; nothing else moved). `sites` 31 → 27: the
four retired. No closed hypothesis and no `Prop`-former enters with the line. Every hypothesis of the six modules'
96 statements (their heads, read in full: stage 1) is a condition on its theorem's own variables — a radicand's class,
squarefreeness, a divisibility (`hm`, `h4`, `h12`, `h168`, `h24`, `h8`, `h7`, `h3`, `hd`), a subfield holding a square
root or `1/3` in its unit-vector ring (`hF`, `h3`), a plane two- or three-colourable or not (`h`, `h2`, `h3`, `hnb`), a
bound on `localBound F` (`h`), an ideal maximal, non-zero, of given cardinality or with trivial conjugation (`h𝔪`,
`hne`, `h9`, `htriv`, `hram`), a field or ring with an involution and a square root of `−1` (`hσσ`, `hσ`, `hι`, `hσι`,
`hcc`, `hmax`, `hcard`, `hl`), a winding or a colouring proper along a step set (`W`, `hc`), a character in a band set or
torsion (`hθ`, `hτ`, `h6`), bounds on reals (`ha`, `hb`, `h1`, `h2`). **None is a hand result of this project or an
outside theorem written out in a binder**, so none is declared.

**`ARCHITECTURE.md`** § Trust, "Assumed as hypotheses", brought to what the step prints: "102 pairs, 52 statements";
"Thirty-three entries … one retired at FS131-LU1 and one at FS131-LJ1"; "Hand results of ours — twenty-one: twelve
named, nine written out in a binder", the row `hRow99` gone and a sentence saying what it became; the sentence "taking
the nine that remain" of the chain's headline now "the nine that remained then — eight since FS131-LJ1".

| step, this machine | wall | peak (charged) | max-rss |
|---|---|---|---|
| `./scripts/assumptions.sh` | 109–119 s | 0.66–0.67 GiB | 4.57 GiB |
| `./scripts/assumptions.sh --self-test` (33 checks) | 128 s | 0.68 GiB | 4.58 GiB |

## Stage 5 — SAVED (FS131-LJ1): the vacuity step — the scan adds no site, so every model is named by hand

`./scripts/vacuity.sh` on the built tree (`data/fs131/lj1/probes/vacuity-probe.log`; full output
`probes/receipt-vacuity-probe.log`): **exit 0, "vacuity: OK"**. Its self-test (`probes/vacuity-selftest-probe.log`):
"OK — all 65 controls behaved: every one fired, and the silent ones stayed silent." (The same scan on the merged tree
before the docstring build, `probes/vacuity-given.log`, gave the same counts.)

| | `main` (FS131-LU1's gated scan) | this tree |
|---|---|---|
| declarations | 16029 | **16125** (+96: the six modules' constants that are not internal, 11 + 20 + 17 + 13 + 31 + 4) |
| refutations-skipped | 228 | 228 |
| sites | 1454 | 1454 |
| vacuous / stale / declared / witnessed / generic / unknown | 0 / 0 / 3 / 38 / 1411 / 2 | 0 / 0 / 3 / 38 / 1411 / 2 |

**How the scan classes every new site: there is none.** Row for row against the last landing's gated scan
(`tools/fs131_l5_vacdiff.py`, `probes/vacdiff-probe.txt`): "main rows 1535, landing rows 1535; lost 0 …; added 0"; the six
modules "declarations 0 -> 11 … 4 [new module]", "by module: declarations +96, refutations +0: equal to the scans
difference"; "vacdiff: PASS". No declaration of the line is skipped as a refutation (`¬ Colorable 2`, `≠ 3`, `∉` are not
`False` as stated); nothing reads `VACUOUS`, `STALE` or `UNKNOWN`; the baseline's two entries are as on `main`. **The scan
reads none of the line's binders**: its colourability hypotheses are propositions the scan does not track (`Colorable k`,
`¬ Colorable 2`), and the structures its theorems range over — a stable prime, a maximal ideal of `ℤ[U_F]`, a finite ring
with an involution, a character in a band set — are not its carriers. **Silence is not evidence**, so each model is named
below.

**The baseline header's count line refiled from this scan** (`scripts/gate_report.py header` on the scan's output, into
`scripts/vacuity-baseline.txt`; no entry touched): `declarations=16029` → `declarations=16125`.

**The model of each hypothesis of the headlines, by hand**, and whether the kernel holds it — "library" is a theorem or
an `example` of a module, checked in the build; "term" a theorem of `data/fs131/lj1/checks.lean`, kernel-checked when the
pass elaborates it, not a library theorem (`probes/checks-probe2.log`, no error, no warning; axioms per term below). The
joining job's four models in the joining module (its D3) are the first rows.

| statement | its hypotheses | the model | held |
|---|---|---|---|
| **clause (a)**, `chromaticNumber_planeOver_sqrt_table` and its rows | `Squarefree m`, and each conjunct's class of `m` | every class met: 2 colours at `√2`, 3 at `√7`, 4 at `√11` (the dyadic prime) and at `√23` (a prime above 7), `≥ 4` at `√47` and `√167` (the excluded classes 47, 167 mod 168) — the module's spec `example`s; the value 4 at 71, 95, 191 (row 73's radicands the record held by hand) and the three-chromatic `ℚ(√3)` | library (`example`s, `chromaticNumber_planeOver_sqrt_three`); 71/95/191 a term (`table_at_71_95_191`, standard three) |
| **clause (b)**, `chromaticNumber_planeOver_eq_three_iff` | a real number field; `hnb : ¬ Colorable 2` | **both sides of the iff occur under `hnb`**: at `ℚ(√3)` the plane is not bipartite, `χ = 3`, and a prime with residue field `𝔽₃` exists; at `ℚ(√11)` the plane is not bipartite and no prime with residue field `𝔽₃` exists (3 is inert) | the pieces library (`TorsionExtraction.not_colorable_two_of_sqrt_mem`, `chromaticNumber_planeOver_sqrt_three`, `…_eq_four_of_dyadic`); the two joint forms terms (`clause_b_true_side`, `clause_b_false_side`, on Weil's bound as the clause is) |
| `colorable_three_planeOver_iff` | a real number field | both disjuncts occur: two-colourable at `ℚ(√2)`, a prime of three elements at `ℚ(√3)`; neither at `ℚ(√11)` | as above |
| **clause (c)**, `four_le_chromaticNumber_planeOver_of_inv_three_mem`, `chromaticNumber_planeOver_ne_three_of_inv_three_mem` | `(3 : ℂ)⁻¹ ∈ unitRing F`; `¬ Colorable 2` | **`ℚ(√11)`, both at once** (`1/3 = 2 − v − v̄`, `v = (5 + i√11)/6`); `h3` is a real condition: it fails at `ℚ(√3)` | library: `four_le_chromaticNumber_planeOver_of_sqrt_mem` is that composition; the joint form and the failure terms (`clause_c_model`, `inv_three_notMem_sqrt_three`, standard three) |
| **row 99**, `localBound_le_chromaticNumber_of_le_four`, `chromaticNumber_planeOver_eq_localBound_of_le_four` | a real number field; `localBound F ≤ 4` | **no library theorem bounds a `localBound` above at a named field** (the joining job: "proved for no field in the library"). This job's terms: `L(ℚ) ≤ 2` and `= 2`; `L(ℚ(√3)) = 3`; **`L(ℚ(√11)) = 4`**, the hypothesis's boundary (the stable prime above 2 with four elements, `exists_stablePrime_card_four_sqrt`, has a target on four vertices) — each `= χ` there | terms (`localBound_rat_le_two` standard three; `localBound_rat_eq_two`, `localBound_sqrt_three`, `localBound_sqrt_eleven` on Weil's bound, through the row's theorem) |
| `chromaticNumber_planeOver_le_three_iff`, `localBound_le_chromaticNumber_or_four_le` | a real number field | no hypothesis to model; both sides of the iff occur (`ℚ(√3)`: `χ = L = 3`; `ℚ(√11)`: `χ = L = 4`) | terms, as above |
| `UpperHalf.chromaticNumber_planeOver_eq_two_of_localBound_le_two` | `localBound F ≤ 2` | `ℚ` | term (`localBound_rat_le_two`) |
| J1 `exists_stablePrime_of_maximal` | `𝔪` maximal, `𝔪 ≠ ⊥` | the ideals below (each holds 2 or 3) | through J3's and J4's proofs at the two library models; not stated |
| J2 `exists_unitSet_residue_eq` | a stable prime, `ℤ[U_F] ⊆ 𝓞_P`, a residue of norm one | `t = 1` at any stable prime with J1's `hle` | inside J3's and J4's proofs; not stated |
| J4 `exists_stablePrime_conj_trivial`; `exists_stablePrime_ramified_sqrt` | a maximal ideal with trivial conjugation | at `ℚ(√2)` | library (`exists_maximal_conj_trivial_sqrt_two`) |
| J3, `exists_stablePrime_card_nine` | a maximal ideal of `ℤ[U_F]` with nine elements in its quotient | at `ℚ(√3)` | library (`exists_maximal_card_nine_sqrt_three`, Weil) |
| `levelTarget_colorable_three_of_card_nine`, `exists_maximal_card_three_of_stablePrime_card_nine` | a stable prime with nine elements in its quotient | at `ℚ(√3)`: `exists_stablePrime_card_nine` applied to the row above | term (`stablePrime_nine_sqrt_three`, Weil); the docstring now names the composition (stage 2) |
| `levelTarget_colorable_two_of_ramified` | a stable prime with trivial conjugation | `(1 + i)` at `ℚ` | library (`UpperHalf.exists_stablePrime_rat`); used by `localBound_rat_le_two` |
| `exists_stablePrime_card_four_sqrt`, `DyadicQuadratic.colorable_four_planeOver_sqrt` | `m ≡ 3 (mod 8)` | `m = 3, 11` | library (the dyadic module's spec; the table's `example` at 11); `localBound_sqrt_eleven` |
| `ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable`; `TorsionExtraction.exists_torsion_mem_fieldBandSet`, `tendsto_layer` | a three-colourable plane; `Θ₃(R_F) ≠ ∅` | `ℚ(√3)` | library (`fieldBandSet_three_nonempty_sqrt_three`) |
| `bandSet_three_nonempty_of_proper`, `exists_character_of_properAlong` | a colouring proper along a step set | `ℤ` along `(1, 2)`; the 5-cycle on `ℤ/5` | library (`exists_character_one_two`, `bandSet_three_nonempty_zmod_five`) |
| `ThreeColourCriterion.exists_maximal_card_nine`, `exists_normOne_zero_of_card_ne_nine` | a finite ring of characteristic 3 with an involution, `ι² = −1`, a functional never 0 on norm-one elements; a field of `≠ 9` elements with such `ι` | `𝔽₉ = 𝔽₃[i]` and the field of `27²` elements, named in the module docstring | **not held** (the joining job's stage 3, and item 698's ruling: a sentence); the first's content is met inside `exists_maximal_card_nine_sqrt_three`'s proof |
| `UpperHalf.two_notMem_stablePrime_seven` | a stable prime of `K(√7)` | one exists by Chebotarev | **not held**: the kernel holds no stable prime of this field, and the docstring says so |
| `UpperHalf.chromaticNumber_planeOver_sqrt_five_le_five`, `…_sqrt_247_le_five` | none | — | — |

**No hypothesis of a headline that is a condition is without a kernel model but three**: the two finite-field
hypotheses of `ThreeColourCriterion` (ruled a sentence, item 698) and the stable prime of `K(√7)` (the module says so);
three hypotheses are met by terms only — `localBound F ≤ 4` (and `≤ 2`) of row 99's forms and of the two-colour
corollary, and a stable prime with nine elements in its quotient (open gate item 3); the joint forms of clauses (b) and (c)
are terms whose pieces are library theorems. **No older statement is emptied or made vacuous by this landing**:
it brings no axiom and no carrier. **One older hypothesis is made provable**: `hRow99` (stage 4).

| step, this machine | wall | peak (charged) | max-rss |
|---|---|---|---|
| `./scripts/vacuity.sh` | 121–125 s | 0.60 GiB | 4.52 GiB |
| `./scripts/vacuity.sh --self-test` (65 controls) | about 130 s | 0.60 GiB | 4.5 GiB |

## Stage 6 — SAVED (FS131-LJ1): read aloud — each clause against the claim list

*The statements as the kernel holds them are `#check` prints from the built tree (`data/fs131/lj1/checks.lean`,
`probes/checks-probe2.log`); axioms are from the same file's `#print axioms` lines, read by me. "std3" means
`[propext, Classical.choice, Quot.sound]`; "Weil" means those and `HadwigerNelson.StandingFive.kloosterman_bound`. The
two places where Lean says more than the claim list's lines were sent to the coordinator before the pass.*

### NF4-THEOREM (a) — the table: term for term, plus one degenerate case

The kernel's statement: `ThreeFourColours.chromaticNumber_planeOver_sqrt_table : ∀ {m : ℕ}, Squarefree m → (m % 4 ≠ 3 →
χ = 2) ∧ (m % 12 = 3 ∨ m % 12 = 7 → χ = 3) ∧ (m % 12 = 11 → 4 ≤ χ) ∧ (m % 12 = 11 → m % 168 ≠ 47 ∧ m % 168 ≠ 143 ∧ m % 168
≠ 167 → χ = 4)`. Here `χ` is `(SimpleGraph.induce (planeOver (fieldOfRadicands {m})) (unitDistance ℂ)).chromaticNumber`,
and `fieldOfRadicands {m}` is the subfield of `ℝ` generated by `√m`. **std3.**
- Hypotheses Lean has that the claim lacks: **none**.
- Hypotheses the claim has that Lean does not need: squarefreeness, for the lower bound
  (`TorsionExtraction.four_le_chromaticNumber_planeOver_fieldOfRadicands {d} (hd : d % 12 = 11)`, and for every subfield
  holding `√d`: `four_le_chromaticNumber_planeOver_of_sqrt_mem`; the dated line of 17:51, G-1). The rows need only part of
  squarefreeness (the joining job's dated line, (3)). Each is kernel-checked.
- **Lean says more, in a case the dated lines do not name**: at `m = 1` (squarefree, `1 ≢ 3 (mod 4)`)
  `fieldOfRadicands {1}` is `ℚ`, so the first conjunct also gives `χ(ℚ²) = 2` — true (Woodall), but not a quadratic field.
  Sent to the coordinator.
- The excluded classes are exactly the claim's 47, 143 and 167 modulo 168.

**Each exact value, and the kernel theorem that holds each half** (all std3):

| value | upper half | lower half | the value |
|---|---|---|---|
| 2, squarefree `m ≢ 3 (mod 4)` | `DyadicQuadratic.colorable_two_planeOver_sqrt` (`[Fischer1990]` Thm 8) | `UpperHalf.two_le_chromaticNumber_planeOver` (any subfield) | `ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_two` |
| 3, squarefree `m ≡ 3, 7 (mod 12)` | `ThreeFourColours.colorable_three_planeOver_sqrt` (a prime above 3; Thm 9) | `TorsionExtraction.three_le_chromaticNumber_planeOver_of_sqrt_mem` (Thm 8's "only if") | `chromaticNumber_planeOver_sqrt_eq_three` |
| 4, squarefree `m ≡ 11 (mod 12)` outside 47, 143, 167 (mod 168) | `DyadicQuadratic.colorable_four_planeOver_sqrt` at `m ≡ 3 (mod 8)` (the value is Thm 10(i)'s); `ThreeFourColours.colorable_four_planeOver_sqrt_of_seven` (the residue plane at 7) | `TorsionExtraction.four_le_chromaticNumber_planeOver_fieldOfRadicands` — **this project's** | `chromaticNumber_planeOver_sqrt_eq_four` (through `…_of_dyadic`, `…_of_seven`) |
| `≥ 4` at 47, 143, 167 (mod 168) | — | the same | — |

### NF4-THEOREM (b) — term for term; "above 3" is implied, not written

`ThreeFourColours.chromaticNumber_planeOver_eq_three_iff : ∀ (F : Subfield ℝ) [NumberField F], ¬ Colorable 2 → (χ(F²) = 3
↔ ∃ 𝔭 : Ideal (𝓞 F), 𝔭.IsMaximal ∧ Nat.card (𝓞 F ⧸ 𝔭) = 3)`. **Weil.**
- "a real number field" is a subfield of `ℝ` that is a number field. This is the claim's reading: the plane depends on
  the embedding. "Whose plane is not bipartite" is `¬ Colorable 2`. "A prime of F with residue field `𝔽₃`" is a maximal
  ideal of `𝓞 F` whose quotient has three elements.
- Hypotheses Lean has that the claim lacks: **none**. The claim has one that Lean does not write, "above 3": a quotient
  of three elements has characteristic 3, so the prime contains 3 (the joining job's reading, item 720).
- Without `hnb`: `colorable_three_planeOver_iff` (`Colorable 3 ↔ Colorable 2 ∨ ∃ 𝔭 …`), **Weil**.
- **Which direction reads Weil**: from a three-colouring to the prime. The other direction, from the prime to the
  colouring, is `colorable_three_of_card_three` (**std3**; prior art: the residue plane `Γ₃`). That is the claim list's
  "not claimed" line, which says every upper bound here is prior art.
- Both sides of the iff occur under `hnb` (stage 5: `ℚ(√3)` and `ℚ(√11)`).

### NF4-THEOREM (c) — at least as strong as the claim

`TorsionExtraction.four_le_chromaticNumber_planeOver_of_inv_three_mem : ∀ {F : Subfield ℝ}, (3 : ℂ)⁻¹ ∈ unitRing F →
¬ Colorable 2 → 4 ≤ χ(F²)`. **std3.**
- "`1/3` is an integer combination of unit vectors" is `(3 : ℂ)⁻¹ ∈ unitRing F`. `unitRing F` is
  `UnitRing.unitRingOver F`, the subring of `ℂ` generated by the unit vectors of `F²`. Every element of it is a sum of
  unit vectors (`UnitRing.exists_sum_eq_of_mem_unitRingOver`), and every integer combination of them lies in it, so the
  two readings are equivalent.
- **"`F²` has an odd cycle" is `¬ Colorable 2`.** A graph with an odd cycle is not two-colourable, so Lean's hypothesis
  follows from the claim's, and Lean's statement applies wherever the claim's does. The converse, that a graph which is
  not two-colourable has an odd cycle, is true but neither stated nor needed. Sent to the coordinator.
- Hypotheses Lean has that the claim lacks: **none**. Every subfield of `ℝ`, as the claim says.
- Its dated widening G-2 is `chromaticNumber_planeOver_ne_three_of_inv_three_mem` (`χ ≠ 3`, no bipartiteness
  hypothesis), **std3**.

### Row 99 (the claim list's NF4-ROW-99; `LEDGER.md` row 99) — its first three sentences in the kernel, on Weil

| the row's sentence | kernel statement | axioms |
|---|---|---|
| "`χ(F²) ≤ 3 ⟺ L(F) ≤ 3`" | `ThreeFourColours.chromaticNumber_planeOver_le_three_iff (F) [NumberField F]` | Weil |
| "`χ(F²) = L(F)` whenever `L(F) ≤ 4`" | `chromaticNumber_planeOver_eq_localBound_of_le_four (F) (h : localBound F ≤ 4)` — upper half `UpperHalf.chromaticNumber_planeOver_le_localBound` (std3, FS131-LU1), lower half `localBound_le_chromaticNumber_of_le_four` (Weil) | Weil |
| "a non-bipartite real number field's plane is three-chromatic iff some prime of `F` above 3 has residue field `𝔽₃`" | clause (b), above | Weil |
| the form row 127 takes (`hRow99`) | `localBound_le_chromaticNumber_of_le_four`, from `localBound_le_chromaticNumber_or_four_le` (`L ≤ χ ∨ 4 ≤ χ`, every real number field) | Weil |
| "every three-colour band character of such a field is a residue character at one such prime (no mixing)" | **none — still [hand]** | — |
| "`χ(ℚ(α,√7)²) = 4`" | **none — still [hand]** | — |

- `L(F)` is `SpectralChain.localBound F := ⨅ P : StablePrime F, (levelTarget P 1).chromaticNumber`, the row's local
  bound at level one.
- Hypotheses Lean has that the row lacks: **none**. Those the row has that Lean does not need: none.
- Weil's bound is read in exactly one place, `ThreeColourCriterion.targetFloor_four_weil`, in the case of three colours
  and not two (`exists_maximal_card_nine_of_colorable_three`). The two-colour case does not read it, and neither does
  the case `χ ≥ 4`.

### The claim list's other lines

- **NF4-NC** ("not claimed"), clause by clause. *Every upper bound is prior art*: each upper-half statement of the line
  carries a credit in its docstring — `[Fischer1990]` Thms 8, 9, 10(i) with page, the residue plane `[Moorhouse2010]`,
  `[Madore2015]`, or the residue module — as the joining job read them against the paper. *The two-colour classification
  over every real number field, and the three-colour one for fields containing `√3`, are not ours*: in the ring's words
  the two-colour end is `exists_maximal_conj_trivial_of_colorable_two`, credited to the outside model and to
  `[Fischer1990]` Thm 1(iii). Its prime form is `exists_stablePrime_ramified_sqrt` and the joining module's J4; the
  module docstrings say whose. *Anything at five colours*: the two statements at five, `UpperHalf.…_sqrt_five_le_five`
  and `…_sqrt_247_le_five`, are upper halves, prior art; the lower halves are stated nowhere. *Fields that are not number
  fields*: clause (b) and row 99 require `[NumberField F]`. Clause (c), clause (a)'s lower bounds, NF4-S6 and NF4-S7 hold
  for every subfield of `ℝ`, which the claim also states for (c).
- **NF4-S6**: `ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable` (std3). It starts from a colouring where
  the claim starts from a winding; the winding form is `Winding.exists_box_point` with `exists_character_of_box_point`.
  **NF4-S7**: `TorsionExtraction.exists_torsion_mem_fieldBandSet` (std3). **NF4-S9 at level one**, as the 17:59 line
  restricts it: `ThreeFourColours.exists_unitSet_residue_eq` (std3); at higher levels nothing is stated.
- **NF4-ROW-73**: "`= 4`, both halves". In the kernel twice, std3: `UpperHalf.chromaticNumber_planeOver_eleven` (the
  residue plane at 7, FS131-LU1) and `ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four_of_dyadic` at 11 (the
  table's `example`). Also exactly 4 at 23 (an `example`) and at 71, 95 and 191 (this job's term `table_at_71_95_191`,
  not a library theorem).
- **NF4-ROW-82**: "`χ(F²) ≥ 4` whenever `1/3 ∈ ℤ[U_F]` and `F²` is not bipartite; so `χ(ℚ(√d)²) ≥ 4` for every squarefree
  `d ≡ 11 (mod 12)`". Clause (c) and the table's third conjunct, std3; FS81-T4 is
  `colorable_two_of_fieldBandSet_three_nonempty`.
- **The dated lines.** *17:51 (G-1, G-2, G-3)*: G-1 and G-2 as above. G-3 says clause (b) does not need the outside
  model's two-colour classification: `colorable_three_planeOver_iff`'s proof reaches the prime through
  `exists_maximal_card_nine_of_colorable_three` under `¬ Colorable 2`, and names no prime above 2. *17:59, NF4-S9*: level
  one only, as above. *17:59, NF4-DYADIC-TWO and -FOUR*: `exists_stablePrime_ramified_sqrt` (squarefree `m ≢ 3 (mod 4)`)
  and `exists_stablePrime_card_four_sqrt` (every `m ≡ 3 (mod 8)`, more than the line's `m ≡ 11 (mod 24)`, as the
  joining job's dated line (5) says), both std3. *20:28 and 20:32*: the widened statements are the module's —
  `exists_mul_conj_inv_eq_of_mul_conj_eq_one` has no `[Finite k]`, `eq_zero_of_forall_normOne_eq` has no `hσσ`,
  `exists_maximal_conj_trivial` has no involution hypothesis (their heads, stage 1). *The joining job's line*: each of
  its five items is a kernel statement of the built tree, by the names it gives, each std3. Two pieces are not kernel
  statements: its two examples of why squarefreeness cannot be dropped whole (`m = 12` gives `ℚ(√3)`, `m = 99` gives
  `ℚ(√11)`). They are remarks, and the docstrings use the second.

**Which clauses rest on the standard three alone, and which also on Weil's bound, read from my own print.** On the
standard three alone: clause (a) whole, including the lower bound of four; clause (c) and its widening; clause (b) from
the prime to the colouring; NF4-S6, S7, S9 at level one; the dictionary J1–J4; the two dyadic statements. On the
standard three and Weil's bound: clause (b) as claimed and without `hnb`, and row 99 in its four forms, with the model
`exists_maximal_card_nine_sqrt_three`. Twelve records in all, and one private helper.

## Stage 7 — SAVED (FS131-LJ1): before the pass — `main` merged once more, the two planted controls, the slots

**`main` merged in again** (`data/fs131/lj1/merge-2.out`): it had moved to `3a6f8876b`. The eleven paths it brought are
all under `data/` and `plans/`, among them inventory items 723–731 and the claim list's dated line of 03:30 UTC (this
job's read-aloud, filed in its words). The trial was clean (`merge-2-trial.out`), and the merge was by hash and
automatic (`457cd8e70`), so the commit the gate reads holds them. The coordinator's item 731 says "no reply sent — it
goes on unless told": the read-aloud's two findings do not stop the pass.

**The zero-`sorry` search's plant** (`data/fs131/lj1/sorry-plant.sh`, FS131-LU1's pointed at
`Instances/UpperHalfCorollaries`; `sorry-plant.out`). A theorem with a `sorry` body was appended, never built and never
committed. The narrow search found 0 lines before and 1 with the plant: "PLANT FIRED: the search finds the planted
sorry and nothing else". The module was restored by `git checkout` ("RESTORED", digest `1488efc2…` before and after);
the search then found 0 lines again, and 0 tracked files were modified.

**The lint's negative control** (`data/fs131/lj1/lint-plant.sh`; `lint-plant-run.out`). `theorem zz_lj1_lint_plant
[Nonempty ℕ] : (1 : ℕ) = 1 := rfl` was planted at the end of `Instances/UpperHalfCorollaries.lean`, never committed, and
built: "build: OK — 249 of 249 batches, 5 module(s) rebuilt, **0 module(s) with warnings**, 7m54s"
(`lint-plant-build.log`). The five were the torsion module, whose docstring stage 5 edited; the two modules downstream
of it; the planted module; and the root. The build's own linters do not see the plant. Then the guarded lint: **exit 1**,
"`unusedArguments`: (2/2) Failed with 1 messages", "`@zz_lj1_lint_plant` 1 unused argument", with `synTaut` failing on
the same plant (`lint-plant.log`). The file was restored by `git checkout` under a trap: "RESTORED: the module is the
text it was", the plant's name 0 times, "tracked files modified: 0". Nothing ran beside the plant. The pass's build
recompiles the module and the root from the restored text.

**The drafts' slots, read on `main` at `3a6f8876b`** (`data/fs131/lj1/drafts-slots.py`, FS131-LU1's with this
landing's slots; `drafts-slots.out`): 21 of 21 found exactly once, the control absent. One slot first occurred twice: the
bibliography's sentence on `χ(ℚ(√11)²) ≤ 4`, which two rows carry. Its slot now includes the words before it in the
`[Fischer1990]` row.

**What stands for "nothing else was recompiled"**, since this job copied no compiled file. The joining job copied the
whole `.lake/build` of `fs131-wnf`, the tree whose gate passed last (its stage 2). The pass therefore compares every
`.olean` of this tree with the last landing's manifest of that tree, `data/fs131/lu1/olean-manifest.txt`
(`data/fs131/lj1/olean_against_lu1.py`, with four plants). Only the last landing's three modules and the root may
differ, because that landing recompiled them after making its manifest; and only the line's six modules may be new. It
also dumps the last two landings' modules as stored and compares them with those landings' own final dumps.

## Stage 8 — SAVED (FS131-LJ1): the full gate on one commit — `def7c07f8` — green on its first pass

One pass ran every step in order, one at a time, under the slot (`data/fs131/lj1/run-gate.sh final 3a6f8876b 8`,
launched from a snapshot copy). Every log is under `data/fs131/lj1/gate/` with its exit status on its last line.
`run-gate-final.head` records the commit, `def7c07f8e7bda496e33aac52ee076cfab554d17`, and that no tracked file was
modified at its start; it also lists the paths under `Proofs/`, `scripts/` and the map where the commit differs from
`main`: the six modules, `Proofs.lean` and `ARCHITECTURE.md`. `scripts/` differs from `main` too: see the baseline row
below. `run-pass-final.out` holds every step's exit and `measure-final.txt` every step's wall time and memory
(03:40:05–04:03:20, 23 minutes). **Every step exited 0 but the one planted control that must exit 1** (the scan
difference's plants), and "tracked files modified after the pass: 0". It is the **first** full pass of this job. Every
count below is read from the saved logs.

| step | result, read from its saved log (`data/fs131/lj1/gate/`, tag `final`) | log | wall | peak (charged) / max-rss |
|---|---|---|---|---|
| build (`BATCH=8`, `--mem 10 --cpus 4`) | "build: OK — 249 of 249 batches, 2 module(s) rebuilt, **0 module(s) with warnings**, 7m15s": `Instances.UpperHalfCorollaries` and the root, recompiled from the text restored after the lint's control. One line of the build log holds "warning", and it is that sentence; Lake's full log has 0. Then `lake build --no-build Proofs`: up to date | `build-final.log`, `receipt-build-final.log`, `build-final.rss`, `uptodate-final.log` | 450 s | the one compiler 3.3 GiB resident |
| `sorry` | the narrow pattern over `Proofs/` and `Proofs.lean`: **0** lines; `\bsorry\b`: 24, all prose, `main`'s count; the search's plant fired before the pass (stage 7) | `sorry-narrow-final.txt`, `sorry-wide-final.txt`; `../sorry-plant.out` | — | — |
| `axiom` lines in `Proofs/` | 4 line-initial, as on `main` (three axioms, and one line of a docstring's code block). **The landing brings none** | `axiom-lines-final.txt` | — | — |
| doubled names, after the build and before the audit | "dupnames: OK — no name is declared by two modules (24 generated on demand, listed above)"; its self-test "OK — all 15 controls behaved" | `dupnames-final.log`, `dupnames-selftest-final.log` | 6.2 s; 28 s | 0.51 / 4.34 GiB; 0.78 / 1.54 |
| every declaration in a block, before the audit | "declarations the landing brings: 96 (of 96 constants in 6 modules); with one line: 96; unfiled: 0; doubled: 0; `#print axioms` lines in the script: 7602, names twice: 0" | `unfiled-final.txt`, `decls-final.out` | 67 s (the dump) | 0.55 / 4.38 |
| axioms | "audited: **7602 records — 7531 clean on the standard axioms, 28 axiom-free, 38 imported** (resting on a declared outside theorem), **5 declared purchase(s)**"; "axioms: OK". `CLAUDE.md` § Trust ledger flagged stale, "7447 clean → 7531, 26 imported → 38" (draft 1) | `axioms-final.log`, `receipt-axioms-final.log` | 9.4 s | 0.63 / 4.44 |
| its self-test | "axioms self-test: OK — every planted fault fired, and every partner passed." (23 of 23; its two state-reading controls moved at stage 3 after being seen red) | `axioms-selftest-final.log`, `receipt-axioms-self-test-final.log` | 193 s | 1.08 / 4.80 |
| every declaration of the landing filed on what it rests on (`data/fs131/lj1/lj1_records.py`) | "records: PASS": 83 records on exactly the three, 1 on `[propext, Quot.sound]` (`DyadicQuadratic.mod_four_of_squarefree`), 12 on the three and Weil's bound; headlines "39 of 39" under CLEAN and "12 of 12" under IMPORTED; over the whole log 38 under IMPORTED (20 + 6 + 12), none carrying two imports, none `sorryAx`; "plants: every one of 16 fired; the unplanted lists pass" | `records-final.txt`, `records-plant-final.txt`, `theorem-lines-final.txt` | — | — |
| the import's block with its two controls; the generated modules against the generator (regression checks, because the audit script they read is edited) | "block: PASS — every record as filed; both controls fired"; "CHECK OK" (163 records); "SELF-TEST OK: 10 plants refused and 1 partner accepted" | `block-final.txt`, `port-check-final.txt`, `port-selftest-final.txt` | 9 s | (the tool's own slots) |
| vacuity | "scanned: **declarations=16125 refutations-skipped=228**"; "sites: **sites=1454 vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2**"; "vacuity: OK"; the baseline header "match (9 of 9 compared)". Flagged stale, not failed: `CLAUDE.md` § The gate ("declarations 16029 → 16125"; draft 2) | `vacuity-final.log`, `receipt-vacuity-final.log` | 118 s | 0.60 / 4.50 |
| the scan against the last landing's, row for row | "by module: declarations +96, refutations +0: equal to the scans difference"; "vacdiff: PASS"; its plants: "vacdiff: FAIL (5)", exit 1, as they must | `vacdiff-final.txt`, `vacdiff-plant-final.txt`, `count-modules-final.out` | 74 s (the counter) | 0.57 / 4.45 |
| its self-test | "OK — all 65 controls behaved: every one fired, and the silent ones stayed silent." | `vacuity-selftest-final.log` | 124 s | 0.60 / 4.51 |
| assumptions | "assumptions: OK — 3 outside theorem(s) as axioms, with **39** theorem(s) resting on them; 19 named and **14** inline hypotheses (7 outside, **21** ours, 5 open), taken by **102** statement(s) and mentioned by 1"; "assumed: **axioms=3 rests=39 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1**"; the ledger's header "match (9 of 9 compared)"; `CLAUDE.md` § Trust ledger flagged stale, "rests 26 → 39, inline 15 → 14, ours 22 → 21, takes 106 → 102" (draft 3); its self-test "OK — all 33 checks behaved" | `assumptions-final.log`, `receipt-assumptions-final.log`, `assumptions-selftest-final.log` | 122 s; 122 s | 0.68 / 4.57; 0.71 / 4.60 |
| architecture | "RESULT: PASS" | `arch-final.txt` | 3.8 s | — |
| guarded lint (`lake lint --no-build -- --no-build --trace`, `--mem 8`) | exit 0, "-- Linting passed for Proofs.", 14 linters, each "Passed!", none failed; its control went red before the pass (stage 7) | `lint-final.log`; `../lint-plant.log` | 10.3 s | 0.90 / 4.93 |
| notes, as the last landing ran them | "notes read: 196 LOCAL-SAID=31 NO-OBJECT=48 NONE-SAID=59 no-conflict=58", `main`'s count; "self-test: OK (6 controls, 1 planted)" | `notes-l5-final.txt`, `notes-qa4-selftest-final.txt` | 3.8 s | — |
| **the statements as stored, against the dump made before the merge and before any edit** | "statements: PASS: no statement and no definition changed — 96 named constants compared in 6 module(s)"; "plants: every one of 4 fired; the unplanted pair passes" | `statements-final.txt`, `statements-plant-final.txt`, `statements-final.compact` | 6.1 s | 0.59 / 4.41 |
| the six files in text, block comments removed, against the merge commit (`fb76f2890`) | "SAME" six times; the plant "DIFFERS" six times | `code-only-final.txt`, `code-only-plant-final.txt`, `proofs-diff-final.txt` | — | — |
| the statements by `#check`, their axioms, the four sites of the retired binder, the models | no error, no warning; 47 prints, **28 on `[propext, Classical.choice, Quot.sound]` and 19 on those and `StandingFive.kloosterman_bound`**, each as stage 6 reads it | `checks-final.out`, `checks-final.err` (empty) | 3.6 s | 0.53 / 4.36 |
| the compiled library against the last landing's manifest of its gated tree | ".olean files of Proofs: 1908 in the tree, 1902 in the last landing's manifest; same SHA-256: 1900; differing: 2" (`Proofs.olean`, `Arith/QuadraticPrime.olean`, both allowed: that landing recompiled them after its manifest); "in the tree only: 6", the line's modules; `Outside/OAI158`, `Plane/LebesgueNumber`, `Plane/AeColouring`, `Arith/WeilKloosterman`, `SpectralChain` "identical"; "olean-against-lu1: PASS"; "plants: every one of 4 fired" | `olean-against-lu1-final.txt`, `…-plant-final.txt` | 2.5 s | — |
| the last two landings' modules as this tree stores them, against those landings' own final dumps | FS131-LU1's three: "PASS … 52 named constants compared in 3 module(s)"; FS131-LC1's: "PASS … 87 named constants compared in 3 module(s)" | `statements-lu1-final.txt`, `statements-lc1-final.txt` | 5.5 s; 3.7 s | 0.63 / 4.45 |
| the baseline and the scans' sources | baseline entries unchanged from `main`'s (2). Lines that differ from `main`'s: `scripts/Axioms.lean` 118 (the block), `scripts/Assumptions.lean` 10 (the retired sites and the comment), `scripts/assumptions-ledger.txt` 19, `scripts/axioms-controls.txt` 13 (the two controls and the header's description of the state), `scripts/vacuity-baseline.txt` 2 (the header's count line). 0 lines differ in `scripts/Vacuity.lean`, the other control files, `DupNames.lean`, `gate_report.py`, the four gate scripts or `build.sh` | `baseline-final.txt` | — | — |
| the three digests against the previous landing's receipts (`data/fs131/lu1/gate/receipt-*-final.log`) | axioms: 96 rows added and none removed, 84 under CLEAN and 12 under IMPORTED; vacuity: one count moves, "rows: none changed"; assumptions: `rests 26 → 39`, `inline 15 → 14`, `ours 22 → 21`, `takes 106 → 102` — the entry, four sites and four `TAKES` rows of `inline:Row99` gone, thirteen `RESTS` rows added. **Stale against the front page until the drafts are filed, exactly these lines**: in `CLAUDE.md` § Trust ledger, "7447 clean → 7531, 26 imported → 38" and "rests 26 → 39, inline 15 → 14, ours 22 → 21, takes 106 → 102"; in `CLAUDE.md` § The gate, "declarations 16029 → 16125". The two headers on the branch match | `digest-axioms-final.txt`, `digest-vacuity-final.txt`, `digest-assumptions-final.txt` | — | — |

**The brief's prediction, against the gate**: "7,602 records, 7,531 clean, 38 imported, with the axiom-free and purchase
counts unchanged". **Met, each count.**

**Read aloud against the informal claim.** The claim of this landing is the claim list's theorem: (a) the table for
real quadratic fields; (b) the three-colour criterion over every real number field; (c) a lower bound of four over every
subfield of `ℝ` whose unit-vector ring holds `1/3`; and row 99's first three sentences. What the gate shows: no `axiom`
and no `sorry` enters `Proofs/`; each of the 96 declarations of the six modules has one record, 84 under CLEAN on the
standard three or fewer and 12 under IMPORTED on those and Weil's bound alone; no name is declared twice, so each
printed list is the list of the proof the kernel checked; the one hand result the line proves has left the ledger of
what the library assumes, and its cost is the import's `RESTS` rows; no statement moved between the joining job's
first build, the merge and this commit. **What the gate does not show, and this record says**: that each statement is
its claim (stage 6, clause by clause, with two places where Lean says slightly more); that the hypotheses can be met
(stage 5 names each model and how it is held, since the scan saw none of them); that the assumptions step would have
noticed the discharged binder (it would not: stage 4, where four kernel terms stand in its place); that any value is
new. The values 2 and 3 and every upper bound are prior art. This project's are the lower bound of four, the
three-colour criterion's direction from a colouring to the prime, and the clause for subfields, each with its kernel
proof.

## Drafts for the front page (FS131-LJ1)

*For the coordinator to file; this job files none of them. Each draft names its slot: the file, the section, and **the
exact words on `main` it replaces or follows**. A script checks that each slot occurs exactly once on `main`
(`data/fs131/lj1/drafts-slots.py`, output `drafts-slots.out`). Each draft also names the log line it comes from. The
gated commit is `def7c07f8e7bda496e33aac52ee076cfab554d17`; its logs are `data/fs131/lj1/gate/*-final.*`, and the three scans' full outputs are
`receipt-axioms-final.log`, `receipt-vacuity-final.log` and `receipt-assumptions-final.log`. **Whose the mathematics is,
as the joining job read it against the paper**: the values 2 and 3 and every upper bound are prior art (`[Fischer1990]`
Thms 1, 8, 9, 10(i); `[Johnson1987]`; the residue plane, `[Moorhouse2010]`, `[Madore2015]`). This project's are three
things: the lower bound of four against every colouring at radicands 11 modulo 12; the three-colour criterion over
every real number field (the direction from a colouring to the prime); and the clause for subfields of the reals.
Throughout, the kernel proofs are this project's. Nothing here moves the answer.*

**1. `CLAUDE.md` § Trust ledger, the audit's sentence.** *Replaces* "the current audit reads 7447 clean and 5 declared
purchases, and 26 imported (and 28 axiom-free; 7,506 records at the landing of FS-131's first number-field module, the
residue upper half, FS131-LU1, 2026-10-13)". From `axioms-final.log`, "audited: 7602 records — 7531 clean on the
standard axioms, 28 axiom-free, 38 imported (resting on a declared outside theorem), 5 declared purchase(s)":

> the current audit reads 7531 clean and 5 declared purchases, and 38 imported (and 28 axiom-free; 7,602 records at the
> landing of FS-131's three-and-four-colours line, FS131-LJ1, 2026-10-14)

7447 + 84 = 7531; 26 + 12 = 38; 7,506 + 96 = 7,602; axiom-free and purchases do not move.

**1b. The same paragraph, the import's count.** *Replaces* "`StandingFive.kloosterman_bound` — Weil's bound for
Kloosterman sums, `[Weil1948]` p. 207, read against its page by two readers — with eight imported records;" *by*

> `StandingFive.kloosterman_bound` — Weil's bound for Kloosterman sums, `[Weil1948]` p. 207, read against its page by
> two readers — with twenty imported records (twelve of them the three-colour criterion's and row 99's, FS131-LJ1);

From `records-final.txt`: "records carrying kloosterman_bound: 20 (filed: 20); of the landing's: 12". The rest of the
paragraph stands: "no record rests on two of the three" ("carrying two imports 0").

**2. `CLAUDE.md` § The gate, the vacuity scan's two count lines.** *Replaces* "`declarations=16029
refutations-skipped=228 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`." From
`vacuity-final.log`, "scanned: declarations=16125 refutations-skipped=228" and "sites: sites=1454 vacuous=0 stale=0
declared=3 witnessed=38 generic=1411 unknown=2" (runs of spaces collapsed):

> `declarations=16125 refutations-skipped=228 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`.

One count moves: declarations +96. No site is added, because the scan is silent on the line (stage 5). The baseline's
header is refiled on the branch.

**3. `CLAUDE.md` § Trust ledger, the nine assumption counts and their sentence.** *Replaces* "`axioms=3 rests=26
named=19 inline=15 outside=7 ours=22 open=5 takes=106 mentions=1` — three outside theorems declared as axioms, with
twenty-six theorems resting on them; thirty-four hypotheses, nineteen named and fifteen written out in a binder — seven
standing for outside theorems, twenty-two for hand results of ours and five declared as open questions — taken in 106
(hypothesis, statement) pairs by 52 statements (`scripts/assumptions-ledger.txt` lists each pair; FS131-LT5, 2026-10-06;
one hand result left the list at FS131-LU1, 2026-10-13: the upper half `χ(F²) ≤ L(F)` is the theorem
`UpperHalf.chromaticNumber_planeOver_le_localBound`)". From `receipt-assumptions-final.log`, its `=== TOTALS ===` line,
"axioms=3 rests=39 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1":

> `axioms=3 rests=39 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1` — three outside theorems declared
> as axioms, with thirty-nine theorems resting on them; thirty-three hypotheses, nineteen named and fourteen written out
> in a binder — seven standing for outside theorems, twenty-one for hand results of ours and five declared as open
> questions — taken in 102 (hypothesis, statement) pairs by 52 statements (`scripts/assumptions-ledger.txt` lists each
> pair; FS131-LT5, 2026-10-06; two hand results have left the list since. At FS131-LU1, 2026-10-13: the upper half
> `χ(F²) ≤ L(F)`, now the theorem `UpperHalf.chromaticNumber_planeOver_le_localBound`. At FS131-LJ1, 2026-10-14: row 99's
> lower half through four, `hRow99`, now the theorem `ThreeFourColours.localBound_le_chromaticNumber_of_le_four`, which
> rests on Weil's bound)

Four of the nine move:
- `rests` 26 → 39: the twelve imported records and one private helper.
- `inline` 15 → 14 and `ours` 22 → 21: the entry `inline:Row99` retired.
- `takes` 106 → 102: its four pairs.

The ledger is rewritten on the branch by the script (`--write-ledger`: thirteen rows gained, four lost, 142 rows).

**4. `tools/claude_md_fact_audit.py`, `GATE_CHANGES`.** One entry after the last (`(("7395", "5"), ("7447", "5")):`):

```python
    (("7447", "5"), ("7531", "5")): "FS-131, the landing of its three-and-four-colours line — for squarefree m the plane over Q(sqrt m) needs 2 colours at m != 3 (mod 4), 3 at m = 3, 7 (mod 12), at least 4 at m = 11 (mod 12) and exactly 4 there outside 47, 143, 167 (mod 168); over every real number field a non-bipartite plane is three-chromatic iff a prime has residue field F_3, chi <= 3 iff L <= 3 and chi = L for L <= 4 (on Weil's bound); chi >= 4 over every subfield of R whose unit-vector ring holds 1/3 and whose plane is not bipartite; the values 2 and 3 and every upper bound prior art, the lower bound of four, the criterion and the clause for subfields ours, the kernel proofs ours (FS131-LJ1; copy data/fs131/lj1/gate/receipt-axioms-final.log, gated commit def7c07f8): 7,602 records, 7,531 clean, 28 axiom-free, 38 imported, 5 purchases",
```

**4b. The same file's table of superseded counts.** Every token the drafts retire, in that table's own form, each with
its value as the reason: `"7447"` (7531 clean); `"7,506"` and `"7506"` (7,602 records); `"26 imported"` (38 imported);
`"with eight"` (with twenty); `"declarations=16029"`, `"16029"` and `"declarations=16029 refutations-skipped=228
sites=1454"` (16125); `"rests=26"` (39); `"inline=15"` (14); `"ours=22"` (21); `"takes=106"` (102); `"axioms=3
rests=26 named=19 inline=15 outside=7 ours=22 open=5 takes=106 mentions=1"` (the new nine); `"twenty-six theorems
resting"` (thirty-nine); `"thirty-four hypotheses"` (thirty-three); `"fifteen written out"` (fourteen); `"twenty-two
for hand results"` (twenty-one); `"106 (hypothesis, statement) pairs by 52 statements"` (102 by 52). The reason for
each: "superseded gate count, refiled at FS131-LJ1's landing from data/fs131/lj1/gate/receipt-axioms-final.log (the
vacuity count from receipt-vacuity-final.log, the assumption counts from receipt-assumptions-final.log); the old count
stays in data/fs131/lu1/gate/ and in GATE_CHANGES". **The next landing's previous receipts are
`data/fs131/lj1/gate/receipt-{axioms,vacuity,assumptions}-final.log`.**

**5. `CLAUDE.md` § Where the problem stands, "What the kernel holds, beyond the interval": the sentences on three and
four colours.** *Follows* "`χ(ℚ(√167)²) ≤ 8` and `χ(ℚ(√47)²) ≤ 5` a second way (rows 52, 57, 63, 105, 119, 121;
FS131-LU1; known values and bounds, the kernel proofs ours);" *with*

> **three and four colours over real number fields** (FS131-LJ1). For squarefree `m` the plane over `ℚ(√m)` needs 2
> colours when `m ≢ 3 (mod 4)` and 3 when `m ≡ 3, 7 (mod 12)`. When `m ≡ 11 (mod 12)` it needs at least 4, and exactly 4
> outside the classes 47, 143 and 167 modulo 168. All of this is on the standard three axioms
> (`ThreeFourColours.chromaticNumber_planeOver_sqrt_table`), and the lower bound of four needs no squarefreeness
> (`TorsionExtraction.four_le_chromaticNumber_planeOver_fieldOfRadicands`). Every subfield of `ℝ` whose unit-vector ring
> holds `1/3` has a plane that needs at least four colours unless it is bipartite, and is never exactly three-chromatic
> (`TorsionExtraction.four_le_chromaticNumber_planeOver_of_inv_three_mem`, `…_ne_three_…`; standard three). Over every
> real number field, on one declared outside theorem, Weil's bound: a non-bipartite plane is three-chromatic exactly when
> some prime of `F` has residue field `𝔽₃`; `χ(F²) ≤ 3 ⟺ L(F) ≤ 3`; and `χ(F²) = L(F)` whenever `L(F) ≤ 4`
> (`ThreeFourColours.chromaticNumber_planeOver_eq_three_iff`, `…_le_three_iff`, `…_eq_localBound_of_le_four`; rows 82
> and 99). The values 2 and 3 and every upper bound are `[Fischer1990]`'s (Thms 8, 9, 10(i)) and the residue planes'.
> The lower bound of four against every colouring, the three-colour criterion and the clause for subfields are this
> project's, with every kernel proof;

**6. `CLAUDE.md` § Frontier, the "Last filed" line.** *Replaces* "Last filed: **the landing of FS-131's first
number-field module, the residue upper half**" *by* "Last filed: **the landing of FS-131's three-and-four-colours line**
(FS131-LJ1, 2026-10-14: `Arith/ThreeColourCharacter`, `TorsionExtraction`, `ThreeColourCriterion`, `DyadicQuadratic`,
`ThreeFourColours` and `Instances/UpperHalfCorollaries` through the gate — 94 theorems and 2 definitions, 84 records on
the standard three axioms and 12 on those and Weil's bound; the quadratic table, the three-colour criterion over every
real number field and row 99's first three sentences in the kernel; row 99's `hRow99` discharged; no value moved);
before it **the landing of FS-131's first number-field module, the residue upper half**". The rest of the line stands.

**7. `LEDGER.md` — the rows this line regrades, each only as far as its statement landed** (the joining job's D5 checked
against the built tree; every name below is a kernel theorem of the gated commit, with its axioms from `checks-final.out`
and `records-final.txt`).
- **Row 52.** *Replaces* "The two values stay [hand + tools] until the ramified clause is applied at 11 to `K(√5)` and
  `K(√247)`: no file states those instances." *by* "The ramified clause is applied at 11 since FS131-LJ1: the two values'
  upper halves are [kernel] (`UpperHalf.chromaticNumber_planeOver_sqrt_five_le_five`, `…_sqrt_247_le_five`: `χ ≤ 5` over
  `fieldOfRadicands {11, 3, 5}` and `{11, 3, 247}`, the standard three; prior art). Their lower halves, `χ ≥ 5` over these
  two fields, are stated by no declaration, so the two values stay [hand + tools]." The grade bracket "[kernel for the
  bound; hand + tools for the two values]" stands.
- **Row 73.** *Follows* "four exactly except 47 (≤ 5 at 11)." *with* "Since FS131-LJ1, `χ(ℚ(√11)²) = 4` is also the
  table's dyadic row at `m = 11` (`ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four_of_dyadic`). The five lower
  bounds `χ ≥ 4` at 23, 47, 71, 95 and 191 are instances of row 82's family theorem in the kernel
  (`TorsionExtraction.four_le_chromaticNumber_planeOver_fieldOfRadicands`, standard three), and no longer [certified,
  tools] only. The value is exactly 4 at 23, 71, 95 and 191 (`ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four`:
  each is squarefree and `≡ 11 (mod 12)`, and none is 47, 143 or 167 modulo 168). The case at 23 is an `example` of the
  module; the cases at 71, 95 and 191 are kernel-checked terms of the landing (`data/fs131/lj1/checks.lean`,
  `table_at_71_95_191`), not library theorems."
- **Row 79.** *Follows* the grade "**[hand; two independent derivations — de Bruijn and Coxeter — read by Poros; the
  owner checked the two deciding steps]**" *with* "**Its ⟹ is [kernel] since FS131-LJ1** (standard three), for every
  abelian group and step set: `ThreeColourCharacter.bandSet_three_nonempty_of_proper`, with
  `exists_character_of_properAlong`; and at the plane over every subfield of `ℝ`,
  `fieldBandSet_three_nonempty_of_colorable` and, reading the colouring only on `ℤ[U_F]`,
  `…_of_colorable_unitRing` (FS73-T22's ⟹ and FS81-T2). The ⟸, the density of periodic colourings and the statement
  about forced pairs stay [hand]."
- **Row 82.** *Replaces* the grade "**[hand, two independent derivations]**" *by* "**[kernel since FS131-LJ1, the
  standard three; before it hand, two independent derivations]**". *And replaces*, in its **Not claimed**, "anything in
  the kernel (FS73-T22's ⟹ is hand-proved, never kernel; FS-75);" *by* "a kernel proof beyond what the landing holds —
  the row's theorem is `TorsionExtraction.four_le_chromaticNumber_planeOver_of_inv_three_mem` and
  `chromaticNumber_planeOver_ne_three_of_inv_three_mem`; its family clause is `four_le_chromaticNumber_planeOver_of_sqrt_mem`
  (every subfield of `ℝ` holding `√d`, `d ≡ 11 (mod 12)`, with no squarefreeness), whose character form is
  `fieldBandSet_three_eq_empty_of_sqrt_mem`; T4 is `colorable_two_of_fieldBandSet_three_nonempty`; and 'three-colourability
  of every real quadratic plane is decided exactly' is `ThreeFourColours.chromaticNumber_planeOver_sqrt_table`
  (FS131-LJ1);". The row's prior art stands, with the theorem numbers the joining job read: `[Fischer1990]` Thm 10(ii)
  and Ex. 4 for the unit vector and the additive case.
- **Row 99.** *Replaces* the grade "**[hand (+ Weil, tools exact); S1 three derivations (J02, J09, J09v), S2 and the
  torsion theorem two, S3 three, no mixing two independent (J09; J09v blind, a different route)]**" *by*
  "**[kernel since FS131-LJ1, on one declared outside theorem (Weil's bound), for the row's first three sentences:
  `ThreeFourColours.chromaticNumber_planeOver_le_three_iff`, `chromaticNumber_planeOver_eq_localBound_of_le_four`,
  `chromaticNumber_planeOver_eq_three_iff`; "no mixing" and `χ(ℚ(α,√7)²) = 4` stay hand (+ Weil, tools exact) — S1 three
  derivations (J02, J09, J09v), S2 and the torsion theorem two, S3 three, no mixing two independent (J09; J09v blind, a
  different route)]**". *And replaces*, in its **Not claimed**, "a kernel proof (FS-75) — of which one leaf is in the
  kernel since FS131-LU1, the upper half `χ(F²) ≤ L(F)` for every real number field
  (`UpperHalf.chromaticNumber_planeOver_le_localBound`); every other step of the row stays [hand];" *by* "a kernel proof
  of "no mixing" or of `χ(ℚ(α,√7)²) = 4` — the row's other statements are in the kernel: the upper half since FS131-LU1
  (`UpperHalf.chromaticNumber_planeOver_le_localBound`), and since FS131-LJ1 the lower half
  `ThreeFourColours.localBound_le_chromaticNumber_or_four_le` with its three sentences, on Weil's bound. Weil's bound is
  read at one place, `ThreeColourCriterion.targetFloor_four_weil`, in the case of three colours and not two. The
  direction from the prime to the colouring rests on the standard three (`colorable_three_of_card_three`);".
- **Row 105.** *Replaces* "the reading applied at any named field (`K(√7)`'s "every prime above 2 splits in `K(√7)(i)`"
  is not stated);" *by* "the reading applied at any named field but `K(√7)`. There, its consequence that no stable prime
  of `K(√7)(i)` holds 2 is `UpperHalf.two_notMem_stablePrime_seven` since FS131-LJ1 (standard three). That statement
  ranges over a type the kernel does not show to be non-empty (a stable prime exists by Chebotarev), and the splitting
  itself is not stated;".

**8. `LEAN.md`** — the lines the five records drafted, each for § Searching — Lean, after its last bullet ("`tools/check_architecture.py`
fails on a row's imports cell and on module coverage; a misnamed identifier in a row's description is listed under `[3]`
and does not fail (FS131-IV1, two plants on copies)."), by address, to be filed in their words. Each record is in this
tree:
- FS131-IC1, `plans/FS131-IC1-implementation.md` § D7: `simp [f]` on an upstream definition generates `f.eq_1` in the
  module that asks, so a sibling may hold a second copy (a `GENERATED` row of `scripts/dupnames.sh`).
- FS131-IT1, `plans/FS131-IT1-implementation.md` lines 311–320: four lines (`Int.inductionOn'`; `linear_combination` and
  `Complex.I_sq`; the numeral cast in a subring; an orbit as a `zpow`).
- FS131-IN1, `plans/FS131-IN1-implementation.md` § 5: `letI` against `haveI` for a module structure;
  `ConstantInfo.value?` is `none` for a theorem; a farm for a worktree with no upstream `.olean`; two deprecations.
- FS131-ID1, `plans/FS131-ID1-implementation.md` § D6: three lines (a footer's hygienic names; pricing an exhaustion over
  residues by its modulus; `omega` and `Int.natAbs`).
- FS131-KJ1, `plans/FS131-KJ1-joining-module.md` § Stage 7, D8: four lines.
- **This landing's two**, for § The gate (after the assumptions bullet's sentence "… (`hUpper` of
  `SpectralChain.chromaticNumber_eq_localBound`, proved by `UpperHalf.chromaticNumber_planeOver_le_localBound` and retired
  by FS131-LU1 — its record's stage 4 has the receipt);"):
  "A binder retired on the landing's word is retired on a kernel term, not by eye: apply each theorem that takes it to the
  discharging theorem in a checks file. If the binder's type is not that theorem's, the term does not elaborate; and the
  term's axioms are what feeding the binder costs. When that theorem rests on a declared import, the hand result leaves
  the list and its cost moves to the import's `RESTS` row (`hRow99`, `data/fs131/lj1/checks.lean`; FS131-LJ1)." And, for
  § Trust ledger: "The assumptions step's `rests` counts every theorem whose stored axiom list holds an import, private
  helpers included. The audit's imported count counts only the records it names, which are public, so the two can
  differ: 39 against 38 at FS131-LJ1 (`ThreeColourCriterion.exists_maximal_card_nine_of_quotient`)."

**9. `BIBLIOGRAPHY.md`, the row `[Fischer1990]`.** *Follows* "colorings of the graphs (ℚ²(√m), 1)"*. the upper bound `χ(ℚ(√11)²) ≤ 4` is
kernel-checked since FS131-LU1 (`UpperHalf.chromaticNumber_planeOver_eleven`)." in its "what rests on it" cell (the
words before "the upper bound" are part of the slot: the rest occurs twice in the file) *with*: "His Thms 8, 9, 10(i)
give the values and upper bounds of the quadratic table in the kernel since FS131-LJ1
(`ThreeFourColours.chromaticNumber_planeOver_sqrt_table`). His Thm 1(i)–(iii) are three kernel statements
(`DyadicQuadratic.colorable_planeOver_of_addMonoidHom`, `TorsionExtraction.colorable_two_iff_fieldBandSet_two_nonempty`,
`ThreeColourCriterion.exists_maximal_conj_trivial_of_colorable_two` with `fieldBandSet_two_nonempty_of_conj_trivial`)." In
its reading cell, *after* "… which conclude only the additive case (`LEDGER.md` row 82)": the joining job's sentence,
"re-read 2026-10-13 by FS131-KJ1 (Thm 1 and its proof, Thms 7–10 and their proofs, Ex. 4, against the kernel statements
of the three-and-four-colours line): Thm 1(i)–(iii) are three kernel statements; the two-colour and three-colour maps
are his; his four-colouring at `N ≡ 3 (mod 8)` is `ℤ/(4)`-valued and is not the kernel's."

**10. `CLAUDE.md` § The theory in one paragraph.** *Replaces* "and through
five the bound is exact: χ(F²) = L(F) whenever L(F) ≤ 5 (row 99 below five;" *by* "and through
five the bound is exact: χ(F²) = L(F) whenever L(F) ≤ 5 (row 99 below five — through four [kernel] since FS131-LJ1 on
Weil's bound, `ThreeFourColours.chromaticNumber_planeOver_eq_localBound_of_le_four`;". *(The slot is checked by the
script; if the paragraph's words differ, this draft is dropped, not reworded.)*

## Open gate items at this landing

1. **The chain's four theorems still state `hRow99`.** The binder is now discharged by
   `ThreeFourColours.localBound_le_chromaticNumber_of_le_four`, which rests on Weil's bound. The four are
   `SpectralChain.min_localBound_five_le_chromaticNumber`, `…_of_totallyReal`, `chromaticNumber_eq_localBound` and
   `UpperHalf.chromaticNumber_eq_localBound_of_chain`. Restating the headline without the binder is the chain's next
   planner's job (item 720, ruling (d)); the restated headline would be an imported record (`site_chain`,
   `data/fs131/lj1/checks.lean`). Their docstrings still list row 99 among the hand inputs: `SpectralChain.lean:239`,
   `:594`, `:614`. These words now describe a hypothesis that a theorem meets over the import. This is a correction for
   the cleanup sweep, not made here, because the files are not the landing's.
2. **The assumptions step still finds a discharged binder only on a landing's word**, as at FS131-LU1. Here the word is
   backed by four kernel terms that apply each taker to the theorem; the step itself compares no binder's type with any
   conclusion. The tooling list's line from FS131-LU1 stands, with this second instance.
3. **Hypotheses met by terms only, not by library declarations.** The first is `localBound F ≤ 4` (and `≤ 2`) of row
   99's forms and of `UpperHalf.chromaticNumber_planeOver_eq_two_of_localBound_le_two`: no library theorem bounds a
   `localBound` above at a named field, and the terms are `L(ℚ) ≤ 2`, `= 2`, `L(ℚ(√3)) = 3` and `L(ℚ(√11)) = 4`. The
   second is a stable prime with nine elements in its quotient (`stablePrime_nine_sqrt_three`). The table's value at
   71, 95 and 191 is also a term. **Not held at all**: the two finite-field models of
   `ThreeColourCriterion.exists_maximal_card_nine` and `exists_normOne_zero_of_card_ne_nine` (item 698 ruled them a
   sentence), and a stable prime of `K(√7)` for `UpperHalf.two_notMem_stablePrime_seven` (which exists by Chebotarev; the
   docstring says so). One line each would make the first two library `example`s. That is the next module's choice.
4. **Row 52's two values**: the upper halves are in the kernel; `χ ≥ 5` over `K(√5)` and `K(√247)` is stated by no
   declaration (item 720, ruling (c)).
5. **Row 99's last two clauses**, "no mixing" and `χ(ℚ(α,√7)²) = 4`, are not in the kernel; no statement of this line is
   either.
6. **Corrections drafted for older files**, waiting for one sweep (items 702, 708). The joining job drafted three:
   `Instances/SqrtEleven.lean:29` and `:242` ("`[Fischer1990]` Thm 9" should read Thm 10(i), and "not in the kernel" is
   no longer true); `Instances/UpperHalfValues.lean:21`. This landing adds item 1's three docstring lines in
   `SpectralChain.lean`.
7. **The vacuity scan is silent on the line.** It adds 96 declarations and no site, so stage 5's table is the only
   reading of its hypotheses' models. This is the class of module `LEAN.md` § The gate already names (FS131-LU1).
8. **`rests` and the audit's imported count now differ (39 against 38)** by one private helper on Weil's bound. This is
   not a defect; the front page's sentence counts theorems, and draft 8's second line says why the two differ.

## Theorems this phase proved, final

*This job proved no theorem of the library. The gate's pass shows that the 96 declarations of the six modules are [kernel], each with one record. Below is every one with its banner and its axioms as the audit printed them on the gated commit `def7c07f8`, generated by `data/fs131/lj1/lj1_records.py … --lines` from `gate/receipt-axioms-final.log` (`gate/theorem-lines-final.txt`). Whose each theorem is, and its credits, are in its module's docstrings and the claim list. The kernel-checked terms of `data/fs131/lj1/checks.lean` are not library theorems and are not listed here (stages 4 and 5).*

*`Arith/ThreeColourCharacter`*
- `ThreeColour.Winding.exists_box_point` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCharacter.bandSet_nonempty_of_finite` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCharacter.bandSet_three_nonempty_of_proper` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCharacter.bandSet_three_nonempty_zmod_five` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCharacter.exists_character_of_box_point` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCharacter.exists_character_of_properAlong` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCharacter.exists_character_one_two` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCharacter.exists_int_vector_of_forall_neg` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable_unitRing` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCharacter.isClosed_band` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
*`Arith/TorsionExtraction`*
- `TorsionExtraction.chromaticNumber_planeOver_ne_three_of_inv_three_mem` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.coe_inv5` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.colorable_two_iff_fieldBandSet_two_nonempty` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.colorable_two_of_fieldBandSet_three_nonempty` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.colorable_two_of_inv_three_mem` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.exists_torsion_mem_fieldBandSet` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.exists_zmod_hom_of_mem_torsionBy` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.fieldBandSet_three_eq_empty_of_sqrt_mem` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.four_le_chromaticNumber_planeOver_fieldOfRadicands` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.four_le_chromaticNumber_planeOver_of_inv_three_mem` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.four_le_chromaticNumber_planeOver_of_sqrt_mem` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.inv5` — definition; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.inv_natCast_mem_unitRing_of_sqrt_mem` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.inv_three_mem_unitRing_of_sqrt_mem` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.layer_dichotomy` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.layer_step` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.mem_fieldBandSet_two_of_inv_three_mem` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.not_colorable_two_of_sqrt_mem` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.tendsto_layer` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `TorsionExtraction.three_le_chromaticNumber_planeOver_of_sqrt_mem` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
*`Arith/ThreeColourCriterion`*
- `ThreeColourCriterion.coe_conjR` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCriterion.comap_conjR_eq` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCriterion.conjR` — definition; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCriterion.conjR_conjR` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCriterion.conj_mem_unitRing` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCriterion.eq_zero_of_forall_normOne_eq` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCriterion.exists_maximal_card_nine` — theorem; [kernel]; under IMPORTED; axioms: [propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]
- `ThreeColourCriterion.exists_maximal_card_nine_of_colorable_three` — theorem; [kernel]; under IMPORTED; axioms: [propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]
- `ThreeColourCriterion.exists_maximal_conj_trivial` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCriterion.exists_maximal_conj_trivial_of_colorable_two` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCriterion.exists_maximal_of_torsion` — theorem; [kernel]; under IMPORTED; axioms: [propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]
- `ThreeColourCriterion.exists_mul_conj_inv_eq_of_mul_conj_eq_one` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCriterion.exists_normOne_zero_of_card_ne_nine` — theorem; [kernel]; under IMPORTED; axioms: [propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]
- `ThreeColourCriterion.exists_unitSet_mul_conjR_eq` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCriterion.fieldBandSet_two_nonempty_of_conj_trivial` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCriterion.finite_quotient_span_natCast` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeColourCriterion.targetFloor_four_weil` — theorem; [kernel]; under IMPORTED; axioms: [propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]
*`Arith/DyadicQuadratic`*
- `DyadicQuadratic.colorable_four_planeOver_sqrt` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `DyadicQuadratic.colorable_planeOver_of_addMonoidHom` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `DyadicQuadratic.colorable_two_planeOver_sqrt` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `DyadicQuadratic.colorable_two_planeOver_sqrt_of_mod_four` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `DyadicQuadratic.dyadic_shape_one_mod_four` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `DyadicQuadratic.dyadic_shape_three_mod_eight` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `DyadicQuadratic.dyadic_shape_two_mod_four` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `DyadicQuadratic.exists_addMonoidHom_one_mod_four` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `DyadicQuadratic.exists_addMonoidHom_three_mod_eight` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `DyadicQuadratic.exists_addMonoidHom_two_mod_four` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `DyadicQuadratic.exists_int_solution_of_mem_unitVectors` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `DyadicQuadratic.exists_rat_add_mul_sqrt_eq` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `DyadicQuadratic.mod_four_of_squarefree` — theorem; [kernel]; under CLEAN; axioms: [propext, Quot.sound]
*`Arith/ThreeFourColours`*
- `ThreeFourColours.chromaticNumber_planeOver_eq_localBound_of_le_four` — theorem; [kernel]; under IMPORTED; axioms: [propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]
- `ThreeFourColours.chromaticNumber_planeOver_eq_three_iff` — theorem; [kernel]; under IMPORTED; axioms: [propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]
- `ThreeFourColours.chromaticNumber_planeOver_le_three_iff` — theorem; [kernel]; under IMPORTED; axioms: [propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]
- `ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four_of_dyadic` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four_of_seven` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four_of_seven_of_mod` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_three` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_three_of_mod` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_two` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.chromaticNumber_planeOver_sqrt_table` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.chromaticNumber_planeOver_sqrt_three` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.colorable_four_planeOver_sqrt_of_seven` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.colorable_three_of_card_three` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.colorable_three_planeOver_iff` — theorem; [kernel]; under IMPORTED; axioms: [propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]
- `ThreeFourColours.colorable_three_planeOver_sqrt` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.exists_maximal_card_nine_sqrt_three` — theorem; [kernel]; under IMPORTED; axioms: [propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]
- `ThreeFourColours.exists_maximal_card_three_of_card_nine` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.exists_maximal_card_three_of_stablePrime_card_nine` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.exists_maximal_conj_trivial_sqrt_two` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.exists_stablePrime_card_four_sqrt` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.exists_stablePrime_card_nine` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.exists_stablePrime_conj_trivial` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.exists_stablePrime_of_maximal` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.exists_stablePrime_ramified_sqrt` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.exists_unitSet_residue_eq` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.fieldBandSet_three_nonempty_sqrt_three` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.levelTarget_colorable_three_of_card_nine` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.levelTarget_colorable_two_of_ramified` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `ThreeFourColours.localBound_le_chromaticNumber_of_le_four` — theorem; [kernel]; under IMPORTED; axioms: [propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]
- `ThreeFourColours.localBound_le_chromaticNumber_or_four_le` — theorem; [kernel]; under IMPORTED; axioms: [propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]
*`Instances/UpperHalfCorollaries`*
- `UpperHalf.chromaticNumber_planeOver_eq_two_of_localBound_le_two` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.chromaticNumber_planeOver_sqrt_247_le_five` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.chromaticNumber_planeOver_sqrt_five_le_five` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.two_notMem_stablePrime_seven` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
(96 declarations of 96 constants in 6 modules)

## Slips, my own

1. **A count written loosely.** Stage 5's first text said "six models are held as terms only". The true count is three
   hypotheses met by terms only, plus two joint forms whose pieces are library theorems. It was corrected in the record
   before stage 6 was saved; no draft carried it.
2. **A check written against a listing I had not looked at.** `olean_against_lu1.py` first globbed `*.olean*`, which
   also matches the `.olean.hash` files the manifest does not list. A directory listing caught it before its first run;
   the shipped version reads `*.olean` only, as the manifest does.
3. **A docstring edit after the first build.** Stage 5's pointer in `Arith/TorsionExtraction` was made after the first
   build. The lint control's build and then the pass's build compiled it; the text check and the stored-term
   comparison of the pass cover it.

## Stage 9 — SAVED (FS131-LJ1): the green line, and where the branch stands

The gate is green on `def7c07f8` (stage 8), and the coordinator has been told in one line. The branch `fs131-wj1`
holds, above `main` at `3a6f8876b`:
- the six modules (docstring edits in three of them: `ThreeColourCriterion`, `ThreeFourColours`, `TorsionExtraction`);
- their six import lines and six rows of the map;
- the audit block, the two moved controls, the retired sites, the rewritten ledger and the refiled baseline header;
- this record and `data/fs131/lj1/`.

Nothing is pushed: the server is unreachable, and the brief says so. The merge into `main` is the
coordinator's. No background process of this job is running or queued (`scripts/slot.py --status`: no `lj1-` slot).
The drafts are above, with their slots checked on `main` at `3a6f8876b` (21 of 21) and kept as one file,
`data/fs131/lj1/drafts.md`. The next landing's previous receipts are
`data/fs131/lj1/gate/receipt-{axioms,vacuity,assumptions}-final.log`.
