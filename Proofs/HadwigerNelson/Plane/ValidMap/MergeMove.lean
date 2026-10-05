import Proofs.HadwigerNelson.Plane.ValidMap.Surgery

/-!
# MERGE at a point: the children of `exists_merge_aux` (FS110-W-MERGE; FS131-IMM1)

Wave 4's third simplifying move (inventory item 285; record `plans/FS131-IMM-implementation.md`): if `int D_c(v)` is non-empty and `c`
has `n + 1 ≥ 2` sectors at `v`, two `c`-sectors consecutive along `D_c(v)`'s arc of directions merge by recolouring with `c` the sectors
of the gap between them near `v`. `Plane/ValidMap/Moves`' `exists_merge_aux` cites the children here.

The children, in the order the proof uses them:

* **Clearness off an open set** (`dist_ne_one_of_isOpen_isClear`): an open set of points clear for `c` meets no unit circle about a
  point of the closure of `c`'s class (so the recoloured region's closure creates no contact at a far point, and `D_c(v′)` is unchanged).
* **The allowed cone is a convex cone** (`add_mem_allowedCone`, `smul_mem_allowedCone`).
* **N3-CLEAR at a boundary direction, by N3-UP** (`clear_of_push`): a point pushed along `e γ` from a closure point of a `c`-tile at `v`
  stays clear for `c` when every contact of `c` at `v` has a margin at the direction `e α` or sits, with the right type, near `v ± e γ`
  (in-type tiles there are cleared by the lens `lens_dist_lt_one_of_up`, out-type tiles by the lune `lune_dist_le_of_up`); and
  `push_contacts_of_mem_allowedCone`: those contacts are what `e α, e (α + σψ) ∈ D_c(v)` leaves.
* **The tangent arc on a vertical line** (`hgt`, `tanHeight_hgt`, `sign_sub_hgt`) and **the germ's point under a point near it**
  (`push_decomp`).
* **Clearness at an end of a gap** (`clear_near_end`): at a direction `e θ` interior to `D_c(v)` by N3-CLEAR
  (`clear_of_subset_interior_allowedCone`), at a boundary direction by the push from the gap's bounding germ.

