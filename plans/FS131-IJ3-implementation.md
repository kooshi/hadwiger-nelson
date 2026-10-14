# FS131-IJ3 — the five-colour chain: M2b's last leaf (`archimedean_support`), then the entropy side

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IJ3-m2b-entropy.md` (on `main`). Branch `fs131-wt5`, cut from
`fs131-wt4` at `226eae199` in the worktree `.claude/worktrees/fs131-wq1`. Working files: `data/fs131/ij3/`. Laptop: 12
cores, 31 GB.*

## Theorems this phase proved

Printed from build 4's tree (`data/fs131/ij3/axioms-after.txt`; reader `tools/fs131_ij3_axioms.py` PASS, control 4 of
4); all under `HadwigerNelson.Rigidity`; [kernel] unless marked. "Standard three" = `[propext, Classical.choice, Quot.sound]`.
- **M2b** (`BochnerTau`): `archimedean_support` (a finite measure on `R̂` with `archTop`-continuous transform gives the
  non-archimedean characters measure `0`) — standard three; with it **`bochnerOn_tauPrime : BochnerOn (tauPrime F)`** —
  standard three (J45 N2's `⟸` at `S = ∅`; M2b has no leaf left). Public now, statements unchanged: `archHom`,
  `archTop_eq`, `eventually_archTop`, `norm_archHom_nsmul`, `fivePow`, `nsmul_fivePow`, `inv_five_mem`,
  `exists_nsmul_mem_of_mem_nhds_profTop` — standard three.
- **The split** (`EntropySplitMax`): `rotInv_sub_maxMultiple`, `measure_haarSet_eq_zero`, `not_smul_dualHaar_le_dirac_one` —
  standard three; `ksEntropy_eq_zero_of_not_smul_le` and **`entropySplit_of_admissiblePair : ∀ {F} [NumberField F]
  (p : AdmissiblePair F), EntropySplit F`** — the standard three and the declared `positive_entropy_rigidity` (through Lemma
  Γ), no `sorry`.
- **M5-E** (`EntropyFibres`): `measurable_blockLabel`, `blockEntropy_iterate`, `ksEntropy_eq_zero_of_iterate`,
  `ksEntropy_finite_mixture_eq_zero`, `observationEntropy_comp_le`, `exists_sectionPartition`, `exists_pattern_names_le`
  (one unread binder dropped), `ksEntropy_eq_zero_iff_of_finite`, `finFour_fibre_model` — standard three.
- **M5-P** (`PositiveEntropy`): `ZdAction.two_le_of_not_isVirtuallyCyclic`, `ZdAction.noVirtuallyCyclicFactors_of_isIrreducible`,
  `ZdAction.coe_nsmul`, `ZdAction.map_eq_of_isAddHaarMeasure` (one unread binder dropped),
  `ZdAction.eq_of_isErgodicOn_of_invariant_component`, `ZdAction.invariantComponent_model`, `finTwo_haar_model`,
  `isAddHaarMeasure_of_add_invariant` — standard three; **`haar_or_zero_entropy`** (`[EinsiedlerLindenstrauss2022]` Thm 1.2
  from Thm 1.3, FS105-DED) — the standard three and the declared `positive_entropy_rigidity`, no `sorry`.
- **Not proved:** `exists_admissiblePair` (lane A, planned and priced, § 2.5), `ZdAction.mulTwoThree_model` (§ 6),
  `noRamifiedStableDyadic_of_tca` (M9-S, not reached).

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

## Stage 2 — SAVED: M2b complete — the eight lemmas public, `archimedean_support` proved

**2.1 The eight `private`s** (item 876 ruling 1). `Proofs/HadwigerNelson/Rigidity/ContinuityGroup.lean`: `private ` removed
from `archHom` (l. 56), `archTop_eq` (65), `eventually_archTop` (74), `norm_archHom_nsmul` (80), `inv_five_mem` (126),
`fivePow` (149), `nsmul_fivePow` (152), `exists_nsmul_mem_of_mem_nhds_profTop` (171); `git diff` on the file: those eight
lines and nothing else. No public name of the library clashes with the eight (grep of `Proofs/`). `BochnerTau`'s
`open private … from Proofs.HadwigerNelson.Rigidity.ContinuityGroup` (two lines) deleted; the module reads the eight by
their public names. (The two public definitions carry their docstrings.)

**2.2 `archimedean_support`** (written against `data/fs131/ij3/work/BochnerTau.lean`, elaborated in a scratch farm of the
tree's compiled library with the edited `ContinuityGroup` compiled over it, `data/fs131/ij3/farm.sh`; rounds
`logs/BT-1.log` … `BT-4.log`, the last exit 0 with **no warning**; copied over the module). About 616 lines, inside IJ2's
450–700. **The route is IJ2's § 5.7, with these choices of mine:**
- *Coordinates without `ℚ`-linear algebra on the mixed space* (`as_exists_coords`): `b_i = c·ω_i` (`ω` an integral basis,
  `c·𝓞_L ⊆ R` by `exists_mul_stableIntegers_le` — `ContinuityGroup`'s private `exists_nat_mul_integers_mem` restated with
  its four-line proof as `as_natMul_integers_mem`, since that lemma is not among the eight), `q_j(y) = ω^*_j(y)/c`; only
  `q_j(b_i) = δ_ij` and injectivity of `y ↦ q(y)` are kept. The bound `‖ι(y)‖ ≤ Σ_j |q_j(y)|·‖ι(b_j)‖`
  (`as_norm_archHom_le`) uses a common denominator `N` (`N•y` an integral combination of the `b_j`, by injectivity).
- *Lattice points* `Σ_j z_j • b_j/5^k`: a point with `5^k q(y)` integral is the lattice point (`as_eq_lat`), where
  `χ(y) = exp(i⟨t_k χ, q(y)⟩)` with `t_k(χ)_j = 5^k arg χ(b_j/5^k)` (`as_char_eq_asEv`).
- *Tightness* (`as_tight`): `as_dirichlet` (for `|θ| ≤ π`, `L|θ| ≥ 2π`: `Σ_{n<L}(1 − cos nθ) ≥ L/2`, from the geometric sum
  and Jordan's inequality `Real.mul_le_sin`), averaged and Markov's inequality (`as_measure_far_le`), into
  `isTightMeasureSet_iff_exists_isCompact_measure_compl_le` on `ι → ℝ` (sup norm; the closed ball compact).
- *The limit* (`as_exists_limit`): `isCompact_closure_of_isTightMeasureSet` and `IsCompact.ultrafilter_le_nhds` at
  `Ultrafilter.of atTop`, read through `ProbabilityMeasure.tendsto_iff_forall_integral_rclike_tendsto`; the transform at
  the lattice points is eventually constant along `atTop`.
- *Density* (`as_transform_eq`): `d_m` with coordinates `⌊5^m q(y)⌋/5^m`; `ι(d_m − y) → 0` gives `φ(d_m) → φ(y)` by
  `archTop`-continuity, and dominated convergence the limit's side.
- *Conclusion* (`as_support_prob`): `e(s)(r) = exp(i⟨s, q(r)⟩)`, continuous into the dual; `ρ = e_*μ`
  (`measure_eq_of_fourier`); `range e = ⋃_n e(closedBall 0 n)` measurable and inside `archChars`. The theorem normalises a
  finite `ρ` to a probability.
Private helpers added: 25 (`as_*`, `asT`, `asEv` and their lemmas), names distinct from the module's later helpers. No
import added.

**2.3 Build 1** (`./scripts/build.sh` under the slot, `MEMMAX=10G BATCH=8`; full output `logs/build1-full.log`, gate log
`build/gate/build/20261014T164320Z-3873571.log`): `OK — 256 of 256 batches, 8 module(s) rebuilt, 16 module(s) with
warnings, 8m23s`, exit 0. Rebuilt: `ContinuityGroup`, `BochnerTau`, the five `Count*` modules, `Proofs`. **No warning from
`ContinuityGroup` or `BochnerTau`**; every warning of the build is a ``declaration uses `sorry` `` in another module.

**2.4 Axioms, from the built tree** (`data/fs131/ij3/probes/ax-m2b-built.lean`, `logs/ax-m2b-built.log`):
`bochnerOn_tauPrime` and `archimedean_support` — `[propext, Classical.choice, Quot.sound]`. Sent to the coordinator as one
line (first from the farm compile, `logs/ax-m2b.log`). The full receipts of § Done means item 4 are the last stage's.

**2.5 Lane A, `exists_admissiblePair`: the plan, and its price** (sent to the coordinator; not proved here).
*Read aloud:* over every real number field `F` there are unit vectors `u, w` of `F²` such that `(a, b) ↦ u^a w^b` is
injective on `ℤ²` and, for every finite-index `Λ ⊆ ℤ²`, the values on `Λ` generate `F(i)`. *Route* (X02D's valuation
argument at one degree-one prime; `AdmissiblePair.ofPow`): an odd prime `p` and a prime `𝔓` of `𝓞_L` of degree one,
unramified; `(z) = 𝔓^h`; `w = z/z̄`; then `ℚ(w^k) = L` for every `k ≥ 1`: if `w^k ∈ M ⊊ L`, every prime of `𝓞_L` above
`𝔭 = 𝔓 ∩ 𝓞_M` contains `z` (the valuation of `w^k ∈ M` at `𝔭` is positive), so it is `𝔓`, and `Σ e·f = [L : M]` with
`e = f = 1` gives `[L : M] = 1`; `u` the same at a second prime, independence by the valuations at the two primes.
*Leaves (private helpers):* A1 Schur — infinitely many primes divide values of a monic integral polynomial (~80); A2 a
degree-one unramified odd prime — a residue map `𝓞_L → ℤ/p` through `discr · 𝓞_L ⊆ ℤ[θ]`
(`discr_mul_isIntegral_mem_adjoin`), unramified by `not_dvd_discr_iff_forall_mem` (200–300); A3 a principal power,
class group finite (30–50); A4 `𝔓̄ ≠ 𝔓` (conjugation fixing `𝓞/𝔓 = ℤ/p` puts `2i` in `𝔓`) (40–70); A5 the core over
`𝓞_M` with `Ideal.sum_ramification_inertia` (300–450); A6 independence (100–150); A7 assembly (60–100). **Price: 800–1,250
lines, about 1,000 — from the plan, not from proved leaves.** No archimedean replacement exists: for totally real `F`, `L`
is CM and every conjugate of a unit vector lies on the unit circle. Messaged to the coordinator with the proposal to take
the split next (it takes the pair as an argument) and leave lane A to a job of its own.

## Stage 3 — SAVED: the split, `Rigidity/EntropySplitMax`, its five leaves

Written against `data/fs131/ij3/work/EntropySplitMax.lean` (rounds `logs/ES-1.log` … `ES-4.log`, the last exit 0 with **no
warning**, in the farm with the lakefile's two options), then copied over the module: `git diff` removes the five
`sorry` lines and adds proofs and one private helper. About 135 lines against KN8's plan (no number given there; its
§ 3.4 per-leaf routes all went through as planned). **Re-priced:** the split was the cheapest lane of the job; the
two hard leaves (KN8's "(i)'s measurability name, and (ii)'s complex-valued conditional expectation") are
`StronglyMeasurable.integral_condExpKernel`, `setIntegral_condExp` and `condExp_ae_eq_integral_condExpKernel`, which take
`ℂ`-valued functions directly.

| leaf | route |
|---|---|
| `rotInv_sub_maxMultiple` | KN8's line: `map_sub_maxMultiple` at `MeasurableEquiv.smul g` |
| `measure_haarSet_eq_zero` | KN8's (i)–(iv); (i) stated as its own private lemma `measurableSet_haarSet` (KN8's advice), read by step 3 |
| `ksEntropy_eq_zero_of_not_smul_le` | KN8's line: the decomposition, the null Haar set under the trim, Lemma Γ almost everywhere, `ksEntropy_bind_eq_zero` (preservation from `ErgodicSMul`'s invariance, `measurePreserving_smul`) |
| `entropySplit_of_admissiblePair` | KN8's line; `IsFiniteMeasure` of the remainder by `isFiniteMeasure_of_le` and `Measure.sub_le`; `p.u ∈ p.subgroup` at `n = ![1, 0]` |
| `not_smul_dualHaar_le_dirac_one` | KN8's line: at `{1}ᶜ`; Haar null there would make its coefficient at `1` equal to `1` |

Built at the next build (§ the last stage). The split's records rest on Lemma Γ and so on the leaves open in
`Rigidity/Pieces` and below (`haar_or_zero_entropy`): their axioms are the last stage's print.

## Stage 4 — SAVED: M5-E, `Rigidity/EntropyFibres`, its nine leaves

Written against `data/fs131/ij3/work/EntropyFibres.lean` (rounds `logs/EF-1.log` … `EF-10.log`, the last exit 0 with **no
warning**), copied over the module: `git diff` removes the nine `sorry` lines (and the `by` of the one-line
`measurable_blockLabel`), adds proofs and **one ruled binder drop**: `omit [IsTopologicalAddGroup X] in` above
`exists_pattern_names_le`, whose proof reads no topological group structure (the `unusedSectionVars` linter named it once
the proof was in; item 726's word, as the brief rules). No other statement, docstring or import changed. About 390 lines.

| leaf | route |
|---|---|
| `measurable_blockLabel` | `measurable_of_countable` after `measurable_pi_lambda` (KN9) |
| `blockEntropy_iterate` | the word equivalence `(Fin (q·n) → Fin k) ≃ (Fin n → Fin (k^q))` from `finProdFinEquiv`, `Equiv.curry`, `finFunctionFinEquiv`; `observationEntropy_equiv` (KN9) |
| `ksEntropy_eq_zero_of_iterate` | the infimum at index `q(n+1) − 1`; `a/(qm) ≤ a/m` for `a ≥ 0`, both `ofReal` zero otherwise (KN9) |
| `ksEntropy_finite_mixture_eq_zero` | `Kernel.ofFunOfCountable`, the uniform probability, `Measure.bind_apply`, `ksEntropy_bind_eq_zero` (KN9) |
| `observationEntropy_comp_le` | fibre masses add (`measureReal_biUnion_finset`), the port's `negMulLog_sum_le` on the fibre written as an `if`, `Finset.sum_comm` (KN9) |
| `exists_sectionPartition` | KN9's route; `U = U₀ ∩ −U₀` from `exists_open_nhds_zero_half`; `Q` the least covering index (`Finset.min'`); the image of a Borel set of a translate through `IsOpenEmbedding.of_continuous_injective_isOpenMap` and `IsOpenEmbedding.measurableEmbedding` under a local `borel` instance |
| `exists_pattern_names_le` | KN9's pattern `R₀ x i ∈ Option (Fin l × Fin k)`, encoded by `Fintype.equivFin`; its cells are preimages of images of measurable subsets of cells (`himg`); the names of `P` are determined by `Q` at time zero and the names of `R` (induction along the orbit); then `observationEntropy_comp_le`, `observationEntropy_joint_le`, `finiteShannon_le_log_card` |
| `ksEntropy_eq_zero_iff_of_finite` | `ksEntropy_map` at `borel (X ⧸ G)` (the induced map continuous by `continuous_coinduced_dom`); `⇒` by the two lemmas above and `exists_blockEntropy_le_mul` with `n ≥ 2 log k / ε`; `⇐` by `ksEntropyOn_le_ksEntropy` (KN9) |
| `finFour_fibre_model` | the five clauses directly |

