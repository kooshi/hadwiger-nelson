# FS124-L1 — the landing: the disc criterion, through the gate and onto `main`

*Record of the landing implementer (de Bruijn, Opus 5.5). Brief: `data/fs124/briefs/FS124-L1-landing.md` on `main` at
`910cb176`. Branch `fs124-wl1`, worktree `.claude/worktrees/fs124-wl1`, cut from `fs124-wk1` at `80ee1983`. Working
files: `data/fs124/l1/`. Tools: `tools/fs124_l1_*.py`; other jobs' tools are run, never edited. The record is written
in stages; each is committed before the next starts.*

## Theorems this phase proved

*The final list, with the gated commit and the axioms as the gate printed them, is at the end of this record
("Theorems this phase proved, final").* This job proves no theorem of its own: it gates and lands FS124-K1's
statements (planner) with FS124-I1's proofs (implementer) — the 57 theorems of `Plane/WeakColouringOn`, `Plane/Radius`
and `Plane/RadiusOutside`, listed one per line with their axioms in `plans/FS124-I1-implementation.md` § Theorems this
phase proved.

## Stage 1 — SAVED (FS124-L1): the readback, what was read, the branch built as given

### The brief's quotations

`tools/fs132_i1_quotes.py` (FS132-I1's checker, run unedited) on the brief, relative sources read under `main`'s
checkout (`--root /home/kooshi/source/lean-dir`, at `910cb176`) and absolute ones as given: **16 quotations, 0
mismatches**, exit 0 (`data/fs124/l1/quotes.out`). By source: `Plane/Radius.lean` 2, `Plane/RadiusOutside.lean` 4,
`Plane/WeakColouringOn.lean` 1 (the three in this worktree), `CLAUDE.md` 4, `LEDGER.md` 1 (row 161, whole),
`plans/FS124-close-inventory.md` 2, `plans/FS132-close-inventory.md` 1, the request file 1. Its self-test plants a
changed word, a wrong source and an empty quotation: each **FIRED**, exit 0 (`data/fs124/l1/quotes-selftest.out`). No
finding about a quotation.

**Two notes on the brief** (neither changes the job):
1. `main` has moved since the brief was written: `1f22daba` → `910cb176` (the brief's own commit) → `20b759b4` at
   16:16 UTC — four commits, `plans/` 4 paths and `data/` 3, nothing else.
2. The brief says the import module "copies ten declarations of the release". The module's own header counts "the
   eight declarations below — the six copied and the two statements"; its docstrings mark seven copied declarations
   (`ProperColoring`, `anglePeriodPositive`, `Angles`, `angularMeasure`, `direction`, the anonymous probability
   instance, `WeakColoring`) and the two axioms' statements. Three counts of one file, by what is counted; the licence
   sentence of stage 4 names no count.

### What was read

Whole: the brief; `plans/STANDING-RULES.md`; `LEAN.md` as on `main` (`910cb176`); `RUNNING.md` § Building and § Make
the gate fail, and watch it fail (to its line 275); the planner's record `plans/FS124-kernel-plan.md` (all five
stages); the implementer's record `plans/FS124-I1-implementation.md` (four stages, twelve drafts); the last landing's
record `plans/FS132-L2-landing.md` (ten stages, its drafts, its slips) and its runner `data/fs132/l2/run-gate.sh`;
inventory items 19 and 24 (`plans/FS124-close-inventory.md`) and 51 (`plans/FS132-close-inventory.md`); the theorem
record's entries C124-RADIUS-GRAPH, -COUNTABLE, -UP, -DOWN, -FIVE and C124-EVERY-DIRECTION
(`plans/FS124-derivation.md` § 1, on `main`); row 161 as the brief quotes it; the three modules of the landing with
every docstring; `CLAUDE.md` § Trust ledger and § The gate **from disk on `main`** (the copy loaded at launch is an
older snapshot: it reads 6533 clean; the disk reads 6910); the header of `Outside/OAI158.lean` (lines 1–90); the
tools this job runs or builds on — `tools/fs132_l2_records.py`, `tools/fs132_l1_records.py`, `tools/fs132_l1_block.py`,
`data/fs132/l2/decls.lean`, `checks.lean`, `run-readback-import.sh`; `scripts/Axioms.lean`'s IMPORTED section on
`main` (lines 156–232).

### The branch as given

`./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`, at `80ee1983`: **exit 0** —
"build: OK — 476 of 476 batches, 4 module(s) rebuilt, 0 module(s) with warnings, 8m51s"; no `declaration uses sorry`
line; the one line of the log holding "warning" is that sentence (`data/fs124/l1/build-0-as-given.log`). The four
rebuilt are the three modules of the landing and the root: the worktree's build is a copy of the last landing's tree,
which holds every other module of this branch and not these.

### The merge, tried before it is made

`git merge-tree --write-tree --name-only` of the branch tip against `origin/main` at `6a721c6a`
(`data/fs124/l1/merge-trial.out`): **exit 1, one conflict — `Proofs.lean`** (each side added import lines after the
same line: `main` the twenty-two of FS-132's landing, the branch its three). `ARCHITECTURE.md` and `scripts/Axioms.lean`
merge automatically. **No conflict in a file under `Proofs/`**, as the brief expected. Since the merge base `596100d4`
`main` changes 23 paths under `Proofs/` (the last landing's modules and its licence copy), `Proofs.lean`, 3 under
`scripts/`, 7 under `tools/`, `ARCHITECTURE.md`, and the files of the coordinator; the branch changes 3 under
`Proofs/`, `Proofs.lean`, `scripts/Axioms.lean`, `ARCHITECTURE.md`, `data/` and `plans/`.

### Built for the later stages (nothing run yet)

`data/fs124/l1/decls.lean` (the kernel's list of the three modules' constants; after FS132-L2's dumper);
`tools/fs124_l1_records.py` (every declaration of the landing in a block, each filed on what it rests on, with
fifteen plants; after FS132-L2's, whose claim was the other kind — no record on an import);
`data/fs124/l1/checks.lean` (the statements as stored, their axioms, the halves proved apart, the models as terms);
`data/fs124/l1/run-readback-import.sh` (FS132-L1's runner as FS132-L2 ran it, the output directory changed);
`data/fs124/l1/run-gate.sh` (the pass, after FS132-L2's runner).

## Stage 2 — SAVED (FS124-L1): `main` merged in

**Tried again on the committed tree** (`data/fs124/l1/merge-trial-2.out`, `f8917640` against `origin/main` at
`98738509`, which had moved once more — FS-136's and the inventory's commits, `plans/` and `data/` only): the same one
conflict, `Proofs.lean`.

**Made**: `git merge --no-ff --no-commit 987385099934894359bc9203dfca0b9c7a582368` (the hash, never the ref;
`data/fs124/l1/merge.out`) — `ARCHITECTURE.md` and `scripts/Axioms.lean` merged automatically; **one conflict,
`Proofs.lean`, resolved by keeping both sides' import lines**: `main`'s twenty-two (the last landing's modules), then
the branch's three. Checked: the resolved file differs from `main`'s by exactly the three added lines and from the
branch's by exactly the twenty-two; 308 import lines, none twice. **No conflict in a file under `Proofs/`.** Merge
commit **`eadcf27b`** (parents `f8917640`, `98738509`).

**The two files git merged by itself, read**: `ARCHITECTURE.md` — `main`'s rows of the last landing stand in § 3.11
and § 3.12, the branch's § 3.13 after them, no heading twice; `scripts/Axioms.lean` — under IMPORTED the branch's five
records follow FS132-I1's ten; under CLEAN the branch's block of 52 follows FS131-L8A's and `main`'s four blocks of the
last landing follow it; 7,010 `#print axioms` lines = `main`'s 6,953 + 57.

**Built** (`data/fs124/l1/build-1-merged.log`): **exit 0** — "build: OK — 480 of 480 batches, 1 module(s) rebuilt, 0
module(s) with warnings, 9m6s" (the root: its import list changed; every other module's compiled file is the one the
last landing's tree or stage 1's build made).

## Stage 3 — SAVED (FS124-L1): the registrations

**What the landing brings, as the kernel lists it** (`data/fs124/l1/decls.lean`, this job's dumper after FS132-L2's;
output `data/fs124/l1/probes/decls-probe.out`): **78 constants in three modules** — `Plane/WeakColouringOn` 50,
`Plane/Radius` 16, `Plane/RadiusOutside` 12; **62 declarations a person typed** — 57 theorems, 4 definitions
(`rigidMotion`, `motionMul`, `monoPairSet`, `AeProperOn`), 1 structure (`IsWeakColouringOn`); the other 16 are the
elaborator's (10 auxiliaries such as `eq_1` and `_simp_`, 6 projections, constructor and recursor).

**The branch's block as merged: 57 records, as the brief counts them** — 52 under CLEAN (FS124-I1's block, after
FS131-L8A's), 5 under IMPORTED (`radius_five` beneath the line naming `no_proper_five_coloring`; the four of (down) and
the join beneath the line naming `proper_to_borel_weak`). **And five more, this job's, a decision of mine**: the four
definitions and the structure were in no block. The last landing's standard is that every declaration a landing brings
has one record, definitions and structures filed with the theorems ("as the port's block files its 24 definitions",
`plans/FS132-L2-landing.md` stage 5), and I hold this landing to it: a block headed "FS124-L1", five records, under
CLEAN, just above the PURCHASED banner. `tools/fs124_l1_records.py … --unfiled`: "declarations the landing brings: 62
(of 78 constants in 3 modules); with one line: 62; unfiled: 0; doubled: 0". **So the counts move by five more than the
brief expects: clean +57, not +52; records +62, not +57** (below). The audit script holds 7,015 `#print axioms` lines
= `main`'s 6,953 + 62.

**The audit on the registered tree** (`./scripts/axioms.sh` under the slot; `data/fs124/l1/probes/axioms-probe.out`):
exit 0 — "axioms: OK — **6967 clean, 20 axiom-free, 23 imported, 5 declared purchase(s)**"; 7,015 records. Against
`main` (6910 clean, 18 imported, 6,953 records): clean +57, imported +5, records +62, nothing else moved; "declared
imports: 3; library axioms other than native auxiliaries: 3, every one declared". The digest reads `CLAUDE.md`
§ Trust ledger as stale ("6910 clean → 6967, 18 imported → 23"), as it must until the front page is refiled.

**Each filed on exactly what it rests on, read from the audit's own output** (`tools/fs124_l1_records.py`, this
job's, on the kernel's list and the audit's saved log; `data/fs124/l1/probes/records-probe.txt`): "records: PASS" —
"landing records on exactly the three: 57" (the 52 theorems and the five definitions), "on the three and
no_proper_five_coloring: 1", "on the three and proper_to_borel_weak: 4"; `radius_up`,
`exists_radius_of_not_colorable`, `colorable_plane_of_forall_aeProperOn_ball`, `radius_graph` and `radius_countable`
each "under CLEAN: [Classical.choice, Quot.sound, propext]"; over the whole log "records carrying kloosterman_bound: 8
(filed: 8)", "no_proper_five_coloring: 6 (filed: 6); of the landing's: 1", "proper_to_borel_weak: 9 (filed: 9); of the
landing's: 4"; "records under IMPORTED 23; carrying two imports 0; carrying sorryAx 0". **Fifteen plants, in memory,
one at a time, every one fired** (`probes/records-plant-probe.txt`): a record dropped; doubled; `sorryAx` under one; a
clean record given the transfer; one given the five-colour theorem; one filed under IMPORTED; one under PURCHASED; a
native auxiliary; **the wrong filing twice — `radius_five` on the transfer for the five-colour theorem, `radius_down`
under CLEAN**; the criterion carrying both imports; **the half that needs no import (`radius_up`) resting on the
transfer**; a theorem with no record; one of `main`'s records stripped of Weil's bound; a module absent from the dump.

**The wrong-filing control, on the audit script itself, on the merged tree** (`data/fs124/l1/wrong-filing-plant.sh`,
the implementer's control run again; `wrong-filing-run.out`, `wrong-filing-plant.log`): `radius_five`'s line and
`radius_up`'s exchanged — **exit 1**, "FAIL stale-import 'HadwigerNelson.Plane.radius_up' carries no declared import:
its record belongs under CLEAN", "FAIL import-in-clean 'HadwigerNelson.Plane.radius_five' carries the declared import
HadwigerNelson.Outside.OAI158.no_proper_five_coloring: move its record under IMPORTED", "2 check(s) failed"; the file
put back under a trap, "RESTORED: the audit script is the text it was" (digest `a5823c9f…` before and after). **And
this job's tool, on that planted run's real log** (`probes/records-on-wrong-filing-log.txt`; the log compressed beside
it): exit 1, four failures naming the two records — IMPORT-RECORD, NOT-CLEAN-SECTION, HALF, IMPORTED-SET.

**The import's own block with its two controls** (`tools/fs132_l1_block.py`, FS132-L1's, unedited, on the import's
module as it now stands; `probes/block-probe.txt`): "records filed: 22 as filed: 22 (clean 12, on H 5, on T 5)"; the
wrong filing refused exactly `six_le_chiM0`, `chiM0_six_or_seven`, `seven_le_chromaticNumber_plane_iff`, "CONTROL FIRED
AS EXPECTED"; the planted `sorry` refused eleven; each read as a plain check exits 1; "block: PASS".

**The prose of the audit script's IMPORTED section**, where a count is said: "with five and five (the fifth on the
transfer is FS132-L1's)" now reads "with six and nine (the fifth on the transfer is FS132-L1's; one on the first and
four on the transfer are of FS-124's radius clause, `Plane/RadiusOutside`, FS124-I1, landed by FS124-L1)".

**`ARCHITECTURE.md`.** § 3.13's opening paragraph said "A skeleton on branch `fs124-wk1` … 49 of the 57 leaves are a
`sorry`": on `main` that is false twice, and it now says what lands — whose the statements and the proofs are, 57
theorems and no `sorry`, the row, and which records rest on what. The three rows read "planned by FS124-K1, proved by
FS124-I1" and carry row 161 in their Row column. § 5 Trust: the third column of the two rows of `Outside/OAI158`'s
axioms names the new records — `Plane.radius_five` on `no_proper_five_coloring` (six records), and
`Plane.exists_isWeakColouringOn_of_colorable`, `Plane.radius_down`, `Plane.colorable_iff_forall_ball`,
`Plane.seven_le_chromaticNumber_plane_iff_exists_ball` on `proper_to_borel_weak` (nine).
`tools/check_architecture.py`: exit 0, "RESULT: PASS" (`probes/arch-probe.out`). Its item [7] lists, without
failing, `('Plane/Radius', 161)` among the rows whose text names neither the module nor an identifier of its
description: row 161 as filed names the claims (C124-RADIUS-GRAPH …) and the two join theorems, not `radius_graph`
or `radius_up`; draft 7 below names them.

**The doubled-name check** (`./scripts/dupnames.sh` under the slot, after the build and before the audit;
`probes/dupnames-probe.out`): exit 0, "dupnames: OK — no name is declared by two modules (24 generated on demand,
listed above)". None of the landing's names meets one of the last landing's: the join of the two lines made no
doubled name.

**No docstring and no header of the three modules is changed**: each was read whole at stage 1 and says nothing that
the landing makes false (no "`sorry`", no branch name; every `Inhabitant` note names a theorem that exists and
satisfies the hypotheses it is named for — stage 6).

## Stage 4 — SAVED (FS124-L1): the import module's licence sentence

One paragraph of one sentence added to the module docstring of `Proofs/HadwigerNelson/Outside/OAI158.lean`, after the
paragraph "Why axioms, and what was checked" — **nothing else in the file changes** (`git diff`: four lines added,
none removed):

> **Licence.** The release is published under the Apache License, Version 2.0, and the declarations copied from it
> below are used under that licence: a byte-identical copy of its `LICENSE` file is beside this module,
> `Proofs/HadwigerNelson/Outside/OAIMath2026-LICENSE.txt`.

The copy is the release's file byte for byte (sha256 `c71d239d…` for both; and `tools/fs132_i2_port.py --check`:
"OK: OAIMath2026-LICENSE.txt is the release's LICENSE byte for byte, 11357 bytes", "CHECK OK",
`probes/port-check-probe.out`).

**Built** (`data/fs124/l1/build-2-registrations.log`): **exit 0** — "build: OK — 480 of 480 batches, 25 module(s)
rebuilt, 0 module(s) with warnings, 10m19s": a docstring is environment data, so the import's module and everything
downstream of it recompiled — the nine ported modules, the thirteen of `Plane/SixRing`, `Plane/RadiusOutside`, the
root. The module's compiled file: `0f3b15f3…` before (the one FS132-L1 gated and FS132-L2 left), `f763d277…` after
(`data/fs124/l1/OAI158-digests-before.txt`; the read-back's summary).

**The stored-term comparison, again, on the module as recompiled** (`tools/fs132_i1_readback.py`, driven by
FS132-L1's runner with its output directory changed — `data/fs124/l1/run-readback-import.sh`; summary
`data/fs124/l1/readback-import-joined.txt`, prints under `readback-import/`): every step as expected; the release's
print made again at its pin equals the import's committed print; **the recompiled module's print equals the import's
own print**; "declarations: 8 compared: 8 identical: 8 different: 0", "READ-BACK IDENTICAL: all 8 declarations, term
for term, modulo the namespace"; "SELF-TEST OK … 6 plants"; the Lean control "FIRED AS EXPECTED" on the six altered
declarations and refused when read as a plain comparison; level one, no constant absent; the nine characterisations
elaborate with no message; 0 files written at the release's side. "READ-BACK RUN joined: OK". **The eight
declarations are untouched.**

## Stage 5 — SAVED (FS124-L1): what the library assumes

`./scripts/assumptions.sh --self-test` first (`data/fs124/l1/probes/assumptions-selftest-first.out`): exit 0, "OK —
all 33 checks behaved: every planted fault fired, and every partner stayed silent". Then the step
(`probes/assumptions-first.out`): **exit 1, five failures, one kind, every one read** — the five the implementer
measured and no other:

```
FAIL unlisted-consumer HadwigerNelson.Plane.radius_five :: the scan finds 'RESTS HadwigerNelson.Outside.OAI158.no_proper_five_coloring HadwigerNelson.Plane.radius_five' and the ledger does not list it
FAIL unlisted-consumer HadwigerNelson.Plane.colorable_iff_forall_ball :: the scan finds 'RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Plane.colorable_iff_forall_ball' and the ledger does not list it
FAIL unlisted-consumer HadwigerNelson.Plane.exists_isWeakColouringOn_of_colorable :: the scan finds 'RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Plane.exists_isWeakColouringOn_of_colorable' and the ledger does not list it
FAIL unlisted-consumer HadwigerNelson.Plane.radius_down :: the scan finds 'RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Plane.radius_down' and the ledger does not list it
FAIL unlisted-consumer HadwigerNelson.Plane.seven_le_chromaticNumber_plane_iff_exists_ball :: the scan finds 'RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Plane.seven_le_chromaticNumber_plane_iff_exists_ball' and the ledger does not list it
```

Each is a theorem whose stored axiom list holds a declared outside theorem and that the ledger did not yet list: each
is conditional on that import, as its docstring says. **The definition's conditions ask no declaration**: neither
`AeProperOn` nor `IsWeakColouringOn` is read as an undeclared former (each is concluded by theorems that take no
assumption — `aeProperOn_of_proper`, `AeColouring.isWeakColouringOn`), and no hypothesis of the 57 statements is
closed (`closed=1473`, `main`'s count). **`scripts/Assumptions.lean`: no line added** (0 lines differ from `main`'s).

`./scripts/assumptions.sh --write-ledger` (`probes/assumptions-write-ledger.out`): exit 0, "ledger written (122
rows)". **Every row the ledger gains** (`git diff scripts/assumptions-ledger.txt`: five rows added, none removed, and
the header's count line):

```
RESTS HadwigerNelson.Outside.OAI158.no_proper_five_coloring HadwigerNelson.Plane.radius_five
RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Plane.colorable_iff_forall_ball
RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Plane.exists_isWeakColouringOn_of_colorable
RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Plane.radius_down
RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Plane.seven_le_chromaticNumber_plane_iff_exists_ball
```

After it (`probes/assumptions-second.out`): **exit 0** — "assumptions: OK — 3 outside theorem(s) as axioms, with 23
theorem(s) resting on them; 19 named and 16 inline hypotheses (7 outside, 23 ours, 5 open), taken by 98 statement(s)
and mentioned by 1".

| | `main` (FS132-L2's gated scan) | this tree |
|---|---|---|
| `scanned` | constants=14516 theorems=10782 formers=338 hypotheses=18802 closed=1473 | constants=14582 theorems=10843 formers=340 hypotheses=18856 closed=1473 |
| the nine | axioms=3 **rests=18** named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1 | axioms=3 **rests=23** named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1 |
| the rest | conditions=38 … silent=1 cohyp=58 hints=0 unseen=16765 fails=0 | conditions=38 … silent=1 cohyp=58 hints=0 unseen=16817 fails=0 |

One of the nine moves: `rests`, 18 → 23. The ledger's header reads "match (9 of 9 compared)"; `CLAUDE.md` § Trust
ledger reads stale on that one count ("rests 18 → 23") — flagged, not failed, until refiled (draft 2).

## Stage 6 — SAVED (FS124-L1): the vacuity step

`./scripts/vacuity.sh` (`data/fs124/l1/probes/vacuity-probe.out`): **exit 0, "vacuity: OK"**.

| | `main` (FS132-L2's gated scan) | this tree |
|---|---|---|
| declarations | 15292 | **15370** (+78: the landing's 78 constants, the dump's own count) |
| refutations-skipped | 226 | 226 |
| sites | 1447 | **1448** (+1) |
| vacuous / stale / declared / witnessed / generic / unknown | 0 / 0 / 3 / 38 / 1404 / 2 | 0 / 0 / 3 / 38 / **1405** / 2 |

**How the scan classes every new site: there is one, and it is GENERIC** —
`SITE GENERIC HadwigerNelson.Plane.AeColouring.isWeakColouringOn :: HadwigerNelson.Plane.AeColouring k`: a binder
over this library's bundled colourings of the plane at a free number of labels, where no inhabitant witness can
exist for every `k` (it is inhabited at seven and nine: `r7_aeColouring`, `sq9`). Nothing reads `VACUOUS`, `STALE` or
`UNKNOWN`; the baseline's two entries are as on `main`; no statement of the three modules concludes `False`, so none
is skipped as a refutation. `scripts/vacuity-baseline.txt`: its header's two count lines, from `scripts/gate_report.py
header` on this scan; no entry touched.

**The scan is silent on every other hypothesis of the landing**, as the last landing found of its own: the
colourings here are maps `c : ℂ → Fin k` under the predicate `IsWeakColouringOn U c` (or `AeProperOn U c`), which the
scan does not track. Silence is not evidence. **The model of each hypothesis, by hand**, and whether the kernel holds
it — "library" is a theorem or an `example` of a module, checked in the build; "term" is a theorem of the iteration
file `data/fs124/l1/checks.lean`, kernel-checked when the gate's pass elaborates it, and not a library theorem
(`probes/checks-probe.out`; every term on the standard three unless said):

| statement | its hypotheses | the model | held |
|---|---|---|---|
| `AeProperOn U c` (the definition; the hypothesis of every core lemma) | the monochromatic unit pairs inside `U` are null | R7 on every set, `exists_isWeakColouringOn_seven`. The degenerate model, where the clause asks nothing: any map on the disc of radius `1/2` (an `example`). **Not always true**: one colour on the disc of radius `2` is not (`example`, through `not_unitPairsNull_ball_two`) | library |
| `radius_graph`, `radius_countable` | `U` open; `c` a weak colouring of `U`; `V` finite (countable with compact closure) inside `U` | every hypothesis at once at `U = univ`, `c` = R7, `V = {0, 1}` — a set **with a unit pair**, so the clause on pairs at distance 1 is exercised: the two `example`s of `Plane/Radius` run the theorems there. At `univ` the clause "the motion carries `V` into `U`" asks nothing; **on a bounded set**, the open disc of radius 2 (`U ≠ univ`), the same `c` and `V`: `FS124L1.model_graph` | library at `univ`; term at the disc |
| `radius_up` | for every `R > 0` a weak `k`-colouring of the disc of radius `R` about `0` | **`k = 7`**: R7 (`FS124L1.model_up`; the module's `example` runs the theorem there and gets `χ(ℝ²) ≤ 7`). **`k = 6`: whether it holds is the Hadwiger–Nelson problem** — it holds exactly when `χ(ℝ²) ≤ 6` (`colorable_iff_forall_ball`; the docstring says "an open question"). **`k = 5`: empty given the declared outside theorem** `no_proper_five_coloring` (`radius_five`; `FS124L1.up_hypothesis_five_empty`, on that import) — the docstring says so, naming `radius_five`. `k ≤ 4`: empty with no import (`exists_radius_no_weak_four`) | library at seven; term at five |
| `radius_down` | `χ(ℝ²) ≤ k` | `k = 7`: `chromaticNumber_plane_interval` (row 33); the module's `example` runs the theorem there. `k = 6` open; `k ≤ 5` false given `no_proper_five_coloring`, `k ≤ 4` false with no import | library |
| `radius_five` | none | — (an existence; false at seven colours, the module's adversary `example`; true at four with no import, `exists_radius_no_weak_four`) | library |
| `colorable_iff_forall_ball` | none (an equivalence at a free `k`) | **both sides true at `k = 7`** (`FS124L1.join_seven`) and **both false at `k = 4`** (`FS124L1.join_four`), each with no import: the equivalence is not one between two statements of one fixed truth value | terms |
| `seven_le_chromaticNumber_plane_iff_exists_ball` | none (a closed equivalence) | its truth value on each side is the open problem. One colour up both sides are false with no import (`FS124L1.criterion_at_seven`); one colour down both are true on `no_proper_five_coloring` (`FS124L1.criterion_at_five`) | terms |
| `exists_radius_of_not_colorable` (the half toward a disc) | the plane has no proper `k`-colouring | `k = 4`: `isEmpty_coloring_plane_four` (rung B), as the docstring says; at `k = 5` on the import; at `k = 6` open | library |

**An import empties a carrier of this landing's own, and the docstrings say so**: given `radius_five`, a weak
five-colouring of a large disc does not exist, so `radius_up`, `radius_graph` and `radius_countable` read at `k = 5`
on a large open set assume nothing; each is stated at a free `k`, `radius_up`'s docstring names the import and the
theorem, and no `IsEmpty` statement or marker rests on the import (`LEAN.md` § The gate). **No older statement is
emptied by this landing**: `IsWeakColouringOn` and `AeProperOn` are new with it, and it brings no axiom.

## Stage 7 — SAVED (FS124-L1): read aloud — the definition and the theorems against the row's sentences and the entries' statements

*The statements are read as the kernel holds them (`data/fs124/l1/gate/checks-final.out`, from
`data/fs124/l1/checks.lean`: `#print` of each definition, `#check @…` of each theorem with every binder's type shown,
`#print axioms` of each), never as the files print them. The row is `LEDGER.md` row 161; the entries are
`plans/FS124-derivation.md` § 1.*

**The definition the statements name.** `IsWeakColouringOn U c`, for `U : Set ℂ` and `c : ℂ → Fin k`, is two
clauses: `Measurable c`, and `AeProperOn U c` — `(volume.prod arcLength) {q : ℂ × ℝ | q.1 ∈ U ∧ q.1 + e q.2 ∈ U ∧
c q.1 = c (q.1 + e q.2)} = 0`, where `e θ = exp (θ i)` and `arcLength` is Lebesgue measure on the line restricted to
`[0, 2π)`. Aloud: *a function from the whole plane to `k` labels, Borel measurable, such that the pairs (a point, an
angle) whose two ends — the point, and the point moved one unit in the direction of the angle — both lie in `U` and
carry one label form a set of measure zero, for plane measure times arc length.* Against the claim list's words — "a
measurable map `c` from `U` to `k` labels with `c(z) ≠ c(z + u)` for almost every pair of a point `z` of `U` and a
unit vector `u` with `z + u` in `U`": the second clause is those words (`aeProperOn_iff_ae` states it as "for almost
every `(z, θ)`: `z ∈ U → z + e θ ∈ U → c z ≠ c (z + e θ)`"); the first differs in two things, both said in the module
header — the map is total and read on `U` alone (`aeProperOn_congr`), which for a measurable `U` and `k ≥ 1` is the
same notion as a measurable map on `U` itself (`exists_isWeakColouringOn_iff_subtype`), and "measurable" is Borel
measurability.

**1. `radius_up` — C124-RADIUS-UP (the row's second quoted sentence).**

| the row's clause | the Lean statement | verdict |
|---|---|---|
| "For every integer k ≥ 1" | `∀ {k : ℕ}` | every natural `k`; at `k = 0` no `c : ℂ → Fin 0` exists, the hypothesis fails and nothing is said: the claim's range is all the statement speaks of |
| "if for every R > 0 the open disc of radius R about the origin has a weak measurable k-colouring" | `(∀ R > (0 : ℝ), ∃ (c : ℂ → Fin k), IsWeakColouringOn (Metric.ball (0 : ℂ) R) c) →` | the same; "measurable" is Borel |
| "then every finite unit-distance graph in the plane has a proper k-colouring" | `(∀ (V : Set ℂ), V.Finite → (SimpleGraph.induce V (unitDistance ℂ)).Colorable k)` | the graph on a finite set of points with **every** unit pair an edge is `k`-colourable; a finite unit-distance graph drawn on those points is a subgraph of it |
| "and χ(ℝ²) ≤ k" | `∧ (unitDistance ℂ).chromaticNumber ≤ ↑k` | the same; `chromaticNumber_plane_eq_complex` equates this number with row 33's over `EuclideanSpace ℝ (Fin 2)` |

Aloud: *if discs about the origin of every radius can each be coloured with `k` labels, Borel measurably, so that
almost every unit pair inside the disc gets two labels, then every finite set of points of the plane can be properly
`k`-coloured, and so can the plane.* **The row's sentence.** Axioms, as the audit prints the record: `[propext,
Classical.choice, Quot.sound]`, under CLEAN. Not said, as the row's "Not claimed" asks: no radius, nothing at
`k = 6` about the hypothesis.

**2. `radius_down` — C124-RADIUS-DOWN (the row's third).** "For every integer k ≥ 1: if χ(ℝ²) ≤ k, every open set of
the plane has a weak measurable k-colouring." — `∀ {k : ℕ}, (unitDistance ℂ).chromaticNumber ≤ ↑k → ∀ (U : Set ℂ),
IsOpen U → ∃ (c : ℂ → Fin k), IsWeakColouringOn U c`. Word for word; `k ≥ 1` is no hypothesis because `χ(ℝ²) ≤ 0` is
false; the colouring obtained is Borel. Aloud: *if the plane can be properly coloured with `k` colours — no
regularity asked — then every open set has a Borel `k`-colouring under which almost every unit pair inside the set
gets two labels.* **The row's sentence.** Axioms: the standard three and
`HadwigerNelson.Outside.OAI158.proper_to_borel_weak`, under IMPORTED — and the row says so ("over the declared outside
theorem"; not claimed: "anything without that import").

**3. `radius_five` — C124-RADIUS-FIVE (the row's fifth).** "There is R > 0 such that no open disc of radius R has a
weak measurable five-colouring." — `∃ R > (0 : ℝ), ∀ (p : ℂ), ¬∃ (c : ℂ → Fin 5), IsWeakColouringOn (Metric.ball p R)
c`. "No open disc of radius R" is every centre `p`. **The row's sentence.** Axioms: the standard three and
`HadwigerNelson.Outside.OAI158.no_proper_five_coloring`, under IMPORTED. No value of `R`, as the row says.

**4. `colorable_iff_forall_ball` — the row's "So at each `k` the two hold together or fail together".**
`∀ {k : ℕ}, (unitDistance ℂ).Colorable k ↔ ∀ R > (0 : ℝ), ∃ (c : ℂ → Fin k), IsWeakColouringOn (Metric.ball (0 : ℂ) R)
c`. Aloud: *for every `k`, the plane has a proper `k`-colouring exactly when the disc about the origin of every
radius has a weak `k`-colouring.* The left side is `χ(ℝ²) ≤ k` (`SimpleGraph.chromaticNumber_le_iff_colorable`); the
right side is "every open disc has one", the discs about the origin standing for all by translation
(`exists_isWeakColouringOn_ball_iff`). **The row's sentence.** Axioms: the standard three and `proper_to_borel_weak`.

**5. `seven_le_chromaticNumber_plane_iff_exists_ball` — the row's "at six, with row 33, the plane needs seven colours
precisely if some open disc has no weak measurable six-colouring".** `(7 : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber ↔
∃ R > (0 : ℝ), ¬∃ (c : ℂ → Fin 6), IsWeakColouringOn (Metric.ball (0 : ℂ) R) c`. No binder, no hypothesis. Aloud: *the
plane's unit-distance graph needs at least seven colours exactly when there is a radius such that no Borel map from
the plane to six labels gives two labels to almost every unit pair inside the open disc of that radius about the
origin.* The row's wording differs in two harmless places, and each is closed by a term of the checks file on the
same axioms: "needs seven colours" is `χ(ℝ²) = 7`, which with row 33's `χ(ℝ²) ≤ 7` is `7 ≤ χ(ℝ²)`; "some open disc"
is a disc at any centre. `FS124L1.eq_seven_iff_exists_disc : (unitDistance ℂ).chromaticNumber = 7 ↔ ∃ (p : ℂ) (R : ℝ),
0 < R ∧ ¬ ∃ c : ℂ → Fin 6, IsWeakColouringOn (ball p R) c` — **the row's sentence, as worded** — is the landed
theorem with `chromaticNumber_plane_interval` and the translation lemma. Axioms: the standard three and
`proper_to_borel_weak`; `no_proper_five_coloring` is not among them.

**6. `radius_graph` — C124-RADIUS-GRAPH (the row's first quoted sentence).**

| the row's clause | the Lean statement | verdict |
|---|---|---|
| "Let k ≥ 1, U an open set of the plane, c a weak k-colouring of U, and V a finite subset of U" | `{k : ℕ} {U : Set ℂ} {c : ℂ → Fin k}`, `IsOpen U →`, `IsWeakColouringOn U c →`, `{V : Set ℂ}`, `V.Finite →`, `V ⊆ U →` | the same |
| "Then the rigid motions g with g(V) ⊂ U form a non-empty open set" | `(IsOpen {q : ℂ × ℝ \| Set.MapsTo (rigidMotion q) V U} ∧ {q : ℂ × ℝ \| Set.MapsTo (rigidMotion q) V U}.Nonempty)` | **in parameters**: the motion with parameter `q = (x, θ)` is `z ↦ x + e θ * z`, and the set of parameters is open in `ℂ × ℝ` and non-empty |
| "and for almost every one of them the points g(v), g(v′) have different labels for every two points v, v′ of V at distance 1" | `(∀ᵐ (q : ℂ × ℝ) ∂volume.prod arcLength, Set.MapsTo (rigidMotion q) V U → ∀ v ∈ V, ∀ w ∈ V, dist v w = 1 → c (rigidMotion q v) ≠ c (rigidMotion q w))` | the same: almost every motion, each counted once (its angle in `[0, 2π)`), if it carries `V` into `U`, separates every unit pair of `V` — "almost every motion in that open set", as the entry's hand-off asks, not "some motion" |
| "so the unit-distance graph on V has a proper k-colouring" | `(SimpleGraph.induce V (unitDistance ℂ)).Colorable k` | the same |

Axioms: the standard three. **`radius_countable` — C124-RADIUS-COUNTABLE** (the row: "for a countable set with
compact closure in the open set"): "the unit-distance graph on V has a proper k-colouring of the form v ↦ c(g(v)) for
a rigid motion g with g(V) ⊂ U" is `∃ (q : ℂ × ℝ), Set.MapsTo (rigidMotion q) V U ∧ ∀ v ∈ V, ∀ w ∈ V, dist v w = 1 →
c (rigidMotion q v) ≠ c (rigidMotion q w)` under `V.Countable`, `IsCompact (closure V)`, `closure V ⊆ U`. The
standard three.

**Which entry is read back by which theorem, and the wider form under it** (the module states the cores for any
function proper at almost every unit pair, and the entries' words as corollaries):

| entry | its read-back | the core it is a corollary of |
|---|---|---|
| C124-RADIUS-GRAPH | `radius_graph` | `AeProperOn.ae_rigidMotion` (any function, a countable `V` anywhere, every real angle), `isOpen_setOf_mapsTo_rigidMotion`, `AeProperOn.colorable_induce` |
| C124-RADIUS-COUNTABLE | `radius_countable` | `AeProperOn.exists_rigidMotion` |
| C124-RADIUS-UP | `radius_up` | `colorable_plane_of_forall_aeProperOn_ball` (discs at any centres, any function); its contrapositive `exists_radius_of_not_colorable` |
| C124-RADIUS-DOWN | `radius_down` | `exists_isWeakColouringOn_of_colorable` (one colouring for every set, open or not) |
| C124-RADIUS-FIVE | `radius_five` | `exists_radius_of_not_colorable` at `Outside.OAI158.not_colorable_five` (no map at all, at any centre) |
| C124-EVERY-DIRECTION | **none** | not stated in this module (below) |
| the disc criterion (the entry C124-RADIUS-DOWN's hand-off; the row's "So …") | `colorable_iff_forall_ball`, `seven_le_chromaticNumber_plane_iff_exists_ball` | `radius_up` and `radius_down` |

### Which half of the criterion rests on the outside theorem, and which on the standard three alone

- **Toward six — the standard three alone.** *Weak colourings of every disc colour the plane*: **`radius_up`**, under
  CLEAN, `[propext, Classical.choice, Quot.sound]`. Its contrapositive, *if the plane needs seven colours then some
  disc has no weak six-colouring*, is `exists_radius_of_not_colorable` at `k = 6`, under CLEAN on the same three —
  and says more: at that radius no disc at any centre has even a non-measurable six-colouring proper at almost every
  unit pair.
- **Toward seven — on the declared outside theorem.** *A disc with no weak six-colouring gives seven*: the
  contrapositive of **`radius_down`**, under IMPORTED on the standard three and
  `Outside.OAI158.proper_to_borel_weak` (`[OAIMath2026]` family 158, the transfer of colourability).

The two theorems that say so are `radius_up` and `radius_down`, each a record of the gate's audit under the banner
named. And each half of each join theorem is proved apart in the checks file, from the lemma the join theorem's
docstring names, and printed: `FS124L1.colorable_of_forall_ball` and `FS124L1.exists_ball_of_seven_le` — the
standard three; `FS124L1.forall_ball_of_colorable` and `FS124L1.seven_le_of_exists_ball` — the standard three and
`proper_to_borel_weak`. **So an exclusion on one disc reaches `χ(ℝ²) = 7` only through the release's transfer; weak
six-colourings of every disc reach `χ(ℝ²) ≤ 6` on this library's own three axioms.** That the half toward seven
*needs* the import is a fact about this proof, not a theorem: the kernel says what a proof uses, never what every
proof must.

### What the Lean statements do not say that the row does — and what they say that it does not

1. **C124-EVERY-DIRECTION has no Lean theorem.** The row's last quoted sentence — "Let U be a measurable subset of
   the plane and c a measurable map … Then for every unit vector u, c(z) ≠ c(z + u) for almost every point z of U
   with z + u in U" — is not stated in the three modules (the planner's decision, its record § 4.2: no entry uses it,
   and its proof needs a lemma the release's port brings). It stays [hand], one mind.
2. **"Measurable" is Borel measurability of a total function.** Every statement asks or delivers `Measurable c` for
   `c : ℂ → Fin k`. The criterion does not depend on the reading: `FS124L1.seven_le_iff_no_aeProperOn : 7 ≤ χ(ℝ²) ↔ ∃
   R > 0, ¬ ∃ c : ℂ → Fin 6, AeProperOn (ball 0 R) c` (a term, on the standard three and `proper_to_borel_weak`) —
   the same equivalence with **no** measurability asked, hence with every class of maps between the Borel ones and
   all of them, the Lebesgue measurable ones among them. (up) is likewise proved for any function
   (`colorable_plane_of_forall_aeProperOn_ball`); (down) delivers a Borel colouring, the strongest reading.
3. **"The rigid motions … form a non-empty open set" is a statement about parameters.** `rigidMotion (x, θ)` is
   `z ↦ x + e θ * z`; that these are all the orientation-preserving isometries of the plane, and that a set of
   motions is open exactly when its set of parameters is, are the standard facts and are "not proved here" (the
   module header). No conclusion uses them: the colouring of `V` is `v ↦ c (rigidMotion q v)`, and each
   `rigidMotion q` preserves distances (`dist_rigidMotion`). Nor is it a clause of the Lean statement that the open
   set of motions has positive measure for `volume ⊗ arcLength`; it follows from the first conjunct (an open set of
   parameters holding `(0, 0)` holds `(x, θ)` for small `x` and small `θ ≥ 0`), and the proof of the third conjunct
   uses the positivity it needs (`AeProperOn.exists_rigidMotion`, for Lebesgue measure on all angles).
4. **"About the origin."** The two join theorems and `radius_up` speak of discs about `0`; the row's "some open disc"
   and "every open disc" are discs at any centre — `exists_isWeakColouringOn_ball_iff`, a theorem on the standard
   three, and the term of item 5 above.
5. **More than the row says** (the planner's generalizations, the module's and not entries): measurability idle in
   GRAPH, COUNTABLE and UP; GRAPH's almost-every clause for a countable set anywhere; (down) for every subset; (up)
   and (five) at any centres; (five)'s sentence at four colours with no import (`exists_radius_no_weak_four`).
6. Nothing else: the row's "Not claimed" lines are true of the Lean statements — no explicit radius at any `k`;
   nothing on whether the hypothesis holds at `k = 6`; (down) not without the import; no value of `R` in (five).

## Stage 8 — SAVED (FS124-L1): the lint's control, and the first full pass — red at one check, repaired

**Before the pass, the lint's negative control** (`data/fs124/l1/lint-plant.sh`, FS132-L1's script as FS132-L2 ran
it, pointed at a module of this landing; `lint-plant-run.out`): `theorem zz_l1_lint_plant [Nonempty ℕ] : (1 : ℕ) = 1 :=
rfl` planted at the end of `Plane/RadiusOutside.lean` (never committed), built — "480 of 480 batches, 2 module(s)
rebuilt, **0 module(s) with warnings**, 9m30s" (`lint-plant-build.log`: the build's own linters do not see it) — then
the guarded lint: **exit 1**, "`unusedArguments`: (2/2) Failed with 1 messages", "error: @zz_l1_lint_plant 1 unused
argument", and `synTaut` on the same plant (`lint-plant.log`). Restored by `git checkout` under a trap: the digest is
the one taken before (`94b537c5…`), the plant's name in the file 0 times; the pass's build recompiled the module and
the root from the restored text.

**The first full pass** (`data/fs124/l1/run-gate.sh`, after FS132-L2's runner, launched from a snapshot copy; on
commit `97504e17`, no tracked file modified before or after; 16:58Z–17:19Z; its logs are kept under
`data/fs124/l1/gate/` with the tag `pass1`, the bulky receipts dropped but the red one, compressed): **every step exit
0 but two — the scan difference's plants, which must exit 1, and `./scripts/axioms.sh --self-test`: exit 1, "FAIL — 2
of 23 control(s) did not behave as designed"** (`axioms-selftest-pass1.log`):

```
FAIL  baseline — passed; expected COUNTS imported=18 digest 'old': expected exit 0 and 'the sentence is in its older form, which records no imported count, and the audit has 18 imported', got exit 0
        got: COUNTS clean=6967 free=20 imported=23 purchased=5 declared=3 library=3 native=10 records=7015
FAIL  imported_declared — passed; expected COUNTS imported=19 digest 'old': expected exit 0 and 'the sentence is in its older form, which records no imported count, and the audit has 19 imported', got exit 0
        got: COUNTS clean=6967 free=20 imported=24 purchased=5 declared=4 library=4 native=10 records=7016
```

**The mechanism, and why the repair is not a tuning.** These two of the twenty-three controls are the ones that read
the library's state: each plants nothing false (both "passed") and asserts the count of IMPORTED records the audit
then prints — eighteen, and eighteen plus its one planted record. This landing files five more records under
IMPORTED, so the true count is twenty-three; the other twenty-one controls, which plant faults, all fired. The
controls file says of exactly these two that a landing moves them ("The `baseline` and `imported_declared` counts …
read the library's state"), FS131-I2n, FS131-L10B and FS132-L1 each moved them at their landings by that rule, and
the brief names the file among my touches "if a control's expected count moves with your state". **The edit**
(`scripts/axioms-controls.txt`): `imported=18` → `23` and its digest text; `imported=19` → `24` and its digest text;
the header's sentence on the state ("with five each: eighteen IMPORTED records" → "with six and nine … twenty-three
IMPORTED records") and its rule, which now names this case — a later record resting on a declared import moves
`imported`, with no import declared. No control is added, removed or weakened; `declared=3`/`4` and `library=3`/`4`
stand. After it (`probes/axioms-selftest-after-controls.out`): **exit 0**, "axioms self-test: OK — every planted
fault fired, and every partner passed." *A slip of mine*: the implementer's record said it had run no `--self-test`,
the brief named this file, and I did not run the audit's self-test among stage 3's probes; it cost one pass of twenty
minutes.

Every other step of the first pass read as the final pass reads (stage 9); nothing else was changed between the two
but this file, this record and the logs.

## Stage 9 — SAVED (FS124-L1): the full gate on one commit — `24a42aa9`

**`main` merged in once more before the pass** (`data/fs124/l1/merge-trial-3.out`, `merge-3.out`): `main` had moved
to `ac7dee7b`, twenty commits past the commit merged at stage 2 — `data/` 34 paths, `plans/` 8, `BIBLIOGRAPHY.md`,
`LEAN.md`, **0 paths outside `plans/`, `data/`, `.claude/`, `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`, `RUNNING.md`**;
merged by hash, automatic (`6286ada7`), so that the commit the gate reads already holds it. Between the first pass's
commit `97504e17` and the gated commit `24a42aa9`, `git diff --stat … -- Proofs Proofs.lean ARCHITECTURE.md
lakefile.toml lean-toolchain lake-manifest.json CLAUDE.md tools` is empty and under `scripts/` one file differs, the
controls file of stage 8.

One pass is every step in order, one at a time under the slot (`data/fs124/l1/run-gate.sh final`, launched from a
snapshot copy; every log under `data/fs124/l1/gate/` with its exit status on its last line; `run-gate-final.head`
records the commit and that no tracked file was modified at its start; `run-pass-final.out` holds every step's exit;
17:22Z–17:35Z). **Every step exit 0 but the one planted control that must exit 1** (the scan difference's plants).
Counts below are read from the saved logs, not from the runner's summary. It is the **second** full pass of this job;
the first was red at one check (stage 8). *A slip of mine in this pass, said once*: the runner's last line reads
"tracked files modified after the pass: 1" — while the pass ran I set the executable bit on
`data/fs124/l1/drafts-slots.py`, a script of this job that was already committed (`git diff`: "old mode 100644, new
mode 100755", no line of content). No step of the gate reads that file; the bit is put back and the tree is the
commit's again (0 tracked files modified, checked before and after the `sorry` plant below).

| step | result, read from its saved log (`data/fs124/l1/gate/`, tag `final`) | log |
|---|---|---|
| build | "build: OK — all 1869 modules already up to date, nothing built, **0 module(s) with warnings**, 3s" — Lake finds every module's compiled file current for the committed sources; they are the files the first pass's build made ("480 of 480 batches, 2 module(s) rebuilt, 0 module(s) with warnings, 9m28s", `build-pass1.log`, after the lint control's restore) and no Lean source differs between the two commits. Lines holding "warning" in the build log: 1, that sentence; in Lake's full log: 0 | `build-final.log`, `receipt-build-final.log` |
| `sorry` | narrow pattern (`^\s*sorry\s*$`, `:= sorry`, `by sorry`) over `Proofs/` and `Proofs.lean`: **0** lines; `\bsorry\b`: 24, all prose, `main`'s count (the three modules hold the word nowhere). **The plant** (`data/fs124/l1/sorry-plant.sh`, after the pass, on the gated commit): a theorem with a `sorry` body appended to `Plane/Radius.lean`, never built, never committed — narrow lines 1, "PLANT FIRED" at `Radius.lean:268`; restored by `git checkout`, the digest the one taken before, narrow lines 0 again, 0 tracked files modified | `sorry-narrow-final.txt`, `sorry-wide-final.txt`; `../sorry-plant.out` |
| `axiom` lines in `Proofs/` | 4 line-initial, as on `main`: the two imports (`OAI158.lean`, now ll. 111 and 123 — four lines lower, the licence paragraph), `kloosterman_bound`, and one line of a docstring's code block (`Sat/Lrat.lean` l. 85). **Three axioms; the landing brings none** | `axiom-lines-final.txt` |
| doubled names, **after the build and before the audit** | "scanned 7493 modules, 1869 of them the package's (1869 source files)"; "dupnames: OK — no name is declared by two modules (24 generated on demand, listed above)" | `dupnames-final.log` |
| its self-test | "OK — all 15 controls behaved: every planted fault fired, and every partner passed." | `dupnames-selftest-final.log` |
| every declaration in a block, before the audit | "declarations the landing brings: 62 (of 78 constants in 3 modules); with one line: 62; unfiled: 0; doubled: 0" | `unfiled-final.txt` |
| axioms | "audited: **7015 records — 6967 clean on the standard axioms, 20 axiom-free, 23 imported** (resting on a declared outside theorem), **5 declared purchase(s)**"; "declared imports (3): …kloosterman_bound, …no_proper_five_coloring, …proper_to_borel_weak"; "library axioms other than native auxiliaries (3): … every one declared"; "axioms: OK". `CLAUDE.md` § Trust ledger flagged stale, "6910 clean → 6967, 18 imported → 23" (draft 1) | `axioms-final.log`, `receipt-axioms-final.log` |
| its self-test | "23 controls, each planted in a copy of scripts/Axioms.lean"; "OK — every planted fault fired, and every partner passed." (red in the first pass, 2 of 23, on the two state-reading counts: stage 8) | `axioms-selftest-final.log`, `receipt-axioms-self-test-final.log.xz` |
| **every declaration of the landing filed on what it rests on** (`tools/fs124_l1_records.py`) | "landing: 78 constants in 3 modules; declarations it brings: 62 (57 THM, 4 DEF, 1 IND); records in the log: 7015"; "landing records on exactly the three: 57", "on the three and no_proper_five_coloring: 1", "on the three and proper_to_borel_weak: 4"; `radius_five` "under IMPORTED: [Classical.choice, Quot.sound, no_proper_five_coloring, propext]"; `radius_down`, `exists_isWeakColouringOn_of_colorable`, `colorable_iff_forall_ball`, `seven_le_chromaticNumber_plane_iff_exists_ball` each "under IMPORTED: [Classical.choice, Quot.sound, proper_to_borel_weak, propext]"; `radius_up`, `exists_radius_of_not_colorable`, `colorable_plane_of_forall_aeProperOn_ball`, `radius_graph`, `radius_countable` each "under CLEAN: [Classical.choice, Quot.sound, propext]"; "records carrying kloosterman_bound: 8 (filed: 8); of the landing's: 0", "…no_proper_five_coloring: 6 (filed: 6); of the landing's: 1", "…proper_to_borel_weak: 9 (filed: 9); of the landing's: 4"; "records under IMPORTED 23; carrying two imports 0; carrying sorryAx 0"; "records: PASS" | `records-final.txt` |
| its plants | fifteen, one at a time, "every one of 15 fired; the unplanted lists pass" (stage 3 lists them; the wrong filing twice, and the import-free half resting on the transfer, among them). On the audit script itself the wrong filing was refused before the pass (stage 3) | `records-plant-final.txt`; `../wrong-filing-run.out` |
| the import's block as filed, with its two controls (`tools/fs132_l1_block.py`, FS132-L1's), on the module as recompiled | "records filed: 22 as filed: 22 (clean 12, on H 5, on T 5) refused: 0"; the wrong filing: refused exactly `six_le_chiM0`, `chiM0_six_or_seven`, `seven_le_chromaticNumber_plane_iff`, "CONTROL FIRED AS EXPECTED"; the planted `sorry`: refused eleven; each read as a plain check exits 1; "block: PASS — every record as filed; both controls fired" | `block-final.txt`, `block-*-final.*` |
| the generated modules and the licence copy against the generator | "OK: scripts/Axioms.lean holds the block, 163 records"; "CHECK OK"; "SELF-TEST OK: 10 plants refused and 1 partner accepted" | `port-check-final.txt`, `port-selftest-final.txt` |
| vacuity | "scanned: **declarations=15370 refutations-skipped=226**"; "sites: **sites=1448 vacuous=0 stale=0 declared=3 witnessed=38 generic=1405 unknown=2**"; "evidence: 18 emptiness proof(s), 63 witness(es)"; the baseline's header "match (9 of 9 compared)"; "UNKNOWN …hexShell_plane5", "UNKNOWN …hexShell_plane6", held as on `main`; "vacuity: OK". `CLAUDE.md` § The gate flagged stale on three counts (draft 4) | `vacuity-final.log`, `receipt-vacuity-final.log` |
| the scan against `main`'s, row for row | "counter vs the main scan: declarations 15292 / 15292, refutations 226 / 226: agree"; "counter vs the landing scan: declarations 15370 / 15370, refutations 226 / 226: agree"; "main rows 1528, landing rows 1529; lost 0 (0 with a removed declaration); added 1" — "added SITE GENERIC HadwigerNelson.Plane.AeColouring.isWeakColouringOn :: HadwigerNelson.Plane.AeColouring k"; three new modules, 50 + 16 + 12; "by module: declarations +78, refutations +0: equal to the scans difference"; "vacdiff: PASS" | `vacdiff-final.txt` |
| its self-test, and the difference's plants | "OK — all 65 controls behaved: every one fired, and the silent ones stayed silent."; the plants: exit 1 — COUNTER-DISAGREES, LOST, NOT NEW, FLAGGED, MODULE-SUM | `vacuity-selftest-final.log`, `vacdiff-plant-final.txt` |
| assumptions | "assumptions: OK — 3 outside theorem(s) as axioms, with 23 theorem(s) resting on them; 19 named and 16 inline hypotheses (7 outside, 23 ours, 5 open), taken by 98 statement(s) and mentioned by 1"; "assumed: **axioms=3 rests=23 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1**"; "decided: … conditions=38 fails=0"; "hints=0 silent=1 unseen=16817"; the ledger's header "match (9 of 9 compared)"; `CLAUDE.md` § Trust ledger flagged stale, "rests 18 → 23" (draft 3) | `assumptions-final.log`, `receipt-assumptions-final.log` |
| its self-test | "21 controls, planted together in one copy of scripts/Assumptions.lean"; "OK — all 33 checks behaved: every planted fault fired, and every partner stayed silent." | `assumptions-selftest-final.log` |
| architecture | "RESULT: PASS" | `arch-final.txt` |
| guarded lint (`lake lint --no-build -- --no-build --trace`, `--mem 8`) | exit 0, "-- Linting passed for Proofs.", 14 linters each "(2/2) Passed!"; its control red before the first pass (stage 8) | `lint-final.log`; `../lint-plant.log` |
| notes, as the last landing ran them | `tools/fs131_l5_notes.py --only-flagged`: "notes read: 196 LOCAL-SAID=31 NO-OBJECT=48 NONE-SAID=59 no-conflict=58", 0 CONFLICT — `main`'s count: the check reads the modules of QA4's audit, none of them this landing's; `tools/fs131_qa4_notes.py --self-test`: "OK (6 controls, 1 planted)" | `notes-l5-final.txt`, `notes-qa4-selftest-final.txt` |
| **the import's stored-term comparison, on this commit** (the module's compiled file `f763d277…`, recompiled by this landing) | "declarations: 8 compared: 8 identical: 8 different: 0", "READ-BACK IDENTICAL: all 8 declarations, term for term, modulo the namespace"; "SELF-TEST OK: … 6 plants"; the Lean control "FIRED AS EXPECTED"; 0 files written at the release's side; "READ-BACK RUN gate-final: OK" | `readback-import-final.txt`; `../readback-import/*-gate-final.*` |
| the port's stored-term comparison, on this commit (its nine modules recompiled under the import's new docstring) | the release's print `c3343d13…` and this library's print `7874161e…`, each the port's committed print byte for byte ("IDENTICAL"); "READBACK OK"; the port's tables unchanged as git sees them; "SELF-TEST OK: 13 plants refused, the unplanted pair passes"; "LEVEL1 OK"; "PORT READ-BACK RUN gate-final: OK" | `readback-port-final.txt`; `../readback-port/*-gate-final.*` |
| the statements by `#check`, their axioms, the halves and the models | each as stages 6 and 7 read it; no error; byte for byte the probe's output of stage 4's tree | `checks-final.out` |
| the baseline and the scans' sources | "baseline entries: unchanged from main's (2)"; lines of `scripts/Vacuity.lean` that differ from `main`'s: 0; of `scripts/Assumptions.lean`: 0 | `baseline-final.txt` |
| the three digests against the previous landing's receipts (`data/fs132/l2/gate/receipt-*-final.log`) | axioms: **62 rows added** — 57 CLEAN on `[propext, Classical.choice, Quot.sound]`, 5 IMPORTED — none removed; "clean records, by axiom set: 6802 [propext, Classical.choice, Quot.sound], 86 [propext, Quot.sound], 78 [propext], 1 [Quot.sound]". vacuity: three counts move, **one row added**, the GENERIC site, none removed. assumptions: **five `RESTS` rows added**, and the two `AXIOM` rows of the release's theorems change their count (`theorems=5` → `6`, `theorems=5` → `9`); nothing else | `digest-axioms-final.txt`, `digest-vacuity-final.txt`, `digest-assumptions-final.txt` |

**Read aloud against the informal claim.** The claim of this landing: "`7 ≤ χ(ℝ²)` if and only if some open disc
about the origin has no measurable six-colouring proper at almost every unit pair — on the standard three axioms and
one declared outside theorem." What the gate shows: no `axiom` enters and no `sorry` is in `Proofs/`; every one of
the 62 declarations the landing brings has one record; the criterion's two forms and (down) are under IMPORTED on
exactly the standard three and the Borel transfer, (five) on exactly the three and the five-colour theorem, and the
other 57 — (up), its contrapositive and the finite-set and countable forms among them — under CLEAN on exactly the
three; no record carries both imports; no name is declared twice, so each printed list is the list of the proof the
kernel checked; nothing the landing brings takes a declared hypothesis, and the five that rest on an import are in
the ledger; the import's eight stored statements are the release's, term for term, on the module as recompiled.
**What the gate does not show, and this record says**: that the hypotheses can be met — the scan has one site in 78
constants, and stage 6 names each model and how it is held; that row 161's every sentence is a theorem — one is not
(C124-EVERY-DIRECTION), and stage 7 says what is; that the half toward seven *needs* the import — the kernel says
what this proof uses.

## Stage 10 — SAVED (FS124-L1): the landing

`main` had not moved while the gate ran: `origin/main` was `ac7dee7b`, the commit merged before the pass. **The commit
pushed is `022f4c59`**: the gated commit `24a42aa9` and one commit of this job's logs and record. The diff that shows
it (`data/fs124/l1/push-check.out`): `git diff --name-only 24a42aa9 022f4c59` — `data/` 86, `plans/` 1, nothing else;
`git diff --stat 24a42aa9 022f4c59 -- Proofs Proofs.lean scripts tools ARCHITECTURE.md lakefile.toml lean-toolchain
lake-manifest.json CLAUDE.md` — **empty**; `origin/main` is its ancestor; the tree holds zero `sorry` by the narrow
search; no tracked file modified. The coordinator was sent one line when the gate was green, before the push.

**The push** (`data/fs124/l1/push-main.out`): `git push origin HEAD:main` from the worktree — "ac7dee7bd..022f4c59c
HEAD -> main", **a fast-forward; no force.** `origin/main` by `ls-remote`: `ac7dee7b…` before, `022f4c59…` after. The
record's last sections and the report follow in a second fast-forward that touches `plans/` and `data/` only.

## Drafts for the front page (FS124-L1)

*For the coordinator to file; nothing here is filed by this job. Each names its slot — the file, the section, and **the
exact words on `main` it replaces or follows**, read on `main` at `022f4c59 (this landing; the coordinator's files as at `ac7dee7b`)` and each asserted to occur exactly once
there (`data/fs124/l1/drafts-slots.py`, output `drafts-slots.out`) — and the log line it comes from. The gated commit
is `24a42aa9f7816b544c4e7a63c754a9b45e77bd49`; its logs are `data/fs124/l1/gate/*-final.*` (`receipt-axioms-final.log`, `receipt-vacuity-final.log`,
`receipt-assumptions-final.log` are the three scans' full outputs).*

**1. `CLAUDE.md` § Trust ledger, the audit's sentence.** *Replaces* "the current audit reads 6910 clean and 5 declared
purchases, and 18 imported (and 20 axiom-free; 6,953 records at the landing of FS-132's first theorem, FS132-L2,
2026-10-07)" — from `axioms-final.log`, "audited: 7015 records — 6967 clean on the standard axioms, 20 axiom-free, 23
imported (resting on a declared outside theorem), 5 declared purchase(s)":

> the current audit reads 6967 clean and 5 declared purchases, and 23 imported (and 20 axiom-free; 7,015 records at the
> landing of FS-124's disc criterion, FS124-L1, 2026-10-07)

6910 + 57 = 6967 (the 52 clean theorems of the three modules and their five definitions, every one on exactly the
standard three: `records-final.txt`); 18 + 5 = 23; 6953 + 62 = 7015; axiom-free and purchases do not move. **Five more
than my brief expected** (clean +52, records +57): the four definitions and the structure of `Plane/WeakColouringOn`
are filed, by this job's decision (stage 3). Until it is filed the audit flags the sentence stale (not failed): "6910
clean → 6967, 18 imported → 23".

**2. `CLAUDE.md` § Trust ledger, how many records rest on each outside theorem.** *Replaces*, in the sentence after it,
"— no map `ℂ → Fin 5` separates every unit pair — with five, and" *by* "— no map `ℂ → Fin 5` separates every unit pair
— with six, and", and "— a proper `k`-colouring of the plane gives a Borel one proper at almost every unit pair — with
five;" *by* "— a proper `k`-colouring of the plane gives a Borel one proper at almost every unit pair — with nine;" —
from `records-final.txt`: "whole log: records carrying no_proper_five_coloring: 6 (filed: 6); of the landing's: 1",
"records carrying proper_to_borel_weak: 9 (filed: 9); of the landing's: 4", "records carrying kloosterman_bound: 8
(filed: 8)". "no record rests on two of the three" stands ("carrying two imports 0").

**3. `CLAUDE.md` § Trust ledger, the nine assumption counts.** *Replaces* "`axioms=3 rests=18 named=19 inline=16
outside=7 ours=23 open=5 takes=98 mentions=1` — three outside theorems declared as axioms, with eighteen theorems
resting on them;" — from `receipt-assumptions-final.log`, `=== TOTALS ===`, and `assumptions-final.log`, "assumptions:
OK — 3 outside theorem(s) as axioms, with 23 theorem(s) resting on them; 19 named and 16 inline hypotheses (7 outside,
23 ours, 5 open), taken by 98 statement(s) and mentioned by 1":

> `axioms=3 rests=23 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1` — three outside theorems declared
> as axioms, with twenty-three theorems resting on them;

One count of the nine moves (`rests`, 18 → 23); no hypothesis is added in either form, no line of
`scripts/Assumptions.lean` changes, and the rest of the paragraph stands. The ledger's header is refiled by
`--write-ledger` on the branch ("match (9 of 9 compared)"); until the front page is, the step flags it stale: "rests
18 → 23".

**4. `CLAUDE.md` § The gate, the vacuity scan's two count lines.** *Replaces* "`declarations=15292
refutations-skipped=226 sites=1447`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1404 unknown=2`." — from
`vacuity-final.log`, "scanned: declarations=15370 refutations-skipped=226", "sites: sites=1448 vacuous=0 stale=0
declared=3 witnessed=38 generic=1405 unknown=2":

> `declarations=15370 refutations-skipped=226 sites=1448`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1405 unknown=2`.

Three counts move: declarations +78 (the landing's 78 constants), sites +1 and generic +1 (one site,
`AeColouring.isWeakColouringOn :: AeColouring k`). The sentences on the baseline's two entries stand.

**5. `tools/claude_md_fact_audit.py`, `GATE_CHANGES`** — one entry after the last (`(("6533", "5"), ("6910", "5"))`):

```python
    (("6910", "5"), ("6967", "5")): "FS-124, the landing of its first module — the disc criterion: weak colourings of a set, the radius clause and its join over the Borel transfer (FS124-L1; copy data/fs124/l1/gate/receipt-axioms-final.log, gated commit 24a42aa9): 7,015 records, 6,967 clean, 20 axiom-free, 23 imported, 5 purchases",
```

and, in the same file's table of superseded counts, after the entries for `"6533"` and `"6576"`, the two this filing
supersedes, in that table's own form: `"6910"` (6967 clean) and `"6953"` (7,015 records), "superseded gate count,
refiled at FS124-L1's landing from data/fs124/l1/gate/receipt-axioms-final.log; the old count stays in
data/fs132/l2/gate/receipt-axioms-final.log and in GATE_CHANGES". Also superseded by drafts 2–4: "eighteen theorems",
`rests=18`, `declarations=15292`, `sites=1447`, `generic=1404`. The previous landing's receipts, against which the
three digests were taken: `data/fs132/l2/gate/receipt-axioms-final.log`, `receipt-vacuity-final.log`,
`receipt-assumptions-final.log`; **the next landing's previous receipts are
`data/fs124/l1/gate/receipt-{axioms,vacuity,assumptions}-final.log`.**

**6. `CLAUDE.md` § Where the problem stands — the disc criterion, and which half needs the import.** *Follows* the
paragraph's last sentence, "Falconer's everywhere-proper `χ_m` is one step further, a GAP; by Thm 1.4 `χ_m(ℝ²) ≥
χ_m⁰(ℝ²) ≥ 6`." The planner's sentence (`plans/FS124-kernel-plan.md` § 4.4, first item), word for word; every name in
it is a landed declaration of namespace `HadwigerNelson.Plane` (`checks-final.out`: `#check` of each;
`records-final.txt`: each record's banner and axioms):

> On discs (`Plane/RadiusOutside`): `seven_le_chromaticNumber_plane_iff_exists_ball` — `7 ≤ χ(ℝ²)` exactly when some
> open disc about the origin has no weak measurable six-colouring — and `colorable_iff_forall_ball` at every `k`. *Seven
> gives such a disc* is the contrapositive of `radius_up` (`exists_radius_of_not_colorable`) and rests on the standard
> three axioms; *such a disc gives seven* is the contrapositive of `radius_down` and rests on the declared outside
> theorem `Outside.OAI158.proper_to_borel_weak`. So an exclusion on a disc reaches seven only through the transfer, and
> weak six-colourings of every disc reach six with no import.

Checked against the gate: `radius_up` and `exists_radius_of_not_colorable` are under CLEAN on `[propext,
Classical.choice, Quot.sound]`; `radius_down`, `colorable_iff_forall_ball` and
`seven_le_chromaticNumber_plane_iff_exists_ball` under IMPORTED on those three and `proper_to_borel_weak`; the halves
proved apart print the same (`checks-final.out`). Two words a reader may want (stage 7): "weak measurable" is Borel
measurable, and the criterion holds as well with no measurability asked; "about the origin" is any centre.

**7. `LEDGER.md` row 161.** *(a) Replaces* its grade sentence, "**Grade:** [hand] or derived from [hand] entries, one
mind each, kernel pending. **Kernel-checked on a branch, not through the gate, not held** (`fs124-wk1`, 57 theorems):
`colorable_iff_forall_ball` and `seven_le_chromaticNumber_plane_iff_exists_ball`, each on the standard three axioms and
that one declared outside theorem; (up) and its contrapositive on the standard three alone." — from
`records-final.txt` and `checks-final.out`:

> **Grade:** **[kernel]**, through the gate (FS124-L1, 2026-10-07, gated commit `24a42aa9`;
> `Proofs/HadwigerNelson/Plane/` `WeakColouringOn`, `Radius`, `RadiusOutside`, namespace `HadwigerNelson.Plane`), for
> every quoted sentence but the last: C124-RADIUS-GRAPH `radius_graph`, -COUNTABLE `radius_countable`, -UP `radius_up`,
> each on `[propext, Classical.choice, Quot.sound]`; -DOWN `radius_down` and the two forms of the criterion,
> `colorable_iff_forall_ball` and `seven_le_chromaticNumber_plane_iff_exists_ball`, each on those three and the declared
> outside theorem `Outside.OAI158.proper_to_borel_weak`; -FIVE `radius_five`, on those three and
> `Outside.OAI158.no_proper_five_coloring`; no record on both, none taking an assumption in hypothesis form. **Which
> half of the criterion needs the import:** toward six none — (up), and its contrapositive
> `exists_radius_of_not_colorable` (seven gives a disc with no weak six-colouring), on the standard three alone; toward
> seven the Borel transfer — a disc with no weak six-colouring gives seven only through (down). "Measurable" is Borel
> measurability of a map of the whole plane read on the set; rigid motions and their open sets are read in the
> parameters `(x, θ)` of `z ↦ x + e^{iθ}z`. **[hand], one mind, with no Lean theorem:** C124-EVERY-DIRECTION.

*(b) The sentence after it stands*, with its first words changed: "The kernel planner's own generalizations there are
its module's, not entries:" → "The kernel module's own generalizations are its own, not entries:" (there is no "there"
once the branch is gone).

*(c) The row's address cell*: *replaces* "branch `fs124-wk1`" *by* "`Proofs/HadwigerNelson/Plane/WeakColouringOn.lean`,
`Radius.lean`, `RadiusOutside.lean`; `plans/FS124-kernel-plan.md`, `plans/FS124-I1-implementation.md`,
`plans/FS124-L1-landing.md`".

*What the row may not say*: "[kernel]" of C124-EVERY-DIRECTION; "with no import" of the criterion as a whole — one
half of it; "an explicit radius"; that the kernel's "(down) for every subset" or "measurability idle" are entries.
`tools/check_architecture.py` lists (without failing) that row 161 names no identifier of `Plane/Radius`: with (a) it
names `radius_graph`, `radius_countable`, `radius_up`.

**8. `plans/FS124-derivation.md` — the theorem record.** *(a) One dated line under each of the entries
C124-RADIUS-GRAPH, -COUNTABLE, -UP, -DOWN, -FIVE* (the entries' `grade:` and `minds:` fields are the coordinator's):

> **2026-10-07, FS124-L1 — [kernel], through the full gate at `24a42aa9`**: `HadwigerNelson.Plane.radius_graph`
> (C124-RADIUS-GRAPH), `radius_countable` (-COUNTABLE), `radius_up` (-UP), each on `[propext, Classical.choice,
> Quot.sound]`; `radius_down` (-DOWN), on those and the declared outside theorem `Outside.OAI158.proper_to_borel_weak`;
> `radius_five` (-FIVE), on those and `Outside.OAI158.no_proper_five_coloring`
> (`Proofs/HadwigerNelson/Plane/Radius.lean`, `RadiusOutside.lean`; the definition, `WeakColouringOn.lean`). Statements
> FS124-K1's, proofs FS124-I1's, landed by FS124-L1. Each entry's words are the theorem named; under them the module
> proves the wider forms (any function proper at almost every unit pair, a countable set anywhere, any centres, every
> subset), which are the module's and not entries. No assumption in hypothesis form. "Measurable" is Borel; motions are
> read in their parameters.

*(b) Replaces*, in the file's head (its line on the kernel lane's state), "the five entries of § 1's radius clause are
a module complete on branch `fs124-wk1` (57 theorems) — **kernel-checked on a branch, not through the gate, not
held**;" *by* "the five entries of § 1's radius clause are kernel theorems through the gate (FS124-L1; 57 theorems,
three modules);".

*(c) Replaces*, under C124-RADIUS-GRAPH, "**Kernel**: first module, complete on a branch, not held." *by* "**Kernel**:
`radius_graph`, through the gate (FS124-L1)."; and under C124-RADIUS-DOWN, "each on the standard three axioms and that
one declared outside theorem, **on a branch**. By the planner's record (§ 4.4, on its branch):" *by* "each on the
standard three axioms and that one declared outside theorem, **through the gate (FS124-L1)**. By the planner's record
(§ 4.4):".

*(d) C124-EVERY-DIRECTION's line stands*: "not stated in the first module".

**9. The phrase "kernel-checked on a branch", wherever it is said of this module** (each occurrence found on `main`):

- `CLAUDE.md` § Frontier, "Last filed": *replaces* "no value moved; its first Lean module complete on a branch, its
  landing owed)" *by* "no value moved; its first Lean module, the disc criterion, through the gate, FS124-L1)".
- `CLAUDE.md` § Paths forward, "Open milestones", and the same sentence in `plans/FRONTIER-STUBS.md`: *replaces* "Its
  first Lean module, the disc criterion, is complete on branch `fs124-wk1` (57 theorems; kernel-checked on a branch, not
  through the gate; its landing is owed); its second is being planned; Closed when its modules pass the gate." *by*

  > Its first Lean module, the disc criterion, is through the gate (FS124-L1, 2026-10-07; `Plane/WeakColouringOn`,
  > `Plane/Radius`, `Plane/RadiusOutside`, 57 theorems): `7 ≤ χ(ℝ²)` exactly when some open disc has no weak measurable
  > six-colouring (`Plane.seven_le_chromaticNumber_plane_iff_exists_ball`), the half toward six on the standard three
  > axioms and the half toward seven on the declared outside theorem `Outside.OAI158.proper_to_borel_weak`; its second
  > is being planned; Closed when its modules pass the gate.

- `CLAUDE.md` § Where the problem stands, item 31: in "At the unit arc itself (FS-124; rows 161–164; [hand], one mind
  each, kernel pending): `χ(ℝ²) ≤ 6` exactly when every open disc has a measurable six-colouring proper at almost every
  unit pair, the direction toward seven over the outside theorem on Borel transfer (row 161);" *replaces* "(row 161);"
  *by* "(row 161, [kernel] since FS124-L1);" — rows 162–164 stay as they are.
- `plans/STUB-q-ring.md`, its head: *replaces* "the first is complete on a branch, the second is being planned" *by*
  "the first is through the gate (FS124-L1), the second is being planned"; and its closing section: *replaces* "(§ 1;
  its module complete on branch `fs124-wk1`, kernel-checked on a branch, not through the gate, not held)" *by* "(§ 1;
  its module through the gate, FS124-L1 — [kernel], the half toward seven on one declared outside theorem)".
- `LEDGER.md` row 161 and `plans/FS124-derivation.md`: drafts 7 and 8.

**10. `LEAN.md`.** *(a) § Searching — Lean*, one bullet, the implementer's draft 12, not yet filed (the planner's two
lines are):

> - A `#check` under `import Mathlib` shows that a name exists at the pin, not that a module can see it: check a route's
>   names under the module's own imports. `rotation` (`Mathlib.Analysis.Complex.Isometry`) is outside
>   `Plane/AeColouring`'s closure; multiplication by a unit complex number is a real-linear isometry with no new import
>   as `⟨(LinearEquiv.smulOfUnit (Units.mk0 a ha)).restrictScalars ℝ, _⟩`, and `LinearIsometryEquiv.measurePreserving`
>   is in the closure (FS124-I1).

*(b) § The gate*, in the bullet "Every gate keeps what it computed", *follows* "(`latest` is the last complete run;
`scripts/gate-log.sh`)":

> — a run that failed on a planted fault is a complete run: after a control planted in a gate's own input (the wrong
> filing in `scripts/Axioms.lean`), `latest` is the planted run until the gate is run again, and a tool reading it
> reads the plant (FS124-L1: `tools/fs124_l1_records.py` refused that log, as it should)

*(c) § The gate*, in the bullet on `./scripts/vacuity.sh`, *follows* the sentence ending "(FS132-L2, its record's
stage 7).":

> A landing whose modules are consumed through a predicate on maps (`IsWeakColouringOn U c`) names in the same way the
> parameter at which each hypothesis is inhabited, open, and empty given an import (FS124-L1, its record's stage 6:
> seven, six, five).

*(d) § Assumptions*, the bullet "An imported theorem carries four things", item 2, *follows* "the landing runs it again
on the module as recompiled on the joined tree.": "A copy carries the source's licence in its module docstring, with
the text beside it (`Outside/OAI158`, since FS124-L1)."

**11. `BIBLIOGRAPHY.md`, `[OAIMath2026]`'s entry** — to add to what of ours rests on it:

> FS-124's disc criterion (FS124-L1, 2026-10-07): `Plane.radius_down`, `Plane.exists_isWeakColouringOn_of_colorable`,
> `Plane.colorable_iff_forall_ball` and `Plane.seven_le_chromaticNumber_plane_iff_exists_ball` rest on the imported
> `proper_to_borel_weak`, `Plane.radius_five` on the imported `no_proper_five_coloring`; nine and six records of the
> audit rest on the two. The import module's docstring names the release's licence (Apache-2.0) and the copy beside it.

**12. The Proof Atlas.** The node of row 161's criterion (C124-RADIUS-UP with C124-RADIUS-DOWN; the join): **[hand] →
[kernel]**, its edge to `[OAIMath2026]` family 158 an edge to a **declared outside theorem** (`proper_to_borel_weak`),
carried by the half toward seven only. C124-RADIUS-GRAPH, -COUNTABLE, -UP: [hand] / derived → [kernel], the standard
three, no outside edge. C124-RADIUS-DOWN: → [kernel] on `proper_to_borel_weak`. C124-RADIUS-FIVE: → [kernel] on
`no_proper_five_coloring`. C124-EVERY-DIRECTION: stays [hand]. No value moves.

**13. `ARCHITECTURE.md`**: nothing to file — § 3.13's paragraph and rows and § 5 Trust's two record lists are on the
branch as landed (stage 3).

**14. `plans/FS132-close-inventory.md` item 51 (a)** — its ruling is done: the import module's header names the
licence (stage 4); the eight stored terms are untouched.

## Open gate items at this landing

1. **C124-EVERY-DIRECTION is in row 161 and in no Lean module.** Its sentence stays [hand]; the planner's reasons
   stand (no consumer; its proof waits on a lemma the release's port brings).
2. **Two models are terms of an iteration file, not library theorems**: every hypothesis of `radius_graph` and
   `radius_countable` at once on a bounded open set (`FS124L1.model_graph`; the modules' own `example`s run the
   theorems at `U = univ`), and the two truth values of `colorable_iff_forall_ball` (`join_seven`, `join_four`). The
   brief adds no statement; a later module that wants them has the six lines each.
3. **The vacuity scan tracks no carrier of these modules** (`IsWeakColouringOn`, `AeProperOn`): one site in 78
   constants, on the bundled `AeColouring`. For the tooling job, beside FS132-L1's and FS132-L2's questions. The notes
   check reads QA4's modules only: no instrument reads the `Inhabitant` notes of the three modules; stage 6 read them.
4. **The parameter reading.** "Every orientation-preserving isometry is a `rigidMotion`" and "open in the group is open
   in parameters" are "not proved here" (the module header). No statement uses them; row 161's first sentence is read
   through them.
5. **Earlier landings' record tools state earlier filings**: `tools/fs132_l1_records.py` and `tools/fs132_l2_records.py`
   require exactly eighteen records under IMPORTED and now refuse a current log, by design; `tools/fs124_l1_records.py`
   carries the filing (twenty-three). A later landing extends `FILED_HERE`, or the tooling job makes one filing table.
6. **Whether a landing files its definitions** is practice, not a written rule: FS132-L1 filed theorems, FS132-L2 and
   this landing every declaration. Not checked by me: whether every definition of earlier modules has a record.

## Theorems this phase proved, final

*Each [kernel], through the full gate at `24a42aa9`, on `main` since `022f4c59`. Printed from the gate's own logs
(`data/fs124/l1/theorem-lines.py` on `gate/decls-final.out` and `gate/receipt-axioms-final.log`; output
`data/fs124/l1/theorem-lines.md`): every declaration the landing brings — 57 theorems, 4 definitions, 1 structure —
with the banner its record is under and its axioms as the audit printed them. Namespace `HadwigerNelson.Plane`;
modules under `Proofs/HadwigerNelson/`. Statements FS124-K1's, proofs FS124-I1's; this job proved none and changed
none. The informal statement each headline theorem was read against is in stage 7.*

**The seven the landing is for**, with the sentence each is read against:

- **`seven_le_chromaticNumber_plane_iff_exists_ball`** (`Plane/RadiusOutside.lean`) — row 161's "the plane needs seven
  colours precisely if some open disc has no weak measurable six-colouring". `[propext, Classical.choice, Quot.sound]`
  and `HadwigerNelson.Outside.OAI158.proper_to_borel_weak`. No assumption in hypothesis form.
- **`colorable_iff_forall_ball`** (the same file) — "at each `k` the two hold together or fail together". The same
  axioms.
- **`radius_up`** (`Plane/Radius.lean`) — C124-RADIUS-UP. `[propext, Classical.choice, Quot.sound]`: the half toward
  six, with no import; its contrapositive is `exists_radius_of_not_colorable`, on the same three.
- **`radius_down`** (`Plane/RadiusOutside.lean`) — C124-RADIUS-DOWN. The standard three and
  `Outside.OAI158.proper_to_borel_weak`: the half toward seven.
- **`radius_five`** (the same file) — C124-RADIUS-FIVE. The standard three and
  `Outside.OAI158.no_proper_five_coloring`.
- **`radius_graph`**, **`radius_countable`** (`Plane/Radius.lean`) — C124-RADIUS-GRAPH, -COUNTABLE. The standard three.
- **`AeProperOn`**, **`IsWeakColouringOn`** (`Plane/WeakColouringOn.lean`) — the definition the statements name.

**Every declaration, one line each:**

**`Plane/WeakColouringOn`** (38 declarations):

- `AeColouring.isWeakColouringOn` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `AeProperOn` — definition; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `AeProperOn.comp_rigidMotion` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `AeProperOn.mono` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `IsWeakColouringOn` — structure; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `IsWeakColouringOn.comp_rigidMotion` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `IsWeakColouringOn.exists_aeColouring` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `IsWeakColouringOn.mono` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `aeProperOn_congr` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `aeProperOn_iff_ae` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `aeProperOn_iff_unitPairsNull` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `aeProperOn_iff_volume` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `aeProperOn_of_proper` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `aeProperOn_of_proper_off_null` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `continuous_rigidMotion` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `continuous_rigidMotion_apply` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `dist_rigidMotion` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `exists_isWeakColouringOn_ball_iff` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `exists_isWeakColouringOn_iff_subtype` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `exists_rigidMotion_edge` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `isWeakColouringOn_univ_iff` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `measurePreserving_motionMul_left` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `measurePreserving_motionMul_right` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `mem_monoPairSet_iff_rigidMotion` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `mem_monoPairSet_of_e_eq` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `monoPairSet` — definition; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `monoPairSet_eq_iUnion` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `monoPairSet_mono` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `motionMul` — definition; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `prod_arcLength_eq_restrict` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `prod_arcLength_eq_zero_iff_volume` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `rigidMotion` — definition; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `rigidMotion_add_two_pi` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `rigidMotion_apply_one` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `rigidMotion_apply_zero` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `rigidMotion_motionMul` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `rigidMotion_translation` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `rigidMotion_zero` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]

**`Plane/Radius`** (16 declarations):

- `AeProperOn.ae_rigidMotion` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `AeProperOn.ae_rigidMotion_arcLength` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `AeProperOn.ae_rigidMotion_edge` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `AeProperOn.colorable_induce` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `AeProperOn.exists_rigidMotion` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `aeProperOn_iff_ae_rigidMotion` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `colorable_induce_of_forall_aeProperOn_ball` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `colorable_induce_of_forall_ne` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `colorable_plane_of_forall_aeProperOn_ball` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `colorable_plane_of_forall_finite` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `exists_isWeakColouringOn_seven` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `exists_radius_of_not_colorable` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `isOpen_setOf_mapsTo_rigidMotion` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `radius_countable` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `radius_graph` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `radius_up` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]

**`Plane/RadiusOutside`** (8 declarations):

- `colorable_iff_forall_ball` — theorem; [kernel]; under IMPORTED; axioms: [propext, Classical.choice, Quot.sound] and `HadwigerNelson.Outside.OAI158.proper_to_borel_weak`
- `exists_isWeakColouringOn_of_colorable` — theorem; [kernel]; under IMPORTED; axioms: [propext, Classical.choice, Quot.sound] and `HadwigerNelson.Outside.OAI158.proper_to_borel_weak`
- `exists_isWeakColouringOn_univ_iff` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `exists_radius_no_weak_four` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `isWeakColouringOn_univ_iff_weakColoring` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `radius_down` — theorem; [kernel]; under IMPORTED; axioms: [propext, Classical.choice, Quot.sound] and `HadwigerNelson.Outside.OAI158.proper_to_borel_weak`
- `radius_five` — theorem; [kernel]; under IMPORTED; axioms: [propext, Classical.choice, Quot.sound] and `HadwigerNelson.Outside.OAI158.no_proper_five_coloring`
- `seven_le_chromaticNumber_plane_iff_exists_ball` — theorem; [kernel]; under IMPORTED; axioms: [propext, Classical.choice, Quot.sound] and `HadwigerNelson.Outside.OAI158.proper_to_borel_weak`

## Slips, my own

1. **The audit's self-test was not among my probes** (stage 8): the implementer's record said no `--self-test` had
   been run and the brief named the controls file; I ran the audit, its wrong-filing plant and my own tool's plants
   before the pass, and not `./scripts/axioms.sh --self-test`. It went red in the first full pass on two counts that
   read the library's state, and cost one pass of twenty minutes.
2. **A tracked file's mode bit set while the final pass ran** (stage 9): `chmod +x` on a script of this job under
   `data/`, already committed. No step reads it; put back; the runner's last line reports it. I had said I would touch
   no tracked file during a pass.
3. **Five records more than the brief counted** (stage 3) is a decision, not a slip, but it moved two counts the
   coordinator had drafted from: clean +57 for +52, records +62 for +57. Sent in the line before the push.
4. **A count in my tool's docstring** ("fourteen faults" for fifteen plants), corrected before the tool was first run.
5. **The first draft of one checks term** said "on the two imports" of a statement that the print shows rests on one
   (`criterion_at_five`, on `no_proper_five_coloring` alone); corrected before the gate's pass read the file.

## The second fast-forward

After the push `main` moved once, to `9ba528c4` (the coordinator's inventory item on this landing: `plans/`, one
path; 0 paths outside the brief's list). Merged by hash, automatic; the commit that carries this record's last
sections and the report (`data/fs124/reports/FS124-L1.md`) differs from the landed tip `022f4c59` in `plans/` and
`data/` only, and from the gated commit `24a42aa9` in no path outside the brief's list
(`data/fs124/l1/push-main-2.out`). The drafts' slots, read again on `main` after the landing: 26 of 26 found, the
control fired (`data/fs124/l1/drafts-slots.out`). No background process of this job is left running.
