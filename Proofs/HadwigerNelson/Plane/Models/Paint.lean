import Proofs.HadwigerNelson.Plane.ValidMap.OpenMove
import Proofs.HadwigerNelson.Plane.ValidMap.BaseSteps
import Proofs.HadwigerNelson.Plane.Woodall.Steps

/-!
# The models' construction: a plane map with spare colours, painted on small sets (FS131-KM1, skeleton)

`plans/FS131-models-kernel-plan.md` § 2. Every model of this lane is one object: the seven-colour brick map read in more colours
(`brickBase`), with a picture painted on small open sets, each inside one brick (`ArcMap.paint`), in colours the bricks do not use — so
validity is a statement about the picture alone (`paint_valid`), the map is a map of the plane (`paint_isPlaneMap`, hence `Covers v 1` at
every `v`), and near a planted point the interior points are a ball off the picture's arcs (`interiorPts_paint`), whose sectors are read off a
partition (`isSector_iff_of_partition`, `encard_sectorsOf_of_partition`: `Plane/ValidMap/Sectors`, `Surgery`).

* **Relabelling** (`ArcMap.relabel`): the colours pushed along `f`; with `f` injective the classes are the old ones.
* **Painting** (`ArcMap.paint`): `ArcMap.recolour` (`Plane/Woodall/Merge`) with a colouring `g` in place of one colour, and the frontier of
  the painted set allowed on the old arcs as well as the new.
* **The base** (`brickBase k`): `sevenBrickMap` in `Fin k`, `7 ≤ k`; the planted points `plantPt = 2/5 + (3/10) i` (the centre of the brick
  `(0, 4/5) × (0, 3/5)`), `plantPt ± i` (FS131-E7 § 6.1) and the tangent point `plantPt + (3/5 + (4/5) i)`.
* **Horn patches** (`hornArcs`, `frontier_hornSet_subset`): the boundary of a horn set as three arcs; **the fan** (`fanRest`,
  `ball_diff_fan`, `isSector_fan_iff`): the sectors of a ball cut by tangent arcs of increasing curvatures along one ray.

**Inhabitants.** `relabel` and `paint` are defined for every arc map; the base is `sevenBrickMap`'s (valid, of the plane, Condition 5); the
models built on them are `Plane/Models/Moves`, `Stuck`, `Bends`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k k' : ℕ}

/-! ## Relabelling the colours -/

