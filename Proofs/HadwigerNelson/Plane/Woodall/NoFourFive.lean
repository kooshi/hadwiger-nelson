import Proofs.HadwigerNelson.Plane.Woodall.Collar
import Proofs.HadwigerNelson.Plane.Tiles

/-!
# No point of four or five sectors: FS131-E1's lemmas over arc maps (E1-SEE, E1-RAY, E1-CROSS, E1-COVER, E1-BAD)

FS131-W2's skeleton (`plans/FS131-W-kernel-plan.md` §§ 7–8). FS131-E1 (`plans/FS131-E1-derivation.md` § 3) restores Woodall's Theorem 6 for arc
maps with one lemma in place of his steps 7–8 and of step 5's equality case: **E1-NO45**, no point of four or five sectors in a five-colour valid
map in normal form (`ArcMap.false_of_four_le_sectors`, `Plane/Woodall/Steps`). Its lemmas, read on W's colour-change picture (`ArcMap.SectorsAt`):

* **E1-SEE** (`ArcMap.not_mem_coloursAt_of_dist_eq_one`): a point at distance `1` from an interior point of colour `j` does not carry `j`.
  The robust form (`ArcMap.not_mem_coloursAt_of_collarAt`): a point `v + e ψ` whose inner and outer collars both lie in the shadow of `j`'s class
  does not carry `j`.
* **E1-RAY** (`ArcMap.SectorsAt.collarAt_shadow_inner_of_mem`, `_outer_of_mem`): a sector at `v` holding a direction `γ` with `cos (γ − ψ) < 0`
  (`> 0`) puts an inner (outer) collar about `ψ` in its colour's shadow.
* **E1-CROSS** (`ArcMap.SectorsAt.not_mem_range_of_crossesAt`): a colour whose class reaches `v + e θ` from inside and from outside `ω(v)`
  (`ArcMap.CrossesAt`) is carried by no sector at `v`.
* **E1-COVER** (`ArcMap.SectorsAt.false_of_ncard_le_two_on_arc`), in E1-GEN6's form and read on colour classes (§ 7.3 (a)): at a point whose
  picture has positive angles and at most one colour absent, no open arc of `ω(v)` longer than `π/3` has at most two colours at each of its
  points. Through: the local structure off crossings (`ArcMap.exists_side_colours_of_not_crossesAt`), one colour class along the arc
  (`ArcMap.exists_closure_colour_of_arc`), and the diameter of a connected subset of a closure (`dist_le_one_of_subset_closure`).
