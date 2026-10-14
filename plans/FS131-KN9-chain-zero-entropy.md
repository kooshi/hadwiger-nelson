# FS131-KN9 — the five-colour chain, next: M5 (Theorem 1.2 from Theorem 1.3), M9 (the ring and the scope), M8b (the zero-entropy side's second half)

*Job FS131-KN9, de Bruijn (the planner), Opus 5.5, 2026-10-14. Brief `data/fs131/briefs/FS131-KN9-chain-zero-entropy.md` (on `main`).
Branch `fs131-wk9`, cut from `3b531d1d2` (the join of `fs131-wl1` into `fs131-wpd`), in the worktree
`.claude/worktrees/fs131-wch`. Not pushed (the brief: the remote is unreachable). Working files under `data/fs131/kn9/`.*

## Theorems this phase proved

A planning job; every other statement typed here is a skeleton leaf (`sorry`) with its plan. Three short lemmas were proved
in passing (kernel-checked in a skeleton module; their axioms not audited, as no gate ran):

- `Rigidity.ZdAction.IsTotallyIrreducible.isIrreducible` — total irreducibility read at `Λ = ℤ^d` — `Rigidity/PositiveEntropy`.
- `Rigidity.mem_stableIntegers` — membership in `O′` is membership in every stable valuation subring — `Rigidity/RingScope`.
- `Rigidity.unitRing_le_stableIntegers` — `R ⊆ O′` over every real number field (FS91-J10-L1 (c)) — `Rigidity/RingScope`.

