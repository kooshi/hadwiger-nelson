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
- `Plane/ValidMap/BendCollar`: **`ArcMap.CollarFit.degree_openArc`**.

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
