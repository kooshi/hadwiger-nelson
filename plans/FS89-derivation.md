# FS-89 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Written 2026-09-25 at the close (WORKFLOW 2.0 step 9) by the close planner (de Bruijn, Opus 5.5), from Stage 0's two records
(`plans/FS89-S0A-gluing-verification.md`, verifier G; `plans/FS89-S0B-band-set.md`, S0B), the plan (`plans/FS89-rational-band-rigidity.md`,
the planner's P-R1), and Stage 1's three records (`plans/FS89-S1D-derivation.md`, the derivation agent D; `plans/FS89-S1V-verification.md`,
verifier H; `plans/FS89-S1VB-verification.md`, verifier I). Grades are `CLAUDE.md` § Notation's. A proof held in a record is not repeated
here; this file is the index that survives the ledger rows' compression (rows 95–97). `LEDGER.md` § B indexes every entry, one line each
(`tools/fs71_ledger_b_check.py --strict`). **FS-89 added no Lean**, so nothing below is kernel-checked, and every kernel decision is recorded
per entry.*

**Duplicates are merged, one entry per theorem.** An entry carries the id of its first derivation, and its title names every other id the
records give it (`= S1V-4`, `= S1VB-10`, …), so a grep for any of them lands here. What was independent is stated per entry: **blind** means
the deriver had not seen the other derivation or its statement; **from the statement** means it had seen the statement, not the proof.
**Verifier corrections are applied as filed:** verifier H's wording slip and gap in S0B §6 (FS89-S0B-T6); verifier I's scope correction of
D's §3 (FS89-D1-T2); verifier H's precision on U2's order-4 types (FS89-S1V-5).

**Who found what.** **Verifier G** (Stage 0A, blind to S0B): S0A-1 to S0A-13. **S0B** (Stage 0B): S0B-T1 to T6, C1, L4. **The planner**:
P-R1. **D** (Stage 1, the derivation agent): D0-T1, D1-*, D2-*, D5-*. **Verifier H** (Stage 1 V-A, blind to D): S1V-1 to S1V-10. **Verifier
I** (Stage 1 V-B; phase B1 blind to D's routes, phase B2 given D's lemma statements without proofs): S1VB-1 to S1VB-14. The **owner** (one-step
checks, cited by close-inventory item), the **close planner** (§9, one entry of tools grade and four compositions) and the **prior-art reader**
of `[Berend1983]`/`[Berend1984]` (§9a: PA-B1, PA-B2; its PA-B3 is a reading, §10).

> **Correction owed (2026-09-25 crunch):** see `plans/FS91-S0V2-SWm-second-reading.md` §3.4, §3.7 and `plans/FS91-S1D-character.md` §4.4; carried in `plans/FS91-close-inventory.md` rows 61, 69, 78. Not applied here; the close rewrites this entry.

**Notation, fixed once** (the plan's §0.1). `R_S = ℤ[i][1/p : p ∈ S]` for a set `S` of primes `p ≡ 1 (mod 4)`; `w_p = π_p/π̄_p`
(`w₅ = (3+4i)/5`, `w₁₃ = (5+12i)/13`); `U_S = ⟨i⟩ × ⟨w_p : p ∈ S⟩`; `Q = R_{all} = ℤ[U_ℚ]`; `R₆₅ = R_{{5,13}}`. The band `B_k = [1/k, 1 − 1/k]`;
`Θ_k(R) = {θ ∈ Hom(R, ℝ/ℤ) : θ(U) ⊆ B_k}`, a **band character** a point of it. `A`: archimedean characters `λ_e(x) = Re(ē x)`; `T`: torsion;
`T_N`: killed by `N`. For a real field `F`, `R_F = ℤ[U_F]`. `θ₂` the parity character. A **leaf** is `τ + {λ_d : |d| ≤ r_τ}`, `r_τ` the margin.
A **corner** is a character `x` with `2x = θ₂` (orbit coordinates `(1+i)/4 + ½ℤ[i]`). **RQ_k**: `Θ_k(Q) ⊆ T + A`. **RS_k(S)**: `Θ_k(R_S) ⊆ T + A`.
**MS_k(S)**: every `U_S`-minimal closed subset of `Θ_k(R_S)` lies in `T + A`.

*Erratum (2026-10-03, FS129-SA1, from FS91-J03a-9 and FS91-J07-14; `plans/FS91-close-inventory.md` rows 61, 69, 78):* over `R_F` with `F ≠ ℚ`, read `A` as `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`, the archimedean characters of every place of `F(i)`; `λ_e(x) = Re(ē x)` at one embedding is its case `F = ℚ`. With the one-embedding reading FS89-S0A-2, FS89-S0A-10 and FS89-CL2 are false (ℚ(√3), band 1/4: `τ + Re(ē σ₂(·))`); with `A(R_F)` they hold, and every proof step in this file already reads every real place (FS91-J07-14). *(Filed 2026-10-03 by FS129-Z1, verbatim from `plans/FS129-SA1-audit.md` § 3.1's draft; `plans/FS129-close-inventory.md` item 108. The Notation above stands as written.)*

**Scope, stated once.** Every statement below is about **characters** (colourings `x ↦ ⌊kθ(x)⌋`), never about `χ`: at four colours emptiness
of `Θ₄` is one-sided (G71), and a non-character colouring is untouched. A result on `Q` or `R_S` is a result on the rational unit circle; it
reaches a real field `F` only through the gluing (FS89-S0A-2) and at that entry's grade. "Not found in print" is not "new". **Prior art,
read:** `[Berend1983]` and `[Berend1984]` (TAMS 280 and 286), saved by Kooshi at the close, were read in full by a prior-art reader
(`plans/FS89-PA-berend1984.md`, verdicts in its §4): **none of FS-89's statements is in them or in `[Berend1984min]`; the method is Berend's**
— D1-L3's above all, which is 1984 §II.3 written out `p`-adically. "New" still waits on Berend's later citers, of which the close's gate
opened what it could reach (plan §R-close.6).

## §1. The gluing and its consequences (verifier G, blind; the owner)

**FS89-S0A-1 — G0: `ℤ[U_ℚ] = ℤ[i][1/p : p ≡ 1 (4)]` ∋ 1/5; the layers `bℤ[U_ℚ]` (`b ∈ U_F`) lie in `R_F` and cover `U_F`; a band character of `R_F` restricts to a band character on every layer. [hand; verifier G blind; the planner's §0.1 restates it]**
*Proof:* `plans/FS89-S0A-gluing-verification.md` §C1 G0 (Hilbert 90 per prime). *Proof verdict:* closes. *Rests on it:* every entry below
that passes from `Q` to a field. *Prior art:* `[Fischer1990b]` (the unit-vector ring of a quadratic field in closed form); G74's layers.
*Kernel:* stub (FS-47, the unit-vector ring in the kernel).

**FS89-S0A-2 — G1, the gluing: `Θ_k(ℤ[U_ℚ]) ⊆ T_N + A` ⟹ `Θ_k(R_F) ⊆ T_N + A` for every subfield `F ⊆ ℝ`, at every band; the lift `lim 5^k·(small rep of Nθ(x/5^k))` is one real functional, and the gluing reads only `ℤ[1/5]` in each layer, never the band. [hand; verifier G blind; the route is the advisor's sketch, closed]**
*Proof:* S0A §C1 G1, steps 1–6; the advisor's sketch `plans/POROS-2026-09-25-fs86-next.md` §3; inventory item 10. *Proof verdict:* closes;
the sketch's two unsaid lines (additivity; "the lift ≡ ψ mod 1") are supplied (S0A §C2 D3). *Rests on it:* S0A-6, S0A-10, FS89-CL2–CL5;
D2-L1 is the same argument with a general base. *Prior art:* G74's `5^{−k}` gluing (FS-81) at three colours; the form over every `F ⊆ ℝ` not
found. *Kernel:* stub (a candidate for FS-87's list: short, and the conduit from `Q` to every field).

**FS89-S0A-3 — Lemma N₀: `Θ₄(Q) ∩ (T + A) ⊆ T₁₆₈ + A`; the torsion part is one of a 2-part of order dividing 8, an order-3 part (with `|α| ≤ 1/12`) or an order-7 part (`|α| ≤ 1/28`), and each occurs (= S1V-4, verifier H's V2). [hand; two derivations, both blind: verifier G, and verifier H before it opened S0A's record (its divergence table was written after its verdict's commit 78b5638d); Weil's bound external]**
Odd levels collapse to 1; a non-zero odd piece is exactly the middle half of the residues, and its complement's Fourier coefficient is a
Kloosterman sum, so Weil forces `q ≤ π²`, leaving 3 and 7; the 2-part has order dividing 8 and vanishes beside an odd piece. *Proof:*
S0A §C1 G1 (Lemma N₀); `plans/FS89-S1V-verification.md` § V-A2, V2a–V2e; `tools/fs89_s1v_n0_check.py` (0.5 s, a fixed list of orders the
derivation names, three plants); inventory items 10, 25. *Proof verdict:* closes (the two routes agree at every step; S0A's 2-adic step is
shorter). *Rests on it:* S0A-2's fixed `N = 168`; S1V-5; FS89-CL2. *Prior art:* the middle-half/Weil step is FS89-S0A-8's; not found in print
as a classification. *Kernel:* declined (rests on Weil's bound).

**FS89-S0A-4 — Level collapse: a band character in `T + A` has level ≤ 1 at every odd stable place where the unit vectors are dense at every level, and 2-level ≤ 3 at ℚ(i)'s ramified 2 (bands 1/4 and 1/5). [hand; verifier G]**
*Proof:* S0A §C1 G1 (Lemma N₀), G2 step 3. *Proof verdict:* closes. *Rests on it:* S0A-3, S0A-8, S0A-9. *Prior art:* row 75's fibre-share
reasoning, of which this is the band form. *Kernel:* declined.

**FS89-S0A-5 — No band character of any `R_F` has layer restrictions in `T + A` of unbounded order; the 3-adic character at the split prime above 3 of ℚ(√2) is layer-wise torsion, not in `T + A`, and not a band character. [hand; verifier G (its adversarial attempt, which failed for a stated reason)]**
*Proof:* S0A §C1 G1, the adversarial attempt. *Proof verdict:* closes. *Rests on it:* the gluing's hypothesis being sharp. *Prior art:* none.
*Kernel:* declined.

**FS89-S0A-6 — C-HD1, conditional form: the four-band rational statement (RQ₄) implies HD1 (`Θ₄(R_F) ⊆ T`, dyadic torsion) for ℚ(√59), ℚ(√83), ℚ(√131). [hand, given FS86-dB-Theta's inputs; verifier G]**
S0A-2's output is exactly FS86-dB-Theta's hypothesis (a torsion character of `R` is torsion at the stable places). *Proof:* S0A §C1 G1; §C2
D5. *Proof verdict:* closes. *Rests on it:* FS89-CL3. *Prior art:* none. *Kernel:* declined.

**FS89-S0A-7 — Archimedean averaging: over a real number field, the torsion part of a band character in `T + A` is itself a band character, non-zero, with margin `r`. [hand; verifier G]**
The linear archimedean part averages away over the unit vectors, so Croft's `m₁` does not enter for characters. *Proof:* S0A §C1 G3 step 3.
*Proof verdict:* closes. *Rests on it:* S0A-8, S0A-9 (the five-colour case closes only through it; S0A §C2 D7(b)). *Prior art:* none.
*Kernel:* declined.

**FS89-S0A-8 — G2, general form: for `F` in Lemma R's scope with every stable place odd of prime residue field `q ≥ 11`, `Θ₄(R_F) ∩ (T + A) = ∅`; given RQ₄, `Θ₄(R_F) = ∅`; instance ℚ(√47). [hand, given Lemma R (FS86-B1-LR, its corrected scope) and Weil; verifier G; the owner's one-step check]**
The band collapses every tower to level 1; the torsion part's value multiset at one place is the middle half, each value twice; its
frequency-1 coefficient has modulus `1/sin(π/2q)`, an eigenvalue of `Γ_q`, so `≤ 2√q` by Weil, and `1/sin(π/2q) > 2√q` for `q ≥ 11`.
*Proof:* S0A §C1 G2; inventory item 12 (the owner: 7.03 > 6.63 at 11). *Proof verdict:* closes; **fewer inputs than FS86-CL1**: no
`[AmbrusEtAl2023]`, no FS-66 certificate, no `[Zhang2012]`. *Rests on it:* FS89-CL4. *Prior art:* none. *Kernel:* declined (Weil).

**FS89-S0A-9 — G3: under the five-band rational statement (RQ₅), `Θ₅(R_{ℚ(√167)}) = ∅`; needed at each stable place, a level-one ratio `< 1/5`: 23 (`α ≤ 97`, FS-66) and 43 (`α ≤ 365`, FS-53) by certificate, 59 by exact spectrum (Hoffman 0.19912), every `q ≥ 67` and the ramified 167 by Weil. [hand + cert + tools exact; verifier G]**
*Proof:* S0A §C1 G3; §C2 D7 (the advisor's sketch omitted 43, and "the same argument" fails at 1/5 if the product includes the real places,
`χ_f ≤ 4.36 < 5`; it closes through S0A-7). *Proof verdict:* closes. *Rests on it:* FS89-CL5. *Prior art:* none. *Kernel:* declined (rests on
FS-53's and FS-66's certificates, themselves tools-checked).

> **Correction owed (2026-09-25 crunch):** see `plans/FS91-S1D-six.md` stage 6 (J08-11) and J08's "Proposed edits"; carried in `plans/FS91-close-inventory.md` row 85. Not applied here; the close rewrites this entry.

**FS89-S0A-10 — The equivalence: `Θ_k(ℤ[U_ℚ]) ⊆ T + A` ⟺ `Θ_k(R_F) ⊆ T + A` for every subfield `F ⊆ ℝ`, every band; the rational statement is the uniform statement at its hardest-looking instance, not a lemma on the way to it. [hand; verifier G]**
⟸ is `F = ℚ`; ⟹ is S0A-2 with the order bound (automatic at four colours by S0A-3; finite, not computed, at five). *Proof:* S0A §C3.
*Proof verdict:* closes. *Rests on it:* FS89-CL2; the plan's §IQ. *Prior art:* none. *Kernel:* declined.

**FS89-S0A-11 — Finite-type band characters of `Q` are in `T + A` at bands 1/4 and 1/5: a counterexample to RQ must read infinitely many split places (= FS86-dB-Sv at `F = ℚ`, reproved blind). [hand; verifier G blind; de Bruijn at FS-86]**
*Proof:* S0A §C3 (a deep pole at one split place `v` kills the partner place's component; `v`'s component sweeps a coset of step
`1/p ≤ 1/5`). *Proof verdict:* closes. *Rests on it:* the plan's FT line. *Prior art:* FS86-dB-Sv. *Kernel:* declined.

**FS89-S0A-12 — A `T + A` statement about `ℤ[U₅]` cannot exclude split components at primes `p ≠ 5`: a continuous character at `p` restricts to every `ℤ[U₅]`-layer as torsion of order `p^k`; so one-prime gluing needs `Θ_k(ℤ[U₅]) ⊆ T_N + A` with `N` fixed, and the advisor's "if the single-prime band set is torsion-plus-archimedean, HD1 lands" overclaims. [hand; verifier G; the owner's one-step check]**
*Proof:* S0A §C2 D8; inventory item 14. *Proof verdict:* closes. *Rests on it:* the correction of the S0B brief (inventory item 15); why
FS-81's C1(5) needed its `N = 6`. *Prior art:* none. *Kernel:* declined.

**FS89-S0A-13 — Weil check: `max|λ| ≤ 2√q`, and the middle-half coefficient `1/sin(π/2q) > 2√q` for every `q ≡ 3 (4)`, `11 ≤ q ≤ 83`; Hoffman ratios at 23 and 43 exceed 1/5, at 59 it is 0.19912. [tools (float, margins printed); verifier G]**
*Proof:* `data/fs89/s0a/circle_spectra.py`. *Proof verdict:* closes at float grade with printed margins. *Rests on it:* S0A-8, S0A-9's 59
entry. *Prior art:* G44 (Kloosterman control). *Kernel:* declined.

## §2. One prime is not enough (S0B; verifier H; the owner)

**FS89-S0B-T1 — The rank-one orbit model: `Θ_β(U₅)` ≅ bi-infinite sequences `e_m ∈ Q_β = [β, 1−β]²` with `e_{m+1} − w̄e_m ∈ π⁻¹ℤ[i]` (layers `wᵐℤ[i]`); a character is a forward and a backward orbit sharing `e₀`. [hand + tools exact; S0B (two models agreeing to depth 6, and the adelic formula value for value at `|m| ≤ 25`); the owner re-derived the step rule]**
*Proof:* `plans/FS89-S0B-band-set.md` §1, C1; `tools/fs89_s0b_orbits.py`, `tools/fs89_s0b_heteroclinic.py`; inventory item 13. *Proof verdict:*
 closes. *Rests on it:* S0B-T2 to T5; its rank-`r` form FS89-D0-T1. *Prior art:* FS81-C-verification §1.2 (the `L`-layer form).
*Kernel:* declined.

**FS89-S0B-T2 — Leaves: `τ + λ_d ∈ Θ_β` iff `|d| ≤ r_τ`; in adelic form `T + A` is exactly "the two 5-adic components are images of one Gaussian rational"; forward layers read `b₊`, backward `b₋`; if two leaf discs meet, a forward half of one and a backward half of the other form a character outside `T + A`. [hand; S0B]**
At three colours the parity disc (radius 1/6) misses the order-3 points (distance `√2/6`), which is why FS81-T3 holds; at four colours
(radius 1/4) they lie inside it. *Proof:* S0B §2. *Proof verdict:* closes. *Rests on it:* S0B-T3, T4; S1V-10's rank-`r` form. *Prior art:*
none. *Kernel:* declined.

**FS89-S0B-T3 — The heteroclinic `θ*` (the order-3 character on forward layers, `θ₂ + λ` on backward ones, glued at `e₀ = (1+i)/3`) lies in `Θ₄(U₅)`. [hand + tools exact; S0B; the owner by independent code (inventory item 16)]**
*Proof:* S0B §3; `tools/fs89_s0b_heteroclinic.py`, `data/fs89/s0b/heteroclinic-check.txt`. *Proof verdict:* closes. *Rests on it:* S0B-T4,
T5; `RS₄({5})` false. *Prior art:* the heteroclinic points of algebraic `ℤ^d`-actions (`[LindSchmidt1999]`, vocabulary). *Kernel:* declined.

**FS89-S0B-T4 — A band character reading `τ₁ + λ` forward and `τ₂ + λ` backward, `τ₁ ≠ τ₂`, is not in `T + A`; hence `Θ₄(U₅) ⊄ T + A` and `RS₄({5})` is false. [hand; S0B; the owner (density, inventory item 16)]**
*Proof:* S0B §3. *Proof verdict:* closes. *Rests on it:* "one prime is not enough" (row 97). *Prior art:* `[Berend1984min]` Lemma 3.3 (one
parameter has minimal sets of positive dimension) is the phenomenon's general form; `[Berend1984]` Lemma II.6 and Prop. II.3 (and `[Berend1983]`
Lemma 3.6) build a one-parameter orbit **homoclinic** to 0 — S0B's points are **heteroclinic** between two torsion leaves inside a band set,
not found as stated. *Kernel:* declined.

**FS89-S0B-T5 — From `e₀ = q` the forward orbits form a perfect tree: continuum many non-`T + A` points, with a Cantor fibre of irrational 5-adic parts. [hand, exact prefixes; S0B]**
*Proof:* S0B §3; `tools/fs89_s0b_switching.py`, `data/fs89/s0b/switching-prefixes.txt`. *Proof verdict:* closes. *Rests on it:* the
switching family that D1-T2 kills at rank two. *Prior art:* as S0B-T4. *Kernel:* declined.

**FS89-S0B-T6 — Any second split prime `p ≠ 5` kills every rational heteroclinic of `Θ₄(R₅)`: no band character of `ℤ[i][1/5p]` restricts to one, whatever its torsion difference; `θ*` does not extend even to rows 0–2 of `R₆₅` (= S1V-8, verifier H's Theorem V4, which strengthens S0B's statement). [hand + exact arithmetic; S0B (derived, one mind, for torsion difference prime to 13); verifier H blind (general), with the rows' sweep bound S1V-7; the owner's check `v(w₅¹² − 1) = 1` at 13]**
S0B stated it at `p = 13` for torsion differences prime to 13. **Verifier H's corrections, applied:** S0B's "the character of `w̄₁₃ⁿ(q₁ − q₂)`
minus its 13-principal part", read literally, deletes the part used next — the difference is exactly `λ_{w̄ⁿD}` on `ℤ[i]` with nothing
subtracted, of `π₁₃`-level `n − v(D)`; and S0B's sweep assumed the 13-part sits at one place above 13, which V's step V3b supplies for
`|n| ≥ b₀`. *Proof:* S0B §6; `plans/FS89-S1V-verification.md` § V-A3 (V3a–V3c, Theorem V4, the divergence table); inventory item 26. *Proof verdict:*
 closes in V's form; S0B's closes with the two repairs. *Rests on it:* U4's rational half; the planner's §0.4; D's §3 mechanism
(superseded there by D1-T2). *Prior art:* none. *Kernel:* declined.

**FS89-S0B-C1 — The positive control: FS81-T3/T8 reproduced on two exact code paths (the `L`-layer and orbit models) at depth ≤ 8, three colours, 5 pieces at every depth, planted faults firing for their reasons; at four colours the two models agree exactly (29, 157, 593, 2017, 6349, 19113 pieces at depths 1–6). [tools exact; S0B; the owner reran it (inventory item 13)]**
*Proof:* S0B C1; `data/fs89/s0b/control-k3-*.txt`, `orbit-counts-k4.txt`, `layerL-words-k4.txt`. *Proof verdict:* closes. *Rests on it:* S0B-T1's
model. *Prior art:* FS81-T3, T8. *Kernel:* declined.

**FS89-S0B-L4 — The primitive band torsion characters of `ℤ[i]/N` at four colours with `5 ∤ N`, `N ≤ 130`: 145 characters of 12 orders (2, 3, 4, 7, 8, 22, 26, 31, 41, 48, 76, 79), with their margins. [tools exact, a finite list; S0B]**
*Proof:* S0B §4; `data/fs89/s0b/torsion_points.py`, `torsion-points-k4-N130.txt`. *Proof verdict:* closes for the list. *Rests on it:*
S0A-12's reading of unbounded orders (§10); inventory item 17 (the ban's edge, recorded for Kooshi). *Prior art:* the question is
`[Shparlinski2016]`'s shape (multiplicative subgroups against intervals), not this list. *Kernel:* declined.

## §3. The plan

**FS89-P-R1 — `Θ₃(R₆₅) ⊆ T₆ + A`: FS81-T3 on each layer `w₁₃ⁿ·ℤ[i][1/5]`, glued through 5-divisibility as in S0A-2 (the three-colour control of the plan's §S.4). [derived, one mind (the planner); unverified — D's D2-L1 and verifier I's VB4 each imply it (RS₃({5}) is FS81-T3)]**
*Proof:* plan §S.4 (i). *Proof verdict:* closes as an instance of D2-L1 with `R = R₅`, `N = 6`. *Rests on it:* nothing (the window it
controlled was not run). *Prior art:* FS81-T3. *Kernel:* declined.

## §4. The rank-`r` model (D; verifier H, blind; the owner)

**FS89-D0-T1 — The rank-`r` orbit model: `Θ_β(U_S)` ≅ arrays `(e_m)_{m∈ℤ^S}` in `Q_β` with `e_{m+ε_p} − w̄_p e_m ∈ π_p^{−1}ℤ[i]` for every `p ∈ S`; adjacent compatibility glues to a unique character (a distributive lattice of fractional ideals); squares complete uniquely (CRT), so an array is determined by its axes; leaves are `c_τ(m) + w̄^m d` (= S1V-9, verifier H's Theorem V5). [hand + tools exact; two derivations, independent (D; verifier H blind to D); the owner's CRT check at 200 random triples]**
*Proof:* `plans/FS89-S1D-derivation.md` §1; S1V § V-A4 (V5), `tools/fs89_s1v_array_check.py` (0.7 s, two plants); inventory items 23, 31 (P-A4
met). *Proof verdict:* closes. *Rests on it:* D1-L5, D1-L6, D5-L3, S1VB-13. *Prior art:* S0B-T1 (rank one); the arrays are Lind–Schmidt's
homoclinic language in coordinates. *Kernel:* declined.

**FS89-S1V-10 — Theorem V6, `T + A` at rank `r`, five equivalent forms: one Gaussian rational at all `2r` local components ⟺ one leaf on the coordinate axes ⟺ one leaf everywhere ⟺ one archimedean part on every half-axis; leaf discs have radius `min_{U_S} dist(τ, ∂B)`. [hand; verifier H]**
*Proof:* S1V § V-A4, Theorem V6. *Proof verdict:* closes. *Rests on it:* the orthant reading of the model. *Prior art:* S0B-T2 (rank one).
*Kernel:* declined.

## §5. From finite sets of primes to all of them (verifier H, blind; the owner)

**FS89-S1V-1 — Theorem V1: a character of `Q` whose restriction to every `R_S` (a directed exhausting family of finite nonempty `S`) is in `T + A` is in `T + A`, with one archimedean part and torsion order `ord(ψ|_{ℤ[i]})`. [hand, elementary; verifier H blind; the owner's one-step check (inventory item 24)]**
*Proof:* S1V § V-A1 (`T ∩ A = 0` by `p`-divisibility; `ℤ[i]/N ≅ R_S/NR_S` for `N` prime to `S`). *Proof verdict:* closes; the planner's
worry about orders growing with `S` cannot happen. *Rests on it:* S1V-2. *Prior art:* none. *Kernel:* declined.

**FS89-S1V-2 — U1 and its sharp form: `RS₄(S)` for every finite `S ⊇ S₀` implies RQ₄; and RQ₄ ⟺ `Θ₄(Q)|_{R_S} ⊆ T + A` for every finite `S`. [hand; verifier H]**
*Proof:* S1V § V-A1, Corollary and "a sharper form". *Proof verdict:* closes. *Rests on it:* one of three routes from rank two to RQ₄ (with
D2-L1 and VB4). *Prior art:* none. *Kernel:* declined.

**FS89-S1V-3 — The leaf formula at `Q`: `τ + λ_d ∈ Θ₄(Q)` iff `τ(G_N) ⊆ [1/4 + |d|, 3/4 − |d|]`, `G_N` the image of the local norm-one groups (joint density by the Cayley map). [hand; verifier H]**
*Proof:* S1V § V-A2 (★). *Proof verdict:* closes. *Rests on it:* S1V-5's margins. *Prior art:* S0B-T2 (at `R₅`). *Kernel:* declined.

**FS89-S1V-5 — U2, the explicit list: `Θ₄(Q) ∩ (T + A)` is 13 discs (parity, margin 1/4; four of order 3, margin 1/12; eight of order 7, margin 1/28) and 16 points (eight of order 4 and eight of order 8, margin 0): 29 torsion characters, all killed by 168, of six symmetry types — `(x+y)/2`, `(x+y)/3`, `(x+y)/4`, `(x+2y)/4`, `(2x+3y)/7`, `(3x+2y)/8` (the order-4 set has two types: verifier H's precision on the planner's U2). [hand + tools exact; verifier H blind; the owner reran the tool (inventory item 25)]**
The discs are disjoint in `Q̂` (`T ∩ A = 0`); their layer-0 shadows overlap, which is S0B's lens. *Proof:* S1V § V-A2, Theorem V3;
`tools/fs89_s1v_n0_check.py`. *Proof verdict:* closes. *Rests on it:* RQ₄'s explicit form, `Θ₄(Q) = 𝓛₄(Q)` (row 95); FS89-CL1. *Prior art:*
 none. *Kernel:* stub (a finite classification, a candidate for FS-87's list).

**FS89-S1V-6 — The rows of a band character of `R_{5,p}` over a rational heteroclinic of `R₅` are rational heteroclinics whose archimedean parts are rotated by `w̄_p^b` (the `p^b w_p^b = π_p^{2b}` trick). [hand; verifier H]**
*Proof:* S1V § V-A3, V3a. *Proof verdict:* closes. *Rests on it:* S0B-T6 in V's form. *Prior art:* none. *Kernel:* declined.

**FS89-S1V-7 — The sweep bound: a band torsion character with no `π̄_p`-part has `π_p`-level at most `v_{π_p}(w₅^o − 1)`, `o` fixed by its prime-to-`p` order. [hand; verifier H (its own place slip, `π_p` against `π̄_p`, corrected before any other file was opened; the numbers are identical)]**
*Proof:* S1V § V-A3, V3c. *Proof verdict:* closes. *Rests on it:* S0B-T6 in V's form. *Prior art:* none. *Kernel:* declined.

## §6. Rank two: minimal sets and points (D; verifier I, blind in B1, from the statements in B2)

**FS89-D1-L2 — Berend's case 2: if small differences in a closed `U_S`-invariant `M` have zero `S`-adic part, then `M` meets `T + A`; a minimal such `M` lies in `T + A` (= S1VB-8, verifier I's VB5, the minimal form). [hand; two derivations, independent (D, via `x∘(w_pⁿ − 1) = λ_v` on a recurrent point; verifier I blind, via finitely many cosets of `A` and `(u − 1)b_v = r`)]**
*Proof:* S1D §2; S1VB §B1.2 (VB5), §B2; S1VB §B3 row D1-L2. *Proof verdict:* closes; D's route is shorter and gives "meets `T + A`" for any
closed invariant set. *Rests on it:* D1-T1, D1-T2, D5-T1, S1VB-14. *Prior art:* `[Berend1984min]` Prop. 4.1, case 2, with the archimedean
plane, which nothing contracts, in place of the strictly contracted subspace; **method in print, statement not** (`[Berend1984]` Lemmas
II.14–II.15, `[Berend1983]` Lemmas 5.1–5.2: finite kernels, finite invariant sets torsion; the kernel taken modulo `A` is not in print).
*Kernel:* declined.

**FS89-D1-L3 — Case 1 at `|S| ≥ 2`: if small differences in `M` have non-zero `S`-adic parts, then `M − M = R̂_S`; the orbit closure of any non-zero pure local element is `R̂_S` (= S1VB-10). [hand; two derivations, the second from the statement (D: expand at `v` by `w_p`, rotate by `⟨i, w_q⟩`, an open subgroup of `ℤ_v^×`, then strong approximation with `v` omitted; verifier I in B2, after seeing the statement: the same expansion and rotation based at 0, density by the annihilator of the image of `K_v` in `R_S` being 0 — verifier I's disclosure: its blind B1 did not find the difference set based at 0)]**
Fails at rank one, as it must (Berend's Lemma 3.3; S0B-T3–T5). *Proof:* S1D §2; S1VB §B2 D1-L3; inventory items 27, 36. *Proof verdict:*
closes; the whole milestone rests on its step from one pure local element to density. *Rests on it:* D1-T1, D1-T2, D5-T1, S1VB-14. *Prior art:*
 `[Berend1984min]` Prop. 4.1, case 1; **method in print, statement not**: `[Berend1984]` §II.3 (Lemma II.7's pure local element; Lemmas
II.8–II.11, the `p`-adic arc from two independent elements; Prop. II.4), its principle stated in words in Prop. III.4's proof (p. 527), never
with a rotated archimedean direction present. *Kernel:* declined.

**FS89-D1-L4 — The parity line: `M ⊆ Θ₄` with `θ₂ ∈ M − M` contains a corner (`2x = θ₂`); `θ₂(u) = 1/2` on every rational unit vector, so `x(u), x(u) + ½ ∈ [1/4, 3/4]` forces `x(u) ∈ {1/4, 3/4}` (= S1VB-11). [hand, two lines; D; verifier I from the statement; the owner]**
*Proof:* S1D §2; S1VB §B2; inventory item 27. *Proof verdict:* closes. *Rests on it:* D1-T1, D1-T2, S1VB-14. *Prior art:* none (the band
replaces Furstenberg's "`M − M` is proper"); its band-free replacement is in print and applies verbatim (`[Berend1984]` Thm I.2 with Prop.
II.6; FS89-PA-B2). *Kernel:* declined.

**FS89-D1-T1 — `MS₄(S)` for every finite `S` with `|S| ≥ 2`: every `U_S`-minimal closed subset of `Θ₄(R_S)` is a finite torsion orbit or a finite union of leaf circles. [hand; D; verifier I (B2: TRUE from D1-L2 to L4, no finite lemma); B1's blind verdict GAP was its own route's]**
*Proof:* S1D §2; S1VB §B2 assembly, claim 1. *Proof verdict:* closes. *Rests on it:* S1VB-5, S1VB-14. *Prior art:* `[Berend1984min]` Thm 2.1
(MT ⟺ hyperbolic and multi-parameter) and Lemma 3.1 (isometric directions carry minimal circles, our leaves) — this is MT **modulo the
isometric direction**. **Method in print, statement not:** its skeleton is `[Berend1984]` Prop. II.7 (p. 523) and `[Berend1983]` Prop. 5.1,
whose conclusion (every minimal set finite torsion) is false for this action; not found by the plan's gate or the close's (plan §R-close.6).
*Kernel:* declined.

**FS89-S1VB-1 — Lemma E (expansion): small differences with a non-zero local part in a closed invariant set expand to a pure local difference. [hand; verifier I blind]**
*Proof:* S1VB §B1.0. *Proof verdict:* closes. *Rests on it:* VB1, VB3. *Prior art:* the expansion step of `[Berend1984min]` Prop. 4.1. *Kernel:* declined.

**FS89-S1VB-2 — Lemma SW: no ball of pure local translates lies in `Θ_k(R_S)`, `k ∈ {4, 5}` (a pure local sweep moves `θ(u)` through a coset of step `1/p ≤ 1/5`, which leaves the band). [hand; verifier I blind]**
*Proof:* S1VB §B1.0. *Proof verdict:* closes. *Rests on it:* VB1, VB3. *Prior art:* FS86-dB-Sv's sweep. *Kernel:* declined.

**FS89-S1VB-3 — Lemma JC: `⟨(w̄_{p′}, w_{p′}|_v)⟩` is dense in `S¹ × W₀`, `W₀` open in `ℤ_p^×`. [hand; verifier I blind]**
*Proof:* S1VB §B1.0. *Proof verdict:* closes. *Rests on it:* VB1. *Prior art:* standard (a rational rotation of infinite order jointly with a
`p`-adic unit). *Kernel:* declined.

**FS89-S1VB-4 — VB1: for `|S| ≥ 2`, a band point whose orbit closure meets `T + A` is in `T + A` (bands 1/4, 1/5). [hand; verifier I blind]**
Expand a small difference, turn it with the other prime's unit, sweep a full coset of step `1/p`. *Proof:* S1VB §B1.1. *Proof verdict:*
closes. *Rests on it:* S1VB-14 (replacing D's isolation lemmas); VB2. *Prior art:* none found. *Kernel:* declined.

**FS89-S1VB-5 — VB2: for `|S| ≥ 2`, `MS_k(S)` ⟺ `RS_k(S)` ⟺ every minimal subset of `Θ_k(R_S)` meets `T + A` (bands 1/4, 1/5). [hand; verifier I blind]**
*Proof:* S1VB §B1.1. *Proof verdict:* closes. *Rests on it:* the reduction of the seven claims to one (inventory item 35). *Prior art:*
none. *Kernel:* declined.

**FS89-S1VB-6 — VB3: `RS_k(S)` ⟹ `Θ_k(R_S) ∩ T` is finite, for any nonempty `S` (non-effective: no order bound). [hand; verifier I blind]**
*Proof:* S1VB §B1.1. *Proof verdict:* closes. *Rests on it:* D1-C2 and D5-C2 are not independent inputs (S1VB §B3); VB4. *Prior art:*
none. *Kernel:* declined.

**FS89-S1VB-7 — VB4: `RS_k(S)` ⟹ `RS_k(S′)` for every `S′ ⊇ S`, finite or not; in particular RQ_k. [hand; verifier I blind; S0A-2's gluing with base `R_S`, the order bound from VB3]**
*Proof:* S1VB §B1.1. *Proof verdict:* closes. *Rests on it:* S1VB-14's passage to RQ₄ and RQ₅. *Prior art:* S0A-2. *Kernel:* declined.

**FS89-S1VB-9 — VB6: a minimal set with a pure local pair and an infinite fibre group is impossible. [hand; verifier I blind]**
*Proof:* S1VB §B1.2. *Proof verdict:* closes; the case B1 could not close (a finite fibre group with a `p`-adic odometer factor under the
rotated direction) does not arise once D1-L3 is known. *Rests on it:* nothing now (B1's route, superseded). *Prior art:* none. *Kernel:* declined.

**FS89-D1-L5 — At `S = {5, 13}`: a band array within 0.13 of a corner pattern at two `m`-adjacent sites equals it there (the deviation rotates rigidly by `w̄₅` and leaves the quadrant). [hand + tools exact; D; checked independently by S1VB-13]**
*Proof:* S1D §3; `tools/fs89_s1d_corner_check.py`; S1VB §B2. *Proof verdict:* closes. *Rests on it:* D1-C1. *Prior art:* none. *Kernel:*
declined.

**FS89-D1-L6 — The corner exit lemma at `{5, 13}`, band 1/4 (`w̄₁₃ ≡ 3 (mod π₅)`, `w̄₅ ≡ 7 (mod π₁₃)`): no band array leaves a full corner plane; segment length 3 is necessary and sufficient. [hand + tools exact; two independent exact tools (D's, with three plants firing after two unreachable ones were replaced; verifier I's, 48 cases, 0 survivors, a different labelling of `𝔽₁₃`)]**
*Proof:* S1D §3; `tools/fs89_s1d_corner_check.py` → `data/fs89/s1d/corner-check.txt`; `tools/fs89_s1vb_corner_check.py` →
`data/fs89/s1vb/corner-check.txt`; inventory items 27, 29, 36. *Proof verdict:* closes. *Rests on it:* D1-C1. *Prior art:* none. *Kernel:*
stub (a finite check, a candidate for FS-87's list).

**FS89-D1-C1 — Corners are isolated in `Θ₄(R₆₅)`; a single vertical domino already isolates a corner (verifier I's strengthening of D's `3 × 2` box) (= S1VB-13, the finite lemmas D1-L5, D1-L6, D1-C1 and D5-L3 checked exactly, stated segment lengths 3 and 4 tight). [hand + tools exact; D; verifier I's own tool, six plants firing]**
*Proof:* S1D §3; S1VB §B2, §B3 row D1-C1. *Proof verdict:* closes. *Rests on it:* D's route to D1-T2 and D1-C2 (not needed on verifier I's
route, S1VB-14). *Prior art:* none. *Kernel:* stub (with D1-L6).

**FS89-D1-T2 — `RS₄({5, 13})`: `Θ₄(R₆₅) ⊆ T + A`; no heteroclinic or switching character at `{5, 13}` (U4, promoted from S0B's reading to a theorem). [hand + tools exact; D (case 1 forces a corner into the orbit closure; D1-C1 finishes); verifier I (B2, from the statements; and its own route VB1, needing no finite lemma)]**
**Verifier I's scope correction, applied:** D's §3 says "D1-T2 is about `R₆₅` exactly … what is missing [for `S ⊋ {5, 13}`] is D1-L6 in each new
direction". That understates D's own result: its D2-L1 in general form already gives `RS₄(S′)` for every `S′ ⊇ {5, 13}`, and S1VB-14 gives
every `|S| ≥ 2`. *Proof:* S1D §3; S1VB §B2 assembly, claim 2; §B3 row "scope of RS"; inventory item 37. *Proof verdict:* closes. *Rests on it:*
D2-T1. *Prior art:* as D1-T1. *Kernel:* declined.

**FS89-D1-C2 — `Θ₄(R₆₅) ∩ T` is finite, so `Θ₄(R₆₅)` is a finite union of leaf discs. [hand + tools exact; D (by corner isolation); verifier I's VB3 derives it from D1-T2 by expansion, so it is not an independent input]**
*Proof:* S1D §3; S1VB §B1.1 (VB3), §B3. *Proof verdict:* closes; the list itself is not computed. *Rests on it:* D2-T1's order bound. *Prior art:*
 none. *Kernel:* declined.

**FS89-S1VB-14 — `RS₄(S)` and `MS₄(S)` for every finite `S` with `|S| ≥ 2`; `RS₅(S)` and `MS₅(S)` for every `S ∋ 5` with `|S| ≥ 2`; with VB4, RQ₄ and RQ₅; no finite computation. [hand; verifier I's assembly of D's D1-L2 to L4 and D5-L1 with its own VB1 and VB4 (the lemmas each derived twice, as their entries say)]**
*Proof:* S1VB §B2 "The assembly" and its consequence; §B3. *Proof verdict:* closes. *Rests on it:* rows 95–96's scope "every `|S| ≥ 2`".
*Prior art:* **not in `[Berend1983]`, `[Berend1984]` or `[Berend1984min]`**: VB1 has no analogue there (Berend's point step, the end of
`[Berend1984]` Thm II.1's proof, needs no continuous part), though Lemma JC's joint closure is the device of Lemma II.10's proof; the band
sweep SW is ours. Not found by the close's gate (plan §R-close.6). *Kernel:* declined.

## §7. All primes (D; verifier I)

**FS89-D2-L1 — Bounded-order layering: `Θ_β(R) ⊆ T_N + A` for a `p`-divisible `R = ℤ[U_R] ⊆ Q` implies `Θ_β(R′) ⊆ T_N + A` for every `R ⊆ R′ ⊆ Q`. [hand; D (the archimedean parts aligned on the ideals `R ∩ uR`); verifier I from the statement (S0A-2's 5-adic real lift with base `R`)]**
*Proof:* S1D §4; S1VB §B2 D2-L1. *Proof verdict:* closes. *Rests on it:* D2-T1, D5-T2, P-R1. *Prior art:* S0A-2 (base `Q`); G74's gluing.
*Kernel:* declined.

**FS89-D2-T1 — RQ₄: `Θ₄(ℤ[i][1/p : p ≡ 1 (4)]) ⊆ T + A`; with S1V-5, `Θ₄(Q)` is exactly the 13 discs and 16 points of U2, an explicit compact set. [hand + tools exact; D (D2-L1 with `R = R₆₅`, `N` from D1-C2); verifier I (every lemma re-derived, from the statements; a second assembly by VB1 and VB4 needing no finite lemma); inventory item 36]**
*Proof:* S1D §4; S1VB §B2 assembly, claim 4. *Proof verdict:* closes. *Rests on it:* FS89-CL2, CL3, CL4; row 95. *Prior art:* **not in
`[Berend1983]`, `[Berend1984]` or `[Berend1984min]`, all read in full; the method is Berend's** (no band and no `T + A` in print; the
finite-to-infinite-type passage is a method analogue of `[Berend1984]` Ch. IV, Lemma IV.2 and Prop. IV.1, while the archimedean alignment
on `R ∩ uR` is not in print); not found by the plan's gate (26 queries) or the close's (plan §R-close.6). *Kernel:* declined (no Lean this milestone; a kernel route would need the solenoid's dual and strong approximation, far from Mathlib).

## §8. Five colours (D; verifier I)

**FS89-D5-L1 — At band 1/5 with `5 ∈ S`: `θ₂ ∈ M − M` implies `M` meets a corner leaf disc of radius 1/20 (`x(u) ∈ [1/5, 3/10] ∪ [7/10, 4/5]`, so `2x ∈ Θ_{2/5}(R_S)`). [hand; two routes: D (FS81-T3 lifted through D2-L1); verifier I from the statement, by S1VB-12 with no FS-81 input]**
*Proof:* S1D §5; S1VB §B2 D5-L1; inventory item 28 (the owner's check). *Proof verdict:* closes. *Rests on it:* D5-T1, S1VB-14's five-colour
half. *Prior art:* FS81-T3. *Kernel:* declined.

**FS89-S1VB-12 — Narrow-band rigidity: for `5 ∈ S`, a character of `R_S` with `φ(U_S) ⊆ [−1/10, 1/10]` is `λ_e` with `|e| ≤ 1/10` (5-steps are exact since `0.283 < 1/√5`; the other primes' defects are killed by `w̄₅^m`). [hand; verifier I]**
*Proof:* S1VB §B2 D5-L1. *Proof verdict:* closes. *Rests on it:* D5-L1 by an elementary route. *Prior art:* FS81-T3 (the three-colour
parity disc) is the analogue. *Kernel:* declined.

**FS89-D5-L2 — Near a corner leaf a band array is on the leaf (digit spacing); its hypothesis `|d| ≤ 1/20` is not needed (verifier I). [hand; D; verifier I from the statement]**
*Proof:* S1D §5; S1VB §B2. *Proof verdict:* closes. *Rests on it:* D5-T1 on D's route. *Prior art:* none. *Kernel:* declined.

**FS89-D5-L3 — The corner-leaf exit lemma at `{5, 13}`, band 1/5, displacement ≤ 0.06, on all 128 exit lines; segment length 4 tight (checked independently by S1VB-13). [hand + tools exact; D's tool (plants: displacement 3/10 leaves 64 survivors, `w̄₁₃ → 1` leaves 8); verifier I's tool, a sound over-approximation of the continuous displacement]**
*Proof:* S1D §5; `tools/fs89_s1d_band5_check.py` → `data/fs89/s1d/band5-check.txt`; S1VB §B2 D5-L3. *Proof verdict:* closes. *Rests on it:*
 D5-T1 on D's route. *Prior art:* none. *Kernel:* stub (with D1-L6).

**FS89-D5-T1 — `RS₅({5, 13})`: `Θ₅(R₆₅) ⊆ T + A`. [hand + tools exact; D; verifier I (B2 from the statements; and by VB2 with D5-L1)]**
*Proof:* S1D §5; S1VB §B2 assembly, claim 5. *Proof verdict:* closes. *Rests on it:* D5-T2. *Prior art:* as D1-T1. *Kernel:* declined.

**FS89-D5-C2 — `Θ₅(R₆₅) ∩ T` is finite. [hand + tools exact; D; verifier I's VB3 at `k = 5` (not an independent input)]**
*Proof:* S1D §5; S1VB §B2 claim 6. *Proof verdict:* closes. *Rests on it:* D5-T2's order bound. *Prior art:* none. *Kernel:* declined.

**FS89-D5-T2 — RQ₅: `Θ₅(ℤ[i][1/p : p ≡ 1 (4)]) ⊆ T + A`; it implies RQ₄ (`Θ₄ ⊆ Θ₅`), by a route sharing D1-L2 and D1-L3 (not independent). [hand + tools exact; D; verifier I (every lemma re-derived from the statements; a second assembly via VB1, VB4)]**
*Proof:* S1D §5; S1VB §B2 claim 7. *Proof verdict:* closes. *Rests on it:* FS89-CL2, CL5; row 95. *Prior art:* as D2-T1. *Kernel:* declined.

## §9. The close (the close planner)

**FS89-CL1 — S0B's 29 depth-one cells and verifier H's 29 torsion characters are different lists with equal counts: parity sits in the 12-gon, order 3 in the four hexagons, order 7 inside the eight quadrilaterals, order 4 at eight of the 16 point cells, and order 8 at a vertex of each quadrilateral; the other eight point cells carry no torsion character of `Q` (order 20 on `L = (1/5)ℤ[i]`) and restrict to `ℤ[i]` as the four corners `(1+i)/4 + ½ℤ[i]` of D1-L4, twice each. [tools exact; the close planner, one mind]**
S0B's "eight point cells whose order on `L` is divisible by 5 are not torsion" and verifier H's "eight order-8 points" are therefore
different eights, both correct: at depth one the order-8 characters sit on the boundary of the order-7 quadrilaterals, and the corners
S0B saw at depth one are the very points D's proof isolates. *Proof:* `tools/fs89_close_cell_reconcile.py` → `data/fs89/close/cell-reconcile.txt`
(119 fixed points, exact; the plant, order 9 for order 8, goes red); inventory item 25. *Proof verdict:* closes. *Rests on it:* nothing; it
retires the owner's reconciliation note. *Prior art:* none. *Kernel:* declined.

> **Correction owed (2026-09-25 crunch):** see `plans/FS91-S0V2-SWm-second-reading.md` §3.4 (J03a-9) and `plans/FS91-S1D-character.md` §4.4 (J07-14); carried in `plans/FS91-close-inventory.md` rows 61, 69, 78. Not applied here; the close rewrites this entry.

**FS89-CL2 — For every subfield `F ⊆ ℝ`: `Θ₄(R_F) ⊆ T₁₆₈ + A` and `Θ₅(R_F) ⊆ T + A`; every four- or five-colour character colouring of any real field's plane is a torsion character plus an archimedean one. [hand; a composition: S0A-10 and S0A-3 (verifier G; N₀ twice) with D2-T1 and D5-T2 — no new step]**
*Proof:* this entry. *Proof verdict:* closes at the composed grades. *Rests on it:* CL3–CL5; row 95's field clause. *Prior art:* as D2-T1.
*Kernel:* declined.

*Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SA1-audit.md` § 3.1; `plans/FS129-close-inventory.md` item 108):* the correction banner above this entry covers FS89-S0A-2 and FS89-S0A-10 as well: they state the field clause with the same Notation's `A`, and are false as written for the same reason (ℚ(√3), band 1/4). The repair is the one line filed under the Notation (`A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`), and it makes all three true. Nothing downstream inherits the falsity: CL3–CL5 read both real places (`plans/FS91-S1D-character.md` § 4.4). For the Lean backlog: S0A-2's kernel line names it a candidate for FS-87's list; formalized from the Notation as written it is unprovable (inventory item 109).

**FS89-CL3 — HD1 for ℚ(√59), ℚ(√83), ℚ(√131): every four-colour band character of the plane is a dyadic torsion (pullback) character; so no character colouring of these planes is non-periodic. `F(R)` stays undecided, and non-character colourings are untouched. [hand; a composition: S0A-6 with D2-T1, at FS86-dB-Theta's grade (two derivations, given V3: FS-66's certificates at 11, and at 19 for 83 and 131, and Zhang2012 Thm 1.8(i))]**
By FS86-dB-HDcert, HD1 now has a finite exact certificate on some finitely generated `Λ₁ ∋ 1` (existence only; no size bound, and `Λ₅₁₀` is
not known to carry it). *Proof:* this entry. *Proof verdict:* closes at the composed grade. *Rests on it:* row 96; FS-90 (a) re-aimed. *Prior art:*
 none. *Kernel:* declined.

**FS89-CL4 — C-47 unconditional: `Θ₄(R_{ℚ(√47)}) = ∅`; no character four-colouring `x ↦ ⌊4θ(x)⌋` of ℚ(√47)'s plane exists. `χ(ℚ(√47)²) = 5` is not claimed. [hand; a composition: S0A-8 (given Lemma R and Weil) with D2-T1]**
*Proof:* this entry. *Proof verdict:* closes at the composed grade. *Rests on it:* row 96; FS-83 at `k = 4`, FS-84. *Prior art:* none.
*Kernel:* declined.

**FS89-CL5 — C-167 unconditional: `Θ₅(R_{ℚ(√167)}) = ∅`; no character five-colouring of ℚ(√167)'s plane exists. `χ(ℚ(√167)²) ≥ 6` is not claimed. [hand + cert; a composition: S0A-9 (FS-53's and FS-66's certificates) with D5-T2]**
*Proof:* this entry. *Proof verdict:* closes at the composed grade. *Rests on it:* row 96; FS-83 at `k = 5`, FS-59, FS-64's windowless case.
*Prior art:* none. *Kernel:* declined.

## §9a. The prior-art reader (`plans/FS89-PA-berend1984.md`, "Theorems this phase proved")

**FS89-PA-B1 — `(R̂_S, U_S)` in Berend's coordinates: `R̂_S = Ω_a²` (`a = ∏_{p∈S} p`) and `Q̂ = Ω_P²` (his Ch. IV); the action meets his irreducibility condition (1) at every `S ≠ ∅`, his multi-parameter condition (3) exactly when `|S| ≥ 2`, and his hyperbolicity (2) at every finite place but not at `∞`; it is an ℱ-flow (`[Berend1984]` Prop. II.6: `w_p` ergodic, every determinant 1) at every finite `S`. [hand, a hypothesis check; the reader, one mind]**
*Proof:* the reader's §2 table. *Proof verdict:* closes. *Rests on it:* PA-B2; the prior-art verdicts (D1-L3's hypothesis `|S| ≥ 2` *is*
Berend's condition (3)). *Prior art:* the frame is `[Berend1984]`'s. *Kernel:* declined.

**FS89-PA-B2 — Band-free minimal sets: for every finite `S` with `|S| ≥ 2`, every `U_S`-minimal closed `M ⊊ R̂_S` lies in `T + A` (case 2 by D1-L2; case 1 gives `M − M = R̂_S` by D1-L3, hence `M = R̂_S` by `[Berend1984]` Thm I.2 with Prop. II.6 — Furstenberg's Prop. IV.1 in held form). So `MS_k(S)` holds at every band `k`, and D1-L4 and D5-L1 are not needed for it. [hand; the reader, one mind, unverified; resting on D1-L2 and D1-L3, each derived twice]**
*Proof:* the reader's §5 (a)–(b). *Proof verdict:* closes as a composition; the one new input (Thm I.2 with Prop. II.6) is in print and its
hypotheses are PA-B1's. *Rests on it:* the stub FS-91 (band rigidity at six colours needs only the point step). *Prior art:* `[Berend1984]`
Thm I.2; `[Berend1983]` p. 530 quotes Furstenberg's Prop. IV.1 for commutative toral semigroups. *Kernel:* declined.

## §10. Conjectures and readings this milestone stated and did not prove (the close's sweep)

| statement | who | status at the close | where it goes |
|---|---|---|---|
| U5: at one prime the band torsion orders are unbounded (at primes dividing `Φ_k(w₅)`) | verifier G's reading; S0B's (two minds, independent) | reading; S0B-L4 is a finite list (12 orders below 130); moot for `Q` (N₀) | stub FS-91's side question |
| U3: `RS₄({p})` fails at every single prime `p ≡ 1 (4)` | the planner | open; proved at `p = 5` only | stub FS-91 |
| `MS₄({5})` false (a uniformly recurrent switching family, Berend's Lemma 3.3 shape) | D (0.75) | open; D1-L3 fails at rank one | stub FS-91 |
| U4: 13 kills the switching family | S0B's reading | **proved** (D1-T2) | done |
| U1's hypothesis "may fail at every `S`" | verifier H's aside | **false**: S1VB-14 proves it at every `|S| ≥ 2` | done |
| the band-1/6 exit lemma: are the corner leaves (radius 1/12) and the order-6 points over `X₃` isolated at band 1/6? | D (§5 "Where it stops") | unchecked | stub FS-91 |
| **the close planner's reading:** the route of S1VB-14 needs no isolation lemma, and its band restriction sits only in Lemma SW (a sweep of step `1/p ≤ 1/5` against the excluded interval of width `2/k`, which it meets for every `k ≤ 9`) and in the parity line (`x, x + ½ ∈ B_k` ⟹ `2x ∈ B_{k/2}`, i.e. `Θ₃` at `k = 6`, `Θ₄` at `k = 8`, both rigid). So `RS₆(S)` and `RS₈(S)` at `|S| ≥ 2` may follow by the same assembly | the close planner, one mind, **unchecked**: VB1's and SW's proofs were not re-read at band 1/6 | reading; the first thing FS-91 checks. **The Berend reader reached the same observation from Lemma SW (PA-B3: `RS_k(S)` for every `|S| ≥ 2` and `k < 2·min S`, so `RQ_k` for every `k ≤ 9` via `{5, 13}`, and `RS₅(S)` without `5 ∈ S`, with PA-B2 in place of D1-L4/D5-L1)** — the same observation twice, not independent evidence; unverified | stub FS-91, as its first question for a verifier |
| the four-colour band set of `ℤ[U₅]` has entropy at most about `log 1.7` per layer, fibre dimension at most about 0.33 | S0B §6 | measured bound, not a value | declined (no consumer) |
| G76's reading "the obstruction is the real place" | FS-86 | **for characters, answered**: at rank ≥ 2 the real place is not an obstruction modulo `A` | G76 rewritten |
