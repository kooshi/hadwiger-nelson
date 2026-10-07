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
