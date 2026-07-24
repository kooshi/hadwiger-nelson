import Proofs

/-!
# Axiom audit — the trust receipt

The de Bruijn criterion made a standing check: everything shipped reduces to what the kernel
verified plus what we explicitly chose to trust. One `#print axioms` line per public theorem on the
milestone's surface; the gate reads this output and fails on a leftover `sorryAx` or an unaudited
custom axiom.

Run it:  `lake env lean scripts/Axioms.lean`

**M01 — the statement.** Expected on every line: exactly `propext`, `Classical.choice`,
`Quot.sound`. No `sorryAx`, no `Lean.ofReduceBool` (nothing native yet — that ledger opens at M05).
-/

open HadwigerNelson

-- The reduction and its API.
#print axioms lt_chromaticNumber_iff_not_colorable
#print axioms add_one_le_chromaticNumber_iff_not_colorable
#print axioms lt_chromaticNumber_unitDistance
#print axioms add_one_le_chromaticNumber_unitDistance
#print axioms chromaticNumber_unitDistance_congr
#print axioms add_one_le_chromaticNumber_unitDistance_edgeList

-- The model of the hypotheses, and the headline.
#print axioms trianglePoints_dist
#print axioms not_colorable_two_top_fin_three
#print axioms edgeGraph_triangleEdges_eq_top
#print axioms three_le_chromaticNumber_unitDistance_complex
#print axioms three_le_chromaticNumber_unitDistance_complex'
#print axioms three_le_chromaticNumber_plane
