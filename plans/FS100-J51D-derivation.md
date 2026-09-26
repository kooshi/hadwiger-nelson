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

### §M.2 — `debruijn-obligation-modeling` on KS-1 (fresh invocation, 2026-09-26)

**The space.** KS-1 quantifies over all real fields `F`, all f.g. `Γ ⊆ R̂` and all measurable `W`: no example verifies it. The **local
obligation** that discharges it is a per-point statement about the closed set `C = cl ev(U)` — fibre saturation, "`s + K₀ ⊆ C` for each
`s ∈ C`" (KS-sat) — and the bridge from it to the global selection is KS-2 (Fubini + Steinhaus, no induction). So the statement from which
the proof derives is a statement **about `C` alone**, with `W` gone; KS-1 = KS-2 ∘ KS-sat, and all the arithmetic sits in KS-sat.

**Derive the statement (strengthen / weaken).**
- *Weakest one-shot hypothesis.* KS-2's argument needs, for each `s′ ∈ π(C)`, that the fibre `C_{s′} ⊆ s + K₀` meets every non-empty open set
  of the coset (so that it meets the Steinhaus set `{ζ : |P ∩ (Q − ζ)| > 0}` of any two positive-measure colour sets); for closed `C` that is
  the full fibre. So KS-sat is not an over-strengthening — it is the exact hypothesis of a one-shot selection. **Recorded as the adversarial
  mutation:** weaken "full fibre" to "each fibre contains a translate of a proper subtorus in every direction" (directional saturation) and the
  selection breaks (the OR fibre of §M.1).
- *The general form that carries itself.* KS-2 should be stated arithmetic-free: **`K` compact abelian, `C ⊆ K` closed, `H ≤ K` closed with
  `C + H = C`; a measurable proper four-colouring of `Cay(K, C)` yields one of `Cay(K/H, C/H)`.** It iterates (a chain `H₁ ≤ H₂ …` of
  saturating subgroups), and it is what both readings (`T + A`, `E`) consume.
- *KS-3 splits along a filtration of `R̂`, not along coordinates.* `T + A ⊆ E ⊆ R̂`, both **pure** (if `mθ ∈ E_S` then `θ ∈ E_S`: `A` and
  `Fin_S` are divisible, and `m(θ − λ/m − φ/m) ∈ T` forces the rest torsion), so `Γ = Γ_{T+A} ⊕ Γ_{Fin} ⊕ Γ_∞` with `Γ_{T+A} = Γ ∩ (T+A)`,
  `Γ ∩ E = Γ_{T+A} ⊕ Γ_{Fin}`. The children, each with its own tool:
  1. **inside `E`, the `T + A` reading** — does `C` saturate over `Γ_{Fin}`? Tool: weak approximation (FS91-J10-L2), because a character of
     `E_S` reads only `∞`, finitely many stable places at finite level, and the places of `S` (no uncontrolled places). Predicted **FALSE** at
     a conjugate pair `{w, w̄}` (the valuation dichotomy `v_w(u) = −v_w̄(u)`); a finite exact identity, checkable in seconds.
  2. **rank one inside `E`** (`θ ∈ E ∖ (T + A)`): `cl θ(U) = T` by weak approximation — predicted TRUE.
  3. **rank one off `E`, `F = ℚ`**: through row 98's machinery on `R_S` (Lemma E, JC, PA-B2, VB1's mechanism) with the sweep SW-m run at an
     arc `J` instead of at 0 — predicted TRUE, a re-reading of held lemmas.
  4. **rank one off `E`, general `F`**: the same needs PA-B2 and JC over `R_{F,S}` (degree-2 local fields, several archimedean circles); row
     98's field clause went through a band-dependent gluing that does not transfer (a torsion-order bound is used). Predicted GAP.
  5. **rank `n` off `E` (KS-sat_E)**: joint density of the off-`E` values with the `E`-values pinned — the real obligation. It is a **set**
     statement, so Weyl's criterion does not apply character by character; it needs either an equidistribution (a measure whose Fourier
     coefficients vanish) or the orbit-closure theory of the diagonal `U`-action on `R̂ⁿ` (topological self-joinings). Predicted GAP, at the
     named step: *for `u` with prescribed components at `∞`, the stable places and `S`, the values of characters that read infinitely many split
     places cannot be steered without controlling `u` at every place, and `U_Σ` is discrete in `∏_Σ`* (no strong approximation for the
     anisotropic torus).
- *KS-C* is a two-line composition (random placement, then T-C(A)); its only obligation is that the placed colouring's spectrum lies in
  `Γ_sel ⊆ E_S` for one finite `S` — true for f.g. `Γ_sel` since `E` is an increasing union of subgroups.

