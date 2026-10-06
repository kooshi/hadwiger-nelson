import Proofs.HadwigerNelson.Plane.Saturated.FanBridge

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

/-! ## Polar coordinates about a point (FS131-I6E) -/

/-- The polar angle of `w` about `z`, in the lift near `θ₀`. -/
noncomputable def polarAngle (z : ℂ) (θ₀ : ℝ) (w : ℂ) : ℝ := θ₀ + Complex.arg ((w - z) * (starRingEnd ℂ) (e θ₀))

/-- A point other than `z` is its own polar point. -/
theorem polarPt_dist_polarAngle (z : ℂ) (θ₀ : ℝ) (w : ℂ) : polarPt z (dist w z) (polarAngle z θ₀ w) = w := by
  set u : ℂ := (w - z) * (starRingEnd ℂ) (e θ₀) with hu
  have hnu : ‖u‖ = dist w z := by rw [hu, norm_mul, RingHomIsometric.norm_map, norm_e, mul_one, dist_eq_norm]
  have h1 : ((dist w z : ℝ) : ℂ) * e (Complex.arg u) = u := by
    rw [← hnu, e]; exact Complex.norm_mul_exp_arg_mul_I u
  have h2 : e θ₀ * u = w - z := by rw [hu, mul_comm (w - z), ← mul_assoc, e_mul_conj_e, one_mul]
  rw [polarPt, polarAngle, e_add, mul_left_comm, h1, h2]; ring

/-- The polar angle of a polar point in the lift near its own angle. -/
theorem polarAngle_polarPt (z : ℂ) {t : ℝ} (ht : 0 < t) (θ : ℝ) : polarAngle z θ (polarPt z t θ) = θ := by
  have : (polarPt z t θ - z) * (starRingEnd ℂ) (e θ) = (t : ℂ) := by
    rw [polarPt, add_sub_cancel_left, mul_assoc, e_mul_conj_e, mul_one]
  rw [polarAngle, this, Complex.arg_ofReal_of_nonneg ht.le, add_zero]

/-- The polar angle is continuous at a polar point in the lift near its own angle. -/
theorem continuousAt_polarAngle (z : ℂ) {t : ℝ} (ht : 0 < t) (θ : ℝ) :
    ContinuousAt (polarAngle z θ) (polarPt z t θ) := by
  have h1 : (polarPt z t θ - z) * (starRingEnd ℂ) (e θ) = (t : ℂ) := by
    rw [polarPt, add_sub_cancel_left, mul_assoc, e_mul_conj_e, mul_one]
  have h2 : ContinuousAt Complex.arg ((polarPt z t θ - z) * (starRingEnd ℂ) (e θ)) := by
    rw [h1]; exact Complex.continuousAt_arg (Complex.ofReal_mem_slitPlane.2 ht)
  have h3 : ContinuousAt (fun w : ℂ => (w - z) * (starRingEnd ℂ) (e θ)) (polarPt z t θ) := by fun_prop
  exact continuousAt_const.add (ContinuousAt.comp (f := fun w : ℂ => (w - z) * (starRingEnd ℂ) (e θ)) h2 h3)

/-- **The polar map is open off the centre**: the image of a neighbourhood of `(t, θ)`, `t > 0`, is a neighbourhood
of `z + t e(θ)`. -/
theorem image_polarPt_mem_nhds (z : ℂ) {V : Set (ℝ × ℝ)} {t θ : ℝ} (ht : 0 < t) (hV : V ∈ 𝓝 (t, θ)) :
    (fun q : ℝ × ℝ => polarPt z q.1 q.2) '' V ∈ 𝓝 (polarPt z t θ) := by
  have hc : ContinuousAt (fun w : ℂ => (dist w z, polarAngle z θ w)) (polarPt z t θ) :=
    (continuous_id.dist continuous_const).continuousAt.prodMk (continuousAt_polarAngle z ht θ)
  have h0 : (dist (polarPt z t θ) z, polarAngle z θ (polarPt z t θ)) = (t, θ) := by
    rw [dist_polarPt z ht.le, polarAngle_polarPt z ht]
  have hV' : V ∈ 𝓝 ((fun w : ℂ => (dist w z, polarAngle z θ w)) (polarPt z t θ)) := by
    show V ∈ 𝓝 (dist (polarPt z t θ) z, polarAngle z θ (polarPt z t θ))
    rw [h0]; exact hV
  have h1 : ∀ᶠ w in 𝓝 (polarPt z t θ), (dist w z, polarAngle z θ w) ∈ V := hc hV'
  filter_upwards [h1] with w hw
  exact ⟨_, hw, polarPt_dist_polarAngle z θ w⟩

