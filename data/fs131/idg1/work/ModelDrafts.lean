import Proofs.HadwigerNelson.Rigidity.Duality
import Proofs.HadwigerNelson.Rigidity.DualConnected
import Proofs.HadwigerNelson.Rigidity.UnitCircle
/-! FS131-IDG1 — draft models for the hypotheses of this job's statements that ship none in their files (for the
landing to place; each elaborates against the built tree). Read-only. -/

open MeasureTheory HadwigerNelson.SpectralInputs

namespace HadwigerNelson.Rigidity

-- `measure_eq_of_fourier`'s hypotheses (two finite measures, equal coefficients): `σ = σ' = dualHaar ℤ`.
example : IsFiniteMeasure (dualHaar ℤ) ∧
    ∀ r : ℤ, ∫ χ, (χ r : ℂ) ∂(dualHaar ℤ) = ∫ χ, (χ r : ℂ) ∂(dualHaar ℤ) :=
  ⟨inferInstance, fun _ => rfl⟩

-- `IsHaarFourier.map_dual`'s and `map_dual_eq`'s hypotheses: Haar measure, and an injective endomorphism other than the
-- identity, `n ↦ 2n` on `ℤ`.
example : IsHaarFourier (dualHaar ℤ) ∧ Function.Injective (zmultiplesHom ℤ (2 : ℤ)) :=
  ⟨isHaarFourier_dualHaar ℤ, fun a b h => by
    simp only [zmultiplesHom_apply, smul_eq_mul] at h
    omega⟩

-- `subgroupHaar_pos`'s hypotheses: `U = univ`, `Y = ⊥` (compact: finite).
example : IsOpen (Set.univ : Set (AddChar ℤ Circle)) ∧
    (Set.univ ∩ ((⊥ : Subgroup (AddChar ℤ Circle)) : Set (AddChar ℤ Circle))).Nonempty :=
  ⟨isOpen_univ, ⟨1, Set.mem_univ _, Subgroup.one_mem _⟩⟩

-- `finite_dualAnnihilator`'s hypothesis `Finite (G ⧸ N)` at `N = ⊤`.
example : Finite (ℤ ⧸ (⊤ : AddSubgroup ℤ)) := inferInstance

-- `surjective_compAddMonoidHom`'s hypotheses, not at the identity: `n ↦ 2n` on `ℤ` is injective.
example : Function.Injective (zmultiplesHom ℤ (2 : ℤ)) := fun a b h => by
  simp only [zmultiplesHom_apply, smul_eq_mul] at h
  omega

-- D2's hypothesis at a closed subgroup that is neither `⊥` nor `⊤`: the annihilator of `2ℤ`.
example : IsClosed ((dualAnnihilator (AddSubgroup.zmultiples (2 : ℤ)) : Subgroup (AddChar ℤ Circle)) :
    Set (AddChar ℤ Circle)) :=
  isClosed_dualAnnihilator _

end HadwigerNelson.Rigidity
