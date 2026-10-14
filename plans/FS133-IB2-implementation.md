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

## Stage 2 — SAVED: the thirteen leaves, Amendment 1 carried out, the join

*`Defs` under `lake env lean` with the lakefile's options (`data/fs133/ib2/lean1.sh`): no `sorry`, no error, no
warning. `InvariantLaw` cannot be elaborated alone before `Defs` is compiled (it imports the compiled `Defs`, which
did not yet hold `countable_algPlane`): its first elaboration is the build, stage 3.*

**2.1 The leaves — each on the plan's route, with the bridge as two private lemmas** (`SimpleGraph.card_le_indepNum_induce`:
an independent subset of `S` has at most `α(G[S])` points; `SimpleGraph.exists_indep_card_eq_indepNum`: some independent
subset of `S` has exactly `α(G[S])`). The plan named the bridge `indepNum_induce_finset` as a public lemma; a public
declaration is outside this job's touches, so it is two private ones, and every reading of the ratio in the file goes
through them.
- **G1** `le_finIndepRatio_iff`, **G2** `finIndepRatio_le_of_forall_card_le`, **G3** `finIndepRatio_le_one` (G2 at a
  singleton), **G4** `finIndepRatio_le_of_embedding` (G1 both ways: an independent subset of the image pulls back
  through `S.filter (f · ∈ I')`), **G5** `inv_le_finIndepRatio_of_colorable` (pigeonhole by
  `Finset.card_eq_sum_card_fiberwise` and a strict sum; `k = 0` is no case: a vertex of a nonempty `S` gives
  `0 < k`), **G6** `inv_finIndepRatio_le_iSup_fractionalChromaticNumber` (`ENNReal.inv_iInf` twice,
  `ENNReal.inv_div`, `le_fractionalChromaticNumber_of_indepNum` at `a := α(G[S]) ≥ 1`) — **proved**.
- **G7** `isIndepSet_unitDistance_iff`, **G8** `isIndepSet_ball_half` (the triangle inequality through `0`),
  **G9** `mOne_eq_iSup_nullMeasurableSet` (a Borel subset almost everywhere equal, independent as a subset; the
  private `upperDensity_congr_ae`), **G10** `minIndepNum_one`, **G11** `algPlaneEmbedding.map_rel_iff'` (`Iff.rfl`:
  the subtype's distance is the ambient one by definition) — **proved**.
- **G12a** `IsInvariantLaw.isPlaneSystem` — **proved**: measurability of `shiftLab z`, `turnLab u` by
  `measurable_pi_lambda` (private `measurable_shiftLab`, `measurable_turnLab`), the two `MeasurePreserving` fields from
  `h.shift`, `h.turn`, the five laws by `funext` (private `kCoeff_one'`, `kCoeff_mul'`), the covariance by `mul_add` —
  the convention the plan's § 6.1 checked by hand. **The kernel's model of the field theorem's hypotheses** (stage 5).
- **G12b** `isInvariantLaw_dirac` — **proved, by a route the plan does not name** (sent to the coordinator at once):
  its `indep` clause needs the point mass to see single points of `E → Bool`, and that is the countability of `E`
  (`Pi.instMeasurableSingletonClass`, then `ae_dirac_eq`). It cannot be done without it: a measurable set of the
  product depends on countably many coordinates, so for an uncountable index set the labellings with some `true`
  coordinate would carry mass one. `Countable E` was in the library only downstream, as `InvariantLaw`'s public
  `countable_algPlane`, whose proof reads `Algebraic.countable`, outside `Defs`'s import closure.

**2.2 Amendment 1 (04:30 UTC; read on disk in the coordinator's tree): option (a).** **`OneClass.countable_algPlane`
moved into `Defs`**, its statement and docstring unchanged, with a proof that needs no new import (a rational
polynomial is fixed by the list of its first `natDegree + 1` coefficients, so `ℚ[X]` is countable; each algebraic
number lies in the finite root set of a nonzero one: `Polynomial.rootSet_finite`, `Polynomial.mem_rootSet`); the copy
in `InvariantLaw` deleted; `isInvariantLaw_dirac` and `InvariantLaw`'s four `haveI := countable_algPlane` read the one
lemma. `InvariantLaw`'s imports are unchanged (its `Mathlib.Algebra.AlgebraicCard` stays, now read by nothing).

**2.3 The join (Done, item 4).** Both private lemmas of `InvariantLaw` are **deleted** (their text kept at
`data/fs133/ib2/deleted-private-block.txt`):
- `exists_indep_subset` — replaced at its one call (`exists_isInvariantLaw`) by `(G.le_finIndepRatio_iff.1 le_rfl)
  (F n) (hF n)`, the line FS133-IB1's draft DB3 gave.
- `card_le_indepNum_induce` — its one call was in `IsShiftInvariantLaw.measure_origin_le`, which also unfolded
  `finIndepRatio`. That proof now reads the ratio through `le_finIndepRatio_iff` only: for each nonempty `S`, a
  largest independent subset `J` of `S` (`Finset.exists_max_image` over `S.powerset.filter`), and the random set
  meets `S` in an independent subset, so in at most `#J` points almost surely. No independence number appears in the
  file now, and no proof of the bridge is in it: the bridge is `Defs`'s, once.

**2.4 Re-pricing** (Done, item 2). The plan priced lane G at 4–6 h. The first two leaves closed in the first
elaboration with the bridge; all thirteen closed in two elaborations of the file (one error: `simpa` gave `1 ≤ α`
where `0 < α` was asked). What is left is receipts: the build, the statement check, the axioms, the drafts.

**2.5 A finding for another lane** (not a statement). The plan's G9 names `upperDensity_congr_ae` and says lane C's
A1 (`Plane/OneClass/Algebraic`) uses it too. Here it is **private** (a public declaration is outside this job's
touches), so lane C cannot read it: it needs its own copy (a duplicate proof) or a ruling to make this one public.
