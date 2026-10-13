# FS131-LC1 — the landing of the measurable-number module: `χ(ℝ²) = χ_m(ℝ²)`, Lebesgue-measurable classes, every unit pair

*Job record of FS131-LC1 (brief: `data/fs131/briefs/FS131-LC1-landing.md`; de Bruijn, the implementer, as the lander of
one finished module; branch `fs131-wkc`, worktree `.claude/worktrees/fs131-wkc`; the laptop: 12 cores, 31 GB). The
module is FS131-KC1's (`Proofs/HadwigerNelson/Plane/LebesgueNumber.lean`; its record
`plans/FS131-KC1-measurable-number-plan.md`). **The mathematics is other people's**: a printed lemma (`[Davies2026]`
Lemma B.1, p. 44), formalized by FS131-KC1 with its printed proof; a declared outside theorem
(`Outside.OAI158.proper_to_borel_weak`, `[OAIMath2026]` family 158); a composition. This job proves nothing and changes
no statement: it takes the module through the gate. Working files: `data/fs131/lc1/` (this job's scripts are there, not
under `tools/`: the brief's list of what the job touches names that directory and not `tools/`).*

## Theorems this phase proved

*Filled at the green line from the gate's saved logs (§ "Theorems this phase proved, final"). Until the gate is green on
one commit nothing below is "held".*

## Stage 1 — SAVED (FS131-LC1): the readback, what was read, `main` merged, the tree as given probed before any edit

### The brief's quotations

`data/fs131/lc1/readback_check.py` (FS131-KC1's script pointed at this brief: every block quote must occur character
for character in the file its source line names): **7 of 7 MATCH** (`readback.out`); with `--fault` (one character of
each altered) **7 of 7 MISMATCH** (`readback-fault.out`), so the check can fire. A count, not a mismatch: the brief's
§ Done means says "the six quoted lines"; there are seven block quotes — two of Kooshi's words (W2, W3), four claim
lines (NF3-PRINTED, -WEAK-TO-PROPER, -PLANE, -NC) and the dated line of 16:51 UTC.

### What was read

The brief and `plans/STANDING-RULES.md` in full; `LEAN.md` in full; `RUNNING.md` § Building and § Make the gate fail,
and watch it fail; the planner's record and its report (all seven drafts); the module, every line; the last landing's
record (`plans/FS124-L2-landing.md`) stages 3 to 9, the head of its drafts and its open gate items, and its runner
`data/fs124/l2/run-gate.sh`. **The paper, first-hand from the rendered pages** (`~/source/library/pdf/Davies2026-…pdf`):
p. 1 (title, author, "arXiv:2610.12301v1 [math.CO] 8 Oct 2026"), p. 2 (the definitions), p. 44 (Appendix B's standing
hypotheses, the sentence before the lemma, Lemma B.1 and its proof), p. 46 (the density-point argument). And, from a
text extraction of the library copy, the end of the proof of Lemma 5.6 of `[DeCorteOliveiraVallentin2022]` (printed
p. 22: "Let I be the set of density points in the support of f … Claim: I is independent") — the passage `[Davies2026]`
p. 46 cites as "the density-point argument in [24, proof of Lemma 5.6]". Stage 6 reads the statements against these.

### `main` merged

`main` had moved from the branch point `4410f75fc` to `3fd0d9ba3`: **15 paths, `data/` 12 and `plans/` 3, nothing
else** (`data/fs131/lc1/merge-main-diff.out`; the list of paths outside `plans/` and `data/` is empty), and no path in
common with the branch's own changes (`ARCHITECTURE.md`, `Proofs.lean`, the module, `data/` 8, `plans/` 1). Merged by
hash, automatic: `b6e5abfab` (`merge-main.out`).

### The tree as given, before any edit

*Every step under the slot with this machine's budget (`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6`), through
`data/fs131/lc1/m.sh`, which runs the step inside the slot's scope under `data/fs131/lc1/in-scope.sh` and appends one
line per step to `data/fs131/lc1/probes/measure.txt`: exit status, wall time, and **two memory numbers that measure
different things** — `peak`, the scope's `memory.peak` (what the kernel charged the step: private memory and the file
pages it was first to read; `.olean` pages already in the page cache are not charged again, so on a warm machine it is
far below a cold run's cost), and `max-rss`, the largest resident set of any one process of the step (GNU `time`:
private memory plus every mapped `.olean` page it touched). The instrument's control: a process holding 300 MiB reads
`peak=0.30 GiB max-rss=0.30 GiB`; a step that exits 7 is recorded `exit=7`.*

| step, on the tree as given (`b6e5abfab`) | result | wall | peak (charged) | max-rss |
|---|---|---|---|---|
| is the build current? `lake build --no-build Proofs` (compiles nothing) | exit 0, "All targets up-to-date (5995 jobs)" | 3.2 s | 0.21 GiB | — |
| the module's constants as the kernel lists them (`decls.lean`) | 41 constants in `Plane/LebesgueNumber`; **34 a person typed: 31 theorems, 3 definitions** (`HasDensityOneAt`, `AeColouring.core`, `chiLebesgue`); 7 the elaborator's (`HasDensityOneAt.eq_1`, six `match_1_n`) | 59.3 s | 0.55 GiB | — |
| every constant of the three modules to be edited, stored type and value (`StatementDump.lean` → `statements/before.compact`, at `statements/before.commit`) | 137 constants (`Plane/AeColouring` 22, `Plane/FalconerReduction` 72, `Plane/LebesgueNumber` 43); 87 named; the reader's four plants fire | 3.0 s | 0.52 GiB | 4.34 GiB |
| the statements by `#check`, their axioms, the model terms (`checks.lean`; `probes/checks-before.log`) | no error, no warning; eleven headline theorems on `[propext, Classical.choice, Quot.sound]`, three on those and `Outside.OAI158.proper_to_borel_weak` | 3.9 s | 0.55 GiB | 4.37 GiB |
| the guarded lint | exit 0, "-- Linting passed for Proofs.", every linter "(2/2) Passed!" | 9.2 s | 1.05 GiB | 4.92 GiB |
| `./scripts/dupnames.sh` | "dupnames: OK — no name is declared by two modules (24 generated on demand, listed above)" | 4.0 s | 0.52 GiB | 4.35 GiB |
| `./scripts/vacuity.sh` | "vacuity: OK"; against this tree's previous run (FS124-L1's): declarations 15370 → 15969, refutations-skipped 226 → 228, sites 1448 → 1454, generic 1405 → 1411; **six new sites, all `GENERIC`, all the binder `AeColouring k`** (stage 5) | 117.9 s | 0.59 GiB | 4.50 GiB |
| `./scripts/assumptions.sh` | **exit 1, three failures, one kind, expected**: `FAIL unlisted-consumer` for the three theorems that rest on `proper_to_borel_weak` and are not yet in the ledger; "rests 23 → 26"; nothing else fails (stage 4) | 105.7 s | 0.66 GiB | 4.55 GiB |