**Re-priced:** M5-E's first two leaves were 2 and 25 lines; the lane came to about 390 lines, with the finite-fibred trio
about 300 of them.

## Stage 5 — SAVED: M5-P, `Rigidity/PositiveEntropy`, six of its ten leaves

Written against `data/fs131/ij3/work/PositiveEntropy.lean` (`logs/PE-1.log`, `PE-2.log`, the last exit 0 with no warning
but the four remaining leaves' ``declaration uses `sorry` ``), copied over the module; `git diff` removes six `sorry` lines.
Proved, each by KN9's route: `ZdAction.two_le_of_not_isVirtuallyCyclic` (`interval_cases`; `n = 0` at `d = 0`, `n = 1` at
`d = 1`), `ZdAction.coe_nsmul` (induction), `ZdAction.map_eq_of_isAddHaarMeasure` (`g + α^n x = α^n(α^{−n} g + x)`,
`isAddHaarMeasure_of_isCompact_nonempty_interior` at `univ`, `isAddHaarMeasure_eq_of_isProbabilityMeasure`),
`ZdAction.invariantComponent_model`, `finTwo_haar_model` (`map_add_right_eq_self` for the counting measure),
`isAddHaarMeasure_of_add_invariant`. **Left:** `noVirtuallyCyclicFactors_of_isIrreducible`,
`eq_of_isErgodicOn_of_invariant_component`, `mulTwoThree_model`, `haar_or_zero_entropy`.

