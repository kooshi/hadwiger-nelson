import Proofs.HadwigerNelson.Rigidity.CountExtension
import Proofs.HadwigerNelson.Rigidity.PlaneZhang

/-!
# The count: from the slice `Δ × K` down to the finite levels, and `TCA F → R88TCA` (FS-131, job FS131-K12A; module M12, block D; skeleton)

**Read aloud, against the derivation** (R88-TCA; J28D § 3.3: "the count reads `1 = Σ_j p_j ≤ 4 max(α(Y′), r_X) < 1` — no
such `μ`"; FS100-TCA). The headline's hypothesis `hCount : (chainInterface F).Count` is `TCA F → R88TCA`, and this module
proves it over the named outside hypothesis `Plane.OneAvoidingDensityBound` (`[AmbrusEtAl2023]` Thm 1):

* `levelRows φ j k q` — **the descent**: for a colouring `φ` of `ℂ × K`, a colour `j` and a level `k`, the points `z` at
  which colour `j` fills more than three quarters of the level-`k` coset `q` of the fibre `{x : φ(z, x) = j}`. Indexed by the
  finite group `(levR F k).range`, whose connection set is the image of `U` (`[S9]`, `image_levR_unitVectors`).
* `rowsEdgeNull_levelRows` — the level rows have null edges in `UD(ℝ²) ⊗ Cay(level k, U)`: two rows `q`, `q + s` over
  points at distance one share more than half of a coset of `K` after the translation `ιK u` (`u ↦ s`), so a positive
  measure of them would give the slice a positive measure of monochromatic edges.
* `volume_colour_le` — the window measure of colour `j` is at most the level rows' (each coset has measure `1/|level k|`)
  plus the points that fill their coset to at most three quarters, which tend to `0` (`tendsto_haarK_bad`).
* `false_of_slice` — **the contradiction**: four colours fill a window of `ℂ × K`; each holds at most
  `max(m₁, c) + ε` of it (`sum_volume_inter_sq_le` with `ratioLe_levR_range`); `m₁ < 1/4` and `c < 1/4`.
* `count_of_oneAvoidingDensityBound` — **the count**: `(chainInterface F).Count`, for every real number field, over
  `Plane.OneAvoidingDensityBound`. It reads `TCA F` through `Rigidity.tca_uniform` (module M13, over Weil's bound) and the
  scope through `noRamifiedStableDyadic_of_tca` — no hypothesis of the count is unread.

**Models.** `false_of_slice` is a step inside a proof by contradiction: its hypotheses are refuted by itself. At `ℚ(√11)`,
where `TCA` fails (the stable prime above `7` has all-levels ratio at least `2/7`, J28D § 3.4), the derivation's control
`⌊4(θ + s)⌋` is an invariant colouring with spectrum on `T + A` — the count's conclusion fails there, as it must.
-/

namespace HadwigerNelson.Rigidity.Counting

open SpectralChain NumberField MeasureTheory Filter Topology Plane

noncomputable section

variable {F : Subfield ℝ} [NumberField F]

/-- The finite group of level `k`, the image of `R`, as a `Fintype` for the descent's sums. -/
noncomputable instance (k : ℕ) : Fintype (levR F k).range.toAddSubgroup := Fintype.ofFinite _

/-- **The level-`k` rows of colour `j`.** -/
def levelRows (φ : ℂ × K F → Fin 4) (j : Fin 4) (k : ℕ) (q : (levR F k).range.toAddSubgroup) : Set ℂ :=
  {z | 3 / 4 * haarK F (proj F k ⁻¹' {(q : Lev F k)}) <
      haarK F ({x | φ (z, x) = j} ∩ proj F k ⁻¹' {(q : Lev F k)})}

theorem measurableSet_levelRows {φ : ℂ × K F → Fin 4} (hφ : Measurable φ) (j : Fin 4) (k : ℕ)
    (q : (levR F k).range.toAddSubgroup) : MeasurableSet (levelRows φ j k q) := by
  sorry

/-- **The level rows have null edges.** -/
theorem rowsEdgeNull_levelRows {φ : ℂ × K F → Fin 4} (hφ : Measurable φ) (h : SliceEdgeNull φ) (j : Fin 4) (k : ℕ) :
    RowsEdgeNull {d : (levR F k).range.toAddSubgroup | (d : Lev F k) ∈ normOneLev F k} (levelRows φ j k) := by
  sorry

/-- **The descent's measure comparison**: colour `j` in the window `sq a s × K` is the level rows plus the badly filled
points. -/
theorem volume_colour_le {φ : ℂ × K F → Fin 4} (hφ : Measurable φ) (j : Fin 4) (k : ℕ) (a : ℂ) (s : ℝ) :
    (volume.prod (haarK F)).real ({p | φ p = j} ∩ sq a s ×ˢ Set.univ) ≤
      (Nat.card (levR F k).range.toAddSubgroup : ℝ)⁻¹ * ∑ q, volume.real (levelRows φ j k q ∩ sq a s) +
        (volume.prod (haarK F)).real {p | p.1 ∈ sq a s ∧ φ p = j ∧
          haarK F ({x | φ (p.1, x) = j} ∩ proj F k ⁻¹' {proj F k p.2}) ≤
            3 / 4 * haarK F (proj F k ⁻¹' {proj F k p.2})} := by
  sorry

/-- The badly filled points of a window tend to `0` with the level. -/
theorem tendsto_bad {φ : ℂ × K F → Fin 4} (hφ : Measurable φ) (j : Fin 4) (a : ℂ) (s : ℝ) :
    Tendsto (fun k => (volume.prod (haarK F)).real {p | p.1 ∈ sq a s ∧ φ p = j ∧
        haarK F ({x | φ (p.1, x) = j} ∩ proj F k ⁻¹' {proj F k p.2}) ≤
          3 / 4 * haarK F (proj F k ⁻¹' {proj F k p.2})}) atTop (𝓝 0) := by
  sorry

/-- **The contradiction**: no measurable four-colouring of the slice has null monochromatic edges, under `TCA F` and
`m₁ < 1/4`. -/
theorem false_of_slice (hT : TCA F) (hm : mOne < ENNReal.ofReal (1 / 4)) {φ : ℂ × K F → Fin 4} (hφ : Measurable φ)
    (h : SliceEdgeNull φ) : False := by
  sorry

/-- **The count** (R88-TCA at `S = ∅`, class form), over the outside theorem `[AmbrusEtAl2023]` Thm 1. -/
theorem count_of_oneAvoidingDensityBound (hOA : Plane.OneAvoidingDensityBound) : (chainInterface F).Count := by
  intro hT μ σ hσ hTA
  obtain ⟨φ, hφ, hnull⟩ := exists_slice μ hσ hTA
  exact false_of_slice hT (Plane.mOne_lt_quarter hOA) hφ hnull

end

end HadwigerNelson.Rigidity.Counting
