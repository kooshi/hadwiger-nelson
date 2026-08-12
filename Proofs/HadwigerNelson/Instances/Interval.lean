import Proofs.HadwigerNelson.Instances.DeGrey.Bound
import Proofs.HadwigerNelson.Instances.Seven

/-!
# The classical interval, kernel-checked at both ends (M36)

**Read aloud, against the informal claim.** Colour every point of the plane so that no two
points exactly one unit apart get the same colour. At least five colours are needed, and
seven always suffice. Both ends are checked by the Lean kernel.

* the lower end is `chromaticNumber_plane_ge_five` — de Grey's 1581-vertex unit-distance
  graph, its geometry exact in `ℚ(√3, √5, √7, √11)` and its non-4-colourability replayed
  from an LRAT certificate (M06–M09);
* the upper end is `chromaticNumber_plane_le_seven` — the `4/5 × 3/5` brick colouring of
  `Instances/Seven.lean`, one certificate `decide`.

Neither end is new mathematics: `χ(ℝ²) ≥ 5` is de Grey (2018) and `χ(ℝ²) ≤ 7` is classical.
What this file states is that the interval every account of the Hadwiger–Nelson problem
opens with is now, in this repository, a theorem on axioms exactly
`[propext, Classical.choice, Quot.sound]` at both ends — and the exact value inside it
remains open.
-/

namespace HadwigerNelson

/-- **`5 ≤ χ(ℝ²) ≤ 7`** — the classical interval of the Hadwiger–Nelson problem, both ends
kernel-checked. -/
theorem chromaticNumber_plane_interval :
    5 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber ∧
      (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber ≤ 7 :=
  ⟨chromaticNumber_plane_ge_five, chromaticNumber_plane_le_seven⟩

end HadwigerNelson
