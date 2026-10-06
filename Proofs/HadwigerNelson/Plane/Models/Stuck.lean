import Proofs.HadwigerNelson.Plane.Models.Paint

/-!
# A stuck vertex in a valid map of the plane, and a doubly shadowed band under Condition 5 (FS131-KM1, skeleton)

`plans/FS131-models-kernel-plan.md` § 4; the hand objects are FS131-E7's `P₅` and `P₄` (`plans/FS131-E7-derivation.md` §§ 7, 6).

* `stuckModel : ArcMap 12` — the brick map with five spare colours painted in three bricks: in `B(plantPt, 1/10)` the bowtie's picture
  (`7` inside `B(N, 1)`, `8` inside `B(S′, 1)`, `9` on the two horns between `ω(N)` and `ω(S′)`), and about each pole a square of side
  `1/10` cut by its diagonals into four wedges (`7` or `8` toward the vertex, `9` away from it, `10` and `11` at the sides). **The model of
  `Valid ∧ Covers v 1 ∧ IsStuck v`** (`stuckModel_hyps`), in place of the completed bowtie; E7's discs at the poles are squares here, so
  that every new arc but the four unit arcs and one circle is a segment with rational ends.
* `shadowModel : ArcMap 9` — the brick map with two spare colours: `7` on the flank above a band at `plantPt` and on a horn at the lower
  pole, `8` on their mirror images. **The model of `flank_ne_of_doublyShadowed`** (`shadowModel_flank_ne`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## The stuck vertex -/

/-- The open square of side `1/10` about `p`. -/
def poleSq (p : ℂ) : Set ℂ := {z | |(z - p).re| < 1 / 20 ∧ |(z - p).im| < 1 / 20}

/-- The four sides and the two diagonals of the square about `p`. -/
noncomputable def poleSqArcs (p : ℂ) : Set Arc :=
  {Arc.seg (p + (-1 / 20 - 1 / 20 * I)) (p + (1 / 20 - 1 / 20 * I)), Arc.seg (p + (1 / 20 - 1 / 20 * I)) (p + (1 / 20 + 1 / 20 * I)),
    Arc.seg (p + (1 / 20 + 1 / 20 * I)) (p + (-1 / 20 + 1 / 20 * I)), Arc.seg (p + (-1 / 20 + 1 / 20 * I)) (p + (-1 / 20 - 1 / 20 * I)),
    Arc.seg (p + (-1 / 20 - 1 / 20 * I)) (p + (1 / 20 + 1 / 20 * I)), Arc.seg (p + (-1 / 20 + 1 / 20 * I)) (p + (1 / 20 - 1 / 20 * I))}

/-- The painted set of `stuckModel`: the disc about the vertex and the squares about its poles. -/
noncomputable def stuckW : Set ℂ := ball plantPt (1 / 10) ∪ poleSq plantN ∪ poleSq plantS

/-- The new arcs of `stuckModel`: the circle of radius `1/10`; the arcs of `ω(N)` and of `ω(S′)` inside it, each as its two tangent arcs
from the vertex; the squares' sides and diagonals. -/
noncomputable def stuckArcs : Set Arc :=
  {Arc.circ plantPt (1 / 10) 0 (2 * π), germArc plantPt 0 1 (1 / 10), germArc plantPt π (-1) (1 / 10),
    germArc plantPt 0 (-1) (1 / 10), germArc plantPt π 1 (1 / 10)} ∪ poleSqArcs plantN ∪ poleSqArcs plantS

/-- The painting of `stuckModel` (read on `stuckW` only). -/
noncomputable def stuckCol (z : ℂ) : Fin 12 := by
  classical
  exact
    if dist z plantPt < 1 / 10 then
      (if dist z plantN < 1 then 7 else if dist z plantS < 1 then 8 else 9)
    else if z ∈ poleSq plantN then
      (if (z - plantN).im < -|(z - plantN).re| then 7
        else if |(z - plantN).re| < (z - plantN).im then 9
        else if |(z - plantN).im| < (z - plantN).re then 10 else 11)
    else
      (if |(z - plantS).re| < (z - plantS).im then 8
        else if (z - plantS).im < -|(z - plantS).re| then 9
        else if |(z - plantS).im| < (z - plantS).re then 10 else 11)

section StuckHelpers

open ArcMap

/-! ### Coordinates, and the arcs of `stuckModel` as point sets (FS131-MB1's helpers) -/

/-- The planted points in coordinates. -/
theorem stuckModel_plant_coords : plantPt.re = 2 / 5 ∧ plantPt.im = 3 / 10 ∧ plantN.re = 2 / 5 ∧ plantN.im = 13 / 10 ∧
    plantS.re = 2 / 5 ∧ plantS.im = -7 / 10 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;> simp [plantN, plantS, plantPt] <;> norm_num

/-- The squared distance in coordinates. -/
theorem stuckModel_dist_sq (z w : ℂ) : dist z w ^ 2 = (z.re - w.re) ^ 2 + (z.im - w.im) ^ 2 := by
  rw [Complex.dist_eq_re_im, Real.sq_sqrt (by positivity)]

/-- Each coordinate difference is at most the distance. -/
theorem stuckModel_abs_coords_le (z w : ℂ) : |z.re - w.re| ≤ dist z w ∧ |z.im - w.im| ≤ dist z w := by
  rw [dist_eq_norm]
  exact ⟨by simpa using Complex.abs_re_le_norm (z - w), by simpa using Complex.abs_im_le_norm (z - w)⟩

/-- The whole circle of radius `ρ` about `c` is the carrier of the arc `circ c ρ 0 (2π)` (`ArcMap.carrier_circ_full` is the radius `1`). -/
theorem stuckModel_carrier_circ (c : ℂ) {ρ : ℝ} (hρ : 0 < ρ) : (Arc.circ c ρ 0 (2 * π)).carrier = sphere c ρ := by
  ext z
  simp only [Arc.carrier, mem_image, mem_Icc, mem_sphere_iff_norm]
  constructor
  · rintro ⟨θ, -, rfl⟩
    rw [add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hρ]
  · intro hz
    have hpol : z - c = (ρ : ℂ) * e (arg (z - c)) := by
      have := eq_polar_arg (z - c)
      rw [hz] at this; exact this
    have hπ := Real.pi_pos
    rcases le_or_gt 0 (arg (z - c)) with h | h
    · exact ⟨arg (z - c), ⟨h, by linarith [Complex.arg_le_pi (z - c)]⟩, by rw [← hpol]; ring⟩
    · refine ⟨arg (z - c) + 2 * π, ⟨by linarith [Complex.neg_pi_lt_arg (z - c)], by linarith⟩, ?_⟩
      rw [e_add_two_pi, ← hpol]; ring

/-- The corners of a pole's square, as pairs of coordinates. -/
theorem stuckModel_corners : (-1 / 20 - 1 / 20 * I : ℂ) = ⟨-1 / 20, -1 / 20⟩ ∧ (1 / 20 - 1 / 20 * I : ℂ) = ⟨1 / 20, -1 / 20⟩ ∧
    (1 / 20 + 1 / 20 * I : ℂ) = ⟨1 / 20, 1 / 20⟩ ∧ (-1 / 20 + 1 / 20 * I : ℂ) = ⟨-1 / 20, 1 / 20⟩ := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;> apply Complex.ext <;> simp <;> norm_num

/-- A point of the segment between `p + (a₁, b₁)` and `p + (a₂, b₂)`, in coordinates relative to `p`. -/
theorem stuckModel_mem_seg_iff (p : ℂ) (a₁ b₁ a₂ b₂ : ℝ) (z : ℂ) :
    z ∈ segment ℝ (p + ⟨a₁, b₁⟩) (p + ⟨a₂, b₂⟩) ↔
      ∃ t : ℝ, 0 ≤ t ∧ t ≤ 1 ∧ z.re - p.re = a₁ + t * (a₂ - a₁) ∧ z.im - p.im = b₁ + t * (b₂ - b₁) := by
  constructor
  · intro h
    obtain ⟨t, h0, h1, hre, him⟩ := coords_of_mem_segment h
    refine ⟨t, h0, h1, ?_, ?_⟩
    · rw [hre]; simp only [Complex.add_re]; ring
    · rw [him]; simp only [Complex.add_im]; ring
  · rintro ⟨t, h0, h1, hre, him⟩
    refine mem_segment_of_coords t h0 h1 ?_ ?_
    · simp only [Complex.add_re]; linarith
    · simp only [Complex.add_im]; linarith

/-- **The arcs of a pole's square**: the four sides, then the two diagonals, in coordinates relative to the pole. -/
theorem stuckModel_mem_poleSqArcs_iff (p z : ℂ) :
    z ∈ ⋃ a ∈ poleSqArcs p, a.carrier ↔
      (z.im - p.im = -1 / 20 ∧ |z.re - p.re| ≤ 1 / 20) ∨ (z.re - p.re = 1 / 20 ∧ |z.im - p.im| ≤ 1 / 20) ∨
      (z.im - p.im = 1 / 20 ∧ |z.re - p.re| ≤ 1 / 20) ∨ (z.re - p.re = -1 / 20 ∧ |z.im - p.im| ≤ 1 / 20) ∨
      (z.re - p.re = z.im - p.im ∧ |z.re - p.re| ≤ 1 / 20) ∨ (z.re - p.re = -(z.im - p.im) ∧ |z.re - p.re| ≤ 1 / 20) := by
  obtain ⟨c1, c2, c3, c4⟩ := stuckModel_corners
  simp only [poleSqArcs, biUnion_insert, biUnion_singleton, mem_union, Arc.carrier, c1, c2, c3, c4, stuckModel_mem_seg_iff]
  refine or_congr ?_ (or_congr ?_ (or_congr ?_ (or_congr ?_ (or_congr ?_ ?_))))
  · constructor
    · rintro ⟨t, h0, h1, hA, hB⟩; exact ⟨by linarith, abs_le.mpr ⟨by linarith, by linarith⟩⟩
    · rintro ⟨h, hab⟩; obtain ⟨l, u⟩ := abs_le.mp hab
      exact ⟨(z.re - p.re + 1 / 20) * 10, by linarith, by linarith, by linarith, by linarith⟩
  · constructor
    · rintro ⟨t, h0, h1, hA, hB⟩; exact ⟨by linarith, abs_le.mpr ⟨by linarith, by linarith⟩⟩
    · rintro ⟨h, hab⟩; obtain ⟨l, u⟩ := abs_le.mp hab
      exact ⟨(z.im - p.im + 1 / 20) * 10, by linarith, by linarith, by linarith, by linarith⟩
  · constructor
    · rintro ⟨t, h0, h1, hA, hB⟩; exact ⟨by linarith, abs_le.mpr ⟨by linarith, by linarith⟩⟩
    · rintro ⟨h, hab⟩; obtain ⟨l, u⟩ := abs_le.mp hab
      exact ⟨(1 / 20 - (z.re - p.re)) * 10, by linarith, by linarith, by linarith, by linarith⟩
  · constructor
    · rintro ⟨t, h0, h1, hA, hB⟩; exact ⟨by linarith, abs_le.mpr ⟨by linarith, by linarith⟩⟩
    · rintro ⟨h, hab⟩; obtain ⟨l, u⟩ := abs_le.mp hab
      exact ⟨(1 / 20 - (z.im - p.im)) * 10, by linarith, by linarith, by linarith, by linarith⟩
  · constructor
    · rintro ⟨t, h0, h1, hA, hB⟩; exact ⟨by linarith, abs_le.mpr ⟨by linarith, by linarith⟩⟩
    · rintro ⟨h, hab⟩; obtain ⟨l, u⟩ := abs_le.mp hab
      exact ⟨(z.re - p.re + 1 / 20) * 10, by linarith, by linarith, by linarith, by linarith⟩
  · constructor
    · rintro ⟨t, h0, h1, hA, hB⟩; exact ⟨by linarith, abs_le.mpr ⟨by linarith, by linarith⟩⟩
    · rintro ⟨h, hab⟩; obtain ⟨l, u⟩ := abs_le.mp hab
      exact ⟨(z.re - p.re + 1 / 20) * 10, by linarith, by linarith, by linarith, by linarith⟩

/-- The arcs of a pole's square lie in the closed square. -/
theorem stuckModel_poleSqArcs_subset {p z : ℂ} (hz : z ∈ ⋃ a ∈ poleSqArcs p, a.carrier) :
    |z.re - p.re| ≤ 1 / 20 ∧ |z.im - p.im| ≤ 1 / 20 := by
  rw [stuckModel_mem_poleSqArcs_iff] at hz
  rcases hz with ⟨h, hab⟩ | ⟨h, hab⟩ | ⟨h, hab⟩ | ⟨h, hab⟩ | ⟨h, hab⟩ | ⟨h, hab⟩
  · exact ⟨hab, by rw [h]; norm_num [abs_of_neg]⟩
  · exact ⟨by rw [h]; norm_num [abs_of_pos], hab⟩
  · exact ⟨hab, by rw [h]; norm_num [abs_of_pos]⟩
  · exact ⟨by rw [h]; norm_num [abs_of_neg], hab⟩
  · exact ⟨hab, by rw [← h]; exact hab⟩
  · exact ⟨hab, by rw [show z.im - p.im = -(z.re - p.re) by linarith, abs_neg]; exact hab⟩

/-- The open square about a pole, in coordinates. -/
theorem stuckModel_mem_poleSq {p z : ℂ} : z ∈ poleSq p ↔ |z.re - p.re| < 1 / 20 ∧ |z.im - p.im| < 1 / 20 := Iff.rfl

/-- The open square about a pole is open. -/
theorem stuckModel_isOpen_poleSq (p : ℂ) : IsOpen (poleSq p) := by
  show IsOpen {z : ℂ | |(z - p).re| < 1 / 20 ∧ |(z - p).im| < 1 / 20}
  exact (isOpen_lt (by fun_prop) continuous_const).and (isOpen_lt (by fun_prop) continuous_const)

/-- In its open square, a point is on a pole's arcs exactly when it is on a diagonal. -/
theorem stuckModel_poleSq_diag {p z : ℂ} (hz : z ∈ poleSq p) :
    z ∈ ⋃ a ∈ poleSqArcs p, a.carrier ↔ |z.re - p.re| = |z.im - p.im| := by
  obtain ⟨h1, h2⟩ := stuckModel_mem_poleSq.mp hz
  rw [stuckModel_mem_poleSqArcs_iff]
  constructor
  · rintro (⟨h, -⟩ | ⟨h, -⟩ | ⟨h, -⟩ | ⟨h, -⟩ | ⟨h, -⟩ | ⟨h, -⟩)
    · rw [h] at h2; norm_num [abs_of_neg] at h2
    · rw [h] at h1; norm_num [abs_of_pos] at h1
    · rw [h] at h2; norm_num [abs_of_pos] at h2
    · rw [h] at h1; norm_num [abs_of_neg] at h1
    · rw [h]
    · rw [h, abs_neg]
  · intro h
    rcases abs_eq_abs.mp h with h | h
    · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inl ⟨h, h1.le⟩))))
    · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr ⟨h, h1.le⟩))))

/-- The frame coordinates along `e 0` and `e π`. -/
theorem stuckModel_frames (v z : ℂ) : frameX v 0 z = z.re - v.re ∧ frameY v 0 z = z.im - v.im ∧
    frameX v π z = -(z.re - v.re) ∧ frameY v π z = -(z.im - v.im) := by
  have h0 : e 0 = 1 := e_zero
  have hπ : e π = -1 := by rw [e_eq]; simp
  refine ⟨?_, ?_, ?_, ?_⟩ <;> simp [frameX, frameY, h0, hπ]

/-- The poles of the frames along `e 0` and `e π` at the planted vertex. -/
theorem stuckModel_poles : plantPt + e (0 + π / 2) = plantN ∧ plantPt - e (π + π / 2) = plantN ∧
    plantPt - e (0 + π / 2) = plantS ∧ plantPt + e (π + π / 2) = plantS := by
  rw [zero_add, e_pi_div_two, e_pi_add_pi_div_two]
  exact ⟨rfl, by rw [sub_neg_eq_add]; rfl, rfl, by rw [← sub_eq_add_neg]; rfl⟩

/-- The four tangent arcs at the vertex lie on the unit circles about the poles, within `1/10` of the vertex. -/
theorem stuckModel_germ_subset :
    ((germArc plantPt 0 1 (1 / 10)).carrier ∪ (germArc plantPt π (-1) (1 / 10)).carrier ⊆
      sphere plantN 1 ∩ closedBall plantPt (1 / 10)) ∧
    ((germArc plantPt 0 (-1) (1 / 10)).carrier ∪ (germArc plantPt π 1 (1 / 10)).carrier ⊆
      sphere plantS 1 ∩ closedBall plantPt (1 / 10)) := by
  obtain ⟨hN0, hNπ, hS0, hSπ⟩ := stuckModel_poles
  have hc : ∀ (β κ : ℝ), |κ| = 1 → (germArc plantPt β κ (1 / 10)).carrier = branchPt plantPt β κ '' Icc 0 (1 / 10) :=
    fun β κ hκ => carrier_germArc plantPt β (by norm_num) (by rw [hκ]; norm_num)
  have hb : ∀ (β κ s : ℝ), s ∈ Icc (0 : ℝ) (1 / 10) → branchPt plantPt β κ s ∈ closedBall plantPt (1 / 10) :=
    fun β κ s hs => by rw [mem_closedBall, dist_eq_norm, norm_branchPt_sub _ _ _ hs.1]; exact hs.2
  have hm1 : |(-1 : ℝ)| = 1 := by rw [abs_neg, abs_one]
  refine ⟨?_, ?_⟩
  · rintro z (hz | hz)
    · rw [hc 0 1 abs_one] at hz
      obtain ⟨s, hs, rfl⟩ := hz
      exact ⟨by rw [mem_sphere, ← hN0]; exact dist_branchPt_one plantPt 0 hs.1 (by linarith [hs.2]), hb _ _ s hs⟩
    · rw [hc π (-1) hm1] at hz
      obtain ⟨s, hs, rfl⟩ := hz
      exact ⟨by rw [mem_sphere, ← hNπ]; exact dist_branchPt_neg_one plantPt π hs.1 (by linarith [hs.2]), hb _ _ s hs⟩
  · rintro z (hz | hz)
    · rw [hc 0 (-1) hm1] at hz
      obtain ⟨s, hs, rfl⟩ := hz
      exact ⟨by rw [mem_sphere, ← hS0]; exact dist_branchPt_neg_one plantPt 0 hs.1 (by linarith [hs.2]), hb _ _ s hs⟩
    · rw [hc π 1 abs_one] at hz
      obtain ⟨s, hs, rfl⟩ := hz
      exact ⟨by rw [mem_sphere, ← hSπ]; exact dist_branchPt_one plantPt π hs.1 (by linarith [hs.2]), hb _ _ s hs⟩