/-- The open set of polar coordinates `(t, θ)` with `0 < t < r` and `φ t < θ < ψ t`. -/
theorem isOpen_setOf_polar_lt {r : ℝ} {φ ψ : ℝ → ℝ} (hφ : ContinuousOn φ (Ioo 0 r)) (hψ : ContinuousOn ψ (Ioo 0 r)) :
    IsOpen {q : ℝ × ℝ | q.1 ∈ Ioo 0 r ∧ φ q.1 < q.2 ∧ q.2 < ψ q.1} := by
  have hS : IsOpen {q : ℝ × ℝ | q.1 ∈ Ioo 0 r} := isOpen_Ioo.preimage continuous_fst
  have hm : MapsTo (Prod.fst : ℝ × ℝ → ℝ) {q : ℝ × ℝ | q.1 ∈ Ioo 0 r} (Ioo 0 r) := fun q hq => hq
  have h1 : ContinuousOn (fun q : ℝ × ℝ => q.2 - φ q.1) {q : ℝ × ℝ | q.1 ∈ Ioo 0 r} :=
    continuous_snd.continuousOn.sub (hφ.comp continuous_fst.continuousOn hm)
  have h2 : ContinuousOn (fun q : ℝ × ℝ => ψ q.1 - q.2) {q : ℝ × ℝ | q.1 ∈ Ioo 0 r} :=
    (hψ.comp continuous_fst.continuousOn hm).sub continuous_snd.continuousOn
  have h3 := (h1.isOpen_inter_preimage hS isOpen_Ioi (t := Ioi 0)).inter
    (h2.isOpen_inter_preimage hS isOpen_Ioi (t := Ioi 0))
  convert h3 using 1
  ext q
  simp only [mem_setOf_eq, mem_inter_iff, mem_preimage, mem_Ioi, sub_pos]
  tauto

/-- A polar region is the image of its set of polar coordinates. -/
theorem polarRegion_eq_image (z : ℂ) (r : ℝ) (φ ψ : ℝ → ℝ) :
    polarRegion z r φ ψ =
      (fun q : ℝ × ℝ => polarPt z q.1 q.2) '' {q : ℝ × ℝ | q.1 ∈ Ioo 0 r ∧ φ q.1 < q.2 ∧ q.2 < ψ q.1} := by
  ext w
  constructor
  · rintro ⟨t, ht, θ, hθ, rfl⟩
    exact ⟨(t, θ), ⟨ht, hθ.1, hθ.2⟩, rfl⟩
  · rintro ⟨⟨t, θ⟩, ⟨ht, h1, h2⟩, rfl⟩
    exact ⟨t, ht, θ, ⟨h1, h2⟩, rfl⟩

/-- **A polar region between two continuous graphs is open.** -/
theorem isOpen_polarRegion (z : ℂ) {r : ℝ} {φ ψ : ℝ → ℝ} (hφ : ContinuousOn φ (Ioo 0 r))
    (hψ : ContinuousOn ψ (Ioo 0 r)) : IsOpen (polarRegion z r φ ψ) := by
  rw [polarRegion_eq_image, isOpen_iff_mem_nhds]
  rintro _ ⟨⟨t, θ⟩, hq, rfl⟩
  exact image_polarPt_mem_nhds z hq.1.1 ((isOpen_setOf_polar_lt hφ hψ).mem_nhds hq)

