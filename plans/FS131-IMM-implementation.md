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

Still open: `exists_merge_aux` (§ 4).

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
