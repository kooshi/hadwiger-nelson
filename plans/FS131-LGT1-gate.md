# FS131-LGT1 — the five-colour chain's landing, part 3: the full gate on one commit

*de Bruijn, the implementer (the gate-runner). Brief: `data/fs131/briefs/FS131-LGT1-gate.md` (main checkout, written
2026-10-15 00:17 UTC). Tree `.claude/worktrees/fs131-wq1`, branch `fs131-wlc`, started at `df6579be0`. Work files:
`data/fs131/lgt1/`.*

## Theorems this phase proved

None. This job writes the gate's inputs, runs the gate and reads the statements aloud; the theorems are the chain's
implementers' and the lander's (`plans/FS131-LCH1-join.md` § Theorems this phase proved).

## Stage 1 — SAVED (the readback)

**Quotations** (standing rule 3). FS131-LCH1's checker run unchanged by path, `tools/fs131_lch1_quotes.py <brief> <main
checkout> HEAD` (main at `6abec67d5`, which is the brief's commit `84311cfc6` plus one handoff commit): **6/6 blocks
match** (`data/fs131/lgt1/quotes.out`) — the request, NF2-LEAF-23 (`data/fs131/claims-NF2.md`), row 121 (`LEDGER.md`),
inventory items 940, 941, 942 (`plans/FS131-close-inventory.md`). The control mutates one character of every block:
**6/6 fail** (`quotes-plant.out`). No finding about the brief.

**The branch.** `git rev-parse HEAD` in the tree: `df6579be0bd0d5436a9971fd5ecba14c67887720`, branch `fs131-wlc`; no
tracked file modified. `git diff 2fcba050a HEAD -- . ':!plans' ':!data'`: **0 lines** — the sources are as at
`2fcba050a`, for which build 5 compiled the library. `main` since the merged `bd3bd9541` (to `6abec67d5`) has moved in
`plans/` and `data/` only (`git diff --name-only bd3bd9541 6abec67d5`, outside those: empty).

**What the join brings, by path** (`git diff --name-status bd3bd9541 HEAD -- Proofs`): **144 modules added** — 50 under
`Rigidity/`, 85 under `Arith/` (81 `FibreCert*`, `BinaryField`, `CircleCos`, `DyadicCerts`, `FibreShareIneq`), 5
`Outside/OAI015*`, 2 under `Plane/` (`WindowDensity`, `MOneBound`), 2 under `Instances/` (`SqrtFortySevenFive`,
`SqrtClassValues`) — and **4 of main's modules changed** (`Arith/ThreeFourColours`, `Arith/UpperHalf`,
`Instances/SqrtFortySeven`, `Plane/OneClass/InvariantLaw`), with `Proofs.lean`.

**The machine at the start**: 308 GB of disk free (`df`), 28.3 GiB available, the slot's ledger empty.

**The work list** — the lander's § "Drafts for part 2" in order, each with the previous landing's log it is compared
against (FS131-LDB1's, `/home/kooshi/source/lean-dir/data/fs131/ldb1/gate/<step>-final.*`):
1. The audit's blocks (`scripts/Axioms.lean`): the chain's, regenerated from a fresh print of every record of the 148
   modules (Lemma C′ gone); the link's (FS131-IKL1 § 4.3); the `p = 19` line's (FS131-IKC4); the dyadic line's
   (FS131-ICM4) — then `axioms.sh` against `receipt-axioms-final.log` (9,824 records, 9,438 clean, 355 axiom-free, 26
   imported, 5 purchases).
2. The coverage run (every public constant of the 148 modules a record or reached), after FS131-LDB1's `Coverage.lean`,
   against `coverage-final.out` and `records-final.txt`.
3. The assumptions step: `--self-test`, a run, `--write-ledger`, the nine counts, against `receipt-assumptions-final.log`
   (`axioms=2 rests=27 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1`).
4. Vacuity: `vacuity.sh`, `--self-test`, the counts reconciled against `receipt-vacuity-final.log` and
   `count-modules-final.out` (`declarations=20563 refutations-skipped=234 sites=1454`, `vacuous=0 stale=0 declared=3
   witnessed=38 generic=1411 unknown=2`), row for row by `tools/fs131_l5_vacdiff.py`.
5. The lint's negative control (a planted unused instance binder in a leaf module, built, linted red, restored), against
   FS131-LDB1's `lint-plant-run.out`.
6. The full gate on one commit (`data/fs131/lgt1/run-gate.sh`, after `data/fs131/ldb1/run-gate.sh`): build, up-to-date,
   the kernel's count of declarations, `sorry` and `axiom` scans, `dupnames` and self-test, the audit and self-test,
   coverage and records, the generators' byte checks, vacuity, self-test and the row diff, assumptions and self-test,
   architecture, lint, the statement check against the lander's dumps (`tools/fs131_lch1_statements.py`, with its
   plants), the baseline and the scans' sources against `main`'s, the three digests against FS131-LDB1's receipts —
   every log under `data/fs131/lgt1/gate/` with its exit status on its last line.
7. Read aloud: the headline and `χ(ℚ(√47)²) = 5` printed from the gated build, then M15's other values against row 123.
8. Drafts for the front page, each slot checked by a script.

## Stage 2 — SAVED (the gate's inputs)

**1. The audit's blocks.** The kernel's print of every record of the 148 modules (`data/fs131/lgt1/lean/AxiomsAll.lean`,
FS131-LCH1's printer with its module list read from `data/fs131/lgt1/modules.txt`; the tree's library current, `lake
build --no-build Proofs`: "All targets up-to-date (6457 jobs)", `nobuild-start.log`): **2,345 records, 1,545 public and
800 private, none on `sorryAx`** (`axioms-all.txt`). `tools/fs131_lgt1_audit_block.py` classes each public record and
leaves out the 106 `scripts/Axioms.lean` already prints (FS131-IJN1's 8 on `positive_entropy_rigidity`, FS131-LCH1's 13,
main's records of its four changed modules — each found in the section its axioms require); **1,439 placed**
(`data/fs131/lgt1/insert_blocks.py`, each at an anchor that must occur once): **1,413 CLEAN** (the chain 860, the link 25,
the dyadic line 96, the bound at 11 and 19 405, main's four modules 27), **18 under Weil's bound** (the chain 15, the
link's models 3), **8 under `positive_entropy_rigidity`**. Against the lines' own drafts (`block.out`): the chain's
drafted block 915 names (907 placed here, 8 already in) — every one; FS131-IKL1 § 4.3, 23 — every one; FS131-IKC1 4,
FS131-IKC2 4, FS131-IKC3 18, FS131-IKC4 190, FS131-ICM4 65 — every one; Lemma C′, the chain draft's one OPEN record, is
no record now. 235 placed records are named by no draft: 193 helpers and data of the `FibreCert*` modules, 27 of
`Instances/SqrtFortySeven`'s definitions and lemmas (main's module: `F47`, its coordinates, the reduction `red`, …) that
no landing had listed, 15 others (structure API, generated names). The generator's plant (an unknown axiom, a `sorryAx`,
a CLEAN record filed under PURCHASED, in memory): all three reported, exit 1 (`block-plant.out`).
- *Predicted before the run* (`prediction-axioms.txt`): 11,284 records — 10,650 clean, 569 axiom-free, 60 imported, 5
  purchases. `axioms.sh` (`axioms-1.log`): "audited: 11284 records — 10650 clean on the standard axioms, 569 axiom-free,
  60 imported (resting on a declared outside theorem), 5 declared purchase(s)", "declared imports (3)", "axioms: OK".
  **Met.**
- *Coverage* (`data/fs131/lgt1/lean/Coverage.lean`, FS131-LDB1's over the 148 modules, the records every `#print
  axioms` line of `scripts/Axioms.lean`): "MODULES 148", "CONSTANTS 4015 PUBLIC 1586", "RECORDS 1545 ABSENT 0 BLOCK
  1413", "REACHED 41" (inductives, constructors and recursors), **no UNREACHED**; the control (the records of the two
  leaf modules `Rigidity/CertLinkModels` and `Instances/SqrtClassValues`, which no module imports, taken out): 13
  removed, the same 13 reported. `tools/fs131_lgt1_records.py` (FS131-LDB1's records check with this landing's claims):
  **PASS** — the 1,545 printed once each, on the printer's axioms, in the section those require; the headline and
  `χ(ℚ(√47)²) = 5` under IMPORTED on exactly the three, `Rigidity.positive_entropy_rigidity` and
  `StandingFive.kloosterman_bound`; IMPORTED 60 = Weil's bound alone 38, the five-colour theorem 6, E–L alone 8, both 8;
  its seven plants each fail (`records-1.txt`, `records-plant-1.txt`).

**2. The assumptions step.** First run (`assumptions-1.log`): 64 failures — **4 `stale-condition`**
(`SpectralChain.TCA`, `SpectralChain.IsTraceSpectral`, `SpectralInputs.IsHaarFourier`, `SpectralInputs.IsSpectralMeasureOf`:
declared conditions on `main`, now concluded by the chain's theorems — `tca_of_five_le_localBound`, `aplus_model`,
`isHaarFourier_dualHaar`, `spectral_null_model` …): their entries retired; **3 `undeclared-never-concluded`**
(`Rigidity.EntropySplitEvery`, `Rigidity.IsRamified`, `Rigidity.SIndep`): declared `.condition`, each with its reason
— `EntropySplitEvery` is PE-2 as derived, taken only by `entropySplit_of_every`, which proves it implies `EntropySplit F`,
which the kernel holds with no such hypothesis; `IsRamified` a predicate of a prime (the prime of `ℤ[i]` above 2 at `ℚ` is
one, by hand; no declaration exhibits it); `SIndep` a predicate of two sets (the empty set satisfies it); 6
`stale-consumer` (the deleted conditional's `TAKES` rows) and 51 `unlisted-consumer`: the ledger's. `--write-ledger`
(`assumptions-ledger.diff`): **52 rows in** (31 `RESTS` on Weil's bound, 7 on E–L, 12 `TAKES`, 1 `MENTIONS`, the header)
**and 7 out** (the conditional's 6 `TAKES`, the header). The rows read: the twelve `TAKES` rows are three conditional
forms the chain keeps (`five_le_chromaticNumber_of_mrPlus`, `min_localBound_five_le_chromaticNumber_closed`,
`min_localBound_five_le_chromaticNumber_of_closed`, over `BochnerHerglotz`, `Interface.APlus0`/`APlusOfR88`,
`Interface.Count`, `InvariantMeasureOnClosed`) and `isSpectralMeasureOf_condExpL2` over `BochnerOn`; **the headline and
`χ(ℚ(√47)²) = 5` take nothing** (their only rows are `RESTS`). Third run (`assumptions-3.log`): "assumptions: OK — 3
outside theorem(s) as axioms, with 74 theorem(s) resting on them; 19 named and 14 inline hypotheses (7 outside, 21 ours,
5 open), taken by 108 statement(s) and mentioned by 2"; `CLAUDE.md` § Trust ledger flagged stale; self-test "OK — all 33
checks behaved" (`assumptions-selftest-1.log`). **The nine counts**, each move explained: `axioms` 2 → 3 (E–L Thm 1.3
declared); `rests` 27 → 74 rows (+16 on E–L, +31 on Weil's bound: the chain's records through the certificate link and the
three-four colours line; 66 theorems, 8 on both); `takes` 102 → 108 (+12 − 6, above; 55 statements, from 52); `mentions`
1 → 2 (`Rigidity.interface_mr_iff` on `Interface.MR`); `named`, `inline`, `outside`, `ours`, `open` unchanged.

**3. Vacuity** (`vacuity-1.log`): "vacuity: OK"; `declarations=22238 refutations-skipped=240 sites=1455`, `vacuous=0
stale=0 declared=3 witnessed=38 generic=1412 unknown=2`. The counter (`count-modules-1.out`) agrees with the scan;
`tools/fs131_l5_vacdiff.py` against FS131-LDB1's receipt row for row: "main rows 1535, landing rows 1537; lost 0; added 2",
"by module: declarations +1675, refutations +6: equal to the scans difference", "vacdiff: PASS" (`vacdiff-1.txt`).
Each move: **declarations +1,675** = the 144 new modules' 1,663, `Plane/OneClass/InvariantLaw` +12 (the eleven helpers made
public and `avgMeasure.eq_1`), `Arith/UpperHalf` +1 (`exists_I_integer` public), `Instances/SqrtFortySeven` −1 (the
deleted conditional); **refutations +6**, each read (`skipped.out`): `noRamifiedStableDyadic_of_tca` and
`…_of_three_le_localBound` (a conclusion `∀ P, IsDyadic P → ¬ IsRamified P`, read through to `→ False`: they refute
nothing), `Counting.count_of_oneAvoidingDensityBound` (its conclusion `Interface.Count`, `TCA F → R88TCA`, read through),
`Counting.false_of_slice` (a refutation: `TCA F`, `m₁ < 1/4` and a measurable four-colouring of the product with null
slice edges give `False`), `ZdAction.noVirtuallyCyclicFactors_of_isIrreducible` and
`trivialAction_noVirtuallyCyclicFactors` (a conclusion `∀ Y, … → ¬ …`: refute nothing); **sites +1, generic +1**:
`SimpleGraph.Coloring.colorClass.eq_1`, Mathlib's definition's equation lemma generated in `Rigidity/SqrtClassFive`, its
binder `C : G.Coloring α` parametric; one evidence row added (`Rigidity.nonempty_invariantColouring_bot`, a witness of
`InvariantColouring ⊥`). The baseline's header refiled with the new counts. **Where the scan is silent**: the headline's
one hypothesis structure is `[NumberField F]`, inhabited by `SqrtFortySeven.numberField_F47` (a theorem); the link's
binders (`HenselCount`, `NewCharBound`, `FibreShareBound`, a stable prime of residue size `q²`) are inhabited together at
`q = 3` by `CertLink.fibreShareBound_three` and `card_le_of_fibreShareBound_model` (FS131-IKL1 § 4.4, theorems); no
binder of the 148 modules ranges over a carrier an import empties.

**4. The lint's negative control** (`data/fs131/lgt1/lint-plant.sh`, FS131-IJN1's with the module `Rigidity/CertLinkModels`,
a leaf; tree clean at the plant): the plant built (`lint-plant-build.log`: "build: OK — 291 of 291 batches, 2 module(s)
rebuilt", BATCH=8), `lake lint` **exit 1, `synTaut` and `unusedArguments` each "(2/2) Failed with 1 messages", both at
`CertLinkModels.lean:74:1 … @zz_lgt1_lint_plant`**: "LINT CONTROL FIRED: exit 1, the plant named"; "RESTORED: the module is
the text it was", the plant's name 0 times in the file, tracked files modified 0 (`lint-plant-run.out`,
`lint-plant-restore.txt`). The gate's build rebuilds the module and the root from the restored text.

**The gate runner** is `data/fs131/lgt1/run-gate.sh` (FS131-LDB1's, with this landing's steps: the 148 modules' print
against the block's, coverage and records, the dyadic certificates' check and its planted fault, and FS131-LCH1's
statement check with its plants, the raw dumps' sums checked and their indexes re-split).

## Stage 3 — SAVED (the full gate on one commit — `eee71c74c` — green on its second pass)

**The first pass** (`data/fs131/lgt1/run-gate.sh final 6abec67d5 8`, from a snapshot copy, on `de877ff21`; logs
`data/fs131/lgt1/gate-pass1/`, its `README.txt`): every step green but **the audit's self-test, exit 1** — "2 of 23
control(s) did not behave as designed": `baseline` and `imported_declared`, the two controls that read the library's
state, expected "COUNTS imported=26 declared=2 library=2" and got "imported=60 declared=3 library=3". The chain's join
declared a third import (`positive_entropy_rigidity`) and its self-test had not been run since. The controls were moved
by `scripts/axioms-controls.txt`'s own rule ("per declared import, `declared` and `library` rise by one in both controls
and `imported` by its records, the `old` digests' texts follow, and `banner_dropped` gains `FAIL outside-banners <one of
its records>` and `FAIL stale-declaration <the axiom>`"): 26 → 60, 2 → 3, 27 → 61, 3 → 4, the two `old` texts, and
`banner_dropped`'s two lines for the new import; the self-test alone then "OK — every planted fault fired, and every
partner passed" (`axioms-selftest-2.log`). Commit `eee71c74c`; no statement, no proof and no record touched.

**The second pass, one pass, every step in order, under the slot** (`run-gate.sh final 6abec67d5 8`, launched from
`build/lgt1-run-gate-snapshot.sh`, 01:16:25–01:32 UTC). Every log is under `data/fs131/lgt1/gate/` with its exit status on
its last line; `run-pass-final.out` holds every step's exit, `measure-final.txt` its wall time and memory, and
`run-gate-final.head` the commit, **`eee71c74cb281a6eabe047e5121c7734a0637af7`**, with no tracked file modified at its
start and **"tracked files modified after the pass: 0"**. **Every step exited 0 but the two controls that must exit 1**
(the dyadic certificates' planted fault; the scan difference's plants). Before the pass: the lint's planted control
(stage 2, "LINT CONTROL FIRED"). Every count below is read from the saved logs.

| step | result, from its saved log (`data/fs131/lgt1/gate/<step>-final.*`) | wall | peak / max-rss GiB |
|---|---|---|---|
| build (`BATCH=8`, `--mem 10`) | "build: OK — all 2154 modules already up to date, nothing built, 0 module(s) with warnings" (the first pass's build, on the same `Proofs/` sources, rebuilt `Rigidity.CertLinkModels` and the root after the lint's control: "291 of 291 batches, 2 module(s) rebuilt, 0 module(s) with warnings, 7m17s"); Lake's full log 0 lines holding "warning"; `lake build --no-build Proofs`: "All targets up-to-date (6457 jobs)" | 4 s | — |
| `sorry` | narrow pattern over `Proofs/`, `Proofs.lean`: **0**; `\bsorry\b`: 62, every one prose — FS131-LDB1's 55 in the same files, and 7 new, each a docstring saying "no `sorry`" or naming the job that removed one (five `Outside/OAI015*`, `Rigidity/ChainAtTA`, `Rigidity/PositiveEntropy`) | — | — |
| `axiom` lines | 5 line-initial: the three declared (`no_proper_five_coloring`, `kloosterman_bound`, `positive_entropy_rigidity`), `Sat/Lrat`'s docstring code line (main's), `Rigidity/Entropy` l. 25 (a prose line beginning "axiom whose conclusion …"); `native_decide` in one landed module, `Plane/MOneBound`'s docstring ("with no `native_decide`") | — | — |
| doubled names, before the audit | "dupnames: OK — no name is declared by two modules (31 generated on demand, listed above)"; self-test "OK — all 15 controls behaved" | 4 s; 20 s | 0.54 / 4.62; 0.62 / 1.53 |
| axioms | "audited: 11284 records — **10650 clean** on the standard axioms, **569 axiom-free**, **60 imported** (resting on a declared outside theorem), **5 declared purchase(s)**"; "declared imports (3): …kloosterman_bound, …no_proper_five_coloring, …positive_entropy_rigidity"; "axioms: OK"; `CLAUDE.md` § Trust ledger flagged stale, "9438 clean → 10650, 26 imported → 60" (draft 1) | 10 s | 1.20 / 5.17 |
| its self-test | "OK — every planted fault fired, and every partner passed." (23 controls) | 232 s | 1.37 / 5.31 |
| the 148 modules' print | "axioms-all: IDENTICAL to the print the block was generated from" | 4 s | 0.52 / 4.59 |
| coverage and records | "MODULES 148", "CONSTANTS 4015 PUBLIC 1586", "RECORDS 1545 ABSENT 0 BLOCK 1413", "REACHED 41", no `UNREACHED`, "CONTROL-REMOVED 13"; "records: PASS"; plants "every one fired; the unplanted inputs pass" | 5 s | 0.53 / 4.63 |
| generators | the port's 31 "CHECK OK"; the covering and the certificate rewritten in place; the dyadic certificates "MODULE BLOCK: IDENTICAL (DyadicCerts.lean)", "ALL PASS", its planted bit "DIFFERS", "FAILED (1)", exit 1 as it must; "count=0" tracked files changed | ≤ 6 s | — |
| vacuity | "scanned: **declarations=22238 refutations-skipped=240**"; "sites: **sites=1455 vacuous=0 stale=0 declared=3 witnessed=38 generic=1412 unknown=2**"; "vacuity: OK"; the baseline's header "match (9 of 9 compared)"; `CLAUDE.md` § The gate stale (draft 4) | 127 s | 0.60 / 4.76 |
| its self-test | "OK — all 65 controls behaved" | 125 s | 0.61 / 4.78 |
| the scan against FS131-LDB1's | "main rows 1535, landing rows 1537; lost 0 (0 with a removed declaration); added 2"; "vacdiff: PASS"; its plants "vacdiff: FAIL (5)", exit 1 as they must | 0.1 s | — |
| assumptions | "assumptions: OK — 3 outside theorem(s) as axioms, with 74 theorem(s) resting on them; 19 named and 14 inline hypotheses (7 outside, 21 ours, 5 open), taken by 108 statement(s) and mentioned by 2"; "decided: … conditions=41 fails=0"; `CLAUDE.md` stale, "axioms 2 → 3, rests 27 → 74, takes 102 → 108, mentions 1 → 2" (draft 3) | 118 s | 0.66 / 4.83 |
| its self-test | "OK — all 33 checks behaved" | 124 s | 0.71 / 4.87 |
| architecture | "RESULT: PASS" | 7 s | — |
| guarded lint | exit 0, "-- Linting passed for Proofs.", 14 linters each "(2/2) Passed!" | 13 s | 0.99 / 5.33 |
| notes | "notes read: 196 … no-conflict=58", FS131-LDB1's count; self-test "OK (6 controls, 1 planted)" | 4 s | — |
| the stored statements | the lander's raw dumps checked against their committed sums ("OK" ×3), both before-indexes re-split from them "byte-identical to the committed ones"; the dump of this build "modules=2154 constants=35786", **byte-identical to the lander's build-5 dump**; `ReAdd`'s term surgery and its control; `tools/fs131_lch1_statements.py` against the dumps made before any edit: **"expected 34480 constants; same 34428, renamed 2, deleted 26, public 16, dropped 8, new 16, instance 0, incoming 1288; reports 0"**; its plants "5/5 planted faults reported" | ≤ 8 s | 0.53 / 4.60 |
| the baseline and the scans' sources against `main`'s | baseline entries unchanged (2); lines that differ: `scripts/Axioms.lean` 1508 (the blocks), `scripts/assumptions-ledger.txt` 68 (the ledger), `scripts/axioms-controls.txt` 26 (the controls), `scripts/Assumptions.lean` 9 (four entries out, three in), `scripts/vacuity-baseline.txt` 4 (the header); every scan's own source 0 | — | — |
| the three digests against FS131-LDB1's receipts | **axioms**: 11,284 records; stale: `CLAUDE.md` § Trust ledger. **vacuity**: the counts above; stale: `CLAUDE.md` § The gate. **assumptions**: the nine above; stale: `CLAUDE.md` § Trust ledger | — | — |

**Predicted before the run, against it**: the audit at 11,284 / 10,650 / 569 / 60 / 5 (stage 2's prediction, met there and
again here); vacuity and the nine counts as stage 2 read and explained them. **Met.**

**What the gate shows, and what it does not.** It shows: no `sorry` and no undeclared axiom in `Proofs/`; three declared
outside theorems, each audited; every public record of the 148 modules audited once, on exactly the axioms the kernel
prints for it, and every other public constant of them reached from one; no name declared twice, so each printed list is
the list of the proof the kernel checked; no stored statement or definition moved but the ruled ones, from the kernel's
side, against dumps made before any edit. It does not show: the two outside theorems' fidelity to their papers (the
planners' read-backs; `lean4checker` cannot check an axiom); anything an independent kernel replay would add
(`lean4checker` not run); that the 81 `FibreCert*` modules are byte-for-byte their generators' output (no generator was
re-run on them: the kernel checks what they state, and the statement check covers them); that the result is new.

## Stage 4 — SAVED (read aloud)

Printed from the gated build (`data/fs131/lgt1/lean/ReadAloud.lean` → `read-aloud.out`, `pp.fullNames`), after the
pass's build and before its later steps read the library; the two headline types are those `axioms-all-final.out` and the
statement dump (byte-identical to the lander's build-5 dump) hold.

**`HadwigerNelson.Rigidity.min_localBound_five_le_chromaticNumber : ∀ (F : Subfield ℝ) [NumberField ↥F],
Min.min (SpectralChain.localBound F) 5 ≤ (SimpleGraph.induce (planeOver F) (unitDistance ℂ)).chromaticNumber`** —
"depends on axioms: [propext, Classical.choice, Quot.sound, HadwigerNelson.Rigidity.positive_entropy_rigidity,
HadwigerNelson.StandingFive.kloosterman_bound]".

**`HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five : (SimpleGraph.induce (planeOver
SqrtFortySeven.F47) (unitDistance ℂ)).chromaticNumber = 5`** — the same five axioms.

**Every binder and defined term, traced** (each printed from the build):
- `F : Subfield ℝ` with `[NumberField ↥F]`: a subfield of the reals, finite over `ℚ` — "a real number field". The
  headline's only hypothesis is the instance; the assumptions ledger lists no `TAKES` row for either theorem (stage 2).
- `planeOver F = {z | z.re ∈ F ∧ z.im ∈ F}` (a set of `ℂ`): the plane `F²`, as points of `ℂ`.
- `unitDistance ℂ`: `Adj x y := dist x y = 1` on `ℂ`'s metric, `|x − y|`, the Euclidean distance of `ℝ²`; `induce` on
  `planeOver F` is the subgraph on `F²` (`SimpleGraph.comap` along the subtype embedding). So the graph is the
  unit-distance graph on `F²`, and `chromaticNumber` is Mathlib's (`⨅ n ∈ setOf G.Colorable, ↑n` in `ℕ∞`): `χ(F²)`.
- `SpectralChain.localBound F = ⨅ P : StablePrime F, (levelTarget P 1).chromaticNumber`, with `StablePrime F` a maximal
  ideal `P` of `𝓞(F(i))` fixed by conjugation (`comap (conjO F) P = P`), `F(i) = fieldI F = planeOverSubfield F`, and
  `levelTarget P 1` the Cayley graph `SimpleGraph.fromRel (fun x y => (x − y)·conj(x − y) = 1)` on `𝓞(F(i))/P`: the
  residue target of norm-one differences. So `localBound F` is `L(F)`, "the least chromatic number among the residue
  targets its conjugation-fixed primes supply" (`CLAUDE.md` § Notation). (An empty infimum would be `⊤`, making
  `min(L, 5) = 5`; it is not empty at the instances: `five_le_localBound_sqrt47` and the upper half at a prime above 11
  read real primes.)
- `SqrtFortySeven.F47 = SquareClass.fieldOfRadicands {47} = Subfield.closure {√47}` in `ℝ`: `ℚ(√47)`.
  `numberField_F47 : NumberField ↥F47` on the standard three.

**Against NF2-LEAF-23** ("`NumberField` for `ℚ(√47)`'s `Subfield ℝ`, and `5 ≤ localBound` there: every stable prime of
`ℚ(√47, i)` and its target … Then `ℚ(√143)`, `ℚ(√311)`, `ℚ(√335)` (D:275), `ℚ(√3,√5)` (D:301), `ℚ(√167) ≥ 5` (D:279)"):
`numberField_F47` (the standard three); `five_le_localBound_sqrt47 : 5 ≤ SpectralChain.localBound SqrtFortySeven.F47` (the
standard three and Weil's bound); `SqrtClassValues.chromaticNumber_planeOver_sqrt143_eq_five`, `…sqrt311…`,
`…sqrt335…` (`= 5` at `fieldOfRadicands {143}`, `{311}`, `{335}`), `…sqrt3_sqrt5_eq_five` (`= 5` at `fieldOfRadicands {3,
5}`), `five_le_chromaticNumber_planeOver_sqrt167` (`5 ≤ χ` at `fieldOfRadicands {167}`), each with no hypothesis, each on
the same five axioms. **The leaf is met as stated.**

**Against row 121** ("`χ(ℚ(√47)²) = 5` … MR at ℚ(√47) (row 120) with J45's SP-Cor and T-C(A) at `S = ∅` gives `≥ 5`;
the plane at 11 gives `≤ 5`"): the stored type is `χ(ℚ(√47)²) = 5`, word for word, with no hypothesis; what the kernel
did not check is exactly the two declared outside theorems — Weil's bound (`StandingFive.kloosterman_bound`, `[Weil1948]`
p. 207; its stored type in the print: the Kloosterman sum over a finite field of odd characteristic bounded by `2√|F|`)
and Einsiedler–Lindenstrauss's positive-entropy rigidity (`Rigidity.positive_entropy_rigidity`,
`[EinsiedlerLindenstrauss2022]` Thm 1.3; its stored type in the print: an ergodic probability measure for a `ℤ^d` action,
`d ≥ 2`, with no virtually cyclic factors on a solenoid, is an average of finitely many measures each invariant under a
closed subgroup with zero entropy on the quotient). Their read-backs against the papers are the planners' (`[Weil1948]`:
two readers, `CLAUDE.md` § Trust ledger; E–L: `plans/FS131-KN7-chain-next.md` § 3.3, "clause by clause, page and line");
this job did not re-read either paper. Row 121's other sentences are **not** what the stored statements say, and the
kernel claims none of them: the triangle-free five-chromatic finite graph by de Bruijn–Erdős (no declaration), row 88 ⟺
T-B1 at ℚ(√59), ℚ(√83), ℚ(√131), and the prior-art and answered-question clauses (prose).

**M15's other values against row 123** ("for every real number field `F`, `χ(F²) ≥ min(L(F), 5)`, so `χ(F²) = L(F)`
whenever `L(F) ≤ 5` … Instances: `χ = 5` at ℚ(√143), ℚ(√311), ℚ(√335) and every squarefree `d ≡ 47, 143, 167 (mod 168)`
with `L = 5` (44 of the 52 with `d ≤ 3000`); `χ(ℚ(√3,√5)²) = 5`; `χ(ℚ(√167)²) ≥ 5`"):
- the main clause is `Rigidity.min_localBound_five_le_chromaticNumber`, word for word (every real number field, complex
  places included: `F ⊆ ℝ` with `NumberField`, no total reality asked);
- `Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound : 5 ≤ L(F) → 5 ≤ χ(F²)`, its form at `L ≥ 5`;
- "so `χ(F²) = L(F)` whenever `L(F) ≤ 5`" is **not a stored theorem**: it is the headline with the upper half
  `UpperHalf.chromaticNumber_planeOver_le_localBound` (row 123's own words, [kernel] since FS131-LU1), a two-line
  composition (`le_antisymm`, `min_eq_left`); the library's stored equality `SpectralChain.chromaticNumber_eq_localBound`
  and `UpperHalf.chromaticNumber_eq_localBound_of_chain` are the conditional forms, over the named hypotheses (their
  `TAKES` rows) — an open item below;
- the instances at ℚ(√143), ℚ(√311), ℚ(√335), ℚ(√3,√5) and `≥ 5` at ℚ(√167): stored, as above;
- the family "every squarefree `d ≡ 47, 143, 167 (mod 168)` with `L = 5` (44 of 52, `d ≤ 3000`)", the CLS
  characterization in full, and ℚ(√23, ∛2)'s `L = 5`: **not stored** — each such field is an instance of the headline
  once `5 ≤ L(F)` is proved there, which the kernel has at the five named fields only.
**Read aloud: the two statements say what NF2-LEAF-23 and row 121's headline claim say, no more and no less, on two
declared outside theorems.**
