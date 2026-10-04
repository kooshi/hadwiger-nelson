import Proofs.HadwigerNelson.Topology.LebesgueCovering
-- FS131-LEB: the one-line discharge of FS-131 wave 4's `sorry`, tested here against a verbatim copy of wave 4's two
-- declarations (`.claude/worktrees/fs131-w4/Proofs/HadwigerNelson/Plane/SVMap.lean` lines 246–258, branch `fs131-w4`
-- at `6bd00949`), placed in wave 4's namespace with wave 4's `open` line, so name resolution is the one wave 4 will see.
-- Run: lake env lean data/fs131/leb/Wave4Bridge.lean (iteration only; not part of the library).

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- The closed axis-parallel square `[c.re, c.re + s] × [c.im, c.im + s]`. -/
def closedSquare (c : ℂ) (s : ℝ) : Set ℂ := {z | c.re ≤ z.re ∧ z.re ≤ c.re + s ∧ c.im ≤ z.im ∧ z.im ≤ c.im + s}

/-- Wave 4's statement, discharged by FS131-LEB. -/
theorem lebesgue_covering_square {m : ℕ} (c : ℂ) {s : ℝ} (hs : 0 < s) (F : Fin m → Set ℂ) (hF : ∀ i, IsClosed (F i))
    (hcov : closedSquare c s ⊆ ⋃ i, F i)
    (hLR : ∀ i, ¬ ((∃ z ∈ F i ∩ closedSquare c s, z.re = c.re) ∧ ∃ z ∈ F i ∩ closedSquare c s, z.re = c.re + s))
    (hBT : ∀ i, ¬ ((∃ z ∈ F i ∩ closedSquare c s, z.im = c.im) ∧ ∃ z ∈ F i ∩ closedSquare c s, z.im = c.im + s)) :
    ∃ z ∈ closedSquare c s, ∃ i j l : Fin m, i ≠ j ∧ i ≠ l ∧ j ≠ l ∧ z ∈ F i ∧ z ∈ F j ∧ z ∈ F l :=
  LebesgueCovering.lebesgue_covering_square c hs F hF hcov hLR hBT

#print axioms lebesgue_covering_square

end HadwigerNelson.Plane
