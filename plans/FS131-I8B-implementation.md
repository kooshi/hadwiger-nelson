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
