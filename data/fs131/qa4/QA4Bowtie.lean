/-
FS131-QA4 scratch (read-only against `fs131-wop`'s oleans, `main`'s `Proofs/` at `d4403f09`; `lake env lean`, nothing built).
The two fragments that carry a horn do not cover the closed unit disc about their vertex: neither is a model of any hypothesis set
that holds `F.Covers v 1` (the four moves, the stuck family) or `F.IsPlaneMap`.
-/
import Proofs.HadwigerNelson.Plane.ValidMap.BaseSteps

open Complex Real Set Filter Topology Metric

namespace HadwigerNelson.Plane.ArcMap

/-- Every point of the bowtie's tiles has real part at most `1/2`. -/
theorem qa4_bowtieTiles_re {z : ℂ} (hz : z ∈ bowtieTiles) : z.re ≤ 1 / 2 := by
  have hx := le_abs_self z.re
  simp only [bowtieTiles, mem_union] at hz
  rcases hz with ((((((((((h | h) | h) | h) | h) | h) | h) | h) | h) | h) | h)
  · -- G
    obtain ⟨h1, -, h3⟩ := h
    have him := Complex.abs_im_le_norm (z - I)
    simp only [Complex.sub_im, Complex.I_im] at him
    have := (abs_le.mp (him.trans h1.le)).1
    linarith
  · -- H
    obtain ⟨h1, -, h3⟩ := h
    have him := Complex.abs_im_le_norm (z + I)
    simp only [Complex.add_im, Complex.I_im] at him
    have := (abs_le.mp (him.trans h1.le)).2
    linarith
  · obtain ⟨-, h2, -⟩ := h; linarith
  · obtain ⟨h1, h2⟩ := h; linarith
  · obtain ⟨h1, h2⟩ := h; linarith
  · obtain ⟨-, -, h3, -⟩ := h; linarith
  · obtain ⟨h1, h2, -, h4⟩ := h; linarith
  · obtain ⟨-, -, h3, -⟩ := h; linarith
  · obtain ⟨h1, h2, -, h4⟩ := h; linarith
  · obtain ⟨-, h2, -⟩ := h; linarith
  · obtain ⟨h1, -, -⟩ := h; linarith

/-- **QA4-B1**: the bowtie does not cover the closed unit disc about its stuck vertex `0` — the point `1` is outside its domain. -/
theorem qa4_bowtie_not_covers : ¬ bowtie.Covers 0 1 := by
  intro h
  have h1 : (1 : ℂ) ∈ closure bowtieTiles :=
    interior_subset (h (by simp [mem_closedBall] : (1 : ℂ) ∈ closedBall (0 : ℂ) 1))
  have hcl : closure bowtieTiles ⊆ {z : ℂ | z.re ≤ 1 / 2} :=
    closure_minimal (fun z hz => qa4_bowtieTiles_re hz) (isClosed_le Complex.continuous_re continuous_const)
  have := hcl h1
  norm_num at this

/-- **QA4-B2**: so the bowtie is not a map of the plane either. -/
theorem qa4_bowtie_not_isPlaneMap : ¬ bowtie.IsPlaneMap := fun h =>
  qa4_bowtie_not_covers fun z _ => by rw [show bowtie.dom = univ from h]; exact mem_univ z

/-- **QA4-B3**: the cusp fragment does not cover the closed unit disc about `0` (its domain is `B(0, 1/2)`). -/
theorem qa4_cuspFrag_not_covers : ¬ cuspFrag.Covers 0 1 := by
  intro h
  have h1 : (1 : ℂ) ∈ ball (0 : ℂ) (1 / 2) := h (by simp [mem_closedBall] : (1 : ℂ) ∈ closedBall (0 : ℂ) 1)
  rw [mem_ball, dist_zero_right, norm_one] at h1
  norm_num at h1

end HadwigerNelson.Plane.ArcMap

#print axioms HadwigerNelson.Plane.ArcMap.qa4_bowtie_not_covers
#print axioms HadwigerNelson.Plane.ArcMap.qa4_bowtie_not_isPlaneMap
#print axioms HadwigerNelson.Plane.ArcMap.qa4_cuspFrag_not_covers
