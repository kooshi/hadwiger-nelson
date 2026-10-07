# FS131-I8B — wave 8, the join and the shared part

*Job FS131-I8B (de Bruijn, the implementer), 2026-10-06, branch `fs131-w8b` (cut from `fs131-w8` at `8d979793`). Brief:
`data/fs131/briefs/FS131-I8B-wave8-join.md` (on `main`). The plans: `plans/FS131-w8-kernel-plan.md` (the planner's record, FS131-K8 and
FS131-K8b) and `plans/FS131-I8A-implementation.md` (the first implementer's record, by the merge of Stage 2). Working files:
`data/fs131/i8b/`. Tools: `tools/fs131_i8b_*.py`.*

## Theorems this phase proved

All [kernel] on branch `fs131-w8b` (built through `./scripts/build.sh`, log `data/fs131/i8b/logs/build-4-shared-and-anti.log`; not
gated, not on `main`); each on a subset of `[propext, Classical.choice, Quot.sound]` (`data/fs131/i8b/logs/axioms-5.txt`).

- **FS116-N2-ANTI** — `HadwigerNelson.Plane.ArcMap.star_anti` (`Plane/RingCalculus/Star`), from `star_anti_ne`, `star_anti_count`,
  `false_of_antipodal_gaps`, `mem_coneAt_add_int_mul_two_pi`, at the statement ruled in inventory item 568 (two hypotheses after `hm`).
  Read aloud against the row ("in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of four
  colours, let y = r(ψ) and y* = r(ψ + 180°) be hubs of p, and let ψ + 90° and ψ − 90° lie in the interiors of the cones at p of tiles
  t⁺ and t⁻; then t⁺ ≠ t⁻, A(y) = A(y*) = {c(t⁺), c(t⁻)}, T_y = O_(y*) and O_y = T_(y*), each a single colour, and y and y* have four
  colours and no more", `plans/FS116-derivation.md` ll. 715–717, with its *not claimed* line "anything when an edge of p leaves at
  ψ + 90° or ψ − 90°", l. 719): `F : ArcMap 6`, `F.Valid`, `F.NonSiamese`, `F.Covers p 1`, `F.SimpleOn {p}`,
  `(F.coloursAt p).ncard = 4`, `F.IsHub p ψ`, `F.IsHub p (ψ + π)`, tiles `tp`, `tm` of colours `cp`, `cm` with `p` in their closures,
  `ψ + π / 2 ∈ interior (coneAt tp p)`, `ψ - π / 2 ∈ interior (coneAt tm p)`, no tile of `p` other than `tp` approaches `p` along
  `ψ + π / 2`, none other than `tm` along `ψ - π / 2` ⊢ `tp ≠ tm`, the colours absent at `r(ψ)` are `{cp, cm}`, those absent at
  `r(ψ + π)` are `{cp, cm}`, one colour is `T_y` and `O_(y*)`, one colour is `O_y` and `T_(y*)`, and `r(ψ)`, `r(ψ + π)` carry four
  colours each. The row's "simple" is read at the tiles of `p` only (the planner's generalization, kept).
- **The shared lemmas** (`Plane/RingCalculus/StarChart`; helpers of the semi-hub rows, no row of their own; statements in § 3.2):
  `exists_int_of_angleIcc_subset` (C1), `int_eq_zero_of_two_pi_mul_lt`, `int_eq_zero_of_abs_two_pi_mul_lt` (C2),
  `ArcMap.mem_closure_tile_of_near` (G1), `ArcMap.ncard_tileAt_eq`, `ArcMap.IsSectorChart.tileAt_equiv`,
  `ArcMap.exists_sectorChart_tileAt` (K1), `ArcMap.IsSectorChart.exists_initialPiece_branch`,
  `ArcMap.IsSectorChart.exists_initialPiece_between`, `ArcMap.exists_initialPiece_of_ncard_le_three` (K2), and the children
  `Arc.InitialPiece.exists_param`, `ArcMap.IsSectorChart.exists_branch_of_isPreconnected`, `segment_eq_image_ray`,
  `branchPt_mem_Rgn`, `branchPt_curveGerm_add`, `not_both_mem_Rgn_curveGerm`. K1 read against the planner's sentence "under
  `SimpleOn {x}` the tiles of `x` are the chart's sectors, one each"; K2 against "two consecutive sectors share the branch between
  them — an initial piece of a map arc in both closures"; C1 against "a connected interval inside a disjoint union of translates lies
  in one".

## Stage 1 — SAVED (FS131-I8B): the readback, the branch built as given

### 1.1 What I may and may not change

- **May**: the merge's files; `Plane/RingCalculus/Star` — `star_anti`'s statement by the ruled change (two binders after `hm`), its
  docstring, its proof, helpers under new names; a new module for the shared lemmas with its `Proofs.lean` and `ARCHITECTURE.md` lines;
  a block "FS131-I8B" in `scripts/Axioms.lean` above the PURCHASED banner; this record; `tools/fs131_i8b_*.py`; `data/fs131/i8b/`;
  `data/fs131/reports/FS131-I8B.md`.
- **May not**: any other statement or definition; `SemiHub`, `SemiHubPlaces` (the next two implementers'); `outerAdj`; the wave's
  foundation (`…/Basic`); any landed module; `main`; a third hypothesis on `star_anti`, or either ruled binder dropped, without a
  message; an `axiom`; `native_decide`; the gate.

### 1.2 The brief's quotations against their sources (standing rule 3)

`tools/fs131_i8b_quotes.py` (the form of the planner's `tools/fs131_k8b_quotes.py`, which is another job's and is not edited) reads
every `> …` block of the brief with its `> — source:` line and looks for the text, whitespace collapsed, in the source:
**18 quotations, 18 found verbatim, 0 missing** (`data/fs131/i8b/logs/quotes.log`, exit 0). Planted fault (`--fault`, one letter of the
first quotation changed): exit 1, one `MISS` (`data/fs131/i8b/logs/quotes-fault.log`).

Two notes on the sources, neither a defect of wording:

- The row's *not claimed* line is at `plans/FS116-derivation.md` l. 719 (the entry begins at l. 714); the planner's § 7.3 cites
  l. 714 for it and the first implementer's § 5.5 cites l. 719.
- The four quotations from the first implementer's § 5.5 and the three from the planner's § 9.1 are first lines of longer bullets;
  the bullets were read whole (§ 1.3).

### 1.3 What was read

- The brief; `plans/STANDING-RULES.md`; `LEAN.md` in full; `RUNNING.md` § Building and § Make the gate fail, and watch it fail.
- The planner's record, Stages 6–10 whole (§ 7.3 on the gap; § 9.1 on the shared lemmas; §§ 9.2–9.3, every row naming C1, C2, G1, K1,
  K2; § 9.8 the handoff). The first implementer's record: its theorem list, Stage 1, Stage 5 whole (§ 5.2 the gap, § 5.5 the ruling
  and the route).
