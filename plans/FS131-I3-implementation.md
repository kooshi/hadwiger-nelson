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

## Build

See `data/fs131/i3/build-stage1.log` for the build of the commit this record sits on (started under the slot; the state of that run is in the
report). The expected result is green with exactly the `declaration uses 'sorry'` warnings of the 41 open leaves and nothing else.

## Drafts for the front page

None yet: the gate has not run (41 `sorry` remain). The counts for `CLAUDE.md` § The gate and § Trust ledger and `scripts/vacuity-baseline.txt`'s
header are drafted at the milestone's gate.
