# FS131-I8C — wave 8, the semi-hub rows' first module (`Plane/RingCalculus/SemiHub`)

*Job FS131-I8C (de Bruijn, the implementer), 2026-10-06, branch `fs131-w8c` (cut from `fs131-w8b` at `6e0cf10d`). Brief:
`data/fs131/briefs/FS131-I8C-wave8-semihub.md` (on `main`). The plans: `plans/FS131-w8-kernel-plan.md` Stages 6–10 (the planner's
record, FS131-K8b) and `plans/FS131-I8B-implementation.md` (the join job's record: the shared lemmas and its section for the two
implementers). Working files: `data/fs131/i8c/`. Tools: `tools/fs131_i8c_*.py`.*

## Theorems this phase proved

All [kernel] on branch `fs131-w8c` (built through `./scripts/build.sh`, log `data/fs131/i8c/logs/build-3-seventeen-leaves.log`;
**not gated, not on `main`**), each on exactly `[propext, Classical.choice, Quot.sound]` (`data/fs131/i8c/logs/axioms-3.txt`);
declarations of `HadwigerNelson.Plane.ArcMap` in `Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean`. No assumption is
imported and no hypothesis stands for an unproved result. Each read against its row's entry as filed
(`data/fs131/k8/rows-extract.md`); where the kernel statement is narrower or wider than the row, the line says how.

- **FS116-V5-QCOL** (row 132), all clauses but one — `qcol_inner_tile` ("a germ on a (Q) arc lies on an arc of ω(p) whose inner
  tile is p's tile of the inner colour": valid, non-Siamese, any point `p`, any `k`); `qcol_not_one_arc` ("the two germs of one pair
  never lie on one (Q) arc", no change point read); `GermOnQWith.exists_isRingArc_ccw`, `…_cw` (a germ on a (Q) arc is a sub-arc
  with the same sides from its point; no map hypothesis) — with the planner's `qcol_cw`, `qcol_ccw`,
  `IsTile.not_mem_closure_of_not_subset_ball`, and `ringArc_dist_le_one`, now a kernel theorem. **Not in the kernel**: the clause
  "a (Q) arc holding u⁺ (v⁻) and not u⁻ (v⁺) ends at u (v)" (not stated; the sub-arc lemmas stand in for its uses).
