# FS-131 — the collar bend's construction: the kernel plan (de Bruijn, the planner)

*Job FS131-KP2, de Bruijn (Opus 5.5), launched 2026-10-05 on branch `fs131-w5` at `ae881022` (worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5`). Brief `data/fs131/briefs/FS131-KP2-collar.md` (on `main`), with
`plans/STANDING-RULES.md`, `LEAN.md` and `RUNNING.md` § Building. No fence (inventory ruling 1). Working files `data/fs131/kp2/`; tools
`tools/fs131_kp2_*.py`.*

## Theorems this phase proved

None yet (updated at each saved stage). A planning job: it lays `bend_toward_collar` out as named children with `sorry` at each; a child
short enough to prove here is proved and listed here with its grade and address.

## Stage 1 — SAVED: the readback, the as-given build, and what this job plans

### 1.1 The brief's quotations against their sources (standing rule 3)

Checked by script, 2026-10-05: `tools/fs131_kp2_quotes.py` reads each quotation from the brief itself (the `> ` line above each
`> — source:` line) and requires it verbatim in the source the brief names — the leaf at `ae881022`, KB2's record at `ae881022`, the
inventory and `CLAUDE.md` on `main`. Result `data/fs131/kp2/quotes.txt`: **PASS, 9 of 9 verbatim**; `--self-test` changes one character in
each quotation in turn and requires the check to fail: **9 of 9 plants fired** (`data/fs131/kp2/quotes-selftest.txt`).

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "Do not consider Lean formalization a cost. …" | `CLAUDE.md` § Counter-priors | verbatim (two sentences of Kooshi's longer quotation) |
| 2 | "theorem bend_toward_collar (hF : F.Valid) {P : ℂ} …" | `Plane/ValidMap/BendCollar.lean` at `ae881022` | verbatim (its first line) |
| 3 | "- **The lens boundary `β`**: `C_A`, `C_B`, …" | `plans/FS131-I5-implementation.md` § 44.3 | verbatim (its first line) |
| 4–9 | items 359, 365, 369, 378, 386, 387 (first lines) | `plans/FS131-close-inventory.md` on `main` | verbatim |

No mismatch. One note on the brief's wording, not a defect: "Done means" item 2 lists `RingArcsWithin` among "the child's clauses"; the
statement of `bend_toward_collar` has no `RingArcsWithin` clause — R1 (`M.IsRingArc → F.IsRingArc`) is its constant-sided form. The
construction gives `M.RingArcsWithin F` anyway (every arc it adds has radius `≠ 1`), and this plan states it as a child because R1 is proved
through it (§ 3).

### 1.2 The as-given build (`ae881022`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — all 1781 modules already up to date, nothing built,
4 modules with warnings, every warning `declaration uses 'sorry'`**, exit 0 (`build/gate/build/20261005T104808Z-3479001.log`; driver log
`data/fs131/kp2/build-asgiven.log`). The `sorry` declarations: `BendCollar` 1 (`bend_toward_collar`, line 31), `HexRing` 1 (`bv_l3`),
`BaseDense` 4 (three `exists_preBend` children and `cv_exists`'s stale copy), `Terminal` 9 (stale; the `Terminal` lane's).

### 1.3 What this job plans, and what it may change

**Planned**: the construction of `ArcMap.bend_toward_collar` (`Plane/ValidMap/BendCollar`), whose statement is fixed — reduced to named
children, each with `sorry`, each read back against what its consumer needs, a plan and a price per child, the obligation pass, inhabitants
for any structure a child takes as a hypothesis, and a handoff that two implementers can split by file. A child provable in about an hour is
proved here.

**May change**: `Plane/ValidMap/BendCollar.lean` (new declarations; `bend_toward_collar`'s docstring and statement byte-for-byte unchanged,
checked by script), new modules upstream of it, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-I5g",
extended), this record, `tools/fs131_kp2_*.py`, `data/fs131/kp2/`, `data/fs131/reports/FS131-KP2.md`.

**May not change**: any declaration `main` brought (new declarations only — so `bendMap`, `cutArcs`, `toward_clear`, `bend_toward` are cited
or re-proved under new names, never edited); `BaseDense` (the remaining `exists_preBend` children are another job's), `HexRing`,
`BaseWalk`, `Terminal`. No merge of another branch, no gate run, nothing on `main`. No new `axiom`, no `native_decide`.

## Stage 1 — SAVED

## Stage 2 — SAVED: the route checked (D1 against the clauses and against `main`'s machinery)

### 2.1 Read back: what each clause needs, and where D1 meets it

The construction as laid out here (the skeleton, § 3) is KB2's D1 with one change of frame: **the bent map is `F`'s image under the
homeomorphism** (`ArcMap.pushforward`: same domain, arcs `cutArcs ∪ {collarArcA, collarArcB}`, colour `F.col ∘ h⁻¹`), not a `bendMap` with
a recoloured lens. D1 already says "the bent map as the image of the old one"; taking it literally makes clauses 4–6 topology, with no case
on the lens.

| clause of `bend_toward_collar` | how the construction meets it | `main`'s machinery reused | new children |
|---|---|---|---|
| 1 `M.Valid` | `Valid.of_agreesOff` on the closed lens; its points are `c'` in `M`, clear for `c'` in `F` (open lens: `toward_clear`, the lens being under the toward profile; open arc: `ne1_region`), no two `1` apart (radii `≤ 1`, angles within `60°`) | `Valid.of_agreesOff`, `toward_clear`, `n2_env_toward`, `n2_env_near`, `ne1_region` | `map_valid`, `map_agreesOff`, `map_lens`, `one_sub_lensProf_le`, `dist_lt_one_of_mem_polarSet`, `CollarFit.clear` (in `exists_collarFit`) |
| 2 `M.dom = F.dom` | definitional (`rfl`) | — | — |
| 3 `h = id` off `thickening ε α` | `h = id` off the collar `K`, and `K ⊆ thickening ε α` | — | `homeo_eq_self`, `pushHomeo_eq_self`, `CollarFit.sub_thick` |
| 4 `h` fixes `Γ ∖ α°` | `Γ ∩ K ⊆ α` (`CollarFit.free`) and `h` fixes the ends | — | `homeo_fix_Γ` |
| 5 interior points and colours carried | `M.interiorPts = h(F.interiorPts)`, `M.col ∘ h = F.col` | — | `pushforward_mem_interiorPts_iff`, `pushforward_col_apply` (proved) |
| 6 `coloursAt` carried | a homeomorphism carries closures of classes | — | `pushforward_coloursAt`, `pushforward_region` |
| 7–8 degree, repeated colour | **computed at each point, never transported by `h`** (sector counts read balls): off `K` the maps agree near the point; inside `K` interior points have degree 1; `α°` and `β°` have two-germ charts with sectors `c`, `c'`; at the ends `M`'s chart is `F`'s with `α`'s germ curvature `1 ↦ ±1/R` | `localSectors_disj`, `isSectorChart_of`, `IsSectorChart.hasDegree`, `IsSectorChart.encard_sectorsOf`, `exists_eq_branchPt_curveGerm`, `branchPt_curveGerm_mem`, `exists_germDir_ne_of_ne`, `carrier_germArc`, `not_hasRepeatedColour_of_mem_interiorPts` | `map_hasDegree`, `map_hasRepeatedColour`, `hasDegree_iff_of_agree`, `hasDegree_iff_of_mem_interiorPts`, `degree_openArc`, `map_degree_lensCurve`, `map_degree_end` |
| 9 R1 | the arc lies in `F.Γ` (`M` creates no unit arc: `β` has radius `R ≠ 1`); its sides change only at the ends, where the collar's horn lies on one side of `ω(Q)` | `ringArcsWithin_of_Γ_subset`, `germArc_isUnitArc_iff` | `map_R1`, `map_ringArcsWithin`, `sides_end` |
| 10 R2 | the closed arc misses `α°` (an end on `α°` is excluded by `hfree`), so lies in `M.Γ`; sides as in R1 | `mem_cutArcs_iff` | `map_R2`, `map_Γ` |
| 11 R3 | `α°` lies in the lens, interior in `M` | — | `map_R3` |
| 12 no new inert arc | only `c` is lost, only on `lensSet`; a unit arc centred there never has `c` on a side | `lock`, `Valid.dist_ne_one_of_isOpen_subset_closure` | `map_inert`, `coloursAt_subset`, `side_ne_inner_of_mem_lens` |

**No clause D1 cannot meet.** Checked in particular: (a) `c = c'` is allowed by the statement (no hypothesis excludes it); every degree child
reads the sector colours as a list (`c` and `c'`), so `c = c'` needs no case. (b) An end where `α`'s germ is the only germ (then `c = c'`): the
germ swap is uniform (the sector before `i` is the sector from `i`). (c) An end where another germ has `α`'s direction: its curvature is not
`1`, so `R'`, `R''` (and `R` between them) can be taken nearer `1` than it — finitely many germs. (d) `ε` arbitrary: the collar is chosen inside
`thickening ε α ∩ dom` (`α` compact in the open domain). (e) The ends are fixed by `h`: `A = P + e(θ₁)` is a polar point only at angles
`≡ θ₁`, none in `(θ₁, θ₂)`.

### 2.2 Findings

1. **Generalization — `hmax` is not read by the construction** (grade: [reading], the planner's; its killing test is the proof of the
   children, none of which takes `hmax`). Maximality is what `exists_preBend`'s measure needs, not what the bend needs: a non-maximal `α`
   bends the same way (at an end where `α` continues with the same sides, the chart swap is the same). `hlen` is implied (`l60_le`, KB2).
   The assembly reads both once (`have _ := hlen`, `have _ := hmax`, the repository's convention for a hypothesis the statement keeps and the proof does not need; a `clear` left the unused-variable linter firing, build 1). Nothing downstream changes: `exists_preBend_step` supplies both anyway. Sent to the
   coordinator mid-job.
2. **`toward_clear` and `n2_env_*` are public on this branch** (since the merge with `main`): KB2's "~30 lines to re-prove under a new name"
   is not needed; `toward_clear` is cited as it stands.
3. **`main`'s `bendMap` is not reused** (only its cut engine `cutArcs`, `cutArcs_locallyFinite`, `mem_cutArcs_iff`, `exists_kept_of_mem_openArc`,
   and its validity engine `Valid.of_agreesOff`): the pushforward frame replaces `bend_hlc`'s case analysis by one topological lemma
   (`pushforward_locallyConstant`), and KB2's "the collar lens inside `main`'s crescent `L`" is not needed — clearness comes straight from
   `toward_clear` at each lens point, and pairs from a polar bound.
4. **The bi-Lipschitz condition of I5o's notes (§ 41.2 (c)) is not needed**: no sector count is carried by `h`; each is computed from a chart
   at its point (§ 2.1, clauses 7–8).
5. **`RingArcsWithin`** (the brief's word) is not a clause; the construction proves `M.RingArcsWithin F` (`map_ringArcsWithin`) as R1's
   first step.

## Stage 2 — SAVED

## Stage 3 — SAVED: the skeleton

Three modules, upstream of `BaseDense` (map: `ARCHITECTURE.md`, `tools/check_architecture.py` exit 0):

- **`Plane/ValidMap/RadialPush`** (new; imports `UnitArc`, `Surgery`) — pure geometry: `polarSet`; `tent`, `push1` (`push1_mid`,
  `push1_of_not_mem` proved; `push1_push1`, `push1_image_Ico`, `push1_image_Ioc`); `PushProfiles` (a structure taken as a hypothesis — its
  inhabitant is `pushProfiles_collar`), `polarAngle`, `pushFun`, `pushInv`, `pushHomeo` (a def over four children: `pushInv_pushFun`,
  `pushFun_pushInv`, `continuous_pushFun`, `continuous_pushInv`), `pushHomeo_polar`, `pushHomeo_eq_self`, `pushHomeo_image_polarSet`; D1's
  `tangRad` (`tangRad_zero` proved; `tangRad_spec`, `tangRad_lt_one`, `one_lt_tangRad`, `tangRad_lt_tangRad`, `one_sub_tangRad_le`,
  `tangRad_sub_one_le`), `clampAngle`, `lensProf`, `outerProf`, `pushProfiles_collar`, `one_sub_lensProf_le`; the sets `collarK`,
  `lensSet`, `lensCurve`, `collarMid`, the arcs `collarArcA`, `collarArcB` (`germArc`s) with `collarArcs_carrier`;
  `dist_lt_one_of_mem_polarSet`. Spec examples: `polarSet` membership, `tent 0 1 2 1 = 1`.
- **`Plane/ValidMap/Pushforward`** (new; imports `Surgery`) — `ArcMap.pushforward` (a def over `pushforward_locallyConstant`);
  `pushforward_Γ`, `pushforward_mem_interiorPts_iff`, `pushforward_col_apply` proved; `pushforward_interiorPts`, `pushforward_region`,
  `pushforward_coloursAt`; `hasDegree_iff_of_agree`, `hasDegree_iff_of_charts`, `hasDegree_iff_of_mem_interiorPts`.
- **`Plane/ValidMap/BendCollar`** (extended; now imports both) — `CollarFit` (a Prop structure: the collar's fit to the map; inhabitant
  `exists_collarFit`, at a model map to be built, § 4 child B0), `exists_collarFit`, `kin_subset`, `kout_subset`, `pushProfiles` (proved),
  `homeo` (def), `homeo_eq_self`, `homeo_ringPt`, `homeo_fix_Γ`, `homeo_image_dom`, `collarArcs` (def), `collarArcs_nondegenerate`,
  `collarArcs_locallyFinite` (proved), `collarArcs_Γ`, `map` (def), `map_Γ`, `map_lens`, `map_agreesOff`, `map_valid`, `degree_openArc`,
  `map_degree_lensCurve`, `map_degree_end`, `map_hasDegree`, `map_hasRepeatedColour`, `map_ringArcsWithin`, `sides_end`, `map_R1`,
  `map_R2`, `map_R3`, `coloursAt_subset`, `side_ne_inner_of_mem_lens`, `map_inert`. **`bend_toward_collar` is proved over them** (its
  `sorry` replaced by the assembly: `have _ := hlen`, `have _ := hmax`, `exists_collarFit`, then one `refine` citing a clause lemma per clause).

Statement: `tools/fs131_kp2_stmt.py` — the block from `/-- **The collar bend**` to `:= by` byte-identical to `ae881022`, one declaring
file, no `axiom` and no `native_decide` in the three modules: PASS; `--self-test` (a changed hypothesis, a changed docstring letter, a
second declaring file, an `axiom` line): 4 of 4 fired. `scripts/Axioms.lean`: 61 lines added after the FS131-KB2 lines of the block
headed "FS131-I5g". Build: § 3.1 (filled when it lands).

## Stage 3 — SAVED

## Stage 4 — SAVED: a plan per child

Prices are lines of Lean, read from the neighbouring proofs on this branch (`bend_toward` is ~190 lines over its children; the cut engine
~180); per `LEAN.md`, re-price from the first two leaves. Lemmas cited were read in their source on this branch at `ae881022`
(`UnitArc`, `Surgery`, `LocalStructure`, `Sectors`, `Basic`); the skeleton elaborates with every citation in a statement, and the ones only in
routes are named with their file. Hard = needs an idea beyond assembly.

### RadialPush (pure geometry) — about 1,450 lines

| child | route | cites | price | hard |
|---|---|---|---|---|
| `push1_push1` | split `t ≤ a`, `a < t ≤ m`, `m < t < b`, `t ≥ b`; on each piece `push1` is affine with image the matching piece for `m'`; `field_simp`, `linarith` | `push1_of_not_mem`, `push1_mid` | 60 | — |
| `push1_image_Ico`, `_Ioc` | monotone and continuous on the piece, ends to ends (or by `push1_push1` both ways) | `intermediate_value_Icc` | 60 | — |
| `pushInv_pushFun`, `pushFun_pushInv` | child `polarAngle_polar : |θ − φ| < π → 0 < t → polarAngle P φ (P + t e θ) = θ` (`arg` of `t e(θ − φ)`, `Complex.arg_real_mul`, `arg_exp_mul_I`-style, as in `toward_polar`); `z = P + ‖z − P‖ e(polarAngle z)` (`eq_polar_frameDir`); `push1` keeps radii positive (`0 < a`); then `push1_push1` | `eq_polar_frameDir`, `push1_push1` | 150 | — |
| `continuous_pushFun`, `_Inv` | `pushFun z = z − (1 − l θ)·tent(a θ, 1, b θ, ‖z − P‖)·e θ`; continuity on `ℂ ∖ {P} ∩ {polarAngle away from the slit}` by composition where `l θ < 1`, and by `(1 − l θ) → 0` times a factor in `[0,1]` where `l θ = 1` (a two-line `tendsto` lemma: `f → 0`, `g` bounded ⇒ `f·g → 0`); identity on the open set `{‖z − P‖ < min a} ∪ {angle off [θ₁, θ₂]}` | `Complex.continuousAt_arg`, `ContinuousOn` piecing (`continuous_of_continuousOn_iUnion_of_isOpen`) | 250 | **yes** (the sector's edge) |
| `pushHomeo_polar`, `_eq_self`, `_image_polarSet` | `polarAngle_polar`; off the open collar `push1 = id` (`push1_of_not_mem`) | — | 150 | — |
| `tangRad_spec` | `‖t e(θ+u) − (1−R) e θ‖² = t² − 2(1−R) t cos u + (1−R)²` (`dist_polar_polar_sq` shape); the root by `Real.sq_sqrt`; the disc as `t` between the two roots, the other negative (`R > 1/2`) | `dist_polar_polar_sq` | 80 | — |
| `tangRad_lt_one`, `one_lt_tangRad`, `tangRad_lt_tangRad` | the identity `(1 − t)(t + 2R − 1) = 2(1 − R) t (1 − cos u)` (child `tangRad_identity`); `cos u < 1` for `0 < |u| ≤ π`; monotone in `R` from the quadratic's value at `tangRad R' u` | `Real.cos_lt_cos_of_nonneg_of_le_pi` | 120 | — |
| `one_sub_tangRad_le`, `tangRad_sub_one_le` | the identity, `t ≤ 1` and `t ≥ 2R − 1`; `1 − cos u ≤ u²/2` (`Real.one_sub_sq_div_two_le_cos`) | — | 100 | — |
| `pushProfiles_collar` | continuity by composition (`clampAngle` continuous); off `(θ₁, θ₂)` the clamp is an end: one term `tangRad _ 0 = 1`, the other `< 1` / `> 1`; inside the three comparisons and `0 < tangRad R' u` | the four above | 120 | — |
| `one_sub_lensProf_le` | `1 − max ≤ min of 1 − each`; `one_sub_tangRad_le`; `u ≤ π/3 < 2` | — | 60 | — |
| `collarArcs_carrier` | `carrier_germArc`; a branch point `A + 2R sin(s/2) e(θ₁ + π/2 + s/2)` has polar angle in `[θ₁, φ]` up to `X` and radius `tangRad R (angle − θ₁)` (`tangRad_spec`'s uniqueness); on `[θ₁, φ]` the max is the `C_A` term (`tangRad` even and increasing in `cos u` there) | `carrier_germArc`, `branchPt_eq_circle` | 250 | **yes** (trig bookkeeping) |
| `dist_lt_one_of_mem_polarSet` | copy `toward_pairs`'s last ten lines on polar points | `dist_polar_polar_sq` | 40 | — |

### Pushforward (generic) — about 300 lines

| child | route | price |
|---|---|---|
| `pushforward_locallyConstant` | `h⁻¹ y ∈ F.interiorPts` (domain kept, `hΓ`), `F.locallyConstant`, `h.symm.continuous.tendsto` | 30 |
| `pushforward_interiorPts`, `_region`, `_coloursAt` | set algebra with `hΓ`, `hdom`; `h.image_closure` (`Homeomorph.image_closure`) | 80 |
| `hasDegree_iff_of_agree` | for `r ≤ r₀`, `IsSector v r S` reads `interiorPts ∩ ball v r` and the colour on it: the two sets of sectors are equal | 80 |
| `hasDegree_iff_of_charts` | `IsSectorChart.hasDegree` (both `max n 1`), `IsSectorChart.encard_sectorsOf` (both `{i | col i = c}.encard`) for `0 < n`; `n = 0`: `IsSectorChart.isSector_iff_of_zero`, no repeated colour | 60 |
| `hasDegree_iff_of_mem_interiorPts` | `localSectors` at an interior point has `n = 0` (`mem_Γ`), so degree `1`; uniqueness of the eventual count | 30 |

### BendCollar (map level) — about 3,000 lines

| child | route | cites | price | hard |
|---|---|---|---|---|
| **B0** `collarModel` (new: the inhabitant) | a fragment exercising the hypotheses with `c ≠ c'`: domain a disc of diameter `< 1` about `r([0, π/6])` (valid trivially), arcs: `ω(0)` across the disc and the two radial segments at the ends, colours swapping across each segment (so `α` is maximal with sides `0`, `1`), `1 ∉ coloursAt 0` | — | 150 | — |
| `exists_collarFit` | four children: **C1** `R` near `1` makes the lens clear (`one_sub_lensProf_le` against `n2_env_toward`, `n2_env_near` with `r` from `hout`, then `toward_clear`); **C2** the collar is thin: `K ⊆ thickening δ α` with `δ ≤ ε` and `thickening δ α ⊆ dom` (`IsCompact.exists_thickening_subset_open`); **C3** middle freeness: on `α' = r([θ₁ + τ, θ₂ − τ])` a Lebesgue number of `hfree`'s balls (`lebesgue_number_lemma_of_metric`); **C4** end freeness: `F`'s chart at `A` (`localSectors_disj`) has `α`'s germ `(θ₁ + π/2, 1)` (child: a germ whose branch meets `α` near `A` at infinitely small distances is `α`'s, by `exists_germDir_ne_of_ne`); the collar near `A` lies in the horn between `(θ₁+π/2, 1/R'')` and `(θ₁+π/2, 1/R')` (`tangRad_spec` in the frame at `A`: inside the tangent circle is `TanAbove` with curvature `1/R`, `sectorBetween_eq_hornSet`), which holds no other branch once `1/R''`, `1/R'` are nearer `1` than every other germ of that direction; the same at `B`. `short` by `l60_le`. Filters `∀ᶠ R in 𝓝[<] 1`, `∀ᶠ R'' in 𝓝[>] 1` | `toward_clear`, `n2_env_toward`, `n2_env_near`, `l60_le`, `localSectors_disj`, `sectorBetween_eq_hornSet`, `exists_germDir_ne_of_ne` | 450 | **yes** (C4) |
| `kin_subset`, `kout_subset` | the polar set is preconnected (image of `{(θ, t)}` under the polar map), `Γ`-free (`free`), in the domain, so one colour (`IsPreconnected.constant`); its closure meets `α°` from inside, where `innerColours = {c}` | `continuousOn_col` | 120 | — |
| `homeo_eq_self`, `homeo_ringPt`, `homeo_fix_Γ`, `homeo_image_dom` | `pushHomeo_eq_self` (open collar `⊆ K`); `pushHomeo_polar`, `push1_mid`; `free` and the ends; identity off `K ⊆ dom`, `h(K) ⊆ K` | — | 100 | — |
| `collarArcs_nondegenerate` | `cutArcs_nondegenerate`, `germArc_nondegenerate` (`X ≠ A`) | — | 30 | — |
| `collarArcs_Γ` | off `α°` and the ends `mem_cutArcs_iff`; on `α°` an arc of `F` through it is an arc of `ω(P)` (else `Arc.finite_inter_sphere_or_eq_circ` against `free_open` and `Arc.exists_near`), so the cut leaves nothing (`exists_kept_of_mem_openArc`); the two arcs are `β` (`collarArcs_carrier`); `h(Γ) = (Γ ∖ α°) ∪ β°` | `mem_cutArcs_iff`, `exists_kept_of_mem_openArc` | 150 | — |
| `map_Γ`, `map_lens`, `map_agreesOff` | `pushforward_Γ` with `collarArcs_Γ`; `pushforward_interiorPts`; `pushHomeo_image_polarSet` on the outer collar (`push1_image_Ioc`) with `kout_subset`, and on the inner (`push1_image_Ico`) with `kin_subset` | — | 200 | — |
| `map_valid` | `Valid.of_agreesOff` on `lensSet ∪ lensCurve`; `clear`, `ne1_region`; `dist_lt_one_of_mem_polarSet` | `Valid.of_agreesOff`, `ne1_region` | 60 | — |
| `degree_openArc` | a two-germ chart at `ringPt P θ` (`isSectorChart_of`; branches: `Γ ∩ ball = ω(P) ∩ ball` from `free_open`, the circle's two germs by `exists_eq_branchPt_curveGerm`/`branchPt_curveGerm_mem`); sector colours `c`, `c'` from `IsRingArc`'s sides; then `hasDegree_iff_of_charts` against a two-germ word, or directly | `isSectorChart_of`, `exists_eq_branchPt_curveGerm` | 150 | — |
| `map_degree_lensCurve` | the same on `C_A` / `C_B` (`map_Γ`; the collar `Γ`-free), and at `X` a two-germ chart of the two arcs' germs (transversal: distinct centres, equal radii) | — | 200 | — |
| `map_degree_end` | `F`'s chart at `A` and `M`'s chart = the same germs with `κ i := 1/R` (`isSectorChart_of`; sorted by C4's gap; branches by `map_Γ`, `carrier_germArc`); colours per sector unchanged (the sector before `i` gains the lens, colour `c'`; the one from `i` loses it, colour `c`; others untouched as `h = id` there); `hasDegree_iff_of_charts`. At `B`: `(θ₂ − π/2, −1) ↦ −1/R`, the order reversed | `localSectors_disj`, `isSectorChart_of`, `IsSectorChart.encard_sectorsOf` | 350 | **yes** |
| `map_hasDegree`, `map_hasRepeatedColour` | by the place of `z`: off `K` (`homeo_eq_self` on a ball, `hasDegree_iff_of_agree`); `K ∩ F.interiorPts` (both interior: `pushforward_mem_interiorPts_iff`, `hasDegree_iff_of_mem_interiorPts`, `not_hasRepeatedColour_of_mem_interiorPts`); `α°` (`degree_openArc`, `homeo_ringPt`, `map_degree_lensCurve`); the ends (`map_degree_end`) | — | 120 | — |
| `map_ringArcsWithin` | `ringArcsWithin_of_Γ_subset` with `A' = {collarArcA, collarArcB}`, `germArc_isUnitArc_iff` (`1/R ≠ 1`) | — | 40 | — |
| `sides_end` | near `A` the maps differ only on the collar horn with `α`'s branch (`homeo_eq_self`); the horn is preconnected (`isPreconnected_hornSet`) and misses `ω(Q)` for `Q ≠ P` (`ω(Q)`'s germs at `A`: another direction, or curvature `−1`), so lies on one side; on it both maps carry `c` and `c'` up to `A` | `isPreconnected_hornSet` | 200 | **yes** |
| `map_R1`, `map_R2`, `map_R3` | as in their docstrings | `mem_cutArcs_iff` | 240 | — |
| `coloursAt_subset`, `side_ne_inner_of_mem_lens`, `map_inert` | `pushforward_coloursAt` and the cases of `h⁻¹ Q`; `lock` (two points) and `Valid.dist_ne_one_of_isOpen_subset_closure`; R1 | `lock` | 200 | — |

**Total**: about 4,750 lines (KB2's 3,000–4,000 priced the same design without the pushforward layer, the model map and the explicit
charts). Formalization is not a cost that ranks routes (`CLAUDE.md` § Counter-priors); the price is for staffing only.

## Stage 4 — SAVED

Every lemma the routes above cite was confirmed by `#check` (`data/fs131/kp2/Checks.lean` → `checks.out`, 33 names, 0 errors; two names
first guessed wrong were corrected there: `localSectors_disj` is `HadwigerNelson.Plane.localSectors_disj`, outside `ArcMap`; there is no
`Real.cos_lt_one`, and `Real.cos_lt_cos_of_nonneg_of_le_pi` is cited instead).

## Stage 5 — SAVED: the obligation pass, and the handoff

### 5.1 The obligation pass (`debruijn-obligation-modeling`, invoked fresh for this job)

- **The space, characterized.** Twelve clauses. Seven are topology or set algebra once the bent map is `F`'s image (`pushforward`):
  2–6, R3, and the reduction of R1/R2 to the two ends. Two are metric and read per point (degree, repeated colour). Three read `F`'s
  colours (validity, inert, the sides at the ends). For the metric pair the case table is the place of `z`: off `K`, interior in `K`, on
  `α°`, at an end — four cases, all written out in `map_hasDegree`'s docstring before any tactic.
- **The statement the degree clauses derive from** — `ArcMap.hasDegree_iff_of_charts` (added to `Pushforward`): *two charts with the same
  colour word give the same degree and the same repeated-colour answer*. The tempting statement, "`h` carries sectors", is false in
  general: sectors read balls, which a radial push does not carry. The colour word holds in all four cases. Off `K` the two charts are
  equal. At interior points the word is empty. On `α°` and on `β°` it is the same two-letter word, `c` and `c'`. At an end the germ swap
  keeps every sector's colour. So the four cases become four instances of one lemma, each a few lines over its chart. This is the
  strengthening the pass looked for; the per-case proofs I first had in mind each re-proved the counting.
- **Each child strictly smaller.** The measure is the number of open clauses, plus the open inputs of each clause. Every child proves
  one clause, or one fact one clause reads (a set equality, a chart, a colour). None restates its parent. The assembly is a single
  `refine` with one clause lemma per clause.
- **The partition.** *Prove*: everything. *Test*: the spec examples (`polarSet` membership, `tent 0 1 2 1 = 1`), proved values
  (`push1_mid`, `tangRad_zero`), and, once proved, an `example` of `pushProfiles_collar` at concrete radii (`R' = 3/4`, `R = 7/8`,
  `R'' = 5/4` on `[0, π/6]`). That example catches a profile whose inequalities were stated the wrong way round. *Assume*: nothing. No
  outside theorem is imported, and no hand result of ours enters as a hypothesis. Every cited theorem (`toward_clear`, `lock`, `l60_le`,
  `n2_env_*`, `localSectors_disj`, `ringArcsWithin_of_Γ_subset`, …) is a kernel theorem on this branch, on the standard three by M5's
  receipt.
- **Smells read.**
  1. `CollarFit` repeats two of the bend's hypotheses (`ring`, `free_open`). This is deliberate: each clause lemma then takes one
     hypothesis, not five.
  2. `A` and `B` are mirror images. Formalizing the reflection about the bisector would cost more than doing both ends. The pass's
     choice: the end children (`map_degree_end`, `sides_end`, C4 of `exists_collarFit`) get one helper each, with an orientation
     `σ = ±1`.
  3. `hmax` is a dead hypothesis (§ 2.2, finding 1); the vacuity seam is checked below.
- **Mutation audit, planned for the implementers.** With `hfree` dropped, C3 of `exists_collarFit` must fail: an arc crossing `α°`
  leaves no `Γ`-free collar. With `hout` dropped, C1 must fail: `toward_clear` needs the outer class kept away from `P`. With `R < 1`
  swapped for `R ≤ 1` in `CollarFit.params`, `pushProfiles_collar` must fail (`l = 1` inside). Each is checked once the child is proved.
- **Vacuity.** `CollarFit` is a structure taken as a hypothesis, so it needs an inhabitant: child B0 (`collarModel`, § 4) with
  `exists_collarFit`. B0 has `c ≠ c'`, so the clauses about the sides are exercised.

### 5.2 The handoff (two implementers, split by file)

| implementer | files and declarations | about |
|---|---|---|
| **G, the geometry** | all of `Plane/ValidMap/RadialPush`; in `BendCollar`: `kin_subset`, `kout_subset`, `homeo_eq_self`, `homeo_ringPt`, `homeo_fix_Γ`, `homeo_image_dom`, `collarArcs_nondegenerate`, `collarArcs_Γ`, `map_Γ`, `map_lens`, `map_agreesOff`, `map_valid` | 2,250 lines |
| **C, the charts and sides** | all of `Plane/ValidMap/Pushforward`; in `BendCollar`: `exists_collarFit`, `degree_openArc`, `map_degree_lensCurve`, `map_degree_end`, `map_hasDegree`, `map_hasRepeatedColour`, `map_ringArcsWithin`, `sides_end`, `map_R1`, `map_R2`, `map_R3`, `coloursAt_subset`, `side_ne_inner_of_mem_lens`, `map_inert`, and the new child B0 `collarModel` | 2,500 lines |

- **Interfaces.** Both work against the signatures as stated. G's children are inputs to C's (C cites `map_Γ`, `map_lens`,
  `homeo_ringPt`, …), and C works while they are still `sorry`. Neither may change a statement. A change one of them needs goes to the
  coordinator, then to me.
- **Merging.** Both edit `BendCollar.lean`, in disjoint declarations: each fills in its own `sorry`s, and git merges such edits
  cleanly. Before both launch, the coordinator can remove even that overlap by moving G's block (from `CollarFit.kin_subset` to
  `map_valid`) into a new module `Plane/ValidMap/CollarMap.lean` upstream of `BendCollar`. The statements would move verbatim, checked
  the way `tools/fs131_kp2_stmt.py` checks. **Held for the coordinator.**
- **Order inside each lane, hardest first where it informs the rest.**
  - G: `push1_push1` → `polarAngle_polar` (a new child) → the inverses → `continuous_pushFun` (hard) → the `tangRad` family →
    `collarArcs_carrier` (hard) → the map-level children.
  - C: `Pushforward` (with `hasDegree_iff_of_charts` first) → `degree_openArc` (the two-germ chart pattern) → `map_degree_lensCurve` →
    `exists_collarFit`'s C4, which shares the identification of the end germ with `map_degree_end` → `map_degree_end` → `sides_end` →
    R1, R2, R3 and inert → the case splits of `map_hasDegree`/`map_hasRepeatedColour` → B0.
- **Re-price from the first two leaves** (`LEAN.md`): G from `push1_push1` and `polarAngle_polar`, C from `hasDegree_iff_of_charts` and
  `degree_openArc`.

## Stage 5 — SAVED