## Stage 6 — SAVED: M5-P's deduction — `haar_or_zero_entropy` proved; `mulTwoThree_model` left

`logs/PE-3.log`, `PE-4.log` (the last exit 0, the only warning `mulTwoThree_model`'s ``declaration uses `sorry` ``).
Proved, each by KN9's decomposition (§ 2.4 there): `ZdAction.noVirtuallyCyclicFactors_of_isIrreducible` (a continuous
additive map into the finite `Y` has a clopen zero set, so it is `0` on the connected `X`; then `α m = α (k • n)`),
`ZdAction.eq_of_isErgodicOn_of_invariant_component` (`A = ⋂_{k ≠ j₀}` null sets, `A′ = ⋂_n (αⁿ)⁻¹ A` exactly invariant
by reindexing, ergodicity, and every other component would give `A′ᶜ` mass), and **`haar_or_zero_entropy`** — the
declared `positive_entropy_rigidity` read as stated (no `PolishSpace`); Case A by `isAddHaarMeasure_of_add_invariant`,
`map_eq_of_isAddHaarMeasure` and the invariant component; Case B by total irreducibility at `Λ` (each `G j` finite),
`ksEntropy_eq_zero_iff_of_finite` on clause (4), `ksEntropy_finite_mixture_eq_zero`, and `coe_nsmul` with
`ksEntropy_eq_zero_of_iterate` at `q = [ℤ^d : Λ]`. It rests on the declared axiom; its record is printed in the last
stage. **Not proved: `ZdAction.mulTwoThree_model`** (the model of FS105-NVC's hypotheses: `×2, ×3` on `ℝ` irreducible and
not virtually cyclic). Its route is KN9's (closed subgroups of `ℝ` are `0`, `cℤ` or `ℝ`; `cℤ` is not doubling-invariant;
`2^a 3^b = 1` forces `a = b = 0`), priced at 100–150 lines; left at my budget, it is on no consumer's path.

