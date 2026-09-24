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

**Grade of the chain.** Every entry T1–T7 has **two independent derivations**: the planner's, with Poros's check, and the
verifier's, written blind and compared line by line in the verification record §2 (14 divergences of route, none of truth). That is the
FS-73 standard [hand, two independent derivations].

## §1. Stage C — the field-level three-colour theorem

**T1 — The pull-back lemma (P-F1). [hand; the modeling agent; checked by the verifier]**
- *Statement.* For an additive map `φ : A → B` with `φ(S_A) ⊆ S_B`, `θ ↦ θ∘φ` maps `Θ(B, S_B)` into `Θ(A, S_A)`.
- *Instances.* L3 (`φ = x ↦ bx : (R₅, U₅) → (R_F, U_F)`); L1's restriction maps (the inclusions `(⟨S⟩, S) → (R_F, U_F)`); FS73-T11's
  "a sub-configuration's EMPTY proves the field".
- *Proof:* one line (verification record §2.1).
- *Rests on it:* T2, T4.
- *Prior art:* standard functoriality; not claimed.
- *Kernel:* **kernel**, with FS-75 (a two-line lemma).

**T2 — L1 as an inverse limit (P-F2), with the finite form's band map written out. [hand; the planner and Poros (FIP form, sketch L1), the verifier (both forms, record §1.1 and §2.1)]**
- *Statement.* For every subfield `F ⊆ ℝ`, `Θ₃(F) = lim_S Θ₃(⟨S⟩, S)` over the directed set of finite symmetric `S ⊆ U_F`. So
  `χ(F²) ≤ 3 ⟹ Θ₃(F) ≠ ∅` (L1), with no finite generation of `ℤ[U_F]`.
- *The finite form used* is FS73-T22 ⟹ applied to `Λ = ⟨S⟩` (generation holds by definition). The verifier re-derived it with the
  explicit band map `t = 𝟙/2 − a/6`, which needs the winding's parity `W(ρ) ≡ Σρ (mod 2)`.
- *Proof:* the verification record §1.1 (the FIP form in `Hom(R_F, T)`) and §2.1 (the inverse-limit form); `plans/FS81-F-sketch.md` L1.
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
  - **`χ(ℚ(√2, √7)²) ≥ 4`** is a new instance: `1/3 = 1 + u + ū` with `u = (−1 + 2√2 i)/3`, and L4's relation is
    `1 = 12 + 3u + 3ū − 6v₇ − 6v̄₇`.
- *Proof:* the verification record §1.5 and §2.1; the sketch F-T4.
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
- *Rests on it:* P0.3's expectations (every census field is EMPTY in B at `K_B(d) ≤ 3`); the kernel's per-d fallback for T5.
- *Prior art:* ours.
- *Kernel:* **stub (FS-75)**. As a parametric certificate family it is the finite shadow of T5.
- *Reading, not proved:* that configuration A's nonemptiness at `d ≡ 11 (mod 24)` explains the census's skew (2 of 20 certified at
  `d ≡ 3 (mod 8)` against 13 of 20 at `d ≡ 7 (mod 8)`). The census used saturated lattices of its own, not configuration A. The
  killing test: a census-style search (lattice balls at the census's depth) that lands the `d ≡ 11 (mod 24)` fields at the same rate
  as the `d ≡ 23 (mod 24)` ones.
