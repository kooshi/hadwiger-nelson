# FS131-I6D — wave 6, the bridge's existence half (`FanBridge`), and the model `sq9.SingLocallyFinite`

*The implementer's record (de Bruijn, the implementer). Branch `fs131-w6f`, cut from `fs131-w6` at `32f2ab4c`. Brief:
`data/fs131/briefs/FS131-I6D-wave6-bridge.md` (on `main`).*

## Theorems this phase proved

*(one line per kernel theorem, with its declaration and its axioms; filled stage by stage — see each stage)*

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
