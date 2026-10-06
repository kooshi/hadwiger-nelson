# FS131-MC1 — the example maps finished and landed (de Bruijn, the implementer)

*Brief: `data/fs131/briefs/FS131-MC1-models-land.md` (on `main`). Branch `fs131-wmb`, worktree `.claude/worktrees/fs131-wmb`, from
`b9b3a9e5`. Started 2026-10-06 10:20 UTC. Logs and working files: `data/fs131/mc/`.*

## Theorems this phase proved

*Filled at each saved stage; the final list is the section "Theorems this phase proved, final" at the end of this file.*

## Stage 1 — SAVED (FS131-MC1): the readback, the build as given

### 1.1 The brief's quotations (standing rule 3)

Each of the brief's fourteen quotations was searched verbatim (`grep -cF`) in its named source; each is found exactly once: `CLAUDE.md`
§ The standard of evidence (1); `plans/FS131-close-inventory.md` items 466, 471, 472, 474, 475, 479, 480 (7; each read in full);
`Plane/Models/Stuck.lean` `stuckModel_terminal` and `stuckModel_hyps` (2); `Plane/Models/Bends.lean` `awayModel_hyps` (1);
`Plane/Models/Moves.lean` `hornModel_shave` (1); `plans/FS131-models-kernel-plan.md`'s Stage 3 heading (1);
`plans/FS131-MB1-implementation.md` § 8.4's heading (1). **No mismatch.**

### 1.2 What was read, and how far

- `plans/STANDING-RULES.md`, `LEAN.md` (this branch's copy, and `main`'s diff against it: the naming rule and the `dupnames.sh` bullet),
  `RUNNING.md` § Building and § Make the gate fail — in full.
- The planner's record `plans/FS131-models-kernel-plan.md` §§ 3.1–3.13 in full; MA1's record Stage 4, its drafts and "What is left";
  MB1's record Stage 4 and drafts; MB2's Stages 7–8, drafts and theorem list — in full. The earlier stages of the three records: headings
  only.
- `plans/FS131-L5-landing.md` (on `main`) Stages 4–6 and the drafts, in full: the gate's order and its instruments.
- `plans/FS131-E7-derivation.md` §§ 7.1–7.6 in full (the terminal claim and what it does to the stuck family's docstrings).
- The inventory's items named above.

### 1.3 The build as given

`data/fs131/mc/build-asgiven.log` (2026-10-06 10:26 UTC, `HEAD=b9b3a9e5`): `build: OK — all 1771 modules already up to date, nothing
built, 1 module(s) with warnings`, `exit=0`; the one warning replayed is `Plane/Models/Stuck.lean:1362:8: declaration uses 'sorry'`
(`stuckModel_terminal`). MB2's full log of the same sources (`data/fs131/mb2/build-3-full.log`) holds no other warning.

### 1.4 What I may and may not change

No statement or definition of a landed declaration; no statement of the lane's skeleton. New declarations in the four model modules (or
beside them); docstrings only in landed modules; the registrations the gate's procedures ask.

## Stage 2 — SAVED (FS131-MC1): `main` merged in (`abe678bb`); the joined tree builds; no doubled name

- **The trial** (`git merge-tree --write-tree --name-only HEAD origin/main`, `data/fs131/mc/merge-trial.txt`; `origin/main` at
  `c52be9e9`, merge base `f46430e2`): one conflict, `scripts/Axioms.lean`; `ARCHITECTURE.md` and `Proofs.lean` merge by themselves.
- **The merge `abe678bb`** (`git merge --no-ff origin/main`): `scripts/Axioms.lean` keep-both, `main`'s blocks first and the example
  maps' block after them, above the `=== PURCHASED ===` banner — 5,328 `#print axioms` lines = `main`'s 5,221 + the lane's 107;
  `git diff origin/main -- scripts/Axioms.lean` removes no line. Against `main`, `Proofs.lean` gains the four `Plane.Models` imports
  and `ARCHITECTURE.md` the four rows, nothing else.
