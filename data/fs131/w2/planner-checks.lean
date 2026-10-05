import Proofs.HadwigerNelson.Plane.Tiles
namespace HadwigerNelson.Plane
open Complex Real Set Filter Topology Metric

theorem dist_le_one_of_subset_closure' {U S : Set ℂ} (hU : IsOpen U) (hnull : UnitPairsNull U) (hS : IsPreconnected S)
    (hSU : S ⊆ closure U) {x y : ℂ} (hx : x ∈ S) (hy : y ∈ S) : dist x y ≤ 1 := by
  by_contra hgt
  push_neg at hgt
  obtain ⟨z, hzU, hxz⟩ := Metric.mem_closure_iff.mp (hSU hx) (min 1 ((dist x y - 1) / 2)) (by
    have : 0 < (dist x y - 1) / 2 := by linarith
    positivity)
  have hzx : dist z x < 1 := by rw [dist_comm]; exact lt_of_lt_of_le hxz (min_le_left _ _)
  have key := dist_lt_one_of_isPreconnected hS hx hzx
    (fun s hs => dist_ne_one_of_mem_of_mem_closure hU hnull hzU (hSU hs)) y hy
  have h2 : dist x z < (dist x y - 1) / 2 := lt_of_lt_of_le hxz (min_le_right _ _)
  have := dist_triangle x z y
  linarith

theorem ArcMap.not_mem_coloursAt_of_dist_eq_one' {k : ℕ} {F : ArcMap k} (hF : F.Valid) {j : Fin k} {q Y : ℂ}
    (hq : q ∈ F.region j) (hqY : dist q Y = 1) : j ∉ F.coloursAt Y :=
  fun hY => dist_ne_one_of_mem_of_mem_closure (F.isOpen_region j) (hF.unitPairsNull_region j) hq hY hqY

end HadwigerNelson.Plane
