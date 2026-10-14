import Proofs.HadwigerNelson.Rigidity.PlaceSizes

/-!
# The pigeonhole's multipliers `(1 + 2bi)/(1 − 2bi)` (FS-131, job FS131-K8B1; module M8b-3a; skeleton)

The multipliers of Lemma 3.2′(a) (X01D § 3.4, `plans/FS100-X01D-derivation.md` l. 248) on the shorter height input of
FS131-KN8 (`data/fs131/claims-NF2.md` § Dated lines, 2026-10-14: "`z = 1 + 2bi` gives `α′ = 1/(2[F:ℚ])` with no Pythagorean
count").

**Read aloud.** For `b ∈ ℕ`, `v_b := (1 + 2bi)/(1 − 2bi) = ((1 − 4b²) + 4b·i)/(1 + 4b²)` (`multiplier F b`, by its coordinates):

* a unit vector of `F²`, since its coordinates are rational (`multiplier`, `coe_multiplier`);
* `b ↦ v_b` is injective (`multiplier_injective`: the real part `(1 − 4b²)/(1 + 4b²)` is strictly decreasing);
* **an isometry at every archimedean place** of `L` (`absAt_multiplier_arch`; X01D l. 248: "every `v ∈ U_ℚ ⊂ ℚ(i)` has
  modulus 1 at every archimedean place of `L`" — an embedding sends `i` to `±i`);
* **its split height is at most `(1 + 2b)^{[L:ℚ]}`** (`splitHeight_multiplier_le`): `|v_b|_w ≤ |1 − 2bi|_w⁻¹` at every
  finite place, and `∏_w |1 − 2bi|_w⁻¹ = |N(1 − 2bi)| = ∏_v v(1 − 2bi)^{mult} ≤ (1 + 2b)^{[L:ℚ]}` (the product formula for
  an integer). So the `B` multipliers `v_1, …, v_B` have heights at most `(3B)^{[L:ℚ]} =: M`, and `B = M^{1/[L:ℚ]}/3`: the
  count `#V_M ≥ c·M^{α′}` with `α′ = 1/[L:ℚ] = 1/(2[F:ℚ])`, the dated line's exponent.

**Inhabitants.** `b = 1`: `v_1 = (−3 + 4i)/5` (`multiplier_one`).
-/

namespace HadwigerNelson.Rigidity

open SpectralChain NumberField

noncomputable section

variable (F : Subfield ℝ) [NumberField F]

private theorem multiplier_mem (b : ℕ) :
    (⟨(1 - 4 * (b : ℝ) ^ 2) / (1 + 4 * (b : ℝ) ^ 2), 4 * (b : ℝ) / (1 + 4 * (b : ℝ) ^ 2)⟩ : ℂ) ∈ unitVectors F := by
  sorry

/-- **The multiplier `v_b = (1 + 2bi)/(1 − 2bi)`**, given by its coordinates `((1 − 4b²) + 4b·i)/(1 + 4b²)`. -/
def multiplier (b : ℕ) : unitVectors F :=
  ⟨⟨(1 - 4 * (b : ℝ) ^ 2) / (1 + 4 * (b : ℝ) ^ 2), 4 * (b : ℝ) / (1 + 4 * (b : ℝ) ^ 2)⟩, multiplier_mem F b⟩

example (b : ℕ) : ((multiplier F b : ℂ)).re = (1 - 4 * (b : ℝ) ^ 2) / (1 + 4 * (b : ℝ) ^ 2) := rfl

/-- `v_b = (1 + 2bi)/(1 − 2bi)`. -/
theorem coe_multiplier (b : ℕ) :
    (multiplier F b : ℂ) = (1 + 2 * (b : ℂ) * Complex.I) / (1 - 2 * (b : ℂ) * Complex.I) := by
  sorry

/-- `v_1 = (−3 + 4i)/5`. -/
theorem multiplier_one : (multiplier F 1 : ℂ) = ⟨-3 / 5, 4 / 5⟩ := by
  sorry

/-- **Distinct `b` give distinct multipliers**: the real part is strictly decreasing in `b`. -/
theorem multiplier_injective : Function.Injective (multiplier F) := by
  sorry

/-- **An isometry at every archimedean place of `L`** (X01D l. 248). -/
theorem absAt_multiplier_arch (v : InfinitePlace (fieldI F)) (b : ℕ) :
    (WPlace.arch v).absAt (unitL (multiplier F b)) = 1 := by
  sorry

/-- **The height of `v_b`**: `∏_{w split} max(1, |v_b|_w) ≤ (1 + 2b)^{[L:ℚ]}`. -/
theorem splitHeight_multiplier_le (b : ℕ) :
    splitHeight (unitL (multiplier F b)) ≤ (1 + 2 * (b : ℝ)) ^ Module.finrank ℚ (fieldI F) := by
  sorry

end

end HadwigerNelson.Rigidity