/-- **A polar region between two continuous graphs, one below the other, is preconnected.** -/
theorem isPreconnected_polarRegion (z : ℂ) {r : ℝ} {φ ψ : ℝ → ℝ} (hφ : ContinuousOn φ (Ioo 0 r))
    (hψ : ContinuousOn ψ (Ioo 0 r)) (hlt : ∀ t ∈ Ioo 0 r, φ t < ψ t) : IsPreconnected (polarRegion z r φ ψ) := by
  have him : polarRegion z r φ ψ =
      (fun q : ℝ × ℝ => polarPt z q.1 (φ q.1 + q.2 * (ψ q.1 - φ q.1))) '' (Ioo 0 r ×ˢ Ioo 0 1) := by
    ext w
    constructor
    · rintro ⟨t, ht, θ, hθ, rfl⟩
      have hpos : 0 < ψ t - φ t := sub_pos.2 (hlt t ht)
      refine ⟨(t, (θ - φ t) / (ψ t - φ t)), ⟨ht, div_pos (sub_pos.2 hθ.1) hpos, ?_⟩, ?_⟩
      · rw [div_lt_one hpos]; linarith [hθ.2]
      · simp only
        rw [div_mul_cancel₀ _ hpos.ne']; ring_nf
    · rintro ⟨⟨t, s⟩, ⟨ht, hs⟩, rfl⟩
      have hpos : 0 < ψ t - φ t := sub_pos.2 (hlt t ht)
      refine ⟨t, ht, φ t + s * (ψ t - φ t), ⟨?_, ?_⟩, rfl⟩
      · have := mul_pos hs.1 hpos; linarith
      · have := mul_lt_mul_of_pos_right hs.2 hpos; linarith
  rw [him]
  refine (isPreconnected_Ioo.prod isPreconnected_Ioo).image _ ?_
  have hm : MapsTo (Prod.fst : ℝ × ℝ → ℝ) (Ioo 0 r ×ˢ Ioo (0 : ℝ) 1) (Ioo 0 r) := fun q hq => hq.1
  have h1 : ContinuousOn (fun q : ℝ × ℝ => (q.1, φ q.1 + q.2 * (ψ q.1 - φ q.1))) (Ioo 0 r ×ˢ Ioo (0 : ℝ) 1) :=
    continuous_fst.continuousOn.prodMk ((hφ.comp continuous_fst.continuousOn hm).add
      (continuous_snd.continuousOn.mul ((hψ.comp continuous_fst.continuousOn hm).sub
        (hφ.comp continuous_fst.continuousOn hm))))
  exact (continuous_polarPt z).comp_continuousOn h1

/-- A polar point a full turn on is the same point. -/
theorem polarPt_add_two_pi (z : ℂ) (t θ : ℝ) : polarPt z t (θ + 2 * Real.pi) = polarPt z t θ := by
  rw [polarPt, polarPt, e_add_two_pi]

/-- A polar region out to a smaller radius is a subset. -/
theorem polarRegion_mono (z : ℂ) {ρ r : ℝ} (h : ρ ≤ r) (φ ψ : ℝ → ℝ) : polarRegion z ρ φ ψ ⊆ polarRegion z r φ ψ := by
  rintro w ⟨t, ht, θ, hθ, rfl⟩
  exact ⟨t, ⟨ht.1, lt_of_lt_of_le ht.2 h⟩, θ, hθ, rfl⟩

/-- The centre is in the closure of a polar region out to a positive radius whose lower graph is below its upper. -/
theorem mem_closure_polarRegion (z : ℂ) {r : ℝ} (hr : 0 < r) {φ ψ : ℝ → ℝ} (hlt : ∀ t ∈ Ioo 0 r, φ t < ψ t) :
    z ∈ closure (polarRegion z r φ ψ) := by
  rw [Metric.mem_closure_iff]
  intro ε hε
  have ht : min ε r / 2 ∈ Ioo 0 r :=
    ⟨half_pos (lt_min hε hr), by have := min_le_right ε r; linarith [lt_min hε hr]⟩
  refine ⟨polarPt z (min ε r / 2) ((φ (min ε r / 2) + ψ (min ε r / 2)) / 2), ⟨_, ht, _, ⟨?_, ?_⟩, rfl⟩, ?_⟩
  · linarith [hlt _ ht]
  · linarith [hlt _ ht]
  · rw [dist_comm, dist_polarPt z ht.1.le]
    have := min_le_left ε r; linarith [lt_min hε hr]

/-- **The essential boundary of a measurable set is null** (Lebesgue's density theorem, for the set and for its
complement). -/
theorem volume_essBoundary {A : Set ℂ} (hA : MeasurableSet A) : volume (essBoundary A) = 0 := by
  refine measure_mono_null (t := (A \ densitySet A) ∪ (Aᶜ \ densitySet Aᶜ)) ?_
    (measure_union_null (volume_diff_densitySet hA) (volume_diff_densitySet hA.compl))
  rintro x ⟨hx1, hx2⟩
  by_cases hxA : x ∈ A
  · exact Or.inl ⟨hxA, hx2⟩
  · exact Or.inr ⟨hxA, fun h => notMem_essClosure_of_mem_densitySet hA.compl disjoint_compl_left h hx1⟩

/-- The essential boundary of a colouring is null. -/
theorem AeColouring.volume_essBdry (c : AeColouring k) : volume c.essBdry = 0 :=
  measure_iUnion_null fun j => volume_essBoundary (c.measurableSet_cls j)

namespace AeColouring

variable {c : AeColouring k} {z : ℂ}

namespace Fan

variable (F : c.Fan z)

/-- The angle of the next branch is continuous. -/
theorem continuousOn_cyclicNext (i : Fin F.n) : ContinuousOn (cyclicNext F.φ i) (Ioo 0 F.r) := by
  by_cases h : (i : ℕ) + 1 < F.n
  · have h1 : cyclicNext F.φ i = F.φ ⟨i + 1, h⟩ := funext fun t => cyclicNext_of_lt _ h t
    rw [h1]; exact F.cont _
  · have h1 : cyclicNext F.φ i = fun t => F.φ ⟨0, i.pos⟩ t + 2 * Real.pi :=
      funext fun t => cyclicNext_of_not_lt _ h t
    rw [h1]; exact (F.cont _).add continuousOn_const

/-- A cell of a fan is open. -/
theorem isOpen_cell (i : Fin F.n) : IsOpen (F.cell i) :=
  isOpen_polarRegion z (F.cont i) (F.continuousOn_cyclicNext i)

/-- **A cell of a fan is preconnected** — out to any radius `ρ ≤ F.r` (the first of the three cell lemmas). -/
theorem isPreconnected_polarRegion_of_le (i : Fin F.n) {ρ : ℝ} (hρ : ρ ≤ F.r) :
    IsPreconnected (polarRegion z ρ (F.φ i) (cyclicNext F.φ i)) :=
  isPreconnected_polarRegion z ((F.cont i).mono (Ioo_subset_Ioo_right hρ))
    ((F.continuousOn_cyclicNext i).mono (Ioo_subset_Ioo_right hρ))
    fun _ ht => F.φ_lt_cyclicNext i (Ioo_subset_Ioo_right hρ ht)

/-- **A cell of a fan is preconnected** (the first of the three cell lemmas). -/
theorem isPreconnected_cell (i : Fin F.n) : IsPreconnected (F.cell i) :=
  F.isPreconnected_polarRegion_of_le i le_rfl

/-- **A cell of a fan lies in the density set of its colour** (the second of the three cell lemmas). -/
theorem cell_subset_densitySet (i : Fin F.n) : F.cell i ⊆ densitySet (c.cls (F.col i)) :=
  subset_densitySet_of_isOpen_ae_subset (F.isOpen_cell i) (F.region i)

/-- **A cell of a fan holds the initial part of each ray strictly between its two limit directions** (the third of
the three cell lemmas). -/
theorem exists_ray_subset_cell (i : Fin F.n) {θ : ℝ} (h1 : F.dir i < θ) (h2 : θ < F.nextDir i) :
    ∃ ε > 0, ∀ t ∈ Ioo 0 ε, polarPt z t θ ∈ F.cell i := by
  have e1 : ∀ᶠ t in 𝓝[>] (0 : ℝ), F.φ i t < θ := (F.tendsto i).eventually (eventually_lt_nhds h1)
  have e2 : ∀ᶠ t in 𝓝[>] (0 : ℝ), θ < cyclicNext F.φ i t := (F.tendsto_cyclicNext i).eventually (eventually_gt_nhds h2)
  obtain ⟨ε, hε, hsub⟩ := (mem_nhdsGT_iff_exists_Ioo_subset).1 ((e1.and e2).and (Ioo_mem_nhdsGT F.r_pos))
  exact ⟨ε, hε, fun t ht => ⟨t, (hsub ht).2, θ, ⟨(hsub ht).1.1, (hsub ht).1.2⟩, rfl⟩⟩

/-- The centre of a fan is in the closure of each cell, out to any positive radius. -/
theorem mem_closure_polarRegion_of_le (i : Fin F.n) {ρ : ℝ} (hρ0 : 0 < ρ) (hρ : ρ ≤ F.r) :
    z ∈ closure (polarRegion z ρ (F.φ i) (cyclicNext F.φ i)) :=
  mem_closure_polarRegion z hρ0 fun _ ht => F.φ_lt_cyclicNext i (Ioo_subset_Ioo_right hρ ht)

/-- The cell clockwise of branch `i` is the polar region between a continuous graph below branch `i` and branch `i`
(the branch before, or the last branch a turn back). -/
theorem exists_lower_of_pred {i j : Fin F.n} (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n)) :
    ∃ lo : ℝ → ℝ, ContinuousOn lo (Ioo 0 F.r) ∧ (∀ t ∈ Ioo 0 F.r, lo t < F.φ i t) ∧
      (∀ ρ, polarRegion z ρ lo (F.φ i) = polarRegion z ρ (F.φ j) (cyclicNext F.φ j)) := by
  rcases hij with hij | ⟨hi0, hjn⟩
  · have hlt : (j : ℕ) + 1 < F.n := by rw [hij]; exact i.2
    have hi : (⟨j + 1, hlt⟩ : Fin F.n) = i := Fin.ext hij
    have h1 : cyclicNext F.φ j = F.φ i := funext fun t => by rw [cyclicNext_of_lt _ hlt, hi]
    refine ⟨F.φ j, F.cont j, fun t ht => F.mono t ht (Fin.lt_def.2 (by omega)), fun ρ => by rw [h1]⟩
  · have hnlt : ¬ (j : ℕ) + 1 < F.n := by omega
    have hi : (⟨0, j.pos⟩ : Fin F.n) = i := Fin.ext hi0.symm
    have h1 : cyclicNext F.φ j = fun t => F.φ i t + 2 * Real.pi :=
      funext fun t => by rw [cyclicNext_of_not_lt _ hnlt, hi]
    refine ⟨fun t => F.φ j t - 2 * Real.pi, (F.cont j).sub continuousOn_const,
      fun t ht => by linarith [F.wrap t ht j i], fun ρ => ?_⟩
    rw [h1]
    ext w
    constructor
    · rintro ⟨t, ht, θ, hθ, rfl⟩
      exact ⟨t, ht, θ + 2 * Real.pi, ⟨by linarith [hθ.1], by linarith [hθ.2]⟩, (polarPt_add_two_pi z t θ).symm⟩
    · rintro ⟨t, ht, θ, hθ, rfl⟩
      refine ⟨t, ht, θ - 2 * Real.pi, ⟨by linarith [hθ.1], by linarith [hθ.2]⟩, ?_⟩
      rw [← polarPt_add_two_pi z t (θ - 2 * Real.pi), sub_add_cancel]

