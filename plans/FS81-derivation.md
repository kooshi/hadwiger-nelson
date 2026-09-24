# FS-81 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Opened 2026-09-24 by the stage-C verifier (de Bruijn, Opus 5.5) at the owner's routing, with the statements of record from stage C.
The close planner adds the other phases' entries (phase 0, stage D) and the `LEDGER.md` § B lines. Grades are `CLAUDE.md` §
Notation's. A proof held in a record is not repeated here. FS-81 added no Lean, so nothing below is kernel-checked, and each entry
carries its kernel decision.*

**Who found what.**
- The **planner**: §F's statements and the proof sketch `plans/FS81-F-sketch.md`.
- **Poros (plan)**: the compactness indexing, and §F.5.
- The **modeling agent**: the proposals P-F1–P-F3 (plan §B.1.8).
- The **verifier**: the blind re-derivation `plans/FS81-C-verification.md` §1, the comparison §2, the scope §3 and the finite threshold
  §4.
- The **owner**: T40's grid check at 1/600, and the relation arithmetic checked at all 41 d below 500.

**Grade of the chain.**
- **T2–T6** each have **two independent derivations**: the planner's, with Poros's check, and the verifier's, written blind and
  compared line by line in the verification record §2 (14 divergences of route, none of truth). That is the FS-73 standard
  [hand, two independent derivations].
- **T1** is a one-line lemma, stated by the modeling agent and checked by the verifier.
- **T7 and T8 are the verifier's alone: one mind**, checked by exact computation where noted. At the close the close planner re-read
  T7's chain step by step (its *Proof verdict*); T8 has had no second reading of its norm bound, so a ledger row cites it at
  [hand + tools exact, one mind].
- **T9–T25** (phase 0 and stage D) were added at the close by the close planner (de Bruijn, Opus 5.5) from the phase records'
  "Theorems this phase proved"; each names its prover. The readings and open questions the milestone stated are in §5.

## §1. Stage C — the field-level three-colour theorem

**T1 — The pull-back lemma (P-F1). [hand; the modeling agent; checked by the verifier]**
- *Statement.* For an additive map `φ : A → B` with `φ(S_A) ⊆ S_B`, `θ ↦ θ∘φ` maps `Θ(B, S_B)` into `Θ(A, S_A)`.
- *Instances.* L3 (`φ = x ↦ bx : (R₅, U₅) → (R_F, U_F)`); L1's restriction maps (the inclusions `(⟨S⟩, S) → (R_F, U_F)`); FS73-T11's
  "a sub-configuration's EMPTY proves the field".
- *Proof:* one line (verification record §2.1).
- *Proof verdict:* closes (one line, checked by the verifier).
- *Rests on it:* T2, T4.
- *Prior art:* standard functoriality; not claimed.
- *Kernel:* **kernel**, with FS-75 (a two-line lemma).

**T2 — L1 as an inverse limit (P-F2), with the finite form's band map written out. [hand; the planner and Poros (FIP form, sketch L1), the verifier (both forms, record §1.1 and §2.1)]**
- *Statement.* For every subfield `F ⊆ ℝ`, `Θ₃(F) = lim_S Θ₃(⟨S⟩, S)` over the directed set of finite symmetric `S ⊆ U_F`. So
  `χ(F²) ≤ 3 ⟹ Θ₃(F) ≠ ∅` (L1), with no finite generation of `ℤ[U_F]`.
- *The finite form used* is FS73-T22 ⟹ applied to `Λ = ⟨S⟩` (generation holds by definition). The verifier re-derived it with the
  explicit band map `t = 𝟙/2 − a/6`, which needs the winding's parity `W(ρ) ≡ Σρ (mod 2)`.
