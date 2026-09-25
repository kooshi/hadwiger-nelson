# FS-91 stage 0, job J02 — three colours obey the local–global conjecture over every real number field (derivation record)

*Crunch job J02, 2026-09-25; de Bruijn (Opus 5.5), the derivation agent. Brief:
`data/crunch-2026-09-25/briefs/J02-three-colours-stage0.md` with `data/crunch-2026-09-25/briefs/STANDING-RULES.md`. The blind
derivation J09 (`plans/FS91-S0FV-three-colours-blind.md`) and `plans/FS91-close-inventory.md` are fenced: not read, not messaged.*

**Notation** is `CLAUDE.md` § Notation's and `plans/FS89-derivation.md`'s: `F ⊆ ℝ` a field, `L = F(i)`, `c` complex conjugation on `L`,
`U = U_F = {z ∈ L : z c(z) = 1}` (the unit vectors of `F²`, with `F² ≅ L` by `(x, y) ↦ x + iy`), `R = R_F = ℤ[U]` (the additive span
of `U`), `Θ₃(R) = {θ ∈ Hom(R, ℝ/ℤ) : θ(U) ⊆ [1/3, 2/3]}`. A **stable** prime is a prime `𝔓` of `L` with `c(𝔓) = 𝔓`.

## Stage 1 — SAVED

### 1.1 Quotation check (standing rule 5)

Each quotation in the brief against its source, read from disk this stage.

