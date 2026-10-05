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
