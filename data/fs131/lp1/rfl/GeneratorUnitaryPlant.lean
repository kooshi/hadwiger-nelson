import Proofs.HadwigerNelson.Outside.OAI158SpectralMeasure
/-!
FS131-LP1, the planted control of `GeneratorUnitary.lean`: the release's instance with its `npow` replaced by `npowRec`
(the same type, the same multiplication, another term) is not this pin's instance by `rfl`; the kernel must refuse
`planted_paths_agree`, and accept `monoid_paths_agree` beside it (this file's partner, the same text as there).
-/
noncomputable section
open scoped ComplexConjugate IsMulCommutative
namespace FS131LP1Plant
open HadwigerNelson.Outside.OAI158.CommutingSpectral
variable {G H : Type*} [CommGroup G]
  [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
  (U : G →* unitary (H →L[ℂ] H))
theorem monoid_paths_agree :
    (SubmonoidClass.toMonoid (algebra U) : Monoid (algebra U)) = (inferInstance : Monoid (algebra U)) := rfl
theorem planted_paths_agree :
    ({ SubmonoidClass.toMonoid (algebra U) with
        npow := fun n x => npowRec n x
        npow_zero := fun _ => rfl
        npow_succ := fun _ _ => rfl } : Monoid (algebra U)) = (inferInstance : Monoid (algebra U)) := rfl
end FS131LP1Plant
end