## Stage 7 — SAVED: the receipts (builds 3 and 4, no statement changed, the axioms, the lint), Amendment 1, and the drafts

**7.1 Two more edits after the lint.** The environment lint after build 2 (`logs/lint-after.log`, exit 1) reported two
`unusedArguments` findings in my files, each named: `archHom`'s `[NumberField ↥F]` (exposed by its publicity) and
`ZdAction.map_eq_of_isAddHaarMeasure`'s `[T2Space X]` (unread by my proof). The second binder is dropped under item 726's
word; for the first, Amendment 1 (2026-10-14 17:16 UTC) ruled `@[nolint unusedArguments]` on `archHom` with a one-line
`--` reason, item 863's remedy for `archTop` — done (`ContinuityGroup` l. 56–57; the whole file's diff against
`226eae199` is the eight `private`s and these two lines). That red run is the lint's control.

**7.2 Builds.** Build 3 (the drop; `logs/build3-full.log`): OK, 4 modules rebuilt, 6m56s. **Build 4** (the attribute;
`logs/build4-full.log`, gate log `build/gate/build/20261014T172310Z-4023754.log`): `OK — 256 of 256 batches, 8 module(s)
rebuilt, 14 module(s) with warnings, 7m58s`, exit 0. **Warnings from my seven files: only the remaining leaves'**
``declaration uses `sorry` `` — `PositiveEntropy` l. 365 (`mulTwoThree_model`), `ChainAtTA` l. 550, 555, 562
(`entropySplit`, `zeroEntropyCarried`, `noRamifiedStableDyadic_of_tca`), `UnitCircle` l. 219 (`exists_admissiblePair`).
No other warning in the build.