| # | the brief's quotation | source | verdict |
|---|---|---|---|
| Q1 | "The sum of several local parts is the one step to check; it is a sumset question, not a search." | `plans/POROS-2026-09-25-crunch-plan.md` §1.2, F1, fifth sub-bullet | **verbatim** |
| Q2 | the sketch block, "F1 sharpened after reading FS89-derivation CL2 and S0A-3 … Johnson papers, which are not held." | the advisor's second message ("Send 2"); committed only as a summary in `plans/POROS-2026-09-25-crunch-plan.md` §3, Send 2 | **matches the summary** in every checkable point (CL2 "for every `F ⊆ ℝ`"; S0A-3's `\|α\| ≤ 1/12`; Cayley parametrisation and weak approximation; the three named checks; 0.75). The verbatim text exists only in the brief, so the block is taken as the advisor's words on the planner's authority |
| Q3 | "CL2 is stated for every subfield F ⊆ ℝ: Θ₄(R_F) ⊆ T₁₆₈ + A." | `plans/FS89-derivation.md` FS89-CL2's title: "For every subfield `F ⊆ ℝ`: `Θ₄(R_F) ⊆ T₁₆₈ + A` and `Θ₅(R_F) ⊆ T + A`" | **correct** (the five-band half omitted, not needed) |
| Q4 | "(b) order 3 with \|α\| ≤ 1/12 (S0A-3 gives the same bound)" | S0A-3 (`plans/FS89-derivation.md`): "an order-3 part (with `\|α\| ≤ 1/12`)" — **at band `[1/4, 3/4]`** | **correct as a quotation of S0A-3; not C1(5)'s bound.** At band `[1/3, 2/3]`, C1(5) (`plans/FS81-derivation.md` T3) lists the order-3 type as the four characters `X₃` **with no archimedean part**: they take the values 1/3 and 2/3 exactly on `U₅`, so `α = 0`. The sketch's bound is true (weaker) and harmless |
| Q5 | "(a) parity plus an archimedean part of norm at most 1/6" | FS81-T3: "`{θ₂ + λ_e : \|e\| ≤ 1/6} ∪ X₃`" | **correct** |
| Q6 | "FS73-T22 gives θ ∈ Θ₃(R_F)" | FS73-T22 is stated for finitely generated `Λ` (`plans/FS73-derivation.md` T21–T22 setting); the passage to `R_F` is FS81-T2 (compactness, "with no finite generation of `ℤ[U_F]`") | **correct with FS81-T2 as the conduit** (the sketch names T22 only) |
| Q7 | row 95: "every four-colour band character of every real field's unit-vector ring is torsion plus archimedean" (the brief's paraphrase, "Why now") | `LEDGER.md` row 95: "by the gluing the same holds for every real field (`Θ₄(R_F) ⊆ T₁₆₈ + A`, `Θ₅(R_F) ⊆ T + A` for every `F ⊆ ℝ`)" | **faithful** |
| Q8 | "3 inert in the cubic and split in ℚ(√7); the prime above 7 of residue field `𝔽₇`, stable in `F(i)`" (S3) | FS-82 stub, "First instance" and "Why it is an exposed test" | **faithful**; re-derived in stage 3 |
| Q9 | S2's "the FS-45 stub's Theorem 2.1" for the two-colour case | the two-colour classification is GPT Astra's Theorem 2.1 (`reference/ChatGPT-local-global-tightness-conjecture/local-global-further-results.md` §2), carried in G55 and row 63; FS-45's stub is the chain theorem's kernel home | **address to check at stage 3**; the theorem itself is Astra's Thm 2.1 |

### 1.2 C0 — predictions

**Honesty note:** these were written after reading every source in the brief's list **and** after a route to S1 had formed in thought
(the finite ring `R/6R`, Astra's Teichmüller subring and Hilbert-90 lift, applied to the torsion character `τ` of FS81-T4). They are not
blind priors; they measure confidence in a route already seen, before any line of it was written down or checked.

| item | claim | P(true as the brief states it) | the reason |
|---|---|---|---|
| **S1** | every real number field: `χ(F²) ≤ 3 ⟹ L(F) ≤ 3` | **0.85** | a complete route is in view that needs neither row 95 nor Lemma R; the risk is a slip in the finite-ring step |
| **S2** | the conjecture's `L ≤ 4` clause for every real number field | **0.83** | S1 plus three known directions (row 52, Astra Thm 2.1) |
| **S3** | `Θ₃(ℤ[U_F]) = ∅`, `χ(F²) = 4` at `ℚ(α, √7)` | **0.83** | S1 plus arithmetic the stub already did; PARI to re-check |
| step 1 | T22 gives `θ ∈ Θ₃(R_F)` | 0.97 | FS81-T2 |
| step 2 | type (a) ⟹ bipartite | 0.9 for a point **all of whose** unit vectors are of type (a); **0.3** that the sketch covers a point with both types | type is per layer, not global; nothing in the sketch rules out a mixture |
| step 3 | type (b): `τ` factors through `R_F/3R_F` = "the product over the stable 𝔭 \| 3, collapsed to level one by the band" | **0.4** provable from held inputs in general | `R/3R ≅ ∏ O_𝔓/3O_𝔓` is Lemma R's consequence (b), whose scope is `L/ℚ` Galois (FS86-B1-LR) — **the first instance `L = ℚ(α, √7, i)` is not Galois over ℚ**; and at a ramified 3 `R/3R` has nilpotents the band must collapse |
| step 4 | Cayley + weak approximation: `U_F` jointly dense in the local circles and "the archimedean circle" | 0.95 for weak approximation; 0.9 that "the archimedean circle" (singular) is a wording slip | a field with complex places has non-compact archimedean factors `ℂ^×`; and density in local circles becomes surjectivity onto `R/NR` only through Lemma R |
| step 5 | the sumset step | 0.6 as stated | it assumes a global type (b) |
| step 6 | an additive 3-colouring of `Γ_{3^f}` forces `f = 1` | 0.95 | Weil (Hoffman) for `q ≥ 27`; exact at 27 by tool |

**Registered outcome:** S1 TRUE by a route that repairs steps 2–5 (0.85); GAP left open (0.12); FALSE (0.03).

### 1.3 Would-have-searched-here log

- (none yet)

### Theorems this phase proved

*(filled at stages 2–4)*
