import Proofs.HadwigerNelson.Plane.Woodall.NoFourFive

/-!
# Woodall's step 3, localized: finitely many merges on a ball (FS131-E3's E3-W, E3-NICE, E3-BALL)

FS131-W3's skeleton (`plans/FS131-W-kernel-plan.md` § 14) for `exists_woodallMerged`, the modification Woodall's chain reads
(`plans/FS131-E3-derivation.md` §§ 3.2–3.4): every valid arc map of the plane has a valid arc map of the plane, Condition 5 kept, in which
every point of `closedBall 0 R` of three or more colours is `NiceAt`.

* **Recolouring** (`ArcMap.recolour`): a set `W` whose frontier lies on finitely many new arcs is given one colour; nothing else moves. Its
  validity is a statement about `W` alone (`recolour_valid`), its Condition 5 one about the new arcs (`recolour_condition5`), and off
  `closure W` and the new arcs the regions are unchanged (`recolour_region_diff`).
* **E3-W** (`clear_wedge`): two open ray segments in the closure of an open set `S` with null unit pairs, less than `π` apart, clear the wedge
  between them of `S`'s unit distance up to radius `r₁ cos(α/2)/2` (the sagitta). E3's hypothesis "`ω(v)` misses `S`" is not needed: the
  segments put `v` in `closure S`, and wave 1's `dist_ne_one_of_mem_of_mem_closure` gives it.
* **The merge at a wedge** (`wedgeMerge`, `wedgeMerge_valid`, `wedgeMerge_condition5`, `wedgeMerge_region_diff`): the recolouring of the open
  annular sector `annSector v 0 ρ d₁ d₂` with `c`, bounded by two segments and an arc of radius `ρ`.
* **Locality** (`coloursAt_congr`, `niceAt_congr`): the colours at a point and `NiceAt` depend only on the regions near it.
* **The local data at a point** (`DirColourAt`): finitely many exceptional directions, off which a thin open cone lies in one colour class.
  Wave 3's wedge lemma (`GoodAt.exists_wedge`) gives it at every point of the domain (`exists_dirColourAt`); the `NiceAt` picture is built from
  it (`niceAt_of_dirColourAt`); in a good ball only the centre carries three colours (`GoodAt.ncard_coloursAt_le_two`), so three-colour points
  are finite on compact sets (`finite_three_le_coloursAt`).
* **E3-NICE** (`exists_merge_at`): merging at one point until it, and every new point of three colours near it, is `NiceAt`.
* **E3-BALL** (`exists_woodallMerged`): finitely many such merges on `closedBall 0 R`.

No statement here reads `localSectors` (FS131-I3i): wave 3's landed `GoodAt` engine gives every local fact the merge needs (§ 14.3).

**Inhabitants.** `recolour`, `wedgeMerge` and `DirColourAt` are defined for any arc map; the theorems over a valid map of the plane with any
number of colours are inhabited by `sevenBrickMap` (`sevenBrickMap_valid`, `sevenBrickMap_isPlaneMap`, `Plane/SVMap`); `DirColourAt` has its spec
example on the one-colour plane below; `clear_wedge` is region-only (any open set with null unit pairs and two such segments: E3's model, a
two-sector colour class of diameter below `1`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- `φ` is off the finitely many directions `D`, mod `2π`. -/
def OffDirs (D : Finset ℝ) (φ : ℝ) : Prop := ∀ δ ∈ D, ∀ m : ℤ, φ ≠ δ + 2 * π * m

/-- **E3-W, Woodall's criterion with a radius** (`plans/FS131-E3-derivation.md` § 3.2; `[Woodall1973]` p. 197, step 3, asserts it without a
radius: "each unit circle through Q, except for those through P, passes through X or Y"): if the open segments from `v` in the directions
`d₁ < d₂ < d₁ + π`, of length `r₁ < cos(α/2)/2` (`α = d₂ − d₁`), lie in the closure of an open set `S` with null unit pairs, then no point of the
open wedge between them within `r₁ cos(α/2)/2` of `v` is at distance `1` from a point of `S`. -/
theorem clear_wedge {S : Set ℂ} (hS : IsOpen S) (hnull : UnitPairsNull S) {v : ℂ} {d₁ d₂ r₁ : ℝ} (hd : d₁ < d₂)
    (hπ : d₂ - d₁ < π) (hr₁ : 0 < r₁) (hr₁c : r₁ < Real.cos ((d₂ - d₁) / 2) / 2)
    (hseg : ∀ s ∈ Ioo 0 r₁, v + (s : ℂ) * e d₁ ∈ closure S ∧ v + (s : ℂ) * e d₂ ∈ closure S) :
    ∀ z ∈ annSector v 0 (r₁ * Real.cos ((d₂ - d₁) / 2) / 2) d₁ d₂, ∀ y ∈ S, dist z y ≠ 1 := by
  sorry

