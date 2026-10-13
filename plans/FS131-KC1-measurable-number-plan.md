# FS131-KC1 — the plane's chromatic number equals its Lebesgue-measurable chromatic number: the kernel plan

*Job record of FS131-KC1 (brief: `data/fs131/briefs/FS131-KC1-measurable-number-plan.md`; de Bruijn, the planner; branch
`fs131-wkc`). Claim list: `data/fs131/claims-NF3.md`. The mathematics is other people's: a printed lemma
(`[Davies2026]` Lemma B.1, p. 44, with its proof), a density-point step this library already holds, and a declared outside
theorem (`Outside.OAI158.proper_to_borel_weak`, `[OAIMath2026]`); what is done here is typing, composing and planning.
Working files: `data/fs131/kc1/`.*

## Theorems this phase proved

The leaves fell while typing: the module has no `sorry`. Each line is **kernel-checked by `lake env lean` in this tree
(with `autoImplicit` off), not yet through `./scripts/build.sh` or the gate** — the landing's work, § Stage 3. Module:
`Proofs/HadwigerNelson/Plane/LebesgueNumber.lean`. Axioms as printed by `data/fs131/kc1/axioms_probe.sh`
(`data/fs131/kc1/axioms-probe.out`; its control plants a `sorry` and `sorryAx` reaches the headline).

| theorem | what it says | axioms |
|---|---|---|
| `HadwigerNelson.exists_proper_ae_eq_of_proper_on_conull` | `[Davies2026]` Lemma B.1 as the sentence that introduces it, for a translation-invariant relation on a finite-dimensional real normed space with a Haar measure | the standard three |
| `HadwigerNelson.exists_proper_nullMeasurable_of_avoiding_cover` | Lemma B.1 in its printed form (sets), same generality | the standard three |
| `HadwigerNelson.davies_lemma_B1_euclidean`, `Plane.davies_lemma_B1` | Lemma B.1 for `ℝ^d` and any set `D` of distances; for the plane and the unit distance | the standard three |
| `Plane.exists_proper_of_aeColouring`, `Plane.exists_proper_of_nullMeasurable_weak` | NF3-WEAK-TO-PROPER, for a Borel and for a Lebesgue-measurable weak colouring | the standard three |
| `Plane.exists_aeColouring_of_nullMeasurable_proper` | the converse (a null change to a Borel map) | the standard three |
| `Plane.chiM0_eq_chiLebesgue`, `Plane.nonempty_aeColouring_iff_exists_nullMeasurable_proper` | `χ_m⁰(ℝ²) = χ_m(ℝ²)`, and colour by colour | the standard three |
| `Plane.chiLebesgue_le_chiM`, `Plane.chromaticNumber_plane_le_chiLebesgue` | `χ(ℝ²) ≤ χ_m(ℝ²) ≤ χ_B(ℝ²)` | the standard three |
| `Plane.chromaticNumber_plane_eq_chiLebesgue`, `Plane.chromaticNumber_euclidean_plane_eq_chiLebesgue`, `Plane.colorable_iff_exists_nullMeasurable_proper` | NF3-PLANE: `χ(ℝ²) = χ_m(ℝ²)`, and colour by colour | the standard three and `Outside.OAI158.proper_to_borel_weak` |

Supporting: `HasDensityOneAt` with `hasDensityOneAt_univ`, `hasDensityOneAt_congr_ae`, `HasDensityOneAt.inter`,
`hasDensityOneAt_preimage_add_right`, `HasDensityOneAt.nonempty`, `ae_hasDensityOneAt_fibre`, `exists_translate_mem`,
`exists_nullMeasurable_selector`; `Plane.AeColouring.core` with four lemmas; `Plane.nullMeasurable_iff_forall_fibre`,
`Plane.chiLebesgue_le`. None of it is this project's mathematics beyond the composing.

## Stage 1 — SAVED: readback

