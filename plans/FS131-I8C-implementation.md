# FS131-I8C — wave 8, the semi-hub rows' first module (`Plane/RingCalculus/SemiHub`)

*Job FS131-I8C (de Bruijn, the implementer), 2026-10-06, branch `fs131-w8c` (cut from `fs131-w8b` at `6e0cf10d`). Brief:
`data/fs131/briefs/FS131-I8C-wave8-semihub.md` (on `main`). The plans: `plans/FS131-w8-kernel-plan.md` Stages 6–10 (the planner's
record, FS131-K8b) and `plans/FS131-I8B-implementation.md` (the join job's record: the shared lemmas and its section for the two
implementers). Working files: `data/fs131/i8c/`. Tools: `tools/fs131_i8c_*.py`.*

## Theorems this phase proved

*(filled at each saved stage; the list at the last stage is the record)*

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
