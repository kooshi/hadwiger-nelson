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

## Stage 3 — SAVED: the rest of `InvariantLaw` (I1, I2, I5, I6, I7), and Amendment 1 carried out

*Under `lake env lean` with the lakefile's options; no `sorry` is left in the file, and it elaborates with no
warning.*

**3.1 Amendment 1 of the brief** (2026-10-14 02:59 UTC; read on disk in the coordinator's tree, with the dated line
it put in `data/fs133/claims-K1.md`). Item 3: **`exists_turnInvariant` loses `hshift`** — the binder, the line that
kept the linter quiet, and the argument at its two call sites (`exists_invariant_of_closed`, `exists_isInvariantLaw`,
both in this file; no other file of the library names the theorem: `grep` over `Proofs/`); its docstring now says
what is asked and why the translations' stability is not. Nothing else of the skeleton's statements is touched.
Item 4: the two private lemmas stay (3.3).

**3.2 The leaves.**
- **I1 `IsShiftInvariantLaw.measure_origin_le` — proved**, on the plan's route: for each nonempty finite `S`,
  `P {I 0} · #S = ∑_{g ∈ S} P {I g} = ∫⁻ #{g ∈ S | I g}`, and the integrand is at most the independence number of
  the induced graph almost surely.
- **I2 `exists_foelner_finset` — proved, by another route than the plan's** (sent to the coordinator). The plan: a
  `ℚ`-basis and boxes of points with bounded denominators. Taken: **polynomial growth**. For a finite `Z ⊆ A` let
  `G N` be the image of the box `[0, N]^Z` under `c ↦ ∑ c z • z`; then `#G N ≤ (N + 1)^#Z`, `G N ⊆ G (N + 1)` and
  `G N + z ⊆ G (N + 1)` for `z ∈ Z`, so if every step grew by more than the factor `1 + ε` then
  `(1 + ε)^N ≤ (N + 1)^#Z` for all `N`, against `tendsto_pow_const_div_const_pow_of_one_lt`; a step that does not
  is a set that loses at most `ε · #G N` points under each `z ∈ Z` (`exists_almost_invariant`, private). The
  sequence is the diagonal along an enumeration of `A`. No basis, no coordinates, no injectivity.
  **The proof does not read `[Module ℚ A]`**: it is a theorem about any countable commutative group (3.4).
- **I5 `exists_isInvariantLaw` — proved**, on the plan's route: the indicators of independent sets are a closed
  set (an intersection over pairs of preimages of subsets of the discrete `Bool × Bool`), stable under the
  translations and the rotations; I2 at `E`; an independent subset of `F n` of the ratio's size; I3 at `a := true`;
  I4; `≤` by I1.
- **I6 `norm_kCoeff_mul`, I7 `unitDistance_algPlane_eq_circulantGraph` — proved.**

**3.3 The two private lemmas that read the ratio on a finite set** (Amendment 1, item 4): `card_le_indepNum_induce`
(an independent subset of a finite vertex set has at most the independence number of the induced graph) and
`exists_indep_subset` (a nonempty finite vertex set holds an independent set of at least the ratio times its size).
They unfold `finIndepRatio`, so that this file prints the standard three while `Defs`'s `le_finIndepRatio_iff` and
`finIndepRatio_le_one` are unproved. **For the join** (the line the amendment asks for, repeated in the drafts):
when `Defs` is proved, `exists_indep_subset` is `(le_finIndepRatio_iff G).1 le_rfl S hS` and
`card_le_indepNum_induce` is the bridge `Defs` names `indepNum_induce_finset`; both are re-pointed at the public
lemmas or deleted — no duplicate proof goes to the landing.

**3.4 A second finding about a statement** (a generalization; the statement is **not** changed, and no line hides
the binder). `exists_foelner_finset (A) [AddCommGroup A] [Module ℚ A] [Countable A]`: the instance `[Module ℚ A]` is
not read by the proof. The build's linters do not report an unread instance binder; the environment linter
(`unusedArguments`, the landing's `lake lint`) will. By Amendment 1's reasoning the binder should go — its one
caller, `exists_invariant_of_closed`, and I5 pass no explicit instance — but my touches do not reach this
statement: sent to the coordinator for a ruling.

**3.5 Receipts** (the footer on the file as it stands). Axioms (`data/fs133/ib1/stage3-axioms.out`): all ten public
theorems of the file `[propext, Classical.choice, Quot.sound]`. Stored statements against stage 1's dump
(`stage3-moved.txt`): `InvariantLaw` **9 IDENTICAL, 1 DIFFERENT — `exists_turnInvariant`, the ruled widening**.

**3.6 Re-pricing of what is left**: `SectionDensity`'s six leaves, each short (Tonelli on a window, the reverse
Fatou lemma, a strict integral inequality); then the build and the receipts.

