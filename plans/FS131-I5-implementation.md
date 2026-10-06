# FS131-I5 — wave 5's first implementer: the merge, the eleventh-point repair, the base's obligation pass, and wave 5's leaves

*de Bruijn, the implementer (Opus), on branch `fs131-w5` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5`. Brief:
`data/fs131/briefs/FS131-I5-wave5.md` (main tree). Started 2026-10-04.*

## Theorems this phase proved

*Kernel-checked on the build of stage 5 (`data/fs131/i5/build-stage5.log`); axioms read from that build's oleans (`data/fs131/i5/I5Axioms.lean`, output
`I5Axioms.out`). "Wired" means proved here over a child that is still `sorry` — not yet a kernel theorem; it becomes one when the child lands.*

Kernel theorems, on `[propext, Classical.choice, Quot.sound]`:
- `HadwigerNelson.Plane.ArcMap.linkage_dot_ne_zero` (`Plane/ValidMap/HexRing`) — BV-ND's step 1.
- `HadwigerNelson.Plane.ArcMap.endpoint_dist_ge` (`Plane/ValidMap/BaseWalk`) — FS110-CB D5 item 6.
- `HadwigerNelson.Plane.ArcMap.eleventh_type` (`BaseWalk`) — Lemma 4's `10 + 1` count.
- `HadwigerNelson.Plane.ArcMap.isCubicTrichromatic_of_three_of_noRep` (`HexRing`) — wave 5's shared child.
- `HadwigerNelson.Plane.ArcMap.BaseCtx.cubic_of_three` (`BaseWalk`).
- `HadwigerNelson.Plane.ArcMap.disc1ts`, `HadwigerNelson.Plane.ArcMap.disc1ts_degree` (`Plane/ValidMap/Dense`) — FS129-SR2-DISC1TS, FS112-DISC1.
- `HadwigerNelson.Thomassen.triLattice_hyps`, `HadwigerNelson.Thomassen.triLattice_adj` (`Plane/ValidMap/MapGraph`) — `lemma1`'s model.
- `HadwigerNelson.Plane.ArcMap.Unenclosed.unenclosedC` (`Plane/ValidMap/Chain`) — E4's by-definition child.

Wired (over `sorry` children; axioms `[propext, sorryAx, Classical.choice, Quot.sound]`): `p17_ua` (over `bv_hex`), `bv_nd1` (over `bv_nd`),
`flankQ_upper_of_qrOnly`, `flankQ_lower_of_qrOnly` (over wave 4's `flankQ_upper`/`_lower`), `cvb_thom` (over `cvb_thom_reduced`, `Thomassen.lemma1`),
`BaseCtx.cor3_base` (over `cor3`), `n3_base` (over `exists_preBend`, `row134BaseUA`), `localDense` (over `exists_unenclosed_or_bad`, `n3_base`), `dense3`
(over `localDense`).

### FS131-I5b (wave 5's second implementer)

*Kernel-checked on the build of stage 8 (`data/fs131/i5b/build-stage8.log`; `build/gate/build/20261004T212909Z-2535131.log`); axioms read from that
build's oleans (`data/fs131/i5b/I5bAxioms.lean`, output `I5bAxioms.out`; its control, `cvb_thom`, reads `sorryAx` through the planar core, so the
reader sees the failure it guards against).*

Kernel theorems, on `[propext, Classical.choice, Quot.sound]`:
- `HadwigerNelson.Thomassen.lemma1` (`Plane/ValidMap/MapGraph`) — Thomassen's Lemma 1, `[Thomassen1999]` p. 850.
- `HadwigerNelson.Plane.exists_holed_valid_fragment` (`MapGraph`) — FS114-CVB-PINCH's last clause (CVB B1's configuration).
- Children (`MapGraph`): `Thomassen.LocallyHamiltonian.exists_two_common`, `Thomassen.LocallyHamiltonian.two_mid`, `Thomassen.exists_eq_of_steps_up`,
  `Thomassen.exists_eq_of_steps`; `Plane.norm_side_of_isPreconnected`, `Plane.mem_carrier_circ_of_norm`, `Plane.norm_of_mem_carrier_circ`,
  `Plane.norm_of_mem_carrier_radial`, `Plane.mem_carrier_radial`, `Plane.norm_of_mem_holedArcs`, `Plane.holed_off_arcs`,
  `Plane.dist_lt_one_of_same_quadrant`, `Plane.holedFrag_valid`, `Plane.isPreconnected_holedAnnulus`.

`cvb_thom` stays wired (over `cvb_thom_reduced`, the planar core); `lemma1` no longer carries `sorry`.

### FS131-I5c (wave 5's third implementer)

*Kernel-checked on the build of stage 11 (`data/fs131/i5c/build-stage11-brick.log`; `build/gate/build/20261004T232548Z-3420195.log`); axioms read from that
build's oleans (`data/fs131/i5c/I5cAxioms.lean`, output `I5cAxioms.out`; its control, `stuck_structure_ua`, reads `sorryAx`).*

Kernel theorems, on `[propext, Classical.choice, Quot.sound]`:
- `HadwigerNelson.Plane.sevenBrickMap_isTerminalMap` (`Plane/ValidMap/Terminal`) — the inhabitant of `IsTerminalMap` at seven colours.
- `HadwigerNelson.Plane.not_row134BaseUA_seven` (`Plane/ValidMap/Dense`) — `Row134BaseUA`'s seven-colour form is false.
- The brick infrastructure (`Plane/ValidMap/BrickMap`, new module), 41 theorems, among them `sevenBrick_mem_interiorPts`, `sevenBrick_isTile_iff`,
  `sevenBrick_col_val`, `brickCell_eq_of_closure`, `encard_brickCellsAt_le`, `sevenBrick_isSector_iff`, `sevenBrick_sectorsOf_subsingleton`,
  `sevenBrick_not_hasRepeatedColour`, `sevenBrick_not_mergeAvailable`, `sevenBrick_ncard_coloursAt_le`, `countable_circle_grid`, `branchPt_re_im`,
  `sevenBrick_branch_false`, `sevenBrick_not_isHorn`, `sevenBrick_not_isRingArc`, `isPreconnected_compl_reProdIm_Icc`, `sevenBrick_unenclosedC`,
  `sevenBrick_baseHyp`, `sevenBrick_noInertNear` (every one listed in `scripts/Axioms.lean`'s block "FS131-I5c").
- Stage 12 (`data/fs131/i5c/build-stage12.log`; axioms `data/fs131/i5c/I5cAxioms12.out`, control `l3_base` with `sorryAx`), `Plane/ValidMap/BaseWalk`:
  `HadwigerNelson.Plane.ArcMap.BaseCtx.vin_antipodal` (FS110-CD Theorem D2 (i)), `BaseCtx.eleventh_antipodal` (Theorem D2 (ii)),
  `BaseCtx.retArc_partner` (FS110-CD Lemma R step 3); children `dist_le_one_of_mem_region`, `antipodal_aux`, `eq_of_dist_le_one_antipodal`,
  `exists_mem_region_ne`, `exists_tileOf_of_mem_coloursAt`, `dist_sq_re_im`, `antipodal_neg`, `exists_near_far_antipodal`,
  `not_mem_coloursAt_of_tile_dist` (the (P) sweep), `IsTile.exists_dist_eq_one`, `germPseudo_unique`.
- Stage 13 (`data/fs131/i5c/build-stage13b.log`; axioms `I5cAxioms13.out`): `HadwigerNelson.Plane.ArcMap.stuck_horns_ua`, `woodallCone_isHorn_ua`
  (`Terminal`; N4-STUCK (i) with unit arcs), `pseudo_ncard_ne_one_of_change`, `germ_sub_two_pi` (`BaseWalk`).

Wired by FS131-I5c (over `sorry` children): `stuck_structure_ua` (over the new child `stuck_flanks_ua`), `BaseCtx.retArcs_finite` (over `pseudo_finite`),
`BaseCtx.hex_base` (over `rot_noThird` and `bv_hex`).

### FS131-I5d (wave 5's fourth implementer)

*Kernel-checked on the builds of stages 16–18 (`data/fs131/i5d/build-stage16.log`, `-stage17.log`, `-stage18.log`; gate logs named in each stage);
axioms read from those builds' oleans (`data/fs131/i5d/I5dAxioms16.out`, `I5dAxioms17.out`, `I5dAxioms18.out`; each with a control reading `sorryAx`).*

Kernel theorems, on `[propext, Classical.choice, Quot.sound]`:
- `HadwigerNelson.Plane.ArcMap.stuck_flanks_ua` (`Plane/ValidMap/Terminal`) — N4-STUCK (ii) with unit arcs (FS114-CV § 1.4); with it I5c's wiring
  `HadwigerNelson.Plane.ArcMap.stuck_structure_ua` (FS112-WALK row 5, N4-STUCK (i)–(ii) with unit arcs) is a kernel theorem.
- `HadwigerNelson.Plane.ArcMap.cv_l0` (`Terminal`) — FS114-CV-HD's (CV-L0).
- `HadwigerNelson.Plane.ArcMap.n3_end_chain` (`Terminal`) — FS112-N3-END's chain clause (inventory item 74).
- `HadwigerNelson.Plane.ArcMap.BaseCtx.pseudo_nonempty`, `BaseCtx.pseudo_finite` (`Plane/ValidMap/BaseWalk`) — NB3 steps 3 and 4; with the second, I5c's
  wiring `BaseCtx.retArcs_finite` (FS110-CD Lemma R's finiteness) is a kernel theorem.
- Children: the module `Plane/ValidMap/FlankUA` (29 theorems: `not_mem_angleIcc_add_pi`, `shadow_of_not_shave`, `not_outType_N_of_flankAbove_one`,
  `not_outType_S_of_flankBelow_neg_one`, `srcG_of_shadow`, `srcH_of_shadow`, `dot_nonneg_of_srcG`, `dot_nonpos_of_srcH`, `region_near_of_inType`,
  `dist_N_S`, `region_far_S_of_srcG`, `region_far_N_of_srcH`, `flank_ne_of_shadows`, `exists_isRingArc_of_onRingArc` (plan § 9.1's shared child),
  `N_add_eq_framePt`, `S_add_eq_framePt`, `framePt_normSq_aux`, `horn_radial_N`, `horn_radial_S`, `not_antipodal_coneAt_N_of_horn`,
  `not_antipodal_coneAt_S_of_horn`, `horn_poles_contact`, `coloursAt_eq_of_mem_interiorPts`, `abs_le_norm_e_sub_one`, `sphere_near_mem_ringArc`,
  `IsRingArc.coloursAt_eq`, `IsFlankAbove.unique`, `horn_bounds_of_noMerge`, `hasSectors_one_of_contacts`), and `chainVertex_antipodal` (`Terminal`).

Wired by FS131-I5d (over a `sorry` child): `n3_end` (FS112-N3-END, moved to wave 5 by item 289) — its second disjunct proved; its first case is the new
child `n3_end_of_not_inType` (NB3-END items 2–5).

### FS131-I5e (wave 5's fifth implementer)

*Kernel-checked on the build of stage 21 (`data/fs131/i5e/build-stage21.log`; `build/gate/build/20261005T020618Z-432319.log`); axioms read from that build's
oleans (`data/fs131/i5e/I5eAxioms21.lean`, output `I5eAxioms21.out`; its controls: `cor3_local` reads `sorryAx`, `linkage_dot_ne_zero` the standard three).*

Kernel theorems, on `[propext, Classical.choice, Quot.sound]`:
- `HadwigerNelson.Plane.ArcMap.GermPseudo.mem_pseudoColours` (`Plane/ValidMap/HexRing`) — a germ's pseudo-colour is a pseudo-colour of its point.

Wired by FS131-I5e (over the new `sorry` child `cor3_local`, `Plane/ValidMap/Cor3`; axioms `[propext, sorryAx, Classical.choice, Quot.sound]`): `cor3`
(FS112-N3-COR3; moved verbatim to `Plane/ValidMap/Cor3` at stage 20), `pseudo_ncard_le_two_of_baseHyp` (`HexRing`), `BaseCtx.pseudo_ncard_le_two`
(`BaseWalk`, NB3 step 5), `rot_noThird` (`HexRing`, N2-ROT's "no `r`-tile at `x`"). Held, not proved: `n3_end_of_not_inType` (a GAP in NB3-END item 2,
stage 20; to Ephodos).

### FS131-I5f (wave 5's sixth implementer)

*Kernel-checked on the build of stage 23 (`data/fs131/i5f/build-stage23.log`; `build/gate/build/20261005T024824Z-741049.log`); axioms read from that
build's oleans (`data/fs131/i5f/I5fAxioms23.lean`, output `I5fAxioms23.out`; controls `l3_base` with `sorryAx`, `linkage_dot_ne_zero` clean).*

Kernel theorems, on `[propext, Classical.choice, Quot.sound]`:
- `HadwigerNelson.Plane.ArcMap.cor3_local` (`Plane/ValidMap/Cor3`) — FS112-N3-COR3's local form (inventory item 218 (b)); with it `cor3`,
  `pseudo_ncard_le_two_of_baseHyp`, `BaseCtx.pseudo_ncard_le_two`, `rot_noThird` and `BaseCtx.cor3_base` are kernel theorems.
- Children (`Cor3`): `e_arg_of_norm_eq_one`, `IsRingArc.disjoint_coneAt`, `exists_ringArc_of_sides`, `exists_mem_coneAt_region_inter`,
  `mem_coneAt_inter_ball_of_re_neg`, `mem_coneAt_diff_closedBall_of_re_pos`, `exists_near_tangent`, `exists_tangent_colour`, `cor3_half`, `cor3_at`,
  `exists_crossings`.
- The assembly's glue (`BaseDense`): `CircleColouring.mem_S_of_ne`, `CircleColouring.leftVal_of_not_mem`, `exists_eq_of_absent`, `BaseCtx.removable`, and
  (`BaseWalk` since stage 24) the periodicity lemmas `germ_add_int_mul`, `ringPt_add_int_mul`, `germPseudo_add_int_mul`, `ringArc_add_int_mul`, `IsRetArc.add_int_mul`,
  `IsRetArc.exists_Ico`.

- Stage 24 (`data/fs131/i5f/build-stage24.log`; axioms `I5fAxioms24.out`), `Plane/ValidMap/BaseWalk`: `HadwigerNelson.Plane.ArcMap.BaseCtx.exists_pseudoCircle`
  (NB3 steps 3–5, the bridge to a circle colouring with no swap); children `germPseudo_cw_iff`, `germPseudo_ccw_iff`, `BaseCtx.exists_germPseudo`; the
  periodicity lemmas above moved here from `BaseDense` at this stage.

Wired by FS131-I5f (axioms `[propext, sorryAx, Classical.choice, Quot.sound]`): `row134BaseUA` (= `BaseCtx.false`, the walk assembled over its leaves as
stated), `BaseCtx.exists_endpoint_third`, `BaseCtx.third_ne`.

### FS131-I5g (wave 5's seventh implementer)

*Each stage's build and axiom read named in its line; axioms read from that build's oleans (`data/fs131/i5g/I5gAxioms<stage>.lean`, output `.out`).*

Kernel theorems, on `[propext, Classical.choice, Quot.sound]`:
- Stage 26 (`data/fs131/i5g/build-stage26.log`; `build/gate/build/20261005T033138Z-1000357.log`; axioms `I5gAxioms26.out`, control `select` with
  `sorryAx`), `Plane/ValidMap/BaseWalk`: `HadwigerNelson.Plane.CircleColouring.reduce` (FS110-CD Lemma R steps 4–5, CE's R3); children
  `reduce_leftVal_add_int_mul`, `reduce_rightVal_add_int_mul`, `Removable.add_int_mul`, `reduce_nearOnly`, `reduce_exists_max`, `reduce_left_uncov`,
  `reduce_right_uncov`, `reduce_zmod3`, `reduce_partner_noChange`, `reduce_leftVal_ne`, `reduce_vals_of_const`, `reduce_locConst`, `reduce_proper_off`,
  `reduce_int_eq_zero` (all `CircleColouring.`).
- Stage 27 (`data/fs131/i5g/build-stage27.log`; `build/gate/build/20261005T034254Z-1077466.log`; axioms `I5gAxioms27.out`, control `l3_base` with
  `sorryAx`), `BaseWalk`: `HadwigerNelson.Plane.CircleColouring.select` (`[SokolovVoronov2025]` Lemma 5, BV-C6, Prop. 18 as BASE-V's BV-L5, BV-C6,
  BV-P18); children `select_bdd`, `select_firstPassage`, `select_unique`, `select_lt`, `select_window`, `select_window'`, `select_chord`,
  `select_residue`, `select_core`.
- Stage 28 (`data/fs131/i5g/build-stage28.log`; `build/gate/build/20261005T043331Z-1353383.log`; axioms `I5gAxioms28.out`, controls `row134BaseUA`
  and `bv_hex` with `sorryAx`, `linkage_dot_ne_zero` clean), `BaseWalk`: `HadwigerNelson.Plane.ArcMap.BaseCtx.l3_base` (`[SokolovVoronov2025]` Lemma 3
  in pseudo-colour form, BASE-V's BV-L3 route); children `CircleColouring.link_side_right`, `link_side_left`, `link_val_right`, `link_val_left`,
  `link_path`, `link_relabel`, `link_periodic_finite`; `ArcMap.link_cos_fibre`, `link_circles_rep`, `link_circles_two`, `link_circles_finite`,
  `link_norm_e_sub_sq`, `link_cos_eq_of_ringPt`, `link_fibres`, `link_turn`, `link_flip`, `link_dist_ringPt_sq`, `link_partners`, `link_one_lt_two`,
  `exists_linkage`.

### FS131-I5j (wave 5's eighth implementer)

*Each stage's build and axiom read named in its line; axioms read from that build's oleans (`data/fs131/i5j/I5jAxioms<stage>.lean`, output `.out`).*

Kernel theorems, on `[propext, Classical.choice, Quot.sound]`:
- Stage 31 (`data/fs131/i5j/build-stage31.log`; `build/gate/build/20261005T051518Z-1601427.log`; axioms `I5jAxioms31.out`, controls `rot_out` and
  `row134BaseUA` with `sorryAx`, `linkage_dot_ne_zero` clean), `Plane/ValidMap/HexRing`: `HadwigerNelson.Plane.ArcMap.bv_hex` (FS114-BV-HEX, BASE-V
  § 1a.4 steps 1–6), `HadwigerNelson.Plane.ArcMap.hex_regular` (FS112-ROTHEX's N2-HEX; its first disjunct always), and with them `p17_ua`,
  `BaseCtx.hex_base`; the shared child `coneAt_of_cubic` (plan § 9.1); children `hex_int_core`, `hex_int_noAdj`, `exists_halfTurn_of_cos_nonpos`,
  `eq_floor_of_floor_eq_ceil`, `hex_real_core`, `angleIcc_add_int_mul`, `hex_cones_of_serve`, `subset_closure_region_of_isOpen`,
  `Valid.cone_re_nonneg_of_preconnected`, `GermPseudo.germIn_closure`, `germPseudo_add_two_pi`, `ringPt_add_two_pi'`, `hex_side`, `dist_frame`,
  `ringPt_frame`, `norm_sq_eq_re_im`, `e_hex_re_im`, `hex_point`, `hex_adjacent` (all `ArcMap.`).
- Stage 32 (`data/fs131/i5j/build-stage32.log`; `build/gate/build/20261005T052713Z-1651689.log`; axioms `I5jAxioms32.out`, control `rot_in` with
  `sorryAx`, `linkage_dot_ne_zero` clean), `HexRing`: `HadwigerNelson.Plane.ArcMap.rot_out` (FS112-ROTHEX, N2-ROT's outward row (A+, A−)); child
  `dist_radial_hex`.

### FS131-I5m (wave 5's ninth implementer)

*Each stage's build and axiom read named in its line; axioms read from that build's oleans (`data/fs131/i5m/I5mAxioms<stage>.lean`, output `.out`).*

Kernel theorems, on `[propext, Classical.choice, Quot.sound]`:
- Stage 35 (`data/fs131/i5m/build-stage35.log`; `build/gate/build/20261005T062507Z-1929717.log`; axioms `I5mAxioms35.out`, control `bv_nd` with
  `sorryAx`, `linkage_dot_ne_zero` clean), `Plane/ValidMap/HexRing`: `HadwigerNelson.Plane.ArcMap.rot_in` (FS112-ROTHEX, N2-ROT's inward row (B+, B−));
  children `hex_side_far`, `Valid.cone_re_nonpos_of_preconnected`, `dist_radial_hex_in`, `hex_point_in` (all `ArcMap.`).
- Stage 36 (`data/fs131/i5m/build-stage36.log`; `build/gate/build/20261005T064038Z-2050688.log`; axioms `I5mAxioms36.out`, control `bv_l3` with
  `sorryAx`, `linkage_dot_ne_zero` clean), `HexRing`: `HadwigerNelson.Plane.ArcMap.bv_nd` (FS114-BV-HEX's (BV-ND), BASE-V § 1b.2 steps 2–4, with unit
  arcs, at every `k`), and with it `bv_nd1`; children `sq_dist_germ`, `germ_dist_cmp_one`, `exists_chart_of_noRep`, `IsSectorChart.exists_sector_of_region`,
  `BranchGerms.next_adj`, `IsSectorChart.exists_shared`, `Valid.pair_le`, `Valid.pair_ge`, `tangent_pair_ne_one` (all `ArcMap.`).
- Stage 37 (`data/fs131/i5m/build-stage37.log`; `build/gate/build/20261005T065125Z-2125030.log`; axioms `I5mAxioms37.out`, control `bv_l3` with
  `sorryAx`, `linkage_dot_ne_zero` clean), `HexRing`, children for `bv_l3` (not yet consumed): `dot_ringPt_sub`, `linkage_first_order`, `half_le_sin`,
  `linkage_cmp`, `linkage_end` (all `ArcMap.`).

### FS131-I5h (wave 5's `Terminal` implementer)

*Kernel-checked on the build of stage 28 (`data/fs131/i5h/build-stage28.log`; `build/gate/build/20261005T041051Z-1283678.log`); axioms read from that
build's oleans (`data/fs131/i5h/I5hAxioms28.lean`, output `I5hAxioms28.out`; controls `n3_end_of_not_inType` with `sorryAx`, `linkage_dot_ne_zero` clean).*

Kernel theorems, on `[propext, Classical.choice, Quot.sound]`, all in `Plane/ValidMap/HornShadow` (new):
- FS131-E5's **e5-sh**, (SH1) in a global form stronger than E5's: `HadwigerNelson.Plane.tanAbove_S_of_dist_le_one`, mirror `tanBelow_N_of_dist_le_one`;
  horn forms `shadow_hornSet_subset_S`, `shadow_hornSet_add_pi_subset_S`, `shadow_hornSet_subset_N`, `shadow_hornSet_add_pi_subset_N`.
- **e5-sh**, (SH2) as E5 states it (`r ≤ 1/2`): `mem_shadow_hornSet_S`, `mem_shadow_hornSet_add_pi_S`, `mem_shadow_hornSet_N`, `mem_shadow_hornSet_add_pi_N`.
- **e5-sep**, as the unit pair it produces: `sep_S`, `sep_add_pi_S`, `sep_N`, `sep_add_pi_N`.
- Children: `isPreconnected_hornSet_unit`, `exists_drop_height`, `exists_near_hornSet_of_partner`, `lt_of_tanAbove_tanBelow`, `TanAbove.mono`,
  `TanBelow.mono`, `frameY_add_pi`, `tanAbove_add_pi_iff`, `tanBelow_add_pi_iff`, `neg_curvDown_neg`, `e_add_pi_add_pi`, `dist_eq_dist_of_frame`.

None of my ten leaves is closed yet (stage 28, "What is left").

### FS131-I5n (wave 5's fifth `Terminal` implementer)

*Kernel-checked on the build of stage 41 (`data/fs131/i5n/build-stage41.log`; `build/gate/build/20261005T072751Z-2311355.log`); axioms read from that
build's oleans (`data/fs131/i5n/I5nAxioms41.lean`, output `I5nAxioms41.out`; controls `y3_end_needs` and `exists_merge` with `sorryAx`,
`upper_bounds_of_inType_N` clean).*

Kernel theorems, on `[propext, Classical.choice, Quot.sound]`:
- `HadwigerNelson.Plane.ArcMap.cv_hd_main_inType` (`Plane/ValidMap/Terminal`) — FS114-CV-HD's main clause, branch `G_N` (CVB § 1.6).
- U1 for a flank (`Plane/ValidMap/HornShadow`): `ArcMap.flank_radial_N`, `ArcMap.flank_radial_S`, `ArcMap.coneAt_N_subset_of_flankAbove`,
  `ArcMap.coneAt_S_subset_of_flankBelow`.
- Children (`Terminal`): `mem_coneAt_of_e_eq`, `not_mem_angleIcc_of_gap`, `mem_angleIoo_of_e_ne`, `mem_angleIoo_half`, `BranchGerms.exists_succ`,
  `BranchGerms.exists_pred`, `BranchGerms.Mono.false_of_full`, `ArcMap.IsSectorChart.card_le_encard_sectorsOf`, `ArcMap.mergeAvailable_of_two_sectors`,
  `ArcMap.IsSectorChart.exists_index_of_mem_coloursAt`.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

Each quotation checked by reading its source at the named address (main tree for `plans/FS131-close-inventory.md`, `CLAUDE.md`; the worktree for the plan):

| quotation (opening words) | source | result |
|---|---|---|
| "**The plan to work from**: § 4 (leaves 1–22, K5's) and § 9 …" | `plans/FS131-w5-kernel-plan.md` § 10.1, paragraph 5 | verbatim |
| "**It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name …" | the plan § 10.2, paragraph 1 | verbatim |
| "227. **Ruling: repair (b) adopted as drafted** (E4 § 5.2). Choice: `UnenclosedC` on …" | `plans/FS131-close-inventory.md` item 227 (line 1629) | verbatim |
| "218. **Rulings on KB's and IC1's held items** (four parts each, …)" | the inventory, item 218 (line 1562) | verbatim; the brief's summary of (b), (c), (d), (e), (g) matches the item |
| Kooshi, "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors — read before pricing anything | verbatim (the sentence continues in the source with the FLT remark) |
| item 208 (a), `cvb_thom_reduced` priced from its first two children | the inventory, item 208 (line 1485) | matches |

The brief's counts: "41 `sorry` leaves in `Terminal`, `Dense`, `HexRing`, `MapGraph`" — the as-given build's warnings read 14 + 10 + 10 + 7 = 41 (§ 1.2).
"`row134BaseUA` laid out as 19 leaves in `BaseWalk`" — checked after the merge (stage 2). No mismatch found.

### 1.2 The as-given build (`764cc558`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree: **OK — all 1749 modules already up to date,
nothing built, 7 modules with warnings**, exit 0 (`build/gate/build/20261004T202344Z-2104727.log`; driver log `data/fs131/i5/build-stage1-asgiven.log`).
Every warning is `declaration uses 'sorry'`, 86 in all: wave 5's `Terminal` 14, `Dense` 10, `HexRing` 10, `MapGraph` 7 (41), and wave 4's `BaseSteps` 16,
`Contact` 10, `UnitArc` 19 (wave 4's implementers' own, on their branches).

### 1.3 What I may and may not change

**May** (plan § 10.2; brief § What is yours to decide): add children anywhere in the wave-5 modules (`Chain`, `Terminal`, `Dense`, `HexRing`, `MapGraph`,
and after the merge `BaseWalk`, `BaseDense`); place shared children in `Chain` or in wave 3–4's foundation modules (`Plane/ValidMap/Basic`,
`Plane/LocalMap`, `Plane/LocalStructure`, `Plane/RingGerm`, `Plane/RingBand`), statements unchanged, each with a spec example; add strengthened forms of
wave 4's moves as new lemmas; change imports (updating `ARCHITECTURE.md` and `scripts/Axioms.lean`, my block headed "FS131-I5"); add `cor3_local` as a
new lemma (item 218 (b)). **One ruled statement change, mine to apply**: FS131-E4's repair (b), E4 § 5.2 verbatim (item 227).

**May not**: change any statement of the plan's §§ 3.2, 8.2 or of KB's base plan beyond E4 § 5.2; change any definition of `Chain` beyond E4's two
additions (`UnenclosedC`, `Unenclosed`), or `HexRing`'s or `MapGraph`'s vocabulary; add an `axiom` or `native_decide`; edit wave 4's modules (`Contact`,
`UnitArc`, `BaseSteps`, `SVMap`, `StuckChain`); edit a file while a build of it runs; build except through `scripts/build.sh` under the slot. A leaf that
cannot be proved as written goes to Keryx at once with the reason and the smallest counterexample or missing hypothesis.

## Stage 1 — SAVED

## Stage 2 — SAVED: the merge of `fs131-w5b`

**The merge**: `fs131-w5b` (`49ed9cc4`, FS131-KB's base skeleton) merged into `fs131-w5` as `160b04f6` — the one commit of this job made without paths
(a merge commit records the merged tree; its message says so). **No conflicts**: `fs131-w5b` branched at `764cc558`, and `fs131-w5` since carried only
this job's record and log, so the expected append-only conflicts (`scripts/Axioms.lean`, `Proofs.lean`, `ARCHITECTURE.md`, `Dense.lean`'s moved block)
did not arise.

**The build** of `160b04f6` (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 446 of 446 batches, 4 modules rebuilt (`Dense`, `BaseWalk`, `BaseDense`, `Proofs`),
9 modules with warnings, every warning `declaration uses 'sorry'`**, exit 0 (`build/gate/build/20261004T202434Z-2107187.log`; driver log
`data/fs131/i5/build-stage2-merge.log`). Sorry declarations, 105 in all: wave 5's **60** — `Terminal` 14, `Dense` 5, `HexRing` 10, `MapGraph` 7 (K5's and
K5b's 41, with `row134BaseUA` and its four consumers now in `BaseDense`, 5) and `BaseWalk` 19 (the brief's count, confirmed) — and wave 4's 45.

**Duplicates.** `tools/fs131_qa1_dupes.py` (FS131-QA1's, run as the brief asks): exit 0, 6 names, all wave 1–4 (`data/fs131/i5/qa1-dupes-stage2.txt`) — but
that tool's body table has no wave 5, so it cannot see this merge. So I wrote **`tools/fs131_i5_dupes.py`**, which reuses QA1's declaration reader and asks
whether a name new in wave 5's own files since its fork from wave 4 (`9a8de899`) is declared at the tip of `main`, `fs131-w2`, `fs131-w4`, `fs131-w4c` or
`fs131-ww` in another file, or in the same file without being there at the fork. **Result: 107 new names, 0 collisions**, exit 0
(`data/fs131/i5/i5-dupes-stage2.txt`). Controls: `--self-test` (a faithful body stays quiet; a different-file plant and a same-file plant each fire) OK; the
red control on real data — the same check against `fs131-w5b`, which carries the merged files — reports all 107 names and exits 1, for the stated reason
("same file, added by both since the fork").

**Iteration** (never evidence): `data/fs131/i5/iter.sh` (wave 4's script re-pointed at this worktree, scratch `/home/kooshi/scratch-w5-i5`).

## Stage 2 — SAVED

## Stage 3 — SAVED: FS131-E4's repair (b), applied

**Applied, E4 § 5.2 verbatim** (`plans/FS131-E4-derivation.md` § 5.2, main tree; inventory item 227):

| E4 § 5.2 item | where | read back against E4 |
|---|---|---|
| `UnenclosedC`, `Unenclosed` (definitions and docstrings) | `Plane/ValidMap/Chain`, namespace `ArcMap`, beside `NoInertNear` | verbatim, text and docstrings |
| `Row134BaseUA` gains `F.UnenclosedC u`; the bold sentence gains "and no tile of a colour of `u` enclosing a tile at `u`" | `Chain` | statement verbatim; the bold sentence carries E4's words; the docstring's module pointer corrected (`Dense` → `BaseDense`, where KB moved it) |
| `BaseCtx` gains `unenclosed : F.UnenclosedC u` ("no tile of a colour of `u` encloses a tile at `u`") | `Plane/ValidMap/BaseWalk` | verbatim |
| `exists_eleventh`: statement unchanged, "**GAP as the walk stands**" → "proved from `B.unenclosed` (FS131-E4 E4-RIM)" | `BaseWalk` | statement unchanged; docstring rewritten around E4's words with the argument's address |
| `n3_base` gains `(hE : F.UnenclosedC u)` | `Plane/ValidMap/BaseDense` | verbatim |
| `exists_unenclosed_or_bad` stated (`sorry`) | `BaseDense` | statement verbatim; E4's docstring sentence kept, the argument's outline and address added |
| `localDense`'s proof through `exists_unenclosed_or_bad` (`ρ = 2`) then `n3_base` at `v` | `BaseDense` | **proved** over the two (`closedBall v 2 ⊆ closedBall x 3` by the triangle inequality); statement unchanged |
| `not_row134BaseUA_seven`'s hypothesis list gains `F.UnenclosedC u` | `Plane/ValidMap/Dense` | verbatim; docstring says why the seven-brick corner satisfies it |
| `dense3`, `cv_exists` statements unchanged | `BaseDense` | unchanged (`dense3` now proved from `localDense`, below) |

**The four children** E4 names, stated or proved: `exists_eleventh` from `B.unenclosed` (an existing `sorry` leaf; its route E4-RIM); `exists_unenclosed_or_bad`
(new `sorry`, E4-OUTERMOST); **the pre-bend** as one new child **`exists_preBend`** (new `sorry`: from `Valid`, `Covers u 2`, cubic trichromatic, `BaseHyp u`,
`UnenclosedC u`, a modified fragment with all of those and `NoInertNear u` — KB's owed strengthened-bend child with E4-BEND-UN's clause joined, as E4 says;
its measure is the number of unit arcs meeting `B̄(u, 2)`, which every bend lowers, a bend's new curve not being a unit arc); **`Unenclosed.unenclosedC`**
(proved, by definition). `n3_base` is now **proved** over `exists_preBend` and `row134BaseUA`.

**Spec examples** (Chain): the one-colour plane satisfies `UnenclosedC` (through `Unenclosed`); an adversary — a tile at `v` with a point in a bounded
component of `(cl T)ᶜ` for `T` of a colour at `v` — refutes it.

**A slip found and fixed in K5's `scripts/Axioms.lean` block**: the record `#print axioms HadwigerNelson.Plane.row134BaseUA` names a constant that never existed
(`row134BaseUA` has always been declared inside `namespace ArcMap`, at `764cc558` in `Dense` and now in `BaseDense`): `Unknown constant`, which would fail the
gate's audit. Corrected to `HadwigerNelson.Plane.ArcMap.row134BaseUA` (one line in K5's block, logged here). All 72 wave-5 records now resolve (checked by
compiling every `#print axioms` line of the wave-5 blocks against the iteration oleans). My block, "FS-131 wave 5 (job FS131-I5)", records the three new
declarations.

**Docstrings updated**: `Chain`'s module doc (an enclosure bullet; `Row134BaseUA`'s bullet), `BaseWalk`'s module doc and `BaseCtx`'s, `BaseDense`'s module doc,
`row134BaseUA`'s (the eleventh point from `unenclosed`), `n3_base`'s, `localDense`'s.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 446 of 446 batches, 7 modules rebuilt, 9 with warnings, every warning `declaration uses 'sorry'`**,
exit 0 (driver log `data/fs131/i5/build-stage3-repair.log`). Wave 5's sorry declarations: `BaseDense` 4 (`row134BaseUA`, `exists_preBend`,
`exists_unenclosed_or_bad`, `cv_exists`; `n3_base`, `localDense`, `dense3` now proved over their children), `BaseWalk` 19, `Dense` 5, `HexRing` 10,
`MapGraph` 7, `Terminal` 14 — 59, against 60 before: two children added, three consumers proved.

## Stage 3 — SAVED

## Stage 4 — SAVED: the base's obligation pass (`debruijn-obligation-modeling`, invoked fresh), the `#check`s, and `IsRetArc`'s repair

### 4.1 What the pass decided, statement by statement (BaseWalk, BaseDense, after E4's repair)

*For each: does the proof derive from the statement as written; its decomposition; a hypothesis the proof needs that the statement lacks. A statement
under `BaseCtx` is true vacuously once `row134BaseUA` lands; the question asked of each is whether its **local** argument exists.*

| statement | verdict | decomposition, children, notes |
|---|---|---|
| `CircleColouring.reduce` | derives | CD Lemma R steps 4–5 (`plans/FS110-CD-verification.md` § 2.4, § 3.0 item 2): recolour each maximal span by its outer colour; properness case by case (CD's five cases; the "open vs closed" case uses that partners of open-arc points are third-coloured). Measure: the finite family's maximal elements. Children: `maximal_of_nested`, the five case lemmas |
| `CircleColouring.select` | derives | BASE-V § 1a.2–1a.3 over wave 3's `Lift` (as KB § 4 B2) |
| `BaseCtx.cubic_of_three` | derives | child `isCubicTrichromatic_of_three_of_noRep` (the sector chart: three colours, one sector each when no colour repeats, so `max n 1 = 3`) with `BaseHyp`'s `repSet` clause |
| `BaseCtx.pseudo_nonempty` | derives | the (P) sweep at each tile at `x` against `p`'s sector of its colour: each tile at `x` lies on one side of `ω(p)` locally, so `ω(p)` near `x` is in `Γ` with both sides in `P_cl(p)`; child `exists_isRingArc_of_onRingArc`; then `noBoth` at `p ∈ B̄(u, 2)` against H |
| `BaseCtx.pseudo_ncard_le_two` | derives **through `cor3_local`** (ruling 218 (b)) | three pseudo-colours make `P_cl(x)` the complement of `P_cl(p)` (H caps it at three), `x` cubic by `cubic_of_three`, `dist x p = 1 < 2`; `cor3` needs `Covers x 1`, which `B̄(u, 2)` does not give; `cor3_local` reads the strips at the corners and the arcs at `p`, `x` only — its exact hypothesis is fixed when NB3-COR3's argument is read for it (owed with the leaf) |
| `BaseCtx.pseudo_finite` | derives | as KB § 4 A3; the measure-free finiteness (compactness of `ω(p)`, local finiteness, two points per non-concentric arc); concentric arcs carry one pseudo-colour (in/out-contact), inert excluded by `NoInertNear`, both-kind by `noBoth` with H |
| `BaseCtx.exists_pseudoCircle` | derives | **`S` = the genuine change points only** (germs differ): at a singleton point the pseudo-colour is locally constant (upper semicontinuity of `P_cl` by local finiteness, with `pseudo_nonempty`), so every angle has both germs and `c` is defined by them; a non-singleton point with equal germs (a tangent tile, a spike) is not in `S`, which is what the clause `∀ θ ∈ C.S, ¬ ∃ v, LeftVal ∧ RightVal` demands |
| `BaseCtx.retArc_partner` | derives | CD step 3: `ω(y)` meets `ω(u)` at angle `x` only within the arc; the `a`-tile connected with both ends in its closure crosses `ω(y)`; the (P) sweep. Reads validity and `Covers` only |
| `BaseCtx.retArcs_finite` | derives | ends are germ-change points, which are non-singleton (both germ colours at the point), finitely many per period by `pseudo_finite`; plus a periodicity lemma for `IsRetArc` (the assembly needs the family over one period) |
| `BaseCtx.retArcs_nested` | **did not derive as KB stated `IsRetArc`; derives after the repair (§ 4.3)** | CD step 4 over the joining continua (planar core, C3) |
| `BaseCtx.exists_endpoint` | derives (planar core, C4) | **its `hc`'s second disjunct is dead**: with `ha` (`cw a`) it asks `cw c`, and one germ has one pseudo-colour, so `a = c`, against `hac` — the statement is the one-order form; a `c → a` change is used by calling it with the colours swapped. Not a defect, recorded so the assembly is not surprised |
| `BaseCtx.exists_eleventh` | derives from `B.unenclosed` | E4-RIM steps 1–5; children: Lemma H(a) (`tile_subset_ball_of_meets`: a tile of a colour of `u` meeting `B(u, 1)` lies in it), no tile of a colour of `u` meets `ω(u)`, and the planar lemma (the frontier of the unbounded complementary component of a plane continuum is connected — not in Mathlib, grep below; the planar-infrastructure job, items 218 (c), 227) |
| `endpoint_dist_ge` | **proved** (stage 5) | — |
| `BaseCtx.vin_antipodal` | derives | Lemma H as in E4-RIM step 1: `u`'s `i`-tile `S` and the tile `T` at `p` give all cross distances below `1`, so `S ⊆ B̄(p, 1) ∩ B̄(p′, 1) = {u}`, against `S` open; child: a tile of colour `i` at `u` for `i ∈ P_cl(u)` |
| `BaseCtx.eleventh_antipodal` | derives | CD Theorem D2 (ii): `u`'s tiles of `q`'s two colours lie in `B̄(q, 1)`, of `p`'s colour in `B̄(p, 1)`; the cusps `u + t e⊥` lie outside both, and the three sectors at `u` cover a punctured neighbourhood's interior points |
| `BaseCtx.cor3_base` | **proved** over `cor3` (stage 5) | — |
| `BaseCtx.l3_base` | derives | BASE-V BV-L3 in pseudo-colour form (KB § 2.2): shared circle-abstract child `linkage_band`; `linkage_dot_ne_zero` (proved) |
| `BaseCtx.hex_base` | derives | `rot_noThird` gives each of the six points pseudo-colour exactly its two germ colours, so `HexRing u ψ (g ∘ b)`; then `p17_ua`. **The assembly calls it with the unreduced colouring** (`exists_pseudoCircle`'s `C`): `IsHex` reads only the six points' one-sided values, which `reduce` preserves, while `hex_base`'s `∀ θ` germ hypotheses fail for the reduced `C′` inside recoloured spans |
| `eleventh_type` | **proved** (stage 5) | — |
| `row134BaseUA` | derives | the assembly as its docstring: `exists_pseudoCircle`; `𝓙` = the returning arcs over one period (`retArcs_finite`), removable by `retArc_partner`, nested (`retArcs_nested`); `reduce`; `select` — hexagon → `hex_base` on the unreduced `C`; else nine change points with endpoints (`exists_endpoint`, `hout` from `reduce`'s "outside every span"); each endpoint's third colour is a colour of `u` (else it is complementary to `u` within `1`, against `cor3_base`); per pair the three third colours are distinct (two equal: same multicolour, distance in `[1, 2]` by `endpoint_dist_ge`, not `1` by `pair_P'`, not `2` by `vin_antipodal`, else `l3_base`); `exists_eleventh`; `eleventh_type`; `eleventh_antipodal` and `cor3_base` close |
| `exists_preBend` | derives | the measure: the number of unit arcs meeting `B̄(u, 2)` (finite by local finiteness on the compact disc), lowered by each toward-bend (the new curve is not a unit arc); each bend keeps validity (wave 4's bend), `Covers`, `u`'s sectors (arcs ending at `u`: "at the ends the sector structure is unchanged"), H (no point gains a colour or sector), and `UnenclosedC u` (E4-BEND-UN); the lens stays in `B̄(P, 1) ⊆ B̄(u, 2)` |
| `n3_base`, `localDense`, `dense3` | **proved** over their children (stage 3) | — |
| `exists_unenclosed_or_bad` | derives | E4-OUTERMOST: children `tile_diam_le_one` (from `IsTile.dist_lt_one`), hulls, the outermost tile (a finite chain: finitely many tiles meet `B̄(x, 1)`), the rim's two outer tiles (the planar lemma), `isCubicTrichromatic_of_three_of_noRep` |
| `cv_exists` | derives | KB/K5 § 4 leaf 21 |

**Test, prove, assume** (the partition): proved — everything above; tested — the spec examples (`UnenclosedC`'s two); assumed — nothing new (no `axiom`;
the planar lemma is to be formalized, not imported).

### 4.2 The Mathlib names, confirmed at the pin

`data/fs131/i5/I5Checks.lean` (`lake env lean`, exit 0, output `data/fs131/i5/I5Checks.out`): `SimpleGraph.sum_degrees_eq_twice_card_edges`,
`SimpleGraph.even_card_odd_degree_vertices` (the handshake lemma C4 names), `IsPreconnected.prod`, `IsPreconnected.image`, `IsPreconnected.Icc_subset`,
`closure_prod_eq`, `Metric.mem_closure_iff`, `Metric.closedBall_subset_closedBall`, `isClosed_le`, `connectedComponentIn`, `IsOpen.connectedComponentIn`,
`isPreconnected_connectedComponentIn`, `IsPreconnected.subset_connectedComponentIn`, `Bornology.IsBounded`, `IsCompact.isBounded`,
`Metric.isBounded_iff_subset_closedBall`, `convexHull`, `Convex.isPreconnected`, `IsCompact.elim_finite_subcover`, `isCompact_closedBall`, `isCompact_sphere`,
`Set.Finite.subset`, `Finset.card_union_add_card_inter`, `Finset.card_sdiff_add_card_inter`, `Finset.eq_of_subset_of_card_le`, `Finset.card_image_of_injective`,
`Finset.card_compl`, `ENat.card_eq_top_of_infinite`, `IsClosed.frontier_eq` — 29, all present. (A thirtieth, `isPreconnected_iff_subset_of_disjoint_fun`, was my
guess and does not exist; removed.) **Not in Mathlib** (`grep -rl` over `.lake/packages/mathlib/Mathlib` for "nicoheren", "Janiszewski", "JordanCurve",
"jordan_curve": no file): unicoherence of the plane and the Jordan curve theorem — the planar lemma E4 needs is to be built.

### 4.3 `IsRetArc` gains CD's β (inventory items 231–232; the brief's amendment)

**The configuration that forced it** (sent to Keryx mid-job): one `a`-tile and one `c`-tile, `a` and `c` both absent at `u`, whose common boundary crosses
`ω(u)` at `0°`, `20°`, `40°`, so the ring reads `a | c | a | c`. KB's path-free `IsRetArc` (one `a`-tile and one `c`-tile with both ends in both closures, plus the
germ pattern) holds for `[0°, 20°]` with `(a, c)` and for `[20°, 40°]` with `(c, a)`; the closed arcs meet only at `r(20°)`, so `retArcs_nested` fails there,
`reduce`'s conclusion fails for abutting spans (`r(20°)` stays a change point), and `exists_endpoint`'s `hout` excludes `r(40°)`, which in CD's sense is not
returning. Checked against `retArc_partner` (partners of `(0°, 40°)` at `(60°, 100°)` and `(−60°, −20°)` carry the third colour) and ring properness: consistent.
The source (FS110-CD Lemma R, `plans/FS110-CD-verification.md` § 2.4, l. 200): "Let `(b, b′)` be a returning pair joined by `β` (an `a|c` boundary path in the
closed disc)" — the clause the Lean had dropped.

**The change** (`Plane/ValidMap/BaseWalk`): `IsRetArc`'s last clause is now `∃ T₁ T₂, F.TileOf a T₁ ∧ F.TileOf c T₂ ∧ ∃ K, IsConnected K ∧ ringPt u s ∈ K ∧
ringPt u t ∈ K ∧ K ⊆ closure T₁ ∩ closure T₂ ∩ closedBall u 1` (CD's β read as a continuum; it implies the four closure memberships it replaces). Docstring
cites CD § 2.4 l. 200 and items 231–232 and states the configuration. The uses: `retArcs_nested`'s and `exists_endpoint`'s statements are textually unchanged
(they quantify over `IsRetArc`); `reduce` is circle-abstract and does not mention it; the docstrings of `retArc_partner`, `retArcs_nested` (why abutting is now
excluded: one inner `a|c` germ per point of `ω(u)` under H, an `a|c` germ along `ω(u)` being an inert arc) and `exists_endpoint` ("outside every returning arc,
CD's sense") are updated. No other definition or statement changed.

### 4.4 The build of stage 4 (with stage 5's leaves)

One build carries stages 4 and 5 (`data/fs131/i5/build-stage5.log`; `build/gate/build/20261004T205348Z-2322842.log`): **OK — 446 of 446 batches, 7 modules
rebuilt, 9 with warnings, every warning `declaration uses 'sorry'`**, exit 0. A first launch of it waited on the slot (`ledger 80 + 40 > budget 90 GiB`) and was
stopped by its PID (2298563, verified absent from `ps`) before admission, nothing built, so that two more leaves could join it; the log of that try was
overwritten by the relaunch.

## Stage 4 — SAVED

## Stage 5 — SAVED: leaves proved

**Order** (§ 10.1's, cheapest first, re-cut by what was ready): the shared child `isCubicTrichromatic_of_three_of_noRep` (placed in `HexRing`, upstream of
every consumer — `Chain` cannot see the sector charts), then `linkage_dot_ne_zero`, `flankQ_*_of_qrOnly`, `p17_ua` over `bv_hex`, `cvb_thom` over `lemma1`
(§ 10.1's wiring leaves), `triLattice_hyps`, `disc1ts`, `disc1ts_degree`, and from the base `eleventh_type`, `endpoint_dist_ge`, `cor3_base`, `cubic_of_three`, plus
`bv_nd1` over `bv_nd`. Every statement is the one committed (no statement changed); `p17_ua`'s declaration moved below `bv_hex` in `HexRing` (a position,
not a statement), and `triLattice_adj` (six-case adjacency) was added as a child.

**Read back against the plan's read-backs** (§§ 3.2, 8.2, KB § 3.2): same statements, each.

**Two computations worth recording.** `bv_nd1` over `bv_nd`: `x₀ − σx₀ = e(φ − 60°)`, and the double event is read with both sides **clockwise** and the colours
in the order `(β, α)` — the clockwise velocities `−i e φ`, `−i e(φ + 60°)` have component `cos 30° > 0` along `e(φ − 60°)` (K5b's note, "both forward sides
clockwise", confirmed). `linkage_dot_ne_zero`: both dots zero give `w = l e φ`, `e χ = m w` with `l, m = ±1`, so `u₁ − u₂ = (l − 1 + m l) e φ` of length `1` or
`3` — exact, by `linear_combination` over the unit-norm identities.

**Re-pricing** (brief item 4: from the first two hard leaves). None of the plan's **H** leaves was reached; the fourteen proved here are its **E** and **M**
leaves and wirings. Measured on them: an **E** leaf took one attempt (minutes), an **M** leaf (`endpoint_dist_ge`, `isCubicTrichromatic_of_three_of_noRep`,
`triLattice_hyps`) one or two iterations, about 30–60 lines each — at or below the plan's pricing. The **H** leaves stay un-priced. **`cvb_thom_reduced`'s first two
children were not reached**, so item 208 (a)'s price is not given.

## Stage 5 — SAVED

## Stage 6 — SAVED: what is left, for wave 5's next implementer

**Left: 46 `sorry` declarations in wave 5** (`Terminal` 12, `Dense` 3, `HexRing` 7, `MapGraph` 5, `BaseWalk` 15, `BaseDense` 4), in § 10.1's order with the
base's: `Thomassen.lemma1` (pure graph theory; **its proof is planned in full below**) → `bv_nd`, `bv_hex` (six children), `rot_noThird`, `rot_out`, `rot_in`,
`hex_regular`, `bv_l3` → `disc1_local`, `cor3` (and `cor3_local`, ruling 218 (b)) → the chain leaves (`stuck_structure_ua`, `cv_l0`, `cv_hd_main`, `cv_hd`,
`cv_class`, `y3_end_needs`, `c_ends`, `c_double`, `n3_end_chain`) → `sevenBrickMap_isTerminalMap`, `not_row134BaseUA_seven` → `exists_red`, `exists_terminal` →
`cv_exists` → `exists_holed_valid_fragment`, `cvb_pinch_connected`, `cvb_hole_disconnected` → `cvb_thom_reduced`; the base: `pseudo_nonempty`,
`pseudo_ncard_le_two`, `pseudo_finite`, `exists_pseudoCircle`, `reduce`, `select`, `retArc_partner`, `retArcs_finite`, `vin_antipodal`, `eleventh_antipodal`,
`l3_base`, `hex_base`, `exists_preBend`, then the planar core (`retArcs_nested`, `exists_endpoint`, `exists_eleventh`, `exists_unenclosed_or_bad` — the
planar-infrastructure job, items 218 (c), 227), and `row134BaseUA` (§ 4.1's assembly).

**`Thomassen.lemma1`, the proof to transcribe** (`[Thomassen1999]` p. 850–851, read 2026-10-04 in the OCR copy
`~/source/library/papers/Thomassen-1999-On-the-Nelson-unit-distance-coloring-problem.txt` ll. 73–100, recast with two uniform lemmas so the three
degree cases share them). Let `D n = {v | G.dist x v = n}` (connected, so `G.dist` is the distance). Two facts for every vertex: **(C)** an edge `zw` has
two common neighbours (`w`'s two cycle-neighbours in the cycle on `N(z)`, distinct since a cycle has length ≥ 3); **(L)** a vertex of `D n`, `n ≥ 1`, with a
neighbour in `D (n+1)` has at least two neighbours in `D n` (its cycle visits `D (n−1)` and `D (n+1)`, which no edge joins, so each of the two arcs between
them holds a vertex of `D n`; formally, deleting the `D n` vertices — at most one — leaves a path on which the level cannot jump by `2`). With all
degrees ≤ 5 and `x` of maximum degree `d`: `d = 3` — each `y ∈ D 1` has `x` and two common neighbours with `x` (in `D 1`), so no neighbour in `D 2`: `|V| ≤ 4`.
`d = 4` — each `y ∈ D 1` has ≤ 1 neighbour in `D 2`; a `z ∈ D 2` with lower neighbour `y` has (C) two common neighbours with `y` inside `N(y) ∖ {x, z} ⊆ D 1`,
so ≥ 3 lower neighbours; ≤ 4 edges `D 1 → D 2` give `|D 2| ≤ 1`; then (L) forbids `D 3`: `|V| ≤ 6`. `d = 5` — each `y ∈ D 1` has ≤ 2 neighbours in `D 2`; a
`z ∈ D 2` has ≥ 2 lower neighbours (`y` and a common neighbour in `D 1`, since `N(y)` holds at most one other `D 2` vertex); `z` has ≤ 1 upper neighbour (two
would give, by (L), ≥ 2 + 2 + 2 = 6); a `w ∈ D 3` has ≥ 3 lower neighbours (`z` and its two common neighbours with `z`, inside `N(z)`'s `D 2` part); so
`|D 2| ≤ 10 / 2 = 5`, `|D 3| ≤ 5 / 3`, i.e. ≤ 1, and (L) forbids `D 4`: `|V| ≤ 12 < 13`. Mathlib pieces: `Reachable.exists_walk_length_eq_dist`,
`Connected.dist_triangle`, `dist_eq_one_iff_adj`, the bipartite double count `Finset.sum_card_bipartiteAbove_eq_sum_card_bipartiteBelow`. Estimated 300–400 lines.

**Drafts for the front page**: none this phase — wave 5 is not at its gate (the gate and the landing are a later implementer's, after wave 4 lands), and no
milestone closes. For the gate's eventual carriers decision (plan § 10.3), nothing here changes K5b's recommendation; `IsRetArc` stays **OUT** (an atom read
inside refutations).

## Stage 6 — SAVED

---

*Continued by FS131-I5b, wave 5's second implementer (de Bruijn, the implementer, on Opus), on branch `fs131-w5` in the same worktree. Brief:
`data/fs131/briefs/FS131-I5b-wave5.md` (main tree). Started 2026-10-04. Stages 1–6 above are FS131-I5's; mine start at 7.*

## Stage 7 — SAVED: FS131-I5b's readback

### 7.1 The brief's quotations against their sources (standing rule 3)

| quotation (opening words) | source | result |
|---|---|---|
| "**Left: 46 `sorry` declarations in wave 5** (`Terminal` 12, `Dense` 3, `HexRing` 7, `MapGraph` 5, `BaseWalk` 15, `BaseDense` 4), in § 10.1's order with the" | this record, Stage 6, paragraph 1 | verbatim |
| "**`Thomassen.lemma1`, the proof to transcribe** (`[Thomassen1999]` p. 850–851, read 2026-10-04 in the OCR copy" | this record, Stage 6, paragraph 2 | verbatim |
| "239. **Ruling: the planar core goes to the planar-infrastructure job** — `cvb_thom_reduced`, `retArcs_nested`, `exists_endpoint`, `exists_eleventh`," | `plans/FS131-close-inventory.md` item 239 (main tree, line 1717) | verbatim; the item continues with the fifth, `exists_unenclosed_or_bad` |
| "**It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the" | `plans/FS131-w5-kernel-plan.md` § 10.2, paragraph 1 | verbatim |
| "232. **Ruling: `IsRetArc` gains CD's β** — some connected `K` with `r(s), r(t) ∈ K ⊆ closure T₁ ∩ closure T₂ ∩ closedBall u 1`. Choice: I5 makes the definition" | the inventory, item 232 (line 1663) | verbatim |
| Kooshi, "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors — read before pricing anything | verbatim (the paragraph continues with the FLT remark) |

The brief's counts: "46 … (`Terminal` 12, `Dense` 3, `HexRing` 7, `MapGraph` 5, `BaseWalk` 15, `BaseDense` 4)" and "41 are yours" — confirmed by the as-given build
(§ 7.2): 46 wave-5 `sorry` warnings, of which the five planar-core leaves (`cvb_thom_reduced` in `MapGraph`; `retArcs_nested`, `exists_endpoint`,
`exists_eleventh` in `BaseWalk`; `exists_unenclosed_or_bad` in `BaseDense`) leave 41. No mismatch found.

### 7.2 The as-given build (`7b049700`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1751 modules already
up to date, nothing built, 9 modules with warnings**, exit 0 (`build/gate/build/20261004T210641Z-2410833.log`; driver log
`data/fs131/i5b/build-stage1-asgiven.log`). Every warning is `declaration uses 'sorry'`: wave 5's `Terminal` 12, `Dense` 3, `HexRing` 7, `MapGraph` 5,
`BaseWalk` 15, `BaseDense` 4 (46), and wave 4's `BaseSteps` 16, `Contact` 10, `UnitArc` 19 (wave 4's implementers', on their own branches).

### 7.3 What I may and may not change

**May** (plan § 10.2; brief § What is yours to decide): add children anywhere in the wave-5 modules (`Chain`, `Terminal`, `Dense`, `HexRing`, `MapGraph`,
`BaseWalk`, `BaseDense`); place shared children in `Chain` or in wave 3–4's foundation modules (`Plane/ValidMap/Basic`, `Plane/LocalMap`,
`Plane/LocalStructure`, `Plane/RingGerm`, `Plane/RingBand`), statements unchanged, each with a spec example; add strengthened forms of wave 4's moves as new
lemmas; change imports (updating `ARCHITECTURE.md` and `scripts/Axioms.lean`, my block headed "FS131-I5b"); state `cor3_local` as a new lemma (item 218 (b)),
its covering hypothesis fixed only after NB3-COR3's argument is read.

**May not**: change any statement of the plan's §§ 3.2, 8.2 or of KB's base plan (row theorems, hypotheses, conclusions), any definition of `Chain`, or
`HexRing`'s or `MapGraph`'s vocabulary (§ 10.2's list), or the two ruled repairs as I5 applied them; add an `axiom` or `native_decide`; edit wave 4's modules
(`Contact`, `UnitArc`, `BaseSteps`, `SVMap`, `StuckChain`); prove the five planar-core leaves (item 239); edit a file while a build of it runs; build except
through `scripts/build.sh` under the slot. A leaf that cannot be proved as written goes to Keryx at once with the reason and the smallest counterexample or
missing hypothesis.

## Stage 7 — SAVED

## Stage 8 — SAVED: `Thomassen.lemma1` and `exists_holed_valid_fragment` proved; a statement defect in `cvb_hole_disconnected`

**`Thomassen.lemma1`** (statement unchanged; read back against plan § 8.2: same statement). I5's planned proof (Stage 6) with one simplification:
the vertex `x` need not have maximum degree. With every degree at most `5`, **any** `x` gives `|D₁| ≤ 5`, `|D₂| ≤ |D₁|`, `|D₃| ≤ 1`, `D₄ = ∅`, so
`|V| ≤ 12`: I5's three degree cases are its `d = 5` case run with `deg ≤ 5` everywhere. Children, each stated over a general graph:
- `LocallyHamiltonian.exists_two_common` — (C): an edge `y w` has two distinct common neighbours (`w`'s two neighbours on `N(y)`'s cycle, through
  Mathlib's `Walk.IsCycle.ncard_neighborSet_toSubgraph_eq_two`).
- `exists_eq_of_steps_up`, `exists_eq_of_steps` — a discrete intermediate value theorem for integer sequences with steps of size at most `1`.
- `LocallyHamiltonian.two_mid` — (L): a vertex with neighbours at levels `m` and `m + 2` has two distinct neighbours at level `m + 1` (the cycle
  `N(v)` read through `Walk.getVert`, levels changing by at most `1` per step by `Adj.diff_dist_adj`; one crossing between the two positions, a
  second on the other arc, distinct by `IsCycle.getVert_injOn'`).
- The count: double counting by `Finset.card_nsmul_le_card_nsmul` (edges `D₂ → D₁`: `2|D₂| ≤ 2|D₁|`; edges `D₃ → D₂`: `3|D₃| ≤ |D₂|`).
`MapGraph` gains three Mathlib imports (`SimpleGraph.Connectivity.Subgraph`, `SimpleGraph.Metric`, `Enumerative.DoubleCounting`); the project
import graph is unchanged. Spec examples: `exists_eq_of_steps` on the identity sequence; `exists_two_common` on the triangular lattice. **The bound
`13` is load-bearing**: the icosahedron's graph (12 vertices, 5-regular, every neighbourhood a 5-cycle) satisfies every other hypothesis.

**`exists_holed_valid_fragment`** (statement unchanged; the docstring's ring now reads `1/2 < |z| < 3/5`, colours `3, 4, 5, 6 = 0`). The object,
`holedFrag : ArcMap 6` on `B(0, 3/5)`: arcs the circles of radii `1/4`, `1/2` and four radial segments on the axes from radius `1/2` to `3/5`
(`holedArcs`); colour `2` on `|z| < 1/4`, `1` on `1/4 ≤ |z| < 1/2`, one colour per quadrant beyond (`holedCol`). Valid: each colour class lies in a
disc of radius `1/2` about `0` or in one closed quadrant of `B(0, 3/5)`, where two points are less than `1` apart (`dist_lt_one_of_same_quadrant`:
`dist² ≤ |x|² + |y|² < 18/25`). The tile through `3/8` is the open annulus (both inclusions: the annulus is preconnected, the image of a band under
polar coordinates; the component's norms avoid `1/4` and `1/2`, `norm_side_of_isPreconnected`); its closure is the closed annulus; the hole is the
component of `0`, inside `B(0, 1/4)`; every unbounded component lies in `|z| > 1/2`.

**A statement defect, sent to Keryx mid-job (2026-10-04): `cvb_hole_disconnected` is false as written** — `IsHoleOf` counts a bounded component of
`(cl T)ᶜ` as a hole when its closure misses only the *unbounded* components' closures, so a bounded component chained to the outside through another
bounded component passes. Counterexample at `k = 7`: `sevenBrickMap` with three whole circles added as arcs in the brick `[0, 4/5] × [0, 3/5]`
about `c = 2/5 + (3/10)i` — radius `1/4` about `c`, radius `1/16` about `c + 1/16` (`D₁`), radius `1/16` about `c + 3/16` (`D₂`); the colouring is
unchanged, so the map stays valid and of the plane. `T = B(c, 1/4) ∖ (D̄₁ ∪ D̄₂)` has `IsHoleOf T D₁`, yet in `mapGraph − T` the tiles `D₁ ~ D₂`
(closures meet at `c + 1/8`) `~ brick ∖ B̄(c, 1/4)` (at `c + 1/4`) `~` the bricks: connected. `∂T` is connected (CVB's sense: no hole). Proposed
repair (Keryx's or the planner's): quantify `IsHoleOf`'s last clause over every other component. The definition feeds `fill`, `IsOuterTile`,
`filledGraph` — the planar-core job should know. The leaf is left `sorry` and not touched.

**`cvb_pinch_connected`** looks true as written (a weaker `IsHoleOf` strengthens "no hole"): it derives from the uniqueness of the unbounded
component of `(cl T)ᶜ` (`cl T` bounded, the complement of a large closed ball connected) and the connectedness of the tiles' adjacency graph inside
each component (an open connected set, tiles locally finite) — planar topology of the planar core's kind; not attempted.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 446 of 446 batches, 2 modules rebuilt (`MapGraph`, `Proofs`), 9 with warnings, every warning
`declaration uses 'sorry'`**, exit 0 (driver log `data/fs131/i5b/build-stage8.log`; `build/gate/build/20261004T212909Z-2535131.log`; the first build,
lemma1 alone, `data/fs131/i5b/build-lemma1.log`, also OK). Wave 5's sorry declarations: **44** (`Terminal` 12, `Dense` 3, `HexRing` 7,
`MapGraph` 3, `BaseWalk` 15, `BaseDense` 4), against 46. `tools/check_architecture.py`: PASS. `scripts/Axioms.lean`: my block "FS-131 wave 5
(job FS131-I5b)", 14 records (`lemma1` and `exists_holed_valid_fragment` were already in K5b's block).

**Re-pricing** (brief item 2). Both leaves proved were the plan's **M**: `lemma1` about 330 lines with children, six iterations; the holed fragment
about 270 lines, seven iterations — at the plan's price. No **H** leaf was reached. Read for pricing, the remaining leaves fall into four shared
infrastructures, none built: (1) **the brick map's point classification** (every sector at every point is one open brick's intersection with the
ball; bricks sharing a closure point differ in colour, offsets `(±1, 0), (−1, 1), (0, 1), (0, −1), (1, −1)`; at most three bricks per point) — it
carries both `sevenBrickMap_isTerminalMap` (with "no horn": a horn's curved edge would lie in a union of segments) and `not_row134BaseUA_seven`
(with the bricks as tiles, whose closures' complements are connected); one child for two leaves, est. 400–600 lines; (2) **sector-chart geometry at
a point** (adjacent sectors, the edge between them and its tangent) — `bv_nd` (BASE-V § 1b.2 steps 2–4), then `bv_nd1` already wired, and
`hex_regular` (its `coneAt_of_cubic`); (3) **the stuck structure** (`stuck_structure_ua`), on which `cv_l0`, `cv_hd*`, `cv_class`, `c_ends`,
`c_double`, `n3_end_chain`, `y3_end_needs` all read; (4) **the limit constructions** (`exists_red`, `exists_terminal`). `disc1_local`: TS-T's
square argument reads only the square of side `1 + ε` about the point, but `AeProperRegions` asks density and local finiteness on the whole plane;
cutting a fragment's regions at a disc can split a tile into pieces whose count needs the arcs' finiteness against the circle — a child, not a
restatement.

## Stage 8 — SAVED

---

*Continued by FS131-I5c, wave 5's third implementer (de Bruijn, the implementer, on Opus), on branch `fs131-w5` in the same worktree. Brief:
`data/fs131/briefs/FS131-I5c-wave5.md` (main tree). Started 2026-10-04. Stages 1–8 above are FS131-I5's and FS131-I5b's; mine start at 9.*

## Stage 9 — SAVED: FS131-I5c's readback

### 9.1 The brief's quotations against their sources (standing rule 3)

| quotation (opening words) | source | result |
|---|---|---|
| Kooshi, "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors — read before pricing anything | verbatim (the paragraph continues with the FLT remark) |
| "**Re-pricing** (brief item 2). Both leaves proved were the plan's **M**: `lemma1` about 330 lines with children, six iterations; the holed fragment" | this record, Stage 8, paragraph "Re-pricing" | verbatim |
| "239. **Ruling: the planar core goes to the planar-infrastructure job** — `cvb_thom_reduced`, `retArcs_nested`, `exists_endpoint`, `exists_eleventh`," | `plans/FS131-close-inventory.md` item 239 (main tree, l. 1717) | verbatim |
| "247. **Rulings on I5b's held items and the slot.** (a) `IsHoleOf` / `cvb_hole_disconnected`: as item 242 (the planar job's first question). (b)" | the inventory, item 247 (l. 1770) | verbatim |
| "272. **Wave 2's slot → wave 5's third implementer, FS131-I5c, on `fs131-w5`; it merges `fs131-w4` once that branch holds the `Contact` lane.** Choice: I5c works" | the inventory, item 272 (l. 1993) | verbatim |
| "252. **Ruling: the sides clause becomes form (b), in `stuck_structure` and in `stuck_structure_ua`.** Choice: (b), the point form outside the parabola. Alternative" | the inventory, item 252 (l. 1807) | verbatim |
| "258. **Ruling on item 257: `pair_i` gains `(h3 : dist u₁ u₂ < 3)`.** Choice: add the hypothesis `dist u₁ u₂ < 3`, which excludes exactly I4k's isolated configuration" | the inventory, item 258 (l. 1845) | verbatim |
| "**It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the" | `plans/FS131-w5-kernel-plan.md` § 10.2, paragraph 1 | verbatim |

The seven skipped leaves, read in items 239, 242, 247 (b): `cvb_thom_reduced`, `retArcs_nested`, `exists_endpoint`, `exists_eleventh`, `exists_unenclosed_or_bad`
(item 239), `cvb_hole_disconnected` (item 242), `cvb_pinch_connected` (item 247 (b)) — the brief's list, matched. Items 251, 252 (form (b): `(‖z − v‖²/2 <
frameY v α z → col z = g) ∧ (frameY v α z < −‖z − v‖²/2 → col z = h)`; `stuck_structure_ua` keeps its flank conjuncts), 257–258, 266–269 read in full. No
mismatch found.

### 9.2 The as-given build (`0db34854`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1751 modules already up to
date, nothing built, 9 modules with warnings**, exit 0 (`build/gate/build/20261004T230142Z-3239563.log`; driver log `data/fs131/i5c/build-stage9-asgiven.log`).
Every warning is `declaration uses 'sorry'`, 89: wave 5's `Terminal` 12, `Dense` 3, `HexRing` 7, `MapGraph` 3, `BaseWalk` 15, `BaseDense` 4 (**44**, the brief's
count; less the planar seven, **37** mine), and wave 4's `BaseSteps` 16, `Contact` 10, `UnitArc` 19 (stale copies; wave 4's branch has proved most of them).

### 9.3 The merge condition

`git merge-base --is-ancestor f975677b origin/fs131-w4`: exit 0 at the readback (`origin/fs131-w4` at `54852de9`, FS131-I4l's stage 34, the `Contact` lane merged).
So the merge is the next stage.

## Stage 9 — SAVED

## Stage 10 — SAVED: the merge of `fs131-w4`, and ruling 252 applied to `stuck_structure_ua`

**The merge**: `origin/fs131-w4` at `111830c8` (FS131-I4l's stage 35: the `Contact` lane merged at `f975677b` — `stuck_structure` in form (b),
`stuck_structure_flanks` — and `pair_i` proved with ruling 258's `h3`) merged into `fs131-w5` as `45991831`, the one commit of this job made without paths
(its message says so). **One conflict**, in `ARCHITECTURE.md` (the `BaseSteps` row: `fs131-w4` added the `UnitArc` import), resolved by keeping both sides —
`fs131-w4`'s `BaseSteps` row and `fs131-w5`'s wave-5 rows; `scripts/Axioms.lean` merged clean; no Lean file conflicted. `tools/check_architecture.py`: PASS.

**Checks.** `tools/fs131_qa1_dupes.py`: exit 0, the same 6 names as stage 2, all waves 1–4 (`data/fs131/i5c/qa1-dupes-merge.txt`); `tools/fs131_i5_dupes.py`:
131 wave-5 names new since the fork, 0 collisions (`data/fs131/i5c/i5-dupes-merge.txt`). The statement comparison (`tools/fs131_i4_stmts.py`) of every Lean file
either side changed, against both parents (`data/fs131/i5c/merge-stmts.txt`): against `fs131-w4` none changed; against `fs131-w5` only wave 4's ruled changes —
`pair_i` gains `(h3 : dist u₁ u₂ < 3)` (item 258), `pair_ii`'s binders `_h₂`, `_hc₂`, `_hy` and `pair_P'`'s `_h` (items 244 (a), 258), `stuck_structure`'s
sides clause in form (b) (item 252) — read token by token.

**The build** of the merged tree (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 445 of 445 batches, 19 modules rebuilt, 9 with warnings, every warning
`declaration uses 'sorry'`**, exit 0 (`build/gate/build/20261004T230340Z-3259096.log`; driver log `data/fs131/i5c/build-stage10-merge.log`). Sorry declarations:
wave 5 **44** (unchanged), wave 4 9 (`Contact` 3, the moves; `UnitArc` 5; `BaseSteps` 1).

**Ruling 252 applied** (`Plane/ValidMap/Terminal`): `stuck_structure_ua`'s sides clause is now form (b) — `(‖z - v‖ ^ 2 / 2 < frameY v α z → F.col z = g) ∧
(frameY v α z < -(‖z - v‖ ^ 2 / 2) → F.col z = h)`, textually wave 4's clause in `stuck_structure_flanks` — and its flank conjuncts are kept; the docstring says
why (both horns of curvatures in `[−1, 1]` lie in `|frameY| ≤ ‖z − v‖²/2`). No other statement changed. The leaf itself is not proved this job (stage 12).

## Stage 10 — SAVED

## Stage 11 — SAVED: the brick infrastructure; `sevenBrickMap_isTerminalMap` and `not_row134BaseUA_seven` proved

**A new module, `Plane/ValidMap/BrickMap`** (imports `Chain`, `Contact`, and Mathlib's `Analysis.Real.Cardinality`; imported by `Terminal`), so a second
implementer can work beside the rest of wave 5. The point classification of `sevenBrickMap`, read without a sector chart:
- **cells**: `brickCell c r` (an open rectangle, `Ioo ×ℂ Ioo`), open, convex, pairwise disjoint; the interior points are exactly the cells
  (`sevenBrick_mem_interiorPts`, by the row and column floors and wave 4's `mem_sevenBrickArcs_of_bottom/_left`, `not_mem_sevenBrickArcs`); the tiles are
  the cells (`sevenBrick_isTile_iff`, through `Sectors`' `connectedComponentIn_eq_of_iUnion`);
- **colour** `(c + 3 r) mod 7` (`sevenBrick_col_val`); two cells whose closures share a point and whose colours agree are one cell
  (`brickCell_eq_of_closure`: rows differ by at most `1`, `2c + r` by at most `2`, and `c + 3r` then moves by `±1, ±2, ±3`);
- **at most three cells at a point** (`encard_brickCellsAt_le`): `(2c + r) mod 3` is injective on them (`2c + r` separates them — it has the parity of
  `r` — and spans at most three consecutive values);
- **sectors**: at any radius `ρ > 0` the sectors at `v` are the cells whose closure holds `v`, cut by the ball (`sevenBrick_isSector_iff`); so no colour
  has two sectors (`sevenBrick_sectorsOf_subsingleton`), no repeated colour, no MERGE; at most three sectors, hence (`exists_hasDegree_of_chart`) at
  most three colours (`sevenBrick_ncard_coloursAt_le`);
- **no curved boundary**: the points off the cells lie on the grid `im ∈ (3/5)ℤ`, `re ∈ (2/5)ℤ` (`sevenBrick_grid_of_not_mem`); a circle meets the grid at
  countably many angles (`countable_circle_grid`, by `Real.sin_eq_sin_iff`, `Real.cos_eq_cos_iff`); a branch of curvature `κ ≠ 0` lies on a circle,
  read by the angle `β + 2 arcsin(κ s/2)` (`branchPt_re_im`, by the product-to-sum identities), injective in `s` — so no curved branch lies off the interior
  points (`sevenBrick_branch_false`), no horn exists (`sevenBrick_not_isHorn`: one bounding arc is curved, and it is off the interior points by wave 4's
  `not_mem_interiorPts_of_mem_closure_sector`), and no unit arc lies in `Γ` (`sevenBrick_not_isRingArc`), since an interval of reals is uncountable;
- **no enclosure**: the complement of a closed rectangle is preconnected (four half-planes, consecutive ones meeting) and unbounded
  (`sevenBrick_not_isBounded_component`), so `UnenclosedC` holds at every point (`sevenBrick_unenclosedC`); `BaseHyp` and `NoInertNear` hold at every point.

**The two leaves** (statements unchanged; read back against plan §§ 3.2, 5.2, 10.3: same statements): `sevenBrickMap_isTerminalMap` — valid, plane, no MERGE
(no colour has two sectors), no MERGE-RAY or SHAVE (no horn), `QROnly` vacuously (no ring arc); `not_row134BaseUA_seven` — the brick corner `0`
(`sevenBrick_corner_isCubicTrichromatic`, wave 4) with `sevenBrick_baseHyp 0`, `sevenBrick_noInertNear 0`, `sevenBrick_unenclosedC 0`. Every clause of
both is exercised on the real object (no clause is vacuous on a degenerate model: the brick map has vertices of three colours and degree three).

**Spec examples** (`BrickMap`): `brickCell 0 0` holds its centre, not its corner `0`, whose closure it holds; `brickCellsAt 0` holds `(0, 0)` and `(0, −1)` and
not `(1, 0)`.

**Bookkeeping**: `Proofs.lean` imports `BrickMap`; `ARCHITECTURE.md` gains its row and `Terminal`'s Imports cell gains it (`tools/check_architecture.py`:
PASS); `scripts/Axioms.lean` gains my block "FS-131 wave 5 (job FS131-I5c)", the module's 41 theorems.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 446 of 446 batches, 6 modules rebuilt, 9 with warnings, every warning `declaration uses 'sorry'`**,
exit 0 (`build/gate/build/20261004T232548Z-3420195.log`; driver log `data/fs131/i5c/build-stage11-brick.log`). Wave 5's sorry declarations: **42**
(`Terminal` 11, `Dense` 2, `HexRing` 7, `MapGraph` 3, `BaseWalk` 15, `BaseDense` 4), against 44.

**Re-pricing** (brief item 3, from the first two leaves): both were I5b's infrastructure (1), the brick map's point classification, priced at 400–600
lines; it came to about 540 lines (the module) and two short wirings, in about a dozen iterations — at the price. The trick that kept it short: reading
sectors and tiles through cells cut by balls (`connectedComponentIn_eq_of_iUnion`), never through a sector chart, and replacing every "the edges are
straight" argument by one countability fact.

## Stage 11 — SAVED

## Stage 12 — SAVED: three of the base's distance leaves proved (`vin_antipodal`, `eleventh_antipodal`, `retArc_partner`)

All three in `Plane/ValidMap/BaseWalk`, statements unchanged (read back against KB's plan § 3.2 and § 4.1's table: same statements), children placed
between `endpoint_dist_ge` and `vin_antipodal` and before `retArc_partner` — away from the fenced planar-core declarations (inventory item 274).

- **`vin_antipodal`** (FS110-CD Theorem D2 (i)). Lemma H's distance step as a child, `dist_le_one_of_mem_region`: a point `s` of the class of `i`
  within `1` of a point of an `i`-tile `T` is within `1` of all of `cl T` (the distances from `s` over the connected `T` miss `1`, by validity). Pick
  `s ≠ u` in the class of `i` near `u` (`exists_mem_region_ne`), close enough to reach both tiles; then `s ∈ B̄(p, 1) ∩ B̄(p′, 1) = {u}` for antipodal
  `p, p′` (`eq_of_dist_le_one_antipodal`, over the real lemma `antipodal_aux`: `b = −a`, then the parallelogram law) — against `s ≠ u`. Simpler than
  § 4.1's route: no tile of colour `i` at `u` is needed, only points of its class.
- **`eleventh_antipodal`** (Theorem D2 (ii)). `u`'s colours are the two it shares with `q` and the V-in colour `i` (disjointness puts `i` off `q`; a
  count on `ncard`); each shared colour has a tile at `q` (`exists_tileOf_of_mem_coloursAt`, through the sector chart) inside `B(u, 1)` (`hqT`). Near `u`
  every interior point carries a colour of `u` (wave 4's `eventually_col_mem_coloursAt`), so `dist_le_one_of_mem_region` puts the classes of the shared
  colours in `B̄(q, 1)` and that of `i` in `B̄(p, 1)`, near `u`; the cusp point `u + (ε/2) i (q − u)` is farther than `1` from both
  (`exists_near_far_antipodal`), and an interior point near it (`dense_interiorPts`) has no admissible colour.
- **`retArc_partner`** (Lemma R step 3). `r(s)` and `r(t)` lie on opposite sides of `ω(r(x ± 60°))` (`dist_ringPt_ringPt_cmp_one`); both lie in the
  closures of `IsRetArc`'s `a`-tile and `c`-tile, so each tile holds a point at distance exactly `1` from `r(y)` (`IsTile.exists_dist_eq_one`), and the
  (P) sweep (`not_mem_coloursAt_of_tile_dist`: a point of the class near `r(y)`, translated, would sit in the tile at distance `1`) keeps both colours
  off `r(y)`. The theorem's `a`, `c` are `IsRetArc`'s by `germPseudo_unique`. The joining continuum `K` enters only through its two ends' membership in
  the closures — the route reads less than CD's sentence.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 446 of 446 batches, 3 modules rebuilt, 9 with warnings, every warning `declaration uses 'sorry'`**,
exit 0 (`build/gate/build/20261004T234350Z-3556904.log`; driver log `data/fs131/i5c/build-stage12.log`). Wave 5's sorry declarations: **39** (`Terminal` 11,
`Dense` 2, `HexRing` 7, `MapGraph` 3, `BaseWalk` 12, `BaseDense` 4), against 42. `scripts/Axioms.lean`: the eleven children added to my block.

## Stage 12 — SAVED

## Stage 13 — SAVED: two wirings in the base, and `stuck_structure_ua` reduced to its flank step

- **`retArcs_finite`** (`BaseWalk`), proved **over `pseudo_finite`**: a returning arc's ends are change points of the pseudo-colouring (two germ
  pseudo-colours `a ≠ c` put both at the point, neither at `u`: `pseudo_ncard_ne_one_of_change`), so `s` lies in `pseudo_finite`'s finite set at `p = u`
  and `t` in it or in its translate by `2π` (`germ_sub_two_pi`, as `t < s + 60° < 2π + 60°`). Wired: kernel when `pseudo_finite` lands.
- **`hex_base`** (`BaseWalk`), proved **over `rot_noThird` and `p17_ua`** (so over `bv_hex`): a rotating hexagon of a circle colouring whose one-sided
  values are germ pseudo-colours is a `HexRing` of the map — each of its six points has pseudo-colour exactly its two germs' colours by `rot_noThird`
  (the germ colours `g (b j) ≠ g (b (j + 1))`, `b` injective and `j ≠ j + 1` in `ℤ/3`) — refuted by `p17_ua`. Wired. KB's note (§ 4.1's table: the assembly
  calls it with the unreduced colouring) is unaffected: the statement reads only the hypotheses `hL`, `hR`.
- **`stuck_structure_ua`** (`Terminal`), proved **over a new child `stuck_flanks_ua`**, with its horn half proved: `woodallCone_isHorn_ua` and
  `stuck_horns_ua` are wave 4's `woodallCone_isHorn` and `stuck_horns` with `woodallCone` in place of `woodallCone_strict` — Condition 5 entered wave 4's
  horn analysis only through the strict bounds, so with unit arcs the horns, their uniqueness per ray, the two `c`-sectors and the out-type contacts at
  both poles hold with curvatures in `[−1, 1]`, verbatim. **What is left is `stuck_flanks_ua`**: from the horns, the two flank colours `g ≠ h` (the
  four flanks are two), the colours `{c, g, h}`, the degree `4`, and ruling 252's sides clause. Wave 4's route for it (`stuck_structure_flanks`) passes
  through `shaveAvailable_of_not_doublyShadowed` and `flank_ne_of_doublyShadowed`, both under Condition 5, and `outType_S_of_shadow`/`_N_` with strict
  bounds; with a horn arc on `ω(v ± n)` (curvature `±1`) that step needs a unit-arc form — the S–V Prop. 7 flank argument with unit arcs, the one place
  this leaf is hard. `stuck_flanks_ua` is the configuration of `stuck_structure_ua` at the horns' axis, so no content is added or lost (the other axis
  `α + π` is the same configuration with `g ↔ h`, `κ₁κ₂ ↔ κ₃κ₄`). Its inhabitant note: `bowtie` at `0` with the horns `stuck_horns_ua` gives there.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`), with the inhabitant note in: **OK — 446 of 446 batches, 5 modules rebuilt, 9 with warnings, every warning
`declaration uses 'sorry'`**, exit 0 (`build/gate/build/20261005T000636Z-3731746.log`; driver log `data/fs131/i5c/build-stage13b.log`; the build before the
docstring edit, `build-stage13.log`, also OK). Axioms (`data/fs131/i5c/I5cAxioms13.out`): `stuck_horns_ua`, `woodallCone_isHorn_ua`,
`pseudo_ncard_ne_one_of_change`, `germ_sub_two_pi` and every stage-11/12 theorem on the standard three; `retArcs_finite`, `hex_base`, `stuck_structure_ua`
on `sorryAx` through their named children (the control). Wave 5's sorry declarations: **37** (`Terminal` 11, `Dense` 2, `HexRing` 7, `MapGraph` 3,
`BaseWalk` 10, `BaseDense` 4), against 39; the planar job's seven among them, so **30 left in this lane**. `tools/check_architecture.py`: PASS.

**Duplicates after stage 13** (`tools/fs131_i5_dupes.py`, `data/fs131/i5c/i5-dupes-stage13.txt`): exit 1, 602 "collisions", **every one in wave 4's own files**
(`Contact` 302, `BaseSteps` 212, `UnitArc` 81, `Basic` 4, `Sectors` 2, `LocalStructure` 1), none in a wave-5 file. The tool reads "wave 5's own files" as
those changed since the fork `9a8de899`, which after stage 10's merge include wave 4's merged files — so it compares wave 4 with itself (the red control
of stage 2, met by the real merge). A tool defect, not a duplicate: its `FORK` should move to the merge base, or its file set be wave 5's eight modules
(FS131-I5's tool, not edited here).

**What is left in this lane (30), and where it stands** (for wave 5's next implementer):
- **the flank step** `stuck_flanks_ua` — the one hard piece of `stuck_structure_ua` (S–V Prop. 7 with a horn arc on `ω(v ± n)`); then the seven chain leaves
  that read it: `cv_l0` (also needs a constant-sides sub-arc of an `OnRingArc`, plan § 9.1's `exists_isRingArc_of_onRingArc`), `cv_hd_main`, `cv_hd`,
  `cv_class`, `y3_end_needs`, `c_ends` (with `stuckAlong_of_run`), `c_double`, `n3_end_chain`;
- **the limit constructions** `exists_red`, `exists_terminal`; and `cv_exists`, which reads `exists_terminal` and a bi-infinite-run argument (CVB § 1.4
  items 1–7) not yet stated as a lemma;
- **the base**: `pseudo_nonempty` (the (P) sweep of stage 12, `not_mem_coloursAt_of_tile_dist`, shows every tile of a colour of `p` misses `ω(p)`, so
  `P_cl(x) ⊆ P_cl(p)` puts an arc of `ω(p)` through `x` in `Γ`; what remains is its constant-sides sub-arc, then `noBoth`), `pseudo_ncard_le_two` (through
  `cor3_local`, ruling 218 (b)), `pseudo_finite`, `exists_pseudoCircle`, `reduce`, `select` (circle-abstract, Lemma 5/BV-C6/Prop. 18), `l3_base`, and the
  assembly `row134BaseUA`, `exists_preBend`;
- **the ring** `rot_noThird`, `rot_out`, `rot_in`, `hex_regular`, `bv_hex`, `bv_l3`, `bv_nd`; **density** `disc1_local`, `cor3`.

**Drafts for the front page**: none — wave 5 is not at its gate. For the gate's carriers decision (plan § 10.3): `IsTerminalMap`'s inhabitant
`sevenBrickMap_isTerminalMap` is now proved, so the planner's recommendation (`IsTerminalMap` and `QROnly` **IN**) can be taken without an `UNKNOWN`.

## Stage 13 — SAVED

*Continued by FS131-I5d, wave 5's fourth implementer (de Bruijn, the implementer, on Opus), on branch `fs131-w5` in the same worktree. Brief:
`data/fs131/briefs/FS131-I5d-wave5.md` (main tree), with its dated amendment (inventory items 288–289: `n3_end` moves to wave 5). Started 2026-10-04.
Stages 1–13 above are FS131-I5's, I5b's and I5c's; mine start at 14.*

## Stage 14 — SAVED: FS131-I5d's readback

### 14.1 The brief's quotations against their sources (standing rule 3)

| quotation (opening words) | source | result |
|---|---|---|
| Kooshi, "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors — read before pricing anything | verbatim (the paragraph continues with the FLT remark) |
| "**What is left in this lane (30), and where it stands** (for wave 5's next implementer):" | this record, Stage 13 | verbatim |
| "284. **FS131-I5c handed back** (Stage 13 SAVED, harness 525k by the task notice; report `fs131-w5`'s `data/fs131/reports/FS131-I5c.md`; commits `c10cf764`," | `plans/FS131-close-inventory.md` item 284 (main tree, l. 2122) | verbatim |
| "287. **IM3's slot → wave 5's next implementer, FS131-I5d, on `fs131-w5`; IM3's MERGE findings relayed to IMM1 at once.** Choice: as the handoff queued (item 285):" | the inventory, item 287 (l. 2165) | verbatim |
| "274. **Rulings on QA3's held items and the freed slot.** (a) **`InMK`**: restated when its first consumer is planned, not now (no theorem uses it; a definition" | the inventory, item 274 (l. 2013) | verbatim |
| "**It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the" | `plans/FS131-w5-kernel-plan.md` § 10.2, paragraph 1 | verbatim |
| (amendment) "289. **Rulings on I4m's items: `n3_end` moves to wave 5; the next wave-4 job merges the moves branch and proves the bends.** (a) **`n3_end`'s reading** (Stage 38)" | the inventory, item 289 (l. 2187) | verbatim |

Items 258, 268–269, 274 (fence: `IsHoleOf`, `fill`, `IsOuterTile`, `filledGraph`, the three `cvb_*` leaves, `retArcs_nested`, `exists_endpoint`,
`exists_eleventh`, `exists_unenclosed_or_bad`), 284–289 and I5c's Stages 10–13 read in full; FS131-I4m's Stage 38 on `origin/fs131-w4` (the `n3_end` route)
read. No mismatch found. `n3_end`'s statement and docstring on this branch (`BaseSteps` l. 1641–1653) are identical to `origin/fs131-w4`'s (diff of l.
1600–1670: empty).

### 14.2 The as-given build (`728c3502`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit (it waited for the slot): **OK — all
1752 modules already up to date, nothing built, 9 modules with warnings**, exit 0 (`build/gate/build/20261005T003227Z-3931639.log`; driver log
`data/fs131/i5d/build-stage14-asgiven.log`). Every warning is `declaration uses 'sorry'`, 46: wave 5's `Terminal` 11, `Dense` 2, `HexRing` 7, `MapGraph` 3,
`BaseWalk` 10, `BaseDense` 4 (**37**, the brief's count; less the planar seven, **30** mine), and wave 4's stale `Contact` 3, `UnitArc` 5, `BaseSteps` 1.

## Stage 14 — SAVED

## Stage 15 — SAVED: `n3_end` moved to wave 5 (inventory item 289, the brief's amendment)

`n3_end` (FS112-N3-END), statement and docstring verbatim (the 12 lines of `BaseSteps` l. 1643–1654, copied by script), now stands in
`Plane/ValidMap/Terminal` just before `n3_end_chain`; deleted from this branch's `BaseSteps` together with its section header `/-! ## FS112-N3-END -/`
(l. 1641–1655), and its `#print axioms` line deleted from `scripts/Axioms.lean`'s wave-4 block and re-added in a new block "FS-131 wave 5 (job
FS131-I5d)" (placed after I5c's block, before I5b's, away from the PURCHASED banner where wave 4 appends). `ARCHITECTURE.md`: `Terminal`'s row names
`n3_end` (moved from `BaseSteps` by item 289); `BaseSteps`' row and `BaseSteps`' module docstring still name it (wave 4's text, left for the merge, so the
two branches' `BaseSteps` deletions stay identical — **for the coordinator**: whichever lands second may drop those two mentions). `tools/check_architecture.py`:
PASS. No other file referenced `n3_end` (by grep).

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 446 of 446 batches, 7 modules rebuilt, 8 with warnings, every warning `declaration uses 'sorry'`**,
exit 0 (`build/gate/build/20261005T003637Z-3957634.log`; driver log `data/fs131/i5d/build-stage15-move.log`). Sorry declarations (unique): wave 5's `Terminal`
12 (11 + `n3_end`), `Dense` 2, `HexRing` 7, `MapGraph` 3, `BaseWalk` 10, `BaseDense` 4 — **38**, of them **31 this lane's**; wave 4's stale `Contact` 3,
`UnitArc` 5; `BaseSteps` 0.

## Stage 15 — SAVED

## Stage 16 — SAVED: `stuck_flanks_ua` proved (so `stuck_structure_ua` is a kernel theorem), `cv_l0` proved, the shared child; a new module `Plane/ValidMap/FlankUA`

**The route for the flank step, with no Condition 5 and no curvature function** (FS114-CV § 1.4's re-derivation of N4-STUCK (ii), read directly). Wave 4's
route passed through `shaveAvailable_of_not_doublyShadowed` (the shadow as `TanBelow σ_g` / `TanAbove σ_h`, built from sector charts at `S′`/`N` under
Condition 5). The unit-arc form needs much less:
1. **No SHAVE, read directly** (`shadow_of_not_shave`): if the tip of a horn were clear for its upper flank's colour `g` near `v`, SHAVE is available with
   the split arc at the horn's own lower bound (`σ = κ₁`: every tip point is "above σ", so clear for `g` suffices); for `h`, `σ = κ₂`. So each flank colour
   shadows the horn at every scale. This is the only use of the move's precondition.
2. **The sources** (`srcG_of_shadow`, `srcH_of_shadow`): wave 4's `shadow_source_near_poles` (no Condition 5) localizes the shadow at `N` or `S′`. At
   `κ₂ < 1`, wave 4's `horn_shadow_near_S` puts it at `S′`, out-type by `outType_S_of_mem_closure`; at `κ₂ = 1` it is at `N` or `S′`, and at `N` the
   contact is in-type because the flank lies inside `B(N, 1)` (`not_outType_N_of_flankAbove_one`: an out-type tile at `N` would be unit-near the flank,
   hence within `1` of `v`). Mirror for `h`. So `g` is in-type at `N` or out-type at `S′`, `h` in-type at `S′` or out-type at `N`; their allowed cones lie in
   `d·n ≥ 0`, `d·n ≤ 0` (`dot_nonneg_of_srcG`, `dot_nonpos_of_srcH`).
3. **`g ≠ h`** (`flank_ne_of_shadows`): one colour on both flanks is out-type at both poles (as the lower flank by `outType_N_of_mem_closure`, as the upper
   by `outType_S_of_mem_closure`), which `κ₂ = 1` or `κ₁ = −1` forbids; off those bounds wave 4's `horn_not_shadowed_near_N`, `_S` keep the tip out of
   its shadow near both poles.
4. **The turned horn's flanks are the same two** — by directions, replacing wave 4's `false_of_all_outType` step: `−n` lies in some colour's cone, not
   `c`'s (out-type at `S′`) nor `g`'s (`d·n ≥ 0`); were the `−e α` horn's `+n` flank `h`, its own source would put `h`'s cone in `d·n ≥ 0` too. Mirror.
5. **Contacts, one sector each, degree 4**: `e α`, `e (α + π)` and `n` lie in `D_g`, so every contact of `g` is on the normal line — in-type at `N` or
   out-type at `S′` (wave 4's `hiiig` with the in-type case at `N` admitted); then `d·n > 0` is inside `D_g` (`hasSectors_one_of_contacts`), and no MERGE
   leaves one sector. `h` the mirror. Degree `4` by wave 4's `hasDegree_of_three_colours`.
6. **The sides** (ruling 252's form (b)): `c` by `region_far_of_outType`; the flanks by `region_far_N_of_srcH` / `region_far_S_of_srcG` — an out-type
   source by `region_far_of_outType`, an in-type one by `region_near_of_inType` (the class near `v` stays in `B̄(S′, 1)`, which misses `B(N, 1)`).

**Leaves proved** (statements unchanged, read back against plan § 3.2 and I5c's Stage 10: same statements): `stuck_flanks_ua` (`Terminal`); with it
`stuck_structure_ua` reads the standard three. **`cv_l0`** (`Terminal`, FS114-CV-HD's CV-L0): a unit arc of `ω(E)` holds a constant-sided sub-arc (the
child below); `QROnly` makes it (Q) or (R2), so its outer colour is carried at `E`; wave 3's `ringArc_cone_outer` puts that colour's cone at `E` in an
angular interval of width `π − ℓ < π` (`not_mem_angleIcc_add_pi`), while `stuck_structure_ua` gives every colour at `E` both `α` and `α + π` (horns for
`c`, flanks for `g` and `h`); finiteness by wave 3's `finite_ringΓ_off_ringArc`. **The shared child `exists_isRingArc_of_onRingArc`** (plan § 9.1, for
`cv_l0` and `pseudo_nonempty`): stated with the sub-arc inside any ball `B(x, ε)` (both consumers need it near `x`); proved from wave 4's
`exists_isRingArc_of_subset_Γ`.

**The new module** `Plane/ValidMap/FlankUA` (imports `Contact`, `UnitArc`; imported by `Terminal`): 15 theorems (`not_mem_angleIcc_add_pi`,
`shadow_of_not_shave`, `not_outType_N_of_flankAbove_one`, `not_outType_S_of_flankBelow_neg_one`, `srcG_of_shadow`, `srcH_of_shadow`, `dot_nonneg_of_srcG`,
`dot_nonpos_of_srcH`, `region_near_of_inType`, `dist_N_S`, `region_far_S_of_srcG`, `region_far_N_of_srcH`, `flank_ne_of_shadows`,
`exists_isRingArc_of_onRingArc`, `hasSectors_one_of_contacts`), each with an inhabitant note (`bowtie` at `0`, `quadRing`); a spec example for
`angleIcc`. It is the shared infrastructure `n3_end` will read (inventory item 289): a second implementer could work there beside the rest of wave 5.
`Proofs.lean`, `ARCHITECTURE.md` (its row; `Terminal`'s Imports cell), `scripts/Axioms.lean` (block "FS131-I5d": the 15) updated;
`tools/check_architecture.py`: PASS. Name collisions: none (each new name declared once in `Proofs/`, by `rg`).

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 6 modules rebuilt, 8 with warnings, every warning `declaration uses 'sorry'`**,
exit 0 (`build/gate/build/20261005T005549Z-4120781.log`; driver log `data/fs131/i5d/build-stage16.log`). Wave 5's sorry declarations: **36** (`Terminal` 10,
`Dense` 2, `HexRing` 7, `MapGraph` 3, `BaseWalk` 10, `BaseDense` 4), **29 this lane's**. Axioms (`data/fs131/i5d/I5dAxioms16.lean`, output
`I5dAxioms16.out`, read from this build's oleans): every theorem above and `stuck_structure_ua` on `[propext, Classical.choice, Quot.sound]`; the control
`n3_end` reads `sorryAx`.

**Re-pricing** (brief item 2, from the first two hard leaves): `stuck_flanks_ua` was the wave's "one hard piece" of `stuck_structure_ua` (I5c: S–V Prop. 7
with a horn arc on `ω(v ± n)`); it came to about 280 lines of `FlankUA` and 230 of proof, first-time clean in scratch, because the SHAVE precondition read
at `σ = κ₁`, `κ₂` replaces the whole `σ_g`/`σ_h` machinery. `cv_l0`: 30 lines over wave 3's U1 cone. Both well under the plan's H/M.

## Stage 16 — SAVED

## Stage 17 — SAVED: `n3_end_chain`, `pseudo_nonempty`, `pseudo_finite` proved (so `retArcs_finite` is a kernel theorem)

- **`n3_end_chain`** (`Terminal`, item 74's chain clause). Route (NB3-END item 1, N112-END's argument, U1 read through the horn itself): both unit bounds
  of `c`'s horn put radial segments of the horn just outside `ω(N)` and just outside `ω(S′)` (`horn_radial_N`, `horn_radial_S`: explicit frame
  coordinates `(t sin x, 1 − t cos x)`, `(t sin x, t cos x − 1)`), so wave 3's `cos_nonpos_of_radial_outer` confines `c`'s cone at each pole to an angular
  interval shorter than `π` (`not_antipodal_coneAt_N_of_horn`, `_S_`); `c` is carried at both poles (`horn_poles_contact`: `woodallCone`'s contacts at the
  horn's own axis); and at a chain vertex every colour has both directions of one axis in its cone (`chainVertex_antipodal`, over `stuck_structure_ua`).
  So neither `v ± n` is a chain vertex. **Generalization (reported)**: the proof reads only `hst`, `h3`, `hc2` and the two unit bounds of `hH` — `hT`,
  the flank `hg` and the in-type contact `hgN` are unread (bound by `have _ :=`): the chain clause holds at every stuck vertex of a valid plane map whose
  two-sector colour has a horn with bounds `−1` and `1`.
- **`BaseCtx.pseudo_nonempty`** (`BaseWalk`, NB3 step 3, the route I5c named): with `P_cl(x) ⊆ P_cl(p)`, the (P) sweep (`not_mem_coloursAt_of_tile_dist`)
  keeps every interior point off `ω(p)` near `x`, so an arc of `ω(p)` through `x` lies in `Γ`; the shared child gives a constant-sided sub-arc near `x`, both
  of whose side colours are colours of `x`, hence of `p`: a both-kind arc centred at `p`, against `noBoth` and H. (`not_mem_coloursAt_of_tile_dist`, I5c's
  child, moved up within `BaseWalk` to precede its new consumer; statement unchanged.)
- **`BaseCtx.pseudo_finite`** (`BaseWalk`, NB3 step 4): the angles off wave 3's `RegularAt` are finitely many (`finite_not_regular`); at a regular angle
  the point is interior (its one colour, absent at `p` by `not_mem_coloursAt_of_mem_sphere`: `coloursAt_eq_of_mem_interiorPts`) or interior to a
  constant-sided arc, where the colours are the two side colours (`IsRingArc.coloursAt_eq`, through `sphere_near_mem_ringArc`) and exactly one is at
  `p` (`NoInertNear`; `noBoth` with H). With it I5c's wiring `retArcs_finite` reads the standard three.

Children added (statements new; inhabitant notes in their docstrings): in `FlankUA` — `N_add_eq_framePt`, `S_add_eq_framePt`, `framePt_normSq_aux`,
`horn_radial_N`, `horn_radial_S`, `not_antipodal_coneAt_N_of_horn`, `not_antipodal_coneAt_S_of_horn`, `horn_poles_contact`,
`coloursAt_eq_of_mem_interiorPts`, `abs_le_norm_e_sub_one`, `sphere_near_mem_ringArc`, `IsRingArc.coloursAt_eq`; in `Terminal` — `chainVertex_antipodal`.
`scripts/Axioms.lean` (block "FS131-I5d") and `ARCHITECTURE.md` (`FlankUA`'s row) updated; `tools/check_architecture.py`: PASS; names collision-free (`rg`).
Statements of the three leaves read back against plan §§ 3.2, 8.2 and KB's § 3.2: same statements.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 6 modules rebuilt, 8 with warnings, every warning `declaration uses 'sorry'`**,
exit 0 (`build/gate/build/20261005T011148Z-52561.log`; driver log `data/fs131/i5d/build-stage17.log`). Wave 5's sorry declarations: **33** (`Terminal` 9,
`Dense` 2, `HexRing` 7, `MapGraph` 3, `BaseWalk` 8, `BaseDense` 4), **26 this lane's**. Axioms (`data/fs131/i5d/I5dAxioms17.lean` → `I5dAxioms17.out`): the
three leaves, every child, `not_mem_coloursAt_of_tile_dist` and `retArcs_finite` on the standard three; the control `exists_pseudoCircle` reads `sorryAx`.

## Stage 17 — SAVED

## Stage 18 — SAVED: `n3_end` proved over one named child (its first case); the handoff

**`n3_end`** (`Terminal`, moved here at stage 15; statement and docstring verbatim) — proved over the new child **`n3_end_of_not_inType`**, on FS131-I4m's
Stage 38 route (inventory items 288–289: no `hQR`, the split on an in-type `g`-tile at `N`):
- **an in-type upper flank at `N`** (the second disjunct, proved): `κ₂ ≤ 1` (`horn_bounds_of_noMerge`: `woodallCone`'s sectors are horns with bounds in
  `[−1, 1]`, and `hornSet_curv_eq` identifies the given horn's bounds); `κ₂ ≥ 1`, since at `κ₂ < 1` wave 4's `outType_N_of_flankAbove` makes `g` out-type at
  `N`; and for any `c`-horn along `α + π`, `stuck_flanks_ua` (with `horn_poles_contact`) makes `g` its `+n` flank (`IsFlankAbove.unique`), so at a bound
  above `−1` wave 4's `outType_S_of_flankBelow` in the turned frame (whose `S′` is `N`) would make `g` out-type at `N` again.
- **no in-type upper flank at `N`** (the first disjunct): the child `n3_end_of_not_inType`, `sorry` — NB3-END items 2–5 with item 2's premise read as I4m
  read it. It is the leaf's whole open part (I4m priced the leaf at two sessions; the half proved here was the cheap half). What it can start from:
  `srcG_of_shadow` already gives "in-type at `N` or out-type at `S′`", so here `g` is out-type at `S′`; the work is the two `g`-sectors at `S′` (items 2–3),
  the colours `y ≠ z` beside its `+a` horn (item 4, the SHAVE contradiction for `z = y`) and the in-type `y`-tile at `v − 2n` (item 5, `noBoth`).

Children added: `IsFlankAbove.unique`, `horn_bounds_of_noMerge` (`FlankUA`), `n3_end_of_not_inType` (`Terminal`, the `sorry`). `scripts/Axioms.lean` and
`ARCHITECTURE.md` updated; `tools/check_architecture.py`: PASS; names collision-free.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 6 modules rebuilt, 8 with warnings, every warning `declaration uses 'sorry'`**,
exit 0 (`build/gate/build/20261005T013008Z-182604.log`; driver log `data/fs131/i5d/build-stage18.log`). Wave 5's sorry declarations: **33** (`Terminal` 9 —
`n3_end_of_not_inType` in place of `n3_end` —, `Dense` 2, `HexRing` 7, `MapGraph` 3, `BaseWalk` 8, `BaseDense` 4), **26 this lane's**. Axioms
(`data/fs131/i5d/I5dAxioms18.lean` → `I5dAxioms18.out`): `IsFlankAbove.unique`, `horn_bounds_of_noMerge`, `stuck_flanks_ua`, `n3_end_chain` on the standard
three; `n3_end` and its child read `sorryAx` (the control).

**What is left in this lane (26), and where it stands** (for wave 5's next implementer):
- **`Terminal` (9)**: `n3_end_of_not_inType` (above); the CV-HD cluster `cv_hd_main` (H: CVB § 1.6, both branches), `y3_end_needs` (H: YB3 § 3.1's seven
  colours), then `cv_hd`, `cv_class`, `c_double`, `c_ends` (with `stuckAlong_of_run`, plan § 9.1) — `FlankUA`'s sources and `chainVertex_antipodal`,
  `not_antipodal_coneAt_*_of_horn` are the tools they share; the limit constructions `exists_red`, `exists_terminal`.
- **`BaseWalk` (5 of 8)**: `pseudo_ncard_le_two` (needs ruling 218 (b)'s `cor3_local`: `cor3` needs `Covers x 1`, which `B̄(u, 2)` does not give at
  `x ∈ ω(p)`); `exists_pseudoCircle` (the bridge: a construction over `pseudo_finite`, `pair_i`, `pair_ii`, `pseudo_ncard_le_two`); `reduce`, `select`
  (circle-abstract); `l3_base`.
- **`HexRing` (7)**: `rot_noThird` rests on `cor3`, which lives in `Dense`, downstream of `HexRing` — not citable as the modules stand (a finding, record
  report); `rot_out`, `rot_in` read `rot_noThird`; `hex_regular` (sector geometry: the cones of a cubic vertex as contiguous closed intervals, then
  arithmetic); `bv_hex`, `bv_l3`, `bv_nd` (BASE-V; `bv_nd`'s step 4 needs the α|β edge at a point of ≤ 3 colours from its sector chart).
- **`Dense` (2)**: `disc1_local`, `cor3`. **`BaseDense` (3 of 4)**: `row134BaseUA` (the assembly), `exists_preBend` (over wave 4's `bend_toward`),
  `cv_exists` (needs CVB § 1.4's bi-infinite-run argument as a lemma beside `exists_terminal`, I5c's note).

**Drafts for the front page**: none — wave 5 is not at its gate.

## Stage 18 — SAVED

## Stage 19 — SAVED: FS131-I5e's readback

*FS131-I5e, wave 5's fifth implementer (Opus), resuming this record at its first unsaved stage (Stage 18 SAVED, `a804de21`). Brief:
`data/fs131/briefs/FS131-I5e-wave5.md` (main tree).*

### 19.1 The brief's quotations against their sources (standing rule 3)

| quotation (opening words) | source | result |
|---|---|---|
| Kooshi, "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors — read before pricing anything (l. 119) | verbatim |
| "**What is left in this lane (26), and where it stands** (for wave 5's next implementer):" | this record, Stage 18 | verbatim |
| "298. **FS131-I5d handed back** (Stage 18 SAVED, harness ≈ 599k by the task notice; record `fs131-w5`'s `plans/FS131-I5-implementation.md`, Stages 14–18;" | `plans/FS131-close-inventory.md` item 298 (main tree, l. 2318) | verbatim |
| "299. **Rulings on I5d's held items, and its slot.** (a) **`rot_noThird`'s block**: wave 5's next implementer moves `cor3` — statement, docstring and proof (a" | the inventory, item 299 (l. 2337) | verbatim |
| "- **no in-type upper flank at `N`** (the first disjunct): the child `n3_end_of_not_inType`, `sorry` — NB3-END items 2–5 with item 2's premise read as I4m" | this record, Stage 18 (l. 747) | verbatim |
| "288. **FS131-I4m handed back** (Stage 40 SAVED, harness 466k by the task notice; report `fs131-w4`'s `data/fs131/reports/FS131-I4m.md`; commits `70075915`," | the inventory, item 288 (l. 2171) | verbatim |
| "218. **Rulings on KB's and IC1's held items** (four parts each, compressed where the alternative is plain)." | the inventory, item 218 (l. 1562) | verbatim |
| "274. **Rulings on QA3's held items and the freed slot.** (a) **`InMK`**: restated when its first consumer is planned, not now (no theorem uses it; a definition" | the inventory, item 274 (l. 2013) | verbatim |
| "**It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the" | `plans/FS131-w5-kernel-plan.md` § 10.2, paragraph 1 (l. 470) | verbatim |

Items 218, 258, 268–269, 274 (the planar fence: `IsHoleOf`, `fill`, `IsOuterTile`, `filledGraph`, the three `cvb_*` leaves, `retArcs_nested`,
`exists_endpoint`, `exists_eleventh`, `exists_unenclosed_or_bad`), 284, 288–289, 295, 298–299 read in full; I5d's Stages 14–18 read; NB3-END
(`plans/FS112-NB3-verification.md` l. 222–243) read. No mismatch found. The brief's remark that nothing in wave 5 may cite `exists_merge` (item 295): by
`rg`, no wave-5 module cites it.

### 19.2 The as-given build (`a804de21`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit (it waited for the slot): **OK — all
1753 modules already up to date, nothing built, 8 modules with warnings**, exit 0 (`build/gate/build/20261005T014933Z-325834.log`; driver log
`data/fs131/i5e/build-stage19-asgiven.log`). Every warning is `declaration uses 'sorry'`, 41: wave 5's `Terminal` 9, `Dense` 2, `HexRing` 7, `MapGraph` 3,
`BaseWalk` 8, `BaseDense` 4 (**33**, the brief's count; less the planar seven, **26** this lane's), and wave 4's stale `Contact` 3, `UnitArc` 5.

Iteration script: `data/fs131/i5e/iter.sh` (I5d's, re-pointed at its own scratch mirror `/home/kooshi/scratch-w5e`, outside the repository).

## Stage 19 — SAVED

## Stage 20 — SAVED: `cor3` moved upstream of `HexRing` (ruling 299 (a)); `n3_end_of_not_inType` stopped at a GAP in NB3-END item 2 (ruling 299 (b))

### 20.1 The move

Every name `cor3`'s statement uses is upstream of `HexRing`: `IsCubicTrichromatic`, `BothKind` (`Plane/ValidMap/Basic`), `IsLeavingCentre`
(`Plane/ValidMap/BaseSteps`), `Covers`, `Valid`, `coloursAt` (`Plane/ArcMap`). So `cor3` — statement, docstring and proof (a `sorry`) — moved by script into
a new module **`Plane/ValidMap/Cor3`** (imports `BaseSteps`; its own module docstring; the declaration under the same section header
`/-! ## FS112-N3-COR3 -/` it had in `Dense`), and was deleted from `Dense` with that header. `HexRing` and `Dense` import `Cor3` (`Dense` also through
`HexRing`); `Dense`'s module docstring says where `cor3` went; `rot_noThird`'s docstring is unchanged. The full name `HadwigerNelson.Plane.ArcMap.cor3`
is unchanged, so `scripts/Axioms.lean`'s record of it (wave 5's skeleton block) stands. `Proofs.lean`, `ARCHITECTURE.md` (a row for `Cor3`; `Dense`'s
row and Imports cell; `HexRing`'s Imports cell) updated; `tools/check_architecture.py`: PASS.

**The check** (`tools/fs131_i5_cor3_move.py`): extracts the declaration (docstring to the end of the body) from `Dense` at `a804de21` and from `Cor3` in the
tree, and compares byte for byte; checks `Dense` no longer declares `cor3` and that exactly one file under `Proofs/` does. Result: **PASS** — "block: 11
lines, 1257 bytes, identical". `--self-test`: five plants (one byte in the statement, one in the docstring, the body changed, still in the old module,
declared twice), each **fired**, and the unplanted control passed. The docstring plant at first **did not fire**: its pattern ("close complementary
pair") occurs first in `Cor3`'s module docstring, so the plant edited the wrong docstring — an unreachable control, caught by the self-test and
re-aimed at a phrase only the declaration's docstring carries ("FS112-STOP's object"). The check is of the move commit: later stages prove `cor3`
over `cor3_local` (stage 21), after which its body differs by design.

### 20.2 `n3_end_of_not_inType`: GAP at NB3-END item 2, and what the leaf can start from

**The GAP** (messaged to Keryx 2026-10-05, ruled: the leaf stays `sorry` in this job and goes to an Ephodos re-derivation; inventory to be filed by
Keryx). NB3-END item 2 (`plans/FS112-NB3-verification.md` l. 234–237): "`c ∈ P_cl(S′)` (N3-DEG at `v`), its sectors in `α`'s away cone (U1), below:
the two `g`-tiles are **two sectors** of `g` at `S′`." U1 read on `H`'s lower arc of `ω(S′)` — which runs from `v` toward `+a` only — puts `c`'s
cone at `S′` in the **closed** interval `[α+π, α+2π−φ]` (I5d's `not_antipodal_coneAt_S_of_horn`), which contains the direction `α+π` of `−a`. So
the text does not exclude: one `g`-sector at `S′` with cone `[α+π, α+2π]` (the whole closed lower half-plane, shadowing both `H` and `H₋`), and `c`
carried at `S′` only by a `c`-horn along `−a` on its `+n` side (cone `{α+π}`). Then the two sectors are one, and `HasRepeatedColour (v − n)` does not
follow. The case needs `κ₄ < 1` (`H₋`'s bound on the `S′` side): at `κ₄ = 1`, `H₋`'s arc continues the arc of `ω(S′)` past `v` and U1 excludes `−a`.
A repair (one mind, leading order only, sent with the message): `y = S′ + s·e(α+π−θ)` has a unit partner in `H₋` iff `θ/s > τ(κ₄) = −κ₄/(2(1−κ₄))`
(the minimum over `x` of `(s−x)²/2 − κ₄x²/2`); `g`'s witnesses for `H₋` satisfy it, and the `c`-horn lies on their `+n` side, at larger `θ`, so it
meets `H₋` at distance `1` (a `c`-unit pair). The exact form needs the shadow of `H₋` near `S′` to be closed upward in the frame's `Y` at fixed `X`
— the mirror of NB3 item 4's "downward closed" — not derived.

**The limit directions of the shadow witnesses** (worked out here for the deriver and the next implementer; one mind, exact inequalities). Frame at
`v`: `a = e α`, `n = e(α + π/2)`, `S′ = v − n`, `N = v + n`. From `stuck_flanks_ua`: horns `H` (along `a`, bounds `−1, κ₂`) and `H₋` (along `−a`,
bounds `κ₃, κ₄`), `g` = `IsFlankAbove v α κ₂ g` = `IsFlankBelow v (α+π) κ₃ g` (the `+n` side of both). No SHAVE (`shadow_of_not_shave`) gives `g`-shadow
witnesses on both horns at every scale; `hno` excludes an in-type `g`-contact at `N`, so `srcG_of_shadow` / `srcH_of_shadow` (turned) give `g`
out-type at `S′`.
- *Localization at `S′`.* For `H`: at `κ₂ < 1`, `horn_shadow_near_S`; at `κ₂ = 1`, `shadow_source_near_poles` with `N ∉ cl(region g)` (a `g`-contact
  at `N` is not out-type, `not_outType_N_of_flankAbove_one`, and not in-type, `hno`). For `H₋` (turned frame `a' = −a`, `n' = −n`, its `N′ = S′`): at
  `κ₃ > −1`, `horn_shadow_near_N` turned; at `κ₃ = −1`, `shadow_source_near_poles` with `N ∉ cl(region g)` (`not_outType_S_of_flankBelow_neg_one`
  turned, and `hno`). So witnesses `z_k → v` in the horn, `y_k ∈ region g`, `|z_k − y_k| = 1`, `y_k → S′`.
- *For `H`:* write `z_k − v = x a + y n` (`x > 0`; the horn: `x² + 2y + y² > 0` and `y < κ₂(x² + y²)/2`, so `|y| ≤ C x²`) and
  `y_k = S′ + s·e(α + t)`. (1) `y_k`'s sector lies in a `g`-tile at `S′`, out-type, so `|y_k − v| > 1`: `sin t < s/2`. (2) `|z_k − y_k| = 1`:
  `2s(x cos t + (1 + y) sin t) = x² + 2y + y² + s² > s²`, so `x cos t + (1 + y) sin t > s/2`. Hence `sin t ∈ (−x/(1+y), s/2) → 0` and
  `cos t > −y s/(2x) → 0`: **the witnesses tend to `+a` from `S′`**, from the closed lower side (`g`'s cone at `S′` lies in `d·n ≤ 0`). The `g`-sector
  holding infinitely many of them has `α` in its cone and its cone in `[α−π, α]`: its upper germ `nextβ ≡ α` — tangent to `+a` from below.
- *For `H₋`:* the mirror (turned frame; `|y_k − v| > 1` gives `sin t′ > −s/2`; the unit distance with `H₋` below `ω(S′)` in its frame,
  `x² + y′² − 2y′ > 0`, gives `x cos t′ − (1 − y′) sin t′ > s/2`): `sin t′ → 0`, `cos t′ ≥ 0` in the limit — **the witnesses tend to `−a`**; the sector
  holding them has `α + π` in its cone and its cone in `[α+π, α+2π]`: its lower germ `β ≡ α + π`.
- What is then open is exactly the GAP above: that these two sectors differ.

Wave 4's analogue of this step (`sector_shadow_S`, `flank_shadow_g_chart`) assumes Condition 5 and `κ₁ > −1`, neither available here; the leaf has
`κ₁ = −1` by hypothesis.

### 20.3 The build

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 6 modules rebuilt, 9 with warnings, every warning `declaration uses 'sorry'`**, exit 0 (`build/gate/build/20261005T015517Z-347267.log`, "Build completed successfully (5369 jobs)"; driver log `data/fs131/i5e/build-stage20-cor3move.log`). Wave 5's sorry declarations:
**33** (`Terminal` 9, `Dense` 1, `Cor3` 1, `HexRing` 7, `MapGraph` 3, `BaseWalk` 8, `BaseDense` 4), **26 this lane's** — unchanged by the move.

## Stage 20 — SAVED

## Stage 21 — SAVED: `cor3_local` stated (ruling 218 (b)); `cor3`, `pseudo_ncard_le_two` and `rot_noThird` proved over it

- **`cor3_local`** (`Plane/ValidMap/Cor3`, new, `sorry`; ruling 218 (b): "`cor3_local`, reading small discs only"; ruling 299 (c)). Its statement is
  `cor3`'s, with `Covers u 1`, `Covers u′ 1` replaced by `u ∈ F.dom`, `u′ ∈ F.dom` and `∀ q, dist q u = 1 → dist q u′ = 1 → q ∈ F.dom` (the domain is
  open, so each gives a small disc). Why these: N3-COR3's argument (`plans/FS112-NB3-verification.md` l. 120–135) reads the strips at the two
  crossings `w₀, w₀′` (NB3-FAIL; in Lean `fail_leavingCentre` and `fail_colours` use their `Covers u 1` only for `u ∈ F.dom`, by reading their
  proofs), the arcs of `ω(w)` ending at `u`, `u′` (inside the charts at `u`, `u′`), and N112-U1 at `w` (`ringArc_cone_outer`, no covering hypothesis).
  The reading that nothing else is read is mine (one mind) and is what `cor3_local`'s eventual proof must confirm; if it needs a larger disc, the
  statement comes back through Keryx. `cor3` keeps its statement and is now **proved over `cor3_local`** (its covers give all three hypotheses), so
  the row's open part is the one leaf `cor3_local`.
- **`pseudo_ncard_le_two_of_baseHyp`** (`HexRing`, new child, statement new): `|c′| ≤ 2` at a cubic trichromatic `p ∈ B̄(u, 1)` under `Valid`,
  `Covers u 2`, `BaseHyp u` alone. Three pseudo-colours at `x ∈ ω(p)` are all three colours absent at `p`; a fourth colour would be a point of `F(M)`
  in `B̄(u, 2)`, so `x` carries exactly those, is cubic trichromatic (`isCubicTrichromatic_of_three_of_noRep`, H) and complementary to `p` at distance
  `1`; `cor3_local` (with `p, x ∈ B̄(u, 2) ⊆ dom` and the common unit points within `1` of `p`) gives a four-colour common unit point inside `B̄(u, 2)`,
  against H. Placed in `HexRing` because `rot_noThird` needs it and `BaseWalk` is downstream.
- **`BaseCtx.pseudo_ncard_le_two`** (`BaseWalk`, NB3 step 5) — proved: the child at `B.valid`, `B.covers`, `B.hyp` (it reads neither `NoInertNear` nor
  `UnenclosedC`).
- **`rot_noThird`** (`HexRing`, N2-ROT's "no `r`-tile at `x`") — proved: the germs' pseudo-colours `p`, `q` are pseudo-colours of `x = r(ψ)`
  (`GermPseudo.mem_pseudoColours`, new child: colours are closed), and the child bounds them by two. Its docstring ("the proof rests on FS112-N3-COR3")
  stands. `rot_out` and `rot_in` read `rot_noThird` and are now unblocked; not reached in this job.
- **`GermPseudo.mem_pseudoColours`** (`HexRing`, new child): a germ's pseudo-colour is a pseudo-colour of its point (the local `hmem` of I5c's
  `pseudo_ncard_ne_one_of_change`, stated once; that proof is left as it is).

Statements of the leaves read back against plan §§ 3.2, 8.2 and KB's § 3.2: unchanged (`git diff` touches only their bodies). `scripts/Axioms.lean`: a
block "FS131-I5e" (after I5d's block, above the PURCHASED banner) with the three new records; `ARCHITECTURE.md`: `Cor3`'s and `HexRing`'s rows. New names
collision-free (`rg` over `Proofs/`: each declared once).

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 6 modules rebuilt, 9 with warnings, every warning `declaration uses 'sorry'`**, exit 0 (`build/gate/build/20261005T020618Z-432319.log`, "Build completed successfully (5369 jobs)"; driver log `data/fs131/i5e/build-stage21.log`). Wave 5's sorry declarations:
**31** (`Terminal` 9, `Dense` 1, `Cor3` 1, `HexRing` 6, `MapGraph` 3, `BaseWalk` 7, `BaseDense` 4), **24 this lane's** (from 26: `pseudo_ncard_le_two` and `rot_noThird` closed; `cor3` closed over the new `cor3_local`). Axioms (`data/fs131/i5e/I5eAxioms21.lean` → `I5eAxioms21.out`, read from this build's oleans): `GermPseudo.mem_pseudoColours` on `[propext, Classical.choice, Quot.sound]`; `pseudo_ncard_le_two_of_baseHyp`, `rot_noThird`, `BaseCtx.pseudo_ncard_le_two`, `cor3` on the standard three and `sorryAx` (wired over `cor3_local`, which reads `sorryAx` itself — the control the reader must see fail); `linkage_dot_ne_zero` (a kernel theorem, the clean control) on the standard three.

**What is left in this lane (24), and where it stands** (for wave 5's next implementers):
- **`Terminal` (9)**: `n3_end_of_not_inType` — **held for an Ephodos re-derivation** (stage 20's GAP at NB3-END item 2; the limit directions are in
  § 20.2); `cv_class` — its second disjunct ("`g` twice at `E − n`, `h` twice at `E + n`") rests on CVB § 1.4 item 5's separation, whose exclusion of a
  `c`-sector in the `±a` stack is the same one-line step (told to Keryx; best proved after the re-derivation); `cv_hd_main` (H: CVB § 1.6),
  `y3_end_needs` (H: YB3 § 3.1), `cv_hd`, `c_double`, `c_ends` (with `stuckAlong_of_run`); the limit constructions `exists_red`, `exists_terminal`.
- **`HexRing` (6)**: `rot_out`, `rot_in` (unblocked: N2-ROT's table by N-E2 at `σ^{±1}x`, with `rot_noThird` for "no `r`-tile"), `hex_regular`,
  `bv_hex`, `bv_l3`, `bv_nd`.
- **`Cor3` (1)**: `cor3_local` (H: N3-COR3; the strips fail at both crossings, the side cones force four colours; children `common_unit_points`).
- **`BaseWalk` (4 of 7 left)**: `exists_pseudoCircle` (now over `pseudo_ncard_le_two`, proved), `reduce`, `select` (circle-abstract), `l3_base`
  (rewrite `linkage_dot_ne_zero`'s docstring as `plans/FS131-QA3-audit.md` § 2.4 d drafts it, item 274 (b)). The other three are the planar job's.
- **`Dense` (1)**: `disc1_local`. **`BaseDense` (3 of 4)**: `row134BaseUA`, `exists_preBend`, `cv_exists`.

**A split for a second wave-5 implementer** (ruling 299 (e)), by file, so the two trees merge in disjoint hunks: one implementer on **`Terminal`**
(the CV-HD cluster, `c_ends`, `c_double`, the limit constructions — after the re-derivation for `n3_end_of_not_inType` and `cv_class`); the other on
**`HexRing`, `Cor3`, `BaseWalk`'s four** (the base's ring lemmas: `rot_out`, `rot_in`, `hex_regular`, `bv_*`, `cor3_local`, `reduce`, `select`,
`exists_pseudoCircle`, `l3_base`). `Terminal` imports none of `HexRing`, `Cor3`, `BaseWalk`; `BaseWalk` reaches `Terminal` through `Dense`, so an edit to `Terminal` rebuilds it, but the files are disjoint. `Dense`'s `disc1_local` and `BaseDense`'s
three go with the second (they read `HexRing` and the walk). The shared files are `Proofs.lean`, `ARCHITECTURE.md` and `scripts/Axioms.lean` (one block
per job).

**Drafts for the front page**: none — wave 5 is not at its gate.

## Stage 21 — SAVED

## Stage 22 — SAVED: FS131-I5f's readback

*FS131-I5f, wave 5's sixth implementer (Opus), resuming this record at its first unsaved stage (Stage 21 SAVED, `6e38803d`). Brief:
`data/fs131/briefs/FS131-I5f-wave5.md` (main tree). My set (ruling 311, I5e's split): `HexRing`'s six (`rot_out`, `rot_in`, `hex_regular`, `bv_hex`,
`bv_l3`, `bv_nd`), `Cor3`'s `cor3_local`, `BaseWalk`'s four (`exists_pseudoCircle`, `CircleColouring.reduce`, `CircleColouring.select`, `l3_base`),
`Dense`'s `disc1_local`, `BaseDense`'s three (`row134BaseUA`, `exists_preBend`, `cv_exists`) — 15. Never `Terminal`, never the planar job's seven.

### 22.1 The brief's quotations against their sources (standing rule 3)

Checked by script (each `> ` line of the brief searched verbatim in the file its `— source:` line names; main tree for `CLAUDE.md` and the inventory,
the worktree for the plan and this record):

| quotation (opening words) | source | result |
|---|---|---|
| Kooshi, "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | verbatim |
| "**What is left in this lane (24), and where it stands** (for wave 5's next implementers):" | this record, Stage 21 | verbatim |
| "**A split for a second wave-5 implementer** (ruling 299 (e)), by file, so the two trees merge in disjoint hunks: one implementer on **`Terminal`**" | this record, Stage 21 | verbatim |
| "310. **FS131-I5e handed back** (Stage 21 SAVED, harness ≈ 401k by the task notice; record" | `plans/FS131-close-inventory.md` item 310 (l. 2472) | verbatim |
| "311. **Ruling: I5e's slot → FS131-I5f, wave 5's non-`Terminal` half; E5 takes the next slot, whatever wave 4's state.** Choice: I5f on `fs131-w5` takes I5e's" | the inventory, item 311 (l. 2486) | verbatim |
| "218. **Rulings on KB's and IC1's held items** (four parts each, compressed where the alternative is plain)." | the inventory, item 218 (l. 1562) | verbatim |
| "274. **Rulings on QA3's held items and the freed slot.** (a) **`InMK`**: restated when its first consumer is planned, not now (no theorem uses it; a definition" | the inventory, item 274 (l. 2013) | verbatim |
| "**It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the" | `plans/FS131-w5-kernel-plan.md` § 10.2 (l. 470) | verbatim |
| "295. **Ruling: MERGE leaves wave 4; the freed slot goes to FS131-IX1 as ruled.** Choice: (a) wave 4 lands without `exists_merge` — at wave 4's merge-and-gate," | the inventory, item 295 (l. 2274) | verbatim |

Items 218, 258, 274, 284, 295, 299, 310, 311 read in full; I5e's Stages 19–21 read. **One count differs, a finding about the ruling, not the brief**:
item 311 says the lane "would otherwise stand idle with 16 leaves open that need no re-derivation"; the brief says 15, and the build's warnings give 15
(below). Not material.

### 22.2 The as-given build (`6e38803d`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit (it waited for the slot):
**OK — all 1754 modules already up to date, nothing built, 9 modules with warnings**, exit 0 (`build/gate/build/20261005T022500Z-568829.log`; driver log
`data/fs131/i5f/build-stage22-asgiven.log`). Every warning is `declaration uses 'sorry'`, 39: wave 5's `Terminal` 9, `Dense` 1, `Cor3` 1, `HexRing` 6,
`MapGraph` 3, `BaseWalk` 7, `BaseDense` 4 (**31**, the brief's count; less the planar job's seven and `Terminal`'s nine, **15** mine), and wave 4's stale
`Contact` 3, `UnitArc` 5.

Iteration script: `data/fs131/i5f/iter.sh` (I5e's, re-pointed at its own scratch mirror `/home/kooshi/scratch-w5f`, outside the repository).

## Stage 22 — SAVED

## Stage 23 — SAVED: `cor3_local` proved (its hypotheses suffice, ruling 218 (b) confirmed); `row134BaseUA` wired (the walk assembled over its leaves, no statement defect)

### 23.1 `cor3_local` — a kernel theorem

**`cor3_local` is proved as stated** (`Plane/ValidMap/Cor3`; axioms the standard three). I5e's reading (stage 21: the argument reads `u`, `u′` and the
common unit points in the domain, nothing more) is confirmed: the proof uses `u ∈ F.dom`, `u′ ∈ F.dom` (the charts at `u`, `u′`) and `w ∈ F.dom` at each
crossing `w` (interior points near `w`), and no covering hypothesis. With it `cor3`, `pseudo_ncard_le_two_of_baseHyp`, `BaseCtx.pseudo_ncard_le_two` and
`rot_noThird` are kernel theorems (they were wired over it).

**The route** (one mind; a re-reading of N3-COR3 through the colours' cones at the crossing, shorter than NB3's strip-by-strip argument, and with no
strip and no `fail_*` lemma): at a crossing `w` of `ω(u)` and `ω(u′)`,
1. *(`exists_tangent_colour`)* along each half-tangent `e β = (w − u)(±i)` of `ω(u)` at `w`, colours approach `w` from inside and from outside `ω(u)`
   (pigeonhole over the colours on interior points along the tangent, `exists_mem_coneAt_region_inter`, on explicit points `exists_near_tangent`). If
   both were colours of `u`, the two sectors of `u` they fill lie inside and outside `ω(w)` (`closure_sector_subset_of_side`), so they share a germ that
   runs along `ω(w)` — an arc of `Γ` on `ω(w)` ending at `u` with those two side colours (`exists_ringArc_of_sides`) — and `β` would lie in that arc's
   facing and away cones, which are disjoint (`IsRingArc.disjoint_coneAt`, from U1). So a colour of `u′` approaches `w` along each half-tangent.
2. *(`cor3_half`)* the two half-tangents of `ω(u)` lie strictly on opposite sides of `ω(u′)` (transversality, `Im((w − u′) conj (w − u)) ≠ 0`), so one
   colour of `u′` approaches `w` from inside `ω(u′)` and one from outside (`mem_coneAt_inter_ball_of_re_neg` and its outward form, first order). By the
   same chart lemma at `u′` they are the inner and outer colours of one arc of `ω(w)` ending at `u′`, distinct (U1 again) and carried at `w`: a leaving
   centre of `u′` and the centre of a both-kind arc.
3. *(`cor3_at`)* the roles exchanged give two colours of `u` at `w`; the four are distinct (the colours of `u` and `u′` are disjoint): four colours.
4. *(`exists_crossings`)* the two crossings exist, are distinct and transversal for `0 < |u − u′| < 2` (`u ≠ u′` since the colours are disjoint and
   three each).

NB3's "one failure is not enough" (the side-cone argument with two leaving arcs sharing a colour) is replaced by step 1, which needs no case on the
number of leaving arcs: the shared germ between the inside and the outside sector *is* the arc with exactly those two colours. No strip is used, so
`fail_leavingCentre` / `fail_colours` (which take `Covers u 1`) are not needed.

Children (all in `Cor3`, axioms the standard three): `e_arg_of_norm_eq_one`, `IsRingArc.disjoint_coneAt`, `exists_ringArc_of_sides`,
`exists_mem_coneAt_region_inter`, `mem_coneAt_inter_ball_of_re_neg`, `mem_coneAt_diff_closedBall_of_re_pos`, `exists_near_tangent`,
`exists_tangent_colour`, `cor3_half`, `cor3_at`, `exists_crossings`. **Generalizations** (every `k`, reported): `exists_ringArc_of_sides`,
`exists_tangent_colour`, `cor3_half` and `cor3_at` hold at every `k` (six colours enter `cor3_local` only as "every colour is carried at `u` or at
`u′`").

### 23.2 `row134BaseUA` — wired: the walk composes from its leaves as stated

`row134BaseUA` is now `BaseCtx.false` applied to the bundled hypotheses, and `BaseCtx.false` assembles the walk (KB's plan § 4 leaf F1, the order in
`row134BaseUA`'s docstring) over the leaves **as stated**: `exists_pseudoCircle`, `reduce`, `retArcs_finite`, `retArcs_nested`, `select`, `rot_noThird`,
`p17_ua`, `exists_endpoint`, `exists_eleventh`, `eleventh_type`, `endpoint_dist_ge`, `pair_P'`, `vin_antipodal`, `l3_base`, `cor3_base`,
`eleventh_antipodal`, `cubic_of_three`, `retArc_partner`. **No statement defect surfaced**: every leaf's hypotheses were dischargeable from the others'
conclusions. Two observations, neither a defect:
- `hex_base` cannot be cited on the reduced colouring `C′` (its `hL`, `hR` ask for every angle, and `C′` differs from the map inside the removed
  returning arcs); the assembly repeats its four-line proof at the hexagon's six points, which are change points of `C′` and so keep the map's germs.
- `exists_endpoint`'s second disjunct of `hc` (`GermPseudo u θ .cw c ∧ GermPseudo u θ .ccw a`) is unusable beside `ha : GermPseudo u θ .cw a`
  (`germPseudo_unique` and `a ≠ c`); the assembly calls it with `a`, `c` exchanged instead. Harmless.

Glue (`BaseDense`, before `row134BaseUA`): `CircleColouring.mem_S_of_ne`, `CircleColouring.leftVal_of_not_mem`, the `2π`-periodicity of germs, ring
points, ring arcs and returning arcs (`IsRetArc.exists_Ico`), `exists_eq_of_absent`, `BaseCtx.removable` (a returning arc is `Removable` for the
pseudo-colouring's circle colouring: `retArc_partner` through the bridge), `BaseCtx.exists_endpoint_third` (an endpoint's third colour is a colour of
`u`, else `cor3_base`), `BaseCtx.third_ne` (Lemma 4's distinctness: `endpoint_dist_ge`, `pair_P'`, `vin_antipodal`, `l3_base`). `BaseCtx.removable` and the
periodicity lemmas are kernel theorems; `BaseCtx.false`, `third_ne`, `exists_endpoint_third` and `row134BaseUA` are wired (over `exists_pseudoCircle`,
`reduce`, `select`, `l3_base`, `bv_hex` and the planar job's three).

### 23.3 The build

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` (a first attempt waited 25 min for the slot without starting and was
stopped by PID while still waiting, so that one build covers both leaves): **OK — 447 of 447 batches, 6 modules rebuilt, 8 with warnings, every warning
`declaration uses 'sorry'`**, exit 0 (`build/gate/build/20261005T024824Z-741049.log`, "Build completed successfully (5369 jobs)"; driver log
`data/fs131/i5f/build-stage23.log`). Wave 5's sorry declarations: **29** (`Terminal` 9, `Dense` 1, `Cor3` 0, `HexRing` 6, `MapGraph` 3, `BaseWalk` 7,
`BaseDense` 3), **13 mine** (from 15: `cor3_local` proved, `row134BaseUA` wired). Axioms read from this build's oleans
(`data/fs131/i5f/I5fAxioms23.lean` → `I5fAxioms23.out`): `cor3_local`, `cor3`, `pseudo_ncard_le_two_of_baseHyp`, `BaseCtx.pseudo_ncard_le_two`,
`rot_noThird`, `BaseCtx.cor3_base`, the `Cor3` children, `BaseCtx.removable`, `IsRetArc.exists_Ico` on `[propext, Classical.choice, Quot.sound]`;
`BaseCtx.false` and `row134BaseUA` on those and `sorryAx` (wired); the controls read as they must (`l3_base` `sorryAx`, `linkage_dot_ne_zero` clean).
`tools/check_architecture.py`: PASS. `scripts/Axioms.lean`: a block "FS131-I5f" (after I5e's) with every new record. New names collision-free here and
on `fs131-w5p`, `fs131-w5t`, `fs131-w4`, `main` (by `git grep`).

## Stage 23 — SAVED

## Stage 24 — SAVED: `exists_pseudoCircle` proved (a kernel theorem); the periodicity glue moved upstream to `BaseWalk`

**`BaseCtx.exists_pseudoCircle` is proved as stated** (`Plane/ValidMap/BaseWalk`; axioms the standard three), on KB's plan A4's route with one change
of construction: the change set is the set of **germ changes** (`S = {θ | no v has both germs g v}`) rather than "non-singleton or germs differ", since
the statement's fifth clause asks that `S` hold only genuine changes. The colouring at `θ` is the clockwise germ's colour (`choose`), so the one-sided
values are the germs' by construction; local constancy off `S` reads the two germs at `θ`; properness at `60°` is `pair_i` at a nearby angle where both
points are singletons (inside the two counter-clockwise germs); no swap is `pair_ii` at `x`, `x ± 60°` (both pseudo-colours are the change's two colours,
`pseudo_ncard_le_two`), its two outcomes refuted by H directly and through `noBoth`. `g` is an equivalence `ℤ/3 ≃ (P_cl(p))ᶜ`
(`Fintype.equivOfCardEq`).

Children (`BaseWalk`, a section after `germ_sub_two_pi`, before `retArc_partner`; standard three): `germPseudo_cw_iff`, `germPseudo_ccw_iff` (a germ's
pseudo-colour in interval form), `BaseCtx.exists_germPseudo` (both germs of every point of `ω(p)` carry one pseudo-colour: the non-singleton points are
finite, `pseudo_finite`, and on an open arc of singleton points the pseudo-colour is constant — each colour's set is closed and the arc preconnected,
`isPreconnected_iff_subset_of_disjoint_closed`). The periodicity lemmas of stage 23 (`germ_add_int_mul`, `ringPt_add_int_mul`, `germPseudo_add_int_mul`,
`ringArc_add_int_mul`, `IsRetArc.add_int_mul`, `IsRetArc.exists_Ico`) moved from `BaseDense` to this section verbatim (their full names unchanged, so
`scripts/Axioms.lean`'s records stand); `exists_pseudoCircle` itself moved down into the same section, statement and docstring unchanged, because its proof
reads `germPseudo_unique` and `pseudo_ncard_ne_one_of_change`, declared after its old place. Nothing between its old and new place cites it.

`row134BaseUA` now rests, of my set, on `reduce`, `select`, `l3_base` and `bv_hex` (with the planar job's `retArcs_nested`, `exists_endpoint`,
`exists_eleventh`).

**Statements unchanged** (checked by script, `tools/fs131_i5_stmt_check.py 6e38803d`: every declaration of `Cor3`, `BaseWalk`, `BaseDense`, `HexRing`,
`Dense` at the as-given commit keeps its statement text, new declarations allowed; **PASS**; `--self-test`: three plants — a hypothesis loosened in
`cor3_local`, a conclusion loosened in `l3_base`, a declaration renamed in `HexRing` — each **fired**, the unplanted control passed). The planar job's
fence holds: `retArcs_nested`, `exists_endpoint`, `exists_eleventh`, `exists_unenclosed_or_bad` byte-identical to `6e38803d`; `Terminal` and `MapGraph`
untouched.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 3 modules rebuilt, 8 with warnings, every warning `declaration uses 'sorry'`**,
exit 0 (`build/gate/build/20261005T030125Z-824312.log`, "Build completed successfully (5369 jobs)"; driver log `data/fs131/i5f/build-stage24.log`). Wave
5's sorry declarations: **28** (`Terminal` 9, `Dense` 1, `HexRing` 6, `MapGraph` 3, `BaseWalk` 6, `BaseDense` 3), **12 mine**. Axioms read from this
build's oleans (`data/fs131/i5f/I5fAxioms24.lean` → `I5fAxioms24.out`): `exists_pseudoCircle`, `exists_germPseudo`, `germPseudo_cw_iff`,
`germPseudo_ccw_iff`, `IsRetArc.exists_Ico`, `germ_add_int_mul`, `BaseCtx.removable`, `cor3_local` on the standard three; `row134BaseUA` with `sorryAx`
(wired); controls `reduce` `sorryAx`, `linkage_dot_ne_zero` clean. `tools/check_architecture.py`: PASS. `scripts/Axioms.lean`: three records added to the
"FS131-I5f" block.

**What is left of my set (12), and where it stands** (for wave 5's next implementer on this half):
- **On `row134BaseUA`'s path** (it is wired; these four of mine, with the planar job's three, are what it rests on):
  - `CircleColouring.reduce` (**M–H**, circle-abstract). Construction: on each `θ` whose `e θ` lies in some closed span `e '' Icc q.1 q.2`, `q ∈ 𝓙`,
    recolour by the outer colour of the longest such `q` (spans containing one point are nested, so the longest contains the others; choose it by
    `Finset.exists_max_image` on `q.2 − q.1`, reading `e θ` so the choice is `2π`-periodic); `C′.S := C.S` minus the closed spans. The step CD § 2.4
    step 5 reads as "the partners of `I₁` have one-colour pseudo-colours" is derivable from `Removable` alone (checked by hand here, one mind): if
    `x ∈ (s, t)` and `y = x ± 60°` had `LeftVal y v`, `RightVal y w`, the partner clause at points near `y` off `S` (finitely many per period) gives
    `v, w ∉ {a, c}`, so `v = w`, the third colour — a partner of an interior point is never a genuine change point. Then step 5's six cases go
    through on `C`'s properness (CD's "mono–mono") and the partner clause; no-swap for `C′` is `C`'s off the spans, and inside a span's interior
    `C′` is constant, which the partner clause makes proper.
  - `CircleColouring.select` (**H**, circle-abstract): BASE-V § 1a.2–1a.3 over wave 3's `Lift` (KB's plan B2).
  - `BaseCtx.l3_base` (**H**): BASE-V § 1b.3's linkage band on the two pseudo-colourings, now available from `exists_pseudoCircle` at both centres
    (KB's plan D5); `linkage_dot_ne_zero`'s docstring is to be rewritten then (item 274 (b)).
  - `bv_hex` (**H**, six children; `p17_ua` is wired over it).
- **Off that path**: `rot_out`, `rot_in`, `hex_regular` (FS112-ROTHEX's own clauses; the walk uses `p17_ua`/`bv_hex`, not N2-ROT's table — KB's note
  10.5 (1)); `bv_nd`, `bv_l3` (FS114-BV-HEX's; `bv_nd1` is wired over `bv_nd`, and `l3_base` replaces `bv_l3` in the walk).
- **`exists_preBend`** (`n3_base`'s pre-bend): needs `bend_toward` (`sorry` on this branch, proved on `fs131-w4` by I4n) iterated over the finitely
  many inert arcs centred in `B̄(u, 1)`, **and** a bend form that keeps `u` cubic trichromatic and `UnenclosedC u` — E4-BEND-UN's "each bend is induced
  by a homeomorphism of the plane fixing `u`". `bend_toward`'s conclusion gives agreement off an `ε`-thickening of the arc, `RingArcsWithin` and
  region inclusions, but no homeomorphism, and an inert arc of `ω(P)` may end at `u` (`|u − P| = 1`), where agreement off the thickening says
  nothing about `u`'s sectors. So the leaf needs the strengthened-bend child KB's plan § 2.3 owes; a question for the planner (below).
- **`cv_exists`**: over `exists_terminal` (`Terminal`, `sorry`) and `dense3`; but `exists_terminal`'s clause 3 lets a run end within `1` of an (R2)
  arc point, which a map with no four-colour vertex may have, so the contradiction needs CVB § 1.4 items 3–6 (a stuck vertex centres no unit arc; the
  chain runs on along one axis) — the `stuckAlong_of_run` / `cv_l0` cluster of `Terminal`. Best taken with or after the `Terminal` implementer.
- **`disc1_local`** (`Dense`): FS112-DISC1 on a fragment — the nesting of tiles about `x` inside `B̄(x, 1)`, planar topology. The planar job's
  `exists_unenclosed_or_bad` does not give it (its bad points may be repeated-colour points with two colours, and `Dense` is upstream of `BaseDense`);
  a candidate for the planar lane.

**Drafts for the front page**: none — wave 5 is not at its gate.

## Stage 24 — SAVED

## Stage 25 — SAVED: FS131-I5g's readback

*FS131-I5g, wave 5's seventh implementer (Opus), resuming this record at its first unsaved stage (Stage 24 SAVED, `d61edefc`). Brief:
`data/fs131/briefs/FS131-I5g-wave5.md` (main tree). My set (ruling 317 (a)): `BaseWalk`'s `CircleColouring.reduce`, `CircleColouring.select`,
`BaseCtx.l3_base`; `HexRing`'s `bv_hex`, `rot_out`, `rot_in`, `hex_regular`, `bv_nd`, `bv_l3`; `BaseDense`'s `exists_preBend` with the strengthened-bend
child (ruling 317 (b)) — 10. Never `Terminal`, `cv_exists`, `disc1_local`, or the planar job's seven.

### 25.1 The brief's quotations against their sources (standing rule 3)

Checked by script (each `> ` line of the brief searched verbatim in the file its `— source:` line names, with line breaks in the source folded to one
space; main tree for `CLAUDE.md` and the inventory, the worktree for the plans and this record). The checker was watched to fire on a planted
one-letter change ("practicaly") in the first quotation.

| quotation (opening words) | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | verbatim |
| "**What is left of my set (12), and where it stands** (for wave 5's next implementer on this half):" | this record, Stage 24 | verbatim |
| "- **`exists_preBend`** (`n3_base`'s pre-bend): needs `bend_toward` (`sorry` on this branch, proved on `fs131-w4` by I4n) iterated over the finitely" | this record, Stage 24 | verbatim |
| "316. **FS131-I5f handed back** (Stage 24 SAVED, harness ≈ 569k by the task notice; record `fs131-w5`'s `plans/FS131-I5-implementation.md`, Stages 22–24;" | `plans/FS131-close-inventory.md` item 316 | verbatim |
| "317. **Rulings on I5f's questions, and its slot.** (a) **I5f's slot → FS131-I5g on `fs131-w5`**, the same half: `row134BaseUA`'s four first (`reduce` by I5f's" | the inventory, item 317 | verbatim |
| "226. **FS131-E4 done, harness ≈ 480k** (report `data/fs131/reports/FS131-E4.md`; record `plans/FS131-E4-derivation.md`; commits `fffe465f` … `e2928a7b`, checked;" | the inventory, item 226 | verbatim |
| "274. **Rulings on QA3's held items and the freed slot.** (a) **`InMK`**: restated when its first consumer is planned, not now (no theorem uses it; a definition" | the inventory, item 274 | verbatim |
| "**It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the" | `plans/FS131-w5-kernel-plan.md` § 10.2 | verbatim |
| "295. **Ruling: MERGE leaves wave 4; the freed slot goes to FS131-IX1 as ruled.** Choice: (a) wave 4 lands without `exists_merge` — at wave 4's merge-and-gate," | the inventory, item 295 | verbatim |

Items 226, 258, 274, 295, 316, 317 read in full; I5f's Stages 22–24 read; the plans' §§ 3.2, 8.2, 9.1, 10.2 (`FS131-w5-kernel-plan.md`) and stages 3–6
(`FS131-w5base-kernel-plan.md`) read.

### 25.2 The as-given build (`d61edefc`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1754 modules already
up to date, nothing built, 8 modules with warnings**, exit 0 (`build/gate/build/20261005T031610Z-915357.log`; driver log
`data/fs131/i5g/build-stage25-asgiven.log`). Every warning is `declaration uses 'sorry'`, 36: wave 5's `Terminal` 9, `Dense` 1, `HexRing` 6, `MapGraph` 3,
`BaseWalk` 6, `BaseDense` 3 (**28**, the brief's count; mine 10 of them), and wave 4's stale `Contact` 3, `UnitArc` 5. `tools/fs131_i5_stmt_check.py
d61edefc`: PASS; `--self-test`: three plants fired, the control passed.

Iteration script: `data/fs131/i5g/iter.sh` (I5f's, re-pointed at its own scratch mirror `/home/kooshi/scratch-w5g`, outside the repository).

## Stage 25 — SAVED

## Stage 26 — SAVED: `CircleColouring.reduce` proved (a kernel theorem)

**`reduce` is proved as stated** (`Plane/ValidMap/BaseWalk`; axioms the standard three), on I5f's construction (Stage 24, "What is left"), circle-abstract:
1. *The periodic family.* `𝓚 = {(q.1 + 2πm, q.2 + 2πm) | q ∈ 𝓙, m ∈ ℤ}`: every member removable (`Removable.add_int_mul`), shorter than `60°`, locally finite
   (finitely many with left end in any `[a, b]`), and **nested or disjoint as real intervals** — from `hnest` on the circle, since two short spans that meet
   in `ℝ` and whose `e`-images nest are nested (a point whose `e` lies in a span of length `< 60°` meeting it lies in it: `e_eq_e_iff`, the integer is `0`).
2. *Maximal members* (`reduce_exists_max`): every covered `θ` lies in a member that holds every member meeting it (the longest member containing `θ`).
   Near any `x` only members containing `x` cover (`reduce_nearOnly`), so left of a maximal member's left end and right of its right end nothing is covered
   (`reduce_left_uncov`, `reduce_right_uncov`).
3. *The colouring.* `c′ θ` = the colour just left of the maximal member's left end when `θ` is covered, else `c θ`; `S′ = {θ ∈ S | θ uncovered}`.
   Locally constant off `S′` (`reduce_locConst`: interior points, and the two ends, where the outside colour is the outer colour `a` on both sides —
   `LeftVal s a`, `RightVal t a`); `2π`-periodic (a maximal member shifted by `2π` is maximal).
4. *Proper* (`reduce_proper_off`, after moving both points off `S` by local constancy): uncovered–uncovered is `C.proper`; covered–uncovered is the
   partner clause; covered–covered: **I5f's hand check is formalized** as `reduce_partner_noChange` — at a point of `(s, t) ± 60°` the one-sided values
   agree (both avoid `a` and `c`, three colours) — so the second span's left end is not inside the first's `+60°` shift, nor the first's inside the
   second's `−60°` shift, which forces `s′ = s + 60°`, and `C.proper` just left of `s` separates the two outer colours.
5. *No swap*: at `x ∈ S′` the two colourings agree near `x`; if `x ± 60°` is uncovered they agree there too and a swap of `C′` is one of `C` (`hns`); if
   it is covered `C′` is locally constant there, so its one-sided values agree, while a swap needs them distinct (properness of `C′`, `reduce_leftVal_ne`).
6. The conclusion's clauses: `S′ ⊆ S`; `e x` in no span's image (else `x` covered); one-sided values equal `C`'s (agreement near `x`).

Read against the informal claim (FS110-CD Lemma R steps 4–5): "recolouring each maximal arc of a finite, pairwise nested-or-disjoint family of removable
arcs by its outer colour leaves a circle colouring with no swap point, whose change points are change points of the original outside the arcs' closed
spans, with the same one-sided colours" — **same**; the colouring built is exactly that recolouring.

**Statements unchanged** (`tools/fs131_i5_stmt_check.py d61edefc`: PASS). New names collision-free on `fs131-w5p`, `fs131-w5t`, `fs131-w4`, `main` (`git grep`).

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 3 modules rebuilt (`BaseWalk`, `BaseDense`, `Proofs`), 8 with warnings, every
warning `declaration uses 'sorry'`**, exit 0 (`build/gate/build/20261005T033138Z-1000357.log`; driver log `data/fs131/i5g/build-stage26.log`). Wave 5's
sorry declarations: **27** (`BaseWalk` 5), mine 9. Axioms (`data/fs131/i5g/I5gAxioms26.lean` → `.out`): `reduce` and its 14 children on the standard three;
control `select` reads `sorryAx`. `scripts/Axioms.lean`: a block "FS131-I5g" (above the `=== PURCHASED ===` banner) with the 14 children (`reduce`'s own
record is KB's).

**Re-pricing** (first hard leaf): `reduce` took about 30k tokens of context, about a third of an implementer session's working budget — M–H as planned.

## Stage 26 — SAVED

## Stage 27 — SAVED: `CircleColouring.select` proved (a kernel theorem)

**`select` is proved as stated** (`Plane/ValidMap/BaseWalk`; axioms the standard three), circle-abstract, on BASE-V's route (§ 1a.2–1a.3) with BV-L5's
recolouring replaced by its jump points — the **first passages** of the lift — so no recoloured colouring is built:
1. *The band* (BV-H1): with no swap point wave 3's `m0_const` (over `hbig_of_noSwap`) makes `m₀` constant on `T0`, so `D₀ ∈ {3M + 1, 3M + 2}` at every `z`
   with `z, z + 60°` off `S`. *The increment* `N = f(θ + 2π) − f(θ)` is one integer off `S` (`W_eq_aux` and `3 | N`, by periodicity of `c`), and summing the
   band over a good hexagon gives `18M + 6 ≤ N ≤ 18M + 12`, so `N ≠ 0`. For `N < 0` the selection runs on the negated lift (colours `−c`, `M ↦ −M − 1`).
2. *First passages* (`select_firstPassage`, for an integer lift `g` with `N > 0`): `x_ℓ = inf {x ∉ S | g x ≥ ℓ}` exists (`g` is bounded above on a period,
   `select_bdd`, by compactness), `g < ℓ` left of it, `g = ℓ − 1` just left and `g = ℓ` just right (the jump is at most one). They are unique
   (`select_unique`), strictly increasing (`select_lt`), `2π`-periodic in `ℓ ↦ ℓ + N`, change points, and each keeps its pair `{ℓ − 1, ℓ}` — BV-L5's
   kept points with their pairs.
3. *Windows* (`select_window`, `select_window'`): `x_{ℓ + 3M + 3} > x_ℓ + 60°` (BV-P18's count: just right of `x_ℓ` and everywhere left of it `g ≤ ℓ`, and
   the band adds at most `3M + 2`), and `x_{ℓ + 3M + 1} ≤ x_ℓ + 60°` (the band adds at least `3M + 1`).
4. *`N = 6`* forces `M = 0`; six gaps of at most `60°` summing to `2π` are all `60°`: the hexagon `IsHex (x_0) (j ↦ τ(j − 1))` (BV-C6).
   *Otherwise* `N ≥ 9(M + 1)` (`3 | N`), and for a pair `{v, w}` the levels `ℓ₀, ℓ₀ + k, ℓ₀ + 2k` (`k = 3(M + 1)`, `ℓ₀` the pair's residue,
   `select_residue`) give three change points with that pair, consecutive gaps `> 60°` summing to `2π`, so every chord exceeds `1` (`select_chord`).

Read against the informal claim (`select`'s docstring; BASE-V BV-L5, BV-C6, BV-P18): "a circle colouring with no swap point is the rotating hexagon, or for
each pair of colours it has three change points with that pair, pairwise more than `60°` apart (chords longer than `1`); the points are the colouring's
own" — **same**.

**Statements unchanged** (`tools/fs131_i5_stmt_check.py d61edefc`: PASS). New names collision-free (`git grep` on `fs131-w5p`, `fs131-w5t`, `fs131-w4`, `main`).

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 3 modules rebuilt, 8 with warnings, every warning `declaration uses 'sorry'`**,
exit 0 (`build/gate/build/20261005T034254Z-1077466.log`; driver log `data/fs131/i5g/build-stage27.log`). Wave 5's sorry declarations: **26** (`BaseWalk` 4),
mine 8. Axioms (`I5gAxioms27.lean` → `.out`): `select` and its 9 children on the standard three; control `l3_base` reads `sorryAx`. `scripts/Axioms.lean`:
the 9 children added to the "FS131-I5g" block.

**Re-pricing from the first two hard leaves**: `reduce` and `select` (both M–H/H in the plan) each took roughly 30–40k tokens and one build. The remaining
leaves are map-level (planar geometry, sector charts, the linkage): `l3_base` is the linkage argument of BASE-V § 1b.3 and I expect it to be the largest
of the set (a parametrized linkage loop, a discrete intermediate-value argument for the height difference, the band at the two partners of an
intersection point).

## Stage 27 — SAVED

## Stage 28 — SAVED: `BaseCtx.l3_base` proved (a kernel theorem); `linkage_dot_ne_zero`'s docstring rewritten (item 274 (b))

**`l3_base` is proved as stated** (`Plane/ValidMap/BaseWalk`; axioms the standard three), on BASE-V § 1b.3's route — the unit-distance linkage and the
band — with three changes of construction, each forced by the pseudo-colour setting (rings may carry contact arcs, change points may be non-generic):
1. *The linkage as one loop* (`exists_linkage`, explicit): `x = r_{u₁}(φ θ)`, `φ θ = φ_c + θ_X cos θ` (`φ_c` the direction to `u₂`, `cos θ_X =
   (t² − 3)/2t`, so `φ` sweeps exactly the arc of `ω(u₁)` within `2` of `u₂`), `y = u₂ + (x − u₂)(½ + k i)` with `k = sgn(sin θ)·√(1/|x − u₂|² − ¼)`,
   `χ` the angle of `y` read from the direction to `u₁` (continuous: `y` never reaches the far point, which is `t + 1 > 2` from `u₁`). Facts: finite
   fibres (`link_fibres`: a point of `ω(u₂)` has at most two partners on `ω(u₁)`, `link_circles_finite`); `χ` turns where `|y − u₁| = 2` (`link_turn`:
   there `χ` is an end of its range); at the intersection point `P = r_{u₁}(φ_c + γ)`, `cos γ = t/2`, reached at `θ = ±θ_A`, the two values of `y` are
   `P`'s partners `r_{u₂}(χ_P ± 60°)` (`link_partners`), `x` stays above `P` on `(−θ_A, θ_A)` and below it on `(θ_A, 2π − θ_A)`; `χ` is strictly monotone
   near `±θ_A` where `|y − u₁| < 2` (`link_flip`: the two partners of `y` are then apart, so `x` is a function of `y` near `P`), which holds at one of
   them at least (`link_one_lt_two`). The declaration needs 300000 heartbeats (measured; it fails at the default 200000), so it carries
   `set_option maxHeartbeats 400000 in` with that measurement as its comment.
2. *The band constancy* (`link_path`, circle-abstract): along a path with finite fibres, read through lifts `L₁`, `L₂`, the difference `L₁(φ) − L₂(χ)`
   at generic parameters is never `0 mod 3` (`hgen`) and keeps its band `⌊·/3⌋`: at every parameter the one-sided values (`link_val_left/right`, from
   the lifts' sides and the path's side, constant by the intermediate value theorem) differ by at most `1`, unless both lifts jump and the jump is `±2`
   — and then the two changes carry one pair (computed), which `hdbl` excludes unless `χ` turns. No velocity is used: BV-ND's `μ ≠ 0` and the
   turning-point step of QA3's note 2.4 d are replaced by "the two points switch the same pair" (FS112-N3-PAIRS (ii), `pair_ii`, which needs no sense),
   so `linkage_dot_ne_zero` is not cited (its docstring is rewritten anyway, as item 274 (b) asks).
3. *The endpoints and the band* (no `c₀`, no genericity of `P`): on each of the two paths from `P`'s configurations — `θ ∈ [−θ_A, θ_A]` (`x` above `P`)
   and `[θ_A, 2π − θ_A]` (`x` below) — `L₁` is read at `P` from one side at both ends, so the band constancy gives `|L₂(χ_A^±) − L₂(χ_B^±)| ≤ 1` for the
   sides from which `y` reaches its two ends. The flip makes the two paths reach a non-end partner from opposite sides; at one partner at least this
   holds. With the band of `C₂` (`D₀ ∈ {3M + 1, 3M + 2}`, at left and at right values) at `χ_P ± 60°` and `χ_P`, every combination of sides gives a
   difference of absolute value at least `2` (equal sides: two band terms; opposite sides on both paths: their sum is four band terms) — a
   contradiction (`omega` over the cases). This replaces BASE-V's `c₀ = h₁(P) − h₂(P) ∈ 3ℤ`, which needs `P` generic (BV's "non-generic `P`" remark).

Map inputs: both pseudo-colourings from `exists_pseudoCircle`, the second relabelled to the first's labelling (`link_relabel`; `g₁` hits every colour
absent at `u₁`, a count); `hgen` is FS112-N3-PAIRS (i) (`pair_i`) at points whose pseudo-colour is one colour (non-singleton points excluded with the
change points: `pseudo_finite` and `link_periodic_finite`); `hdbl` is FS112-N3-PAIRS (ii) (`pair_ii`) with `y ≠ u₁`, `|y − u₁| ≠ 2`, its two outcomes
refuted by H (`BaseCtx.hyp`) and `noBoth`.

Read against the informal claim (`l3_base`'s docstring; `[SokolovVoronov2025]` Lemma 3, BV-L3): "two cubic trichromatic points of `B̄(u, 1)` with one
multicolour are not at distance in `(1, 2)`; their circles may carry in- and out-contact unit arcs" — **same**. The docstring's list of inputs names
`linkage_dot_ne_zero`, which the proof does not need (point 2); left as written (a docstring, not a statement).

**`linkage_dot_ne_zero`'s docstring** (`HexRing`) now reads as `plans/FS131-QA3-audit.md` § 2.4 d drafts it ("at least one of the two points moves with
non-zero component along `e`; at a switch of both colours (no turning point, `λ₁, λ₂ ≠ 0`) the two components are equal, so both are non-zero");
statement unchanged.

**Statements unchanged** (`tools/fs131_i5_stmt_check.py d61edefc`: PASS). New names collision-free (`git grep` on `fs131-w5p`, `fs131-w5t`, `fs131-w4`,
`fs131-w5x`, `main`).

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 5 modules rebuilt (`HexRing`, `Dense`, `BaseWalk`, `BaseDense`, `Proofs`), 8 with
warnings, every warning `declaration uses 'sorry'`**, exit 0 (`build/gate/build/20261005T043331Z-1353383.log`; driver log `data/fs131/i5g/build-stage28.log`).
Wave 5's sorry declarations: **25** (`BaseWalk` 3 — the planar job's `retArcs_nested`, `exists_endpoint`, `exists_eleventh`), mine 7. Axioms
(`I5gAxioms28.lean` → `.out`): `l3_base` and its 20 children on the standard three; controls `row134BaseUA` and `bv_hex` read `sorryAx`,
`linkage_dot_ne_zero` clean. `scripts/Axioms.lean`: the 20 children added to the "FS131-I5g" block.

**`row134BaseUA` now rests, of this half, on `bv_hex` alone** (through `hex_base` → `p17_ua`), with the planar job's three.

## Stage 28 — SAVED

## Stage 29 — SAVED: the handoff (what is left of this half, and where it stands)

`tools/check_architecture.py`: PASS (no module added; imports unchanged). The working tree is clean at the stage-28 commit.

**What is left of my set (7)**, for wave 5's next implementer on this half:
- **`bv_hex`** (**H**; the last of this half on `row134BaseUA`'s path — with the planar job's three, all `row134BaseUA` now rests on). BASE-V § 1a.4
  steps 1–6. Step 6's count reads the tangent cones of `u`'s three sectors as closed angular intervals summing to `2π` (horns of angle `0` allowed):
  the shared child **`coneAt_of_cubic`** (plan § 9.1, `hex_regular`'s child too) does not exist yet — only `Simple.coneAt_eq_angleIcc`
  (`Plane/LocalStructure` l. 2463) for simple maps, and `IsJordanDomain.coneAt_eq_angleIcc` (l. 386). Build it first, from the sector chart of a cubic
  trichromatic vertex (`IsCubicTrichromatic.chart`, `Plane/ValidMap/BaseSteps` l. 407). Step 5 is `Valid.cone_re_nonneg_of_germ`'s pattern
  (`Plane/RingGerm` l. 134) along the outward radial. Step 4's exactly-unit pair `x_j + s t`, `x_{j+1} + s t` needs open neighbourhoods inside the two
  cones (the colour at the point itself is not read); `hF.dist_ne_one_of_isOpen_subset_closure` (used in `BaseSteps`) is the tool.
- **`rot_out`, `rot_in`** (M each), **`hex_regular`** (M, over `coneAt_of_cubic`), **`bv_nd`** (M–H: BASE-V § 1b.2 steps 2–4, the unit-arc tangency
  computation of step 4), **`bv_l3`** (H; off the walk's path — `l3_base` replaced it there). For `bv_l3` the stage-28 machinery transfers: with
  `RingProper` the two rings are wave 3's `ringCircleColouring`s, `exists_linkage` and `link_path` apply verbatim, and `hdbl` is `bv_nd` (or
  `pair_ii`, which `bv_l3`'s hypothesis H on the circles supports, as in `l3_base`).
- **`exists_preBend`** (H): needs the strengthened bend (ruling 317 (b): a child of `exists_preBend`, read back against E4-BEND-UN, citing
  `bend_toward` as given). Not attempted in this job.

**Route notes for the next implementer** (from stages 26–28):
- Circle-abstract arguments go fastest as lemmas over a family or an integer function with explicit hypotheses (`reduce_*`, `select_*`,
  `link_path`), assembled in the leaf's proof.
- A long `set`-based construction exhausts the declaration's heartbeat budget (it is cumulative); `clear_value` the `set` variables once their
  defining equations are recorded, keep `nlinarith` off goals that mention them, and split facts into lemmas over the defining equations
  (`link_fibres`, `link_flip`, …). `exists_linkage` still needs 300000 (measured) and carries `set_option maxHeartbeats 400000 in`.
- Iteration: `data/fs131/i5g/iter.sh` (scratch mirror `/home/kooshi/scratch-w5g`); a scratch file importing `BaseWalk` compiles in seconds.

**Drafts for the front page**: none — wave 5 is not at its gate.

## Stage 29 — SAVED

## Stage 30 — SAVED: FS131-I5j's readback

*FS131-I5j, wave 5's eighth implementer (Opus), resuming this record at its first unsaved stage (Stage 29 SAVED, `f0c6ba67`). Brief:
`data/fs131/briefs/FS131-I5j-wave5.md` (main tree). My set (ruling 331 (b)): `coneAt_of_cubic` (a new shared child), then `HexRing`'s `bv_hex` and
`hex_regular` over it, then `rot_out`, `rot_in`, `bv_nd`, `bv_l3`, then `BaseDense`'s `exists_preBend` over the strengthened-bend child (ruling 317 (b))
— 7 `sorry` declarations. Never `Terminal`, `cv_exists`, `disc1_local`, or the planar job's declarations.

### 30.1 The brief's quotations against their sources (standing rule 3)

Checked by a new script, `tools/fs131_i5_quote_check.py` (each run of `> ` lines searched verbatim, line breaks folded, in the file its `— source:` line
names; a relative path resolves to the main tree first, an absolute one as given): **12 quotations, 12 verbatim**, exit 0. Negative control: `--plant`
changes "practically" to "practicaly" in the first quotation, and the checker reports it MISMATCH (exit 0 under `--plant` only when caught). A first run
resolved `plans/FS131-close-inventory.md` to the worktree's stale copy and reported the six inventory quotations as mismatches — the resolution was
corrected to the main tree's copy (the brief's own tree), and the six then read verbatim.

| quotation (opening words) | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | verbatim |
| "**What is left of my set (7)**, for wave 5's next implementer on this half:" | this record, Stage 29 | verbatim |
| "- **`bv_hex`** (**H**; the last of this half on `row134BaseUA`'s path — …" | this record, Stage 29 | verbatim |
| "- **`rot_out`, `rot_in`** (M each), **`hex_regular`** (M, over `coneAt_of_cubic`), …" | this record, Stage 29 | verbatim |
| "- **`exists_preBend`** (H): needs the strengthened bend (ruling 317 (b): …" | this record, Stage 29 | verbatim |
| "330. **FS131-I5g handed back** …" | `plans/FS131-close-inventory.md` item 330 | verbatim |
| "331. **Rulings on I5g's held items, and its slot.** …" | the inventory, item 331 | verbatim |
| "317. **Rulings on I5f's questions, and its slot.** …" | the inventory, item 317 | verbatim |
| "226. **FS131-E4 done, harness ≈ 480k** …" | the inventory, item 226 | verbatim |
| "274. **Rulings on QA3's held items and the freed slot.** …" | the inventory, item 274 | verbatim |
| "**It may**: add children anywhere in the wave's modules — …" | `plans/FS131-w5-kernel-plan.md` § 10.2 | verbatim |
| "295. **Ruling: MERGE leaves wave 4; …" | the inventory, item 295 | verbatim |

Items 317, 330, 331 read in full; I5g's Stages 25–29 read; the kernel plan's §§ 3.2, 4, 8.2, 9.1, 10.2 and the base plan's Stages 3–6 read.

### 30.2 The as-given build (`f0c6ba67`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1754 modules already
up to date, nothing built, 8 modules with warnings**, exit 0 (`build/gate/build/20261005T044936Z-1440310.log`; driver log
`data/fs131/i5j/build-stage30-asgiven.log`). Every warning is `declaration uses 'sorry'`, 33: wave 5's `Terminal` 9, `Dense` 1, `HexRing` 6, `MapGraph` 3,
`BaseWalk` 3, `BaseDense` 3 (**25**, the brief's count; mine 7 of them: `HexRing`'s 6 and `BaseDense`'s `exists_preBend`), and wave 4's stale `Contact` 3,
`UnitArc` 5. `tools/fs131_i5_stmt_check.py d61edefc`: PASS; `--self-test`: three plants fired, the control passed.

Iteration script: `data/fs131/i5j/iter.sh` (I5g's, re-pointed at a fresh scratch mirror `/home/kooshi/scratch-w5j`, outside the repository).

## Stage 30 — SAVED

## Stage 31 — SAVED: `coneAt_of_cubic` (a new shared child), `hex_regular` and `bv_hex` proved (kernel theorems); `l3_base`'s docstring corrected

**`coneAt_of_cubic`** (plan § 9.1's shared child, `Plane/ValidMap/HexRing`): at a cubic trichromatic `u` there are `β : Fin 3 → ℝ` and an injective
`f : Fin 3 → Fin k` with `β₀ ≤ β₁ ≤ β₂ ≤ β₀ + 2π`, `coloursAt u = range f`, and the cones of the three colour classes at `u` the closed angular intervals
`[β₀, β₁]`, `[β₁, β₂]`, `[β₂, β₀ + 2π]` (horns of angle `0` allowed). From the sector chart (`IsCubicTrichromatic.chart`): the class of `f i` near `u` is
the `i`-th sector (`exists_sector_of_mem_coneAt_region` and injectivity), whose cone is the chart's. Spec example: it applies at the brick corner
(`sevenBrick_corner_isCubicTrichromatic`, a valid map of the plane).

**The hexagon count** (new children, pure arithmetic): `hex_int_core` (three integer intervals over one period holding the six residues mod 6 are the
tight ones — a Finset count: two classes fit an interval of length `≤ 3`, so `2 · 6 ≤ 12` forces equality; a class of two needs two integers),
`hex_int_noAdj` (with no two consecutive residues in one class, impossible), `exists_halfTurn_of_cos_nonpos`, `eq_floor_of_floor_eq_ceil`,
`hex_real_core` (the same in the directions, through `⌊3(a − ψ)/π − 3/2⌋`, `⌈3(a − ψ)/π − 9/2⌉`), `angleIcc_add_int_mul`, and `hex_cones_of_serve`
(the six directions served by the cones of a cubic vertex make the cones regular, and two consecutive directions share a colour). A first attempt
to close the count by `omega` over the 3⁶ assignments timed out at 200000 heartbeats both as one call and as 729 split calls; the count is now a
Finset argument and every `omega` call is small.

**`hex_regular` is proved as stated** — **and its first disjunct always holds**: at a cubic vertex the cones are contiguous, so two horns share their
boundary direction and point the same way; the antipodal double cusp (the second disjunct) needs four branches. So **F-HEXCUSP (plan § 8.4) does not
arise at a cubic vertex**: N2-HEX holds as FS-110 wrote it, for degree 3. The statement is untouched (its second disjunct is unrealized, not false);
the docstring now says what the proof establishes. Read against the informal claim (FS110-N2-HEX): "each of the six points served ⟹ `u` regular" —
**same** (stronger than the statement, which also allows the unrealized disjunct).

**`bv_hex` is proved as stated** (`plans/BASE-V-verification.md` § 1a.4 steps 1–6), with new children:
- `hex_side` (step 1: a germ in the closure of `q` whose points are nearer than `1` to `x` puts the class of `q` near `x` inside `B̄(y, 1)`);
- `hex_point` (steps 1–3 and 5 at one point: near `x`, outside `B̄(r(φ ± 60°), 1)`, every interior point has one colour `c ∈ P_cl(u)`, and `c`'s cone at
  `u` lies in the closed half-plane away from `x`; the outward radial lies in that cone, `1 + s + s²`); step 3 uses only "fewer than four colours" at
  `x` (the repeated-colour half of H is not needed: the cone's colours are colours of `x` that are colours of `u`, and there is one such);
- `Valid.cone_re_nonneg_of_preconnected` (`Valid.cone_re_nonneg_of_germ` with the germ replaced by any preconnected set; step 5 along the radial);
- `hex_adjacent` (step 4: `x + s e(φ + 30°)` and `x′ + s e(φ + 30°)` are exactly `1` apart, in the two cones — `1 + s²` to the near neighbours,
  `1 + √3 s + s²` to the far ones — and each cone is an open set in its colour's closure, `subset_closure_region_of_isOpen`; then
  `Valid.dist_ne_one_of_isOpen_subset_closure`);
- glue: `GermPseudo.germIn_closure`, `germPseudo_add_two_pi`, `ringPt_add_two_pi'`, `dist_frame`, `ringPt_frame`, `norm_sq_eq_re_im`, `e_hex_re_im`.
Step 6 is `hex_cones_of_serve` (no colour serves two consecutive directions alone, against step 4). Read against the informal claim (FS114-BV-HEX):
"the regular hexagon of kept points cannot occur at a cubic trichromatic `u` of a valid map (unit arcs allowed) when `x_1, …, x_6` are cubic" —
**same** (the statement's widening G-BVHEX — every `k`, H at the six points, `B̄(u, 1)` — holds as stated).

With `bv_hex`, `p17_ua` and `BaseCtx.hex_base` are kernel theorems, and **`row134BaseUA` rests only on the planar job's three** (`retArcs_nested`,
`exists_endpoint`, `exists_eleventh`).

**`l3_base`'s docstring** (item 330's correction) now names its inputs as the proof uses them (`exists_pseudoCircle`, `pair_i`, `pair_ii`,
`exists_linkage`, `link_path`) and says that neither `linkage_dot_ne_zero` nor `bv_nd` is an input.

**Statements unchanged** (`tools/fs131_i5_stmt_check.py d61edefc`: PASS). New names collision-free on `fs131-w5p`, `fs131-w5c`, `fs131-w4`, `main` as
full names (`git grep`); `main` has `HadwigerNelson.Plane.dist_frame` (wave 2's `MaximalCover`), a different full name from mine
(`HadwigerNelson.Plane.ArcMap.dist_frame`) — renamed `dist_eFrame` at the next stage to keep `open ArcMap` unambiguous after the merge.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 5 modules rebuilt (`HexRing`, `Dense`, `BaseWalk`, `BaseDense`, `Proofs`), 8 with
warnings, every warning `declaration uses 'sorry'`**, exit 0 (`build/gate/build/20261005T051518Z-1601427.log`; driver log `data/fs131/i5j/build-stage31.log`).
Wave 5's sorry declarations (distinct sites in the gate log): **23** (`HexRing` 4: `rot_out`, `rot_in`, `bv_l3`, `bv_nd`), mine 5. Axioms
(`data/fs131/i5j/I5jAxioms31.lean` → `.out`, read against the build's oleans): `bv_hex`, `hex_regular`, `p17_ua`, `BaseCtx.hex_base` and the 20 children
on the standard three; controls `rot_out` and `row134BaseUA` read `sorryAx`, `linkage_dot_ne_zero` clean. `scripts/Axioms.lean`: the 20 children added to
the "FS131-I5g" block (a comment line names this stage), above the `=== PURCHASED ===` banner. `tools/check_architecture.py`: PASS.

**Re-pricing from the first two hard leaves** (`coneAt_of_cubic` with `hex_regular`, then `bv_hex`): about 60k and 90k tokens of context with three
iteration rounds each — the plan's M and M–H hold; the arithmetic count (planned "finite real arithmetic") was the expensive part of `hex_regular`.

## Stage 31 — SAVED

## Stage 32 — SAVED: `rot_out` proved (a kernel theorem); `dist_frame` renamed `dist_eFrame`

**`rot_out` is proved as stated** (FS112-ROTHEX, N2-ROT's outward row (A+, A−); `Plane/ValidMap/HexRing`). It is `hex_point` at the change point
`x = r(ψ)`: `rot_noThird` gives `c′(x) = {p, q}`, (A+) and (A−) are exactly `hex_point`'s two germ inputs, and H (no four colours at `x ∈ B̄(u, 2)`)
its colour bound — so `g` is the outward cone's colour, `P_cl(x) = {p, q, g}` (a clause added to `hex_point`'s conclusion), `g` fills the cone, and
`g`'s cone at `u` faces away from `x` (step 5). The tile clause is new: `x` is cubic trichromatic (three colours, no repeated colour by H), so a
`g`-tile `T` at `x` meets the `g`-sector of `x`'s chart, which holds an interior point of the outward cone beyond `ω(u)`; `T` with the sector is
connected and in the closure of `g`, so by validity against points of `g` near `u` every point of `T` is at distance at least `1` from `u`, and `T`
is open, so it misses `B̄(u, 1)`. New child: `dist_radial_hex` (the outward radial's distances, factored out of `hex_point`). Read against the
informal claim (FS110-N2-ROT's outward row, with unit arcs under H): "`x` carries `p`, `q` and one colour `g` of `u`; `g` fills the outward cone; every
`g`-tile at `x` misses `B̄(u, 1)`; `u`'s `g`-sector lies in the closed half-plane away from `x`" — **same**.

**`dist_frame` → `dist_eFrame`** (`main` has `HadwigerNelson.Plane.dist_frame`, wave 2's `MaximalCover`; distinct full names, but `open ArcMap` inside
`HadwigerNelson.Plane` would make the short name ambiguous after the merge). `scripts/Axioms.lean` updated, `dist_radial_hex` added to the block.

**Statements unchanged** (`tools/fs131_i5_stmt_check.py d61edefc`: PASS; `hex_point` is this job's own child, its conclusion widened by one clause and
its one consumer, `bv_hex`, updated). New names collision-free (`git grep` on `fs131-w5p`, `fs131-w5c`, `fs131-w4`, `main`).

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 5 modules rebuilt, 8 with warnings, every warning `declaration uses 'sorry'`**,
exit 0 (`build/gate/build/20261005T052713Z-1651689.log`; driver log `data/fs131/i5j/build-stage32.log`). Wave 5's sorry declarations (distinct sites):
**22** (`HexRing` 3: `rot_in`, `bv_l3`, `bv_nd`), mine 4. Axioms (`I5jAxioms32.lean` → `.out`): `rot_out`, `hex_point`, `dist_radial_hex`, `dist_eFrame`,
`bv_hex`, `hex_regular`, `rot_noThird` on the standard three; control `rot_in` reads `sorryAx`, `linkage_dot_ne_zero` clean.

## Stage 32 — SAVED

## Stage 33 — SAVED: the handoff (what is left of this half, and where it stands)

The working tree is clean at the stage-32 commit. `tools/check_architecture.py`: PASS (no module added; imports unchanged).

**What is left of my set (4)**, for wave 5's next implementer on this half (none is on `row134BaseUA`'s path, which now rests only on the planar
job's three):
- **`rot_in`** (M): the mirror of `rot_out` (stage 32). Children to add, each a mirror of a stage-31 lemma: `hex_side_far` (a germ in the closure of
  `p` whose points are **farther** than `1` from `x` — here the germ just counter-clockwise of `r(ψ + 60°)`, at chord `60° + t` — keeps the class of `p`
  near `x` outside `B(r(ψ + 60°), 1)`; same proof as `hex_side`, the two cases swapped); `hex_point_in` (the **inward** cone `{z : |z − r(ψ ± 60°)| < 1}`,
  which holds the inward radial `x − s e ψ`, `|·|² = 1 − s + s²` for `0 < s < 1`); `Valid.cone_re_nonpos_of_preconnected` (the mirror of
  `Valid.cone_re_nonneg_of_preconnected` with a point **nearer** than `1`, as `Valid.cone_re_nonpos_of_germ` mirrors `_nonneg_`); the tile clause
  mirrored (the tile with the `g`-sector reaches inside `ω(u)`, so all its points are within `1` of `u`, and `T` is open, so `T ⊆ B(u, 1)`).
- **`bv_nd`** (M–H): BASE-V § 1b.2 steps 2–4. H at `x₀`, `y₀` (no four colours, no repeated colour) makes each cubic or interior; step 2 is
  `hF.dist_lt_or_gt_of_isPreconnected` over the `α`- and `β`-sectors (the event's germs lie in the open regions, `GermIn … (F.region α)`); step 4 is
  the tangency identity `|a(s) − b(±s)|²` (`tools/base_v_linkage.py`, K3, K4), the frame lemmas `dist_eFrame`, `ringPt_frame`, `norm_sq_eq_re_im`
  of stage 31 serve its distances.
- **`bv_l3`** (H): I5g's note stands — with `RingProper` the rings are wave 3's `ringCircleColouring`s, `exists_linkage` and `link_path` apply as in
  `l3_base`, and `hdbl` is `pair_ii` (H on the circles) or `bv_nd`.
- **`exists_preBend`** (H): the strengthened bend (ruling 317 (b)), not attempted in this job; E4-BEND-UN not read here.

**Route notes** (from stages 31–32):
- A count over `3⁶` assignments is beyond `omega` (200000 heartbeats both as one call and as 729 split calls); a `Finset` card argument with small
  `omega` calls closes it (`hex_int_core`).
- `hex_point` packages BV-HEX's steps 1–3 and 5 at one point and serves both `bv_hex` and `rot_out`; its inward mirror is `rot_in`'s main child.
- `convert … using 2` on `GermPseudo` splits the angle sum (`ψ + jπ/3 + π/3` against `ψ + (j+1)π/3`) into wrong subgoals; rewrite the angle and the
  `ZMod 3` index first (`bv_hex`'s `hcw`, `hccw`).

**Drafts for the front page**: none — wave 5 is not at its gate.

## Stage 33 — SAVED

## Stage 34 — SAVED: FS131-I5m's readback

*FS131-I5m, wave 5's ninth implementer (Opus), resuming this record at its first unsaved stage (Stage 33 SAVED, `ad8ff032`; branch head `298a3c0b`).
Brief: `data/fs131/briefs/FS131-I5m-wave5.md` (main tree). My set (ruling 344 (b)): `rot_in`, then `bv_nd`, `bv_l3`, then `BaseDense`'s `exists_preBend`
over the strengthened-bend child (ruling 317 (b)) — 4 `sorry` declarations. Never `Terminal`, `cv_exists`, `disc1_local`, or the planar jobs' declarations.

### 34.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_i5_quote_check.py` (I5j's) on the brief: **12 quotations, 12 verbatim**, exit 0; `--plant` (one letter changed in the first quotation)
reports it MISMATCH, exit 0 under `--plant` only when caught.

| quotation (opening words) | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. …" | `CLAUDE.md` § Counter-priors | verbatim |
| "- **`rot_in`** (M): the mirror of `rot_out` (stage 32). …" | this record, Stage 33 | verbatim |
| "- **`bv_nd`** (M–H): BASE-V § 1b.2 steps 2–4. …" | this record, Stage 33 | verbatim |
| "- **`bv_l3`** (H): I5g's note stands — …" | this record, Stage 33 | verbatim |
| "- **`exists_preBend`** (H): the strengthened bend (ruling 317 (b)), …" | this record, Stage 33 | verbatim |
| "336. **FS131-I5j handed back** …" | `plans/FS131-close-inventory.md` item 336 | verbatim |
| "344. **Rulings on IMM2's held items, and its slot.** …" | the inventory, item 344 | verbatim |
| "317. **Rulings on I5f's questions, and its slot.** …" | the inventory, item 317 | verbatim |
| "226. **FS131-E4 done, harness ≈ 480k** …" | the inventory, item 226 | verbatim |
| "274. **Rulings on QA3's held items and the freed slot.** …" | the inventory, item 274 | verbatim |
| "**It may**: add children anywhere in the wave's modules — …" | `plans/FS131-w5-kernel-plan.md` § 10.2 | verbatim |
| "295. **Ruling: MERGE leaves wave 4; …" | the inventory, item 295 | verbatim |

Items 226, 274, 295, 317, 336, 344 read in full; I5j's Stages 30–33 and I5g's Stage 29 read; the kernel plan's §§ 3.2, 8.2, 10.2 read.

### 34.2 The as-given build (`298a3c0b`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1754 modules already
up to date, nothing built, 8 modules with warnings**, exit 0 (`build/gate/build/20261005T061811Z-1883588.log`; driver log
`data/fs131/i5m/build-stage34-asgiven.log`). Every warning is `declaration uses 'sorry'`: wave 5's `Terminal` 9, `HexRing` 3, `MapGraph` 3, `BaseWalk` 3,
`BaseDense` 3, `Dense` 1 (**22**, item 336's count; mine 4: `HexRing`'s `rot_in`, `bv_nd`, `bv_l3` and `BaseDense`'s `exists_preBend`), and wave 4's stale
`Contact` 3, `UnitArc` 5. `tools/fs131_i5_stmt_check.py d61edefc`: PASS.

## Stage 34 — SAVED

## Stage 35 — SAVED: `rot_in` proved (a kernel theorem)

**`rot_in` is proved as stated** (FS112-ROTHEX, N2-ROT's inward row (B+, B−); `Plane/ValidMap/HexRing`), as I5j's route note planned: the mirror of
`rot_out`. New children, each a mirror of a stage-31/32 lemma:
- `hex_side_far` (`hex_side` mirrored: a germ in the closure of `q` whose points are **farther** than `1` from `x` keeps the class of `q` near `x`
  outside `B(y, 1)`; the same connectedness argument, the two cases swapped);
- `Valid.cone_re_nonpos_of_preconnected` (`Valid.cone_re_nonneg_of_preconnected` mirrored, with a point of the set **nearer** than `1` to `y`, as
  `Valid.cone_re_nonpos_of_germ` mirrors `_nonneg_`);
- `dist_radial_hex_in` (the inward radial `x − s e φ` lies inside both neighbouring unit discs: `|·|² = 1 − s + s²`, `0 < s < 1`);
- `hex_point_in` (`hex_point` mirrored: under (B+) — the germ counter-clockwise of `r(φ + 60°)` pseudo-coloured `p`, at chord `60° + t` — and (B−),
  near `x` the inward cone `{z : |z − r(φ ± 60°)| < 1}` has one colour `c ∈ P_cl(u)`, `P_cl(x) = {p, q, c}`, and `c`'s cone at `u` lies in the closed
  half-plane toward `x`, along the inward radial; the radius is kept below `1/2` so the radial stays inside `ω(u)`).

`rot_in` itself is `rot_out`'s proof with the tile clause mirrored: `x` is cubic trichromatic (three colours, H); a `g`-tile `T` at `x` meets the
`g`-sector of `x`'s chart, which holds an interior point `v` of the inward cone inside `ω(u)` (`|v − u| < 1`); `T` with the sector is connected, in
the closure of `g`, and validity against points of `g` near `u` keeps every point of `T` within `1` of `u`; `T` is open, so a point at distance
exactly `1` would have a neighbour of `T` beyond `1` along `t − u` — so `T ⊆ B(u, 1)`. Read against the informal claim (FS110-N2-ROT's inward row,
with unit arcs under H; plan § 8.2): "`x` carries `p`, `q` and one colour `g` of `u`; `g` fills the inward cone (the directions `(150°, 210°)`);
every `g`-tile at `x` lies in `B(u, 1)`; `u`'s `g`-sector lies in the closed half-plane toward `x`" — **same**.

**Statements unchanged** (`tools/fs131_i5_stmt_check.py d61edefc`: PASS). New names collision-free (`git grep` of each full theorem name on
`origin/fs131-w5p`, `origin/fs131-w5c`, `origin/fs131-w4`, `main`: none).

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 5 modules rebuilt (`HexRing`, `Dense`, `BaseWalk`, `BaseDense`, `Proofs`), 8
with warnings, every warning `declaration uses 'sorry'`**, exit 0 (`build/gate/build/20261005T062507Z-1929717.log`; driver log
`data/fs131/i5m/build-stage35.log`). Wave 5's sorry declarations (distinct sites): **21** (`HexRing` 2: `bv_l3`, `bv_nd`), mine 3. Axioms
(`data/fs131/i5m/I5mAxioms35.lean` → `.out`, read against the build's oleans under a 12 GiB slot): `rot_in` and its four children, `rot_out` on the
standard three; control `bv_nd` reads `sorryAx`, `linkage_dot_ne_zero` clean. `scripts/Axioms.lean`: the four children added to the "FS131-I5g"
block (a comment line names this stage), above the `=== PURCHASED ===` banner. `tools/check_architecture.py`: PASS.

**Re-pricing (first leaf)**: `rot_in` took about 40k tokens of context and one iteration round (every child compiled first time from its mirror):
M holds, low.

## Stage 35 — SAVED

## Stage 36 — SAVED: `bv_nd` proved (a kernel theorem), and with it `bv_nd1`

**`bv_nd` is proved as stated** (FS114-BV-HEX's (BV-ND), `plans/BASE-V-verification.md` § 1b.2 steps 2–4; `Plane/ValidMap/HexRing`), with unit arcs and
at every `k`. The route, in the map's own terms (new children in brackets):
1. At each of `x₀ = r_{u₁}(φ)`, `y₀ = r_{u₂}(χ)` (H: no four colours, no repeated colour) a sector chart with at most three sectors of pairwise
   distinct colours [`exists_chart_of_noRep`, from `localSectors_disj`; the proof of `isCubicTrichromatic_of_three_of_noRep` without the count];
   the germ points of a colour near the point lie in that colour's sector [`IsSectorChart.exists_sector_of_region`].
2. Step 2 (first order): with `E = x₀ − y₀`, the germ of `ω(u₂)` on side `σ` sits at squared distance `1 + 2(1 + a)(1 − cos t) − 2 D sin t` from
   `x₀`, `D = ⟨σ i e χ, E⟩` [`sq_dist_germ`, an identity]; so the `α`-germ ahead of `y₀` (`D > 0`) comes within `1` of `x₀` and the `β`-germ behind
   goes beyond [`germ_dist_cmp_one`].
3. Validity along connected sectors: one `α`-point of `y₀`'s sector within `1` of `x₀ ∈ cl A₁` puts every pair of `cl A₁ × cl A₂` within `1`
   [`Valid.pair_le`]; one `β`-point beyond `1` puts every `β`-pair at `≥ 1` [`Valid.pair_ge`].
4. Step 3: with at most three sectors the `α`- and `β`-sectors are adjacent [`BranchGerms.next_adj`, by `decide` for `n ≤ 3`], so at each small
   distance `s` there is a point of both closures [`IsSectorChart.exists_shared`, from `mem_closure_sector_of_lt` and `e_nextDir`]; at `x₀` it lies
   on `ω(y₀)` (`≤ 1` and `≥ 1`), at `y₀` on `ω(x₀)`.
5. Step 4: two such points at the same `s ∈ (0, 1)` are `1 − s²` or `√(1 + 2s²)` apart, never `1` [`tangent_pair_ne_one`, real algebra in the
   frame of `E`]; the first contradicts the `β`-pairs, the second the `α`-pairs.

**What the proof reads** (recorded in `bv_nd`'s docstring): only `y₀`'s sense — the component of `ω(u₂)`'s velocity along `E` — and, at `x₀`, only
that both colours are carried there. The `DoubleEvent`'s first dot condition and the senses of `ω(u₁)`'s germs are not used (validity makes them
follow). A **generalization**, not stated as a theorem: BV-ND holds with the double event replaced by "`x₀` carries `α` and `β`, and `y₀` switches
`β → α` moving toward `x₀`". Read against the informal claim (BV-ND, plan § 8.2, G-BVND): "no double event at two points of the domain outside
`F(M) ∪ R(M)`, every `k`, any centres; with unit arcs, at cusps" — **same**. `bv_nd1` (proved over `bv_nd` by FS131-I5, stage 5) is now a kernel
theorem.

**Statements unchanged** (`tools/fs131_i5_stmt_check.py d61edefc`: PASS); `bv_nd`'s docstring gained the paragraph above. New names collision-free
(`git grep` on `origin/fs131-w5p`, `origin/fs131-w5c`, `origin/fs131-w4`, `main`, `origin/fs131-w5`: none).

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 5 modules rebuilt, 8 with warnings, every warning `declaration uses 'sorry'`**,
exit 0 (`build/gate/build/20261005T064038Z-2050688.log`; driver log `data/fs131/i5m/build-stage36.log`). Wave 5's sorry declarations (distinct sites):
**20** (`HexRing` 1: `bv_l3`), mine 2. Axioms (`I5mAxioms36.lean` → `.out`): `bv_nd`, `bv_nd1`, the nine children and `rot_in` on the standard three
(`BranchGerms.next_adj` on `[propext]`); control `bv_l3` reads `sorryAx`, `linkage_dot_ne_zero` clean. `scripts/Axioms.lean`: the nine children
added to the "FS131-I5g" block (comment line names this stage). `tools/check_architecture.py`: PASS.

**Re-pricing from the first two leaves** (`rot_in`, `bv_nd`): about 40k and 35k tokens of context, every child compiling within two rounds. The
plan's M and M–H hold, low; the cost of `bv_l3` and `exists_preBend` is in their new content (stage 37), not in iteration.

## Stage 36 — SAVED

## Stage 37 — SAVED: the linkage to first order (five children for `bv_l3`); `bv_l3` moved below `bv_nd`; the handoff

**Why `bv_l3` needs new content.** `l3_base`'s route transfers (I5g's note), except at one input: its double-event step `hdbl` is `pair_ii`, which
needs `u₁` cubic trichromatic (`pair_ii` reads `u₁`'s chart for "`d₁ ≠ d₂`"), and `bv_l3` has no sector hypothesis at `u₁`, `u₂` (cusps, double cusps,
any degree — plan § 8.2's read-back). So `hdbl` must go through `bv_nd`, which needs the senses of motion: the new content is the velocity reading
of the linkage. Its analytic core is proved here, as five children placed after `bv_nd1`, and **`bv_l3` (statement and `sorry` unchanged) is moved to
the end of the file**, below `bv_nd` and these children, so its proof can cite them:
- `linkage_first_order`: with `|r_{u₁}(a₀) − r_{u₂}(b₀)| = 1`, `E` their difference, `D₁ = ⟨i e a₀, E⟩`, `D₂ = ⟨i e b₀, E⟩`:
  `| |r_{u₁}(a) − r_{u₂}(b)|² − 1 − 2(D₁ sin(a − a₀) − D₂ sin(b − b₀)) | ≤ 3((a − a₀)² + (b − b₀)²)` (from `dot_ringPt_sub`, an identity);
- `linkage_cmp`: two motions that both lengthen the pair to first order (`s₁ D₁ > 0`, `s₂ D₂ < 0`) leave every nearby moved pair farther than `1`;
  both shortening, nearer (`half_le_sin`: `sin t ≥ t/2` on `[0, 1]`);
- `linkage_end`: at `D₂ = 0` (with `x ≠ u₂`, so `x = u₂ + 2 e b₀`) moving `y` never shortens the pair, so a lengthening motion of `x` takes every
  pair beyond `1`, whatever `y` does.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 5 modules rebuilt, 8 with warnings, every warning `declaration uses 'sorry'`**,
exit 0 (`build/gate/build/20261005T065125Z-2125030.log`; driver log `data/fs131/i5m/build-stage37.log`). Wave 5's sorry declarations: **20** (unchanged),
mine 2 (`bv_l3`, `exists_preBend`). Axioms (`I5mAxioms37.lean` → `.out`): the five children, `bv_nd`, `rot_in` on the standard three; control `bv_l3`
reads `sorryAx`, `linkage_dot_ne_zero` clean. `scripts/Axioms.lean`: the five children added to the "FS131-I5g" block (comment line names this
stage). Statements unchanged (`tools/fs131_i5_stmt_check.py d61edefc`: PASS; the checker matches by name within a file, so the move is invisible
to it, as it should be). New names collision-free on `origin/fs131-w5p`, `origin/fs131-w5c`, `origin/fs131-w4`, `main`. `tools/check_architecture.py`: PASS.

### What is left of this half (2), for the next implementer

- **`bv_l3`** (H; off the walk's path). The route, every input named:
  1. *Rings.* `C_i := ringCircleColouring hF hc_i hno_i g hg` with **one** `g : Fin 6 → ZMod 3` injective on `(coloursAt u₁)ᶜ = (coloursAt u₂)ᶜ`
     (`hsame`; `h3` makes it three colours); `hno_i : ∀ x, ¬ F.OnRingArc u_i x` from `RingProper`'s finiteness of `Γ ∩ ω(u_i)` (a lemma to write: a
     ring arc puts infinitely many points of `Γ` on the circle). No relabelling (`link_relabel`) is needed: both rings read through `g`.
  2. *`hgen`* (FS112-N3-PAIRS (i)'s place): two generic points off `Γ` at distance `1` with `L₁.f − L₂.f ≡ 0` have `g(col x) = g(col y)`, so one
     colour (`InjOn`; both colours absent at `u₁` by `not_mem_coloursAt_of_mem_sphere`), against validity (both interior). No `pair_i`.
  3. *No swap on `ω(u₂)`* (for the band): `RingProper`'s (ii) forbids two change points at distance `1` with one pair; an `IsSwap` gives two
     (the `LeftVal`/`RightVal` values turn into `GermIn … (region c)` because the ring's points near a change point are off `Γ`, hence interior).
  4. *The band* `3M + 1 ≤ D ≤ 3M + 2`: `l3_base`'s `hbandL`/`hbandR` verbatim (`hbig_of_noSwap`, `m0_const`, `D0_mod_ne`, `exists_T0_left/right`).
  5. *`hdbl`* (the new step). At `s₀` with both jumps `±1` and a pair condition: if `|y₀ − u₁| = 2`, `exists_linkage`'s turning clause. Otherwise
     take the one-sided sides of `φ` and `χ` at `s₀` (`link_val_left`, `link_val_right`) and a generic parameter in each one-sided neighbourhood (the
     bad set is finite, as `link_path`'s `hbad`), where `hgen` holds. Under P1 (`l₁ ≡ l₂`, `r₁ ≡ r₂`) the admissible (x-side, y-side) pairs before
     and after are `(l₁, r₂)`, `(r₁, l₂)`; under P2 (`l₁ ≡ r₂`, `r₁ ≡ l₂`) they are `(l₁, l₂)`, `(r₁, r₂)`. So: y on one side before and after ⟹
     `χ` turns (the conclusion); x on one side ⟹ y too ⟹ the same; otherwise both cross — in opposite senses under P1, the same sense under P2.
     For a crossing, with `D₁ = ⟨i e φ₀, E⟩`, `D₂ = ⟨i e χ₀, E⟩`: `D₁ = 0` forces `|y₀ − u₁| ∈ {0, 2}` (excluded: `y₀ = u₁` would give `t = 1`);
     `D₂ = 0` forces `x₀ = u₂ + 2 e χ₀`, and `linkage_end` makes the crossing of `x` impossible (on its lengthening side every pair is beyond `1`,
     against `|x(s) − y(s)| = 1`); a sign pattern where both motions lengthen or both shorten is refuted by `linkage_cmp` just after `s₀` (with
     `t₁ = |φ(s) − φ₀|`, `t₂ = |χ(s) − χ₀|` small by continuity); the remaining pattern is a `DoubleEvent`, refuted by `bv_nd` with H at `x₀`, `y₀`
     (`hH`): P2 with `D₁, D₂ > 0`: sides `ccw, ccw`, `α` the colour of `l₁`; P2 with `D₁, D₂ < 0`: `cw, cw`, `α` of `r₁`; P1 with `D₁ > 0 > D₂`:
     `ccw, cw`, `α` of `l₁`; P1 with `D₁ < 0 < D₂`: `cw, ccw`, `α` of `r₁`. (`linkage_dot_ne_zero` is not needed on this route.)
  6. *The rest*: `l3_base`'s two paths `[−θ_A, θ_A]`, `[θ_A, 2π − θ_A]`, the flips at `±θ_A`, the band at `P`'s partners and the closing `omega`,
     verbatim, with `C₂` for `C₂'`.
  Estimate: the `l3_base` copy is about 350 lines; steps 1, 3 and 5 are new, about 250 lines. H stands.
- **`exists_preBend`** (H): the strengthened bend (ruling 317 (b)) — not attempted; E4-BEND-UN (`plans/FS131-E4-derivation.md`) not read in this job.

**Route notes** (stages 35–37): the mirrors of stage-31/32 lemmas compile first time from a text substitution (`hex_side` → `hex_side_far` etc.); a
lemma placed in a scratch file importing an *upstream* module (`BaseSteps`) can be iterated while a build of `HexRing` runs; `omega` does not see
through `max n 1` after `simp` (state `ncard ≤ 1` by `exact` from `max 0 1`).

**Drafts for the front page**: none — wave 5 is not at its gate.

## Stage 37 — SAVED

## Stage 38 — SAVED (FS131-I5o): the readback, and the as-given build

*FS131-I5o, wave 5's non-`Terminal` lane (Opus), resuming this record at its first unsaved stage (Stage 37 SAVED, `1b4a75d8`; branch head `f33ef153`).
Brief: `data/fs131/briefs/FS131-I5o-wave5.md` (main tree). My set (ruling 358): merge `fs131-w5p` (at `5086e856`) into `fs131-w5` and check it; then
`bv_l3`, `exists_preBend` (over the strengthened-bend child, ruling 317 (b)), `disc1_local`. Never `Terminal`, `cv_exists`, `main`, `framePt → fromFrame`,
the gate, or any statement on either side of the merge.

### 38.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_i5_quote_check.py` (I5j's, run, not edited) on the brief: **13 quotations, 13 verbatim**, exit 0 (`data/fs131/i5o/quote-check-38.txt`);
`--plant` (one letter changed in the first) reports it MISMATCH (`quote-check-38-plant.txt`). The thirteen: `CLAUDE.md` § Counter-priors; inventory
items 358, 357, 349, 317, 226, 274, 295; this record's Stage 37 (the `bv_l3` and `exists_preBend` bullets); `Dense.lean`'s `disc1_local` docstring opening
and its statement line; the kernel plan § 10.2's "**It may**" line. Items 226, 274, 295, 317, 349, 357, 358 read in full; I5m's Stages 34–37 read; RS1's
Stage 29 on `fs131-w5p` (`plans/FS131-planar-implementation.md`) read.

### 38.2 The as-given build (`f33ef153`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1754 modules already
up to date, nothing built, 8 modules with warnings**, exit 0 (`build/gate/build/20261005T082731Z-2684723.log`; driver log
`data/fs131/i5o/build-stage38-asgiven.log`). Every warning is `declaration uses 'sorry'`: wave 5's `Terminal` 9, `MapGraph` 3, `BaseWalk` 3, `BaseDense` 3,
`HexRing` 1, `Dense` 1 (**20**, item 349's count), and wave 4's stale `Contact` 3, `UnitArc` 5. `tools/fs131_i5_stmt_check.py d61edefc`: PASS
(`data/fs131/i5o/stmt-check-38.txt`).

## Stage 38 — SAVED

## Stage 39 — SAVED (FS131-I5o): `fs131-w5p` merged (the planar chain); checked

`git merge --no-ff origin/fs131-w5p` (at `5086e856`; merge base `0db34854`) into `fs131-w5` (at `956c1cd2`). Git auto-merged `Proofs.lean`, `BaseDense`,
`BaseWalk` and brought `MapGraph`, `MapTopology`, `CurveGraph`, `PlaneTopology`, `Thomassen` and `fs131-w5p`'s `data/`, `plans/`, `tools/` files; two
conflicts, each **keep both sides**, nothing more:
- `ARCHITECTURE.md` (the module table): classified row by row against the merge base, **no row changed on both sides** (ours changed `BaseSteps`, `BrickMap`,
  `Contact`, `Cor3`, `Dense`, `FlankUA`, `HexRing`, `Terminal`, `UnitArc`; theirs `BaseWalk`, `MapGraph` and the new `CurveGraph`, `PlaneTopology`,
  `MapTopology`, `Thomassen`); each row taken from the side that changed it, `MapTopology` and `Thomassen` placed before `MapGraph` as theirs orders them;
  checked by script: 239 rows = 235 ours + 4 new, every row equal to its changed side.
- `scripts/Axioms.lean`: both sides appended a block at the end of the CLEAN section (ours FS131-IC1 … I5m; theirs FS131-IX1 … RS1); both kept, ours
  first; the merged `#print axioms` lines equal the union of both parents' (3099), no duplicate.

### 39.1 The checks

- **(a) Statements, byte for byte** — new tool `tools/fs131_i5o_merge_check.py BASE OURS THEIRS`: every declaration of `BaseWalk`, `BaseDense`, `MapGraph`,
  `MapTopology`, `CurveGraph`, `PlaneTopology`, `Thomassen` in either parent (a theorem up to its `:=`, any other declaration whole), three-way against
  the base, must appear in the merge identical to the side that changed it (a key changed on both sides is a CONFLICT); and every `.lean` file only one
  side changed must equal that side's file. **PASS: 504 declaration keys, 0 conflicts, 17 one-sided files byte-equal** (`data/fs131/i5o/merge-check.txt`).
  `--self-test`: a hypothesis added in `BaseWalk`, `cvb_thom_reduced` renamed, a line appended to `HexRing` — each FIRED, the unplanted run PASS
  (`merge-check-selftest.txt`). Also `tools/fs131_i5_stmt_check.py d61edefc`: PASS (`stmt-check-39.txt`).
- **The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 448 of 448 batches, 8 modules rebuilt (`Thomassen`, `PlaneTopology`, `CurveGraph`, `MapTopology`,
  `MapGraph`, `BaseWalk`, `BaseDense`, `Proofs`), 6 with warnings, every warning `declaration uses 'sorry'`**, exit 0, 9 min 20 s
  (`build/gate/build/20261005T083032Z-2697877.log`; driver log `data/fs131/i5o/build-stage39-merge.log`). `tools/check_architecture.py`: PASS.
- **(b) Axioms** (`data/fs131/i5o/I5oAxioms39.lean` → `.out`, against the merged build's oleans, 12 GiB slot): **on the standard three** —
  `BaseCtx.retArcs_nested`, `BaseCtx.exists_endpoint`, `BaseCtx.exists_eleventh` (`BaseWalk`'s planar three), `BaseCtx.false`, **`row134BaseUA`**,
  `exists_unenclosed_or_bad`, `cvb_thom_reduced`, `cvb_thom`, `cvb_pinch_connected`, `cvb_hole_disconnected` (`MapGraph`'s three leaves and their consumer),
  `IsBoundaryWalk.sep`, `filledGraph_ringList`, `filledGraph_planarLike`; **controls on `sorryAx`**: `exists_preBend`, `bv_l3`, `localDense` (it rests on
  `n3_base` → `exists_preBend`).
- **(c) `sorry` by file** (`grep -cw sorry`; `data/fs131/i5o/sorry-counts-39.txt`), before (`f33ef153`) → after: `BaseWalk` 3 → 0, `BaseDense` 3 → 2
  (`exists_preBend`, `cv_exists`), `MapGraph` 3 → 0, `HexRing` 1 → 1, `Dense` 1 → 1, `Terminal` 9 → 9; `MapTopology`, `CurveGraph`, `PlaneTopology`,
  `Thomassen` 0. **Wave 5: 20 → 13** (`Terminal` 9 — the other lane's; mine: `bv_l3`, `exists_preBend`, `disc1_local`; `cv_exists` the `Terminal` lane's).
  Wave 4's stale copies unchanged (`Contact` 3, `UnitArc` 5).

**`row134BaseUA` is a kernel theorem on this branch** (with the planar chain and E4-RIM; `n3_base` still waits on `exists_preBend`). Statements unchanged on
both sides; no `axiom`, no `native_decide`. The merge commit is made with `git commit -i <paths>` (a merge cannot be a partial commit; `-i` names the
resolved paths explicitly, standing rule 6's intent).

## Stage 39 — SAVED

## Stage 40 — SAVED (FS131-I5o): `disc1_local` proved (a kernel theorem)

**`disc1_local` is proved as stated** (FS112-DISC1 on a fragment, `Plane/ValidMap/Dense`), by FS106-TS-T's argument read on one closed square (order changed
by ruling 360 (c): `disc1_local` before `bv_l3`). New declarations, all in `Dense` (names collision-free on `HEAD`, `origin/fs131-w5c`, `origin/fs131-w4mm`,
`origin/main`):
- `IsRegOf` (a region of a family of classes: `AeProperRegions.IsRegion` with the classes given directly), with `IsRegOf.subset`, `.isPreconnected`,
  `.chain_step`, `.dist_lt_one`, and `unitPairsNull_of_dist_ne_one`; two spec examples (the plane is a region of `univ`; `∅` is not a region);
- `exists_three_le_multicolour_square`: open classes with no unit pair inside a class, **dense and locally finite only at the points of a closed square of
  side `s > 1`**, have a point of the square in three class closures. The proof is `AeProperRegions.exists_three_le_multicolour`'s, transformed by script
  (`R.cls` → `cls`, `R.IsRegion` → `IsRegOf cls`, the global local finiteness chosen only at points of the square, `R.dense p` → the hypothesis at `p`);
- `ArcMap.exists_three_le_coloursAt_square`: a valid map whose domain holds such a square has a point of at least three colours in it (density by
  `dense_interiorPts`, local finiteness by `finite_tiles_near`, both at domain points; `region_locallyFinite`'s argument with `hx : x ∈ F.dom`);
- `ArcMap.closedSquare_subset_closedBall`: the square of side `6/5` about `x` lies in `B̄(x, 1)` (half-diagonal `3√2/5 < 1`).
`disc1_local`: the square of side `6/5` about `x` is in `B̄(x, 1) ⊆ F.dom`, so it holds a point of three colours. Read against the informal claim (FS129-OR1-
LOCALDENSE's reading of FS112-DISC1: "a valid fragment covering `B̄(x, 1)` has a point of at least three colours in `B̄(x, 1)`") — **same**; the route differs
from the docstring's quoted FS129 wording (nested tiles), which the docstring keeps as the row's own words (a `--` comment in the proof says so). Strictly
more is true by the proof: the point lies within `3√2/5` of `x`, for any valid fragment whose domain holds that square.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 448 of 448 batches, 4 modules rebuilt (`Dense`, `BaseWalk`, `BaseDense`, `Proofs`), 5 with warnings
(`Dense` has none now), every warning `declaration uses 'sorry'`**, exit 0, 8 min 43 s (`build/gate/build/20261005T084436Z-2794592.log`; driver log
`data/fs131/i5o/build-stage40.log`). Axioms (`I5oAxioms40.lean` → `.out`): `disc1_local` and its nine children on the standard three; control `bv_l3` on
`sorryAx`. `scripts/Axioms.lean`: the eight new theorems added under "-- FS131-I5o (stage 40)" after I5m's stage-37 lines. `tools/fs131_i5_stmt_check.py
d61edefc`: PASS; `tools/check_architecture.py`: PASS. Wave 5's `sorry` declarations: **12** (mine left: `bv_l3`, `exists_preBend`).

## Stage 40 — SAVED

## Stage 41 — SAVED (FS131-I5o): the strengthened bend stated (scratch, elaborated); notes for its construction and for `exists_preBend`; `bv_l3`'s placement; two of `bv_l3`'s steps compiled

### 41.1 The strengthened bend, as stated (rulings 359–360, 363–366)

`data/fs131/i5o/BendCollar.lean` (imports `Chain`; elaborates, one `sorry`; **not in the library** — `exists_preBend` stays `sorry`, so the statement would
be an unused leaf): `ArcMap.bend_toward_collar`. Hypotheses: `F.Valid`; `F.IsRingArc P θ₁ θ₂ c c'` with `c' ∉ F.coloursAt P`; `θ₂ − θ₁ < 2π`; **`hmax`** (no
ring arc at `P` with the same sides strictly contains `α`, as sets); **`hfree`** (near each point of `α°`, `Γ ⊆ ω(P)`); `ε > 0`. Conclusions: `M` and a
homeomorphism `h : ℂ ≃ₜ ℂ` with `M.Valid`, `M.dom = F.dom`; `h = id` off `thickening ε α`; `h` fixes every point of `F.Γ` off `α°`; `h` carries interior points to
interior points of the same colour; hence (stated) `M.coloursAt (h z) = F.coloursAt z`, `M.HasDegree (h z) n ↔ F.HasDegree z n`, `M.HasRepeatedColour (h z)
↔ F.HasRepeatedColour z`; **R1** every ring arc of `M` is one of `F` with the same sides; **R2** every ring arc of `F` whose open arc misses `α°` is one of `M`;
**R3** no point of `α°` is on a unit arc of `M` at `P`; and **no new inert arc** (`M.Inert Q a b → F.Inert Q a b`).

**Read back against E4-BEND-UN** (`plans/FS131-E4-derivation.md`, its derivation block and § Argument): E4's "the toward-bend of a whole inert unit arc …
with its lens chosen inside a collar of the arc in its inner tile" — the child bends a whole maximal constant-sided arc whose outer colour is absent at `P`
(the toward bend's own hypothesis; inert is stronger, and is what `exists_preBend` supplies); E4's "uses only: that the bend is induced by a homeomorphism of
the plane supported in a small neighbourhood of the lens's closure, fixing the arc's ends, carrying each old tile onto the new tile of the same index" — the
`h` clauses (support in `thickening ε α`, the ends and all of `Γ ∖ α°` fixed, interior points and colours carried point by point, which is "each old tile
onto the new tile of the same index"); E4's conclusion "keeps `Unenclosed u`" — follows from the `h` clauses (a homeomorphism carries bounded components of
`ℂ ∖ cl T` to bounded components of `ℂ ∖ cl h(T)`; `h u = u` because `u ∈ Γ ∖ α°`), not stated as a clause: the iteration derives it. **Beyond E4**: the
transport of colours, degrees and repeated colours (`exists_preBend`'s docstring: "no point gains a colour or a sector"), and R1–R3 with no new inert arc,
which the iteration's measure needs (§ 41.3). **Same**, with those additions.

### 41.2 Notes for the construction job (the collar bend)

1. **Why `bendMap` cannot give the collar** (wave 4, `UnitArc` on `main`, `bendMap P θ₁ θ₂ a L j`): the bent map has exactly one new `Arc` `a` through both
   ends `A = r(θ₁)`, `B = r(θ₂)`, and the lens is bounded by `α` and `a`. Two distinct circles (or a circle and a line) through `A` and `B` cross
   transversally at `A`, so every `bendMap` lens has a positive opening angle at each tip. **The horn end**: the inner tile's sector at `A` beside `α` is
   bounded by `α` and the next ray `ρ` of `Γ` at `A`; if `ρ` is tangent to `α` at `A` (an internally tangent circle, curvature `κ_ρ > 1` — the only arcs that
   can be tangent to `ω(P)` at `A` on the inner side: a segment or a circle of curvature `< 1` tangent at `A` lies outside `B(P, 1)` near `A`), the sector is a
   horn of width `O(t²)` and no positive-angle wedge fits in it. Main's crescent then swallows the horn's tip and a wedge of the tile beyond `ρ`: at `A` with
   colours `{c, c', d}`, `c` can be lost at `A`, and `a` crosses `ρ`, making new vertices. So the collar needs a lens bounded by several arcs.
2. **The construction in mind.** (a) *The lens boundary*: at a horn end, a circle arc through `A` tangent to `α` with curvature strictly between `1` and `κ_ρ`
   — it lies strictly between `α` and `ρ` near `A` (second order); at a transversal end, a circle arc through `A` at an angle smaller than the sector's; in
   the middle, an arc inside the collar; the joins inside `T_in` (corners are degree-2 points with colours `{c, c'}`, harmless). So `bendMap` generalized to a
   finite set of new arcs. (b) *Validity*: for a small crescent parameter `d`, the collar lens can be chosen inside main's crescent `L` (its tips lie in `L`'s
   wedge, its middle under `L`'s depth), so main's clearness (`IsClear c'` on `L`) and "no unit pair inside `L`" apply to the subset. (c) *The homeomorphism*:
   a radial push in polar coordinates about `P`, `h(P + ρ e(θ)) = P + ψ_θ(ρ) e(θ)` for `θ ∈ (θ₁, θ₂)`, `ψ_θ` a piecewise-linear homeomorphism of
   `[1 − w_in(θ), 1 + w_out(θ)]` fixing the ends and sending `1 ↦ 1 − ℓ(θ)`, the identity elsewhere; `w_in`, `w_out` are collar widths in `T_in`, `T_out`
   (`→ 0` at an end whose sector on that side is a horn), `ℓ < w_in` the lens depth (`ρ = 1 − ℓ(θ)` is the lens boundary). Continuity at the ends needs `w, ℓ →
   0` there; bi-Lipschitz near the ends if `ℓ/w_in` stays bounded away from `1`, which is what transporting sector counts (metric: balls) needs.
   (d) *The collar exists* along `α°` by `hfree` and local finiteness (a uniform strip over each compact sub-arc of `α°`), and at the ends inside the two
   sectors beside `α`.
3. **"No new inert arc" holds — the validity argument** (my first report said otherwise; corrected, items 365–366). Colours change only at points of `α°`
   (`{c, c'} → {c'}`), of the lens (`{c} → {c'}`) and of the new boundary (`{c} → {c, c'}`: a gain, harmless). Let `β ⊆ ω(Q)` be a unit arc with `Q ∈ α°`. Near
   `Q` the colour `c` fills an open half-disc `H` on `α`'s inner side. If `c` lay on β's inner (outer) side: `x = Q + δn ∈ H`, `y = Q + (1 ∓ η)e(t)` on β's `c`
   side, `|x − y|² − 1 = ∓2η − 2δ⟨e(t), n⟩ + O(δ² + η² + δη)`; for every `t` but the one normal direction some `n ∈ H` gives the needed sign, and the
   intermediate value theorem in `η` gives two `c`-points at distance exactly `1` — against validity. So a unit arc centred on `α°` never carries `c` on a side;
   non-inert in `F`, it carries `c'`, which `Q` keeps. A centre in the lens has a whole `c`-disc around it: the same argument excludes `c` on any side. With R1
   (sides kept), nothing becomes inert.
4. **The fake-boundary vertex — and why `exists_preBend` never meets it.** If an arc `δ` of `Γ` meets `α` at an interior point `x` (crossing, tangent, or
   ending there), constant sides force `δ` to have one colour on both sides near `x` (a crossing needs `c = c'`; a tangency from inside needs `c` on both sides of
   `δ`); near `x`, `cl T_in` is two cusps pinched at `x`, not `α° × [0, 1)`, and a homeomorphism fixing `Γ ∖ α°` cannot move `α°` off a crossing point
   (`h(x) = x` by continuity along `δ`). **But such an `x` is a repeated-colour point** (`c` or `c'` has at least two sectors at `x`), and `α° ⊆ B̄(u, 2)` (`P ∈
   B̄(u, 1)`), so `BaseHyp u` excludes it; likewise `c = c'` makes every point of `α°` a repeated-colour point. So under the base's hypotheses `hfree` follows
   from `BaseHyp u` and local finiteness (arcs not through `x` keep a positive distance), and `c ≠ c'`. In a general map, splitting `α` at the finitely many
   such vertices (each piece is constant-sided with a free interior, but not maximal — R2 then needs the piece's ends, interior points of `α`, handled: the
   remaining piece of `α` stays a ring arc because sides are read only at interior points) or pinching the lens at them would be needed; `exists_preBend`
   does not need either.
5. **The `Covers u 2` edge**: `α ⊆ B̄(u, 2)` may touch `∂B̄(u, 2)` (when `|P − u| = 1`); the domain is open and contains `B̄(u, 2)`, so `thickening ε α ⊆ F.dom`
   for small `ε`, and the collar lives in the domain; bad points outside `B̄(u, 2)` are fixed by `h` (they lie in `Γ ∖ α°`), so `BaseHyp u` is kept.
6. **Full circles** (`hlen`): a whole inert circle `ω(P) ⊆ Γ` has no ends; it needs its own case (an annular lens bounded by a concentric circle of radius
   `1 − δ`, a radial push with no end conditions).

### 41.3 `exists_preBend` over the child — the route (not formalized this job)

Strong induction on **`N(F)` = the number of maximal constant-sided unit arcs (any sides) centred in `B̄(u, 1)`** — a finiteness child to state: finitely many
arcs of `F.arcs` meet `B̄(u, 2)` (local finiteness on a compact set), each positive-length unit arc of `Γ` lies on one of their circles, and the
constant-sided maximal sub-arcs on each are finitely many (their ends are among finitely many break points); with it, every ring arc lies in a maximal one.
Step: if no inert arc is centred in `B̄(u, 1)`, stop (`M = F`). Else extend one to its maximal ring arc `α` (same sides, same centre, so inert), check
`hlen` (else the full-circle case), `hmax`, `hfree` (§ 41.2 item 4 from `BaseHyp u`), choose `ε` with `thickening ε α ⊆ F.dom` and `u ∉ thickening` unless
`u ∈ {A, B}` (in either case `h u = u`: `u ∈ Γ ∖ α°`, since `u` has three colours and points of `α°` two), and bend. Invariants: `Valid`, `Covers u 2`
(same domain), `IsCubicTrichromatic u` (colours and degree at `h u = u`), `BaseHyp u` (bad points of `M` are `h`-images of bad points of `F`, which are in
`Γ ∖ α°`, so fixed), `UnenclosedC u` (homeomorphism invariance, § 41.1). **The count drops**: a maximal ring arc `β` of `M` is a ring arc of `F` (R1), inside a
maximal `γ` of `F`; `γ ≠ α` (R3 and `β` of positive length); `γ°` misses `α°` (same centre: overlapping maximal arcs with the same sides merge; other sides
cannot overlap; another centre: `hfree`); so `γ` is a ring arc of `M` (R2) and `β = γ` by maximality in `M` — an injection into `F`'s maximal arcs minus `α`.
At the end no inert arc is centred in `B̄(u, 1)`: `NoInertNear u`. Children to state with it: the finiteness child, `hfree_of_baseHyp`, the full-circle bend.

### 41.4 `bv_l3`: its placement blocks the route as written

`bv_l3` is in `Plane/ValidMap/HexRing`, which imports neither `Plane/RingBand` (`ringCircleColouring`, the band lemmas `hbig_of_noSwap`, `m0_const`, `D0_mod_ne`,
`exists_T0_left/right`) nor `Plane/ValidMap/BaseWalk` (`exists_linkage`, `link_path`, `link_val_left/right`, `l3_base`'s argument); `HexRing` is upstream of
`BaseWalk` (`BaseWalk → Dense → HexRing`), so I5m's route (Stage 37) cannot be written in `HexRing`. **Nothing consumes `bv_l3`** (`git grep`: docstrings only).
Proposal for a ruling: move `bv_l3`, statement verbatim, to the end of `BaseWalk` (after `l3_base`) or to `BaseDense`; I5m's linkage children stay in `HexRing`
(`BaseWalk` sees them). A move-aware statement check is needed (the lane's `fs131_i5_stmt_check.py` matches by name within each file; I5e's
`fs131_i5_cor3_move.py` is the model). And a shorter route than copying `l3_base` (about 350 lines): extract its band-and-linkage argument into one lemma over the
two inputs that differ — `hgen` (generic pairs not `0 mod 3`) and `hdbl` (a double switch makes `χ` turn) — so `l3_base` and `bv_l3` are each a short proof
over it.

**Two of `bv_l3`'s new steps, compiled** (`data/fs131/i5o/RingScratch.lean`, importing `RingBand` and `HexRing`; elaborates with no `sorry`; ready for
`bv_l3`'s new home): `not_onRingArc_of_finite` (step 1: a ring meeting `Γ` finitely carries no arc of `Γ` — from `RingProper`'s first clause);
`ringCircle_val_germ` (the bridge: a one-sided value of `ringCircleColouring` is a germ of the map in one absent colour's class, sent to that value by `g`);
`ringCircle_noSwap` (step 3: a proper ring has no swap point — a swap gives two change points at distance `1` with one pair, against `RingProper`'s second
clause; the two values differ because the clockwise germs are `1` apart). Left for `bv_l3`: step 2 (`hgen` through one `g` on both rings), step 5 (`hdbl`
by the velocity reading, I5m's children), and the band-and-linkage argument (steps 4 and 6).

## Stage 41 — SAVED

## Stage 42 — SAVED (FS131-I5o): the hand-back

### Theorems this phase proved (FS131-I5o)

- `HadwigerNelson.Plane.ArcMap.disc1_local` (FS112-DISC1 on a fragment) — [kernel], `[propext, Classical.choice, Quot.sound]` — `Plane/ValidMap/Dense`
- `HadwigerNelson.Plane.exists_three_le_multicolour_square` (FS106-TS-T on a square, classes given directly) — [kernel], standard three — `Dense`
- `HadwigerNelson.Plane.ArcMap.exists_three_le_coloursAt_square` (TS-T on a square inside a fragment) — [kernel], standard three — `Dense`
- `HadwigerNelson.Plane.ArcMap.closedSquare_subset_closedBall` — [kernel], standard three — `Dense`
- `HadwigerNelson.Plane.IsRegOf.subset`, `.isPreconnected`, `.chain_step`, `.dist_lt_one`, `HadwigerNelson.Plane.unitPairsNull_of_dist_ne_one` — [kernel],
  standard three — `Dense`
- By the merge (proved on `fs131-w5p` by the planar jobs; on the standard three on this branch's merged build, Stage 39): `row134BaseUA`, `BaseCtx.false`,
  `BaseCtx.retArcs_nested`, `BaseCtx.exists_endpoint`, `BaseCtx.exists_eleventh`, `exists_unenclosed_or_bad`, `cvb_thom_reduced`, `cvb_thom`,
  `cvb_pinch_connected`, `cvb_hole_disconnected`, `IsBoundaryWalk.sep`, `filledGraph_ringList`, `filledGraph_planarLike`.
- Compiled in scratch only, not in the library (no audit): `not_onRingArc_of_finite`, `ringCircle_val_germ`, `ringCircle_noSwap`
  (`data/fs131/i5o/RingScratch.lean`); stated with `sorry`: `bend_toward_collar` (`data/fs131/i5o/BendCollar.lean`).

**Left in my set (2)**: `bv_l3` (needs a ruling on its module, § 41.4; route and two steps ready), `exists_preBend` (over the collar bend, § 41.1–41.3; the
construction is its own job). **Drafts for the front page**: none — wave 5 is not at its gate.

## Stage 42 — SAVED

## Stage 43 — SAVED (FS131-KB2): the readback, and the as-given build

*FS131-KB2, the strengthened bend's construction (Opus), continuing this record from Stage 42 (`4a0e5c28`). Brief:
`data/fs131/briefs/FS131-KB2-bend.md` (main tree). My set (ruling 370 (d)): land `bend_toward_collar` (I5o's statement) in a module of its own upstream of
`BaseDense`, construct it, then `exists_preBend` over it. Never `HexRing`, `BaseWalk`, `Terminal`, `Dense`, `MapGraph`, wave 4's stale modules, `main`, or the
gate.*

### 43.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_i5_quote_check.py` (I5j's, run, not edited) on the brief: **15 quotations, 15 verbatim**, exit 0 (`data/fs131/kb/quote-check-43.txt`); `--plant`
reports 1 not verbatim (`quote-check-43-plant.txt`). The fifteen: `CLAUDE.md` § Counter-priors; `exists_preBend`'s first line (`BaseDense`); `bend_toward_collar`'s
first line (`data/fs131/i5o/BendCollar.lean`); E4-BEND-UN's index line; this record's § 41.2 items 1, 2, 6; inventory items 359, 360, 365, 366, 369, 370, 317;
the kernel plan § 10.2's "**It may**" line. Read in full: items 317, 359–370; this record's Stages 38–42; E4-BEND-UN's derivation block and § Argument
(`plans/FS131-E4-derivation.md`); `BaseDense` whole; the scratch child whole.

### 43.2 The as-given build (`4a0e5c28`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1758 modules already
up to date, nothing built, 5 modules with warnings**, exit 0 (`build/gate/build/20261005T085919Z-2876965.log`; driver log
`data/fs131/kb/build-stage43-asgiven.log`); every warning `declaration uses 'sorry'`. `tools/fs131_i5_stmt_check.py d61edefc`: PASS (`data/fs131/kb/stmt-check-43.txt`).

## Stage 43 — SAVED

## Stage 44 — SAVED (FS131-KB2): `bend_toward_collar` landed in `Plane/ValidMap/BendCollar`; the construction's design

### 44.1 The landing

`Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean` (new; imports `Chain`, `UnitArc`, `LocalStructure`), imported by `BaseDense`; added to
`Proofs.lean`, to `ARCHITECTURE.md` (a row before `BaseDense`, whose Imports cell gains it) and to `scripts/Axioms.lean` (after I5o's stage-40 lines).
`bend_toward_collar`, docstring and statement, **verbatim**: `tools/fs131_kb_stmt_move.py` (new) compares the block from `/--` to `:= by` in
`data/fs131/i5o/BendCollar.lean` at `4a0e5c28` with the module's, byte for byte, and checks the context lines (`namespace HadwigerNelson.Plane`,
`namespace ArcMap`, `variable {k : ℕ} {F : ArcMap k}`) and that one file under `Proofs/` declares it: **PASS** (`data/fs131/kb/move-check-44.txt`);
`--self-test`: a changed hypothesis, a changed docstring letter, a dropped `variable` line, a second declaring file — each FIRED, unplanted PASS
(`move-check-44-selftest.txt`). The scratch file is deleted (its content is in the library; the check reads it from `4a0e5c28`).

### 44.2 The statement read clause by clause (no defect found)

Before building, each clause was checked for an edge case that could make it false; none was found, and two facts shorten the construction:
- **`hlen` is implied, and full circles cannot occur**: `l60_le` (wave 4, proved on this branch) gives `θ₂ − θ₁ ≤ π/3` for every ring arc of a valid map,
  so § 41.2 item 6's full-circle case is empty (a whole circle would be a ring arc of length `2π`).
- **No new inert arc at a centre on `α°` is `lock`**: a unit arc of `M` centred at `Q ∈ α°` is one of `F`'s (R1); if `c` lay on a side, every interior
  point `x` of it would be in `cl(C_c) ∩ ω(Q)`, which `lock` (FS112-LOCK, proved here) confines to `{P, P + 2e(θ_Q)}` — two points. At a centre in the lens
  (an open set inside `C_c`) it is `Valid.dist_ne_one_of_isOpen_subset_closure`. Every other centre keeps its colours or only gains (`β°` gains `c'`).
- **R1/R2 reduce to the two ends**: with `β` built from circles of radius `≠ 1`, a unit arc in `M.Γ` meets `β` finitely, so lies in `F.Γ` (closed in the
  domain), misses `β°` (`β° ⊆` interior points of `F`) and `α°` (interior points of `M`); off `cl(supp h)` the maps agree; `cl(supp h) ∩ F.Γ = α`. So
  only a unit arc of `ω(Q)` through `A` or `B`, `Q ≠ P`, needs its sides compared, and there the collar near the end (the two sectors of the end's chart
  beside `α`, with `α`'s branch) is preconnected and misses `ω(Q)`, so it lies on one side of `ω(Q)`, and each side carries the same colours in `M` and
  `F` (`c` keeps `S_in ∖ cl L`, `c'` gains only on that side).
- **R3** is `α° ∩ M.Γ = ∅`; **degrees and repeated colours** need local structure only at interior points (degree 1), at `α°` (two germs of `ω(P)`),
  at `β°` (two germs, at a corner of two circles or on one circle) and at the ends.

### 44.3 The construction's design (D1; for the construction leaves)

- **The lens boundary `β`**: `C_A`, `C_B`, the circles of radius `R < 1` internally tangent to `ω(P)` at `A`, `B` (centres `P + (1 − R)e(θ₁)`,
  `P + (1 − R)e(θ₂)`), curvature `1/R`; `β` = the arc of `C_A` from `A` to their crossing `X` (on the ray at `θ_m = (θ₁+θ₂)/2`, by symmetry) and the arc of
  `C_B` from `X` to `B`. With `R > 1/2`, `P` is inside both discs, so each ray from `P` meets each circle once: `C_A` is the radial graph
  `t_A(θ) = (1−R)cos(θ−θ₁) + √((1−R)²cos²(θ−θ₁) + 2R − 1)`, and `β`'s radial function is `max(t_A, t_B)`; the depth of `β` below `α` is about
  `(1−R)(1 − cos(θ − θ_E))` (at most `(1−R)/2`), quadratic at the ends — so (i) at a horn end (the next germ inside tangent to `α`, curvature `κ > 1`) `C_A`'s
  germ `(β_α, 1/R)` fits between `α`'s germ `(β_α, 1)` and it once `1/R < κ`, and (ii) the depth is below main's toward profile `ψ · min(θ − θ₁, θ₂ − θ)`, so
  main's `toward_clear` argument (N2-SIGN, N2-ENV near and toward; `n2_env_*` are proved on this branch, `toward_clear` is main-only — ~30 lines to
  re-prove under a new name) makes every lens point clear for `c'`; `α°` points are clear by `ne1_region`; two points of `L ∪ α°` are `< 1` apart
  (angular width `≤ π/3`, radii `≤ 1`). Validity is then `Valid.of_agreesOff` on `U = cl L` (proved on this branch).
- **The push `h`**: along the rays from `P`, `h(P + t e(θ)) = P + ψ_θ(t) e(θ)` with `ψ_θ(t) = t − ℓ(θ) · tent_{a(θ), 1, b(θ)}(t)` (tent = 0 off
  `[a, b]`, 1 at `1`, linear between), `ℓ = 1 − max(t_A, t_B)` the lens depth, `a`, `b` the collar's inner and outer profiles (inner: the same two circles
  with a smaller radius `R' < R`, outer: the circles of radius `R'' > 1` tangent externally-containing at `A`, `B`); identity for `θ ∉ (θ₁, θ₂)`. Its
  inverse is `u ↦ u + ℓ · tent_{a, 1−ℓ, b}(u)`. Increasing since `ℓ < 1 − a`; continuous at the ends since `ℓ → 0` there. The collar is Γ-free but for
  `α°`: near each end by the end's chart (`localSectors_disj`; `α`'s germ `(θ_E + π/2, 1)` is one of the chart's, and the collar's germs lie strictly
  between its neighbours), in the middle by `hfree` and compactness.
- **The bent map**: `M.dom = F.dom`, `M.col = F.col ∘ h⁻¹`, `M.arcs` = F's arcs with the open arc cut out (main's `cutArcs` engine, ~150 lines, main-only:
  to re-prove under a new name, or to cite after the merge with `main`) and the two arcs of `β`. Then `M.Γ = h(F.Γ)`, so clauses 3–6 and
  `M.interiorPts = h(F.interiorPts)` follow, and `M`'s colour is locally constant through `h`.
- **Degrees at the ends**: `M`'s chart at `A` is `F`'s with `α`'s germ replaced by `C_A`'s (`isSectorChart_of`), so both have `max n 1` sectors, and the
  sector colours agree as lists (`α`'s outer neighbour sector becomes `S_out ∪ α ∪ L`, colour `c'`; the inner `S_in ∖ cl L`, colour `c`).
- **Price**: about 3,000–4,000 lines (geometry of the tangent circles and radial graphs ~600; the push ~400; the bent map ~400; collar freeness ~500;
  validity ~300; degrees ~700; R1/R2 ~500). Not attempted this job beyond the landing (budget: the job opened at about 340k by the harness's count
  after the readback).

### 44.4 The build

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — 448 of 448 batches, 3 modules rebuilt (`BendCollar`,
`BaseDense`, `Proofs`), 6 with warnings, every warning `declaration uses 'sorry'`** (new: `bend_toward_collar`), exit 0, 8 min 16 s
(`build/gate/build/20261005T091944Z-2965180.log`; driver log `data/fs131/kb/build-stage44.log`). `tools/fs131_i5_stmt_check.py d61edefc`: PASS
(`stmt-check-44.txt`); `tools/check_architecture.py`: PASS; `tools/fs131_kb_stmt_move.py` after the deletion: PASS.

## Stage 44 — SAVED

## Stage 45 — SAVED (FS131-KB2): `exists_preBend` proved over the collar bend and six named children

`exists_preBend`'s `sorry` is replaced by record § 41.3's iteration (statement unchanged): strong induction on `(G.maxRingArcs u).ncard`, each step
`exists_preBend_step`, which applies `bend_toward_collar` to the maximal extension of an inert arc and checks every hypothesis on the bent map. New, all in
`BaseDense` before `exists_preBend` (names collision-free on `HEAD`, `origin/main`, `origin/fs131-w5c`, `origin/fs131-w4mm` by `git grep`):
- `maxRingArcs F u` — the maximal constant-sided unit arcs centred in `B̄(u, 1)`, as sets; spec example: a map with no arcs has none.
- **`exists_preBend_step`** — proved over the children: the inert arc's maximal extension `α` (`exists_maxRingArc`), `hfree` (`hfree_of_baseHyp`), `hlen`
  (`l60_le`), `ε` with `thickening ε α ⊆ dom` (`IsCompact.exists_thickening_subset_open`); `h u = u` (`u ∈ Γ` by its three colours, `u ∉ α°` by
  `ncard_coloursAt_le_two_of_mem_openArc`, then clause 4); cubic trichromatic by clauses 6–7 at `u`; `BaseHyp u` (a point of `B̄(u, 2)` whose preimage lies
  outside it was moved, so lies in the thickening and off `Γ ∖ α°`, and not on `α° ⊆ B̄(u, 2)`: an interior point, one colour, no repeated colour);
  `UnenclosedC u` (`unenclosedC_of_homeomorph`, `K` the thickening); the measure drops (`maxRingArcs_subset_of_bend`, and `α` is one of `F`'s maximal arcs).
- **`not_hasRepeatedColour_of_mem_interiorPts`** — proved (near an interior point the one sector is a ball).
- Children left `sorry`, each stated with its route in its docstring: `finite_maxRingArcs` (the finiteness child), `exists_maxRingArc` (sup of ends),
  `hfree_of_baseHyp` (a third germ at `x ∈ α°` makes a repeated colour), `ncard_coloursAt_le_two_of_mem_openArc`, `maxRingArcs_subset_of_bend` (R1–R3,
  maximality, `hfree`), `unenclosedC_of_homeomorph` (E4-BEND-UN's argument).

So `n3_base`, `localDense`, `dense3` now rest on `bend_toward_collar` and these six, nothing else open (`row134BaseUA` is on the standard three).

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 448 of 448 batches, 2 modules rebuilt (`BaseDense`, `Proofs`), 6 with warnings, every warning
`declaration uses 'sorry'`**, exit 0, 8 min 20 s (`build/gate/build/20261005T093152Z-3016959.log`; driver log `data/fs131/kb/build-stage45.log`). `BaseDense`'s
`sorry` declarations: the six children (lines 320, 326, 335, 342, 365, 379) and `cv_exists` (the stale copy, the `Terminal` lane's); `exists_preBend` and
`exists_preBend_step` carry none of their own. **Axioms** (`data/fs131/kb/KBAxioms45.lean` → `.out`, 12 GiB slot): `not_hasRepeatedColour_of_mem_interiorPts` and
`row134BaseUA` on the standard three; controls on `sorryAx`: `exists_preBend_step`, `exists_preBend`, `n3_base`, `bend_toward_collar`. `scripts/Axioms.lean`: the
eight new theorems after the stage-44 line. `tools/fs131_i5_stmt_check.py d61edefc`: PASS (`stmt-check-45.txt`; `exists_preBend`'s statement unchanged);
`tools/fs131_kb_stmt_move.py`: PASS; `tools/check_architecture.py`: PASS.

## Stage 45 — SAVED

## Stage 46 — SAVED (FS131-KB2): the hand-back

### Theorems this phase proved (FS131-KB2)

- `HadwigerNelson.Plane.ArcMap.not_hasRepeatedColour_of_mem_interiorPts` — [kernel], `[propext, Classical.choice, Quot.sound]` — `Plane/ValidMap/BaseDense`
- `HadwigerNelson.Plane.ArcMap.exists_preBend` (FS112-N3-BASE's pre-bend, E4-BEND-UN's iteration) and `exists_preBend_step` — proved **over** `bend_toward_collar`
  and six stated children (`finite_maxRingArcs`, `exists_maxRingArc`, `hfree_of_baseHyp`, `ncard_coloursAt_le_two_of_mem_openArc`, `maxRingArcs_subset_of_bend`,
  `unenclosedC_of_homeomorph`); on `sorryAx` through them — not kernel theorems yet.
- Stated with `sorry`: `bend_toward_collar` (landed verbatim, `Plane/ValidMap/BendCollar`) and the six children.

**Left (the construction and six children)**: `bend_toward_collar`'s construction (design § 44.3, priced there at 3,000–4,000 lines) and the six children above
(each docstring names its route). **Drafts for the front page**: none — wave 5 is not at its gate.

## Stage 46 — SAVED

## Stage 47 — SAVED (FS131-M5): the readback, and the as-given build

*FS131-M5, wave 5's sync (Opus), continuing this record from Stage 46 (`caada347`). Brief: `data/fs131/briefs/FS131-M5-sync.md` (main tree). My set (ruling
379 (a)–(b)): merge `main` into `fs131-w5` (`main`'s side for every wave-4 module, `framePt → fromFrame` in wave 5's files, identical copies removed, checked),
then, as budget allows, four `BaseDense` children of `exists_preBend`. Never `main`, `BendCollar`'s statement, `HexRing`/`BaseWalk` beyond the merge,
`Terminal`, or the gate scripts' recorded counts.*

### 47.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_i5_quote_check.py` (I5j's, run, not edited) on the brief: **11 quotations, 11 verbatim**, exit 0 (`data/fs131/m5/quote-check.txt`); `--plant`
reports 1 not verbatim, exit 0 as the control expects (`quote-check-plant.txt`). The eleven: `CLAUDE.md` § Counter-priors; inventory items 379, 378, 318, 375,
358, 369; the first lines of `ncard_coloursAt_le_two_of_mem_openArc`, `unenclosedC_of_homeomorph`, `exists_maxRingArc`, `hfree_of_baseHyp` (`BaseDense` at
`caada347`). Read in full: items 318, 375–379; this record's Stages 39 and 43–46; ML1's Stage 14 (`fs131-w4mm`'s `plans/FS131-IMM-implementation.md`: it
took `main`'s side for every wave-4 module, restored two declarations by script, checked dupes before the merge with a new tool and statements three-way
with `tools/fs131_wl_mergestmts.py`).

### 47.2 The as-given build (`caada347`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1759 modules already
up to date, nothing built, 6 modules with warnings**, exit 0 (`build/gate/build/20261005T094501Z-3096603.log`; driver log `data/fs131/m5/build-asgiven.log`);
every warning `declaration uses 'sorry'`.

### 47.3 The ground before the merge

Merge base `111830c8`; this branch changed 319 files since, `main` 539; **both**: `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean`,
`Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean` — as the brief says. `sorry` by file (`grep -rcw`, `data/fs131/m5/sorry-counts-before.txt`):
`BaseDense` 7, `BendCollar` 1, `Contact` 3, `HexRing` 1, `Terminal` 9, `UnitArc` 5, and `Packed` 1 (a word in a docstring, not a term).

## Stage 47 — SAVED

## Stage 48 — SAVED (FS131-M5): `main` merged (wave 4, Woodall, MERGE); copies removed; checked; the build green

`git merge --no-ff --no-commit origin/main` into `fs131-w5` (at `e6ba8923`; one merge base `111830c8`). `origin/main` was **`1be5d622`** when the merge ran — `ddad786d` (the brief's) plus inventory item 380, `plans/` only (another session's fetch moved the shared ref); the commit subject's "ddad786d" is that slip, the merge's second parent is `1be5d622`, and every check below ran against it. Git took `main`'s side for every
wave-4 module by itself — this branch never touched `Basic`, `Contact`, `UnitArc` after the fork, so their stale copies (`Contact` 3 `sorry`, `UnitArc` 5)
were replaced by `main`'s proved files — and brought `Surgery`, `Cone`, `Moves`, `MergeMove`, Woodall's five modules, wave 2's and the Falconer modules.
`BaseSteps`, the one proof file both sides changed, merged clean: both deleted `n3_end` identically (this branch moved it to `Terminal`), and `main` added
`bowtie_not_isStuck_I`, `bowtie_not_isHorn_I_axis`. **No declaration this branch added to a wave-4 module** (it added none after the fork). Three conflicts,
each two blocks appended at one place, **kept both, ours first**: `Proofs.lean` (wave 5's thirteen imports; Woodall's five), `ARCHITECTURE.md` (wave 5's
fifteen rows; Woodall's five), `scripts/Axioms.lean` (wave 5's blocks; `Moves`' and later blocks).

### 48.1 The rename and the copies

- **`framePt → fromFrame`** in `FlankUA`, the only wave-5 file using it (29 occurrences, among them its own lemma names: `N_add_eq_framePt`,
  `S_add_eq_framePt`, `framePt_normSq_aux` → `…fromFrame…`), and their three records in `scripts/Axioms.lean`. After the merge `framePt` occurs only in
  wave 2's `Plane/Slack` (and its record `dist_framePt_sq`); no wave-5 module's import closure reaches `Slack`, so even a missed occurrence could not
  resolve to it. **Note for `fs131-w5c`**: its `HornShadow`, `Terminal`, `FlankUA` use `framePt` and need the same rename at their merge.
- **Copies.** New tool `tools/fs131_m5_dupes.py` (comments and docstrings stripped first, namespaces tracked, binder names alpha-normalized): every
  declaration of a file this branch changed since the fork, not declared at the fork, against every name and every theorem statement of `main`. Before
  the merge (`data/fs131/m5/dupes-premerge.txt`): **three NAME collisions and two STATEMENT copies**, each of a lemma new on `main` since the fork:
  - NAME `BranchGerms.next_injective` and `ArcMap.coloursAt_subset_of_mem_interiorPts` (`MapTopology` / `main`'s `Surgery`; statements equal up to binder
    names) — **deleted from `MapTopology`**, which now imports `Plane/ValidMap/Surgery` (adds `Cone`, `Surgery` to its closure, nothing else; no cycle); the
    uses (`MapTopology` 4, `MapGraph` 5) cite `main`'s unchanged.
  - NAME `e_mul_e_neg` (`PlaneTopology` / `main`'s wave-2 `Slack`, identical) — importing `Slack` would put ten wave-2 measure-theory modules under the
    planar chain's root, so **`PlaneTopology`'s copy is made `private`** (module-local: its name is mangled, no collision), its docstring naming `Slack`'s.
    The common home of both is `Plane/Basic` (beside `e_add`), a `main` file outside this job: a correction owed.
  - STATEMENT `unitPairsNull_of_dist_ne_one` (`Dense`, I5o's helper) = `main`'s `unitPairsNull_of_no_unit_pair` (`FalconerReduction`) — **deleted**; `Dense`
    imports `Plane/FalconerReduction` (adds `Cover`, `FalconerFan`, `UnitAvoiding`, `FalconerReduction`) and its one use cites `main`'s.
  - STATEMENT `branchPt_congr` (`CurveGraph`) = `main`'s `branchPt_congr_dir` (`Moves`) — importing `Moves` would put seventeen modules, all of wave 4's
    surgery, under the planar foundation, so **`CurveGraph`'s copy is made `private`**, its docstring naming `Moves`'. Common home: `Plane/LocalStructure`
    (where `branchPt` lives), a `main` file: a correction owed.
  - After the rename one more: STATEMENT `ArcMap.N_add_eq_fromFrame` (`FlankUA`) = `main`'s `normalPt_add_eq_fromFrame` (`UnitArc`, already in `FlankUA`'s
    closure) — **deleted**, its one use cites `main`'s.
  - The tool also reported a NAME `ArcMap.near` through QA1's parser (`tools/fs131_ml_dupes.py`, run before writing mine): a docstring line beginning
    "class near `y`" read as a `class` declaration on both sides — no declaration; mine strips docstrings and does not report it.
  - Records: the five ours-side `#print axioms` lines of the deleted or private copies removed (`next_injective`, `coloursAt_subset_of_mem_interiorPts`,
    `unitPairsNull_of_dist_ne_one`, `e_mul_e_neg`, `branchPt_congr`, and `ArcMap.N_add_eq_fromFrame`); `main`'s lines kept, none twice.
  - `ARCHITECTURE.md`: the Imports cells of `MapTopology` (+ `Plane/ValidMap/Surgery`) and `Dense` (+ `Plane/FalconerReduction`); `tools/check_architecture.py`
    failed on exactly those two before the edit (its control) and **PASS** after (`data/fs131/m5/arch-check.txt`).
  - Not removed (reported, `STATEMENT-OLD`, informational): `ArcMap.dist_sq_re_im` (`BaseWalk`) and `ArcMap.norm_sq_eq_re_im` (`HexRing`) repeat lemmas
    declared at the fork (`SixFragment`, `Chord`, `UnitArc`) — repeats the merge does not create, in files this job does not touch beyond the merge.
  - I5h's `isPreconnected_hornSet_unit` is not on this branch (it is `fs131-w5c`'s `HornShadow`): for that branch's merge.
- After: **`tools/fs131_m5_dupes.py`: 0 NAME/STATEMENT pairs**, 2 PRIVATE (the two module-local copies), 4 STATEMENT-OLD, 4 CONCL candidates read by hand (none
  a copy: `IsRegOf.dist_lt_one` vs `SVMap`'s `IsRegion.dist_lt_one` are different predicates; `Terminal`'s `flankQ_*_of_qrOnly` are the unconditional
  forms of `UnitArc`'s, by design) (`dupes-merged.txt`). `--plant` (a re-declared `main` name, `main`'s `isPreconnected_hornSet` statement under a new name,
  a docstring line "class e_mul_e_neg"): reports exactly the first two, exit 1 (`dupes-plant.txt`).

### 48.2 The checks

- **Files, byte for byte** — new tool `tools/fs131_m5_merge_check.py`: every file `main` alone changed equals `main`'s; every file this branch alone
  changed equals ours after the declared edits (each old text occurring exactly as often as declared); `BaseSteps` equals `git merge-file`'s clean merge;
  `Proofs.lean`'s imports and `scripts/Axioms.lean`'s records are the three-way merges of the sides' sets (ours' records renamed, the copies' dropped, the
  moved `n3_end` kept — a set-level merge would drop it: its line moved on our side, its old place deleted on `main`'s), none twice; `ARCHITECTURE.md`
  row by row three-way, up to the two Imports cells. **PASS, 1783 files** (`data/fs131/m5/merge-check-selftest.txt`). `--self-test`: a byte in `Surgery`, an
  extra line in `FlankUA`, a dropped import, a doubled record, a reverted Imports cell — each FIRED naming its file; the unplanted run PASS.
- **Statements, three-way** (`tools/fs131_wl_mergestmts.py HEAD origin/main --rename framePt=fromFrame`, WL1's, run): 7,126 names, 0 base conflicts,
  **6 reported, each this job's declared change**: `N_add_eq_fromFrame`, `next_injective`, `unitPairsNull_of_dist_ne_one` "merged {} expected {…}" (the
  deleted copies), `coloursAt_subset_of_mem_interiorPts` CONFLICT (added on both sides; `main`'s kept), `e_mul_e_neg` "merged 2 expected 1" (`Slack`'s and
  the private copy), `n3_end` "merged 1 expected {}" (moved to `Terminal` on this branch, statement verbatim; `main` deleted `BaseSteps`' copy)
  (`mergestmts.txt`). `--plant`: a seventh, `AeColouring.exists_fill`, exit 1 (`mergestmts-plant.txt`). `tools/fs131_i5_stmt_check.py d61edefc`: PASS
  (`stmt-check-48.txt`).
- **The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 455 of 455 batches, 44 modules rebuilt, 4 with warnings, every warning `declaration uses 'sorry'`**
  (`BaseDense`, `BendCollar`, `HexRing`, `Terminal`), exit 0, 14 min 31 s (`build/gate/build/20261005T100515Z-3256459.log`, "Build completed successfully
  (5788 jobs)"; driver log `data/fs131/m5/build-merge.log`).
- **Axioms** (`data/fs131/m5/M5Axioms48.lean` → `.out`, 12 GiB slot, against the merged build): **on the standard three** — wave 4's seven leaves this branch
  carried as stale `sorry`: `exists_shave`, `exists_rayMerge`, `exists_merge`, `bend_toward`, `flankQ_upper`, `flankQ_lower`, `nb4p` (`bend_away` is deleted
  on `main`, unused here); the consumers of the renamed and de-duplicated declarations: `S_add_eq_fromFrame`, `fromFrame_normSq_aux`, `horn_radial_N`,
  `horn_radial_S`, `exists_ball_two_tiles`, `exists_isRingArc_of_touch`, `exists_inner_branch`, `IsRegOf.chain_step`, `exists_eq_of_interleaved_paths`,
  `exists_curveGerm_eq`; wave 5's held `row134BaseUA`, `cvb_thom`, `disc1_local`, `not_hasRepeatedColour_of_mem_interiorPts`. **Controls on `sorryAx`**:
  `exists_preBend`, `n3_base`, `bend_toward_collar`, `bv_l3`.
- **`sorry` by file** (`grep -rcw`; `sorry-counts-before.txt` → `sorry-counts-after.txt`): `Contact` 3 → 0, `UnitArc` 5 → 0 (`main`'s); `BaseDense` 7,
  `BendCollar` 1, `HexRing` 1, `Terminal` 9 unchanged; `Packed` 1, `Cover` 1, `CoverExamples` 2 are docstring words ("sorry-free"), not terms.

Statements unchanged on both sides but for the copies removed; no `axiom`, no `native_decide`.

## Stage 48 — SAVED

## Stage 49 — SAVED (FS131-M5): `ncard_coloursAt_le_two_of_mem_openArc` and `unenclosedC_of_homeomorph` proved

Statements unchanged; no new declarations.
- **`ncard_coloursAt_le_two_of_mem_openArc`** — a colour `j` at `x = r(θ)` has `x` in the closure of its class; the class is open (`isOpen_region`), so
  each of its points on `ω(P)` is a closure point of its part inside (`IsOpen.inter_closure`, `closure_ball`); hence
  `region j ⊆ cl(region j ∩ B(P, 1)) ∪ (region j ∖ B̄(P, 1))`, and `x` is in the closure of one of the two parts: `j` is an inner colour (`= c`) or an
  outer one (`= c'`). So `coloursAt x ⊆ {c, c'}`, `ncard ≤ 2`. (No arc geometry needed: the sphere part is absorbed by openness.)
- **`unenclosedC_of_homeomorph`** — pull everything back by `h`: `h⁻¹' M.interiorPts = F.interiorPts`; the preimage of a component is the component of
  the preimage (`Homeomorph.image_connectedComponentIn` for `h.symm`), so `h⁻¹'` carries `M`'s tiles to `F`'s and their colours (`hint`); closures and
  complements commute with `h⁻¹'`; and `h⁻¹' C ⊆ cl K ∪ C` (`h` is the identity off `K`), so a bounded component pulls back to a bounded one, which
  `F.UnenclosedC u` forbids. Only the one direction of boundedness is used.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 455 of 455 batches, 2 modules rebuilt (`BaseDense`, `Proofs`), 4 with warnings, every warning
`declaration uses 'sorry'`** — `BaseDense`'s now at `finite_maxRingArcs`, `exists_maxRingArc`, `hfree_of_baseHyp`, `maxRingArcs_subset_of_bend`,
`cv_exists` — exit 0, 8 min 14 s (`build/gate/build/20261005T102236Z-3314484.log`; driver log `data/fs131/m5/build-stage49.log`). Axioms: in Stage 50's print.

## Stage 49 — SAVED

## Stage 50 — SAVED (FS131-M5): `exists_maxRingArc` proved, over two new helpers

Statement unchanged. New, before it in `BaseDense` (names free on `HEAD`, `origin/main`, `origin/fs131-w5c` by `git grep`):
- **`exists_shift_of_ringArc_subset`** (namespace `Plane`): if `ringArc P a b ⊆ ringArc P s t`, `a ≤ b` and `t − s < 2π`, then for some `n : ℤ`,
  `s + 2πn ≤ a` and `b ≤ t + 2πn` — the lift of `a` fixes `n`; were `b` past `t + 2πn`, the parameter `min b (t + 2πn + δ)`, `δ` half the gap
  `2π − (t − s)`, would have no lift into `[s, t]` (`e_eq_e_iff`). No bound on `b − a` is needed.
- **`IsRingArc.shift`**: a ring arc read with both ends shifted by `2πn` is a ring arc with the same sides (`ringArc_add_two_pi_mul`, `ringPt_add_int_mul`).
- **`exists_maxRingArc`**: `a` = the infimum of the left ends, `b` = the supremum of the right ends, over the lifts `[s, t] ⊇ [θ₁, θ₂]` of ring arcs with
  sides `c, c'` (bounded by `l60_le`: `θ₂ − π/3 ≤ s`, `t ≤ θ₁ + π/3`). Every `φ ∈ (a, b)` lies inside one member (`exists_lt_of_csInf_lt`,
  `exists_lt_of_lt_csSup`, or `(θ₁, θ₂)` itself), which gives `r(φ) ∈ Γ` and its sides; the two ends are in `Γ` because the arc lies in the domain
  (`ω(P) ⊆ B̄(u, 2)`) and `Γ` is closed there (`ringArc_subset_Γ_of_finite`, the ends as the finite set). Maximality: an arc with these sides containing
  `[a, b]` is, after the shift `exists_shift_of_ringArc_subset` gives, a member, so its ends are `a` and `b`. (The domain hypothesis is exactly what
  inventory item 380's counterexample says such a statement needs: `ω(P) ⊆ dom`, here from `Covers u 2` and `P ∈ B̄(u, 1)`.)

Elaborated first in `data/fs131/m5/scratch/MaxArc.lean` (deleted now; its content is in the library). `tools/fs131_i5_stmt_check.py d61edefc`: PASS
(`data/fs131/m5/stmt-check-50.txt`). `scripts/Axioms.lean`: the two helpers' records before `exists_maxRingArc`'s.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 455 of 455 batches, 2 modules rebuilt (`BaseDense`, `Proofs`), 4 with warnings, every warning
`declaration uses 'sorry'`**, exit 0, 8 min 21 s (`build/gate/build/20261005T103209Z-3367893.log`, "Build completed successfully (5788 jobs)"; driver log
`data/fs131/m5/build-stage50.log`). **Axioms** (`data/fs131/m5/M5Axioms50.lean` → `.out`, 12 GiB slot): **on the standard three** —
`ncard_coloursAt_le_two_of_mem_openArc`, `unenclosedC_of_homeomorph`, `exists_maxRingArc`, `exists_shift_of_ringArc_subset`, `IsRingArc.shift`; **controls on
`sorryAx`**: `hfree_of_baseHyp`, `exists_preBend_step`, `exists_preBend`. `BaseDense`'s `sorry` 7 → 4: `finite_maxRingArcs`, `hfree_of_baseHyp`,
`maxRingArcs_subset_of_bend`, `cv_exists` (the `Terminal` lane's stale copy).

## Stage 50 — SAVED

## Stage 51 — SAVED (FS131-M5): the hand-back

### Theorems this phase proved (FS131-M5)

All [kernel], `[propext, Classical.choice, Quot.sound]`, in `Plane/ValidMap/BaseDense`:
- `HadwigerNelson.Plane.ArcMap.ncard_coloursAt_le_two_of_mem_openArc` — an interior point of a constant-sided unit arc carries at most its two side colours.
- `HadwigerNelson.Plane.ArcMap.unenclosedC_of_homeomorph` — `UnenclosedC u` is carried by a homeomorphism of the plane fixing `u`, the identity off a bounded set,
  that carries interior points, colours and colour sets (E4-BEND-UN's argument).
- `HadwigerNelson.Plane.ArcMap.exists_maxRingArc` — every unit arc centred in `B̄(u, 1)` of a valid fragment covering `B̄(u, 2)` lies in a maximal one with its sides.
- Helpers: `HadwigerNelson.Plane.exists_shift_of_ringArc_subset`, `HadwigerNelson.Plane.ArcMap.IsRingArc.shift`.
- On this branch after the merge (proved on `main`, now the files here): wave 4's `exists_shave`, `exists_rayMerge`, `exists_merge`, `bend_toward`, `flankQ_upper`,
  `flankQ_lower`, `nb4p` — on the standard three against this branch's build (Stage 48).

**Left**: `hfree_of_baseHyp` — route, not attempted for budget: at `x = r(θ)`, `BaseHyp u` puts `x ∉ fourSet ∪ repSet` (`dist x u ≤ 2`), so
`exists_chart_of_noRep` (`HexRing`) gives a chart with sector colours injective; each sector colour is carried at `x`, and the colours at `x` lie in `{c, c'}`
(`ncard_coloursAt_le_two_of_mem_openArc`'s first step, worth factoring out as `coloursAt_subset_of_mem_openArc`), so at most two germs; both of `ω(P)`'s
germs at `x` are germs of the chart (the arc near `x` lies in `Γ`), so the branches are the circle's (same tangent: `curveAt_eq_of_same`, `curve_inter` in
`LocalStructure` for the curvature), and `Γ ∩ B(x, r₀) ⊆ ω(P)`. Also left: `finite_maxRingArcs`, `maxRingArcs_subset_of_bend`, and `bend_toward_collar`'s
construction (ruling 379 (c): a planner pass first). **Drafts for the front page**: none — wave 5 is not at its gate.

## Stage 51 — SAVED

*The join (FS131-M6, Stage 53, merging `origin/fs131-w5` at `385b5ad3` into `fs131-w5c`): the stages above from Stage 27 to Stage 51 are `fs131-w5`'s (FS131-I5g, I5j, I5m, I5o, KB2, M5), numbered as on that branch; the stages below, Stage 27 to Stage 44, are `fs131-w5c`'s (FS131-I5h, I5i, I5k, I5l, I5n, I5p), numbered as on this branch, so that the inventory's citations of "`fs131-w5c`'s Stages n–m" still resolve; FS131-M6's own stages run from Stage 52.*


## Stage 27 — SAVED (FS131-I5h): the readback

*FS131-I5h, wave 5's `Terminal` implementer (Opus), on branch `fs131-w5c` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c`, cut from `fs131-w5`
at `75689a4c`; continuing this record from Stage 27 while FS131-I5g writes stages on `fs131-w5`. Brief: `data/fs131/briefs/FS131-I5h-terminal.md` (main
tree). My set (ruling 322 (c)): E5's two lemmas as children, then `n3_end_of_not_inType`, `cv_class`, the CV-HD cluster (`cv_hd_main`, `y3_end_needs`,
`cv_hd`, `c_double`, `c_ends`), `exists_red`, `exists_terminal`, then `cv_exists` (`BaseDense`, its lines only).*

### 27.1 The brief's quotations against their sources (standing rule 3)

Checked by script, `tools/fs131_i5h_quotes.py` (each run of `> ` lines searched verbatim, whitespace folded, in the file its `— source:` line names; main
tree unless the path is absolute). **11 quotations, 0 failures** — every one verbatim: `CLAUDE.md` § Counter-priors (Kooshi on pricing); this record's
Stage 21 (`Terminal` (9)) and Stage 24 (`cv_exists`); the inventory's items 320, 321, 322, 274, 295; E5's record § 3.4 and § 3.5 headings; the plan's
§ 10.2 ("It may"). `--self-test`: a one-letter plant in the first quotation **fired** (1 failure reported), the unplanted run passed.

Read in full: inventory items 274, 295, 320–323; E5's record § 3 (§§ 3.1–3.6: SH, the inputs F1–F6, SEP, NB3-END item 2, CVB § 1.4 item 5, the
entries); this record's Stages 18 and 20.2 (I5d's and I5e's notes under `n3_end`: the GAP and the limit directions), Stages 21–26; the plan's §§ 3.2, 4,
8.2, 9.1, 10.2; NB3-END items 1–5 (`plans/FS112-NB3-verification.md` l. 222–243). No mismatch found. Item 323 (staffing back to three) applies to launches,
not to this running job.

### 27.2 The as-given build (`75689a4c`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — 447 of 447 batches, 22
modules rebuilt (the copied `.lake/build` differed), 8 modules with warnings**, exit 0, 11 min 49 s (`build/gate/build/20261005T035051Z-1154391.log`;
driver log `data/fs131/i5h/build-stage27-asgiven.log`). Every warning is `declaration uses 'sorry'`; distinct declarations: wave 5's `Terminal` 9, `Dense`
1, `HexRing` 6, `MapGraph` 3, `BaseWalk` 5, `BaseDense` 3 (**27**, I5g's count at Stage 26; mine 10: `Terminal`'s 9 and `cv_exists`), and wave 4's stale
`Contact` 3, `UnitArc` 5.

Iteration script: `data/fs131/i5h/iter.sh` (I5g's, re-pointed at this worktree and its own scratch mirror `/home/kooshi/scratch-w5h`, outside the
repository).

## Stage 27 — SAVED

## Stage 28 — SAVED (FS131-I5h): E5's lemmas SH and SEP, kernel theorems (`Plane/ValidMap/HornShadow`, new)

**The module.** `Plane/ValidMap/HornShadow` (imports `FlankUA`; imported by `Terminal` and `Proofs.lean`), 26 declarations, every one proved, no `sorry`,
no `axiom`, no `native_decide`. Statements read back against E5's record (`plans/FS131-E5-derivation.md`, main tree):

| E5's entry | Lean | read-back |
|---|---|---|
| e5-sh (SH1): "every y with \|y − S′\| < 1/2 that has a unit partner in H satisfies TanAbove S′ α μ y" (`H = H^σ_r(ν, ν′)`, `−1 < ν < ν′ ≤ 1`, `0 < r < 1/2`, `μ = ν/(1 + ν)`) | `tanAbove_S_of_dist_le_one` (`−1 < ν`, `TanAbove v α ν z`, `dist y z ≤ 1` ⟹ `TanAbove (v − n) α (curvDown ν) y`); horn forms `shadow_hornSet_subset_S` (σ = +1) and `shadow_hornSet_add_pi_subset_S` (σ = −1, `ν = −κ₄`, `κ₄ < 1`) | **stronger** (the brief's "a stronger one you find"): no bound on `\|y − S′\|`, no `ν′`, no `r`, any point above the `ν`-circle, distance `≤ 1`. The proof is E5's (O) without (D): the circle of curvature `ν` has centre `v + n/ν`, radius `1/\|ν\|`; the triangle inequality gives `\|y − O\| < 1 + 1/ν` (`ν > 0`) or `> 1/\|ν\| − 1` (`ν < 0`), which is `TanAbove S′ α f(ν)` by the offset identity (`ν = 0`: `Y(y) > Y(z) − 1 > −1`) |
| e5-sh (SH2): "for some ρ > 0 every y with \|y − S′\| < ρ, σ·frameX v α y > 0 and TanAbove S′ α μ y has a unit partner in H" | `mem_shadow_hornSet_S` (σ = +1: `−1 < ν < ν′ ≤ 1`, `0 < r ≤ 1/2`), `mem_shadow_hornSet_add_pi_S` (σ = −1: `−1 ≤ κ₃ < κ₄ < 1`, so `ν = −κ₄`, `ν′ = −κ₃`) | **same**, with `r ≤ 1/2` for E5's `r < 1/2` (a widening). Route: wave 4's far-side shadow `shadow_farSide_above` (based at `S′`) gives a unit partner `w` above the `ν`-circle near `v`; E5's vertical drop (D) moves it to a height strictly between the `ν`- and `ν′`-circles (`exists_drop_height`, an intermediate value), a point of `H` within `1` of `y` (`exists_near_hornSet_of_partner`); a point of `H` on the middle germ (`branchPt`) lies beyond `1`; `H` is connected (`isPreconnected_hornSet_unit`: the sector between two germs of one direction, `BranchGerms.isPreconnected_sector`). Side `−` by the reflection in the normal line through `v` |
| e5-sh at `N` (§ 3.5's mirror: "the shadow near N of a horn on side σ with N-side bound υ ∈ (−1, 1) is TanBelow N α f̃(υ) on side σ") | SH1: `tanBelow_N_of_dist_le_one`, `shadow_hornSet_subset_N` (σ = +1, `υ < 1`), `shadow_hornSet_add_pi_subset_N` (σ = −1, `υ = −κ₃`, `κ₃ > −1`); SH2: `mem_shadow_hornSet_N` (`−1 ≤ υ′ < υ < 1`), `mem_shadow_hornSet_add_pi_N` (`−1 < κ₃ < κ₄ ≤ 1`) | **same** (SH1 stronger as above), by the frame turned by `π` (`tanAbove_add_pi_iff`, `tanBelow_add_pi_iff`, `neg_curvDown_neg`: `−f(−υ) = f̃(υ)`) |
| e5-sep: "let H be a c-horn at v on side σ with S′-side bound ν ∈ (−1, 1), and G a sector at S′ with a boundary half-arc γ of the σ-direction, lying on γ's −n side, that holds points tending to S′ on side σ each with a unit partner in H; then no c-sector at S′ whose cone is the σ-direction alone lies on γ's +n side" | `sep_S` (σ = +1), `sep_add_pi_S` (σ = −1, the form `n3_end_of_not_inType` reads with `H = H₋`); mirrored at `N`: `sep_N`, `sep_add_pi_N` (the forms `cv_class` reads, CVB § 1.4 item 5 with `Q±`, `H±`) | **the same content, stated map-free as the unit pair it produces**: one point `y₀` of `shadow H` below the arc of curvature `μ` through `S′` (G's witness, below its half-arc `γ` of curvature `μ`), and a set `K` with points arbitrarily near `S′` on side σ above that arc, give `y ∈ K`, `z ∈ H`, `dist y z = 1`. With `K` a `c`-sector and `H` a `c`-horn this contradicts `Valid` (`F.Valid` reads exactly "two interior points at distance 1 differ in colour"). E5's sequence `y_k → S′` is not needed: one witness suffices (`lt_of_tanAbove_tanBelow`, the SEP-ORDER identity: above `f(ν)` and below `μ` at one point off `S′` forces `μ > f(ν)`); the cone/local-structure reading of "K on γ's +n side" is the consumer's (F6) |

Children (all in `HornShadow`): `frameY_add_pi`, `tanAbove_add_pi_iff`, `tanBelow_add_pi_iff`, `neg_curvDown_neg`, `e_add_pi_add_pi`, `dist_eq_dist_of_frame`,
`isPreconnected_hornSet_unit` (renamed from `isPreconnected_hornSet`: `main`'s `Plane/ValidMap/Surgery` declares that name with another statement — found by
`git grep` over `fs131-w5c`, `fs131-w5`, `fs131-w5p`, `fs131-ww`, `main`; every other new name is unique there), `exists_drop_height`,
`exists_near_hornSet_of_partner`, `lt_of_tanAbove_tanBelow`, `TanAbove.mono`, `TanBelow.mono`. Spec examples: `curvDown (1/3) = 1/4` (E5's SH model line),
`−curvDown (−1/2) = curvUp (1/2) = 1`.

**Statements unchanged**: `tools/fs131_i5h_stmt_check.py 75689a4c` (FS131-I5f's checker re-aimed at `Terminal`, `BaseDense`, `FlankUA`): **PASS**;
`--self-test`: three plants (a hypothesis of `n3_end_of_not_inType` loosened, `cv_exists`'s conclusion loosened, `cv_class` renamed) each **FIRED**, the
unplanted control passed. `tools/fs131_i5_stmt_check.py 75689a4c` (I5g's files, which I did not touch): **PASS**. `Terminal`'s only edit is its import of
`HornShadow`.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 6 modules rebuilt (`HornShadow`, `Terminal`, `Dense`, `BaseWalk`, `BaseDense`, `Proofs`), 8 with warnings, every warning `declaration uses 'sorry'`**, exit 0, 9 min 15 s (`build/gate/build/20261005T041051Z-1283678.log`; driver log `data/fs131/i5h/build-stage28.log`). `HornShadow` has no warning. Wave 5's sorry declarations: **27** (unchanged: SH and SEP are new children, no leaf closed yet), mine 10. Axioms read from this build's oleans (`data/fs131/i5h/I5hAxioms28.lean` → `I5hAxioms28.out`): all 26 declarations of `HornShadow` on `[propext, Classical.choice, Quot.sound]`; controls: `n3_end_of_not_inType` reads `sorryAx` (the reader sees the failure the print guards against), `linkage_dot_ne_zero` the standard three. `scripts/Axioms.lean`: a block "FS131-I5h" above the `=== PURCHASED ===` banner with the 26 records; `ARCHITECTURE.md`: a row for `HornShadow`, `Terminal`'s Imports cell; `tools/check_architecture.py`: PASS.

**Re-pricing** (the brief: "re-price from your first two hard leaves"). SH2 was the first hard proof here: about 60k tokens of context with its children,
of which most went to elaboration timeouts in one long proof, cured by splitting it into three lemmas. The leaves themselves are not started, so the
re-pricing is of their route: `n3_end_of_not_inType` needs, beyond SH/SEP, the local structure at `S′` (E5's F2–F6) — the sector chart at `S′`
(`localSectors`), the two `g`-sectors located by the witnesses' directions (I5e's § 20.2 limits), U1 at `S′` for `c` — and then NB3-END items 3–5 (which
E5 did not re-derive and which are NB3's, one mind). On this session's rate, H as planned: one implementer session for item 2 (the repeated colour),
a second for items 3–5.

**What is left of my set (10), and where it stands** (for the next `Terminal` implementer):
- **`n3_end_of_not_inType`** (`Terminal`). Its three conclusions: `HasRepeatedColour S′` is E5 § 3.4 (now over `sep_add_pi_S`); `4 ≤ #P_cl(S′)` and the
  both-kind arc at `v − 2n` are NB3-END items 3–5. Suggested children: (i) `g_sectors_two_at_S` — `∀ᶠ r, 2 ≤ (F.sectorsOf S′ r g).encard`, from: F2 (a
  `g`-point near `S′` inside `B̄(v, 1)` crosses the upper `g`-sector: `region_far_S_of_srcG`, `dot_nonneg_of_srcG`), F3–F4 (the witnesses of
  `shadow_of_not_shave` localize at `S′` and tend to `±a`: I5e's § 20.2 inequalities), F5 (U1 at `S′`: `not_antipodal_coneAt_S_of_horn`,
  `ringArc_cone_outer`), F6 (`localSectors` at `S′`; a sector whose cone holds `α` and `α + π` inside `[α + π, α + 2π]` is the lower half between two germs
  of directions `α`, `α + π`), then `sep_add_pi_S` (with `H = H₋`, `ν = −κ₄`; at `κ₄ = 1`, U1 instead). **Sign care**: a chart germ at `S′` of direction
  `α + π` and `BranchGerms` curvature `κ` is the arc of upward curvature `−κ` in the frame at `α` (`branchPt` reads curvature in the germ's own
  direction). (ii) items 3–5 of NB3-END.
- **`cv_class`**: its "None" disjunct by `sep_N`/`sep_add_pi_N` at `N` and § 3.4's argument at `S` (E5 § 3.5); its bowtie disjunct over `cv_hd`.
- **`cv_hd_main`** (H: CVB § 1.6, both branches), **`y3_end_needs`** (H: YB3 § 3.1), **`cv_hd`** (M over `cv_hd_main`), **`c_double`** (E–M over `cv_hd`,
  `flankQ_*_of_qrOnly`), **`c_ends`** (M, with `stuckAlong_of_run`), **`exists_red`**, **`exists_terminal`** (H, the limit constructions), **`cv_exists`**
  (`BaseDense`; over `exists_terminal`, CVB § 1.4 items 3–6) — none started.

**Drafts for the front page**: none — wave 5 is not at its gate.

## Stage 28 — SAVED

## Stage 29 — SAVED (FS131-I5i): the readback

*FS131-I5i, wave 5's second `Terminal` implementer (Opus), continuing FS131-I5h's work on branch `fs131-w5c` in
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` from `72149b07`. Brief: `data/fs131/briefs/FS131-I5i-terminal.md` (main tree). My set (ruling 329),
in its order: `n3_end_of_not_inType` (the repeated colour first, E5 § 3.4; then NB3-END items 3–5), `cv_class`, the CV-HD cluster (`cv_hd_main`,
`y3_end_needs`, `cv_hd`, `c_double`, `c_ends`), `exists_red`, `exists_terminal`, `cv_exists` (`BaseDense`, its lines only).*

### 29.1 The brief's quotations against their sources (standing rule 3)

Checked by script, `tools/fs131_i5h_quotes.py` (I5h's checker, in my touches; each run of `> ` lines searched verbatim, whitespace folded, in the file its
`— source:` line names): **12 quotations, 0 failures** — `CLAUDE.md` § Counter-priors; the inventory's items 328, 329, 321, 274, 295; this record's Stage 28
(three bullets: `n3_end_of_not_inType`, `cv_class`, the CV-HD cluster); E5's record § 3.4 and § 3.5 headings; the plan's § 10.2 ("It may"). `--self-test`
(a one-letter plant in the first quotation): **fired** (1 failure reported), the unplanted run passed.

Read in full: I5h's Stages 27–28; E5's record § 3 (§§ 3.1–3.6); I5d's and I5e's notes under `n3_end` (Stages 18 and 20.2); inventory items 274, 295, 321,
328, 329; the plan's §§ 3.2, 4, 8.2 (and § 9.1's rows for this half); NB3-END items 1–5 (`plans/FS112-NB3-verification.md` l. 222–243). No mismatch found.

### 29.2 The as-given build (`72149b07`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1755 modules already up
to date, nothing built, 8 modules with warnings**, exit 0 (`build/gate/build/20261005T042632Z-1343653.log`; driver log
`data/fs131/i5i/build-stage29-asgiven.log`). Every warning `declaration uses 'sorry'`: wave 5's `Terminal` 9, `Dense` 1, `HexRing` 6, `MapGraph` 3,
`BaseWalk` 5, `BaseDense` 3 (**27**, I5h's count; mine 10: `Terminal`'s 9 and `cv_exists`), and wave 4's stale `Contact` 3, `UnitArc` 5.

## Stage 29 — SAVED

## Stage 30 — SAVED (FS131-I5i): NB3-END item 2 assembled in the kernel over named children (`flank_two_sectors_at_S`, E5 § 3.4 over SEP); `n3_end_of_not_inType` reduced to NB3-END items 3–5

**What this stage proves.** `flank_two_sectors_at_S` (`Terminal`): in `n3_end_of_not_inType`'s setting the upper flank colour `g` has at least two
sectors at `S′ = v − n` for every small radius — E5 § 3.4 (NB3-END item 2, `e5-two-g-sectors`), assembled over the children below; at this stage five
of them (`angleIcc_eq_lower_half`, `angle_pinch`, `nextκ_le_of_disjoint`, `tanBelow_of_mem_sector`, `exists_tanAbove_of_sector`) are still `sorry`
(proved in scratch, folded in at Stage 31). With
it `n3_end_of_not_inType` is assembled: its repeated-colour conclusion is `flank_two_sectors_at_S`; its other two conclusions are the new named children
`n3_end_four_colours` (NB3-END items 3–4) and `n3_end_bothKind` (item 5), each `sorry`, statements in `n3_end_of_not_inType`'s hypotheses verbatim. The
leaf's `sorry` is replaced by two smaller ones; no statement of the skeleton changed.

**The route, step by step against E5's record** (every step of E5 § 3.2–3.4 went through in Lean; none failed):

| E5 | Lean | note |
|---|---|---|
| (F1) the stuck structure | `exists_horn_add_pi_of_stuck` (the `−a` horn at exactly `α + π`), `horn_bounds_of_noMerge`, `horn_poles_contact`, `stuck_flanks_ua` | new child: the opposite horn of a given horn, by `woodallCone_isHorn_ua` and `horn_unique_of_stuck` |
| (F2) `g` near `S′` outside `B̄(v, 1)` | `far_of_outType_chart` (pointwise: a point of a colour out-type at `P`, near `P`, lies in a chart sector, hence in a tile whose closure holds `P`), `coneAt_subset_of_far` (the cone form, `[α + π, α + 2π]`) | out-type at `S′` from `srcG_of_shadow` and `hno` — not E5's connectedness argument; the same fact |
| (F3) the witnesses, localized | `shadow_of_not_shave`; `witness_near_S_upper` (κ₂ < 1: `horn_shadow_near_S`; κ₂ = 1: `shadow_source_near_poles`, `N ∉ cl(region g)`), `witness_near_S_lower` (its mirror at the `−a` horn) | `N ∉ cl(region g)` when κ₂ = 1 or κ₃ = −1: in-type excluded by `hno`, out-type by `not_outType_N_of_flankAbove_one` / `not_outType_S_of_flankBelow_neg_one` turned |
| (F4) their directions | `witness_dir_real` (pure reals, exact: `σp > 0` and `(σp − s)² + q² < 8(ρ + δ)² s²`), `dirDist_sq_frame`, `witness_dir_pt`, `exists_witness_dir` | I5e § 20.2's inequalities made exact and uniform: `α ∈ cone(g)`, `α + π ∈ cone(g)` at `S′` |
| (F5) U1 at `S′` | `coneAt_S_subset_of_horn`, `coneAt_N_subset_of_horn` (the bounds inside wave 5's `not_antipodal_coneAt_*_of_horn`, exposed) | `c`'s cone at `S′` in `[α + π, α + 2π − φ]`; at κ₄ = 1 also in `[α + π + φ′, α + 2π]` |
| (F6) the chart at `S′` | `localSectors`; `angleIcc_eq_lower_half` (one `g`-sector holding `α` and `α + π` inside the lower half-turn is the half-disc, germs at `α + π` and `α + 2π`), `angle_pinch` (`c`'s sector is a horn along `−a`, via `Mono.disjoint`), `nextκ_le_of_disjoint` (that horn's upper germ curves no more than the half-disc's first germ, else the sectors meet at small radius) | sign care as I5h warned: a germ of direction `α + π` and curvature `κ` is upward curvature `−κ`; `tanBelow_of_mem_sector`, `exists_tanAbove_of_sector` read it |
| SEP, κ₄ < 1 | `sep_add_pi_S` with `μ = −κ_{i₀}`, an `H₋`-witness in the half-disc on the `−a` side (below the first germ), the `c`-horn above it | the unit pair contradicts `Valid` |
| κ₄ = 1 | `angle_pinch_false` | `c`'s horn direction `α + π` is outside U1's cone through `H₋`'s arc of `ω(S′)` |

Children added: `HornShadow` (all proved) — `witness_dir_aux1`–`aux3`, `witness_dir_real`, `dirDist_sq_frame`, `witness_dir_pt`, `angle_pinch_false`,
`coneAt_subset_of_far`, `exists_witness_dir`, `ArcMap.witness_near_S_upper`, `_lower`, `ArcMap.far_of_outType_chart`, `ArcMap.coneAt_S_subset_of_horn`,
`ArcMap.coneAt_N_subset_of_horn`; `Terminal` — `int_eq_one_of_real`, `int_eq_zero_of_real`, `abs_half_lt_one`, `angleIcc_eq_lower_half`, `angle_pinch`,
`ArcMap.nextκ_le_of_disjoint`, `ArcMap.tanBelow_of_mem_sector`, `ArcMap.exists_tanAbove_of_sector`, `ArcMap.exists_horn_add_pi_of_stuck`,
`ArcMap.flank_two_sectors_at_S`. Children added `sorry`: `ArcMap.n3_end_four_colours`, `ArcMap.n3_end_bothKind`. Names checked unique by `git grep` over
`main`, `fs131-w5`, `fs131-w5p`, `fs131-ww` (one collision found and avoided: `frame_polar` exists in `Sectors`, identical statement; used it).

**Statements unchanged**: `tools/fs131_i5h_stmt_check.py 72149b07` (I5h's checker: `Terminal`, `BaseDense`, `FlankUA`): **PASS**.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 6 modules rebuilt (`HornShadow`, `Terminal`, `Dense`, `BaseWalk`,
`BaseDense`, `Proofs`), 8 with warnings, every warning `declaration uses 'sorry'`**, exit 0, 8 min 47 s (`build/gate/build/20261005T045447Z-1471139.log`;
driver log `data/fs131/i5i/build-stage30.log`). `HornShadow` has no warning. Distinct `sorry` declarations: `Terminal` 15 (the 8 untouched leaves, the
5 chart/angle children, `n3_end_four_colours`, `n3_end_bothKind`; `n3_end_of_not_inType` no longer uses `sorry` directly), `Dense` 1, `HexRing` 6,
`MapGraph` 3, `BaseWalk` 5, `BaseDense` 3; wave 4's stale `Contact` 3, `UnitArc` 5.

**Re-pricing** (the brief: "re-price from your first two hard leaves"). The two hard pieces here were `witness_dir_real` (the exact witness-direction
inequality, about 15k tokens, the cost all in `nlinarith` heartbeats until split into three small lemmas, as `LEAN.md` advises) and the assembly
`flank_two_sectors_at_S` (about 12k: it elaborated over its children on the second attempt). The whole of NB3-END item 2 — 26 declarations — cost about
130k tokens of one session, against I5h's estimate of one session for it. NB3-END items 3–5 (NB3's, one mind) are of the same kind (sector charts at
`S′` and `v − 2n`, U1, SHAVE's clearness): about one session.

## Stage 30 — SAVED

## Stage 31 — SAVED (FS131-I5i): the five chart and angle children proved, so `flank_two_sectors_at_S` (NB3-END item 2) is a kernel theorem; the handover

**Folded in** (proved in scratch during Stage 30's build, now in `Terminal`): `angleIcc_eq_lower_half` (over `ArcMap.exists_lift_of_Icc_subset_angleIcc`),
`angle_pinch`, `ArcMap.nextκ_le_of_disjoint` (if the horn's upper germ curved more than the half-disc's first germ, the point
`S′ + s e(β + arcsin(x s/2))` for `x` between them would lie in both sectors at `s = r₀/2`, against `IsSectorChart.disjoint`),
`ArcMap.tanBelow_of_mem_sector`, `ArcMap.exists_tanAbove_of_sector` (through wave 4's `frame_polar` and `Real.sin_arcsin`), and three helpers
`int_eq_one_of_real`, `int_eq_zero_of_real`, `abs_half_lt_one`. Nothing of `flank_two_sectors_at_S` rests on `sorry` now.

**Statements unchanged**: `tools/fs131_i5h_stmt_check.py 72149b07`: **PASS**. `tools/check_architecture.py`: **PASS** (no new module).

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 5 modules rebuilt (`Terminal`, `Dense`, `BaseWalk`, `BaseDense`,
`Proofs`), 8 with warnings, every warning `declaration uses 'sorry'`**, exit 0, 8 min 38 s (`build/gate/build/20261005T050511Z-1542012.log`; driver log
`data/fs131/i5i/build-stage31.log`). Distinct `sorry` declarations: `Terminal` **10** (`exists_red`, `exists_terminal`, `cv_hd_main`, `cv_hd`, `cv_class`,
`y3_end_needs`, `c_ends`, `c_double`, `n3_end_four_colours`, `n3_end_bothKind`), `Dense` 1, `HexRing` 6, `MapGraph` 3, `BaseWalk` 5, `BaseDense` 3 — wave 5
**28** (27 at launch: the leaf `n3_end_of_not_inType` replaced by two smaller children); wave 4's stale `Contact` 3, `UnitArc` 5.

**Axioms, read from this build's oleans** (`data/fs131/i5i/I5iAxioms31.lean` → `I5iAxioms31.out`, run under a 12 GiB slot, exit 0): 28 records; the 24
proved declarations of this job on `[propext, Classical.choice, Quot.sound]`, among them `ArcMap.flank_two_sectors_at_S`; `n3_end_four_colours`,
`n3_end_bothKind` and the control `n3_end_of_not_inType` read `sorryAx` (the reader sees the failure the print guards against); the control
`linkage_dot_ne_zero` the standard three. `scripts/Axioms.lean`: the "FS131-I5h" block extended by a commented line and 26 records, above the
`=== PURCHASED ===` banner.

### Theorems this phase proved

All [kernel], axioms `[propext, Classical.choice, Quot.sound]` (`data/fs131/i5i/I5iAxioms31.out`):
- `HadwigerNelson.Plane.ArcMap.flank_two_sectors_at_S` (`Plane/ValidMap/Terminal.lean`) — NB3-END item 2, E5 § 3.4 (`e5-two-g-sectors`): in
  `n3_end_of_not_inType`'s setting the upper flank colour has at least two sectors at `S′ = v − n` for every small radius.
- `ArcMap.exists_horn_add_pi_of_stuck` (`Terminal`) — the opposite horn at a stuck vertex, at exactly `α + π`, bounds in `[−1, 1]`.
- `ArcMap.nextκ_le_of_disjoint`, `ArcMap.tanBelow_of_mem_sector`, `ArcMap.exists_tanAbove_of_sector`, `angleIcc_eq_lower_half`, `angle_pinch`,
  `int_eq_one_of_real`, `int_eq_zero_of_real`, `abs_half_lt_one` (`Terminal`) — the chart at `S′` (E5's F6) and its angle arithmetic.
- `witness_dir_real` (with `witness_dir_aux1`–`aux3`), `dirDist_sq_frame`, `witness_dir_pt`, `exists_witness_dir` (`HornShadow`) — E5's F3–F4, the
  witnesses' directions, exact.
- `coneAt_subset_of_far`, `ArcMap.far_of_outType_chart` (`HornShadow`) — E5's F2 (cone and pointwise forms).
- `ArcMap.coneAt_S_subset_of_horn`, `ArcMap.coneAt_N_subset_of_horn`, `angle_pinch_false` (`HornShadow`) — U1's cone forms, E5's F5.
- `ArcMap.witness_near_S_upper`, `ArcMap.witness_near_S_lower` (`HornShadow`) — the localization at `S′` (E5's F3).

### What is left of my set (10), and where it stands (for the next `Terminal` implementer)

- **`n3_end_of_not_inType`**: assembled; open only through `n3_end_four_colours` (NB3-END items 3–4: `S′` terminal makes `g`'s two sectors horns along
  `±a` — `woodallCone_isHorn_ua` at `S′`, as `exists_horn_add_pi_of_stuck` does at `v` —, then the colours `y` below and `z` above `g`'s `+a` horn,
  `z ≠ y` by SHAVE) and `n3_end_bothKind` (item 5: the `y`-shadow on that horn, an in-type `y`-tile at `v − 2n` Siamese to the lower flank).
  `flank_two_sectors_at_S` returns the flank colour `g` with its two sectors; the chart at `S′` and U1's cone forms are ready.
- **`cv_class`**: its "None" disjunct is E5 § 3.5 — this stage's argument mirrored at `N` (`sep_N`, `sep_add_pi_N`; the witness, cone and chart lemmas
  here have frame-turned forms: `witness_near_S_lower` is already the `α + π` reading). Its bowtie disjunct over `cv_hd`.
- **`cv_hd_main`, `y3_end_needs`, `cv_hd`, `c_double`, `c_ends`, `exists_red`, `exists_terminal`, `cv_exists`**: not started; Stage 28's notes stand.

**Drafts for the front page**: none — wave 5 is not at its gate.

## Stage 31 — SAVED

## Stage 32 — SAVED (FS131-I5k): the readback

*FS131-I5k, wave 5's third `Terminal` implementer (Opus), continuing FS131-I5i's work on branch `fs131-w5c` in
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` from `33320123`. Brief: `data/fs131/briefs/FS131-I5k-terminal.md` (main tree). My set (ruling
335), in its order: `n3_end_four_colours` and `n3_end_bothKind` (NB3-END items 3–5), `cv_class`, the CV-HD cluster (`cv_hd_main`, `y3_end_needs`, `cv_hd`,
`c_double`, `c_ends`), `exists_red`, `exists_terminal`, `cv_exists` (`BaseDense`, its lines only).*

### 32.1 The brief's quotations against their sources (standing rule 3)

Checked by script, `tools/fs131_i5h_quotes.py` (I5h's checker, in my touches): **12 quotations, 0 failures** — `CLAUDE.md` § Counter-priors; the
inventory's items 334, 335, 288, 274, 295; this record's Stage 31 (three bullets: `n3_end_of_not_inType`, `cv_class`, the CV-HD cluster); NB3's N3-END
heading (`plans/FS112-NB3-verification.md`); E5's § 3.5 heading; the plan's § 10.2 ("It may"). `--self-test` (a one-letter plant in the first quotation):
**fired** (1 failure reported), the unplanted run passed.

Read in full: I5h's Stage 28; I5i's Stages 29–31; inventory items 288 (the case-split correction: `κ₂ = 1`, `g ∉ P_cl(N)` goes through items 2–5), 289,
334, 335; NB3's N3-END entry (`plans/FS112-NB3-verification.md` l. 221–243) and its divergence table rows 2–4 (l. 286–288); E5's § 3.2–3.5
(`plans/FS131-E5-derivation.md` l. 221–298); the plan's §§ 3.2, 8.2, 10.1–10.2. No mismatch found.

### 32.2 The as-given build (`33320123`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1755 modules already up
to date, nothing built, 8 modules with warnings**, exit 0 (`build/gate/build/20261005T051846Z-1623760.log`; driver log
`data/fs131/i5k/build-stage32-asgiven.log`). Every warning `declaration uses 'sorry'`: `Terminal` 10 (my ten), `Dense` 1, `HexRing` 6, `BaseWalk` 5,
`BaseDense` 3 (`cv_exists` among them), `MapGraph` 3 — wave 5 **28**, I5i's count; wave 4's stale `Contact`, `UnitArc`.

## Stage 32 — SAVED

## Stage 33 — SAVED (FS131-I5k): NB3-END items 3–5 in the kernel, so `n3_end_of_not_inType` and `n3_end` are kernel theorems

**What this stage proves.** `n3_end_four_colours` (NB3-END items 3–4) and `n3_end_bothKind` (item 5), the two children I5i left, so
`n3_end_of_not_inType` and FS112-N3-END (`n3_end`) rest on no `sorry`. No statement changed; no `axiom`; no `native_decide`.

**Items 3–4, by a shorter route than NB3's.** `S′ = v − n` has a repeated colour (`flank_two_sectors_at_S`, item 2) and the map is terminal,
so `S′` is stuck (`isStuck_of_hasRepeatedColour`: no move anywhere, and a colour's sector count is eventually constant). With at most three
colours `S′` would be a chain vertex, where every colour — `c` among them, carried at `S′` by N3-DEG — approaches along both directions of one
axis (`chainVertex_antipodal`); U1 keeps `c`'s cone at `S′` free of antipodal pairs (`not_antipodal_coneAt_S_of_horn`). So `#P_cl(S′) ≥ 4`.
NB3's colours `y ≠ z` beside `g`'s `+a` horn and its SHAVE step are not used. **A generalization** for the report: NB3-END items 3–4's four
colours follow from item 2, terminality at `S′` and U1 alone.

**Item 5, NB3's route in the kernel** (every step went through; none failed):

| NB3-END item 5 | Lean |
|---|---|
| `g`'s two sectors at `S′` are horns along `±a`, with out-type contacts at `v` and `v − 2n` (item 3) | `flank_coneAt_S` (`α ∈ cone(g)` at `S′`, E5's F2–F4: the first half of `flank_two_sectors_at_S`'s proof); `exists_horn_of_mem_coneAt_of_stuck` (N3-DEG's horns at a stuck point, `woodallCone_isHorn_ua`, located by a direction of the class: `exists_mem_sectorsOf_of_mem_coneAt`, `e_eq_of_mem_coneAt_hornSet`) |
| "No SHAVE of that horn needs a `y`-shadow on it" | `IsHorn.exists_flankBelow`, `shadow_of_not_shave` |
| the shadow's source: in-type at `v − 2n`, or out-type at `v` | `srcH_of_shadow` at `S′` |
| "`y ∉ P_cl(v)`" | the out-type branch puts `y` in `P_cl(v) = {c, g, h}`: `c` by U1 (`α ∉ [α + π, α + 2π − φ]`, `not_mem_angleIcc_S_self`), `g` by validity (its own shadow on its own horn), `h` because its flank below `c`'s horn lies in `B(S′, 1)` and has `v` in its closure (`not_outType_v_of_flankBelow_neg_one`, over `isPreconnected_hornSet_of_abs_le`) |
| "possible only when the horn's lower arc is an arc of `ω(P₋₂)`" | the in-type contact keeps `y`'s class near `S′` in `B̄(v − 2n, 1)` (`region_near_of_inType`); a band point above curvature `−1` would leave it, so `κ₁′ = −1` |
| "that arc has `s_in = y`, `s_out = g`, both in `P_cl(P₋₂)`" | `IsHorn.isRingArc_lower_ua` (the ring arc), `y` from the in-type contact, `g` from the out-type contact at `v − 2n` |

NB3's "`z ≠ y`" is not needed for item 5 either (the upper flank `z` enters only as `shadow_of_not_shave`'s argument).

**A copy, flagged for the merge.** `IsHorn.isRingArc_lower_ua` is wave 4's `IsHorn.isRingArc_lower` (engine 5, `UnitArc` on `main`), proved
here under its own name because this branch does not carry wave 4's landing and the brief does not take `main`; its proof is `main`'s with
`fromFrame` read as this branch's `framePt` and one identity (`ringPt_S_sub_eq_framePt`) in place of `main`'s `normalPt_sub_add_eq_fromFrame`.
At the merge with `main` it should collapse to a citation of `IsHorn.isRingArc_lower` (the docstring says so).

Children added (all `Terminal`, all proved): `ringPt_S_sub_eq_framePt`, `isPreconnected_hornSet_of_abs_le`, `not_mem_angleIcc_S_self`,
`ArcMap.IsHorn.isRingArc_lower_ua`, `ArcMap.exists_mem_sectorsOf_of_mem_coneAt`, `ArcMap.exists_horn_of_mem_coneAt_of_stuck`,
`ArcMap.not_outType_v_of_flankBelow_neg_one`, `ArcMap.isStuck_of_hasRepeatedColour`, `ArcMap.flank_coneAt_S`. Names checked unique by
`git grep` over `main`, `origin/fs131-w5`, `origin/fs131-w5p`, `origin/fs131-ww`, `origin/fs131-w5c`. The two leaves' docstrings now state the
routes taken (statements untouched).

**Statements unchanged**: `tools/fs131_i5h_stmt_check.py 72149b07`: **PASS**; and against my launch, `tools/fs131_i5h_stmt_check.py 33320123`
(which also covers I5i's children `n3_end_four_colours`, `n3_end_bothKind`, `flank_two_sectors_at_S`): **PASS**. `tools/check_architecture.py`:
**PASS** (no new module).

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 5 modules rebuilt (`Terminal`, `Dense`, `BaseWalk`, `BaseDense`,
`Proofs`), 8 with warnings, every warning `declaration uses 'sorry'`**, exit 0, 8 min 35 s (`build/gate/build/20261005T053544Z-1692375.log`;
driver log `data/fs131/i5k/build-stage33.log`). `Terminal`'s `sorry` declarations: **8** (`exists_red`, `exists_terminal`, `cv_hd_main`, `cv_hd`,
`cv_class`, `y3_end_needs`, `c_ends`, `c_double`); wave 5 **26** (28 at launch).

**Axioms, read from this build's oleans** (`data/fs131/i5k/I5kAxioms33.lean` → `I5kAxioms33.out`, 12 GiB slot, exit 0): `n3_end_four_colours`,
`n3_end_bothKind`, `n3_end_of_not_inType`, `n3_end` and the nine children on `[propext, Classical.choice, Quot.sound]`; controls: `cv_class`
reads `sorryAx` (the reader sees the failure the print guards against), `ArcMap.linkage_dot_ne_zero` the standard three. `scripts/Axioms.lean`:
the "FS131-I5h" block extended by a commented line and the nine children's records (`n3_end`, `n3_end_of_not_inType` already had theirs).

**Re-pricing** (the brief: "from your first two hard leaves"). Both leaves together cost about 60k tokens of context, against I5i's estimate of
about one session for items 3–5: the toolkit (wave 4's and I5d–I5i's lemmas) carried nearly every step, and the one missing piece (the ring
arc) was a copy. The CV-HD cluster's leaves are of the same kind where they read the stuck structure; `exists_red`/`exists_terminal` (limit
constructions) are not.

### Theorems this phase proved

All [kernel], axioms `[propext, Classical.choice, Quot.sound]` (`data/fs131/i5k/I5kAxioms33.out`):
- `HadwigerNelson.Plane.ArcMap.n3_end_four_colours` (`Plane/ValidMap/Terminal.lean`) — NB3-END items 3–4: `#P_cl(v − n) ≥ 4`.
- `HadwigerNelson.Plane.ArcMap.n3_end_bothKind` (`Terminal`) — NB3-END item 5: a both-kind unit arc centred at `v − 2n`.
- hence `ArcMap.n3_end_of_not_inType` and **`ArcMap.n3_end`** (FS112-N3-END, NB3's corrected form with item 288's case split) rest on no
  `sorry`.
- children: `ringPt_S_sub_eq_framePt`, `isPreconnected_hornSet_of_abs_le`, `not_mem_angleIcc_S_self`, `ArcMap.IsHorn.isRingArc_lower_ua`,
  `ArcMap.exists_mem_sectorsOf_of_mem_coneAt`, `ArcMap.exists_horn_of_mem_coneAt_of_stuck`, `ArcMap.not_outType_v_of_flankBelow_neg_one`,
  `ArcMap.isStuck_of_hasRepeatedColour`, `ArcMap.flank_coneAt_S`.

**In progress, not in the tree** (`data/fs131/i5k/Scratch5.lean`, iteration only, against this build's oleans): `cv_class` assembled — its
"None" disjunct over a general form of § 3.4 (`flank_two_sectors_at_S_gen`, any bounds in `[−1, 1]`, E5 § 3.5's "U1 or SEP at each end", with
mirrored chart lemmas `κ_le_of_disjoint_end`, `tanBelow_of_mem_sector_end`, `exists_tanAbove_of_sector_end`, the angle lemma
`angle_pinch_ends` and `IsFlankBelow.unique`), applied at `S′` for `g` and in the turned frame at `N` for `h`; its bowtie disjunct over `cv_hd`,
`c_double` and `n3_end_chain`. Folded in at Stage 34.

**Drafts for the front page**: none — wave 5 is not at its gate.

## Stage 33 — SAVED

## Stage 34 — SAVED (FS131-I5k): `cv_class` proved over `cv_hd`, `c_double` and a general form of E5 § 3.4; the handover

**What this stage proves.** `cv_class` (FS114-CV-HD's CV-CLASS) no longer uses `sorry` itself: it rests on `cv_hd` and `c_double` (both open,
both in my set). Statement unchanged; the declaration is moved below its children in `Terminal` (a section "FS114-CV-HD, (CV-CLASS) (placed
after its children)" before `end ArcMap`), because its proof cites lemmas that sit after its old place. Lean changes in commit `a4900311`;
this record entry in the next commit (the first commit's record append did not run: a `git rm` before it failed on the scratch file, which
this commit removes — its content is all in `Terminal`).

**The route, against E5 § 3.5** (every step went through; none failed):

| E5 § 3.5 | Lean |
|---|---|
| the split: CV-HD's four conditions all hold or none does | `cv_hd`'s three equivalences (open) |
| the bowtie case: both neighbours `≥ 4` colours and both-kind centres, a one-vertex chain | `c_double` (open): its (Q) arcs at `N` and `S` are both-kind arcs (a (Q) arc carries both side colours at its centre) with `≥ 4` colours; the chain clause is `n3_end_chain` (kernel) |
| "None": `h` has two sectors at `E + n` (`Q₊ = Q₋` excluded by SEP mirrored, or U1 at a bound `1`) | `flank_two_sectors_at_S_gen` applied in the frame turned by `π` (`c`'s horn along `α + π`, its upper flank `h`, its `N` the point `S`; `¬H_S` from `¬G_N` by `cv_hd`'s first equivalence), `IsFlankBelow.unique` to name `h` |
| "by § 3.4's argument with `cv_class`'s bounds (U1 on whichever lower arc is `ω(S′)`) `g` has two at `E − n`" | `flank_two_sectors_at_S_gen` (new, kernel): `flank_two_sectors_at_S`'s argument with both ends of the half-disc closed — a `c`-horn along `−a` at `S′` by `sep_add_pi_S` (`κ₄ < 1`) or U1 (`κ₄ = 1`), one along `+a` by `sep_S` (`κ₁ > −1`) or U1 (`κ₁ = −1`); the `c`-cone at `S′` bounded by `c`'s out-type contact there (`far_of_outType_chart`), so a `c`-sector meeting no interior direction of the half-disc is a horn at one of its two ends (`angle_pinch_ends`) |
| "each neighbour stuck or with at least four colours" | each neighbour has a repeated colour, so it is stuck (`isStuck_of_hasRepeatedColour`) |

Children added (all `Terminal`, all proved): `angle_pinch_ends`, `not_mem_angleIcc_S_add`, `ArcMap.κ_le_of_disjoint_end`,
`ArcMap.tanBelow_of_mem_sector_end`, `ArcMap.exists_tanAbove_of_sector_end` (the `+a`-end mirrors of I5i's three chart lemmas),
`ArcMap.IsFlankBelow.unique` (the mirror of `IsFlankAbove.unique`), `ArcMap.flank_two_sectors_at_S_gen`. Names checked unique by `git grep` over
`main`, `origin/fs131-w5`, `origin/fs131-w5p`, `origin/fs131-ww`.

**Generalizations** (for the report): E5 § 3.5's two-sector claim holds at every bound in `[−1, 1]` with no use of "None" beyond `¬G_N` (for `g`
at `S`) and `¬H_S` (for `h` at `N`) — the conditions on `υ±` and `λ±` are not read; and in the "None" disjunct the alternative "at least four
colours" is never needed: both neighbours are stuck.

**Statements unchanged**: `tools/fs131_i5h_stmt_check.py 72149b07` and `… 33320123`: **PASS** both. `tools/check_architecture.py`: not re-run
(no module or import changed since Stage 33's PASS).

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 5 modules rebuilt, 8 with warnings, every warning `declaration uses
'sorry'`**, exit 0, 8 min 40 s (`build/gate/build/20261005T054738Z-1755163.log`, ends "Build completed successfully (5370 jobs)"; driver log
`data/fs131/i5k/build-stage34.log`). `Terminal`'s `sorry` declarations: **7** (`exists_red`, `exists_terminal`, `cv_hd_main`, `cv_hd`,
`y3_end_needs`, `c_ends`, `c_double`); wave 5 **25** (28 at launch).

**Axioms, read from this build's oleans** (`data/fs131/i5k/I5kAxioms34.lean` → `I5kAxioms34.out`, 12 GiB slot, exit 0): the seven children and
`n3_end` on `[propext, Classical.choice, Quot.sound]`; `cv_class` reads `sorryAx` (through `cv_hd`, `c_double`), and so does the control `cv_hd`;
the control `ArcMap.linkage_dot_ne_zero` the standard three. `scripts/Axioms.lean`: the seven records added to the "FS131-I5h" block (`cv_class`
already had its record).

### Theorems this phase proved

All [kernel], axioms `[propext, Classical.choice, Quot.sound]` (`data/fs131/i5k/I5kAxioms34.out`):
- `HadwigerNelson.Plane.ArcMap.flank_two_sectors_at_S_gen` (`Plane/ValidMap/Terminal.lean`) — E5 § 3.4 at any bounds in `[−1, 1]` (E5 § 3.5's
  claim): an upper flank with no in-type contact at `N` has at least two sectors at `S′`.
- `ArcMap.κ_le_of_disjoint_end`, `ArcMap.tanBelow_of_mem_sector_end`, `ArcMap.exists_tanAbove_of_sector_end`, `angle_pinch_ends`,
  `not_mem_angleIcc_S_add`, `ArcMap.IsFlankBelow.unique` (`Terminal`) — its chart, angle and flank children.
- `ArcMap.cv_class` is proved **over** `cv_hd` and `c_double` (its axioms include `sorryAx` until those land).

### What is left of my set (7 of 11), and where it stands (for the next `Terminal` implementer)

- **`cv_hd`** (M, over `cv_hd_main`): the cycle `G_N → υ± = 1 → H_S → λ± = −1 → G_N`. `G_N → υ±` is already in the kernel inside `n3_end`'s
  proof (its `right` branch: `outType_N_of_flankAbove` forces `κ₂ = 1`; `stuck_flanks_ua` and `outType_S_of_flankBelow` force `κ₃ = −1`):
  extract it as a child. `H_S → λ±` is the same lemma in the frame turned by `π` (as `cv_class`'s "None" case turns it: `c`'s horn along
  `α + π`, `IsHorn.congr` for the other horn along `α + 2π`, `e (α + π + π/2) = −e (α + π/2)`, `IsFlankBelow.unique`). `υ± → H_S` is
  `cv_hd_main`; `λ± → G_N` is `cv_hd_main` turned by `π`.
- **`cv_hd_main`** (H: FS114-CVB § 1.6, both branches; its `¬G_N` branch consumes `y3_end_needs`), **`y3_end_needs`** (H: YB3 § 3.1): not started.
- **`c_double`** (E–M over `cv_hd`): all four arcs unit gives `λ±`, hence `G_N ∧ H_S` by `cv_hd`; the (Q) arcs from `flankQ_upper_of_qrOnly` /
  `flankQ_lower_of_qrOnly` (`QROnly`: both side colours at the centre, so not (R2)). `flankQ_upper`/`flankQ_lower` are `sorry` on this branch
  (wave 4's stale copy; proved on `main`), so `c_double` reads `sorryAx` through them until the merge with `main`.
- **`c_ends`** (M, with `stuckAlong_of_run`), **`exists_red`**, **`exists_terminal`** (H, the limit constructions), **`cv_exists`** (`BaseDense`,
  over `exists_terminal`, CVB § 1.4 items 3–6): not started.

**Drafts for the front page**: none — wave 5 is not at its gate.

## Stage 34 — SAVED

## Stage 35 — SAVED (FS131-I5l): the readback

*FS131-I5l, wave 5's fourth `Terminal` implementer (Opus), continuing FS131-I5k's work on branch `fs131-w5c` in
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` from `8458054e`. Brief: `data/fs131/briefs/FS131-I5l-terminal.md` (main tree). My set (ruling
341), in its order: `cv_hd` over `cv_hd_main` (with `y3_end_needs`), `c_double`, `c_ends`, then `exists_red`, `exists_terminal`, `cv_exists` (`BaseDense`, its
lines only).*

### 35.1 The brief's quotations against their sources (standing rule 3)

Checked by script, `tools/fs131_i5h_quotes.py` (I5h's checker, in my touches): **10 quotations, 0 failures** — `CLAUDE.md` § Counter-priors; the
inventory's items 340, 341, 274, 295; this record's Stage 34 (four bullets: `cv_hd`, `cv_hd_main`/`y3_end_needs`, `c_double`, the last four leaves); the
plan's § 10.2 ("It may"). `--self-test` (a one-letter plant in the first quotation): **fired** (1 failure reported), the unplanted run passed.

Read in full: I5h's Stage 28; I5k's Stages 32–34; inventory item 341 in full (the order and the alternative weighed); FS114-CVB §§ 1.3–1.8
(`plans/FS114-CVB-verification.md` l. 69–204: the frame, CV-EXISTS, CV-L0, CV-HD both branches, CV-CLASS, CV-ENDS); YB3 § 3.1
(`plans/FS112-YB3-verification.md` l. 154–229: Steps 1–4, the BOWTIE exception, the corrected statement); the plan's §§ 3.2, 4, 8.2 (the rows of my
leaves), 9.1 (`stuckAlong_of_run`, the name correction `IsHorn.isRingArc_upper` → `flankQ_upper_of_qrOnly`). No mismatch found.

### 35.2 The as-given build (`8458054e`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1755 modules already up
to date, nothing built, 8 modules with warnings**, exit 0 (`build/gate/build/20261005T060209Z-1822165.log`; driver log
`data/fs131/i5l/build-stage35-asgiven.log`). Every warning `declaration uses 'sorry'`: `Terminal` 7 (my seven), `Dense` 1, `HexRing` 6, `BaseWalk` 5,
`BaseDense` 3 (`cv_exists` among them), `MapGraph` 3 — wave 5 **25**, I5k's count.

## Stage 35 — SAVED

## Stage 36 — SAVED (FS131-I5l): `cv_hd`, `c_double`, `c_ends` proved; `cv_hd_main` reduced to its branch `G_N` and `y3_end_needs`

**What this stage proves.** `cv_hd` (FS114-CV-HD's equivalences), `c_double` (FS112-C-DOUBLE) and `c_ends` (FS112-C-ENDS, erratum form) no longer
use `sorry` themselves; `cv_hd_main` is assembled over its two branches. No statement changed; no `axiom`; no `native_decide`. Declarations moved
(statements untouched, `tools/fs131_i5h_stmt_check.py` reads by name): `IsFlankBelow.unique` up before CV-HD (it is read there now), `y3_end_needs`
before `cv_hd_main` (its `¬G_N` branch), `c_ends` after `cv_class` (it reads CV-CLASS), under a section "FS112-C-ENDS (placed after `cv_class`)".

**The routes** (every step went through; none failed):

| leaf | hand route | Lean |
|---|---|---|
| `cv_hd` | CVB § 1.6 "Hence": `G_N ⇒ υ± ⇒ H_S ⇒ λ± ⇒ G_N` | the Siamese arrow `upper_bounds_of_inType_N` (n3_end's second-branch argument at any lower bounds) and `cv_hd_main`, each in both frames; the frame turned by `π` is `stuck_turned_frame` (the horn along `α + π + π`, the flanks swapped, the poles swapped) |
| `cv_hd_main` | CVB § 1.6, two branches on `G_N` | `¬G_N`: `y3_end_needs` (its statement verbatim); `G_N`: the new child **`cv_hd_main_inType`** (open), CVB's "Branch `G_N`" (seven colours at `N`) |
| `c_double` | CVB § 1.6 "Hence" (FS114-CV's route, R-CDOUBLE) | `cv_hd` gives `H_S` and `G_N` from `υ± = 1`; each horn arc is FLANK-Q's ring arc (`flankQ_upper_of_qrOnly`, `flankQ_lower_of_qrOnly`, in both frames), its (R2) branch excluded by the in-type flank colour carried at the centre, so (Q) with four colours; the `−a` horn's `N` arc is read a turn back (`IsQArc.add_int_mul`) |
| `c_ends` | CVB § 1.8 (CV-ENDS) | the end vertex is a chain vertex stuck along `±e α` (`stuckAlong_of_mem_stuckRun`: the plan's `stuckAlong_of_run` by induction on `\|j\|`); CV-CLASS there (`cv_class`, with the axis fixed by `stuck_structure_at_axis`) makes each neighbour along `±n` four-coloured or stuck (`four_or_stuck_of_chainVertex`); the neighbour beyond the end is not a chain vertex, so a stuck one has four colours |

**`stuckAlong_of_run` (plan § 9.1, "M–H; the one structural lemma the chain rows share")**, proved by a shorter route than NB3's: a colour of
`v` (the two-sector colour, out-type at `v ± n`) is carried at the chain neighbour `w`; at `w` every colour approaches along both directions of
`w`'s axis `β` (`stuck_structure_ua`); `v` is a contact of that colour on `ω(w)`, of one type, so both `e β` and `−e β` lie in one closed
half-plane (`coneAt_subset_allowedCone`), forcing `e β ⊥ v − w`. **A generalization** for the report: the axis propagates with no use of `≤ 3`
colours at `v`, of terminality, or of the cone colour's alternation.

**Children added** (all `Terminal`, all proved): `upper_bounds_of_inType_N`, `stuck_turned_frame`, `IsQArc.add_int_mul`, `StuckAlong.congr`,
`stuck_structure_at_axis`, `stuckAlong_of_run`, `stuckAlong_of_mem_stuckRun`, `four_or_stuck_of_chainVertex`; one open child, `cv_hd_main_inType`
(CVB § 1.6's branch `G_N`, stated as the branch: `hυ` substituted, `G_N` and `¬H_S` as hypotheses). Names checked unique by `git grep` over
`main`, `origin/fs131-w5`, `origin/fs131-w5p`, `origin/fs131-ww`, `origin/fs131-w4mm` (to be re-run at the next stage before the handover).

**A tool defect, fixed** (my touches include `tools/fs131_i5h_*.py`): `tools/fs131_i5h_stmt_check.py --self-test`'s first plant **did not fire** —
its bare string first matched `n3_end_four_colours` (added after the base `72149b07`, so unchecked), and the plant edited that instead. Re-aimed
inside `n3_end_of_not_inType`; the self-test now fires all three plants, the unplanted control passes.

**Statements unchanged**: `tools/fs131_i5h_stmt_check.py 72149b07`: **PASS** (exit 0); `… 8458054e` (my launch): **PASS**.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 5 modules rebuilt, 8 with warnings, every warning `declaration uses
'sorry'`**, exit 0, 8 min 49 s (`build/gate/build/20261005T061611Z-1871940.log`, ends "Build completed successfully (5370 jobs)"; driver log
`data/fs131/i5l/build-stage36.log`). `Terminal`'s `sorry` declarations: **4** (`exists_red`, `exists_terminal`, `y3_end_needs`, `cv_hd_main_inType`);
wave 5 **22** (25 at launch).

**Axioms, read from this build's oleans** (`data/fs131/i5l/I5lAxioms36.lean` → `I5lAxioms36.out`, 12 GiB slot, exit 0): the eight proved children
on `[propext, Classical.choice, Quot.sound]`; `cv_hd_main`, `cv_hd`, `c_double`, `four_or_stuck_of_chainVertex`, `c_ends` read `sorryAx` (through
`cv_hd_main_inType`, `y3_end_needs`, and the branch's stale `flankQ_upper`/`flankQ_lower`, proved on `main`); controls: `y3_end_needs` reads
`sorryAx`, `ArcMap.linkage_dot_ne_zero` the standard three. `scripts/Axioms.lean`: the nine new records added to the "FS131-I5h" block.

**Re-pricing** (the brief: "from your first two hard leaves"). `cv_hd` and `c_double` cost about 25k tokens of context together, `c_ends` with
`stuckAlong_of_run` about 20k: the toolkit carried every step. The open hard leaves are of another kind: `cv_hd_main_inType` and `y3_end_needs` each
need a full local chart at `N` (and at `N + n`) and five to seven MERGE/separation arguments — one session each on this rate; `exists_red` and
`exists_terminal` are limit constructions over the moves, and cite W-MERGE (`exists_merge`), which ruling 295 bars from wave 5 (see the handover).

### Theorems this phase proved

All [kernel], axioms `[propext, Classical.choice, Quot.sound]` (`data/fs131/i5l/I5lAxioms36.out`):
- `HadwigerNelson.Plane.ArcMap.upper_bounds_of_inType_N` (`Plane/ValidMap/Terminal.lean`) — CV-HD's Siamese arrow `G_N ⇒ υ± = 1`.
- `ArcMap.stuck_turned_frame`, `ArcMap.IsQArc.add_int_mul`, `ArcMap.StuckAlong.congr`, `ArcMap.stuck_structure_at_axis` (`Terminal`).
- `ArcMap.stuckAlong_of_run` (`Terminal`) — the plan's shared chain lemma: the axis propagates to a chain neighbour; `ArcMap.stuckAlong_of_mem_stuckRun`.
- proved **over open leaves** (their axioms include `sorryAx` until those land): `ArcMap.cv_hd` (over `cv_hd_main`), `ArcMap.cv_hd_main` (over
  `cv_hd_main_inType`, `y3_end_needs`), `ArcMap.c_double` (over `cv_hd`, `flankQ_*`), `ArcMap.c_ends` and `ArcMap.four_or_stuck_of_chainVertex`
  (over `cv_class`).

## Stage 36 — SAVED

## Stage 37 — SAVED (FS131-I5l): `cv_exists` proved over `exists_terminal`, with no CV-HD

**What this stage proves.** `cv_exists` (FS114-CV-EXISTS, `BaseDense`, its lines only) no longer uses `sorry` itself: it rests on `exists_terminal`
(open, by statement) and `dense3`. Statement unchanged; the docstring's route sentence names the new children. No `axiom`; no `native_decide`.

**The route, against FS114-CVB § 1.4** (every step went through; none failed):

| CVB § 1.4 | Lean |
|---|---|
| `M*` (N2-TERM); suppose it has no vertex of four or more colours | `exists_terminal`; a four-colour point of `M*` would carry its colours in `F` (`IsModification.coloursAt_subset`), so `#P_cl ≤ 3` everywhere in `M*` |
| item 2: stuck vertices exist (DENSE3; N2-TERM item 2) | `dense3` on `M*`; its point is not in `F(M*)`, so it carries a repeated colour, hence is stuck (`isStuck_of_hasRepeatedColour`: terminal), along the axis of its horns (`stuck_horns_ua`) |
| items 1, 4: every unit arc (R2), so FLANK holds as under Condition 5 (`G_N`, `H_S` absent) | an in-type flank at a pole forces its horn arc onto the pole's unit circle (`upper_bounds_of_inType_N`), FLANK-Q's ring arc (`flankQ_upper_of_qrOnly`), both-kind there: (Q) needs four colours, (R2) needs the flank colour absent — so `¬G_N`, `¬H_S` |
| item 5: `h` twice at `N` (and `g` twice at `S′`) | `flank_two_sectors_at_S_gen` at `S` and in the turned frame (`stuck_turned_frame`), as `cv_class`'s "None" case |
| item 6: the chain runs on, on the same axis; bi-infinite | both neighbours stuck with `≤ 3` colours, so chain vertices (`chainVertex_neighbours_of_noFour`); the axis by `stuckAlong_of_run`; induction on `\|j\|` (`stuckRun_eq_univ_of_noFour`) |
| item 7: N4-FIN forbids it | `exists_terminal`'s clause 3: the run is not `univ` |

CVB's item 3 (CV-L0) and its `|P_cl(N)| ≤ 3` count are not needed: E5 § 3.4's general form gives the two sectors directly. `cv_exists` uses neither CV-HD
nor C-ENDS, as its docstring and CVB say.

**Children added** (`Terminal`, after `c_ends`): `chainVertex_neighbours_of_noFour`, `stuckRun_eq_univ_of_noFour`. Names checked unique by `git grep`
over `main`, `origin/fs131-w5`, `origin/fs131-w5p`, `origin/fs131-ww`, `origin/fs131-w4mm` (each ref verified to exist, positive control
`exists_shave` found on each); so are all of Stage 36's.

**Statements unchanged**: `tools/fs131_i5h_stmt_check.py 72149b07`: **PASS** (exit 0).

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 5 modules rebuilt, 8 with warnings, every warning `declaration uses
'sorry'`**, exit 0, 8 min 49 s (`build/gate/build/20261005T063146Z-1980470.log`, ends "Build completed successfully (5370 jobs)"; driver log
`data/fs131/i5l/build-stage37.log`). `BaseDense`'s `sorry` declarations: **2** (`exists_preBend`, `exists_unenclosed_or_bad`, neither mine); wave 5 **21**.

**Axioms, read from this build's oleans** (`data/fs131/i5l/I5lAxioms37.lean` → `I5lAxioms37.out`, 12 GiB slot, exit 0): `chainVertex_neighbours_of_noFour`
and `stuckRun_eq_univ_of_noFour` read `sorryAx` **only through this branch's stale `flankQ_upper`** (proved on `main`; every other input is on the
standard three: `upper_bounds_of_inType_N`, `stuck_turned_frame`, `stuck_structure_at_axis`, `flank_two_sectors_at_S_gen`, `stuckAlong_of_run`,
`isStuck_of_hasRepeatedColour`); `cv_exists` reads `sorryAx` (also through `exists_terminal` and `dense3`'s base); controls: `exists_terminal` reads
`sorryAx`, `stuckAlong_of_run` the standard three. `scripts/Axioms.lean`: the two records added to the "FS131-I5h" block (`cv_exists` had its record).

### Theorems this phase proved

- `HadwigerNelson.Plane.ArcMap.chainVertex_neighbours_of_noFour`, `ArcMap.stuckRun_eq_univ_of_noFour` (`Plane/ValidMap/Terminal.lean`) — CVB § 1.4
  items 4–6 (with no four-colour vertex every stuck run is bi-infinite), [kernel] over the branch's stale `flankQ_upper` (axioms `[propext, sorryAx,
  Classical.choice, Quot.sound]` here; the standard three at the merge with `main`).
- `ArcMap.cv_exists` (`Plane/ValidMap/BaseDense.lean`) — FS114-CV-EXISTS, proved **over** `exists_terminal` (open) and `dense3`.

## Stage 37 — SAVED

## Stage 38 — SAVED (FS131-I5l): the shared first step of the two `G_N`-level leaves, the MERGE engine; the CV-HD block placed after NB3-END's lemmas; the handover

**What this stage proves.** Three children for the two open CV-HD-level leaves, all kernel theorems on the standard three: `dot_eq_zero_of_antipodal_contact`
(the perpendicularity engine of `stuckAlong_of_run`, stated alone), `mergeAvailable_of_not_mem_pole` (CVB § 1.6's repeated step "`D_r(N)` has interior
unless it is the line `±a`, which needs a contact at `E`; W-MERGE"), and `lower_flank_horns_at_N` (CVB § 1.4 item 5 / § 1.6 and YB3 § 3.1 Steps 2–3:
with `κ₃ = −1` and `¬H_S`, the point `N` is stuck with at least four colours and `h` has exactly two sectors there, cusp horns `Q±` along `±e α` with
bounds in `[−1, 1]` and out-type contacts at `N + n` and `E`). No statement changed; no `axiom`; no `native_decide`.

**A block moved** (statements untouched): `upper_bounds_of_inType_N` … `c_double` (the CV-HD main clause, its `G_N` child, `y3_end_needs`, `cv_hd`,
`c_double`) now sit after NB3-END's lemmas, under the section "FS114-CV-HD's main clause and equivalences, FS112-Y3-END-NEEDS, FS112-C-DOUBLE (placed
after NB3-END's lemmas, which their open leaves read)", so the open leaves may cite `flank_two_sectors_at_S`, `n3_end_four_colours`, `n3_end_bothKind`
and the three new children. `cv_l0` stays in place.

**Statements unchanged**: `tools/fs131_i5h_stmt_check.py 72149b07`: **PASS** (exit 0). New names unique by `git grep` over `main`, `origin/fs131-w5`,
`origin/fs131-w5p`, `origin/fs131-ww`, `origin/fs131-w4mm`.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 5 modules rebuilt, 8 with warnings, every warning `declaration uses
'sorry'`**, exit 0, 8 min 42 s (`build/gate/build/20261005T064611Z-2087752.log`, ends "Build completed successfully (5370 jobs)"; its one `error:` line
is the up-to-date probe's "target is out-of-date"; driver log `data/fs131/i5l/build-stage38.log`). `Terminal`'s `sorry` declarations: **4**
(`exists_red`, `exists_terminal`, `y3_end_needs`, `cv_hd_main_inType`); wave 5 **21** (`Terminal` 4, `BaseDense` 2, `BaseWalk` 5, `HexRing` 6,
`MapGraph` 3, `Dense` 1); 25 at my launch.

**Axioms, read from this build's oleans** (`data/fs131/i5l/I5lAxioms38.lean` → `I5lAxioms38.out`, 12 GiB slot, exit 0): the three new children on
`[propext, Classical.choice, Quot.sound]`; the moved `cv_hd`, `c_double` read `sorryAx` (over the open leaves); controls: `cv_hd_main_inType` reads
`sorryAx`, `upper_bounds_of_inType_N` the standard three. `scripts/Axioms.lean`: the three records added to the "FS131-I5h" block.

### Theorems this phase proved

All [kernel], axioms `[propext, Classical.choice, Quot.sound]` (`data/fs131/i5l/I5lAxioms38.out`):
- `HadwigerNelson.Plane.ArcMap.dot_eq_zero_of_antipodal_contact` (`Plane/ValidMap/Terminal.lean`) — a contact on `ω(w)` is perpendicular to an
  antipodal pair of the colour's cone at `w`.
- `ArcMap.mergeAvailable_of_not_mem_pole` (`Terminal`) — W-MERGE at `w` for a colour with two or more sectors, a cone direction `β`, and absent at one
  of `w ± e(β + π/2)`.
- `ArcMap.lower_flank_horns_at_N` (`Terminal`) — the lower flank's two horns `Q±` at `N` along `±e α`, `N` stuck with four or more colours.

### The handover: what is proved, what is left (for the next `Terminal` implementer)

**Proved over open leaves this session**: `cv_hd` (over `cv_hd_main`), `cv_hd_main` (over `cv_hd_main_inType`, `y3_end_needs`), `c_double` (over
`cv_hd`), `c_ends` (over `cv_class` → `cv_hd`), `cv_exists` (over `exists_terminal`). `chainVertex_neighbours_of_noFour`, `stuckRun_eq_univ_of_noFour`,
`c_double` also read `sorryAx` through this branch's stale `flankQ_upper`/`flankQ_lower` (proved on `main`; they collapse at the merge).

**Left (4 in `Terminal`, none in `BaseDense`'s lines of this lane)**:
1. **`cv_hd_main_inType`** (H; CVB § 1.6 "Branch `G_N`"). Route in Lean: `lower_flank_horns_at_N` gives `Q±` (the `h`-horns at `N` along `±a`), `N`
   stuck, `≥ 4` colours; `c, g, h ∈ P_cl(N)` (`horn_poles_contact`, `G_N`, `Q±`). The ring tiles: `cv_l0` at `E` makes `Γ ∩ ω(E)` finite, so the arc of
   `ω(E)` just right (left) of `N` lies in one tile `T₊` (`T₋`), whose colour `r₊` (`r₋`) is not carried at `E` (N-E1, `ne1_region`: a point of the
   class at distance `1` from `E`) and is carried at `N` (the arc accumulates at `N`; colour constant along it by `IsPreconnected.constant` on the
   interior points). Distinctness, each by `mergeAvailable_of_not_mem_pole` at `N` with `β = α` (the pole `N − n = E` carries none of `r±, x₁, x₂`):
   `r₊ ≠ r₋`, `x₁ ∉ {r₊, r₋}`, `x₂ ∉ {r₊, r₋, x₁}` — each needs the two sectors to be **distinct sectors at `N`**, which is the real work: read the
   sector chart at `N` (`localSectors`, `IsSectorChart`; a horn's flanks are the chart's adjacent indices, `IsSectorChart.exists_flank_after` /
   `_before`), with `c`'s sectors confined to the pinch about `+n` (U1, `ringArc_cone_outer`, the arcs of `ω(N)` bounding `E`'s horns have outer
   colour `c`) and `g`'s below `ω(E)` (in-type at `N`), so no sector at `N` wraps from the `+a` side to the `−a` side. `x₁, x₂ ∉ {c, g, h}`: `≠ h`
   (a flank is not the horn's colour), `≠ c` (outside the pinch), `≠ g` (CVB: an out-type `g`-contact of `ω(E)` at `N` would force `D_g(E) ⊆ {d·n ≤ 0}`).
   Seven colours in `Fin 6`: `Finset.card_le_univ`. Price: one session.
2. **`y3_end_needs`** (H; YB3 § 3.1 Steps 3–4). Step 2 is `lower_flank_horns_at_N` (its hypotheses are exactly `y3_end_needs`'s with `κ₂ = 1`).
   Step 3 at `N`: the upper flanks `x₁ ≠ x₂` and the lower flank `y` of `Q±`, five colours `{c, h, x₁, x₂, y}` (distinctness by
   `mergeAvailable_of_not_mem_pole`, and `IsHorn` flank facts); Step 4 at `N + n`: no SHAVE at `N` needs an in-type `x₁` at `N + n` (so `Q₊`'s upper arc
   is on `ω(N + n)`: `upper_bounds_of_inType_N`'s argument one level up) and an out-type `y` at `N + n` tangent to `±a`; then `y`'s two sectors at `N + n`
   are horns (`lower_flank_horns_at_N`'s pattern one level up, or `stuck_horns_ua` and `dot_eq_zero_of_antipodal_contact`) with upper flanks
   `z₁ ≠ z₂` outside the five — seven colours. YB3's FLANK-at-`N` sharpening (b) (contact arcs of `ω(N)`) is the step most likely to need a new
   chart lemma. Price: one session.
3. **`exists_red`, `exists_terminal`** (H, the limit constructions): **both cite W-MERGE (`exists_merge`)** — N2-RED merges at the centre of every
   both-kind arc with three colours there (neither bend applies), and N2-TERM's `Terminal` clause needs every available MERGE performed. Ruling 295
   bars `exists_merge` from wave 5 ("it would change if wave 5's skeleton came to cite `exists_merge` before wave 4's merge-and-gate starts"), and
   `main` no longer declares it. Held for the coordinator; not started.

**Drafts for the front page**: none — wave 5 is not at its gate.

## Stage 38 — SAVED

## Stage 39 — SAVED (FS131-I5n): the readback

*FS131-I5n, wave 5's fifth `Terminal` implementer (Opus), continuing FS131-I5l's work on branch `fs131-w5c` in
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` from `6d316ef2`. Brief: `data/fs131/briefs/FS131-I5n-terminal.md` (main tree). My set (ruling
350): first ruling 348 (a)'s swap of `exists_merge`'s statement in `Contact` for `fs131-w4mm`'s ruling-269 text, then `cv_hd_main_inType`,
`y3_end_needs`, `exists_red`, `exists_terminal`.*

### 39.1 The brief's quotations against their sources (standing rule 3)

Checked by script, `tools/fs131_i5h_quotes.py` (I5h's checker, in my touches): **12 quotations, 0 failures** — `CLAUDE.md` § Counter-priors; this
record's Stage 38 (three handover items: `cv_hd_main_inType`, `y3_end_needs`, the limit constructions); `fs131-w4mm`'s `Contact.lean` (`exists_merge`'s
first line); the inventory's items 347, 268, 269, 348, 350, 274; the plan's § 10.2 ("It may"). `--self-test` (a one-letter plant in the first quotation):
**fired** (1 failure reported), the unplanted run passed (exit 0).

Read in full: I5l's Stages 35–38; inventory items 268, 269, 274, 347–350; FS114-CVB §§ 1.4–1.6 (`plans/FS114-CVB-verification.md` l. 100–175: CV-EXISTS's
items 5–7, CV-L0, CV-HD both branches and "Hence"); YB3 § 3.1 (`plans/FS112-YB3-verification.md` l. 154–229: Steps 1–4, the shadow cases (i)–(ii),
BOWTIE, the corrected statement); the plan's rows for `exists_terminal` and `exists_red` (§ 3.2, l. 122–123) and § 9.1's row (l. 391), § 2.2's
"valid modification" row (the adversary). No mismatch found.

**The stale MERGE, confirmed by script before the swap** (`tools/fs131_i5n_merge_swap.py --check`, new, against the committed ref `origin/fs131-w4mm` =
`0cdac72c`, never that tree's working copy, which FS131-IMM3 edits): exit 1, the two blocks differ at exactly the clause of item 268 (`(∀ x ∉ sphere v ρ,
F'.coloursAt x ⊆ F.coloursAt x)` here, `F'.coloursAt v ⊆ F.coloursAt v` there) and the docstring phrase ruling 269 rewrites ("no point off the disc's rim
gains a colour" here, "`v` gains no colour" there). Nothing in `fs131-w5c` cites `exists_merge` (`git grep -n "exists_merge\b"`: its declaration only).

### 39.2 The as-given build (`6d316ef2`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1755 modules already up
to date, nothing built, 8 modules with warnings**, exit 0 (`build/gate/build/20261005T070437Z-2195522.log`; driver log
`data/fs131/i5n/build-stage39-asgiven.log`). `Terminal`'s warnings: 4 (`exists_red` l. 650, `exists_terminal` l. 662, `y3_end_needs` l. 2169,
`cv_hd_main_inType` l. 2182) — I5l's count.

## Stage 39 — SAVED

## Stage 40 — SAVED (FS131-I5n): ruling 348 (a)'s swap — `exists_merge` in ruling 269's form

**What this stage changes.** In `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean`, `exists_merge`'s docstring and statement are replaced by the text of
`fs131-w4mm`'s `Contact` `exists_merge` (ruling 269's form), copied by script; its `sorry` body is kept. No other line of `Contact` changed; no proof
cites `exists_merge` on this branch.

**The copy, by script** (`tools/fs131_i5n_merge_swap.py`, new): `--apply` reads the block (from the docstring opening `/-- **FS110-W-MERGE**` through the
statement's `:= by`) from the committed ref `origin/fs131-w4mm` (= `0cdac72c`; never that tree's working copy, which FS131-IMM3 edits) and writes it over
this tree's block. The diff it applied:

```
-`c` has `n` sectors at `v`, no point off the disc's rim gains a colour, the new points on the rim carry at most three colours
+`c` has `n` sectors at `v`, `v` gains no colour, the new points on the rim carry at most three colours
-      (F.Condition5 → F'.Condition5) ∧ F'.HasSectors v c n ∧ (∀ x ∉ sphere v ρ, F'.coloursAt x ⊆ F.coloursAt x) ∧
+      (F.Condition5 → F'.Condition5) ∧ F'.HasSectors v c n ∧ F'.coloursAt v ⊆ F.coloursAt v ∧
```

`--check` afterwards: **IDENTICAL** (1054 characters, 11 lines; the body after `:= by` begins `sorry`), exit 0. `--self-test` (plants `F'.coloursAt w` for
`F'.coloursAt v` in this tree's block): **fired** (DIFFERENT, exit 0 for the self-test). Before the swap `--check` read DIFFERENT, exit 1 (Stage 39).
**Every statement of `Contact` against `6d316ef2`** (I5h's checker's statement reader, run over `Contact` by a one-off script): 180 declarations then and
now; changed: `exists_merge` only; none missing, none new.

**The lane's statement checker**: `tools/fs131_i5h_stmt_check.py 72149b07`: **PASS** (exit 0). It reads `Terminal`, `BaseDense` and `FlankUA` only, not
`Contact`, so it does not report the swap — the script and the one-off read above do.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 9 modules rebuilt (`Contact`'s dependents: its docstring is environment data),
8 with warnings, every warning `declaration uses 'sorry'`**, exit 0, 9 min 39 s (`build/gate/build/20261005T070700Z-2207119.log`, ends "Build completed
successfully (5370 jobs)"; its one `error:` line is the up-to-date probe's "target is out-of-date"; driver log `data/fs131/i5n/build-stage40-swap.log`).
`Contact`'s `sorry` warnings on this branch: l. 4064, 4078, 4094 (`exists_shave`, `exists_rayMerge`, `exists_merge` — wave 4's, stale here, all three
unchanged in status); `Terminal`'s: 4, as at launch.

## Stage 40 — SAVED

## Stage 41 — SAVED (FS131-I5n): `cv_hd_main_inType` proved (CVB § 1.6's branch `G_N`), a kernel theorem

**What this stage proves.** `cv_hd_main_inType` no longer uses `sorry`, and reads no open leaf: it is a kernel theorem on the standard three. No
statement changed (its docstring's route sentence now describes the route taken); no `axiom`; no `native_decide`. Fourteen children added, all kernel.

**The route, against CVB § 1.6 "Branch `G_N`"** (every step went through; none failed). CVB counts seven colours at `N`: `c, g, h`, the ring colours
`r₊ ≠ r₋`, the upper neighbours `x₁ ≠ x₂` of `Q±`. In Lean the count is the same in kind with the **four sectors flanking `Q±` in the sector chart at
`N`** in place of the ring tiles (no chart lemma for the ring tiles is needed):

| step | Lean |
|---|---|
| `N` stuck, `h` exactly two sectors `Q±` along `±e α` | `lower_flank_horns_at_N` (I5l) |
| `c`'s cone at `N` in the pinch about `+n` (U1, CVB "`c`'s sectors at `N` lie in the pinch around `+n`") | `coneAt_N_subset_of_horn` (the `+e α` horn) and `coneAt_S_subset_of_horn` in the frame turned by `π` |
| `g`'s cone at `N` in the pinch about `−n` (CVB: "`g` in-type, in U1's inner cone facing `−n`") | **new**: `coneAt_N_subset_of_flankAbove` (the flank above the `+e α` horn, upper arc on `ω(N)`) and `coneAt_S_subset_of_flankBelow` in the turned frame (the flank `g` below the `−e α` horn, its arc on `ω(N)`), each from a radial segment just inside `ω(N)` (`flank_radial_N`/`_S`) and `Valid.cos_nonneg_of_radial_inner` |
| `Q±` as chart sectors `ip`, `im`; the sectors just after and before each (`a`, `b`, `c'`, `d`) | `index_of_isSector_hornSet`; **new** `BranchGerms.exists_succ`, `exists_pred` |
| each of the four colours carries `α` or `α + π` in its cone, so is not `c` or `g` (U1) | `coneAt_mono`, **new** `mem_coneAt_of_e_eq`, `not_mem_angleIcc_of_gap` |
| … nor `h` (three chart sectors of `h` against `HasSectors N h 2`) | **new** `IsSectorChart.card_le_encard_sectorsOf` |
| so absent at `E = N − n`, and two of them equal on distinct sectors is MERGE at `N` (CVB's repeated W-MERGE step) | `mergeAvailable_of_not_mem_pole` through **new** `mergeAvailable_of_two_sectors` |
| distinct sectors: `ip ≠ im`, flanks off `Q±`, `a ≠ d`, `b ≠ c'` by their germs; `a ≠ b`, `c' ≠ d` by sortedness (a sector a whole turn wide leaves no room for `Q∓`) | **new** `BranchGerms.Mono.false_of_full`, `mem_angleIoo_of_e_ne` |
| `a ≠ c'` (the upper side is not one sector): `c` has a sector there, inside the open upper half-turn | **new** `IsSectorChart.exists_index_of_mem_coloursAt`, `mem_angleIoo_half`, `Mono.disjoint` |
| `b ≠ d` (the lower side is not one sector): `g` has a sector there, inside the open lower half-turn — CVB's "the `g`-sector separates them through the bottom" | the same, in the turned frame |
| seven distinct colours in `Fin 6` | `List.Nodup.length_le_card` |

**A generalization** (for the report): the proof reads only `g ∈ P_cl(N)` from `G_N` (`hGN.1.2.2`), not the in-type clause, and no curvature bound of
`Q±`. So `κ₂ = 1`, `κ₃ = −1`, `¬H_S` and `g ∈ P_cl(N)` already give seven colours at `N` — consistent with YB3 § 3.1 Step 3's sharpening (a), which in the
`¬G_N` branch puts `g ∉ P_cl(N)`. **U1 for the inner colour** (`coneAt_N_subset_of_flankAbove`) is new infrastructure: the existing U1 lemmas bound the
outer colour.

**Children added** (`Plane/ValidMap/HornShadow`, after `coneAt_N_subset_of_horn`): `flank_radial_N`, `flank_radial_S`, `coneAt_N_subset_of_flankAbove`,
`coneAt_S_subset_of_flankBelow`. (`Plane/ValidMap/Terminal`, a new section "Angles mod `2π` and germ order" before the first `namespace ArcMap`):
`mem_coneAt_of_e_eq`, `not_mem_angleIcc_of_gap`, `mem_angleIoo_of_e_ne`, `mem_angleIoo_half`, `BranchGerms.exists_succ`, `BranchGerms.exists_pred`,
`BranchGerms.Mono.false_of_full`; (`Terminal`, after `mergeAvailable_of_not_mem_pole`): `IsSectorChart.card_le_encard_sectorsOf`,
`mergeAvailable_of_two_sectors`, `IsSectorChart.exists_index_of_mem_coloursAt`. Names checked unique by `git grep` over `main`, `origin/fs131-w5`,
`origin/fs131-w5p`, `origin/fs131-ww`, `origin/fs131-w4mm`, `origin/fs131-w5c` (each ref verified; positive controls `lower_flank_horns_at_N`,
`exists_flank_after` found). Models in the docstrings of the hypothesis-carrying ones: `bowtie` at `0` (`bowtie_valid`, `bowtie_flanks`).

**Statements unchanged**: `tools/fs131_i5h_stmt_check.py 72149b07`: **PASS** (exit 0).

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 6 modules rebuilt, 8 with warnings, every warning `declaration uses
'sorry'`**, exit 0, 9 min 1 s (`build/gate/build/20261005T072751Z-2311355.log`, ends "Build completed successfully (5370 jobs)"; driver log
`data/fs131/i5n/build-stage41.log`). `Terminal`'s `sorry` declarations: **3** (`exists_red`, `exists_terminal`, `y3_end_needs`); wave 5 **20**
(`Terminal` 3, `BaseDense` 2, `BaseWalk` 5, `HexRing` 6, `MapGraph` 3, `Dense` 1; 21 at launch).

**Axioms, read from this build's oleans** (`data/fs131/i5n/I5nAxioms41.lean` → `I5nAxioms41.out`, 12 GiB slot, exit 0): the fourteen children and
`cv_hd_main_inType` on `[propext, Classical.choice, Quot.sound]`; `cv_hd_main`, `cv_hd` read `sorryAx` (through `y3_end_needs`, now their only open
input on this route); controls: `y3_end_needs` and `exists_merge` read `sorryAx`, `upper_bounds_of_inType_N` the standard three. `scripts/Axioms.lean`:
the fourteen new records added to the "FS131-I5h" block (`cv_hd_main_inType` had its record).

**Re-pricing** (the brief: "from your first two hard leaves"). `cv_hd_main_inType` cost about 90k tokens of context with its fourteen children, most
of it reading the chart and cone toolkit; the elaboration went through at the first full attempt after three small fixes. The chart helpers now in
place (`card_le_encard_sectorsOf`, `mergeAvailable_of_two_sectors`, `exists_index_of_mem_coloursAt`, `exists_succ`/`exists_pred`) carry the counting
part of `y3_end_needs`'s Step 3 directly; its Step 4 (shadows at `N + n`) is new work.

### Theorems this phase proved

All [kernel], axioms `[propext, Classical.choice, Quot.sound]` (`data/fs131/i5n/I5nAxioms41.out`):
- `HadwigerNelson.Plane.ArcMap.cv_hd_main_inType` (`Plane/ValidMap/Terminal.lean`) — FS114-CV-HD's main clause, branch `G_N` (CVB § 1.6): seven
  colours at `N`.
- `ArcMap.flank_radial_N`, `ArcMap.flank_radial_S`, `ArcMap.coneAt_N_subset_of_flankAbove`, `ArcMap.coneAt_S_subset_of_flankBelow`
  (`Plane/ValidMap/HornShadow.lean`) — U1 for a flank colour (the inner colour of a unit arc faces it).
- `mem_coneAt_of_e_eq`, `not_mem_angleIcc_of_gap`, `mem_angleIoo_of_e_ne`, `mem_angleIoo_half`, `BranchGerms.exists_succ`, `BranchGerms.exists_pred`,
  `BranchGerms.Mono.false_of_full`, `ArcMap.IsSectorChart.card_le_encard_sectorsOf`, `ArcMap.mergeAvailable_of_two_sectors`,
  `ArcMap.IsSectorChart.exists_index_of_mem_coloursAt` (`Terminal`).

## Stage 41 — SAVED

## Stage 42 — SAVED (FS131-I5n): `y3_end_needs` reduced to its case `g ∉ P_cl(N)`; the handover

**What this stage proves.** `y3_end_needs` no longer uses `sorry` itself: its case `g ∈ P_cl(N)` is closed by the seven-colour count of Stage 41, and
its case `g ∉ P_cl(N)` is a new open child, `y3_end_needs_of_not_mem` (YB3 § 3.1 Steps 3–4: the levels at `N` and `N + n`). No statement changed; no
`axiom`; no `native_decide`.

**How.** Stage 41's proof reads only `g ∈ P_cl(N)` from `G_N`, so it is now stated as that: **`seven_colours_at_N`** (over `Valid`, `IsPlaneMap`,
`Terminal`; `QROnly` is not read), and `cv_hd_main_inType` is a two-line corollary. `y3_end_needs` carries no `QROnly`, so I5l's
`lower_flank_horns_at_N` is now the corollary of **`lower_flank_horns_at_N_of`** (the same proof over `Valid`, `IsPlaneMap`, `Terminal`; the original
statement unchanged). `y3_end_needs` splits on `g ∈ P_cl(N)`: the first case is `seven_colours_at_N`, the second `y3_end_needs_of_not_mem` (whose
statement drops `¬G_N`, which `g ∉ P_cl(N)` implies). The unused hypothesis `hnoG` of `y3_end_needs` is referenced once in its body, so the linter is
silent with its binder name unchanged.

**Statements unchanged**: `tools/fs131_i5h_stmt_check.py 72149b07`: **PASS** (exit 0).

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`), after the linter fix: **OK — 447 of 447 batches, 5 modules rebuilt, 8 with warnings, every warning
`declaration uses 'sorry'`** (0 others; the first run of this stage, `build/gate/build/20261005T074739Z-2455558.log`, showed the unused-variable warning
on `hnoG`, fixed), exit 0, 8 min 43 s (`build/gate/build/20261005T075711Z-2522128.log`, ends "Build completed successfully (5370 jobs)"; driver log
`data/fs131/i5n/build-stage42.log`). `Terminal`'s `sorry` declarations: **3** (`exists_red` l. 799, `exists_terminal` l. 811, `y3_end_needs_of_not_mem`
l. 2605); wave 5 **20** (`Terminal` 3, `BaseDense` 2, `BaseWalk` 5, `HexRing` 6, `MapGraph` 3, `Dense` 1).

**Axioms, read from this build's oleans** (`data/fs131/i5n/I5nAxioms42.lean` → `I5nAxioms42.out`, 12 GiB slot, exit 0, re-run after the final build):
`lower_flank_horns_at_N_of`, `lower_flank_horns_at_N`, `seven_colours_at_N`, `cv_hd_main_inType` on `[propext, Classical.choice, Quot.sound]`;
`y3_end_needs`, `cv_hd_main`, `cv_hd`, `c_double` read `sorryAx` (through `y3_end_needs_of_not_mem`; `c_double` also through this branch's stale
`flankQ_*`); controls: `y3_end_needs_of_not_mem` and `exists_merge` read `sorryAx`, `mergeAvailable_of_two_sectors` the standard three.
`scripts/Axioms.lean`: the three new records added to the "FS131-I5h" block.

### Theorems this phase proved

All [kernel], axioms `[propext, Classical.choice, Quot.sound]` (`data/fs131/i5n/I5nAxioms42.out`):
- `HadwigerNelson.Plane.ArcMap.seven_colours_at_N` (`Plane/ValidMap/Terminal.lean`) — CVB § 1.6's seven-colour count at `N` with `G_N` read as
  `g ∈ P_cl(N)`; `cv_hd_main_inType` its corollary.
- `ArcMap.lower_flank_horns_at_N_of` (`Terminal`) — I5l's `lower_flank_horns_at_N` over `Valid`, `IsPlaneMap`, `Terminal`.
- proved **over an open child**: `ArcMap.y3_end_needs` (over `y3_end_needs_of_not_mem`).

### The handover: what is proved, what is left (for the next `Terminal` implementer)

**Proved this session** (Stages 41–42, kernel on the standard three): `cv_hd_main_inType`, `seven_colours_at_N`, `lower_flank_horns_at_N_of`, U1 for a
flank colour (`coneAt_N_subset_of_flankAbove`, `coneAt_S_subset_of_flankBelow`, the radial lemmas), and the chart toolkit (`card_le_encard_sectorsOf`,
`mergeAvailable_of_two_sectors`, `exists_index_of_mem_coloursAt`, `BranchGerms.exists_succ`/`exists_pred`, `Mono.false_of_full`, the angle lemmas).
`exists_merge` is in ruling 269's form (Stage 40).

**Left (3 in `Terminal`)**:
1. **`y3_end_needs_of_not_mem`** (H; YB3 § 3.1 Steps 3–4, `g ∉ P_cl(N)`). Step 3 with the Stage 41 toolkit: the chart at `N` with `Q±`
   (`lower_flank_horns_at_N_of`), the four flanking sectors `a, b, c', d` and their colours (`exists_succ`/`exists_pred`, `exists_col`), none `c` (U1:
   `coneAt_N_subset_of_horn`, `coneAt_S_subset_of_horn` turned) nor `h` (`card_le_encard_sectorsOf` against `HasSectors N h 2`), absent at `E`, so
   pairwise distinct on distinct sectors (`mergeAvailable_of_two_sectors`); `a ≠ c'` by `c`'s sector (as in `seven_colours_at_N`). Without `g`, the
   lower side may be one sector (`b = d`, YB3's `y`): `P_cl(N) ⊇ {c, h, x₁, x₂, y}`, at most six — the count at `N` cannot finish, as YB3 says. Step 4
   at `N + n`: no SHAVE at `N` (`hstN.2.2.1`) gives an `x₁`-shadow on `Q₊` (and on `Q₋` for `x₂`) and a `y`-shadow; the shadow sources are as in
   `flank_two_sectors_at_S`'s proof (`shadow_of_not_shave`, `srcG_of_shadow`, the `witness_*` lemmas), one level up: in-type `x₁` at `N + n` (so `Q₊`'s
   upper arc on `ω(N + n)`, `upper_bounds_of_inType_N`'s argument at `N`) and out-type `y` at `N + n` tangent to `±a`; then `y` has two sectors at
   `N + n` (its two contacts), horns along `±e α` (`stuck_horns_ua` needs `N + n` stuck: no MERGE of `y` there by `mergeAvailable_of_not_mem_pole`, as
   `y ∉ P_cl(N)`… — to be checked: YB3 reads "no MERGE" of `y` at `N + n`, and `N + n` need not be stuck; `woodallCone_isHorn_ua` with an empty
   `int D_y(N + n)` is the form to use), with upper flanks `z₁ ≠ z₂` outside `{c, h, x₁, x₂, y}` (their tiles outside `B̄(N, 1)`, out-type contacts of
   `N`: `outType_iff`), and `g` absent at `N`… so `z₁, z₂` are two colours outside a five-set, one of which is `g` at most: a seventh colour. Price:
   one session; Step 4's shadow sources at `N + n` are the new work (YB3's FLANK-at-`N` sharpening (b), contact arcs of `ω(N)`, may need a chart
   lemma).
2. **`exists_red`, `exists_terminal`** (H, the limit constructions): may now cite `exists_merge` in ruling 269's form (ruling 348 (a)); not started.
   The plan's row (§ 9.1, l. 391): the measure is the locally finite count, descending per move inside a ball; the limit by local eventual
   constancy. Each also needs the whole-arc bends (N2-RED) and N4-TERM's `Φ` (N2-TERM); `IsModification` is weak (plan § 2.2's adversary), which
   the limit can use. Price: one to two sessions each.

**Drafts for the front page**: none — wave 5 is not at its gate.

## Stage 42 — SAVED

## Stage 43 — SAVED (FS131-I5p): the readback

*FS131-I5p, wave 5's sixth `Terminal` implementer (Opus), continuing FS131-I5n's work on branch `fs131-w5c` in
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` from `da09c260`. Brief: `data/fs131/briefs/FS131-I5p-terminal.md` (main tree). My set (ruling
356): `y3_end_needs_of_not_mem`, then `exists_red`, `exists_terminal` (citing `exists_merge` in ruling 269's form only).*

### 43.1 The brief's quotations against their sources (standing rule 3)

Checked by script, `tools/fs131_i5h_quotes.py` (I5h's checker, in my touches): **12 quotations, 0 failures** — `CLAUDE.md` § Counter-priors; the three
leaves' first lines in `Terminal.lean`; this record's Stage 42 (two handover items); the inventory's items 355, 347, 348, 356, 274; the plan's § 10.2 ("It
may"). `--self-test` (a one-letter plant in the first quotation): **fired** (1 failure reported); the unplanted run passed (exit 0).

Read in full: I5l's Stage 38; I5n's Stages 39–42; inventory items 268, 269, 274, 347, 348, 355, 356; YB3 § 3.1 (`plans/FS112-YB3-verification.md`, Steps
1–4, the corrected statement). No mismatch found.

### 43.2 The as-given build (`da09c260`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1755 modules already up
to date, nothing built, 8 modules with warnings**, exit 0 (`build/gate/build/20261005T081034Z-2600880.log`; driver log
`data/fs131/i5p/build-stage43-asgiven.log`). `Terminal`'s warnings: 3 (`exists_red` l. 799, `exists_terminal` l. 811, `y3_end_needs_of_not_mem` l. 2605) —
I5n's count.

## Stage 43 — SAVED

## Stage 44 — SAVED (FS131-I5p): `y3_end_needs_of_not_mem` proved, so `y3_end_needs`, `cv_hd_main` and `cv_hd` are kernel theorems; the handover

**What this stage proves.** `y3_end_needs_of_not_mem` (YB3 § 3.1 Steps 3–4, the case `g ∉ P_cl(N)`) no longer uses `sorry`. With it, `y3_end_needs`,
`cv_hd_main` and `cv_hd` read no open leaf: kernel theorems on the standard three. No statement changed; no `axiom`; no `native_decide`. Seven children
added, all kernel; one existing proof (`flank_two_sectors_at_S_gen`) re-routed through its new generalization, statement unchanged.

**The route, against YB3 § 3.1** (every step went through in Lean; none failed):

| YB3 | Lean |
|---|---|
| Step 3: at `N`, `h`'s two horns `Q±`, upper flanks `x₁ ≠ x₂`, lower flank(s), all outside `{c, h}` | `seven_colours_at_N`'s chart count, unchanged, with `x ≠ g` read from `x ∈ P_cl(N)` and `g ∉ P_cl(N)` in place of U1 for `g` |
| Step 3 (a): the lower side is one colour `y` | **case split on the two lower chart colours `y₁ = y₂`**: if they differ, `c, g, h, x₁, y₁, x₂, y₂` are seven distinct colours (MERGE separates `y₁`, `y₂` on their sectors) — no step needed beyond `seven_colours_at_N`'s |
| Step 4: an `x₁`-shadow on `Q₊` comes from an in-type `x₁` at `N + n`, so `Q₊`'s upper arc is on `ω(N + n)` | `shadow_of_not_shave` at `N`, `srcG_of_shadow` (the out-type alternative sits at `E`, where `x₁` is absent), `outType_N_of_flankAbove`: `μ₂ = 1`; the mirror for `x₂` on `Q₋` (`srcH_of_shadow`, `outType_S_of_flankBelow`): `μ₃ = −1` |
| `y` has two sectors at `N + n` | **new** `flank_two_sectors_at_S_of_flanks` (E5 § 3.4 with its three-colour hypothesis replaced by the flank facts it reads) at `N` in the frame turned by `π`; the chart flanks named by **new** `IsSectorChart.isFlankAbove_of_col`/`isFlankBelow_of_col` |
| no MERGE: `y`-horns `R±` along `±a` at `N + n` | `isStuck_of_hasRepeatedColour`; **new** `horns_of_two_sectors_at` (the second half of `lower_flank_horns_at_N_of`, at any point) |
| upper flanks `z₁, z₂` of `R±`: not `y`, not `h` (pinch) | the `three` count; U1 at `N + n` for `h` (`coneAt_N_subset_of_horn`, `coneAt_S_subset_of_horn` turned, now that `μ₂ = 1`, `μ₃ = −1`) |
| not `c`, `x₁`, `x₂` ("their sectors at `N` have `d·n > 0`, while `z_i`'s tile at `N + n` lies outside `B̄(N, 1)`") | **new** `not_inType_S_of_flankAbove`/`not_inType_N_of_flankBelow` (a flank above a bound `≥ −1` is outside `B̄(N, 1)`): against the in-type `x₁`, `x₂` contacts of Step 4 directly; for `c`, the contact would be out-type and `coneAt_subset_allowedCone` bars `c`'s direction at `N` (in the open upper half-turn, **new** `cos_pos_of_mem_angleIoo`) |
| `z₁, z₂` outside the five, so the seventh colour | both are `g` (pigeonhole in `Fin 6`); two `g`-sectors at `N + n` separated by `h`'s (`mem_angleIoo_half`), `g` absent at the pole `N`: MERGE at `N + n` (`mergeAvailable_of_two_sectors`) |

**A simplification over YB3's Step 4** (for the report): `z₁ ≠ z₂` is never proved separately — both are forced to be `g`, and two `g`-sectors give the
MERGE; and YB3's sharpening (b) (`N` centres unit arcs of length `≥ 180°`) is not needed.

**Children added** (all in `Plane/ValidMap/Terminal`): `cos_pos_of_mem_angleIoo` (angle section); `flank_two_sectors_at_S_of_flanks` (before
`flank_two_sectors_at_S_gen`, which now cites it); `IsSectorChart.isFlankAbove_of_col`, `IsSectorChart.isFlankBelow_of_col` (copies of `Contact`'s
`exists_flank_after`/`_before` with the colour named), `not_inType_S_of_flankAbove`, `not_inType_N_of_flankBelow`, `horns_of_two_sectors_at` (before
`lower_flank_horns_at_N_of`). Names checked unique by `git grep` over `main` (`3ef0895c`), `origin/fs131-w5`, `origin/fs131-w5p`, `origin/fs131-ww`,
`origin/fs131-w4mm`, `origin/fs131-w5c` (each ref resolved; positive control `lower_flank_horns_at_N_of` found). Models in the docstrings: `bowtie`
(`bowtie_flanks`) for the two flank lemmas; `bowtie` at `0` for `horns_of_two_sectors_at`'s point hypotheses, `Covers` the caller's.

**Statements unchanged**: `tools/fs131_i5h_stmt_check.py 72149b07`: **PASS** (exit 0, `data/fs131/i5p/stmt-check-44.txt`); and against my launch commit,
`tools/fs131_i5h_stmt_check.py da09c260` (so I5n's `y3_end_needs_of_not_mem`, added after `72149b07`, is covered): **PASS** (`stmt-check-44-da09.txt`),
`--self-test`: all three plants **fired**, unplanted control PASS. `tools/fs131_i5n_merge_swap.py --check`: **IDENTICAL** (`merge-swap-44.txt`).

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 5 modules rebuilt, 8 with warnings, every warning `declaration uses
'sorry'`**, exit 0, 8 min 48 s (`build/gate/build/20261005T082921Z-2689945.log`, ends "Build completed successfully (5370 jobs)"; its one `error:` line is
the up-to-date probe's "target is out-of-date"; driver log `data/fs131/i5p/build-stage44.log`). `Terminal`'s `sorry` declarations: **2** (`exists_red`
l. 806, `exists_terminal` l. 818); wave 5 **19** (`Terminal` 2, `BaseDense` 2, `BaseWalk` 5, `HexRing` 6, `MapGraph` 3, `Dense` 1; 20 at launch).

**Axioms, read from this build's oleans** (`data/fs131/i5p/I5pAxioms44.lean` → `I5pAxioms44.out`, 12 GiB slot, exit 0): `y3_end_needs_of_not_mem`, the
seven children, `flank_two_sectors_at_S_gen`, `y3_end_needs`, `cv_hd_main`, `cv_hd`, `seven_colours_at_N` on `[propext, Classical.choice, Quot.sound]`.
`cv_class`, `c_double`, `c_ends` read `sorryAx` through this branch's stale wave-4 `flankQ_upper`/`flankQ_lower` only (printed: `flankQ_upper_of_qrOnly`,
`flankQ_lower_of_qrOnly` read `sorryAx`; `main`'s `UnitArc` has no `sorry`), as I5l recorded. Controls: `exists_red`, `exists_terminal`, `exists_merge`
read `sorryAx`. `scripts/Axioms.lean`: the seven new records added to the "FS131-I5h" block.

**Re-pricing.** `y3_end_needs_of_not_mem` cost about 110k tokens of context, most of it reading the shadow, flank and chart toolkit; the whole proof
(about 330 lines with its children, a scratch file importing the built `Terminal`) elaborated at the third attempt, after two one-line fixes (a stray
copied docstring line; an `rintro rfl` that substituted the wrong variable). Iterating on a scratch file that imports the built module took about 6 s
per run, against about 9 min per build: the cheap loop for this lane.

### Theorems this phase proved

All [kernel], axioms `[propext, Classical.choice, Quot.sound]` (`data/fs131/i5p/I5pAxioms44.out`), in `Plane/ValidMap/Terminal.lean`:
- `HadwigerNelson.Plane.ArcMap.y3_end_needs_of_not_mem` — FS112-Y3-END-NEEDS's case `g ∉ P_cl(N)` (YB3 § 3.1 Steps 3–4); with it, now closed beneath:
  `ArcMap.y3_end_needs` (FS112-Y3-END-NEEDS, corrected, inventory item 69), `ArcMap.cv_hd_main` (FS114-CV-HD's main clause), `ArcMap.cv_hd`
  (FS114-CV-HD's equivalences).
- `ArcMap.flank_two_sectors_at_S_of_flanks` — E5 § 3.4 at any bounds over the flanks (no three-colour hypothesis).
- `ArcMap.horns_of_two_sectors_at` — a repeated colour at a stuck point, carried at a pole, has two horns along that pole's axis.
- `ArcMap.not_inType_S_of_flankAbove`, `ArcMap.not_inType_N_of_flankBelow` — a flank beyond a bound `∓1` is never in-type at the vertex, seen
  from the pole.
- `ArcMap.IsSectorChart.isFlankAbove_of_col`, `ArcMap.IsSectorChart.isFlankBelow_of_col` — a chart sector's colour is the flank colour at its germ.
- `cos_pos_of_mem_angleIoo` — a direction in the open upper half-turn has positive `n`-component.

### The handover: what is proved, what is left (for the next `Terminal` implementer)

**Proved this session**: the `Terminal` half's CV-HD/Y3 block is closed in the kernel — `y3_end_needs`, `cv_hd_main`, `cv_hd` on the standard three
(`cv_class`, `c_double`, `c_ends` too once `main`'s `flankQ_*` arrive at the merge).

**Left (2 in `Terminal`)**: **`exists_red`, `exists_terminal`** (H, the limit constructions; not started). They may cite `exists_merge` in ruling 269's
form (ruling 348 (a)); `exists_merge` is itself open (wave 4's MERGE lane). What I read of them: `IsModification` (`Chain.lean`) asks the same domain,
`RingArcsWithin` (no unit arc created) and `coloursAt_subset` at points of `≥ 4` colours only — it does not ask `M` to agree with `F` anywhere else, the
"weak" reading of plan § 2.2. The plan's route (§ 4 leaves 2–3, § 9.1 l. 391): a locally finite count descending per move inside a ball, the limit by
local eventual constancy; N2-RED also needs the whole-arc bends (`bend_toward`, `bend_away` are open on this branch's stale `UnitArc`) and N2-TERM N4-TERM's
`Φ`. Price: one to two sessions each, as I5n wrote; the limit of a sequence of `ArcMap`s (its arcs locally finite, its colouring valid) is the new
infrastructure and is not in the repository.

**Drafts for the front page**: none — wave 5 is not at its gate.

## Stage 44 — SAVED

## Stage 52 — SAVED (FS131-M6): the readback, and the as-given build

*FS131-M6, wave 5's second sync (Opus), continuing this record on branch `fs131-w5c` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` from
`8d84435e`. Brief: `data/fs131/briefs/FS131-M6-sync.md` (main tree). My set (ruling 389 (b)): merge `origin/fs131-w5` (which carries `main`) into `fs131-w5c`,
`framePt → fromFrame` on this branch's side, copies removed, checked; then, as budget allows, lane B's `run_hornBoundsQR`, `stuckRun_ne_univ`, and
`badCount_lt_top`'s unused `hc` dropped (ruling 389 (a)). Numbered 52 on: `fs131-w5`'s side of this record runs to Stage 51, this branch's to Stage 44, and
the merge (next stage) joins both.*

### 52.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_m6_quotes.py` (a copy of KL1's checker under this job's prefix): **9 quotations, 0 failures**, exit 0 (`data/fs131/m6/quote-check.txt`) —
`CLAUDE.md` § Counter-priors; inventory items 389, 388, 386, 355, 340, 373; the first lines of `run_hornBoundsQR` and `stuckRun_ne_univ` (`Terminal` at
`8d84435e`). `--self-test` (a one-letter plant in the first quotation): **fired**, 1 failure (`quote-check-selftest.txt`). Read in full: items 340, 355,
373, 386, 388, 389; M5's Stages 47–51 on `fs131-w5`'s copy of this record (Stage 48: git took `main`'s side for every wave-4 module by itself; three
append-conflicts kept both, ours first; `framePt → fromFrame` in `FlankUA`; copies found by `tools/fs131_m5_dupes.py` and deleted or made `private`;
checked byte for byte by `tools/fs131_m5_merge_check.py` and three-way by `tools/fs131_wl_mergestmts.py --rename framePt=fromFrame`). No mismatch.

### 52.2 The as-given build (`8d84435e`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1757 modules already
up to date, nothing built, 9 modules with warnings**, exit 0 (`build/gate/build/20261005T110003Z-3543531.log`; driver log `data/fs131/m6/build-asgiven.log`);
every warning `declaration uses 'sorry'` (30), no `error:` line.

### 52.3 The ground before the merge

Merge base `75689a4c`; `origin/fs131-w5` at `385b5ad3` when read (KP2's stage 1 over M5's `ae881022`). Changed on both sides since the base: `ARCHITECTURE.md`,
`Proofs.lean`, `scripts/Axioms.lean`, this record, `Plane/ValidMap/BaseDense`, `Plane/ValidMap/Contact` — the brief's six. `sorry` by file (`grep -rcw`,
`data/fs131/m6/sorry-counts-before.txt`): `BaseDense` 2, `BaseWalk` 5, `Contact` 3, `Dense` 1, `HexRing` 6, `MapGraph` 3, `Procedure` 4, `Terminal` 2,
`UnitArc` 5, `Packed` 1 (a docstring word). On `origin/fs131-w5`: `BaseDense` 4, `BendCollar` 1, `HexRing` 1, `Terminal` 9 (its stale copy of this lane),
`Packed` 1, `Cover` 1, `CoverExamples` 2 (docstring words).

## Stage 52 — SAVED

## Stage 53 — SAVED (FS131-M6): `origin/fs131-w5` merged into `fs131-w5c`; `framePt → fromFrame`; copies removed; checked; the build green

`git merge --no-ff --no-commit origin/fs131-w5` at `e37e864d` (one merge base `75689a4c`). **The merged commit is `385b5ad3`** (KP2's stage 1 over
M5's `ae881022`); `origin/fs131-w5` moved to `4ced8071` (KP2's stages 2–5: `RadialPush`, `Pushforward`, `BendCollar`'s children) while this stage ran,
and is **not** in this merge — every check below names `385b5ad3`, never the moving ref (M5's slip, avoided). Git merged `Proofs.lean`,
`scripts/Axioms.lean`, `BaseDense` (both sides kept: `exists_preBend`'s children from `fs131-w5`, `cv_exists`'s proof from here) and `Contact`
(equal to `fs131-w5`'s, i.e. `main`'s proved `exists_merge`, whose statement equals this branch's, item 355) by itself. Two conflicts:
`ARCHITECTURE.md` (one block of rows, resolved row by row three-way: `HornShadow`, `Terminal` ours; `Dense`, `BaseWalk`, `BendCollar`, `BaseDense`
theirs) and this record (rebuilt from the base and both sides' additions: `fs131-w5`'s Stages 27–51 as numbered there, then the join line, then
this branch's Stages 27–44 and 52 as numbered here, so the inventory's "`fs131-w5c`'s Stages n–m" citations still resolve; both sides' summary
blocks at the head kept, `fs131-w5`'s first).

### 53.1 The rename and the copies

- **`framePt → fromFrame`** on this branch's side: `HornShadow` (42 occurrences: `framePt`, `frameX_framePt`, `frameY_framePt`, `framePt_normSq_aux`,
  `S_add_eq_framePt` → `main`'s names; `N_add_eq_framePt` → `main`'s `normalPt_add_eq_fromFrame`, the statement M5 found equal), `Terminal` (17,
  among them its own `ringPt_S_sub_eq_framePt` → `ringPt_S_sub_eq_fromFrame`, record renamed). No `framePt` remains outside wave 2's `Plane/Slack`
  (and its record `dist_framePt_sq`); neither `HornShadow`'s nor `Terminal`'s import closure reaches `Slack` (`tools/fs131_m6_closure.py --reach`,
  self-test passed), so none could resolve to it. `Limit`, `Procedure`, `BaseDense` had none.
- **Copies removed** (each declaration and its `#print axioms` line deleted, its uses renamed):
  - `isPreconnected_hornSet_unit` (`HornShadow`; `|κᵢ| ≤ 1`, `r ≤ 1/2`) — a special case of `Surgery`'s `isPreconnected_hornSet` (`|κᵢ| r < 2`), already
    in `HornShadow`'s closure; its one use (`mem_shadow_hornSet_S`) now cites `Surgery`'s with `|ν| r ≤ r < 2` by `mul_le_of_le_one_left` (a first
    `nlinarith` form timed out at 200000 heartbeats in that large context, `LEAN.md`'s warning; replaced before the green build).
  - `IsHorn.isRingArc_lower_ua` (`Terminal`) = `main`'s `IsHorn.isRingArc_lower` (`UnitArc`), verbatim statement; its use in `n3_end_bothKind` cites `main`'s.
  - `Arc.ptL`, `Arc.paramsL`, `Arc.subL`, `continuous_ptL`, `carrier_eq_imageL`, `carrier_subL`, `nondegenerate_subL` (`Limit`) = `Surgery`'s `Arc.pt`,
    `params`, `sub` and four lemmas; the three lemmas `Surgery` lacks are renamed `Arc.isCompact_params`, `Arc.ordConnected_params`, `Arc.finite_pt_eq`
    (names free on `HEAD`, `origin/main`, `origin/fs131-w5`) and state the same over `main`'s definitions; the four spec examples kept, over `Arc.pt`/`sub`.
  - `branchPt_mem_closure_sector_pair` (`Limit`) = `fs131-w5`'s `BranchGerms.branchPt_mem_closure_sector` (`MapTopology`) up to `next` vs `BranchGerms.next`
    and a section variable — **`Limit` now imports `Plane/ValidMap/MapTopology`** (no cycle: `MapTopology` does not reach `Limit`), adding ten modules to
    `Limit`'s closure (`MapTopology`, `HexRing`, `UnitArc`, `BaseSteps`, `Cor3`, `PlaneTopology`, `CurveGraph`, `RingGerm`, `SixFragment`,
    `LocalMapExamples`), all already under `Procedure`'s or `Terminal`'s; a choice the coordinator may reverse (M5's alternative: a `private` copy).
  - `ringArc_add_int` (`Procedure`, found by the tool) = `MapTopology`'s `ringArc_add_two_pi_mul`, now in `Procedure`'s closure through `Limit`; its one use
    (`isRingArc_add_int`) cites it.
  - Left, reported (`STATEMENT-OLD`, repeats of lemmas declared at the fork in modules outside the closure, not created by the merge):
    `Limit`'s `coloursAt_eq_singleton_of_interior` = `FlankUA`'s `coloursAt_eq_of_mem_interiorPts`; `Procedure`'s `ringPt_add_int` = `BaseWalk`'s
    `ringPt_add_int_mul`.
- **The dupes tool**: `tools/fs131_m6_dupes.py`, M5's under my prefix with one more failing class, **STATEMENT-NORM** (statements equal after
  deleting namespace qualifiers and binder-bracket kinds, with the section variables a statement uses prepended) — M5's exact class missed
  `branchPt_mem_closure_sector_pair`. Before the merge (`8d84435e` against `385b5ad3`): `branchPt_mem_closure_sector_pair` (NORM),
  `ringArc_add_int`, `IsHorn.isRingArc_lower_ua` (`dupes-premerge-m6tool.txt`, exit 1). After: **0 NAME/STATEMENT/NORM pairs**, the two
  STATEMENT-OLD above, two CONCL candidates read by hand (`ringPt_add_int`; `Terminal`'s `isPreconnected_hornSet_of_abs_le`, `≤ 2` against
  `Surgery`'s `< 2`: a generalization, kept) (`dupes-merged.txt`, exit 0). `--plant` (a re-declared name, `isPreconnected_hornSet`'s statement under a
  new name, a docstring "class" line, and `branchPt_mem_closure_sector_pair`'s text): reports exactly the three it must, exit 1 (`dupes-plant.txt`).
- `ARCHITECTURE.md`: `Limit`'s Imports cell (+ `Plane/ValidMap/MapTopology`), `HornShadow`'s row (cites `Surgery`'s lemma). `tools/check_architecture.py`
  failed on exactly `Limit`'s imports before the edit (`arch-check-before-edit.txt`) and **PASS** after (`arch-check.txt`).

### 53.2 The checks

- **Files, byte for byte** — `tools/fs131_m6_merge_check.py` (M5's adapted: a `cut` edit kind, the records' renames, the shared record):
  `75689a4c e37e864d 385b5ad3`: **PASS, 1787 files**; `--self-test`: a byte in `Surgery`, a line in `Terminal`, a dropped import, a doubled record,
  a reverted Imports cell, a dropped record line — each FIRED naming its file (`merge-check-selftest.txt`).
- **Statements, three-way** — `tools/fs131_wl_mergestmts.py e37e864d 385b5ad3 --rename framePt=fromFrame --rename ptL=pt --rename paramsL=params
  --rename subL=sub --rename carrier_eq_imageL=carrier_eq_image` (WL1's, run): 7,358 names, 0 base conflicts, **exactly 4 reported, the 4 declared
  deletions** (`IsHorn.isRingArc_lower_ua`, `branchPt_mem_closure_sector_pair`, `isPreconnected_hornSet_unit`, `ringArc_add_int`: "merged {}");
  every other statement of either side is the changing side's up to the renames (`mergestmts.txt`). `--plant`: a fifth, `AeColouring.exists_fill`,
  exit 1 (`mergestmts-plant.txt`).
- **The build** (slot 40 GiB, 8 cpus, `BATCH=4`): the first run failed on the heartbeat timeout above (`build/gate/build/20261005T111830Z-3709289.log`,
  445 of 456 batches); after the fix **OK — 456 of 456 batches, 10 modules rebuilt, 5 with warnings, every warning `declaration uses 'sorry'`**, exit
  0, 9 min 49 s (`build/gate/build/20261005T113352Z-3846867.log`, "Build completed successfully (5791 jobs)"; driver log `data/fs131/m6/build-merge.log`).
- **Axioms** (`data/fs131/m6/M6Axioms53.lean` → `.out`, 12 GiB slot, against this build): **on the standard three** — the brief's six, `flankQ_upper`,
  `flankQ_lower`, `cv_class`, `c_double`, `c_ends`, `exists_merge`; the consumers of the renamed and removed declarations `ringPt_S_sub_eq_fromFrame`,
  `mem_shadow_hornSet_S`, `sep_S`, `n3_end_bothKind`, `n3_end`, `cv_hd`, `eventually_essSet_iff_of_goodAt`, `exists_clean`, `Arc.finite_pt_eq`,
  `Arc.isCompact_params`, `isRingArc_add_int`, `badCount_lt_top`, `mergeAvailable_of_bothKind`. **Controls on `sorryAx`**: `run_hornBoundsQR`,
  `stuckRun_ne_univ`, `exists_terminal`, `cv_exists`, `exists_preBend`.
- **`sorry` by file** (`grep -rcw`; `sorry-counts-before.txt` → `sorry-counts-after.txt`): `BaseWalk` 5 → 0, `Contact` 3 → 0, `Dense` 1 → 0, `MapGraph`
  3 → 0, `UnitArc` 5 → 0 (`fs131-w5`'s and `main`'s proofs), `HexRing` 6 → 1 (`bv_l3`), `BaseDense` 2 → 3 (`finite_maxRingArcs`, `hfree_of_baseHyp`,
  `maxRingArcs_subset_of_bend`; `cv_exists` proved here), `BendCollar` 0 → 1 (`bend_toward_collar`), `Procedure` 4 (`exists_vertexStep`,
  `exists_arcStep`, `exists_terminalSeq`, and a docstring word), `Terminal` 2 (`run_hornBoundsQR`, `stuckRun_ne_univ`); `Packed` 1, `Cover` 1,
  `CoverExamples` 2 are docstring words.

Statements unchanged on both sides but for the four copies removed and the declared renames; no `axiom`, no `native_decide`.

## Stage 53 — SAVED

## Stage 54 — SAVED (FS131-M6): `run_hornBoundsQR` proved (with a stronger form at every chain vertex); `badCount_lt_top`'s `hc` dropped

**`run_hornBoundsQR`** is a kernel theorem on the standard three, over three new declarations placed before it in `Terminal`:
- **`BranchGerms.horn_cases_four`** — on a cycle of four indices, if the germs at `iu` and at the index after it share one direction and those at `ip`
  and after it another, an index whose next germ shares its direction is `iu` or `ip` (a Bool-valued colouring of `Fin 4` and three indices: `decide`;
  control: the same claim with conclusion `i = iu` alone is refused).
- **`horn_flanks_of_isChainVertex`** — at a chain vertex (stuck, `≤ 3` colours), **a horn of any colour along any direction** is one of the two-sector
  colour's two horns: the chart (`Near`) has four germs (degree `4` from `stuck_structure_ua`, against `IsSectorChart.hasDegree`), the three horns'
  chart indices (`Near.horn_index`) fall under `horn_cases_four` with the direction test `e (β j) = e α₀` (`BranchGerms.e_nextβ`, `e_add_pi_ne`), so the
  horn's colour has two sectors and the structure's flanks lie above and below it at its own bounds (`IsFlankAbove.congr`, `IsFlankBelow.congr`).
- **`hornBoundsQR_of_isChainVertex`** — in a terminal map, `HornBoundsQR w β` at **every chain vertex `w` and every direction `β`**: the horn's
  pole contacts (`horn_poles_contact`) and FLANK-Q (`flankQ_upper_of_qrOnly`, `flankQ_lower_of_qrOnly`).
- `run_hornBoundsQR` is then two applications at `v + j n` (`isChainVertex_of_mem_stuckRun`), along `α` and `α + π`. Its hypotheses `hv`
  (`StuckAlong v α`) and `h3` are not read (`have _ :=`, IL2's form for `hc`): **a generalization** — the clause holds at every chain vertex, along every
  direction, with no run.

KL1's route (§ 3.1) planned "`IsHorn` uniqueness at a chart index"; the step that needed thought was that the horn's colour is arbitrary (`HornBoundsQR`
quantifies over every `d`), settled by the four-germ count rather than by sector colours.

**`badCount_lt_top`**: its unused `(hc : F.IsClean)` removed (ruling 389 (a): a stronger theorem; no Lean consumer), its docstring updated, the
`have _ := hc` line gone. `tools/fs131_il_stmt_check.py 06f39aef` (IL2's, run): exactly one statement changed, `badCount_lt_top` (`stmt-check-54.txt`,
exit 1 as it must be for a ruled change); the three new declarations are additions.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 456 of 456 batches, 6 modules rebuilt, 5 with warnings, every warning `declaration uses
'sorry'`** (`Terminal`'s only at `stuckRun_ne_univ`), exit 0, 9 min 18 s (`build/gate/build/20261005T114745Z-3978587.log`; its one `error:` line is
the up-to-date probe's; driver log `data/fs131/m6/build-stage54.log`). **Axioms** (`data/fs131/m6/M6Axioms54.lean` → `.out`): on the standard three —
`BranchGerms.horn_cases_four`, `horn_flanks_of_isChainVertex`, `hornBoundsQR_of_isChainVertex`, `run_hornBoundsQR`, `badCount_lt_top`; controls on
`sorryAx`: `stuckRun_ne_univ`, `exists_terminal`. Records added to `scripts/Axioms.lean` before `run_hornBoundsQR`'s. `sorry`: `Terminal` 2 → 1.

## Stage 54 — SAVED

## Stage 55 — SAVED (FS131-M6): the hand-back

### Theorems this phase proved (FS131-M6)

All [kernel], `[propext, Classical.choice, Quot.sound]`, in `Plane/ValidMap/Terminal`:
- `HadwigerNelson.Plane.ArcMap.run_hornBoundsQR` — N2-TERM's clause 3, the horn bounds: at each vertex of a stuck run of a terminal six-map, every
  horn bound `±1` along `±e α` sits on a (Q) or (R2) arc.
- `HadwigerNelson.Plane.ArcMap.hornBoundsQR_of_isChainVertex` — the same at every chain vertex of a terminal map, along every direction.
- `HadwigerNelson.Plane.ArcMap.horn_flanks_of_isChainVertex` — every horn at a chain vertex is a horn of the two-sector colour, with flanks at its bounds.
- `HadwigerNelson.Plane.BranchGerms.horn_cases_four` — the four-germ index bookkeeping.
- In `Plane/ValidMap/Procedure`: `HadwigerNelson.Plane.ArcMap.badCount_lt_top`, now with no cleanness hypothesis (statement strengthened by ruling).
- On this branch after the merge (proved on `main`, now the files here; standard three against this branch's build, Stage 53): `flankQ_upper`,
  `flankQ_lower`, `exists_merge`, and through them `cv_class`, `c_double`, `c_ends`.

**Left — `stuckRun_ne_univ`**, not attempted (budget). Route, KL1's § 3.1 with what Stage 54 adds: along `univ` every `P_j = v + j n` is a chain vertex
with a horn along `α` (`horn_flanks_of_isChainVertex` gives its colour's two sectors and its flanks; take `λ_j < υ_j` its bounds, in `[−1, 1]` by
`stuck_structure_ua`); **no bound is `±1`**: a bound `υ_j = 1` gives, by `hornBoundsQR_of_isChainVertex`, a (Q) or (R2) arc of `ω(P_j + n) = ω(P_{j+1})`,
a unit arc centred at the chain vertex `P_{j+1}`, which `cv_l0` forbids (`λ_j = −1` likewise at `P_{j−1}`) — this part is now short. **The open child is
`shadow_recursion`**: `λ_j ≤ curvDown λ_{j+1}` and `curvUp υ_{j−1} ≤ υ_j`. No SHAVE at `P_j` makes each flank shadow the horn at every scale
(`shadow_of_not_shave`, `FlankUA`, no Condition 5); `srcG_of_shadow`/`srcH_of_shadow` put the source at `P_{j±1}` (strict bounds: `κ₂ < 1` gives the
out-type case at `S′`); the step still to write is the one wave 4's `stuck_chain` never made in Lean: identify the source colour's class near `P_{j±1}`
with a side of `P_{j±1}`'s horn and apply the N4-SHADOW geometry (`Cone.lean`'s far-side lemmas, `shadow_hornSet_subset_S`/`_N`) to get the
concentric-circle bound; then `n4_fin`. Price: M–H, one session.

**Drafts for the front page**: none — wave 5 is not at its gate.

## Stage 55 — SAVED

## Stage 60 — SAVED (FS131-IS1): the readback, the as-given build, the scope

*FS131-IS1, `Terminal`'s last implementer (Opus), continuing this record on branch `fs131-w5s` in
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5s`, cut from `fs131-w5c` at `ebb0b292`. Brief:
`data/fs131/briefs/FS131-IS1-stuck-run.md` (main tree). Numbered 60 on: Stages 56–59 are kept for FS131-I5q's on `fs131-w5`, so the later
merges join the copies cleanly. My set: `stuckRun_ne_univ` (the last `sorry` of `Terminal`), with "no bound is `±1`" first and the child
`shadow_recursion`.*

### 60.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_is_quotes.py` (a copy of M6's checker under this job's prefix): **7 quotations, 0 failures**, exit 0
(`data/fs131/is/quote-check.txt`) — `CLAUDE.md` § Counter-priors; inventory items 398, 420, 421; the first line of `stuckRun_ne_univ`
(`Terminal` at `ebb0b292`); M6's "Left" paragraph (this record, Stage 55); the planner's row (`plans/FS131-limit-kernel-plan.md` § 3.1).
`--self-test` (a one-letter plant in the first quotation): **fired**, 1 failure (`quote-check-selftest.txt`). No mismatch. Read in full:
this record's Stages 52–55; inventory item 421; `plans/FS110-derivation.md`'s entries FS110-N4-SHADOW, -N4-SHAVE, -N4-STUCK, -N4-FIN;
`plans/FS110-N-proof.md` § Continuation — FS110-N4, §§ 2.1–2.6 (the proof file the entries name); `Plane/StuckChain` (`n4_fin`),
`Plane/ValidMap/HornShadow` (SH1, SH2, SEP), `Plane/ValidMap/Basic`, `Plane/ValidMap/Chain`, and `Terminal` from `cv_l0` on.

### 60.2 The as-given build (`ebb0b292`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1785
modules already up to date, nothing built, 5 modules with warnings**, exit 0 (`build/gate/build/20261006T041943Z-883493.log`; driver log
`data/fs131/is/build-asgiven.log`); every warning `declaration uses 'sorry'` (`BendCollar` 1, `HexRing` 1, `Procedure` 2, `Terminal` 1 at
`3592:8` = `stuckRun_ne_univ`, `BaseDense` 3), no `error:` line. `Terminal`'s `sorry` by `grep -cw`: **1** (line 3594).

### 60.3 What I may and may not change

May: `Plane/ValidMap/Terminal` — `stuckRun_ne_univ`'s proof, and new declarations beside it (before it, after `run_hornBoundsQR`);
`Plane/ValidMap/HornShadow` and `Plane/ValidMap/FlankUA` — supporting lemmas **added at the end of the file** only (FS131-IR2 may add to
`FlankUA` on `fs131-w5c`); `scripts/Axioms.lean` — a block of my own headed "FS131-IS1" above the `=== PURCHASED ===` banner; this record;
`tools/fs131_is_*.py`; `data/fs131/is/`; `data/fs131/reports/FS131-IS1.md`. May not: `Procedure`, `Limit`, the move modules, `BaseDense`,
`BendCollar`, `HexRing`, `Proofs.lean`; any statement, any definition a statement uses; no `axiom`, no `native_decide`; no merge into
`fs131-w5c`, no gate run, nothing on `main`.

### 60.4 The route as read (before any proof)

The hand proof (N4 § 2.6) takes both inequalities "from validity of the flanks alone" once the colours are placed: the horn at `P_{k+1}` has
the colour of `P_k`'s lower flank, and its shadow at `P_k` is everything above the circle of curvature `f(λ_{k+1})`; the lower flank reaches
up to the arc `λ_k`. In this module's terms: (1) no bound `±1` at a chain vertex whose neighbour is a chain vertex (`hornBoundsQR_of_isChainVertex`
against `cv_l0` at the neighbour); (2) so `cv_class` is in its second case there — the upper flank twice at `S′`, the lower flank twice at
`N`; (3) at the chain vertex `N` the twice-carried colour is the colour of the horn along `e α` (one horn per direction at a chain vertex:
the four-germ count of Stage 54); (4) SH2 (`mem_shadow_hornSet_S`, `mem_shadow_hornSet_N`) and `Valid` give the two inequalities; (5) `n4_fin`.
`shadow_of_not_shave` and `srcG_of_shadow` are not read on this route: `flank_two_sectors_at_S_gen` (inside `cv_class`) already carries them.

## Stage 60 — SAVED