- *Proof:* the verification record §1.1 (the FIP form in `Hom(R_F, T)`) and §2.1 (the inverse-limit form); `plans/FS81-F-sketch.md` L1.
- *Proof verdict:* closes: two independent derivations (the planner's with Poros's check; the verifier's, blind), compared line by line with no divergence of truth; it rests on FS73-T22 ⟹ (hand, three derivations at FS-73, never kernel).
- *Rests on it:* T5, T6, T7.
- *Prior art:* the compactness is de Bruijn–Erdős's in character form; T22 is FS-73's.
- *Kernel:* **stub (FS-75)**. The inverse-limit form is the one to state there; it needs T22 ⟹ in the kernel first.

**T3 — L2 = C1(5): the rotation set of the rational pattern. [hand + tools exact; the planner (sketch L2), the verifier (record §1.2)]**
- *Statement.* `Θ(U₅) = {θ ∈ Hom(ℤ[i][1/5], ℝ/ℤ) : θ(iᵏwᵐ) ∈ [1/3, 2/3]} = {θ₂ + λ_e : |e| ≤ 1/6} ∪ X₃`, with `X₃` the four
  characters through `ℤ[i]/3` nonzero on `1` and `i`.
- *Computational input:* FS73-T40's cell list `Θ_R = c0 + (D0 ∪ F4) + 5ℤ²`, reproduced on a second code path
  (`tools/fs81_verify_thetaR.py`, half-plane clipping), with three planted faults that fire.
- *Two routes for the order-3 chain:*
  - the sketch's: `3θ = 0` on every layer;
  - the verifier's: uniqueness of the F4 representative modulo `π̄ℤ[i]` and `πℤ[i]`.
- *The infinite steps, named:* the layers `wᵐ`, `m ∈ ℤ`, reach every denominator only together
  (`Σ_{|m|≤M} wᵐL = 5^{−(M+1)}ℤ[i]`); the disc `|e| ≤ 1/6` needs the whole orbit `{wᵐ}`.
- *Proof:* the verification record §1.2; the sketch L2.
- *Proof verdict:* closes: two derivations of the chain by different routes, and T40's cell list reproduced on a second code path whose three planted faults fire.
- *Rests on it:* T4–T8.
- *Prior art:* ours (FS73-T40's list is ours).
- *Kernel:* **stub (FS-75)**. The cell list is a finite exact computation; the chain argument is short.

**T4 — L3 and the layer torsion character; L4′: `1/3 ∈ ℤ[U_F]` and `Θ₃(F) ≠ ∅` make `F²` bipartite. [hand; the verifier's route (record §1.3–§1.4); the planner's per-layer case analysis (sketch L3–L4) is the second derivation]**
- *Statement.*
  - For `θ ∈ Θ₃(F)`, each layer `θ(b·)|_{R₅}` lies in `Θ(U₅)` (L3).
  - `τ(x) = lim_k θ(25^{−k}x)` is a character `R_F → (1/6)ℤ/ℤ` taking the value 1/2 on parity-type units and 1/3 or 2/3 on order-3
    ones.
  - If `1/3 ∈ ℤ[U_F]`, then `τ = 1/2` on `U_F`, a bipartition.
- *L4 as stated follows:* a relation `1 = Σ c_j u_j` with `3 | c_j` and `Σ c_j` even gives `1/3 ∈ ℤ[U_F]` and contradicts `τ(1) = 1/2`.
  The two conditions together are equivalent to "`1/3 ∈ ℤ[U_F]` and `F²` not bipartite".
- *The field-level step, named:* `λ_e` is never torsion on `R₅`, because every layer contains `5^{−k}` for every `k`.
- *Proof:* the verification record §1.3–§1.4; the sketch L3–L4.
- *Proof verdict:* closes: two derivations by different routes (the sketch's per-layer case analysis; the verifier's single limit τ).
- *Rests on it:* T5, T6.
- *Prior art:* the obstruction "`1/k ∈ C₀` ⟹ no **additive** k-colouring" is `[Fischer1990]` §1 and Thm 10(ii). **The passage from
  additive to all 3-colourings is ours, unclaimed as new while `[Johnson2000]` and `[Johnson2006]` are unread** (plan §PA.4).
- *Kernel:* **stub (FS-75)**.

**T5 — The field-free form (P-F3), sharpest verified shape, with F-T4 as its corollary. [hand; the modeling agent (the form), the verifier (the audit and the five-layer sharpening, record §2.1); two derivations of the chain]**
- *Statement.* For every multiplicatively closed `U` in the unit circle with `U₅ ⊆ U`, `1/3 ∈ ℤ[U]` and an odd closed walk in
  `Cay(ℤ[U], U)`, that Cayley graph, and hence the unit-distance graph on `ℤ[U]`, is not 3-colourable.
- *Sharpest instance:* for squarefree `d ≡ 11 (mod 12)` the **listed five layers `{vᵏ : |k| ≤ 2}·U₅`**, `v = ((2n−1) + i√d)/(2n)`,
  already have empty `Θ₃`. The relation `1 = 2n − nv − nv̄` supplies both hypotheses.
- *Corollary (F-T4):*
  - every `F ⊆ ℝ` with `1/3 ∈ ℤ[U_F]` and `F²` not bipartite has `χ(F²) ≥ 4`;
  - in particular **`χ(ℚ(√d)²) ≥ 4` for every squarefree `d ≡ 11 (mod 12)`**, which is T4 (G61) for the whole family;
  - **`χ(ℚ(√2, √7)²) ≥ 4`**, an instance with no √3 and no four-chromatic quadratic subfield: `1/3 = 1 + u + ū` with `u = (−1 + 2√2 i)/3`, and L4's relation is
    `1 = 12 + 3u + 3ū − 6v₇ − 6v̄₇`.
- *Proof:* the verification record §1.5 and §2.1; the sketch F-T4.
- *Proof verdict:* closes: two derivations of the chain; the five-layer sharpening and the ℚ(√2, √7) relation are the verifier's (one mind), the relation re-checked by the owner (sum 1, coefficients ≡ 0 mod 3, coefficient sum 6).
- *Rests on it:* the census's 25 open fields (all ≥ 4), FS-59's premise, the conjecture's four-colour clause for quadratic fields.
- *Prior art:* the vector `v` and `1/3 ∈ C₀` at `N ≡ −1 (mod 24)` are `[Fischer1990]` Thm 10(ii) and Ex. 4. At `N ≡ 11 (mod 24)` the same
  vector gives `1/3`, since `3 | (N+1)/2`. The type-M family is `[Polymath16wikiMain]`'s. The theorem is **unclaimed as new while the
  Johnson papers are unread**.
- *Kernel:* **stub (FS-75, re-aimed)**. The five-layer statement parametric in d is the target. Per-d certificates exist at `K_B(d)`
  (T8) as the fallback.

**T6 — §F.5: at `d ≡ 3, 7 (mod 12)` every slope is additive mod 3, so `Θ₃(ℚ(√d))` is exactly the set of additive 3-colourings. [hand; Poros (the extension), the planner (both mixed cases), the verifier (blind, record §1.6)]**
- *Statement.* For squarefree `d ≡ 3 (mod 4)` with `3 ∤ n`, every point of `Θ₃(ℚ(√d))` has only order-3 layers and
  `θ(ℤ[U]) ⊆ (1/3)ℤ/ℤ`. With T5, this classifies `Θ₃` for every real quadratic `d ≡ 3 (mod 4)`.
- *Negative control:* `[Fischer1990]` Thm 9's colourings are such points. They are local at one prime above 3, and nonzero on 84–372
  sampled unit vectors per field at eight `N` (record §3.2).
- Whether every additive 3-colouring is Fischer's up to symmetry depends on `ℤ[U]/3ℤ[U]`, and is **not settled**.
- *Proof:* the verification record §1.6; the sketch §F.5.
- *Proof verdict:* closes: three minds (Poros stated it, the planner re-derived both mixed cases, the verifier derived it blind), and Fischer's colourings pass as the negative control.
- *Rests on it:* the classification of three-colourings of real quadratic planes (record §3.3).
- *Prior art:* the colourings are Fischer's (1990); that they are all of them is ours, subject to the same Johnson caveat.
- *Kernel:* **declined**. It is not on a kernel consumer's path; FS-75 may add it later.

**T7 — The contrapositive: for every real number field `F`, `χ(F²) = 3` ⟹ some prime of `F` above 3 has odd residue degree. [derived; the verifier (record §3.3), from T5 and ASTRA-T2]**
- *Consequences.*
  - Consistent with ASTRA-T3, and weaker than ASTRA-T4's `𝔽₃` criterion for √3-fields, but it holds without √3.
  - Residue degree 1 gives `χ ≤ 3` (an additive colouring through `𝔽₉`).
  - For real quadratic fields three-colourability is thereby decided exactly.
- *The residual case left open:* every prime above 3 of odd residue degree has degree ≥ 3, e.g. `ℚ(α, √7)` with `α³ = α + 1`. No
  additive colouring passes through such a prime (Hilbert 90 and `χ(Γ₂₇) ≥ 6`). **Stub candidate.**
- *Proof:* the verification record §3.3.
- *Proof verdict:* closes: the verifier's derivation, re-read step by step by the close planner (L1 and non-bipartiteness; F-T4's contrapositive; prime inversion; `F(i)/F` unramified above 3, so a conjugation-stable prime is inert, so its residue field lacks `√−1`, so `f` is odd). One derivation plus one checked reading.
- *Rests on it:* the classification of three-colourable real quadratic planes (with T5, T6 and `[Fischer1990]` Thms 8–9); the residual-case stub (`plans/STUB-three-colours-residue-degree-three.md`).
- *Prior art:* prime inversion is ASTRA-T2 (`[Fischer1990b]` Thm 1 for multiquadratic fields).
- *Kernel:* **declined**. It is derived from T5 and ASTRA-T2, whose kernel home is FS-47.

## §2. Stage C — the finite level (C4)

**T8 — The finite threshold for the listed configurations. [hand + tools exact; the verifier (record §4.0–§4.3)]**
- *(a) The rational layer at every level.* `Θ_K = c_K + (D_K ∪ F_K) + 5^Kℤ²`, with `D_K = ⋂_{|m|≤K−1} wᵐD0`. This proves P0.1's reading
  for all K; the polygons match P0.1 vertex for vertex at K = 1..6.
- *(b) Configuration A.* `A = {1, v, v̄}·U^(5^K)`, listed. It is NONEMPTY at every K for `d ≡ 11 (mod 24)`, by the field-level point
  `(θ₂, θ₂, χ)` on `R₅ + vR₅ + v̄R₅`, whose relations are exactly `R₅·(2n−1, −n, −n)`. At `d ≡ 23 (mod 24)` it is EMPTY at the field
  level, hence at finite K.
- *(c) Configuration B, and A at `d ≡ 23 (mod 24)`.*
  - EMPTY whenever `5^K > √2·r_K·d` (a norm bound on the torsion residual, after Gauss's lemma).
  - NONEMPTY whenever `5^K ≤ √2·h_K·d` (the alternating point `g_k = (−1)^k c_K/d`).
  - Hence `K_B(d) = min{K : d < 21·5^{K−1}}` exactly for `d < 65,625`, and as an upper bound for every d.
  - In the milestone's variable: `5^K ≳ (0.94–0.99)·n`. The planner's `5^K ≳ 2n` is implied, and twice too large.
- *Checked:*
  - against every phase-0 A/B row: 7 listed rows agree, and the saturated rows lie outside the statement;
  - against phase 0's tree at d = 11 (B EMPTY at K = 1), and at 11, 23, 47, 59 (NONEMPTY);
  - against six explicit certificates lifted by V2's `theta_from_x` and passed by `tools/fs81_theta_check.py`, with the threshold's
    edge at 491/527 (K = 3) and 2603 (K = 4) behaving as predicted, and a planted point refused.
- *Proof:* the verification record §4; `tools/fs81_verify_c4.py`.
- *Proof verdict:* closes: one mind (the verifier), checked by exact computation against every phase-0 row it covers, six explicit points and a planted point.
- *Rests on it:* P0.3's expectations (every census field is EMPTY in B at `K_B(d) ≤ 3`); the kernel's per-d fallback for T5.
- *Prior art:* ours.
- *Kernel:* **stub (FS-75)**. As a parametric certificate family it is the finite shadow of T5.
- *Reading, not proved:* that configuration A's nonemptiness at `d ≡ 11 (mod 24)` explains the census's skew (2 of 20 certified at
  `d ≡ 3 (mod 8)` against 13 of 20 at `d ≡ 7 (mod 8)`). The census used saturated lattices of its own, not configuration A. The
  killing test: a census-style search (lattice balls at the census's depth) that lands the `d ≡ 11 (mod 24)` fields at the same rate
  as the `d ≡ 23 (mod 24)` ones.

## §3. Phase 0 — explicit finite certificates over the census (the phase-0 implementer)

*Source: `data/fs81/records/phase-P0.md` §9 (P0-T1–P0-T11), with the per-object table `phase-P0-objects.md` and the acceptance pass §11
(411 certificates re-checked, 0 failures). "Structural checker" = `tools/fs81_struct_check.py`; "frozen" = `tools/fs73v2_check.py`;
"new checker" = `tools/fs81_theta_check.py`; the owner planted the structural and new checkers (inventory items 36, 73).*

**T9 — P0-T1: χ(ℚ(√d)²) ≥ 4 at each of the 25 open census d, by a structural certificate on the listed five-layer configuration `B = {vᵏ : |k| ≤ 2}·U^(5^K_B(d))`. [cert + hand; the phase-0 implementer (the certificate form R1–R4, following T8's mechanism); the verifier (T8's threshold, which aimed it); the owner (R2 and R4 re-derived, the checker planted)]**
- *Statement.* At d = 35, 83, 107, 131, 155, 179, 203, 215, 227, 251, 263, 287, 299, 323, 347, 371, 383, 395, 407, 419, 443, 455, 467, 479,
  491, `Θ₃(B) = ∅` at `K_B(d)` (2 at 35 and 83, 3 elsewhere); 50 or 70 unit-vector pairs.
- *Proof:* `data/fs81/phase0/struct/d<d>-B-K<K>.json`, structural checker PASS (about a second per field); the hand steps are the
  ℚ-linear extension, R2, R4 (T12) and FS73-T22 ⟹. Record §6.
- *Proof verdict:* closes at [cert + hand]; **independent of T2–T5** (it uses T22 ⟹ and the rational layer, not L1 or L4).
- *Rests on it:* LEDGER row 83 (the census completed); FS-75's per-d fallback.
- *Prior art:* the vector `v` is `[Fischer1990]`'s (Thm 10(ii), Ex. 4); the certificates are ours.
- *Kernel:* **stub (FS-75)**, as the fallback to T5's parametric statement.

**T10 — P0-T2: the same uniform witness at the 15 census fields certified earlier (11, 23, 47, 59, 71, 95, 119, 143, 167, 191, 239, 311, 335, 359, 431). [cert + hand; the phase-0 implementer]**
- *Proof:* as T9. *Proof verdict:* closes; a second, uniform witness for each field. *Rests on it:* row 83. *Prior art:* the fields'
  first certificates are FS-58's, FS-61's and FS-73's (rows 72–74, 79). *Kernel:* stub (FS-75), with T9.

**T11 — P0-T3: at 35, 131, 155, 179, 251, 287, 395, 407, 467, 479, 491, χ(ℚ(√d)²) ≥ 4 also by relation-tree certificates on saturated lattices (D ≤ 5,000) through the frozen checker. [cert + hand (T22 ⟹); the phase-0 implementer; the owner re-ran the frozen checker on ℚ(√131)'s]**
- *Proof:* `data/fs81/phase0/certs/*-sat.json.gz`, frozen PASS; record §7. *Proof verdict:* closes; independent of the structural route
  and of T5, and read by the checker frozen at FS-73. *Rests on it:* row 83 (11 of the 25 open fields certified twice). *Prior art:*
  FS-73's V2 relation tree. *Kernel:* declined (the structural route is the kernel's path).

**T12 — P0-T4: the reduction for B — `θ ∈ Θ₃` gives a solvable δ-system `L_k(δ) = nΔ²δ_k + δ_k ∈ 5^K(ℤ + ½)²`, `δ_k ∈ P ∪ F`. [hand; the phase-0 implementer; re-derived by the owner]**
- *Statement.* R2: `μ_k = (θ(vᵏ), θ(ivᵏ))` satisfies `nΔ²μ_k + μ_k = 0`, from `v + v̄ = 2 − 1/n`; R4: the coefficients `n, −(2n−1), n`
  sum to 1, so the base point leaves `c + 5^Kℤ²` and `L_k` lands in `5^K(ℤ + ½)²`.
- *Proof:* `tools/fs81_struct_check.py` docstring R2, R4; record §6. *Proof verdict:* closes; two minds (the implementer; the owner's
  re-derivation). *Rests on it:* T9, T10. *Prior art:* ours. *Kernel:* stub (FS-75).

**T13 — P0-T5: the rational layer at finite depth — `Θ_K ⊆ c_K + (P_K ∪ F_K) + 5^Kℤ²` at K ≤ 3 by the checker's induction, and equality with one polygon (4(2K+1) vertices, area → π/36) and four order-3 points per period at K ≤ 6 by exact lifting. [tools exact; the phase-0 implementer]**
- *Proof:* `tools/fs81_struct_check.py` R3; `tools/fs81_rational.py`; record §3. *Proof verdict:* closes at its K; the verifier proved
  every K (T8(a)), matching vertex for vertex. *Rests on it:* T9. *Prior art:* FS73-T40 at K = 1. *Kernel:* declined (T8(a) is the
  statement to port).

**T14 — P0-T6: at `K_B(d) − 1` the δ-system is solvable at all 40 fields. [tools; float LP proposes feasibility, not certified; the phase-0 implementer]**
- *Proof:* `data/fs81/phase0/p03-struct.jsonl`. *Proof verdict:* a necessary condition only, not a point of `Θ₃`; consistent with
  T8's NONEMPTY side. *Rests on it:* nothing. *Prior art:* none. *Kernel:* declined.

**T15 — P0-T7: a new EMPTY certificate for ℚ(√59) on the 23 edge-direction pairs of its FS-61 witness (D = 90). [cert + hand; the phase-0 implementer; the owner re-ran the frozen checker]**
- *Proof:* `data/fs81/phase0/certs/ctl-pos-59-witness.json.gz`, frozen PASS (5,404 leaves). *Proof verdict:* closes; the positive
  control at d ≡ 3 (mod 8). *Rests on it:* phase 0's controls. *Prior art:* FS-61's witness (row 74). *Kernel:* declined.

**T16 — P0-T8: at K = 1 the listed configurations are EMPTY exactly at B over ℚ(√11) and C = `{1, v, z}·U^(5)` over ℚ(√23) (3, 4, +), ℚ(√71) (1, 6, +), ℚ(√119) (9, 10, −) and ℚ(√167) (11, 12, −) and (15, 14, +); NONEMPTY, with a certified point, at the other 198 tested. [cert (EMPTY: + hand); the phase-0 implementer]**
- *Proof:* `data/fs81/records/phase-P0-objects.md`. *Proof verdict:* closes for the objects listed. *Rests on it:* the d ≡ 23 (mod 48)
  lead (§5 R2). *Prior art:* FS73-T41 at 167. *Kernel:* declined.

**T17 — P0-T9: over ℚ(√167) the span of `A = {1, v, v̄}·U^(5)` is `L21cc6506`'s lattice (A's `Θ₃` point fails on `z̄`), so a configuration's span can decide where the configuration does not. [cert; the phase-0 implementer]**
- *Proof:* `data/fs81/phase0/checker-fixtures/wide-A167-on-L21cc6506.json`. *Proof verdict:* closes. *Rests on it:* the driver's
  saturation step (inventory item 42). *Prior art:* FS73-T11. *Kernel:* declined.

**T18 — P0-T10: complex conjugation and `√d ↦ −√d` send T41's configuration `C(+)` to one set that is neither `C(+)` nor `C(−)`; the two signs are the two orbits, and conjugate pairs agree at 167 and 47. [tools exact + cert; the phase-0 implementer, on the modeling agent's orbit proposal]**
- *Proof:* `data/fs81/phase0/orbits.jsonl`. *Proof verdict:* closes; a free builder control. *Rests on it:* phase 0's table.
  *Prior art:* FS73-T41 (`{1, v, z}` empty, `{1, v, z̄}` not). *Kernel:* declined.

**T19 — P0-T11: the frozen `tools/fs73v2_check.py`'s own `--self-test` passes both coverage mutants (low child `r·x ≤ lo − 2`; high child `r·x ≥ hi + 2`), so a coverage regression in it would not be caught; the checker itself is unchanged and sound. [tools, mutation test; found by the owner's plant on the new checker (inventory item 36), reproduced on the frozen one by the phase-0 implementer]**
- *Proof:* record §3's note; the mutants in the implementer's scratch; `tools/fs81_theta_check.py` carries both plants strictly
  (`634d75d3`). *Proof verdict:* closes. *Rests on it:* a note in FS-73's record (`plans/FS73-rigidity-dichotomy.md`, added at this
  close). *Prior art:* none. *Kernel:* declined.