## Stage 4 — SAVED: `SectionDensity` (D1–D5 and the child), Amendments 2 and 3 carried out, the draft D4 filed

*Under `lake env lean` with the lakefile's options; neither file holds a `sorry`, and each elaborates with no
warning. The build is stage 5.*

**4.1 The leaves of `SectionDensity`.**
- **D1 `sectionDensity_univ`, D2 `sectionDensity_empty` — proved** (the window ratio is the constant `1`, `0`).
- **D3 `measurable_sectionDensity` — proved**, on the plan's route: `measurable_measure_prodMk_right` for the finite
  measure `lam.restrict (Xn n)`, a constant divisor, `Measurable.limsup`.
- **D4 `le_lintegral_sectionDensity` — proved**, on the plan's route: Tonelli on each window
  (`Measure.prod_apply_symm`, `Measure.prod_apply`), so every window average has mean at least `α`; then
  `limsup_lintegral_le` with the bound `1`.
- **D5 `measure_le_sectionDensity_pos` — proved**: were the event null, `D < α` almost everywhere, and
  `lintegral_strict_mono` against the constant gives `∫⁻ D < α`, against D4. It does not use D3 (the constant is
  the measurable side).
- **child `ofReal_integral_le_measure_pos` — proved**, through `∫ h ≤ (∫⁻ ofReal ∘ h).toReal` and
  `ofReal (h ω) ≤ 1_{h > 0} ω`: the module's imports hold no set integral (`integral_indicator_one` is not in their
  closure), and no import was added to this file.
- Private helpers: `measure_inter_section`, `measurable_windowRatio`, `windowRatio_le_one`.

**4.2 The amendments** (each read on disk in the coordinator's tree).
- *Amendment 2* (03:06 UTC): **`exists_foelner_finset` loses `[Module ℚ A]`**; its docstring says "a countable
  commutative group", and so does its line in the module docstring (prose about the same statement; an edit one
  line beyond the amendment's letter, named in the report).
- *Amendment 3* (03:09 UTC): **`omit [MeasurableSpace Ω] in` above `sectionDensity_univ` and
  `sectionDensity_empty`**. The file's `variable` line put the instance into both stored statements; the definition
  `sectionDensity` takes only `[MeasurableSpace X]`, so neither the statements nor the proofs read it, and with the
  proofs in the build's `unusedSectionVars` linter reported both. And its standing word: a binder of a statement of
  these two files that neither the statement nor its proof reads is dropped without asking and listed. **No further
  one was found**: both files elaborate with no linter message, and every other hypothesis is used by name in its
  proof.

**4.3 The four ruled differences** — the only stored statements of the two files that differ from stage 1's dump
(`data/fs133/ib1/stage4-moved.txt`: 15 IDENTICAL, 4 DIFFERENT; the reading of each as "one unread binder dropped
and nothing else" is stage 5's, on the built tree):

| statement | the binder dropped | why it was unread |
|---|---|---|
| `OneClass.exists_turnInvariant` | `hshift : ∀ z, MapsTo (shiftLab z) C C` | a rotation of a translation-invariant law is translation-invariant by the covariance alone, whatever its carrier |
| `OneClass.exists_foelner_finset` | `[Module ℚ A]` | the Følner sequence comes from polynomial growth of a commutative group; no basis, no scalar |
| `Plane.sectionDensity_univ` | `[MeasurableSpace Ω]` | put in by the section's `variable` line; the definition takes only `[MeasurableSpace X]` and the statement measures nothing on `Ω` |
| `Plane.sectionDensity_empty` | `[MeasurableSpace Ω]` | the same |

**4.4 Axioms**, from the footers (`data/fs133/ib1/stage4-axioms.out`): all eighteen public theorems of the two files
`[propext, Classical.choice, Quot.sound]`.

**4.5 The draft D4 filed** (Done, item 6): the first implementer's dated note, word for word (its text taken from
`plans/FS133-IA1-implementation.md` by script and re-wrapped), in `plans/FS133-kernel-plan.md` § 2.4, as a paragraph
of its own following the sentence the draft names ("… and its docstring and `ARCHITECTURE.md` line must say so.").
