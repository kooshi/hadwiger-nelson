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

## Stage 2 — SAVED

### The fix, as built

Three files carry it: `scripts/Axioms.lean` (the receipt), `scripts/axioms.sh` (every decision), `scripts/gate_report.py` (the digest), plus
the controls file `scripts/axioms-controls.txt`.

**The receipt** (`scripts/Axioms.lean`):
- `set_option pp.fullNames true` after `open HadwigerNelson`: every axiom prints by its full name (stage 1's second defect). The only
  visible change on `main` is the five purchases' native axioms, which now print as `HadwigerNelson.moserSpindle_cnf_unsat._native…`.
- A namespace `AxiomAudit` with two instruments, each printing fixed-prefix lines and refusing (an elaboration error, so the gate fails)
  rather than printing less:
  - `declareImport n`, called as `#eval AxiomAudit.declareImport ``Full.Name` — **the one list of declared imports**. The double backtick
    elaborates only if the constant exists, so a typo cannot read as an empty list. It refuses unless `n` is an `axiom`, is declared in a
    module under `Proofs` (or in the audit file itself, for the controls), and has a docstring naming a bibliography key of the form
    `[Author2024]` (`LEAN.md` § Assumptions item 1; `isBibKey` is checked by `decide` on five strings, `hasBibKey` by two `#guard`s). Prints
    `DECLARED IMPORT <full name>`.
  - `libraryAxioms`, the file's last command: every `axiom` declared in a module under `Proofs` (or in the file), the native-evaluation
    auxiliaries counted apart. Prints `LIBRARY SUMMARY axioms=N native=M`, then one `LIBRARY AXIOM <full name>` per axiom. On `main`:
    `axioms=0 native=10`.
- An **IMPORTED** banner, its section placed **first, just above CLEAN**, with the procedure for declaring an import beside it (done-means 5).
  Why first: `tools/check_architecture.py` (line 204) reads every `#print axioms` after the PURCHASED banner as a purchase, so PURCHASED must
  stay last; and every wave appends its records just above the PURCHASED banner, so a section there would collide with each landing's
  merge. (The first build placed IMPORTED after PURCHASED; reading `check_architecture.py` showed that wave 2's moved records would then
  have read as undeclared purchases there, so it moved.) Wave 3's merge, below, went through with no conflict.

**Why the list lives in `scripts/Axioms.lean` and not in `ARCHITECTURE.md`.** There Lean itself checks each entry (it exists, it is an
axiom of the library, its docstring names a key), and the landing implementer already edits that file to move records. `ARCHITECTURE.md`
§ Trust is then checked against the list as a second ledger, the way the native purchases' docstrings are checked against PURCHASED:
`LEAN.md` § Assumptions item 4 becomes mechanical.

**The decisions** (`scripts/axioms.sh`, one function `check_receipt`, run by the gate and by `--self-test` alike). Each record's axiom
list is read as a set. Allowed per section — CLEAN: a subset of the standard three; IMPORTED: the standard three and declared imports, at
least one declared import; PURCHASED: the standard three, native axioms (a name with a `_native` component, or `Lean.ofReduceBool` /
`Lean.trustCompiler`) and declared imports, at least one native axiom. Every failure is one line, `FAIL <kind> <detail>`, naming the record
or the axiom:

| kind | what it catches |
|---|---|
| `undeclared-in-clean`, `-in-imported`, `-in-purchased` | an axiom that is neither standard, native, `sorryAx` nor declared (the brief's defect, and stage 1's hole 1) |
| `native-in-clean`, `native-in-imported` | a native purchase outside PURCHASED |
| `import-in-clean` | a declared import under CLEAN: "move its record under IMPORTED" |
| `stale-import`, `stale-purchase` | an IMPORTED record with no declared import; a PURCHASED one with no native axiom |
| `sorry` | `sorryAx` on any record (the older global `grep sorryAx` is kept as well) |
| `undeclared-library-axiom` | an axiom of the library that no `declareImport` names, audited or not (stage 1's hole 2) |
| `declared-not-in-library`, `stale-declaration`, `declared-twice` | a declaration of nothing, of an axiom no audited record carries, or twice |
| `arch-missing` | a declared import that `ARCHITECTURE.md` § Trust does not name in backticks (with or without `HadwigerNelson.`) |
| `library-accounting` | the `LIBRARY SUMMARY` count disagreeing with the `LIBRARY AXIOM` lines read, or the line absent |
| `banners`, `outside-banners`, `malformed` | a banner missing, doubled or unknown; a record before the first banner; a line shaped like a record that is not one |
| `purchase-ledgers` | the source and environment purchase ledgers disagree (the existing check, moved into the function) |

The normalizer now joins only a record's own continuation lines (a record opens with `'…' depends on axioms: [` and ends at `]`); every
other line stands alone.

**The digest** (`scripts/gate_report.py`): counts IMPORTED records ("audited: … N imported (resting on a declared outside theorem) …"),
lists the declared imports, the IMPORTED records with their axiom sets, and the library axioms; reads `CLAUDE.md` § Trust ledger's
sentence in a new form, **"current audit reads N clean and M declared purchases, and I imported"**, comparing all three counts. The older
form (no imported count) is still read, compared on clean and purchases only, and flagged as stale the moment the audit has an IMPORTED
record. The new form keeps the old one as its prefix on purpose: `tools/claude_md_fact_audit.py` (`GATE_RE`, line 668) reads that prefix
at every filing and is not this job's to edit. A changed record whose rendered axiom sets read the same — natives are shown as a count —
now names the axioms that left and arrived; the `pp.fullNames` switch produced five such rows, which read `X → X` before this.

### Controls, each watched firing — `./scripts/axioms.sh --self-test`

23 controls, each planted into a copy of the shipped audit and judged by the gate's own `check_receipt`. Every control is two-sided: the
FAIL lines it predicts must appear, naming the culprit, and any FAIL it does not predict is itself a failure. Last run (pre-merge):
`build/gate/axioms-self-test/20261004T135638Z-4020028.log`, all 23 behaving.

| control | expected and seen |
|---|---|
| `baseline` (the shipped audit, unplanted) | PASS; imported=0, declared=0, library=0; digest: older sentence reads "match … older form", new sentence "match (clean, purchases and imported compared)", the sentence twice exits 3 |
| `imported_declared` — **an IMPORTED record with only a declared import** | PASS; imported=1, declared=1, library=1; digest: new sentence matches, imported count one high reads STALE, older sentence reads STALE "… the audit has 1 imported" |
| `imported_undeclared` — **an IMPORTED record carrying a declared import and an undeclared axiom** | `undeclared-in-imported` naming `t3c_ax_b`, `undeclared-library-axiom`; and no `stale-import` |
| `clean_undeclared` — **a CLEAN record with an undeclared axiom** (stage 1's plant) | `undeclared-in-clean` naming `t3c_clean_user`, `undeclared-library-axiom` |
| `import_in_clean` | `import-in-clean`; no `stale-declaration` |
| `arch_missing` | `arch-missing` naming `t3c_import` |
| `stale_declaration`, `declared_twice` | `stale-declaration`; `declared-twice` |
| `stale_import` (a clean theorem under IMPORTED) | `stale-import` |
| `native_in_imported` | `native-in-imported`, `stale-import` |
| `library_undeclared` (an axiom no audited record uses) | `undeclared-library-axiom` naming `t3c_unaudited` |
| `library_accounting` (a `LIBRARY AXIOM` line dropped from the output) | `library-accounting`; and no `undeclared-library-axiom` |
| `declare_not_axiom`, `declare_outside_library` (`propext`), `declare_no_doc`, `declare_no_key`, `declare_typo` | the copy does not elaborate, with the refusal's own words ("is not an `axiom`", "is not declared in the library", "has no docstring", "names no bibliography key", "Unknown constant `t3c_no_such_axiom`") |
| **existing**: `sorry`, `native_in_clean`, `stale_purchase` | `sorry` naming `t3c_sorry`; `native-in-clean` naming `moserSpindle_cnf_unsat`; `stale-purchase` naming `four_le_chromaticNumber_plane`, with `purchase-ledgers` |
| `purchased_undeclared` (a PURCHASED record on a native axiom and an undeclared one) | `undeclared-in-purchased` naming `t3c_ax_c`, `undeclared-library-axiom`, `purchase-ledgers`; no `stale-purchase` |
| `outside_banners`, `banner_dropped` | `outside-banners`; `banners` naming IMPORTED |

**The controls found two things on their way to green.** (1) `purchased_undeclared` predicted `purchase-ledgers` and did not get it: the
environment-ledger pattern, unchanged from the first version, required a dot in the record's name, so a purchase declared at the root never
reached the ledger comparison. Fixed (`sed 's/.*\.//'` on the name). (2) `declare_typo` expected "unknown constant" and Lean says
"Unknown constant `t3c_no_such_axiom`": the control fired for the right cause (the message names the planted name); the expectation was
corrected to that exact text, which names the culprit. When the IMPORTED section moved first, eight controls went red loudly ("did not
elaborate": their declarations sat after the `declareImport` lines that used them); every planted declaration now goes under PRE.

**The checker broken on purpose** — `data/fs131/t3/mutants.sh`, each mutant a copy of `scripts/axioms.sh` with one edit (asserted to
apply), run as `--self-test`; log `build/t3-mutants/summary.txt`:
- A, the subset check off (the gate as it was): `clean_undeclared`, `imported_undeclared`, `purchased_undeclared` go red.
- B, declared imports not recognized: the PASS partner `imported_declared` goes red, with four others.
- C, the constant — `propext` dropped from the standard three: all 23 go red, the PASS partner `baseline` with 1,296 FAIL lines.
- D, the library check off: `library_undeclared` reads "passed" and goes red, with three others.

Under mutant A the planted case of stage 1 still fails, through `undeclared-library-axiom`: the library list is a second net for an axiom
declared in the library. Only the subset check catches an axiom from outside the library.

### What the old instrument saw that the new one does not

Nothing found. The old CLEAN check matched `native_decide|ofReduceBool` anywhere on a record's line, its name included; the new one reads
only the axiom list, so a record *named* `…native_decide…` with clean axioms no longer fails, which is right, and any axiom named
`…ofReduceBool…` other than `Lean.ofReduceBool` is undeclared and still fails. The old PURCHASED stale check also matched the name. The
old banner check required CLEAN and PURCHASED present; the new one requires all three exactly once and no other.

### `main`'s gate, before the merge

`./scripts/axioms.sh`: OK — 1292 clean, 11 axiom-free, 0 imported, 5 declared purchases; declared imports 0; library axioms other than
native auxiliaries 0; native auxiliaries 10; recorded count matches ("older form … no imported record"). **IMPORTED is empty on `main`
and the clean count is unchanged** (1292 before and after the fix). Log `build/gate/axioms/20261004T135502Z-4014551.log`.
`tools/check_architecture.py`: PASS.

### Wave 2, dry-run — `data/fs131/t3/wave_dryrun.sh`

The tool builds a dry-run audit from a wave's own records with `main`'s instruments and IMPORTED section spliced in, declares the named
axioms, elaborates it in the wave's worktree (`lake env lean`, which builds nothing; the worktree's `FalconerReduction.olean` was newer
than its source), and judges it with `main`'s `check_receipt`. On `fs131-w2` at `59976a11`, declaring
`HadwigerNelson.Plane.falconer_lemma2_nonempty`: `declareImport` accepted the real axiom (its docstring's `` `[Falconer1981]` `` read as a
key), the wave's `ARCHITECTURE.md` § Trust row passed `arch-missing`, and **four records fail `import-in-clean`** — `falconer_reduction`,
`le_chiM_of_falconerFan`, `exists_mem_falconerE`, `fan_tip_ae_mem`: the records wave 2's landing moves under IMPORTED. Under the old gate
all four would have been counted clean. With the four moved (a second dry run): no failure but the wave's 115 `sorry` records (none of
the four among them); clean 1745 → 1741, imported 0 → 4. On `fs131-w2d` (`f7eeace4`, an ancestor of `fs131-w2`) no audited record yet
carries the axiom, and declaring it fails `stale-declaration`, as designed.

### On the merged state (wave 3 landed; inventory item 157)

At the coordinator's word, the work was committed (`a09b2254`, WIP) and `origin/main` merged in (`58a1cea5`; tip `0ff8f659`). The merge of
`scripts/Axioms.lean` went through with no conflict: wave 3's 502 records sit under CLEAN, the IMPORTED section above it, PURCHASED last.
- `./scripts/build.sh` (slot 40 GiB, 8 cpus, BATCH 4): OK — 441 of 441 batches, 14 modules rebuilt, 0 with warnings, 9 m 5 s; log
  `build/gate/build/20261004T140333Z-4046216.log`.
- `./scripts/axioms.sh`: OK — **1810 records: 1794 clean, 11 axiom-free, 0 imported, 5 declared purchases**. Every CLEAN record passes the
  subset check: 1692 carry exactly the standard three, 57 `[propext]`, 44 `[propext, Quot.sound]`, 1 `[Quot.sound]`, 11 none. **No record
  is a finding.** The 502 new records are wave 3's. The digest flags `CLAUDE.md` § Trust ledger as stale (1292 clean → 1794): the sentence
  predates wave 3's landing, and the draft below carries the merged counts. Log `build/gate/axioms/20261004T141303Z-4086598.log`.
- `./scripts/axioms.sh --self-test`: OK, 23 of 23; log `build/gate/axioms-self-test/20261004T141316Z-4087072.log`.
- `tools/check_architecture.py`: PASS.