## §4. Stage D — ℚ(√47) at four colours, calibrated first (the stage-D implementer; the modeling agent)

*Source: `data/fs81/records/phase-D.md` "Theorems this phase proved" (D-T1–D-T3) and its D0b and D1 sections; plan §B.*

**T20 — D-T1: value precedence over the unpinned colours only, encoded by an auxiliary chain, is a sound symmetry reduction under any clique pin and any vertex order; a chain that touches a pinned colour is not (unless the pinned clique comes first in the order). [hand; the modeling agent found the obligation (plan §B.2.2); the stage-D implementer proved it and built K2 on it]**
- *Proof:* K2's docstring, step 4; phase-D record, K2. *Proof verdict:* closes; K2 refuses the "precedence over a pinned colour" plant.
  *Rests on it:* every stage-D ask; `CLAUDE.md` § Toolchain's symmetry checklist item 2 (reworded at this close). *Prior art:* value
  precedence is standard (Law–Lee); the pinned-colour interaction is ours as a stated rule. *Kernel:* declined.

**T21 — D-T2: de Grey's lattice point `(a + bζ₆ + cw + dζ₆w)/9` is `((4a + 2b + 2c + d − d√33)/36, ((2b + d)√3 + (2c + d)√11)/36)`. [hand + tools exact; the stage-D implementer]**
- *Proof:* `tools/fs81_phaseD.py` `oe_to_k2`; K2 re-derives FS-73's 10,703 unit edges from the converted points and rebuilds FS-73's
  CNF byte for byte. *Proof verdict:* closes. *Rests on it:* T23. *Prior art:* FS-73's coordinates. *Kernel:* declined.