/-- **The map with its colours relabelled along `f`**: the same domain and arcs, the colour `f (F.col z)`. -/
def relabel (F : ArcMap k) (f : Fin k → Fin k') : ArcMap k' where
  dom := F.dom
  isOpen_dom := F.isOpen_dom
  arcs := F.arcs
  nondegenerate := F.nondegenerate
  locallyFinite := F.locallyFinite
  col := fun z => f (F.col z)
  locallyConstant := fun x hx hΓ => (F.locallyConstant x hx hΓ).mono fun _ hy => congrArg f hy

/-- Relabelling keeps the interior points. -/
theorem relabel_interiorPts (F : ArcMap k) (f : Fin k → Fin k') : (F.relabel f).interiorPts = F.interiorPts := rfl

/-- Relabelling keeps `Γ`. -/
theorem relabel_Γ (F : ArcMap k) (f : Fin k → Fin k') : (F.relabel f).Γ = F.Γ := rfl

/-- Relabelling keeps a map of the plane one. -/
theorem relabel_isPlaneMap {F : ArcMap k} (hP : F.IsPlaneMap) (f : Fin k → Fin k') : (F.relabel f).IsPlaneMap := hP

/-- Under an injective relabelling the class of `f j` is the class of `j`. -/
theorem relabel_region {F : ArcMap k} {f : Fin k → Fin k'} (hf : Function.Injective f) (j : Fin k) :
    (F.relabel f).region (f j) = F.region j := by
  ext z
  show z ∈ F.interiorPts ∧ f (F.col z) = f j ↔ z ∈ F.interiorPts ∧ F.col z = j
  exact and_congr_right fun _ => hf.eq_iff

/-- A colour outside the range of the relabelling has an empty class. -/
theorem relabel_region_eq_empty {F : ArcMap k} {f : Fin k → Fin k'} {j : Fin k'} (hj : j ∉ range f) :
    (F.relabel f).region j = ∅ := by
  ext z
  simp only [mem_empty_iff_false, iff_false]
  rintro ⟨-, hz⟩
  exact hj ⟨F.col z, hz⟩

/-- An injective relabelling keeps validity. -/
theorem relabel_valid {F : ArcMap k} (hF : F.Valid) {f : Fin k → Fin k'} (hf : Function.Injective f) : (F.relabel f).Valid :=
  fun x hx y hy hxy h => hF x hx y hy hxy (hf h)

/-- Relabelling keeps Condition 5 (it reads the arcs and the domain only). -/
theorem relabel_condition5 {F : ArcMap k} (h5 : F.Condition5) (f : Fin k → Fin k') : (F.relabel f).Condition5 := h5

/-! ## Painting a set -/

/-- **Painting** `W` with the colouring `g`: the arcs of `F` and the finitely many arcs `B`; the colour `g` on `W` and `F`'s elsewhere. The
frontier of `W` lies on the arcs, old or new, and `g` is locally constant on `W` off them. `recolour` is the case of a constant `g` with the
frontier on the new arcs. -/
noncomputable def paint (F : ArcMap k) (W : Set ℂ) (B : Set Arc) (hB : ∀ a ∈ B, a.Nondegenerate) (hBf : B.Finite)
    (hW : frontier W ⊆ ⋃ a ∈ F.arcs ∪ B, a.carrier) (g : ℂ → Fin k)
    (hg : ∀ x ∈ W, x ∉ ⋃ a ∈ F.arcs ∪ B, a.carrier → ∀ᶠ y in 𝓝 x, g y = g x) : ArcMap k where
  dom := F.dom
  isOpen_dom := F.isOpen_dom
  arcs := F.arcs ∪ B
  nondegenerate := fun a ha => ha.elim (F.nondegenerate a) (hB a)
  locallyFinite := fun x hx => by
    obtain ⟨t, ht, hfin⟩ := F.locallyFinite x hx
    refine ⟨t, ht, (hfin.union hBf).subset ?_⟩
    rintro a ⟨ha | ha, hne⟩
    · exact Or.inl ⟨ha, hne⟩
    · exact Or.inr ha
  col := by classical exact fun z => if z ∈ W then g z else F.col z
  locallyConstant := by
    classical
    intro x hx hxΓ
    have hxF : x ∉ ⋃ a ∈ F.arcs, a.carrier := fun h => hxΓ (by
      obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp h
      exact mem_iUnion₂.mpr ⟨a, Or.inl ha, hxa⟩)
    have hxW : x ∉ frontier W := fun h => hxΓ (hW h)
    by_cases hx' : x ∈ W
    · have hint : x ∈ interior W := by
        by_contra hni
        exact hxW ⟨subset_closure hx', hni⟩
      filter_upwards [mem_interior_iff_mem_nhds.mp hint, hg x hx' hxΓ] with y hy hgy
      simp [hy, hx', hgy]
    · have hcl : x ∉ closure W := fun h => hxW ⟨h, fun hi => hx' (interior_subset hi)⟩
      filter_upwards [isClosed_closure.isOpen_compl.mem_nhds hcl, F.locallyConstant x hx hxF] with y hy hyc
      have hyW : y ∉ W := fun h => hy (subset_closure h)
      simp [hyW, hx', hyc]

variable {F : ArcMap k} {W : Set ℂ} {B : Set Arc} {hB : ∀ a ∈ B, a.Nondegenerate} {hBf : B.Finite}
  {hW : frontier W ⊆ ⋃ a ∈ F.arcs ∪ B, a.carrier} {g : ℂ → Fin k}
  {hg : ∀ x ∈ W, x ∉ ⋃ a ∈ F.arcs ∪ B, a.carrier → ∀ᶠ y in 𝓝 x, g y = g x}

/-- Painting keeps the domain, so a map of the plane stays one. -/
theorem paint_isPlaneMap (hP : F.IsPlaneMap) : (F.paint W B hB hBf hW g hg).IsPlaneMap := hP

/-- The colour of a painted point. -/
theorem paint_col_of_mem {z : ℂ} (hz : z ∈ W) : (F.paint W B hB hBf hW g hg).col z = g z := by
  classical
  show (if z ∈ W then g z else F.col z) = g z
  rw [if_pos hz]

/-- The colour of a point off the painted set. -/
theorem paint_col_of_not_mem {z : ℂ} (hz : z ∉ W) : (F.paint W B hB hBf hW g hg).col z = F.col z := by
  classical
  show (if z ∈ W then g z else F.col z) = F.col z
  rw [if_neg hz]

/-- **The interior points of the painted map** are `F`'s off the new arcs. -/
theorem interiorPts_paint :
    (F.paint W B hB hBf hW g hg).interiorPts = F.interiorPts \ ⋃ a ∈ B, a.carrier := by
  ext z
  show z ∈ F.dom ∧ z ∉ ⋃ a ∈ F.arcs ∪ B, a.carrier ↔ (z ∈ F.dom ∧ z ∉ ⋃ a ∈ F.arcs, a.carrier) ∧ z ∉ ⋃ a ∈ B, a.carrier
  rw [biUnion_union, mem_union, not_or, and_assoc]

/-- **The classes of the painted map**: `F`'s class off `W`, and the points of `W` painted `j`, both off the new arcs. -/
theorem region_paint (j : Fin k) :
    (F.paint W B hB hBf hW g hg).region j =
      ((F.region j \ W) ∪ (F.interiorPts ∩ W ∩ g ⁻¹' {j})) \ ⋃ a ∈ B, a.carrier := by
  sorry

/-- **Validity of a painting** is a statement about `W`: no unit pair of one painted colour inside `W`, and none between a point of `W` and
`F`'s class of its painted colour off `W`. With colours `F` does not use the second is empty (`relabel_region_eq_empty`). -/
theorem paint_valid (hF : F.Valid) (hWW : ∀ x ∈ W, ∀ y ∈ W, dist x y = 1 → g x ≠ g y)
    (hWc : ∀ x ∈ W, ∀ y ∈ F.region (g x), y ∉ W → dist x y ≠ 1) : (F.paint W B hB hBf hW g hg).Valid := by
  sorry

/-- **Condition 5 is kept** when no new arc meets a unit circle in infinitely many points. -/
theorem paint_condition5 (h5 : F.Condition5) (hB5 : ∀ a ∈ B, ∀ p, (a.carrier ∩ sphere p 1).Finite) :
    (F.paint W B hB hBf hW g hg).Condition5 := by
  rintro a (ha | ha) p
  · exact h5 a ha p
  · exact (hB5 a ha p).subset fun z hz => ⟨hz.1.1, hz.2⟩

end ArcMap

/-! ## The base: the brick map in `k` colours, and the planted points -/

/-- **The brick map in `k ≥ 7` colours**: `sevenBrickMap` with its colours read in `Fin k`; the colours `7, …, k − 1` are spare. -/
noncomputable def brickBase (k : ℕ) (h : 7 ≤ k) : ArcMap k := sevenBrickMap.relabel (Fin.castLE h)

/-- The base is valid. -/
theorem brickBase_valid (k : ℕ) (h : 7 ≤ k) : (brickBase k h).Valid :=
  ArcMap.relabel_valid sevenBrickMap_valid (Fin.castLE_injective h)

/-- The base is a map of the plane. -/
theorem brickBase_isPlaneMap (k : ℕ) (h : 7 ≤ k) : (brickBase k h).IsPlaneMap :=
  ArcMap.relabel_isPlaneMap sevenBrickMap_isPlaneMap _

/-- The base has Condition 5. -/
theorem brickBase_condition5 (k : ℕ) (h : 7 ≤ k) : (brickBase k h).Condition5 :=
  ArcMap.relabel_condition5 sevenBrickMap_condition5 _

/-- A spare colour has an empty class in the base. -/
theorem brickBase_region_spare {k : ℕ} (h : 7 ≤ k) {j : Fin k} (hj : 7 ≤ (j : ℕ)) : (brickBase k h).region j = ∅ := by
  refine ArcMap.relabel_region_eq_empty ?_
  rintro ⟨i, rfl⟩
  have := i.isLt
  simp only [Fin.val_castLE] at hj
  omega

/-- **A point strictly inside a brick is an interior point of the base**: the brick of column `c` and row `r` is
`(2r/5 + 4c/5, 2r/5 + 4(c + 1)/5) × (3r/5, 3(r + 1)/5)`. (Wave 5's `Plane/ValidMap/BrickMap` states this with `brickCell`; this form needs
nothing that is not on `main`.) -/
theorem brickBase_mem_interiorPts {k : ℕ} (h : 7 ≤ k) {c r : ℤ} {z : ℂ}
    (hre : 2 / 5 * (r : ℝ) + 4 / 5 * c < z.re ∧ z.re < 2 / 5 * (r : ℝ) + 4 / 5 * (c + 1))
    (him : 3 / 5 * (r : ℝ) < z.im ∧ z.im < 3 / 5 * ((r : ℝ) + 1)) : z ∈ (brickBase k h).interiorPts := by
  sorry

/-- **Two points strictly inside one brick have one base colour.** -/
theorem brickBase_col_eq {k : ℕ} (h : 7 ≤ k) {c r : ℤ} {z z' : ℂ}
    (hre : 2 / 5 * (r : ℝ) + 4 / 5 * c < z.re ∧ z.re < 2 / 5 * (r : ℝ) + 4 / 5 * (c + 1))
    (him : 3 / 5 * (r : ℝ) < z.im ∧ z.im < 3 / 5 * ((r : ℝ) + 1))
    (hre' : 2 / 5 * (r : ℝ) + 4 / 5 * c < z'.re ∧ z'.re < 2 / 5 * (r : ℝ) + 4 / 5 * (c + 1))
    (him' : 3 / 5 * (r : ℝ) < z'.im ∧ z'.im < 3 / 5 * ((r : ℝ) + 1)) : (brickBase k h).col z = (brickBase k h).col z' := by
  sorry

/-- **The base colour of the brick `(0, 4/5) × (0, 3/5)` is `0`** (the corner's upper right cell, `sevenBrick_corner_col`). -/
theorem brickBase_col_zero {k : ℕ} (h : 7 ≤ k) {z : ℂ} (hre : 0 < z.re ∧ z.re < 4 / 5) (him : 0 < z.im ∧ z.im < 3 / 5) :
    ((brickBase k h).col z : ℕ) = 0 := by
  sorry

/-- The planted vertex: the centre `2/5 + (3/10) i` of the brick `(0, 4/5) × (0, 3/5)`. -/
noncomputable def plantPt : ℂ := 2 / 5 + 3 / 10 * I

/-- The direction `3/5 + (4/5) i` of the tangent point: a unit vector with rational coordinates, at a positive angle from the axis. -/
noncomputable def plantDir : ℂ := 3 / 5 + 4 / 5 * I

/-- The tangent disc: radius `1/20`, inside `B(plantPt, 1)` and touching `ω(plantPt)` at `plantPt + plantDir`; it lies in the brick
`(2/5, 6/5) × (3/5, 6/5)`. -/
noncomputable def tangentDisc : Set ℂ := ball (plantPt + 19 / 20 * plantDir) (1 / 20)

/-- The upper pole `N = plantPt + i` of the planted vertex's frame along `e 0`: a point of the brick `(0, 4/5) × (6/5, 9/5)`. -/
noncomputable def plantN : ℂ := plantPt + I

/-- The lower pole `S′ = plantPt − i`: a point of the brick `(0, 4/5) × (−6/5, −3/5)`. -/
noncomputable def plantS : ℂ := plantPt - I

/-- `plantDir` is a unit vector. -/
theorem norm_plantDir : ‖plantDir‖ = 1 := by
  sorry

/-- The tangent disc lies in the open unit disc about the planted vertex, and its closure meets the unit circle at one point. -/
theorem tangentDisc_subset_ball : tangentDisc ⊆ ball plantPt 1 ∧
    closure tangentDisc ∩ sphere plantPt 1 = {plantPt + plantDir} := by
  sorry

/-! ## Horn patches and the fan -/

/-- **The boundary of a horn set**, as three arcs: the two tangent arcs out to `ρ` and the piece of the circle of radius `ρ` between their
ends (the end of the tangent arc of curvature `κ` is at the angle `α + arcsin(κρ/2)`). -/
noncomputable def hornArcs (v : ℂ) (α κ₁ κ₂ ρ : ℝ) : Set Arc :=
  {germArc v α κ₁ ρ, germArc v α κ₂ ρ, Arc.circ v ρ (α + Real.arcsin (κ₁ * ρ / 2)) (α + Real.arcsin (κ₂ * ρ / 2))}

/-- The three arcs have positive length. -/
theorem hornArcs_nondegenerate (v : ℂ) (α : ℝ) {κ₁ κ₂ ρ : ℝ} (hρ : 0 < ρ) (h12 : κ₁ < κ₂) (h1 : |κ₁| * ρ ≤ 1)
    (h2 : |κ₂| * ρ ≤ 1) : ∀ a ∈ hornArcs v α κ₁ κ₂ ρ, a.Nondegenerate := by
  sorry

/-- The three arcs are finitely many. -/
theorem hornArcs_finite (v : ℂ) (α κ₁ κ₂ ρ : ℝ) : (hornArcs v α κ₁ κ₂ ρ).Finite := by
  unfold hornArcs
  exact ((finite_singleton _).insert _).insert _

/-- **The frontier of a horn set lies on its three arcs.** -/
theorem frontier_hornSet_subset (v : ℂ) (α : ℝ) {κ₁ κ₂ ρ : ℝ} (hρ : 0 < ρ) (h12 : κ₁ < κ₂) (h1 : |κ₁| * ρ ≤ 1)
    (h2 : |κ₂| * ρ ≤ 1) : frontier (hornSet v α κ₁ κ₂ ρ) ⊆ ⋃ a ∈ hornArcs v α κ₁ κ₂ ρ, a.carrier := by
  sorry

/-- The arcs of a horn's boundary lie in the closed disc of its radius. -/
theorem hornArcs_carrier_subset (v : ℂ) (α : ℝ) {κ₁ κ₂ ρ : ℝ} (hρ : 0 < ρ) (h1 : |κ₁| * ρ ≤ 1) (h2 : |κ₂| * ρ ≤ 1) :
    ⋃ a ∈ hornArcs v α κ₁ κ₂ ρ, a.carrier ⊆ closedBall v ρ := by
  sorry

/-- **The rest of a ball off a fan**: the points of `B(v, r)` behind the vertex, below the fan's lowest arc or above its highest. -/
def fanRest (v : ℂ) (α κlo κhi r : ℝ) : Set ℂ :=
  {z | dist z v < r ∧ (frameX v α z < 0 ∨ TanBelow v α κlo z ∨ TanAbove v α κhi z)}

/-- The rest is open. -/
theorem isOpen_fanRest (v : ℂ) (α κlo κhi r : ℝ) : IsOpen (fanRest v α κlo κhi r) := by
  sorry

/-- **The rest is connected** when the fan's lowest curvature is negative and its highest positive: it is the union of three convex sets
(a half-disc and two lenses), the half-disc meeting both lenses. -/
theorem isPreconnected_fanRest (v : ℂ) (α : ℝ) {κlo κhi r : ℝ} (hlo : κlo < 0) (hhi : 0 < κhi) (hr : 0 < r) :
    IsPreconnected (fanRest v α κlo κhi r) := by
  sorry

/-- **A ball cut by a fan** of `m + 2` tangent arcs of increasing curvatures along one ray: off the arcs it is the rest and the `m + 1`
horn sets between consecutive arcs. -/
theorem ball_diff_fan {m : ℕ} (κ : Fin (m + 2) → ℝ) (hκ : StrictMono κ) (v : ℂ) (α : ℝ) {ρ r : ℝ} (hr : 0 < r) (hrρ : r ≤ ρ)
    (hκρ : ∀ i, |κ i| * ρ ≤ 1) :
    ball v r \ ⋃ i, (germArc v α (κ i) ρ).carrier =
      fanRest v α (κ 0) (κ (Fin.last (m + 1))) r ∪ ⋃ i : Fin (m + 1), hornSet v α (κ i.castSucc) (κ i.succ) r := by
  sorry

/-- **The sectors of a fan**: a map whose interior points in `B(v, r)` are the ball off a fan of tangent arcs, the lowest curvature
negative and the highest positive, has as its sectors at radius `r` the rest and the `m + 1` horn sets. -/
theorem isSector_fan_iff {k : ℕ} {G : ArcMap k} {m : ℕ} (κ : Fin (m + 2) → ℝ) (hκ : StrictMono κ) {v : ℂ} {α ρ r : ℝ} (hr : 0 < r)
    (hrρ : r ≤ ρ) (hκρ : ∀ i, |κ i| * ρ ≤ 1) (hlo : κ 0 < 0) (hhi : 0 < κ (Fin.last (m + 1)))
    (hI : G.interiorPts ∩ ball v r = ball v r \ ⋃ i, (germArc v α (κ i) ρ).carrier) {S : Set ℂ} :
    G.IsSector v r S ↔ S = fanRest v α (κ 0) (κ (Fin.last (m + 1))) r ∨
      ∃ i : Fin (m + 1), S = hornSet v α (κ i.castSucc) (κ i.succ) r := by
  sorry

/-- **The rest is no horn set**: it approaches `v` along an open interval of directions. -/
theorem fanRest_ne_hornSet (v : ℂ) (α : ℝ) {κlo κhi r : ℝ} (hr : 0 < r) (α' κ₁ κ₂ : ℝ) :
    fanRest v α κlo κhi r ≠ hornSet v α' κ₁ κ₂ r := by
  sorry

end HadwigerNelson.Plane
