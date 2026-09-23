# FS-73 phase P5: the kernel (`Proofs/HadwigerNelson/Kempe.lean`)

Implementer K (Opus 5.5), 2026-09-23, desktop. Brief: burn down the 22 `sorry`s of the §K skeleton in the order and by
the routes of the plan's §M.2 table, changing no statement. **Outcome: zero `sorry`. No statement changed. The module
is imported by `Proofs.lean`, and the build, axiom audit, vacuity gate and linter are green.**

## Theorems this phase proved

Every entry is **[kernel]**, proved in `Proofs/HadwigerNelson/Kempe.lean` on the standard three axioms (the audit
shows some on a subset of them). "Closed here" means the `sorry` was burned down in this phase. "Planner" means the
skeleton already held the proof and this phase closed the leaves beneath it.

| declaration | one-line statement | status |
|---|---|---|
| `kempeSwap` (its properness field) | exchanging colours `a`, `b` on a Kempe-closed set is a proper colouring | closed here |
| `swap_ne_of_mem_of_notMem_adj` (private, new) | across the boundary of a Kempe-closed set, a member's swapped colour differs from a non-member neighbour's | new helper, closed here |
| `kempeSwap_apply_of_mem`, `kempeSwap_apply_of_notMem` | the swap exchanges `a`/`b` on members and fixes non-members | closed here |
| `kempeSwap_ne_of_mem_of_notMem` | the swap separates a member from a non-member of the same colour | closed here |
| `not_forces_of_kempeClosed` | a Kempe-closed set holding `u` and missing `v` refutes `Forces G k u v` | closed here |
| `exists_coloring_ne_of_forall_finset` | de Bruijn–Erdős for a separated pair: separating functions, proper on every finset, glue into a separating colouring (by `Finset.rado_selection`) | closed here |
| `forces_iff_exists_finite` | **R1**: a pair is forced iff it is forced in some finite induced subgraph | closed here |
| `VoltageEscape.zero_mem_lift` | the origin lies in the certificate's lift | closed here |
| `VoltageEscape.add_mem_lift_iff` | the lift is a union of `V`-cosets | closed here |
| `VoltageEscape.kempeClosed` | the lift is Kempe-closed for the pulled-back colouring | closed here |
| `not_forces_of_voltageEscape` | **T10.1**: a target outside the lift escapes, `¬ Forces (addCayley S) k 0 δ` | planner (now sorry-free beneath) |
| `forces_iff_of_quotient_fanGap` | **T6**: one gapped quotient colouring gives `Forces ↔ =` on every graph mapping into the lattice graph | planner |
| `not_forces_of_additiveKempe` | **T2**: an additive colouring into a group of order `k` frees every target outside the pair-sum closure `R_b` | closed here |
| `mem_forcedSubgroup` | `δ ∈ F ↔ Forces (addCayley S) k 0 δ` | closed here |
| `periods_le_periods_comap_translate` | a translate of a colouring has at least its periods | closed here |
| `mem_periodicForcedSubgroup` | `δ ∈ P ↔` every periodic colouring identifies `0` and `δ` (H1 pointwise) | closed here |
| `ker_le_periods_comap` | a pulled-back quotient colouring is periodic under the kernel of the period map | closed here |
| `periodic_kempeSwap` | a swap on a `w`-invariant Kempe-closed set keeps the period `w` | closed here |
| `exists_finiteIndex_between_notMem` | in a finitely generated abelian group, `e ∉ V ≤ H` (finite index) is missed by some finite-index `W` with `V ≤ W ≤ H` | closed here |
| `notMem_periodicForcedSubgroup_of_voltageEscape` | **R3, escape direction**: an escape certificate at a finite-index period puts `δ` outside `P` | closed here |
| `voltageEscapeZ` (five proof fields) | the named inhabitant of `VoltageEscape`: the fan-gap case on `ℤ`, colours `0`/`2` in `Fin 3`, lift `{0}` | closed here |
| spec `example`s (three) | `2 ∉ voltageEscapeZ.lift`; the path `ℤ` has a periodic 2-colouring; `2 ∈ F ∧ 1 ∉ F` on the path | closed here |
| `kempeClosed_empty`, `kempeClosed_twoColour`, `VoltageEscape.enlarge`, `isPeriodic_comap`, `notMem_periodicForcedSubgroup_of_ne`, `forcedSubgroup_le_periodicForcedSubgroup`, `inheritanceQuestion_iff`, `periods`, `mem_periods` | as in §K | planner |