- **FS116-N3-PAIR** (row 99) — `germPair_inner_ne` (the step: the two arcs' inner colours differ) and the planner's
  `germPair_swap`, now a kernel theorem: "if both germs of one pair … lie on (Q) arcs and the two arcs have the same pair of
  colours, then the inner colour of each is the outer colour of the other". Wider than the row: no change point, no *simple*, any
  `k`.
- **FS116-V5-DICHO** (row 140) — `germPair_dicho`: "Π₁ = Π₂ (and then the inner colour of each is the outer colour of the other) or
  Π₁ ∩ Π₂ = ∅", at a point of exactly four colours simple for the map; from `ringArc_pair_eq_or_disjoint` — the dichotomy clause
  for **any two** arcs of `Γ` on `ω(p)` whose side colours are carried at `p` (a generalization of that clause; the swap is read
  at a germ pair only, § 3.2).
- **FS116-N3-CONE** (row 110) — (a) `ringTile_uMinus`, `ringTile_vMinus`, `ringTile_vPlus`, `ringTile_uPlus` (no *simple* read;
  `F.Covers p 1`, at least four colours, at most two absent, a change point); (c) `isRingArc_of_edge` ("an edge at y between a tile
  inside B̄(w, 1) and a tile outside B(w, 1) is an arc of ω(w)": `y` lies on an arc of `Γ` on `ω(w)` with those side colours; any
  map; its hypothesis `T₁ ≠ T₂` is not read) and `four_le_of_bothKind` ("whose centre w, if it carries both side colours, is a
  vertex of at least four colours": valid, non-Siamese, `w ∈ dom`, simple at `w`) — with the planner's (b), the four
  `germOnQ_bar_*`, and `closure_inter_subset_sphere`.
- **FS116-N3-STAR2** (row 100) — `exists_isStar4` (a vertex of exactly four colours simple for a valid non-Siamese map has a star);
  `ringArc_star` (a (Q) arc joins opposite tiles, with FS112-U1's four bounds); `fullSemiHub_star_crossed` (the row's four windows
  and `ℓ + m ≤ 60°`); `fullSemiHub_star_parallel` (the row's two inclusions, the other two cones by
  `IsStar4.angleIcc_subset_cone₂`, `…_cone₄`). The row's "at least four colours" is exactly four; its "full semi-hub of kind O" is
  the two arcs, which is all the argument reads.
- **No row**: `fullSemiHub_star_parallel_T` (`plans/FS116-N3-proof.md` § 2.3's third line; FS116-N3-STAR2's *not claimed* line
  excludes kind T; no held model).
- **Helpers, no row of their own**: `IsRingArc.exists_sub_of_germIn`, `exists_far_of_germPair`, `germIn_closure_tile_of_near`,
  `disjoint_ball_of_far_germ`, `simpleOn_not_hasRepeatedColour` (the statement of wave 9's leaf
  `not_hasRepeatedColour_of_simpleOn`), `IsStar4.rotate`, `IsStar4.shift`, `IsStar4.exists_first`,
  `IsStar4.opposite_of_disjoint`; in `HadwigerNelson.Plane`: `two_pi_mul_int_le_of_neg`, `two_pi_le_mul_int_of_pos`,
  `BranchGerms.nextβ_four`, `halfDisc_valid`, `halfDisc_nonSiamese`, `halfDisc_ncard_coloursAt_zero`.

**No Lean term inhabits a star or a semi-hub** (§ 3.4): the star rows and FS116-N3-CONE (a) are kernel theorems whose hypotheses
are met by held fragments by hand only.

## Stage 1 — SAVED (FS131-I8C): the readback, the leaves' kernel signatures, the branch built as given

### 1.1 What I may and may not change

- **May**: the proofs of the 17 `sorry` leaves of `Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean`, and new helper
  declarations there under names no other module declares; a new module of my own beside it (with `Proofs.lean` and
  `ARCHITECTURE.md`); a block "FS131-I8C" in `scripts/Axioms.lean` above the `=== PURCHASED ===` banner; this record;
  `tools/fs131_i8c_*.py`; `data/fs131/i8c/`; `data/fs131/reports/FS131-I8C.md`. Docstrings may be corrected (the plan's § 9.8).
- **May not**: any statement or definition; the shared module `StarChart` (a change to it is a message to the coordinator);
  `SemiHubPlaces` and `outerAdj` (FS131-I8D's); the wave's other modules; any landed module; `main`; an `axiom`;
  `native_decide`; a merge of another branch; the gate.

### 1.2 The brief's quotations against their sources (standing rule 3)

`tools/fs131_i8c_quotes.py` (the form of the join job's `tools/fs131_i8b_quotes.py`, which is another job's and is not edited)
reads every `> …` block of the brief with its `> — source:` line and looks for the text, whitespace collapsed, in the source:
**36 quotations, 36 found verbatim, 0 missing** (`data/fs131/i8c/logs/quotes.log`, exit 0). Planted fault (`--fault`, one letter
of the first quotation changed): exit 1, one `MISS` (`data/fs131/i8c/logs/quotes-fault.log`).

One note on the sources, no defect of wording: the seventeen statement quotations and the seven shared-lemma quotations are the
first lines of their declarations; each was read whole in the module (§ 1.3) and from the kernel (§ 1.4).

### 1.3 What was read

- The brief; `plans/STANDING-RULES.md`; `LEAN.md` in full; `RUNNING.md` § Building and § Make the gate fail, and watch it fail.
- The planner's record, Stages 6–10 whole (§ 7.5 the three words; § 8 the model, what the pass changed, the statements against
  their rows and attacked; § 9.1–9.2 the routes; § 9.5, 9.6, 9.8). The join job's record whole (its § 3.2 statements, § 3.3 on K2,
  and "For the two implementers who start from here", notes 1–7).
- The module `Plane/RingCalculus/SemiHub` in full; `Plane/LocalMap` in full; `Plane/RingCalculus/Basic` (definitions and first
  consequences); `Plane/RingCalculus/StarChart` (statements, and the proofs of G1, `ncard_tileAt_eq`, K1); the landed lemmas each
  leaf cites, at their statements (named per leaf in the later stages).

### 1.4 The leaves' kernel signatures (inventory item 556)

`#check @…` on the seventeen leaves from the built modules (`data/fs131/i8c/logs/leaf-signatures-as-given.log`): **every hypothesis
its statement names is a binder of the kernel's statement; no section variable carries one** (the module declares only `{k}` and
`{F}`). `isRingArc_of_edge` reads no validity and no non-Siamese hypothesis, as its docstring says ("Any map"); `qcol_inner_tile`,
the two sub-arc lemmas and `germPair_inner_ne` read no *simple*; the four `ringTile_*` read `F.Covers p 1`, `4 ≤ ncard`,
`k ≤ ncard + 2` and a change point; the five star leaves read `p ∈ F.dom`, `F.SimpleOn {p}` and `ncard = 4`.

### 1.5 The branch as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, log `data/fs131/i8c/logs/build-1-as-given.log`:
"build: OK — all 1812 modules already up to date, nothing built, 3 module(s) with warnings", `EXIT=0`. `rg -c "^\s*sorry"` on
`Proofs/HadwigerNelson/Plane/RingCalculus/`: `SemiHub` 17, `SemiHubPlaces` 6, `Empty` 1 — the 24 the join job handed on.

## Stage 2 — SAVED (FS131-I8C): nine leaves, the model owed, the tools

### 2.1 The leaves closed (in the planner's order; each first elaborated in a scratch file, then pasted)

| leaf | route as written | lines | against the plan |
|---|---|---|---|
| `qcol_inner_tile` | `innerColours = {c}` puts each interior point of the arc in `closure (region c ∩ ball p 1)`; every point of that set is in `closure T` by G1 (`mem_closure_tile_of_near`, with `p ∈ closure T` at distance below `1`); close the arc as `IsRingArc.ringArc_subset_closure` does | 10 | the plan's route (35 priced) |
| `GermOnQWith.exists_isRingArc_ccw`, `…_cw` | one helper for both sides, `IsRingArc.exists_sub_of_germIn`: wave 3's `exists_germ_interior` gives, for small `t`, an interior angle of the arc congruent to `θ + s t`, and `mem_ringArc_of_germIn` the end `r(θ)` itself | 30 + 9 + 9 | **the plan's "hard" (angles modulo `2π`) was landed**: `exists_germ_interior` (`Plane/RingGerm` l. 1189) is the plan's child "a point of `ringPt p '' Icc` that is not an end's image is an interior point's image" (110 priced) |
| `qcol_not_one_arc` | `exists_far_of_germPair` (a point of each germ, `120° ± 2t` apart, by `dist_ringPt_ringPt_cmp_one`) against `ringArc_dist_le_one` | 5 (+ 25 helper) | the plan's route; `dist_ringPt_shift_cmp` does not serve (it asks `\|d\| ≤ 1` and the shift here is `60° + 2t > 1`): `dist_ringPt_ringPt_cmp_one` (`Plane/Chord`) is the lemma |
| `germPair_inner_ne` | the same helper; one tile of `p` would hold both points (`qcol_inner_tile` twice, `IsTile.dist_le_one_of_mem_closure`). **No sub-arc is formed**: `GermOnQWith` hands the arc itself | 7 | shorter than the plan (60 priced: "sub-arcs at `u`, `v`") |
| `ringTile_uMinus`, `ringTile_vPlus` | `germIn_closure_tile_of_near`: the germ lies in the closure of the class (`qcol_cw` / `qcol_ccw`), its points are nearer than `1` to `y ∈ closure R`, so in `closure R` (G1); `GermIn.ringPt_mem_closure`; `IsTile.subset_ball` | 9 + 9 (+ 11 helper) | the plan's route. Its child "the ring germ of a change point lies in the tile of its colour at `y`" is **not needed**: G1 is applied to `y` itself, which the statement gives in `closure R` |
| `ringTile_vMinus`, `ringTile_uPlus` | `disjoint_ball_of_far_germ`: each germ point lies in the closure of some tile of the colour, which is not `R` (its point is more than `1` from `y`) and so is far from `R` (`unitNear_or_unitFar`, non-Siamese); a point of `R` nearer than `1` to `v` would be nearer than `1` to a germ point | 6 + 6 (+ 28 helper) | the plan's route (2 × 45 priced) |

Helpers added to `SemiHub` (names grepped by declaration keyword on `origin/main`, `origin/fs131-w6`, `-w7`, `-w9`, `-w8b`: none
declared there; `./scripts/dupnames.sh` below): `IsRingArc.exists_sub_of_germIn`, `exists_far_of_germPair`,
`germIn_closure_tile_of_near`, `disjoint_ball_of_far_germ`. `SemiHub` now imports `Plane/RingCalculus/StarChart`.

With these, the planner's two declarations proved from stated leaves are theorems of the kernel: `ringArc_dist_le_one` (from
`qcol_inner_tile`) and FS116-N3-PAIR's `germPair_swap` (from `germPair_inner_ne`).

