# FS-100 stage 4 — Kronecker selection: the derivation (job J51D)

*Brief `data/crunch-2026-09-25/briefs/J51D-FS100-kronecker-derivation.md` with `STANDING-RULES.md`; the owner's launch notes override
both (modeling passes required at stage 1, committed before stage 2; no contact with J51V; working files `data/fs100/j51d/`). De Bruijn
(Opus 5.5), 2026-09-26. Claims fixed by the planner, `plans/FS100-three-field-lemma.md` §S (commit `845ed4e1`). Per claim: TRUE / FALSE
with a counterexample / GAP at a named step.*

## Theorems this phase proved

*(filled stage by stage; grade per `CLAUDE.md` § Notation; address in this file)*

## Stage 1 — quotation check, the claims verbatim, §M, C0

### 1.1 The claims, verbatim

Copied mechanically from `plans/FS100-three-field-lemma.md` lines 470–479 (commit `845ed4e1`) to `data/fs100/j51d/claims-verbatim.md`
(md5 `897f264ed7fc39e16d821f816b391d92`); every verdict below is against this copy.

| id | claim, verbatim | kind |
|---|---|---|
| KS-1 | "Let `F ⊆ ℝ` be a real number field, `R = ℤ[U_F]`, `n ≥ 1`, `Θ : R → Tⁿ` a homomorphism, `K = cl Θ(R)`, `K̂′ = {m ∈ ℤⁿ : m·Θ ∈ T + A(R_F)}`, `K₀ = ann_K(K̂′)`, `π : K → K′ = K/K₀`, and `W : K → {0,1,2,3}` measurable with `W(t) ≠ W(t + s)` for Haar-almost every `t ∈ K` and every `s ∈ cl Θ(U)`. Then there is a measurable `W′ : K′ → {0,1,2,3}` with `W′(t′) ≠ W′(t′ + s′)` for almost every `t′` and every `s′ ∈ cl π(Θ(U))`." (Kronecker selection, J37 §4.5 R2, in the reading above) | TRUE / FALSE / GAP |
| KS-2 | "If, for every `s ∈ cl Θ(U)`, `s + K₀ ⊆ cl Θ(U)` (KS-sat), then the conclusion of KS-1 holds, with `W′(π(t))` any measurable selection from the colours `W` takes on a positive-measure part of `t + K₀`." | TRUE / FALSE / GAP |
| KS-3 | "KS-sat holds for every real number field `F`, every `n` and every homomorphism `Θ : R → Tⁿ`." | TRUE / FALSE / GAP |
| KS-4 | "Over ℚ(√11), with `Θ = (θ_{C9}, θ₁)`, `θ_{C9}` row 94's character `(2x + 3y)/7` plus an archimedean term below `1/28`, `θ₁ ∉ E`, and `W` reading only the first coordinate as `⌊4·⌋`, KS-1's conclusion holds with `W′` the same window." (the stub's control) | TRUE / FALSE |
| KS-5 | "Over ℚ(√11), with `Θ = (θ_{C9}, θ_{C9} + θ₁)`, `θ₁ ∉ E`, and `W(t₁, t₂) = ⌊4t₁⌋`, KS-1's conclusion holds, and `K′` is the image of `θ_{C9}`." (a rank-two control of the shape T-J37-4 names) | TRUE / FALSE |
| KS-C | "Over ℚ(√47), KS-1 together with T-C(A) at `S = ∅` implies: no four-colouring of ℚ(√47)'s plane has the form `x ↦ W(Θ(x) + t)` with `Θ : R → Tⁿ` a homomorphism, `W` measurable and the colouring proper for almost every `t`." | TRUE / FALSE / GAP |
| K0 | "J45's A⁺ and SP-Cor hold, with the same proofs, over every real quadratic field in T-C(A)'s class (so over ℚ(√143), ℚ(√311), ℚ(√335)), given T-C(A) there at `S = ∅`." | TRUE / GAP at a named step |

### 1.2 Quotation check of the brief (standing rule 5)

| # | the brief's quotation or reference | source checked | verdict |
|---|---|---|---|
| B1 | the claim list "verbatim from `plans/FS100-three-field-lemma.md` §S" | §S table, lines 470–479 | copied mechanically (1.1) |
| B2 | "the factor reading of 'the (T + A)-part'" | plan §S "The precise reading of the statement" | exact; the reading is the planner's, flagged there as a pre-§M observation |
| B3 | "J51-T3's sketch of KS-2, which you must write out or refute, not trust" | plan §PA.3 ("KS-sat ⟹ Kronecker selection. [hand, one mind, sketch …]") | exact |
| B4 | stage 3's rank-one question, "for `θ ∉ T + A`, is `cl θ(U)` the circle" | plan §P, P-sat1: "KS-3 at `n = 1`: for `θ ∉ T + A`, `cl θ(U)` is the whole circle" | faithful |
| B5 | "a FALSE with its counterexample over ℚ(√11) is 'the first control the gap has ever had'" | stub line 350, quoting J37 §4.3 (d): "is **the first control the gap has ever had**" | exact; note the source's condition is a counterexample *over ℚ(√11)* **in the gap** (J37: "a two-character window colouring with no finite-place proper factor") — a FALSE elsewhere, or with a finite-place factor, is not that control (used in 4.x) |
| B6 | Lindenstrauss–Wang 2012 "zbMATH 1258.37031", Z. Wang 2012 "zbMATH 1278.37007" | plan §PA.2 table | exact |
| B7 | the reading list: rows 94–98, 102, 109, 113; FS91 row 98; M3-J21-MX; R88-TCA; J37 §3.3–§4.5; J45 §5.4 | the files | all resolve; read (1.3) |
| B8 | owner note 1, "invoke `debruijn-domain-modeling` and then `debruijn-obligation-modeling` freshly … applied to KS-1, and commit what each pass changed before stage 2 starts" | the owner's launch message | done: §M.1 and §M.2 below, one commit each |

No discrepancy. One flag (B5): the brief's shorthand "a FALSE … over ℚ(√11)" drops the source's qualifier that the counterexample must lie in
the gap; the verdicts below keep the qualifier.

### 1.3 Reading done (G50: status per item)

- `plans/FS100-three-field-lemma.md` in full; the stub §1–§4 in full, §5–§6 in part; J37 §3.3–§4.5 in full; `LEDGER.md` rows 94–98, 102,
  109, 113 in full; `plans/FS91-derivation.md` §1–§2 (row 98's chain, Lemma C/C′, weak approximation J10-L2, joint image J07-5);
  `plans/FS89-derivation.md` S0A-2, D1-L2/L3, VB1–VB4 entries; `plans/FS89-S1VB-verification.md` §B1.0–§B1.1 (Lemmas E, SW, JC, L; VB1–VB3
  with proofs); `plans/R88-derivation.md` R88-TC, R88-TCA; `plans/M3-derivation.md` M3-J21-MX (statement).
- **Not yet read:** EL2021 beyond the planner's §1; Lindenstrauss–Wang 2012, Z. Wang 2012 (not fetched yet — stage 3 decides whether KS-3
  needs them); J45 §5.4 (K0, stage 4).

### §M.1 — `debruijn-domain-modeling` on KS-1 (fresh invocation, 2026-09-26)

**Grok: what the statement is about, stripped of coordinates.** The `n` coordinates of `Θ` are incidental (a basis). The intrinsic object is
the finitely generated subgroup `Γ = {m·Θ : m ∈ ℤⁿ} ⊆ R̂`; then `K = Γ̂` (`K̂ ≅ Γ`), `Θ` is evaluation `ev : R → Γ̂`, `C := cl ev(U) ⊆ K`, and a
selection target is a subgroup `Γ_sel ⊆ Γ`, with `K′ = Γ̂_sel` and `π` restriction; `K₀ = ann(Γ_sel)`. The planner's factor reading is exactly
this with `Γ_sel = Γ ∩ (T + A)` — **confirmed as the right shape**: basis-free, and the literal "subgroup of `Tⁿ`" is basis-dependent
(the planner's `Θ = (θ_E, θ_E + ψ)`; KS-5 is that case).

**The object the hypothesis and conclusion talk about.** "`W(t) ≠ W(t+s)` for a.e. `t`" for all `s ∈ C` says `W` is a measurable proper
four-colouring of the Cayley graph `Cay(K, C)`; necessarily `0 ∉ C`. Reasoning surface (T-J37-1 step 1): with `A_j = W⁻¹(j)`,
`f_j(s) = |A_j ∩ (A_j + s)|` is continuous and properness is `f_j|_C = 0`; so "for all `s ∈ Θ(U)`" and "for all `s ∈ cl Θ(U)`" agree, and the
quantifier order is **∀ `s`, a.e. `t`** (the other order is the same for countable `Θ(U)` and is what the colouring needs). So KS-1 reads:
*measurable four-colourability of `Cay(Γ̂, C)` implies that of `Cay(Γ̂_sel, π(C))`* — colourability pulled **backwards** along the graph
homomorphism `π`.

**Bridging case (a neighbour we can model).** If `K = K′ × K₀` and `C = C′ × C₀`, then `Cay(K, C)` is the categorical product
`Cay(K′, C′) × Cay(K₀, C₀)`, and KS-1 there is a measurable Hedetniemi-type selection. It **fails whenever `Cay(K₀, C₀)` is itself
four-colourable** (colour by the `K₀` coordinate) and `Cay(K′, C′)` is not. So the one thing that can make KS-1 true is that the fibres of
`C` over `π(C)` are too big to colour — the extreme case being full fibres, which is KS-sat. This names the property the proof must supply,
and the shape of a counterexample: fibres that are **small but colourable**.

**The adversarial member (the unsampled one).** Take `Γ_sel = 0`: then `K′ = 0`, `π(C) = {0}`, and KS-1's conclusion "`W′(0) ≠ W′(0)`" is
impossible, so KS-1 at `Γ ∩ (T + A) = 0` asserts that **no proper `W` exists at all**. Is there a proper `W` with `Γ ∩ (T + A) = 0`? The
fibres must be colourable; the characters off `T + A` that are cheapest to control are the pure local ones at one split place `v = {w, w̄}`,
where every unit vector has `(u_w, u_w̄) = (x, x⁻¹)`, so a character reading `w` and one reading `w̄` are **never simultaneously
non-trivial** at a pole — an "OR" fibre. Over a field with a two-colouring (`ℚ`) that is enough for a proper `W` with `Γ ∩ (T + A) = 0`
(written out and checked in stage 2/4). So: **`T + A` is the wrong subgroup to select onto.** It is incidental — it is what rank one
produced (T-J37-1 via row 98) — while the consumer, T-C(A), kills `T + A + Fin_S` for every finite `S`. The intrinsic target is
`Γ_E := Γ ∩ E` (E = `⋃_S E_S`); for f.g. `Γ`, `Γ ∩ E ⊆ E_S` for one finite `S`.

**Rebuild (the statements this milestone should carry; proposed, the planner's claims are not edited).**
- **KS-1_E.** As KS-1 with `K̂′_E = {m : m·Θ ∈ E}` in place of `T + A(R_F)`.
- **KS-sat_E.** `s + ann(Γ ∩ E) ⊆ C` for every `s ∈ C`.
- **KS-2** is arithmetic-free: a statement about a compact abelian `K`, a closed `C`, a closed subgroup `K₀`; it should be stated and proved
  there, and then applies to both readings.
- **KS-C_E.** KS-1_E at ℚ(√47) with T-C(A) at every finite `S` (which R88-TCA gives) ⟹ no Kronecker four-colouring of ℚ(√47)'s plane.

**Seams.** An inhabitant of KS-1's hypotheses exists (KS-4's C9 window, over ℚ(√11)); the adversarial member above is the negative test;
the next-lemma test — does KS-C follow in two lines from the selection plus T-C(A)? — passes in both readings (random placement: 4.x).

**What the pass changed:** the target subgroup (`T + A` → `E`), flagged as the statement's main defect before any proof; KS-2 to be proved
arithmetic-free; a predicted FALSE for KS-1 and KS-3 as stated, to be written out and checked, not assumed.
