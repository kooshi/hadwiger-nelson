# FS131-CC1 — lane C of the collar bend (de Bruijn, the implementer)

*Job FS131-CC1, de Bruijn (Opus 5.5), launched 2026-10-05 on branch `fs131-w5k`, cut from `fs131-w5` at `2736ab8c` (CG1's move commit;
worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5k`). Brief `data/fs131/briefs/FS131-CC1-collar.md` (on `main`), with
`plans/STANDING-RULES.md`, `LEAN.md` and `RUNNING.md` § Building and § Make the gate fail. No fence (inventory ruling 1). Working files
`data/fs131/cc/`; tools `tools/fs131_cc_*.py`. The planner's record is `fs131-w5`'s `plans/FS131-collar-kernel-plan.md` (KP2, with lane G's
stages from 7 on); this file is lane C's.*

## Theorems this phase proved

Each [kernel], on exactly `[propext, Classical.choice, Quot.sound]` (stage 2: `data/fs131/cc/CCAxioms2.out`).
- `Plane/ValidMap/Pushforward`, KP2's seven children: `ArcMap.pushforward_locallyConstant`, `ArcMap.pushforward_interiorPts`,
  `ArcMap.pushforward_region`, `ArcMap.pushforward_coloursAt`, `ArcMap.hasDegree_iff_of_agree`, `ArcMap.hasDegree_iff_of_charts`,
  `ArcMap.hasDegree_iff_of_mem_interiorPts` (and with them KP2's `pushforward_Γ`, `pushforward_mem_interiorPts_iff`,
  `pushforward_col_apply`, now off `sorryAx`).
- `Plane/ValidMap/Pushforward`, new: `ArcMap.HasDegree.unique`, `ArcMap.HasDegree.iff_eq`, `ArcMap.IsSectorChart.not_hasRepeatedColour_of_zero`,
  `ArcMap.IsSectorChart.hasRepeatedColour_iff`, `ArcMap.curveAt_one_sub_eq_sphere`, `ArcMap.branchPt_congr`, `ArcMap.circleGerms_nextβ_zero`,
  `…_nextβ_one`, `…_nextκ_zero`, `…_nextκ_one`, `ArcMap.circleGerms_mem_sector_zero`, `…_one`, **`ArcMap.isSectorChart_circle`**,
  `ArcMap.exists_two_le_encard_fin_two_iff`, **`ArcMap.degree_of_circle`**, `ArcMap.exists_sphere_inter_ball_subset_openArc`.
- `Plane/ValidMap/BendCollar`: **`ArcMap.CollarFit.degree_openArc`**; and (stage 3, `data/fs131/cc/CCAxioms3.out`)
  `ArcMap.isCompact_polarSet_Icc`, `ArcMap.ringPt_not_mem_openArc_of_end`, `ArcMap.mem_closure_region_inter_iff_of_agree`.
- Proved with no `sorry` of their own, resting on open children (lane G's statements, lane C's four open leaves), so on `sorryAx` until
  those land (stage 3): `CollarFit.map_R1`, `map_R2`, `map_R3`, `map_inert`, `coloursAt_subset`, `side_ne_inner_of_mem_lens`,
  `map_ringArcsWithin`, `map_hasDegree`, `map_hasRepeatedColour`, and the helpers `CollarFit.sides_eq`, `map_degree_and_repeated`,
  `lensProf_le_one`, `isClosed_closedLens`, `isClosed_collarK`, `lens_subset_closedLens`. Not kernel theorems yet.

## Stage 1 — SAVED (FS131-CC1): the readback, the as-given build, and what this job may change

### 1.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_cc_quotes.py` reads each quotation from the brief itself on `main` (the `> ` line above each `> — source:` line) and requires it
verbatim in the source the brief names: KP2's plan on `fs131-w5` at `2736ab8c` and at `fs131-w5`'s head (both), `CLAUDE.md` and the inventory
on `main`. Result `data/fs131/cc/quotes.txt`: **PASS, 9 of 9 verbatim**. `--self-test` (`data/fs131/cc/quotes-selftest.txt`): one changed
character in each quotation in turn, and one quotation pointed at a source that does not hold it — **10 of 10 plants fired**, the unplanted
partner PASS.

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "Do not consider Lean formalization a cost. …" | `CLAUDE.md` § Counter-priors | verbatim |
| 2–4 | lane C's row of § 5.2, C's order, "Interfaces" | KP2's plan § 5.2 at `2736ab8c` and at `fs131-w5`'s head | verbatim |
| 5–9 | items 394, 395, 396, 390, 378 (first lines) | `plans/FS131-close-inventory.md` on `main` | verbatim |

No mismatch.

Read in full: KP2's plan (Stages 1–6, with lane G's Stages 7–8), KB2's design (`plans/FS131-I5-implementation.md` § 44), `Pushforward.lean`,
`BendCollar.lean`, `CollarMap.lean`, `RadialPush.lean`, and the chart machinery they cite (`LocalStructure` § The sector structure,
`ValidMap/Sectors`, `ValidMap/Surgery`'s germ arcs and sector counts).

### 1.2 The as-given build (`2736ab8c`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` at `2736ab8c`: **OK — 455 of 455 batches, 9 modules rebuilt
(`Pushforward`, `RadialPush`, `CollarMap`, `BendCollar`, `Terminal`, `Dense`, `BaseWalk`, `BaseDense`, `Proofs` — the tree's `.lake/build` was
copied from `fs131-w5c`), 7 with warnings, every warning `declaration uses 'sorry'`**, exit 0, 9 min 3 s (`build/gate/build/20261005T120300Z-4055015.log`,
which ends "Build completed successfully (5791 jobs)"; driver log `data/fs131/cc/build-asgiven.log`). `sorry` declarations in lane C's files:
`Pushforward` 7, `BendCollar` 14 (the fourteen of KP2's C row; `bend_toward_collar` none of its own).

### 1.3 What this job may change, and what it may not

**May change**: `Proofs/HadwigerNelson/Plane/ValidMap/Pushforward.lean` (proofs of its seven children, and new supporting declarations);
in `Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean` the proofs of lane C's fourteen declarations (`exists_collarFit`, `degree_openArc`,
`map_degree_lensCurve`, `map_degree_end`, `map_hasDegree`, `map_hasRepeatedColour`, `map_ringArcsWithin`, `sides_end`, `map_R1`, `map_R2`,
`map_R3`, `coloursAt_subset`, `side_ne_inner_of_mem_lens`, `map_inert`) and new children beside them; the new child B0 `collarModel` (with its
statement, which is this lane's to write: plan § 4); `scripts/Axioms.lean` (a block of my own, headed "FS131-CC1", above the
`=== PURCHASED ===` banner); this record; `tools/fs131_cc_*.py`; `data/fs131/cc/`; `data/fs131/reports/FS131-CC1.md`.

**May not change**: any statement in the skeleton — a hypothesis, a conclusion, a docstring, a definition the statements use — and no new
`axiom`, no `native_decide`; `RadialPush.lean` and `CollarMap.lean` (lane G's), `BaseDense`, `HexRing`, `BaseWalk`, `Proofs.lean` and
`ARCHITECTURE.md` (unless I add a module). A lane-G statement I need changed is a message to the coordinator. No merge into `fs131-w5`, no
`main` taken in, no gate run, nothing on `main`.

## Stage 1 — SAVED (FS131-CC1)

## Stage 2 — SAVED (FS131-CC1): `Pushforward` proved, a generic two-germ chart on a circle, `degree_openArc` proved; the re-price

### 2.1 What was proved

**`Plane/ValidMap/Pushforward`, all seven children** (statements unchanged): `pushforward_locallyConstant` (a domain point off the new arcs
pulls back to an interior point of `F`; `F.locallyConstant` there, composed with `h⁻¹`'s continuity), `pushforward_interiorPts`
(`image_sdiff` with `hdom`, `hΓ`), `pushforward_region` (`image_inter`), `pushforward_coloursAt` (`Homeomorph.image_closure`),
`hasDegree_iff_of_agree` (on `(0, r₀]` the two maps have the same sectors and the same sector colours), `hasDegree_iff_of_charts` (both
degrees `max n 1`; with no germ no repeated colour on either side, otherwise both read the colour word), `hasDegree_iff_of_mem_interiorPts`
(`localSectors` at an interior point has no germ). So `pushforward`, `pushforward_Γ`, `pushforward_mem_interiorPts_iff`,
`pushforward_col_apply` and `CollarFit.pushProfiles` no longer rest on a `sorry`.

New supporting declarations in `Pushforward` (each with its route in its docstring):
- `HasDegree.unique`, `HasDegree.iff_eq` — a degree is unique (two eventual counts agree);
- `IsSectorChart.not_hasRepeatedColour_of_zero`, `IsSectorChart.hasRepeatedColour_iff` — a chart's repeated colour is its colour word's
  (the two halves `hasDegree_iff_of_charts` derives from);
- **the two-germ chart on a circle**: `circleGerms φ ρ` (a `def`, with a spec `example`), `circleGerms_nextβ_*`, `circleGerms_nextκ_*`,
  `circleGerms_mem_sector_zero`/`_one` (the outward ray in sector `0`, the inward ray in sector `1`), `curveAt_one_sub_eq_sphere`,
  `branchPt_congr`, and **`isSectorChart_circle`**: if near `v = q + ρ e(φ)` the arcs are the circle about `q` of radius `ρ`, then
  `circleGerms φ ρ` is a sector chart at `v` (out to any radius below `2ρ` in the domain) — through `isSectorChart_of`, the branches by
  `exists_eq_branchPt_curveGerm`/`branchPt_curveGerm_mem`;
- `exists_two_le_encard_fin_two_iff`, and **`degree_of_circle`**: at such a point the degree is `2`, and a colour repeats exactly when the
  colour reaching `v` from inside the circle is the one reaching it from outside;
- `exists_sphere_inter_ball_subset_openArc` — points of `ω(p)` near an interior point of an arc lie on the open arc (the local angle is
  continuous: `eq_polar_local`, `continuousAt_arg_div`). A near-copy of `FlankUA`'s `sphere_near_mem_ringArc`, which is downstream of
  `BendCollar` and so not citable here (a tidy move for the coordinator: inventory item 387 (a)'s list).

**`CollarFit.degree_openArc`** (`BendCollar`): `degree_of_circle` at `ringPt P θ` with `q = P`, `ρ = 1`, `φ = θ`; near the point `Γ` is
`ω(P)` (`free_open` one way, `exists_sphere_inter_ball_subset_openArc` and `ring` the other); the colours from inside and outside are `c`
and `c'` (`ring`'s sides). 25 lines.

### 2.2 The re-price (`LEAN.md`: from the first two leaves)

KP2 priced `Pushforward` at about 300 lines and `degree_openArc` at 150. Spent: about 120 lines for `Pushforward`'s seven children, 230
for the generic circle chart (`isSectorChart_circle`, `degree_of_circle` and their helpers), 25 for `degree_openArc` — 375 against 450.
On price, not below it: the chart pattern KP2 named had to be built once, generically, and it now serves `map_degree_lensCurve` off the
crossing (`C_A`, `C_B` are circles of radius `R`) as it served `degree_openArc`. Re-priced remainder of lane C, in lines:

| child | KP2 | now | why |
|---|---|---|---|
| `map_degree_lensCurve` | 200 | 300 | off `X` the circle chart applies once `M.Γ` near the point is identified with `C_A` (or `C_B`): `M.Γ = h(F.Γ)` near it (`pushforward_Γ`, `h` open), `h(α°) ⊆ lensCurve`, and the lens curve near the point is one circle (`tangRad_spec`, the max of the two profiles attained by one term, uniqueness of the positive root); at `X` a second two-germ chart, of two circles crossing |
| `exists_collarFit` | 450 | 450 | unchanged; C4 the hard leaf |
| `map_degree_end` | 350 | 350 | unchanged |
| `sides_end` | 200 | 200 | unchanged |
| `map_hasDegree`, `map_hasRepeatedColour` | 120 | 150 | the off-collar case needs `collarK` closed: `isCompact_polarSet_Icc` (stage 3) |
| `map_R1`, `map_R2` | 240 | 250 | the R1 arc lies in `F.Γ` by finiteness against the two radius-`R` arcs (`ringArc_subset_Γ_of_finite`), not by `map_ringArcsWithin`, whose statement gives each point's own sub-arc only |
| `coloursAt_subset`, `side_ne_inner_of_mem_lens`, `map_inert`, `map_ringArcsWithin`, `map_R3` | 200 | 200 | stage 3 |
| B0 `collarModel` | 150 | 150 | unchanged |

### 2.3 The build, the axioms, the statements

**Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 455 of 455 batches, 5 modules rebuilt (`Pushforward`, `CollarMap`, `BendCollar`,
`BaseDense`, `Proofs`), 6 with warnings, every warning `declaration uses 'sorry'`**, exit 0, 8 min 50 s
(`build/gate/build/20261005T121738Z-4138672.log`, which ends "Build completed successfully (5791 jobs)"; driver log
`data/fs131/cc/build-stage2.log`). `Pushforward`: no `sorry`. `BendCollar`: 13 `sorry` declarations (lane C's fourteen less
`degree_openArc`).

**Axioms** against that build's oleans (`data/fs131/cc/CCAxioms2.lean` → `.out`): the 27 theorems above (`Pushforward`'s seven, the three
proved in KP2's skeleton that rested on `pushforward`'s field, the sixteen supporting lemmas, `degree_openArc`) each on exactly `[propext,
Classical.choice, Quot.sound]`; controls `CollarFit.map_degree_lensCurve` and `bend_toward_collar` on `sorryAx` (the control fires).
`scripts/Axioms.lean`: a block headed "FS131-CC1" above the `=== PURCHASED ===` banner, the sixteen new supporting theorems (the skeleton's
children were already listed by KP2's block).

**Statements**: `tools/fs131_cc_stmt.py` (new) — `RadialPush` and `CollarMap` byte-identical to `2736ab8c`, every skeleton declaration of
`Pushforward` and `BendCollar` once in its file with its statement byte-identical (docstring and header to `:=`; a definition's whole
text; spec examples), `bend_toward_collar`'s whole text unchanged, no other file under `Proofs/` changed, no `axiom`, no `native_decide`:
**PASS** (`data/fs131/cc/stmt-stage2.txt`, listing the seventeen new declarations). `--self-test` (`stmt-selftest.txt`): eleven plants —
a changed hypothesis, a changed docstring letter, a changed definition body, a changed spec example, an edit to `CollarMap`, a deleted
theorem, a duplicated theorem, an edit to the assembly, an edit outside the layout, an `axiom` line, a `native_decide` — **11 of 11
fired, each naming its culprit**; the unplanted partner PASS.

## Stage 2 — SAVED (FS131-CC1)

## Stage 3 — SAVED (FS131-CC1): R1, R2, R3, inert, the colours lost, the sides on the lens, no new unit arc, and the case split of the degree clauses

### 3.1 What was proved (`BendCollar`; statements unchanged)

Taken out of KP2's order, as the brief allows: the children that read only lane G's statements and the chart lemmas of stage 2 came first,
so that the hard leaves left (`exists_collarFit`'s C4, `map_degree_end`, `sides_end`, `map_degree_lensCurve`) are the only open ones.

- **`CollarFit.map_ringArcsWithin`** — `ringArcsWithin_of_Γ_subset` with the two collar arcs (radius `R ≠ 1`: `germArc_isUnitArc_iff`),
  `map_Γ` and `collarArcs_carrier`.
- **`CollarFit.map_R3`** — `α°` lies in `lensSet`, interior in the bent map (`map_lens`).
- **`CollarFit.coloursAt_subset`** — off the closed lens the maps agree near the point (the closed lens is closed); on its boundary
  the point is `h` of a point of `α°` or an end fixed by `h`, and `pushforward_coloursAt` carries `c` there; in `F` the closed lens holds no
  interior point of a colour other than `c` (`kin_subset`), so every other colour is kept.
- **`CollarFit.side_ne_inner_of_mem_lens`** — centred on `α°`: `lock` puts every interior point of the arc in two points, against the
  countable fibres of `ringPt` and the positive length of `(a, b)`; centred in the open lens: `Valid.dist_ne_one_of_isOpen_subset_closure`
  with the open class of `c`.
- **`CollarFit.map_inert`** — `map_R1`, then `coloursAt_subset` and `side_ne_inner_of_mem_lens`.
- **`CollarFit.map_R1`** — the closed arc lies in `F.Γ` by finiteness against the two radius-`R` arcs (`Arc.finite_inter_sphere_or_eq_circ`,
  `ringArc_subset_Γ_of_finite`; not through `map_ringArcsWithin`, whose statement gives each point its own sub-arc only); its sides: off the
  closed lens by locality, at an end by `sides_end` (`Q ≠ P`: an arc of `ω(P)` in the bent map's `Γ` through an end would run into `α°`).
- **`CollarFit.map_R2`** — no point of the closed arc is on `α°` (near one, `Γ` is `ω(P)` by `free_open` and its points there are on `α°`,
  which the open arc of `ω(Q)` then meets); the sides by `sides_eq`.
- **`CollarFit.map_hasDegree`, `CollarFit.map_hasRepeatedColour`** — both from one case split, `CollarFit.map_degree_and_repeated`: an
  interior point of `F` goes to one of the bent map (degree `1`, no repeated colour); off the closed collar `h` is the identity on a ball
  (`hasDegree_iff_of_agree`); on the collar a point of `Γ` is on `α` (`free`): on `α°` `degree_openArc` against `map_degree_lensCurve`, at an
  end `map_degree_end`.

New supporting declarations: `isCompact_polarSet_Icc` (a polar band over a closed angle interval is compact), `ringPt_not_mem_openArc_of_end`,
`CollarFit.lensProf_le_one`, `CollarFit.isClosed_closedLens`, `CollarFit.lens_subset_closedLens`, `CollarFit.isClosed_collarK`,
`mem_closure_region_inter_iff_of_agree` (closures are local), `CollarFit.sides_eq` (R1's and R2's common step), `CollarFit.map_degree_and_repeated`.

`hmax` is read by none of them (KP2's reading, inventory item 390, survives this stage's children).

### 3.2 What is left in lane C, with the route each is ready for

Four `sorry`s in `BendCollar` and the child B0, every other declaration of lane C proved over them and lane G's statements:

| child | state | route ready for a successor |
|---|---|---|
| `CollarFit.map_degree_lensCurve` | open | off the crossing `X`: `degree_of_circle` at `v = P + lensProf θ · e θ` with the circle `C_A` (or `C_B`). `M.Γ` near `v` is `h(F.Γ ∩ U)` for a small ball `U` about `ringPt P θ` (`pushforward_Γ`; `h(U)` is a neighbourhood of `v`), which is `h(α° ∩ U) ⊆ lensCurve`; the lens curve near `v` is `C_A`'s circle (`lensProf` is the `A` term on `[θ₁, θ_m]`: `tangRad R u` increases with `cos u`; `tangRad_spec` gives `⊆`; the converse by `eq_polar_local` and the uniqueness of the positive root, whose product with the other root is `1 − 2R < 0`). Colours: inside `C_A` near `v` the images of the inner collar (`kin_subset`, `pushforward_col_apply`) carry `c`; outside, the lens (`map_lens`) carries `c'`. At `X` a second two-germ chart, of two circles crossing (not yet built). About 300 lines. |
| `CollarFit.map_degree_end` | open | KP2's route (plan § 4): `F`'s chart at the end by `localSectors_disj`, `α`'s germ replaced by `C_A`'s (`isSectorChart_of`), the colour word kept, then `hasDegree_iff_of_charts` (proved). About 350 lines. |
| `CollarFit.sides_end` | open | KP2's route: the collar's horn at the end is preconnected (`isPreconnected_hornSet`) and misses `ω(Q)`, `Q ≠ P`. About 200 lines. |
| `exists_collarFit` | open | KP2's C1–C4 (plan § 4); C4 (end freeness) shares the end germ's identification with `map_degree_end`. About 450 lines. |
| B0 `collarModel` | not stated | plan § 4: a disc of diameter `< 1` about `r([0, π/6])`, the arcs `ω(0)` across it and the two radial segments at the ends, colours swapping across each, `c ≠ c'`; then `exists_collarFit` at it inhabits `CollarFit`. About 150 lines. |

### 3.3 The build, the axioms, the statements, and two notes

**Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 455 of 455 batches, 3 modules rebuilt (`BendCollar`, `BaseDense`, `Proofs`), 6 with
warnings, every warning `declaration uses 'sorry'`**, exit 0, 8 min 17 s (`build/gate/build/20261005T123523Z-79691.log`, which ends "Build
completed successfully (5791 jobs)"; driver log `data/fs131/cc/build-stage3.log`). `BendCollar`'s `sorry` declarations: four — lines 120
(`exists_collarFit`), 157 (`map_degree_lensCurve`), 168 (`map_degree_end`), 270 (`sides_end`).

**Axioms** against that build's oleans (`data/fs131/cc/CCAxioms3.lean` → `.out`): on exactly the standard three — `isCompact_polarSet_Icc`,
`ringPt_not_mem_openArc_of_end`, `mem_closure_region_inter_iff_of_agree`, `CollarFit.degree_openArc`. On `sorryAx`, as they must be while
their inputs are open — `CollarFit.lensProf_le_one`, `isClosed_closedLens`, `isClosed_collarK`, `lens_subset_closedLens` (through lane G's
`pushProfiles_collar`), `map_ringArcsWithin`, `map_R3`, `coloursAt_subset`, `side_ne_inner_of_mem_lens` (also lane G's map-level
children), `sides_eq`, `map_R1`, `map_R2`, `map_inert` (also `sides_end`), `map_degree_and_repeated`, `map_hasDegree`,
`map_hasRepeatedColour` (also `map_degree_lensCurve`, `map_degree_end`); controls `sides_end`, `bend_toward_collar` on `sorryAx`.
`scripts/Axioms.lean`: the nine new supporting theorems added to the "FS131-CC1" block.

**Statements**: `tools/fs131_cc_stmt.py`: **PASS** (`data/fs131/cc/stmt-stage3.txt`); its self-test re-run on this tree: 11 of 11 plants
fired, the partner PASS (`stmt-selftest3.txt`).

**Notes.** (1) A limit of my check, not of a statement: `fs131_cc_stmt.py` reads a theorem's statement up to `:= by`, so a term-mode proof of
an unchanged statement reads as a change (it did, for `map_hasDegree` and `map_hasRepeatedColour`). The two proofs are written `:= by exact …`;
the check was not loosened. (2) Lane G's `pushProfiles_collar` is the one leaf under nearly every map-level child of this lane; when lane G
proves it, `lensProf_le_one`, both closedness lemmas and `lens_subset_closedLens` come off `sorryAx` with no change here.

## Stage 3 — SAVED (FS131-CC1)

---

# FS131-CC2 — lane C of the collar bend, continued (de Bruijn, the implementer)

*Job FS131-CC2, de Bruijn (Opus 5.5), launched 2026-10-06 on branch `fs131-w5k` at `bc168474` (CC1's report commit; worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5k`). Brief `data/fs131/briefs/FS131-CC2-collar.md` (on `main`'s disk, untracked at
launch), with `plans/STANDING-RULES.md`, `LEAN.md` and `RUNNING.md` § Building and § Make the gate fail. No fence. Working files
`data/fs131/cc/`; tools `tools/fs131_cc_*.py`. Stages from 4 on are this job's.*

## Theorems this phase proved (FS131-CC2)

Filled at each saved stage below; the list as it stands is in the last saved stage's section.

## Stage 4 — SAVED (FS131-CC2): the readback, the as-given build, and what this job may change

### 4.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_cc_quotes2.py` (new; CC1's `fs131_cc_quotes.py` is left as it was) reads each quotation from the brief itself on `main`'s disk
(the `> ` line above each `> — source:` line) and requires it verbatim in the source the brief names: `BendCollar.lean` and CC1's record on
`fs131-w5k` at `bc168474`, KP2's plan on `fs131-w5` at `5059983d`, `CLAUDE.md` on `main`, the inventory from `main`'s disk and from `main`'s
head (both). Result `data/fs131/cc/quotes-cc2.txt`: **PASS, 13 of 13 verbatim**. `--self-test` (`data/fs131/cc/quotes-cc2-selftest.txt`): one
changed character in each quotation in turn, and one quotation pointed at a source that does not hold it — **14 of 14 plants fired**, the
unplanted partner PASS.

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "Do not consider Lean formalization a cost. …" | `CLAUDE.md` § Counter-priors | verbatim |
| 2–5 | the four open leaves' first lines (`map_degree_lensCurve`, `map_degree_end`, `sides_end`, `exists_collarFit`) | `BendCollar.lean` at `bc168474` | verbatim |
| 6 | "theorem bend_toward_collar (hF : F.Valid) {P : ℂ} …" | `BendCollar.lean` at `bc168474` | verbatim |
| 7 | "Four `sorry`s in `BendCollar` and the child B0, …" | CC1's record § 3.2 at `bc168474` | verbatim |
| 8 | lane C's row of § 5.2 | KP2's plan at `5059983d` | verbatim |
| 9–13 | items 405, 406, 402, 394, 390 (first lines) | `plans/FS131-close-inventory.md` on `main` (disk and head) | verbatim |

No mismatch.

Read in full: the brief, the standing rules, `LEAN.md`, `RUNNING.md` § Building and § Make the gate fail; CC1's record (Stages 1–3); KP2's
plan with lane G's stages (on `fs131-w5` at `5059983d`); `BendCollar.lean` at `bc168474`; inventory items 405–407.

### 4.2 The as-given build (`bc168474`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` at `bc168474`: **OK — all 1784 modules already up to date,
nothing built, 6 modules with warnings**, exit 0, 9 s (`build/gate/build/20261006T023000Z-67729.log`; driver log
`data/fs131/cc/build-asgiven-cc2.log`, which ends `EXIT=0`). As the brief expected.

### 4.3 What this job may change, and what it may not

**May change**: the files the merge of `origin/fs131-w5` (`5059983d`) brings, as the merge brings them; in
`Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean` the proofs of lane C's four open leaves (`CollarFit.map_degree_lensCurve`,
`CollarFit.map_degree_end`, `CollarFit.sides_end`, `exists_collarFit`), new children beside them, and the new child B0 `collarModel` with
its statement (this lane's to write: KP2's plan § 4); `Proofs/HadwigerNelson/Plane/ValidMap/Pushforward.lean` (supporting lemmas only);
`scripts/Axioms.lean` (a block of my own, headed "FS131-CC2", above the `=== PURCHASED ===` banner; at the merge both sides' blocks kept);
this record; `tools/fs131_cc_*.py` (with the fix to `fs131_cc_stmt.py` the brief orders, item 406 (c)); `data/fs131/cc/`;
`data/fs131/reports/FS131-CC2.md`.

**May not change**: any statement — a hypothesis, a conclusion, a docstring, a definition the statements use; no new `axiom`, no
`native_decide`; `RadialPush.lean` and `CollarMap.lean` beyond what the merge brings (lane G's, finished); `BaseDense`, `HexRing`,
`BaseWalk`, `Proofs.lean` and `ARCHITECTURE.md` (unless I add a module). No merge into `fs131-w5`, no `main` taken into this branch, no gate
run, nothing on `main`. No agents of my own; no file edited while a build of it runs; no background process left running.

## Stage 4 — SAVED (FS131-CC2)

## Stage 5 — SAVED (FS131-CC2): lane G merged in; the statement checker fixed; what still rests on `sorryAx`, by name

### 5.1 The merge

`git merge origin/fs131-w5` (`5059983d`, lane G's last commit) into `fs131-w5k` at `6db9c5d8`. Git merged every file by itself; the one
file both sides changed, `scripts/Axioms.lean`, merged with **both blocks kept**: the merged file is the base's (`2736ab8c`) plus 90 lines,
27 from this branch (the block headed "FS131-CC1") and 63 from lane G (its lines in the block headed "FS131-I5g"), and no line of either
side is missing (`diff` of each side against the merged file: 0 lines removed). `RadialPush.lean` and `CollarMap.lean` are byte-identical
to `5059983d`; `Pushforward.lean` and `BendCollar.lean` byte-identical to `6db9c5d8`. The merge is committed with `git commit` and no path
list (git refuses a path list on a merge); the index held the merge's files and this stage's files, each added by name.

### 5.2 The statement checker, fixed (inventory item 406 (c))

`tools/fs131_cc_stmt.py`, rewritten in three places:
- **the split**: a theorem's statement now ends at its **top-level `:=`** — the first `:=` outside every bracket, comment and string
  (`top_level_assign`), so `by …` or a term after it is proof and may change, and a `:=` inside a binder's default value does not end
  the statement. It fails closed: with a `let`/`have` before that `:=`, the whole declaration is compared;
- **the bases**: every statement of all four modules is compared with the skeleton at `2736ab8c` (so the merge is checked on lane G's
  side too), and `RadialPush`/`CollarMap` must be byte-identical to `5059983d`;
- **a name check** (lane G's finding, item 402): no new declaration of `Pushforward` or `BendCollar` has the full name of a
  declaration in another file under `Proofs/` (namespaces read from the `namespace`/`section`/`end` lines; a first, name-only form
  flagged `ArcMap.branchPt_congr` against `CurveGraph`'s `branchPt_congr` in another namespace, a false alarm, and was replaced).

On the merged tree: **PASS — 85 skeleton declarations, each once, statements byte-identical to `2736ab8c`; lane G's files as `5059983d`;
no other file under `Proofs/` changed; no `axiom`, no `native_decide`** (`data/fs131/cc/stmt-merge.txt`). So no statement of either side
changed in the merge. `--self-test` (`data/fs131/cc/stmt-merge-selftest.txt`): **15 of 15 plants fired, each naming its culprit, and 8 of 8
partners passed**. The term-mode controls the ruling asked for: *a term-mode proof under a changed statement* fires (`CollarFit.map_R3`
with `Ioo` turned `Icc` and a one-line term proof); its partners pass — `:= by exact X` turned `:= X`, and a whole tactic block replaced
by a term, both under an unchanged statement. On the splitter alone: a changed default value inside a binder fires; a binder `:=` with
only the proof changed, a `:=` in a comment or a string, and a `let` (whole text compared) pass. CC1's two `:= by exact …` proofs stay.

### 5.3 The build, and what rests on `sorryAx`

**Build** of the merged tree (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 455 of 455 batches, 5 modules rebuilt (`RadialPush`, `CollarMap`,
`BendCollar`, `BaseDense`, `Proofs`), 4 with warnings**, exit 0, 8 min 41 s (driver log `data/fs131/cc/build-merge.log`, ending `EXIT=0`;
the build's full output copied to `data/fs131/cc/build-merge-full.log`, which ends "Build completed successfully (5791 jobs)").

**Where `sorryAx` can enter** (`tools/fs131_cc_sorry_upstream.py`, new; `data/fs131/cc/sorry-upstream-merge.txt`): the full log's
`declaration uses 'sorry'` warnings, set against `BendCollar`'s imports. `BendCollar` imports 28 modules of `Proofs/` transitively, and
**none of them has a `sorry` declaration** (`RadialPush`, `CollarMap`, `Pushforward` among them); `BendCollar` has exactly four —
`exists_collarFit` (line 120), `CollarFit.map_degree_lensCurve` (157), `CollarFit.map_degree_end` (168), `CollarFit.sides_end` (270). A
declaration's axioms hold `sorryAx` only through a `sorry` declaration of its own module or of a module that one imports, so **every
`sorryAx` in `BendCollar` enters through those four**. Self-test (`sorry-upstream-selftest.txt`): a planted warning in an upstream module
fires and names it, a cut log fires; a warning in a module that is not upstream, and the unplanted log, pass.

**Axioms** against this build's oleans (`data/fs131/cc/CCAxiomsMerge.lean` → `.out`, `pp.fullNames`; read by `tools/fs131_cc_axioms.py`,
new, `data/fs131/cc/axioms-merge.txt`: **PASS, 70 names, 70 records**):
- **57 on the standard three or fewer**: lane G's 32 children (KP2's 20 in `RadialPush`, 12 in `CollarMap`, `map_Γ`, `map_lens`,
  `map_agreesOff`, `map_valid` among them — off `sorryAx` now that `Pushforward` is proved beneath them); `Pushforward`'s twelve (KP2's
  ten, `isSectorChart_circle`, `degree_of_circle`); and thirteen of CC1's in `BendCollar`, eight of them newly off `sorryAx` by the
  merge — `CollarFit.lensProf_le_one`, `isClosed_closedLens`, `isClosed_collarK`, `lens_subset_closedLens`, `map_ringArcsWithin`,
  `map_R3`, `coloursAt_subset`, `side_ne_inner_of_mem_lens` — with `isCompact_polarSet_Icc`, `ringPt_not_mem_openArc_of_end`,
  `mem_closure_region_inter_iff_of_agree`, `CollarFit.degree_openArc`, `CollarFit.pushProfiles`.
- **13 on `sorryAx`**, and by § above only through lane C's four open leaves: of CC1's stage-3 lemmas, **`CollarFit.sides_eq`,
  `map_R1`, `map_R2`, `map_inert`** (they read `sides_end`) and **`CollarFit.map_degree_and_repeated`, `map_hasDegree`,
  `map_hasRepeatedColour`** (they read `map_degree_lensCurve` and `map_degree_end`); the four leaves themselves; `bend_toward_collar`;
  and the control planted in the print file (`theorem ccControlPlanted : (1 : ℕ) = 2 := sorry`), which prints `sorryAx`.
The reader's self-test (`axioms-selftest.txt`): a name moved to the other section (each way), a deleted record, a foreign axiom in a
record of each kind — **5 of 5 fired, each naming its culprit**; the unplanted partner PASS.

## Stage 5 — SAVED (FS131-CC2)

## Stage 6 — SAVED (FS131-CC2): three of the four leaves — `map_degree_lensCurve`, `map_degree_end`, `sides_end`; one statement they all derive from

### 6.1 A better shape than the plan's, taken (the brief: "if you see a better shape, take it and say so")

KP2's plan and CC1's § 3.2 priced the two degree leaves at about 650 lines: a second two-germ chart where the lens boundary's two
circles cross, and at each end a chart surgery replacing `α`'s germ by the tangent circle's. Both rest on the plan's reading (§ 5.1) that
"`h` carries sectors" is false, sectors being read in balls. That reading is right about sectors at a given radius and too strong about
their **number**. Every point of every arc map's domain has a sector chart (`localSectors`), and the count of germs in a chart is a
topological invariant of the point:

> **`ArcMap.hasDegree_iff_of_homeo`** (`Plane/ValidMap/Pushforward`, new, [kernel]). Let `h` be a homeomorphism of the plane with
> `h z ∈ F'.interiorPts ↔ z ∈ F.interiorPts` and `F'.col (h z) = F.col z` on interior points. Then at every `v ∈ F.dom` with
> `h v ∈ F'.dom`: `F'.HasDegree (h v) m ↔ F.HasDegree v m` for all `m`, and `F'.HasRepeatedColour (h v) ↔ F.HasRepeatedColour v`.

Proof (`IsSectorChart.exists_injective_of_homeo`): take charts at `v` and at `h v`. A small sector at `v` is connected, so `h` sends it
into one sector at `h v` (connected sets among disjoint open ones: `exists_subset_of_isPreconnected_iUnion`); a smaller sector at `h v`
comes back into one sector at `v`; and the second assignment undoes the first, because each sector reaches its base point. So sectors
inject both ways, the two charts have the same number of germs, and the bijection carries colours. `pushforward_hasDegree` is the same
for `F.pushforward h …`. About 120 lines, first elaboration clean.

With it the two degree leaves are a few lines each, and no chart at the crossing or at an end is built:
- **`CollarFit.map_degree_lensCurve`** — the point is `h (ringPt P θ)` (`homeo_ringPt`); `pushforward_hasDegree` and `degree_openArc`.
- **`CollarFit.map_degree_end`** — an end is a point of `Γ` off the open arc, fixed by `h` (`homeo_fix_Γ`); `pushforward_hasDegree`.

(`map_degree_and_repeated`, CC1's case split, now has a one-line proof by the same lemma for `z ∈ F.dom`; it is left as CC1 wrote it,
since it also covers `z ∉ F.dom`.)

### 6.2 `sides_end`, by the same idea

`M.region d = h '' F.region d` (`pushforward_region`), so the side colours at a fixed end `x` are read from `F.region d` met with
`h⁻¹(B(Q, 1))`. It is enough that near `x` the homeomorphism moves no point across `ω(Q)`. Off the collar it moves nothing; it maps the
collar into itself (`CollarFit.homeo_mem_collarK`); and near `x` the collar minus `x` lies on one side of `ω(Q)`:

> **`CollarFit.exists_one_side`** (`BendCollar`, new, [kernel]): for `Q ≠ P` and an end `x`, there is `ρ > 0` such that every collar
> point `z ≠ x` within `ρ` of `x` has `dist z Q < 1`, or every such point has `1 < dist z Q`.

Its geometry is one lemma, **`collarK_frame`**: in the frame at an end `E` (`z − E = (Y + X i) e(θ_E)`), a collar point has `X ≥ 0`
at `θ₁` (`X ≤ 0` at `θ₂`) and lies between the tangent circles: `0 ≤ 2R'Y + |z − E|²` and `2R''Y + |z − E|² ≤ 0`. Those two are exactly
`tangRad`'s quadratic at `R'` and `R''` (`tangRad_le_iff`, `le_tangRad_iff`) — no distance to a circle's centre is computed. The rest is
real algebra (`side_core`, over `side_core_pos`, `side_core_neg`, `crescent_Y`, each on its own real variables, as `LEAN.md` advises for
`nlinarith`): with `m = E − Q` of frame components `(α, β)`, `dist(z, Q)² − 1 = |w|² + 2(αY + βX)`; the crescent hugs the tangent
(`|Y| ≤ |w|²`), so the sign is that of `βX` near `E`, and where `β = 0` the circle is the one tangent from outside (`α = −1`; `α = 1`
is `Q = P`). No horn set, no `isPreconnected_hornSet`, no case on the colour `d`. About 290 lines with the algebra.

`hF` is read by neither `map_degree_end` nor `sides_end` (`have _ := hF`, the repository's convention).

### 6.3 The re-price (the brief: after the first two leaves)

| child | CC1's price | spent | left |
|---|---|---|---|
| `map_degree_lensCurve`, `map_degree_end` | 650 | 135 (`Pushforward` +120, the two proofs 25) | — |
| `sides_end` | 200 | 290 | — |
| `exists_collarFit` | 450 | — | about 400: its children are written and elaborate in a scratch file but for one line (§ 7, next stage) |
| B0 `collarModel` | 150 | — | 150–300 (an explicit arc map with a ring arc; not started) |

### 6.4 The build, the axioms, the statements

**Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 455 of 455 batches, 3 modules rebuilt (`BendCollar`, `BaseDense`, `Proofs`), 4 with
warnings**, exit 0, 8 min 27 s (driver log `data/fs131/cc/build-stage6b.log`, ending `EXIT=0`; full output
`data/fs131/cc/build-stage6-full.log`, ending "Build completed successfully (5791 jobs)"). A build before it (`build-stage6.log`, OK, 5
modules rebuilt with `Pushforward`) showed one warning that was not a `sorry`: `hF` unused in `map_degree_end`; fixed, and
`tools/fs131_cc_sorry_upstream.py` now fails on any warning other than `sorry` in the collar's four modules (it fires on that build's
log; plant in its self-test). On this build's log (`data/fs131/cc/sorry-upstream-6.txt`): **PASS — no `sorry` in any of the 28 modules
`BendCollar` imports, no other warning in the collar's modules, and exactly one `sorry` declaration in `BendCollar`: `exists_collarFit`
(line 120).**

**Axioms** against this build's oleans (`data/fs131/cc/CCAxioms6.lean` → `.out`; `data/fs131/cc/axioms-6.txt`: **PASS, 33 names, 33
records**): **30 on the standard three or fewer** — the eleven new supporting theorems; the three leaves `CollarFit.map_degree_lensCurve`,
`CollarFit.map_degree_end`, `CollarFit.sides_end`; and every clause lemma of the assembly, off `sorryAx` now: `CollarFit.sides_eq`,
`map_R1`, `map_R2`, `map_inert`, `map_degree_and_repeated`, `map_hasDegree`, `map_hasRepeatedColour`, `map_R3`, `coloursAt_subset`,
`side_ne_inner_of_mem_lens`, `map_ringArcsWithin`, `map_valid`, `map_Γ`, `map_lens`, `map_agreesOff`, `degree_openArc`. **3 on
`sorryAx`**: `exists_collarFit` (the one open leaf), `bend_toward_collar` (through it alone), and the planted control. The reader's
self-test: 5 of 5 fired, partner PASS.

**Statements**: `tools/fs131_cc_stmt.py`: **PASS** (`data/fs131/cc/stmt-stage6.txt`; 85 skeleton declarations, statements
byte-identical to `2736ab8c`; lane G's files as `5059983d`); self-test 15 of 15 fired, 8 of 8 partners passed (`stmt-selftest6.txt`).
`scripts/Axioms.lean`: a block headed "FS131-CC2" above the `=== PURCHASED ===` banner, the eleven new theorems.

### 6.5 Theorems this stage proved

Each [kernel], on exactly `[propext, Classical.choice, Quot.sound]` or fewer (`data/fs131/cc/CCAxioms6.out`); names under
`HadwigerNelson.Plane.ArcMap`.
- `Plane/ValidMap/Pushforward`: `exists_subset_of_isPreconnected_iUnion`, `IsSectorChart.exists_injective_of_homeo`,
  **`hasDegree_iff_of_homeo`**, `pushforward_hasDegree`.
- `Plane/ValidMap/BendCollar`, the skeleton's leaves: **`CollarFit.map_degree_lensCurve`**, **`CollarFit.map_degree_end`**,
  **`CollarFit.sides_end`**; new: `collarK_frame`, `side_core_pos`, `side_core_neg`, `crescent_Y`, `side_core`,
  `CollarFit.exists_one_side`, `CollarFit.homeo_mem_collarK`.
- Kernel theorems now, with no change to their text (their open inputs landed): `CollarFit.sides_eq`, `map_R1`, `map_R2`,
  `map_inert`, `map_degree_and_repeated`, `map_hasDegree`, `map_hasRepeatedColour` (CC1's), and by the merge `CollarFit.lensProf_le_one`,
  `isClosed_closedLens`, `isClosed_collarK`, `lens_subset_closedLens`, `map_ringArcsWithin`, `map_R3`, `coloursAt_subset`,
  `side_ne_inner_of_mem_lens`.

**`hmax`, scored so far** (item 390): none of the three leaves reads it, nor `hlen`; `exists_collarFit`'s statement does not take it.

## Stage 6 — SAVED (FS131-CC2)
