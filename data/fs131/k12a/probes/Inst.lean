import Proofs.HadwigerNelson.Rigidity.ContinuityGroup
import Proofs.HadwigerNelson.Rigidity.ClassRatio
open HadwigerNelson HadwigerNelson.SpectralChain NumberField
variable (F : Subfield ℝ) [NumberField F] (P : StablePrime F) (k : ℕ)
#synth TopologicalSpace (𝓞 (fieldI F) ⧸ P.P ^ k)
example : Finite (𝓞 (fieldI F) ⧸ P.P ^ k) := inferInstance
#check @Ideal.finiteQuotientOfFreeOfNeBot
#check @RingHom.pi
#check @Complex.reLm
#check @LinearMap.smulRight
#check @AddSubgroup.topologicalClosure
#check @Ideal.absNorm_ne_zero_of_nonZeroDivisors
#check @countable_unitRing
#check @Monoid.ExponentExists
#check @pow_card_eq_one
#check @Finite.compactSpace
#check @Measure.addHaarMeasure_self
#check NumberField.mixedEmbedding.mixedSpace
#check @Ideal.quotientMap
#check @SpectralInputs.contChars
