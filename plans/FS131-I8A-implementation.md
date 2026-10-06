# FS131-I8A — wave 8's first implementer: the route to `emptyNS` (`Plane/RingCalculus/Empty`), then `Star`'s two leaves

*Job FS131-I8A (de Bruijn, the implementer), 2026-10-06, branch `fs131-w8a` (cut from `fs131-w8` at `f1c13612`). Brief:
`data/fs131/briefs/FS131-I8A-wave8-first.md` (on `main`). The plan: `plans/FS131-w8-kernel-plan.md` (the planner's record, FS131-K8).
Working files: `data/fs131/i8a/`. Tools: `tools/fs131_i8a_*.py`.*

## Theorems this phase proved

All [kernel] on branch `fs131-w8a` (built through `./scripts/build.sh`; not gated, not on `main`); each on exactly
`[propext, Classical.choice, Quot.sound]` unless a smaller set is named. Declarations are of `HadwigerNelson.Plane.ArcMap` unless a
namespace is given.

- **FS116-V6-HUBS, second clause** (the trigonometry) — `ringPt_sixth_dist_le_one` (`Plane/RingCalculus/Empty`), from
  `intCast_zmod_six_of_half_le_cos`. Read against "a tile of p tips at most two, and two only if consecutive … Consecutive hubs are 1
  apart, the others √3 or 2" (`plans/FS116-V6-verification.md` l. 141–144): two ring points `60°·(n − m)` apart within distance 1 force
  `n − m ≡ 0, ±1 (mod 6)`.
- **FS116-V6-COUNT, the count** — `v6_count` (`…/Empty`), from `V6Count.count` (`Plane/RingCalculus/HubCount`): `V6Count.exists_shape`,
  `V6Count.table` (the kernel's check of `13⁴` quadruples; axioms `[propext, Quot.sound]`, no native axiom), `V6Count.stmtB_sound`. Read
  against "M = 4, s = 2, each hub of S has exactly two tips, and every tip at a hub of S is a double tile … the two hubs of S are
  antipodal" (ll. 163–169): the five conjuncts of the statement.
- **FS116-V6-COUNT, the last step, without sectors** — `exists_ne_mem_closure_inter_of_split` (`…/Empty`), from
  `Plane/RingCalculus/TilesAt` (`finite_tileAt`, `exists_ball_tileAt`, `TileAt.inter_sphere_nonempty`,
  `sphere_subset_iUnion_closure_tileAt`, `isPreconnected_sphere_complex`). Read against the module docstring's "the closures of the tiles
  of p cover a small circle about p; if those tiles are split into two non-empty groups … a tile of one group and a tile of the other
  share a closure point other than p".
- **FS116-V6-HUG and FS129-MR1-DOUBLETIP, at the class the argument reads** — `not_sole_tip_of_adjacent_changePoints`
  (`Plane/RingCalculus/SoleTip`): valid, non-Siamese, `Covers p 1`, at least four colours at `p` with at most two absent
  (`k ≤ ncard + 2`), change points at `ψ` and `ψ + 60°`, one tile the only tip at each: `False`. From it `v6_hug` (its `hΓ` idle) and
  `doubleTip` (its `hS`, `hv`, `hu` idle) (`…/Empty`). Read against "No tile T of p tips both y_0 and y_1 while being the only tip at
  each" (`plans/FS116-V6-verification.md` l. 148) and against `doubleTip`'s docstring.
- **FS116-V6-HUBS, `m = 1`** — `v6_hubs` (`…/Empty`), from `GammaFreeRing.changePoint_gap` and `Plane/RingCalculus/RingColour`. Read
  against "the change points are y_k = r(ψ₀ + 60°k), six of them" (l. 141): the change points' angles are one coset of `(π/3)ℤ`.
- **FS129-SR3-EMPTY-NS** (carrying FS116-Y4-EMPTY and FS116-Y4-OBST) — `emptyNS` (`…/Empty`): no valid non-Siamese six-coloured map
  covering `B̄(p, 1)` about a point `p` of at least four colours has a ring with no arc of `Γ`. Read aloud against the row ("No
  non-Siamese … valid six-coloured fragment on a closed disc of radius above 1 about a vertex of at least four colours has a ring carrying
  no arc of Γ", l. 173, with *simple* removed by FS129-SR3): `F : ArcMap 6`, `F.Valid`, `F.NonSiamese`, `F.Covers p 1` (the open domain
  holds `B̄(p, 1)`, which is "radius above 1": `covers_one_iff`), `4 ≤ (F.coloursAt p).ncard`, `F.GammaFreeRing p` (no sub-arc of `ω(p)`
  of positive length lies in `Γ`) ⊢ `False`. With it `v6_hubs_vacuous` and `v6_hug_vacuous` are kernel facts.
- **FS116-N2-RECIP** — `star_recip` (`Plane/RingCalculus/Star`), with `exists_tileOf_of_germIn`. Read against "p is a change point of
  y's ring, its two sides lying in the tiles of p that hold the directions ψ − 90° and ψ + 90°, whose colours are the two colours of
  A(y)" (`plans/FS116-N2-proof.md` § 2.2, RECIP): a change point of `ω(y)` at angle `ψ + π`, the absent colours of `y` are its two
  colours, and each germ lies in a tile of `p` of that colour. As the planner recorded, the statement does not say those tiles hold the
  directions `ψ ∓ 90°`.

## Stage 1 — SAVED (FS131-I8A): the readback, the branch built as given, the statement instrument

### 1.1 What I may and may not change

- **May**: the proofs of `ringPt_sixth_dist_le_one`, `v6_count`, `exists_ne_mem_closure_inter_of_split`, `v6_hug`, `v6_hubs`, `emptyNS`
  (`Plane/RingCalculus/Empty`), then of `star_recip`, `star_anti` (`…/Star`) if budget remains; new helper declarations under names no
  other module declares; a new module of my own beside them, with its `Proofs.lean` and `ARCHITECTURE.md` lines; a block "FS131-I8A" in
  `scripts/Axioms.lean` above the `=== PURCHASED ===` banner; this record; `tools/fs131_i8a_*.py`; `data/fs131/i8a/`;
  `data/fs131/reports/FS131-I8A.md`. A docstring may be corrected (the plan's § 5.6).
- **May not**: any statement or definition (a false or unprovable leaf is a message to the coordinator); the foundation
  (`…/Basic`) or any landed module beyond new declarations; the planner's record; `outerAdj`, `doubleTip` (they wait for the second
  planning pass and keep their `sorry`); `v6_hubs`, `v6_hug` stay public with their `VACUITY DECLARED` lines and the companions
  `v6_hubs_vacuous`, `v6_hug_vacuous` stay as they are (ruling 518); no `axiom`, no `native_decide`; no nine-colour map of my own and no
  merge of `fs131-w6m` (the model of `emptyNS` is a later job's, ruling 525 (c) as amended by item 530); no merge, no gate, no `main`.

### 1.2 The brief's quotations against their sources (standing rule 3)

Checked by script (`grep -cF` of each quoted first line in its source file; 31 quotations): **every one is found exactly once,
verbatim** — the Counter-priors sentence (`CLAUDE.md`), inventory items 518, 524, 525 (`plans/FS131-close-inventory.md` on `main`,
ll. 5495, 5613, 5636), the ten statements' first lines (`Empty.lean`, `Star.lean`), and the plan's headings and bullets.

One finding about the brief, not a mismatch of wording: the two table rows it quotes under "### 5.4 The statements, attacked" (the rows
for `emptyNS` and for `star_flank`, …) stand in the plan's **§ 5.5** table ("Inhabitants and vacuity"), ll. 287 and 291, not in § 5.4.

### 1.3 What was read

- The brief; `plans/STANDING-RULES.md`; `LEAN.md` in full (with the two facts the launch message names: the section-`variable` bullet
  and the closed-`Nat`-term bullet); `RUNNING.md` § Building and § Make the gate fail, and watch it fail.
- The planner's record whole (`plans/FS131-w8-kernel-plan.md`, Stages 1–5).
- My files and what they import, in full: `Plane/RingCalculus/Empty`, `…/Star`, `…/Basic`, `Plane/ArcMap`, `Plane/LocalMap`. The
  statement surface (every signature, extracted by script) of `Plane/Tiles`, `Plane/Chord`, `Plane/RingGerm`, `Plane/LocalStructure`;
  their proofs are read where a leaf uses them.
- The rows' argument: `plans/FS116-V6-verification.md` § 2.1–2.2 (V6-DIAM … V6-COUNT, the whole route to EMPTY), ll. 91–191.
- Inventory items 518, 524, 525, 530 whole.

### 1.4 The branch as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: `data/fs131/i8a/logs/build-1-as-given.log` ends
"build: OK — all 1805 modules already up to date, nothing built, 2 module(s) with warnings", `EXIT=0`; the warnings are ten
`declaration uses sorry` lines — eight in `Empty.lean` (ll. 86, 97, 109, 125, 136, 148, 180, 193), two in `Star.lean` — the ten the
brief counts.

### 1.5 The leaves as the kernel has them (`LEAN.md` § Searching — Lean, last bullet)

`tools/fs131_i8a_stmt.py` elaborates each of the two modules twice — the source at `f1c13612` (`git show`) and the working source — with
one appended command that prints every declaration of the module from the environment (`ConstantInfo.type`: its structural hash and its
printed form with full names; a definition's value hash), and compares by name. It is a comparison of elaborated signatures, not of text.

- Baseline, saved: `data/fs131/i8a/sigs-base.tsv` (23 declarations: `Empty` 12, `Star` 11).
- **Each of the ten leaves, read from that print, is the statement the file shows**: the three leaves stated under the section
  `variable {k : ℕ} {F : ArcMap k}` are `exists_ne_mem_closure_inter_of_split` (which names `F`, and the kernel's statement begins
  `∀ {k : ℕ} {F : ArcMap k} {p : ℂ}, p ∈ F.dom → …`), `ringPt_sixth_dist_le_one` and `v6_count` (which name no map, and the kernel's
  statements have none — as intended: pure trigonometry and finite combinatorics); the other seven carry their own `{F : ArcMap 6}`.
  No leaf has lost a hypothesis to the section-variable rule.
- Controls, each watched to fire (`data/fs131/i8a/logs/stmt-selftest-1.log`): `text` (a hypothesis of `v6_count` altered: exit 1, names
  `v6_count`); `include` (`include hbad in` above `ringPt_sixth_dist_le_one` — the statement's text unchanged, the kernel's statement
  gains `0 = 1 →`: exit 1, names it; this is the class a text diff passes); `def` (`v6_anti`'s conclusion altered: exit 1, names it).
  The instrument's own failure is exit 2 and was seen once (a wrong option name in the printer: "INSTRUMENT FAILURE … the printer did
  not report"), never a pass.

### 1.6 Working method

- Helpers go in new modules beside `Empty` (one per leaf group), imported by `Empty`; the leaves stay in `Empty` with their statements.
- Iteration by `lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false` (2.4 s on `Empty` as given); evidence only from
  `./scripts/build.sh` under the slot.
- At each save: the build's log, the statement check against `f1c13612`, the axioms print of the stage's declarations with a `sorry`
  control beside it, commit by explicit path, push.

## Stage 2 — SAVED (FS131-I8A): three leaves — the sixths, the count, the split

### 2.1 What closed, and how

| leaf | route | lines (plan's price) | elaborations |
|---|---|---|---|
| `ringPt_sixth_dist_le_one` | `dist² = 2 − 2cos((n − m)·60°)` (`sq_norm_e_sub_e`), so `cos ≥ ½`; reduce `n − m` mod 6 and read six values (`intCast_zmod_six_of_half_le_cos`) | 50 (80) | 1 |
| `v6_count` | a certified computation, new module `Plane/RingCalculus/HubCount` | 230 with docs and examples (150) | 3 |
| `exists_ne_mem_closure_inter_of_split` | the plan's route, new module `Plane/RingCalculus/TilesAt`; the plan's density step is `mem_closure_tile` (landed), so no density argument | 110 (200) | 1 |

**Re-priced after the first two leaves** (the brief's item 2): lines at about the plan's count, time at minutes per leaf; the two
leaves that are compositions over landed lemmas closed at the first or third elaboration. `v6_hubs` and `v6_hug` are re-priced at their
own stages, from their routes.

### 2.2 `v6_count`: the measurement, and the shape chosen (the brief's item 5; `LEAN.md` § The kernel's cost model)

- **Measured under the slot** (`scripts/slot.py --mem 8 --cpus 1`): the cover hypothesis alone over all `13⁴ = 28,561` quadruples of
  tip sets, 4.2 s in the kernel; the whole statement (`V6Count.table`), **12.3 s**, well under the 8 GiB cap. So `decide +kernel`, not
  the hand count. No `native_decide`.
- **The shape.** The statement over a `Bool`-valued relation is a `Bool` (`stmtB`) built from four literal quantifiers (`allZ`, `anyZ`,
  `allF`, `anyF`: a six- or four-fold `&&`/`||`), never a `Decidable` instance over a `Fintype` — whose synthesis for the whole statement
  failed outright, and whose kernel cost is the kind the cost model warns of. The hypotheses come first under `||`, so a quadruple
  failing the cover costs only the cover. `stmtB_sound` reads the `Bool` back as the statement (`CountStmt`), so nothing about `stmtB`
  is trusted: a wrong `stmtB` would fail `stmtB_sound` or `table`. The tip sets are `Option (ZMod 6 × Bool)` — none, one hub, two
  consecutive — and `exists_shape` proves from `hcons` that every tile's set of tipped hubs is one of the thirteen.
- **The closed-`Nat`-term fact** (the launch message's second fact) does not bite here: the kernel term is `decide (… = true)` on a
  `Bool` with no rewriting lemma applied to a closed numeral.
- **The kernel against the planner's tool**: the tool counts 72 quadruples meeting the hypotheses, none violating the conclusion; the
  kernel proves that none of the 28,561 violates it. No disagreement. One of the 72 is a Lean term (`V6Count.countModel`,
  `countModel_hyps`: tiles tipping `{5,0}`, `{0,1}`, `{2,3}`, `{3,4}`), and an adversary with the hug hypothesis dropped
  (`{0,1}`, `{2,3}`, `{4,5}`, nothing) is an `example`.

### 2.3 Spec examples added (the plan's § 5.5 debts for these leaves)

- `ringPt_sixth_dist_le_one`: an inhabitant of its hypothesis (consecutive sixths are 1 apart) and an adversary (sixths two apart are
  not within 1 — the lemma itself refutes it by `decide` in `ℤ/6`).
- `exists_ne_mem_closure_inter_of_split`: applied to `halfPlane2` at its change point `r(0) = 1`, the tiles split into those of colour
  1 and the others — both groups inhabited, so every hypothesis is exercised on a Lean object (the lemma reads no validity).
- `v6_count`: `countModel_hyps`.

### 2.4 The save

- Build: `data/fs131/i8a/logs/build-2-three-leaves.log` — "build: OK — 468 of 468 batches, 4 module(s) rebuilt, 2 module(s) with
  warnings", `EXIT=0` (rebuilt: `HubCount`, `TilesAt`, `Empty`, `Proofs`; the warnings are the `sorry` leaves left: `Empty` 5, `Star` 2).
- Statement check against `f1c13612` (`data/fs131/i8a/logs/stmt-2.log`): 23 base declarations compared, 0 changed or missing; 1 added
  in `Empty` (`intCast_zmod_six_of_half_le_cos`).
- Axioms (`tools/fs131_i8a_axioms.py`, reading this job's block of `scripts/Axioms.lean` against the compiled modules;
  `data/fs131/i8a/logs/axioms-2.txt`): 21 records, each a subset of the standard three (`V6Count.table`: `[propext, Quot.sound]`). Its
  control, a theorem proved by `sorry`, prints `sorryAx` in the same run; with `--fault` (the control added to the audited records) the
  check exits 1 and names it (`axioms-2-fault.verdict`).
- `./scripts/dupnames.sh`: "OK — no name is declared by two modules" (`data/fs131/i8a/logs/dupnames-2.log`).
- `tools/check_architecture.py`: PASS (`data/fs131/i8a/logs/check-architecture-2.log`), with rows for the two new modules.

### 2.5 A finding at this stage, sent to the coordinator mid-job (iteration-grade until Stage 3 saves it)

`v6_hug`'s argument reads no Γ-free ring, and the same argument proves `doubleTip` without *simple* and without its two far-germ
hypotheses. Stage 3 carries it.

## Stage 3 — SAVED (FS131-I8A): the sole tip — `v6_hug`, and `doubleTip` by the coordinator's ruling

*Stages 3 and 4 share one build and one commit (the helper modules of both were ready together); each is its own section.*

### 3.1 The route is not the plan's

The plan's route for `v6_hug` (its § 5.2: wave 3's `flank_cone`, `flank_edge_exists`, `flank_initialPieces`, then "the tiles beyond those
edges are X′-tiles") needs a step it does not carry: that an initial piece of `T`'s edge at `y` lies in the closure of one `X′`-tile.
With curved arcs a second arc may be tangent to that edge at `y`, and what lies between them is invisible to cones — so I did not take
that route. The route taken reads no edge:

1. `Valid.dist_le_one_of_near_germ` (FS116-N1-GERM-R, pointwise, the near side; the crossing lemma `Valid.false_of_crossing`): near
   `y = r(ψ)` the class of the clockwise colour at `y' = r(ψ + 60°)` stays within `1` of `y'`.
2. `exists_ball_subset_closure_region_of_sole_tip`: near `y`, an interior point of `B(p, 1)` outside `B̄(y', 1)` has a colour that is
   not a colour of `p` (its tile would be a tile of `p` by the non-Siamese engine, a tile of `y` by `exists_ball_tileAt`, so the sole
   tip `T`, which lies in `B(y', 1)`) and not that clockwise colour (1.); so it has the other ring colour, and that open region lies in
   the closure of one colour class.
3. The arc of `ω(y')` from `y` toward `p` is in the closure of that region (`mem_closure_diff_closedBall`), so in the closure of a tile
   of the ring colour; mirror at `y'`. `twoCirc_cmp_one` (FS129-SR1-TWOCIRC, landed) puts points of the two arcs nearer than `1`; the
   non-Siamese engine makes the two tiles one; it holds a ring point just clockwise of `y` and one just counter-clockwise of `y'`, more
   than `1` apart (`dist_ringPt_shift_cmp`), against `IsTile.dist_lt_one`.

About 260 lines with the docstring (the plan's price: 300); two elaborations.

### 3.2 The finding (a generalization; sent mid-job, ruled on by the coordinator)

`not_sole_tip_of_adjacent_changePoints` has `v6_hug`'s hypotheses **without `hΓ`** (the Γ-free ring) and `doubleTip`'s **without `hS`**
(`SimpleOn (closedBall p 1)`), **`hv`** (`¬ GermOnQ p (ψ − π/3) .cw`) and **`hu`** (`¬ GermOnQ p (ψ + 2π/3) .ccw`), at every `k` with
`k ≤ ncard + 2`. So FS116-V6-HUG is not confined to the empty class, and FS129-MR1-DOUBLETIP holds with neither simplicity nor a
condition on the far germs. By the coordinator's ruling (mid-job, 2026-10-06) the two statements keep their hypotheses as filed, each
idle one read by `have _ := …`, and `doubleTip` is closed here from the lemma; whether the rows are restated at the wider class is
decided at the wave's landing.

**Which of its hypotheses are jointly satisfiable short of the last** (my reading, one mind, a sentence and not a proof): a valid
non-Siamese map with a vertex of four colours and two absent and a change point on its ring is held by hand (the bowtie's centre, the
strip's `P₂`: `Plane/RingCalculus/Star`'s header), but **two change points `60°` apart are held by no fragment** (`Empty`'s header:
"no held fragment has two adjacent change points of this kind"), so already "`hy` and `hy'`" together are not known satisfiable, and
the lemma may be a refutation of hypotheses that contradict each other before the tip enters. No Lean model of any part of the class
exists.

Not checked: the entries' prose for why simplicity and the far germs were asked (the second planner reads that); any held fragment
against the lemma.

## Stage 4 — SAVED (FS131-I8A): `v6_hubs` and `emptyNS`

### 4.1 `v6_hubs` — the plan's children, and where the route differs

New module `Plane/RingCalculus/RingColour` (the germ colouring), the assembly in `Empty`. The plan's H1–H7, as built:

- **H1 is not needed.** `germ_dichotomy` (landed, wave 3) gives every germ in one class or on a ring arc; a Γ-free ring has no ring arc
  (`GammaFreeRing.exists_germIn`). No finiteness of `Γ ∩ ω(p)` is read anywhere.
- **H2–H6** are `RingColour`'s lemmas over a germ colouring `κ` taken as data: `germCol_const` (H4, by `IsPreconnected.constant` on
  an open interval), `germCol_rotate_ne` (H3), `germCol_change_rotate`/`germCol_change_int` (H5), `exists_germCol_change` (H6),
  `exists_isChangePoint_iff` (a change point is a point whose two germs differ in colour — `r(ψ) ∈ Γ` follows).
- **H7** (`GammaFreeRing.changePoint_gap`): no count of change points in a window, no finiteness, no parity as a number. Two change
  points less than `60°` apart give a third in the window by H4 twice (`exists_third_change`). Then three classes of change points;
  each class is six ring points `60°` apart covered by the four tiles of `p` (`exists_fin_tileAt`, `star_tip_nonempty`), so by a second
  kernel table on the thirteen tip sets (`V6Count.twoDoubles`, 11.8 s) each class has two tiles holding two consecutive points of it;
  no tile does so in two classes (`not_double_two_classes`: `cos δ = cos(δ + 60°) + cos(δ − 60°) ≥ 1` forces the two points equal);
  `fin_four_three_pairs` ends it. **The plan's caution holds as it said**: the count alone gives `m ≤ 2`, and the third change point
  is the colour argument.
- The statement's `∃ ψ₀, ∀ ψ, … ↔ ∃ n : ℤ, ψ = ψ₀ + n * (π / 3)`: `ψ₀` from H6, `←` by H5 over `ℤ`, `→` by the floor of
  `(ψ − ψ₀)/(π/3)` and H7.

About 330 lines (`RingColour` 190 with examples, the assembly 140); the plan's price was 600–900. One elaboration found the one defect
(an unused hypothesis of a helper).

### 4.2 `emptyNS` — the composition

As the plan: `ψ₀` from `v6_hubs`; four tiles by `exists_fin_tileAt`; `tip i a` := "some integer of the class `a` has its sixth in
`cl (tile i)`" (so `ringPt_sixth_dist_le_one` applies with no case split on `ℤ/6`: `sixth_cons_of_mem_closure`); `hhug` from `v6_hug`;
`v6_count` gives a hub `a` with every tile tipping `a` or `a + 3`; the split lemma on "tips `a`" / "tips `a + 3`" against `v6_anti`.
**Only the first conjunct of `v6_count`'s conclusion is read** (every tile tips `a` or `a + 3`); the four others are idle in this
composition. About 75 lines (the plan's price: 200).

### 4.3 The model, the markers

- `emptyNS`'s docstring and the module's say the Lean model is owed and name it: `sq9Map : ArcMap 9` (`Plane/Saturated/Sq9Map`, wave 6)
  and the five facts (`Valid`, `NonSiamese`, `Covers` at a lattice vertex, four colours there, `GammaFreeRing` there). Not built here
  (the brief's item 3).
- `v6_hubs`, `v6_hug` are public with their `VACUITY DECLARED` lines; `v6_hubs_vacuous`, `v6_hug_vacuous` are untouched and now rest on
  a proved `emptyNS` (axioms: the standard three).

### 4.4 The save (stages 3 and 4)

- Build: `data/fs131/i8a/logs/build-3-route.log` — "build: OK — 468 of 468 batches, 6 module(s) rebuilt, 2 module(s) with warnings",
  `EXIT=0`. Rebuilt: `HubCount` (24 s: two kernel tables), `TilesAt`, `SoleTip`, `RingColour`, `Empty`, `Proofs`. Warnings: three
  `declaration uses sorry` — `Star` ll. 211, 231 (`star_recip`, `star_anti`) and `Empty` l. 559 (`outerAdj`, the second planning pass's).
- Statement check against `f1c13612` (`data/fs131/i8a/logs/stmt-3.log`): 23 base declarations, 0 changed or missing, 9 added in `Empty`.
- Axioms (`data/fs131/i8a/logs/axioms-3.txt`): 64 records, each a subset of the standard three (`V6Count.table`, `V6Count.doublesTable`:
  `[propext, Quot.sound]`); the control prints `sorryAx`; `--fault` exits 1 naming the control.
- `./scripts/dupnames.sh`: OK (`data/fs131/i8a/logs/dupnames-3.log`). `tools/check_architecture.py`: PASS
  (`data/fs131/i8a/logs/check-architecture-3.log`), with rows for `SoleTip` and `RingColour`.

## Stage 5 — SAVED (FS131-I8A): `star_recip`; `star_anti` left open, with a gap named

### 5.1 `star_recip`

The plan's route, shorter: `p` is a change point of `ω(y)` because otherwise FS129-SR2-TOUCHW (`touchW`, landed) at `y` and angle
`ψ + π` makes one of the two colours absent at `y` absent at `p` too, while `star_absent` puts both among the colours of `p`. No
separate proof that the two germs at `p` lie in single classes is needed (the change point carries them). The tiles are
`exists_tileOf_of_germIn` (a germ in a colour class is connected and off `Γ`, so in one tile of that colour, with the ring point in its
closure) — a new lemma in `Star`, class-free. About 45 lines (the plan's price: 150); one elaboration.

### 5.2 `star_anti` — not proved: a gap at the plan's step "t⁺ ≠ t⁻"

Not started beyond its analysis. The argument (`plans/FS116-N2-proof.md` ll. 219–222): "If t⁺ = t⁻, its cone (an interval) holds one of
the closed half-circles … in its interior, leaving no room for a tip of y … or for the tile of p of an outer colour of y". In Lean the
cone of a tile at a point where the map is simple is `angleIcc β₁ β₂` with `β₁ ≤ β₂ ≤ β₁ + 2π`, and the separation
(`SimpleOn.coneAt_eq_angleIcc_sep`) is disjointness of every other tile's cone from the **open** interval `angleIoo β₁ β₂`.

- If `β₂ < β₁ + 2π` the argument is sound: the other tiles' cones lie in the closed gap, which holds neither `ψ + 90°` nor `ψ − 90°`
  (both interior to the cone), and a tip's cone (in `[ψ − 90°, ψ + 90°]`) and an outer colour's tile's cone (in `[ψ + 90°, ψ + 270°]`)
  cannot both lie in one gap missing both boundary directions.
- **If `β₂ = β₁ + 2π`** (the cone is the whole circle), the gap is the single direction `β₁`, and the separation leaves the other
  three tiles of `p` room there, as cusps. A tip of `y` and the tile of an outer colour of `y` can then both have the cone `{β₁}` with
  `β₁ ≡ ψ ± 90°`: tangent at `p` to `ω(y)`, one inside `B̄(y, 1)`, one outside `B(y, 1)`. I found no contradiction from the lemmas
  held (STAR's clauses, validity, non-Siamese, Jordan domains at `p`), and no configuration realizing it in a valid map with two
  antipodal hubs.

So: **GAP at that step, the full-circle cone; neither a proof nor a refutation of the statement.** If the configuration exists,
`star_anti`'s first conjunct (`tp ≠ tm`) fails and the statement needs `tp ≠ tm` (or a proper cone) as a hypothesis. Sent to the
coordinator mid-job with the save of Stage 4. The rest of the route (cardinalities from `star_coloursAt`; the single tip colour — for
which the diameter of a tile is enough: a tile of one colour tipping `y` and `y*` would have closure points `2` apart) looked sound and
is about 150 lines.

### 5.3 Small repairs in this stage

- `Plane/RingCalculus/TilesAt`'s header said its spec examples were at its end; they are in `Empty` (the split lemma on `halfPlane2`).
  Corrected. A slip of Stage 2, mine.
- `Plane/RingCalculus/RingColour`: an `example` exhibiting a germ colouring of `halfPlane2`'s ring — an inhabitant of the hypothesis
  `hκ` its lemmas take.

### 5.4 The save

- Builds: `data/fs131/i8a/logs/build-4-recip.log` (with `star_recip`: "build: OK — 468 of 468 batches, 5 module(s) rebuilt", `EXIT=0`)
  and `data/fs131/i8a/logs/build-5-final.log` (with the two repairs of § 5.3: "build: OK — 468 of 468 batches, 5 module(s) rebuilt,
  2 module(s) with warnings", `EXIT=0`). The warnings are the two `sorry` left on the branch's ring calculus: `Star` l. 268
  (`star_anti`) and `Empty` l. 559 (`outerAdj`). `rg -c "^\s*sorry"`: `Star` 1, `Empty` 1, the five other modules 0.
- Statement check against `f1c13612` (`data/fs131/i8a/logs/stmt-5.log`): 23 base declarations compared, **0 changed or missing**,
  10 added (9 in `Empty`, `exists_tileOf_of_germIn` in `Star`). `…/Basic` byte-identical to `f1c13612` (`git diff` empty).
- Axioms (`data/fs131/i8a/logs/axioms-5.txt`): 66 records, each a subset of the standard three; the control prints `sorryAx`;
  `--fault` exits 1 naming the control (`axioms-5-fault.verdict`).
- `./scripts/dupnames.sh`: OK (`data/fs131/i8a/logs/dupnames-5.log`). `tools/check_architecture.py`: PASS (`check-architecture-4.log`).
- No `axiom`, no `native_decide` in the seven modules (grep; the one hit is `HubCount`'s docstring saying so).

### 5.5 The coordinator's ruling on `star_anti`, and what I did with it

The ruling (mid-job, after § 5.2 was sent): the gap is a defect of the skeleton's hypothesis — the row's "not claimed" line
(`plans/FS116-derivation.md` l. 719) excludes "anything when an edge of p leaves at ψ + 90° or ψ − 90°", which
`ψ ± π/2 ∈ interior (coneAt t p)` says except when the cone is the whole circle — and `star_anti` gains two binders after `hm`:

    (hp'' : ∀ T, F.TileAt p T → T ≠ tp → ψ + π / 2 ∉ coneAt T p)
    (hm'' : ∀ T, F.TileAt p T → T ≠ tm → ψ - π / 2 ∉ coneAt T p)

with the choice left to me by my token count. **I did not make the change**: by my own count I am past the brief's guidance line and
near its hand-back line, and the leaf is about 200 lines of interval work modulo `2π`. The statement and the leaf stand as at
`f1c13612`; the wave's next job makes the ruled change. What I can hand it, attacked by thought only (not elaborated):

- **The binders close the stuck case.** If `tp = tm = t` with the whole circle as cone, every other tile of `p` has its cone in
  `{β₁} + 2πℤ`; a tip of `y` (cone non-empty, in `[ψ − 90°, ψ + 90°]`) and the tile of `p` of an outer colour of `y` (cone non-empty, in
  `[ψ + 90°, ψ + 270°]`) both exist at a hub and are not `t` (its colour is absent at `y`, theirs are not), so `β₁` is in both closed
  half-circles, hence `β₁ ≡ ψ ± 90°` — which `hp''` or `hm''` forbids of a tile other than `t`.
- **They are no new content at a proper interval.** If the cone of `tp` is `angleIcc β₁ β₂` with `β₂ < β₁ + 2π`, its interior is in
  `angleIoo β₁ β₂`, which `SimpleOn.coneAt_eq_angleIcc_sep` keeps disjoint from every other tile's cone; and if `tp ≠ tm` a
  whole-circle cone of one leaves the other's cone discrete, with empty interior, against `hm` or `hp'`. So the binders bite only where
  the statement was not known true.
- **Their form is usable as written**: the proof applies them to a tip (`IsTip p y S` gives `F.TileAt p S`) and to the tile of `p` of an
  outer colour. `TileAt`, not `TileOf`, is the right one.
- **The route for the rest**: (a) `cp ≠ cm` from `tp ≠ tm` (one tile per colour at `p`); (b) `{cp, cm} ⊆ A(y), A(y*)` from
  `star_flank_interior` (at `y*` use the angle `ψ − π`, whose ring point is `r(ψ + π)`); (c) `|C(y)| = 2 + |T_y| + |O_y|` from
  `star_coloursAt`, `disjoint_tipColours_outerTileColours`, and both non-empty at a hub, so `|C(y)| = 4`, `A(y) = {cp, cm}`,
  `T_y = {a}`, `O_y = {b}`; (d) `a ≠ a*` for the tip colours at `y` and `y*` because one tile of `p` of that colour would hold `y` and
  `y*`, `2` apart (`IsTile.dist_le_one_of_mem_closure`), so `T_y = O_(y*)` and `O_y = T_(y*)` — no cones needed for (d), unlike the
  plan's route.

## Drafts for the front page

*For the coordinator to file; nothing here is filed by this job. This job did not run the gate (its brief withholds it: the landing's),
so it drafts no gate counts and no trust-ledger counts.*

1. **`CLAUDE.md` § The gate, § Trust ledger** — no draft: counts are the landing job's. What the landing will meet from this branch:
   two `decide +kernel` tables (`V6Count.table`, `V6Count.doublesTable`; axioms `[propext, Quot.sound]`, no purchase), about 24 s of
   kernel time in `Plane/RingCalculus/HubCount`; this job's block in `scripts/Axioms.lean` (66 records, all CLEAN); two
   `VACUITY DECLARED` lines (`v6_hubs`, `v6_hug`) the vacuity scan will print, each with a kernel refutation beside it; `sorry` left on
   the branch: `outerAdj` (`Empty`), `star_anti` (`Star`).
2. **`LEDGER.md` row 148** (slot: the row's grade and address; follows its statement) — draft: "**[kernel on `fs131-w8a`, not gated]**
   at the wider class of FS129-SR3-EMPTY-NS — non-Siamese, simple or not: `HadwigerNelson.Plane.ArcMap.emptyNS`
   (`Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean`), on the standard three axioms, no assumption imported. Its steps:
   `v6_hubs`, `v6_hug` (each `VACUITY DECLARED`, refuted by `v6_hubs_vacuous`, `v6_hug_vacuous`), `v6_count` (a kernel table),
   `exists_ne_mem_closure_inter_of_split`, `v6_anti`. Lean model at nine colours owed (`sq9Map`, five facts)."
3. **`LEDGER.md` row 150**, its sole-tip half (slot: after "share neither a sole tip") — draft: "the sole-tip half **[kernel on
   `fs131-w8a`, not gated]**, and wider than filed: `not_sole_tip_of_adjacent_changePoints`
   (`Proofs/HadwigerNelson/Plane/RingCalculus/SoleTip.lean`) reads no simplicity and no condition on the far germs; `doubleTip` is its
   instance with the row's hypotheses kept. The sole-outer-colour half (`outerAdj`) is open."
4. **`LEDGER.md` § B, FS116-V6-HUG's line** (slot: its grade cell, "hand; one mind; true vacuously") — draft: "kernel on `fs131-w8a`;
   not vacuous at the class its proof reads (`not_sole_tip_of_adjacent_changePoints`: no Γ-free ring)."
5. **`LEDGER.md` § B, FS116-N2-RECIP's line** (slot: its grade cell) — draft: "kernel on `fs131-w8a`: `star_recip`, at a change point
   `y` of four colours (never a hub, never non-Siamese), `Covers p 2`."
6. **`CLAUDE.md` § Frontier**, the Open-milestones paragraph (slot: after "the Lean backlog … in a session of its own") — no change of
   state by this job: FS-131 stays open; wave 8's route to `emptyNS` is proved on a branch.
7. **Proof Atlas grade changes** (on landing, not now): FS129-SR3-EMPTY-NS, FS116-Y4-EMPTY, FS116-Y4-OBST, FS116-V6-HUBS, -V6-HUG,
   -V6-COUNT, FS129-MR1-DOUBLETIP, FS116-N2-RECIP → kernel; FS116-N2-ANTI stays hand, with a gap named (§ 5.2).
