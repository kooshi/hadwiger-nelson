# Draft claim list M1-entropy — Kolmogorov–Sinai entropy: this library's definition pinned to the textbook's number

*Drafted by FS131-KN3 (the chain's planner) for Keryx to fix; a draft, not a fixed claim list. Kind: planner and implementer.*

## The leaves it carries (quoted by script)

> NF2-LEAF-13: **Kolmogorov–Sinai entropy** `h_μ(T)` of a measure-preserving map for an invariant probability measure, with the conditional form `h_ρ(γ | 𝒜)` on an invariant sub-σ-algebra. Mathlib at the pin has none (searched "kolmogorov.?sinai", "measure.theoretic entropy", "metric entropy"; found `Dynamics/TopologicalEntropy/`, `SpecialFunctions/BinaryEntropy`, `Log/NegMulLog`). Every printed input below is a sentence about it. `plans/STUB-mr-in-lean.md` notes that `[OAIMath2026]` family 015 has conditional entropy for countable partitions in Lean at another pin, headers only read: a port candidate, to be read before this is typed from scratch.
> — source: data/fs131/claims-NF2.md § The chain's leaves

> NF2-LEAF-17: T1, ergodic decomposition for a countable group acting on a compact metrizable space; T2, `h_ρ(γ) = lim_k h_ρ(γ | 𝒜_k)` along increasing invariant σ-algebras; T3, Jacobs's formula; T4, Fourier uniqueness (leaf 3). X02D § Stage 3: "T1–T4 textbook; exact theorem numbers not checked here" — **a prior-art debt: no page is cited for T1–T3**, so none can be read back yet. Mathlib: no ergodic decomposition (searched). My call: unknown until leaf 13 is typed; T2 and T3 are candidates to formalize, T1 to import.
> — source: data/fs131/claims-NF2.md § The chain's leaves

## Statements

1. `Rigidity.blockEntropy_one`, `Rigidity.ksEntropy_id`, `Rigidity.ksEntropy_map` — typed, `sorry`.
2. to type — the bridge: for `MeasurePreserving T μ μ` and a probability `μ`, `ksEntropy μ T =` the ported `measureEntropy μ T`.
3. to type — **T2** for `ksEntropyOn`: for increasing `T`-invariant sub-σ-algebras `𝒜_k` with `⨆ k, 𝒜_k = m`, each countably generated, `ksEntropy μ T = ⨆ k, ksEntropyOn (𝒜_k) μ T` (X02D l. 173; from `measureEntropy_eq_iSup_generating`).
4. to type — the consequence of **T3** the chain reads: a mixture over a Markov kernel of `T`-invariant probability measures with `ksEntropy = 0` has `ksEntropy = 0` (X02D ll. 207, 217; from `measureEntropy_kernel_zero`).
5. to type — `ksEntropy μ (T^[q]) = 0 ↔ ksEntropy μ T = 0` for `q ≥ 1`, and `ksEntropy μ T⁻¹ = ksEntropy μ T` (FS105-DED's inputs).
6. to type — **the model at positive entropy**: the shift on `ℕ → Bool` with the fair product measure has `ksEntropy = log 2`. The check that the definition under the axiom is not too small or too large.

## Derivation addresses

`plans/FS100-X02D-derivation.md` ll. 170–175 (T1–T4, "textbook; exact theorem numbers not checked here" — **the page for T2 is this module's planner's to name**); `plans/FS105-derivation.md` l. 24 (FS105-DED's classical inputs)

## Imports

`Rigidity/Entropy`, M0

## Exports

every entropy fact M5, M7 and M8 read

## Can run beside

edits `Rigidity/Entropy.lean`; no other module does

## Not claimed

Any size or price. That the statements marked "to type" elaborate as written. What I read: definitions typed and elaborated by me; no lemma proved beyond `ksEntropy_zero_measure`, `ksEntropyOn_mono`, `measurableSet_nameCell`.