**Validate adversarially (planned checks).** `tools/j51d_or_check.py`: exact arithmetic over rational unit vectors (a complete enumeration of
the finite set of Pythagorean triples up to a height fixed in advance), asserting that `(ψ_π(u), ψ_π̄(u))` never has both coordinates
non-zero, and that the four-colouring `W` of the adversarial member is proper on every enumerated edge; plant: `ψ_π̄` replaced by `ψ` at a
prime of 13 (both coordinates then non-zero together) — must fire. Mutation audit of KS-2: delete "`C + H = C`" and exhibit the OR fibre
as the failure.

**What the pass changed:** the decomposition of KS-3 into five children by the purity filtration `T + A ⊆ E`; KS-2 to be proved in the
arithmetic-free general form with iteration; the real obligation named (child 5) before any derivation; the exact check designed with its
plant.

### 1.4 C0 — my probabilities before any derivation (after §M; the planner's §P for comparison)

| claim | TRUE | FALSE | GAP | planner (§P) | why, one line |
|---|---|---|---|---|---|
| KS-1 | 0.10 | 0.80 | 0.10 | X-KS 0.50 / 0.15 / 0.35 | §M.1's adversarial member: a proper `W` with `Γ ∩ (T + A) = 0` over `ℚ` looks constructible |
| KS-2 | 0.95 | 0.02 | 0.03 | P-sat 0.85 | Fubini + Steinhaus |
| KS-3 | 0.05 | 0.90 | 0.05 | P-sat1 0.70 (rank one only) | the conjugate-pair OR fibre |
| KS-3, rank one | 0.55 | 0.05 | 0.40 | P-sat1 0.70 | TRUE inside `E` and at `ℚ`; general `F` off `E` likely GAP |
| KS-4 | 0.97 | 0.03 | — | — | `W` reads only the `T + A` coordinate; cannot fail (an uninformative control) |
| KS-5 | 0.95 | 0.05 | — | — | as KS-4 |
| KS-C | 0.85 (as an implication) | 0.05 | 0.10 | — | two-line composition |
| KS-1_E (proposed) | 0.35 | 0.10 | 0.55 | — | child 5 is the equidistribution J37 named |
| K0 | 0.70 | 0.05 | 0.25 | P-K0 0.75 | not read yet |

### 1.5 Would have searched here (stage 1)

- None. (A search would have been "sample characters of ℚ(√11) and plot `cl Θ(U)`"; the valuation dichotomy was derived instead, and its
  check in stage 2 is an exact identity over a fixed finite set.)

## Stage 1 — SAVED

