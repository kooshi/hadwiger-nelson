# FS-100 stage 4 — J51V, blind verification of the Kronecker-selection claims (KS-1 to KS-5, KS-C, K0)

*Verification record of crunch job **J51V** (Coxeter, Opus 5.5, 2026-09-25). Brief:
`data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md`, with `data/crunch-2026-09-25/briefs/STANDING-RULES.md` as part of it, and the
owner's launch notes (the fence does not cover J51V's own commits and report; commits are seen by subject only). No subagents; no finite-witness
search (ban to 2026-10-01); I touch only this file, `data/fs100/j51v/`, `tools/j51v_*` and my report. A derivation job (J51D) works the same
claims; I have not contacted it and have not opened its files.*

## Theorems this phase proved

*(filled at stage 3)*

## Stage 1 — SAVED (quotation check, fence log, C0)

### 1.1 Quotation check (standing rule 5)

| # | quoted in the brief | source | result |
|---|---|---|---|
| Q1 | the fixed claim list KS-1 … K0 ("verbatim; written before any claim was derived") | the FS-100 plan, which is **fenced** | **not checkable** blind; logged. KS-1 compared instead with the stub's open quotation of J37 §4.5 R2 (`plans/STUB-measure-rigidity-three-fields.md` §3, first block quote): KS-1 is a *formalization*, not a quotation — J37's `K′` is "a closed subgroup `K′ ⊆ Tⁿ`, the closure of the image of `Θ`'s `(T + A(R_F))`-part", KS-1's is the quotient `K/K₀` by the annihilator of the combinations `m` with `m·Θ ∈ T + A`; J37's `W` lives on `Tⁿ`, KS-1's on `K`; J37 says "Prove or refute", KS-1 asserts. KS-4 agrees in substance with J37's control ("over ℚ(√11) with `Θ = (θ_{C9}, θ₁)`, `θ₁ ∉ E`, W reading only the first coordinate must pass"). |
| Q2 | Notation: "`T` the torsion characters, `A(R_F)` the archimedean ones, `E = ⋃_S (T + A + Fin_S)` (`Fin_S`: continuous at the finite set `S` of split places) — `LEDGER.md` rows 98, 113" (not in quotation marks) | rows 98, 113 | agrees: row 98 "`A(R_F) = Hom_ℚ(F(i), ℝ) mod 1` the archimedean characters of every place of `F(i)`"; row 113 "`T + A + Fin_S` (`S` a finite set of split places, the dyadic one included)". `E = ⋃_S` is the stub's §2 notation, not the rows' |
| Q3 | "row 98 (band rigidity at every band, `Θ_k(R_F) ⊆ T + A`)" | row 98 | agrees; the row has the sharper `T_{N_k}(R_F) + A(R_F)`. Band: `Θ_k = {θ : θ(U) ⊆ B_{1/k}}`, `B_β = {z : ‖z‖ ≥ β}` (`plans/FS91-derivation.md` notation) |
| Q4 | "row 109 (M3-J21-MX, the mixing selection, `plans/M3-derivation.md`)" | row 109 | agrees |
| Q5 | "row 96 (`Θ₄(ℚ(√47)) = ∅`)" | row 96 | agrees ("ℚ(√47)'s plane has no character four-colouring (`Θ₄ = ∅`)") |
| Q6 | "row 94 (C9)" | row 94 | agrees |
| Q7 | "R88-TCA (T-C(A), `plans/R88-derivation.md`)" | `plans/R88-derivation.md` §2 | agrees; the statement: "over ℚ(√47), and (J28D) over every real field whose stable places all have all-levels ratio `< 1/4`, no translation-invariant Borel probability on `X₄(F)` has spectral measure carried by `T + A + Fin_S` for a finite set `S` of split places, dyadic ones included" — two derivations at ℚ(√47), **one mind (J28D) over the class** |
| Q8 | "row 105 and Lemmas C, C′ (`R = O′`)" | rows 105, 100 | **mild mismatch:** row 105 is prime inversion in valuation form and does not state `R = O′`; `R_F = O′` is Lemma C′ (row 100, FS91-J07-4). Harmless |
| Q9 | "J45's lemma statements (`plans/FS84-SI-D-derivation.md` §5.4: SI-1 to SI-5, RU, SP-oi, SP-if, A⁺, B⁺)" | J45 §5.4 | **mismatch:** §5.4 lists SI-1 … SI-5, R-U, SP-if, A⁺, B⁺ (and N1, N2, SI-J, G2-11, SI-C, SP-Cor) but **not SP-oi**; SP-oi is in J45's theorems table ("J45-SP-oi — SP's 'only if'") and §4.2 ("Lemma SP-only-if"). Harmless |
| Q10 | "Berend 1983/1984 and Furstenberg 1967 (held)" | `BIBLIOGRAPHY.md` | keys `[Berend1983]`, `[Berend1984]`, `[Berend1984min]`, `[Furstenberg1967]` resolve |