- The wave's modules in this tree, in full: `Plane/RingCalculus/Basic`, `Star`, `SemiHub`, `SemiHubPlaces`; `Plane/SimpleOn` in full;
  of `Plane/LocalStructure` the sector chart (`branchPt`, `sectorBetween`, `BranchGerms`, `IsSectorChart`, `isSectorChart_of`,
  `localSectors_disj`, `IsSectorChart.exists_tile_inter_ball`, `Simple.coneAt_eq_angleIcc_sep`), `coneAt`, `Arc.InitialPiece`,
  `exists_initialPiece_of_cone`'s statement; of wave 4, `IsSectorChart.branchPt_mem_closure_sector_after`, `…_before`,
  `IsSectorChart.exists_ball_subset_of_branchPt` (`Plane/ValidMap/Surgery`), `IsSectorChart.exists_ball_branch`,
  `IsSectorChart.exists_isRingArc_of_along` (`Plane/ValidMap/BaseSteps`): the lemmas the planner named for K2 "by name, not read".
- The row: `plans/FS116-derivation.md` ll. 714–722 (FS116-N2-ANTI's entry) and its argument, `plans/FS116-N2-proof.md` § 2.2
  (ll. 198–229: STAR, RECIP, ANTI).

### 1.4 The branch as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, log `data/fs131/i8b/logs/build-1-as-given.log`:
"build: OK — all 1811 modules already up to date, nothing built, 4 module(s) with warnings", `EXIT=0`. `rg -c "^\s*sorry"` on
`Proofs/HadwigerNelson/Plane/RingCalculus/`: `SemiHub` 17, `SemiHubPlaces` 6, `Star` 2, `Empty` 1 — the 26 the brief counts.

Trial of the merge (`git merge-tree --write-tree HEAD origin/fs131-w8a`, `origin/fs131-w8a` at `e1e0c74d`): exit 0, no conflict;
fifteen files, three of them Lean (`Star`, `RingColour`, `TilesAt`), one registry (`scripts/Axioms.lean`).

## Stage 2 — SAVED (FS131-I8B): the merge

`git merge --no-ff origin/fs131-w8a` (at `e1e0c74d`): no conflict; commit `9ddc32d2`, the index holding the merge and nothing else
(fifteen files: `Star` — `star_recip` proved, `exists_tileOf_of_germIn` — , `RingColour`, `TilesAt`, `scripts/Axioms.lean`, the first
implementer's record, report and logs). Build of the merged tree: `data/fs131/i8b/logs/build-2-merged.log` — "build: OK — 468 of 468
batches, 8 module(s) rebuilt, 4 module(s) with warnings", `EXIT=0`. `rg -c "^\s*sorry"`: `SemiHub` 17, `SemiHubPlaces` 6, `Star` 1,
`Empty` 1 — 25 leaves.

## Stage 3 — SAVED (FS131-I8B): the shared module, `Plane/RingCalculus/StarChart`

### 3.1 Every use the two plans make of the shared lemmas (`plans/FS131-w8-kernel-plan.md` §§ 9.1–9.3)

| lemma | used by (`SemiHub`) | used by (`SemiHubPlaces`) | the form the use wants |
|---|---|---|---|
| C1 | `germPair_dicho` (twelve cases), `ringArc_star`, `fullSemiHub_star_crossed`, `fullSemiHub_star_parallel`, `…_parallel_T` | `crossed_no_tip`, `crossed_changePoint` | a star's cone `angleIcc e_i e_(i+1)` (with `e_i ≤ e_(i+1)`) inside a window `angleIcc lo hi` shorter than `2π` gives one integer `m` with `lo + 2πm ≤ e_i`, `e_(i+1) ≤ hi + 2πm` |
| C2 | every use of C1 ("`have : m = 0 := …; linarith`") | the same | from two real bounds `−2π < 2πm < 2π` — the two-sided form is what `linarith` can feed; the plan's `|2πm| < 2π` is kept as its corollary |
| G1 | `qcol_inner_tile`, the four `ringTile_*`, `germPair_inner_ne` | the far side tiles of `semiHub_places`, `crossed_no_tip` | a closure point of the class of `c`, in the domain, nearer than `1` to a closure point of a `c`-tile `R`, is in `closure R` |
| K1 | `exists_isStar4` (`n = 4`), `four_le_of_bothKind` (no repeated colour) | `semiHub_places` (`n = 3`) | an injective list of the tiles of `x` indexed as the chart's sectors, with `τ i ∩ ball = sector i` (for `hasRepeatedColour_iff`'s `col`) and the cones (for the star); and the count `n =` colours, so that `ncard = 4` gives `Fin 4` |
| K2 | `isRingArc_of_edge` ("sides constant by K2's local picture") | `semiHub_places` (each edge case: "any two of three tiles are consecutive, so share an edge") | `∃ α ∈ F.arcs, ∃ δ B, α.InitialPiece x δ B ∧ B ⊆ closure T₁ ∩ closure T₂` — the hypotheses `hα`, `hB`, `hBT` of `isRingArc_of_edge` |

### 3.2 The statements (each `#check`ed from the built module: `data/fs131/i8b/logs/shared-signatures.log`)

All in `Proofs/HadwigerNelson/Plane/RingCalculus/StarChart.lean`, namespace `HadwigerNelson.Plane` (C1, C2, the map-free children) and
`HadwigerNelson.Plane.ArcMap` (the rest). Imports `Plane/RingCalculus/TilesAt`, `Plane/ValidMap/HexRing`, `Plane/ValidMap/Surgery`;
imported by no module yet.

- **C1** `exists_int_of_angleIcc_subset {a b lo hi : ℝ} (hab : a ≤ b) (hlen : hi < lo + 2 * π) (h : angleIcc a b ⊆ angleIcc lo hi) :
  ∃ m : ℤ, lo + 2 * π * m ≤ a ∧ b ≤ hi + 2 * π * m`. **A finding: C1 was not missing.** It is wave 3's
  `ArcMap.exists_lift_of_Icc_subset_angleIcc` (`Plane/RingGerm` l. 2242: `B - A < 2 * π → p ≤ q → Icc p q ⊆ angleIcc A B → ∃ j : ℤ,
  A + 2 * π * j ≤ p ∧ q ≤ B + 2 * π * j`) with the inner interval given as an `angleIcc`; the declaration here is that one-line corollary,
  under the plan's name so that its tables read as written.
- **C2** `int_eq_zero_of_two_pi_mul_lt {m : ℤ} (h₁ : -(2 * π) < 2 * π * (m : ℝ)) (h₂ : 2 * π * (m : ℝ) < 2 * π) : m = 0`, and the plan's
  form `int_eq_zero_of_abs_two_pi_mul_lt {m : ℤ} (h : |2 * π * (m : ℝ)| < 2 * π) : m = 0`.
- **G1** `mem_closure_tile_of_near (hF : F.Valid) (hN : F.NonSiamese) {c : Fin k} {R : Set ℂ} (hR : F.TileOf c R) {z z' : ℂ}
  (hzd : z ∈ F.dom) (hz : z ∈ closure (F.region c)) (hz' : z' ∈ closure R) (h : dist z z' < 1) : z ∈ closure R`.
- `ncard_tileAt_eq (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : p ∈ F.dom) : {T | F.TileAt p T}.ncard = (F.coloursAt p).ncard`
  (the plan's child of `exists_isStar4`).
- **K1** `IsSectorChart.tileAt_equiv {n : ℕ} {G : BranchGerms n} {x : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G x r₀) (hn : 0 < n)
  (hS : F.SimpleOn {x}) : ∃ τ : Fin n → Set ℂ, Function.Injective τ ∧ (∀ T, F.TileAt x T ↔ ∃ i, τ i = T) ∧
  (∀ i, τ i ∩ ball x r₀ = G.sector x r₀ i) ∧ ∀ i, coneAt (τ i) x = angleIcc (G.β i) (G.nextβ i)`. No validity is read. The plan's
  word "equiv" is an injective list with its range, which is what every use consumes; no `Equiv` term is built.
- **K1 with the count** `exists_sectorChart_tileAt (hF : F.Valid) (hN : F.NonSiamese) {x : ℂ} (hx : x ∈ F.dom) (hS : F.SimpleOn {x})
  {n : ℕ} (hn : (F.coloursAt x).ncard = n) (h2 : 2 ≤ n) : ∃ r₀, ∃ G : BranchGerms n, F.IsSectorChart G x r₀ ∧ (∀ i j, i ≠ j → ∀ s ∈
  Ioo 0 r₀, e (G.dir i s) ≠ e (G.dir j s)) ∧ ∃ τ : Fin n → Set ℂ, Function.Injective τ ∧ (∀ T, F.TileAt x T ↔ ∃ i, τ i = T) ∧
  (∀ i, τ i ∩ ball x r₀ = G.sector x r₀ i) ∧ ∀ i, coneAt (τ i) x = angleIcc (G.β i) (G.nextβ i)` — "K1 at `n = 4`" and "at `n = 3`"
  as one statement. First written with `BranchGerms (F.coloursAt x).ncard`; restated with a free `n` before the save, because a
  consumer holding `ncard = 4` would have had to cast a dependent type.
- **K2, the branch** `IsSectorChart.exists_initialPiece_branch (hC : F.IsSectorChart G x r₀) (hdisj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 r₀,
  e (G.dir i s) ≠ e (G.dir j s)) (j : Fin n) : ∃ α ∈ F.arcs, ∃ B, α.InitialPiece x (G.β j) B ∧
  B ⊆ insert x (branchPt x (G.β j) (G.κ j) '' Ioo 0 r₀)`.
- **K2** `IsSectorChart.exists_initialPiece_between (hC) (hdisj) (i : Fin n) : ∃ α ∈ F.arcs, ∃ B, α.InitialPiece x
  (G.β (BranchGerms.next i)) B ∧ B ⊆ closure (G.sector x r₀ i) ∩ closure (G.sector x r₀ (BranchGerms.next i))`. The disjointness
  hypothesis `hdisj` is `localSectors_disj`'s second clause, which `exists_sectorChart_tileAt` hands on.
- **K2 at three colours** `exists_initialPiece_of_ncard_le_three (hF : F.Valid) (hN : F.NonSiamese) {x : ℂ} (hx : x ∈ F.dom)
  (hS : F.SimpleOn {x}) (h3 : (F.coloursAt x).ncard ≤ 3) {T₁ T₂ : Set ℂ} (h₁ : F.TileAt x T₁) (h₂ : F.TileAt x T₂) (hne : T₁ ≠ T₂) :
  ∃ α ∈ F.arcs, ∃ δ B, α.InitialPiece x δ B ∧ B ⊆ closure T₁ ∩ closure T₂` (over wave 4's `BranchGerms.next_adj`).
- Children stated for reuse: `Arc.InitialPiece.exists_param (h : a.InitialPiece y δ B) : ∃ γ : ℝ → ℂ, ∃ ε > 0, Continuous γ ∧ γ 0 = y ∧
  (∀ t ∈ Ioc 0 ε, γ t ≠ y) ∧ ∀ η ∈ Ioc 0 ε, γ '' Icc 0 η ⊆ B ∧ a.InitialPiece y δ (γ '' Icc 0 η)`;
  `IsSectorChart.exists_branch_of_isPreconnected (hC) (hdisj) {S : Set ℂ} (hS : IsPreconnected S) (hne : S.Nonempty)
  (hsub : S ⊆ (F.Γ ∩ ball x r₀) \ {x}) : ∃ j, S ⊆ branchPt x (G.β j) (G.κ j) '' Ioo 0 r₀`; `segment_eq_image_ray`,
  `branchPt_mem_Rgn`, `branchPt_curveGerm_add`, `not_both_mem_Rgn_curveGerm`.

### 3.3 K2's proof, and the wave-4 lemmas the planner named for it (read, as the brief asks)

- `exists_initialPiece_of_cone` (`Plane/LocalStructure` l. 3394) gives an initial piece in the closure of **one** tile, at an edge of
  its cone; it does not say the piece is the branch the next tile shares, and between two tiles with a common edge direction a cusp
  tile may sit (two horn sectors in one direction). So K2 is not a corollary of it.
- `IsSectorChart.exists_isRingArc_of_along` (`Plane/ValidMap/BaseSteps` l. 597) builds an `IsRingArc` along a germ of curvature `±1`
  tangent to a unit circle — an arc of `Γ` with constant sides, not an `Arc.InitialPiece`; `IsSectorChart.exists_ball_branch` (l. 445)
  and `IsSectorChart.exists_ball_subset_of_branchPt` (`Plane/ValidMap/Surgery` l. 1311) are the local picture at a branch point.
  `Arc.InitialPiece` is produced by `exists_initialPiece_of_cone` alone in the landed library and consumed by nothing but
  `Arc.InitialPiece.subset_carrier`.
- **The route taken** (chart-internal, so that horn sectors are covered): the branch points of germ `j` lie on `Γ`; finitely many arcs
  meet a good ball (`GoodAt.fin`), so one arc `a` holds branch points in every wedge about `e (G.β j)` (`branchPt_mem_Rgn`, a
  pigeonhole by `eventually_all_finite`); `GoodAt.exists_wedge` makes `a` pass through `x` tangent to `e (G.β j)`, and wave 3's
  `Arc.exists_initialPiece_of_approach` gives an initial piece `B` of `a` inside a wedge chosen within the chart's ball and below the
  curve's scale. Its punctured part is connected (`Arc.InitialPiece.exists_param`), so it lies on one branch `l` of the chart
  (`exists_branch_of_isPreconnected`); `l = j`, because otherwise at one distance the curve of `a` would have a point of branch `j`
  and a point of branch `l`, both in the wedge — the curve's two germs there (`exists_eq_branchPt_curveGerm`), whose offsets sum to a
  multiple of the normal (`branchPt_curveGerm_add`), so not both on the side of `e (G.β j)` (`not_both_mem_Rgn_curveGerm`). The
  closures are wave 4's `IsSectorChart.branchPt_mem_closure_sector_before`, `…_after`.

### 3.4 The save

- Builds: `data/fs131/i8b/logs/build-3-starchart-first.log` (the module as first written: "build: OK — 468 of 468 batches, 2 module(s)
  rebuilt, 4 module(s) with warnings", `EXIT=0`) and `data/fs131/i8b/logs/build-4-shared-and-anti.log` (the module as committed, with
  `exists_sectorChart_tileAt` restated; the tree of that build also holds Stage 4's `Star`: "build: OK — 468 of 468 batches, 8
  module(s) rebuilt, 3 module(s) with warnings", `EXIT=0`). `StarChart` has no warning in either.
- Axioms, from the built modules (`tools/fs131_i8b_axioms.py`, the form of the first implementer's tool; `data/fs131/i8b/logs/axioms-4.txt`,
  `axioms-4.verdict`): 21 records (the sixteen of `StarChart` and Stage 4's five of `Star`), each a subset of the standard three; the
  planted control prints `sorryAx`; `--fault` exits 1 naming the control (`axioms-4-fault.verdict`).
- `./scripts/dupnames.sh`: "OK — no name is declared by two modules (23 generated on demand)", exit 0 (`dupnames-4.log`). The sixteen
  names were also grepped by declaration keyword on `origin/fs131-w6`, `-w7`, `-w9` and `main`: none declared there.
  `tools/check_architecture.py`: `RESULT: PASS` (`check-architecture-4.log`).
- Spec examples in the module: C1 on numbers with an adversary for its length hypothesis; C2's bound read; K1 and K2 run on `halfDisc`
  at `0` (`halfDisc_sectorChart`, `halfDisc_simpleOn`, `localSectors_disj`). **Owed**: a Lean model of the class "valid, non-Siamese,
  simple at `x`, at least two colours at `x`" for `ncard_tileAt_eq`, `exists_sectorChart_tileAt` and
  `exists_initialPiece_of_ncard_le_three` — `halfDisc` at `0` is the candidate (its validity and its lack of Siamese pairs are
  `example`s in `Plane/ArcMap`, unnamed; about 25 lines to name them and count its two colours at `0`).

## Stage 4 — SAVED (FS131-I8B): `star_anti` at its ruled statement, proved

### 4.1 The change

The two binders of ruling 568 (a), exactly as ruled and in the ruled place (after `hm`), nothing else:

    (hp'' : ∀ T, F.TileAt p T → T ≠ tp → ψ + π / 2 ∉ coneAt T p)
    (hm'' : ∀ T, F.TileAt p T → T ≠ tm → ψ - π / 2 ∉ coneAt T p)

Their form needed no adjustment. The docstring gained the clause naming the excluded case and the row's line
(`plans/FS116-derivation.md` l. 719), and says which hypothesis each step reads.

### 4.2 The proof (about 150 lines, three children; first elaboration of each but for one deprecated name)

- `false_of_antipodal_gaps` — the interval step, pure reals: an interval `[b₁, b₂]` of directions holding `ψ + 90°` and `ψ − 90°`
  cannot leave room, off its open part, for a direction strictly inside `(ψ − 90°, ψ + 90°)` and one strictly inside
  `(ψ + 90°, ψ + 270°)`. No case split on whether the cone is every direction: the whole-circle cone and the proper interval close by
  the same four inequalities.
- `star_anti_ne` — `t⁺ ≠ t⁻`, at any `k` with at most two colours absent (`k ≤ ncard + 2`, `4 ≤ ncard`: a **generalization** of this
  clause, which reads no six): a tip of `y` (`star_tip_nonempty`, cone in `[ψ − 90°, ψ + 90°]` by `IsTip.coneAt_subset`) and the tile
  of `p` of an outer colour of `y` (`star_outer_nonempty`, cone in `[ψ + 90°, ψ + 270°]` by `star_outer_cone`) are tiles of `p` other
  than `t` (their colours are carried at `y`, its colour is not); each has a direction in its closed half-circle
  (`SimpleOn.coneAt_eq_angleIcc`), off both ends by `hp''`, `hm''`, and off the open part of the cone of `t`
  (`SimpleOn.coneAt_eq_angleIcc_sep`).
- `star_anti_count` — at one hub, two distinct colours of `p` absent at `y` are the absent pair, `T_y` and `O_y` are single colours,
  the other two of `p`, and `y` has four colours: `star_absent`, `disjoint_tipColours_outerTileColours`, and `ncard` arithmetic in
  `Set (Fin 6)`.
- The composition: `cp`, `cm` are absent at `y` and at `y*` (`star_flank_interior`, at the angle `ψ − π` for `tm`, whose ring point is
  `r(ψ + π)`); `tp ≠ tm`; `cp ≠ cm` (one tile per colour at `p`); the count at both hubs; the tips of `y` and `y*` have different
  colours (one tile of `p` would hold `y` and `y*`, `2` apart: `IsTile.dist_le_one_of_mem_closure`), so the two single colours are
  exchanged.

### 4.3 The first implementer's four handed claims (`plans/FS131-I8A-implementation.md` § 5.5), against the kernel

- "The binders close the stuck case": **yes** — and with them the step needs no case at all (§ 4.2, first bullet).
- "They are no new content at a proper interval": **not checked in Lean** — no declaration here derives `hp''` from `hp'` at a proper
  interval; it stays a hand remark (true by `SimpleOn.coneAt_eq_angleIcc_sep` when `tp`'s cone is proper: the interior of its cone is
  in the open part, which every other tile's cone misses).
- "Their form is usable as written": **yes** — applied to a tip through `IsTip.tileAt` and to the outer colour's tile of `p` as
  `⟨hQ.1, hpQ⟩`.
- "The route for the rest", (a)–(d): **followed**; (d) needs no cone, as handed.

One observation the proof makes visible: `t⁺ ≠ t⁻` reads `hp'`, `hm` as membership only (`interior_subset`); the interiors are read by
`star_flank_interior` alone (the two colours' absence at `y` and `y*`).

### 4.4 The save

- Build: `data/fs131/i8b/logs/build-4-shared-and-anti.log` — "build: OK — 468 of 468 batches, 8 module(s) rebuilt, 3 module(s) with
  warnings", `EXIT=0`; 24 `declaration uses sorry` lines, in `SemiHub` (17), `SemiHubPlaces` (6), `Empty` (1). `rg -c "^\s*sorry"`
  agrees; `Star` holds none.
- Axioms from the built modules (`axioms-5.txt`, `axioms-5.verdict`): 21 records — `StarChart`'s sixteen and `Star`'s five
  (`mem_coneAt_add_int_mul_two_pi`, `false_of_antipodal_gaps`, `star_anti_ne`, `star_anti_count`, `star_anti`) — each a subset of the
  standard three; the control prints `sorryAx`; `--fault` exits 1 naming it.
- No `axiom`, no `native_decide` in what this job wrote.

## Stage 5 — SAVED (FS131-I8B): the statement check, the guarded lint, the handoff

### 5.1 The statement check, on elaborated signatures

`tools/fs131_i8b_stmt.py` (the form of the wave's `tools/fs131_i8a_stmt.py`, over the nine modules of the ring calculus that exist at
a base; `--expect` names the declarations expected to change, and the exit is 0 only if the changed set is exactly that):

- against `8d979793` (`data/fs131/i8b/logs/stmt-vs-8d979793.log`): 214 base declarations compared in 9 modules; **1 changed —
  `star_anti`**; 5 added in those modules (`exists_tileOf_of_germIn`, by the merge; `false_of_antipodal_gaps`,
  `mem_coneAt_add_int_mul_two_pi`, `star_anti_count`, `star_anti_ne`, mine); exit 0.
- against `e1e0c74d` (`stmt-vs-e1e0c74d.log`): 152 base declarations compared in 7 modules (`SemiHub`, `SemiHubPlaces` do not exist
  there: listed and skipped, every declaration of them an addition); **1 changed — `star_anti`**; 4 added (mine); exit 0.
- **by exactly the two binders** (`tools/fs131_i8b_binders.py`, `binders.log`): the kernel's statement now is the base statement with
  the two ruled hypotheses inserted, in order, immediately before `tp ≠ tm ∧ …` — against both bases, exit 0; its planted fault (one
  binder dropped from the expected insertion) exits 1.
- My additions outside those modules: the new module `Plane/RingCalculus/StarChart` (sixteen declarations, § 3.2).
- The tool's three planted faults (`--self-test`: a hypothesis altered in `Empty`, an `include` that adds `0 = 1 →` with the text
  unchanged, a binder added to `star_recip`): `data/fs131/i8b/logs/stmt-selftest.log` — its last line is recorded in § 5.4.

### 5.2 The guarded lint

After the last green build (no Lean file changed since `build-4`): `scripts/slot.py --mem 8 --cpus 2 -- lake lint --no-build --
--no-build --trace`, `data/fs131/i8b/logs/lint.log`: exit 0, "-- Linting passed for Proofs.", fourteen `(2/2) Passed!` lines, no line
with "failed" or "error". No control was planted for it by this job (a planted unused instance binder needs a build of its own; the
wave's gate has it).

`./scripts/dupnames.sh` after the build: OK, exit 0 (`dupnames-4.log`; no Lean file changed after it). `tools/check_architecture.py`:
`RESULT: PASS` (`check-architecture-5.log`, after `ARCHITECTURE.md`'s row for `Star` was brought up to date).

### 5.3 Slips, the job's

- Build 3 was launched with `&` inside a tool call instead of the harness's background mode: it ran to its end and its log is saved,
  but nothing would have told me had it died; and the `ls` beside it ran in the wrong directory and failed. Builds 1, 2 and 4 were
  launched properly.
- `exists_sectorChart_tileAt` was restated once before its save (a free `n` in place of `(F.coloursAt x).ncard` in a type);
  `build-3-starchart-first.log` is the build of the first form, `build-4` of the form committed.
- Stages 2 and 3 are one commit after the merge commit (the merged tree's build log and the shared module together).
- The shared module's commit (`d635a30a`) was built in a tree that also held Stage 4's `Star`; `StarChart` does not import `Star`, so
  its compiled module is the one that commit alone gives, but no build ran at that commit alone.
- No Lean model of the class "valid, non-Siamese, simple at `x`" (§ 3.4, owed); no control planted for the lint.
- I cannot read the harness's token count; the hand-back is at this saved stage on my own estimate of the brief's line.

### 5.4 The self-test's result

`data/fs131/i8b/logs/stmt-selftest.log`: control 'binder' exit 1 — FIRED; control 'include' exit 1 — FIRED; control 'text' exit 1 —
FIRED (each run reports two changed declarations: `star_anti` and the planted one); "self-test: OK — every planted fault fired",
exit 0.

## For the two implementers who start from here

*FS131-I8C on `Plane/RingCalculus/SemiHub` (the planner's "I8B"), FS131-I8D on `Plane/RingCalculus/SemiHubPlaces` with `outerAdj`
(its "I8C"). Start from `fs131-w8b`'s tip. `Star` holds no `sorry`; do not touch it or `StarChart` — a lemma either of you needs
beside these goes in your own module under a name of your own, and is said in your report.*

**Import.** `import Proofs.HadwigerNelson.Plane.RingCalculus.StarChart` in `SemiHub` (then `SemiHubPlaces` has it through `SemiHub`;
if the two jobs run at once, `SemiHubPlaces` adds the import itself — a module may be imported twice over). `StarChart` imports
`TilesAt`, `ValidMap/HexRing`, `ValidMap/Surgery`, and not `Star`.

| lemma | statement | serves |
|---|---|---|
| C1 `exists_int_of_angleIcc_subset` | § 3.2 | every "cone of a star tile inside a window": `obtain ⟨m, h1, h2⟩ := exists_int_of_angleIcc_subset h.le₁₂ (by linarith [Real.pi_pos]) (h.cone₁ ▸ hwindow)` |
| C2 `int_eq_zero_of_two_pi_mul_lt` | § 3.2 | `have hm0 : m = 0 := int_eq_zero_of_two_pi_mul_lt (by linarith) (by linarith)`, then `subst hm0; simp only [Int.cast_zero, mul_zero, add_zero] at h1 h2` |
| G1 `ArcMap.mem_closure_tile_of_near` | § 3.2 | `qcol_inner_tile`, `ringTile_*`, `germPair_inner_ne`; the far side tiles of `semiHub_places`, `crossed_no_tip` |
| `ArcMap.ncard_tileAt_eq` | § 3.2 | counting tiles by colours (`crossed_four`'s arithmetic may want it) |
| K1 `ArcMap.exists_sectorChart_tileAt` | § 3.2 | `exists_isStar4`: call it with `hn := h4` and `(by norm_num : 2 ≤ 4)` — `G : BranchGerms 4`, `τ : Fin 4 → Set ℂ`; `semiHub_places`: with `ncard = 3` |
| K1 `ArcMap.IsSectorChart.tileAt_equiv` | § 3.2 | `four_le_of_bothKind` (any chart with a germ; no validity) |
| K2 `ArcMap.exists_initialPiece_of_ncard_le_three` | § 3.2 | `semiHub_places`: the two tiles of each edge case, directly in the shape of `isRingArc_of_edge`'s `hα`, `hB`, `hBT` |
| K2 `ArcMap.IsSectorChart.exists_initialPiece_between`, `…_branch` | § 3.2 | the same at a chart, for consecutive sectors `i`, `BranchGerms.next i` |
| `Arc.InitialPiece.exists_param`, `ArcMap.IsSectorChart.exists_branch_of_isPreconnected` | § 3.2 | `isRingArc_of_edge` (below) |

**What my reading of the foundation shows will not go as the plan writes it** (each a note, none a statement defect found; the
code-font hints here and in the table above are by reading, not elaborated — only what `StarChart` itself runs is checked):

1. **C1 is landed** (wave 3, `ArcMap.exists_lift_of_Icc_subset_angleIcc`): the plan's "one missing lemma" is a corollary. Nothing to
   mint.
2. **`exists_isStar4` is short** (the plan prices 250 lines): from `exists_sectorChart_tileAt … h4 (by norm_num)` take
   `e_i := G.β i`; `G.nextβ i` unfolds by `simp [BranchGerms.nextβ]` to `G.β (i + 1)` for `i < 3` and to `G.β 0 + 2 * π` at `i = 3`
   — exactly `IsStar4`'s four cones; the order is `hC.sorted.mono`; `tileAt` is K1's second clause over `Fin 4`; `ne` is
   injectivity. `IsStar4.rotate` (the plan's child of `ringArc_star`) is the same data re-indexed through
   `angleIcc_add_int_mul`.
3. **`four_le_of_bothKind`**: `exists_sectorChart_tileAt` asks `2 ≤ n`. At a point with one colour use `localSectors` with
   `IsSectorChart.tileAt_equiv` (a germ) or `IsSectorChart.not_hasRepeatedColour_of_zero` (none). For
   `IsSectorChart.hasRepeatedColour_iff`'s `hcol`, the sector at radius `r ≤ r₀` lies in `τ i` by `G.sector_mono` and K1's third
   clause; two sectors of one colour are then two tiles `τ i ≠ τ j` of one colour at `w`, against
   `NonSiamese.tile_eq_of_mem_closure`.
4. **`isRingArc_of_edge` has no chart among its hypotheses**, so "sides constant by K2's local picture" has to make its own: take
   `localSectors_disj` at `y`; shrink `B` into the chart's ball by `Arc.InitialPiece.exists_param` (its `γ '' Ioc 0 η` is connected
   and misses `y`); `IsSectorChart.exists_branch_of_isPreconnected` puts it on one branch `j`; `closure_inter_subset_sphere` puts it
   on `ω(w)`; at each branch point `IsSectorChart.exists_ball_subset_of_branchPt` (`Plane/ValidMap/Surgery` l. 1311) leaves the two
   sectors beside the branch, one in `T₁` and one in `T₂` (each tile is open, meets the ball, and they differ), which gives
   `innerColours = {c₁}` and `outerColours = {c₂}` there. Wave 4's `IsSectorChart.exists_isRingArc_of_along`
   (`Plane/ValidMap/BaseSteps` l. 597) builds such an arc from a germ with `G.κ k₀ = ±1` and `e (G.β k₀) = I * G.κ k₀ * (u - q)`, but
   returns its side colours as `∃ c c'`, and its two hypotheses would have to be derived from "the branch lies on `ω(w)`" — I do not
   know which of the two routes is shorter; neither is in the kernel.
5. **K2's direction**: the piece leaves along `G.β (BranchGerms.next i)`; with K1's cones that is the common end of
   `coneAt (τ i) x = angleIcc (G.β i) (G.nextβ i)` and the start of the next (`BranchGerms.e_nextDir`, `nextβ` unfolded as in note 2).
   `exists_initialPiece_of_ncard_le_three` hides the direction (`∃ δ`), which is all `isRingArc_of_edge` reads.
6. **`exists_initialPiece_of_cone`** (`Plane/LocalStructure` l. 3394, the plan's first place to look for K2) gives a piece in **one**
   tile's closure and cannot tell the shared branch from a cusp tile's other side; do not reach for it where two tiles are meant.
7. **`star_anti` now has two more hypotheses** (`hp''`, `hm''`); the plan says nothing of the two modules reads it, and I found no
   use of it in either.

## Drafts for the front page

*For the coordinator to file; nothing here is filed by this job, which did not run the gate (the brief withholds it), so it drafts no
gate counts and no trust-ledger counts.*

1. **`CLAUDE.md` § The gate, § Trust ledger** — no draft. What the wave's landing will meet from this job: 21 records in the block
   "FS131-I8B" of `scripts/Axioms.lean`, all CLEAN; no purchase; no `VACUITY DECLARED` line added; `star_anti` keeps its `VACUITY:`
   docstring paragraph (satisfiability open, the strip's `P₀` named with the hypotheses it fails).
2. **`LEDGER.md` § B, FS116-N2-ANTI's line** (slot: its grade cell, "derived; one mind") — draft: "kernel on `fs131-w8b`, not gated:
   `HadwigerNelson.Plane.ArcMap.star_anti` (`Proofs/HadwigerNelson/Plane/RingCalculus/Star.lean`), on the standard three axioms, no
   assumption imported; *simple* read at the tiles of `p` only; with the row's *not claimed* case as two hypotheses (no other tile of
   `p` approaches `p` along `ψ ± 90°`: inventory item 568)."
3. **`plans/FS116-derivation.md`, FS116-N2-ANTI's entry — an erratum for its statement line** (slot: after "let ψ + 90° and ψ − 90°
   lie in the interiors of the cones at p of tiles t⁺ and t⁻") — draft: "(no edge of p leaving at ψ + 90° or ψ − 90°: read as a
   hypothesis; the interior of a cone that is every direction does not give it)". The deriver's file; a draft only.
4. **`plans/FRONTIER-STUBS.md`** (slot: a stub line under FS-124's residues, as the planner's § 7.3 proposes) — draft: "can a tile of
   a four-colour vertex have every direction in its cone, with two antipodal hubs? (the case `star_anti` excludes by hypothesis;
   neither excluded nor constructed)".
5. **`CLAUDE.md` § Frontier** — no change of state: FS-131 stays open; on wave 8's line `Star` is whole and the semi-hub modules have
   their shared part.
6. **Proof Atlas grade changes** (on landing, not now): FS116-N2-ANTI → kernel, with its two hypotheses.
