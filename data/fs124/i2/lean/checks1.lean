import Proofs.HadwigerNelson.Plane.Basic
import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Analysis.Convex.Topology
import Mathlib.Geometry.Euclidean.Basic
open Metric MeasureTheory
#check @Complex.basisOneI
#check @Module.finrank_eq_card_basis
example : Module.finrank ℝ ℂ = 2 := by
  rw [Module.finrank_eq_card_basis Complex.basisOneI, Fintype.card_fin]
example : Module.finrank ℝ ℂ = 2 := by exact?
