import Proofs.HadwigerNelson.Plane.LocalMap
import Proofs.HadwigerNelson.Plane.Chord
import Mathlib.LinearAlgebra.Complex.FiniteDimensional
import Mathlib.Geometry.Euclidean.Basic

/-!
# The local structure of an arc map at a point: finitely many tiles, the germ dichotomy, interval cones

Wave 3's supporting lemmas (`plans/FS131-w3-kernel-plan.md` § "For stage 3" and stage 3; inventory ruling 27: wave 3 takes
these forward from wave 4's foundation). Pure topology of `ArcMap`: no validity, no colour count.

* **Angular intervals.** `angleIcc a b` and `angleIoo a b` are the closed and open intervals `[a, b]`, `(a, b)` of angles,
  repeated with period `2π` — the rows' cones "`[θ₂ − 90°, θ₁ + 90°]`" read on the circle. Empty when `b < a` (resp.
  `b ≤ a`); the whole line when `b − a ≥ 2π`.
* **The disc of radius above 1.** `covers_one_iff`: a fragment covers `B̄(p, 1)` exactly when it covers a closed disc of
  radius above `1` about `p` (the domain is open and the disc compact) — so every row's "on a closed disc of radius above
  1 about `p`" is stated as `F.Covers p 1`.
* **Arcs against a unit circle.** `Arc.finite_inter_sphere_or_eq_circ`: a nondegenerate arc meets `ω(p)` in finitely many
  points or is an arc of `ω(p)` itself; `finite_ringΓ_off_ringArc`: on a covered ring, the points of `Γ` that lie on no arc
  of `Γ` on `ω(p)` are finitely many.
* **Interior points are dense** (`dense_interiorPts`): `Γ` is a locally finite union of arcs, so it has empty interior;
  every point of the domain carries a colour (`exists_mem_coloursAt`).
