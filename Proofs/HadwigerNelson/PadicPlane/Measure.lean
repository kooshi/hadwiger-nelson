import Proofs.HadwigerNelson.PadicPlane.Basic
import Mathlib.MeasureTheory.Measure.Haar.Basic
import Mathlib.NumberTheory.Padics.Hensel

/-!
# The measure step: a Borel colouring of the p-adic plane needs at least `1/c` colours (FS131-KPA1, skeleton)

**Read aloud.** `ℤ_p²` carries its Borel σ-algebra (scoped here: Mathlib declares none on `ℤ_[p]`) and its Haar probability
`haar p`. `res p k : ℤ_p² → (ℤ/p^k)²` reduces both coordinates modulo `p^k`; its fibres are the cosets of `p^k ℤ_p²`, each
of measure `p^{−2k}`.

* `exists_unitVector_lift` — **Hensel**: every unit vector of `(ℤ/p^k)²` is the residue of a unit vector of `ℤ_p²` (`p` odd).
* `isIndepSet_wellFilled` — **the well-filled cosets are independent**: if `I ⊆ ℤ_p²` is measurable and independent in
  `unitQuadrance ℤ_[p]`, the level-`k` residues whose coset `I` fills to more than half form an independent set of
  `UD(ℤ/p^k, 2)`. (Two adjacent ones `C`, `C' = C + s` with `s` a unit vector lifted by Hensel: `I ∩ C` and `(I ∩ C') − s`
  are two subsets of `C` of measure above `μ(C)/2`, so they meet, at `x` with `x, x + s ∈ I`.) One lift, no Fubini.
