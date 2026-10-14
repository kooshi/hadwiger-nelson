import Proofs.HadwigerNelson.Rigidity.BochnerTau
import Proofs.HadwigerNelson.Arith.FactorAction
open HadwigerNelson HadwigerNelson.SpectralChain HadwigerNelson.SpectralInputs HadwigerNelson.Rigidity MeasureTheory
set_option pp.fullNames true
#print HadwigerNelson.SpectralChain.Interface.APlusOfR88
#print HadwigerNelson.SpectralChain.Interface.APlus0
#print HadwigerNelson.SpectralChain.Interface.R88TCA
#print HadwigerNelson.Rigidity.chainInterface
-- the restatement, checked by the kernel to be the hypothesis itself
example (F : Subfield ℝ) [NumberField F] : (chainInterface F).APlusOfR88 ↔
    ((∀ (μ : InvariantColouring F) (σ : Measure (Dual F)), IsTraceSpectral F μ.μ σ → σ (TA F)ᶜ ≠ 0) →
      ∀ (μ : InvariantColouring F) (σ : Measure (Dual F)), IsTraceSpectral F μ.μ σ →
        ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ < 0) := Iff.rfl
set_option pp.fullNames false
#check @HadwigerNelson.Rigidity.contChars_tauPrime
#check @HadwigerNelson.Rigidity.bochnerHerglotz_of_countable
#check @HadwigerNelson.Rigidity.bochnerOn_tauPrime
#check @HadwigerNelson.Rigidity.measure_eq_of_fourier
#check @HadwigerNelson.Rigidity.isTopologicalAddGroup_tauPrime
#check @HadwigerNelson.Rigidity.isCountablyGenerated_nhds_tauPrime
#check @HadwigerNelson.Rigidity.measurableSet_TA
#check @HadwigerNelson.Rigidity.rot_preimage_TA
#check @HadwigerNelson.SpectralInputs.spectral_carried_iff
#check @HadwigerNelson.SpectralInputs.si4
#check @HadwigerNelson.SpectralInputs.si4_equivariant
#check @HadwigerNelson.SpectralInputs.si4_equivariant_factorSigma
#check @HadwigerNelson.SpectralInputs.comap_factorSigma_eq_of_action
#check @HadwigerNelson.SpectralChain.rotInv_of_isTraceSpectral
#check @HadwigerNelson.SpectralInputs.contVec_eq_lpMeas
#check @HadwigerNelson.SpectralInputs.inner_sub_condExpL2_eq_zero
#print axioms HadwigerNelson.Rigidity.contChars_tauPrime
#print axioms HadwigerNelson.Rigidity.bochnerHerglotz_of_countable
#print axioms HadwigerNelson.Rigidity.measure_eq_of_fourier
#print axioms HadwigerNelson.Rigidity.bochnerOn_tauPrime
