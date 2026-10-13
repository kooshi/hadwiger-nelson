import Proofs.HadwigerNelson.Plane.OneClass.Defs
-- FS133-IA1: which Mathlib modules the ported module would import are already in the import closure of
-- `Plane/OneClass/Defs` (what `Plane/OneClass/Field` imports today)?  An import outside that closure would change the
-- closure of every module downstream of `Field`, and with it, possibly, the instances their statements store.
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let have_ := env.header.moduleNames
  for m in [`Mathlib.Algebra.AlgebraicCard, `Mathlib.Algebra.Order.Ring.Star,
      `Mathlib.Analysis.CStarAlgebra.Module.Constructions, `Mathlib.Analysis.Complex.Circle,
      `Mathlib.FieldTheory.AlgebraicClosure, `Mathlib.MeasureTheory.Function.L2Space,
      `Mathlib.MeasureTheory.Function.LpSpace.InfiniteSum, `Mathlib.RingTheory.Flat.FaithfullyFlat.Basic,
      `Mathlib.RingTheory.Flat.TorsionFree, `Mathlib.RingTheory.SimpleRing.Principal,
      `Mathlib.MeasureTheory.Function.LpSpace.ContinuousCompMeasurePreserving,
      `Mathlib.Analysis.InnerProductSpace.Projection.Basic, `Mathlib.MeasureTheory.Constructions.BorelSpace.Complex,
      `Mathlib.LinearAlgebra.Complex.FiniteDimensional, `Mathlib.Analysis.InnerProductSpace.l2Space,
      `Mathlib.MeasureTheory.Function.LpSpace.Complete, `Mathlib.Topology.Algebra.UniformGroup.Basic] do
    IO.println s!"{if have_.contains m then "IN " else "OUT"} {m}"
  IO.println s!"modules in the closure: {have_.size}"