**T22 — D-T3: an additive four-colouring of a non-bipartite lattice unit-distance graph is gap-free at every vertex. [hand; the stage-D implementer]**
- *Statement.* `φ(−u) = −φ(u)`, so `φ(U)` is a symmetric subset of `G ∖ {0}` for `G = ℤ/4` or `V₄`; a proper subset gives a proper
  2-colouring, so a non-bipartite graph uses all three nonzero values at every vertex.
- *Proof:* phase-D record, "Theorems this phase proved". *Proof verdict:* closes. *Rests on it:* D1's typing (an additive colouring
  never supplies a gap; G68's gap must come from a non-additive colouring). *Prior art:* G68 (gapped colourings are non-additive for
  odd periods). *Kernel:* declined.

**T23 — D0b: the unit-distance graph on the R = 1.4 ball of de Grey's lattice (30,181 points) forces the pair (0, v), `v = −(4/9)(1 + √−11)`, at four colours, so `R*(X_A) ≤ 1.4`. [cert: K2 CERTIFIED and cake_lpr `s VERIFIED UNSAT` on one CaDiCaL LRAT, kissat agreeing; the stage-D implementer; the owner's plant on K2]**
- *Statement.* X_A = that graph plus the one non-unit edge {0, v} (squared length 64/27) is not four-colourable. The certificate
  proves a **forced pair**, never a chromatic bound. A solver-free bound came first (D0a): `R*(X_A) ≤ 1.4997`, because FS73-T6's
  certified 2,044-point core lies in that ball about the pair's midpoint and a refusing graph keeps refusing after vertices of degree
  < 4 are deleted.
