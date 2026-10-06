import Proofs.HadwigerNelson.Plane.ValidMap.CollarMapOut
import Proofs.HadwigerNelson.Plane.ValidMap.R2Cap
import Proofs.HadwigerNelson.Plane.ValidMap.HornChart

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## The horn clause of a collar bend, either way (FS131-BA2; plan § 4) -/

/-- **A circle tangent to `ω(P)` from inside or around meets it only at the point of tangency**: a point of `ω(P)` on the circle of
radius `R ≠ 1` about `P + (1 − R) e(θ)` is `r(θ)`. -/
theorem eq_ringPt_of_mem_tangentCircle {P z : ℂ} {θ R : ℝ} (hR1 : R ≠ 1) (hz1 : dist z P = 1)
    (hzR : dist z (P + ((1 - R : ℝ) : ℂ) * e θ) = R) : z = ringPt P θ := by
  have h1 := r2_dist_sq_center P θ z
  have h2 := r2_dist_sq P θ (1 + R) z
  rw [show (2 - (1 + R) : ℝ) = 1 - R by ring, hzR] at h2
  rw [hz1] at h1
  have h3 : (R - 1) * (1 + r2Y P θ z) = 0 := by linear_combination (h1 - h2) / 2
  have hY : r2Y P θ z = -1 := by
    rcases mul_eq_zero.mp h3 with h | h
    · exact absurd (by linarith) hR1
    · linarith
  have hX : r2X P θ z = 0 := by
    have : r2X P θ z ^ 2 = 0 := by rw [hY] at h1; linarith
    exact pow_eq_zero_iff (two_ne_zero) |>.mp this
  have hf := r2_frame P θ z
  rw [hY, hX] at hf
  have hf' : z - (P + 2 * e θ) = -e θ := by rw [hf]; push_cast; ring
  rw [ringPt]
  linear_combination hf'