/-- **Near a point of branch `i` every point is on the branch or in one of the two cells beside it** (FS131-E8 § 6.2
(2)): an open set about the point inside the union of the cell clockwise of the branch, the branch and the cell
counter-clockwise of it. -/
theorem exists_isOpen_subset_cells {i j : Fin F.n} (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n))
    {t : ℝ} (ht : t ∈ Ioo 0 F.r) :
    ∃ O : Set ℂ, IsOpen O ∧ polarPt z t (F.φ i t) ∈ O ∧ O ⊆ F.cell j ∪ F.branch i ∪ F.cell i := by
  obtain ⟨lo, hlo, hlt, heq⟩ := F.exists_lower_of_pred hij
  refine ⟨polarRegion z F.r lo (cyclicNext F.φ i), isOpen_polarRegion z hlo (F.continuousOn_cyclicNext i),
    ⟨t, ht, F.φ i t, ⟨hlt t ht, F.φ_lt_cyclicNext i ht⟩, rfl⟩, ?_⟩
  rintro w ⟨s, hs, θ, hθ, rfl⟩
  rcases lt_trichotomy θ (F.φ i s) with h | h | h
  · refine Or.inl (Or.inl ?_)
    rw [cell, ← heq]
    exact ⟨s, hs, θ, ⟨hθ.1, h⟩, rfl⟩
  · exact Or.inl (Or.inr ⟨s, hs, by rw [h]⟩)
  · exact Or.inr ⟨s, hs, θ, ⟨h, hθ.2⟩, rfl⟩