/-- **The unit circle about a pole inside `B(v, 1/10)` is its two tangent arcs**: a point within `1/10` of the vertex at distance `1`
from a pole lies on one of the two tangent arcs of that pole's circle. -/
theorem stuckModel_mem_germ_of_dist {z : ℂ} (hz : dist z plantPt < 1 / 10) :
    (dist z plantN = 1 → z ∈ (germArc plantPt 0 1 (1 / 10)).carrier ∪ (germArc plantPt π (-1) (1 / 10)).carrier) ∧
    (dist z plantS = 1 → z ∈ (germArc plantPt 0 (-1) (1 / 10)).carrier ∪ (germArc plantPt π 1 (1 / 10)).carrier) := by
  obtain ⟨hN0, hNπ, hS0, hSπ⟩ := stuckModel_poles
  obtain ⟨fx0, fy0, fxπ, fyπ⟩ := stuckModel_frames plantPt z
  have hn : ‖z - plantPt‖ < 1 / 10 := by rwa [dist_eq_norm] at hz
  have hm1 : |(-1 : ℝ)| = 1 := by rw [abs_neg, abs_one]
  have hc : ∀ (β κ : ℝ), |κ| = 1 → (germArc plantPt β κ (1 / 10)).carrier = branchPt plantPt β κ '' Icc 0 (1 / 10) :=
    fun β κ hκ => carrier_germArc plantPt β (by norm_num) (by rw [hκ]; norm_num)
  have key : ∀ (β κ : ℝ), |κ| = 1 → 0 < frameX plantPt β z → tanHeight κ (frameX plantPt β z) (frameY plantPt β z) = 0 →
      z ∈ (germArc plantPt β κ (1 / 10)).carrier := fun β κ hκ hX hT => by
    rw [hc β κ hκ]
    exact ⟨‖z - plantPt‖, ⟨norm_nonneg _, hn.le⟩, (eq_branchPt_of_tanHeight_eq_zero hX hT (by rw [hκ]; linarith)).symm⟩
  have hv : z.re - plantPt.re = 0 → z.im - plantPt.im = 0 → ∀ (β κ : ℝ), |κ| = 1 →
      z ∈ (germArc plantPt β κ (1 / 10)).carrier := by
    intro h1 h2 β κ hκ
    rw [hc β κ hκ]
    refine ⟨0, ⟨le_rfl, by norm_num⟩, ?_⟩
    rw [branchPt, Complex.ofReal_zero, zero_mul, add_zero]
    apply Complex.ext <;> linarith
  have hy : |z.im - plantPt.im| < 1 / 10 := (stuckModel_abs_coords_le z plantPt).2.trans_lt hz
  obtain ⟨hy1, hy2⟩ := abs_lt.mp hy
  constructor
  · intro h1
    have hsq := sq_dist_N plantPt 0 z
    rw [hN0, h1, fx0, fy0] at hsq
    rcases lt_trichotomy 0 (z.re - plantPt.re) with hx | hx | hx
    · left; exact key 0 1 abs_one (by rw [fx0]; exact hx) (by rw [fx0, fy0]; unfold tanHeight; linarith)
    · left; refine hv hx.symm ?_ 0 1 abs_one
      rw [← hx] at hsq
      have : (z.im - plantPt.im) * (z.im - plantPt.im - 2) = 0 := by linarith
      rcases mul_eq_zero.mp this with h | h
      · exact h
      · linarith
    · right; exact key π (-1) hm1 (by rw [fxπ]; linarith) (by rw [fxπ, fyπ]; unfold tanHeight; linarith)
  · intro h1
    have hsq := sq_dist_S plantPt 0 z
    rw [hS0, h1, fx0, fy0] at hsq
    rcases lt_trichotomy 0 (z.re - plantPt.re) with hx | hx | hx
    · left; exact key 0 (-1) hm1 (by rw [fx0]; exact hx) (by rw [fx0, fy0]; unfold tanHeight; linarith)
    · left; refine hv hx.symm ?_ 0 (-1) hm1
      rw [← hx] at hsq
      have : (z.im - plantPt.im) * (z.im - plantPt.im + 2) = 0 := by linarith
      rcases mul_eq_zero.mp this with h | h
      · exact h
      · linarith
    · right; exact key π 1 abs_one (by rw [fxπ]; linarith) (by rw [fxπ, fyπ]; unfold tanHeight; linarith)

/-- **The new arcs of `stuckModel` as a point set.** -/
theorem stuckModel_arcs_union : ⋃ a ∈ stuckArcs, a.carrier =
    sphere plantPt (1 / 10) ∪ ((germArc plantPt 0 1 (1 / 10)).carrier ∪ (germArc plantPt π (-1) (1 / 10)).carrier) ∪
      ((germArc plantPt 0 (-1) (1 / 10)).carrier ∪ (germArc plantPt π 1 (1 / 10)).carrier) ∪
      (⋃ a ∈ poleSqArcs plantN, a.carrier) ∪ (⋃ a ∈ poleSqArcs plantS, a.carrier) := by
  unfold stuckArcs
  rw [biUnion_union, biUnion_union, biUnion_insert, biUnion_insert, biUnion_insert, biUnion_insert, biUnion_singleton,
    stuckModel_carrier_circ _ (by norm_num)]
  simp only [union_assoc]

/-- The three pieces of the painted set, in coordinates. -/
theorem stuckModel_pieces {z : ℂ} :
    (dist z plantPt ≤ 1 / 10 → |z.re - 2 / 5| ≤ 1 / 10 ∧ |z.im - 3 / 10| ≤ 1 / 10) ∧
    (|z.re - plantN.re| ≤ 1 / 20 ∧ |z.im - plantN.im| ≤ 1 / 20 → |z.re - 2 / 5| ≤ 1 / 20 ∧ |z.im - 13 / 10| ≤ 1 / 20) ∧
    (|z.re - plantS.re| ≤ 1 / 20 ∧ |z.im - plantS.im| ≤ 1 / 20 → |z.re - 2 / 5| ≤ 1 / 20 ∧ |z.im + 7 / 10| ≤ 1 / 20) := by
  obtain ⟨h1, h2, h3, h4, h5, h6⟩ := stuckModel_plant_coords
  refine ⟨fun h => ?_, fun h => ?_, fun h => ?_⟩
  · have := stuckModel_abs_coords_le z plantPt
    rw [h1, h2] at this
    exact ⟨this.1.trans h, this.2.trans h⟩
  · rw [h3, h4] at h; exact h
  · rw [h5, h6] at h
    refine ⟨h.1, ?_⟩
    rw [show z.im + 7 / 10 = z.im - -7 / 10 by ring]; exact h.2

/-- **Near the vertex the new arcs are the two unit circles about the poles.** -/
theorem stuckModel_mem_arcs_ball_iff {z : ℂ} (hz : dist z plantPt < 1 / 10) :
    z ∈ ⋃ a ∈ stuckArcs, a.carrier ↔ dist z plantN = 1 ∨ dist z plantS = 1 := by
  obtain ⟨hb1, hb2⟩ := stuckModel_pieces.1 hz.le
  obtain ⟨-, hb2⟩ := abs_le.mp hb2
  rw [stuckModel_arcs_union]
  constructor
  · rintro ((((h | h) | h) | h) | h)
    · rw [mem_sphere] at h; linarith
    · exact Or.inl (stuckModel_germ_subset.1 h).1
    · exact Or.inr (stuckModel_germ_subset.2 h).1
    · obtain ⟨-, h2⟩ := stuckModel_pieces.2.1 (stuckModel_poleSqArcs_subset h)
      linarith [(abs_le.mp h2).1]
    · obtain ⟨-, h2⟩ := stuckModel_pieces.2.2 (stuckModel_poleSqArcs_subset h)
      linarith [(abs_le.mp h2).2, (abs_le.mp (stuckModel_pieces.1 hz.le).2).1]
  · rintro (h | h)
    · exact Or.inl (Or.inl (Or.inl (Or.inr ((stuckModel_mem_germ_of_dist hz).1 h))))
    · exact Or.inl (Or.inl (Or.inr ((stuckModel_mem_germ_of_dist hz).2 h)))

/-- **In a pole's open square the new arcs are its two diagonals.** -/
theorem stuckModel_mem_arcs_sq_iff {z : ℂ} :
    (z ∈ poleSq plantN → (z ∈ ⋃ a ∈ stuckArcs, a.carrier ↔ |z.re - plantN.re| = |z.im - plantN.im|)) ∧
    (z ∈ poleSq plantS → (z ∈ ⋃ a ∈ stuckArcs, a.carrier ↔ |z.re - plantS.re| = |z.im - plantS.im|)) := by
  have hfar : ∀ w : ℂ, w ∈ sphere plantPt (1 / 10) ∪
      ((germArc plantPt 0 1 (1 / 10)).carrier ∪ (germArc plantPt π (-1) (1 / 10)).carrier) ∪
      ((germArc plantPt 0 (-1) (1 / 10)).carrier ∪ (germArc plantPt π 1 (1 / 10)).carrier) → |w.im - 3 / 10| ≤ 1 / 10 := by
    rintro w ((h | h) | h)
    · exact (stuckModel_pieces.1 (le_of_eq (mem_sphere.mp h))).2
    · exact (stuckModel_pieces.1 (mem_closedBall.mp (stuckModel_germ_subset.1 h).2)).2
    · exact (stuckModel_pieces.1 (mem_closedBall.mp (stuckModel_germ_subset.2 h).2)).2
  refine ⟨fun hz => ?_, fun hz => ?_⟩
  · obtain ⟨-, hz2⟩ := stuckModel_pieces.2.1 ⟨(stuckModel_mem_poleSq.mp hz).1.le, (stuckModel_mem_poleSq.mp hz).2.le⟩
    rw [stuckModel_arcs_union, ← stuckModel_poleSq_diag hz]
    constructor
    · rintro ((h | h) | h)
      · linarith [(abs_le.mp (hfar z h)).2, (abs_le.mp hz2).1]
      · exact h
      · obtain ⟨-, h2⟩ := stuckModel_pieces.2.2 (stuckModel_poleSqArcs_subset h)
        linarith [(abs_le.mp h2).2, (abs_le.mp hz2).1]
    · exact fun h => Or.inl (Or.inr h)
  · obtain ⟨-, hz2⟩ := stuckModel_pieces.2.2 ⟨(stuckModel_mem_poleSq.mp hz).1.le, (stuckModel_mem_poleSq.mp hz).2.le⟩
    rw [stuckModel_arcs_union, ← stuckModel_poleSq_diag hz]
    constructor
    · rintro ((h | h) | h)
      · linarith [(abs_le.mp (hfar z h)).1, (abs_le.mp hz2).2]
      · obtain ⟨-, h2⟩ := stuckModel_pieces.2.1 (stuckModel_poleSqArcs_subset h)
        linarith [(abs_le.mp h2).1, (abs_le.mp hz2).2]
      · exact h
    · exact fun h => Or.inr h

/-- A strict inequality between continuous functions is locally constant where the two sides differ. -/
theorem stuckModel_eventually_lt_iff {f g : ℂ → ℝ} (hf : Continuous f) (hg : Continuous g) {x : ℂ} (h : f x ≠ g x) :
    ∀ᶠ y in 𝓝 x, (f y < g y ↔ f x < g x) := by
  rcases lt_or_gt_of_ne h with h | h
  · filter_upwards [hf.continuousAt.eventually_lt hg.continuousAt h] with y hy
    exact ⟨fun _ => h, fun _ => hy⟩
  · filter_upwards [hg.continuousAt.eventually_lt hf.continuousAt h] with y hy
    exact ⟨fun h' => absurd h' (not_lt.mpr hy.le), fun h' => absurd h' (not_lt.mpr h.le)⟩

/-- A point of a pole's square is neither within `1/10` of the vertex nor in the other pole's square. -/
theorem stuckModel_sq_disjoint {z : ℂ} :
    (z ∈ poleSq plantN → ¬ dist z plantPt < 1 / 10) ∧ (z ∈ poleSq plantS → ¬ dist z plantPt < 1 / 10 ∧ z ∉ poleSq plantN) := by
  refine ⟨fun hz hb => ?_, fun hz => ⟨fun hb => ?_, fun hN => ?_⟩⟩
  · obtain ⟨-, h2⟩ := stuckModel_pieces.2.1 ⟨(stuckModel_mem_poleSq.mp hz).1.le, (stuckModel_mem_poleSq.mp hz).2.le⟩
    linarith [(abs_le.mp h2).1, (abs_le.mp (stuckModel_pieces.1 hb.le).2).2]
  · obtain ⟨-, h2⟩ := stuckModel_pieces.2.2 ⟨(stuckModel_mem_poleSq.mp hz).1.le, (stuckModel_mem_poleSq.mp hz).2.le⟩
    linarith [(abs_le.mp h2).2, (abs_le.mp (stuckModel_pieces.1 hb.le).2).1]
  · obtain ⟨-, h2⟩ := stuckModel_pieces.2.2 ⟨(stuckModel_mem_poleSq.mp hz).1.le, (stuckModel_mem_poleSq.mp hz).2.le⟩
    obtain ⟨-, h3⟩ := stuckModel_pieces.2.1 ⟨(stuckModel_mem_poleSq.mp hN).1.le, (stuckModel_mem_poleSq.mp hN).2.le⟩
    linarith [(abs_le.mp h2).2, (abs_le.mp h3).1]

end StuckHelpers

theorem stuckArcs_nondegenerate : ∀ a ∈ stuckArcs, a.Nondegenerate := by
  have hπ := Real.pi_pos
  obtain ⟨c1, c2, c3, c4⟩ := stuckModel_corners
  have hseg : ∀ p : ℂ, ∀ a ∈ poleSqArcs p, a.Nondegenerate := by
    intro p a ha
    simp only [poleSqArcs, mem_insert_iff, mem_singleton_iff, c1, c2, c3, c4] at ha
    rcases ha with rfl | rfl | rfl | rfl | rfl | rfl <;>
    · show (_ : ℂ) ≠ _
      intro h
      have h' := add_left_cancel h
      rw [Complex.ext_iff] at h'
      norm_num at h'
  rintro a ((ha | ha) | ha)
  · simp only [mem_insert_iff, mem_singleton_iff] at ha
    rcases ha with rfl | rfl | rfl | rfl | rfl
    · exact ⟨by norm_num, by linarith, by linarith⟩
    all_goals exact germArc_nondegenerate _ _ _ (by norm_num)
  · exact hseg _ a ha
  · exact hseg _ a ha

theorem stuckArcs_finite : stuckArcs.Finite := by
  have hseg : ∀ p : ℂ, (poleSqArcs p).Finite := fun p => by
    unfold poleSqArcs
    exact (((((finite_singleton _).insert _).insert _).insert _).insert _).insert _
  unfold stuckArcs
  exact ((((((finite_singleton _).insert _).insert _).insert _).insert _).union (hseg _)).union (hseg _)

theorem frontier_stuckW_subset : frontier stuckW ⊆ ⋃ a ∈ (brickBase 12 (by norm_num)).arcs ∪ stuckArcs, a.carrier := by
  have hsq : ∀ p : ℂ, frontier (poleSq p) ⊆ ⋃ a ∈ poleSqArcs p, a.carrier := by
    intro p z hz
    have hcl : z ∈ {w : ℂ | |w.re - p.re| ≤ 1 / 20 ∧ |w.im - p.im| ≤ 1 / 20} :=
      closure_minimal (show poleSq p ⊆ {w : ℂ | |w.re - p.re| ≤ 1 / 20 ∧ |w.im - p.im| ≤ 1 / 20} from fun w hw =>
          ⟨(stuckModel_mem_poleSq.mp hw).1.le, (stuckModel_mem_poleSq.mp hw).2.le⟩)
        ((isClosed_le (by fun_prop) continuous_const).and (isClosed_le (by fun_prop) continuous_const)) hz.1
    have hnot : z ∉ poleSq p := by rw [← (stuckModel_isOpen_poleSq p).interior_eq]; exact hz.2
    rw [stuckModel_mem_poleSqArcs_iff]
    obtain ⟨h1, h2⟩ := hcl
    by_cases ha : |z.re - p.re| < 1 / 20
    · have hb : |z.im - p.im| = 1 / 20 := le_antisymm h2 (not_lt.mp fun h => hnot (stuckModel_mem_poleSq.mpr ⟨ha, h⟩))
      rcases (abs_eq (by norm_num : (0 : ℝ) ≤ 1 / 20)).mp hb with h | h
      · exact Or.inr (Or.inr (Or.inl ⟨h, h1⟩))
      · exact Or.inl ⟨by linarith, h1⟩
    · have ha' : |z.re - p.re| = 1 / 20 := le_antisymm h1 (not_lt.mp ha)
      rcases (abs_eq (by norm_num : (0 : ℝ) ≤ 1 / 20)).mp ha' with h | h
      · exact Or.inr (Or.inl ⟨h, h2⟩)
      · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨by linarith, h2⟩)))
  intro z hz
  have hz' : z ∈ ⋃ a ∈ stuckArcs, a.carrier := by
    rw [stuckModel_arcs_union]
    rcases frontier_union_subset (ball plantPt (1 / 10) ∪ poleSq plantN) (poleSq plantS) hz with ⟨h1, -⟩ | ⟨-, h1⟩
    · rcases frontier_union_subset _ _ h1 with ⟨h2, -⟩ | ⟨-, h2⟩
      · rw [frontier_ball _ (by norm_num)] at h2; exact Or.inl (Or.inl (Or.inl (Or.inl h2)))
      · exact Or.inl (Or.inr (hsq _ h2))
    · exact Or.inr (hsq _ h1)
  rw [biUnion_union]; exact Or.inr hz'

