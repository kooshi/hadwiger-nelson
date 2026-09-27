# FS-105 — theorems proved outside the kernel (the derivation file)

*Filed by the close planner FS105-C (de Bruijn, Opus 5.5), 2026-09-26, from the records `plans/FS105-R-reading.md` (R, the reader, not blind),
`plans/FS105-D-deduction.md` (D, blind to R and to the advisor until its stage 2, `46550398`), `plans/FS105-B-derivation.md` (B, blind to X01D,
X12B, X01V and every other FS-105 record until its stage 3, `85c2eb2e`), `plans/FS105-W-walk.md` (W, not blind; its PE-2 walk committed,
`a0fee351`, before it read R) and the advisor's `plans/POROS-2026-09-26-fs105-harden-mr.md` (A). Reconciliation: `plans/FS105-harden-mr.md`
§R-close stage 1. Notation: `plans/FS100-derivation.md` §1 and §3 (`F` a real number field, `L = F(i)`, `U = U_F`, `R = ℤ[U]`, `R̂` its dual,
`T`, `A`, `E`, `m` Haar probability, `h_μ(u)` the entropy of `χ ↦ u·χ`, **admissible** `Γ`); `F₁ = ℚ(√635087)`; `F_dG = ℚ(√3,√5,√7,√11)`,
de Grey's field. EL2021 = `[EinsiedlerLindenstrauss2022]`; EL2003 = `[EinsiedlerLindenstrauss2003]`.*

**The milestone's result in one paragraph.** MR (`LEDGER.md` row 120) survives FS-105 with its grade rewritten. The proof of EL2021 Thm 1.2
that PE-2 uses is not where the record put it: EL2021 attributes it to EL2003 ("already proven in the announcement [7]"), and EL2003 is an
announcement whose §6 is headed "Outline of the proof of Theorem 1.1" (R §1.3; D §1.0) — so not a proof. EL2021 proves the more general
Thm 1.3, and Thm 1.2 follows from it by a deduction EL2021 never writes, now derived twice, the second blind (FS105-DED). PE-2's use sits
inside Thm 1.3's hypotheses at ℚ(√635087) and at de Grey's field (FS105-PEH), with a reading gap — not a mathematical one — at the
leafwise-measure machinery EL2021 cites. EF_F⁺ has a third derivation blind to the other two, at ℚ(√635087) (FS105-B-EFP), which met
X01V's old stall by the premise X01V §4.2 had named. MR at degree 16 walks through with the degree in the constants only (FS105-MR16), and
row 129's finite-graph test of MR is correct as stated, with the two shapes a refutation must take (FS105-W-D2) and nothing in print near
either. *Not a theorem, recorded here:* EL2003 does not prove its Thm 1.1 [reading, verbatim, two readers: R §1.3, D §1.0]; nothing in print
or held comes within `0.0176` of (W) [reading, one mind: W §4.3].

## §1. PE-2's external step: EL2021 Thm 1.2, its provenance and its hypotheses

**FS105-DED — EL2021 Thm 1.3 implies EL2021 Thm 1.2: for a totally irreducible, not virtually cyclic ℤ^d-action α by automorphisms of a solenoid X and an α-invariant ergodic probability µ, Thm 1.3 applies (FS105-NVC), each of its closed α_Λ-invariant subgroups G_j is finite or X (total irreducibility), some G_j = X forces µ = m_X (Haar uniqueness and ergodicity), and every G_j finite gives h_µ(αⁿ) = 0 for every n (Abramov–Rokhlin over the finite-fibred factor X → X/G_j, affinity of entropy, Abramov's power formula). (= FS105-R-D; D-T2, D-T3.) [hand; two minds, D blind to R; the advisor's sketch A §2.2 besides, whose ingredients R received]**
*Proof:* R §2.1 steps 1–5; D §2.1 steps 0–3 with its table of classical inputs C1–C6 (§2.2) and senses S1–S6 (§2.3). *Proof verdict:*
TRUE by both, no divergence of truth (D Stage 3); D's Case A uses neither Thm 1.3(3) nor the orbit argument, R's uses (3); D's Case B needs
no finiteness of entropy. Thm 1.2 so carries exactly Thm 1.3's grade: [external], a published theorem (ETDS 42 (2022)) whose proof EL2021
gives in §4.3 and §§4.4–7. *Rests on it:* FS100-PE2's external input at every field; hence row 120 and every given-MR headline (rows
121–130). *Prior art:* the deduction is not written in EL2021 (every "Theorem 1.2" in its text is on pp. 2–3; p. 3: "The proofs of Theorem
1.2 and Theorem 1.3 follow the outline of Rudolph's proof", D §1.0); EL2003 gives "a sketch" (§6); the inputs are classical (Walters,
*An Introduction to Ergodic Theory*, Thms 4.13, 8.1; Abramov–Rokhlin). A routine step; no novelty claimed. *Kernel:* declined — solenoid
actions and Kolmogorov–Sinai entropy are not on Mathlib's surface; FS-101 carries MR as the named hypothesis `hMR`, whose statement is
unchanged.

