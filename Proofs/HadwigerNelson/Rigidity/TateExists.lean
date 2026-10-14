import Proofs.HadwigerNelson.Rigidity.TateKernel

/-!
# Tate's self-duality in the form the zero-entropy side reads: a Tate model exists (FS-131, job FS131-KT1)

Lane T's exit (`plans/FS131-KT1-tate.md` § Stage 4): over every real number field `F`, the dual of `R = ℤ[U_F]` has a Tate
model (`Rigidity.TateModel`) — `W = L_∞ × ∏′_{w split} L_w`, the standard character `ψ`, and `π a := (r ↦ ψ(a r))`, with the
five facts of X01D § 2.0 (`plans/FS100-X01D-derivation.md` l. 118; [Tate1950] § 4.1 for the adeles, [Weil1967] IV.2; for
`S`-integer rings [ChothiEverestWard1997]). Read on the weaker reading of the ring (FS131-KN9): `R ⊆ O′`
(`Rigidity.unitRing_le_stableIntegers`) and `c·O′ ⊆ R` (`Rigidity.exists_mul_stableIntegers_le`); no `R = O′`, so no scope.

**The assembly.** `exists_tateModel` is the structure built from `Rigidity.tatePi` (module `Rigidity/TateCharacter`) and the
facts of `Rigidity/TateCharacter` and `Rigidity/TateKernel`, one field each; it has no leaf of its own.

**Inhabitants.** The statement is an existence over every real number field; its instance at `ℚ` (`F = ⊥`, `R = ℤ[i][1/p : p ≡ 1
(4)]`) is the model of X01D's control EF-X (l. 161). No hypothesis to model.
-/

namespace HadwigerNelson.Rigidity

/-- **A Tate model of `R̂` exists, over every real number field** (lane T's leaf; X01D § 2.0's duality on the weaker reading of
the ring). -/
theorem exists_tateModel (F : Subfield ℝ) [NumberField F] : Nonempty (TateModel F) :=
  ⟨{ π := tatePi F
     continuous_π := continuous_tatePi F
     π_unit_mul := tatePi_unit_mul F
     surjective_π := surjective_tatePi F
     ker_subset := tatePi_ker_subset F
     stableIntegers_le := fun _ hx => tatePi_toSAdele_of_mem F hx
     exists_nat_mul_mem := tatePi_exists_nat_mul_mem F
     exists_isCompact := tatePi_exists_isCompact F
     arch_mem := tatePi_arch_mem F }⟩

end HadwigerNelson.Rigidity