### 1.2 Fence log — one accidental breach, recorded

While looking for Lemma P I ran `grep -rn "Lemma P" plans/*.md`, which does not exclude fenced files. Its output printed **eight lines of the
fenced `plans/FS100-three-field-lemma.md`** (its lines 44, 52, 59, 60, 74, 82, 91, 172) and **one line of `plans/FS100-close-inventory.md`**
(row 1; that file is not on the fence list, but it carries J51's results, so I treat it as fenced in spirit). What I saw, in substance: a result
"J51-T1: real quadratic ℚ(√d) is in T-C(A)'s class ⟺ `d ≡ 47, 143, 167 (mod 168)` ⟺ `L ≥ 5`; ℚ(√143), ℚ(√311), ℚ(√335), ℚ(√167) in class",
a table row "ℚ(√143) … 11 ramified: FS-66 via Lemma P (ii); 31 split: Hoffman … yes", and pointers to `plans/FS86-B1-verification.md` Lemma P (ii).
**What it contaminates:** K0's parenthetical (class membership of the three fields) — my check of it is **not blind**. Nothing I saw bears on
KS-1 to KS-5 or KS-C. **Repair:** from here on every search excludes the fenced files by name. Opened on purpose, all open: rows 94–113;
`plans/FS84-SI-D-derivation.md`; `plans/R88-derivation.md`; `plans/FS84-S1-derivation.md` §1.3; `plans/FS86-B1-verification.md` (grep only);
the stub up to and including §3's first block quote.

### 1.3 C0 — probabilities per claim

*Honest timing note (G21).* The first column is my estimate on first reading the claim list. Before I wrote this table, while reading the inputs,
the split-place torus (`y ↦ (y, y⁻¹)` at a place split in `L/F`) came to mind as a way to make `cl Θ(U)` thin — so KS-3's and KS-1's
numbers at the time of writing are informed by a candidate counterexample not yet checked. Both columns are given; stage 2 scores the first.

| claim | first read: TRUE / FALSE / GAP | at writing: TRUE / FALSE / GAP | note |
|---|---|---|---|
| KS-1 | 0.55 / 0.20 / 0.25 | 0.15 / 0.75 / 0.10 | the selection must lose nothing when it drops the non-`(T + A)` combinations |
| KS-2 | 0.85 / 0.03 / 0.12 | 0.85 / 0.03 / 0.12 | Fubini over `K₀`-cosets; risk: measurability of the selection |
| KS-3 | 0.35 / 0.35 / 0.30 | 0.10 / 0.85 / 0.05 | a strong universal (every `F`, `n`, `Θ`) |
| KS-4 | 0.92 / 0.02 / 0.06 | 0.92 / 0.02 / 0.06 | `W` reads only the `(T + A)` coordinate |
| KS-5 | 0.88 / 0.04 / 0.08 | 0.85 / 0.05 / 0.10 | as KS-4 after a unimodular change of basis; wording of "the image" |
| KS-C | 0.75 / 0.05 / 0.20 | 0.70 / 0.05 / 0.25 | an implication; the pull-down's spectrum must land on `T + A` |
| K0 | 0.80 / 0.05 / 0.15 | 0.80 / 0.05 / 0.15 | "the same proofs": does anything in A⁺ / SP-Cor read ℚ(√47) itself? |

### 1.4 Would-have-searched-here log (running)

- (none yet)