theorem stuckCol_locallyConstant : ∀ x ∈ stuckW, x ∉ ⋃ a ∈ (brickBase 12 (by norm_num)).arcs ∪ stuckArcs, a.carrier →
    ∀ᶠ y in 𝓝 x, stuckCol y = stuckCol x := by
  intro x hxW hx
  have hxB : x ∉ ⋃ a ∈ stuckArcs, a.carrier := fun h => hx (by rw [biUnion_union]; exact Or.inr h)
  have hne : ∀ a b : ℝ, |a| ≠ |b| → b ≠ -|a| ∧ |a| ≠ b ∧ |b| ≠ a := fun a b h =>
    ⟨fun h' => h (by rw [h', abs_neg, abs_abs]), fun h' => h (by rw [← h', abs_abs]), fun h' => h (by rw [← h', abs_abs])⟩
  rcases hxW with (hxb | hxN) | hxS
  · -- within `1/10` of the vertex: the colour changes across the two unit circles only
    rw [mem_ball] at hxb
    have hxN : dist x plantN ≠ 1 := fun h => hxB ((stuckModel_mem_arcs_ball_iff hxb).mpr (Or.inl h))
    have hxS : dist x plantS ≠ 1 := fun h => hxB ((stuckModel_mem_arcs_ball_iff hxb).mpr (Or.inr h))
    filter_upwards [isOpen_ball.mem_nhds (mem_ball.mpr hxb),
      stuckModel_eventually_lt_iff (f := fun y => dist y plantN) (g := fun _ => 1) (by fun_prop) continuous_const hxN,
      stuckModel_eventually_lt_iff (f := fun y => dist y plantS) (g := fun _ => 1) (by fun_prop) continuous_const hxS]
      with y hyb hyN hyS
    rw [mem_ball] at hyb
    simp only [stuckCol, hyb, hxb, if_true, hyN, hyS]
  · -- in the square about `N`: across its diagonals only
    have hd : |x.re - plantN.re| ≠ |x.im - plantN.im| := fun h => hxB ((stuckModel_mem_arcs_sq_iff.1 hxN).mpr h)
    obtain ⟨d1, d2, d3⟩ := hne _ _ hd
    filter_upwards [(stuckModel_isOpen_poleSq plantN).mem_nhds hxN,
      stuckModel_eventually_lt_iff (f := fun y => (y - plantN).im) (g := fun y => -|(y - plantN).re|) (by fun_prop)
        (by fun_prop) d1,
      stuckModel_eventually_lt_iff (f := fun y => |(y - plantN).re|) (g := fun y => (y - plantN).im) (by fun_prop)
        (by fun_prop) d2,
      stuckModel_eventually_lt_iff (f := fun y => |(y - plantN).im|) (g := fun y => (y - plantN).re) (by fun_prop)
        (by fun_prop) d3] with y hyN h1 h2 h3
    have hyb := stuckModel_sq_disjoint.1 hyN
    have hxb := stuckModel_sq_disjoint.1 hxN
    simp only [stuckCol, hyb, hxb, if_false, hyN, hxN, if_true, h1, h2, h3]
  · -- in the square about `S′`
    have hd : |x.re - plantS.re| ≠ |x.im - plantS.im| := fun h => hxB ((stuckModel_mem_arcs_sq_iff.2 hxS).mpr h)
    obtain ⟨d1, d2, d3⟩ := hne _ _ hd
    filter_upwards [(stuckModel_isOpen_poleSq plantS).mem_nhds hxS,
      stuckModel_eventually_lt_iff (f := fun y => |(y - plantS).re|) (g := fun y => (y - plantS).im) (by fun_prop)
        (by fun_prop) d2,
      stuckModel_eventually_lt_iff (f := fun y => (y - plantS).im) (g := fun y => -|(y - plantS).re|) (by fun_prop)
        (by fun_prop) d1,
      stuckModel_eventually_lt_iff (f := fun y => |(y - plantS).im|) (g := fun y => (y - plantS).re) (by fun_prop)
        (by fun_prop) d3] with y hyS h1 h2 h3
    obtain ⟨hyb, hyN⟩ := stuckModel_sq_disjoint.2 hyS
    obtain ⟨hxb, hxN⟩ := stuckModel_sq_disjoint.2 hxS
    simp only [stuckCol, hyb, hxb, if_false, hyN, hxN, h1, h2, h3]

