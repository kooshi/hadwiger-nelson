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

## Drafts for the front page

None yet: 16 `sorry` remain, so the gate has not run. (The build above is the iteration check, not the gate.)

## Build

See `data/fs131/i3/build-stage1.log` for the build of the commit this record sits on (started under the slot; the state of that run is in the
report). The expected result is green with exactly the `declaration uses 'sorry'` warnings of the 41 open leaves and nothing else.


