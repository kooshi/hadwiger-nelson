# FS131-KN3 — the chain under "the plane over the field of √47 needs five colours": its hypotheses as closed statements about a field, its first layer typed, and the rest cut into modules

*de Bruijn, the planner. Brief: `data/fs131/briefs/FS131-KN3-chain-plan.md`. Branch `fs131-wch`, worktree
`.claude/worktrees/fs131-wch`. Claims: `data/fs131/claims-NF2.md`. Stands on `plans/FS131-KN1-number-field-kernel-map.md`
(the map) and `plans/FS131-EN1-derivation.md` (the deriver's reading, § 8.1 its table).*

## Theorems this phase proved

Filled at each stage; the last stage's list is the record.

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
