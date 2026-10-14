# Draft claim list M8-zero-entropy-carried — EF_F⁺: zero entropy is carried by `T + A` (the pigeonhole carried to the field); re-cut by FS131-KN6 from the deriver's answer (FS131-EN2)

*Drafted by FS131-KN3, rewritten by FS131-KN6 (2026-10-14) for Keryx to fix; a draft, not a fixed claim list. Written by `tools/fs131_kn6_recut.py` from `data/fs131/kn6/recut-M8.tmpl`: every quoted line is copied by script. The first draft is in git (`758af9d28`). Kind: two lanes — **M8a**, the names at entropy zero (an implementer, from the plan in `plans/FS131-KN6-chain-first-layer.md` § Stage 5); **M8b**, the model, the pigeonhole and the wandering step (its own planner).*

## The leaves it carries (quoted by script)

> NF2-LEAF-21: EF_F⁺ (D:162): the model of the dual as `𝔸_𝒮/D` (FS105:76, FS105-B-M1; X01D § 2.0, :113); Lemma PF, the product-formula gap (X01D:208; Mathlib has the product formula, `NumberField.prod_abs_eq_one`); an expanding place (X01D § 3.2, :214); Lemma 3.1′ (X01D:226); Lemma 3.2′ (a), the pigeonhole with the rational unit vectors as multipliers (X01D § 3.4, :246) over the height count (FS105:106, :110); two scales and one global point (X01D § 3.5–3.6); leaves (§ 3.7); wandering shells (§ 3.8, :301; FS105:86).
> — source: data/fs131/claims-NF2.md § The chain's leaves

> NF2-LEAF-18: Shannon–McMillan–Breiman, for EF_F⁺'s Lemma 3.1′ (X11K's node M2: "X-SMB"). Mathlib: none (searched "shannon", "mcmillan"). Whether Lemma 3.1′ needs the theorem or only the definition of entropy, I did not read.
> — source: data/fs131/claims-NF2.md § The chain's leaves

**NF2-LEAF-18 is answered** (FS131-EN2, inventory item 706): the lemma needs neither the theorem it names nor the scheme the first draft of this list asked about; it needs EN2-ZE below.

## Statements

1. `Rigidity.zeroEntropyCarried [NumberField F] (h : NoRamifiedStableDyadic F) : ZeroEntropyCarried F` — typed, `sorry` (unchanged).
2. to type (M8b) — the model of `Dual F` as `𝔸_𝒮/D` and, in it, `TA F` = the classes with a lift whose finite part is on the diagonal (FS105-B-M1; X01D § 2.0). Needs `R = O′` (M9).
3. **M8a, the count** — fresh, pure combinatorics, no measure:

> EN2-CNT: Let `𝒜` be a finite alphabet of `a ≥ 1` letters, `k ≥ 1`, `𝒢` a set of words of length `k` over `𝒜`, `g ≥ 2` a real number with `#𝒢 ≤ g`, `θ ≥ 0` and `n ≥ k`. The number of words `w` of length `n` over `𝒜` having at most `θn` positions `0 ≤ j ≤ n − k` with `w[j, j + k) ∉ 𝒢` is at most `(2a)^{θn + k}·g^{2n/k}`.
> — source: plans/FS131-EN2-derivation.md, the entry at l. 458

4. **M8a, the names at entropy zero** — fresh; in place of Shannon–McMillan–Breiman:

> EN2-ZE: Let `(X, μ)` be a probability space, `T : X → X` measurable with `T_*μ = μ`, and `P` a measurable map from `X` to a finite set; write `[x]_n` for the set of points `y` with `P(T^j y) = P(T^j x)` for `0 ≤ j < n`, and `H_n` for the Shannon entropy of the partition of `X` into these sets. If `inf_{n ≥ 1} H_n/n = 0`, then for every `β > 0` and `η > 0` there are `N₀` and a measurable `X′ ⊆ X` with `μ(X′) ≥ 1 − η` such that `μ([x]_n) ≥ e^{−βn}` for every `x ∈ X′` and every `n ≥ N₀`.
> — source: plans/FS131-EN2-derivation.md, the entry at l. 506

   In this library's words: for `[IsProbabilityMeasure μ]`, `MeasurePreserving T μ μ`, `Measurable P` and `partitionEntropy μ T P = 0` (the infimum form — the deriver's hypothesis word for word since FS131-KN6's change of that definition), for `β, η > 0` there are `N₀` and a measurable `X′` with `μ X′ ≥ 1 − η` and `exp (−β n) ≤ μ.real (nameCell T P n (fun j => P (T^[j] x)))` for `x ∈ X′`, `n ≥ N₀`.
