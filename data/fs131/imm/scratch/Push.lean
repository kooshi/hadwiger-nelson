import Proofs.HadwigerNelson.Plane.ValidMap.Surgery

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **N3-CLEAR at a boundary direction, by N3-UP** (FS110-W-MERGE's cusp-end clearance): let every contact of `c` at `v` either have a
margin `μ` at the direction `e α` (`dot (e α) (w − v) ≥ μ` in-type, `≤ −μ` out-type), or be in-type within `1/2` of `v + e γ`, or
out-type within `1/2` of `v − e γ`. Then near `v`, a point `z₀ + τ e γ` (`τ ≥ 0`) pushed from a closure point `z₀` of a `c`-tile at `v`,
along a direction within `μ/2` of `e α`, is clear for `c`: tiles near the margin contacts are cleared as in N3-CLEAR
(`clear_of_subset_interior_allowedCone`), in-type tiles near `v + e γ` by the lens (`lens_dist_lt_one_of_up`), out-type tiles near
`v − e γ` by the lune (`lune_dist_le_of_up`). -/
theorem clear_of_push (hF : F.Valid) {v : ℂ} {c : Fin k} (hv : F.Covers v 1) (hc : c ∈ F.coloursAt v)
    {α γ μ : ℝ} (hμ : 0 < μ)
    (hcont : ∀ w, F.IsContact v c w →
      (F.InType v c w → μ ≤ dot (e α) (w - v) ∨ dist w (v + e γ) ≤ 1 / 2) ∧
      (F.OutType v c w → dot (e α) (w - v) ≤ -μ ∨ dist w (v - e γ) ≤ 1 / 2)) :
    ∃ ρ > 0, ∀ T₀ : Set ℂ, F.TileOf c T₀ → v ∈ closure T₀ → ∀ z₀ ∈ closure T₀, ∀ τ : ℝ, 0 ≤ τ →
      dist z₀ v < ρ → dist (z₀ + τ * e γ) v < ρ →
      dist (z₀ + τ * e γ - v) (‖z₀ + τ * e γ - v‖ * e α) ≤ μ / 2 * ‖z₀ + τ * e γ - v‖ →
      F.IsClear c (z₀ + τ * e γ) := by
  -- the lens and the lune along `e γ`
  obtain ⟨rL, hrL, hlens⟩ := lens_dist_lt_one_of_up v (γ - π / 2)
  have hγ : γ - π / 2 + π / 2 = γ := by ring
  rw [hγ] at hlens
  -- the contacts, each with a ball met only by tiles holding it in their closure
  set W := closure (F.region c) ∩ sphere v 1 with hW
  have hloc : ∀ w ∈ W, ∃ δw > 0, δw ≤ μ / 4 ∧ δw ≤ 1 / 4 ∧
      ∀ T, F.IsTile T → (T ∩ ball w δw).Nonempty → w ∈ closure T := by
    intro w hw
    have hwdom : w ∈ F.dom := hv (sphere_subset_closedBall hw.2)
    obtain ⟨δ', hδ', h⟩ := exists_ball_tiles_mem_closure hwdom
    refine ⟨min δ' (min (μ / 4) (1 / 4)), lt_min hδ' (lt_min (by positivity) (by norm_num)),
      (min_le_right _ _).trans (min_le_left _ _), (min_le_right _ _).trans (min_le_right _ _), fun T hT hne => h T hT ?_⟩
    obtain ⟨y, hyT, hyb⟩ := hne
    exact ⟨y, hyT, ball_subset_ball (min_le_left _ _) hyb⟩
  choose! δw hδw0 hδwμ hδw4 hδwT using hloc
  set U := ⋃ w ∈ W, ball w (δw w) with hU
  have hUo : IsOpen U := isOpen_biUnion fun w _ => isOpen_ball
  have hWU : W ⊆ U := fun w hw => mem_biUnion hw (mem_ball_self (hδw0 w hw))
  -- the annulus margin `t₀`
  set K := (closure (F.region c) ∩ {y | 1 / 2 ≤ dist y v ∧ dist y v ≤ 3 / 2}) \ U with hK
  have hKc : IsCompact K := by
    refine Metric.isCompact_of_isClosed_isBounded ?_ ?_
    · refine (isClosed_closure.inter ?_).sdiff hUo
      exact (isClosed_le continuous_const (continuous_id.dist continuous_const)).inter
        (isClosed_le (continuous_id.dist continuous_const) continuous_const)
    · refine (Metric.isBounded_closedBall (x := v) (r := 3 / 2)).subset fun y hy => ?_
      exact mem_closedBall.mpr hy.1.2.2
  obtain ⟨t₀, ht₀, ht₀h, ht₀K⟩ : ∃ t₀ > 0, t₀ ≤ 1 / 2 ∧ ∀ y ∈ K, t₀ ≤ |dist y v - 1| := by
    rcases K.eq_empty_or_nonempty with hKe | hKne
    · exact ⟨1 / 2, by norm_num, le_rfl, fun y hy => by rw [hKe] at hy; exact hy.elim⟩
    · obtain ⟨y₀, hy₀K, hmin⟩ := hKc.exists_isMinOn hKne
        ((continuous_id.dist continuous_const).sub continuous_const).abs.continuousOn
      have hpos : 0 < |dist y₀ v - 1| := by
        rw [abs_pos, sub_ne_zero]
        intro h1
        exact hy₀K.2 (hWU ⟨hy₀K.1.1, by rw [mem_sphere]; exact h1⟩)
      exact ⟨min (1 / 2) |dist y₀ v - 1|, lt_min (by norm_num) hpos, min_le_left _ _,
        fun y hy => (min_le_right _ _).trans (hmin hy)⟩
  refine ⟨min (min t₀ (μ / 2)) (min rL (1 / 4)), lt_min (lt_min ht₀ (by positivity)) (lt_min hrL (by norm_num)),
    fun T₀ hT₀ hvT₀ z₀ hz₀ τ hτ hz₀v hzv hdir y hy hzy => ?_⟩
  set z := z₀ + (τ : ℂ) * e γ with hz
  have hzt₀ : dist z v < t₀ := lt_of_lt_of_le hzv ((min_le_left _ _).trans (min_le_left _ _))
  have hzμ : dist z v < μ / 2 := lt_of_lt_of_le hzv ((min_le_left _ _).trans (min_le_right _ _))
  have hzL : dist z v < rL := lt_of_lt_of_le hzv ((min_le_right _ _).trans (min_le_left _ _))
  have hz₀L : dist z₀ v < rL := lt_of_lt_of_le hz₀v ((min_le_right _ _).trans (min_le_left _ _))
  have hz₀4 : dist z₀ v < 1 / 4 := lt_of_lt_of_le hz₀v ((min_le_right _ _).trans (min_le_right _ _))
  -- `y` is within `t₀` of `ω(v)`
  have hnear : |dist y v - 1| < t₀ := by
    have h1 := dist_triangle y z v
    have h2 := dist_triangle y v z
    rw [dist_comm y z, hzy] at h1
    rw [dist_comm y z, hzy, dist_comm v z] at h2
    rw [abs_lt]; constructor <;> linarith
  have hyU : y ∈ U := by
    by_contra hyU
    have hyK : y ∈ K := by
      refine ⟨⟨subset_closure hy, ?_, ?_⟩, hyU⟩
      · have := (abs_lt.mp hnear).1; linarith
      · have := (abs_lt.mp hnear).2; linarith
    linarith [ht₀K y hyK]
  obtain ⟨w, hwW, hyw⟩ := mem_iUnion₂.mp hyU
  have hw : F.IsContact v c w := ⟨hc, hwW.2, hwW.1⟩
  obtain ⟨hTy, hyT⟩ := tileOf_component hy
  have hwT : w ∈ closure (connectedComponentIn F.interiorPts y) := hδwT w hwW _ hTy.1 ⟨y, hyT, hyw⟩
  have hyw4 : dist y w < μ / 4 := lt_of_lt_of_le hyw (hδwμ w hwW)
  have hyw4' : dist y w < 1 / 4 := lt_of_lt_of_le hyw (hδw4 w hwW)
  -- the margin computation along `d = z − v`
  set d := z - v with hd
  set t := ‖d‖ with ht
  have htz : t = dist z v := by rw [ht, hd, dist_eq_norm]
  have hu : ‖w - v‖ = 1 := by rw [← dist_eq_norm]; exact hw.2.1
  have hdu : |dot d (w - v) - t * dot (e α) (w - v)| ≤ μ / 2 * t := by
    have h1 : dot (d - (t : ℂ) * e α) (w - v) = dot d (w - v) - t * dot (e α) (w - v) := by
      rw [dot_sub, dot_ofReal_mul]
    rw [← h1]
    refine (abs_dot_le _ _).trans ?_
    rw [hu, mul_one, ← dist_eq_norm]
    exact hdir
  have hdyw : |dot d (y - w)| ≤ t * (μ / 4) := by
    refine (abs_dot_le _ _).trans ?_
    rw [← ht, ← dist_eq_norm]
    exact mul_le_mul_of_nonneg_left hyw4.le (norm_nonneg _)
  have hsplit : dot d (y - v) = dot d (w - v) + dot d (y - w) := by
    unfold dot; simp only [map_sub, mul_sub, Complex.sub_re]; ring
  have hsq : ‖y - v‖ ^ 2 - 2 * dot d (y - v) + t ^ 2 = 1 := by
    have := norm_sub_sq_eq_dot (y - v) d
    rw [show y - v - d = y - z by rw [hd]; ring, dot_comm' (y - v) d, ← dist_eq_norm, dist_comm, hzy] at this
    rw [← ht] at this
    linarith
  have ht0 : 0 ≤ t := norm_nonneg _
  have htμ : t ≤ μ / 2 := by rw [htz]; exact hzμ.le
  have hT₀c : z₀ ∈ closure (F.region c) := closure_mono (fun x hx => hT₀.subset_region hx) hz₀
  rcases (contact_inType_or_outType hF hv hw).1 with hin | hout
  · have hyv : ‖y - v‖ < 1 := by rw [← dist_eq_norm]; exact hin _ hTy hwT hyT
    rcases (hcont w hw).1 hin with hm | hN
    · -- a margin contact
      have h1 : t * (μ / 4) ≤ dot d (y - v) := by
        have := (abs_le.mp hdu).1
        have := (abs_le.mp hdyw).1
        nlinarith
      have : ‖y - v‖ ^ 2 < 1 := by nlinarith [norm_nonneg (y - v)]
      nlinarith
    · -- an in-type tile near `v + e γ`: the lens
      have hyN : dist y (v + e γ) ≤ 1 := by
        have := dist_triangle y w (v + e γ); linarith
      have hvy : dist v y < 1 := by rw [dist_comm, dist_eq_norm]; exact hyv
      have hnear0 := unitNear_of_mem_closure hF hT₀ hTy hvT₀ (subset_closure hyT) hvy
      have hz₀y : dist z₀ y < 1 :=
        lt_of_le_of_ne (UnitNear.dist_le_of_mem_closure hnear0 hz₀ (subset_closure hyT))
          (by rw [dist_comm]; exact ne1_region hF hT₀c hy)
      have := hlens z₀ hz₀L τ hτ hzL y ⟨by rw [mem_ball, dist_eq_norm]; exact hyv, hyN⟩ hz₀y
      rw [← hz, hzy] at this
      exact lt_irrefl _ this
  · have hyv : 1 < ‖y - v‖ := by
      have := disjoint_left.mp (hout _ hTy hwT) hyT
      rw [mem_closedBall, not_le, dist_eq_norm] at this; exact this
    rcases (hcont w hw).2 hout with hm | hS
    · -- a margin contact
      have h1 : dot d (y - v) ≤ -(t * (μ / 4)) := by
        have := (abs_le.mp hdu).2
        have := (abs_le.mp hdyw).2
        nlinarith
      have : 1 < ‖y - v‖ ^ 2 := by nlinarith
      nlinarith
    · -- an out-type tile near `v − e γ`: the lune
      have hyS : dist y (v - e γ) ≤ 1 := by
        have := dist_triangle y w (v - e γ); linarith
      have hvy : 1 < dist v y := by rw [dist_comm, dist_eq_norm]; exact hyv
      have hfar0 := unitFar_of_mem_closure hF hT₀ hTy hvT₀ (subset_closure hyT) hvy
      have hz₀y : 1 < dist z₀ y :=
        lt_of_le_of_ne (UnitFar.one_le_dist_of_mem_closure hfar0 hz₀ (subset_closure hyT))
          (fun h => ne1_region hF hT₀c hy (by rw [dist_comm]; exact h.symm))
      have hlune := lune_dist_le_of_up v (γ - π / 2) (z := z₀) (by linarith) hτ (p := y)
        ⟨by rw [hγ, mem_closedBall]; exact hyS, by rw [mem_ball, not_lt, dist_eq_norm]; exact hyv.le⟩
      rw [hγ, ← hz, hzy] at hlune
      linarith

end ArcMap

end HadwigerNelson.Plane

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- The dot product against `e θ` in coordinates. -/
theorem dot_e_eq_cos_sin (θ : ℝ) (u : ℂ) : dot (e θ) u = Real.cos θ * u.re + Real.sin θ * u.im := by
  unfold dot; rw [e_eq]; simp [Complex.mul_re, Complex.conj_re, Complex.conj_im, Complex.cos_ofReal_re, Complex.sin_ofReal_re]

/-- `‖u − τ e θ‖² = ‖u‖² − 2τ (e θ · u) + 1` for `τ = ±1`, in coordinates. -/
theorem norm_sub_smul_e_sq (u : ℂ) (θ : ℝ) {τ : ℝ} (hτ : τ = 1 ∨ τ = -1) :
    ‖u - τ * e θ‖ ^ 2 = u.re ^ 2 + u.im ^ 2 - 2 * τ * (Real.cos θ * u.re + Real.sin θ * u.im) + 1 := by
  rw [Complex.sq_norm, Complex.normSq_apply, e_eq]
  simp only [Complex.sub_re, Complex.sub_im, Complex.add_re, Complex.add_im, Complex.ofReal_re, Complex.ofReal_im,
    Complex.mul_re, Complex.mul_im, Complex.I_re, Complex.I_im]
  have hτ2 : τ ^ 2 = 1 := by rcases hτ with rfl | rfl <;> norm_num
  nlinarith [Real.sin_sq_add_cos_sq θ]

/-- The planar step of `push_contacts_of_mem_allowedCone`: a unit vector `(x, y)` with `x ≥ 0` and `x cos ψ + y sin ψ ≥ 0` has `x ≥ μ`
or `y ≥ 7/8`, for `μ ≤ min (sin ψ / 2) (1/4)`. -/
theorem push_alg {x y c s μ : ℝ} (hxy : x ^ 2 + y ^ 2 = 1) (hs : 0 < s) (hc : c ≤ 1) (hμ1 : μ ≤ s / 2) (hμ2 : μ ≤ 1 / 4)
    (hx : 0 ≤ x) (h : 0 ≤ x * c + y * s) : μ ≤ x ∨ 7 / 8 ≤ y := by
  by_contra hcon
  push Not at hcon
  obtain ⟨hxμ, hy⟩ := hcon
  have h1 : x * c ≤ x := by nlinarith
  have h2 : -(s / 2) < y * s := by linarith
  have h3 : -(1 / 2) < y := by
    by_contra h4; push Not at h4; nlinarith
  have h5 : x ^ 2 < 1 / 16 := by nlinarith
  nlinarith

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **The contacts at a boundary direction of `D_c(v)`** (the hypothesis of `clear_of_push`): if `e α` and `e (α + σψ)` (`σ = ±1`,
`0 < ψ < π`) lie in `D_c(v)`, then every in-type contact has a margin `μ` at `e α` or lies within `1/2` of `v + e (α + σπ/2)`, and every
out-type contact has a margin or lies within `1/2` of `v − e (α + σπ/2)`. -/
theorem push_contacts_of_mem_allowedCone {v : ℂ} {c : Fin k} {α ψ σ : ℝ} (hσ : σ = 1 ∨ σ = -1) (hψ : 0 < ψ) (hψπ : ψ < π)
    (h1 : e α ∈ F.allowedCone v c) (h2 : e (α + σ * ψ) ∈ F.allowedCone v c) :
    ∃ μ > 0, ∀ w, F.IsContact v c w →
      (F.InType v c w → μ ≤ dot (e α) (w - v) ∨ dist w (v + e (α + σ * (π / 2))) ≤ 1 / 2) ∧
      (F.OutType v c w → dot (e α) (w - v) ≤ -μ ∨ dist w (v - e (α + σ * (π / 2))) ≤ 1 / 2) := by
  have hs : 0 < Real.sin ψ := Real.sin_pos_of_pos_of_lt_pi hψ hψπ
  have hc1 : Real.cos ψ ≤ 1 := Real.cos_le_one ψ
  have hμ0 : 0 < min (Real.sin ψ / 2) (1 / 4) := lt_min (by positivity) (by norm_num)
  refine ⟨min (Real.sin ψ / 2) (1 / 4), hμ0, fun w hw => ?_⟩
  set μ := min (Real.sin ψ / 2) (1 / 4) with hμ
  have hμ1 : μ ≤ Real.sin ψ / 2 := min_le_left _ _
  have hμ2 : μ ≤ 1 / 4 := min_le_right _ _
  set u := w - v with hu
  have hu1 : u.re ^ 2 + u.im ^ 2 = 1 := by
    have h1u : ‖u‖ = 1 := by rw [hu, ← dist_eq_norm]; exact hw.2.1
    have h := Complex.sq_norm u
    rw [h1u, Complex.normSq_apply] at h
    nlinarith
  have hcs : Real.cos α ^ 2 + Real.sin α ^ 2 = 1 := by rw [add_comm]; exact Real.sin_sq_add_cos_sq α
  set x := Real.cos α * u.re + Real.sin α * u.im with hx
  set y := σ * (-Real.sin α * u.re + Real.cos α * u.im) with hy
  have hσ2 : σ ^ 2 = 1 := by rcases hσ with rfl | rfl <;> norm_num
  have hxy : x ^ 2 + y ^ 2 = 1 := by
    have : x ^ 2 + y ^ 2 = (Real.cos α ^ 2 + Real.sin α ^ 2) * (u.re ^ 2 + u.im ^ 2) +
        (σ ^ 2 - 1) * (-Real.sin α * u.re + Real.cos α * u.im) ^ 2 := by rw [hx, hy]; ring
    rw [this, hcs, hu1, hσ2]; ring
  have hdα : dot (e α) u = x := dot_e_eq_cos_sin α u
  have hd2 : dot (e (α + σ * ψ)) u = x * Real.cos ψ + y * Real.sin ψ := by
    rw [dot_e_eq_cos_sin]
    rcases hσ with rfl | rfl
    · rw [one_mul, Real.cos_add, Real.sin_add, hx, hy]; ring
    · rw [show α + -1 * ψ = α - ψ by ring, Real.cos_sub, Real.sin_sub, hx, hy]; ring
  -- the two poles: `‖u ∓ e (α + σπ/2)‖² = 2 ∓ 2y`
  have hpole : ∀ τ : ℝ, τ = 1 ∨ τ = -1 → ‖u - τ * e (α + σ * (π / 2))‖ ^ 2 = 2 - 2 * τ * y := by
    intro τ hτ
    rw [norm_sub_smul_e_sq u _ hτ, hu1]
    have hcos : Real.cos (α + σ * (π / 2)) = -σ * Real.sin α := by
      rcases hσ with rfl | rfl
      · rw [one_mul, Real.cos_add_pi_div_two]; ring
      · rw [show α + -1 * (π / 2) = α - π / 2 by ring, Real.cos_sub_pi_div_two]; ring
    have hsin : Real.sin (α + σ * (π / 2)) = σ * Real.cos α := by
      rcases hσ with rfl | rfl
      · rw [one_mul, Real.sin_add_pi_div_two]; ring
      · rw [show α + -1 * (π / 2) = α - π / 2 by ring, Real.sin_sub_pi_div_two]; ring
    rw [hcos, hsin, hy]; ring
  have hhalf : ∀ τ : ℝ, τ = 1 ∨ τ = -1 → 7 / 8 ≤ τ * y → ‖u - τ * e (α + σ * (π / 2))‖ ≤ 1 / 2 := by
    intro τ hτ hτy
    have h := hpole τ hτ
    have : ‖u - τ * e (α + σ * (π / 2))‖ ^ 2 ≤ (1 / 2) ^ 2 := by rw [h]; nlinarith
    exact (pow_le_pow_iff_left₀ (norm_nonneg _) (by norm_num) two_ne_zero).mp this
  constructor
  · intro hin
    have hx0 : 0 ≤ x := by rw [← hdα]; exact (h1 w hw).1 hin
    have h20 : 0 ≤ x * Real.cos ψ + y * Real.sin ψ := by rw [← hd2]; exact (h2 w hw).1 hin
    rcases push_alg hxy hs hc1 hμ1 hμ2 hx0 h20 with hm | hy7
    · exact Or.inl (by rw [hdα]; exact hm)
    · right
      have := hhalf 1 (Or.inl rfl) (by rw [one_mul]; exact hy7)
      rwa [Complex.ofReal_one, one_mul, hu, show w - v - e (α + σ * (π / 2)) = w - (v + e (α + σ * (π / 2))) by ring,
        ← dist_eq_norm] at this
  · intro hout
    have hx0 : 0 ≤ -x := by rw [← hdα]; linarith [(h1 w hw).2 hout]
    have h20 : 0 ≤ -x * Real.cos ψ + -y * Real.sin ψ := by
      have := (h2 w hw).2 hout; rw [hd2] at this; linarith
    have hxy' : (-x) ^ 2 + (-y) ^ 2 = 1 := by rw [neg_sq, neg_sq]; exact hxy
    rcases push_alg hxy' hs hc1 hμ1 hμ2 hx0 h20 with hm | hy7
    · exact Or.inl (by rw [hdα]; linarith)
    · right
      have := hhalf (-1) (Or.inr rfl) (by linarith)
      rwa [Complex.ofReal_neg, Complex.ofReal_one, neg_one_mul, sub_neg_eq_add, hu,
        show w - v + e (α + σ * (π / 2)) = w - (v - e (α + σ * (π / 2))) by ring, ← dist_eq_norm] at this

end ArcMap

end HadwigerNelson.Plane