Also proved, as parts of definitions: the two laws of the model `Rigidity.ZdAction.mulTwoThree`.

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_kn9_quotes.py` parses every block quotation of the brief (a run of `> ` lines closed by `> — source: <path>`)
and requires its text, verbatim, in the source file on `main`. **8 quotations, 0 missing** (exit 0): W2
(`data/fs131/REQUEST-2026-10-13.md`), NF2-NC, NF2-LEAF-21, NF2-MRPLUS-SCOPE and the two dated lines of 2026-10-14
(`data/fs131/claims-NF2.md`), inventory items 761 and 775 (`plans/FS131-close-inventory.md`). **Control** (`--plant`, one
character of the first quotation changed): that one reported `MISS`, the others `OK`, exit 0 under the plant's rule — the
check can fail. The nested quotations inside items 761 and 775 are from hand-back messages, not on disk; item 775's ruling 3
already says so, and I did not re-check them.

### 1.2 The build of the branch

`./scripts/build.sh` under the slot (`--mem 10 --cpus 4`, `MEMMAX=10G`, `BATCH=8`): `==> build: OK — 249 of 249 batches,
10 module(s) rebuilt, 11 module(s) with warnings, 7m36s`, `exit=0` (`data/fs131/kn9/build1.log`). Rebuilt: the first
parent's modules (`Rigidity.PositiveEntropy`, `DualGroup`, `DualConnected`, `Annihilator`, `UnitCircle`, `SubgroupHaar`,
`Duality`, `Pieces`, `EntropySplitMax`) and `Proofs`, as the brief expected. 74 warnings, each ``declaration uses `sorry` ``;
no other warning.

### 1.3 The three modules' rows, restated

From the chain's architecture (`plans/FS131-KN3-chain-plan.md` § Stage 6, its table):

| id | module | leaves | discharges | needs | status (KN3) |
|---|---|---|---|---|---|
| M5 | Theorem 1.2 from Theorem 1.3 (FS105-DED) | 16 | `haar_or_zero_entropy` | M1 | statement typed |
| M8 | EF_F⁺ | 21, 18 | `zeroEntropyCarried` | M1, M9 | not read; its own planner |
| M9 | the ring and the scope — with the two unnumbered results | — | `noRamifiedStableDyadic_of_tca`; `R = O′`; the density of `R` | — | entries read |

From the split planner's lanes (`plans/FS131-KN8-chain-split.md` § 5.1): M5 writes `Rigidity/PositiveEntropy` (one proof) or a
new file, needs M1 and the finite-fibred step, "a planner first"; M8b writes new files, needs N (the names at entropy zero,
`Rigidity/ZeroEntropyNames`, landed in `fs131-wl1`), M9 and PD (Tate), "a planner, on § Stage 4's vocabulary". M8 was cut by
FS131-KN6 into M8a (the names, `Rigidity/ZeroEntropyNames`, proved by lane N) and M8b (the model, the pigeonhole, the
wandering step; `data/fs131/kn3/claims-M8-zero-entropy-carried.md`).

The split planner's § Stage 4, in its four parts (its words): **(1)** "The model of `R̂` — a theorem over one classical
input, not a definition of `Dual F`": `W := L_∞ × ∏′_{w split} L_w` (or `𝔸_L` with `Λ_𝔸 := L + ∏_{w stable} 𝔡_w^{-1}Ô_w`),
the standard character `ψ`, `π : W → Dual F`, `π a := (r ↦ ψ(a r))`, equivariant; the input Tate's self-duality ("`π` is
open and onto with kernel `Λ = R^∨ ⊂ L`, discrete and cocompact"); `TA F = π(L + L_∞)` a theorem. **(2)** M8b-2, thin boxes:
`Q(ε)`, `Q_{v*}(ε, δ)`, Lemma PF, the expanding place (Kronecker), local injectivity, Lemma 3.1′ over EN2-ZE with
`P := ξ`, `T := rot u*`. **(3)** M8b-3, the pigeonhole with `V_M ⊆ U_ℚ` and the shorter height input (`z = 1 + 2bi`,
`α′ = 1/(2[F:ℚ])`), the two scales, the global point, `μ(R̂ ∖ (T + K_{v*})) = 0`. **(4)** M8b-4, leaves (`φ_t` injective,
a Borel isomorphism by Lusin–Souslin; finite `U`-orbits on `L/Λ`, strong approximation or the torsion-group route) and
wandering shells (`g = γ/σ(γ)`, `(γ) = 𝔓_w^h`); exit `Rigidity.zeroEntropyCarried`.

The dated line of FS131-KPD1 the brief quotes adds to part (1): surjectivity of `π` from D2's case
(`Rigidity.eq_top_of_isClosed_of_dualCoannihilator_eq_bot`) once `W/Λ` is compact; "its kernel `Λ = R^∨` and the
cocompactness are the adelic part M8b must price".

## Stage 2 — SAVED: M5 typed and planned (Theorem 1.2 from Theorem 1.3)

Read for this stage: FS105-DED in full (`plans/FS105-D-deduction.md`, on `main`); `Rigidity/PositiveEntropy`, `Rigidity/Solenoid`,
`Rigidity/Entropy` and the port's `Outside/OAI015Shannon` (its theorem list and five statements) in this tree; M5's draft claim
list. Names checked at the pin: `data/fs131/kn9/logs/Names5.log`, `Names5b.log`, `Names5c.log` (the misses are listed in § 2.6
with the names that replace them).

### 2.1 The cut (mine to decide)

- **`Rigidity/EntropyFibres` (new; imports `Rigidity/Entropy`)** — the three entropy facts FS105-DED reads (its C4–C6), each
  in the direction it reads and each with an elementary route. They are facts about `ksEntropy`, not about solenoids, so they
  sit below `PositiveEntropy`, which now imports the module (and `Mathlib.MeasureTheory.Measure.Haar.Unique` for the proof).
- **Beside `haar_or_zero_entropy` in `Rigidity/PositiveEntropy`** (the brief's touches) — FS105-NVC (step 0), the Haar
  statements of Case A, and `ZdAction.coe_nsmul`; three models.
- **Draft statement 2's second half is not typed** ("for a totally irreducible one, so does every restriction to a
  finite-index subgroup"): the deduction applies the declared theorem to `α` itself and reads total irreducibility directly
  at step 1; the restriction clause is FS105-DED's S3′, which the Lean `NoVirtuallyCyclicFactors` (factors of `α` only) does
  not need. Typing it would need a `ZdAction d X` for a subgroup `Λ ≅ ℤ^d`, a basis choice no consumer reads.
- **Draft statement 3 (the finite-fibred step) is typed as the iff it names**, `ksEntropy_eq_zero_iff_of_finite`; only `⇒` is
  read, and `⇐` costs four lines.

### 2.2 A second route for C4, and the binder it removed (the coordinator's ruling)

FS105-DED step B1 proves the finite-fibred step by the Abramov–Rokhlin formula with conditional measures over a countably
generated σ-algebra (its C4). **The route the implementer builds is another, with no conditional measure** (mine, one mind):

1. *A section partition* (`exists_sectionPartition`): `V := (G ∖ {0})ᶜ` is open (T1, `G` finite), an open `U ∋ 0` with
   `U − U ⊆ V`, finitely many translates `x_i + U` cover `X` (compact), `Q x` := the first translate containing `x`. Each cell
   meets each coset at most once. On `x_i + U` the projection `mk : X → X ⧸ G` is injective, continuous and open, so an open
   embedding: **the image of a measurable subset of a cell is Borel in `X ⧸ G`.**
2. *The pattern* (`exists_pattern_names_le`): `R x` records, for each cell `i` of `Q`, whether `x + G` meets it and, if it
   does, `(P, Q ∘ T)` at the meeting point. Each cell of `R` is `mk⁻¹(mk(Q⁻¹{i} ∩ P⁻¹{c} ∩ T⁻¹Q⁻¹{i′}))` or a complement
   of one, so `R` is a partition of the factor for the Borel σ-algebra. At every `y`, `R y (Q y) = (P y, Q (T y))`, so the
   name of length `n` of `P` at `x` is decoded from `Q x` and the name of `R` at `x`: `H_n(P) ≤ H_n(R) + log |Q|`
   (coarsening `observationEntropy_comp_le`, the port's `observationEntropy_joint_le`, `finiteShannon_le_log_card`).
3. *The step* (`ksEntropy_eq_zero_iff_of_finite`): entropy zero on the factor makes `h(T, R) = 0` (`ksEntropy_map` at
   `borel (X ⧸ G)`); `exists_blockEntropy_le_mul` gives `n ≥ log|Q|/ε` with `H_n(R) ≤ εn`; so `h(T, P) ≤ 2ε`.

**What it changed.** FS131-KN8 § 2.6 added `[PolishSpace X]` because FS105-DED's step reads clause (4) over Mathlib's quotient
σ-algebra, equal to the Borel one only through Lusin–Souslin. Step 1 above gets the Borel images from the open embedding, so
the step holds over the declared clause (4) as stated, for every compact T1 group; Haar uniqueness at the pin
(`MeasureTheory.Measure.isAddHaarMeasure_eq_of_isProbabilityMeasure`) asks `LocallyCompactSpace` only. I sent it to the
coordinator as a generalization; **the ruling (2026-10-14): drop the binder, plan the proof through the axiom's own
clause (4), keep the quotient-σ-algebra form only if something reads it** — nothing does, so it is not stated. Restoring the
binder, should the open-embedding step fail in the kernel, is a statement change and goes to the coordinator. The kernel's
receipt is § 2.7.

### 2.3 The domain pass (`debruijn-domain-modeling`, a fresh invocation, scoped to M5's definitions and to the σ-algebra)

- **`blockLabel T P q`** is the release's `orbitName T P q` read as one letter (`finFunctionFinEquiv`), definitionally; the
  letter is forced by the library's vocabulary (`ksEntropy` is a supremum over label maps into some `Fin k`). The encoding
  order is incidental and the entropy cannot see it (`observationEntropy_equiv`). The unsampled member `q = 0` was checked by
  hand: `Fin (k⁰) = Fin 1`, and both sides of `blockEntropy_iterate` are `negMulLog (μ.real univ)`. Kept as defined; the plan
  routes its proof through `orbitName` and the port's `orbitName_add`. One `example` (`decide`) pins the encoding.
- **`ZdAction.mulTwoThree`** (the model of FS105-NVC): `n ↦ ×2^{n₀}3^{n₁}` as `AddMonoidHom.mulLeft`; its two laws close with
  `zpow_add₀` and `ring`, so the definition is proved, not left. An `example` pins `α^{(1,0)} 1 = 2`.
- **The σ-algebra on `X ⧸ G`** — the representation choice the pass was asked about: Mathlib's quotient instance (what the
  Polish form gives) or `borel` (what the page and the axiom say). The intrinsic object is the page's; the instance was
  incidental to FS105-DED's route. Choosing `borel` made the hypothesis the axiom's own clause, removed `PolishSpace`, and
  removed one statement (`measurable_comap_mk_of_invariant`, first typed for the instance, now absorbed into the pattern
  lemma's conclusion).

### 2.4 The obligation pass (`debruijn-obligation-modeling`, a fresh invocation, scoped to M5's statements)

Every statement true as typed; for each, the hypotheses its proof reads and its children.

| statement | true? | reads | children / measure |
|---|---|---|---|
| `measurable_blockLabel` | yes | `hT`, `hP` | `measurable_pi_lambda`, then `Measurable.of_discrete` on a finite type |
| `blockEntropy_iterate` | yes, every `q`, `n`, `μ` (`q = 0` by hand) | — | the name equation `orbitName (T^[q]) (blockLabel T P q) n x = e (orbitName T P (q*n) x)` for the word equivalence `e` (`finProdFinEquiv`, `Equiv.curry`, `finFunctionFinEquiv`, `Function.iterate_add_apply`, `Function.iterate_mul`); then `blockEntropy_eq_observationEntropy` and `observationEntropy_equiv` |
| `ksEntropy_eq_zero_of_iterate` | yes; **`hq` load-bearing** (at `q = 0`, `T^[0] = id` has entropy zero and the conclusion fails for a shift) | `hT`, `hq`, `h` | per `P`: `partitionEntropy μ T P ≤ partitionEntropy μ (T^[q]) (blockLabel T P q)`, index `q(n+1) − 1` in the infimum, `a/(qm) ≤ a/m` for `a ≥ 0` and both `ofReal` zero for `a < 0`; then `partitionEntropy_le_ksEntropy`, `ksEntropy_eq_zero_iff` |
| `ksEntropy_finite_mixture_eq_zero` | yes, at `J = 0` too (the measure is `0`), so no `0 < J` | all | `J = 0`: `ksEntropy_zero_measure`; `J > 0`: `τ := J⁻¹ • count` on `Fin J`, `κ := Kernel.ofFunOfCountable ν` (Markov by `hν`), `τ.bind κ = J⁻¹ • Σ ν j` (`Measure.ext`, `Measure.bind_apply`, `lintegral_count`), `ksEntropy_bind_eq_zero` |
| `observationEntropy_comp_le` | yes; finite measure only (additivity of `μ.real`); no `≤ 1` (`−x log x` is subadditive on `[0, ∞)`) | all | fibre masses add (`measureReal_biUnion_finset`-shape), the port's `negMulLog_sum_le`, `Finset.sum_fiberwise` |
| `exists_sectionPartition` | yes (T1 and compact suffice) | all | the open `U`; `compact_covered_by_add_left_translates`; `Q` by the first index (`Fin.find`-shape); the Borel images by `QuotientAddGroup.isOpenMap_coe`, `Topology.IsOpenEmbedding.of_continuous_injective_isOpenMap` on the subtype `x_i + U`, `Topology.IsOpenEmbedding.measurableEmbedding` with `@BorelSpace _ _ (borel _) ⟨rfl⟩`, `MeasurableEmbedding.measurableSet_image` |
| `exists_pattern_names_le` | yes; reads neither finiteness of `G`, nor invariance of `μ`, nor `T(G) ⊆ G` | `hQ`, `hsec`, `himg`, `hT`, `hP`, probability | the pattern `R` (classical choice of the meeting point; `Fintype.equivFin` to `Fin K`); its cells as preimages of images (`hsec` makes the meeting point unique); the key identity `R y (Q y) = (P y, Q (T y))`; the decoder by recursion on `j < n` (measure: `j`) |
| `ksEntropy_eq_zero_iff_of_finite` | yes; **`hG` load-bearing** (at `G = X` the factor is a point and the conclusion fails) | all | `⇒`: the two lemmas above, `ksEntropy_map` at `borel` (`continuous_quot_mk`, `Continuous.quotient_map'` for the measurability of `mk` and the induced map), `partitionEntropy_le_ksEntropyOn`, `exists_blockEntropy_le_mul` (reads `hμ`); `⇐`: `ksEntropy_map`, `ksEntropyOn_le_ksEntropy` with `Measurable.comap_le` |
| `ZdAction.two_le_of_not_isVirtuallyCyclic` | yes | `h` | `d = 0` (`n = 0`, `Subsingleton (Fin 0 → ℤ)`), `d = 1` (`n = 1`, `m = m 0 • 1`), `omega` |
| `ZdAction.noVirtuallyCyclicFactors_of_isIrreducible` | yes | all | a private child: a continuous `f : X →+ X` with values in a finite `Y` is `0` on a connected T1 group (`f⁻¹{0}` clopen: `Set.Finite.isClosed` twice, `IsClopen.eq_univ`); then `α m = α (k • n)` and `hvc` |
| `ZdAction.coe_nsmul` | yes | — | induction on `q` (`succ_nsmul`, `map_add'`, `Function.iterate_succ`) |
| `ZdAction.map_eq_of_isAddHaarMeasure` | yes | all | `IsAddLeftInvariant` of the image by `g + α n x = α n (α (−n) g + x)`; `isAddHaarMeasure_of_isCompact_nonempty_interior` at `univ`; the image is a probability; `isAddHaarMeasure_eq_of_isProbabilityMeasure` |
| `ZdAction.eq_of_isErgodicOn_of_invariant_component` | yes | all | `A := ⋂_{k ≠ j₀}` null sets of `hsing k j₀` (`MutuallySingular.measure_nullSet`, `measure_compl_nullSet`); `A′ := ⋂ n, (α n)⁻¹ A`, invariant by `map_add'`; `μ A′ = J⁻¹`, `μ A′ᶜ = J⁻¹(J − 1)`; ergodicity; `J = 1`; `Fin 1` |
| `isAddHaarMeasure_of_add_invariant` | yes (no T2 needed) | all | `IsAddLeftInvariant.mk` with `add_comm`; `isAddHaarMeasure_of_isCompact_nonempty_interior` at `univ` |

