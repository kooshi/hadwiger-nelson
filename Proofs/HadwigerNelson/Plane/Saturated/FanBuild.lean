import Proofs.HadwigerNelson.Plane.Saturated.FanArcs

/-!
# The fan at an isolated singular point exists (FS-131 wave 6, FS131-I6D; the proof of FS131-E8-FAN)

`plans/FS131-E8-derivation.md` § 3.6 (`plans/FS131-I6D-implementation.md`):

* `polarPt_norm_arg`, `polarPt_eq_polarPt`, `polarPt_add_int`, `polarGraph_sub_int` — polar coordinates about `z`.
* `isOpen_polarRegion`, `isPreconnected_polarRegion`, `polarRegion_nonempty` — the region between two continuous
  polar graphs is open, connected and not empty.
* `exists_ordered_lifts` — finitely many continuous angles, no two equal modulo `2π` at any distance, can be shifted
  by multiples of `2π` and indexed so that at every distance they increase and lie within one turn.
* `polarRegion_disjoint_polarGraph` — the region between consecutive branches meets no branch.
* **`AeColouring.exists_fan_of_isolated`** — FS131-E8-FAN (the proof of `AeColouring.fan_of_isolated`).
* `isPreconnected_polarGraph`, `AeColouring.Fan.finite_arcs_meeting_ball`, `AeColouring.regJLiteral_of_locallyFinite`,
  `AeColouring.finite_arcs_of_bounded` — FS131-E8-CLAUSE2 (the proofs of `regJLiteral_of_saturated`,
  `finite_arcs_of_isBounded`).

Inhabitant of the hypotheses of `exists_fan_of_isolated`: `sq9` at the grid vertex, `R = 1/4`
(`sq9_singular_near_vertex`, `sq9_tight_saturated`; `sq9_isolatedAt` in `Plane/Saturated/FanBridge`).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

/-! ## Polar coordinates -/

/-- Every point is in polar form about `z`, with its angle measured from any reference direction. -/
theorem polarPt_norm_arg (z w : ℂ) (θ₀ : ℝ) :
    polarPt z ‖w - z‖ (θ₀ + Complex.arg ((w - z) * (starRingEnd ℂ) (e θ₀))) = w := by
  have h1 : ‖(w - z) * (starRingEnd ℂ) (e θ₀)‖ = ‖w - z‖ := by rw [norm_mul, RCLike.norm_conj, norm_e, mul_one]
  have h2 : ((‖w - z‖ : ℝ) : ℂ) * e (Complex.arg ((w - z) * (starRingEnd ℂ) (e θ₀))) =
      (w - z) * (starRingEnd ℂ) (e θ₀) := by
    rw [← h1]; exact Complex.norm_mul_exp_arg_mul_I _
  have h3 := e_mul_conj_e θ₀
  show z + ((‖w - z‖ : ℝ) : ℂ) * e (θ₀ + Complex.arg ((w - z) * (starRingEnd ℂ) (e θ₀))) = w
  rw [e_add, mul_left_comm, h2]
  linear_combination (w - z) * h3

