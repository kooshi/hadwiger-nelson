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
