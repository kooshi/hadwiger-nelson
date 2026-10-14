# FS133-IPQ1 — the density equality's last two leaves: `Plane/OneClass/Pair`, Q4 and Q5

*de Bruijn, the implementer; job FS133-IPQ1 (brief: `data/fs133/briefs/FS133-IPQ1-pairs.md`, on `main`). Branch
`fs133-wpq`, cut from `b84e09ef8` (FS133-ICD1's head, branch `fs133-wcd`) in the worktree `.claude/worktrees/fs133-wk1`.
The plan is `plans/FS133-kernel-plan.md` § 5.4 (lane D: Q4, Q5) with § 5.5; FS133-ICD1's record § 1.3 and § 4.5.
Working files: `data/fs133/ipq1/`. Files this job writes: `Plane/OneClass/Pair.lean` (proofs and private helpers
only), possibly a new module under `Plane/OneClass/` for the two new pieces, this record, the report.*

## Theorems this phase proved

Each [kernel], printed from the built tree (stage 4.3; `data/fs133/ipq1/axioms-built.out`); statements FS133-K1's,
one binder dropped (stage 3.3, ruled by the standing word of item 726); proofs this job's. "Std" is
`[propext, Classical.choice, Quot.sound]`; "Std + RF" is those and the declared outside theorem
`HadwigerNelson.Outside.OAI158.Spectral.residual_fourier`.

`Proofs/HadwigerNelson/Plane/OneClass/Pair.lean`:
- `OneClass.exists_measurable_admissibleAe` (Q4) — C133-PAIR forward: a labelling of the algebraic plane admissible
  for an algebraic pattern gives a labelling of the plane with Borel fibres admissible almost everywhere. Std + RF.
- `OneClass.exists_admissibleOn_of_ae` (Q5) — C133-PAIR converse: a labelling with Lebesgue-measurable fibres
  admissible almost everywhere, for a pattern at positive distances (no countability, no algebraicity), gives a
  labelling admissible at every pair. Std.
- With these, both clauses of **C133-PAIR** have no `sorry` beneath them: `OneClass.exists_admissibleOn_univ_iff_ae`
  and `OneClass.exists_admissibleOn_univ_iff_algPlane` — each Std + RF.
- Six private helpers (not records): `kCoeff_one_pair`, `kCoeff_mul_pair`, `isPlaneSystem_lab`, `dist_kCoeff_mul`,
  `exists_slice_ne_zero`, `prod_pairs_ne_zero`.

The module `Plane/OneClass` now has no `sorry`.

## Stage 1 — SAVED: the readback, the leaves restated, the stored statements dumped before any edit

**1.1 The brief's quotations.** `tools/fs133_ipq1_readback.py` (FS133-ICD1's reader with this job's brief; each quoted
line a substring of its source, read in the coordinator's tree): **4 matched, 0 mismatched**, exit 0
(`data/fs133/ipq1/readback-brief.out`) — W2 against `data/fs131/REQUEST-2026-10-13.md`; K133-PAIR and K133-NC-PAIR
against `data/fs133/claims-K1.md`; inventory item 779 against `plans/FS131-close-inventory.md`. With `--fault` (the
last character of each quoted line changed): 0 matched, 4 mismatched, exit 1 (`readback-brief-fault.out`). No finding
about the brief's quotations.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make the
gate fail; the agent file's workflow; the plan's §§ 4.1, 5.0–5.5; FS133-ICD1's record whole; `Pair.lean` whole; the
derivation's entry C133-PAIR with § Argument and § Converse (`plans/FS133-E1-derivation.md` ll. 637–763, on `main`).

**1.3 Each leaf, in one line, beside the plan's route.** The file's text is the statement; the line is a reading.

| leaf | the statement, in one line | the plan's route (§ 5.4) |
|---|---|---|
| **Q4** `exists_measurable_admissibleAe` | for a finite `Λ` and an algebraic pattern `N`, a labelling admissible on `E` gives a labelling `ℓ'` of `ℂ` whose every fibre is Borel and which, at each `r`, has no forbidden pair at `(x, x + r e^{iθ})` for `(Leb ⊗ arc)`-almost every `(x, θ)` | `exists_invariant_of_closed` on the closed set of admissible labellings of `E`; `exists_field` at `ι := Λ` with the indicators of `{ℓ 0 = a}`; clause (c) at `z := r ∈ E`; Tonelli over the countable `(r, a, b)`; fix `ω`; the least `a` with `H a (x, ω) > 0` where the sum is `1` (the release's `positiveSelect`) |
| **Q5** `exists_admissibleOn_of_ae` | for a finite `Λ` and a pattern whose constrained distances are countable and positive, a labelling with null-measurable fibres admissible almost everywhere gives a labelling admissible at every pair of points of `ℂ` | density-point cores of the fibres; a two-set, radius-`r` density-point lemma; every finite set has a translate inside the conull union of the cores (`exists_translate_mem`); Rado selection (`Finset.rado_selection`) for the pattern |

**1.4 The stored statements before any edit.** The build as the last implementer left it: `lake build --no-build`
under the slot reads `All targets up-to-date (6048 jobs)`, exit 0 (`data/fs133/ipq1/nobuild-before.log`; it replays
`Pair`'s two `sorry` warnings, ll. 106 and 114). `data/fs133/ipq1/lean/StatementDump.lean` (FS133-ICD1's dumper, its
body unchanged, the module list all seven modules of `Plane/OneClass`) prints every named constant of the seven from
their compiled data, in the full print and the print with instance and proof arguments erased:
`data/fs133/ipq1/moved/before.out.xz` (sha256 in `before.sha256`) — **`SectionDensity` 9 named and 3 private, `Defs`
53 and 4, `InvariantLaw` 9 and 19, `Field` 1 and 30, `Algebraic` 9 and 1, `Fractional` 7 and 11, `Pair` 19 named and
0 private; 175 in all**; no `ABSENT`. This job edits only `Pair`; the other six are dumped to show them untouched.

## Stage 2 — SAVED: Q4 proved; Q5 re-priced

**2.1 Q4 `exists_measurable_admissibleAe` — proved**, on the plan's route, in `Pair.lean` itself (no new module), with
four private helpers:
- `kCoeff_one_pair`, `kCoeff_mul_pair` — the rotation coefficients multiply (copies of `Defs`' private
  `kCoeff_one'`, `kCoeff_mul'`, under names of their own);
- `isPlaneSystem_lab` — a law on `E → Λ` invariant under `shiftLab` and `turnLab` is a plane system (the
  `Λ`-valued form of `IsInvariantLaw.isPlaneSystem`, whose measurability helpers are private to `Defs`);
- `dist_kCoeff_mul` — the algebraic rotations preserve distances (from `norm_kCoeff_mul`).

The proof, step by step against the derivation's F1–F6. `Λ` gets the discrete topology and the full σ-algebra
locally (`letI`), as `exists_invariant_of_closed` asks; nothing of either reaches the statement. **(F1)** `C`, the
labellings `m : E → Λ` with `¬ N (dist ↑x ↑y) (m x) (m y)` for all `x y : E`, is closed (an intersection over pairs of
preimages of a set of the discrete `Λ × Λ` under the continuous `m ↦ (m x, m y)`), nonempty (the restriction of `ℓ`),
and preserved by `shiftLab` (`dist_add_right`) and `turnLab` (`dist_kCoeff_mul`); `exists_invariant_of_closed` gives
`P`, carried by `C`. **(F2)** `f a m := if m 0 = a then 1 else 0`, measurable, in `[0, 1]`, fixed by `turnLab`
(`kCoeff u * 0 = 0`). **(F3–F5)** `exists_field` at `ι := Λ`: the affine clause at `c = 1, d = 1` gives
`∑ a H a (x, ·) = 1` almost surely at every `x`; for `N r a b`, `z := (r : E)` (`r` algebraic:
`IsAlgebraic.algebraMap`, `mem_algebraicClosure_iff`; nonzero as `r > 0`), the premise `f a · f b ∘ shiftLab z = 0`
holds on `C` (`dist ↑0 ↑z = r`), so the products vanish at every `x` and every `w = r e^{iθ}`. **(F6)** Tonelli twice,
as `exists_measurable_indep_of_field` does (`Measure.prod_apply_symm`, `Measure.measure_ae_null_of_prod_null`): almost
every `ω` has a null set of forbidden pairs `{(x, θ) | 0 < H a (x, ω), 0 < H b (x + r e^{iθ}, ω)}` for every
`(r, a, b)` with `N r a b` — countably many: `ae_all_iff` over `{r | ∃ a b, N r a b} × Λ × Λ`, countable by
`IsAlgPattern.countable` — and a null set `Bad` of points where no field is positive. One such `ω` is fixed. **The
labelling**: `ℓ' x := g (pos x)` with `pos x a := decide (0 < H a (x, ω))` and `g S` a label `a` with `S a = true`
if there is one (`Exists.choose`), else `ℓ 0` — no order on `Λ` is needed; `ℓ'` is Borel as a function of a finite
type composed with a measurable map (`measurable_of_finite`, `measurable_to_bool`), so every fibre is Borel. Off
`Bad`, `H (ℓ' x) (x, ω) > 0`. Admissibility almost everywhere: the pairs with first endpoint in `Bad` are null
(`Measure.quasiMeasurePreserving_fst`), with second endpoint in `Bad` null (each `θ`-section is a translate of
`Bad`, `measure_preimage_add_right`), and the rest lie in the null sets of forbidden pairs.

**Its axioms**, from a copy of the file with a `#print axioms` footer (`data/fs133/ipq1/work/PairAx.lean`, output
`PairAx-q4.out`): `[propext, Classical.choice, Quot.sound, HadwigerNelson.Outside.OAI158.Spectral.residual_fourier]`
— the plan's § 5.5 list for it. Elaborated under `lean1.sh` (the lakefile's options): no error, one warning, Q5's
`sorry`.

**2.2 Q5 re-priced.** Q4 closed in six elaborations of about 3–4 s each against the plan's 6–10 h. Q5's two new
pieces, both as private helpers in `Pair.lean`: (i) a two-set, radius-`r` density-point lemma — if `x` is a
density-one point of `A`, `y` of a Lebesgue-measurable `B`, and `‖y − x‖ = r > 0`, then
`{(x', θ) | x' ∈ A, x' + r e^{iθ} ∈ B}` has positive `Leb ⊗ arc` measure: the comparison of
`dist_ne_one_of_mem_densitySet` (`Plane/DensityPoints`) run for two sets and a radius, its sections taken without
measurability (`Measure.measure_ae_null_of_prod_null` after `Measure.prod_swap`); (ii) the extension — simpler than
the library's `exists_proper_ae_eq_of_proper_on_conull`, because Q5 asks no agreement with `ℓ'`: one conull set `T`
of points that are density-one points of their own fibre, a translate of every finite set into `T`
(`exists_translate_mem` at `V x = T`), and `Finset.rado_selection`. **Re-priced at one long stage for both**; neither is
larger. **A binder the route does not read:** `hcount` (the countability of the constrained distances) — the converse
reads each distance's null set alone (the derivation's § Converse never takes a union over distances; the forward
direction does). If the proof confirms it, the binder is dropped under the standing word of item 726, and named.

## Stage 3 — SAVED: Q5 proved, with its two new pieces; one unread binder dropped

**3.1 The two new pieces**, private helpers in `Pair.lean` (no new module: no other file reads them).
- **(i) `exists_slice_ne_zero`** — *two density-one points see each other in a set of positive measure*: if `x` is a
  density-one point of `A` and `y` of a Lebesgue-measurable `B` (`HasDensityOneAt volume`, closed balls), then for
  some `ρ > 0` every `v` with `‖x + v − y‖ ≤ ρ` has `volume {x' | x' ∈ A ∧ x' + v ∈ B} ≠ 0`. The comparison of
  `Plane.dist_ne_one_of_mem_densitySet` for two sets: at a radius `ρ` where `A` fills more than half of
  `B(x, ρ)` and `B` more than seven eighths of `B(y, 2ρ)`, the points of `A ∩ B(x, ρ)` moved by `v` land in
  `B(y, 2ρ)`, so a null slice would put more than half of `B(x, ρ)` inside `B(y, 2ρ) ∖ B`, which has less than an
  eighth of `4 |B(x, ρ)|` (`measure_inter_add_sdiff₀` — the one use of `B`'s measurability; `volume_real_closedBall`).
- **(ii) `prod_pairs_ne_zero`** — *the density-point step for a radius*: with `x`, `y` as in (i) and `dist x y = r > 0`,
  `(Leb ⊗ arc) {(x', θ) | x' ∈ A ∧ x' + r e^{iθ} ∈ B} ≠ 0`. The direction `θ₀` from `x` to `y`
  (`exists_angle_of_norm_eq_one`), an interval of directions of length `min (ρ / r) π` about it inside `[0, 2π)`
  (`exists_interval_near`), whose displacements `r e^{iθ}` move `x` to within `ρ` of `y` (`norm_e_sub_e_le`), so each of
  its slices is not null by (i); a null set of pairs would have almost every direction's slice null — with no
  measurability of the set: `Measure.measurePreserving_swap` pulls the null set back
  (`QuasiMeasurePreserving.preimage_null`), and `Measure.measure_ae_null_of_prod_null` reads its sections — so the
  interval would be null.
- **The extension** needs no lemma of its own: Q5 asks for no agreement with `ℓ'`, so the proof takes one conull set
  `T` and `exists_translate_mem` at `V x = T` (density one everywhere, `hasDensityOneAt_congr_ae`), and
  `Finset.rado_selection` at `F x ↦ ℓ' (x + ξ F)`, in the body of Q5.

**3.2 Q5 `exists_admissibleOn_of_ae` — proved.** `T := {x | x is a density-one point of ℓ'⁻¹{ℓ' x}}` is conull
(`Besicovitch.ae_tendsto_measure_inter_div` per label, as `ae_hasDensityOneAt_fibre`; `ae_all_iff` over the finite
`Λ`); `ℓ'` is admissible at every pair of `T` — a forbidden pair `x, y ∈ T` at distance `r` (`r > 0` by `hpos`) would
make the set of (ii) for the fibres of `ℓ' x` and `ℓ' y` a subset of `AdmissibleAe`'s null set at `r`; every finite
`F` has a translate `F + ξ F ⊆ T`; Rado selection gives `χ` agreeing on each pair `{x, y}` with some `ℓ' (· + ξ t)`, and
`dist (x + ξ) (y + ξ) = dist x y` carries the pair into `T`. Elaborated under `lean1.sh`: **no error and no warning;
no `sorry` in the file** (`data/fs133/ipq1/work/pair-lean1.out`). First elaboration of the two pieces and Q5 closed
them; the second dropped the binder.

**3.3 A ruled difference (the standing word of item 726).** The first elaboration of the proved file warned
`Variable name hcount is not explicitly referenced` at `exists_admissibleOn_of_ae`'s binder
`(hcount : {r | ∃ a b, N r a b}.Countable)` — the route reads each distance's null set alone. **Dropped**; the two
clauses of C133-PAIR, which passed it `hN.countable`, now do not (proofs only); the theorem's docstring's last
sentence reads "The distances need not be algebraic, nor countably many: each distance is read alone." (was: "The
distances need not be algebraic."). The statement is stronger by one hypothesis; no other statement or docstring
changed. Stage 4's comparison names it.

**3.4 The axioms of `Pair`'s four open records**, from a copy with a footer (`data/fs133/ipq1/work/PairAx.lean`,
output `PairAx-q5.out`): `exists_admissibleOn_of_ae` on `[propext, Classical.choice, Quot.sound]`;
`exists_measurable_admissibleAe`, `exists_admissibleOn_univ_iff_ae`, `exists_admissibleOn_univ_iff_algPlane` on those
and `HadwigerNelson.Outside.OAI158.Spectral.residual_fourier` — each the plan's § 5.5 list. The build of record and the
receipts from the built tree are stage 4.

## Stage 4 — SAVED: the build of record, and every receipt from the built tree

**4.1 The build** (Done, item 4). `data/fs133/ipq1/build.sh build-record` (the slot at 10 GiB and 4 cpus,
`MEMMAX=10G BATCH=8`): **`build: OK — 249 of 249 batches, 2 module(s) rebuilt, 0 module(s) with warnings, 7m16s`**,
exit 0 (`data/fs133/ipq1/build-record.log`, full output `build-record-full.log`): `✔ Built
Proofs.HadwigerNelson.Plane.OneClass.Pair (4.4s)` and `Proofs` — **no warning from `Pair`**. `sorry` in the seven
files of `Plane/OneClass`: 0 each (`grep -c`); in `Outside/OAI158Transfer`, one line, a docstring saying "no
`sorry`". No generated constant from another module's definition: every constant compiled into `Pair`'s `.olean`
listed (`data/fs133/ipq1/lean/PairConstants.lean` → `pair-constants-built.out`, 32): the 19 named of the dump, the six
private helpers, `AdmissibleAe._proof_1`, two `_simp_1_*` auxiliaries inside this job's proofs and
`admissibleOn_colourPattern_iff._simp_1_3`, `IsAlgPattern.mk._flat_ctor`; the two `eq_1` lemmas are of `Pair`'s own
definitions (`AdmissibleOn`, `colourPattern`) and were there before (24 constants before: 32 = 24 + 6 + 2).

**4.2 No statement changed but the ruled one** (Done, item 4), from the kernel's side.
`tools/fs133_ipq1_moved.py` (FS133-ICD1's reader, its verdicts unchanged, with one more ruled verdict,
`--binder-dropped=N:B`: the second dump's full print must equal the first's with the leading-spine binder `B` removed
and every de Bruijn index beneath it that points past it lowered by one — an index pointing at it fails — and the
erased print the same with every local `@m` after the binder lowered; a small parser of the dump's print, which
round-trips all 404 prints of the first dump). `--strict --binder-dropped=HadwigerNelson.OneClass.exists_admissibleOn_of_ae:hcount`,
`moved/before.out.xz` (stage 1) against `moved/built.out.xz` (sha256 in `built.sha256`):
**175 constants — 174 IDENTICAL, 1 BINDER-DROPPED (`exists_admissibleOn_of_ae`); `MOVED OK`**; new: the six private
helpers, nothing public (`moved/before-to-built.txt`). The other six modules: every constant IDENTICAL.
**Controls** (`moved/control-built.txt`): nine plants — the dropped binder left in, another change beside the drop,
the named binder absent from the first print, the dropped binder read in the first print (checked separately to land
on the verdict `DROPPED-BUT-BINDER-READ`), and FS133-ICD1's five (a constant changed in both prints, in the full print
only under `--strict`, removed, made an axiom, moved to another module) — each fails the run and is named; unplanted,
no failure. **End to end** (`data/fs133/ipq1/plant/`): a copy of the final `Pair` elaborated with FS133-IB2's footer at
another path reads **19 of 19 IDENTICAL** to the compiled module (`copy-verdict.txt`); the copy with `hcount` put back
(and passed by the two callers) reads `DIFFERENT … exists_admissibleOn_of_ae`, `MOVED FAILED: 1`, exit 1, against the
compiled module (`planted-verdict.txt`) — **and 19 of 19 IDENTICAL against the dump made before any edit**
(`planted-vs-before.txt`): the statement with the binder restored is the statement FS133-K1 stored, so the drop is
the only stored difference, by a second route; the copy against the first dump under the ruled verdict reads
BINDER-DROPPED 1, IDENTICAL 18 (`copy-vs-before.txt`). **The ruled difference**: one, the binder `hcount` of
`exists_admissibleOn_of_ae` (stage 3.3).

**4.3 The axioms of every public declaration of the module** (Done, item 4). `data/fs133/ipq1/lean/Axioms.lean`
(FS133-ICD1's 125 records, list unchanged) → `axioms-built.out`; `tools/fs133_ipq1_axioms.py` (FS133-ICD1's reader,
unchanged but its first line) against `axioms-expect.tsv` (FS133-ICD1's table, its four OPEN rows given their final
kinds by the plan's § 5.5: `exists_admissibleOn_of_ae` CLEAN, the other three IMPORTED): **125 records — 111 on the
standard three, 14 on those and `Spectral.residual_fourier`, none on `sorryAx`; `AXIOMS OK`** (`axioms-verdict.out`) —
every record matches § 5.5, and no record of its standard-three list prints the import. Controls
(`axioms-control.out`): a `sorryAx` in a clean record, the import in a clean record, the import missing from an
imported record, a record removed — each reported; end to end, a theorem on `sorry` planted beside the 125
(`lean/AxiomsPlanted.lean`) prints `[sorryAx]` and is reported, exit 1 (`axioms-planted-verdict.out`).

**4.4 The models, checked** (`data/fs133/ipq1/work/Models.lean` → `Models.out`, no error, no warning): the brick
colouring meets `exists_admissibleOn_of_ae`'s and `exists_measurable_admissibleAe`'s hypotheses at once at
`colourPattern (Fin 7)` and both conclusions are reached from it; the private helpers' hypotheses, written out, are
met by `univ` with `x = 0, y = 1, r = 1`, and by the point mass of a constant labelling.

**4.5 The environment linters — one failure, not in `Pair`.** `lake lint --no-build -- --no-build --trace` under the
slot (`data/fs133/ipq1/lint.out`): exit 1, **one message, `unusedArguments`, at
`HadwigerNelson.Plane.ofReal_integral_le_measure_pos` (`Plane/OneClass/SectionDensity.lean` l. 156): "argument 4:
[MeasureTheory.IsProbabilityMeasure μ]"** — FS133-IB1's module (its last commit `9e779ee61`), outside this job's
touches; the inequality holds for any measure, so the binder is unread, and dropping it changes a stored statement
of `SectionDensity`. Every other linter passed; no message names `Pair`. Held for the coordinator.

**4.6 Not run here** (the landing's, on the joined tree): `scripts/axioms.sh`, `vacuity.sh`, `dupnames.sh`,
`assumptions.sh`. Every private helper's name carries its module.

## Drafts for the front page (files this job does not write; each names its slot) — Stage 5, SAVED

*The gate's counts for `CLAUDE.md` § The gate and § Trust ledger are the landing's, from the whole-library gate on the
joined tree (stage 4.6); this job's contribution to them is DQ1's four records. C133-PAIR has no ledger row (it is
the derivation's entry; row 129 carries C133-ONE, whose regrade FS133-ICD1's DD4 drafted), so no row is regraded
here; DQ3 is its front-page sentence.*

**DQ1. `scripts/Axioms.lean`** — the four records FS133-ICD1's block DD1 held back (`data/fs133/icd1/axioms-block.txt`,
its last five lines, commented). Under **CLEAN**, appended to FS133-ICD1's CLEAN block for the three files (which
then holds 16 records):

```
#print axioms HadwigerNelson.OneClass.exists_admissibleOn_of_ae
```

Under **IMPORTED**, appended to FS133-ICD1's IMPORTED block (which then holds 12 records, each on the standard three
and `HadwigerNelson.Outside.OAI158.Spectral.residual_fourier` and on nothing else):

```
#print axioms HadwigerNelson.OneClass.exists_measurable_admissibleAe
#print axioms HadwigerNelson.OneClass.exists_admissibleOn_univ_iff_ae
#print axioms HadwigerNelson.OneClass.exists_admissibleOn_univ_iff_algPlane
```

The block's line "-- NOT YET FILED: … once proved, the first under CLEAN, the other three under IMPORTED" is then
deleted. (A correction owed in that draft line: its own tags, and FS133-ICD1's record DD1, put the **second** record,
`exists_admissibleOn_of_ae`, under CLEAN and the first under IMPORTED; the printed axioms agree with the tags.) With
these four the module's audit reads 125 records: 111 on the standard three, 14 on those and the import, none open.
The private helpers this job added (`kCoeff_one_pair`, `kCoeff_mul_pair`, `isPlaneSystem_lab`, `dist_kCoeff_mul`,
`exists_slice_ne_zero`, `prod_pairs_ne_zero`) are not records.

**DQ2. The model for each new hypothesis** (`LEAN.md` § The gate; checked by the elaborator in a scratch file,
`data/fs133/ipq1/work/Models.lean`, `Models.out`). No public statement gained a hypothesis; `exists_admissibleOn_of_ae`
lost one (`hcount`). FS133-ICD1's DD2 names the model of every public hypothesis of `Pair`; it stands, with
`exists_admissibleOn_of_ae`'s now `hpos`, `hm`, `h`: the brick colouring `sevenBrick.color` at
`colourPattern (Fin 7)` (`exists_admissible_colourPattern_seven`; `hpos` from `isAlgPattern_colourPattern`, `hm` from
its Borel fibres), and from it both conclusions are reached in the scratch file. The private helpers' hypotheses,
each met by one object at once: `exists_slice_ne_zero` and `prod_pairs_ne_zero` — `A = B = univ` (null-measurable,
density one everywhere, `hasDensityOneAt_univ`), `x = 0`, `y = 1`, `r = 1`; `isPlaneSystem_lab` — the point mass of a
constant labelling (`Measure.map_dirac'`), and the law `exists_invariant_of_closed` gives inside Q4's proof;
`dist_kCoeff_mul` has none. The vacuity scan reads `Pair`'s binders `GENERIC` (no colouring binder of a tracked
predicate); the assumptions step has nothing to declare (no hypothesis of `Pair` stands for an outside theorem or a hand
result).

