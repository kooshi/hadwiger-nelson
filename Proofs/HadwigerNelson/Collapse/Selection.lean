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

**Models.** `selCol` is defined for every measurable `φ`. `SliceEdgeNullK` and thickness hold together at `ℚ(√635087)`
(`c = 2√103/104 = 0.1952`) for the slice of any of its colourings — with seven colours by the plane's seven-colouring
(`Bridge.chromaticNumber_complex_le_seven`, `exists_slice_of_colorable`) — and that model fails the window: at `k = 7`,
`c/(1 + c) > 1/7` and `c(k − 1) > 1`. With the window, the hypotheses of `unitPairsNull_selCol` and
`exists_aeColouring_of_slice` at once are inhabited by no object of the library: at `ℚ(√635087)` the window asks `k ≤ 6`; at
`k ≤ 5` they are empty given `Outside.OAI158.no_proper_five_coloring` (the conclusion would give `χ(ℝ²) ≤ 5`); at `k = 6` their
joint satisfiability is `χ(ℝ²) ≤ 6`, the open question (`exists_slice_of_colorable` from a six-colouring of the plane one way,
this theorem and N-EASY the other). A field all of whose stable primes have residue size `Q²` with `Q ≥ 142` is uniformly
thick below `1/6` (Weil) and would inhabit them at `k = 7`; none is stated here. The adversary is `ℚ(√11)`: its stable prime above
`2` has the dyadic target `K₄`, `λ* = 1/3` (V1's control K2), so it is `c`-thick for no `c < 1/3`, and at `k = 4` the residue
four-colouring's slice has every fibre of mass `1/4 = c/(1 + c)` at `c = 1/3` — the threshold window `(c/(1 + c), 1/k)` is empty,
as `χ(ℚ(√11)²) = 4 < χ(ℝ²)` requires.
-/

namespace HadwigerNelson.Collapse

open SpectralChain NumberField Rigidity Rigidity.Counting MeasureTheory Filter Topology Plane

noncomputable section

variable {F : Subfield ℝ} [NumberField F] {k : ℕ}

-- FS131-ICO2: the proofs. The fibre masses are Tonelli's sections of `φ ⁻¹' {j}`; `ae_slice_edge` carries `SliceEdgeNullK`
-- from `(ℂ × K) × ℝ` to `(ℂ × ℝ) × K` by one measure-preserving reorder and reads it fibre by fibre; the selection is
-- measurable because it factors through the finite `Fin k → Bool` of which colours are heavy.

/-- **The fibre mass** of colour `j` over `z`: the Haar measure of `{x ∈ K : φ(z, x) = j}`. -/
def fibreMass (φ : ℂ × K F → Fin k) (z : ℂ) (j : Fin k) : ℝ := (haarK F {x | φ (z, x) = j}).toReal

/-- The fibre masses are measurable in `z` (Tonelli: `measurable_measure_prodMk_left` on the fibre of a measurable set). -/
theorem measurable_fibreMass {φ : ℂ × K F → Fin k} (hφ : Measurable φ) (j : Fin k) :
    Measurable fun z => fibreMass φ z j :=
  (measurable_measure_prodMk_left (ν := haarK F) (hφ (measurableSet_singleton j))).ennreal_toReal

/-- The fibre masses over `z` sum to `1` (the fibres partition `K`, a probability space). -/
theorem sum_fibreMass {φ : ℂ × K F → Fin k} (hφ : Measurable φ) (z : ℂ) : ∑ j, fibreMass φ z j = 1 := by
  have hm : Measurable fun x : K F => φ (z, x) := hφ.comp measurable_prodMk_left
  have hsum := sum_measure_preimage_singleton (μ := haarK F) Finset.univ (fun j _ => hm (measurableSet_singleton j))
  rw [Finset.coe_univ, Set.preimage_univ, measure_univ] at hsum
  unfold fibreMass
  rw [← ENNReal.toReal_sum fun j _ => measure_ne_top _ _]
  exact (congrArg ENNReal.toReal hsum).trans ENNReal.toReal_one

/-- **For almost every `(z, θ)` the fibres at the two ends of the unit pair have null edges** across every unit vector:
Tonelli on `SliceEdgeNullK` (reorder `((ℂ × K) × ℝ)` to `(ℂ × ℝ) × K`), one unit vector at a time, then countably many. -/
theorem ae_slice_edge {φ : ℂ × K F → Fin k} (hφ : Measurable φ) (hnull : SliceEdgeNullK F φ) :
    ∀ᵐ p ∂(volume.prod arcLength), ∀ u ∈ unitVectorsR F,
      haarK F {x | φ (p.1, x) = φ (p.1 + e p.2, x + ιK F u)} = 0 := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  -- the reorder `((z, θ), x) ↦ ((z, x), θ)` is measure-preserving
  have hT : MeasurePreserving (fun q : (ℂ × ℝ) × K F => ((q.1.1, q.2), q.1.2))
      ((volume.prod arcLength).prod (haarK F)) ((volume.prod (haarK F)).prod arcLength) := by
    have h1 := measurePreserving_prodAssoc (volume : Measure ℂ) arcLength (haarK F)
    have h2 := (MeasurePreserving.id (volume : Measure ℂ)).prod
      (Measure.measurePreserving_swap (μ := arcLength) (ν := haarK F))
    have h3 := (measurePreserving_prodAssoc (volume : Measure ℂ) (haarK F) arcLength).symm
    exact (h3.comp h2).comp h1
  have hu : ∀ u ∈ unitVectorsR F, ∀ᵐ p ∂(volume.prod arcLength),
      haarK F {x | φ (p.1, x) = φ (p.1 + e p.2, x + ιK F u)} = 0 := by
    intro u hu
    set S : Set ((ℂ × K F) × ℝ) := {p | φ p.1 = φ (p.1.1 + e p.2, p.1.2 + ιK F u)} with hS
    have hm2 : Measurable fun p : (ℂ × K F) × ℝ => φ (p.1.1 + e p.2, p.1.2 + ιK F u) :=
      hφ.comp (((measurable_fst.comp measurable_fst).add (continuous_e.measurable.comp measurable_snd)).prodMk
        ((measurable_snd.comp measurable_fst).add_const _))
    have hSm : MeasurableSet S := measurableSet_eq_fun (hφ.comp measurable_fst) hm2
    have h0 : ((volume.prod arcLength).prod (haarK F)) ((fun q : (ℂ × ℝ) × K F => ((q.1.1, q.2), q.1.2)) ⁻¹' S) = 0 := by
      rw [hT.measure_preimage hSm.nullMeasurableSet]
      exact hnull u hu
    filter_upwards [(Measure.measure_prod_null (hSm.preimage hT.measurable)).mp h0] with p hp
    exact hp
  have hall : ∀ᵐ p ∂(volume.prod arcLength), ∀ u : unitVectorsR F,
      haarK F {x | φ (p.1, x) = φ (p.1 + e p.2, x + ιK F u)} = 0 :=
    ae_all_iff.mpr fun u => hu u u.2
  filter_upwards [hall] with p hp u hu'
  exact hp ⟨u, hu'⟩

/-- **No colour is heavy at both ends of a null-edge pair**: if the fibres over `z` and `w` have null edges across every unit
vector, no colour has mass at least `θ₀ > c/(1 + c)` over both (`mixing_K` on the two fibres of colour `j`). -/
theorem not_both_heavy {c θ₀ : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c) (hc : c < 1) (hθ : c / (1 + c) < θ₀)
    {φ : ℂ × K F → Fin k} (hφ : Measurable φ) {z w : ℂ}
    (hzw : ∀ u ∈ unitVectorsR F, haarK F {x | φ (z, x) = φ (w, x + ιK F u)} = 0) (j : Fin k) :
    ¬ (θ₀ ≤ fibreMass φ z j ∧ θ₀ ≤ fibreMass φ w j) := by
  rintro ⟨hz, hw⟩
  have hA : MeasurableSet {x : K F | φ (z, x) = j} := (hφ.comp measurable_prodMk_left) (measurableSet_singleton j)
  have hB : MeasurableSet {x : K F | φ (w, x) = j} := (hφ.comp measurable_prodMk_left) (measurableSet_singleton j)
  have hnull : ∀ u ∈ unitVectorsR F,
      haarK F ({x | φ (z, x) = j} ∩ (fun x => x + ιK F u) ⁻¹' {x | φ (w, x) = j}) = 0 := by
    intro u hu
    refine measure_mono_null (fun x hx => ?_) (hzw u hu)
    exact hx.1.trans hx.2.symm
  have hmix := mixing_K hT hc0 hc hA hB hnull
  exact not_both_ge_of_mixing hc0 hθ hz hw measureReal_le_one measureReal_le_one hmix

open Classical in
/-- **The selection**: the least colour whose fibre has mass at least `θ₀` (`0` if none — which `θ₀ < 1/k` rules out). -/
def selCol [NeZero k] (φ : ℂ × K F → Fin k) (θ₀ : ℝ) (z : ℂ) : Fin k :=
  if h : (Finset.univ.filter fun j => θ₀ ≤ fibreMass φ z j).Nonempty then
    (Finset.univ.filter fun j => θ₀ ≤ fibreMass φ z j).min' h else 0

/-- Below `1/k` the selected colour is heavy: some fibre has mass at least `1/k > θ₀` (pigeonhole on `sum_fibreMass`). -/
theorem le_fibreMass_selCol [NeZero k] {φ : ℂ × K F → Fin k} (hφ : Measurable φ) {θ₀ : ℝ} (hθk : θ₀ < 1 / k) (z : ℂ) :
    θ₀ ≤ fibreMass φ z (selCol φ θ₀ z) := by
  classical
  have hk : (0 : ℝ) < k := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne k)
  have hle : ∑ _j : Fin k, (1 / (k : ℝ)) ≤ ∑ j, fibreMass φ z j := by
    rw [sum_fibreMass hφ z, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul,
      mul_one_div_cancel hk.ne']
  obtain ⟨j, -, hj⟩ := Finset.exists_le_of_sum_le Finset.univ_nonempty hle
  have hne : (Finset.univ.filter fun j => θ₀ ≤ fibreMass φ z j).Nonempty :=
    ⟨j, Finset.mem_filter.mpr ⟨Finset.mem_univ j, hθk.le.trans hj⟩⟩
  unfold selCol
  rw [dif_pos hne]
  exact (Finset.mem_filter.mp (Finset.min'_mem _ hne)).2

/-- The selection is measurable (each class is a Boolean combination of the measurable sets `{z | θ₀ ≤ fibreMass φ z j}`). -/
theorem measurable_selCol [NeZero k] {φ : ℂ × K F → Fin k} (hφ : Measurable φ) (θ₀ : ℝ) : Measurable (selCol φ θ₀) := by
  classical
  set G : ℂ → Fin k → Bool := fun z j => decide (θ₀ ≤ fibreMass φ z j) with hG
  have hGm : Measurable G := by
    refine measurable_pi_iff.mpr fun j => measurable_to_bool ?_
    have : (fun z => G z j) ⁻¹' {true} = {z | θ₀ ≤ fibreMass φ z j} := by
      ext z; simp [hG]
    rw [this]
    exact measurableSet_le measurable_const (measurable_fibreMass hφ j)
  set H : (Fin k → Bool) → Fin k := fun b =>
    if h : (Finset.univ.filter fun j => b j = true).Nonempty then (Finset.univ.filter fun j => b j = true).min' h
    else 0 with hH
  have hsel : selCol φ θ₀ = H ∘ G := by
    funext z
    simp only [selCol, hH, hG, Function.comp_apply, decide_eq_true_eq]
  rw [hsel]
  exact (measurable_of_finite H).comp hGm

/-- **Every class of the selection has null unit pairs**: at almost every `(z, θ)` the fibres at the two ends have null edges
(`ae_slice_edge`), and a colour selected at both ends would be heavy at both (`le_fibreMass_selCol`, `not_both_heavy`). -/
theorem unitPairsNull_selCol [NeZero k] {c θ₀ : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c) (hc : c < 1)
    (hθ : c / (1 + c) < θ₀) (hθk : θ₀ < 1 / k) {φ : ℂ × K F → Fin k} (hφ : Measurable φ)
    (hnull : SliceEdgeNullK F φ) (j : Fin k) : UnitPairsNull (selCol φ θ₀ ⁻¹' {j}) := by
  have hae := ae_slice_edge hφ hnull
  rw [ae_iff] at hae
  refine measure_mono_null ?_ hae
  intro p hp hall
  have h1 : selCol φ θ₀ p.1 = j := hp.1
  have h2 : selCol φ θ₀ (p.1 + e p.2) = j := hp.2
  have ha := le_fibreMass_selCol hφ hθk p.1
  have hb := le_fibreMass_selCol hφ hθk (p.1 + e p.2)
  rw [h1] at ha
  rw [h2] at hb
  exact not_both_heavy hT hc0 hc hθ hφ hall j ⟨ha, hb⟩

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
  simp [fibreMass]

end

end HadwigerNelson.Collapse
