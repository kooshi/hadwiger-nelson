# FS133-IB2 — the definitions of the one-class transfer's kernel module: `Plane/OneClass/Defs`, thirteen leaves

*de Bruijn, the implementer; job FS133-IB2 (brief: `data/fs133/briefs/FS133-IB2-definitions.md`, on `main`).
Branch `fs133-wb2`, cut from `8ed85e9b8` (the last implementer's head, branch `fs133-wb1`) in the worktree
`.claude/worktrees/fs133-wk1`. The plan is `plans/FS133-kernel-plan.md` § 5.2 (lane B, the G leaves), with § 5.5.
Working files: `data/fs133/ib2/`. Files this job writes: `Proofs/HadwigerNelson/Plane/OneClass/Defs.lean` (proofs
and private helpers only), and in `Proofs/HadwigerNelson/Plane/OneClass/InvariantLaw.lean` the two private lemmas
`card_le_indepNum_induce`, `exists_indep_subset` and the proofs that call them.*

## Theorems this phase proved

Each **[kernel] on `[propext, Classical.choice, Quot.sound]`**, printed from the built tree (stage 3.3;
`data/fs133/ib2/axioms-built.out`); none rests on the declared outside theorem. Statements FS133-K1's, unchanged
(stage 3.2); proofs this job's.

`Proofs/HadwigerNelson/Plane/OneClass/Defs.lean`:
- `SimpleGraph.le_finIndepRatio_iff` — `r ≤ ᾱ(G)` iff every nonempty finite vertex set holds an independent subset
  of at least `r` times its size.
- `SimpleGraph.finIndepRatio_le_of_forall_card_le` — one nonempty finite set whose independent subsets have at most
  `a` points bounds `ᾱ(G)` by `a / |S|`.
- `SimpleGraph.finIndepRatio_le_one` — `ᾱ(G) ≤ 1` on a nonempty vertex type.
- `SimpleGraph.finIndepRatio_le_of_embedding` — an induced embedding `G ↪g G'` gives `ᾱ(G') ≤ ᾱ(G)`.
- `SimpleGraph.inv_le_finIndepRatio_of_colorable` — a `k`-colourable graph has `ᾱ(G) ≥ 1/k`.
- `SimpleGraph.inv_finIndepRatio_le_iSup_fractionalChromaticNumber` — `1/ᾱ(G) ≤ sup_S χ_f(G[S])`.
- `HadwigerNelson.Plane.isIndepSet_unitDistance_iff` — independence in a unit-distance graph is "no two points at
  distance one".
- `HadwigerNelson.Plane.isIndepSet_ball_half` — the open disc of radius `1/2` is independent.
- `HadwigerNelson.Plane.mOne_eq_iSup_nullMeasurableSet` — `m₁` over Lebesgue-measurable sets is `m₁` over Borel ones.
- `HadwigerNelson.Plane.minIndepNum_one` — `f(1) = 1` (a drift check).
- `HadwigerNelson.OneClass.algPlaneEmbedding` — its proof field: the inclusion of the algebraic plane in the plane is
  an embedding of unit-distance graphs (a definition; its data field unchanged).
- `HadwigerNelson.OneClass.IsInvariantLaw.isPlaneSystem` — an invariant random independent set is a plane system:
  **the field theorem's hypotheses (`OneClass.exists_field`) inhabited in the kernel**.
- `HadwigerNelson.OneClass.isInvariantLaw_dirac` — the point mass at the empty labelling is an invariant law of
  every graph on the algebraic plane.
- `HadwigerNelson.OneClass.countable_algPlane` — the algebraic plane is countable (moved here from `InvariantLaw` by
  Amendment 1, its statement unchanged; a proof with no new import).

`Proofs/HadwigerNelson/Plane/OneClass/InvariantLaw.lean` (re-proved at the join; statements unchanged):
- `HadwigerNelson.OneClass.IsShiftInvariantLaw.measure_origin_le` — now through `le_finIndepRatio_iff` alone.
- `HadwigerNelson.OneClass.exists_isInvariantLaw` — one line: the independent subsets of the ratio's size from
  `le_finIndepRatio_iff`.

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

## Stage 3 — SAVED: the build under the slot, and every receipt from the built tree

**3.1 The build** (Done, item 5). Three runs of `data/fs133/ib2/build.sh` (`./scripts/build.sh` under the slot,
`--mem 10 --cpus 4`, `MEMMAX=10G BATCH=8`):
- *A first run, stopped by me at batch 56 of 249* (`build-stopped.log`, `build-stopped-full.log`): it had recompiled
  `Plane/OneClass/Defs` from the committed source (`✔ Built … Defs (2.7s)`, no warning) when I saw that the join had
  left `measure_origin_le`'s binder `hS` unread — a warning to come — so it was building under text I was about to
  fix (`RUNNING.md`: a run that blocks its own fix is killed). Stopped by its process group (`kill -TERM -- -1600294`),
  checked by effect: no process of the group in `ps`, the log's digest the same across ten seconds. It forfeited
  nothing. Two fixes in `InvariantLaw` followed, both found by elaborating it against a farm of `.olean` files
  (`data/fs133/ib2/farm1.sh`; the build's library untouched): the binder written `_`, and the filter's binder
  annotated `J : Finset E` (it had elaborated as `Set E` from the ascription, an error).
- *The build of record* (`build.log`, `build-full.log`, `build.exit` = 0): **`build: OK — 249 of 249 batches, 6
  module(s) rebuilt, 3 module(s) with warnings, 6m37s`**. Rebuilt: `InvariantLaw` (4.8 s), `Field`, `Algebraic`,
  `Fractional`, `Pair`, `Proofs`. Its 13 warnings are each `declaration uses 'sorry'`, in `Algebraic` (5), `Fractional`
  (3), `Pair` (5) — lane C's and lane D's leaves; **none from `Defs` or `InvariantLaw`**.
- *An up-to-date run* (`build-uptodate.log`): `build: OK — all 1887 modules already up to date, nothing built, 3
  module(s) with warnings, 3s`. Lake replays each cached module's messages: it replays the same thirteen for
  `Algebraic`, `Fractional`, `Pair` and **none for `Defs` or `InvariantLaw`** — so `Defs`, compiled in the stopped
  run, is current and carries no warning.
- `sorry` in the two files: 0 and 0.

**3.2 No statement changed** (Done, item 5), from the kernel's side, on the built tree. `tools/fs133_ib2_moved.py`
(FS133-IB1's reader with this job's verdicts: a constant's module is read; a moved constant must be identical and in
another module; a deleted one must be private and absent; a definition whose proof field was filled must keep its
stored type and read the same with proof arguments erased; `--strict`: nothing may move even in instance arguments).
- **The two modules** — `moved/before.out.xz` (stage 1) against `moved/built.out.xz` (`moved/before-to-built.txt`):
  **80 constants: 76 IDENTICAL, 1 MOVED-IDENTICAL, 1 PROOF-FILLED, 2 DELETED; `MOVED OK`.**
  - `OneClass.countable_algPlane`: its stored type identical in the full print, compiled in `Defs`, no longer in
    `InvariantLaw` — Amendment 1.
  - `OneClass.algPlaneEmbedding`: stored type identical; the stored value differs only in its one proof argument,
    `map_rel_iff'` — the `sorryAx` term before, the generated `algPlaneEmbedding._proof_2` after (`LEAN.md`: a
    definition that holds proofs as fields moves its value when a field is proved). Its data field `toFun` is the
    same term; the proof's type is fixed by `RelEmbedding.mk`'s, whose other arguments are identical.
  - Deleted: `InvariantLaw`'s private `card_le_indepNum_induce` and `exists_indep_subset` (item 4).
  - New: the seven private helpers of `Defs` (the two bridge lemmas, `upperDensity_congr_ae`, `measurable_shiftLab`,
    `measurable_turnLab`, `kCoeff_one'`, `kCoeff_mul'`). Every constant compiled in `Defs` is under a declaration of
    the file (`all-constants-built.out`: 75 constants; the generated ones are `eq_1` of its own five definitions,
    `_proof_n`, `_simp_n`, `_flat_ctor`; none for an upstream definition — `unfold upperDensity` generated none).
- **`InvariantLaw` against its implementer's last dump** (`data/fs133/ib1/moved/built.out.xz`, the module's 31
  constants; `moved/ib1-built-to-built.txt`): **28 IDENTICAL, 1 MOVED-IDENTICAL (`countable_algPlane`), 2 DELETED;
  `MOVED OK`.** (Stage 1's dump against the same: 31 IDENTICAL, `moved/before-vs-ib1-built.txt` — the tree was as
  handed back; and `Defs`'s 49 against FS133-IB1's eight-module dump: 49 IDENTICAL, `moved/before-vs-ib1-eight-defs.txt`.)
- **All eight modules of the milestone** (FS133-IA1's dumper, run read-only, `moved/eight-built.out.xz`, against
  FS133-IB1's `eight-built.out.xz`; `moved/eight-ib1-to-built.txt`): **114 constants: 112 IDENTICAL, the same 1
  MOVED-IDENTICAL and 1 PROOF-FILLED; nothing new.** So `countable_algPlane` is **the only declaration of the eight
  modules whose module changed**, and nothing downstream moved, not in an instance argument.
- **Controls.** On the reader (`moved/control-built.txt`): eleven plants — a constant changed in both prints, in the
  full print only under `--strict`, a constant removed, a theorem made an axiom, an unlisted constant moved to another
  module, the moved constant's print changed, the moved constant left in its old module, each deleted private put
  back, the filled definition's erased value changed, its type changed — each failed the run and was named; the
  unplanted run: no failure. **End to end** (`plant/`): a copy of `Defs` elaborated with the footer at another path
  reads **50 of 50 public constants IDENTICAL** to the compiled module (`plant/copy-verdict.txt`); the same copy with a
  hypothesis `(_hplant : (0 : ℕ) = 0)` added to `finIndepRatio_le_one` reads `DIFFERENT … finIndepRatio_le_one`,
  `MOVED FAILED: 1`, exit 1 (`plant/planted-verdict.txt`).
- **No ruled difference** of the kind the standing word allows: no binder of a statement of `Defs` is unread.

**3.3 The axioms of every public declaration** (Done, item 5). `data/fs133/ib2/lean/Axioms.lean` →
`axioms-built.out`; `tools/fs133_ib2_axioms.py` (FS133-IB1's reader, unchanged) against `axioms-expect.tsv` (all
CLEAN by the plan's § 5.5): **34 records — `Defs`'s 25 (16 theorems, 6 definitions, 3 structures) and
`InvariantLaw`'s 9 — all `[propext, Classical.choice, Quot.sound]`, `AXIOMS OK`** (`axioms-verdict.out`). None prints
`sorryAx` or the declared outside theorem. Controls: on the reader, a `sorryAx` in a clean record, the import in a
clean record and a record removed are each reported (`axioms-control.out`); end to end, a theorem on `sorry` planted
beside the 34 (`lean/AxiomsPlanted.lean`) prints `[sorryAx]` and is reported, exit 1 (`axioms-planted-verdict.out`).

**3.4 Not run here** (the landing's, on the joined tree): `scripts/axioms.sh`, `vacuity.sh`, `dupnames.sh`,
`assumptions.sh`, `lake lint`. Every private helper's name carries its module, so none can double a public name;
`dupnames.sh` on the joined tree is still what shows it.

## Drafts for the landing (files this job does not write; each names its slot)

**DC1. `scripts/Axioms.lean`, under CLEAN** — the block `data/fs133/ib2/axioms-block.txt`, appended where the waves
append their CLEAN records (above the PURCHASED banner, after FS133-IB1's block DB1): its header comment and 25
`#print axioms` lines, one per public declaration of `Plane/OneClass/Defs` (16 theorems, 6 definitions, 3
structures). **FS133-IB1's block DB1 (`data/fs133/ib1/axioms-block.txt`) then loses its line
`#print axioms HadwigerNelson.OneClass.countable_algPlane`** (the declaration is now `Defs`'s and in this block; its
header's count reads 18 records, 17 theorems and the definition, for the two modules it names). No line goes under
IMPORTED: no record of `Defs` rests on the declared outside theorem (stage 3; the plan's § 5.5).

**DC2. The model for each hypothesis** (`LEAN.md` § The gate). No model was added as a declaration: a public
declaration is outside this job's touches, and the file already ships two (`isInvariantLaw_dirac`,
`IsInvariantLaw.isPlaneSystem`). Each note names a library theorem or a term that inhabits the hypotheses all at
once, at a parameter nothing refutes.
- **`IsPlaneSystem P τ ρ` — the hypothesis of the field theorem `OneClass.exists_field` (`Plane/OneClass/Field`)**:
  **`IsInvariantLaw.isPlaneSystem`** is its model in the kernel, on the standard three — the labellings of the
  algebraic plane with `shiftLab`, `turnLab` and any invariant law. The law that exercises the field theorem's clause
  (c) (FS133-IA1's draft D2) is **the law of `exists_isInvariantLaw_unitDistance`** (`Plane/OneClass/InvariantLaw`,
  kernel, standard three): with `ι := Unit` and `f ℓ := if ℓ 0 then 1 else 0` (measurable, `[0, 1]`-valued, fixed by
  `turnLab u` because `kCoeff u * 0 = 0`), the premise of clause (c) holds at `z := 1` (`‖1‖ = 1`, so the law's
  independent sets never hold both `0` and `1`), and the observable is not almost surely `0`: its mean is the law's
  density, the ratio of `unitDistance E`, at least that of `unitDistance ℂ` (`finIndepRatio_le_of_embedding` at
  `algPlaneEmbedding`) and so at least `1/7` (`inv_le_finIndepRatio_of_colorable` at `HadwigerNelson.plane_colorable_seven`,
  `Instances/Seven`). The point mass at the empty labelling (`isInvariantLaw_dirac`) is
  a model of the fields where clause (c) is met only trivially (its observable is `0`).
- `IsShiftInvariantLaw G P`, `IsInvariantLaw G P`: `isInvariantLaw_dirac G` (every graph, density `0`) and, at
  `G := unitDistance E`, the law of `exists_isInvariantLaw_unitDistance` (density the ratio, positive).
- `finIndepRatio_le_of_embedding` (`f : G ↪g G'`): `algPlaneEmbedding` (this file).
- `inv_le_finIndepRatio_of_colorable` (`h : G.Colorable k`): `unitDistance ℂ` at `k := 7`
  (`HadwigerNelson.plane_colorable_seven`, `Instances/Seven`).
- `finIndepRatio_le_of_forall_card_le` (`hS`, `h`): `S := {0, 1}` in `unitDistance ℂ`, `a := 1` (the two points are
  at distance one, so an independent subset has at most one); and any singleton at `a := 1`, which is the proof of
  `finIndepRatio_le_one`.
- `finIndepRatio_le_one` (`[Nonempty V]`): any graph on a nonempty type.
- `upperDensity_le_mOne` (`hA`, `hind`): `Metric.ball 0 (1/2)` with `measurableSet_ball` and `isIndepSet_ball_half`.
- `le_finIndepRatio_iff`, `inv_finIndepRatio_le_iSup_fractionalChromaticNumber`, `isIndepSet_unitDistance_iff`,
  `mOne_le_iff`, `mOne_le_one`, `mOne_eq_iSup_nullMeasurableSet`, `minIndepNum_one`, `countable_algPlane`: no
  hypothesis that is a structure.
- The vacuity scan will read the binders `GENERIC` (no colouring binder of a tracked predicate; the law structures
  are this file's). The assumptions step: no hypothesis of this file stands for an outside theorem or a hand result.

**DC3. `data/fs133/claims-K1.md`** (the coordinator's file; the dated line for Amendment 1) — one constant moved:

| constant | from | to | stored type | ruling |
|---|---|---|---|---|
| `HadwigerNelson.OneClass.countable_algPlane` | `Plane/OneClass/InvariantLaw` | `Plane/OneClass/Defs` | identical in the full print (stage 3) | Amendment 1, option (a) |

**DC4. `ARCHITECTURE.md` § 3**, the rows of the two modules:
- `Plane/OneClass/Defs`: "**FS-133 (FS133-K1; a skeleton).**" → "**FS-133 (FS133-K1's statements, FS133-IB2's
  proofs; no `sorry`).**"; and the row gains "`countable_algPlane` (the algebraic plane is countable; moved here from
  `InvariantLaw`, FS133-IB2)". Its imports cell is unchanged: no import was added.
- `Plane/OneClass/InvariantLaw`: its row does not name `countable_algPlane`, so the move changes nothing in it
  (FS133-IB1's draft DB5 for that row stands).

**DC5. `LEAN.md` § Searching — Lean**, new bullets:
- "A point mass on `E → Bool` sees single labellings only when the index set is countable: `ae_dirac_eq` asks
  `MeasurableSingletonClass`, which `Pi.instMeasurableSingletonClass` gives from `Countable E`; with an uncountable
  index set a product-measurable set depends on countably many coordinates and `{I | ∃ z, I z = true}` has
  point-mass one at the empty labelling. `Countable` of the algebraic numbers with no `Mathlib.Algebra.AlgebraicCard`:
  `ℚ[X]` injects into `List ℚ` by the first `natDegree + 1` coefficients, and each algebraic number is in
  `p.rootSet ℂ` for a nonzero `p` (`Polynomial.rootSet_finite`, `Polynomial.mem_rootSet`;
  `OneClass.countable_algPlane`, FS133-IB2)."
- "`fun J => G.IsIndepSet (J : Set E)` as a `Finset.filter` predicate on `S.powerset` elaborates `J : Set E` from the
  ascription and the filter then fails ('expected `Finset (Set E)`'): annotate the binder, `fun J : Finset E => …`
  (FS133-IB2)."
- "An implementer's working module that imports a module it has just changed cannot be elaborated by `lake env lean`
  until the build recompiles the import; a farm (a symlink copy of the tree's `.lake/build/lib/lean`, the changed
  module compiled with `lean -o` over its removed symlink) elaborates it in seconds with the build's own library
  untouched (`data/fs133/ib2/farm1.sh`, FS133-IB2)."
