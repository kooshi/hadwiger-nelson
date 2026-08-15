import Proofs.HadwigerNelson.OneDefect
import Proofs.HadwigerNelson.PairDist

/-!
# Specification of `OneDefect.lean` — the Moser bound, re-proved through the abstract spindle

The one-defect theorem quantifies over every finite graph, every colour count and every distance;
this file exhibits a *model* of its hypotheses at the smallest interesting size, and reads the
conclusion aloud against a theorem the repository already holds another way. The rhombus — two unit
triangles on a shared edge, `Gadget.rhombus` — has its far corners at distance `√3`, and at three
colours it forces them equal (`Gadget.rhombusGadget`, by exhaustion). Fed to
`add_one_le_chromaticNumber_unitDistance_of_forces` at `d = √3 ≥ 1/2` that is **χ(ℝ²) ≥ 4** — the
Moser bound, with no spindle drawn, no seventh point, and no certificate: homogeneity places the
second rhombus and the `√3`–`√3`–`1` triangle closes it.

The same object through the *append* form (`_of_one_defect`, refuting the rhombus with its tip
pair as an extra edge, i.e. `K₄`) exercises the other entry point. And the red control: at
`d < 1/2` the triangle does not exist, so `1/2 ≤ d` is load-bearing — stated as an `example`.
-/

namespace HadwigerNelson

open SimpleGraph

/-- The rhombus's four points, twice their true coordinates: index `1 ↦ 0`, `2 ↦ 1`, `0 ↦ ζ₆`,
`3 ↦ ζ̄₆`. Indices match `Gadget.rhombus` (`0` and `3` are the far corners). -/
def rhombusTable : PtTable :=
  (PtTable.node 2
    (PtTable.node 1
      (PtTable.leaf ⟨⟨⟨⟨⟨1,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,
                     ⟨⟨⟨⟨0,1⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩)
      (PtTable.leaf ⟨⟨⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,
                     ⟨⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩))
    (PtTable.node 1
      (PtTable.leaf ⟨⟨⟨⟨⟨2,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,
                     ⟨⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩)
      (PtTable.leaf ⟨⟨⟨⟨⟨1,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,
                     ⟨⟨⟨⟨0,(-1)⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩)))

/-- The rhombus as a certificate: `Gadget.rhombus`'s five edges, all unit. -/
def rhombusCert : UDCert 4 where
  verts := rhombusTable.toVerts
  edges := rhombus
  denom := 2

theorem rhombusCert_valid : rhombusCert.Valid = true := by decide +kernel

/-- The far corners are at distance `√3`. -/
theorem rhombusCert_tips : rhombusCert.PairsAt [(0, 3)] 3 = true := by decide +kernel

/-- **The rhombus forces its far corners equal at three colours** — `Forcer.rhombus_forces` holds
this already; here the same fact is re-derived from `Gadget.rhombusGadget` (exhaustion over `3⁴`
colourings) through `forces_of_gadget`, so the gadget→`Forces` bridge is exercised against a
theorem proved another way. -/
theorem rhombus_forces_of_gadget : Forces (edgeGraph 4 rhombus) 3 0 3 :=
  forces_of_gadget rhombusGadget 0 1 (by decide)

/-- **The Moser bound through the abstract spindle: χ(ℝ²) ≥ 4.** No spindle is drawn — the rhombus,
its `√3` tip pair, and the theorem. -/
theorem four_le_chromaticNumber_plane_of_rhombus : ((3 + 1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := by
  have hunit := rhombusCert.valid_sound (by decide) rhombusCert_valid
  have htip := rhombusCert.pairsAt_sound (by decide) rhombusCert_tips (0, 3) (List.mem_singleton_self _)
  refine add_one_le_chromaticNumber_unitDistance_of_forces rhombusCert.point ?_ htip ?_ rhombus_forces_of_gadget
  · rintro i j ⟨-, hij | hji⟩
    · exact hunit (i, j) hij
    · rw [dist_comm]; exact hunit (j, i) hji
  · -- `1/2 ≤ √3`, since `(1/2)² < 3`.
    rw [show ((3 : ℤ) : ℝ) = 3 by norm_num]
    exact le_trans (by norm_num) (Real.le_sqrt_of_sq_le (by norm_num : (1 : ℝ) ^ 2 ≤ 3))

/-- **The same bound through the append form**: the rhombus with its tip pair as an extra edge is
`K₄`, not 3-colourable — the shape a descent certificate produces (a refutation of the list with
one non-unit pair). -/
theorem four_le_chromaticNumber_plane_of_rhombus_defect :
    ((3 + 1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := by
  have hunit := rhombusCert.valid_sound (by decide) rhombusCert_valid
  have htip := rhombusCert.pairsAt_sound (by decide) rhombusCert_tips (0, 3) (List.mem_singleton_self _)
  refine add_one_le_chromaticNumber_unitDistance_of_one_defect rhombus 0 3 rhombusCert.point hunit
    htip ?_ ?_
  · rw [show ((3 : ℤ) : ℝ) = 3 by norm_num]
    exact le_trans (by norm_num) (Real.le_sqrt_of_sq_le (by norm_num : (1 : ℝ) ^ 2 ≤ 3))
  · -- `K₄` at three colours: every colouring repeats on some edge; `decide` over `3⁴`.
    intro hc
    obtain ⟨f, hf⟩ := colorable_iff_exists.mp hc
    revert f hf
    simp only [edgeGraph_adj]
    decide

/-- **Red control: `1/2 ≤ d` is load-bearing.** At `d = 1/4` the two circles miss and no
`d`–`d`–`1` triangle exists, so the spindle theorem cannot be applied there. -/
example : ¬ ∃ z : ℂ, dist 0 z = 1 / 4 ∧ dist ((1 / 4 : ℝ) : ℂ) z = 1 :=
  not_exists_dist_eq_and_dist_eq_one_of_lt_half
    (by rw [dist_zero_left, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (by norm_num)])
    (by norm_num)

end HadwigerNelson
