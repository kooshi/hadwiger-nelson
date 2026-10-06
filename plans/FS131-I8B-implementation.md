# FS131-I8B — wave 8, the join and the shared part

*Job FS131-I8B (de Bruijn, the implementer), 2026-10-06, branch `fs131-w8b` (cut from `fs131-w8` at `8d979793`). Brief:
`data/fs131/briefs/FS131-I8B-wave8-join.md` (on `main`). The plans: `plans/FS131-w8-kernel-plan.md` (the planner's record, FS131-K8 and
FS131-K8b) and `plans/FS131-I8A-implementation.md` (the first implementer's record, by the merge of Stage 2). Working files:
`data/fs131/i8b/`. Tools: `tools/fs131_i8b_*.py`.*

## Theorems this phase proved

*(Filled at each saved stage; at Stage 1 none.)*

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
