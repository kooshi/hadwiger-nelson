# Draft claim list M7-entropy-split — PE-2: Lemma Γ and the passage from `Γ` to `U`

*Drafted by FS131-KN3 (the chain's planner) for Keryx to fix; a draft, not a fixed claim list. Kind: planner and implementer.*

## The leaves it carries (quoted by script)

> NF2-LEAF-20: PE-2 (D:191): Lemma F (X02D:100); PE-1′, the pieces meet the printed hypotheses (X02D:146); Lemma W (X02D:156); Lemma Γ (X02D § 3.1, :181) over leaves 16, 17 (T2, T4); from `Γ` to `U` (X02D § 3.2, :196) over T1, T3.
> — source: data/fs131/claims-NF2.md § The chain's leaves

> NF2-LEAF-17: T1, ergodic decomposition for a countable group acting on a compact metrizable space; T2, `h_ρ(γ) = lim_k h_ρ(γ | 𝒜_k)` along increasing invariant σ-algebras; T3, Jacobs's formula; T4, Fourier uniqueness (leaf 3). X02D § Stage 3: "T1–T4 textbook; exact theorem numbers not checked here" — **a prior-art debt: no page is cited for T1–T3**, so none can be read back yet. Mathlib: no ergodic decomposition (searched). My call: unknown until leaf 13 is typed; T2 and T3 are candidates to formalize, T1 to import.
> — source: data/fs131/claims-NF2.md § The chain's leaves

## Statements

1. `Rigidity.entropySplit [NumberField F] : EntropySplit F` — typed, `sorry`.
2. to type — **Lemma Γ** (X02D § 3.1): for admissible `Γ` and a `Γ`-invariant, `Γ`-ergodic probability `ρ` on `Dual F`: `IsHaarFourier ρ`, or `ksEntropy ρ (rot γ) = 0` for every `γ ∈ Γ`.
3. to type — from `Γ` to `U` (X02D § 3.2), over the ergodic decomposition for the countable group `U_F` (T1; existence from M0's port; **uniqueness is cited at ll. 205, 209, 225 and is not in the release by name**).

## Derivation addresses

EN1 § 8.1 row 11: FS100-PE2 (`plans/FS100-derivation.md` l. 191); `plans/FS100-X02D-derivation.md` § 3.1 (l. 181), § 3.2 (l. 196)

## Imports

M1, M4, M5, M6, M0

## Exports

`entropySplit`

## Can run beside

edits `Rigidity/ChainAtTA.lean` at one proof, or lives in a new file that `ChainAtTA`'s successor imports; after M5 and M6

## Not claimed

Any size or price. That the statements marked "to type" elaborate as written. What I read: § 3.1 read in full by me; § 3.2 at its first lines; size unknown.
