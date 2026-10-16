# FS131-ICT2 — the three-colour criterion to the gate: the ruled drops, lint, the gate on one commit, the read-aloud, the drafts

*Implementer: de Bruijn (Opus 5.5), job FS131-ICT2, brief `data/fs131/briefs/FS131-ICT2-three-colour.md` (on `main`). Worktree
`.claude/worktrees/kel1`, branch `fs131-ktc1`, at `ffe203401` on arrival (FS131-ICT1's last commit `0ab9c6614` with `main`
merged in). Started 2026-10-16 15:50 UTC. No fence (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1). The
predecessor's record is `plans/FS131-ICT1-three-colour.md`; the plan is `plans/FS131-KTC1-three-colour-plan.md`.*

## Theorems this phase proved

None yet (the mathematics was done by FS131-ICT1; this job gates it). Filled in at the gate.

## Stage 1 — SAVED: the readback

### 1.1 The quotations of the brief, checked against their sources

`tools/fs131_ict2_quotes.py` (FS131-ICT1's checker with this brief's path: each quotation, as a contiguous block of whole
lines, against its source in this worktree and in the main tree): `data/fs131/ict2/quote_check.out` — **2 quotations, 0
mismatched** (inventory items 1012 and 1003 of `plans/FS131-close-inventory.md`, found in both trees). Its control
(`--plant`: one character changed in the longest line of each quotation) reports both (`quote_check_plant.out`, exit 0).

The brief's receipts, checked on the branch: `grep -cw sorry` reads 0 in the three modules; `even_pmHeight_sub_sum` (then
`Fibre.lean` l. 179) took `(hc : ProperAlong s c)` and read it only by `have _ := hc`; `exists_le_mul_of_imp_eq_zero` (then
l. 433) took `(hadd : ∀ x ∈ M, ∀ y ∈ M, x + y ∈ M)` and read it only by `have _ := hadd` — as the brief says.

### 1.2 What is left, and the order

1. **The ruled drops** (item 1012): `hc` from `CayleyThree.even_pmHeight_sub_sum`, `hadd` from
   `CayleyThree.exists_le_mul_of_imp_eq_zero`; their call sites (`Density.lean`, three uses of the first; `Fibre.lean`'s
   `exists_slack_bound`, one of the second) updated. With them, before the first build: the three module titles lose the word
   "skeleton" (doc text only; the modules compile in this build anyway), and the Dickson lemma's docstring loses "closed under
   sums" with its hypothesis.
2. **The build** (`./scripts/build.sh` under the slot, the brief's line), then **`lake lint`** — a saved stage.
3. **The gate on one commit**: `data/fs131/clone1/run-gate.sh`'s steps copied to `data/fs131/ict2/run-gate.sh`, logs under
   `data/fs131/ict2/gate/`, every count change explained against `data/fs131/ico2/gate/` (gated on `7c72b9bf7`); first its
   inputs: the audit block for the three modules in `scripts/Axioms.lean` (generated from the kernel's print of every record,
   LEAN.md § Searching — Lean, FS131-LGT1's method), the `ARCHITECTURE.md` rows brought to "landed", the vacuity scan's new sites
   with each structure's inhabitant (plan § 3.7), the assumptions step (no hypothesis of ours expected); the statement
   comparison against `data/fs131/ict1/statements-before.txt.gz` with the three ruled changes and the new helper constants; `#print
   axioms` of every head statement — a saved stage.
4. **The read-aloud** of each head statement against ledger row 79, with what is not claimed — a saved stage.
5. **The drafts** for the front files (plan § 3.8 brought to what is proved; "prior art not yet searched" where a novelty line
   would go, item 1000) — a saved stage.
6. **The report**.

## Stage 2 — SAVED (partly): the ruled drops applied; the build running at the coordinator's stop; the gate's tools written, not run

**Stopped here at the coordinator's word** (message of 2026-10-16, about 15:56 UTC: a pause Kooshi called; save a stage
and hand back). What is done, what is running, and what is left, for a successor in this worktree and on this branch.

### 2.1 The two ruled drops (inventory item 1012), applied

- `CayleyThree.even_pmHeight_sub_sum` (`Fibre.lean` l. 179): `(hc : ProperAlong s c)` removed; the proof is now the term
  `⟨∑ j, x j - liftHeight s c x, by rw [pmHeight]; ring⟩`. Its three call sites in `Density.lean`
  (`exists_periodic_properAlong_eqOn`, ll. 462, 463, 473) pass `(s := s) (c := c)` in place of `hc`.
- `CayleyThree.exists_le_mul_of_imp_eq_zero` (`Fibre.lean` l. 430): `(hadd : ∀ x ∈ M, ∀ y ∈ M, x + y ∈ M)` removed, with the
  `have _ := hadd` and its comment; its docstring's "closed under sums and under differences of comparable elements" now reads
  "closed under differences of comparable elements" (the hypothesis it described is gone). Its one call site
  (`exists_slack_bound`) drops `hMadd` from the argument list (`hMadd` is still used there, for `hslack`).
- Doc text only: the three module titles' "(FS-131, planner FS131-KTC1; skeleton)" now reads "(FS-131; planner FS131-KTC1,
  implementers FS131-ICT1 and FS131-ICT2)"; the three `ARCHITECTURE.md` rows say the same in place of "skeleton".