- **The build tree.** Wave 5's compiled modules were copied in from the idle landing worktree before the build
  (`rsync -a --update .claude/worktrees/fs131-w5c/.lake/build/ .lake/build/`, `data/fs131/mc/rsync-w5c-build.txt`: 76 `.olean` files
  written, 24 of them new; that tree is at `ad611866`, whose `Proofs/` is `main`'s — `git diff --name-only 1351ebc2 origin/main --
  Proofs Proofs.lean lakefile.toml lake-manifest.json lean-toolchain` is empty). Lake checks each module's trace by hash, so a
  copied file that did not match its source would have been rebuilt.
- **The build of the joined tree** (`data/fs131/mc/build-merge.log`, `HEAD=abe678bb`): `build: OK — 465 of 465 batches, 5 module(s)
  rebuilt, 1 module(s) with warnings, 8m41s`, `exit=0`; the full log (`build-merge-full.log`) ends `Build completed successfully
  (5807 jobs)` and holds one warning, twice printed: `Plane/Models/Stuck.lean:1362:8: declaration uses 'sorry'`. The five rebuilt are
  the four model modules and `Proofs`.
- **`./scripts/dupnames.sh` on the joined tree, before anything else** (`data/fs131/mc/dupnames-joined.log`, `exit=0`): `dupnames: OK
  — no name is declared by two modules (23 generated on demand, listed above)`. The three brick facts re-proved in this lane carry
  names of their own (`brickBase_mem_interiorPts`, `brickBase_col_eq`, `brickBase_col_zero`), so the join made no doubled name; the
  tidy to wave 5's `BrickMap` is Stage 3's.

### 2.1 A finding sent to the coordinator at this stage (by message, 2026-10-06)

Read by script over the nineteen stuck-family heads of `Plane/ValidMap/Terminal`: `F.Terminal` alone is a hypothesis of `n3_end_chain`
(and of the three `n3_end_*` steps whose `hno` the model fails by design); `cv_l0`, `hornBoundsQR_of_isChainVertex`,
`horn_upper_ne_one`, `c_ends`, `run_ends` take `hM : F.IsTerminalMap`, which is `Valid ∧ IsPlaneMap ∧ Terminal ∧ QROnly`
(`Plane/ValidMap/Chain.lean` l. 76). `stuckModel.QROnly` is not a declaration of the skeleton. So `stuckModel_terminal` proved would
serve one docstring line in full (`n3_end_chain`); `cv_l0`'s needs `QROnly` beside it. The other fifteen heads take `Covers` or
`IsPlaneMap` with `IsStuck` or `IsChainVertex`, which `stuckModel_hyps` supplies.

## Stage 3 — SAVED (FS131-MC1): the ruled removal, the tidy to `BrickMap`, the two folds, the applications

### 3.1 The ruling (inventory item 482), and the one declaration removed

By message, 2026-10-06: option (a) — "remove the declaration `stuckModel_terminal`, land everything else"; "`n3_end_chain`, `cv_l0` and
`hornBoundsQR_of_isChainVertex` keep the hand-model sentence, corrected to say what is now true"; "`c_ends`, `run_ends` (six colours)
and `horn_upper_ne_one` (two chain vertices) keep their open-question or refutation lines untouched".

**Removed, the ruled removal, and nothing else of the skeleton**: from `Plane/Models/Stuck.lean`, with its docstring —

> theorem stuckModel_terminal : stuckModel.Terminal := by
> — source: `Plane/Models/Stuck.lean` l. 1362 at `b9b3a9e5`

and its record in `scripts/Axioms.lean`. The statement check (§ 3.6) shows this as the one skeleton declaration gone.

### 3.2 The work list for a successor: `stuckModel.IsTerminalMap` whole

**Target** (two declarations, to be stated together; `IsTerminalMap` is `Valid ∧ IsPlaneMap ∧ Terminal ∧ QROnly`,
`Plane/ValidMap/Chain.lean` l. 76, and the first two are `stuckModel_hyps`):

    theorem stuckModel_terminal : stuckModel.Terminal
    theorem stuckModel_qrOnly : stuckModel.QROnly
    theorem stuckModel_isTerminalMap : stuckModel.IsTerminalMap :=
      ⟨stuckModel_valid, stuckModel_isPlaneMap, stuckModel_terminal, stuckModel_qrOnly⟩

It serves `cv_l0` and `hornBoundsQR_of_isChainVertex` (which take `hM : F.IsTerminalMap`) and `n3_end_chain` (`hT : F.Terminal`);
`Plane/Models/Applied` already applies each of the three to `stuckModel` with that one hypothesis taken as given, so the day the
target is proved each becomes a closed application by deleting the binder.

**The route for `Terminal`, read against wave 5's library; no Lean of it is written.** `Terminal` is: at every `u`, no MERGE (which
needs a colour with two sectors), no MERGE-RAY and no SHAVE (which need a horn). At `plantPt`: `stuckModel_isStuck`. At `u ≠ plantPt`
it suffices that no colour has two sectors and no sector is a horn set.

| part | what it uses | my count |
|---|---|---|
| general: two sectors of one colour are one if `F.region c ∩ ball u r` is preconnected; a horn of colour `c` is then that whole set, so no horn if the set approaches `u` along an open interval of directions (`ne_hornSet_of_interior_coneAt`, `coneAt_mono`); an open convex set with `u` in its closure does (`mem_coneAt_of_ray`, Mathlib's `Convex.add_smul_sub_mem_interior'`); a convex set off a closed disc is preconnected when some point `p` of it has `(p − q)·(z − q) ≥ ρ²` for every `z` of it (the segment from `p` then misses the disc) | new, in `Paint` | 110 |
| off the closure of `stuckW`: `stuckModel` agrees with the base there, `isSite_iff_of_agreesOff` (`Procedure` l. 2870), then `sevenBrick_not_hasRepeatedColour`, `sevenBrick_not_isHorn` (`BrickMap`) through `relabel` (interior points are the same by `rfl`; a colour with a sector is `castLE` of a brick colour) | 60 |
| the closed disc about the vertex, `u ≠ plantPt`: no horn by `hasHornCount_zero_of_two_spheres` (`HornChart` l. 166) — `Γ` near `u` lies on `sphere plantPt (1/10)` and one of `ω(N)`, `ω(S′)`, which cross at `Im ((u − v) conj (u − N)) = (u − v).re ≠ 0`. No repeated colour: the classes of `7` and `8` near `u` are intersections of balls; the class of `9` is `ball u r ∩ ball v (1/10)` off one closed unit disc (`u` is outside the other: the two closed discs meet at `v` alone) — empty, convex, or on `ω(N)` star-shaped about `u − (r/2) i` by the criterion above (`(p − N)·(z − N) > 1 − r²/2 + (r/2)(9/10)`); the brick's colour is `ball u r` off `closedBall v (1/10)`, star-shaped about `v + (1 + 5r)(u − v)` | 170 |
| the two closed squares: every painted class near `u` is a wedge cut by the square and the ball, convex and open; the brick's colour is `ball u r` off the closed square — for `r ≤ 1/20` the union of at most two half-balls `{0 < (z − u).re · a_u}`, `{0 < (z − u).im · b_u}` (`a_u`, `b_u` the coordinates of `u − p` that equal `±1/20`), which share a point at a corner | 250 |
| assembly | | 40 |

500 to 650 lines against the plan's 300–500. Three families of local classes are not convex and carry the geometry: the class of `9`
beside a unit circle, the brick's colour outside the planted disc, the brick's colour outside a square's corner.

**`QROnly` is not routed here** (the plan's § 3.8: "the only unit arcs are the four tangent arcs, sides `7`/`9` and `8`/`9`, all
carried at a pole of four colours"; priced H there): it quantifies over every centre `P`, so it needs "no arc of `Γ` on a unit circle
but those four" — the brick map's `sevenBrick_not_isRingArc` off the painted set, and on it the squares' segments (no arc of a circle)
and the circle of radius `1/10` (no unit circle).

### 3.3 The brick facts tidied to wave 5's `BrickMap`, and the two folds of item 479

- **`Paint` now imports `Plane/ValidMap/BrickMap`.** The three brick leaves keep their statements (the statement check, § 3.6) and are
  re-proved from wave 5's: `brickBase_mem_interiorPts` is `sevenBrick_mem_interiorPts` at `brickCell c r`; `brickBase_col_eq` and
  `brickBase_col_zero` are `sevenBrick_col_val`, through two new lemmas — `mem_brickCell_of_coords` (this lane's coordinates are a point
  of `brickCell c r`) and `brickBase_col_val` (the base colour of a cell is `(c + 3 r) mod 7`). `brick_floor_eq` and
  `not_int_between`, the coordinate argument written while `BrickMap` was not on `main`, are deleted; `awayModel_centre_brick`
  (`Bends`) reads the colour `6` of the cell `(−1, 0)` from `brickBase_col_val` by `decide`. Not done of FS131-MA1's § 4.3 table: the
  `tangentBrick` family stated as `brickCell 0 1` (four lemmas of `Paint` keep their own proofs; no doubled name, no doubled statement
  of a `BrickMap` lemma).
- **Fold 1** (`awayModel_dist_sq` beside `stuckModel_dist_sq`): one general lemma, `dist_sq_coords (z w : ℂ)`, in `Paint`;
  `stuckModel_dist_sq` is gone (12 uses renamed in `Stuck`) and `awayModel_dist_sq`, the same at the centre `awayP`, is its corollary.
- **Fold 2** (`shadowModel_hornSet_not_mem_hornArcs` over `disjoint_hornSet_hornArcs`): the one-base-point case is now `Paint`'s lemma
  applied; for that the helper's two bounds `|σ| ρ ≤ 2` became `≤ 1` (its two callers supply them by `norm_num`); the far case keeps
  MB2's argument. `shadowModel_mem_hornArcs` is kept (it serves the far case).

### 3.4 The applications: `Plane/Models/Applied` (new)

One module that imports the three model modules and wave 5's `Procedure`, `MapGraph`, `Terminal`, `BaseDense`, and applies the
landed theorems to the models. **The instrument is elaboration**: an application that type-checks has every hypothesis of the
theorem supplied by a named fact about the one object, in the shape the binder asks. Named theorems where the conclusion is worth
citing; `example`s (unnamed, so not audit records, but compiled by the same build) for the hypothesis checks.

| theorem applied | to | as |
|---|---|---|
| `cvb_hole_disconnected` (`MapGraph`) | `hornModel`, `T = holedTile`, hole `tangentDisc` | `hornModel_hole_disconnected` |
| `IsSite` (definition, `Limit`) | `hornModel`, `twoHornModel` at `plantPt` | `hornModel_isSite`, `twoHornModel_isSite` |
| `exists_shave_aux`, `exists_rayMerge_aux`, `exists_merge_aux` (`Moves`) | `hornModel`, `twoHornModel` | three `example`s |
| `exists_vertexStep` (`Procedure`) | `hornModel` | an `example` **taking `hc : hornModel.IsClean` as given** — not proved |
| nine of `FlankUA`'s ten stuck heads | `stuckModel` at `plantPt` | nine `example`s |
| ten of `Terminal`'s nineteen | `stuckModel` at `plantPt` | ten `example`s |
| `n3_end_chain`, `cv_l0`, `hornBoundsQR_of_isChainVertex` | `stuckModel` | three `example`s **taking `Terminal` / `IsTerminalMap` as given** |
| `bend_away_part` (`BendStep`) | `awayModel`, the whole arc | `awayModel_bend_away_part` |
| `bend_away_whole` (`UnitArc`; ruling 471 (c)) | `awayModel`, the sub-arc `[1/5, 3/10]` (`IsRingArc.mono`) | `awayModel_bend_away_whole`, with `awayModel_gap`, `awayModel_isRingArc_gap` |
| `exists_r2Subdiv`, `r2_side_dichotomy` (`R2Cap`), `bend_away_subdiv` (`BendStep`) | `awayModel`, the whole arc | three `example`s |
| `bend_away_gap`, `exists_lensOut_clear` (`BendGap`) | `awayModel`, the sub-arc | two `example`s |

New facts about `stuckModel` that the applications needed, each short: `stuckModel_ncard` (three colours), `stuckModel_isChainVertex`,
`stuckModel_isHorn_pi`, `stuckModel_not_mem_interiorPts`, `stuckModel_interior_allowedCone`, `stuckModel_contacts_frame` (the poles
written as the stuck family writes them), `stuckModel_horn_shadows` (both shadows live on the horn at every radius).

**Not served, and why.** `hasSectors_one_of_contacts`: its `hcont` lists every contact of the colour, and only four contacts of
`stuckModel` are stated. `exists_vertexStep` and Procedure's ten other steps: `IsClean` is not proved for any model (the plan's § 3.8
priced it M: every point of `Γ` carries two colours). `CollarFitOut.map_R1`, `map_R2`, `pushOutProfiles`, `AwayBend.idle`,
`CollarFit.map_hornCount_le`: they take a `CollarFitOut` / `AwayBend` package, which no declaration states for `awayModel`.
`exists_arcStep`: a clean map. The three terminal heads: § 3.2.

### 3.5 The docstring lines (`tools/fs131_mc_docs.py`)

Sixty edits in eleven landed modules, each a pattern matched exactly once inside one declaration's docstring; after writing, every
edited file equals `origin/main`'s with all docstrings blanked (no statement, no definition, no proof touched: 11 of 11). The tool's
self-test refuses a pattern that matches twice, one that matches nowhere and one that is another declaration's text.

- **The four moves** (`Contact`: `exists_shave`, `exists_rayMerge`, `exists_merge`; `Moves`: the three `_aux` forms; `OpenMove`:
  `exists_open`): the "none in Lean … open gate item" sentence replaced by the model and the application's name; the fragments'
  sentences kept ("hypothesis by hypothesis only").
- **`flank_ne_of_doublyShadowed`** (`Contact`): `shadowModel`, `shadowModel_flank_ne`.
- **The stuck family** — `FlankUA`'s nine and `Terminal`'s ten of § 3.4: "no Lean model of all at once" replaced by `stuckModel` at
  `plantPt` with `stuckModel_hyps`, the `bowtie` sentence kept as the fragment's, and the "[hand] … open gate item" sentence replaced by
  the parameters on `stuckModel` and "`Plane/Models/Applied` applies this theorem to it".
- **Kept open, corrected to what is true** (ruling 482): `n3_end_chain` (all but `hT : F.Terminal`), `cv_l0` and
  `hornBoundsQR_of_isChainVertex` (all but `hM : F.IsTerminalMap`: `Terminal` and `QROnly` not proved), `hasSectors_one_of_contacts`
  (all but `hcont`), `exists_vertexStep` (`hornModel` meets all but `hc`).
- **The outward bend**: `bend_away_part`, `bend_away_subdiv` (`BendStep`), `bend_away_gap`, `exists_lensOut_clear` (`BendGap`),
  `r2_side_dichotomy`, `exists_r2Subdiv` (`R2Cap`): `awayModel` and the application.
- **Lines added where none stood**: `bend_away_whole`, `bend_toward` (`UnitArc`: the plane-map model first, the cusp fragment's arc
  as "a model of the hypotheses' letter"); `cvb_hole_disconnected` (`MapGraph`): a valid map of the plane with a holed tile exists, at
  eight colours — `hornModel`; the sentence "Whether a valid plane map with a holed tile exists is not claimed" now reads "The row
  does not claim that …".
- **Untouched**, as ruled: `c_ends`, `run_ends`, `horn_upper_ne_one`, the three `n3_end_*` steps with `hno`; and `a4six`,
  `straddlers_third`, `nb4p` (E7's `F₀`, `F₁`: no Lean object).
- **Not applied** of the plan's § 3.10: the line after `HasHornCount`'s spec example (`OpenMove` l. 36) — `hornModel_hasHornCount` is
  named in `exists_open`'s note instead.

### 3.6 The builds and the checks of this stage

- **The four model modules after the removal, the tidy and the folds** (`data/fs131/mc/build-tidy1.log`): `Paint`, `Moves`, `Stuck`,
  `Bends` rebuilt with **0 warnings** — no `sorry` is left in the lane; that run failed at the new `Applied` alone (an import and a
  namespace of mine: `BaseDense`, `ArcMap.radiusTwoArc`), repaired before the next.
- **The tree with the applications and the docstring lines** (`data/fs131/mc/build-docs.log`; the sources are this stage's commit):
  `build: OK — 466 of 466 batches, 35 module(s) rebuilt, 0 module(s) with warnings, 14m37s`, `exit=0`; the full log
  (`build-docs-full.log`) ends `Build completed successfully` and holds **0 `warning` lines**. `sorry` by the gate's narrow
  pattern under `Proofs/`: 0 lines.
- **The statement check** (`tools/fs131_mc_statements.py`, `data/fs131/mc/statements.out`): the skeleton (`fe9d6d32`) has 132
  declarations in the four modules; **131 are in the tree verbatim and 1 is gone, `stuckModel_terminal`, the ruled removal**. Against
  the branch as given (`b9b3a9e5`, 351 declarations): gone 4 — that one, `stuckModel_dist_sq` (moved to `Paint` as `dist_sq_coords`),
  `brick_floor_eq`, `not_int_between` (the tidy); changed 1 — `shadowModel_hornSet_not_mem_hornArcs` (fold 2; MB2's helper, no
  skeleton statement); 0 problems. Self-test: a second skeleton declaration dropped, a skeleton statement altered and an unlisted
  helper dropped are each reported beside a faithful run (`statements-selftest.out`).
- **The landed modules**: 11 edited, each equal to `origin/main`'s with docstrings blanked.
- **The architecture check**: `RESULT: PASS`; it fired once on its own cause while I worked — `Applied`'s row lacked the import
  `Plane/ValidMap/BaseDense` I had just added (`data/fs131/mc/arch-plant-import.txt`: "imports of Plane/Models/Applied: … real-only
  ['Plane/ValidMap/BaseDense']", exit 1) — a live negative control.
- **The notes check** (`tools/fs131_l5_notes.py --only-flagged`): 196 notes read, 0 CONFLICT. It fired once on my first wording of
  `exists_shave`'s line, where a line break split the phrase it reads ("hypothesis by / hypothesis"): CONFLICT 1, repaired by moving
  the break.
- **The open gate items** (`tools/fs131_mc_gateitems.py`, `data/fs131/mc/gateitems.out`): of wave 5's sixty-two, **33 closed, 29
  remain** (§ Drafts). Its self-test: on `main`'s tree all 62 are found and read REMAIN; four planted sentences read as they must
  (one of them the defect its first run had — `owed` matched inside "shadowed" — found because the count came out 23).

## Stage 3 — SAVED (FS131-MC1)

## Stage 4 — SAVED (FS131-MC1): the full gate on `3fe561a9` — green at every step

**The gated commit is `3fe561a9`**: this line at `791a3fbf` (Stage 3) with the registrations below, and `origin/main` at `74d392dc`
merged in (`git diff --name-only c52be9e9 74d392dc` names 18 paths under `data/` and 5 under `plans/`, nothing else). Runner
`data/fs131/mc/run-final.sh` → `run-pass.sh final` → `run-gate.sh final` (FS131-L5's runner with its log directory changed), each step
under the slot, each driver log ending in its exit status. `data/fs131/mc/run-gate-final.head` records `HEAD=3fe561a9…` and **no tracked
file modified**. A first pass ran on `791a3fbf` (tag `first`), before the registrations; every step read exit 0 there too.

### 4.1 What this job registered, by the gate's own procedures

- **`scripts/Axioms.lean`**: 223 records in a block "FS131-MC1" (every theorem of the five model modules the four jobs' blocks did not
  list, `Applied`'s fifteen among them; `tools/fs131_mc_register.py`), and `stuckModel_terminal`'s record removed. 5,550 records =
  `main`'s 5,221 + the lane's 329 theorems.
- **`scripts/Vacuity.lean`**: a docstring entry "The example maps' carriers (FS131-MC1 …)": **no new carrier, IN or OUT** — the lane
  defines maps, sets and colourings, no structure and no predicate — so `trackedProps` and the controls are unchanged (62). No carrier's
  class was changed.
- **`scripts/vacuity-baseline.txt`**: the header's two count lines, from `scripts/gate_report.py header`. No entry added.
- `ARCHITECTURE.md`: the five rows of `Plane/Models/` (Stage 3). `Proofs.lean`: the import of `Applied`.

### 4.2 The steps, each saved log read

| step | result | log (`data/fs131/mc/`) |
|---|---|---|
| build | `build: OK — all 1801 modules already up to date, nothing built, 0 module(s) with warnings`, exit 0; the full build of these Lean sources is Stage 3's: 466 of 466 batches, "Build completed successfully (5808 jobs)", **0 `warning` lines** | `build-final.log`; `build-docs.log`, `build-docs-full.log` |
| `sorry` | narrow pattern: **0** lines; `\bsorry\b`: 5, all prose, the five wave 5's landing listed (`Packed` l. 266, `Plane/Cover` l. 33, `Plane/CoverExamples` l. 13 and 6541, `BendStep` l. 345) | `sorry-narrow-final.txt`, `sorry-wide-final.txt` |
| doubled names | **"dupnames: OK — no name is declared by two modules (23 generated on demand, listed above)"** | `dupnames-final.log`, `receipt-dupnames-final.log` |
| its self-test | "OK — all 15 controls behaved: every planted fault fired, and every partner passed." | `dupnames-selftest-final.log` |
| axioms | **"axioms: OK — 5525 clean, 16 axiom-free, 4 imported, 5 declared purchase(s)"**; "audited: 5550 records" | `axioms-final.log`, `receipt-axioms-final.log` |
| its self-test | "OK — every planted fault fired, and every partner passed." (23 controls) | `axioms-selftest-final.log` |
| vacuity | **"vacuity: OK"**; `declarations=13386 refutations-skipped=192`, `sites=1137 vacuous=0 stale=0 declared=3 witnessed=37 generic=1095 unknown=2`; baseline header "match (9 of 9 compared)" | `vacuity-final.log`, `receipt-vacuity-final.log` |
| its self-test | "OK — all 62 controls behaved: every one fired, and the silent ones stayed silent." | `vacuity-selftest-final.log` |
| architecture | "RESULT: PASS", exit 0 | `arch-final.txt` |
| guarded lint (`lake lint --no-build -- --no-build --trace`, `--mem 8`) | exit 0, "-- Linting passed for Proofs.", 14 linters each "Passed!" | `lint-final.log` |
| notes | `notes read: 196 LOCAL-SAID=31 NO-OBJECT=48 NONE-SAID=59 no-conflict=58`, **0 CONFLICT** (193 at wave 5's landing; the three new are the lines on `bend_away_whole`, `bend_toward`, `cvb_hole_disconnected`) | `notes-final.txt` |

### 4.3 The axioms, reconciled

- **Against `main`'s gated audit** (`data/fs131/l5/receipt-axioms-final.log`, 5,221 records) by `scripts/gate_report.py axioms`
  (`digest-axioms-draft.txt`): **329 records added, every one CLEAN on exactly `[propext, Classical.choice, Quot.sound]`; 0 removed; 0
  changed.** 5,221 + 329 = 5,550. Imported 4 and purchases 5 unchanged: the lane has no `axiom` and no `native_decide`.
- **Every theorem of the landing is audited** (`tools/fs131_l5_records.py` on the kernel's own list, `count-modules-final.out` against
  wave 5's `data/fs131/l5/count-modules-landing.out`; `records-final.txt`, PASS): the library holds 8,677 theorems against `main`'s
  8,330 — 347 new, 0 gone; 18 are generated by Lean (`eq_1`); **the 329 hand-written each have exactly one record under CLEAN, each on
  exactly the standard three**: `Paint` 106, `Moves` 72, `Stuck` 99, `Bends` 37, `Applied` 15.
- **The heads**, each "exactly the standard three" in that check: `hornModel_shave`, `hornModel_open`, `twoHornModel_rayMerge`,
  `twoHornModel_merge`, `stuckModel_hyps`, `shadowModel_flank_ne`, `awayModel_hyps`, `awayModel_bend_away_part`,
  `awayModel_bend_away_whole`, `hornModel_hole_disconnected`.

### 4.4 The vacuity counts, reconciled — and what the scan reads at the sites these models inhabit

- **The counter agrees with both scans** (`tools/fs131_l5_vacdiff.py`, `vacdiff-final.txt`, PASS): `declarations` 12,999 → 13,386
  (+387: `Paint` 127, `Moves` 86, `Stuck` 116, `Bends` 43, `Applied` 15 — five new modules, no count of a module of `main` changed);
  `refutations-skipped` 182 → 192 (+10: `Paint` 5, `Moves` 2, `Stuck` 3).
- **Row for row against `main`'s gated scan** (1,205 rows): **0 rows lost; 12 added, every one on a declaration `main` does not
  hold.** Five `EVIDENCE WITNESS` rows — `hornModel_isHorn`, `stuckModel_isHorn_pi` (`IsHorn`), `stuckModel_isStuck` (`IsStuck`),
  `awayModel_isRingArc_gap`, `cuspFrag_isRingArc` (`IsRingArc`) — each also a `SITE WITNESSED` row of its own statement (`witnessed`
  32 → 37); two `SITE GENERIC` rows on `Condition5` (`ArcMap.relabel_condition5`, `ArcMap.paint_condition5`; `generic` 1,093 →
  1,095). `sites` 1,130 → 1,137. **No site reads VACUOUS, STALE or UNKNOWN; nothing asks for a baseline entry.** The scan's rows on
  the gated commit are identical to the first pass's (`cmp`).
- **What the scan reads at the sites the models inhabit: nothing new, by its law.** The stuck family's 26 `IsStuck` sites, the moves'
  and the bends' `IsHorn`, `IsRingArc` and `Valid` sites are binders on a variable map and read `GENERIC` before and after — "the
  caller's obligation", against which no witness can be registered. The form of evidence the scan does register, an unconditional
  theorem at a closed instance, it now holds for `IsStuck`, `IsHorn` and `IsRingArc` **at maps of the plane** (before this landing:
  `bowtie`, `cuspFrag`, `l60Frag`, `quadRing`, `sixFrag` — fragments). It does not read a conjunction (`stuckModel_isHorn`,
  `awayModel_hyps`) or an unconditional `X.Valid` as a witness (none of `main`'s 57 witnesses is a `Valid`), so `hornModel_valid` and
  its like add no row. That a model meets every hypothesis of a theorem at once is not a thing this scan can read; it is checked by
  elaboration in `Plane/Models/Applied` and said in the theorem's docstring. No carrier's class was changed.

### 4.5 Each check's negative control, watched

| check | the plant | what went red |
|---|---|---|
| build's warning count | the tree as given (Stage 1) | 1 `warning` line (`Stuck.lean:1362`), against 0 |
| `sorry` scan | the tree as given (`git grep` at `b9b3a9e5`) | 1 line, `Stuck.lean:1363: sorry` (`sorry-narrow-asgiven.txt`), against 0 |
| doubled names | its 15 controls | each fired |
| axioms | its 23 controls; the records check's five plants on the first pass's log (`records-plant.txt`, exit 1: `sorryAx` on a head, a record dropped, doubled, moved under PURCHASED, a head on fewer axioms) | named each |
| vacuity | its 62 controls; the row check's four plants (`vacdiff-plant.txt`, exit 1: LOST, NOT NEW, FLAGGED, COUNTER-DISAGREES) | named each |
| architecture | live: `Applied`'s row without the import `BaseDense` (`arch-plant-import.txt`) | "imports of Plane/Models/Applied: … real-only ['Plane/ValidMap/BaseDense']", exit 1 |
| notes | its self-test (`notes-selftest.txt`: a conflicting note planted in `BendGap`, CONFLICT 0 → 1); and live, my first wording of `exists_shave`'s line (CONFLICT 1; that run's output was overwritten by the repaired run, so the live instance is told here and not kept) | fired |
| lint | none at a landing (ruling 419 (b)) | — |
| this job's tools | `tools/fs131_mc_statements.py`, `fs131_mc_docs.py`, `fs131_mc_gateitems.py` `--self-test` (`statements-selftest.out`, `docs-selftest.out`, `gateitems-selftest.out`) | each plant fired beside a faithful run |

### 4.6 The drafts, checked by the digest

Drafts 1 and 2 below, applied to a scratch copy of `CLAUDE.md`, are read by `scripts/gate_report.py` against the final logs:
§ Trust ledger "match (clean, purchases and imported compared)" (`digest-axioms-draft.txt`); § The gate "match (9 of 9 compared)"
(`digest-vacuity-draft.txt`). The unedited `CLAUDE.md` is flagged STALE by both digests until the filing (5196 → 5525; 12999 →
13386, 182 → 192, 1130 → 1137, 32 → 37, 1093 → 1095).

### 4.7 Read against the informal statement, aloud

- `awayModel_bend_away_part : ∃ M K, M.Valid ∧ IsCompact K ∧ K ⊆ thickening 1 (ringArc awayP (−arcsin (3/10)) (arcsin (3/10))) ∧
  LocalStep awayModel M K` — "wave 5's outward bend applies to an explicit eight-colour map of the plane: there is a valid map
  differing from it inside a compact set within distance 1 of the arc". The content is in the proof term: `bend_away_part` applied
  to `awayModel_hyps`' five clauses in order. It says nothing about which points of the arc are removed (the theorem's later clauses
  are dropped from this statement, not from the application).
- `awayModel_bend_away_whole : ∃ F', F'.Valid ∧ ∀ θ ∈ (1/5, 3/10), ¬ F'.OnRingArc awayP (ringPt awayP θ)` — "on the sub-arc over
  `[1/5, 3/10]`, which no radius-2 contact faces, the whole arc bends away: a valid map in which no interior point of the sub-arc
  lies on an arc of `Γ` on `ω(awayP)`". `cuspFrag_bend_away`'s form.
- `hornModel_hole_disconnected` — "in the eight-colour map `hornModel`, removing the tile around the tangent disc disconnects the map
  graph". With `hornModel_holedTile` it is: **a valid map of the plane with a holed tile exists** (at eight colours, by a planted
  disc of a spare colour) — the configuration FS114-CVB-PINCH's hole clause is about.
- The nineteen `example`s on `stuckModel` state nothing of their own: each is a landed theorem's hypotheses met.
- What none of these is: a statement at six colours, or that `stuckModel` is terminal.

## Stage 4 — SAVED (FS131-MC1)
