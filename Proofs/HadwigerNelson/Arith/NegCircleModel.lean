import Proofs.HadwigerNelson.Arith.SpectralInputs

/-!
# A model of `Interface.NegCircle`: the point mass at the parity character over `ℚ` (FS-131 wave 10, second planning pass)

**Read aloud, against the informal claim.** `SpectralInputs.sp_if` assumes `I.NegCircle`: a rotation-invariant probability
`λ` on the characters with `∫ Re χ(1) dλ < 0`, carried by a set translation by which does not leave `E`ᶜ. FS131-I10A found
it had no model in the kernel (so `sp_if` is an open item under the gate's inhabitant rule) and priced the derivation's own
`λ` — the archimedean circle, `J₀(j₁,₁) < 0` — at a job's stage. **The cheaper model, checked on paper here:** over
`F = ℚ` every unit vector `u = (a + bi)/c` reduces to `1` at the prime `1 + i` of `ℚ(i)` (`u·ū = 1` in a residue field of
two elements), so `r ↦ (−1)^(r mod (1 + i))` is a character `χ₀` of `R = ℤ[U_ℚ]` fixed by every rotation, with
`χ₀(1) = −1`: the point mass at `χ₀` is rotation-invariant with `∫ Re χ(1) = −1`, and at `Interface.trivial` (`E = ∅`) the
carrier clause holds with `S` everything. (`χ₀` is Woodall's two-colouring of `ℚ²`.)

Two leaves: `exists_parityHom` (the reduction map, from `UnitRing.normOne_subset_valuationSubring` at the `(1 + i)`-adic
valuation subring, which conjugation fixes) and `negCircle_trivial_bot` (the model).

With it every hypothesis of `sp_if` that the kernel can exhibit is met at once at `F = ℚ`, `I = Interface.trivial`:
`MulStable` (empty `E`), `NegCircle` (here), and `ν` the point mass at the trivial character; `BochnerHerglotz` is the
named classical hypothesis and has no kernel model.
-/

namespace HadwigerNelson.SpectralInputs

open MeasureTheory SpectralChain

/-- **The parity map of `ℤ[U_ℚ]`**: a ring homomorphism to `𝔽₂` sending every rational unit vector to `1` (reduction at
the prime `1 + i` of `ℚ(i)`). -/
theorem exists_parityHom :
    ∃ π : unitRing (⊥ : Subfield ℝ) →+* ZMod 2, ∀ u : unitVectors (⊥ : Subfield ℝ), π (uvRing u) = 1 := by
  sorry

/-- **`Interface.NegCircle` has a model**: at `F = ℚ` and the trivial interface, the point mass at the parity
character. -/
theorem negCircle_trivial_bot : (Interface.trivial (⊥ : Subfield ℝ)).NegCircle := by
  sorry

end HadwigerNelson.SpectralInputs
