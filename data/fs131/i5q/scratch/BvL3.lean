import Proofs.HadwigerNelson.Plane.ValidMap.BaseWalk

/-! Scratch for FS131-I5q: `bv_l3` in its new home (`BaseWalk`, after `l3_base`): the core extracted from `l3_base`, the three steps of
`data/fs131/i5o/RingScratch.lean`, the double switch by the velocity reading, and the theorem. -/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- A unit vector perpendicular to `i e(θ)` is `± e(θ)`. -/
theorem eq_or_eq_neg_of_dot_I_mul_e {θ : ℝ} {E : ℂ} (hE : ‖E‖ = 1) (h : dot (I * e θ) E = 0) : E = e θ ∨ E = -e θ := by
  set w := e θ * starRingEnd ℂ E with hw
  have hw1 : ‖w‖ = 1 := by rw [hw, norm_mul, norm_e, Complex.norm_conj, hE, one_mul]
  have hwim : w.im = 0 := by
    have : dot (I * e θ) E = -w.im := by
      simp only [dot, hw, Complex.mul_re, Complex.mul_im, Complex.I_re, Complex.I_im]; ring
    linarith
  have hsq : w.re ^ 2 = 1 := by
    have h2 := Complex.sq_norm w
    rw [hw1, Complex.normSq_apply, hwim] at h2; nlinarith
  have hEE : E * starRingEnd ℂ E = 1 := by
    rw [Complex.mul_conj, Complex.normSq_eq_norm_sq, hE]; norm_num
  have hfac : (w.re - 1) * (w.re + 1) = 0 := by linear_combination hsq
  have key : ∀ c : ℂ, w = c → e θ = c * E := by
    intro c hc
    have : e θ * (starRingEnd ℂ E * E) = c * E := by rw [← mul_assoc, ← hw, hc]
    rwa [mul_comm (starRingEnd ℂ E) E, hEE, mul_one] at this
  rcases mul_eq_zero.mp hfac with h1 | h1
  · left
    have hw1' : w = 1 := Complex.ext (by simp; linarith) (by simp [hwim])
    have := key 1 hw1'
    rw [one_mul] at this; exact this.symm
  · right
    have hwm : w = -1 := Complex.ext (by simp; linarith) (by simp [hwim])
    have := key (-1) hwm
    rw [this]; ring

namespace CircleColouring

/-- Along a path with finite fibres, the parameters whose image meets a locally finite set are finitely many. -/
theorem link_bad_finite {φ χ : ℝ → ℝ} {a b : ℝ} (hφc : ContinuousOn φ (Icc a b)) (hχc : ContinuousOn χ (Icc a b))
    (hφf : ∀ v, {s | s ∈ Icc a b ∧ φ s = v}.Finite) (hχf : ∀ v, {s | s ∈ Icc a b ∧ χ s = v}.Finite)
    {T₁ T₂ : Set ℝ} (hT₁ : ∀ a b, (T₁ ∩ Icc a b).Finite) (hT₂ : ∀ a b, (T₂ ∩ Icc a b).Finite) :
    {s | s ∈ Icc a b ∧ (φ s ∈ T₁ ∨ χ s ∈ T₂)}.Finite := by
  obtain ⟨m, hm⟩ := (isCompact_Icc.image_of_continuousOn hφc).bddBelow
  obtain ⟨M, hM⟩ := (isCompact_Icc.image_of_continuousOn hφc).bddAbove
  obtain ⟨m', hm'⟩ := (isCompact_Icc.image_of_continuousOn hχc).bddBelow
  obtain ⟨M', hM'⟩ := (isCompact_Icc.image_of_continuousOn hχc).bddAbove
  refine (((hT₁ m M).biUnion fun v _ => hφf v).union ((hT₂ m' M').biUnion fun v _ => hχf v)).subset ?_
  rintro s ⟨hs, h | h⟩
  · left
    exact mem_biUnion (x := φ s) ⟨h, hm ⟨s, hs, rfl⟩, hM ⟨s, hs, rfl⟩⟩ ⟨hs, rfl⟩
  · right
    exact mem_biUnion (x := χ s) ⟨h, hm' ⟨s, hs, rfl⟩, hM' ⟨s, hs, rfl⟩⟩ ⟨hs, rfl⟩

/-- `link_val_right` with the side named: just right of `s₀` the path lies on one side `σ` of its value, and the lift reads that side. -/
theorem link_val_right_side {C : CircleColouring} (L : C.Lift) {f : ℝ → ℝ} {a b : ℝ} (hc : ContinuousOn f (Icc a b))
    (hfin : ∀ v, {s | s ∈ Icc a b ∧ f s = v}.Finite) {s₀ : ℝ} (hs₀ : s₀ ∈ Ico a b) {l r : ℤ} (hLR : L.Sides (f s₀) l r) :
    ∃ σ : Side, ∃ v : ℤ, ((σ = .cw ∧ v = l) ∨ (σ = .ccw ∧ v = r)) ∧ ∃ δ > 0, s₀ + δ ≤ b ∧
      ∀ s ∈ Ioo s₀ (s₀ + δ), L.f (f s) = v ∧ 0 < σ.sign * (f s - f s₀) := by
  obtain ⟨δ, hδ, hδb, h | h⟩ := link_val_right L hc hfin hs₀ hLR
  · exact ⟨.cw, l, Or.inl ⟨rfl, rfl⟩, δ, hδ, hδb, fun s hs =>
      ⟨(h s hs).1, by simp only [Side.sign]; linarith [(h s hs).2]⟩⟩
  · exact ⟨.ccw, r, Or.inr ⟨rfl, rfl⟩, δ, hδ, hδb, fun s hs =>
      ⟨(h s hs).1, by simp only [Side.sign]; linarith [(h s hs).2]⟩⟩

/-- The mirror of `link_val_right_side`. -/
theorem link_val_left_side {C : CircleColouring} (L : C.Lift) {f : ℝ → ℝ} {a b : ℝ} (hc : ContinuousOn f (Icc a b))
    (hfin : ∀ v, {s | s ∈ Icc a b ∧ f s = v}.Finite) {s₀ : ℝ} (hs₀ : s₀ ∈ Ioc a b) {l r : ℤ} (hLR : L.Sides (f s₀) l r) :
    ∃ σ : Side, ∃ v : ℤ, ((σ = .cw ∧ v = l) ∨ (σ = .ccw ∧ v = r)) ∧ ∃ δ > 0, a ≤ s₀ - δ ∧
      ∀ s ∈ Ioo (s₀ - δ) s₀, L.f (f s) = v ∧ 0 < σ.sign * (f s - f s₀) := by
  obtain ⟨δ, hδ, hδb, h | h⟩ := link_val_left L hc hfin hs₀ hLR
  · exact ⟨.cw, l, Or.inl ⟨rfl, rfl⟩, δ, hδ, hδb, fun s hs =>
      ⟨(h s hs).1, by simp only [Side.sign]; linarith [(h s hs).2]⟩⟩
  · exact ⟨.ccw, r, Or.inr ⟨rfl, rfl⟩, δ, hδ, hδb, fun s hs =>
      ⟨(h s hs).1, by simp only [Side.sign]; linarith [(h s hs).2]⟩⟩

end CircleColouring

namespace ArcMap

