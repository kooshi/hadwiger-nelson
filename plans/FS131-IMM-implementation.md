# FS131-IMM — wave 4's MERGE (`exists_merge_aux`) in `Plane/ValidMap/MergeMove`

*The record of FS131-IMM1 (de Bruijn, the implementer, on Opus), branch `fs131-w4mm` cut from `fs131-w4m` at `73d31ad6`, in the worktree
`.claude/worktrees/fs131-w4mm`. Brief: `data/fs131/briefs/FS131-IMM1-merge.md` (on `main`). Report: `data/fs131/reports/FS131-IMM1.md`.*

## Theorems this phase proved

None yet (see the last SAVED stage).

## Stage 1 — SAVED: the readback, the as-given build

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation (a prefix, cut with `…`) | source | result |
|---|---|---|
| "theorem exists_merge_aux (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)" | `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean` l. 584 (this branch) | **verbatim** |
| "Choose two `c`-sectors consecutive along `D_c(v)`'s arc of directions with the gap between them inside `D_c(v)` (the `c`-sectors' cones lie in `D_c(v)`," | `plans/FS131-IM-implementation.md` l. 305 (§ 3.4, this branch) | **verbatim** |
| "above it, item 262 (a)). About 1.5 sessions. **MERGE (`exists_merge_aux`)**: the run cut again, in a gap of `D_c(v)`, but **without** the full" | the same, l. 453 (§ 6.3) | **verbatim** |
| "269. **Ruling on item 268: `exists_merge` and `exists_merge_aux` take `F'.coloursAt v ⊆ F.coloursAt v` in place of the off-rim clause.** Choice: IM2 replaces the" | `plans/FS131-close-inventory.md` l. 1958 (on `main`) | **verbatim** |
| "285. **Ruling: I5c's slot → the parallel MERGE implementer FS131-IMM1 on a new branch `fs131-w4mm`; wave 5's next implementer takes the next slot.** Choice: as" | the same, l. 2141 | **verbatim** |
| "**It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the" | `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 14.2, l. 887 | **verbatim** |

Read: the IM record's §§ 3 and 6 and IM3's Stages 7–9 (this branch), and — by the coordinator's message after launch — IM3's § 10.1 on
`fs131-w4m` (`.claude/worktrees/fs131-w4m/plans/FS131-IM-implementation.md`), which I found independently before reading it: `Near.move` and
`Near.exists_cut` add the whole circle `∂B(v, ρ)`, so neither serves MERGE; and the rim clause `¬ F'.HasRepeatedColour x` fails at the rim
crossing of any germ at `v` with one colour on both sides unless that germ is cut just inside the rim. The audit records go just above the
`=== PURCHASED ===` banner (IM3's § 8.2).

### 1.2 The branch builds as given

`73d31ad6`, under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): **OK**, 446 of 446 batches, 11
modules rebuilt (the copied `.lake/build` came from an older tree: `Basic`, `Sectors`, `StuckChain`, `SVMap`, `Cone`, `Contact`, `Surgery`, `UnitArc`,
`Moves`, `BaseSteps`, `Proofs`), 10 min 24 s; warnings only `declaration uses 'sorry'` — `Moves` 2 (l. 573 `exists_rayMerge_aux`, l. 584
`exists_merge_aux`), `Contact` 4, `BaseSteps` 7, `UnitArc` 17. Log `build/gate/build/20261005T002608Z-3882202.log`; terminal output
`data/fs131/imm/build-asgiven.log`.
