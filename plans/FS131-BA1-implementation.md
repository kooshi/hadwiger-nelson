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

## Stage 2 — SAVED (FS131-BA1): the one ruled statement change (`AwayBend.idle`), with D1 proved

- **The change** (inventory ruling 446 (b)): `AwayBend.idle` loses `hA : F.IsRingArc P a b c c'` and `hε : 0 < ε`; with `hA` gone its
  implicit `c'` binds nothing and goes too (it could not be inferred at a call). It now reads
  `theorem AwayBend.idle (hF : F.Valid) {P : ℂ} {a b : ℝ} {c : Fin k} (hC : ∀ θ ∈ Ioo a b, P + 2 * e θ ∈ closure (F.region c)) {ε : ℝ} :
  AwayBend F F (Homeomorph.refl ℂ) ∅ P a b c ε`. Its one call, `BendStep.lean` l. 312 in `bend_away_subdiv`'s `contact` case, drops
  the two arguments. Nothing else in `BendStep` changed: the `intro` line above still names `hA` and `hε`, and the build prints no
  unused-variable warning for them (read in the log, not assumed).
- **D1 proved in the same edit** (it is the proof that shows the two hypotheses unread): every field by `rfl`, `Iff.rfl`,
  `LocalStep.refl`, `isCompact_empty`; `rest` is the empty set by `hC`.
- **Build**: OK — 459 of 459 batches, 5 modules rebuilt (`BendAway`, `R2Cap`, `BendGap`, `BendStep`, `Proofs`), exit 0, no warning
  other than `declaration uses 'sorry'` (`build/gate/build/20261006T061935Z-1633795.log`; driver log `data/fs131/ba1/build1a.log`);
  `BendAway` now 5 `sorry` warnings (was 6). The walk takes about 8 minutes whatever is rebuilt, so I build at group saves and
  iterate under `lake env lean` (never evidence).
- **Statements** (`tools/fs131_ba1_stmt.py`, base `dd8c2c33`): 0 failures; the one allowed change printed; `BendStep`'s changed
  lines: `[312]` (`data/fs131/ba1/stmt-stage2.txt`). `--self-test` after the change: ten plants FIRED, unplanted PASS
  (`data/fs131/ba1/stmt-selftest.txt`).

## Stage 2 — SAVED (FS131-BA1)

## Stage 3 — SAVED (FS131-BA1): lane G whole — `LensOut` and `CollarMapOut`, 14 leaves proved

