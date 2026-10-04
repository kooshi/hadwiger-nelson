# FS131-I3 — wave 3's implementation (de Bruijn, the implementer)

*Brief: `data/fs131/briefs/FS131-I3-wave3.md`. Branch `fs131-w3`, worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w3`. The plan:
`plans/FS131-w3-kernel-plan.md` (§ 5.2 the read-backs, § 6 the leaf plans, § 7 the handoff). Nothing in this milestone is blind.*

## Theorems this phase proved

Sorry-free by the scratch audit (iteration only, **not the gate**: `#print axioms` over scratch oleans, every one of the 99
sorry-free records of `scripts/Axioms.lean`'s wave-3 section reads `[propext, Classical.choice, Quot.sound]` or fewer; the saved
gate log is still to be read at the milestone's gate). Declarations are `HadwigerNelson.Plane.ArcMap.*` unless marked. Row, then
declarations, read against `plans/FS131-w3-kernel-plan.md` § 5.2 (every statement as the skeleton gave it; none changed):

- **FS116-V5-NE1** — `ne1_region`, `IsTile.subset_ball`, `IsTile.closure_subset_closedBall`, `IsTile.dist_lt_one`. Same, strengthened.
- **FS116-V4-DICHOTOMY** — `unitNear_or_unitFar`, `IsTile.unitNear_self`, `IsTile.dist_le_one_of_mem_closure`, `unitNear_of_mem_closure`,
  `unitFar_of_mem_closure`, `NonSiamese.eq_of_unitNear`. Same.
- **FS116-V4-MEET** — `unitNear_iff_of_mem_closure_inter`. Same.
- **FS116-S1-CLUSTER** — `cluster`. Same.
- **FS129-OR1-WHOLE** — `Valid.wholeRestrict`, `wholeRestrict_covers`, `isTile_wholeRestrict_iff`, `isTile_wholeRestrict_of_mem_closure`,
  `NonSiamese.wholeRestrict`, `Simple.wholeRestrict`, `not_mem_closure_wholeRestrict_of_inner`, `not_mem_closure_wholeRestrict_R₂`. Same, strengthened.
- **FS116-V4-TWIST** — `not_germIn_closure_rotate`, `not_mem_coloursAt_of_mem_sphere`. Stronger.
- **FS116-N1-TWIST-D** — `isClosed_ringD`, `ringD_subset_Γ`, `finite_ringD_off_ringArc`. Same, strengthened.
- **FS116-N1-GERM-R** — `germR_vMinus`, `germR_vPlus`, `germR_uMinus`, `germR_uPlus`. Stronger.
- **FS116-N1-GERM-S**, first clause only — `germS_absent` (the other three clauses are open).
- **FS116-N2-FIVERING**, two clauses — `fiveRing_no_changePoint`, `fiveRing_no_hub`.
- **FS129-SR1-SIXQ** — `sixQ_sphere_subset_Γ`, `sixQ_sides`, `sixQ_isQArc` (`sixQ_inhabited` waits on `sixFrag`).
- **FS116-N1-ECHO** — `echo_unique`, `echo_of_mem_closure`, `echo`. Same, strengthened.
- **FS116-V5-U1**, five clauses — `ringArc_cone_inner`, `ringArc_cone_outer`, `ringArc_sideCone_inner`, `ringArc_sideCone_outer`,
  `ringArc_sideCone_other` (with `hz : z ∈ F.dom`, § 5.3).
- **FS129-SR1-RINGBAND**, the map bridge — `ring_finite_S`, `ring_locallyConstant`, `ring_proper`; `ringCircleColouring` is now sorry-free.
- Foundation children (not rows): `Valid.dist_lt_or_gt_of_isPreconnected` (engine 1), `mem_closure_tile` (engine 2), `Valid.false_of_crossing`,
  `Valid.cone_re_nonneg_of_germ`, `Valid.cone_re_nonpos_of_germ`, `Valid.cos_nonneg_of_radial_inner`, `Valid.cos_nonpos_of_radial_outer`,
  `exists_mem_coneAt_region`, `covers_one_iff`, `finite_ringΓ_off_ringArc`, `dense_interiorPts`, `exists_mem_coloursAt`,
  `Arc.finite_inter_sphere_or_eq_circ`, `Arc.volume_carrier`, and the supporting lemmas (full list: `tools/fs131_k3b_decls.py`).

- **FS129-SR1-RINGBAND** (FS131-I3b, all twelve leaves; axioms `[propext, Classical.choice, Quot.sound]` read from
  `data/fs131/i3/axioms-stage2.out`, log `build/gate/axioms/20261004T083504Z-2241407.log`) — `exists_lift`, `ringband_i`, `ringband_ii`, `W_eq`,
  `ringband_iii`, `ringband_iv`, `ringband_v`, `ringband_vi_periodic`, `ringband_vi_noJump`, `exists_swap_of_abs_W_le_one`, `W_mod_six`,
  `exists_pair_of_abs_W_le_two` (all `HadwigerNelson.Plane.CircleColouring.*`), hence `ArcMap.exists_swap_of_ring`. Same statements as § 5.2 **except
  `ringband_iv`'s second conjunct**, which carries the added hypothesis `∀ x ∈ C.S, ¬ ∃ v, C.LeftVal x v ∧ C.RightVal x v` under the coordinator's
  ruling (inventory item 61; counterexample: `hexColouring` with `S` padded by the points `0.1 + 2πk`, `W = 2`).
- **FS116-Y2-SIXFRAG**, partial (FS131-I3b) — `sixArcs_nondegenerate`, `sixArcs_locallyFinite`, the three spec examples, `sixFrag_coloursAt_zero`,
  `sixFrag_isQArc`, `sixFrag_isRingArc`. Their axiom lists still read `sorryAx` for the declarations that mention `sixFrag` (its `locallyConstant`
  field is the open `sixCol_locallyConstant`); the proof terms themselves use no other sorry.
