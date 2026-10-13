# FS131-KN3 — the chain under "the plane over the field of √47 needs five colours": its hypotheses as closed statements about a field, its first layer typed, and the rest cut into modules

*de Bruijn, the planner. Brief: `data/fs131/briefs/FS131-KN3-chain-plan.md`. Branch `fs131-wch`, worktree
`.claude/worktrees/fs131-wch`. Claims: `data/fs131/claims-NF2.md`. Stands on `plans/FS131-KN1-number-field-kernel-map.md`
(the map) and `plans/FS131-EN1-derivation.md` (the deriver's reading, § 8.1 its table).*

## Theorems this phase proved

A planning job: the chain's leaves are not proved. What the kernel checked, one file at a time under `lake env lean` (not
through `./scripts/build.sh`, not at the gate; axiom lists from `data/fs131/kn3/logs/FirstLayerCheck.log`):

- `Rigidity.positive_entropy_rigidity_model` — [kernel, standard three] — `Rigidity/PositiveEntropy.lean`: the hypotheses of
  the declared theorem have a model (degenerate).
- `Rigidity.ZdAction.isVirtuallyCyclicMod_bot`, `Rigidity.isSolenoid_unit`, `Rigidity.trivialAction_noVirtuallyCyclicFactors`,
  `Rigidity.trivialAction_isErgodicOn` — [kernel, standard three; the file has no `sorry`] — `Rigidity/Solenoid.lean`.
- `Rigidity.ksEntropy_zero_measure`, `Rigidity.measurableSet_nameCell`, `Rigidity.ksEntropyOn_mono` — [kernel] — `Rigidity/Entropy.lean`.
- `Rigidity.mrPlus_of_split_of_carried` (EN1-FROM-TWO), `Rigidity.five_le_chromaticNumber_of_mrPlus` (EN1-SPCOR's composition),
  `Rigidity.min_localBound_five_le_chromaticNumber_of_closed` (the headline with closed hypotheses) — **compositions checked
  over leaves that are `sorry`** (`exists_nonTorsion_unitVector`; `measurableSet_TA`, `rot_preimage_TA` under
  `chainInterface`): the kernel prints `sorryAx` for each, so none is a theorem of the library yet — `Rigidity/ChainAtTA.lean`.

Declared, not proved: the axiom `Rigidity.positive_entropy_rigidity` (`[EinsiedlerLindenstrauss2022]` Thm 1.3).

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_kn3_readback.py` compares, character for character, (a) every `> NF2-…:` line of the brief with the line of
that id in `data/fs131/claims-NF2.md`, and (b) every `NF2-LEAF-nn` of the claim list with item `nn` of the map's "The
chain's leaves, in dependency order", the paragraph joined into one line.

- (a) 16 quotations, **identical**. (b) 23 leaves against 23 map items, **identical**; no map item without a claim.
- Control (`--plant`): one character changed in `NF2-MRPLUS` and one in map item 13, in memory; both reported.

No mismatch; nothing for the coordinator from the readback of text.

### 1.2 The kernel theorems of the chain, read in the source

Read in full: `Proofs/HadwigerNelson/SpectralChain.lean` (649 lines). Read at the definitions the chain names:
`Arith/CharacterColouring.lean` (`torsionBy`, `archimedean`), `Arith/SpectralInputs.lean` (`IsHaarFourier`, `contChars`,
`BochnerOn`).

**The objects.** `unitVectors F : Set ℂ`; `unitRing F : Subring ℂ` (`R = ℤ[U]`); `Dual F := AddChar (unitRing F) Circle`
with the cylinder σ-algebra `dualMeasurableSpace` (the comap of the product σ-algebra under `χ ↦ (g ↦ (χ g : ℂ))`) and
**no topology**; `rot u χ := χ.compAddMonoidHom (mulLeft (uvRing u))`; `RotInv F τ := ∀ u, τ.map (rot u) = τ`.
`Measure` in Lean is a positive measure: the deriver's "finite positive measure" is `IsFiniteMeasure τ` and nothing more,
so the signed reading that fails cannot be typed by accident.

**The interface** (`Interface F`, ll. 130–144): `E TA : Set (Dual F)`, both measurable, `TA ⊆ E`, `rot u ⁻¹' E = E`, and
`h : Measure (Dual F) → unitVectors F → ENNReal`. All free data. Its `Prop`s:

| `Prop` (line) | reads of the interface | closed at `E := TA := T + A`, `h :=` entropy? |
|---|---|---|
| `Interface.RU` (161) | `E \ TA` | yes, and then it says `τ ∅ = 0`: true, one line |
| `Interface.APlus0` (169) | `TAᶜ` | yes: a sentence about `F` |
| `Interface.PE2` (177) | `E` (the Haar part is `E`-null), `h` | yes — but its third conjunct `τH I.E = 0` then asks `m(T + A) = 0`, which no proof on the path uses (§ 1.3) |
| `Interface.EFPlus` (186) | `h`, `TAᶜ` | yes |
| `Interface.MR` (192) | `E` | yes: it is then MR⁺(F) word for word |
| `Interface.R88TCA` (315) | `TAᶜ` | yes |
| `Interface.APlusOfR88` (320) | through the two above | yes |
| `Interface.Count` (326) | through `R88TCA`; `TCA F` is closed already | yes |

**The headline** `min_localBound_five_le_chromaticNumber [NumberField F]` (l. 595) takes: `hBH : BochnerHerglotz (unitRing F)`
and `hL1 : InvariantMeasureOnClosed F` — closed already, classical, to be formalized (ruling 4); `I : Interface F` — free;
`hTR`, `hCX : … → I.Count`; `hAP : I.APlusOfR88`; `hRU : I.RU`; `hMR : TCA F → I.PE2 ∧ I.EFPlus`; `hCLS : 5 ≤ localBound F →
TCA F` and `hRow99` — closed already. So **what it takes to close every hypothesis is two terms and no more: a set
`TA F : Set (Dual F)` with its measurability and rotation-stability, and an entropy `Measure (Dual F) → unitVectors F →
ENNReal`.** Everything else in the first layer is what the two deductions' *proofs* need to be statable (the pieces, Haar
with a topology, the printed theorem).

**The proved links, and what each reads** (checked in the source, not from the map):
- `Interface.mr_of_pe2_efPlus` (196): binds `hHE` at l. 198 and never uses it; uses `E` only through `TA_subset_E` (l. 204).
- `Interface.x4_eq_empty` (519): uses `measurableSet_E`, `measurableSet_TA`, `rot_preimage_E`, `TA_subset_E`, `hRU` (l. 544),
  `hA`, `hMR` at `τ := σ.restrict Eᶜ`.
