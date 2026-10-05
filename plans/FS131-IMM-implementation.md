# FS131-IMM — wave 4's MERGE (`exists_merge_aux`) in `Plane/ValidMap/MergeMove`

*The record of FS131-IMM1 (de Bruijn, the implementer, on Opus), branch `fs131-w4mm` cut from `fs131-w4m` at `73d31ad6`, in the worktree
`.claude/worktrees/fs131-w4mm`. Brief: `data/fs131/briefs/FS131-IMM1-merge.md` (on `main`). Report: `data/fs131/reports/FS131-IMM1.md`.*

## Theorems this phase proved

Kernel-checked in this job's stage-3 build (`build/gate/build/20261005T010522Z-5176.log`), axioms printed against that build's oleans
(`lake env lean data/fs131/imm/AxiomsIMM.lean`, `data/fs131/imm/axioms-stage3.txt`), all in `Proofs/HadwigerNelson/Plane/ValidMap/MergeMove.lean`, each
reading exactly `[propext, Classical.choice, Quot.sound]` (`exists_merge_aux` reads `sorryAx` besides — the print's positive control):

- `HadwigerNelson.Plane.ArcMap.dist_ne_one_of_isOpen_isClear` — [kernel], the standard three — an open set of clear points meets no unit circle about the closure of the class
- `HadwigerNelson.Plane.ArcMap.add_mem_allowedCone` — [kernel], the standard three — `D_c(v)` is closed under sums
- `HadwigerNelson.Plane.ArcMap.smul_mem_allowedCone` — [kernel], the standard three — `D_c(v)` is closed under non-negative multiples
- `HadwigerNelson.Plane.ArcMap.clear_of_push` — [kernel], the standard three — **N3-CLEAR at a boundary direction, by N3-UP** (FS110-W-MERGE's cusp-end clearance, exact)
- `HadwigerNelson.Plane.dot_e_eq_cos_sin` — [kernel], the standard three — the dot product against `e θ` in coordinates
- `HadwigerNelson.Plane.norm_sub_smul_e_sq` — [kernel], the standard three — `‖u − τ e θ‖²` in coordinates, `τ = ±1`
- `HadwigerNelson.Plane.push_alg` — [kernel], the standard three — the planar step of the contacts' split
- `HadwigerNelson.Plane.ArcMap.push_contacts_of_mem_allowedCone` — [kernel], the standard three — the contacts at a boundary direction of `D_c(v)`
- `HadwigerNelson.Plane.tanHeight_hgt` — [kernel], the standard three — the tangent arc over the abscissa `X`
- `HadwigerNelson.Plane.abs_hgt_le` — [kernel], the standard three — its height is at most `|κ| X²`
- `HadwigerNelson.Plane.sign_sub_hgt` — [kernel], the standard three — the sign of `tanHeight` on a vertical line
- `HadwigerNelson.Plane.e_add_sigma_pi_div_two` — [kernel], the standard three — `e (θ + σπ/2) = σ e (θ + π/2)`
- `HadwigerNelson.Plane.sigma_tanHeight_nonneg` — [kernel], the standard three — the side of a germ in polar form
- `HadwigerNelson.Plane.push_decomp` — [kernel], the standard three — the germ's point on the perpendicular through a point near it
- `HadwigerNelson.Plane.ArcMap.clear_near_end` — [kernel], the standard three — **clearness at an end of a gap** (interior: N3-CLEAR; boundary: the push)


### FS131-IMM2 (stage 5; build `build/gate/build/20261005T060420Z-1825986.log`, axioms `data/fs131/imm/axioms-stage5.txt`, all in `MergeMove`)

- `BranchGerms.idx_zero` — [kernel], the standard three
- `BranchGerms.turns_zero` — [kernel], the standard three
- `BranchGerms.lift_zero` — [kernel], the standard three
- `BranchGerms.next_idx` — [kernel], the standard three
- `BranchGerms.turns_succ` — [kernel], the standard three
- `BranchGerms.lift_succ` — [kernel], the standard three
- `BranchGerms.lift_succ'` — [kernel], the standard three
- `BranchGerms.κ_idx_succ` — [kernel], the standard three
- `BranchGerms.e_lift` — [kernel], the standard three
- `BranchGerms.liftDir_eq` — [kernel], the standard three
- `BranchGerms.liftDir_succ` — [kernel], the standard three
- `BranchGerms.branchPt_idx` — [kernel], the standard three
- `BranchGerms.mem_sector_idx` — [kernel], the standard three
- `BranchGerms.liftDir_lt_succ` — [kernel], the standard three
- `BranchGerms.liftDir_mono` — [kernel], the standard three
- `BranchGerms.lift_mono` — [kernel], the standard three
- `BranchGerms.idx_add_n` — [kernel], the standard three
- `BranchGerms.turns_add_n` — [kernel], the standard three
- `BranchGerms.lift_add_n` — [kernel], the standard three
- `BranchGerms.exists_idx_eq` — [kernel], the standard three
- `BranchGerms.idx_ne` — [kernel], the standard three
- `cross_e_e` — [kernel], the standard three
- `cone_smul_mem_interior` — [kernel], the standard three
- `cone_add_mem_interior` — [kernel], the standard three
- `cone_eq_univ_of_zero_mem_interior` — [kernel], the standard three
- `cone_mem_interior_of_arc` — [kernel], the standard three
- `cone_half_plane` — [kernel], the standard three
- `cone_mem_interior_of_between` — [kernel], the standard three
- `cone_side` — [kernel], the standard three
- `gap_assemble` — [kernel], the standard three
- `ArcMap.Near.exists_tile_of_sector` — [kernel], the standard three
- `ArcMap.Near.pos_of_hasSectors` — [kernel], the standard three
- `ArcMap.Near.e_mem_allowedCone_of_col` — [kernel], the standard three
- `ArcMap.Near.branchPt_lift` — [kernel], the standard three
- `ArcMap.Near.base_before` — [kernel], the standard three
- `ArcMap.Near.base_after` — [kernel], the standard three
- `ArcMap.Near.gap_clear` — [kernel], the standard three
- `ArcMap.Near.exists_gap` — [kernel], the standard three

Definitions: `BranchGerms.idx`, `turns`, `lift`, `liftDir` (spec examples beside them). The interface for the rest is `ArcMap.Near.exists_gap` (record § 4.1–4.2 proved).

Still open: `exists_merge_aux`'s two leaves (§ 9).

### FS131-IMM3 (stage 7; build `build/gate/build/20261005T071525Z-2257155.log`, axioms `data/fs131/imm/axioms-stage7.txt`, all in `MergeMove`)

Each [kernel], reading exactly `[propext, Classical.choice, Quot.sound]` except `mem_gapGerm`, `mem_gapSec` (axiom-free):
`BranchGerms.mem_gapGerm`, `mem_gapSec`, `exists_rep`, `idx_inj`, `idx_mem_gapGerm_iff`, `idx_mem_gapSec_iff`, `phantom_idx_succ_iff`, `liftDir_add_n`;
`ArcMap.Near.Small.half`, `Small.mono`, `dist_branchPt`, `outer_subset`, `mem_outer`, `norm_of_mem_sector`, `mem_sector_of_lt`, `sector_mono`,
`sector_subset_interiorPts`, `not_mem_branch_of_mem_sector`, `sector_disjoint`, `eq_of_mem_branch`, `branchPt_not_mem_sector`,
`mem_gapSet_of_mem_sector`, `branchPt_mem_gapSet_iff`, `mergeCol_of_mem_sector`, `mergeCol_branchPt`, `mergeCol_of_not_mem`, `carrier_rimArc`,
`rimArc_nondegenerate`, `mem_mergeArcs`, `germ_half_subset`, `outer_subset_germ`, `mergeArcs_cases`, `germ_subset_closedBall`,
`mergeArcs_nondegenerate`, `mergeArcs_finite`, `mergeArcs_subset_closedBall`, `mergeArcs_unit`, `mergeArcs_condition5`, `exists_next_eq`,
`ball_cases`, `v_mem_mergeArcs`, `branchPt_mem_mergeArcs_inner`, `branchPt_mem_mergeArcs_outer`, `mem_mergeArcs_rim`, `liftDir_gap_germ`,
`exists_dir_of_mem_gapSec`, `branchPt_rim_mem_trimArcs`, `gap_sides`, **`merge_hlc`** (49 theorems). Restated: `ArcMap.Near.exists_gap`
(clause `b < X.n`, ruling 344 (a)). Definitions: `BranchGerms.gapGerm`, `gapSec`, `branch`, `gapSet`, `Phantom`, `mergeCol`, `rimArc`,
`mergeArcs` (spec examples beside them).

### FS131-IMM3 (stage 8; build `build/gate/build/20261005T073602Z-2376652.log`, axioms `data/fs131/imm/axioms-stage8.txt`, all in `MergeMove`)

Each [kernel], reading exactly `[propext, Classical.choice, Quot.sound]`: `ArcMap.Near.mergeCol_mem_coloursAt`, `mem_mergeArcs_inner`,
`gap_sides_idx`, `mem_chain`, `sector_subset_chain`, `isPreconnected_chain`, `mem_merge_interiorPts_iff`, `mem_interiorPts_of_merge_rim`,
**`merge_agreesOff`**, **`merge_ringArcsWithin`**, **`merge_condition5`**, **`merge_coloursAt_self`**, **`merge_valid`**, **`merge_hasSectors`**,
**`merge_coloursAt_rim`**, **`merge_ncard_coloursAt_rim`** (16 theorems). Definition: `ArcMap.Near.chain` (spec examples beside it).

### FS131-IMM3 (stage 9; build `build/gate/build/20261005T074636Z-2448915.log`, axioms `data/fs131/imm/axioms-stage9.txt`)

No new kernel theorem: `exists_merge_aux`'s body is the assembly, sorry-free, over the two **open leaves** `ArcMap.Near.merge_not_hasRepeatedColour_rim`
and `ArcMap.Near.merge_allowedCone` (each `sorry`, in `MergeMove`); its axioms read `sorryAx` through them.


### FS131-IMM4 (stage 11; build `build/gate/build/20261005T081907Z-2639896.log`, axioms `data/fs131/imm/axioms-stage11.txt`, all in `MergeMove`)

Each [kernel], reading exactly `[propext, Classical.choice, Quot.sound]`: `tanHeight_combo`, `side_ineq`, `isPreconnected_side_plane`,
`frame_mul_e`, `isPreconnected_side`, `isPreconnected_of_two_sides`, `ArcMap.Near.sides_preconnected` (**the sides lemma**),
`ArcMap.encard_sectorsOf_le_one`, `ArcMap.Near.norm_of_mem_rimArc`, `ArcMap.Near.mergeCol_of_mem_sector_out`,
`ArcMap.Near.mem_merge_interiorPts_of_mem`, `ArcMap.Near.branchPt_mem_merge_interiorPts_iff`, and the leaf
**`ArcMap.Near.merge_not_hasRepeatedColour_rim`** (13 theorems).

### FS131-IMM4 (stage 12; build `build/gate/build/20261005T083812Z-2758320.log`, axioms `data/fs131/imm/axioms-stage12.txt`, all in `MergeMove` unless named)

Each [kernel], reading exactly `[propext, Classical.choice, Quot.sound]`: `exists_step_of_strictMono`, `ArcMap.finite_tiles_ball_of_goodAt`,
`ArcMap.IsTile.mem_of_mem_closure`, `ArcMap.Near.gapSec_of_mem_rimArc`, `chain_subset_ball`, `isOpen_chain`, `isClear_chain`,
`closure_gapSet_subset`, `merge_region_of_region`, `merge_region_cases`, `closure_merge_region`, `chain_subset_merge_region`,
`v_mem_closure_merge_tile`, `merge_exists_tile`, `merge_tile_split`, `merge_tile_cover`, `merge_isContact_iff`, `merge_inType_iff`,
`merge_outType_iff`, and the leaf **`ArcMap.Near.merge_allowedCone`** (20 theorems); with them **`HadwigerNelson.Plane.ArcMap.exists_merge_aux`
(in `Moves`) reads exactly the standard three** — MERGE has no `sorry` beneath.

## Stage 1 — SAVED: the readback, the as-given build

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation (a prefix, cut with `…`) | source | result |
|---|---|---|
| "theorem exists_merge_aux (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)" | `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean` l. 584 (this branch) | **verbatim** |
| "Choose two `c`-sectors consecutive along `D_c(v)`'s arc of directions with the gap between them inside `D_c(v)` (the `c`-sectors' cones lie in `D_c(v)`," | `plans/FS131-IM-implementation.md` l. 305 (§ 3.4, this branch) | **verbatim** |
| "above it, item 262 (a)). About 1.5 sessions. **MERGE (`exists_merge_aux`)**: the run cut again, in a gap of `D_c(v)`, but **without** the full" | the same, l. 453 (§ 6.3) | **verbatim** |
| "269. **Ruling on item 268: `exists_merge` and `exists_merge_aux` take `F'.coloursAt v ⊆ F.coloursAt v` in place of the off-rim clause.** Choice: IM2 replaces the" | `plans/FS131-close-inventory.md` l. 1958 (on `main`) | **verbatim** |
| "285. **Ruling: I5c's slot → the parallel MERGE implementer FS131-IMM1 on a new branch `fs131-w4mm`; wave 5's next implementer takes the next slot.** Choice: as" | the same, l. 2141 | **verbatim** |
| "**It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the" | `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 14.2, l. 887 | **verbatim** |

Read: the IM record's §§ 3 and 6 and IM3's Stages 7–9 (this branch), and — by the coordinator's message after launch — IM3's § 10.1 on
`fs131-w4m` (`.claude/worktrees/fs131-w4m/plans/FS131-IM-implementation.md`), which I found independently before reading it: `Near.move` and
`Near.exists_cut` add the whole circle `∂B(v, ρ)`, so neither serves MERGE; and the rim clause `¬ F'.HasRepeatedColour x` fails at the rim
crossing of any germ at `v` with one colour on both sides unless that germ is cut just inside the rim. The audit records go just above the
`=== PURCHASED ===` banner (IM3's § 8.2).

### 1.2 The branch builds as given

`73d31ad6`, under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): **OK**, 446 of 446 batches, 11
modules rebuilt (the copied `.lake/build` came from an older tree: `Basic`, `Sectors`, `StuckChain`, `SVMap`, `Cone`, `Contact`, `Surgery`, `UnitArc`,
`Moves`, `BaseSteps`, `Proofs`), 10 min 24 s; warnings only `declaration uses 'sorry'` — `Moves` 2 (l. 573 `exists_rayMerge_aux`, l. 584
`exists_merge_aux`), `Contact` 4, `BaseSteps` 7, `UnitArc` 17. Log `build/gate/build/20261005T002608Z-3882202.log`; terminal output
`data/fs131/imm/build-asgiven.log`.

## Stage 2 — SAVED: `MergeMove` created; `Moves` imports it

`Proofs/HadwigerNelson/Plane/ValidMap/MergeMove.lean` (importing `Plane/ValidMap/Surgery` only) holds MERGE's children; `Moves` gains the line
`import Proofs.HadwigerNelson.Plane.ValidMap.MergeMove` beside its `Surgery` import (kept, so `tools/fs131_im_split.py --check` still reads
`Moves` as importing `Surgery`); `Proofs.lean` imports it after `Surgery`; `ARCHITECTURE.md` gains its row and `Moves`' Imports cell names
it; `scripts/Axioms.lean` gains the block "FS-131 wave 4, `MergeMove` (job FS131-IMM1)" just above the `=== PURCHASED ===` banner.
**No child goes into `Surgery`**: the brief allows new declarations at its end, but `tools/fs131_im_split.py --check` holds `Surgery` byte
for byte to header + IM2's block + footer, so every child of MERGE lives in `MergeMove` (and `fs131-w4mm` merges with `fs131-w4m`'s
`Surgery` without conflict).

First children (sorry-free): `ArcMap.dist_ne_one_of_isOpen_isClear` (an open set of points clear for `c` meets no unit circle about a
point of the closure of `c`'s class — what the `D_c(v′)` clause needs of the recoloured region), `ArcMap.add_mem_allowedCone`,
`ArcMap.smul_mem_allowedCone` (`D_c(v)` is a convex cone).

Checks: `tools/check_architecture.py` PASS (before the row was added it failed exactly on "missing: ['Plane/ValidMap/MergeMove']" — the
module-coverage control); `tools/fs131_im_split.py --check` PASS; `tools/fs131_im_statements.py --check` PASS (diffs empty).
**Build** (under the slot, as in § 1.2): **OK**, 446 of 446 batches, 3 modules rebuilt (`MergeMove` 1.4 s, `Moves` 3.2 s, `Proofs`); warnings
only `declaration uses 'sorry'` — `Moves` 2 (l. 574 `exists_rayMerge_aux`, l. 585 `exists_merge_aux`), `Contact` 4, `BaseSteps` 7, `UnitArc`
17; none in `MergeMove`. Log `build/gate/build/20261005T005242Z-4094929.log`; terminal output `data/fs131/imm/build-stage2.log`.
Iteration: `data/fs131/imm/iter.sh` elaborates a scratch file against a private olean mirror `build/imm-mirror` (never evidence; a planted
`example : (1:ℕ) = 2 := rfl` was reported, so the mirror checks).

## Stage 3 — SAVED: the gap's clearness at its ends (N3-UP made exact), in `MergeMove`

**Proved** (in `MergeMove`, sorry-free; listed under "Theorems this phase proved"):

- `ArcMap.clear_of_push` — **N3-CLEAR at a boundary direction, by N3-UP.** If every contact `w` of `c` at `v` has a margin `μ` at the
  direction `e α` (`dot (e α) (w − v) ≥ μ` in-type, `≤ −μ` out-type), or is in-type within `1/2` of `v + e γ`, or out-type within `1/2` of
  `v − e γ`, then near `v` every point `z₀ + τ e γ` (`τ ≥ 0`) pushed from a closure point `z₀` of a `c`-tile at `v`, along a direction within
  `μ/2` of `e α`, is clear for `c`. N3-CLEAR's proof (`clear_of_subset_interior_allowedCone`) with its margin step split three ways: margin
  contacts as there; in-type tiles near `v + e γ` by the lens (`lens_dist_lt_one_of_up`), from `dist z₀ y < 1` (the dichotomy
  `unitNear_of_mem_closure` against the tile at `v`, strict by `ne1_region`); out-type tiles near `v − e γ` by the lune (`lune_dist_le_of_up`).
  FS110's sentence "every point of `G` near `a` lies directly `+n`-above a point of that horn, which is a `c`-tile and so clear, hence clear
  by N3-UP" needs no horn: the base point may be any closure point of a `c`-tile at `v` — in use, the gap's bounding germ.
- `ArcMap.push_contacts_of_mem_allowedCone` — if `e α` and `e (α + σψ)` (`σ = ±1`, `0 < ψ < π`) lie in `D_c(v)`, the contacts are as
  `clear_of_push` needs, with `μ = min (sin ψ / 2) (1/4)` and `γ = α + σπ/2` (planar step `push_alg`; coordinates `dot_e_eq_cos_sin`,
  `norm_sub_smul_e_sq`).
- `hgt κ X` (the tangent arc's height over the abscissa `X`, the small root of `tanHeight κ X y = 0`), `tanHeight_hgt`, `abs_hgt_le`,
  `sign_sub_hgt` (the sign of `tanHeight` on a vertical line is the sign of `Y − hgt`), with a spec example; `e_add_sigma_pi_div_two`,
  `sigma_tanHeight_nonneg`, and `push_decomp`: a point `v + s e φ` within `π/4` of `θ` on the side `σ` of the germ `(θ, κ)` is
  `z₀ + τ e (θ + σπ/2)` with `τ ≥ 0` and `z₀` the germ's branch point on the same perpendicular, at distance in `(0, 5s/4]`.
- `ArcMap.clear_near_end` — **clearness at an end of a gap**: if `e θ ∈ int D_c(v)`, or `e θ ∈ D_c(v)` with a direction `e (θ + σψ)` of
  `D_c(v)` on the side `σ`, and the germ `(θ, κ)` lies near `v` in the closure of a `c`-tile at `v`, then near `v` every point at a
  direction within `ε` of `θ`, on the side `σ` of the germ, is clear for `c`.

**Re-priced from the first two children** (standing order): `clear_of_push` (≈ 170 lines) and `push_contacts_of_mem_allowedCone`
(≈ 110) took about 25k tokens of work, two or three fix rounds each; one heartbeat death (a `clear_near_end` draft with every step in one
declaration; LEAN.md's `nlinarith` rule) was repaired by splitting out `push_decomp` and `sigma_tanHeight_nonneg`. Faster than feared; the
whole of MERGE remains larger than IM2's "about two sessions" (§ 4 below).

## 4. What is left, and the plan (for whoever continues; no statement changes)

**Verdict on the statement**: believed **TRUE** as written (ruling 269's form); no defect found. The rim clause
`¬ F'.HasRepeatedColour x` forces annulus cuts (IM3's § 10.1 finding, found here independently), and the `D_c(v′)` clause needs the
recoloured region's closure to stay off far unit circles — both are construction choices, not hypotheses. Everything below is in
`X : F.Near v` (`exists_near`), with `{i | X.col i = c}.encard = n + 1` (`Near.encard_col_eq`), `K := F.allowedCone v c`.

**4.1 The gap's choice and `K`'s geometry** (≈ 400 lines). If `K = univ`, any two consecutive `c`-sectors. Otherwise pick `e θ₀ ∈ int K`;
then `e θ* ∉ K` for `θ* = θ₀ + π` (a child: `d ∈ int K`, `−d ∈ K` ⇒ `0 ∈ int K` ⇒ `K = univ`). Let `i*` be the chart sector whose cone holds
`θ*` (`BranchGerms.exists_angle`; it is not a `c`-sector, since `c`-cones lie in `K`, `coneAt_subset_allowedCone`), `p` the first `c`-sector
after `i*` along `next`, `q` the next `c`-sector after `p`, `q = next^M p` (`1 ≤ M`); gap sectors `next^m p` (`0 < m < M`, colours `≠ c`), gap
germs `J = {next^m p | 1 ≤ m ≤ M}`. Lift directions along the orbit: `Λ 0 = β p`, `Λ (m+1) = Λ m + (nextβ − β)(next^m p)`, so
`e (Λ m) = e (β (next^m p))` and sector `next^m p` is `sectorBetween v (Λ m) κ_m (Λ (m+1)) κ_{m+1} r` (a child: `sectorBetween` is invariant
under shifting both directions by `2πk`). `θ₁ = Λ 1` (germ `next p`), `θ₂ = Λ M` (germ `q`), both directions of `K`; and `θ₂ < θ*′ + 2π` for the
lift `θ*′` of `θ*` in `[Λ_{i*} 0, Λ_{i*} 1]` (needs the full-turn bound `Λ n ≤ Λ 0 + 2π` along the orbit from `i*`). Then: if `θ₂ − θ₁ < π`,
`e θ ∈ K` on `[θ₁, θ₂]` and `e θ ∈ int K` on `(θ₁, θ₂)` (children: `e θ = a e θ₁ + b e θ₂`, `a, b ≥ 0`, by `add_/smul_mem_allowedCone`; for the
interior, the coefficients `A(d) = cross(d, e θ₂)/sin(θ₂ − θ₁)`, `B(d) = cross(e θ₁, d)/sin(θ₂ − θ₁)` are continuous and `{A > 0, B > 0} ⊆ K` is
open); if `θ₂ − θ₁ = π`, `K ⊇` the open half-plane on the gap's side (`d₀ ∈ int K` lies there, else `e θ* ∈ K`); if `> π`, the complementary arc
`(θ₂, θ₁ + 2π)` is shorter than `π` with ends in `K` and holds `θ*` — contradiction. End witnesses: nondegenerate gap, `ψ = min (θ₂ − θ₁) (π/2)`;
degenerate (`θ₁ = θ₂`, `e θ₁ ∉ int K`), a side `σ` with `e (θ₁ + σψ) ∈ K` from `d₀` (neither `σ` fails, else `e θ₁ ∈ int K`).

**4.2 The gap's clearness** (≈ 150 lines). `clear_near_end` at `θ₁` (`σ = 1`, base germ `next p ⊆ cl (sector p)`, by
`branchPt_mem_closure_sector_before`, in the `c`-tile of sector `p`) and at `θ₂` (`σ = −1`, base germ `q ⊆ cl (sector q)`,
`branchPt_mem_closure_sector_after`); the middle `Icc (θ₁ + ε₁) (θ₂ − ε₂) ⊆ (θ₁, θ₂)` by N3-CLEAR; a gap point at radius `s` has direction in
`[germDir θ₁ (nextκ p) s, germDir θ₂ (κ q) s]`, and for small `s` the end lemmas' `|φ − θ| ≤ ε` follows from `exists_abs_arcsin_lt`. In the
degenerate case one end lemma covers the whole gap. Output: `ρ_c > 0` with every gap point at radius `< ρ_c` clear for `c`.

**4.3 The map `F'`** (≈ 500 lines; `Near.move` and `Near.exists_cut` add the whole circle `∂B(v, ρ)`, so they are not used). Radii: `ρ`
with `X.Small ρ`, `ρ < ρ_c`; `ρ₁ = ρ/2`. A germ `j` is *phantom* when `X.col (prev j) = X.col j`. New arcs `A`: `X.germ ρ₁ j` for `j ∉ J`;
`Arc.outer (X.germ ρ j) v ρ₁` (the germ over `[ρ₁, ρ]`, `Arc.outer_spec`) for every non-phantom `j`; the rim arcs
`Arc.circ v ρ₁ (dir i ρ₁) (nextDir i ρ₁)` over the gap sectors `i` (non-degenerate: `hord`, and `nextDir ≤ dir + 2π` — a child from `hdisj`).
**No arc on `∂B(v, ρ)`.** Colouring: `c` on `N₀ = (gap sectors ∪ gap germs' branches) ∩ B(v, ρ₁) ∖ {v}`; `X.col j` on each phantom germ `j`'s
branch over `(ρ₁, ρ)`; `F.col` elsewhere. `F' = F.surgery v ρ A col' …`; its local constancy cannot use `surgery_hlc_of` (the rim is not on
`A`): off `B̄(v, ρ)` it is `F`'s; on the rim a point on no arc of `F'` is on no germ, so `F`-interior with `col' = F.col` near it; inside, by
cases (a sector; a gap germ's branch below `ρ₁`; a phantom branch in the annulus; the circle of radius `ρ₁` off the rim arcs), each by
`exists_ball_subset_of_branchPt`.

**4.4 The clauses.** *Valid*: `Valid.of_agreesOff` — `N₀` clear by 4.2, phantom points clear for their colour (`isClear_of_mem_closure`,
`isClear_col`), the recoloured set inside `B(v, 1/2)`. *AgreesOff, RingArcsWithin, Condition 5*: `surgery_agreesOff`, `surgery_ringArcsWithin`
(new unit arcs are germ arcs or their pieces, `⊆ F.Γ`; rim arcs have radius `ρ₁ < 1`), `surgery_condition5`. *HasSectors v c n*: at `r < ρ₁` the
interior points are the sectors `i ∉ J ∪ gap` and the merged piece `⋃_{m ≤ M} sector (next^m p) ∪ ⋃_{1 ≤ m ≤ M} branch (next^m p)` (open by
`exists_ball_subset_of_branchPt`, preconnected by induction on `m` as `cut_hasSectors`' `hMpre`), counted by `encard_sectorsOf_of_partition`.
*`v` gains no colour*: as `move_coloursAt_self`. *The rim* (`x ∈ sphere v ρ`; `F' = F` near `x` but for cut phantoms): (R1) `x` on no germ:
interior, one sector; (R2) `x` on a non-phantom germ `j`: the pieces `sector (prev j) ∩ B(x, r)`, `sector j ∩ B(x, r)`, two colours;
(R3) `x` on a phantom germ: one piece (the two sides chained through the cut branch), one colour. Both need **the sides lemma**: for
`x = branchPt` of germ `j` at `s < s₀` and small `r`, `sector j ∩ B(x, r)` and `sector (prev j) ∩ B(x, r)` are preconnected. Route:
`C = {tanHeight κ_j (frame β_j) = 0}`; `C ∩ B(x, r)` lies on the branch (`eq_branchPt_of_tanHeight_eq_zero`, `frameX > 0` near `x`); the side
`{tanHeight > 0}` is convex for `κ ≥ 0` (`tanHeight` concave), `{tanHeight < 0}` convex for `κ ≤ 0`; the other side is a ball minus a closed
disc whose circle passes through `x`, star-shaped about `x + (r/2R)(x − o)` when `9r < 4R` (checked: `f(t) ≥ (1−t)(R + r/2)² + tR² −
t(1−t)(3r/2)² > R²`); each side lies in one sector (preconnected, interior), so each sector `∩ B` is one side. *`D_c(v′)` unchanged*
(≈ 400 lines): `coloursAt v′` agree (open complement of `B̄(v, ρ)`); contacts agree because `cl N₀ ⊆ {v} ∪ R′` with `R′` the merged piece at
radius `ρ_c` (open, every point clear: sectors by `isClear_col`, gap by 4.2, bounding germs by closure), so `dist_ne_one_of_isOpen_isClear`
keeps `R′` off `ω(v′)`; types agree: an `F`-`c`-tile lies in an `F'`-`c`-tile, and an `F'`-`c`-tile `T′` with `w ∈ cl T′`, `w ≠ v`, contains an
`F`-`c`-tile with `w` in its closure (`w ∉ cl N₀`; phantom points are limits of their sectors' points in `T′`; only finitely many `F`-tiles
lie in `T′`, each touching `B̄(v, ρ) ⊆ dom` — `finite_tiles_near` and compactness), while `T′` misses `ω(v′)` (`ne1_region` for `F'`) and so
lies on that tile's side; for `w = v`, `T′` meets a `c`-sector at `v` or `N₀`, whose `F'`-component holds sector `p`.

**4.5 The price.** About 2000–2500 further lines: 4.1 ≈ 400, 4.2 ≈ 150, 4.3 ≈ 500, 4.4 ≈ 1200, assembly ≈ 150 — two to three of my
sessions at this stage's rate.

### 3.1 The build and the axioms of this stage

Under the slot, as in § 1.2: **OK**, 446 of 446 batches, 3 modules rebuilt (`MergeMove` 14 s, `Moves` 2.7 s, `Proofs`); warnings only
`declaration uses 'sorry'` — `Moves` 2 (`exists_rayMerge_aux`, `exists_merge_aux`), `Contact` 4, `BaseSteps` 7, `UnitArc` 17; none in
`MergeMove`. Log `build/gate/build/20261005T010522Z-5176.log`; terminal output `data/fs131/imm/build-stage3.log`. **Axioms** against that
build's oleans (`data/fs131/imm/axioms-stage3.txt`, 16 records): the 15 children read exactly `[propext, Classical.choice, Quot.sound]`;
`exists_merge_aux` reads `sorryAx` besides. No `axiom`, no `native_decide`. The 15 records are in `scripts/Axioms.lean`'s FS131-IMM1 block
(above the PURCHASED banner). `tools/fs131_im_statements.py --check` PASS (diffs empty), `tools/fs131_im_split.py --check` PASS,
`tools/check_architecture.py` PASS. Scratch files (`data/fs131/imm/scratch/`) are working copies, now in `MergeMove`.

## Stage 4 — SAVED (FS131-IMM2): the readback, the as-given build

*FS131-IMM2 (de Bruijn, the implementer, on Opus) continues this record from here; brief `data/fs131/briefs/FS131-IMM2-merge.md` (on `main`).*

### 4.0.1 The brief's quotations against their sources (standing rule 3)

Checked by script (exact substring search), each **verbatim**:

| quotation (a prefix) | source | line |
|---|---|---|
| "theorem exists_merge_aux (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)" | `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean` (this branch) | 585 |
| "**Verdict on the statement**: believed **TRUE** as written (ruling 269's form); no defect found. The rim clause" | this record § 4 | 109 |
| "**4.1 The gap's choice and `K`'s geometry** (≈ 400 lines). If `K = univ`, …" | this record § 4 | 114 |
| "**4.3 The map `F'`** (≈ 500 lines; `Near.move` and `Near.exists_cut` add the whole circle …" | this record § 4 | 134 |
| "294. **FS131-IMM1 done at its line, MERGE not yet proved** …" | `plans/FS131-close-inventory.md` (on `main`) | 2255 |
| "269. **Ruling on item 268: …**" | the same | 1958 |
| "286. **FS131-IM3 handed back** …" | the same | 2148 |
| "295. **Ruling: MERGE leaves wave 4; …**" | the same | 2274 |
| "337. **Ruling on I5j's slot: MERGE's continuation, FS131-IMM2, …**" | the same | 2839 |
| "**It may**: add children anywhere in the wave's modules — …" | `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 14.2 | 887 |

Read: this record in full, inventory items 269, 286, 294, 295, 337.

### 4.0.2 The branch builds as given

`7060fcc6`, under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): **OK**, "all 1748 modules already
up to date, nothing built", 2 s; warnings only `declaration uses 'sorry'` (`Moves` l. 574 `exists_rayMerge_aux`, l. 585 `exists_merge_aux`;
`Contact`, `BaseSteps`, `UnitArc` as before). Log `build/gate/build/20261005T054213Z-1726483.log`; terminal output
`data/fs131/imm/build-asgiven-imm2.log`. The scratch copies `data/fs131/imm/scratch/{Push,End,Gap}.lean` are deleted (each of their 13 declarations
checked present in `MergeMove` by name first).

## Stage 5 — SAVED (FS131-IMM2): the gap's choice and its clearness (record § 4.1–4.2), in `MergeMove`

**Proved** (in `MergeMove`, sorry-free, 38 theorems and 4 definitions; listed under "Theorems this phase proved"). The interface every later
part reads is one theorem:

> `ArcMap.Near.exists_gap (hF : F.Valid) (hv : F.Covers v 1) {c} {n} (hn1 : 1 ≤ n) (hn : F.HasSectors v c (n + 1)) (hD : (interior (F.allowedCone v c)).Nonempty) :`
> `∃ s : Fin X.n, ∃ a b : ℕ, a < b ∧ b < a + X.n ∧ X.col (idx s a) = c ∧ X.col (idx s b) = c ∧ (∀ m, a < m → m < b → X.col (idx s m) ≠ c) ∧`
> `∃ ρc > 0, ∀ t ∈ Ioo 0 ρc, ∀ φ, X.G.liftDir s (a + 1) t ≤ φ → φ ≤ X.G.liftDir s b t → F.IsClear c (v + t * e φ)`

that is: two `c`-sectors `idx s a`, `idx s b`, consecutive along the orbit of `next`, and every point of the gap between them near `v`
(directions from germ `idx s (a + 1)` to germ `idx s b`, lifted) clear for `c`. Its parts:

- **The orbit and its lifts** (`BranchGerms.idx s m = (s + m) mod n`, `turns`, `lift`, `liftDir`): `next_idx`, `lift_succ`/`lift_succ'`
  (one step adds `nextβ − β`), `lift_add_n` (a full turn adds `2π`), `lift_mono`, `liftDir_lt_succ`/`liftDir_mono` (strict where the germs are
  ordered), `e_lift`, `branchPt_idx`, `mem_sector_idx` (sector `idx s m` in lifted directions), `exists_idx_eq`, `idx_ne` (injective within
  a turn). Lifts are by the closed form `β (idx s m) + 2π ⌊(s + m)/n⌋`, so the recursion and the full turn are lemmas, not definitions.
- **The directions of a convex cone** (stated for any `K` closed under sums and non-negative multiples, applied to `D_c(v)` by IMM1's
  `add_mem_allowedCone`, `smul_mem_allowedCone`): `cone_smul_mem_interior`, `cone_add_mem_interior`, `cone_eq_univ_of_zero_mem_interior`;
  `cone_mem_interior_of_arc` (an open arc shorter than `π` with ends in `K` is interior — Cramer's coefficients, an open quadrant inside `K`);
  `cone_half_plane` (`±u ∈ K` and a point of `K` on the left of `u` put the whole open left half-plane in `K`, interior when the point is);
  **`cone_mem_interior_of_between`**: `e θ₁, e θ₂ ∈ K`, `e θs ∉ K`, `θs < θ₁ ≤ θ₂ < θs + 2π` ⟹ `e θ ∈ int K` on `(θ₁, θ₂)` — by cases
  `θ₂ − θ₁ < π` (Cramer), `= π` (the half-plane; an interior point on the wrong side would put `e θs` in `K`), `> π` (the complementary arc
  is shorter than `π` and holds `θs + 2π`: contradiction); **`cone_side`**: a direction of `K` (int `K ≠ ∅`) is interior or has a direction
  of `K` at `θ ± ψ`, `0 < ψ < π` (via `arg (d₀ · conj (e θ))`).
- **The gap's clearness**: `gap_assemble` (a property near each end of `[germDir θ₁ κ₁ t, germDir θ₂ κ₂ t]` and on each closed middle
  interval holds on the whole gap for small `t`; the ends tend to `θ₁, θ₂` by `exists_abs_arcsin_lt`); `Near.base_before`/`base_after`
  (the bounding germs lie in the closure of the `c`-sectors' tiles, `exists_tile_of_sector`); `Near.gap_clear` — IMM1's `clear_near_end` at
  `θ₁` (side `+1`, base germ `idx s (a+1)`) and at `θ₂` (side `−1`, base germ `idx s b`), N3-CLEAR (`clear_of_subset_interior_allowedCone`)
  on the middle; when `θ₁ = θ₂` one end lemma covers the gap, on the side `cone_side` names.
- **The choice** (`exists_gap`): if `D_c(v) = ℂ`, any `c`-sector and the next one (`Nat.find`), clear by N3-CLEAR on a padded interval.
  Otherwise `e θs ∉ D_c(v)` for `θs = arg u`, `u ∉ D_c(v)`; `exists_angle` puts `θs` (mod `2π`) in the closed cone of a chart sector `s`,
  which is therefore not a `c`-sector (`e_mem_allowedCone_of_col`); `a` is the first `c`-sector after `s`, `b` the next (`Nat.find` twice,
  `a ≥ 1`, `b < X.n`); then `θs ≤ lift s 1 ≤ θ₁ ≤ θ₂ ≤ lift s X.n = β s + 2π ≤ θs + 2π`, strict at both ends since `e θ₁, e θ₂ ∈ D_c(v)`.
  `pos_of_hasSectors`: two sectors of one colour force a germ (with none the punctured ball is one sector), so `0 < X.n`.

**Re-priced from the first two parts** (standing order): 4.1 + 4.2 came to about 650 lines against IMM1's 400 + 150 — the cone geometry
was stated once for any convex cone, which kept each case short; no heartbeat death. At this rate 4.3 + 4.4 are about 1,300–1,600 lines
(§ 5.2's list), two of my sessions.

### 5.1 The build, the axioms, the checks

Under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): **OK**, 446 of 446 batches, 3 modules rebuilt (`MergeMove` 15 s, `Moves` 2.5 s, `Proofs`), 8 min 27 s; warnings only `declaration uses 'sorry'` (`Moves` l. 574 `exists_rayMerge_aux`, l. 585 `exists_merge_aux`; `Contact`, `BaseSteps`, `UnitArc` as before), none in `MergeMove`. Log `build/gate/build/20261005T060420Z-1825986.log` ("Build completed successfully (5363 jobs)"); terminal output
`data/fs131/imm/build-stage5.log`. **Axioms** against that build's oleans (`lake env lean data/fs131/imm/AxiomsIMM.lean`,
`data/fs131/imm/axioms-stage5.txt`): 54 records: the 53 theorems of `MergeMove` (IMM1's 15 and these 38) read exactly `[propext, Classical.choice, Quot.sound]`; `exists_merge_aux` reads `sorryAx` besides — the print's positive control, so the print sees a `sorry` where one is. `tools/fs131_im_statements.py --check` PASS (diff empty); `tools/fs131_im_split.py --check` PASS;
`tools/check_architecture.py` PASS. New tool **`tools/fs131_imm_decls.py`** (`--check`: every theorem of `MergeMove`, by full name with its
namespaces resolved, has a `#print axioms` line in `scripts/Axioms.lean` and in `data/fs131/imm/AxiomsIMM.lean`): PASS, 53 theorems;
`--self-test` fires on all three planted faults (a dropped record, namespace resolution, a mismatched `end`). The 38 new records are in
`scripts/Axioms.lean`'s FS131-IMM1 block after the line `-- FS131-IMM2`, above the PURCHASED banner. No `axiom`, no `native_decide`, no
statement changed.

### 5.2 What is left, and the plan (refined from § 4.3–4.4; for whoever continues)

`exists_merge_aux` is still `sorry`. Everything below takes `exists_gap`'s output, `X.Small ρ`, `ρ < ρc`, and writes `ρ₁ = ρ/2`.
**First, an easy strengthening of my own lemma**: `exists_gap` proves `b < X.n` in both cases; restate its clause `b < a + X.n` as `b < X.n`
(the index lemmas below need `a < X.n`).

**Definitions, on the chart's plain data** (so each can have a spec example; drafted, uncompiled against the new oleans, in
`data/fs131/imm/wip/B.lean`): `BranchGerms.gapGerm s a b = {idx s m | a < m ≤ b}`, `gapSec s a b = {idx s m | a < m < b}`,
`G.branch v r j = branchPt '' Ioo 0 r` (= `Near.cutSet`), `G.gapSet v s a b r` (gap sectors and gap germs' branches out to `r`),
`Phantom col j` (the two sides of germ `j` have one colour), `G.mergeCol v col Fcol s a b c ρ` (`c` on `gapSet ρ₁`; on any branch out to
`ρ`, the colour of the sector after its germ — so the colouring never mentions phantoms; `Fcol` elsewhere), `G.rimArc` (`circ v ρ₁` from
`liftDir s (a+1) ρ₁` to `liftDir s b ρ₁`), `G.mergeArcs` (germ arcs out to `ρ₁` off `gapGerm`; `Arc.outer (germArc … ρ) v ρ₁` for the
non-phantom germs; the rim arc when `a + 1 < b`). With `a + 1 = b` the single gap germ `idx s b` is phantom (both sides `c`) and is cut in
all of `B(v, ρ)`.

**4.3 the map** `F' = F.surgery v ρ (mergeArcs) (mergeCol) …`: (i) the arcs: non-degenerate, finite, inside `B̄(v, ρ)`, unit ones in `F.Γ`,
Condition 5 (as `newArcs_*`); the outer pieces lie on the branch over `[ρ₁, ρ]` and cover it over `(ρ₁, ρ]` (`outer_subset`, `mem_outer`,
drafted) — the point at `ρ₁` is not needed, since there a non-phantom gap germ is on the rim arc and every other germ on its inner arc;
(ii) membership in the new arcs inside `B(v, ρ)` by radius (`v`; a germ off the gap at `t ≤ ρ₁`; a non-phantom germ at `t ∈ [ρ₁, ρ]`; the rim);
(iii) the colouring on sector points (`c` iff a gap sector below `ρ₁`, else the sector's colour) and branch points (`c` iff a gap germ below
`ρ₁`, else the colour after the germ), by `sector_disjoint`, `eq_of_branchPt_eq`; (iv) **the rim germ points lie on `trimArcs`**: the branch
over `(ρ, s₀)` is on `F`'s arcs outside `B̄(v, ρ)`, covered by `trimArcs` (`trimArcs_spec`), finitely many of which meet a neighbourhood
(`F.locallyFinite`, `trimArcs ⊆ F.arcs ∪ T`), so their union is closed there; (v) `hlc`, by cases: off `B̄(v, ρ)` as `surgery_hlc_of`'s third
case; on the rim, a point off the arcs is on no germ (iv), hence in a chart sector, colour constant; inside, a sector point (gap sector below
or above `ρ₁` — at `ρ₁` it is on the rim arc — or another sector), or a branch point (a gap germ below `ρ₁`: the ball of
`exists_ball_subset_of_branchPt` meets only `c`-coloured pieces; at `ρ₁` only when `a + 1 = b`; above `ρ₁` only a phantom germ, both sides one
colour). Germ indices are read at a representative `m ∈ [a + 1, a + 1 + X.n)`, so `prev (idx s m) = idx s (m − 1)` (`exists_rep`, `idx_inj`,
`idx_mem_gapGerm_iff`, `phantom_idx_succ_iff`, drafted).

**4.4 the clauses.** *AgreesOff, RingArcsWithin, Condition 5*: `surgery_agreesOff`, `surgery_ringArcsWithin`, `surgery_condition5`. *Valid*:
`Valid.of_agreesOff` on `B̄(v, ρ)` — gap points clear by `exists_gap` (a gap sector point has its lifted direction in `[liftDir (a+1),
liftDir b]` by `mem_sector_idx` and `liftDir_mono`), sector points by `isClear_col`, and every branch point clear for the colour after its
germ (`isClear_of_mem_closure` on the sector after it) — one rule for phantom and rim points; pairs inside are closer than `1`. *`v` gains no
colour*: every `F'`-interior point of `B(v, ρ)` has a colour some chart sector has, and each chart sector's colour is at `v`. *HasSectors
v c n*: at `r < ρ₁` the pieces `A i` (`i : Fin X.n`) = the merged sector `sector (idx s a) ∪ sector (idx s b) ∪ gapSet r` at `i = idx s a`,
`∅` at the other merged indices, `sector r i` elsewhere; the merged piece is open (sectors, and `exists_ball_subset_of_branchPt` at gap
branch points) and preconnected by induction along the chain `m = a, …, b` (each gap germ's branch is in the closure of the sectors on both
its sides, as `cut_hasSectors`' `hMpre`); count `1 + ((n + 1) − 2) = n` by `encard_sectorsOf_of_partition`. *The rim* (`x ∈ ∂B(v, ρ)`, a
small ball about `x` misses `B̄(v, ρ₁)`): `F'.coloursAt x ⊆ F.coloursAt x` (≤ 2, `ncard_coloursAt_le_two`), and no repeated colour — (R1) `x` on
no germ: one interior piece; (R2) `x` on a non-phantom germ: `F' = F` near `x`, two pieces of two colours; (R3) `x` on a phantom germ: one
piece, the two sides joined through the cut branch inside `B(v, ρ)`. Both need **the sides lemma**: for the germ's circle `∂B(o, R)` (or line)
through `x` and `r ≤ R/2`, `B(x, r) ∩ B(o, R)` is convex and `B(x, r) ∖ B̄(o, R)` is star-convex about `x + (r/2)(x − o)/R` (from
`‖(1−t)y + tz − o‖² = (1−t)‖y−o‖² + t‖z−o‖² − t(1−t)‖y−z‖²`, `‖y − o‖ = R + r/2`, `‖y − z‖ < 3r/2`: the excess is `(1−t)r(R − 2r) ≥ 0`); with
`−(2/κ) tanHeight = ‖z − o‖² − 1/κ²` these are the two sides `{tanHeight ≷ 0}`, and each lies in one of the two chart sectors beside the germ
(connected, inside their disjoint union), different ones since both sectors reach `x` — so no sign bookkeeping. *`D_c(v′)` unchanged* for
`v′ ∉ B̄(v, ρ)`: coloursAt `v′` agree (a neighbourhood of `v′` misses `B̄(v, ρ)`); `F.region c ⊆ F'.region c ⊆ F.region c ∪ gapSet ρ₁ ∪`
(branches of germs with colour `c` after them, in the closure of `F.region c`), so the contacts agree because `closure (gapSet ρ₁) ⊆ {v} ∪
mergedSet ρ`, an open set of points clear for `c` (`dist_ne_one_of_isOpen_isClear`); types: the easy direction by `F`-tile ⊆ `F'`-tile; the
other by — an `F'`-`c`-tile `T′` misses `ω(v′)` (`ne1_region` for `F'`), its closure points off `closure (gapSet ρ₁)` are closure points of
`T′ ∩ F.region c` (a cut-branch point of `T′` has a convex `F'`-interior ball inside `T′`), and `T′ ∩ F.region c` is a finite union of
`F`-tiles: a tile of `T′` whose closure misses `B̄(v, ρ)` is clopen in `T′`, hence `T′` itself, and the others meet a finite cover of the
compact `B̄(v, ρ)` by `finite_tiles_near` balls.

## Stage 6 — SAVED (FS131-IMM3): the readback, the as-given build

*FS131-IMM3 (de Bruijn, the implementer, on Opus) continues this record from here; brief `data/fs131/briefs/FS131-IMM3-merge.md` (on `main`).*

### 6.1 The brief's quotations against their sources (standing rule 3)

Checked by script (exact substring search), each **verbatim**:

| quotation (a prefix) | source | line |
|---|---|---|
| "theorem exists_merge_aux (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)" | `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean` (this branch) | 585 |
| "**First, an easy strengthening of my own lemma**: `exists_gap` proves `b < X.n` in both cases; …" | this record § 5.2 | 305 |
| "**Definitions, on the chart's plain data** (so each can have a spec example; …" | this record § 5.2 | 308 |
| "**4.3 the map** `F' = F.surgery v ρ (mergeArcs) (mergeCol) …`: (i) the arcs: …" | this record § 5.2 | 317 |
| "343. **FS131-IMM2 handed back** …" | `plans/FS131-close-inventory.md` (on `main`) | 2905 |
| "344. **Rulings on IMM2's held items, and its slot.** …" | the same | 2922 |
| "347. **FS131-I5l handed back** …" | the same | 2956 |
| "348. **Ruling on item 347: MERGE returns to wave 5's path; …**" | the same | 2978 |
| "269. **Ruling on item 268: …**" | the same | 1958 |
| "294. **FS131-IMM1 done at its line, MERGE not yet proved** …" | the same | 2255 |
| "**It may**: add children anywhere in the wave's modules — …" | `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 14.2 | 887 |

Read: this record in full (IMM1's §§ 1–4, IMM2's §§ 4.0–5.2), inventory items 269, 294, 343–348, the draft `data/fs131/imm/wip/B.lean`, and
`Surgery`'s surgery API (`trimArcs`, `surgery`, `surgery_agreesOff`, `surgery_ringArcsWithin`, `surgery_condition5`, `surgery_hlc_of`).

### 6.2 The branch builds as given

`045c71c6`, under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): **OK**, "all 1748 modules already
up to date, nothing built", 2 s; warnings only `declaration uses 'sorry'` (`Moves` l. 574 `exists_rayMerge_aux`, l. 585 `exists_merge_aux`;
`Contact`, `BaseSteps`, `UnitArc` as before). Log `build/gate/build/20261005T070047Z-2176958.log`; terminal output
`data/fs131/imm/build-asgiven-imm3.log`.

## Stage 7 — SAVED (FS131-IMM3): `exists_gap` restated; MERGE's definitions; 4.3 (i), (ii), (iii), (iv), (v) — the map's arcs, colouring and local constancy

**`exists_gap`'s clause restated** (ruling 344 (a)), its diff in `MergeMove`:

```
-    ∃ s : Fin X.n, ∃ a b : ℕ, a < b ∧ b < a + X.n ∧ X.col (BranchGerms.idx s a) = c ∧
+    ∃ s : Fin X.n, ∃ a b : ℕ, a < b ∧ b < X.n ∧ X.col (BranchGerms.idx s a) = c ∧
```

and in its docstring "`a < b < a + n`" → "`a < b < n`". The proof is unchanged (both cases' `by omega` already read `b < X.n` from `Nat.find`'s spec).

**Definitions** (IMM2's draft `data/fs131/imm/wip/B.lean`, now in `MergeMove`, the draft deleted), with spec examples beside them: `gapGerm`, `gapSec`,
`branch`, `gapSet`, `Phantom`, `mergeCol`, `rimArc`, `mergeArcs`. The map is `F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ)
(X.G.mergeCol v X.col F.col s a b c ρ) …` with no new definition for it: every clause lemma will take the surgery's proof arguments implicitly, as
`Surgery`'s section does.

**Proved** (sorry-free, listed under "Theorems this phase proved"):
- **(iii) the colouring**: `mergeCol_of_mem_sector` (a sector point inside `ρ`: `c` iff a gap sector and inside `ρ/2`, else the sector's colour),
  `mergeCol_branchPt` (a branch point: `c` iff a gap germ and inside `ρ/2`, else the colour after the germ), `mergeCol_of_not_mem` (`F`'s off
  `B(v, ρ)`), over `mem_gapSet_of_mem_sector`, `branchPt_mem_gapSet_iff` and the chart facts `sector_disjoint`, `not_mem_branch_of_mem_sector`,
  `eq_of_mem_branch`.
- **(i) the arcs**: `mem_mergeArcs`, `mergeArcs_cases` (every new arc but the rim arc lies on a germ arc out to `ρ`), and the surgery's and the
  clauses' obligations `mergeArcs_nondegenerate` (the rim arc by `liftDir_add_n`: `liftDir s b ≤ liftDir s (a+1) + 2π` since `b < a + 1 + n`),
  `mergeArcs_finite`, `mergeArcs_subset_closedBall`, `mergeArcs_unit`, `mergeArcs_condition5`.
- **(ii) membership**, the directions needed: `v_mem_mergeArcs` (M1), `branchPt_mem_mergeArcs_inner` (M2, a germ off the gap out to `ρ/2`),
  `branchPt_mem_mergeArcs_outer` (M3, a non-phantom germ over `(ρ/2, ρ]`), `mem_mergeArcs_rim` (M4); `liftDir_gap_germ`,
  `exists_dir_of_mem_gapSec` place gap points between the end germs' lifted directions; `ball_cases`.
- **(iv)** `branchPt_rim_mem_trimArcs`: a germ's point at distance `ρ` lies on `F.trimArcs v ρ` — the branch beyond `ρ` is on `F`'s arcs off
  `B̄(v, ρ)`, so on trimmed arcs meeting `B(v, ρ₀)`, finitely many (`GoodAt.fin` and `trimArcs_spec`'s finite `T`), whose union is closed.
- **(v) `merge_hlc`**: the colouring is locally constant off `F.trimArcs v ρ ∪ mergeArcs` — inside `B(v, ρ)` by `ball_cases`: a sector point
  (a gap sector point at radius exactly `ρ/2` is on the rim arc), a branch point (`exists_ball_subset_of_branchPt` and `gap_sides`: the sectors
  beside a gap germ are gap sectors or the gap's `c`-sectors; at `ρ/2` a gap germ is on the rim arc unless `a + 1 = b`, when both sides are `c`;
  beyond `ρ/2` a germ off the arcs is phantom); on the rim by (iv) (a rim point off the new map's arcs is `F`-interior, in one chart sector at a
  radius `ρ' > ρ`); off `B̄(v, ρ)` as `surgery_hlc_of`. It takes `X.Small ρ'` with `ρ < ρ'` (room beyond the rim).

**Re-priced from these parts** (standing order): 49 theorems in about 520 lines, every one compiled at the first or second attempt; the record's
4.3 is done but for the surgery's instantiation. 4.4 is left (below), about 700–900 lines at this rate.

### 7.1 The build, the axioms, the checks

Under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): **OK**, 446 of 446 batches, 3 modules rebuilt
(`MergeMove` 16 s, `Moves`, `Proofs`), 8 min 25 s; "Build completed successfully (5363 jobs)"; warnings only `declaration uses 'sorry'` (`Moves` l. 574
`exists_rayMerge_aux`, l. 585 `exists_merge_aux`; `Contact`, `BaseSteps`, `UnitArc` as before), none in `MergeMove`. Log
`build/gate/build/20261005T071525Z-2257155.log`; terminal output `data/fs131/imm/build-stage7.log`. **Axioms** against that build's oleans
(`lake env lean data/fs131/imm/AxiomsIMM.lean`, `data/fs131/imm/axioms-stage7.txt`): 103 records — 100 on exactly the standard three, 2 axiom-free
(`mem_gapGerm`, `mem_gapSec`), and `exists_merge_aux` on `sorryAx` besides (the print's positive control). `tools/fs131_imm_decls.py --check`: before
the receipt lines were added it failed, naming the 49 new theorems in both files (98 lines); after, PASS, 102 theorems. `tools/fs131_im_statements.py
--check` PASS (diff empty); `tools/fs131_im_split.py --check` PASS. The 49 records are in `scripts/Axioms.lean`'s FS131-IMM1 block after `-- FS131-IMM3`.
No `axiom`, no `native_decide`, no backlog statement changed.

### 7.2 What is left (4.4 and the assembly), for whoever continues

With `ρ' := ` a radius with `X.Small ρ'`, `ρ < ρ'`, `ρ < ρc` (exists_gap), write `F' := F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ)
(X.G.mergeCol v X.col F.col s a b c ρ) X.mem_dom h.1 (mergeArcs_nondegenerate h hbn) (mergeArcs_finite ρ) (merge_hlc h' hρρ' h hab hbn hca hcb)`.
- **AgreesOff, RingArcsWithin, Condition 5**: `surgery_agreesOff mergeArcs_subset_closedBall (fun z hz => mergeCol_of_not_mem …)`,
  `surgery_ringArcsWithin mergeArcs_unit`, `surgery_condition5 (mergeArcs_condition5 h hbn)` — one line each.
- **The interior points in `B(v, ρ)`**: `surgery_mem_arcs_iff_of_mem X.hG` reduces `F'`-interior to "off `⋃ mergeArcs`"; the converse of (M1)–(M4)
  inside `B(v, ρ/2)` (an arc point there is `v` or a branch point of a germ off the gap: `mergeArcs_cases`, `outer_subset`, the rim arc at radius
  `ρ/2`) gives, for `r < ρ/2`, `F'.interiorPts ∩ ball v r = (⋃ i ∉ merged, sector r i) ∪ (sector r (idx s a) ∪ sector r (idx s b) ∪ gapSet r)`.
- **Valid**: `Valid.of_agreesOff` on `closedBall v ρ`: an `F'`-interior point is, by `ball_cases`, a sector point (clear for its sector's colour by
  `isClear_col`, for `c` by `exists_gap` with `exists_dir_of_mem_gapSec`) or a branch point (clear for the colour after its germ by
  `isClear_of_mem_closure` on `sector j`, for `c` by `exists_gap` with `branchPt_idx`, `liftDir_gap_germ`); a rim point is `F`-interior by (iv);
  pairs inside are closer than `1`.
- **`v` gains no colour**: every `F'`-interior point of `B(v, ρ)` has a chart sector's colour (`mergeCol_of_mem_sector`, `mergeCol_branchPt`), and
  each chart sector's colour is at `v` (`mem_closure_sector`) — as `move_coloursAt_self`.
- **HasSectors v c n**: `encard_sectorsOf_of_partition` at `r < ρ/2` with pieces indexed by `Fin X.n` (the merged piece at `idx s a`, `∅` at the gap
  sectors and at `idx s b`, `sector r i` elsewhere); the merged piece is open (`exists_ball_subset_of_branchPt` at gap branch points) and preconnected
  (induction along `m = a, …, b`, each gap germ's branch in the closure of both sectors beside it, as `cut_hasSectors`' `hMpre`); count `(n + 1) − 1`.
- **The rim** (`x ∈ sphere v ρ`): `F'.coloursAt x ⊆ F.coloursAt x` as `move_coloursAt_sphere` (the colouring is `F`'s near `x` except on cut phantom
  branches, whose colour is that of both sectors beside them), so `≤ 2`; and `¬ F'.HasRepeatedColour x` by the sides lemma (§ 5.2).
- **`D_c(v′)` unchanged** (§ 5.2's route).

## Stage 8 — SAVED (FS131-IMM3): 4.4's clauses but two — agreement, no unit arc, Condition 5, validity, `v`'s colours, `HasSectors v c n`, the rim's colours

Every clause lemma is stated for `F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc` with
the surgery's proof arguments implicit (as `Surgery`'s section does), so the assembly instantiates them with `mergeArcs_nondegenerate`,
`mergeArcs_finite`, `merge_hlc`.

**Proved** (sorry-free, listed under "Theorems this phase proved"):
- `mem_merge_interiorPts_iff` (inside `B(v, ρ)` an interior point of the new map is a point off `⋃ mergeArcs`) and `mem_interiorPts_of_merge_rim`
  (a rim point interior to the new map is interior to `F`, by (iv)).
- **`merge_agreesOff`**, **`merge_ringArcsWithin`**, **`merge_condition5`**: `surgery_agreesOff`, `surgery_ringArcsWithin`, `surgery_condition5` over
  stage 7's arc lemmas.
- **`merge_coloursAt_self`** (`v` gains no colour): every colour the new map gives in the punctured `B(v, ρ)` is a chart sector's colour or `c`
  (`mergeCol_mem_coloursAt`), each carried at `v`.
- **`merge_valid`**: `Valid.of_agreesOff` on `B̄(v, ρ)` with the gap's clearness as a hypothesis in `exists_gap`'s form (`ρ ≤ ρc`); a sector point is
  clear for `c` (gap, `exists_dir_of_mem_gapSec`) or for its sector's colour (`isClear_col`); a branch point for `c` (gap germ, `branchPt_idx`,
  `liftDir_gap_germ`) or for the colour after its germ (`isClear_of_mem_closure` over `cutSet_subset_closure`); a rim point is `F`'s; pairs in
  `B̄(v, ρ)` are closer than `1`.
- **`merge_hasSectors`**: at every `r < ρ/2`, `encard_sectorsOf_of_partition` over the pieces `P i` (`i : Fin X.n`) = the chain from `idx s a` to
  `idx s b` at `i = idx s a`, `∅` at the gap germs' indices (the gap sectors and `idx s b`), `sector r i` elsewhere; the chain (`chain`: the first
  `c`-sector, then each gap germ's branch and the sector after it) is open (`exists_ball_subset_of_branchPt`, `gap_sides_idx`) and preconnected
  (`isPreconnected_chain`, by induction along the orbit, as `cut_hasSectors`' `hMpre`), all of colour `c`; the pieces of colour `c` are
  `{i | X.col i = c} \ {idx s b}`, so the count is `(n + 1) − 1` (`Set.encard_sdiff_singleton_add_one`).
- **`merge_coloursAt_rim`**: at a rim point `x`, `F'.coloursAt x ⊆ F.coloursAt x` — off `B̄(v, ρ/2)` the new map's colour class is in the closure of
  `F`'s (a cut phantom branch point has the colour of the sector after its germ, `cutSet_subset_closure`); **`merge_ncard_coloursAt_rim`**: `≤ 3`
  (`≤ 2` by `IsSectorChart.ncard_coloursAt_le_two`).

**Re-priced**: stage 8 came to 16 theorems in about 390 lines, each compiled within three attempts; no heartbeat death.

### 8.1 The build, the axioms, the checks

Under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): **OK**, 446 of 446 batches, 3 modules rebuilt,
8 min 30 s; "Build completed successfully (5363 jobs)"; warnings only `declaration uses 'sorry'` (`Moves` `exists_rayMerge_aux`, `exists_merge_aux`;
`Contact`, `BaseSteps`, `UnitArc` as before), none in `MergeMove`. Log `build/gate/build/20261005T073602Z-2376652.log`; terminal output
`data/fs131/imm/build-stage8.log`. **Axioms** against that build's oleans (`data/fs131/imm/axioms-stage8.txt`): 119 records — 116 on exactly the
standard three, 2 axiom-free, `exists_merge_aux` on `sorryAx` besides (the control). `tools/fs131_imm_decls.py --check`: FAIL naming the 16 new
theorems (32 lines) before their receipt lines were added, PASS (118 theorems) after; `tools/fs131_im_statements.py --check` PASS;
`tools/fs131_im_split.py --check` PASS. No `axiom`, no `native_decide`, no backlog statement changed.

### 8.2 What is left: two clauses and the assembly

1. **`¬ F'.HasRepeatedColour x` at rim points** — the sides lemma (§ 5.2): at a rim point on germ `j`, for small `r`, `sector (prev j) ∩ B(x, r)`
   and `sector j ∩ B(x, r)` are preconnected (each is one side of the germ's circle or line inside the ball: convex, or star-convex about
   `x + (r/2R)(x − o)`), so `encard_sectorsOf_of_partition` gives one piece per colour: (R1) `x` on no germ — one sector; (R2) a non-phantom germ —
   the new map is `F` near `x` (its annulus piece and the trimmed arcs), two pieces of two colours; (R3) a phantom germ — one piece (the two sides
   joined through the cut branch inside `B(v, ρ)`, `isPreconnected` as in `isPreconnected_chain`), one colour.
2. **`D_c(v′)` unchanged** for `v′ ∉ B̄(v, ρ)` (§ 5.2's route; note that a merged `c`-tile misses `ω(v′)` because the new map is valid
   (`merge_valid`), which is what keeps `w = v`'s type when `dist v v′ = 1`).
3. **The assembly** of `exists_merge_aux`: `X := (exists_near hv.mem).some`, `hcnt := X.encard_col_eq …` (`Near.encard_col_eq`), `exists_gap` for
   `s a b ρc hgc`; `ρ'` with `X.Small ρ'` (`eventually_small`) and `ρ := min (ρ' / 2) ρc / 2`-style so that `X.Small ρ`, `ρ < ρ'`, `ρ ≤ ρc`; then
   `F' := F.surgery v ρ (mergeArcs) (mergeCol) X.mem_dom h.1 (mergeArcs_nondegenerate h hbn) (mergeArcs_finite ρ) (merge_hlc h' hρρ' h hab hbn hca hcb)`
   and the clauses `merge_valid`, `merge_agreesOff`, `merge_ringArcsWithin`, `merge_condition5`, `merge_hasSectors`, `merge_coloursAt_self`,
   `merge_ncard_coloursAt_rim` with items 1 and 2.

## Stage 9 — SAVED (FS131-IMM3): `exists_merge_aux` assembled over two open leaves

**The assembly** (`Moves.exists_merge_aux`'s proof body, its statement unchanged — `tools/fs131_im_statements.py --check` PASS): `X` from `exists_near`,
`hcnt` from `Near.encard_col_eq`, `s a b ρc hgc` from `exists_gap` (restated form), `ρ'` with `X.Small ρ'` (`eventually_small`), `ρ := min (ρ'/2)
(ρc/2)`, so `X.Small ρ`, `ρ < ρ'`, `ρ ≤ ρc`; `F' := F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) X.mem_dom _
(mergeArcs_nondegenerate h hbn) (mergeArcs_finite ρ) (merge_hlc h' hρρ' h hab hbn hca hcb)`; the clauses are stage 8's lemmas and the two leaves.

**The two open leaves**, in `MergeMove`, each `sorry` and each stated for the surgery with its proof arguments implicit:
- `merge_not_hasRepeatedColour_rim (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (hab : a < b) (hbn : b < X.n) (hx : x ∈ sphere v ρ) :
  ¬ F'.HasRepeatedColour x` — § 8.2 item 1 (the sides lemma).
- `merge_allowedCone (hF : F.Valid) (hv1 : F.Covers v 1) h' hρρ' h hab hbn hca hcb hgap (hρc : ρ ≤ ρc) hgc : ∀ v' ∉ closedBall v ρ,
  F'.allowedCone v' c = F.allowedCone v' c` — § 8.2 item 2. It carries every hypothesis the assembly has, so it is no stronger than
  `exists_merge_aux`'s own clause for this construction; its truth is IMM1's and IMM2's belief (record § 4.4, § 5.2), not yet checked here.

Both are believed true; neither has been attacked beyond the reading in § 8.2. A successor proves them in place (no statement of a backlog
theorem changes; the leaves are this lane's children and may be restated if a hypothesis proves missing — say so in the record).

### 9.1 The build, the axioms, the checks

Under the slot: **OK**, 446 of 446 batches, 3 modules rebuilt, 8 min 28 s; "Build completed successfully (5363 jobs)"; warnings `declaration uses
'sorry'` — `MergeMove` l. 2426 `merge_not_hasRepeatedColour_rim`, l. 2434 `merge_allowedCone`; `Moves` l. 574 `exists_rayMerge_aux` only
(`exists_merge_aux` no longer); `Contact`, `BaseSteps`, `UnitArc` as before. Log `build/gate/build/20261005T074636Z-2448915.log`; terminal output
`data/fs131/imm/build-stage9.log`. **Axioms** (`data/fs131/imm/axioms-stage9.txt`): 121 records — 116 on exactly the standard three, 2 axiom-free,
and on `sorryAx` besides exactly the two leaves and `exists_merge_aux` (the control: the print sees the `sorry` beneath the assembly).
`tools/fs131_imm_decls.py --check` PASS (120 theorems, the two leaves' receipt lines added); `tools/fs131_im_statements.py --check` PASS;
`tools/fs131_im_split.py --check` PASS. No `axiom`, no `native_decide`, no backlog statement changed.

### 9.2 For whoever continues

Prove `merge_not_hasRepeatedColour_rim` (§ 8.2 item 1, about 200 lines: the sides lemma by convexity on one side and star-convexity on the other,
then three cases) and `merge_allowedCone` (§ 8.2 item 2 and § 5.2's route, about 300–400 lines). Iterate with `data/fs131/imm/wip/C.lean`
(imports `Moves`) via `bash data/fs131/imm/iter.sh data/fs131/imm/wip/C.lean` after refreshing the mirror (`cp -a .lake/build/lib/lean/.
build/imm-mirror/` after a green build; the mirror is current at stage 9). Then MERGE's landing (a later job).

## Stage 10 — SAVED (FS131-IMM4): the readback, the as-given build

*FS131-IMM4 (de Bruijn, the implementer, on Opus) continues this record from here; brief `data/fs131/briefs/FS131-IMM4-merge.md` (on `main`).*

### 10.1 The brief's quotations against their sources (standing rule 3)

Checked by script (exact substring search), each **verbatim**:

| quotation (a prefix) | source | line |
|---|---|---|
| "theorem merge_not_hasRepeatedColour_rim {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (hab : a < b)" | `Proofs/HadwigerNelson/Plane/ValidMap/MergeMove.lean` (this branch, `8cae85bc`) | 2426 |
| "theorem merge_allowedCone (hF : F.Valid) (hv1 : F.Covers v 1) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ)" | the same | 2434 |
| "theorem exists_merge_aux (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)" | `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean` (this branch) | 585 |
| "1. **`¬ F'.HasRepeatedColour x` at rim points** — the sides lemma (§ 5.2): …" | this record § 8.2 | 526 |
| "2. **`D_c(v′)` unchanged** for `v′ ∉ B̄(v, ρ)` (§ 5.2's route; …" | this record § 8.2 | 531 |
| "Prove `merge_not_hasRepeatedColour_rim` (§ 8.2 item 1, about 200 lines: …" | this record § 9.2 | 568 |
| "353. **FS131-IMM3 handed back** …" | `plans/FS131-close-inventory.md` (on `main`) | 3034 |
| "354. **Ruling on IMM3's slot: MERGE's continuation, FS131-IMM4, …**" | the same | 3052 |
| "348. **Ruling on item 347: MERGE returns to wave 5's path; …**" | the same | 2978 |
| "269. **Ruling on item 268: …**" | the same | 1958 |
| "**It may**: add children anywhere in the wave's modules — …" | `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 14.2 | 887 |

Read: this record's Stages 6–9 and IMM2's § 5.2 in full (and IMM1's § 4), inventory items 269, 348, 353, 354, plan § 14.2, both leaves and the
assembly, and the APIs they stand on (`Surgery`: `surgery`, `trimArcs_spec`, `encard_sectorsOf_of_partition`, `exists_ball_subset_of_branchPt`,
`Near`; `Cone`: `inType_iff`, `outType_iff`; `Tiles`: `ne1_region`; `LocalStructure`: `finite_tiles_near`, `GoodAt.finite_tiles_sphere`).

### 10.2 The branch builds as given

`8cae85bc`, under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): **OK**, "all 1748 modules already
up to date, nothing built", 2 s; warnings only `declaration uses 'sorry'` (`MergeMove` l. 2426, l. 2434 — the two leaves; `Moves` l. 574
`exists_rayMerge_aux`; `Contact`, `BaseSteps`, `UnitArc` as before). Log `build/gate/build/20261005T080558Z-2587020.log`; terminal output
`data/fs131/imm/build-asgiven-imm4.log`. The iteration mirror `build/imm-mirror` was older than this build's oleans (02:44 against 02:54) and was
refreshed from them.

## Stage 11 — SAVED (FS131-IMM4): `merge_not_hasRepeatedColour_rim` proved (the sides lemma, then the three cases)

**The route** (record § 8.2 item 1, sharpened): at a rim point `x`, every count is shown `≤ 1` for all small `r`.
- **The sides lemma, one argument for both sides and every curvature** (`isPreconnected_side_plane`): in the frame along the germ's
  tangent, `tanHeight κ` is a quadratic with Hessian `−κ` (`tanHeight_combo`), so for `w₀` on the circle (`tanHeight κ w₀ = 0`) and
  `|κ| r ≤ 2/5`, each side `{σ · tanHeight > 0}` of `B(w₀, r)` is **star-convex about `w₀ + σ (r/2) g`**, `g = (−κ X₀, 1 − κ Y₀)` the unit
  normal (`‖g‖² = 1 − 2κ tanHeight = 1`): there `σ · tanHeight = r/2 − σκ r²/8`, and along a segment to a point `z` of the side the excess
  is `≥ (1 − b)(r/2)(1 − (5/2)|κ| r) + b σ tanHeight(z) > 0` (`side_ineq`). No sign cases: IMM2's convex/star-convex split and the
  `κ = 0` half-planes are one statement. `isPreconnected_side` moves it into the plane by the frame's isometry (`frame_mul_e`).
- `sides_preconnected`: at a germ's point at distance `ρ < ρ'`, for small `r` the two chart sectors beside the germ, cut to `B(x, r)`,
  are the two sides (the circle meets the ball in the branch only: `eq_branchPt_of_tanHeight_eq_zero` with `frameX > 0` near `x`, and
  `tanHeight_branchPt`), hence preconnected (`isPreconnected_of_two_sides`: disjoint open non-empty `A`, `B` with `A ∪ B = P ∪ Q`, `P`, `Q`
  preconnected, are `P` and `Q`). It needs `p ≠ next p` (two or more germs; MERGE has `X.n ≥ 2`).
- The new map near `x` (`B(x, r)` misses `B̄(v, ρ/2)`): sector points are interior to it (`mem_merge_interiorPts_of_mem`: off the rim arc,
  `F`'s interior points stay interior), with the sector's colour (`mergeCol_of_mem_sector_out`); a germ point at `t ∈ (ρ/2, ρ')` is interior
  exactly when `t < ρ` on a phantom germ (`branchPt_mem_merge_interiorPts_iff`). Then (R1) `x` on no germ: the interior points are the ball,
  preconnected, so at most one sector of any colour (`encard_sectorsOf_le_one`); (R2) a non-phantom germ: two pieces, the sectors beside
  the germ, of the two different colours beside it (`encard_sectorsOf_of_partition` over `Bool`); (R3) a phantom germ: one preconnected
  piece (the two sides joined through a cut branch point `y₀` in both closures).

**Re-priced** (the brief's standing order, after the first leaf): leaf 1 took about 500 lines (343 of children, 157 of proof), every child
compiled at the first or second attempt; IMM3 priced it at about 200. Leaf 2 was drafted in the same stage's iteration and compiles in
`data/fs131/imm/wip/C.lean` (about 480 lines, see Stage 12), so no further re-pricing is needed.

### 11.1 The build, the axioms, the checks

Under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): **OK**, 446 of 446 batches, 3 modules
rebuilt (`MergeMove` 18 s, `Moves` 2.6 s, `Proofs`), 8 min 27 s; "Build completed successfully (5363 jobs)"; warnings only `declaration uses
'sorry'` — `MergeMove` l. 2933 `merge_allowedCone` (the one open leaf), `Moves` l. 574 `exists_rayMerge_aux`; `Contact`, `BaseSteps`, `UnitArc`
as before. Log `build/gate/build/20261005T081907Z-2639896.log`; terminal output `data/fs131/imm/build-stage11.log`. **Axioms** against that
build's oleans (`lake env lean data/fs131/imm/AxiomsIMM.lean` under the slot, `data/fs131/imm/axioms-stage11.txt`), read by the new tool
**`tools/fs131_imm_axioms.py`** (re-joins Lean's wrapped lines, parses names with apostrophes, classes each record; `--self-test` passes the
clean receipt and fires on a planted sorry, a planted foreign axiom, a missing control and an empty parse): **133 records — 118 on exactly
the standard three, 13 on fewer (two axiom-free, eleven on `[propext]` or `[propext, Quot.sound]`), 2 with `sorryAx` (`merge_allowedCone` and
`exists_merge_aux`, the control), 0 foreign; PASS with `--expect-sorry` those two.** The same tool on `axioms-stage9.txt` with this
expectation FAILS naming `merge_not_hasRepeatedColour_rim` — the stage's change, seen by the instrument. (IMM3's "116 on exactly the
standard three" counted the subset records with them: 105 + 13 = 116 + 2.) `tools/fs131_imm_decls.py --check`: FAIL naming the 12 new
theorems in both receipt files (24 lines) before their lines were added, PASS (132 theorems) after; `tools/fs131_im_statements.py --check`
PASS; `tools/fs131_im_split.py --check` PASS. No `axiom`, no `native_decide`, no backlog statement changed; the leaf's statement unchanged
(its docstring rewritten from "open leaf").

**Proved** (12 children and the leaf, in `MergeMove`'s new block "FS131-IMM4: the rim clause", listed under "Theorems this phase proved").

## Stage 12 — SAVED (FS131-IMM4): `merge_allowedCone` proved; `exists_merge_aux` carries no `sorryAx`

**The route** (record § 5.2, § 8.2 item 2): for `v′ ∉ B̄(v, ρ)` and every `w`, the contacts agree and so do their types, so the cones agree.
- **`F`'s class of `c` survives** (`merge_region_of_region`): its points are interior to the new map (the new map's arcs are trimmed arcs and
  germ arcs of `F`, and the rim arc, which runs through gap sectors only — `gapSec_of_mem_rimArc`, by `exists_step_of_strictMono` along the
  lifted directions — none of colour `c` by `hgap`) and keep the colour `c`.
- **The new class** (`merge_region_cases`): `F`'s class, the gap out to `ρ/2`, or cut branch points inside `ρ` of germs with `c` after them;
  so `closure F'.region c ⊆ closure F.region c ∪ closure gapSet(ρ/2)` (`closure_merge_region`), and `closure gapSet(ρ/2) ⊆ {v} ∪ chain(ρ)`
  (`closure_gapSet_subset`), where the chain out to `ρ` (the first `c`-sector, the gap, the last `c`-sector) is open (`isOpen_chain`) and
  clear for `c` in `F` (`isClear_chain`: `c`-sectors by validity, gap points by `exists_gap`'s clearness), so it meets no unit circle about a
  closure point of `F`'s class (`dist_ne_one_of_isOpen_isClear`, IMM1's).
- **Contacts** (`merge_isContact_iff`): `c ∈ coloursAt v′` agrees (the gap's closure is inside `B̄(v, ρ)`); a contact of the new class is
  `F`'s, or `v` (in the closure of `F`'s class), or a chain point (at distance `≠ 1` from `v′`).
- **Tiles** — `merge_exists_tile`: each `c`-tile of `F` lies in one of the new map; `merge_tile_split`: a `c`-tile of the new map lies
  inside or outside `ω(v′)` (the new map is valid, `merge_valid`; `ne1_region`); `merge_tile_cover`: a `c`-tile `T′` of the new map with a
  contact `w` in its closure holds a `c`-tile of `F` with `w` in its closure — if `T′` misses `B̄(v, ρ)` it is a tile of `F`; otherwise its
  points are in the closure of `T′ ∩ F.region c` or the gap (a cut branch point has a ball inside `T′` meeting the sector after its germ),
  the contact is not a chain point, `v` is handled by `v_mem_closure_merge_tile` (the tile holds a `c`-sector of `F` at `v`, or the merged
  chain, which holds the first `c`-sector), and `T′` holds finitely many tiles of `F` — each meets `B(v, (ρ + ρ₀)/2)` (else it is clopen in
  `T′`, using `IsTile.mem_of_mem_closure` off the disc), and finitely many tiles meet a ball inside a good ball (`finite_tiles_ball_of_goodAt`).
- **Types** (`merge_inType_iff`, `merge_outType_iff`) from the three tile facts; the leaf by `ext`.

**One binder renamed, the type unchanged**: `merge_allowedCone`'s hypothesis `(hv1 : F.Covers v 1)` is not used by the proof (finiteness
comes from the good ball `X.hG`, clearness from `exists_gap`'s `hgc`), so the unused-variable linter fired on it; it is renamed `_hv1`,
which leaves the theorem's type and the assembly's call in `Moves` unchanged (positional). No hypothesis or conclusion changed. The
docstring says so.

**Proved** (19 children and the leaf, in `MergeMove`'s new block "FS131-IMM4: `D_c(v′)` off the disc", listed under "Theorems this phase
proved"). `data/fs131/imm/wip/C.lean` (the working file) is deleted, its content in `MergeMove`.

### 12.1 The build, the axioms, the checks

Under the slot: **OK**, 446 of 446 batches, 3 modules rebuilt (`MergeMove` 19 s, `Moves` 2.5 s, `Proofs`), 8 min 27 s; "Build completed
successfully (5363 jobs)"; warnings only `declaration uses 'sorry'` — `Moves` l. 574 `exists_rayMerge_aux` (this branch's pre-RAY copy);
`Contact`, `BaseSteps`, `UnitArc` as before; **none in `MergeMove`** (4 modules with warnings, down from 5). Log
`build/gate/build/20261005T083812Z-2758320.log`; terminal output `data/fs131/imm/build-stage12.log`. **Axioms** against that build's oleans
(`lake env lean data/fs131/imm/AxiomsIMM.lean` under the slot, `data/fs131/imm/axioms-stage12.txt`; `exists_rayMerge_aux` added to the
receipt as the control): `tools/fs131_imm_axioms.py data/fs131/imm/axioms-stage12.txt --expect-sorry HadwigerNelson.Plane.ArcMap.exists_rayMerge_aux`
— **153 records: 139 on exactly the standard three, 13 on fewer (two axiom-free, eleven on `[propext]` or `[propext, Quot.sound]`), 1 with
`sorryAx` — `exists_rayMerge_aux`, the control — and 0 foreign; PASS.** In particular **`exists_merge_aux` reads exactly `[propext,
Classical.choice, Quot.sound]`**, as do both former leaves. The same expectation on stage 11's receipt FAILS, naming `merge_allowedCone`
and `exists_merge_aux` (still `sorryAx` then) and the absent control. `grep -c sorry` on `MergeMove`: 0. `tools/fs131_imm_decls.py --check`:
FAIL naming the 19 new theorems in both files before their lines were added, PASS (151 theorems) after; `tools/fs131_im_statements.py
--check` PASS; `tools/fs131_im_split.py --check` PASS. No `axiom`, no `native_decide`, no backlog statement changed.

### 12.2 What is proved, and what is left (the handover)

**MERGE is proved**: `exists_merge_aux` (wave 4's FS110-W-MERGE, in ruling 269's form) and all 151 theorems of `MergeMove` are on the
standard three or fewer, with no `sorry` beneath; the build is green. **Left for MERGE's landing** (a later job, on Keryx's word, not this
one): merging this branch into the wave's line and `main` (with `framePt → fromFrame` and whatever else the landing rules), restoring
`exists_merge`'s `sorry` in `Contact` by `exists_merge_aux`, and the full gate (`scripts/axioms.sh` — the MergeMove records in
`scripts/Axioms.lean`'s FS131-IMM1 block are now all clean — `vacuity.sh`, linters, the counts). The two theorems of `Moves` this branch
does not own (`exists_rayMerge_aux`, pre-RAY) and the other modules' `sorry`s are untouched.

No front-page drafts: the brief withholds the gate from this job, and the `## Drafts for the front page` section belongs to the run that
gates MERGE's landing.

## Stage 13 — SAVED (FS131-ML1): the readback, the as-given build, and what this job may change

*FS131-ML1 (de Bruijn, the implementer, on Opus) continues this record from here; brief `data/fs131/briefs/FS131-ML1-merge-land.md` (on `main`
at `7e5e98a1`). Its job: MERGE's landing — merge `main` (wave 4 and Woodall landed) into `fs131-w4mm`, restore `exists_merge_aux` (`Moves`) and
`exists_merge` (`Contact`) in ruling 269's form over `MergeMove`, the full gate on one commit, and a fast-forward of `main`.*

### 13.1 The brief's quotations against their sources (standing rule 3)

Checked by script (`data/fs131/ml/quotes.py`: every `> ` line of the brief followed by a `> — source:` line, searched as an exact substring;
inventory items in `plans/FS131-close-inventory.md` at `main`, the two statements at `c9623d04`), each **verbatim**:

| quotation (a prefix) | source | line |
|---|---|---|
| "367. **FS131-IMM4 done: MERGE is proved** …" | `plans/FS131-close-inventory.md` (`main`) | 3187 |
| "368. **Rulings on IMM4's held items, and its slot.** …" | the same | 3202 |
| "295. **Ruling: MERGE leaves wave 4; …**" | the same | 2274 |
| "269. **Ruling on item 268: …**" | the same | 1958 |
| "348. **Ruling on item 347: MERGE returns to wave 5's path; …**" | the same | 2978 |
| "318. **WAVE 4 LANDED on `main`, held in the kernel** …" | the same | 2570 |
| "319. **Wave 4's filing, and the freed slot.** …" | the same | 2594 |
| "326. **WOODALL'S CHAIN LANDED: FS131-WL1 done** …" | the same | 2677 |
| "327. **Woodall's landing counts filed** …" | the same | 2704 |
| "theorem exists_merge_aux (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)" | `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean` (`c9623d04`) | 585 |
| "theorem exists_merge (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)" | `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` (`c9623d04`) | 1479 |

Read: items 367–368, 295, 269, 348, 318–319, 326–327 in full; this record's Stages 1–12; wave 4's landing record (`fs131-w4`'s
`plans/FS131-I4-implementation.md`, G4's Stages 44–48) and Woodall's (`fs131-ww`'s `plans/FS131-IW-implementation.md`, WL1's Stages 19, 21–22 and its
drafts), whose order this landing follows.

### 13.2 The branch builds as given

`c9623d04`, under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): **OK**, "all 1748 modules already up
to date, nothing built, 4 module(s) with warnings, 2s", exit 0 (log `build/gate/build/20261005T085202Z-2839746.log`; driver `data/fs131/ml/build-asgiven.log`):
29 warnings, every one `declaration uses 'sorry'` (`grep -v` of that phrase over the `warning:` lines: 0) — `BaseSteps` 7, `Contact` 4, `Moves` 1
(l. 574 `exists_rayMerge_aux`, this branch's pre-RAY copy), `UnitArc` 17: all this branch's stale wave-4 copies, none in `MergeMove`.

### 13.3 The merge as it stands, and what this job may and may not change

**One merge base**, `73d31ad6` (`git merge-base --all HEAD origin/main`). **This branch's side** since it (`git diff --stat 73d31ad6 HEAD`): the new
`MergeMove` (3,480 lines), `Moves` (its `MergeMove` import and `exists_merge_aux`'s proof, 24 lines), `Proofs.lean` (one import), `ARCHITECTURE.md`
(`MergeMove`'s row, `Moves`' row), `scripts/Axioms.lean` (one block of 151 records just above `=== PURCHASED ===`), `tools/fs131_imm_*.py`.
**`main`'s side**: wave 2, wave 4 (every leaf proved, `exists_merge`/`exists_merge_aux` deleted, `framePt → fromFrame`), Woodall, and the gate scripts'
changes (34 files under `Proofs/`, `scripts/`, `ARCHITECTURE.md`). `Surgery` and `Cone` — `MergeMove`'s whole import closure in wave 4 — are unchanged on
`main` since the base; `MergeMove` names no `framePt` (`grep`: 0), so the rename touches it nowhere; this branch's `scripts/Axioms.lean` carries two
`framePt` records, both the base's, which the merge replaces with `main`'s renamed ones.

**May**: take `main`'s side for every wave-4 module; restore `exists_merge_aux` in `Moves` with IMM's proof (and `Moves`' import of `MergeMove`) and
`exists_merge` in `Contact` as a one-line citation of it, each statement and docstring byte-identical to `c9623d04`; `Contact`'s header line
"* **FS110-W-MERGE**: `exists_merge`." and its section header `/-! ## FS110-W-MERGE -/`; `Moves`' module docstring back to naming MERGE (G4 Stage 45
removed exactly that when it deleted `exists_merge_aux`); the `ARCHITECTURE.md` mentions (`Contact`'s and `Moves`' rows, `MergeMove`'s row) and the
`Proofs.lean` import; `framePt → fromFrame` in this branch's own code if any uses it; delete identical copies (rename on this branch's side any that
collide and differ); records in `scripts/Axioms.lean`; carriers and controls in `scripts/Vacuity.lean`, `scripts/vacuity-controls.lean`, the baseline's
header; the axioms self-test's expected counts if this state moves them; `tools/fs131_ml_*.py`, `data/fs131/ml/`, this record, the report; `main` by
fast-forward only. **May not**: any statement — no hypothesis, conclusion or definition the statements use; no `axiom`, no `native_decide`; `CLAUDE.md`,
`LEAN.md`, `tools/claude_md_fact_audit.py`, `LEDGER.md` (drafts only); another job's tools (`tools/fs131_qa1_dupes.py`, `fs131_wl_mergestmts.py`,
`fs131_im_statements.py`, `fs131_im_split.py`, `fs131_imm_*.py` are run, never edited).

## Stage 14 — SAVED (FS131-ML1): `main` merged (`b9305232`); `exists_merge_aux` and `exists_merge` restored; the build green

**Before the merge.** `tools/fs131_qa1_dupes.py` (run as the brief names it, not edited): 13 names in two bodies' own files, none of them
`MergeMove`'s — its fixed body table has no entry for `fs131-w4mm` (`data/fs131/ml/qa1-dupes.txt`; `--self-test` OK). So the question was asked
of this merge by a new tool, **`tools/fs131_ml_dupes.py`** (QA1's `qualified_decls` imported): every name declared in this branch's own files
(`git diff --name-only 73d31ad6 HEAD`: `MergeMove`, `Moves`; 192 declarations) against every name `main` declares (8,857): **0 pairs**
(`data/fs131/ml/dupes-premerge.txt`). Its `--plant` (two synthetic own files: `main`'s `ArcMap.exists_shave_aux` under another statement, and
`ArcMap.exists_rayMerge_aux` with `main`'s statement copied verbatim) reports exactly `DIFFERS exists_shave_aux` and `IDENTICAL exists_rayMerge_aux`,
exit 1 (`data/fs131/ml/dupes-plant.txt`). Also: none of `MergeMove`'s 151 theorem statements is held by `main` under another name (an ad hoc
pass over `tools/fs131_i4_mergestmts.py`'s `stmts`: 0). **No identical copy, no collision: nothing deleted, nothing renamed.**

**The merge** (`b9305232`, `git merge --no-ff --no-commit origin/main` at `7e5e98a1`, one merge base `73d31ad6`; the resolved files `git add`ed by
name). `Proofs.lean` auto-merged (both sides: `main`'s new modules and `MergeMove`'s import). Three conflicts:
- `Moves`: git kept this branch's `import …MergeMove` and took `main`'s text everywhere else; the one conflict, at the end, was resolved by
  script — `main`'s `exists_rayMerge_aux` body (RAY, proved there), then `exists_merge_aux`'s docstring, statement and proof cut from `c9623d04`
  verbatim. The module docstring is put back to naming MERGE (title "SHAVE, MERGE-RAY and MERGE (FS110-N4-SHAVE, N4-RAY, W-MERGE)", "three
  simplifying moves", `exists_merge_aux` in the list — the words G4 Stage 45 removed) with one clause added: "MERGE's children are
  `Plane/ValidMap/MergeMove`". `git diff origin/main` on `Moves`: the import, the docstring's three lines, and the 30 lines of `exists_merge_aux`.
- `Contact` (no conflict: `main` deleted, this branch never touched it): `exists_merge` restored by script — the section header `/-! ## FS110-W-MERGE -/`,
  docstring and statement cut from `c9623d04` verbatim, placed where they stood (after `exists_rayMerge`, before `/-! ## FS110-N4-STUCK -/`), the body
  `exact exists_merge_aux hF hv hn1 hn hD` in place of `sorry` (the one-line citation, `exists_shave`'s form); the header line
  "* **FS110-W-MERGE**: `exists_merge`." after N4-STUCK's, as at `c9623d04`.
- `ARCHITECTURE.md`: `MergeMove`'s row (now "FS131-IMM1–IMM4, inventory items 285, 367; landed by FS131-ML1"), `Moves`' row as the three moves
  (with "W-MERGE left wave 4 at its landing, inventory item 295 (a), and returned at MERGE's, FS131-ML1"; imports `Surgery`, `MergeMove`), `UnitArc`'s
  row `main`'s (its `Sectors` import); `Contact`'s row regains "FS110-W-MERGE (`exists_merge`)".
- `scripts/Axioms.lean`: `main`'s block "FS131-IM3: MERGE-RAY's children" first, then this branch's `MergeMove` block (151 records), both just above
  `=== PURCHASED ===`; the two records `ArcMap.exists_merge` (after `exists_rayMerge`) and `ArcMap.exists_merge_aux` (after `exists_rayMerge_aux`)
  restored where G4 deleted them. 3,807 records = 3,654 + 151 + 2, none twice.

**`framePt`**: none in `MergeMove`, `Moves` or `Contact` (`grep`: 0); on the merged tree `framePt` occurs only in wave 2's `Plane/Slack` and its
record `dist_framePt_sq`, so nothing of MERGE can resolve to it; this branch's two `framePt` records were the base's, replaced by `main`'s renamed ones.

**Checks.** **`tools/fs131_ml_restore.py`** (new): both declarations' docstring + statement byte-identical to `c9623d04` (`exists_merge_aux` 848
bytes, `exists_merge` 1,101 bytes), `exists_merge`'s body the one-line citation, and the import, header, `Proofs.lean`, `ARCHITECTURE.md` and record
checks: PASS (`data/fs131/ml/restore-check.txt`); `--plant` (`hn1 : 2 ≤ n` in `exists_merge`): FAIL naming it, exit 1 (`restore-plant.txt`); on
`origin/main` every check FAILS (11 lines, `restore-main.txt`), so each failure path is reachable. `tools/fs131_im_statements.py --check` (IM's,
run): **PASS** — "exists_merge_aux has Contact's statement of exists_merge verbatim (6 lines; diff empty)"; on `main` it FAILS on `exists_merge`
(item 318's correction (2), discharged) (`data/fs131/ml/im-statements.txt`). `tools/fs131_im_split.py --check`: PASS (`im-split.txt`).
**Three-way statements** (`tools/fs131_wl_mergestmts.py HEAD origin/main`, WL1's, run): **6,509 names, 0 base conflicts, 2 mismatches —
`exists_merge` and `exists_merge_aux`, each "merged {…} expected {}"**: a plain three-way merge would keep `main`'s deletion; the two are the
restore this job was asked for, their statements checked against `c9623d04` above (`data/fs131/ml/mergestmts.txt`). Its `--plant`: a third
mismatch (`AeColouring.exists_fill`), exit 1 (`mergestmts-plant.txt`). `tools/fs131_i4_treedupes.py` on the merged tree: 9,029 declarations,
exactly `main`'s three standing repeats (`conj_e`, `bindings`, `with`; `--rev origin/main` the same three) (`treedupes-merged.txt`, `treedupes-main.txt`).

**Build** of the merged tree (under the slot): **OK — 451 of 451 batches, 34 module(s) rebuilt, 0 module(s) with warnings, 13m41s**, exit 0
(`build/gate/build/20261005T085902Z-2875622.log`; driver `data/fs131/ml/build-merged.log`): `grep -c warning` on the full log 0; its five `error` lines
are the up-to-date probe's "target is out-of-date" (5 of 5), which starts the walk. `MergeMove` rebuilt against `main`'s oleans in 41 s, `Moves`
11 s, `Contact` 13 s.

## Stage 15 — SAVED (FS131-ML1): the full gate on `df473bfe` — green, every count reconciled

**`main` merged again first** (`df473bfe`, `origin/main` at `3d6319ad`: three commits, `git diff --name-only a6c248c9 df473bfe` = two briefs,
`plans/FS131-close-inventory.md`, `plans/SESSION-HANDOFF-2026-10-04.md` — no gate input). Every check on `df473bfe`, its saved log read
(copies under `data/fs131/ml/`; runner `data/fs131/ml/run-gate.sh final`, each script under `scripts/slot.py --mem 30 --cpus 4`):
- **Build**: "build: OK — all 1766 modules already up to date, nothing built, 0 module(s) with warnings, 2s", exit 0 — the up-to-date probe against
  the oleans Stage 14's 13m41s build wrote from the same Lean sources (`build/gate/build/20261005T092305Z-2984013.log`; driver
  `data/fs131/ml/build-final.log`); **0 warnings** there and in Stage 14's full log. Negative control: the as-given build of Stage 13 (`c9623d04`),
  the same script, reported 29 warnings, every one `declaration uses 'sorry'`.
- **Sorry**: `grep -rnP '^\s*sorry\s*$|:= sorry|by sorry' Proofs/`: **0**; the wider `\bsorry\b` finds 4 lines, all docstring prose of `main`'s
  (`Plane/Cover` l. 33, `Plane/CoverExamples` l. 13, l. 6541, `Packed` l. 266) (`data/fs131/ml/sorry-final.txt`). Control: the same pattern over
  `c9623d04`'s tree, 29 lines.
- **Axioms** (`scripts/axioms.sh`): "**axioms: OK — 3784 clean, 14 axiom-free, 4 imported, 5 declared purchase(s)**", exit 0; "audited: 3807
  records" (`build/gate/axioms/20261005T092312Z-2984691.log`, copy `data/fs131/ml/axioms-receipt-final.log`; digest `data/fs131/ml/axioms-final.log`).
  **Reconciled against `main`'s gated run** (WL1's, `fs131-ww/build/gate/axioms/20261005T041304Z-1297413.log`, `main`'s Lean and scripts unchanged
  since its gated `08e64ae5` — `git diff --name-only 08e64ae5 origin/main` outside `plans/`, `data/` is `CLAUDE.md`, `LEAN.md`, the output style and
  the fact audit): `scripts/gate_report.py axioms` with it as the previous run lists **153 records added, every one CLEAN, none removed, none
  changed** (`data/fs131/ml/axioms-vs-main-final.txt`); 3,654 + 153 = 3,807; clean 3,633 + 151 = 3,784; axiom-free 12 + 2 = 14 (`BranchGerms.mem_gapGerm`,
  `mem_gapSec`); imported 4 and purchases 5 unchanged (no `axiom`, no `native_decide`: the purchases are rung A's five). The prediction written before
  the run (from IMM4's stage-12 receipt: 151 `MergeMove` records, 2 axiom-free, plus the 2 restored on the three) was these four numbers exactly.
  **MERGE's records** (`tools/fs131_ml_axioms.py`, new: the names of `scripts/Axioms.lean`'s `MergeMove` block plus the two restored, read in the gate's
  saved log with IMM4's parser): **153 records, 140 on exactly `[propext, Classical.choice, Quot.sound]` — `exists_merge` and `exists_merge_aux` among
  them — 11 on fewer, 2 on none; PASS** (`data/fs131/ml/merge-axioms-final.txt`); its `--plant` (a `sorryAx` added to `exists_merge`'s record,
  `merge_allowedCone`'s dropped) FAILS naming both (`merge-axioms-plant.txt`). `tools/fs131_imm_decls.py --check`: "all 151 theorems of MergeMove
  audited in 2 files". **`--self-test`**: "23 controls … OK — every planted fault fired, and every partner passed", exit 0
  (`build/gate/axioms-self-test/20261005T092316Z-2985167.log`; driver `data/fs131/ml/axioms-selftest-final.log`); its expected counts read the
  library's one declared import, which MERGE does not move, so `scripts/axioms-controls.txt` is unchanged.
- **Vacuity** (`scripts/vacuity.sh`): "**vacuity: OK**", exit 0: `declarations=11026 refutations-skipped=113 sites=770`, `vacuous=0 stale=0 declared=3
  witnessed=32 generic=733 unknown=2`; "recorded counts in scripts/vacuity-baseline.txt's header: match (9 of 9 compared)"; against Stage 14's run
  "counts: unchanged, rows: none changed" (`build/gate/vacuity/20261005T092450Z-2995244.log`, copy `data/fs131/ml/vacuity-scan-final.log`; digest
  `data/fs131/ml/vacuity-final.log`). **Reconciled row for row** against `main`'s gated scan (WL1's `fs131-ww/build/gate/vacuity/20261005T041457Z-1309134.log`,
  `sites=755`) by **`tools/fs131_ml_vacdiff.py`** (new): 830 rows of `main`'s, **0 lost**; **15 added, every one a MERGE declaration's: SITE GENERIC on
  `F.Valid` 13, on `F.Condition5` 2** (among them `exists_merge`, `exists_merge_aux`, `merge_allowedCone`, `exists_gap`, `merge_condition5`); no
  EVIDENCE row added; PASS (`data/fs131/ml/vacdiff-final.txt`); its `--plant` (a `main` row dropped, a non-MERGE row added) FAILS naming both
  (`vacdiff-plant.txt`). **The scan's other counts by its own logic** (`data/fs131/ml/count-merge.lean`, `isRefutation` copied from `scripts/Vacuity.lean`,
  over `MergeMove` and the two restored names): **175 declarations, 2 refutations** (`merge_valid`, `isClear_chain` — a conclusion `F'.Valid` or
  `IsClear` reduces to `… → False`, WL1's noted reading) = 11026 − 10851 and 113 − 111 exactly (`count-merge.out`). Witnessed, declared, vacuous, stale,
  unknown unchanged (32, 3, 0, 0, 2 — the baseline's two `hexShell` entries). **MERGE's carriers** decided by the procedure (`scripts/Vacuity.lean`,
  "MERGE's carriers (FS131-ML1 …)"): no new carrier IN — `BranchGerms.Phantom` OUT (a predicate of written-down germ data, both values spec
  examples, taken only negated at a variable chart) with `MergeMove`'s data definitions; its 15 sites are on `Valid` and `Condition5`, already IN. So
  no control is added (the last on `main` stays 62). **`--self-test`**: "OK — all 62 controls behaved", exit 0
  (`build/gate/vacuity-self-test/20261005T092559Z-3000462.log`; driver `data/fs131/ml/vacuity-selftest-final.log`). **Negative control**:
  `ArcMap.Condition5` misspelt in `trackedProps` (`Condition5X`), the self-test run: "FAIL — 3 of 62 control(s) did not behave as designed",
  exactly the `Condition5` controls (`planted_vacuous_condition5`, `planted_generic_condition5`, `planted_unknown_condition5`), exit 1
  (`data/fs131/ml/vacuity-selftest-plant-misspelt.log`); the file restored from a copy (`cmp` identical) before the green runs.
- **Architecture**: `tools/check_architecture.py` "RESULT: PASS", exit 0 (`data/fs131/ml/arch-final.txt`). Negative control: `MergeMove`'s row removed in
  a copy-edit — "missing: ['Plane/ValidMap/MergeMove']", "FAIL module coverage", exit 1 (`arch-plant.txt`); restored, `cmp` identical.
- **The restore and the statements on `HEAD`**: `tools/fs131_ml_restore.py --rev HEAD` PASS (`restore-check-final.txt`); `fs131_im_statements.py --check`,
  `fs131_im_split.py --check` PASS (Stage 14; no `.lean` changed since).

**The baseline header** (`scripts/vacuity-baseline.txt`, written in Stage 14's commit from `scripts/gate_report.py header` on the merged run):
`declarations=11026  refutations-skipped=113  sites=770` / `vacuous=0 stale=0 declared=3 witnessed=32 generic=733 unknown=2`.
