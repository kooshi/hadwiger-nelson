# FS131-T3 — the axiom gate: CLEAN means the standard three, and declared outside theorems get their own section

*de Bruijn, the implementer (project tooling), on `main`. Brief: `data/fs131/briefs/FS131-T3-axiom-gate.md`. Started 2026-10-04.*

## Theorems this phase proved

None: a project-tooling job. It changes what the axiom gate accepts, not any theorem.

## Stage 1 — SAVED

### The brief's quotations, checked against their sources

| quotation in the brief | source | result |
|---|---|---|
| "144. **FS131-QA1 done, harness ≈ 380k** (report `data/fs131/reports/FS131-QA1.md`; record `plans/FS131-QA1-audit.md`; commits `1905567e`, `bbee15f0`, `e7a91c31`, `2153ea8e`," | `plans/FS131-close-inventory.md` line 892 | verbatim |
| "* **CLEAN** — every line must be exactly `propext`, `Classical.choice`, `Quot.sound`. Any" | `scripts/Axioms.lean` line 26 (at `a48ca5bb`) | verbatim |

The brief's description of the script ("rejects only `native_decide`/`ofReduceBool` and `sorryAx`, the block after `BAD=0`") matches
`scripts/axioms.sh` at `a48ca5bb`: the CLEAN check is `grep -nE 'native_decide|ofReduceBool'`, the `sorryAx` grep runs over every
record, and the PURCHASED check fails only a record with no `native_decide` in its line.

One reading of the documented rule, stated so it can be challenged: "every line must be exactly `propext`, `Classical.choice`,
`Quot.sound`" cannot mean equality. On `main` 101 records carry a proper subset of the three (57 `[propext]`, 43 `[propext, Quot.sound]`,
1 `[Quot.sound]`) and 11 carry none, all legitimately. The script's own header says "nothing but propext / Classical.choice /
Quot.sound", and the brief's (a) says subset, so the check is a subset check. No record on `main` fails it (stage 2 shows this).

### `main`'s gate before any change

`./scripts/build.sh` (slot 40 GiB, 8 cpus): OK, 440 of 440 batches, 3 modules rebuilt (`Proofs` among them: main's tree was behind
its last landing), 0 with warnings, 8 m 27 s; log `build/gate/build/20261004T131711Z-3762805.log`.

`./scripts/axioms.sh` (slot 24 GiB, 4 cpus): OK — 1308 records: 1292 clean, 11 axiom-free, 5 declared purchases; the recorded
count in `CLAUDE.md` § Trust ledger matches (1292 clean and 5 declared purchases); log
`build/gate/axioms/20261004T132546Z-3822236.log`. The whole audit takes about 3 s, so every control below runs the real file.

### The defect, reproduced on `main`

Harness: `data/fs131/t3/repro_main.sh` takes `scripts/axioms.sh` and `scripts/Axioms.lean` as committed at `a48ca5bb`, patches the
script in three places only (REPO fixed; the Lean file it elaborates; its gate-log directory moved to `build/gate/axioms-t3-repro/`,
so the real gate's `latest` is never touched; each patch asserted to have applied), plants lines before the PURCHASED banner, and runs it.

- **`repro_main.sh defect`** plants
  ```lean
  axiom t3_planted_axiom : True
  theorem t3_planted_clean_user : True := t3_planted_axiom
  #print axioms t3_planted_clean_user
  ```
  under CLEAN. **The committed gate exits 0**: "`==> axioms: OK — 1293 clean, 11 axiom-free, 5 declared purchase(s)`". Its digest
  counts the record as "clean on the standard axioms" and lists the axiom set `1 [t3_planted_axiom]` among the clean ones; the only
  sign anywhere is the count drift against `CLAUDE.md` (1292 → 1293), a flag that never fails. Log
  `build/gate/axioms-t3-repro/20261004T132635Z-3826359.log`. **Defect confirmed.**
- **`repro_main.sh native`**, the harness's partner, moves an existing native purchase (`#print axioms moserSpindle_cnf_unsat`) under
  CLEAN in the same harness. **The committed gate exits 1**: "`==> FAIL: a native purchase appears in the CLEAN section`". So the
  harness runs the gate's checks, and the pass above is the defect, not the scaffolding. Log
  `build/gate/axioms-t3-repro/20261004T132645Z-3827330.log`.

### A second defect the reproduction showed: the receipt prints axiom names relative to `open HadwigerNelson`

`#print axioms` renders each axiom with `MessageData.ofConstName` (core, `Lean/Elab/Print.lean` line 244), which shortens a name
against the open namespaces; `scripts/Axioms.lean` opens `HadwigerNelson`. So the native partner's axiom printed as
`moserSpindle_cnf_unsat._native.native_decide.ax_1_1`, with no `HadwigerNelson.`, and wave 2's import would print as
`Plane.falconer_lemma2_nonempty`. Measured on a scratch file (`build/t3-scratch/pp.lean`): under `open Foo` the axiom `Foo.Bar.myAx`
prints `[Bar.myAx]`; after `set_option pp.fullNames true` it prints `[Foo.Bar.myAx]`. A declared-import list compared against the
receipt must see one spelling of each name, so the fix sets `pp.fullNames` and the receipt names every axiom in full.

### Two more holes of the same shape, found reading the script (each fixed and controlled in stage 2)

1. **A PURCHASED record may carry any other axiom.** The PURCHASED check fails a record only when its line has no `native_decide`, so
   `[propext, …, foo._native.native_decide.ax_1_1, some_axiom]` passes.
2. **An axiom whose consumers are not audited is invisible.** The gate reads only the records `scripts/Axioms.lean` prints; an `axiom` in
   `Proofs/` used by no audited declaration passes every check.
