import Proofs.HadwigerNelson.Rigidity.SqrtClassFive
import Proofs.HadwigerNelson.Instances.SqrtFortySeven

/-!
# `χ(ℚ(√47)²) = 5` (FS-131, job FS131-KM15; module M15, the first instance)

**Read aloud, against the informal claim** (`data/fs131/claims-NF2.md`, NF2-LEAF-23: "`NumberField` for `ℚ(√47)`'s
`Subfield ℝ`, and `5 ≤ localBound` there: every stable prime of `ℚ(√47, i)` and its target").

* `numberField_F47` — `ℚ(√47) ⊂ ℝ` is a number field (the library's instance for fields of square roots).
* `stablePrime_card_sqrt47` — **every stable prime of `ℚ(√47, i)` has a residue field of `p²` elements, `p` a prime
  `≡ 3 (mod 4)` modulo which `47` is a square** (`p = 47` included, where `47 ≡ 0`): no stable prime lies above 2, and the
  residue size `Q = pⁿ` of `Rigidity.stablePrime_card_of_two_notMem` has `n = 1` because `Q² ∣ p^[ℚ(√47, i) : ℚ]` and the
  degree is at most 4. So the targets are `Γ₁₁, Γ₁₉, Γ₂₃, Γ₃₁, Γ₄₃, Γ₄₇, Γ₆₇, …`.
* `five_le_localBound_sqrt47` — **`5 ≤ L(ℚ(√47))`**: `47` is in D:116's class (`Rigidity.five_le_localBound_of_isSquare_class`).
* `chromaticNumber_planeOver_sqrt47_eq_five` — **`χ(ℚ(√47)²) = 5`**, given `[AmbrusEtAl2023]` Theorem 1 as printed
  (`Plane.OneAvoidingDensityBound`): the chain's lower bound and the kernel's upper half
  (`chromaticNumber_planeOver_sqrt47_le_five`). It answers `[Moorhouse2010]`'s question and the existence half of
  Soifer's Open Problem 55.1 (`CLAUDE.md` § Publication), over the outside theorem and the chain's leaves.

**What rests on what:** `#print axioms` of the value prints the standard three, the declared `positive_entropy_rigidity`
and `kloosterman_bound`, and `sorryAx` through the leaves of other lines and `Rigidity.ratioAtMost_two_notMem_link`.

**Not claimed:** `L(ℚ(√47)) = 5`; that every listed `p` carries a stable prime (only `p = 11` is exhibited); that the value
is new mathematics.

**Inhabitants.** `StablePrime F47` is inhabited above 11 (`exists_stablePrime_eleven`): `1/11` is not in `ℤ[U]`, since
every unit vector has 11-integral coordinates (`unit_mem_A`). `Plane.OneAvoidingDensityBound` is an outside theorem
(`Plane.oneAvoidingDensityBound_model` models its clause).
-/

namespace HadwigerNelson.SqrtFortySeven

open SpectralChain NumberField SimpleGraph

/-- **`ℚ(√47)` is a number field**: `QuadraticPrime.instNumberFieldFieldOfRadicands` at `{47}`. -/
theorem numberField_F47 : NumberField F47 := inferInstance

/-- `[ℚ(√47, i) : ℚ] ≤ 4`: `F(i)` is the image of `F × F`, and `F47` is spanned by `1` and `√47`. -/
theorem finrank_fieldI_F47_le : Module.finrank ℚ (fieldI F47) ≤ 4 := by
  sorry

/-- `47` is a square in `ℚ(√47)`. -/
theorem isSquare_fortySeven : IsSquare ((47 : ℕ) : F47) :=
  ⟨⟨s, sqrt47_mem⟩, Subtype.ext (by push_cast; exact s_mul_s.symm)⟩

/-- **Every stable prime of `ℚ(√47, i)` and its residue size**: `p²` elements, `p ≡ 3 (mod 4)` prime, `47` a square
modulo `p`. -/
theorem stablePrime_card_sqrt47 (P : StablePrime F47) :
    ∃ p : ℕ, p.Prime ∧ p % 4 = 3 ∧ IsSquare (47 : ZMod p) ∧ Nat.card (𝓞 (fieldI F47) ⧸ P.P) = p ^ 2 := by
  sorry

/-- **A stable prime above 11** — the model of `StablePrime F47`: `1/11 ∉ ℤ[U]`, since every unit vector of `ℚ(√47)²` has
11-integral coordinates (`unit_mem_A`), and `UpperHalf.inv_natCast_mem_unitRingOver_iff_forall_stablePrime`. -/
theorem exists_stablePrime_eleven : ∃ P : StablePrime F47, (11 : 𝓞 (fieldI F47)) ∈ P.P := by
  sorry

/-- **`5 ≤ L(ℚ(√47))`**. -/
theorem five_le_localBound_sqrt47 : 5 ≤ localBound F47 :=
  Rigidity.five_le_localBound_of_isSquare_class F47 isSquare_fortySeven (by norm_num)

/-- **`χ(ℚ(√47)²) = 5`**, given `[AmbrusEtAl2023]` Theorem 1 as printed. -/
theorem chromaticNumber_planeOver_sqrt47_eq_five (hOA : Plane.OneAvoidingDensityBound) :
    ((unitDistance ℂ).induce (planeOver F47)).chromaticNumber = 5 :=
  le_antisymm chromaticNumber_planeOver_sqrt47_le_five
    (Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound F47 hOA five_le_localBound_sqrt47)

/-! ## Spec -/

-- The listed residue characteristics: `47` is a square modulo 11, 19, 23, 31, 43 and 47, and not modulo 3 or 7.
example : IsSquare (47 : ZMod 11) ∧ IsSquare (47 : ZMod 19) ∧ IsSquare (47 : ZMod 23) ∧ IsSquare (47 : ZMod 31) ∧
    IsSquare (47 : ZMod 43) ∧ IsSquare (47 : ZMod 47) := by decide
example : ¬ IsSquare (47 : ZMod 3) ∧ ¬ IsSquare (47 : ZMod 7) := by decide

end HadwigerNelson.SqrtFortySeven
