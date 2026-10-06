# FS131-I6E — wave 6's bridge: what every fan carries (`FanBridge`'s five `Fan` lemmas)

*de Bruijn, the implementer (Opus 5.5), on branch `fs131-w6g` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g`, at
`d62406a2` when started (the branch as fast-forwarded by the brief's Amendment 1). Brief: `data/fs131/briefs/FS131-I6E-wave6-bridge.md`
(main tree; its Amendment 1 of 2026-10-06 is part of it). Started 2026-10-06.*

## Theorems this phase proved

*Filled stage by stage; each line names the declaration, its axioms as printed from the build's oleans, and the entry it was read against.
"Wired" means proved here over a leaf that is still `sorry` on this branch — not yet a kernel theorem.*

**Kernel theorems, on `[propext, Classical.choice, Quot.sound]`** (Stages 2–4; build `data/fs131/i6e/logs/build-2-four-leaves.log`, axioms
`data/fs131/i6e/logs/axioms-2.out`, whose control `AeColouring.gamma` reads `sorryAx`), all in `Plane/Saturated/FanBridge`, names under
`HadwigerNelson.Plane.`:
- **`AeColouring.Fan.two_le_n`** — FS131-E8-TWOSIDES, "if z is a singular point the fan has at least two branches" (the deriver's § 6.2 (4);
  FS131-E8-FAN's "at least two"). No saturation.
- **`AeColouring.Fan.col_ne`** — FS131-E8-TWOSIDES, "the regions on the two sides of each branch have different colours" (§ 6.2 (1)–(3)).
  No saturation. (`Fan.col_ne_aux` is the same statement, placed before `two_le_n`, which reads it at a fan with one branch.)
- **The three cell lemmas of a fan** (ruling 531 (c); no saturation): `AeColouring.Fan.isPreconnected_cell` (a cell is preconnected;
  `Fan.isPreconnected_polarRegion_of_le` is the form out to any radius `ρ ≤ F.r`), `AeColouring.Fan.cell_subset_densitySet` (it lies in its
  colour's density set), `AeColouring.Fan.exists_ray_subset_cell` (it holds the initial part of each ray strictly between its two limit
  directions). With them `Fan.isOpen_cell`, `Fan.mem_closure_polarRegion_of_le` (`z` is in the closure of each cell),
  `Fan.continuousOn_cyclicNext`.
- Children, § 6.2: `volume_essBoundary` (**the essential boundary of a measurable set is null** — Lebesgue's theorem for the set and its
  complement; this replaces the plan's "a continuous polar graph is null"), `AeColouring.volume_essBdry`;
  `Fan.exists_lower_of_pred`, `Fan.exists_isOpen_subset_cells` (§ 6.2 (2): near a branch point every point is on the branch or in one of the
  two cells beside it), `Fan.exists_isOpen_ae_two_colours`; `isConnected_ball_diff_singleton` (the punctured disc, for § 6.2 (4)).
- Children, polar coordinates about a point: `fanAngle` (a definition: the polar angle in the lift near `θ₀`), `polarPt_dist_fanAngle`,
  `fanAngle_polarPt`, `continuousAt_fanAngle`, `image_polarPt_mem_nhds` (the polar map is open off the centre), `isOpen_setOf_polar_lt`,
  `polarRegion_eq_image`, `polarRegion_isOpen`, `polarRegion_isPreconnected`, `polarPt_add_two_pi`, `polarRegion_mono`,
  `mem_closure_polarRegion`.
- Children of the two branch leaves that rest on no open leaf: `IsUnitCurve.reverse` (a curve run backwards), `dist_sq_polarPt_add`,
  `re_e_mul_conj_I_mul_e`, `re_e_mul_conj_e_eq_cos`, `dist_sq_polarPt_add_I`, `dist_sq_polarPt_sub_I`, `eq_I_mul_or_eq_neg_of_re_eq_zero`,
  `dist_sq_polarPt_polarPt_add_I`, `eventually_dist_polarPt_lt_one`, `AeColouring.eq_or_eq_of_mem_essClosure`,
  `Fan.eq_add_or_eq_sub_of_dist_eq_one` (a branch on a unit circle has its centre at `z ± i e(dir i)`).

**Wired** (axioms `[propext, sorryAx, Classical.choice, Quot.sound]` on this branch; no `sorry` of mine under them):
- **`AeColouring.Fan.branch_outside_discs`** — FS131-E8-OUTSIDE on the branch (the deriver's § 6.3; the plan's § 10.2 (L), the lens). Over
  `gamma` and `IsUnitCurve.exists_polarGraph` only (not `beta`, not `alpha`) — both proved on `fs131-w6f` at `8e81fedd`.
- **`AeColouring.Fan.branch_contacts`** — **FS131-E8-BRANCH** (the deriver's § 6.1), its docstring amended: the alternative is inclusive.
  Over `gamma`, `IsUnitCurve.exists_polarGraph`, and `Pinch`'s `pinch`, `c11_split`, `TwoColourOn.essBoundary_inter_eq` (line P).
- Their children: `Fan.exists_unitCurve_branch` (**the branch is a unit-speed curve from `z` with initial tangent `e(dir i)`**: over
  `gamma`, `exists_polarGraph`), `Fan.exists_twoColourNhd_branch` (over `TwoColourOn.essBoundary_inter_eq`),
  `Fan.dist_eq_one_of_common_contact` (§ 6.1 Case A; over `pinch`, `c11_split`), `Fan.contacts_of_no_common` (§ 6.1 Case B at one point;
  over `pinch`).

## What I may and may not change

- **Mine**: the proofs of five leaves of `Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean`, in `namespace AeColouring.Fan` —
  `two_le_n`, `col_ne`, `branch_outside_discs`, `branch_contacts`, `sector_alone`; new helper declarations under names no other module
  declares, placed after the header `## What every fan carries under saturation` and before `namespace Fan`, or between my own leaves —
  never above `gamma`; one docstring line of `branch_contacts` (its alternative is inclusive: the deriver's § 6.1); a block "FS131-I6E" in
  `scripts/Axioms.lean`; this record; `tools/fs131_i6e_*.py`; `data/fs131/i6e/`; `data/fs131/reports/FS131-I6E.md`.
- **Not mine**: any statement or definition; the seven other leaves of `FanBridge` (`gamma`, `IsUnitCurve.exists_polarGraph`, `beta`,
  `alpha`, `fan_of_isolated`, `regJLiteral_of_saturated`, `finite_arcs_of_isBounded` — another implementer's, on `fs131-w6f`; they stay
  `sorry` here, and my theorems that rest on `gamma` and `exists_polarGraph` are **wired**, not kernel theorems, until that branch
  lands); `Basic`, `Pinch`, `MapColouring`, `Fan`, `FanExamples`, `Curve`, `LocalGraph`; the planners' record; `main`. No `axiom`, no
  `native_decide`. No merge, no gate.
- **Owned by ruling 531 (c)** (Amendment 1): the three cell lemmas of a fan, each a declaration of its own, named in the report.

## Stage 1 — SAVED (FS131-I6E): the readback, the as-given build, the statement check, the expectations

**Quotations** (standing rule 3): `tools/fs131_i6e_quotes.py` — 23 quotations, 23 exact (`data/fs131/i6e/logs/quotes-1.out`); with
`--plant` it reports one mismatch and exits 1 (`quotes-1-plant.out`).

**Read, in order**: the brief and its amendment; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` §§ Building, Make the gate
fail; `FanBridge.lean`, `Fan.lean`, `Basic.lean`, `Pinch.lean` whole; the statements of `Curve.lean`, `LocalGraph.lean`,
`FanExamples.lean` (their proofs not read); the planners' record Stages 9–12 whole; the deriver's record Stage 3 (§§ 3.1–3.8, with the
erratum and the note) and Stage 6 (§§ 6.1–6.5) whole; `plans/FS121-V2-verification.md` §§ 1.3–2.4 whole. Not read: the planners'
Stages 1–8 (the first pass's Stages 3 and 5 are superseded for my leaves by Stage 9, which I read), the other FS-121 arguments.

**The as-given build** (`d62406a2`): OK — 466 of 466 batches, 4 modules rebuilt, 3 modules with warnings, exit 0
(`data/fs131/i6e/logs/build-0-as-given.log`, the driver's; the tool's full output copied to `build-0-as-given-full.log`). Twenty distinct
`declaration uses sorry` warnings: `FanBridge` 12 (five mine), `Pinch` 7, `MapColouring` 1 — as Amendment 1 says.

**The statement check** (`tools/fs131_i6e_statements.py`, base `d62406a2`): the 17 statements of `FanBridge` verbatim; the seven leaves
that are not mine still `sorry`; the seven files that are not mine byte-identical; no `axiom`, no `native_decide` — 0 failures
(`logs/statements-1.out`); `--plant` reports one `CHANGED` and exits 1. It allows docstring lines to change and nothing between
`theorem` and `:=`.

**Registered expectations** (before any proof was compiled; informed by the plan and the deriver's Stage 6):

| # | expectation |
|---|---|
| Z1 | `two_le_n` and `col_ne` close in one stage with no polar-coordinates integral: the branch is null because the essential boundary of a measurable set is null (Lebesgue's theorem for the set and its complement), not by the plan's image-of-a-graph route — 0.8 |
| Z2 | none of the five statements is false or short of a hypothesis — 0.85 (the deriver checked them) |
| Z3 | `branch_outside_discs` and `branch_contacts` are **wired** over `gamma` and `IsUnitCurve.exists_polarGraph` only (not `beta`, `alpha`) — 0.9 |
| Z4 | the plan's price for the first two leaves (1 d each) is high by a factor of three or more — 0.7 |
| Z5 | I close four of the five leaves inside the budget, `sector_alone` at least to its three cell lemmas and Lemma H — 0.5 |
| Z6 | `sector_alone` needs `θ₁ ≤ π` nowhere: the positive-angle case closes from the two edge contacts and the cyclic order alone — 0.6 (my sketch) |

## Stage 2 — SAVED (FS131-I6E): `two_le_n` and `col_ne`, with the three cell lemmas; the price re-read

**The route** (the deriver's § 6.2, with one step replaced). (1) *A branch is null*: not by polar coordinates. The branch lies in the
essential boundary, and **the essential boundary of a measurable set is null** (`volume_essBoundary`: a point of `A` off `Ã` is in the null
set `A ∖ Ã`; a point of `Aᶜ` with `d̄_A > 0` is no density point of `Aᶜ`, in the null set `Aᶜ ∖ (Aᶜ)~`). No integral, no image of a graph.
(2) *The local picture*: the polar map is open off the centre (`image_polarPt_mem_nhds`, through the continuous local angle `fanAngle`),
so the polar region between the branch before `i` (or the last branch a turn back: `Fan.exists_lower_of_pred`) and the branch after `i` is
an open set about a point of branch `i`, inside cell `j` ∪ branch `i` ∪ cell `i`. (3) Equal colours make that open set a.e. of one colour,
its points density points, against `notMem_essBdry_of_mem_densitySet`. (4) `n = 0`: the punctured disc is connected (the image of
`(0, r) × ℝ` under the polar map), `ae_one_colour_of_isConnected` gives one colour, `z` is a density point of it and outside every other
class's support. `n = 1`: `col_ne` at `i = j = 0`.

**A build that failed, and what it found.** `build-1-two-sides.log`: FAIL at `Proofs.lean` — my helper `polarAngle` is a definition of
`Plane/ValidMap/RadialPush`, which `FanBridge` does not import (the module compiled; the import surface did not). Renamed `fanAngle`;
`tools/fs131_i6e_names.py` now compares every name this job adds with every declaration head in `Proofs/` and on the other implementer's
branch (41 new names, 0 collisions, one allowed: `IsUnitCurve.reverse` beside `IsArcOf.reverse`; `--plant` adds `polarAngle` and exits 1;
`logs/names-2.out`). **Inventory**: `RadialPush.polarAngle` and `fanAngle` are one definition in two modules that do not import each
other (and `fs131-w6f`'s `FanBuild` re-derives the same angle inline): a shared home upstream of both (`Plane/LocalStructure`, beside
`polarPt`) would make one.

**Amendment 2 (the coordinator, mid-job): not merged.** When it arrived, the proofs of `branch_outside_discs` and `branch_contacts` were
written against `gamma` and `IsUnitCurve.exists_polarGraph` as stated, so the three facts it offers were not needed. Two of my names were
on its list — `isOpen_polarRegion`, `isPreconnected_polarRegion`, **the same statements** as `fs131-w6f`'s in `FanBuild` — and are renamed
`polarRegion_isOpen`, `polarRegion_isPreconnected` here; `IsUnitCurve.continuousOn` was in my scratch file only and is not declared (its
three uses are inlined). **At the join**: delete my two `polarRegion_*` lemmas and point their six uses at `FanBuild`'s
(`isOpen_polarRegion`, `isPreconnected_polarRegion`); nothing else of mine meets a name of that branch.

**Re-pricing** (the brief's ask). The plan priced `two_le_n` and `col_ne` at a day each; they closed, with the three cell lemmas and the
polar-coordinates children, in one elaboration after four one-line fixes. `branch_outside_discs` (1 d) and `branch_contacts` (1.5 d) were
written in one pass and closed after eight one-line fixes over two elaborations. The planner's factor of two to three is an underestimate
for these four: the prices were high by more than an order of magnitude. Not re-priced by them: nothing — `sector_alone` is stage 5.

## Stage 3 — SAVED (FS131-I6E): `branch_outside_discs` (wired)

`Fan.exists_unitCurve_branch`: with `R = min F.r (1/2)`, the setting `IsolatedAt z R` holds (`F.singular`, `hsat.mono`); the branch out to
`R` is preconnected and lies in the essential boundary of the punctured disc, so it lies in the component `gamma` describes,
`γ '' (0, L)`; `z` is in its closure, so in the compact `γ '' [0, L]`, at an end (the open arc misses `z`); run the curve from `z`
(`IsUnitCurve.reverse` if the end is `L`); `IsUnitCurve.exists_polarGraph` makes the arc a polar graph about `z` with angle tending to
`ψ 0`, the two polar angles give one direction at every distance below `R`, so `e(ψ 0) = e(dir i)` in the limit and the arc *is* the branch
out to `R`. Then `IsUnitCurve.one_le_dist`. The deriver's finding (ii) is followed: `beta` is not read.

## Stage 4 — SAVED (FS131-I6E): `branch_contacts` (wired), its docstring amended

The deriver's § 6.1, its two cases, as an inclusive alternative (no proof splits on the two types as exclusive: the split is on *some
branch point below `R` has a common contact of the two colours*, or none has).
- **The colours of the two-colour ball** (`Fan.exists_twoColourNhd_branch`): a class with positive upper density at a branch point is one
  of the two beside the branch (`AeColouring.eq_or_eq_of_mem_essClosure`, on stage 2's open set), and the two classes of a two-colour
  neighbourhood are essential-boundary classes there (`TwoColourNhd.mem_essBoundary`) and differ.
- **Case A** (`Fan.dist_eq_one_of_common_contact`; no saturation, no bound `1/2` — the deriver's (iii)): `pinch` with the pair of contacts
  `(y, y)` cannot be its tangent case (`y − x = −(y − x)` puts `y` at `x`), so the point is of split type, `c11_split` puts the essential
  boundary of its ball on the unit circle about `y`, and the set of such `t` is open and closed in `(0, F.r)`. Then
  `Fan.eq_add_or_eq_sub_of_dist_eq_one`: `|z − y| = 1` in the limit, `⟨e(φ i t), y − z⟩ = t/2 → 0`, so `y − z ⊥ e(dir i)`.
- **Case B** (`Fan.contacts_of_no_common`, at one point `γ s` of the branch's curve): distinct contacts give `pinch`'s tangent case with
  normal `ν = y_a − γ s`. *`ν ⊥ T`*: the curve near `s` is essential boundary inside the two-colour ball, so outside the open unit disc
  about `γ s + ν` (an open set a.e. of one colour); `|γ − (γ s + ν)|²` has a local minimum at `s`, and its derivative there is
  `−2⟨ν, e(ψ s)⟩` (Fermat). *The sign* — the step the deriver's sentence "the tangent has a positive radial component, so `iT` has a
  positive component along increasing angle" stands for: if `ν = −i e(ψ s)`, the disc about `γ s + i e(ψ s)` is a.e. of the clockwise
  colour; but `IsUnitCurve.sin_le_inner` gives `t cos(φ i t − ψ s) ≥ sin s > 0`, so the point `z + t e(φ i t + η)`, `η > 0` small, lies
  in that disc (`eventually_dist_polarPt_lt_one`: `|w − c|² = 1 − 4t sin(η/2)(cos(κ + η/2) − t sin(η/2))`), in the ball, and in the
  counter-clockwise cell — an open set a.e. of both colours (`TwoColourOn.false_of_mem_inter`). So `ν = i e(ψ s)`; let `s → 0⁺`, supports
  are closed.

**Checks** (stages 2–4 share them): build **OK — 466 of 466 batches, 2 modules rebuilt, exit 0** (`logs/build-2-four-leaves.log`); 16
`declaration uses sorry` left on the branch: `FanBridge` 8 (the other implementer's seven and `sector_alone`), `Pinch` 7, `MapColouring` 1.
Axioms (`data/fs131/i6e/I6eAxioms.lean`, output `logs/axioms-2.out`): control `sorryAx`; 39 records on the standard three; 6 wired.
Statement check against `d62406a2`: 17 statements verbatim, the seven other leaves still `sorry`, seven files byte-identical, 0 failures
(`logs/statements-2.out`). `scripts/Axioms.lean`: a block "FS131-I6E" with the 39 clean records.
