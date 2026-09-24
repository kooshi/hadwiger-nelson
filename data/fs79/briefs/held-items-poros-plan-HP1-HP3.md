# Poros FS-79 plan phase: HELD items (for the owner's final report only; never to the planner or competitors)

*Kept separate from the record so the record's shared sections can be moved to `plans/` without carrying these.*

## H-P1 (withdrawn as held: it surfaced independently in the plan)
"Rigidity manufactures torsion": a rigid factor (de Grey's lattice, F = 8Λ, 9,120 colourings) makes a torsion-free Cayley graph behave
like ℤ² × finite, the torsion-then-lift step Greenfeld–Tao use for tilings. The planner reached it independently from FS73-T34 (KR6's
frame product; plan §PA.3 item 4). It is public in the plan, so nothing is held. The Greenfeld–Tao reading debt is inventory item 16.

## H-P2 (held: a candidate invariant, a construction with a snag and tests)
- **The coincidence.** K₄'s square complex is ℝP² = S²/antipode (through the cube Q₃, FS73-T29). Lovász's box complex satisfies
  B(K₄) ≃ S² ℤ₂-equivariantly, with the antipodal action. So the plan's "higher kinds (target topology above loops)" and its Kind T (the
  domain's ℤ₂-index) may be one kind: an equivariant degree into (S², antipode).
- **Candidate.** Pass to the winding's double cover, where the colouring lifts to a Q₃-colouring and hence to the sphere. There, take the
  π₂-charge per unit area on each 2-dimensional sublattice plane: a "skyrmion density" 2-form on Λ⊗ℝ. It is the slope one dimension up
  (G72's "spheres").
- **Snag 1 (sign).** π₁(ℝP²) acts on π₂ by −1. A deck translation with w = 1 flips the charge while averaging preserves the density, so
  the density must vanish on every 2-plane not contained in ker(w). This is a test, not only a snag.
- **Snag 2 (fillings).** For generating sets whose relation cycles are not squares (Pythagorean relators, long odd cycles), each relator
  2-cell's filling in S² is unique only up to π₂. So the charge is defined only modulo the integer contributions of the relator cells.
  Whether the density survives that ambiguity is the real question.
- **Tests:**
  - every one of de Grey's 12 classes should carry a well-defined density, and F = 8Λ should be visible;
  - compare with Moore–Newman's height on the triangular lattice;
  - on the grid, CGHO says there is no height; is a charge still defined?
  - on T30's rank-1 walls: rank 1 has no 2-planes, so the charge is silent there, as it must be.

## H-P3 (held: a framing of the obstruction question, borderline between question and route)
At three colours Θ is compositional: Θ(S₁ ∪ S₂) = Θ(S₁) ∩ Θ(S₂), because Θ is defined generator by generator. That is what made
L21cc6506's certificate small (T40: one pull-back per layer). The obstruction question in G72 shape could ask:
- *is there a one-sided invariant T, taking values in a computable family, with T(S₁ ∪ S₂) ⊆ T(S₁) ∩ T(S₂) and T(S) = ∅ ⟹ not
  4-colourable?*

The multilayer U = {1, v, v̄, z, z̄}·U_R is the instance that invites it. Held because it points at a route: layer-wise certificates.