/-- **Two circles of one radius whose centres are apart, and closer than a diameter, cross**: at a common point the two radii are not
parallel. -/
theorem im_ne_zero_of_two_spheres {x q q' : ℂ} {R : ℝ} (hq : dist x q = R) (hq' : dist x q' = R) (hne : q ≠ q')
    (hlt : dist q q' < 2 * R) : ((x - q) * starRingEnd ℂ (x - q')).im ≠ 0 := by
  intro him
  have hR : 0 < R := by
    have := dist_pos.mpr hne
    linarith
  have hu : Complex.normSq (x - q) = R ^ 2 := by rw [Complex.normSq_eq_norm_sq, ← dist_eq_norm, hq]
  have hv : Complex.normSq (x - q') = R ^ 2 := by rw [Complex.normSq_eq_norm_sq, ← dist_eq_norm, hq']
  have hprod : Complex.normSq ((x - q) * starRingEnd ℂ (x - q')) = R ^ 2 * R ^ 2 := by
    rw [Complex.normSq_mul, Complex.normSq_conj, hu, hv]
  rw [Complex.normSq_apply, him] at hprod
  have hsub := Complex.normSq_sub (x - q) (x - q')
  rw [hu, hv, show x - q - (x - q') = q' - q by ring, Complex.normSq_eq_norm_sq, ← dist_eq_norm, dist_comm] at hsub
  have hd0 := dist_pos.mpr hne
  set a := ((x - q) * starRingEnd ℂ (x - q')).re with ha
  have hfac : (a - R ^ 2) * (a + R ^ 2) = 0 := by nlinarith
  rcases mul_eq_zero.mp hfac with h | h
  · have : dist q q' ^ 2 = 0 := by rw [hsub]; linarith
    nlinarith
  · have : dist q q' ^ 2 = (2 * R) ^ 2 := by rw [hsub]; linarith
    nlinarith

/-- **A branch at an end of the arc, in the end's frame**: the branch from `r(θ_E)` along the arc's direction on the side `σ`, of
curvature `σ/ρ`, is `P + (1 + s e(σ(π/2 + arcsin(s/(2ρ))))) e(θ_E)`. -/
theorem branchPt_end_frame (P : ℂ) (θE ρ s : ℝ) {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) :
    branchPt (ringPt P θE) (θE + σ * (π / 2)) (σ / ρ) s =
      P + (1 + (s : ℂ) * e (σ * (π / 2 + Real.arcsin (s / (2 * ρ))))) * e θE := by
  have harc : Real.arcsin (σ / ρ * s / 2) = σ * Real.arcsin (s / (2 * ρ)) := by
    rcases hσ with rfl | rfl
    · rw [one_mul]; congr 1; ring
    · rw [show (-1 : ℝ) / ρ * s / 2 = -(s / (2 * ρ)) by ring, Real.arcsin_neg]; ring
  rw [branchPt, harc, ringPt, show θE + σ * (π / 2) + σ * Real.arcsin (s / (2 * ρ)) =
    σ * (π / 2 + Real.arcsin (s / (2 * ρ))) + θE by ring, e_add]
  ring

/-- `e (σ φ)` is `e φ` or its conjugate. -/
theorem e_sign_mul {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) (φ : ℝ) :
    (σ = 1 ∧ e (σ * φ) = e φ) ∨ (σ = -1 ∧ e (σ * φ) = starRingEnd ℂ (e φ)) := by
  rcases hσ with rfl | rfl
  · exact Or.inl ⟨rfl, by rw [one_mul]⟩
  · exact Or.inr ⟨rfl, by rw [neg_one_mul, conj_e]⟩

/-- **A branch at an end of the arc lies on its tangent circle** (`germ_tangentCircle`, in either direction). -/
theorem dist_branchPt_end (P : ℂ) (θE : ℝ) {ρ s σ : ℝ} (hσ : σ = 1 ∨ σ = -1) (hρ : 0 < ρ) (hs : 0 ≤ s) (hs2 : s ≤ 2 * ρ) :
    dist (branchPt (ringPt P θE) (θE + σ * (π / 2)) (σ / ρ) s) (P + ((1 - ρ : ℝ) : ℂ) * e θE) = ρ := by
  obtain ⟨g1, -, -⟩ := germ_tangentCircle hρ hs hs2
  rw [branchPt_end_frame P θE ρ s hσ, dist_eq_norm,
    show P + (1 + (s : ℂ) * e (σ * (π / 2 + Real.arcsin (s / (2 * ρ))))) * e θE - (P + ((1 - ρ : ℝ) : ℂ) * e θE) =
      (1 + (s : ℂ) * e (σ * (π / 2 + Real.arcsin (s / (2 * ρ)))) - ((1 - ρ : ℝ) : ℂ)) * e θE by ring, norm_mul, norm_e, mul_one]
  rcases e_sign_mul hσ (π / 2 + Real.arcsin (s / (2 * ρ))) with ⟨-, h⟩ | ⟨-, h⟩
  · rw [h]; exact g1
  · have key : ‖1 + (s : ℂ) * starRingEnd ℂ (e (π / 2 + Real.arcsin (s / (2 * ρ)))) - ((1 - ρ : ℝ) : ℂ)‖ =
        ‖1 + (s : ℂ) * e (π / 2 + Real.arcsin (s / (2 * ρ))) - ((1 - ρ : ℝ) : ℂ)‖ := by
      rw [← RCLike.norm_conj (1 + (s : ℂ) * e (π / 2 + Real.arcsin (s / (2 * ρ))) - ((1 - ρ : ℝ) : ℂ))]
      congr 1
      simp only [map_sub, map_add, map_one, map_mul, Complex.conj_ofReal]
    rw [h, key]; exact g1

/-- **A branch at an end of the arc, in polar form about `P`** (`germ_tangentCircle`, `polar_tangentCircle`, `eq_of_tangentCircle`, the
intermediate value theorem on the chord): for `ρ > 1/2` and a chord `s ≤ 1`, the branch point is `P + tangRad ρ u · e(θ_E + σ u)` for an
angle `u ∈ [0, π/2]` whose chord is `s`. -/
theorem branchPt_end_polar (P : ℂ) (θE : ℝ) {ρ s σ : ℝ} (hσ : σ = 1 ∨ σ = -1) (hρ : 1 / 2 < ρ) (hs : 0 ≤ s) (hs1 : s ≤ 1) :
    ∃ u ∈ Icc (0 : ℝ) (π / 2), branchPt (ringPt P θE) (θE + σ * (π / 2)) (σ / ρ) s = P + (tangRad ρ u : ℂ) * e (θE + σ * u) ∧
      ‖(tangRad ρ u : ℂ) * e u - 1‖ = s := by
  have hπ := Real.pi_pos
  have hρ0 : 0 < ρ := by linarith
  have hcont : Continuous fun u : ℝ => ‖(tangRad ρ u : ℂ) * e u - 1‖ :=
    ((Complex.continuous_ofReal.comp (continuous_tangRad ρ)).mul continuous_e).sub continuous_const |>.norm
  have hf0 : ‖(tangRad ρ 0 : ℂ) * e 0 - 1‖ = 0 := by rw [tangRad_zero hρ0.le, e_zero]; simp
  have hf1 : s ≤ ‖(tangRad ρ (π / 2) : ℂ) * e (π / 2) - 1‖ := by
    obtain ⟨-, -, h3⟩ := polar_tangentCircle hρ (show (0 : ℝ) ≤ π / 2 by linarith) (by linarith)
    rw [Real.cos_pi_div_two, mul_zero, sub_zero, mul_one] at h3
    have hn := norm_nonneg ((tangRad ρ (π / 2) : ℂ) * e (π / 2) - 1)
    nlinarith
  obtain ⟨u, hu, hus⟩ := intermediate_value_Icc (show (0 : ℝ) ≤ π / 2 by linarith) hcont.continuousOn
    (show s ∈ Icc (‖(tangRad ρ 0 : ℂ) * e 0 - 1‖) (‖(tangRad ρ (π / 2) : ℂ) * e (π / 2) - 1‖) from ⟨by rw [hf0]; exact hs, hf1⟩)
  have hus' : ‖(tangRad ρ u : ℂ) * e u - 1‖ = s := hus
  refine ⟨u, hu, ?_, hus'⟩
  obtain ⟨g1, g2, g3⟩ := germ_tangentCircle hρ0 hs (by linarith)
  obtain ⟨p1, p2, -⟩ := polar_tangentCircle hρ hu.1 (by linarith [hu.2])
  have heq : 1 + (s : ℂ) * e (π / 2 + Real.arcsin (s / (2 * ρ))) = (tangRad ρ u : ℂ) * e u :=
    eq_of_tangentCircle hρ0 g1 p1 g2 p2 (by rw [g3, hus'])
  rw [branchPt_end_frame P θE ρ s hσ, e_add, mul_comm (e θE), ← mul_assoc]
  congr 2
  rcases e_sign_mul hσ (π / 2 + Real.arcsin (s / (2 * ρ))) with ⟨rfl, h⟩ | ⟨rfl, h⟩
  · rw [h, heq, one_mul]
  · rw [h, neg_one_mul, ← conj_e u, ← Complex.conj_ofReal (tangRad ρ u), ← map_mul, ← heq]
    simp only [map_add, map_one, map_mul, Complex.conj_ofReal]

/-- **The arc's own branch at an end**: the branch of curvature `σ` is `ω(P)`, the point at chord `s ≤ 1` being `r(θ_E + σ u)` with
`2 sin (u/2) = s`, `u ∈ [0, π/2]`. -/
theorem branchPt_end_unit (P : ℂ) (θE : ℝ) {s σ : ℝ} (hσ : σ = 1 ∨ σ = -1) (hs : 0 ≤ s) (hs1 : s ≤ 1) :
    ∃ u ∈ Icc (0 : ℝ) (π / 2), branchPt (ringPt P θE) (θE + σ * (π / 2)) σ s = ringPt P (θE + σ * u) ∧
      2 * Real.sin (u / 2) = s := by
  have hπ := Real.pi_pos
  obtain ⟨u, hu, h1, h2⟩ := branchPt_end_polar P θE (ρ := 1) hσ (by norm_num) hs hs1
  refine ⟨u, hu, ?_, ?_⟩
  · have ht : tangRad 1 u = 1 := by unfold tangRad; norm_num
    rw [div_one, ht] at h1
    rw [h1, ringPt]; simp
  · have ht : tangRad 1 u = 1 := by unfold tangRad; norm_num
    rw [ht] at h2
    have h3 := norm_e_sub_e_eq u 0
    rw [e_zero, sub_zero, abs_of_nonneg (Real.sin_nonneg_of_nonneg_of_le_pi (by linarith [hu.1]) (by linarith [hu.2]))] at h3
    rw [← h3, ← h2]; simp

/-- On `[0, π/2]` a smaller sine is a smaller angle. -/
theorem lt_of_sin_lt_sin {u u₁ : ℝ} (hu : u ∈ Icc (0 : ℝ) (π / 2)) (hu₁ : 0 ≤ u₁) (h : Real.sin u < Real.sin u₁) : u < u₁ := by
  have hπ := Real.pi_pos
  by_contra hle
  push Not at hle
  have := Real.sin_le_sin_of_le_of_le_pi_div_two (by linarith) hu.2 hle
  linarith

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **The horn count at an end of a collar bend is kept** (plan § 4, the end case; either bend, either end): `M`'s `Γ` is `F`'s with the
open arc cut out, the lens arc from the end `r(θ_E)` (the germ arc of curvature `σ/R` along the arc's direction) and a closed set off
the end; `F.Γ` meets the collar only on the arc. Near the end `Γ_M` is `Γ_F` with the arc's branch (curvature `σ`) replaced by the lens
arc's (curvature `σ/R`), and a branch of a curvature between lies in the collar off `ω(P)` — `hasHornCount_iff_of_germ_swap`. -/
theorem hasHornCount_iff_collar_end {M : ArcMap k} {P : ℂ} {θ₁ θ₂ θE σ R' R R'' dE : ℝ} {L' : Set ℂ}
    (hσE : (σ = 1 ∧ θE = θ₁) ∨ (σ = -1 ∧ θE = θ₂)) (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3)
    (hR' : 1 / 2 < R') (hR'R : R' < R) (hR'1 : R' < 1) (hRR'' : R < R'') (h1R'' : 1 < R'') (hR1 : R ≠ 1)
    (hdom : M.dom = F.dom) (hring : ringArc P θ₁ θ₂ ⊆ F.Γ) (hfree : F.Γ ∩ collarK P θ₁ θ₂ R' R'' ⊆ ringArc P θ₁ θ₂)
    (hdE : 0 < dE) (hdE2 : dE ≤ 2 * R) (hL' : IsClosed L') (hxL' : ringPt P θE ∉ L')
    (hΓ : M.Γ = (F.Γ \ ringPt P '' Ioo θ₁ θ₂) ∪
      ((germArc (ringPt P θE) (θE + σ * (π / 2)) (σ / R) dE).carrier ∪ L')) (j : ℕ) :
    M.HasHornCount (ringPt P θE) j ↔ F.HasHornCount (ringPt P θE) j := by
  have hπ := Real.pi_pos
  have hσ : σ = 1 ∨ σ = -1 := hσE.elim (fun h => Or.inl h.1) (fun h => Or.inr h.1)
  have hσabs : |σ| = 1 := by rcases hσ with rfl | rfl <;> simp
  have hσ2 : σ * σ = 1 := by rcases hσ with rfl | rfl <;> norm_num
  have hR0 : 0 < R := by linarith
  have hℓ0 : 0 < θ₂ - θ₁ := by linarith
  have hθE : θE ∈ Icc θ₁ θ₂ := by
    rcases hσE with ⟨-, rfl⟩ | ⟨-, rfl⟩
    · exact ⟨le_rfl, h12.le⟩
    · exact ⟨h12.le, le_rfl⟩
  have hang : ∀ u : ℝ, 0 ≤ u → u ≤ θ₂ - θ₁ → θE + σ * u ∈ Icc θ₁ θ₂ := by
    intro u h0 h1
    rcases hσE with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;> constructor <;> linarith
  have hangO : ∀ u : ℝ, 0 < u → u < θ₂ - θ₁ → θE + σ * u ∈ Ioo θ₁ θ₂ := by
    intro u h0 h1
    rcases hσE with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;> constructor <;> linarith
  -- near angle `0` the other end's two profiles stay off `1`
  obtain ⟨u₀, hu₀, hprof⟩ : ∃ u₀ > 0, ∀ u : ℝ, |u| < u₀ →
      tangRad R' (θ₂ - θ₁ - u) < tangRad R' u ∧ tangRad R'' u < tangRad R'' (θ₂ - θ₁ - u) := by
    have hc1 : Continuous fun u : ℝ => tangRad R' u - tangRad R' (θ₂ - θ₁ - u) :=
      (continuous_tangRad R').sub ((continuous_tangRad R').comp (continuous_const.sub continuous_id))
    have hc2 : Continuous fun u : ℝ => tangRad R'' (θ₂ - θ₁ - u) - tangRad R'' u :=
      ((continuous_tangRad R'').comp (continuous_const.sub continuous_id)).sub (continuous_tangRad R'')
    have hab : 0 < |θ₂ - θ₁| ∧ |θ₂ - θ₁| ≤ π := by rw [abs_of_pos hℓ0]; exact ⟨hℓ0, by linarith⟩
    have h1 : (0 : ℝ) < tangRad R' 0 - tangRad R' (θ₂ - θ₁ - 0) := by
      rw [tangRad_zero (by linarith), sub_zero]
      linarith [tangRad_lt_one hR' hR'1 hab.1 hab.2]
    have h2 : (0 : ℝ) < tangRad R'' (θ₂ - θ₁ - 0) - tangRad R'' 0 := by
      rw [tangRad_zero (by linarith), sub_zero]
      linarith [one_lt_tangRad h1R'' hab.1 hab.2]
    obtain ⟨ε, hε, hball⟩ := Metric.eventually_nhds_iff.mp
      ((hc1.continuousAt.eventually (lt_mem_nhds h1)).and (hc2.continuousAt.eventually (lt_mem_nhds h2)))
    refine ⟨ε, hε, fun u hu => ?_⟩
    have := hball (show dist u 0 < ε by rwa [Real.dist_eq, sub_zero])
    exact ⟨by linarith [this.1], by linarith [this.2]⟩
  obtain ⟨u₁, hu₁0, hu₁u₀, hu₁ℓ⟩ : ∃ u₁ > 0, u₁ ≤ u₀ ∧ u₁ ≤ θ₂ - θ₁ := ⟨min u₀ (θ₂ - θ₁), lt_min hu₀ hℓ0, min_le_left _ _, min_le_right _ _⟩
  have hsu₁ : 0 < Real.sin u₁ := Real.sin_pos_of_pos_of_lt_pi hu₁0 (by linarith)
  obtain ⟨δ', hδ', hballL⟩ := Metric.isOpen_iff.mp hL'.isOpen_compl _ hxL'
  obtain ⟨r, hr, hr2, hrd, hrδ, hrs⟩ : ∃ r > 0, r ≤ 1 / 2 ∧ r ≤ dE ∧ r ≤ δ' ∧ 2 * r ≤ Real.sin u₁ := by
    refine ⟨min (min (1 / 2) dE) (min δ' (Real.sin u₁ / 2)), lt_min (lt_min (by norm_num) hdE) (lt_min hδ' (by linarith)),
      (min_le_left _ _).trans (min_le_left _ _), (min_le_left _ _).trans (min_le_right _ _),
      (min_le_right _ _).trans (min_le_left _ _), ?_⟩
    have h1 : min (min (1 / 2) dE) (min δ' (Real.sin u₁ / 2)) ≤ Real.sin u₁ / 2 :=
      (min_le_right _ _).trans (min_le_right _ _)
    linarith
  -- the arc's own branch near the end
  have hunit : ∀ s ∈ Ioo 0 r, ∃ u, 0 < u ∧ u < u₁ ∧
      branchPt (ringPt P θE) (θE + σ * (π / 2)) σ s = ringPt P (θE + σ * u) ∧ 2 * Real.sin (u / 2) = s := by
    intro s hs
    obtain ⟨u, hu, h1, h2⟩ := branchPt_end_unit P θE hσ hs.1.le (by linarith [hs.2])
    have hu0 : 0 < u := by
      rcases eq_or_lt_of_le hu.1 with h | h
      · rw [← h] at h2; simp at h2; linarith [hs.1]
      · exact h
    refine ⟨u, hu0, ?_, h1, h2⟩
    have hsin : Real.sin u ≤ s := by
      have h3 := Real.sin_two_mul (u / 2)
      rw [show 2 * (u / 2) = u by ring] at h3
      have hc := Real.cos_le_one (u / 2)
      have hs0 : 0 ≤ Real.sin (u / 2) := Real.sin_nonneg_of_nonneg_of_le_pi (by linarith) (by linarith [hu.2])
      nlinarith
    exact lt_of_sin_lt_sin hu hu₁0.le (by linarith [hs.2])
  -- a branch of radius `ρ` near the end, in polar form
  have hpolar : ∀ ρ : ℝ, 1 / 2 < ρ → ∀ s ∈ Ioo 0 r, ∃ u, 0 < u ∧ u < u₁ ∧
      branchPt (ringPt P θE) (θE + σ * (π / 2)) (σ / ρ) s = P + (tangRad ρ u : ℂ) * e (θE + σ * u) := by
    intro ρ hρ s hs
    obtain ⟨u, hu, h1, h2⟩ := branchPt_end_polar P θE hσ hρ hs.1.le (by linarith [hs.2])
    have ht := tangRad_pos hρ u
    have hu0 : 0 < u := by
      rcases eq_or_lt_of_le hu.1 with h | h
      · rw [← h, tangRad_zero (by linarith), e_zero] at h2; simp at h2; linarith [hs.1]
      · exact h
    refine ⟨u, hu0, ?_, h1⟩
    have hnorm : ‖(tangRad ρ u : ℂ) * e u‖ = tangRad ρ u := by
      rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg ht.le]
    have htge : 1 - s ≤ tangRad ρ u := by
      have h3 := norm_sub_norm_le (1 : ℂ) ((tangRad ρ u : ℂ) * e u)
      rw [norm_one, hnorm, norm_sub_rev, h2] at h3
      linarith
    have him : tangRad ρ u * Real.sin u ≤ s := by
      have h3 := Complex.abs_im_le_norm ((tangRad ρ u : ℂ) * e u - 1)
      rw [h2, Complex.sub_im, Complex.im_ofReal_mul, im_e, Complex.one_im, sub_zero] at h3
      exact (le_abs_self _).trans h3
    have hsu : 0 ≤ Real.sin u := Real.sin_nonneg_of_nonneg_of_le_pi hu.1 (by linarith [hu.2])
    refine lt_of_sin_lt_sin hu hu₁0.le ?_
    nlinarith [hs.2, mul_nonneg hsu (show (0 : ℝ) ≤ tangRad ρ u - 1 / 2 by linarith [hs.2])]
  have hdistb : ∀ {β κ s : ℝ}, 0 < s → dist (branchPt (ringPt P θE) β κ s) (ringPt P θE) = s := fun {β κ s} hs => by
    rw [dist_eq_norm, norm_branchPt_sub _ _ _ hs.le]
  have hneb : ∀ {β κ s : ℝ}, 0 < s → branchPt (ringPt P θE) β κ s ≠ ringPt P θE := fun {β κ s} hs h => by
    have := hdistb (β := β) (κ := κ) hs
    rw [h, dist_self] at this
    linarith
  have hκR : |σ / R| * dE ≤ 2 := by
    rw [abs_div, hσabs, abs_of_pos hR0, div_mul_eq_mul_div, one_mul, div_le_iff₀ hR0]; linarith
  refine hasHornCount_iff_of_germ_swap (F := F) (M := M) (β₀ := θE + σ * (π / 2)) (κ₀ := σ) (κ₀' := σ / R) (r := r)
    (hring ⟨θE, hθE, rfl⟩).1 hdom hr ?_ ?_ ?_ ?_ ?_ j
  · rw [hσabs]; linarith
  · rw [abs_div, hσabs, abs_of_pos hR0, div_mul_eq_mul_div, one_mul, div_lt_iff₀ hR0]; nlinarith
  · -- the arc's branch lies in `Γ`
    rintro _ ⟨s, hs, rfl⟩
    obtain ⟨u, hu0, hu1, h1, -⟩ := hunit s hs
    rw [h1]
    exact hring ⟨_, hang u hu0.le (hu1.le.trans hu₁ℓ), rfl⟩
  · -- `Γ_M` near the end
    rw [hΓ, carrier_germArc _ _ hdE.le hκR]
    ext z
    constructor
    · rintro ⟨⟨hzM, hzb⟩, hzx⟩
      rcases hzM with ⟨hzΓ, hzO⟩ | ⟨s, hs, rfl⟩ | hzL
      · refine Or.inl ⟨⟨⟨hzΓ, hzb⟩, hzx⟩, ?_⟩
        rintro ⟨s, hs, rfl⟩
        obtain ⟨u, hu0, hu1, h1, -⟩ := hunit s hs
        exact hzO ⟨_, hangO u hu0 (hu1.trans_le hu₁ℓ), h1.symm⟩
      · have hs0 : 0 < s := lt_of_le_of_ne hs.1 fun h => hzx (by rw [← h]; simp [branchPt])
        rw [mem_ball, hdistb hs0] at hzb
        exact Or.inr ⟨s, ⟨hs0, hzb⟩, rfl⟩
      · exact absurd hzL (hballL (ball_subset_ball hrδ hzb))
    · rintro (⟨⟨⟨hzΓ, hzb⟩, hzx⟩, hzB⟩ | ⟨s, hs, rfl⟩)
      · refine ⟨⟨Or.inl ⟨hzΓ, ?_⟩, hzb⟩, hzx⟩
        rintro ⟨θ, hθ, rfl⟩
        apply hzB
        have hs'0 : 0 < dist (ringPt P θ) (ringPt P θE) := dist_pos.mpr hzx
        have hs'r : dist (ringPt P θ) (ringPt P θE) < r := hzb
        obtain ⟨u, hu0, hu1, h1, h2⟩ := hunit _ ⟨hs'0, hs'r⟩
        refine ⟨_, ⟨hs'0, hs'r⟩, ?_⟩
        rw [h1]
        have hv : 0 < σ * (θ - θE) ∧ σ * (θ - θE) ≤ θ₂ - θ₁ := by
          rcases hσE with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;> constructor <;> linarith [hθ.1, hθ.2]
        have hchord : dist (ringPt P θ) (ringPt P θE) = 2 * Real.sin (σ * (θ - θE) / 2) := by
          rw [dist_eq_norm, ringPt, ringPt, add_sub_add_left_eq_sub, norm_e_sub_e_eq]
          have hnn : 0 ≤ Real.sin (σ * (θ - θE) / 2) :=
            Real.sin_nonneg_of_nonneg_of_le_pi (by linarith [hv.1]) (by linarith [hv.2])
          rcases hσ with rfl | rfl
          · rw [one_mul] at hnn ⊢; rw [abs_of_nonneg hnn]
          · rw [show -1 * (θ - θE) / 2 = -((θ - θE) / 2) by ring, Real.sin_neg] at hnn ⊢
            rw [abs_of_nonpos (by linarith)]
        have hsin : Real.sin (u / 2) = Real.sin (σ * (θ - θE) / 2) := by linarith
        have hu2 : u ≤ π / 2 := by linarith [hu1]
        have huv := Real.injOn_sin ⟨by linarith, by linarith⟩ ⟨by linarith [hv.1], by linarith [hv.2]⟩ hsin
        have hσu : σ * u = θ - θE := by
          have : u = σ * (θ - θE) := by linarith
          rw [this, ← mul_assoc, hσ2, one_mul]
        rw [hσu]; ring_nf
      · exact ⟨⟨Or.inr (Or.inl ⟨s, ⟨hs.1.le, hs.2.le.trans hrd⟩, rfl⟩), by rw [mem_ball, hdistb hs.1]; exact hs.2⟩, hneb hs.1⟩
  · -- a branch of a curvature between lies in the collar, off `ω(P)`
    intro κ hκ1 hκ2 hκne s hs hzΓ
    have hm : min 1 (1 / R) ≤ σ * κ ∧ σ * κ ≤ max 1 (1 / R) := by
      rcases hσ with rfl | rfl
      · rw [one_mul]; exact ⟨hκ1, hκ2⟩
      · rw [neg_div, min_neg_neg] at hκ1
        rw [neg_div, max_neg_neg] at hκ2
        exact ⟨by linarith, by linarith⟩
    have hinv : 0 < 1 / R := by positivity
    have hm0 : 0 < σ * κ := lt_of_lt_of_le (lt_min one_pos hinv) hm.1
    have hm1 : σ * κ ≠ 1 := fun h => hκne (by have := congrArg (σ * ·) h; simpa [← mul_assoc, hσ2] using this)
    have hκρ : κ = σ / (1 / (σ * κ)) := by
      rw [div_div_eq_mul_div, div_one, ← mul_assoc, hσ2, one_mul]
    have hρlo : R' < 1 / (σ * κ) := by
      rw [lt_div_iff₀ hm0]
      rcases le_max_iff.mp hm.2 with h | h
      · nlinarith
      · have : σ * κ * R ≤ 1 := by rwa [le_div_iff₀ hR0] at h
        nlinarith
    have hρhi : 1 / (σ * κ) < R'' := by
      rw [div_lt_iff₀ hm0]
      rcases min_le_iff.mp hm.1 with h | h
      · nlinarith
      · have : 1 ≤ σ * κ * R := by rwa [div_le_iff₀ hR0] at h
        nlinarith
    have hρ1 : 1 / (σ * κ) ≠ 1 := fun h => hm1 (by rw [div_eq_one_iff_eq hm0.ne'] at h; exact h.symm)
    obtain ⟨u, hu0, hu1, hz⟩ := hpolar (1 / (σ * κ)) (by linarith) s hs
    rw [← hκρ] at hz
    have huabs : 0 < |u| ∧ |u| ≤ π := by rw [abs_of_pos hu0]; exact ⟨hu0, by linarith⟩
    have hρ2 : (1 : ℝ) / 2 < 1 / (σ * κ) := by linarith
    have ht := tangRad_pos hρ2 u
    have a1 := tangRad_lt_tangRad hR' hρlo huabs.1 huabs.2
    have a2 := tangRad_lt_tangRad hρ2 hρhi huabs.1 huabs.2
    obtain ⟨a3, a4⟩ := hprof u (by rw [abs_of_pos hu0]; linarith)
    have hθ := hang u hu0.le (hu1.le.trans hu₁ℓ)
    have hclamp : clampAngle θ₁ θ₂ (θE + σ * u) = θE + σ * u := by
      unfold clampAngle; rw [min_eq_left hθ.2, max_eq_right hθ.1]
    have hzK : branchPt (ringPt P θE) (θE + σ * (π / 2)) κ s ∈ collarK P θ₁ θ₂ R' R'' := by
      rw [hz]
      refine ⟨_, hθ, _, ⟨?_, ?_⟩, rfl⟩
      · unfold lensProf
        rw [hclamp]
        rcases hσE with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
        · rw [show θE + 1 * u - θE = u by ring, show θ₂ - (θE + 1 * u) = θ₂ - θE - u by ring]
          exact max_le a1.le (a3.le.trans a1.le)
        · rw [show θE + -1 * u - θ₁ = θE - θ₁ - u by ring, show θE - (θE + -1 * u) = u by ring]
          exact max_le (a3.le.trans a1.le) a1.le
      · unfold outerProf
        rw [hclamp]
        rcases hσE with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
        · rw [show θE + 1 * u - θE = u by ring, show θ₂ - (θE + 1 * u) = θ₂ - θE - u by ring]
          exact le_min a2.le (a2.le.trans a4.le)
        · rw [show θE + -1 * u - θ₁ = θE - θ₁ - u by ring, show θE - (θE + -1 * u) = u by ring]
          exact le_min (a2.le.trans a4.le) a2.le
    obtain ⟨θ', -, hθ'⟩ := hfree ⟨hzΓ, hzK⟩
    have hd1 : dist (branchPt (ringPt P θE) (θE + σ * (π / 2)) κ s) P = 1 := by rw [← hθ']; exact dist_ringPt P θ'
    rw [hz, dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg ht.le] at hd1
    rcases lt_or_gt_of_ne hρ1 with h | h
    · linarith [tangRad_lt_one hρ2 h huabs.1 huabs.2]
    · linarith [one_lt_tangRad h huabs.1 huabs.2]

/-- **The horn clause of a collar bend, either way** (plan § 4): `M` agrees with `F` off the closed collar, whose `Γ` is the arc; `M`'s
`Γ` is `F`'s with the open arc cut out and the two lens arcs (germ arcs of curvature `±1/R`, `R ≠ 1`, from the ends). Then no horn count
rises: off the collar the maps agree near the point (`hasHornCount_iff_of_agree`); in the collar and not an end the point is interior
in `M` or on the lens arcs, which lie on two circles that cross (`hasHornCount_zero_of_two_spheres`); at an end the count is kept
(`hasHornCount_iff_collar_end`). -/
theorem hornCount_le_of_collarBend {M : ArcMap k} {P : ℂ} {θ₁ θ₂ R' R R'' dA dB : ℝ} (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3)
    (hR' : 1 / 2 < R') (hR'R : R' < R) (hR'1 : R' < 1) (hRR'' : R < R'') (h1R'' : 1 < R'') (hR1 : R ≠ 1)
    (hdom : M.dom = F.dom) (hKdom : collarK P θ₁ θ₂ R' R'' ⊆ F.dom) (hKcl : IsClosed (collarK P θ₁ θ₂ R' R''))
    (hring : ringArc P θ₁ θ₂ ⊆ F.Γ) (hfree : F.Γ ∩ collarK P θ₁ θ₂ R' R'' ⊆ ringArc P θ₁ θ₂)
    (hag : ∀ z ∉ collarK P θ₁ θ₂ R' R'', (z ∈ M.interiorPts ↔ z ∈ F.interiorPts))
    (hdA : 0 < dA) (hdA2 : dA ≤ 2 * R) (hdB : 0 < dB) (hdB2 : dB ≤ 2 * R)
    (hΓ : M.Γ = (F.Γ \ ringPt P '' Ioo θ₁ θ₂) ∪ ((germArc (ringPt P θ₁) (θ₁ + π / 2) (1 / R) dA).carrier ∪
      (germArc (ringPt P θ₂) (θ₂ - π / 2) (-(1 / R)) dB).carrier))
    {x : ℂ} {j : ℕ} (hj : F.HasHornCount x j) : ∃ j' ≤ j, M.HasHornCount x j' := by
  have hπ := Real.pi_pos
  have hR0 : 0 < R := by linarith
  have hA : germArc (ringPt P θ₁) (θ₁ + π / 2) (1 / R) dA = germArc (ringPt P θ₁) (θ₁ + 1 * (π / 2)) (1 / R) dA := by rw [one_mul]
  have hB : germArc (ringPt P θ₂) (θ₂ - π / 2) (-(1 / R)) dB = germArc (ringPt P θ₂) (θ₂ + -1 * (π / 2)) (-1 / R) dB := by
    rw [show θ₂ + -1 * (π / 2) = θ₂ - π / 2 by ring, neg_div]
  have hκA : |(1 : ℝ) / R| * dA ≤ 2 := by rw [abs_of_pos (by positivity), div_mul_eq_mul_div, one_mul, div_le_iff₀ hR0]; linarith
  have hκB : |(-1 : ℝ) / R| * dB ≤ 2 := by
    rw [abs_div, abs_neg, abs_one, abs_of_pos hR0, div_mul_eq_mul_div, one_mul, div_le_iff₀ hR0]; linarith
  have hcarA : ∀ z ∈ (germArc (ringPt P θ₁) (θ₁ + π / 2) (1 / R) dA).carrier, dist z (P + ((1 - R : ℝ) : ℂ) * e θ₁) = R := by
    intro z hz
    rw [hA, carrier_germArc _ _ hdA.le hκA] at hz
    obtain ⟨s, hs, rfl⟩ := hz
    exact dist_branchPt_end P θ₁ (Or.inl rfl) hR0 hs.1 (hs.2.trans hdA2)
  have hcarB : ∀ z ∈ (germArc (ringPt P θ₂) (θ₂ - π / 2) (-(1 / R)) dB).carrier, dist z (P + ((1 - R : ℝ) : ℂ) * e θ₂) = R := by
    intro z hz
    rw [hB, carrier_germArc _ _ hdB.le hκB] at hz
    obtain ⟨s, hs, rfl⟩ := hz
    exact dist_branchPt_end P θ₂ (Or.inr rfl) hR0 hs.1 (hs.2.trans hdB2)
  have hene : e θ₁ ≠ e θ₂ := by
    intro h
    have h1 := norm_e_sub_e_eq θ₂ θ₁
    rw [h, sub_self, norm_zero] at h1
    have h2 : 0 < Real.sin ((θ₂ - θ₁) / 2) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
    rw [abs_of_pos h2] at h1
    linarith
  have hne12 : ringPt P θ₁ ≠ ringPt P θ₂ := fun h => hene (add_left_cancel h)
  by_cases hxK : x ∈ collarK P θ₁ θ₂ R' R''
  · by_cases hend : x = ringPt P θ₁ ∨ x = ringPt P θ₂
    · rcases hend with rfl | rfl
      · refine ⟨j, le_rfl, (hasHornCount_iff_collar_end (L' := (germArc (ringPt P θ₂) (θ₂ - π / 2) (-(1 / R)) dB).carrier)
          (Or.inl ⟨rfl, rfl⟩) h12 hℓ hR' hR'R hR'1 hRR'' h1R'' hR1 hdom hring hfree hdA hdA2 (Arc.isClosed_carrier _) ?_ ?_ j).mpr hj⟩
        · exact fun h => hne12 (eq_ringPt_of_mem_tangentCircle hR1 (dist_ringPt P θ₁) (hcarB _ h))
        · rw [hΓ, hA]
      · refine ⟨j, le_rfl, (hasHornCount_iff_collar_end (L' := (germArc (ringPt P θ₁) (θ₁ + π / 2) (1 / R) dA).carrier)
          (Or.inr ⟨rfl, rfl⟩) h12 hℓ hR' hR'R hR'1 hRR'' h1R'' hR1 hdom hring hfree hdB hdB2 (Arc.isClosed_carrier _) ?_ ?_ j).mpr hj⟩
        · exact fun h => hne12 (eq_ringPt_of_mem_tangentCircle hR1 (dist_ringPt P θ₂) (hcarA _ h)).symm
        · rw [hΓ, hB, union_comm (germArc (ringPt P θ₁) (θ₁ + π / 2) (1 / R) dA).carrier]
    · refine ⟨0, Nat.zero_le _, ?_⟩
      have hxd : x ∈ F.dom := hKdom hxK
      by_cases hxI : x ∈ M.interiorPts
      · exact hasHornCount_zero_of_mem_interiorPts hxI
      · have hxM : x ∈ M.Γ := ⟨hdom ▸ hxd, by_contra fun h => hxI ⟨hdom ▸ hxd, h⟩⟩
        have hxF : x ∉ F.Γ := by
          intro hxF
          obtain ⟨θ, hθ, rfl⟩ := hfree ⟨hxF, hxK⟩
          rw [hΓ] at hxM
          rcases hxM with ⟨-, hO⟩ | hA' | hB'
          · have hθ' : θ ∉ Ioo θ₁ θ₂ := fun h => hO ⟨θ, h, rfl⟩
            rcases eq_or_lt_of_le hθ.1 with h1 | h1
            · exact hend (Or.inl (by rw [h1]))
            · exact hend (Or.inr (by rw [le_antisymm hθ.2 (not_lt.mp fun h2 => hθ' ⟨h1, h2⟩)]))
          · exact hend (Or.inl (eq_ringPt_of_mem_tangentCircle hR1 (dist_ringPt P θ) (hcarA _ hA')))
          · exact hend (Or.inr (eq_ringPt_of_mem_tangentCircle hR1 (dist_ringPt P θ) (hcarB _ hB')))
        have hxFI : x ∈ F.interiorPts := ⟨hxd, fun h => hxF ⟨hxd, h⟩⟩
        obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp F.isOpen_interiorPts x hxFI
        have hqne : P + ((1 - R : ℝ) : ℂ) * e θ₁ ≠ P + ((1 - R : ℝ) : ℂ) * e θ₂ := by
          intro h
          have h1 : ((1 - R : ℝ) : ℂ) ≠ 0 := by
            rw [Ne, Complex.ofReal_eq_zero]; exact fun h => hR1 (by linarith)
          exact hene (mul_left_cancel₀ h1 (add_left_cancel h))
        have hqlt : dist (P + ((1 - R : ℝ) : ℂ) * e θ₁) (P + ((1 - R : ℝ) : ℂ) * e θ₂) < 2 * R := by
          rw [dist_eq_norm, show P + ((1 - R : ℝ) : ℂ) * e θ₁ - (P + ((1 - R : ℝ) : ℂ) * e θ₂) =
            ((1 - R : ℝ) : ℂ) * (e θ₁ - e θ₂) by ring, norm_mul, Complex.norm_real, Real.norm_eq_abs]
          have h1 := norm_e_sub_e_le θ₁ θ₂
          rw [abs_of_neg (by linarith)] at h1
          have h2 : |1 - R| < R := abs_lt.mpr ⟨by linarith, by linarith⟩
          have h3 := abs_nonneg (1 - R)
          have hπ4 := Real.pi_lt_four
          nlinarith [norm_nonneg (e θ₁ - e θ₂)]
        refine hasHornCount_zero_of_two_spheres (F := M) (q := P + ((1 - R : ℝ) : ℂ) * e θ₁)
          (q' := P + ((1 - R : ℝ) : ℂ) * e θ₂) (ρ := R) (ρ' := R) (hdom ▸ hxd) hr hR0 hR0 ?_ ?_
        · rintro z ⟨hzM, hzb⟩
          rw [hΓ] at hzM
          rcases hzM with ⟨hzF, -⟩ | hA' | hB'
          · exact absurd hzF.2 (hball hzb).2
          · exact Or.inl (mem_sphere.mpr (hcarA z hA'))
          · exact Or.inr (mem_sphere.mpr (hcarB z hB'))
        · intro h1 h2
          exact Or.inr (im_ne_zero_of_two_spheres (mem_sphere.mp h1) (mem_sphere.mp h2) hqne hqlt)
  · obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp hKcl.isOpen_compl x hxK
    exact ⟨j, le_rfl, (hasHornCount_iff_of_agree hr (fun y hy => hag y (hball hy)) j).mpr hj⟩

end ArcMap

end HadwigerNelson.Plane