* **E1-BAD** (`ArcMap.SectorsAt.exists_two_absent`), corrected (§ 7.4) and in its robust form (§ 7.3 (b)): at a point of `n ≥ 3` sectors of
  distinct colours with angles in `(0, π]`, off at most `n` angles every point `v + e ψ` of `ω(v)` lacks two colours of the picture. Through:
  interior directions (`ArcMap.SectorsAt.not_mem_coloursAt_of_mem_Ioo`), and at each edge **the refined second-order lemma**
  (`ArcMap.SectorsAt.exists_normal_collarAt`: one of the edge's two normals carries an inner collar in the shadow of both adjacent colours),
  from the colour of one tangent parabola, of curvature `1/2` (`ArcMap.SectorsAt.exists_parabola_region`), and its collar
  (`collarAt_shadow_of_parabola`).

E1-NOBRANCH is `ArcMap.exists_three_le_sectors` (`Plane/Woodall/Steps`, over wave 4's `ts_t`): the Jordan curve theorem is not needed (§ 7.5).

**Inhabitants.** `ArcMap.CrossesAt` has its spec example and adversary below. The `SectorsAt` hypotheses with no validity are inhabited by
`ArcMap.const_sectorsAt` (one sector); those over a valid map of the plane with a picture of two or three sectors by `sevenBrickMap`
(`sevenBrickMap_valid`, `sevenBrickMap_isPlaneMap`, `Plane/SVMap`) at a brick corner (three sectors of angles `π`, `π/2`, `π/2`), its picture by
`exists_sectorsAt`; E1-COVER concludes `False` (a refutation).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Region-only tools -/

/-- **A connected subset of the closure of an open set with null unit pairs has every two points at distance at most `1`** (the closure form of
FS106-DIAM; it replaces E1-COVER (d)'s one-region step and E1-NOBRANCH (i)): for `x, y` at distance `> 1`, a point `z ∈ U` near `x` sees the
value `1` of `dist z ·` on the subset (`dist_lt_one_of_isPreconnected`), at a point of `closure U` (`dist_ne_one_of_mem_of_mem_closure`). -/
theorem dist_le_one_of_subset_closure {U S : Set ℂ} (hU : IsOpen U) (hnull : UnitPairsNull U) (hS : IsPreconnected S)
    (hSU : S ⊆ closure U) {x y : ℂ} (hx : x ∈ S) (hy : y ∈ S) : dist x y ≤ 1 := by
  sorry

/-- **Sharpness of `dist_le_one_of_subset_closure`**: the closed disc of radius `1/2` is the closure of an open set with no unit pair, and holds
two points at distance exactly `1` — so `≤ 1` cannot be strengthened to `< 1` (FS106-DIAM's strict form is for the open set itself). -/
example : ∃ x ∈ closure (ball (0 : ℂ) (1 / 2)), ∃ y ∈ closure (ball (0 : ℂ) (1 / 2)), dist x y = 1 := by
  refine ⟨1 / 2, ?_, -1 / 2, ?_, ?_⟩
  · rw [closure_ball _ (by norm_num), mem_closedBall, dist_zero_right]; norm_num
  · rw [closure_ball _ (by norm_num), mem_closedBall, dist_zero_right]; norm_num
  · rw [dist_eq_norm]; norm_num

/-- **A collar about `ψ` holds the inner and outer halves of a small disc about `u + e ψ`.** -/
theorem exists_mem_collar_of_dist_lt (u : ℂ) (ψ : ℝ) {h : ℝ} (hh : 0 < h) :
    ∃ ε > 0, ∀ z, dist z (u + e ψ) < ε →
      (dist z u < 1 → z ∈ collar u .inner (ψ - h) (ψ + h) h) ∧ (1 < dist z u → z ∈ collar u .outer (ψ - h) (ψ + h) h) := by
  sorry

/-- **At most five angles leave an open arc of length `2π/5` free of them** (mod `2π`): E1-COVER (e)'s count, in the form E1-NO45 consumes
(`2π/5 > π/3`). With one of the angles as the base point, the five arcs `(κ + 2πj/5, κ + 2π(j+1)/5)` miss it and the other four hit at most four. -/
theorem exists_Ioo_avoiding (K : Finset ℝ) (hK : K.card ≤ 5) :
    ∃ θ : ℝ, ∀ κ ∈ K, ∀ m : ℤ, κ + 2 * π * m ∉ Ioo θ (θ + 2 * π / 5) := by
  sorry

/-- An open annular sector at `v` approaches `v` along each of its open directions. -/
theorem mem_coneAt_annSector (v : ℂ) {r a b γ : ℝ} (hr : 0 < r) (hγ : γ ∈ Ioo a b) : γ ∈ coneAt (annSector v 0 r a b) v := by
  sorry

/-- **Second-order collars from a tangent parabola** (the second-order lemma's engine, `plans/FS131-W-kernel-plan.md` § 7.3 (b)): if `S` holds the
points `v + (x + (κx²/2) i) e(β)`, `0 < x < r`, of the parabola tangent to `e β` at `v` with upward curvature `κ`, then at the normal
`β + σ π/2` (`σ = ±1`) the shadow of `S` carries an inner collar when `σκ < 1` and an outer collar when `σκ > 1`: the unit circle about a point
`z` of the collar has `v` on one side (inside it for inner `z`) and the parabola's point at a fixed small `x` on the other, and the parabola's arc
is connected. -/
theorem collarAt_shadow_of_parabola {S : Set ℂ} {v : ℂ} {β κ σ r : ℝ} (hσ : σ = 1 ∨ σ = -1) (hr : 0 < r)
    (hS : ∀ x ∈ Ioo 0 r, framePt v β x (κ * x ^ 2 / 2) ∈ S) :
    (σ * κ < 1 → CollarAt (shadow S) v .inner (β + σ * (π / 2))) ∧
      (1 < σ * κ → CollarAt (shadow S) v .outer (β + σ * (π / 2))) := by
  sorry

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-! ## Crossing the unit circle -/

/-- **The colour `X` crosses `ω(v)` at the angle `θ`** (E1-CROSS's hypothesis, on colour classes): `v + e θ` is a limit of points of `X`'s class
inside `ω(v)` and of points of it outside. -/
def CrossesAt (v : ℂ) (X : Fin k) (θ : ℝ) : Prop :=
  v + e θ ∈ closure (F.region X ∩ ball v 1) ∧ v + e θ ∈ closure (F.region X \ closedBall v 1)

/-- The colour of the one-colour plane crosses every unit circle at every angle. -/
example (v : ℂ) (θ : ℝ) : (ArcMap.const univ isOpen_univ (0 : Fin 1)).CrossesAt v 0 θ := by
  have hreg : (ArcMap.const univ isOpen_univ (0 : Fin 1)).region 0 = univ := by
    ext z; simp [ArcMap.region, ArcMap.const, ArcMap.interiorPts]
  have key : ∀ s : ℝ, (s = 1 ∨ s = -1) → ∀ ε > 0, ∃ t : ℝ, 0 < t ∧ t < 1 ∧ t < ε ∧
      dist (v + ((1 + s * t : ℝ) : ℂ) * e θ) v = 1 + s * t ∧ dist (v + ((1 + s * t : ℝ) : ℂ) * e θ) (v + e θ) = t := by
    intro s hs ε hε
    refine ⟨min (ε / 2) (1 / 2), by positivity, by
      exact lt_of_le_of_lt (min_le_right _ _) (by norm_num), lt_of_le_of_lt (min_le_left _ _) (by linarith), ?_, ?_⟩
    · rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs]
      rcases hs with rfl | rfl
      · rw [abs_of_pos (by positivity)]
      · rw [abs_of_pos]; have : min (ε / 2) (1 / 2 : ℝ) ≤ 1 / 2 := min_le_right _ _; linarith
    · have hrw : v + ((1 + s * min (ε / 2) (1 / 2) : ℝ) : ℂ) * e θ - (v + e θ)
          = ((s * min (ε / 2) (1 / 2) : ℝ) : ℂ) * e θ := by push_cast; ring
      rw [dist_eq_norm, hrw, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_mul]
      rcases hs with rfl | rfl <;> simp <;> linarith
  refine ⟨Metric.mem_closure_iff.mpr fun ε hε => ?_, Metric.mem_closure_iff.mpr fun ε hε => ?_⟩
  · obtain ⟨t, ht0, ht1, htε, hd, hd'⟩ := key (-1) (Or.inr rfl) ε hε
    refine ⟨_, ⟨by rw [hreg]; trivial, ?_⟩, by rw [dist_comm, hd']; exact htε⟩
    rw [mem_ball, hd]; linarith
  · obtain ⟨t, ht0, ht1, htε, hd, hd'⟩ := key 1 (Or.inl rfl) ε hε
    refine ⟨_, ⟨by rw [hreg]; trivial, ?_⟩, by rw [dist_comm, hd']; exact htε⟩
    rw [mem_closedBall, hd]; linarith

/-- **Adversary for `CrossesAt`**: a colour whose class lies inside `ω(v)` reaches it from one side only and does not cross. -/
example (v : ℂ) (θ : ℝ) : ¬ (ArcMap.const (ball v 1) isOpen_ball (0 : Fin 1)).CrossesAt v 0 θ := by
  have hreg : (ArcMap.const (ball v 1) isOpen_ball (0 : Fin 1)).region 0 = ball v 1 := by
    ext z; simp [ArcMap.region, ArcMap.const, ArcMap.interiorPts]
  rintro ⟨-, hout⟩
  have : (ArcMap.const (ball v 1) isOpen_ball (0 : Fin 1)).region 0 \ closedBall v 1 = ∅ := by
    rw [hreg]; exact sdiff_eq_empty.mpr ball_subset_closedBall
  rw [this, closure_empty] at hout
  exact hout

variable {F}

/-! ## E1-SEE: seeing through a point at distance one -/

/-- **E1-SEE** (`plans/FS131-E1-derivation.md` § 3.1): in a valid map, a point `Y` at distance exactly `1` from a point `q` of colour `j`'s class
does not carry `j` (FS106-DIAM's third clause, wave 1's `dist_ne_one_of_mem_of_mem_closure`, at the class of `j`). -/
theorem not_mem_coloursAt_of_dist_eq_one (hF : F.Valid) {j : Fin k} {q Y : ℂ} (hq : q ∈ F.region j) (hqY : dist q Y = 1) :
    j ∉ F.coloursAt Y := by
  sorry

/-- **E1-SEE, robust form** (the kill at a normal, § 7.3 (b)): if both an inner and an outer collar about `ψ` lie in the shadow of `j`'s class,
the point `v + e ψ` does not carry `j` — `j`'s class misses both collars (validity), hence a disc about `v + e ψ` (`exists_mem_collar_of_dist_lt`;
a point of the class on `ω(v)` has a disc in the class, meeting the inner collar). -/
theorem not_mem_coloursAt_of_collarAt (hF : F.Valid) {v : ℂ} {ψ : ℝ} {j : Fin k}
    (hin : CollarAt (shadow (F.region j)) v .inner ψ) (hout : CollarAt (shadow (F.region j)) v .outer ψ) :
    j ∉ F.coloursAt (v + e ψ) := by
  sorry

/-! ## E1-RAY and E1-CROSS -/

/-- **E1-RAY, inner** (`plans/FS131-E1-derivation.md` § 3.2): a sector at `v` holding the direction `γ` in its open range, with
`cos (γ − ψ) < 0`, puts an inner collar about `ψ` in its colour's shadow (W's `collarAt_shadow_inner` on a truncated sector,
`mem_coneAt_annSector`). -/
theorem SectorsAt.collarAt_shadow_inner_of_mem {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (i : Fin n) {γ ψ : ℝ} (hγ : γ ∈ Ioo (d i.castSucc) (d i.succ)) (hcos : Real.cos (γ - ψ) < 0) :
    CollarAt (shadow (F.region (c i))) v .inner ψ := by
  sorry

/-- **E1-RAY, outer**: the same with `cos (γ − ψ) > 0` and an outer collar. -/
theorem SectorsAt.collarAt_shadow_outer_of_mem {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (i : Fin n) {γ ψ : ℝ} (hγ : γ ∈ Ioo (d i.castSucc) (d i.succ)) (hcos : 0 < Real.cos (γ - ψ)) :
    CollarAt (shadow (F.region (c i))) v .outer ψ := by
  sorry

/-- **E1-CROSS** (`plans/FS131-E1-derivation.md` § 3.3), on colour classes: in a valid map, at a point whose picture has positive angles, a colour
crossing `ω(v)` at any angle is carried by no sector (a sector of colour `X` has a direction with `cos (γ − θ) ≠ 0`, so a collar on one side
about `θ` lies in `X`'s shadow, and `X`'s points on that side near `v + e θ` lie in it). -/
theorem SectorsAt.not_mem_range_of_crossesAt (hF : F.Valid) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (hpos : ∀ i : Fin n, 0 < d i.succ - d i.castSucc) {X : Fin k} {θ : ℝ} (hX : F.CrossesAt v X θ) :
    X ∉ Set.range c := by
  sorry

/-! ## E1-COVER -/

/-- **The local structure off crossings** (E1-COVER (a), on colour classes): in a map of the plane, at a point `v + e θ` of `ω(v)` with at most
two colours where no colour crosses, the point carries exactly two colours `A ≠ B`, and a disc about it has its interior points coloured `A`
inside `ω(v)`, `B` outside, and none on `ω(v)`. -/
theorem exists_side_colours_of_not_crossesAt (hP : F.IsPlaneMap) {v : ℂ} {θ : ℝ} (h2 : (F.coloursAt (v + e θ)).ncard ≤ 2)
    (hnc : ∀ X, ¬ F.CrossesAt v X θ) :
    ∃ A B : Fin k, A ≠ B ∧ F.coloursAt (v + e θ) = {A, B} ∧ ∃ r > 0, ∀ z ∈ ball (v + e θ) r, z ∈ F.interiorPts →
      (dist z v < 1 → F.col z = A) ∧ (1 < dist z v → F.col z = B) ∧ dist z v ≠ 1 := by
  sorry

/-- **One colour class along a branch-point-free arc** (E1-COVER (b)–(c), on colour classes; the clopen argument of § 7.3 (a)): in a map of the
plane, if every point of the open arc `(θ₁, θ₂)` of `ω(v)` carries at most two colours and all the colours crossing `ω(v)` along it are one
colour, some colour class has every point of the arc in its closure. -/
theorem exists_closure_colour_of_arc (hP : F.IsPlaneMap) {v : ℂ} {θ₁ θ₂ : ℝ}
    (hnb : ∀ θ ∈ Ioo θ₁ θ₂, (F.coloursAt (v + e θ)).ncard ≤ 2)
    (hcross : ∀ X X' : Fin k, ∀ θ ∈ Ioo θ₁ θ₂, ∀ θ' ∈ Ioo θ₁ θ₂, F.CrossesAt v X θ → F.CrossesAt v X' θ' → X = X') :
    ∃ X : Fin k, ∀ θ ∈ Ioo θ₁ θ₂, v + e θ ∈ closure (F.region X) := by
  sorry

/-- **E1-COVER** (`plans/FS131-E1-derivation.md` § 3.4), in E1-GEN6's form and on colour classes: in a valid map of the plane, at a point `v` whose
picture has positive angles and at most one colour absent from its sectors, no open arc of `ω(v)` of angular length greater than `π/3` has at
most two colours at each of its points (its points all lie in one class's closure, `exists_closure_colour_of_arc` with E1-CROSS; a closed sub-arc
of length in `(π/3, π]` has chord `> 1`, against `dist_le_one_of_subset_closure`). -/
theorem SectorsAt.false_of_ncard_le_two_on_arc (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ}
    {c : Fin n → Fin k} (h : F.SectorsAt v n d c) (hpos : ∀ i : Fin n, 0 < d i.succ - d i.castSucc)
    (habs : ∀ X Y : Fin k, X ∉ Set.range c → Y ∉ Set.range c → X = Y) {θ₁ θ₂ : ℝ} (hlen : π / 3 < θ₂ - θ₁)
    (hnb : ∀ θ ∈ Ioo θ₁ θ₂, (F.coloursAt (v + e θ)).ncard ≤ 2) : False := by
  sorry

/-! ## E1-BAD -/

/-- **Every direction lies in one half-open sector**, mod `2π` (the bookkeeping of E1-BAD's case analysis): `d` is monotone with
`d (last n) = d 0 + 2π`. -/
theorem SectorsAt.exists_mem_Ico {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k} (h : F.SectorsAt v n d c) (D : ℝ) :
    ∃ i : Fin n, ∃ m : ℤ, D + 2 * π * m ∈ Ico (d i.castSucc) (d i.succ) := by
  sorry

/-- **E1-BAD, interior directions** (§ 3.5's first bullet, with E1-SEE): if a branch direction `ψ ± π/2` of `ω(v + e ψ)` at `v` is, mod `2π`,
interior to sector `i`, the branch near `v` runs in a truncated sector, so `v + e ψ` does not carry `c i`. -/
theorem SectorsAt.not_mem_coloursAt_of_mem_Ioo (hF : F.Valid) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (i : Fin n) {ψ D : ℝ} (hD : D = ψ + π / 2 ∨ D = ψ - π / 2) {m : ℤ}
    (hm : D + 2 * π * m ∈ Ioo (d i.castSucc) (d i.succ)) : c i ∉ F.coloursAt (v + e ψ) := by
  sorry

/-- **The colour of a tangent parabola at an edge** (the second-order lemma's map-level input, § 9.1): in a map of the plane, at an edge
direction `β = d i` of a picture with positive angles, the parabola tangent to `e β` at `v` with upward curvature `1/2` has its points `0 < x < r`,
for some `r > 0`, in one colour class, of one of the edge's two colours. A parabola lies on no circle and no line, so each of the finitely many arcs
near `v` meets it at finitely many points; its small points are interior points of one tile; their colour has `β` in its cone, so it is the colour of
sector `i` or of the sector before. -/
theorem SectorsAt.exists_parabola_region (hP : F.IsPlaneMap) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (hn : 2 ≤ n) (hpos : ∀ j : Fin n, 0 < d j.succ - d j.castSucc) (i : Fin n) :
    ∃ r > 0, ∃ j : Fin k, (j = c ((finRotate n).symm i) ∨ j = c i) ∧
      ∀ x ∈ Ioo 0 r, framePt v (d i.castSucc) x ((1 / 2 : ℝ) * x ^ 2 / 2) ∈ F.region j := by
  sorry

/-- **The refined second-order lemma** (§ 7.3 (b); W's § 4.1 lemma in the form E1-BAD's count and `step6` consume): in a map of the plane, at
every edge direction `β = d i` of a picture with positive angles, one of the edge's two normals `β ± π/2` carries an inner collar in the shadow of
both adjacent colours. With the parabola of curvature `1/2` and its colour `j` (`exists_parabola_region`): if `j` is the colour after the edge,
the normal `β + π/2` (`collarAt_shadow_of_parabola`, `1/2 < 1`; the colour before by E1-RAY); if before, the normal `β − π/2` (`−1/2 < 1`). -/
theorem SectorsAt.exists_normal_collarAt (hP : F.IsPlaneMap) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (hn : 2 ≤ n) (hpos : ∀ j : Fin n, 0 < d j.succ - d j.castSucc) (i : Fin n) :
    ∃ σ : ℝ, (σ = 1 ∨ σ = -1) ∧
      CollarAt (shadow (F.region (c ((finRotate n).symm i))) ∩ shadow (F.region (c i))) v .inner (d i.castSucc + σ * (π / 2)) := by
  sorry

/-- **E1-BAD at a good normal** (the edge case's kill): in a valid map, if the normal `β + σπ/2` of the edge `β = d i` carries an inner collar in
the shadow of both adjacent colours, the point `v + e (β + σπ/2)` lacks one of them — the one whose sector lies on the normal's side (E1-RAY puts
its outer collar in its shadow; `not_mem_coloursAt_of_collarAt`). -/
theorem SectorsAt.absent_at_normal (hF : F.Valid) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (hn : 2 ≤ n) (hpos : ∀ j : Fin n, 0 < d j.succ - d j.castSucc) (i : Fin n) {σ : ℝ}
    (hσ : σ = 1 ∨ σ = -1)
    (hs : CollarAt (shadow (F.region (c ((finRotate n).symm i))) ∩ shadow (F.region (c i))) v .inner (d i.castSucc + σ * (π / 2))) :
    c ((finRotate n).symm i) ∉ F.coloursAt (v + e (d i.castSucc + σ * (π / 2))) ∨
      c i ∉ F.coloursAt (v + e (d i.castSucc + σ * (π / 2))) := by
  sorry

/-- **E1-BAD** (`plans/FS131-E1-derivation.md` § 3.5), corrected (§ 7.4) and robust (§ 7.3 (b)): in a valid map of the plane, at a point whose
picture has `n ≥ 3` sectors of distinct colours, each of angle in `(0, π]`, there is a set `K` of at most `n` angles off which (mod `2π`) every point
`v + e ψ` of `ω(v)` lacks two distinct colours of the picture. `K` holds, for each edge, the normal the second-order lemma does not certify, and for
a sector of angle `π` both normals of its two edges; off `K`, each branch direction `ψ ± π/2` is interior to a sector (`not_mem_coloursAt_of_mem_Ioo`)
or is an edge with `ψ` its good normal (`absent_at_normal`), and the two colours lost are distinct. -/
theorem SectorsAt.exists_two_absent (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (hn : 3 ≤ n) (hc : Function.Injective c) (hpos : ∀ i : Fin n, 0 < d i.succ - d i.castSucc)
    (hπ : ∀ i : Fin n, d i.succ - d i.castSucc ≤ π) :
    ∃ K : Finset ℝ, K.card ≤ n ∧ ∀ ψ : ℝ, (∀ κ ∈ K, ∀ m : ℤ, ψ ≠ κ + 2 * π * m) →
      ∃ i j : Fin n, c i ≠ c j ∧ c i ∉ F.coloursAt (v + e ψ) ∧ c j ∉ F.coloursAt (v + e ψ) := by
  sorry

end ArcMap

end HadwigerNelson.Plane
