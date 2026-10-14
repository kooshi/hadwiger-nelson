# FS131-IJ3 — the five-colour chain: M2b's last leaf (`archimedean_support`), then the entropy side

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IJ3-m2b-entropy.md` (on `main`). Branch `fs131-wt5`, cut from
`fs131-wt4` at `226eae199` in the worktree `.claude/worktrees/fs131-wq1`. Working files: `data/fs131/ij3/`. Laptop: 12
cores, 31 GB.*

## Theorems this phase proved

(Filled as leaves fall; each line its declaration, its grade and its axioms as printed from a built tree.)

## Stage 1 — SAVED: the readback, the leaves beside their plans, the stored statements before any edit

**1.1 The brief's quotations** (standing rule 3; `tools/fs131_ij3_quotes.py`, FS131-IJ1's reader as FS131-IJ2 copied it,
unchanged in logic, against `main`'s tree): **7 quotations, 7 MATCH** (`data/fs131/ij3/logs/quotes.log`) — W2
(`data/fs131/REQUEST-2026-10-13.md`), the three dated lines of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 761,
791 and 876 (`plans/FS131-close-inventory.md`). **Control** (`--plant`): one character of each quotation changed in turn, each
planted quotation MISMATCH and the other six MATCH, 7 of 7 (`logs/quotes-plant.log`). No finding about the brief.

**1.2 The tree.** `lake build --no-build` under the slot: "All targets up-to-date (6115 jobs)", exit 0
(`logs/nobuild0.log`): the compiled library is current for `fs131-wt4` at `226eae199`, as the brief says.

**1.3 Each leaf, its statement in one line, beside its plan.** `R = unitRing F`, `R̂ = Dual F`, `L = F(i)`.

| lane | leaf | the statement | plan |
|---|---|---|---|
| M2b `BochnerTau` | `archimedean_support` | a finite measure on `R̂` whose transform is `archTop`-continuous gives the complement of `archChars R` measure `0` | IJ2's record § 5.7: a `ℚ`-basis of `L` in `R`, the maps `t_k` to `ℝ^d` at scale `5^{−k}`, tightness uniform in `k` by a Dirichlet-kernel bound, Prokhorov, the limit's transform equal to `φ` on `R` by density, uniqueness |
| A `UnitCircle` | `exists_admissiblePair` | over every real number field an admissible pair exists | none typed: planned in this record at its stage (item 761 ruling 4's note is one input) |
| split `EntropySplitMax` | `rotInv_sub_maxMultiple` | the remainder `τ − a·m` after the largest Haar multiple is rotation invariant | KN8 § 3.4 item 2 |
| | `measure_haarSet_eq_zero` | for the conditional-expectation kernel on the invariant σ-algebra of any action, the set where every coefficient off `0` vanishes is `ν`-null, given no positive Haar multiple below `ν` | KN8 § 3.4 item 3 |
| | `ksEntropy_eq_zero_of_not_smul_le` | a `Γ`-invariant probability with no positive Haar multiple below it has entropy zero at every rotation of `Γ` | KN8 § 3.4 item 4 |
| | `entropySplit_of_admissiblePair` | one admissible pair gives `EntropySplit F` | KN8 § 3.4 item 5 |
| | `not_smul_dualHaar_le_dirac_one` | no positive multiple of `dualHaar` is below the point mass at `1` | KN8 § 3.4 item 6 |
| M5-E `EntropyFibres` | `measurable_blockLabel` | the block label of a measurable map and label is measurable | KN9 § Stage 2 |
| | `blockEntropy_iterate` | `H_n(T^q, P^{(q)}) = H_{qn}(T, P)` for every measure | KN9 § Stage 2 |
| | `ksEntropy_eq_zero_of_iterate` | entropy zero of `T^q` (`q ≥ 1`) gives entropy zero of `T` | KN9 § Stage 2 |
| | `ksEntropy_finite_mixture_eq_zero` | a uniform finite mixture of invariant probabilities of entropy zero has entropy zero | KN9 § Stage 2 |
| | `observationEntropy_comp_le` | a function of an observation carries at most its Shannon entropy | KN9 § Stage 2 |
| | `exists_sectionPartition` | a finite subgroup of a compact T1 group has a finite measurable section partition whose cells project Borel sets to Borel sets | KN9 § Stage 2 |
| | `exists_pattern_names_le` | `H_n(P) ≤ H_n(R) + log k` for a pattern partition `R` of the factor | KN9 § Stage 2 |
| | `ksEntropy_eq_zero_iff_of_finite` | entropy zero on `X ⧸ G` (Borel) iff entropy zero on `X`, `G` finite | KN9 § Stage 2 |
| | `finFour_fibre_model` | `ℤ/4`, `{0, 2}`, the identity, the uniform probability: a model | KN9 § Stage 2 |
| M5-P `PositiveEntropy` | `ZdAction.two_le_of_not_isVirtuallyCyclic` | an action that is not virtually cyclic has `d ≥ 2` | KN9 § Stage 2 |
| | `ZdAction.noVirtuallyCyclicFactors_of_isIrreducible` | irreducible on a connected T1 group and not virtually cyclic: no virtually cyclic factor | KN9 § Stage 2 |
| | `ZdAction.coe_nsmul` | `α(q • n) = (α n)^[q]` | KN9 § Stage 2 |
| | `ZdAction.map_eq_of_isAddHaarMeasure` | a Haar probability is `α n`-invariant | KN9 § Stage 2 |
| | `ZdAction.eq_of_isErgodicOn_of_invariant_component` | an ergodic uniform mixture of mutually singular probabilities with an invariant component is that component | KN9 § Stage 2 |
| | `ZdAction.mulTwoThree_model` | `×2, ×3` on `ℝ` is irreducible and not virtually cyclic | KN9 § Stage 2 |
| | `ZdAction.invariantComponent_model` | the trivial action on `Unit` with the point mass: a model | KN9 § Stage 2 |
| | `finTwo_haar_model` | the uniform probability on `ℤ/2` is a translation-invariant probability | KN9 § Stage 2 |
| | `isAddHaarMeasure_of_add_invariant` | a translation-invariant probability on a compact group is Haar | KN9 § Stage 2 |
| | `haar_or_zero_entropy` | `[EinsiedlerLindenstrauss2022]` Thm 1.2: Haar, or entropy zero at every `n` | KN9 § Stage 2 (FS105-DED) |
| M9-S `ChainAtTA` | `noRamifiedStableDyadic_of_tca` | T-C(A) excludes a ramified stable dyadic prime | KN9 § 3.4 |

**1.4 The stored statements before any edit.** `data/fs131/ij3/lean/StatementDump.lean` (FS131-IJ2's dumper aimed at
every module of `Proofs/HadwigerNelson/Rigidity/`, 41 modules — the seven this job writes and every module downstream of
them; no module outside `Rigidity/` imports one), run on the current build before any edit: `statements-before.txt` (268 MB;
committed as `.xz`, sha256 in `statements-before.sha256`), 1,424 constants (`logs/dump-before.err` holds only the slot's
line).

**1.5 Class binders** (item 847's defect). Section variables with class binders in my seven files: `EntropyFibres`'
`FiniteFibres` (`[AddCommGroup X] [TopologicalSpace X] [IsTopologicalAddGroup X] [MeasurableSpace X] [BorelSpace X]`) and
`PositiveEntropy`'s `ZdAction` section (`[AddCommGroup X] [TopologicalSpace X]`); `ChainAtTA`'s `ArchMeasurable`
(`[AddCommGroup G]`) is off my leaf. Read from the dump's stored types: `exists_sectionPartition`, `exists_pattern_names_le`,
`ksEntropy_eq_zero_iff_of_finite` carry all five; `finFour_fibre_model` none (it names no `X`); every theorem of the
`ZdAction` section that names `X` carries `AddCommGroup X` and `TopologicalSpace X` (`two_le_of_not_isVirtuallyCyclic`,
`noVirtuallyCyclicFactors_of_isIrreducible`, `coe_nsmul`, `map_eq_of_isAddHaarMeasure`,
`eq_of_isErgodicOn_of_invariant_component`, `IsTotallyIrreducible.isIrreducible`); `mulTwoThree`, `mulTwoThree_model`,
`invariantComponent_model` name none. The other files declare only `variable (F : Subfield ℝ)` or `{F}`. The files'
instances (`UnitCircle`'s `instMulActionDual`, `measurableConstSMul_dual`, `countable_unitRing_of_numberField`,
`countable_unitCircle`) take their binders written. **No stored type lacks a class binder its section declares.**