**FS105-VC — Under the literal reading of EL2021 p. 2 the trivial factor X/X is virtually cyclic (αᵐ = id = α^{0·n}), so Thm 1.3's hypothesis "no virtually cyclic factors" is satisfied by no action unless it means no non-trivial algebraic factor on which the induced action is virtually cyclic; that is EL2021's own use (Lemma 7.4, p. 32, applied to Y_irred ≠ 0) and the sense PE-1′ used. (= FS105-R-VC; D S3; A §2.2 (i).) [hand; three minds, D blind]**
*Proof:* R §2.2; D §2.3 row S3; A §2.2. *Proof verdict:* TRUE, three times. *Rests on it:* FS105-DED; FS100-PE1's "without virtually
cyclic factor". *Prior art:* EL2021 p. 2 (the definition) and p. 32 (the use). *Kernel:* declined.

**FS105-NVC — If a ℤ^d-action α by automorphisms of a solenoid X is irreducible and not virtually cyclic, then d ≥ 2, X ≠ {0}, and no algebraic factor map onto a non-trivial solenoid carries a virtually cyclic action; if α is totally irreducible, the same holds for every restriction α_Λ′ to a finite-index subgroup. (= D-T1; R §2.1 step 1; A §2.2 (ii).) [hand; three minds, D blind]**
*Proof:* D §2.1 steps 0a–0d (primal: `x ↦ α^{m−kn}x − x` is a continuous homomorphism of the connected `X` into the finite kernel, hence 0);
R §2.1 step 1 (dual: an automorphism of the torsion-free `X̂` is fixed by its restriction to a finite-index subgroup); A §2.2 (ii).
*Proof verdict:* TRUE by all three, the same fact from the two sides of Pontryagin duality. *Rests on it:* FS105-DED. *Prior art:* none
sought; elementary. *Kernel:* declined.

**FS105-L21 — For every ℤ^d-action α by automorphisms of a solenoid: if α has no non-trivial virtually cyclic factor, then neither has its restriction α_Λ to a finite-index Λ (through X″ = ⋂ αⁿX′) nor the adelic lift of EL2021 Lemma 4.2 (virtual cyclicity depends only on the ℚ-span of the invariant subgroup). EL2021 applies Thm 4.1 to α_Λ and Thm 1.3 to the lift, and writes neither transfer. (= FS105-R-L2.1.) [hand; one mind, its first half re-checked by D]**
*Proof:* R §2.1, Lemma 2.1. *Proof verdict:* TRUE (R); D Stage 3 re-checked part (i) by hand ("Sound"), not part (ii). For the FS-105
pieces both transfers are immediate anyway (R §2.3). *Rests on it:* FS105-PEH's reading of (a4) on the lift; nothing else. *Prior art:*
EL2021 §4.3, Lemma 4.2 (the places the transfer is used). *Kernel:* declined.

