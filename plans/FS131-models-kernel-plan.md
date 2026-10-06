# FS131-KM1 — the example maps planned: Lean objects on which the four moves' hypotheses, the stuck vertex's and the two bends' hold at once (de Bruijn, the planner)

*Brief: `data/fs131/briefs/FS131-KM1-models.md`. Branch `fs131-wm`, worktree `.claude/worktrees/fs131-wm`. Started 2026-10-06 07:10 UTC.
Nothing in this milestone is blind (ruling 1), so this plan has one phase.*

## Theorems this phase proved

Listed at the last saved stage (§ "Theorems this phase proved, final"); a planning job proves few. Until that section exists: none.

## Stage 1 — SAVED (FS131-KM1): the readback

### 1.1 The brief's quotations (standing rule 3)

`tools/fs131_km_quotes.py` reads each `> text` / `> — source: path` pair of the brief and counts the text in the file the source line
names; output `data/fs131/km/quotes.out`. **27 quotations, 27 found verbatim, each once; none missing.** `--self-test` changes the last
character of every quotation and requires all 27 to be reported missing: `27 of 27 … OK`, exit 0 (the planted fault fires).

The six theorem heads, the four pieces (`recolour`, `recolour_valid`, `sevenBrickMap`, `bowtie`, `bowtie_isStuck`, `cuspFrag`) and the
three audit rows are as quoted. Read in their place, whole with docstrings: `exists_merge`, `exists_rayMerge`, `exists_shave`
(`Contact.lean` l. 1490–1531), `exists_open`'s module header and `HasHornCount` (`OpenMove.lean` l. 1–120), `bend_toward`,
`bend_away_whole` (`UnitArc.lean` l. 3771–3978).

### 1.2 What was read, and how far

| file | read |
|---|---|
| `plans/STANDING-RULES.md`, `LEAN.md` | whole |
| `RUNNING.md` § Building | whole |
| `plans/FS131-QA4-audit.md` | whole (§§ 3.1–3.5, 4, 6 as the brief asks) |
| `plans/FS131-E7-derivation.md` | §§ 3–7 whole (l. 239–766); §§ 1–2, 8 not read |
| `plans/FS131-close-inventory.md` | items 427, 440 (its second half), 441, 454 (its second half), 455 |
| `Plane/ArcMap.lean` | whole |
| `Plane/Woodall/Merge.lean` | header; `recolour` and its five lemmas, `wedgeMerge` (l. 633–800); `coloursAt_congr`, `niceAt_congr` |
| `Plane/ValidMap/Basic.lean` | l. 1–300: every definition a move's hypothesis names |
| `Plane/LocalMap.lean` | l. 60–288: cones, germs, tiles, ring arcs, change points |
| `Plane/SVMap.lean` | l. 826–1125: `sevenBrickMap`, its arcs, `not_mem_sevenBrickArcs`, the corner sectors; the corner theorems by their heads |
| `Plane/ValidMap/Sectors.lean` | `isSector_iff_of_partition`, `encard_sectors_of_partition`, `cuspFrag` and the heads of its lemmas |
| `Plane/ValidMap/Surgery.lean` | `germArc`, `carrier_germArc`; the heads of `isOpen_hornSet`, `isPreconnected_hornSet` |
| `Plane/ValidMap/BaseSteps.lean` | `coloursAt_hasSectors_of_tiles`, `bowtie_inType`; the rest by heads |
| `data/fs131/qa4/QA4Bowtie.lean`, `QA4Collar.lean` | at Stage 3, with the bends |

