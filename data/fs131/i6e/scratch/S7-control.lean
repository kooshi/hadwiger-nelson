import Proofs.HadwigerNelson.Plane.Saturated.FanBridge
/-! FS131-I6E, negative controls for the model examples (`lake env lean`; each must be refused).
(1) `col_ne` between two regions that are not beside one branch: the side condition is not `rfl`.
(2) `sector_alone` with the positive-angle hypothesis replaced by its negation's shape: the argument does not fit. -/
open HadwigerNelson.Plane Set Metric
example : sq9Fan.col (2 : Fin 4) ≠ sq9Fan.col (0 : Fin 4) := sq9Fan.col_ne (Or.inr ⟨rfl, rfl⟩)
example {i i' : Fin 4} (hcol : sq9Fan.col i = sq9Fan.col i') : i = i' :=
  sq9Fan.sector_alone (sq9_tight_saturated.2.1.saturatedOn _) (le_of_eq rfl) hcol
