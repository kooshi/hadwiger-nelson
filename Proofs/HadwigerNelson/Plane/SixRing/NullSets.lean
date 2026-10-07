import Proofs.HadwigerNelson.Plane.SixRing.Basic
import Mathlib.MeasureTheory.Measure.Hausdorff

/-!
# Null sets on the line, in the plane and in the space of triples: the measure-theoretic tools of the exclusion (FS-132)

Helpers of job FS132-I4 for the leaves of `ChartMeasure`, `State`, `Excl` and `Kill`. **No colouring, no chart and no
palette**: every statement is about Lebesgue measure on `ℝ`, `ℝ × ℝ` or `ℝ × ℝ × ℝ`, or about one-dimensional
Hausdorff measure in the plane.

* `shear_measurePreserving` — the shear `(a, w) ↦ (a + f w, w)` of the space of triples preserves measure; with it
  `quasiMeasurePreserving_triple_fst`, `_snd`, `_add`: the maps under which the leaves pull an almost-everywhere
  statement about angles or about chart coordinates back to the triples `(α, d, d')`.
* `change_of_ae_flip` — a change point moves with a flip (the derivation's step M1, "each `ψ_k` is an essential
  change point", one step of its induction).
* `exists_inter_pos_of_ae_union` — the ring form's connectedness argument.
* `volume_preimage_inter_le_hausdorff`, `lipschitzWith_add_e`, `hausdorffMeasure_add_e_image_eq_zero` — an expanding
  map from a set of the line onto an arc of a unit circle pulls null sets of directions back to null sets (the
  derivation's step M7, "for fixed `z` the point `z′` moves along the unit circle about `z`").
* `exists_mem_Ioo_of_ae` — an almost-everywhere statement holds somewhere in every interval (the Fubini sections of
  the kill, step M9); `exists_pos_forall_le` — finitely many positive numbers have a positive lower bound.
-/

open MeasureTheory Set
open scoped NNReal

namespace HadwigerNelson.SixRing

/-! ## Shears and projections of `ℝ × ℝ × ℝ` -/

/-- The shear `(a, w) ↦ (a + f w, w)` of `ℝ × (ℝ × ℝ)` by a measurable function of the last two coordinates preserves
Lebesgue measure: for each `w` it is a translation of the first coordinate. -/
theorem shear_measurePreserving {f : ℝ × ℝ → ℝ} (hf : Measurable f) :
    MeasurePreserving (fun y : ℝ × ℝ × ℝ => (y.1 + f y.2, y.2)) volume volume := by
  have hskew : MeasurePreserving (fun q : (ℝ × ℝ) × ℝ => (q.1, q.2 + f q.1))
      ((volume : Measure (ℝ × ℝ)).prod (volume : Measure ℝ)) ((volume : Measure (ℝ × ℝ)).prod volume) :=
    (MeasurePreserving.id volume).skew_product (g := fun w a => a + f w)
      (measurable_snd.add (hf.comp measurable_fst))
      (ae_of_all _ fun w => (measurePreserving_add_right volume (f w)).map_eq)
  exact (Measure.measurePreserving_swap.comp hskew).comp Measure.measurePreserving_swap

/-- Forgetting the last coordinate of a triple pulls null sets of the plane back to null sets. -/
theorem quasiMeasurePreserving_triple_fst :
    Measure.QuasiMeasurePreserving (fun y : ℝ × ℝ × ℝ => (y.1, y.2.1)) volume volume :=
  QuasiMeasurePreserving.prodMap (Measure.QuasiMeasurePreserving.id _) Measure.quasiMeasurePreserving_fst

/-- Forgetting the middle coordinate of a triple pulls null sets of the plane back to null sets. -/
theorem quasiMeasurePreserving_triple_snd :
    Measure.QuasiMeasurePreserving (fun y : ℝ × ℝ × ℝ => (y.1, y.2.2)) volume volume :=
  QuasiMeasurePreserving.prodMap (Measure.QuasiMeasurePreserving.id _) Measure.quasiMeasurePreserving_snd

/-- A translate of the first coordinate by a measurable function of the other two, as a map to the line, pulls null
sets back to null sets. -/
theorem quasiMeasurePreserving_triple_add {f : ℝ × ℝ → ℝ} (hf : Measurable f) :
    Measure.QuasiMeasurePreserving (fun y : ℝ × ℝ × ℝ => y.1 + f y.2) volume volume :=
  Measure.quasiMeasurePreserving_fst.comp (shear_measurePreserving hf).quasiMeasurePreserving

/-! ## Change points -/

/-- **A change point moves with a flip.** If near `t` almost every `θ` has `θ + a ∈ T` exactly when `θ ∉ S`, and every
neighbourhood of `t` meets `S` and its complement in positive measure, then every neighbourhood of `t + a` meets `T`
and its complement in positive measure. -/
theorem change_of_ae_flip {S T : Set ℝ} {t a δ : ℝ} (hδ : 0 < δ)
    (hflip : ∀ᵐ θ : ℝ, |θ - t| < δ → (θ + a ∈ T ↔ θ ∉ S))
    (hS : ∀ η : ℝ, 0 < η → 0 < volume (S ∩ Ioo (t - η) (t + η)) ∧ 0 < volume (Sᶜ ∩ Ioo (t - η) (t + η))) :
    ∀ η : ℝ, 0 < η → 0 < volume (T ∩ Ioo (t + a - η) (t + a + η)) ∧
      0 < volume (Tᶜ ∩ Ioo (t + a - η) (t + a + η)) := by
  intro η hη
  have hη' : 0 < min η δ := lt_min hη hδ
  obtain ⟨h1, h2⟩ := hS (min η δ) hη'
  have key : ∀ U V : Set ℝ, (∀ᵐ θ : ℝ, |θ - t| < δ → θ ∈ V → θ + a ∈ U) →
      volume (V ∩ Ioo (t - min η δ) (t + min η δ)) ≤ volume (U ∩ Ioo (t + a - η) (t + a + η)) := by
    intro U V hUV
    calc volume (V ∩ Ioo (t - min η δ) (t + min η δ))
        ≤ volume ((fun θ => θ + a) ⁻¹' (U ∩ Ioo (t + a - η) (t + a + η))) := by
          apply measure_mono_ae
          filter_upwards [hUV] with θ hθ hmem
          obtain ⟨hV, hI⟩ := hmem
          have hlt : |θ - t| < δ := by
            rw [abs_lt]
            constructor <;> linarith [hI.1, hI.2, min_le_right η δ]
          exact ⟨hθ hlt hV, by linarith [hI.1, min_le_left η δ], by linarith [hI.2, min_le_left η δ]⟩
      _ = volume (U ∩ Ioo (t + a - η) (t + a + η)) := measure_preimage_add_right volume a _
  exact ⟨h2.trans_le (key T Sᶜ (hflip.mono fun θ hθ hlt hV => (hθ hlt).mpr hV)),
    h1.trans_le (key Tᶜ S (hflip.mono fun θ hθ hlt hV hT => (hθ hlt).mp hT hV))⟩

/-- **Two sets that cover almost all of the line, neither null, meet in positive measure near one point** (the
ring form's "the set of `θ` near which `s` is almost everywhere constant is open; were it the whole circle, `s` would
be almost everywhere constant by connectedness"): there is `ψ` every neighbourhood of which meets both in positive
measure. -/
theorem exists_inter_pos_of_ae_union {A B : Set ℝ} (hAB : ∀ᵐ θ : ℝ, θ ∈ A ∨ θ ∈ B)
    (hA : volume A ≠ 0) (hB : volume B ≠ 0) :
    ∃ ψ : ℝ, ∀ η : ℝ, 0 < η →
      0 < volume (A ∩ Ioo (ψ - η) (ψ + η)) ∧ 0 < volume (B ∩ Ioo (ψ - η) (ψ + η)) := by
  by_contra hno
  have hno' : ∀ ψ : ℝ, ∃ η : ℝ, 0 < η ∧
      (volume (A ∩ Ioo (ψ - η) (ψ + η)) = 0 ∨ volume (B ∩ Ioo (ψ - η) (ψ + η)) = 0) := by
    intro ψ
    by_contra hψ
    refine hno ⟨ψ, fun η hη => ?_⟩
    by_contra hη2
    refine hψ ⟨η, hη, ?_⟩
    by_contra h3
    exact hη2 ⟨pos_iff_ne_zero.mpr fun h => h3 (Or.inl h), pos_iff_ne_zero.mpr fun h => h3 (Or.inr h)⟩
  have hopen : ∀ C : Set ℝ, IsOpen {ψ : ℝ | ∃ η : ℝ, 0 < η ∧ volume (C ∩ Ioo (ψ - η) (ψ + η)) = 0} := by
    intro C
    rw [Metric.isOpen_iff]
    rintro ψ ⟨η, hη, h0⟩
    refine ⟨η / 2, half_pos hη, fun ψ' hψ' => ⟨η / 2, half_pos hη, ?_⟩⟩
    have hd := abs_lt.mp (show |ψ' - ψ| < η / 2 from hψ')
    exact measure_mono_null (inter_subset_inter_right _
      (Ioo_subset_Ioo (by linarith [hd.1]) (by linarith [hd.2]))) h0
  have hcover : (univ : Set ℝ) ⊆ {ψ : ℝ | ∃ η : ℝ, 0 < η ∧ volume (B ∩ Ioo (ψ - η) (ψ + η)) = 0} ∪
      {ψ : ℝ | ∃ η : ℝ, 0 < η ∧ volume (A ∩ Ioo (ψ - η) (ψ + η)) = 0} := by
    intro ψ _
    obtain ⟨η, hη, h | h⟩ := hno' ψ
    · exact Or.inr ⟨η, hη, h⟩
    · exact Or.inl ⟨η, hη, h⟩
  have hdisj : ¬ ((univ : Set ℝ) ∩ ({ψ : ℝ | ∃ η : ℝ, 0 < η ∧ volume (B ∩ Ioo (ψ - η) (ψ + η)) = 0} ∩
      {ψ : ℝ | ∃ η : ℝ, 0 < η ∧ volume (A ∩ Ioo (ψ - η) (ψ + η)) = 0})).Nonempty := by
    rintro ⟨ψ, -, ⟨η₁, hη₁, h1⟩, ⟨η₂, hη₂, h2⟩⟩
    have hI : volume (Ioo (ψ - min η₁ η₂) (ψ + min η₁ η₂)) ≤
        volume (B ∩ Ioo (ψ - η₁) (ψ + η₁)) + volume (A ∩ Ioo (ψ - η₂) (ψ + η₂)) := by
      refine (measure_mono_ae ?_).trans (measure_union_le _ _)
      filter_upwards [hAB] with θ hθ hI
      rcases hθ with h | h
      · exact Or.inr ⟨h, by linarith [hI.1, min_le_right η₁ η₂], by linarith [hI.2, min_le_right η₁ η₂]⟩
      · exact Or.inl ⟨h, by linarith [hI.1, min_le_left η₁ η₂], by linarith [hI.2, min_le_left η₁ η₂]⟩
    rw [h1, h2, add_zero, Real.volume_Ioo, nonpos_iff_eq_zero, ENNReal.ofReal_eq_zero] at hI
    linarith [lt_min hη₁ hη₂]
  have hpre := isPreconnected_univ (α := ℝ) _ _ (hopen B) (hopen A) hcover
  have hnull : ∀ C : Set ℝ, (∀ x : ℝ, ∃ η : ℝ, 0 < η ∧ volume (C ∩ Ioo (x - η) (x + η)) = 0) → volume C = 0 := by
    intro C hC
    refine measure_null_of_locally_null C fun x _ => ?_
    obtain ⟨η, hη, h0⟩ := hC x
    exact ⟨C ∩ Ioo (x - η) (x + η),
      inter_mem_nhdsWithin C (Ioo_mem_nhds (by linarith) (by linarith)), h0⟩
  by_cases hUA : ((univ : Set ℝ) ∩ {ψ : ℝ | ∃ η : ℝ, 0 < η ∧ volume (B ∩ Ioo (ψ - η) (ψ + η)) = 0}).Nonempty
  · by_cases hUB : ((univ : Set ℝ) ∩ {ψ : ℝ | ∃ η : ℝ, 0 < η ∧ volume (A ∩ Ioo (ψ - η) (ψ + η)) = 0}).Nonempty
    · exact hdisj (hpre hUA hUB)
    · exact hB (hnull B fun x => (hcover (mem_univ x)).resolve_right fun h => hUB ⟨x, mem_univ x, h⟩)
  · exact hA (hnull A fun x => (hcover (mem_univ x)).resolve_left fun h => hUA ⟨x, mem_univ x, h⟩)

/-! ## Arcs: a one-dimensional pull-back through an expanding map into the plane -/

/-- A map from a set of the line into a metric space that does not contract distances by more than a factor `K`
pulls sets of one-dimensional Hausdorff measure zero back to Lebesgue-null sets. (The form of the release's
`line_volume_preimage_bound`, with the target any metric space.) -/
theorem volume_preimage_inter_le_hausdorff {E : Type*} [MetricSpace E] [MeasurableSpace E] [BorelSpace E]
    {F : ℝ → E} {s : Set ℝ} {K : ℝ≥0} (hF : AntilipschitzWith K (s.restrict F)) (A : Set E) :
    volume (F ⁻¹' A ∩ s) ≤ (K : ENNReal) * μH[1] A := by
  have he : Subtype.val '' ((s.restrict F) ⁻¹' A) = F ⁻¹' A ∩ s := by
    ext x
    constructor
    · rintro ⟨q, hq, rfl⟩; exact ⟨hq, q.2⟩
    · rintro ⟨hx, hs⟩; exact ⟨⟨x, hs⟩, hx, rfl⟩
  have hi := (isometry_subtype_coe : Isometry (Subtype.val : s → ℝ)).hausdorffMeasure_image
    (Or.inl (by norm_num : (0 : ℝ) ≤ 1)) ((s.restrict F) ⁻¹' A)
  have ha := hF.hausdorffMeasure_preimage_le (by norm_num : (0 : ℝ) ≤ 1) A
  rw [he, hausdorffMeasure_real] at hi
  rw [← hi, ENNReal.rpow_one] at ha
  exact ha

/-- The unit circle about `z`, parametrized by the angle, is `1`-Lipschitz. -/
theorem lipschitzWith_add_e (z : ℂ) : LipschitzWith 1 fun θ : ℝ => z + Plane.e θ := by
  refine LipschitzWith.of_dist_le_mul fun a b => ?_
  rw [dist_add_left, NNReal.coe_one, one_mul, dist_eq_norm, Real.dist_eq]
  have h : Plane.e a - Plane.e b = Plane.e b * (Complex.exp (Complex.I * ((a - b : ℝ) : ℂ)) - 1) := by
    have hab : Plane.e a = Plane.e b * Plane.e (a - b) := by rw [← Plane.e_add]; congr 1; ring
    rw [hab, Plane.e, Plane.e, mul_comm Complex.I]
    ring
  rw [h, norm_mul, Plane.norm_e, one_mul]
  exact Real.norm_exp_I_mul_ofReal_sub_one_le

/-- The points of the unit circle about `z` at the angles of a Lebesgue-null set have one-dimensional Hausdorff
measure zero. -/
theorem hausdorffMeasure_add_e_image_eq_zero (z : ℂ) {N : Set ℝ} (hN : volume N = 0) :
    μH[1] ((fun θ : ℝ => z + Plane.e θ) '' N) = 0 := by
  have h := (lipschitzWith_add_e z).hausdorffMeasure_image_le (by norm_num : (0 : ℝ) ≤ 1) N
  rw [hausdorffMeasure_real, hN, mul_zero] at h
  exact nonpos_iff_eq_zero.mp h

/-- A statement that holds for almost every real number holds at some point of every non-empty open interval. -/
theorem exists_mem_Ioo_of_ae {a b : ℝ} (hab : a < b) {P : ℝ → Prop} (h : ∀ᵐ x : ℝ, P x) : ∃ x ∈ Ioo a b, P x := by
  refine Measure.exists_mem_of_measure_ne_zero_of_ae ?_ (ae_restrict_of_ae h)
  rw [Real.volume_Ioo, Ne, ENNReal.ofReal_eq_zero, not_le]
  linarith

/-- A positive lower bound for finitely many positive numbers. -/
theorem exists_pos_forall_le {ι : Type*} [Finite ι] {κ : ι → ℝ} (h : ∀ i, 0 < κ i) :
    ∃ κ₀ : ℝ, 0 < κ₀ ∧ ∀ i, κ₀ ≤ κ i := by
  rcases isEmpty_or_nonempty ι with hι | hι
  · exact ⟨1, one_pos, fun i => (hι.false i).elim⟩
  · obtain ⟨i₀, hi₀⟩ := Finite.exists_min κ
    exact ⟨κ i₀, h i₀, hi₀⟩

end HadwigerNelson.SixRing