- *Proof:* `data/fs81/phaseD/cert-X_A-target-R1.4/` (`K2.out`, `rup-recheck.out`; CNF sha256 `0169f9b4…`); the 140 MB LRAT is kept
  outside the repository (sha256 `02ff096b…d449`, regeneration in `PROOF-NOT-COMMITTED.md`). *Proof verdict:* closes at [cert]; the
  X_A triangle-pin and X_B refusals at R = 1.4 rest on two solvers only. *Rests on it:* LEDGER row 84; D2's `d*`. *Prior art:* FS73-T6
  (the 2,044-point forcer); `[Hubai2018]` (the ring's periodicity). *Kernel:* declined (a calibration bound, not a result on the
  target).

**T24 — D1: 102 of the 127 candidate lattices over ℚ(√47) are four-colourable, every one by a K1-certified witness (177 witnesses), 49 of them by a gapped colouring (so every pair on them is free, G68); the 25 survivors have no additive colouring into ℤ/4 or V₄. [cert; tools exact for the additive enumeration; the stage-D implementer]**
- *Proof:* `data/fs81/phaseD/d47/K1-checker-run.txt`; `data/fs81/phaseD/d47/survivors.md`. *Proof verdict:* closes for the 102; the
  survivors are typed nulls of capped screens (`Θ₄` finder 60 s, residue asks 120 s, quotients to N ≤ 15), none called rigid.
  *Rests on it:* row 84; the ℚ(√47) stub. *Prior art:* FS-79's screen (row 81), reused at d = 47. *Kernel:* declined.