5. to type (M8b) — Lemma 3.1′, its statement unchanged and the third part of its proof on statement 4:

> EN2-L31: Fix `ε > 0` with `∏_{v|∞}(2ε(1 + |u*|_v^{1/2}))² · ∏_{w split} max(1,|u*|_w) < 1/C_Λ` (ordinary moduli inside, normalised outside). For every `β > 0` and `η > 0` there are `δ₀ > 0` and a Borel `X′ ⊆ R̂` with `μ(X′) > μ(R̂) − η` such that `μ(π(x̃ + Q_{v*}(2ε, δ))) ≥ δ^β` for every `x ∈ X′`, every lift `x̃`, and every `0 < δ ≤ δ₀`.
> — source: plans/FS131-EN2-derivation.md, the entry at l. 542

## The classical statements this module now reads, and where each comes from

| statement | from | status |
|---|---|---|
| the rate of one partition is zero when the entropy is | the definition: `Rigidity.ksEntropy_eq_zero_iff` | **proved** (`Rigidity/Entropy`, FS131-KN6) |
| a long block with `H_k ≤ ε k` | `Rigidity.exists_blockEntropy_le_mul`, from the pinning theorem | typed, a leaf of M1 |
| Markov on the terms of one `H_k`: `γ k · μ(B) ≤ H_k` for `B` the union of the cells lighter than `e^{−γk}` | fresh, over `Real.negMulLog` | to type (M8a) |
| **the maximal ergodic inequality for the indicator of a set** | the release, `excessiveOccupation_measure_bound` over `finite_hopf_maximal` — **by port**: 243 lines (two files and three declarations) that elaborate at this pin after two renames (measured, FS131-KN6 § Stage 5) | module M0, lane M0-max |
| a geometric series; a countable union bound | Mathlib | — |

## What leaves the chain's list of classical inputs here

Shannon–McMillan–Breiman (in neither library); Egorov; Jacobs's formula and the ergodic decomposition for the single map `u*`; conditional information; the martingale theorem.

## Derivation addresses

`plans/FS131-EN2-derivation.md` § 3.5 (EN2-CNT, EN2-ZE), § 3.6 (EN2-L31), § 5.1 (what the module reads); EN1 § 8.1 row 12: FS100-EFP (`plans/FS100-derivation.md` l. 162); `plans/FS100-X01D-derivation.md` § 2.0 (l. 118), l. 208 (Lemma PF), §§ 3.2–3.8; `plans/FS100-X12B-derivation.md` §§ 2.1–2.2; `plans/FS105-derivation.md` ll. 76, 86, 106, 110; FS100-EFG (b) (`plans/FS100-derivation.md` l. 216)

## Imports

M8a: `Rigidity/Entropy` (M1), M0-max. M8b: M8a, M9, Mathlib's adeles and `NumberField.prod_abs_eq_one`

## Exports

`zeroEntropyCarried`

## Can run beside

M8a: one new file (`Rigidity/ZeroEntropyNames`), after M0-max and M1's `exists_blockEntropy_le_mul` are stated (they are); shares no file. M8b: new files; after M9

## Not claimed

Any size or price of M8b. That the statements marked "to type" elaborate as written. The deriver's entries are [hand], one mind; the kernel is their second check, and the deriver names where to attack first (EN2 § 3.7: step 4's "the block of `name_n(x)` at `j` is `name_k(T^j x)`", and step 3's use of the inequality for every `n`). What I read: EN2 §§ 3.0, 3.5–3.7, 5.1 in full; X01D not read by me.

## Since FS131-KN9 (2026-10-14; by hand — the text above is kept)

M8b's vocabulary decided, not typed (`plans/FS131-KN9-chain-zero-entropy.md` § Stage 4): the model built for `O′` and read for
`R` through `R ⊆ O′` and `c·O′ ⊆ R` (module M9) — **not `R = O′`** (the coordinator's ruling: plan on the weaker reading; the
scope binder of statement 1 stays until the proof shows it unread); a structure `TateModel F` over the concrete
`W = L_∞ × ∏′_{split} L_w` carrying the five facts M8b reads, built by **lane T** (Tate's duality in that form: a planner and
implementer job; strong approximation and Lusin–Souslin are not needed on its routes); M8b-2 (thin boxes, Lemma 3.1′ over
EN2-ZE), M8b-3 (the pigeonhole over `z = 1 + 2bi`), M8b-4 (leaves and shells) over `(D : TateModel F)`.