### 1.3 The build as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` in the worktree, 2026-10-06 07:16 UTC: `All targets
up-to-date (5750 jobs)`, `OK — all 1767 modules already up to date, nothing built, 0 module(s) with warnings, 3s`, exit 0
(`data/fs131/km/build-0.log`). The branch is current.

### 1.4 What I am planning, and what I may change

**Planning**: Lean objects — maps, each with a named theorem stating that it satisfies every hypothesis of one landed theorem at once —
for: the four local moves (`exists_merge`, `exists_rayMerge`, `exists_shave`, `exists_open`); a positive `HasHornCount v 1` (and, after
wave 5, `IsSite`); `Valid ∧ Covers v 1 ∧ IsStuck v` (FLANK-Q, `FlankUA`, `Terminal`'s stuck lemmas, `woodallCone`); E7's four (`F₀` for
`a4six`, `F₁` for `straddlers_third` and `nb4p`'s background, `P₄` for `flank_ne_of_doublyShadowed`, `P₅`); the two bends
(`bend_toward`, `bend_away_whole`); `awayModel` for `bend_away_part`; and the objects `exists_vertexStep` and `cvb_hole_disconnected`
will apply to once wave 5 lands.

**Mine to change**: new modules under `Proofs/HadwigerNelson/Plane/` (new declarations only), `Proofs.lean`, `ARCHITECTURE.md`, a block
"FS131-KM1" in `scripts/Axioms.lean`, this record, `tools/fs131_km_*.py`, `data/fs131/km/`, the report. **Not mine**: any statement,
definition or docstring of a landed declaration (the docstring lines the models earn are drafted in § "Docstring lines", with their
slots); `main`; wave 5's branches; `LEAN.md`, the inventory and every file Keryx alone writes.

## Stage 2 — SAVED (FS131-KM1): the construction decided

### 2.1 The decision: one construction — a plane map with spare colours, painted

**Every model of this lane is `(brickBase k).paint W B g`**: the seven-colour brick map read in `k ≥ 7` colours, with a colouring `g` in
spare colours painted on a small open set `W` whose pieces each lie inside one brick, and finitely many new arcs `B` carrying the
picture's boundaries. One construction serves the audit's rank 4 (the four moves), rank 5 (the stuck vertex), E7's `P₄` and `P₅`, and
`awayModel`; the two existing fragments serve rank 6 (`cuspFrag`'s ring arc). The reason it is one: a local theorem's hypotheses read
three scales, and a painting in fresh colours answers each from the picture alone —

| scale | hypotheses | what the painted map gives |
|---|---|---|
| the whole map | `Valid`, `Covers v 1`, `IsPlaneMap`, `Condition5` | the base is a valid plane map with Condition 5 (kernel); a spare colour has no base class, so validity is "no unit pair of one painted colour inside `W`" (`paint_valid`); the domain is the base's |
| near `v` | sectors, degree, horns, flanks, horn count, `coloursAt v` | `interiorPts ∩ B(v, r)` is the ball off the picture's arcs (`interiorPts_paint`; the brick's edges miss the ball), so the sectors are read off a partition of a ball (`isSector_iff_of_partition`, `encard_sectorsOf_of_partition`) — nothing about the base enters |
| on `ω(v)` | contacts and their types, the allowed cone, `IsClear`, shadows | the class of a spare colour is its painted set off the arcs (`region_paint`), so contacts and shadows are statements about explicit small sets; the class of a brick colour only shrinks, so a point that was of that colour stays clear for it |

**What the library gave and what was missing** (checked, not assumed): no colour relabelling exists (`rg "relabel|castLE"` over
`Proofs/HadwigerNelson/Plane`: no hit) — `ArcMap.relabel` is new, 6 lemmas, all proved here in about 45 lines (QA4 priced it at 60).
`ArcMap.recolour` paints one colour and asks the frontier of `W` on the *new* arcs; `awayModel`'s painted set is bounded partly by brick
edges and `P₅` needs five colours in one disc, so `ArcMap.paint` is new: a colouring in place of one colour, the frontier on old or new
arcs; `recolour` is its special case and stays untouched. **`encard_sectorsOf_of_partition` already exists** (`Surgery.lean` l. 1115,
more general than the one I first wrote: the elaborator refused my duplicate, and it is deleted).

### 2.2 The completed bowtie is dropped; `P₅` stands in its place (ruling 441 (c)'s default; no reason found to keep both)

I looked for a reason to keep it — a transfer theorem that would carry `bowtie_isStuck` and the seventeen `bowtie_*` facts to a map of
the plane without re-proving them. It does not come cheaply: the bowtie's tiles reach `|re z| < 113/260` and height above `1`, wider than a
brick (`4/5 × 3/5`), so any valid base's edges cross them. An overlay then has brick edges inside bowtie tiles (not clean, MERGE available
on them, so never terminal), and the transfer of `IsStuck` needs four general lemmas (local agreement; contacts and their types under
cut tiles; a shadow witness moved off the new edges, which needs the base's Condition 5; closures of classes) — about 400–600 lines for
an object that is then weaker than `P₅`, which is terminal and clean and is wanted anyway for `Terminal`'s family. `P₅`'s picture at the
vertex is `cuspFrag`'s picture at `0` with three colours, so its sectors come from `cuspFrag_partition` and `cuspPiece_data` by a
translation (§ 3.5), and the bowtie's own stuckness lemmas in `BaseSteps` (`eventually_not_two_rays_hornSet`, `hornSet_curv_eq`) are
general and reused as they stand.

### 2.3 Three variations on the hand objects, each mine, each checked

1. **The tangent disc sits at `plantPt + (3/5 + (4/5) i)`, never at the pole.** The audit's fourth picture is "one lone horn with a
   tangent disc"; a disc of the horn's colour internally tangent to `ω(v)` at the pole `v + i` of the horn's own axis is **invalid** —
   the horn's points along the axis are in the disc's shadow (`|z − c₀|² = x² + (1 − s)² > (1 − s)²`). The contact must make a positive
   angle with the horn: at `w − v = 3/5 + (4/5) i` every horn point is within `1` of every disc point
   (`(z − v)·(q − v) ≥ 0.495 |z − v|`). Control: `tools/fs131_km_models.py`, 0 monochromatic pairs in 70,590; with the disc moved to the
   pole (`--plant`) 130 are found, exit 1. This is E6's own placement (its `T_c` touches at `(3/5, 4/5)`); the audit's sentence does not
   say where, so it is a constraint recorded, not a correction.
2. **`P₅`'s pieces at the poles are squares, not discs** (side `1/10`, cut by their diagonals): every new arc but the circle about the
   vertex and the four unit arcs is then a segment with rational ends. E7's inequalities are re-read with `|a|, |b| < 1/20` in place of
   `a² + b² < 1/400`: colour `7` uses only `a² + b² < 2b² ≤ |b|/10`; colour `9` uses no bound; the far wedges are `2 − √2/10 > 1`
   apart; in-type at `N` is `a² + b² + 2b < 0` for `|a| < −b ≤ 1/20`. All hold. Control: 0 monochromatic pairs in 222,812, and 75 of 75
   sampled horn points shadowed by both flank wedges through E7's formula.
3. **`exists_merge`'s model is two horns, not two wedges.** Its hypotheses are a colour with `n + 1 ≥ 2` sectors and a cone with
   interior; `twoHornModel` (the model of `exists_rayMerge`) satisfies them, so the audit's "X of two segments" is not built. What that
   leaves unexercised is said in § 3.4.

### 2.4 A fact about the order of work, for the coordinator

Wave 5's `Plane/ValidMap/BrickMap` (on `fs131-w5`, 537 lines, not on `main`) is the brick infrastructure these models lean on:
`brickCell`, `sevenBrick_mem_interiorPts`, `sevenBrick_col_val`, `sevenBrick_isTile_iff`, `sevenBrick_isSector_iff`,
`sevenBrick_not_isHorn`, `sevenBrick_not_hasRepeatedColour`; KA1's plan for `awayModel` is written in `brickCell`. This skeleton is cut
from `main` and uses none of it: the three brick facts it needs are stated in coordinates (`brickBase_mem_interiorPts`,
`brickBase_col_eq`, `brickBase_col_zero`; provable on `main` from `not_mem_sevenBrickArcs` and `sevenBrick_color_eq`, about 120 lines, or
in three lines each from `BrickMap` once it has landed), and no name of `BrickMap` is reused. One leaf cannot be done cheaply on `main`:
`stuckModel_terminal` (every point of the plane) wants `BrickMap`'s sector and horn lemmas; it is placed in the after-wave-5 pass
(§ 3.8).

## Stage 3 — SAVED (FS131-KM1): the skeleton, its readback, the plan per leaf, the passes, the docstring lines, the handoff

### 3.1 The modules (all new; `Proofs.lean`, `ARCHITECTURE.md` rows and the `scripts/Axioms.lean` block in the same commits)

| module | holds | `sorry` leaves |
|---|---|---|
| `Plane/Models/Paint` | `ArcMap.relabel`, `ArcMap.paint` and their lemmas (proved); `brickBase`; the planted points; `hornArcs`; the fan | 13 |
| `Plane/Models/Moves` | `hornModel`, `twoHornModel`; the four moves applied; `HasHornCount 1`; the holed tile | 18 |
| `Plane/Models/Stuck` | `stuckModel` (`P₅`), `shadowModel` (`P₄`) | 21 |
| `Plane/Models/Bends` | `cuspFrag`'s ring arc and the two bends applied; `awayModel` | 7 |

Imports: `Paint` imports `ValidMap/OpenMove`, `ValidMap/BaseSteps`, `Woodall/Steps` — downstream of every theorem modelled; the other
three import `Paint` only. No landed declaration is edited. No `axiom`, no `native_decide`.

### 3.2 The readback by elaboration: each model theorem is the landed theorem applied to the object

The form chosen (brief, Done means 3: "a conjunction, or the theorem applied to the object, whichever reads back better") is **the theorem
applied**: `hornModel_shave`, `hornModel_open`, `twoHornModel_rayMerge`, `twoHornModel_merge`, `shadowModel_flank_ne`,
`cuspFrag_bend_away`, `cuspFrag_bend_toward` are each a call of the landed theorem with every hypothesis supplied by a named fact about
the one object. They elaborate, so each fact has exactly the type the theorem's binder asks — the kernel has read my hypothesis lists
against the statements, which no table of mine could do. What is left unproved is the facts themselves (the leaves). The stuck family has
no single consumer on `main`, so its model is the conjunction `stuckModel_hyps`.

### 3.3 The objects, read against the hand models

| object | definition | hand model | read |
|---|---|---|---|
| `hornModel : ArcMap 8` | base; `7` on `hornSet plantPt 0 (−1/2) (1/2) (1/10)` and on `tangentDisc = B(plantPt + (19/20)(3/5 + 4i/5), 1/20)` | QA4 § 3.2 (b), § 3.3's third and fourth pictures | mine; § 2.3 (1) |
| `twoHornModel : ArcMap 8` | base; `7` on `hornSet plantPt 0 (−3/4) (−1/2) (1/10)`, `hornSet plantPt 0 (1/2) (3/4) (1/10)`, `tangentDisc` | QA4 § 3.3's second picture (curvatures `−1, −1/2, 1/2, 1` there; `∓3/4, ∓1/2` here, so that no arc is a unit arc and the fan lemma's `\|κ\|ρ ≤ 1` holds with room) | mine |
| `stuckModel : ArcMap 12` | base; in `B(plantPt, 1/10)`: `7` inside `B(N, 1)`, `8` inside `B(S′, 1)`, `9` elsewhere; in the square about `N`: `7` below (`b < −\|a\|`), `9` above, `10` right, `11` left; about `S′`: `8` above, `9` below, `10`, `11` | E7 § 7.1's table, row by row | every row matches; discs → squares (§ 2.3 (2)) |
| `shadowModel : ArcMap 9` | base; `7` on `hornSet plantPt 0 (1/2) (3/4) (1/10) ∪ hornSet plantS 0 (1/10) (1/5) (1/20)`; `8` on `hornSet plantPt 0 (−3/4) (−1/2) (1/10) ∪ hornSet plantN 0 (−1/5) (−1/10) (1/20)` | E7 § 6.1, verbatim | matches |
| `awayModel : ArcMap 8` | base; `7` on `(0, 4/5) × (0, 3/5) ∩ B(P, 1)` and on `(4/5, 8/5) × (0, 3/5) ∖ B̄(P, 2)`, `P = −3/5 + 3i/10`; arcs `circ P 1 (∓arcsin(3/10))`, `circ P 2 (∓arcsin(3/20))` | KA1's plan § 5, verbatim | matches |
| the cusp arc | `cuspFrag.IsRingArc I (−π/2 + 1/10) (−π/2 + 2/5) 0 1` | QA4 § 4.1 ("on one side of `0`") | angles mine: the arc's points are `2 sin(t/2) ≤ 0.40 < 1/2` from `0` and `5 − 4 cos t > 1` from `−i` |

`plantPt = 2/5 + 3i/10`, `plantN = plantPt + i`, `plantS = plantPt − i` are E7's `v`, `N`, `S′`. Bricks: `B(plantPt, 1/10)` in brick
`(c, r) = (0, 0)`, colour `0`; the square at `N` in `(−1, 2)`; at `S′` in `(1, −2)`; the tangent disc in `(0, 1)` — each strictly inside,
with its margin (`tools/fs131_km_models.py`, four lines `True`).

**E7's objects, first independent reading** (the brief's last sentence of Done means 3): **no clause fails.** Re-derived by me from the
definitions, not from E7's text: `P₅`'s colours at the vertex, the two horns as `hornSet plantPt 0 (−1) 1` and `hornSet plantPt π (−1) 1`
(`tanAbove_neg_one_iff`, `tanBelow_one_iff`), the four flanks with the frame along `e π` turned (its normal is `−i`, so there `8` is the
upper flank and `7` the lower), the four contact claims, the validity inequality of each colour, and that a point of `B(v, 1/10)` is in at
most one of `B(N, 1)`, `B(S′, 1)` (`|z − N|² + |z − S′|² = 2|z − v|² + 2`). `P₄`: the definitions, the source circle (`S′ + 6i = v + 5i`,
curvature `1/6` between `1/10` and `1/5`), the flank statements and the band's bounds read; § 6.3.1's two-circle argument and § 7.4's
table were read, not re-derived.

### 3.4 What each model exercises, and what it meets only degenerately

| theorem | model | exercised | met degenerately, or not exercised |
|---|---|---|---|
| `exists_shave` | `hornModel` at `plantPt`, `n = 0`, `(κ₁, κ₂) = (−1/2, 1/2)`, `g = h = 0`, `σ = 0` | a live horn, both flanks live, a map of the plane; the cone has a contact | `n = 0`: the horn is its colour's only sector. Both flanks are one colour and every horn point is clear for it, so **every** `σ ∈ [κ₁, κ₂]` satisfies `hclear`: the split's position is not exercised (a model in which only one `σ` works is E6's map, F6 — not asked by the statement). The bounds are strictly inside `(−1, 1)`: the unit-arc case `κ = ±1` is not exercised |
| `exists_open` | `hornModel`, `m = 2`, `j = 1`, `δ = 1` | a lone horn (`HasSectors plantPt 7 1`); `D₇(plantPt)` is the closed half-plane `d·(3/5 + 4i/5) ≥ 0` — one in-type contact, `−plantDir` not allowed (`hornModel_contact`) | no out-type contact |
| `exists_rayMerge` | `twoHornModel`, `n = 1`, `κ = −3/4, −1/2, 1/2, 3/4` | two horns of one colour on one ray, the gap between them a sector of the brick's colour | outer bounds strictly inside `[−1, 1]` |
| `exists_merge` | `twoHornModel`, `n = 1` | two sectors of `7`, the cone a half-plane | `1 ≤ n` is tight; the two sectors are horns, so MERGE's gap between two *wedge* sectors of positive angle is not exercised |
| `Valid ∧ Covers v 1 ∧ IsStuck v` | `stuckModel` at `plantPt` | all three reasons for stuckness live: the cone of `9` is a line (two out-type contacts), the two horns lie on different rays, every horn point is in both flanks' shadows; three colours at the vertex; the flanks in-type at the poles | — |
| `flank_ne_of_doublyShadowed` | `shadowModel`, `(κ₁, κ₂) = (−1/2, 1/2)`, band `(−1/8, 1/8)`, `g = 7`, `h = 8` | Condition 5, both flanks live, both shadows from live regions, the conclusion `7 ≠ 8` | no horn of a third colour between the flanks (the statement has none) |
| `bend_away_whole`, `bend_toward` | `cuspFrag`'s arc about `i` | a ring arc with both sides live | **the centre is outside the closure of the domain, so it carries no colour at all**: `hin`, `hout` hold for want of any colour, and the radius-2 arc is off the map. A fragment, not a plane map |
| `bend_away_part` (wave 5) | `awayModel` | a plane map; the inner colour absent at `P` because `P` is interior to another brick; a contact interval strictly inside the arc's angles: two gaps and a contact piece | an isolated contact (KA1 § 5 says so) |

**A stronger model of `bend_toward` falls out of `awayModel`, for the implementer to add** (new declarations, authorized here):
`awayModel.coloursAt awayP = {6}` (the brick `(−1, 0)`), so the arc's outer colour `0` is not carried at `P` either, and `bend_toward`
applies to `awayModel` — a plane map, the centre carrying a colour. Name it `awayModel_bend_toward`.

### 3.5 The plan per leaf

Prices: S up to 30 lines, M 30–120, H above 120; estimates from the library's measured pictures (`cuspFrag` with its partition and horn
about 260 lines; `l60Frag` 840; `isoFrag` 160), to be re-priced from each file's first two leaves. `data/fs131/km/KMCheck.lean` resolves
by `#check` every library and Mathlib name cited below (its output is `KMCheck.out`).