### 2.2 The model owed by the join job (ruling 586 (b))

At the end of `SemiHub`: `halfDisc_valid`, `halfDisc_nonSiamese` (the unnamed example of `Plane/ArcMap`, named),
`halfDisc_ncard_coloursAt_zero` (two colours at `0`), and one `example` that runs the three shared lemmas on the object:
`halfDisc` is valid, has no Siamese pair, is simple at `0 ∈ dom` (`halfDisc_simpleOn`); `ncard_tileAt_eq` counts **two tiles at
`0`**; `exists_sectorChart_tileAt` gives a chart with two germs whose sectors are those tiles; and for the two tiles (taken from the
count by `Set.ncard_eq_two`, so the conclusion is about two tiles that exist) `exists_initialPiece_of_ncard_le_three` gives an
initial piece of an arc of the map in both closures. This is a model of the class "valid, non-Siamese, simple at `x`" at a point of
two colours; **it is no model of a star or of a semi-hub** (four colours at a point: still owed, as the planner's § 9.6 says).

### 2.3 The save

- Build: `data/fs131/i8c/logs/build-2-nine-leaves.log` — "build: OK — 468 of 468 batches, 3 module(s) rebuilt, 3 module(s) with
  warnings", `EXIT=0`. Its full log (`build/gate/build/20261006T230021Z-3865311.log`) names 15 declarations with `sorry`:
  `SemiHub` 8, `SemiHubPlaces` 6, `Empty` 1; every other warning line is absent. `rg -c "^\s*sorry"` agrees for `SemiHub`: 8.
- Axioms from the built modules (`tools/fs131_i8c_axioms.py`, the form of the join job's; `data/fs131/i8c/logs/axioms-2.txt`,
  `axioms-2.verdict`): 18 records of the block "FS131-I8C" of `scripts/Axioms.lean`, each a subset of the standard three; the
  planted control prints `sorryAx`; `--fault` exits 1 naming the control (`axioms-2-fault.verdict`).
- Statement check on elaborated signatures (`tools/fs131_i8c_stmt.py`, the form of the join job's, over the ten modules of the ring
  calculus, `StarChart` among them) against `6e0cf10d` (`data/fs131/i8c/logs/stmt-2-vs-6e0cf10d.log`): **235 base declarations
  compared in 10 modules; 0 changed or missing; 7 added** (the four helpers and the three `halfDisc_*`); exit 0. Its four planted
  faults (`--self-test`: a hypothesis of `germPair_dicho` altered, an `include` that adds `0 = 1 →` to `qcol_inner_tile` with the
  text unchanged, a binder added to `ringArc_star`, the definition `IsEdgeDir` altered): `data/fs131/i8c/logs/stmt-selftest.log` —
  control 'binder' exit 1 — FIRED (`ringArc_star`: type hash, printed type); 'def' — FIRED (`IsEdgeDir`: value hash alone, its
  type unchanged); 'include' — FIRED (`qcol_inner_tile`: type hash, printed type, the source text of the statement identical);
  'text' — FIRED (`germPair_dicho`); "self-test: OK — every planted fault fired", exit 0. Each run names exactly its culprit.
- `./scripts/dupnames.sh`: "OK — no name is declared by two modules (23 generated on demand)", exit 0
  (`data/fs131/i8c/logs/dupnames-2.log`). `tools/check_architecture.py`: `RESULT: PASS` after `ARCHITECTURE.md`'s row for `SemiHub`
  gained the import and the state (`check-architecture-2.log`).

### 2.4 Re-priced from the first leaves (the brief's item 2)

Nine leaves and the model in about 185 lines of Lean against the planner's 365 for those leaves (0.5), each on its first or second
elaboration. Two of the plan's "hard" children were landed lemmas (`exists_germ_interior`; G1 applied to `y` directly). **The
remaining eight leaves, re-priced**: the five star leaves and `germPair_dicho` about 250 lines (the plan: 980), since
`exists_isStar4` is K1 read out (the join job's note 2), the windows are `linarith` after C1, and DICHO has a route with no case
table (§ 3.2 below); `four_le_of_bothKind` about 30 (the plan: 80); `isRingArc_of_edge` about 150 (the plan: 250), through wave
4's `IsSectorChart.exists_isRingArc_of_along`. Expected: all seventeen in this job.

## Stage 3 — SAVED (FS131-I8C): the other eight leaves; the module holds no `sorry`

### 3.1 The leaves closed

Proof-body lines are measured from the module (the lines between `:= by` and the declaration's end); § 2.1's column counted the
statement lines too, by eye — two measures under one word, labelled here.

| leaf | route as written | proof lines | against the plan |
|---|---|---|---|
| `exists_isStar4` | K1 with the count (`exists_sectorChart_tileAt … h4`) at `n = 4`: tiles `τ 0 … τ 3`, edges `G.β 0 … G.β 3`; `G.nextβ` unfolded once for four germs (`BranchGerms.nextβ_four`); the order is `hC.sorted.mono` | 24 | the join job's note 2, as it said (the plan: 250) |
| `ringArc_star` | a star read from the inner colour's tile (`IsStar4.exists_first`, over `IsStar4.rotate`), moved into the facing window by C1 and `IsStar4.shift`; the outer colour's tile is first, second or fourth only against the bounds (`linarith` after C1, with the two halves "a non-zero integer multiple of `2π` has size at least `2π`": `two_pi_mul_int_le_of_neg`, `two_pi_le_mul_int_of_pos`); third: C1 and C2 give its bounds | 46 | the plan's route (200 + 130) |
| `fullSemiHub_star_crossed` | `ringArc_star` on `A`; the tile of `b` is not first or third (colours), not second (`linarith` after C1), so fourth, with its lift `j = 1`; the tile of `b'` is not first or third (colours), not fourth (`linarith` after C1), so second, lift `0`; the four windows and `ℓ + m ≤ 60°` read off | 56 | the plan's route (110) |
| `fullSemiHub_star_parallel`, `…_parallel_T` | `ringArc_star` on `A`; `B`'s outer window on the first tile (lift `0`) and inner window on the third (lift `1`) | 23 + 23 | the plan's route (2 × 80) |
| `germPair_dicho` | **another route than the plan's**: `ringArc_pair_eq_or_disjoint` (§ 3.2) and the planner's `germPair_swap`. No sub-arc, no window, no case table | 5 (+ 35 + 28 for the two lemmas) | the plan: sub-arcs, `ringArc_star`, "twelve small cases", 200 |
| `four_le_of_bothKind` | `noBoth` and `simpleOn_not_hasRepeatedColour`: in a chart at `w`, K1's tiles colour the sectors (`IsSectorChart.hasRepeatedColour_iff`, `Plane/ValidMap/Pushforward`, now imported); two sectors of one colour are two tiles of `w` of one colour | 1 (+ 16) | the plan's route (80) |
| `isRingArc_of_edge` | the piece lies on `ω(w)` (`closure_inter_subset_sphere`); shrunk into a chart at `y` (`localSectors_disj`, `Arc.InitialPiece.exists_param`), its punctured part lies on one branch (`IsSectorChart.exists_branch_of_isPreconnected`) and is that branch out to the distance of its end (intermediate values of the distance from `y`); two of its points on `ω(w)` make the branch the germ of `ω(w)` (wave 4's `germ_eq_of_two_on_circle`); wave 4's `IsSectorChart.exists_isRingArc_of_along` gives an arc of `Γ` on `ω(w)` ending at `y`; a point of it on the piece names its side colours, since `T₁ ⊆ ball w 1` and `T₂` misses `closedBall w 1` (both tiles are open) | 109 | the join job's note 4, its second route (the plan: 250). The statement's `hne : T₁ ≠ T₂` is not read (§ 3.3) |

`germPair_dicho` moved in the file to below the stars (its proof reads `ringArc_star`); its statement is the planner's, byte for
byte, and the statement check below reads the kernel's.

### 3.2 `ringArc_pair_eq_or_disjoint`: the statement the dichotomy derives from, and exactly how far it reaches

    theorem ringArc_pair_eq_or_disjoint (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
        (h4 : (F.coloursAt p).ncard = 4) {u v u' v' : ℝ} {a a' b b' : Fin k} (hA : F.IsRingArc p u v a a')
        (hB : F.IsRingArc p u' v' b b') (ha : a ∈ F.coloursAt p) (ha' : a' ∈ F.coloursAt p) (hb : b ∈ F.coloursAt p)
        (hb' : b' ∈ F.coloursAt p) :
        ({a, a'} : Set (Fin k)) = {b, b'} ∨ Disjoint ({a, a'} : Set (Fin k)) {b, b'}

The tiles of an arc's two side colours have disjoint cones at `p` (wave 4's `IsRingArc.disjoint_coneAt`); consecutive tiles of a
star share an edge direction and every tile's cone is non-empty, so two tiles with disjoint cones are opposite
(`IsStar4.opposite_of_disjoint`: sixteen ordered cases, four same-tile and eight adjacent excluded, four opposite); a star has two
opposite pairs.

- **What generalizes** (a generalization of FS116-V5-DICHO's dichotomy clause, which the row states "if both germs of one pair at y
  lie on (Q) arcs", `data/fs131/k8/rows-extract.md` row 140): equal as sets, or disjoint, for any two arcs of `Γ` on `ω(p)` whose
  side colours are carried at `p`.
- **What does not**: the row's parenthesis "(and then the inner colour of each is the outer colour of the other)". That is
  FS116-N3-PAIR's conclusion and reads the two germs' position (`germPair_inner_ne`). Two sub-arcs of one arc have equal pairs and
  one inner colour. FS116-N3-PAIR's *not claimed* line — "anything about two (Q) arcs that are not at the germs of one pair" (row 99)
  — stands as filed.
- **What the kernel therefore did not check**: the planner's table of one-shared-colour cases (plan § 8.4, "One mind; the
  implementer's `linarith` is the second check"). The proof does not pass through it. It is neither confirmed nor refuted here.
- No Lean model: the hypotheses are met by hand by the strip's `P₀` and the bowtie's centre (`data/fs116/n3/semi.out`).

### 3.3 Findings about the statements (none changed)

- **No leaf was false and none needed a hypothesis it lacked.** Each was proved as the planner stated it.
- **`isRingArc_of_edge` does not read `hne : T₁ ≠ T₂`**: a tile inside `closedBall w 1` and a tile missing `ball w 1` differ (a tile
  is open and non-empty). The hypothesis is redundant, not wrong; it is kept, named in the proof by `have _ := hne` so that the
  unused-argument linter is not what reports it, and said in the docstring.
- **The rows' own entries against the final statements** (`data/fs131/k8/rows-extract.md`, rows 132, 99, 140, 110, 100; read at this
  stage — the brief asked for it at Stage 1, § 3.5):
  - FS116-V5-QCOL: its clause "a (Q) arc holding u⁺ (v⁻) and not u⁻ (v⁺) ends at u (v)" is **not in the kernel**. The planner did
    not state it (plan § 8.3); the two sub-arc lemmas give a sub-arc from `u` with the same sides, which is what the rows consume,
    and say nothing of where the arc itself ends. "FS116-V5-QCOL proved" is true of every other clause.
  - FS116-N3-CONE (c), "an edge at y … is an arc of ω(w)": the kernel statement is "`y` lies on an arc of `Γ` on `ω(w)` with inner
    colour `c₁` and outer colour `c₂`" for an initial piece of the edge — the planner's reading of "is an arc". Its last clause is
    `four_le_of_bothKind`, with `w ∈ F.dom` and *simple* at `w` as hypotheses (the row's setting supplies them only for `w` in the
    fragment's domain).
  - FS116-N3-STAR2: the four crossed windows and the two parallel inclusions agree with the row degree for degree (`π/6 = 30°`,
    read edge by edge: `t_b|t_a` is `e₁`, `t_a|t_b′` is `e₂`, `t_b′|t_a′` is `e₃`, `t_a′|t_b` is `e₄`). The row says "at least four
    colours"; the statements say exactly four, the form inventory item 592 ruled for the sibling module.
  - **`fullSemiHub_star_parallel_T` has no row**: it is `plans/FS116-N3-proof.md` § 2.3's third line, which FS116-N3-SEMI's argument
    reads, and FS116-N3-STAR2's *not claimed* line excludes kind T. It is a kernel theorem with no ledger row behind it and no held
    model.
  - FS116-V5-DICHO and FS116-N3-PAIR: § 3.2.
- **A leaf of wave 9 is proved here under another name**: `simpleOn_not_hasRepeatedColour` has the statement of
  `not_hasRepeatedColour_of_simpleOn` (`origin/fs131-w9`, `Plane/Classes/QFree` l. 135, there with `sorry`; read from that branch's
  source, not from a build of it). Sent to the coordinator mid-job; routed (inventory item 593, by its word).
- The module's one remaining occurrence of the word `sorry` is prose: the planner's docstring of `qcol_inner_tile` ("stated there
  with `sorry` on a branch this one does not hold"). A debt scan by text will meet that line; no term uses `sorry`.

### 3.4 What is owed after this job

- **A Lean star, and a Lean semi-hub**: no term inhabits `IsStar4`, nor the hypotheses of `ringArc_star`, the three pinned stars,
  `ringArc_pair_eq_or_disjoint`, `germPair_dicho`, the four `ringTile_*` (a change point of a four-colour vertex). Held by hand
  only (the strip's `P₀`, the bowtie's centre). `fullSemiHub_star_parallel_T` has no held model at all.
- A named example of `isRingArc_of_edge`'s hypotheses.
- Paid at this job: the class of the shared lemmas (`halfDisc` at `0`, two colours, § 2.2), and the two sub-arc lemmas on
  `quadRing` at `r(π/4)`, both sides (an `example` in the spec section; they read no map hypothesis, so `quadRing`, which is not
  valid, meets every hypothesis they have).

### 3.5 The save

- **Build** (the module text of digest `40148413b2a7b1cb`, md5, first sixteen characters, recorded before the launch and matched
  after): `data/fs131/i8c/logs/build-3-seventeen-leaves.log` — "build: OK — 468 of 468 batches, 3 module(s) rebuilt, 2 module(s)
  with warnings, 8m38s", `EXIT=0`. Its full log (`build/gate/build/20261006T233019Z-4080976.log`): "✔ Built
  Proofs.HadwigerNelson.Plane.RingCalculus.SemiHub (6.9s)", no warning of any kind for `SemiHub`; the two modules with warnings are
  `SemiHubPlaces` (6 declarations with `sorry`) and `Empty` (1), the sibling implementer's. The log's one line reading "error" is
  the up-to-date probe naming `SemiHub` as the target to rebuild (line 5; the same line stands in build 2's log).
- **Axioms**, from the built modules (`axioms-3.txt`, `axioms-3.verdict`): 35 records of the block "FS131-I8C" — the seventeen
  leaves, the planner's `ringArc_dist_le_one` and `germPair_swap`, and the sixteen declarations this job adds — each on exactly
  `[propext, Classical.choice, Quot.sound]` (the receipt read record by record, not its verdict line); the planted control alone
  prints `sorryAx`; `--fault` exits 1 naming it (`axioms-3-fault.verdict`).
- **Statement check** on elaborated signatures against `6e0cf10d` (`stmt-3-vs-6e0cf10d.log`; expectation registered before the
  run: 0 changed, 16 added): "235 base declarations compared in 10 modules; 0 changed or missing; 16 added since the base", exit 0.
  The sixteen are this job's and no other. `germPair_dicho`, moved in the file, has the base's type hash. `tools/` is unchanged
  since Stage 2's self-test (`git diff --name-only 1e605b60 -- tools/`: empty), so the four planted faults of § 2.3 speak for
  the instrument that ran here.
- **Doubled names**: `./scripts/dupnames.sh` on the built tree — "OK — no name is declared by two modules (23 generated on
  demand)", exit 0 (`dupnames-3.log`). The sixteen names grepped by declaration keyword on `origin/main`, `origin/fs131-w6`, `-w7`,
  `-w9` and the sibling's `origin/fs131-w8d` (at `1e6b71d9`): 0 on each; the same pattern on this module counts 16 (its positive
  control). None of the sibling's fourteen names (its list, relayed by the coordinator) is declared here.
- **The guarded lint**, after this build and with no Lean file changed since: `scripts/slot.py --mem 8 --cpus 2 -- lake lint
  --no-build -- --no-build --trace`, `data/fs131/i8c/logs/lint.log`: exit 0, "-- Linting passed for Proofs.", fourteen
  `(2/2) Passed!` lines, no line with "failed". `unusedArguments` passes over `isRingArc_of_edge` because of `have _ := hne`
  (§ 3.3): that silence is this job's doing, and the finding is in the record. No control was planted for the lint (it needs a
  build of its own; the wave's gate has it).
- `tools/check_architecture.py`: `RESULT: PASS` (`check-architecture-3.log`); `SemiHub` now imports `Plane/RingCalculus/StarChart`
  and `Plane/ValidMap/Pushforward` (landed; `StarChart`'s row in `ARCHITECTURE.md` still says "imported by no module yet" — its
  row is the join job's and the sibling may edit it, so it is left for the landing).
- Only `SemiHub.lean` changed under `Proofs/`. No statement or definition changed; no `axiom`, no `native_decide`; no module of
  this job's own (the helpers fit the module). Not run, by the brief: the gate (`axioms.sh`, `vacuity.sh`), a merge.

**Lines**: the seventeen leaves' proofs are 357 lines, the sixteen added declarations' 248 — 605 against the planner's 1,700
(0.36, inside the milestone's band of a third to two thirds). The module grew from 522 to 1,282 lines, docstrings included.

### 3.6 Slips, the job's

- **Two helpers written and then removed, each a weaker copy of a landed wave-4 theorem**: `disjoint_angleIcc_antipodal`
  (`IsRingArc.disjoint_coneAt`, `Plane/ValidMap/Cor3` — the sibling implementer's remark, relayed) and `branch_on_unit_circle`
  (`germ_eq_of_two_on_circle`, `Plane/ValidMap/BaseSteps`, found by the audit the remark prompted). I had grepped the other
  branches for the names and not this tree for the statements' shapes (`LEAN.md` § Searching — Lean asks for the second). Both had
  been named to the coordinator in a mid-job message; a second message withdrew them. The other sixteen were then searched by
  shape: no landed form found (a failed search is not an absence; `IsRingArc.mono` is the sub-interval lemma, not the germ one).
- **A generalization announced too widely, then narrowed** (§ 3.2): my first message said "FS116-V5-DICHO holds for any two (Q)
  arcs"; only its dichotomy clause does. Found on reading the rows' own entries, corrected in the module, in `ARCHITECTURE.md` and
  by the second message.
- **The rows' entries were read at Stage 3, not at Stage 1** as the brief's item 1 asks; until then I had them only through the
  planner's quotations.
- **The build was launched and stopped three times before the run that is cited** (a docstring pass, then each of the two helper
  removals, then the prose of § 3.2): each stop by the task's own id, verified by effect — my processes gone, no process left with
  its working directory in this worktree, the slot ledger released, the compiled `SemiHub` still build 2's; the sibling's build,
  which held the other slot, was never signalled. No stopped run compiled `SemiHub`; what was forfeited is about five minutes of
  build walk. The log file was overwritten by the cited run.
- § 2.1's "lines" column and § 3.1's "proof lines" are two measures (§ 3.1's first lines).
- `IsStar4`'s helpers and the star leaves ship with no Lean inhabitant (§ 3.4): the docstrings say so; the debt is not paid.
- I cannot read the harness's token count; the hand-back is at this saved stage on my own estimate, with all seventeen leaves
  closed.