- **Iteration (not evidence):** the three modules elaborated in order with the lakefile's options
  (`data/fs131/ict2/seq.sh drops`, `lean -o` into this tree's `.lake/build`, where none of the three was compiled): each
  `exit=0`, no warning (`data/fs131/ict2/logs/{Circular,Fibre,Density}-drops.log`).

### 2.2 The build

Started 2026-10-16 15:50:42 UTC: `SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py
--mem 8 --cpus 5 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`, process group `3922409`
(`data/fs131/ict2/logs/build1.pgid`), log `data/fs131/ict2/build1.full.log` (its last line `exit=<n>` when it ends), sources'
md5 at the start `data/fs131/ict2/build1.sources.md5`. At the stop it was at batch 288 of 735 (about 1.7 s a batch: the walk;
the three modules and the root compile at the end). It is left to finish (the coordinator's word allows either); its result
is below.

**Result (seen by this job): exit 0, "build: OK — 735 of 735 batches, 4 module(s) rebuilt, 0 module(s) with warnings, 17m41s"**
(15:50:42–16:08:30 UTC; the rebuilt modules are the three `CayleyThree/` modules and the root `Proofs`); `grep -c "declaration
uses 'sorry'"` = 0 in the full output (`data/fs131/ict2/build1.log`, a copy of `build/gate/build/20261016T155042Z-3922412.log`);
the one `error:` line there is the up-to-date check's own (`lake build --no-build`, exit 3, "needs to be rebuilt"), as
expected; the sources' md5 unchanged across the build (`md5sum -c data/fs131/ict2/build1.sources.md5`: OK, four files). So
§ 2.4's step 1 is done; the successor starts at step 2 (lint), on this tree's build as it stands.

### 2.3 The gate's tools, written and **not yet run** (none plant-tested: a successor runs each with its control first)

- `data/fs131/ict2/run-gate.sh` — `data/fs131/clone1/run-gate.sh` with its log directory `data/fs131/ict2/gate/` and slot
  names `ict2-*`; nothing else changed (`diff` in this stage's work).
- `data/fs131/ict2/lean/StatementDump.lean` — FS131-ICT1's dumper, renamed only. Run after the build:
  `lake env lean data/fs131/ict2/lean/StatementDump.lean > data/fs131/ict2/statements-after.txt` (gzip it before committing:
  inventory item 1011).
- `data/fs131/ict2/lean/ReAdd.lean` — the three ruled changes undone by term surgery on the stored types (the two dropped
  binders put back with `mkArrow` after 5 and 3 leading binders, their domains elaborated from the skeleton's text;
  `mcshane_model`'s right side replaced by `∑ j, x j`), printing `AFTER`/`READD`/`CONTROL-TRUE`/`CONTROL-POS`/`RHS-IS-L1` lines
  with `Expr.hash` for comparison with the skeleton's stored hashes (FS131-LCH1's method). Not yet elaborated: it may need a
  fix at first run.
- `tools/fs131_ict2_statements.py BEFORE AFTER READD [--plant]` — the comparator: SAME / RULED (hash and text) / CHANGED /
  MISSING / ADDED, `ALLOWED_PUBLIC` = FS131-ICT1's fifteen public helpers (record §§ 2, 3.4, 5), seven plants. BEFORE is
  `data/fs131/ict1/statements-before.txt.gz`.
- `data/fs131/ict2/lean/AxiomsAll.lean` and `tools/fs131_ict2_audit_block.py` — the kernel's print of every record of the
  three modules, and the generator of their `#print axioms` block for `scripts/Axioms.lean`'s CLEAN section (FS131-ICO2's
  method; a record on any import STOPS it here). The block is not yet in `scripts/Axioms.lean`; after it goes in (a
  `/-! ## FS131-ICT2 … -/` block before `=== PURCHASED ===`, as FS131-ICO2's), run the generator with `--coverage`.
- `data/fs131/ict2/lean/VacuityNew.lean` — the scan's `declarations=` and `refutations-skipped` counts for the three modules
  (FS131-ICO2's reader).
- `data/fs131/ict2/lean/ReadAloud.lean` — the fifteen head and model statements as stored, their axioms, the definitions they
  read and the named inhabitants (`ThreeColour.properAlong_one_two`, `ThreeColour.nonempty_winding_one_two`,
  `isTight_one_two`, `coloringOneTwo`, `mcshane_model`; `colorable_three_rat` for `not_isPeriodic_rat`'s closed carrier,
  which the scan reads as evidence: `scripts/Vacuity.lean` l. 637).

### 2.4 What is left, in order (for the successor)

1. Read the build's end in `data/fs131/ict2/build1.full.log` (§ 2.2) and check `md5sum -c data/fs131/ict2/build1.sources.md5`.
   If it did not finish green, rebuild with the brief's line.
2. `lake lint --no-build -- --no-build --trace` under the slot (LEAN.md § The gate); a finding in the three modules needs a
   proof edit and a rebuild.
3. The dumps (`StatementDump`, `ReAdd`), then `tools/fs131_ict2_statements.py` with `--plant`; the audit block
   (`AxiomsAll` → `fs131_ict2_audit_block.py`, its `--plant`, then the block into `scripts/Axioms.lean`, then `--coverage`;
   the axioms self-test's controls may need moving by `scripts/axioms-controls.txt`'s rule if its counts are read there);
   `VacuityNew`; commit; then `data/fs131/ict2/run-gate.sh` on that commit, and every count against
   `data/fs131/ico2/gate/` (baseline: axioms 11,398 records — 10,747 clean, 569 axiom-free, 77 imported, 5 purchases;
   vacuity `declarations=22357 refutations-skipped=242 sites=1455`, `vacuous=0 stale=0 declared=3 witnessed=38
   generic=1412 unknown=2`; assumptions `axioms=3 rests=99 named=19 inline=14 outside=7 ours=21 open=5 takes=109
   mentions=2`). The three modules are new to `main`, so every change should be theirs.
4. The read-aloud against row 79 (`ReadAloud.lean`'s print; plan § 3.2 has the planner's), with what is not claimed.
5. The drafts (plan § 3.8 brought to what is proved; "prior art not yet searched" where a novelty line would go, item 1000).
   One observation for them: definitions without a spec example of their own — `circularColoring`, `tightSet`, `fibre`,
   `Winding.flip`, `coloringOneTwo` (`heightWinding` is exercised by `isTight_one_two`, `mcshane` by `mcshane_model`); the gate
   item "every definition has an `example` that would fail if it drifted" may want them before the landing (a source edit, so
   a rebuild).
6. The report.
