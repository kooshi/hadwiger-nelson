import Proofs.HadwigerNelson.Rigidity.Pieces
open MeasureTheory HadwigerNelson HadwigerNelson.Rigidity SpectralChain
#check @mul_nsmul
#check @mul_nsmul'
#check @Finset.notMem_empty
#check @exists_apply_ne_one
#check @nsmulAddMonoidHom_apply
#check @AddMonoidHom.coe_rangeRestrict
#check @AddMonoidHom.rangeRestrict_surjective
#check @AddSubgroup.mem_map
#check @AddMonoidHom.mem_range
#check @AddSubmonoidClass.coe_nsmul
#check @AddSubgroup.mem_map_of_mem
#check @connectedSpace_dual
#check @additiveDualDualEquiv
#check @Measurable.const_mul
#check @Measurable.mul_const
variable (F : Subfield ℝ) [NumberField F]
example : IsAddTorsionFree (fieldI F) := IsAddTorsionFree.of_isCancelMulZero_charZero
example (n : ℕ) (k : ℕ) (z : ℤ × ℤ) : (n * k) • z = n • k • z := by rw [mul_nsmul]
example (x : ℂ) (hx : x ∈ fieldI F) : IsAlgebraic ℚ x :=
  ((IsIntegral.of_finite ℚ (⟨x, hx⟩ : fieldI F)).map ((fieldI F).subtype.toRatAlgHom)).isAlgebraic
example (i : ℕ) (a : ℤ) (h1 : 0 ≤ a) (h2 : a < i) : a.toNat < i := by omega
