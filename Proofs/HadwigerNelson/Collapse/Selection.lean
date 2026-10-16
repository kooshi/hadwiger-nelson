import Proofs.HadwigerNelson.Collapse.Slice
import Proofs.HadwigerNelson.Collapse.Mixing
import Proofs.HadwigerNelson.Plane.AeColouring

/-!
# The mixing selection: a slice colouring of `ℂ × K` gives a measurable colouring of the plane proper at almost every unit pair (FS-131, job FS131-KCL1; module C6)

**Read aloud, against the informal claim** (FS103-SEL; V1-L6, `plans/FS103-V1-verification.md` ll. 143–158; V2 L3, ll. 153–160):
"if `X × ∏_v K_v` carries a CP random map whose fibre colour-measure vector `x ↦ (Haar{b : C(x, b) = j})_j` has disjoint
supports at every edge …, and `sup_v λ*_v < 1/(k−1)`, then `X` has a CP `k`-colouring; … the colour count entering only at the
covering pigeonhole `max_j m_j ≥ 1/k`" (`plans/FS103-derivation.md` § 1). Here, over a uniformly `c`-thick field with
`c(k − 1) < 1`:

* `fibreMass φ z j` — the Haar measure of the fibre `{x ∈ K : φ(z, x) = j}`; measurable in `z`, summing to `1` over `j`.
* `ae_slice_edge` — for almost every `(z, θ)`, the fibres of `z` and of `z + e^{iθ}` have null edges across every unit vector
  (Tonelli on `SliceEdgeNullK`; the unit vectors are countable).
* `selCol φ θ₀` — the least colour whose fibre has mass at least `θ₀`; for `c/(1 + c) < θ₀ < 1/k` it exists at every `z`
  (pigeonhole), it is measurable, and no colour is selected at both ends of almost any unit pair (`Collapse.mixing_K` and
  `not_both_ge_of_mixing`) — so its classes have null unit pairs.
* `exists_aeColouring_of_slice` — **an `AeColouring k` of the plane**: the library's `χ_m⁰` object (`Plane/AeColouring`).

**The format.** The derivation selects with a random threshold to keep continuity in probability (the CP format, `χ_CP`). The
library's number is `χ_m⁰(ℝ²)`, whose colourings need only measurability and properness at almost every unit pair; a fixed
threshold suffices, and N-EASY (`Plane.chromaticNumber_plane_le_chiM0`) turns the colouring into `χ(ℝ²) ≤ k`.

