/-! ## FS131-ITT1 — lanes T-I, T-L, T-A, T-C and M9-R of the five-colour chain's adelic model (`Rigidity/RingScope`,
`TateModel`, `TateLocal`, `TateArch`, `TateCharacter`): every public declaration CLEAN at build 6 (the standard three or
fewer); `unitRing_eq_stableIntegers` (RingScope, outside lane M9-R) is the one record still on `sorry`, not listed -/
-- FS131-ITT1
-- Rigidity/RingScope
#print axioms HadwigerNelson.Rigidity.dense_mixedEmbedding_nsmul_unitRing
#print axioms HadwigerNelson.Rigidity.exists_mul_stableIntegers_le
#print axioms HadwigerNelson.Rigidity.mem_stableIntegers
#print axioms HadwigerNelson.Rigidity.stableIntegers
#print axioms HadwigerNelson.Rigidity.unitRing_le_stableIntegers
#print axioms HadwigerNelson.SpectralChain.StablePrime.localRing.congr_simp
-- Rigidity/TateModel
#print axioms HadwigerNelson.Rigidity.IsStablePlace
#print axioms HadwigerNelson.Rigidity.SAdeleRing
#print axioms HadwigerNelson.Rigidity.SplitAdeleRing
#print axioms HadwigerNelson.Rigidity.SplitPlace
#print axioms HadwigerNelson.Rigidity.TateModel.arch_mem
#print axioms HadwigerNelson.Rigidity.TateModel.casesOn
#print axioms HadwigerNelson.Rigidity.TateModel.continuous_π
#print axioms HadwigerNelson.Rigidity.TateModel.ctorIdx
#print axioms HadwigerNelson.Rigidity.TateModel.exists_isCompact
#print axioms HadwigerNelson.Rigidity.TateModel.exists_nat_mul_mem
#print axioms HadwigerNelson.Rigidity.TateModel.isOpenMap
#print axioms HadwigerNelson.Rigidity.TateModel.ker_eq
#print axioms HadwigerNelson.Rigidity.TateModel.ker_subset
#print axioms HadwigerNelson.Rigidity.TateModel.mem_TA
#print axioms HadwigerNelson.Rigidity.TateModel.mem_Λ
#print axioms HadwigerNelson.Rigidity.TateModel.mk.inj
#print axioms HadwigerNelson.Rigidity.TateModel.mk.injEq
#print axioms HadwigerNelson.Rigidity.TateModel.mk.noConfusion
#print axioms HadwigerNelson.Rigidity.TateModel.mk.sizeOf_spec
#print axioms HadwigerNelson.Rigidity.TateModel.mul_mem_Λ
#print axioms HadwigerNelson.Rigidity.TateModel.noConfusion
#print axioms HadwigerNelson.Rigidity.TateModel.noConfusionType
#print axioms HadwigerNelson.Rigidity.TateModel.recOn
#print axioms HadwigerNelson.Rigidity.TateModel.sigmaCompactSpace
#print axioms HadwigerNelson.Rigidity.TateModel.stableIntegers_le
#print axioms HadwigerNelson.Rigidity.TateModel.surjective_π
#print axioms HadwigerNelson.Rigidity.TateModel.toSAdele_mem_torsionChars
#print axioms HadwigerNelson.Rigidity.TateModel.Λ
#print axioms HadwigerNelson.Rigidity.TateModel.π
#print axioms HadwigerNelson.Rigidity.TateModel.π_eq_π_iff
#print axioms HadwigerNelson.Rigidity.TateModel.π_unit_mul
#print axioms HadwigerNelson.Rigidity.ofUnitRing
#print axioms HadwigerNelson.Rigidity.splitAdeleRing_isOpen_integers
#print axioms HadwigerNelson.Rigidity.toSAdele
#print axioms HadwigerNelson.Rigidity.toSplitAdele
#print axioms HadwigerNelson.Rigidity.unitL
-- Rigidity/TateLocal
#print axioms HadwigerNelson.Rigidity.compactSpace_adicCompletionIntegers
#print axioms HadwigerNelson.Rigidity.exists_approx_completion
#print axioms HadwigerNelson.Rigidity.exists_int_trace_of_integral
#print axioms HadwigerNelson.Rigidity.exists_nat_mul_integral_of_trace_int
#print axioms HadwigerNelson.Rigidity.exists_trace_not_int_away
#print axioms HadwigerNelson.Rigidity.exists_valuation_le_one_away
-- Rigidity/TateArch
#print axioms HadwigerNelson.Rigidity.archTrace
#print axioms HadwigerNelson.Rigidity.archTrace_mixedEmbedding
#print axioms HadwigerNelson.Rigidity.archTrace_mixedEmbedding_one
#print axioms HadwigerNelson.Rigidity.exists_eq_mixedEmbedding_of_archTrace_int
-- Rigidity/TateCharacter
#print axioms HadwigerNelson.Rigidity.IsApprox
#print axioms HadwigerNelson.Rigidity.continuous_tateChar
#print axioms HadwigerNelson.Rigidity.continuous_tatePi
#print axioms HadwigerNelson.Rigidity.exists_int_trace_sub_of_isApprox
#print axioms HadwigerNelson.Rigidity.exists_isApprox
#print axioms HadwigerNelson.Rigidity.mem_stableIntegers_iff_valuation
#print axioms HadwigerNelson.Rigidity.tateChar
#print axioms HadwigerNelson.Rigidity.tateCharFun
#print axioms HadwigerNelson.Rigidity.tateCharFun_add
#print axioms HadwigerNelson.Rigidity.tateCharFun_eq
#print axioms HadwigerNelson.Rigidity.tateCharFun_zero
#print axioms HadwigerNelson.Rigidity.tateChar_of_integral
#print axioms HadwigerNelson.Rigidity.tateChar_toSAdele_of_mem
#print axioms HadwigerNelson.Rigidity.tatePi
#print axioms HadwigerNelson.Rigidity.tatePi_apply
#print axioms HadwigerNelson.Rigidity.tatePi_arch_mem
#print axioms HadwigerNelson.Rigidity.tatePi_toSAdele_of_mem
#print axioms HadwigerNelson.Rigidity.tatePi_unit_mul
