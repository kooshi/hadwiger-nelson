import Proofs.HadwigerNelson.Plane.Saturated.FanBridge

namespace HadwigerNelson.Plane
open Complex Set MeasureTheory Filter Topology Metric
namespace AeColouring
namespace Fan
--BEGIN-EX
/-! ### The model of the five lemmas: `sq9Fan` at the grid vertex (FS131-I6E) -/

/-- `two_le_n` on its model: `sq9Fan` at the singular vertex `sqVertex` (it has four branches). -/
example : 2 ≤ sq9Fan.n := sq9Fan.two_le_n sqVertex_mem_singularSet

/-- `col_ne` on its model: the quadrants on the two sides of the first half-axis of `sq9Fan` have different colours. -/
example : sq9Fan.col (3 : Fin 4) ≠ sq9Fan.col (0 : Fin 4) := sq9Fan.col_ne (Or.inr ⟨rfl, rfl⟩)

/-- The saturation hypothesis of `branch_outside_discs`, `branch_contacts`, `sector_alone`, `sector_unique` on their
model. -/
example : SaturatedOn sq9.cls (ball sqVertex sq9Fan.r \ {sqVertex}) := sq9_tight_saturated.2.1.saturatedOn _

/-- `branch_outside_discs` on its model: each half-axis of `sq9Fan` stays outside its two tangent unit discs. -/
example (i : Fin 4) {t : ℝ} (ht : t ∈ Ioo 0 (min sq9Fan.r (1 / 2))) :
    1 ≤ dist (polarPt sqVertex t (sq9Fan.φ i t)) (sqVertex + I * e (sq9Fan.dir i)) :=
  (sq9Fan.branch_outside_discs (sq9_tight_saturated.2.1.saturatedOn _) i ht).1

/-- `sector_alone` on its model: `sq9Fan` has four sectors of positive angle, so its four colours are different. -/
example {i i' : Fin 4} (hcol : sq9Fan.col i = sq9Fan.col i') : i = i' :=
  sq9Fan.sector_alone (sq9_tight_saturated.2.1.saturatedOn _) (sq9Fan_dir_lt_nextDir i) hcol
--END-EX
end Fan
end AeColouring
end HadwigerNelson.Plane