/-- **Lemma 3's band-and-linkage argument** (BASE-V § 1b.3 steps 1 and 4; `[SokolovVoronov2025]` Lemma 3), over its two inputs: for two
circle colourings read on `ω(u₁)`, `ω(u₂)` with `1 < |u₁ − u₂| < 2`, the second with no swap point, there is no pair of lifts such that
(`hgen`) generic points at distance `1` never have heights congruent mod `3`, and (`hdbl`) along any unit-distance linkage a double
switch between one pair of heights makes the second angle turn, unless `|y − u₁| = 2`. The proof runs the linkage `exists_linkage` twice
round the intersection point `P` and compares the band of `L₁(φ) − L₂(χ)` (`link_path`) with the band of `L₂` at `P`'s partners
(`hbig_of_noSwap`, `m0_const`, `D0_mod_ne`). A refutation's engine: no model expected. -/
theorem l3_core {u₁ u₂ : ℂ} (ht : 1 < dist u₁ u₂) (ht' : dist u₁ u₂ < 2) {C₁ C₂ : CircleColouring} (L₁ : C₁.Lift) (L₂ : C₂.Lift)
    (hns₂ : ∀ x, ¬ C₂.IsSwap x) {T₁ T₂ : Set ℝ} (hT₁ : ∀ a b, (T₁ ∩ Icc a b).Finite) (hT₂ : ∀ a b, (T₂ ∩ Icc a b).Finite)
    (hS₁ : C₁.S ⊆ T₁) (hS₂ : C₂.S ⊆ T₂)
    (hgen : ∀ a b : ℝ, dist (ringPt u₁ a) (ringPt u₂ b) = 1 → a ∉ T₁ → b ∉ T₂ → (L₁.f a - L₂.f b) % 3 ≠ 0)
    (hdbl : ∀ {φ χ : ℝ → ℝ}, Continuous φ → Continuous χ → (∀ a b v, {θ | θ ∈ Icc a b ∧ φ θ = v}.Finite) →
      (∀ a b v, {θ | θ ∈ Icc a b ∧ χ θ = v}.Finite) → (∀ θ, dist (ringPt u₁ (φ θ)) (ringPt u₂ (χ θ)) = 1) →
      ∀ {s : ℝ}, dist (ringPt u₂ (χ s)) u₁ ≠ 2 → ∀ {l₁ r₁ l₂ r₂ : ℤ}, L₁.Sides (φ s) l₁ r₁ → L₂.Sides (χ s) l₂ r₂ →
        (r₁ - l₁ = 1 ∨ r₁ - l₁ = -1) → (r₂ - l₂ = 1 ∨ r₂ - l₂ = -1) →
        ((l₁ - l₂) % 3 = 0 ∧ (r₁ - r₂) % 3 = 0 ∨ (l₁ - r₂) % 3 = 0 ∧ (r₁ - l₂) % 3 = 0) →
        (∀ᶠ s' in 𝓝[≠] s, χ s' < χ s) ∨ (∀ᶠ s' in 𝓝[≠] s, χ s < χ s')) : False := by
  classical
  have hπ := Real.pi_pos
  obtain ⟨θ₀, -, hg₀⟩ := C₂.exists_good_near 0 1 one_pos
  have hT00 : θ₀ ∈ CircleColouring.T0 C₂ := ⟨hg₀.notMem, by simpa using hg₀.hex_notMem (i := 1) (by norm_num)⟩
  obtain ⟨M, hMc⟩ : ∃ M, ∀ z ∈ CircleColouring.T0 C₂, L₂.m 0 z = M :=
    ⟨L₂.m 0 θ₀, fun z hz => CircleColouring.m0_const L₂ (CircleColouring.hbig_of_noSwap L₂ hns₂) z hz θ₀ hT00⟩
  have hbandz : ∀ z ∈ CircleColouring.T0 C₂, 3 * M + 1 ≤ L₂.D 0 z ∧ L₂.D 0 z ≤ 3 * M + 2 := by
    intro z hz
    have h1 := hMc z hz
    have h2 := CircleColouring.Lift.D0_mod_ne (L := L₂) hz.1 hz.2
    unfold CircleColouring.Lift.m at h1
    omega
  have hbandL : ∀ (x : ℝ) (l r l' r' : ℤ), L₂.Sides x l r → L₂.Sides (x + π / 3) l' r' →
      3 * M + 1 ≤ l' - l ∧ l' - l ≤ 3 * M + 2 := by
    intro x l r l' r' h0 h1
    obtain ⟨z, hz, hzD⟩ := CircleColouring.exists_T0_left L₂ h0 h1
    rw [← hzD]; exact hbandz z hz
  have hbandR : ∀ (x : ℝ) (l r l' r' : ℤ), L₂.Sides x l r → L₂.Sides (x + π / 3) l' r' →
      3 * M + 1 ≤ r' - r ∧ r' - r ≤ 3 * M + 2 := by
    intro x l r l' r' h0 h1
    obtain ⟨z, hz, hzD⟩ := CircleColouring.exists_T0_right L₂ h0 h1
    rw [← hzD]; exact hbandz z hz
  -- the linkage
  obtain ⟨φ, χ, θA, φP, χP, hφc, hχc, hφper, hχper, hdist, hφfib, hχfib, hturn, hθA0, hθAπ, hφA, hφA', hin1, hin2,
    hchiA, hflip, hone⟩ := exists_linkage ht ht'
  have hgen' : ∀ s, φ s ∉ T₁ → χ s ∉ T₂ → (L₁.f (φ s) - L₂.f (χ s)) % 3 ≠ 0 := fun s => hgen _ _ (hdist s)
  have hdbl' : ∀ s, ∀ l₁ r₁ l₂ r₂ : ℤ, L₁.Sides (φ s) l₁ r₁ → L₂.Sides (χ s) l₂ r₂ → (r₁ - l₁ = 1 ∨ r₁ - l₁ = -1) →
      (r₂ - l₂ = 1 ∨ r₂ - l₂ = -1) → ((l₁ - l₂) % 3 = 0 ∧ (r₁ - r₂) % 3 = 0 ∨ (l₁ - r₂) % 3 = 0 ∧ (r₁ - l₂) % 3 = 0) →
      (∀ᶠ s' in 𝓝[≠] s, χ s' < χ s) ∨ (∀ᶠ s' in 𝓝[≠] s, χ s < χ s') := by
    intro s l₁ r₁ l₂ r₂ hs1 hs2 hj1 hj2 hpair
    by_cases h2 : dist (ringPt u₂ (χ s)) u₁ = 2
    · exact hturn s h2
    · exact hdbl hφc hχc hφfib hχfib hdist h2 hs1 hs2 hj1 hj2 hpair
  -- sides at the ends of the two paths
  obtain ⟨l₁P, r₁P, hsP, -⟩ := L₁.exists_sides φP
  obtain ⟨lA, rA, hsA, -⟩ := L₂.exists_sides (χ θA)
  obtain ⟨lB, rB, hsB, -⟩ := L₂.exists_sides (χ (-θA))
  have hsP1 : L₁.Sides (φ (-θA)) l₁P r₁P := hφA' ▸ hsP
  have hsP2 : L₁.Sides (φ θA) l₁P r₁P := hφA ▸ hsP
  have h2πA : 2 * π - θA = -θA + 2 * π := by ring
  have hsP3 : L₁.Sides (φ (2 * π - θA)) l₁P r₁P := by rw [h2πA, hφper]; exact hsP1
  have hsB3 : L₂.Sides (χ (2 * π - θA)) lB rB := by rw [h2πA, hχper]; exact hsB
  have hφc' := hφc.continuousOn (s := Icc (-θA) θA)
  have hχc' := hχc.continuousOn (s := Icc (-θA) θA)
  have hφc'' := hφc.continuousOn (s := Icc θA (2 * π - θA))
  have hχc'' := hχc.continuousOn (s := Icc θA (2 * π - θA))
  -- path 1, `[−θ_A, θ_A]`: `x` above `P`
  obtain ⟨δ1, hδ1, hδ1b, h1φ⟩ := CircleColouring.link_val_right L₁ hφc' (hφfib _ _) ⟨le_rfl, by linarith⟩ hsP1
  obtain ⟨δ2, hδ2, hδ2b, h1χ⟩ := CircleColouring.link_val_right L₂ hχc' (hχfib _ _) ⟨le_rfl, by linarith⟩ hsB
  obtain ⟨δ3, hδ3, hδ3a, h2φ⟩ := CircleColouring.link_val_left L₁ hφc' (hφfib _ _) ⟨by linarith, le_rfl⟩ hsP2
  obtain ⟨δ4, hδ4, hδ4a, h2χ⟩ := CircleColouring.link_val_left L₂ hχc' (hχfib _ _) ⟨by linarith, le_rfl⟩ hsA
  have hφ1 : ∀ s ∈ Ioo (-θA) (-θA + δ1), L₁.f (φ s) = r₁P := by
    rcases h1φ with h | h
    · intro s hs; exfalso
      have e1 := (h s hs).2; have e2 := hin1 s ⟨hs.1, by linarith [hs.2]⟩; rw [hφA'] at e1; linarith
    · exact fun s hs => (h s hs).1
  have hφ2 : ∀ s ∈ Ioo (θA - δ3) θA, L₁.f (φ s) = r₁P := by
    rcases h2φ with h | h
    · intro s hs; exfalso
      have e1 := (h s hs).2; have e2 := hin1 s ⟨by linarith [hs.1], hs.2⟩; rw [hφA] at e1; linarith
    · exact fun s hs => (h s hs).1
  obtain ⟨hB1, hB1v, hB1s⟩ : ∃ h : ℤ, (∀ s ∈ Ioo (-θA) (-θA + δ2), L₂.f (χ s) = h) ∧
      ((h = lB ∧ ∀ s ∈ Ioo (-θA) (-θA + δ2), χ s < χ (-θA)) ∨ (h = rB ∧ ∀ s ∈ Ioo (-θA) (-θA + δ2), χ (-θA) < χ s)) := by
    rcases h1χ with h | h
    · exact ⟨lB, fun s hs => (h s hs).1, Or.inl ⟨rfl, fun s hs => (h s hs).2⟩⟩
    · exact ⟨rB, fun s hs => (h s hs).1, Or.inr ⟨rfl, fun s hs => (h s hs).2⟩⟩
  obtain ⟨hA1, hA1v, hA1s⟩ : ∃ h : ℤ, (∀ s ∈ Ioo (θA - δ4) θA, L₂.f (χ s) = h) ∧
      ((h = lA ∧ ∀ s ∈ Ioo (θA - δ4) θA, χ s < χ θA) ∨ (h = rA ∧ ∀ s ∈ Ioo (θA - δ4) θA, χ θA < χ s)) := by
    rcases h2χ with h | h
    · exact ⟨lA, fun s hs => (h s hs).1, Or.inl ⟨rfl, fun s hs => (h s hs).2⟩⟩
    · exact ⟨rA, fun s hs => (h s hs).1, Or.inr ⟨rfl, fun s hs => (h s hs).2⟩⟩
  have hp1 := CircleColouring.link_path L₁ L₂ (by linarith : -θA < θA) hφc' hχc' (hφfib _ _) (hχfib _ _) hT₁ hT₂
    hS₁ hS₂ (fun s _ => hgen' s) (fun s _ => hdbl' s) (r₁P - hB1) (r₁P - hA1)
    ⟨min δ1 δ2, lt_min hδ1 hδ2, fun s hs => by
      rw [hφ1 s ⟨hs.1, by linarith [hs.2, min_le_left δ1 δ2]⟩, hB1v s ⟨hs.1, by linarith [hs.2, min_le_right δ1 δ2]⟩]⟩
    ⟨min δ3 δ4, lt_min hδ3 hδ4, fun s hs => by
      rw [hφ2 s ⟨by linarith [hs.1, min_le_left δ3 δ4], hs.2⟩, hA1v s ⟨by linarith [hs.1, min_le_right δ3 δ4], hs.2⟩]⟩
  -- path 2, `[θ_A, 2π − θ_A]`: `x` below `P`
  obtain ⟨δ5, hδ5, hδ5b, h3φ⟩ := CircleColouring.link_val_right L₁ hφc'' (hφfib _ _) ⟨le_rfl, by linarith⟩ hsP2
  obtain ⟨δ6, hδ6, hδ6b, h3χ⟩ := CircleColouring.link_val_right L₂ hχc'' (hχfib _ _) ⟨le_rfl, by linarith⟩ hsA
  obtain ⟨δ7, hδ7, hδ7a, h4φ⟩ := CircleColouring.link_val_left L₁ hφc'' (hφfib _ _) ⟨by linarith, le_rfl⟩ hsP3
  obtain ⟨δ8, hδ8, hδ8a, h4χ⟩ := CircleColouring.link_val_left L₂ hχc'' (hχfib _ _) ⟨by linarith, le_rfl⟩ hsB3
  have hφ3 : ∀ s ∈ Ioo θA (θA + δ5), L₁.f (φ s) = l₁P := by
    rcases h3φ with h | h
    · exact fun s hs => (h s hs).1
    · intro s hs; exfalso
      have e1 := (h s hs).2; have e2 := hin2 s ⟨hs.1, by linarith [hs.2]⟩; rw [hφA] at e1; linarith
  have hφ4 : ∀ s ∈ Ioo (2 * π - θA - δ7) (2 * π - θA), L₁.f (φ s) = l₁P := by
    rcases h4φ with h | h
    · exact fun s hs => (h s hs).1
    · intro s hs; exfalso
      have e1 := (h s hs).2; have e2 := hin2 s ⟨by linarith [hs.1], hs.2⟩
      rw [h2πA, hφper, hφA'] at e1; linarith
  obtain ⟨hA2, hA2v, hA2s⟩ : ∃ h : ℤ, (∀ s ∈ Ioo θA (θA + δ6), L₂.f (χ s) = h) ∧
      ((h = lA ∧ ∀ s ∈ Ioo θA (θA + δ6), χ s < χ θA) ∨ (h = rA ∧ ∀ s ∈ Ioo θA (θA + δ6), χ θA < χ s)) := by
    rcases h3χ with h | h
    · exact ⟨lA, fun s hs => (h s hs).1, Or.inl ⟨rfl, fun s hs => (h s hs).2⟩⟩
    · exact ⟨rA, fun s hs => (h s hs).1, Or.inr ⟨rfl, fun s hs => (h s hs).2⟩⟩
  obtain ⟨hB2, hB2v, hB2s⟩ : ∃ h : ℤ, (∀ s ∈ Ioo (2 * π - θA - δ8) (2 * π - θA), L₂.f (χ s) = h) ∧
      ((h = lB ∧ ∀ s ∈ Ioo (2 * π - θA - δ8) (2 * π - θA), χ s < χ (2 * π - θA)) ∨
        (h = rB ∧ ∀ s ∈ Ioo (2 * π - θA - δ8) (2 * π - θA), χ (2 * π - θA) < χ s)) := by
    rcases h4χ with h | h
    · exact ⟨lB, fun s hs => (h s hs).1, Or.inl ⟨rfl, fun s hs => (h s hs).2⟩⟩
    · exact ⟨rB, fun s hs => (h s hs).1, Or.inr ⟨rfl, fun s hs => (h s hs).2⟩⟩
  have hp2 := CircleColouring.link_path L₁ L₂ (by linarith : θA < 2 * π - θA) hφc'' hχc'' (hφfib _ _) (hχfib _ _) hT₁ hT₂
    hS₁ hS₂ (fun s _ => hgen' s) (fun s _ => hdbl' s) (l₁P - hA2) (l₁P - hB2)
    ⟨min δ5 δ6, lt_min hδ5 hδ6, fun s hs => by
      rw [hφ3 s ⟨hs.1, by linarith [hs.2, min_le_left δ5 δ6]⟩, hA2v s ⟨hs.1, by linarith [hs.2, min_le_right δ5 δ6]⟩]⟩
    ⟨min δ7 δ8, lt_min hδ7 hδ8, fun s hs => by
      rw [hφ4 s ⟨by linarith [hs.1, min_le_left δ7 δ8], hs.2⟩, hB2v s ⟨by linarith [hs.1, min_le_right δ7 δ8], hs.2⟩]⟩
  -- the flips: where `|y − u₁| < 2`, the two paths reach `y` from opposite sides
  have hflipA : dist (ringPt u₂ (χ θA)) u₁ < 2 → (hA1 = lA ∧ hA2 = rA) ∨ (hA1 = rA ∧ hA2 = lA) := by
    intro hd
    obtain ⟨η, hη, hm⟩ := hflip θA (Or.inl rfl) hd
    set ε := min η (min δ4 δ6) with hε
    have hε0 : 0 < ε := lt_min hη (lt_min hδ4 hδ6)
    have e1 : ε ≤ η := min_le_left _ _
    have e2 : ε ≤ δ4 := (min_le_right _ _).trans (min_le_left _ _)
    have e3 : ε ≤ δ6 := (min_le_right _ _).trans (min_le_right _ _)
    have hs₁ : θA - ε / 2 ∈ Ioo (θA - δ4) θA := ⟨by linarith, by linarith⟩
    have hs₂ : θA + ε / 2 ∈ Ioo θA (θA + δ6) := ⟨by linarith, by linarith⟩
    have m₁ : θA - ε / 2 ∈ Icc (θA - η) (θA + η) := ⟨by linarith, by linarith⟩
    have m₀ : θA ∈ Icc (θA - η) (θA + η) := ⟨by linarith, by linarith⟩
    have m₂ : θA + ε / 2 ∈ Icc (θA - η) (θA + η) := ⟨by linarith, by linarith⟩
    rcases hm with hm | hm
    · have f1 := hm m₁ m₀ (by linarith)
      have f2 := hm m₀ m₂ (by linarith)
      left; constructor
      · rcases hA1s with ⟨h, -⟩ | ⟨-, h⟩
        · exact h
        · exact absurd (h _ hs₁) (not_lt.mpr f1.le)
      · rcases hA2s with ⟨-, h⟩ | ⟨h, -⟩
        · exact absurd (h _ hs₂) (not_lt.mpr f2.le)
        · exact h
    · have f1 := hm m₁ m₀ (by linarith)
      have f2 := hm m₀ m₂ (by linarith)
      right; constructor
      · rcases hA1s with ⟨-, h⟩ | ⟨h, -⟩
        · exact absurd (h _ hs₁) (not_lt.mpr f1.le)
        · exact h
      · rcases hA2s with ⟨h, -⟩ | ⟨-, h⟩
        · exact h
        · exact absurd (h _ hs₂) (not_lt.mpr f2.le)
  have hflipB : dist (ringPt u₂ (χ (-θA))) u₁ < 2 → (hB1 = rB ∧ hB2 = lB) ∨ (hB1 = lB ∧ hB2 = rB) := by
    intro hd
    obtain ⟨η, hη, hm⟩ := hflip (-θA) (Or.inr rfl) hd
    set ε := min η (min δ2 δ8) with hε
    have hε0 : 0 < ε := lt_min hη (lt_min hδ2 hδ8)
    have e1 : ε ≤ η := min_le_left _ _
    have e2 : ε ≤ δ2 := (min_le_right _ _).trans (min_le_left _ _)
    have e3 : ε ≤ δ8 := (min_le_right _ _).trans (min_le_right _ _)
    have hs₁ : -θA + ε / 2 ∈ Ioo (-θA) (-θA + δ2) := ⟨by linarith, by linarith⟩
    have hs₂ : 2 * π - θA - ε / 2 ∈ Ioo (2 * π - θA - δ8) (2 * π - θA) := ⟨by linarith, by linarith⟩
    have hper2 : χ (2 * π - θA - ε / 2) = χ (-θA - ε / 2) := by
      rw [show 2 * π - θA - ε / 2 = (-θA - ε / 2) + 2 * π by ring, hχper]
    have hper0 : χ (2 * π - θA) = χ (-θA) := by rw [h2πA, hχper]
    have m₁ : -θA - ε / 2 ∈ Icc (-θA - η) (-θA + η) := ⟨by linarith, by linarith⟩
    have m₀ : -θA ∈ Icc (-θA - η) (-θA + η) := ⟨by linarith, by linarith⟩
    have m₂ : -θA + ε / 2 ∈ Icc (-θA - η) (-θA + η) := ⟨by linarith, by linarith⟩
    rcases hm with hm | hm
    · have f1 := hm m₁ m₀ (by linarith)
      have f2 := hm m₀ m₂ (by linarith)
      left; constructor
      · rcases hB1s with ⟨-, h⟩ | ⟨h, -⟩
        · exact absurd (h _ hs₁) (not_lt.mpr f2.le)
        · exact h
      · rcases hB2s with ⟨h, -⟩ | ⟨-, h⟩
        · exact h
        · have := h _ hs₂; rw [hper2, hper0] at this; exact absurd this (not_lt.mpr f1.le)
    · have f1 := hm m₁ m₀ (by linarith)
      have f2 := hm m₀ m₂ (by linarith)
      right; constructor
      · rcases hB1s with ⟨h, -⟩ | ⟨-, h⟩
        · exact h
        · exact absurd (h _ hs₁) (not_lt.mpr f2.le)
      · rcases hB2s with ⟨-, h⟩ | ⟨h, -⟩
        · have := h _ hs₂; rw [hper2, hper0] at this; exact absurd this (not_lt.mpr f1.le)
        · exact h
  -- the band at the two partners of `P` (BV-H1): `χ(±θ_A) = χ_P ± 60°`
  obtain ⟨l₀, r₀, hs₀, -⟩ := L₂.exists_sides χP
  obtain ⟨lp, rp, hsp, -⟩ := L₂.exists_sides (χP + π / 3)
  obtain ⟨lm, rm, hsm, -⟩ := L₂.exists_sides (χP - π / 3)
  have b1 := hbandL χP l₀ r₀ lp rp hs₀ hsp
  have b2 := hbandR χP l₀ r₀ lp rp hs₀ hsp
  have hsm' : L₂.Sides (χP - π / 3 + π / 3) l₀ r₀ := by rw [show χP - π / 3 + π / 3 = χP by ring]; exact hs₀
  have b3 := hbandL (χP - π / 3) lm rm l₀ r₀ hsm hsm'
  have b4 := hbandR (χP - π / 3) lm rm l₀ r₀ hsm hsm'
  have hAB : (lA = lp ∧ rA = rp ∧ lB = lm ∧ rB = rm) ∨ (lA = lm ∧ rA = rm ∧ lB = lp ∧ rB = rp) := by
    rcases hchiA with ⟨eA, eB⟩ | ⟨eA, eB⟩
    · rw [eA] at hsA; rw [eB] at hsB
      obtain ⟨f1, f2⟩ := hsA.unique hsp
      obtain ⟨f3, f4⟩ := hsB.unique hsm
      exact Or.inl ⟨f1, f2, f3, f4⟩
    · rw [eA] at hsA; rw [eB] at hsB
      obtain ⟨f1, f2⟩ := hsA.unique hsm
      obtain ⟨f3, f4⟩ := hsB.unique hsp
      exact Or.inr ⟨f1, f2, f3, f4⟩
  obtain ⟨p1a, p1b, p1c⟩ := hp1
  obtain ⟨p2a, p2b, p2c⟩ := hp2
  have hB1v' : hB1 = lB ∨ hB1 = rB := hB1s.imp (fun h => h.1) (fun h => h.1)
  have hA1v' : hA1 = lA ∨ hA1 = rA := hA1s.imp (fun h => h.1) (fun h => h.1)
  have hA2v' : hA2 = lA ∨ hA2 = rA := hA2s.imp (fun h => h.1) (fun h => h.1)
  have hB2v' : hB2 = lB ∨ hB2 = rB := hB2s.imp (fun h => h.1) (fun h => h.1)
  rcases hone with hd | hd
  · rcases hflipA hd with ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> rcases hB1v' with e3 | e3 <;> rcases hB2v' with e4 | e4 <;>
      rcases hAB with ⟨f1, f2, f3, f4⟩ | ⟨f1, f2, f3, f4⟩ <;> omega
  · rcases hflipB hd with ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> rcases hA1v' with e3 | e3 <;> rcases hA2v' with e4 | e4 <;>
      rcases hAB with ⟨f1, f2, f3, f4⟩ | ⟨f1, f2, f3, f4⟩ <;> omega

variable {k : ℕ} {F : ArcMap k}

/-- **A finite ring carries no arc of `Γ`** (`bv_l3`'s step 1): an arc of `Γ` on `ω(p)` of positive length is infinite, so a ring meeting
`Γ` in finitely many points (`RingProper`'s first clause) carries none. -/
theorem not_onRingArc_of_finite {p : ℂ} (h : (F.Γ ∩ sphere p 1).Finite) (x : ℂ) : ¬ F.OnRingArc p x := by
  rintro ⟨θ₁, θ₂, h12, -, hsub⟩
  have hπ := Real.pi_pos
  set b := min θ₂ (θ₁ + π) with hb
  have hab : θ₁ < b := lt_min h12 (by linarith)
  have hinj : InjOn (ringPt p) (Ioo θ₁ b) := by
    intro s hs s' hs' hss
    have hss' : spherePt p 1 s = spherePt p 1 s' := by simpa [spherePt, ringPt] using hss
    exact injOn_spherePt p one_pos θ₁ ⟨hs.1, by linarith [hs.2, min_le_right θ₂ (θ₁ + π)]⟩
      ⟨hs'.1, by linarith [hs'.2, min_le_right θ₂ (θ₁ + π)]⟩ hss'
  refine ((Ioo_infinite hab).image hinj) (h.subset ?_)
  rintro _ ⟨t, ht, rfl⟩
  exact ⟨hsub ⟨t, ⟨ht.1.le, by linarith [ht.2, min_le_left θ₂ (θ₁ + π)]⟩, rfl⟩, ringPt_mem_sphere p t⟩

/-- **The ring colouring's one-sided values are germs of the map** (the bridge back from `ringCircleColouring`): if the ring colouring
takes the value `a` just before `x` (resp. after), the germ of `ω(p)` on the clockwise (resp. counter-clockwise) side of `r(x)` lies in
one colour's class, a colour absent at `p` that `g` sends to `a`. -/
theorem ringCircle_val_germ (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (hno : ∀ x, ¬ F.OnRingArc p x) (g : Fin k → ZMod 3)
    (hg : Set.InjOn g (F.coloursAt p)ᶜ) {x : ℝ} {a : ZMod 3} (s : Side)
    (h : (s = .cw ∧ (F.ringCircleColouring hF hp hno g hg).LeftVal x a) ∨
      (s = .ccw ∧ (F.ringCircleColouring hF hp hno g hg).RightVal x a)) :
    ∃ X, g X = a ∧ X ∉ F.coloursAt p ∧ GermIn p x s (F.region X) := by
  set C := F.ringCircleColouring hF hp hno g hg with hC
  obtain ⟨l, r, hlr, hlx, hxr, hsub⟩ : ∃ l r, l < r ∧ (s = .cw → r = x) ∧ (s = .ccw → l = x) ∧
      ∀ θ ∈ Ioo l r, θ ∉ C.S ∧ C.c θ = a := by
    rcases h with ⟨rfl, h⟩ | ⟨rfl, h⟩
    · obtain ⟨l, hl, hs⟩ := mem_nhdsLT_iff_exists_Ioo_subset.mp ((C.eventually_notMem_S_lt x).and h)
      exact ⟨l, x, hl, fun _ => rfl, fun h => absurd h (by decide), fun θ hθ => hs hθ⟩
    · obtain ⟨r, hr, hs⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp ((C.eventually_notMem_S_gt x).and h)
      exact ⟨x, r, hr, fun h => absurd h (by decide), fun _ => rfl, fun θ hθ => hs hθ⟩
  have hint : ∀ θ ∈ Ioo l r, ringPt p θ ∈ F.interiorPts := fun θ hθ =>
    F.mem_interiorPts_of_notMem_Γ (hp (sphere_subset_closedBall (ringPt_mem_sphere p θ))) (hsub θ hθ).1
  have habs : ∀ θ ∈ Ioo l r, F.col (ringPt p θ) ∉ F.coloursAt p := fun θ hθ =>
    not_mem_coloursAt_of_mem_sphere hF (ringPt_mem_sphere p θ) ⟨hint θ hθ, rfl⟩
  obtain ⟨θ₀, hθ₀⟩ : ∃ θ₀, θ₀ ∈ Ioo l r := ⟨(l + r) / 2, by constructor <;> linarith⟩
  refine ⟨F.col (ringPt p θ₀), (hsub θ₀ hθ₀).2, habs θ₀ hθ₀, r - l, by linarith, ?_⟩
  rintro _ ⟨t, ht, rfl⟩
  have hθ : x + s.sign * t ∈ Ioo l r := by
    cases s
    · have := hlx rfl; simp only [Side.sign]; constructor <;> linarith [ht.1, ht.2]
    · have := hxr rfl; simp only [Side.sign]; constructor <;> linarith [ht.1, ht.2]
  refine ⟨hint _ hθ, ?_⟩
  show F.col (ringPt p (x + s.sign * t)) = F.col (ringPt p θ₀)
  exact hg (habs _ hθ) (habs θ₀ hθ₀) ((hsub _ hθ).2.trans (hsub θ₀ hθ₀).2.symm)

/-- **A proper ring has no swap point** (`bv_l3`'s step 3, for the band lemma): a swap of the ring colouring at `x` gives two change
points `r(x)`, `r(x ± π/3)` of `ω(p)`, at distance `1`, switching between one pair of colours (read back on the map's germs by
`ringCircle_val_germ`), against `RingProper`'s second clause. The two values differ because the clockwise germs at the two points are at
distance `1` (validity). -/
theorem ringCircle_noSwap (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (hR : F.RingProper p) (g : Fin k → ZMod 3)
    (hg : Set.InjOn g (F.coloursAt p)ᶜ) (x : ℝ) :
    ¬ (ringCircleColouring hF hp (not_onRingArc_of_finite hR.1) g hg).IsSwap x := by
  set C := ringCircleColouring hF hp (not_onRingArc_of_finite hR.1) g hg with hC
  rintro ⟨hxS, a, b, ha, hb, h⟩
  have hπ := Real.pi_pos
  have hno := not_onRingArc_of_finite (F := F) hR.1
  have main : ∀ y, |x - y| = π / 3 → C.LeftVal y b → C.RightVal y a → False := by
    intro y hxy hl hr
    have hd : dist (ringPt p x) (ringPt p y) = 1 :=
      ((dist_ringPt_ringPt_cmp_one p (by rw [hxy]; linarith)).1).mpr hxy
    obtain ⟨X', hX'a, hX'u, hX'g⟩ := ringCircle_val_germ hF hp hno g hg .cw (Or.inl ⟨rfl, ha⟩)
    obtain ⟨X, hXb, hXu, hXg⟩ := ringCircle_val_germ hF hp hno g hg .ccw (Or.inr ⟨rfl, hb⟩)
    obtain ⟨Y', hY'b, hY'u, hY'g⟩ := ringCircle_val_germ hF hp hno g hg .cw (Or.inl ⟨rfl, hl⟩)
    obtain ⟨Y, hYa, hYu, hYg⟩ := ringCircle_val_germ hF hp hno g hg .ccw (Or.inr ⟨rfl, hr⟩)
    -- the two values differ: the clockwise germs at `x` and `y` are `1` apart
    have hab : a ≠ b := by
      rintro rfl
      have hXY : X' = Y' := hg hX'u hY'u (hX'a.trans hY'b.symm)
      obtain ⟨δ₁, hδ₁, hs₁⟩ := hX'g
      obtain ⟨δ₂, hδ₂, hs₂⟩ := hY'g
      set t := min δ₁ δ₂ / 2 with ht
      have ht0 : 0 < t := by positivity
      have ht1 : t < δ₁ := by have := min_le_left δ₁ δ₂; linarith
      have ht2 : t < δ₂ := by have := min_le_right δ₁ δ₂; linarith
      have hz := hs₁ ⟨t, ⟨ht0, ht1⟩, rfl⟩
      have hw := hs₂ ⟨t, ⟨ht0, ht2⟩, rfl⟩
      have hdd : dist (ringPt p (x + Side.cw.sign * t)) (ringPt p (y + Side.cw.sign * t)) = 1 := by
        have : |(x + Side.cw.sign * t) - (y + Side.cw.sign * t)| = π / 3 := by
          rw [show (x + Side.cw.sign * t) - (y + Side.cw.sign * t) = x - y by ring]; exact hxy
        exact ((dist_ringPt_ringPt_cmp_one p (by rw [this]; linarith)).1).mpr this
      rw [hXY] at hz
      exact hF _ hz.1 _ hw.1 hdd (hz.2.trans hw.2.symm)
    have hyS : y ∈ C.S := by
      by_contra hyS
      have hc := C.locallyConstant y hyS
      have h1 : C.LeftVal y (C.c y) := hc.filter_mono nhdsWithin_le_nhds
      have h2 : C.RightVal y (C.c y) := hc.filter_mono nhdsWithin_le_nhds
      exact hab ((CircleColouring.RightVal.unique hr h2).trans (CircleColouring.LeftVal.unique hl h1).symm)
    have hXX : X ≠ X' := fun h' => hab (hX'a.symm.trans (h' ▸ hXb))
    have hYY : Y ≠ Y' := fun h' => hab (hYa.symm.trans (h' ▸ hY'b))
    have e1 : X = Y' := hg hXu hY'u (hXb.trans hY'b.symm)
    have e2 : X' = Y := hg hX'u hYu (hX'a.trans hYa.symm)
    refine hR.2 x y X X' Y Y' hd ⟨hxS, hXX, hXg, hX'g⟩ ⟨hyS, hYY, hYg, hY'g⟩ ?_
    rw [e1, e2, Set.pair_comm]
  rcases h with ⟨hl, hr⟩ | ⟨hl, hr⟩
  · exact main _ (by rw [show x - (x + π / 3) = -(π / 3) by ring, abs_neg, abs_of_pos (by positivity)]) hl hr
  · exact main _ (by rw [show x - (x - π / 3) = π / 3 by ring, abs_of_pos (by positivity)]) hl hr

/-- **A double switch along the linkage, read by its velocities** (`bv_l3`'s step 5; BASE-V § 1b.3 step 4): for two ring colourings read
through one labelling `g` of the absent colours (`hv₁`, `hv₂`: one-sided values are germs of the map), with generic pairs never
congruent (`hgen`), a parameter `s₀` of a unit-distance linkage at which both heights jump by `±1` between one pair of residues, with
`|y₀ − u₁| ≠ 2`, is a turning point of the second angle. Else `y` crosses `y₀`, and by `hgen` on each side so does `x`, in the opposite sense
under `l₁ ≡ l₂, r₁ ≡ r₂` and in the same sense under `l₁ ≡ r₂, r₁ ≡ l₂`; with `D₁ = ⟨i e φ₀, x₀ − y₀⟩`, `D₂ = ⟨i e χ₀, x₀ − y₀⟩`: `D₁ = 0` puts
`y₀` at `u₁` or at distance `2` from it; `D₂ = 0` forbids `x` its lengthening side (`linkage_end`); two motions that both lengthen or both
shorten are refuted just after `s₀` (`linkage_cmp`); what is left is a double event, refuted by `bv_nd` under H. A step inside a
refutation: no model expected. -/
theorem bv_l3_dbl {F : ArcMap 6} (hF : F.Valid) {u₁ u₂ : ℂ} (hc₁ : F.Covers u₁ 1) (hc₂ : F.Covers u₂ 1) (ht : 1 < dist u₁ u₂)
    (hH : ∀ x, (dist x u₁ = 1 ∨ dist x u₂ = 1) → x ∉ F.fourSet ∪ F.repSet)
    {g : Fin 6 → ZMod 3} {A : Set (Fin 6)} (hg : Set.InjOn g A) {C₁ C₂ : CircleColouring} (L₁ : C₁.Lift) (L₂ : C₂.Lift)
    (hv₁ : ∀ (x : ℝ) (a : ZMod 3) (s : Side), (s = .cw ∧ C₁.LeftVal x a) ∨ (s = .ccw ∧ C₁.RightVal x a) →
      ∃ X, g X = a ∧ X ∈ A ∧ GermIn u₁ x s (F.region X))
    (hv₂ : ∀ (x : ℝ) (a : ZMod 3) (s : Side), (s = .cw ∧ C₂.LeftVal x a) ∨ (s = .ccw ∧ C₂.RightVal x a) →
      ∃ X, g X = a ∧ X ∈ A ∧ GermIn u₂ x s (F.region X))
    (hgen : ∀ a b : ℝ, dist (ringPt u₁ a) (ringPt u₂ b) = 1 → a ∉ C₁.S → b ∉ C₂.S → (L₁.f a - L₂.f b) % 3 ≠ 0)
    {φ χ : ℝ → ℝ} (hφc : Continuous φ) (hχc : Continuous χ) (hφf : ∀ a b v, {θ | θ ∈ Icc a b ∧ φ θ = v}.Finite)
    (hχf : ∀ a b v, {θ | θ ∈ Icc a b ∧ χ θ = v}.Finite) (hdist : ∀ θ, dist (ringPt u₁ (φ θ)) (ringPt u₂ (χ θ)) = 1)
    {s₀ : ℝ} (h2 : dist (ringPt u₂ (χ s₀)) u₁ ≠ 2) {l₁ r₁ l₂ r₂ : ℤ} (hs1 : L₁.Sides (φ s₀) l₁ r₁)
    (hs2 : L₂.Sides (χ s₀) l₂ r₂) (hj1 : r₁ - l₁ = 1 ∨ r₁ - l₁ = -1) (hj2 : r₂ - l₂ = 1 ∨ r₂ - l₂ = -1)
    (hpair : (l₁ - l₂) % 3 = 0 ∧ (r₁ - r₂) % 3 = 0 ∨ (l₁ - r₂) % 3 = 0 ∧ (r₁ - l₂) % 3 = 0) :
    (∀ᶠ s' in 𝓝[≠] s₀, χ s' < χ s₀) ∨ (∀ᶠ s' in 𝓝[≠] s₀, χ s₀ < χ s') := by
  have hφc' := hφc.continuousOn (s := Icc (s₀ - 1) (s₀ + 1))
  have hχc' := hχc.continuousOn (s := Icc (s₀ - 1) (s₀ + 1))
  -- the sides of `x` and of `y` just after and just before `s₀`
  obtain ⟨σA, vA, hvA, δ1, hδ1, hδ1b, hA1⟩ :=
    CircleColouring.link_val_right_side L₁ hφc' (hφf _ _) ⟨by linarith, by linarith⟩ hs1
  obtain ⟨σB, vB, hvB, δ2, hδ2, hδ2b, hB1⟩ :=
    CircleColouring.link_val_left_side L₁ hφc' (hφf _ _) ⟨by linarith, by linarith⟩ hs1
  obtain ⟨τA, wA, hwA, δ3, hδ3, hδ3b, hA2⟩ :=
    CircleColouring.link_val_right_side L₂ hχc' (hχf _ _) ⟨by linarith, by linarith⟩ hs2
  obtain ⟨τB, wB, hwB, δ4, hδ4, hδ4b, hB2⟩ :=
    CircleColouring.link_val_left_side L₂ hχc' (hχf _ _) ⟨by linarith, by linarith⟩ hs2
  by_cases hτ : τB = τA
  · -- `y` on one side before and after: `χ` turns
    rw [← nhdsLT_sup_nhdsGT, eventually_sup, eventually_sup]
    have hlt : ∀ᶠ s in 𝓝[<] s₀, 0 < τA.sign * (χ s - χ s₀) := by
      filter_upwards [Ioo_mem_nhdsLT (show s₀ - δ4 < s₀ by linarith)] with s hs
      rw [← hτ]; exact (hB2 s hs).2
    have hgt : ∀ᶠ s in 𝓝[>] s₀, 0 < τA.sign * (χ s - χ s₀) := by
      filter_upwards [Ioo_mem_nhdsGT (show s₀ < s₀ + δ3 by linarith)] with s hs
      exact (hA2 s hs).2
    cases τA
    · left
      exact ⟨hlt.mono fun s hs => by simp only [Side.sign] at hs; linarith,
        hgt.mono fun s hs => by simp only [Side.sign] at hs; linarith⟩
    · right
      exact ⟨hlt.mono fun s hs => by simp only [Side.sign] at hs; linarith,
        hgt.mono fun s hs => by simp only [Side.sign] at hs; linarith⟩
  exfalso
  -- generic parameters on each side: the heights there are not congruent
  have hbad := CircleColouring.link_bad_finite hφc' hχc' (hφf _ _) (hχf _ _) C₁.S_inter_Icc_finite C₂.S_inter_Icc_finite
  have hgenA : (vA - wA) % 3 ≠ 0 := by
    have hm : 0 < min δ1 δ3 := lt_min hδ1 hδ3
    obtain ⟨z, hz, hzb⟩ := ((Ioo_infinite (show s₀ < s₀ + min δ1 δ3 by linarith)).sdiff hbad).nonempty
    have hz1 : z ∈ Ioo s₀ (s₀ + δ1) := ⟨hz.1, by linarith [hz.2, min_le_left δ1 δ3]⟩
    have hz3 : z ∈ Ioo s₀ (s₀ + δ3) := ⟨hz.1, by linarith [hz.2, min_le_right δ1 δ3]⟩
    have hzI : z ∈ Icc (s₀ - 1) (s₀ + 1) := ⟨by linarith [hz.1], by linarith [hz1.2]⟩
    have := hgen (φ z) (χ z) (hdist z) (fun h => hzb ⟨hzI, Or.inl h⟩) (fun h => hzb ⟨hzI, Or.inr h⟩)
    rwa [(hA1 z hz1).1, (hA2 z hz3).1] at this
  have hgenB : (vB - wB) % 3 ≠ 0 := by
    have hm : 0 < min δ2 δ4 := lt_min hδ2 hδ4
    obtain ⟨z, hz, hzb⟩ := ((Ioo_infinite (show s₀ - min δ2 δ4 < s₀ by linarith)).sdiff hbad).nonempty
    have hz2 : z ∈ Ioo (s₀ - δ2) s₀ := ⟨by linarith [hz.1, min_le_left δ2 δ4], hz.2⟩
    have hz4 : z ∈ Ioo (s₀ - δ4) s₀ := ⟨by linarith [hz.1, min_le_right δ2 δ4], hz.2⟩
    have hzI : z ∈ Icc (s₀ - 1) (s₀ + 1) := ⟨by linarith [hz2.1], by linarith [hz.2]⟩
    have := hgen (φ z) (χ z) (hdist z) (fun h => hzb ⟨hzI, Or.inl h⟩) (fun h => hzb ⟨hzI, Or.inr h⟩)
    rwa [(hB1 z hz2).1, (hB2 z hz4).1] at this
  -- so `x` crosses too: against `y` under the first pairing, with it under the second
  obtain ⟨hσB, hrel⟩ : σB = σA.flip ∧ (((l₁ - l₂) % 3 = 0 ∧ (r₁ - r₂) % 3 = 0 ∧ τA = σA.flip) ∨
      ((l₁ - r₂) % 3 = 0 ∧ (r₁ - l₂) % 3 = 0 ∧ τA = σA)) := by
    rcases hvA with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;> rcases hvB with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;>
      rcases hwA with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;> rcases hwB with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;>
      rcases hpair with ⟨p1, p2⟩ | ⟨p1, p2⟩ <;>
      first
        | exact absurd rfl hτ
        | omega
        | exact ⟨rfl, Or.inl ⟨p1, p2, rfl⟩⟩
        | exact ⟨rfl, Or.inr ⟨p1, p2, rfl⟩⟩
  have hτB : τB = τA.flip := by
    cases τA <;> cases τB <;> first | rfl | exact absurd rfl hτ
  set E := ringPt u₁ (φ s₀) - ringPt u₂ (χ s₀) with hE
  have h1 := hdist s₀
  have hE1 : ‖E‖ = 1 := by rw [hE, ← dist_eq_norm, h1]
  set D₁ := dot (I * e (φ s₀)) E with hD₁
  set D₂ := dot (I * e (χ s₀)) E with hD₂
  -- pairs of the linkage just after and just before `s₀`, in the form the first-order lemmas read
  have hnear : ∀ δ' > 0, ∃ η > 0, ∀ s, |s - s₀| < η → |φ s - φ s₀| < δ' ∧ |χ s - χ s₀| < δ' := by
    intro δ' hδ'
    obtain ⟨η₁, hη₁, h₁⟩ := Metric.continuous_iff.mp hφc s₀ δ' hδ'
    obtain ⟨η₂, hη₂, h₂⟩ := Metric.continuous_iff.mp hχc s₀ δ' hδ'
    refine ⟨min η₁ η₂, lt_min hη₁ hη₂, fun s hs => ⟨?_, ?_⟩⟩
    · rw [← Real.dist_eq]; exact h₁ s (by rw [Real.dist_eq]; exact lt_of_lt_of_le hs (min_le_left _ _))
    · rw [← Real.dist_eq]; exact h₂ s (by rw [Real.dist_eq]; exact lt_of_lt_of_le hs (min_le_right _ _))
  have hsgn : ∀ (σ : Side) (x : ℝ), x = σ.sign * (σ.sign * x) ∧ σ.sign * x ≤ |x| := by
    intro σ x
    cases σ
    · exact ⟨by simp only [Side.sign]; ring, by simp only [Side.sign]; linarith [neg_abs_le x]⟩
    · exact ⟨by simp only [Side.sign]; ring, by simp only [Side.sign]; linarith [le_abs_self x]⟩
  have hpt : ∀ (σ τ : Side) (s : ℝ), 0 < σ.sign * (φ s - φ s₀) → 0 < τ.sign * (χ s - χ s₀) → ∀ δ' : ℝ,
      |φ s - φ s₀| < δ' → |χ s - χ s₀| < δ' → ∃ t₁ ∈ Ioo 0 δ', ∃ t₂ ∈ Ioo 0 δ',
        dist (ringPt u₁ (φ s₀ + σ.sign * t₁)) (ringPt u₂ (χ s₀ + τ.sign * t₂)) = 1 := by
    intro σ τ s p1 p2 δ' c1 c2
    obtain ⟨e1, b1⟩ := hsgn σ (φ s - φ s₀)
    obtain ⟨e2, b2⟩ := hsgn τ (χ s - χ s₀)
    refine ⟨σ.sign * (φ s - φ s₀), ⟨p1, lt_of_le_of_lt b1 c1⟩, τ.sign * (χ s - χ s₀), ⟨p2, lt_of_le_of_lt b2 c2⟩, ?_⟩
    rw [← e1, ← e2, show φ s₀ + (φ s - φ s₀) = φ s by ring, show χ s₀ + (χ s - χ s₀) = χ s by ring]
    exact hdist s
  have hafter : ∀ δ' > 0, ∃ t₁ ∈ Ioo 0 δ', ∃ t₂ ∈ Ioo 0 δ',
      dist (ringPt u₁ (φ s₀ + σA.sign * t₁)) (ringPt u₂ (χ s₀ + τA.sign * t₂)) = 1 := by
    intro δ' hδ'
    obtain ⟨η, hη, hηc⟩ := hnear δ' hδ'
    have hm : 0 < min (min δ1 δ3) η := lt_min (lt_min hδ1 hδ3) hη
    set s := s₀ + min (min δ1 δ3) η / 2 with hs
    have hs1' : s ∈ Ioo s₀ (s₀ + δ1) := ⟨by linarith, by linarith [min_le_left (min δ1 δ3) η, min_le_left δ1 δ3]⟩
    have hs3' : s ∈ Ioo s₀ (s₀ + δ3) := ⟨by linarith, by linarith [min_le_left (min δ1 δ3) η, min_le_right δ1 δ3]⟩
    have hsη : |s - s₀| < η := by
      rw [hs, add_sub_cancel_left, abs_of_pos (by linarith)]; linarith [min_le_right (min δ1 δ3) η]
    exact hpt σA τA s (hA1 s hs1').2 (hA2 s hs3').2 δ' (hηc s hsη).1 (hηc s hsη).2
  have hbefore : ∀ δ' > 0, ∃ t₁ ∈ Ioo 0 δ', ∃ t₂ ∈ Ioo 0 δ',
      dist (ringPt u₁ (φ s₀ + σB.sign * t₁)) (ringPt u₂ (χ s₀ + τB.sign * t₂)) = 1 := by
    intro δ' hδ'
    obtain ⟨η, hη, hηc⟩ := hnear δ' hδ'
    have hm : 0 < min (min δ2 δ4) η := lt_min (lt_min hδ2 hδ4) hη
    set s := s₀ - min (min δ2 δ4) η / 2 with hs
    have hs2' : s ∈ Ioo (s₀ - δ2) s₀ := ⟨by linarith [min_le_left (min δ2 δ4) η, min_le_left δ2 δ4], by linarith⟩
    have hs4' : s ∈ Ioo (s₀ - δ4) s₀ := ⟨by linarith [min_le_left (min δ2 δ4) η, min_le_right δ2 δ4], by linarith⟩
    have hsη : |s - s₀| < η := by
      rw [hs, show s₀ - min (min δ2 δ4) η / 2 - s₀ = -(min (min δ2 δ4) η / 2) by ring, abs_neg, abs_of_pos (by linarith)]
      linarith [min_le_right (min δ2 δ4) η]
    exact hpt σB τB s (hB1 s hs2').2 (hB2 s hs4').2 δ' (hηc s hsη).1 (hηc s hsη).2
  -- `D₁ ≠ 0`: else `y₀` is `u₁` or at distance `2` from it
  have hx0 : ringPt u₁ (φ s₀) ≠ u₂ := by
    intro h
    have := dist_ringPt u₁ (φ s₀)
    rw [h, dist_comm] at this; linarith
  have hD₁0 : D₁ ≠ 0 := by
    intro h0
    rcases eq_or_eq_neg_of_dot_I_mul_e hE1 h0 with h | h
    · have hy : ringPt u₂ (χ s₀) = u₁ := by
        rw [hE] at h; simp only [ringPt] at h ⊢; linear_combination -h
      have := dist_ringPt u₂ (χ s₀)
      rw [hy] at this; linarith
    · apply h2
      have hy : ringPt u₂ (χ s₀) = u₁ + 2 * e (φ s₀) := by
        rw [hE] at h; simp only [ringPt] at h ⊢; linear_combination -h
      rw [hy, dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e]; norm_num
  have hσs : σA.sign ≠ 0 := by cases σA <;> simp [Side.sign]
  have hτs : τA.sign ≠ 0 := by cases τA <;> simp [Side.sign]
  have hp0 : σA.sign * D₁ ≠ 0 := mul_ne_zero hσs hD₁0
  have hσBs : σB.sign = -σA.sign := by rw [hσB, Side.sign_flip]
  by_cases hD₂0 : D₂ = 0
  · -- `x` at the end of its arc: its lengthening side is forbidden, and it visits both sides
    rcases lt_or_gt_of_ne hp0 with hneg | hpos
    · obtain ⟨δ, hδ, hfar⟩ := linkage_end u₁ u₂ (φ s₀) (χ s₀) h1 hx0 hD₂0 σB (by rw [hσBs]; linarith)
      obtain ⟨t₁, ht₁, t₂, -, hd⟩ := hbefore δ hδ
      have := hfar t₁ ht₁ (χ s₀ + τB.sign * t₂); linarith
    · obtain ⟨δ, hδ, hfar⟩ := linkage_end u₁ u₂ (φ s₀) (χ s₀) h1 hx0 hD₂0 σA hpos
      obtain ⟨t₁, ht₁, t₂, -, hd⟩ := hafter δ hδ
      have := hfar t₁ ht₁ (χ s₀ + τA.sign * t₂); linarith
  have hq0 : τA.sign * D₂ ≠ 0 := mul_ne_zero hτs hD₂0
  obtain ⟨hlen, hsho⟩ := linkage_cmp u₁ u₂ (φ s₀) (χ s₀) h1 σA τA
  have hn1 : ¬ (0 < σA.sign * D₁ ∧ τA.sign * D₂ < 0) := by
    rintro ⟨a, b⟩
    obtain ⟨δ, hδ, hfar⟩ := hlen a b
    obtain ⟨t₁, ht₁, t₂, ht₂, hd⟩ := hafter δ hδ
    have := hfar t₁ ht₁ t₂ ht₂; linarith
  have hn2 : ¬ (σA.sign * D₁ < 0 ∧ 0 < τA.sign * D₂) := by
    rintro ⟨a, b⟩
    obtain ⟨δ, hδ, hnr⟩ := hsho a b
    obtain ⟨t₁, ht₁, t₂, ht₂, hd⟩ := hafter δ hδ
    have := hnr t₁ ht₁ t₂ ht₂; linarith
  -- what is left is a double event
  have hDE : ∀ s₁ s₂ : Side, (((l₁ - l₂) % 3 = 0 ∧ (r₁ - r₂) % 3 = 0 ∧ s₂ = s₁.flip) ∨
      ((l₁ - r₂) % 3 = 0 ∧ (r₁ - l₂) % 3 = 0 ∧ s₂ = s₁)) → 0 < s₁.sign * D₁ → 0 < s₂.sign * D₂ → False := by
    intro s₁ s₂ hrel' hp hq
    obtain ⟨hvl1, hvr1⟩ := hs1.vals
    obtain ⟨hvl2, hvr2⟩ := hs2.vals
    obtain ⟨Xl, hXl, hXlA, gXl⟩ := hv₁ _ _ .cw (Or.inl ⟨rfl, hvl1⟩)
    obtain ⟨Xr, hXr, hXrA, gXr⟩ := hv₁ _ _ .ccw (Or.inr ⟨rfl, hvr1⟩)
    obtain ⟨Yl, hYl, hYlA, gYl⟩ := hv₂ _ _ .cw (Or.inl ⟨rfl, hvl2⟩)
    obtain ⟨Yr, hYr, hYrA, gYr⟩ := hv₂ _ _ .ccw (Or.inr ⟨rfl, hvr2⟩)
    have hcast : ∀ a b : ℤ, (a - b) % 3 = 0 → (a : ZMod 3) = b := fun a b h =>
      (ZMod.intCast_eq_intCast_iff' a b 3).mpr (by omega)
    have hne : (l₁ : ZMod 3) ≠ r₁ := fun h' => by
      have := (ZMod.intCast_eq_intCast_iff' l₁ r₁ 3).mp h'; omega
    have hXne : Xl ≠ Xr := fun h => hne (by rw [← hXl, ← hXr, h])
    have hx : ringPt u₁ (φ s₀) ∈ F.dom := hc₁ (sphere_subset_closedBall (ringPt_mem_sphere _ _))
    have hy : ringPt u₂ (χ s₀) ∈ F.dom := hc₂ (sphere_subset_closedBall (ringPt_mem_sphere _ _))
    have hHH : ringPt u₁ (φ s₀) ∉ F.fourSet ∪ F.repSet ∧ ringPt u₂ (χ s₀) ∉ F.fourSet ∪ F.repSet :=
      ⟨hH _ (Or.inl (dist_ringPt _ _)), hH _ (Or.inr (dist_ringPt _ _))⟩
    have hpos1 : 0 < dot ((s₁.sign : ℂ) * (I * e (φ s₀))) E := by rw [dot_ofReal_mul]; exact hp
    have hpos2 : 0 < dot ((s₂.sign : ℂ) * (I * e (χ s₀))) E := by rw [dot_ofReal_mul]; exact hq
    rcases hrel' with ⟨p1, p2, rfl⟩ | ⟨p1, p2, rfl⟩
    · have el : Yl = Xl := hg hYlA hXlA (by rw [hYl, hXl]; exact (hcast _ _ p1).symm)
      have er : Yr = Xr := hg hYrA hXrA (by rw [hYr, hXr]; exact (hcast _ _ p2).symm)
      rw [el] at gYl; rw [er] at gYr
      cases s₁
      · exact bv_nd hF hx hy ⟨h1, hXne.symm, .cw, .ccw, hpos1, hpos2, gXr, gXl, gYl, gYr⟩ hHH
      · exact bv_nd hF hx hy ⟨h1, hXne, .ccw, .cw, hpos1, hpos2, gXl, gXr, gYr, gYl⟩ hHH
    · have el : Yr = Xl := hg hYrA hXlA (by rw [hYr, hXl]; exact (hcast _ _ p1).symm)
      have er : Yl = Xr := hg hYlA hXrA (by rw [hYl, hXr]; exact (hcast _ _ p2).symm)
      rw [el] at gYr; rw [er] at gYl
      cases s₂
      · exact bv_nd hF hx hy ⟨h1, hXne.symm, .cw, .cw, hpos1, hpos2, gXr, gXl, gYr, gYl⟩ hHH
      · exact bv_nd hF hx hy ⟨h1, hXne, .ccw, .ccw, hpos1, hpos2, gXl, gXr, gYl, gYr⟩ hHH
  rcases lt_or_gt_of_ne hp0 with hp | hp <;> rcases lt_or_gt_of_ne hq0 with hq | hq
  · refine hDE σA.flip τA.flip ?_ (by rw [Side.sign_flip]; linarith) (by rw [Side.sign_flip]; linarith)
    rcases hrel with ⟨a, b, c⟩ | ⟨a, b, c⟩
    · exact Or.inl ⟨a, b, by rw [c]⟩
    · exact Or.inr ⟨a, b, by rw [c]⟩
  · exact hn2 ⟨hp, hq⟩
  · exact hn1 ⟨hp, hq⟩
  · exact hDE σA τA hrel hp hq

/-- **FS114-BV-HEX, (BV-L3)** — scratch copy of the statement in `HexRing`. -/
theorem bv_l3' {F : ArcMap 6} (hF : F.Valid) {u₁ u₂ : ℂ} (hc₁ : F.Covers u₁ 1) (hc₂ : F.Covers u₂ 1)
    (h3 : (F.coloursAt u₁).ncard = 3) (hsame : F.coloursAt u₁ = F.coloursAt u₂) (ht : 1 < dist u₁ u₂) (ht' : dist u₁ u₂ < 2)
    (hR₁ : F.RingProper u₁) (hR₂ : F.RingProper u₂)
    (hH : ∀ x, (dist x u₁ = 1 ∨ dist x u₂ = 1) → x ∉ F.fourSet ∪ F.repSet) : False := by
  classical
  -- one labelling of the three absent colours, for both rings
  obtain ⟨g, -, hg₁⟩ : ∃ g : Fin 6 → ZMod 3, (F.coloursAt u₁)ᶜ ⊆ g ⁻¹' univ ∧ Set.InjOn g (F.coloursAt u₁)ᶜ := by
    refine (Set.toFinite _).exists_injOn_of_encard_le ?_
    rw [← (Set.toFinite (F.coloursAt u₁)ᶜ).cast_ncard_eq, Set.ncard_compl, Nat.card_eq_fintype_card, Fintype.card_fin, h3,
      Set.encard_univ, ENat.card_eq_coe_fintype_card, ZMod.card]
  have hg₂ : Set.InjOn g (F.coloursAt u₂)ᶜ := hsame ▸ hg₁
  have hno₁ := not_onRingArc_of_finite (F := F) hR₁.1
  have hno₂ := not_onRingArc_of_finite (F := F) hR₂.1
  set C₁ := F.ringCircleColouring hF hc₁ hno₁ g hg₁ with hC₁
  set C₂ := F.ringCircleColouring hF hc₂ hno₂ g hg₂ with hC₂
  have hns₂ : ∀ x, ¬ C₂.IsSwap x := ringCircle_noSwap hF hc₂ hR₂ g hg₂
  obtain ⟨L₁⟩ := CircleColouring.exists_lift C₁
  obtain ⟨L₂⟩ := CircleColouring.exists_lift C₂
  -- generic pairs: two interior points at distance `1` with one label have one colour
  have hgen : ∀ a b : ℝ, dist (ringPt u₁ a) (ringPt u₂ b) = 1 → a ∉ C₁.S → b ∉ C₂.S → (L₁.f a - L₂.f b) % 3 ≠ 0 := by
    intro a b hd ha hb h0
    have hc : C₁.c a = C₂.c b := by
      have h3' : ((L₁.f a - L₂.f b : ℤ) : ZMod 3) = 0 :=
        (ZMod.intCast_zmod_eq_zero_iff_dvd _ 3).mpr (Int.dvd_of_emod_eq_zero h0)
      push_cast at h3'
      rw [L₁.cast_eq _ ha, L₂.cast_eq _ hb] at h3'
      exact sub_eq_zero.mp h3'
    have hxi : ringPt u₁ a ∈ F.interiorPts :=
      F.mem_interiorPts_of_notMem_Γ (hc₁ (sphere_subset_closedBall (ringPt_mem_sphere _ _))) ha
    have hyi : ringPt u₂ b ∈ F.interiorPts :=
      F.mem_interiorPts_of_notMem_Γ (hc₂ (sphere_subset_closedBall (ringPt_mem_sphere _ _))) hb
    have hxa : F.col (ringPt u₁ a) ∈ (F.coloursAt u₁)ᶜ :=
      not_mem_coloursAt_of_mem_sphere hF (ringPt_mem_sphere _ _) ⟨hxi, rfl⟩
    have hya : F.col (ringPt u₂ b) ∈ (F.coloursAt u₁)ᶜ := by
      rw [hsame]; exact not_mem_coloursAt_of_mem_sphere hF (ringPt_mem_sphere _ _) ⟨hyi, rfl⟩
    exact hF _ hxi _ hyi hd (hg₁ hxa hya hc)
  -- the rings' one-sided values are germs of the map, in colours absent at `u₁`
  have hv₁ : ∀ (x : ℝ) (a : ZMod 3) (s : Side), (s = .cw ∧ C₁.LeftVal x a) ∨ (s = .ccw ∧ C₁.RightVal x a) →
      ∃ X, g X = a ∧ X ∈ (F.coloursAt u₁)ᶜ ∧ GermIn u₁ x s (F.region X) := fun x a s h =>
    ringCircle_val_germ hF hc₁ hno₁ g hg₁ s h
  have hv₂ : ∀ (x : ℝ) (a : ZMod 3) (s : Side), (s = .cw ∧ C₂.LeftVal x a) ∨ (s = .ccw ∧ C₂.RightVal x a) →
      ∃ X, g X = a ∧ X ∈ (F.coloursAt u₁)ᶜ ∧ GermIn u₂ x s (F.region X) := fun x a s h => by
    obtain ⟨X, e1, e2, e3⟩ := ringCircle_val_germ hF hc₂ hno₂ g hg₂ s h
    exact ⟨X, e1, by rw [hsame]; exact e2, e3⟩
  exact l3_core ht ht' L₁ L₂ hns₂ C₁.S_inter_Icc_finite C₂.S_inter_Icc_finite subset_rfl subset_rfl hgen
    fun hφc hχc hφf hχf hdist _ h2 _ _ _ _ hs1 hs2 hj1 hj2 hpair =>
      bv_l3_dbl hF hc₁ hc₂ ht hH hg₁ L₁ L₂ hv₁ hv₂ hgen hφc hχc hφf hχf hdist h2 hs1 hs2 hj1 hj2 hpair

end ArcMap

end HadwigerNelson.Plane