**FS105-PEH — PE-2 applies EL2021 Thm 1.2, hence Thm 1.3, within its hypotheses at ℚ(√635087) and at de Grey's field: for admissible Γ = ⟨u, w⟩ ≅ ℤ² and M ⊆ R finitely generated over ℤ[Γ] with ℚM = L, M̂ is a solenoid (dimension 4 at F₁, 32 at F_dG), Γ acts by automorphisms, totally irreducibly (⟺ admissibility, finiteness by Lemma F), not virtually cyclically and with no non-trivial virtually cyclic factor (on M̂, every α_Λ and the adelic lift), d = 2, every measure PE-2 feeds in is a Γ-ergodic probability, one entropy notion on both sides, Lemma W holds at both fields; and Thm 1.3's proof, as far as read, assumes nothing more for these pieces — semisimple, totally A-irreducible, isometric at every archimedean place, so every Lyapunov weight is non-archimedean and the last step of Thm 4.1's proof writes the purely p-adic case. (= claims (a1)–(a9); W's FS105-W-PE.) [hand + reading; one reading at F₁ (R), two separate readings at F_dG (R; W), each a checking reading of X02D and X02V; (a9) a reading gap at the cited machinery]**
*Proof:* R §§2.3–2.5, §3.2–3.3 (both fields); W §3.1–3.2 (`F_dG`, committed before reading R); the derivations walked are X02D §2–3
and X02V §2. *Proof verdict:* TRUE item by item, both fields (the reconciliation's table); (a9) TRUE as far as read, with a **reading gap,
not a mathematical one**, at `[10]` §7, `[11]` Prop. 6.4 and Lemma 5.2, `[5]` Thm 8.2, Prop. 6.2, Lemma 5.10, `[9]`, `[28]`, `[34]` Thm
3.7, and the unread proofs of Thm 7.1, Prop. 7.5 and EL2021 §§5–6 (R §3.1's reading table). Fetching `[10]`, `[11]`, `[5]` declined for
now by the owner (item 21): Thm 1.3 is a refereed published theorem, used by statement. *Tools:* `tools/fs105_r_scope.py` (plants
`--plant-wall`, `--plant-lemmaw` fire); `tools/fs105_w_setting.py`, `tools/fs105_w_admissible.py` (A1–A3). *Rests on it:* FS100-PE2 at
`F₁` and `F_dG`; FS103-635, FS103-DG through MR. *Prior art:* EL2021 §§1, 2, 4 and the end of §7 (read in full, R); EL2003 p. 100 ("we do
not assume any hyperbolicity"). *Kernel:* declined.

**FS105-H — For F totally real, γ ∈ U_F non-torsion and ℤ[γ^{±1}] ⊆ M: h_{m_{M̂}}(γ) ≥ log 2 (the Haar entropy of the cyclic factor is the Mahler measure of γ's primitive minimal polynomial, every archimedean absolute value of γ is 1, and γ is not an algebraic integer by Kronecker, so the leading coefficient is at least 2). (= FS105-R-H.) [hand; one mind, on the Mahler-measure entropy formula, textbook]**
*Proof:* R §2.5 (ii-a). *Proof verdict:* TRUE (R); W's positivity (X02D §3.3's Lemma H) agrees and is weaker. *Rests on it:* X02V's
uniqueness step and X02D's second route; FS105-PEH's Thm 5.1 denominator (R §3.2). *Prior art:* Lind–Schmidt–Ward; Yuzvinskii for the
cyclic case. *Kernel:* declined.

**FS105-L74 — EL2021 Lemma 7.4's conclusion (two linearly independent Lyapunov weights on Y_irred) holds for the FS-105 pieces directly: Y_irred is the whole lift, χ_𝔓(a, b) = b·log|w|_𝔓 at the prime of Lemma W and χ_v(a, b) = a·log|u|_v at a finite v where the non-torsion u is not a unit. (= FS105-R-7.4.) [hand; one mind; an exact instance at F_dG]**
*Proof:* R §2.3. *Tools:* W's A2 valuation matrix (rank 2 at the primes above 5 and 421, W §3.3) is this check at `F_dG`, made for a
different reason. *Proof verdict:* TRUE. *Rests on it:* FS105-PEH (the one place EL2021's proof consumes "no virtually cyclic factors").
*Prior art:* EL2021 Lemma 7.4 (proved there from the hypothesis by Dirichlet's unit theorem). *Kernel:* declined.

**FS105-SCOPE — The scope facts: 635087 is prime; F₁ is totally real of degree 2, its dyadic prime (e = 2, f = 1) splits in F₁(i); F_dG is totally real of degree 16, its four dyadic primes (e = f = 2) split in F_dG(i) into eight; so neither field has a stable dyadic place and R = O′ at both (rows 100, 105); at F_dG the least prime totally split in L is 421 and μ(L) = μ₁₂; at F₁ the first stable primes lie above 103, 107, 127, 163 and 635087. (= FS105-R-S; FS105-W-S; B §1.3.) [tools exact; two code runs at each field — F₁ (R, B), F_dG (R, W); plants fire]**
*Proof:* `tools/fs105_r_scope.py`, `tools/fs105_b_setting.py`, `tools/fs105_w_setting.py` (S1–S5, S8), outputs under `data/fs105/`.
*Proof verdict:* agree wherever they overlap. *Rests on it:* every FS-105 claim's scope line. *Prior art:* none needed. *Kernel:* declined.

## §2. EF_F⁺ at ℚ(√635087), blind (FS105-B)

**FS105-B-M1 — For every real number field F with R = O′: R̂ ≅ 𝔸_𝒮/D equivariantly, where 𝒮 is the set of split finite places of L together with the archimedean ones, Φ(x)(r) = ψ_𝒮(xr), ker Φ = D = {ℓ ∈ L : ℓ ∈ 𝔡_v⁻¹ at every stable v}, T = Φ(L) and A = Φ(L_∞); so x ∈ T + A iff a lift has its finite part in the diagonal L. [hand; one mind (B), the model derived; X12B states the same model by Tate duality in one line, X01D a different presentation]**
*Proof:* B §1.4 (M1–M4) and §Stage 2 "M1 proved". *Proof verdict:* TRUE (B; its Stage 4 table: "same model; none"). *Rests on it:*
FS105-B-EFP, -L5, -L6. *Prior art:* `S`-integer self-duality (Tate, Weil), here with `𝒮` infinite as a direct limit. *Kernel:* declined.

**FS105-B-L5 — At F₁, for a U-invariant finite μ with h_μ(u*) = 0 for one non-torsion u*: μ-almost every x has its 𝔓₀-coordinate in L, where 𝔓₀ is a split place at which u* expands (Lemma 0). [hand; one mind, blind]**
*Proof:* B Steps 1–5 (lift uniqueness on a small neighbourhood; Bowen balls thin at `𝔓₀`; SMB gives `μ(x + W_n) ≥ e^{−nβ}`; the pigeonhole
over `(s+i)/(s−i)`, at least `½M^{1/4}` of height `≤ M`; the collision is a global `ℓ_n ∈ L` of polynomial height; Liouville at `𝔓₀`
freezes it; the other places paid for in the heights). *Proof verdict:* TRUE (B; no failing line against X01D §3, X12B §2, B Stage 4).
*Rests on it:* FS105-B-EFP. *Prior art:* `[EinsiedlerFish2010]` Lemmas 3.1–3.2, transferred. *Kernel:* declined.

**FS105-B-L6 — A U-invariant finite measure on T + Y_{𝔓₀} (global at one place) lives on T + A: each other split place is killed by a contraction z/σz ∈ U with z ∈ 𝔔 ∖ σ𝔔 (no class number needed), a finite measure invariant under a contraction of L_𝔔 sitting at 0; U-invariance only, no entropy. [hand; one mind, blind]**
*Proof:* B Step 6, Lemmas 6a–6b. *Proof verdict:* TRUE (B); X01D's wandering shells and X12B's Lemma Z reach the same end with stabilisers
and a class number (B Stage 4). *Rests on it:* FS105-B-EFP. *Prior art:* not in EF 2010 (the circle has one place). *Kernel:* declined.

**FS105-B-EFP — EF_F⁺ at F₁ = ℚ(√635087): every U-invariant finite positive Borel measure μ on R̂ with h_μ(u*) = 0 for one non-torsion u* ∈ U satisfies μ(R̂ ∖ (T + A)) = 0. [hand; one mind, blind — with X01D and X12B, three derivations blind to one another, and X01V's checking reading]**
*Proof:* B §Stage 2 (M1, Steps 0–6) and Stage 3's one-paragraph proof; the multiplier count `≥ ½M^{1/4}` checked exactly
(`tools/fs105_b_heights.py`, H1–H4; `tools/fs105_b_setting.py`; every plant fires; H3's constant fixed on the boundary, a tool slip, not a
proof defect, item 27). Controls run: C-1 (`F = ℚ`: the conclusion is `T + A`, never finite support), C-2 (a finitely generated `Γ` must
fail; the proof uses the count no such `Γ` has). *Proof verdict:* TRUE; it meets X01V's blind stall ("images `u′B` small at every place")
by the premise X01V §4.2 named ("the product over all places of the error"), blind (the close's classification, §R-close 1.2). *Scope
(not claimed by B):* nothing reads `[F:ℚ] = 2` but `κ = 1/(2d)`, and any `κ > 0` works, so the argument runs at every totally real `F`
with `R = O′` — W's FS105-W-G walks it at degree 16. *Rests on it:* FS100-EFP's count of minds; FS100-MR at `F₁`; rows 128–129 at
ℚ(√635087). *Prior art:* FS100-EFP's cell (method `[EinsiedlerFish2010]`; transfer not found in print). *Kernel:* declined (as FS100-EFP).

**FS105-B-EF0 — EF_F⁰ at F₁: every U-invariant, U-ergodic probability μ on R̂ with h_μ(u) = 0 for every u ∈ U satisfies μ(E) = 1 — a corollary of FS105-B-EFP with u* = (3+4i)/5, ergodicity unused. [hand; one mind, blind]**
*Proof:* B §Stage 2, Corollary. *Proof verdict:* TRUE. *Rests on it:* given PE-2, MR at `F₁` needs only this (inventory item 13).
*Prior art:* X01V §2.3's statement. *Kernel:* declined.

## §3. MR at degree 16 (C-MR16)

**FS105-W-H — For q = (a+bi)/c ∈ U_ℚ (a primitive triple) and F of degree n with L = F(i): H_L(q) = c^n exactly in normalised absolute values on L, so #{q ∈ U_ℚ : H_L(q) ≤ M} = #{q : den q ≤ M^{1/n}} = (4/π + o(1))M^{1/n}; X12B's H_L(q) ≤ c^{[L:ℚ]} is valid and loose by a factor 2 in the exponent. [tools exact; one mind]**
*Proof:* W §1.2 (S7, ten triples), §2.0. *Proof verdict:* TRUE. *Rests on it:* FS105-W-G; a normalisation note on FS100-EFG (b).
*Prior art:* the count of primitive Pythagorean triples. *Kernel:* declined.

**FS105-W-G — EF_F⁺'s zero-entropy argument (X01D §3, X12B §2) needs exactly liminf_M log #V_M / log M > 0, polynomial growth of the multipliers in H_L with any positive exponent: its exponents are degree-free (K > 9, chosen first), the degree entering only the constants (4ε)^{2n}, (16ε)^{2n}, 2^{2n} and the choice β < 1/(nK), which Lemma 3.1′ supplies for every β; at n = 16, K = 16, β = 1/512, the pigeonhole exponent is 1/16 − 1/32 = 1/32 > 0; sub-polynomial growth, (log M)^k, would not suffice. [hand, a checking reading of X01D and X12B, not blind; tools exact (G1–G4); one mind — B's blind scope remark, "any κ > 0 works", agrees]**
*Proof:* W §2.1–2.3; `tools/fs105_w_growth.py` (G1–G3; the inert split filter of stage 2 fixed and guarded by G4, the numbers unchanged,
item 31). *Proof verdict:* TRUE. *Rests on it:* FS105-MR16; G80's *Do*. *Prior art:* `[EinsiedlerFish2010]` (1.1) takes any `α > 0`.
*Kernel:* declined.

**FS105-W-LW — At F_dG, z = √3+√5+√7+√11+21i+1 has v₄₂₁(N_{L/ℚ} z) = 1, and Γ = ⟨(3+4i)/5, z/c(z)⟩ ≅ ℤ² is admissible: every non-trivial element of Gal(L/ℚ) moves the 421-part of div(w), so no non-zero power of w lies in a proper subfield of L (all 373 excluded at once); control ⟨(3+4i)/5, (5+12i)/13⟩ generates only ℚ(i), not admissible. [tools exact + hand (the divisor argument); one mind]**
*Proof:* W §1.2 (S6), §3.1 (A1: `(τ(w)/w)¹² ≠ 1` for all 31 `τ ≠ 1`, a second exact route). *Proof verdict:* TRUE. *Rests on it:*
FS105-PEH at `F_dG`; FS105-MR16. *Prior art:* Lemma W (FS100-PE1), made explicit. *Kernel:* declined.

**FS105-MR16 — C-MR16: MR(F_dG) holds by row 120's proof, every step walked at [F:ℚ] = 16 — EF_F⁺ by FS105-W-G, PE-2 by FS105-PEH at F_dG, the composition FS100-MR (a) field-free; the degree enters only constants chosen before the scale and the count of subfields one totally split prime excludes at once. [hand, a checking reading, one mind, not blind; tools exact; resting on EL2021 Thm 1.3 and FS105-DED]**
*Proof:* W §2–3, §5.1 (with W §3.3's correction: "given EL2021 Thm 1.3 … and FS105-R-D", not "Thm 1.2 by statement"). *Proof verdict:*
TRUE, no GAP and no FALSE; audited at the places a degree-16 failure would sit (a degree-dependent exponent; an archimedean constant
outgrowing the thinness; a count below what `β` allows; a normalisation mismatch; admissibility read off `ℚ(Γ) = L`; a `Γ` from `U_ℚ`),
three exactly (W §5.1). *Rests on it:* FS103-DG and row 128's de Grey instance (the owner's ruling, item 33: ℚ(√635087) stays the headline
carrier; `F_dG` an instance at a reading grade). *Prior art:* as row 120. *Kernel:* declined.

## §4. Row 129's finite-graph test

**FS105-W-D1 — MR(F₁) implies α₁(ℝ²) = m₁(ℝ²) through α₁(ℝ²) ≤ α₁(F₁²) ≤ α_inv(F₁²) ≤ α_loc(F₁) = m₁(ℝ²) ≤ α₁(ℝ²), every direction named; the only MR-carrying link is FRAC; row 129's killing test ("any proof that α₁(ℝ²) > m₁(ℝ²) refutes MR at ℚ(√635087)") is correct as stated and uses only B-AMEN's Følner half (two blind derivations: FS103-F, FS103-B), not its one-mind reverse half and not B-CHIF. [checking reading, one mind, not blind]**
*Proof:* W §4.1 (links L1–L5 with their reasons and minds). *Proof verdict:* TRUE. *Rests on it:* row 129's killing test; its grade line
(the correction drafted in §R-close stage 4). *Prior art:* L5 is `[MatolcsiEtAl2025]` (14) and `[DuczVarga2026]` Claim 1. *Kernel:*
declined.

**FS105-W-D2 — With the best proved bounds (m₁(ℝ²) ≤ 0.24699…, `[AmbrusEtAl2023]` Thm 1; α₁(ℝ²) < 1/4.0007 = 0.249956…, `[DuczVarga2026]` Lemma 1 and its blow-ups), a proof of α₁(ℝ²) > m₁(ℝ²) must be (W) a constant c ∈ (0.24699…, 0.249956…) with α(G) ≥ c|G| for every finite unit-distance graph G in the plane, equivalently sup_G χ_f(G) < 4.04876, a window 0.00297 wide in ratio; or (W′) χ_f,0(ℝ²) < χ_f(ℝ²), which with B-CHIF gives α₁ > m₁ and answers "strict" to `[MatolcsiEtAl2025]` §2's open question; neither implies the other. [derived from held papers; one mind]**
*Proof:* W §4.2. *Proof verdict:* TRUE (W); the close re-did the arithmetic (§R-close 1.1). *Rests on it:* row 129's sentence (drafted
in §R-close stage 4). *Prior art:* MRVZ §2 states (W′)'s question open ("it is not known whether equality holds"); the cheap form
`α₁ ≥ 1/4` (MRVZ's Conjecture 1) is false in print (`[DuczVarga2026]`). *Kernel:* declined.

## §K. Kernel decisions, summarised

Every entry declined: the objects (solenoid actions, Kolmogorov–Sinai entropy, restricted-product duality, `m₁`, `α₁`) are not on Mathlib's
surface. **FS-101 is unaffected**: its named hypothesis `hMR` states MR, whose statement FS-105 left unchanged; only its grade moved.
