# FS131-I6D — wave 6, the bridge's existence half (`FanBridge`), and the model `sq9.SingLocallyFinite`

*The implementer's record (de Bruijn, the implementer). Branch `fs131-w6f`, cut from `fs131-w6` at `32f2ab4c`. Brief:
`data/fs131/briefs/FS131-I6D-wave6-bridge.md` (on `main`).*

## Theorems this phase proved

*Axioms as printed on this branch (`data/fs131/i6d/logs/axioms-3.txt`). "std3" is `[propext, Classical.choice, Quot.sound]`; "std3 + upstream"
adds `sorryAx`, every instance of which is a leaf of `Curve` or `LocalGraph` — another line's, proved on `fs131-w6c` at `d62406a2` with identical
statements (the coordinator's message, 2026-10-06) — since none of this job's four modules holds a `sorry`. Each becomes std3 at the join (with
`Pinch`'s leaves, which `local_graph` reads), which is where the audit runs.*

- **FS131-E8-BETA, the curve's part** — `IsUnitCurve.exists_polarGraph` (`Plane/Saturated/FanBridge`; proof `IsUnitCurve.exists_polar_angle`, `Plane/Saturated/CurveArc`) — std3 + upstream (`chord`, `strictMonoOn_dist`, `norm_sub_le`).
- **FS131-E8-GAMMA** — `AeColouring.gamma` (proof `AeColouring.exists_arc_of_isolated`, `Plane/Saturated/FanArcs`, over `ArcSetting.exists_component_arc`, `Plane/Saturated/ArcContinuation`) — std3 + upstream (`chord`, `AeColouring.local_graph`, `closure_essBdry_subset`).
- **FS131-E8-BETA** — `AeColouring.beta` (proof `AeColouring.exists_polarGraph_of_isolated`, `FanArcs`) — std3 + upstream.
- **FS131-E8-ALPHA** — `AeColouring.alpha` (proof `AeColouring.finite_components_of_isolated`, `FanArcs`) — std3 + upstream.
- **FS131-E8-FAN** — `AeColouring.fan_of_isolated` (proof `AeColouring.exists_fan_of_isolated`, `Plane/Saturated/FanBuild`) — std3 + upstream (the above and `ae_one_colour_of_isConnected`).
- **FS131-E8-BRIDGE** — `AeColouring.regJFan_of_saturated`, `regJFan_iff_singLocallyFinite` (the planner's proofs from `fan_of_isolated`; now with no `sorry` of `FanBridge` under them) — std3 + upstream.
- **FS131-E8-CLAUSE2** — `AeColouring.regJLiteral_of_saturated`, `AeColouring.finite_arcs_of_isBounded` (proofs `regJLiteral_of_locallyFinite`, `finite_arcs_of_bounded`, `FanBuild`, over `Fan.finite_arcs_meeting_ball` — std3, no saturation read) — std3 + upstream.
- **The model** — `sq9_singLocallyFinite : sq9.SingLocallyFinite` (`Plane/Saturated/FanExamples`; with `sq9_singularSet_subset_grid`, `sq9_not_isCuspAt`) — **std3**; `sq9_regJFan : sq9.RegJFan` (`FanBridge`) — std3 + upstream.
- Colour-free lemmas, each **std3**: `eq_affine_of_sin_bounds`, `IsUnitCurve.affine`, `.dist_le`, `isUnitCurve_angleCurve`, `IsUnitCurve.eqOn_angleCurve` (`CurveArc`); `isOpen_polarRegion`, `isPreconnected_polarRegion`, `exists_ordered_lifts`, `polarRegion_disjoint_polarGraph` (`FanBuild`). Std3 + upstream (`chord` only): `IsUnitCurve.sin_abs_le_dist`, `.reparam`, `IsArcOf.eqOn`, `ArcSetting.exists_max_arc`, `ArcSetting.exists_component_arc`.

## Stage 1 — SAVED (FS131-I6D): the readback, the as-given build, what may and may not change

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation | source | result |
|---|---|---|
| the seven statement heads (`gamma`, `IsUnitCurve.exists_polarGraph`, `beta`, `alpha`, `fan_of_isolated`, `regJLiteral_of_saturated`, `finite_arcs_of_isBounded`) | `Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean` ll. 67, 78, 91, 100, 112, 130, 136 at `32f2ab4c` | each matches, character for character (the quotation is the first line of each statement) |
| "## Stage 11 — SAVED: the bridge's eight rows …", "### 11.4 The plan per leaf", the `FanBridge` module row, the `gamma`, `alpha`, `fan_of_isolated` rows, "### 12.1 …", "### 12.2 …" | `plans/FS131-w6-kernel-plan.md` ll. 577, 627, 603, 647, 650, 651, 696, 712 | each matches |
| "## Stage 3 — SAVED: the derivation — the four clauses, the fan, the bridge" | `plans/FS131-E8-derivation.md` l. 193 (on `main`) | matches |
| inventory items 501, 502, 490, 499 (first lines) | `plans/FS131-close-inventory.md` ll. 5176, 5205, 4925, 5122 (on `main`) | each matches |

No mismatch.

### 1.2 Read

The brief; `plans/STANDING-RULES.md`; `LEAN.md` in full; `RUNNING.md` § Building, § Make the gate fail, and watch it fail; the planners' record
Stages 9–12 whole; the deriver's Stage 3 (§§ 3.1–3.8) with the erratum under § 3.1 and the note under FS131-E8-FAN; the modules `Basic`, `Fan`,
`FanExamples`, `Curve`, `LocalGraph`, `FanBridge` whole, and `Pinch` ll. 150–260 (`TwoColourOn.essBoundary_inter_eq`, `TwoColourNhd.mem_essBoundary`).
Not read: the deriver's Stage 6 beyond its headings; the first pass's Stages 3 and 5.

### 1.3 The branch builds as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, in the worktree: **OK — all 1804 modules up to date, 5 modules with
warnings, 31 warnings, every one `declaration uses sorry`** (`Pinch` 7, `MapColouring` 1, `Curve` 6, `LocalGraph` 5, `FanBridge` 12), exit 0
(`data/fs131/i6d/logs/build-0-as-given.log`).

### 1.4 What I may and may not change

- **May**: the proofs of `gamma`, `IsUnitCurve.exists_polarGraph`, `beta`, `alpha`, `fan_of_isolated`, `regJLiteral_of_saturated`,
  `finite_arcs_of_isBounded` in `FanBridge` (and an import line there); new helper declarations under names of my own, in new modules of my own beside
  it (with `Proofs.lean` and `ARCHITECTURE.md` rows); `sq9.SingLocallyFinite` as a new declaration in `FanExamples`; a block "FS131-I6D" in
  `scripts/Axioms.lean`; this record; `tools/fs131_i6d_*.py`; `data/fs131/i6d/`; the report.
- **May not**: any statement or definition; `Basic`, `Pinch`, `MapColouring`, `Fan`, the planners' record; the five `AeColouring.Fan` leaves of
  `FanBridge` (`two_le_n`, `col_ne`, `branch_outside_discs`, `branch_contacts`, `sector_alone` — another implementer's, on `fs131-w6g`), nor helpers
  between them; `Curve` and `LocalGraph` (a third implementer's, on `fs131-w6c`); a new `axiom`; `native_decide`; `main`; the gate.
- **What my theorems rest on until the lines join**: `Curve`'s six leaves and `LocalGraph`'s five are `sorry` on this branch, so every theorem below
  that cites one prints `sorryAx` here; each stage's axioms line says which upstream leaves it reads.

### 1.5 The route, fixed before the first leaf (changes to the plan's § 11.4 are said where they are made)

- Helpers live in two new modules, so `FanBridge` gets proof bodies and one import line only: `Plane/Saturated/CurveArc` (no colouring: shift and
  reversal of a unit curve, the chord bound on any interval, the reparametrization lemma, the continuation theorem over a set with charts, the polar
  graph) and `Plane/Saturated/FanArcs` (the colouring's charts; the forms of `gamma`, `beta`, `alpha` with `IsolatedAt`'s fields as hypotheses).
- `gamma`, changed route (the plan's: Zorn over curves ordered by extension, "gluing two charts along an overlap"). Mine: (N) a map of an interval
  with `sin|Δs| ≤ |Δf|`, `sin|Δf| ≤ |Δs|` is `±s + c` (monotone, derivative `±1` by the cubic bound on `sin`); (R) a unit curve inside the image of a
  chart is the chart up to `±s + c` — both inequalities are the chord bound; (U) two arcs through `y` with one tangent angle there agree on their
  common interval (open and closed); the maximal arc is the union, its angle extended 1-Lipschitz to the line and the curve recovered as
  `y + ∫ e ∘ ψ` — every arc is the restriction of a curve on the whole line, which removes the one-sided derivatives at the ends; an end inside the
  punctured disc would be an essential boundary point (`closure_essBdry_subset`) and its chart would extend the arc; the component is the arc (open in
  the essential boundary by the charts, closed by the ends).

## Stage 2 — SAVED (FS131-I6D): `IsUnitCurve.exists_polarGraph`, `gamma`, `beta`, `alpha` — proved

**Leaves closed (4 of 7)**: `IsUnitCurve.exists_polarGraph`, `AeColouring.gamma`, `AeColouring.beta`, `AeColouring.alpha` — each a one-line
term in `FanBridge` over a theorem of a new module (statement text of each identical to its leaf's conclusion).

**New modules** (no `sorry` in any):
- `Plane/Saturated/CurveArc` — `IsUnitCurve.affine`, `.sin_le_dist`, `.sin_abs_le_dist`, `.dist_le`, `.injOn_of_abs_le`,
  `.abs_sub_lt_of_dist_lt_one`; `angleCurve`, `isUnitCurve_angleCurve`, `IsUnitCurve.eqOn_angleCurve`; `eq_add_of_sin_bounds`,
  `eq_affine_of_sin_bounds`; `IsUnitCurve.reparam`; `IsUnitCurve.exists_polar_angle` (the leaf `exists_polarGraph`).
- `Plane/Saturated/ArcContinuation` — `HasArcChart`, `ArcSetting`, `IsArcOf`; `IsArcOf.eqOn`, `ArcSetting.exists_max_arc`,
  `IsArcOf.left_end_notMem`, `.right_end_notMem`, `ArcSetting.exists_component_arc`.
- `Plane/Saturated/FanArcs` — `AeColouring.hasArcChart`, `.arcSetting_of_isolated`, `.exists_arc_of_isolated` (GAMMA),
  `.exists_polarGraph_of_isolated` (BETA), `.finite_components_of_isolated` (ALPHA).

**Routes, against the plan's § 11.4.**
- `exists_polarGraph`: the plan's route. The inverse of the distance is `StrictMonoOn.orderIso` composed with `projIcc` (continuous on the line);
  the angle is `ψ 0 + arg ((γ s − γ 0) · conj (e (ψ 0)))`, continuous because `chord` keeps the argument in the right half plane; the limit is
  `norm_sub_le`. Reads `strictMonoOn_dist`, `chord`, `norm_sub_le` (upstream leaves).
- `gamma`: **changed route** (§ 1.5), no Zorn and no gluing of charts. What made it short: (i) the chord bound gives `sin|Δs| ≤ |Δγ| ≤ |Δs|` on any
  interval, so a curve inside another's image is related to it by a map `τ` with `sin|Δs| ≤ |Δτ|`, `sin|Δτ| ≤ |Δs|`, and such a map is `±s + c`
  (`eq_affine_of_sin_bounds`: monotone by `ContinuousOn.strictMonoOn_of_injOn_Icc'`, right derivative `1` by the cubic bound
  `Real.sin_gt_sub_cube`, then `constant_of_has_deriv_right_zero`); (ii) arcs are curves **on the whole line** (`angleCurve y θ = y + ∫₀ˢ e ∘ θ`
  with `θ` a 1-Lipschitz extension, `LipschitzOnWith.extend_real`), so the maximal arc is the supremum of intervals with one glued angle, and an
  end inside `U` is extended by changing the angle function only; (iii) the right end is the left end of the reversed arc.
  Reads `chord` (through `sin_le_dist`) and `AeColouring.local_graph`, `closure_essBdry_subset` (upstream leaves).
- `beta`, `alpha`: the plan's routes.

**Re-pricing, from the first two leaves** (the brief's instruction): `exists_polarGraph` priced 1.5 d, `gamma` 4 d; both closed in this stage,
in one sitting, with five elaborations of `CurveArc`, three of `ArcContinuation`, two of `FanArcs`. The plan's prices for the *large* leaves were
high too, by more than the factor it expected for the computational ones: what was priced as gluing charts became one real-variable lemma.
`fan_of_isolated` (3 d) is re-priced at one stage.

**Checks.**
- Build: **OK — 466 of 466 batches, 5 modules rebuilt** (`CurveArc`, `ArcContinuation`, `FanArcs`, `FanBridge`, `Proofs`), 5 modules with
  warnings, **27 `declaration uses sorry`** (31 as given, less these four), exit 0 — `data/fs131/i6d/logs/build-1-gamma-beta-alpha.log`.
- Statements: `python3 tools/fs131_i6d_statements.py` — OK against `32f2ab4c` (six frozen files byte-identical; in `FanBridge` and `FanExamples`
  every base line survives in order, a `sorry` and a trailing `by` excepted); `--self-test`: three planted faults (a bound changed, a hypothesis
  deleted, a docstring changed) each fire, the unplanted tree passes.
- Axioms (`python3 tools/fs131_i6d_axioms.py`, `data/fs131/i6d/logs/axioms-1.txt`): 23 records — 5 clean (the standard three), 18 the standard
  three and `sorryAx`; my three modules hold no `sorry`, so each `sorryAx` is an upstream leaf's (`Curve`: `chord`, `strictMonoOn_dist`,
  `norm_sub_le`; `LocalGraph`: `AeColouring.local_graph`, `closure_essBdry_subset`). Controls: `IsUnitCurve.chord` reads `sorryAx` (fires);
  `norm_sub_le_of_discs` reads clean; a missing name is an error (fires).
- `tools/check_architecture.py`: PASS (three rows added to § 3.11, `FanBridge`'s imports updated); before the rows were added it failed on
  exactly the three modules and the new import — its control, watched.
- Names: `python3 tools/fs131_i6d_names.py` — 0 hits for my 43 new short names on `origin/fs131-w6` (`6fc27fa1`), `-w6c` (`fa316580`), `-w6g`
  (`32f2ab4c`), `-w6p`, `-w6m`; `--self-test` OK. Text level; the gate's check is `scripts/dupnames.sh` on the joined tree.

**Each theorem against its entry** (`plans/FS131-E8-derivation.md`): GAMMA — "every connected component of the interface set in B(z, R) is an open
arc of length at most π/2, not closed, each of whose two ends converges to z or to a point of the circle ∂B(z, R), and whose unit tangent has a
limit at each end": the component is `γ '' Ioo 0 L`, `L ≤ π/2`, `γ` injective on `[0, L]`, `IsUnitCurve` on `[0, L]`, each end `z` or on
`sphere z R` — read on the essential boundary in the punctured disc, which is the interface set there. BETA — "a polar graph
{z + t e(φ(t)) : 0 < t < R} with φ continuous on (0, R) and convergent, as t → 0": `beta`'s conclusion. ALPHA — "finitely many connected
components … meet the closed disc of radius R/2 about z, and there is r with 0 < r ≤ R/2 such that every point of the essential boundary in
B(z, r) other than z lies on a component that has an end at z": `alpha`'s conclusion, "has an end at z" read as `z` in the closure.

## Stage 3 — SAVED (FS131-I6D): `fan_of_isolated`, `regJLiteral_of_saturated`, `finite_arcs_of_isBounded` — proved (all seven leaves closed)

**Leaves closed (7 of 7)**: with stage 2's four, `AeColouring.fan_of_isolated`, `AeColouring.regJLiteral_of_saturated`,
`AeColouring.finite_arcs_of_isBounded` — one-line terms in `FanBridge` over `Plane/Saturated/FanBuild` (new, no `sorry`). `FanBridge`'s five
remaining `sorry`s are the five `AeColouring.Fan` leaves of the other implementer (`two_le_n`, `col_ne`, `branch_outside_discs`,
`branch_contacts`, `sector_alone`), untouched. `regJFan_of_saturated` (FS131-E8-BRIDGE, proved by the planner from `fan_of_isolated`) now rests on
no `sorry` of this file.

**Routes, against the plan's § 11.4.**
- `fan_of_isolated`: the plan's route (E8 § 3.6), in five pieces. `isOpen_polarRegion` — every point is in polar form about `z` with its angle
  measured from a reference direction by `arg` (`polarPt_norm_arg`), continuous near a point of the region, so the region is a neighbourhood of
  each of its points; `isPreconnected_polarRegion` — the image of a rectangle; `exists_ordered_lifts` — the angles at `r/2` reduced into
  `[0, 2π)` by a floor, sorted by `Finset.orderEmbOfFin`, and the difference of two lifts stays in `(0, 2π)` because its image is an interval that
  misses `0` and `2π`; `polarRegion_disjoint_polarGraph` — no branch enters the region between consecutive ones; regions by
  `ae_one_colour_of_isConnected`. Reads `alpha`, `beta` and `AeColouring.ae_one_colour_of_isConnected` (an upstream leaf).
- CLAUSE2, **shorter than the plan's** (and than E8 § 3.7's "compactness off the fans"): `fan_of_isolated` gives a fan at *every* point under
  saturation and local finiteness (singular or not), a fan's disc meets finitely many interface arcs (`Fan.finite_arcs_meeting_ball`: an arc
  that meets it off the centre holds a whole branch; no saturation read), and a bounded set is covered by finitely many such discs. The first
  clause is the same lemma at one disc; no chart is read again.

**Checks.**
- Build: **OK — 466 of 466 batches, 3 modules rebuilt** (`FanBuild`, `FanBridge`, `Proofs`), **24 `declaration uses sorry`** (31 as given, less
  my seven), exit 0 — `data/fs131/i6d/logs/build-2-fan-clause2.log`.
- Statements: `tools/fs131_i6d_statements.py` OK against `32f2ab4c`.
- Axioms (`data/fs131/i6d/logs/axioms-2.txt`): 35 records — 10 clean, 25 the standard three and `sorryAx` (upstream leaves only: my four modules
  hold no `sorry`); the three controls as in stage 2.
- `tools/check_architecture.py`: PASS (row `Plane/Saturated/FanBuild`). Names: 0 hits for 57 short names on the wave's five other branches
  (`origin/fs131-w6` `6fc27fa1`, `-w6c` `d62406a2`, `-w6g` `32f2ab4c`, `-w6p`, `-w6m`).

**Each theorem against its entry.** FAN — "there is r > 0 such that the essential boundary in B(z, r) off z is the union of finitely many pairwise
disjoint curves … each a polar graph t ↦ z + t e(φ(t)) over 0 < t < r with φ continuous and convergent as t → 0, and each open region between two
angularly consecutive curves is almost everywhere of one colour": the structure `Fan`, field by field (`bdry`, `cont`, `tendsto`, `mono` and
`wrap` for "angularly consecutive", `region`); "at least two" and "of different colours" are the other implementer's `two_le_n`, `col_ne`.
Hypotheses: `0 < R`, `Σ ∩ B(z, R) ⊆ {z}`, saturation on the punctured disc — no `z ∈ Σ`, no `R ≤ 1/2` (the proof passes to `min R (1/2)`).
CLAUSE2 — "every point of Σ lies in the closure of finitely many connected components of the interface set, and every bounded set meets
finitely many connected components of the interface set": the two declarations, verbatim.

## Stage 4 — SAVED (FS131-I6D): the model `sq9.SingLocallyFinite`, `sq9.RegJFan`; the last checks; what is left

**Proved**: `sq9_singLocallyFinite : sq9.SingLocallyFinite` in `Plane/Saturated/FanExamples` (the plan's § 10.3 debt), on the standard three axioms,
and `sq9_regJFan : sq9.RegJFan` in `FanBridge` (after `regJFan_iff_singLocallyFinite`; from `regJFan_of_saturated`, `sq9_tight_saturated`).
**Route, shorter than the plan's** ("the vertex analysis at every grid vertex … the lemmas of `FanExamples` with `n`, `m` general"): no vertex is
analysed. `Σ ⊆` the grid's vertices (`sq9_singularSet_subset_grid`) because (a) `sq9` has no cusp anywhere — a point of a class's support lies in
a closed square of its colour (`sq9_essSupport_subset_sq`, nine candidate squares near any point) and closed squares lie in the essential closure
(wave 2's `sq9Sq_subset_essClosure`); (b) an essential boundary point lies on a grid line (wave 2's `sq9_mem_edge_of_not_mem_densitySet`), and one
that is no vertex has a two-colour ball (`sq9_twoColourNhd_of_re_grid`, `_of_im_grid`, through `twoColourNhd_of_halves`). A unit disc holds
finitely many vertices. Spec example: `sqVertex` (a singular point, `sqVertex_mem_singularSet`) satisfies the inclusion's conclusion.
**Inhabitant notes** added, as the brief asks, to the docstrings of `fan_of_isolated` (`sq9_isolatedAt`), `regJFan_of_saturated`,
`regJLiteral_of_saturated`, `finite_arcs_of_isBounded` (`sq9` with `sq9_tight_saturated`, `sq9_singLocallyFinite`): one added line each, the base
text intact (the statements tool now lets a docstring's closing line be continued, and still fails a changed one).

**A slip, caught before the build**: my helper `abs_re_im_lt_of_mem_ball` (in `FanExamples`) had the name of a theorem of `Plane/SVMap` (a
different statement; neither module imports the other, so `lake env lean` on `FanExamples` could not see it and the build would have refused
`Proofs`). `tools/fs131_i6d_names.py` reported it on every ref; renamed `abs_re_im_sub_lt_of_mem_ball`. The tool's first run had searched my
modules only — the names I add to files not wholly mine are now in its list.

**Checks.**
- Build: **OK — 466 of 466 batches, 3 modules rebuilt** (`FanExamples`, `FanBridge`, `Proofs`), **24 `declaration uses sorry`, none mine**
  (`Pinch` 7, `MapColouring` 1, `Curve` 6, `LocalGraph` 5, `FanBridge` 5 — the five `AeColouring.Fan` leaves), exit 0 —
  `data/fs131/i6d/logs/build-3-model.log`.
- Statements: OK against `32f2ab4c`; `--self-test` OK (three plants fire, the unplanted tree passes).
- Axioms (`data/fs131/i6d/logs/axioms-3.txt`): 41 records — 15 clean, 26 the standard three and `sorryAx` (upstream leaves only); controls fire.
- Negative control of elaboration (`data/fs131/i6d/logs/plant-false-example.txt`): a false `example : (1 : ZMod 3) = 0 := by decide` appended to
  a scratch copy of each of `CurveArc`, `ArcContinuation`, `FanArcs`, `FanBuild`, `FanBridge` is refused, and is the only error of each — the
  files are elaborated to their last line. (The model's file: the same plant, the same refusal, on the scratch copy it was developed in.)
- Linters, as iteration evidence only (`lake lint --no-build -- --no-build --trace` under the slot, `data/fs131/i6d/logs/lint-1.txt`): exit 0,
  `-- Linting passed for Proofs.`, 14 `Passed!` lines, no line naming a declaration of mine.
- `tools/check_architecture.py`: PASS. Names: 0 hits for 67 short names on the wave's five other branches (`-w6c`, `-w6g` at `d62406a2`), and 0
  elsewhere in this tree.
- **Not run, by the brief**: the gate (`scripts/axioms.sh`, `scripts/vacuity.sh`, `scripts/dupnames.sh`) — the join's.

**The coordinator's message (mid-job, after stage 3)** — `fs131-w6c` handed back at `d62406a2`, statements identical: read. I want neither the
merge nor an unexported fact. `gamma`'s route reads of `IsInterfaceChart` only `isOpen`, `mem`, `pos`, `subset`, `curve`, `zero`, `bdry` — not
`injOn` (injectivity is the chord bound's), not `discs`, not `sides`; and none of `exists_arclength_inverse`, `exists_unit_curve_of_two_discs`,
`IsUnitCurve.sin_add_sin_le`, `IsUnitCurve.strictMonoOn_dist_of_le_pi`, `isConnected_graph_side` is declared here (names tool, 0 hits at
`d62406a2`).

### What is left, and its route

Nothing of this job's list: the seven leaves and the model are proved. For the join and for the lines that follow:
1. **The join with `fs131-w6c`** (and `-w6p`): both lines edit `scripts/Axioms.lean` (my block "FS131-I6D" sits above the PURCHASED banner) and
   `ARCHITECTURE.md` (I added four rows after `Plane/Saturated/Curve`'s and changed `FanBridge`'s import cell); `Proofs.lean` has my four imports
   after `Curve`'s. Then `scripts/dupnames.sh` and the audit: my 41 records should read the standard three once `Curve`, `LocalGraph` and `Pinch`
   are proved.
2. **For the implementer of the five `Fan` leaves (`fs131-w6g`)** — proved here, so never to be declared again under these names:
   `isOpen_polarRegion`, `isPreconnected_polarRegion`, `polarRegion_nonempty`, `isPreconnected_polarGraph`, `polarPt_norm_arg`,
   `polarPt_eq_polarPt`, `polarPt_add_int`, `polarGraph_sub_int`, `polarRegion_disjoint_polarGraph` (`FanBuild`); `IsUnitCurve.affine` (shift
   and reversal), `.sin_abs_le_dist`, `.dist_le`, `.injOn_of_abs_le`, `.continuousOn`, `.abs_angle_sub_le`, `.reparam`, `angleCurve`
   (`CurveArc`); `AeColouring.arcSetting_of_isolated`, `ArcSetting.exists_open_subset_component` (`FanArcs`). `Fan.branch_outside_discs` and
   `Fan.branch_contacts` need "a branch is a component with `z` in its closure, parametrized from `z`": `exists_arc_of_isolated` with
   `polarGraph_of_curve_from_center` is that curve, and `isPreconnected_polarGraph` with `Fan.branch_subset` puts a branch in one component.
3. **Stale docstring phrases, not mine to change** (`Fan.lean` is fenced; in `FanBridge` my check freezes base lines): "[hand], one mind, until
   `Plane/Saturated/FanBridge` lands" (`Fan.lean`'s module docstring), "each entry **[hand], one mind, kernel pending** until this module lands"
   (`FanBridge`'s), "([hand], one mind, until `fan_of_isolated` is proved)" (`Fan.sector_alone`'s). At the join: "kernel-checked
   (`fan_of_isolated`)".

## Drafts for the front page

*I ran no gate (the brief), so no count is drafted; each draft is conditional on the join named in "What is left" (1).*

- **`CLAUDE.md` § The gate and § Trust ledger** — slot: the sentence "the current audit reads … clean and … declared purchases" and the vacuity
  counts. Draft: no number from this branch. At the join this job adds 41 records to `scripts/Axioms.lean` (block "FS131-I6D"), all expected
  under CLEAN, no purchase, no import; and four modules (`Plane/Saturated/CurveArc`, `ArcContinuation`, `FanArcs`, `FanBuild`) with three
  definitions (`HasArcChart`, `ArcSetting`, `IsArcOf`, each with a spec lemma) and `angleCurve` (spec `angleCurve_zero`) to the vacuity scan —
  `ArcSetting`'s and `IsArcOf`'s theorems take a structure hypothesis; their inhabitant is `AeColouring.arcSetting_of_isolated` at
  `sq9_isolatedAt` (named in `ArcContinuation`'s module docstring), which the scan may read as GENERIC or UNKNOWN: to be reconciled there.
- **The derivation's entries, regraded** — slot: `plans/FS131-E8-derivation.md`, the `grade:` and `minds:` lines of FS131-E8-GAMMA, -BETA,
  -ALPHA, -FAN, -BRIDGE, -CLAUSE2 (each "grade: hand / minds: 1"), and the phrase "[hand], one mind, kernel pending" of its § 3.8. Draft, for
  each: "grade: kernel — `AeColouring.gamma` | `IsUnitCurve.exists_polarGraph`, `AeColouring.beta` | `AeColouring.alpha` |
  `AeColouring.fan_of_isolated` | `AeColouring.regJFan_of_saturated` | `AeColouring.regJLiteral_of_saturated`,
  `AeColouring.finite_arcs_of_isBounded` (`Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean`), on the standard three axioms once
  `Plane/Saturated/Curve`, `LocalGraph` and `Pinch` are proved (`fs131-w6c`, `fs131-w6p`); no assumption beyond the statement's hypotheses."
  FS131-E8-CLAUSE2's "uses only" line can lose "FS131-E8-LOCAL (off Σ each interface point has a neighbourhood in one component); compactness"
  for "a fan at every point (FS131-E8-FAN at singular and non-singular points alike); a bounded set is covered by finitely many fans' discs".
- **`CLAUDE.md` § Frontier** — slot: the sentence on FS-131's wave 6 (the Lean backlog's state; I do not hold its current words). Draft: "wave
  6's bridge is in the kernel: under saturation a fan exists at every point isolated from the other singular points (`fan_of_isolated`), so
  `RegJFan` is `SingLocallyFinite` (`regJFan_iff_singLocallyFinite`), with `sq9` its model (`sq9_regJFan`)" — to be filed when the join passes
  the gate.
- **Proof Atlas** — the nodes FS131-E8-GAMMA, -BETA, -ALPHA, -FAN, -BRIDGE, -CLAUSE2: [hand] → [kernel] at that join.
