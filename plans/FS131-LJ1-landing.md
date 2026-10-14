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

*Filled at the green line: § "Theorems this phase proved, final". This job proved no theorem of the library.*

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
