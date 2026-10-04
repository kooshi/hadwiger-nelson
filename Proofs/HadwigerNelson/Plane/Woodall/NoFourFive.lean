import Proofs.HadwigerNelson.Plane.Woodall.Collar
import Proofs.HadwigerNelson.Plane.Tiles

/-!
# No point of four or five sectors: FS131-E1's lemmas over arc maps (E1-SEE, E1-RAY, E1-CROSS, E1-COVER, E1-BAD)

FS131-W2's skeleton (`plans/FS131-W-kernel-plan.md` §§ 7–8). FS131-E1 (`plans/FS131-E1-derivation.md` § 3) restores Woodall's Theorem 6 for arc
maps with one lemma in place of his steps 7–8 and of step 5's equality case: **E1-NO45**, no point of four or five sectors in a five-colour valid
map in normal form (`ArcMap.false_of_four_le_sectors`, `Plane/Woodall/Steps`). Its lemmas, read on W's colour-change picture (`ArcMap.SectorsAt`):

* **E1-SEE** (`ArcMap.not_mem_coloursAt_of_dist_eq_one`): a point at distance `1` from an interior point of colour `j` does not carry `j`.
  The robust form (`ArcMap.not_mem_coloursAt_of_collarAt`): a point `v + e ψ` whose inner and outer collars both lie in the shadow of `j`'s class
  does not carry `j`.
* **E1-RAY** (`ArcMap.SectorsAt.collarAt_shadow_inner_of_mem`, `_outer_of_mem`): a sector at `v` holding a direction `γ` with `cos (γ − ψ) < 0`
  (`> 0`) puts an inner (outer) collar about `ψ` in its colour's shadow.
* **E1-CROSS** (`ArcMap.SectorsAt.not_mem_range_of_crossesAt`): a colour whose class reaches `v + e θ` from inside and from outside `ω(v)`
  (`ArcMap.CrossesAt`) is carried by no sector at `v`.
* **E1-COVER** (`ArcMap.SectorsAt.false_of_ncard_le_two_on_arc`), in E1-GEN6's form and read on colour classes (§ 7.3 (a)): at a point whose
  picture has positive angles and at most one colour absent, no open arc of `ω(v)` longer than `π/3` has at most two colours at each of its
  points. Through: the local structure off crossings (`ArcMap.exists_side_colours_of_not_crossesAt`), one colour class along the arc
  (`ArcMap.exists_closure_colour_of_arc`), and the diameter of a connected subset of a closure (`dist_le_one_of_subset_closure`).
