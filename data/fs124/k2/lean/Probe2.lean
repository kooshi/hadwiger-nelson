import Proofs.HadwigerNelson.Plane.OnePiece

namespace HadwigerNelson.Plane
open Complex Set MeasureTheory Metric

variable {α : Type*}

theorem probe_mem_unitShadow_of_isPreconnected {P : Set ℂ} (hP : IsPreconnected P) {z y₀ y₁ : ℂ} (h₀ : y₀ ∈ P)
    (h₁ : y₁ ∈ P) (hin : dist y₀ z < 1) (hout : 1 < dist y₁ z) : z ∈ unitShadow P := by
  by_contra hz
  have hne : ∀ s ∈ P, dist z s ≠ 1 := fun s hs h => hz ⟨s, hs, h⟩
  rcases preconnected_dist_lt_or_gt hP hne with h | h
  · exact absurd (h y₁ h₁) (by rw [dist_comm]; exact not_lt.mpr hout.le)
  · exact absurd (h y₀ h₀) (by rw [dist_comm]; exact not_lt.mpr hin.le)

theorem probe_not_onSide_iff {σ : CircleSide} {P : Set ℂ} {w : ℂ} :
    ¬ OnSide σ P w ↔ ∃ y ∈ P, y ∈ σ.flip.region w := by
  cases σ
  · simp only [OnSide, InnerAt, CircleSide.flip, CircleSide.region, not_subset, mem_compl_iff]
  · simp only [OnSide, OuterAt, CircleSide.flip, CircleSide.region, not_disjoint_iff]

theorem probe_mem_region_comm {σ : CircleSide} {y z : ℂ} : y ∈ σ.region z ↔ z ∈ σ.region y := by
  cases σ <;> simp [CircleSide.region, dist_comm]

theorem probe_isOpen_region (σ : CircleSide) (w : ℂ) : IsOpen (σ.region w) := by
  cases σ
  · exact isOpen_ball
  · exact isClosed_closedBall.isOpen_compl

/-- the type of a piece -/
theorem probe_ae_ne_region {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {x : ℂ} {P : Set ℂ}
    {i : α} (hP : IsPieceAt U c x P i) {w : ℂ} (hw : w ∈ U) {σ : CircleSide} (hσ : ¬ OnSide σ P w) :
    ∃ η > 0, ∀ᵐ z, z ∈ ball w η → z ∈ σ.region x → c z ≠ i := by
  obtain ⟨y₀, hy₀P, hy₀⟩ := probe_not_onSide_iff.mp hσ
  -- a disc about `w` inside `U` on which `y₀` stays on the other side of the unit circle about the point
  obtain ⟨η, hη, hball⟩ := Metric.isOpen_iff.mp (hU.inter (probe_isOpen_region σ.flip y₀)) w
    ⟨hw, probe_mem_region_comm.mp hy₀⟩
  refine ⟨η, hη, ?_⟩
  filter_upwards [hc.ae_unitShadow_ne hP.isOpen hP.subset hP.ae_label] with z hz hzb hzσ
  refine hz ⟨(hball hzb).1, ?_⟩
  have hy₀z : y₀ ∈ σ.flip.region z := probe_mem_region_comm.mp (hball hzb).2
  -- a point of `P` near `x` on the side `σ` of the unit circle about `z`
  obtain ⟨y₁, hy₁σ, hy₁P⟩ := mem_closure_iff.mp hP.mem_closure _ (probe_isOpen_region σ z)
    (probe_mem_region_comm.mp hzσ)
  cases σ
  · exact probe_mem_unitShadow_of_isPreconnected hP.isPreconnected hy₁P hy₀P
      (by simpa [CircleSide.region] using hy₁σ) (by simpa [CircleSide.region, CircleSide.flip] using hy₀z)
  · exact probe_mem_unitShadow_of_isPreconnected hP.isPreconnected hy₀P hy₁P
      (by simpa [CircleSide.region, CircleSide.flip] using hy₀z) (by simpa [CircleSide.region] using hy₁σ)

end HadwigerNelson.Plane
