import Proofs.HadwigerNelson.Plane.ValidMap.CollarMap
import Proofs.HadwigerNelson.Plane.ValidMap.LensOut

/-!
# The outward collar bend's map (FS131-KA1's skeleton; mirror of `Plane/ValidMap/CollarMap`)

The outward collar's fit to the map (`CollarFitOut`), its homeomorphism, the bent map `CollarFitOut.map` and the geometric clauses read
off it (`map_Γ`, `map_lens`, `map_agreesOff`, `map_valid`): `plans/FS131-bendaway-kernel-plan.md` § 3, lane G. The collar is the toward
bend's set `collarK P θ₁ θ₂ R' R''`; only the lens differs — outside `ω(P)`, bounded by the circles of radius `R > 1` tangent to
`ω(P)` at the ends, and recoloured with the **inner** colour.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

section CollarOut

variable {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} {ε R' R R'' : ℝ}

/-- **The outward collar fits the map**: `CollarFit` with the lens radius above `1` (`1/2 < R' < 1 < R < R''`, and `R ≤ 9/8` so that
two lens points are closer than `1`, `dist_lt_one_of_thin`) and the open lens — now outside `ω(P)` — clear for the **inner** colour.
Inhabitant: `exists_collarFitOut` (`Plane/ValidMap/BendGap`), at any map satisfying `bend_away_gap`'s hypotheses; a model map for those
is owed with the away bend's (the plan's § 5). -/
structure CollarFitOut (F : ArcMap k) (P : ℂ) (θ₁ θ₂ : ℝ) (c c' : Fin k) (ε R' R R'' : ℝ) : Prop where
  /-- The arc is a constant-sided unit arc. -/
  ring : F.IsRingArc P θ₁ θ₂ c c'
  /-- It is at most `60°` long (`l60_le`). -/
  short : θ₂ - θ₁ ≤ π / 3
  /-- The radii. -/
  params : 1 / 2 < R' ∧ R' < 1 ∧ 1 < R ∧ R < R'' ∧ R ≤ 9 / 8
  /-- Near each interior point of the arc, `Γ` is `ω(P)`. -/
  free_open : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1
  /-- The collar lies within `ε` of the arc. -/
  sub_thick : collarK P θ₁ θ₂ R' R'' ⊆ thickening ε (ringArc P θ₁ θ₂)
  /-- The collar lies in the domain. -/
  sub_dom : collarK P θ₁ θ₂ R' R'' ⊆ F.dom
  /-- The collar meets `Γ` only on the arc. -/
  free : F.Γ ∩ collarK P θ₁ θ₂ R' R'' ⊆ ringArc P θ₁ θ₂
  /-- The open lens is clear for the inner colour. -/
  clear : ∀ z ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioo 1 (outerProf θ₁ θ₂ R θ)), F.IsClear c z

