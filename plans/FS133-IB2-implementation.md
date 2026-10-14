# FS133-IB2 — the definitions of the one-class transfer's kernel module: `Plane/OneClass/Defs`, thirteen leaves

*de Bruijn, the implementer; job FS133-IB2 (brief: `data/fs133/briefs/FS133-IB2-definitions.md`, on `main`).
Branch `fs133-wb2`, cut from `8ed85e9b8` (the last implementer's head, branch `fs133-wb1`) in the worktree
`.claude/worktrees/fs133-wk1`. The plan is `plans/FS133-kernel-plan.md` § 5.2 (lane B, the G leaves), with § 5.5.
Working files: `data/fs133/ib2/`. Files this job writes: `Proofs/HadwigerNelson/Plane/OneClass/Defs.lean` (proofs
and private helpers only), and in `Proofs/HadwigerNelson/Plane/OneClass/InvariantLaw.lean` the two private lemmas
`card_le_indepNum_induce`, `exists_indep_subset` and the proofs that call them.*

## Theorems this phase proved

*(filled at the last stage)*

## Stage 1 — SAVED: the readback, the leaves restated, the stored statements dumped before any edit

**1.1 The brief's quotations.** `tools/fs133_ib2_readback.py` (FS133-IB1's reader with this job's brief; each quoted
line a substring of its source, read in the coordinator's tree): **3 matched, 0 mismatched**, exit 0
(`data/fs133/ib2/readback-brief.out`) — W2 against `data/fs131/REQUEST-2026-10-13.md`; K133-ONE and K133-NC-ONE
against `data/fs133/claims-K1.md`. With `--fault` (the last character of each quoted line changed): 0 matched,
3 mismatched, exit 1 (`readback-brief-fault.out`). No finding about the brief's quotations.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make the
gate fail; the plan's §§ 4, 5.0–5.2, 5.5, 6 and 4.2; FS133-IB1's record whole; FS133-IA1's drafts (its D2 names the
law that exercises `exists_field`'s clause (c): the law of `exists_isInvariantLaw_unitDistance` at `z = 1`, not the
point mass); `Defs.lean`, and in `InvariantLaw.lean` the two private lemmas and their callers.

**1.3 Each leaf, in one line, beside the plan's route.** Thirteen `sorry`s. The file's text is the statement; the
line is a reading.

| leaf | the statement, in one line | the plan's route (§ 5.2) |
|---|---|---|
| **G1** `SimpleGraph.le_finIndepRatio_iff` | `r ≤ ᾱ(G)` iff every nonempty finite `S` holds an independent `I ⊆ S` with `r·#S ≤ #I` | the bridge `α(G[S])` = the largest independent `I ⊆ S` (`exists_isNIndepSet_indepNum`, `IsIndepSet.card_le_indepNum`) |
| **G2** `finIndepRatio_le_of_forall_card_le` | one nonempty `S` whose independent subsets have at most `a` points gives `ᾱ(G) ≤ a / #S` | the bridge |
| **G3** `finIndepRatio_le_one` | `[Nonempty V]`: `ᾱ(G) ≤ 1` | the bridge |
| **G4** `finIndepRatio_le_of_embedding` | an induced embedding `G ↪g G'` gives `ᾱ(G') ≤ ᾱ(G)` | the image of `S`; an independent subset of the image pulls back |
| **G5** `inv_le_finIndepRatio_of_colorable` | `G.Colorable k` gives `k⁻¹ ≤ ᾱ(G)` | pigeonhole on the colour classes of `S`; a class is independent |
| **G6** `inv_finIndepRatio_le_iSup_fractionalChromaticNumber` | `ᾱ(G)⁻¹ ≤ ⨆ S, χ_f(G[S])` | `le_fractionalChromaticNumber_of_indepNum` on `G[S]` with `a := α(G[S])`; `ENNReal.inv_iInf` |
| **G7** `Plane.isIndepSet_unitDistance_iff` | independent in `unitDistance V` iff no two points of `A` at distance one | `unitDistance_adj`; `dist x x = 0 ≠ 1` |
| **G8** `Plane.isIndepSet_ball_half` | the open disc of radius `1/2` about `0` is independent | G7 and the triangle inequality |
| **G9** `Plane.mOne_eq_iSup_nullMeasurableSet` | `m₁` is also the supremum over null-measurable independent sets | `NullMeasurableSet.exists_measurable_subset_ae_eq`; a lemma `upperDensity_congr_ae` |
| **G10** `Plane.minIndepNum_one` | `f(1) = 1` | one point |
| **G11** `algPlaneEmbedding`'s `map_rel_iff'` | the inclusion `E → ℂ` reflects and preserves unit distance | `unitDistance_adj`, `Subtype.dist_eq` |
| **G12a** `OneClass.IsInvariantLaw.isPlaneSystem` | an invariant law with `shiftLab`, `turnLab` is a plane system | measurability by `measurable_pi_lambda`; `MeasurePreserving` from the `map` equalities; the five laws by `funext` |
| **G12b** `OneClass.isInvariantLaw_dirac` | the point mass at the empty labelling is an invariant law of every graph on `E` | the same (the plan names no step for its `indep` clause; stage 2.2) |

**1.4 The stored statements before any edit** (the build as the last implementer left it, for `8ed85e9b8`; its
last commit changed only the report, `git diff f8f4c8598 8ed85e9b8 --stat`). `data/fs133/ib2/lean/StatementDump.lean`
(FS133-IB1's dumper, its body unchanged, the module list `Defs`, `InvariantLaw`) prints every named constant of the
two modules from their compiled data, in the full print and the print with instance and proof arguments erased:
`data/fs133/ib2/moved/before.out` — **`Defs` 49 named constants (no private one), `InvariantLaw` 10 named and 21
private, 80 in all**. Their comparison with the last implementer's dump of `InvariantLaw` and the reader's control
are stage 4's (the reader is `tools/fs133_ib2_moved.py`, made from FS133-IB1's).