**`haar_or_zero_entropy`, decomposed** (every hypothesis read; no `PolishSpace`): `haveI` the four instances of `hX`;
`two_le_of_not_isVirtuallyCyclic hvc`; `noVirtuallyCyclicFactors_of_isIrreducible hirr.isIrreducible hvc`;
`positive_entropy_rigidity hX hd α hnvc μ hμ herg` (the axiom as declared). Step 1: `hirr Λ hΛ (G j) hcl hinv` gives each
`G j` finite or `⊤`. **Case A** (some `G j₀ = ⊤`): clause (2) at every `g` gives `isAddHaarMeasure_of_add_invariant`, then
`map_eq_of_isAddHaarMeasure` and `eq_of_isErgodicOn_of_invariant_component` give `μ = ν j₀`, Haar. **Case B**: for `n ∈ Λ`,
`h : G j ≤ (G j).comap (α n)` from `InvariantOn` (`AddSubgroup.map_le_iff_le_comap`), clause (4) and
`ksEntropy_eq_zero_iff_of_finite` give `ksEntropy (ν j) (α n) = 0`; `ksEntropy_finite_mixture_eq_zero` gives it for `μ`; for
any `n`, `q := Λ.index ≠ 0` (`AddSubgroup.FiniteIndex.index_ne_zero`), `q • n ∈ Λ` (`AddSubgroup.nsmul_index_mem`, normal in a
commutative group), `coe_nsmul` and `ksEntropy_eq_zero_of_iterate`.

### 2.5 Read aloud against the sources

| Lean | source | reading |
|---|---|---|
| `haar_or_zero_entropy` (unchanged but for the binder) | Thm 1.2, p. 2 (quoted in its docstring) | as KN3/KN7 read it; "`µ = m_X`" is `μ.IsAddHaarMeasure` for a probability `μ`, which is `m_X` by uniqueness |
| `two_le_of_not_isVirtuallyCyclic`, `noVirtuallyCyclicFactors_of_isIrreducible` | FS105-DED steps 0a, 0d; D-T1 | equal at `α` itself; the hypothesis of 0d is irreducibility (total irreducibility read at `Λ = ℤ^d`); S3′ (restrictions) not typed (§ 2.1) |
| `eq_of_isErgodicOn_of_invariant_component` | step 2, C3 | equal; reads no clause (3) and no ergodicity of the `ν j`, as the step says |
| `isAddHaarMeasure_of_add_invariant`, `map_eq_of_isAddHaarMeasure` | step 2, C1 | the two halves of C1 |
| `ksEntropy_eq_zero_iff_of_finite` | step 3 B1, C4, D-T3 | **wider**: for every compact T1 group, a finite subgroup and a continuous endomorphism mapping it into itself (B1: an automorphism of a solenoid), over the Borel σ-algebra; D-T3's equality of entropies is read as "zero iff zero", which is all B1 uses |
| `ksEntropy_finite_mixture_eq_zero` | B2, C5 ("only ≤ is needed") | the `≤` at zero, for the uniform weights the declared theorem gives |
| `ksEntropy_eq_zero_of_iterate` | B3, C6 | the direction read (`h(T^q) = 0 ⇒ h(T) = 0`); no invariance needed with the infimum form |

**Models** (each exercises every clause of the hypotheses it names): `finFour_fibre_model` — `ℤ/4`, `G = {0, 2}`, the identity,
the uniform probability (the finite-fibred step and both its lemmas); `ZdAction.mulTwoThree_model` — `×2, ×3` on `ℝ`, irreducible
and not virtually cyclic (FS105-NVC); `finTwo_haar_model` — the uniform probability on `ℤ/2`, translation-invariant (both Haar
statements); `ZdAction.invariantComponent_model` — `J = 1` on the one-point group (the statement's content is that `J ≥ 2`
has no model, which its docstring says). The power and the mixture: the point mass and the identity (a note in the module
docstring). `haar_or_zero_entropy` itself: PE-1′'s pieces, as its docstring has said since KN3. The four models are leaves
for the implementer (each a few lines; `mulTwoThree_model` about thirty, over `AddSubgroup.dense_or_cyclic` and unique
factorisation).

### 2.6 Names at the pin