**`Paint` (13 leaves).**

| leaf | route | price |
|---|---|---|
| `brickBase_mem_interiorPts`, `brickBase_col_eq`, `brickBase_col_zero` | `relabel_interiorPts`, then `not_mem_sevenBrickArcs` (the height is no multiple of `3/5`, the sheared abscissa none of `4/5`: floors from the strict bounds); the colour by `sevenBrick_color_eq` with `⌊·⌋ = r`, `= c`; colour `0` at `(0, 0)` as in `sevenBrick_corner_col`. After wave 5: `sevenBrick_mem_interiorPts`, `sevenBrick_col_val` | M, S, S |
| `norm_plantDir`, `tangentDisc_subset_ball` | `(3/5)² + (4/5)² = 1`; `dist q v ≤ 19/20 + dist q c < 1`; the closure is the closed ball (`closure_ball`), and `‖q − v‖ = 1` with `‖q − c‖ ≤ 1/20`, `‖c − v‖ = 19/20` forces equality in the triangle inequality, hence `q = v + plantDir` (strict convexity: write `q − v = (19/20) u + δ`, expand `‖·‖²`) | S, M |
| `hornArcs_nondegenerate` | `germArc_nondegenerate`; the rim piece by `Real.arcsin_lt_arcsin` on `κ₁ρ/2 < κ₂ρ/2 ∈ [−1/2, 1/2]` | S |
| `frontier_hornSet_subset`, `hornArcs_carrier_subset` | `frontier = closure ∖ interior`, the set open (`isOpen_hornSet`); a point of the closure off the set has `dist = ρ`, or `frameX = 0`, or a `tanHeight = 0`, with the other three weak. `tanHeight κᵢ = 0`, `frameX ≥ 0`, `dist ≤ ρ` is a point of `germArc` (`carrier_germArc`: the branch; the converse direction of `mem_germArc_iff_of_mem_hornSet`'s proof); `frameX = 0` forces `z = v` (`y(1 − κy/2)` has the sign of `y`); `dist = ρ` gives the rim piece in polar form (`tanHeight_polar`, `sectorBetween_eq_hornSet`'s parametrization). **What is hard**: the closure's weak inequalities — take them from continuity (`closure_minimal` on the four closed conditions), never from a description of the closure | M, S |
| `isOpen_fanRest`, `isPreconnected_fanRest` | open: three open conditions. Connected: `{frameX < 0}`, `{TanBelow κlo}` (`κlo < 0`: the open disc of radius `1/\|κlo\|` about `v + n/κlo`), `{TanAbove κhi}` (the disc about `v + n/κhi`) are convex, each meets the ball in a convex set, and the half-disc meets both lenses (`v − (r/2)(e α ∓ t·n)`): `Convex.isPreconnected`, `IsPreconnected.union` twice | S, M |
| `ball_diff_fan` | `tanHeight (κ i)` is strictly decreasing in `i` at `z ≠ v`. `⊇`: a horn has `th_i > 0 > th_{i+1}`, so no `th_j = 0`; the rest has `frameX < 0` (arcs have `frameX ≥ 0`), or all `th_j < 0`, or all `> 0`. `⊆`: `frameX < 0` → rest; `frameX = 0`, `z ≠ v` → rest by the sign of `y`; `frameX > 0` and no `th_j = 0`: `th₀ < 0` or `th_last > 0` → rest, else the last index with `th > 0` (child `exists_sign_change`: a strictly antitone `f : Fin (m + 2) → ℝ` with `f 0 > 0 > f (last)` has `i` with `f i.castSucc > 0 > f i.succ` or a zero — by `Fin.induction` or `Nat.findGreatest`) | M–H |
| `isSector_fan_iff`, `fanRest_ne_hornSet` | `isSector_iff_of_partition` over `Option (Fin (m + 1))` with `ball_diff_fan`: open (`isOpen_hornSet`, `isOpen_fanRest`), preconnected (`isPreconnected_hornSet`, needs `\|κ\| r < 2`), disjoint, non-empty (`exists_mem_hornSet_near`-style points), `v` in each closure (`mem_coneAt_hornSet` then `mem_closure_of_mem_coneAt`). The rest approaches `v` along the open half-turn behind it: `ne_hornSet_of_interior_coneAt` | M, S |

