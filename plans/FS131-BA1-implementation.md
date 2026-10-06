# FS131-BA1 — the outward collar bend, its lens and its composition (lanes G and D): the implementer's record

*de Bruijn, the implementer, on branch `fs131-w5a` (at `dd8c2c33` when the job began). Brief:
`data/fs131/briefs/FS131-BA1-bend-away-lens.md` (on `main`'s tree). Working files: `data/fs131/ba1/`. Tools: `tools/fs131_ba1_*.py`.
**The plan this record implements is the planner's**: `plans/FS131-bendaway-kernel-plan.md` (FS131-KA1), §§ 2–3 — its § 3.3 is the
plan per child and its § 3.6 the handoff; this record does not restate them.*

## Theorems this phase proved

The list is kept at the end of the last saved stage ("Theorems this phase proved (the list the head of this record points to)").

## Stage 1 — SAVED (FS131-BA1): the readback, the as-given build, what I may and may not change

### 1.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_ba1_quotes.py` (KA1's checker copied under this job's prefix) on the brief: **16 quotations, 0 failures**, exit 0
(`data/fs131/ba1/quotes.txt`); its self-test plants a one-letter change in the first quotation and exits non-zero naming it
(`data/fs131/ba1/quotes-selftest.txt`: "16 quotations, 1 failures", "SELF-TEST: FIRED (good)"). No mismatch.

### 1.2 Read for this job

- The brief; `plans/STANDING-RULES.md`; `LEAN.md` in full; `RUNNING.md` § Building and § Make the gate fail, and watch it fail.
- The planner's record `plans/FS131-bendaway-kernel-plan.md` whole (Stages 1–3, §§ 4–5); inventory items 442–448.
- The modules I hold, whole: `LensOut.lean`, `CollarMapOut.lean`, `BendAway.lean`; `BendStep.lean` l. 285–384 (`bend_away_subdiv`,
  `bend_away_part`).
- The toward bend's modules my mirrors name: `RadialPush.lean` whole (1,138 lines); `CollarMap.lean` whole (463 lines). `BendCollar`
  is lane C's template, not read. Definitions lane D reads (`LocalStep`, `AgreesOff`, `cutArcs`, `IsRingArc`, `OnRingArc`) are read at
  their sources when their child is taken.

### 1.3 The as-given build (`dd8c2c33`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — all 1795 modules already up to date, nothing
built, 9 modules with warnings, exit 0** (`build/gate/build/20261006T061624Z-1587212.log`; driver log `data/fs131/ba1/build0.log`).
**39 distinct `declaration uses 'sorry'` warnings, no other warning**: `BendAway` 6, `LensOut` 7, `CollarMapOut` 7 — **this job's 20
leaves** — and `R2Cap` 3, `HornChart` 4, `BendGap` 8, `BendStep` 1 (the other half's 16), `Procedure` 2, `Terminal` 1.

### 1.4 What I may and may not change

- **May**: the proofs of the 20 leaves in `LensOut.lean`, `CollarMapOut.lean`, `BendAway.lean`; new helper declarations in those three
  files; **one statement**, `AwayBend.idle` (it loses `hA` and `hε`, inventory ruling 446 (b)), with its one call line in `BendStep`'s
  `bend_away_subdiv`; a block "FS131-BA1" in `scripts/Axioms.lean` above `=== PURCHASED ===`; this record; `tools/fs131_ba1_*.py`;
  `data/fs131/ba1/`; the report `data/fs131/reports/FS131-BA1.md`.
- **May not**: any other statement or definition (a false or too-weak child is a message to the coordinator with the configuration);
  `R2Cap.lean`, `HornChart.lean`, `BendGap.lean` and the rest of `BendStep.lean` (FS131-BA2's, on `fs131-w5z`); `Procedure.lean`,
  `Terminal.lean`; the toward bend's modules beyond new declarations (none is planned: a private helper a mirror needs is re-proved in
  the mirror's file, ruling 421 (c)); `main`; a merge; the gate. No `axiom`, no `native_decide`.

### 1.5 The statement check for this job

`tools/fs131_ba1_stmt.py` (KA1's `fs131_ka_stmt.py` under this job's prefix; base `dd8c2c33`; `EDITABLE` = the three files and
`BendStep.lean`; the one allowed statement change `AwayBend.idle`; `pushOutHomeo`, a `def` whose four proof fields are leaves, compared
up to `left_inv`; in `BendStep.lean` only the line holding `AwayBend.idle` may change). At the base: **0 failures over 1,795 base
files**. `--self-test`: **ten plants, each FIRED for its own reason** (`data/fs131/ba1/stmt-selftest0.txt`): a changed hypothesis of
`dist_lt_one_of_thin` (STATEMENT), a changed `toFun` of `pushOutHomeo` (STATEMENT), a changed field of `CollarFitOut` and of `AwayBend`
(STATEMENT), `AwayBend.next` renamed (MISSING), a changed bound in `bend_away_subdiv` (STATEMENT and LINES), a second changed line of
`BendStep` (LINES), an edit to `BendGap` (CHANGED, not editable), an `axiom` in a new file, a `native_decide` in an editable file; the
unplanted run PASS.

## Stage 1 — SAVED (FS131-BA1)