**DQ3. `CLAUDE.md` § Where the problem stands, "What the kernel holds, beyond the interval"**, a sentence following
FS133-ICD1's DD4 sentence on the density equality (its grade [kernel] on one declared outside theorem until the port
lands `residual_fourier` as a theorem; not on `main` and not through the gate until the landing):

"**Labellings with forbidden pairs of labels at algebraic distances** (FS-133, C133-PAIR): for a finite set of labels
and a pattern forbidding, at each of countably many positive algebraic distances, some ordered pairs of labels, the
plane has a labelling admissible at every pair of points if and only if the algebraic plane has one, and if and only if
the plane has a Lebesgue-measurable labelling admissible at almost every pair `(x, x + r e^{iθ})`
(`OneClass.exists_admissibleOn_univ_iff_algPlane`, `OneClass.exists_admissibleOn_univ_iff_ae`), on the declared
outside theorem `Outside.OAI158.Spectral.residual_fourier`, which only the direction from the algebraic plane to a
measurable labelling reads (`exists_measurable_admissibleAe`; its labelling has Borel fibres); the converse — a
Lebesgue-measurable labelling admissible almost everywhere gives one admissible at every pair, at any positive
distances, algebraic or not, countably many or not — is on the standard three (`exists_admissibleOn_of_ae`). For one
distance with equal labels forbidden this is `[OAIMath2026]` family 158's Theorem 1.3; the general pattern was not
found in print at the scope of the plan's § PA.2. Not claimed: any constraint on three or more points; in the forward
direction any distance that is not algebraic; infinitely many labels; that the measurable labelling resembles the one
started from; a measurable labelling admissible at every pair."

