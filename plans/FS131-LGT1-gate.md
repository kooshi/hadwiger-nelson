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