* **Finitely many tiles near a point** (`finite_tiles_near`, the wave's hardest leaf) and its consequences: the colours at
  a point are the colours of the tiles whose closure holds it (`mem_coloursAt_iff_exists_tileOf`), the cone of a colour
  class is the union of its tiles' cones (`coneAt_region_eq_biUnion`), every direction lies in some colour's cone
  (`exists_mem_coneAt_region`).
* **The germ dichotomy** (`germ_dichotomy`): at a ring point in the domain, a germ lies in one colour class, or on an arc of
  `Γ` on `ω(p)` with constant sides.
* **Interval cones in a simple map** (`Simple.coneAt_eq_angleIcc`): each tile's cone at a point of its closure is one closed
  angular interval.

Every leaf is `sorry` until wave 3's implementer lands it (`plans/FS131-w3-kernel-plan.md` § the leaf plans).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Angular intervals -/

/-- Normalising is `2/‖u‖`-Lipschitz at `u`: `‖w/‖w‖ − u/‖u‖‖ ≤ 2‖w − u‖/‖u‖`. -/
theorem norm_div_norm_sub_le {u w : ℂ} (hu : u ≠ 0) (hw : w ≠ 0) :
    ‖w / (‖w‖ : ℂ) - u / (‖u‖ : ℂ)‖ ≤ 2 * ‖w - u‖ / ‖u‖ := by
  set a := ‖u‖ with ha
  set b := ‖w‖ with hb
  have ha0 : 0 < a := norm_pos_iff.mpr hu
  have hb0 : 0 < b := norm_pos_iff.mpr hw
  have hac : (a : ℂ) ≠ 0 := by exact_mod_cast ha0.ne'
  have hbc : (b : ℂ) ≠ 0 := by exact_mod_cast hb0.ne'
  have key : w / (b : ℂ) - u / (a : ℂ) = (w - u) / (a : ℂ) + w * (((a - b) / (a * b) : ℝ) : ℂ) := by
    push_cast; field_simp; ring
  rw [key]
  refine (norm_add_le _ _).trans ?_
  have h1 : ‖(w - u) / (a : ℂ)‖ = ‖w - u‖ / a := by
    rw [norm_div, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ha0]
  have h2 : ‖w * (((a - b) / (a * b) : ℝ) : ℂ)‖ = |a - b| / a := by
    rw [norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_div, abs_of_pos (mul_pos ha0 hb0), ← hb]
    field_simp
  have h3 : |a - b| ≤ ‖w - u‖ := by
    rw [abs_sub_comm]; exact abs_norm_sub_norm_le w u
  rw [h1, h2]
  have : |a - b| / a ≤ ‖w - u‖ / a := div_le_div_of_nonneg_right h3 ha0.le
  have e : 2 * ‖w - u‖ / a = ‖w - u‖ / a + ‖w - u‖ / a := by ring
  rw [e]; linarith

/-- The closed angular interval `[a, b]`, repeated with period `2π`. -/
def angleIcc (a b : ℝ) : Set ℝ := ⋃ m : ℤ, Icc (a + 2 * π * m) (b + 2 * π * m)

/-- The open angular interval `(a, b)`, repeated with period `2π`. -/
def angleIoo (a b : ℝ) : Set ℝ := ⋃ m : ℤ, Ioo (a + 2 * π * m) (b + 2 * π * m)

/-- `[a, b]` lies in its angular interval. -/
theorem Icc_subset_angleIcc (a b : ℝ) : Icc a b ⊆ angleIcc a b := fun x hx =>
  mem_iUnion.mpr ⟨0, by simpa using hx⟩

/-- `(a, b)` lies in its angular interval. -/
theorem Ioo_subset_angleIoo (a b : ℝ) : Ioo a b ⊆ angleIoo a b := fun x hx =>
  mem_iUnion.mpr ⟨0, by simpa using hx⟩

/-- Spec example: `2π + π/2` lies in the angular interval `[0, π]`. -/
example : 2 * π + π / 2 ∈ angleIcc 0 π := by
  refine mem_iUnion.mpr ⟨1, ?_⟩
  constructor <;> push_cast <;> linarith [Real.pi_pos]

/-- **Adversary**: `−π/2` does not lie in the angular interval `(0, π)`. -/
example : -(π / 2) ∉ angleIoo 0 π := by
  intro h
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp h
  have hπ := Real.pi_pos
  rcases lt_or_ge m 0 with hm | hm
  · have : (m : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_iff.mpr hm
    nlinarith
  · have : (0 : ℝ) ≤ m := by exact_mod_cast hm
    nlinarith

/-! ## Cones of a Jordan domain's tile: one angular interval -/
/-- **The Jordan chart at a point of the closure**: near a point `x` of the closure of a Jordan domain `T`, the part of `T`
in a small disc is contained in a preconnected subset of `T` lying in any prescribed disc about `x`. -/
theorem ArcMap.IsJordanDomain.local_connected {T : Set ℂ} (hJ : ArcMap.IsJordanDomain T) {x : ℂ} (hx : x ∈ closure T)
    {r : ℝ} (hr : 0 < r) :
    ∃ r' > 0, ∃ C : Set ℂ, C ⊆ T ∧ C ⊆ ball x r ∧ IsPreconnected C ∧ T ∩ ball x r' ⊆ C := by
  obtain ⟨h, hh⟩ := hJ
  set xs : closure T := ⟨x, hx⟩ with hxs
  set z₀ : closedBall (0 : ℂ) 1 := h.symm xs with hz₀
  have hhz₀ : (h z₀ : ℂ) = x := by rw [hz₀]; simp [hxs]
  -- continuity of h at z₀
  have hcont : ContinuousAt (fun z : closedBall (0 : ℂ) 1 => (h z : ℂ)) z₀ :=
    continuous_subtype_val.continuousAt.comp h.continuous.continuousAt
  obtain ⟨s, hs, hsub⟩ := Metric.continuousAt_iff.mp hcont r hr
  -- continuity of h.symm at xs
  have hcont' : ContinuousAt h.symm xs := h.symm.continuous.continuousAt
  obtain ⟨r', hr', hsub'⟩ := Metric.continuousAt_iff.mp hcont' s hs
  set U : Set (closedBall (0 : ℂ) 1) := {z | (z : ℂ) ∈ ball (0 : ℂ) 1 ∩ ball (z₀ : ℂ) s} with hU
  have hUpre : IsPreconnected U := by
    rw [← Topology.IsInducing.subtypeVal.isPreconnected_image]
    have : Subtype.val '' U = ball (0 : ℂ) 1 ∩ ball (z₀ : ℂ) s := by
      ext z
      constructor
      · rintro ⟨w, hw, rfl⟩; exact hw
      · intro hz
        exact ⟨⟨z, ball_subset_closedBall hz.1⟩, hz, rfl⟩
    rw [this]
    exact ((convex_ball _ _).inter (convex_ball _ _)).isPreconnected
  refine ⟨r', hr', (fun z : closedBall (0 : ℂ) 1 => (h z : ℂ)) '' U, ?_, ?_, ?_, ?_⟩
  · rintro _ ⟨z, hz, rfl⟩
    exact (hh z).mpr hz.1
  · rintro _ ⟨z, hz, rfl⟩
    have := hsub (x := z) (by rw [Subtype.dist_eq]; exact hz.2)
    rw [dist_comm, hhz₀] at this
    simpa [dist_comm] using this
  · exact hUpre.image _ (continuous_subtype_val.comp h.continuous).continuousOn
  · rintro y ⟨hyT, hyb⟩
    set ys : closure T := ⟨y, subset_closure hyT⟩
    set z := h.symm ys with hz
    have hhz : (h z : ℂ) = y := by rw [hz]; simp [ys]
    have hzball : (z : ℂ) ∈ ball (0 : ℂ) 1 := (hh z).mp (by rw [hhz]; exact hyT)
    have hd : dist z z₀ < s := hsub' (x := ys) (by
      rw [Subtype.dist_eq]; simpa [ys, xs, dist_comm] using hyb)
    exact ⟨z, ⟨hzball, by rw [mem_ball]; exact hd⟩, hhz⟩



/-- Rotating by `π − γ` and then by `γ − π` is the identity. -/
theorem e_mul_e_sub_pi (γ : ℝ) : e (π - γ) * e (γ - π) = 1 := by
  rw [← e_add]; simp [e]

/-- A nonzero `w` of argument `a` is `‖w‖ e a`; rotating by `c` adds `c` to the angle. -/
theorem mul_e_of_arg {w : ℂ} {a : ℝ} (ha : arg w = a) (c : ℝ) : w * e c = (‖w‖ : ℂ) * e (a + c) := by
  have hw := Complex.norm_mul_exp_arg_mul_I w
  rw [ha] at hw
  rw [e_add, ← mul_assoc]
  congr 1
  exact hw.symm

/-- A preconnected set missing a point of `ℂ` and the two rays at angles `γ` and `γ + δ` from it lies, in the angle
`arg ((z − x) e(π − γ))`, on one side of the second ray. -/
theorem arg_side {C : Set ℂ} (hC : IsPreconnected C) {x : ℂ} (hxC : x ∉ C) {γ δ : ℝ}
    (h1 : ∀ z ∈ C, ∀ s : ℝ, 0 < s → z - x ≠ s * e γ)
    (h2 : ∀ z ∈ C, ∀ s : ℝ, 0 < s → z - x ≠ s * e (γ + δ)) :
    (∀ z ∈ C, arg ((z - x) * e (π - γ)) < δ - π) ∨ (∀ z ∈ C, δ - π < arg ((z - x) * e (π - γ))) := by
  have hne : ∀ z ∈ C, z - x ≠ 0 := fun z hz h => hxC (by rwa [sub_eq_zero.mp h] at hz)
  have hw0 : ∀ z ∈ C, (z - x) * e (π - γ) ≠ 0 := fun z hz => mul_ne_zero (hne z hz) (by simp [e])
  have hback : ∀ z ∈ C, ∀ a : ℝ, arg ((z - x) * e (π - γ)) = a →
      z - x = (‖(z - x) * e (π - γ)‖ : ℂ) * e (a + (γ - π)) := by
    intro z hz a ha
    have := mul_e_of_arg ha (γ - π)
    rw [mul_assoc, e_mul_e_sub_pi, mul_one] at this
    exact this
  have hslit : ∀ z ∈ C, (z - x) * e (π - γ) ∈ slitPlane := by
    intro z hz
    rw [Complex.mem_slitPlane_iff_arg]
    refine ⟨?_, hw0 z hz⟩
    intro harg
    apply h1 z hz ‖(z - x) * e (π - γ)‖ (norm_pos_iff.mpr (hw0 z hz))
    have := hback z hz π harg
    rw [show π + (γ - π) = γ by ring] at this
    exact this
  have hcont : ContinuousOn (fun z => arg ((z - x) * e (π - γ))) C := by
    intro z hz
    refine ContinuousAt.continuousWithinAt ?_
    exact (Complex.continuousAt_arg (hslit z hz)).comp (f := fun z : ℂ => (z - x) * e (π - γ)) (by fun_prop)
  have hpre := hC.image _ hcont
  have hmiss : ∀ z ∈ C, arg ((z - x) * e (π - γ)) ≠ δ - π := by
    intro z hz harg
    apply h2 z hz ‖(z - x) * e (π - γ)‖ (norm_pos_iff.mpr (hw0 z hz))
    have := hback z hz (δ - π) harg
    rw [show δ - π + (γ - π) = (γ + δ) + (-(2 * π)) by ring, e_add, e_neg] at this
    simpa using this
  have := hpre.subset_or_subset (u := Iio (δ - π)) (v := Ioi (δ - π)) isOpen_Iio isOpen_Ioi
    (Set.disjoint_left.mpr fun a (h : a < δ - π) (h' : δ - π < a) => lt_asymm h h')
    (by rintro _ ⟨z, hz, rfl⟩; exact (lt_or_gt_of_ne (hmiss z hz)))
  rcases this with h | h
  · left; intro z hz; exact h ⟨z, hz, rfl⟩
  · right; intro z hz; exact h ⟨z, hz, rfl⟩


/-- The unit direction of `z − x` close to `e β` puts `arg ((z − x) e(π − γ))` close to `β − γ − π`, for `β` in the
window `(γ, γ + 2π)` that `arg` reads without crossing its cut. -/
theorem arg_near {γ β : ℝ} (h1 : γ < β) (h2 : β < γ + 2 * π) {η : ℝ} (hη : 0 < η) :
    ∃ ε > 0, ∀ z x : ℂ, z ≠ x → ‖(z - x) / (‖z - x‖ : ℂ) - e β‖ < ε →
      |arg ((z - x) * e (π - γ)) - (β - γ - π)| < η := by
  have hπ := Real.pi_pos
  have hW : e β * e (π - γ) = e (β - γ - π) := by
    rw [← e_add, show β + (π - γ) = (β - γ - π) + 2 * π by ring, e_add_two_pi]
  have harg : arg (e (β - γ - π)) = β - γ - π := by
    show arg (Complex.exp (((β - γ - π : ℝ) : ℂ) * I)) = _
    rw [Complex.exp_mul_I]
    exact Complex.arg_cos_add_sin_mul_I (θ := β - γ - π) ⟨by linarith, by linarith⟩
  have hslit : e (β - γ - π) ∈ slitPlane := by
    rw [Complex.mem_slitPlane_iff_arg, harg]
    exact ⟨by intro h; linarith, by simp [e]⟩
  obtain ⟨ε, hε, hcont⟩ := Metric.continuousAt_iff.mp (Complex.continuousAt_arg hslit) η hη
  refine ⟨ε, hε, fun z x hzx hd => ?_⟩
  have hn : 0 < ‖z - x‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hzx)
  have hnc : (‖z - x‖ : ℂ) ≠ 0 := by exact_mod_cast hn.ne'
  set u : ℂ := (z - x) / (‖z - x‖ : ℂ) with hu
  have hzu : (z - x) * e (π - γ) = (‖z - x‖ : ℝ) * (u * e (π - γ)) := by
    rw [hu]; field_simp
  have h3 := hcont (x := u * e (π - γ)) (by
    rw [dist_eq_norm, ← hW, ← sub_mul, norm_mul, norm_e, mul_one]; exact hd)
  rw [hzu, Complex.arg_real_mul _ hn]
  rw [Real.dist_eq, harg] at h3
  exact h3



/-- Every real is congruent mod `2π` to one in `[θ₀, θ₀ + 2π)`. -/
theorem exists_shift_Ico (θ₀ x : ℝ) : ∃ m : ℤ, x + 2 * π * m ∈ Ico θ₀ (θ₀ + 2 * π) := by
  have hπ := Real.pi_pos
  refine ⟨-⌊(x - θ₀) / (2 * π)⌋, ?_, ?_⟩
  · have := Int.floor_le ((x - θ₀) / (2 * π))
    rw [le_div_iff₀ (by positivity)] at this
    push_cast; linarith
  · have := Int.lt_floor_add_one ((x - θ₀) / (2 * π))
    rw [div_lt_iff₀ (by positivity)] at this
    push_cast; linarith

/-- A `2π`-periodic set of angles is invariant under every integer shift. -/
theorem periodic_int {K : Set ℝ} (hper : ∀ β, β + 2 * π ∈ K ↔ β ∈ K) (β : ℝ) (m : ℤ) :
    β + 2 * π * m ∈ K ↔ β ∈ K := by
  induction m using Int.induction_on with
  | zero => simp
  | succ n ih =>
    have := hper (β + 2 * π * n)
    push_cast at ih ⊢
    rw [show β + 2 * π * ((n : ℝ) + 1) = β + 2 * π * n + 2 * π by ring, this, ih]
  | pred n ih =>
    have := hper (β + 2 * π * ((-(n : ℤ) - 1 : ℤ) : ℝ))
    rw [show β + 2 * π * ((-(n : ℤ) - 1 : ℤ) : ℝ) + 2 * π = β + 2 * π * ((-(n : ℤ) : ℤ) : ℝ) by push_cast; ring] at this
    rw [← this, ih]

/-- **A closed nonempty `2π`-periodic set of angles with no two separated points is one angular interval.** -/
theorem exists_angleIcc_of_no_gap {K : Set ℝ} (hK : IsClosed K) (hne : K.Nonempty)
    (hper : ∀ β, β + 2 * π ∈ K ↔ β ∈ K)
    (hgap : ∀ γ₁ a γ₂ b : ℝ, γ₁ < a → a < γ₂ → γ₂ < b → b < γ₁ + 2 * π → γ₁ ∉ K → γ₂ ∉ K → a ∈ K → b ∈ K →
      False) :
    ∃ β₁ β₂, β₁ ≤ β₂ ∧ β₂ ≤ β₁ + 2 * π ∧ K = angleIcc β₁ β₂ := by
  have hπ := Real.pi_pos
  by_cases hall : ∀ γ, γ ∈ K
  · refine ⟨0, 2 * π, by positivity, by linarith, ?_⟩
    ext y
    simp only [hall y, true_iff, angleIcc, mem_iUnion]
    obtain ⟨m, hm1, hm2⟩ := exists_shift_Ico 0 y
    refine ⟨-m, ?_, ?_⟩ <;> push_cast <;> linarith
  push Not at hall
  obtain ⟨γ, hγ⟩ := hall
  have hγ2 : γ + 2 * π ∉ K := fun h => hγ ((hper γ).mp h)
  set A := K ∩ Icc γ (γ + 2 * π) with hA
  have hAc : IsCompact A := isCompact_Icc.inter_left hK
  obtain ⟨k₀, hk₀⟩ := hne
  obtain ⟨m₀, hm₀⟩ := exists_shift_Ico γ k₀
  have hAne : A.Nonempty := ⟨k₀ + 2 * π * m₀, (periodic_int hper k₀ m₀).mpr hk₀,
    hm₀.1, hm₀.2.le⟩
  obtain ⟨β₁, hβ₁A, hβ₁min⟩ := hAc.exists_isMinOn hAne continuousOn_id
  obtain ⟨β₂, hβ₂A, hβ₂max⟩ := hAc.exists_isMaxOn hAne continuousOn_id
  have hβ₁lt : γ < β₁ := lt_of_le_of_ne hβ₁A.2.1 (fun h => hγ (h ▸ hβ₁A.1))
  have hβ₂lt : β₂ < γ + 2 * π := lt_of_le_of_ne hβ₂A.2.2 (fun h => hγ2 (h ▸ hβ₂A.1))
  have hβ12 : β₁ ≤ β₂ := hβ₁min hβ₂A
  have hIcc : Icc β₁ β₂ ⊆ K := by
    intro t ht
    by_contra htK
    have h1 : β₁ < t := lt_of_le_of_ne ht.1 (fun h => htK (h ▸ hβ₁A.1))
    have h2 : t < β₂ := lt_of_le_of_ne ht.2 (fun h => htK (h ▸ hβ₂A.1))
    exact hgap γ β₁ t β₂ hβ₁lt h1 h2 hβ₂lt hγ htK hβ₁A.1 hβ₂A.1
  refine ⟨β₁, β₂, hβ12, by linarith, ?_⟩
  ext k
  simp only [angleIcc, mem_iUnion]
  constructor
  · intro hk
    obtain ⟨m, hm⟩ := exists_shift_Ico γ k
    have hmem : k + 2 * π * m ∈ A := ⟨(periodic_int hper k m).mpr hk, hm.1, hm.2.le⟩
    have h1 : β₁ ≤ k + 2 * π * m := hβ₁min hmem
    have h2 : k + 2 * π * m ≤ β₂ := hβ₂max hmem
    refine ⟨-m, ?_, ?_⟩ <;> push_cast <;> linarith
  · rintro ⟨m, hm1, hm2⟩
    have : k + 2 * π * ((-m : ℤ) : ℝ) ∈ K := hIcc ⟨by push_cast; linarith, by push_cast; linarith⟩
    exact (periodic_int hper k (-m)).mp this


/-- The cone of a set at a point is closed. -/
theorem isClosed_coneAt (S : Set ℂ) (y : ℂ) : IsClosed (coneAt S y) := by
  rw [← isOpen_compl_iff, Metric.isOpen_iff]
  intro β hβ
  simp only [mem_compl_iff, coneAt, mem_setOf_eq, not_forall, not_exists, not_and, not_lt] at hβ
  obtain ⟨ε, hε, hnone⟩ := hβ
  refine ⟨ε / 2, half_pos hε, fun β' hβ' => ?_⟩
  simp only [mem_compl_iff, coneAt, mem_setOf_eq, not_forall, not_exists, not_and, not_lt]
  refine ⟨ε / 2, half_pos hε, fun z hzS hzy hzd => ?_⟩
  have h1 := hnone z hzS hzy (by linarith [hzd])
  have h2 : ‖e β' - e β‖ ≤ |β' - β| := norm_e_sub_e_le β' β
  rw [mem_ball, Real.dist_eq] at hβ'
  have h3 : ‖(z - y) / (‖z - y‖ : ℂ) - e β‖ ≤ ‖(z - y) / (‖z - y‖ : ℂ) - e β'‖ + ‖e β' - e β‖ := by
    calc _ = ‖((z - y) / (‖z - y‖ : ℂ) - e β') + (e β' - e β)‖ := by ring_nf
      _ ≤ _ := norm_add_le _ _
  linarith

/-- Open sets approach their points along every direction. -/
theorem mem_coneAt_of_mem_isOpen {T : Set ℂ} (hT : IsOpen T) {x : ℂ} (hx : x ∈ T) (β : ℝ) :
    β ∈ coneAt T x := by
  intro ε hε
  obtain ⟨r, hr, hrT⟩ := Metric.isOpen_iff.mp hT x hx
  set s : ℝ := min (r / 2) (ε / 2) with hs
  have hs0 : 0 < s := lt_min (half_pos hr) (half_pos hε)
  have hsr : s < r := lt_of_le_of_lt (min_le_left _ _) (by linarith)
  have hsε : s < ε := lt_of_le_of_lt (min_le_right _ _) (by linarith)
  have hd : ‖(s : ℂ) * e β‖ = s := by rw [norm_mul, Complex.norm_real, norm_e, mul_one, Real.norm_eq_abs, abs_of_pos hs0]
  refine ⟨x + (s : ℂ) * e β, hrT (by rw [mem_ball, dist_eq_norm, add_sub_cancel_left, hd]; exact hsr), ?_, ?_, ?_⟩
  · intro h
    have : (s : ℂ) * e β = 0 := by simpa using h
    rw [← norm_eq_zero, hd] at this
    exact hs0.ne' this
  · rw [dist_eq_norm, add_sub_cancel_left, hd]; exact hsε
  · rw [add_sub_cancel_left, hd]
    have : (s : ℂ) * e β / ((s : ℝ) : ℂ) = e β := by
      have : (s : ℂ) ≠ 0 := by exact_mod_cast hs0.ne'
      field_simp
    rw [this, sub_self, norm_zero]; exact hε

/-- A set whose closure holds `x`, and which has points of `x`'s punctured neighbourhoods arbitrarily near, has a
nonempty cone at `x`: the unit directions of such points have a limit point. -/
theorem coneAt_nonempty {T : Set ℂ} {x : ℂ} (h : ∀ ε > 0, ∃ z ∈ T, z ≠ x ∧ dist z x < ε) :
    (coneAt T x).Nonempty := by
  choose z hzT hzx hzd using fun n : ℕ => h (1 / ((n : ℝ) + 1)) (by positivity)
  set u : ℕ → ℂ := fun n => (z n - x) / (‖z n - x‖ : ℂ) with hu
  have hun : ∀ n, u n ∈ sphere (0 : ℂ) 1 := by
    intro n
    have hn : ‖z n - x‖ ≠ 0 := norm_ne_zero_iff.mpr (sub_ne_zero.mpr (hzx n))
    rw [mem_sphere_zero_iff_norm, hu]
    simp only [norm_div, Complex.norm_real, norm_norm]
    exact div_self hn
  obtain ⟨a, ha, φ, hφ, hlim⟩ := (isCompact_sphere (0 : ℂ) 1).tendsto_subseq hun
  have ha1 : ‖a‖ = 1 := by simpa using ha
  have hae : a = e (arg a) := by
    have := Complex.norm_mul_exp_arg_mul_I a
    rw [ha1] at this
    simpa [e] using this.symm
  refine ⟨arg a, fun ε hε => ?_⟩
  have h1 := (Metric.tendsto_atTop.mp hlim) ε hε
  obtain ⟨N₁, hN₁⟩ := h1
  obtain ⟨N₂, hN₂⟩ := exists_nat_gt (1 / ε)
  refine ⟨z (φ (max N₁ N₂)), hzT _, hzx _, ?_, ?_⟩
  · refine lt_of_lt_of_le (hzd _) ?_
    have hφn : max N₁ N₂ ≤ φ (max N₁ N₂) := hφ.id_le _
    have : (1 / ε) < ((φ (max N₁ N₂) : ℕ) : ℝ) + 1 := by
      have : (N₂ : ℝ) ≤ ((φ (max N₁ N₂) : ℕ) : ℝ) :=
        Nat.cast_le.mpr ((le_max_right _ _).trans hφn)
      linarith
    rw [div_le_iff₀ (by positivity)]
    rw [div_lt_iff₀ hε] at this
    nlinarith
  · have := hN₁ (max N₁ N₂) (le_max_left _ _)
    rw [dist_eq_norm] at this
    show ‖(z (φ (max N₁ N₂)) - x) / (‖z (φ (max N₁ N₂)) - x‖ : ℂ) - e (arg a)‖ < ε
    rw [← hae]; exact this

/-- **The cone of a Jordan domain's tile is one angular interval.** Near a point `x` of the closure, the tile's part in a
small disc lies in a preconnected piece of the tile in a slightly larger disc (the chart), so two separated directions of
the cone, with two directions the cone misses between them, cannot both be approached (`arg_side`). -/
theorem ArcMap.IsJordanDomain.coneAt_eq_angleIcc {T : Set ℂ} (hJ : ArcMap.IsJordanDomain T) (hTo : IsOpen T) {x : ℂ}
    (hx : x ∈ closure T) :
    ∃ β₁ β₂, β₁ ≤ β₂ ∧ β₂ ≤ β₁ + 2 * π ∧ coneAt T x = angleIcc β₁ β₂ := by
  have hnear : ∀ ε > 0, ∃ z ∈ T, z ≠ x ∧ dist z x < ε := by
    intro ε hε
    obtain ⟨z, hzT, hzd⟩ := Metric.mem_closure_iff.mp hx (ε / 2) (half_pos hε)
    by_cases hzx : z = x
    · subst hzx
      obtain ⟨r, hr, hrT⟩ := Metric.isOpen_iff.mp hTo z hzT
      refine ⟨z + ((min (r / 2) (ε / 2) : ℝ) : ℂ), hrT ?_, ?_, ?_⟩
      · rw [mem_ball, dist_eq_norm, add_sub_cancel_left, Complex.norm_real, Real.norm_eq_abs,
          abs_of_pos (lt_min (half_pos hr) (half_pos hε))]
        exact lt_of_le_of_lt (min_le_left _ _) (by linarith)
      · intro h
        have : ((min (r / 2) (ε / 2) : ℝ) : ℂ) = 0 := by simpa using h
        have := lt_min (half_pos hr) (half_pos hε)
        simp_all
      · rw [dist_eq_norm, add_sub_cancel_left, Complex.norm_real, Real.norm_eq_abs,
          abs_of_pos (lt_min (half_pos hr) (half_pos hε))]
        exact lt_of_le_of_lt (min_le_right _ _) (by linarith)
    · exact ⟨z, hzT, hzx, by rw [dist_comm]; linarith⟩
  refine exists_angleIcc_of_no_gap (isClosed_coneAt T x) (coneAt_nonempty hnear)
    (fun β => mem_coneAt_add_two_pi) ?_
  intro γ₁ a γ₂ b h1 h2 h3 h4 hγ₁ hγ₂ ha hb
  have hxT : x ∉ T := fun hxT => hγ₁ (mem_coneAt_of_mem_isOpen hTo hxT γ₁)
  -- the two missing directions give a radius below which no point of `T` lies near them
  have hmiss : ∀ γ, γ ∉ coneAt T x → ∃ ε > 0, ∀ z ∈ T, z ≠ x → dist z x < ε →
      ∀ s : ℝ, 0 < s → z - x ≠ s * e γ := by
    intro γ hγ
    simp only [coneAt, mem_setOf_eq, not_forall, not_exists, not_and, not_lt] at hγ
    obtain ⟨ε, hε, hnone⟩ := hγ
    refine ⟨ε, hε, fun z hzT hzx hzd s hs hzs => ?_⟩
    have h5 := hnone z hzT hzx hzd
    have hu : (z - x) / (‖z - x‖ : ℂ) = e γ := by
      rw [hzs, norm_mul, Complex.norm_real, norm_e, mul_one, Real.norm_eq_abs, abs_of_pos hs]
      have : (s : ℂ) ≠ 0 := by exact_mod_cast hs.ne'
      field_simp
    rw [hu, sub_self, norm_zero] at h5
    linarith
  obtain ⟨ε₁, hε₁, hm₁⟩ := hmiss γ₁ hγ₁
  obtain ⟨ε₂, hε₂, hm₂⟩ := hmiss γ₂ hγ₂
  obtain ⟨r', hr', C, hCT, hCb, hCpre, hCsub⟩ := hJ.local_connected hx (lt_min hε₁ hε₂)
  have hxC : x ∉ C := fun h => hxT (hCT h)
  have hzx : ∀ z ∈ C, z ≠ x := fun z hz h => hxC (h ▸ hz)
  have hside := arg_side hCpre hxC (γ := γ₁) (δ := γ₂ - γ₁)
    (fun z hz s hs => hm₁ z (hCT hz) (hzx z hz)
      (lt_of_lt_of_le (by simpa [dist_comm] using hCb hz) (min_le_left _ _)) s hs)
    (fun z hz s hs => by
      have := hm₂ z (hCT hz) (hzx z hz)
        (lt_of_lt_of_le (by simpa [dist_comm] using hCb hz) (min_le_right _ _)) s hs
      rwa [show γ₁ + (γ₂ - γ₁) = γ₂ by ring])
  -- a point of `T` near the direction `a`, and one near `b`
  obtain ⟨εa, hεa, hna⟩ := arg_near (γ := γ₁) (β := a) h1 (by linarith) (η := γ₂ - a) (by linarith)
  obtain ⟨εb, hεb, hnb⟩ := arg_near (γ := γ₁) (β := b) (by linarith) h4 (η := b - γ₂) (by linarith)
  obtain ⟨za, hzaT, hzax, hzad, hzau⟩ := ha (min r' εa) (lt_min hr' hεa)
  obtain ⟨zb, hzbT, hzbx, hzbd, hzbu⟩ := hb (min r' εb) (lt_min hr' hεb)
  have hza : za ∈ C := hCsub ⟨hzaT, by rw [mem_ball]; exact lt_of_lt_of_le hzad (min_le_left _ _)⟩
  have hzb : zb ∈ C := hCsub ⟨hzbT, by rw [mem_ball]; exact lt_of_lt_of_le hzbd (min_le_left _ _)⟩
  have hA := hna za x hzax (lt_of_lt_of_le hzau (min_le_right _ _))
  have hB := hnb zb x hzbx (lt_of_lt_of_le hzbu (min_le_right _ _))
  rw [abs_lt] at hA hB
  rcases hside with hs | hs
  · have := hs zb hzb
    linarith [hB.1]
  · have := hs za hza
    linarith [hA.2]

/-! ## Arcs against a unit circle -/

/-- A nondegenerate arc meets the unit circle `ω(p)` in finitely many points, unless it is an arc of `ω(p)` itself (a
line or a different circle meets `ω(p)` in at most two points). -/
theorem Arc.finite_inter_sphere_or_eq_circ (a : Arc) (ha : a.Nondegenerate) (p : ℂ) :
    (a.carrier ∩ sphere p 1).Finite ∨ ∃ θ₀ θ₁, a = .circ p 1 θ₀ θ₁ := by
  cases a with
  | seg a b =>
    left
    have hab : b - a ≠ 0 := sub_ne_zero.mpr (Ne.symm ha)
    set A : ℝ := ‖b - a‖ ^ 2
    set B : ℝ := 2 * ((a - p) * (starRingEnd ℂ) (b - a)).re
    set C : ℝ := ‖a - p‖ ^ 2 - 1
    have hA : A ≠ 0 := by positivity
    let q : Polynomial ℝ := Polynomial.C A * Polynomial.X ^ 2 + Polynomial.C B * Polynomial.X + Polynomial.C C
    have hq : q ≠ 0 := by
      intro h
      have := congrArg (fun r => Polynomial.coeff r 2) h
      simp [q, Polynomial.coeff_X_pow] at this
      exact hA this
    refine ((Polynomial.finite_setOf_isRoot hq).image (fun t : ℝ => a + (t : ℂ) * (b - a))).subset ?_
    rintro z ⟨hz, hzs⟩
    rw [Arc.carrier, segment_eq_image'] at hz
    obtain ⟨t, -, rfl⟩ := hz
    refine ⟨t, ?_, by simp [Complex.real_smul]⟩
    simp only [mem_sphere, dist_eq_norm] at hzs
    have h2 : ‖a + (t : ℂ) * (b - a) - p‖ ^ 2 = 1 := by
      simp only [Complex.real_smul] at hzs
      rw [hzs]; norm_num
    have h3 : ‖a - p + (t : ℂ) * (b - a)‖ ^ 2 = A * t ^ 2 + B * t + (C + 1) := by
      rw [Complex.sq_norm, Complex.normSq_apply]
      simp only [A, B, C, Complex.sq_norm, Complex.normSq_apply, Complex.add_re, Complex.add_im,
        Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, Complex.sub_re,
        Complex.sub_im, Complex.conj_re, Complex.conj_im]
      ring
    have h4 : a - p + (t : ℂ) * (b - a) = a + (t : ℂ) * (b - a) - p := by ring
    rw [h4, h2] at h3
    simp only [q, Set.mem_setOf_eq, Polynomial.IsRoot, Polynomial.eval_add, Polynomial.eval_mul,
      Polynomial.eval_C, Polynomial.eval_pow, Polynomial.eval_X]
    linarith
  | circ c ρ θ₀ θ₁ =>
    by_cases hcp : c = p
    · subst hcp
      by_cases hρ : ρ = 1
      · right; subst hρ; exact ⟨θ₀, θ₁, rfl⟩
      · left
        have : (Arc.circ c ρ θ₀ θ₁).carrier ∩ sphere c 1 = ∅ := by
          refine eq_empty_of_forall_notMem ?_
          rintro z ⟨⟨θ, -, rfl⟩, hz⟩
          simp only [mem_sphere, dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one,
            Complex.norm_real] at hz
          have hρ0 : 0 < ρ := ha.1
          rw [Real.norm_eq_abs, abs_of_pos hρ0] at hz
          exact hρ hz
        rw [this]; exact finite_empty
    · left
      have hsub : (Arc.circ c ρ θ₀ θ₁).carrier ∩ sphere p 1 ⊆ sphere c ρ ∩ sphere p 1 := by
        rintro z ⟨⟨θ, -, rfl⟩, hz⟩
        refine ⟨?_, hz⟩
        have hρ0 : 0 < ρ := ha.1
        simp [norm_e, abs_of_pos hρ0]
      refine Set.Finite.subset ?_ hsub
      by_cases hsub1 : (sphere c ρ ∩ sphere p 1 : Set ℂ).Subsingleton
      · exact hsub1.finite
      · obtain ⟨x, hx, y, hy, hxy⟩ := Set.not_subsingleton_iff.mp hsub1
        refine (Set.toFinite {x, y}).subset ?_
        intro z hz
        have := EuclideanGeometry.eq_of_dist_eq_of_dist_eq_of_finrank_eq_two
          (V := ℂ) (P := ℂ) Complex.finrank_real_complex hcp hxy hx.1 hy.1 hz.1 hx.2 hy.2 hz.2
        simpa using this

/-- A segment is a Lebesgue-null set of the plane (it lies in a proper affine subspace). -/
theorem volume_segment_eq_zero (a b : ℂ) : MeasureTheory.volume (segment ℝ a b) = 0 := by
  let s : AffineSubspace ℝ ℂ := AffineSubspace.mk' a (Submodule.span ℝ {b - a})
  have hsub : segment ℝ a b ⊆ (s : Set ℂ) := by
    rintro z ⟨u, v, hu, hv, huv, rfl⟩
    rw [SetLike.mem_coe, AffineSubspace.mem_mk']
    refine Submodule.mem_span_singleton.mpr ⟨v, ?_⟩
    have : u = 1 - v := by linarith
    subst this
    simp only [vsub_eq_sub, Complex.real_smul]
    push_cast; ring
  refine MeasureTheory.measure_mono_null hsub (MeasureTheory.Measure.addHaar_affineSubspace _ _ ?_)
  intro h
  have h1 : s.direction = ⊤ := by rw [h]; exact AffineSubspace.direction_top _ _ _
  rw [AffineSubspace.direction_mk'] at h1
  have h2 := finrank_span_le_card (R := ℝ) ({b - a} : Set ℂ)
  rw [h1, finrank_top, Complex.finrank_real_complex] at h2
  simp at h2

/-- The points of an arc form a Lebesgue-null set. -/
theorem Arc.volume_carrier (a : Arc) : MeasureTheory.volume a.carrier = 0 := by
  cases a with
  | seg a b => exact volume_segment_eq_zero a b
  | circ c ρ θ₀ θ₁ =>
    refine MeasureTheory.measure_mono_null (t := sphere c |ρ|) ?_
      (MeasureTheory.Measure.addHaar_sphere _ _ _)
    rintro _ ⟨θ, -, rfl⟩
    simp [norm_e]

/-- The carrier of the arc `circ p 1 θ₀ θ₁` is the closed sub-arc `r([θ₀, θ₁])` of `ω(p)`. -/
theorem carrier_circ_unit (p : ℂ) (θ₀ θ₁ : ℝ) : (Arc.circ p 1 θ₀ θ₁).carrier = ringArc p θ₀ θ₁ := by
  simp [Arc.carrier, ringArc, ringPt]

/-- `a` is an arc of the unit circle `ω(p)`. -/
def Arc.OnRing (p : ℂ) (a : Arc) : Prop := ∃ θ₀ θ₁, a = .circ p 1 θ₀ θ₁

/-- An arc on `ω(p)` has its carrier on `ω(p)`. -/
theorem Arc.OnRing.carrier_subset_sphere {p : ℂ} {a : Arc} (h : a.OnRing p) : a.carrier ⊆ sphere p 1 := by
  obtain ⟨θ₀, θ₁, rfl⟩ := h
  rw [carrier_circ_unit]
  rintro _ ⟨θ, -, rfl⟩
  exact ringPt_mem_sphere p θ

/-- The polar point `p + ρ e(ψ)`. -/
noncomputable def polarPt (p : ℂ) (ρ ψ : ℝ) : ℂ := p + (ρ : ℂ) * e ψ

/-- The polar map is continuous. -/
theorem continuous_polarPt (p : ℂ) : Continuous (fun q : ℝ × ℝ => polarPt p q.1 q.2) := by
  unfold polarPt e; fun_prop

/-- The distance from the centre of a polar point is `|ρ|`. -/
theorem norm_polarPt_sub (p : ℂ) (ρ ψ : ℝ) : ‖polarPt p ρ ψ - p‖ = |ρ| := by
  simp [polarPt]

/-- A polar point at radius within `ε` of `1` and angle within `κ` of `φ` is within `ε + κ` of `r(φ)`. -/
theorem dist_polarPt_ringPt_le (p : ℂ) (ρ ψ φ : ℝ) :
    dist (polarPt p ρ ψ) (ringPt p φ) ≤ |ρ - 1| + |ψ - φ| := by
  have h1 : polarPt p ρ ψ - ringPt p φ = ((ρ - 1 : ℝ) : ℂ) * e ψ + (e ψ - e φ) := by
    simp only [polarPt, ringPt]; push_cast; ring
  rw [dist_eq_norm, h1]
  refine (norm_add_le _ _).trans ?_
  rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs]
  linarith [norm_e_sub_e_le ψ φ]

/-- `|‖z − p‖ − 1| ≤ dist z r(φ)`. -/
theorem abs_norm_sub_one_le (p z : ℂ) (φ : ℝ) : |‖z - p‖ - 1| ≤ dist z (ringPt p φ) := by
  have := abs_norm_sub_norm_le (z - p) (e φ)
  rw [norm_e, show z - p - e φ = z - ringPt p φ by simp only [ringPt]; ring] at this
  exact this.trans (dist_eq_norm _ _).symm.le

/-- **Polar neighbourhoods**: every point `z` near `r(φ)` is `p + ρ e(ψ)` with `ρ = ‖z − p‖` near `1` and `ψ` in a given open
interval about `φ`. -/
theorem polar_nbhd (p : ℂ) {φ α β : ℝ} (h : φ ∈ Ioo α β) :
    ∃ ν > 0, ∀ z : ℂ, dist z (ringPt p φ) < ν →
      |‖z - p‖ - 1| < ν ∧ ∃ ψ ∈ Ioo α β, z = polarPt p ‖z - p‖ ψ := by
  have hc : ContinuousAt Complex.arg (1 : ℂ) :=
    Complex.continuousAt_arg (by simp [Complex.mem_slitPlane_iff])
  obtain ⟨ν', hν', harg⟩ := Metric.continuousAt_iff.mp hc (min (φ - α) (β - φ))
    (lt_min (by linarith [h.1]) (by linarith [h.2]))
  refine ⟨ν', hν', fun z hz => ⟨?_, ?_⟩⟩
  · exact lt_of_le_of_lt (abs_norm_sub_one_le p z φ) hz
  · set w : ℂ := (z - p) * (starRingEnd ℂ) (e φ) with hw
    have hconj : e φ * (starRingEnd ℂ) (e φ) = 1 := e_mul_conj_e φ
    have hdw : dist w 1 < ν' := by
      have : w - 1 = (z - ringPt p φ) * (starRingEnd ℂ) (e φ) := by
        rw [hw]; simp only [ringPt]
        linear_combination hconj
      rw [dist_eq_norm, this, norm_mul, Complex.norm_conj, norm_e, mul_one, ← dist_eq_norm]
      exact hz
    have ha := harg hdw
    rw [Complex.arg_one, Real.dist_eq, sub_zero] at ha
    have hlt := lt_of_lt_of_le ha (min_le_left _ _)
    have hlt' := lt_of_lt_of_le ha (min_le_right _ _)
    rw [abs_lt] at hlt hlt'
    refine ⟨φ + Complex.arg w, ⟨by linarith [hlt.1], by linarith [hlt'.2]⟩, ?_⟩
    have hwn : ‖w‖ = ‖z - p‖ := by rw [hw, norm_mul, Complex.norm_conj, norm_e, mul_one]
    have h3 := Complex.norm_mul_exp_arg_mul_I w
    have h4 : z - p = w * e φ := by rw [hw, mul_assoc, mul_comm (starRingEnd ℂ (e φ)), hconj, mul_one]
    unfold polarPt
    rw [← hwn, e_add, show ((‖w‖ : ℝ) : ℂ) * (e φ * e (Complex.arg w)) = ((‖w‖ : ℂ) * e (Complex.arg w)) * e φ by ring]
    have h5 : ((‖w‖ : ℝ) : ℂ) * e (Complex.arg w) = w := by rw [e]; exact h3
    rw [h5, ← h4]; ring

/-- `e a = e b` exactly when `a − b` is an integer multiple of `2π`. -/
theorem e_eq_e_iff {a b : ℝ} : e a = e b ↔ ∃ n : ℤ, a = b + n * (2 * π) := by
  rw [e, e, Complex.exp_eq_exp_iff_exists_int]
  constructor
  · rintro ⟨n, hn⟩
    refine ⟨n, ?_⟩
    have := congrArg Complex.im hn
    simpa using this
  · rintro ⟨n, hn⟩
    exact ⟨n, by rw [hn]; push_cast; ring⟩

/-- Every angle is congruent mod `2π` to one in `[θ₀, θ₀ + 2π]`. -/
theorem exists_mem_Icc_e_eq (θ₀ x : ℝ) : ∃ ψ ∈ Icc θ₀ (θ₀ + 2 * π), e ψ = e x := by
  have hπ := Real.pi_pos
  refine ⟨x - ⌊(x - θ₀) / (2 * π)⌋ * (2 * π), ⟨?_, ?_⟩, e_eq_e_iff.mpr ⟨-⌊(x - θ₀) / (2 * π)⌋, by push_cast; ring⟩⟩
  · have := Int.floor_le ((x - θ₀) / (2 * π))
    rw [le_div_iff₀ (by positivity)] at this
    linarith
  · have := Int.lt_floor_add_one ((x - θ₀) / (2 * π))
    rw [div_lt_iff₀ (by positivity)] at this
    linarith

/-- `e t ≠ 1` for `0 < |t| < 2π`. -/
theorem e_ne_one {t : ℝ} (h0 : t ≠ 0) (h1 : |t| < 2 * π) : e t ≠ 1 := by
  intro h
  have h' : e t = e 0 := by rw [h]; simp [e]
  obtain ⟨n, hn⟩ := e_eq_e_iff.mp h'
  have hπ := Real.pi_pos
  rw [zero_add] at hn
  rcases lt_trichotomy n 0 with hn0 | hn0 | hn0
  · have : (n : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_iff.mpr hn0
    have : t ≤ -(2 * π) := by rw [hn]; nlinarith
    rw [abs_of_neg (by linarith)] at h1; linarith
  · subst hn0; simp at hn; exact h0 hn
  · have : (1 : ℝ) ≤ n := by exact_mod_cast hn0
    have : 2 * π ≤ t := by rw [hn]; nlinarith
    rw [abs_of_pos (by linarith)] at h1; linarith

/-- A ring point `t ≥ 0` along a side of `r(θ)` is within `t` of it. -/
theorem dist_ringPt_side_le (p : ℂ) (θ : ℝ) (s : Side) {t : ℝ} (ht : 0 ≤ t) :
    dist (ringPt p (θ + s.sign * t)) (ringPt p θ) ≤ t := by
  have h1 := norm_e_sub_e_le (θ + s.sign * t) θ
  have hs : |s.sign| = 1 := by cases s <;> simp [Side.sign]
  rw [dist_eq_norm]
  simp only [ringPt, add_sub_add_left_eq_sub]
  calc _ ≤ |θ + s.sign * t - θ| := h1
    _ = t := by rw [add_sub_cancel_left, abs_mul, hs, one_mul, abs_of_nonneg ht]

/-- A point of the germ of `ω(p)` of length `δ` is within `δ` of the base point. -/
theorem dist_lt_of_mem_germ {p : ℂ} {θ : ℝ} {s : Side} {δ : ℝ} {x : ℂ} (h : x ∈ germ p θ s δ) :
    dist x (ringPt p θ) < δ := by
  obtain ⟨t, ⟨ht0, htδ⟩, rfl⟩ := h
  have h1 := norm_e_sub_e_le (θ + s.sign * t) θ
  have hs : |s.sign| = 1 := by cases s <;> simp [Side.sign]
  rw [dist_eq_norm]
  simp only [ringPt, add_sub_add_left_eq_sub]
  calc _ ≤ |θ + s.sign * t - θ| := h1
    _ = t := by rw [add_sub_cancel_left, abs_mul, hs, one_mul, abs_of_pos ht0]
    _ < δ := htδ

/-- The base point of a germ of length below `2π` is not on it. -/
theorem ringPt_notMem_germ {p : ℂ} {θ : ℝ} {s : Side} {δ : ℝ} (hδ : δ ≤ 2 * π) : ringPt p θ ∉ germ p θ s δ := by
  rintro ⟨t, ⟨ht0, htδ⟩, h⟩
  have hs : |s.sign| = 1 := by cases s <;> simp [Side.sign]
  have h1 : e (s.sign * t) = 1 := by
    have h2 : e (θ + s.sign * t) = e θ := by simpa [ringPt] using h
    rw [e_add] at h2
    have hne : e θ ≠ 0 := fun h0 => by simpa [h0] using norm_e θ
    exact mul_left_cancel₀ hne (by rw [h2, mul_one])
  exact e_ne_one (by cases s <;> simp [Side.sign] <;> exact ht0.ne')
    (by rw [abs_mul, hs, one_mul, abs_of_pos ht0]; linarith) h1

/-- The germ is preconnected. -/
theorem isPreconnected_germ (p : ℂ) (θ : ℝ) (s : Side) (δ : ℝ) : IsPreconnected (germ p θ s δ) :=
  isPreconnected_Ioo.image _ (by unfold ringPt e; fun_prop)

/-- The angles of the closed (open) sub-arc of the germ's side of `θ` of length `δ` are `θ + sign · u` for `u ∈ [0, δ]`
(`(0, δ)`). -/
theorem sideInterval (θ δ : ℝ) (hδ : 0 < δ) (s : Side) :
    θ < θ + δ ∧ (s = .ccw → ∀ φ, (φ ∈ Icc θ (θ + δ) ↔ ∃ u ∈ Icc 0 δ, φ = θ + s.sign * u)) ∧
      (s = .cw → ∀ φ, (φ ∈ Icc (θ - δ) θ ↔ ∃ u ∈ Icc 0 δ, φ = θ + s.sign * u)) := by
  refine ⟨by linarith, ?_, ?_⟩
  · rintro rfl φ
    simp only [Side.sign, one_mul]
    constructor
    · intro h; exact ⟨φ - θ, ⟨by linarith [h.1], by linarith [h.2]⟩, by ring⟩
    · rintro ⟨u, hu, rfl⟩; exact ⟨by linarith [hu.1], by linarith [hu.2]⟩
  · rintro rfl φ
    simp only [Side.sign]
    constructor
    · intro h; exact ⟨θ - φ, ⟨by linarith [h.2], by linarith [h.1]⟩, by ring⟩
    · rintro ⟨u, hu, rfl⟩; exact ⟨by linarith [hu.2], by linarith [hu.1]⟩

/-- **A germ that an arc of `ω(p)` meets arbitrarily close to its base point lies in it** (for short germs): `r(θ)` lies on
the arc `r([θ₀, θ₁])` and every germ of length `δ` meets it. -/
theorem exists_germ_subset_ringArc {p : ℂ} {θ θ₀ θ₁ : ℝ} (hlt : θ₀ < θ₁) (hle : θ₁ ≤ θ₀ + 2 * π) (s : Side)
    (hy : ringPt p θ ∈ ringArc p θ₀ θ₁) (hhit : ∀ δ > 0, (germ p θ s δ ∩ ringArc p θ₀ θ₁).Nonempty)
    {δ₀ : ℝ} (hδ₀ : 0 < δ₀) : ∃ δ' > 0, δ' ≤ δ₀ ∧ germ p θ s δ' ⊆ ringArc p θ₀ θ₁ := by
  have hπ := Real.pi_pos
  have hs : |s.sign| = 1 := by cases s <;> simp [Side.sign]
  by_cases hfull : θ₁ = θ₀ + 2 * π
  · refine ⟨δ₀, hδ₀, le_rfl, ?_⟩
    rintro _ ⟨t, -, rfl⟩
    obtain ⟨ψ, hψ, hψe⟩ := exists_mem_Icc_e_eq θ₀ (θ + s.sign * t)
    exact ⟨ψ, ⟨hψ.1, by rw [hfull]; exact hψ.2⟩, by simp [ringPt, hψe]⟩
  · have hg : 0 < 2 * π - (θ₁ - θ₀) := by
      have : θ₁ < θ₀ + 2 * π := lt_of_le_of_ne hle hfull
      linarith
    set δ' := min δ₀ ((2 * π - (θ₁ - θ₀)) / 2) with hδ'
    have hδ'0 : 0 < δ' := lt_min hδ₀ (by linarith)
    obtain ⟨z, ⟨t, ⟨ht0, htδ⟩, rfl⟩, ψ, hψ, hψz⟩ := hhit δ' hδ'0
    obtain ⟨φ₀, hφ₀, hφ₀e⟩ := hy
    have heθ : e θ = e φ₀ := by simpa [ringPt] using hφ₀e.symm
    have h1 : e ψ = e (φ₀ + s.sign * t) := by
      have h2 : e ψ = e (θ + s.sign * t) := by simpa [ringPt] using hψz
      rw [h2, e_add, e_add, heθ]
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp h1
    have htδ' : t < (2 * π - (θ₁ - θ₀)) / 2 := lt_of_lt_of_le htδ (min_le_right _ _)
    have hst : |s.sign * t| = t := by rw [abs_mul, hs, one_mul, abs_of_pos ht0]
    have hst' := abs_le.mp hst.le
    have hn0 : n = 0 := by
      by_contra hne
      rcases lt_or_gt_of_ne hne with hneg | hpos
      · have : (n : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_iff.mpr hneg
        nlinarith [hψ.1, hφ₀.2]
      · have : (1 : ℝ) ≤ n := by exact_mod_cast hpos
        nlinarith [hψ.2, hφ₀.1]
    subst hn0
    simp only [Int.cast_zero, zero_mul, add_zero] at hn
    have hψ' : φ₀ + s.sign * t ∈ Icc θ₀ θ₁ := hn ▸ hψ
    refine ⟨t, ht0, lt_of_lt_of_le htδ (min_le_left _ _) |>.le, ?_⟩
    rintro _ ⟨u, ⟨hu0, hut⟩, rfl⟩
    have hconv : φ₀ + s.sign * u ∈ Icc θ₀ θ₁ := by
      have hl : u / t ∈ Icc (0 : ℝ) 1 := ⟨by positivity, by rw [div_le_one ht0]; exact hut.le⟩
      have : φ₀ + s.sign * u = (1 - u / t) * φ₀ + (u / t) * (φ₀ + s.sign * t) := by field_simp; ring
      rw [this]
      exact (convex_Icc θ₀ θ₁) hφ₀ hψ' (by linarith [hl.2]) hl.1 (by ring)
    refine ⟨φ₀ + s.sign * u, hconv, ?_⟩
    simp only [ringPt]
    rw [e_add, e_add, heθ]

/-- The cone of a finite union is the union of the cones. -/
theorem coneAt_biUnion_finite {ι : Type*} {s : Set ι} (hs : s.Finite) (T : ι → Set ℂ) {y : ℂ} {β : ℝ}
    (h : β ∈ coneAt (⋃ i ∈ s, T i) y) : ∃ i ∈ s, β ∈ coneAt (T i) y := by
  by_contra hcon
  push Not at hcon
  have ev : ∀ᶠ ε in 𝓝[>] (0 : ℝ), ∀ i ∈ s, ∀ z ∈ T i,
      ¬ (z ≠ y ∧ dist z y < ε ∧ ‖(z - y) / (‖z - y‖ : ℂ) - e β‖ < ε) := by
    refine (eventually_all_finite hs).mpr fun i hi => ?_
    have := hcon i hi
    simp only [coneAt, mem_setOf_eq, not_forall, not_exists, not_and] at this
    obtain ⟨ε₀, hε₀, hz⟩ := this
    filter_upwards [Ioo_mem_nhdsGT hε₀] with ε hε z hz' ⟨h1, h2, h3⟩
    exact hz z hz' h1 (h2.trans hε.2) (h3.trans hε.2)
  have ev0 : ∀ᶠ ε in 𝓝[>] (0 : ℝ), 0 < ε := self_mem_nhdsWithin
  obtain ⟨ε, hε0, hε⟩ := (ev0.and ev).exists
  obtain ⟨z, hz, hz1, hz2, hz3⟩ := h ε hε0
  obtain ⟨i, hi, hzi⟩ := mem_iUnion₂.mp hz
  exact hε i hi z hzi ⟨hz1, hz2, hz3⟩


/-- The cone at `y` is local: it sees only a ball about `y`. -/
theorem coneAt_inter_ball {S : Set ℂ} {y : ℂ} {r : ℝ} (hr : 0 < r) {β : ℝ} (h : β ∈ coneAt S y) :
    β ∈ coneAt (S ∩ ball y r) y := by
  intro ε hε
  obtain ⟨z, hz, hne, hd, hdir⟩ := h (min ε r) (lt_min hε hr)
  exact ⟨z, ⟨hz, by rw [mem_ball]; exact hd.trans_le (min_le_right _ _)⟩, hne, hd.trans_le (min_le_left _ _),
    hdir.trans_le (min_le_left _ _)⟩

/-! ## Curves through a point, and a farthest-point lemma beside them -/

/-- The full curve through `x` with data `(κ, b)`: `κ = 0` the line through `x` normal to `b`, `κ = 1` the circle through
`x` centred at `x + b`. -/
def curveAt (x : ℂ) (κ : ℝ) (b : ℂ) : Set ℂ :=
  {z | κ * Complex.normSq (z - x) = 2 * ((z - x) * (starRingEnd ℂ) b).re}

/-- A point scaled away from `x` along the ray through `w` stays off the curve, if `w` lies outside it (or off the line). -/
theorem mem_curveAt_scale {x : ℂ} {κ : ℝ} {b w : ℂ}
    (hout : (κ = 0 ∧ ((w - x) * (starRingEnd ℂ) b).re ≠ 0) ∨ (κ = 1 ∧ 2 * ((w - x) * (starRingEnd ℂ) b).re < Complex.normSq (w - x)))
    {t : ℝ} (ht : 1 ≤ t) : x + (t : ℂ) * (w - x) ∉ curveAt x κ b := by
  intro h
  simp only [curveAt, mem_setOf_eq, add_sub_cancel_left] at h
  have e1 : Complex.normSq ((t : ℂ) * (w - x)) = t ^ 2 * Complex.normSq (w - x) := by
    rw [map_mul, Complex.normSq_ofReal]; ring
  have e2 : (((t : ℂ) * (w - x)) * (starRingEnd ℂ) b).re = t * ((w - x) * (starRingEnd ℂ) b).re := by
    rw [mul_assoc, Complex.re_ofReal_mul]
  rw [e1, e2] at h
  rcases hout with ⟨rfl, hne⟩ | ⟨rfl, hlt⟩
  · apply hne; nlinarith
  · have hN : 0 ≤ Complex.normSq (w - x) := Complex.normSq_nonneg _
    have ht0 : 0 < t := by linarith
    have h2 : t * Complex.normSq (w - x) = 2 * ((w - x) * (starRingEnd ℂ) b).re := by
      apply mul_left_cancel₀ ht0.ne'; nlinarith
    nlinarith


/-- The outward case of `exists_farther`: from a point outside the circle (or off the line) go radially away from `x`. -/
theorem farther_out {x z : ℂ} {κ : ℝ} {b w : ℂ}
    (hout : (κ = 0 ∧ ((w - x) * (starRingEnd ℂ) b).re ≠ 0) ∨ (κ = 1 ∧ 2 * ((w - x) * (starRingEnd ℂ) b).re < Complex.normSq (w - x)))
    {δ : ℝ} (hδ0 : 0 < δ) (hδ : δ ≤ ‖z - x‖) (hw : dist w z < δ / 3) :
    ∃ w' : ℂ, ‖z - x‖ < ‖w' - x‖ ∧ segment ℝ w w' ⊆ ball z δ ∧ Disjoint (segment ℝ w w') (curveAt x κ b) := by
  set m := w - x with hm
  have hdz : |‖m‖ - ‖z - x‖| ≤ dist w z := by
    calc |‖m‖ - ‖z - x‖| ≤ ‖w - x - (z - x)‖ := abs_norm_sub_norm_le _ _
      _ = dist w z := by rw [dist_eq_norm]; congr 1; ring
  have hmpos : 0 < ‖m‖ := by
    have := (abs_le.mp hdz).2
    have := (abs_le.mp hdz).1
    linarith
  set T : ℝ := 1 + (δ / 2) / ‖m‖ with hT
  have hT1 : 1 ≤ T := by rw [hT]; have : 0 ≤ (δ / 2) / ‖m‖ := by positivity
                         linarith
  have hTm : (T - 1) * ‖m‖ = δ / 2 := by rw [hT]; field_simp; ring
  refine ⟨x + (T : ℂ) * m, ?_, ?_, ?_⟩
  · rw [add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (by linarith)]
    have : T * ‖m‖ = ‖m‖ + δ / 2 := by nlinarith
    rw [this]
    have := (abs_le.mp hdz).1
    linarith
  · intro y hy
    obtain ⟨a, c, ha, hc, hac, rfl⟩ := hy
    have hy : a • w + c • (x + (T : ℂ) * m) = x + ((a + c * T : ℝ) : ℂ) * m := by
      have : a = 1 - c := by linarith
      subst this
      simp only [Complex.real_smul, hm]; push_cast; ring
    rw [hy, mem_ball, dist_eq_norm]
    have h1 : x + ((a + c * T : ℝ) : ℂ) * m - z = (w - z) + ((c * (T - 1) : ℝ) : ℂ) * m := by
      have : a + c * T = 1 + c * (T - 1) := by
        have : a = 1 - c := by linarith
        subst this; ring
      rw [this, hm]; push_cast; ring
    rw [h1]
    refine lt_of_le_of_lt (norm_add_le _ _) ?_
    rw [norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (by nlinarith), ← dist_eq_norm]
    have hc1 : c ≤ 1 := by linarith
    have : c * (T - 1) * ‖m‖ ≤ δ / 2 := by
      calc c * (T - 1) * ‖m‖ = c * ((T - 1) * ‖m‖) := by ring
        _ ≤ 1 * ((T - 1) * ‖m‖) := by gcongr
        _ = δ / 2 := by rw [hTm]; ring
    linarith
  · rw [Set.disjoint_left]
    intro y hy
    obtain ⟨a, c, ha, hc, hac, rfl⟩ := hy
    have hy : a • w + c • (x + (T : ℂ) * m) = x + ((a + c * T : ℝ) : ℂ) * (w - x) := by
      have : a = 1 - c := by linarith
      subst this
      simp only [Complex.real_smul, hm]; push_cast; ring
    rw [hy]
    exact mem_curveAt_scale hout (by nlinarith)


/-- The two coordinate identities of the inward step of `farther_in`. -/
theorem circle_step_real (p1 p2 b1 b2 s β ε : ℝ) (hE1 : p1 ^ 2 + p2 ^ 2 = 2 * (p1 * b1 + p2 * b2))
    (hE2 : p1 ^ 2 + p2 ^ 2 = s ^ 2) (hE3 : b1 ^ 2 + b2 ^ 2 = β ^ 2) :
    (p1 - b1 + ε * ((β - s) * p1 + s * b1)) ^ 2 + (p2 - b2 + ε * ((β - s) * p2 + s * b2)) ^ 2 =
        β ^ 2 - ε * s * β * (2 * β - s) + ε ^ 2 * (((β - s) * p1 + s * b1) ^ 2 + ((β - s) * p2 + s * b2) ^ 2) ∧
    (p1 + ε * ((β - s) * p1 + s * b1)) ^ 2 + (p2 + ε * ((β - s) * p2 + s * b2)) ^ 2 =
        s ^ 2 + 2 * ε * s ^ 2 * (β - s / 2) + ε ^ 2 * (((β - s) * p1 + s * b1) ^ 2 + ((β - s) * p2 + s * b2) ^ 2) := by
  constructor
  · linear_combination (1 + ε * (β - 2 * s)) * hE1 + ε * β * hE2 + (1 - 2 * ε * s) * hE3
  · linear_combination (1 + 2 * ε * (β - s / 2)) * hE2 - ε * s * hE1


/-- The inward case of `exists_farther`: from a point inside the circle step into the disc along `(β − s) p + s b`, a direction that enters the disc and leaves the circle about `x`. -/
theorem farther_in {x z b w : ℂ} (hb : b ≠ 0) (hz : z ∈ curveAt x 1 b) (hd : 0 < ‖z - x‖)
    (hbig : ‖z - x‖ < 2 * ‖b‖) {δ : ℝ} (hδ0 : 0 < δ) (hw : dist w z < δ)
    (hin : Complex.normSq (w - x) < 2 * ((w - x) * (starRingEnd ℂ) b).re) :
    ∃ w' : ℂ, ‖z - x‖ < ‖w' - x‖ ∧ segment ℝ w w' ⊆ ball z δ ∧ Disjoint (segment ℝ w w') (curveAt x 1 b) := by
  set p := z - x with hp
  set s := ‖p‖ with hs
  set β := ‖b‖ with hβ
  have hβ0 : 0 < β := norm_pos_iff.mpr hb
  have hs0 : 0 < s := hd
  have hz' : Complex.normSq p = 2 * (p * (starRingEnd ℂ) b).re := by simpa [curveAt, hp] using hz
  set ξ : ℂ := ((β - s : ℝ) : ℂ) * p + (s : ℂ) * b with hξ
  have hξn : ‖ξ‖ ≤ 2 * β * s := by
    refine (norm_add_le _ _).trans ?_
    rw [norm_mul, norm_mul, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs, Real.norm_eq_abs,
      abs_of_pos hs0, ← hs, ← hβ]
    have : |β - s| ≤ β := by rw [abs_le]; constructor <;> linarith
    nlinarith
  set M : ℝ := 2 * β * s with hM
  have hM0 : 0 < M := by positivity
  set ε : ℝ := min (δ / (2 * M)) (s * β * (2 * β - s) / (2 * M ^ 2)) with hε
  have hε0 : 0 < ε := lt_min (by positivity) (div_pos (by have : 0 < 2 * β - s := by linarith
                                                          positivity) (by positivity))
  have hε1 : ε * M ≤ δ / 2 := by
    have := min_le_left (δ / (2 * M)) (s * β * (2 * β - s) / (2 * M ^ 2))
    calc ε * M ≤ δ / (2 * M) * M := by gcongr
      _ = δ / 2 := by field_simp
  have hε2 : ε * M ^ 2 ≤ s * β * (2 * β - s) / 2 := by
    have := min_le_right (δ / (2 * M)) (s * β * (2 * β - s) / (2 * M ^ 2))
    calc ε * M ^ 2 ≤ s * β * (2 * β - s) / (2 * M ^ 2) * M ^ 2 := by gcongr
      _ = s * β * (2 * β - s) / 2 := by field_simp
  set w' : ℂ := z + (ε : ℂ) * ξ with hw'
  have hξ1 : ((β - s) * p.re + s * b.re) = ξ.re := by simp [hξ]
  have hξ2 : ((β - s) * p.im + s * b.im) = ξ.im := by simp [hξ]
  have hE1 : p.re ^ 2 + p.im ^ 2 = 2 * (p.re * b.re + p.im * b.im) := by
    have := hz'
    simp only [Complex.normSq_apply, Complex.mul_re, Complex.conj_re, Complex.conj_im] at this
    nlinarith
  have hE2 : p.re ^ 2 + p.im ^ 2 = s ^ 2 := by
    rw [hs, Complex.sq_norm, Complex.normSq_apply]; ring
  have hE3 : b.re ^ 2 + b.im ^ 2 = β ^ 2 := by
    rw [hβ, Complex.sq_norm, Complex.normSq_apply]; ring
  obtain ⟨k1, k2⟩ := circle_step_real p.re p.im b.re b.im s β ε hE1 hE2 hE3
  rw [hξ1, hξ2] at k1 k2
  have hξsq : ξ.re ^ 2 + ξ.im ^ 2 ≤ M ^ 2 := by
    have := Complex.sq_norm ξ
    rw [Complex.normSq_apply] at this
    nlinarith [norm_nonneg ξ]
  have hdist : dist w' z = ε * ‖ξ‖ := by
    rw [hw', dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hε0]
  have hw'z : dist w' z < δ := by
    rw [hdist]
    have : ε * ‖ξ‖ ≤ ε * M := by gcongr
    linarith
  -- w' lies in the open disc
  have hw'in : dist w' (x + b) < β := by
    rw [dist_eq_norm]
    have h1 : w' - (x + b) = (p - b) + (ε : ℂ) * ξ := by rw [hw', hp]; ring
    rw [h1]
    refine lt_of_pow_lt_pow_left₀ 2 hβ0.le ?_
    rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]
    simp only [Complex.add_re, Complex.sub_re, Complex.add_im, Complex.sub_im, Complex.mul_re, Complex.mul_im,
      Complex.ofReal_re, Complex.ofReal_im, zero_mul, sub_zero, add_zero]
    have a1 : ε ^ 2 * (ξ.re ^ 2 + ξ.im ^ 2) ≤ ε * (s * β * (2 * β - s) / 2) := by
      calc ε ^ 2 * (ξ.re ^ 2 + ξ.im ^ 2) ≤ ε ^ 2 * M ^ 2 := by gcongr
        _ = ε * (ε * M ^ 2) := by ring
        _ ≤ ε * (s * β * (2 * β - s) / 2) := by gcongr
    have a2 : 0 < ε * (s * β * (2 * β - s)) := by
      have : 0 < 2 * β - s := by linarith
      positivity
    linarith [k1, a1, a2]
  have hwin : dist w (x + b) < β := by
    rw [dist_eq_norm]
    refine lt_of_pow_lt_pow_left₀ 2 hβ0.le ?_
    rw [← Complex.normSq_eq_norm_sq, show w - (x + b) = (w - x) - b by ring, Complex.normSq_sub]
    have : Complex.normSq b = β ^ 2 := by rw [hβ, Complex.normSq_eq_norm_sq]
    rw [this]; linarith
  refine ⟨w', ?_, ?_, ?_⟩
  · refine lt_of_pow_lt_pow_left₀ 2 (norm_nonneg _) ?_
    have h1 : w' - x = p + (ε : ℂ) * ξ := by rw [hw', hp]; ring
    have h3 : ‖w' - x‖ ^ 2 = (p.re + ε * ξ.re) ^ 2 + (p.im + ε * ξ.im) ^ 2 := by
      rw [h1, Complex.sq_norm, Complex.normSq_apply]
      simp only [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im,
        Complex.ofReal_re, Complex.ofReal_im, zero_mul, sub_zero, add_zero]
      ring
    have h4 : ‖z - x‖ ^ 2 = s ^ 2 := rfl
    rw [h3, h4, k2]
    have : 0 < 2 * ε * s ^ 2 * (β - s / 2) := by
      have : 0 < β - s / 2 := by linarith
      positivity
    have := mul_nonneg (sq_nonneg ε) (add_nonneg (sq_nonneg ξ.re) (sq_nonneg ξ.im))
    linarith
  · have hconv : Convex ℝ (ball (x + b) β ∩ ball z δ) := (convex_ball _ _).inter (convex_ball _ _)
    intro y hy
    exact (hconv.segment_subset ⟨hwin, by rwa [mem_ball]⟩ ⟨hw'in, by rwa [mem_ball]⟩ hy).2
  · have hconv : Convex ℝ (ball (x + b) β ∩ ball z δ) := (convex_ball _ _).inter (convex_ball _ _)
    rw [Set.disjoint_left]
    intro y hy hyc
    have hyD := hconv.segment_subset ⟨hwin, by rwa [mem_ball]⟩ ⟨hw'in, by rwa [mem_ball]⟩ hy
    have h1 := hyD.1
    rw [mem_ball, dist_eq_norm] at h1
    simp only [curveAt, mem_setOf_eq, one_mul] at hyc
    have h2 : Complex.normSq (y - x - b) = Complex.normSq (y - x) + Complex.normSq b - 2 * ((y - x) * (starRingEnd ℂ) b).re := Complex.normSq_sub _ _
    have h3 : Complex.normSq b = β ^ 2 := by rw [hβ, Complex.normSq_eq_norm_sq]
    have h4 : Complex.normSq (y - x - b) < β ^ 2 := by
      rw [Complex.normSq_eq_norm_sq, show y - x - b = y - (x + b) by ring]
      exact pow_lt_pow_left₀ h1 (norm_nonneg _) two_ne_zero
    linarith


/-- **Farther points beside a curve** (the farthest-point lemma's local step): near a point `z ≠ x` of a curve through `x`
(a line, or a circle of diameter above `‖z − x‖`), every point `w` off the curve is joined, by a segment off the curve and
inside `B(z, δ)`, to a point strictly farther from `x` than `z`. -/
theorem exists_farther {x z : ℂ} {κ : ℝ} (hκ : κ = 0 ∨ κ = 1) {b : ℂ} (hb : b ≠ 0)
    (hz : z ∈ curveAt x κ b) (hd : 0 < ‖z - x‖) (hbig : κ = 1 → ‖z - x‖ < 2 * ‖b‖)
    {δ : ℝ} (hδ0 : 0 < δ) (hδ : δ ≤ ‖z - x‖) {w : ℂ} (hw : dist w z < δ / 3) (hwc : w ∉ curveAt x κ b) :
    ∃ w' : ℂ, ‖z - x‖ < ‖w' - x‖ ∧ segment ℝ w w' ⊆ ball z δ ∧ Disjoint (segment ℝ w w') (curveAt x κ b) := by
  rcases hκ with rfl | rfl
  · refine farther_out (Or.inl ⟨rfl, ?_⟩) hδ0 hδ hw
    intro h; apply hwc; simp only [curveAt, mem_setOf_eq, zero_mul]; linarith
  · rcases lt_or_gt_of_ne (show Complex.normSq (w - x) ≠ 2 * ((w - x) * (starRingEnd ℂ) b).re by
        intro h; apply hwc; simpa [curveAt] using h) with h | h
    · exact farther_in hb hz hd (hbig rfl) hδ0 (by linarith) h
    · exact farther_out (Or.inr ⟨rfl, h⟩) hδ0 hδ hw


/-- `Re (m · conj b)` in coordinates. -/
theorem re_mul_conj_eq (m b : ℂ) : (m * (starRingEnd ℂ) b).re = m.re * b.re + m.im * b.im := by
  simp [Complex.mul_re]

/-- A nonzero complex number has nonzero squared coordinates sum. -/
theorem sq_re_im_ne {b : ℂ} (hb : b ≠ 0) : b.re ^ 2 + b.im ^ 2 ≠ 0 := by
  have := Complex.normSq_pos.mpr hb
  rw [Complex.normSq_apply] at this
  nlinarith

/-- A complex number with zero coordinates is `0`. -/
theorem eq_of_re_im {m : ℂ} (h1 : m.re = 0) (h2 : m.im = 0) : m = 0 := Complex.ext (by simpa using h1) (by simpa using h2)

/-- A vector `m` perpendicular to `d` on the circle `|m|² = 2 m·b` is `0` or has `|m|²|d|² = 4 (d × b)²`. -/
theorem perp_circle (m1 m2 d1 d2 b1 b2 : ℝ) (hd : d1 ^ 2 + d2 ^ 2 ≠ 0) (h1 : m1 * d1 + m2 * d2 = 0)
    (h2 : m1 ^ 2 + m2 ^ 2 = 2 * (m1 * b1 + m2 * b2)) :
    (m1 = 0 ∧ m2 = 0) ∨ (m1 ^ 2 + m2 ^ 2) * (d1 ^ 2 + d2 ^ 2) = 4 * (d1 * b2 - d2 * b1) ^ 2 := by
  set q := m1 * d2 - m2 * d1 with hq
  set c := d1 * b2 - d2 * b1 with hc
  have e1 : q ^ 2 = (m1 ^ 2 + m2 ^ 2) * (d1 ^ 2 + d2 ^ 2) := by
    have : (m1 ^ 2 + m2 ^ 2) * (d1 ^ 2 + d2 ^ 2) = (m1 * d1 + m2 * d2) ^ 2 + q ^ 2 := by rw [hq]; ring
    rw [this, h1]; ring
  have e2 : (m1 * b1 + m2 * b2) * (d1 ^ 2 + d2 ^ 2) = -q * c := by
    have : (m1 * b1 + m2 * b2) * (d1 ^ 2 + d2 ^ 2) = (m1 * d1 + m2 * d2) * (b1 * d1 + b2 * d2) - q * c := by
      rw [hq, hc]; ring
    rw [this, h1]; ring
  have e3 : q * (q + 2 * c) = 0 := by
    have : (m1 ^ 2 + m2 ^ 2) * (d1 ^ 2 + d2 ^ 2) = 2 * (m1 * b1 + m2 * b2) * (d1 ^ 2 + d2 ^ 2) := by rw [h2]
    nlinarith
  rcases mul_eq_zero.mp e3 with h | h
  · left
    have hN : (m1 ^ 2 + m2 ^ 2) * (d1 ^ 2 + d2 ^ 2) = 0 := by rw [← e1, h]; ring
    have hN' : m1 ^ 2 + m2 ^ 2 = 0 := by
      rcases mul_eq_zero.mp hN with h' | h'
      · exact h'
      · exact absurd h' hd
    constructor <;> nlinarith [sq_nonneg m1, sq_nonneg m2]
  · right
    rw [← e1]
    have : q = -2 * c := by linarith
    rw [this]; ring

/-- Two distinct full curves through `x` meet near `x` only at `x`. -/
theorem curve_inter {x : ℂ} {κ κ' : ℝ} (hκ : κ = 0 ∨ κ = 1) (hκ' : κ' = 0 ∨ κ' = 1) {b b' : ℂ} (hb : b ≠ 0)
    (hb' : b' ≠ 0)
    (hsame : ¬ (κ = κ' ∧ (κ = 1 → b = b') ∧ (κ = 0 → (b * (starRingEnd ℂ) b').im = 0))) :
    ∃ ε > 0, ∀ z : ℂ, ‖z - x‖ < ε → z ∈ curveAt x κ b → z ∈ curveAt x κ' b' → z = x := by
  have hnb : b.re ^ 2 + b.im ^ 2 ≠ 0 := sq_re_im_ne hb
  have hnb' : b'.re ^ 2 + b'.im ^ 2 ≠ 0 := sq_re_im_ne hb'
  -- the shared shape: a direction `d ≠ 0` with `m ⊥ d`, and the circle `N = 2 m·e`
  have key : ∀ (d e : ℂ), d.re ^ 2 + d.im ^ 2 ≠ 0 →
      ∃ ε > 0, ∀ z : ℂ, ‖z - x‖ < ε → (z - x).re * d.re + (z - x).im * d.im = 0 →
        (z - x).re ^ 2 + (z - x).im ^ 2 = 2 * ((z - x).re * e.re + (z - x).im * e.im) → z = x := by
    intro d e hd
    by_cases hc : d.re * e.im - d.im * e.re = 0
    · refine ⟨1, one_pos, fun z _ h1 h2 => ?_⟩
      rcases perp_circle _ _ _ _ _ _ hd h1 h2 with ⟨h3, h4⟩ | h
      · exact sub_eq_zero.mp (eq_of_re_im h3 h4)
      · rw [hc] at h
        have hN : ((z - x).re ^ 2 + (z - x).im ^ 2) * (d.re ^ 2 + d.im ^ 2) = 0 := by rw [h]; ring
        have hN' : (z - x).re ^ 2 + (z - x).im ^ 2 = 0 := by
          rcases mul_eq_zero.mp hN with h' | h'
          · exact h'
          · exact absurd h' hd
        exact sub_eq_zero.mp (eq_of_re_im (by nlinarith [sq_nonneg (z - x).re, sq_nonneg (z - x).im]) (by nlinarith [sq_nonneg (z - x).re, sq_nonneg (z - x).im]))
    · have hdpos : 0 < d.re ^ 2 + d.im ^ 2 := lt_of_le_of_ne (by positivity) (Ne.symm hd)
      refine ⟨2 * |d.re * e.im - d.im * e.re| / Real.sqrt (d.re ^ 2 + d.im ^ 2), by positivity, fun z hz h1 h2 => ?_⟩
      rcases perp_circle _ _ _ _ _ _ hd h1 h2 with ⟨h3, h4⟩ | h
      · exact sub_eq_zero.mp (eq_of_re_im h3 h4)
      · exfalso
        have hn : ‖z - x‖ ^ 2 = (z - x).re ^ 2 + (z - x).im ^ 2 := by rw [Complex.sq_norm, Complex.normSq_apply]; ring
        have hs : Real.sqrt (d.re ^ 2 + d.im ^ 2) ^ 2 = d.re ^ 2 + d.im ^ 2 := Real.sq_sqrt hdpos.le
        have hspos : 0 < Real.sqrt (d.re ^ 2 + d.im ^ 2) := Real.sqrt_pos.mpr hdpos
        have h5 : ‖z - x‖ * Real.sqrt (d.re ^ 2 + d.im ^ 2) < 2 * |d.re * e.im - d.im * e.re| := by
          rwa [lt_div_iff₀ hspos] at hz
        have h6 : (‖z - x‖ * Real.sqrt (d.re ^ 2 + d.im ^ 2)) ^ 2 = 4 * |d.re * e.im - d.im * e.re| ^ 2 := by
          rw [mul_pow, hn, hs, h, sq_abs]
        have h7 : 0 ≤ ‖z - x‖ * Real.sqrt (d.re ^ 2 + d.im ^ 2) := by positivity
        have h8 : 0 ≤ 2 * |d.re * e.im - d.im * e.re| := by positivity
        nlinarith
  simp only [curveAt, mem_setOf_eq, re_mul_conj_eq, Complex.normSq_apply]
  rcases hκ with rfl | rfl <;> rcases hκ' with rfl | rfl
  · -- two lines
    have hdet : b.im * b'.re - b.re * b'.im ≠ 0 := by
      intro h; apply hsame; refine ⟨rfl, fun h' => absurd h' (by norm_num), fun _ => ?_⟩
      simpa [Complex.mul_im] using (by linarith : b.re * -b'.im + b.im * b'.re = 0)
    refine ⟨1, one_pos, fun z _ h1 h2 => ?_⟩
    have e1 : (z - x).re * b.re + (z - x).im * b.im = 0 := by linarith
    have e2 : (z - x).re * b'.re + (z - x).im * b'.im = 0 := by linarith
    have m1 : (z - x).re = 0 := by
      have : (z - x).re * (b.im * b'.re - b.re * b'.im) = 0 := by linear_combination (-b'.im) * e1 + b.im * e2
      rcases mul_eq_zero.mp this with h | h
      · exact h
      · exact absurd h hdet
    have m2 : (z - x).im = 0 := by
      have : (z - x).im * (b.im * b'.re - b.re * b'.im) = 0 := by linear_combination b'.re * e1 - b.re * e2
      rcases mul_eq_zero.mp this with h | h
      · exact h
      · exact absurd h hdet
    exact sub_eq_zero.mp (eq_of_re_im m1 m2)
  · -- κ = 0, κ' = 1
    obtain ⟨ε, hε, hk⟩ := key b b' hnb
    refine ⟨ε, hε, fun z hz h1 h2 => hk z hz (by linarith) (by linarith)⟩
  · -- κ = 1, κ' = 0
    obtain ⟨ε, hε, hk⟩ := key b' b hnb'
    refine ⟨ε, hε, fun z hz h1 h2 => hk z hz (by linarith) (by linarith)⟩
  · -- two circles
    have hne : b - b' ≠ 0 := by
      intro h; apply hsame; exact ⟨rfl, fun _ => sub_eq_zero.mp h, fun h' => absurd h' (by norm_num)⟩
    obtain ⟨ε, hε, hk⟩ := key (b - b') b (sq_re_im_ne hne)
    refine ⟨ε, hε, fun z hz h1 h2 => hk z hz ?_ (by linarith)⟩
    show (z - x).re * (b.re - b'.re) + (z - x).im * (b.im - b'.im) = 0
    linear_combination (1 / 2) * h2 - (1 / 2) * h1


/-- Curves with the same data (a circle with its centre; parallel lines) coincide. -/
theorem curveAt_eq_of_same {x : ℂ} {κ κ' : ℝ} (hκ : κ = 0 ∨ κ = 1) {b b' : ℂ} (hb : b ≠ 0) (hb' : b' ≠ 0)
    (hsame : κ = κ' ∧ (κ = 1 → b = b') ∧ (κ = 0 → (b * (starRingEnd ℂ) b').im = 0)) :
    curveAt x κ b = curveAt x κ' b' := by
  obtain ⟨rfl, h1, h0⟩ := hsame
  by_cases hk : κ = 1
  · rw [h1 hk]
  · by_cases hk0 : κ = 0
    · have hdet := h0 hk0
      simp only [Complex.mul_im, Complex.conj_re, Complex.conj_im] at hdet
      have hnb := sq_re_im_ne hb
      have hnb' := sq_re_im_ne hb'
      ext z
      simp only [curveAt, mem_setOf_eq, re_mul_conj_eq, hk0, zero_mul]
      constructor
      · intro h
        have h' : (z - x).re * b.re + (z - x).im * b.im = 0 := by linarith
        have : ((z - x).re * b'.re + (z - x).im * b'.im) * (b.re ^ 2 + b.im ^ 2) = 0 := by
          linear_combination (b.re * b'.re + b.im * b'.im) * h' + ((z - x).re * b.im - (z - x).im * b.re) * hdet
        rcases mul_eq_zero.mp this with h2 | h2
        · linarith
        · exact absurd h2 hnb
      · intro h
        have h' : (z - x).re * b'.re + (z - x).im * b'.im = 0 := by linarith
        have : ((z - x).re * b.re + (z - x).im * b.im) * (b'.re ^ 2 + b'.im ^ 2) = 0 := by
          linear_combination (b.re * b'.re + b.im * b'.im) * h' - ((z - x).re * b'.im - (z - x).im * b'.re) * hdet
        rcases mul_eq_zero.mp this with h2 | h2
        · linarith
        · exact absurd h2 hnb'
    · exfalso
      rcases hκ with h | h
      · exact hk0 h
      · exact hk h


/-- The data `(κ, b)` of the full curve carrying an arc through `x`: the line through `x` along a segment, the circle through
`x` about the centre of a circular arc. -/
noncomputable def Arc.curveData (x : ℂ) : Arc → ℝ × ℂ
  | .seg u v => (0, I * (v - u))
  | .circ c _ _ _ => (1, c - x)

/-- The full curve through `x` carrying an arc. -/
def Arc.curve (x : ℂ) (a : Arc) : Set ℂ := curveAt x (a.curveData x).1 (a.curveData x).2

/-- The `κ` of an arc's curve data is `0` or `1`. -/
theorem Arc.curveData_kappa (x : ℂ) (a : Arc) : (a.curveData x).1 = 0 ∨ (a.curveData x).1 = 1 := by
  cases a <;> simp [Arc.curveData]

/-- The vector of an arc's curve data is nonzero for a nondegenerate arc through `x`. -/
theorem Arc.curveData_ne {x : ℂ} {a : Arc} (ha : a.Nondegenerate) (hx : x ∈ a.carrier) : (a.curveData x).2 ≠ 0 := by
  cases a with
  | seg u v =>
    simp only [Arc.curveData]
    exact mul_ne_zero Complex.I_ne_zero (sub_ne_zero.mpr (Ne.symm ha))
  | circ c ρ θ₀ θ₁ =>
    simp only [Arc.curveData]
    obtain ⟨θ, -, rfl⟩ := hx
    intro h
    have : ρ * e θ = 0 := by
      have h' : c - (c + ρ * e θ) = 0 := h
      linear_combination -h'
    rw [mul_eq_zero] at this
    rcases this with h2 | h2
    · exact ha.1.ne' (by exact_mod_cast h2)
    · simpa using congrArg norm h2

/-- An arc through `x` lies on its full curve through `x`. -/
theorem Arc.carrier_subset_curve {x : ℂ} {a : Arc} (hx : x ∈ a.carrier) : a.carrier ⊆ a.curve x := by
  cases a with
  | seg u v =>
    intro z hz
    obtain ⟨a1, b1, -, -, hab1, rfl⟩ := hx
    obtain ⟨a2, b2, -, -, hab2, rfl⟩ := hz
    have hd : (a2 • u + b2 • v) - (a1 • u + b1 • v) = ((b2 - b1 : ℝ) : ℂ) * (v - u) := by
      have e1 : a1 = 1 - b1 := by linarith
      have e2 : a2 = 1 - b2 := by linarith
      subst e1 e2
      simp only [Complex.real_smul]; push_cast; ring
    simp only [Arc.curve, Arc.curveData, curveAt, mem_setOf_eq, hd, zero_mul]
    rw [map_mul, Complex.conj_I]
    have : ((b2 - b1 : ℝ) : ℂ) * (v - u) * (-I * (starRingEnd ℂ) (v - u)) =
        -(((b2 - b1 : ℝ) : ℂ) * I) * ((v - u) * (starRingEnd ℂ) (v - u)) := by ring
    rw [this, Complex.mul_conj]
    simp
  | circ c ρ θ₀ θ₁ =>
    intro z hz
    obtain ⟨θ', -, rfl⟩ := hx
    obtain ⟨θ, -, rfl⟩ := hz
    simp only [Arc.curve, Arc.curveData, curveAt, mem_setOf_eq, one_mul, re_mul_conj_eq, Complex.normSq_apply]
    have hn : ‖ρ * e θ‖ = ‖ρ * e θ'‖ := by simp [norm_e]
    have h2 := Complex.sq_norm (ρ * e θ)
    have h3 := Complex.sq_norm (ρ * e θ')
    rw [Complex.normSq_apply] at h2 h3
    rw [hn] at h2
    simp only [Complex.sub_re, Complex.sub_im, Complex.add_re, Complex.add_im]
    nlinarith


/-- An open nonempty set has a point off any curve. -/
theorem exists_notMem_curveAt {x : ℂ} {κ : ℝ} (hκ : κ = 0 ∨ κ = 1) {b : ℂ} (hb : b ≠ 0) {O : Set ℂ}
    (hO : IsOpen O) (hne : O.Nonempty) : ∃ w ∈ O, w ∉ curveAt x κ b := by
  by_contra hcon
  push Not at hcon
  obtain ⟨z, hz⟩ := hne
  have hzc := hcon z hz
  rcases hκ with rfl | rfl
  · obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp hO z hz
    have hb0 : 0 < ‖b‖ := norm_pos_iff.mpr hb
    set η : ℝ := ε / (2 * ‖b‖) with hη
    have hη0 : 0 < η := by positivity
    have hmem : z + (η : ℂ) * b ∈ ball z ε := by
      rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hη0, hη]
      field_simp; linarith
    have := hcon _ (hball hmem)
    simp only [curveAt, mem_setOf_eq, zero_mul] at this hzc
    have e1 : (z + (η : ℂ) * b - x) = (z - x) + (η : ℂ) * b := by ring
    rw [e1, add_mul, Complex.add_re, mul_assoc, Complex.mul_conj, Complex.re_ofReal_mul] at this
    have h2 : ((z - x) * (starRingEnd ℂ) b).re = 0 := by linarith
    rw [h2] at this
    simp at this
    rcases this with h | h
    · exact hη0.ne' h
    · exact hb (Complex.normSq_eq_zero.mp (by simpa using h))
  · have hsph : curveAt x 1 b = sphere (x + b) ‖b‖ := by
      ext y
      simp only [curveAt, mem_setOf_eq, one_mul, mem_sphere_iff_norm]
      have h1 : Complex.normSq (y - x - b) = Complex.normSq (y - x) + Complex.normSq b - 2 * ((y - x) * (starRingEnd ℂ) b).re := Complex.normSq_sub _ _
      have h2 : ‖y - (x + b)‖ ^ 2 = Complex.normSq (y - x - b) := by
        rw [Complex.sq_norm]; congr 1; ring
      have h3 : ‖b‖ ^ 2 = Complex.normSq b := Complex.sq_norm b
      constructor
      · intro h
        have : ‖y - (x + b)‖ ^ 2 = ‖b‖ ^ 2 := by rw [h2, h3, h1]; linarith
        exact (sq_eq_sq₀ (norm_nonneg _) (norm_nonneg _)).mp this
      · intro h
        have : ‖y - (x + b)‖ ^ 2 = ‖b‖ ^ 2 := by rw [h]
        rw [h2, h3, h1] at this; linarith
    have hsub : O ⊆ interior (sphere (x + b) ‖b‖) := by
      rw [← hsph]; exact hO.subset_interior_iff.mpr hcon
    rw [interior_sphere'] at hsub
    exact hsub hz

/-- The points `m` of a circle about `0` with fixed inner product against `b ≠ 0` are finitely many (at most two). -/
theorem finite_perp_circle (b : ℂ) (hb : b ≠ 0) (c K : ℝ) :
    {m : ℂ | m.re * b.re + m.im * b.im = c ∧ m.re ^ 2 + m.im ^ 2 = K}.Finite := by
  have hB := sq_re_im_ne hb
  set B := b.re ^ 2 + b.im ^ 2 with hBdef
  have hroot : {v : ℝ | v ^ 2 = c ^ 2 * 0 + (K * B - c ^ 2)}.Finite := by
    by_cases h : ∃ v₀ : ℝ, v₀ ^ 2 = c ^ 2 * 0 + (K * B - c ^ 2)
    · obtain ⟨v₀, hv₀⟩ := h
      refine (Set.toFinite ({v₀, -v₀} : Set ℝ)).subset fun v hv => ?_
      simp only [mem_setOf_eq] at hv
      rcases sq_eq_sq_iff_eq_or_eq_neg.mp (hv.trans hv₀.symm) with h | h
      · exact Or.inl h
      · exact Or.inr (by simpa using h)
    · push Not at h
      exact (Set.finite_empty).subset fun v hv => absurd hv (h v)
  refine (hroot.image fun v : ℝ => (⟨(c * b.re + v * b.im) / B, (c * b.im - v * b.re) / B⟩ : ℂ)).subset ?_
  intro m ⟨h1, h2⟩
  refine ⟨m.re * b.im - m.im * b.re, ?_, ?_⟩
  · simp only [mem_setOf_eq]
    have : (m.re * b.im - m.im * b.re) ^ 2 + c ^ 2 = K * B := by
      rw [← h1, ← h2, hBdef]; ring
    linarith
  · apply Complex.ext
    · simp only
      field_simp
      rw [← h1]; ring
    · simp only
      field_simp
      rw [← h1]; ring

/-- A curve through `x` meets a circle about `x` in finitely many points. -/
theorem finite_curve_inter_sphere {x : ℂ} {κ : ℝ} {b : ℂ} (hb : b ≠ 0) (ρ : ℝ) :
    (curveAt x κ b ∩ sphere x ρ).Finite := by
  have := (finite_perp_circle b hb (κ * ρ ^ 2 / 2) (ρ ^ 2)).image (fun m : ℂ => x + m)
  refine this.subset ?_
  intro z ⟨hz1, hz2⟩
  refine ⟨z - x, ⟨?_, ?_⟩, by ring⟩
  · simp only [curveAt, mem_setOf_eq, re_mul_conj_eq, Complex.normSq_apply] at hz1
    have hn : ‖z - x‖ = ρ := by rwa [mem_sphere_iff_norm] at hz2
    have : (z - x).re * (z - x).re + (z - x).im * (z - x).im = ρ ^ 2 := by
      have h3 : ‖z - x‖ ^ 2 = ρ ^ 2 := by rw [hn]
      rw [Complex.sq_norm, Complex.normSq_apply] at h3; exact h3
    rw [this] at hz1
    linarith
  · have hn : ‖z - x‖ = ρ := by rwa [mem_sphere_iff_norm] at hz2
    have h3 : ‖z - x‖ ^ 2 = ρ ^ 2 := by rw [hn]
    rw [Complex.sq_norm, Complex.normSq_apply] at h3
    nlinarith

/-- A function on an interval that is locally constant off a finite set takes finitely many values off it. -/
theorem finite_image_of_locConst {β : Type*} (g : ℝ → β) {Θ : Set ℝ} (hΘ : Θ.Finite) :
    ∀ {a b : ℝ}, (∀ t ∈ Ioo a b, t ∉ Θ → ∀ᶠ s in 𝓝 t, g s = g t) → (g '' (Ioo a b \ Θ)).Finite := by
  induction Θ, hΘ using Set.Finite.induction_on with
  | empty =>
    intro a b hloc
    rw [sdiff_empty]
    have hc : ∀ s ∈ Ioo a b, ∀ t ∈ Ioo a b, g s = g t := by
      intro s hs t ht
      let f : Ioo a b → β := fun u => g u
      have hf : IsLocallyConstant f := by
        rw [IsLocallyConstant.iff_eventually_eq]
        intro u
        have := hloc u u.2 (by simp)
        exact (continuous_subtype_val.continuousAt.eventually this)
      haveI : PreconnectedSpace (Ioo a b) := Subtype.preconnectedSpace isPreconnected_Ioo
      exact hf.apply_eq_of_preconnectedSpace ⟨s, hs⟩ ⟨t, ht⟩
    by_cases hne : (Ioo a b).Nonempty
    · obtain ⟨t₀, ht₀⟩ := hne
      exact (Set.finite_singleton (g t₀)).subset (by
        rintro _ ⟨t, ht, rfl⟩
        exact hc t ht t₀ ht₀)
    · rw [Set.not_nonempty_iff_eq_empty.mp hne]; simp
  | insert hθ hfin ih =>
    rename_i θ₀ Θ'
    intro a b hloc
    by_cases hmem : θ₀ ∈ Ioo a b
    · have h1 := ih (a := a) (b := θ₀) (fun t ht htn => hloc t ⟨ht.1, ht.2.trans hmem.2⟩
        (by rintro (h | h); exacts [ht.2.ne h, htn h]))
      have h2 := ih (a := θ₀) (b := b) (fun t ht htn => hloc t ⟨hmem.1.trans ht.1, ht.2⟩
        (by rintro (h | h); exacts [ht.1.ne' h, htn h]))
      refine (h1.union h2).subset ?_
      rintro _ ⟨t, ⟨ht, htn⟩, rfl⟩
      have : t ≠ θ₀ := fun h => htn (Or.inl h)
      have htn' : t ∉ Θ' := fun h => htn (Or.inr h)
      rcases lt_or_gt_of_ne this with h | h
      · exact Or.inl ⟨t, ⟨⟨ht.1, h⟩, htn'⟩, rfl⟩
      · exact Or.inr ⟨t, ⟨⟨h, ht.2⟩, htn'⟩, rfl⟩
    · refine (ih (a := a) (b := b) fun t ht htn => hloc t ht ?_).subset ?_
      · rintro (h | h)
        · exact hmem (h ▸ ht)
        · exact htn h
      · rintro _ ⟨t, ⟨ht, htn⟩, rfl⟩
        refine ⟨t, ⟨ht, fun h => htn (Or.inr h)⟩, rfl⟩


namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-! ## The disc of radius above 1 -/

/-- A fragment covers `B̄(p, 1)` exactly when it covers a closed disc of radius above `1` about `p`: the domain is open and
the disc compact. Every row's "on a closed disc of radius above 1 about `p`" is stated as `F.Covers p 1`. -/
theorem covers_one_iff (p : ℂ) : F.Covers p 1 ↔ ∃ R, 1 < R ∧ F.Covers p R := by
  constructor
  · intro h
    obtain ⟨δ, hδ, hsub⟩ := isCompact_closedBall p (1 : ℝ) |>.exists_cthickening_subset_open F.isOpen_dom h
    refine ⟨δ + 1, by linarith, ?_⟩
    have := cthickening_closedBall (E := ℂ) hδ.le zero_le_one p
    rw [this] at hsub
    exact hsub
  · rintro ⟨R, hR, h⟩
    exact (closedBall_subset_closedBall hR.le).trans h

/-! ## The points of `Γ` on a ring that lie on no arc of `Γ` on it -/

/-- On a covered ring, the points of `Γ` that lie on no arc of `Γ` on `ω(p)` are finitely many: the ring is compact, each
of its points has a neighbourhood meeting finitely many arcs, and each arc not on `ω(p)` meets `ω(p)` in finitely many
points (`Arc.finite_inter_sphere_or_eq_circ`). -/
theorem finite_ringΓ_off_ringArc {p : ℂ} (hp : F.Covers p 1) :
    ((F.Γ ∩ sphere p 1) \ {x | F.OnRingArc p x}).Finite := by
  have hK : sphere p 1 ⊆ F.dom := sphere_subset_closedBall.trans hp
  choose! t ht hfin using F.locallyFinite
  obtain ⟨S, hSK, hcov⟩ := (isCompact_sphere p 1).elim_nhds_subcover t fun x hx => ht x (hK hx)
  have h𝒜 : {a | a ∈ F.arcs ∧ (a.carrier ∩ sphere p 1).Nonempty}.Finite := by
    refine (S.finite_toSet.biUnion fun x hx => hfin x (hK (hSK x hx))).subset ?_
    rintro a ⟨ha, y, hya, hyK⟩
    obtain ⟨x, hxS, hyx⟩ := mem_iUnion₂.mp (hcov hyK)
    exact mem_iUnion₂.mpr ⟨x, hxS, ha, y, hya, hyx⟩
  have hsub : (F.Γ ∩ sphere p 1) \ {x | F.OnRingArc p x} ⊆
      ⋃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ sphere p 1).Nonempty},
        (a.carrier ∩ sphere p 1) \ {x | F.OnRingArc p x} := by
    rintro x ⟨⟨⟨hxd, hxΓ⟩, hxK⟩, hxn⟩
    obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp hxΓ
    exact mem_iUnion₂.mpr ⟨a, ⟨ha, x, hxa, hxK⟩, ⟨hxa, hxK⟩, hxn⟩
  refine (h𝒜.biUnion fun a ha => ?_).subset hsub
  rcases Arc.finite_inter_sphere_or_eq_circ a (F.nondegenerate a ha.1) p with h | ⟨θ₀, θ₁, rfl⟩
  · exact h.subset sdiff_subset
  · refine (finite_empty).subset ?_
    rintro x ⟨⟨hxa, hxK⟩, hxn⟩
    apply hxn
    have hnd := F.nondegenerate _ ha.1
    have hcar : (Arc.circ p 1 θ₀ θ₁).carrier = ringArc p θ₀ θ₁ := by
      simp [Arc.carrier, ringArc, ringPt]
    refine ⟨θ₀, θ₁, hnd.2.1, ?_, ?_⟩
    · rw [← hcar]; exact hxa
    · rw [← hcar]
      intro z hz
      refine ⟨hK ?_, mem_iUnion₂.mpr ⟨_, ha.1, hz⟩⟩
      obtain ⟨θ, -, rfl⟩ := hz
      simp


/-! ## Interior points are dense -/

/-- `Γ` has empty interior: every point of the domain is a limit of interior points. -/
theorem dense_interiorPts : F.dom ⊆ closure F.interiorPts := by
  intro x hx
  rw [Metric.mem_closure_iff]
  intro ε hε
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite x hx
  obtain ⟨r, hr, hrsub⟩ := Metric.mem_nhds_iff.mp (inter_mem ht (F.isOpen_dom.mem_nhds hx))
  set r' := min r ε
  have hr' : 0 < r' := lt_min hr hε
  set N : Set ℂ := ⋃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ t).Nonempty}, a.carrier
  have hN : MeasureTheory.volume N = 0 :=
    (MeasureTheory.measure_biUnion_null_iff hfin.countable).mpr fun a _ => a.volume_carrier
  have hpos : 0 < MeasureTheory.volume (ball x r') := Metric.measure_ball_pos _ _ hr'
  have hnot : ¬ ball x r' ⊆ N := fun h =>
    absurd (MeasureTheory.measure_mono_null h hN) hpos.ne'
  obtain ⟨y, hy, hyN⟩ := not_subset.mp hnot
  have hyr : y ∈ ball x r := ball_subset_ball (min_le_left _ _) hy
  refine ⟨y, ⟨(hrsub hyr).2, fun hΓ => hyN ?_⟩, ?_⟩
  · obtain ⟨a, ha, hya⟩ := mem_iUnion₂.mp hΓ
    exact mem_iUnion₂.mpr ⟨a, ⟨ha, y, hya, (hrsub hyr).1⟩, hya⟩
  · rw [dist_comm]
    exact lt_of_lt_of_le (mem_ball.mp hy) (min_le_right _ _)

/-- Every point of the domain carries a colour. -/
theorem exists_mem_coloursAt {x : ℂ} (hx : x ∈ F.dom) : ∃ c, c ∈ F.coloursAt x := by
  have hx' := F.dense_interiorPts hx
  have : F.interiorPts = ⋃ c, F.region c := by
    ext y
    simp only [mem_iUnion, region, mem_inter_iff, mem_preimage, mem_singleton_iff]
    exact ⟨fun h => ⟨F.col y, h, rfl⟩, fun ⟨_, h, _⟩ => h⟩
  rw [this, closure_iUnion_of_finite] at hx'
  obtain ⟨c, hc⟩ := mem_iUnion.mp hx'
  exact ⟨c, hc⟩

/-! ## A ray from a point of the domain into the interior points -/

/-- A line meets a circle in finitely many points: `{s | ‖x + s w − c‖ = ρ}` is finite when `w ≠ 0`. -/
theorem finite_ray_inter_sphere (x c w : ℂ) (ρ : ℝ) (hw : w ≠ 0) :
    {s : ℝ | ‖x + (s : ℂ) * w - c‖ = ρ}.Finite := by
  set A : ℝ := ‖w‖ ^ 2
  set B : ℝ := 2 * ((x - c) * (starRingEnd ℂ) w).re
  set C : ℝ := ‖x - c‖ ^ 2 - ρ ^ 2
  have hA : A ≠ 0 := by positivity
  let q : Polynomial ℝ := Polynomial.C A * Polynomial.X ^ 2 + Polynomial.C B * Polynomial.X + Polynomial.C C
  have hq : q ≠ 0 := by
    intro h
    have := congrArg (fun r => Polynomial.coeff r 2) h
    simp [q, Polynomial.coeff_X_pow] at this
    exact hA this
  refine (Polynomial.finite_setOf_isRoot hq).subset ?_
  intro t ht
  simp only [mem_setOf_eq] at ht
  have h3 : ‖x - c + (t : ℂ) * w‖ ^ 2 = A * t ^ 2 + B * t + (C + ρ ^ 2) := by
    rw [Complex.sq_norm, Complex.normSq_apply]
    simp only [A, B, C, Complex.sq_norm, Complex.normSq_apply, Complex.add_re, Complex.add_im,
      Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, Complex.sub_re,
      Complex.sub_im, Complex.conj_re, Complex.conj_im]
    ring
  have h4 : x - c + (t : ℂ) * w = x + (t : ℂ) * w - c := by ring
  rw [h4, ht] at h3
  simp only [q, Set.mem_setOf_eq, Polynomial.IsRoot, Polynomial.eval_add, Polynomial.eval_mul,
    Polynomial.eval_C, Polynomial.eval_pow, Polynomial.eval_X]
  linarith

/-- A ray `x + s w` with `w` not parallel to the segment `[u, v]` meets it in at most one point. -/
theorem subsingleton_ray_inter_segment (x u v w : ℂ) (hd : v - u ≠ 0)
    (hpar : (w * (starRingEnd ℂ) (v - u)).im ≠ 0) :
    {s : ℝ | x + (s : ℂ) * w ∈ segment ℝ u v}.Subsingleton := by
  intro s₁ h₁ s₂ h₂
  obtain ⟨a₁, b₁, -, hb₁, hab₁, e₁⟩ := h₁
  obtain ⟨a₂, b₂, -, hb₂, hab₂, e₂⟩ := h₂
  by_contra hne
  have key : ((s₁ - s₂ : ℝ) : ℂ) * w = ((b₁ - b₂ : ℝ) : ℂ) * (v - u) := by
    have ha₁ : a₁ = 1 - b₁ := by linarith
    have ha₂ : a₂ = 1 - b₂ := by linarith
    subst ha₁ ha₂
    simp only [Complex.real_smul] at e₁ e₂
    push_cast at e₁ e₂ ⊢
    linear_combination e₂ - e₁
  apply hpar
  have : w = (((b₁ - b₂) / (s₁ - s₂) : ℝ) : ℂ) * (v - u) := by
    have hs : ((s₁ - s₂ : ℝ) : ℂ) ≠ 0 := by
      exact_mod_cast sub_ne_zero.mpr hne
    apply mul_left_cancel₀ hs
    rw [key]
    push_cast
    have hs' : ((s₁ : ℂ) - s₂) ≠ 0 := by simpa using hs
    field_simp
  rw [this, mul_assoc, Complex.mul_conj, ← Complex.ofReal_mul]
  exact Complex.ofReal_im _

/-- **A ray from a point of the domain** (child of engine 2): there are a direction `w ≠ 0` and `ε > 0` with
`x + s w` an interior point for all `0 < s < ε`. -/
theorem exists_ray_in_interiorPts {x : ℂ} (hx : x ∈ F.dom) :
    ∃ w : ℂ, w ≠ 0 ∧ ∃ ε > 0, ∀ s ∈ Ioo (0 : ℝ) ε, x + (s : ℂ) * w ∈ F.interiorPts := by
  classical
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite x hx
  set 𝒜 := {a | a ∈ F.arcs ∧ (a.carrier ∩ t).Nonempty}
  obtain ⟨r, hr, hrsub⟩ := Metric.mem_nhds_iff.mp (inter_mem ht (F.isOpen_dom.mem_nhds hx))
  -- the bad slopes
  let slope : Arc → ℝ := fun a => match a with
    | .seg u v => (v - u).im / (v - u).re
    | .circ .. => 0
  have hbad : (slope '' 𝒜).Finite := hfin.image _
  obtain ⟨lam, hlam⟩ := hbad.infinite_compl.nonempty
  set w : ℂ := 1 + (lam : ℂ) * I with hw
  have hw0 : w ≠ 0 := by
    intro h; have := congrArg Complex.re h; simp [hw] at this
  have hfinS : {s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier}.Finite := by
    have : {s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier} ⊆ ⋃ a ∈ 𝒜, {s : ℝ | x + (s : ℂ) * w ∈ a.carrier} := by
      intro s hs
      obtain ⟨a, ha, hsa⟩ := mem_iUnion₂.mp hs
      exact mem_iUnion₂.mpr ⟨a, ha, hsa⟩
    refine (hfin.biUnion fun a ha => ?_).subset this
    have hnd := F.nondegenerate a ha.1
    cases a with
    | seg u v =>
      have hd : v - u ≠ 0 := sub_ne_zero.mpr (Ne.symm hnd)
      refine (subsingleton_ray_inter_segment x u v w hd ?_).finite
      intro him
      apply hlam
      refine ⟨Arc.seg u v, ha, ?_⟩
      show (v - u).im / (v - u).re = lam
      have hre : (v - u).re ≠ 0 := by
        intro h0
        have : (w * (starRingEnd ℂ) (v - u)).im = lam * (v - u).re - (v - u).im := by
          simp [hw, Complex.mul_im]; ring
        rw [this, h0] at him
        have him' : (v - u).im = 0 := by linarith
        exact hd (Complex.ext h0 him')
      have : (w * (starRingEnd ℂ) (v - u)).im = lam * (v - u).re - (v - u).im := by
        simp [hw, Complex.mul_im]; ring
      rw [this] at him
      field_simp
      linarith
    | circ c ρ θ₀ θ₁ =>
      refine (finite_ray_inter_sphere x c w |ρ| hw0).subset ?_
      rintro s ⟨θ, -, hθ⟩
      simp only [mem_setOf_eq]
      rw [← hθ]
      simp [norm_e]
  obtain ⟨ε₁, hε₁, hε₁S⟩ : ∃ ε > 0, ∀ s ∈ {s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier}, ε ≤ |s| ∨ s = 0 ∨ True := by
    exact ⟨1, one_pos, fun _ _ => Or.inr (Or.inr trivial)⟩
  -- a positive lower bound for the bad parameters
  have hclosed := hfinS.isClosed
  have hopen : IsOpen {s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier}ᶜ := hclosed.isOpen_compl
  -- remove s = 0, which may be bad: use the finite set restricted to positive parameters
  have hfinPos : ({s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier} ∩ Ioi 0).Finite := hfinS.subset inter_subset_left
  have hcl2 := hfinPos.isClosed
  have h0 : (0 : ℝ) ∈ ({s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier} ∩ Ioi 0)ᶜ := by
    intro h; exact (lt_irrefl (0 : ℝ)) h.2
  obtain ⟨ε₂, hε₂, hball⟩ := Metric.isOpen_iff.mp hcl2.isOpen_compl 0 h0
  refine ⟨w, hw0, min ε₂ (r / ‖w‖), lt_min hε₂ (div_pos hr (norm_pos_iff.mpr hw0)), ?_⟩
  intro s hs
  have hs0 : 0 < s := hs.1
  have hsε : s < ε₂ := lt_of_lt_of_le hs.2 (min_le_left _ _)
  have hsr : s * ‖w‖ < r := by
    have := lt_of_lt_of_le hs.2 (min_le_right _ _)
    rwa [lt_div_iff₀ (norm_pos_iff.mpr hw0)] at this
  have hmem : x + (s : ℂ) * w ∈ ball x r := by
    rw [mem_ball, dist_eq_norm]
    simpa [norm_mul, abs_of_pos hs0] using hsr
  have hnb : x + (s : ℂ) * w ∉ ⋃ a ∈ 𝒜, a.carrier := by
    intro h
    have : s ∈ ({s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier} ∩ Ioi 0) := ⟨h, hs0⟩
    have hsb : s ∈ ball (0 : ℝ) ε₂ := by
      rw [mem_ball, Real.dist_eq, sub_zero, abs_of_pos hs0]; exact hsε
    exact hball hsb this
  refine ⟨(hrsub hmem).2, fun hΓ => hnb ?_⟩
  obtain ⟨a, ha, hya⟩ := mem_iUnion₂.mp hΓ
  exact mem_iUnion₂.mpr ⟨a, ⟨ha, _, hya, (hrsub hmem).1⟩, hya⟩

/-- **Engine 2.** Every point of the domain lies in the closure of some tile: a ray from it into the interior points
is connected, so lies in one tile. -/
theorem mem_closure_tile {x : ℂ} (hx : x ∈ F.dom) : ∃ T, F.IsTile T ∧ x ∈ closure T := by
  obtain ⟨w, hw, ε, hε, hray⟩ := F.exists_ray_in_interiorPts hx
  set y := x + ((ε / 2 : ℝ) : ℂ) * w
  have hy : y ∈ F.interiorPts := hray _ ⟨by positivity, by linarith⟩
  refine ⟨connectedComponentIn F.interiorPts y, ⟨y, hy, rfl⟩, ?_⟩
  have hpre : IsPreconnected ((fun s : ℝ => x + (s : ℂ) * w) '' Ioo 0 ε) :=
    (isPreconnected_Ioo).image _ (by fun_prop)
  have hsub : (fun s : ℝ => x + (s : ℂ) * w) '' Ioo 0 ε ⊆ connectedComponentIn F.interiorPts y :=
    hpre.subset_connectedComponentIn ⟨ε / 2, ⟨by positivity, by linarith⟩, rfl⟩
      (by rintro _ ⟨s, hs, rfl⟩; exact hray s hs)
  refine closure_mono hsub ?_
  have hcont : Continuous fun s : ℝ => x + (s : ℂ) * w := by fun_prop
  have h0x := map_mem_closure hcont (by rw [closure_Ioo hε.ne]; exact ⟨le_rfl, hε.le⟩ : (0 : ℝ) ∈ closure (Ioo 0 ε))
    (mapsTo_image (fun s : ℝ => x + (s : ℂ) * w) (Ioo 0 ε))
  simpa using h0x

/-- Near a point of the domain, a ball in the domain meets only finitely many arcs. -/
theorem exists_ball_finite {y : ℂ} (hy : y ∈ F.dom) :
    ∃ ε > 0, ball y ε ⊆ F.dom ∧ {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty}.Finite := by
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite y hy
  obtain ⟨ε, hε, hsub⟩ := Metric.mem_nhds_iff.mp (inter_mem ht (F.isOpen_dom.mem_nhds hy))
  refine ⟨ε, hε, fun z hz => (hsub hz).2, hfin.subset ?_⟩
  rintro a ⟨ha, z, hza, hz⟩
  exact ⟨ha, z, hza, (hsub hz).1⟩

/-! ## Finitely many tiles near a point -/

section FiniteTiles


/-- `ρ₀` is a **good radius** about `x`: the ball lies in the domain, only finitely many arcs meet it, all pass through `x`,
every circle among them has diameter above `ρ₀`, and distinct full curves through `x` of two of them meet inside the ball
only at `x`. -/
structure GoodAt (x : ℂ) (ρ₀ : ℝ) : Prop where
  /-- The radius is positive. -/
  pos : 0 < ρ₀
  /-- The ball lies in the domain. -/
  subdom : ball x ρ₀ ⊆ F.dom
  /-- Finitely many arcs meet the ball. -/
  fin : {a | a ∈ F.arcs ∧ (a.carrier ∩ ball x ρ₀).Nonempty}.Finite
  /-- Every arc meeting the ball passes through `x`. -/
  through : ∀ a ∈ F.arcs, (a.carrier ∩ ball x ρ₀).Nonempty → x ∈ a.carrier
  /-- Every circle among them has diameter above `ρ₀`. -/
  big : ∀ a ∈ F.arcs, (a.carrier ∩ ball x ρ₀).Nonempty → (a.curveData x).1 = 1 → ρ₀ < 2 * ‖(a.curveData x).2‖
  /-- Two of them with different full curves meet in the ball only at `x`. -/
  uniq : ∀ a ∈ F.arcs, ∀ a' ∈ F.arcs, (a.carrier ∩ ball x ρ₀).Nonempty → (a'.carrier ∩ ball x ρ₀).Nonempty →
    ∀ z ∈ ball x ρ₀, z ≠ x → z ∈ a.curve x → z ∈ a'.curve x → a.curve x = a'.curve x

/-- Every point of the domain has a good radius. -/
theorem exists_goodAt {x : ℂ} (hx : x ∈ F.dom) : ∃ ρ₀, F.GoodAt x ρ₀ := by
  obtain ⟨ε₁, hε₁, hdom, hfin⟩ := F.exists_ball_finite hx
  set 𝒜 := {a | a ∈ F.arcs ∧ (a.carrier ∩ ball x ε₁).Nonempty} with h𝒜
  have ev0 : ∀ᶠ ρ in 𝓝[>] (0 : ℝ), 0 < ρ := self_mem_nhdsWithin
  have ev1 : ∀ᶠ ρ in 𝓝[>] (0 : ℝ), ρ ≤ ε₁ := by
    filter_upwards [Ioo_mem_nhdsGT hε₁] with ρ hρ; exact hρ.2.le
  have ev2 : ∀ᶠ ρ in 𝓝[>] (0 : ℝ), ∀ a ∈ 𝒜, x ∈ a.carrier ∨ a.carrier ∩ ball x ρ = ∅ :=
    (eventually_all_finite hfin).mpr fun a ha => by
      by_cases hxa : x ∈ a.carrier
      · exact Filter.Eventually.of_forall fun _ => Or.inl hxa
      · obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp a.isClosed_carrier.isOpen_compl x hxa
        filter_upwards [Ioo_mem_nhdsGT hr] with ρ hρ
        right
        exact eq_empty_of_forall_notMem fun z ⟨hza, hz⟩ => hball (ball_subset_ball hρ.2.le hz) hza
  have ev3 : ∀ᶠ ρ in 𝓝[>] (0 : ℝ), ∀ a ∈ 𝒜, x ∈ a.carrier → (a.curveData x).1 = 1 →
      ρ < 2 * ‖(a.curveData x).2‖ :=
    (eventually_all_finite hfin).mpr fun a ha => by
      by_cases hxa : x ∈ a.carrier
      · by_cases h1 : (a.curveData x).1 = 1
        · have hb := Arc.curveData_ne (F.nondegenerate a ha.1) hxa
          have hpos : 0 < 2 * ‖(a.curveData x).2‖ := by positivity
          filter_upwards [Ioo_mem_nhdsGT hpos] with ρ hρ _ _
          exact hρ.2
        · exact Filter.Eventually.of_forall fun _ _ h1' => absurd h1' h1
      · exact Filter.Eventually.of_forall fun _ h => absurd h hxa
  have ev4 : ∀ᶠ ρ in 𝓝[>] (0 : ℝ), ∀ a ∈ 𝒜, ∀ a' ∈ 𝒜, x ∈ a.carrier → x ∈ a'.carrier →
      ∀ z ∈ ball x ρ, z ≠ x → z ∈ a.curve x → z ∈ a'.curve x → a.curve x = a'.curve x := by
    refine (eventually_all_finite hfin).mpr fun a ha => (eventually_all_finite hfin).mpr fun a' ha' => ?_
    by_cases hxa : x ∈ a.carrier
    · by_cases hxa' : x ∈ a'.carrier
      · have hb := Arc.curveData_ne (F.nondegenerate a ha.1) hxa
        have hb' := Arc.curveData_ne (F.nondegenerate a' ha'.1) hxa'
        by_cases hsame : ((a.curveData x).1 = (a'.curveData x).1 ∧
            ((a.curveData x).1 = 1 → (a.curveData x).2 = (a'.curveData x).2) ∧
            ((a.curveData x).1 = 0 → ((a.curveData x).2 * (starRingEnd ℂ) (a'.curveData x).2).im = 0))
        · exact Filter.Eventually.of_forall fun _ _ _ _ _ _ _ _ =>
            curveAt_eq_of_same (Arc.curveData_kappa x a) hb hb' hsame
        · obtain ⟨ε, hε, hk⟩ := curve_inter (x := x) (Arc.curveData_kappa x a) (Arc.curveData_kappa x a') hb hb' hsame
          filter_upwards [Ioo_mem_nhdsGT hε] with ρ hρ _ _ z hz hzx hz1 hz2
          exact absurd (hk z (by rw [← dist_eq_norm]; exact lt_trans hz hρ.2) hz1 hz2) hzx
      · exact Filter.Eventually.of_forall fun _ _ h => absurd h hxa'
    · exact Filter.Eventually.of_forall fun _ h => absurd h hxa
  obtain ⟨ρ, hρ0, hρ1, hρ2, hρ3, hρ4⟩ := (ev0.and (ev1.and (ev2.and (ev3.and ev4)))).exists
  have hsub : ∀ a ∈ F.arcs, (a.carrier ∩ ball x ρ).Nonempty → a ∈ 𝒜 := fun a ha ⟨z, hza, hz⟩ =>
    ⟨ha, z, hza, ball_subset_ball hρ1 hz⟩
  have hthrough : ∀ a ∈ F.arcs, (a.carrier ∩ ball x ρ).Nonempty → x ∈ a.carrier := by
    intro a ha hne
    rcases hρ2 a (hsub a ha hne) with h | h
    · exact h
    · exact absurd h (Set.nonempty_iff_ne_empty.mp hne)
  refine ⟨ρ, ⟨hρ0, (ball_subset_ball hρ1).trans hdom, hfin.subset fun a ⟨ha, hne⟩ => hsub a ha hne, hthrough, ?_, ?_⟩⟩
  · intro a ha hne h1
    exact hρ3 a (hsub a ha hne) (hthrough a ha hne) h1
  · intro a ha a' ha' hne hne' z hz hzx hz1 hz2
    exact hρ4 a (hsub a ha hne) a' (hsub a' ha' hne') (hthrough a ha hne) (hthrough a' ha' hne') z hz hzx hz1 hz2


variable {F}

/-- A preconnected set of interior points meeting a tile lies in it. -/
theorem IsTile.subset_of_preconnected {T : Set ℂ} (hT : F.IsTile T) {s : Set ℂ} (hs : IsPreconnected s)
    (hsI : s ⊆ F.interiorPts) {t : ℂ} (ht : t ∈ s) (htT : t ∈ T) : s ⊆ T := by
  obtain ⟨y, hy, rfl⟩ := hT
  rw [connectedComponentIn_eq htT]
  exact hs.subset_connectedComponentIn ht hsI

/-- Near a point `z ≠ x` of an arc, inside a good ball, every arc point lies on the full curve of that arc. -/
theorem GoodAt.exists_local_curve {x : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt x ρ₀) {z : ℂ} (hz : z ∈ ball x ρ₀) (hzx : z ≠ x)
    {a : Arc} (ha : a ∈ F.arcs) (hza : z ∈ a.carrier) :
    ∃ δ > 0, ball z δ ⊆ ball x ρ₀ ∧ ∀ y ∈ ball z δ, ∀ a' ∈ F.arcs, y ∈ a'.carrier → y ∈ a.curve x := by
  have hxa : x ∈ a.carrier := hG.through a ha ⟨z, hza, hz⟩
  set 𝒜 := {a | a ∈ F.arcs ∧ (a.carrier ∩ ball x ρ₀).Nonempty} with h𝒜
  have ev1 : ∀ᶠ δ in 𝓝[>] (0 : ℝ), ∀ a' ∈ 𝒜, z ∈ a'.carrier ∨ a'.carrier ∩ ball z δ = ∅ :=
    (eventually_all_finite hG.fin).mpr fun a' _ => by
      by_cases hza' : z ∈ a'.carrier
      · exact Filter.Eventually.of_forall fun _ => Or.inl hza'
      · obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp a'.isClosed_carrier.isOpen_compl z hza'
        filter_upwards [Ioo_mem_nhdsGT hr] with δ hδ
        right
        exact eq_empty_of_forall_notMem fun y ⟨hya, hy⟩ => hball (ball_subset_ball hδ.2.le hy) hya
  obtain ⟨r0, hr0, hr0sub⟩ := Metric.isOpen_iff.mp isOpen_ball z hz
  have ev2 : ∀ᶠ δ in 𝓝[>] (0 : ℝ), δ ≤ r0 := by
    filter_upwards [Ioo_mem_nhdsGT hr0] with δ hδ; exact hδ.2.le
  have ev0 : ∀ᶠ δ in 𝓝[>] (0 : ℝ), 0 < δ := self_mem_nhdsWithin
  obtain ⟨δ, hδ0, hδ1, hδ2⟩ := (ev0.and (ev2.and ev1)).exists
  have hbs : ball z δ ⊆ ball x ρ₀ := (ball_subset_ball hδ1).trans hr0sub
  refine ⟨δ, hδ0, hbs, fun y hy a' ha' hya' => ?_⟩
  have ha'𝒜 : a' ∈ 𝒜 := ⟨ha', y, hya', hbs hy⟩
  have hza' : z ∈ a'.carrier := by
    rcases hδ2 a' ha'𝒜 with h | h
    · exact h
    · exact absurd h (Set.nonempty_iff_ne_empty.mp ⟨y, hya', hy⟩)
  have heq : a.curve x = a'.curve x :=
    hG.uniq a ha a' ha' ⟨z, hza, hz⟩ ⟨z, hza', hz⟩ z hz hzx (Arc.carrier_subset_curve hxa hza)
      (Arc.carrier_subset_curve (hG.through a' ha' ⟨y, hya', hbs hy⟩) hza')
  rw [heq]
  exact Arc.carrier_subset_curve (hG.through a' ha' ⟨y, hya', hbs hy⟩) hya'

/-- **No tile lies inside a good ball**: a tile inside `B(x, ρ)`, `ρ < ρ₀`, would have a farthest point `z` of its closure
from `x`; off `Γ` the tile continues beyond `z`, and on `Γ` it lies beside the one curve through `z`, which it cannot
cross, yet which leads outward. -/
theorem GoodAt.not_tile_subset_ball {x : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt x ρ₀) {T : Set ℂ} (hT : F.IsTile T) {ρ : ℝ}
    (hρ : ρ < ρ₀) (hsub : T ⊆ ball x ρ) : False := by
  obtain ⟨y0, hy0⟩ := hT.nonempty
  have hcl : closure T ⊆ closedBall x ρ := closure_minimal (hsub.trans ball_subset_closedBall) isClosed_closedBall
  have hK : IsCompact (closure T) := (isCompact_closedBall x ρ).of_isClosed_subset isClosed_closure hcl
  obtain ⟨z, hzK, hzmax⟩ := hK.exists_isMaxOn ⟨y0, subset_closure hy0⟩
    (continuous_norm.comp (continuous_id.sub continuous_const) : Continuous fun y : ℂ => ‖y - x‖).continuousOn
  have hmax : ∀ y ∈ closure T, ‖y - x‖ ≤ ‖z - x‖ := fun y hy => isMaxOn_iff.mp hzmax y hy
  have hzρ : ‖z - x‖ ≤ ρ := by
    have := hcl hzK; rwa [mem_closedBall, dist_eq_norm] at this
  set d := ‖z - x‖ with hd
  have hd0 : 0 < d := by
    by_contra hneg
    have hd' : d = 0 := le_antisymm (not_lt.mp hneg) (norm_nonneg _)
    have hyx : y0 = x := by
      have := hmax y0 (subset_closure hy0)
      rw [hd'] at this
      exact sub_eq_zero.mp (norm_le_zero_iff.mp this)
    obtain ⟨ε, hε, hballT⟩ := Metric.isOpen_iff.mp hT.isOpen y0 hy0
    have hmem : y0 + ((ε / 2 : ℝ) : ℂ) ∈ ball y0 ε := by
      rw [mem_ball, dist_eq_norm, add_sub_cancel_left, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by positivity)]
      linarith
    have := hmax _ (subset_closure (hballT hmem))
    rw [hd', hyx, add_sub_cancel_left, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by positivity)] at this
    have : (0 : ℝ) < ε / 2 := by positivity
    linarith
  have hzball : z ∈ ball x ρ₀ := by
    rw [mem_ball, dist_eq_norm]; linarith
  have hzx : z ≠ x := fun h => by rw [h, sub_self, norm_zero] at hd; exact hd0.ne' hd
  by_cases hzI : z ∈ F.interiorPts
  · obtain ⟨ε, hε, hballI⟩ := Metric.isOpen_iff.mp F.isOpen_interiorPts z hzI
    obtain ⟨t, htT, hzt⟩ := Metric.mem_closure_iff.mp hzK ε hε
    have hballT : ball z ε ⊆ T :=
      hT.subset_of_preconnected (convex_ball z ε).isPreconnected hballI (by rwa [mem_ball, dist_comm]) htT
    have hτ0 : 0 ≤ ε / (2 * d) := by positivity
    set τ : ℝ := 1 + ε / (2 * d) with hτ
    have hτ1 : 0 ≤ τ := by rw [hτ]; linarith
    have hτ2 : 0 ≤ τ - 1 := by rw [hτ]; linarith
    have hτd : (τ - 1) * d = ε / 2 := by rw [hτ]; field_simp; ring
    have hmem : x + (τ : ℂ) * (z - x) ∈ ball z ε := by
      have : x + (τ : ℂ) * (z - x) - z = ((τ - 1 : ℝ) : ℂ) * (z - x) := by push_cast; ring
      rw [mem_ball, dist_eq_norm, this, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg hτ2, ← hd, hτd]
      linarith
    have h1 := hmax _ (subset_closure (hballT hmem))
    rw [add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg hτ1, ← hd] at h1
    have h2 : τ * d = d + ε / 2 := by nlinarith
    linarith
  · have hzdom : z ∈ F.dom := hG.subdom hzball
    have hzΓ : z ∈ ⋃ a ∈ F.arcs, a.carrier := by
      by_contra hn; exact hzI ⟨hzdom, hn⟩
    obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp hzΓ
    have hxa : x ∈ a.carrier := hG.through a ha ⟨z, hza, hzball⟩
    obtain ⟨δ₁, hδ₁, hδ₁ball, hδ₁curve⟩ := hG.exists_local_curve hzball hzx ha hza
    set δ := min δ₁ d with hδ
    have hδ0 : 0 < δ := lt_min hδ₁ hd0
    have hδd : δ ≤ d := min_le_right _ _
    have hδδ₁ : δ ≤ δ₁ := min_le_left _ _
    have hb := Arc.curveData_ne (F.nondegenerate a ha) hxa
    have hzc : z ∈ a.curve x := Arc.carrier_subset_curve hxa hza
    obtain ⟨t, htT, hzt⟩ := Metric.mem_closure_iff.mp hzK (δ / 3) (by positivity)
    have hOo : IsOpen (T ∩ ball z (δ / 3)) := hT.isOpen.inter isOpen_ball
    obtain ⟨w, ⟨hwT, hwz⟩, hwc⟩ := exists_notMem_curveAt (Arc.curveData_kappa x a) hb hOo ⟨t, htT, by rwa [mem_ball, dist_comm]⟩
    obtain ⟨w', hw'far, hseg, hdisj⟩ := exists_farther (Arc.curveData_kappa x a) hb hzc hd0
      (fun h1 => lt_of_le_of_lt hzρ (hρ.trans_le (hG.big a ha ⟨z, hza, hzball⟩ h1).le))
      hδ0 hδd (by rwa [mem_ball] at hwz) hwc
    have hsegI : segment ℝ w w' ⊆ F.interiorPts := by
      intro y hy
      have hyb := hseg hy
      refine ⟨hG.subdom (hδ₁ball (ball_subset_ball hδδ₁ hyb)), fun hyΓ => ?_⟩
      obtain ⟨a', ha', hya'⟩ := mem_iUnion₂.mp hyΓ
      exact Set.disjoint_left.mp hdisj hy (hδ₁curve y (ball_subset_ball hδδ₁ hyb) a' ha' hya')
    have hsegT : segment ℝ w w' ⊆ T :=
      hT.subset_of_preconnected (convex_segment w w').isPreconnected hsegI (left_mem_segment ℝ w w') hwT
    have := hmax _ (subset_closure (hsegT (right_mem_segment ℝ w w')))
    linarith


/-- The point of the circle `S(x, ρ)` at angle `θ`. -/
noncomputable def spherePt (x : ℂ) (ρ θ : ℝ) : ℂ := x + (ρ : ℂ) * e θ

/-- `θ ↦ spherePt x ρ θ` is continuous. -/
theorem continuous_spherePt (x : ℂ) (ρ : ℝ) : Continuous (spherePt x ρ) := by
  unfold spherePt e; fun_prop

/-- `spherePt x ρ θ` is at distance `ρ` from `x`. -/
theorem norm_spherePt_sub (x : ℂ) {ρ : ℝ} (hρ : 0 ≤ ρ) (θ : ℝ) : ‖spherePt x ρ θ - x‖ = ρ := by
  simp [spherePt, norm_e, abs_of_nonneg hρ]

/-- `spherePt x ρ θ` lies on `S(x, ρ)`. -/
theorem spherePt_mem_sphere (x : ℂ) {ρ : ℝ} (hρ : 0 ≤ ρ) (θ : ℝ) : spherePt x ρ θ ∈ sphere x ρ := by
  rw [mem_sphere_iff_norm]; exact norm_spherePt_sub x hρ θ

/-- `spherePt x ρ` is injective on an interval of length `2π`. -/
theorem injOn_spherePt (x : ℂ) {ρ : ℝ} (hρ : 0 < ρ) (a : ℝ) : InjOn (spherePt x ρ) (Ioo a (a + 2 * π)) := by
  intro θ hθ θ' hθ' h
  have h1 : (ρ : ℂ) * e θ = (ρ : ℂ) * e θ' := by simpa [spherePt] using h
  have h2 : e θ = e θ' := mul_left_cancel₀ (by exact_mod_cast hρ.ne') h1
  obtain ⟨n, hn⟩ := e_eq_e_iff.mp h2
  have hπ := Real.pi_pos
  have h3 : (n : ℝ) < 1 := by
    by_contra hc; push Not at hc
    nlinarith [hθ.1, hθ.2, hθ'.1, hθ'.2]
  have h4 : (-1 : ℝ) < n := by
    by_contra hc; push Not at hc
    nlinarith [hθ.1, hθ.2, hθ'.1, hθ'.2]
  have : n = 0 := by
    have h5 : n < 1 := by exact_mod_cast h3
    have h6 : -1 < n := by exact_mod_cast h4
    omega
  rw [this] at hn; simpa using hn

/-- **Finitely many tiles meet a small circle**: off the finitely many points of `Γ` on it, the circle's points fall into
finitely many arcs, each inside one tile. -/
theorem GoodAt.finite_tiles_sphere {x : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt x ρ₀) {ρ : ℝ} (hρ0 : 0 < ρ) (hρ : ρ < ρ₀) :
    {T | F.IsTile T ∧ (T ∩ sphere x ρ).Nonempty}.Finite := by
  have hπ := Real.pi_pos
  set 𝒜 := {a | a ∈ F.arcs ∧ (a.carrier ∩ ball x ρ₀).Nonempty} with h𝒜
  set S : Set ℂ := ⋃ a ∈ 𝒜, (a.curve x ∩ sphere x ρ) with hS
  have hSfin : S.Finite := hG.fin.biUnion fun a ha =>
    finite_curve_inter_sphere (Arc.curveData_ne (F.nondegenerate a ha.1) (hG.through a ha.1 ha.2)) ρ
  have hsph : ∀ θ, spherePt x ρ θ ∈ ball x ρ₀ := fun θ => by
    rw [mem_ball, dist_eq_norm, norm_spherePt_sub x hρ0.le]; exact hρ
  have hbad : ∀ θ, spherePt x ρ θ ∉ F.interiorPts → spherePt x ρ θ ∈ S := by
    intro θ hθ
    have hd : spherePt x ρ θ ∈ F.dom := hG.subdom (hsph θ)
    have hΓ : spherePt x ρ θ ∈ ⋃ a ∈ F.arcs, a.carrier := by
      by_contra hn; exact hθ ⟨hd, hn⟩
    obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp hΓ
    have hne : (a.carrier ∩ ball x ρ₀).Nonempty := ⟨_, hza, hsph θ⟩
    exact mem_iUnion₂.mpr ⟨a, ⟨ha, hne⟩, Arc.carrier_subset_curve (hG.through a ha hne) hza,
      spherePt_mem_sphere x hρ0.le θ⟩
  set g : ℝ → Set ℂ := fun θ => connectedComponentIn F.interiorPts (spherePt x ρ θ) with hg
  have hΘ : ∀ a : ℝ, {θ ∈ Ioo a (a + 2 * π) | spherePt x ρ θ ∈ S}.Finite := fun a =>
    Set.Finite.of_injOn (f := spherePt x ρ) (t := S) (fun θ hθ => hθ.2) ((injOn_spherePt x hρ0 a).mono fun θ hθ => hθ.1) hSfin
  have hmain : ∀ a : ℝ, (g '' (Ioo a (a + 2 * π) \ {θ ∈ Ioo a (a + 2 * π) | spherePt x ρ θ ∈ S})).Finite := by
    intro a
    refine finite_image_of_locConst g (hΘ a) fun t ht htn => ?_
    have hI : spherePt x ρ t ∈ F.interiorPts := by
      by_contra h; exact htn ⟨ht, hbad t h⟩
    obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp F.isOpen_interiorPts _ hI
    have hcont := (continuous_spherePt x ρ).continuousAt (x := t)
    filter_upwards [hcont.eventually (Metric.ball_mem_nhds _ hε)] with s hs
    simp only [hg]
    have hsub : ball (spherePt x ρ t) ε ⊆ connectedComponentIn F.interiorPts (spherePt x ρ t) :=
      (convex_ball _ _).isPreconnected.subset_connectedComponentIn (mem_ball_self hε) hball
    exact (connectedComponentIn_eq (hsub hs)).symm
  refine ((hmain (-π)).union (hmain 0)).subset ?_
  rintro T ⟨hT, p, hpT, hps⟩
  -- the angle of `p`
  have hp1 : ‖p - x‖ = ρ := by rwa [mem_sphere_iff_norm] at hps
  set u : ℂ := (p - x) / (ρ : ℂ) with hu
  have hun : ‖u‖ = 1 := by
    rw [hu, norm_div, hp1, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hρ0, div_self hρ0.ne']
  set θ₀ := Complex.arg u with hθ₀
  have hpe : p = spherePt x ρ θ₀ := by
    have h1 : e θ₀ = u := by
      have := Complex.norm_mul_exp_arg_mul_I u
      rw [hun, Complex.ofReal_one, one_mul] at this
      exact this
    have hne : (ρ : ℂ) ≠ 0 := by exact_mod_cast hρ0.ne'
    have h2 : (ρ : ℂ) * ((p - x) / (ρ : ℂ)) = p - x := by field_simp
    rw [spherePt, h1, hu, h2]; ring
  have hint : ∃ a ∈ ({-π, 0} : Set ℝ), θ₀ ∈ Ioo a (a + 2 * π) := by
    rcases lt_or_eq_of_le (Complex.arg_le_pi u) with h | h
    · exact ⟨-π, by simp, by constructor <;> linarith [Complex.neg_pi_lt_arg u]⟩
    · exact ⟨0, by simp, by constructor <;> linarith⟩
  obtain ⟨a, haS, ha⟩ := hint
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp hT.isOpen p hpT
  have hcont : Tendsto (spherePt x ρ) (𝓝 θ₀) (𝓝 p) := by
    rw [hpe]; exact (continuous_spherePt x ρ).continuousAt
  obtain ⟨η, hη, hηball⟩ := Metric.mem_nhds_iff.mp (hcont.eventually (Metric.ball_mem_nhds p hε))
  have hlt : max a (θ₀ - η) < min (a + 2 * π) (θ₀ + η) := by
    refine max_lt (lt_min (by linarith) (by linarith [ha.1])) (lt_min (by linarith [ha.2]) (by linarith))
  obtain ⟨θ, hθU, hθΘ⟩ := ((Set.Ioo_infinite hlt).sdiff (hΘ a)).nonempty
  have hθI : θ ∈ Ioo a (a + 2 * π) := ⟨(le_max_left _ _).trans_lt hθU.1, hθU.2.trans_le (min_le_left _ _)⟩
  have hθη : θ ∈ ball θ₀ η := by
    rw [mem_ball, Real.dist_eq, abs_lt]
    constructor
    · linarith [(le_max_right _ _).trans_lt hθU.1]
    · linarith [hθU.2.trans_le (min_le_right _ _)]
  have hqT : spherePt x ρ θ ∈ T := hball (hηball hθη)
  have hTg : T = g θ := by
    obtain ⟨y, hy, rfl⟩ := hT
    exact connectedComponentIn_eq hqT
  have hΘ' : θ ∉ {θ ∈ Ioo a (a + 2 * π) | spherePt x ρ θ ∈ S} := hθΘ
  have hmem : T ∈ g '' (Ioo a (a + 2 * π) \ {θ ∈ Ioo a (a + 2 * π) | spherePt x ρ θ ∈ S}) :=
    ⟨θ, ⟨hθI, hΘ'⟩, hTg.symm⟩
  simp only [mem_insert_iff, mem_singleton_iff] at haS
  rcases haS with rfl | rfl
  · exact Or.inl hmem
  · exact Or.inr hmem


/-- The tiles of colour `c` meeting a small ball cover the colour class inside it. -/
theorem region_inter_ball_subset {x : ℂ} {r : ℝ} (c : Fin k) :
    F.region c ∩ ball x r ⊆ ⋃ T ∈ {T | F.TileOf c T ∧ (T ∩ ball x r).Nonempty}, T := by
  rintro y ⟨hy, hyb⟩
  have hyI : y ∈ F.interiorPts := hy.1
  have hT : F.IsTile (connectedComponentIn F.interiorPts y) := ⟨y, hyI, rfl⟩
  have hmem : y ∈ connectedComponentIn F.interiorPts y := mem_connectedComponentIn hyI
  have hcol : F.col y = c := hy.2
  refine mem_iUnion₂.mpr ⟨_, ⟨?_, y, hmem, hyb⟩, hmem⟩
  have := hT.tileOf hmem
  rwa [hcol] at this


end FiniteTiles

/-- **Finitely many tiles meet a small disc about any point of the domain**: near `x` only the arcs through `x` remain,
every pair of their full curves meets only at `x`, and every tile meeting `B(x, r)` meets a fixed small circle about `x`
(a tile inside the ball would have a farthest point, `GoodAt.not_tile_subset_ball`); only finitely many tiles meet that
circle (`GoodAt.finite_tiles_sphere`). -/
theorem finite_tiles_near {x : ℂ} (hx : x ∈ F.dom) :
    ∃ r > 0, {T | F.IsTile T ∧ (T ∩ ball x r).Nonempty}.Finite := by
  obtain ⟨ρ₀, hG⟩ := F.exists_goodAt hx
  have hρ0 := hG.pos
  refine ⟨ρ₀ / 2, by positivity, (hG.finite_tiles_sphere (ρ := 3 * ρ₀ / 4) (by positivity) (by linarith)).subset ?_⟩
  rintro T ⟨hT, p, hpT, hp⟩
  refine ⟨hT, ?_⟩
  have hpρ : p ∈ ball x (3 * ρ₀ / 4) := ball_subset_ball (by linarith) hp
  have hnot : ¬ T ⊆ ball x (3 * ρ₀ / 4) := fun h => hG.not_tile_subset_ball hT (by linarith) h
  obtain ⟨q, hqT, hq⟩ := Set.not_subset.mp hnot
  by_contra hne
  have hno : ∀ y ∈ T, y ∉ sphere x (3 * ρ₀ / 4) := fun y hy hys => hne ⟨y, hy, hys⟩
  obtain ⟨y, hy, hy1, hy2⟩ := hT.isPreconnected (ball x (3 * ρ₀ / 4)) (closedBall x (3 * ρ₀ / 4))ᶜ isOpen_ball
    isClosed_closedBall.isOpen_compl (fun y hy => by
      by_cases h1 : y ∈ ball x (3 * ρ₀ / 4)
      · exact Or.inl h1
      · right
        intro h2
        exact hno y hy (le_antisymm (mem_closedBall.mp h2) (not_lt.mp h1)))
    ⟨p, hpT, hpρ⟩ ⟨q, hqT, fun h2 => hno q hqT (le_antisymm (mem_closedBall.mp h2) (not_lt.mp hq))⟩
  exact hy2 (ball_subset_closedBall hy1)

/-- The colours at a point of the domain are the colours of the tiles whose closure holds it (the rows' `P_cl`, read
tile by tile). -/
theorem mem_coloursAt_iff_exists_tileOf {x : ℂ} (hx : x ∈ F.dom) {c : Fin k} :
    c ∈ F.coloursAt x ↔ ∃ T, F.TileOf c T ∧ x ∈ closure T := by
  constructor
  · intro hc
    obtain ⟨r, hr, hfin⟩ := F.finite_tiles_near hx
    have hfin' : {T | F.TileOf c T ∧ (T ∩ ball x r).Nonempty}.Finite :=
      hfin.subset fun T ⟨hT, hne⟩ => ⟨hT.1, hne⟩
    have hx1 : x ∈ closure (F.region c ∩ ball x r) := by
      rw [mem_closure_iff_nhds]
      intro t ht
      obtain ⟨y, hy1, hy2⟩ := mem_closure_iff_nhds.mp hc (t ∩ ball x r) (inter_mem ht (ball_mem_nhds x hr))
      exact ⟨y, hy1.1, hy2, hy1.2⟩
    have hx2 := closure_mono (F.region_inter_ball_subset (x := x) (r := r) c) hx1
    rw [hfin'.closure_biUnion] at hx2
    obtain ⟨T, hT, hxT⟩ := mem_iUnion₂.mp hx2
    exact ⟨T, hT.1, hxT⟩
  · rintro ⟨T, hT, hxT⟩
    exact mem_coloursAt_of_tileOf hT hxT

/-- At a point of the domain, the cone of a colour class is the union of the cones of its tiles whose closure holds the
point: "the cone of a tile of colour `c`" and "the cone of the class of `c`" agree. -/
theorem coneAt_region_eq_biUnion {x : ℂ} (hx : x ∈ F.dom) (c : Fin k) :
    coneAt (F.region c) x = ⋃ T ∈ {T | F.TileOf c T ∧ x ∈ closure T}, coneAt T x := by
  apply Set.Subset.antisymm
  · intro β hβ
    obtain ⟨r, hr, hfin⟩ := F.finite_tiles_near hx
    have hfin' : {T | F.TileOf c T ∧ (T ∩ ball x r).Nonempty}.Finite :=
      hfin.subset fun T ⟨hT, hne⟩ => ⟨hT.1, hne⟩
    have h1 := coneAt_inter_ball hr hβ
    have h2 := coneAt_mono (F.region_inter_ball_subset (x := x) (r := r) c) x h1
    obtain ⟨T, hT, hβT⟩ := coneAt_biUnion_finite hfin' (fun T => T) h2
    exact mem_iUnion₂.mpr ⟨T, ⟨hT.1, mem_closure_of_mem_coneAt hβT⟩, hβT⟩
  · intro β hβ
    obtain ⟨T, hT, hβT⟩ := mem_iUnion₂.mp hβ
    exact coneAt_mono hT.1.subset_region x hβT

/-- At a point of the domain every direction lies in the cone of some colour (pigeonhole over the finitely many colours,
on interior points near the ray). -/
theorem exists_mem_coneAt_region {x : ℂ} (hx : x ∈ F.dom) (β : ℝ) : ∃ c, β ∈ coneAt (F.region c) x := by
  classical
  obtain ⟨r, hr, hrsub⟩ := Metric.isOpen_iff.mp F.isOpen_dom x hx
  obtain ⟨N₀, hN₀⟩ := exists_nat_gt (2 / r)
  set N : ℕ := N₀ + 2 with hNdef
  have hN : 2 / r < N := lt_of_lt_of_le hN₀ (by rw [hNdef]; push_cast; linarith)
  have hN2 : (2 : ℝ) ≤ N := by rw [hNdef]; push_cast; linarith [(Nat.cast_nonneg N₀ : (0 : ℝ) ≤ N₀)]
  have hmge : ∀ n : ℕ, (N : ℝ) ≤ ((n + N : ℕ) : ℝ) := fun n => by
    push_cast; linarith [(Nat.cast_nonneg n : (0 : ℝ) ≤ n)]
  have hex : ∀ n : ℕ, ∃ z : ℂ, z ∈ F.interiorPts ∧
      dist z (x + e β / ((n + N : ℕ) : ℂ)) < 1 / ((n + N : ℕ) : ℝ) ^ 2 := by
    intro n
    have hm0 : (0 : ℝ) < ((n + N : ℕ) : ℝ) := lt_of_lt_of_le (by linarith) (hmge n)
    have hmem : x + e β / ((n + N : ℕ) : ℂ) ∈ ball x r := by
      rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_div, norm_e, Complex.norm_natCast]
      rw [div_lt_iff₀ hm0]
      have h2 : 2 / r < N := hN
      rw [div_lt_iff₀ hr] at h2
      nlinarith [hmge n]
    have hd := F.dense_interiorPts (hrsub hmem)
    obtain ⟨z, hz, hzd⟩ := Metric.mem_closure_iff.mp hd (1 / ((n + N : ℕ) : ℝ) ^ 2) (by positivity)
    exact ⟨z, hz, by rw [dist_comm]; exact hzd⟩
  choose z hzI hzd using hex
  obtain ⟨c, hc⟩ : ∃ c : Fin k, {n : ℕ | F.col (z n) = c}.Infinite := by
    by_contra hcon
    push Not at hcon
    have hfin : (Set.univ : Set ℕ).Finite := by
      have : (Set.univ : Set ℕ) = ⋃ c : Fin k, {n : ℕ | F.col (z n) = c} := by
        ext n; simp
      rw [this]
      exact Set.finite_iUnion fun c => hcon c
    exact Set.infinite_univ hfin
  refine ⟨c, fun ε hε => ?_⟩
  obtain ⟨M, hM⟩ : ∃ M : ℕ, 8 / ε < M := exists_nat_gt _
  obtain ⟨n, hn, hnM⟩ := hc.exists_gt M
  have hmM : (M : ℝ) < ((n + N : ℕ) : ℝ) := by
    have : M < n + N := by omega
    exact_mod_cast this
  set m : ℕ := n + N with hm
  have hm0 : (2 : ℝ) ≤ m := (hN2.trans (hmge n))
  have hmpos : (0 : ℝ) < m := by linarith
  have hmε : 8 < ε * m := by
    have : 8 / ε < m := hM.trans hmM
    rwa [div_lt_iff₀ hε, mul_comm] at this
  set u : ℂ := e β / (m : ℂ) with hu
  have hun : ‖u‖ = 1 / m := by rw [hu, norm_div, norm_e, Complex.norm_natCast]
  have hu0 : u ≠ 0 := by
    intro h; rw [h, norm_zero] at hun; have : (0:ℝ) < 1 / m := by positivity
    linarith
  have hwu : ‖z n - x - u‖ < 1 / (m : ℝ) ^ 2 := by
    have := hzd n
    rw [dist_eq_norm, show z n - (x + u) = z n - x - u by ring] at this
    exact this
  have hwu' : 1 / (m : ℝ) ^ 2 ≤ 1 / (2 * m) := by
    rw [div_le_div_iff₀ (by positivity) (by positivity)]; nlinarith
  have hwn : 1 / (2 * (m : ℝ)) ≤ ‖z n - x‖ := by
    have h2 := norm_sub_norm_le u (z n - x)
    rw [norm_sub_rev u (z n - x), hun] at h2
    have : 1 / (m : ℝ) = 2 * (1 / (2 * m)) := by field_simp
    linarith
  have hw0 : z n - x ≠ 0 := by
    intro h; rw [h, norm_zero] at hwn
    have : (0 : ℝ) < 1 / (2 * (m : ℝ)) := by positivity
    linarith
  refine ⟨z n, ⟨hzI n, hn⟩, sub_ne_zero.mp hw0 |> fun h => h, ?_, ?_⟩
  · rw [dist_eq_norm]
    have h1 : ‖z n - x‖ ≤ ‖u‖ + ‖z n - x - u‖ := by
      have := norm_add_le u (z n - x - u)
      rw [show u + (z n - x - u) = z n - x by ring] at this; exact this
    rw [hun] at h1
    have : 1 / (m : ℝ) + 1 / (m : ℝ) ^ 2 ≤ 2 / m := by
      rw [show 2 / (m : ℝ) = 1 / m + 1 / m by ring]
      have : 1 / (m : ℝ) ^ 2 ≤ 1 / m := by
        rw [div_le_div_iff₀ (by positivity) (by positivity)]; nlinarith
      linarith
    have h2 : 2 / (m : ℝ) < ε := by
      rw [div_lt_iff₀ hmpos]; nlinarith
    linarith
  · have hdir := norm_div_norm_sub_le hu0 hw0
    have hub : u / (‖u‖ : ℂ) = e β := by
      rw [hun, hu]
      have : ((1 / (m : ℝ) : ℝ) : ℂ) = 1 / (m : ℂ) := by push_cast; rfl
      rw [this]
      have hmc : (m : ℂ) ≠ 0 := by exact_mod_cast hmpos.ne'
      field_simp
    rw [hub] at hdir
    refine lt_of_le_of_lt hdir ?_
    rw [hun, div_lt_iff₀ (by positivity)]
    have : 2 * ‖z n - x - u‖ < 2 * (1 / (m : ℝ) ^ 2) := by linarith
    have h3 : 2 * (1 / (m : ℝ) ^ 2) = ε * (1 / m) * (2 / (ε * m)) := by field_simp
    have h4 : 2 / (ε * (m : ℝ)) < 1 := by rw [div_lt_one (by positivity)]; linarith
    calc 2 * ‖z n - x - u‖ < 2 * (1 / (m : ℝ) ^ 2) := this
      _ = ε * (1 / m) * (2 / (ε * m)) := h3
      _ ≤ ε * (1 / m) := by
        have : 0 ≤ ε * (1 / (m : ℝ)) := by positivity
        nlinarith

/-! ## The germ dichotomy -/

/-- Inside a ball meeting finitely many arcs, the points of the unit circle on the arcs that are not arcs of it are
finitely many. -/
theorem finite_nonring_inter_sphere (p : ℂ) {y : ℂ} {ε : ℝ}
    (hfin : {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty}.Finite) :
    (⋃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty ∧ ¬ a.OnRing p}, a.carrier ∩ sphere p 1).Finite := by
  refine (hfin.subset ?_ : {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty ∧ ¬ a.OnRing p}.Finite).biUnion ?_
  · rintro a ⟨ha, hne, -⟩; exact ⟨ha, hne⟩
  · rintro a ⟨ha, -, hring⟩
    rcases Arc.finite_inter_sphere_or_eq_circ a (F.nondegenerate a ha) p with h | ⟨θ₀, θ₁, rfl⟩
    · exact h
    · exact absurd ⟨θ₀, θ₁, rfl⟩ hring

/-- A point of a ball meeting finitely many arcs that lies on no arc other than arcs of `ω(p)` has a neighbourhood meeting
only arcs of `ω(p)`. -/
theorem exists_ball_onRing (p : ℂ) {y : ℂ} {ε : ℝ}
    (hfin : {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty}.Finite) {x : ℂ} (hx : x ∈ ball y ε)
    (hxn : ∀ a ∈ F.arcs, ¬ a.OnRing p → x ∉ a.carrier) :
    ∃ r0 > 0, ball x r0 ⊆ ball y ε ∧ ∀ a ∈ F.arcs, (a.carrier ∩ ball x r0).Nonempty → a.OnRing p := by
  set bad : Set ℂ := ⋃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty ∧ ¬ a.OnRing p}, a.carrier with hbad
  have hbfin : {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty ∧ ¬ a.OnRing p}.Finite :=
    hfin.subset fun a ⟨ha, hne, _⟩ => ⟨ha, hne⟩
  have hcl : IsClosed bad := hbfin.isClosed_biUnion fun a ha => a.isClosed_carrier
  have hxb : x ∉ bad := by
    intro h
    obtain ⟨a, ⟨ha, -, hr⟩, hxa⟩ := mem_iUnion₂.mp h
    exact hxn a ha hr hxa
  obtain ⟨r0, hr0, hsub⟩ := Metric.isOpen_iff.mp (isOpen_ball.inter hcl.isOpen_compl) x ⟨hx, hxb⟩
  refine ⟨r0, hr0, fun z hz => (hsub hz).1, fun a ha hne => ?_⟩
  obtain ⟨z, hza, hz⟩ := hne
  by_contra hr
  exact (hsub hz).2 (mem_iUnion₂.mpr ⟨a, ⟨ha, ⟨z, hza, (hsub hz).1⟩, hr⟩, hza⟩)


/-- **The sides of a ring point**: if a ball about `r(φ)` lies in the domain and meets only arcs of `ω(p)`, then for angles in a
neighbourhood of `φ` the colours just inside and just outside the ring are each one colour, the same for all of them. -/
theorem exists_sides_nbhd (p : ℂ) {φ r0 : ℝ} (hr0 : 0 < r0) (hdom : ball (ringPt p φ) r0 ⊆ F.dom)
    (hring : ∀ a ∈ F.arcs, (a.carrier ∩ ball (ringPt p φ) r0).Nonempty → a.OnRing p) :
    ∃ κ > 0, ∃ c c' : Fin k, ∀ φ' ∈ Ioo (φ - κ) (φ + κ),
      F.innerColours p (ringPt p φ') = {c} ∧ F.outerColours p (ringPt p φ') = {c'} := by
  set κ : ℝ := min (r0 / 4) (1 / 2) with hκ
  have hκ0 : 0 < κ := lt_min (by positivity) (by norm_num)
  have hκ1 : κ ≤ r0 / 4 := min_le_left _ _
  have hκ2 : κ ≤ 1 / 2 := min_le_right _ _
  -- polar points near `r(φ)` off the ring are interior points
  have hint : ∀ ρ ψ : ℝ, |ρ - 1| < κ → ρ ≠ 1 → |ψ - φ| < κ → polarPt p ρ ψ ∈ F.interiorPts := by
    intro ρ ψ hρ hρ1 hψ
    have hball : polarPt p ρ ψ ∈ ball (ringPt p φ) r0 := by
      rw [mem_ball]
      linarith [dist_polarPt_ringPt_le p ρ ψ φ]
    refine ⟨hdom hball, fun hz => ?_⟩
    obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp hz
    have hr := hring a ha ⟨_, hza, hball⟩
    have hs := hr.carrier_subset_sphere hza
    rw [mem_sphere, dist_eq_norm, norm_polarPt_sub, abs_of_pos (by linarith [(abs_lt.mp hρ).1, hκ2])] at hs
    exact hρ1 hs
  -- one colour on each side box
  have hbox : ∀ J : Set ℝ, IsPreconnected J → J ⊆ {ρ | |ρ - 1| < κ ∧ ρ ≠ 1} → J.Nonempty →
      ∃ c, ∀ ρ ∈ J, ∀ ψ ∈ Ioo (φ - κ) (φ + κ), polarPt p ρ ψ ∈ F.region c := by
    intro J hJ hJs ⟨ρ0, hρ0⟩
    have hconn : IsPreconnected ((fun q : ℝ × ℝ => polarPt p q.1 q.2) '' (J ×ˢ Ioo (φ - κ) (φ + κ))) :=
      (hJ.prod isPreconnected_Ioo).image _ (continuous_polarPt p).continuousOn
    have hsub : ((fun q : ℝ × ℝ => polarPt p q.1 q.2) '' (J ×ˢ Ioo (φ - κ) (φ + κ))) ⊆ F.interiorPts := by
      rintro _ ⟨⟨ρ, ψ⟩, ⟨hρ, hψ⟩, rfl⟩
      exact hint ρ ψ (hJs hρ).1 (hJs hρ).2 (by rw [abs_lt]; constructor <;> linarith [hψ.1, hψ.2])
    refine ⟨F.col (polarPt p ρ0 φ), fun ρ hρ ψ hψ => ⟨hsub ⟨(ρ, ψ), ⟨hρ, hψ⟩, rfl⟩, ?_⟩⟩
    exact hconn.constant (F.continuousOn_col.mono hsub) ⟨(ρ, ψ), ⟨hρ, hψ⟩, rfl⟩
      ⟨(ρ0, φ), ⟨hρ0, ⟨by linarith, by linarith⟩⟩, rfl⟩
  obtain ⟨c, hc⟩ := hbox (Ioo (1 - κ) 1) isPreconnected_Ioo
    (fun ρ hρ => ⟨by rw [abs_lt]; constructor <;> linarith [hρ.1, hρ.2], hρ.2.ne⟩)
    ⟨1 - κ / 2, by constructor <;> linarith⟩
  obtain ⟨c', hc'⟩ := hbox (Ioo 1 (1 + κ)) isPreconnected_Ioo
    (fun ρ hρ => ⟨by rw [abs_lt]; constructor <;> linarith [hρ.1, hρ.2], hρ.1.ne'⟩)
    ⟨1 + κ / 2, by constructor <;> linarith⟩
  refine ⟨κ, hκ0, c, c', fun φ' hφ' => ⟨?_, ?_⟩⟩
  · -- inside
    ext c''
    simp only [mem_singleton_iff]
    constructor
    · intro hmem
      obtain ⟨ν, hν, hnu⟩ := polar_nbhd p hφ'
      have hmem' : ringPt p φ' ∈ closure (F.region c'' ∩ ball p 1) := hmem
      obtain ⟨z, ⟨hzr, hzb⟩, hzd⟩ := Metric.mem_closure_iff.mp hmem' (min ν κ) (lt_min hν hκ0)
      rw [dist_comm] at hzd
      obtain ⟨hρ, ψ, hψ, hz⟩ := hnu z (lt_of_lt_of_le hzd (min_le_left _ _))
      have hzn : ‖z - p‖ < 1 := by simpa [dist_eq_norm] using hzb
      have hρκ : ‖z - p‖ ∈ Ioo (1 - κ) 1 := by
        refine ⟨?_, hzn⟩
        have : dist z (ringPt p φ') < κ := lt_of_lt_of_le hzd (min_le_right _ _)
        have h2 := abs_norm_sub_one_le p z φ'
        linarith [(abs_le.mp h2).1]
      have hψ' : ψ ∈ Ioo (φ - κ) (φ + κ) := ⟨by linarith [hψ.1, hφ'.1], by linarith [hψ.2, hφ'.2]⟩
      have := (hc _ hρκ ψ hψ').2
      rw [← hz] at this
      exact hzr.2.symm.trans this
    · intro hcc
      rw [hcc]
      show ringPt p φ' ∈ closure (F.region c ∩ ball p 1)
      rw [mem_closure_iff_nhds]
      intro U hU
      obtain ⟨ε', hε', hεU⟩ := Metric.mem_nhds_iff.mp hU
      set ρ := 1 - min κ ε' / 2 with hρ
      have hmk : 0 < min κ ε' := lt_min hκ0 hε'
      have hρ1 : ρ ∈ Ioo (1 - κ) 1 :=
        ⟨by linarith [min_le_left κ ε'], by linarith⟩
      refine ⟨polarPt p ρ φ', hεU ?_, ?_, ?_⟩
      · rw [mem_ball]
        have := dist_polarPt_ringPt_le p ρ φ' φ'
        rw [sub_self, abs_zero, add_zero] at this
        refine lt_of_le_of_lt this ?_
        rw [abs_of_neg (by linarith)]
        linarith [min_le_right κ ε']
      · exact hc _ hρ1 φ' hφ'
      · rw [mem_ball, dist_eq_norm, norm_polarPt_sub, abs_of_pos (by linarith [hρ1.1, hκ0])]
        exact hρ1.2
  · -- outside
    ext c''
    simp only [mem_singleton_iff]
    constructor
    · intro hmem
      obtain ⟨ν, hν, hnu⟩ := polar_nbhd p hφ'
      have hmem' : ringPt p φ' ∈ closure (F.region c'' \ closedBall p 1) := hmem
      obtain ⟨z, ⟨hzr, hzb⟩, hzd⟩ := Metric.mem_closure_iff.mp hmem' (min ν κ) (lt_min hν hκ0)
      rw [dist_comm] at hzd
      obtain ⟨hρ, ψ, hψ, hz⟩ := hnu z (lt_of_lt_of_le hzd (min_le_left _ _))
      have hzn : 1 < ‖z - p‖ := by simpa [dist_eq_norm] using hzb
      have hρκ : ‖z - p‖ ∈ Ioo 1 (1 + κ) := by
        refine ⟨hzn, ?_⟩
        have : dist z (ringPt p φ') < κ := lt_of_lt_of_le hzd (min_le_right _ _)
        have h2 := abs_norm_sub_one_le p z φ'
        linarith [(abs_le.mp h2).2]
      have hψ' : ψ ∈ Ioo (φ - κ) (φ + κ) := ⟨by linarith [hψ.1, hφ'.1], by linarith [hψ.2, hφ'.2]⟩
      have := (hc' _ hρκ ψ hψ').2
      rw [← hz] at this
      exact hzr.2.symm.trans this
    · intro hcc
      rw [hcc]
      show ringPt p φ' ∈ closure (F.region c' \ closedBall p 1)
      rw [mem_closure_iff_nhds]
      intro U hU
      obtain ⟨ε', hε', hεU⟩ := Metric.mem_nhds_iff.mp hU
      set ρ := 1 + min κ ε' / 2 with hρ
      have hmk : 0 < min κ ε' := lt_min hκ0 hε'
      have hρ1 : ρ ∈ Ioo 1 (1 + κ) :=
        ⟨by linarith, by linarith [min_le_left κ ε']⟩
      refine ⟨polarPt p ρ φ', hεU ?_, ?_, ?_⟩
      · rw [mem_ball]
        have := dist_polarPt_ringPt_le p ρ φ' φ'
        rw [sub_self, abs_zero, add_zero] at this
        refine lt_of_le_of_lt this ?_
        rw [abs_of_pos (by linarith)]
        linarith [min_le_right κ ε']
      · exact hc' _ hρ1 φ' hφ'
      · rw [mem_closedBall, dist_eq_norm, norm_polarPt_sub, abs_of_pos (by linarith [hρ1.1])]
        linarith [hρ1.1]

/-- **Constancy of the sides**: if the sides of the ring are locally constant along a preconnected set of angles, they are
constant on it. -/
theorem sides_const (p : ℂ) {I : Set ℝ} (hI : IsPreconnected I) (hne : I.Nonempty)
    (hloc : ∀ φ ∈ I, ∃ κ > 0, ∃ c c' : Fin k, ∀ φ' ∈ Ioo (φ - κ) (φ + κ),
      F.innerColours p (ringPt p φ') = {c} ∧ F.outerColours p (ringPt p φ') = {c'}) :
    ∃ c c' : Fin k, ∀ φ ∈ I, F.innerColours p (ringPt p φ) = {c} ∧ F.outerColours p (ringPt p φ) = {c'} := by
  classical
  obtain ⟨φ₀, hφ₀⟩ := hne
  obtain ⟨κ₀, -, c₀, c₀', -⟩ := hloc φ₀ hφ₀
  haveI : Nonempty (Fin k × Fin k) := ⟨(c₀, c₀')⟩
  let P : ℝ → Fin k × Fin k → Prop := fun φ cc =>
    F.innerColours p (ringPt p φ) = {cc.1} ∧ F.outerColours p (ringPt p φ) = {cc.2}
  have huniq : ∀ φ cc dd, P φ cc → P φ dd → cc = dd := by
    intro φ cc dd h1 h2
    exact Prod.ext (Set.singleton_eq_singleton_iff.mp (h1.1.symm.trans h2.1))
      (Set.singleton_eq_singleton_iff.mp (h1.2.symm.trans h2.2))
  let f : ℝ → Fin k × Fin k := fun φ => Classical.epsilon (P φ)
  have hf : ∀ φ cc, P φ cc → f φ = cc := fun φ cc h =>
    huniq φ _ _ (Classical.epsilon_spec (p := P φ) ⟨cc, h⟩) h
  have hcont : ContinuousOn f I := by
    intro φ hφ
    obtain ⟨κ, hκ, c, c', h⟩ := hloc φ hφ
    refine ContinuousAt.continuousWithinAt ?_
    have hev : ∀ᶠ φ' in 𝓝 φ, f φ' = (c, c') := by
      filter_upwards [Ioo_mem_nhds (show φ - κ < φ by linarith) (show φ < φ + κ by linarith)] with φ' hφ'
      exact hf φ' (c, c') (h φ' hφ')
    have hφ : f φ = (c, c') := hf φ (c, c') (h φ ⟨by linarith, by linarith⟩)
    exact continuousAt_const.congr (hev.mono fun φ' h' => hφ.trans h'.symm)
  refine ⟨(f φ₀).1, (f φ₀).2, fun φ hφ => ?_⟩
  have hfφ : f φ = f φ₀ := hI.constant hcont hφ hφ₀
  obtain ⟨κ, hκ, c, c', h⟩ := hloc φ hφ
  have hP : P φ (c, c') := h φ ⟨by linarith, by linarith⟩
  have : (c, c') = f φ₀ := (hf φ _ hP).symm.trans hfφ
  rw [← this]
  exact hP

/-- **The germ dichotomy**: at a ring point `r(θ)` of the domain, the germ of `ω(p)` on either side lies in one colour
class, or on an arc of `Γ` on `ω(p)` with constant sides (the strip beside a short germ avoids every other arc, which
meets `ω(p)` in finitely many points). -/
theorem germ_dichotomy {p : ℂ} {θ : ℝ} (hθ : ringPt p θ ∈ F.dom) (s : Side) :
    (∃ c, GermIn p θ s (F.region c)) ∨
      ∃ θ₁ θ₂ c c', F.IsRingArc p θ₁ θ₂ c c' ∧ GermIn p θ s (ringArc p θ₁ θ₂) := by
  classical
  have hπ := Real.pi_pos
  obtain ⟨ε, hε, hdomε, hfin⟩ := F.exists_ball_finite hθ
  set y := ringPt p θ with hy
  have hNfin := F.finite_nonring_inter_sphere p hfin
  set N := ⋃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty ∧ ¬ a.OnRing p}, a.carrier ∩ sphere p 1 with hN
  -- short germs avoid the finite set of crossings
  have hgermN : ∀ᶠ δ in 𝓝[>] (0 : ℝ), ∀ n ∈ N, n ∉ germ p θ s δ := by
    refine (Filter.eventually_all_finite hNfin).2 fun n _ => ?_
    by_cases hny : n = y
    · filter_upwards [Ioo_mem_nhdsGT (show (0 : ℝ) < 2 * π by positivity)] with δ hδ
      rw [hny]; exact ringPt_notMem_germ hδ.2.le
    · have hd : 0 < dist n y := dist_pos.mpr hny
      filter_upwards [Ioo_mem_nhdsGT hd] with δ hδ hmem
      have h2 : dist n y < δ := dist_lt_of_mem_germ hmem
      linarith [hδ.2]
  have hsmall : ∀ᶠ δ in 𝓝[>] (0 : ℝ), δ < ε / 2 := by
    filter_upwards [Ioo_mem_nhdsGT (show (0 : ℝ) < ε / 2 by positivity)] with δ h using h.2
  have hpos : ∀ᶠ δ in 𝓝[>] (0 : ℝ), 0 < δ := self_mem_nhdsWithin
  -- a germ short enough lies in interior points unless an arc of `ω(p)` meets it
  have hgerm_int : ∀ δ, 0 < δ → δ < ε / 2 → (∀ n ∈ N, n ∉ germ p θ s δ) →
      (∀ a ∈ F.arcs, a.OnRing p → (a.carrier ∩ ball y ε).Nonempty → Disjoint (germ p θ s δ) a.carrier) →
      germ p θ s δ ⊆ F.interiorPts := by
    intro δ hδ hδε hN' hA z hz
    have hzb : z ∈ ball y ε := by
      rw [mem_ball]; linarith [dist_lt_of_mem_germ hz]
    refine ⟨hdomε hzb, fun hzΓ => ?_⟩
    obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp hzΓ
    by_cases hr : a.OnRing p
    · exact Set.disjoint_left.mp (hA a ha hr ⟨z, hza, hzb⟩) hz hza
    · have hzs : z ∈ sphere p 1 := by
        obtain ⟨t, -, rfl⟩ := hz
        exact ringPt_mem_sphere _ _
      exact hN' z (mem_iUnion₂.mpr ⟨a, ⟨ha, ⟨z, hza, hzb⟩, hr⟩, hza, hzs⟩) hz
  -- the arcs of `ω(p)` near `y`
  set 𝒜₁ := {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty ∧ a.OnRing p} with h𝒜₁
  have h𝒜₁fin : 𝒜₁.Finite := hfin.subset fun a ⟨ha, hne, _⟩ => ⟨ha, hne⟩
  by_cases hA : ∀ᶠ δ in 𝓝[>] (0 : ℝ), ∀ a ∈ 𝒜₁, Disjoint (germ p θ s δ) a.carrier
  · -- the germ lies in one colour class
    left
    obtain ⟨δ, ⟨⟨⟨hδA, hδN⟩, hδs⟩, hδp⟩⟩ := ((((hA.and hgermN).and hsmall).and hpos)).exists
    have hint := hgerm_int δ hδp hδs hδN (fun a ha hr hne => hδA a ⟨ha, hne, hr⟩)
    set z0 := ringPt p (θ + s.sign * (δ / 2)) with hz0
    have hz0g : z0 ∈ germ p θ s δ := ⟨δ / 2, ⟨by linarith, by linarith⟩, rfl⟩
    exact ⟨F.col z0, δ, hδp, fun z hz => ⟨hint hz,
      (isPreconnected_germ p θ s δ).constant (F.continuousOn_col.mono hint) hz hz0g⟩⟩
  · -- an arc of `ω(p)` meets every short germ
    right
    have hex : ∃ a ∈ 𝒜₁, ∀ δ > 0, (germ p θ s δ ∩ a.carrier).Nonempty := by
      by_contra hcon
      push Not at hcon
      apply hA
      refine (Filter.eventually_all_finite h𝒜₁fin).2 fun a ha => ?_
      obtain ⟨δa, hδa, hemp⟩ := hcon a ha
      filter_upwards [Ioo_mem_nhdsGT hδa] with δ hδ
      refine Set.disjoint_left.mpr fun z hz hza => ?_
      have : z ∈ germ p θ s δa ∩ a.carrier := ⟨germ_mono hδ.2.le hz, hza⟩
      rw [hemp] at this
      exact this
    obtain ⟨a, ⟨haF, hane, hring⟩, hhit⟩ := hex
    obtain ⟨θ₀, θ₁, rfl⟩ := hring
    obtain ⟨-, hlt, hle⟩ := F.nondegenerate _ haF
    rw [carrier_circ_unit] at hhit
    have hclosed : IsClosed (ringArc p θ₀ θ₁) := by
      rw [← carrier_circ_unit]; exact Arc.isClosed_carrier _
    have hymem : y ∈ ringArc p θ₀ θ₁ := by
      refine hclosed.closure_subset_iff.mpr subset_rfl ?_
      rw [Metric.mem_closure_iff]
      intro ε' hε'
      obtain ⟨z, hzg, hza⟩ := hhit ε' hε'
      exact ⟨z, hza, by rw [dist_comm]; exact dist_lt_of_mem_germ hzg⟩
    obtain ⟨δ₁, ⟨⟨hδN, hδs⟩, hδp⟩⟩ := (((hgermN.and hsmall).and hpos)).exists
    obtain ⟨δ', hδ'0, hδ'le, hsub⟩ := exists_germ_subset_ringArc hlt hle s hymem hhit hδp
    have hN' : ∀ n ∈ N, n ∉ germ p θ s δ' := fun n hn h => hδN n hn (germ_mono hδ'le h)
    have hδ'ε : δ' < ε / 2 := lt_of_le_of_lt hδ'le hδs
    obtain ⟨θ₁', θ₂', hlt', hIcc, hIoo⟩ : ∃ θ₁' θ₂' : ℝ, θ₁' < θ₂' ∧
        (∀ φ, φ ∈ Icc θ₁' θ₂' ↔ ∃ u ∈ Icc 0 δ', φ = θ + s.sign * u) ∧
        (∀ φ, φ ∈ Ioo θ₁' θ₂' ↔ ∃ u ∈ Ioo 0 δ', φ = θ + s.sign * u) := by
      cases s
      · refine ⟨θ - δ', θ, by linarith, fun φ => ?_, fun φ => ?_⟩
        · simp only [Side.sign]
          constructor
          · intro h; exact ⟨θ - φ, ⟨by linarith [h.2], by linarith [h.1]⟩, by ring⟩
          · rintro ⟨u, hu, rfl⟩; exact ⟨by linarith [hu.2], by linarith [hu.1]⟩
        · simp only [Side.sign]
          constructor
          · intro h; exact ⟨θ - φ, ⟨by linarith [h.2], by linarith [h.1]⟩, by ring⟩
          · rintro ⟨u, hu, rfl⟩; exact ⟨by linarith [hu.2], by linarith [hu.1]⟩
      · refine ⟨θ, θ + δ', by linarith, fun φ => ?_, fun φ => ?_⟩
        · simp only [Side.sign]
          constructor
          · intro h; exact ⟨φ - θ, ⟨by linarith [h.1], by linarith [h.2]⟩, by ring⟩
          · rintro ⟨u, hu, rfl⟩; exact ⟨by linarith [hu.1], by linarith [hu.2]⟩
        · simp only [Side.sign]
          constructor
          · intro h; exact ⟨φ - θ, ⟨by linarith [h.1], by linarith [h.2]⟩, by ring⟩
          · rintro ⟨u, hu, rfl⟩; exact ⟨by linarith [hu.1], by linarith [hu.2]⟩
    have hGermIn : GermIn p θ s (ringArc p θ₁' θ₂') :=
      ⟨δ', hδ'0, fun z ⟨t, ht, hz⟩ => ⟨θ + s.sign * t, (hIcc _).2 ⟨t, ⟨ht.1.le, ht.2.le⟩, rfl⟩, hz⟩⟩
    have hΓ : ringArc p θ₁' θ₂' ⊆ F.Γ := by
      rintro _ ⟨φ, hφ, rfl⟩
      obtain ⟨u, hu, rfl⟩ := (hIcc φ).1 hφ
      have hball : ringPt p (θ + s.sign * u) ∈ ball y ε := by
        rw [mem_ball]
        have h2 : dist (ringPt p (θ + s.sign * u)) y ≤ u := dist_ringPt_side_le p θ s hu.1
        linarith [hu.2]
      refine ⟨hdomε hball, mem_iUnion₂.mpr ⟨Arc.circ p 1 θ₀ θ₁, haF, ?_⟩⟩
      rw [carrier_circ_unit]
      have hcl : ringPt p (θ + s.sign * u) ∈ closure (germ p θ s δ') := by
        have hc : Continuous fun t : ℝ => ringPt p (θ + s.sign * t) := by unfold ringPt e; fun_prop
        have hu' : u ∈ closure (Ioo (0 : ℝ) δ') := by rw [closure_Ioo hδ'0.ne]; exact hu
        exact map_mem_closure (f := fun t : ℝ => ringPt p (θ + s.sign * t)) hc hu' (mapsTo_image _ _)
      exact hclosed.closure_subset_iff.mpr hsub hcl
    have hloc : ∀ φ ∈ Ioo θ₁' θ₂', ∃ κ > 0, ∃ c c' : Fin k, ∀ φ' ∈ Ioo (φ - κ) (φ + κ),
        F.innerColours p (ringPt p φ') = {c} ∧ F.outerColours p (ringPt p φ') = {c'} := by
      intro φ hφ
      obtain ⟨u, hu, rfl⟩ := (hIoo φ).1 hφ
      have hzg : ringPt p (θ + s.sign * u) ∈ germ p θ s δ' := ⟨u, hu, rfl⟩
      have hzb : ringPt p (θ + s.sign * u) ∈ ball y ε := by
        rw [mem_ball]
        have h2 : dist (ringPt p (θ + s.sign * u)) y < δ' := dist_lt_of_mem_germ hzg
        linarith
      have hxn : ∀ a' ∈ F.arcs, ¬ a'.OnRing p → ringPt p (θ + s.sign * u) ∉ a'.carrier := by
        intro a' ha' hr hza
        exact hN' _ (mem_iUnion₂.mpr ⟨a', ⟨ha', ⟨_, hza, hzb⟩, hr⟩, hza, ringPt_mem_sphere _ _⟩) hzg
      obtain ⟨r0, hr0, hrb, hring'⟩ := F.exists_ball_onRing p hfin hzb hxn
      exact F.exists_sides_nbhd p hr0 (hrb.trans hdomε) hring'
    obtain ⟨c, c', hcc⟩ := F.sides_const p isPreconnected_Ioo
      ⟨(θ₁' + θ₂') / 2, by constructor <;> linarith⟩ hloc
    exact ⟨θ₁', θ₂', c, c', ⟨hlt', hΓ, fun φ hφ => hcc φ hφ⟩, hGermIn⟩


/-! ## Interval cones in a simple map -/

section Simple

variable {F}

/-- **In a simple map each tile's cone at a point of its closure is one closed angular interval** (possibly a single
direction, a cusp, or every direction): near the point the tile's boundary is a Jordan curve with exactly two branches,
each a segment or a circular arc, and the tile is the sector between them. -/
theorem Simple.coneAt_eq_angleIcc (hS : F.Simple) {T : Set ℂ} (hT : F.IsTile T) {x : ℂ} (hxd : x ∈ F.dom)
    (hx : x ∈ closure T) :
    ∃ β₁ β₂, β₁ ≤ β₂ ∧ β₂ ≤ β₁ + 2 * π ∧ coneAt T x = angleIcc β₁ β₂ := by
  have _hxd := hxd
  exact (hS.1 T hT).coneAt_eq_angleIcc hT.isOpen hx

end Simple

end ArcMap

end HadwigerNelson.Plane
