import Proofs.HadwigerNelson.Rigidity.ContinuityGroup
import Proofs.HadwigerNelson.Rigidity.Herglotz

open MeasureTheory HadwigerNelson SpectralChain SpectralInputs NumberField

namespace HadwigerNelson.Rigidity

open private archHom archTop_eq tendsto_archHom eventually_archTop norm_archHom_nsmul fivePow nsmul_fivePow
  fivePow_succ fivePow_add exists_nsmul_mem_of_mem_nhds_profTop mem_nhds_profTop inv_five_mem
  from Proofs.HadwigerNelson.Rigidity.ContinuityGroup

#check @archHom
#check @archTop_eq
#check @eventually_archTop
#check @norm_archHom_nsmul
#check @fivePow
#check @nsmul_fivePow
#check @exists_nsmul_mem_of_mem_nhds_profTop
#check @mem_nhds_profTop
#check @AddChar.sum_apply_eq_ite
#check @AddChar.norm_apply
#check @AddChar.card_eq
#check @measure_eq_of_fourier
#check @measurable_evalChar
#check @nhds_inf
#check @Ultrafilter.of_le
#check @summable_of_sum_le
#check @hasSum_iff_tendsto_nat_of_nonneg
#check @Finset.sum_mul_sum
#check @Complex.mul_conj
#check @Complex.normSq_eq_norm_sq
#check @Finset.inner_mul_le_norm_mul_norm
#check @sq_sum_le_card_mul_sum_sq
#check @Fintype.exists_ne_map_eq_of_card_lt
#check @Finite.exists_ne_map_eq_of_infinite
#check @QuotientAddGroup.eq_zero_iff
#check @AddChar.map_zero_eq_one
example (n : ℕ) : ∀ M, 0 < M → M ≤ n + 1 → M ∣ (n + 1).factorial := fun M h1 h2 => Nat.dvd_factorial h1 h2

end HadwigerNelson.Rigidity
