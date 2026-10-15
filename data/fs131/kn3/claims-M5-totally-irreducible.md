# Draft claim list M5-totally-irreducible — Theorem 1.2 from Theorem 1.3 (FS105-DED)

*Drafted by FS131-KN3 (the chain's planner) for Keryx to fix; a draft, not a fixed claim list. Kind: planner and implementer.*

## The leaves it carries (quoted by script)

> NF2-LEAF-16: `[EinsiedlerLindenstrauss2022]` Thm 1.2 (p. 2) — the import the chain reads (X7).
> — source: data/fs131/claims-NF2.md § The chain's leaves

## Statements

1. `Rigidity.haar_or_zero_entropy` — typed, `sorry`: for a solenoid `X`, a totally irreducible, not virtually cyclic `ZdAction d X` and an invariant ergodic probability `μ`: `μ.IsAddHaarMeasure ∨ ∀ n, ksEntropy μ (α n) = 0`.
2. to type — FS105-NVC: an irreducible, not virtually cyclic action has `2 ≤ d` and `NoVirtuallyCyclicFactors`; for a totally irreducible one, so does every restriction to a finite-index subgroup.
3. to type — the finite-fibred step: for a finite `α_Λ`-invariant subgroup `G`, `ksEntropy` of `α n` on `X ⧸ G` for the image measure is `0` iff it is `0` on `X` (Abramov–Rokhlin over a finite-to-one factor).

## Derivation addresses

`plans/FS105-derivation.md` l. 24 (FS105-DED), l. 35 (FS105-VC), FS105-NVC; its classical inputs C1–C6 in D § 2.2 there

## Imports

`Rigidity/PositiveEntropy`, M1

## Exports

`haar_or_zero_entropy` on the axiom

## Can run beside

edits `Rigidity/PositiveEntropy.lean` (one proof) or proves it in a new file; shares none

## Not claimed

Any size or price. That the statements marked "to type" elaborate as written. What I read: statement typed by me; the deduction read only at its entry.

## Since FS131-KN8 (2026-10-14; by hand — the old text above is kept)

Statement 1 takes `[PolishSpace X]` (the coordinator's standing word, inventory item 750 ruling 2): the finite-fibred step
(statement 3) reads clause (4) over Mathlib's quotient σ-algebra, so the proof runs over
`positive_entropy_rigidity_of_polishSpace` (`plans/FS131-KN8-chain-split.md` § 2.6).

## Since FS131-KN9 (2026-10-14; by hand — the text above is kept)

**Typed** (`plans/FS131-KN9-chain-zero-entropy.md` § Stage 2): statement 2 as `ZdAction.two_le_of_not_isVirtuallyCyclic` and
`ZdAction.noVirtuallyCyclicFactors_of_isIrreducible` (its restriction clause not typed: off the path, the deduction applies the
declared theorem to `α` itself); statement 3 as `Rigidity.ksEntropy_eq_zero_iff_of_finite` (module `Rigidity/EntropyFibres`),
over the Borel σ-algebra of `X ⧸ G` as in the declared clause (4), for every compact T1 group, by a section partition and a
pattern partition (no Abramov–Rokhlin, no Lusin–Souslin). With it: the power (`ksEntropy_eq_zero_of_iterate`), the finite mixture
(`ksEntropy_finite_mixture_eq_zero`), the Haar steps of Case A. **Statement 1 no longer takes `[PolishSpace X]`** (the
coordinator's ruling of 2026-10-14; the kernel's dump shows exactly that binder removed). Lanes M5-E and M5-P (§ 2.8 there).