/-- Near a point of branch `i` almost every point has the colour of one of the two cells beside the branch. -/
theorem exists_isOpen_ae_two_colours {i j : Fin F.n} (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n))
    {t : ℝ} (ht : t ∈ Ioo 0 F.r) :
    ∃ O : Set ℂ, IsOpen O ∧ polarPt z t (F.φ i t) ∈ O ∧ (O : Set ℂ) ≤ᵐ[volume] (c.cls (F.col j) ∪ c.cls (F.col i) : Set ℂ) := by
  obtain ⟨O, hO, hx, hsub⟩ := F.exists_isOpen_subset_cells hij ht
  refine ⟨O, hO, hx, ?_⟩
  have h1 : (F.cell j ∪ F.branch i ∪ F.cell i : Set ℂ) ≤ᵐ[volume] (c.cls (F.col j) ∪ c.cls (F.col i) : Set ℂ) := by
    have hb : (F.branch i : Set ℂ) ≤ᵐ[volume] (∅ : Set ℂ) := by
      rw [ae_le_set, sdiff_empty]
      exact measure_mono_null (fun w hw => (F.branch_subset i hw).1) c.volume_essBdry
    have h2 := ((F.region j).union hb).union (F.region i)
    rwa [union_empty] at h2
  exact Filter.EventuallyLE.trans (Eventually.of_forall hsub) h1