**7.3 No statement and no definition changed, from the kernel's side** (stage 1's dump against build 4's,
`statements-after.txt`, 269 MB, `.xz` + sha256; reader `tools/fs131_ij3_statements.py`, new): **PASS**
(`statements-compare.out`) — 867 named constants of the 41 modules (kind, module, stored type), 210 data definitions'
values, 4 example heads of my files; the ruled changes and nothing else: **the eight `RULED PUBLIC`** (and
`archHom.congr_simp`, generated with it), each stored type equal after the private names are replaced by the public
ones everywhere (23 stored terms of the first dump touched); **two `RULED DROP`**, each type the first with exactly the
named binder removed (hygienic binder names compared up to renaming: dropping a binder renumbers the later ones);
**one `PROOF-ONLY VALUE`**: `BochnerTau`'s private `uFive`, whose value now cites the elaborator's shared auxiliary proof
`asT._proof_1` where it cited `uFive._proof_1` (both theorems; its data with proofs erased is equal). No new public
constant; 25 new private constants (24 `BochnerTau`, 1 `EntropySplitMax`); the only axiom the declared one, unchanged.
**Control** (`--control`, ten plants: a leaf's statement, a definition's value, a leaf gone, a definition's type, a move,
a new public, an axiom, a kind, a publicized lemma left private, an unruled binder drop): **10 of 10 reported**
(`statements-control.out`). The reader's three readings (generated suffixes follow their lemma, binder renaming, shared
auxiliary proofs) were added after its first run reported them, each looked at before it was accepted.