`InheritanceQuestion` is a `def` of a `Prop`, stated and not claimed, as §K requires.

## What each leaf cost, against its price

The plan priced the file at about 1.5 working days (§M.2). **It took about 40 minutes of active work.** About 25 of
those minutes were gate runs: four capped builds at about 3.5 minutes each, plus the axiom audit, the vacuity gate and
the linter, and one negative control on the linter. A login cut-off split the work into two sessions, 01:32–01:39 and
10:14–10:44 UTC. Every leaf closed on its first or second elaboration.

| leaf | price | actual | note |
|---|---|---|---|
| `kempeSwap` properness | 1 h | one pass | four cases; the boundary case became the private helper |
| apply lemmas | minutes | one pass | `show` the `if`, then `if_pos` / `if_neg` |
| `kempeSwap_ne_of_mem_of_notMem` | 30 min | two passes | the apply lemmas take `C` explicitly |
| `not_forces_of_kempeClosed` | minutes | one pass | |
| `exists_coloring_ne_of_forall_finset` | 2 h | one pass, after one import | needed `import Mathlib.Combinatorics.Compactness`, which replaced the unused `…SimpleGraph.Finsubgraph` |
| `forces_iff_exists_finite` | 2 h | one pass | contrapositive over `t ∪ {u, v}` with a default colour, as §M.2 says |
| `zero_mem_lift`, `add_mem_lift_iff` | 30 min | one pass | |
| `VoltageEscape.kempeClosed` | 2 h | one pass | `addCayley_adj'`, then `closed` and the voltage identity by `abel` |
| T2 `not_forces_of_additiveKempe` | 3 h | one pass | the longest proof (~55 lines); the choice-free set of the docstring works verbatim |
| `mem_forcedSubgroup` | 30 min | one pass | |
| `periods_le_periods_comap_translate`, `mem_periodicForcedSubgroup` | 1.5 h | two passes | the child was declared after its consumer; moved above it (order only) |
| `ker_le_periods_comap`, `periodic_kempeSwap` | 1 h | one pass | |
| `exists_finiteIndex_between_notMem` | **½ day (P-K1)** | **two passes, ~20 lines** | a different route from the plan's, below |
| R3 | 2 h | one pass | exactly §M.2's route over the children |
| `voltageEscapeZ` + escape `example` | 1 h | two passes | a trailing `decide` was dead after `simp` |
| the path examples | 2 h | one pass | `decide` over `ZMod 2`, `Fin 2` |

## Findings

1. **Residual finiteness through characters, not the structure theorem.** The plan's route rebuilt
   `AddGroup.ResiduallyFinite` for finitely generated abelian groups from `AddCommGroup.equiv_free_prod_directSum_zmod`,
   in 60–80 lines. The proof uses instead:
   - `CharacterModule.exists_character_apply_ne_zero_of_ne_zero`: `ℚ/ℤ` is injective, so some character of `A ⧸ V` is
     nonzero at the image of `e`;
   - pulled back to `A`, the character's range is finitely generated (the `AddGroup.fg_range` instance) and torsion
     (`q` is killed by `q.den`: four lines);
   - so the range is finite (`AddCommGroup.finite_of_fg_torsion`), and the kernel has finite index
     (`AddSubgroup.finiteIndex_ker`);
   - then `W = ker ⊓ H`.

   About 20 lines. `[AddGroup.FG A]` is necessary, not merely convenient: in `ℚ` no proper subgroup has finite index. The
   same five lines would give the instance `AddGroup.ResiduallyFinite` for every finitely generated additive
   commutative group. That is a Mathlib candidate, deferred with every upstreaming (§ Publication).
2. **P-K1, both halves.** "Every leaf closes within budget": **confirmed**, with no statement change. "The
   residual-finiteness step is the costliest": **not confirmed**. By length, T2 was the costliest leaf (~55 lines). By
   passes, three leaves needed a second pass, residual finiteness among them. No leaf was expensive.
3. **The pricing was off by about ×20.** The obligation pass decomposed every leaf into a statement it derives from. That
   decomposition is what made each leaf a single pass, so the price measured the work before decomposition. A reading
   for future pricing: after an obligation pass of this grain, price leaves at minutes, and price only the leaves the pass
   could not decompose.