**Why the scans ran first.** The order of the steps before the final pass is this job's to choose, and the docstring
corrections recompile 117 modules (stage 2): had a scan asked for a word in the new module's docstrings, a second
build would have followed. None does: the lint is clean on the module as given, the vacuity scan fails nothing, and
the assumptions step fails only on the ledger rows the landing is to write.

## Stage 2 — SAVED (FS131-LC1): the docstring corrections, one build, and this machine's first measurement of a build that recompiles real modules

### The corrections (docstrings and module headers only; no statement)

*The coordinator was told before the gate and extended this job's touches to match (the brief's Amendment 1, 18:00 UTC,
on `main` at `ec4ea081d`): the four further lines of the same slip, the five fixes in the new module, and
`scripts/axioms-controls.txt` (stage 3).*

**The three named in the brief, from the planner's drafts:**
- `Plane.chiM` (`Plane/FalconerReduction`) — the planner's draft, verbatim: "`χ_B(ℝ²)`, the **Borel** chromatic number
  of the plane: the least `k` with a Borel-measurable `k`-colouring proper at every unit pair. Falconer's number, with
  Lebesgue-measurable classes, is `Plane.chiLebesgue` (`Plane/LebesgueNumber`), and `chiLebesgue ≤ chiM`."
- `Plane.le_chiM_of_falconerFan` — verbatim: "**FS129-SA1-FALC-RED**, its conclusion for the Borel chromatic number:
  `χ_B(ℝ²) ≥ k + 1`."
- `Plane.AeColouring` — the planner's draft with one change: its parenthesis names **both** theorems
  (`Plane.exists_proper_of_nullMeasurable_weak`, `Plane.exists_aeColouring_of_nullMeasurable_proper`). The draft named
  the first only, and "the number is the same" needs both: a Lebesgue weak colouring gives a Lebesgue proper one by
  the first, and that gives a Borel weak one by the second. The composition is kernel-checked as a term
  (`FS131LC1.lebesgue_weak_iff_nonempty_aeColouring`, `data/fs131/lc1/checks.lean`, the standard three). `Plane.chiM0`'s
  docstring gains the sentence the brief describes: an `AeColouring` is a Borel map, the Lebesgue number of the same
  kind is the same, and it is `Plane.chiLebesgue` (`Plane.chiM0_eq_chiLebesgue`).

**Four more lines of the same slip, in the two files those three already recompile** (a later fix would cost a second
build of 117 modules): `Plane/FalconerReduction`'s module title ("gives `χ_m(ℝ²) ≥ k + 1`" → `χ_B`, with a paragraph
"Which number": its sets are `MeasurableSet`s and `chiM`'s maps are `Measurable`, so the bound is on the Borel number,
and `chiLebesgue ≤ chiM` points the other way) and its spec example's docstring (`χ_m` → `χ_B`); `Plane/AeColouring`'s
module header (a colouring there is a total **Borel**-measurable function; the Lebesgue number is the same, the two
theorems named) and the field's docstring ("The colouring is Lebesgue measurable." → "Borel measurable.").

**Five in the new module, from the read-aloud** (stage 6 gives the reasons): the standing hypotheses at
`davies_lemma_B1_euclidean` ("`D ⊆ (0, ∞)` finite and nonempty …: `D` is any set of reals"); the density-point step's
attribution, twice (the header; `AeColouring.core_dist_ne_one`); "which Mathlib proves from Tychonoff's theorem";
`exists_proper_of_aeColouring`'s sentence on six colours, which now names the two declared outside theorems it holds
under.

**No statement changed.** In text (`data/fs131/lc1/code_only_diff.py`, every block comment removed, against the commit
before the edits, `e9e7cd2de`): `Plane/AeColouring` 929 characters of code before and after, `Plane/FalconerReduction`
33,156, `Plane/LebesgueNumber` 19,746 — "SAME" three times (`code-only.out`); its plant, one code character altered,
reads "DIFFERS" three times (`code-only-plant.out`). **From the kernel's side** (`StatementDump.lean`, read by
`tools/fs124_l2_statements.py`): every constant of the three modules' compiled data, stored type and a definition's
stored value, dumped before any edit (`statements/before.compact`, at `b6e5abfab`) and after the build
(`statements/after-build1.compact`): "statements: PASS: no statement and no definition changed — 87 named constants
compared in 3 module(s)" (`statements/diff-before-vs-build1.txt`); four plants — a stored type changed, a definition's
value changed, a constant dropped, one added — each fired (`statements/diff-plant.txt`). The three edited files
elaborate alone with no message (`probes/syntax-*.log`).

### The build

`data/fs131/lc1/run-build.sh 1 10 8 2` — `./scripts/build.sh` under the slot, `--mem 10 --cpus 8`, `MEMMAX=10G BATCH=2`
(`data/fs131/lc1/build-1.log`; Lake's full output `build/gate/build/20261013T175432Z-351432.log`, 0 lines holding
"warning"):

> ==> build: OK — 946 of 946 batches, 117 module(s) rebuilt, 0 module(s) with warnings, 47m22s

**117 modules, the number predicted before the build** (`data/fs131/lc1/dependents.py`, `dependents.out`: the three
edited modules and every module of `Proofs/` that imports one, 114 of them — `Plane/Cover` and its cone, the `ValidMap`,
`Saturated`, `SixRing`, `RingCalculus` and `Woodall` families, the ten `Outside/OAI158*` modules, FS-124's, and the
root).