All of lane G (the plan's G1–G7) is proved: `LensOut.lean` and `CollarMapOut.lean` hold no `sorry`. The plan's order was kept (G1,
G2, G4; G3; G5–G7); the three groups were elaborated one after another under `lake env lean` and saved by **one** build, because the
build's walk costs about 8 minutes whatever is rebuilt and two other builds held the slot (my build waited about ten minutes for it):
the sources were committed before the build (`c036110a`) so a halt would have cost nothing.

### 3.1 What was proved, child by child

| child | declarations | route (the plan's unless said) |
|---|---|---|
| G1 | `pushOutHomeo` (its four proof fields), `pushOutHomeo_polar`, `pushOutHomeo_symm_polar`, `pushOutHomeo_eq_self` | the plan's: `radialMap_radialMap` and `continuous_radialMap_push1` at the dummy toward profiles `PushOutProfiles.toward` (`(a + 1)/2` in the middle); helpers `PushOutProfiles.cases`, `.toward`, `.a_pos`, `.push1_zero`, `.push1_pos`, `.push1_push1` |
| G2 | `pushOutProfiles_collar` | the mirror, with a spec example at `R' = 3/4`, `R = 9/8`, `R'' = 5/4` |
| G4 | `dist_lt_one_of_thin` | the plan's triangle inequality; **the constants differ**: with `w = (u + v)/2`, `2 sin(Δ/2) ≤ 2 sin(π/6 − w) = cos w − √3 sin w ≤ 1 − sin w` (`two_sin_half_le_of_gap`: only `√3 ≥ 1` is read) and `κ(u² + v²) ≤ w²/2 < sin w` (`sq_div_two_lt_sin`: `sin w ≥ (2/π) w`, `π < 4`). A spec example at numbers. |
| G3 | `collarOutArcs_carrier` | the mirror, with one step that is **not** a flipped inequality: for `R > 1` the chord from the point of tangency increases because `tangRad R u · cos u` decreases, and that is read off the circle's quadratic (`tangRad_mul_cos_anti`: `t² + 2(R − 1) t cos u = 2R − 1`, `t` increasing by `tangRad_mono`) — in the toward proof both factors decrease. Helpers `tangRad_mono`, `tangRad_mul_cos_anti`, `tangentArc_image_out`, `collarOutMid_eq`, `dist_collarOutMid_left`, `dist_collarOutMid_right` (the crossing is `collarMid`'s point: `max_self` and `min_self` agree on the bisector). |
| G5 | `CollarFitOut.homeo_image_dom`, `collarOutArcs_nondegenerate`, `collarOutArcs_Γ`, `map_Γ` | mirrors; helpers `CollarFitOut.mem_interiorPts`, `kin_subset`, `kout_subset`, `homeo_eq_self`, `homeo_ringPt`, `homeo_fix_Γ`, `lensOutCurve_subset`, `ringPt_mem_lensOutCurve`, `not_kept`, `homeo_image_Γ` (the toward lemmas re-proved for `CollarFitOut`: the collar set is the same, the structure is not) |
| G6 | `CollarFitOut.map_lens`, `map_agreesOff` | mirrors: the **inner** collar is stretched over the lens (`push1_mem_Ico` at `(m, m') = (l, 1)`) |
| G7 | `CollarFitOut.map_valid` | the mirror with `dist_lt_one_of_mem_lensOutSet` (new, in `LensOut`: `dist_lt_one_of_thin` at `κ = R − 1` through `outerProf_le_left`, `outerProf_le_right`, `tangRad_sub_one_le`) |

### 3.2 A finding about a statement: `dist_lt_one_of_thin` does not read `hκ0`

`hκ0 : 0 ≤ κ` follows from the other hypotheses (`1 ≤ t₁ ≤ 1 + κ (φ₁ − α₁)²` and `α₁ < φ₁`), and the proof does not use it: with
`clear hκ0` as its first line the proof elaborates unchanged (scratch run, iteration grade). The linter says so too ("Variable name
`hκ0` is not explicitly referenced"). **I did not change the statement**: the proof keeps the binder by `have _ := hκ0` (inventory
ruling 419 (c)'s form for a kept hypothesis), and its one caller (`dist_lt_one_of_mem_lensOutSet`) passes `0 ≤ R − 1`. Removing it is
a ruling's to make (ruling 419 (a)'s rule); it would change that statement and one call. Held for the coordinator.

### 3.3 The re-pricing the brief asks for (after G1 and G4)

Each of G1, G2, G4 and G3 elaborated on its first run; G5–G7 on their first run; lane G whole is about 600 lines and took a fraction
of one session. The plan priced this half at about two sessions (`LEAN.md`: a kernel leaf priced from a plan's table is priced
high): **re-priced at well under one session for lanes G and D together**, the remaining cost being build waits, not proofs.

### 3.4 The build and the receipts

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 459 of 459 batches, exit 0, 5 modules rebuilt (`LensOut`, `CollarMapOut`,
  `BendGap`, `BendStep`, `Proofs`), no warning other than `declaration uses 'sorry'`**
  (`build/gate/build/20261006T064254Z-1791847.log`, which ends "Build completed successfully (5802 jobs)"; driver log
  `data/fs131/ba1/build2.log`). **`LensOut` and `CollarMapOut` print no warning** (they printed 7 and 7). Distinct `sorry` warnings
  left: 24 — `BendAway` 5 (lane D, next stage), and not this job's: `R2Cap` 3, `HornChart` 4, `BendGap` 8, `BendStep` 1,
  `Procedure` 2, `Terminal` 1.
- **Axioms** against that build's oleans (`data/fs131/ba1/BA1AxiomsG.lean` → `BA1AxiomsG.out`, `slot.py --mem 12 --cpus 2 -- lake
  env lean`, exit 0; IR1's `tools/fs131_ir_axsum.py`, `BA1AxiomsG-summary.txt`, PASS): **48 records — 45 on the standard three or
  fewer** (the 14 leaves, 27 helpers, `claim_e`, `end_cap`, `collarOutArcs_locallyFinite`, and `CollarFitOut.pushOutProfiles`, which
  KA1 had through `sorryAx`), **3 through `sorryAx`, exactly the expected ones** (`bend_away_gap`, `bend_away_subdiv`,
  `bend_away_part`: the other half's open children, and lane D's until the next stage), 0 other. **Control**: with `bend_away_part`
  left off the expectation list the summarizer exits 1 naming it (`BA1AxiomsG-control.txt`).
- **Statements** (`tools/fs131_ba1_stmt.py`, base `dd8c2c33`): 0 failures over 1,795 base files; the one allowed change
  (`AwayBend.idle`); `BendStep`'s changed lines `[312]`; 27 new declarations listed in `LensOut` and `CollarMapOut`
  (`data/fs131/ba1/stmt-stage3.txt`). No `axiom`, no `native_decide`.
- **Names**: none of the new helpers' names is declared on `main`, `fs131-w5y`, `fs131-w5z` or `fs131-w5c` at this writing (grep by
  `theorem <name>`).

## Stage 3 — SAVED (FS131-BA1)
