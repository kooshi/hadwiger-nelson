import Proofs.HadwigerNelson.Rigidity.CountExtension
namespace HadwigerNelson.Rigidity.Counting
open SpectralChain NumberField MeasureTheory Filter Topology
variable {F : Subfield ℝ} [NumberField F]
#synth SecondCountableTopology (∀ k, Lev F k)
#synth SecondCountableTopology (K F)
#synth FirstCountableTopology (NumberField.mixedEmbedding.mixedSpace (fieldI F))
#synth FirstCountableTopology (G F)
example : (𝓝 (0 : G F)).IsCountablyGenerated := inferInstance
example : (comap (ιG F) (𝓝 0)).IsCountablyGenerated := inferInstance
end HadwigerNelson.Rigidity.Counting
