# FS131-I8D — wave 8, the semi-hub rows' second module and the outer-adjacency row

*Job FS131-I8D (de Bruijn, the implementer), 2026-10-06, branch `fs131-w8d` (cut from `fs131-w8b` at `6e0cf10d`). Brief:
`data/fs131/briefs/FS131-I8D-wave8-semihub.md` (on `main`). The plans: `plans/FS131-w8-kernel-plan.md` (the planner's record, Stages
6–10) and `plans/FS131-I8B-implementation.md` (the join job's record, its section "For the two implementers who start from here").
Working files: `data/fs131/i8d/`. Tools: `tools/fs131_i8d_*.py`.*

## Theorems this phase proved

All [kernel] on branch `fs131-w8d` (built through `./scripts/build.sh`, log `data/fs131/i8d/logs/build-4-outeradj.log`; **not gated,
not on `main`**). Axioms from the built modules (`data/fs131/i8d/logs/axioms-4.verdict`): `outerAdj` and its module on the standard
three; every theorem of `SemiHubPlaces` on the standard three **and, until the wave's join, on the open leaves of
`Plane/RingCalculus/SemiHub` it cites** (job FS131-I8C's, proved in a tree of its own: `sorryAx` here, by that route only — the tool
names the leaves per record). So the first three lines below are kernel theorems *given `SemiHub`'s statements*, and become
unconditional when that module holds no `sorry`.

- **FS129-SR3-OUTERADJ** (carrying FS116-V6-ADJ) — `HadwigerNelson.Plane.ArcMap.outerAdj` (`Plane/RingCalculus/Empty`), from
  `not_sole_outer_of_adjacent_changePoints` (`Plane/RingCalculus/OuterAdj`). Axioms: exactly `[propext, Classical.choice,
  Quot.sound]`; no assumption. Read against the row ("in a non-Siamese valid six-coloured fragment on a closed disc of radius above 1
  about a vertex p of at least four colours, let y = r(ψ) and y′ = r(ψ + 60°) be change points of the ring such that neither the arc of
  ω(p) just counter-clockwise of r(ψ − 60°) nor the arc just clockwise of r(ψ + 120°) lies on a (Q) arc; then no colour of p is at once
  the only colour carried at y by a tile that is not a tile of p and the only colour carried at y′ by a tile that is not a tile of p"):
  `F : ArcMap 6`, `F.Valid`, `F.NonSiamese`, `F.Covers p 1`, `4 ≤ (F.coloursAt p).ncard`, `F.IsChangePoint p ψ X X'`,
  `F.IsChangePoint p (ψ + π / 3) Y Y'`, `¬ F.GermOnQ p (ψ - π / 3) .ccw`, `¬ F.GermOnQ p (ψ + 2 * π / 3) .cw`, any colour `c` ⊢ not
  both `F.outerTileColours p (ringPt p ψ) = {c}` and `F.outerTileColours p (ringPt p (ψ + π / 3)) = {c}`. "The only colour carried by
  a tile that is not a tile of p" is `O_y = {c}`, the planner's reading (the ring's own two colours are not colours of `p`).
- **FS116-N3-CROSS** — `crossed_no_tip` (with `crossed_tip_zeroAngle`), `crossed_outer`, `crossed_four`, `crossed_changePoint`,
  `crossed_semiHub` (`Plane/RingCalculus/SemiHubPlaces`). Axioms: the standard three and `SemiHub`'s `GermOnQWith.exists_isRingArc_ccw`,
  `…_cw`, `fullSemiHub_star_crossed`, `qcol_inner_tile`. Read against the row, clause by clause: "every tile of p at y has a cone at y of
  zero angle" — `crossed_no_tip`: no tile of `p` has `y` in its closure (stronger; the filed wording is the corollary); "the outer
  colours at y lie in {a′, b′}" — `crossed_outer`: `F.outerTileColours p (ringPt p ψ) ⊆ {a', b'}`; "if y has four colours and every tile
  at y a cone of positive angle at y, its outer colours are a′ and b′ and its missing pair is {a, b}" — `crossed_four`: `O_y = {a', b'}`
  and `(F.coloursAt (ringPt p ψ))ᶜ = {a, b}` (positive angle idle); "unless an edge of p runs along ω(y) at p, p is a change point of
  the ring of y, that ring being b just counter-clockwise of p and a just clockwise" — `crossed_changePoint`:
  `¬ F.OnRingArc (ringPt p ψ) p → F.IsChangePoint (ringPt p ψ) (ψ + π) b a`, on `F.Covers p 2`; "and p is a semi-hub of kind O of the
  ring of y" — `crossed_semiHub`: `F.IsSemiHub (ringPt p ψ) (ψ + π) .O`. The row's "at least four colours" at `p` is **exactly four**
  in the last three (`(F.coloursAt p).ncard = 4`, the ruling of § 2.2), as it already was in the first two.
- **FS116-N3-SEMI** — `semiHub_places` (`Plane/RingCalculus/SemiHubPlaces`), from `semiHub_places_O`, `semiHub_places_T`; and
  **FS116-RING-TRANSFER-QC**, its first clause — `transferQC` (the planner's proof over it). Axioms: the standard three and `SemiHub`'s
  two sub-arc lemmas, the four `ringTile_*`, `isRingArc_of_edge`, `four_le_of_bothKind`, `germPair_dicho`,
  `fullSemiHub_star_parallel`, `fullSemiHub_star_parallel_T`. Read against the row ("… let y = r(ψ) be a semi-hub of the ring of p; then
  y is a vertex of at least four colours, or y is a vertex of exactly three colours one of whose edges at y is an arc of the unit circle
  about r(ψ + 60°) or about r(ψ − 60°) whose two side colours are both carried at that centre, which is then a vertex of at least four
  colours, or y is a full parallel semi-hub of exactly three colours — the two absent at p and the colour of the tile of p whose cone
  holds ψ + 180° (kind O) or ψ (kind T) in its interior"): `F.Valid`, `F.NonSiamese`, `F.Covers p 1`, *simple* at the four points `p`,
  `r(ψ)`, `r(ψ ± π/3)`, `(F.coloursAt p).ncard = 4` (the ruling), `k ≤ ncard + 2`, `F.IsSemiHub p ψ kind` ⊢ the three alternatives:
  `4 ≤` colours at `y`; or three and `y` on an arc of `Γ` on `ω(w)` with constant sides both carried at `w` (`F.BothKind w θ₁ θ₂`,
  `ringPt p ψ ∈ ringArc w θ₁ θ₂`), `w = r(ψ ± π/3)`, `4 ≤` colours at `w`; or three, `F.IsFullSemiHub p ψ kind`, the swapped pair as
  two `GermOnQWith`, and a tile `T` of `p` of colour `c` with `C(y) = A(p) ∪ {c}` and cone `⊇ [ψ + 150°, ψ + 210°]` (kind O) or
  `⊇ [ψ − 30°, ψ + 30°]` (kind T) — the planner's stronger form of "in its interior". "One of whose edges at y is an arc" is read as "`y`
  lies on such an arc" (the planner's statement; the proof's arc is an edge at `y` between two tiles of `y`).
- **Helpers, each on the standard three** (class-free or read one object; no row of their own): `GermIn.tangent_mem_coneAt`,
  `e_add_sub_e_sub`, `IsRingArc.inner_ne_outer`, `eq_of_ncard_eq_four`, `eq_triple_of_ncard_le_three`,
  `disjoint_ball_of_far_witness`, `mem_closure_of_coneAt_toward`, `ringPt_ringPt_four_thirds` (`SemiHubPlaces`);
  `Valid.dist_le_one_of_near_germ_closure`, `exists_ball_subset_closure_of_sole_outer`, `not_germOnQ_of_germIn_region`,
  `norm_e_add_e_sub_e_sq`, `one_lt_norm_e_add_e_sub_e`, `not_sole_outer_of_adjacent_changePoints` (`OuterAdj`).

## Stage 1 — SAVED (FS131-I8D): the readback, the branch built as given

### 1.1 What I may and may not change

- **May**: the proofs of the six open leaves of `Plane/RingCalculus/SemiHubPlaces` and of `outerAdj` in `Plane/RingCalculus/Empty`;
  helper declarations under names no other module declares; a new module of my own beside them, with its `Proofs.lean` and
  `ARCHITECTURE.md` lines; docstrings; a block "FS131-I8D" in `scripts/Axioms.lean` above the PURCHASED banner; this record;
  `tools/fs131_i8d_*.py`; `data/fs131/i8d/`; `data/fs131/reports/FS131-I8D.md`.
- **May not**: any statement or definition; the shared module `Plane/RingCalculus/StarChart` (a change to it is a message to the
  coordinator); `Plane/RingCalculus/SemiHub` (FS131-I8C's); the wave's other modules; any landed module; `main`; an `axiom`;
  `native_decide`; a merge of another branch; the gate.

### 1.2 The brief's quotations against their sources (standing rule 3)

`tools/fs131_i8d_quotes.py` (the form of the join job's `tools/fs131_i8b_quotes.py`, which is another job's and is not edited) reads
every `> …` block of the brief with its `> — source:` line and looks for the text, whitespace collapsed, in the source:
**27 quotations, 27 found verbatim, 0 missing** (`data/fs131/i8d/logs/quotes.log`, exit 0). Planted fault (`--fault`, one letter of the
first quotation changed): exit 1, one `MISS`, the other 26 `ok` (`data/fs131/i8d/logs/quotes-fault.log`).

One note on the sources, not a defect of wording: the fourteen quotations of statements are first lines of longer signatures, and the
seven of the plan are headings; each was read whole (§ 1.3, § 1.4).

### 1.3 What was read

- The brief; `plans/STANDING-RULES.md`; `LEAN.md` in full; `RUNNING.md` § Building and § Make the gate fail, and watch it fail.
- The planner's record, Stages 6–10 whole (§ 7.4 on `outerAdj`; § 8.3 the statements against their rows; § 8.4 the attacks; § 9.1 the
  three carrying lemmas; § 9.3 the six routes and the case table of `semiHub_places`; § 9.4 the plan for `outerAdj`; §§ 9.5–9.8).
- The join job's record: Stages 2–5 and "For the two implementers who start from here" whole (its seven notes on what will not go as
  the plan writes it).
- The wave's modules in this tree, in full: `Plane/RingCalculus/Basic`, `Star`, `SemiHub`, `SemiHubPlaces`, `SoleTip` (the template for
  `outerAdj`); of `Empty` the header and the section of `outerAdj`; of `Plane/LocalMap` the vocabulary (ll. 60–300: cones, germs,
  ring arcs, (Q), change points, hubs).
- The rows' entries (`data/fs131/k8/rows-extract.md`: FS116-N3-SEMI, FS116-N3-CROSS, FS116-RING-TRANSFER-QC, FS129-SR3-OUTERADJ) and
  their arguments: `plans/FS116-N3-proof.md` §§ 2.1–2.4, 3.1, 3.2; `plans/FS116-V5-verification.md` §§ 3.2–3.4;
  `plans/FS129-SR3-audit.md` Stage 3 whole (§ 3.1).

### 1.4 The leaves as the kernel has them

`#check @…` on the seven leaves and on eight shared lemmas, from the built modules (`data/fs131/i8d/logs/leaf-signatures.log`):
**every hypothesis of every leaf is a binder of its kernel statement** — the two modules declare only `{k}` and `{F}` as section
variables, and each leaf's printed type carries `F.Valid`, `F.NonSiamese` and every named hypothesis of its source text, in order.
No leaf lacks a hypothesis its row reads (inventory item 556's check); nothing to message.

### 1.5 The branch as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, log `data/fs131/i8d/logs/build-1-as-given.log`:
"build: OK — all 1812 modules already up to date, nothing built, 3 module(s) with warnings", `EXIT=0`. `rg -c "^\s*sorry"` on
`Proofs/HadwigerNelson/Plane/RingCalculus/`: `SemiHub` 17, `SemiHubPlaces` 6, `Empty` 1 — 24 leaves, seven of them this job's.

## Stage 2 — SAVED (FS131-I8D): the statement defect and its ruling; `crossed_no_tip`, `crossed_outer`, `crossed_four`

### 2.1 The first two leaves, and the re-pricing the brief asks for

`crossed_no_tip` and `crossed_outer` closed at first elaboration, over one composition minted once (`crossed_star_data`: the two
sub-arc lemmas and `fullSemiHub_star_crossed`): 30 and 22 lines against 120 and 80 priced. **Re-priced from them**: a leaf whose
route exists costs a quarter to a third of its price here; the whole of `SemiHubPlaces` is one job, and `outerAdj` rides with it if
the budget holds. Two routes are shorter than the plan's: a tip's exclusion from `t_a'`, `t_b'` needs no C1 (both cones hold the
star's edge `e₃`, more than `90°` from `ψ`: `cos_nonneg_of_mem_coneAt`), and `crossed_outer` needs no "four distinct colours" child
(the tile of an outer colour is one of the star's four).

### 2.2 The statement defect (sent to the coordinator; ruled)

**Found** at the third leaf: `crossed_four`, `crossed_changePoint`, `crossed_semiHub`, `semiHub_places` and the planner's `transferQC`
read "`p` has exactly four colours" and were stated with `(h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2)`.
Wave 3's `germS_absent` gives `(F.coloursAt p).ncard + 2 = k` — two colours absent, so four present only at `k = 6` — and every route
goes through a statement of `SemiHub` that asks `ncard = 4`. The sharp case, in Lean (`data/fs131/i8d/scratch/k6_remark.lean`,
elaborated clean, `data/fs131/i8d/logs/k6-remark.log` empty): under `crossed_four`'s hypotheses its conclusion
`(F.coloursAt (ringPt p ψ))ᶜ = {a, b}` implies `k = 6`; at `k ≥ 7` the leaf as written claimed that no such configuration exists,
which no row does (FS116-N3-CROSS's *not claimed*: "anything at k ≥ 7"). No counterexample map is held: unprovable as stated, not
shown false. The planner's sentence the slip comes from: `fullSemiHub_star_crossed`'s docstring, "four colours by `germS_absent`".

**Ruled** (the coordinator's message, 2026-10-06; its inventory number is the coordinator's to give): form (i) — the five statements
take `(h4 : (F.coloursAt p).ncard = 4)` in place of `(h4 : 4 ≤ (F.coloursAt p).ncard)`, `hk` kept; a docstring clause on each naming
the class and why. Done exactly so:

- `tools/fs131_i8d_stmt.py` (the form of the wave's statement check, over the ten modules of the ring calculus; elaborated
  signatures, never text) against `6e0cf10d` with `--expect` the five names: 235 base declarations compared, **5 changed — exactly the
  five**, 2 added (`crossed_star_data`, `crossed_coloursAt`), exit 0 (`data/fs131/i8d/logs/stmt-2-vs-6e0cf10d.log`).
- `tools/fs131_i8d_binders.py` on that log: each of the five is its base statement with `4 ≤ (F.coloursAt p).ncard` replaced by
  `(F.coloursAt p).ncard = 4` and nothing else (`binders-2.log`, exit 0); planted fault (`= 5` expected): five `MISMATCH`, exit 1
  (`binders-2-fault.log`).
- The statement check's self-test (`stmt-selftest.log`, exit 0): each of the three planted faults (a hypothesis altered in `Empty`, an
  `include` adding `0 = 1 →` with the text unchanged, a binder added to `star_recip`) adds exactly its culprit to the changed set. The
  join job's self-test judged a control by exit 1 alone, which the already-changed `star_anti` gave it; this one compares sets.

### 2.3 `crossed_four`, at the ruled statement

`y` has no tip (`crossed_no_tip`), so by `star_coloursAt` its colours are the two absent at `p` and its outer colours, which lie in
`{a', b'}` (`crossed_outer`): four colours need both. The absent pair is `P ∖ {a', b'}` with `P = {a, a', b, b'}` and `a ≠ a'`,
`b ≠ b'` (`crossed_coloursAt`: the star's first and third, second and fourth tiles are distinct tiles of `p`, one per colour).
About 40 lines against 80.

### 2.4 The save

- Build: `data/fs131/i8d/logs/build-2-crossed-three.log` — "build: OK — 468 of 468 batches, 2 module(s) rebuilt, 3 module(s) with
  warnings", `EXIT=0`; the full log's `declaration uses sorry` lines are in `SemiHub` (17 leaves), `SemiHubPlaces` (3:
  `semiHub_places`, `crossed_changePoint`, `crossed_semiHub`) and `Empty` (1).
- **Axioms, with the debt beneath each record named** (`tools/fs131_i8d_axioms.py`, `axioms-2.txt`, `axioms-2.verdict`): my leaves
  cite statements the sibling implementer proves in a tree of its own, so `#print axioms` shows `sorryAx` and cannot say whose. The
  tool prints, per record, its axioms and its *sorry roots* (the declarations beneath it whose own term mentions `sorryAx`, with their
  module), and passes a record only if every root is in `Plane/RingCalculus/SemiHub`. Six records, each on the standard three and
  resting besides on open leaves of `SemiHub` only — four distinct: `GermOnQWith.exists_isRingArc_ccw`, `…_cw`,
  `fullSemiHub_star_crossed`, `qcol_inner_tile` (the first, second and fourth are proved on `origin/fs131-w8c` at `1e605b60`). The
  planted control (a theorem proved by `sorry` in the scratch file) prints `sorryAx` with itself as its one root; `--fault` (the
  control audited) exits 1 naming it (`axioms-2-fault.verdict`).
- `./scripts/dupnames.sh`: OK, exit 0 (`dupnames-2.log`). My helper names scanned by declaration keyword on `origin/fs131-w8c`,
  `-w6`, `-w7`, `-w9`, `main`: no hit; the scan fires on a known name of the sibling's. The sibling's names (the coordinator's relay)
  are declared nowhere here.

## Stage 3 — SAVED (FS131-I8D): `crossed_changePoint`, `crossed_semiHub`, `semiHub_places` — the six leaves of `SemiHubPlaces` closed

Every leaf closed at first or second elaboration (the proofs were drafted in a copy of the module under `data/fs131/i8d/scratch/`
while a build held the module, then installed). The module went from 155 lines to 1,010: about 855 written against 1,430 priced.

### 3.1 `crossed_changePoint` (about 60 lines against 200)

Each germ of `ω(y)` at `p` lies in a colour class (`germ_dichotomy`; an arc would be `F.OnRingArc y p`, excluded by `hna`), whose
colour is absent at `y` (`not_mem_coloursAt_of_mem_sphere`), so `a` or `b` (`crossed_four`); its tile is the tile of `p` of that
colour, and approaches `p` along the germ's tangent — **a lemma the plan lists as a child and the library did not hold**:
`GermIn.tangent_mem_coneAt` (`θ + s.sign * (π / 2) ∈ coneAt S (ringPt p θ)`, class-free, over a chord identity
`e_add_sub_e_sub`). The crossed star puts `ψ + 270°` outside the cone of `t_a` and `ψ + 90°` outside the cone of `t_b`
(`add_notMem_angleIcc`, `sub_notMem_angleIcc`, wave 3; no C1). `p ∈ Γ`: four colours, so no interior point.

### 3.2 `crossed_semiHub` — the row's weakest clause closes in the kernel (about 150 lines against 300)

The step the blind second mind left open (`plans/FS116-V5-verification.md` ll. 650–660) is `crossed_not_germOnQ_inside`: no germ of
`ω(y)` running inside `B(p, 1)` from `r(ω)`, `ω` within `60°` of `ψ`, lies on a (Q) arc of the ring of `y`. The route is the plan's,
with two landed lemmas in place of two it priced as children: wave 4's `IsRingArc.disjoint_coneAt` (`Plane/ValidMap/Cor3`: the cones at
the centre of an arc's two side classes are disjoint) for `disjoint_angleIcc_antipodal`, and wave 3's `exists_mem_coneAt_region` (every
direction at a point of the domain is in the cone of some class) for `iUnion_coneAt_tileAt`. The side colours are not `a'`, `b'` (the
tile of `p` of that colour would hold `r(ω)`, by `mem_closure_tile_of_near` along the germ, and it approaches `p` along the star's
`e₃`, more than `90°` from `ω`); so they are the ring's `X`, `X'`, with disjoint cones at `y`; the closed half-circle
`[ψ + 90°, ψ + 270°]` at `y` is covered by the two closed cones (a tile of `y` of colour `a'` or `b'` reaching into `B(p, 1)` would be a
tip), `ψ + 90°` is in the one and `ψ + 270°` in the other (the ring's own germs at `y`, by the tangent lemma): `isPreconnected_Icc`.
The tip pair is not free: `ringGerm_inward` at `y` would give a tile of `y` holding `p`, a tip (`isTip_comm`), and there is none.

**Two hypotheses are idle, and stay as filed** (a generalization, reported): the freedom of the outer pair of `y` (`ho`: referenced by
`have _ := ho`, as `doubleTip` does for its three) and *simple* at `y` (`hS` is read at `{p}` only). The clause holds at a closed
change point of `p`'s ring too.

### 3.3 `semiHub_places` (about 430 lines with its seven children against 650)

The plan's case table, with three of its cells merged by two lemmas that need no case on *which* side colour:

- `disjoint_ball_of_far_witness` — a tile `C ∋ y` of colour `o` misses `B(w, 1)` when `w` carries `o` and some closure point of the
  class of `o` is nearer than `1` to `w` and more than `1` from `y` (the tile of `o` at `w` would hold it). One proof for "`o` the inner
  colour" and "`o` the outer colour" of the arc at `u` (the plan's two sub-cases: "that one is `p`'s tile, or holds outer points of the
  arc more than `1` from `y`").
- `mem_closure_of_coneAt_toward` — a tile approaching `y` along a direction within `90°` of `γ` holds `y + e(γ)` when that point
  carries its colour. One proof for the tip `τ` whether its colour is the inner or the outer colour of the arc at `u` (kind T).
- `semiHub_edge` — FS116-N3-CONE (c) composed once: `exists_initialPiece_of_ncard_le_three` (K2 at three colours),
  `isRingArc_of_edge`, `four_le_of_bothKind`.
- In the "otherwise" cells the pairs are not disjoint because four distinct colours of a four-colour vertex are all of them
  (`eq_of_ncard_eq_four`, with `IsRingArc.inner_ne_outer`: the two side colours of an arc differ when the inner one is carried at the
  centre — from `IsRingArc.disjoint_coneAt`, no star); then `germPair_dicho` gives the swap, and the star (`fullSemiHub_star_parallel`,
  `…_parallel_T`) places the third colour's tile: `t_front` is barred to an outer colour by `star_outer_cone` (it holds `ψ`), `t_back`
  to a tip (it holds `ψ + 180°`).
- Kind T's tip is taken as *the* tile `ringGerm_inward` gives along `ψ + 180°`, so "a single tip" needs no argument.

**The shared lemmas served as stated**: C1 and C2 were not needed in this module (every window was closed by a direction the cone
holds and a cosine, or by `add_notMem_angleIcc` / `sub_notMem_angleIcc`); G1 is used three times; K2 at three colours once, in
exactly the shape the join job handed (`hα`, `hB`, `hBT` of `isRingArc_of_edge`); K1 not at all (no sector is named). No corollary of a
shared lemma was needed, and no message about them.

### 3.4 The save

- Build: `data/fs131/i8d/logs/build-3-semihubplaces.log` — "build: OK — 468 of 468 batches, 2 module(s) rebuilt, 2 module(s) with
  warnings", `EXIT=0`. The full log's warnings are `declaration uses sorry` lines only, in `SemiHub` (17 leaves) and `Empty` (1):
  **`SemiHubPlaces` has no warning** — no `sorry`, and the build's linters are silent on it.
- Axioms (`axioms-3.txt`, `axioms-3.verdict`): 22 records — 8 on a subset of the standard three (`e_add_sub_e_sub`,
  `GermIn.tangent_mem_coneAt`, `ringPt_ringPt_four_thirds`, `IsRingArc.inner_ne_outer`, `eq_of_ncard_eq_four`,
  `eq_triple_of_ncard_le_three`, `disjoint_ball_of_far_witness`, `mem_closure_of_coneAt_toward`), 14 resting besides on open leaves
  of `SemiHub` only, 13 distinct. Per leaf: the five `crossed_*` on `GermOnQWith.exists_isRingArc_ccw`, `…_cw`,
  `fullSemiHub_star_crossed`, `qcol_inner_tile` (`crossed_outer` not the last); `semiHub_places` (and `transferQC`) on the two sub-arc
  lemmas, the four `ringTile_*`, `isRingArc_of_edge`, `four_le_of_bothKind`, `germPair_dicho`, `fullSemiHub_star_parallel`,
  `fullSemiHub_star_parallel_T`. The control prints `sorryAx` rooted at itself; `--fault` exits 1 (`axioms-3-fault.verdict`).
- The statement check against `6e0cf10d` (`stmt-3-vs-6e0cf10d.log`): 235 compared, exactly the five ruled declarations changed, each by
  exactly the ruled binder (`binders-3.log`); 14 added, all mine.
- `./scripts/dupnames.sh`: OK, exit 0 (`dupnames-3.log`); `tools/check_architecture.py`: `RESULT: PASS`
  (`check-architecture-3.log`; the module now imports `StarChart` and `SoleTip` beside `SemiHub`). My names scanned by declaration
  keyword on `origin/fs131-w8c`, `-w6`, `-w7`, `-w9`, `main`: no hit (`name-scan.log`; its two hits are on my own `HEAD`).

## Stage 4 — SAVED (FS131-I8D): `outerAdj`, the guarded lint, the drafts

### 4.1 `outerAdj` — a new module, and one cell of the plan corrected (about 290 lines against 380)

`Plane/RingCalculus/OuterAdj` (imports `SoleTip`, and `SemiHub` for the proved `qcol_ccw`, `qcol_cw`; imported by `Empty`, so `Empty`
now has `SemiHub` beneath it — an edge of the import graph that was not there), on the template of the sole-tip lemma with the arcs run
outward. `outerAdj` in `Empty` is one line over `not_sole_outer_of_adjacent_changePoints`, which reads `k ≤ ncard + 2` and never six.

**The plan's § 9.4 A1 does not hold as written, and the proof needed its repair.** A1: "near `y`, every interior point outside
`B̄(p, 1)` and outside `B̄(y′, 1)` has colour `c` … not `X′` (near `y` the class of `X′` stays in `B̄(v, 1)` … and the points in question
are outside `B̄(v, 1)`)". To first order a point `y + s·e(θ)` is outside `B̄(p, 1)` for `θ ∈ (−90°, 90°)`, outside `B̄(y′, 1)` for
`θ ∈ (−150°, 30°)` and outside `B̄(v, 1)` only for `θ ∈ (−30°, 150°)`: between `−90°` and `−30°` it is outside the first two discs and
inside `B(v, 1)`, where the tile of `X′` may be. The lemma here (`exists_ball_subset_closure_of_sole_outer`) removes the third disc
too, and the arc of `ω(y′)` leaving `y` away from `p` is then shown outside `B̄(v, 1)` — an inequality the plan did not list, on no
common unit circle with a landed lemma: `|e(a) + e(b) − e(c)|² = 3 + 2cos(a − b) − 2cos(a − c) − 2cos(b − c)`
(`norm_e_add_e_sub_e_sq`), and at mutual angles `120° − t`, `120°`, `t` that is `4 − 3cos t + 2 sin 120° sin t > 1`
(`one_lt_norm_e_add_e_sub_e`); the same lemma serves the mirror at `y′` (the disc about `r(ψ + 120°)`). The row's own argument
(`plans/FS129-SR3-audit.md` § 3.1) is at tile level and does not make the claim; the defect is the plan's region-level restatement.

The rest is the plan's: A0 (`ringGerm_outward` at `y` puts `ψ` in the cone of the outer tile, which so leaves `B̄(y′, 1)`; its free
outer pair is `hv` and the germ just clockwise of `y′`, which lies in a class — `not_germOnQ_of_germIn_region`), A2
(`mem_closure_diff_closedBall`), A3 (`twoCirc_cmp_one` with `σ = −1`). The identification of the tiles needs no radius from A1: the
tile of colour `c` holding the arc point is the outer tile at `y` because the point is nearer than `1` to `y`
(`NonSiamese.tile_eq_of_dist_lt`, three times). `Valid.dist_le_one_of_near_germ_closure` is the closure form the plan asked for.

### 4.2 The save

- Build: `data/fs131/i8d/logs/build-4-outeradj.log` — "build: OK — 468 of 468 batches, 3 module(s) rebuilt, 1 module(s) with
  warnings", `EXIT=0`; rebuilt `OuterAdj`, `Empty`, `Proofs`. Read in the full log (`build/gate/build/20261006T234047Z-4155575.log`,
  1,034 lines), not in that line: its one `error` line (l. 21, "target is out-of-date and needs to be rebuilt", for `OuterAdj`) is
  the script's `lake build --no-build` pre-check, before batch 1 — the stale signal that starts the walk, not a failure of it; its 85
  warning lines are one class, `declaration uses sorry`, at 17 distinct positions of `SemiHub` (replayed for its dependents). **No
  warning in `OuterAdj`, `Empty` or `SemiHubPlaces`.** `rg -c "^\s*sorry"` on the ring calculus: `SemiHub` 17 and nothing else — the
  seven leaves of this job are closed.
- Axioms (`axioms-4.txt`, `axioms-4.verdict`): 29 records — 15 on a subset of the standard three (`outerAdj` and the six of
  `OuterAdj` among them: exactly `propext`, `Classical.choice`, `Quot.sound`), 14 resting besides on open leaves of `SemiHub` only (13
  distinct), 0 bad; the control prints `sorryAx` rooted at itself; `--fault` exits 1 (`axioms-4-fault.verdict`).
- The statement check against `6e0cf10d` (`stmt-4-vs-6e0cf10d.log`): 235 compared in ten modules, exactly the five ruled declarations
  changed, by exactly the ruled binder (`binders-4.log`); `outerAdj`'s statement unchanged. The tool's list of modules does not hold
  the new `OuterAdj` (every declaration of it is an addition).
- `./scripts/dupnames.sh`: OK, exit 0 (`dupnames-4.log`). `tools/check_architecture.py`: `RESULT: PASS`
  (`check-architecture-4.log`: a row for `OuterAdj`, `Empty`'s row and imports brought up to date).
- **The guarded lint**, after the last green build (no Lean file changed since): `scripts/slot.py --mem 8 --cpus 2 -- lake lint
  --no-build -- --no-build --trace`, `data/fs131/i8d/logs/lint.log`: exit 0, "-- Linting passed for Proofs.", fourteen `Passed!`
  lines, no line with "fail" or "error". No control planted for it by this job (it needs a build of its own; the wave's gate has it).

### 4.3 Slips, the job's

- § 3.4 first said "16 added" for the statement check's additions; the log says 14; corrected in place.
- A grep of the full build log was first run with a variable holding two lines (the script prints "full output" twice), so it also
  searched a file named `this`; the counts came from the real log and were re-read with the path written out (§ 4.2).
- No Lean model of a semi-hub, of a star, or of two adjacent change points: every docstring keeps the planner's line on what is
  owed (§ 9.6 of the plan). No vacuity run (the gate is the wave's).
- The proofs of Stage 3 and 4 were drafted in scratch copies (`data/fs131/i8d/scratch/SHP.lean`, `OuterAdj.lean`) elaborated by
  `lake env lean` while a build held the module; the evidence is the builds, not those runs.
- I cannot read the harness's token count; the hand-back is at this saved stage on my own estimate of the brief's line.

## For the join

- **What discharges at the join**: when `SemiHub` holds no `sorry`, the block "FS131-I8D" of `scripts/Axioms.lean` (29 records)
  reads CLEAN throughout; until then 14 of them print `sorryAx`, by `SemiHub`'s leaves only (`tools/fs131_i8d_axioms.py` is the
  check that says so; after the join it should report 29 on the standard three and no record resting).
- **Statements of `SemiHub` this module reads** (a change to any of them is a change here): `GermOnQWith.exists_isRingArc_ccw`,
  `…_cw`, `qcol_inner_tile`, `fullSemiHub_star_crossed`, `fullSemiHub_star_parallel`, `…_parallel_T`, `germPair_dicho`, the four
  `ringTile_*`, `isRingArc_of_edge`, `four_le_of_bothKind`, and the proved `qcol_cw`, `qcol_ccw`, `IsStar4`'s fields,
  `IsStar4.angleIcc_subset_cone₂`, `…_cone₄`, `GermOnQWith.germOnQ`.
- **A docstring of `SemiHub` to correct** (the sibling's file, not touched): `fullSemiHub_star_crossed`'s "four colours by
  `germS_absent`" — `germS_absent` gives `ncard + 2 = k`, four colours only at `k = 6`.
- **Names**: mine are listed in § "Theorems this phase proved" and in the block; none is declared on `origin/fs131-w8c` (at
  `1e605b60`), `-w6`, `-w7`, `-w9` or `main` by a declaration-keyword scan; `./scripts/dupnames.sh` on the joined tree is the check.

## Drafts for the front page

*For the coordinator to file; nothing here is filed by this job, which did not run the gate (the brief withholds it), so it drafts no
gate counts and no trust-ledger counts.*

1. **`CLAUDE.md` § The gate, § Trust ledger** — no draft. What the wave's landing will meet from this job: 29 records in the block
   "FS131-I8D" of `scripts/Axioms.lean`, CLEAN once `SemiHub` is whole; no purchase; no `VACUITY DECLARED` line added.
2. **`LEDGER.md` § B, FS129-SR3-OUTERADJ's line** (slot: its grade cell, "hand; one mind") — draft: "kernel on `fs131-w8d`, not
   gated: `HadwigerNelson.Plane.ArcMap.outerAdj` (`Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean`), from
   `not_sole_outer_of_adjacent_changePoints` (`…/OuterAdj.lean`), on the standard three axioms, no assumption imported; the argument
   reads at most two colours absent at `p`, never six."
3. **`LEDGER.md` § B, the lines of FS116-N3-CROSS, FS116-N3-SEMI, FS116-RING-TRANSFER-QC** (slot: each grade cell) — draft, to file
   at the wave's join and not before: "kernel: `crossed_no_tip`, `crossed_outer`, `crossed_four`, `crossed_changePoint`,
   `crossed_semiHub`; `semiHub_places`; `transferQC` (`Proofs/HadwigerNelson/Plane/RingCalculus/SemiHubPlaces.lean`), on the standard
   three axioms once `…/SemiHub` holds no `sorry`; at a vertex of exactly four colours (`(F.coloursAt p).ncard = 4`); CROSS's last
   clause, filed at one mind and a checking reading, is closed in the kernel and reads neither the freedom of `y`'s outer pair nor
   *simple* at `y`."
4. **`plans/FS116-derivation.md`, the entries of FS116-N3-CROSS and FS116-N3-SEMI — errata** (the deriver's file; drafts only):
   CROSS, its minds line — "the last clause: kernel-checked (FS131-I8D), the stall of V5's blind verdict closed by the disjoint cones
   of the two side classes at `y` and the connected half-circle of directions into `B(p, 1)`"; CROSS, its statement — "a crossed full
   semi-hub *of kind O*": the kind enters no clause but the name (generalization: the clauses hold at a closed change point).
5. **`plans/FS131-w8-kernel-plan.md` § 9.4, A1** (the planner's record; a draft) — "…outside `B̄(p, 1)`, outside `B̄(y′, 1)` **and
   outside `B̄(v, 1)`**…; the arc of `ω(y′)` from `y` away from `p` is outside `B̄(v, 1)` (`one_lt_norm_e_add_e_sub_e`)".
6. **`CLAUDE.md` § Frontier** — no change of state: FS-131 stays open; on wave 8's line `SemiHubPlaces`, `Empty` and `OuterAdj` hold
   no `sorry`, and `SemiHub`'s leaves are the wave's remaining debt.
7. **Proof Atlas grade changes** (on landing, not now): FS129-SR3-OUTERADJ → kernel; FS116-N3-CROSS, FS116-N3-SEMI,
   FS116-RING-TRANSFER-QC → kernel at the join.