**DQ4. `ARCHITECTURE.md` § 3, the row of `Plane/OneClass/Pair`**: FS133-ICD1's DD3 draft for it
("**FS-133 (FS133-K1's statements, FS133-ICD1's proofs; … `Pair` two leaves, Q4 and Q5).**") becomes "**FS-133
(FS133-K1's statements, FS133-ICD1's and FS133-IPQ1's proofs; no `sorry`; one unread binder dropped from
`exists_admissibleOn_of_ae`, FS133-IPQ1).**"; its imports cell is unchanged (this job added no import).

**DQ5. `plans/FS133-kernel-plan.md`**, notes for the planner's record (§ 5.4): Q4 needed no port of the release's
`positiveSelect` — any choice of a label with positive field works, and the labelling is Borel as a function of the
finite type `Λ → Bool`; Q5's extension is not the library's `exists_proper_ae_eq_of_proper_on_conull` rerun but
simpler (no agreement with `ℓ'` is asked: one conull set, `exists_translate_mem` at `V x = T`,
`Finset.rado_selection`); Q5 reads no countability (`hcount` dropped); `davies_lemma_B1` was not an instance (its
`havoid` is one relation within one set; a pattern relates two sets).

**DQ6. `LEAN.md` § Searching — Lean**, new bullets.
- "A function from `ℂ` to a finite type is Borel with no case analysis when it factors through a measurable map into
  `Λ → Bool`: `measurable_pi_iff`, `measurable_to_bool` for each coordinate, then `measurable_of_finite` for the
  function out of `Λ → Bool` (`OneClass.exists_measurable_admissibleAe`, its choice of a label by `Exists.choose`)
  (FS133-IPQ1)."
- "Positivity of a product measure from its slices in the second factor, with no measurability:
  `(Measure.measurePreserving_swap).quasiMeasurePreserving.preimage_null` pulls a null set of `ℂ × ℝ` back to
  `ℝ × ℂ`, and `Measure.measure_ae_null_of_prod_null` reads its sections (`OneClass` Pair's `prod_pairs_ne_zero`)
  (FS133-IPQ1)."
- "`IsClosed.preimage` with a continuous map into `Λ × Λ` built inline by `(continuous_apply x).prodMk …` fails
  to unify the product's topology when `Λ`'s topology is a `letI`; name the map with its type ascribed
  (`Continuous (fun m : E → Λ => ((m x, m y) : Λ × Λ))`) and apply that (FS133-IPQ1)."