/-- `col_ne`, to be pasted. -/
theorem col_ne' {i j : Fin F.n} (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n)) : F.col j ≠ F.col i := by
  intro heq
  obtain ⟨O, hO, hx, hae⟩ := F.exists_isOpen_ae_two_colours hij (t := F.r / 2) ⟨half_pos F.r_pos, half_lt_self F.r_pos⟩
  rw [heq, union_self] at hae
  have hd := subset_densitySet_of_isOpen_ae_subset hO hae hx
  exact c.notMem_essBdry_of_mem_densitySet hd
    (F.branch_subset i ⟨F.r / 2, ⟨half_pos F.r_pos, half_lt_self F.r_pos⟩, rfl⟩).1

end Fan

/-- The punctured disc is connected. -/
theorem _root_.HadwigerNelson.Plane.isConnected_ball_diff_singleton (z : ℂ) {r : ℝ} (hr : 0 < r) :
    IsConnected (ball z r \ {z}) := by
  have him : ball z r \ {z} = (fun q : ℝ × ℝ => polarPt z q.1 q.2) '' (Ioo 0 r ×ˢ univ) := by
    ext w
    constructor
    · rintro ⟨hw, hwz⟩
      have hpos : 0 < dist w z := dist_pos.2 hwz
      exact ⟨(dist w z, polarAngle z 0 w), ⟨⟨hpos, hw⟩, mem_univ _⟩, polarPt_dist_polarAngle z 0 w⟩
    · rintro ⟨⟨t, θ⟩, ⟨ht, -⟩, rfl⟩
      have ht' : t ∈ Ioo 0 r := ht
      show polarPt z t θ ∈ ball z r \ {z}
      refine ⟨by rw [mem_ball, dist_polarPt z ht'.1.le]; exact ht'.2, fun h => ?_⟩
      have h1 := dist_polarPt z ht'.1.le θ
      rw [mem_singleton_iff.1 h, dist_self] at h1
      exact ht'.1.ne h1
  rw [him]
  exact (((nonempty_Ioo.2 hr).prod univ_nonempty).image _).elim fun w hw =>
    ⟨⟨w, hw⟩, (isPreconnected_Ioo.prod isPreconnected_univ).image _ (continuous_polarPt z).continuousOn⟩

namespace Fan

variable (F : c.Fan z)

/-- `two_le_n`, to be pasted. -/
theorem two_le_n' (hz : z ∈ c.singularSet) : 2 ≤ F.n := by
  by_contra hlt
  rw [not_le] at hlt
  rcases Nat.lt_succ_iff.1 hlt |>.eq_or_lt with h1 | h0
  · -- one branch: the regions on its two sides are one region
    have hpos : 0 < F.n := by omega
    exact F.col_ne' (i := ⟨0, hpos⟩) (j := ⟨0, hpos⟩) (Or.inr ⟨rfl, by simp [h1]⟩) rfl
  · -- no branch: the punctured disc is of one colour, and `z` is a density point of it
    have hn : F.n = 0 := by omega
    have hempty : IsEmpty (Fin F.n) := ⟨fun i => by have := i.2; omega⟩
    have hb : Disjoint (ball z F.r \ {z}) c.essBdry := by
      rw [disjoint_iff_inter_eq_empty, inter_comm, F.bdry, iUnion_of_empty]
    have hcusp : Disjoint (ball z F.r \ {z}) (cuspSet c.cls) := by
      rw [Set.disjoint_left]
      rintro w ⟨hw, hwz⟩ hwc
      exact hwz (F.singular ⟨cuspSet_subset_singularSet _ hwc, hw⟩)
    obtain ⟨j, hj⟩ := c.ae_one_colour_of_isConnected (isOpen_ball.sdiff isClosed_singleton)
      (isConnected_ball_diff_singleton z F.r_pos) hb hcusp
    have hball : (ball z F.r : Set ℂ) ≤ᵐ[volume] c.cls j := by
      rw [ae_le_set] at hj ⊢
      refine measure_mono_null (t := ((ball z F.r \ {z}) \ c.cls j) ∪ {z}) ?_
        (measure_union_null hj (measure_singleton z))
      rintro w ⟨hw, hwj⟩
      by_cases hwz : w = z
      · exact Or.inr hwz
      · exact Or.inl ⟨⟨hw, hwz⟩, hwj⟩
    have hzd : z ∈ densitySet (c.cls j) :=
      subset_densitySet_of_isOpen_ae_subset isOpen_ball hball (mem_ball_self F.r_pos)
    rcases hz with ⟨hzb, -⟩ | ⟨j', hj'1, hj'2⟩
    · exact c.notMem_essBdry_of_mem_densitySet hzd hzb
    · by_cases hjj : j' = j
      · subst hjj
        exact hj'2 (upperDensityAt_pos_of_mem_densitySet hzd)
      · have h0 : volume (c.cls j' ∩ ball z F.r) = 0 := by
          rw [ae_le_set] at hball
          refine measure_mono_null ?_ hball
          rintro w ⟨hwj', hw⟩
          exact ⟨hw, fun hwj => hjj ((show c.col w = j' from hwj').symm.trans hwj)⟩
        exact (hj'1 F.r F.r_pos).ne' h0

end Fan

end AeColouring

end HadwigerNelson.Plane
