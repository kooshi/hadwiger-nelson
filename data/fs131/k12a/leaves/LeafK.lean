import Proofs.HadwigerNelson.Rigidity.CountCompletion
/-! First leaf of block K (scratch; FS131-K12A): `K F` is compact and `haarK F` is a probability measure. -/
namespace HadwigerNelson.Rigidity.Counting
open SpectralChain NumberField MeasureTheory
variable (F : Subfield ℝ) [NumberField F]

theorem leafK_compactSpace : CompactSpace (K F) := by
  haveI : ∀ k, CompactSpace (Lev F k) := fun k => Finite.compactSpace
  exact isCompact_iff_compactSpace.mp (AddSubgroup.isClosed_topologicalClosure _).isCompact

theorem leafK_isProbabilityMeasure : IsProbabilityMeasure (haarK F) := by
  haveI := leafK_compactSpace F
  constructor
  have h := Measure.addHaarMeasure_self (G := K F) (K₀ := ⊤)
  simpa [haarK] using h

end HadwigerNelson.Rigidity.Counting