**The brief's quotations, by script** (`data/fs131/kc1/readback_check.py`: each block quote of the brief must occur
character for character in the file its source line names). Nine of nine MATCH; with `--fault` (one character of each
altered) nine of nine read MISMATCH, so the check can fire. The brief's § Done means says "the eight quoted lines": there
are nine block quotes (two of Kooshi's words, four claims, three library lines) — a count, not a mismatch.

**One quotation is cut where the defect is.** The brief quotes `Plane.chiM` as `noncomputable def chiM : ℕ∞ :=` and stops
at `:=`; the body, on the next line of `Proofs/HadwigerNelson/Plane/FalconerReduction.lean` (27–28), is

```lean
noncomputable def chiM : ℕ∞ :=
  ⨅ (k : ℕ) (_ : ∃ f : ℂ → Fin k, Measurable f ∧ ∀ x y, dist x y = 1 → f x ≠ f y), (k : ℕ∞)
```

**The lemma, read on the page** (`[Davies2026]`, the rendered p. 44, which is the PDF's page 44). The statement, the
standing hypotheses and the sentence before the lemma are as NF3-PRINTED has them, word for word. The proof, in its six
steps: (1) make the sets disjoint, `A_i ∖ ⋃_{j<i} A_j`; (2) keep of each `A_i` only its density-one points — a null change
by the Lebesgue density theorem — so the sets still avoid `D`, their union `A` is conull, every point of `A_i` is a
density-one point of `A_i`, and `c : A → [k]` gives `A_i` colour `i`; (3) for a finite `F ⊆ ℝ^d` the set
`⋂_{x∈F∩A} (A_{c(x)} − x) ∩ ⋂_{x∈F∖A} (A − x)` "has positive measure near 0: the first part has density one there and the
second is conull"; (4) "A translation ξ in this intersection gives a proper colouring x ↦ c(x + ξ) of F agreeing with c on
F ∩ A"; (5) "The compactness principle for graph colourings [20] then gives a proper colouring of ℝ^d extending c"; (6)
"Each colour class differs from A_i only within the null set ℝ^d ∖ A, so the colouring is Lebesgue measurable." The
paper's measurable chromatic number, p. 2: "Requiring the colour classes to be Lebesgue measurable gives the measurable
chromatic number χ^(m)(ℝ^d)" — classes **Lebesgue** measurable, proper at **every** pair.

**The two definitions, read from the Lean source.**

| | σ-algebra | where proper | classes or a map | is it the paper's? |
|---|---|---|---|---|
| `Plane.chiM0` (`Plane/AeColouring.lean:32`), over `Plane.AeColouring k` (lines 23–29) | **Borel**: the field `measurable : Measurable col`, and `ℂ`'s σ-algebra is `Complex.measurableSpace := borel ℂ` (the docstrings say "Lebesgue-measurable") | **almost every** unit pair: `∀ j, UnitPairsNull (col ⁻¹' {j})`, i.e. `(volume.prod arcLength) {(x, θ) | x ∈ A ∧ x + e θ ∈ A} = 0` for each fibre `A` | a map `col : ℂ → Fin k`; the classes are its fibres | the paper has no almost-everywhere number. As a number it is the Lebesgue almost-everywhere one: a null change makes a Lebesgue weak colouring Borel (`UnitPairsNull.congr_ae`, `Plane/Cover.lean:259`) |
| `Plane.chiM` (`Plane/FalconerReduction.lean:27–28`) | **Borel**: `Measurable f` | **every** unit pair: `∀ x y, dist x y = 1 → f x ≠ f y` | a map `f : ℂ → Fin k` | **no.** It is row 130's `χ_B`, not `χ_m`; its docstring calls it "`χ_m(ℝ²)` (Falconer's, everywhere-proper)" |

**The statement defect** (sent to "main" at once; accepted, with a dated line in `data/fs131/claims-NF3.md`). The claim
list names `Plane.chiM` as the library's object for Falconer's number, and it is the Borel number. Lemma B.1's colouring
is Lebesgue measurable and no more (step 6: the null set is coloured by a compactness argument), so `chiM0 = Plane.chiM`
and `χ(ℝ²) = Plane.chiM` are not what the lemma gives, and NF3-NC excludes Borel statements. **Resolution:** a new
definition for the Lebesgue number, both headlines over it, the inequality to `Plane.chiM` beside them, `Plane.chiM`
untouched. Whether `Plane.chiM` equals the Lebesgue number is not claimed and not attempted: it asks a Borel colouring of
the null set under lists, which compactness does not give.

**The reader's record** (`plans/FS131-ER1-davies-reading.md` on `main`, untracked there; read at its § 2.1, § 2.7, § M):
its M.0 table already separates `χ_m` (Lebesgue) from `χ_B` (Borel) and its ER1-WEAK-TO-PROPER hand-off says "the equality
with Falconer's number, which the library does not yet define" — so the reader had it right and the slip was in the claim
list's header. Its M.3 names the reach of the lemma's argument (translation invariance, the density theorem, compactness;
no use of the distance set, of `d ⩾ 2`, or of the norm); the plan below types that reach as the core statement.

## Stage 2 — SAVED: the statements, typed and read back; the skeleton became the module

**The module** `Proofs/HadwigerNelson/Plane/LebesgueNumber.lean` (imports `Outside/OAI158`, `Plane/FalconerReduction`,
`Plane/WeakColouringOn`, `Plane/DensityPoints`, `Mathlib.Combinatorics.Compactness`; its line is in `Proofs.lean` and its
row in `ARCHITECTURE.md` § 3, `tools/check_architecture.py` exit 0, 341 rows, 0 import mismatches). Elaboration: 5.6 s,
3.6 GB under `--mem 4 --cpus 2` (measured; the other planner's build held 18 of the 22 GiB budget, so `--mem 8` would
not have been admitted and 4 was the honest figure). First elaboration of the skeleton: ten `sorry`, all at leaves, the
assemblies proved; then the ten closed in three more runs, each at its first attempt.

**Each headline read back against its claim and the page.**

- *NF3-PRINTED.* `exists_proper_nullMeasurable_of_avoiding_cover (μ) [μ.IsAddHaarMeasure] (hR : ∀ ξ x y, R x y → R (x + ξ)
  (y + ξ)) (hA : ∀ i, NullMeasurableSet (A i) μ) (havoid : ∀ i, ∀ x ∈ A i, ∀ y ∈ A i, ¬ R x y) (hcov : μ (⋃ i, A i)ᶜ = 0) :
  ∃ f : E → Fin k, NullMeasurable f μ ∧ (∀ᵐ x ∂μ, x ∈ A (f x)) ∧ ∀ x y, R x y → f x ≠ f y`. "measurable" → Lebesgue
  measurable (`NullMeasurableSet`, `NullMeasurable`: measurable for the completed measure); "D-avoiding" → `havoid` at
  `R x y := dist x y ∈ D` (`davies_lemma_B1_euclidean`), `dist x y = 1` in the plane (`Plane.davies_lemma_B1`); "whose
  union is conull" → `hcov`; "admits a measurable proper k-colouring of its D-distance graph" → the first and third
  conjuncts. The middle conjunct is more than the printed statement and is what its proof gives ("after changes on a null
  set"). The standing hypotheses (`D` finite and nonempty, `d ⩾ 2`, `k ⩾ 2`) are absent: the proof does not read them.
  At `k = 0` the hypotheses are contradictory (a Haar measure is not zero); nothing is hidden there.
- *The sentence before the lemma* → `exists_proper_ae_eq_of_proper_on_conull … (hc : NullMeasurable c μ) (hS : μ Sᶜ = 0)
  (hproper : ∀ x ∈ S, ∀ y ∈ S, R x y → c x ≠ c y) : ∃ f, NullMeasurable f μ ∧ f =ᵐ[μ] c ∧ ∀ x y, R x y → f x ≠ f y`: "a
  measurable proper colouring of a conull set can, after changes on a null set, be extended to a measurable proper
  colouring of ℝ^d" — `c` is given on all of `E` and read only on `S`.
- *NF3-WEAK-TO-PROPER.* `Plane.exists_proper_of_nullMeasurable_weak (hc : NullMeasurable c volume) (hnull : ∀ j,
  UnitPairsNull (c ⁻¹' {j})) : ∃ f : ℂ → Fin k, NullMeasurable f volume ∧ f =ᵐ[volume] c ∧ ∀ x y, dist x y = 1 → f x ≠ f y`,
  and `Plane.chiM0_eq_chiLebesgue : chiM0 = chiLebesgue`. "Lebesgue measurable" → `NullMeasurable`; "proper at almost
  every pair" → the library's primitive, each class with null unit pairs; "proper at every such pair" → the last
  conjunct; the plane and the unit distance only, as the claim's second half says. `chiLebesgue` is an infimum in `ℕ∞`
  over `k` of the existence of such an `f`, shaped as `chiM` and `chiM0` are; it is inhabited at nine (`sq9Col`) and is at
  least five with no import (the two `example`s).
- *NF3-PLANE.* `Plane.chromaticNumber_plane_eq_chiLebesgue : (unitDistance ℂ).chromaticNumber = chiLebesgue`, read against
  `SimpleGraph.chromaticNumber` (an infimum in `ℕ∞` over `n` of `Colorable n`) and `unitDistance_adj` (`Adj x y ↔ dist x y
  = 1`): both sides are least numbers of colours, the left over all maps, the right over Lebesgue-measurable ones. Its
  axioms are the standard three and `Outside.OAI158.proper_to_borel_weak`, and nothing else new.
- *NF3-NC.* Every docstring says whose the mathematics is; no value is stated (the two `example`s bound the definition
  for a sanity check, 5 and 9, both this library's old facts); nothing is said of `Plane.chiM` but `chiLebesgue ≤ chiM`.

**Models of the hypotheses** (each an `example` or a named theorem in the module): the lemma's, both forms — the nine
classes of `sq9Col`; the weak-to-proper step's — `r7_aeColouring`, run in an `example` (its colouring is proper only
almost everywhere, so the step is exercised where it does something); `exists_translate_mem`'s — `V x = univ`.
`AeColouring k` is empty at `k ≤ 5` given the declared outside theorem `Outside.OAI158.no_proper_five_coloring`, and at
six its inhabitation is the open problem: the docstring of `exists_proper_of_aeColouring` says so.

## Stage 3 — SAVED: the modeling pass, the printed proof mapped to Lean, what is left, what comes free, the drafts

**The domain-modeling pass** (`debruijn-domain-modeling`, invoked fresh on the five choices below). What it changed:
`exists_translate_mem` first coupled a conull set `T` with sets `B x` (`x + ξ ∈ T ∧ (x ∈ T → x + ξ ∈ B x)`); it is now the
fact itself — finitely many Lebesgue-measurable sets `V x`, each of density one at its own `x`, are met by one
translation — and the case split moved into the one proof that needs it. The selector was first stated inside the
section and would have carried four instance binders it never reads; it is stated for any measurable space. What it
kept, with the reason: (1) the relation is `R : E → E → Prop` with translation invariance, not a `SimpleGraph` (symmetry
and irreflexivity are never read) and not a distance set (the norm is never read); (2) the core is the function form,
which is the paper's own introducing sentence and what both consumers reduce to — the weak colouring uses it with no
disjointification at all; (3) "Lebesgue measurable" is `NullMeasurable f μ`, tied to the paper's words by
`nullMeasurable_iff_forall_fibre` (Mathlib's `NullMeasurable.aemeasurable` and `AEMeasurable.nullMeasurable` are the
bridge to the release's `AEMeasurable`); (4) `HasDensityOneAt` is the third name for density one beside
`Plane.densitySet` and the ported `Outside.OAI158.DensityOne` — the general one, tied to the first by `Iff.rfl`
(`Plane.mem_densitySet_iff_hasDensityOneAt`); the port's is in a module this one does not import; (5) `chiLebesgue`
mirrors `chiM` and `chiM0`. Seams checked: `k = 0`; the zero-dimensional space; a reflexive `R` (the hypotheses are then
unsatisfiable, consistently). No obligation resisted, so no obligation-modeling pass was run; the consumer surface is
five names (`chiLebesgue`, `chiLebesgue_le`, the two equalities, the colour-by-colour form), named as their neighbours
`chiM0_le`, `chromaticNumber_plane_eq_chiM0`, `colorable_iff_nonempty_aeColouring` are.

**The printed proof's six steps, mapped.**

| printed step | where it is in the module | Mathlib, by full name |
|---|---|---|
| 1. make the sets disjoint | `exists_nullMeasurable_selector` (the least index holding `x`); used only by the sets form | `Finset.min'_mem`, `Finset.min'_le`, `MeasureTheory.NullMeasurableSet.biUnion`, `.iInter`, `.iUnion`, `MeasurableSet.const` |
| 2. keep the density-one points; the union stays conull | the set `T` in `exists_proper_ae_eq_of_proper_on_conull`; `ae_hasDensityOneAt_fibre` | `Besicovitch.ae_tendsto_measure_inter_div` (every set, no measurability), `MeasureTheory.ae_imp_of_ae_restrict`, `MeasureTheory.ae_all_iff` |
| 3. the intersection has positive measure near 0 | `exists_translate_mem`, over `HasDensityOneAt.inter`, `hasDensityOneAt_preimage_add_right`, `hasDensityOneAt_congr_ae`, `hasDensityOneAt_univ`, `HasDensityOneAt.nonempty` | `MeasureTheory.measure_union_add_inter₀`, `ENNReal.Tendsto.sub`, `ENNReal.add_sub_cancel_right`, `tendsto_of_tendsto_of_tendsto_of_le_of_le'`, `ENNReal.add_div`, `ENNReal.div_le_div_right`, `ENNReal.div_self`, `ENNReal.div_le_of_le_mul`, `Metric.measure_closedBall_pos`, `MeasureTheory.measure_closedBall_lt_top`, `MeasureTheory.measure_preimage_add_right`, `MeasureTheory.measurePreserving_add_right`, `MeasureTheory.NullMeasurableSet.preimage`, `MeasureTheory.ae_eq_univ`, `Finset.set_biInter_insert` |
| 4. `x ↦ c(x + ξ)` is proper on `F` and agrees with `c` on `F ∩ A` | `hξT`, `hξc` in the same proof | — |
| 5. compactness | `Finset.rado_selection`, read at `{x}` and at `{x, y}` | `Finset.rado_selection` (`Mathlib.Combinatorics.Compactness`) |
| 6. the classes differ from the `A_i` on a null set, so Lebesgue measurable | `hc.congr hae.symm` | `MeasureTheory.NullMeasurable.congr` |

**Which de Bruijn–Erdős.** Mathlib's `Finset.rado_selection`, the form `Kempe.exists_coloring_ne_of_forall_finset` uses —
not `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom`, the form `Plane.chromaticNumber_plane_le_chiM0` (N-EASY)
and `Bridge` use. The lemma needs a colouring that *extends* `c`, and Rado's selection gives that at singletons with no
gadget; the homomorphism form would need the precolouring coded into the graph. **Which density-point step.** This
library's own, `Plane.AeColouring.dist_ne_one` (`Plane/DensityPoints`, FS111-V0-ID1), with `volume_diff_densitySet` and
`measurableSet_densitySet` (`Plane/Cover`); the ported `Outside.OAI158.weak_density_proper` and `ae_density_actual`
(`Outside/OAI158Palette`) say the same and were not needed. **The ledger's "reduction to a null-set step"** (FS103-M-D,
row 130) was never formalized; the lemma's translation replaces its list-colouring question, so nothing is built on it.
**What failed:** nothing failed to elaborate. `Finset.rado_selection`, not `Fin.find` or `disjointed`, were the choices
made to avoid API I had not confirmed at the pin.

**What is left — for a landing, not an implementer.**
1. **The build**: `./scripts/build.sh` in this tree, under `--mem 18 --cpus 10 -- env MEMMAX=18G BATCH=2`. `lake env
   lean` is not the build: the lakefile's linters are not in force there (a missing docstring on a public `def` would
   show only in the build; every declaration here has one). The tree's `.lake/build` is a landing behind: the first
   build compiles FS-124's eight modules as well.
2. **`scripts/Axioms.lean`**: eleven records under CLEAN (the rows of the table above on the standard three, with the
   supporting theorems as the audit's practice asks) and three under IMPORTED on `proper_to_borel_weak` —
   `Plane.colorable_iff_exists_nullMeasurable_proper`, `Plane.chromaticNumber_plane_eq_chiLebesgue`,
   `Plane.chromaticNumber_euclidean_plane_eq_chiLebesgue` — so that import's records go from nine to twelve; then
   `./scripts/axioms.sh`, its `--self-test`, the counts for `CLAUDE.md` § Trust ledger and the import's row of
   `ARCHITECTURE.md` § Trust (three names to add).
3. **The other gates**: `./scripts/dupnames.sh`; `./scripts/vacuity.sh` (the colourings here are maps under predicates
   the scan does not track — the models are named above and in the docstrings); `./scripts/assumptions.sh` (no hypothesis
   stands for an assumption: `hR`, `hc`, `hS`, `hproper`, `hA`, `havoid`, `hcov` are conditions on each theorem's own
   variables; `rests` goes from 23 to 26); `lake lint`.

**What comes free, and what does not.** The lemma is stated once for every finite-dimensional real normed space with a
Haar measure and every translation-invariant relation, so it holds in every dimension `d ⩾ 0`, for every set `D` of
distances, finite or not, and for every `k` (`davies_lemma_B1_euclidean`); the cost in this library's vocabulary was
nothing — the plane's instance is one line. The **weak-to-proper step** does not come free outside the plane: its
density-point step is held here only for `ℂ` and the unit distance (`UnitPairsNull` is a set of pairs `(x, θ)` in
`ℂ × ℝ`). In `ℝ^d` with a finite `D` it needs (a) a definition of "almost every pair at a distance in `D`" (a sphere
measure for each distance), (b) from it, `A ∩ (A − u)` null for **every** `u` of length in `D` — continuity of
translation in `L²` and full support of the sphere measure, the reader's M.2 (b), the port's `weak_all_directions` in
the plane — and (c) from that, two density-one points of `A` are never at such a distance, which this module's
`HasDensityOneAt.inter`, `hasDensityOneAt_preimage_add_right` and `HasDensityOneAt.nonempty` give in every dimension in
a few lines. So (c) is free and (a), (b) are a small job of their own.

**Drafts for files I do not write** are in the report (`data/fs131/reports/FS131-KC1.md`): row 130's "Not claimed"
line and the clause that closes it, the sentence for a reader of the repository, `CLAUDE.md`'s sentence on Falconer's
number, the docstrings of `Plane.chiM` and `Plane.AeColouring`, the `BIBLIOGRAPHY.md` reading status, three `LEAN.md`
facts.