**`Moves` (18 leaves).** One shared child first, in `Paint` or here: **the painted class is the painted set** —
`region_paint` with `brickBase_region_spare` gives `hornModel.region 7 = hornW ∖ arcs` (`hornW ⊆` the base's interior points by
`brickBase_mem_interiorPts`), and `hornModel.region 0 ⊆ (brickBase 8 _).region 0`.

| leaf | route | price |
|---|---|---|
| `hornB_nondegenerate`, `frontier_hornW_subset` (and the two for `twoHornModel`) | `hornArcs_nondegenerate`, a full circle; `frontier_union_subset`, `frontier_hornSet_subset`, `frontier_ball`, and a child `carrier_circ_full` at a general radius (`ArcMap.carrier_circ_full` is stated for radius `1` only) | S each |
| `hornModel_valid`, `twoHornModel_valid` | `paint_valid` with `brickBase_valid`; `hWc` is empty (`brickBase_region_spare`); `hWW`: any two points of the class are less than `1` apart — horn–horn `< 1/5`; disc–disc `< 1/10`; horn–disc by § 2.3 (1)'s inequality, stated as one small real-variable lemma (`LEAN.md`: `nlinarith` wants its own context) | M, S |
| `hornModel_isHorn`, `_hasSectors`, `_hasDegree`, `_hasHornCount`; `twoHornModel_isHorn`, `_hasSectors` | for `r ≤ 1/10`: `interiorPts ∩ ball = ball ∖ fan` (`interiorPts_paint`; the ball is in the brick; the rim piece and the tangent circle are outside the open ball), then `isSector_fan_iff` with `m = 0` (`m = 2`); colours of the pieces from the class lemma; counts by `encard_sectorsOf_of_partition` and `encard_sectors_of_partition`; the horn count is `1` because the rest is no horn set (`fanRest_ne_hornSet`) | M for the first, S each after |
| `hornModel_flanks`, `hornModel_clear` | `hornSet plantPt 0 (1/2) 1 r ⊆ fanRest ⊆ region 0`; clear: `region 0` shrank and the horn's points were of colour `0` in the valid base (`brickBase_valid`, `brickBase_col_zero`) | S, S |
| `hornModel_contact`, `hornModel_cone`; `twoHornModel_cone` | the class is horn ∪ disc inside `B(plantPt, 1)`, so every tile of `7` is in the ball: in-type at every contact, out-type at none in the closure of a tile (`IsPreconnected.subset_connectedComponentIn` puts the disc in a tile). Contacts are `closure(class) ∩ ω(plantPt) = {plantPt + plantDir}` (`tangentDisc_subset_ball`). Cone: `ball plantDir (1/2) ⊆ allowedCone` (`d·u ≥ 1 − 1/2`), and `−plantDir` fails at the contact | M, M, S |
| `hornModel_holedTile` | the brick `(2/5, 6/5) × (3/5, 6/5)` off the closed disc is open, in the interior points, and connected (four overlapping convex rectangles around the disc); it is a whole component because its frontier is on arcs. The four `IsHoleOf` clauses are closures of a rectangle and a disc | M |

