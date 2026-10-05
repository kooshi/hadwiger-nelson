import Proofs.HadwigerNelson.Plane.Woodall.NoFourFive

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

theorem exists_preconnected_of_mem_coneAt {v : ℂ} (hv : v ∈ F.dom) {j : Fin k} {β : ℝ}
    (hβ : β ∈ coneAt (F.region j) v) : ∃ R ⊆ F.region j, IsPreconnected R ∧ β ∈ coneAt R v := by
  rw [F.coneAt_region_eq_biUnion hv j] at hβ
  obtain ⟨T, ⟨hT, -⟩, hβT⟩ := mem_iUnion₂.mp hβ
  exact ⟨T, hT.subset_region, hT.1.isPreconnected, hβT⟩

theorem collarAt_shadow_inner_of_mem_coneAt {v : ℂ} (hv : v ∈ F.dom) {j : Fin k} {β ψ : ℝ}
    (hβ : β ∈ coneAt (F.region j) v) (hcos : Real.cos (β - ψ) < 0) : CollarAt (shadow (F.region j)) v .inner ψ := by
  obtain ⟨R, hRj, hR, hβR⟩ := exists_preconnected_of_mem_coneAt hv hβ
  exact (collarAt_shadow_inner hR hβR hcos).mono (shadow_mono hRj)

theorem collarAt_shadow_outer_of_mem_coneAt {v : ℂ} (hv : v ∈ F.dom) {j : Fin k} {β ψ : ℝ}
    (hβ : β ∈ coneAt (F.region j) v) (hcos : 0 < Real.cos (β - ψ)) : CollarAt (shadow (F.region j)) v .outer ψ := by
  obtain ⟨R, hRj, hR, hβR⟩ := exists_preconnected_of_mem_coneAt hv hβ
  exact (collarAt_shadow_outer hR hβR hcos).mono (shadow_mono hRj)

theorem SectorsAt.mem_coneAt_of_mem_Icc {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (i : Fin n) {γ : ℝ} (hγ : γ ∈ Icc (d i.castSucc) (d i.succ)) :
    γ ∈ coneAt (F.region (c i)) v := by
  rw [h.2.2.2.2.2 (c i)]
  exact mem_iUnion₂.mpr ⟨i, rfl, Icc_subset_angleIcc _ _ hγ⟩

end ArcMap
end HadwigerNelson.Plane