* `haar_le_of_towerRatio` — **a measurable independent set holds at most the tower ratio**: `TowerRatio p c` gives
  `haar p I ≤ c`. (The badly filled points of `I` have measure tending to `0` with `k` — a compact set inside `I` and an
  open set outside, finitely many cosets between, Haar being regular (`exists_level_haar_bad_le`, after
  `Rigidity/CountCompletion`'s `tendsto_haarK_bad`) — and the well-filled cosets number at most `c · p^{2k}`.) No density
  theorem, no martingale, no Fourier analysis on `ℚ_p`.
* `one_le_mul_of_borelColoring`, `le_borelChromaticNumber_of_towerRatio` — **the Borel bound**: a proper colouring of the
  p-adic plane with `k` Borel classes has `1 ≤ k·c`, so `⌈1/c⌉ ≤ χ_Bor`. The classes meet `ℤ_p²` in measurable independent
  sets covering a set of measure `1`.

**Not claimed:** anything about a colouring whose classes are not Borel, or about the plain chromatic number.

**Models.** `TowerRatio p 1` (`towerRatio_one`) satisfies the hypotheses of every theorem here; with it the conclusions are
`haar p I ≤ 1` and `1 ≤ k`. A measurable independent set: the empty set, or any single point (no unit vector is `0`). A
Borel colouring of the p-adic plane, the one binder the vacuity scan reads here (`col`, `GENERIC` in `k`): at `p = 3`,
`k = 3`, `PadicPlane/Upper.exists_borelColoring_of_colorable` with `finitePlane3_colorable_three`, so the hypotheses of
`one_le_mul_of_borelColoring` hold together at `p = 3`, `k = 3`, `c = 1`. At `k` below `⌈1/c⌉` the binder is empty: that is
the theorem.
-/

namespace HadwigerNelson.PadicPlane

open MeasureTheory SimpleGraph Topology
open scoped ENNReal

variable (p : ℕ) [Fact p.Prime]

/-- The Borel σ-algebra of `ℤ_[p]` (Mathlib declares no measurable structure on it). Scoped. -/
noncomputable scoped instance instMeasurableSpacePadicInt : MeasurableSpace ℤ_[p] := borel ℤ_[p]

scoped instance instBorelSpacePadicInt : BorelSpace ℤ_[p] := ⟨rfl⟩

/-- **The Haar probability of `ℤ_p²`**, normalized on the whole compact group. -/
noncomputable def haar : Measure (ℤ_[p] × ℤ_[p]) := Measure.addHaarMeasure ⊤

/-- **The level-`k` residue** `ℤ_p² → (ℤ/p^k)²`, coordinatewise. -/
noncomputable def res (k : ℕ) : ℤ_[p] × ℤ_[p] →+ ZMod (p ^ k) × ZMod (p ^ k) :=
  (PadicInt.toZModPow k).toAddMonoidHom.prodMap (PadicInt.toZModPow k).toAddMonoidHom

theorem res_apply (k : ℕ) (x : ℤ_[p] × ℤ_[p]) :
    res p k x = (PadicInt.toZModPow k x.1, PadicInt.toZModPow k x.2) := rfl

/-- Spec: the residue of `(1, 0)` at level `k` is `(1, 0)`. -/
example (k : ℕ) : res p k (1, 0) = (1, 0) := by simp [res_apply]

/-- Every residue is the residue of a point of `ℤ_p²` (`toZModPow` sends the natural number `x.val` to `x`). -/
theorem res_surjective (k : ℕ) : Function.Surjective (res p k) := by
  sorry

/-- The cosets of `p^k ℤ_p²` are open (the kernel of `toZModPow k` is the ball `‖x‖ ≤ p^{−k}`). -/
theorem isOpen_res_fibre (k : ℕ) (x : ZMod (p ^ k) × ZMod (p ^ k)) : IsOpen (res p k ⁻¹' {x}) := by
  sorry

theorem haar_univ : haar p Set.univ = 1 := by
  sorry

/-- **Every level-`k` coset has measure `p^{−2k}`**: the `p^{2k}` cosets are translates of one another and cover `ℤ_p²`. -/
theorem haar_res_fibre (k : ℕ) (x : ZMod (p ^ k) × ZMod (p ^ k)) :
    haar p (res p k ⁻¹' {x}) = ((p : ℝ≥0∞) ^ (2 * k))⁻¹ := by
  sorry

/-- **Hensel**: at an odd prime every unit vector of `(ℤ/p^k)²` is the residue of a unit vector of `ℤ_p²`. (One coordinate
of a residue unit vector is a unit; fix the other and solve `X² = 1 − a²` by `hensels_lemma`; the root is congruent to the
residue modulo `p^k` because `X + x₀` is a unit.) -/
theorem exists_unitVector_lift (hp : p ≠ 2) (k : ℕ) {t : ZMod (p ^ k) × ZMod (p ^ k)}
    (ht : t.1 ^ 2 + t.2 ^ 2 = 1) : ∃ s : ℤ_[p] × ℤ_[p], s.1 ^ 2 + s.2 ^ 2 = 1 ∧ res p k s = t := by
  sorry

/-- **The well-filled cosets of a measurable independent set are independent**: the level-`k` residues `x` whose coset `I`
fills to more than half form an independent set of `UD(ℤ/p^k, 2)`. -/
theorem isIndepSet_wellFilled (hp : p ≠ 2) {I : Set (ℤ_[p] × ℤ_[p])} (hI : MeasurableSet I)
    (hind : (unitQuadrance ℤ_[p]).IsIndepSet I) (k : ℕ) :
    (unitQuadrance (ZMod (p ^ k))).IsIndepSet
      {x | haar p (res p k ⁻¹' {x}) < 2 * haar p (I ∩ res p k ⁻¹' {x})} := by
  sorry

/-- **Density along cosets** (after `Rigidity/CountCompletion.tendsto_haarK_bad`): the points of a measurable `I` whose
level-`k` coset `I` fills to at most half have measure at most `ε` from some level on. -/
theorem exists_level_haar_bad_le {I : Set (ℤ_[p] × ℤ_[p])} (hI : MeasurableSet I) {ε : ℝ≥0∞} (hε : 0 < ε) :
    ∃ k₀ : ℕ, ∀ k, k₀ ≤ k → haar p {y | y ∈ I ∧
      2 * haar p (I ∩ res p k ⁻¹' {res p k y}) ≤ haar p (res p k ⁻¹' {res p k y})} ≤ ε := by
  sorry

/-- **A measurable independent set of `ℤ_p²` holds at most the tower ratio.** -/
theorem haar_le_of_towerRatio (hp : p ≠ 2) {c : ℝ} (hc : TowerRatio p c) {I : Set (ℤ_[p] × ℤ_[p])}
    (hI : MeasurableSet I) (hind : (unitQuadrance ℤ_[p]).IsIndepSet I) : haar p I ≤ ENNReal.ofReal c := by
  sorry

/-- **A Borel colouring of the p-adic plane with `k` colours has `1 ≤ k·c`** for every tower ratio `c`. -/
theorem one_le_mul_of_borelColoring (hp : p ≠ 2) {c : ℝ} (hc : TowerRatio p c) {k : ℕ}
    (col : (padicPlane p).Coloring (Fin k))
    (hcol : ∀ i, MeasurableSet[borel (ℚ_[p] × ℚ_[p])] (⇑col ⁻¹' {i})) : 1 ≤ (k : ℝ) * c := by
  sorry

/-- **The Borel chromatic number of the p-adic plane is at least `⌈1/c⌉`** for every positive tower ratio `c`. -/
theorem le_borelChromaticNumber_of_towerRatio (hp : p ≠ 2) {c : ℝ} (hc : TowerRatio p c) (hc0 : 0 < c) :
    ((⌈1 / c⌉₊ : ℕ) : ℕ∞) ≤ borelChromaticNumber (padicPlane p) := by
  sorry

end HadwigerNelson.PadicPlane
