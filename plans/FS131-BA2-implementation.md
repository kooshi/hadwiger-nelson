# FS131-BA2 — the outward collar bend, lanes C and H: the implementer's record

*de Bruijn, the implementer, on branch `fs131-w5z` (at `dd8c2c33` when the job began). Brief:
`data/fs131/briefs/FS131-BA2-bend-away-gap.md` (on `main`'s tree). The plan this job builds is the planner's record,
**`plans/FS131-bendaway-kernel-plan.md`** (FS131-KA1; §§ 2–4): read that first. Working files: `data/fs131/ba2/`. Tools:
`tools/fs131_ba2_*.py`.*

## Theorems this phase proved

The list is at the end of this record ("Theorems this phase proved (the list the head of this record points to)"); each stage adds
its own.

## Stage 1 — SAVED (FS131-BA2): the readback, the as-given build, what I may and may not change

### 1.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_ba2_quotes.py` (KA1's checker copied under this job's prefix) on the brief: **15 quotations, 0 failures**, exit 0
(`data/fs131/ba2/quotes.txt`); its self-test plants a one-letter change in the first quotation and exits non-zero naming it
(`data/fs131/ba2/quotes-selftest.txt`: "15 quotations, 1 failures", "SELF-TEST: FIRED (good)"). No mismatch.

### 1.2 Read for this job

- The brief; `plans/STANDING-RULES.md`; `LEAN.md` in full; `RUNNING.md` § Building and § Make the gate fail, and watch it fail.
- The planner's record `plans/FS131-bendaway-kernel-plan.md` whole (Stages 1–3, §§ 4–5).
- My modules whole: `R2Cap.lean`, `HornChart.lean`, `BendGap.lean`, `BendStep.lean`; the other half's by statement: `BendAway.lean`,
  `LensOut.lean`, `CollarMapOut.lean` (each whole — they are short).
- The toward bend's modules and the chart machinery as each child names them (logged per stage).

### 1.3 The as-given build (`dd8c2c33`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — all 1795 modules already up to date, nothing
built, 9 modules with warnings, exit 0** (`build/gate/build/20261006T061719Z-1612132.log`; driver log `data/fs131/ba2/build0.log`).
**39 distinct `declaration uses sorry` warnings**, as the brief expects: `BendAway` 6, `LensOut` 7, `CollarMapOut` 7, `R2Cap` 3,
`HornChart` 4, `BendGap` 8, `BendStep` 1, and (not this milestone's bend) `Procedure` 2, `Terminal` 1.

### 1.4 What I may and may not change

- **Mine to prove** (16 open children): `R2Cap` — `exists_r2_crescent_free` (C1), `r2_side_dichotomy` (C2), `exists_r2Subdiv` (C3);
  `HornChart` — `hasHornCount_iff_of_agree` (H1), `hasHornCount_zero_of_mem_interiorPts` (H2), `hasHornCount_zero_of_two_spheres` (H3),
  `hasHornCount_iff_of_germ_swap` (H4); `BendGap` — `exists_lensOut_clear` (C4), `exists_collarFitOut` (C5),
  `CollarFitOut.map_ringArcsWithin`, `.map_R1`, `.map_R2` (C6), `.map_localStep` (C7), `.map_hornCount_le` (C8), `.awayBend` (C9); and in
  `BendStep` the one child `CollarFit.map_hornCount_le`.
- **May**: the proofs of those; new helpers as new declarations in `R2Cap.lean`, `HornChart.lean`, `BendGap.lean`; a block "FS131-BA2"
  in `scripts/Axioms.lean` above `=== PURCHASED ===`; this record; `tools/fs131_ba2_*.py`; `data/fs131/ba2/`; the report.
- **May not**: any statement or definition, anywhere (a false or unusable child is a message to the coordinator with the
  configuration); `LensOut.lean`, `CollarMapOut.lean`, `BendAway.lean` (FS131-BA1's — I read their statements, which stand as `sorry` in
  this tree); the rest of `BendStep.lean`; `Procedure.lean`, `Terminal.lean`; the toward bend's modules (a private helper a mirror needs is
  re-proved in my file); `main`; a merge; the gate. No `axiom`, no `native_decide`.

### 1.5 The statement check, armed

`tools/fs131_ba2_stmt.py` — KA1's `fs131_ka_stmt.py` copied under this job's prefix, `EDITABLE` extended to my four files, the base
moved to the skeleton's commit `dd8c2c33`, `ALLOW` emptied (no statement changes in this job). At the skeleton: **0 failures over 1,795
base files** (`data/fs131/ba2/stmt-stage1.txt`). `--self-test`: **ten plants, each FIRED, the unplanted run PASS**
(`data/fs131/ba2/stmt-selftest.txt`) — a changed hypothesis of a proved theorem, `bend_away_part`'s horn clause changed, a hypothesis
added to `exists_r2_crescent_free`, `hasHornCount_iff_of_germ_swap` renamed, `hbetween` weakened, `hin` dropped from
`exists_lensOut_clear`, an edit to `BendCollar`, an `axiom` in a new file and in an editable one, `native_decide` in an editable one. The
self-test asserts each plant's anchor is present before planting, so a plant cannot pass by planting nothing.

## Stage 1 — SAVED (FS131-BA2)