- `Interface.five_le_chromaticNumber` (568), the headline (595), `…_of_totallyReal` (616), `chromaticNumber_eq_localBound` (626).

### 1.3 What the readback fixes for the architecture

1. **The interface is kept, with one concrete instance beside it** — not replaced. `Interface.x4_eq_empty` and the headline
   are through the gate and are exactly the compositions wanted; at the instance `E := TA := T + A` their hypotheses are
   closed. No gated statement changes.
2. **The entropy split is restated beside `Interface.PE2`, not discharged through it** (the deriver's first question).
   `Interface.PE2` at `E := T + A` carries the conjunct `τH (T + A) = 0`, i.e. `m(T + A) = 0` — J45-N1 (c) at `S = ∅`, which
   the deriver's walk puts off the path and which no proof on the path reads. Proving it to feed a clause nobody reads
   would put an off-path hand result back on the path. So the first layer states PE-2 in the page's own form — `τ = a • m
   + τ′` with `m` Haar and `h_{τ′}(u) = 0` — and proves MR⁺ from it and EF_F⁺ by the deriver's five lines (EN1-FROM-TWO),
   a new theorem beside `Interface.mr_of_pe2_efPlus`. The headline is then fed `I.MR` directly, through a variant of
   `five_le_chromaticNumber` that takes `hMR` (it is `x4_eq_empty` and three lines). What a landing would retire: nothing
   is retired; `Interface.PE2` stays as the abstract form and stops being a hypothesis of any closed statement.
3. **MR⁺'s scope hypothesis.** The deriver's line: MR⁺ holds for `R_F = O′`. The headline takes `hMR` under `TCA F`, and
   `TCA F` excludes a ramified stable dyadic place (ratio `1/2` there; the headline's docstring l. 592). So the scope is a
   hypothesis of EF_F⁺'s closed statement, and the module that proves "`TCA F` ⟹ no ramified stable dyadic place" is one
   of the leaves (the deriver's row 14; § the architecture).

## Stage 2 — SAVED: §G and §PA, short

### §G — the grokkings that bear on a chain this long (read by number in `.claude/skills/grokkings/SKILL.md`)

- **G92** (a held result reaches as far as its argument, not as far as its statement). Its *Do* is this job's method: each
  hypothesis is restated at the class its proof reads. Three uses here: `Interface.PE2`'s Haar-null clause is dropped
  because no proof reads it (§ 1.3); EF_F⁺ is typed at its own strength (one non-torsion `u*`), not in the weakened form
  the interface carried; the scope is carried by the one statement whose proof reads it (EF_F⁺), not by MR⁺'s consumers.
- **G80** (infinite rank is the resource). It fixes what "the pieces" are for: Theorem 1.3 is applied on finitely generated
  pieces `M̂`, never on `R̂`, where no finitely generated subgroup acts irreducibly (row 118). So the printed theorem is
  declared for an abstract solenoid, and the passage `M̂_k → R̂` (Lemma Γ) is ours and a module.
- **G21** (a negative measures its enumeration; the defects that flatter survive). Applied to an axiom: the check on
  `positive_entropy_rigidity` is the read-back against the page, clause by clause, and the direction of every choice the
  Lean statement makes is recorded as "weaker than the page or equal to it" (§ The four items).
- `LEAN.md` § The kernel's cost model is about reduction; this chain evaluates nothing in the kernel. What does bear:
  § Searching — Lean, "never state one lemma under one name in two modules that do not import each other" (the later
  modules are cut so that every shared definition is upstream of both users: § The architecture), and "a section
  `variable` enters a theorem only if the statement mentions it" (every leaf below is `#check`ed as the kernel has it).

### §PA — each printed statement the chain reads

| statement | where printed | held? | Mathlib at the pin / other Lean |
|---|---|---|---|
| **positive entropy rigidity** | `[EinsiedlerLindenstrauss2022]` Thm 1.3, § 1.1, pp. 2–3 of arXiv:2101.11120v1; Thm 1.2 on p. 2 | **held** (`~/source/library/pdf/EinsiedlerLindenstrauss2022-…pdf`); pp. 1–4 read by me today from the PDF's text layer, both statements and the three definitions on p. 2 copied into the module docstrings | none: no solenoid, no `ℤ^d`-action vocabulary, no entropy. `PontryaginDual` (`Topology/Algebra/PontryaginDual.lean`), `ContinuousAddEquiv`, `AddSubgroup.FiniteIndex`, `QuotientAddGroup.map`, `QuotientAddGroup.measurableSpace`, `Measure.MutuallySingular`, `Measure.IsAddHaarMeasure` are there and are what the statement is typed with |
| Kolmogorov–Sinai entropy | textbook (Walters, *An Introduction to Ergodic Theory*, ch. 4 — recalled, not held, not read) | no page held | none (`Dynamics/TopologicalEntropy/` is topological; `Real.negMulLog`, `binEntropy`, `InformationTheory.klDiv` static). **`[OAIMath2026]` family 015**, `~/source/math/lean/OAI/NumberTheory/DukePrimeDegree/Entropy/MetricEntropy.lean` (51 lines, read in full today): `metricEntropy` in the same shape as `Rigidity.ksEntropy`; `PeriodicEntropyZero.lean` proves zero entropy for an almost-everywhere periodic map (statements read). The rest of `Entropy/` (20,958 lines by `wc`) unread: the planner of module M1 reads it before proving Abramov's formulas from scratch |
| Thm 1.2's proof | attributed on p. 2 to `[EinsiedlerLindenstrauss2003]` Thm 1.1 | held; `BIBLIOGRAPHY.md`: read in full by FS105-R, "an announcement … only 'a sketch'" | — ; **no complete printed proof found**, so ruling 2 stands |
| ergodic decomposition (T1), entropy along increasing σ-algebras (T2), Jacobs (T3) | **no page cited in any record** (X02D l. 175: "exact theorem numbers not checked here") | — | none ("ergodic decomposition" not in Mathlib; `Ergodic`, `ErgodicSMul`, `condExp`, martingale convergence `MeasureTheory.tendsto_ae_condExp` are). **A prior-art debt carried forward to modules M7 and M8, whose planners name the page before typing** |
| Shannon–McMillan–Breiman, almost-everywhere form, not ergodic | X01D ll. 237–239 cites `[EinsiedlerFish2010]` Thm 2.1 | the paper is held and read in full (bibliography) | none |
| Herglotz–Bochner; Markov–Kakutani; Chebotarev; `[AmbrusEtAl2023]`; Weil | the map's § X5 | as there; not re-read by me | as there |

**Not worked around:** nothing was fetched. **Not read by me:** `[EinsiedlerFish2010]`, `[EinsiedlerLindenstrauss2003]`,
the paper's §§ 2–9 (the bibliography records who read which).

## Stage 3 — SAVED: the vocabulary typed (three modules elaborate)

`Proofs/HadwigerNelson/Rigidity/Entropy.lean` (3 leaves `sorry`), `Rigidity/Solenoid.lean` (no `sorry`),
`Rigidity/PositiveEntropy.lean` (the axiom; its model; Thm 1.2 stated, `sorry`). Elaborated one file at a time by
`data/fs131/kn3/lean1.sh <module>` (under the slot at `--mem 4`, which the files stay inside; logs in
`data/fs131/kn3/logs/`, last line `exit=<status>`); **not yet through `./scripts/build.sh`** — another planner's build
held the machine's one build slot.

**The definitions, and the form each was weighed against** (sent to the coordinator when typed):

1. **`ksEntropy`** — label maps `P : X → Fin k`, `nameCell`, `blockEntropy` (Shannon entropy of the names of length `n`),
   `partitionEntropy` (a `liminf` of `H_{n+1}/(n+1)`), a supremum over *measurable* label maps. **`ksEntropyOn 𝒜`** is the
   same supremum over `𝒜`-measurable labels and is the leaf's "conditional form": in X02D § 3.1 step 3,
   `h_ρ(γ | 𝒜_k)` is the entropy of the factor `(M̂_k, ρ_k, γ)`. Against: a separate relative entropy `H(· | 𝒜)`, read by no
   statement of this layer.
2. **`IsSolenoid`, `ZdAction`, `IsIrreducible`, `IsTotallyIrreducible`, `IsVirtuallyCyclic`** — the page's sentences
   (p. 2), additive. `ZdAction` is a structure (a map `ℤ^d → (X →+ X)` with `α^0 = id`, `α^{m+n} = α^m ∘ α^n`, each
   continuous). Against: Mathlib's `DistribMulAction (Multiplicative (Fin d → ℤ)) X`, a class, awkward to restrict to `Λ`.
3. **`NoVirtuallyCyclicFactors`** — FS105-VC's forced sense, with "virtually cyclic on `X/Y`" as the page's sentence read
   modulo `Y` (`IsVirtuallyCyclicMod`); `isVirtuallyCyclicMod_bot` proves the two definitions agree at `Y = 0`.
4. **`IsErgodicOn Λ μ`** — invariance under every `α^n`, `n ∈ Λ`, and every strictly invariant measurable set null or
   conull.

**Inhabitants and drift checks.** `ksEntropy_zero_measure` (proved); `isSolenoid_unit`,
`trivialAction_noVirtuallyCyclicFactors`, `trivialAction_isErgodicOn` (proved), assembled as
`positive_entropy_rigidity_model`; `example : (ZdAction.trivial 2 Unit).IsVirtuallyCyclic` (the trivial action is virtually
cyclic, so the clause `Y ≠ ⊤` cannot be dropped). Owed by M1's implementer: `blockEntropy_one`, `ksEntropy_id`,
`ksEntropy_map`, and the two-shift at `log 2`.

## Stage 4 — SAVED: the survey of the outside release's entropy development (Amendment 1)

*A survey by statement: `rg` for definitions and `theorem` heads, and a reading of what it found. `~/source/math` was
read and nothing was written into it or run from it. "Proves" below means: declared as a `theorem` with a proof in a
file where `rg` finds no `sorry` and no `axiom`; I built nothing and read no proof. Release toolchain: Lean 4.34.1
(`plans/STUB-mr-in-lean.md`); this library: 4.32.0.*

### 4.1 What is there

Two directories of `[OAIMath2026]` family 015 carry the entropy development, `OAI/NumberTheory/`:

- **`PrimePackets/`** — 143 files, 58,852 lines: the base. Entropy lives in about a dozen of them; the rest is the
  family's arithmetic and its homogeneous space.
- **`DukePrimeDegree/Entropy/`** — 212 files, 20,958 lines, 604 theorems and lemmas, no `sorry`, no `axiom` (by `rg`). Most
  files are steps of that family's own argument on its lattice space (names such as `RootPrefixTubeInformation`,
  `WholeFutureProbabilityKernel`); about fifteen are general measure-theoretic entropy.