/-- The boundary of the open annular sector `annSector v 0 ρ d₁ d₂`: its two edges and its outer arc. -/
noncomputable def wedgeArcs (v : ℂ) (ρ d₁ d₂ : ℝ) : Set Arc :=
  {Arc.seg v (v + (ρ : ℂ) * e d₁), Arc.seg v (v + (ρ : ℂ) * e d₂), Arc.circ v ρ d₁ d₂}

/-- The wedge's arcs have positive length. -/
theorem wedgeArcs_nondegenerate {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π) :
    ∀ a ∈ wedgeArcs v ρ d₁ d₂, a.Nondegenerate := by
  sorry

/-- The frontier of the open annular sector lies on its two edges and its outer arc. -/
theorem frontier_annSector_subset {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π) :
    frontier (annSector v 0 ρ d₁ d₂) ⊆ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier := by
  sorry

namespace ArcMap

variable {k : ℕ}

/-! ## Recolouring a set bounded by new arcs -/

/-- **Recolouring** `W` with the colour `c`: the arcs of `F` and the finitely many arcs `B`, which carry the frontier of `W`; the colour `c` on
`W` and `F`'s colour elsewhere. The colour is locally constant off the arcs because a point off `frontier W` lies in the interior of `W` or of
its complement. -/
noncomputable def recolour (F : ArcMap k) (W : Set ℂ) (B : Set Arc) (hB : ∀ a ∈ B, a.Nondegenerate) (hBf : B.Finite)
    (hW : frontier W ⊆ ⋃ a ∈ B, a.carrier) (c : Fin k) : ArcMap k where
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
  col := by classical exact fun z => if z ∈ W then c else F.col z
  locallyConstant := by
    classical
    intro x hx hxΓ
    have hxF : x ∉ ⋃ a ∈ F.arcs, a.carrier := fun h => hxΓ (by
      obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp h
      exact mem_iUnion₂.mpr ⟨a, Or.inl ha, hxa⟩)
    have hxW : x ∉ frontier W := fun h => hxΓ (by
      obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp (hW h)
      exact mem_iUnion₂.mpr ⟨a, Or.inr ha, hxa⟩)
    by_cases hx' : x ∈ W
    · have hint : x ∈ interior W := by
        by_contra hni
        exact hxW ⟨subset_closure hx', hni⟩
      filter_upwards [mem_interior_iff_mem_nhds.mp hint] with y hy
      simp [hy, hx']
    · have hcl : x ∉ closure W := fun h => hxW ⟨h, fun hi => hx' (interior_subset hi)⟩
      filter_upwards [isClosed_closure.isOpen_compl.mem_nhds hcl, F.locallyConstant x hx hxF] with y hy hyc
      have hyW : y ∉ W := fun h => hy (subset_closure h)
      simp [hyW, hx', hyc]

variable {F : ArcMap k} {W : Set ℂ} {B : Set Arc} {hB : ∀ a ∈ B, a.Nondegenerate} {hBf : B.Finite}
  {hW : frontier W ⊆ ⋃ a ∈ B, a.carrier} {c : Fin k}

/-- Recolouring keeps the domain, so a map of the plane stays one. -/
theorem recolour_isPlaneMap (hP : F.IsPlaneMap) : (F.recolour W B hB hBf hW c).IsPlaneMap := hP

/-- The interior points of the recoloured map are interior points of `F` (the arcs only grow). -/
theorem interiorPts_recolour_subset : (F.recolour W B hB hBf hW c).interiorPts ⊆ F.interiorPts := by
  rintro x ⟨hx, hxΓ⟩
  exact ⟨hx, fun h => hxΓ (by
    obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp h
    exact mem_iUnion₂.mpr ⟨a, Or.inl ha, hxa⟩)⟩

/-- **Validity of a recolouring** is a statement about `W`: no unit pair inside `W`, and none between `W` and `F`'s class of `c`. -/
theorem recolour_valid (hF : F.Valid) (hWW : ∀ x ∈ W, ∀ y ∈ W, dist x y ≠ 1)
    (hWc : ∀ x ∈ W, ∀ y ∈ F.region c, dist x y ≠ 1) : (F.recolour W B hB hBf hW c).Valid := by
  sorry

/-- **Condition 5 is kept** when no new arc meets a unit circle in infinitely many points. -/
theorem recolour_condition5 (h5 : F.Condition5) (hB5 : ∀ a ∈ B, ∀ p, (a.carrier ∩ sphere p 1).Finite) :
    (F.recolour W B hB hBf hW c).Condition5 := by
  rintro a (ha | ha) p
  · exact h5 a ha p
  · exact (hB5 a ha p).subset fun z hz => ⟨hz.1.1, hz.2⟩

/-- **Off `closure W` and the new arcs, the regions are unchanged.** -/
theorem recolour_region_diff (j : Fin k) :
    (F.recolour W B hB hBf hW c).region j \ (closure W ∪ ⋃ a ∈ B, a.carrier) =
      F.region j \ (closure W ∪ ⋃ a ∈ B, a.carrier) := by
  sorry

/-! ## The merge at a wedge -/

/-- **The merge at a wedge** (E3-NICE's single merge): `F` recoloured with `c` on the open annular sector of radius `ρ` between the directions
`d₁ < d₂ ≤ d₁ + 2π`, its two edges and its outer arc added to the arcs. -/
noncomputable def wedgeMerge (F : ArcMap k) (v : ℂ) {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π)
    (c : Fin k) : ArcMap k :=
  F.recolour (annSector v 0 ρ d₁ d₂) (wedgeArcs v ρ d₁ d₂) (wedgeArcs_nondegenerate hρ hd hd2)
    (((finite_singleton _).insert _).insert _) (frontier_annSector_subset hρ hd hd2) c

/-- **The merge at a wedge is valid** (E3-W): the two edges in the closure of `F`'s class of `c`, less than `π` apart, and the radius within
E3-W's bound. -/
theorem wedgeMerge_valid (hF : F.Valid) {v : ℂ} {ρ d₁ d₂ r₁ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hπ : d₂ - d₁ < π) (hr₁ : 0 < r₁)
    (hr₁c : r₁ < Real.cos ((d₂ - d₁) / 2) / 2) (hρr : ρ ≤ r₁ * Real.cos ((d₂ - d₁) / 2) / 2)
    (hseg : ∀ s ∈ Ioo 0 r₁, v + (s : ℂ) * e d₁ ∈ closure (F.region c) ∧ v + (s : ℂ) * e d₂ ∈ closure (F.region c)) :
    (F.wedgeMerge v hρ hd (by linarith [Real.pi_pos]) c).Valid := by
  sorry

/-- **The merge at a wedge keeps Condition 5**: its new arcs are two segments and an arc of radius `ρ < 1`. -/
theorem wedgeMerge_condition5 (h5 : F.Condition5) {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hρ1 : ρ < 1) (hd : d₁ < d₂)
    (hd2 : d₂ ≤ d₁ + 2 * π) : (F.wedgeMerge v hρ hd hd2 c).Condition5 := by
  sorry

/-- **The merge at a wedge changes nothing off `closedBall v ρ`.** -/
theorem wedgeMerge_region_diff {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π) (j : Fin k) :
    (F.wedgeMerge v hρ hd hd2 c).region j \ closedBall v ρ = F.region j \ closedBall v ρ := by
  sorry

/-! ## Locality -/

/-- **The colours at a point depend only on the regions near it.** -/
theorem coloursAt_congr {F F' : ArcMap k} {w : ℂ} {U : Set ℂ} (hU : U ∈ 𝓝 w)
    (h : ∀ j, F.region j ∩ U = F'.region j ∩ U) : F.coloursAt w = F'.coloursAt w := by
  sorry

/-- **`NiceAt` depends only on the regions near the point** (and on its being in the domain): pictures read cones, and cones are local. -/
theorem niceAt_congr {F F' : ArcMap k} {w : ℂ} {U : Set ℂ} (hU : U ∈ 𝓝 w) (hdom : w ∈ F.dom ↔ w ∈ F'.dom)
    (h : ∀ j, F.region j ∩ U = F'.region j ∩ U) : F.NiceAt w ↔ F'.NiceAt w := by
  sorry

/-! ## The local data at a point -/

/-- **The local data at `v`**: off the finitely many directions `D` (mod `2π`), a thin open cone about each direction `φ` lies in the colour
class `σ φ`. With `D` the tangent directions at `v` of the arcs through `v`, wave 3's wedge lemma gives it at every point of the domain
(`exists_dirColourAt`). `D` may hold invisible directions (an arc between two sides of one colour); the colour classes' cones off `D` are read
from `σ` alone. -/
def DirColourAt (F : ArcMap k) (v : ℂ) (D : Finset ℝ) (σ : ℝ → Fin k) : Prop :=
  ∀ φ : ℝ, OffDirs D φ → ∃ r > 0, annSector v 0 r (φ - r) (φ + r) ⊆ F.region (σ φ)

/-- Spec example: the one-colour plane has the local data `D = ∅`, `σ = 0` at every point. -/
example (v : ℂ) : (ArcMap.const univ isOpen_univ (0 : Fin 1)).DirColourAt v ∅ fun _ => 0 :=
  fun _ _ => ⟨1, one_pos, fun _ _ => ⟨by simp, rfl⟩⟩

/-- **The local data exists at every point of the domain** — from `exists_goodAt` and `GoodAt.exists_wedge` (wave 3, landed); no
`localSectors`. -/
theorem exists_dirColourAt {v : ℂ} (hv : v ∈ F.dom) : ∃ (D : Finset ℝ) (σ : ℝ → Fin k), F.DirColourAt v D σ := by
  sorry

/-- **In a good ball only the centre carries three colours**: every other point lies on at most one full curve of arcs
(`GoodAt.exists_local_curve`), which it has two sides of. -/
theorem GoodAt.ncard_coloursAt_le_two {x : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt x ρ₀) {z : ℂ} (hz : z ∈ ball x ρ₀) (hzx : z ≠ x) :
    (F.coloursAt z).ncard ≤ 2 := by
  sorry

/-- **Points of three or more colours are finite on a compact subset of the domain** (finitely many good balls cover it, each holding at
most its centre). -/
theorem finite_three_le_coloursAt {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ F.dom) :
    {v ∈ K | 3 ≤ (F.coloursAt v).ncard}.Finite := by
  sorry

/-- **The `NiceAt` picture from the local data** (E3-NICE's last paragraph): if every colour's directions off `D` form one arc of the circle
(`hrun`) and no colour's cone meets a direction of `D` strictly inside another colour's arc (`hpoke`), a point of three or more colours is
`NiceAt` — the arcs, in order, are the positive sectors, and at each change of colour the other colours whose cones hold that direction are
horns, each once. -/
theorem niceAt_of_dirColourAt {v : ℂ} (hv : v ∈ F.dom) {D : Finset ℝ} {σ : ℝ → Fin k} (hD : F.DirColourAt v D σ)
    (hrun : ∀ φ₁ φ₂ : ℝ, OffDirs D φ₁ → OffDirs D φ₂ → φ₁ < φ₂ → φ₂ < φ₁ + 2 * π → σ φ₁ = σ φ₂ →
      (∀ φ ∈ Ioo φ₁ φ₂, OffDirs D φ → σ φ = σ φ₁) ∨ (∀ φ ∈ Ioo φ₂ (φ₁ + 2 * π), OffDirs D φ → σ φ = σ φ₁))
    (hpoke : ∀ δ ∈ D, ∀ j c : Fin k, δ ∈ coneAt (F.region j) v →
      (∃ t > 0, ∀ φ ∈ Ioo (δ - t) (δ + t), OffDirs D φ → σ φ = c) → j = c)
    (h3 : 3 ≤ (F.coloursAt v).ncard) : F.NiceAt v := by
  sorry

/-! ## E3-NICE and E3-BALL -/

/-- **E3-NICE, the merge at one point** (`plans/FS131-E3-derivation.md` § 3.3): for every `ε > 0` there are `ρ ∈ (0, ε)` and a valid map of the
plane, Condition 5 kept, equal to `F` off `closedBall v ρ`, in which every point of `closedBall v ρ` of three or more colours is `NiceAt` —
finitely many merges at wedges (`wedgeMerge`) of decreasing radii, each across a gap of angle `< π` between two arcs of one colour, or across a
colour poking into another's arc, until the local data at `v` satisfies `niceAt_of_dirColourAt`; the new points of three colours are crossings
of the merges' outer arcs with branches, `NiceAt` by the same lemma. -/
theorem exists_merge_at (hF : F.Valid) (hP : F.IsPlaneMap) (v : ℂ) {ε : ℝ} (hε : 0 < ε) :
    ∃ ρ ∈ Ioo 0 ε, ∃ F' : ArcMap k, F'.Valid ∧ F'.IsPlaneMap ∧ (F.Condition5 → F'.Condition5) ∧
      (∀ j, F'.region j \ closedBall v ρ = F.region j \ closedBall v ρ) ∧ F'.WoodallMerged (closedBall v ρ) := by
  sorry

/-- **Woodall's step 3, localized** (FS131-E3's E3-BALL, `plans/FS131-E3-derivation.md` § 3.4; `[Woodall1973]` p. 197 for the merge): every
valid map of the plane has a valid map of the plane, Condition 5 kept, in which every point of `closedBall 0 R` of three or more colours is
`NiceAt` — the points of three colours in the ball are finite (`finite_three_le_coloursAt`), and one merge (`exists_merge_at`), within less
than their distance to the others, removes one bad point and adds none (`coloursAt_congr`, `niceAt_congr` off the merged ball). Not claimed:
Woodall's horn-only conclusion, at every point (a GAP past Condition 5, inventory item 161 (b)). -/
theorem exists_woodallMerged (hF : F.Valid) (hP : F.IsPlaneMap) (R : ℝ) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.IsPlaneMap ∧ F'.WoodallMerged (closedBall 0 R) ∧ (F.Condition5 → F'.Condition5) := by
  sorry

end ArcMap

end HadwigerNelson.Plane
