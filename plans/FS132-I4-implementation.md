# FS132-I4 — the join: the ported outside lemmas under the exclusion's skeleton, and the leaves that stand on them

*Record of the implementer (de Bruijn, Opus 5.5). Brief: `data/fs132/briefs/FS132-I4-join.md` on `main` at `4bb0c8c4a`.
Branch `fs132-wi4`, cut from `fs132-wk1` at `1c5e2609a`; worktree `.claude/worktrees/fs132-wi4`. Working files:
`data/fs132/i4/`. The planner's record is `plans/FS132-kernel-plan.md` (not edited here); the port's is
`plans/FS132-I2-implementation.md` on branch `fs132-wi2` (not edited here).*

## Theorems this phase proved

*One line per kernel theorem, with its declaration and its axioms. Filled as the stages save; the axioms are printed
at the last stage from the built modules.*

(none yet — stage 1 is the readback)

## Stage 1 — SAVED (FS132-I4): the readback, and the branch built as given

**The quotations.** `data/fs132/i4/readback.py` reads every quotation of the brief (a run of `>` lines closed by a
`> — source:` line) and checks that its text, whitespace-normalized, occurs in the named source:
**21 quotations, 21 matched** (`data/fs132/i4/readback.out`, exit 0) — Kooshi's two, the fifteen first lines of the
leaves in `State`, `Excl`, `ChartMeasure`, `Kill`, the planner's four. Control: with one letter of the first quotation
changed (`--fault`) the run reads `matched=20 mismatched=1` and exits 1 (`readback-fault.out`). No finding about the brief.

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and
watch it fail; the planner's record Stages 5–7 (§§ 5.1–5.4, 6.1–6.4, 7, 7.1); the port's record §§ 2.1, 3.1, 3.2, 3.4,
3.5, 3.6 and its drafts; the skeleton's `Basic`, `Placeholders`, `State`, `Excl`, `TwoPairs`, `ChartMeasure`, `Kill`,
`Chart`, `Shift`, `StepLemma`, `Orbit` (whole); the hand argument `plans/FS132-E3-derivation.md` Stage 3 (the entries,
M0–M9, the ring form, on `main`) and `plans/FS132-derivation.md` § 1 (on `main`).

**The branch as given.** `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`:
**exit 0**, "all 1860 modules already up to date, nothing built" (`data/fs132/i4/logs/build-0-as-given.out`); 71
`declaration uses sorry` warnings, by module: `Chart` 11, `ChartMeasure` 4, `CyclicCentre` 3, `Excl` 2, `Kill` 2,
`Placeholders` 3, `Shift` 7, `State` 8, `StepLemma` 8, `Tips` 7, `Winding` 16 — the planner's count (§ 7, "71").

**What this job's leaves are** (16 `sorry`s in four files — 8 + 2 + 4 + 2; this line first read "17", a miscount corrected at stage 3 — and the three placeholders the join removes):
`State` 8 (`measurableSet_liftPalette`, `OutsideOrbit.ae_iff_not`, `.ae_flip`, `.change_at`, `.chart_avoids`,
`exists_tip`, `.hubColours`, `.hubColours_flip`), `Excl` 2 (`exists_change_of_ae_outside`, `ae_real_of_ae_angles`),
`ChartMeasure` 4 (`chart_quasiMeasurePreserving`, `shear_quasiMeasurePreserving`, `ae_ne_of_not_isTip`,
`unitPair_chart_ae`), `Kill` 2 (`no_double_change`, `step_kill`). `TwoPairs` has none of its own.

## Stage 2 — SAVED (FS132-I4): the join

