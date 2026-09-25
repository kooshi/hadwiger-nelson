# HELD — candidate routes for the FS-86 competition's advisor (plan-phase Poros)

*Written by the plan-phase advisor of FS-86 (four-colour rigidity over ℚ(√59), ℚ(√83)). Each item is a candidate route or route
analysis I formed while advising the planner and deliberately did NOT send, so neither competitor gets a head start. Offer them to both
competitors at the same moment, only after both have written their first route (protocol rule 5; FS-73 ruling R1). Every item is a hunch
in the hypothetical mood with its basis and falsifier; nothing here is checked beyond what is stated.*

**Sent to the planner as frame (so NOT held; in the plan):** the row-67 identity of the dyadic plane; F(R) = ⋃ F(Λ) and P(Λ) ⊆ P(R) ∩ Λ;
the field-level binary F(R) ∈ {0, P(R)} (G55 transport); P₄(R) = R ∩ 𝔓⁴ by weak approximation + `[Zhang2012]` Thm 1.8(i) + row 67 (the
ramified 59 tower unchecked); that one non-periodic colouring of R gives F(R) = 0; that G74/FS-83 bears on the "no" branch.

**Notation.** F = ℚ(√59); R = ℤ[U_F]; 𝔓 the dyadic prime of F(i), 𝔓² = (2); P_m = row 67's Cay(O/𝔓^m, S_m); Θ₄(F) = characters θ of R
with θ(U_F) ⊆ [1/4, 3/4]; Λ a finitely generated sublattice with finite unit-vector set U.

---

hunch: HD1-character-colourings-cannot-give-the-field-level-no
  claim: At the field level, a point θ of Θ₄(F) with nonzero archimedean part cannot exist, so FS-83's character colourings cannot supply the non-periodic colouring that would prove F(R) = 0.
    - A character of R with a nontrivial component at a NON-stable (split) place has dense range on U_F: unit vectors there have unbounded valuation (T(F_v) ≅ F_v^×), so {βa + γ/a}_p runs over ℤ[1/p]/ℤ. So θ = τ + ℓ, τ torsion from the stable places (finitely many values on U_F), ℓ archimedean.
    - Weak approximation makes the τ-coordinate and the archimedean coordinate of u ∈ U_F independent; the archimedean range of ℓ on the dense set is a symmetric interval [−r, r]. So τ(U_F) + [−r, r] ⊆ [1/4, 3/4] needs, if r > 0, τ(U_F) ⊆ (1/4, 3/4) strictly.
    - Such τ is an additive homomorphism of the product of local planes into a circular clique K_{n/k} with 3 < n/k < 4. By the MIS-normal argument its composition with a four-colouring is pulled back from the dyadic plane; whether an additive circular colouring of P_m × H with ratio < 4 exists is the remaining check (K₄ at level one has χ_c = 4; I expect none).
    - If none exists, Θ₄(F) consists of torsion points only (Fischer-type additive colourings, local at 2), all periodic: FS-83 at k = 4 over ℚ(√59) gives nothing toward F(R) = 0.
  basis: derived (the first two bullets); prior (the circular step)
  falsifier: an additive map R → ℤ/n with every unit vector landing in (n/4, 3n/4), n/k₀ ∈ (3, 4); or a character with a non-stable-place component and bounded range on U_F
  registered: 2026-09-25
  status: open

hunch: HD2-F-zero-at-the-field-level-via-gaps-on-a-cofinal-chain
  claim: F(R) = 0 iff F(Λ_M) = 0 for every M in a cofinal chain (FR-1(i)); and F(Λ) = 0 whenever Λ has ONE periodic four-colouring with a fan gap (row 66, `slack_addCayley_of_fanGap`). So a route to the field-level "no": show every Λ_M has a gapped periodic colouring — the natural source being its sparse dyadic sub-tower Q_m past the saturation depth (U cannot fill S_m there), where tightness may fail and a gap may appear. A uniform-in-M construction (by formula, not search) would prove "no finite triangle-free unit-distance graph over ℚ(√59) forces a pair at four colours" — a restricted Soifer-negative, and with FR-1(iii) a counterexample to the inheritance question P = F at four colours (P(R) ≠ 0 = F(R)).
  basis: derived (the equivalence and the gap consequence); prior (that sparse levels carry gaps)
  falsifier: a Λ_M all of whose periodic four-colourings are gap-free at every level (then this route cannot give F(Λ_M) = 0 and something else must)
  registered: 2026-09-25
  status: open

hunch: HD3-twisted-dyadic-homomorphisms-bound-P-on-a-lattice
  claim: For a finitely generated Λ, P(Λ) ⊆ ⋂ φ^{-1}(𝔓⁴) over all additive φ: Λ → O with φ(U) ⊆ S (each gives colourings pulled back from P₄ along φ). At the field level φ must satisfy φ(S) ⊆ S on the closure (U_F dense in S), which I expect leaves only the symmetries (multiplication by S, the Galois group of L/ℚ₂) — no reduction. For finite U the condition is finitely many 2-adic equations N(φ(u)) = 1 on a rank-4 ℤ₂-linear map, much looser, so twists may exist and cut P(Λ) below Λ ∩ 𝔓⁴ — possibly to 0. Computing the 2-adic points of this variety mod 𝔓^m is exact computer algebra (derivation-shaped), not a colouring search.
  basis: derived (the bound); prior (that twists exist for finite U)
  falsifier: for Λ_510, the only solutions mod 𝔓^m (m ≤ 8) are the symmetries of the inclusion
  registered: 2026-09-25
  status: open

hunch: HD4-kempe-screens-are-blind-at-the-field-level
  claim: On Cay(R, U_F) every two-colour Kempe component of a colouring pulled back from P₄ spans its fibre: the voltage lattice contains u − u' for every pair u ≡ u' (mod 𝔓⁴) of unit vectors (walk 0 → u → u − u'), and with U_F dense these generate R ∩ 𝔓⁴ (or a finite-index part). So FS-70's voltage-escape screen cannot produce the "no" at the field level; the escapes, if any, are non-Kempe.
  basis: derived (the walk); prior (the generation)
  falsifier: a Kempe component of a pulled-back colouring of R that misses part of its 𝔓⁴-fibre
  registered: 2026-09-25
  status: open

hunch: HD5-the-counting-behind-FR-1-iii
  claim: (Sent in substance as frame; kept here for the competition advisor's convenience.) Four classes of a four-colouring of G × H each have size ≤ α(G × H) = α(G)|H| = |G||H|/4 (Zhang's formula), so each is a maximum independent set; by MIS-normality each is I_j × V(H) (a preimage from H would have size ≤ |G|α(H) < |G||H|/4); so the colouring is c ∘ π_G.
  basis: derived
  falsifier: Zhang's journal Theorem 1.8 carrying an extra hypothesis absent from arXiv v1
  registered: 2026-09-25
  status: open (sent as frame)

---

**Note added at stage A's close (2026-09-25).** HD1 bears directly on the plan's fallback (§S.5, FS-83 at `k = 4`): it predicts the
fallback's hour-one question is decided by weak approximation plus one circular-chromatic question on the product of stable local planes.
If the killing test fires, release HD1 to the fallback's agent before it starts (owner's call). HD2–HD4 are for the competition advisor
under protocol rule 5. HD5 was sent as frame and is in the plan (§0.3 (iii)).