*Fence received from the owner mid-stage 2 (J51V's files, the close inventory, the session handoff, `git show` of J51V commits): honoured;
none was opened before or after.*

## Stage 2 — KS-2, the controls KS-4 and KS-5, and the adversarial member (KS-1, KS-3 refuted)

*Notation.* `L = F(i)`; `R = ℤ[U] = O′` (row 105, Lemma C′); `R̂ = (L_∞ × 𝔸′_split)/R*` (FS89-S1VB §B1.0 conventions, every split place);
`T`, `A = Hom_ℚ(L, ℝ) mod 1`, `Fin_S`, `E_S = T + A + Fin_S`, `E = ⋃_S E_S` as in the stub §2. For a split place `v` of `F` with `v = w w̄`
in `L`, identify `L_w ≅ F_v ≅ L_w̄`; `ψ_v` the standard character of `F_v` (trivial on `O_v`); `ψ_w(r) := ψ_v(ι_w(r))`, a character of `R`.

### 2.1 KS-2 — TRUE, in an arithmetic-free form (J51D-T1)

**J51D-T1.** *Let `K` be a compact metrizable abelian group, `C ⊆ K` closed, `H ≤ K` a closed subgroup with `C + H = C`, `q : K → K/H`. If
`W : K → {0,1,2,3}` is measurable and, for every `s ∈ C`, `W(t) ≠ W(t + s)` for Haar-a.e. `t`, then `S(t) := {j : m_H{h : W(t + h) = j} > 0}`
depends only on `q(t)`, is non-empty, and for every `s ∈ C`, `S(t) ∩ S(t + s) = ∅` for a.e. `t`; so any measurable `W′` with
`W′(q(t)) ∈ S(t)` satisfies `W′(y) ≠ W′(y + s′)` for a.e. `y ∈ K/H` and every `s′ ∈ q(C)`.*

*Proof.* `S` is constant on `H`-cosets (invariance of `m_H`), non-empty (the four sets cover `H`), and measurable in `t` (Fubini on
`(t, h) ↦ W(t + h)`). Fix `s ∈ C`. For each `h ∈ H`, `s + h ∈ C`, so `{t : W(t) = W(t + s + h)}` is null; by Fubini the set
`N = {(t, h) : W(t) = W(t + s + h)}` is `m_K × m_H`-null. The map `(t, h₁, h₂) ↦ (t + h₁, h₂ − h₁)` preserves `m_K × m_H × m_H`, so
`{(t, h₁, h₂) : W(t + h₁) = W(t + s + h₂)}` is null; hence for a.e. `t`, `W(t + h₁) ≠ W(t + s + h₂)` for a.e. `(h₁, h₂)`. A colour in
`S(t) ∩ S(t + s)` would give a positive-measure product set of pairs with equal colours; so `S(t) ∩ S(t + s) = ∅` a.e. Then
`W′(q(t)) ∈ S(t)`, `W′(q(t) + q(s)) = W′(q(t + s)) ∈ S(t + s)`, and the push-forward of `m_K` is `m_{K/H}`. ∎

KS-2 is the instance `K = cl Θ(R)`, `H = K₀`, `C = cl Θ(U)` (and `cl π(Θ(U)) ⊆ π(C)`, compact). **Verdict: TRUE** [hand, one mind]. J51-T3's
sketch is confirmed; the step it left unwritten is the change of variables that turns "null for each `h`" into "the two colour sets on the
fibres are disjoint". Nothing of `F`, `R`, `T + A` is used; the selection iterates along a chain of saturating subgroups. **Mutation:**
drop `C + H = C` and the conclusion fails (2.4's `C`, with `H = K`).

### 2.2 The conjugate-pair dichotomy (J51D-T2)

**J51D-T2.** *For every real number field `F` and every split place `v = w w̄`: (a) for every `u ∈ U`, `ψ_w(u) = 0` or `ψ_w̄(u) = 0`;
(b) no non-zero `m₁ψ_w + m₂ψ_w̄` lies in `T + A`; in particular `ψ_w, ψ_w̄` are independent.*

*Proof.* (a) `u ū = 1` and conjugation exchanges `w` and `w̄`, so `ι_w̄(u) = ι_w(u)⁻¹`; if `ι_w(u) ∈ O_v` then `ψ_w(u) = 0`, otherwise
`ι_w̄(u) ∈ 𝔭_v` and `ψ_w̄(u) = 0`. (b) Suppose `m₁ψ_w + m₂ψ_w̄ = σ + λ`, `σ` of order `N`, `λ ∈ A`, `m₁ ≠ 0`. Choose a second split place
`w₀ ∉ {w, w̄}` (infinitely many exist). By strong approximation for `L` with `w₀` omitted there is `y ∈ L`, integral at every finite place
but `w₀, w, w̄` (so `y ∈ R`), with `ι_w̄(y)` deep in `𝔭_v`, `y_∞` as small as wished, and `ι_w(y)` in a prescribed class with
`ψ_v(N m₁ ι_w(y))` at distance `≥ 1/3` from 0. Then `(σ + λ)(Ny) = Nλ(y)` is small while `(m₁ψ_w + m₂ψ_w̄)(Ny)` is not. Symmetric for `m₂`. ∎
[hand, one mind; (a) checked exactly at `F = ℚ`, `v = (2+i)(2−i)`, on all 25,492 rational unit vectors of height `≤ 20,000`
(`tools/j51d_or_check.py`, D1; 4,256 of them non-zero in each coordinate, none in both; plant P1, the place above 13 in place of `w̄`, fires
with 48 joint non-zeros).]

### 2.3 KS-3 — FALSE

**Counterexample (any real field, any split place).** `Θ = (ψ_w, ψ_w̄)`: by J51D-T2 (b) `Γ ≅ ℤ²`, `Γ ∩ (T + A) = 0`, so `K = T²` and
`K₀ = K`; by (a), `C = cl Θ(U) ⊆ (T × {0}) ∪ ({0} × T)`, and `0 ∈ C` (`u = 1`), so `0 + K₀ = T² ⊄ C`. Over ℚ(√11) and ℚ(√47) take `v` above 5
(split in `L/F` in both: `F_v ∋ i`). **Non-vacuous form over ℚ(√11):** `Θ = (θ_{C9}, ψ_w, ψ_w̄)` has `W = ⌊4t₁⌋` proper, `K₀ = {0} × T²`, and
KS-sat fails on every fibre — while KS-1's conclusion holds there (`W′ = ⌊4t₁⌋`). So **KS-sat is not necessary for KS-1**; it fails
already inside `E_{{v}}`, where it is the wrong hypothesis. [hand + tools exact, as J51D-T2]

### 2.4 KS-1 — FALSE as stated (the adversarial member, J51D-T3)

**J51D-T3.** *Over `F = ℚ` (`R = ℤ[i][1/p : p ≡ 1 (4)]`), with `τ` the parity character `τ(x) = (x mod (1+i))/2` (`τ(U) = {1/2}`, D1-L4) and
`w, w̄` the places above 5: `Θ = (τ + ψ_w, τ + ψ_w̄)` and `W(t₁, t₂) = 2·[t₁ ≥ 1/2] + [t₂ ≥ 1/2]` satisfy KS-1's hypothesis, and its
conclusion fails.* By J51D-T2, every `Θ(u)` has one coordinate exactly `1/2`, so `C ⊆ (T × {1/2}) ∪ ({1/2} × T)` and `W(t) ≠ W(t + s)` for
**every** `t` and `s ∈ C` (a bit flips). `m₁Θ₁ + m₂Θ₂ = (m₁ + m₂)τ + m₁ψ_w + m₂ψ_w̄ ∈ T + A` iff `m = 0` (T2 (b)); so `K̂′ = 0`, `K′ = {0}`,
`cl π(Θ(U)) = {0}`, and the conclusion asks `W′(0) ≠ W′(0)`. ∎ [hand + tools exact: `tools/j51d_or_check.py` D2–D4 — `τ(u) = 1/2` and a
coordinate equal to `1/2` on all 25,492 unit vectors, and 4,000 sampled edges `{x, x + u}` (x a sum of ≤ 4 unit vectors, `t` random
rational) all proper; plants P2 (wrong parity) and P1 fire; output `data/fs100/j51d/or_check.out`.]

**What it is, and what it is not.** `x ↦ W(Θ(x) + t)` is a proper four-colouring of ℚ's plane for every `t`, reading the parity place and
one split place: its spectrum lies in `Γ ⊆ E_{{5}}`, so it has a finite-place proper factor (itself). **It is not in the gap and not over
ℚ(√11): it is not "the first control the gap has ever had"** (B5). What it refutes is the choice of `T + A` as the selection target: a
Kronecker colouring can live on `Fin_S` coordinates. The same construction works over every real field with a character `τ`, `τ(U) = {1/2}`
(a stable place with residue field `𝔽₂`, i.e. `χ(F²) = 2`, G56). **Over ℚ(√11) KS-1 is not decided here**; the one-place construction
cannot reach it [reading, sketch: its fibres are an "OR" of two coordinates, which needs two coordinates each of fractional chromatic number
2, and every `T + A` coordinate of ℚ(√11) has more (the plane has odd cycles)].

### 2.5 KS-4 and KS-5 — TRUE, and uninformative

- **KS-4.** `θ_{C9}` has values in `[2/7, 5/7] + (−1/28, 1/28) ⊆ [1/4, 3/4]` on `U` (the 8 points of the circle over `𝔽₇` give
  `2x + 3y ∈ {2,3,4,5}`, `tools/j51d_or_check.py`; plant P3 fires), so `W = ⌊4t₁⌋` is proper for every `s ∈ C` and every `t` (a shift in
  `[1/4, 3/4]` changes `⌊4t⌋` mod 4). `θ₁ ∉ E ⊇ T + A` gives `K̂′ = ℤ × 0`, `K₀ = {0} × T`, `K′ = T`, `π = ` first coordinate, `π(C) = cl θ_{C9}(U)`,
  and `W′ = ⌊4·⌋` is proper. **TRUE** [hand + tools exact].
- **KS-5.** `Γ = ⟨θ_{C9}, θ_{C9} + θ₁⟩` is free of rank 2; `m₁θ_{C9} + m₂(θ_{C9} + θ₁) ∈ T + A` iff `m₂θ₁ ∈ T + A` iff `m₂ = 0` (`T + A` is pure);
  so `K̂′ = ℤ × 0`, `K₀ = {0} × T`, `π(t₁, t₂) = t₁`, `π ∘ Θ = θ_{C9}`, and `K′ = cl θ_{C9}(R)` (`= T` when the archimedean term is non-zero).
  `W = ⌊4t₁⌋` proper as in KS-4, `W′ = ⌊4·⌋`. **TRUE** [hand].
- **G21 (a control of the wrong shape).** Both controls pass whatever `θ₁` is — even `θ₁ ∈ E ∖ (T + A)` — because `W` already reads only the
  `T + A` coordinate; "`θ₁ ∉ E`" is never used. Their failure outcome is unreachable, so passing tests nothing. The discriminating control is
  one whose `W` reads the non-`T + A` coordinates: J51D-T3 is one, and it fails KS-1.

### Would have searched here (stage 2)

- "Search for a proper `W` on `T²` or `T³` with small fibres" — replaced by the derived dichotomy J51D-T2 and a hand-built `W`; the tool only
  checks a derived identity on a complete finite set fixed in advance (heights `≤ 20,000`, seconds).

## Stage 2 — SAVED