4. **Prose corrected, statements untouched.** These are the changes that are not proofs:
   - The module doc and R1's docstring still named `nonempty_hom_of_forall_finite_subgraph_hom`, the route the obligation
     pass replaced; they now name `Finset.rado_selection`.
   - The residual-finiteness docstring now describes the character route.
   - The status line now reads "proved".
   - `VoltageEscape.zero_mem_lift` gained the docstring that `linter.missingDocs` requires. `lake env lean` without the
     lakefile's options does not show that warning; `-Dlinter.missingDocs=true` does.
   - Imports: `Finsubgraph` became `Compactness`, and `CharacterModule`, `FiniteAbelian.Basic` and `Torsion` were added.

   A mechanical comparison of all 42 declaration and `example` headers against `HEAD`'s skeleton finds them identical.
   The one addition is the private helper.
5. **The architecture checker fails, and the failure predates this phase.** `python3 tools/check_architecture.py`
   reports `FAIL module coverage: missing ['Kempe']`, because the skeleton file has been on disk since the planner.
   `ARCHITECTURE.md` is not this phase's file. A proposed § 3 row for the PO:

   `| `Kempe` | **FS-73 P5, proved (zero `sorry`).** Kempe swaps on any graph (`KempeClosed`, `kempeSwap`, `not_forces_of_kempeClosed`); compactness R1 (`exists_coloring_ne_of_forall_finset` by `Finset.rado_selection`, `forces_iff_exists_finite`); T10's escape certificate `VoltageEscape` with `not_forces_of_voltageEscape` and its named inhabitant `voltageEscapeZ`; T6 `forces_iff_of_quotient_fanGap`; T2 `not_forces_of_additiveKempe`; the normal form `periods`, `IsPeriodic`, `forcedSubgroup` (F), `periodicForcedSubgroup` (P) with `mem_forcedSubgroup`, `mem_periodicForcedSubgroup`; residual finiteness `exists_finiteIndex_between_notMem`; R3 `notMem_periodicForcedSubgroup_of_voltageEscape`; the question `InheritanceQuestion` (a `Prop`, not claimed) and `inheritanceQuestion_iff`. | `FanGap`, `LocalGlobal`, `Palette` | — | FS-73 |`

   The imports cell must match `scripts/build_order.py`. The checker compares it.
6. **Proposed plan edits** (the PO routes them):
   - §M.2's residual-finiteness row: the route is the character route above, 20 lines.
   - §K's status column: all proved.
   - §K's closing note: the kernel instances (Λ′, L6, L3, FS-70's exhibitions) "stay tools-grade unless P5 finishes
     early". P5 did finish early. Whether to spend the time on one instance is the PO's call; the price is a finite ball
     with an explicit escape, FS-2's second target.

## Gate evidence (final file, sha256 `65945b26…fe7507f`)

| gate | result | log |
|---|---|---|
| `./scripts/build.sh` (under the heavy lock) | OK, 177/177 batches, 0 modules with warnings (`Kempe` and `Proofs` rebuilt) | `build/gate/build/20260923T103922Z-457439.log` |
| `scripts/axioms.sh` | OK: 1034 clean, 10 axiom-free, 5 declared purchases (unchanged); 30 new records, all CLEAN; no `native_decide` | `build/gate/axioms/20260923T104258Z-473393.log` |
| `scripts/vacuity.sh` | OK: `declarations=6795 refutations-skipped=278`, `sites=275 vacuous=0 stale=0 declared=3 witnessed=17 generic=253 unknown=2` | `build/gate/vacuity/20260923T104301Z-473589.log` |
| `scripts/vacuity.sh --self-test` | OK, all seven controls fired as designed (run on the pre-tidy file; the tidy was a proof body and a docstring) | `build/gate/vacuity-self-test/20260923T102440Z-404710.log` |
| `lake lint` | "Linting passed for Proofs." | terminal only |
| `lake lint` negative control | a planted `def fs73LintPlant (n m : ℕ) : ℕ := n` made it exit 1, naming `Proofs.HadwigerNelson.Kempe` and the unused `m`. Then the file was restored (sha256 matched the saved copy), rebuilt, and lint passed again | terminal only |
| debt scan `grep -rn sorry Kempe.lean` | 0 matches | — |

**Counts owed to `CLAUDE.md` at the close** (reported, not edited):
- the trust ledger: 1004 clean → 1034;
- § The gate: `declarations` 6728 → 6795, `refutations-skipped` 270 → 278, `sites` 262 → 275, `generic` 240 → 253,
  the rest unchanged;
- `scripts/vacuity-baseline.txt`'s header also reads stale (6723 → 6795), per the gate's own message.

## Resume

Nothing is in flight. No checkpoint exists or is needed: every step was an elaboration of under five seconds or a
capped build of about 3.5 minutes.
