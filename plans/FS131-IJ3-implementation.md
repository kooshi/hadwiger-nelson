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
