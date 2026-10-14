import Proofs.HadwigerNelson.Rigidity.TateModel
open HadwigerNelson.Rigidity
variable (F : Subfield ℝ) [NumberField F]
#synth IsTopologicalRing (SplitAdeleRing F)
#synth IsTopologicalRing (SAdeleRing F)
#synth T2Space (SAdeleRing F)
#synth IsTopologicalAddGroup (SAdeleRing F)
#synth LocallyCompactSpace (NumberField.mixedEmbedding.mixedSpace (HadwigerNelson.SpectralChain.fieldI F))
