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

## Drafts for the front page (FS131-LGT1)

*For the coordinator to file; this job files none of them. Each draft names its slot: the file, the section, and the exact
words it replaces or follows. `data/fs131/lgt1/drafts-slots.py` checks that each slot occurs exactly once on `main`
(`6abec67d5`), whitespace-normalised (`drafts-slots.out`: "slots: 23 checked, control absent: yes; SLOTS OK"; the same
check at `9fe574044`, before the density bound's filing, fails on 10 slots — `drafts-slots-plant.out`). Each count names
the log it comes from: the gated pass, `data/fs131/lgt1/gate/*-final.*` (stage 3).*

**Whose it is, and what is new** (the brief's amendment of 00:33 UTC). `χ(ℚ(√47)²) = 5` and the main clause through five
are this project's derivation (rows 120–123; FS-100), held at [hand] since 2026-09-26. **Prior art: not found in print**
(row 121's search, X24R) for the lower half. Not ours, named as the ledger names it: the upper half `χ(ℚ(√47)²) ≤ 5` and
the plane at 11 are prior art (row 52's residue colouring; `[Moorhouse2010]`, `[Fischer1990]`); Weil's bound
(`[Weil1948]`) and Einsiedler–Lindenstrauss Thm 1.3 (`[EinsiedlerLindenstrauss2022]`) are declared outside theorems; the
density bound inside the chain is `[AmbrusEtAl2023]`'s. **What this landing adds is the kernel's check**: the statements as
derived, with no hypothesis of ours, on those two outside theorems. No value of `χ(ℝ²)` moves.

**1. `CLAUDE.md` § Trust ledger, the audit's sentence.** *Replaces* "the current audit reads 9438 clean and 5 declared
purchases, and 26 imported (and 355 axiom-free; 9,824 records at the landing of the density bound, FS131-LDB1,
2026-10-14)". From `axioms-final.log`, "audited: 11284 records — 10650 clean on the standard axioms, 569 axiom-free, 60
imported (resting on a declared outside theorem), 5 declared purchase(s)":

> the current audit reads 10650 clean and 5 declared purchases, and 60 imported (and 569 axiom-free; 11,284 records at
> the landing of the five-colour chain, FS131-LGT1, 2026-10-15)

9,845 records at this job's start (the density bound's 9,824 and the chain's 21 the lander and FS131-IJN1 filed) + 1,439
placed = 11,284; clean 9,451 + 1,199; axiom-free 355 + 214; imported 34 + 26.

**2. `CLAUDE.md` § Trust ledger, the declared outside axioms.** *Replaces* "The library declares two outside axioms:
`StandingFive.kloosterman_bound` — Weil's bound for Kloosterman sums, `[Weil1948]` p. 207, read against its page by two
readers — with twenty imported records (twelve of them the three-colour criterion's and row 99's, FS131-LJ1); and, from
`[OAIMath2026]` family 158, a Lean development built and audited here at its own pin,
`Outside.OAI158.no_proper_five_coloring` — no map `ℂ → Fin 5` separates every unit pair — with six; no record rests on
both," *by*

> The library declares three outside axioms: `StandingFive.kloosterman_bound` — Weil's bound for Kloosterman sums,
> `[Weil1948]` p. 207, read against its page by two readers — with forty-six imported records (twelve of them the
> three-colour criterion's and row 99's, FS131-LJ1; twenty-six the five-colour chain's, FS131-LGT1); from `[OAIMath2026]`
> family 158, a Lean development built and audited here at its own pin, `Outside.OAI158.no_proper_five_coloring` — no
> map `ℂ → Fin 5` separates every unit pair — with six; and `Rigidity.positive_entropy_rigidity` — Einsiedler and
> Lindenstrauss's positive-entropy rigidity for `ℤ^d`-actions on solenoids, `[EinsiedlerLindenstrauss2022]` Thm 1.3, read
> back clause by clause in `plans/FS131-KN7-chain-next.md` § 3.3 — with sixteen, eight of which rest on Weil's bound too
> (the five-colour chain's headline `Rigidity.min_localBound_five_le_chromaticNumber`, `χ(ℚ(√47)²) = 5` and M15's other
> values); no record rests on the five-colour theorem and another import,

From `receipt-axioms-final.log` (`tools/fs131_lgt1_records.py`, `records-final.txt`): IMPORTED 60 = Weil alone 38, the
five-colour theorem 6, E–L alone 8, both 8.

**3. `CLAUDE.md` § Trust ledger, the nine counts.** *Replaces* "`axioms=2 rests=27 named=19 inline=14 outside=7 ours=21
open=5 takes=102 mentions=1` — two outside theorems declared as axioms, with twenty-seven theorems resting on them;" *by*

> `axioms=3 rests=74 named=19 inline=14 outside=7 ours=21 open=5 takes=108 mentions=2` — three outside theorems declared
> as axioms, with seventy-four (axiom, theorem) rows resting on them, sixty-six theorems, eight of them on two;

and *replaces* "taken in 102 (hypothesis, statement) pairs by 52 statements" *by* "taken in 108 (hypothesis, statement)
pairs by 55 statements". From `receipt-assumptions-final.log`: "assumed: axioms=3 rests=74 named=19 inline=14 outside=7
ours=21 open=5 takes=108 mentions=2"; the ledger's header "match (9 of 9 compared)". The chain's two hypotheses `hOA` and
`hRow99` are discharged and its conditional value at ℚ(√47) deleted (its six `TAKES` rows gone); the twelve new `TAKES`
rows are three conditional forms kept beside the headline and `isSpectralMeasureOf_condExpL2` (stage 2).

**4. `CLAUDE.md` § The gate, the vacuity scan's counts.** *Replaces* "`declarations=20563 refutations-skipped=234
sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`." *by*

> `declarations=22238 refutations-skipped=240 sites=1455`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1412 unknown=2`.

From `vacuity-final.log`. Each move (stage 2): declarations +1,675 (144 modules 1,663; `InvariantLaw` +12; `UpperHalf`
+1; `SqrtFortySeven` −1), refutations +6 (each read), one GENERIC site (`SimpleGraph.Coloring.colorClass.eq_1`). The
baseline's header is refiled on the branch.

**5. `CLAUDE.md` § Frontier, Last filed.** *Replaces* "Last filed: **the landing of the density bound** (FS131-LDB1,
2026-10-14:" *by*

> Last filed: **the landing of the five-colour chain** (FS131-LCH1, FS131-LGT1, 2026-10-15: the chain's 144 modules and
> the four of `main`'s it changes through the gate on one commit — 1,439 records; `min(L(F), 5) ≤ χ(F²)` for every real
> number field with no hypothesis (`Rigidity.min_localBound_five_le_chromaticNumber`), `χ(ℚ(√47)²) = 5`
> (`SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five`), `χ = 5` at ℚ(√143), ℚ(√311), ℚ(√335), ℚ(√3,√5) and
> `χ(ℚ(√167)²) ≥ 5`, on two declared outside theorems — Weil's bound and `[EinsiedlerLindenstrauss2022]` Thm 1.3, the
> latter declared at this landing; the lower half at ℚ(√47) not found in print, the upper half prior art; the
> derivation this project's (rows 120–123), the kernel's check this landing's; Lemma C′ (row 100) left out of the library,
> its statement kept; no value of `χ(ℝ²)` moved); before it **the landing of the density bound** (FS131-LDB1, 2026-10-14:

**6. `CLAUDE.md` § Where the problem stands, "What the kernel holds, beyond the interval".** *Follows* "The theorem is
`[AmbrusEtAl2023]`'s; the route, the formalization and the kernel check are this project's;" *with*

> **the main clause through five** (FS-131, FS131-LCH1, FS131-LGT1): for every real number field `F`, `min(L(F), 5) ≤
> χ(F²)`, with no hypothesis (`Rigidity.min_localBound_five_le_chromaticNumber`), and with the upper half
> (`UpperHalf.chromaticNumber_planeOver_le_localBound`) `χ(F²) = L(F)` whenever `L(F) ≤ 5` (a two-line composition, not a
> stored theorem); `χ(ℚ(√47)²) = 5` (`SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five`), `χ = 5` at ℚ(√143),
> ℚ(√311), ℚ(√335) and ℚ(√3, √5), and `χ(ℚ(√167)²) ≥ 5` (`Instances/SqrtClassValues`) — rows 121 and 123, with row
> 120's measure rigidity, as the chain uses it, proved from Thm 1.3, and the density bound inside it as a theorem; on two declared outside theorems,
> Weil's bound (`StandingFive.kloosterman_bound`) and `[EinsiedlerLindenstrauss2022]` Thm 1.3
> (`Rigidity.positive_entropy_rigidity`). Prior art: the lower half at ℚ(√47) not found in print (row 121); the upper
> half `χ ≤ 5` and the plane at 11 are prior art (row 52); the derivation is this project's, and the kernel's check is
> this landing's;

**7. `CLAUDE.md` § Where the problem stands, the algebraic lower end.** *Replaces* "— at [hand] grade, over MR (row 120:
`[EinsiedlerLindenstrauss2022]` Thm 1.3 by statement, with a two-mind deduction of its Thm 1.2, and
`[EinsiedlerFish2010]`'s method transferred, three blind derivations), not in the kernel, where row 127 holds it only over
named hypotheses." *by*

> — in the kernel since FS131-LGT1, with no hypothesis, on two declared outside theorems: `[EinsiedlerLindenstrauss2022]`
> Thm 1.3 (`Rigidity.positive_entropy_rigidity`) and Weil's bound (`StandingFive.kloosterman_bound`); the rest of the
> route — measure rigidity as the chain uses it (row 120's deduction), the count, SP-Cor, T-C(A) — is kernel-checked
> (`SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five`; rows 120, 121, 127).

**8. `CLAUDE.md` § Grokkings, the theory in one paragraph.** *Replaces* "at five given MR, by measure rigidity for the
unit-vector group, with no witness graph: rows 120, 123, G80; [hand])" *by* "at five by measure rigidity for the
unit-vector group, with no witness graph: rows 120, 123, G80; [kernel] since FS131-LGT1 on Weil's bound and
`[EinsiedlerLindenstrauss2022]` Thm 1.3, `Rigidity.min_localBound_five_le_chromaticNumber`)". The next sentence ("So,
given MR, F² needs five exactly when …") is row 123's CLS in full, which the kernel holds only in part
(`Rigidity.tca_iff_five_le_localBound`): left for the filer to word, or as it is.

**9. `CLAUDE.md` § The local–global conjecture, its proved range.** *Replaces* "Its proved range is
`plans/WHERE-THE-PROBLEM-STANDS.md` item 10's — every `L ≤ 5`, at [hand] through MR (row 123)." *by* "Its proved range is
`plans/WHERE-THE-PROBLEM-STANDS.md` item 10's — every `L ≤ 5`, at [hand] through MR (row 123), and in the kernel since
FS131-LGT1 on Weil's bound and `[EinsiedlerLindenstrauss2022]` Thm 1.3."

**10. The same section, the predictions met.** *Replaces* "**all met**, at [hand] through MR (rows 120–121, 123)" *by*
"**all met**, in the kernel since FS131-LGT1 on Weil's bound and `[EinsiedlerLindenstrauss2022]` Thm 1.3 (rows 120–121,
123; `Instances/SqrtFortySevenFive`, `Instances/SqrtClassValues`)".

**11. The same section, ℚ(√167).** *Replaces* "proven 4 in the kernel (row 119) and ≥ 5 at [hand] (row 123)," *by*
"proven 4 in the kernel (row 119) and ≥ 5 in the kernel since FS131-LGT1, on the two outside theorems
(`SqrtClassValues.five_le_chromaticNumber_planeOver_sqrt167`; row 123),".

**12. `CLAUDE.md` § The mission, publication.** *Replaces* "in the kernel only in row 127's conditional form;" *by* "in
the kernel since FS131-LGT1 with no hypothesis of ours, on two declared outside theorems (Weil's bound,
`[EinsiedlerLindenstrauss2022]` Thm 1.3);". (The publication bar's question — landing the two outside theorems on the
standard three — is the publication pass's, and is not touched here.)

**13. `LEDGER.md` row 121, its consequences.** *Replaces* "in the kernel only over named hypotheses, row 127;" *by*

> **[kernel] since FS131-LGT1** with no hypothesis, on two declared outside theorems — Weil's bound
> (`StandingFive.kloosterman_bound`, `[Weil1948]`) and Einsiedler–Lindenstrauss Thm 1.3
> (`Rigidity.positive_entropy_rigidity`, `[EinsiedlerLindenstrauss2022]`): `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five`,
> and `χ = 5` at ℚ(√143), ℚ(√311), ℚ(√335), `χ(ℚ(√167)²) ≥ 5` (`Instances/SqrtClassValues`); the triangle-free graph by
> de Bruijn–Erdős and row 88 ⟺ T-B1 at ℚ(√59), ℚ(√83), ℚ(√131) are not in the kernel; the conditional form (row 127)
> deleted at the join;

The row's prior-art clause stays as it is ("not found in print"; the upper half prior art).

**14. `LEDGER.md` row 123, its grade's head.** *Replaces* "**[hand + tools exact; MR row 120's grade (EL2021 Thm 1.2
external;" *by* "**[kernel] since FS131-LGT1 for the main clause and its five named instances — `Rigidity.min_localBound_five_le_chromaticNumber`
(every real number field, no hypothesis), `Instances/SqrtClassValues`, `Instances/SqrtFortySevenFive` — on Weil's bound
and `[EinsiedlerLindenstrauss2022]` Thm 1.3, declared outside theorems; `χ = L` at `L ≤ 5` is that clause with the upper
half, not stored as one theorem; the family (44 of 52, `d ≤ 3000`), CLS in full and ℚ(√23, ∛2) keep the derivation's
grade:** **[hand + tools exact; MR row 120's grade (EL2021 Thm 1.2 external;".

**15. `LEDGER.md` row 127.** *Replaces* "`χ(ℚ(√47)²) = 5` given the chain
(`SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five_of_chain`);" *by* "`χ(ℚ(√47)²) = 5` given the chain
(`SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five_of_chain`, deleted at FS131-LCH1's join, its hypotheses
discharged: row 121);" and *replaces* "**Not claimed:** any named hypothesis. **Prior art:** the upper half at ℚ(√47) is
row 52's residue colouring; the kernel forms ours." *by* "**Not claimed:** any named hypothesis. **Since FS131-LGT1** the
main clause holds with no hypothesis (`Rigidity.min_localBound_five_le_chromaticNumber`, row 123's grade); the
conditional forms here stay in the library, each over the named hypotheses its `TAKES` rows list. **Prior art:** the upper
half at ℚ(√47) is row 52's residue colouring; the kernel forms ours."

**16. `LEAN.md` § Building**, *following* its last bullet (ending "(`data/fs131/ipd1/farm2-run.sh`, FS131-IPD1;
`data/fs131/lp1/advalue-run.sh`, FS131-LP1)."), FS131-LCH1's line, verbatim from its record:
- "`decide +kernel` modules in one batch share no memory: eight `Plane/DensityBound/Cells/PartNN` (about 2 GB each) are
  OOM-killed in a 10 GiB scope (exit 143, `Terminated`, the user journal's `oom-kill`), and two FS131-IKC4 check modules
  (5.4–7.3 GiB each) in one 10 GiB scope likewise; a rebuild of either needs `BATCH=3` (cells) or `BATCH=2` at
  `MEMMAX=16G` (the checks) (FS131-LCH1)."
- and this job's: "A lint control planted in a leaf module (one only the root imports: `Rigidity/CertLinkModels`) costs a
  two-module rebuild: 7 m 17 s at `BATCH=8` on the laptop, all but 3 s of it the walk (FS131-LGT1)."

**17. `LEAN.md` § Searching — Lean**, *following* its last bullet (ending "the covering's 48 modules and the certificate's
23 byte for byte; FS131-LDB1)."), FS131-LCH1's three, verbatim from its record (`Expr.hash` and the dropped binder put back
by `mkArrow`; making a private declaration public renames its internal constants, compared by prefix; a corollary cannot
live in a module its theorem's module imports), FS131-IKL1's § 4.6 lines as that record has them, and this job's:
- "An audit block for a landing is generated from the kernel's print of every record of the landed modules
  (`data/fs131/lgt1/lean/AxiomsAll.lean`, `tools/fs131_lgt1_audit_block.py`), less the records already filed, and the
  lines' own drafts are a cross-check, not the source: at the five-colour chain's landing they named 1,204 of the 1,439
  records; the other 235 — helpers, certificate data, and 27 definitions of a `main` module no landing had listed — were
  found only by the print (FS131-LGT1)."
- "A declared `.condition` goes stale when a landing brings a theorem that concludes it (`stale-condition`, 'the entry is
  not needed'): retire the entry (`SpectralChain.TCA`, `IsTraceSpectral`, `SpectralInputs.IsHaarFourier`,
  `IsSpectralMeasureOf`, FS131-LGT1)."
- "The audit's self-test reads the library's state in two controls (`baseline`, `imported_declared`: the imported count,
  the declared imports): a landing that declares an import or adds imported records turns it red until the controls are
  moved by `scripts/axioms-controls.txt`'s own rule — FS131-LCH1's join declared `positive_entropy_rigidity` and the
  self-test was not run on it; run it before the full pass (FS131-LGT1)."
- "In the assumptions step's digest, lines `- FAIL …` under 'changes since the previous complete run' are rows that have
  gone, not failures: read the count from the step's own `FAIL — n check(s)` line (FS131-LGT1)."

**18. `BIBLIOGRAPHY.md`, `[EinsiedlerLindenstrauss2022]`, the role column**, *following* "PE-2's positive-entropy input
(row 120), resting since FS-105 on its Thm 1.3 plus the deduction FS105-DED [hand, two minds], EL2003's proof being an
outline": "; Thm 1.3 is declared to the kernel as the axiom `Rigidity.positive_entropy_rigidity` (FS131-KN3; read back
clause by clause, FS131-KN7 § 3.3), and the five-colour chain's headline and values rest on it and on `[Weil1948]` with
FS105-DED and the rest of the chain kernel-checked (FS131-LGT1)".

**19. `BIBLIOGRAPHY.md`, `[Weil1948]`, the role column's end**, *following* "**as a statement about the norm-one Cayley
graph of `𝔽_{p²}`**, not yet about the plane `UD(𝔽_p, 2)` (no declaration links the two)": "; the five-colour chain's
records rest on it through the certificate link and row 99's lower half — 26 records, the headline
`Rigidity.min_localBound_five_le_chromaticNumber` and `χ(ℚ(√47)²) = 5` among them (FS131-LGT1)".

**20. `tools/claude_md_fact_audit.py`, `GATE_CHANGES`.** One entry after `(("9038", "5"), ("9438", "5")):`'s:

```python
    (("9438", "5"), ("10650", "5")): "FS-131, the landing of the five-colour chain — the chain's 144 modules and four of main's through the gate on one commit: min(L(F), 5) ≤ χ(F²) for every real number field with no hypothesis (Rigidity.min_localBound_five_le_chromaticNumber), χ(ℚ(√47)²) = 5, χ = 5 at ℚ(√143), ℚ(√311), ℚ(√335), ℚ(√3,√5), χ(ℚ(√167)²) ≥ 5, on Weil's bound and [EinsiedlerLindenstrauss2022] Thm 1.3 (Rigidity.positive_entropy_rigidity, the third declared import); the derivation ours (rows 120–123), the lower half not found in print, the upper half prior art (FS131-LCH1, FS131-LGT1; copy data/fs131/lgt1/gate/receipt-axioms-final.log, gated commit eee71c74c): 11,284 records, 10,650 clean, 569 axiom-free, 60 imported, 5 purchases",
```

**20b. The same file's table of superseded counts**, each only if the filing leaves it nowhere in the files the audit
joins: `"9438"` (10650 clean); `"9,824"` and `"9824"` (11,284 records); `"declarations=20563"` and `"20563"` (22238);
`"declarations=20563 refutations-skipped=234 sites=1454"`; `"axioms=2 rests=27 named=19 inline=14 outside=7 ours=21
open=5 takes=102 mentions=1"`. Reason: "superseded gate count, refiled at FS131-LGT1's landing from
data/fs131/lgt1/gate/receipt-axioms-final.log (the vacuity count from receipt-vacuity-final.log, the nine from
receipt-assumptions-final.log); the old count stays in data/fs131/ldb1/gate/ and in GATE_CHANGES". `355` (axiom-free) is
not listed: check where else it occurs before retiring it. **The next landing's previous receipts are
`data/fs131/lgt1/gate/receipt-{axioms,vacuity,assumptions}-final.log`.**

**21. `data/fs131/claims-NF2.md` § Dated lines**, *following* its last line ("- 2026-10-14 — **The density bound is
landed** (FS131-LDB1) …"):

> - 2026-10-15 — **The five-colour chain is landed** (FS131-LCH1, FS131-LGT1): `Rigidity.min_localBound_five_le_chromaticNumber`
>   and `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five` through the full gate on one commit, with no
>   hypothesis, on `[propext, Classical.choice, Quot.sound, Rigidity.positive_entropy_rigidity,
>   StandingFive.kloosterman_bound]`; NF2-LEAF-23 met as stated (`numberField_F47`, `five_le_localBound_sqrt47`, the
>   values at ℚ(√143), ℚ(√311), ℚ(√335), ℚ(√3,√5), ℚ(√167)); Lemma C′ out of the library, its statement kept
>   (`data/fs131/lch1/ring-scope-lemma-c-prime.lean`).

**22. The Proof Atlas grades.** Row 121 `χ(ℚ(√47)²) = 5`: [hand] → **[kernel, on two declared outside theorems]**
(`SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five`); row 123's main clause `min(L(F), 5) ≤ χ(F²)`: [hand] →
**[kernel, the same two]** (`Rigidity.min_localBound_five_le_chromaticNumber`), and its four `= 5` values and `χ(ℚ(√167)²)
≥ 5` likewise; row 127: superseded in strength (its conditional forms stay); row 120's MR at a number field: its
deduction from Thm 1.3 is kernel-checked inside the chain (no stored theorem by the row's name; the filer words it).

## Open gate items at this landing

*Each named, with what would close it; none is a red check of this gate.*

1. **`lean4checker`** (the publication gate) has not been run over the chain; it cannot re-check the three axioms.
2. **The two outside theorems the headline rests on are read against their papers by the planners, not by this job**:
   Weil's bound by two readers (`CLAUDE.md` § Trust ledger); E–L Thm 1.3 clause by clause in
   `plans/FS131-KN7-chain-next.md` § 3.3. Its model in its own file, `Rigidity.positive_entropy_rigidity_model`, is the
   one-point solenoid — degenerate, "its clause on factors empty" (its docstring); "the model that exercises every clause
   is PE-1′, a leaf of the chain". Whether PE-1′ is stated as a theorem exhibiting a non-degenerate model was not checked
   here — a question for the coordinator before the announcement names the import.
3. **`χ(F²) = L(F)` at `L(F) ≤ 5` with no hypothesis is a term, not a stored theorem** (the headline with
   `UpperHalf.chromaticNumber_planeOver_le_localBound`); the stored equalities `SpectralChain.chromaticNumber_eq_localBound`
   and `UpperHalf.chromaticNumber_eq_localBound_of_chain` stay conditional. A closed corollary by name is a new statement
   for a planner.
4. **Row 123's family** (every squarefree `d ≡ 47, 143, 167 (mod 168)` with `L = 5`, 44 of 52 below 3000), CLS in full and
   ℚ(√23, ∛2)'s `L = 5` are not stored; each field is an instance of the headline once `5 ≤ L(F)` is proved there.
5. **The 81 `Arith/FibreCert*` modules were not regenerated** byte for byte by their generators (`tools/fs131_ikc4_gen.py`,
   `fs131_ikc4_checks.py`, `fs131_ikc3_ktab.py`, `fs131_ikc1_gen.py`): their exact command lines and certificate inputs are
   in FS131-IKC1 … IKC4's records; the kernel checks what the modules state, and the statement check covers their constants.
6. **Three `.condition` entries on this landing's word** (`Rigidity.EntropySplitEvery`, `IsRamified`, `SIndep`; stage 2):
   the alternative for `EntropySplitEvery` is a `.former` of kind `ours` (FS100-PE2), which would add a `TAKES` row to
   `entropySplit_of_every` and move `named` and `ours` by one.
7. **Lemma C′** (row 100) is out of the library, its statement kept in `data/fs131/lch1/ring-scope-lemma-c-prime.lean`; its
   line on the publication roadmap is owed (item 941).
8. **`CLAUDE.md`'s "So, given MR, F² needs five exactly when …"** (the theory paragraph) is row 123's CLS in full, held in
   the kernel only in part (`Rigidity.tca_iff_five_le_localBound`): draft 8 leaves it to the filer.
9. The lander's four raw dumps are deleted at this hand-back (their sums committed; the gate's check read them first,
   "OK" ×3 and both indexes re-split byte-identical); their uncompressed `.full.txt` and `.index.tsv` siblings in
   `data/fs131/lch1/` (untracked, their `.xz` committed) are not in the brief's list and are left.