/-- The outward collar's profiles are push profiles. -/
theorem CollarFitOut.pushOutProfiles (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    PushOutProfiles θ₁ θ₂ (lensProf θ₁ θ₂ R') (outerProf θ₁ θ₂ R) (outerProf θ₁ θ₂ R'') :=
  pushOutProfiles_collar hfit.params.1 hfit.params.2.1 hfit.params.2.2.1 hfit.params.2.2.2.1 hfit.ring.1 hfit.short

/-- **The outward collar's homeomorphism**: the radial push about `P` across the collar, sending the arc onto the outward lens curve. -/
noncomputable def CollarFitOut.homeo (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') : ℂ ≃ₜ ℂ :=
  pushOutHomeo P θ₁ θ₂ (lensProf θ₁ θ₂ R') (outerProf θ₁ θ₂ R) (outerProf θ₁ θ₂ R'') hfit.pushOutProfiles

/-- The homeomorphism keeps the domain (mirror of `CollarFit.homeo_image_dom`). **Open — `sorry`** (plan § 3, child G5). -/
theorem CollarFitOut.homeo_image_dom (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') : hfit.homeo '' F.dom = F.dom := by
  sorry

/-- **The outward bent map's arcs**: `F`'s with the open arc cut out, and the outward lens boundary's two arcs. -/
def collarOutArcs (F : ArcMap k) (P : ℂ) (θ₁ θ₂ R : ℝ) : Set Arc :=
  F.cutArcs P θ₁ θ₂ ∪ {collarOutArcA P θ₁ θ₂ R, collarOutArcB P θ₁ θ₂ R}

/-- The outward bent map's arcs are non-degenerate (mirror of `CollarFit.collarArcs_nondegenerate`). **Open — `sorry`** (child G5). -/
theorem CollarFitOut.collarOutArcs_nondegenerate (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    ∀ a ∈ collarOutArcs F P θ₁ θ₂ R, a.Nondegenerate := by
  sorry

/-- The outward bent map's arcs are locally finite on the domain (the cut's, and two more). -/
theorem collarOutArcs_locallyFinite :
    ∀ x ∈ F.dom, ∃ t ∈ 𝓝 x, {a | a ∈ collarOutArcs F P θ₁ θ₂ R ∧ (a.carrier ∩ t).Nonempty}.Finite := by
  intro x hx
  obtain ⟨t, ht, hfin⟩ := F.cutArcs_locallyFinite (P := P) (θ₁ := θ₁) (θ₂ := θ₂) x hx
  refine ⟨t, ht, (hfin.union ((Set.finite_singleton (collarOutArcB P θ₁ θ₂ R)).insert (collarOutArcA P θ₁ θ₂ R))).subset ?_⟩
  rintro b ⟨hb | hb, hbt⟩
  · exact Or.inl ⟨hb, hbt⟩
  · exact Or.inr hb

/-- The outward bent map's arcs inside the domain are the homeomorphism's image of `Γ` (mirror of `CollarFit.collarArcs_Γ`, through
`collarOutArcs_carrier` and the mirror of `homeo_image_Γ`). **Open — `sorry`** (child G5). -/
theorem CollarFitOut.collarOutArcs_Γ (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    F.dom ∩ ⋃ a ∈ collarOutArcs F P θ₁ θ₂ R, a.carrier = hfit.homeo '' F.Γ := by
  sorry

/-- **The outward bent map**: `F`'s image under the outward collar's homeomorphism, with the arcs `collarOutArcs`. -/
noncomputable def CollarFitOut.map (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') : ArcMap k :=
  F.pushforward hfit.homeo hfit.homeo_image_dom (collarOutArcs F P θ₁ θ₂ R) hfit.collarOutArcs_nondegenerate
    collarOutArcs_locallyFinite hfit.collarOutArcs_Γ

/-- Spec: the outward bent map's arcs are the cut and the two lens arcs, its domain `F`'s. -/
example (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    hfit.map.arcs = F.cutArcs P θ₁ θ₂ ∪ {collarOutArcA P θ₁ θ₂ R, collarOutArcB P θ₁ θ₂ R} ∧ hfit.map.dom = F.dom :=
  ⟨rfl, rfl⟩

/-- **The outward bent map's `Γ`**: `F`'s off the open arc, and the outward lens boundary (mirror of `CollarFit.map_Γ`).
**Open — `sorry`** (child G5). -/
theorem CollarFitOut.map_Γ (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    hfit.map.Γ = (F.Γ \ ringPt P '' Ioo θ₁ θ₂) ∪ lensOutCurve P θ₁ θ₂ R := by
  sorry

/-- **The outward lens is the inner colour's**: the lens with the open arc is interior in the bent map, of colour `c` (it is `h`'s
image of part of the inner collar and of the arc... of the inner collar `{a ≤ t < 1}` stretched onto `{a ≤ t < l}`; mirror of
`CollarFit.map_lens` with `kin_subset`). **Open — `sorry`** (child G6). -/
theorem CollarFitOut.map_lens (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {z : ℂ} (hz : z ∈ lensOutSet P θ₁ θ₂ R) :
    z ∈ hfit.map.interiorPts ∧ hfit.map.col z = c := by
  sorry

/-- **The outward bent map agrees with `F` off the closed lens** (mirror of `CollarFit.map_agreesOff`). **Open — `sorry`** (child G6). -/
theorem CollarFitOut.map_agreesOff (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    hfit.map.AgreesOff F (lensOutSet P θ₁ θ₂ R ∪ lensOutCurve P θ₁ θ₂ R) := by
  sorry

/-- **The outward bent map is valid** (mirror of `CollarFit.map_valid`): the closed lens's interior points are the lens, of colour `c`,
clear for `c` in `F` (`clear` off `ω(P)`, `ne1_region` on the open arc), and no two of them are `1` apart — by `dist_lt_one_of_thin`
with `κ = R − 1 ≤ 1/8` and `tangRad_sub_one_le`, **not** by `dist_lt_one_of_mem_polarSet`. **Open — `sorry`** (child G7). -/
theorem CollarFitOut.map_valid (hF : F.Valid) (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') : hfit.map.Valid := by
  sorry

end CollarOut

end ArcMap

end HadwigerNelson.Plane
