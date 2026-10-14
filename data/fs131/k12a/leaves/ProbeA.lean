import Proofs.HadwigerNelson.Rigidity.CountTorus
open HadwigerNelson HadwigerNelson.SpectralChain NumberField
variable (F : Subfield ℝ) [NumberField F]
#synth Algebra F (fieldI F)
#check @Rat.denseRange_cast
#check @NumberField.InfinitePlace.comap
#check @NumberField.ComplexEmbedding.IsReal
#check @HadwigerNelson.UnitRing.planeOverSubfield
example : Module ℝ (NumberField.mixedEmbedding.mixedSpace (fieldI F)) := inferInstance
example : FiniteDimensional ℝ (NumberField.mixedEmbedding.mixedSpace (fieldI F)) := inferInstance
