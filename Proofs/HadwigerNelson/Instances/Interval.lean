import Proofs.HadwigerNelson.Instances.DeGrey.Bound
import Proofs.HadwigerNelson.Instances.Seven
import Proofs.HadwigerNelson.Reduction

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
remains open, which is the whole point of the hunt this repository is for.

**What "kernel-checked" covers here**, exactly. The upper end rests on nothing but the
kernel: the colouring is written down rather than searched for, and its certificate is
`decide`d. The lower end rests on the kernel plus the standing reading of an LRAT
certificate: the SAT solver that produced that certificate is an untrusted oracle whose
output the kernel re-checks line by line. Neither end trusts anything in `tools/`.
-/

namespace HadwigerNelson

/-- **`5 ≤ χ(ℝ²) ≤ 7`** — the classical interval of the Hadwiger–Nelson problem, both ends
kernel-checked. -/
theorem chromaticNumber_plane_interval :
    5 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber ∧
      (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber ≤ 7 :=
  ⟨chromaticNumber_plane_ge_five, chromaticNumber_plane_le_seven⟩

/-! ## What the lower end costs every statement about four-colourings of the plane

A consequence of the left half worth stating on its own, because it is easy to state a theorem
that this fact silently empties. Since the plane needs five colours, **the type of proper
four-colourings of the plane is uninhabited**, so any theorem of the form "every proper
four-colouring of the plane does `P`" is vacuously true and is evidence for nothing, whatever `P`
says and however hard its proof was.

Two theorems in this repository are of that form — `Instances/Core9.lean`'s `core9_plane` (every
proper four-colouring of the plane has a monochromatic `√3`-pair) and `Instances/Core122.lean`'s
`core122_plane` (the same at distance `2`). Both are true and both are kernel-checked; neither
carries content, and the content they were written to carry is in their *carriers*
(`core9_pigeonhole`, `core122_pigeonhole`), which quantify over four-colourings of a nine- and a
122-vertex graph and are not vacuous — the nine-core is 3-colourable, so it certainly has proper
four-colourings.

The non-vacuous plane-level form has to name a class of objects that really is four-colourable.
Over `K = ℚ(√3, √11)` there is one, by Theorem B (`FieldWall4.lean`); `ValuationLaw.lean` works
there for exactly this reason. At five colours nothing is emptied: whether `χ(ℝ²) ≥ 6` is open, so
`Instances/HexShell.lean`'s five-colour statements are live. -/

/-- **The plane has no proper four-colouring** — `chromaticNumber_plane_ge_five`, moved across the
isometry to `ℂ` and read as the emptiness of a type. -/
theorem isEmpty_coloring_plane_four : IsEmpty ((unitDistance ℂ).Coloring (Fin 4)) := by
  constructor
  intro C
  have hle : (unitDistance ℂ).chromaticNumber ≤ 4 :=
    SimpleGraph.Colorable.chromaticNumber_le ⟨C⟩
  have h5 : (5 : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := by
    rw [← chromaticNumber_plane_eq_complex]; exact chromaticNumber_plane_interval.1
  have : (5 : ℕ∞) ≤ 4 := le_trans h5 hle
  norm_num at this

/-- **So a statement about every proper four-colouring of the plane says nothing.** Stated as the
general fact rather than instance by instance, and used as the honest reading of `core9_plane` and
`core122_plane`. -/
theorem vacuous_of_plane_four_coloring (P : (unitDistance ℂ).Coloring (Fin 4) → Prop) :
    ∀ C, P C := fun C => (isEmpty_coloring_plane_four.false C).elim

end HadwigerNelson
