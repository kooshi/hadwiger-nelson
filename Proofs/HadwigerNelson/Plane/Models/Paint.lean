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
  classical
  ext z
  have hreg : z ∈ (F.paint W B hB hBf hW g hg).region j ↔
      z ∈ (F.paint W B hB hBf hW g hg).interiorPts ∧ (F.paint W B hB hBf hW g hg).col z = j := Iff.rfl
  rw [hreg, interiorPts_paint]
  by_cases hz : z ∈ W
  · rw [paint_col_of_mem hz]
    constructor
    · rintro ⟨⟨hzF, hzB⟩, hgz⟩
      exact ⟨Or.inr ⟨⟨hzF, hz⟩, hgz⟩, hzB⟩
    · rintro ⟨h | h, hzB⟩
      · exact absurd hz h.2
      · exact ⟨⟨h.1.1, hzB⟩, h.2⟩
  · rw [paint_col_of_not_mem hz]
    constructor
    · rintro ⟨⟨hzF, hzB⟩, hcz⟩
      exact ⟨Or.inl ⟨⟨hzF, hcz⟩, hz⟩, hzB⟩
    · rintro ⟨h | h, hzB⟩
      · exact ⟨⟨h.1.1, hzB⟩, h.1.2⟩
      · exact absurd h.1.2 hz

/-- **Validity of a painting** is a statement about `W`, read at the points off the new arcs: no unit pair of one painted colour inside
`W`, and none between a point of `W` and `F`'s class of its painted colour off `W`. With colours `F` does not use the second is empty
(`relabel_region_eq_empty`). -/
theorem paint_valid (hF : F.Valid)
    (hWW : ∀ x ∈ W, ∀ y ∈ W, x ∉ ⋃ a ∈ B, a.carrier → y ∉ ⋃ a ∈ B, a.carrier → dist x y = 1 → g x ≠ g y)
    (hWc : ∀ x ∈ W, x ∉ ⋃ a ∈ B, a.carrier → ∀ y ∈ F.region (g x), y ∉ W → dist x y ≠ 1) :
    (F.paint W B hB hBf hW g hg).Valid := by
  classical
  intro x hx y hy hxy
  rw [interiorPts_paint] at hx hy
  by_cases h1 : x ∈ W <;> by_cases h2 : y ∈ W
  · rw [paint_col_of_mem h1, paint_col_of_mem h2]
    exact hWW x h1 y h2 hx.2 hy.2 hxy
  · rw [paint_col_of_mem h1, paint_col_of_not_mem h2]
    intro hc
    exact hWc x h1 hx.2 y ⟨hy.1, hc.symm⟩ h2 hxy
  · rw [paint_col_of_not_mem h1, paint_col_of_mem h2]
    intro hc
    exact hWc y h2 hy.2 x ⟨hx.1, hc⟩ h1 (by rw [dist_comm]; exact hxy)
  · rw [paint_col_of_not_mem h1, paint_col_of_not_mem h2]
    exact hF x hx.1 y hy.1 hxy

/-- **Condition 5 is kept** when no new arc meets a unit circle in infinitely many points. -/
theorem paint_condition5 (h5 : F.Condition5) (hB5 : ∀ a ∈ B, ∀ p, (a.carrier ∩ sphere p 1).Finite) :
    (F.paint W B hB hBf hW g hg).Condition5 := by
  rintro a (ha | ha) p
  · exact h5 a ha p
  · exact (hB5 a ha p).subset fun z hz => ⟨hz.1.1, hz.2⟩

