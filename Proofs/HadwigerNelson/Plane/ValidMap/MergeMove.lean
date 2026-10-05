import Proofs.HadwigerNelson.Plane.ValidMap.Surgery

/-!
# MERGE at a point: the children of `exists_merge_aux` (FS110-W-MERGE; FS131-IMM1)

Wave 4's third simplifying move (inventory item 285; record `plans/FS131-IMM-implementation.md`): if `int D_c(v)` is non-empty and `c`
has `n + 1 ≥ 2` sectors at `v`, two `c`-sectors consecutive along `D_c(v)`'s arc of directions merge by recolouring with `c` the sectors
of the gap between them near `v`. `Plane/ValidMap/Moves`' `exists_merge_aux` cites the children here.

The children, in the order the proof uses them:

* **Clearness off an open set** (`dist_ne_one_of_isOpen_isClear`): an open set of points clear for `c` meets no unit circle about a
  point of the closure of `c`'s class (so the recoloured region's closure creates no contact at a far point, and `D_c(v′)` is unchanged).
* **The allowed cone is a convex cone** (`add_mem_allowedCone`, `smul_mem_allowedCone`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## Clearness off an open set -/

/-- **An open set of clear points meets no unit circle about the closure of the class**: if every point of an open set `U` is clear
for `c`, no point of `U` lies at distance `1` from a point of the closure of `c`'s class (translate the pair into the class). -/
theorem dist_ne_one_of_isOpen_isClear {c : Fin k} {U : Set ℂ} (hU : IsOpen U) (hclear : ∀ z ∈ U, F.IsClear c z)
    {z y : ℂ} (hz : z ∈ U) (hy : y ∈ closure (F.region c)) : dist z y ≠ 1 := by
  intro hzy
  obtain ⟨ε, hε, hεU⟩ := Metric.isOpen_iff.mp hU z hz
  obtain ⟨y', hy', hyy'⟩ := Metric.mem_closure_iff.mp hy ε hε
  refine hclear (z + (y' - y)) (hεU ?_) y' hy' ?_
  · rw [mem_ball, dist_eq_norm, show z + (y' - y) - z = y' - y by ring, ← dist_eq_norm, dist_comm]; exact hyy'
  · rw [dist_eq_norm, show z + (y' - y) - y' = z - y by ring, ← dist_eq_norm]; exact hzy

/-! ## The allowed cone is a convex cone -/

/-- The allowed cone is closed under sums. -/
theorem add_mem_allowedCone {v : ℂ} {c : Fin k} {d d' : ℂ} (hd : d ∈ F.allowedCone v c) (hd' : d' ∈ F.allowedCone v c) :
    d + d' ∈ F.allowedCone v c := by
  intro w hw
  obtain ⟨h1, h2⟩ := hd w hw
  obtain ⟨h1', h2'⟩ := hd' w hw
  refine ⟨fun hin => ?_, fun hout => ?_⟩
  · rw [dot_add_left]; linarith [h1 hin, h1' hin]
  · rw [dot_add_left]; linarith [h2 hout, h2' hout]

/-- The allowed cone is closed under non-negative multiples. -/
theorem smul_mem_allowedCone {v : ℂ} {c : Fin k} {d : ℂ} {t : ℝ} (ht : 0 ≤ t) (hd : d ∈ F.allowedCone v c) :
    (t : ℂ) * d ∈ F.allowedCone v c := by
  intro w hw
  obtain ⟨h1, h2⟩ := hd w hw
  refine ⟨fun hin => ?_, fun hout => ?_⟩
  · rw [dot_ofReal_mul]; exact mul_nonneg ht (h1 hin)
  · rw [dot_ofReal_mul]; exact mul_nonpos_of_nonneg_of_nonpos ht (h2 hout)

end ArcMap

end HadwigerNelson.Plane
