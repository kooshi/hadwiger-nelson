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

## Stage 2 — SAVED (FS131-BA2): lane H whole (H1–H4) and lane C's radius-2 half (C1–C3) proved

### 2.1 What landed (seven children; `HornChart.lean` and `R2Cap.lean` now hold no `sorry`)

| child | statement | route taken | against the plan |
|---|---|---|---|
| H1 `hasHornCount_iff_of_agree` | unchanged | `hasDegree_iff_of_agree`'s sector equality, with the horn predicate | as planned |
| H2 `hasHornCount_zero_of_mem_interiorPts` | unchanged | `exists_hasHornCount`'s first case, copied (9 lines; it sits in `Procedure`, downstream) | as planned |
| H3 `hasHornCount_zero_of_two_spheres` | unchanged | **changed route**: no circle–circle intersection count. Two helpers: `branch_frequently_mem_sphere` (a branch meeting a circle at distances accumulating at `0` passes through it at the base point, is tangent there, and has `κ v = −1` for `(x − q) e(−β) = u + v i`, `u = 0` — one real identity and two closed-set limits) and `branch_curv_eq_of_two_spheres` (two branches of one direction on two non-tangent circles have one curvature); a cusp index gives two germs of one direction with different curvatures (`Sorted`), each frequently on one of the circles | the plan's "let `s → 0`" made exact; shorter than `eq_of_tangentCircle`'s argument |
| H4 `hasHornCount_iff_of_germ_swap` | unchanged | as planned: `localSectors_disj`; the germ `(β₀, κ₀)` is the chart's (`germ_eq_of_frequently_branchPt_eq`, a pigeonhole over the germs by `Filter.eventually_all`); the swapped germs `⟨G.β, update G.κ i₀ κ₀'⟩` are sorted (`hbetween` puts every other germ of that direction off `[min, max]`), are `M`'s chart (`isSectorChart_of`; `x ∈ Γ_M` because `M.interiorPts` is open), and have the same directions — `IsSectorChart.hasHornCount` twice | as planned |
| C1 `exists_r2_crescent_free` | unchanged | `exists_end_free`'s proof with the frame at `P + 2e(θ_E)`; `branch_tangent` at `(X/2, Y/2, s/2, 2κ)` | as planned |
| C2 `r2_side_dichotomy` | unchanged | **changed in three places** (below) | the plan's argument, with the frame Cartesian |
| C3 `exists_r2Subdiv` | unchanged | as planned (`R2Subdiv.of_local`, one side at a time, `join` at the point) | as planned; it rests on FS131-BA1's open `R2Subdiv.of_local` |

**C2's route, where it differs from the plan's.**
1. *The half-crescent in the frame's Cartesian coordinates, not as a box image.* New definitions `r2X`, `r2Y` (frame coordinates at the
   radius-2 point) and `r2Side P θ₀ σ ρ₀ x₁` (the open set `{0 < σX < x₁, −1 < Y, 2ρ₀Y + N < 0}`); the half-crescent is
   `r2Side ∩ {2 < dist z P}`. Its connectedness (`isPreconnected_r2Crescent`) is `isPreconnected_of_forall` along a **spine**: each slice
   `X = const` is an interval in `Y` (two monotone quadratics), and the parabola `Y = −X²/(4 + 2τ)` runs through every slice — no
   square root and no angle is read.
2. *One argument for "inside or on the radius-2 circle"*: for `y` with `1 < |y − P| ≤ 2` near a radius-2 point over an interior angle `θ`,
   the point `x` one unit under `y` (`under_point`) lies in `closure (ball (r θ) r' ∩ ball P 1) ⊆ closure (region c)`
   (`IsRingArc.exists_inner_ball`: `innerColours = {c}` and `dense_interiorPts`), so `ne1_region` excludes `y`. The plan split
   `s < 2` from `s = 2`.
3. *The cap by closure, with no angle*: a point `y` of the class with `|y − P| ≥ 2` under the tangent circle is in the open set
   `region c ∩ r2Side` and in the closure of `{2 < dist}` (`mem_closure_dist_gt`), so the open half-crescent holds a point of the
   class — against its colour.

### 2.2 Two findings about statements (none changes one; both are generalizations, held for the coordinator)

- `hasHornCount_zero_of_two_spheres` does not read `hρ : 0 < ρ`, `hρ' : 0 < ρ'`.
- `hasHornCount_iff_of_germ_swap` does not read `hκ : |κ₀| * r < 2` (`F`'s own chart bounds its germ's curvature).
Each proof opens with `have _ := h…` and a comment, so the build carries no unused-variable warning and the statements stand as planned.

### 2.3 Re-pricing (the brief asks for it after C1 and H3)

The plan priced lane H at S, S, M, M–H and C1–C3 at M, M–H, M — a session's main work. Measured: each of the seven landed within one to
three elaboration rounds (H1, H2, C1, H3, H4 on the first; C2's helpers on the second, its main proof on the second; C3 on the second).
`LEAN.md`'s rule held: a kernel leaf priced from a plan's table is priced high, here by about a factor of five. The remaining children
(C4–C9 and the toward bend's horn child) are re-priced at about one stage each, C6 (the longest copies) the largest.

### 2.4 The build and the receipts

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 459 of 459 batches, 5 modules rebuilt (`HornChart`, `R2Cap`, `BendGap`, `BendStep`,
  `Proofs`), exit 0, no warning other than `declaration uses sorry`** (`build/gate/build/20261006T063434Z-1729388.log`; driver log
  `data/fs131/ba2/build1.log`). **32 distinct `sorry` warnings** (39 before): `HornChart` 4 → 0, `R2Cap` 3 → 0; `BendGap` 8, `BendStep` 1,
  and the other half's and the older ones unchanged (`BendAway` 6, `LensOut` 7, `CollarMapOut` 7, `Procedure` 2, `Terminal` 1).
- **Axioms** against that build's oleans (`data/fs131/ba2/BA2Axioms.lean` → `BA2Axioms-stage2.out`, `slot.py --mem 12 --cpus 2 -- lake env
  lean`, exit 0; `tools/fs131_ir_axsum.py`, `BA2Axioms-stage2-summary.txt`, PASS): **37 records — 27 on the standard three (the six
  proved children H1–H4, C1, C2 and their 21 helpers), 10 through `sorryAx`, exactly the expected ones, 0 other.** *Slip of my own, caught
  by the summarizer*: my first expectation list left `exists_r2Subdiv` off; it is proved **from** FS131-BA1's open `R2Subdiv.of_local`,
  and the first run failed naming it. **Control**: with `CollarFit.map_hornCount_le` left off the expectation list the summarizer exits 1
  naming it (`BA2Axioms-stage2-control.txt`).
- **Statements**: `tools/fs131_ba2_stmt.py` (base `dd8c2c33`): **0 failures over 1,795 base files**; 24 new declarations listed
  (`data/fs131/ba2/stmt-stage2.txt`).
- **Receipt**: a block "FS131-BA2" of 21 records (the helpers) in `scripts/Axioms.lean`, above `=== PURCHASED ===`.
- Iteration under `lake env lean` (never evidence): errors of mine read and fixed — a second `conj_e_mul_e` (one exists in
  `ValidMap/Basic` with the factors the other way round; mine is `conj_e_mul_e'`), `IsOpen.inter` on a set-builder conjunction
  (`IsOpen.and`), a `set` that hid a rewrite target, an `obtain` pattern clearing a variable its neighbours depend on.

## Theorems this phase proved (the list the head of this record points to)

Kernel-checked, on `[propext, Classical.choice, Quot.sound]` (`data/fs131/ba2/BA2Axioms-stage2.out`), namespace
`HadwigerNelson.Plane`:
- `ArcMap.hasHornCount_iff_of_agree`, `ArcMap.hasHornCount_zero_of_mem_interiorPts`, `ArcMap.hasHornCount_zero_of_two_spheres`,
  `ArcMap.hasHornCount_iff_of_germ_swap` (`ValidMap/HornChart`) — the horn count where two maps agree, at an interior point, on two
  non-tangent circles, and under a germ swap; with `ArcMap.branch_frequently_mem_sphere`, `ArcMap.branch_curv_eq_of_two_spheres`,
  `ArcMap.germ_eq_of_frequently_branchPt_eq`.
- `ArcMap.exists_r2_crescent_free`, `ArcMap.r2_side_dichotomy` (`ValidMap/R2Cap`) — the radius-2 crescent is free of `Γ` off the
  circle; all or none on each side, with the cap; with `isPreconnected_r2Crescent`, `ArcMap.IsRingArc.exists_inner_ball`, `under_point`,
  `mem_closure_dist_gt` and the frame lemmas (`r2_frame`, `r2_dist_sq`, …).

Proved **from an open child of the other half** (through `sorryAx`; not a result yet): `ArcMap.exists_r2Subdiv` (from
`R2Subdiv.of_local`, FS131-BA1's D6).

## Stage 2 — SAVED (FS131-BA2)
