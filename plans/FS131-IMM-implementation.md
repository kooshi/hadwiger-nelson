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

Still open: `exists_merge_aux` (§ 5.2).

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
