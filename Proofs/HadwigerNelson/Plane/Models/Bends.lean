import Proofs.HadwigerNelson.Plane.Models.Paint

/-!
# Models of the bends: a ring arc of the cusp fragment, and a plane map with a radius-2 contact interval (FS131-KM1, skeleton)

`plans/FS131-models-kernel-plan.md` § 5.

* **`bend_toward`, `bend_away_whole`** (`Plane/ValidMap/UnitArc`): the arc of `ω(i)` over `[−π/2 + 1/10, −π/2 + 2/5]` in `cuspFrag`, inner
  colour `0`, outer colour `1`. Its centre `i` is outside the closure of the domain `B(0, 1/2)`, so it carries no colour, and the
  radius-2 arc is `1/2` from the domain: both bends' hypotheses hold (`cuspFrag_bend_away`, `cuspFrag_bend_toward`).
* **`awayModel : ArcMap 8`** (FS131-KA1's plan § 5; the inhabitant of wave 5's `bend_away_part`): the brick map with the colour `7` on the
  part of the brick `(0, 4/5) × (0, 3/5)` inside `B(P, 1)` and on the part of the brick `(4/5, 8/5) × (0, 3/5)` outside `B̄(P, 2)`,
  `P = −3/5 + (3/10) i`. A unit arc of `ω(P)` with inner colour `7`, absent at `P`, whose radius-2 contacts are an interval strictly inside
  its angles.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## The cusp fragment's ring arc -/

/-- **A ring arc of the cusp fragment**: the arc of `ω(i)` over `[−π/2 + 1/10, −π/2 + 2/5]`, inner colour `0`, outer colour `1`. -/
theorem cuspFrag_isRingArc : ArcMap.cuspFrag.IsRingArc I (-(π / 2) + 1 / 10) (-(π / 2) + 2 / 5) 0 1 := by
  sorry

/-- The centre `i` carries no colour of the cusp fragment: it is `1/2` from the domain. -/
theorem cuspFrag_coloursAt_I : ArcMap.cuspFrag.coloursAt I = ∅ := by
  sorry

/-- The radius-2 arc about `i` over the ring arc's angles misses the closure of the inner colour's class. -/
theorem cuspFrag_radiusTwo_disjoint :
    Disjoint (ArcMap.radiusTwoArc I (-(π / 2) + 1 / 10) (-(π / 2) + 2 / 5)) (closure (ArcMap.cuspFrag.region 0)) := by
  sorry

/-- **The model of `bend_away_whole`**: the bend applied to the cusp fragment's ring arc. -/
theorem cuspFrag_bend_away : ∃ F' : ArcMap 2, F'.Valid ∧
    ∀ θ ∈ Ioo (-(π / 2) + 1 / 10) (-(π / 2) + 2 / 5), ¬ F'.OnRingArc I (ringPt I θ) := by
  obtain ⟨F', h1, -, -, h2, -⟩ := ArcMap.bend_away_whole ArcMap.cuspFrag_valid cuspFrag_isRingArc
    (by simp [cuspFrag_coloursAt_I]) cuspFrag_radiusTwo_disjoint one_pos
  exact ⟨F', h1, h2⟩

/-- **The model of `bend_toward`**: the bend applied to the same arc (the outer colour is not carried at the centre either). -/
theorem cuspFrag_bend_toward : ∃ F' : ArcMap 2, F'.Valid ∧
    ∀ θ ∈ Ioo (-(π / 2) + 1 / 10) (-(π / 2) + 2 / 5), ¬ F'.OnRingArc I (ringPt I θ) := by
  obtain ⟨F', h1, -, -, h2, -⟩ := ArcMap.bend_toward ArcMap.cuspFrag_valid cuspFrag_isRingArc
    (by simp [cuspFrag_coloursAt_I]) one_pos
  exact ⟨F', h1, h2⟩

/-! ## The outward bend's plane map -/

/-- The centre of `awayModel`'s unit arc. -/
noncomputable def awayP : ℂ := -3 / 5 + 3 / 10 * I

/-- The painted set of `awayModel`: the brick `(0, 4/5) × (0, 3/5)` inside `B(P, 1)` and the brick `(4/5, 8/5) × (0, 3/5)` outside
`B̄(P, 2)`. -/
noncomputable def awayW : Set ℂ :=
  ({z | 0 < z.re ∧ z.re < 4 / 5 ∧ 0 < z.im ∧ z.im < 3 / 5} ∩ ball awayP 1) ∪
    ({z | 4 / 5 < z.re ∧ z.re < 8 / 5 ∧ 0 < z.im ∧ z.im < 3 / 5} \ closedBall awayP 2)

/-- The new arcs of `awayModel`: the arcs of the circles of radii `1` and `2` about `P` across their bricks, wall to wall. -/
noncomputable def awayArcs : Set Arc :=
  {Arc.circ awayP 1 (-(Real.arcsin (3 / 10))) (Real.arcsin (3 / 10)),
    Arc.circ awayP 2 (-(Real.arcsin (3 / 20))) (Real.arcsin (3 / 20))}

theorem awayArcs_nondegenerate : ∀ a ∈ awayArcs, a.Nondegenerate := by
  sorry

theorem awayArcs_finite : awayArcs.Finite := (finite_singleton _).insert _

theorem frontier_awayW_subset : frontier awayW ⊆ ⋃ a ∈ (brickBase 8 (by norm_num)).arcs ∪ awayArcs, a.carrier := by
  sorry

/-- **The outward bend's plane map** (FS131-KA1 § 5): the brick map in eight colours with `7` painted on `awayW`. -/
noncomputable def awayModel : ArcMap 8 :=
  (brickBase 8 (by norm_num)).paint awayW awayArcs awayArcs_nondegenerate awayArcs_finite frontier_awayW_subset (fun _ => 7)
    (fun _ _ _ => Filter.Eventually.of_forall fun _ => rfl)

/-- **The hypotheses of `bend_away_part`, at once**: `awayModel` is a valid map of the plane; the arc of `ω(P)` over
`[−arcsin(3/10), arcsin(3/10)]` is a ring arc with inner colour `7` and outer colour `0`; `7` is not carried at `P`; and near each interior
point of the arc `Γ` lies on `ω(P)`. -/
theorem awayModel_hyps : awayModel.Valid ∧ awayModel.IsPlaneMap ∧
    awayModel.IsRingArc awayP (-(Real.arcsin (3 / 10))) (Real.arcsin (3 / 10)) 7 0 ∧ (7 : Fin 8) ∉ awayModel.coloursAt awayP ∧
    ∀ θ ∈ Ioo (-(Real.arcsin (3 / 10))) (Real.arcsin (3 / 10)), ∃ r > 0, awayModel.Γ ∩ ball (ringPt awayP θ) r ⊆ sphere awayP 1 := by
  sorry

/-- **What `awayModel` exercises**: the radius-2 contacts of the arc's inner colour are the interval `[−arcsin(3/20), arcsin(3/20)]`,
strictly inside the arc's angles — two gaps and a contact piece. -/
theorem awayModel_r2Contacts : awayModel.r2Contacts awayP (-(Real.arcsin (3 / 10))) (Real.arcsin (3 / 10)) 7 =
    Icc (-(Real.arcsin (3 / 20))) (Real.arcsin (3 / 20)) := by
  sorry

end HadwigerNelson.Plane
