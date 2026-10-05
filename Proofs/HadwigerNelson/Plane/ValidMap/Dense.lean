import Proofs.HadwigerNelson.Plane.ValidMap.Terminal
import Proofs.HadwigerNelson.Plane.ValidMap.HexRing
import Proofs.HadwigerNelson.Plane.ValidMap.Cor3

/-!
# Density: discs of radius 1 and 3, row 134's base with unit arcs, a four-colour vertex in every valid map

Wave 5's skeleton (`plans/FS131-w5-kernel-plan.md` § 3). Rows: **FS129-SR2-DISC1TS** with FS112-DISC1 merged (`disc1ts`,
`disc1ts_degree`; the fragment form FS129-OR1-LOCALDENSE reads, `disc1_local`), **FS112-N3-COR3** (`cor3`, moved upstream to `Plane/ValidMap/Cor3`, inventory item 299 (a)), **FS112-N3-BASE**
(`n3_base`), **FS129-OR1-LOCALDENSE** (`localDense`), **FS112-N3-DENSE3** (`dense3`), **FS114-CV-EXISTS** (`cv_exists`), and the
seven-colour control of `Row134BaseUA` (`not_row134BaseUA_seven`). `Row134BaseUA` (the foundation, `Plane/ValidMap/Chain`) is wave 5's
intermediate statement of the base; `row134BaseUA` and its four consumers moved to `Plane/ValidMap/BaseDense`, downstream of the walk's leaves
(`Plane/ValidMap/BaseWalk`, job FS131-KB). FS112-ROTHEX and FS114-BV-HEX, which the walk reads, are stated in `Plane/ValidMap/HexRing`; FS114-CVB-THOM in `Plane/ValidMap/MapGraph` (plan § 8).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS129-SR2-DISC1TS (FS112-DISC1 merged) -/

/-- **FS129-SR2-DISC1TS**, chromaticity form: every closed disc of radius `1` of a valid map of the plane holds a point of at least
three colours — FS106-TS-T's `1/√2 + ε < 1` (`ts_t`). Stronger than FS112-DISC1's "a vertex of degree at least 3" (`disc1ts_degree`).
Inhabitant: `sevenBrickMap` (valid, of the plane). -/
theorem disc1ts (hF : F.Valid) (hP : F.IsPlaneMap) (x : ℂ) : ∃ y ∈ closedBall x 1, 3 ≤ (F.coloursAt y).ncard := by
  have hs : 1 < Real.sqrt 2 := by
    rw [show (1 : ℝ) = Real.sqrt 1 by simp]; exact Real.sqrt_lt_sqrt (by norm_num) (by norm_num)
  have hε : 0 < 1 - 1 / Real.sqrt 2 := by
    rw [sub_pos, div_lt_one (by linarith)]; exact hs
  obtain ⟨y, hy, h3⟩ := ts_t hF hP x hε
  exact ⟨y, by rw [mem_closedBall]; linarith, h3⟩

/-- **FS112-DISC1** as FS129-SR2-DISC1TS states it: every closed disc of radius `1` of a valid map of the plane contains a vertex of
degree at least `3`. -/
theorem disc1ts_degree (hF : F.Valid) (hP : F.IsPlaneMap) (x : ℂ) :
    ∃ y ∈ closedBall x 1, ∃ n, 3 ≤ n ∧ F.HasDegree y n := by
  obtain ⟨y, hy, h3⟩ := disc1ts hF hP x
  obtain ⟨n, hn, hdeg⟩ := exists_hasDegree_of_mem_dom (F := F) (hP ▸ mem_univ y)
  exact ⟨y, hy, n, h3.trans hn, hdeg⟩

/-- **FS112-DISC1 on a fragment** (FS129-OR1-LOCALDENSE's use: "read on a fragment: its argument nests tiles surrounding `x`, each of
diameter at most 1 and so inside `B̄(x, 1)`"): a valid fragment covering `B̄(x, 1)` has a point of at least three colours in `B̄(x, 1)`.
A supporting lemma (the merged row read at the class LOCALDENSE's argument reads). Inhabitant: `sevenBrickMap`. -/
theorem disc1_local (hF : F.Valid) {x : ℂ} (hx : F.Covers x 1) : ∃ y ∈ closedBall x 1, 3 ≤ (F.coloursAt y).ncard := by
  sorry

end ArcMap

/-! ## The seven-colour control: `Row134BaseUA` spends six colours -/

/-- **`Row134BaseUA`'s seven-colour form is false**: the seven-brick map's corner `0` is a cubic trichromatic vertex of a valid
seven-coloured map of the plane with no point of `F(M) ∪ R(M)` in `B̄(0, 2)`, no unit arc anywhere, and no tile enclosing another (its tiles are
open rectangles, whose closures have connected, unbounded complements: `UnenclosedC 0`, FS131-E4's added hypothesis). So the base's six colours
are load-bearing, and the hypothesis is not true for a reason that ignores the colour count. -/
theorem not_row134BaseUA_seven :
    ¬ ∀ (F : ArcMap 7) (u : ℂ), F.Valid → F.Covers u 2 → F.IsCubicTrichromatic u → F.BaseHyp u → F.NoInertNear u →
      F.UnenclosedC u → False := fun h =>
  h sevenBrickMap 0 sevenBrickMap_valid (fun _ _ => mem_univ _) sevenBrick_corner_isCubicTrichromatic (sevenBrick_baseHyp 0)
    (sevenBrick_noInertNear 0) (sevenBrick_unenclosedC 0)

end HadwigerNelson.Plane