**The merge.** `git merge --no-ff fs132-wi2` (tip `4060fe1d6`) into `fs132-wi4`: **automatic, no conflict** — merge
commit `466d0fa1d`. Both sides had added lines to `Proofs.lean` and to `ARCHITECTURE.md` § 3; git kept both (the eight
`Outside.OAI158…` imports beside the twelve `Plane.SixRing…` ones; the eight rows beside the thirteen). What the merge
brought into this branch: the eight generated modules under `Proofs/HadwigerNelson/Outside/`, the port's edit of
`Outside/OAI158Palette.lean` (docstrings and the header's notice of change: the module re-elaborates and so does every
module downstream of it), its block in `scripts/Axioms.lean` (lines "FS132-I2" … "FS132-I2: end of the block"), its
tools and data, its record. (The merge commit is the one commit of this job not made by explicit path: git refuses a
partial commit during a merge; the index held the merge's 81 files and nothing else — checked with `git status` before
it was concluded.)

**The merged tree, placeholders still present** — `build.sh` under the slot: exit 0, 25 modules rebuilt, 71 `sorry`
warnings, 9m14s (`data/fs132/i4/logs/build-1-merged.out`). No name clashes at this state: the placeholders are
`HadwigerNelson.SixRing.*`, the ported theorems `HadwigerNelson.Outside.OAI158.*`.

**The four statements, the placeholder's form beside the ported theorem's, as the kernel stores them.**
`data/fs132/i4/join/Compare.lean` → `Compare.out` (`lake env lean` on the merged tree, exit 0): for each short name the
stored type of `HadwigerNelson.SixRing.<name>` against that of `HadwigerNelson.Outside.OAI158.<name>`, by `Expr.equal`
(structural, with binder names and binder annotations) and by `==` (up to bound-variable names):

| statement | placeholder (`Plane/SixRing/Placeholders`, deleted) | ported (`Outside/…`) | `Expr.equal` |
|---|---|---|---|
| `palette_transfer_pair` | `{k} (c) (hc) (hw : WeakColoring k c) (x : ℂ) : ∀ᵐ p ∂angularMeasure.prod angularMeasure, c (angularSum x 1 p) ∉ palette c hc x p.1 ∪ palette c hc x p.2` | the same (`OAI158PaletteDensity`) | **IDENTICAL** |
| `palette_sixty_disjoint` | `{k} (c) (hc) (hw) (x) : ∀ᵐ f ∂angularMeasure, Disjoint (palette c hc x f) (palette c hc x (f + ↑sixty))` | the same (`OAI158PaletteTransport`) | **IDENTICAL** |
| `two_state_impossible` | `{k} {c} (hc) (hw) (x) (J K : Finset (Fin k)) (hcard : (Finset.univ \ (J ∪ K)).card ≤ 2) (s : Angles → Bool) (hs : Measurable s) (hJ : RealState hc x {t \| s ↑t = false} J) (hK : RealState hc x {t \| s ↑t = true} K) (hflip : ∀ᵐ t ∂angularMeasure, s (t + ↑(π / 3)) = !s t) : False` | the same (`OAI158States`) | **IDENTICAL** |
| `mem_spatialSupport_ae` | `{k} (c) (hc) (i : Fin k) : ∀ᵐ z : ℂ, c z = i → z ∈ spatialSupport c i` | the same (`OAI158AngularBoundary`) | **IDENTICAL** |

The eight `#check`s with full names are in `Compare.out` under the verdicts. Controls in the same run, both read
DIFFERENT as they must: one statement against another (`Expr.equal=false`), and a statement against itself with its
first binder's annotation flipped (`Expr.equal=false`, `==` true — so `Expr.equal` is the comparison that sees a binder
made implicit, and it is the one the verdicts use).

**The join.** `Plane/SixRing/Placeholders.lean` deleted (`git rm`); its import line out of `Proofs.lean`; its row out of
`ARCHITECTURE.md` § 3; its importers pointed at the ported modules — imports only:

| module | was | is |
|---|---|---|
| `ChartMeasure` | `Chart`, `Shift`, `Placeholders` | `Chart`, `Shift`, `Outside/OAI158PaletteDensity`, `Outside/OAI158AngularBoundary` |
| `Excl` | `Placeholders` | `Outside/OAI158PaletteTransport` |
| `TwoPairs` | `Excl` | `Excl`, `Outside/OAI158States` |
| `State` | `ChartMeasure`, `StepLemma` | the same and `Outside/OAI158PaletteTransport` |

