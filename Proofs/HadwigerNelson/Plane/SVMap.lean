import Proofs.HadwigerNelson.Plane.ValidMap.Basic
import Proofs.HadwigerNelson.Instances.Seven

/-!
# Almost-everywhere-proper maps, region-only: lemma (L) and TS-T (FS-106)

Wave 4's skeleton (`plans/FS131-w4-kernel-plan.md` § 7), the two rows FS131-W (Woodall's chain: FS106-WO, FS106-TW, FS106-AE-MAP6,
inventory ruling 54) branches from. Both rows are **region-only** (`plans/FS106-derivation.md`'s header: "a step that reads no colour at
a boundary point"), so both are stated over open colour classes, never over a map's boundaries:

* **FS106-L** (`lemmaL`): in a two-coloured open set `W` (`W ⊆ cl (A ∪ B)`, `A`, `B` open, no two points of one class at distance
  exactly `1`), a point `b ∈ W` with both colours arbitrarily near has its unit circle outside `W`. `b ∈ W` cannot be dropped
  (`not_lemmaL_of_not_mem`: a counterexample with `b` on the frontier of `W`).
* **The regions of an almost-everywhere-proper map** (`AeProperRegions k`, D-AEMAP read region-only): `k` open colour classes, no two
  points of one class at distance `1`, dense union, finitely many components of the classes near every point (S–V's Condition 3). The
  **multicolour** (`multicolour`, D-VMC and S–V's Definition 2) is the set of colours whose class has the point in its closure; its
  `ncard` is the chromaticity. A valid map of the plane gives one (`ArcMap.toAeProperRegions`), and `ArcMap.coloursAt` is its
  multicolour by definition.
* **FS106-TS-T**: a point of chromaticity `≥ 3` within `1/√2 + ε` of every point
  (`AeProperRegions.exists_three_le_multicolour`, SB's route through **Lebesgue's covering theorem** for the square,
  `lebesgue_covering_square` — an outside theorem, its disposition owed, `plans/FS131-w4-kernel-plan.md` § 7) and within `1` (TS's
  form); for arc maps (`ArcMap.ts_t`), a point of chromaticity `≥ 3` has degree `≥ 3` (`ArcMap.exists_hasDegree_of_mem_dom`), at most
  three colours everywhere (S–V Lemma 2's conclusion under Condition 5, not a backlog row) makes it trichromatic, and Condition 6
  (`ArcMap.Condition6`) of degree `3`.
* **The inhabitant**: `sevenBrickMap`, the brick seven-colouring of `Instances/Seven` (M36) as an arc map of the plane, valid.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## FS106-L -/

/-- **FS106-L** (lemma (L), `plans/FS106-V-verification.md` V3 stage 1, region-only): in a two-coloured open set `W` with no
monochrome unit — `W ⊆ cl (A ∪ B)` for open classes `A`, `B`, no two points of one class at distance exactly `1` — a two-colour
change point `b` of `W` (a point of `W` with both colours arbitrarily near) has its unit circle outside `W`. (Disjointness of `A` and
`B` is not read.) -/
theorem lemmaL {A B W : Set ℂ} (hA : IsOpen A) (hB : IsOpen B) (hW : IsOpen W) (hWAB : W ⊆ closure (A ∪ B))
    (hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1) (hBu : ∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) {b : ℂ} (hbW : b ∈ W)
    (hbA : b ∈ closure A) (hbB : b ∈ closure B) : Disjoint (sphere b 1) W := by
  sorry

/-- **Adversary for FS106-L's reading**: the change point must lie in `W`. With `b = 0` on the frontier of `W`, `A` a thin cone at
`0` pointing away from `1` together with the part of `B(1, r)` outside `B̄(0, 1)`, and `B` the opposite cone together with the part of
`B(1, r)` inside, both classes avoid the unit distance, `0 ∈ cl A ∩ cl B`, and `1 ∈ ω(0) ∩ W`. -/
theorem not_lemmaL_of_not_mem :
    ¬ ∀ (A B W : Set ℂ) (b : ℂ), IsOpen A → IsOpen B → IsOpen W → W ⊆ closure (A ∪ B) →
      (∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1) → (∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) → b ∈ closure A → b ∈ closure B →
      Disjoint (sphere b 1) W := by
  sorry

/-! ## The regions of an almost-everywhere-proper map, and the multicolour -/

/-- **The multicolour** of `x` for the colour classes `S` (D-VMC; S–V's Definition 2, "the set of colors assigned to the regions
whose closure contains `u`"): the colours whose class has `x` in its closure. Its `ncard` is the chromaticity of `x`. -/
def multicolour {k : ℕ} (S : Fin k → Set ℂ) (x : ℂ) : Set (Fin k) := {j | x ∈ closure (S j)}

/-- **The regions of an almost-everywhere-proper map-type colouring** (D-AEMAP, region-only): `k` open colour classes (each the union
of the open regions of one colour), no two points of one class at distance exactly `1`, whose union is dense (every point lies in the
closure of a region), with finitely many connected components of the classes meeting a neighbourhood of each point (S–V's
Condition 3, read on regions). Boundaries and vertices are never read. -/
structure AeProperRegions (k : ℕ) where
  /-- The colour classes: the union of the open regions of each colour. -/
  cls : Fin k → Set ℂ
  /-- Each class is open. -/
  isOpen_cls : ∀ j, IsOpen (cls j)
  /-- Almost-everywhere-properness: no two points of one class at distance exactly `1`. -/
  dist_ne_one : ∀ j, ∀ x ∈ cls j, ∀ y ∈ cls j, dist x y ≠ 1
  /-- Every point lies in the closure of a region. -/
  dense : Dense (⋃ j, cls j)
  /-- Finitely many regions (components of the classes) meet a neighbourhood of each point. -/
  locallyFinite : ∀ x, ∃ t ∈ 𝓝 x,
    {C : Set ℂ | ∃ j, ∃ y ∈ cls j, C = connectedComponentIn (cls j) y ∧ (C ∩ t).Nonempty}.Finite

/-- The multicolour reads the closures of the classes: with classes `B(0, 1)` and `B(2, 1)`, both colours are at `1`. -/
example : multicolour (![ball (0 : ℂ) 1, ball 2 1] : Fin 2 → Set ℂ) 1 = univ := by
  ext j
  simp only [multicolour, mem_setOf_eq, mem_univ, iff_true]
  fin_cases j
  · show (1 : ℂ) ∈ closure (ball 0 1)
    rw [closure_ball _ one_ne_zero, mem_closedBall, dist_zero_right]; simp
  · show (1 : ℂ) ∈ closure (ball 2 1)
    rw [closure_ball _ one_ne_zero, mem_closedBall, dist_comm, dist_eq_norm]; norm_num

/-- **Adversary**: a point outside every closure has empty multicolour. -/
example : multicolour (![ball (0 : ℂ) 1, ball 2 1] : Fin 2 → Set ℂ) (5 * I) = ∅ := by
  ext j
  simp only [multicolour, mem_setOf_eq, mem_empty_iff_false, iff_false]
  fin_cases j
  · show (5 * I : ℂ) ∉ closure (ball 0 1)
    rw [closure_ball _ one_ne_zero, mem_closedBall, dist_zero_right]; simp
  · show (5 * I : ℂ) ∉ closure (ball 2 1)
    rw [closure_ball _ one_ne_zero, mem_closedBall, dist_eq_norm]
    have : ‖(5 * I - 2 : ℂ)‖ ^ 2 = 29 := by
      rw [← Complex.normSq_eq_norm_sq]; simp [Complex.normSq_apply]; norm_num
    nlinarith [norm_nonneg (5 * I - 2 : ℂ)]

/-! ## Lebesgue's covering theorem for the square (an outside theorem) -/

/-- The closed axis-parallel square `[c.re, c.re + s] × [c.im, c.im + s]`. -/
def closedSquare (c : ℂ) (s : ℝ) : Set ℂ := {z | c.re ≤ z.re ∧ z.re ≤ c.re + s ∧ c.im ≤ z.im ∧ z.im ≤ c.im + s}

/-- **Lebesgue's covering theorem for the square** (`n = 2`): if a closed square is covered by finitely many closed sets none of
which meets two opposite sides, some point of the square lies in three of them. Hurewicz–Wallman, *Dimension Theory* (1941), Thm IV 2
(the `n`-cube, `n + 1` sets); SB's step 6 (`plans/FS106-SB-verification.md` § 2.5). **An outside theorem, its disposition owed**
(`plans/FS131-w4-kernel-plan.md` § 7: a separate formalization job, or an `axiom` with `LEAN.md` § Assumptions' four items). -/
theorem lebesgue_covering_square {m : ℕ} (c : ℂ) {s : ℝ} (hs : 0 < s) (F : Fin m → Set ℂ) (hF : ∀ i, IsClosed (F i))
    (hcov : closedSquare c s ⊆ ⋃ i, F i)
    (hLR : ∀ i, ¬ ((∃ z ∈ F i ∩ closedSquare c s, z.re = c.re) ∧ ∃ z ∈ F i ∩ closedSquare c s, z.re = c.re + s))
    (hBT : ∀ i, ¬ ((∃ z ∈ F i ∩ closedSquare c s, z.im = c.im) ∧ ∃ z ∈ F i ∩ closedSquare c s, z.im = c.im + s)) :
    ∃ z ∈ closedSquare c s, ∃ i j l : Fin m, i ≠ j ∧ i ≠ l ∧ j ≠ l ∧ z ∈ F i ∧ z ∈ F j ∧ z ∈ F l := by
  sorry

/-! ## FS106-TS-T, region-only -/

namespace AeProperRegions

variable {k : ℕ} (R : AeProperRegions k)

/-- **FS106-TS-T** (SB's form, `plans/FS106-SB-verification.md` § 2.5): every point `z` of an almost-everywhere-proper map has a point
of chromaticity at least `3` within `1/√2 + ε`, for every `ε > 0`. -/
theorem exists_three_le_multicolour (z : ℂ) {ε : ℝ} (hε : 0 < ε) :
    ∃ x, dist x z < 1 / Real.sqrt 2 + ε ∧ 3 ≤ (multicolour R.cls x).ncard := by
  sorry

/-- **FS106-TS-T** in TS's form (`plans/FS106-TS-derivation.md` § 2.4): a point of chromaticity at least `3` within distance `1`
(strictly). -/
theorem exists_three_le_multicolour_lt_one (z : ℂ) : ∃ x, dist x z < 1 ∧ 3 ≤ (multicolour R.cls x).ncard := by
  sorry

end AeProperRegions

/-! ## FS106-TS-T for arc maps, with Conditions 5 and 6 -/

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- The colours at a point are the multicolour of the colour classes (by definition). -/
theorem coloursAt_eq_multicolour (x : ℂ) : F.coloursAt x = multicolour F.region x := rfl

variable {F}

/-- In a map of the plane, finitely many tiles meet a neighbourhood of each point, and the components of a colour class are its
tiles — so the regions are locally finite (wave 3's `finite_tiles_near`). -/
theorem region_locallyFinite (hP : F.IsPlaneMap) (x : ℂ) : ∃ t ∈ 𝓝 x,
    {C : Set ℂ | ∃ j, ∃ y ∈ F.region j, C = connectedComponentIn (F.region j) y ∧ (C ∩ t).Nonempty}.Finite := by
  sorry

/-- In a map of the plane the colour classes have dense union (wave 3's `dense_interiorPts`). -/
theorem dense_iUnion_region (hP : F.IsPlaneMap) : Dense (⋃ j, F.region j) := by
  sorry

/-- **A valid map of the plane gives the regions of an almost-everywhere-proper map**: its colour classes. -/
noncomputable def toAeProperRegions (hF : F.Valid) (hP : F.IsPlaneMap) : AeProperRegions k where
  cls := F.region
  isOpen_cls := F.isOpen_region
  dist_ne_one := fun j x hx y hy hxy => hF x hx.1 y hy.1 hxy (by rw [hx.2, hy.2])
  dense := dense_iUnion_region hP
  locallyFinite := region_locallyFinite hP

/-- **FS106-TS-T for a valid map of the plane**: a point of at least three colours within `1/√2 + ε` of every point. -/
theorem ts_t (hF : F.Valid) (hP : F.IsPlaneMap) (z : ℂ) {ε : ℝ} (hε : 0 < ε) :
    ∃ x, dist x z < 1 / Real.sqrt 2 + ε ∧ 3 ≤ (F.coloursAt x).ncard := by
  sorry

/-- **TS-T's vertex step**: a point of the domain has a finite degree, at least its number of colours (each colour at the point
contributes a sector). So a point of chromaticity `≥ 3` is a vertex of degree `≥ 3`. -/
theorem exists_hasDegree_of_mem_dom {x : ℂ} (hx : x ∈ F.dom) : ∃ n, (F.coloursAt x).ncard ≤ n ∧ F.HasDegree x n := by
  sorry

/-- **FS106-TS-T, Condition 5's clause**, over its conclusion: where every point carries at most three colours (S–V Lemma 2 almost
everywhere under Condition 5 — SB § 2.1 A5, not a backlog row; for arc maps FS110-NB-4's conclusion, as inventory ruling 53 states
FS110-N4-STUCK), the point TS-T finds is trichromatic, of degree at least `3`. -/
theorem ts_t_trichromatic (hF : F.Valid) (hP : F.IsPlaneMap) (h3 : ∀ x, (F.coloursAt x).ncard ≤ 3) (z : ℂ) {ε : ℝ}
    (hε : 0 < ε) : ∃ x, dist x z < 1 / Real.sqrt 2 + ε ∧ (F.coloursAt x).ncard = 3 ∧ ∃ n, 3 ≤ n ∧ F.HasDegree x n := by
  sorry

/-- **FS106-TS-T, Condition 6's clause** (closing S–V Lemma 4 (a) under Conditions 5–6): with at most three colours everywhere and
Condition 6, the point TS-T finds is a trichromatic vertex of degree exactly `3`. -/
theorem ts_t_degree_three (hF : F.Valid) (hP : F.IsPlaneMap) (h3 : ∀ x, (F.coloursAt x).ncard ≤ 3) (h6 : F.Condition6)
    (z : ℂ) {ε : ℝ} (hε : 0 < ε) :
    ∃ x, dist x z < 1 / Real.sqrt 2 + ε ∧ (F.coloursAt x).ncard = 3 ∧ F.HasDegree x 3 := by
  sorry

end ArcMap

/-! ## The inhabitant: the brick seven-colouring as an arc map of the plane -/

/-- The lower-left corner `((2/5) r + (4/5) c, (3/5) r)` of the cell `(c, r)` of `sevenBrick` (`Instances/Seven`). -/
noncomputable def brickCorner (c r : ℤ) : ℂ := ((2 / 5 * r + 4 / 5 * c : ℝ) : ℂ) + ((3 / 5 * r : ℝ) : ℂ) * I

/-- The cell edges of `sevenBrick`: each cell's bottom edge and left edge. -/
noncomputable def sevenBrickArcs : Set Arc :=
  ⋃ c : ℤ, ⋃ r : ℤ, {Arc.seg (brickCorner c r) (brickCorner (c + 1) r),
    Arc.seg (brickCorner c r) (brickCorner c r + ((3 / 5 : ℝ) : ℂ) * I)}

/-- Every cell edge has positive length. -/
theorem sevenBrickArcs_nondegenerate : ∀ a ∈ sevenBrickArcs, a.Nondegenerate := by
  sorry

/-- Finitely many cell edges meet a neighbourhood of each point. -/
theorem sevenBrickArcs_locallyFinite : ∀ x ∈ (univ : Set ℂ), ∃ t ∈ 𝓝 x,
    {a | a ∈ sevenBrickArcs ∧ (a.carrier ∩ t).Nonempty}.Finite := by
  sorry

/-- The brick colour is locally constant off the cell edges. -/
theorem sevenBrick_color_locallyConstant : ∀ x ∈ (univ : Set ℂ), x ∉ ⋃ a ∈ sevenBrickArcs, a.carrier →
    ∀ᶠ y in 𝓝 x, sevenBrick.color y = sevenBrick.color x := by
  sorry

/-- **The brick seven-colouring as an arc map of the plane** — the inhabitant of "a valid map of the plane". -/
noncomputable def sevenBrickMap : ArcMap 7 where
  dom := univ
  isOpen_dom := isOpen_univ
  arcs := sevenBrickArcs
  nondegenerate := sevenBrickArcs_nondegenerate
  locallyFinite := sevenBrickArcs_locallyFinite
  col := sevenBrick.color
  locallyConstant := sevenBrick_color_locallyConstant

/-- `sevenBrickMap` is a map of the plane. -/
theorem sevenBrickMap_isPlaneMap : sevenBrickMap.IsPlaneMap := rfl

/-- `sevenBrickMap` is valid: the brick colouring is proper at every unit pair (`Brick.avoids`, M36). -/
theorem sevenBrickMap_valid : sevenBrickMap.Valid := fun x _ y _ hxy =>
  sevenBrick.avoids (List.mem_singleton.mpr rfl) sevenBrick_check (by rw [hxy]; simp)

/-- The regions of an almost-everywhere-proper map exist: `sevenBrickMap`'s (the inhabitant of `AeProperRegions`). -/
noncomputable def sevenBrickRegions : AeProperRegions 7 :=
  sevenBrickMap.toAeProperRegions sevenBrickMap_valid sevenBrickMap_isPlaneMap

end HadwigerNelson.Plane
