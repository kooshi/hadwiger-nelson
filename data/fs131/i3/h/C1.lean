import Proofs.HadwigerNelson.Plane.SixFragment

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- Rotation by `60° k` carries the arcs of `sixFrag` into themselves. -/
theorem mem_arcs_rot (k : ℤ) {x : ℂ} (h : x ∈ ⋃ a ∈ sixArcs, a.carrier) :
    e (k * (π / 3)) * x ∈ ⋃ a ∈ sixArcs, a.carrier := by
  obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp h
  rcases ha with ((⟨j, rfl⟩ | ha) | ⟨j, rfl⟩) | ⟨j, rfl⟩
  · obtain ⟨u, v, hu, hv, huv, rfl⟩ := hxa
    have hv1 : v ≤ 1 := by linarith
    have := mem_arcs_radial hv hv1 (((j : ℕ) : ℤ) + k)
    convert this using 1
    simp only [smul_zero, zero_add, Complex.real_smul]
    rw [mul_left_comm, ← e_add]; congr 2; push_cast; ring
  · rw [mem_singleton_iff] at ha
    subst ha
    obtain ⟨θ, -, rfl⟩ := hxa
    exact mem_arcs_of_norm_eq_one (by simp)
  · obtain ⟨θ, hθ, rfl⟩ := hxa
    have := mem_arcs_side₁ (((j : ℕ) : ℤ) + k) (ψ := θ + k * (π / 3))
      ⟨by push_cast; linarith [hθ.1], by push_cast; linarith [hθ.2]⟩
    convert this using 1
    show e (k * (π / 3)) * (_ + ((1 : ℝ) : ℂ) * e θ) = _
    rw [Complex.ofReal_one, one_mul, mul_add, ← e_add, ← e_add]
    congr 2 <;> push_cast <;> ring
  · obtain ⟨θ, hθ, rfl⟩ := hxa
    have := mem_arcs_side₂ (((j : ℕ) : ℤ) + k) (ψ := θ + k * (π / 3))
      ⟨by push_cast; linarith [hθ.1], by push_cast; linarith [hθ.2]⟩
    convert this using 1
    show e (k * (π / 3)) * (_ + ((1 : ℝ) : ℂ) * e θ) = _
    rw [Complex.ofReal_one, one_mul, mul_add, ← e_add, ← e_add]
    congr 2 <;> push_cast <;> ring

/-- Rotation by `60° k` preserves the interior points of `sixFrag`. -/
theorem rot_mem_interiorPts (k : ℤ) {x : ℂ} (hx : x ∈ sixFrag.interiorPts) :
    e (k * (π / 3)) * x ∈ sixFrag.interiorPts := by
  obtain ⟨hxd, hxΓ⟩ := hx
  refine ⟨?_, fun h => hxΓ ?_⟩
  · show _ ∈ ball (0 : ℂ) (3 / 2)
    have : x ∈ ball (0 : ℂ) (3 / 2) := hxd
    rw [mem_ball_zero_iff] at this ⊢
    rwa [norm_mul, norm_e, one_mul]
  · have := mem_arcs_rot (-k) h
    rwa [← mul_assoc, ← e_add, show ((-k : ℤ) : ℝ) * (π / 3) + k * (π / 3) = 0 by push_cast; ring, e_zero,
      one_mul] at this

end HadwigerNelson.Plane
