# FS131-KN9 — the five-colour chain, next: M5 (Theorem 1.2 from Theorem 1.3), M9 (the ring and the scope), M8b (the zero-entropy side's second half)

*Job FS131-KN9, de Bruijn (the planner), Opus 5.5, 2026-10-14. Brief `data/fs131/briefs/FS131-KN9-chain-zero-entropy.md` (on `main`).
Branch `fs131-wk9`, cut from `3b531d1d2` (the join of `fs131-wl1` into `fs131-wpd`), in the worktree
`.claude/worktrees/fs131-wch`. Not pushed (the brief: the remote is unreachable). Working files under `data/fs131/kn9/`.*

## Theorems this phase proved

None. A planning job: every statement typed here is a skeleton leaf (`sorry`), each with its plan; the few-line checks
that elaborate are definitions' examples, not theorems of the chain.

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
