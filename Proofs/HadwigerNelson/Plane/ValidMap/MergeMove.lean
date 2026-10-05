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
* **The orbit of `next` and its lifted directions** (`BranchGerms.idx`, `turns`, `lift`, `liftDir`; FS131-IMM2): the germs after `s`
  in order, with directions lifted so they increase (`lift_succ`, `lift_add_n`, `mem_sector_idx`).
* **The directions of a convex cone** (`cone_mem_interior_of_arc`, `cone_half_plane`, `cone_mem_interior_of_between`, `cone_side`):
  between two directions of `D_c(v)` with an excluded direction outside, every direction is interior.
* **The gap** (`gap_assemble`, `gap_clear`, `exists_gap`): two `c`-sectors consecutive along the orbit after an excluded direction,
  with every point of the gap between them near `v` clear for `c` (record § 4.1–4.2).

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

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## The orbit of `next` and the lifted directions along it -/

namespace BranchGerms

variable {n : ℕ} (G : BranchGerms n)

/-- The `m`-th index after `s` along `next`: `(s + m) mod n`. -/
def idx (s : Fin n) (m : ℕ) : Fin n := ⟨(s.val + m) % n, Nat.mod_lt _ s.pos⟩

/-- The number of full turns taken by the first `m` steps after `s`. -/
def turns (s : Fin n) (m : ℕ) : ℕ := (s.val + m) / n

/-- **The lifted direction of germ `idx s m`**: its direction plus `2π` per full turn, so the lifts increase along the orbit. -/
noncomputable def lift (s : Fin n) (m : ℕ) : ℝ := G.β (idx s m) + 2 * π * (turns s m : ℝ)

/-- The lifted direction of germ `idx s m` at distance `t`. -/
noncomputable def liftDir (s : Fin n) (m : ℕ) (t : ℝ) : ℝ := germDir (G.lift s m) (G.κ (idx s m)) t

/-- Spec: two steps after the last of three germs reach the second, one turn on. -/
example : idx (n := 3) ⟨2, by norm_num⟩ 2 = ⟨1, by norm_num⟩ ∧ turns (n := 3) ⟨2, by norm_num⟩ 2 = 1 := by decide

/-- Spec: the lift of the germ one step after the last of three is the first germ's direction plus a turn, and its lifted direction
at distance `0` is that lift. -/
example : (⟨![0, 1, 2], ![0, 0, 0]⟩ : BranchGerms 3).lift ⟨2, by norm_num⟩ 1 = 2 * π ∧
    (⟨![0, 1, 2], ![0, 0, 0]⟩ : BranchGerms 3).liftDir ⟨2, by norm_num⟩ 1 0 = 2 * π := by
  refine ⟨?_, ?_⟩
  · simp [lift, idx, turns]
  · simp [liftDir, lift, idx, turns]

theorem idx_zero (s : Fin n) : idx s 0 = s := Fin.ext (by simp [idx, Nat.mod_eq_of_lt s.isLt])

theorem turns_zero (s : Fin n) : turns s 0 = 0 := by simp [turns, Nat.div_eq_of_lt s.isLt]

theorem lift_zero (s : Fin n) : G.lift s 0 = G.β s := by simp [lift, idx_zero, turns_zero]

theorem next_idx (s : Fin n) (m : ℕ) : next (idx s m) = idx s (m + 1) := by
  have hn := s.pos
  have h1 := Nat.mod_add_div (s.val + m) n
  have hlt := Nat.mod_lt (s.val + m) hn
  unfold next idx
  split_ifs with h
  · apply Fin.ext
    simp only at h ⊢
    rw [show s.val + (m + 1) = ((s.val + m) % n + 1) + n * ((s.val + m) / n) by omega,
      Nat.add_mul_mod_self_left, Nat.mod_eq_of_lt h]
  · apply Fin.ext
    simp only at h ⊢
    rw [show s.val + (m + 1) = n * ((s.val + m) / n + 1) by rw [Nat.mul_add, Nat.mul_one]; omega,
      Nat.mul_mod_right]

theorem turns_succ (s : Fin n) (m : ℕ) :
    turns s (m + 1) = if (idx s m).val + 1 < n then turns s m else turns s m + 1 := by
  have hn := s.pos
  unfold turns idx
  simp only
  have := Nat.mod_add_div (s.val + m) n
  have hlt := Nat.mod_lt (s.val + m) hn
  split_ifs with h
  · rw [← Nat.add_assoc]
    rw [show s.val + m + 1 = ((s.val + m) % n + 1) + n * ((s.val + m) / n) by omega,
      Nat.add_mul_div_left _ _ hn, Nat.div_eq_of_lt h, Nat.zero_add]
  · rw [← Nat.add_assoc]
    rw [show s.val + m + 1 = n * ((s.val + m) / n + 1) by rw [Nat.mul_add, Nat.mul_one]; omega,
      Nat.mul_div_cancel_left _ hn]

/-- **One step of the lift** adds the gap to the next germ's direction. -/
theorem lift_succ (s : Fin n) (m : ℕ) :
    G.lift s (m + 1) = G.lift s m + (G.nextβ (idx s m) - G.β (idx s m)) := by
  have hts := turns_succ s m
  have hni := next_idx s m
  unfold lift
  unfold nextβ
  unfold next at hni
  split_ifs at hts hni ⊢ with h
  · rw [← hni, hts]; ring
  · rw [← hni, hts]; push_cast; ring

/-- The lift at one step is the next direction of the previous germ, plus its turns. -/
theorem lift_succ' (s : Fin n) (m : ℕ) :
    G.lift s (m + 1) = G.nextβ (idx s m) + 2 * π * (turns s m : ℝ) := by
  rw [lift_succ]; unfold lift; ring

theorem κ_idx_succ (s : Fin n) (m : ℕ) : G.κ (idx s (m + 1)) = G.nextκ (idx s m) := by
  rw [nextκ_eq, next_idx]

/-- The lift is the germ's direction up to whole turns. -/
theorem e_lift (s : Fin n) (m : ℕ) : e (G.lift s m) = e (G.β (idx s m)) := by
  unfold lift
  rw [e_eq_e_iff]
  exact ⟨((turns s m : ℕ) : ℤ), by push_cast; ring⟩

/-- The lifted direction at a distance is the germ's direction there plus its turns. -/
theorem liftDir_eq (s : Fin n) (m : ℕ) (t : ℝ) :
    G.liftDir s m t = G.dir (idx s m) t + 2 * π * (turns s m : ℝ) := by
  unfold liftDir lift; rw [dir]; unfold germDir; ring