**Models.** `selCol` is defined for every measurable `φ`; its hypotheses (`SliceEdgeNullK` and thickness) hold together at
`ℚ(√635087)` for the slice of any of its colourings (`Collapse/Headline`). The adversary is `ℚ(√11)`: its stable prime above
`2` has the dyadic target `K₄`, `λ* = 1/3` (V1's control K2), so it is `c`-thick for no `c < 1/3`, and at `k = 4` the residue
four-colouring's slice has every fibre of mass `1/4 = c/(1 + c)` at `c = 1/3` — the threshold window `(c/(1 + c), 1/k)` is empty,
as `χ(ℚ(√11)²) = 4 < χ(ℝ²)` requires.
-/

namespace HadwigerNelson.Collapse

open SpectralChain NumberField Rigidity Rigidity.Counting MeasureTheory Filter Topology Plane

noncomputable section

variable {F : Subfield ℝ} [NumberField F] {k : ℕ}

/-- **The fibre mass** of colour `j` over `z`: the Haar measure of `{x ∈ K : φ(z, x) = j}`. -/
def fibreMass (φ : ℂ × K F → Fin k) (z : ℂ) (j : Fin k) : ℝ := (haarK F {x | φ (z, x) = j}).toReal

/-- The fibre masses are measurable in `z` (Tonelli: `measurable_measure_prodMk_left` on the fibre of a measurable set). -/
theorem measurable_fibreMass {φ : ℂ × K F → Fin k} (hφ : Measurable φ) (j : Fin k) :
    Measurable fun z => fibreMass φ z j := by
  sorry

/-- The fibre masses over `z` sum to `1` (the fibres partition `K`, a probability space). -/
theorem sum_fibreMass {φ : ℂ × K F → Fin k} (hφ : Measurable φ) (z : ℂ) : ∑ j, fibreMass φ z j = 1 := by
  sorry

/-- **For almost every `(z, θ)` the fibres at the two ends of the unit pair have null edges** across every unit vector:
Tonelli on `SliceEdgeNullK` (reorder `((ℂ × K) × ℝ)` to `(ℂ × ℝ) × K`), one unit vector at a time, then countably many. -/
theorem ae_slice_edge {φ : ℂ × K F → Fin k} (hφ : Measurable φ) (hnull : SliceEdgeNullK F φ) :
    ∀ᵐ p ∂(volume.prod arcLength), ∀ u ∈ unitVectorsR F,
      haarK F {x | φ (p.1, x) = φ (p.1 + e p.2, x + ιK F u)} = 0 := by
  sorry

/-- **No colour is heavy at both ends of a null-edge pair**: if the fibres over `z` and `w` have null edges across every unit
vector, no colour has mass at least `θ₀ > c/(1 + c)` over both (`mixing_K` on the two fibres of colour `j`). -/
theorem not_both_heavy {c θ₀ : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c) (hc : c < 1) (hθ : c / (1 + c) < θ₀)
    {φ : ℂ × K F → Fin k} (hφ : Measurable φ) {z w : ℂ}
    (hzw : ∀ u ∈ unitVectorsR F, haarK F {x | φ (z, x) = φ (w, x + ιK F u)} = 0) (j : Fin k) :
    ¬ (θ₀ ≤ fibreMass φ z j ∧ θ₀ ≤ fibreMass φ w j) := by
  sorry

open Classical in
/-- **The selection**: the least colour whose fibre has mass at least `θ₀` (`0` if none — which `θ₀ < 1/k` rules out). -/
def selCol [NeZero k] (φ : ℂ × K F → Fin k) (θ₀ : ℝ) (z : ℂ) : Fin k :=
  if h : (Finset.univ.filter fun j => θ₀ ≤ fibreMass φ z j).Nonempty then
    (Finset.univ.filter fun j => θ₀ ≤ fibreMass φ z j).min' h else 0

/-- Below `1/k` the selected colour is heavy: some fibre has mass at least `1/k > θ₀` (pigeonhole on `sum_fibreMass`). -/
theorem le_fibreMass_selCol [NeZero k] {φ : ℂ × K F → Fin k} (hφ : Measurable φ) {θ₀ : ℝ} (hθk : θ₀ < 1 / k) (z : ℂ) :
    θ₀ ≤ fibreMass φ z (selCol φ θ₀ z) := by
  sorry

/-- The selection is measurable (each class is a Boolean combination of the measurable sets `{z | θ₀ ≤ fibreMass φ z j}`). -/
theorem measurable_selCol [NeZero k] {φ : ℂ × K F → Fin k} (hφ : Measurable φ) (θ₀ : ℝ) : Measurable (selCol φ θ₀) := by
  sorry

/-- **Every class of the selection has null unit pairs**: at almost every `(z, θ)` the fibres at the two ends have null edges
(`ae_slice_edge`), and a colour selected at both ends would be heavy at both (`le_fibreMass_selCol`, `not_both_heavy`). -/
theorem unitPairsNull_selCol [NeZero k] {c θ₀ : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c) (hc : c < 1)
    (hθ : c / (1 + c) < θ₀) (hθk : θ₀ < 1 / k) {φ : ℂ × K F → Fin k} (hφ : Measurable φ)
    (hnull : SliceEdgeNullK F φ) (j : Fin k) : UnitPairsNull (selCol φ θ₀ ⁻¹' {j}) := by
  sorry

/-- **The mixing selection**: over a uniformly `c`-thick field with `c(k − 1) < 1`, a slice `k`-colouring gives a measurable
`k`-colouring of the plane proper at almost every unit pair. The threshold is `θ₀ = (c/(1 + c) + 1/k)/2`. -/
theorem exists_aeColouring_of_slice {c : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c) (hk : 2 ≤ k)
    (hck : c * ((k : ℝ) - 1) < 1) {φ : ℂ × K F → Fin k} (hφ : Measurable φ) (hnull : SliceEdgeNullK F φ) :
    Nonempty (AeColouring k) := by
  haveI : NeZero k := ⟨by omega⟩
  have hkr : (2 : ℝ) ≤ k := by exact_mod_cast hk
  have hc : c < 1 := by nlinarith
  have hgap : c / (1 + c) < 1 / k := by
    rw [div_lt_div_iff₀ (by linarith) (by linarith)]
    nlinarith
  set θ₀ := (c / (1 + c) + 1 / k) / 2 with hθ₀
  exact ⟨⟨selCol φ θ₀, measurable_selCol hφ θ₀,
    unitPairsNull_selCol hT hc0 hc (by linarith) (by linarith) hφ hnull⟩⟩

/-! ## Spec -/

-- a constant slice colouring puts all the mass on its colour: `fibreMass` would drift if it measured anything else.
example (j : Fin 3) (z : ℂ) : fibreMass (F := F) (fun _ : ℂ × Counting.K F => j) z j = 1 := by
  sorry

end

end HadwigerNelson.Collapse