/-- A point in polar form determines its distance, and its angle modulo `2π`. -/
theorem polarPt_eq_polarPt {z : ℂ} {t t' θ θ' : ℝ} (ht : 0 < t) (ht' : 0 < t')
    (h : polarPt z t θ = polarPt z t' θ') : t = t' ∧ ∃ m : ℤ, θ = θ' + m * (2 * Real.pi) := by
  have h1 : t = t' := by
    have h2 := congrArg (fun w => dist w z) h
    simp only [dist_polarPt z ht.le, dist_polarPt z ht'.le] at h2
    exact h2
  subst h1
  refine ⟨rfl, e_eq_e_iff.1 ?_⟩
  have h2 : (t : ℂ) * e θ = (t : ℂ) * e θ' := add_left_cancel (a := z) h
  exact mul_left_cancel₀ (Complex.ofReal_ne_zero.2 ht.ne') h2

/-- A whole number of turns does not move a point in polar form. -/
theorem polarPt_add_int (z : ℂ) (t θ : ℝ) (m : ℤ) : polarPt z t (θ + m * (2 * Real.pi)) = polarPt z t θ := by
  have h : e (θ + m * (2 * Real.pi)) = e θ := e_eq_e_iff.2 ⟨m, rfl⟩
  simp only [polarPt, h]

/-- A polar graph is unchanged when its angle is shifted by a whole number of turns. -/
theorem polarGraph_sub_int (z : ℂ) (r : ℝ) (φ : ℝ → ℝ) (m : ℤ) :
    polarGraph z r (fun t => φ t - m * (2 * Real.pi)) = polarGraph z r φ := by
  have h : ∀ t, polarPt z t (φ t - m * (2 * Real.pi)) = polarPt z t (φ t) := fun t => by
    have := polarPt_add_int z t (φ t) (-m)
    rw [← this]; congr 1; push_cast; ring
  ext w
  constructor
  · rintro ⟨t, ht, rfl⟩; exact ⟨t, ht, h t⟩
  · rintro ⟨t, ht, rfl⟩; exact ⟨t, ht, (h t).symm⟩

/-- **The region between two continuous polar graphs is open.** -/
theorem isOpen_polarRegion (z : ℂ) {r : ℝ} {φ ψ : ℝ → ℝ} (hφ : ContinuousOn φ (Ioo 0 r))
    (hψ : ContinuousOn ψ (Ioo 0 r)) : IsOpen (polarRegion z r φ ψ) := by
  rw [isOpen_iff_mem_nhds]
  rintro _ ⟨t₀, ht₀, θ₀, hθ₀, rfl⟩
  have hw₀ : (polarPt z t₀ θ₀ - z) * (starRingEnd ℂ) (e θ₀) = (t₀ : ℂ) := by
    show (z + (t₀ : ℂ) * e θ₀ - z) * (starRingEnd ℂ) (e θ₀) = (t₀ : ℂ)
    rw [add_sub_cancel_left, mul_assoc, e_mul_conj_e, mul_one]
  have hn₀ : ‖polarPt z t₀ θ₀ - z‖ = t₀ := by rw [norm_polarPt_sub, abs_of_pos ht₀.1]
  have hnorm : Tendsto (fun w : ℂ => ‖w - z‖) (𝓝 (polarPt z t₀ θ₀)) (𝓝 t₀) := by
    have h1 : Continuous fun w : ℂ => ‖w - z‖ := by fun_prop
    have h2 := h1.tendsto (polarPt z t₀ θ₀)
    rwa [hn₀] at h2
  have harg : Tendsto (fun w : ℂ => θ₀ + Complex.arg ((w - z) * (starRingEnd ℂ) (e θ₀)))
      (𝓝 (polarPt z t₀ θ₀)) (𝓝 θ₀) := by
    have hc1 : ContinuousAt Complex.arg ((polarPt z t₀ θ₀ - z) * (starRingEnd ℂ) (e θ₀)) := by
      rw [hw₀]
      exact Complex.continuousAt_arg (Or.inl (by rw [Complex.ofReal_re]; exact ht₀.1))
    have hc2 : Continuous fun w : ℂ => (w - z) * (starRingEnd ℂ) (e θ₀) := by fun_prop
    have h3 := (tendsto_const_nhds (x := θ₀)).add (hc1.tendsto.comp (hc2.tendsto (polarPt z t₀ θ₀)))
    rw [hw₀, Complex.arg_ofReal_of_nonneg ht₀.1.le, add_zero] at h3
    exact h3
  have hI : Ioo 0 r ∈ 𝓝 t₀ := Ioo_mem_nhds ht₀.1 ht₀.2
  have e1 : ∀ᶠ w in 𝓝 (polarPt z t₀ θ₀), ‖w - z‖ ∈ Ioo 0 r := hnorm hI
  have e2 := (((hφ.continuousAt hI).tendsto).comp hnorm).eventually_lt harg hθ₀.1
  have e3 := harg.eventually_lt (((hψ.continuousAt hI).tendsto).comp hnorm) hθ₀.2
  filter_upwards [e1, e2, e3] with w h1 h2 h3
  exact ⟨‖w - z‖, h1, _, ⟨h2, h3⟩, (polarPt_norm_arg z w θ₀).symm⟩

/-- **The region between two continuous polar graphs is connected.** -/
theorem isPreconnected_polarRegion (z : ℂ) {r : ℝ} {φ ψ : ℝ → ℝ} (hφ : ContinuousOn φ (Ioo 0 r))
    (hψ : ContinuousOn ψ (Ioo 0 r)) (hlt : ∀ t ∈ Ioo 0 r, φ t < ψ t) : IsPreconnected (polarRegion z r φ ψ) := by
  have himg : polarRegion z r φ ψ =
      (fun p : ℝ × ℝ => polarPt z p.1 (φ p.1 + p.2 * (ψ p.1 - φ p.1))) '' (Ioo 0 r ×ˢ Ioo (0 : ℝ) 1) := by
    ext w
    constructor
    · rintro ⟨t, ht, θ, hθ, rfl⟩
      have hd := sub_pos.2 (hlt t ht)
      refine ⟨(t, (θ - φ t) / (ψ t - φ t)),
        ⟨ht, div_pos (sub_pos.2 hθ.1) hd, (div_lt_one hd).2 (by linarith [hθ.2])⟩, ?_⟩
      show polarPt z t (φ t + (θ - φ t) / (ψ t - φ t) * (ψ t - φ t)) = _
      rw [div_mul_cancel₀ _ hd.ne']
      congr 1; ring
    · rintro ⟨⟨t, l⟩, ⟨ht, hl⟩, rfl⟩
      have hd := sub_pos.2 (hlt t ht)
      exact ⟨t, ht, _, ⟨by nlinarith [hl.1], by nlinarith [hl.2]⟩, rfl⟩
  rw [himg]
  have h1 : ContinuousOn (fun p : ℝ × ℝ => φ p.1) (Ioo 0 r ×ˢ Ioo (0 : ℝ) 1) :=
    hφ.comp continuousOn_fst fun p hp => hp.1
  have h2 : ContinuousOn (fun p : ℝ × ℝ => ψ p.1) (Ioo 0 r ×ˢ Ioo (0 : ℝ) 1) :=
    hψ.comp continuousOn_fst fun p hp => hp.1
  have h3 : ContinuousOn (fun p : ℝ × ℝ => (p.1, φ p.1 + p.2 * (ψ p.1 - φ p.1))) (Ioo 0 r ×ˢ Ioo (0 : ℝ) 1) :=
    continuousOn_fst.prodMk (h1.add (continuousOn_snd.mul (h2.sub h1)))
  exact (isPreconnected_Ioo.prod isPreconnected_Ioo).image _ ((continuous_polarPt z).comp_continuousOn h3)

/-- The region between two polar graphs, the first below the second, is not empty. -/
theorem polarRegion_nonempty (z : ℂ) {r : ℝ} (hr : 0 < r) {φ ψ : ℝ → ℝ} (hlt : ∀ t ∈ Ioo 0 r, φ t < ψ t) :
    (polarRegion z r φ ψ).Nonempty := by
  have ht : r / 2 ∈ Ioo 0 r := ⟨by linarith, by linarith⟩
  have := hlt _ ht
  exact ⟨_, r / 2, ht, (φ (r / 2) + ψ (r / 2)) / 2, ⟨by linarith, by linarith⟩, rfl⟩

/-! ## Ordering the branches -/

/-- **Finitely many continuous angles on `(0, r)`, no two equal modulo `2π` at any distance, can be shifted by whole
turns and indexed so that at every distance they increase and lie within one turn.** -/
theorem exists_ordered_lifts {ι : Type*} {B : Set ι} (hB : B.Finite) {r : ℝ} (hr : 0 < r) (Φ : ι → ℝ → ℝ)
    (hc : ∀ K ∈ B, ContinuousOn (Φ K) (Ioo 0 r))
    (hne : ∀ K₁ ∈ B, ∀ K₂ ∈ B, ∀ t ∈ Ioo 0 r, ∀ m : ℤ, Φ K₁ t = Φ K₂ t + m * (2 * Real.pi) → K₁ = K₂) :
    ∃ (n : ℕ) (f : Fin n → ι) (m : Fin n → ℤ), (∀ i, f i ∈ B) ∧ (∀ K ∈ B, ∃ i, f i = K) ∧
      (∀ t ∈ Ioo 0 r, StrictMono fun i => Φ (f i) t - m i * (2 * Real.pi)) ∧
      ∀ t ∈ Ioo 0 r, ∀ i j, Φ (f i) t - m i * (2 * Real.pi) < Φ (f j) t - m j * (2 * Real.pi) + 2 * Real.pi := by
  classical
  have hπ := Real.pi_pos
  have ht₀ : r / 2 ∈ Ioo 0 r := ⟨by linarith, by linarith⟩
  set mf : ι → ℤ := fun K => ⌊Φ K (r / 2) / (2 * Real.pi)⌋ with hmf
  set v : ι → ℝ := fun K => Φ K (r / 2) - mf K * (2 * Real.pi) with hv
  have hv0 : ∀ K, 0 ≤ v K ∧ v K < 2 * Real.pi := fun K => by
    have h1 := Int.floor_le (Φ K (r / 2) / (2 * Real.pi))
    have h2 := Int.lt_floor_add_one (Φ K (r / 2) / (2 * Real.pi))
    rw [le_div_iff₀ (by positivity)] at h1
    rw [div_lt_iff₀ (by positivity)] at h2
    constructor <;> simp only [hv, hmf] <;> linarith
  have hvinj : InjOn v B := by
    intro K₁ h₁ K₂ h₂ h12
    refine hne K₁ h₁ K₂ h₂ (r / 2) ht₀ (mf K₁ - mf K₂) ?_
    simp only [hv] at h12
    push_cast
    linarith
  set V : Finset ℝ := hB.toFinset.image v with hV
  set emb := V.orderEmbOfFin rfl with hemb
  have hex : ∀ i : Fin V.card, ∃ K, K ∈ B ∧ v K = emb i := fun i => by
    obtain ⟨K, hK, hKv⟩ := Finset.mem_image.1 (V.orderEmbOfFin_mem rfl i)
    exact ⟨K, hB.mem_toFinset.1 hK, hKv⟩
  choose f hfB hfv using hex
  have hfinj : ∀ i j, f i = f j → i = j := fun i j h => emb.injective (by rw [← hfv i, ← hfv j, h])
  have key : ∀ i j : Fin V.card, i < j → ∀ t ∈ Ioo 0 r,
      0 < (Φ (f j) t - mf (f j) * (2 * Real.pi)) - (Φ (f i) t - mf (f i) * (2 * Real.pi)) ∧
      (Φ (f j) t - mf (f j) * (2 * Real.pi)) - (Φ (f i) t - mf (f i) * (2 * Real.pi)) < 2 * Real.pi := by
    intro i j hij
    set g : ℝ → ℝ := fun t =>
      (Φ (f j) t - mf (f j) * (2 * Real.pi)) - (Φ (f i) t - mf (f i) * (2 * Real.pi)) with hg
    have hgc : ContinuousOn g (Ioo 0 r) :=
      ((hc _ (hfB j)).sub continuousOn_const).sub ((hc _ (hfB i)).sub continuousOn_const)
    have hg0 : 0 < g (r / 2) ∧ g (r / 2) < 2 * Real.pi := by
      have e1 : g (r / 2) = emb j - emb i := by rw [← hfv i, ← hfv j]
      have e2 : emb i < emb j := emb.strictMono hij
      have e3 := hv0 (f i)
      have e4 := hv0 (f j)
      rw [hfv i] at e3
      rw [hfv j] at e4
      rw [e1]
      constructor <;> linarith
    have hgne : ∀ t ∈ Ioo 0 r, g t ≠ 0 ∧ g t ≠ 2 * Real.pi := by
      intro t ht
      constructor
      · intro h0
        have h1 := hne (f j) (hfB j) (f i) (hfB i) t ht (mf (f j) - mf (f i))
          (by simp only [hg] at h0; push_cast; linarith)
        exact hij.ne (hfinj _ _ h1).symm
      · intro h0
        have h1 := hne (f j) (hfB j) (f i) (hfB i) t ht (mf (f j) - mf (f i) + 1)
          (by simp only [hg] at h0; push_cast; linarith)
        exact hij.ne (hfinj _ _ h1).symm
    have hoc := (isPreconnected_Ioo.image g hgc).ordConnected
    intro t ht
    constructor
    · by_contra hle
      rw [not_lt] at hle
      obtain ⟨t', ht', h0⟩ := hoc.out (mem_image_of_mem g ht) (mem_image_of_mem g ht₀) ⟨hle, hg0.1.le⟩
      exact (hgne t' ht').1 h0
    · by_contra hle
      rw [not_lt] at hle
      obtain ⟨t', ht', h0⟩ := hoc.out (mem_image_of_mem g ht₀) (mem_image_of_mem g ht) ⟨hg0.2.le, hle⟩
      exact (hgne t' ht').2 h0
  refine ⟨V.card, f, fun i => mf (f i), hfB, fun K hK => ?_, fun t ht i j hij => ?_, fun t ht i j => ?_⟩
  · have hKV : v K ∈ (V : Set ℝ) := Finset.mem_coe.2 (Finset.mem_image.2 ⟨K, hB.mem_toFinset.2 hK, rfl⟩)
    rw [← Finset.range_orderEmbOfFin V rfl] at hKV
    obtain ⟨i, hi⟩ := hKV
    exact ⟨i, hvinj (hfB i) hK ((hfv i).trans hi)⟩
  · have := (key i j hij t ht).1
    show Φ (f i) t - mf (f i) * (2 * Real.pi) < Φ (f j) t - mf (f j) * (2 * Real.pi)
    linarith
  · rcases lt_trichotomy i j with h | h | h
    · have := (key i j h t ht).1; linarith
    · rw [h]; linarith
    · have := (key j i h t ht).2; linarith

/-- **The region between consecutive branches meets no branch.** -/
theorem polarRegion_disjoint_polarGraph {z : ℂ} {r : ℝ} {n : ℕ} {φ : Fin n → ℝ → ℝ}
    (hmono : ∀ t ∈ Ioo 0 r, StrictMono fun i => φ i t)
    (hwrap : ∀ t ∈ Ioo 0 r, ∀ i j, φ i t < φ j t + 2 * Real.pi) (i j : Fin n) :
    Disjoint (polarRegion z r (φ i) (cyclicNext φ i)) (polarGraph z r (φ j)) := by
  rw [Set.disjoint_left]
  rintro w ⟨t, ht, θ, hθ, rfl⟩ ⟨t', ht', hw⟩
  obtain ⟨rfl, m, hm⟩ := polarPt_eq_polarPt ht.1 ht'.1 hw
  have hπ := Real.pi_pos
  have hM := hmono t ht
  have h0i : φ ⟨0, i.pos⟩ t ≤ φ i t := hM.monotone (Fin.le_def.2 (Nat.zero_le _))
  have h0j : φ ⟨0, i.pos⟩ t ≤ φ j t := hM.monotone (Fin.le_def.2 (Nat.zero_le _))
  have hj2 := hwrap t ht j ⟨0, i.pos⟩
  by_cases h : (i : ℕ) + 1 < n
  · rw [cyclicNext_of_lt _ h] at hθ
    have h1 := hwrap t ht ⟨i + 1, h⟩ ⟨0, i.pos⟩
    have a1 : (-1 : ℝ) < m := by nlinarith [hθ.1, hθ.2]
    have a2 : (m : ℝ) < 1 := by nlinarith [hθ.1, hθ.2]
    have hm0 : m = 0 := by
      have b1 : -1 < m := by exact_mod_cast a1
      have b2 : m < 1 := by exact_mod_cast a2
      omega
    rw [hm0, Int.cast_zero, zero_mul, add_zero] at hm
    rw [hm] at hθ
    have c1 : i < j := hM.lt_iff_lt.1 hθ.1
    have c2 : j < ⟨i + 1, h⟩ := hM.lt_iff_lt.1 hθ.2
    rw [Fin.lt_def] at c1 c2
    simp only at c2
    omega
  · rw [cyclicNext_of_not_lt _ h] at hθ
    have a1 : (-1 : ℝ) < m := by nlinarith [hθ.1, hθ.2]
    have a2 : (m : ℝ) < 1 := by nlinarith [hθ.1, hθ.2]
    have hm0 : m = 0 := by
      have b1 : -1 < m := by exact_mod_cast a1
      have b2 : m < 1 := by exact_mod_cast a2
      omega
    rw [hm0, Int.cast_zero, zero_mul, add_zero] at hm
    rw [hm] at hθ
    have c1 : i < j := hM.lt_iff_lt.1 hθ.1
    rw [Fin.lt_def] at c1
    have := j.2
    omega

/-! ## The fan -/

namespace AeColouring

/-- **FS131-E8-FAN** (the proof of `AeColouring.fan_of_isolated`): if `z` is the only possible singular point of
`B(z, R)` and the colouring is saturated at the essential boundary points of the punctured disc, then `z` has a
fan. -/
theorem exists_fan_of_isolated (c : AeColouring k) {z : ℂ} {R : ℝ} (hR : 0 < R)
    (hS : c.singularSet ∩ ball z R ⊆ {z}) (hsat : SaturatedOn c.cls (ball z R \ {z})) : Nonempty (c.Fan z) := by
  have hR'0 : 0 < min R (1 / 2) := lt_min hR (by norm_num)
  have hR'2 : min R (1 / 2) ≤ 1 / 2 := min_le_right _ _
  have hbb : ball z (min R (1 / 2)) ⊆ ball z R := ball_subset_ball (min_le_left _ _)
  have hS' : c.singularSet ∩ ball z (min R (1 / 2)) ⊆ {z} := fun x hx => hS ⟨hx.1, hbb hx.2⟩
  have hsat' : SaturatedOn c.cls (ball z (min R (1 / 2)) \ {z}) := hsat.mono fun x hx => ⟨hbb hx.1, hx.2⟩
  obtain ⟨hfin, r, hr, hrR, hcl⟩ := finite_components_of_isolated (c := c) hR'0 hR'2 hS' hsat'
  set R' := min R (1 / 2) with hR'
  set E : Set ℂ := c.essBdry ∩ (ball z R' \ {z}) with hE
  have hrR' : r < R' := by linarith
  have hEr : ∀ w ∈ c.essBdry ∩ (ball z r \ {z}), w ∈ E := fun w hw =>
    ⟨hw.1, mem_ball.2 (lt_trans (mem_ball.1 hw.2.1) hrR'), hw.2.2⟩
  set B : Set (Set ℂ) := {K | ∃ w ∈ c.essBdry ∩ (ball z r \ {z}), K = connectedComponentIn E w} with hB
  have hBfin : B.Finite := hfin.subset (by
    rintro K ⟨w, hw, rfl⟩
    exact ⟨w, hEr w hw, rfl, w, mem_connectedComponentIn (hEr w hw),
      mem_closedBall.2 (by have := mem_ball.1 hw.2.1; linarith)⟩)
  have hbeta : ∀ K ∈ B, ∃ (φ : ℝ → ℝ) (d : ℝ), ContinuousOn φ (Ioo 0 R') ∧ Tendsto φ (𝓝[>] 0) (𝓝 d) ∧
      K = polarGraph z R' φ := by
    rintro K ⟨w, hw, rfl⟩
    exact exists_polarGraph_of_isolated hR'2 hS' hsat' (hEr w hw) (hcl w hw)
  choose! Φ D hΦc hΦt hΦg using hbeta
  have hKeq : ∀ K₁ ∈ B, ∀ K₂ ∈ B, ∀ p, p ∈ K₁ → p ∈ K₂ → K₁ = K₂ := by
    rintro _ ⟨w₁, hw₁, rfl⟩ _ ⟨w₂, hw₂, rfl⟩ p hp₁ hp₂
    exact (connectedComponentIn_eq hp₁).trans (connectedComponentIn_eq hp₂).symm
  obtain ⟨n, f, m, hfB, hfsurj, hmono, hwrap⟩ := exists_ordered_lifts hBfin hr Φ
    (fun K hK => (hΦc K hK).mono (Ioo_subset_Ioo le_rfl hrR'.le))
    (fun K₁ h₁ K₂ h₂ t ht m hm => by
      have ht' : t ∈ Ioo 0 R' := ⟨ht.1, ht.2.trans hrR'⟩
      refine hKeq K₁ h₁ K₂ h₂ (polarPt z t (Φ K₁ t)) ?_ ?_
      · have hmem : polarPt z t (Φ K₁ t) ∈ polarGraph z R' (Φ K₁) := ⟨t, ht', rfl⟩
        rw [← hΦg K₁ h₁] at hmem
        exact hmem
      · have hmem : polarPt z t (Φ K₁ t) ∈ polarGraph z R' (Φ K₂) :=
          ⟨t, ht', by rw [hm]; exact polarPt_add_int z t _ m⟩
        rw [← hΦg K₂ h₂] at hmem
        exact hmem)
  set φ : Fin n → ℝ → ℝ := fun i t => Φ (f i) t - m i * (2 * Real.pi) with hφ
  have hgraph : ∀ i, polarGraph z R' (φ i) = f i := fun i => by
    rw [hΦg _ (hfB i)]; exact polarGraph_sub_int z R' _ (m i)
  have hφc : ∀ i, ContinuousOn (φ i) (Ioo 0 r) := fun i =>
    ((hΦc _ (hfB i)).mono (Ioo_subset_Ioo le_rfl hrR'.le)).sub continuousOn_const
  have hsing : c.singularSet ∩ ball z r ⊆ {z} := fun x hx => hS' ⟨hx.1, ball_subset_ball hrR'.le hx.2⟩
  have hbdry : c.essBdry ∩ (ball z r \ {z}) = ⋃ i, polarGraph z r (φ i) := by
    apply subset_antisymm
    · intro w hw
      obtain ⟨i, hi⟩ := hfsurj _ ⟨w, hw, rfl⟩
      have hwK : w ∈ polarGraph z R' (φ i) := by
        rw [hgraph i, hi]; exact mem_connectedComponentIn (hEr w hw)
      obtain ⟨t, ht, rfl⟩ := hwK
      refine mem_iUnion.2 ⟨i, t, ⟨ht.1, ?_⟩, rfl⟩
      have := mem_ball.1 hw.2.1
      rwa [dist_polarPt z ht.1.le] at this
    · intro w hw
      obtain ⟨i, hi⟩ := mem_iUnion.1 hw
      refine ⟨?_, polarGraph_subset _ _ _ hi⟩
      obtain ⟨t, ht, rfl⟩ := hi
      have h1 : polarPt z t (φ i t) ∈ f i := by
        rw [← hgraph i]; exact ⟨t, ⟨ht.1, ht.2.trans hrR'⟩, rfl⟩
      obtain ⟨w', hw', hfw⟩ := hfB i
      rw [hfw] at h1
      exact (connectedComponentIn_subset _ _ h1).1
  have hnext_c : ∀ i, ContinuousOn (cyclicNext φ i) (Ioo 0 r) := fun i => by
    by_cases h : (i : ℕ) + 1 < n
    · rw [show cyclicNext φ i = φ ⟨i + 1, h⟩ from funext fun t => cyclicNext_of_lt _ h t]
      exact hφc _
    · rw [show cyclicNext φ i = fun t => φ ⟨0, i.pos⟩ t + 2 * Real.pi from
        funext fun t => cyclicNext_of_not_lt _ h t]
      exact (hφc _).add continuousOn_const
  have hnext_lt : ∀ i, ∀ t ∈ Ioo 0 r, φ i t < cyclicNext φ i t := fun i t ht => by
    by_cases h : (i : ℕ) + 1 < n
    · rw [cyclicNext_of_lt _ h]
      exact hmono t ht (Fin.lt_def.2 (Nat.lt_succ_self _))
    · rw [cyclicNext_of_not_lt _ h]
      exact hwrap t ht i _
  have hregion : ∀ i, ∃ j, (polarRegion z r (φ i) (cyclicNext φ i) : Set ℂ) ≤ᵐ[volume] c.cls j := fun i => by
    refine c.ae_one_colour_of_isConnected (isOpen_polarRegion z (hφc i) (hnext_c i))
      ⟨polarRegion_nonempty z hr (hnext_lt i), isPreconnected_polarRegion z (hφc i) (hnext_c i) (hnext_lt i)⟩ ?_ ?_
    · rw [Set.disjoint_left]
      intro w hw hwb
      have hw' := polarRegion_subset _ _ _ _ hw
      have h1 : w ∈ ⋃ j, polarGraph z r (φ j) := by rw [← hbdry]; exact ⟨hwb, hw'⟩
      obtain ⟨j, hj⟩ := mem_iUnion.1 h1
      exact Set.disjoint_left.1 (polarRegion_disjoint_polarGraph hmono hwrap i j) hw hj
    · rw [Set.disjoint_left]
      intro w hw hwc
      have hw' := polarRegion_subset _ _ _ _ hw
      exact hw'.2 (hsing ⟨cuspSet_subset_singularSet _ hwc, hw'.1⟩)
  choose col hcol using hregion
  exact ⟨{ r := r, r_pos := hr, n := n, φ := φ, dir := fun i => D (f i) - m i * (2 * Real.pi), col := col,
           cont := hφc, tendsto := fun i => (hΦt _ (hfB i)).sub_const _, mono := hmono, wrap := hwrap,
           singular := hsing, bdry := hbdry, region := hcol }⟩

/-! ## FS131-E8-CLAUSE2 -/

/-- A continuous polar graph is connected. -/
theorem _root_.HadwigerNelson.Plane.isPreconnected_polarGraph (z : ℂ) {r : ℝ} {φ : ℝ → ℝ}
    (hφ : ContinuousOn φ (Ioo 0 r)) : IsPreconnected (polarGraph z r φ) := by
  have himg : polarGraph z r φ = (fun t => polarPt z t (φ t)) '' Ioo 0 r := by
    ext w
    constructor
    · rintro ⟨t, ht, rfl⟩; exact ⟨t, ht, rfl⟩
    · rintro ⟨t, ht, rfl⟩; exact ⟨t, ht, rfl⟩
  rw [himg]
  exact isPreconnected_Ioo.image _ ((continuous_polarPt z).comp_continuousOn (continuousOn_id.prodMk hφ))

/-- **Finitely many interface arcs meet the disc of a fan**: each one that meets it off the centre holds a whole
branch. No saturation is read. Inhabitant: `sq9Fan` (`Plane/Saturated/FanExamples`). -/
theorem Fan.finite_arcs_meeting_ball {c : AeColouring k} {z : ℂ} (F : c.Fan z) :
    {A : Set ℂ | (∃ y ∈ c.interfaceSet, A = connectedComponentIn c.interfaceSet y) ∧
      (A ∩ ball z F.r).Nonempty}.Finite := by
  have hr2 : F.r / 2 ∈ Ioo 0 F.r := ⟨by linarith [F.r_pos], by linarith [F.r_pos]⟩
  refine ((Set.finite_range fun i : Fin F.n =>
    connectedComponentIn c.interfaceSet (polarPt z (F.r / 2) (F.φ i (F.r / 2)))).union
    (Set.finite_singleton (connectedComponentIn c.interfaceSet z))).subset ?_
  rintro A ⟨⟨y, hy, rfl⟩, p, hpA, hpb⟩
  have hpI : p ∈ c.interfaceSet := connectedComponentIn_subset _ _ hpA
  have hAp : connectedComponentIn c.interfaceSet y = connectedComponentIn c.interfaceSet p :=
    connectedComponentIn_eq hpA
  by_cases hpz : p = z
  · right
    rw [mem_singleton_iff, hAp, hpz]
  · left
    have hp' : p ∈ c.essBdry ∩ (ball z F.r \ {z}) := ⟨hpI.1, hpb, hpz⟩
    rw [F.bdry] at hp'
    obtain ⟨i, hi⟩ := mem_iUnion.1 hp'
    refine ⟨i, ?_⟩
    have hsub := (isPreconnected_polarGraph z (F.cont i)).subset_connectedComponentIn hi
      (F.branch_subset_interfaceSet i)
    have hq : polarPt z (F.r / 2) (F.φ i (F.r / 2)) ∈ connectedComponentIn c.interfaceSet p :=
      hsub ⟨_, hr2, rfl⟩
    show connectedComponentIn c.interfaceSet (polarPt z (F.r / 2) (F.φ i (F.r / 2))) =
      connectedComponentIn c.interfaceSet y
    rw [hAp]
    exact (connectedComponentIn_eq hq).symm

/-- **FS131-E8-CLAUSE2**, first clause (the proof of `AeColouring.regJLiteral_of_saturated`). -/
theorem regJLiteral_of_locallyFinite (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) :
    c.RegJLiteral := by
  refine ⟨hS, fun z _ => ?_⟩
  obtain ⟨R, hR, hsub⟩ := hS.exists_ball_subset z
  obtain ⟨F⟩ := c.exists_fan_of_isolated hR hsub (hsat.saturatedOn _)
  refine F.finite_arcs_meeting_ball.subset ?_
  rintro A ⟨hA, hz⟩
  obtain ⟨p, hp, hpz⟩ := Metric.mem_closure_iff.1 hz F.r F.r_pos
  exact ⟨hA, p, hp, mem_ball.2 (by rwa [dist_comm] at hpz)⟩

/-- **FS131-E8-CLAUSE2**, second clause (the proof of `AeColouring.finite_arcs_of_isBounded`): every point has a fan
(singular or not), a bounded set is covered by finitely many of their discs, and each disc meets finitely many
arcs. -/
theorem finite_arcs_of_bounded (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite)
    {K : Set ℂ} (hK : Bornology.IsBounded K) :
    {A : Set ℂ | (∃ y ∈ c.interfaceSet, A = connectedComponentIn c.interfaceSet y) ∧ (A ∩ K).Nonempty}.Finite := by
  have hfan : ∀ x : ℂ, Nonempty (c.Fan x) := fun x => by
    obtain ⟨R, hR, hsub⟩ := hS.exists_ball_subset x
    exact c.exists_fan_of_isolated hR hsub (hsat.saturatedOn _)
  have F : ∀ x : ℂ, c.Fan x := fun x => (hfan x).some
  obtain ⟨t, -, htcover⟩ := hK.isCompact_closure.elim_nhds_subcover (fun x => ball x (F x).r)
    fun x _ => ball_mem_nhds x (F x).r_pos
  refine (t.finite_toSet.biUnion fun x _ => (F x).finite_arcs_meeting_ball).subset ?_
  rintro A ⟨hA, p, hpA, hpK⟩
  obtain ⟨x, hxt, hpx⟩ := mem_iUnion₂.1 (htcover (subset_closure hpK))
  exact mem_iUnion₂.2 ⟨x, hxt, hA, p, hpA, hpx⟩

end AeColouring

end HadwigerNelson.Plane
