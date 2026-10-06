# FS131-MB1 — the example maps built, half B: `Plane/Models/Stuck` and `Plane/Models/Bends` (de Bruijn, the implementer)

*Brief: `data/fs131/briefs/FS131-MB1-models-stuck.md` (on `main`). Branch `fs131-wmb`, worktree `.claude/worktrees/fs131-wmb`, cut from the
planner's tip `fe9d6d32`. Started 2026-10-06 08:59 UTC. The plan is `plans/FS131-models-kernel-plan.md` (FS131-KM1), whose § 3.5 prices each leaf.*

## Theorems this phase proved

Listed at the last saved stage, in the section "Theorems this phase proved, at the last saved stage" at the end of this file.

## Stage 1 — SAVED (FS131-MB1): the readback

### 1.1 The brief's quotations (standing rule 3)

`tools/fs131_mb_quotes.py` reads each `> text` / `> — source: path` pair of the brief and counts the text in the file its source line
names (a relative path is read from the main checkout, where Keryx's files live). Output `data/fs131/mb/quotes.out`: **9 quotations, 9
found verbatim, each once; none missing**, exit 0. `--self-test` changes the last character of every quotation and requires all 9 to be
reported missing, beside the faithful run, which must report none: `9 of 9 … faithful run 0 missing -> OK`, exit 0.

### 1.2 What was read, and how far

| file | read |
|---|---|
| the brief; `plans/STANDING-RULES.md`; `LEAN.md` (main checkout, with today's naming rule) | whole |
| `RUNNING.md` § Building, § Make the gate fail, and watch it fail | § Building whole; the second to its l. 295 |
| `plans/FS131-models-kernel-plan.md` (FS131-KM1) | whole |
| `plans/FS131-close-inventory.md` | items 460, 461 whole (461 (c): a plane-map model of `bend_away_whole` is wanted, about 30 lines beside `awayModel`) |
| `plans/FS131-E7-derivation.md` | § 7 (`P₅`) whole; § 6 not yet (read when `shadowModel` is begun) |
| `Plane/Models/Paint`, `Stuck`, `Bends` | whole, every docstring |
| `Plane/ArcMap` | whole |
| `Plane/ValidMap/Basic` | l. 1–300: every definition a leaf names |
| `Plane/LocalMap` | l. 56–319 |
| `Plane/ValidMap/Sectors` | `isSector_iff_of_partition`, `encard_sectors_of_partition`; the cusp fragment whole (l. 445–744) |
| `Plane/ValidMap/BaseSteps` | the bowtie at `E`: `bowtie_coloursAt_zero`, `_isHorn`, `_flanks` (l. 2804–2905), `bowtie_hornSet_zero` … `bowtie_not_shave_zero` (l. 3798–4025); the rest by heads |
| `Plane/ValidMap/UnitArc` | `isRingArc_of_clean`'s head, `l60Frag_isRingArc` (the pattern), `bend_toward`, `bend_away_whole` (statements and docstrings) |
| `Plane/ValidMap/Contact` | `flank_ne_of_doublyShadowed` (statement and docstring) |
| `Plane/ValidMap/Surgery`, `Cone`, `Moves`, `OpenMove` | `germArc`, `carrier_germArc`; by statement: `isOpen_hornSet`, `isPreconnected_hornSet`, `eq_branchPt_of_tanHeight_eq_zero`, `encard_sectorsOf_of_partition`, `dist_branchPt_one`, `mem_coneAt_hornSet`, `e_eq_of_mem_coneAt_hornSet`, `hornSet_curv_eq`, `ne_hornSet_of_interior_coneAt`, `mem_germArc_iff_of_mem_hornSet` |

### 1.3 The build as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` in the worktree: `build: OK — 452 of 452 batches, 5
module(s) rebuilt, 4 module(s) with warnings, 8m6s`, exit 0 (`data/fs131/mb/build-0.log`; the full log, copied from
`build/gate/build/`, is `build-0-full.log`). The full log holds 131 warning lines, **all** `declaration uses 'sorry'` (0 others); distinct:
**59** — `Paint` 13, `Moves` 18, `Stuck` 21, `Bends` 7. As the brief says.

### 1.4 What I may and may not change

**Mine**: the proofs of the `sorry` leaves of `Proofs/HadwigerNelson/Plane/Models/Stuck.lean` and `Bends.lean`; new helper declarations in
those two files; a block "FS131-MB1" in `scripts/Axioms.lean`; this record; `tools/fs131_mb_*.py`; `data/fs131/mb/`; the report.

**Not mine**: any statement of the skeleton — a theorem's head, and the definitions `poleSq`, `poleSqArcs`, `stuckW`, `stuckArcs`,
`stuckCol`, `stuckModel`, `shadowWg`, `shadowWh`, `shadowArcs`, `shadowCol`, `shadowModel`, `awayP`, `awayW`, `awayArcs`, `awayModel`
(a definition is a statement); `Plane/Models/Paint.lean` and `Moves.lean` (implementer A's: I use `Paint`'s open leaves by their
statements, so on this branch whatever reads them rests on `sorryAx` **through `Paint` alone** until A's branch joins); every landed
module; `main`; the files Keryx alone writes. No new `axiom`, no `native_decide`. A false leaf is a message to the coordinator.

**The naming rule** (`LEAN.md` § Searching — Lean, last bullet): a helper of mine begins with its model's name (`stuckModel_…`,
`shadowModel_…`, `awayModel_…`, `cuspArc_…`/`cuspFrag_…`), and each new name is checked against every worktree's `Proofs/` before it is
committed (§ 1.6).

### 1.5 The order, and why it is not the planner's

The planner's order for this half is `Stuck` then `Bends`. I take **the cusp fragment's ring arc first** (three leaves of `Bends`), then
`stuckModel`, then `shadowModel`, then `awayModel`. Reason: the cusp arc reads nothing of `Paint`, so its two model theorems
(`cuspFrag_bend_away`, `cuspFrag_bend_toward`) are the only ones in my files whose receipt can read the standard three **on this
branch**; it is the cheapest whole model, and it prices the lane from two leaves, as the brief asks. The order within the plan's
dependencies is mine by the brief; nothing downstream reads the order.

### 1.6 Tools, each with a planted fault watched to fire

- `tools/fs131_mb_quotes.py` — § 1.1.
- `tools/fs131_mb_statements.py` — **the statement check**: every declaration of the skeleton at `fe9d6d32` in `Stuck` and `Bends` (a
  theorem by its head through the first `:=`, a definition whole) occurs verbatim, once, in the working file; and no path differs from
  `fe9d6d32` outside this job's paths. Output `data/fs131/mb/statements.out`. `--self-test` changes one character of each head in turn
  (53 plants) and requires each reported, beside the faithful run: `53 of 53 … faithful run 0 missing -> OK`.
- `data/fs131/mb/MBAxioms.lean` — the receipt by `lake env lean`: for each record its axioms **and the declarations of its dependency
  closure that are themselves proved by `sorry`, with their modules**, so that "rests on `sorryAx` through `Paint` alone" is read off,
  not asserted. Verdicts `STANDARD-THREE`, `SORRY-VIA-PAINT-ONLY`, `SORRY-IN-OWN-FILES`, `OTHER-AXIOM`. Its control is the skeleton
  itself: every record still open must read `SORRY-IN-OWN-FILES` and name its own leaf.

## Stage 2 — SAVED (FS131-MB1): the cusp fragment's ring arc — `cuspFrag_bend_away` and `cuspFrag_bend_toward` whole, on the standard three

*2026-10-06 09:09 UTC.* Three leaves of `Bends` proved, with four helpers (new declarations in `Bends`: `cuspArc_sin`, `cuspArc_pt`, `cuspArc_mem`,
`cuspFrag_closure_region_subset`; each name checked absent from every worktree's `Proofs/`).

| leaf | route taken | lines |
|---|---|---|
| `cuspFrag_isRingArc` | the planner's (`l60Frag_isRingArc`'s pattern), without `dense_interiorPts`: on `O = B(0, 1/2) ∩ {1 < ‖w + i‖}`, an open neighbourhood of each arc point, the interior points are the points off `ω(i)` and the colour is the side of `ω(i)`; each side's closure by `IsOpen.inter_closure`. The arc's points: `‖i + e θ‖² = 2 + 2 sin θ < 1/4` and `‖2i + e θ‖² = 5 + 4 sin θ > 1` from `−1 < sin θ ≤ −23/25` (`cos t ≥ 1 − t²/2` at `t = θ + π/2 ≤ 2/5`) | 52 (+ 30 of helpers) |
| `cuspFrag_coloursAt_I` | every class lies in `B̄(0, 1/2)`, and `‖i‖ = 1` | 8 |
| `cuspFrag_radiusTwo_disjoint` | `‖i + 2 e θ‖ ≥ 2 − 1` | 10 |

**The build**: `data/fs131/mb/build-1.log` — `build: OK — 452 of 452 batches, 2 module(s) rebuilt, 4 module(s) with warnings, 8m13s`, exit 0;
the full log (`build-1-full.log`): 0 warnings other than `sorry`; distinct `sorry` warnings **56** — `Paint` 13, `Moves` 18, `Stuck` 21,
`Bends` **4** (was 7).

**The receipt** (`data/fs131/mb/MBAxioms-stage2.out`, by `lake env lean` on the built tree): `cuspFrag_isRingArc`,
`cuspFrag_coloursAt_I`, `cuspFrag_radiusTwo_disjoint`, `cuspFrag_bend_away`, `cuspFrag_bend_toward` each read `STANDARD-THREE`
(`[propext, Classical.choice, Quot.sound]`, no `sorry`-proved declaration in the closure). **Controls**: the 23 records still open
each read `SORRY-IN-OWN-FILES` and name their own leaves (the verdict that must fire, fires); `#mb_applies` reads the model theorems
as the landed theorems applied — `cuspFrag_bend_away <- ArcMap.bend_away_whole | APPLIED`, `cuspFrag_bend_toward <- ArcMap.bend_toward |
APPLIED` — and the planted wrong pairing `cuspFrag_bend_away <- ArcMap.bend_toward` reads `NOT-APPLIED`.

**The statement check**: `data/fs131/mb/statements.out` — 53 skeleton declarations, 0 not found verbatim once; no path outside this
job's differs from `fe9d6d32`. `tools/check_architecture.py`: exit 0, `RESULT: PASS` (`arch.out`). `scripts/Axioms.lean`: a block
"FS131-MB1" above the `=== PURCHASED ===` banner, with the three cusp leaves (the two model theorems are already in FS131-KM1's block).

**What this model is and is not** (the planner's § 3.4, unchanged by the proof): the arc's centre `i` is outside the closure of the
fragment's domain and carries no colour, so `hin` and `hout` hold for want of any colour — a model of the hypotheses' letter on a
fragment. Ruling 461 (c)'s plane-map model of `bend_away_whole` rests on `awayModel`, which is the last group of this job's order.

**Re-priced from the first leaves** (the brief's Done means 2). The cusp group: 95 lines against the plan's M + S + S (up to 180).
`stuckModel`'s first group (the arcs as point sets, `stuckArcs_nondegenerate`, `_finite`, `frontier_stuckW_subset`,
`stuckCol_locallyConstant`), drafted and elaborating in `data/fs131/mb/scratch/` but for one line: about 100 lines for the four leaves
and 330 for the helpers every later leaf of `stuckModel` reads (the arcs of a square by coordinates, the tangent arcs as the unit
circles about the poles inside `B(v, 1/10)`, the three pieces in coordinates). **`stuckModel` without `stuckModel_terminal` re-prices
to about 900–1,000 lines**, inside the plan's 950–1,300 for the same leaves. `shadowModel` and `awayModel` are not re-priced: neither is
begun.

## Stage 3 — SAVED (FS131-MB1): `stuckModel` — the thirteen leaves of `stuckModel_hyps` proved; `Valid` on the standard three, `IsStuck` through one leaf of `Paint`

*2026-10-06 09:33 UTC.* Every leaf of `stuckModel` but `stuckModel_terminal` (the plan places it after wave 5: § 3.8) is proved. `Stuck.lean` went from
202 to 1,430 lines: 321 lines in the thirteen leaves and 836 in 58 helpers (new declarations, each named `stuckModel_…` or
`stuckModelPiece…`; 97 names in the file, none declared in any other worktree's `Proofs/` outside the planner's own copy of the skeleton).

### 3.1 The leaves, and the route each took

| leaf | route | lines |
|---|---|---|
| `stuckArcs_nondegenerate`, `stuckArcs_finite` | explicit lists; the squares' corners rewritten as pairs of coordinates (`stuckModel_corners`) | 19, 6 |
| `frontier_stuckW_subset` | `frontier_union_subset` twice; the frontier of an open square is its closure off itself, hence on a side (`stuckModel_mem_poleSqArcs_iff`); the circle by `stuckModel_carrier_circ` (a full circle at any radius: the library's `carrier_circ_full` is radius `1`) | 28 |
| `stuckCol_locallyConstant` | by piece; each strict comparison in `stuckCol` is locally constant where its two sides differ (`stuckModel_eventually_lt_iff`), which off the arcs they do: near the vertex `dist · N ≠ 1`, `dist · S′ ≠ 1` (`stuckModel_mem_arcs_ball_iff`), in a square `|a| ≠ |b|` (`stuckModel_mem_arcs_sq_iff`) | 43 |
| `stuckModel_valid` | `paint_valid`; `hWc` empty (`brickBase_region_spare`, `stuckModel_stuckCol_spare`); `hWW` is `stuckModel_no_unit_pair`: nine pairs of pieces, the four that matter being E7 § 7.2's inequalities as four real lemmas (`stuckModel_near_real`, `_near_real'`, `_far_real`, `_far_real'`), each a linear combination of five or three named products | 8 (+ 170) |
| `stuckModel_coloursAt`, `_hasSectors`, `_isHorn`, `_flanks` | the plan's translation: `stuckModelPiece r i = (· + plantPt) '' cuspPiece r i`, the partition `stuckModel_partition` from `cuspFrag_partition`, the pieces' data from `cuspPiece_data` through the translation; **the sector count of every colour** (`stuckModel_sectorsOf_encard`, by `encard_sectorsOf_of_partition`) | 24, 19, 13, 21 |
| `stuckModel_contacts` | the class of a painted colour is its painted set off the new arcs (`stuckModel_region_subset`, `stuckModel_mem_region_of`); the four wedges lie in their classes (`stuckModel_wedges`) and inside or outside the unit disc about the vertex (`stuckModel_wedge_dist`); a tile with a pole in its closure lies in that pole's square (`stuckModel_tile_subset_sq`: the three pieces are separated open sets) | 53 |
| `stuckModel_not_mergeAvailable` | only `9` has two sectors (`stuckModel_hasSectors_two`); its cone lies in the line `im d = 0` by the two out-type contacts | 18 |
| `stuckModel_not_rayAvailable` | `stuckModel_horn_cases` — **the plan's route, not the bowtie's**: a horn set that is a sector at the vertex is a piece; the two lens pieces are no horn sets (`ne_hornSet_of_interior_coneAt`: each approaches the vertex along the directions within `1/2` of `±π/2`); a horn piece fixes `e α` (`e_eq_of_mem_coneAt_hornSet`) and the curvatures `(−1, 1)` (`hornSet_curv_eq`). Two horns on one ray would have `κ₂ = 1 < −1 = κ₃` | 10 (+ 75) |
| `stuckModel_not_shaveAvailable` | the horn is fixed as above; each flank colour is `7` or `8`; **every horn point within `1/20` of the vertex is at distance exactly `1` from a point of `7`'s class and from one of `8`'s** (`stuckModel_shadow`) | 59 (+ 55) |

**One change of route, said as the brief asks.** `stuckModel_shadow`'s witness is the point at distance `1` from `z` **toward the pole**
(`z + (N − z)/|z − N|`), where E7 § 7.3 and the plan take the point on the pole's axis (`N − iβ`, `β = 1 − √(1 − x²) − y`). The radial
point is `(1 − 1/d)(z − N)` from `N`, `d = |z − N|`: inside the square because its norm is `d − 1 < 1/20`, inside the wedge toward the
vertex because `z − N` is. No square root. The statement proved is the leaf's own; the radius is `1/20` where the plan says `1/50`.

**What was not hard, against the plan's list** (§ 3.7 names `stuckModel_valid` and `stuckModel_shadow` as carrying real geometry): both
went in one pass each once stated in real variables with their products named (`LEAN.md`: `nlinarith` wants its own context).

### 3.2 The build, the receipt, the checks

**The build**: `data/fs131/mb/build-2.log` — `build: OK — 452 of 452 batches, 2 module(s) rebuilt, 4 module(s) with warnings, 8m18s`, exit
0; the full log (`build-2-full.log`): **0 warnings other than `sorry`**; distinct `sorry` warnings **43** — `Paint` 13, `Moves` 18, `Stuck`
**8** (was 21), `Bends` 4.

**The receipt** (`data/fs131/mb/MBAxioms-stage3.out`, read by `tools/fs131_mb_receipt.py` → `receipt-stage3.out`, exit 0, 32 records,
0 findings):

- **on exactly the standard three** (no `sorry`-proved declaration in the closure): `stuckModel_valid`, `stuckModel_no_unit_pair`,
  `stuckArcs_nondegenerate`, `stuckArcs_finite`, `frontier_stuckW_subset`, `stuckCol_locallyConstant`, and the cusp group's five;
- **`sorryAx` through `Plane.Models.Paint:brickBase_mem_interiorPts` and nothing else** (`SORRY-VIA-PAINT-ONLY`, one leaf named):
  `stuckModel_hyps`, `stuckModel_isStuck`, `stuckModel_coloursAt`, `_hasSectors`, `_isHorn`, `_flanks`, `_contacts`,
  `_not_mergeAvailable`, `_not_rayAvailable`, `_not_shaveAvailable`, and the helpers `stuckModel_partition`, `_horn_cases`, `_shadow`.
  That leaf — "a point strictly inside a brick is an interior point of the base" — is implementer A's; when A's branch joins, these read
  the standard three, and until then **`stuckModel_hyps` is not a theorem on this branch**;
- **open** (`SORRY-IN-OWN-FILES`, each naming its own leaves): `stuckModel_terminal`, `shadowModel`'s five records, `awayModel`'s two.

**Controls, each watched to fire** (`receipt-selftest.out`: `4 of 4 plants fired; faithful run 0 finding(s) -> OK`): a whole record
given `sorryAx`; a through-`Paint` record given a leaf in `Stuck`; an open record marked `STANDARD-THREE`; the wrong pairing
`cuspFrag_bend_away <- ArcMap.bend_toward` marked `APPLIED`. The open records are the receipt tool's own standing control: eight read
`SORRY-IN-OWN-FILES`.

**The statement check**: `statements.out` — 53 skeleton declarations, 0 not found verbatim once; no path outside this job's differs
from `fe9d6d32`. `tools/check_architecture.py`: exit 0, `RESULT: PASS`. `scripts/Axioms.lean`: fifteen records of the stuck vertex added
to the block "FS131-MB1".

### 3.3 The statement read against the claim

`stuckModel_hyps : stuckModel.Valid ∧ stuckModel.IsPlaneMap ∧ stuckModel.Covers plantPt 1 ∧ stuckModel.IsStuck plantPt`, with
`IsStuck v = ¬ MergeAvailable v ∧ ¬ RayAvailable v ∧ ¬ ShaveAvailable v ∧ ∃ c n, 2 ≤ n ∧ HasSectors v c n`. Read against FS131-E7's
`q5-terminal-stuck-model` ("for `k = 12`, `F` the map `P₅` … and `v = 2/5 + (3/10) i`: `F.Valid`, `F.IsPlaneMap`, `F.Terminal` and
`F.IsStuck v`"): the same object with squares for discs at the poles (the planner's variation, § 2.3 (2)), the same vertex, three of its
four conjuncts; `F.Terminal` is `stuckModel_terminal`, open. **Each negative clause is met with its positive part live**, so none holds
for want of an object: `9` has two sectors (`stuckModel_hasSectors`) and its cone fails only by having no interior
(`stuckModel_contacts`: two out-type contacts); two horns of `9` exist, on different rays (`stuckModel_isHorn`); each horn has both flanks
(`stuckModel_flanks`) and fails only the clear split (`stuckModel_shadow`).

## Stage 4 — SAVED (FS131-MB1): the close of this session — what is left and its route, the drafts, slips

*2026-10-06 09:35 UTC.* I stop here, at a saved stage, on the budget line (standing rules 1 and 12): two models whole (the cusp arc; the stuck
vertex but for `stuckModel_terminal`), two not begun. Nothing is half done. `data/fs131/mb/scratch/StuckScratch.lean` (the working copy
of `Stuck.lean` while builds ran) is removed in this commit: it was the file itself.

### 4.1 What is left, and its route

| what | leaves | route, and what this job leaves for it |
|---|---|---|
| `stuckModel_terminal` | 1 (H) | after wave 5, as the plan's § 3.8 has it. At the vertex: `stuckModel_not_mergeAvailable`, `_not_rayAvailable`, `_not_shaveAvailable`. On the three painted pieces `Γ` is known pointwise: `stuckModel_mem_arcs_ball_iff` (the two unit circles), `stuckModel_mem_arcs_sq_iff` (the diagonals), `stuckModel_arcs_union`; the classes by `stuckModel_region_subset` / `stuckModel_mem_region_of`; the painting by `stuckModel_stuckCol_ball`, `_sqN`, `_sqS`. Off the pieces: `BrickMap`'s sector and horn lemmas through locality |
| `shadowModel` | 7: `shadowArcs_nondegenerate`, `frontier_shadowW_subset`, `shadowCol_locallyConstant`, `shadowModel_condition5`, `shadowModel_flanks` (S each), `shadowModel_valid` (M), `shadowModel_doublyShadowed` (H) | not begun; the plan's § 3.5 routes stand, unread against proofs. It reads four of `Paint`'s open leaves (`hornArcs_nondegenerate`, `frontier_hornSet_subset`, `hornArcs_carrier_subset`, `brickBase_mem_interiorPts`). Reusable as they stand: `stuckModel_plant_coords`, `stuckModel_dist_sq`, `stuckModel_abs_coords_le`, `stuckModel_frames`, `stuckModel_poles`, `stuckModel_eventually_lt_iff`, `stuckModel_radial`; the same three bricks hold its pieces, so `stuckModel_stuckW_subset`'s three calls of `brickBase_mem_interiorPts` are its pattern, and `stuckModel_region_subset` the pattern of its class lemma. FS131-E7 § 6 was not read by me |
| `awayModel` | 4: `awayArcs_nondegenerate` (S), `frontier_awayW_subset` (M), `awayModel_hyps` (H), `awayModel_r2Contacts` (M) | not begun; KA1's plan § 5 and the plan's § 3.5 |
| ruling 461 (c): a plane-map model of `bend_away_whole`; the plan's `awayModel_bend_toward` | new declarations | **not on `awayModel`'s whole arc** — see § 4.2 |

### 4.2 A note on ruling 461 (c), for whoever builds it

`bend_away_whole` asks `hR2 : Disjoint (radiusTwoArc P θ₁ θ₂) (closure (F.region c))`. On `awayModel`'s arc as `awayModel_hyps` states
it (`[−arcsin(3/10), arcsin(3/10)]`, inner colour `7`) that fails by the skeleton's own leaf: `awayModel_r2Contacts` says the radius-2
contacts are `[−arcsin(3/20), arcsin(3/20)]`, not empty — the object was designed for `bend_away_part`. A model of `bend_away_whole` on
`awayModel` is therefore **a sub-arc inside one of the two gaps**, e.g. `[1/5, 3/10]` (`arcsin(3/20) < 1/5` and `3/10 < arcsin(3/10)`):
there `P + 2 e θ` has height `3/10 + 2 sin θ > 3/5`, above the brick that holds the outer piece. It needs the ring arc restricted to
the sub-arc (no `IsRingArc` restriction lemma is in the library by that name: `rg "theorem IsRingArc\."` lists five, none of them; it
is three lines from the definition) and `hR2` there. Read, not built: one mind, no proof.

### 4.3 Slips, my own

- The first draft of `tools/fs131_mb_receipt.py` split the receipt's messages on a `file:line:col:` prefix the output does not carry,
  parsed nothing, and its faithful run reported 36 findings while all four plants "fired". Caught by the self-test's own second half
  (the faithful run must pass beside the plants): without that pair it would have read as four working controls. Repaired before any
  number from it was recorded.
- Its first expectation table put `frontier_stuckW_subset`, `stuckCol_locallyConstant` and `stuckModel_valid` among the records resting
  on `Paint`; measured, they are on the standard three. The table now states what was measured, which makes it a regression check
  and no longer a prediction; the prediction it replaced was wrong in the direction that undersold the work.
- A `rw [← hsq]` with `hsq : … = 1` rewrote every `1` of the goal; found at the first elaboration, proof restated.

## Drafts for the front page

*Each names its slot. This job ran no gate (the brief keeps it for the landing) and its branch carries `sorry` — `Paint`'s and `Moves`'
leaves, and twelve of its own files' — so it files no count.*

1. **`CLAUDE.md` § The gate, § Trust ledger — the counts**: no draft. The counts move when the lane lands on `main`; the landing job
   reads them from its own gate run.
2. **Ledger rows regraded to [kernel]**: none. The models are inhabitants owed by `LEAN.md` § The gate's inhabitant bullet, not ledger
   rows.
3. **The docstring lines the models earn** (the plan's § 3.10; applied by whoever lands the lane, none applied here). Read against
   what is now proved:
   - the seventeen notes of QA4-2 and `cv_l0`'s — slot and text as the plan's § 3.10 rows 8–9 have them, with one addition after
     "`stuckModel_isHorn`, `_flanks`, `_contacts`": "; `stuckModel_hasSectors` and `stuckModel_coloursAt` for the sector counts and
     the colours". **To be applied only when `stuckModel_hyps` reads the standard three**, that is after implementer A's
     `brickBase_mem_interiorPts` lands; `cv_l0`'s line names `stuckModel_terminal`, which is open.
   - `bend_away_whole`, `bend_toward` (`UnitArc`) — slot: the end of each docstring. Text, the plan's with its second sentence held
     back: "**Inhabitant**: `cuspFrag`'s arc of `ω(i)` (`Plane/Models/Bends`, `cuspFrag_bend_away` / `cuspFrag_bend_toward`); its
     centre is off the fragment and carries no colour — a model of the hypotheses' letter." The sentence "On a map of the plane:
     `awayModel` …" waits for `awayModel`.
4. **The Frontier line, the Proof Atlas**: no change — no result's grade moved.
5. **`LEAN.md` § The gate** (a draft for Keryx, to follow the `dupnames.sh` bullet's last sentence, if wanted): "A branch that holds a
   sibling branch's leaves open reads its own records with `#mb_receipt` (`data/fs131/mb/MBAxioms.lean`): beside the axioms it lists
   the `sorry`-proved declarations of the record's dependency closure by module, so 'rests on `sorryAx` through the sibling's file
   alone' is read off the term and not asserted."

## Theorems this phase proved, at the last saved stage

All in the worktree's build of `fs131-wmb` at `16a8082e`'s Lean source (`data/fs131/mb/build-2.log`, exit 0); axioms as stored in the
built `.olean`s and printed by `lake env lean data/fs131/mb/MBAxioms.lean` (`MBAxioms-stage3.out`) — the gate's audit
(`scripts/axioms.sh`) was not run.

**[kernel], on exactly `[propext, Classical.choice, Quot.sound]`:**

- `HadwigerNelson.Plane.cuspFrag_bend_away`, `cuspFrag_bend_toward` (`Plane/Models/Bends`) — `ArcMap.bend_away_whole` and
  `ArcMap.bend_toward` applied to the cusp fragment's arc of `ω(i)` over `[−π/2 + 1/10, −π/2 + 2/5]`; with their leaves
  `cuspFrag_isRingArc`, `cuspFrag_coloursAt_I`, `cuspFrag_radiusTwo_disjoint` and helpers `cuspArc_sin`, `cuspArc_pt`, `cuspArc_mem`,
  `cuspFrag_closure_region_subset`.
- `HadwigerNelson.Plane.stuckModel_valid` (`Plane/Models/Stuck`) — the twelve-colour planted bowtie is valid; with
  `stuckModel_no_unit_pair`, the four real lemmas `stuckModel_near_real`, `_near_real'`, `_far_real`, `_far_real'`, and the
  structural leaves `stuckArcs_nondegenerate`, `stuckArcs_finite`, `frontier_stuckW_subset`, `stuckCol_locallyConstant` (so the
  definition `stuckModel` itself is free of `sorry`).

**Proved from one open leaf of implementer A's** (`Plane.Models.Paint:brickBase_mem_interiorPts`; each rests on `sorryAx` through it
and through nothing else — not theorems until it lands): `stuckModel_hyps`, `stuckModel_isStuck`, `stuckModel_coloursAt`,
`stuckModel_hasSectors`, `stuckModel_isHorn`, `stuckModel_flanks`, `stuckModel_contacts`, `stuckModel_not_mergeAvailable`,
`stuckModel_not_rayAvailable`, `stuckModel_not_shaveAvailable`, with `stuckModel_partition`, `stuckModel_horn_cases`,
`stuckModel_shadow`, `stuckModel_sectorsOf_encard` and the rest of the helpers that read the partition at the vertex.

**Open in this job's files** (12 `sorry`): `stuckModel_terminal`; `shadowModel`'s seven; `awayModel`'s four.

---

# FS131-MB2 — MB1's successor: `shadowModel` and `awayModel` (de Bruijn, the implementer)

*Brief: `data/fs131/briefs/FS131-MB2-models-shadow.md` (on `main`). Same branch and worktree, from MB1's tip `b7fbe6f9`. Started 2026-10-06
09:37 UTC. Stages continue MB1's numbering. What this job proved is listed in the section "Theorems this phase proved (FS131-MB2), at the
last saved stage" at the end of this file.*

## Stage 5 — SAVED (FS131-MB2): the readback

### 5.1 The brief's quotations (standing rule 3)

`tools/fs131_mb2_quotes.py` (MB1's reader pointed at this job's brief) — output `data/fs131/mb2/quotes.out`: **9 quotations, 9 found
verbatim, each once; none missing**, exit 0. `--self-test`: `9 of 9 planted quotations reported missing; faithful run 0 missing -> OK`,
exit 0.

### 5.2 What was read, and how far

| file | read |
|---|---|
| the brief; `plans/STANDING-RULES.md`; `LEAN.md` (main checkout) | whole |
| `RUNNING.md` § Building, § Make the gate fail, and watch it fail | § Building whole; the second to its l. 275 |
| this record, MB1's Stages 1–4 | whole |
| `plans/FS131-models-kernel-plan.md` (FS131-KM1) | whole |
| `plans/FS131-close-inventory.md` | items 470, 471 whole; 460, 461 by their heads (the brief's quotations) |
| `plans/FS131-E7-derivation.md` (main checkout) | § 6 whole (l. 532–626) |
| `plans/FS131-bendaway-kernel-plan.md` (`fs131-w5a`) | § 5 whole (l. 442–466) |
| `Plane/Models/Paint`, `Bends` | whole |
| `Plane/Models/Stuck` | l. 1–130, the declarations' heads (all), `shadowModel`'s section whole; MB1's helpers as each is used |
| `Plane/ArcMap`, `Plane/ValidMap/Basic` l. 1–300 | whole |
| `Plane/ValidMap/Surgery` | `germArc`, `carrier_germArc` |
| `Plane/LocalMap` | the ring-arc definitions (l. 240–262) |
| `Plane/ValidMap/Contact` | `flank_ne_of_doublyShadowed`'s statement |

### 5.3 The build as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` in the worktree: `build: OK — all 1771 modules already up
to date, nothing built, 4 module(s) with warnings, 2s`, exit 0 (`data/fs131/mb2/build-0.log`; the full log `build-0-full.log`). Warnings:
43 distinct, **all** `declaration uses 'sorry'` (0 others) — `Paint` 13, `Moves` 18 (the other half's 31), `Stuck` 8, `Bends` 4. As the
brief says.

### 5.4 What I may and may not change

**Mine**: the proofs of the eleven `sorry` leaves of `shadowModel` (7, in `Stuck.lean`) and `awayModel` (4, in `Bends.lean`); new helper
declarations in those two files, named `shadowModel_…` and `awayModel_…`; a block "FS131-MB2" in `scripts/Axioms.lean`; this record;
`tools/fs131_mb2_*.py`; `data/fs131/mb2/`; the report.

**Not mine**: any statement or definition of the skeleton or of MB1 (`shadowWg`, `shadowWh`, `shadowArcs`, `shadowCol`, `shadowModel`,
`awayP`, `awayW`, `awayArcs`, `awayModel` among them); `stuckModel_terminal` and the plane-map model of `bend_away_whole` (after wave 5:
the brief's Done means 3); `Plane/Models/Paint.lean` and `Moves.lean` (the other half's — I read `Paint`'s open leaves by their
statements); every landed module; `main`; the gate; MB1's tools (`tools/fs131_mb_*.py`: another job's). No new `axiom`, no
`native_decide`.

### 5.5 Tools, each with a planted fault watched to fire

- `tools/fs131_mb2_quotes.py` — § 5.1.
- `tools/fs131_mb2_statements.py` — **the statement check**, against two bases: every declaration of `Stuck` and `Bends` at MB1's tip
  `b7fbe6f9` (115: the skeleton with MB1's helpers; a theorem by its head through the first `:=`, a definition whole) and every
  declaration of the skeleton at `fe9d6d32` (53) occurs verbatim, once, in the working file; and no path differs from `b7fbe6f9` outside
  this job's paths. Output `data/fs131/mb2/statements.out`: 0 and 0 not found, 0 forbidden paths, exit 0. `--self-test` changes one
  character of each of the 115 heads in turn: `115 of 115 planted head changes reported; faithful run 0 missing -> OK`.
- The receipt (`data/fs131/mb2/MB2Axioms.lean`, read by `tools/fs131_mb2_receipt.py`) is written at the first model's save (Stage 6).
