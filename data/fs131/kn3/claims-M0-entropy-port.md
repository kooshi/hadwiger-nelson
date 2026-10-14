# Draft claim list M0-entropy-port — the entropy base, ported from `[OAIMath2026]` family 015 (a port job with its own brief)

*Drafted by FS131-KN3 (the chain's planner) for Keryx to fix; a draft, not a fixed claim list. Kind: a port, by the method of `LEAN.md` § Assumptions ("An outside Lean proof may be ported"): cone from the source's compiled constants, a generator that refuses a patch to a statement, the licence beside the modules, a read-back across pins.*

## The leaves it carries (quoted by script)

> NF2-LEAF-13: **Kolmogorov–Sinai entropy** `h_μ(T)` of a measure-preserving map for an invariant probability measure, with the conditional form `h_ρ(γ | 𝒜)` on an invariant sub-σ-algebra. Mathlib at the pin has none (searched "kolmogorov.?sinai", "measure.theoretic entropy", "metric entropy"; found `Dynamics/TopologicalEntropy/`, `SpecialFunctions/BinaryEntropy`, `Log/NegMulLog`). Every printed input below is a sentence about it. `plans/STUB-mr-in-lean.md` notes that `[OAIMath2026]` family 015 has conditional entropy for countable partitions in Lean at another pin, headers only read: a port candidate, to be read before this is typed from scratch.
> — source: data/fs131/claims-NF2.md § The chain's leaves

> NF2-LEAF-17: T1, ergodic decomposition for a countable group acting on a compact metrizable space; T2, `h_ρ(γ) = lim_k h_ρ(γ | 𝒜_k)` along increasing invariant σ-algebras; T3, Jacobs's formula; T4, Fourier uniqueness (leaf 3). X02D § Stage 3: "T1–T4 textbook; exact theorem numbers not checked here" — **a prior-art debt: no page is cited for T1–T3**, so none can be read back yet. Mathlib: no ergodic decomposition (searched). My call: unknown until leaf 13 is typed; T2 and T3 are candidates to formalize, T1 to import.
> — source: data/fs131/claims-NF2.md § The chain's leaves

## Statements

1. `measureEntropy`, `observationEntropyRate`, `orbitEntropy_subadditive`, `tendsto_observationEntropyRate` — `PrimePackets/ShannonEntropy.lean` (453 lines, `import Mathlib` only).
2. `observationEntropyRate_finite_mixture`, `measureEntropy_kernel_zero` — `PrimePackets/EntropyMixtures.lean` (540 lines over the file above).
3. `measureEntropy_inverse` — `DukePrimeDegree/Entropy/EntropyInverse.lean` (92 lines over `ShannonEntropy`).
4. `measureEntropy_eq_iSup_generating` — `PrimePackets/EntropyGeneratingSupremum.lean` with `GeneratingObservationEntropy`, `ConditionalProbabilityExpectation`, `ObservationSigmaAlgebra`, `ObservationConditionalProbability`.
5. cone to compute before a call: `action_ergodic_decomposition` (`PrimePackets/ErgodicDecomposition.lean`, which imports `KernelEntropy` → `AtomMass`), `observationEntropyRate_blocks` (`DukePrimeDegree/Entropy/FiniteBlockEntropy.lean`, which imports `RootSubgroups`).

## Derivation addresses

`plans/FS131-KN3-chain-plan.md` § Stage 4 (the survey); nothing of ours is derived here

## Imports

Mathlib

## Exports

the release's entropy of a map and its theorems, kernel-checked at this pin, under `Outside.`

## Can run beside

new files under `Proofs/HadwigerNelson/Outside/` only; shares none

## Not claimed

Any size or price. That the statements marked "to type" elaborate as written. What I read: statement heads read; no proof read; nothing built. Size unknown; the release names its own friction (1,502 Mathlib commits between the pins).

## Dated lines

- 2026-10-14 (FS131-KN6) — **measured, and re-cut into lanes**: `plans/FS131-KN6-chain-first-layer.md` § Stage 5.1. `ShannonEntropy`, `EntropyMixtures`, and the maximal inequality (`HopfMaximal`, `MaximalOccupation`, three declarations of `InverseEntropy` — not in this list's first draft) elaborate at this pin after seven one-token renames. Statement 3 (`EntropyInverse`) and statement 5's `observationEntropyRate_blocks` are module M5's inputs and were not trialled; statement 4's eleven files and statement 5's `action_ergodic_decomposition` are module M7's and were not trialled.