**`Stuck` (21 leaves).** `stuckModel` (13): shared children — the class lemma per colour; **the partition at the vertex by translation**:
for `r ≤ 1/10`, `stuckModel.interiorPts ∩ ball plantPt r = (· + plantPt) '' (cuspFrag.interiorPts ∩ ball 0 r)` (both are the ball off
`ω(±i)` moved; `cuspFrag_mem_interiorPts`), so the sectors are the translates of `cuspPiece r i` (`cuspFrag_partition`,
`cuspPiece_data`), two of them the horn sets (`hornSet_cusp_iff`, `hornSet_cusp_pi_eq`).

| leaf | route | price |
|---|---|---|
| `stuckArcs_nondegenerate`, `_finite`, `frontier_stuckW_subset`, `stuckCol_locallyConstant` | explicit lists; frontier of a union of a ball and two squares; in the ball the colour changes only across `ω(N)`, `ω(S′)` — which inside the closed ball are the four tangent arcs (`carrier_germArc`: child "the unit circle about a pole inside `B̄(v, ρ)` is its two branches") — in a square only across its diagonals | S, S, M, M |
| `stuckModel_valid` | `paint_valid`, `hWc` empty; `hWW` colour by colour, E7 § 7.2's five inequalities with `\|a\|, \|b\| < 1/20`, each a small real lemma | M–H |
| `stuckModel_coloursAt`, `_hasSectors`, `_isHorn`, `_flanks` | the translated partition; flanks by `tanAbove_one_iff`, `tanBelow_neg_one_iff` and their mirror at `e π` (`frameX_add_pi`) | M, S, S, S |
| `stuckModel_contacts` | class lemma; `a² + (1 + b)² ≥ 1` on `b ≥ \|a\|` with equality at `0` only; in-type by `a² + b² + 2b < 0` | M |
| `stuckModel_not_mergeAvailable` | child: the sector count of every colour (`encard_sectorsOf_of_partition`: `9 ↦ 2`, `7, 8 ↦ 1`, others `0`), so the colour is `9`; its cone lies in `{d : dot d i ≤ 0 ∧ dot d (−i) ≤ 0}`, a line, interior empty | M |
| `stuckModel_not_rayAvailable` | a horn at the vertex is a sector that is a horn set: one of the two (`ne_hornSet_of_interior_coneAt` excludes the lens pieces), with its direction and bounds fixed (`e_eq_of_mem_coneAt_hornSet`, `hornSet_curv_eq`); two on one ray are one set, against `κ₂ < κ₃` — `BaseSteps`' route for the bowtie (`eventually_not_two_rays_hornSet`) | M |
| `stuckModel_not_shaveAvailable` | the horn and its flanks are forced as above; child `stuckModel_shadow`: for `z` in a horn within `1/50` of the vertex, `N − iβ` (`β = 1 − √(1 − x²) − y`) is a point of the class of `7` at distance exactly `1`, and `S′ + iβ′` one of `8` (E7 § 7.3); so no `σ` clears any horn point | M–H |
| `stuckModel_terminal` | **after wave 5** (§ 3.8) | H |