**Its definitions, beside this layer's.**

| release | file | this layer | same number? |
|---|---|---|---|
| `finiteShannon p = Σ negMulLog (p a)`; `observationEntropy μ P = finiteShannon (a ↦ μ.real {P = a})` | `PrimePackets/ShannonEntropy.lean` (453 lines, **`import Mathlib` only**) | `blockEntropy μ T P 1` (the lemma `blockEntropy_one`) | yes, at labels `Fin k` |
| `orbitName T P N y = (j ↦ P (T^[j] y))` | same | `nameCell T P n w = {orbitName = w}` | yes |
| `observationEntropyRate μ T P : ℝ := sInf {H_N / N : N ≥ 1}` | same | `partitionEntropy` (a `liminf` of `H_{n+1}/(n+1)`, in `ℝ≥0∞`) | **for a `T`-invariant probability measure, yes**: `tendsto_observationEntropyRate` (same file) proves `H_N/N` converges to that infimum. For a measure `T` does not preserve the infimum can be smaller than the `liminf`; no statement of this layer reads entropy there |
| `measureEntropy μ T : ℝ≥0∞ := ⨆ k, ⨆ P : Y → Fin k, ⨆ (fibres measurable), ofReal (rate)` | same | `ksEntropy μ T` | yes, under invariance (fibres of a map into `Fin k` measurable ⟺ the map measurable) |
| `metricEntropy T μ` (a `liminf`; labels `Fin (k+1)`) | `DukePrimeDegree/Entropy/MetricEntropy.lean` (51 lines; 5 files name it) | `ksEntropy` | yes, as written; the release's second definition |
| `conditionalSigmaEntropy μ P m = ∫ finiteShannon (a ↦ μ[1_{P = a} \| m]) dμ` — `H(P \| m)` | `PrimePackets/ConditionalSigmaEntropy.lean` (79 lines) | none (not read by this layer's statements) | — |
| `conditionalInformation μ P m y = −log μ[1_{P = P y} \| m](y)` | `DukePrimeDegree/Entropy/ConditionalInformation.lean` | none | — |
| — | — | `ksEntropyOn 𝒜 μ T` (the entropy of the factor `𝒜` is) | not found by name; `observationSigma` and `measureEntropy_eq_iSup_generating` are the nearest |

**Its general theorems, by name and statement head** (the ones a chain about an invariant measure could read):

| theorem | file (lines; imports beyond Mathlib) | says |
|---|---|---|
| `orbitEntropy_subadditive`, `tendsto_observationEntropyRate` | `PrimePackets/ShannonEntropy` (453; none) | `H_{M+N} ≤ H_M + H_N`; `H_N/N →` the rate, for `MeasurePreserving T μ μ` |
| `finiteShannon_le_log_card`, `observationEntropy_joint_le`, `observationEntropy_comp_preserving` | same | `H ≤ log card`; `H(P ∨ Q) ≤ H(P) + H(Q)`; invariance of `H` under a measure-preserving map |
| `measureEntropy_lower_of_good_atoms` | same | if sets `A_N` of mass `≥ w` eventually meet every name-cell of length `N` in mass `≤ C e^{−cN}`, then `h ≥ c·w` |
| `observationEntropyRate_finite_mixture` | `PrimePackets/EntropyMixtures` (540; `ShannonEntropy`) | the rate is affine over a finite convex combination of invariant probability measures |
| `measureEntropy_kernel_zero` | same | **a mixture `κ ∘ₘ τ` of `T`-invariant probability measures of entropy zero has entropy zero** |
| `kernel_entropyRate_le_block` | same | `rate(κ ∘ₘ τ) · N ≤ ∫ H_N(κ z) dτ` |
| `action_ergodic_decomposition` | `PrimePackets/ErgodicDecomposition` (509; `KernelEntropy` → `AtomMass`, `EntropyMixtures`) | **for a countable group `H` acting on a standard Borel space and an invariant probability `μ`: the conditional-expectation kernel on the invariant σ-algebra integrates to `μ` and is `ErgodicSMul H` almost everywhere** |
| `invariant_kernel_decomposition`, `condExpKernel_invariant`, `condExpKernel_ae_constant`, `continuous_action_ergodic_decomposition`, `invariant_probability_unique_transitive` | same | the components are invariant a.e.; a function measurable for the conditioning σ-algebra is a.e. constant on components; a version for a continuous action through a dense subgroup; uniqueness of the invariant probability of a transitive action |
| `positive_entropy_components_ae` (`KernelEntropy`), `ae_positive_component_entropy` (`DukePrimeDegree/Entropy/Entropy`) | — | positive entropy of a mixture gives positive entropy on components (heads only read) |
| `measureEntropy_eq_iSup_generating` | `PrimePackets/EntropyGeneratingSupremum` (56; a chain of four small files: `GeneratingObservationEntropy` 93, `ConditionalProbabilityExpectation` 60, `ObservationSigmaAlgebra` 77, `ObservationConditionalProbability`) | **for finite partitions `Q_n` whose σ-algebras increase and generate the whole σ-algebra, `h_μ(T) = sup_n rate(Q_n)`** |
| `measureEntropy_eq_iSup_finiteGenerating` | `PrimePackets/FiniteGeneratingObservations` (102) | the same along a canonical generating sequence of a countably generated space |
| `conditionalObservationEntropy_tendsto_zero`, `conditionalObservationEntropy_tendsto_sigma` | `GeneratingObservationEntropy`, `ConditionalSigmaEntropy` | `H(P \| Q_n) → 0` along a generating sequence; `H(P \| Q_n) → H(P \| ⨆ σ(Q_n))` |
| `conditionalSigmaEntropy_antitone`, `conditionalSigmaEntropy_tendsto_iSup` | `DukePrimeDegree/Entropy/ConditionalSigmaOrder` (80), `ConditionalSigmaLimit` (68) | `H(P \| m)` decreases in `m`; `H(P \| m_n) → H(P \| ⨆ m_n)` for increasing `m_n` |
| `measureEntropy_inverse` | `DukePrimeDegree/Entropy/EntropyInverse` (92; `ShannonEntropy`) — and `PrimePackets/InverseEntropy` | `h(S) = h(T)` for a left inverse `S` of a measure-preserving `T` |
| `observationEntropyRate_blocks`, `observationEntropyRate_iterate_le` | `DukePrimeDegree/Entropy/FiniteBlockEntropy` (218; `ConditionalOrbitEntropy`, `EntropyMixtures`, `RootSubgroups`) | `rate(T^q, names of length q) = q · rate(T, P)` — Abramov's power formula on a partition; a bound for the iterate |
| `measureEntropy_eq_zero_of_fourth_iterate` | `FourthIterateEntropy` (130) | `h(T⁴) = 0 ⟹ h(T) = 0` (the power 4 only) |
| `measureEntropy_zero_of_ae_periodic` | `PeriodicEntropyZero` (121; reaches `Geometry/`) | an almost-everywhere periodic map has entropy zero |
| `observationEntropyRate_le_of_good_names`, `measureEntropy_eq_zero_of_good_names` | `EntropyUpper` (134; `ShannonEntropy`), `EntropyCover` (69) | names covered by few words on most of the mass bound the rate; subexponential covers give entropy zero |

### 4.2 Each classical statement the chain reads, against that table

| the chain reads (EN1 § 8.1's last paragraph; the map's § X5) | in the release | call |
|---|---|---|
| the definition of entropy; `H_n` subadditive; the limit exists | **there as stated** (`ShannonEntropy.lean`, Mathlib-only) | **port** that one file as the base of module M1, and prove one bridge, `ksEntropy μ T = measureEntropy μ T` for `MeasurePreserving T μ μ` and a probability `μ` (from `tendsto_observationEntropyRate`). `ksEntropy` stays this library's definition and the axiom stays stated over it: a declared theorem should not rest on a copied definition |
| **T1**, the ergodic decomposition for a countable group | **there in a form that would serve, for existence** (`action_ergodic_decomposition`: standard Borel, any countable group). **Uniqueness of the representing measure**, which X02D § 3.2 cites three times (ll. 205, 209, 225), **not found by name** among the file's 13 theorems | **port** existence (the cone is to be computed first: the file imports `KernelEntropy`, which reaches the family's `AtomMass`); uniqueness **formalize fresh**, or § 3.2 rewritten on the canonical decomposition, where equivariance is a computation — a question for the derive lane (§ the report) |
| **T2**, `h_ρ(γ) = lim_k h_ρ(γ \| 𝒜_k)` along increasing invariant σ-algebras | **there in a form that would serve** (`measureEntropy_eq_iSup_generating`, for finite partitions generating exactly — which is the chain's case: the evaluations at `r ∈ M_k` generate the cylinder σ-algebra) | **port** the five small files; T2 for `ksEntropyOn` is then a short lemma, formalized fresh |
| **T3**, Jacobs's formula | **the consequence the chain uses is there as stated**: X02D § 3.2 reads T3 only as "a mixture of zero-entropy invariant measures has zero entropy" (ll. 207, 217) = `measureEntropy_kernel_zero`. The formula `h(∫ρ dP) = ∫ h(ρ) dP` itself: not found by name | **port** `EntropyMixtures.lean` (540 lines over `ShannonEntropy` only). **Jacobs's formula leaves the list of statements to declare** |
| Abramov's power formula, `h(T⁻¹) = h(T)` (FS105-DED's C-inputs) | **there** on a partition (`observationEntropyRate_blocks`), `measureEntropy_inverse` | **port** `EntropyInverse` (over `ShannonEntropy`); the power formula's file reaches `RootSubgroups`, so its cone is computed before a call — else fresh from `orbitEntropy_subadditive` |
| Abramov–Rokhlin over a finite-fibred factor (FS105-DED) | **absent by name** ("abramov\|rokhlin": the two directories' hits are `Entropy/Entropy.lean` and `Geometry/Reduction.lean`, heads only read; no theorem so named) | **formalize fresh** in M5, on the ported `H(P \| m)` if its lemmas serve |
| affinity of entropy (FS105-DED) | **there** for finite mixtures (`observationEntropyRate_finite_mixture`) | port, with `EntropyMixtures` |
| **Shannon–McMillan–Breiman**, almost-everywhere form (EF_F⁺'s Lemma 3.1′) | **absent by name** (no "mcmillan", "breiman"; no almost-everywhere convergence of an information function found by name). Present: the two ways the theorem is *used* — `measureEntropy_eq_zero_of_good_names` and `measureEntropy_lower_of_good_atoms` | **formalize fresh, after one question to the derive lane**: whether Lemma 3.1′'s Steps 4–5 can run on convergence in mean along a subsequence of scales chosen summable (Markov's inequality on the information function and Borel–Cantelli), which needs no almost-everywhere theorem. The deriver left exactly this open (EN1 § 7.2) |
| Egorov | Mathlib: `MeasureTheory.tendstoUniformlyOn_of_ae_tendsto` | in Mathlib |
| Herglotz–Bochner, Markov–Kakutani, Chebotarev, strong and weak approximation, Tate's duality, Lusin–Souslin, Kronecker on units, `[LevitzMott1972]`, `[AmbrusEtAl2023]`, Weil | **not in these two directories.** A search by name over the whole release finds no theorem named for Chebotarev (one file mentions it, `CubicMoment/Estimates/PublishedHecke.lean`, unread) and a second development that names the ergodic decomposition (`GroupTheory/PolycyclicRecognition/Analysis/`, unread); the other keywords hit unrelated families (a "solenoidal" recorder, Kronecker deltas) | unchanged from the map's § X5 and ruling 4 |

### 4.3 Does the release state a rigidity theorem of the kind this chain declares?

**It states one, on a different space, and its files carry a proof of it.** `DukePrimeDegree/MainConditional.lean` l. 28
defines `EKLPrimeInput d : Prop` — docstring: "The published rigidity input, on the actual lattice space and with actual
diagonal ergodicity and measure-theoretic entropy" — for `d + 1` prime and `≥ 3`: every probability measure on `X (d + 1)`
(the quotient of `SL_{d+1}(ℝ)` by the image of `SL_{d+1}(ℤ)`, `PrimePackets/PacketAlgebra.lean` l. 18) that is ergodic for
the diagonal group and has `0 < measureEntropy` for the regular diagonal element is the Haar probability. And
`DukePrimeDegree/Entropy/RegularEntropyDischarge.lean` l. 106 declares `theorem eklPrimeInput_unconditional (d : ℕ) :
EKLPrimeInput d`, which `MainUnconditional.lean` uses. So it is a positive-entropy rigidity statement for an invariant
measure — **for the diagonal action on a space of lattices** (the file under it is named `Dynamics/PublishedEKL.lean`), in
prime degree. **Nothing in the two directories names a solenoid or a toral automorphism** (`rg -l -i 'solenoid|toral
automorphism'`: 0 files), so neither Theorem 1.2 nor Theorem 1.3 of `[EinsiedlerLindenstrauss2022]` is stated there.
What this bears on: pricing the formalization of Theorem 1.3 (not this job's) can start from a Lean development that
carries the same method's vocabulary — leafwise and conditional measures, entropy contributions, the low-entropy and
high-entropy cases — for another group.

### 4.4 What the survey changes in the architecture

- **A new module M0, "the entropy base, ported"** — a port job with its own brief (the generator and read-back of
  `LEAN.md` § Assumptions: `tools/fs132_i2_port.py`'s method), in this order of certainty: `ShannonEntropy.lean`
  (Mathlib-only), `EntropyMixtures.lean`, `EntropyInverse.lean`, the five files under
  `measureEntropy_eq_iSup_generating`; then, cone permitting, `action_ergodic_decomposition` and
  `observationEntropyRate_blocks`. Friction named by the release itself: 1,502 Mathlib commits between the pins.
- **M1** (entropy, ours) shrinks to: the three leaves typed here, the bridge to the ported `measureEntropy`, T2 for
  `ksEntropyOn`, and the two-shift model.
- **M7** (from `Γ` to `U`) loses Jacobs's formula as an input and takes T1's existence from the port.
- **M8** (the pigeonhole at the field) keeps Shannon–McMillan–Breiman as its one open classical input, behind a
  question to the derive lane.

## Stage 5 — SAVED: the first layer compiles

Four modules under `Proofs/HadwigerNelson/Rigidity/`, in `Proofs.lean` and in `ARCHITECTURE.md`'s map
(`tools/check_architecture.py`: FAIL "module coverage" with the rows absent, PASS with them):

| module | holds | `sorry` |
|---|---|---|
| `Rigidity/Entropy` | `nameCell`, `blockEntropy`, `partitionEntropy`, `ksEntropyOn`, `ksEntropy` | 3 leaves |
| `Rigidity/Solenoid` | `IsSolenoid`, `ZdAction` and the page's predicates; the degenerate model | none |
| `Rigidity/PositiveEntropy` | the axiom `positive_entropy_rigidity` (Thm 1.3), its model; `haar_or_zero_entropy` (Thm 1.2) | 1 leaf |
| `Rigidity/ChainAtTA` | `TA`, `chainInterface`, `MRPlus`, `EntropySplit`, `ZeroEntropyCarried`, `NoRamifiedStableDyadic`; MR⁺ from the two; the headline with closed hypotheses | 6 leaves |

**How it was checked, and what was not.** Each file through `lake env lean -DautoImplicit=false
-DrelaxedAutoImplicit=false` under the slot (`data/fs131/kn3/lean1.sh`; every log ends `exit=0`); then
`data/fs131/kn3/FirstLayerCheck.lean` prints ten statements and six axiom lists as the kernel has them
(`data/fs131/kn3/logs/FirstLayerCheck.log`). **Not run: `./scripts/build.sh`.** Another planner's build held the
machine's one build slot each time I looked (18 of 22 GiB, the last look at age 1006 s), and a first build on the laptop
is unmeasured and would have outlived this session; the file-by-file check does not apply the lakefile's linters (a
missing docstring is not reported: `LEAN.md`). The first build is the implementer's or the landing's, by
`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 scripts/slot.py --mem 18 --cpus 10 --name kn3 -- env MEMMAX=18G BATCH=2
./scripts/build.sh` from the worktree. One file took under 4 GiB (the cap it ran under) and under two minutes.

### 5.1 A slip of mine, found by reading the axiom as the kernel had it

The axiom was first written under `variable … [MeasurableSpace X] [BorelSpace X]`. Its statement names no `BorelSpace`, and
**an `axiom` does not take an instance binder its statement does not mention** (the `theorem` beside it, under the same
`variable` line, did): the stored type had no `[BorelSpace X]`, so the axiom said Theorem 1.3 of every σ-algebra on the
solenoid — more than the page, and nothing the page's proof supports. Found by `#check @positive_entropy_rigidity` in
`FirstLayerCheck.lean`, before any commit of the chain module; repaired by writing every binder in the signature. The
print before the repair is kept (`data/fs131/kn3/logs/FirstLayerCheck-before-binder-fix.log`) as the planted fault of
`tools/fs131_kn3_axiom_binders.py`, which reads the kernel's print for the four instance binders: exit 1 on the old
print, naming `BorelSpace X`; exit 0 on the new. **A draft line for `LEAN.md` § Searching — Lean** is in the report.

### 5.2 The statements, read aloud against their claims

- **NF2-MRPLUS / NF2-MRPLUS-SCOPE** ↔ `MRPlus F` and `mrPlus [NumberField F] (h : NoRamifiedStableDyadic F) : MRPlus F`.
  "Every finite rotation-invariant measure on the dual of ℤ[U_F]" = `∀ τ : Measure (Dual F), IsFiniteMeasure τ → RotInv F
  τ`; "that gives T + A measure 0" = `τ (TA F) = 0`; "has every Fourier coefficient off 0 equal to 0" = `∀ r ≠ 0, ∫ χ, (χ r
  : ℂ) ∂τ = 0`. Positivity: `Measure` is positive. The field's hypothesis: on the theorem, not in the definition.
- **NF2-FROM-TWO** ↔ `mrPlus_of_split_of_carried : EntropySplit F → ZeroEntropyCarried F → MRPlus F` — proved, with one
  leaf under it (`exists_nonTorsion_unitVector`, the deriver's step 3: `(3 + 4i)/5`). Kernel: `sorryAx` from that leaf only.
- **NF2-SPCOR** ↔ `five_le_chromaticNumber_of_mrPlus`: R-U is discharged inside it as `τ (TA F \ TA F) = 0`.
- **NF2-LEAF-02** ↔ `chainInterface`, `interface_mr_iff` (`Iff.rfl`), `min_localBound_five_le_chromaticNumber_of_closed`.
- **NF2-LEAF-22** ↔ `mrPlus`; `Interface.mr_of_pe2_efPlus` is not used (its `Prop` `Interface.PE2` carries the unread clause).
- **NF2-LEAF-01** ↔ `TA`, `measurableSet_TA` (leaf), `rot_preimage_TA` (leaf). The leaf's "bridge between the two models of
  a character" is not on the path: nothing in the chain reads `CharacterColouring.torsionBy`.
- **NF2-LEAF-13** ↔ `ksEntropy`, `ksEntropyOn`. **NF2-LEAF-14** ↔ `IsSolenoid`, `ZdAction`, the predicates; the pieces
  `M̂` themselves are module M6's. **NF2-LEAF-15** ↔ not typed here: Theorem 1.3 names no Haar measure; Theorem 1.2 says
  `μ.IsAddHaarMeasure` on the abstract solenoid, and the Fourier form on `Dual F` is `IsHaarFourier` (through the gate
  already). The passage between them is a lemma of M6. **NF2-LEAF-16** ↔ by ruling 2, `positive_entropy_rigidity` (Thm 1.3)
  with `haar_or_zero_entropy` (Thm 1.2) a leaf. **NF2-LEAF-20, -21** ↔ `entropySplit`, `zeroEntropyCarried`.
- **The headline's hypotheses, as the kernel has them**: `BochnerHerglotz (unitRing F)`, `InvariantMeasureOnClosed F`,
  `(chainInterface F).Count`, `(chainInterface F).APlusOfR88`, `EntropySplit F`, `NoRamifiedStableDyadic F →
  ZeroEntropyCarried F`, `TCA F → NoRamifiedStableDyadic F`, `5 ≤ localBound F → TCA F`, row 99's inequality. Nine, each a
  closed statement about `F`; the last form (`…_closed`) takes six of them and rests on the three leaves.

### 5.3 The four items of `positive_entropy_rigidity` (`LEAN.md` § Assumptions) — drafted

1. **Docstring**: `[EinsiedlerLindenstrauss2022]` Theorem 1.3, § 1.1, pp. 2–3 of arXiv:2101.11120v1; the page quoted in
   the module docstring. *Owed:* the journal's page numbers (ETDS 42 (2022) 691–736; I read the arXiv text layer).
2. **Read-back, clause by clause.**

   | the page | the Lean statement | direction |
   |---|---|---|
   | "a `ℤ^d`-action (`d ≥ 2`) by automorphisms of a solenoid `X`" | `IsSolenoid X`, `2 ≤ d`, `α : ZdAction d X`; `[BorelSpace X]` | equal; "compact group" read as Hausdorff |
   | "`α` has no virtually cyclic factors" | `α.NoVirtuallyCyclicFactors` (no closed invariant `Y ≠ X` with the action on `X/Y` virtually cyclic) | **a sense chosen**: the literal phrase is met by no action (FS105-VC, three minds); the paper's own use is Lemma 7.4, p. 32. A reading that asked less of `α` would make the axiom stronger than the page; none is known. **Residual trust: this reading** |
   | "`µ` an `α`-invariant and ergodic probability measure on `X`" | `IsProbabilityMeasure μ`, `α.IsErgodicOn ⊤ μ` | equal (strictly invariant sets suffice for a countable group) |
   | "a subgroup `Λ ⊆ ℤ^d` of finite index and a decomposition `µ = (1/J)(µ₁ + … + µ_J)` into mutually singular measures" | `Λ.FiniteIndex`, `0 < J`, `μ = (J)⁻¹ • ∑ j, ν j`, `∀ i ≠ j, ν i ⟂ₘ ν j`, `IsProbabilityMeasure (ν j)` | probability: the page's "ergodic" and its `1/J`; also forced by (3), singularity and the ergodicity of `µ` |
   | (1) "`µ_j` is `α_Λ`-ergodic" | `α.IsErgodicOn Λ (ν j)` | equal |
   | (2) "an `α_Λ`-invariant closed subgroup `G_j` such that … `µ_j(B) = µ_j(B + g)` for all `g ∈ G_j` and every measurable `B`" | `IsClosed (G j)`, `α.InvariantOn Λ (G j)`, `∀ g ∈ G j, ∀ B measurable, ν j ((· + g)⁻¹' B) = ν j B` | equal (`(· + g)⁻¹' B = B − g`, and `G j` is a group) |
   | (3) "for `n ∈ ℤ^d`, `αⁿ_* µ_j = µ_k` for some `k` and `αⁿ(G_j) = G_k`" | `∀ n, ∃ k, (ν j).map (α n) = ν k ∧ (G j).map (α n) = G k` | equal |
   | (4) "`µ_j` induces a measure on the factor `X/G_j` with `h_{µ_j}(αⁿ_{X/G_j}) = 0` for any `n ∈ Λ`" | `∀ n ∈ Λ, ∀ h, ksEntropy ((ν j).map (mk' (G j))) (QuotientAddGroup.map (G j) (G j) (α n) h) = 0` | equal: the quotient σ-algebra on `X/G_j` is its Borel σ-algebra for a Polish group and a closed subgroup (Mathlib: `QuotientAddGroup.borelSpace`), and a solenoid is compact metrizable (its dual is countable); `∀ h` because the induced map needs the proof that (2) supplies |

   Entropy is `Rigidity.ksEntropy`; that it is the textbook's number rests on module M1's checks (the two-shift at
   `log 2`; the bridge to the outside release's `measureEntropy`).
3. **A model of the hypotheses**: `positive_entropy_rigidity_model` (kernel: the standard three axioms) — degenerate. The
   model that exercises the clause on factors is PE-1′ (module M6); until it lands the axiom's item 3 is met in form only.
4. **`ARCHITECTURE.md` § Trust** — a draft line for the landing, not written now (a skeleton is not a purchase): "`Rigidity.positive_entropy_rigidity`
   — `[EinsiedlerLindenstrauss2022]` Thm 1.3, pp. 2–3; declared; the sense of 'no virtually cyclic factors' is FS105-VC's;
   read back in `plans/FS131-KN3-chain-plan.md` § 5.3". And for `scripts/Axioms.lean`'s IMPORTED section, at the landing:
   one `AxiomAudit.declareImport` line for ``HadwigerNelson.Rigidity.positive_entropy_rigidity`` with every record that
   rests on it. Today no record does (`entropySplit` is a `sorry`), and the audit would fail on an undeclared `axiom`: the
   branch is a skeleton and is not at the gate.

## Stage 6 — SAVED: the architecture

Seventeen modules; a draft claim list for each under `data/fs131/kn3/claims-<id>.md`, written by
`tools/fs131_kn3_claimlists.py` (every leaf line copied by script from the fixed claim list; `--check` compares the files
with a regeneration, and fired on a line edited by hand; its coverage line: leaves 1, 3–21, 23 carried by a module, leaves
2 and 22 proved in the first layer, none unassigned).

| id | module | leaves | discharges | needs | status of my reading |
|---|---|---|---|---|---|
| — | **the first layer** (`Rigidity/Entropy`, `Solenoid`, `PositiveEntropy`, `ChainAtTA`) | 2, 22; the definitions of 13, 14; 16 declared | MR⁺ from PE-2 and EF_F⁺; the headline with closed hypotheses | — | typed, elaborated |
| C0 | the smaller set; Lemma F | 1 | `measurableSet_TA`, `rot_preimage_TA`, `exists_nonTorsion_unitVector` | — | typed; an implementer's job |
| M0 | the entropy base, **ported** from `[OAIMath2026]` family 015 | 13, 17 | — | Mathlib | surveyed (Stage 4); a port job with its own brief |
| M1 | entropy, ours | 13, 17 (T2, T3's consequence) | the three leaves of `Rigidity/Entropy`; the bridge; the two-shift at `log 2` | M0 | definitions typed |
| M2 | Herglotz–Bochner; Bochner for an induced topology | 3, 11 | `BochnerHerglotz`, `BochnerOn` | — | not read (ruling 4) |
| M3 | Markov–Kakutani | 4 | `InvariantMeasureOnClosed` | — | not read (ruling 4) |
| M4 | the dual as a compact group; Haar in two forms | 15 | — | `Solenoid` | not typed |
| M5 | Theorem 1.2 from Theorem 1.3 (FS105-DED) | 16 | `haar_or_zero_entropy` | M1 | statement typed |
| M6 | the pieces; PE-1′; Lemma W | 14, 19 | the axiom's non-degenerate model | M4, C0 | not read |
| M7 | PE-2: Lemma Γ; from `Γ` to `U` | 20, 17 (T1) | `entropySplit` | M0, M1, M4, M5, M6 | § 3.1 read |
| M8 | EF_F⁺ | 21, 18 | `zeroEntropyCarried` | M1, M9 | not read; its own planner |
| M9 | the ring and the scope — **with the two unnumbered results** | — | `noRamifiedStableDyadic_of_tca`; `R = O′`; the density of `R` | — | entries read |
| M10 | N1 (a) at `S = ∅`: the continuity group is `T + A` | 11 | N2 at `T + A` | C0 | not read |
| M11 | A⁺ at `S = ∅` | 12 | `(chainInterface F).APlusOfR88` | M10, M2 | not read |
| M12 | the count; `m₁(ℝ²) < 1/4` declared; `[S9]` | 7, 9, 10 | `(chainInterface F).Count` | M9 | not read; its own planner |
| M13 | CLS, with EN1-UQ4 at the dyadic targets | 8 | `5 ≤ localBound F → TCA F` | the `Arith/` floors | not read |
| M14 | row 99 at `L ≤ 4` (leaf 5 is branch `fs131-wnf`'s) | 5, 6 | `hRow99`; the upper half | — | not mine |
| M15 | the instances, `ℚ(√47)` first; the final statement | 23 | row 121's sentence | all | not read |

**The deriver's three questions, answered.** (1) The entropy split is restated beside `Interface.PE2`
(`EntropySplit`), not proved through it: § 1.3 item 2. (2) One definition of the smaller set, `Rigidity.TA`, in the
kernel's model of a character; the pigeonhole's reader gets its description as a theorem of M8 (the adelic model), the
spectral reader as a theorem of M10 (the continuity group). (3) The two unnumbered results are module M9, with the
scope lemma FS100-EXC, because the three are one piece of arithmetic about stable primes and three blocks read them
(M8's model, M12's extension step, the headline's `hScope`).

**What can be planned and built at the same time without sharing a file.** Each of these writes only new files, or one
proof in a file no other of them touches: **C0, M0, M2, M3, M4, M9, M13**, and M12's declaration of `m₁`, and M15's place
computations. Then, as their inputs land: M1 (after M0), M5 (after M1), M6 and M10 (after C0, M4), M8 (after M9; M1's
definitions are typed, so its planning can start now), M11 (after M10, M2), M12 (after M9), M7 last of the entropy side.
Two files are shared by design and are edited by one module each: `Rigidity/Entropy.lean` (M1 only),
`Rigidity/ChainAtTA.lean` (C0 only; M7, M8 and M9 prove their leaves in files of their own and the landing replaces the
`sorry`, or the three leaves move to a file downstream — the planner of each says which). Lemma F is stated once, in C0.

**Which I would start next, and why.**
1. **M0 with M1 — the entropy base.** The axiom's conclusion is a sentence about `ksEntropy`; until the definition is
   pinned to the textbook's number (the bridge to the release's `measureEntropy`, the two-shift at `log 2`) the axiom's
   read-back has a hole in it, and M5, M7 and M8 all read entropy. The port is the cheapest large step on the map: two of
   its files import nothing but Mathlib.
2. **M9 — the ring and the scope.** It holds the two results the leaf list missed; three blocks wait on it; it is
   arithmetic over Mathlib's number-field API with no entropy and no measure, so a planner can type it against the kernel
   today; and it settles early whether `IsRamified` (my definition by the action on the residue field) meets Mathlib's
   ramification index.
3. **C0 — an implementer, no planner.** Three leaves with their routes written; closing them takes `sorryAx` out of the
   three proved compositions, so that MR⁺ from PE-2 and EF_F⁺ and the headline with closed hypotheses are theorems of the
   library on the standard three axioms.
M2 and M3 are already ruled to be jobs of their own and conflict with nothing above.

**Before M7 and M8 are planned, two questions for the derive lane** (through the coordinator):
- *M8, Lemma 3.1′.* Can Steps 4–5 (X01D ll. 226–246) run on convergence in mean — `μ{I_n > εn} ≤ H_n/(εn)` by Markov's
  inequality on the information function, along a subsequence of scales chosen so that the bad sets are summable — with
  no almost-everywhere theorem? The deriver left this open (EN1 § 7.2); Shannon–McMillan–Breiman is in neither Mathlib
  nor the release, so the answer decides whether a classical theorem is formalized or dropped.
- *M7, § 3.2.* The ergodic decomposition's *uniqueness* is cited at X02D ll. 205, 209 and 225. The release proves
  existence in canonical form (the conditional measures on the invariant σ-algebra). Does § 3.2 go through on the canonical
  decomposition, where "`u` permutes the components" is a computation and no uniqueness theorem is read?

**Sizes.** Typed or read in full by me: the first layer (four files, about 560 lines with docstrings; ten `sorry`
leaves). Every other module: **unknown** — I typed none of them and read no proof under them in full. The survey's line
counts are `wc` on files I did not build.

### Drafts for files I do not write

- **`LEAN.md` § Searching — Lean**, a new line: "An `axiom` takes from a section `variable` line only the binders its
  statement mentions: an instance binder it does not name (`[BorelSpace X]`) is dropped in silence, where a `theorem` under
  the same line keeps it. Write every binder of an axiom in its own signature and read the stored type (`#check @name`)
  before the first commit (`Rigidity.positive_entropy_rigidity`; `tools/fs131_kn3_axiom_binders.py` with the print kept
  as its planted fault) (FS131-KN3)."
- **`BIBLIOGRAPHY.md`, `[EinsiedlerLindenstrauss2022]`, reading status**, to follow the present text: "pp. 1–4 of
  arXiv v1 re-read from the PDF's text layer by FS131-KN3 (2026-10-13) for the Lean statement of Thm 1.3; Thms 1.2, 1.3
  and the three definitions of p. 2 quoted in `Proofs/HadwigerNelson/Rigidity/`". **`[OAIMath2026]`**, family 015: "its
  entropy development surveyed by statement (FS131-KN3, `plans/FS131-KN3-chain-plan.md` § Stage 4): `PrimePackets/
  ShannonEntropy.lean` and `DukePrimeDegree/Entropy/MetricEntropy.lean` read in full; statement heads of about twenty
  files; no proof read, nothing built".
- **`scripts/Axioms.lean`, `scripts/Assumptions.lean`, `ARCHITECTURE.md` § Trust**: nothing now — the branch is a
  skeleton. At the landing of the first module that proves a record from the axiom: one `AxiomAudit.declareImport` line
  and the § Trust line drafted in § 5.3 item 4; and `Interface.PE2`, `Interface.RU`, `Interface.EFPlus` stop being taken
  by any closed statement on the path (their entries in `AssumptionAudit.declared` stay while rows 112, 116–118 take them).
