# FS-73 — Poros's two held items (plan-phase Poros, final report 2026-09-23). NOT in the repo until the close.
Ruling R1: the P3 advisor offers them to BOTH competitors identically, at the same moment, only after each has written its own first route.

## H-1: irreversible walls — a necessary condition on one shape of counterexample, tied to G58. (Sketch, hand, not checked in detail.)
- Setting: C3-inherit fails at (Λ, δ) exactly when some non-periodic colouring c separates a vector δ ∈ P (P = common periods of all periodic colourings).
- Reduction to one dimension: if c is periodic under a sublattice W of rank r−1 (at K read Λ/F for Λ), c is determined on Λ/W ≅ ℤ × finite, so c is a point of a 1-D SFT Y over a finite slab alphabet.
- 1-D fact: Y splits into irreducible components joined by one-way transient transitions (a DAG). Every word inside one irreducible component occurs in a periodic point of Y, which is a finite-index periodic colouring of Λ. So if c's separating word lies in a recurrent part of Y, H1 already fails at δ. A counterexample of this shape needs its separating pattern on a TRANSIENT wall from phase A to phase B with no route back.
- Symmetry step: x ↦ −x is an automorphism of Cay(Λ,U) (U = −U) preserving W; c∘(−1) runs from −B to −A. If one global colour permutation τ makes τ(−A) ~ A and τ(−B) ~ B (G58's antipodal form), a B→A transition exists, A and B are one irreducible component, and a periodic separator exists.
- Conclusion: a counterexample periodic in r−1 directions needs a CHIRAL pair of phases (not jointly self-conjugate under −1 up to one colour permutation), or a wall whose reverse is blocked for another reason.
- Unchecked: whether the reflection acts on the slab alphabet so as to swap components nontrivially; says nothing about corners, point defects (tri-sectors), lower-rank periodicity.
- Bears first at K if P has finite index and F rank 2: walls between G70's two residue phases; MASCOT-T10's phase walls.
- Killing test: a reversible wall pair (A|B and B|A realised) whose alternating periodic arrangement A|B|A|B… is not proper.

## H-2: window colourings — a constructive family for the recurrent non-periodic part of the gap. (Construction, hand; usefulness untested.)
- A rank-4 lattice Λ in a quartic CM field E embeds discretely and cocompactly in ℂ × ℂ′ (the two complex embeddings); each projection is dense. Complex conjugation central in a CM field ⟹ |u′| = 1 for u ∈ U, so U′ is a set of unit vectors.
- For any f: ℂ′ → {1,2,3,4} with f(y) ≠ f(y + u′) ∀y, ∀u ∈ U, c(x) = f(x′) properly colours Cay(Λ,U). Same with the physical embedding: c(x) = g(x) for g a colouring of the plane avoiding only the finitely many directions of U.
- For measurable f with regular (polygonal) classes, c is a cut-and-project / model-set colouring: recurrent, uniquely ergodic, non-periodic unless f is periodic under a lattice of ℂ′ compatible with Λ′ (then c's period group generically rank ≤ 2). Periodic colourings = continuous through the finite places (profinite completion); window colourings = continuous through an archimedean place — natural candidates in the recurrent part of C3's gap.
- A counterexample of this type: a regular proper f with f(y) ≠ f(y + δ′) somewhere, at some δ ∈ P. Mixed windows through ℂ′ × ℤ_p are FS-64's adelic instrument.
- Fourier bound does not exclude it: a measurable four-class f needs inf_ξ Σ_u cos 2π⟨ξ, u′⟩ ≤ −d/3 = −18; characters through ℂ′ are dense in T⁴, so the infimum is the lattice's continuous minimum −22.41 (plan §R0).
- Caveat: any colouring of Λ extends to ℂ′ by cosets, so the family has content only for regular f.
- Killing test of usefulness: a proof that no regular four-class f avoids U′ (e.g., a finite unit-distance configuration in the U′ directions forcing five colours on any regular colouring).

## For the P3 advisor (Poros's §5, condensed)
Read the census's two ranks (F_known, P_found) and P_found's stabilisation data first; if P stabilises at finite index and F stays rank 2, K itself is the counterexample candidate. Traps: odd targets refusing ≠ no odd-period colouring (quotients are subgraphs/diagonal subgraphs); "rigid" has four meanings (G42 γ=0; G69 Kempe = H1; G61(2) tight-unique; G70 √3-clean ⟹ residue); distances vs vectors; "-found" vs "every"; target vs quotient spectra; corollaries dressed as observations. Ask each competitor to check a construction against its own stated prediction before sending (Poros's error shape).
