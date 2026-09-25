# FS-91 stage 0 — three colours over real number fields, a blind derivation (crunch job J09)

*De Bruijn (Opus 5.5), 2026-09-25, crunch job J09 (brief `data/crunch-2026-09-25/briefs/J09-three-colours-blind.md`, standing rules
`data/crunch-2026-09-25/briefs/STANDING-RULES.md`). Blind: until stage 3's verdicts are committed I have not opened the advisor's crunch
plan, J02's brief, J02's record or `data/fs91/j02/`, any commit naming J02, the FS-91 close inventory, M1's plan, or the crunch queue past
§1. Grades are `CLAUDE.md` § Notation's.*

## Stage 1 — SAVED

### 1.1 Quotations checked against their sources

| quotation in the brief | source I may open | result |
|---|---|---|
| the advisor's F1 sentence ("If this holds: χ(F²) ≤ 3 ⟺ L(F) ≤ 3 for every real number field, so the conjecture's L ≤ 4 clause holds everywhere.") and "First instance ℚ(α,√7): Θ₃ = ∅, so χ = 4." | `plans/POROS-2026-09-25-crunch-plan.md` §1.2 F1 — **fenced** | **not checkable by me**; taken as the brief's fixed statements S1–S3 |
| S3's field "`F = ℚ(α, √7)`, `α³ = α + 1`" and its prediction | `plans/STUB-three-colours-residue-degree-three.md`: "**First instance: `F = ℚ(α, √7)`, `α³ = α + 1`.**" and "`Θ₃(ℚ(α, √7)) = ∅`, so χ = 4 (the conjecture's prediction)" | matches |
| "`L(F)` and 'usable prime': `CLAUDE.md` § Notation" | § Notation, read from disk: "**Usable prime** of F: one whose residue field is 𝔽_q with q ≡ 3 (mod 4) — for q = p^f that is p ≡ 3 (mod 4) **and f odd**; then χ(F²) ≤ χ(Γ_q) (row 52). **L(F)**, F's *local bound*: the least chromatic number among the residue targets its conjugation-fixed primes supply." | matches |
| "`Θ₃(R) = {θ ∈ Hom(R, ℝ/ℤ) : θ(u) ∈ [1/3, 2/3] for every u ∈ U_F}`" | `LEDGER.md` row 82: "`Θ₃(F) = {θ ∈ Hom(ℤ[U_F], ℝ/ℤ) : θ(U_F) ⊆ [1/3, 2/3]}`" | matches (R = ℤ[U_F]) |
| "At three colours it is proved for real quadratic fields and for fields containing √3" | § Notation / Mission: "proved only for L ≤ 3 generally, L ≤ 4 given √3, and L ≤ 5 for multiquadratic F ⊇ K (G55); since FS-81 also L ≤ 4 for every real quadratic field (row 82)" | matches |
| the stub's arithmetic of ℚ(α,√7) | to be re-derived (stage 3), not trusted | — |

One wording note, not a divergence of truth: the stub says of ℚ(α,√7) "the dyadic targets have `χ ≥ 4`". Re-derived at stage 3: the one
dyadic prime of `F` **splits** in `F(i)` (`F_𝔭 ⊇ ℚ₂(√7) = ℚ₂(i)`), so it supplies no target at all; `L(F) = 4` comes from 7 alone.

### 1.2 C0 — priors, before any written derivation

Honesty note (as verifier G's at FS-89): written after reading the brief, the rules, the stub, `LEDGER.md` rows 52–60, 72–74, 79, 82–84,
95–97, `plans/FS81-derivation.md` §1–§2, `plans/FS89-derivation.md` §1–§2, `plans/FS89-S0A-gluing-verification.md` §C1 and FS86's Lemma R
entries. While reading I made a first mental pass at a route (below), so these are priors of that moment, not of a blank mind.

| statement | predicted verdict | probability |
|---|---|---|
| **S1** for every real **number** field | TRUE | 0.75 |
| S1 for every **algebraic** subfield of ℝ (L read through places) | TRUE, by König's lemma from the number-field case | 0.65 |
| S1 for every subfield of ℝ | GAP at the definition of `L(F)` for transcendental `F` (§ Notation defines it through primes) | 0.6 that the honest verdict is a named gap |
| **S2** | TRUE, as a corollary of S1, G55 and the residue upper bound | 0.75 |
| **S3** | TRUE (`Θ₃ = ∅`, `χ = 4`) | 0.8 |
| a point of `Θ₃(ℚ(α,√7))` exists (the falsifier) | — | 0.1 |

**The route I expect.** FS81-T4 already types every `ℤ[i][1/5]`-layer of a point `θ ∈ Θ₃(F)` as parity (`τ = 1/2`) or order 3 (`τ = ±1/3`);
its torsion part `τ` has an order-3 component `τ₃ = 4τ` that vanishes exactly on the parity-type unit vectors. Non-bipartite forces `τ₃ ≠ 0`.
The one piece of information FS-81 did not exploit: **the zero set of `τ₃` on `U_F` is invariant under multiplication by `i`** (a layer
contains `i` times each of its vectors). If `τ₃` is local at the stable primes above 3 and reads residues, weak approximation for the norm-one
torus turns that invariance into a statement about an `𝔽₃`-linear functional on `∏ 𝔽_{q_𝔓²}` restricted to `∏ μ_{q_𝔓+1}` — which should
fail when every `q_𝔓 ≥ 27` by a character-sum count, and hold at `q = 3` exactly by the four order-3 characters. The two risks: (a) that
`τ₃` is local (a Lemma R at 3 without FS86-B1-LR's Galois hypothesis), and (b) the count at `q = 27`, where Weil's bound may be too weak.

## Would-have-searched-here log

| # | the move I would have made by search | what I did instead |
|---|---|---|
| — | (stage 1: none) | — |

## Theorems this phase proved

*(filled per stage)*