Confirmed (`data/fs131/kn9/logs/Names5*.log`): `MeasureTheory.Measure.isAddHaarMeasure_eq_of_isProbabilityMeasure`
(`[LocallyCompactSpace G]`, no countability), `MeasureTheory.Measure.isAddHaarMeasure_of_isCompact_nonempty_interior`,
`MeasureTheory.Measure.IsAddLeftInvariant.mk` / `.map_add_left_eq_self`, `AddSubgroup.nsmul_index_mem` (`[H.Normal]`),
`AddSubgroup.FiniteIndex.index_ne_zero`, `AddSubgroup.map_le_iff_le_comap`, `IsClopen.eq_univ`, `Set.Finite.isClosed`
(`[T1Space]`), `finFunctionFinEquiv`, `finProdFinEquiv`, `Function.iterate_add_apply`, `Function.iterate_mul`,
`Function.iterate_succ`, `succ_nsmul`, `ProbabilityTheory.Kernel.ofFunOfCountable`, `MeasureTheory.Measure.dirac_bind`,
`MeasureTheory.Measure.bind_apply`, `MeasureTheory.Measure.bind_smul`, `MeasureTheory.lintegral_count`,
`MeasureTheory.Measure.count_univ`, `MeasureTheory.Measure.MutuallySingular.nullSet` / `.measure_nullSet` /
`.measure_compl_nullSet` / `.sum_left`, `measurable_quotient_mk''`, `measurable_from_quotient`,
`QuotientAddGroup.isOpenMap_coe`, `Topology.IsOpenEmbedding.of_continuous_injective_isOpenMap`,
`Topology.IsOpenEmbedding.measurableEmbedding`, `MeasurableEmbedding.measurableSet_image`, `compact_covered_by_add_left_translates`,
`exists_open_nhds_zero_half`, `Continuous.quotient_map'`, `AddSubgroup.dense_or_cyclic`, `Measurable.comap_le`,
`Measurable.of_discrete`, `Equiv.sum_comp`; the port's `negMulLog_sum_le`, `observationEntropy_joint_le`,
`finiteShannon_le_log_card`, `observationEntropy_equiv`, `orbitName`. **Not names at the pin** (and what replaces them):
`MeasureTheory.Measure.map_add_left_eq_self` (the field `IsAddLeftInvariant.map_add_left_eq_self`), `AddMonoidHom.iterate_map_nsmul`
(`ZdAction.coe_nsmul` is typed for it), `exists_open_nhds_zero_sub` (`exists_open_nhds_zero_half` on `U ∩ −U`),
`QuotientAddGroup.continuous_map` (`Continuous.quotient_map'`), `Real.subgroup_dense_or_cyclic` (`AddSubgroup.dense_or_cyclic`),
`ProbabilityTheory.Kernel.IsMarkovKernel` (`ProbabilityTheory.IsMarkovKernel`), bare `isProbabilityMeasure_map` (the
implementer finds the namespaced form; KN8's plan reads it too). `continuous_mul_left` is deprecated at the pin for
`continuous_const_mul` (build 2's one warning; fixed).

### 2.7 The kernel's receipt for the ruling, and the builds

- **Build 2** (M5 typed, the binder still there): `OK — 250 of 250 batches, 5 module(s) rebuilt, 6m30s`, `exit=0`; one
  warning besides `sorry` (the deprecation above). **Build 3** (the binder dropped, the Borel form):
  `OK — 250 of 250 batches, 5 module(s) rebuilt, 12 module(s) with warnings, 7m18s`, `exit=0`; 92 warnings, each
  ``declaration uses `sorry` `` (19 from this job's two files: 9 in `EntropyFibres`, 10 in `PositiveEntropy`); none other
  (`data/fs131/kn9/build2.log`, `build3.log`).
- **The dump** (`data/fs131/kn9/lean/ModuleDump.lean`, KN8's dumper; before from build 1's compiled module,
  `logs/dump-before.log`; after from build 3's, `logs/dump-after.log`; `tools/fs131_kn9_binder.py`,
  `logs/binder-check.out`): the axiom, its model and the Polish form `SAME`; `haar_or_zero_entropy`'s before text holds
  ` [@PolishSpace.{u_1} X inst_1]` exactly once and **the before text with it removed is the after text** (`PASS`); 17
  constants `ADDED` (this job's, and six generated `mulTwoThree._proof_n`), none removed. **Control** (`--plant`, one character
  of the binder kept): check 2 `FAIL`, the rest pass (`logs/binder-check-control.out`). **And** the after text equals
  FS131-KN8's print from before it added the binder (`data/fs131/kn8/logs/lean-dump-before.log`): the statement is again
  FS131-KN7's.

### 2.8 Lanes for M5 (they share no file)

| lane | writes | needs | size (my guess, not measured) |
|---|---|---|---|
| **M5-E** — `Rigidity/EntropyFibres`'s 9 leaves | that file | Mathlib; the port (`Outside/OAI015*`, landed); `Rigidity/Entropy`'s proved lemmas | the finite-fibred trio (section partition, pattern, step) is the bulk; the power and the mixture each a short page |
| **M5-P** — `Rigidity/PositiveEntropy`'s 10 leaves, `haar_or_zero_entropy` last | that file | M5-E's statements (typed; its proofs not needed to start) | `haar_or_zero_entropy` about forty lines over its children; `mulTwoThree_model` the longest model |

Two implementers can run them at once; one implementer takes M5-E first. `Rigidity/Pieces`' docstring sentence "with
`[PolishSpace (PieceDual M)]` from `Rigidity.polishSpace_dual`" is stale since the ruling (Lemma Γ no longer needs the instance
for this call); it is lane G's file — a docstring edit for lane G or the landing, drafted in § Drafts.

## Stage 3 — SAVED: M9 typed and planned (the ring and the scope)

Read for this stage: EN1 § 8.1–8.2 (`plans/FS131-EN1-derivation.md`), J45 N1 (`plans/FS84-SI-D-derivation.md` ll. 100–122), J28D C1
(`plans/FS86-R88-D-derivation.md` ll. 144–152), FS91-J07-3 and J07-4 (`plans/FS91-derivation.md` ll. 127–136), FS91-J10's lemmas L1–L7
(`plans/FS91-S1V-character.md` § 2.2, ll. 45–116), FS100-EXC (`plans/FS100-derivation.md` l. 297); in this tree `Rigidity/ChainAtTA`
(the scope's definitions), `UnitRing.lean`'s declarations, `Arith/UpperHalf` ll. 100–190 (the stable valuation subrings).

### 3.1 The cut, and what the coordinator's rulings of this job changed in it

**`Rigidity/RingScope` (new; imports `Rigidity/ChainAtTA`)**: `stableIntegers F` (`O′`), `R ⊆ O′` (proved), `c·O′ ⊆ R`, `R = O′`,
the density. `R` is read inside `L` as `UnitRing.unitRing (conjOn (fieldI_conj F))`; the plane's `unitRing F ⊆ ℂ` is the same
ring through `UnitRing.coe_mem_unitRingOver_iff`, already proved. **The scope lemma** `noRamifiedStableDyadic_of_tca` stays
where it is typed (`Rigidity/ChainAtTA`, off the headline's path); its plan is § 3.4, one proof in that file — the brief keeps
that file mine to read only, so the edit is the M9 implementer's (lane C, its only other writer, has landed) or moves
downstream unchanged at the landing; the coordinator's choice.

**The weaker reading of EF_F⁺** (sent mid-job; the coordinator's ruling of 2026-10-14: "plan M8b on it"): M8b's model needs
`R ⊆ O′` and `c·O′ ⊆ R` only, both over every real number field. So **`R = O′` (Lemma C′) is off M8b's path**, and by the
same ruling it is typed and planned in words only (§ 3.3). Whether anything else on the headline's path reads it: EN1 § 8.1
row 8 says T-C(A) at `S = ∅` "reads `R = O′` (Lemma C (d), Lemma C′)" — module M12's, not this job's; Lemma C (d)'s
inclusion `R ∩ ∏_{𝔓∣N} 𝔓^K ⊆ NR` follows from `c·O′ ⊆ R` alone (FS91-J10-L3's proof, read above), so whether M12 needs the
equality or only (d) is **M12's planner's question, named here**. Row 3's density, in the form typed here, does not read it.

**The readability lemma** of KN6's dated line ("`IsRamified P` is equivalent to ramification index 2 over `P ∩ 𝓞_F` in Mathlib's
sense") is **not typed by this job**: stating it needs an `Algebra F (fieldI F)` (and so `Algebra (𝓞 F) (𝓞 (fieldI F))`) that the
library does not declare — a structure no consumer reads — and the proof reads Mathlib's Galois inertia API at the pin
(`Ideal.card_inertia_eq_ramificationIdxIn`, `Ideal.Quotient.stabilizerHom_surjective`, both present;
`data/fs131/kn9/logs/Names9.log`). Its route in words: for a stable `P`, `g = 1`; `e·f = 2`; the decomposition group is
`Gal(L/F)` and surjects onto the residue automorphisms (`stabilizerHom_surjective`), so conjugation acts trivially on `𝓞 ⧸ P`
iff the residue extension is trivial iff `f = 1` iff `e = 2`. Off the path; a stub-sized job if wanted.

### 3.2 The passes (each a fresh invocation, scoped to M9)

**Domain** (`debruijn-domain-modeling`): `O′` as the infimum of the stable valuation subrings is the problem's own object (the
Dedekind overring that inverts the split primes), and it speaks the vocabulary the library already reasons in
(`UnitRing.unitRing_le_valuationSubring_iff`, `inv_mem_iff_forall_valuationSubring`, `UpperHalf.mem_localRing_of_mul_conj_eq_one`),
which is why `R ⊆ O′` closed in three lines. It needs `[NumberField F]` (the valuation subrings are built from `𝓞 (F(i))`), found
at the first elaboration (`logs/RingScope-1.log`). **The density** is typed as "`N·R` is dense in `L ⊗ ℝ` for every `N ≥ 1`",
which is J45 N1 (b) at `S = ∅` with the profinite factor read off (a basic open set of `R̂_prof × (L ⊗ ℝ)` is
`(r + N·R̂) × V`): the intrinsic content without a profinite completion the library lacks. `L ⊗ ℝ` is Mathlib's mixed space of
`L`, through `NumberField.mixedEmbedding`. Adversarial member: `R` discrete in `L ⊗ ℝ` (as `𝓞 L` is) would make the statement
false; `1/5 ∈ R` is what excludes it, and it is consistent with `R ⊆ O′` because no prime above 5 is stable (`(2 ± i)` are
swapped by conjugation).

**Obligation** (`debruijn-obligation-modeling`):

| statement | true? | reads | children |
|---|---|---|---|
| `mem_stableIntegers`, `unitRing_le_stableIntegers` | **proved** (`Subring.mem_iInf`; `unitRing_le_iff`, `mem_localRing_of_mul_conj_eq_one`) | — | — |
| `exists_mul_stableIntegers_le` | yes, every real number field (FS91-J10-L1 (e); [hand], J10, and J07's (C) route) | `[NumberField F]` | **(b)** `ℚ·R = L` ⇒ `∃ c₀ ≠ 0, c₀·𝓞 L ⊆ R`: `i ∈ R`; the `ℚ`-span of `R` is a finite-dimensional `ℚ`-subalgebra of `L`, a domain, hence a field (`Subalgebra.toIntermediateField`-shape over algebraicity); `u_a = (1 + ia)/(1 − ia) ∈ U` gives `ia`, then `a = −i·ia`; then an integral basis of `𝓞 L` with a common denominator. **(d)** `𝓞 L[U] = O′`: `⊆` from `R ⊆ O′` and `𝓞 L ⊆ O′`; `⊇` by the overring argument, at a non-stable `𝔔` an `a` with `v_𝔔(a) = −1`, `v_{c𝔔}(a) = 0` (approximation in a Dedekind domain), `u = a/ā` of norm one, then the ideal `J` and a maximal `𝔐 ⊇ J` (the hard child: a DVR has no proper overring but its fraction field — Mathlib's `ValuationSubring.eq_of_le_of_ne_top`, `LEAN.md` § Searching, FS131-KN2's line). **(e)** `O′ = Σ 𝓞 L·U`, so `c₀·O′ ⊆ R` |
| `unitRing_eq_stableIntegers` | yes in the scope ([hand], three derivations); **false without it** at `ℚ(√5)` and `ℚ(√17)` (J10-T6's exception data) | `h` | words only (§ 3.3) |
| `dense_mixedEmbedding_nsmul_unitRing` | yes; **`hN` load-bearing** (`0·R = {0}`) | `[NumberField F]`, `hN` | (i) `(3 + 4i)/5 ∈ U` (`3/5, 4/5 ∈ F`), `6/5 = u + ū ∈ R`, `1/5 ∈ R`; (ii) `c₀·𝓞 L ⊆ R` (step (b) above); (iii) the image of `𝓞 L` spans the mixed space (`NumberField.mixedEmbedding.latticeBasis`); (iv) the union over `k` of `N 5^{−k} c₀ ·` that lattice is dense (each coordinate approximated by `m/5^k`) |
| `noRamifiedStableDyadic_of_tca` (in `ChainAtTA`) | yes; reads `h` only (the dyadic clause of the scope is not read: a ramified stable prime is dyadic anyway) | `h` | § 3.4 |

### 3.3 `R = O′` (Lemma C′), in words only — off M8b's path

Statement as typed: for a real number field with `NoRamifiedStableDyadic F`, `UnitRing.unitRing (conjOn (fieldI_conj F)) =
stableIntegers F`. Route (FS91-J10's, the shortest of the three derivations): by `exists_mul_stableIntegers_le`, `R = O′` iff
`R + c·O′ = O′` iff `R → O′/cO′` is onto; `O′/cO′ ≅ ∏_{stable 𝔓 ∣ c} 𝓞_𝔓/𝔓^{m_𝔓}` (CRT in `O′`); the image of `U` there is the
product of the local norm-one images (weak approximation for the norm-one torus, FS91-J10-L2, by the stereographic
parametrisation and the approximation theorem for `F`); the subring of a finite product of local rings generated by a product
of subgroups containing `−1` is the product of the generated subrings (idempotents from the local rings' distinct maximal
ideals); and at each stable `𝔓` the norm-one image generates `𝓞_𝔓/𝔓^m` — at an inert `𝔓` from level one (`μ_{q+1}` generates
`𝔽_{q²}`) through the graded pieces `1 + π^{m−1}H` (J10-L6's computation), and it fails exactly at a ramified dyadic level one,
where the image is `{1}` (FS100-EXC). Not sized; not on the headline's path after § Stage 4's plan; a stub-sized job (Lemma C
and C′ in the kernel are FS-47's stub, inventory item 79 of FS-91).

### 3.4 `noRamifiedStableDyadic_of_tca`, the plan

`intro P _ hram`; `obtain ⟨c, hc, hbound⟩ := h P`; at `m = 1`, the two-colouring `C` of `colorable_two_levelTarget_one_of_isRamified
hram` (`Colorable.toColoring`-shape). If `𝓞 ⧸ P ^ 1` is infinite, `Nat.card = 0` and the singleton `{0}` is independent (a simple
graph has no loops): `1 ≤ c·0`, false. If finite, the two colour classes cover it, one holds at least half
(`Finset.exists_le_card_fiber_of_mul_le_card`-shape), it is independent (a colour class of a proper colouring), so
`N/2 ≤ c·N < N/4` with `N ≥ 1`, false. About twenty-five lines.

### 3.5 Lanes for M9

| lane | writes | needs | note |
|---|---|---|---|
| **M9-R** — `exists_mul_stableIntegers_le`, `dense_mixedEmbedding_nsmul_unitRing` | `Rigidity/RingScope` | Mathlib's Dedekind and mixed-embedding API | **on M8b's path** (the first) and M12's (the second); the overring child (d) is the hard one |
| **M9-S** — `noRamifiedStableDyadic_of_tca` | one proof in `Rigidity/ChainAtTA` | nothing new | off the path; any time |
| `unitRing_eq_stableIntegers` | — | — | off the path; not a lane until something reads it |

### 3.6 Build 4

`OK — 251 of 251 batches, 2 module(s) rebuilt, 13 module(s) with warnings, 6m43s`, `exit=0` (`data/fs131/kn9/build4.log`); 95
warnings, each ``declaration uses `sorry` `` (3 new, `Rigidity/RingScope`'s leaves); none other.

## Stage 4 — SAVED: M8b, its vocabulary decided and its classical inputs priced (not typed)

Read for this stage: X01D § 2.0 and §§ 3.1–3.8 (`plans/FS100-X01D-derivation.md` ll. 111–311, in full), the split planner's
§ Stage 4, M8's draft claim list; Mathlib's adele files at the pin (`Mathlib/NumberTheory/NumberField/AdeleRing.lean`, 74 lines;
`Mathlib/RingTheory/DedekindDomain/FiniteAdeleRing.lean`, 188; `Mathlib/NumberTheory/NumberField/InfiniteAdeleRing.lean`, 134; their
declarations listed) and `Mathlib/NumberTheory/Padics/AddChar.lean`'s header. **Not reached: typing.** What follows decides, for
M8b's planner, what the split planner's § Stage 4 left open, and changes it where the weaker reading (§ 3.1) makes it shorter.

### 4.1 The model, on the weaker reading: built for `O′`, read for `R`

`W := L_∞ × ∏′_{w split} L_w` (Mathlib's `NumberField.InfiniteAdeleRing L` times a `RestrictedProduct` over the split
`HeightOneSpectrum`s, w.r.t. `adicCompletionIntegers`), the standard character `ψ = ψ_∞ ∏ ψ_w`, and
`π : W → Dual F`, `π a := (r ↦ ψ(a r))` for `r ∈ R ⊆ O′ ⊆ L` (`unitRing_le_stableIntegers`). **What M8b reads of it, and from
where:**

| fact | where read | how obtained, on the weaker reading |
|---|---|---|
| `π` a continuous homomorphism, `π(u a) = rot u (π a)` | everywhere | definitional, from `ψ` |
| `π` onto | the lifts `x̃` (Lemma 3.1′, Steps 3–5) | FS131-KPD1's line: `π(W)` has zero annihilator in `R` (`ψ_∞` alone separates: `Tr(a r) ∈ ℤ` for all `a ∈ L_∞` forces `r = 0`) and is compact once `W = K + Λ′` with `K` compact and `Λ′ ⊆ ker π`; then `Rigidity.eq_top_of_isClosed_of_dualCoannihilator_eq_bot` (D2's case, lane PD) |
| `W = K + O′` (cocompactness) | surjectivity; Lemma 3.1′'s finite cover | `K := (a fundamental domain of `𝓞 L` in `L_∞`) × ∏_{split} O_w`: subtract `r ∈ O′` with prescribed principal parts at the finitely many split `w` where `a_w ∉ O_w` and integral elsewhere (approximation in a Dedekind domain, `IsDedekindDomain.exists_forall_sub_mem_ideal`-shape with a common denominator), then an element of `𝓞 L` (`ZSpan.fundamentalDomain` on `NumberField.mixedEmbedding.latticeBasis`, through Mathlib's equivalence of `InfiniteAdeleRing` with the mixed space) |
| `ker π = ι(Λ)`, `Λ ⊆ L`, `Λ` an `R`-module, `d·O′ ⊆ Λ ⊆ d⁻¹·O′` for some integer `d ≥ 1` | Lemma PF (`C_Λ < ∞`), Steps 3–5, Step 6 | `⊇`: the additive product formula `ψ(L) = 1` and `ψ_w(𝔡_w^{-1}O_w) = 1`. `⊆` (**the content of Tate's `L^⊥ = L` here**): for `a ∈ ker π`, subtract `r ∈ O′` as in the cocompactness step (`r ∈ ker π`), so `a − r ∈ L_∞ × ∏ O_w`; testing on `𝓞 L` puts its archimedean part `y` in the trace dual `(𝓞 L)^∨ ⊆ L` (`y ∈ ker π`); `c := a − r − y` has `c_∞ = 0` and, tested on elements of `O′` with one prescribed split pole and integral at the other split places (dense in `L_{w₀}`), `ψ_{w₀}(c_{w₀} L_{w₀}) = 1`, so `c_{w₀} = 0` (local non-degeneracy). **With `c·O′ ⊆ R`** (`exists_mul_stableIntegers_le`) the same computation runs for `R` with `c` in front: `ker π_R ⊆ c⁻¹ ker π_{O′}` |
| `T = π(L)`, `A = π(L_∞)` (so `TA F = π(L + L_∞)`) | the conclusion, Step 7 | `T`: a character of order `N` is `π(a)` with `Na ∈ Λ ⊆ L`; conversely `π(t)` for `t ∈ L` depends only on the stable components (product formula), where `t` has bounded denominators. `A`: an additive `ψ : R → ℝ` extends `ℚ`-linearly to `L` (`ℚR = L`, `exists_mul_stableIntegers_le`'s step (b); `CharacterColouring.exists_ratLinear_extension`), a trace form `Tr(a ·)` for `a ∈ L_∞` |
| finite `U`-orbits on `L/Λ` | Step 6 (ii) | **no strong approximation needed**: `t ∈ m⁻¹O′` for some integer `m`, `u t ∈ m⁻¹O′` for `u ∈ U ⊆ O′`, and `m⁻¹O′/Λ ⊆ m⁻¹O′/dO′`, finite (`O′/nO′` is a finite product of `𝓞/𝔓^k` over the stable `𝔓 ∣ n`) |
| `φ_t` a Borel isomorphism onto its image | Step 6 (i) | **no Lusin–Souslin and no `PolishSpace W` needed**: `W_{v*}` is σ-compact (closed in the σ-compact `W`), `φ_t` is injective and continuous, so a closed embedding on each compact piece (`Topology.IsClosedEmbedding.measurableEmbedding`), and Borel images on each piece add up |

**The interface (my recommendation for M8b's planner).** Package the five facts as a structure `TateModel F` over the concrete
`W` (fields: `π` with continuity and equivariance; surjectivity; `Λ` with `ker π = ι '' Λ`, `R`-stability and the two-sided
bound by `O′`; `W = K + ι(O′)` with `K` compact; `TA F = π '' (ι L + L_∞)`), so that M8b-2..4 are planned and proved over
`(D : TateModel F)` **at the same time as** its construction (lane T below), whose single exit is `Nonempty (TateModel F)`.
Then `zeroEntropyCarried`'s proof is `M8b-4's theorem` applied to lane T's model — and the scope hypothesis is read by neither
(the coordinator's ruling: dropped then, with a dump).

### 4.2 Parts 2–4, decided

- **M8b-2, thin boxes (Lemma 3.1′).** `Q(ε)`, `Q_{v*}(ε, δ)` as subsets of `W` (archimedean components in the ordinary modulus,
  split ones in `O_w`); **Lemma PF** for `y ∈ Λ ∖ 0` and for `y ∈ R ∖ 0` from Mathlib's `NumberField.prod_abs_eq_one` (present;
  `Names9.log`) and the bound `d⁻¹·O′` (so `C_Λ ≤ ∏_{stable 𝔓 ∣ d} N𝔓^{v_𝔓(d)}`); **the expanding place** by Kronecker —
  `NumberField.Embeddings.pow_eq_one_of_norm_eq_one` (present) after the product formula forces `|u*|_v = 1` everywhere and
  integrality at every finite place; **local injectivity** (part (ii)) by induction on `i < n − 1` with the measure `n − 1 − i`;
  **Lemma 3.1′** as EN2-L31 states it, part (iii) over `Rigidity.exists_forall_exp_le_measureReal_nameCell` (EN2-ZE, proved by
  lane N) with `P := ξ` the finite partition of part (i) and `T := rot u*` — the label map is `Dual F → Fin k`, as EN2-ZE takes it.
- **M8b-3, the pigeonhole and the global point (Lemma 3.2′(a), §§ 3.5–3.6).** Multipliers `V_M := {(1 + 2bi)/(1 − 2bi) : 1 ≤ b,
  1 + 4b² ≤ M^{1/n}}`, `n = [L : ℚ(i)] = [F : ℚ]` (KN8's shorter height input: `#V_M ≥ c·M^{α′}`, `α′ = 1/(2[F:ℚ])`, and the
  height of each is `(1 + 4b²)^n ≤ M`, read as `∏_w max(1, |v|_w) ≤ M`); they are archimedean isometries at every place of `L`
  (they lie in `ℚ(i)`); the pigeonhole is a finite-measure count (`μ(vB) = μ(B)` by `RotInv`, `Σ μ(vB) > μ(R̂)` forces an
  intersection); two scales `M`, `M²` give `z = ℓ₁e₂ − ℓ₂e₁ ∈ Λ` with every place bounded, so `z = 0` by Lemma PF; iterating
  the scales gives one `t ∈ L` and `(x̃ − t)_{v*} = 0`; so `μ(R̂ ∖ (T + K_{v*})) = 0`, `K_{v*} := π(W_{v*})`, Borel because
  σ-compact. The constants (`K = 16`, `β = α′/(2K)`, `δ(M) = M^{−K}`) as X01D fixes them, with `α′` for `α`.
- **M8b-4, leaves and wandering shells (§§ 3.7–3.8).** The leaves `φ_t(W_{v*})` pairwise disjoint (`W_{v*} ∩ L = 0`); finite
  orbits and the stabiliser of finite index (§ 4.1's route); `ν_t` invariant under `U_t`; at a split `w ≠ v*`,
  `g := γ/σ(γ)` with `(γ) = 𝔓_w^h` — Mathlib's class group is finite (`NumberField.classNumber`, present), so `𝔓_w^h` is
  principal — and `|g|_w ≠ 1`; the shells' measures are periodic in `j` and sum to a finite number, so all vanish; countably
  many split `w`; so `μ` is carried by `π(L + L_∞) = TA F`. Exit: `Rigidity.zeroEntropyCarried` (moved downstream of M8b at
  the landing with its statement unchanged, as ruling 5 of inventory item 761 moves `entropySplit`).

### 4.3 The classical inputs (brief item 5): named, searched at the pin, priced, formalize or declare

| input | at the pin (searched by name; `data/fs131/kn9/logs/Names9.log`, the file listings above) | price (from Mathlib's state, **not from an elaborated leaf**) | choice |
|---|---|---|---|
| **Tate's self-duality, in the form § 4.1 reads**: the standard character `ψ`; `ψ(L) = 1`; local non-degeneracy; `ker π ⊆ L`; cocompactness | **none**: the adele rings are types with their topology and ring structure only (no discreteness of `L`, no compact quotient, no characters, no local traces); `Mathlib/NumberTheory/Padics/AddChar.lean` describes the continuous characters of `ℤ_p` only | **the dominant cost of M8b.** The character `ψ_w` needs either the local trace `L_w → ℚ_p` (Mathlib does not present `adicCompletion` as a finite extension of `ℚ_p` with `Tr_{L/ℚ} = Σ_w Tr_{L_w/ℚ_p}`, as far as I found) or a global definition on `L` by approximation, extended to `L_w` by uniform continuity. Then the four facts by § 4.1's routes. My guess: **a planner-and-implementer job of several days**, two to four thousand lines; re-price from its first two leaves (`LEAN.md`) | **formalize** (W2), as **lane T**, a planner first; the declared form is no shortcut — `[Weil1967]` IV.2 / `[Tate1950]` § 4.1's statements need `ψ` built anyway, so a declared axiom would save only the four proofs. Neither source is held or read (prior-art debt; bibliography lines in § Drafts) |
| strong approximation | none by that name | **not needed** on § 4.1's routes: the finite orbits use `O′/nO′` finite; the absorption of stable components needs no approximation once the model is built for `O′` directly (stable places never enter `W`) | dropped from the inputs |
| approximation in a Dedekind domain (prescribed principal parts at finitely many primes, integral elsewhere) | `IsDedekindDomain.exists_forall_sub_mem_ideal` (CRT) is Mathlib's; the fractional form with poles is not, as far as I searched | a few hundred lines over CRT | formalize, inside lane T |
| Kronecker | `NumberField.Embeddings.pow_eq_one_of_norm_eq_one` (present) | the expanding place: about a hundred lines with the product formula and integrality from the finite places | Mathlib's |
| the product formula | `NumberField.prod_abs_eq_one` (present) | read directly | Mathlib's |
| Lusin–Souslin | `MeasurableSet.image_of_continuousOn_injOn` (Mathlib) — **not needed**: σ-compactness and closed embeddings on compact pieces suffice (§ 4.1) | — | dropped |
| finiteness of the class group | `NumberField.classNumber`, `ClassGroup.fintypeOfAdmissibleOfFinite` (present) | short | Mathlib's |
| the height count | — | replaced by KN8's family `z = 1 + 2bi` (elementary) | formalize in M8b-3 |
| Shannon–McMillan–Breiman | — | replaced by EN2-ZE (lane N, proved) | — |

No axiom is declared, and none is drafted: the one input with no route in Mathlib (Tate) is a formalization lane.

### 4.4 What M8b's planner inherits

Its vocabulary: § 4.1's `TateModel F` (to type first, over the concrete `W`), § 4.2's three modules over it. Its inputs typed
and landed or on the way: EN2-ZE and EN2-CNT (`Rigidity/ZeroEntropyNames`, proved), `R ⊆ O′` (proved here), `c·O′ ⊆ R` and the
density (M9-R), D2's case (lane PD). Its open questions: (i) the form of `ψ_w` (local trace or global definition) — lane T's
planner, by measuring both on the first two leaves; (ii) whether `zeroEntropyCarried`'s scope binder is read — the kernel
answers it (the coordinator's ruling).

## Stage 5 — SAVED: the lanes after this job, and the drafts

### 5.1 The lanes (none shares a file with another)

| lane | writes | needs | who |
|---|---|---|---|
| **M5-E** — `Rigidity/EntropyFibres`' 9 leaves | that file | Mathlib; the port; `Rigidity/Entropy` | an implementer; the finite-fibred trio is the bulk |
| **M5-P** — `Rigidity/PositiveEntropy`'s 10 leaves (`haar_or_zero_entropy` last) | that file | M5-E's statements | an implementer; may run beside M5-E |
| **M9-R** — `exists_mul_stableIntegers_le`, `dense_mixedEmbedding_nsmul_unitRing` | `Rigidity/RingScope` | Mathlib's Dedekind and mixed-embedding API | an implementer; on M8b's path (the first) |
| **M9-S** — `noRamifiedStableDyadic_of_tca` | one proof in `Rigidity/ChainAtTA` | nothing new | an implementer, any time (off the path) |
| **T** — `TateModel F` and its construction (`ψ`, the five facts of § 4.1) | new files | M9-R (`c·O′ ⊆ R`), PD (D2's case) | **a planner first**, who measures the two forms of `ψ_w` on the first two leaves |
| **M8b** — `TateModel F` typed, then M8b-2, -3, -4 over it | new files | N (landed), M9-R, PD; lane T's structure (its statement, not its proof) | **a planner**, on § 4's vocabulary |

The order on the chain's longest path: M9-R and the M8b planner can start now; lane T's planner beside them (it shares no
file); M5-E and M5-P are independent of all three.

### 5.2 Drafts for files I do not write

- **`data/fs131/claims-NF2.md` § Dated lines** (each follows the last line there):
  - "2026-10-14 — **The finite-fibred step reads the declared clause (4) as stated; `haar_or_zero_entropy` takes no
    `PolishSpace` (FS131-KN9, the coordinator's ruling).** Over the Borel σ-algebra of `X ⧸ G` for every compact T1 group: a
    finite partition whose cells lie in translates of an open `U` with `(U − U) ∩ G = {0}` — on which the projection is an open
    embedding, so images of Borel subsets of a cell are Borel — and the pattern of a partition `P` on the cosets give
    `H_n(P) ≤ H_n(pattern) + log |Q|` (`Rigidity.ksEntropy_eq_zero_iff_of_finite`, module `Rigidity/EntropyFibres`; a plan, not a
    proof). The binder `[PolishSpace X]` added by FS131-KN8 (inventory item 761) is gone: no Lusin–Souslin is read. The kernel's
    dump shows exactly that binder removed, and the statement is again FS131-KN7's."
  - "2026-10-14 — **EF_F⁺ on a weaker reading of the ring (FS131-KN9; a reading, one mind; the kernel is its test).** X01D's
    model, Lemma PF, the pigeonhole and Step 6's finite orbits read `R` only through `R ⊆ O′` (FS91-J10-L1 (c)) and `c·O′ ⊆ R`
    for an integer `c ≥ 1` (FS91-J10-L1 (e)), both over every real number field. If M8b's proof is written so (the coordinator's
    ruling: it is planned so), EF_F⁺ and MR⁺ hold over every real number field, NF2-MRPLUS-SCOPE (a)'s GAP at row 100's
    exception fields closes, and `R = O′` (Lemma C′) leaves the headline's path unless module M12 reads it; the class `L ≥ 5`
    is inside the scope either way."
  - "2026-10-14 — **M9's two unnumbered results are typed (FS131-KN9).** The density of the ring as
    `Rigidity.dense_mixedEmbedding_nsmul_unitRing` (`N·R` dense in `L ⊗ ℝ` for every `N ≥ 1`; EN1 § 8.2 route 4, reading no
    `R = O′`); `R = O′` as `Rigidity.unitRing_eq_stableIntegers`, off M8b's path, planned in words; `R ⊆ O′` proved
    (`Rigidity.unitRing_le_stableIntegers`)."
  - "2026-10-14 — **Strong approximation and Lusin–Souslin leave EF_F⁺'s inputs (FS131-KN9; a plan).** Step 6's finite
    `U`-orbits on `L/Λ` follow from `d·O′ ⊆ Λ ⊆ d⁻¹·O′` and the finiteness of `O′/nO′`; the leaves' Borel isomorphisms from
    σ-compactness (closed embeddings on compact pieces). Tate's duality in the form the model reads stays, as lane T."
- **`LEAN.md` § Searching — Lean**, new lines:
  - "A definition over the stable valuation subrings (`StablePrime.localRing`, `Arith/UpperHalf`) needs `[NumberField F]`;
    without it the elaborator reports `failed to synthesize NumberField ↥F` at the first use (FS131-KN9, `Rigidity.stableIntegers`)."
  - "At the pin `continuous_mul_left` is deprecated for `continuous_const_mul` (FS131-KN9)."
  - "Mathlib at the pin holds `NumberField.AdeleRing`, `IsDedekindDomain.FiniteAdeleRing` and `NumberField.InfiniteAdeleRing` as
    topological rings, `NumberField.prod_abs_eq_one`, `NumberField.Embeddings.pow_eq_one_of_norm_eq_one` (Kronecker),
    `NumberField.classNumber`, `Ideal.card_inertia_eq_ramificationIdxIn` and `Ideal.Quotient.stabilizerHom_surjective`; it holds
    nothing of the adeles' duality — no discreteness of `K`, no compact quotient, no additive characters (searched by name,
    FS131-KN9, `data/fs131/kn9/logs/Names9.log`; `Mathlib/NumberTheory/Padics/AddChar.lean` treats `ℤ_p` only)."
  - "A ruling that removes one binder of a statement is shown from the kernel's side by two dumps of the compiled module and
    `tools/fs131_kn9_binder.py`: the old print holds the binder's text once and, with it removed, is the new print; the other
    constants are unchanged; the control keeps one character of the binder and must fail (FS131-KN9)."
- **`Rigidity/Pieces`' module docstring** (lane G's file, or the landing): "at each piece, with `[PolishSpace (PieceDual M)]`
  from `Rigidity.polishSpace_dual`." becomes "at each piece (it takes no `PolishSpace` since FS131-KN9)."
- **`BIBLIOGRAPHY.md`**: a row **`[Tate1950]`** — J. Tate, *Fourier analysis in number fields and Hecke's zeta-functions*, thesis,
  Princeton (1950), in Cassels–Fröhlich (eds.), *Algebraic Number Theory* (1967) 305–347 — role: the source of the self-duality
  lane T formalizes (§ 4.1 there: the additive characters and `K^⊥ = K`); **not held, not read** (recalled). A row
  **`[Weil1967]`** — A. Weil, *Basic Number Theory*, Grundlehren 144, Springer (1967), Ch. IV — the same role; **not held, not
  read** (recalled). `[ChothiEverestWard1997]` (row at l. 95/764): cited again by X01D l. 118 for the `S`-integer duality;
  unread here. `[EinsiedlerLindenstrauss2022]`: nothing read by this job beyond Theorems 1.2–1.3 as quoted in
  `Rigidity/PositiveEntropy`'s docstring.
- **`ARCHITECTURE.md`**: written by this job (its rows for `Rigidity/EntropyFibres` and `Rigidity/RingScope`, and the
  `PositiveEntropy` row); § Trust: nothing new (no axiom added; the declared theorem untouched).

### 5.3 The checks at the hand-back

- **Lint** (`lake lint --no-build -- --no-build --trace` under the slot): `exit=0`, `-- Linting passed for Proofs.`, 14 linters
  `Passed` (`data/fs131/kn9/logs/lint.log`).
- **Architecture** (`tools/check_architecture.py`): module coverage `[1]` passes (364 rows, 364 modules, none missing or extra,
  the two new modules included); **one failure, not this job's**: `[2]` "imports of `Rigidity/ZeroEntropyNames`: stated-only [],
  real-only [`Outside/OAI015Maximal`]" — that module and its row are unchanged since the base `3b531d1d2` (`git diff` empty for
  both), so the mismatch came with the join of `fs131-wl1` (lane N's import of the port); the row's imports cell needs
  `Outside/OAI015Maximal` added (a one-cell fix for the landing or lane N's next job; I did not edit a row this job did not
  write). `data/fs131/kn9/logs/architecture.log`.
- **Builds**: 1–4 all `exit=0`; the last, build 4, 95 warnings, each a `sorry`.