(and one sentence of `State.lean`'s module docstring, which said "placeholders until the port's join").
**Every leaf or call site that had to change: none.** No statement, no proof term and no call site of any module was
touched: `TwoPairs.no_alternating_groups` calls the ported `two_state_impossible` with the argument list it called the
placeholder with, and `open Outside.OAI158` resolves the four short names as the planner's § 7.1 said it would.

**The joined tree** — `build.sh` under the slot: **exit 0**, 7 modules rebuilt (`ChartMeasure`, `Excl`, `Kill`, `State`,
`Orbit`, `TwoPairs`, `Proofs`), 8m52s, **68 `sorry` warnings** = 71 − the 3 placeholders (`Chart` 11, `ChartMeasure` 4,
`CyclicCentre` 3, `Excl` 2, `Kill` 2, `Shift` 7, `State` 8, `StepLemma` 8, `Tips` 7, `Winding` 16;
`data/fs132/i4/logs/build-2-join.out`).
`tools/check_architecture.py`: **exit 0**, `RESULT: PASS`, 330 rows against 330 modules, 0 import mismatches
(`logs/arch-2-join.out`). `./scripts/dupnames.sh` (slot, 16 GiB): **exit 0**, 1867 of 1867 package modules scanned, no
name declared by two modules, 23 generated on demand (`logs/dupnames-2-join.out`).

**The coordinator's relay, received while the join built** (from FS132-I3, branch `fs132-wi3`, at its commit
`6fe55ef78`: the step lemma's module proved; `volume_change_pairs_pos` lost `hS`, `exists_shiftMap` lost `huw`, under
the planner's permission (1); mine to decide whether to merge that commit now). **Decision: merge `fs132-wi3` at
`6fe55ef78` into this branch, next (stage 3)** — so that `exists_tip` is written once against the final binders and the
final merge of the two branches finds no call site to adjust; this branch writes neither `StepLemma.lean` nor
`Shift.lean`, so that branch's later commits merge over it without conflict.

## Stage 3 — SAVED (FS132-I4): the step lemma's branch merged; the palettes' module, the ring form's two leaves and the chart's null sets proved

**The second merge** (the coordinator's relay, stage 2's last paragraph). `git merge --no-ff 6fe55ef78` (branch
`fs132-wi3`, FS132-I3's stage 2): **automatic** — merge commit `ea51e2969`. It touches
`Proofs/HadwigerNelson/Plane/SixRing/StepLemma.lean` (every leaf proved there; `volume_change_pairs_pos` without `hS`,
`exists_shiftMap` without `huw`; `step_lemma` and `step_at_of_change` as the planner stated them), that job's record
`plans/FS132-I3-implementation.md` and its `data/fs132/i3/`; nothing else. `StepLemma.lean` is not edited on this
branch. Its row in `ARCHITECTURE.md` still reads "SKELETON" — FS132-I3's to rewrite; not touched here.

**Proved at this stage** (statements as the planner wrote them unless said; routes and what changed from the plan):

| leaf | module | route as built | against the planner's route |
|---|---|---|---|
| `ae_real_of_ae_angles` | `Excl` | `angleMk_quasiMeasurePreserving.ae` (ported) | as planned (its second option) |
| `exists_change_of_ae_outside` | `Excl` | `exists_inter_pos_of_ae_union` (new, `NullSets`): the two sets "locally null for `X`", "locally null for `Y`" are open, cover the line and are disjoint; the line is connected; neither palette set is null (`volume_liftPalette_ne_zero`, from the ported `palette_sixty_real`) | the planner's argument, on the two palette sets instead of on a state; **`hXY : X ≠ Y` dropped** (permission 1) |
| `measurableSet_liftPalette` | `State` | the ported `liftPalette_measurable` | found in the port (not a new proof) |
| `OutsideOrbit.ae_iff_not`, `.ae_flip` | `State` | clause (i) at `n` and at `n + 1` translated, with the ported **`palette_sixty_real`** (the real-line form of `palette_sixty_disjoint`, per label) | the planner pulled `palette_sixty_disjoint` back to `ℝ`; the port already holds the pulled-back form |
| `OutsideOrbit.change_at` | `State` | induction up and down from clause (ii) by `change_of_ae_flip` (new, `NullSets`) | as planned |
| `OutsideOrbit.chart_avoids` | `State` | `palette_transfer_pair` along `chartAngles_quasiMeasurePreserving`; two flips; clause (i) at `n − 1` and `n + 1` | as planned |
| `exists_tip` | `State` | `ae_chart_colour_mem` (new: no label outside a set `T` tips ⟹ the chart's colours lie in `T` near the hub) at `T = {X, Y}`, against `volume_change_pairs_pos` (called without `hS`) | as planned |
| `OutsideOrbit.hubColours`, `.hubColours_flip` | `State` | `ae_chart_colour_mem` at `T = {b, X, Y}` with `chart_avoids`; the flip is `hubColours` at `n + 1` reworded by `.ae_flip` | as planned |
| `chart_quasiMeasurePreserving` | `ChartMeasure` | `angularSum_quasiMeasurePreserving` (ported) after the linear change `chartAngles_quasiMeasurePreserving` (a skew product, measure preserving, then the ported `anglePair_quasiMeasurePreserving`) | the planner's first route, through `angularSum…` instead of `circleSum…` |
| `shear_quasiMeasurePreserving` | `ChartMeasure` | `shear_measurePreserving` (new, `NullSets`: `MeasurePreserving.skew_product` between two swaps) and a projection | as planned |
| `ae_ne_of_not_isTip` | `ChartMeasure` | as planned: a ball about the hub, `continuous_chart`, `chart_hub`, `dist_chart_lt_one`, `mem_spatialSupport_ae` through the chart | as planned |
| `unitPair_chart_ae` | `ChartMeasure` | **another route than the planner's.** No formula for the partner's direction and no `arccos`: the bad pairs `(z, t)` are null (weakness); so almost every chart point has a null set of bad directions (Fubini, the chart); for fixed `(α, d)` the partner `d' ↦ Z(α + ε + d' + π/3, d')` lies on the unit circle about `Z(α, d)` (`dist_chart_chart_shift`) and its distance from `p` is `ringRadius d'`, which falls at rate at least `1/4` (`ringRadius_sub_ge`), so the partner is `4`-antilipschitz in `d'` (`abs_dist_sub_le`); an antilipschitz map into the plane pulls sets of one-dimensional Hausdorff measure zero back to null sets (`volume_preimage_inter_le_hausdorff`, the release's `line_volume_preimage_bound` with any metric target), and the arc at a null set of directions has Hausdorff measure zero (`hausdorffMeasure_add_e_image_eq_zero`); Fubini again. This is the derivation's own sentence ("for fixed `z` the point `z′` moves along the unit circle about `z` with `|z′| = 2cos(π/3 + d′/2)` strictly decreasing in `d′`") | the planner's route went through the explicit direction `u = α + 2π/3 − d/2 − arccos(…)` and a `C¹` inverse; not built |

**Statements changed, each under the planner's permission (1)** (a hypothesis the proof does not use):
- `exists_change_of_ae_outside`: `(hXY : X ≠ Y)` dropped. Call site changed: `Orbit.not_ae_outside` (one argument
  removed; `Orbit.lean` is otherwise untouched). With `X = Y` the hypothesis is already contradictory.

**Helpers added** (permission 3; each under a name no other module declares — `dupnames` at stage 2 and at the last
stage): the module `Plane/SixRing/NullSets` (no colouring): `shear_measurePreserving`,
`quasiMeasurePreserving_triple_fst`, `_snd`, `_add`, `change_of_ae_flip`, `exists_inter_pos_of_ae_union`,
`volume_preimage_inter_le_hausdorff`, `lipschitzWith_add_e`, `hausdorffMeasure_add_e_image_eq_zero`,
`exists_pos_forall_le`; in `Excl`: `volume_liftPalette_ne_zero`; in `ChartMeasure`:
`chartAngles_quasiMeasurePreserving`, `ringRadius_sub_ge`, `ringRadius_pos`, `volume_partner_direction_eq_zero`; in
`State`: `OutsideOrbit.ae_mem_or`, `.ae_add_mem_or`, `ae_chart_colour_mem`.

**Searched before proving a helper** (the brief's item 3): the ported modules by statement shape — found and used
`liftPalette_measurable`, `palette_sixty_real`, `angleMk_quasiMeasurePreserving`, `anglePair_quasiMeasurePreserving`,
`angularSum_quasiMeasurePreserving`, `mem_spatialSupport_ae`, and `line_volume_preimage_bound` (the pattern of
`volume_preimage_inter_le_hausdorff`; the ported lemma is for maps `ℝ → ℝ`, the partner map is `ℝ → ℂ`). Mathlib:
`MeasurePreserving.skew_product`, `QuasiMeasurePreserving.prod_of_right`, `Measure.ae_prod_iff_ae_ae`,
`Measure.measure_ae_null_of_prod_null`, `AntilipschitzWith.hausdorffMeasure_preimage_le`,
`LipschitzWith.hausdorffMeasure_image_le`, `hausdorffMeasure_real`, `Real.norm_exp_I_mul_ofReal_sub_one_le`,
`measure_null_of_locally_null`, `isPreconnected_univ`. `exact?` on `exists_pos_forall_le`'s statement found nothing.

**Built**: `build.sh` under the slot — **exit 0**, 9 modules rebuilt, 9m11s, **46 `sorry` warnings**: `Chart` 11,
`CyclicCentre` 3, `Kill` 2, `Shift` 7, `Tips` 7, `Winding` 16 (`data/fs132/i4/logs/build-3-state.out`); none in
`NullSets`, `Excl`, `ChartMeasure`, `State`, `StepLemma`, `TwoPairs`, `Orbit`. `tools/check_architecture.py`: PASS
(`logs/arch-3.out`; the helper's row and import line added, four rows rewritten).

**Iteration** (never evidence): `data/fs132/i4/lean1.sh` elaborates one module against a symlink farm of the built
library and writes its `.olean` there, so that the next module can import it without a walk of the library (the
port's device). Every claim above is from `build.sh`.

**What these theorems rest on that is not yet proved** (so `#print axioms` shows `sorryAx` on some of them until lots
A and B land; the last stage prints each): `chart_eq_angularSum`, `continuous_chart`, `chart_hub`, `dist_chart_lt_one`,
`dist_chart_centre` (`Chart`, unassigned) and `dist_chart_chart_shift`, `measurable_shift` (`Shift`, FS132-I3's).

## Stage 4 — SAVED (FS132-I4): the relation with no double change, and the kill

**Proved at this stage** (`Plane/SixRing/Kill`; the module has no `sorry` of its own, and `chart_step_false`, the
planner's proof, now stands on proved leaves of this module):

| leaf | route as built | against the planner's route |
|---|---|---|
| `no_double_change` | the first hub's statement along the projection `(α, d, d') ↦ (α, d)`; the second hub's along the shear to `(α + ε + d', d')` (`HubColours.ae_partner`, from `HubColours.shift_back`: the second hub in the coordinates `(β, d')`, `β` the chart angle less `π/3`); where both pairs are split each point carries `b`; `unitPair_chart_ae` | as planned |
| `step_kill` | `step_kill_left` (the step falls: `θ ∈ S ↔ θ < t`) and the same after `HubColours.swap` (the two outside labels exchanged, `S` replaced by its complement; a rising step of `S` is a falling step of `Sᶜ` off the null set `{t}`). In `step_kill_left`, with `κ_3 = κ'/128`: (a) at the triples with `t − κ_3 < α < t`, `0 < d < κ_3`, `t − α < d' < 16(t − α)` the partner carries `b`, so `Z(α, d)` does not; Fubini over `d'` (`exists_mem_Ioo_of_ae`) gives it for almost every `(α, d)`; (b) so `V_0` carries `Y`; (c) the same from the other side at the triples with `h' = α + ε − t ∈ (0, κ_3)`, `h' < d < 16h'`, carried to the coordinates `(β, d', d)` by a measure-preserving shear and an exchange of the last two coordinates, then Fubini over `d`; so `V_1` carries `Y`; (d) for almost every triple with `0 < d, d' < κ'/256` and `t − ε < α < t` both points carry `Y` and are a unit pair: impossible, and for each `(d, d')` that set of `α` is an interval of length `ε > 0` | the derivation's (a)–(d) and the planner's constants (`κ_3 = κ'/128`); the planner's "as `no_double_change`, twice; `Measure.ae_prod_iff_ae_ae`; both orientations by the symmetry `(X, Y, S) ↔ (Y, X, Sᶜ)`" — as planned |

**Statements changed, each under the planner's permission (1)** (a hypothesis the proof does not use):
- `no_double_change`: `(hκ' : 0 < κ')` dropped (for `κ' ≤ 0` the box is empty). Call site changed: `chart_step_false`,
  in the same file (one argument removed).
- `step_kill`: `(hS : MeasurableSet S)` dropped — the proof asks measurability only of sets cut out by the colouring
  and the chart, never of `S` (FS132-I3's relay had said the step lemma needs no measurability of the shift; this is
  the same observation one step later: the kill needs none of `S`). Call site changed: `chart_step_false`, in the
  same file (one argument removed; `chart_step_false` keeps its own `hS`, which `step_lemma` reads).

No other statement of the skeleton was changed by this job. **All sixteen leaves of the brief are proved.**

**Helpers added** (permission 3): in `Kill`: `HubColours.swap`, `HubColours.shift_back`, `HubColours.ae_partner`,
`step_kill_left`; in `NullSets`: `exists_mem_Ioo_of_ae`.

**Two things met on the way** (for a successor on these files): `tauto` exhausts its heartbeats in the context of
`no_double_change` (a dozen hypotheses, two of them long implications) — the two case splits are written out; and
`rw` with `Measure.ae_prod_iff_ae_ae` does not find its pattern after a `filter_upwards` has beta-reduced the goal —
the lemma is applied by `refine (… (p := fun w => …) …).mpr ?_` with the predicate named.

**Built**: `build.sh` under the slot — **exit 0**, 8 modules rebuilt, 9m16s, **44 `sorry` warnings**: `Chart` 11,
`CyclicCentre` 3, `Shift` 7, `Tips` 7, `Winding` 16 (`data/fs132/i4/logs/build-4-kill.out`); none in any module this job
proves. `tools/check_architecture.py`: PASS (`logs/arch-4.out`).

**The coordinator's Amendment 1, received as this build ended** (the brief's last section, 2026-10-07 13:44 UTC):
merge the tip of `fs132-wi3` (`e9dd2f46`: the shift's module proved too) and replace the words of the two
`ARCHITECTURE.md` rows that still say "SKELETON" by that record's draft 1. Done at stage 5.

## Stage 5 — SAVED (FS132-I4): Amendment 1 (the finished branch merged, two rows), and the gate items on the sixteen leaves

**The third merge** (Amendment 1). `git merge --no-ff e9dd2f46` (the tip of `fs132-wi3`): merge commit `b844cbb73`. It
touches `Plane/SixRing/Shift.lean` (every leaf proved), three lines of `StepLemma.lean`, that job's record, report and
data, and `scripts/Axioms.lean` — **one conflict, there**: both branches append a block after the port's, at one
place. Resolved by keeping all three blocks in the order FS132-I2, FS132-I3, FS132-I4; no line of either side was
dropped (`git diff` against each parent shows additions only). Neither Lean file of that branch is edited here.
**The two rows** of `ARCHITECTURE.md` (`Plane/SixRing/Shift`, `Plane/SixRing/StepLemma`) reworded by that record's
draft 1, as written there. On Amendment 1's item (3): `Shift.chart_eq_polar_shift` and `Chart.chart_eq_polar` do not
collide (`dupnames` below).

**Built** (the last build of the sixteen leaves): `build.sh` under the slot — **exit 0**, 7 modules rebuilt, 9m42s,
**37 `sorry` warnings**: `Chart` 11, `CyclicCentre` 3, `Tips` 7, `Winding` 16
(`data/fs132/i4/logs/build-5-final.out`).

**The axioms of every theorem this job proved, from the built modules.** `data/fs132/i4/axioms/gen.py` writes
`Print.lean` from `targets.txt` (46 records: the 16 leaves, the 23 helpers, and 7 theorems the planner proved from
leaves); `lake env lean` on it after the build → `Print.out` (exit 0); `check.py` → `check.out`, **exit 0**. For each
record it reads `Lean.collectAxioms` and the record's *sorry frontier*: every declaration of this package under it
whose own stored term names `sorryAx`, with its module.
- **29 records on exactly `[propext, Classical.choice, Quot.sound]`**: the 11 helpers of `NullSets`; `Excl`'s three
  (`ae_real_of_ae_angles`, `volume_liftPalette_ne_zero`, `exists_change_of_ae_outside`);
  `chartAngles_quasiMeasurePreserving`, `shear_quasiMeasurePreserving`, `ringRadius_sub_ge`, `ringRadius_pos`;
  `measurableSet_liftPalette`, `OutsideOrbit.ae_mem_or`, `.ae_add_mem_or`, `.ae_iff_not`, `.ae_flip`, `.change_at`;
  `HubColours.swap`, `.shift_back`, `.ae_partner`; and the planner's **`no_alternating_groups`,
  `no_alternating_pairs`** (C132-DIAG-WIDE at the whole plane: sorry-free since the join).
- **17 records read `sorryAx`, each through leaves of `Chart` and `Tips` only** (the checker fails on a frontier
  declaration in any other module): the 13 of this job through `chart_eq_angularSum`, `continuous_chart`, `chart_hub`,
  `dist_chart_lt_one`, `dist_chart_centre`; the assembly (`no_outside_orbit_points`, `no_outside_orbit`,
  `not_ae_outside`) through those and `exists_adjacent_tips`, `exists_cycle_label`, `tip_unique`. `check.out` lists
  each with its leaves.
- **No outside theorem and no native axiom under any of the 46.**
- Controls, in the same run: `not_colorable_five` shows `no_proper_five_coloring`; `chromaticNumber_plane_eq_chiM0`
  shows `proper_to_borel_weak`; a `sorry` planted in `Print.lean` is found in the frontier of the theorem that uses
  it. `check.py --self-test` (`selftest.out`): 7 plants in the output — a `sorry` in a module this job proves, an
  outside theorem and a native axiom under a target, a target not printed, `sorryAx` with an empty frontier, the
  planted control and an outside control gone clean — **7 of 7 refused**.

**The block in `scripts/Axioms.lean`**, headed "FS132-I4": the 39 records of this job by module and the two of
`TwoPairs`; under CLEAN, so the landing's `axioms.sh` fails on the 13 until `Chart`'s leaves are proved — as it must.

| check | command | result | saved |
|---|---|---|---|
| the module map | `tools/check_architecture.py` | exit 0, `RESULT: PASS` | `logs/arch-5.out` |
| doubled names | `./scripts/dupnames.sh` (slot, 16 GiB) | **exit 0**: 1868 of 1868 package modules scanned, none doubled, 23 generated on demand | `logs/dupnames-5.out` |
| the environment linters | `slot.py --mem 8 -- lake lint --no-build -- --no-build --trace` | **exit 0**, `-- Linting passed for Proofs.`, 14 linters `(2/2) Passed!` | `logs/lint-5.out` |

Not run, by the brief: the full gate (`axioms.sh`, `vacuity.sh`, `assumptions.sh`, their self-tests) — the landing's.

**The coordinator's Amendment 2, received as this stage's build ended** (2026-10-07 13:49 UTC): the chart's module and
the tips' are added to this job's touches, with a stopping rule (about 420k by my own count, or three failed attempts
on one leaf). Stage 6 onward. Own count at this stage: about 320k (an estimate; no meter).