`shadowModel` (8): `shadowArcs_nondegenerate` (S), `frontier_shadowW_subset` (S: four horn sets), `shadowCol_locallyConstant` (S: the two
classes are open and disjoint), `shadowModel_valid` (M: `paint_valid`; each horn set in a disc of radius `1/10`; flank against source by
E7 § 6.2's concentric circles about `plantPt + 4i` — `tanAbove` and `tanBelow` as distances to centres, one triangle inequality),
`shadowModel_condition5` (S: `paint_condition5`, `brickBase_condition5`, `Arc.finite_inter_sphere_or_eq_circ` with radii `≠ 1`),
`shadowModel_flanks` (S: `κ′ = ∓3/4`), `shadowModel_doublyShadowed` (H: E7 § 6.3.1 — the witness on the circle of radius `6` about
`plantPt + 5i`; prove existence by the intermediate value theorem on that circle's arc inside the source horn rather than by the angle
formula: `dist z ·` is below `1` at one end and above at the other).

**`Bends` (7 leaves).** `cuspFrag_isRingArc` (M: the pattern is `l60Frag_isRingArc`; inner and outer colours from `cuspCol` and the two
distances of § 3.3), `cuspFrag_coloursAt_I` (S: the classes lie in `B(0, 1/2)`), `cuspFrag_radiusTwo_disjoint` (S: `‖i + 2e θ‖ ≥ 1`),
`awayArcs_nondegenerate` (S), `frontier_awayW_subset` (M: a rectangle cut by a circle; the brick's walls are base arcs —
`mem_sevenBrickArcs_of_bottom`, `_of_left`), `awayModel_hyps` (H: KA1 priced the whole object at one session; `isoFrag` is the pattern),
`awayModel_r2Contacts` (M).

### 3.6 The domain-modeling pass (`debruijn-domain-modeling`, invoked fresh)

- **The cut.** Intrinsic to "a model of a local theorem": the three scales of § 2.1 and nothing else. The base contributes only that it is
  a valid plane map with spare colours and bricks with interiors; the picture contributes sets. So "one base, one painting" is the
  image. A first-class fragment transported by a transfer theorem would add a second object whose only content is that local
  predicates read `interiorPts ∩ ball` — which is already how `IsSector` is defined. Rejected: an index nobody inspects.
- **Reuse is at the level of sets, not maps**: `cuspFrag`'s partition serves `stuckModel` by a translation of sets; no map is transported.
- **Ugliness read.** Three models share "a fan along one ray": collapsed into `ball_diff_fan` over `Fin (m + 2)` (one lemma, `m = 0, 2`)
  rather than a lemma per picture. `stuckCol` is total with a fall-through branch read nowhere (its docstring says "read on `stuckW`
  only"): a junk branch, kept because `paint` reads `g` on `W` alone. `brickBase_col_zero` states the colour through `ℕ`, since
  `(0 : Fin k)` needs `k ≠ 0`.
- **The adversarial member found one defect, in my own statement**: `paint_valid` first asked "no unit pair of one painted colour" of
  *every* pair of points of `W`, arc points included, where validity reads only interior points; on `stuckModel` the arc points carry
  fall-through colours and the stronger hypothesis is a claim about them nobody means. Restated at the points off the new arcs, and
  proved in that form. Nothing consumed the first form.
- **Seams checked by hand, each a line of § 3.3**: a point of `B(v, 1/10)` is in at most one of the two unit discs; the squares and the
  ball are disjoint; `holedTile`'s four closure clauses; the ring arc's inner and outer colours at interior points.
- **The next lemma, named before looking**: wave 5's `IsSite`, `IsClean`, `IsHoleOf`, `LocalStep` on these objects — each states in the
  existing vocabulary (§ 3.8), so the representation is not fitted to today's list.

### 3.7 The obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh)

- **The space.** No leaf is an induction but one (`exists_sign_change` inside `ball_diff_fan`); every other is a set identity, a
  containment, or an inequality over the points of a small set. So the decomposition is by *shared local obligation*, and three of them
  close most leaves:
  1. **the painted class is the painted set** (`region_paint` + `brickBase_region_spare`): validity, contacts, clear points and shadows
     become statements about sets — 20 leaves read it;
  2. **the fan partition** (`ball_diff_fan`, `isSector_fan_iff`): six sector leaves of `Moves`;
  3. **contacts read the class only**: with (1), each cone leaf is "the closure of an explicit set meets `ω(v)` in these points".
- **Strengthened children the leaves want** (new lemmas, the implementer's to add): the sector count of *every* colour at
  `stuckModel`'s vertex (¬MERGE quantifies over all colours; the stated `stuckModel_hasSectors` names three); "every tile of `7` lies in
  the unit ball" for the two horn models (gives in-type everywhere, which is what the cone reads); "a horn at the vertex is one of the
  two, with bounds `(−1, 1)`" for both ¬RAY and ¬SHAVE.
- **Leaves that carry real geometry** (the rest is bookkeeping): `stuckModel_valid`, `stuckModel_shadow` (a square root),
  `shadowModel_doublyShadowed` (two circles; route by the intermediate value theorem), `isPreconnected_fanRest`,
  `frontier_hornSet_subset`, `awayModel_hyps`, `stuckModel_terminal`.
- **Measure.** 59 leaves; each plan row replaces one leaf by at most three named children strictly smaller in the sense "fewer scales
  read" (map → class sets → real inequalities). The order of § 3.9 burns the shared obligations first.
- **Validation past the checkmark.** The seven applications are the mutation test run by the elaborator: a fact stated for a different
  parameter than the theorem's binder would not have elaborated (it did refuse one draft: `n` must be given as `0` for
  `HasSectors … 1` to meet `n + 1`). Each count is specific (`HasDegree … 2`, `HasSectors … 0 2`, `coloursAt = {7, 8, 9}`), so a drifted
  picture breaks it.

### 3.8 After wave 5 lands: the applications, each a short theorem on these objects

Not statable on `main` (their predicates are on wave 5's branches); the objects are planned so that each is short:

| wave-5 theorem or definition | object | what the application needs |
|---|---|---|
| `IsSite` (`Limit`, `fs131-w5c`) — a positive instance | `hornModel` (a horn), `twoHornModel` (a repeated colour and a horn), `stuckModel` at `plantPt` | `⟨mem_univ-form, Or.inr ⟨_, _, _, _, hornModel_isHorn⟩⟩`; one line each |
| `exists_vertexStep` (`Procedure`) — `Valid`, `IsClean`, `Covers v 1`, a move available, degree, horn count | `hornModel` (`hornModel_shaveAvailable`, degree `2`, one horn); `twoHornModel` (`twoHornModel_available`; add its degree `4` and horn count `3` — the gap is a horn set too) | **`IsClean`**: every point of `Γ` carries two colours — new arcs separate `7` from a brick colour; brick edges separate different brick colours (the colour is `(c + 3r) mod 7`: neighbours differ by `1, 2, 3`) — M, from `BrickMap`'s sector lemmas |
| `cvb_hole_disconnected` (`MapGraph`, `fs131-w5`) | `hornModel`, `T = holedTile`, `Hc = tangentDisc` | `hornModel_holedTile` is `IsTile ∧` the four clauses of `IsHoleOf` verbatim: `cvb_hole_disconnected hornModel_valid hornModel_isPlaneMap h.1 h.2` |
| `Terminal`'s any-`k` family, `cv_l0`, `IsTerminalMap`, `QROnly` | `stuckModel` | `stuckModel_terminal` (stated on `main`, proved here): the vertex is the only site — off the three painted pieces `BrickMap`'s `sevenBrick_not_isHorn`, `sevenBrick_not_hasRepeatedColour` through locality; on them E7 § 7.4's table with squares. `QROnly`: the only unit arcs are the four tangent arcs, sides `7`/`9` and `8`/`9`, all carried at a pole of four colours. H; the pattern is `sevenBrickMap_isTerminalMap` |
| `bend_away_part` (`BendStep`, `fs131-w5a`) | `awayModel` | `awayModel_hyps` is its five hypotheses in order |

### 3.9 The handoff

**Two implementers, split by file, in parallel**: A — `Paint` then `Moves`; B — `Stuck` then `Bends`. B uses `Paint`'s leaves by their
statements, which are fixed, and its proved part (`region_paint`, `paint_valid`, `interiorPts_paint`). A third, short job after wave 5:
§ 3.8, with the three brick leaves re-proved from `BrickMap` if they are still open.

**If only one model is wanted soon: `hornModel`** (the audit's judgment, confirmed). Order: the three brick leaves; `hornArcs_*` and
`frontier_hornSet_subset`; the fan at `m = 0` (prove `ball_diff_fan` in general — `m = 2` follows for free); the class lemma;
`hornModel_valid`; the sector leaves; flanks, clear, contact, cone. At that point `hornModel_shave` and `hornModel_open` are free of
`sorry`, and the open gate item on SHAVE and OPEN closes; `twoHornModel` then costs its validity and four short leaves, and closes MERGE
and MERGE-RAY.

**Rules for the implementer**: no statement of the skeleton changes (a change comes back through the coordinator); new children are
welcome; the five definitions `hornW`, `twoHornW`, `stuckW`/`stuckCol`, `shadowW*`, `awayW` are statements too. Three places where I
judge a returned statement most likely, so that it is no surprise: `hornArcs`' rim piece (its angles are derived in my notes, not
kernel-checked: the end of the tangent arc of curvature `κ` is `v + ρ e(α + arcsin(κρ/2))`); `brickBase_col_zero` (the colour of brick
`(0, 0)` read from `sevenBrick_corner_col`'s docstring, not evaluated); `stuckModel_terminal`.

**Whole price**: about 2,500–3,700 lines — `Paint` 450–650, `Moves` 500–700, `Stuck` 1,250–1,800 (of which `stuckModel_terminal`
300–500), `Bends` 350–500 — against the audit's 400–800 plus 100 a picture for rank 4 and 1,500–3,000 for rank 5: rank 4 lands inside its
estimate, rank 5 at about half.

### 3.10 The docstring lines the models earn (text and slot; for the implementer who lands the lane — none applied here)

| declaration (file) | slot | line |
|---|---|---|
| `exists_shave` (`Contact`), `exists_shave_aux` (`Moves`) | end of the docstring | "**Inhabitant**: `hornModel` at `plantPt` (`Plane/Models/Moves`, `hornModel_shave`) — a valid map of the plane with one horn of a spare colour in a brick; both flanks are the brick's colour, so every split `σ` is admissible there." |
| `exists_open` (`OpenMove`) | replaces the paragraph "**Inhabitant** (`LEAN.md` § The gate): none in Lean yet. … so `h1` fails." | "**Inhabitant**: `hornModel` at `plantPt` (`Plane/Models/Moves`, `hornModel_open`): a lone horn of colour `7`, `D₇` the closed half-plane of its one in-type contact (`hornModel_contact`), degree `2`, one horn. FS131-E6's twelve-colour map (derivation §§ 3.1–3.3) is the hand model in which SHAVE has only the unit split; `ArcMap.cuspFrag` is no model (`hv` and `h1` fail)." |
| `exists_rayMerge`, `exists_rayMerge_aux` | end | "**Inhabitant**: `twoHornModel` at `plantPt` (`twoHornModel_rayMerge`): two horns of one spare colour along `e 0`, curvatures `−3/4, −1/2` and `1/2, 3/4`." |
| `exists_merge`, `exists_merge_aux` | end | "**Inhabitant**: `twoHornModel` at `plantPt` (`twoHornModel_merge`), `n = 1`: the colour's two sectors are horns and its cone a half-plane; a model whose two sectors are wedges of positive angle is not on file." |
| `HasHornCount` (`OpenMove` l. 36) | after the `cuspFrag` example's docstring | "A count of `1` on a map of the plane: `hornModel_hasHornCount` (`Plane/Models/Moves`)." |
| `flank_ne_of_doublyShadowed` (`Contact`) | end | E7 § 6.5's line, with the object named: "**Inhabitant**: `shadowModel` (`Plane/Models/Stuck`, `shadowModel_flank_ne`) — …" |
| `bend_away_whole`, `bend_toward` (`UnitArc`) | end | "**Inhabitant**: `cuspFrag`'s arc of `ω(i)` (`Plane/Models/Bends`, `cuspFrag_bend_away` / `cuspFrag_bend_toward`); its centre is off the fragment and carries no colour — a model of the hypotheses' letter. On a map of the plane: `awayModel` (`awayModel_bend_toward`, for the toward bend)." |
| the seventeen notes of QA4-2 (`FlankUA` 9, `Terminal` 8; wave 5) | each note, in place of the remedy pass's "no Lean model of all at once" | "Inhabitant of `Valid ∧ Covers v 1 ∧ IsStuck v`: `stuckModel` at `plantPt` (`Plane/Models/Stuck`, `stuckModel_hyps`), with `stuckModel_isHorn`, `_flanks`, `_contacts` for the horn, flank and contact hypotheses; `bowtie` at `0` satisfies all but `Covers`." Each note is re-read against its theorem's remaining hypotheses by whoever edits it (E7 § 7.5: `n3_end*`'s `hno` fails on this object). |
| `cv_l0` and its like (`Terminal`, wave 5c) | the sentence "No model of a stuck vertex in a terminal valid plane map is known" | "Inhabitant: `stuckModel` (`stuckModel_hyps`, `stuckModel_terminal`), twelve colours." |
| `IsSite`, `exists_vertexStep`, `cvb_hole_disconnected`, `bend_away_part` | with § 3.8's applications | the object and the application's name |

### 3.11 Not done, and where a second planning pass takes over

- **`F₀` (the four-petal flower, `a4six`) and `F₁` (`straddlers_third`, `nb4p`'s background): no skeleton.** They are not paintings over
  the brick base: `F₀` is a fragment of its own, an `ArcMap 6` on `B(0, 5/4)` with 24 arcs and a colour by formula (E7 § 3.1), the
  size of a `SixFragment`; its skeleton needs `SixFragment.lean`'s polar lemmas read and its arc list written against them, and the
  Reuleaux lemma stated (E7 § 3.7). `F₁` is `F₀.recolour R B 5` (or `F₀.paint`), a page once `F₀` exists. **A second planning pass
  takes over here**: its inputs are E7 §§ 3–5 and this record's § 2.1 (the painting serves `F₁`), and nothing of this skeleton changes.
- `stuckModel_terminal` and § 3.8's applications: planned, placed after wave 5.
- `P₄`'s § 6.3.1 and `P₅`'s § 7.4 were read, not re-derived (§ 3.3).
- The skeleton's `sorry` leaves were not attempted beyond the general layer: 19 lemmas are proved (list in the last section).
- `shadowModel`'s sampling control is weak (thin classes: 180 unit pairs landed on a class point); E7's own control `band-shadow`
  (4,000,000 flank–source pairs) is the strong one, and the Lean formulas are E7's unchanged.

### 3.12 Tools and receipts

- `tools/fs131_km_quotes.py` — § 1.1; self-test plants 27 faults, all fire.
- `tools/fs131_km_models.py` — sampling controls on the painted classes of the five models, the bricks' margins, the stuck model's
  shadow witnesses and `awayModel`'s contact interval, by formula; output `data/fs131/km/models.out` (`ALL HOLD`, exit 0); planted
  fault `--plant` (the tangent disc at the pole) fires: 130 and 55 monochromatic pairs, exit 1 (`models-plant.out`). A control on
  hand derivations, never evidence for a Lean statement.
- Builds, all through `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` in the worktree:
  `data/fs131/km/build-0.log` (as given), `build-1.log`, `build-2.log`, `build-3.log` (the last: the tree as committed).
- `data/fs131/km/KMAxioms.lean` / `.out`: the `scripts/Axioms.lean` block's records printed by `lake env lean`; `KMCheck.lean` / `.out`:
  the cited names resolved. `tools/check_architecture.py`: `RESULT: PASS` (`arch.out`).

### 3.13 The final build and the receipts

`data/fs131/km/build-3.log` (2026-10-06 07:54 UTC, the tree as committed): `build: OK — 452 of 452 batches, 5 module(s) rebuilt, 4
module(s) with warnings`, exit 0; the full log holds 131 warning lines, **all** `declaration uses 'sorry'` (0 others). `sorry` by
file: `Paint` 13, `Moves` 18, `Stuck` 21, `Bends` 7 — **59 leaves**. The receipt block's 36 records printed by `lake env lean`
(`KMAxioms.out`): 10 on exactly the standard three, 26 with `sorryAx` (the leaves and what rests on them). `KMCheck.out`: every cited name
resolves (two are in the `ArcMap` namespace: `ArcMap.eventually_not_two_rays_hornSet`, `ArcMap.carrier_circ_full`).
`tools/check_architecture.py`: exit 0, `RESULT: PASS`. I ran no gate (`axioms.sh`, `vacuity.sh`, the linters): the brief keeps them
for the landing, and a skeleton fails the first by design.

## Theorems this phase proved, final

A planning job; what is proved is the general layer the models stand on. All **[kernel]**, in `Plane/Models/Paint`, built by the
worktree's `./scripts/build.sh`; the ten audited in `KMAxioms.out` are on exactly the standard three axioms:

- `ArcMap.relabel_interiorPts`, `relabel_Γ`, `relabel_isPlaneMap`, `relabel_region`, `relabel_region_eq_empty`, `relabel_valid`,
  `relabel_condition5` — the relabelling;
- `ArcMap.paint_isPlaneMap`, `paint_col_of_mem`, `paint_col_of_not_mem`, `interiorPts_paint`, `region_paint`, `paint_valid`,
  `paint_condition5` — the painting;
- `brickBase_valid`, `brickBase_isPlaneMap`, `brickBase_condition5`, `brickBase_region_spare` — the base;
- `hornArcs_finite`.

**Proved from open leaves** (each rests on `sorryAx` through the facts it cites and nothing else): `hornModel_shave`, `hornModel_open`,
`hornModel_shaveAvailable`, `twoHornModel_rayMerge`, `twoHornModel_merge`, `twoHornModel_available`, `stuckModel_isStuck`,
`stuckModel_hyps`, `shadowModel_flank_ne`, `cuspFrag_bend_away`, `cuspFrag_bend_toward`. Not theorems until their leaves are.
