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

## Stage 2 — SAVED (FS131-BA2)

## Stage 3 — SAVED (FS131-BA2): C4, the lens's clearance — the new mathematics — in the kernel; C5; C7, C9 and C6's first clause from the other half's children

### 3.1 C4 `exists_lensOut_clear`: the planner's hand proof (§ 2.5) checked step by step, and it holds

Statement unchanged. **On `[propext, Classical.choice, Quot.sound]`** (`data/fs131/ba2/BA2Axioms-stage3.out`; the control — expecting it
through `sorryAx` — fails naming it as standard). I am this derivation's first check, so, by step:

| step of § 2.5 | holds? | the Lean form |
|---|---|---|
| near or far (`n2_sign`), near is closer than `1` (`n2_env_near_away`, the class off a disc about `P` by `hin`) | yes | `away_clear`'s first case, inline |
| far: within `r` of the radius-2 arc (`n2_env_away`) | yes | `r = min d₀ (η/2)` |
| the arc's middle is a positive distance `d₀` from the class (compact against closed, `hgap`) | yes | `exists_gap_middle_far` (`Disjoint.exists_thickenings`), the middle being the angles `[θ₁ + η/4, θ₂ − η/4]` |
| so the far point is within `η` of an end's radius-2 point | yes | the triangle inequality with `‖e θ − e θ'‖ ≤ |θ − θ'|` |
| beyond the end: `claim_e`, no smallness | yes | `lens_end_far`, second case, in the frame coordinates `(r2X, r2Y)`: `z₁ < 1` because the lens point is strictly inside the end's circle and not inside `ω(P)` |
| gap side: `dist y P ≥ 2` (N-c: "far" does the work) | yes | `two_le_dist_of_far`: the direction of `y` from `P` (`eq_polar_frameDir`, `Complex.arg`) is an angle of the closed arc once `η ≤ sin(θ₂ − θ₁)` and `η ≤ 1/2`, and `y` is at least `1` from the arc's point in that direction |
| gap side: the dichotomy's "none" case gives the cap; "all" contradicts `hgap` | yes | `exists_gap_cap` (both ends through one `σ`) |
| `end_cap` once `R = 1 + τ/2 ≤ ρ₀ − 1` | yes | `lens_end_far`, first case; `τ < 2(ρ₀ − 2)` at each end |

Nothing in the statement had to move, and no extra smallness beyond the plan's (`η`, `r`, `τ`) was needed. The one thing § 2.5 left
implicit and the kernel wanted: the far point's `-2 < r2Y` (it is on `P`'s far side of nothing — `p₁ > 0` in Claim E), from `η ≤ 1/2`.
The proof is split into six lemmas because one declaration shares one heartbeat budget (`LEAN.md` § Searching; the first monolithic
form died in `nlinarith` at 200,000 heartbeats — no limit was raised).

### 3.2 The other children of this stage

- **C5 `exists_collarFitOut`** — proved, on the standard three: `exists_collarFit`'s proof with `exists_lensOut_clear`, radii
  `1 − τ`, `1 + τ/2`, `1 + τ`.
- **C6, first clause, `CollarFitOut.map_ringArcsWithin`**; **C7 `CollarFitOut.map_localStep`**; **C9 `CollarFitOut.awayBend`** (every
  field) — proved **from the other half's children**, which are `sorry` in this tree until the merge (`map_Γ`,
  `collarOutArcs_carrier`, `collarOutArcs_nondegenerate`, `map_agreesOff`, `map_lens`, `map_valid`, `pushOutHomeo_polar`,
  `pushOutHomeo_eq_self`, `LocalStep.of_cutArcs`), and — for `awayBend` — from my own still-open `map_R1`, `map_R2`,
  `map_hornCount_le`. Nine access lemmas for the outward collar under names of their own (`CollarFitOut.prof_cases`,
  `lensOutCurve_subset_collar`, `lensOutSet_subset_collar`, `ringArc_subset_collar`, `collar_isClosed`, `collar_inter_sphere`,
  `homeo_off_collar`, `homeo_maps_collar`, `homeo_fix_Γ_off_arc`).