/-- The lifted direction one step on is the previous germ's next direction plus its turns. -/
theorem liftDir_succ (s : Fin n) (m : ℕ) (t : ℝ) :
    G.liftDir s (m + 1) t = G.nextDir (idx s m) t + 2 * π * (turns s m : ℝ) := by
  unfold liftDir nextDir germDir
  rw [lift_succ', κ_idx_succ]; ring

/-- The branch point of germ `idx s m` along its lifted direction. -/
theorem branchPt_idx (v : ℂ) (s : Fin n) (m : ℕ) (t : ℝ) :
    branchPt v (G.β (idx s m)) (G.κ (idx s m)) t = v + (t : ℂ) * e (G.liftDir s m t) := by
  rw [branchPt_eq, liftDir_eq]
  congr 2
  rw [e_eq_e_iff]
  exact ⟨-((turns s m : ℕ) : ℤ), by unfold dir; push_cast; ring⟩

/-- **The sector `idx s m` in lifted directions.** -/
theorem mem_sector_idx {v : ℂ} {r : ℝ} (s : Fin n) (m : ℕ) {z : ℂ} :
    z ∈ G.sector v r (idx s m) ↔
      ∃ t ∈ Ioo 0 r, ∃ φ ∈ Ioo (G.liftDir s m t) (G.liftDir s (m + 1) t), z = v + (t : ℂ) * e φ := by
  rw [sector_eq]
  simp only [liftDir_succ]
  simp only [mem_setOf_eq, G.liftDir_eq s m]
  set T := 2 * π * (turns s m : ℝ)
  have he : ∀ φ, e (φ + T) = e φ := fun φ => by
    rw [e_eq_e_iff]; exact ⟨((turns s m : ℕ) : ℤ), by simp only [T]; push_cast; ring⟩
  constructor
  · rintro ⟨t, ht, φ, hφ, rfl⟩
    exact ⟨t, ht, φ + T, ⟨by linarith [hφ.1], by linarith [hφ.2]⟩, by rw [he]⟩
  · rintro ⟨t, ht, φ, hφ, rfl⟩
    exact ⟨t, ht, φ - T, ⟨by linarith [hφ.1], by linarith [hφ.2]⟩, by rw [← he (φ - T), sub_add_cancel]⟩

/-- The lifted directions increase along the orbit where the germs are ordered. -/
theorem liftDir_lt_succ {s₀ : ℝ} (hord : ∀ t ∈ Ioo 0 s₀, ∀ i, G.dir i t < G.nextDir i t) (s : Fin n) (m : ℕ)
    {t : ℝ} (ht : t ∈ Ioo 0 s₀) : G.liftDir s m t < G.liftDir s (m + 1) t := by
  rw [liftDir_eq, liftDir_succ]; linarith [hord t ht (idx s m)]

theorem liftDir_mono {s₀ : ℝ} (hord : ∀ t ∈ Ioo 0 s₀, ∀ i, G.dir i t < G.nextDir i t) (s : Fin n)
    {t : ℝ} (ht : t ∈ Ioo 0 s₀) : StrictMono fun m => G.liftDir s m t :=
  strictMono_nat_of_lt_succ fun m => G.liftDir_lt_succ hord s m ht

theorem lift_mono (hM : G.Mono) (s : Fin n) : Monotone (G.lift s) :=
  monotone_nat_of_le_succ fun m => by rw [lift_succ]; linarith [hM (idx s m)]

theorem idx_add_n (s : Fin n) (m : ℕ) : idx s (m + n) = idx s m := Fin.ext (by simp [idx, ← Nat.add_assoc])

theorem turns_add_n (s : Fin n) (m : ℕ) : turns s (m + n) = turns s m + 1 := by
  unfold turns; rw [← Nat.add_assoc, Nat.add_div_right _ s.pos]

/-- **A full turn** adds `2π` to the lift. -/
theorem lift_add_n (s : Fin n) (m : ℕ) : G.lift s (m + n) = G.lift s m + 2 * π := by
  unfold lift; rw [idx_add_n, turns_add_n]; push_cast; ring

/-- Every index is on the orbit within one turn. -/
theorem exists_idx_eq (s i : Fin n) : ∃ m < n, idx s m = i := by
  have hn := s.pos
  refine ⟨(i.val + n - s.val) % n, Nat.mod_lt _ hn, Fin.ext ?_⟩
  simp only [idx]
  rw [Nat.add_mod, Nat.mod_mod, ← Nat.add_mod]
  rw [show s.val + (i.val + n - s.val) = i.val + n by have := s.isLt; omega, Nat.add_mod_right,
    Nat.mod_eq_of_lt i.isLt]

/-- Distinct steps within one turn reach distinct indices. -/
theorem idx_ne {s : Fin n} {m m' : ℕ} (h : m < m') (h' : m' < m + n) : idx s m ≠ idx s m' := by
  intro heq
  have := congrArg Fin.val heq
  simp only [idx] at this
  have hn := s.pos
  have h1 := Nat.mod_add_div (s.val + m) n
  have h2 := Nat.mod_add_div (s.val + m') n
  have h3 : (s.val + m') / n ≤ (s.val + m) / n + 1 := by
    rw [← Nat.add_div_right _ hn]; exact Nat.div_le_div_right (by omega)
  have h4 : (s.val + m) / n ≤ (s.val + m') / n := Nat.div_le_div_right (by omega)
  set Q := (s.val + m) / n
  set Q' := (s.val + m') / n
  rcases Nat.lt_or_ge Q Q' with h5 | h5
  · have h6 : Q' = Q + 1 := by omega
    rw [h6, Nat.mul_add, Nat.mul_one] at h2
    omega
  · have h6 : Q' = Q := by omega
    rw [h6] at h2
    omega

end BranchGerms

/-! ## The directions of a convex cone in the plane -/

/-- `e θ` in coordinates against `e α`: the cross product is `sin (θ − α)`. -/
theorem cross_e_e (α θ : ℝ) : (e α).re * (e θ).im - (e α).im * (e θ).re = Real.sin (θ - α) := by
  simp only [re_e, im_e]; rw [Real.sin_sub]; ring


section ConeArc

variable {K : Set ℂ} (hadd : ∀ d ∈ K, ∀ d' ∈ K, d + d' ∈ K) (hsmul : ∀ d ∈ K, ∀ t : ℝ, 0 ≤ t → (t : ℂ) * d ∈ K)
include hadd hsmul

omit hadd in
/-- In a convex cone, a positive multiple of an interior point is interior. -/
theorem cone_smul_mem_interior {d : ℂ} (hd : d ∈ interior K) {t : ℝ} (ht : 0 < t) : (t : ℂ) * d ∈ interior K := by
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp isOpen_interior d hd
  rw [mem_interior]
  refine ⟨ball ((t : ℂ) * d) (t * ε), fun y hy => ?_, isOpen_ball, mem_ball_self (by positivity)⟩
  have ht0 : (t : ℂ) ≠ 0 := by exact_mod_cast ht.ne'
  have hy' : y / t ∈ ball d ε := by
    rw [mem_ball, dist_eq_norm] at hy ⊢
    have : y / t - d = (y - t * d) / t := by field_simp
    rw [this, norm_div, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht, div_lt_iff₀ ht]; linarith
  have := hsmul _ (interior_subset (hball hy')) t ht.le
  rwa [mul_div_cancel₀ _ ht0] at this

omit hsmul in
/-- In a convex cone, an interior point plus a point of the cone is interior. -/
theorem cone_add_mem_interior {d d' : ℂ} (hd : d ∈ interior K) (hd' : d' ∈ K) : d + d' ∈ interior K := by
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp isOpen_interior d hd
  rw [mem_interior]
  refine ⟨ball (d + d') ε, fun y hy => ?_, isOpen_ball, mem_ball_self hε⟩
  have hy' : y - d' ∈ ball d ε := by
    rw [mem_ball, dist_eq_norm] at hy ⊢; rwa [show y - d' - d = y - (d + d') by ring]
  have := hadd _ (interior_subset (hball hy')) d' hd'
  rwa [sub_add_cancel] at this

omit hadd in
/-- A convex cone with `0` interior is the plane. -/
theorem cone_eq_univ_of_zero_mem_interior (h0 : (0 : ℂ) ∈ interior K) : K = univ := by
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp isOpen_interior 0 h0
  refine eq_univ_of_forall fun u => ?_
  by_cases hu : u = 0
  · subst hu; exact interior_subset h0
  have hn : 0 < ‖u‖ := norm_pos_iff.mpr hu
  have hw : ((ε / (2 * ‖u‖) : ℝ) : ℂ) * u ∈ K := by
    refine interior_subset (hball ?_)
    rw [mem_ball, dist_zero_right, norm_mul, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos (by positivity)]
    field_simp; linarith
  have := hsmul _ hw (2 * ‖u‖ / ε) (by positivity)
  rwa [← mul_assoc, ← ofReal_mul, show 2 * ‖u‖ / ε * (ε / (2 * ‖u‖)) = 1 by field_simp, ofReal_one, one_mul] at this

/-- **An open arc shorter than `π` with both ends in a convex cone is interior to it** (Cramer: every vector is a combination of
the two end directions with coefficients `cross(d, e β)/sin(β − α)` and `cross(e α, d)/sin(β − α)`). -/
theorem cone_mem_interior_of_arc {α β : ℝ} (hα : e α ∈ K) (hβ : e β ∈ K) (h0 : 0 < β - α) (hπ : β - α < π)
    {θ : ℝ} (hθ : θ ∈ Ioo α β) : e θ ∈ interior K := by
  set S := Real.sin (β - α) with hS
  have hS0 : 0 < S := Real.sin_pos_of_pos_of_lt_pi h0 hπ
  set U : Set ℂ := {d | 0 < d.re * Real.sin β - d.im * Real.cos β ∧ 0 < Real.cos α * d.im - Real.sin α * d.re} with hU
  have hUo : IsOpen U :=
    (isOpen_lt continuous_const ((continuous_re.mul continuous_const).sub (continuous_im.mul continuous_const))).inter
      (isOpen_lt continuous_const ((continuous_const.mul continuous_im).sub (continuous_const.mul continuous_re)))
  have hUK : U ⊆ K := by
    rintro d ⟨h1, h2⟩
    have hdec : d = (((d.re * Real.sin β - d.im * Real.cos β) / S : ℝ) : ℂ) * e α +
        (((Real.cos α * d.im - Real.sin α * d.re) / S : ℝ) : ℂ) * e β := by
      apply Complex.ext <;>
        simp only [add_re, add_im, mul_re, mul_im, ofReal_re, ofReal_im, re_e, im_e, zero_mul, sub_zero, add_zero] <;>
        field_simp <;> rw [hS, Real.sin_sub] <;> ring
    rw [hdec]
    exact hadd _ (hsmul _ hα _ (div_pos h1 hS0).le) _ (hsmul _ hβ _ (div_pos h2 hS0).le)
  refine interior_maximal hUK hUo ⟨?_, ?_⟩
  · simp only [re_e, im_e]
    rw [show Real.cos θ * Real.sin β - Real.sin θ * Real.cos β = Real.sin (β - θ) by rw [Real.sin_sub]; ring]
    exact Real.sin_pos_of_pos_of_lt_pi (by linarith [hθ.2]) (by linarith [hθ.1])
  · simp only [re_e, im_e]
    rw [show Real.cos α * Real.sin θ - Real.sin α * Real.cos θ = Real.sin (θ - α) by rw [Real.sin_sub]; ring]
    exact Real.sin_pos_of_pos_of_lt_pi (by linarith [hθ.1]) (by linarith [hθ.2])

/-- **A half-plane from a line**: if `±u` (a unit vector) lie in the cone and a point `x` of it is strictly on the left of `u`, every
point strictly on the left lies in the cone; interior when `x` is. -/
theorem cone_half_plane {u : ℂ} (hu : ‖u‖ = 1) (hpos : u ∈ K) (hneg : -u ∈ K) {x : ℂ}
    (hb : 0 < u.re * x.im - u.im * x.re) {y : ℂ} (hy : 0 < u.re * y.im - u.im * y.re) :
    (x ∈ K → y ∈ K) ∧ (x ∈ interior K → y ∈ interior K) := by
  have hu2 : u.re ^ 2 + u.im ^ 2 = 1 := by
    have := Complex.sq_norm u; rw [hu, Complex.normSq_apply] at this; nlinarith [this]
  have kre : (u.re * x.im - u.im * x.re) * y.re = (u.re * y.im - u.im * y.re) * x.re +
      ((u.re * y.re + u.im * y.im) * (u.re * x.im - u.im * x.re) -
        (u.re * y.im - u.im * y.re) * (u.re * x.re + u.im * x.im)) * u.re := by
    linear_combination ((u.re * y.im - u.im * y.re) * x.re - (u.re * x.im - u.im * x.re) * y.re) * hu2
  have kim : (u.re * x.im - u.im * x.re) * y.im = (u.re * y.im - u.im * y.re) * x.im +
      ((u.re * y.re + u.im * y.im) * (u.re * x.im - u.im * x.re) -
        (u.re * y.im - u.im * y.re) * (u.re * x.re + u.im * x.im)) * u.im := by
    linear_combination ((u.re * y.im - u.im * y.re) * x.im - (u.re * x.im - u.im * x.re) * y.im) * hu2
  set b := u.re * x.im - u.im * x.re
  set by' := u.re * y.im - u.im * y.re
  set a := u.re * x.re + u.im * x.im
  set a' := u.re * y.re + u.im * y.im
  have hdec : y = ((by' / b : ℝ) : ℂ) * x + ((a' - by' / b * a : ℝ) : ℂ) * u := by
    have hb0 : b ≠ 0 := hb.ne'
    apply Complex.ext <;>
      simp only [add_re, add_im, mul_re, mul_im, ofReal_re, ofReal_im, zero_mul, sub_zero, add_zero]
    · field_simp; linear_combination kre
    · field_simp; linear_combination kim
  have hline : ∀ t : ℝ, (t : ℂ) * u ∈ K := fun t => by
    rcases le_total 0 t with ht | ht
    · exact hsmul _ hpos t ht
    · have := hsmul _ hneg (-t) (by linarith); rwa [ofReal_neg, neg_mul_neg] at this
  refine ⟨fun hx => ?_, fun hx => ?_⟩
  · rw [hdec]; exact hadd _ (hsmul _ hx _ (div_pos hy hb).le) _ (hline _)
  · rw [hdec]; exact cone_add_mem_interior hadd (cone_smul_mem_interior hsmul hx (div_pos hy hb)) (hline _)

/-- **The directions of a convex cone between two of its directions** (FS110-W-MERGE's gap inside `D_c(v)`): if `e θ₁, e θ₂` lie in
the cone, `e θs` does not, and `θs < θ₁ ≤ θ₂ < θs + 2π`, every direction strictly between `θ₁` and `θ₂` is interior to the cone. -/
theorem cone_mem_interior_of_between (hint : (interior K).Nonempty) {θ₁ θ₂ θs : ℝ} (h1 : e θ₁ ∈ K) (h2 : e θ₂ ∈ K)
    (hs : e θs ∉ K) (hlo : θs < θ₁) (hhi : θ₂ < θs + 2 * π) {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) : e θ ∈ interior K := by
  have hπ := Real.pi_pos
  rcases lt_trichotomy (θ₂ - θ₁) π with hlt | heq | hgt
  · exact cone_mem_interior_of_arc hadd hsmul h1 h2 (by linarith [hθ.1, hθ.2]) hlt hθ
  · -- a half-plane: `±e θ₁` lie in the cone, and an interior point lies on the gap's side
    obtain ⟨d₀, hd₀⟩ := hint
    have hneg : -e θ₁ ∈ K := by
      rw [show -e θ₁ = e θ₂ by rw [show θ₂ = θ₁ + π by linarith, e_add, show e π = -1 by simp [e_eq]]; ring]
      exact h2
    have hu : ‖e θ₁‖ = 1 := norm_e θ₁
    have hcs : (e θ₁).re * (e θs).im - (e θ₁).im * (e θs).re < 0 := by
      rw [cross_e_e]; exact Real.sin_neg_of_neg_of_neg_pi_lt (by linarith) (by linarith)
    -- the interior point is strictly on the gap's side
    have hb : 0 < (e θ₁).re * d₀.im - (e θ₁).im * d₀.re := by
      by_contra hc; push Not at hc
      obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp isOpen_interior d₀ hd₀
      set w := d₀ - ((ε / 2 : ℝ) : ℂ) * (I * e θ₁) with hw
      have hwK : w ∈ K := by
        refine interior_subset (hball ?_)
        rw [mem_ball, dist_eq_norm, hw, show d₀ - ((ε / 2 : ℝ) : ℂ) * (I * e θ₁) - d₀ = -(((ε / 2 : ℝ) : ℂ) * (I * e θ₁)) by ring,
          norm_neg, norm_mul, norm_mul, Complex.norm_real, Complex.norm_I, hu, Real.norm_eq_abs, abs_of_pos (by positivity)]
        linarith
      have hwb : (-e θ₁).re * w.im - (-e θ₁).im * w.re > 0 := by
        have hu2 : (e θ₁).re ^ 2 + (e θ₁).im ^ 2 = 1 := by simp only [re_e, im_e]; exact Real.cos_sq_add_sin_sq θ₁
        simp only [hw, neg_re, neg_im, sub_re, sub_im, mul_re, mul_im, ofReal_re, ofReal_im, I_re, I_im, zero_mul,
          one_mul, zero_sub, sub_zero, zero_add, mul_neg, neg_mul]
        nlinarith [hu2]
      have hsK := (cone_half_plane hadd hsmul (u := -e θ₁) (by rw [norm_neg, hu]) hneg (by rw [neg_neg]; exact h1) hwb
        (y := e θs) (by simp only [neg_re, neg_im]; linarith)).1 hwK
      exact hs hsK
    have hθb : 0 < (e θ₁).re * (e θ).im - (e θ₁).im * (e θ).re := by
      rw [cross_e_e]; exact Real.sin_pos_of_pos_of_lt_pi (by linarith [hθ.1]) (by linarith [hθ.2])
    exact (cone_half_plane hadd hsmul hu h1 hneg hb hθb).2 hd₀
  · -- the complementary arc is shorter than `π` and holds `θs + 2π`
    exfalso
    have h1' : e (θ₁ + 2 * π) ∈ K := by rwa [e_add_two_pi]
    have := cone_mem_interior_of_arc hadd hsmul h2 h1' (by linarith [hθ.1, hθ.2]) (by linarith)
      (θ := θs + 2 * π) ⟨by linarith, by linarith⟩
    rw [e_add_two_pi] at this
    exact hs (interior_subset this)

/-- **A direction of a convex cone with non-empty interior** is interior, or has a direction of the cone on one of its sides within
`(0, π)`. -/
theorem cone_side (hint : (interior K).Nonempty) {θ : ℝ} (hθ : e θ ∈ K) :
    e θ ∈ interior K ∨ ∃ σ : ℝ, (σ = 1 ∨ σ = -1) ∧ ∃ ψ, 0 < ψ ∧ ψ < π ∧ e (θ + σ * ψ) ∈ K := by
  have hπ := Real.pi_pos
  obtain ⟨d₀, hd₀⟩ := hint
  by_cases h0 : d₀ = 0
  · left; rw [cone_eq_univ_of_zero_mem_interior hsmul (h0 ▸ hd₀), interior_univ]; trivial
  obtain ⟨w, hw⟩ : ∃ w, w = d₀ * starRingEnd ℂ (e θ) := ⟨_, rfl⟩
  have hw0 : w ≠ 0 := by rw [hw]; exact mul_ne_zero h0 (by rw [map_ne_zero]; exact e_ne_zero θ)
  have hwn : 0 < ‖w‖ := norm_pos_iff.mpr hw0
  -- `e (θ + arg w)` is `d₀ / ‖w‖`, interior
  have hdir : e (θ + arg w) = ((1 / ‖w‖ : ℝ) : ℂ) * d₀ := by
    have h1 : (‖w‖ : ℂ) * e (arg w) = w := by simp [e]
    have hee : e θ * starRingEnd ℂ (e θ) = 1 := by
      rw [Complex.mul_conj, Complex.normSq_eq_norm_sq, norm_e]; simp
    have key : (‖w‖ : ℂ) * e (θ + arg w) = d₀ := by
      rw [e_add, show (‖w‖ : ℂ) * (e θ * e (arg w)) = e θ * ((‖w‖ : ℂ) * e (arg w)) by ring, h1, hw,
        show e θ * (d₀ * starRingEnd ℂ (e θ)) = d₀ * (e θ * starRingEnd ℂ (e θ)) by ring, hee, mul_one]
    have hwn' : (‖w‖ : ℂ) ≠ 0 := by exact_mod_cast hwn.ne'
    rw [← key]; push_cast; field_simp
  have hint' : e (θ + arg w) ∈ interior K := by rw [hdir]; exact cone_smul_mem_interior hsmul hd₀ (by positivity)
  rcases lt_trichotomy (arg w) 0 with hneg | hzero | hpos
  · right; exact ⟨-1, Or.inr rfl, -arg w, by linarith, by linarith [Complex.neg_pi_lt_arg w], by
      rw [show θ + -1 * -arg w = θ + arg w by ring]; exact interior_subset hint'⟩
  · left; rwa [hzero, add_zero] at hint'
  · rcases lt_or_eq_of_le (Complex.arg_le_pi w) with hlt | heq
    · right; exact ⟨1, Or.inl rfl, arg w, hpos, hlt, by rw [one_mul]; exact interior_subset hint'⟩
    · left
      rw [heq, show e (θ + π) = -e θ by rw [e_add, show e π = -1 by simp [e_eq]]; ring] at hint'
      have h00 := cone_add_mem_interior hadd hint' hθ
      rw [neg_add_cancel] at h00
      rw [cone_eq_univ_of_zero_mem_interior hsmul h00, interior_univ]; trivial

end ConeArc

/-! ## The gap's clearness, assembled from its two ends and its middle -/

/-- **Assembling the gap's clearness**: a property holding near each end of the gap `[germDir θ₁ κ₁ t, germDir θ₂ κ₂ t]` and on
every closed middle interval holds on the whole gap for small `t` (the gap's ends tend to `θ₁` and `θ₂`). -/
theorem gap_assemble {P : ℝ → ℝ → Prop} {θ₁ θ₂ κ₁ κ₂ : ℝ}
    (hend1 : ∃ ε > 0, ∃ ρ > 0, ∀ t ∈ Ioo 0 ρ, ∀ φ, germDir θ₁ κ₁ t ≤ φ → φ ≤ germDir θ₂ κ₂ t → |φ - θ₁| ≤ ε → P t φ)
    (hend2 : ∃ ε > 0, ∃ ρ > 0, ∀ t ∈ Ioo 0 ρ, ∀ φ, germDir θ₁ κ₁ t ≤ φ → φ ≤ germDir θ₂ κ₂ t → |φ - θ₂| ≤ ε → P t φ)
    (hmid : ∀ ε > 0, ∃ ρ > 0, ∀ t ∈ Ioo 0 ρ, ∀ φ ∈ Icc (θ₁ + ε) (θ₂ - ε), P t φ) :
    ∃ ρ > 0, ∀ t ∈ Ioo 0 ρ, ∀ φ, germDir θ₁ κ₁ t ≤ φ → φ ≤ germDir θ₂ κ₂ t → P t φ := by
  obtain ⟨ε₁, hε₁, ρ₁, hρ₁, h1⟩ := hend1
  obtain ⟨ε₂, hε₂, ρ₂, hρ₂, h2⟩ := hend2
  set ε := min ε₁ ε₂ with hε
  have hε0 : 0 < ε := lt_min hε₁ hε₂
  obtain ⟨ρm, hρm, hm⟩ := hmid ε hε0
  obtain ⟨η, hη, harc⟩ := exists_abs_arcsin_lt hε0
  set ρa := η / (|κ₁| + |κ₂| + 1) with hρa
  have hρa0 : 0 < ρa := by positivity
  refine ⟨min (min ρ₁ ρ₂) (min ρm ρa), lt_min (lt_min hρ₁ hρ₂) (lt_min hρm hρa0), fun t ht φ hφ1 hφ2 => ?_⟩
  have ht1 : t < ρ₁ := ht.2.trans_le ((min_le_left _ _).trans (min_le_left _ _))
  have ht2 : t < ρ₂ := ht.2.trans_le ((min_le_left _ _).trans (min_le_right _ _))
  have htm : t < ρm := ht.2.trans_le ((min_le_right _ _).trans (min_le_left _ _))
  have hta : t < ρa := ht.2.trans_le ((min_le_right _ _).trans (min_le_right _ _))
  have hsmall : ∀ κ, |κ| ≤ |κ₁| + |κ₂| → |Real.arcsin (κ * t / 2)| < ε := fun κ hκ => by
    refine harc _ ?_
    rw [abs_div, abs_mul, abs_of_pos ht.1, abs_two]
    have : |κ| * t ≤ (|κ₁| + |κ₂|) * t := mul_le_mul_of_nonneg_right hκ ht.1.le
    have h3 : (|κ₁| + |κ₂| + 1) * t < η := by rw [hρa, lt_div_iff₀ (by positivity)] at hta; linarith
    nlinarith [abs_nonneg κ₁, abs_nonneg κ₂, ht.1]
  have hd1 := hsmall κ₁ (by linarith [abs_nonneg κ₂])
  have hd2 := hsmall κ₂ (by linarith [abs_nonneg κ₁])
  unfold germDir at hφ1 hφ2
  have hφ1' : θ₁ - ε < φ := by linarith [(abs_lt.mp hd1).1]
  have hφ2' : φ < θ₂ + ε := by linarith [(abs_lt.mp hd2).2]
  by_cases hA : φ ≤ θ₁ + ε
  · refine h1 t ⟨ht.1, ht1⟩ φ hφ1 hφ2 ?_
    rw [abs_le]; constructor <;> linarith [min_le_left ε₁ ε₂]
  by_cases hB : θ₂ - ε ≤ φ
  · refine h2 t ⟨ht.1, ht2⟩ φ hφ1 hφ2 ?_
    rw [abs_le]; constructor <;> linarith [min_le_right ε₁ ε₂]
  push Not at hA hB
  exact hm t ⟨ht.1, htm⟩ φ ⟨hA.le, hB.le⟩

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ} (X : F.Near v)

/-- A chart sector lies in a tile of its colour whose closure holds `v`. -/
theorem exists_tile_of_sector (i : Fin X.n) :
    ∃ T₀, F.TileOf (X.col i) T₀ ∧ X.G.sector v X.s₀ i ⊆ T₀ ∧ v ∈ closure T₀ := by
  obtain ⟨z, hz⟩ := X.hC.sector_nonempty X.hs₀ i
  have hI := X.hC.sector_subset_interiorPts i.pos X.hs₀ i
  have hsub : X.G.sector v X.s₀ i ⊆ connectedComponentIn F.interiorPts z :=
    (X.hC.isPreconnected X.s₀ X.hs₀ i).subset_connectedComponentIn hz hI
  have hT : F.IsTile (connectedComponentIn F.interiorPts z) := ⟨z, hI hz, rfl⟩
  refine ⟨_, ?_, hsub, closure_mono hsub (X.hC.mem_closure_sector X.hs₀ i)⟩
  have := hT.tileOf (mem_connectedComponentIn (hI hz))
  have hc : F.col z = X.col i := by simpa using (X.hcol₀ i hz).2
  rwa [hc] at this

/-- **A colour with two sectors at `v` has a germ there**: with no germ the punctured ball is one sector. -/
theorem pos_of_hasSectors {c : Fin k} {m : ℕ} (hm2 : 2 ≤ m) (hm : F.HasSectors v c m) : 0 < X.n := by
  by_contra h0
  have hn0 : X.n = 0 := by omega
  obtain ⟨r, hr', hr⟩ := (hm.and (Ioc_mem_nhdsGT X.hC.pos)).exists
  have hball : ball v r ⊆ F.interiorPts := (ball_subset_ball hr.2).trans (X.hC.empty hn0)
  have hle : (F.sectorsOf v r c).encard ≤ 1 := by
    refine (encard_le_encard (t := {ball v r}) ?_).trans (by simp)
    rintro S ⟨⟨x, hx, rfl, -⟩, -⟩
    rw [mem_singleton_iff, inter_eq_right.mpr hball]
    exact (convex_ball v r).isPreconnected.connectedComponentIn hx.2
  rw [hr'] at hle
  have : (2 : ℕ∞) ≤ m := by exact_mod_cast hm2
  have := this.trans hle
  norm_num at this

variable {X}

/-- **The ends of a `c`-sector's directions lie in `D_c(v)`.** -/
theorem e_mem_allowedCone_of_col (hF : F.Valid) (hv : F.Covers v 1) {c : Fin k} {i : Fin X.n} (hi : X.col i = c)
    {θ : ℝ} (hθ : θ ∈ Icc (X.G.β i) (X.G.nextβ i)) : e θ ∈ F.allowedCone v c := by
  refine coneAt_subset_allowedCone hF hv ?_
  refine coneAt_mono ((X.hcol₀ i).trans (by rw [hi])) v ?_
  rw [X.hC.cone X.s₀ X.hs₀ i]; exact Icc_subset_angleIcc _ _ hθ

/-- A germ's branch point along its lifted direction. -/
theorem branchPt_lift (s : Fin X.n) (m : ℕ) (t : ℝ) :
    branchPt v (X.G.lift s m) (X.G.κ (BranchGerms.idx s m)) t =
      branchPt v (X.G.β (BranchGerms.idx s m)) (X.G.κ (BranchGerms.idx s m)) t := by
  rw [X.G.branchPt_idx v s m t]; rfl

/-- **The base of the gap's lower end**: the germ after a `c`-sector lies in the closure of that sector's tile. -/
theorem base_before {c : Fin k} {s : Fin X.n} {a : ℕ} (hca : X.col (BranchGerms.idx s a) = c) :
    ∃ T₀, F.TileOf c T₀ ∧ v ∈ closure T₀ ∧ ∃ r > 0, ∀ t ∈ Ioo 0 r,
      branchPt v (X.G.lift s (a + 1)) (X.G.κ (BranchGerms.idx s (a + 1))) t ∈ closure T₀ := by
  obtain ⟨T₀, hT₀, hsub, hvT⟩ := X.exists_tile_of_sector (BranchGerms.idx s a)
  rw [hca] at hT₀
  refine ⟨T₀, hT₀, hvT, X.s₀, X.hs₀.1, fun t ht => ?_⟩
  rw [branchPt_lift, ← BranchGerms.next_idx]
  exact closure_mono hsub (IsSectorChart.branchPt_mem_closure_sector_before X.hord le_rfl _ ht)

/-- **The base of the gap's upper end**: a `c`-sector's own germ lies in the closure of its tile. -/
theorem base_after {c : Fin k} {s : Fin X.n} {b : ℕ} (hcb : X.col (BranchGerms.idx s b) = c) :
    ∃ T₀, F.TileOf c T₀ ∧ v ∈ closure T₀ ∧ ∃ r > 0, ∀ t ∈ Ioo 0 r,
      branchPt v (X.G.lift s b) (X.G.κ (BranchGerms.idx s b)) t ∈ closure T₀ := by
  obtain ⟨T₀, hT₀, hsub, hvT⟩ := X.exists_tile_of_sector (BranchGerms.idx s b)
  rw [hcb] at hT₀
  refine ⟨T₀, hT₀, hvT, X.s₀, X.hs₀.1, fun t ht => ?_⟩
  rw [branchPt_lift]
  exact closure_mono hsub (IsSectorChart.branchPt_mem_closure_sector_after X.hord le_rfl _ ht)

/-- **The gap's clearness** (FS110-W-MERGE's gap, record § 4.2): between a `c`-sector `idx s a` and the next `c`-sector `idx s b`,
with a direction `e θs ∉ D_c(v)` below the gap and one turn above it, every point of the gap near `v` is clear for `c`. -/
theorem gap_clear (hF : F.Valid) (hv : F.Covers v 1) {c : Fin k} (hc : c ∈ F.coloursAt v)
    (hD : (interior (F.allowedCone v c)).Nonempty) {s : Fin X.n} {a b : ℕ} (hab : a < b)
    (hca : X.col (BranchGerms.idx s a) = c) (hcb : X.col (BranchGerms.idx s b) = c) {θs : ℝ}
    (hθs : e θs ∉ F.allowedCone v c) (hlo : θs < X.G.lift s (a + 1)) (hhi : X.G.lift s b < θs + 2 * π) :
    ∃ ρc > 0, ∀ t ∈ Ioo 0 ρc, ∀ φ, X.G.liftDir s (a + 1) t ≤ φ → φ ≤ X.G.liftDir s b t →
      F.IsClear c (v + (t : ℂ) * e φ) := by
  have hπ := Real.pi_pos
  have hπ3 := Real.two_le_pi
  have hadd : ∀ d ∈ F.allowedCone v c, ∀ d' ∈ F.allowedCone v c, d + d' ∈ F.allowedCone v c :=
    fun d hd d' hd' => add_mem_allowedCone hd hd'
  have hsmul : ∀ d ∈ F.allowedCone v c, ∀ t : ℝ, 0 ≤ t → (t : ℂ) * d ∈ F.allowedCone v c :=
    fun d hd t ht => smul_mem_allowedCone ht hd
  set θ₁ := X.G.lift s (a + 1) with hθ₁
  set θ₂ := X.G.lift s b with hθ₂
  set κ₁ := X.G.κ (BranchGerms.idx s (a + 1)) with hκ₁
  set κ₂ := X.G.κ (BranchGerms.idx s b) with hκ₂
  have hM := X.hC.sorted.mono
  have h12 : θ₁ ≤ θ₂ := X.G.lift_mono hM s (by omega)
  have h1K : e θ₁ ∈ F.allowedCone v c := by
    rw [hθ₁, X.G.lift_succ', show e (X.G.nextβ (BranchGerms.idx s a) + 2 * π * (BranchGerms.turns s a : ℝ)) =
      e (X.G.nextβ (BranchGerms.idx s a)) by rw [e_eq_e_iff]; exact ⟨(BranchGerms.turns s a : ℤ), by push_cast; ring⟩]
    exact e_mem_allowedCone_of_col hF hv hca ⟨hM _, le_rfl⟩
  have h2K : e θ₂ ∈ F.allowedCone v c := by
    rw [hθ₂, X.G.e_lift]; exact e_mem_allowedCone_of_col hF hv hcb ⟨le_rfl, hM _⟩
  -- the end lemmas in the gap's form
  have end1 : ∀ hK : e θ₁ ∈ interior (F.allowedCone v c) ∨
      (e θ₁ ∈ F.allowedCone v c ∧ ∃ ψ, 0 < ψ ∧ ψ < π ∧ e (θ₁ + 1 * ψ) ∈ F.allowedCone v c),
      ∃ ε > 0, ∃ ρ > 0, ∀ t ∈ Ioo 0 ρ, ∀ φ, germDir θ₁ κ₁ t ≤ φ → φ ≤ germDir θ₂ κ₂ t → |φ - θ₁| ≤ ε →
        F.IsClear c (v + (t : ℂ) * e φ) := fun hK => by
    obtain ⟨ε, hε, ρ, hρ, h⟩ := clear_near_end hF hv hc (Or.inl rfl) hK (X.base_before hca)
    exact ⟨ε, hε, ρ, hρ, fun t ht φ hφ1 _ hφ => h t ht φ (by linarith) hφ⟩
  have end2 : ∀ hK : e θ₂ ∈ interior (F.allowedCone v c) ∨
      (e θ₂ ∈ F.allowedCone v c ∧ ∃ ψ, 0 < ψ ∧ ψ < π ∧ e (θ₂ + -1 * ψ) ∈ F.allowedCone v c),
      ∃ ε > 0, ∃ ρ > 0, ∀ t ∈ Ioo 0 ρ, ∀ φ, germDir θ₁ κ₁ t ≤ φ → φ ≤ germDir θ₂ κ₂ t → |φ - θ₂| ≤ ε →
        F.IsClear c (v + (t : ℂ) * e φ) := fun hK => by
    obtain ⟨ε, hε, ρ, hρ, h⟩ := clear_near_end hF hv hc (Or.inr rfl) hK (X.base_after hcb)
    exact ⟨ε, hε, ρ, hρ, fun t ht φ _ hφ2 hφ => h t ht φ (by linarith) hφ⟩
  refine gap_assemble (κ₁ := κ₁) (κ₂ := κ₂) (P := fun t φ => F.IsClear c (v + (t : ℂ) * e φ)) ?_ ?_ ?_
  · rcases lt_or_eq_of_le h12 with hlt | heq
    · set ψ := min ((θ₂ - θ₁) / 2) 1
      have hψ0 : 0 < ψ := lt_min (by linarith) one_pos
      have hψ1 : ψ ≤ 1 := min_le_right _ _
      have hψ2 : ψ ≤ (θ₂ - θ₁) / 2 := min_le_left _ _
      exact end1 (Or.inr ⟨h1K, ψ, hψ0, by linarith, interior_subset (cone_mem_interior_of_between hadd hsmul hD h1K h2K
        hθs hlo hhi ⟨by linarith, by linarith⟩)⟩)
    · rcases cone_side hadd hsmul hD h1K with hint | ⟨σ, hσ, ψ, hψ, hψπ, hK⟩
      · exact end1 (Or.inl hint)
      · rcases hσ with rfl | rfl
        · exact end1 (Or.inr ⟨h1K, ψ, hψ, hψπ, hK⟩)
        · obtain ⟨ε, hε, ρ, hρ, h⟩ := end2 (Or.inr ⟨h2K, ψ, hψ, hψπ, by rw [← heq]; exact hK⟩)
          exact ⟨ε, hε, ρ, hρ, fun t ht φ h1 h2 hφ => h t ht φ h1 h2 (by rw [← heq]; exact hφ)⟩
  · rcases lt_or_eq_of_le h12 with hlt | heq
    · set ψ := min ((θ₂ - θ₁) / 2) 1
      have hψ0 : 0 < ψ := lt_min (by linarith) one_pos
      have hψ1 : ψ ≤ 1 := min_le_right _ _
      have hψ2 : ψ ≤ (θ₂ - θ₁) / 2 := min_le_left _ _
      exact end2 (Or.inr ⟨h2K, ψ, hψ0, by linarith, interior_subset (cone_mem_interior_of_between hadd hsmul hD h1K h2K
        hθs hlo hhi ⟨by linarith, by linarith⟩)⟩)
    · rcases cone_side hadd hsmul hD h2K with hint | ⟨σ, hσ, ψ, hψ, hψπ, hK⟩
      · obtain ⟨ε, hε, ρ, hρ, h⟩ := end1 (Or.inl (by rw [heq]; exact hint))
        exact ⟨ε, hε, ρ, hρ, fun t ht φ h1 h2 hφ => h t ht φ h1 h2 (by rw [heq]; exact hφ)⟩
      · rcases hσ with rfl | rfl
        · obtain ⟨ε, hε, ρ, hρ, h⟩ := end1 (Or.inr ⟨h1K, ψ, hψ, hψπ, by rw [heq]; exact hK⟩)
          exact ⟨ε, hε, ρ, hρ, fun t ht φ h1 h2 hφ => h t ht φ h1 h2 (by rw [heq]; exact hφ)⟩
        · exact end2 (Or.inr ⟨h2K, ψ, hψ, hψπ, hK⟩)
  · intro ε hε
    by_cases hlt : θ₁ + ε ≤ θ₂ - ε
    · have hsub : e '' Icc (θ₁ + ε) (θ₂ - ε) ⊆ interior (F.allowedCone v c) := by
        rintro _ ⟨θ, hθ, rfl⟩
        exact cone_mem_interior_of_between hadd hsmul hD h1K h2K hθs hlo hhi ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
      obtain ⟨ρ, hρ, h⟩ := clear_of_subset_interior_allowedCone hF hv hc isCompact_Icc hsub
      exact ⟨ρ, hρ, fun t ht φ hφ => h φ hφ t ht.1 ht.2⟩
    · exact ⟨1, one_pos, fun t _ φ hφ => absurd (hφ.1.trans hφ.2) hlt⟩

/-- **The gap** (FS110-W-MERGE, record § 4.1): if `int D_c(v)` is non-empty and `c` has `n + 1 ≥ 2` sectors at `v`, there are two
`c`-sectors `idx s a` and `idx s b`, consecutive along the orbit (`a < b < n`, no `c`-sector strictly between), such that every
point of the gap between them near `v` (directions from germ `idx s (a + 1)` to germ `idx s b`) is clear for `c`. The gap is the
one after an excluded direction `e θs ∉ D_c(v)` (when `D_c(v)` is not the plane). -/
theorem exists_gap (hF : F.Valid) (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)
    (hn : F.HasSectors v c (n + 1)) (hD : (interior (F.allowedCone v c)).Nonempty) :
    ∃ s : Fin X.n, ∃ a b : ℕ, a < b ∧ b < X.n ∧ X.col (BranchGerms.idx s a) = c ∧
      X.col (BranchGerms.idx s b) = c ∧ (∀ m, a < m → m < b → X.col (BranchGerms.idx s m) ≠ c) ∧
      ∃ ρc > 0, ∀ t ∈ Ioo 0 ρc, ∀ φ, X.G.liftDir s (a + 1) t ≤ φ → φ ≤ X.G.liftDir s b t →
        F.IsClear c (v + (t : ℂ) * e φ) := by
  classical
  have hπ := Real.pi_pos
  have hM := X.hC.sorted.mono
  have hpos : 0 < X.n := X.pos_of_hasSectors (by omega) hn
  have hcnt : {i | X.col i = c}.encard = ((n + 1 : ℕ) : ℕ∞) := by
    obtain ⟨r, hr', hr⟩ := (hn.and (Ioc_mem_nhdsGT X.hC.pos)).exists
    rw [← hr', X.hC.encard_sectorsOf hpos hr (fun i => X.hcol i r hr) c]
  obtain ⟨i₁, i₂, hi₁, hi₂, h12⟩ : ∃ i₁ i₂, X.col i₁ = c ∧ X.col i₂ = c ∧ i₁ ≠ i₂ := by
    have : 1 < {i | X.col i = c}.encard := by
      rw [hcnt]; exact_mod_cast (show 1 < n + 1 by omega)
    exact Set.one_lt_encard_iff.mp this
  have hc : c ∈ F.coloursAt v :=
    closure_mono ((X.hcol₀ i₁).trans (by rw [hi₁])) (X.hC.mem_closure_sector X.hs₀ i₁)
  by_cases hU : F.allowedCone v c = univ
  · -- `D_c(v)` is the plane: any `c`-sector and the next one
    obtain ⟨m₂, hm₂, hm₂i⟩ := BranchGerms.exists_idx_eq i₁ i₂
    have hex : ∃ m, 0 < m ∧ m < X.n ∧ X.col (BranchGerms.idx i₁ m) = c := by
      refine ⟨m₂, Nat.pos_of_ne_zero fun h0 => h12 ?_, hm₂, by rw [hm₂i]; exact hi₂⟩
      rw [← hm₂i, h0, BranchGerms.idx_zero]
    have hb := Nat.find_spec hex
    refine ⟨i₁, 0, Nat.find hex, hb.1, by omega, by rw [BranchGerms.idx_zero]; exact hi₁, hb.2.2,
      fun m hm0 hmb => fun hcm => Nat.find_min hex hmb ⟨hm0, by omega, hcm⟩, ?_⟩
    have hsub : e '' Icc (X.G.lift i₁ (0 + 1) - 2) (X.G.lift i₁ (Nat.find hex) + 2) ⊆ interior (F.allowedCone v c) := by
      rw [hU, interior_univ]; exact subset_univ _
    obtain ⟨ρ, hρ, h⟩ := clear_of_subset_interior_allowedCone hF hv hc isCompact_Icc hsub
    refine ⟨ρ, hρ, fun t ht φ hφ1 hφ2 => h φ ⟨?_, ?_⟩ t ht.1 ht.2⟩
    · unfold BranchGerms.liftDir germDir at hφ1
      linarith [Real.neg_pi_div_two_le_arcsin (X.G.κ (BranchGerms.idx i₁ (0 + 1)) * t / 2), Real.pi_le_four]
    · unfold BranchGerms.liftDir germDir at hφ2
      linarith [Real.arcsin_le_pi_div_two (X.G.κ (BranchGerms.idx i₁ (Nat.find hex)) * t / 2), Real.pi_le_four]
  · -- an excluded direction `e θs ∉ D_c(v)`, on the closed cone of the chart sector `s`
    obtain ⟨u, hu⟩ : ∃ u, u ∉ F.allowedCone v c := by
      by_contra h; push Not at h; exact hU (eq_univ_of_forall h)
    have hu0 : u ≠ 0 := by
      rintro rfl
      obtain ⟨d₀, hd₀⟩ := hD
      have := smul_mem_allowedCone (t := 0) le_rfl (interior_subset hd₀)
      rw [ofReal_zero, zero_mul] at this
      exact hu this
    have hθs : e (arg u) ∉ F.allowedCone v c := by
      intro h
      have := smul_mem_allowedCone (norm_nonneg u) h
      rw [show ((‖u‖ : ℝ) : ℂ) * e (arg u) = u by simp [e]] at this
      exact hu this
    obtain ⟨s, θs, hθsI, hθsK⟩ : ∃ s : Fin X.n, ∃ θs, θs ∈ Icc (X.G.β s) (X.G.nextβ s) ∧ e θs ∉ F.allowedCone v c := by
      rcases X.G.exists_angle hpos (arg u) with ⟨i, m, hm⟩ | ⟨i, hi⟩
      · refine ⟨i, X.G.β i, ⟨le_rfl, hM i⟩, ?_⟩
        rwa [show e (X.G.β i) = e (arg u) by rw [e_eq_e_iff]; exact ⟨-m, by rw [hm]; push_cast; ring⟩]
      · obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp hi
        refine ⟨i, arg u - 2 * π * m, ⟨by linarith, by linarith⟩, ?_⟩
        rwa [show e (arg u - 2 * π * m) = e (arg u) by rw [e_eq_e_iff]; exact ⟨-m, by push_cast; ring⟩]
    have hcs : X.col s ≠ c := fun h => hθsK (e_mem_allowedCone_of_col hF hv h hθsI)
    obtain ⟨m₁, hm₁, hm₁i⟩ := BranchGerms.exists_idx_eq s i₁
    obtain ⟨m₂, hm₂, hm₂i⟩ := BranchGerms.exists_idx_eq s i₂
    have hexa : ∃ m, m < X.n ∧ X.col (BranchGerms.idx s m) = c := ⟨m₁, hm₁, by rw [hm₁i]; exact hi₁⟩
    set a := Nat.find hexa with ha
    have hav := Nat.find_spec hexa
    have ha0 : a ≠ 0 := fun h0 => hcs (by rw [← BranchGerms.idx_zero s, ← h0]; exact hav.2)
    have ham₁ : a ≤ m₁ := Nat.find_min' hexa ⟨hm₁, by rw [hm₁i]; exact hi₁⟩
    have ham₂ : a ≤ m₂ := Nat.find_min' hexa ⟨hm₂, by rw [hm₂i]; exact hi₂⟩
    have hm12 : m₁ ≠ m₂ := fun h => h12 (by rw [← hm₁i, ← hm₂i, h])
    have hexb : ∃ m, a < m ∧ m < X.n ∧ X.col (BranchGerms.idx s m) = c := by
      rcases lt_or_eq_of_le ham₁ with h1 | h1
      · exact ⟨m₁, h1, hm₁, by rw [hm₁i]; exact hi₁⟩
      · exact ⟨m₂, by omega, hm₂, by rw [hm₂i]; exact hi₂⟩
    set b := Nat.find hexb with hb
    have hbv := Nat.find_spec hexb
    refine ⟨s, a, b, hbv.1, by omega, hav.2, hbv.2.2,
      fun m ham hmb hcm => Nat.find_min hexb hmb ⟨ham, by omega, hcm⟩, ?_⟩
    -- the excluded direction lies below the gap, and one turn above it
    have hlift1 : X.G.lift s 1 = X.G.nextβ s := by
      rw [X.G.lift_succ', BranchGerms.idx_zero, BranchGerms.turns_zero]; simp
    have hlo' : θs ≤ X.G.lift s (a + 1) :=
      hθsI.2.trans (hlift1 ▸ X.G.lift_mono hM s (by omega))
    have hhi' : X.G.lift s b ≤ θs + 2 * π := by
      have h1 : X.G.lift s b ≤ X.G.lift s (0 + X.n) := X.G.lift_mono hM s (by omega)
      rw [X.G.lift_add_n, X.G.lift_zero] at h1
      linarith [hθsI.1]
    have h1K : e (X.G.lift s (a + 1)) ∈ F.allowedCone v c := by
      rw [X.G.lift_succ', show e (X.G.nextβ (BranchGerms.idx s a) + 2 * π * (BranchGerms.turns s a : ℝ)) =
        e (X.G.nextβ (BranchGerms.idx s a)) by rw [e_eq_e_iff]; exact ⟨(BranchGerms.turns s a : ℤ), by push_cast; ring⟩]
      exact e_mem_allowedCone_of_col hF hv hav.2 ⟨hM _, le_rfl⟩
    have h2K : e (X.G.lift s b) ∈ F.allowedCone v c := by
      rw [X.G.e_lift]; exact e_mem_allowedCone_of_col hF hv hbv.2.2 ⟨le_rfl, hM _⟩
    have hlo : θs < X.G.lift s (a + 1) := lt_of_le_of_ne hlo' fun h => hθsK (h ▸ h1K)
    have hhi : X.G.lift s b < θs + 2 * π :=
      lt_of_le_of_ne hhi' fun h => hθsK (by rw [← e_add_two_pi, ← h]; exact h2K)
    exact X.gap_clear hF hv hc hD hbv.1 hav.2 hbv.2.2 hθsK hlo hhi

end Near

end ArcMap

end HadwigerNelson.Plane

/-! ## FS131-IMM3: MERGE's map — definitions, the new arcs, the colouring and its local constancy (record § 5.2) -/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## MERGE's map: the gap, the new arcs, the colouring (record § 5.2) -/

namespace BranchGerms

variable {n : ℕ} (G : BranchGerms n)

/-- The germ indices of the gap after `idx s a`: `idx s m` for `a < m ≤ b`. -/
def gapGerm (s : Fin n) (a b : ℕ) : Set (Fin n) := {j | ∃ m, a < m ∧ m ≤ b ∧ idx s m = j}

/-- The sector indices of the gap after `idx s a`: `idx s m` for `a < m < b`. -/
def gapSec (s : Fin n) (a b : ℕ) : Set (Fin n) := {i | ∃ m, a < m ∧ m < b ∧ idx s m = i}

/-- Germ `j`'s branch out to `r`, without `v`. -/
def branch (v : ℂ) (r : ℝ) (j : Fin n) : Set ℂ := branchPt v (G.β j) (G.κ j) '' Ioo 0 r

/-- **The gap out to `r`**: its sectors and its germs' branches. -/
def gapSet (v : ℂ) (s : Fin n) (a b : ℕ) (r : ℝ) : Set ℂ :=
  (⋃ i ∈ gapSec s a b, G.sector v r i) ∪ ⋃ j ∈ gapGerm s a b, G.branch v r j

/-- A germ is **phantom** (for the sector colours `col`) when the sectors on its two sides have one colour. -/
def Phantom {k : ℕ} (col : Fin n → Fin k) (j : Fin n) : Prop := ∃ i, next i = j ∧ col i = col j

/-- **MERGE's colouring** at the radius `ρ`: `c` on the gap out to `ρ/2`; on a germ's branch out to `ρ`, the colour of the sector
after the germ; `Fcol` elsewhere. -/
noncomputable def mergeCol {k : ℕ} (v : ℂ) (col : Fin n → Fin k) (Fcol : ℂ → Fin k) (s : Fin n) (a b : ℕ) (c : Fin k)
    (ρ : ℝ) : ℂ → Fin k := fun z => by
  classical
  exact if z ∈ G.gapSet v s a b (ρ / 2) then c else if h : ∃ j, z ∈ G.branch v ρ j then col h.choose else Fcol z

/-- **The rim arc** at `ρ/2` across the gap, from germ `idx s (a + 1)` to germ `idx s b`. -/
noncomputable def rimArc (v : ℂ) (s : Fin n) (a b : ℕ) (ρ : ℝ) : Arc :=
  .circ v (ρ / 2) (G.liftDir s (a + 1) (ρ / 2)) (G.liftDir s b (ρ / 2))

/-- **MERGE's new arcs** at the radius `ρ`: the germs off the gap out to `ρ/2`; the non-phantom germs' pieces between `ρ/2` and `ρ`;
and the rim arc at `ρ/2` across the gap when the gap has a sector. No arc on `∂B(v, ρ)`. -/
noncomputable def mergeArcs {k : ℕ} (v : ℂ) (col : Fin n → Fin k) (s : Fin n) (a b : ℕ) (ρ : ℝ) : Set Arc :=
  (fun j => germArc v (G.β j) (G.κ j) (ρ / 2)) '' (gapGerm s a b)ᶜ ∪
    (⋃ j ∈ {j | ¬ Phantom col j}, (germArc v (G.β j) (G.κ j) ρ).outer v (ρ / 2)) ∪
    {A | a + 1 < b ∧ A = G.rimArc v s a b ρ}

theorem mem_gapGerm {s : Fin n} {a b : ℕ} {j : Fin n} : j ∈ gapGerm s a b ↔ ∃ m, a < m ∧ m ≤ b ∧ idx s m = j := Iff.rfl

theorem mem_gapSec {s : Fin n} {a b : ℕ} {i : Fin n} : i ∈ gapSec s a b ↔ ∃ m, a < m ∧ m < b ∧ idx s m = i := Iff.rfl

/-- **Every index is on the orbit once in `[a, a + n)`** (for `a < n`). -/
theorem exists_rep (s : Fin n) {a : ℕ} (ha : a < n) (i : Fin n) : ∃ m, a ≤ m ∧ m < a + n ∧ idx s m = i := by
  obtain ⟨m₀, hm₀, h⟩ := exists_idx_eq s i
  rcases le_or_gt a m₀ with h1 | h1
  · exact ⟨m₀, h1, by omega, h⟩
  · exact ⟨m₀ + n, by omega, by omega, by rw [idx_add_n, h]⟩

/-- The orbit is injective on `[a, a + n)`. -/
theorem idx_inj {s : Fin n} {a m m' : ℕ} (h1 : a ≤ m) (h2 : m < a + n) (h3 : a ≤ m') (h4 : m' < a + n)
    (he : idx s m = idx s m') : m = m' := by
  rcases lt_trichotomy m m' with h | h | h
  · exact absurd he (idx_ne h (by omega))
  · exact h
  · exact absurd he.symm (idx_ne h (by omega))

/-- An index on the orbit at `m ∈ [a, a + n)` is a gap germ exactly when `a < m ≤ b` (for `b < a + n`). -/
theorem idx_mem_gapGerm_iff {s : Fin n} {a b m : ℕ} (hb : b < a + n) (h1 : a ≤ m) (h2 : m < a + n) :
    idx s m ∈ gapGerm s a b ↔ a < m ∧ m ≤ b := by
  constructor
  · rintro ⟨m', hm'1, hm'2, he⟩
    have := idx_inj (by omega) (by omega) h1 h2 he
    omega
  · rintro ⟨h3, h4⟩; exact ⟨m, h3, h4, rfl⟩

/-- An index on the orbit at `m ∈ [a, a + n)` is a gap sector exactly when `a < m < b` (for `b < a + n`). -/
theorem idx_mem_gapSec_iff {s : Fin n} {a b m : ℕ} (hb : b < a + n) (h1 : a ≤ m) (h2 : m < a + n) :
    idx s m ∈ gapSec s a b ↔ a < m ∧ m < b := by
  constructor
  · rintro ⟨m', hm'1, hm'2, he⟩
    have := idx_inj (by omega) (by omega) h1 h2 he
    omega
  · rintro ⟨h3, h4⟩; exact ⟨m, h3, h4, rfl⟩

/-- The germ after sector `idx s m` is phantom exactly when the two sectors beside it have one colour. -/
theorem phantom_idx_succ_iff {k : ℕ} {col : Fin n → Fin k} {s : Fin n} {m : ℕ} :
    Phantom col (idx s (m + 1)) ↔ col (idx s m) = col (idx s (m + 1)) := by
  constructor
  · rintro ⟨i, hi, hc⟩
    rw [← next_idx] at hi
    rw [← next_injective hi]; exact hc
  · intro h; exact ⟨idx s m, next_idx s m, h⟩

end BranchGerms

-- spec examples for MERGE's definitions
example : (⟨1, by omega⟩ : Fin 3) ∈ BranchGerms.gapGerm (⟨0, by omega⟩ : Fin 3) 0 1 :=
  ⟨1, by omega, le_rfl, rfl⟩
example : (⟨0, by omega⟩ : Fin 3) ∉ BranchGerms.gapGerm (⟨0, by omega⟩ : Fin 3) 0 2 := by
  rintro ⟨m, h1, h2, he⟩
  interval_cases m <;> simp [BranchGerms.idx, Fin.ext_iff] at he
example : (⟨1, by omega⟩ : Fin 3) ∈ BranchGerms.gapSec (⟨0, by omega⟩ : Fin 3) 0 2 := ⟨1, by omega, by omega, rfl⟩
example : (⟨1, by omega⟩ : Fin 3) ∉ BranchGerms.gapSec (⟨0, by omega⟩ : Fin 3) 0 1 := by
  rintro ⟨m, h1, h2, -⟩; omega
example (G : BranchGerms 3) (v : ℂ) (r : ℝ) (j : Fin 3) : G.branch v r j = branchPt v (G.β j) (G.κ j) '' Ioo 0 r := rfl
example (G : BranchGerms 3) (v : ℂ) (r : ℝ) (s : Fin 3) :
    G.gapSet v s 0 2 r = (⋃ i ∈ BranchGerms.gapSec s 0 2, G.sector v r i) ∪ ⋃ j ∈ BranchGerms.gapGerm s 0 2, G.branch v r j := rfl
example : BranchGerms.Phantom (n := 2) (k := 2) (fun _ => 0) ⟨1, by omega⟩ := ⟨⟨0, by omega⟩, rfl, rfl⟩
example : ¬ BranchGerms.Phantom (n := 2) (k := 2) (fun i => ⟨i.val, i.isLt⟩) ⟨1, by omega⟩ := by
  rintro ⟨i, hi, hc⟩
  have : i.val = 1 := by simpa [Fin.ext_iff] using hc
  have h0 : BranchGerms.next i = ⟨0, by omega⟩ := by
    unfold BranchGerms.next; rw [dif_neg (by omega)]
  rw [h0] at hi; exact absurd hi (by simp)
example (G : BranchGerms 3) (v : ℂ) (col : Fin 3 → Fin 2) (Fcol : ℂ → Fin 2) (s : Fin 3) (c : Fin 2) (ρ : ℝ) (z : ℂ)
    (hz : z ∈ G.gapSet v s 0 2 (ρ / 2)) : G.mergeCol v col Fcol s 0 2 c ρ z = c := by
  simp [BranchGerms.mergeCol, hz]
example (G : BranchGerms 3) (v : ℂ) (col : Fin 3 → Fin 2) (Fcol : ℂ → Fin 2) (s : Fin 3) (c : Fin 2) (ρ : ℝ) (z : ℂ)
    (hz : z ∉ G.gapSet v s 0 2 (ρ / 2)) (hb : ∀ j, z ∉ G.branch v ρ j) : G.mergeCol v col Fcol s 0 2 c ρ z = Fcol z := by
  simp [BranchGerms.mergeCol, hz, hb]
example (G : BranchGerms 3) (v : ℂ) (s : Fin 3) (ρ : ℝ) :
    G.rimArc v s 0 2 ρ = .circ v (ρ / 2) (G.liftDir s 1 (ρ / 2)) (G.liftDir s 2 (ρ / 2)) := rfl
example (G : BranchGerms 3) (v : ℂ) (col : Fin 3 → Fin 2) (s : Fin 3) (ρ : ℝ) :
    G.rimArc v s 0 2 ρ ∈ G.mergeArcs v col s 0 2 ρ := Or.inr ⟨by omega, rfl⟩
example (G : BranchGerms 3) (v : ℂ) (col : Fin 3 → Fin 2) (s : Fin 3) (ρ : ℝ) :
    G.rimArc v s 0 1 ρ ∉ G.mergeArcs v col s 0 1 ρ ∨
      G.rimArc v s 0 1 ρ ∈ (fun j => germArc v (G.β j) (G.κ j) (ρ / 2)) '' (BranchGerms.gapGerm s 0 1)ᶜ ∪
        (⋃ j ∈ {j | ¬ BranchGerms.Phantom col j}, (germArc v (G.β j) (G.κ j) ρ).outer v (ρ / 2)) := by
  by_cases h : G.rimArc v s 0 1 ρ ∈ G.mergeArcs v col s 0 1 ρ
  · rcases h with h | ⟨h, -⟩
    · exact Or.inr h
    · omega
  · exact Or.inl h

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ} {X : F.Near v}

/-- Half a small radius is small. -/
theorem Small.half {ρ : ℝ} (h : X.Small ρ) : X.Small (ρ / 2) :=
  ⟨by linarith [h.1], by linarith [h.1, h.2.1], by linarith [h.1, h.2.2.1], by linarith [h.1, h.2.2.2]⟩

/-- A smaller positive radius is small. -/
theorem Small.mono {ρ ρ' : ℝ} (h : X.Small ρ) (h0 : 0 < ρ') (hle : ρ' ≤ ρ) : X.Small ρ' :=
  ⟨h0, hle.trans_lt h.2.1, hle.trans_lt h.2.2.1, hle.trans_lt h.2.2.2⟩

/-- A branch point is at its distance from `v`. -/
theorem dist_branchPt (j : Fin X.n) {t : ℝ} (ht : 0 ≤ t) : dist (branchPt v (X.G.β j) (X.G.κ j) t) v = t := by
  rw [dist_eq_norm, norm_branchPt_sub v _ _ ht]

/-- The outer pieces of germ `j`'s arc out to `ρ`, outside `B(v, ρ/2)`, lie on its branch between `ρ/2` and `ρ`. -/
theorem outer_subset {ρ : ℝ} (h : X.Small ρ) (j : Fin X.n) :
    ∀ A ∈ (X.germ ρ j).outer v (ρ / 2), A.carrier ⊆ branchPt v (X.G.β j) (X.G.κ j) '' Icc (ρ / 2) ρ := by
  have hv : v ∈ (X.germ ρ j).carrier := by rw [carrier_germ h]; exact ⟨0, ⟨le_rfl, h.1.le⟩, by simp [branchPt]⟩
  obtain ⟨h1, -⟩ := Arc.outer_spec (germArc_nondegenerate v _ _ h.1) hv (by linarith [h.1] : (0 : ℝ) < ρ / 2)
  intro A hA z hz
  obtain ⟨-, hsub, hd⟩ := h1 A hA
  have hz' : z ∈ (X.germ ρ j).carrier := hsub hz
  rw [carrier_germ h] at hz'
  obtain ⟨t, ht, rfl⟩ := hz'
  refine ⟨t, ⟨?_, ht.2⟩, rfl⟩
  have := hd _ hz
  rwa [dist_branchPt j ht.1] at this

/-- A point of germ `j`'s branch between `ρ/2` (excluded) and `ρ` lies on an outer piece. -/
theorem mem_outer {ρ : ℝ} (h : X.Small ρ) (j : Fin X.n) {t : ℝ} (ht : t ∈ Ioc (ρ / 2) ρ) :
    branchPt v (X.G.β j) (X.G.κ j) t ∈ ⋃ A ∈ (X.germ ρ j).outer v (ρ / 2), A.carrier := by
  have hv : v ∈ (X.germ ρ j).carrier := by rw [carrier_germ h]; exact ⟨0, ⟨le_rfl, h.1.le⟩, by simp [branchPt]⟩
  obtain ⟨-, h2⟩ := Arc.outer_spec (germArc_nondegenerate v _ _ h.1) hv (by linarith [h.1] : (0 : ℝ) < ρ / 2)
  have ht0 : 0 ≤ t := by linarith [ht.1, h.1]
  refine h2 ⟨?_, ?_⟩
  · show _ ∈ (X.germ ρ j).carrier
    rw [carrier_germ h]; exact ⟨t, ⟨ht0, ht.2⟩, rfl⟩
  · rw [mem_closedBall, dist_branchPt j ht0, not_le]; exact ht.1

/-- A sector point is at a distance in `(0, r)` from `v`. -/
theorem norm_of_mem_sector {r : ℝ} {i : Fin X.n} {z : ℂ} (hz : z ∈ X.G.sector v r i) : ‖z - v‖ ∈ Ioo 0 r := by
  obtain ⟨t, ht, φ, -, rfl⟩ := hz
  rw [add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg ht.1.le]; exact ht

/-- A sector point inside a smaller radius is in the smaller sector. -/
theorem mem_sector_of_lt {r r' : ℝ} {i : Fin X.n} {z : ℂ} (hz : z ∈ X.G.sector v r i) (hr' : ‖z - v‖ < r') :
    z ∈ X.G.sector v r' i := by
  obtain ⟨t, ht, φ, hφ, rfl⟩ := hz
  have : ‖v + (t : ℂ) * e φ - v‖ = t := by
    rw [add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg ht.1.le]
  exact ⟨t, ⟨ht.1, this ▸ hr'⟩, φ, hφ, rfl⟩

/-- Sectors are monotone in the radius. -/
theorem sector_mono {r r' : ℝ} (hr : r ≤ r') (i : Fin X.n) : X.G.sector v r i ⊆ X.G.sector v r' i := fun _ hz =>
  mem_sector_of_lt hz ((norm_of_mem_sector hz).2.trans_le hr)

/-- A sector point of a small radius is interior to `F`. -/
theorem sector_subset_interiorPts {ρ : ℝ} (h : X.Small ρ) (i : Fin X.n) : X.G.sector v ρ i ⊆ F.interiorPts :=
  fun _ hz => (X.hcol i ρ h.mem_Ioc hz).1

/-- A sector point of a small radius is on no branch. -/
theorem not_mem_branch_of_mem_sector {ρ r : ℝ} (h : X.Small ρ) {i : Fin X.n} {z : ℂ} (hz : z ∈ X.G.sector v ρ i)
    (j : Fin X.n) : z ∉ X.G.branch v r j := by
  rintro ⟨t, ht, rfl⟩
  have hI := sector_subset_interiorPts h i hz
  have ht' := norm_of_mem_sector hz
  rw [norm_branchPt_sub v _ _ ht.1.le] at ht'
  exact hI.2 (X.hC.branchPt_mem_Γ j ⟨ht.1, ht'.2.trans h.lt_r₀⟩).2

/-- Two sectors of a small radius are disjoint. -/
theorem sector_disjoint {ρ : ℝ} (h : X.Small ρ) {i i' : Fin X.n} {z : ℂ} (hz : z ∈ X.G.sector v ρ i)
    (hz' : z ∈ X.G.sector v ρ i') : i = i' := by
  by_contra hne
  exact disjoint_left.mp (X.hC.disjoint ρ h.mem_Ioc i i' hne) hz hz'

/-- A branch point of a small radius is on its own branch only. -/
theorem eq_of_mem_branch {ρ : ℝ} (h : X.Small ρ) {j j' : Fin X.n} {t r : ℝ} (ht : t ∈ Ioo 0 ρ)
    (hz : branchPt v (X.G.β j) (X.G.κ j) t ∈ X.G.branch v r j') : j' = j := by
  obtain ⟨t', ht', he⟩ := hz
  have := congrArg (fun z => ‖z - v‖) he
  simp only [norm_branchPt_sub v _ _ ht'.1.le, norm_branchPt_sub v _ _ ht.1.le] at this
  subst this
  exact eq_of_branchPt_eq X.hdisj ⟨ht.1, ht.2.trans h.2.1⟩ he

/-- A branch point of a small radius is in no sector. -/
theorem branchPt_not_mem_sector {ρ : ℝ} (h : X.Small ρ) (j : Fin X.n) {t : ℝ} (ht : t ∈ Ioo 0 ρ) (i : Fin X.n) :
    branchPt v (X.G.β j) (X.G.κ j) t ∉ X.G.sector v ρ i := fun hz =>
  not_mem_branch_of_mem_sector h hz j ⟨t, ⟨ht.1, ht.2⟩, rfl⟩

variable {s : Fin X.n} {a b : ℕ}

/-- **A sector point in the gap set**: exactly when the sector is a gap sector and the point is inside `ρ'`. -/
theorem mem_gapSet_of_mem_sector {ρ ρ' : ℝ} (h : X.Small ρ) (hρ' : ρ' ≤ ρ) {i : Fin X.n} {z : ℂ}
    (hz : z ∈ X.G.sector v ρ i) : z ∈ X.G.gapSet v s a b ρ' ↔ i ∈ BranchGerms.gapSec s a b ∧ ‖z - v‖ < ρ' := by
  constructor
  · rintro (h1 | h1)
    · obtain ⟨i', hi', hz'⟩ := mem_iUnion₂.mp h1
      have := sector_disjoint h hz (sector_mono hρ' i' hz')
      subst this; exact ⟨hi', (norm_of_mem_sector hz').2⟩
    · obtain ⟨j, -, hz'⟩ := mem_iUnion₂.mp h1
      exact absurd hz' (not_mem_branch_of_mem_sector h hz j)
  · rintro ⟨hi, hr⟩
    exact Or.inl (mem_iUnion₂.mpr ⟨i, hi, mem_sector_of_lt hz hr⟩)

/-- **A branch point in the gap set**: exactly when its germ is a gap germ and it is inside `ρ'`. -/
theorem branchPt_mem_gapSet_iff {ρ ρ' : ℝ} (h : X.Small ρ) (hρ' : ρ' ≤ ρ) (j : Fin X.n) {t : ℝ} (ht : t ∈ Ioo 0 ρ) :
    branchPt v (X.G.β j) (X.G.κ j) t ∈ X.G.gapSet v s a b ρ' ↔ j ∈ BranchGerms.gapGerm s a b ∧ t < ρ' := by
  constructor
  · rintro (h1 | h1)
    · obtain ⟨i', -, hz'⟩ := mem_iUnion₂.mp h1
      exact absurd (sector_mono hρ' i' hz') (branchPt_not_mem_sector h j ht i')
    · obtain ⟨j', hj', hz'⟩ := mem_iUnion₂.mp h1
      have := eq_of_mem_branch h ht hz'
      subst this
      obtain ⟨t', ht', he⟩ := hz'
      have := congrArg (fun z => ‖z - v‖) he
      simp only [norm_branchPt_sub v _ _ ht'.1.le, norm_branchPt_sub v _ _ ht.1.le] at this
      exact ⟨hj', this ▸ ht'.2⟩
  · rintro ⟨hj, hr⟩
    exact Or.inr (mem_iUnion₂.mpr ⟨j, hj, t, ⟨ht.1, hr⟩, rfl⟩)

open Classical in
/-- **MERGE's colour of a sector point** (inside a small `ρ`): `c` on the gap sectors inside `ρ/2`, the sector's colour otherwise. -/
theorem mergeCol_of_mem_sector {ρ : ℝ} (h : X.Small ρ) {c : Fin k} {i : Fin X.n} {z : ℂ} (hz : z ∈ X.G.sector v ρ i) :
    X.G.mergeCol v X.col F.col s a b c ρ z =
      if i ∈ BranchGerms.gapSec s a b ∧ ‖z - v‖ < ρ / 2 then c else X.col i := by
  classical
  unfold BranchGerms.mergeCol
  rw [mem_gapSet_of_mem_sector h (by linarith [h.1]) hz]
  split_ifs with h1 h2
  · rfl
  · obtain ⟨j, hj⟩ := h2; exact absurd hj (not_mem_branch_of_mem_sector h hz j)
  · have := (X.hcol i ρ h.mem_Ioc hz).2
    simpa using this

open Classical in
/-- **MERGE's colour of a branch point** (inside a small `ρ`): `c` on the gap germs inside `ρ/2`, the colour of the sector after
the germ otherwise. -/
theorem mergeCol_branchPt {ρ : ℝ} (h : X.Small ρ) {c : Fin k} (j : Fin X.n) {t : ℝ} (ht : t ∈ Ioo 0 ρ) :
    X.G.mergeCol v X.col F.col s a b c ρ (branchPt v (X.G.β j) (X.G.κ j) t) =
      if j ∈ BranchGerms.gapGerm s a b ∧ t < ρ / 2 then c else X.col j := by
  classical
  unfold BranchGerms.mergeCol
  rw [branchPt_mem_gapSet_iff h (by linarith [h.1]) j ht]
  split_ifs with h1 h2
  · rfl
  · rw [eq_of_mem_branch h ht h2.choose_spec]
  · exact absurd ⟨j, t, ht, rfl⟩ h2

/-- **MERGE's colour off the small ball** is `F`'s. -/
theorem mergeCol_of_not_mem {ρ : ℝ} (h : X.Small ρ) {c : Fin k} {z : ℂ} (hz : z ∉ ball v ρ) :
    X.G.mergeCol v X.col F.col s a b c ρ z = F.col z := by
  classical
  have h1 : z ∉ X.G.gapSet v s a b (ρ / 2) := by
    rintro (h1 | h1)
    · obtain ⟨i, -, hz'⟩ := mem_iUnion₂.mp h1
      exact hz (mem_ball.mpr (by rw [dist_eq_norm]; linarith [(norm_of_mem_sector hz').2, h.1]))
    · obtain ⟨j, -, hz'⟩ := mem_iUnion₂.mp h1
      exact hz (ball_subset_ball (by linarith [h.1]) (cutSet_subset_ball (X := X) hz'))
  unfold BranchGerms.mergeCol
  rw [if_neg h1, dif_neg (fun ⟨j, hj⟩ => hz (cutSet_subset_ball (X := X) hj))]

end Near

end ArcMap

namespace BranchGerms

variable {n : ℕ} (G : BranchGerms n)

/-- **A full turn** adds `2π` to the lifted direction. -/
theorem liftDir_add_n (s : Fin n) (m : ℕ) (t : ℝ) : G.liftDir s (m + n) t = G.liftDir s m t + 2 * π := by
  unfold liftDir germDir; rw [lift_add_n, idx_add_n]; ring

end BranchGerms

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ} {X : F.Near v} {s : Fin X.n} {a b : ℕ}

/-- The rim arc's carrier: the circle of radius `ρ/2` between the lifted directions of the gap's end germs. -/
theorem carrier_rimArc (ρ : ℝ) :
    (X.G.rimArc v s a b ρ).carrier = (fun θ : ℝ => v + ((ρ / 2 : ℝ) : ℂ) * e θ) ''
      Icc (X.G.liftDir s (a + 1) (ρ / 2)) (X.G.liftDir s b (ρ / 2)) := rfl

/-- The rim arc is non-degenerate when the gap has a sector. -/
theorem rimArc_nondegenerate {ρ : ℝ} (h : X.Small ρ) (hab : a + 1 < b) (hbn : b < X.n) :
    (X.G.rimArc v s a b ρ).Nondegenerate := by
  have ht : ρ / 2 ∈ Ioo 0 X.s₀ := ⟨by linarith [h.1], by linarith [h.1, h.2.1]⟩
  refine ⟨by linarith [h.1], X.G.liftDir_mono X.hord s ht hab, ?_⟩
  have := (X.G.liftDir_mono X.hord s ht).monotone (show b ≤ a + 1 + X.n by omega)
  rw [X.G.liftDir_add_n] at this; exact this

/-- **Membership in MERGE's new arcs.** -/
theorem mem_mergeArcs {ρ : ℝ} {A : Arc} :
    A ∈ X.G.mergeArcs v X.col s a b ρ ↔ (∃ j ∉ BranchGerms.gapGerm s a b, A = X.germ (ρ / 2) j) ∨
      (∃ j, ¬ BranchGerms.Phantom X.col j ∧ A ∈ (X.germ ρ j).outer v (ρ / 2)) ∨ (a + 1 < b ∧ A = X.G.rimArc v s a b ρ) := by
  unfold BranchGerms.mergeArcs
  simp only [mem_union, mem_image, mem_iUnion₂, mem_setOf_eq, mem_compl_iff]
  constructor
  · rintro ((⟨j, hj, rfl⟩ | ⟨j, hj, hA⟩) | hA)
    · exact Or.inl ⟨j, hj, rfl⟩
    · exact Or.inr (Or.inl ⟨j, hj, hA⟩)
    · exact Or.inr (Or.inr hA)
  · rintro (⟨j, hj, rfl⟩ | ⟨j, hj, hA⟩ | hA)
    · exact Or.inl (Or.inl ⟨j, hj, rfl⟩)
    · exact Or.inl (Or.inr ⟨j, hj, hA⟩)
    · exact Or.inr hA

/-- A germ's arc out to `ρ/2` lies on its arc out to `ρ`. -/
theorem germ_half_subset {ρ : ℝ} (h : X.Small ρ) (j : Fin X.n) : (X.germ (ρ / 2) j).carrier ⊆ (X.germ ρ j).carrier := by
  rw [carrier_germ h.half, carrier_germ h]
  exact image_mono (Icc_subset_Icc le_rfl (by linarith [h.1]))

/-- An outer piece lies on its germ's arc. -/
theorem outer_subset_germ {ρ : ℝ} (h : X.Small ρ) (j : Fin X.n) {A : Arc} (hA : A ∈ (X.germ ρ j).outer v (ρ / 2)) :
    A.carrier ⊆ (X.germ ρ j).carrier := by
  intro z hz
  obtain ⟨t, ht, rfl⟩ := outer_subset h j A hA hz
  rw [carrier_germ h]; exact ⟨t, ⟨by linarith [ht.1, h.1], ht.2⟩, rfl⟩

/-- **The new arcs other than the rim arc lie on germ arcs out to `ρ`.** -/
theorem mergeArcs_cases {ρ : ℝ} (h : X.Small ρ) {A : Arc} (hA : A ∈ X.G.mergeArcs v X.col s a b ρ) :
    (∃ j, A.carrier ⊆ (X.germ ρ j).carrier) ∨ (a + 1 < b ∧ A = X.G.rimArc v s a b ρ) := by
  rcases mem_mergeArcs.mp hA with ⟨j, -, rfl⟩ | ⟨j, -, hA'⟩ | hA'
  · exact Or.inl ⟨j, germ_half_subset h j⟩
  · exact Or.inl ⟨j, outer_subset_germ h j hA'⟩
  · exact Or.inr hA'

theorem germ_subset_closedBall {ρ : ℝ} (h : X.Small ρ) (j : Fin X.n) : (X.germ ρ j).carrier ⊆ closedBall v ρ := by
  rw [carrier_germ h]
  rintro z ⟨t, ht, rfl⟩
  rw [mem_closedBall, dist_branchPt j ht.1]; exact ht.2

/-- MERGE's new arcs are non-degenerate. -/
theorem mergeArcs_nondegenerate {ρ : ℝ} (h : X.Small ρ) (hbn : b < X.n) :
    ∀ A ∈ X.G.mergeArcs v X.col s a b ρ, A.Nondegenerate := by
  intro A hA
  rcases mem_mergeArcs.mp hA with ⟨j, -, rfl⟩ | ⟨j, -, hA'⟩ | ⟨hab, rfl⟩
  · exact germArc_nondegenerate v _ _ h.half.1
  · have hv : v ∈ (X.germ ρ j).carrier := by rw [carrier_germ h]; exact ⟨0, ⟨le_rfl, h.1.le⟩, by simp [branchPt]⟩
    exact ((Arc.outer_spec (germArc_nondegenerate v _ _ h.1) hv h.half.1).1 A hA').1
  · exact rimArc_nondegenerate h hab hbn

/-- MERGE's new arcs are finitely many. -/
theorem mergeArcs_finite (ρ : ℝ) : (X.G.mergeArcs v X.col s a b ρ).Finite := by
  unfold BranchGerms.mergeArcs
  refine (((Set.toFinite _).image _).union ((Set.toFinite _).biUnion fun j _ => Arc.finite_outer _ _ _)).union ?_
  exact (finite_singleton (X.G.rimArc v s a b ρ)).subset fun A hA => hA.2

/-- MERGE's new arcs lie in the closed ball. -/
theorem mergeArcs_subset_closedBall {ρ : ℝ} (h : X.Small ρ) :
    ∀ A ∈ X.G.mergeArcs v X.col s a b ρ, A.carrier ⊆ closedBall v ρ := by
  intro A hA
  rcases mergeArcs_cases h hA with ⟨j, hj⟩ | ⟨-, rfl⟩
  · exact hj.trans (germ_subset_closedBall h j)
  · rintro z ⟨θ, -, rfl⟩
    rw [mem_closedBall, dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real,
      Real.norm_of_nonneg (by linarith [h.1])]
    linarith [h.1]

/-- MERGE's new unit arcs lie in `F`'s `Γ`. -/
theorem mergeArcs_unit {ρ : ℝ} (h : X.Small ρ) :
    ∀ A ∈ X.G.mergeArcs v X.col s a b ρ, A.IsUnitArc → A.carrier ∩ F.dom ⊆ F.Γ := by
  intro A hA hu
  rcases mergeArcs_cases h hA with ⟨j, hj⟩ | ⟨-, rfl⟩
  · exact fun z hz => germ_subset_Γ h j (hj hz.1)
  · exact absurd hu (by show ρ / 2 ≠ 1; linarith [h.2.2.2])

/-- Under Condition 5, each of MERGE's new arcs meets each unit circle in the domain finitely often. -/
theorem mergeArcs_condition5 {ρ : ℝ} (h : X.Small ρ) (hbn : b < X.n) :
    F.Condition5 → ∀ A ∈ X.G.mergeArcs v X.col s a b ρ, ∀ p, (A.carrier ∩ F.dom ∩ sphere p 1).Finite := by
  intro h5 A hA p
  rcases mergeArcs_cases h hA with ⟨j, hj⟩ | ⟨hab, rfl⟩
  · refine (finite_inter_sphere_of_subset_Γ X.hG h5 (C := A.carrier) (fun z hz => ⟨germ_subset_Γ h j (hj hz), ?_⟩) p).subset
      fun z hz => ⟨hz.1.1, hz.2⟩
    exact closedBall_subset_ball h.2.2.1 (germ_subset_closedBall h j (hj hz))
  · rcases Arc.finite_inter_sphere_or_eq_circ _ (rimArc_nondegenerate h hab hbn) p with hf | ⟨θ₀, θ₁, heq⟩
    · exact hf.subset fun z hz => ⟨hz.1.1, hz.2⟩
    · simp only [BranchGerms.rimArc, Arc.circ.injEq] at heq; linarith [h.2.2.2, heq.2.1]

end Near

end ArcMap

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ} {X : F.Near v} {s : Fin X.n} {a b : ℕ}

/-- Every germ is the next of one. -/
theorem exists_next_eq (j : Fin X.n) : ∃ p, BranchGerms.next p = j :=
  Finite.injective_iff_surjective.mp BranchGerms.next_injective j

/-- **A point of the punctured small ball** is in a sector or on a branch. -/
theorem ball_cases {ρ : ℝ} (h : X.Small ρ) (hn : 0 < X.n) {z : ℂ} (hz : z ∈ ball v ρ) (hzv : z ≠ v) :
    (∃ i, z ∈ X.G.sector v ρ i) ∨ ∃ j, ∃ t ∈ Ioo 0 ρ, z = branchPt v (X.G.β j) (X.G.κ j) t := by
  have ht : ‖z - v‖ ∈ Ioo 0 ρ := ⟨norm_pos_iff.mpr (sub_ne_zero.mpr hzv), by rw [← dist_eq_norm]; exact hz⟩
  by_cases hI : z ∈ F.interiorPts
  · left
    have : z ∈ ball v ρ ∩ F.interiorPts := ⟨hz, hI⟩
    rw [X.hC.cover ρ h.mem_Ioc hn] at this
    exact mem_iUnion.mp this
  · right
    obtain ⟨j, hj⟩ := X.hC.exists_branchPt_eq hzv (ball_subset_ball h.lt_r₀.le hz) hI
    exact ⟨j, ‖z - v‖, ht, hj⟩

/-- (M1) `v` lies on the new arcs (a germ off the gap is kept). -/
theorem v_mem_mergeArcs {ρ : ℝ} (h : X.Small ρ) (hab : a < b) (hbn : b < X.n) :
    v ∈ ⋃ A ∈ X.G.mergeArcs v X.col s a b ρ, A.carrier := by
  refine mem_iUnion₂.mpr ⟨X.germ (ρ / 2) (BranchGerms.idx s a), mem_mergeArcs.mpr (Or.inl ⟨_, ?_, rfl⟩), ?_⟩
  · rw [BranchGerms.idx_mem_gapGerm_iff (by omega) le_rfl (by omega)]; omega
  · rw [carrier_germ h.half]; exact ⟨0, ⟨le_rfl, h.half.1.le⟩, by simp [branchPt]⟩

/-- (M2) A branch point out to `ρ/2` of a germ off the gap lies on the new arcs. -/
theorem branchPt_mem_mergeArcs_inner {ρ : ℝ} (h : X.Small ρ) {j : Fin X.n} (hj : j ∉ BranchGerms.gapGerm s a b) {t : ℝ}
    (ht : t ∈ Ioc 0 (ρ / 2)) : branchPt v (X.G.β j) (X.G.κ j) t ∈ ⋃ A ∈ X.G.mergeArcs v X.col s a b ρ, A.carrier := by
  refine mem_iUnion₂.mpr ⟨X.germ (ρ / 2) j, mem_mergeArcs.mpr (Or.inl ⟨_, hj, rfl⟩), ?_⟩
  rw [carrier_germ h.half]; exact ⟨t, ⟨ht.1.le, ht.2⟩, rfl⟩

/-- (M3) A branch point between `ρ/2` and `ρ` of a non-phantom germ lies on the new arcs. -/
theorem branchPt_mem_mergeArcs_outer {ρ : ℝ} (h : X.Small ρ) {j : Fin X.n} (hj : ¬ BranchGerms.Phantom X.col j) {t : ℝ}
    (ht : t ∈ Ioc (ρ / 2) ρ) : branchPt v (X.G.β j) (X.G.κ j) t ∈ ⋃ A ∈ X.G.mergeArcs v X.col s a b ρ, A.carrier := by
  obtain ⟨A, hA, hz⟩ := mem_iUnion₂.mp (mem_outer h j ht)
  exact mem_iUnion₂.mpr ⟨A, mem_mergeArcs.mpr (Or.inr (Or.inl ⟨j, hj, hA⟩)), hz⟩

/-- (M4) A point of the circle of radius `ρ/2` between the gap's end germs lies on the rim arc. -/
theorem mem_mergeArcs_rim {ρ : ℝ} (hab : a + 1 < b) {φ : ℝ} (hφ : φ ∈ Icc (X.G.liftDir s (a + 1) (ρ / 2)) (X.G.liftDir s b (ρ / 2))) :
    v + ((ρ / 2 : ℝ) : ℂ) * e φ ∈ ⋃ A ∈ X.G.mergeArcs v X.col s a b ρ, A.carrier :=
  mem_iUnion₂.mpr ⟨_, mem_mergeArcs.mpr (Or.inr (Or.inr ⟨hab, rfl⟩)), φ, hφ, rfl⟩

/-- A gap germ's lifted direction lies between the gap's end germs'. -/
theorem liftDir_gap_germ {t : ℝ} (ht : t ∈ Ioo 0 X.s₀) {m : ℕ} (h1 : a < m) (h2 : m ≤ b) :
    X.G.liftDir s m t ∈ Icc (X.G.liftDir s (a + 1) t) (X.G.liftDir s b t) :=
  ⟨(X.G.liftDir_mono X.hord s ht).monotone (by omega), (X.G.liftDir_mono X.hord s ht).monotone h2⟩

/-- A gap sector's point has its lifted direction between the gap's end germs'. -/
theorem exists_dir_of_mem_gapSec {ρ : ℝ} (h : X.Small ρ) {i : Fin X.n} (hi : i ∈ BranchGerms.gapSec s a b) {z : ℂ}
    (hz : z ∈ X.G.sector v ρ i) : ∃ φ ∈ Icc (X.G.liftDir s (a + 1) ‖z - v‖) (X.G.liftDir s b ‖z - v‖),
      z = v + ((‖z - v‖ : ℝ) : ℂ) * e φ := by
  obtain ⟨m, h1, h2, rfl⟩ := hi
  obtain ⟨t, ht, φ, hφ, rfl⟩ := (X.G.mem_sector_idx s m).mp hz
  have hn : ‖v + (t : ℂ) * e φ - v‖ = t := by
    rw [add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg ht.1.le]
  rw [hn]
  have ht' : t ∈ Ioo 0 X.s₀ := ⟨ht.1, ht.2.trans h.2.1⟩
  exact ⟨φ, ⟨((X.G.liftDir_mono X.hord s ht').monotone (by omega : a + 1 ≤ m)).trans hφ.1.le,
    hφ.2.le.trans ((X.G.liftDir_mono X.hord s ht').monotone (by omega : m + 1 ≤ b))⟩, rfl⟩

/-- (iv) **A germ's point on the rim lies on the trimmed arcs**: the branch beyond `ρ` is on them, finitely many meet a
neighbourhood, and their union is closed there. -/
theorem branchPt_rim_mem_trimArcs {ρ ρ' : ℝ} (h' : X.Small ρ') (hρ : 0 < ρ) (hρρ' : ρ < ρ') (j : Fin X.n) :
    branchPt v (X.G.β j) (X.G.κ j) ρ ∈ ⋃ B ∈ F.trimArcs v ρ, B.carrier := by
  obtain ⟨-, h2, T, hT, hsub⟩ := F.trimArcs_spec X.mem_dom hρ
  set S := {B | B ∈ F.trimArcs v ρ ∧ (B.carrier ∩ ball v X.ρ₀).Nonempty} with hS
  have hSf : S.Finite := (X.hG.fin.union hT).subset fun B ⟨hB, hBn⟩ => by
    rcases hsub hB with h1 | h1
    · exact Or.inl ⟨h1, hBn⟩
    · exact Or.inr h1
  have hcl : IsClosed (⋃ B ∈ S, B.carrier) := hSf.isClosed_biUnion fun B _ => B.isClosed_carrier
  have hmem : branchPt v (X.G.β j) (X.G.κ j) ρ ∈ ⋃ B ∈ S, B.carrier := by
    refine hcl.mem_of_tendsto ((continuous_branchPt v _ _).continuousWithinAt.tendsto.mono_left
      (nhdsWithin_mono _ subset_rfl) : Filter.Tendsto _ (𝓝[>] ρ) _) ?_
    filter_upwards [Ioo_mem_nhdsGT hρρ'] with t ht
    have ht0 : 0 ≤ t := by linarith [ht.1]
    have hΓ := X.hC.branchPt_mem_Γ j ⟨by linarith [ht.1], ht.2.trans h'.lt_r₀⟩
    have hnc : branchPt v (X.G.β j) (X.G.κ j) t ∉ closedBall v ρ := by
      rw [mem_closedBall, dist_branchPt j ht0, not_le]; exact ht.1
    obtain ⟨B, hB, hzB⟩ := mem_iUnion₂.mp (h2 ⟨hΓ.2, hnc⟩)
    refine mem_iUnion₂.mpr ⟨B, ⟨hB, _, hzB, ?_⟩, hzB⟩
    rw [mem_ball, dist_branchPt j ht0]; exact ht.2.trans h'.2.2.1
  obtain ⟨B, hB, hz⟩ := mem_iUnion₂.mp hmem
  exact mem_iUnion₂.mpr ⟨B, hB.1, hz⟩

end Near

end ArcMap

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ} {X : F.Near v} {s : Fin X.n} {a b : ℕ}

/-- The two sectors beside a gap germ are gap sectors or the gap's `c`-sectors. -/
theorem gap_sides {c : Fin k} (hca : X.col (BranchGerms.idx s a) = c)
    (hcb : X.col (BranchGerms.idx s b) = c) {p j : Fin X.n} (hpj : BranchGerms.next p = j)
    (hj : j ∈ BranchGerms.gapGerm s a b) :
    (p ∈ BranchGerms.gapSec s a b ∨ X.col p = c) ∧ (j ∈ BranchGerms.gapSec s a b ∨ X.col j = c) ∧
      (a + 1 = b → p ∉ BranchGerms.gapSec s a b ∧ j ∉ BranchGerms.gapSec s a b) := by
  obtain ⟨m, h1, h2, rfl⟩ := hj
  obtain ⟨m', rfl⟩ : ∃ m', m = m' + 1 := ⟨m - 1, by omega⟩
  have hp : p = BranchGerms.idx s m' := BranchGerms.next_injective (by rw [hpj, BranchGerms.next_idx])
  subst hp
  have hsec : ∀ i, i ∈ BranchGerms.gapSec s a b → a + 1 < b := fun i hi => by
    obtain ⟨m'', h3, h4, -⟩ := hi; omega
  refine ⟨?_, ?_, fun hab => ⟨fun hi => absurd (hsec _ hi) (by omega), fun hi => absurd (hsec _ hi) (by omega)⟩⟩
  · rcases eq_or_lt_of_le (show a ≤ m' by omega) with h | h
    · right; rw [← h, hca]
    · left; exact ⟨m', h, by omega, rfl⟩
  · rcases eq_or_lt_of_le (show m' + 1 ≤ b by omega) with h | h
    · right; rw [h, hcb]
    · left; exact ⟨m' + 1, h1, h, rfl⟩

/-- **Local constancy of MERGE's colouring** off its arcs (record § 5.2 (v)). -/
theorem merge_hlc {ρ ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) {c : Fin k} (hab : a < b) (hbn : b < X.n)
    (hca : X.col (BranchGerms.idx s a) = c) (hcb : X.col (BranchGerms.idx s b) = c) :
    ∀ x ∈ F.dom, x ∉ ⋃ A ∈ F.trimArcs v ρ ∪ X.G.mergeArcs v X.col s a b ρ, A.carrier →
      ∀ᶠ y in 𝓝 x, X.G.mergeCol v X.col F.col s a b c ρ y = X.G.mergeCol v X.col F.col s a b c ρ x := by
  classical
  have hn : 0 < X.n := by omega
  obtain ⟨-, h2, -⟩ := F.trimArcs_spec X.mem_dom h.1
  intro x hx hxa
  have hxA : x ∉ ⋃ A ∈ X.G.mergeArcs v X.col s a b ρ, A.carrier := fun hm => by
    obtain ⟨A, hA, hxA⟩ := mem_iUnion₂.mp hm; exact hxa (mem_iUnion₂.mpr ⟨A, Or.inr hA, hxA⟩)
  have hxT : x ∉ ⋃ B ∈ F.trimArcs v ρ, B.carrier := fun hm => by
    obtain ⟨B, hB, hxB⟩ := mem_iUnion₂.mp hm; exact hxa (mem_iUnion₂.mpr ⟨B, Or.inl hB, hxB⟩)
  have hρ2 : 0 < ρ / 2 := h.half.1
  rcases lt_trichotomy (dist x v) ρ with hlt | heq | hgt
  · -- inside the ball
    have hxv : x ≠ v := fun hxv => hxA (by rw [hxv]; exact v_mem_mergeArcs h hab hbn)
    have hxn : ‖x - v‖ = dist x v := (dist_eq_norm x v).symm
    rcases ball_cases h hn hlt hxv with ⟨i, hi⟩ | ⟨j, t, ht, rfl⟩
    · have hev : ∀ᶠ y in 𝓝 x, y ∈ X.G.sector v ρ i := (X.hC.isOpen ρ h.mem_Ioc i).mem_nhds hi
      by_cases hig : i ∈ BranchGerms.gapSec s a b
      · have hne : ‖x - v‖ ≠ ρ / 2 := by
          intro he
          obtain ⟨φ, hφ, hxφ⟩ := exists_dir_of_mem_gapSec h hig hi
          have hab' : a + 1 < b := by obtain ⟨m, h3, h4, -⟩ := hig; omega
          rw [he] at hφ hxφ
          exact hxA (hxφ ▸ mem_mergeArcs_rim hab' hφ)
        have hev2 : ∀ᶠ y in 𝓝 x, (‖y - v‖ < ρ / 2 ↔ ‖x - v‖ < ρ / 2) := by
          rcases lt_or_gt_of_ne hne with hl | hg
          · filter_upwards [isOpen_ball.mem_nhds (show x ∈ ball v (ρ / 2) by rw [mem_ball, ← hxn]; exact hl)] with y hy
            rw [mem_ball, dist_eq_norm] at hy; exact ⟨fun _ => hl, fun _ => hy⟩
          · filter_upwards [isClosed_closedBall.isOpen_compl.mem_nhds
              (show x ∉ closedBall v (ρ / 2) by rw [mem_closedBall, ← hxn, not_le]; exact hg)] with y hy
            rw [mem_compl_iff, mem_closedBall, dist_eq_norm, not_le] at hy
            exact ⟨fun h1 => absurd h1 (not_lt.mpr hy.le), fun h1 => absurd h1 (not_lt.mpr hg.le)⟩
        filter_upwards [hev, hev2] with y hy hy2
        rw [mergeCol_of_mem_sector h hy, mergeCol_of_mem_sector h hi]; simp only [hy2]
      · filter_upwards [hev] with y hy
        rw [mergeCol_of_mem_sector h hy, mergeCol_of_mem_sector h hi, if_neg (fun h1 => hig h1.1),
          if_neg (fun h1 => hig h1.1)]
    · -- a branch point
      obtain ⟨p, hpj⟩ := exists_next_eq j
      obtain ⟨ε, hε, hball⟩ := X.hC.exists_ball_subset_of_branchPt X.hs₀.2 X.hdisj (r := ρ) ⟨h.1, h.2.1.le⟩ (p := p) ht
      rw [hpj] at hball
      have hev : ∀ᶠ y in 𝓝 (branchPt v (X.G.β j) (X.G.κ j) t), y ∈ X.G.sector v ρ p ∪ X.G.sector v ρ j ∪
          branchPt v (X.G.β j) (X.G.κ j) '' Ioo 0 ρ := Filter.mem_of_superset (ball_mem_nhds _ hε) hball
      have hxt : ‖branchPt v (X.G.β j) (X.G.κ j) t - v‖ = t := norm_branchPt_sub v _ _ ht.1.le
      rw [mergeCol_branchPt h j ht]
      have hout : ρ / 2 < t → ∀ᶠ y in 𝓝 (branchPt v (X.G.β j) (X.G.κ j) t),
          X.G.mergeCol v X.col F.col s a b c ρ y = X.col j := by
        intro htg
        have hph : BranchGerms.Phantom X.col j := by
          by_contra hph; exact hxA (branchPt_mem_mergeArcs_outer h hph ⟨htg, ht.2.le⟩)
        have hpc : X.col p = X.col j := by
          obtain ⟨i, hi, hc⟩ := hph; rw [← BranchGerms.next_injective (hi.trans hpj.symm)]; exact hc
        filter_upwards [hev, isClosed_closedBall.isOpen_compl.mem_nhds (show branchPt v (X.G.β j) (X.G.κ j) t ∉
          closedBall v (ρ / 2) by rw [mem_closedBall, dist_eq_norm, hxt, not_le]; exact htg)] with y hy hyb
        rw [mem_compl_iff, mem_closedBall, dist_eq_norm, not_le] at hyb
        rcases hy with (hy | hy) | ⟨t', ht', rfl⟩
        · rw [mergeCol_of_mem_sector h hy, if_neg (fun h1 => (not_lt.mpr hyb.le) h1.2), hpc]
        · rw [mergeCol_of_mem_sector h hy, if_neg (fun h1 => (not_lt.mpr hyb.le) h1.2)]
        · rw [norm_branchPt_sub v _ _ ht'.1.le] at hyb
          rw [mergeCol_branchPt h j ht', if_neg (fun h1 => (not_lt.mpr hyb.le) h1.2)]
      by_cases hjg : j ∈ BranchGerms.gapGerm s a b
      · obtain ⟨hps, hjs, h1b⟩ := gap_sides hca hcb hpj hjg
        rcases lt_trichotomy t (ρ / 2) with htl | hte | htg
        · rw [if_pos ⟨hjg, htl⟩]
          filter_upwards [hev, isOpen_ball.mem_nhds (show branchPt v (X.G.β j) (X.G.κ j) t ∈ ball v (ρ / 2) by
            rw [mem_ball, dist_eq_norm, hxt]; exact htl)] with y hy hyb
          rw [mem_ball, dist_eq_norm] at hyb
          rcases hy with (hy | hy) | ⟨t', ht', rfl⟩
          · rw [mergeCol_of_mem_sector h hy]
            rcases hps with hps | hps
            · rw [if_pos ⟨hps, hyb⟩]
            · split_ifs <;> [rfl; exact hps]
          · rw [mergeCol_of_mem_sector h hy]
            rcases hjs with hjs | hjs
            · rw [if_pos ⟨hjs, hyb⟩]
            · split_ifs <;> [rfl; exact hjs]
          · rw [norm_branchPt_sub v _ _ ht'.1.le] at hyb
            rw [mergeCol_branchPt h j ht', if_pos ⟨hjg, hyb⟩]
        · by_cases hab1 : a + 1 < b
          · exfalso
            obtain ⟨m, h1, h2', rfl⟩ := hjg
            have hφ := liftDir_gap_germ (s := s) (⟨ht.1, ht.2.trans h.2.1⟩ : t ∈ Ioo 0 X.s₀) h1 h2'
            rw [hte] at hφ
            apply hxA
            rw [hte, X.G.branchPt_idx]
            exact mem_mergeArcs_rim hab1 hφ
          · have hab1' : a + 1 = b := by omega
            obtain ⟨hpn, hjn⟩ := h1b hab1'
            have hpc : X.col p = c := hps.resolve_left hpn
            have hjc : X.col j = c := hjs.resolve_left hjn
            rw [if_neg (fun h1 => absurd h1.2 (by linarith)), hjc]
            filter_upwards [hev] with y hy
            rcases hy with (hy | hy) | ⟨t', ht', rfl⟩
            · rw [mergeCol_of_mem_sector h hy, if_neg (fun h1 => hpn h1.1), hpc]
            · rw [mergeCol_of_mem_sector h hy, if_neg (fun h1 => hjn h1.1), hjc]
            · rw [mergeCol_branchPt h j ht']; split_ifs <;> [rfl; exact hjc]
        · rw [if_neg (fun h1 => absurd h1.2 (not_lt.mpr htg.le))]; exact hout htg
      · rw [if_neg (fun h1 => hjg h1.1)]
        rcases le_or_gt t (ρ / 2) with htl | htg
        · exact absurd (branchPt_mem_mergeArcs_inner h hjg ⟨ht.1, htl⟩) hxA
        · exact hout htg
  · -- on the rim: interior to `F`, in one chart sector
    have hxv : x ≠ v := fun hxv => by rw [hxv, dist_self] at heq; linarith [h.1]
    have hxF : x ∈ F.interiorPts := by
      refine ⟨hx, fun hxF => ?_⟩
      have hxr : x ∈ ball v X.r₀ := by rw [mem_ball, heq]; exact h.lt_r₀
      obtain ⟨j, hj⟩ := X.hC.exists_branchPt_eq hxv hxr (fun hI => hI.2 hxF)
      rw [← dist_eq_norm, heq] at hj
      exact hxT (hj ▸ branchPt_rim_mem_trimArcs h' h.1 hρρ' j)
    obtain ⟨i, hi⟩ : ∃ i, x ∈ X.G.sector v ρ' i := by
      have : x ∈ ball v ρ' ∩ F.interiorPts := ⟨by rw [mem_ball, heq]; exact hρρ', hxF⟩
      rw [X.hC.cover ρ' h'.mem_Ioc hn] at this
      exact mem_iUnion.mp this
    have hcolx : ∀ y ∈ X.G.sector v ρ' i, ρ / 2 < ‖y - v‖ → X.G.mergeCol v X.col F.col s a b c ρ y = X.col i := by
      intro y hy hyr
      by_cases hyb : y ∈ ball v ρ
      · have hy' := mem_sector_of_lt hy (by rwa [mem_ball, dist_eq_norm] at hyb)
        rw [mergeCol_of_mem_sector h hy', if_neg (fun h1 => (not_lt.mpr hyr.le) h1.2)]
      · rw [mergeCol_of_not_mem h hyb]; simpa using (X.hcol i ρ' h'.mem_Ioc hy).2
    have hxr : ρ / 2 < ‖x - v‖ := by rw [← dist_eq_norm, heq]; linarith [h.1]
    filter_upwards [(X.hC.isOpen ρ' h'.mem_Ioc i).mem_nhds hi, isClosed_closedBall.isOpen_compl.mem_nhds
      (show x ∉ closedBall v (ρ / 2) by rw [mem_closedBall, dist_eq_norm, not_le]; exact hxr)] with y hy hyb
    rw [mem_compl_iff, mem_closedBall, dist_eq_norm, not_le] at hyb
    rw [hcolx y hy hyb, hcolx x hi hxr]
  · -- off the closed ball: `F`'s colouring
    have hxc : x ∉ closedBall v ρ := by rw [mem_closedBall, not_le]; exact hgt
    have hxF : x ∉ ⋃ a ∈ F.arcs, a.carrier := fun hF => hxT (h2 ⟨hF, hxc⟩)
    filter_upwards [F.locallyConstant x hx hxF, isClosed_closedBall.isOpen_compl.mem_nhds hxc] with y hy hyc
    rw [mergeCol_of_not_mem h (fun hb => hyc (ball_subset_closedBall hb)),
      mergeCol_of_not_mem h (fun hb => hxc (ball_subset_closedBall hb)), hy]

end Near

end ArcMap

end HadwigerNelson.Plane

/-! ## FS131-IMM3: MERGE's clauses — agreement, no unit arc, Condition 5, validity, `v`'s colours, the sector count, the rim's colours
(record § 4.4) -/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ} {X : F.Near v} {s : Fin X.n} {a b : ℕ}

/-- **Every colour MERGE gives near `v` is carried at `v`** (`c` is a `c`-sector's colour). -/
theorem mergeCol_mem_coloursAt {ρ : ℝ} (h : X.Small ρ) {c : Fin k} (hn : 0 < X.n) (hca : X.col (BranchGerms.idx s a) = c)
    {z : ℂ} (hz : z ∈ ball v ρ) (hzv : z ≠ v) : X.G.mergeCol v X.col F.col s a b c ρ z ∈ F.coloursAt v := by
  have hcol : ∀ i, X.col i ∈ F.coloursAt v := fun i =>
    closure_mono (X.hcol₀ i) (X.hC.mem_closure_sector X.hs₀ i)
  have hc : c ∈ F.coloursAt v := hca ▸ hcol _
  rcases ball_cases h hn hz hzv with ⟨i, hi⟩ | ⟨j, t, ht, rfl⟩
  · rw [mergeCol_of_mem_sector h hi]; split_ifs
    · exact hc
    · exact hcol i
  · rw [mergeCol_branchPt h j ht]; split_ifs
    · exact hc
    · exact hcol j

/-- Inside `B(v, ρ/2)` a point of MERGE's new arcs is `v` or a branch point of a germ off the gap. -/
theorem mem_mergeArcs_inner {ρ : ℝ} (h : X.Small ρ) {z : ℂ} (hz : z ∈ ball v (ρ / 2))
    (hzA : z ∈ ⋃ A ∈ X.G.mergeArcs v X.col s a b ρ, A.carrier) :
    z = v ∨ ∃ j ∉ BranchGerms.gapGerm s a b, ∃ t ∈ Ioo 0 (ρ / 2), z = branchPt v (X.G.β j) (X.G.κ j) t := by
  obtain ⟨A, hA, hzA⟩ := mem_iUnion₂.mp hzA
  rw [mem_ball] at hz
  rcases mem_mergeArcs.mp hA with ⟨j, hj, rfl⟩ | ⟨j, -, hA'⟩ | ⟨-, rfl⟩
  · rw [carrier_germ h.half] at hzA
    obtain ⟨t, ht, rfl⟩ := hzA
    rcases eq_or_lt_of_le ht.1 with h0 | h0
    · left; rw [← h0]; simp [branchPt]
    · right; rw [dist_branchPt j ht.1] at hz; exact ⟨j, hj, t, ⟨h0, hz⟩, rfl⟩
  · obtain ⟨t, ht, rfl⟩ := outer_subset h j A hA' hzA
    rw [dist_branchPt j (by linarith [ht.1, h.1])] at hz; linarith [ht.1]
  · obtain ⟨θ, -, rfl⟩ := hzA
    rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real,
      Real.norm_of_nonneg (by linarith [h.1])] at hz
    linarith

/-- A gap sector or a gap germ's index: the two sectors beside a gap germ are the gap's first `c`-sector or gap sectors, and the
gap's last `c`-sector or gap sectors. -/
theorem gap_sides_idx {p j : Fin X.n} (hpj : BranchGerms.next p = j) {m : ℕ} (h1 : a < m) (h2 : m ≤ b)
    (hj : BranchGerms.idx s m = j) : ∃ m', m = m' + 1 ∧ a ≤ m' ∧ p = BranchGerms.idx s m' := by
  obtain ⟨m', rfl⟩ : ∃ m', m = m' + 1 := ⟨m - 1, by omega⟩
  exact ⟨m', rfl, by omega, BranchGerms.next_injective (by rw [hpj, BranchGerms.next_idx, hj])⟩

/-- **The merged chain** out to `r`: the first `c`-sector, then each gap germ's branch and the sector after it, up to `idx s m`. -/
def chain (X : F.Near v) (s : Fin X.n) (a : ℕ) (r : ℝ) (m : ℕ) : Set ℂ :=
  X.G.sector v r (BranchGerms.idx s a) ∪
    ⋃ m' ∈ Ioc a m, (X.G.branch v r (BranchGerms.idx s m') ∪ X.G.sector v r (BranchGerms.idx s m'))

theorem mem_chain {r : ℝ} {m : ℕ} {z : ℂ} : z ∈ chain X s a r m ↔ z ∈ X.G.sector v r (BranchGerms.idx s a) ∨
    ∃ m', a < m' ∧ m' ≤ m ∧ (z ∈ X.G.branch v r (BranchGerms.idx s m') ∨ z ∈ X.G.sector v r (BranchGerms.idx s m')) := by
  unfold chain; simp only [mem_union, mem_iUnion₂, mem_Ioc, exists_prop]
  constructor
  · rintro (h | ⟨m', ⟨h1, h2⟩, h3⟩)
    · exact Or.inl h
    · exact Or.inr ⟨m', h1, h2, h3⟩
  · rintro (h | ⟨m', h1, h2, h3⟩)
    · exact Or.inl h
    · exact Or.inr ⟨m', ⟨h1, h2⟩, h3⟩

-- spec examples for `chain`: the first `c`-sector, and the branch of the germ after it once `m > a`
example (r : ℝ) (m : ℕ) : X.G.sector v r (BranchGerms.idx s a) ⊆ chain X s a r m := fun _ hz => Or.inl hz
example (r : ℝ) : X.G.branch v r (BranchGerms.idx s (a + 1)) ⊆ chain X s a r (a + 1) := fun _ hz =>
  mem_chain.mpr (Or.inr ⟨a + 1, by omega, le_rfl, Or.inl hz⟩)

theorem sector_subset_chain {r : ℝ} {m m' : ℕ} (h1 : a ≤ m') (h2 : m' ≤ m) :
    X.G.sector v r (BranchGerms.idx s m') ⊆ chain X s a r m := fun z hz => by
  rcases eq_or_lt_of_le h1 with h | h
  · subst h; exact mem_chain.mpr (Or.inl hz)
  · exact mem_chain.mpr (Or.inr ⟨m', h, h2, Or.inr hz⟩)

/-- The chain is preconnected. -/
theorem isPreconnected_chain {r : ℝ} (hr : r ∈ Ioc 0 X.s₀) {m : ℕ} (hm : a ≤ m) : IsPreconnected (chain X s a r m) := by
  have hr₀ : r ∈ Ioc 0 X.r₀ := ⟨hr.1, hr.2.trans X.hs₀.2⟩
  induction m, hm using Nat.le_induction with
  | base =>
    have : chain X s a r a = X.G.sector v r (BranchGerms.idx s a) := by
      ext z; rw [mem_chain]; constructor
      · rintro (h | ⟨m', h1, h2, -⟩)
        · exact h
        · omega
      · exact Or.inl
    rw [this]; exact X.hC.isPreconnected r hr₀ _
  | succ m hm ih =>
    have heq : chain X s a r (m + 1) = (chain X s a r m ∪ X.G.branch v r (BranchGerms.idx s (m + 1))) ∪
        (X.G.branch v r (BranchGerms.idx s (m + 1)) ∪ X.G.sector v r (BranchGerms.idx s (m + 1))) := by
      ext z; simp only [mem_union, mem_chain]
      constructor
      · rintro (h | ⟨m', h1, h2, h3⟩)
        · exact Or.inl (Or.inl (Or.inl h))
        · rcases eq_or_lt_of_le h2 with h2 | h2
          · subst h2; exact Or.inr h3
          · exact Or.inl (Or.inl (Or.inr ⟨m', h1, by omega, h3⟩))
      · rintro (((h | ⟨m', h1, h2, h3⟩) | h) | (h | h))
        · exact Or.inl h
        · exact Or.inr ⟨m', h1, by omega, h3⟩
        · exact Or.inr ⟨m + 1, by omega, le_rfl, Or.inl h⟩
        · exact Or.inr ⟨m + 1, by omega, le_rfl, Or.inl h⟩
        · exact Or.inr ⟨m + 1, by omega, le_rfl, Or.inr h⟩
    rw [heq]
    have hbr : X.G.branch v r (BranchGerms.idx s (m + 1)) ⊆ closure (X.G.sector v r (BranchGerms.idx s m)) := by
      rintro z ⟨t, ht, rfl⟩
      have := IsSectorChart.branchPt_mem_closure_sector_before (v := v) X.hord hr.2 (BranchGerms.idx s m) ht
      rwa [BranchGerms.next_idx] at this
    have h1 : IsPreconnected (chain X s a r m ∪ X.G.branch v r (BranchGerms.idx s (m + 1))) :=
      ih.subset_closure subset_union_left (union_subset subset_closure
        (hbr.trans (closure_mono (sector_subset_chain hm le_rfl))))
    have h2 : IsPreconnected (X.G.branch v r (BranchGerms.idx s (m + 1)) ∪ X.G.sector v r (BranchGerms.idx s (m + 1))) := by
      refine (X.hC.isPreconnected r hr₀ _).subset_closure subset_union_right (union_subset ?_ subset_closure)
      rintro z ⟨t, ht, rfl⟩
      exact IsSectorChart.branchPt_mem_closure_sector_after X.hord hr.2 _ ht
    refine h1.union' ⟨branchPt v (X.G.β (BranchGerms.idx s (m + 1))) (X.G.κ (BranchGerms.idx s (m + 1))) (r / 2),
      Or.inr ⟨r / 2, ⟨by linarith [hr.1], by linarith [hr.1]⟩, rfl⟩, Or.inl ⟨r / 2, ⟨by linarith [hr.1], by linarith [hr.1]⟩, rfl⟩⟩ h2

section Surgery

variable {c : Fin k} {ρ : ℝ} {hv : v ∈ F.dom} {hρ : 0 < ρ} {hA : ∀ A ∈ X.G.mergeArcs v X.col s a b ρ, A.Nondegenerate}
  {hAf : (X.G.mergeArcs v X.col s a b ρ).Finite}
  {hlc : ∀ x ∈ F.dom, x ∉ ⋃ A ∈ F.trimArcs v ρ ∪ X.G.mergeArcs v X.col s a b ρ, A.carrier →
    ∀ᶠ y in 𝓝 x, X.G.mergeCol v X.col F.col s a b c ρ y = X.G.mergeCol v X.col F.col s a b c ρ x}

/-- Inside `B(v, ρ)`, MERGE's interior points are the points off its new arcs. -/
theorem mem_merge_interiorPts_iff (h : X.Small ρ) {z : ℂ} (hz : z ∈ ball v ρ) :
    z ∈ (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).interiorPts ↔
      z ∉ ⋃ A ∈ X.G.mergeArcs v X.col s a b ρ, A.carrier := by
  have hzd : z ∈ F.dom := X.hG.subdom (ball_subset_ball h.2.2.1.le hz)
  show z ∈ F.dom \ _ ↔ _
  rw [Set.mem_sdiff, surgery_mem_arcs_iff_of_mem X.hG h.2.2.1 hz]
  exact ⟨fun h1 => h1.2, fun h1 => ⟨hzd, h1⟩⟩

/-- On the rim, MERGE's interior points are `F`'s (a germ's rim point lies on the trimmed arcs). -/
theorem mem_interiorPts_of_merge_rim {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') {z : ℂ} (hz : dist z v = ρ)
    (hzI : z ∈ (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).interiorPts) :
    z ∈ F.interiorPts := by
  refine ⟨hzI.1, fun hzF => ?_⟩
  have hzv : z ≠ v := fun hzv => by rw [hzv, dist_self] at hz; linarith
  have hzr : z ∈ ball v X.r₀ := by rw [mem_ball, hz]; exact hρρ'.trans h'.lt_r₀
  obtain ⟨j, hj⟩ := X.hC.exists_branchPt_eq hzv hzr (fun hI => hI.2 hzF)
  rw [← dist_eq_norm, hz] at hj
  obtain ⟨B, hB, hzB⟩ := mem_iUnion₂.mp (hj ▸ branchPt_rim_mem_trimArcs h' hρ hρρ' j)
  exact hzI.2 (mem_iUnion₂.mpr ⟨B, Or.inl hB, hzB⟩)

/-- **MERGE agrees with `F` off `B̄(v, ρ)`.** -/
theorem merge_agreesOff (h : X.Small ρ) :
    (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).AgreesOff F
      (closedBall v ρ) :=
  surgery_agreesOff (mergeArcs_subset_closedBall h)
    fun _ hz => mergeCol_of_not_mem h fun hb => hz (ball_subset_closedBall hb)

/-- **MERGE creates no unit arc.** -/
theorem merge_ringArcsWithin (h : X.Small ρ) :
    (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).RingArcsWithin F :=
  surgery_ringArcsWithin (mergeArcs_unit h)

/-- **MERGE keeps Condition 5.** -/
theorem merge_condition5 (h : X.Small ρ) (hbn : b < X.n) :
    F.Condition5 →
      (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).Condition5 :=
  surgery_condition5 (mergeArcs_condition5 h hbn)

/-- **`v` gains no colour** under MERGE. -/
theorem merge_coloursAt_self (h : X.Small ρ) (hab : a < b) (hbn : b < X.n) (hca : X.col (BranchGerms.idx s a) = c) :
    (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).coloursAt v ⊆
      F.coloursAt v := by
  intro j hj
  have hj : v ∈ closure ((F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf
    hlc).region j) := hj
  rw [mem_closure_iff_nhds] at hj
  obtain ⟨z, hzb, hzI, hzj⟩ := hj (ball v ρ) (isOpen_ball.mem_nhds (mem_ball_self h.1))
  have hzj' : X.G.mergeCol v X.col F.col s a b c ρ z = j := hzj
  have hzv : z ≠ v := by
    rintro rfl; exact (mem_merge_interiorPts_iff h hzb).mp hzI (v_mem_mergeArcs h hab hbn)
  rw [← hzj']; exact mergeCol_mem_coloursAt h (by omega) hca hzb hzv

/-- **MERGE is valid** (record § 4.4): an interior point of the new map in `B̄(v, ρ)` is clear for its colour — the gap's points for
`c` by the gap's clearness, the others for the colour of their sector or of the sector after their germ — and points of `B̄(v, ρ)` are
closer than `1`. -/
theorem merge_valid (hF : F.Valid) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (hab : a < b) (hbn : b < X.n)
    {ρc : ℝ} (hρc : ρ ≤ ρc) (hgc : ∀ t ∈ Ioo 0 ρc, ∀ φ, X.G.liftDir s (a + 1) t ≤ φ → φ ≤ X.G.liftDir s b t →
      F.IsClear c (v + (t : ℂ) * e φ)) :
    (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).Valid := by
  have hregion : ∀ i, ∀ y ∈ F.region i, F.IsClear i y := fun i y hy => by
    have h1 := hy.2; simp only [mem_preimage, mem_singleton_iff] at h1; rw [← h1]; exact isClear_col hF hy.1
  refine Valid.of_agreesOff hF (merge_agreesOff h) ?_ ?_
  · rintro z ⟨hzc, hzI⟩
    show F.IsClear (X.G.mergeCol v X.col F.col s a b c ρ z) z
    rcases (mem_closedBall.mp hzc).lt_or_eq with hlt | heq
    · have hzv : z ≠ v := by
        rintro rfl; exact (mem_merge_interiorPts_iff h hlt).mp hzI (v_mem_mergeArcs h hab hbn)
      rcases ball_cases h (by omega) hlt hzv with ⟨i, hi⟩ | ⟨j, t, ht, rfl⟩
      · rw [mergeCol_of_mem_sector h hi]; split_ifs with hg
        · obtain ⟨φ, hφ, hzφ⟩ := exists_dir_of_mem_gapSec h hg.1 hi
          rw [hzφ]; exact hgc _ ⟨(norm_of_mem_sector hi).1, by linarith [hg.2, h.1]⟩ φ hφ.1 hφ.2
        · exact hregion _ _ (X.hcol i ρ h.mem_Ioc hi)
      · rw [mergeCol_branchPt h j ht]; split_ifs with hg
        · obtain ⟨m, h1, h2, rfl⟩ := hg.1
          have hφ := liftDir_gap_germ (s := s) (⟨ht.1, ht.2.trans h.2.1⟩ : t ∈ Ioo 0 X.s₀) h1 h2
          rw [X.G.branchPt_idx]
          exact hgc t ⟨ht.1, by linarith [hg.2, h.1]⟩ _ hφ.1 hφ.2
        · exact isClear_of_mem_closure (hregion _) (cutSet_subset_closure h ⟨t, ht, rfl⟩)
    · have hzF := mem_interiorPts_of_merge_rim h' hρρ' heq hzI
      rw [mergeCol_of_not_mem h (by rw [mem_ball, heq]; exact lt_irrefl ρ)]
      exact isClear_col hF hzF
  · rintro z ⟨hz, -⟩ y ⟨hy, -⟩ hzy
    exfalso
    have := dist_triangle_right z y v
    rw [mem_closedBall] at hz hy
    linarith [h.2.2.2]

/-- **MERGE's sector count at `v`**: `c` loses one sector (record § 4.4) — inside `B(v, ρ/2)` the interior points are the sectors off
the gap and the merged chain from `idx s a` to `idx s b`, all of colour `c`. -/
theorem merge_hasSectors (h : X.Small ρ) (hab : a < b) (hbn : b < X.n) (hca : X.col (BranchGerms.idx s a) = c)
    (hcb : X.col (BranchGerms.idx s b) = c) (hgap : ∀ m, a < m → m < b → X.col (BranchGerms.idx s m) ≠ c) {n : ℕ}
    (hcnt : {i | X.col i = c}.encard = n + 1) :
    (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).HasSectors v c n := by
  classical
  have hn : 0 < X.n := by omega
  filter_upwards [Ioo_mem_nhdsGT h.half.1] with r hr
  have hr0 := hr.1
  have hrs : r ∈ Ioc 0 X.s₀ := ⟨hr.1, by linarith [hr.2, h.2.1, h.1]⟩
  have hr₀ : r ∈ Ioc 0 X.r₀ := ⟨hr.1, hrs.2.trans X.hs₀.2⟩
  have hrρ : r ≤ ρ := by linarith [hr.2, h.1]
  have hsr : X.Small r := h.mono hr.1 hrρ
  have hagg : BranchGerms.idx s a ∉ BranchGerms.gapGerm s a b := by
    rw [BranchGerms.idx_mem_gapGerm_iff (by omega) le_rfl (by omega)]; omega
  set F' := F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc with hF'
  have hball : ∀ {z : ℂ}, ‖z - v‖ < r → z ∈ ball v ρ := fun hz => by rw [mem_ball, dist_eq_norm]; linarith
  have hball2 : ∀ {z : ℂ}, ‖z - v‖ < r → z ∈ ball v (ρ / 2) := fun hz => by rw [mem_ball, dist_eq_norm]; linarith [hr.2]
  have hsecI : ∀ i, ∀ z ∈ X.G.sector v r i, z ∈ F'.interiorPts ∩ ball v r := by
    intro i z hz
    have hzr := (norm_of_mem_sector hz).2
    refine ⟨(mem_merge_interiorPts_iff h (hball hzr)).mpr fun hzA => ?_, by rw [mem_ball, dist_eq_norm]; exact hzr⟩
    rcases mem_mergeArcs_inner h (hball2 hzr) hzA with rfl | ⟨j, -, t, ht, rfl⟩
    · have := (norm_of_mem_sector hz).1; rw [sub_self, norm_zero] at this; exact lt_irrefl 0 this
    · exact branchPt_not_mem_sector h j ⟨ht.1, by linarith [ht.2, h.1]⟩ i (sector_mono hrρ i hz)
  have hbrI : ∀ m', a < m' → m' ≤ b → ∀ z ∈ X.G.branch v r (BranchGerms.idx s m'), z ∈ F'.interiorPts ∩ ball v r := by
    rintro m' h1 h2 z ⟨t, ht, rfl⟩
    have hzr : ‖branchPt v (X.G.β (BranchGerms.idx s m')) (X.G.κ (BranchGerms.idx s m')) t - v‖ < r := by
      rw [norm_branchPt_sub v _ _ ht.1.le]; exact ht.2
    refine ⟨(mem_merge_interiorPts_iff h (hball hzr)).mpr fun hzA => ?_, by rw [mem_ball, dist_eq_norm]; exact hzr⟩
    rcases mem_mergeArcs_inner h (hball2 hzr) hzA with h0 | ⟨j, hj, t', ht', he⟩
    · have := congrArg (fun z => ‖z - v‖) h0
      simp only [norm_branchPt_sub v _ _ ht.1.le, sub_self, norm_zero] at this; linarith [ht.1]
    · have := eq_of_mem_branch (r := r) h ⟨ht'.1, by linarith [ht'.2, h.1]⟩ ⟨t, ht, he⟩
      exact hj (this ▸ ⟨m', h1, h2, rfl⟩)
  have hchainI : chain X s a r b ⊆ F'.interiorPts ∩ ball v r := by
    intro z hz
    rcases mem_chain.mp hz with hz | ⟨m', h1, h2, hz | hz⟩
    · exact hsecI _ z hz
    · exact hbrI m' h1 h2 z hz
    · exact hsecI _ z hz
  set P : Fin X.n → Set ℂ := fun i => if i = BranchGerms.idx s a then chain X s a r b else
    if i ∈ BranchGerms.gapGerm s a b then ∅ else X.G.sector v r i with hP
  set colA : Fin X.n → Fin k := fun i => if i = BranchGerms.idx s a then c else X.col i with hcolA
  have hPa : P (BranchGerms.idx s a) = chain X s a r b := by simp [hP]
  have hPg : ∀ i, i ∈ BranchGerms.gapGerm s a b → P i = ∅ := fun i hi => by
    have : i ≠ BranchGerms.idx s a := fun he => hagg (he ▸ hi)
    simp [hP, this, hi]
  have hPo : ∀ i, i ≠ BranchGerms.idx s a → i ∉ BranchGerms.gapGerm s a b → P i = X.G.sector v r i := fun i h1 h2 => by
    simp [hP, h1, h2]
  have hU : F'.interiorPts ∩ ball v r = ⋃ i, P i := by
    ext z; constructor
    · rintro ⟨hzI, hzb⟩
      have hzb' : z ∈ ball v ρ := ball_subset_ball hrρ hzb
      have hzv : z ≠ v := by
        rintro rfl; exact (mem_merge_interiorPts_iff h hzb').mp hzI (v_mem_mergeArcs h hab hbn)
      have hzr : ‖z - v‖ < r := by rw [← dist_eq_norm]; exact hzb
      rcases ball_cases h hn hzb' hzv with ⟨i, hi⟩ | ⟨j, t, ht, rfl⟩
      · have hi' := mem_sector_of_lt hi hzr
        refine mem_iUnion.mpr ?_
        by_cases hia : i = BranchGerms.idx s a
        · exact ⟨_, by rw [hPa]; exact mem_chain.mpr (Or.inl (hia ▸ hi'))⟩
        by_cases hig : i ∈ BranchGerms.gapGerm s a b
        · obtain ⟨m', h1, h2, rfl⟩ := hig
          exact ⟨_, by rw [hPa]; exact sector_subset_chain (by omega) h2 hi'⟩
        · exact ⟨i, by rw [hPo i hia hig]; exact hi'⟩
      · rw [norm_branchPt_sub v _ _ ht.1.le] at hzr
        by_cases hjg : j ∈ BranchGerms.gapGerm s a b
        · obtain ⟨m', h1, h2, rfl⟩ := hjg
          exact mem_iUnion.mpr ⟨_, by rw [hPa]; exact mem_chain.mpr (Or.inr ⟨m', h1, h2, Or.inl ⟨t, ⟨ht.1, hzr⟩, rfl⟩⟩)⟩
        · exact absurd (branchPt_mem_mergeArcs_inner h hjg ⟨ht.1, by linarith [hr.2]⟩)
            ((mem_merge_interiorPts_iff h hzb').mp hzI)
    · intro hz
      obtain ⟨i, hi⟩ := mem_iUnion.mp hz
      by_cases hia : i = BranchGerms.idx s a
      · rw [hia, hPa] at hi; exact hchainI hi
      by_cases hig : i ∈ BranchGerms.gapGerm s a b
      · rw [hPg i hig] at hi; exact absurd hi (notMem_empty z)
      · rw [hPo i hia hig] at hi; exact hsecI i z hi
  have hchain_open : IsOpen (chain X s a r b) := by
    rw [isOpen_iff_mem_nhds]
    intro z hz
    rcases mem_chain.mp hz with hz' | ⟨m', h1, h2, ⟨t, ht, rfl⟩ | hz'⟩
    · exact Filter.mem_of_superset ((X.hC.isOpen r hr₀ _).mem_nhds hz') (sector_subset_chain le_rfl hab.le)
    · obtain ⟨p, hpj⟩ := exists_next_eq (BranchGerms.idx s m')
      obtain ⟨m'', hm, ham, rfl⟩ := gap_sides_idx hpj h1 h2 rfl
      obtain ⟨ε, hε, hsub⟩ := X.hC.exists_ball_subset_of_branchPt X.hs₀.2 X.hdisj hrs (p := BranchGerms.idx s m'') ht
      rw [hpj] at hsub
      refine Filter.mem_of_superset (ball_mem_nhds _ hε) (hsub.trans ?_)
      rintro y ((hy | hy) | hy)
      · exact sector_subset_chain ham (by omega) hy
      · exact sector_subset_chain (by omega) h2 hy
      · exact mem_chain.mpr (Or.inr ⟨m', h1, h2, Or.inl hy⟩)
    · exact Filter.mem_of_superset ((X.hC.isOpen r hr₀ _).mem_nhds hz') (sector_subset_chain (by omega) h2)
  have hchain_sec : ∀ i, i ≠ BranchGerms.idx s a → i ∉ BranchGerms.gapGerm s a b →
      Disjoint (chain X s a r b) (X.G.sector v r i) := by
    intro i hia hig
    rw [disjoint_left]
    intro z hz hzi
    rcases mem_chain.mp hz with hz' | ⟨m', h1, h2, hz' | hz'⟩
    · exact hia (sector_disjoint hsr hzi hz')
    · exact not_mem_branch_of_mem_sector hsr hzi _ hz'
    · exact hig (sector_disjoint hsr hz' hzi ▸ ⟨m', h1, h2, rfl⟩)
  rw [encard_sectorsOf_of_partition (A := P) (colA := colA) hU ?_ ?_ ?_ ?_ ?_ c]
  · have hset : {i | (P i).Nonempty ∧ colA i = c} = {i | X.col i = c} \ {BranchGerms.idx s b} := by
      ext i
      simp only [mem_setOf_eq, Set.mem_sdiff, mem_singleton_iff]
      by_cases hia : i = BranchGerms.idx s a
      · subst hia
        refine ⟨fun _ => ⟨hca, fun he => ?_⟩, fun _ => ⟨?_, by simp [hcolA]⟩⟩
        · have := BranchGerms.idx_inj (n := X.n) (s := s) (a := a) le_rfl (by omega) (by omega) (by omega) he; omega
        · rw [hPa]; exact (X.hC.sector_nonempty hr₀ _).mono (sector_subset_chain le_rfl hab.le)
      by_cases hig : i ∈ BranchGerms.gapGerm s a b
      · rw [hPg i hig]
        obtain ⟨m', h1, h2, rfl⟩ := hig
        constructor
        · rintro ⟨hne, -⟩; exact absurd hne Set.not_nonempty_empty
        · rintro ⟨hc, hne⟩
          rcases eq_or_lt_of_le h2 with h2 | h2
          · exact absurd (by rw [h2]) hne
          · exact absurd hc (hgap m' h1 h2)
      · rw [hPo i hia hig]
        simp only [hcolA, if_neg hia]
        refine ⟨fun h1 => ⟨h1.2, fun he => hig (he ▸ ⟨b, hab, le_rfl, rfl⟩)⟩, fun h1 => ⟨X.hC.sector_nonempty hr₀ i, h1.1⟩⟩
    rw [hset]
    have hb : BranchGerms.idx s b ∈ {i | X.col i = c} := hcb
    have := Set.encard_sdiff_singleton_add_one hb
    rw [hcnt] at this
    exact WithTop.add_right_cancel ENat.one_ne_top this
  · intro i
    by_cases hia : i = BranchGerms.idx s a
    · rw [hia, hPa]; exact hchain_open
    by_cases hig : i ∈ BranchGerms.gapGerm s a b
    · rw [hPg i hig]; exact isOpen_empty
    · rw [hPo i hia hig]; exact X.hC.isOpen r hr₀ i
  · intro i
    by_cases hia : i = BranchGerms.idx s a
    · rw [hia, hPa]; exact isPreconnected_chain hrs hab.le
    by_cases hig : i ∈ BranchGerms.gapGerm s a b
    · rw [hPg i hig]; exact isPreconnected_empty
    · rw [hPo i hia hig]; exact X.hC.isPreconnected r hr₀ i
  · intro i i' hii'
    by_cases hia : i = BranchGerms.idx s a
    · subst hia
      rw [hPa]
      by_cases hig : i' ∈ BranchGerms.gapGerm s a b
      · rw [hPg i' hig]; exact disjoint_empty _
      · rw [hPo i' (Ne.symm hii') hig]; exact hchain_sec i' (Ne.symm hii') hig
    by_cases hig : i ∈ BranchGerms.gapGerm s a b
    · rw [hPg i hig]; exact empty_disjoint _
    rw [hPo i hia hig]
    by_cases hia' : i' = BranchGerms.idx s a
    · subst hia'; rw [hPa]; exact (hchain_sec i hia hig).symm
    by_cases hig' : i' ∈ BranchGerms.gapGerm s a b
    · rw [hPg i' hig']; exact disjoint_empty _
    · rw [hPo i' hia' hig']; exact X.hC.disjoint r hr₀ i i' hii'
  · intro i _
    by_cases hia : i = BranchGerms.idx s a
    · rw [hia, hPa]; exact closure_mono (sector_subset_chain le_rfl hab.le) (X.hC.mem_closure_sector hr₀ _)
    by_cases hig : i ∈ BranchGerms.gapGerm s a b
    · rw [hPg i hig] at *; exact absurd ‹(∅ : Set ℂ).Nonempty› Set.not_nonempty_empty
    · rw [hPo i hia hig]; exact X.hC.mem_closure_sector hr₀ i
  · intro i z hz
    show X.G.mergeCol v X.col F.col s a b c ρ z = colA i
    by_cases hia : i = BranchGerms.idx s a
    · rw [hia, hPa] at hz
      simp only [hcolA, hia, if_true]
      rcases mem_chain.mp hz with hz' | ⟨m', h1, h2, ⟨t, ht, rfl⟩ | hz'⟩
      · rw [mergeCol_of_mem_sector h (sector_mono hrρ _ hz')]; split_ifs <;> [rfl; exact hca]
      · rw [mergeCol_branchPt h _ ⟨ht.1, by linarith [ht.2]⟩, if_pos ⟨⟨m', h1, h2, rfl⟩, by linarith [ht.2, hr.2]⟩]
      · rw [mergeCol_of_mem_sector h (sector_mono hrρ _ hz')]
        split_ifs with hg
        · rfl
        · rcases eq_or_lt_of_le h2 with h2 | h2
          · rw [h2, hcb]
          · exact absurd ⟨⟨m', h1, h2, rfl⟩, by linarith [(norm_of_mem_sector hz').2, hr.2]⟩ hg
    by_cases hig : i ∈ BranchGerms.gapGerm s a b
    · rw [hPg i hig] at hz; exact absurd hz (notMem_empty z)
    · rw [hPo i hia hig] at hz
      simp only [hcolA, if_neg hia]
      rw [mergeCol_of_mem_sector h (sector_mono hrρ _ hz),
        if_neg (fun hg => hig (by obtain ⟨m', h1, h2, he⟩ := hg.1; exact ⟨m', h1, h2.le, he⟩))]

/-- **The colours at a rim point** after MERGE are `F`'s there: near the rim the new colouring is `F`'s on `F`'s interior points, and a
cut phantom branch takes the colour of the sector after its germ, in whose closure it lies. -/
theorem merge_coloursAt_rim {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (hn : 0 < X.n) {x : ℂ}
    (hx : x ∈ sphere v ρ) :
    (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).coloursAt x ⊆
      F.coloursAt x := by
  intro j hj
  have hj : x ∈ closure ((F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf
    hlc).region j) := hj
  have hxU : x ∈ (closedBall v (ρ / 2))ᶜ := by
    rw [mem_compl_iff, mem_closedBall, not_le, mem_sphere.mp hx]; linarith [h.1]
  have key : (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).region j ∩
      (closedBall v (ρ / 2))ᶜ ⊆ closure (F.region j) := by
    rintro z ⟨⟨hzI, hzj⟩, hzc⟩
    have hzj' : X.G.mergeCol v X.col F.col s a b c ρ z = j := hzj
    rw [mem_compl_iff, mem_closedBall, not_le] at hzc
    rcases lt_trichotomy (dist z v) ρ with hlt | heq | hgt
    · have hzv : z ≠ v := fun hzv => by rw [hzv, dist_self] at hzc; linarith [h.1]
      have hzn : ρ / 2 < ‖z - v‖ := by rw [← dist_eq_norm]; exact hzc
      rcases ball_cases h hn hlt hzv with ⟨i, hi⟩ | ⟨j', t, ht, rfl⟩
      · rw [mergeCol_of_mem_sector h hi, if_neg (fun h1 => (not_lt.mpr hzn.le) h1.2)] at hzj'
        exact subset_closure (hzj' ▸ X.hcol i ρ h.mem_Ioc hi)
      · rw [norm_branchPt_sub v _ _ ht.1.le] at hzn
        rw [mergeCol_branchPt h j' ht, if_neg (fun h1 => (not_lt.mpr hzn.le) h1.2)] at hzj'
        exact hzj' ▸ cutSet_subset_closure h ⟨t, ht, rfl⟩
    · have hzF := mem_interiorPts_of_merge_rim h' hρρ' heq hzI
      rw [mergeCol_of_not_mem h (by rw [mem_ball, heq]; exact lt_irrefl ρ)] at hzj'
      exact subset_closure ⟨hzF, hzj'⟩
    · have hzc' : z ∉ closedBall v ρ := by rw [mem_closedBall, not_le]; exact hgt
      have hzF : z ∈ F.interiorPts :=
        ((merge_agreesOff (X := X) (s := s) (a := a) (b := b) (c := c) (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf)
          (hlc := hlc) h).2 z hzc').1.mpr hzI
      rw [mergeCol_of_not_mem h (fun hb => hzc' (ball_subset_closedBall hb))] at hzj'
      exact subset_closure ⟨hzF, hzj'⟩
  have : x ∈ closure (((F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf
      hlc).region j) ∩ (closedBall v (ρ / 2))ᶜ) := by
    rw [mem_closure_iff_nhds] at hj ⊢
    intro t ht
    obtain ⟨y, hyt, hy⟩ := hj (t ∩ (closedBall v (ρ / 2))ᶜ) (inter_mem ht (isClosed_closedBall.isOpen_compl.mem_nhds hxU))
    exact ⟨y, hyt.1, hy, hyt.2⟩
  exact closure_minimal key isClosed_closure this

/-- **At most three colours at a rim point** after MERGE (at most two, as for `F`). -/
theorem merge_ncard_coloursAt_rim {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (hn : 0 < X.n) {x : ℂ}
    (hx : x ∈ sphere v ρ) :
    ((F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).coloursAt x).ncard
      ≤ 3 := by
  have hxv : x ≠ v := fun hxv => by rw [hxv, mem_sphere, dist_self] at hx; linarith [h.1]
  have hxs : x ∈ ball v X.s₀ := by rw [mem_ball, mem_sphere.mp hx]; exact h.2.1
  exact (ncard_le_ncard (merge_coloursAt_rim h' hρρ' h hn hx) (toFinite _)).trans
    ((X.hC.ncard_coloursAt_le_two X.hs₀ X.hdisj hxv hxs).trans (by norm_num))

end Surgery

end Near

end ArcMap

end HadwigerNelson.Plane

/-! ## FS131-IMM4: the rim clause — the sides lemma and the new map near a rim point (record § 8.2 item 1) -/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- **The height above the tangent circle along a segment**: `tanHeight κ` in plane coordinates is a quadratic with Hessian `−κ`. -/
theorem tanHeight_combo (κ : ℝ) (y z : ℂ) (t : ℝ) :
    tanHeight κ ((1 - t) • y + t • z).re ((1 - t) • y + t • z).im =
      (1 - t) * tanHeight κ y.re y.im + t * tanHeight κ z.re z.im + κ / 2 * t * (1 - t) * ‖y - z‖ ^ 2 := by
  rw [Complex.sq_norm, Complex.normSq_apply]
  simp only [tanHeight, Complex.add_re, Complex.add_im, Complex.smul_re, Complex.smul_im, Complex.sub_re, Complex.sub_im,
    smul_eq_mul]
  ring

/-- The inequality behind a side's star: the height at a point of the segment from the star's centre stays positive. -/
theorem side_ineq {b r K D S0 Sz : ℝ} (hb0 : 0 ≤ b) (hb1 : b ≤ 1) (hr : 0 < r) (hK : 0 ≤ K) (hKr : K * r ≤ 2 / 5)
    (hS0 : r / 2 - K * r ^ 2 / 8 ≤ S0) (hSz : 0 < Sz) (hD : D ≤ 9 * r ^ 2 / 4) :
    0 < (1 - b) * S0 + b * Sz - K / 2 * b * (1 - b) * D := by
  have hbD : b * D ≤ 9 * r ^ 2 / 4 := by nlinarith
  have h1 : K / 2 * b * (1 - b) * D ≤ (1 - b) * (9 / 8 * K * r ^ 2) := by
    have h2 : 0 ≤ K * (1 - b) := mul_nonneg hK (by linarith)
    nlinarith
  have h3 : 5 / 4 * K * r ^ 2 ≤ r / 2 := by nlinarith
  rcases eq_or_lt_of_le hb0 with hb | hb
  · subst hb; nlinarith
  · nlinarith [mul_pos hb hSz]


/-- **A side of a tangent circle inside a small ball is preconnected** (in plane coordinates): for `w₀` on the circle of curvature `κ`
through `0` (`tanHeight κ = 0`) and `|κ| r ≤ 2/5`, each side `{σ · tanHeight > 0}` of it inside `B(w₀, r)` is star-convex about the
point at distance `r/2` from `w₀` along its normal, on that side — one argument for both sides and every sign of `κ`. -/
theorem isPreconnected_side_plane {κ σ r : ℝ} {w₀ : ℂ} (hT : tanHeight κ w₀.re w₀.im = 0) (hσ : σ = 1 ∨ σ = -1) (hr : 0 < r)
    (hκr : |κ| * r ≤ 2 / 5) : IsPreconnected {w : ℂ | w ∈ ball w₀ r ∧ 0 < σ * tanHeight κ w.re w.im} := by
  set u := σ * r / 2 with hu
  have hσ2 : σ ^ 2 = 1 := by rcases hσ with rfl | rfl <;> norm_num
  have hσκ : -|κ| ≤ σ * κ ∧ σ * κ ≤ |κ| := by
    rcases hσ with rfl | rfl
    · simp only [one_mul]; exact ⟨neg_abs_le κ, le_abs_self κ⟩
    · constructor <;> [linarith [le_abs_self κ]; linarith [neg_abs_le κ]]
  set y₀ : ℂ := ⟨w₀.re * (1 - u * κ), w₀.im + u * (1 - κ * w₀.im)⟩ with hy₀
  have hT' : w₀.im - κ * (w₀.re ^ 2 + w₀.im ^ 2) / 2 = 0 := hT
  have hdist : ‖y₀ - w₀‖ = r / 2 := by
    have h2 : ‖y₀ - w₀‖ ^ 2 = (r / 2) ^ 2 := by
      rw [Complex.sq_norm, Complex.normSq_apply]
      simp only [hy₀, Complex.sub_re, Complex.sub_im]
      have : u ^ 2 = (r / 2) ^ 2 := by rw [hu]; nlinarith [hσ2]
      linear_combination (-(2 * κ * u ^ 2)) * hT' + this
    exact (sq_eq_sq₀ (norm_nonneg _) (by linarith)).mp h2
  have hTy : σ * tanHeight κ y₀.re y₀.im = r / 2 - σ * κ * r ^ 2 / 8 := by
    have h1 : tanHeight κ y₀.re y₀.im = u - κ * u ^ 2 / 2 := by
      simp only [tanHeight, hy₀]
      linear_combination (1 - u * κ) ^ 2 * hT'
    rw [h1, hu]
    have : σ * (σ * r / 2 - κ * (σ * r / 2) ^ 2 / 2) = σ ^ 2 * (r / 2) - σ * σ ^ 2 * κ * r ^ 2 / 8 := by ring
    rw [this, hσ2]; ring
  have hy₀S : y₀ ∈ {w : ℂ | w ∈ ball w₀ r ∧ 0 < σ * tanHeight κ w.re w.im} := by
    refine ⟨by rw [mem_ball, dist_eq_norm, hdist]; linarith, ?_⟩
    rw [hTy]
    have : σ * κ * r ^ 2 / 8 ≤ |κ| * r ^ 2 / 8 := by nlinarith [hσκ.2]
    nlinarith
  have hstar : StarConvex ℝ y₀ {w : ℂ | w ∈ ball w₀ r ∧ 0 < σ * tanHeight κ w.re w.im} := by
    intro z hz a b ha hb hab
    refine ⟨(convex_ball w₀ r) hy₀S.1 hz.1 ha hb hab, ?_⟩
    obtain rfl : a = 1 - b := by linarith
    rw [tanHeight_combo]
    have hyz : ‖y₀ - z‖ < 3 * r / 2 := by
      have := norm_sub_le_norm_sub_add_norm_sub y₀ w₀ z
      have hz' : ‖w₀ - z‖ < r := by rw [← dist_eq_norm, dist_comm]; exact hz.1
      linarith
    have hD : ‖y₀ - z‖ ^ 2 ≤ 9 * r ^ 2 / 4 := by nlinarith [norm_nonneg (y₀ - z)]
    have hS0 : r / 2 - |κ| * r ^ 2 / 8 ≤ σ * tanHeight κ y₀.re y₀.im := by rw [hTy]; nlinarith [hσκ.2]
    have hmain := side_ineq hb (by linarith) hr (abs_nonneg κ) hκr hS0 hz.2 hD
    have hlow : -(|κ| / 2 * b * (1 - b) * ‖y₀ - z‖ ^ 2) ≤ σ * (κ / 2 * b * (1 - b) * ‖y₀ - z‖ ^ 2) := by
      have hnn : 0 ≤ b * (1 - b) * ‖y₀ - z‖ ^ 2 := mul_nonneg (mul_nonneg hb (by linarith)) (sq_nonneg _)
      nlinarith [hσκ.1]
    nlinarith
  exact (hstar.isPathConnected hy₀S).isConnected.isPreconnected


/-- The frame along `e β` at `v` reads `v + w e β` as `w`. -/
theorem frame_mul_e (v : ℂ) (β : ℝ) (w : ℂ) : (v + w * e β - v) * starRingEnd ℂ (e β) = w := by
  rw [add_sub_cancel_left, mul_assoc, e_mul_conj_e, mul_one]

/-- **A side of a germ's tangent circle inside a small ball is preconnected**: for `x` on the circle of curvature `κ` tangent to
`e β` at `v` and `|κ| r ≤ 2/5`, each side `{σ · tanHeight > 0}` of it inside `B(x, r)` is preconnected (the plane form, moved by the
frame's isometry). -/
theorem isPreconnected_side (v : ℂ) (β κ : ℝ) {σ r : ℝ} {x : ℂ} (hT : tanHeight κ (frameX v β x) (frameY v β x) = 0)
    (hσ : σ = 1 ∨ σ = -1) (hr : 0 < r) (hκr : |κ| * r ≤ 2 / 5) :
    IsPreconnected {z : ℂ | z ∈ ball x r ∧ 0 < σ * tanHeight κ (frameX v β z) (frameY v β z)} := by
  set Φ : ℂ → ℂ := fun z => (z - v) * starRingEnd ℂ (e β) with hΦ
  have hW := isPreconnected_side_plane (w₀ := Φ x) hT hσ hr hκr
  have hx : x = v + Φ x * e β := by
    simp only [hΦ]; rw [mul_assoc, mul_comm (starRingEnd ℂ (e β)), e_mul_conj_e, mul_one]; ring
  have heq : {z : ℂ | z ∈ ball x r ∧ 0 < σ * tanHeight κ (frameX v β z) (frameY v β z)} =
      (fun w => v + w * e β) '' {w : ℂ | w ∈ ball (Φ x) r ∧ 0 < σ * tanHeight κ w.re w.im} := by
    ext z
    constructor
    · rintro ⟨hz, hzT⟩
      refine ⟨Φ z, ⟨?_, hzT⟩, ?_⟩
      · rw [mem_ball, dist_eq_norm, show Φ z - Φ x = (z - x) * starRingEnd ℂ (e β) by simp only [hΦ]; ring, norm_mul,
          Complex.norm_conj, norm_e, mul_one, ← dist_eq_norm]; exact hz
      · show v + (z - v) * starRingEnd ℂ (e β) * e β = z
        rw [mul_assoc, mul_comm (starRingEnd ℂ (e β)), e_mul_conj_e, mul_one]; ring
    · rintro ⟨w, ⟨hw, hwT⟩, rfl⟩
      have hfr : (v + w * e β - v) * starRingEnd ℂ (e β) = w := frame_mul_e v β w
      refine ⟨?_, ?_⟩
      · rw [mem_ball, dist_eq_norm]
        conv_lhs => rw [hx]
        rw [show v + w * e β - (v + Φ x * e β) = (w - Φ x) * e β by ring, norm_mul, norm_e, mul_one, ← dist_eq_norm]
        exact hw
      · show 0 < σ * tanHeight κ ((v + w * e β - v) * starRingEnd ℂ (e β)).re ((v + w * e β - v) * starRingEnd ℂ (e β)).im
        rw [hfr]; exact hwT
  rw [heq]
  exact hW.image _ (by fun_prop)


/-- **Two open pieces covered by two preconnected sides are the sides**: if disjoint, open, non-empty `A` and `B` have the union of
two preconnected sets `P` and `Q`, then each of `A`, `B` is one of `P`, `Q`, so both are preconnected. -/
theorem isPreconnected_of_two_sides {A B P Q : Set ℂ} (hA : IsOpen A) (hB : IsOpen B) (hAB : Disjoint A B)
    (hAn : A.Nonempty) (hBn : B.Nonempty) (hP : IsPreconnected P) (hQ : IsPreconnected Q) (hPQ : A ∪ B = P ∪ Q) :
    IsPreconnected A ∧ IsPreconnected B := by
  have hPs : P ⊆ A ∪ B := hPQ ▸ subset_union_left
  have hQs : Q ⊆ A ∪ B := hPQ ▸ subset_union_right
  have key : ∀ {Y Z : Set ℂ}, Y ⊆ A → Z ⊆ B → A ∪ B = Y ∪ Z → A = Y ∧ B = Z := by
    intro Y Z hY hZ hYZ
    constructor
    · refine Subset.antisymm (fun z hz => ?_) hY
      rcases (hYZ ▸ Or.inl hz : z ∈ Y ∪ Z) with h | h
      · exact h
      · exact absurd (hZ h) (disjoint_left.mp hAB hz)
    · refine Subset.antisymm (fun z hz => ?_) hZ
      rcases (hYZ ▸ Or.inr hz : z ∈ Y ∪ Z) with h | h
      · exact absurd (hY h) (disjoint_right.mp hAB hz)
      · exact h
  rcases hP.subset_or_subset hA hB hAB hPs with hPA | hPB <;>
    rcases hQ.subset_or_subset hA hB hAB hQs with hQA | hQB
  · exfalso
    obtain ⟨z, hz⟩ := hBn
    rcases (hPQ ▸ Or.inr hz : z ∈ P ∪ Q) with h | h
    · exact disjoint_left.mp hAB (hPA h) hz
    · exact disjoint_left.mp hAB (hQA h) hz
  · obtain ⟨h1, h2⟩ := key hPA hQB hPQ; exact ⟨h1 ▸ hP, h2 ▸ hQ⟩
  · obtain ⟨h1, h2⟩ := key hQA hPB (by rw [hPQ, union_comm]); exact ⟨h1 ▸ hQ, h2 ▸ hP⟩
  · exfalso
    obtain ⟨z, hz⟩ := hAn
    rcases (hPQ ▸ Or.inl hz : z ∈ P ∪ Q) with h | h
    · exact disjoint_right.mp hAB (hPB h) hz
    · exact disjoint_right.mp hAB (hQB h) hz

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ} {X : F.Near v}

/-- **The sides lemma** (record § 5.2, § 8.2 item 1): near a germ's point at a small distance `ρ`, the two chart sectors beside the
germ, cut down to a small ball about the point, are preconnected — each is one side of the germ's tangent circle in the ball
(`isPreconnected_side`), since the circle meets the ball in the branch only (`eq_branchPt_of_tanHeight_eq_zero`). -/
theorem sides_preconnected {ρ ρ' : ℝ} (h' : X.Small ρ') (hρ0 : 0 < ρ) (hρρ' : ρ < ρ') {p j : Fin X.n}
    (hpj : BranchGerms.next p = j) (hpj' : p ≠ j) :
    ∃ ε > 0, ∀ r ∈ Ioo 0 ε,
      IsPreconnected (X.G.sector v ρ' p ∩ ball (branchPt v (X.G.β j) (X.G.κ j) ρ) r) ∧
        IsPreconnected (X.G.sector v ρ' j ∩ ball (branchPt v (X.G.β j) (X.G.κ j) ρ) r) := by
  set β := X.G.β j with hβ
  set κ := X.G.κ j with hκ
  set x := branchPt v β κ ρ with hx
  have hxv : dist x v = ρ := by rw [dist_eq_norm]; exact norm_branchPt_sub v β κ hρ0.le
  have hcurv : |κ| * ρ' ≤ 2 := h'.curv j
  have hcurv' : |κ| * ρ < 2 :=
    lt_of_le_of_lt (mul_le_mul_of_nonneg_left (hρρ'.trans h'.lt_r₀).le (abs_nonneg κ)) (X.hC.curv j)
  obtain ⟨ε₁, hε₁, hball⟩ := X.hC.exists_ball_subset_of_branchPt X.hs₀.2 X.hdisj (r := ρ') ⟨h'.1, h'.2.1.le⟩ (p := p)
    ⟨hρ0, hρρ'⟩
  rw [hpj] at hball
  have hX0 : 0 < frameX v β x := frameX_branchPt_pos v β κ hcurv' hρ0
  have hcont : Continuous (frameX v β) := by unfold frameX; fun_prop
  obtain ⟨ε₂, hε₂, hX⟩ := Metric.isOpen_iff.mp (isOpen_lt continuous_const hcont) x hX0
  have hε₃ : 0 < ρ' - ρ := by linarith
  have hε₄ : 0 < 2 / 5 / (|κ| + 1) := by positivity
  refine ⟨min (min ε₁ ε₂) (min (ρ' - ρ) (2 / 5 / (|κ| + 1))), lt_min (lt_min hε₁ hε₂) (lt_min hε₃ hε₄), fun r hr => ?_⟩
  have hr1 : r < ε₁ := hr.2.trans_le ((min_le_left _ _).trans (min_le_left _ _))
  have hr2 : r < ε₂ := hr.2.trans_le ((min_le_left _ _).trans (min_le_right _ _))
  have hr3 : r < ρ' - ρ := hr.2.trans_le ((min_le_right _ _).trans (min_le_left _ _))
  have hr4 : r < 2 / 5 / (|κ| + 1) := hr.2.trans_le ((min_le_right _ _).trans (min_le_right _ _))
  have hκr : |κ| * r ≤ 2 / 5 := by
    rw [lt_div_iff₀ (by positivity)] at hr4
    nlinarith [abs_nonneg κ, hr.1]
  have hB : ball x r ⊆ X.G.sector v ρ' p ∪ X.G.sector v ρ' j ∪ branchPt v β κ '' Ioo 0 ρ' :=
    (ball_subset_ball hr1.le).trans hball
  have hBX : ∀ z ∈ ball x r, 0 < frameX v β z := fun z hz => hX (ball_subset_ball hr2.le hz)
  have hBv : ∀ z ∈ ball x r, ‖z - v‖ < ρ' := fun z hz => by
    rw [← dist_eq_norm]
    have := dist_triangle z x v
    rw [mem_ball] at hz
    linarith
  have hTx : tanHeight κ (frameX v β x) (frameY v β x) = 0 := by
    rw [hx, tanHeight_branchPt v β κ κ hcurv'.le hρ0.le]; ring
  have hbr : ∀ z ∈ branchPt v β κ '' Ioo 0 ρ', tanHeight κ (frameX v β z) (frameY v β z) = 0 := by
    rintro z ⟨t, ht, rfl⟩
    rw [tanHeight_branchPt v β κ κ ((mul_le_mul_of_nonneg_left ht.2.le (abs_nonneg κ)).trans hcurv) ht.1.le]; ring
  have hT0 : ∀ z ∈ ball x r, tanHeight κ (frameX v β z) (frameY v β z) = 0 → z ∈ branchPt v β κ '' Ioo 0 ρ' := by
    intro z hz h0
    have hzv : z ≠ v := fun he => by have := hBX z hz; rw [he, frameX_self] at this; exact lt_irrefl 0 this
    refine ⟨‖z - v‖, ⟨norm_pos_iff.mpr (sub_ne_zero.mpr hzv), hBv z hz⟩, ?_⟩
    exact (eq_branchPt_of_tanHeight_eq_zero (hBX z hz) h0
      ((mul_le_mul_of_nonneg_left (hBv z hz).le (abs_nonneg κ)).trans hcurv)).symm
  have hP := isPreconnected_side v β κ hTx (Or.inl rfl) hr.1 hκr
  have hQ := isPreconnected_side v β κ hTx (Or.inr rfl) hr.1 hκr
  have hmem : ∀ i, ∀ z ∈ X.G.sector v ρ' i, z ∉ branchPt v β κ '' Ioo 0 ρ' := fun i z hz =>
    not_mem_branch_of_mem_sector h' hz j
  refine isPreconnected_of_two_sides ((X.hC.isOpen ρ' h'.mem_Ioc p).inter isOpen_ball)
    ((X.hC.isOpen ρ' h'.mem_Ioc j).inter isOpen_ball)
    ((X.hC.disjoint ρ' h'.mem_Ioc p j hpj').mono inter_subset_left inter_subset_left) ?_ ?_ hP hQ ?_
  · have hcl := IsSectorChart.branchPt_mem_closure_sector_before (v := v) X.hord h'.2.1.le p ⟨hρ0, hρρ'⟩
    rw [hpj] at hcl
    obtain ⟨z, hz⟩ := mem_closure_iff.mp hcl (ball x r) isOpen_ball (mem_ball_self hr.1)
    exact ⟨z, hz.2, hz.1⟩
  · have hcl := IsSectorChart.branchPt_mem_closure_sector_after (v := v) X.hord h'.2.1.le j ⟨hρ0, hρρ'⟩
    obtain ⟨z, hz⟩ := mem_closure_iff.mp hcl (ball x r) isOpen_ball (mem_ball_self hr.1)
    exact ⟨z, hz.2, hz.1⟩
  · ext z
    constructor
    · rintro (⟨hzs, hz⟩ | ⟨hzs, hz⟩)
      · have hne : tanHeight κ (frameX v β z) (frameY v β z) ≠ 0 := fun h0 => hmem p z hzs (hT0 z hz h0)
        rcases lt_or_gt_of_ne hne with h | h
        · exact Or.inr ⟨hz, by linarith⟩
        · exact Or.inl ⟨hz, by linarith⟩
      · have hne : tanHeight κ (frameX v β z) (frameY v β z) ≠ 0 := fun h0 => hmem j z hzs (hT0 z hz h0)
        rcases lt_or_gt_of_ne hne with h | h
        · exact Or.inr ⟨hz, by linarith⟩
        · exact Or.inl ⟨hz, by linarith⟩
    · rintro (⟨hz, hzT⟩ | ⟨hz, hzT⟩)
      · rcases hB hz with (h | h) | h
        · exact Or.inl ⟨h, hz⟩
        · exact Or.inr ⟨h, hz⟩
        · have := hbr z h; rw [this] at hzT; linarith
      · rcases hB hz with (h | h) | h
        · exact Or.inl ⟨h, hz⟩
        · exact Or.inr ⟨h, hz⟩
        · have := hbr z h; rw [this] at hzT; linarith


/-- **At most one sector of each colour** where the interior points of the ball are preconnected (every sector is their component,
so the whole set). -/
theorem _root_.HadwigerNelson.Plane.ArcMap.encard_sectorsOf_le_one {G : ArcMap k} {x : ℂ} {r : ℝ}
    (hP : IsPreconnected (G.interiorPts ∩ ball x r)) (c' : Fin k) : (G.sectorsOf x r c').encard ≤ 1 := by
  rw [Set.encard_le_one_iff]
  rintro S S' ⟨⟨y, hy, rfl, -⟩, -⟩ ⟨⟨y', hy', rfl, -⟩, -⟩
  rw [hP.connectedComponentIn hy, hP.connectedComponentIn hy']

/-- The rim arc lies on the circle of radius `ρ/2`. -/
theorem norm_of_mem_rimArc {ρ : ℝ} (h : X.Small ρ) {s : Fin X.n} {a b : ℕ} {z : ℂ}
    (hz : z ∈ (X.G.rimArc v s a b ρ).carrier) : ‖z - v‖ = ρ / 2 := by
  obtain ⟨θ, -, rfl⟩ := hz
  rw [add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg (by linarith [h.1])]

/-- **MERGE's colour of a sector point off `B̄(v, ρ/2)`** (out to a small `ρ' > ρ`) is the sector's colour. -/
theorem mergeCol_of_mem_sector_out {ρ ρ' : ℝ} (h' : X.Small ρ') (h : X.Small ρ) {s : Fin X.n} {a b : ℕ} {c : Fin k} {i : Fin X.n}
    {z : ℂ} (hz : z ∈ X.G.sector v ρ' i) (hzr : ρ / 2 < ‖z - v‖) : X.G.mergeCol v X.col F.col s a b c ρ z = X.col i := by
  by_cases hzb : z ∈ ball v ρ
  · have hz' := mem_sector_of_lt hz (by rwa [mem_ball, dist_eq_norm] at hzb)
    rw [mergeCol_of_mem_sector h hz', if_neg (fun h1 => (not_lt.mpr hzr.le) h1.2)]
  · rw [mergeCol_of_not_mem h hzb]; simpa using (X.hcol i ρ' h'.mem_Ioc hz).2

variable {s : Fin X.n} {a b : ℕ}

section Surgery

variable {c : Fin k} {ρ : ℝ} {hv : v ∈ F.dom} {hρ : 0 < ρ} {hA : ∀ A ∈ X.G.mergeArcs v X.col s a b ρ, A.Nondegenerate}
  {hAf : (X.G.mergeArcs v X.col s a b ρ).Finite}
  {hlc : ∀ x ∈ F.dom, x ∉ ⋃ A ∈ F.trimArcs v ρ ∪ X.G.mergeArcs v X.col s a b ρ, A.carrier →
    ∀ᶠ y in 𝓝 x, X.G.mergeCol v X.col F.col s a b c ρ y = X.G.mergeCol v X.col F.col s a b c ρ x}

/-- **An interior point of `F` off the rim arc is interior to MERGE's map**: the new map's arcs are `F`'s trimmed arcs, germ arcs of
`F`, and the rim arc. -/
theorem mem_merge_interiorPts_of_mem (h : X.Small ρ) {z : ℂ} (hz : z ∈ F.interiorPts)
    (hzr : z ∉ (X.G.rimArc v s a b ρ).carrier) :
    z ∈ (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).interiorPts := by
  refine ⟨hz.1, fun hzA => ?_⟩
  obtain ⟨B, hB, hzB⟩ := mem_iUnion₂.mp hzA
  rcases hB with hB | hB
  · obtain ⟨-, a', ha', hsub, -⟩ := (F.trimArcs_spec hv hρ).1 B hB
    exact hz.2 (mem_iUnion₂.mpr ⟨a', ha', hsub hzB⟩)
  · rcases mergeArcs_cases h hB with ⟨j, hj⟩ | ⟨-, rfl⟩
    · exact hz.2 (germ_subset_Γ h j (hj hzB)).2
    · exact hzr hzB

/-- **A germ's point between `ρ/2` and a small `ρ' > ρ` is interior to MERGE's map** exactly when it is inside `ρ` on a phantom germ
(the phantom germs are cut in the annulus; a germ's rim point is on the trimmed arcs; beyond `ρ` the map is `F`). -/
theorem branchPt_mem_merge_interiorPts_iff {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (j : Fin X.n) {t : ℝ}
    (ht : t ∈ Ioo (ρ / 2) ρ') :
    branchPt v (X.G.β j) (X.G.κ j) t ∈
        (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).interiorPts ↔
      t < ρ ∧ BranchGerms.Phantom X.col j := by
  have ht0 : 0 < t := by linarith [ht.1, h.1]
  have hdist : dist (branchPt v (X.G.β j) (X.G.κ j) t) v = t := dist_branchPt j ht0.le
  constructor
  · intro hzI
    have htρ : t < ρ := by
      by_contra hge
      rcases eq_or_lt_of_le (not_lt.mp hge) with heq | hgt
      · obtain ⟨B, hB, hzB⟩ := mem_iUnion₂.mp (branchPt_rim_mem_trimArcs h' hρ hρρ' j)
        rw [heq] at hzB
        exact hzI.2 (mem_iUnion₂.mpr ⟨B, Or.inl hB, hzB⟩)
      · have hzc : branchPt v (X.G.β j) (X.G.κ j) t ∉ closedBall v ρ := by
          rw [mem_closedBall, hdist, not_le]; exact hgt
        have hzF := ((merge_agreesOff (X := X) (s := s) (a := a) (b := b) (c := c) (hv := hv) (hρ := hρ) (hA := hA)
          (hAf := hAf) (hlc := hlc) h).2 _ hzc).1.mpr hzI
        exact hzF.2 (X.hC.branchPt_mem_Γ j ⟨ht0, ht.2.trans h'.lt_r₀⟩).2
    refine ⟨htρ, ?_⟩
    by_contra hph
    have hzb : branchPt v (X.G.β j) (X.G.κ j) t ∈ ball v ρ := by rw [mem_ball, hdist]; exact htρ
    exact (mem_merge_interiorPts_iff h hzb).mp hzI (branchPt_mem_mergeArcs_outer h hph ⟨ht.1, htρ.le⟩)
  · rintro ⟨htρ, hph⟩
    have hzb : branchPt v (X.G.β j) (X.G.κ j) t ∈ ball v ρ := by rw [mem_ball, hdist]; exact htρ
    refine (mem_merge_interiorPts_iff h hzb).mpr fun hzA => ?_
    obtain ⟨A, hA', hzA'⟩ := mem_iUnion₂.mp hzA
    rcases mem_mergeArcs.mp hA' with ⟨j', -, rfl⟩ | ⟨j', hj', hA''⟩ | ⟨-, rfl⟩
    · rw [carrier_germ h.half] at hzA'
      obtain ⟨t', ht', he⟩ := hzA'
      have := congrArg (fun z => dist z v) he
      simp only [dist_branchPt j' ht'.1, hdist] at this
      linarith [ht'.2, ht.1]
    · obtain ⟨t', ht', he⟩ := outer_subset h j' A hA'' hzA'
      have htt : t' = t := by
        have := congrArg (fun z => dist z v) he
        simp only [dist_branchPt j' (by linarith [ht'.1, h.1] : (0 : ℝ) ≤ t'), hdist] at this
        exact this
      subst htt
      exact hj' ((eq_of_branchPt_eq X.hdisj ⟨ht0, ht.2.trans h'.2.1⟩ he) ▸ hph)
    · have := norm_of_mem_rimArc h hzA'
      rw [← dist_eq_norm, hdist] at this
      linarith [ht.1]

end Surgery

end Near

end ArcMap

end HadwigerNelson.Plane

/-! ## FS131-IMM3: MERGE's two open leaves (record § 8.2 items 1–2) — the assembly in `Moves.exists_merge_aux` reads them -/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ} {X : F.Near v} {s : Fin X.n} {a b : ℕ}

section Surgery

variable {c : Fin k} {ρ : ℝ} {hv : v ∈ F.dom} {hρ : 0 < ρ} {hA : ∀ A ∈ X.G.mergeArcs v X.col s a b ρ, A.Nondegenerate}
  {hAf : (X.G.mergeArcs v X.col s a b ρ).Finite}
  {hlc : ∀ x ∈ F.dom, x ∉ ⋃ A ∈ F.trimArcs v ρ ∪ X.G.mergeArcs v X.col s a b ρ, A.carrier →
    ∀ᶠ y in 𝓝 x, X.G.mergeCol v X.col F.col s a b c ρ y = X.G.mergeCol v X.col F.col s a b c ρ x}

/-- **No repeated colour at a rim point** after MERGE (record § 8.2 item 1: the sides lemma). At a rim point on no germ the new map's
interior points near it are a ball, one sector; on a non-phantom germ they are the two chart sectors beside it (each preconnected,
`sides_preconnected`), of the two colours beside the germ; on a phantom germ, cut inside `ρ`, they are one preconnected set. -/
theorem merge_not_hasRepeatedColour_rim {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (hab : a < b)
    (hbn : b < X.n) {x : ℂ} (hx : x ∈ sphere v ρ) :
    ¬ (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).HasRepeatedColour x := by
  classical
  set F' := F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc with hF'
  have hn : 0 < X.n := by omega
  have hxv : dist x v = ρ := mem_sphere.mp hx
  have hxv' : x ≠ v := fun he => by rw [he, dist_self] at hxv; linarith [h.1]
  suffices hle : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ c', (F'.sectorsOf x r c').encard ≤ 1 by
    rintro ⟨c', hc'⟩
    obtain ⟨r, hr2, hr1⟩ := (hc'.and hle).exists
    have := hr2.trans (hr1 c')
    norm_num at this
  -- a sector point off `B̄(v, ρ/2)` is interior to the new map
  have hsecI : ∀ i, ∀ z ∈ X.G.sector v ρ' i, ρ / 2 < ‖z - v‖ → z ∈ F'.interiorPts := fun i z hz hzr =>
    mem_merge_interiorPts_of_mem h (sector_subset_interiorPts h' i hz)
      (fun hzA => by rw [norm_of_mem_rimArc h hzA] at hzr; exact lt_irrefl _ hzr)
  -- points of a ball of radius `< ρ/2` about `x` are off `B̄(v, ρ/2)`
  have hfar : ∀ r, r ≤ ρ / 2 → ∀ z ∈ ball x r, ρ / 2 < ‖z - v‖ := fun r hr z hz => by
    rw [← dist_eq_norm]
    have := dist_triangle x z v
    rw [mem_ball, dist_comm] at hz
    linarith
  have hnear : ∀ r, r ≤ ρ' - ρ → ∀ z ∈ ball x r, ‖z - v‖ < ρ' := fun r hr z hz => by
    rw [← dist_eq_norm]
    have := dist_triangle z x v
    rw [mem_ball] at hz
    linarith
  by_cases hxI : x ∈ F.interiorPts
  · -- (R1) on no germ: one sector
    obtain ⟨i, hi⟩ : ∃ i, x ∈ X.G.sector v ρ' i := by
      have : x ∈ ball v ρ' ∩ F.interiorPts := ⟨by rw [mem_ball, hxv]; exact hρρ', hxI⟩
      rw [X.hC.cover ρ' h'.mem_Ioc hn] at this
      exact mem_iUnion.mp this
    obtain ⟨ε, hε, hεs⟩ := Metric.isOpen_iff.mp (X.hC.isOpen ρ' h'.mem_Ioc i) x hi
    filter_upwards [Ioo_mem_nhdsGT (lt_min hε (half_pos h.1))] with r hr c'
    have hU : F'.interiorPts ∩ ball x r = ball x r := by
      refine inter_eq_right.mpr fun z hz => hsecI i z (hεs (ball_subset_ball (hr.2.trans_le (min_le_left _ _)).le hz)) ?_
      exact hfar r (hr.2.trans_le (min_le_right _ _)).le z hz
    exact encard_sectorsOf_le_one (by rw [hU]; exact (convex_ball x r).isPreconnected) c'
  · -- on a germ `j`, with `p` the sector before it
    obtain ⟨j, hj⟩ := X.hC.exists_branchPt_eq hxv' (by rw [mem_ball, hxv]; exact hρρ'.trans h'.lt_r₀) hxI
    rw [← dist_eq_norm, hxv] at hj
    subst hj
    obtain ⟨p, hpj⟩ := exists_next_eq j
    have hpj' : p ≠ j := by
      intro he
      have h1 : BranchGerms.next (BranchGerms.idx p 0) = BranchGerms.idx p 1 := BranchGerms.next_idx p 0
      rw [BranchGerms.idx_zero, hpj, ← he] at h1
      exact BranchGerms.idx_ne (s := p) (show 0 < 1 by omega) (show 1 < 0 + X.n by omega) (by rw [BranchGerms.idx_zero]; exact h1)
    obtain ⟨ε, hε, hside⟩ := sides_preconnected h' h.1 hρρ' hpj hpj'
    obtain ⟨ε₁, hε₁, hball⟩ := X.hC.exists_ball_subset_of_branchPt X.hs₀.2 X.hdisj (r := ρ') ⟨h'.1, h'.2.1.le⟩ (p := p)
      ⟨h.1, hρρ'⟩
    rw [hpj] at hball
    have hpos : 0 < min (min ε ε₁) (min (ρ / 2) (ρ' - ρ)) :=
      lt_min (lt_min hε hε₁) (lt_min (half_pos h.1) (sub_pos.mpr hρρ'))
    filter_upwards [Ioo_mem_nhdsGT hpos] with r hr c'
    have hrε : r < ε := hr.2.trans_le ((min_le_left _ _).trans (min_le_left _ _))
    have hrε₁ : r < ε₁ := hr.2.trans_le ((min_le_left _ _).trans (min_le_right _ _))
    have hrρ : r ≤ ρ / 2 := (hr.2.trans_le ((min_le_right _ _).trans (min_le_left _ _))).le
    have hrρ' : r ≤ ρ' - ρ := (hr.2.trans_le ((min_le_right _ _).trans (min_le_right _ _))).le
    set x := branchPt v (X.G.β j) (X.G.κ j) ρ with hx
    have hB : ball x r ⊆ X.G.sector v ρ' p ∪ X.G.sector v ρ' j ∪ branchPt v (X.G.β j) (X.G.κ j) '' Ioo 0 ρ' :=
      (ball_subset_ball hrε₁.le).trans hball
    obtain ⟨hSp, hSj⟩ := hside r ⟨hr.1, hrε⟩
    -- a branch point of the ball is at distance in `(ρ/2, ρ')`
    have hbrt : ∀ t ∈ Ioo 0 ρ', branchPt v (X.G.β j) (X.G.κ j) t ∈ ball x r → t ∈ Ioo (ρ / 2) ρ' := by
      intro t ht hz
      have := hfar r hrρ _ hz
      rw [norm_branchPt_sub v _ _ ht.1.le] at this
      exact ⟨this, ht.2⟩
    -- the ball's points beside the germ, in the sectors, are interior to the new map
    have hSpI : X.G.sector v ρ' p ∩ ball x r ⊆ F'.interiorPts := fun z hz => hsecI p z hz.1 (hfar r hrρ z hz.2)
    have hSjI : X.G.sector v ρ' j ∩ ball x r ⊆ F'.interiorPts := fun z hz => hsecI j z hz.1 (hfar r hrρ z hz.2)
    -- a germ point of the ball is in the closure of the sector after it, inside the ball
    have hclj : ∀ t ∈ Ioo 0 ρ', branchPt v (X.G.β j) (X.G.κ j) t ∈ ball x r →
        branchPt v (X.G.β j) (X.G.κ j) t ∈ closure (X.G.sector v ρ' j ∩ ball x r) := by
      intro t ht hz
      have hcl := IsSectorChart.branchPt_mem_closure_sector_after (v := v) X.hord h'.2.1.le j ht
      rw [inter_comm]; exact isOpen_ball.inter_closure ⟨hz, hcl⟩
    have hclp : ∀ t ∈ Ioo 0 ρ', branchPt v (X.G.β j) (X.G.κ j) t ∈ ball x r →
        branchPt v (X.G.β j) (X.G.κ j) t ∈ closure (X.G.sector v ρ' p ∩ ball x r) := by
      intro t ht hz
      have hcl := IsSectorChart.branchPt_mem_closure_sector_before (v := v) X.hord h'.2.1.le p ht
      rw [hpj] at hcl
      rw [inter_comm]; exact isOpen_ball.inter_closure ⟨hz, hcl⟩
    by_cases hph : BranchGerms.Phantom X.col j
    · -- (R3) a phantom germ, cut inside `ρ`: one sector
      refine encard_sectorsOf_le_one ?_ c'
      obtain ⟨δ, hδ, hδc⟩ := Metric.continuousAt_iff.mp (continuous_branchPt v (X.G.β j) (X.G.κ j)).continuousAt r hr.1
      set t₀ := ρ - min δ (ρ / 2) / 2 with ht₀
      have hm : 0 < min δ (ρ / 2) := lt_min hδ (half_pos h.1)
      have hm' : min δ (ρ / 2) ≤ ρ / 2 := min_le_right _ _
      have ht₀ρ : t₀ < ρ := by linarith
      have ht₀2 : ρ / 2 < t₀ := by linarith
      have hy₀ : branchPt v (X.G.β j) (X.G.κ j) t₀ ∈ ball x r := by
        rw [mem_ball]; refine hδc ?_
        rw [Real.dist_eq, abs_of_neg (by linarith)]; linarith [min_le_left δ (ρ / 2)]
      have ht₀' : t₀ ∈ Ioo 0 ρ' := ⟨by linarith [h.1], ht₀ρ.trans hρρ'⟩
      have hy₀I : branchPt v (X.G.β j) (X.G.κ j) t₀ ∈ F'.interiorPts :=
        (branchPt_mem_merge_interiorPts_iff h' hρρ' h j ⟨ht₀2, ht₀'.2⟩).mpr ⟨ht₀ρ, hph⟩
      set y₀ := branchPt v (X.G.β j) (X.G.κ j) t₀ with hy₀def
      have hS₁ : IsPreconnected (X.G.sector v ρ' p ∩ ball x r ∪ {y₀}) :=
        hSp.subset_closure subset_union_left (union_subset subset_closure (singleton_subset_iff.mpr (hclp t₀ ht₀' hy₀)))
      have hS₂ : IsPreconnected ({y₀} ∪ X.G.sector v ρ' j ∩ ball x r) :=
        hSj.subset_closure subset_union_right (union_subset (singleton_subset_iff.mpr (hclj t₀ ht₀' hy₀)) subset_closure)
      have hS := hS₁.union y₀ (Or.inr rfl) (Or.inl rfl) hS₂
      refine hS.subset_closure ?_ ?_
      · rintro z ((hz | rfl) | (rfl | hz))
        · exact ⟨hSpI hz, hz.2⟩
        · exact ⟨hy₀I, hy₀⟩
        · exact ⟨hy₀I, hy₀⟩
        · exact ⟨hSjI hz, hz.2⟩
      · rintro z ⟨-, hz⟩
        rcases hB hz with (hz' | hz') | ⟨t, ht, rfl⟩
        · exact subset_closure (Or.inl (Or.inl ⟨hz', hz⟩))
        · exact subset_closure (Or.inr (Or.inr ⟨hz', hz⟩))
        · exact closure_mono (subset_union_right.trans subset_union_right) (hclj t ht hz)
    · -- (R2) a non-phantom germ: two sectors, of the two colours beside it
      have hcol : X.col p ≠ X.col j := fun he => hph ⟨p, hpj, he⟩
      have hU : F'.interiorPts ∩ ball x r = ⋃ b' : Bool, cond b' (X.G.sector v ρ' p ∩ ball x r) (X.G.sector v ρ' j ∩ ball x r) := by
        rw [← union_eq_iUnion]
        ext z
        constructor
        · rintro ⟨hzI, hz⟩
          rcases hB hz with (hz' | hz') | ⟨t, ht, rfl⟩
          · exact Or.inl ⟨hz', hz⟩
          · exact Or.inr ⟨hz', hz⟩
          · exact absurd ((branchPt_mem_merge_interiorPts_iff h' hρρ' h j (hbrt t ht hz)).mp hzI).2 hph
        · rintro (hz | hz)
          · exact ⟨hSpI hz, hz.2⟩
          · exact ⟨hSjI hz, hz.2⟩
      rw [encard_sectorsOf_of_partition (colA := fun b' => cond b' (X.col p) (X.col j)) hU ?_ ?_ ?_ ?_ ?_ c']
      · rw [Set.encard_le_one_iff]
        rintro b₁ b₂ ⟨-, h₁⟩ ⟨-, h₂⟩
        cases b₁ <;> cases b₂ <;> simp only [cond_true, cond_false] at h₁ h₂ ⊢
        · exact (hcol (h₂.trans h₁.symm)).elim
        · exact (hcol (h₁.trans h₂.symm)).elim
      · intro b'; cases b'
        · exact (X.hC.isOpen ρ' h'.mem_Ioc j).inter isOpen_ball
        · exact (X.hC.isOpen ρ' h'.mem_Ioc p).inter isOpen_ball
      · intro b'; cases b'
        · exact hSj
        · exact hSp
      · intro b₁ b₂ hb
        have hd := (X.hC.disjoint ρ' h'.mem_Ioc p j hpj').mono (inter_subset_left (t := ball x r))
          (inter_subset_left (t := ball x r))
        cases b₁ <;> cases b₂
        · exact absurd rfl hb
        · exact hd.symm
        · exact hd
        · exact absurd rfl hb
      · intro b' _; cases b'
        · exact hclj ρ ⟨h.1, hρρ'⟩ (mem_ball_self hr.1)
        · exact hclp ρ ⟨h.1, hρρ'⟩ (mem_ball_self hr.1)
      · intro b' z hz; cases b'
        · show X.G.mergeCol v X.col F.col s a b c ρ z = X.col j
          exact mergeCol_of_mem_sector_out h' h hz.1 (hfar r hrρ z hz.2)
        · show X.G.mergeCol v X.col F.col s a b c ρ z = X.col p
          exact mergeCol_of_mem_sector_out h' h hz.1 (hfar r hrρ z hz.2)

/-- **`D_c(v′)` unchanged off `B̄(v, ρ)`** after MERGE (record § 8.2 item 2). **Open leaf**, believed true (IMM1's and IMM2's route, § 5.2):
the contacts agree since the recoloured gap's closure lies in `{v}` and an open set of points clear for `c`; the types agree since a
merged `c`-tile misses `ω(v′)` (the new map is valid, `merge_valid`). -/
theorem merge_allowedCone (hF : F.Valid) (hv1 : F.Covers v 1) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ)
    (hab : a < b) (hbn : b < X.n) (hca : X.col (BranchGerms.idx s a) = c) (hcb : X.col (BranchGerms.idx s b) = c)
    (hgap : ∀ m, a < m → m < b → X.col (BranchGerms.idx s m) ≠ c) {ρc : ℝ} (hρc : ρ ≤ ρc)
    (hgc : ∀ t ∈ Ioo 0 ρc, ∀ φ, X.G.liftDir s (a + 1) t ≤ φ → φ ≤ X.G.liftDir s b t → F.IsClear c (v + (t : ℂ) * e φ)) :
    ∀ v' ∉ closedBall v ρ,
      (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).allowedCone v' c =
        F.allowedCone v' c := by
  sorry

end Surgery

end Near

end ArcMap

end HadwigerNelson.Plane