/-- **The class of a colour the base does not use** is its painted set, off the new arcs. -/
theorem region_paint_of_region_eq_empty {j : Fin k} (hj : F.region j = ∅) :
    (F.paint W B hB hBf hW g hg).region j = (F.interiorPts ∩ W ∩ g ⁻¹' {j}) \ ⋃ a ∈ B, a.carrier := by
  rw [region_paint, hj, Set.empty_sdiff, empty_union]

/-- **The class of a colour that is not painted only shrinks**: it is the base's class off the painted set and the new arcs. -/
theorem region_paint_subset {j : Fin k} (hj : ∀ x ∈ W, g x ≠ j) :
    (F.paint W B hB hBf hW g hg).region j ⊆ F.region j \ W := by
  rw [region_paint]
  rintro z ⟨h | h, -⟩
  · exact h
  · exact absurd h.2 (hj z h.1.2)

/-- **A point the base map has of colour `j`, in a valid base, is clear for `j` in a painting that does not paint `j`.** -/
theorem isClear_paint_of_mem_region (hF : F.Valid) {j : Fin k} (hj : ∀ x ∈ W, g x ≠ j) {z : ℂ} (hz : z ∈ F.region j) :
    (F.paint W B hB hBf hW g hg).IsClear j z :=
  fun y hy => hF.region_dist_ne_one j z hz y (region_paint_subset hj hy).1

/-- **The interior points of a painting near a fan**: where a ball of base interior points meets the new arcs exactly in a fan of
tangent arcs, the painted map's interior points in the ball are the ball off the fan — the hypothesis of `isSector_fan_iff`. -/
theorem interiorPts_paint_inter_ball {v : ℂ} {r : ℝ} {C : Set ℂ} (hball : ball v r ⊆ F.interiorPts)
    (hC : ∀ z ∈ ball v r, z ∈ ⋃ a ∈ B, a.carrier ↔ z ∈ C) :
    (F.paint W B hB hBf hW g hg).interiorPts ∩ ball v r = ball v r \ C := by
  rw [interiorPts_paint]
  ext z
  constructor
  · rintro ⟨⟨-, hzB⟩, hz⟩
    exact ⟨hz, fun h => hzB ((hC z hz).mpr h)⟩
  · rintro ⟨hz, hzC⟩
    exact ⟨⟨hball hz, fun h => hzC ((hC z hz).mp h)⟩, hz⟩

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

/-- The floors of a point strictly inside the brick of column `c` and row `r`: the row is `r` and the column `c`. -/
theorem brick_floor_eq {c r : ℤ} {z : ℂ}
    (hre : 2 / 5 * (r : ℝ) + 4 / 5 * c < z.re ∧ z.re < 2 / 5 * (r : ℝ) + 4 / 5 * (c + 1))
    (him : 3 / 5 * (r : ℝ) < z.im ∧ z.im < 3 / 5 * ((r : ℝ) + 1)) :
    ⌊z.im / (3 / 5)⌋ = r ∧ ⌊(z.re - 2 / 5 * r) / (4 / 5)⌋ = c := by
  constructor
  · rw [Int.floor_eq_iff]
    constructor
    · rw [le_div_iff₀ (by norm_num)]; linarith [him.1]
    · rw [div_lt_iff₀ (by norm_num)]; linarith [him.2]
  · rw [Int.floor_eq_iff]
    constructor
    · rw [le_div_iff₀ (by norm_num)]; linarith [hre.1]
    · rw [div_lt_iff₀ (by norm_num)]; linarith [hre.2]

/-- No integer lies strictly between two consecutive integers. -/
theorem not_int_between {a n : ℤ} (h1 : (a : ℝ) < n) (h2 : (n : ℝ) < a + 1) : False := by
  have h1' : a < n := by exact_mod_cast h1
  have h2' : n < a + 1 := by exact_mod_cast h2
  omega

/-- **A point strictly inside a brick is an interior point of the base**: the brick of column `c` and row `r` is
`(2r/5 + 4c/5, 2r/5 + 4(c + 1)/5) × (3r/5, 3(r + 1)/5)`. (Wave 5's `Plane/ValidMap/BrickMap` states this with `brickCell`; this form needs
nothing that is not on `main`.) -/
theorem brickBase_mem_interiorPts {k : ℕ} (h : 7 ≤ k) {c r : ℤ} {z : ℂ}
    (hre : 2 / 5 * (r : ℝ) + 4 / 5 * c < z.re ∧ z.re < 2 / 5 * (r : ℝ) + 4 / 5 * (c + 1))
    (him : 3 / 5 * (r : ℝ) < z.im ∧ z.im < 3 / 5 * ((r : ℝ) + 1)) : z ∈ (brickBase k h).interiorPts := by
  obtain ⟨hfr, -⟩ := brick_floor_eq hre him
  refine ⟨mem_univ z, not_mem_sevenBrickArcs (fun n hn => ?_) (fun n hn => ?_)⟩
  · exact not_int_between (a := r) (n := n) (by nlinarith [him.1]) (by nlinarith [him.2])
  · rw [hfr] at hn
    exact not_int_between (a := c) (n := n) (by nlinarith [hre.1]) (by nlinarith [hre.2])

/-- **Two points strictly inside one brick have one base colour.** -/
theorem brickBase_col_eq {k : ℕ} (h : 7 ≤ k) {c r : ℤ} {z z' : ℂ}
    (hre : 2 / 5 * (r : ℝ) + 4 / 5 * c < z.re ∧ z.re < 2 / 5 * (r : ℝ) + 4 / 5 * (c + 1))
    (him : 3 / 5 * (r : ℝ) < z.im ∧ z.im < 3 / 5 * ((r : ℝ) + 1))
    (hre' : 2 / 5 * (r : ℝ) + 4 / 5 * c < z'.re ∧ z'.re < 2 / 5 * (r : ℝ) + 4 / 5 * (c + 1))
    (him' : 3 / 5 * (r : ℝ) < z'.im ∧ z'.im < 3 / 5 * ((r : ℝ) + 1)) : (brickBase k h).col z = (brickBase k h).col z' := by
  obtain ⟨h1, h2⟩ := brick_floor_eq hre him
  obtain ⟨h1', h2'⟩ := brick_floor_eq hre' him'
  show Fin.castLE h (sevenBrickMap.col z) = Fin.castLE h (sevenBrickMap.col z')
  rw [sevenBrick_color_eq h1 h2, sevenBrick_color_eq h1' h2']

/-- **The base colour of the brick `(0, 4/5) × (0, 3/5)` is `0`** (the corner's upper right cell, `sevenBrick_corner_col`). -/
theorem brickBase_col_zero {k : ℕ} (h : 7 ≤ k) {z : ℂ} (hre : 0 < z.re ∧ z.re < 4 / 5) (him : 0 < z.im ∧ z.im < 3 / 5) :
    ((brickBase k h).col z : ℕ) = 0 := by
  obtain ⟨h1, h2⟩ := brick_floor_eq (c := 0) (r := 0) (z := z) (by push_cast; constructor <;> linarith [hre.1, hre.2])
    (by push_cast; constructor <;> linarith [him.1, him.2])
  have h0 : sevenBrick.table (zmodIdx 7 (by norm_num) 0) (zmodIdx 7 (by norm_num) 0) = 0 := by decide
  show ((Fin.castLE h (sevenBrickMap.col z) : Fin k) : ℕ) = 0
  rw [sevenBrick_color_eq h1 h2, h0]
  rfl

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

/-- The planted vertex's abscissa. -/
theorem plantPt_re : plantPt.re = 2 / 5 := by simp [plantPt]

/-- The planted vertex's ordinate. -/
theorem plantPt_im : plantPt.im = 3 / 10 := by simp [plantPt]

/-- The tangent direction's abscissa. -/
theorem plantDir_re : plantDir.re = 3 / 5 := by simp [plantDir]

/-- The tangent direction's ordinate. -/
theorem plantDir_im : plantDir.im = 4 / 5 := by simp [plantDir]

/-- The abscissa of the tangent disc's centre `97/100 + (106/100) i`. -/
theorem tangentCentre_re : (plantPt + 19 / 20 * plantDir).re = 97 / 100 := by
  simp [plantPt, plantDir]; norm_num

/-- The ordinate of the tangent disc's centre. -/
theorem tangentCentre_im : (plantPt + 19 / 20 * plantDir).im = 106 / 100 := by
  simp [plantPt, plantDir]; norm_num

/-- `plantDir` is a unit vector. -/
theorem norm_plantDir : ‖plantDir‖ = 1 := by
  have h : ‖plantDir‖ ^ 2 = 1 := by
    rw [Complex.sq_norm, Complex.normSq_apply, plantDir_re, plantDir_im]; norm_num
  have h0 := norm_nonneg plantDir
  nlinarith

/-- The tangent disc's centre is `19/20` from the planted vertex. -/
theorem dist_tangentCentre : dist (plantPt + 19 / 20 * plantDir) plantPt = 19 / 20 := by
  rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_plantDir]; norm_num

/-- The tangent disc lies in the open unit disc about the planted vertex, and its closure meets the unit circle at one point. -/
theorem tangentDisc_subset_ball : tangentDisc ⊆ ball plantPt 1 ∧
    closure tangentDisc ∩ sphere plantPt 1 = {plantPt + plantDir} := by
  refine ⟨fun q hq => ?_, ?_⟩
  · rw [tangentDisc, mem_ball] at hq
    rw [mem_ball]
    calc dist q plantPt ≤ dist q (plantPt + 19 / 20 * plantDir) + dist (plantPt + 19 / 20 * plantDir) plantPt :=
          dist_triangle _ _ _
      _ < 1 := by rw [dist_tangentCentre]; linarith
  · rw [tangentDisc, closure_ball _ (by norm_num : (1 / 20 : ℝ) ≠ 0)]
    ext q
    simp only [mem_inter_iff, mem_closedBall, mem_sphere_iff_norm, mem_singleton_iff]
    constructor
    · -- `(q − v)·u ≥ 1` with `‖q − v‖ = ‖u‖ = 1` forces `q − v = u`
      rintro ⟨h1, h2⟩
      have h1' : dist q (plantPt + 19 / 20 * plantDir) ^ 2 ≤ (1 / 20) ^ 2 := pow_le_pow_left₀ dist_nonneg h1 2
      rw [dist_sq_re_im, tangentCentre_re, tangentCentre_im] at h1'
      have h2' : dist q plantPt ^ 2 = 1 := by rw [dist_eq_norm, h2]; norm_num
      rw [dist_sq_re_im, plantPt_re, plantPt_im] at h2'
      have hdot : 1 ≤ 3 / 5 * (q.re - 2 / 5) + 4 / 5 * (q.im - 3 / 10) := by nlinarith
      have hsq : (q.re - 1) ^ 2 + (q.im - 11 / 10) ^ 2 ≤ 0 := by nlinarith
      have hre : q.re = 1 := by nlinarith [sq_nonneg (q.re - 1), sq_nonneg (q.im - 11 / 10)]
      have him : q.im = 11 / 10 := by nlinarith [sq_nonneg (q.re - 1), sq_nonneg (q.im - 11 / 10)]
      apply Complex.ext
      · rw [hre, Complex.add_re, plantPt_re, plantDir_re]; norm_num
      · rw [him, Complex.add_im, plantPt_im, plantDir_im]; norm_num
    · rintro rfl
      refine ⟨?_, by rw [add_sub_cancel_left, norm_plantDir]⟩
      rw [dist_eq_norm, show plantPt + plantDir - (plantPt + 19 / 20 * plantDir) = (1 / 20 : ℂ) * plantDir by ring, norm_mul,
        norm_plantDir]
      norm_num

/-! ## Horn patches and the fan -/

/-- **The boundary of a horn set**, as three arcs: the two tangent arcs out to `ρ` and the piece of the circle of radius `ρ` between their
ends (the end of the tangent arc of curvature `κ` is at the angle `α + arcsin(κρ/2)`). -/
noncomputable def hornArcs (v : ℂ) (α κ₁ κ₂ ρ : ℝ) : Set Arc :=
  {germArc v α κ₁ ρ, germArc v α κ₂ ρ, Arc.circ v ρ (α + Real.arcsin (κ₁ * ρ / 2)) (α + Real.arcsin (κ₂ * ρ / 2))}

/-- The three arcs have positive length. -/
theorem hornArcs_nondegenerate (v : ℂ) (α : ℝ) {κ₁ κ₂ ρ : ℝ} (hρ : 0 < ρ) (h12 : κ₁ < κ₂) (h1 : |κ₁| * ρ ≤ 1)
    (h2 : |κ₂| * ρ ≤ 1) : ∀ a ∈ hornArcs v α κ₁ κ₂ ρ, a.Nondegenerate := by
  have hπ := Real.pi_pos
  intro a ha
  simp only [hornArcs, mem_insert_iff, mem_singleton_iff] at ha
  rcases ha with rfl | rfl | rfl
  · exact germArc_nondegenerate v α κ₁ hρ
  · exact germArc_nondegenerate v α κ₂ hρ
  · have hk1 := half_curv_mem_Icc (κ := κ₁) (r := ρ) (s := ρ) (by linarith) hρ.le le_rfl
    have hk2 := half_curv_mem_Icc (κ := κ₂) (r := ρ) (s := ρ) (by linarith) hρ.le le_rfl
    have hlt : κ₁ * ρ / 2 < κ₂ * ρ / 2 := by nlinarith
    have hasin := Real.arcsin_lt_arcsin hk1.1 hlt hk2.2
    have hlo := Real.neg_pi_div_two_le_arcsin (κ₁ * ρ / 2)
    have hhi := Real.arcsin_le_pi_div_two (κ₂ * ρ / 2)
    exact ⟨hρ, by linarith, by linarith⟩

/-- The three arcs are finitely many. -/
theorem hornArcs_finite (v : ℂ) (α κ₁ κ₂ ρ : ℝ) : (hornArcs v α κ₁ κ₂ ρ).Finite := by
  unfold hornArcs
  exact ((finite_singleton _).insert _).insert _

/-- The weak inequalities of a horn set hold on its closure (taken from continuity, never from a description of the closure). -/
theorem closure_hornSet_subset (v : ℂ) (α κ₁ κ₂ ρ : ℝ) :
    closure (hornSet v α κ₁ κ₂ ρ) ⊆ {z | dist z v ≤ ρ ∧ 0 ≤ frameX v α z ∧
      0 ≤ tanHeight κ₁ (frameX v α z) (frameY v α z) ∧ tanHeight κ₂ (frameX v α z) (frameY v α z) ≤ 0} := by
  have hX : Continuous (frameX v α) := by unfold frameX; fun_prop
  have hY : Continuous (frameY v α) := by unfold frameY; fun_prop
  have hT : ∀ κ, Continuous fun z => tanHeight κ (frameX v α z) (frameY v α z) := fun κ => by
    unfold tanHeight; fun_prop
  refine closure_minimal (fun z hz => ⟨hz.1.le, hz.2.1.le, le_of_lt hz.2.2.1, le_of_lt hz.2.2.2⟩) ?_
  exact ((isClosed_le (continuous_id.dist continuous_const) continuous_const).inter
    (isClosed_le continuous_const hX)).inter ((isClosed_le continuous_const (hT κ₁)).inter
    (isClosed_le (hT κ₂) continuous_const)) |> fun h => by
      simpa [Set.setOf_and, Set.inter_assoc] using h

/-- On the normal line through the vertex the height above the arc of curvature `κ` is `y (1 − κ y / 2)`. -/
theorem tanHeight_zero_left (κ y : ℝ) : tanHeight κ 0 y = y * (1 - κ * y / 2) := by
  unfold tanHeight; ring

/-- Within `ρ` of the vertex, with `|κ| ρ ≤ 1`, the factor `1 − κ y / 2` is at least `1/2`: on the normal line the height has the sign
of the ordinate. -/
theorem half_le_one_sub {κ ρ y : ℝ} (hκ : |κ| * ρ ≤ 1) (hy : |y| ≤ ρ) : 1 / 2 ≤ 1 - κ * y / 2 := by
  have h : |κ * y| ≤ 1 := by
    rw [abs_mul]
    calc |κ| * |y| ≤ |κ| * ρ := mul_le_mul_of_nonneg_left hy (abs_nonneg κ)
      _ ≤ 1 := hκ
  have := (abs_le.mp h).2
  linarith

/-- The frame's ordinate is at most the distance from the vertex. -/
theorem abs_frameY_le (v : ℂ) (α : ℝ) (z : ℂ) : |frameY v α z| ≤ dist z v := by
  have h := frame_normSq v α z
  rw [← dist_eq_norm] at h
  exact abs_le_of_sq_le_sq (by nlinarith [sq_nonneg (frameX v α z)]) dist_nonneg

/-- A point with both frame coordinates `0` is the vertex. -/
theorem eq_of_frame_eq_zero {v z : ℂ} {α : ℝ} (hx : frameX v α z = 0) (hy : frameY v α z = 0) : z = v := by
  have h := frame_normSq v α z
  rw [hx, hy] at h
  have : ‖z - v‖ = 0 := by nlinarith [norm_nonneg (z - v)]
  exact sub_eq_zero.mp (norm_eq_zero.mp this)

/-- The vertex is on every germ's arc. -/
theorem self_mem_carrier_germArc (v : ℂ) (α : ℝ) {κ ρ : ℝ} (hρ : 0 ≤ ρ) (hκρ : |κ| * ρ ≤ 2) :
    v ∈ (germArc v α κ ρ).carrier := by
  rw [carrier_germArc v α hρ hκρ]
  exact ⟨0, ⟨le_rfl, hρ⟩, by simp [branchPt]⟩

/-- **A point of a tangent arc in front of the vertex is on the germ's arc**: `tanHeight κ = 0`, `frameX > 0`, `dist z v ≤ ρ`. -/
theorem mem_carrier_germArc_of_tanHeight_eq_zero {v z : ℂ} {α κ ρ : ℝ} (hκρ : |κ| * ρ ≤ 2) (hX : 0 < frameX v α z)
    (hT : tanHeight κ (frameX v α z) (frameY v α z) = 0) (hd : dist z v ≤ ρ) : z ∈ (germArc v α κ ρ).carrier := by
  have hn : ‖z - v‖ ≤ ρ := by rw [← dist_eq_norm]; exact hd
  have hρ : 0 ≤ ρ := (norm_nonneg _).trans hn
  rw [carrier_germArc v α hρ hκρ]
  refine ⟨‖z - v‖, ⟨norm_nonneg _, hn⟩, ?_⟩
  exact (eq_branchPt_of_tanHeight_eq_zero hX hT
    ((mul_le_mul_of_nonneg_left hn (abs_nonneg κ)).trans hκρ)).symm

/-- **The frontier of a horn set lies on its three arcs.** -/
theorem frontier_hornSet_subset (v : ℂ) (α : ℝ) {κ₁ κ₂ ρ : ℝ} (hρ : 0 < ρ) (h12 : κ₁ < κ₂) (h1 : |κ₁| * ρ ≤ 1)
    (h2 : |κ₂| * ρ ≤ 1) : frontier (hornSet v α κ₁ κ₂ ρ) ⊆ ⋃ a ∈ hornArcs v α κ₁ κ₂ ρ, a.carrier := by
  have _ := h12
  rw [(isOpen_hornSet v α κ₁ κ₂ ρ).frontier_eq]
  rintro z ⟨hzc, hzn⟩
  obtain ⟨hd, hx, hA, hB⟩ := closure_hornSet_subset v α κ₁ κ₂ ρ hzc
  have hin : ∀ a ∈ hornArcs v α κ₁ κ₂ ρ, z ∈ a.carrier → z ∈ ⋃ a ∈ hornArcs v α κ₁ κ₂ ρ, a.carrier :=
    fun a ha hz => mem_iUnion₂.mpr ⟨a, ha, hz⟩
  have hm1 : germArc v α κ₁ ρ ∈ hornArcs v α κ₁ κ₂ ρ := by simp [hornArcs]
  have hm2 : germArc v α κ₂ ρ ∈ hornArcs v α κ₁ κ₂ ρ := by simp [hornArcs]
  have hm3 : Arc.circ v ρ (α + Real.arcsin (κ₁ * ρ / 2)) (α + Real.arcsin (κ₂ * ρ / 2)) ∈ hornArcs v α κ₁ κ₂ ρ := by
    simp [hornArcs]
  rcases hx.eq_or_lt with hx0 | hxpos
  · -- on the normal line: the point is `v`
    have hy := (abs_frameY_le v α z).trans hd
    rw [← hx0, tanHeight_zero_left] at hA hB
    have hp1 := half_le_one_sub h1 hy
    have hp2 := half_le_one_sub h2 hy
    have hy0 : frameY v α z = 0 := by
      have ha : 0 ≤ frameY v α z := by
        by_contra hneg
        push Not at hneg
        nlinarith
      have hb : frameY v α z ≤ 0 := by
        by_contra hpos
        push Not at hpos
        nlinarith
      linarith
    have hzv : z = v := eq_of_frame_eq_zero hx0.symm hy0
    rw [hzv]
    exact mem_iUnion₂.mpr ⟨_, hm1, self_mem_carrier_germArc v α (κ := κ₁) hρ.le (by linarith)⟩
  · rcases hA.eq_or_lt with hA0 | hApos
    · exact hin _ hm1 (mem_carrier_germArc_of_tanHeight_eq_zero (by linarith) hxpos hA0.symm hd)
    rcases hB.eq_or_lt with hB0 | hBneg
    · exact hin _ hm2 (mem_carrier_germArc_of_tanHeight_eq_zero (by linarith) hxpos hB0 hd)
    -- strictly between the two arcs and in front of the vertex: the point is on the rim
    have hdρ : dist z v = ρ := by
      by_contra hne
      exact hzn ⟨lt_of_le_of_ne hd hne, hxpos, hApos, hBneg⟩
    have hz2 : z ∈ hornSet v α κ₁ κ₂ (2 * ρ) := ⟨by rw [hdρ]; linarith, hxpos, hApos, hBneg⟩
    rw [← sectorBetween_eq_hornSet v α κ₁ κ₂ (2 * ρ) (by nlinarith [abs_nonneg κ₁]) (by nlinarith [abs_nonneg κ₂])] at hz2
    obtain ⟨s, hs, φ, hφ, rfl⟩ := hz2
    have hsρ : s = ρ := by
      rw [dist_eq_norm, add_sub_cancel_left, norm_mul_e hs.1.le] at hdρ
      exact hdρ
    subst hsρ
    exact hin _ hm3 ⟨φ, ⟨hφ.1.le, hφ.2.le⟩, rfl⟩

/-- The arcs of a horn's boundary lie in the closed disc of its radius. -/
theorem hornArcs_carrier_subset (v : ℂ) (α : ℝ) {κ₁ κ₂ ρ : ℝ} (hρ : 0 < ρ) (h1 : |κ₁| * ρ ≤ 1) (h2 : |κ₂| * ρ ≤ 1) :
    ⋃ a ∈ hornArcs v α κ₁ κ₂ ρ, a.carrier ⊆ closedBall v ρ := by
  have hgerm : ∀ κ, |κ| * ρ ≤ 1 → (germArc v α κ ρ).carrier ⊆ closedBall v ρ := by
    intro κ hκ
    rw [carrier_germArc v α hρ.le (by linarith)]
    rintro _ ⟨s, hs, rfl⟩
    rw [mem_closedBall, dist_eq_norm, norm_branchPt_sub v α κ hs.1]
    exact hs.2
  intro z hz
  obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp hz
  simp only [hornArcs, mem_insert_iff, mem_singleton_iff] at ha
  rcases ha with rfl | rfl | rfl
  · exact hgerm κ₁ h1 hza
  · exact hgerm κ₂ h2 hza
  · obtain ⟨θ, -, rfl⟩ := hza
    rw [mem_closedBall, dist_eq_norm, add_sub_cancel_left, norm_mul_e hρ.le]

/-- **The rest of a ball off a fan**: the points of `B(v, r)` behind the vertex, below the fan's lowest arc or above its highest. -/
def fanRest (v : ℂ) (α κlo κhi r : ℝ) : Set ℂ :=
  {z | dist z v < r ∧ (frameX v α z < 0 ∨ TanBelow v α κlo z ∨ TanAbove v α κhi z)}

/-- The rest is open. -/
theorem isOpen_fanRest (v : ℂ) (α κlo κhi r : ℝ) : IsOpen (fanRest v α κlo κhi r) := by
  have hX : Continuous (frameX v α) := by unfold frameX; fun_prop
  have hY : Continuous (frameY v α) := by unfold frameY; fun_prop
  have hT : ∀ κ, Continuous fun z => tanHeight κ (frameX v α z) (frameY v α z) := fun κ => by
    unfold tanHeight; fun_prop
  have h : fanRest v α κlo κhi r = {z | dist z v < r} ∩ ({z | frameX v α z < 0} ∪
      ({z | tanHeight κlo (frameX v α z) (frameY v α z) < 0} ∪ {z | 0 < tanHeight κhi (frameX v α z) (frameY v α z)})) := by
    ext z; rfl
  rw [h]
  exact (isOpen_lt (continuous_id.dist continuous_const) continuous_const).inter
    ((isOpen_lt hX continuous_const).union ((isOpen_lt (hT κlo) continuous_const).union (isOpen_lt continuous_const (hT κhi))))

/-- The frame's abscissa is affine: it is kept by convex combinations. -/
theorem frameX_combo (v : ℂ) (α : ℝ) (x y : ℂ) {a b : ℝ} (hab : a + b = 1) :
    frameX v α (a • x + b • y) = a * frameX v α x + b * frameX v α y := by
  have hb : b = 1 - a := by linarith
  subst hb
  unfold frameX
  simp only [Complex.real_smul, Complex.mul_re, Complex.sub_re, Complex.add_re, Complex.sub_im, Complex.add_im, Complex.mul_im,
    Complex.ofReal_re, Complex.ofReal_im, Complex.ofReal_sub, Complex.ofReal_one, Complex.one_re, Complex.one_im]
  ring

/-- The open half-plane behind the vertex is convex. -/
theorem convex_frameX_neg (v : ℂ) (α : ℝ) : Convex ℝ {z | frameX v α z < 0} := by
  intro x hx y hy a b ha hb hab
  show frameX v α (a • x + b • y) < 0
  rw [frameX_combo v α x y hab]
  have hx' : frameX v α x < 0 := hx
  have hy' : frameX v α y < 0 := hy
  rcases ha.eq_or_lt with ha0 | ha0
  · have hb1 : b = 1 := by linarith
    rw [← ha0, hb1]; linarith
  · nlinarith [mul_nonneg hb (neg_pos.mpr hy').le]

/-- The point with frame coordinates `(x, y)`, `x² + y² < r²`, is less than `r` from the vertex. -/
theorem dist_fromFrame_lt {v : ℂ} {α x y r : ℝ} (hr : 0 < r) (h : x ^ 2 + y ^ 2 < r ^ 2) : dist (fromFrame v α x y) v < r := by
  have hn := frame_normSq v α (fromFrame v α x y)
  rw [frameX_fromFrame, frameY_fromFrame, ← dist_eq_norm] at hn
  exact lt_of_pow_lt_pow_left₀ 2 hr.le (by rw [← hn]; exact h)

/-- **The rest is connected** when the fan's lowest curvature is negative and its highest positive: it is the union of three convex sets
(a half-disc and two lenses), the half-disc meeting both lenses. -/
theorem isPreconnected_fanRest (v : ℂ) (α : ℝ) {κlo κhi r : ℝ} (hlo : κlo < 0) (hhi : 0 < κhi) (hr : 0 < r) :
    IsPreconnected (fanRest v α κlo κhi r) := by
  set H : Set ℂ := ball v r ∩ {z | frameX v α z < 0} with hH
  set L₁ : Set ℂ := ball v r ∩ {z | TanBelow v α κlo z} with hL₁
  set L₂ : Set ℂ := ball v r ∩ {z | TanAbove v α κhi z} with hL₂
  have hsplit : fanRest v α κlo κhi r = H ∪ L₁ ∪ L₂ := by
    ext z
    simp only [fanRest, hH, hL₁, hL₂, mem_setOf_eq, mem_union, mem_inter_iff, mem_ball]
    tauto
  have hcH : Convex ℝ H := (convex_ball v r).inter (convex_frameX_neg v α)
  have hcL₁ : Convex ℝ L₁ := by
    have : {z | TanBelow v α κlo z} = ball (v + ((1 / κlo : ℝ) : ℂ) * e (α + π / 2)) (-(1 / κlo)) := by
      ext z; rw [mem_setOf_eq, tanBelow_iff_of_neg v α hlo, mem_ball]
    rw [hL₁, this]
    exact (convex_ball v r).inter (convex_ball _ _)
  have hcL₂ : Convex ℝ L₂ := by
    have : {z | TanAbove v α κhi z} = ball (v + ((1 / κhi : ℝ) : ℂ) * e (α + π / 2)) (1 / κhi) := by
      ext z; rw [mem_setOf_eq, tanAbove_iff_of_pos v α hhi, mem_ball]
    rw [hL₂, this]
    exact (convex_ball v r).inter (convex_ball _ _)
  -- a point behind `v` and below the lowest arc, and one behind `v` and above the highest
  obtain ⟨s, hs0, hsr, hs2⟩ := exists_small_s (max |κlo| |κhi|) hr
  have hκ1 : |κlo| * s < 2 := lt_of_le_of_lt (mul_le_mul_of_nonneg_right ((le_max_left _ _).trans (le_abs_self _)) hs0.le) hs2
  have hκ2 : |κhi| * s < 2 := lt_of_le_of_lt (mul_le_mul_of_nonneg_right ((le_max_right _ _).trans (le_abs_self _)) hs0.le) hs2
  rw [abs_of_neg hlo] at hκ1
  rw [abs_of_pos hhi] at hκ2
  set t := s / 2 with ht
  have ht0 : 0 < t := by positivity
  have hd : ∀ y : ℝ, y ^ 2 = t ^ 2 → dist (fromFrame v α (-t) y) v < r := fun y hy =>
    dist_fromFrame_lt hr (by nlinarith)
  have h1 : 0 < 1 + κlo * t := by rw [ht]; linarith
  have h2 : 0 < 1 - κhi * t := by rw [ht]; linarith
  have hp₁H : fromFrame v α (-t) (-t) ∈ H := ⟨hd _ (by ring), by show frameX _ _ _ < 0; rw [frameX_fromFrame]; linarith⟩
  have hp₁L : fromFrame v α (-t) (-t) ∈ L₁ := ⟨hd _ (by ring), by
    show tanHeight _ _ _ < 0
    rw [frameX_fromFrame, frameY_fromFrame]; unfold tanHeight; nlinarith [mul_pos ht0 h1]⟩
  have hp₂H : fromFrame v α (-t) t ∈ H := ⟨hd _ rfl, by show frameX _ _ _ < 0; rw [frameX_fromFrame]; linarith⟩
  have hp₂L : fromFrame v α (-t) t ∈ L₂ := ⟨hd _ rfl, by
    show 0 < tanHeight _ _ _
    rw [frameX_fromFrame, frameY_fromFrame]; unfold tanHeight; nlinarith [mul_pos ht0 h2]⟩
  rw [hsplit]
  exact IsPreconnected.union _ (Or.inl hp₂H) hp₂L
    (IsPreconnected.union _ hp₁H hp₁L hcH.isPreconnected hcL₁.isPreconnected) hcL₂.isPreconnected

/-- A sequence of non-zero reals that starts positive and ends negative changes sign between two consecutive terms. -/
theorem exists_sign_change {m : ℕ} (f : Fin (m + 2) → ℝ) (h0 : 0 < f 0) (hl : f (Fin.last (m + 1)) < 0)
    (hne : ∀ j, f j ≠ 0) : ∃ i : Fin (m + 1), 0 < f i.castSucc ∧ f i.succ < 0 := by
  by_contra hcon
  push Not at hcon
  have hall : ∀ j : Fin (m + 2), 0 < f j := by
    intro j
    induction j using Fin.induction with
    | zero => exact h0
    | succ i ih => exact lt_of_le_of_ne (hcon i ih) (Ne.symm (hne _))
  exact lt_asymm (hall _) hl

/-- **A point of a germ's arc**: it is not behind the vertex, and its height above the tangent arc of any curvature `κ'` is
`‖z − v‖² (κ − κ') / 2` — zero for its own curvature, of the sign of `κ − κ'` otherwise. -/
theorem frame_of_mem_carrier_germArc {v z : ℂ} {α κ ρ : ℝ} (hρ : 0 ≤ ρ) (hκρ : |κ| * ρ ≤ 1) (hz : z ∈ (germArc v α κ ρ).carrier) :
    0 ≤ frameX v α z ∧ ∀ κ', tanHeight κ' (frameX v α z) (frameY v α z) = ‖z - v‖ ^ 2 * (κ - κ') / 2 := by
  rw [carrier_germArc v α hρ (by linarith)] at hz
  obtain ⟨s, hs, rfl⟩ := hz
  have hκs : |κ| * s ≤ 1 := (mul_le_mul_of_nonneg_left hs.2 (abs_nonneg κ)).trans hκρ
  refine ⟨?_, fun κ' => ?_⟩
  · rcases hs.1.eq_or_lt with h0 | h0
    · rw [← h0]; simp [branchPt, frameX]
    · exact (frameX_branchPt_pos v α κ (by linarith) h0).le
  · rw [tanHeight_branchPt v α κ κ' (by linarith) hs.1, norm_branchPt_sub v α κ hs.1]

/-- **A point of a horn of the fan against every arc of the fan**: above the arcs up to its lower one, below those from its upper
one on. -/
theorem fan_tanHeight_of_mem_hornSet {m : ℕ} {κ : Fin (m + 2) → ℝ} (hκ : StrictMono κ) {v z : ℂ} {α r : ℝ} {i : Fin (m + 1)}
    (hz : z ∈ hornSet v α (κ i.castSucc) (κ i.succ) r) (j : Fin (m + 2)) :
    (j ≤ i.castSucc → 0 < tanHeight (κ j) (frameX v α z) (frameY v α z)) ∧
      (i.succ ≤ j → tanHeight (κ j) (frameX v α z) (frameY v α z) < 0) :=
  ⟨fun hj => lt_of_lt_of_le hz.2.2.1 (tanHeight_anti (hκ.monotone hj) _ _),
    fun hj => lt_of_le_of_lt (tanHeight_anti (hκ.monotone hj) _ _) hz.2.2.2⟩

/-- **A ball cut by a fan** of `m + 2` tangent arcs of increasing curvatures along one ray: off the arcs it is the rest and the `m + 1`
horn sets between consecutive arcs. -/
theorem ball_diff_fan {m : ℕ} (κ : Fin (m + 2) → ℝ) (hκ : StrictMono κ) (v : ℂ) (α : ℝ) {ρ r : ℝ} (hr : 0 < r) (hrρ : r ≤ ρ)
    (hκρ : ∀ i, |κ i| * ρ ≤ 1) :
    ball v r \ ⋃ i, (germArc v α (κ i) ρ).carrier =
      fanRest v α (κ 0) (κ (Fin.last (m + 1))) r ∪ ⋃ i : Fin (m + 1), hornSet v α (κ i.castSucc) (κ i.succ) r := by
  have hρ : 0 < ρ := lt_of_lt_of_le hr hrρ
  ext z
  simp only [Set.mem_sdiff, mem_ball, mem_iUnion, not_exists, mem_union]
  constructor
  · rintro ⟨hd, harc⟩
    rcases lt_trichotomy (frameX v α z) 0 with hx | hx | hx
    · exact Or.inl ⟨hd, Or.inl hx⟩
    · -- on the normal line, off `v`: the sign of the ordinate decides
      have hy := (abs_frameY_le v α z).trans (hd.le.trans hrρ)
      have hy0 : frameY v α z ≠ 0 := fun hy0 => harc 0 (by
        rw [eq_of_frame_eq_zero hx hy0]
        exact self_mem_carrier_germArc v α hρ.le (by linarith [hκρ 0]))
      rcases lt_or_gt_of_ne hy0 with hneg | hpos
      · refine Or.inl ⟨hd, Or.inr (Or.inl ?_)⟩
        show tanHeight _ _ _ < 0
        rw [hx, tanHeight_zero_left]
        have := half_le_one_sub (hκρ 0) hy
        nlinarith
      · refine Or.inl ⟨hd, Or.inr (Or.inr ?_)⟩
        show 0 < tanHeight _ _ _
        rw [hx, tanHeight_zero_left]
        have := half_le_one_sub (hκρ (Fin.last (m + 1))) hy
        nlinarith
    · -- in front of the vertex and on no arc: no height vanishes, so the heights change sign once
      have hne : ∀ j, tanHeight (κ j) (frameX v α z) (frameY v α z) ≠ 0 := fun j h0 =>
        harc j (mem_carrier_germArc_of_tanHeight_eq_zero (by linarith [hκρ j]) hx h0 (hd.le.trans hrρ))
      rcases lt_or_gt_of_ne (hne 0) with h0 | h0
      · exact Or.inl ⟨hd, Or.inr (Or.inl h0)⟩
      rcases lt_or_gt_of_ne (hne (Fin.last (m + 1))) with hl | hl
      · obtain ⟨i, hi1, hi2⟩ := exists_sign_change (fun j => tanHeight (κ j) (frameX v α z) (frameY v α z)) h0 hl hne
        exact Or.inr ⟨i, hd, hx, hi1, hi2⟩
      · exact Or.inl ⟨hd, Or.inr (Or.inr hl)⟩
  · rintro (⟨hd, h⟩ | ⟨i, hi⟩)
    · refine ⟨hd, fun j hj => ?_⟩
      obtain ⟨hx, hT⟩ := frame_of_mem_carrier_germArc hρ.le (hκρ j) hj
      rcases h with h | h | h
      · exact absurd hx (not_le.mpr h)
      · have h1 := tanHeight_anti (hκ.monotone (Fin.zero_le j)) (frameX v α z) (frameY v α z)
        have h2 := hT (κ j)
        have h3 : tanHeight (κ 0) (frameX v α z) (frameY v α z) < 0 := h
        rw [sub_self, mul_zero, zero_div] at h2
        linarith
      · have h1 := tanHeight_anti (hκ.monotone (Fin.le_last j)) (frameX v α z) (frameY v α z)
        have h2 := hT (κ j)
        have h3 : 0 < tanHeight (κ (Fin.last (m + 1))) (frameX v α z) (frameY v α z) := h
        rw [sub_self, mul_zero, zero_div] at h2
        linarith
    · refine ⟨hi.1, fun j hj => ?_⟩
      obtain ⟨-, hT⟩ := frame_of_mem_carrier_germArc hρ.le (hκρ j) hj
      have h2 := hT (κ j)
      rw [sub_self, mul_zero, zero_div] at h2
      obtain ⟨ha, hb⟩ := fan_tanHeight_of_mem_hornSet hκ hi j
      rcases lt_or_ge j i.succ with hlt | hge
      · exact absurd h2 (ha (Fin.le_castSucc_iff.mpr hlt)).ne'
      · exact absurd h2 (hb hge).ne

/-- **The pieces of a ball cut by a fan** of tangent arcs: the rest (`none`) and the horn sets between consecutive arcs (`some i`). The
partition `isSector_fan_iff` reads, indexed so that `ArcMap.encard_sectorsOf_of_partition` counts a colour's sectors on it. -/
def fanPiece {m : ℕ} (κ : Fin (m + 2) → ℝ) (v : ℂ) (α r : ℝ) : Option (Fin (m + 1)) → Set ℂ
  | none => fanRest v α (κ 0) (κ (Fin.last (m + 1))) r
  | some i => hornSet v α (κ i.castSucc) (κ i.succ) r

/-- The union of the pieces is the rest and the horn sets (the spec of `fanPiece`: it fails if a piece is dropped or doubled). -/
theorem iUnion_fanPiece {m : ℕ} (κ : Fin (m + 2) → ℝ) (v : ℂ) (α r : ℝ) :
    ⋃ o, fanPiece κ v α r o =
      fanRest v α (κ 0) (κ (Fin.last (m + 1))) r ∪ ⋃ i : Fin (m + 1), hornSet v α (κ i.castSucc) (κ i.succ) r := by
  ext z
  simp only [mem_iUnion, mem_union]
  constructor
  · rintro ⟨o, ho⟩
    cases o with
    | none => exact Or.inl ho
    | some i => exact Or.inr ⟨i, ho⟩
  · rintro (h | ⟨i, hi⟩)
    · exact ⟨none, h⟩
    · exact ⟨some i, hi⟩

/-- **The rest approaches the vertex along the open half-turn behind it.** -/
theorem Ioo_subset_coneAt_fanRest (v : ℂ) (α κlo κhi : ℝ) {r : ℝ} (hr : 0 < r) :
    Ioo (α + π / 2) (α + 3 * π / 2) ⊆ coneAt (fanRest v α κlo κhi r) v := by
  intro β hβ ε hε
  set t := min r ε / 2 with ht
  have ht0 : 0 < t := by have := lt_min hr hε; positivity
  have htr : t < r := by have := min_le_left r ε; linarith
  have htε : t < ε := by have := min_le_right r ε; linarith
  have hdist : dist (v + (t : ℂ) * e β) v = t := by rw [dist_eq_norm, add_sub_cancel_left, norm_mul_e ht0.le]
  refine ⟨v + (t : ℂ) * e β, ⟨by rw [hdist]; exact htr, Or.inl ?_⟩, ?_, by rw [hdist]; exact htε, ?_⟩
  · rw [(frame_polar v α t β).1]
    exact mul_neg_of_pos_of_neg ht0 (Real.cos_neg_of_pi_div_two_lt_of_lt (by linarith [hβ.1]) (by linarith [hβ.2]))
  · intro h
    rw [h, dist_self] at hdist
    exact ht0.ne hdist
  · have hnorm : ‖v + (t : ℂ) * e β - v‖ = t := by rw [← dist_eq_norm]; exact hdist
    rw [hnorm, add_sub_cancel_left, mul_div_cancel_left₀ _ (by exact_mod_cast ht0.ne'), sub_self, norm_zero]
    exact hε

/-- The rest's cone at the vertex has interior directions. -/
theorem interior_coneAt_fanRest_nonempty (v : ℂ) (α κlo κhi : ℝ) {r : ℝ} (hr : 0 < r) :
    (interior (coneAt (fanRest v α κlo κhi r) v)).Nonempty := by
  have hπ := Real.pi_pos
  exact ⟨α + π, interior_maximal (Ioo_subset_coneAt_fanRest v α κlo κhi hr) isOpen_Ioo ⟨by linarith, by linarith⟩⟩

/-- **The pieces of a fan are a partition into sectors' shapes**: open, connected, pairwise disjoint, non-empty, each with the vertex in
its closure. -/
theorem fanPiece_data {m : ℕ} (κ : Fin (m + 2) → ℝ) (hκ : StrictMono κ) (v : ℂ) (α : ℝ) {ρ r : ℝ} (hr : 0 < r) (hrρ : r ≤ ρ)
    (hκρ : ∀ i, |κ i| * ρ ≤ 1) (hlo : κ 0 < 0) (hhi : 0 < κ (Fin.last (m + 1))) :
    (∀ o, IsOpen (fanPiece κ v α r o)) ∧ (∀ o, IsPreconnected (fanPiece κ v α r o)) ∧
      (∀ o o', o ≠ o' → Disjoint (fanPiece κ v α r o) (fanPiece κ v α r o')) ∧ (∀ o, (fanPiece κ v α r o).Nonempty) ∧
      ∀ o, v ∈ closure (fanPiece κ v α r o) := by
  have hπ := Real.pi_pos
  have hκr : ∀ i, |κ i| * r < 2 := fun i =>
    lt_of_le_of_lt ((mul_le_mul_of_nonneg_left hrρ (abs_nonneg _)).trans (hκρ i)) (by norm_num)
  have hlt : ∀ i : Fin (m + 1), κ i.castSucc < κ i.succ := fun i => hκ (Fin.castSucc_lt_succ)
  have hcone : ∀ o, ∃ β, β ∈ coneAt (fanPiece κ v α r o) v := by
    intro o
    cases o with
    | none => exact ⟨α + π, Ioo_subset_coneAt_fanRest v α _ _ hr ⟨by linarith, by linarith⟩⟩
    | some i => exact ⟨α, mem_coneAt_hornSet v α (hlt i) hr⟩
  -- the rest misses every horn of the fan
  have hrest : ∀ i : Fin (m + 1), Disjoint (fanPiece κ v α r none) (fanPiece κ v α r (some i)) := by
    intro i
    rw [disjoint_left]
    rintro z ⟨-, h⟩ hz
    obtain ⟨ha, -⟩ := fan_tanHeight_of_mem_hornSet hκ hz 0
    obtain ⟨-, hb⟩ := fan_tanHeight_of_mem_hornSet hκ hz (Fin.last (m + 1))
    rcases h with h | h | h
    · exact lt_asymm h hz.2.1
    · exact lt_asymm h (ha (Fin.zero_le _))
    · exact lt_asymm h (hb (Fin.le_last _))
  -- two horns of the fan, the first below the second
  have hhorn : ∀ i j : Fin (m + 1), i < j → Disjoint (fanPiece κ v α r (some i)) (fanPiece κ v α r (some j)) := by
    intro i j hij
    rw [disjoint_left]
    intro z hzi hzj
    obtain ⟨-, hb⟩ := fan_tanHeight_of_mem_hornSet hκ hzi j.castSucc
    exact lt_asymm (hb (Fin.succ_le_castSucc_iff.mpr hij)) hzj.2.2.1
  refine ⟨fun o => ?_, fun o => ?_, fun o o' hne => ?_, fun o => ?_, fun o => ?_⟩
  · cases o with
    | none => exact isOpen_fanRest v α _ _ r
    | some i => exact isOpen_hornSet v α _ _ r
  · cases o with
    | none => exact isPreconnected_fanRest v α hlo hhi hr
    | some i => exact isPreconnected_hornSet v α (hlt i) (hκr _) (hκr _)
  · cases o with
    | none =>
      cases o' with
      | none => exact absurd rfl hne
      | some j => exact hrest j
    | some i =>
      cases o' with
      | none => exact (hrest i).symm
      | some j =>
        have hij : i ≠ j := fun h => hne (by rw [h])
        rcases lt_or_gt_of_ne hij with h | h
        · exact hhorn i j h
        · exact (hhorn j i h).symm
  · obtain ⟨β, hβ⟩ := hcone o
    obtain ⟨z, hz, -⟩ := hβ 1 one_pos
    exact ⟨z, hz⟩
  · obtain ⟨β, hβ⟩ := hcone o
    exact mem_closure_of_mem_coneAt hβ

/-- **The sectors of a fan**: a map whose interior points in `B(v, r)` are the ball off a fan of tangent arcs, the lowest curvature
negative and the highest positive, has as its sectors at radius `r` the rest and the `m + 1` horn sets. -/
theorem isSector_fan_iff {k : ℕ} {G : ArcMap k} {m : ℕ} (κ : Fin (m + 2) → ℝ) (hκ : StrictMono κ) {v : ℂ} {α ρ r : ℝ} (hr : 0 < r)
    (hrρ : r ≤ ρ) (hκρ : ∀ i, |κ i| * ρ ≤ 1) (hlo : κ 0 < 0) (hhi : 0 < κ (Fin.last (m + 1)))
    (hI : G.interiorPts ∩ ball v r = ball v r \ ⋃ i, (germArc v α (κ i) ρ).carrier) {S : Set ℂ} :
    G.IsSector v r S ↔ S = fanRest v α (κ 0) (κ (Fin.last (m + 1))) r ∨
      ∃ i : Fin (m + 1), S = hornSet v α (κ i.castSucc) (κ i.succ) r := by
  have hU : G.interiorPts ∩ ball v r = ⋃ o, fanPiece κ v α r o := by
    rw [hI, ball_diff_fan κ hκ v α hr hrρ hκρ, iUnion_fanPiece]
  obtain ⟨ho, hp, hd, hn, hc⟩ := fanPiece_data κ hκ v α hr hrρ hκρ hlo hhi
  rw [ArcMap.isSector_iff_of_partition hU ho hp hd hn hc]
  constructor
  · rintro ⟨o, rfl⟩
    cases o with
    | none => exact Or.inl rfl
    | some i => exact Or.inr ⟨i, rfl⟩
  · rintro (rfl | ⟨i, rfl⟩)
    · exact ⟨none, rfl⟩
    · exact ⟨some i, rfl⟩

/-- **The rest is no horn set**: it approaches `v` along an open interval of directions. -/
theorem fanRest_ne_hornSet (v : ℂ) (α : ℝ) {κlo κhi r : ℝ} (hr : 0 < r) (α' κ₁ κ₂ : ℝ) :
    fanRest v α κlo κhi r ≠ hornSet v α' κ₁ κ₂ r :=
  ne_hornSet_of_interior_coneAt (interior_coneAt_fanRest_nonempty v α κlo κhi hr) α' κ₁ κ₂ r


/-! ## Frames along `e 0`, horns against arcs, and the fan's pieces (FS131-MA1: what the models' leaves share) -/

/-- The frame along `e 0` reads the real part. -/
theorem frameX_zero (v z : ℂ) : frameX v 0 z = z.re - v.re := by simp [frameX, e_zero]

/-- The frame along `e 0` reads the imaginary part. -/
theorem frameY_zero (v z : ℂ) : frameY v 0 z = z.im - v.im := by simp [frameY, e_zero]

/-- Two points' abscissae differ by at most their distance. -/
theorem abs_re_sub_le_dist (z w : ℂ) : |z.re - w.re| ≤ dist z w := by
  rw [dist_eq_norm, ← Complex.sub_re]; exact Complex.abs_re_le_norm _

/-- Two points' ordinates differ by at most their distance. -/
theorem abs_im_sub_le_dist (z w : ℂ) : |z.im - w.im| ≤ dist z w := by
  rw [dist_eq_norm, ← Complex.sub_im]; exact Complex.abs_im_le_norm _

/-- **Inside the open ball of its radius a horn's boundary is its two tangent arcs** (the rim piece is on the sphere). -/
theorem mem_hornArcs_carrier_iff_of_mem_ball {v z : ℂ} {α κ₁ κ₂ ρ : ℝ} (hz : dist z v < ρ) :
    z ∈ ⋃ a ∈ hornArcs v α κ₁ κ₂ ρ, a.carrier ↔ z ∈ (germArc v α κ₁ ρ).carrier ∨ z ∈ (germArc v α κ₂ ρ).carrier := by
  have hρ : 0 ≤ ρ := dist_nonneg.trans hz.le
  constructor
  · intro h
    obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
    simp only [hornArcs, mem_insert_iff, mem_singleton_iff] at ha
    rcases ha with rfl | rfl | rfl
    · exact Or.inl hza
    · exact Or.inr hza
    · obtain ⟨θ, -, rfl⟩ := hza
      rw [dist_eq_norm, add_sub_cancel_left, norm_mul_e hρ] at hz
      exact absurd hz (lt_irrefl _)
  · rintro (h | h)
    · exact mem_iUnion₂.mpr ⟨_, by simp [hornArcs], h⟩
    · exact mem_iUnion₂.mpr ⟨_, by simp [hornArcs], h⟩

/-- **A horn set misses the tangent arc of a curvature outside its own.** -/
theorem disjoint_hornSet_carrier_germArc {v : ℂ} {α κ₁ κ₂ κ r ρ : ℝ} (hρ : 0 ≤ ρ) (hκρ : |κ| * ρ ≤ 1)
    (hκ : κ ≤ κ₁ ∨ κ₂ ≤ κ) : Disjoint (hornSet v α κ₁ κ₂ r) (germArc v α κ ρ).carrier := by
  rw [disjoint_left]
  rintro z ⟨-, -, hA, hB⟩ hz
  have h0 := (frame_of_mem_carrier_germArc hρ hκρ hz).2 κ
  rw [sub_self, mul_zero, zero_div] at h0
  rcases hκ with h | h
  · have := tanHeight_anti h (frameX v α z) (frameY v α z)
    unfold TanAbove at hA; linarith
  · have := tanHeight_anti h (frameX v α z) (frameY v α z)
    unfold TanBelow at hB; linarith

/-- **A horn set misses the boundary arcs of a horn of at least its radius whose curvatures lie outside its own** — its own among
them. -/
theorem disjoint_hornSet_hornArcs {v : ℂ} {α κ₁ κ₂ κ₃ κ₄ r ρ : ℝ} (hrρ : r ≤ ρ) (h3 : |κ₃| * ρ ≤ 1) (h4 : |κ₄| * ρ ≤ 1)
    (hκ₃ : κ₃ ≤ κ₁ ∨ κ₂ ≤ κ₃) (hκ₄ : κ₄ ≤ κ₁ ∨ κ₂ ≤ κ₄) :
    Disjoint (hornSet v α κ₁ κ₂ r) (⋃ a ∈ hornArcs v α κ₃ κ₄ ρ, a.carrier) := by
  rw [disjoint_left]
  intro z hz hza
  have hd : dist z v < ρ := lt_of_lt_of_le hz.1 hrρ
  have hρ : 0 ≤ ρ := dist_nonneg.trans hd.le
  rcases (mem_hornArcs_carrier_iff_of_mem_ball hd).mp hza with h | h
  · exact disjoint_left.mp (disjoint_hornSet_carrier_germArc hρ h3 hκ₃) hz h
  · exact disjoint_left.mp (disjoint_hornSet_carrier_germArc hρ h4 hκ₄) hz h

/-- The fan's rest misses a horn whose curvatures lie between the fan's ends. -/
theorem disjoint_fanRest_hornSet {v : ℂ} {α κlo κhi κ₁ κ₂ r r' : ℝ} (h1 : κlo ≤ κ₁) (h2 : κ₂ ≤ κhi) :
    Disjoint (fanRest v α κlo κhi r) (hornSet v α κ₁ κ₂ r') := by
  rw [disjoint_left]
  rintro z ⟨-, h⟩ ⟨-, hx, hA, hB⟩
  unfold TanAbove at hA
  unfold TanBelow at hB
  rcases h with h | h | h
  · exact lt_asymm h hx
  · have := tanHeight_anti h1 (frameX v α z) (frameY v α z)
    unfold TanBelow at h; linarith
  · have := tanHeight_anti h2 (frameX v α z) (frameY v α z)
    unfold TanAbove at h; linarith

/-- Two horns along one ray, the first below the second, are disjoint. -/
theorem disjoint_hornSet_hornSet {v : ℂ} {α κ₁ κ₂ κ₃ κ₄ r r' : ℝ} (h : κ₂ ≤ κ₃) :
    Disjoint (hornSet v α κ₁ κ₂ r) (hornSet v α κ₃ κ₄ r') := by
  rw [disjoint_left]
  rintro z ⟨-, -, -, hB⟩ ⟨-, -, hA, -⟩
  have := tanHeight_anti h (frameX v α z) (frameY v α z)
  unfold TanAbove at hA
  unfold TanBelow at hB
  linarith

/-- A fan's pieces grow with the radius. -/
theorem fanPiece_mono_radius {m : ℕ} (κ : Fin (m + 2) → ℝ) (v : ℂ) (α : ℝ) {r r' : ℝ} (h : r ≤ r') (o : Option (Fin (m + 1))) :
    fanPiece κ v α r o ⊆ fanPiece κ v α r' o := by
  cases o with
  | none => exact fun z hz => ⟨lt_of_lt_of_le hz.1 h, hz.2⟩
  | some i => exact hornSet_mono_radius h

/-- A fan's pieces lie in the ball. -/
theorem fanPiece_subset_ball {m : ℕ} (κ : Fin (m + 2) → ℝ) (v : ℂ) (α r : ℝ) (o : Option (Fin (m + 1))) :
    fanPiece κ v α r o ⊆ ball v r := by
  cases o with
  | none => exact fun z hz => hz.1
  | some i => exact fun z hz => hz.1

/-- A sector of one colour holds no point of another. -/
theorem ArcMap.IsSector.false_of_col {k : ℕ} {G : ArcMap k} {v : ℂ} {r : ℝ} {S : Set ℂ} (hS : G.IsSector v r S) {c c' : Fin k}
    (h : S ⊆ G.col ⁻¹' {c}) (h' : S ⊆ G.col ⁻¹' {c'}) (hne : c ≠ c') : False := by
  obtain ⟨z, hz⟩ := hS.nonempty
  have h1 : G.col z = c := h hz
  have h2 : G.col z = c' := h' hz
  exact hne (h1.symm.trans h2)

/-! ## The brick base near the planted points: the small disc about the vertex, the tangent disc and its brick -/

/-- The closed disc of radius `1/10` about the planted vertex lies strictly inside the brick `(0, 4/5) × (0, 3/5)`. -/
theorem plantBall_subset_brick {z : ℂ} (hz : dist z plantPt ≤ 1 / 10) :
    (0 < z.re ∧ z.re < 4 / 5) ∧ (0 < z.im ∧ z.im < 3 / 5) := by
  have h1 := abs_le.mp ((abs_re_sub_le_dist z plantPt).trans hz)
  have h2 := abs_le.mp ((abs_im_sub_le_dist z plantPt).trans hz)
  rw [plantPt_re] at h1
  rw [plantPt_im] at h2
  exact ⟨⟨by linarith [h1.1], by linarith [h1.2]⟩, ⟨by linarith [h2.1], by linarith [h2.2]⟩⟩

/-- A point strictly inside the brick `(0, 4/5) × (0, 3/5)` is an interior point of the base. -/
theorem brickBase_mem_interiorPts_zero {k : ℕ} (h : 7 ≤ k) {z : ℂ} (hre : 0 < z.re ∧ z.re < 4 / 5)
    (him : 0 < z.im ∧ z.im < 3 / 5) : z ∈ (brickBase k h).interiorPts :=
  brickBase_mem_interiorPts h (c := 0) (r := 0) (by push_cast; constructor <;> linarith [hre.1, hre.2])
    (by push_cast; constructor <;> linarith [him.1, him.2])

/-- The disc of radius `1/10` about the planted vertex consists of interior points of the base. -/
theorem plantBall_subset_interiorPts {k : ℕ} (h : 7 ≤ k) : closedBall plantPt (1 / 10) ⊆ (brickBase k h).interiorPts :=
  fun _ hz => brickBase_mem_interiorPts_zero h (plantBall_subset_brick hz).1 (plantBall_subset_brick hz).2

/-- The disc of radius `1/10` about the planted vertex is of the base's colour `0` (eight colours). -/
theorem plantBall_subset_region_zero : closedBall plantPt (1 / 10) ⊆ (brickBase 8 (by norm_num)).region 0 :=
  fun _ hz => ⟨plantBall_subset_interiorPts _ hz,
    Fin.ext (brickBase_col_zero _ (plantBall_subset_brick hz).1 (plantBall_subset_brick hz).2)⟩

/-- The open brick `(2/5, 6/5) × (3/5, 6/5)` (column `0`, row `1`), which holds the tangent disc. -/
def tangentBrick : Set ℂ := {z | 2 / 5 < z.re ∧ z.re < 6 / 5 ∧ 3 / 5 < z.im ∧ z.im < 6 / 5}

/-- The tangent brick consists of interior points of the base. -/
theorem tangentBrick_subset_interiorPts {k : ℕ} (h : 7 ≤ k) : tangentBrick ⊆ (brickBase k h).interiorPts :=
  fun z hz => brickBase_mem_interiorPts h (c := 0) (r := 1) (by push_cast; constructor <;> linarith [hz.1, hz.2.1])
    (by push_cast; constructor <;> linarith [hz.2.2.1, hz.2.2.2])

/-- The closed tangent disc lies in its brick, with room: within `3/40` of the centre is still inside. -/
theorem closedBall_tangentCentre_subset_tangentBrick {z : ℂ} (hz : dist z (plantPt + 19 / 20 * plantDir) ≤ 3 / 40) :
    z ∈ tangentBrick := by
  have h1 := abs_le.mp ((abs_re_sub_le_dist z _).trans hz)
  have h2 := abs_le.mp ((abs_im_sub_le_dist z _).trans hz)
  rw [tangentCentre_re] at h1
  rw [tangentCentre_im] at h2
  exact ⟨by linarith [h1.1], by linarith [h1.2], by linarith [h2.1], by linarith [h2.2]⟩

/-- The tangent disc consists of interior points of the base. -/
theorem tangentDisc_subset_interiorPts {k : ℕ} (h : 7 ≤ k) : tangentDisc ⊆ (brickBase k h).interiorPts :=
  fun _ hz => tangentBrick_subset_interiorPts h (closedBall_tangentCentre_subset_tangentBrick
    ((le_of_lt (mem_ball.mp hz)).trans (by norm_num)))

/-- The tangent brick is open. -/
theorem isOpen_tangentBrick : IsOpen tangentBrick := by
  have h : tangentBrick = {z : ℂ | 2 / 5 < z.re} ∩ {z | z.re < 6 / 5} ∩ {z | 3 / 5 < z.im} ∩ {z | z.im < 6 / 5} := by
    ext z; simp only [tangentBrick, mem_setOf_eq, mem_inter_iff]; tauto
  rw [h]
  exact (((isOpen_lt continuous_const Complex.continuous_re).inter (isOpen_lt Complex.continuous_re continuous_const)).inter
    (isOpen_lt continuous_const Complex.continuous_im)).inter (isOpen_lt Complex.continuous_im continuous_const)

/-- The tangent brick is convex. -/
theorem convex_tangentBrick : Convex ℝ tangentBrick := by
  have h : tangentBrick = {z : ℂ | 2 / 5 < z.re} ∩ {z | z.re < 6 / 5} ∩ {z | 3 / 5 < z.im} ∩ {z | z.im < 6 / 5} := by
    ext z; simp only [tangentBrick, mem_setOf_eq, mem_inter_iff]; tauto
  rw [h]
  exact (((convex_halfSpace_re_gt _).inter (convex_halfSpace_re_lt _)).inter (convex_halfSpace_im_gt _)).inter
    (convex_halfSpace_im_lt _)

/-- The closure of the tangent brick lies in the closed rectangle. -/
theorem closure_tangentBrick_subset :
    closure tangentBrick ⊆ {z : ℂ | 2 / 5 ≤ z.re ∧ z.re ≤ 6 / 5 ∧ 3 / 5 ≤ z.im ∧ z.im ≤ 6 / 5} := by
  refine closure_minimal (fun z hz => ⟨hz.1.le, hz.2.1.le, hz.2.2.1.le, hz.2.2.2.le⟩) ?_
  have h : {z : ℂ | 2 / 5 ≤ z.re ∧ z.re ≤ 6 / 5 ∧ 3 / 5 ≤ z.im ∧ z.im ≤ 6 / 5} =
      {z : ℂ | 2 / 5 ≤ z.re} ∩ {z | z.re ≤ 6 / 5} ∩ {z | 3 / 5 ≤ z.im} ∩ {z | z.im ≤ 6 / 5} := by
    ext z; simp only [mem_setOf_eq, mem_inter_iff]; tauto
  rw [h]
  exact (((isClosed_le continuous_const Complex.continuous_re).inter (isClosed_le Complex.continuous_re continuous_const)).inter
    (isClosed_le continuous_const Complex.continuous_im)).inter (isClosed_le Complex.continuous_im continuous_const)

/-- **The walls of the tangent brick are cell edges**: an interior point of the base in the closed rectangle is strictly inside. -/
theorem mem_tangentBrick_of_mem_interiorPts {k : ℕ} (h : 7 ≤ k) {z : ℂ} (hz : z ∈ (brickBase k h).interiorPts)
    (hrect : 2 / 5 ≤ z.re ∧ z.re ≤ 6 / 5 ∧ 3 / 5 ≤ z.im ∧ z.im ≤ 6 / 5) : z ∈ tangentBrick := by
  have hz' : z ∉ ⋃ a ∈ sevenBrickArcs, a.carrier := hz.2
  obtain ⟨h1, h2, h3, h4⟩ := hrect
  refine ⟨lt_of_le_of_ne h1 fun he => hz' ?_, lt_of_le_of_ne h2 fun he => hz' ?_, lt_of_le_of_ne h3 fun he => hz' ?_,
    lt_of_le_of_ne h4 fun he => hz' ?_⟩
  · exact mem_sevenBrickArcs_of_left (c := 0) (r := 1) (by push_cast; linarith) (by push_cast; linarith) (by push_cast; linarith)
  · exact mem_sevenBrickArcs_of_left (c := 1) (r := 1) (by push_cast; linarith) (by push_cast; linarith) (by push_cast; linarith)
  · exact mem_sevenBrickArcs_of_bottom (c := 0) (r := 1) (by push_cast; linarith) (by push_cast; linarith)
      (by push_cast; linarith)
  · rcases le_total z.re (4 / 5) with h5 | h5
    · exact mem_sevenBrickArcs_of_bottom (c := -1) (r := 2) (by push_cast; linarith) (by push_cast; linarith)
        (by push_cast; linarith)
    · exact mem_sevenBrickArcs_of_bottom (c := 0) (r := 2) (by push_cast; linarith) (by push_cast; linarith)
        (by push_cast; linarith)

/-- The closed tangent disc is far from the planted vertex: more than `1/10`. -/
theorem tangentDisc_far {z : ℂ} (hz : dist z (plantPt + 19 / 20 * plantDir) ≤ 1 / 20) : 9 / 10 ≤ dist z plantPt := by
  have := dist_triangle (plantPt + 19 / 20 * plantDir) z plantPt
  rw [dist_tangentCentre, dist_comm _ z] at this
  linarith

/-- The tangent disc lies in its closed disc. -/
theorem tangentDisc_subset_closedBall : tangentDisc ⊆ closedBall (plantPt + 19 / 20 * plantDir) (1 / 20) :=
  ball_subset_closedBall

/-- The tangent disc misses its circle. -/
theorem disjoint_tangentDisc_sphere : Disjoint tangentDisc (sphere (plantPt + 19 / 20 * plantDir) (1 / 20)) := by
  rw [disjoint_left]
  intro z hz hs
  rw [tangentDisc, mem_ball] at hz
  rw [mem_sphere] at hs
  linarith

/-- A set inside the small disc about the planted vertex misses one inside the closed tangent disc. -/
theorem disjoint_plantBall_tangent {X Y : Set ℂ} (hX : X ⊆ closedBall plantPt (1 / 10))
    (hY : Y ⊆ closedBall (plantPt + 19 / 20 * plantDir) (1 / 20)) : Disjoint X Y := by
  rw [disjoint_left]
  intro z hx hy
  have h1 := mem_closedBall.mp (hX hx)
  have h2 := tangentDisc_far (mem_closedBall.mp (hY hy))
  linarith

/-- A horn set at the planted vertex within `1/10` lies in the small disc. -/
theorem hornSet_subset_plantBall {α κ₁ κ₂ r : ℝ} (hr : r ≤ 1 / 10) :
    hornSet plantPt α κ₁ κ₂ r ⊆ closedBall plantPt (1 / 10) :=
  fun _ hz => mem_closedBall.mpr (hz.1.le.trans hr)

/-- The tangent disc's circle. -/
theorem tangentCircle_carrier :
    (Arc.circ (plantPt + 19 / 20 * plantDir) (1 / 20) 0 (2 * π)).carrier = sphere (plantPt + 19 / 20 * plantDir) (1 / 20) :=
  carrier_circ_full' _ (by norm_num)

/-- The tangent disc's circle has positive length. -/
theorem tangentCircle_nondegenerate : (Arc.circ (plantPt + 19 / 20 * plantDir) (1 / 20) 0 (2 * π)).Nondegenerate :=
  ⟨by norm_num, by have := Real.pi_pos; linarith, by linarith⟩

/-- The frontier of the tangent disc is its circle's carrier. -/
theorem frontier_tangentDisc :
    frontier tangentDisc = (Arc.circ (plantPt + 19 / 20 * plantDir) (1 / 20) 0 (2 * π)).carrier := by
  rw [tangentCircle_carrier, tangentDisc, frontier_ball _ (by norm_num : (1 / 20 : ℝ) ≠ 0)]

/-! ## A horn against the tangent disc, and the contact it makes -/

/-- **A horn at the planted vertex along `e 0`, between curvatures in `[−3/4, 3/4]` and within `1/10`, lies in the closed disc of
radius `19/20` about the tangent disc's centre** — the inequality behind the validity of the horn models: with `w = z − v = (x, y)` and
`s = x² + y² < 1/100`, `|y| ≤ 3s/8` and `x > 0` give `s ≤ (19/10)(3x/5 + 4y/5)`. -/
theorem horn_ineq {x y : ℝ} (hx : 0 < x) (hs : x ^ 2 + y ^ 2 < 1 / 100) (hlo : -(3 / 8) * (x ^ 2 + y ^ 2) ≤ y)
    (hhi : y ≤ 3 / 8 * (x ^ 2 + y ^ 2)) : x ^ 2 + y ^ 2 ≤ 19 / 10 * (3 / 5 * x + 4 / 5 * y) := by
  set s := x ^ 2 + y ^ 2 with hsdef
  have hs0 : 0 < s := by positivity
  have hy2 : y ^ 2 ≤ (3 / 8 * s) ^ 2 := sq_le_sq' (by linarith) hhi
  have hss : s ^ 2 < s / 100 := by nlinarith
  have hx2 : (157 / 114 * s) ^ 2 < x ^ 2 := by nlinarith
  have hxs : 157 / 114 * s < x := lt_of_pow_lt_pow_left₀ 2 hx.le hx2
  linarith

theorem dist_tangentCentre_le_of_mem_hornSet {κ₁ κ₂ : ℝ} (h1 : -3 / 4 ≤ κ₁) (h2 : κ₂ ≤ 3 / 4) {z : ℂ}
    (hz : z ∈ hornSet plantPt 0 κ₁ κ₂ (1 / 10)) : dist z (plantPt + 19 / 20 * plantDir) ≤ 19 / 20 := by
  obtain ⟨hd, hx, hA, hB⟩ := hz
  unfold TanAbove tanHeight at hA
  unfold TanBelow tanHeight at hB
  rw [frameX_zero, frameY_zero, plantPt_re, plantPt_im] at hA hB
  rw [frameX_zero, plantPt_re] at hx
  have hd2 : dist z plantPt ^ 2 < (1 / 10) ^ 2 := pow_lt_pow_left₀ hd dist_nonneg (by norm_num)
  rw [dist_sq_re_im, plantPt_re, plantPt_im] at hd2
  norm_num at hd2
  set x := z.re - 2 / 5 with hxdef
  set y := z.im - 3 / 10 with hydef
  have hs0 : 0 ≤ x ^ 2 + y ^ 2 := by positivity
  have hs : x ^ 2 + y ^ 2 < 1 / 100 := by linarith
  have hlo : -(3 / 8) * (x ^ 2 + y ^ 2) ≤ y := by nlinarith [mul_nonneg hs0 (by linarith : (0 : ℝ) ≤ κ₁ + 3 / 4)]
  have hhi : y ≤ 3 / 8 * (x ^ 2 + y ^ 2) := by nlinarith [mul_nonneg hs0 (by linarith : (0 : ℝ) ≤ 3 / 4 - κ₂)]
  have key := horn_ineq hx hs hlo hhi
  have hsq : dist z (plantPt + 19 / 20 * plantDir) ^ 2 ≤ (19 / 20) ^ 2 := by
    rw [dist_sq_re_im, tangentCentre_re, tangentCentre_im]
    have e1 : z.re - 97 / 100 = x - 57 / 100 := by rw [hxdef]; ring
    have e2 : z.im - 106 / 100 = y - 76 / 100 := by rw [hydef]; ring
    rw [e1, e2]
    nlinarith
  exact le_of_sq_le_sq hsq (by norm_num)

/-- **Any two points of a horn zone and the tangent disc are less than `1` apart.** -/
theorem dist_lt_one_of_hornZone {x y : ℂ}
    (hx : (dist x plantPt < 1 / 10 ∧ dist x (plantPt + 19 / 20 * plantDir) ≤ 19 / 20) ∨ x ∈ tangentDisc)
    (hy : (dist y plantPt < 1 / 10 ∧ dist y (plantPt + 19 / 20 * plantDir) ≤ 19 / 20) ∨ y ∈ tangentDisc) : dist x y < 1 := by
  rcases hx with ⟨hx1, hx2⟩ | hx <;> rcases hy with ⟨hy1, hy2⟩ | hy
  · have := dist_triangle_right x y plantPt
    linarith
  · have := dist_triangle_right x y (plantPt + 19 / 20 * plantDir)
    rw [tangentDisc, mem_ball] at hy
    linarith
  · have := dist_triangle_right x y (plantPt + 19 / 20 * plantDir)
    rw [tangentDisc, mem_ball] at hx
    linarith
  · have := dist_triangle_right x y (plantPt + 19 / 20 * plantDir)
    rw [tangentDisc, mem_ball] at hx hy
    linarith

/-- **A set inside the small disc about the planted vertex and the tangent disc meets `ω(plantPt)`, in its closure, at the tangent
point only.** -/
theorem closure_inter_sphere_subset {W : Set ℂ} (hW : W ⊆ closedBall plantPt (1 / 10) ∪ tangentDisc) :
    closure W ∩ sphere plantPt 1 ⊆ {plantPt + plantDir} := by
  rintro z ⟨hz, hzs⟩
  have h := closure_mono hW hz
  rw [closure_union, isClosed_closedBall.closure_eq] at h
  rcases h with h | h
  · rw [mem_closedBall] at h
    rw [mem_sphere] at hzs
    linarith
  · rw [← tangentDisc_subset_ball.2]
    exact ⟨h, hzs⟩

/-- **The contact and the cone of a colour whose class lies in `B(plantPt, 1)`, holds the tangent disc, and reaches `ω(plantPt)` at
the tangent point only**: the tangent point is an in-type contact and no out-type one, so the allowed cone is the closed half-plane
`d · plantDir ≥ 0` — it has interior points and does not hold `−plantDir`. -/
theorem ArcMap.tangent_contact_cone {k : ℕ} {G : ArcMap k} {c : Fin k} (hc : c ∈ G.coloursAt plantPt)
    (hsub : G.region c ⊆ ball plantPt 1) (hD : tangentDisc ⊆ G.region c)
    (hcl : closure (G.region c) ∩ sphere plantPt 1 ⊆ {plantPt + plantDir}) :
    G.IsContact plantPt c (plantPt + plantDir) ∧ G.InType plantPt c (plantPt + plantDir) ∧
      -plantDir ∉ G.allowedCone plantPt c ∧ (interior (G.allowedCone plantPt c)).Nonempty := by
  have hw : plantPt + plantDir ∈ closure tangentDisc ∩ sphere plantPt 1 := by rw [tangentDisc_subset_ball.2]; rfl
  have hcontact : G.IsContact plantPt c (plantPt + plantDir) :=
    ⟨hc, by rw [dist_eq_norm, add_sub_cancel_left, norm_plantDir], closure_mono hD hw.1⟩
  have hin : ∀ w, G.InType plantPt c w := fun w T hT _ => hT.subset_region.trans hsub
  -- the tile of the tangent disc has the tangent point in its closure and lies inside `B(plantPt, 1)`: no out-type contact
  have hout : ¬ G.OutType plantPt c (plantPt + plantDir) := by
    intro hO
    have hq : plantPt + 19 / 20 * plantDir ∈ tangentDisc := mem_ball_self (by norm_num)
    have hDI : tangentDisc ⊆ G.interiorPts := fun z hz => (hD hz).1
    have hT : G.IsTile (connectedComponentIn G.interiorPts (plantPt + 19 / 20 * plantDir)) := ⟨_, hDI hq, rfl⟩
    have hDT : tangentDisc ⊆ connectedComponentIn G.interiorPts (plantPt + 19 / 20 * plantDir) :=
      (convex_ball _ _).isPreconnected.subset_connectedComponentIn hq hDI
    have hTc : G.TileOf c (connectedComponentIn G.interiorPts (plantPt + 19 / 20 * plantDir)) := by
      have h := hT.tileOf (hDT hq)
      have hcq : G.col (plantPt + 19 / 20 * plantDir) = c := (hD hq).2
      rwa [hcq] at h
    have hdisj := hO _ hTc (closure_mono hDT hw.1)
    exact disjoint_left.mp hdisj (hDT hq) (mem_closedBall.mpr (by rw [dist_tangentCentre]; norm_num))
  have hcone : ∀ d, d ∈ G.allowedCone plantPt c ↔ 0 ≤ dot d plantDir := by
    intro d
    constructor
    · intro hd
      have := (hd _ hcontact).1 (hin _)
      rwa [add_sub_cancel_left] at this
    · intro hd w hw'
      have hwe : w = plantPt + plantDir := hcl ⟨hw'.2.2, mem_sphere.mpr hw'.2.1⟩
      subst hwe
      exact ⟨fun _ => by rwa [add_sub_cancel_left], fun hO => absurd hO hout⟩
  refine ⟨hcontact, hin _, ?_, ?_⟩
  · rw [hcone, dot_neg_left, dot_self_eq, norm_plantDir]; norm_num
  · refine ⟨plantDir, mem_interior.mpr ⟨ball plantDir (1 / 2), fun d hd => ?_, isOpen_ball, mem_ball_self (by norm_num)⟩⟩
    rw [hcone]
    have h1 : dot d plantDir = dot plantDir plantDir + dot (d - plantDir) plantDir := by rw [dot_sub]; ring
    have h2 := abs_dot_le (d - plantDir) plantDir
    rw [norm_plantDir, mul_one] at h2
    have h3 : ‖d - plantDir‖ < 1 / 2 := by rw [← dist_eq_norm]; exact hd
    rw [h1, dot_self_eq, norm_plantDir]
    linarith [(abs_le.mp h2).1]

end HadwigerNelson.Plane