**7.4 The axioms of every declaration of my seven files** (`lean/Axioms.lean` → `axioms-after.txt`; reader
`tools/fs131_ij3_axioms.py` → `axioms-verdict.out`): **PASS**, 213 records — `BochnerTau` 79 CLEAN; `ContinuityGroup` 28
CLEAN; `UnitCircle` 32 CLEAN, 1 OPEN-LEAF (`exists_admissiblePair`); `EntropySplitMax` 8 CLEAN, 2 IMPORTED
(`ksEntropy_eq_zero_of_not_smul_le`, `entropySplit_of_admissiblePair`); `EntropyFibres` 10 CLEAN; `PositiveEntropy` 11
CLEAN, 2 IMPORTED (`haar_or_zero_entropy`, `positive_entropy_rigidity_of_polishSpace`), 1 OPEN-LEAF (`mulTwoThree_model`);
`ChainAtTA` 34 CLEAN, 5 OPEN-LEAF (its three leaves and `mrPlus`, `min_localBound_five_le_chromaticNumber_closed` over
them). Each OPEN-LEAF's `sorry` is sourced in a leaf this job leaves open. The planted record
(`positive_entropy_rigidity_of_polishSpace`, under `PLANT`) is reported resting on the declared theorem; `--control`:
4 of 4 (`axioms-control.out`).

**7.5 Lint and architecture.** `lake lint --no-build -- --no-build --trace` after build 4 (`logs/lint-after2.log`): exit
0, 14 of 14 Passed, `-- Linting passed for Proofs.` (control: § 7.1's red run). `tools/check_architecture.py`
(`logs/architecture.log`): RESULT PASS. Not run: `scripts/axioms.sh`, `assumptions.sh`, `vacuity.sh`, `dupnames.sh` (the
landing's; my new constants are private, but the eight are new public names — none clashes in `Proofs/`, § 2.1).

## Drafts for the landing (files this job does not write; each names its slot)

**The audit's block** (`scripts/Axioms.lean`): `data/fs131/ij3/draft-axioms-block.lean` — 38 `#print axioms` lines for
the CLEAN section (after FS131-IJ2's block) and 3 for the IMPORTED section (`entropySplit_of_admissiblePair`,
`ksEntropy_eq_zero_of_not_smul_le`, `haar_or_zero_entropy`, each resting on `positive_entropy_rigidity`, whose
`declareImport` line the landing adds with the axiom), generated from build 4's print.

**The models** (`LEAN.md` § The gate). `archimedean_support`: the point mass at the trivial character (transform `1`,
continuous for every topology); its consumer's model as in IJ2. The split: `dualHaar` and the point mass (the module's
docstring); `not_smul_dualHaar_le_dirac_one` is the model of steps 2 and 3, a theorem now. M5-E: `finFour_fibre_model`
(a theorem now) for the finite-fibred trio; the point mass and the identity for the power and the mixture. M5-P:
`invariantComponent_model`, `finTwo_haar_model` (theorems now); `mulTwoThree_model` stays open, so FS105-NVC's hypotheses
have a stated, unproved model; `haar_or_zero_entropy`'s hypotheses have none in the library (PE-1′ supplies them, its
docstring says). Each names objects for the hypotheses they satisfy only; no new declaration.

**`LEAN.md` § Searching — Lean**, seven lines (`data/fs131/ij3/draft-lean-md.txt`, each to follow the last line there).

**Docstrings owed** (to the sweep): `ZdAction.map_eq_of_isAddHaarMeasure`'s "(a compact Hausdorff group is locally
compact)" — no `T2Space` is read now; `BochnerTau`'s module docstring route (1) names "lift … through a box fundamental
domain", the proof goes by the scaled arguments `t_k` instead.