The hypotheses `F.Valid`, `F.Covers v 1`, `c ∈ F.coloursAt v` are parametric (the caller's), as in `Cone`; `hgt` has its spec examples.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## Clearness off an open set -/

/-- **An open set of clear points meets no unit circle about the closure of the class**: if every point of an open set `U` is clear
for `c`, no point of `U` lies at distance `1` from a point of the closure of `c`'s class (translate the pair into the class). -/
theorem dist_ne_one_of_isOpen_isClear {c : Fin k} {U : Set ℂ} (hU : IsOpen U) (hclear : ∀ z ∈ U, F.IsClear c z)
    {z y : ℂ} (hz : z ∈ U) (hy : y ∈ closure (F.region c)) : dist z y ≠ 1 := by
  intro hzy
  obtain ⟨ε, hε, hεU⟩ := Metric.isOpen_iff.mp hU z hz
  obtain ⟨y', hy', hyy'⟩ := Metric.mem_closure_iff.mp hy ε hε
  refine hclear (z + (y' - y)) (hεU ?_) y' hy' ?_
  · rw [mem_ball, dist_eq_norm, show z + (y' - y) - z = y' - y by ring, ← dist_eq_norm, dist_comm]; exact hyy'
  · rw [dist_eq_norm, show z + (y' - y) - y' = z - y by ring, ← dist_eq_norm]; exact hzy

/-! ## The allowed cone is a convex cone -/

/-- The allowed cone is closed under sums. -/
theorem add_mem_allowedCone {v : ℂ} {c : Fin k} {d d' : ℂ} (hd : d ∈ F.allowedCone v c) (hd' : d' ∈ F.allowedCone v c) :
    d + d' ∈ F.allowedCone v c := by
  intro w hw
  obtain ⟨h1, h2⟩ := hd w hw
  obtain ⟨h1', h2'⟩ := hd' w hw
  refine ⟨fun hin => ?_, fun hout => ?_⟩
  · rw [dot_add_left]; linarith [h1 hin, h1' hin]
  · rw [dot_add_left]; linarith [h2 hout, h2' hout]

/-- The allowed cone is closed under non-negative multiples. -/
theorem smul_mem_allowedCone {v : ℂ} {c : Fin k} {d : ℂ} {t : ℝ} (ht : 0 ≤ t) (hd : d ∈ F.allowedCone v c) :
    (t : ℂ) * d ∈ F.allowedCone v c := by
  intro w hw
  obtain ⟨h1, h2⟩ := hd w hw
  refine ⟨fun hin => ?_, fun hout => ?_⟩
  · rw [dot_ofReal_mul]; exact mul_nonneg ht (h1 hin)
  · rw [dot_ofReal_mul]; exact mul_nonpos_of_nonneg_of_nonpos ht (h2 hout)

end ArcMap

end HadwigerNelson.Plane


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


namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- **The height of the tangent arc of curvature `κ` above the abscissa `X`** (the smaller root of `tanHeight κ X y = 0`):
`κ X² / (1 + √(1 − κ² X²))`. -/
noncomputable def hgt (κ X : ℝ) : ℝ := κ * X ^ 2 / (1 + Real.sqrt (1 - κ ^ 2 * X ^ 2))

/-- The point `(X, hgt κ X)` lies on the tangent arc of curvature `κ`. -/
theorem tanHeight_hgt {κ X : ℝ} (h : κ ^ 2 * X ^ 2 ≤ 1) : tanHeight κ X (hgt κ X) = 0 := by
  set S := Real.sqrt (1 - κ ^ 2 * X ^ 2) with hS
  have hS0 : 0 ≤ S := Real.sqrt_nonneg _
  have hS2 : S ^ 2 = 1 - κ ^ 2 * X ^ 2 := Real.sq_sqrt (by linarith)
  have hd : 0 < 1 + S := by linarith
  unfold hgt tanHeight
  rw [← hS]
  field_simp
  linear_combination (-(κ * X ^ 2)) * hS2

/-- Spec: the straight germ has height `0`; the curvature-`1` germ passes through `(1, 1)` (the unit circle about `(0, 1)`). -/
example : hgt 0 3 = 0 ∧ hgt 1 1 = 1 := by
  constructor
  · simp [hgt]
  · norm_num [hgt]

/-- The tangent arc's height is at most `|κ| X²`. -/
theorem abs_hgt_le (κ X : ℝ) : |hgt κ X| ≤ |κ| * X ^ 2 := by
  unfold hgt
  have hd : 1 ≤ 1 + Real.sqrt (1 - κ ^ 2 * X ^ 2) := by linarith [Real.sqrt_nonneg (1 - κ ^ 2 * X ^ 2)]
  rw [abs_div, abs_mul, abs_of_nonneg (sq_nonneg X), abs_of_pos (by linarith : (0 : ℝ) < 1 + Real.sqrt _)]
  exact div_le_self (by positivity) hd

/-- **Above or below the tangent arc, on the vertical line**: near the origin, the sign of `tanHeight κ X Y` is the sign of
`Y − hgt κ X`. -/
theorem sign_sub_hgt {κ X Y σ : ℝ} (h : κ ^ 2 * X ^ 2 ≤ 1) (hY : |κ| * (|Y| + |hgt κ X|) ≤ 1)
    (hσ : 0 ≤ σ * tanHeight κ X Y) : 0 ≤ σ * (Y - hgt κ X) := by
  have h0 := tanHeight_hgt h
  set g := hgt κ X
  have hfac : tanHeight κ X Y = (Y - g) * (1 - κ * (Y + g) / 2) := by
    have : tanHeight κ X Y = tanHeight κ X Y - tanHeight κ X g := by rw [h0, sub_zero]
    rw [this]; unfold tanHeight; ring
  have hpos : 1 / 2 ≤ 1 - κ * (Y + g) / 2 := by
    have : |κ * (Y + g)| ≤ 1 := by
      rw [abs_mul]
      calc |κ| * |Y + g| ≤ |κ| * (|Y| + |g|) := mul_le_mul_of_nonneg_left (abs_add_le _ _) (abs_nonneg _)
        _ ≤ 1 := hY
    linarith [(abs_le.mp this).2]
  rw [hfac] at hσ
  have : 0 ≤ (σ * (Y - g)) * (1 - κ * (Y + g) / 2) := by linarith
  exact nonneg_of_mul_nonneg_left this (by linarith)

end HadwigerNelson.Plane

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- `e (θ + σπ/2) = σ e (θ + π/2)` for `σ = ±1`. -/
theorem e_add_sigma_pi_div_two {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) (θ : ℝ) :
    e (θ + σ * (π / 2)) = (σ : ℂ) * e (θ + π / 2) := by
  rcases hσ with rfl | rfl
  · simp
  · rw [show θ + -1 * (π / 2) = (θ + π / 2) + -π by ring, e_add, show e (-π) = -1 by rw [e_eq]; simp]
    push_cast; ring

/-- The side of a germ in polar form: at a direction within `π/4` of `θ` on the side `σ` of the germ `(θ, κ)`,
`σ tanHeight κ ≥ 0` at the polar point. -/
theorem sigma_tanHeight_nonneg {θ κ σ s φ : ℝ} (hσ : σ = 1 ∨ σ = -1) (hs0 : 0 < s) (hκs : |κ| * s ≤ 1 / 4)
    (hφε : |φ - θ| ≤ π / 4) (hside : 0 ≤ σ * (φ - germDir θ κ s)) :
    0 ≤ σ * (s * (Real.sin (φ - θ) - κ * s / 2)) := by
  have hπ := Real.pi_pos
  have hsin : 0 ≤ σ * (Real.sin (φ - θ) - κ * s / 2) := by
    have hb := half_curv_mem_Icc (κ := κ) (r := s) (s := s) (by linarith) hs0.le le_rfl
    have harc := Real.sin_arcsin hb.1 hb.2
    have hside' : 0 ≤ σ * (φ - θ - Real.arcsin (κ * s / 2)) := by
      rw [show φ - θ - Real.arcsin (κ * s / 2) = φ - germDir θ κ s by unfold germDir; ring]; exact hside
    have hA1 := Real.neg_pi_div_two_le_arcsin (κ * s / 2)
    have hA2 := Real.arcsin_le_pi_div_two (κ * s / 2)
    have hφ1 : -(π / 2) ≤ φ - θ := by linarith [(abs_le.mp hφε).1]
    have hφ2 : φ - θ ≤ π / 2 := by linarith [(abs_le.mp hφε).2]
    rcases hσ with rfl | rfl
    · have : Real.arcsin (κ * s / 2) ≤ φ - θ := by linarith
      have := Real.sin_le_sin_of_le_of_le_pi_div_two hA1 hφ2 this
      rw [harc] at this; linarith
    · have : φ - θ ≤ Real.arcsin (κ * s / 2) := by linarith
      have := Real.sin_le_sin_of_le_of_le_pi_div_two hφ1 hA2 this
      rw [harc] at this; linarith
  have : σ * (s * (Real.sin (φ - θ) - κ * s / 2)) = s * (σ * (Real.sin (φ - θ) - κ * s / 2)) := by ring
  rw [this]; positivity

/-- **The germ's point below (or above) a point near the germ** (the base of the push in `clear_near_end`): a point `v + s e φ` at a
direction within `π/4` of `θ`, on the side `σ` of the germ `(θ, κ)`, is `z₀ + τ e (θ + σπ/2)` with `τ ≥ 0` and `z₀` the germ's branch
point on the same perpendicular to `e θ`, at a distance in `(0, 5s/4]` from `v`. -/
theorem push_decomp (v : ℂ) {θ κ σ s φ : ℝ} (hσ : σ = 1 ∨ σ = -1) (hs0 : 0 < s) (hκs : |κ| * s ≤ 1 / 4)
    (hφε : |φ - θ| ≤ π / 4) (hside : 0 ≤ σ * (φ - germDir θ κ s)) :
    ∃ z₀ : ℂ, ∃ τ : ℝ, 0 ≤ τ ∧ v + (s : ℂ) * e φ = z₀ + (τ : ℂ) * e (θ + σ * (π / 2)) ∧
      z₀ = branchPt v θ κ ‖z₀ - v‖ ∧ 0 < ‖z₀ - v‖ ∧ ‖z₀ - v‖ ≤ s + s / 4 := by
  have hπ := Real.pi_pos
  have hσ2 : σ * σ = 1 := by rcases hσ with rfl | rfl <;> norm_num
  obtain ⟨hX, hY⟩ := frame_polar v θ s φ
  obtain ⟨X, hXd⟩ : ∃ X, X = s * Real.cos (φ - θ) := ⟨_, rfl⟩
  obtain ⟨Y, hYd⟩ : ∃ Y, Y = s * Real.sin (φ - θ) := ⟨_, rfl⟩
  rw [← hXd] at hX
  rw [← hYd] at hY
  have hcos : Real.cos (π / 4) ≤ Real.cos (φ - θ) := by
    rw [← Real.cos_abs (φ - θ)]
    exact Real.cos_le_cos_of_nonneg_of_le_pi (abs_nonneg _) (by linarith) hφε
  have hcos4 : (1 / 2 : ℝ) < Real.cos (π / 4) := by
    rw [Real.cos_pi_div_four]; nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ 2 by norm_num), Real.sqrt_nonneg 2]
  have hX0 : s / 2 < X := by rw [hXd]; nlinarith
  have hXs : X ≤ s := by rw [hXd]; nlinarith [Real.cos_le_one (φ - θ)]
  have hYs : |Y| ≤ s := by
    rw [hYd, abs_mul, abs_of_pos hs0]; nlinarith [Real.abs_sin_le_one (φ - θ)]
  have hκX1 : |κ| * X ≤ 1 / 4 := le_trans (mul_le_mul_of_nonneg_left hXs (abs_nonneg κ)) hκs
  have hκX0 : 0 ≤ |κ| * X := mul_nonneg (abs_nonneg κ) (by linarith)
  have hκX : κ ^ 2 * X ^ 2 ≤ 1 := by
    have h' : (|κ| * X) ^ 2 ≤ 1 := by nlinarith
    rwa [mul_pow, sq_abs] at h'
  obtain ⟨g, hg⟩ : ∃ g, g = hgt κ X := ⟨_, rfl⟩
  have hgle : |g| ≤ s / 4 := by
    have h1 := abs_hgt_le κ X
    have h2 : |κ| * X ^ 2 ≤ s / 4 := by
      have : |κ| * X ^ 2 = (|κ| * X) * X := by ring
      rw [this]; nlinarith
    rw [hg]; linarith
  have hT : 0 ≤ σ * tanHeight κ X Y := by
    have htp := tanHeight_polar v θ κ s φ
    rw [hX, hY] at htp
    rw [htp]; exact sigma_tanHeight_nonneg hσ hs0 hκs hφε hside
  have hτ : 0 ≤ σ * (Y - g) := by
    rw [hg]
    refine sign_sub_hgt hκX ?_ hT
    have h1 : |κ| * (|Y| + |hgt κ X|) ≤ |κ| * (s + s / 4) :=
      mul_le_mul_of_nonneg_left (by rw [← hg]; linarith) (abs_nonneg _)
    calc |κ| * (|Y| + |hgt κ X|) ≤ |κ| * (s + s / 4) := h1
      _ = 5 / 4 * (|κ| * s) := by ring
      _ ≤ 1 := by linarith
  obtain ⟨z₀, hz₀⟩ : ∃ z₀, z₀ = v + (s : ℂ) * e φ + ((g - Y : ℝ) : ℂ) * e (θ + π / 2) := ⟨_, rfl⟩
  have hX₀ : frameX v θ z₀ = X := by rw [hz₀, frameX_add_normal, hX]
  have hY₀ : frameY v θ z₀ = g := by rw [hz₀, frameY_add_normal, hY]; ring
  have hzz₀ : v + (s : ℂ) * e φ = z₀ + ((σ * (Y - g) : ℝ) : ℂ) * e (θ + σ * (π / 2)) := by
    rw [e_add_sigma_pi_div_two hσ, hz₀]
    have : ((σ * (Y - g) : ℝ) : ℂ) * ((σ : ℂ) * e (θ + π / 2)) = (((σ * σ) * (Y - g) : ℝ) : ℂ) * e (θ + π / 2) := by
      push_cast; ring
    rw [this, hσ2, one_mul]; push_cast; ring
  have hn₀ : ‖z₀ - v‖ ^ 2 = X ^ 2 + g ^ 2 := by rw [← frame_normSq v θ z₀, hX₀, hY₀]
  have hn₀pos : 0 < ‖z₀ - v‖ := by
    have h' : 0 < ‖z₀ - v‖ ^ 2 := by rw [hn₀]; nlinarith
    rcases (norm_nonneg (z₀ - v)).lt_or_eq with h'' | h''
    · exact h''
    · rw [← h''] at h'; simp at h'
  have hn₀le : ‖z₀ - v‖ ≤ s + s / 4 := by
    have hg2 : g ^ 2 ≤ (s / 4) ^ 2 := by rw [← sq_abs]; exact pow_le_pow_left₀ (abs_nonneg _) hgle 2
    have h' : ‖z₀ - v‖ ^ 2 ≤ (s + s / 4) ^ 2 := by rw [hn₀]; nlinarith
    exact (pow_le_pow_iff_left₀ (norm_nonneg _) (by positivity) two_ne_zero).mp h'
  have hz₀br : z₀ = branchPt v θ κ ‖z₀ - v‖ := by
    refine eq_branchPt_of_tanHeight_eq_zero (by rw [hX₀]; linarith) (by rw [hX₀, hY₀, hg]; exact tanHeight_hgt hκX) ?_
    calc |κ| * ‖z₀ - v‖ ≤ |κ| * (s + s / 4) := mul_le_mul_of_nonneg_left hn₀le (abs_nonneg _)
      _ = 5 / 4 * (|κ| * s) := by ring
      _ ≤ 2 := by linarith
  exact ⟨z₀, σ * (Y - g), hτ, hzz₀, hz₀br, hn₀pos, hn₀le⟩

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **Clearness at an end of a gap** (FS110-W-MERGE's end directions): let `e θ` be interior to `D_c(v)`, or lie in `D_c(v)` with a
direction `e (θ + σψ)` (`0 < ψ < π`) of `D_c(v)` on the side `σ = ±1`; and let the germ `(θ, κ)` lie, near `v`, in the closure of a
`c`-tile at `v`. Then near `v`, every point at a direction within `ε` of `θ` on the side `σ` of the germ is clear for `c`: by
N3-CLEAR in the first case, and in the second by pushing the germ's point on the same perpendicular to `e θ` (`clear_of_push`). -/
theorem clear_near_end (hF : F.Valid) {v : ℂ} {c : Fin k} (hv : F.Covers v 1) (hc : c ∈ F.coloursAt v) {θ κ σ : ℝ}
    (hσ : σ = 1 ∨ σ = -1)
    (hK : e θ ∈ interior (F.allowedCone v c) ∨
      (e θ ∈ F.allowedCone v c ∧ ∃ ψ, 0 < ψ ∧ ψ < π ∧ e (θ + σ * ψ) ∈ F.allowedCone v c))
    (hbase : ∃ T₀, F.TileOf c T₀ ∧ v ∈ closure T₀ ∧ ∃ r > 0, ∀ s ∈ Ioo 0 r, branchPt v θ κ s ∈ closure T₀) :
    ∃ ε > 0, ∃ ρ > 0, ∀ s ∈ Ioo 0 ρ, ∀ φ, 0 ≤ σ * (φ - germDir θ κ s) → |φ - θ| ≤ ε →
      F.IsClear c (v + (s : ℂ) * e φ) := by
  have hπ := Real.pi_pos
  rcases hK with hint | ⟨h1, ψ, hψ, hψπ, h2⟩
  · -- an interior end: N3-CLEAR on a closed interval about `θ`
    have hopen : IsOpen (e ⁻¹' interior (F.allowedCone v c)) := isOpen_interior.preimage continuous_e
    obtain ⟨δ, hδ, hδb⟩ := Metric.isOpen_iff.mp hopen θ hint
    have hΛ : e '' Icc (θ - δ / 2) (θ + δ / 2) ⊆ interior (F.allowedCone v c) := by
      rintro _ ⟨β, hβ, rfl⟩
      apply hδb
      rw [mem_ball, Real.dist_eq, abs_lt]; constructor <;> linarith [hβ.1, hβ.2]
    obtain ⟨ρ, hρ, hclr⟩ := clear_of_subset_interior_allowedCone hF hv hc isCompact_Icc hΛ
    refine ⟨δ / 2, by positivity, ρ, hρ, fun s hs φ _ hφ => hclr φ ⟨?_, ?_⟩ s hs.1 hs.2⟩
    · linarith [(abs_le.mp hφ).1]
    · linarith [(abs_le.mp hφ).2]
  · -- a boundary end: push from the germ
    obtain ⟨T₀, hT₀, hvT₀, r, hr, hbr⟩ := hbase
    obtain ⟨μ, hμ, hcont⟩ := push_contacts_of_mem_allowedCone hσ hψ hψπ h1 h2
    obtain ⟨ρp, hρp, hpush⟩ := clear_of_push hF hv hc (α := θ) (γ := θ + σ * (π / 2)) hμ hcont
    have hσ2 : σ * σ = 1 := by rcases hσ with rfl | rfl <;> norm_num
    set ε := min (μ / 2) (π / 4) with hε
    have hε0 : 0 < ε := lt_min (by positivity) (by positivity)
    set ρ := min (min (ρp / 2) (r / 2)) (1 / (4 * (|κ| + 1))) with hρ
    have hρ0 : 0 < ρ := lt_min (lt_min (by positivity) (by positivity)) (by positivity)
    refine ⟨ε, hε0, ρ, hρ0, fun s hs φ hside hφ => ?_⟩
    have hsρp : s < ρp / 2 := lt_of_lt_of_le hs.2 ((min_le_left _ _).trans (min_le_left _ _))
    have hsr : s < r / 2 := lt_of_lt_of_le hs.2 ((min_le_left _ _).trans (min_le_right _ _))
    have hsκ : s ≤ 1 / (4 * (|κ| + 1)) := hs.2.le.trans (min_le_right _ _)
    have hκs : |κ| * s ≤ 1 / 4 := by
      have h4 : 0 < 4 * (|κ| + 1) := by positivity
      have : s * (4 * (|κ| + 1)) ≤ 1 := by rwa [le_div_iff₀ h4] at hsκ
      nlinarith [abs_nonneg κ]
    have hs0 := hs.1
    have hφε : |φ - θ| ≤ π / 4 := hφ.trans (min_le_right _ _)
    have hφμ : |φ - θ| ≤ μ / 2 := hφ.trans (min_le_left _ _)
    obtain ⟨z₀, τ, hτ, hzz₀, hz₀br, hn₀pos, hn₀le⟩ := push_decomp v hσ hs0 hκs hφε hside
    have hz₀cl : z₀ ∈ closure T₀ := by
      rw [hz₀br]; exact hbr _ ⟨hn₀pos, by linarith⟩
    have hzv : dist (v + (s : ℂ) * e φ) v = s := by
      rw [dist_eq_norm, add_sub_cancel_left, norm_mul_e hs0.le]
    rw [hzz₀]
    refine hpush T₀ hT₀ hvT₀ z₀ hz₀cl τ hτ ?_ ?_ ?_
    · rw [dist_eq_norm]; linarith
    · rw [← hzz₀, hzv]; linarith
    · rw [← hzz₀, show v + (s : ℂ) * e φ - v = (s : ℂ) * e φ by ring, norm_mul_e hs0.le, dist_eq_norm,
        show (s : ℂ) * e φ - (s : ℂ) * e θ = (s : ℂ) * (e φ - e θ) by ring, norm_mul, Complex.norm_real,
        Real.norm_eq_abs, abs_of_pos hs0]
      have h2 : ‖e φ - e θ‖ ≤ μ / 2 := (norm_e_sub_e_le φ θ).trans hφμ
      calc s * ‖e φ - e θ‖ ≤ s * (μ / 2) := mul_le_mul_of_nonneg_left h2 hs0.le
        _ = μ / 2 * s := by ring

end ArcMap

end HadwigerNelson.Plane