* **E1-BAD** (`ArcMap.SectorsAt.exists_two_absent`), corrected (§ 7.4) and in its robust form (§ 7.3 (b)): at a point of `n ≥ 3` sectors of
  distinct colours with angles in `(0, π]`, off at most `n` angles every point `v + e ψ` of `ω(v)` lacks two colours of the picture. Through:
  interior directions (`ArcMap.SectorsAt.not_mem_coloursAt_of_mem_Ioo`), and at each edge **the refined second-order lemma**
  (`ArcMap.SectorsAt.exists_normal_collarAt`: one of the edge's two normals carries an inner collar in the shadow of both adjacent colours),
  from the colour of one tangent parabola, of curvature `1/2` (`ArcMap.SectorsAt.exists_parabola_region`), and its collar
  (`collarAt_shadow_of_parabola`).

E1-NOBRANCH is `ArcMap.exists_three_le_sectors` (`Plane/Woodall/Steps`, over wave 4's `ts_t`): the Jordan curve theorem is not needed (§ 7.5).

**Inhabitants.** `ArcMap.CrossesAt` has its spec example and adversary below. The `SectorsAt` hypotheses with no validity are inhabited by
`ArcMap.const_sectorsAt` (one sector); those over a valid map of the plane with a picture of two or three sectors by `sevenBrickMap`
(`sevenBrickMap_valid`, `sevenBrickMap_isPlaneMap`, `Plane/SVMap`) at a brick corner (three sectors of angles `π`, `π/2`, `π/2`), its picture by
`exists_sectorsAt`; E1-COVER concludes `False` (a refutation).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Region-only tools -/

/-- **A connected subset of the closure of an open set with null unit pairs has every two points at distance at most `1`** (the closure form of
FS106-DIAM; it replaces E1-COVER (d)'s one-region step and E1-NOBRANCH (i)): for `x, y` at distance `> 1`, a point `z ∈ U` near `x` sees the
value `1` of `dist z ·` on the subset (`dist_lt_one_of_isPreconnected`), at a point of `closure U` (`dist_ne_one_of_mem_of_mem_closure`). -/
theorem dist_le_one_of_subset_closure {U S : Set ℂ} (hU : IsOpen U) (hnull : UnitPairsNull U) (hS : IsPreconnected S)
    (hSU : S ⊆ closure U) {x y : ℂ} (hx : x ∈ S) (hy : y ∈ S) : dist x y ≤ 1 := by
  by_contra hgt
  push Not at hgt
  obtain ⟨z, hzU, hxz⟩ := Metric.mem_closure_iff.mp (hSU hx) (min 1 ((dist x y - 1) / 2)) (lt_min one_pos (by linarith))
  have hz1 : dist z x < 1 := by rw [dist_comm]; exact lt_of_lt_of_le hxz (min_le_left _ _)
  have hall := dist_lt_one_of_isPreconnected hS hx hz1 (fun s hs => dist_ne_one_of_mem_of_mem_closure hU hnull hzU (hSU hs))
  have hzy := hall y hy
  have h2 : dist z x < (dist x y - 1) / 2 := by rw [dist_comm]; exact lt_of_lt_of_le hxz (min_le_right _ _)
  have := dist_triangle x z y
  rw [dist_comm x z] at this
  linarith

/-- **Sharpness of `dist_le_one_of_subset_closure`**: the closed disc of radius `1/2` is the closure of an open set with no unit pair, and holds
two points at distance exactly `1` — so `≤ 1` cannot be strengthened to `< 1` (FS106-DIAM's strict form is for the open set itself). -/
example : ∃ x ∈ closure (ball (0 : ℂ) (1 / 2)), ∃ y ∈ closure (ball (0 : ℂ) (1 / 2)), dist x y = 1 := by
  refine ⟨1 / 2, ?_, -1 / 2, ?_, ?_⟩
  · rw [closure_ball _ (by norm_num), mem_closedBall, dist_zero_right]; norm_num
  · rw [closure_ball _ (by norm_num), mem_closedBall, dist_zero_right]; norm_num
  · rw [dist_eq_norm]; norm_num

/-- **A collar about `ψ` holds the inner and outer halves of a small disc about `u + e ψ`.** -/
theorem exists_mem_collar_of_dist_lt (u : ℂ) (ψ : ℝ) {h : ℝ} (hh : 0 < h) :
    ∃ ε > 0, ∀ z, dist z (u + e ψ) < ε →
      (dist z u < 1 → z ∈ collar u .inner (ψ - h) (ψ + h) h) ∧ (1 < dist z u → z ∈ collar u .outer (ψ - h) (ψ + h) h) := by
  have h1 := eventually_abs_arg_lt u ψ one_pos hh
  have h2 := eventually_norm_sub_mem u ψ (isOpen_Ioo (a := 1 - h) (b := 1 + h)) zero_le_one
    (show (1 : ℝ) ∈ Ioo (1 - h) (1 + h) from ⟨by linarith, by linarith⟩)
  obtain ⟨ε, hε, hz⟩ := Metric.eventually_nhds_iff.mp (h1.and h2)
  refine ⟨ε, hε, fun z hzd => ?_⟩
  have hzd' : dist z (u + ((1 : ℝ) : ℂ) * e ψ) < ε := by simpa using hzd
  obtain ⟨ha, hr⟩ := hz hzd'
  have hdz : ‖z - u‖ = dist z u := (dist_eq_norm z u).symm
  rw [hdz] at hr
  have ha' := abs_lt.mp ha
  have hang : ψ + Complex.arg ((z - u) * starRingEnd ℂ (e ψ)) ∈ Ioo (ψ - h) (ψ + h) :=
    ⟨by linarith [ha'.1], by linarith [ha'.2]⟩
  refine ⟨fun hlt => (mem_collar_iff _ _ _ _ _ _).mpr ⟨‖z - u‖, ?_, _, hang, eq_add_norm_mul_e u z ψ⟩,
    fun hgt => (mem_collar_iff _ _ _ _ _ _).mpr ⟨‖z - u‖, ?_, _, hang, eq_add_norm_mul_e u z ψ⟩⟩
  · show ‖z - u‖ ∈ Ioo (1 - h) 1
    rw [hdz]; exact ⟨hr.1, hlt⟩
  · show ‖z - u‖ ∈ Ioo 1 (1 + h)
    rw [hdz]; exact ⟨hgt, hr.2⟩

/-- **At most five angles leave an open arc of length `2π/5` free of them** (mod `2π`): E1-COVER (e)'s count, in the form E1-NO45 consumes
(`2π/5 > π/3`). With one of the angles as the base point, the five arcs `(κ + 2πj/5, κ + 2π(j+1)/5)` miss it and the other four hit at most four. -/
theorem exists_Ioo_avoiding (K : Finset ℝ) (hK : K.card ≤ 5) :
    ∃ θ : ℝ, ∀ κ ∈ K, ∀ m : ℤ, κ + 2 * π * m ∉ Ioo θ (θ + 2 * π / 5) := by
  classical
  rcases K.eq_empty_or_nonempty with rfl | ⟨κ₀, hκ₀⟩
  · exact ⟨0, by simp⟩
  have hp : (0 : ℝ) < 2 * π := by positivity
  let j : ℝ → ℕ := fun κ => ⌊(toIcoMod hp κ₀ κ - κ₀) / (2 * π / 5)⌋₊
  have hcard : ((K.erase κ₀).image j).card < (Finset.range 5).card := by
    have h1 := Finset.card_image_le (s := K.erase κ₀) (f := j)
    have h2 := Finset.card_erase_of_mem hκ₀
    rw [Finset.card_range]; omega
  obtain ⟨j₀, hj₀, hnot⟩ := Finset.exists_mem_notMem_of_card_lt_card hcard
  have hj₀5 : j₀ < 5 := Finset.mem_range.mp hj₀
  have hj₀5' : (j₀ : ℝ) + 1 ≤ 5 := by exact_mod_cast hj₀5
  have hj₀0 : (0 : ℝ) ≤ j₀ := Nat.cast_nonneg _
  refine ⟨κ₀ + 2 * π * j₀ / 5, fun κ hκ m hhit => ?_⟩
  obtain ⟨hlo, hhi⟩ := hhit
  have hxI : κ + 2 * π * m ∈ Ico κ₀ (κ₀ + 2 * π) := ⟨by nlinarith, by nlinarith⟩
  have hmod : toIcoMod hp κ₀ κ = κ + 2 * π * m := by
    rw [toIcoMod_eq_iff]
    exact ⟨hxI, -m, by simp [zsmul_eq_mul]; ring⟩
  by_cases hκκ : κ = κ₀
  · subst hκκ
    have h0 : toIcoMod hp κ κ = κ := (toIcoMod_eq_iff hp).mpr ⟨⟨le_rfl, by linarith⟩, 0, by simp⟩
    rw [hmod] at h0
    nlinarith
  · have hjκ : j κ = j₀ := by
      show ⌊(toIcoMod hp κ₀ κ - κ₀) / (2 * π / 5)⌋₊ = j₀
      rw [hmod, Nat.floor_eq_iff (div_nonneg (by linarith [hxI.1]) (by positivity))]
      have h5 : (0 : ℝ) < 2 * π / 5 := by positivity
      constructor
      · rw [le_div_iff₀ h5]; nlinarith
      · rw [div_lt_iff₀ h5]; nlinarith
    exact hnot (Finset.mem_image.mpr ⟨κ, Finset.mem_erase.mpr ⟨hκκ, hκ⟩, hjκ⟩)

/-- An open annular sector at `v` approaches `v` along each of its open directions. -/
theorem mem_coneAt_annSector (v : ℂ) {r a b γ : ℝ} (hr : 0 < r) (hγ : γ ∈ Ioo a b) : γ ∈ coneAt (annSector v 0 r a b) v := by
  intro ε hε
  set t := min r ε / 2 with ht
  have ht0 : 0 < t := by positivity
  have htr : t < r := by have := min_le_left r ε; linarith
  have htε : t < ε := by have := min_le_right r ε; linarith
  have hz : v + (t : ℂ) * e γ - v = (t : ℂ) * e γ := by ring
  have hn : ‖(t : ℂ) * e γ‖ = t := by
    rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]
  refine ⟨v + (t : ℂ) * e γ, ⟨(t, γ), ⟨⟨ht0, htr⟩, hγ⟩, rfl⟩, ?_, ?_, ?_⟩
  · intro hzv
    have := congrArg (fun w => ‖w - v‖) hzv
    simp only [hz, hn, sub_self, norm_zero] at this
    linarith
  · rw [dist_eq_norm, hz, hn]; exact htε
  · rw [hz, hn, mul_div_cancel_left₀ _ (by exact_mod_cast ht0.ne' : (t : ℂ) ≠ 0), sub_self, norm_zero]
    exact hε

/-- The frame distance formula: the squared distance from `framePt v β x (κ x²/2)` to the point `v + ρ e(β + σπ/2 + τ)`. -/
theorem norm_sq_framePt_sub {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) (v : ℂ) (β κ ρ τ x : ℝ) :
    ‖framePt v β x (κ * x ^ 2 / 2) - (v + (ρ : ℂ) * e (β + σ * (π / 2) + τ))‖ ^ 2 =
      x ^ 2 * (1 - σ * κ * ρ * Real.cos τ) + 2 * σ * ρ * Real.sin τ * x + κ ^ 2 * x ^ 4 / 4 + ρ ^ 2 := by
  have hc : Real.cos (σ * (π / 2) + τ) = -σ * Real.sin τ ∧ Real.sin (σ * (π / 2) + τ) = σ * Real.cos τ := by
    rcases hσ with rfl | rfl
    · rw [one_mul, add_comm, Real.cos_add_pi_div_two, Real.sin_add_pi_div_two]; simp
    · rw [neg_one_mul, neg_add_eq_sub, Real.cos_sub_pi_div_two, Real.sin_sub_pi_div_two]
      simp
  have h : framePt v β x (κ * x ^ 2 / 2) - (v + (ρ : ℂ) * e (β + σ * (π / 2) + τ)) =
      e β * (((x : ℂ) + ((κ * x ^ 2 / 2 : ℝ) : ℂ) * I) - (ρ : ℂ) * e (σ * (π / 2) + τ)) := by
    rw [framePt, add_assoc β, e_add β]; ring
  rw [h, norm_mul, norm_e, one_mul, Complex.sq_norm, Complex.normSq_apply, e_eq, hc.1, hc.2]
  simp only [Complex.sub_re, Complex.sub_im, Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im,
    Complex.ofReal_re, Complex.ofReal_im, Complex.I_re, Complex.I_im]
  have hσ2 : σ ^ 2 = 1 := by rcases hσ with rfl | rfl <;> norm_num
  linear_combination (ρ ^ 2 * σ ^ 2) * Real.sin_sq_add_cos_sq τ + ρ ^ 2 * hσ2

/-- **Second-order collars from a tangent parabola** (the second-order lemma's engine, `plans/FS131-W-kernel-plan.md` § 7.3 (b)): if `S` holds the
points `v + (x + (κx²/2) i) e(β)`, `0 < x < r`, of the parabola tangent to `e β` at `v` with upward curvature `κ`, then at the normal
`β + σ π/2` (`σ = ±1`) the shadow of `S` carries an inner collar when `σκ < 1` and an outer collar when `σκ > 1`: the unit circle about a point
`z` of the collar has `v` on one side (inside it for inner `z`) and the parabola's point at a fixed small `x` on the other, and the parabola's arc
is connected. -/
theorem collarAt_shadow_of_parabola {S : Set ℂ} {v : ℂ} {β κ σ r : ℝ} (hσ : σ = 1 ∨ σ = -1) (hr : 0 < r)
    (hS : ∀ x ∈ Ioo 0 r, framePt v β x (κ * x ^ 2 / 2) ∈ S) :
    (σ * κ < 1 → CollarAt (shadow S) v .inner (β + σ * (π / 2))) ∧
      (1 < σ * κ → CollarAt (shadow S) v .outer (β + σ * (π / 2))) := by
  set w : ℝ → ℂ := fun x => framePt v β x (κ * x ^ 2 / 2) with hw
  set Q : ℝ → ℝ → ℝ → ℝ := fun ρ τ x =>
    x ^ 2 * (1 - σ * κ * ρ * Real.cos τ) + 2 * σ * ρ * Real.sin τ * x + κ ^ 2 * x ^ 4 / 4 + ρ ^ 2 with hQ
  have hwc : Continuous w := by simp only [hw, framePt]; fun_prop
  have hQc : ∀ ρ τ, Continuous (Q ρ τ) := fun ρ τ => by simp only [hQ]; fun_prop
  have hQcp : ∀ x, Continuous (fun p : ℝ × ℝ => Q p.1 p.2 x) := fun x => by simp only [hQ]; fun_prop
  have hQ0 : ∀ ρ τ, Q ρ τ 0 = ρ ^ 2 := by intro ρ τ; simp [hQ]
  -- the shadow from two points of the arc, one inside and one outside
  have hshadow : ∀ (z : ℂ) (x₀ : ℝ), 0 < x₀ → x₀ < r → (∃ x₁ ∈ Ioc 0 x₀, dist z (w x₁) < 1) →
      (∃ x₂ ∈ Ioc 0 x₀, 1 < dist z (w x₂)) → z ∈ shadow S := by
    rintro z x₀ h0 hr' ⟨x₁, hx₁, h1⟩ ⟨x₂, hx₂, h2⟩
    have hR : IsPreconnected (w '' Ioc 0 x₀) := isPreconnected_Ioc.image _ hwc.continuousOn
    obtain ⟨y, ⟨x, hx, rfl⟩, hy⟩ := mem_shadow_of_preconnected hR (mem_image_of_mem w hx₁) (mem_image_of_mem w hx₂) h1 h2
    exact ⟨w x, hS x ⟨hx.1, lt_of_le_of_lt hx.2 hr'⟩, hy⟩
  have hdist : ∀ ρ τ x : ℝ, dist (v + (ρ : ℂ) * e (β + σ * (π / 2) + τ)) (w x) ^ 2 = Q ρ τ x := by
    intro ρ τ x
    rw [dist_eq_norm, ← norm_neg, neg_sub]
    exact norm_sq_framePt_sub hσ v β κ ρ τ x
  -- small parameters on the arc
  have hsmall_lt : ∀ ρ τ x₀ : ℝ, 0 < x₀ → ρ ^ 2 < 1 → ∃ x₁ ∈ Ioc 0 x₀, Q ρ τ x₁ < 1 := by
    intro ρ τ x₀ hx₀ hρ
    have hev : ∀ᶠ x in 𝓝 (0 : ℝ), Q ρ τ x < 1 :=
      (hQc ρ τ).continuousAt.eventually_lt continuousAt_const (by rw [hQ0]; exact hρ)
    obtain ⟨δ, hδ, hd⟩ := Metric.eventually_nhds_iff.mp hev
    refine ⟨min x₀ (δ / 2), ⟨lt_min hx₀ (by positivity), min_le_left _ _⟩, hd ?_⟩
    rw [Real.dist_eq, sub_zero, abs_of_pos (lt_min hx₀ (by positivity))]
    exact lt_of_le_of_lt (min_le_right _ _) (by linarith)
  have hsmall_gt : ∀ ρ τ x₀ : ℝ, 0 < x₀ → 1 < ρ ^ 2 → ∃ x₁ ∈ Ioc 0 x₀, 1 < Q ρ τ x₁ := by
    intro ρ τ x₀ hx₀ hρ
    have hev : ∀ᶠ x in 𝓝 (0 : ℝ), 1 < Q ρ τ x :=
      continuousAt_const.eventually_lt (hQc ρ τ).continuousAt (by rw [hQ0]; exact hρ)
    obtain ⟨δ, hδ, hd⟩ := Metric.eventually_nhds_iff.mp hev
    refine ⟨min x₀ (δ / 2), ⟨lt_min hx₀ (by positivity), min_le_left _ _⟩, hd ?_⟩
    rw [Real.dist_eq, sub_zero, abs_of_pos (lt_min hx₀ (by positivity))]
    exact lt_of_le_of_lt (min_le_right _ _) (by linarith)
  constructor
  · intro hσκ
    set x₀ := r / 2 with hx₀
    have hx₀0 : 0 < x₀ := by positivity
    have hx₀r : x₀ < r := by linarith
    have hQ1 : (1 : ℝ) < Q 1 0 x₀ := by
      simp only [hQ, Real.cos_zero, Real.sin_zero]
      nlinarith [sq_nonneg (κ * x₀ ^ 2), sq_pos_of_pos hx₀0]
    have hev : ∀ᶠ p in 𝓝 ((1 : ℝ), (0 : ℝ)), 1 < Q p.1 p.2 x₀ :=
      continuousAt_const.eventually_lt (hQcp x₀).continuousAt hQ1
    obtain ⟨ε, hε, hball⟩ := Metric.eventually_nhds_iff.mp hev
    set h := min (ε / 2) (1 / 2) with hh
    have hh0 : 0 < h := lt_min (by positivity) (by norm_num)
    refine ⟨h, hh0, fun z hz => ?_⟩
    obtain ⟨ρ', hρ', θ', hθ', rfl⟩ := (mem_collar_iff _ _ _ _ _ _).mp hz
    have hρ'' : 1 - h < ρ' ∧ ρ' < 1 := hρ'
    set τ := θ' - (β + σ * (π / 2)) with hτ
    have hθ'τ : θ' = β + σ * (π / 2) + τ := by rw [hτ]; ring
    have hτh : |τ| < h := by rw [abs_lt]; constructor <;> linarith [hθ'.1, hθ'.2]
    have hρ0 : 0 < ρ' := by have : h ≤ 1 / 2 := min_le_right _ _; linarith [hρ''.1]
    have hpd : dist (ρ', τ) ((1 : ℝ), (0 : ℝ)) < ε := by
      rw [Prod.dist_eq, max_lt_iff, Real.dist_eq, Real.dist_eq]
      have : h ≤ ε / 2 := min_le_left _ _
      constructor
      · rw [abs_lt]; constructor <;> linarith [hρ''.1, hρ''.2]
      · rw [sub_zero]; linarith
    have hQout : 1 < Q ρ' τ x₀ := hball hpd
    rw [hθ'τ]
    refine hshadow _ x₀ hx₀0 hx₀r ?_ ⟨x₀, ⟨hx₀0, le_rfl⟩, ?_⟩
    · obtain ⟨x₁, hx₁, hlt⟩ := hsmall_lt ρ' τ x₀ hx₀0 (by nlinarith [hρ''.1, hρ''.2])
      refine ⟨x₁, hx₁, ?_⟩
      have := hdist ρ' τ x₁
      nlinarith [dist_nonneg (x := v + (ρ' : ℂ) * e (β + σ * (π / 2) + τ)) (y := w x₁)]
    · have := hdist ρ' τ x₀
      nlinarith [dist_nonneg (x := v + (ρ' : ℂ) * e (β + σ * (π / 2) + τ)) (y := w x₀)]
  · intro hσκ
    set m := σ * κ - 1 with hm
    have hm0 : 0 < m := by rw [hm]; linarith
    set x₀ := min (r / 2) (min 1 (m / (κ ^ 2 + 1))) with hx₀
    have hκ2 : 0 < κ ^ 2 + 1 := by positivity
    have hx₀0 : 0 < x₀ := lt_min (by positivity) (lt_min one_pos (by positivity))
    have hx₀r : x₀ < r := lt_of_le_of_lt (min_le_left _ _) (by linarith)
    have hx₀1 : x₀ ≤ 1 := (min_le_right _ _).trans (min_le_left _ _)
    have hx₀m : x₀ * (κ ^ 2 + 1) ≤ m := by
      have : x₀ ≤ m / (κ ^ 2 + 1) := (min_le_right _ _).trans (min_le_right _ _)
      rwa [le_div_iff₀ hκ2] at this
    have hQ1 : Q 1 0 x₀ < 1 := by
      simp only [hQ, Real.cos_zero, Real.sin_zero]
      have h0 : x₀ ^ 2 ≤ x₀ := by nlinarith
      have h1 : κ ^ 2 * x₀ ^ 2 ≤ κ ^ 2 * x₀ := mul_le_mul_of_nonneg_left h0 (sq_nonneg κ)
      have h2 : κ ^ 2 * x₀ < m := by nlinarith
      have h3 : x₀ ^ 2 * (1 - σ * κ) + κ ^ 2 * x₀ ^ 4 / 4 < 0 := by
        have : x₀ ^ 2 * (-m + κ ^ 2 * x₀ ^ 2 / 4) < 0 := by
          apply mul_neg_of_pos_of_neg (by positivity)
          nlinarith
        nlinarith
      nlinarith
    have hev : ∀ᶠ p in 𝓝 ((1 : ℝ), (0 : ℝ)), Q p.1 p.2 x₀ < 1 :=
      (hQcp x₀).continuousAt.eventually_lt continuousAt_const hQ1
    obtain ⟨ε, hε, hball⟩ := Metric.eventually_nhds_iff.mp hev
    set h := min (ε / 2) 1 with hh
    have hh0 : 0 < h := lt_min (by positivity) one_pos
    refine ⟨h, hh0, fun z hz => ?_⟩
    obtain ⟨ρ', hρ', θ', hθ', rfl⟩ := (mem_collar_iff _ _ _ _ _ _).mp hz
    have hρ'' : 1 < ρ' ∧ ρ' < 1 + h := hρ'
    set τ := θ' - (β + σ * (π / 2)) with hτ
    have hθ'τ : θ' = β + σ * (π / 2) + τ := by rw [hτ]; ring
    have hτh : |τ| < h := by rw [abs_lt]; constructor <;> linarith [hθ'.1, hθ'.2]
    have hpd : dist (ρ', τ) ((1 : ℝ), (0 : ℝ)) < ε := by
      rw [Prod.dist_eq, max_lt_iff, Real.dist_eq, Real.dist_eq]
      have : h ≤ ε / 2 := min_le_left _ _
      constructor
      · rw [abs_lt]; constructor <;> linarith [hρ''.1, hρ''.2]
      · rw [sub_zero]; linarith
    have hQin : Q ρ' τ x₀ < 1 := hball hpd
    rw [hθ'τ]
    refine hshadow _ x₀ hx₀0 hx₀r ⟨x₀, ⟨hx₀0, le_rfl⟩, ?_⟩ ?_
    · have := hdist ρ' τ x₀
      nlinarith [dist_nonneg (x := v + (ρ' : ℂ) * e (β + σ * (π / 2) + τ)) (y := w x₀)]
    · obtain ⟨x₂, hx₂, hgt⟩ := hsmall_gt ρ' τ x₀ hx₀0 (by nlinarith [hρ''.1])
      refine ⟨x₂, hx₂, ?_⟩
      have := hdist ρ' τ x₂
      nlinarith [dist_nonneg (x := v + (ρ' : ℂ) * e (β + σ * (π / 2) + τ)) (y := w x₂)]


namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-! ## Crossing the unit circle -/

/-- **The colour `X` crosses `ω(v)` at the angle `θ`** (E1-CROSS's hypothesis, on colour classes): `v + e θ` is a limit of points of `X`'s class
inside `ω(v)` and of points of it outside. -/
def CrossesAt (v : ℂ) (X : Fin k) (θ : ℝ) : Prop :=
  v + e θ ∈ closure (F.region X ∩ ball v 1) ∧ v + e θ ∈ closure (F.region X \ closedBall v 1)

/-- The colour of the one-colour plane crosses every unit circle at every angle. -/
example (v : ℂ) (θ : ℝ) : (ArcMap.const univ isOpen_univ (0 : Fin 1)).CrossesAt v 0 θ := by
  have hreg : (ArcMap.const univ isOpen_univ (0 : Fin 1)).region 0 = univ := by
    ext z; simp [ArcMap.region, ArcMap.const, ArcMap.interiorPts]
  have key : ∀ s : ℝ, (s = 1 ∨ s = -1) → ∀ ε > 0, ∃ t : ℝ, 0 < t ∧ t < 1 ∧ t < ε ∧
      dist (v + ((1 + s * t : ℝ) : ℂ) * e θ) v = 1 + s * t ∧ dist (v + ((1 + s * t : ℝ) : ℂ) * e θ) (v + e θ) = t := by
    intro s hs ε hε
    refine ⟨min (ε / 2) (1 / 2), by positivity, by
      exact lt_of_le_of_lt (min_le_right _ _) (by norm_num), lt_of_le_of_lt (min_le_left _ _) (by linarith), ?_, ?_⟩
    · rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs]
      rcases hs with rfl | rfl
      · rw [abs_of_pos (by positivity)]
      · rw [abs_of_pos]; have : min (ε / 2) (1 / 2 : ℝ) ≤ 1 / 2 := min_le_right _ _; linarith
    · have hrw : v + ((1 + s * min (ε / 2) (1 / 2) : ℝ) : ℂ) * e θ - (v + e θ)
          = ((s * min (ε / 2) (1 / 2) : ℝ) : ℂ) * e θ := by push_cast; ring
      rw [dist_eq_norm, hrw, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_mul]
      rcases hs with rfl | rfl <;> simp <;> linarith
  refine ⟨Metric.mem_closure_iff.mpr fun ε hε => ?_, Metric.mem_closure_iff.mpr fun ε hε => ?_⟩
  · obtain ⟨t, ht0, ht1, htε, hd, hd'⟩ := key (-1) (Or.inr rfl) ε hε
    refine ⟨_, ⟨by rw [hreg]; trivial, ?_⟩, by rw [dist_comm, hd']; exact htε⟩
    rw [mem_ball, hd]; linarith
  · obtain ⟨t, ht0, ht1, htε, hd, hd'⟩ := key 1 (Or.inl rfl) ε hε
    refine ⟨_, ⟨by rw [hreg]; trivial, ?_⟩, by rw [dist_comm, hd']; exact htε⟩
    rw [mem_closedBall, hd]; linarith

/-- **Adversary for `CrossesAt`**: a colour whose class lies inside `ω(v)` reaches it from one side only and does not cross. -/
example (v : ℂ) (θ : ℝ) : ¬ (ArcMap.const (ball v 1) isOpen_ball (0 : Fin 1)).CrossesAt v 0 θ := by
  have hreg : (ArcMap.const (ball v 1) isOpen_ball (0 : Fin 1)).region 0 = ball v 1 := by
    ext z; simp [ArcMap.region, ArcMap.const, ArcMap.interiorPts]
  rintro ⟨-, hout⟩
  have : (ArcMap.const (ball v 1) isOpen_ball (0 : Fin 1)).region 0 \ closedBall v 1 = ∅ := by
    rw [hreg]; exact sdiff_eq_empty.mpr ball_subset_closedBall
  rw [this, closure_empty] at hout
  exact hout

variable {F}

/-! ## E1-SEE: seeing through a point at distance one -/

/-- **E1-SEE** (`plans/FS131-E1-derivation.md` § 3.1): in a valid map, a point `Y` at distance exactly `1` from a point `q` of colour `j`'s class
does not carry `j` (FS106-DIAM's third clause, wave 1's `dist_ne_one_of_mem_of_mem_closure`, at the class of `j`). -/
theorem not_mem_coloursAt_of_dist_eq_one (hF : F.Valid) {j : Fin k} {q Y : ℂ} (hq : q ∈ F.region j) (hqY : dist q Y = 1) :
    j ∉ F.coloursAt Y := by
  intro hY
  exact dist_ne_one_of_mem_of_mem_closure (F.isOpen_region j) (hF.unitPairsNull_region j) hq hY hqY

/-- A valid map's class of `j` misses its own shadow. -/
theorem not_mem_shadow_of_mem_region (hF : F.Valid) {j : Fin k} {q : ℂ} (hq : q ∈ F.region j) : q ∉ shadow (F.region j) := by
  rintro ⟨y, hy, hd⟩
  exact hF q hq.1 y hy.1 hd (by rw [show F.col q = j from hq.2, show F.col y = j from hy.2])

/-- Carrying a collar is monotone in the set. -/
theorem _root_.HadwigerNelson.Plane.CollarAt.mono {S T : Set ℂ} {u : ℂ} {s : Rim} {θ : ℝ} (h : CollarAt S u s θ) (hST : S ⊆ T) :
    CollarAt T u s θ := by
  obtain ⟨h, hh, hsub⟩ := h
  exact ⟨h, hh, hsub.trans hST⟩

/-- The shadow is monotone in the set. -/
theorem _root_.HadwigerNelson.Plane.shadow_mono {S T : Set ℂ} (hST : S ⊆ T) : shadow S ⊆ shadow T :=
  fun _ ⟨y, hy, hd⟩ => ⟨y, hST hy, hd⟩

/-- **An open set meets the interior points** (a map of the plane): `Γ` has empty interior. -/
theorem exists_mem_interiorPts_of_isOpen (hP : F.IsPlaneMap) {U : Set ℂ} (hU : IsOpen U) (hne : U.Nonempty) :
    (U ∩ F.interiorPts).Nonempty := by
  obtain ⟨z, hz⟩ := hne
  obtain ⟨ε, hε, hεU⟩ := Metric.isOpen_iff.mp hU z hz
  obtain ⟨y, hy, hd⟩ := Metric.mem_closure_iff.mp (F.dense_interiorPts (by rw [hP]; trivial) : z ∈ closure F.interiorPts) ε hε
  exact ⟨y, hεU (by rw [Metric.mem_ball, dist_comm]; exact hd), hy⟩

/-- **Both sides of a unit circle are near each of its points**: every point of `ω(v)` is a limit of points inside and of points outside. -/
theorem exists_near_sphere_sides (v z : ℂ) (hz : dist z v = 1) {ε : ℝ} (hε : 0 < ε) :
    (∃ z', dist z' z < ε ∧ 1 < dist z' v) ∧ ∃ z', dist z' z < ε ∧ dist z' v < 1 := by
  set t := min (1 / 2) (ε / 2) with ht
  have ht0 : 0 < t := lt_min (by norm_num) (by positivity)
  have ht1 : t ≤ 1 / 2 := min_le_left _ _
  have ht2 : t ≤ ε / 2 := min_le_right _ _
  have hz1 : ‖z - v‖ = 1 := by rw [← dist_eq_norm]; exact hz
  have hd : ∀ s : ℝ, dist (v + (1 + s) * (z - v)) z = |s| ∧ dist (v + (1 + (s : ℂ)) * (z - v)) v = |1 + s| := by
    intro s
    constructor
    · rw [dist_eq_norm, show v + (1 + (s : ℂ)) * (z - v) - z = (s : ℂ) * (z - v) by ring, norm_mul, hz1, mul_one,
        Complex.norm_real, Real.norm_eq_abs]
    · rw [dist_eq_norm, add_sub_cancel_left, norm_mul, hz1, mul_one,
        show (1 : ℂ) + (s : ℂ) = ((1 + s : ℝ) : ℂ) by push_cast; ring, Complex.norm_real, Real.norm_eq_abs]
  constructor
  · refine ⟨v + (1 + (t : ℂ)) * (z - v), ?_, ?_⟩
    · rw [(hd t).1, abs_of_pos ht0]; linarith
    · rw [(hd t).2, abs_of_pos (by linarith)]; linarith
  · refine ⟨v + (1 + ((-t : ℝ) : ℂ)) * (z - v), ?_, ?_⟩
    · rw [(hd (-t)).1, abs_neg, abs_of_pos ht0]; linarith
    · rw [(hd (-t)).2, abs_of_pos (by linarith)]; linarith

/-- **E1-SEE, robust form** (the kill at a normal, § 7.3 (b)): if both an inner and an outer collar about `ψ` lie in the shadow of `j`'s class,
the point `v + e ψ` does not carry `j` — `j`'s class misses both collars (validity), hence a disc about `v + e ψ` (`exists_mem_collar_of_dist_lt`;
a point of the class on `ω(v)` has a disc in the class, meeting the inner collar). -/
theorem not_mem_coloursAt_of_collarAt (hF : F.Valid) {v : ℂ} {ψ : ℝ} {j : Fin k}
    (hin : CollarAt (shadow (F.region j)) v .inner ψ) (hout : CollarAt (shadow (F.region j)) v .outer ψ) :
    j ∉ F.coloursAt (v + e ψ) := by
  intro hY
  obtain ⟨h₁, hh₁, hsub₁⟩ := hin
  obtain ⟨h₂, hh₂, hsub₂⟩ := hout
  set h := min h₁ h₂ with hh
  have hh0 : 0 < h := lt_min hh₁ hh₂
  have hin' : collar v .inner (ψ - h) (ψ + h) h ⊆ shadow (F.region j) :=
    (collar_subset_collar v .inner (by linarith [min_le_left h₁ h₂]) (by linarith [min_le_left h₁ h₂]) (min_le_left _ _)).trans hsub₁
  have hout' : collar v .outer (ψ - h) (ψ + h) h ⊆ shadow (F.region j) :=
    (collar_subset_collar v .outer (by linarith [min_le_right h₁ h₂]) (by linarith [min_le_right h₁ h₂]) (min_le_right _ _)).trans hsub₂
  obtain ⟨ε, hε, hcol⟩ := exists_mem_collar_of_dist_lt v ψ hh0
  obtain ⟨q, hq, hqd⟩ := Metric.mem_closure_iff.mp hY ε hε
  have hqd' : dist q (v + e ψ) < ε := by rw [dist_comm]; exact hqd
  rcases lt_trichotomy (dist q v) 1 with hlt | heq | hgt
  · exact not_mem_shadow_of_mem_region hF hq (hin' ((hcol q hqd').1 hlt))
  · -- on `ω(v)`: slide `q` inwards inside the open class
    obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp (F.isOpen_region j) q hq
    set t := min (1 / 2) (min (r / 2) ((ε - dist q (v + e ψ)) / 2)) with ht
    have hgap : 0 < ε - dist q (v + e ψ) := by linarith
    have ht0 : 0 < t := lt_min (by norm_num) (lt_min (by positivity) (by positivity))
    have ht1 : t ≤ 1 / 2 := min_le_left _ _
    have ht2 : t ≤ r / 2 := (min_le_right _ _).trans (min_le_left _ _)
    have ht3 : t ≤ (ε - dist q (v + e ψ)) / 2 := (min_le_right _ _).trans (min_le_right _ _)
    set q' := v + (1 - (t : ℂ)) * (q - v) with hq'
    have hq'q : dist q' q = t * dist q v := by
      rw [dist_eq_norm, dist_eq_norm, hq', show v + (1 - (t : ℂ)) * (q - v) - q = -((t : ℂ) * (q - v)) by ring,
        norm_neg, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]
    have hq'v : dist q' v = (1 - t) * dist q v := by
      rw [dist_eq_norm, dist_eq_norm, hq', add_sub_cancel_left, norm_mul]
      congr 1
      rw [← Complex.ofReal_one, ← Complex.ofReal_sub, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by linarith)]
    rw [heq, mul_one] at hq'q hq'v
    have hq'R : q' ∈ F.region j := hball (by rw [Metric.mem_ball, hq'q]; linarith)
    have hq'd : dist q' (v + e ψ) < ε := by
      have := dist_triangle q' q (v + e ψ)
      rw [hq'q] at this; linarith
    have hq'lt : dist q' v < 1 := by rw [hq'v]; linarith
    exact not_mem_shadow_of_mem_region hF hq'R (hin' ((hcol q' hq'd).1 hq'lt))
  · exact not_mem_shadow_of_mem_region hF hq (hout' ((hcol q hqd').2 hgt))

/-! ## E1-RAY and E1-CROSS -/

/-- **E1-RAY, inner** (`plans/FS131-E1-derivation.md` § 3.2): a sector at `v` holding the direction `γ` in its open range, with
`cos (γ − ψ) < 0`, puts an inner collar about `ψ` in its colour's shadow (W's `collarAt_shadow_inner` on a truncated sector,
`mem_coneAt_annSector`). -/
theorem SectorsAt.collarAt_shadow_inner_of_mem {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (i : Fin n) {γ ψ : ℝ} (hγ : γ ∈ Ioo (d i.castSucc) (d i.succ)) (hcos : Real.cos (γ - ψ) < 0) :
    CollarAt (shadow (F.region (c i))) v .inner ψ := by
  obtain ⟨hδ0, hδ1⟩ := hγ
  set δ := min (γ - d i.castSucc) (d i.succ - γ) / 2 with hδ
  have hδpos : 0 < δ := by rw [hδ]; have := lt_min (sub_pos.mpr hδ0) (sub_pos.mpr hδ1); linarith
  obtain ⟨r, hr, hR⟩ := h.2.2.2.2.1 i δ hδpos
  have hγ' : γ ∈ Ioo (d i.castSucc + δ) (d i.succ - δ) := by
    constructor
    · have := min_le_left (γ - d i.castSucc) (d i.succ - γ); rw [hδ]; linarith
    · have := min_le_right (γ - d i.castSucc) (d i.succ - γ); rw [hδ]; linarith
  exact (collarAt_shadow_inner (isPreconnected_annSector _ _ _ _ _) (mem_coneAt_annSector v hr hγ') hcos).mono (shadow_mono hR)

/-- **E1-RAY, outer**: the same with `cos (γ − ψ) > 0` and an outer collar. -/
theorem SectorsAt.collarAt_shadow_outer_of_mem {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (i : Fin n) {γ ψ : ℝ} (hγ : γ ∈ Ioo (d i.castSucc) (d i.succ)) (hcos : 0 < Real.cos (γ - ψ)) :
    CollarAt (shadow (F.region (c i))) v .outer ψ := by
  obtain ⟨hδ0, hδ1⟩ := hγ
  set δ := min (γ - d i.castSucc) (d i.succ - γ) / 2 with hδ
  have hδpos : 0 < δ := by rw [hδ]; have := lt_min (sub_pos.mpr hδ0) (sub_pos.mpr hδ1); linarith
  obtain ⟨r, hr, hR⟩ := h.2.2.2.2.1 i δ hδpos
  have hγ' : γ ∈ Ioo (d i.castSucc + δ) (d i.succ - δ) := by
    constructor
    · have := min_le_left (γ - d i.castSucc) (d i.succ - γ); rw [hδ]; linarith
    · have := min_le_right (γ - d i.castSucc) (d i.succ - γ); rw [hδ]; linarith
  exact (collarAt_shadow_outer (isPreconnected_annSector _ _ _ _ _) (mem_coneAt_annSector v hr hγ') hcos).mono (shadow_mono hR)

/-- **E1-CROSS** (`plans/FS131-E1-derivation.md` § 3.3), on colour classes: in a valid map, at a point whose picture has positive angles, a colour
crossing `ω(v)` at any angle is carried by no sector (a sector of colour `X` has a direction with `cos (γ − θ) ≠ 0`, so a collar on one side
about `θ` lies in `X`'s shadow, and `X`'s points on that side near `v + e θ` lie in it). -/
theorem SectorsAt.not_mem_range_of_crossesAt (hF : F.Valid) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (hpos : ∀ i : Fin n, 0 < d i.succ - d i.castSucc) {X : Fin k} {θ : ℝ} (hX : F.CrossesAt v X θ) :
    X ∉ Set.range c := by
  rintro ⟨i, rfl⟩
  have hw := hpos i
  have hwle : d i.succ - d i.castSucc ≤ 2 * π := by
    have h1 : d i.succ ≤ d (Fin.last n) := h.2.1 (Fin.le_last _)
    have h2 : d 0 ≤ d i.castSucc := h.2.1 (Fin.zero_le _)
    rw [h.2.2.1] at h1; linarith
  set γ₀ := (d i.castSucc + d i.succ) / 2 with hγ₀
  set ε := (d i.succ - d i.castSucc) / 4 with hε
  have hγ₀m : γ₀ ∈ Ioo (d i.castSucc) (d i.succ) := ⟨by linarith, by linarith⟩
  have hγ₁m : γ₀ + ε ∈ Ioo (d i.castSucc) (d i.succ) := ⟨by linarith, by linarith⟩
  obtain ⟨γ, hγm, hγ⟩ : ∃ γ ∈ Ioo (d i.castSucc) (d i.succ), Real.cos (γ - θ) ≠ 0 := by
    by_cases h0 : Real.cos (γ₀ - θ) = 0
    · refine ⟨γ₀ + ε, hγ₁m, fun h1 => ?_⟩
      have hsin : Real.sin ε ≠ 0 := (Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith [Real.pi_pos])).ne'
      have hexp : Real.cos (γ₀ + ε - θ) = Real.cos (γ₀ - θ) * Real.cos ε - Real.sin (γ₀ - θ) * Real.sin ε := by
        rw [show γ₀ + ε - θ = (γ₀ - θ) + ε by ring, Real.cos_add]
      rw [hexp, h0, zero_mul, zero_sub, neg_eq_zero] at h1
      have hs2 : Real.sin (γ₀ - θ) ^ 2 = 1 := by nlinarith [Real.sin_sq_add_cos_sq (γ₀ - θ)]
      rcases mul_eq_zero.mp h1 with h2 | h2
      · rw [h2] at hs2; norm_num at hs2
      · exact hsin h2
    · exact ⟨γ₀, hγ₀m, h0⟩
  rcases lt_or_gt_of_ne hγ with hneg | hpos'
  · -- inner
    obtain ⟨h₁, hh₁, hsub⟩ := h.collarAt_shadow_inner_of_mem i hγm hneg
    obtain ⟨ε', hε', hcol⟩ := exists_mem_collar_of_dist_lt v θ hh₁
    obtain ⟨q, ⟨hq, hqb⟩, hqd⟩ := Metric.mem_closure_iff.mp hX.1 ε' hε'
    exact not_mem_shadow_of_mem_region hF hq (hsub ((hcol q (by rw [dist_comm]; exact hqd)).1 (mem_ball.mp hqb)))
  · obtain ⟨h₁, hh₁, hsub⟩ := h.collarAt_shadow_outer_of_mem i hγm hpos'
    obtain ⟨ε', hε', hcol⟩ := exists_mem_collar_of_dist_lt v θ hh₁
    obtain ⟨q, ⟨hq, hqb⟩, hqd⟩ := Metric.mem_closure_iff.mp hX.2 ε' hε'
    exact not_mem_shadow_of_mem_region hF hq (hsub ((hcol q (by rw [dist_comm]; exact hqd)).2 (not_le.mp (fun hh => hqb (mem_closedBall.mpr hh)))))

/-! ## E1-COVER -/

/-- **The local structure off crossings** (E1-COVER (a), on colour classes): in a map of the plane, at a point `v + e θ` of `ω(v)` with at most
two colours where no colour crosses, the point carries exactly two colours `A ≠ B`, and a disc about it has its interior points coloured `A`
inside `ω(v)`, `B` outside, and none on `ω(v)`. -/
theorem exists_side_colours_of_not_crossesAt (hP : F.IsPlaneMap) {v : ℂ} {θ : ℝ} (h2 : (F.coloursAt (v + e θ)).ncard ≤ 2)
    (hnc : ∀ X, ¬ F.CrossesAt v X θ) :
    ∃ A B : Fin k, A ≠ B ∧ F.coloursAt (v + e θ) = {A, B} ∧ ∃ r > 0, ∀ z ∈ ball (v + e θ) r, z ∈ F.interiorPts →
      (dist z v < 1 → F.col z = A) ∧ (1 < dist z v → F.col z = B) ∧ dist z v ≠ 1 := by
  set Y := v + e θ with hY
  have hYv : dist Y v = 1 := by rw [hY, dist_eq_norm, add_sub_cancel_left, norm_e]
  -- an interior point near `Y` on a given open side exists
  have hside : ∀ δ > 0, (∃ z, z ∈ ball Y δ ∩ ball v 1 ∩ F.interiorPts) ∧
      ∃ z, z ∈ ball Y δ ∩ (closedBall v 1)ᶜ ∩ F.interiorPts := by
    intro δ hδ
    obtain ⟨⟨zp, hzp, hzpv⟩, ⟨zm, hzm, hzmv⟩⟩ := exists_near_sphere_sides v Y hYv hδ
    constructor
    · obtain ⟨y, hy⟩ := exists_mem_interiorPts_of_isOpen hP (isOpen_ball.inter isOpen_ball)
        ⟨zm, mem_ball.mpr hzm, mem_ball.mpr hzmv⟩
      exact ⟨y, hy⟩
    · obtain ⟨y, hy⟩ := exists_mem_interiorPts_of_isOpen hP (isOpen_ball.inter isClosed_closedBall.isOpen_compl)
        ⟨zp, mem_ball.mpr hzp, by rw [Set.mem_compl_iff, mem_closedBall, not_le]; exact hzpv⟩
      exact ⟨y, hy⟩
  -- the colours reaching `Y` from inside and from outside
  set Cin : Set (Fin k) := {j | Y ∈ closure (F.region j ∩ ball v 1)} with hCin
  set Cout : Set (Fin k) := {j | Y ∈ closure (F.region j \ closedBall v 1)} with hCout
  have hCin_ne : Cin.Nonempty := by
    by_contra hemp
    rw [Set.not_nonempty_iff_eq_empty] at hemp
    have hev : ∀ᶠ z in 𝓝 Y, ∀ j : Fin k, z ∉ F.region j ∩ ball v 1 := by
      rw [Filter.eventually_all]
      intro j
      have hj : Y ∉ closure (F.region j ∩ ball v 1) := fun h => by
        have : j ∈ Cin := h
        rw [hemp] at this; exact this
      exact Filter.mem_of_superset (isClosed_closure.isOpen_compl.mem_nhds hj) fun z hz hzS => hz (subset_closure hzS)
    obtain ⟨δ, hδ, hball⟩ := Metric.eventually_nhds_iff.mp hev
    obtain ⟨⟨z, hz⟩, -⟩ := hside δ hδ
    exact hball hz.1.1 (F.col z) ⟨⟨hz.2, rfl⟩, hz.1.2⟩
  have hCout_ne : Cout.Nonempty := by
    by_contra hemp
    rw [Set.not_nonempty_iff_eq_empty] at hemp
    have hev : ∀ᶠ z in 𝓝 Y, ∀ j : Fin k, z ∉ F.region j \ closedBall v 1 := by
      rw [Filter.eventually_all]
      intro j
      have hj : Y ∉ closure (F.region j \ closedBall v 1) := fun h => by
        have : j ∈ Cout := h
        rw [hemp] at this; exact this
      exact Filter.mem_of_superset (isClosed_closure.isOpen_compl.mem_nhds hj) fun z hz hzS => hz (subset_closure hzS)
    obtain ⟨δ, hδ, hball⟩ := Metric.eventually_nhds_iff.mp hev
    obtain ⟨-, ⟨z, hz⟩⟩ := hside δ hδ
    exact hball hz.1.1 (F.col z) ⟨⟨hz.2, rfl⟩, hz.1.2⟩
  obtain ⟨A, hA⟩ := hCin_ne
  obtain ⟨B, hB⟩ := hCout_ne
  have hdisj : ∀ j, j ∈ Cin → j ∉ Cout := fun j h1 h2 => hnc j ⟨h1, h2⟩
  have hAB : A ≠ B := fun h => hdisj A hA (h ▸ hB)
  have hAcol : A ∈ F.coloursAt Y := closure_mono Set.inter_subset_left hA
  have hBcol : B ∈ F.coloursAt Y := closure_mono Set.sdiff_subset hB
  have hpair : ({A, B} : Set (Fin k)) ⊆ F.coloursAt Y := by
    intro j hj
    rcases hj with rfl | rfl
    · exact hAcol
    · exact hBcol
  have hcols : F.coloursAt Y = {A, B} :=
    (Set.eq_of_subset_of_ncard_le hpair (by rw [Set.ncard_pair hAB]; exact h2) (Set.toFinite _)).symm
  have hBin : B ∉ Cin := fun h => hdisj B h hB
  have hAout : A ∉ Cout := hdisj A hA
  -- a disc about `Y` carrying only these colours, `B` never inside and `A` never outside
  have hev : ∀ᶠ z in 𝓝 Y, (∀ j : Fin k, j ∉ ({A, B} : Set (Fin k)) → z ∉ F.region j) ∧
      z ∉ F.region B ∩ ball v 1 ∧ z ∉ F.region A \ closedBall v 1 := by
    refine (Filter.eventually_all.mpr fun j => ?_).and ((?_ : ∀ᶠ z in 𝓝 Y, z ∉ F.region B ∩ ball v 1).and
      (?_ : ∀ᶠ z in 𝓝 Y, z ∉ F.region A \ closedBall v 1)) |>.mono fun z hz => ⟨hz.1, hz.2.1, hz.2.2⟩
    · by_cases hj : j ∈ ({A, B} : Set (Fin k))
      · exact Filter.Eventually.of_forall fun z hz => absurd hj hz
      · have hj' : Y ∉ closure (F.region j) := fun h => hj (by rw [← hcols]; exact h)
        exact Filter.mem_of_superset (isClosed_closure.isOpen_compl.mem_nhds hj') fun z hz _ hzS => hz (subset_closure hzS)
    · exact Filter.mem_of_superset (isClosed_closure.isOpen_compl.mem_nhds hBin) fun z hz hzS => hz (subset_closure hzS)
    · exact Filter.mem_of_superset (isClosed_closure.isOpen_compl.mem_nhds hAout) fun z hz hzS => hz (subset_closure hzS)
  obtain ⟨r, hr, hb⟩ := Metric.eventually_nhds_iff.mp hev
  have hcolAB : ∀ z ∈ ball Y r, z ∈ F.interiorPts → F.col z = A ∨ F.col z = B := by
    intro z hz hzi
    by_contra hcon
    push Not at hcon
    exact (hb (mem_ball.mp hz)).1 (F.col z) (by simp [hcon.1, hcon.2]) ⟨hzi, rfl⟩
  refine ⟨A, B, hAB, hcols, r, hr, fun z hz hzi => ?_⟩
  have hE := hb (mem_ball.mp hz)
  have hnot1 : dist z v ≠ 1 := by
    intro h1
    obtain ⟨r', hr', hball'⟩ := Metric.isOpen_iff.mp (F.isOpen_region (F.col z)) z ⟨hzi, rfl⟩
    set r'' := min r' (r - dist z Y) with hr''
    have hr''0 : 0 < r'' := lt_min hr' (by have := mem_ball.mp hz; linarith)
    obtain ⟨⟨zp, hzp, hzpv⟩, ⟨zm, hzm, hzmv⟩⟩ := exists_near_sphere_sides v z h1 hr''0
    have hzpY : dist zp Y < r := by
      have := dist_triangle zp z Y; have := min_le_right r' (r - dist z Y); linarith
    have hzmY : dist zm Y < r := by
      have := dist_triangle zm z Y; have := min_le_right r' (r - dist z Y); linarith
    rcases hcolAB z hz hzi with hA' | hB'
    · have hzpR : zp ∈ F.region (F.col z) := hball' (by rw [mem_ball]; exact lt_of_lt_of_le hzp (min_le_left _ _))
      rw [hA'] at hzpR
      exact (hb hzpY).2.2 ⟨hzpR, by rw [mem_closedBall, not_le]; exact hzpv⟩
    · have hzmR : zm ∈ F.region (F.col z) := hball' (by rw [mem_ball]; exact lt_of_lt_of_le hzm (min_le_left _ _))
      rw [hB'] at hzmR
      exact (hb hzmY).2.1 ⟨hzmR, mem_ball.mpr hzmv⟩
  refine ⟨fun hlt => ?_, fun hgt => ?_, hnot1⟩
  · rcases hcolAB z hz hzi with h | h
    · exact h
    · exact absurd ⟨⟨hzi, h⟩, mem_ball.mpr hlt⟩ hE.2.1
  · rcases hcolAB z hz hzi with h | h
    · exact absurd ⟨⟨hzi, h⟩, by rw [mem_closedBall, not_le]; exact hgt⟩ hE.2.2
    · exact h

/-- **One colour class along a branch-point-free arc** (E1-COVER (b)–(c), on colour classes; the clopen argument of § 7.3 (a)): in a map of the
plane, if every point of the open arc `(θ₁, θ₂)` of `ω(v)` carries at most two colours and all the colours crossing `ω(v)` along it are one
colour, some colour class has every point of the arc in its closure. -/
theorem exists_closure_colour_of_arc (hP : F.IsPlaneMap) {v : ℂ} {θ₁ θ₂ : ℝ}
    (hnb : ∀ θ ∈ Ioo θ₁ θ₂, (F.coloursAt (v + e θ)).ncard ≤ 2)
    (hcross : ∀ X X' : Fin k, ∀ θ ∈ Ioo θ₁ θ₂, ∀ θ' ∈ Ioo θ₁ θ₂, F.CrossesAt v X θ → F.CrossesAt v X' θ' → X = X') :
    ∃ X : Fin k, ∀ θ ∈ Ioo θ₁ θ₂, v + e θ ∈ closure (F.region X) := by
  sorry

/-- **E1-COVER** (`plans/FS131-E1-derivation.md` § 3.4), in E1-GEN6's form and on colour classes: in a valid map of the plane, at a point `v` whose
picture has positive angles and at most one colour absent from its sectors, no open arc of `ω(v)` of angular length greater than `π/3` has at
most two colours at each of its points (its points all lie in one class's closure, `exists_closure_colour_of_arc` with E1-CROSS; a closed sub-arc
of length in `(π/3, π]` has chord `> 1`, against `dist_le_one_of_subset_closure`). -/
theorem SectorsAt.false_of_ncard_le_two_on_arc (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ}
    {c : Fin n → Fin k} (h : F.SectorsAt v n d c) (hpos : ∀ i : Fin n, 0 < d i.succ - d i.castSucc)
    (habs : ∀ X Y : Fin k, X ∉ Set.range c → Y ∉ Set.range c → X = Y) {θ₁ θ₂ : ℝ} (hlen : π / 3 < θ₂ - θ₁)
    (hnb : ∀ θ ∈ Ioo θ₁ θ₂, (F.coloursAt (v + e θ)).ncard ≤ 2) : False := by
  sorry

/-! ## E1-BAD -/

/-- **Every direction lies in one half-open sector**, mod `2π` (the bookkeeping of E1-BAD's case analysis): `d` is monotone with
`d (last n) = d 0 + 2π`. -/
theorem SectorsAt.exists_mem_Ico {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k} (h : F.SectorsAt v n d c) (D : ℝ) :
    ∃ i : Fin n, ∃ m : ℤ, D + 2 * π * m ∈ Ico (d i.castSucc) (d i.succ) := by
  sorry

/-- **E1-BAD, interior directions** (§ 3.5's first bullet, with E1-SEE): if a branch direction `ψ ± π/2` of `ω(v + e ψ)` at `v` is, mod `2π`,
interior to sector `i`, the branch near `v` runs in a truncated sector, so `v + e ψ` does not carry `c i`. -/
theorem SectorsAt.not_mem_coloursAt_of_mem_Ioo (hF : F.Valid) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (i : Fin n) {ψ D : ℝ} (hD : D = ψ + π / 2 ∨ D = ψ - π / 2) {m : ℤ}
    (hm : D + 2 * π * m ∈ Ioo (d i.castSucc) (d i.succ)) : c i ∉ F.coloursAt (v + e ψ) := by
  sorry

/-- **The colour of a tangent parabola at an edge** (the second-order lemma's map-level input, § 9.1): in a map of the plane, at an edge
direction `β = d i` of a picture with positive angles, the parabola tangent to `e β` at `v` with upward curvature `1/2` has its points `0 < x < r`,
for some `r > 0`, in one colour class, of one of the edge's two colours. A parabola lies on no circle and no line, so each of the finitely many arcs
near `v` meets it at finitely many points; its small points are interior points of one tile; their colour has `β` in its cone, so it is the colour of
sector `i` or of the sector before. -/
theorem SectorsAt.exists_parabola_region (hP : F.IsPlaneMap) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (hn : 2 ≤ n) (hpos : ∀ j : Fin n, 0 < d j.succ - d j.castSucc) (i : Fin n) :
    ∃ r > 0, ∃ j : Fin k, (j = c ((finRotate n).symm i) ∨ j = c i) ∧
      ∀ x ∈ Ioo 0 r, framePt v (d i.castSucc) x ((1 / 2 : ℝ) * x ^ 2 / 2) ∈ F.region j := by
  sorry

/-- **The refined second-order lemma** (§ 7.3 (b); W's § 4.1 lemma in the form E1-BAD's count and `step6` consume): in a map of the plane, at
every edge direction `β = d i` of a picture with positive angles, one of the edge's two normals `β ± π/2` carries an inner collar in the shadow of
both adjacent colours. With the parabola of curvature `1/2` and its colour `j` (`exists_parabola_region`): if `j` is the colour after the edge,
the normal `β + π/2` (`collarAt_shadow_of_parabola`, `1/2 < 1`; the colour before by E1-RAY); if before, the normal `β − π/2` (`−1/2 < 1`). -/
theorem SectorsAt.exists_normal_collarAt (hP : F.IsPlaneMap) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (hn : 2 ≤ n) (hpos : ∀ j : Fin n, 0 < d j.succ - d j.castSucc) (i : Fin n) :
    ∃ σ : ℝ, (σ = 1 ∨ σ = -1) ∧
      CollarAt (shadow (F.region (c ((finRotate n).symm i))) ∩ shadow (F.region (c i))) v .inner (d i.castSucc + σ * (π / 2)) := by
  sorry

/-- **E1-BAD at a good normal** (the edge case's kill): in a valid map, if the normal `β + σπ/2` of the edge `β = d i` carries an inner collar in
the shadow of both adjacent colours, the point `v + e (β + σπ/2)` lacks one of them — the one whose sector lies on the normal's side (E1-RAY puts
its outer collar in its shadow; `not_mem_coloursAt_of_collarAt`). -/
theorem SectorsAt.absent_at_normal (hF : F.Valid) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (hn : 2 ≤ n) (hpos : ∀ j : Fin n, 0 < d j.succ - d j.castSucc) (i : Fin n) {σ : ℝ}
    (hσ : σ = 1 ∨ σ = -1)
    (hs : CollarAt (shadow (F.region (c ((finRotate n).symm i))) ∩ shadow (F.region (c i))) v .inner (d i.castSucc + σ * (π / 2))) :
    c ((finRotate n).symm i) ∉ F.coloursAt (v + e (d i.castSucc + σ * (π / 2))) ∨
      c i ∉ F.coloursAt (v + e (d i.castSucc + σ * (π / 2))) := by
  sorry

/-- **E1-BAD** (`plans/FS131-E1-derivation.md` § 3.5), corrected (§ 7.4) and robust (§ 7.3 (b)): in a valid map of the plane, at a point whose
picture has `n ≥ 3` sectors of distinct colours, each of angle in `(0, π]`, there is a set `K` of at most `n` angles off which (mod `2π`) every point
`v + e ψ` of `ω(v)` lacks two distinct colours of the picture. `K` holds, for each edge, the normal the second-order lemma does not certify, and for
a sector of angle `π` both normals of its two edges; off `K`, each branch direction `ψ ± π/2` is interior to a sector (`not_mem_coloursAt_of_mem_Ioo`)
or is an edge with `ψ` its good normal (`absent_at_normal`), and the two colours lost are distinct. -/
theorem SectorsAt.exists_two_absent (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (hn : 3 ≤ n) (hc : Function.Injective c) (hpos : ∀ i : Fin n, 0 < d i.succ - d i.castSucc)
    (hπ : ∀ i : Fin n, d i.succ - d i.castSucc ≤ π) :
    ∃ K : Finset ℝ, K.card ≤ n ∧ ∀ ψ : ℝ, (∀ κ ∈ K, ∀ m : ℤ, ψ ≠ κ + 2 * π * m) →
      ∃ i j : Fin n, c i ≠ c j ∧ c i ∉ F.coloursAt (v + e ψ) ∧ c j ∉ F.coloursAt (v + e ψ) := by
  sorry

end ArcMap

end HadwigerNelson.Plane