**T25 — The four-colour sign `λ_min + deg/3` at the usable primes of ℚ(√167) and ℚ(√47): positive at 23 (+0.039, so the ratio bound refuses four colours on Γ₂₃: α ≤ 131.76 < 529/4), 31 (+0.0002) and 43 (+2.704); negative (slack) at 11 (−0.796) and 19 (−0.943). No usable prime of either field is four-tight. [tools exact (exact spectra); the owner, scoring P-G54 at FS-81's opening and correcting §G.1 in §R-review]**
- *Proof:* `plans/FS79-invariant-question.md` §R-close.5 (P-G54); `plans/FS81-quadratic-four-colours.md` §R-review item 1.
  *Proof verdict:* closes; controls reproduce G54's table (7 at k = 4, −4.494; 3 at k = 3, −2; 11 at k = 5, −4.796). *Rests on it:* G54's
  *Do* (three signs, reworded at this close); stage D's reading that no tight-prime mechanism gives a full-rank `F` at ℚ(√47).
  *Prior art:* Hoffman's ratio bound; G54's classifier. *Kernel:* declined.

## §5. Readings and open questions this milestone stated and did not prove (the close's sweep)

*The plan and the records were grepped for "conjecture" and "not claimed" (no hidden conjecture found); each item below has a stub or
an explicit decline.*
- **R1 — the mod-8 skew** [reading; the advisor raised it, the verifier's T8(b) supplies the mechanism]: configuration A's
  nonemptiness at `d ≡ 11 (mod 24)` explains why FS-61's census certified 2 of 20 fields at `d ≡ 3 (mod 8)` against 13 of 20 at
  `d ≡ 7 (mod 8)`. Killing test: a census-style search that lands the `d ≡ 11 (mod 24)` fields at the `d ≡ 23 (mod 24)` rate. In
  G61 (declined as a stub: the census is closed, so only a re-run of its search tests it).
- **R2 — the d ≡ 23 (mod 48) lead** [observation, T16]: T41's shape C empties at K = 1 only at 23, 71, 119, 167, all ≡ 23 (mod 48),
  not at 263, 311, 359 — a threshold in n like B's. Not a stub of its own: FS-75's re-aim carries it as the cheap first derivation
  (T8's norm-bound method should decide it in an afternoon).
- **R3 — D2's price as a size ratio** [reading]: the cheapest minimal survivor over ℚ(√47) needs at least 1,284 times the calibration
  control's points at the density where the control refuses four colours in 55 s; carried from an abelian Cayley graph with one
  non-unit edge, the triangle axis uncovered; not evidence that four colours suffice. In row 84 and the ℚ(√47) stub.
- **R4 — the four-colour undecided band** [measured, contended; one lattice, one encoding, one wall]: on de Grey's lattice the
  refusing families stay undecided at `d_ball` 8.3–14.7. In row 84 and G65.
- **R5 — every additive three-colouring is Fischer's up to symmetry** [open; needs `ℤ[U]/3ℤ[U]`, `[Fischer1990b]`'s closed form the
  input]. In T6; declined as a stub (not on any path to six).
- **R6 — the residual three-colour case** [open]: real number fields whose primes above 3 of odd residue degree all have degree ≥ 3,
  first instance `ℚ(α, √7)`, `α³ = α + 1`. Stub: `plans/STUB-three-colours-residue-degree-three.md`.
- **R7 — one character for the whole field at five colours** [open; the advisor's question, inventory items 12, 18]: can a character
  of `ℤ[U_F]` put every unit vector in `[1/5, 4/5]`? A yes over ℚ(√167) falsifies the conjecture there; at four colours over ℚ(√47),
  its five-clause. Routed to FS-64's stub and to the layer-method stub `plans/STUB-layer-method-five-colours.md`.