/-- **The planted bowtie** (FS131-E7's `P₅`): a valid map of the plane in twelve colours with a stuck vertex at `plantPt`. -/
noncomputable def stuckModel : ArcMap 12 :=
  (brickBase 12 (by norm_num)).paint stuckW stuckArcs stuckArcs_nondegenerate stuckArcs_finite frontier_stuckW_subset stuckCol
    stuckCol_locallyConstant

/-- `stuckModel` is a map of the plane. -/
theorem stuckModel_isPlaneMap : stuckModel.IsPlaneMap := ArcMap.paint_isPlaneMap (brickBase_isPlaneMap 12 _)

/-- `stuckModel` covers the closed unit disc about its vertex. -/
theorem stuckModel_covers : stuckModel.Covers plantPt 1 := ArcMap.covers_of_isPlaneMap stuckModel_isPlaneMap _ _

section StuckModelHelpers

open ArcMap

/-! ### The painted classes of `stuckModel`, and the partition at the vertex (FS131-MB1's helpers) -/

/-- The painted set lies among the base's interior points: each of its three pieces is strictly inside one brick. -/
theorem stuckModel_stuckW_subset : stuckW ⊆ (brickBase 12 (by norm_num)).interiorPts := by
  rintro z ((hz | hz) | hz)
  · obtain ⟨h1, h2⟩ := stuckModel_pieces.1 (mem_ball.mp hz).le
    rw [abs_le] at h1 h2
    exact brickBase_mem_interiorPts _ (c := 0) (r := 0) (by constructor <;> push_cast <;> linarith)
      (by constructor <;> push_cast <;> linarith)
  · obtain ⟨h1, h2⟩ := stuckModel_pieces.2.1 ⟨(stuckModel_mem_poleSq.mp hz).1.le, (stuckModel_mem_poleSq.mp hz).2.le⟩
    rw [abs_le] at h1 h2
    exact brickBase_mem_interiorPts _ (c := -1) (r := 2) (by constructor <;> push_cast <;> linarith)
      (by constructor <;> push_cast <;> linarith)
  · obtain ⟨h1, h2⟩ := stuckModel_pieces.2.2 ⟨(stuckModel_mem_poleSq.mp hz).1.le, (stuckModel_mem_poleSq.mp hz).2.le⟩
    rw [abs_le] at h1 h2
    exact brickBase_mem_interiorPts _ (c := 1) (r := -2) (by constructor <;> push_cast <;> linarith)
      (by constructor <;> push_cast <;> linarith)

/-- The interior points of `stuckModel`: the base's off the new arcs. -/
theorem stuckModel_interiorPts_eq :
    stuckModel.interiorPts = (brickBase 12 (by norm_num)).interiorPts \ ⋃ a ∈ stuckArcs, a.carrier :=
  ArcMap.interiorPts_paint

/-- The colour of a painted point. -/
theorem stuckModel_col_eq {z : ℂ} (hz : z ∈ stuckW) : stuckModel.col z = stuckCol z := ArcMap.paint_col_of_mem hz

/-- A point of the painted set off the new arcs is an interior point of its painted colour's class. -/
theorem stuckModel_mem_region_of {z : ℂ} (hz : z ∈ stuckW) (ha : z ∉ ⋃ a ∈ stuckArcs, a.carrier) :
    z ∈ stuckModel.region (stuckCol z) :=
  ⟨by rw [stuckModel_interiorPts_eq]; exact ⟨stuckModel_stuckW_subset hz, ha⟩, stuckModel_col_eq hz⟩

/-- **The class of a painted colour is its painted set**: it lies in the painted set, off the new arcs (the base has no class of a spare
colour). -/
theorem stuckModel_region_subset {j : Fin 12} (hj : 7 ≤ (j : ℕ)) {z : ℂ} (hz : z ∈ stuckModel.region j) :
    z ∈ stuckW ∧ z ∉ ⋃ a ∈ stuckArcs, a.carrier ∧ stuckCol z = j := by
  have h := hz
  unfold stuckModel at h
  rw [ArcMap.region_paint, brickBase_region_spare _ hj] at h
  obtain ⟨h | h, hB⟩ := h
  · exact absurd h.1 (notMem_empty z)
  · exact ⟨h.1.2, hB, h.2⟩

/-- The painting within `1/10` of the vertex. -/
theorem stuckModel_stuckCol_ball {z : ℂ} (hz : dist z plantPt < 1 / 10) :
    (dist z plantN < 1 → stuckCol z = 7) ∧ (¬ dist z plantN < 1 → dist z plantS < 1 → stuckCol z = 8) ∧
    (¬ dist z plantN < 1 → ¬ dist z plantS < 1 → stuckCol z = 9) := by
  refine ⟨fun h => ?_, fun h h' => ?_, fun h h' => ?_⟩
  · simp only [stuckCol, hz, h, if_true]
  · simp only [stuckCol, hz, h, h', if_true, if_false]
  · simp only [stuckCol, hz, h, h', if_true, if_false]

/-- The painting in the square about `N`: `7` exactly on the wedge toward the vertex, `9` exactly on the wedge away from it, never `8`. -/
theorem stuckModel_stuckCol_sqN {z : ℂ} (hz : z ∈ poleSq plantN) :
    (stuckCol z = 7 ↔ (z - plantN).im < -|(z - plantN).re|) ∧ (stuckCol z = 9 ↔ |(z - plantN).re| < (z - plantN).im) ∧
      stuckCol z ≠ 8 := by
  have hb := stuckModel_sq_disjoint.1 hz
  by_cases h1 : (z - plantN).im < -|(z - plantN).re|
  · have h2 : ¬ |(z - plantN).re| < (z - plantN).im := by
      have := abs_nonneg (z - plantN).re; intro h; linarith
    have hc : stuckCol z = 7 := by simp only [stuckCol, hb, hz, h1, if_true, if_false]
    rw [hc]
    exact ⟨⟨fun _ => h1, fun _ => rfl⟩, ⟨fun h => absurd h (by decide), fun h => absurd h h2⟩, by decide⟩
  · by_cases h2 : |(z - plantN).re| < (z - plantN).im
    · have hc : stuckCol z = 9 := by simp only [stuckCol, hb, hz, h1, h2, if_true, if_false]
      rw [hc]
      exact ⟨⟨fun h => absurd h (by decide), fun h => absurd h h1⟩, ⟨fun _ => h2, fun _ => rfl⟩, by decide⟩
    · by_cases h3 : |(z - plantN).im| < (z - plantN).re
      · have hc : stuckCol z = 10 := by simp only [stuckCol, hb, hz, h1, h2, h3, if_true, if_false]
        rw [hc]
        exact ⟨⟨fun h => absurd h (by decide), fun h => absurd h h1⟩,
          ⟨fun h => absurd h (by decide), fun h => absurd h h2⟩, by decide⟩
      · have hc : stuckCol z = 11 := by simp only [stuckCol, hb, hz, h1, h2, h3, if_true, if_false]
        rw [hc]
        exact ⟨⟨fun h => absurd h (by decide), fun h => absurd h h1⟩,
          ⟨fun h => absurd h (by decide), fun h => absurd h h2⟩, by decide⟩

/-- The painting in the square about `S′`: `8` exactly on the wedge toward the vertex, `9` exactly on the wedge away from it, never `7`. -/
theorem stuckModel_stuckCol_sqS {z : ℂ} (hz : z ∈ poleSq plantS) :
    (stuckCol z = 8 ↔ |(z - plantS).re| < (z - plantS).im) ∧ (stuckCol z = 9 ↔ (z - plantS).im < -|(z - plantS).re|) ∧
      stuckCol z ≠ 7 := by
  obtain ⟨hb, hN⟩ := stuckModel_sq_disjoint.2 hz
  by_cases h1 : |(z - plantS).re| < (z - plantS).im
  · have h2 : ¬ (z - plantS).im < -|(z - plantS).re| := by
      have := abs_nonneg (z - plantS).re; intro h; linarith
    have hc : stuckCol z = 8 := by simp only [stuckCol, hb, hN, h1, if_true, if_false]
    rw [hc]
    exact ⟨⟨fun _ => h1, fun _ => rfl⟩, ⟨fun h => absurd h (by decide), fun h => absurd h h2⟩, by decide⟩
  · by_cases h2 : (z - plantS).im < -|(z - plantS).re|
    · have hc : stuckCol z = 9 := by simp only [stuckCol, hb, hN, h1, h2, if_true, if_false]
      rw [hc]
      exact ⟨⟨fun h => absurd h (by decide), fun h => absurd h h1⟩, ⟨fun _ => h2, fun _ => rfl⟩, by decide⟩
    · by_cases h3 : |(z - plantS).im| < (z - plantS).re
      · have hc : stuckCol z = 10 := by simp only [stuckCol, hb, hN, h1, h2, h3, if_true, if_false]
        rw [hc]
        exact ⟨⟨fun h => absurd h (by decide), fun h => absurd h h1⟩,
          ⟨fun h => absurd h (by decide), fun h => absurd h h2⟩, by decide⟩
      · have hc : stuckCol z = 11 := by simp only [stuckCol, hb, hN, h1, h2, h3, if_false]
        rw [hc]
        exact ⟨⟨fun h => absurd h (by decide), fun h => absurd h h1⟩,
          ⟨fun h => absurd h (by decide), fun h => absurd h h2⟩, by decide⟩

/-- Every painted colour is spare. -/
theorem stuckModel_stuckCol_spare (z : ℂ) : 7 ≤ ((stuckCol z : Fin 12) : ℕ) := by
  unfold stuckCol
  split_ifs <;> decide

/-- **The four pieces at the vertex**: the cusp fragment's (`ArcMap.cuspPiece`), moved to `plantPt` — the two horns, then the parts of
the unit discs about `N` and `S′`. -/
noncomputable def stuckModelPiece (r : ℝ) (i : Fin 4) : Set ℂ := (fun w => w + plantPt) '' cuspPiece r i

theorem stuckModel_mem_piece {r : ℝ} {i : Fin 4} {z : ℂ} : z ∈ stuckModelPiece r i ↔ z - plantPt ∈ cuspPiece r i := by
  unfold stuckModelPiece
  rw [image_add_right]; simp only [mem_preimage, ← sub_eq_add_neg]

/-- Norms relative to the vertex are the distances to the vertex and its poles. -/
theorem stuckModel_norms (z : ℂ) : ‖z - plantPt‖ = dist z plantPt ∧ ‖z - plantPt - I‖ = dist z plantN ∧
    ‖z - plantPt + I‖ = dist z plantS := by
  refine ⟨(dist_eq_norm _ _).symm, ?_, ?_⟩
  · rw [dist_eq_norm, plantN, sub_add_eq_sub_sub]
  · rw [dist_eq_norm, plantS]; congr 1; ring

/-- The four pieces by distances to the vertex and its poles. -/
theorem stuckModel_piece_cases {r : ℝ} {z : ℂ} :
    (z ∈ stuckModelPiece r 0 ↔ dist z plantPt < r ∧ 0 < z.re - plantPt.re ∧ 1 < dist z plantS ∧ 1 < dist z plantN) ∧
    (z ∈ stuckModelPiece r 1 ↔ dist z plantPt < r ∧ z.re - plantPt.re < 0 ∧ 1 < dist z plantS ∧ 1 < dist z plantN) ∧
    (z ∈ stuckModelPiece r 2 ↔ dist z plantPt < r ∧ dist z plantN < 1) ∧
    (z ∈ stuckModelPiece r 3 ↔ dist z plantPt < r ∧ dist z plantS < 1) := by
  obtain ⟨n0, n1, n2⟩ := stuckModel_norms z
  refine ⟨?_, ?_, ?_, ?_⟩
  · rw [stuckModel_mem_piece]
    show z - plantPt ∈ hornSet 0 0 (-1) 1 r ↔ _
    rw [hornSet_cusp_iff, n0, n1, n2, Complex.sub_re]
  · rw [stuckModel_mem_piece]
    show z - plantPt ∈ (fun z => -(starRingEnd ℂ z)) '' hornSet 0 0 (-1) 1 r ↔ _
    rw [mem_cuspPiece_one, n0, n1, n2, Complex.sub_re]
  · rw [stuckModel_mem_piece]
    show z - plantPt ∈ ball 0 r ∩ ball I 1 ↔ _
    rw [mem_inter_iff, mem_ball_zero_iff, mem_ball, dist_eq_norm, n0, n1]
  · rw [stuckModel_mem_piece]
    show z - plantPt ∈ ball 0 r ∩ ball (-I) 1 ↔ _
    rw [mem_inter_iff, mem_ball_zero_iff, mem_ball, dist_eq_norm, sub_neg_eq_add, n0, n2]

/-- **The partition at the vertex**: for `r ≤ 1/10` the interior points of `B(plantPt, r)` are the four pieces. -/
theorem stuckModel_partition {r : ℝ} (hr : r ≤ 1 / 10) :
    stuckModel.interiorPts ∩ ball plantPt r = ⋃ i, stuckModelPiece r i := by
  ext z
  obtain ⟨n0, n1, n2⟩ := stuckModel_norms z
  have hcusp : z - plantPt ∈ cuspFrag.interiorPts ∩ ball 0 r ↔ z ∈ ⋃ i, stuckModelPiece r i := by
    rw [cuspFrag_partition (by linarith)]; simp only [mem_iUnion, stuckModel_mem_piece]
  rw [← hcusp, mem_inter_iff, mem_inter_iff, cuspFrag_mem_interiorPts, mem_ball_zero_iff, n0, n1, n2, mem_ball,
    stuckModel_interiorPts_eq]
  constructor
  · rintro ⟨⟨-, ha⟩, hb⟩
    have hb' : dist z plantPt < 1 / 10 := by linarith
    rw [stuckModel_mem_arcs_ball_iff hb', not_or] at ha
    exact ⟨⟨by linarith, ha.1, ha.2⟩, hb⟩
  · rintro ⟨⟨-, h1, h2⟩, hb⟩
    have hb' : dist z plantPt < 1 / 10 := by linarith
    refine ⟨⟨stuckModel_stuckW_subset (Or.inl (Or.inl (mem_ball.mpr hb'))), ?_⟩, hb⟩
    rw [stuckModel_mem_arcs_ball_iff hb', not_or]; exact ⟨h1, h2⟩

/-- The four pieces, for `0 < r ≤ 1/10`: open, preconnected, pairwise disjoint, non-empty, each with the vertex in its closure. -/
theorem stuckModelPiece_data {r : ℝ} (hr0 : 0 < r) (hr : r ≤ 1 / 10) :
    (∀ i, IsOpen (stuckModelPiece r i)) ∧ (∀ i, IsPreconnected (stuckModelPiece r i)) ∧
      (∀ i j, i ≠ j → Disjoint (stuckModelPiece r i) (stuckModelPiece r j)) ∧ (∀ i, (stuckModelPiece r i).Nonempty) ∧
      ∀ i, plantPt ∈ closure (stuckModelPiece r i) := by
  obtain ⟨ho, hp, hd, hn, hc⟩ := cuspPiece_data hr0 (by linarith)
  have hcont : Continuous fun w : ℂ => w + plantPt := by fun_prop
  refine ⟨fun i => ?_, fun i => (hp i).image _ hcont.continuousOn, fun i j hij => ?_, fun i => (hn i).image _, fun i => ?_⟩
  · exact isOpenMap_add_right plantPt _ (ho i)
  · exact (disjoint_image_iff (add_left_injective plantPt)).mpr (hd i j hij)
  · exact image_closure_subset_closure_image hcont ⟨0, hc i, zero_add _⟩

/-- The colours of the four pieces: `9` on the two horns, `7` and `8` on the parts of the unit discs about `N` and `S′`. -/
theorem stuckModel_piece_col {r : ℝ} (hr : r ≤ 1 / 10) (i : Fin 4) :
    stuckModelPiece r i ⊆ stuckModel.col ⁻¹' {![9, 9, 7, 8] i} := by
  intro z hz
  obtain ⟨p0, p1, p2, p3⟩ := stuckModel_piece_cases (r := r) (z := z)
  have hb : dist z plantPt < 1 / 10 := by
    fin_cases i
    · exact lt_of_lt_of_le (p0.mp hz).1 hr
    · exact lt_of_lt_of_le (p1.mp hz).1 hr
    · exact lt_of_lt_of_le (p2.mp hz).1 hr
    · exact lt_of_lt_of_le (p3.mp hz).1 hr
  obtain ⟨c7, c8, c9⟩ := stuckModel_stuckCol_ball hb
  show stuckModel.col z = _
  rw [stuckModel_col_eq (Or.inl (Or.inl (mem_ball.mpr hb)))]
  fin_cases i
  · obtain ⟨-, -, hS, hN⟩ := p0.mp hz
    exact c9 (not_lt.mpr hN.le) (not_lt.mpr hS.le)
  · obtain ⟨-, -, hS, hN⟩ := p1.mp hz
    exact c9 (not_lt.mpr hN.le) (not_lt.mpr hS.le)
  · exact c7 (p2.mp hz).2
  · have hS := (p3.mp hz).2
    refine c8 (fun hN => ?_) hS
    obtain ⟨n0, n1, n2⟩ := stuckModel_norms z
    have hsum := norm_sub_I_sq_add (z - plantPt)
    rw [n0, n1, n2] at hsum
    have h1 : dist z plantN ^ 2 < 1 := (sq_lt_one_iff₀ dist_nonneg).mpr hN
    have h2 : dist z plantS ^ 2 < 1 := (sq_lt_one_iff₀ dist_nonneg).mpr hS
    linarith [sq_nonneg (dist z plantPt)]

/-- Each piece lies in its colour's class. -/
theorem stuckModel_piece_subset_region {r : ℝ} (hr : r ≤ 1 / 10) (i : Fin 4) :
    stuckModelPiece r i ⊆ stuckModel.region (![9, 9, 7, 8] i) := fun z hz =>
  ⟨(show z ∈ stuckModel.interiorPts ∩ ball plantPt r by rw [stuckModel_partition hr]; exact mem_iUnion.mpr ⟨i, hz⟩).1,
    stuckModel_piece_col hr i hz⟩

/-- The horn pieces are the horn sets at the vertex along `e 0` and `e π`. -/
theorem stuckModel_piece_hornSet (r : ℝ) : stuckModelPiece r 0 = hornSet plantPt 0 (-1) 1 r ∧
    stuckModelPiece r 1 = hornSet plantPt π (-1) 1 r := by
  have htr : ∀ α : ℝ, (fun w => w + plantPt) '' hornSet 0 α (-1) 1 r = hornSet plantPt α (-1) 1 r := by
    intro α
    ext z
    rw [image_add_right]
    simp only [mem_preimage, ← sub_eq_add_neg, hornSet, TanAbove, TanBelow, frameX, frameY, sub_zero, mem_setOf_eq,
      dist_eq_norm]
  refine ⟨htr 0, ?_⟩
  rw [← htr π, hornSet_cusp_pi_eq]; rfl

/-- The number of sectors of each colour at the vertex, at a small radius: the pieces of that colour. -/
theorem stuckModel_sectorsOf_encard {r : ℝ} (hr0 : 0 < r) (hr : r ≤ 1 / 10) (c : Fin 12) :
    (stuckModel.sectorsOf plantPt r c).encard = {i : Fin 4 | ![9, 9, 7, 8] i = c}.encard := by
  obtain ⟨ho, hp, hd, hn, hc⟩ := stuckModelPiece_data hr0 hr
  rw [encard_sectorsOf_of_partition (stuckModel_partition hr) ho hp hd (fun i _ => hc i) (stuckModel_piece_col hr) c]
  congr 1
  ext i
  simp only [mem_setOf_eq, hn i, true_and]

/-! ### Validity, the contacts at the poles, and the moves at the vertex (FS131-MB1's helpers) -/

/-- The unit discs about the poles, in coordinates. -/
theorem stuckModel_dist_pole_lt (x : ℂ) :
    (dist x plantN < 1 ↔ (x.re - 2 / 5) ^ 2 + (x.im - 3 / 10 - 1) ^ 2 < 1) ∧
    (dist x plantS < 1 ↔ (x.re - 2 / 5) ^ 2 + (x.im - 3 / 10 + 1) ^ 2 < 1) := by
  obtain ⟨-, -, h3, h4, h5, h6⟩ := stuckModel_plant_coords
  constructor
  · rw [← sq_lt_one_iff₀ dist_nonneg, stuckModel_dist_sq, h3, h4, show x.im - 13 / 10 = x.im - 3 / 10 - 1 by ring]
  · rw [← sq_lt_one_iff₀ dist_nonneg, stuckModel_dist_sq, h5, h6, show x.im - -7 / 10 = x.im - 3 / 10 + 1 by ring]

/-- E7 § 7.2, colour `7`, in real variables: a point within `1/10` of the vertex inside the unit disc about `N` and a point of the wedge
toward the vertex at `N` are not `1` apart (they are closer). -/
theorem stuckModel_near_real {X Y a b : ℝ} (hX : |X| ≤ 1 / 10) (hY : |Y| ≤ 1 / 10) (hb : |b| ≤ 1 / 20) (hw : b < -|a|)
    (hd : X ^ 2 + (Y - 1) ^ 2 < 1) : (X - a) ^ 2 + (Y - 1 - b) ^ 2 ≠ 1 := by
  obtain ⟨hX1, hX2⟩ := abs_le.mp hX
  obtain ⟨-, hY2⟩ := abs_le.mp hY
  obtain ⟨hb1, -⟩ := abs_le.mp hb
  obtain ⟨ha1, ha2⟩ := abs_lt.mp (lt_neg.mp hw)
  have H1 := mul_nonneg (sub_nonneg.mpr hX2) (by linarith : (0 : ℝ) ≤ -b - a)
  have H2 := mul_nonneg (by linarith : (0 : ℝ) ≤ 1 / 10 + X) (by linarith : (0 : ℝ) ≤ a - b)
  have H3 := mul_nonneg (sub_nonneg.mpr hY2) (by linarith : (0 : ℝ) ≤ -b)
  have H4 := mul_nonneg (by linarith : (0 : ℝ) ≤ -b - a) (by linarith : (0 : ℝ) ≤ a - b)
  have H5 := mul_nonneg (by linarith : (0 : ℝ) ≤ b + 1 / 20) (by linarith : (0 : ℝ) ≤ -b)
  intro h
  nlinarith

/-- Colour `8`: the mirror image at `S′`. -/
theorem stuckModel_near_real' {X Y a b : ℝ} (hX : |X| ≤ 1 / 10) (hY : |Y| ≤ 1 / 10) (hb : |b| ≤ 1 / 20) (hw : |a| < b)
    (hd : X ^ 2 + (Y + 1) ^ 2 < 1) : (X - a) ^ 2 + (Y + 1 - b) ^ 2 ≠ 1 := by
  obtain ⟨hX1, hX2⟩ := abs_le.mp hX
  obtain ⟨hY1, -⟩ := abs_le.mp hY
  obtain ⟨-, hb2⟩ := abs_le.mp hb
  obtain ⟨ha1, ha2⟩ := abs_lt.mp hw
  have H1 := mul_nonneg (sub_nonneg.mpr hX2) (by linarith : (0 : ℝ) ≤ b - a)
  have H2 := mul_nonneg (by linarith : (0 : ℝ) ≤ 1 / 10 + X) (by linarith : (0 : ℝ) ≤ b + a)
  have H3 := mul_nonneg (by linarith : (0 : ℝ) ≤ Y + 1 / 10) (by linarith : (0 : ℝ) ≤ b)
  have H4 := mul_nonneg (by linarith : (0 : ℝ) ≤ b - a) (by linarith : (0 : ℝ) ≤ b + a)
  have H5 := mul_nonneg (by linarith : (0 : ℝ) ≤ 1 / 20 - b) (by linarith : (0 : ℝ) ≤ b)
  intro h
  nlinarith

/-- E7 § 7.2, colour `9`, in real variables: a point within `1/10` of the vertex outside the unit disc about `N` and a point of the wedge
away from the vertex at `N` are not `1` apart (they are farther). -/
theorem stuckModel_far_real {X Y a b : ℝ} (hX : |X| ≤ 1 / 10) (hY : |Y| ≤ 1 / 10) (hw : |a| < b)
    (hd : ¬ X ^ 2 + (Y - 1) ^ 2 < 1) : (X - a) ^ 2 + (Y - 1 - b) ^ 2 ≠ 1 := by
  obtain ⟨hX1, hX2⟩ := abs_le.mp hX
  obtain ⟨-, hY2⟩ := abs_le.mp hY
  obtain ⟨ha1, ha2⟩ := abs_lt.mp hw
  have hd' := not_lt.mp hd
  have H1 := mul_nonneg (sub_nonneg.mpr hX2) (by linarith : (0 : ℝ) ≤ b + a)
  have H2 := mul_nonneg (by linarith : (0 : ℝ) ≤ 1 / 10 + X) (by linarith : (0 : ℝ) ≤ b - a)
  have H3 := mul_nonneg (sub_nonneg.mpr hY2) (by linarith : (0 : ℝ) ≤ b)
  intro h
  nlinarith [sq_nonneg a, sq_nonneg b]

/-- Colour `9` at `S′`: the mirror image. -/
theorem stuckModel_far_real' {X Y a b : ℝ} (hX : |X| ≤ 1 / 10) (hY : |Y| ≤ 1 / 10) (hw : b < -|a|)
    (hd : ¬ X ^ 2 + (Y + 1) ^ 2 < 1) : (X - a) ^ 2 + (Y + 1 - b) ^ 2 ≠ 1 := by
  obtain ⟨hX1, hX2⟩ := abs_le.mp hX
  obtain ⟨hY1, -⟩ := abs_le.mp hY
  obtain ⟨ha1, ha2⟩ := abs_lt.mp (lt_neg.mp hw)
  have hd' := not_lt.mp hd
  have H1 := mul_nonneg (sub_nonneg.mpr hX2) (by linarith : (0 : ℝ) ≤ a - b)
  have H2 := mul_nonneg (by linarith : (0 : ℝ) ≤ 1 / 10 + X) (by linarith : (0 : ℝ) ≤ -b - a)
  have H3 := mul_nonneg (by linarith : (0 : ℝ) ≤ Y + 1 / 10) (by linarith : (0 : ℝ) ≤ -b)
  intro h
  nlinarith [sq_nonneg a, sq_nonneg b]

/-- No unit pair of one painted colour with a point within `1/10` of the vertex. -/
theorem stuckModel_unit_pair_ball {x y : ℂ} (hx : dist x plantPt < 1 / 10) (hy : y ∈ stuckW) (hxy : dist x y = 1) :
    stuckCol x ≠ stuckCol y := by
  obtain ⟨-, -, hNre, hNim, hSre, hSim⟩ := stuckModel_plant_coords
  obtain ⟨hX, hY⟩ := stuckModel_pieces.1 hx.le
  have hsq := sq_coords_of_dist_eq_one hxy
  obtain ⟨b7, b8, b9⟩ := stuckModel_stuckCol_ball hx
  obtain ⟨dN, dS⟩ := stuckModel_dist_pole_lt x
  rcases hy with (hyb | hyN) | hyS
  · exfalso
    obtain ⟨hX', hY'⟩ := stuckModel_pieces.1 (mem_ball.mp hyb).le
    obtain ⟨a1, a2⟩ := abs_le.mp hX; obtain ⟨a3, a4⟩ := abs_le.mp hY
    obtain ⟨a5, a6⟩ := abs_le.mp hX'; obtain ⟨a7, a8⟩ := abs_le.mp hY'
    have h1 : (x.re - y.re) ^ 2 ≤ (1 / 5) ^ 2 := sq_le_sq' (by linarith) (by linarith)
    have h2 : (x.im - y.im) ^ 2 ≤ (1 / 5) ^ 2 := sq_le_sq' (by linarith) (by linarith)
    norm_num at h1 h2; linarith
  · obtain ⟨c7, c9, c8⟩ := stuckModel_stuckCol_sqN hyN
    have hb : |(y - plantN).im| ≤ 1 / 20 := hyN.2.le
    have hconv : (x.re - 2 / 5 - (y - plantN).re) ^ 2 + (x.im - 3 / 10 - 1 - (y - plantN).im) ^ 2 = 1 := by
      have e : (x.re - 2 / 5 - (y - plantN).re) ^ 2 + (x.im - 3 / 10 - 1 - (y - plantN).im) ^ 2 =
          (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 := by rw [Complex.sub_re, Complex.sub_im, hNre, hNim]; ring
      rw [e]; exact hsq
    by_cases hN : dist x plantN < 1
    · rw [b7 hN]
      intro h
      exact stuckModel_near_real hX hY hb (c7.mp h.symm) (dN.mp hN) hconv
    · by_cases hS : dist x plantS < 1
      · rw [b8 hN hS]; exact fun h => c8 h.symm
      · rw [b9 hN hS]
        intro h
        exact stuckModel_far_real hX hY (c9.mp h.symm) (fun h' => hN (dN.mpr h')) hconv
  · obtain ⟨c8, c9, c7⟩ := stuckModel_stuckCol_sqS hyS
    have hb : |(y - plantS).im| ≤ 1 / 20 := hyS.2.le
    have hconv : (x.re - 2 / 5 - (y - plantS).re) ^ 2 + (x.im - 3 / 10 + 1 - (y - plantS).im) ^ 2 = 1 := by
      have e : (x.re - 2 / 5 - (y - plantS).re) ^ 2 + (x.im - 3 / 10 + 1 - (y - plantS).im) ^ 2 =
          (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 := by rw [Complex.sub_re, Complex.sub_im, hSre, hSim]; ring
      rw [e]; exact hsq
    by_cases hN : dist x plantN < 1
    · rw [b7 hN]; exact fun h => c7 h.symm
    · by_cases hS : dist x plantS < 1
      · rw [b8 hN hS]
        intro h
        exact stuckModel_near_real' hX hY hb (c8.mp h.symm) (dS.mp hS) hconv
      · rw [b9 hN hS]
        intro h
        exact stuckModel_far_real' hX hY (c9.mp h.symm) (fun h' => hS (dS.mpr h')) hconv

/-- **No unit pair of one painted colour inside the painted set** (FS131-E7 § 7.2, with squares at the poles). -/
theorem stuckModel_no_unit_pair {x y : ℂ} (hx : x ∈ stuckW) (hy : y ∈ stuckW) (hxy : dist x y = 1) :
    stuckCol x ≠ stuckCol y := by
  have hsq := sq_coords_of_dist_eq_one hxy
  have hsame : ∀ c : ℝ, |x.re - 2 / 5| ≤ 1 / 20 → |x.im - c| ≤ 1 / 20 → |y.re - 2 / 5| ≤ 1 / 20 → |y.im - c| ≤ 1 / 20 →
      False := by
    intro c a1 a2 a3 a4
    obtain ⟨a1, a1'⟩ := abs_le.mp a1; obtain ⟨a2, a2'⟩ := abs_le.mp a2
    obtain ⟨a3, a3'⟩ := abs_le.mp a3; obtain ⟨a4, a4'⟩ := abs_le.mp a4
    have h1 : (x.re - y.re) ^ 2 ≤ (1 / 10) ^ 2 := sq_le_sq' (by linarith) (by linarith)
    have h2 : (x.im - y.im) ^ 2 ≤ (1 / 10) ^ 2 := sq_le_sq' (by linarith) (by linarith)
    norm_num at h1 h2; linarith
  have hfar : ∀ u w : ℂ, |u.im - 13 / 10| ≤ 1 / 20 → |w.im + 7 / 10| ≤ 1 / 20 →
      (u.re - w.re) ^ 2 + (u.im - w.im) ^ 2 = 1 → False := by
    intro u w a1 a2 h
    obtain ⟨a1, -⟩ := abs_le.mp a1; obtain ⟨-, a2⟩ := abs_le.mp a2
    nlinarith [sq_nonneg (u.re - w.re), mul_nonneg (by linarith : (0 : ℝ) ≤ u.im - w.im - 19 / 10)
      (by linarith : (0 : ℝ) ≤ u.im - w.im)]
  have sqN : ∀ w : ℂ, w ∈ poleSq plantN → |w.re - 2 / 5| ≤ 1 / 20 ∧ |w.im - 13 / 10| ≤ 1 / 20 := fun w hw =>
    stuckModel_pieces.2.1 ⟨(stuckModel_mem_poleSq.mp hw).1.le, (stuckModel_mem_poleSq.mp hw).2.le⟩
  have sqS : ∀ w : ℂ, w ∈ poleSq plantS → |w.re - 2 / 5| ≤ 1 / 20 ∧ |w.im + 7 / 10| ≤ 1 / 20 := fun w hw =>
    stuckModel_pieces.2.2 ⟨(stuckModel_mem_poleSq.mp hw).1.le, (stuckModel_mem_poleSq.mp hw).2.le⟩
  rcases hx with (hxb | hxN) | hxS
  · exact stuckModel_unit_pair_ball (mem_ball.mp hxb) hy hxy
  · rcases hy with (hyb | hyN) | hyS
    · exact (stuckModel_unit_pair_ball (mem_ball.mp hyb) (Or.inl (Or.inr hxN)) (by rw [dist_comm]; exact hxy)).symm
    · exact (hsame (13 / 10) (sqN x hxN).1 (sqN x hxN).2 (sqN y hyN).1 (sqN y hyN).2).elim
    · exact (hfar x y (sqN x hxN).2 (sqS y hyS).2 hsq).elim
  · rcases hy with (hyb | hyN) | hyS
    · exact (stuckModel_unit_pair_ball (mem_ball.mp hyb) (Or.inr hxS) (by rw [dist_comm]; exact hxy)).symm
    · exact (hfar y x (sqN y hyN).2 (sqS x hxS).2 (by rw [← hsq]; ring)).elim
    · refine (hsame (-(7 / 10)) (sqS x hxS).1 ?_ (sqS y hyS).1 ?_).elim
      · rw [sub_neg_eq_add]; exact (sqS x hxS).2
      · rw [sub_neg_eq_add]; exact (sqS y hyS).2

/-- **The four wedges at the poles lie in their colours' classes**: at `N`, `7` toward the vertex and `9` away from it; at `S′`, `8`
toward the vertex and `9` away from it. -/
theorem stuckModel_wedges {z : ℂ} :
    (z ∈ poleSq plantN → (z - plantN).im < -|(z - plantN).re| → z ∈ stuckModel.region 7) ∧
    (z ∈ poleSq plantN → |(z - plantN).re| < (z - plantN).im → z ∈ stuckModel.region 9) ∧
    (z ∈ poleSq plantS → |(z - plantS).re| < (z - plantS).im → z ∈ stuckModel.region 8) ∧
    (z ∈ poleSq plantS → (z - plantS).im < -|(z - plantS).re| → z ∈ stuckModel.region 9) := by
  have key : ∀ a b : ℝ, (b < -|a| ∨ |a| < b) → |a| ≠ |b| := by
    intro a b h hab
    rcases h with h | h
    · have := neg_abs_le b; linarith
    · have := le_abs_self b; linarith
  refine ⟨fun hz hw => ?_, fun hz hw => ?_, fun hz hw => ?_, fun hz hw => ?_⟩
  · have h := stuckModel_mem_region_of (Or.inl (Or.inr hz))
      (fun ha => key _ _ (Or.inl hw) ((stuckModel_mem_arcs_sq_iff.1 hz).mp ha))
    rwa [(stuckModel_stuckCol_sqN hz).1.mpr hw] at h
  · have h := stuckModel_mem_region_of (Or.inl (Or.inr hz))
      (fun ha => key _ _ (Or.inr hw) ((stuckModel_mem_arcs_sq_iff.1 hz).mp ha))
    rwa [(stuckModel_stuckCol_sqN hz).2.1.mpr hw] at h
  · have h := stuckModel_mem_region_of (Or.inr hz)
      (fun ha => key _ _ (Or.inr hw) ((stuckModel_mem_arcs_sq_iff.2 hz).mp ha))
    rwa [(stuckModel_stuckCol_sqS hz).1.mpr hw] at h
  · have h := stuckModel_mem_region_of (Or.inr hz)
      (fun ha => key _ _ (Or.inl hw) ((stuckModel_mem_arcs_sq_iff.2 hz).mp ha))
    rwa [(stuckModel_stuckCol_sqS hz).2.1.mpr hw] at h

/-- The points just below and just above a pole lie in its square, in the lower and the upper wedge. -/
theorem stuckModel_pole_rays (p : ℂ) {t : ℝ} (ht0 : 0 < t) (ht : t < 1 / 20) :
    (p + (t : ℂ) * (-I) ∈ poleSq p ∧ (p + (t : ℂ) * (-I) - p).im < -|(p + (t : ℂ) * (-I) - p).re|) ∧
    (p + (t : ℂ) * I ∈ poleSq p ∧ |(p + (t : ℂ) * I - p).re| < (p + (t : ℂ) * I - p).im) := by
  have e1 : (p + (t : ℂ) * (-I) - p).re = 0 ∧ (p + (t : ℂ) * (-I) - p).im = -t := by constructor <;> simp
  have e2 : (p + (t : ℂ) * I - p).re = 0 ∧ (p + (t : ℂ) * I - p).im = t := by constructor <;> simp
  refine ⟨⟨?_, ?_⟩, ⟨?_, ?_⟩⟩
  · show |(p + (t : ℂ) * (-I) - p).re| < 1 / 20 ∧ |(p + (t : ℂ) * (-I) - p).im| < 1 / 20
    rw [e1.1, e1.2, abs_zero, abs_neg, abs_of_pos ht0]; exact ⟨by norm_num, ht⟩
  · rw [e1.1, e1.2, abs_zero]; linarith
  · show |(p + (t : ℂ) * I - p).re| < 1 / 20 ∧ |(p + (t : ℂ) * I - p).im| < 1 / 20
    rw [e2.1, e2.2, abs_zero, abs_of_pos ht0]; exact ⟨by norm_num, ht⟩
  · rw [e2.1, e2.2, abs_zero]; exact ht0

/-- The squared distance to the vertex, in coordinates. -/
theorem stuckModel_dist_vertex_sq (z : ℂ) : dist z plantPt ^ 2 = (z.re - 2 / 5) ^ 2 + (z.im - 3 / 10) ^ 2 := by
  rw [stuckModel_dist_sq, stuckModel_plant_coords.1, stuckModel_plant_coords.2.1]

/-- The wedges at the poles against the unit disc about the vertex: the wedges toward the vertex lie inside it, the wedges away from it
outside its closure. -/
theorem stuckModel_wedge_dist {z : ℂ} :
    (z ∈ poleSq plantN → (z - plantN).im < -|(z - plantN).re| → dist z plantPt < 1) ∧
    (z ∈ poleSq plantN → |(z - plantN).re| < (z - plantN).im → 1 < dist z plantPt) ∧
    (z ∈ poleSq plantS → |(z - plantS).re| < (z - plantS).im → dist z plantPt < 1) ∧
    (z ∈ poleSq plantS → (z - plantS).im < -|(z - plantS).re| → 1 < dist z plantPt) := by
  obtain ⟨-, -, hNre, hNim, hSre, hSim⟩ := stuckModel_plant_coords
  have hsq := stuckModel_dist_vertex_sq z
  have eN : (z.re - 2 / 5) ^ 2 + (z.im - 3 / 10) ^ 2 = (z - plantN).re ^ 2 + (1 + (z - plantN).im) ^ 2 := by
    rw [Complex.sub_re, Complex.sub_im, hNre, hNim]; ring
  have eS : (z.re - 2 / 5) ^ 2 + (z.im - 3 / 10) ^ 2 = (z - plantS).re ^ 2 + (-1 + (z - plantS).im) ^ 2 := by
    rw [Complex.sub_re, Complex.sub_im, hSre, hSim]; ring
  refine ⟨fun hz hw => ?_, fun hz hw => ?_, fun hz hw => ?_, fun hz hw => ?_⟩
  · obtain ⟨hb1, -⟩ := abs_lt.mp hz.2
    obtain ⟨ha1, ha2⟩ := abs_lt.mp (lt_neg.mp hw)
    refine (sq_lt_one_iff₀ dist_nonneg).mp ?_
    rw [hsq, eN]
    nlinarith [mul_nonneg (by linarith : (0 : ℝ) ≤ -(z - plantN).im - (z - plantN).re)
      (by linarith : (0 : ℝ) ≤ (z - plantN).re - (z - plantN).im)]
  · obtain ⟨ha1, ha2⟩ := abs_lt.mp hw
    refine (one_lt_sq_iff₀ dist_nonneg).mp ?_
    rw [hsq, eN]
    nlinarith [sq_nonneg (z - plantN).re, sq_nonneg (z - plantN).im]
  · obtain ⟨-, hb2⟩ := abs_lt.mp hz.2
    obtain ⟨ha1, ha2⟩ := abs_lt.mp hw
    refine (sq_lt_one_iff₀ dist_nonneg).mp ?_
    rw [hsq, eS]
    nlinarith [mul_nonneg (by linarith : (0 : ℝ) ≤ (z - plantS).im - (z - plantS).re)
      (by linarith : (0 : ℝ) ≤ (z - plantS).im + (z - plantS).re)]
  · obtain ⟨ha1, ha2⟩ := abs_lt.mp (lt_neg.mp hw)
    refine (one_lt_sq_iff₀ dist_nonneg).mp ?_
    rw [hsq, eS]
    nlinarith [sq_nonneg (z - plantS).re, sq_nonneg (z - plantS).im]

/-- A tile of a painted colour with a pole in its closure lies in that pole's square (the three pieces of the painted set are
separated open sets). -/
theorem stuckModel_tile_subset_sq {j : Fin 12} (hj : 7 ≤ (j : ℕ)) {T : Set ℂ} (hT : stuckModel.TileOf j T) :
    (plantN ∈ closure T → T ⊆ poleSq plantN) ∧ (plantS ∈ closure T → T ⊆ poleSq plantS) := by
  have hTW : T ⊆ stuckW := fun z hz => (stuckModel_region_subset hj (hT.subset_region hz)).1
  have hself : ∀ p : ℂ, p ∈ poleSq p := fun p =>
    stuckModel_mem_poleSq.mpr ⟨by rw [sub_self, abs_zero]; norm_num, by rw [sub_self, abs_zero]; norm_num⟩
  refine ⟨fun h => ?_, fun h => ?_⟩
  · obtain ⟨x, hxN, hxT⟩ := mem_closure_iff.mp h (poleSq plantN) (stuckModel_isOpen_poleSq _) (hself _)
    refine IsPreconnected.subset_left_of_subset_union (v := ball plantPt (1 / 10) ∪ poleSq plantS)
      (stuckModel_isOpen_poleSq plantN) (isOpen_ball.union (stuckModel_isOpen_poleSq plantS)) ?_ ?_ ⟨x, hxT, hxN⟩
      hT.1.isPreconnected
    · rw [disjoint_left]
      rintro z hzN (hzb | hzS)
      · exact stuckModel_sq_disjoint.1 hzN (mem_ball.mp hzb)
      · exact (stuckModel_sq_disjoint.2 hzS).2 hzN
    · intro z hz
      rcases hTW hz with (hz | hz) | hz
      exacts [Or.inr (Or.inl hz), Or.inl hz, Or.inr (Or.inr hz)]
  · obtain ⟨x, hxS, hxT⟩ := mem_closure_iff.mp h (poleSq plantS) (stuckModel_isOpen_poleSq _) (hself _)
    refine IsPreconnected.subset_left_of_subset_union (v := ball plantPt (1 / 10) ∪ poleSq plantN)
      (stuckModel_isOpen_poleSq plantS) (isOpen_ball.union (stuckModel_isOpen_poleSq plantN)) ?_ ?_ ⟨x, hxT, hxS⟩
      hT.1.isPreconnected
    · rw [disjoint_left]
      rintro z hzS (hzb | hzN)
      · exact (stuckModel_sq_disjoint.2 hzS).1 (mem_ball.mp hzb)
      · exact (stuckModel_sq_disjoint.2 hzS).2 hzN
    · intro z hz
      rcases hTW hz with (hz | hz) | hz
      exacts [Or.inr (Or.inl hz), Or.inr (Or.inr hz), Or.inl hz]

/-- Only the horn colour `9` has two sectors at the vertex. -/
theorem stuckModel_hasSectors_two {c : Fin 12} {n : ℕ} (hn : stuckModel.HasSectors plantPt c n) (h2 : 2 ≤ n) : c = 9 := by
  obtain ⟨r, hrn, hr⟩ := (hn.and (Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num))).exists
  rw [stuckModel_sectorsOf_encard hr.1 hr.2] at hrn
  have hlt : 1 < {i : Fin 4 | ![9, 9, 7, 8] i = c}.encard := by rw [hrn]; exact_mod_cast h2
  obtain ⟨i₁, i₂, h1, h2', hne⟩ := Set.one_lt_encard_iff.mp hlt
  have key : ∀ i₁ i₂ : Fin 4, i₁ ≠ i₂ → (![9, 9, 7, 8] i₁ : Fin 12) = ![9, 9, 7, 8] i₂ → (![9, 9, 7, 8] i₁ : Fin 12) = 9 := by
    decide
  exact (show (![9, 9, 7, 8] i₁ : Fin 12) = c from h1).symm.trans
    (key i₁ i₂ hne ((show (![9, 9, 7, 8] i₁ : Fin 12) = c from h1).trans (show (![9, 9, 7, 8] i₂ : Fin 12) = c from h2').symm))

/-- The parts of the unit discs about the poles are no horn sets: each approaches the vertex along an open interval of directions. -/
theorem stuckModel_lens_ne_hornSet {r : ℝ} (hr0 : 0 < r) (α κ₁ κ₂ : ℝ) :
    stuckModelPiece r 2 ≠ hornSet plantPt α κ₁ κ₂ r ∧ stuckModelPiece r 3 ≠ hornSet plantPt α κ₁ κ₂ r := by
  have hπ := Real.pi_pos
  have key : ∀ σ : ℝ, (σ = 1 ∨ σ = -1) → ∀ β ∈ Ioo (σ * (π / 2) - 1 / 2) (σ * (π / 2) + 1 / 2), ∀ t : ℝ, 0 < t → t < 1 →
      ‖(t : ℂ) * e β - (σ : ℂ) * I‖ < 1 := by
    intro σ hσ β hβ t ht0 ht1
    have e1 : σ * Real.sin β = Real.cos (β - σ * (π / 2)) := by
      rcases hσ with rfl | rfl
      · rw [one_mul, one_mul, Real.cos_sub_pi_div_two]
      · rw [neg_one_mul, neg_one_mul, sub_neg_eq_add, Real.cos_add_pi_div_two]
    have hγ : |β - σ * (π / 2)| < 1 / 2 := by rw [abs_lt]; constructor <;> linarith [hβ.1, hβ.2]
    have hcos := Real.one_sub_sq_div_two_le_cos (x := β - σ * (π / 2))
    have hsin : 7 / 8 ≤ σ * Real.sin β := by rw [e1]; nlinarith [abs_lt.mp hγ]
    have hσ2 : σ ^ 2 = 1 := by rcases hσ with rfl | rfl <;> norm_num
    have hw : (t : ℂ) * e β - (σ : ℂ) * I = ⟨t * Real.cos β, t * Real.sin β - σ⟩ := by
      rw [e_eq]; apply Complex.ext <;> simp [Complex.cos_ofReal_re, Complex.sin_ofReal_re]
    have hsq : ‖(t : ℂ) * e β - (σ : ℂ) * I‖ ^ 2 = t ^ 2 - 2 * t * (σ * Real.sin β) + σ ^ 2 := by
      rw [hw, ← Complex.normSq_eq_norm_sq, Complex.normSq_apply]
      linear_combination t ^ 2 * Real.sin_sq_add_cos_sq β
    refine (sq_lt_one_iff₀ (norm_nonneg _)).mp ?_
    rw [hsq, hσ2]; nlinarith
  have hcone : ∀ σ : ℝ, (σ = 1 ∨ σ = -1) → ∀ S : Set ℂ,
      (∀ z, dist z plantPt < r → ‖z - plantPt - (σ : ℂ) * I‖ < 1 → z ∈ S) → (interior (coneAt S plantPt)).Nonempty := by
    intro σ hσ S hS
    refine ⟨σ * (π / 2), interior_maximal (t := Ioo (σ * (π / 2) - 1 / 2) (σ * (π / 2) + 1 / 2)) (fun β hβ => ?_) isOpen_Ioo
      ⟨by linarith, by linarith⟩⟩
    intro ε hε
    set t := min (min (ε / 2) (r / 2)) (1 / 2) with ht
    have ht0 : 0 < t := lt_min (lt_min (by linarith) (by linarith)) (by norm_num)
    have htε : t < ε := lt_of_le_of_lt ((min_le_left _ _).trans (min_le_left _ _)) (by linarith)
    have htr : t < r := lt_of_le_of_lt ((min_le_left _ _).trans (min_le_right _ _)) (by linarith)
    have ht1 : t < 1 := lt_of_le_of_lt (min_le_right _ _) (by norm_num)
    have htc : (t : ℂ) ≠ 0 := by exact_mod_cast ht0.ne'
    have hn : ‖(t : ℂ) * e β‖ = t := by
      rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]
    have hz : plantPt + (t : ℂ) * e β - plantPt = (t : ℂ) * e β := add_sub_cancel_left _ _
    refine ⟨plantPt + (t : ℂ) * e β, hS _ (by rw [dist_eq_norm, hz, hn]; exact htr)
      (by rw [hz]; exact key σ hσ β hβ t ht0 ht1), ?_, by rw [dist_eq_norm, hz, hn]; exact htε, ?_⟩
    · intro h
      have h' : ‖plantPt + (t : ℂ) * e β - plantPt‖ = 0 := by rw [h, sub_self, norm_zero]
      rw [hz, hn] at h'; linarith
    · rw [hz, hn, mul_div_cancel_left₀ _ htc, sub_self, norm_zero]; exact hε
  refine ⟨(ne_hornSet_of_interior_coneAt (hcone 1 (Or.inl rfl) _ fun z h1 h2 => ?_) α κ₁ κ₂ r),
    (ne_hornSet_of_interior_coneAt (hcone (-1) (Or.inr rfl) _ fun z h1 h2 => ?_) α κ₁ κ₂ r)⟩
  · rw [Complex.ofReal_one, one_mul, (stuckModel_norms z).2.1] at h2
    exact stuckModel_piece_cases.2.2.1.mpr ⟨h1, h2⟩
  · rw [Complex.ofReal_neg, Complex.ofReal_one, neg_one_mul, sub_neg_eq_add, (stuckModel_norms z).2.2] at h2
    exact stuckModel_piece_cases.2.2.2.mpr ⟨h1, h2⟩

/-- **A horn at the vertex is one of the two**: a horn set that is a sector at the vertex lies along `e 0` or `e π`, with the bounding
curvatures `−1` and `1`. -/
theorem stuckModel_horn_cases {α κ₁ κ₂ r : ℝ} (hlt : κ₁ < κ₂) (hr0 : 0 < r) (hr : r ≤ 1 / 10)
    (hS : stuckModel.IsSector plantPt r (hornSet plantPt α κ₁ κ₂ r)) : (e α = e 0 ∨ e α = e π) ∧ κ₁ = -1 ∧ κ₂ = 1 := by
  obtain ⟨ho, hp, hd, hn, hc⟩ := stuckModelPiece_data hr0 hr
  obtain ⟨i, hi⟩ := (isSector_iff_of_partition (stuckModel_partition hr) ho hp hd hn hc).mp hS
  obtain ⟨h0, h1⟩ := stuckModel_piece_hornSet r
  have hα := mem_coneAt_hornSet plantPt α hlt hr0
  have fin : ∀ β : ℝ, hornSet plantPt α κ₁ κ₂ r = hornSet plantPt β (-1) 1 r → e α = e β ∧ κ₁ = -1 ∧ κ₂ = 1 := by
    intro β hβ
    have he : e α = e β := by rw [hβ] at hα; exact e_eq_of_mem_coneAt_hornSet hα
    rw [hornSet_congr he] at hβ
    exact ⟨he, hornSet_curv_eq hlt (by norm_num) hr0 hβ⟩
  fin_cases i
  · obtain ⟨a, b⟩ := fin 0 (hi.trans h0); exact ⟨Or.inl a, b⟩
  · obtain ⟨a, b⟩ := fin π (hi.trans h1); exact ⟨Or.inr a, b⟩
  · exact absurd hi.symm (stuckModel_lens_ne_hornSet hr0 α κ₁ κ₂).1
  · exact absurd hi.symm (stuckModel_lens_ne_hornSet hr0 α κ₁ κ₂).2

/-- The point at distance `1` from `z` toward `p`, for `z` outside the unit disc about `p`. -/
theorem stuckModel_radial {z p : ℂ} (h1 : 1 < dist z p) :
    dist z (z + ((1 / dist z p : ℝ) : ℂ) * (p - z)) = 1 ∧
      z + ((1 / dist z p : ℝ) : ℂ) * (p - z) - p = ((1 - 1 / dist z p : ℝ) : ℂ) * (z - p) := by
  have hd0 : 0 < dist z p := by linarith
  refine ⟨?_, by push_cast; ring⟩
  rw [dist_eq_norm, sub_add_cancel_left, norm_neg, norm_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_pos (by positivity), ← dist_eq_norm, dist_comm p z]
  field_simp

/-- For `z` within `1/20` of the vertex and outside the unit disc about a pole `p`, the point at distance `1` from `z` toward `p` lies
in the pole's square, on the ray from `p` through `z`. -/
theorem stuckModel_radial_sq {z p : ℂ} (hz : dist z plantPt < 1 / 20) (hp : dist plantPt p = 1) (h1 : 1 < dist z p) :
    ∃ y : ℂ, ∃ f : ℝ, 0 < f ∧ dist z y = 1 ∧ y - p = (f : ℂ) * (z - p) ∧ y ∈ poleSq p := by
  have hd0 : 0 < dist z p := by linarith
  have hdz : dist z p < 1 + 1 / 20 := by have := dist_triangle z plantPt p; linarith
  obtain ⟨hy1, hy2⟩ := stuckModel_radial h1
  have hf0 : 0 < 1 - 1 / dist z p := by rw [sub_pos, div_lt_one hd0]; exact h1
  have hn : ‖z + ((1 / dist z p : ℝ) : ℂ) * (p - z) - p‖ < 1 / 20 := by
    rw [hy2, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hf0, ← dist_eq_norm]
    have : (1 - 1 / dist z p) * dist z p = dist z p - 1 := by field_simp
    linarith
  exact ⟨_, _, hf0, hy1, hy2, ⟨(Complex.abs_re_le_norm _).trans_lt hn, (Complex.abs_im_le_norm _).trans_lt hn⟩⟩

/-- **Every point within `1/20` of the vertex outside the unit disc about a pole is in the shadow of that pole's flank colour**
(FS131-E7 § 7.3, with the point toward the pole in place of the point on the pole's axis). -/
theorem stuckModel_shadow {z : ℂ} (hz : dist z plantPt < 1 / 20) :
    (1 < dist z plantN → ∃ y ∈ stuckModel.region 7, dist z y = 1) ∧
    (1 < dist z plantS → ∃ y ∈ stuckModel.region 8, dist z y = 1) := by
  obtain ⟨hvre, hvim, hNre, hNim, hSre, hSim⟩ := stuckModel_plant_coords
  obtain ⟨hX, hY⟩ : |z.re - 2 / 5| < 1 / 20 ∧ |z.im - 3 / 10| < 1 / 20 := by
    have := stuckModel_abs_coords_le z plantPt
    rw [hvre, hvim] at this
    exact ⟨this.1.trans_lt hz, this.2.trans_lt hz⟩
  obtain ⟨hX1, hX2⟩ := abs_lt.mp hX
  obtain ⟨hY1, hY2⟩ := abs_lt.mp hY
  have hXa : |z.re - 2 / 5| < 1 / 20 := hX
  have hvN : dist plantPt plantN = 1 := by rw [plantN, dist_eq_norm, sub_add_cancel_left, norm_neg, Complex.norm_I]
  have hvS : dist plantPt plantS = 1 := by rw [plantS, dist_eq_norm, sub_sub_cancel, Complex.norm_I]
  refine ⟨fun h1 => ?_, fun h1 => ?_⟩
  · obtain ⟨y, f, hf, hy1, hy2, hyS⟩ := stuckModel_radial_sq hz hvN h1
    refine ⟨y, stuckModel_wedges.1 hyS ?_, hy1⟩
    rw [hy2, Complex.re_ofReal_mul, Complex.im_ofReal_mul, Complex.sub_re, Complex.sub_im, hNre, hNim, abs_mul, abs_of_pos hf]
    nlinarith [mul_pos hf (by linarith : (0 : ℝ) < 1 - (z.im - 3 / 10) - |z.re - 2 / 5|)]
  · obtain ⟨y, f, hf, hy1, hy2, hyS⟩ := stuckModel_radial_sq hz hvS h1
    refine ⟨y, stuckModel_wedges.2.2.1 hyS ?_, hy1⟩
    rw [hy2, Complex.re_ofReal_mul, Complex.im_ofReal_mul, Complex.sub_re, Complex.sub_im, hSre, hSim, abs_mul, abs_of_pos hf]
    nlinarith [mul_pos hf (by linarith : (0 : ℝ) < 1 + (z.im - 3 / 10) - |z.re - 2 / 5|)]

end StuckModelHelpers

/-- `stuckModel` is valid (FS131-E7 § 7.2, with squares at the poles). -/
theorem stuckModel_valid : stuckModel.Valid := by
  unfold stuckModel
  refine ArcMap.paint_valid (brickBase_valid 12 _) ?_ ?_
  · intro x hx y hy _ _ hxy
    exact stuckModel_no_unit_pair hx hy hxy
  · intro x _ _ y hy
    rw [brickBase_region_spare _ (stuckModel_stuckCol_spare x)] at hy
    exact absurd hy (notMem_empty y)

/-- The colours at the vertex are `7`, `8`, `9`. -/
theorem stuckModel_coloursAt : stuckModel.coloursAt plantPt = {7, 8, 9} := by
  have h10 : (0 : ℝ) < 1 / 10 := by norm_num
  obtain ⟨-, -, -, -, hc⟩ := stuckModelPiece_data h10 le_rfl
  have hU := stuckModel_partition (r := 1 / 10) le_rfl
  have hreg := stuckModel_piece_subset_region (r := 1 / 10) le_rfl
  ext j
  simp only [mem_insert_iff, mem_singleton_iff]
  constructor
  · intro hj
    obtain ⟨z, ⟨hzI, hzc⟩, hz⟩ := Metric.mem_closure_iff.mp hj (1 / 10) h10
    have hzU : z ∈ stuckModel.interiorPts ∩ ball plantPt (1 / 10) := ⟨hzI, by rw [mem_ball, dist_comm]; exact hz⟩
    rw [hU, mem_iUnion] at hzU
    obtain ⟨i, hi⟩ := hzU
    have hcol : stuckModel.col z = ![9, 9, 7, 8] i := stuckModel_piece_col le_rfl i hi
    have hzc' : stuckModel.col z = j := hzc
    rw [← hzc', hcol]
    fin_cases i <;> simp
  · rintro (rfl | rfl | rfl)
    · show plantPt ∈ closure (stuckModel.region 7)
      exact closure_mono (hreg 2) (hc 2)
    · show plantPt ∈ closure (stuckModel.region 8)
      exact closure_mono (hreg 3) (hc 3)
    · show plantPt ∈ closure (stuckModel.region 9)
      exact closure_mono (hreg 0) (hc 0)

/-- The horn colour `9` has two sectors at the vertex, each flank colour one. -/
theorem stuckModel_hasSectors : stuckModel.HasSectors plantPt 9 2 ∧ stuckModel.HasSectors plantPt 7 1 ∧
    stuckModel.HasSectors plantPt 8 1 := by
  have h10 : (0 : ℝ) < 1 / 10 := by norm_num
  refine ⟨?_, ?_, ?_⟩
  · filter_upwards [Ioc_mem_nhdsGT h10] with r hr
    rw [stuckModel_sectorsOf_encard hr.1 hr.2]
    have : {i : Fin 4 | ![9, 9, 7, 8] i = (9 : Fin 12)} = {0, 1} := by
      ext i; fin_cases i <;> simp
    rw [this, encard_pair (by decide)]; rfl
  · filter_upwards [Ioc_mem_nhdsGT h10] with r hr
    rw [stuckModel_sectorsOf_encard hr.1 hr.2]
    have : {i : Fin 4 | ![9, 9, 7, 8] i = (7 : Fin 12)} = {2} := by
      ext i; fin_cases i <;> simp
    rw [this, encard_singleton, Nat.cast_one]
  · filter_upwards [Ioc_mem_nhdsGT h10] with r hr
    rw [stuckModel_sectorsOf_encard hr.1 hr.2]
    have : {i : Fin 4 | ![9, 9, 7, 8] i = (8 : Fin 12)} = {3} := by
      ext i; fin_cases i <;> simp
    rw [this, encard_singleton, Nat.cast_one]

/-- The two horns of colour `9`, along `e 0` and `e π`, each between the unit arcs of `ω(S′)` and `ω(N)`. -/
theorem stuckModel_isHorn : stuckModel.IsHorn plantPt 0 (-1) 1 9 ∧ stuckModel.IsHorn plantPt π (-1) 1 9 := by
  have h10 : (0 : ℝ) < 1 / 10 := by norm_num
  refine ⟨⟨by norm_num, ?_⟩, ⟨by norm_num, ?_⟩⟩
  · filter_upwards [Ioc_mem_nhdsGT h10] with r hr
    obtain ⟨ho, hp, hd, hn, hc⟩ := stuckModelPiece_data hr.1 hr.2
    rw [← (stuckModel_piece_hornSet r).1]
    exact ⟨(ArcMap.isSector_iff_of_partition (stuckModel_partition hr.2) ho hp hd hn hc).mpr ⟨0, rfl⟩,
      stuckModel_piece_col hr.2 0⟩
  · filter_upwards [Ioc_mem_nhdsGT h10] with r hr
    obtain ⟨ho, hp, hd, hn, hc⟩ := stuckModelPiece_data hr.1 hr.2
    rw [← (stuckModel_piece_hornSet r).2]
    exact ⟨(ArcMap.isSector_iff_of_partition (stuckModel_partition hr.2) ho hp hd hn hc).mpr ⟨1, rfl⟩,
      stuckModel_piece_col hr.2 1⟩

/-- The flanks: along `e 0`, `7` above and `8` below; along `e π` (whose normal is `−i`), `8` above and `7` below. -/
theorem stuckModel_flanks : (stuckModel.IsFlankAbove plantPt 0 1 7 ∧ stuckModel.IsFlankBelow plantPt 0 (-1) 8) ∧
    (stuckModel.IsFlankAbove plantPt π 1 8 ∧ stuckModel.IsFlankBelow plantPt π (-1) 7) := by
  have h10 : (0 : ℝ) < 1 / 10 := by norm_num
  obtain ⟨hN0, hNπ, hS0, hSπ⟩ := stuckModel_poles
  refine ⟨⟨⟨2, by norm_num, ?_⟩, ⟨-2, by norm_num, ?_⟩⟩, ⟨⟨2, by norm_num, ?_⟩, ⟨-2, by norm_num, ?_⟩⟩⟩
  · filter_upwards [Ioc_mem_nhdsGT h10] with r hr
    rintro z ⟨h1, -, h3, -⟩
    rw [tanAbove_one_iff, hN0] at h3
    exact stuckModel_piece_subset_region hr.2 2 (stuckModel_piece_cases.2.2.1.mpr ⟨h1, h3⟩)
  · filter_upwards [Ioc_mem_nhdsGT h10] with r hr
    rintro z ⟨h1, -, -, h4⟩
    rw [tanBelow_neg_one_iff, hS0] at h4
    exact stuckModel_piece_subset_region hr.2 3 (stuckModel_piece_cases.2.2.2.mpr ⟨h1, h4⟩)
  · filter_upwards [Ioc_mem_nhdsGT h10] with r hr
    rintro z ⟨h1, -, h3, -⟩
    rw [tanAbove_one_iff, hSπ] at h3
    exact stuckModel_piece_subset_region hr.2 3 (stuckModel_piece_cases.2.2.2.mpr ⟨h1, h3⟩)
  · filter_upwards [Ioc_mem_nhdsGT h10] with r hr
    rintro z ⟨h1, -, -, h4⟩
    rw [tanBelow_neg_one_iff, hNπ] at h4
    exact stuckModel_piece_subset_region hr.2 2 (stuckModel_piece_cases.2.2.1.mpr ⟨h1, h4⟩)

/-- The contacts at the poles: the flank colours in-type (`7` at `N`, `8` at `S′`), the horn colour out-type at both. -/
theorem stuckModel_contacts :
    (stuckModel.IsContact plantPt 7 plantN ∧ stuckModel.InType plantPt 7 plantN) ∧
    (stuckModel.IsContact plantPt 8 plantS ∧ stuckModel.InType plantPt 8 plantS) ∧
    (stuckModel.IsContact plantPt 9 plantN ∧ stuckModel.OutType plantPt 9 plantN) ∧
    (stuckModel.IsContact plantPt 9 plantS ∧ stuckModel.OutType plantPt 9 plantS) := by
  have h7 : (7 : Fin 12) ∈ stuckModel.coloursAt plantPt := by rw [stuckModel_coloursAt]; simp
  have h8 : (8 : Fin 12) ∈ stuckModel.coloursAt plantPt := by rw [stuckModel_coloursAt]; simp
  have h9 : (9 : Fin 12) ∈ stuckModel.coloursAt plantPt := by rw [stuckModel_coloursAt]; simp
  have hdN : dist plantN plantPt = 1 := by rw [plantN, dist_eq_norm, add_sub_cancel_left, Complex.norm_I]
  have hdS : dist plantS plantPt = 1 := by rw [plantS, dist_eq_norm, sub_sub_cancel_left, norm_neg, Complex.norm_I]
  have h20 : (0 : ℝ) < 1 / 20 := by norm_num
  have hin : ∀ z : ℂ, z ∈ stuckW → dist z plantPt < 1 ∨ z ∈ poleSq plantN ∨ z ∈ poleSq plantS := by
    rintro z ((hz | hz) | hz)
    · exact Or.inl (lt_trans (mem_ball.mp hz) (by norm_num))
    · exact Or.inr (Or.inl hz)
    · exact Or.inr (Or.inr hz)
  refine ⟨⟨⟨h7, hdN, ?_⟩, ?_⟩, ⟨⟨h8, hdS, ?_⟩, ?_⟩, ⟨⟨h9, hdN, ?_⟩, ?_⟩, ⟨⟨h9, hdS, ?_⟩, ?_⟩⟩
  · exact ArcMap.mem_closure_of_ray h20 fun t ht0 ht =>
      stuckModel_wedges.1 (stuckModel_pole_rays plantN ht0 ht).1.1 (stuckModel_pole_rays plantN ht0 ht).1.2
  · intro T hT _ z hz
    obtain ⟨hzW, -, hzc⟩ := stuckModel_region_subset (j := 7) (by decide) (hT.subset_region hz)
    rw [mem_ball]
    rcases hin z hzW with h | h | h
    · exact h
    · exact stuckModel_wedge_dist.1 h ((stuckModel_stuckCol_sqN h).1.mp hzc)
    · exact absurd hzc (stuckModel_stuckCol_sqS h).2.2
  · exact ArcMap.mem_closure_of_ray h20 fun t ht0 ht =>
      stuckModel_wedges.2.2.1 (stuckModel_pole_rays plantS ht0 ht).2.1 (stuckModel_pole_rays plantS ht0 ht).2.2
  · intro T hT _ z hz
    obtain ⟨hzW, -, hzc⟩ := stuckModel_region_subset (j := 8) (by decide) (hT.subset_region hz)
    rw [mem_ball]
    rcases hin z hzW with h | h | h
    · exact h
    · exact absurd hzc (stuckModel_stuckCol_sqN h).2.2
    · exact stuckModel_wedge_dist.2.2.1 h ((stuckModel_stuckCol_sqS h).1.mp hzc)
  · exact ArcMap.mem_closure_of_ray h20 fun t ht0 ht =>
      stuckModel_wedges.2.1 (stuckModel_pole_rays plantN ht0 ht).2.1 (stuckModel_pole_rays plantN ht0 ht).2.2
  · intro T hT hNT
    have hsub := (stuckModel_tile_subset_sq (j := 9) (by decide) hT).1 hNT
    rw [disjoint_left]
    intro z hz hzB
    obtain ⟨-, -, hzc⟩ := stuckModel_region_subset (j := 9) (by decide) (hT.subset_region hz)
    have := stuckModel_wedge_dist.2.1 (hsub hz) ((stuckModel_stuckCol_sqN (hsub hz)).2.1.mp hzc)
    rw [mem_closedBall] at hzB; linarith
  · exact ArcMap.mem_closure_of_ray h20 fun t ht0 ht =>
      stuckModel_wedges.2.2.2 (stuckModel_pole_rays plantS ht0 ht).1.1 (stuckModel_pole_rays plantS ht0 ht).1.2
  · intro T hT hST
    have hsub := (stuckModel_tile_subset_sq (j := 9) (by decide) hT).2 hST
    rw [disjoint_left]
    intro z hz hzB
    obtain ⟨-, -, hzc⟩ := stuckModel_region_subset (j := 9) (by decide) (hT.subset_region hz)
    have := stuckModel_wedge_dist.2.2.2 (hsub hz) ((stuckModel_stuckCol_sqS (hsub hz)).2.1.mp hzc)
    rw [mem_closedBall] at hzB; linarith

/-- No MERGE at the vertex: only `9` is repeated, and its allowed cone lies in the line across the two poles' directions. -/
theorem stuckModel_not_mergeAvailable : ¬ stuckModel.MergeAvailable plantPt := by
  rintro ⟨c, n, hn2, hn, d, hd⟩
  obtain rfl := stuckModel_hasSectors_two hn hn2
  obtain ⟨-, -, ⟨hcN, hoN⟩, ⟨hcS, hoS⟩⟩ := stuckModel_contacts
  have hsub : stuckModel.allowedCone plantPt 9 ⊆ {z : ℂ | 0 * z.re + 1 * z.im = 0} := by
    intro w hw
    have a := (hw plantN hcN).2 hoN
    have b := (hw plantS hcS).2 hoS
    have eN : plantN - plantPt = I := by rw [plantN, add_sub_cancel_left]
    have eS : plantS - plantPt = -I := by rw [plantS, sub_sub_cancel_left]
    rw [eN] at a; rw [eS] at b
    simp only [dot, map_neg, Complex.conj_I, neg_neg, Complex.mul_re, Complex.neg_re, Complex.neg_im, Complex.I_re,
      Complex.I_im] at a b
    simp only [mem_setOf_eq]
    linarith
  have := interior_mono hsub hd
  rw [ArcMap.interior_line_eq_empty (Or.inr one_ne_zero)] at this
  exact this

/-- No MERGE-RAY at the vertex: its two horns lie along different rays. -/
theorem stuckModel_not_rayAvailable : ¬ stuckModel.RayAvailable plantPt := by
  rintro ⟨c, α, κ₁, κ₂, κ₃, κ₄, h23, ⟨h12, h1⟩, ⟨h34, h2⟩⟩
  obtain ⟨r, ⟨⟨hs1, -⟩, ⟨hs2, -⟩⟩, hr⟩ :=
    ((h1.and h2).and (Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num))).exists
  obtain ⟨-, -, hk2⟩ := stuckModel_horn_cases h12 hr.1 hr.2 hs1
  obtain ⟨-, hk3, -⟩ := stuckModel_horn_cases h34 hr.1 hr.2 hs2
  linarith

/-- No SHAVE at the vertex: every point of either horn is in the shadow of both flank colours (the wedges toward the vertex at the two
poles). -/
theorem stuckModel_not_shaveAvailable : ¬ stuckModel.ShaveAvailable plantPt := by
  rintro ⟨c, g, h, α, κ₁, κ₂, σ, ⟨h12, hH⟩, ⟨κ', hκ', hfa⟩, ⟨κ'', hκ'', hfb⟩, -, -, hsh⟩
  obtain ⟨r, ⟨⟨⟨⟨hs, -⟩, hfa'⟩, hfb'⟩, hsh'⟩, hr⟩ :=
    ((((hH.and hfa).and hfb).and hsh).and (Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 20 by norm_num))).exists
  have hr10 : r ≤ 1 / 10 := by linarith [hr.2]
  obtain ⟨hdir, rfl, rfl⟩ := stuckModel_horn_cases h12 hr.1 hr10 hs
  obtain ⟨hN0, hNπ, hS0, hSπ⟩ := stuckModel_poles
  -- the poles of the horn's frame are the two poles, in one order or the other
  have hpoles : (plantPt + e (α + π / 2) = plantN ∧ plantPt - e (α + π / 2) = plantS) ∨
      (plantPt + e (α + π / 2) = plantS ∧ plantPt - e (α + π / 2) = plantN) := by
    rcases hdir with he | he
    · left; rw [e_add, he, ← e_add]; exact ⟨hN0, hS0⟩
    · right; rw [e_add, he, ← e_add]; exact ⟨hSπ, hNπ⟩
  -- a point near the vertex inside the unit disc about a pole has the colour `7` or `8`
  have hflank : ∀ z : ℂ, dist z plantPt < r → dist z plantN < 1 ∨ dist z plantS < 1 → ∀ j : Fin 12,
      z ∈ stuckModel.region j → j = 7 ∨ j = 8 := by
    intro z hzr hd j hj
    rcases hd with hd | hd
    · have := stuckModel_piece_subset_region hr10 2 (stuckModel_piece_cases.2.2.1.mpr ⟨hzr, hd⟩)
      exact Or.inl ((show stuckModel.col z = j from hj.2).symm.trans (show stuckModel.col z = 7 from this.2))
    · have := stuckModel_piece_subset_region hr10 3 (stuckModel_piece_cases.2.2.2.mpr ⟨hzr, hd⟩)
      exact Or.inr ((show stuckModel.col z = j from hj.2).symm.trans (show stuckModel.col z = 8 from this.2))
  obtain ⟨z₁, hz₁, -, -⟩ := exists_mem_hornSet_aboveBelow plantPt α (κ₁ := 1) (κ₂ := κ') (s := (1 + κ') / 2) (m := κ')
    hr.1 (by linarith) (by linarith) (by intro h; linarith)
  obtain ⟨z₂, hz₂, -, -⟩ := exists_mem_hornSet_aboveBelow plantPt α (κ₁ := κ'') (κ₂ := -1) (s := (κ'' + -1) / 2)
    (m := -1) hr.1 (by linarith) (by linarith) (by intro h; linarith)
  have hg : g = 7 ∨ g = 8 := by
    have h3 := hz₁.2.2.1
    rw [tanAbove_one_iff] at h3
    refine hflank z₁ hz₁.1 ?_ g (hfa' hz₁)
    rcases hpoles with ⟨hp, -⟩ | ⟨hp, -⟩
    · rw [hp] at h3; exact Or.inl h3
    · rw [hp] at h3; exact Or.inr h3
  have hh : h = 7 ∨ h = 8 := by
    have h4 := hz₂.2.2.2
    rw [tanBelow_neg_one_iff] at h4
    refine hflank z₂ hz₂.1 ?_ h (hfb' hz₂)
    rcases hpoles with ⟨-, hp⟩ | ⟨-, hp⟩
    · rw [hp] at h4; exact Or.inr h4
    · rw [hp] at h4; exact Or.inl h4
  -- every point of the horn is outside both unit discs, hence in the shadow of both flank colours
  obtain ⟨z, hz⟩ := ArcMap.IsSector.nonempty hs
  have hzr : dist z plantPt < 1 / 20 := lt_of_lt_of_le hz.1 hr.2
  have hA := hz.2.2.1
  have hB := hz.2.2.2
  rw [tanAbove_neg_one_iff] at hA
  rw [tanBelow_one_iff] at hB
  have hout : 1 < dist z plantN ∧ 1 < dist z plantS := by
    rcases hpoles with ⟨hp1, hp2⟩ | ⟨hp1, hp2⟩
    · rw [hp2] at hA; rw [hp1] at hB; exact ⟨hB, hA⟩
    · rw [hp2] at hA; rw [hp1] at hB; exact ⟨hA, hB⟩
  have hnc : ∀ j : Fin 12, j = 7 ∨ j = 8 → ¬ stuckModel.IsClear j z := by
    rintro j (rfl | rfl) hc
    · obtain ⟨y, hy, hyd⟩ := (stuckModel_shadow hzr).1 hout.1; exact hc y hy hyd
    · obtain ⟨y, hy, hyd⟩ := (stuckModel_shadow hzr).2 hout.2; exact hc y hy hyd
  obtain ⟨hA', hB'⟩ := hsh' z hz
  by_cases hσ : TanAbove plantPt α σ z
  · exact hnc g hg (hA' hσ)
  · exact hnc h hh (hB' hσ)

/-- The vertex of `stuckModel` is stuck. -/
theorem stuckModel_isStuck : stuckModel.IsStuck plantPt :=
  ⟨stuckModel_not_mergeAvailable, stuckModel_not_rayAvailable, stuckModel_not_shaveAvailable, 9, 2, le_rfl, stuckModel_hasSectors.1⟩

/-- **The model of `Valid ∧ Covers v 1 ∧ IsStuck v`** — the hypotheses FLANK-Q, `FlankUA` and `Terminal`'s any-`k` stuck lemmas share —
on a map of the plane. -/
theorem stuckModel_hyps : stuckModel.Valid ∧ stuckModel.IsPlaneMap ∧ stuckModel.Covers plantPt 1 ∧ stuckModel.IsStuck plantPt :=
  ⟨stuckModel_valid, stuckModel_isPlaneMap, stuckModel_covers, stuckModel_isStuck⟩

/-- **`stuckModel` is terminal**: no move is available at any point of the plane (FS131-E7 § 7.4: the vertex is the only point with a
repeated colour or a horn). -/
theorem stuckModel_terminal : stuckModel.Terminal := by
  sorry

/-! ## A doubly shadowed band under Condition 5 -/

/-- The class of `7` in `shadowModel`: the flank above the band at the vertex, and a horn at the lower pole. -/
noncomputable def shadowWg : Set ℂ := hornSet plantPt 0 (1 / 2) (3 / 4) (1 / 10) ∪ hornSet plantS 0 (1 / 10) (1 / 5) (1 / 20)

/-- The class of `8` in `shadowModel`: the mirror images. -/
noncomputable def shadowWh : Set ℂ := hornSet plantPt 0 (-3 / 4) (-1 / 2) (1 / 10) ∪ hornSet plantN 0 (-1 / 5) (-1 / 10) (1 / 20)

/-- The new arcs of `shadowModel`: the boundaries of the four horn sets. -/
noncomputable def shadowArcs : Set Arc :=
  hornArcs plantPt 0 (1 / 2) (3 / 4) (1 / 10) ∪ hornArcs plantS 0 (1 / 10) (1 / 5) (1 / 20) ∪
    (hornArcs plantPt 0 (-3 / 4) (-1 / 2) (1 / 10) ∪ hornArcs plantN 0 (-1 / 5) (-1 / 10) (1 / 20))

/-- The painting of `shadowModel` (read on `shadowWg ∪ shadowWh` only). -/
noncomputable def shadowCol (z : ℂ) : Fin 9 := by
  classical
  exact if z ∈ shadowWg then 7 else 8

section ShadowHelpers

open ArcMap

/-! ### The boundary arcs of a horn as point conditions, and the four horn sets of `shadowModel` (FS131-MB2's helpers) -/

/-- **A point of a horn's three boundary arcs** lies within the horn's radius of its base point, and on one of the two tangent circles or
at the radius exactly. -/
theorem shadowModel_mem_hornArcs {v : ℂ} {α κ₁ κ₂ ρ : ℝ} (hρ : 0 ≤ ρ) (h1 : |κ₁| * ρ ≤ 2) (h2 : |κ₂| * ρ ≤ 2) {z : ℂ}
    (hz : z ∈ ⋃ a ∈ hornArcs v α κ₁ κ₂ ρ, a.carrier) :
    dist z v ≤ ρ ∧ (tanHeight κ₁ (frameX v α z) (frameY v α z) = 0 ∨ tanHeight κ₂ (frameX v α z) (frameY v α z) = 0 ∨
      dist z v = ρ) := by
  have hg : ∀ κ : ℝ, |κ| * ρ ≤ 2 → ∀ w ∈ (germArc v α κ ρ).carrier,
      dist w v ≤ ρ ∧ tanHeight κ (frameX v α w) (frameY v α w) = 0 := by
    intro κ hκ w hw
    rw [carrier_germArc v α hρ hκ] at hw
    obtain ⟨s, hs, rfl⟩ := hw
    refine ⟨by rw [dist_eq_norm, norm_branchPt_sub v α κ hs.1]; exact hs.2, ?_⟩
    rw [tanHeight_branchPt v α κ κ (le_trans (mul_le_mul_of_nonneg_left hs.2 (abs_nonneg κ)) hκ) hs.1]
    ring
  simp only [hornArcs, biUnion_insert, biUnion_singleton, mem_union] at hz
  rcases hz with hz | hz | hz
  · exact ⟨(hg κ₁ h1 z hz).1, Or.inl (hg κ₁ h1 z hz).2⟩
  · exact ⟨(hg κ₂ h2 z hz).1, Or.inr (Or.inl (hg κ₂ h2 z hz).2)⟩
  · obtain ⟨θ, -, rfl⟩ := hz
    have : dist (v + (ρ : ℂ) * e θ) v = ρ := by rw [dist_eq_norm, add_sub_cancel_left, norm_mul_e hρ]
    exact ⟨this.le, Or.inr (Or.inr this)⟩

/-- **A horn set misses another horn's boundary arcs** when the two horns share their base point and direction, the set's radius is at
most the arcs', and neither of the arcs' curvatures is strictly inside the set's window — or when the base points are further apart than
the two radii together. -/
theorem shadowModel_hornSet_not_mem_hornArcs {v w : ℂ} {κ₁ κ₂ σ₁ σ₂ r ρ : ℝ} (hρ : 0 ≤ ρ) (h1 : |σ₁| * ρ ≤ 2) (h2 : |σ₂| * ρ ≤ 2)
    (h : (v = w ∧ r ≤ ρ ∧ (σ₁ ≤ κ₁ ∨ κ₂ ≤ σ₁) ∧ (σ₂ ≤ κ₁ ∨ κ₂ ≤ σ₂)) ∨ r + ρ ≤ dist v w) {z : ℂ}
    (hz : z ∈ hornSet v 0 κ₁ κ₂ r) : z ∉ ⋃ a ∈ hornArcs w 0 σ₁ σ₂ ρ, a.carrier := by
  intro hza
  obtain ⟨hd, hcase⟩ := shadowModel_mem_hornArcs hρ h1 h2 hza
  obtain ⟨hzr, -, hA, hB⟩ := hz
  rcases h with ⟨rfl, hrρ, hs1, hs2⟩ | hfar
  · have key : ∀ σ : ℝ, (σ ≤ κ₁ ∨ κ₂ ≤ σ) → tanHeight σ (frameX v 0 z) (frameY v 0 z) ≠ 0 := by
      rintro σ (hσ | hσ) h0
      · have := tanHeight_anti hσ (frameX v 0 z) (frameY v 0 z)
        unfold TanAbove at hA; linarith
      · have := tanHeight_anti hσ (frameX v 0 z) (frameY v 0 z)
        unfold TanBelow at hB; linarith
    rcases hcase with h0 | h0 | h0
    · exact key σ₁ hs1 h0
    · exact key σ₂ hs2 h0
    · linarith
  · have := dist_triangle v z w
    rw [dist_comm v z] at this
    linarith

/-- The distances between the planted points. -/
theorem shadowModel_dists : dist plantPt plantN = 1 ∧ dist plantPt plantS = 1 ∧ dist plantN plantS = 2 ∧ dist plantN plantPt = 1 ∧
    dist plantS plantPt = 1 ∧ dist plantS plantN = 2 := by
  have h1 : dist plantPt plantN = 1 := by rw [dist_eq_norm, plantN, sub_add_cancel_left, norm_neg, Complex.norm_I]
  have h2 : dist plantPt plantS = 1 := by rw [dist_eq_norm, plantS, sub_sub_cancel, Complex.norm_I]
  have h3 : dist plantN plantS = 2 := by
    rw [dist_eq_norm, plantN, plantS, show plantPt + I - (plantPt - I) = 2 * I by ring, norm_mul, Complex.norm_I]; norm_num
  exact ⟨h1, h2, h3, by rw [dist_comm]; exact h1, by rw [dist_comm]; exact h2, by rw [dist_comm]; exact h3⟩

/-- **The painted set of `shadowModel` misses its new arcs**: each of the four horn sets is open, off its own boundary and off the other
three horns' boundaries. -/
theorem shadowModel_not_mem_arcs {z : ℂ} (hz : z ∈ shadowWg ∪ shadowWh) : z ∉ ⋃ a ∈ shadowArcs, a.carrier := by
  obtain ⟨d1, d2, d3, d4, d5, d6⟩ := shadowModel_dists
  unfold shadowArcs
  rw [biUnion_union, biUnion_union, biUnion_union]
  rintro ((ha | ha) | (ha | ha)) <;> rcases hz with (hz | hz) | (hz | hz) <;> revert ha <;>
    first
    | exact shadowModel_hornSet_not_mem_hornArcs (by norm_num) (by norm_num) (by norm_num)
        (Or.inl ⟨rfl, by norm_num, by norm_num, by norm_num⟩) hz
    | exact shadowModel_hornSet_not_mem_hornArcs (by norm_num) (by norm_num) (by norm_num)
        (Or.inr (by simp only [d1, d2, d3, d4, d5, d6]; norm_num)) hz

/-- The two painted colours' sets are disjoint. -/
theorem shadowModel_disjoint {z : ℂ} (hg : z ∈ shadowWg) (hh : z ∈ shadowWh) : False := by
  obtain ⟨d1, d2, d3, d4, d5, d6⟩ := shadowModel_dists
  have far : ∀ {v w : ℂ} {r ρ : ℝ}, dist z v < r → dist z w < ρ → r + ρ ≤ dist v w → False := fun {v w r ρ} h1 h2 h3 => by
    have := dist_triangle v z w
    rw [dist_comm v z] at this
    linarith
  rcases hg with hg | hg <;> rcases hh with hh | hh
  · exact tanBelow_tanAbove_false (by norm_num : (-1 / 2 : ℝ) ≤ 1 / 2) hh.2.2.2 hg.2.2.1
  · exact far hg.1 hh.1 (by rw [d1]; norm_num)
  · exact far hg.1 hh.1 (by rw [d5]; norm_num)
  · exact far hg.1 hh.1 (by rw [d6]; norm_num)

/-- The painted colours' sets are open. -/
theorem shadowModel_isOpen : IsOpen shadowWg ∧ IsOpen shadowWh :=
  ⟨(isOpen_hornSet _ _ _ _ _).union (isOpen_hornSet _ _ _ _ _), (isOpen_hornSet _ _ _ _ _).union (isOpen_hornSet _ _ _ _ _)⟩

/-- The painting on its two sets. -/
theorem shadowModel_shadowCol {z : ℂ} : (z ∈ shadowWg → shadowCol z = 7) ∧ (z ∈ shadowWh → shadowCol z = 8) := by
  classical
  refine ⟨fun h => ?_, fun h => ?_⟩
  · simp only [shadowCol, h, if_true]
  · have : z ∉ shadowWg := fun hg => shadowModel_disjoint hg h
    simp only [shadowCol, this, if_false]

end ShadowHelpers

theorem shadowArcs_nondegenerate : ∀ a ∈ shadowArcs, a.Nondegenerate := by
  rintro a ((ha | ha) | (ha | ha))
  · exact hornArcs_nondegenerate _ _ (by norm_num) (by norm_num) (by norm_num) (by norm_num) a ha
  · exact hornArcs_nondegenerate _ _ (by norm_num) (by norm_num) (by norm_num) (by norm_num) a ha
  · exact hornArcs_nondegenerate _ _ (by norm_num) (by norm_num) (by norm_num) (by norm_num) a ha
  · exact hornArcs_nondegenerate _ _ (by norm_num) (by norm_num) (by norm_num) (by norm_num) a ha

theorem shadowArcs_finite : shadowArcs.Finite :=
  ((hornArcs_finite _ _ _ _ _).union (hornArcs_finite _ _ _ _ _)).union
    ((hornArcs_finite _ _ _ _ _).union (hornArcs_finite _ _ _ _ _))

theorem frontier_shadowW_subset :
    frontier (shadowWg ∪ shadowWh) ⊆ ⋃ a ∈ (brickBase 9 (by norm_num)).arcs ∪ shadowArcs, a.carrier := by
  intro z hz
  have hz' : z ∈ ⋃ a ∈ shadowArcs, a.carrier := by
    unfold shadowArcs
    rw [biUnion_union, biUnion_union, biUnion_union]
    rcases frontier_union_subset _ _ hz with ⟨h, -⟩ | ⟨-, h⟩
    · rcases frontier_union_subset _ _ h with ⟨h', -⟩ | ⟨-, h'⟩
      · exact Or.inl (Or.inl (frontier_hornSet_subset _ _ (by norm_num) (by norm_num) (by norm_num) (by norm_num) h'))
      · exact Or.inl (Or.inr (frontier_hornSet_subset _ _ (by norm_num) (by norm_num) (by norm_num) (by norm_num) h'))
    · rcases frontier_union_subset _ _ h with ⟨h', -⟩ | ⟨-, h'⟩
      · exact Or.inr (Or.inl (frontier_hornSet_subset _ _ (by norm_num) (by norm_num) (by norm_num) (by norm_num) h'))
      · exact Or.inr (Or.inr (frontier_hornSet_subset _ _ (by norm_num) (by norm_num) (by norm_num) (by norm_num) h'))
  rw [biUnion_union]; exact Or.inr hz'

theorem shadowCol_locallyConstant : ∀ x ∈ shadowWg ∪ shadowWh,
    x ∉ ⋃ a ∈ (brickBase 9 (by norm_num)).arcs ∪ shadowArcs, a.carrier → ∀ᶠ y in 𝓝 x, shadowCol y = shadowCol x := by
  rintro x (hx | hx) -
  · filter_upwards [shadowModel_isOpen.1.mem_nhds hx] with y hy
    rw [shadowModel_shadowCol.1 hy, shadowModel_shadowCol.1 hx]
  · filter_upwards [shadowModel_isOpen.2.mem_nhds hx] with y hy
    rw [shadowModel_shadowCol.2 hy, shadowModel_shadowCol.2 hx]

/-- **The doubly shadowed band** (FS131-E7's `P₄`): the brick map in nine colours with `7` and `8` painted in three bricks. -/
noncomputable def shadowModel : ArcMap 9 :=
  (brickBase 9 (by norm_num)).paint (shadowWg ∪ shadowWh) shadowArcs shadowArcs_nondegenerate shadowArcs_finite
    frontier_shadowW_subset shadowCol shadowCol_locallyConstant

/-- `shadowModel` is a map of the plane. -/
theorem shadowModel_isPlaneMap : shadowModel.IsPlaneMap := ArcMap.paint_isPlaneMap (brickBase_isPlaneMap 9 _)

section ShadowModelHelpers

open ArcMap

/-! ### The classes of `shadowModel`, its validity and its shadows (FS131-MB2's helpers) -/

/-- The painted set lies among the base's interior points: each horn set is strictly inside one brick. -/
theorem shadowModel_shadowW_subset : shadowWg ∪ shadowWh ⊆ (brickBase 9 (by norm_num)).interiorPts := by
  have hv : ∀ z : ℂ, dist z plantPt < 1 / 10 → z ∈ (brickBase 9 (by norm_num)).interiorPts := fun z hz => by
    obtain ⟨h1, h2⟩ := stuckModel_pieces.1 hz.le
    rw [abs_le] at h1 h2
    exact brickBase_mem_interiorPts _ (c := 0) (r := 0) (by constructor <;> push_cast <;> linarith)
      (by constructor <;> push_cast <;> linarith)
  have hN : ∀ z : ℂ, dist z plantN < 1 / 20 → z ∈ (brickBase 9 (by norm_num)).interiorPts := fun z hz => by
    have hc := stuckModel_abs_coords_le z plantN
    obtain ⟨h1, h2⟩ := stuckModel_pieces.2.1 ⟨hc.1.trans hz.le, hc.2.trans hz.le⟩
    rw [abs_le] at h1 h2
    exact brickBase_mem_interiorPts _ (c := -1) (r := 2) (by constructor <;> push_cast <;> linarith)
      (by constructor <;> push_cast <;> linarith)
  have hS : ∀ z : ℂ, dist z plantS < 1 / 20 → z ∈ (brickBase 9 (by norm_num)).interiorPts := fun z hz => by
    have hc := stuckModel_abs_coords_le z plantS
    obtain ⟨h1, h2⟩ := stuckModel_pieces.2.2 ⟨hc.1.trans hz.le, hc.2.trans hz.le⟩
    rw [abs_le] at h1 h2
    exact brickBase_mem_interiorPts _ (c := 1) (r := -2) (by constructor <;> push_cast <;> linarith)
      (by constructor <;> push_cast <;> linarith)
  rintro z ((hz | hz) | (hz | hz))
  · exact hv z hz.1
  · exact hS z hz.1
  · exact hv z hz.1
  · exact hN z hz.1

/-- **The painted sets lie in their colours' classes**: a point of `shadowWg` is an interior point of colour `7`, one of `shadowWh` of
colour `8`. -/
theorem shadowModel_mem_region {z : ℂ} :
    (z ∈ shadowWg → z ∈ shadowModel.region 7) ∧ (z ∈ shadowWh → z ∈ shadowModel.region 8) := by
  have hI : ∀ w ∈ shadowWg ∪ shadowWh, w ∈ shadowModel.interiorPts := fun w hw => by
    unfold shadowModel
    rw [ArcMap.interiorPts_paint]
    exact ⟨shadowModel_shadowW_subset hw, shadowModel_not_mem_arcs hw⟩
  have hc : ∀ w ∈ shadowWg ∪ shadowWh, shadowModel.col w = shadowCol w := fun w hw => ArcMap.paint_col_of_mem hw
  refine ⟨fun h => ⟨hI z (Or.inl h), ?_⟩, fun h => ⟨hI z (Or.inr h), ?_⟩⟩
  · show shadowModel.col z = 7
    rw [hc z (Or.inl h), shadowModel_shadowCol.1 h]
  · show shadowModel.col z = 8
    rw [hc z (Or.inr h), shadowModel_shadowCol.2 h]

/-- The height above a tangent circle in the frame along `e 0`, in coordinates. -/
theorem shadowModel_tanHeight (v z : ℂ) (κ : ℝ) : tanHeight κ (frameX v 0 z) (frameY v 0 z) =
    (z.im - v.im) - κ * ((z.re - v.re) ^ 2 + (z.im - v.im) ^ 2) / 2 := by
  rw [(stuckModel_frames v z).1, (stuckModel_frames v z).2.1, tanHeight]

/-- Two points, one within `4` of a centre and one beyond `5` from it, are more than `1` apart. -/
theorem shadowModel_apart {z p c : ℂ} (hz : dist z c < 4) (hp : 5 < dist p c) : 1 < dist z p := by
  have := dist_triangle p z c
  rw [dist_comm p z] at this
  linarith

/-- **Flank against source** (FS131-E7 § 6.2): a point above the arc of curvature `1/2` at the vertex is inside the circle of radius `4`
about `plantPt + 4i`, and a point below the arc of curvature `1/5` at the lower pole is outside the concentric circle of radius `5`; so
they are more than `1` apart. The mirror image for the other colour. -/
theorem shadowModel_flank_source {z p : ℂ} :
    (TanAbove plantPt 0 (1 / 2) z → TanBelow plantS 0 (1 / 5) p → 1 < dist z p) ∧
    (TanBelow plantPt 0 (-1 / 2) z → TanAbove plantN 0 (-1 / 5) p → 1 < dist z p) := by
  obtain ⟨c1, c2, c3, c4, c5, c6⟩ := stuckModel_plant_coords
  have hsq : ∀ {d r : ℝ}, 0 ≤ d → 0 ≤ r → d ^ 2 < r ^ 2 → d < r := fun hd hr h => (lt_iff_sq_lt_sq' hd hr).mpr h
  refine ⟨fun hz hp => ?_, fun hz hp => ?_⟩
  · unfold TanAbove at hz; unfold TanBelow at hp
    rw [shadowModel_tanHeight, c1, c2] at hz
    rw [shadowModel_tanHeight, c5, c6] at hp
    refine shadowModel_apart (c := plantPt + 4 * I) (hsq dist_nonneg (by norm_num) ?_) (hsq (by norm_num) dist_nonneg ?_)
    · rw [stuckModel_dist_sq]; simp only [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, Complex.I_re, Complex.I_im, c1, c2]
      norm_num
      nlinarith [sq_nonneg (z.re - 2 / 5), sq_nonneg (z.im - 3 / 10)]
    · rw [stuckModel_dist_sq]; simp only [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, Complex.I_re, Complex.I_im, c1, c2]
      norm_num
      nlinarith
  · unfold TanBelow at hz; unfold TanAbove at hp
    rw [shadowModel_tanHeight, c1, c2] at hz
    rw [shadowModel_tanHeight, c3, c4] at hp
    refine shadowModel_apart (c := plantPt - 4 * I) (hsq dist_nonneg (by norm_num) ?_) (hsq (by norm_num) dist_nonneg ?_)
    · rw [stuckModel_dist_sq]; simp only [Complex.sub_re, Complex.sub_im, Complex.mul_re, Complex.mul_im, Complex.I_re, Complex.I_im, c1, c2]
      norm_num
      nlinarith [sq_nonneg (z.re - 2 / 5), sq_nonneg (z.im - 3 / 10)]
    · rw [stuckModel_dist_sq]; simp only [Complex.sub_re, Complex.sub_im, Complex.mul_re, Complex.mul_im, Complex.I_re, Complex.I_im, c1, c2]
      norm_num
      nlinarith

/-- **No unit pair inside a painted colour's set.** -/
theorem shadowModel_no_unit_pair {x y : ℂ} :
    (x ∈ shadowWg → y ∈ shadowWg → dist x y ≠ 1) ∧ (x ∈ shadowWh → y ∈ shadowWh → dist x y ≠ 1) := by
  have near : ∀ {c : ℂ} {r : ℝ}, r ≤ 1 / 10 → dist x c < r → dist y c < r → dist x y ≠ 1 := fun {c r} hr h1 h2 h => by
    have := dist_triangle x c y
    rw [dist_comm c y] at this
    linarith
  refine ⟨fun hx hy => ?_, fun hx hy => ?_⟩
  · rcases hx with hx | hx <;> rcases hy with hy | hy
    · exact near le_rfl hx.1 hy.1
    · exact (shadowModel_flank_source.1 hx.2.2.1 hy.2.2.2).ne'
    · rw [dist_comm]; exact (shadowModel_flank_source.1 hy.2.2.1 hx.2.2.2).ne'
    · exact near (by norm_num) hx.1 hy.1
  · rcases hx with hx | hx <;> rcases hy with hy | hy
    · exact near le_rfl hx.1 hy.1
    · exact (shadowModel_flank_source.2 hx.2.2.2 hy.2.2.1).ne'
    · rw [dist_comm]; exact (shadowModel_flank_source.2 hy.2.2.2 hx.2.2.1).ne'
    · exact near (by norm_num) hx.1 hy.1

/-- No new arc of `shadowModel` is a unit arc: the radii are `2`, `4/3`, `10`, `5`, `1/10`, `1/20`. -/
theorem shadowModel_not_isUnitArc : ∀ a ∈ shadowArcs, ¬ a.IsUnitArc := by
  have key : ∀ (v : ℂ) (κ₁ κ₂ ρ : ℝ), |κ₁| ≠ 1 → |κ₂| ≠ 1 → ρ ≠ 1 → ∀ a ∈ hornArcs v 0 κ₁ κ₂ ρ, ¬ a.IsUnitArc := by
    intro v κ₁ κ₂ ρ h1 h2 hρ a ha
    simp only [hornArcs, mem_insert_iff, mem_singleton_iff] at ha
    rcases ha with rfl | rfl | rfl
    · rw [germArc_isUnitArc_iff]; exact h1
    · rw [germArc_isUnitArc_iff]; exact h2
    · exact hρ
  rintro a ((ha | ha) | (ha | ha))
  · exact key _ _ _ _ (by norm_num [abs_of_pos]) (by norm_num [abs_of_pos]) (by norm_num) a ha
  · exact key _ _ _ _ (by norm_num [abs_of_pos]) (by norm_num [abs_of_pos]) (by norm_num) a ha
  · exact key _ _ _ _ (by norm_num [abs_of_neg]) (by norm_num [abs_of_neg]) (by norm_num) a ha
  · exact key _ _ _ _ (by norm_num [abs_of_neg]) (by norm_num [abs_of_neg]) (by norm_num) a ha

/-- **The witness of a shadow, in real variables**: for a band point `(x, y)` near the vertex — `x > 0`, `|y| < (x² + y²)/16` — the curve
`a ↦ (a, a²/14 − 1)` through the lower pole passes from further than `1` (at `a = 0`) to nearer than `1` (at `a = x`); so some point of
it with `0 < a < x` is at distance exactly `1`. -/
theorem shadowModel_witness_real {x y : ℝ} (hx : 0 < x) (hr : x ^ 2 + y ^ 2 < 1 / 10000) (h1 : -(x ^ 2 + y ^ 2) / 16 < y)
    (h2 : y < (x ^ 2 + y ^ 2) / 16) : ∃ a, 0 < a ∧ a < x ∧ (x - a) ^ 2 + (y + 1 - a ^ 2 / 14) ^ 2 = 1 := by
  set f : ℝ → ℝ := fun a => (x - a) ^ 2 + (y + 1 - a ^ 2 / 14) ^ 2 with hf
  have hcont : ContinuousOn f (Icc 0 x) := by rw [hf]; fun_prop
  have h0 : 1 < f 0 := by simp only [hf]; nlinarith [sq_nonneg x, sq_nonneg y]
  have hx2 : x ^ 2 < 1 / 10000 := by nlinarith [sq_nonneg y]
  have hy14 : 14 * y < x ^ 2 := by
    rcases le_or_gt y 0 with hy | hy
    · nlinarith [sq_pos_of_pos hx]
    · have : y < 1 / 160000 := by linarith
      nlinarith [mul_pos hy (by linarith : (0 : ℝ) < 1 / 160000 - y)]
  have hxx : f x < 1 := by
    simp only [hf, sub_self]
    have ha : y - x ^ 2 / 14 < 0 := by linarith
    have hb : -2 < y - x ^ 2 / 14 := by nlinarith [sq_nonneg y, sq_nonneg x]
    nlinarith
  obtain ⟨a, ha, hfa⟩ := intermediate_value_Ioo' hx.le hcont ⟨hxx, h0⟩
  exact ⟨a, ha.1, ha.2, hfa⟩

/-- **Every band point near the vertex is in both shadows** (FS131-E7 § 6.3.1, with the witness on the curve `b = a²/14` through the
pole, between the source horn's two arcs, in place of the circle of radius `6`): a point of the horn of `7` at the lower pole and a
point of the horn of `8` at the upper pole lie at distance exactly `1` from it. -/
theorem shadowModel_shadow {z : ℂ} (hz : z ∈ hornSet plantPt 0 (-1 / 8) (1 / 8) (1 / 100)) :
    (∃ p ∈ hornSet plantS 0 (1 / 10) (1 / 5) (1 / 20), dist z p = 1) ∧
    (∃ q ∈ hornSet plantN 0 (-1 / 5) (-1 / 10) (1 / 20), dist z q = 1) := by
  obtain ⟨c1, c2, c3, c4, c5, c6⟩ := stuckModel_plant_coords
  obtain ⟨hd, hX, hA, hB⟩ := hz
  unfold TanAbove at hA; unfold TanBelow at hB
  rw [shadowModel_tanHeight, c1, c2] at hA hB
  rw [(stuckModel_frames plantPt z).1, c1] at hX
  have hd2 : (z.re - 2 / 5) ^ 2 + (z.im - 3 / 10) ^ 2 < 1 / 10000 := by
    have := stuckModel_dist_sq z plantPt
    rw [c1, c2] at this
    rw [← this]; nlinarith [dist_nonneg (x := z) (y := plantPt)]
  have hone : ∀ {w : ℂ}, dist z w ^ 2 = 1 → dist z w = 1 := fun {w} h => by
    have := dist_nonneg (x := z) (y := w); nlinarith
  have hsmall : ∀ {a : ℝ}, 0 < a → a < z.re - 2 / 5 → a ^ 2 < 1 / 10000 := fun {a} h0 h1 => by
    nlinarith [sq_nonneg (z.im - 3 / 10)]
  constructor
  · obtain ⟨a, ha0, hax, hfa⟩ := shadowModel_witness_real hX hd2 (by linarith) (by linarith)
    have ha2 := hsmall ha0 hax
    refine ⟨⟨2 / 5 + a, -7 / 10 + a ^ 2 / 14⟩, ⟨?_, ?_, ?_, ?_⟩, hone ?_⟩
    · refine (lt_iff_sq_lt_sq' dist_nonneg (by norm_num)).mpr ?_
      rw [stuckModel_dist_sq, c5, c6]; ring_nf; nlinarith [sq_nonneg a, sq_nonneg (a ^ 2)]
    · rw [(stuckModel_frames plantS _).1, c5]; simpa using ha0
    · show 0 < tanHeight _ _ _
      rw [shadowModel_tanHeight, c5, c6]; ring_nf; nlinarith [sq_pos_of_pos ha0, sq_nonneg (a ^ 2)]
    · show tanHeight _ _ _ < 0
      rw [shadowModel_tanHeight, c5, c6]; ring_nf; nlinarith [sq_pos_of_pos ha0, sq_nonneg (a ^ 2)]
    · rw [stuckModel_dist_sq]; simp only; rw [← hfa]; ring
  · obtain ⟨a, ha0, hax, hfa⟩ := shadowModel_witness_real (y := -(z.im - 3 / 10)) hX (by rw [neg_sq]; exact hd2)
      (by rw [neg_sq]; linarith) (by rw [neg_sq]; linarith)
    have ha2 := hsmall ha0 hax
    refine ⟨⟨2 / 5 + a, 13 / 10 - a ^ 2 / 14⟩, ⟨?_, ?_, ?_, ?_⟩, hone ?_⟩
    · refine (lt_iff_sq_lt_sq' dist_nonneg (by norm_num)).mpr ?_
      rw [stuckModel_dist_sq, c3, c4]; ring_nf; nlinarith [sq_nonneg a, sq_nonneg (a ^ 2)]
    · rw [(stuckModel_frames plantN _).1, c3]; simpa using ha0
    · show 0 < tanHeight _ _ _
      rw [shadowModel_tanHeight, c3, c4]; ring_nf; nlinarith [sq_pos_of_pos ha0, sq_nonneg (a ^ 2)]
    · show tanHeight _ _ _ < 0
      rw [shadowModel_tanHeight, c3, c4]; ring_nf; nlinarith [sq_pos_of_pos ha0, sq_nonneg (a ^ 2)]
    · rw [stuckModel_dist_sq]; simp only; rw [← hfa]; ring

end ShadowModelHelpers

/-- `shadowModel` is valid (FS131-E7 § 6.2: the flank lies inside the circle of radius `4` about `plantPt + 4i`, the source outside the
concentric circle of radius `5`). -/
theorem shadowModel_valid : shadowModel.Valid := by
  classical
  unfold shadowModel
  refine ArcMap.paint_valid (brickBase_valid 9 _) ?_ ?_
  · intro x hx y hy _ _ hxy
    by_cases hxg : x ∈ shadowWg <;> by_cases hyg : y ∈ shadowWg
    · exact absurd hxy (shadowModel_no_unit_pair.1 hxg hyg)
    · rw [shadowModel_shadowCol.1 hxg, shadowModel_shadowCol.2 (hy.resolve_left hyg)]; decide
    · rw [shadowModel_shadowCol.2 (hx.resolve_left hxg), shadowModel_shadowCol.1 hyg]; decide
    · exact absurd hxy (shadowModel_no_unit_pair.2 (hx.resolve_left hxg) (hy.resolve_left hyg))
  · intro x hx _ y hy
    have hsp : 7 ≤ ((shadowCol x : Fin 9) : ℕ) := by
      rcases hx with hx | hx
      · rw [shadowModel_shadowCol.1 hx]; decide
      · rw [shadowModel_shadowCol.2 hx]; decide
    rw [brickBase_region_spare _ hsp] at hy
    exact absurd hy (notMem_empty y)

/-- `shadowModel` has Condition 5: its new arcs have radii `2`, `4/3`, `5`, `10`, `1/10`, `1/20`. -/
theorem shadowModel_condition5 : shadowModel.Condition5 := by
  unfold shadowModel
  refine ArcMap.paint_condition5 (brickBase_condition5 9 _) fun a ha p => ?_
  rcases a.finite_inter_sphere_or_eq_circ (shadowArcs_nondegenerate a ha) p with h | ⟨θ₀, θ₁, rfl⟩
  · exact h
  · exact absurd rfl (shadowModel_not_isUnitArc _ ha)

/-- The flanks at the vertex: `7` above the arc of curvature `1/2`, `8` below the arc of curvature `−1/2`. -/
theorem shadowModel_flanks : shadowModel.IsFlankAbove plantPt 0 (1 / 2) 7 ∧ shadowModel.IsFlankBelow plantPt 0 (-1 / 2) 8 := by
  have h10 : (0 : ℝ) < 1 / 10 := by norm_num
  refine ⟨⟨3 / 4, by norm_num, ?_⟩, ⟨-3 / 4, by norm_num, ?_⟩⟩
  · filter_upwards [Ioc_mem_nhdsGT h10] with r hr
    exact fun z hz => shadowModel_mem_region.1 (Or.inl (hornSet_mono_radius hr.2 hz))
  · filter_upwards [Ioc_mem_nhdsGT h10] with r hr
    exact fun z hz => shadowModel_mem_region.2 (Or.inl (hornSet_mono_radius hr.2 hz))

/-- **The band is doubly shadowed** (FS131-E7 § 6.3.1): between the curvatures `∓1/8` every point near the vertex is at distance `1` from
a point of the horn of `7` at the lower pole and from a point of the horn of `8` at the upper pole. -/
theorem shadowModel_doublyShadowed : shadowModel.DoublyShadowed plantPt 0 (-1 / 2) (1 / 2) 7 8 := by
  have h100 : (0 : ℝ) < 1 / 100 := by norm_num
  refine ⟨-1 / 8, 1 / 8, by norm_num, by norm_num, by norm_num, ?_⟩
  filter_upwards [Ioc_mem_nhdsGT h100] with r hr
  intro z hz
  obtain ⟨⟨p, hp, hzp⟩, ⟨q, hq, hzq⟩⟩ := shadowModel_shadow (hornSet_mono_radius hr.2 hz)
  exact ⟨⟨p, shadowModel_mem_region.1 (Or.inr hp), hzp⟩, ⟨q, shadowModel_mem_region.2 (Or.inr hq), hzq⟩⟩

/-- **The model of `flank_ne_of_doublyShadowed`**: the theorem applied to `shadowModel` — every hypothesis holds on it at once. -/
theorem shadowModel_flank_ne : (7 : Fin 9) ≠ 8 :=
  ArcMap.flank_ne_of_doublyShadowed shadowModel_valid shadowModel_condition5
    (ArcMap.covers_of_isPlaneMap shadowModel_isPlaneMap _ _) (by norm_num) (by norm_num) (by norm_num) shadowModel_flanks.1
    shadowModel_flanks.2 shadowModel_doublyShadowed

end HadwigerNelson.Plane
