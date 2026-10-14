# FS133-IB1 — the invariant laws and the section density: two files of lane B of the one-class transfer's kernel module

*de Bruijn, the implementer; job FS133-IB1 (brief: `data/fs133/briefs/FS133-IB1-laws-and-density.md`, on `main`).
Branch `fs133-wb1`, cut from `1dd2b4acd` (the first implementer's head, branch `fs133-wa1`) in the worktree
`.claude/worktrees/fs133-wk1`. The plan is `plans/FS133-kernel-plan.md` § 5.2 (lane B), with §§ 5.0, 5.5, 6.
Working files: `data/fs133/ib1/`. Files of the module this job writes:
`Proofs/HadwigerNelson/Plane/OneClass/InvariantLaw.lean` and `…/SectionDensity.lean`, proofs and private helpers
only.*

## Theorems this phase proved

(Filled at the last stage, from the built tree.)

## Stage 1 — SAVED: the readback, the leaves restated, the statements as the kernel holds them before any edit

**1.1 The brief's quotations.** `tools/fs133_ib1_readback.py` (FS133-IA1's reader with this job's brief; each quoted
line a substring of its source, read in the coordinator's tree): **5 matched, 0 mismatched**, exit 0
(`data/fs133/ib1/readback-brief.out`) — W2 against `data/fs131/REQUEST-2026-10-13.md`; K133-INV-CLASS,
K133-NC-INV-CLASS, K133-DENS-CLASS and K133-NC-DENS-CLASS against `data/fs133/claims-K1.md`. With `--fault` (the
last character of each quoted line changed): 0 matched, 5 mismatched, exit 1 (`readback-brief-fault.out`). No finding
about the brief's quotations.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make the
gate fail; the plan's stages 1–4, § 5.0, § 5.2, § 5.5, § 6 and § 4.2; the first implementer's record (its head, stages
1, 5, 6 and the drafts) and its report; the three files of the lane (`InvariantLaw`, `SectionDensity`, `Defs`).

**1.3 Each leaf, in one line, beside the plan's route.** Fourteen `sorry`s: eight in `InvariantLaw`, six in
`SectionDensity`. The file's text is the statement; the line is a reading.

| leaf | the statement, in one line | the plan's route (§ 5.2) |
|---|---|---|
| **I1** `IsShiftInvariantLaw.measure_origin_le` | a translation-invariant law `P` of any graph `G` on `E` has `P {I | I 0 = true} ≤ G.finIndepRatio` | for each nonempty finite `S`: `∑_{g ∈ S} P{I g} = ∫ #{g ∈ S | I g}`, each term `P{I 0}`, the integrand at most `indepNum` almost surely |
| child `countable_algPlane` | `Countable E` | `Algebraic.countable`, as the release's `E_countable` |
| **I2** `exists_foelner_finset` | a countable `ℚ`-vector space `A` has nonempty finite `F n` with `#{a ∈ F n | a + z ∉ F n} / #F n → 0` for every `z` | a `ℚ`-basis enumerated; boxes of points with coordinates `c i / n!`, `|c i| ≤ n · n!`, on the first `n` basis vectors |
| **I3** `exists_shiftInvariant_of_foelner` | for a Følner sequence `F` in `E`, a closed `C ⊆ E → Λ` that every translation preserves, and `ℓ n ∈ C`: a probability `P` with `P Cᶜ = 0`, `P.map (shiftLab z) = P` for all `z`, and `ofReal c ≤ P {ℓ' | ℓ' 0 = a}` whenever `c · #F n ≤ #{r ∈ F n | ℓ n r = a}` for all `n` | averages of point masses at the translates of `ℓ n` over `F n`; a cluster point in the compact space of probabilities; each claim a closed condition met up to an error tending to `0` |
| **I4** `exists_turnInvariant` | from a translation-invariant probability `P₀` carried by a closed `C` that translations and rotations preserve: a probability carried by `C`, invariant under both, with `P₀`'s law of the label at the origin | a generic child `exists_common_fixed` (countably many commuting continuous maps, a closed class stable under Cesàro averages; one map by Krylov–Bogolyubov, then nested closed sets), no Markov–Kakutani |
| **I5** `exists_isInvariantLaw` | for `S ⊆ E` with `kCoeff u * s ∈ S`: an invariant law of `circulantGraph S` with `P {I | I 0 = true} = (circulantGraph S).finIndepRatio` | `C` := indicators of independent sets, closed and invariant; I2 at `A := E`; `ℓ n` an independent subset of `F n` of the ratio's size; I3 at `a := true`; I4; `≤` by I1 |
| **I6** `norm_kCoeff_mul` | `‖(kCoeff u * z : E)‖ = ‖z‖` in `ℂ` | `norm_mul`, the modulus of a point of the circle |
| **I7** `unitDistance_algPlane_eq_circulantGraph` | `unitDistance E = circulantGraph {z : E | ‖z‖ = 1}` | `SimpleGraph.ext`; `dist a b = ‖a − b‖` |
| **D1** `sectionDensity_univ` | the whole space has section density `1` along windows of finite non-zero measure | unfold, `ENNReal.div_self`, `limsup_const` |
| **D2** `sectionDensity_empty` | the empty set has section density `0` | the same |
| **D3** `measurable_sectionDensity` | for measurable `W` and measurable windows of finite measure, `ω ↦ sectionDensity lam Xn W ω` is measurable | `measurable_measure_prodMk_right` for `lam.restrict (Xn n)`; a constant divisor; `Measurable.limsup` |
| **D4** `le_lintegral_sectionDensity` | if in each window almost every `x` has `α ≤ μ {ω | (x, ω) ∈ W}`, then `α ≤ ∫⁻ sectionDensity dμ` | Tonelli on each window; `limsup_lintegral_le` with the bound `1` |
| **D5** `measure_le_sectionDensity_pos` | then `0 < μ {ω | α ≤ sectionDensity ω}` | by contradiction: `D < α` almost everywhere, so `∫⁻ D < α` |
| child `ofReal_integral_le_measure_pos` | for measurable `h ≤ 1` on a probability space, `ofReal (∫ h) ≤ μ {0 < h}` | `h ≤ 1_{h > 0}` pointwise; not integrable ⇒ the integral is `0` |

**1.4 The statements as the kernel holds them, before any edit** (the build as the first implementer left it, for
`1dd2b4acd`). `data/fs133/ib1/lean/StatementDump.lean` (FS132-I2's dumper, its body unchanged; the full print and
the print with instance and proof arguments erased) prints every named constant of the two modules:
`data/fs133/ib1/moved/before.out.xz` (sha256 of the uncompressed print in `before.sha256`) — **19 constants**:
`InvariantLaw` 10 theorems, `SectionDensity` 1 definition and 8 theorems; no private declaration. Against the first
implementer's last dump of the eight modules (`data/fs133/ia1/moved/built.out.xz`), by `tools/fs133_ib1_moved.py`
(its reader, this job's copy): **19 IDENTICAL** (`moved/before-vs-ia1-built.txt`) — the tree is as it was handed
back. The reader's control on this dump: each of four plants read as planted (`moved/control-before.txt`).

A second instrument for a file not yet built: `data/fs133/ib1/footer.sh` appends
`data/fs133/ib1/lean/Footer.lean.inc` to a working copy and prints the same dump of the constants the copy itself
declares, and the axioms of each of its public theorems, under `lake env lean` (iteration only; the build is the
receipt).

## Stage 2 — SAVED: I3 and I4, the two compactness leaves, and `countable_algPlane`

*Proved under `lake env lean` with the lakefile's options (`data/fs133/ib1/lean1.sh`); the build is the last
stage's receipt.*

**2.1 Three import lines added to `InvariantLaw`** — `Mathlib.Algebra.AlgebraicCard` (`Algebraic.countable`),
`Mathlib.MeasureTheory.Measure.Portmanteau`, `Mathlib.MeasureTheory.Measure.Prokhorov` (the compactness of the space
of probabilities on a compact space, which the plan's route names; none of the three is in the closure of the
module's former imports: `ProbabilityMeasure` itself was an unknown identifier under them). An import can move the
instance a statement stores (the first implementer's finding), so the ten stored statements of `InvariantLaw` were
dumped from the file with the three imports and set against stage 1's dump: **10 IDENTICAL, in the full print**
(`data/fs133/ib1/stage2-moved.txt`; its nine `MISSING` lines are `SectionDensity`'s constants, which a one-file dump
does not hold). Whether a statement of a module downstream (`Algebraic`, `Fractional`, `Pair`) moves is read at the
build, on all eight modules.

**2.2 The route taken, and where it leaves the plan's.** The plan's § 5.2 route for both leaves, with three
changes of shape, none of statement:
- *One ultrafilter instead of a subsequence.* A cluster point of the averages is taken along `Ultrafilter.of atTop`
  (compactness as `IsCompact.ultrafilter_le_nhds`), so no metrizability of the space of probabilities is asked.
  Mathlib's Portmanteau lemmas and `ProbabilityMeasure.tendsto_iff_forall_integral_tendsto` are stated for any
  filter.
- *A finite-intersection argument instead of an enumeration.* `exists_common_fixed` is proved for a family of
  commuting continuous maps indexed by **any** type: the sets of fixed probabilities are closed, every finite
  subfamily has a common fixed point in the class (induction on the finite set, one map at a time by
  `exists_fixed_of_average`), and compactness intersects them (`IsCompact.inter_iInter_nonempty`). The rotations'
  countability is not read.
- *The class is a predicate on measures, stable under one map and under finite uniform averages*, in place of
  "stable under Cesàro averages": then the step for one more map needs only that a pushforward by a commuting map
  and an average of fixed measures are fixed, and the instance needs one rotation, not its iterates.

**2.3 The private helpers** (all in `InvariantLaw`, all `private`):
`avgMeasure` with `avgMeasure_apply`, `isProbabilityMeasure_avgMeasure`, `avgMeasure_map`, `integral_avgMeasure`
(the uniform average of finitely many measures); `abs_sum_add_sub_sum_le` (translating a finite set moves a bounded
sum over it by at most twice the bound times the number of points translated out); `map_eq_of_tendsto` (a weak limit
of asymptotically invariant probabilities is invariant), `map_eq_of_tendsto_of_eventually`,
`measure_compl_eq_zero_of_tendsto` (a weak limit of probabilities carried by a closed set is carried by it),
`tendsto_measure_of_isClopen`, `isClosed_setOf_of_tendsto`; `exists_fixed_of_average` (one map: Krylov–Bogolyubov
inside a closed class; the two integrals against the `n`-th average differ by a telescoping sum, at most
`2‖f‖/(n+1)`), `exists_common_fixed`; `continuous_shiftLab`, `continuous_turnLab`, `isClopen_setOf_origin_eq`.

**2.4 Results.**
- **I3 `exists_shiftInvariant_of_foelner` — proved.** The averages are `avgMeasure (F n) fun r => dirac (shiftLab r
  (ℓ n))`; carried by `C` through Portmanteau's closed-set half; invariance through `abs_sum_add_sub_sum_le` and the
  Følner hypothesis; the origin's label through the clopen set `{ℓ' | ℓ' 0 = a}`.
- **I4 `exists_turnInvariant` — proved**, as the instance of `exists_common_fixed` at the class "carried by `C`,
  translation-invariant, with `P₀`'s law of the label at the origin".
- **`countable_algPlane` — proved** (the release's proof of `E_countable`, three lines).
- Axioms, from the footer on the file (`data/fs133/ib1/stage2-axioms.out`):
  `exists_shiftInvariant_of_foelner`, `exists_turnInvariant`, `countable_algPlane` each
  `[propext, Classical.choice, Quot.sound]`.

**2.5 A finding about a statement (a widening the proof shows; the statement is not changed).**
`exists_turnInvariant` takes `hshift : ∀ z, MapsTo (shiftLab z) C C` and **the proof does not read it**: a rotation
of a translation-invariant law is translation-invariant by the covariance `shiftLab z ∘ turnLab u = turnLab u ∘
shiftLab (kCoeff u * z)` alone, whatever its carrier. The unused-variable linter reports the binder; the proof holds
it with `have _ := hshift` and a comment (the form `LEAN.md` § The gate records for an argument kept on purpose).
Both callers supply it. Sent to the coordinator with the line on the two leaves.

**2.6 Re-pricing, from these two leaves** (the plan: 6–10 h each, "the heaviest of lane B"). Both were written in
one pass over a shared set of helpers and closed in seven elaborations, the errors each a missing annotation; about
400 lines. The rest is priced from that: I2 (the Følner sequence) is now the heaviest — bookkeeping in coordinates,
no library to lean on; I1 and I5 a few dozen lines each over the helpers above; I6, I7, D1–D5 short.