| measured on the laptop (12 cores, 31 GB), this build | |
|---|---|
| wall | 47 m 22 s (2,846 s with the slot's admission; the slot was free) — against 24 m 18 s for the walk that rebuilt ten small modules (FS131-KC1): about 23 minutes of compiling, the rest is Lake started 947 times |
| largest single compiler | **5.5 GiB resident** (5,533 MiB), `Plane/CoverExamples`, which is also the slowest module (134 s); then `ValidMap/BaseSteps` 102 s, `ValidMap/UnitArc` 100 s, `ValidMap/MergeMove` 84 s, `SVMap` 75 s |
| largest sum over the compilers of one batch | **8.0 GiB resident** (8,027 MiB), two processes: `Plane/SVMap` and `Plane/CoverExamples` — resident sets count the mapped `.olean` pages in each process, so the sum counts shared pages twice |
| the sampler | `data/fs131/lc1/sample-lean.sh`: every 5 s, the `lean` processes whose working directory is this worktree (by `/proc/<pid>/cwd`, never by a command line), 566 samples; `build-1.rss` |

**What the numbers say for the next build here.** At `BATCH=2` no batch came near the 10 GiB cap as the kernel charges
it (mapped `.olean` pages already in the page cache are not charged to the batch's scope). A wider batch is safe when
the stale set is known and small: the passes that follow rebuild the new module and the root only, one compiler at a
time, and use `BATCH=10` to start Lake 190 times instead of 947. **If this build had died**: the same command again —
Lake rebuilds what is not yet built, so the redo is the batch in flight and the walk.

**After the build**: the checks file elaborates with no message (`probes/checks-after.log`; against the print made
before the edits it differs by the two terms added since, nothing else).

## Stage 3 — SAVED (FS131-LC1): the registrations

**What the landing brings, as the kernel lists it** (`data/fs131/lc1/decls.lean`; `probes/decls-before.log`): 41
constants in `Plane/LebesgueNumber`; **34 declarations a person typed — 31 theorems and 3 definitions**
(`HasDensityOneAt`, `Plane.AeColouring.core`, `Plane.chiLebesgue`); the other seven are the elaborator's
(`HasDensityOneAt.eq_1` and six `match_1_n`).

**Thirty-four records in `scripts/Axioms.lean`, each under the banner its axioms put it under** — generated from the
kernel's list (`data/fs131/lc1/records.py DECLS --block`; the text is `data/fs131/lc1/audit-block.txt`):
- **three under IMPORTED**, after FS124-I1's lines, headed "FS131-KC1: the measurable number's records resting on
  `proper_to_borel_weak`": `Plane.colorable_iff_exists_nullMeasurable_proper`,
  `Plane.chromaticNumber_plane_eq_chiLebesgue`, `Plane.chromaticNumber_euclidean_plane_eq_chiLebesgue`. The section's
  prose now reads "with six and twelve" and names where the three come from;
- **thirty-one under CLEAN**, one block above the PURCHASED banner, headed "FS131-LC1": 28 theorems and the 3
  definitions.

**Where the count differs from the planner's and why**: the planner counted fourteen (eleven clean, three imported) —
the headline rows of its table; the brief asks for every declaration a person typed, as the last three landings filed
theirs, so the audit gains 34 records. The three imported are the planner's three. `records.py … --unfiled`:
"declarations the landing brings: 34 (of 41 constants in 1 modules); with one line: 34; unfiled: 0; doubled: 0"; the
script holds 7,454 `#print axioms` lines (`main`'s 7,420 + 34), no name twice.

**The audit on the registered tree** (`./scripts/axioms.sh`; `probes/axioms-probe.log`): exit 0 —

> audited: 7454 records — 7395 clean on the standard axioms, 28 axiom-free, 26 imported (resting on a declared outside theorem), 5 declared purchase(s)

Against `main` (7364 clean, 28 axiom-free, 23 imported, 7,420 records): clean +31, imported +3, records +34;
axiom-free and purchases do not move. The digest reads `CLAUDE.md` § Trust ledger as stale ("7364 clean → 7395, 23
imported → 26"), as it must until refiled (draft 1).

**Each filed on what it rests on, read from the audit's own output** (`data/fs131/lc1/records.py`, after
`tools/fs124_l1_records.py`, whose table of the twenty-three earlier imported records it imports;
`probes/records-probe.txt`): "records: PASS" — "landing records on exactly the three: 31", "landing records on the
three and proper_to_borel_weak: 3"; each of the eleven theorems the front page will say need no outside theorem
"under CLEAN: [Classical.choice, Quot.sound, propext]"; over the whole log "records carrying kloosterman_bound: 8
(filed: 8); of the landing's: 0", "no_proper_five_coloring: 6 (filed: 6); of the landing's: 0", "proper_to_borel_weak:
12 (filed: 12); of the landing's: 3"; "records under IMPORTED 26; carrying two imports 0; carrying sorryAx 0".
**Sixteen plants, in memory, one at a time, every one fired** (`probes/records-plant-probe.txt`): a record dropped;
doubled; `sorryAx` under one; a clean record on the transfer; on the five-colour theorem; one filed under IMPORTED;
one under PURCHASED; a native auxiliary; **the headline filed on the wrong import**; **the colour-by-colour form
printed under CLEAN**; the Euclidean form carrying both imports; **`chiM0_eq_chiLebesgue` — the claim that needs no
import — resting on the transfer**; the formalized lemma printed under IMPORTED; a theorem with no record; an earlier
record on the transfer stripped of it; the module absent from the dump.

**The audit's self-test, and its two controls that read the library's state**
(`probes/axioms-selftest-red.log`, then `probes/axioms-selftest-probe.log`). With the controls as on `main`: **exit 1,
red at 2 of 23, the two the file's own header names** — `baseline` ("expected COUNTS imported=23") and
`imported_declared` ("expected COUNTS imported=24"): the landing files twenty-six. The other 21 behaved. By the file's
rule ("a later record resting on a declared import, moves them again — … `imported` by its records, the `old`
digests' texts follow"; FS124-L1's edit is the pattern) `scripts/axioms-controls.txt` moves in four places and its
header's sentence: 23 → 26, 24 → 27, and the two `old` digest texts. After: exit 0, "axioms self-test: OK — every
planted fault fired, and every partner passed" (23 of 23). The file is outside the brief's first list of touches and
inside its Amendment 1.

**`ARCHITECTURE.md`**: § Trust, the row of `Outside.OAI158.proper_to_borel_weak` gains the three names and reads
"twelve records" (the planner's draft 7); § 3, two rows lose the slip the docstrings lost — `Plane/FalconerReduction`
("`chiM` (the Borel number `χ_B(ℝ²)` … Falconer's `χ_m`, with Lebesgue-measurable classes, is
`Plane/LebesgueNumber`'s `chiLebesgue`, and `chiLebesgue ≤ chiM`)", for "`chiM` (Falconer's `χ_m`)") and
`Plane/AeColouring` ("a Borel-measurable `ℂ → Fin k`"). The module's own row is the planner's.
`tools/check_architecture.py`: exit 0, "RESULT: PASS" (`probes/arch-probe.out`).

**The doubled-name check on the built tree** (`./scripts/dupnames.sh`; `probes/dupnames-probe.log`): exit 0,
"dupnames: OK — no name is declared by two modules (24 generated on demand, listed above)".

| step, this machine | wall | peak (charged) | max-rss |
|---|---|---|---|
| `./scripts/axioms.sh` (7,454 records) | 8.1 s | 1.07 GiB | 4.91 GiB |
| `./scripts/axioms.sh --self-test` (23 controls) | 170 s | 1.23 GiB | 5.02 GiB |

## Stage 4 — SAVED (FS131-LC1): what the library assumes

`./scripts/assumptions.sh --self-test` first (`data/fs131/lc1/probes/assumptions-selftest-first.log`): exit 0, "OK —
all 33 checks behaved: every planted fault fired, and every partner stayed silent". Then the step
(`probes/assumptions-first.log`; the same on the tree as given, stage 1): **exit 1, three failures, one kind, each a
row the landing is to write**:

```
FAIL unlisted-consumer HadwigerNelson.Plane.chromaticNumber_euclidean_plane_eq_chiLebesgue :: the scan finds 'RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Plane.chromaticNumber_euclidean_plane_eq_chiLebesgue' and the ledger does not list it
FAIL unlisted-consumer HadwigerNelson.Plane.chromaticNumber_plane_eq_chiLebesgue :: … and the ledger does not list it
FAIL unlisted-consumer HadwigerNelson.Plane.colorable_iff_exists_nullMeasurable_proper :: … and the ledger does not list it
```

**The ledger, written with the script's own flag** (`./scripts/assumptions.sh --write-ledger`;
`probes/assumptions-write-ledger.log`: "ledger written (125 rows) — read the rows above; a row is a theorem that is
conditional"). `git diff scripts/assumptions-ledger.txt`: **three rows gained, none lost**, and the header's count
line:

```
+RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Plane.chromaticNumber_euclidean_plane_eq_chiLebesgue
+RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Plane.chromaticNumber_plane_eq_chiLebesgue
+RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Plane.colorable_iff_exists_nullMeasurable_proper
-#   axioms=3 rests=23 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1
+#   axioms=3 rests=26 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1
```

Each row read: each of the three is a statement that is now conditional on `[OAIMath2026]`'s transfer — `χ(ℝ²) =
χ_m(ℝ²)` in its two forms and colour by colour. They are the three the audit prints under IMPORTED (stage 3).

After it (`probes/assumptions-second.log`): **exit 0** — "assumptions: OK — 3 outside theorem(s) as axioms, with 26
theorem(s) resting on them; 19 named and 16 inline hypotheses (7 outside, 23 ours, 5 open), taken by 98 statement(s)
and mentioned by 1"; "recorded counts in scripts/assumptions-ledger.txt's header: match (9 of 9 compared)";
`CLAUDE.md` § Trust ledger flagged stale, "rests 23 → 26" (draft 3).

| | `main` (FS124-L2's gated scan) | this tree |
|---|---|---|
| `scanned` | constants=15036 theorems=11225 formers=361 hypotheses=19527 closed=1473 | constants=15071 theorems=11257 formers=362 hypotheses=19578 closed=1473 |
| the nine | axioms=3 **rests=23** named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1 | axioms=3 **rests=26** named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1 |
| the rest | conditions=40 … silent=1 cohyp=58 hints=0 unseen=17480 fails=0 | conditions=40 … silent=1 cohyp=58 hints=0 unseen=17512 fails=0 |

**Of the nine counts, one moves: `rests` 23 → 26.** No theorem of the module takes an assumption in hypothesis form
(no `TAKES` row; `closed=1473`, `main`'s count: no closed hypothesis enters), so `scripts/Assumptions.lean` is
untouched — no `.former`, no `.site`, no `.condition`. The one new `Prop`-former, `HasDensityOneAt`, is concluded by
a library theorem (`hasDensityOneAt_univ`), so the step reads it without a declaration.

**The 32 hypotheses the step counts and cannot decide (`unseen` 17480 → 17512), read by hand, on this job's word**:
every hypothesis of the module is a condition on its theorem's own variables — the relation's translation
invariance (`hR`), the measurability of a given colouring or family (`hc`, `hA`, `hVm`, `hf`), a given set conull
(`hS`, `hcov`), a given colouring proper on it or everywhere (`hproper`), given sets avoiding the relation (`havoid`),
given classes with null unit pairs (`hnull`), densities and memberships at given points. None is a hand result of
this project or an outside theorem written out in a binder; the one outside theorem the module uses enters as the
declared axiom, through `Outside.OAI158.colorable_iff_nonempty_aeColouring` and `chromaticNumber_plane_eq_chiM0`.

| step, this machine | wall | peak (charged) | max-rss |
|---|---|---|---|
| `./scripts/assumptions.sh` | 112 s | 0.66 GiB | 4.59 GiB |
| `./scripts/assumptions.sh --self-test` (33 checks) | 112 s | 0.69 GiB | 4.63 GiB |

## Stage 5 — SAVED (FS131-LC1): the vacuity step

`./scripts/vacuity.sh` on the built tree (`data/fs131/lc1/probes/vacuity-probe.log`; its full output
`probes/receipt-vacuity-probe.log`): **exit 0, "vacuity: OK"**. Its self-test
(`probes/vacuity-selftest-probe.log`): "OK — all 65 controls behaved: every one fired, and the silent ones stayed
silent."

| | `main` (FS124-L2's gated scan) | this tree |
|---|---|---|
| declarations | 15928 | **15969** (+41: the module's 41 constants) |
| refutations-skipped | 228 | 228 |
| sites | 1448 | **1454** (+6) |
| vacuous / stale / declared / witnessed / generic / unknown | 0 / 0 / 3 / 38 / 1405 / 2 | 0 / 0 / 3 / 38 / **1411** / 2 |

**How the scan classes every new site: six, all `GENERIC`, all one binder — `(a : AeColouring k)`.** Row for row
against the last landing's gated scan (`tools/fs131_l5_vacdiff.py`, `probes/vacdiff-probe.txt`): "main rows 1529,
landing rows 1535; lost 0 …; added 6", "added SITE GENERIC on AeColouring: 6", "added rows in Plane.LebesgueNumber:
6", "by module: declarations +41, refutations +0: equal to the scans difference", "vacdiff: PASS". The six:
`AeColouring.core`, `.measurableSet_core`, `.core_dist_ne_one`, `.volume_compl_iUnion_core`, `.col_eq_of_mem_core` and
`exists_proper_of_aeColouring`. Nothing reads `VACUOUS`, `STALE` or `UNKNOWN`; the baseline's two entries are as on
`main`; **no declaration of the module is skipped as a refutation.** Unlike the last three landings' modules, this one
is not silent to the scan where it takes the library's tracked carrier; where its colourings are bare maps
(`c : E → Fin k`, `f : ℂ → Fin k`) under `NullMeasurable` and properness, the scan has no site, and silence is not
evidence.

**`GENERIC` is the scan saying it cannot decide: `k` is the caller's.** By hand, where `AeColouring k` is inhabited:
at `k = 7` (`r7_aeColouring`, a library theorem with no import) and at `k = 9` (`FS131LC1.model_converse`, a term);
empty at `k = 0, 1` (the library's instances) and at `k ≤ 5` given the declared outside theorem
`Outside.OAI158.no_proper_five_coloring` (`Outside.OAI158.six_le_chiM0`); **at `k = 6` its inhabitation is the
Hadwiger–Nelson problem** given the two declared outside theorems. `exists_proper_of_aeColouring`'s docstring says
all three.

**The baseline header's two count lines refiled from this scan** (`scripts/gate_report.py header` on the scan's
output, written into `scripts/vacuity-baseline.txt`; no entry touched): `declarations=15928 … sites=1448` →
`declarations=15969  refutations-skipped=228  sites=1454`, `generic=1405` → `generic=1411`. Refiled **before** the
pass, so that the gated commit holds the header its own scan confirms and nothing under `scripts/` moves after it.

**The model of each hypothesis of the headlines, by hand**, and whether the kernel holds it — "library" is a theorem
or an `example` of a module, checked in the build; "term" is a theorem of `data/fs131/lc1/checks.lean`, kernel-checked
when the gate's pass elaborates it and not a library theorem (every term on the standard three unless said):

| statement | its hypotheses | the model | held |
|---|---|---|---|
| `exists_proper_ae_eq_of_proper_on_conull` (the core) | a finite-dimensional real normed space with a Haar measure; `R` invariant under translations; `c` Lebesgue measurable; `S` conull; `c` proper for `R` on `S` | the plane, Lebesgue measure, the unit distance, and **two colourings**: (i) the nine classes of `sq9Col`, `S` the plane — the module's first `example`, through `Plane.davies_lemma_B1`, the selector and the core; (ii) the colouring of `r7_aeColouring` with `S` the union of its cores — the module's second `example`, through `exists_proper_of_aeColouring`. In (ii) the lemma does something: `r7Col` is not proper (`FS131LC1.r7Col_not_proper`) and `S` is not the plane (`FS131LC1.model_core_ne_univ`) | library; the two facts about (ii), terms |
| `exists_proper_nullMeasurable_of_avoiding_cover`, `Plane.davies_lemma_B1` | Lebesgue-measurable sets `A i`, none holding a pair in `R`, with conull union | the nine classes of `sq9Col` (measurable, no unit pair, covering): the module's first `example` | library |
| `davies_lemma_B1_euclidean` | the same in `ℝ^d` for a set `D` of distances | **the library runs it on no object.** `FS131LC1.model_euclidean`: `d = 2`, `D = {1}`, `k = 9` — the paper's own standing hypotheses — the nine classes carried to `EuclideanSpace ℝ (Fin 2)` by the isometry `Complex.orthonormalBasisOneI.repr`, every hypothesis at once | **term** |
| `exists_proper_of_aeColouring` | `a : AeColouring k` | `r7_aeColouring` (`k = 7`): the module's second `example` | library |
| `exists_proper_of_nullMeasurable_weak` | `c` Lebesgue measurable, each class with null unit pairs | `r7Col`: `FS131LC1.model_weak` (the library's `example` runs the `AeColouring` form, which this one reduces to) | term |
| `exists_aeColouring_of_nullMeasurable_proper` | `f` Lebesgue measurable, proper at every unit pair | `sq9Col`: `FS131LC1.model_converse`; in the library it is used inside `chiM0_le_chiLebesgue` | term |
| `nonempty_aeColouring_iff_exists_nullMeasurable_proper`, `colorable_iff_exists_nullMeasurable_proper` | none (`k` free) | both sides hold at `k = 7` (`FS131LC1.model_seven`); both fail at `k = 5` given `no_proper_five_coloring` (`FS131LC1.not_exists_five`, whose axioms print that import); at `k = 6` they are the open problem | term |
| `chiM0_eq_chiLebesgue`, `chiLebesgue_le_chiM`, `chromaticNumber_plane_le_chiLebesgue`, `chromaticNumber_plane_eq_chiLebesgue` and its Euclidean form | none | — the infima are over families that are not empty (nine: the module's `example`) | library |
| `exists_translate_mem` | finitely many Lebesgue-measurable sets, `V x` of density one at `x` | `V x = univ` (`FS131LC1.model_translate`): the degenerate one its docstring names; its real use is inside the core's proof, at the colour classes cut to a conull set, which the two `example`s run | term; library through the core |
| `exists_nullMeasurable_selector` | `0 < k`, Lebesgue-measurable sets | the nine classes, through the first `example` | library |
| `HasDensityOneAt.inter` and the four density lemmas | `HasDensityOneAt μ s x` | `hasDensityOneAt_univ` concludes the former; through the core's proof, every colour class at almost every point | library |
| the four lemmas on `AeColouring.core` | `a : AeColouring k` | `r7_aeColouring`, through the second `example` | library |

**No hypothesis of a headline is without a kernel model; the Euclidean form's, the Lebesgue weak form's and the
converse's are terms** (open gate item 3). **No older statement is emptied by this landing**: it brings no axiom, and
the carrier it reads (`AeColouring k`) was the library's before it.

| step, this machine | wall | peak (charged) | max-rss |
|---|---|---|---|
| `./scripts/vacuity.sh` | 125 s | 0.59 GiB | 4.53 GiB |
| `./scripts/vacuity.sh --self-test` (65 controls) | 125 s | 0.60 GiB | 4.54 GiB |
| the scan's counter (`data/fs131/l5/count-modules.lean`) | see `probes/measure.txt` | | |

## Stage 6 — SAVED (FS131-LC1): read aloud — each headline against its claim line and the dated line, the lemma against the page, the definition against the paper's

*The statements are read as the kernel holds them: `#check @…` and `#print` of `data/fs131/lc1/checks.lean`, elaborated
with the lakefile's two options (`probes/checks-before.log` before any edit; again in the gate's pass,
`gate/checks-final.out`). The page is `[Davies2026]` as rendered: p. 2, p. 44, p. 46. A sentence in quotation marks is
the paper's or the claim list's; a line in code is the kernel's.*

### The definition: `Plane.chiLebesgue` against the paper's measurable chromatic number (p. 2)

The paper, p. 2: "The Hadwiger-Nelson problem asks for the chromatic number of the plane: the minimum number of colours
needed to colour ℝ² so that points at distance 1 receive different colours." And: "Requiring the colour classes to be
Lebesgue measurable gives the measurable chromatic number χ^(m)(ℝ^d)."

```
def HadwigerNelson.Plane.chiLebesgue : ℕ∞ :=
⨅ k, ⨅ (_ : ∃ f, NullMeasurable f volume ∧ ∀ (x y : ℂ), dist x y = 1 → f x ≠ f y), ↑k
```

| the paper's clause | the kernel's | read |
|---|---|---|
| "the minimum number of colours" | the infimum in `ℕ∞`, over `k : ℕ`, of `k` such that a colouring `f : ℂ → Fin k` with the two properties exists; `⊤` if none | the same: an infimum of a set of naturals that is not empty (nine: the module's `example`; seven: `FS131LC1.chiLebesgue_le_seven`, a term) is attained. A map into `Fin k` uses at most `k` colours |
| "ℝ²" | `ℂ`, with its distance `dist x y = ‖x − y‖` and its measure `volume` | the Euclidean plane as this library holds it everywhere (`Plane/`); `volume` on `ℂ` is the Lebesgue measure of the plane (an additive Haar measure: `inferInstance : volume.IsAddHaarMeasure`, printed). **The number is defined over `ℂ` only**: no `EuclideanSpace ℝ (Fin 2)` form of it is stated — the headline in row 33's form has `EuclideanSpace` on its left side and this number on its right |
| "so that points at distance 1 receive different colours" | `∀ (x y : ℂ), dist x y = 1 → f x ≠ f y` | **every** pair at distance one, no exception |
| "the colour classes … Lebesgue measurable" | `NullMeasurable f volume`: the preimage of every set of colours is a `NullMeasurableSet` for `volume` — a set equal, off a null set, to a Borel set; that is the Lebesgue σ-algebra of the plane, the completion of the Borel sets under Lebesgue measure | **Lebesgue, not Borel.** In the paper's own words by a kernel theorem: `nullMeasurable_iff_forall_fibre : NullMeasurable f volume ↔ ∀ (j : Fin k), NullMeasurableSet (f ⁻¹' {j}) volume` — each colour class a Lebesgue-measurable set |

**Which measurability, which pairs:** Lebesgue-measurable classes; every unit pair. It is the paper's `χ^(m)(ℝ²)` and
Falconer's number. It is not `Plane.chiM` (`⨅ k, ⨅ (_ : ∃ f, Measurable f ∧ ∀ x y, dist x y = 1 → f x ≠ f y), ↑k`:
`Measurable` on `ℂ` is Borel) and not `Plane.chiM0` (an `AeColouring k`: a Borel map, each class with
`UnitPairsNull` — proper at almost every unit pair). Sanity of the definition, as terms and `example`s, none a claim:
`5 ≤ chiLebesgue` and `chiLebesgue ≤ 9` (the module's `example`s, the standard three), `chiLebesgue ≤ 7`
(`FS131LC1.chiLebesgue_le_seven`, the standard three), `6 ≤ chiLebesgue` given the *other* declared outside theorem
(`FS131LC1.six_le_chiLebesgue`; its axioms print `no_proper_five_coloring`).

### The lemma against the page (p. 44), clause by clause, with its standing hypotheses

The page. Standing: "Throughout, D = {d₁, …, d_t} ⊆ (0, ∞) is finite and nonempty, d ⩾ 2, and k ⩾ 2." Before the lemma:
"We first show that a measurable proper colouring of a conull set can, after changes on a null set, be extended to a
measurable proper colouring of ℝ^d. We suspect that this is a folklore result, but have not found it in the
literature." **Lemma B.1.** "Suppose that A₁, …, A_k ⊆ ℝ^d are measurable D-avoiding sets whose union is conull. Then
ℝ^d admits a measurable proper k-colouring of its D-distance graph." (p. 2: "A set is D-avoiding if it contains no pair
of points at a distance in D"; "the graph whose edges join points at distances in D".)

```
@davies_lemma_B1_euclidean : ∀ {d : ℕ} (D : Set ℝ) {k : ℕ} {A : Fin k → Set (EuclideanSpace ℝ (Fin d))},
  (∀ (i : Fin k), NullMeasurableSet (A i) volume) →
    (∀ (i : Fin k), ∀ x ∈ A i, ∀ y ∈ A i, dist x y ∉ D) →
      volume (⋃ i, A i)ᶜ = 0 →
        ∃ f, NullMeasurable f volume ∧ (∀ᵐ (x : EuclideanSpace ℝ (Fin d)), x ∈ A (f x)) ∧
              ∀ (x y : EuclideanSpace ℝ (Fin d)), dist x y ∈ D → f x ≠ f y
```

| the page's clause | the kernel's | read |
|---|---|---|
| "A₁, …, A_k ⊆ ℝ^d" | `A : Fin k → Set (EuclideanSpace ℝ (Fin d))` | `k` sets, indexed `0 … k − 1`, in `ℝ^d` with its Euclidean distance and Lebesgue measure |
| "are measurable" | `∀ i, NullMeasurableSet (A i) volume` | Lebesgue measurable — the paper's sense (p. 2; its proof ends "so the colouring is Lebesgue measurable"), and the weaker reading of the hypothesis: a Borel set is one, so the theorem covers both |
| "D-avoiding" | `∀ i, ∀ x ∈ A i, ∀ y ∈ A i, dist x y ∉ D` | no two points of one set at a distance in `D` (with `x = y`: `0 ∉ D` wherever a set is not empty — automatic for the paper's `D ⊆ (0, ∞)`) |
| "whose union is conull" | `volume (⋃ i, A i)ᶜ = 0` | the same |
| "Then ℝ^d admits a measurable proper k-colouring of its D-distance graph" | `∃ f : EuclideanSpace ℝ (Fin d) → Fin k, NullMeasurable f volume ∧ … ∧ ∀ x y, dist x y ∈ D → f x ≠ f y` | a Lebesgue-measurable map into `k` colours, proper at every pair at a distance in `D` |
| — (the proof's last line: "Each colour class differs from A_i only within the null set ℝ^d ∖ A") | the middle conjunct, `∀ᵐ x, x ∈ A (f x)` | **more than the printed statement**, and what its proof gives: almost every point lies in a given set of its own colour |
| standing: "D = {d₁, …, d_t} ⊆ (0, ∞) is finite and nonempty" | `(D : Set ℝ)`, nothing asked | **not asked**: any set of reals. With `0 ∈ D` or with no avoiding cover the hypotheses cannot be met and the theorem says nothing; it is never false |
| standing: "d ⩾ 2" | `{d : ℕ}`, nothing asked | **not asked** |
| standing: "k ⩾ 2" | `{k : ℕ}`, nothing asked | **not asked**; at `k = 0` the hypotheses are contradictory (a Haar measure of the whole space is not zero), which the proof of `exists_proper_nullMeasurable_of_avoiding_cover` derives |

**So the kernel's lemma says more than the page's, in two ways the claim list's dated line accepts** ("the general form
the planner found comes free"): fewer hypotheses, and one more conclusion. The printed proof's six steps are FS131-KC1's
table (its record, § Stage 3); read here against the module: step 3's sentence is the docstring of
`exists_translate_mem`, word for word from the page, and step 5 is `Finset.rado_selection`, which Mathlib proves from
Tychonoff's theorem (its module header: "The proof uses the fact that the product of finite discrete spaces is compact
(by Tychonoff's theorem)").

The sentence before the lemma, against the core:

```
@exists_proper_ae_eq_of_proper_on_conull : ∀ {E : Type u_1} [inst : NormedAddCommGroup E] [inst_1 : NormedSpace ℝ E]
  [FiniteDimensional ℝ E] [inst_3 : MeasurableSpace E] [BorelSpace E] (μ : Measure E) [μ.IsAddHaarMeasure]
  {R : E → E → Prop}, (∀ (ξ x y : E), R x y → R (x + ξ) (y + ξ)) →
    ∀ {k : ℕ} {c : E → Fin k}, NullMeasurable c μ → ∀ {S : Set E}, μ Sᶜ = 0 →
      (∀ x ∈ S, ∀ y ∈ S, R x y → c x ≠ c y) → ∃ f, NullMeasurable f μ ∧ f =ᵐ[μ] c ∧ ∀ (x y : E), R x y → f x ≠ f y
```

"a measurable proper colouring of a conull set" — `c`, Lebesgue measurable, proper for `R` on `S`, `μ Sᶜ = 0` (`c` is
total and read for properness only on `S`; its values off `S` cannot spoil measurability, the complement being null);
"can, after changes on a null set" — `f =ᵐ[μ] c`; "be extended to a measurable proper colouring of ℝ^d" —
`NullMeasurable f μ ∧ ∀ x y, R x y → f x ≠ f y`. In place of `ℝ^d` and "at a distance in `D`": any finite-dimensional
real normed space with its Borel σ-algebra and an additive Haar measure, and any relation carried to itself by every
translation — neither symmetry nor irreflexivity is asked. The plane's form, `Plane.davies_lemma_B1`, is the
Euclidean one at `ℂ` and `dist x y = 1`.

### NF3-PRINTED

The claim line is the page's statement with its standing hypotheses and the sentence before it; the table above is
its reading. **Kernel theorems**: `exists_proper_ae_eq_of_proper_on_conull`,
`exists_proper_nullMeasurable_of_avoiding_cover`, `davies_lemma_B1_euclidean`, `Plane.davies_lemma_B1`, each on
`[propext, Classical.choice, Quot.sound]`. Formalized with the printed proof, not imported: no `axiom` enters with
the module.

### NF3-WEAK-TO-PROPER — **the claim's first clause says more than the kernel holds**

The claim: "a weak measurable `k`-colouring of `ℝ^d` (Lebesgue measurable, proper at almost every pair at a distance in
a finite `D`) gives a Lebesgue-measurable `k`-colouring proper at every such pair; so `χ_m⁰(ℝ²) = χ_m(ℝ²)`."

```
@exists_proper_of_nullMeasurable_weak : ∀ {k : ℕ} {c : ℂ → Fin k}, NullMeasurable c volume →
    (∀ (j : Fin k), UnitPairsNull (c ⁻¹' {j})) →
      ∃ f, NullMeasurable f volume ∧ f =ᵐ[volume] c ∧ ∀ (x y : ℂ), dist x y = 1 → f x ≠ f y
chiM0_eq_chiLebesgue : chiM0 = chiLebesgue
```

- **Less than the first clause**: the plane and the unit distance, not `ℝ^d` and a finite `D`. The step that does not
  come free is the density-point step (the library's `UnitPairsNull` is a set of pairs `(x, θ)` in `ℂ × ℝ`); the lemma
  itself is in every dimension. The planner's report says so, NF3-NC allows it ("anything in dimension other than two
  or for distance sets other than the unit distance beyond what a planner finds comes free" is not claimed), and the
  coordinator was sent the difference before the gate ran. **The `ℝ^d` clause stays [hand]**; what is regraded is the
  plane's clause and the equality.
- "Lebesgue measurable" — `NullMeasurable c volume`. "proper at almost every pair" — `∀ j, UnitPairsNull (c ⁻¹' {j})`:
  `UnitPairsNull A` is `(volume.prod arcLength) (unitPairSet A) = 0`, the pairs `(x, x + e θ)` of one class null for
  plane measure times arc length. "proper at every such pair" — the last conjunct. **More than the claim**: the new
  colouring equals the old one almost everywhere.
- "so `χ_m⁰(ℝ²) = χ_m(ℝ²)`" — `chiM0 = chiLebesgue`. `chiM0` is the least `k` with an `AeColouring k`, a **Borel** map;
  the claim's `χ_m⁰` is the least `k` with a measurable colouring proper at almost every unit pair. They are one
  number: with `k` colours a Lebesgue-measurable such colouring exists exactly when a Borel one does
  (`FS131LC1.lebesgue_weak_iff_nonempty_aeColouring`, a term over `exists_proper_of_nullMeasurable_weak` and
  `exists_aeColouring_of_nullMeasurable_proper`, the standard three). On the standard three, no outside theorem.

### NF3-PLANE

The claim: "`χ(ℝ²) = χ_m(ℝ²)`, Falconer's number. **[derived]** from ER1-WEAK-TO-PROPER and the declared outside
theorem `Outside.OAI158.proper_to_borel_weak`; one mind; in neither paper as far as each was read."

```
chromaticNumber_plane_eq_chiLebesgue : (unitDistance ℂ).chromaticNumber = chiLebesgue
chromaticNumber_euclidean_plane_eq_chiLebesgue : (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber = chiLebesgue
@colorable_iff_exists_nullMeasurable_proper : ∀ {k : ℕ},
  (unitDistance ℂ).Colorable k ↔ ∃ f, NullMeasurable f volume ∧ ∀ (x y : ℂ), dist x y = 1 → f x ≠ f y
```

Read against Mathlib's `SimpleGraph.chromaticNumber : SimpleGraph V → ℕ∞` (the infimum over `n` of `G.Colorable n`) and
`unitDistance_adj : (unitDistance V).Adj x y ↔ dist x y = 1`: the left side is the least number of colours in a
colouring of the plane with no two points at distance one alike, over all maps; the right side is the same least
number over Lebesgue-measurable maps. **Aloud**: the plane can be coloured with `k` colours so that no two points one
unit apart share a colour exactly when it can be so coloured with every colour class a Lebesgue-measurable set.
Axioms, as printed: `[propext, Classical.choice, Quot.sound, Outside.OAI158.proper_to_borel_weak]` on each of the
three — the one declared outside theorem and no other; `no_proper_five_coloring` is not among them. The equality gives
no value, and none is stated.

### The dated line (2026-10-13 16:51 UTC)

"typed over a new definition of the Lebesgue number (the least k with a map `ℂ → Fin k` that is null-measurable for
Lebesgue measure and proper at every unit pair)" — `chiLebesgue`, read above. "with the inequality 'Lebesgue number ≤
`Plane.chiM`' beside them" — `chiLebesgue_le_chiM : chiLebesgue ≤ chiM`, the standard three. "`Plane.chiM` is
untouched" — its stored type and value are the ones dumped before any edit (`gate/statements-final.txt`); only its
docstring moved, to say what it is. "The core lemma is typed in the general form …, the plane and the unit distance as
its instance" — read above; the relation need not even be a graph.

### NF3-NC, against every docstring of the module

"that either statement is this project's theorem" — the module header opens "None of it is this project's beyond the
composing", and the headline's docstring says "A composition of two outside results". "any value" — none; the two
`example`s bound the definition for sanity. "anything about Borel classes where the statements say Lebesgue" — the
header's "What is not said", and `chiLebesgue_le_chiM`'s "Nothing is claimed in the other direction". "anything in
dimension other than two or for distance sets other than the unit distance beyond what … comes free" — the lemma in
every dimension is what came free; the weak-to-proper step and both equalities are the plane's. "that the printed
lemma is new" — the header quotes the paper's "We suspect that this is a folklore result".

### What the read-aloud changed in the module's docstrings (no statement; stage 2 lists the lines)

1. `davies_lemma_B1_euclidean`: its list of the paper's standing hypotheses dropped "⊆ (0, ∞)"; it now reads "`D ⊆
   (0, ∞)` finite and nonempty, `d ⩾ 2`, `k ⩾ 2` — are not used by its proof and are not asked: `D` is any set of reals".
2. The density-point step's attribution, in the header and at `AeColouring.core_dist_ne_one`: "printed in
   `[DeCorteOliveiraVallentin2022]` (proof of Lemma 5.6)" said more than the source — there the argument is for the
   density points of a support on a compact group ("Let I be the set of density points in the support of f … Claim: I
   is independent", printed p. 22), and `[Davies2026]` p. 46 says "We now follow the density-point argument in [24,
   proof of Lemma 5.6]". The docstrings now say: the argument of that proof, as `[Davies2026]` p. 46 follows it in `ℝ^d`.
3. "`Finset.rado_selection`, which is Tychonoff's theorem" → "which Mathlib proves from Tychonoff's theorem".
4. `exists_proper_of_aeColouring`: "whether one exists with six is Hadwiger–Nelson" is true given the two declared
   outside theorems, and now says so and names `Outside.OAI158.colorable_iff_nonempty_aeColouring`.

**One docstring's fact the library does not hold as a theorem**: the module's second `example` is headed "The step run
on a colouring that is not proper". That `r7Col` gives one colour to two points at distance one is true and
kernel-checked as a term — `FS131LC1.r7Col_not_proper`: the lattice point `0` and `3/7 + (5/7)ω`, at distance one
because `(3/7)² + (3/7)(5/7) + (5/7)² = 1`, both of colour `0` — and so is its consequence that the conull set handed
to the lemma there is not the plane (`FS131LC1.model_core_ne_univ`). Open gate item 2.

## Stage 7 — SAVED (FS131-LC1): before the pass — `main` merged once more, the two planted controls

**`main` merged in again** (`data/fs131/lc1/merge-2.out`): it had moved to `f3292e4bc` — `data/` 15 paths, `plans/` 2,
**nothing else** — carrying the brief's Amendment 1 and the claim list's dated line of 18:00 UTC; merged by hash,
automatic (`386087463`), so that the commit the gate reads holds them. The brief's quotations checked again on the
merged tree: 7 of 7. The drafts' slots read on `main` at that commit (`data/fs131/lc1/drafts-slots.py`,
`drafts-slots.out`): 14 of 14 found exactly once, the control absent.

**The zero-`sorry` search's plant** (`data/fs131/lc1/sorry-plant.sh`, after FS124-L2's; `sorry-plant.out`): a theorem
with a `sorry` body appended to `Plane/LebesgueNumber.lean`, never built, never committed — narrow lines 0 before, 1
with the plant, "PLANT FIRED: the search finds the planted sorry and nothing else"; restored by `git checkout`,
"RESTORED: the module is the text it was" (digest `9b0286a3…` before and after), narrow lines 0 again, 0 tracked files
modified.

**The lint's negative control** (`data/fs131/lc1/lint-plant.sh`, FS124-L2's script pointed at this module;
`lint-plant-run.out`): `theorem zz_lc1_lint_plant [Nonempty ℕ] : (1 : ℕ) = 1 := rfl` planted at the end of
`Plane/LebesgueNumber.lean` (never committed), built — "build: OK — 200 of 200 batches, 2 module(s) rebuilt, **0
module(s) with warnings**, 5m33s" at `BATCH=10` (`lint-plant-build.log`: the build's own linters do not see it) — then
the guarded lint: **exit 1**, "`unusedArguments`: (2/2) Failed with 1 messages", "error: @zz_lc1_lint_plant 1 unused
argument", and `synTaut` on the same plant (`lint-plant.log`). Restored by `git checkout` under a trap: the digest is
the one taken before, the plant's name in the file 0 times, 0 tracked files modified; the pass's build recompiles the
module and the root from the restored text. **This machine's second build measurement**: a walk at `BATCH=10` that
rebuilds two modules is 5 m 33 s (200 Lake starts), against 24 m 18 s at `BATCH=2`.