- **Open after this stage**: `CollarFitOut.map_R1`, `CollarFitOut.map_R2` (C6's long mirrors), `CollarFitOut.map_hornCount_le` (C8),
  `CollarFit.map_hornCount_le` (the toward bend's horn child).

### 3.3 The coordinator's message of this stage (inventory item 452 (b)), and what I did with it

Received while the build ran: FS131-BA1 has `LensOut` and `CollarMapOut` proved (`origin/fs131-w5a` at `66cb0314`) with public helpers
the skeleton did not state; I am to **merge `origin/fs131-w5a` into this branch and use them, not re-prove them under other names**.
Checked at once (a scan of my three files against the 33 names of the message): **no name of mine collides**. Four of my access lemmas
re-prove a BA1 lemma under another name (`prof_cases` ≈ `PushOutProfiles.cases`, `lensOutCurve_subset_collar` ≈
`CollarFitOut.lensOutCurve_subset`, `homeo_off_collar` ≈ `CollarFitOut.homeo_eq_self`, `homeo_fix_Γ_off_arc` ≈
`CollarFitOut.homeo_fix_Γ`); they are replaced by BA1's at the merge (Stage 4). This stage is saved first, on the skeleton's base, so
the merge is its own commit.

### 3.4 The build and the receipts

- **Build**: **OK — 459 of 459 batches, 3 modules rebuilt (`BendGap`, `BendStep`, `Proofs`), exit 0, no warning other than
  `declaration uses sorry`** (`build/gate/build/20261006T065233Z-1853457.log`; driver log `data/fs131/ba2/build2.log`). **27 distinct
  `sorry` warnings** (32 before): `BendGap` 8 → 3.
- **Axioms** (`BA2Axioms.lean` → `BA2Axioms-stage3.out`, `BA2Axioms-stage3-summary.txt`, PASS): **49 records — 41 on the standard three
  (with `exists_lensOut_clear`, `exists_collarFitOut` and their twelve helpers), 8 through `sorryAx`, exactly the expected ones**
  (`exists_r2Subdiv`, `map_ringArcsWithin`, `map_localStep`, `awayBend` — from the other half's children — and the four open ones).
  **Control**: expecting `exists_lensOut_clear` through `sorryAx` fails ("SORRY-EXPECTED-BUT-STANDARD").
- **Statements**: `tools/fs131_ba2_stmt.py`: **0 failures over 1,795 base files** (`data/fs131/ba2/stmt-stage3.txt`).

## Stage 3 — SAVED (FS131-BA2)

## Stage 4 — SAVED (FS131-BA2): the two merges (ruling 452 (b)); the horn clause for both bends (C8 and the toward bend's child); 14 of 16 children proved, C6's two long mirrors left

### 4.1 The merges

- `9b665413` — `origin/fs131-w5a` at `66cb0314` (lane G: `LensOut`, `CollarMapOut` proved; `AwayBend.idle`'s ruled change with its one
  call in `BendStep`). No conflict.
- `43dfeb6e` — `fs131-w5a` at `4559c106` (FS131-BA1 done: `BendAway` proved; `dist_lt_one_of_thin`'s ruled change — no child of mine
  calls it). **One conflict, `scripts/Axioms.lean`, both blocks kept** (FS131-BA1's, then FS131-BA2's, above `=== PURCHASED ===`). The
  index was checked before each commit: under `Proofs/` the merged tree differs from `4559c106` in my three files and `BendStep`'s horn
  child only.
- **Names.** None of mine collided with BA1's 33. Four access lemmas of mine that re-proved a BA1 lemma under another name were
  **deleted** and their uses moved to BA1's: `CollarFitOut.prof_cases` → `PushOutProfiles.cases`, `.lensOutCurve_subset_collar` →
  `.lensOutCurve_subset`, `.homeo_off_collar` → `.homeo_eq_self`, `.homeo_fix_Γ_off_arc` → `.homeo_fix_Γ`. Five stay (no counterpart
  in `CollarMapOut`): `CollarFitOut.lensOutSet_subset_collar`, `.ringArc_subset_collar`, `.collar_isClosed`, `.collar_inter_sphere`,
  `.homeo_maps_collar`.

### 4.2 The horn clause, once for both bends

`hornCount_le_of_collarBend` (`BendGap`): for any map `M` on `F`'s domain that agrees with `F` off a closed collar `collarK P θ₁ θ₂ R'
R''` meeting `F.Γ` only on the arc, with `Γ_M = (Γ_F ∖ α°) ∪` the two germ arcs of curvature `±1/R` from the ends (`R' < R < R''`,
`R ≠ 1`, `R' < 1 < R''`) — no horn count rises. **`CollarFit.map_hornCount_le` (the toward bend, `BendStep`) and
`CollarFitOut.map_hornCount_le` (C8) are each twelve lines over it**, and both are on the standard three axioms. By the place of the
point, as the plan's § 4 has it: off the collar H1; in the collar and not an end, interior (H2) or on the lens arcs, which lie on two
circles of one radius whose centres are apart and closer than a diameter (`im_ne_zero_of_two_spheres`; H3); at an end H4
(`hasHornCount_iff_collar_end`).

**Where the route differs from the plan's § 4.** The plan asked "the converse inclusion of `collarK_frame` near the end, to be minted".
Taken instead: the **polar form of a branch at an end** (`branchPt_end_polar`: the branch of radius `ρ > 1/2` from `r(θ_E)` along the
arc is `P + tangRad ρ u · e(θ_E + σu)` for an angle `u ∈ [0, π/2]` with the same chord — `germ_tangentCircle`, `polar_tangentCircle`,
`eq_of_tangentCircle` and the intermediate value theorem; valid for every `ρ > 1/2`, so it serves `R < 1` and `R > 1` alike), then
`tangRad`'s monotonicity in the radius puts a branch of a curvature between the arc's and the lens's between the collar's two profiles
(`branch_between_notMem_Γ`); the other end's profiles stay off `1` near angle `0` by continuity (`exists_collar_end_radius`). The far
lens arc is excluded near an end without any polar form: its carrier is closed and lies on a circle that meets `ω(P)` only at its own
end (`eq_ringPt_of_mem_tangentCircle`). One σ (`±1`) runs both ends.

### 4.3 State of the 16 children

| child | state |
|---|---|
| H1–H4 (`HornChart`) | proved, standard three |
| C1, C2, C3 (`R2Cap`) | proved, standard three (C3 since the merge) |
| C4 `exists_lensOut_clear`, C5 `exists_collarFitOut` | proved, standard three |
| C6 `CollarFitOut.map_ringArcsWithin` | proved, standard three |
| C6 `CollarFitOut.map_R1`, `CollarFitOut.map_R2` | **open — `sorry`** (the long mirrors; route in § 4.6) |
| C7 `CollarFitOut.map_localStep` | proved, standard three |
| C8 `CollarFitOut.map_hornCount_le` | proved, standard three |
| C9 `CollarFitOut.awayBend` | proved from `map_R1`, `map_R2` (through `sorryAx` by those two alone) |
| `CollarFit.map_hornCount_le` (`BendStep`) | proved, standard three |

So `bend_away_gap`, `bend_away_subdiv` and `bend_away_part` now rest on **two** open children, `CollarFitOut.map_R1` and
`CollarFitOut.map_R2`.

### 4.4 Findings about statements (no statement changed; held for the coordinator)

- *Generalizations* (a hypothesis the proof does not read; each proof opens with `have _ := h` and a comment so the build carries no
  warning): `hasHornCount_zero_of_two_spheres` — `hρ`, `hρ'`; `hasHornCount_iff_of_germ_swap` — `hκ`;
  `CollarFit.map_hornCount_le` and `CollarFitOut.map_hornCount_le` — `hF : F.Valid` (the horn clause is geometry of `Γ`).
- *A stale line outside my files*: `BendStep.lean`'s module header still reads "`CollarFit.map_hornCount_le`, open: its children are
  `Plane/ValidMap/HornChart`'s" — the header is not mine to edit; the child's own docstring is brought to "Proved".
- The docstrings of the 14 proved children said "**Open — `sorry`**"; they now say "**Proved (FS131-BA2)**" (docstrings are not
  statements in the checker; the rebuild they cost is `build5.log`).

### 4.5 The build and the receipts (the tree at this stage)

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 459 of 459 batches, exit 0, no warning other than `declaration uses sorry`**
  (`build/gate/build/20261006T072828Z-2178943.log`; driver log `data/fs131/ba2/build5.log`; the builds of the two merge states and of
  the horn clause before the docstrings: `build3.log`, `build4.log`, all OK). **5 distinct `sorry` warnings**: `BendGap` 2
  (`CollarFitOut.map_R1`, `.map_R2`), and — not this job's — `Procedure` 2, `Terminal` 1. From 39 at the skeleton.
- **Axioms** (`data/fs131/ba2/BA2Axioms.lean` → `BA2Axioms-stage4.out`, `BA2Axioms-stage4-summary.txt`, PASS): **71 records — 65 on
  `[propext, Classical.choice, Quot.sound]`, 6 through `sorryAx`, exactly the expected ones** (`map_R1`, `map_R2`, `awayBend`,
  `bend_away_gap`, `bend_away_subdiv`, `bend_away_part`), 0 other. **Control**: expecting `CollarFit.map_hornCount_le` through
  `sorryAx` fails, naming it as standard (`BA2Axioms-stage4-control.txt`).
- **Statements**: `tools/fs131_ba2_stmt.py --other 4559c106` — the checker extended for the ruled merge: a file outside my four must
  equal the skeleton's **or** the merged commit's; my four are still read declaration by declaration against the skeleton —
  **0 failures over 1,795 base files**, 55 new declarations listed (`data/fs131/ba2/stmt-stage4.txt`). Without `--other` it fails naming
  exactly the three merged files (`stmt-stage4-no-other.txt`: the expected red). `--self-test`: **eleven plants, each FIRED** (the new
  one: an edit to `LensOut` against the merged commit), the unplanted run PASS (`stmt-selftest-stage4.txt`).
- **The map**: no module added; `tools/check_architecture.py` PASS (`data/fs131/ba2/arch-stage4.txt`).
- **Receipt**: my block in `scripts/Axioms.lean` now lists 52 helper records (21 + 31), all proved. I ran no gate, touched nothing on
  `main`, and left no process running.
- Iteration under `lake env lean` (never evidence), errors of mine read and fixed: a monolithic end lemma that died at 200,000
  heartbeats (split into `exists_collar_end_radius`, `branch_between_notMem_Γ`, `collar_end_Γ`; no limit raised); a lemma missing
  `hℓ`; `rfl : M.dom = F.dom` unifying `F` with the bent map until `(F := F)` was given.

### 4.6 What is left, and its route for a successor

**C6's two long mirrors, `CollarFitOut.map_R1` and `CollarFitOut.map_R2`** (`BendGap.lean` l. 984, 989) — about 350 lines of
`BendCollar` l. 866–1275 mirrored; one stage. Not started (budget). The route, with what is already in the tree:
1. `exists_one_side` — the toward proof reads the fit only through `params` (`1/2 < R'`, `1 < R''`) and `short`
   (`collarK_frame`, `side_core`): the collar is the same set, so copy it with `CollarFitOut`'s `params` destructured, or state it
   once for `collarK`.
2. The closed lens `polarSet P (Icc θ₁ θ₂) fun θ => Icc 1 (outerProf θ₁ θ₂ R θ)`: closed (`isCompact_polarSet_Icc P continuous_const
   hp.cont_l`), and it holds `lensOutSet ∪ lensOutCurve` (mirrors of `isClosed_closedLens`, `lens_subset_closedLens`).
3. `sides_end` — with `exists_one_side`, `CollarFitOut.homeo_maps_collar` (mine), `.homeo_eq_self`, `.kin_subset`, `.kout_subset`
   (BA1's). Mind the colours: here the lens holds the **inner** colour `c` (the inner collar is stretched over it).
4. `sides_eq` — `map_agreesOff` off the closed lens with `mem_closure_region_inter_iff_of_agree` (`BendCollar`, public); on it, an end.
5. `map_R1` — `map_ringArcsWithin` (proved), `sides_eq`, and the open arc interior in the bent map (`map_lens` at `t = 1`: the
   `hbent` step of `CollarFitOut.awayBend`); `map_R2` — `map_Γ`, `sides_eq`.
BA1's warning applies (its record § 4.1): a mirror is not always a flipped inequality.

**Not built**: the inhabitant `awayModel` (plan § 5) — owed with the models' lane, as the children's docstrings say.

## Theorems this phase proved (the list the head of this record points to)

Kernel-checked, on `[propext, Classical.choice, Quot.sound]` (`data/fs131/ba2/BA2Axioms-stage4.out`), namespace
`HadwigerNelson.Plane`:
- `ArcMap.hasHornCount_iff_of_agree`, `ArcMap.hasHornCount_zero_of_mem_interiorPts`, `ArcMap.hasHornCount_zero_of_two_spheres`,
  `ArcMap.hasHornCount_iff_of_germ_swap` (`ValidMap/HornChart`) — the horn count where two maps agree, at an interior point, on two
  non-tangent circles, and under a germ swap; with `ArcMap.branch_frequently_mem_sphere`, `ArcMap.branch_curv_eq_of_two_spheres`,
  `ArcMap.germ_eq_of_frequently_branchPt_eq`.
- `ArcMap.exists_r2_crescent_free`, `ArcMap.r2_side_dichotomy` (`ValidMap/R2Cap`) — the radius-2 crescent is free of `Γ` off the
  circle; all or none on each side, with the cap; with `isPreconnected_r2Crescent`, `ArcMap.IsRingArc.exists_inner_ball`, `under_point`,
  `mem_closure_dist_gt` and the frame lemmas (`r2_frame`, `r2_dist_sq`, …).

- `ArcMap.exists_lensOut_clear` (`ValidMap/BendGap`) — **the lens's clearance over a gap, tangent ends included** (FS131-KA1's
  § 2.5 over FS131-E5's two lemmas, now **[kernel]**); with `lens_end_far`, `two_le_dist_of_far`, `ArcMap.lens_far_end`,
  `ArcMap.exists_gap_cap`, `ArcMap.exists_gap_middle_far`. `ArcMap.exists_collarFitOut` — the outward collar exists.

- `ArcMap.exists_r2Subdiv` (`ValidMap/R2Cap`) — the radius-2 contacts over a constant-sided unit arc have a finite subdivision
  (on the standard three since the merge of FS131-BA1's `R2Subdiv.of_local`).
- `ArcMap.CollarFitOut.map_ringArcsWithin`, `ArcMap.CollarFitOut.map_localStep` (`ValidMap/BendGap`) — the outward bend creates no
  unit arc and is a local step on its collar.
- `ArcMap.hornCount_le_of_collarBend`, `ArcMap.hasHornCount_iff_collar_end` (`ValidMap/BendGap`) — **the horn clause of a collar
  bend, either way**; `ArcMap.CollarFitOut.map_hornCount_le` (`ValidMap/BendGap`) and **`ArcMap.CollarFit.map_hornCount_le`**
  (`ValidMap/BendStep`, the toward bend's horn child) over it; with `branchPt_end_polar`, `branchPt_end_unit`, `dist_branchPt_end`,
  `eq_ringPt_of_mem_tangentCircle`, `im_ne_zero_of_two_spheres`, `exists_collar_end_radius`, `ArcMap.branch_between_notMem_Γ`,
  `ArcMap.collar_end_Γ`.
All of the above: axioms `[propext, Classical.choice, Quot.sound]` (`data/fs131/ba2/BA2Axioms-stage4.out`, 65 records).

Proved **from open children** (through `sorryAx`; not a result yet): `ArcMap.CollarFitOut.awayBend` — every field of the clause
package, from `CollarFitOut.map_R1` and `CollarFitOut.map_R2` alone.

## Stage 4 — SAVED (FS131-BA2)

## Drafts for the front page

No gate was run by this job (the brief's item 5), so there are no counts to draft for `CLAUDE.md` § The gate or § Trust ledger. For
the wave's final sync, when its gate passes — each slot named, nothing filed by me:
- **`plans/FS131-close-inventory.md`, a new item after 452**: "FS131-BA2: 14 of its 16 children proved on the standard three —
  lane H whole, C1–C5, C7, C8, `map_ringArcsWithin` — with `CollarFit.map_hornCount_le` (the toward bend's horn child);
  `exists_lensOut_clear` (FS131-KA1's § 2.5) checked step by step and found true as stated; `CollarFitOut.awayBend` proved from the two
  left, `CollarFitOut.map_R1`, `CollarFitOut.map_R2`; `bend_away_part` rests on those two alone."
- **`LEDGER.md`, the row of FS131-KA1's lens clearance (§ 2.5 of `plans/FS131-bendaway-kernel-plan.md`), when the wave files it**:
  regraded [hand, one mind] → **[kernel]**: `HadwigerNelson.Plane.ArcMap.exists_lensOut_clear`
  (`Proofs/HadwigerNelson/Plane/ValidMap/BendGap.lean`), axioms `[propext, Classical.choice, Quot.sound]`, assumptions: none beyond
  its hypotheses (`F.Valid`, a constant-sided unit arc, `c ∉ coloursAt P`, the radius-2 arc in the domain, no contact at an interior
  angle).
- **`BendStep.lean`'s module header** (not mine to edit): "`CollarFit.map_hornCount_le`, open: its children are …" → "proved, over
  `hornCount_le_of_collarBend` (`Plane/ValidMap/BendGap`)".
- **Frontier line, Proof Atlas**: no change owed by this job alone — the wave's closing filing carries them.

---

# FS131-BA3 — the outward bend's last two children (the successor's stages, from 5)

*de Bruijn, the implementer, on branch `fs131-w5z` (at `dae3d93e` when the job began). Brief:
`data/fs131/briefs/FS131-BA3-bend-away-mirrors.md` (on `main`'s tree). Working files: `data/fs131/ba3/`. Tools: `tools/fs131_ba3_*.py`.
The stages above are FS131-BA2's and are not redone.*

## Stage 5 — SAVED (FS131-BA3): the readback, the as-given build, what I may and may not change

### 5.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_ba3_quotes.py` (BA2's checker under this job's prefix) on the brief: **13 quotations, 0 failures**, exit 0
(`data/fs131/ba3/quotes.txt`); its self-test plants a one-letter change in the first quotation and exits non-zero naming it
(`data/fs131/ba3/quotes-selftest.txt`: "13 quotations, 1 failures", "SELF-TEST: FIRED (good)"). No mismatch.

### 5.2 Read for this job

- The brief; `plans/STANDING-RULES.md`; `LEAN.md` in full; `RUNNING.md` § Building and § Make the gate fail, and watch it fail.
- This record whole (BA2's Stages 1–4, § 4.6 the work list); BA1's record §§ 3–4 (`plans/FS131-BA1-implementation.md` on `fs131-w5a`);
  the planner's § 2 (`plans/FS131-bendaway-kernel-plan.md` on `fs131-w5a`: § 2.1, R1 at a pinch, and §§ 2.2–2.6).
- `BendCollar.lean` l. 56–172 and 855–1290 whole (`isClosed_closedLens`, `lens_subset_closedLens`,
  `mem_closure_region_inter_iff_of_agree`, `collarK_frame`, `side_core`, `exists_one_side`, `homeo_mem_collarK`, `sides_end`,
  `sides_eq`, `map_R1`, `map_R2`, `map_R3`); `CollarMapOut.lean` whole; `LensOut.lean` by its definitions and statements;
  `BendGap.lean` l. 868–1101 whole (the fit, the access lemmas, the two open children, the assembly).

### 5.3 The as-given build (`dae3d93e`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — all 1795 modules already up to date, nothing
built, 3 modules with warnings, exit 0** (`build/gate/build/20261006T074220Z-2259178.log`; driver log `data/fs131/ba3/build0.log`).
**5 distinct `declaration uses sorry` warnings**, as the brief expects: `BendGap` 2 (l. 984 `CollarFitOut.map_R1`, l. 989
`CollarFitOut.map_R2`), `Procedure` 2, `Terminal` 1.

### 5.4 What I may and may not change

- **Mine to prove**: `CollarFitOut.map_R1`, `CollarFitOut.map_R2` (`BendGap.lean`).
- **Mine to change, exactly as ruled** (inventory ruling 457 (b)): `hasHornCount_zero_of_two_spheres` loses `hρ`, `hρ'`;
  `hasHornCount_iff_of_germ_swap` loses `hκ`; `CollarFitOut.map_hornCount_le` loses `hF` — each with its calls, which a search of
  `Proofs/` and `scripts/` puts in `HornChart` and `BendGap` alone (one call each: `BendGap` l. 658, l. 561, l. 1080).
- **May**: new helpers as new declarations in `BendGap.lean`; a block "FS131-BA3" in `scripts/Axioms.lean` above
  `=== PURCHASED ===`; this record; `tools/fs131_ba3_*.py`; `data/fs131/ba3/`; the report.
- **May not**: any other statement or definition, anywhere; `BendStep.lean` (its horn child keeps `hF`); `LensOut`, `CollarMapOut`,
  `BendAway`; the toward bend's modules (a helper a mirror needs is a new declaration in `BendGap`); `Procedure.lean`, `Terminal.lean`;
  `main`; a merge; the gate. No `axiom`, no `native_decide`.

### 5.5 The statement check, armed

`tools/fs131_ba3_stmt.py` — BA1's pinned-rewrite checker under this job's prefix: base `dae3d93e`, `EDITABLE` = `HornChart`,
`BendGap`; the three ruled names must each equal the base statement with exactly the ruled rewrite; every other file under `Proofs/`
byte-identical to the base. At the tree as given: `--before-ruled` (no statement may differ) **0 failures over 1,795 base files**
(`data/fs131/ba3/stmt-stage1.txt`); the pinned form is **red on exactly the three ruled names**, as it must be before the removals
(`data/fs131/ba3/stmt-stage1-pinned-red.txt`: a ruled change left undone fails). Its `--self-test` is run at Stage 6, on the tree the
removals leave.

### 5.6 The route I take for the mirrors (BA2's § 4.6, with two changes of mine)

1. `exists_one_side` **stated once for the collar set** (`collarK_one_side`: `1/2 < R'`, `1 < R''`, an arc of at most 60°), since the
   toward proof reads the fit through nothing else; the outward form is then one line.
2. `map_R1` **through `sides_eq`**, not by repeating its case split as the toward proof does: R1's point is on `F.Γ`
   (`ringArc_subset_Γ_of_finite`), off the open arc (the open arc is interior in the bent map: `map_lens` at `t = 1`), and at an end
   `Q ≠ P` for the same reason — which are `sides_eq`'s three hypotheses.

## Stage 5 — SAVED (FS131-BA3)

## Stage 6 — SAVED (FS131-BA3): the three ruled removals of unread hypotheses (inventory ruling 457 (b))

### 6.1 The three statements, as they now read

| declaration | removed | its calls (each changed by dropping the argument or its goal) |
|---|---|---|
| `ArcMap.hasHornCount_zero_of_two_spheres` (`HornChart`) | `(hρ : 0 < ρ) (hρ' : 0 < ρ')` | one: `hornCount_le_of_collarBend` (`BendGap`), which passed `hR0 hR0` |
| `ArcMap.hasHornCount_iff_of_germ_swap` (`HornChart`) | `(hκ : |κ₀| * r < 2)` | one: `hasHornCount_iff_collar_end` (`BendGap`), whose first sub-goal (`|σ| * r < 2`) is gone |
| `ArcMap.CollarFitOut.map_hornCount_le` (`BendGap`) | `(hF : F.Valid)` | one: `CollarFitOut.awayBend`'s field `horn` (`BendGap`) |

Verbatim, from the checker's print (`data/fs131/ba3/stmt-stage6.txt`):
- `theorem hasHornCount_zero_of_two_spheres {x q q' : ℂ} {ρ ρ' r : ℝ} (hx : x ∈ F.dom) (hr : 0 < r) (hΓ : F.Γ ∩ ball x r ⊆ sphere q ρ ∪
  sphere q' ρ') (hnt : x ∈ sphere q ρ → x ∈ sphere q' ρ' → (q = q' ∧ ρ = ρ') ∨ ((x - q) * starRingEnd ℂ (x - q')).im ≠ 0) :
  F.HasHornCount x 0`
- `theorem hasHornCount_iff_of_germ_swap {M : ArcMap k} {x : ℂ} {β₀ κ₀ κ₀' r : ℝ} (hx : x ∈ F.dom) (hdom : M.dom = F.dom) (hr : 0 < r)
  (hκ' : |κ₀'| * r < 2) (hF : branchPt x β₀ κ₀ '' Ioo 0 r ⊆ F.Γ) (hM : (M.Γ ∩ ball x r) \ {x} = ((F.Γ ∩ ball x r) \ {x}) \ (branchPt x
  β₀ κ₀ '' Ioo 0 r) ∪ branchPt x β₀ κ₀' '' Ioo 0 r) (hbetween : ∀ κ, min κ₀ κ₀' ≤ κ → κ ≤ max κ₀ κ₀' → κ ≠ κ₀ → ∀ s ∈ Ioo 0 r, branchPt
  x β₀ κ s ∉ F.Γ) (j : ℕ) : M.HasHornCount x j ↔ F.HasHornCount x j`
- `theorem CollarFitOut.map_hornCount_le (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {x : ℂ} {j : ℕ} (hj : F.HasHornCount x j) :
  ∃ j' ≤ j, hfit.map.HasHornCount x j'`

Each proof lost its `have _ := h…` line and the comment above it; nothing else in either file moved (the diff is 6 lines in, 14 out).
No call sits outside `HornChart` and `BendGap` (a search of `Proofs/` and `scripts/` for the three names: the other hits are
docstrings and `#print axioms` lines). `CollarFit.map_hornCount_le` (`BendStep`) keeps its `hF`, as the brief says.

### 6.2 Exactly these three, by script

`tools/fs131_ba3_stmt.py` (base `dae3d93e`): **0 failures over 1,795 base files; the three ruled names each "exactly as ruled"**; no
other statement of `HornChart` or `BendGap` differs from the base, every other file under `Proofs/` is byte-identical to it
(`data/fs131/ba3/stmt-stage6.txt`). `--self-test`: **16 plants, each FIRED for its own reason, the unplanted run PASS**
(`data/fs131/ba3/stmt-selftest.txt`) — each ruled removal left undone, a second change to a ruled statement (two forms), `map_R1`'s
conclusion changed, `map_R1` with an added hypothesis, `map_R2` without `hd`, `map_R2` renamed, a hypothesis dropped from
`exists_collarFitOut`, an edit to `BendCollar`, to `BendStep` (its horn child's `hF` removed) and to `CollarMapOut`, an `axiom` in a
new file and in an editable one, `native_decide` in an editable one. Each plant asserts it changed its file before it is scored.

### 6.3 The build and the receipts

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`), of commit `ef33a037`: **OK — 459 of 459 batches, 4 modules rebuilt (`HornChart`,
  `BendGap`, `BendStep`, `Proofs`), exit 0, no warning other than `declaration uses sorry`**
  (`build/gate/build/20261006T074718Z-2318634.log`, which ends "Build completed successfully (5802 jobs)"; its line 3, "error: target
  is out-of-date and needs to be rebuilt", is the up-to-date probe's answer, after which the walk ran; driver log
  `data/fs131/ba3/build1.log`). **5 distinct `sorry` warnings**, unchanged: `BendGap` 2 (l. 983, 988 now), `Procedure` 2, `Terminal` 1.
- **Axioms** against that build's oleans (`data/fs131/ba3/BA3Axioms-stage6.lean` → `BA3Axioms-stage6.out`, `slot.py --mem 12 --cpus 2
  -- lake env lean`, exit 0; `tools/fs131_ir_axsum.py`, `BA3Axioms-stage6-summary.txt`, PASS): **12 records — 6 on the standard three
  (the three changed statements and the three declarations that call them or stand beside them: `hasHornCount_iff_collar_end`,
  `hornCount_le_of_collarBend`, `CollarFit.map_hornCount_le`), 6 through `sorryAx`, exactly the expected ones** (`map_R1`, `map_R2`,
  `awayBend`, `bend_away_gap`, `bend_away_subdiv`, `bend_away_part`), 0 other. **Control**: expecting
  `CollarFitOut.map_hornCount_le` through `sorryAx` fails, naming it as standard (`BA3Axioms-stage6-control.txt`).
- Iteration (never evidence): the two edited files elaborated outside Lake against a scratch copy of the oleans before the build, so
  the build ran once.

## Stage 6 — SAVED (FS131-BA3)

## Stage 7 — SAVED (FS131-BA3): the helpers of the two mirrors — the one-side lemma for the collar set, the closed outward lens, `sides_end`, `sides_eq`

### 7.1 What landed (seven new declarations in `BendGap.lean`, section `Gap`, before the two children; each elaborated on its first run)

| declaration | mirrors | what differs from the toward form |
|---|---|---|
| `ArcMap.collarK_one_side` | `CollarFit.exists_one_side` | **stated for the set** `collarK P θ₁ θ₂ R' R''` under `1/2 < R'`, `1 < R''`, `θ₂ − θ₁ ≤ π/3` — all the toward proof reads of its fit; the proof is the toward one with `hfit.short` replaced by the hypothesis. A spec example at numbers (`P = 0`, `[0, π/6]`, radii `3/4`, `5/4`, `Q = 2`) |
| `ArcMap.CollarFitOut.one_le_outerProf` | `CollarFit.lensProf_le_one` | the profile is **at least** `1` (the lens is outside `ω(P)`) |
| `ArcMap.CollarFitOut.isClosed_closedLensOut` | `CollarFit.isClosed_closedLens` | the closed lens is `polarSet P (Icc θ₁ θ₂) fun θ => Icc 1 (outerProf θ₁ θ₂ R θ)`: the constant profile is the lower one |
| `ArcMap.CollarFitOut.lensOut_subset_closedLensOut` | `CollarFit.lens_subset_closedLens` | — |
| `ArcMap.CollarFitOut.sides_end` | `CollarFit.sides_end` | **no `hF`** (the toward proof does not read its own); `homeo_maps_collar` (BA2's) for `homeo_mem_collarK`. No colour is named: the lens's colour plays no part at an end |
| `ArcMap.CollarFitOut.sides_eq` | `CollarFit.sides_eq` | **no `hF`**; the one step that is not a flipped inequality: over the open sector a point of the closed lens off `ω(P)` lies in the **outer** collar (`kout_subset`, colour `c'`, through `outerProf R < outerProf R''`), where the toward proof reads the inner collar (`kin_subset`) |
| `ArcMap.CollarFitOut.ringPt_notMem_map_Γ` | (inline in the toward `map_R1`, three times) | the open arc is interior in the bent map (`map_lens` at `t = 1`, the lower end of the lens's interval here, the upper end there) |

BA2's work list (§ 4.6) held as written for items 1–4; its item 1's second option (state it once for `collarK`) is the one taken.

### 7.2 The build and the receipts

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`), of commit `6405a3cb`: **OK — 459 of 459 batches, 3 modules rebuilt (`BendGap`,
  `BendStep`, `Proofs`), exit 0, no warning other than `declaration uses sorry`** (`build/gate/build/20261006T075736Z-2396067.log`,
  ending "Build completed successfully (5802 jobs)"; driver log `data/fs131/ba3/build2.log`). **5 distinct `sorry` warnings**:
  `BendGap` 2 (l. 1208, 1213), `Procedure` 2, `Terminal` 1.
- **Axioms** (`data/fs131/ba3/BA3Axioms-stage7.lean` → `BA3Axioms-stage7.out`, `BA3Axioms-stage7-summary.txt`, PASS): **13 records —
  the 7 helpers on `[propext, Classical.choice, Quot.sound]`, 6 through `sorryAx`, exactly the expected ones**, 0 other.
  **Control**: expecting `CollarFitOut.sides_eq` through `sorryAx` fails, naming it as standard (`BA3Axioms-stage7-control.txt`).
- **Statements**: `tools/fs131_ba3_stmt.py`: **0 failures over 1,795 base files**, the three ruled names exactly as ruled, 7 new
  declarations listed (`data/fs131/ba3/stmt-stage7.txt`).
- **Receipt**: a block "FS131-BA3" of 7 records in `scripts/Axioms.lean`, above `=== PURCHASED ===`.
- **Names**: none of the seven is declared on any `fs131-*` branch head at this writing (a `git grep` over each).

## Stage 7 — SAVED (FS131-BA3)

## Stage 8 — SAVED (FS131-BA3): `CollarFitOut.map_R1` proved, on the standard three

### 8.1 The proof, and where it leaves the toward one

Statement unchanged. Route (mine; the toward `CollarFit.map_R1` repeats `sides_eq`'s case split inline, this one calls `sides_eq`):
1. *The closed arc lies in `F.Γ`* — the toward step word for word with the outward lens arcs: `ringArc_subset_Γ_of_finite`, the arc
   meeting `collarOutArcA`, `collarOutArcB` finitely because their curvature is `1/R ≠ 1` (`germArc_isUnitArc_iff`; `1 < R` here,
   `R < 1` there), and `map_Γ` off them.
2. *An interior point of the arc is off the open arc `α°`*: it is in the bent map's `Γ`, and `α°` is interior there
   (`ringPt_notMem_map_Γ`).
3. *At an end, `Q ≠ P`*: an arc of `ω(P)` in the bent map's `Γ` through an end continues into `α°` — the same fact again.
4. `sides_eq` with 1–3, and the hypothesis's sides.

**The planner's worry at a pinch (plan § 2.1) does not arise in this child**: `map_R1` is about one collar bend, where a pinch point
of the composed bend is an end of the arc; the end case is `sides_end`, proved for every centre `Q ≠ P` with no smallness and no
case on the lens's side. No clause of R1 is false for the outward lens.

**A finding about the statement (none changed)**: `hF : F.Valid` is not read by this proof — R1 is geometry of `Γ` and of the
homeomorphism. The binder is kept by `have _ := hF` with a comment (ruling 419 (c)'s form), as BA2 kept the three removed at Stage 6.
The same holds of the toward `CollarFit.map_R1` (its only use of `hF` is `sides_end hF`, which opens with `have _ := hF`). Held for
the coordinator.

### 8.2 The build and the receipts

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`), of commit `e5532754`: **OK — 459 of 459 batches, 3 modules rebuilt (`BendGap`,
  `BendStep`, `Proofs`), exit 0, no warning other than `declaration uses sorry`** (`build/gate/build/20261006T080733Z-2466966.log`,
  ending "Build completed successfully (5802 jobs)"; driver log `data/fs131/ba3/build3.log`). **4 distinct `sorry` warnings** (5
  before): `BendGap` 1 (l. 1279, `CollarFitOut.map_R2`), `Procedure` 2, `Terminal` 1.
- **Axioms** (`data/fs131/ba3/BA3Axioms-stage7.lean` → `BA3Axioms-stage8.out`, `BA3Axioms-stage8-summary.txt`, PASS): **13 records — 8
  on `[propext, Classical.choice, Quot.sound]` (`CollarFitOut.map_R1` and the 7 helpers), 5 through `sorryAx`, exactly the expected
  ones** (`map_R2`, `awayBend`, `bend_away_gap`, `bend_away_subdiv`, `bend_away_part`), 0 other. **Control**: expecting
  `CollarFitOut.map_R1` through `sorryAx` fails, naming it as standard (`BA3Axioms-stage8-control.txt`).
- **Statements**: `tools/fs131_ba3_stmt.py`: **0 failures over 1,795 base files** (`data/fs131/ba3/stmt-stage8.txt`).

## Stage 8 — SAVED (FS131-BA3)