- **FS116-S1-EXIT** (FS131-I3c; axioms `[propext, Classical.choice, Quot.sound]` read from `build/gate/axioms/20261004T092614Z-2442823.log`, build
  `build/gate/build/20261004T091636Z-2402026.log`) — `exit_lens`, `exit_lens_row` (both `HadwigerNelson.Plane`), children `lens_stepA`, `lens_stepB`, `lens_core`,
  `deriv_nonneg_of_leftmax`, `re_conj_mul_nonneg_of_exit`, `im_leftNormal_mul_conj`. Same statements as § 5.2; hypotheses `hne`, `h3'`, `h5'` (and the row's `h0`) are idle
  (the lens itself pins the exit's side), read once so the unused-variable linter stays silent.
- **Germ dichotomy** (FS131-I3c; same log) — `ArcMap.germ_dichotomy` with children `exists_ball_finite`, `finite_nonring_inter_sphere`, `exists_ball_onRing`,
  `exists_sides_nbhd`, `sides_const`, `polar_nbhd`, `exists_germ_subset_ringArc` and the angle/germ lemmas (`e_eq_e_iff`, `e_ne_one`, `dist_lt_of_mem_germ`,
  `ringPt_notMem_germ`, `isPreconnected_germ`). Same statement.
- **FS116-Y4-FLANK**, three of four (FS131-I3c; same log) — `ArcMap.flank_initialPieces`, `ArcMap.flank_cone` (children `initialPiece_cases`, `sq_norm_pieceB`,
  `sq_norm_pieceB'`, `cos_nonneg_of_mem_coneAt`, `isClosed_coneAt`, `mem_angleIcc_of_cos_nonneg_single`) and `ArcMap.flank` (its audit line reads the standard three);
  `flank_edge_exists` is open. Same statements.

**Reduced to a sorry'd parent, so not yet sorry-free**: `ringQPrimeS` (on `germS_four`), `flank` (on `flank_initialPieces`),
`four_of_bothKind_simple` (on `four_of_bothKind` and `Simple.coneAt_eq_angleIcc`). These three are finished arguments; they close when
their parents do.

## Stage 1 — SAVED: the leaves that need no sector structure (this job's first context)

**Where it stands: 55 of the 96 skeleton leaves proved, 41 `sorry` left, build state in § Build.** Commits `ad579aba` … `9c05ad08` on
`fs131-w3`. `scripts/Axioms.lean`'s wave-3 section regenerated from `tools/fs131_k3b_decls.py` (146 names, `--check` 0 missing).

### The three engines, as built

1. **Engine 1** (`Valid.dist_lt_or_gt_of_isPreconnected`, `Plane/Tiles`) and its closure-point form **`Valid.false_of_crossing`**
   (`Plane/RingGerm`): a point `a` of the closure of one class and a preconnected `S` in that closure cannot hold a point nearer than 1 to
   `a` and one farther. Every "N-E1 against a curve" step is this lemma plus two points. Instances done: TWIST (germ against its rotation),
   ECHO (arc through `w`; the derivative along the arc is the quantity `Im((x−p) conj e ψ)`, exact identity `‖B − eτ‖² − 1 = −2(b₁(cos τ − 1) + b₂ sin τ)`),
   V5-U1's cones (the radial segment, `cos_nonneg_of_radial_inner` / `cos_nonpos_of_radial_outer`), and GERM-R (below).
2. **Engine 2** (`mem_closure_tile`, `Plane/LocalStructure`): a ray `x + s w`, `w = 1 + λ i` with `λ` off the finite set of segment slopes, meets the
   finitely many nearby arcs in finitely many points (`subsingleton_ray_inter_segment`, `finite_ray_inter_sphere`), so a short initial
   piece lies in the interior points and in one tile. No sector structure needed.
3. **Engine 3** (`localSectors`): **not started** — see the open list.

### What GERM-R turned out to be (a simplification worth keeping)

The four clauses are two lemmas: **`Valid.cone_re_nonneg_of_germ`** (germ points farther than 1 from `y`) and **`…_nonpos_…`** (nearer).
Their proof does not need the first-order expansion the plan priced as H: engine 1 at the cone's own point `z ∈ region c` forces
`‖z − w₀‖ ≥ 1` (resp. `≤ 1`) by the limit `t → 0` along the germ, and `‖y − w₀‖ = 1` gives `Re((y−w₀) conj e β) ≥ 0` (resp. `≤ 0`) along the
cone (`cone_expand`). The four instances are trigonometry (`ringPt_sub_ringPt_minus_third`, `…_plus_third`). The same pattern should settle
TOUCHW's `X`-clause and GERM-S's step "carrying only absent colours it carries `X`".

### Open: the 41 leaves, grouped by what they need

| module | leaves | need |
|---|---|---|
| `LocalStructure` (5) | `finite_tiles_near`, `mem_coloursAt_iff_exists_tileOf`, `coneAt_region_eq_biUnion`, `germ_dichotomy`, `Simple.coneAt_eq_angleIcc` | engine 3 (`localSectors`) for the first, third, fifth; `germ_dichotomy` is M without it (finitely many arcs meet `ω(p)` off the ring arcs: `Arc.finite_inter_sphere_or_eq_circ`; a short germ avoids them; the ring-arc case needs a strip free of `Γ`, by compactness of a closed sub-arc) |
| `SixFragment` (11) | `sixArcs_nondegenerate`, `sixArcs_locallyFinite`, `sixCol_locallyConstant`, three spec examples, `sixFrag_valid`, `sixFrag_nonSiamese`, `sixFrag_coloursAt_zero`, `sixFrag_isQArc`, `sixFrag_isRingArc` | exact arithmetic over ℚ(√3, √7); `sixFrag_sphere_subset_Γ` is proved (it reads `sixFrag` and so is sorry-free only once the three `sixArcs_*`/`sixCol_*` leaves are) |
| `RingGerm` (11) | `germS_inward`, `germS_outward`, `germS_four`, `qfree4`, `fiveRing_finite_off_Q`, `fiveRing_length`, `touchW`, `four_of_bothKind`, `flank_cone`, `flank_edge_exists`, `flank_initialPieces` | `germ_dichotomy`, `exists_mem_coneAt_region` (done), the half-plane lemmas (done); `flank_cone` needs the tangent cone of a closed unit disc (`coneAt_subset_of_subset_closedBall`) and `isClosed_coneAt`; `flank_edge_exists` needs engine 3; `four_of_bothKind` needs `coneAt_interiors_disjoint` (engine 3) |
| `Lens` (2) | `exit_lens`, `exit_lens_row` | `HasDerivWithinAt.norm_sq` and the angle bookkeeping of plan § 6.2 |
| `RingBand` (12) | `exists_lift`, `ringband_i` … `ringband_vi_noJump`, `W_eq`, `exists_swap_of_abs_W_le_one`, `W_mod_six`, `exists_pair_of_abs_W_le_two` | the circle-colouring combinatorics (sorted events of a period; `Finset` induction); the map bridge is done, so `exists_swap_of_ring` closes with `exists_swap_of_abs_W_le_one` |

### Re-pricing, from the first hard leaves (brief: "re-price from your first two hard leaves")

The plan priced GERM-R as eight-grade H; it was two lemmas of about 90 lines each and four short instances, because engine 1 applies at the
cone point itself. `echo_unique` (plan: M) was one ~120-line proof. The V5-U1 cones took one arithmetic lemma per side (the outer one needed its
arithmetic split into two pure-real lemmas to stay under the heartbeat limit; do the same for any `nlinarith` block over a dozen hypotheses).
`finite_tiles_near` and `Simple.coneAt_eq_angleIcc` stay the real cost; I did not reach them. Estimate for a successor: `localSectors` is the
critical path for 6 of the 41 leaves; everything else in `RingGerm`, `Lens`, `RingBand`, `SixFragment` is independent of it except
`flank_edge_exists` and `four_of_bothKind`.

### Iteration setup that worked (for the successor)

`lake env lean` rebuilds nothing, and `lake env` overrides `LEAN_PATH`. A scratch tree of oleans: `cp -rs` the worktree's
`.lake/build/lib/lean/Proofs` into a scratch directory, `rm` the symlink of a module, compile it there with
`LEAN_PATH=<scratch>:$(lake env printenv LEAN_PATH) <toolchain>/bin/lean -o <scratch>/Proofs/HadwigerNelson/Plane/X.olean X.lean`, and invoke
`lean` directly (not through `lake env`) so that dependents see the new olean. A whole module checks in about 2 s. **Never evidence**: the
gate is `./scripts/build.sh` under the slot.

### Vacuity step (brief § The vacuity step; T2 landed on `main`, `66f679a6`)

Not reached: it is the last step, after the last leaf. The planner's recommendation stands unchanged until the proofs exist
(IN for `IsRingArc`, `IsChangePoint`, `IsHub` with controls; OUT for `CircleColouring`, `Lift`, `IsTile`, `TileOf`, `GermIn`). Merge `main` first (it
now holds T2's version of `scripts/Vacuity.lean`; wave 2's implementer will add entries to the same `trackedProps` list, so keep both sides).

## Stage 2 — SAVED (FS131-I3b): RingBand sorry-free; SixFragment's easy half; the audit run

Branch `fs131-w3`, commits after `8a850e85`. **41 leaves at the start, 21 `sorry` declarations now** (build `data/fs131/i3/build-stage2-full.log`,
"build: OK", warnings only `declaration uses sorry`; scratch iteration script `data/fs131/i3/iter.sh`).

### What is left (21)

| module | leaves | what each needs (from this job's reading) |
|---|---|---|
| `LocalStructure` (5) | `finite_tiles_near`, `mem_coloursAt_iff_exists_tileOf`, `coneAt_region_eq_biUnion`, `germ_dichotomy`, `Simple.coneAt_eq_angleIcc` | engine 3 (`localSectors`), not started; `germ_dichotomy` is M without it |
| `SixFragment` (3) | `sixCol_locallyConstant`, `sixFrag_valid`, `sixFrag_nonSiamese` | exact plane geometry. Tools now in the file: `arg_polar`, `norm_polar`, `dist_polar_sq`, `sixCol_sector`, `sixCol_inner_zero`, `sixCol_outer_two`, `sixFrag_mem_interiorPts`, `e_notMem_lens_union`. `sixCol_locallyConstant` needs: off the arcs, `arg`'s floor and round are locally constant (rays `60°j` are segments inside the disc and lie in lenses outside; rays `60°j+30°` outside lie in gaps where the round is unread) |
| `RingGerm` (11) | `germS_inward`, `germS_outward`, `germS_four`, `qfree4`, `fiveRing_finite_off_Q`, `fiveRing_length`, `touchW`, `four_of_bothKind`, `flank_cone`, `flank_edge_exists`, `flank_initialPieces` | unchanged from the stage-1 table; none attempted in this job. `flank` and `ringQPrimeS`, `four_of_bothKind_simple`, `sixQ_inhabited` close with their parents |
| `Lens` (2) | `exit_lens`, `exit_lens_row` | not attempted (calculus on `‖γ − y_b‖²` at the exit, then the angle bookkeeping of plan § 6.2) |

### How RingBand was proved (for the record; reusable)

Everything rests on **one-sided sides of the lift**: `Lift.Sides x l r` (left value, right value, equal to `f x` off `S`), `exists_sides`
(sides exist and differ by at most one), `Sides.periodic` (the jump at `x + 2π` equals the jump at `x`: both lift one change of colour, and
`|jump| ≤ 1` pins the representative mod 3), `const_of_local` (a function whose values on a dense set `T` agree near every point of a
preconnected `I` is constant on `T ∩ I`: the removable-discontinuity trick, no induction over sorted events anywhere). From these: `W_eq`;
`hex_summary` (n₂ ≡ 0 mod 3, `3h = 6 − 2n₂`, `3W = 3Σm + 6 + n₂`); `m_eq_near` (across `θ₀` the `m_j` agree when `¬PairPos θ₀`, by
`omega` on nonadjacent jumps); `m0_const` (`m₀` is constant on `T0 = {z, z+60° ∉ S}` when no step jumps by two: `hbig_of_noPair`,
`hbig_of_noSwap`); and the key reading of (iv)/(v): if `h ≠ 0` at one good `θ`, then `h` is the same `H ≠ 0` at all good `θ` (as `W` and
`M` are), so every `D₀ ≡ ρ(H) (mod 3)` on `T0` (`rho_const`), so the jumps at `x` and `x + 60°` are equal (`J_eq_of_rho`) — which gives
60°-invariance of a genuine change set (`inv_of_J_eq`) and, with no pair, makes every jump zero, against properness. `exists_lift` is
`f = val(c) + 3·A`, `A` the cumulative sum of the `∓1` corrections at changes of `±2` in the representatives `0, 1, 2` (`liftStep`, `liftB`,
`liftA`), so `cast_eq` is free and local constancy and the jump bound are local statements about `A`.

### Findings

* **Statement defect, ruled** (inventory item 61): `ringband_iv`'s second conjunct needed genuine change points; the hypothesis is added to that
  conjunct only (above).
* **Slip in the branch's `scripts/Axioms.lean`** (K3's block): the line `#eval IO.println "=== PURCHASED ==="` that `main` carries before
  `## M03` was missing, so `./scripts/axioms.sh` failed with "banners missing". Restored in this job's commit; check the merge with `main`.
* `D0_mod_ne`, `m_eq_near`'s ε-free filter pattern (`eventually_lt_add`, `eventually_gt_add`) and `Sides` are reusable by waves that read
  one-sided colourings.
* Re-pricing (first two hard leaves of this job): RingBand was priced M–H for 12 leaves and cost one infrastructure layer (`Sides`,
  `const_of_local`) of about 250 lines plus short instances; `exists_lift` about 100 lines. The remaining 21 are the H leaves of § 6.3 minus
  `sixFrag_isRingArc`; `sixFrag_isRingArc` (M) took about 150 lines (closed set of lens arcs, `Real.cos_eq_cos_iff`).

## Stage 3 — SAVED (FS131-I3c): Lens, germ_dichotomy, FLANK's geometry and cones; the build; 16 leaves left

Branch `fs131-w3`, commits after `3012c049` (I3b's head). **21 `sorry` declarations at the start, 16 now.** Build `build/gate/build/20261004T091636Z-2402026.log`:
"build: OK", warnings only `declaration uses sorry` (this job's own code adds none); audit `build/gate/axioms/20261004T092614Z-2442823.log` fails only on
`sorryAx` of the open leaves and their dependents, every proved declaration above reads the standard three. Readback: both quotations of the brief match their sources
(plan § 7.2 "It may" paragraph and this record's Stage 2 table). Scratch scripts: `data/fs131/i3/iter.sh` (builds a module into the scratch olean tree), `data/fs131/i3/chk.sh`
(checks a module against it), `tools/fs131_i3_addrecords.py` (adds the missing `#print axioms` records above the `=== PURCHASED ===` banner; it has a `--plant`/`--dry` control).
**Moved**: `re_e`, `im_e`, `sq_norm_eq`, `e_mul_conj_e`, `conj_e` live in `Plane/Chord` (imported now by `Lens` and `LocalStructure`).

### What is left (16)

| module | leaves | route (from this job's reading) |
|---|---|---|
| `LocalStructure` (4) | `finite_tiles_near`, `mem_coloursAt_iff_exists_tileOf`, `coneAt_region_eq_biUnion`, `Simple.coneAt_eq_angleIcc` | engine 3. **Shape found, not built**: for small `r` only arcs through `x` meet `B(x, 2r)`, pairwise meeting only at `x` (finitely many pairs of distinct circles or lines, at most two common points each), distance from `x` strictly monotone along each branch (`2ρ|sin((φ−φ₀)/2)|` on a circle, linear on a segment). Then no tile lies inside `B(x, ρ₀)`: the farthest point `z*` of its closure from `x` lies on one arc, which crosses `sphere(x, |z*−x|)`, so the tile has a side of `ball(z*, ε) ∖ Γ` with points beyond `|z*−x|`. Each tile meeting `B(x, r)` therefore meets `sphere(x, ρ₀)`, and `sphere(x, ρ₀) ∖ Γ` has at most `2·#arcs` arcs, each in one tile. `Simple.coneAt_eq_angleIcc` then goes through the Jordan chart (`h(ball 0 1 ∩ ball z₀ s)` is convex, so one sector) and the cone of a sector. |
| `SixFragment` (3) | `sixCol_locallyConstant`, `sixFrag_valid`, `sixFrag_nonSiamese` | **first build `sixCol (e(π/3) x) = sixCol x + 1` for `x ≠ 0`** (arg shifts by `π/3 − 2πk`, floor and round by `1 − 6k`, the lens test is rotation-covariant). It (a) reduces validity to colour `0` by rotating both points, (b) handles `arg`'s cut at `π` in local constancy (apply the rotation by `−1`, which moves the cut to the positive axis, where `arg` is continuous). Annulus facts used: a point of the ray `60°j` with `1 < ‖x‖ < 3/2` lies strictly inside the lens (`r² − √3 r < 0`); at `arg = 60°j + 30°` the point is outside both lenses (`r² − r + 1 > 1`). Colour `0` is `S_0`, `Q_4`, `G_2`; `Q_4` minus the unit disc lies in a Reuleaux triangle of width `1`, so its diameter is below `1` strictly on the open set. |
| `RingGerm` (9) | `germS_inward`, `germS_outward`, `germS_four`, `qfree4`, `fiveRing_finite_off_Q`, `fiveRing_length`, `touchW`, `four_of_bothKind`, `flank_edge_exists` | `germ_dichotomy` is now proved, so `qfree4`, `fiveRing_finite_off_Q`, `fiveRing_length` need one more child and a finiteness lemma (below). The others as in Stage 2. |

### A finding on FIVERING and QFREE4 (for the next implementer, not a statement defect)

`fiveRing_finite_off_Q`'s "finite" cannot be improved to "empty" by the germ dichotomy alone: two boundary points of one class may be at distance exactly `1` (a tile of diameter `1`, a Reuleaux
triangle). The derivation's step needs an *interior* point of the absent colour `X` at one of the two ring points, or the crossing lemma (`Valid.false_of_crossing`) on a connected set of
`closure (region X)` holding points nearer and farther than `1` from the other point. For a ring arc with constant sides that set is a segment: **outer side**, `u = p + (1+h)e(φ)` and
`v = u + i h e(φ)` (distances to `r(φ + 60°)` with squares `1 + h + h²` and `1 + h + h² − √3 h + h²`, so `1 + h + h² > 1` and `< 1` for `0 < h < (√3 − 1)/2`); **inner side**, `u = p + (1−h)e(φ)` and
`v = u − i h e(φ)`; the segment lies on one side of `ω(p)` and inside the ball where the side colour is constant, and a ball ∖ the other side is a subset of the closure of the side colour's class
(Γ has empty interior, `dense_interiorPts`). The exceptional set is `Z = {θ | r(θ) ∈ Γ ∧ no IsRingArc p θ₁ θ₂ c c' with θ₁ < θ < θ₂}`: its complement is open (off `Γ`, or an open interval of angles), and
at each of its points both germs are off `Γ` or inside a ring arc whose open sub-arc is out of `Z`, so `Z` is discrete and closed, hence finite on `[0, 2π]`. For that, expose from `germ_dichotomy`'s proof the
sub-arc `[θ, θ+δ']` (resp. `[θ−δ', θ]`) it constructs, whose open part consists of angles `θ + sign·u`, `0 < u < δ'` (the proof builds exactly this; only the statement forgets it).
`fiveRing_length`: `[0, 2π) ⊆ Q ∪ (Q − π/3) ∪ finite`, then `ae_arcLength_shift_pi`'s template for a shift by `π/3`.

### Re-pricing (first hard leaves of this job)

`exit_lens` (priced M–H): about 230 lines in two real-algebra lemmas (the frame of `e b` makes the lens and the `y₃` conditions explicit; `nlinarith only` with named hypotheses, and
splitting the lemma, were needed to stay under the heartbeat limit) plus a 40-line complex layer; case 2 by complex conjugation, no second proof. `germ_dichotomy` (priced M on `localSectors`, actually
independent of it): about 450 lines — the polar chart `Φ(ρ, ψ) = p + ρ e(ψ)` replaces every connectedness argument for the two sides. `flank_initialPieces` (M): the two TWOCIRC-style
cases collapse to `‖σρ(e(σt)−1) − 1‖² = 1 + 2ρ(ρ+σ)(1 − cos t)`; about 140 lines. `flank_cone` (M): about 120 lines. The H leaves left are the three engine-3 leaves, `Simple.coneAt_eq_angleIcc`, and the SixFragment trio.

## Stage 4 — SAVED (FS131-I3d): Simple.coneAt_eq_angleIcc, qfree4, the two FIVERING leaves, touchW, germS_inward and germS_outward; 9 leaves left

Branch `fs131-w3`, commits after `98f4b279` (I3c's head). **16 `sorry` declarations at the start, 9 now** (`LocalStructure` 3, `SixFragment` 3, `RingGerm` 3). Build `build/gate/build/20261004T101422Z-2686823.log` ("build: OK", warnings only `declaration uses sorry`); audit `build/gate/axioms/20261004T102246Z-2733747.log` (copy `data/fs131/i3/axioms-stage4.out`) fails only on `sorryAx` of the 9 open leaves and their dependents; every declaration proved in this stage reads `[propext, Classical.choice, Quot.sound]`.
Readback: both quotations of the brief match their sources (plan § 7.2 "It may" paragraph; this record's Stage 3 first table row); branch as I3c left it
(`98f4b279`). Scratch iteration: `/home/kooshi/scratch-fs131` (a `cp -rs` mirror of the worktree's `.lake/build/lib/lean/Proofs`; `it.sh Plane/X` compiles a module into it,
`c.sh file.lean` checks a scratch file against it) — never evidence.

### Findings that change the plan for the rest

* **The sector engine (`localSectors`) is not on the critical path of the interval cones.** `Simple.coneAt_eq_angleIcc` needs no sectors: it is the Jordan chart
  (`ArcMap.IsJordanDomain.local_connected`: near `x`, `T ∩ ball x r'` lies in a preconnected `C ⊆ T ∩ ball x r`, the image of a convex set under the chart),
  a separation lemma in `arg` (`arg_side`, `arg_near`: a preconnected set avoiding two rays from `x` lies on one side), and a real-analysis lemma
  (`exists_angleIcc_of_no_gap`: a closed nonempty `2π`-periodic set of angles with no two separated points is one angular interval). It uses only `IsOpen T` and `IsJordanDomain T`.
* **The three engine-3 leaves left (`finite_tiles_near`, `mem_coloursAt_iff_exists_tileOf`, `coneAt_region_eq_biUnion`) are terminal except for
  `four_of_bothKind`** (which needs the cone of a class to be the union of its tiles' cones). Nothing else in the repository uses them. Route found, not built:
  (i) for small `ρ₀`, only arcs through `x` meet `B(x, ρ₀)`; they pairwise meet only at `x` and each carrier circle through `x` has `2ρ > ρ₀`;
  (ii) *no tile lies in `B(x, ρ₀)` and meets `B(x, r)`*: the farthest point `z*` of the closure lies on exactly one carrier, transversal to `sphere(x, |z*−x|)`
  (circle `|z−x| = 2ρ|sin(Δ/2)|`, `Δ < π`); both sides of the carrier near `z*` hold points beyond `|z*−x|` (a polar box chart about the centre for a circle, a
  box for a line; the side sets are images of convex boxes, so preconnected, and lie in `interiorPts`); (iii) hence every tile meeting `B(x, r)` meets `sphere(x, ρ)`
  for every `ρ ∈ (r, ρ₀)`, and the tiles meeting `sphere(x, ρ)` are finite: `Γ ∩ sphere(x, ρ)` is finite (≤ 2 per carrier), and the tile of `x + ρ e(φ)` depends only on
  the step function `φ ↦ #{roots below φ}`. A shorter statement of (ii) in rays: along the ray from `x` in direction `u` the carrier circle `|z − c| = ρ_a` through `x`
  meets it at the single point `x + 2⟨c − x, u⟩ u`, so a tile `T ⊆ B(x, R)` lies inside `⋃ B(c_a, ρ_a)`.
* **The (Q)-free and five-colour ring rows share one regularity layer** (all in `RingGerm`, before `qfree4`): `RegularAt p θ` (off `Γ`, or an interior angle of an arc of
  `Γ` on `ω(p)` with constant sides), `isOpen_regularAt`, `exists_regular_germ` (every side germ is regular: the dichotomy less at most two end angles),
  `finite_not_regular` (irregular angles in a bounded range are finite: a closed set of isolated points in a compact range), and `carries_absent` (a regular
  ring point on no (Q) arc lies in the closure of the one absent colour's class while `r(θ ± 60°)` does not: N-E1 off `Γ`, `IsRingArc.not_mem_closure_third` on an arc).
  The geometry of the arc case is one crossing lemma, `Valid.not_mem_closure_of_side`, parametrized by the side `s = ±1` and the direction `σ = ±1`.
* **No finite exceptional set is needed in `qfree4`**: two regular angles `60°` apart exist (`exists_regular_pair`, finite exclusions from an interval).
* **`fiveRing_length` goes through the open angles `qOpen`** (interior to a (Q) arc): `qOpen` is open, periodic, inside the (Q) set, and every regular angle on a closed (Q) arc is in it
  (`qOpen_of_regular`: the constant-side arc through a regular angle has the (Q) arc's colours), so the cover `[0, 2π) ⊆ qOpen ∪ (qOpen − 60°) ∪ finite` and the measure
  of a periodic measurable set under a shift (`arcLength_preimage_add_periodic`) give `2π ≤ 2 · arcLength (qOpen)`. The set of (Q) angles itself need not be measurable.
* **GERM-S (i) and (ii)** are `changePoint_germs`/`changePoint_germs_out` (the four germs at a change point carry `X`, `X'` as the row says: the TWIST rotation and `germ_absent_class`), GERM-R's four direction sets to place the colour (`germR_*`), and two
  tile lemmas (`tile_subset_closedBall_of_cone`, `outward_of_cone`: a class approaching `y` along a direction facing `p` puts the tiles of `p` in `B̄(y, 1)`, one facing away keeps them out of `B(y, 1)`; the crossing lemma `Valid.dist_lt_or_gt_of_isPreconnected` at a point of the class near `y`). `germS_four` needs one more thing, a tile of colour `c` with `p` in its closure for each colour `c` of `p`
  (`mem_coloursAt_iff_exists_tileOf`, i.e. `finite_tiles_near`): then the inward colour and the outward colour differ (a tile in `B̄(y, 1)` missing `B(y, 1)` lies in a sphere, which holds no open set), and with `X`, `X'` at `y` that is four.
* **TOUCHW** is `germ_absent_class` (a germ off (Q) arcs not in the closure of `X`'s class lies in the closure of the other absent colour `X'`'s class and misses `X`'s:
  the dichotomy, `IsRingArc.exists_germ_interior`, `IsRingArc.eq_of_mem_closure`) four times, the TWIST rotation for "not `X`", and
  `not_mem_closure_of_four_germs` (GERM-R's four direction sets cover every direction) for "`X'` not carried at `w`".

### Re-pricing (first hard leaves of this job)

`Simple.coneAt_eq_angleIcc` (priced H on `localSectors`): about 330 lines, no sectors. `qfree4` (M–H): about 330 lines in five reusable lemmas (the crossing at a side ~110 lines, regular germs and
finiteness ~150). `fiveRing_finite_off_Q` (M–H): 30 lines on those. `fiveRing_length` (M): 220 lines, the measure layer being most of it. `touchW` (H): about 330 lines in six lemmas. `germS_inward` and `germS_outward` (H, one argument): about 250 lines in five lemmas, on the TOUCHW machinery.
The leaves that remain are all either engine-3 (`finite_tiles_near` and its two corollaries, `flank_edge_exists`, `four_of_bothKind`), the `germS_*` trio, or the SixFragment trio.

### What is left (11)

| module | leaves | route |
|---|---|---|
| `LocalStructure` (3) | `finite_tiles_near`, `mem_coloursAt_iff_exists_tileOf`, `coneAt_region_eq_biUnion` | the route in Findings above; the other two are short on the first (closure of a finite union; the cone of a finite union and its locality) |
| `SixFragment` (3) | `sixCol_locallyConstant`, `sixFrag_valid`, `sixFrag_nonSiamese` | unchanged from Stage 3. Note for `sixFrag_valid`: the three colour-`0` tiles are `S_0` (angles `(0°, 60°)`, `r < 1`), `Q_4` (angles about `240°`, in the lens) and `G_2` (angles in `[120°, 180°)`, outside the lens of its index); `S_0`–`Q_4` is easy (angular gap `≥ 150°`, `r ≥ 1`: `|x − y|² ≥ r² + s² + √3 rs > 1`); `S_0`–`G_2` is not (the `60°` angular gap alone gives only `1 − s + s² < 1`; the lens exclusion is what keeps `G_2` away from `e(120°)`) |
| `RingGerm` (3) | `germS_four`, `four_of_bothKind`, `flank_edge_exists` | `germS_four`: see Findings (it waits on `mem_coloursAt_iff_exists_tileOf`). `four_of_bothKind`: needs `coneAt_region_eq_biUnion` and the disjoint-interiors of cones of distinct tiles (which has a route without sectors: the cone of `Γ` at `x` is finite mod `2π`, so for a generic direction a small convex sector lies in `interiorPts` and hence in one tile). `flank_edge_exists`: the end direction of a tile's cone is a tangent of an arc through `y` (sectors) |

## Stage 5 — SAVED (FS131-I3e): the engine-3 leaves, germS_four; 5 leaves left

Branch `fs131-w3`, commits after `dbf34f37`. **9 `sorry` declarations at the start, 5 now** (`SixFragment` 3, `RingGerm` 2: `four_of_bothKind`, `flank_edge_exists`).
Build of the stage-5 commit (before the statement repair below): `build/gate/build/20261004T110435Z-2915550.log`, "build: OK", warnings only `declaration uses sorry`.
Axioms of the proved declarations read by `#print axioms` over the scratch oleans (iteration, not the gate): all `[propext, Classical.choice, Quot.sound]`.

* **`finite_tiles_near`** (and `mem_coloursAt_iff_exists_tileOf`, `coneAt_region_eq_biUnion`, both short on it). No sector engine. Route: a *good radius* `GoodAt x ρ₀`
  (ball in the domain, finitely many arcs meet it, all through `x`, circles among them of diameter above `ρ₀`, distinct full curves through `x` meet inside only at `x`);
  each arc through `x` lies on a full curve `curveAt x κ b` (`κ = 0` a line, `κ = 1` the circle about `x + b`), `curve_inter` the algebra of two curves.
  Farthest-point lemma `GoodAt.not_tile_subset_ball`: a tile inside `B(x, ρ)` has a farthest point `z` of its closure; off `Γ` the tile continues, on `Γ` the local lemma
  `exists_farther` (radial step outside the circle or off the line; inside the disc the step `(β − s)p + s b`, a direction entering the disc and leaving the circle about `x`,
  inside the convex ball-meets-ball) gives a segment off the one curve through `z` to a farther point of the tile. Then every tile meeting `B(x, r)` meets `S(x, ρ)`, and
  `GoodAt.finite_tiles_sphere` (the circle minus the finitely many points of `Γ` falls into finitely many arcs, `finite_image_of_locConst`). `exists_ball_finite` moved
  earlier in `LocalStructure` (position only).
* **`germS_four`**: the inward colour of `germS_inward` and the outward colour of `germS_outward` differ (a tile in `B̄(y,1)` missing `B(y,1)` lies in a sphere, which holds
  no open set), and with `X, X'` that is four. `germS_four` and `ringQPrimeS` moved after `germS_outward` (positions only).
* **Statement finding, ruled (inventory item 112)**: `four_of_bothKind`'s `hint` now takes `β₁ < β₂` (a cusp tile has a one-direction cone, and the plan's disjoint-interiors route
  fails there); `four_of_bothKind_simple` gains `hnc : ∀ T, F.IsTile T → z ∈ closure T → ∀ β, coneAt T z ≠ angleIcc β β`, which feeds the strict `hint`
  (that proof is done). Both docstrings say so. `four_of_bothKind` itself is still `sorry`: it needs the disjoint-interior lemma for distinct tiles' cones (a generic direction
  has a small convex sector in `interiorPts`; with `GoodAt`, the directions where `Γ` has a branch are the finitely many tangent directions `arg b ± π/2` of the curves through `z`).

### What is left (5)

| module | leaves | route |
|---|---|---|
| `SixFragment` (3) | `sixCol_locallyConstant`, `sixFrag_valid`, `sixFrag_nonSiamese` | Findings of this stage. `locallyConstant`: cases `‖x‖ < 1` (arg off the integers, as `x` is off the segments), `‖x‖ > 1` (sector/round constant off integer resp. half-integer rays; on the half-integer rays both lens tests are strictly false, `r² − r + 1 > 1`; on the negative axis the round is `3` mod 6 on both sides and `InSixLens` is `6`-periodic in its index; off these, a point with the lens test false and `dist = 1` lies on a lens side). `valid`: no arc condition is needed for the pair bounds except `‖x‖ ≠ 1` and `‖x‖ < 3/2`. Rotation by `60°` shifts `sixCol` by `1` (`arg` wraps by `2πn`, `floor` and `round` shift by `1 + 6n`, `InSixLens` is `6`-periodic in the index), so reduce to colour `0`: `S_0` (`‖·‖ < 1`, arg in `[0°, 60°)`), `Q_4` (lens at `240°`, `‖·‖ ≥ 1`), `G_2` (arg in `[120°, 180°)`, outside the lens of its round). The `S_0`–`G_2` pair: `dist² = s² + r² − 2 s r cos δ`, `δ ∈ (60°, 90°)` forces `β < 150°` and the gap condition `r ≥ 2 sin β`, so `r sin δ ≥ 2 sin β sin(β − 60°) = 1/2 − cos(2β − 60°) > 1`. Diameter `< 1` of `Q_4 ∩ {‖·‖ ≥ 1}`: that set lies in the Reuleaux triangle on `e(−30°), e(30°), √3`; a Cartesian reduction `3(P + Q − 1) ≤ 2(P + u)(Q + v) − 6uv` with `4u² + 2Pu + P² − 3P < 0` is a candidate for `nlinarith`. **`sixFrag_nonSiamese` also needs each of `S_0`, `Q_4`, `G_2` (cut at `3/2`) to be connected** (else two tiles of one region are a Siamese pair): `Q_4` is `{1 < r < min(3/2, 2cos(φ − a), 2cos(φ − b))}`, a convex set in `(r, φ)`; `G_2` is `{max(1, h(φ)) ≤ r < 3/2}` over an angular interval. The plan's "M on the same pair lemmas" misses this. |
| `RingGerm` (2) | `four_of_bothKind`, `flank_edge_exists` | `four_of_bothKind`: above. `flank_edge_exists`: the cone of `t` at `y` ends at `δ = ψ + 210°` (`flank_cone`), so `δ` is a branch direction of an arc through `y` (else a sector about `δ` lies in `interiorPts`, in one tile, and the cone passes `δ`); the arc piece and `B ⊆ closure t` need the regions between consecutive branches at `y` (local sectors), which `GoodAt` supports: branches are initial pieces of the curves through `y`. |

## Theorems this phase proved (FS131-I3e)

Declarations `HadwigerNelson.Plane.ArcMap.*` unless marked; all `[propext, Classical.choice, Quot.sound]` (scratch `#print axioms`; the gate log is still to be read); statements as the skeleton gave them.
- **Engine 3 (`plans/FS131-w3-kernel-plan.md` § 6)** — `finite_tiles_near`, `mem_coloursAt_iff_exists_tileOf`, `coneAt_region_eq_biUnion` (children, `HadwigerNelson.Plane.*`: `curveAt`, `curve_inter`, `exists_farther`, `farther_in`, `farther_out`, `finite_curve_inter_sphere`, `finite_image_of_locConst`, `spherePt`, `Arc.curveData`, `Arc.curve`, `Arc.carrier_subset_curve`; `ArcMap.GoodAt`, `exists_goodAt`, `GoodAt.not_tile_subset_ball`, `GoodAt.finite_tiles_sphere`, `region_inter_ball_subset`; `coneAt_biUnion_finite`, `coneAt_inter_ball`).
- **FS116-N1-GERM-S (iii)** — `germS_four`, and so `ringQPrimeS` (FS116-RING-Q-PRIME-S) is now sorry-free.

## Theorems this phase proved (FS131-I3d)

All on `[propext, Classical.choice, Quot.sound]`, read from `build/gate/axioms/20261004T102246Z-2733747.log` (build `build/gate/build/20261004T101422Z-2686823.log`); declarations are `HadwigerNelson.Plane.ArcMap.*` unless marked;
statements as the skeleton gave them (none changed). Read against `plans/FS131-w3-kernel-plan.md` § 5.2.

- **FS116-V5-U1 (interval cones)** — `Simple.coneAt_eq_angleIcc` (children, `HadwigerNelson.Plane.*`: `IsJordanDomain.local_connected`, `IsJordanDomain.coneAt_eq_angleIcc`, `arg_side`, `arg_near`, `mem_e_of_arg` as `mul_e_of_arg`, `exists_angleIcc_of_no_gap`, `exists_shift_Ico`, `periodic_int`, `mem_coneAt_of_mem_isOpen`, `coneAt_nonempty`; `isClosed_coneAt` moved here from `RingGerm`). Same statement.
- **FS116-N1-QFREE4** — `qfree4` (children: `Valid.not_mem_closure_of_side`, `IsRingArc.not_mem_closure_third`, `dist_ringPt_third`, `RegularAt`, `carries_absent`, `subsingleton_e_eq`, `isOpen_regularAt`, `exists_regular_germ`, `finite_not_regular`, `absent_subsingleton`, `exists_regular_pair`). Same.
- **FS116-N2-FIVERING** — `fiveRing_finite_off_Q`, `fiveRing_length` (children: `qOpen`, `qOpen_subset`, `isOpen_qOpen`, `qOpen_periodic`, `qOpen_of_regular`, `arcLength_apply`, `arcLength_preimage_add_periodic`). Same.
- **FS129-SR2-TOUCHW** — `touchW` (children: `exists_near_of_mem_closure_isOpen`, `not_mem_closure_of_four_germs`, `exists_germ_interior`, `IsRingArc.ringArc_subset_closure`, `IsRingArc.eq_of_mem_closure`, `germ_absent_class`, `mem_ringArc_of_germIn`). Same.
- **FS116-N1-GERM-S (i), (ii)** — `germS_inward`, `germS_outward` (children: `changePoint_germs`, `changePoint_germs_out`, `tile_subset_closedBall_of_cone`, `outward_of_cone`). Same.

`side_ball_subset_closure` moved earlier in `RingGerm` (before the QFREE4 block); `germS_inward`, `germS_outward` now stand after `re_mul_conj_e_bound` (positions only).

## Drafts for the front page

None yet: 5 `sorry` remain, so the gate has not run. (The build above is the iteration check, not the gate.)

## Build

See `data/fs131/i3/build-stage1.log` for the build of the commit this record sits on (started under the slot; the state of that run is in the
report). The expected result is green with exactly the `declaration uses 'sorry'` warnings of the 41 open leaves and nothing else.


