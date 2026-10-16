import Proofs.HadwigerNelson.PadicPlane.Basic

/-!
# The upper half: `χ_Bor(ℚ_p²) ≤ χ(UD(𝔽_p, 2))` at `p ≡ 3 (mod 4)` (FS131-KPA1, skeleton)

**Read aloud, against `[Madore2015]` Prop. 3.2 and Rem. 3.6 (pp. 6–7).** Madore: when the residue form is anisotropic, the
map `x ↦ x − ξ_C` on each coset `C` of `ℤ_p²` in `ℚ_p²` (`ξ_C` a chosen point of `C`) is a graph homomorphism
`Γ(ℚ_p²) → Γ(ℤ_p²)`, because every edge joins two points of one coset (unit vectors are integral,
`norm_le_one_of_sq_add_sq_eq_one`); composed with reduction modulo `p` it is a homomorphism to `UD(𝔽_p, 2)`, so
`χ(ℚ_p²) ≤ χ(𝔽_p²)`. Each coset is open, so the map is locally constant and the pulled-back colouring has open classes:
**it is Borel**. The posers prove only `O(p²)` (`[BardestaniMallahiKarai2017]` Lemma 3.3, box colourings).

* `exists_residueMap` — a map `ρ : ℚ_p² → 𝔽_p²` carrying edges to edges, every fibre open.
* `exists_borelColoring_of_colorable` — the Borel colouring itself;
  `borelChromaticNumber_le_of_colorable`, `borelChromaticNumber_le_chromaticNumber` — the upper half.

The construction is Madore's; that it is Borel is the one line above. Prior art in construction.

**Models.** `exists_residueMap` has no hypothesis but `p ≡ 3 (mod 4)`, inhabited at `p = 3` and `7`;
`borelChromaticNumber_le_of_colorable`'s hypothesis is inhabited by every colouring of a finite plane in the library
(`finitePlane3_colorable_three`, `finitePlane7_colorable_four`, `finitePlane11_colorable_five`).
-/

namespace HadwigerNelson.PadicPlane

open SimpleGraph MeasureTheory

variable (p : ℕ) [Fact p.Prime]

/-- **Madore's homomorphism, locally constant** (`[Madore2015]` Prop. 3.2): at `p ≡ 3 (mod 4)` there is a map
`ρ : ℚ_p² → 𝔽_p²` carrying every edge of the p-adic plane to an edge of `UD(𝔽_p, 2)`, each of whose fibres is open. (A
point minus a fixed representative of its coset of `ℤ_p²`, reduced modulo `p`.) -/
theorem exists_residueMap (hp : p % 4 = 3) :
    ∃ ρ : ℚ_[p] × ℚ_[p] → ZMod p × ZMod p,
      (∀ x y, (unitQuadrance ℚ_[p]).Adj x y → (finitePlane p).Adj (ρ x) (ρ y)) ∧ ∀ z, IsOpen (ρ ⁻¹' {z}) := by
  sorry

/-- **A Borel colouring of the p-adic plane from one of `UD(𝔽_p, 2)`**: a `k`-colouring of the finite plane, pulled back
along `exists_residueMap`, is a proper `k`-colouring of the p-adic plane whose classes are open, hence Borel. The inhabitant
of every hypothesis that asks for a Borel colouring of the p-adic plane (`PadicPlane/Measure`). -/
theorem exists_borelColoring_of_colorable (hp : p % 4 = 3) {k : ℕ} (h : (finitePlane p).Colorable k) :
    ∃ c : (unitQuadrance ℚ_[p]).Coloring (Fin k), ∀ i, MeasurableSet[borel (ℚ_[p] × ℚ_[p])] (⇑c ⁻¹' {i}) := by
  sorry

/-- **The upper half**: a `k`-colouring of `UD(𝔽_p, 2)` bounds the Borel chromatic number of the p-adic plane by `k`. -/
theorem borelChromaticNumber_le_of_colorable (hp : p % 4 = 3) {k : ℕ} (h : (finitePlane p).Colorable k) :
    borelChromaticNumber (unitQuadrance ℚ_[p]) ≤ k :=
  let ⟨c, hc⟩ := exists_borelColoring_of_colorable p hp h
  borelChromaticNumber_le_of_coloring c hc

/-- **The upper half, as numbers**: `χ_Bor(ℚ_p²) ≤ χ(UD(𝔽_p, 2))`. -/
theorem borelChromaticNumber_le_chromaticNumber (hp : p % 4 = 3) :
    borelChromaticNumber (unitQuadrance ℚ_[p]) ≤ (finitePlane p).chromaticNumber := by
  sorry

end HadwigerNelson.PadicPlane
