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
