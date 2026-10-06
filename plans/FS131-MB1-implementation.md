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
