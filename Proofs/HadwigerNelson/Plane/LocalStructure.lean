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

* **The sector structure at a point** (`localSectors`, FS131-I3i; inventory item 136): for small radii the arcs about a
  point of the domain are finitely many **branch germs** — a tangent direction and a signed curvature each (`branchPt`,
  `BranchGerms`) — sorted counter-clockwise, and the interior points near the point are the open **sectors** between
  consecutive germs, the same for every smaller radius: open, connected, disjoint, each with the cone of its two germs'
  directions (`ArcMap.IsSectorChart`); a cusp is a sector between two tangent germs, its cone one direction.

The inversion engine late in the module (`rotD`, `invC`, `Rgn`, `levD`: the chart `ζ ↦ ζ/|ζ|²` about a point turns every
curve through it into a line) gives the wedge lemma, tiles' cones with disjoint interiors, and initial pieces of arcs.
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

/-! ## The inversion engine: wedges about a direction, cones with disjoint interiors, initial pieces -/

/-- `e(σ π/2) = σ i` for `σ = ±1`. -/
theorem ArcMap.e_sigma_half {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) : e (σ * (π / 2)) = (σ : ℂ) * I := by
  rcases hσ with rfl | rfl
  · simp [e_pi_div_two]
  · rw [show (-1 : ℝ) * (π / 2) = -(π / 2) by ring, e_neg]; simp

/-! ## Inversion coordinates at a point -/

/-- The displacement from `y`, rotated by `-δ` where `u = e δ`: the direction `u` becomes the positive real axis. -/
noncomputable def rotD (y u w : ℂ) : ℂ := (w - y) * (starRingEnd ℂ) u

/-- The inversion `ζ ↦ ζ / |ζ|²` (it is `(conj ζ)⁻¹`). -/
noncomputable def invC (ζ : ℂ) : ℂ := ((starRingEnd ℂ) ζ)⁻¹

theorem invC_invC (ζ : ℂ) : invC (invC ζ) = ζ := by
  simp [invC, map_inv₀]

theorem invC_re (ζ : ℂ) : (invC ζ).re = ζ.re / Complex.normSq ζ := by
  simp [invC, Complex.inv_re]

theorem invC_im (ζ : ℂ) : (invC ζ).im = ζ.im / Complex.normSq ζ := by
  simp [invC, Complex.inv_im]

theorem invC_ne_zero {ζ : ℂ} (h : ζ ≠ 0) : invC ζ ≠ 0 := by
  simp [invC, h]

theorem continuousOn_invC : ContinuousOn invC {ζ : ℂ | ζ ≠ 0} := by
  unfold invC
  exact ContinuousOn.inv₀ (Complex.continuous_conj.continuousOn) (fun ζ hζ => by simpa using hζ)

theorem rotD_eq (y u w : ℂ) (hu : ‖u‖ = 1) : (w - y) = rotD y u w * u := by
  unfold rotD
  have : (starRingEnd ℂ) u * u = 1 := by
    rw [mul_comm, Complex.mul_conj, Complex.normSq_eq_norm_sq, hu]; simp
  calc w - y = (w - y) * ((starRingEnd ℂ) u * u) := by rw [this, mul_one]
    _ = _ := by ring

theorem normSq_rotD (y u w : ℂ) (hu : ‖u‖ = 1) : Complex.normSq (rotD y u w) = Complex.normSq (w - y) := by
  unfold rotD
  simp [map_mul, Complex.normSq_eq_norm_sq, hu]

theorem rotD_ne_zero_iff (y u w : ℂ) (hu : ‖u‖ = 1) : rotD y u w ≠ 0 ↔ w ≠ y := by
  unfold rotD
  have hu0 : (starRingEnd ℂ) u ≠ 0 := by
    intro h; rw [map_eq_zero] at h; simp [h] at hu
  simp [hu0, sub_eq_zero]

/-- The wedge region of directions near `u` at distance below `1/N`, in coordinates: in the inverted plane
it is the convex set `{ν : N < Re ν, |Im ν| < m Re ν}`. -/
def Rgn (y u : ℂ) (N m : ℝ) : Set ℂ :=
  {w | w ≠ y ∧ N * Complex.normSq (rotD y u w) < (rotD y u w).re ∧ |(rotD y u w).im| < m * (rotD y u w).re}

/-- The level function: `σ Im ν` in the inverted plane. -/
noncomputable def levD (y u : ℂ) (σ : ℝ) (w : ℂ) : ℝ := σ * (rotD y u w).im / Complex.normSq (rotD y u w)

/-- The inverted wedge. -/
def Kinv (N m : ℝ) : Set ℂ := {ν | N < ν.re ∧ |ν.im| < m * ν.re}

theorem mem_Rgn_iff {y u w : ℂ} (hu : ‖u‖ = 1) (N m : ℝ) :
    w ∈ Rgn y u N m ↔ w ≠ y ∧ invC (rotD y u w) ∈ Kinv N m := by
  by_cases hw : w = y
  · simp [Rgn, hw]
  · have hζ : rotD y u w ≠ 0 := (rotD_ne_zero_iff y u w hu).mpr hw
    have hpos : 0 < Complex.normSq (rotD y u w) := Complex.normSq_pos.mpr hζ
    simp only [Rgn, Kinv, mem_setOf_eq, invC_re, invC_im, hw, ne_eq, not_false_eq_true, true_and]
    rw [lt_div_iff₀ hpos, abs_div, abs_of_pos hpos, ← mul_div_assoc, div_lt_div_iff_of_pos_right hpos]

theorem levD_eq {y u w : ℂ} (σ : ℝ) : levD y u σ w = σ * (invC (rotD y u w)).im := by
  rw [invC_im]; unfold levD; ring

/-- The wedge, cut by a level interval, is the image of a convex set under the inversion: so it is preconnected. -/
theorem isPreconnected_Rgn_lev {y u : ℂ} (hu : ‖u‖ = 1) {N m : ℝ} (hN : 0 < N) (σ : ℝ) {I : Set ℝ}
    (hI : I.OrdConnected) : IsPreconnected {w ∈ Rgn y u N m | levD y u σ w ∈ I} := by
  set K : Set ℂ := {ν | ν ∈ Kinv N m ∧ σ * ν.im ∈ I} with hK
  have hconv : Convex ℝ K := by
    rw [convex_iff_forall_pos]
    intro x hx y hy a b ha hb hab
    obtain ⟨⟨hx1, hx2⟩, hx3⟩ := hx
    obtain ⟨⟨hy1, hy2⟩, hy3⟩ := hy
    have hre : (a • x + b • y).re = a * x.re + b * y.re := by simp
    have him : (a • x + b • y).im = a * x.im + b * y.im := by simp
    refine ⟨⟨?_, ?_⟩, ?_⟩
    · rw [hre]; nlinarith [mul_pos ha (sub_pos.2 hx1), mul_pos hb (sub_pos.2 hy1)]
    · rw [hre, him]
      rw [abs_lt] at hx2 hy2 ⊢
      constructor <;> nlinarith [mul_pos ha (sub_pos.2 hx2.1), mul_pos ha (sub_pos.2 hx2.2), mul_pos hb (sub_pos.2 hy2.1), mul_pos hb (sub_pos.2 hy2.2)]
    · have := (hI.convex hx3 hy3 ha.le hb.le hab)
      simpa [him, mul_add, smul_eq_mul, mul_left_comm] using this
  have himg : {w ∈ Rgn y u N m | levD y u σ w ∈ I} = (fun ν => y + invC ν * u) '' K := by
    ext w
    constructor
    · rintro ⟨hw, hl⟩
      rw [mem_Rgn_iff hu] at hw
      refine ⟨invC (rotD y u w), ⟨hw.2, ?_⟩, ?_⟩
      · rwa [levD_eq] at hl
      · simp only [invC_invC]
        have := rotD_eq y u w hu
        linear_combination (-1 : ℂ) * this
    · rintro ⟨ν, ⟨hν1, hν2⟩, rfl⟩
      have hν0 : ν ≠ 0 := by
        intro h; rw [h] at hν1; simp [Kinv] at hν1
      have hne : invC ν ≠ 0 := invC_ne_zero hν0
      have hrot : rotD y u (y + invC ν * u) = invC ν := by
        unfold rotD
        have : (starRingEnd ℂ) u * u = 1 := by
          rw [mul_comm, Complex.mul_conj, Complex.normSq_eq_norm_sq, hu]; simp
        calc (y + invC ν * u - y) * (starRingEnd ℂ) u = invC ν * (u * (starRingEnd ℂ) u) := by ring
          _ = invC ν := by rw [mul_comm u, this, mul_one]
      have hwy : y + invC ν * u ≠ y := by
        intro h
        have hu0 : u ≠ 0 := by intro h0; simp [h0] at hu
        have : invC ν * u = 0 := by linear_combination h
        rcases mul_eq_zero.mp this with h1 | h1
        · exact hne h1
        · exact hu0 h1
      refine ⟨(mem_Rgn_iff hu N m).mpr ⟨hwy, ?_⟩, ?_⟩
      · rw [hrot, invC_invC]; exact hν1
      · rw [levD_eq, hrot, invC_invC]; exact hν2
  rw [himg]
  refine (hconv.isPreconnected).image _ ?_
  intro ν hν
  have : ν ≠ 0 := by
    intro h; rw [h] at hν; have := hν.1.1; simp at this; linarith
  exact (continuousOn_invC.continuousAt (isOpen_ne.mem_nhds this)).continuousWithinAt.mul continuousWithinAt_const |>.const_add y


theorem conj_mul_self_e (β : ℝ) : (starRingEnd ℂ) (e β) * e β = 1 := by
  rw [mul_comm, Complex.mul_conj, Complex.normSq_eq_norm_sq, norm_e]; simp

/-- A direction in the cone of `S` at `y` puts points of `S` in every wedge about it. -/
theorem exists_mem_Rgn_of_mem_coneAt {S : Set ℂ} {y : ℂ} {β : ℝ} (hβ : β ∈ coneAt S y) {N m : ℝ}
    (hN : 0 < N) (hm : 0 < m) : ∃ w ∈ S, w ∈ Rgn y (e β) N m := by
  set ε : ℝ := min (1 / 2) (min (1 / (2 * N)) (m / 2)) with hε
  have hε0 : 0 < ε := by positivity
  have hε1 : ε ≤ 1 / 2 := min_le_left _ _
  have hε2 : ε ≤ 1 / (2 * N) := (min_le_right _ _).trans (min_le_left _ _)
  have hε3 : ε ≤ m / 2 := (min_le_right _ _).trans (min_le_right _ _)
  obtain ⟨z, hzS, hzy, hzd, hdir⟩ := hβ ε hε0
  refine ⟨z, hzS, hzy, ?_⟩
  have hu : ‖e β‖ = 1 := norm_e β
  set r : ℝ := ‖z - y‖ with hr
  have hr0 : 0 < r := norm_pos_iff.mpr (sub_ne_zero.mpr hzy)
  have hrε : r < ε := by rwa [dist_eq_norm] at hzd
  set η : ℂ := (z - y) / (r : ℂ) * (starRingEnd ℂ) (e β) - 1 with hη
  have hηn : ‖η‖ < ε := by
    have : η = ((z - y) / (r : ℂ) - e β) * (starRingEnd ℂ) (e β) := by
      rw [hη]; linear_combination (1 : ℂ) * (conj_mul_self_e β)
    rw [this, norm_mul, Complex.norm_conj, hu, mul_one]; exact hdir
  have hζ : rotD y (e β) z = (r : ℂ) * (1 + η) := by
    unfold rotD
    rw [hη]
    have : (r : ℂ) ≠ 0 := by exact_mod_cast hr0.ne'
    field_simp; ring
  have hnS : Complex.normSq (rotD y (e β) z) = r ^ 2 := by
    rw [normSq_rotD y _ z hu, Complex.normSq_eq_norm_sq]
  have hre : (rotD y (e β) z).re = r * (1 + η.re) := by rw [hζ]; simp
  have him : (rotD y (e β) z).im = r * η.im := by rw [hζ]; simp
  have h1 : |η.re| < ε := lt_of_le_of_lt (Complex.abs_re_le_norm η) hηn
  have h2 : |η.im| < ε := lt_of_le_of_lt (Complex.abs_im_le_norm η) hηn
  rw [abs_lt] at h1 h2
  have hNr : N * r < 1 / 2 := by
    have : r < 1 / (2 * N) := hrε.trans_le hε2
    rw [lt_div_iff₀ (by positivity)] at this; linarith
  refine ⟨?_, ?_⟩
  · rw [hnS, hre]
    have : N * r ^ 2 = r * (N * r) := by ring
    nlinarith [mul_pos hr0 hr0]
  · rw [him, hre, abs_mul, abs_of_pos hr0]
    have : |η.im| < m * (1 + η.re) := by
      rw [abs_lt]; constructor <;> nlinarith
    calc r * |η.im| < r * (m * (1 + η.re)) := by gcongr
      _ = m * (r * (1 + η.re)) := by ring

/-- Points on the ray at angle `δ + σ u₀` (small `u₀`) lie in the wedge at small distance, with level `sin u₀ / s`. -/
theorem ray_mem_Rgn {y : ℂ} {δ σ u₀ : ℝ} (hσ : σ = 1 ∨ σ = -1) {N m : ℝ} (hN : 0 < N)
    (hu₀ : 0 < u₀) (hu₁ : u₀ < π / 2) (hm : Real.sin u₀ < m * Real.cos u₀) :
    ∃ s₀ > 0, ∀ s : ℝ, s ∈ Ioo 0 s₀ → y + (s : ℂ) * e (δ + σ * u₀) ∈ Rgn y (e δ) N m ∧
      levD y (e δ) σ (y + (s : ℂ) * e (δ + σ * u₀)) = Real.sin u₀ / s := by
  have hc : 0 < Real.cos u₀ := Real.cos_pos_of_mem_Ioo ⟨by linarith, hu₁⟩
  refine ⟨Real.cos u₀ / N, by positivity, fun s hs => ?_⟩
  have _ := hs
  obtain ⟨hs0, hs1⟩ := hs
  have hζ : rotD y (e δ) (y + (s : ℂ) * e (δ + σ * u₀)) = (s : ℂ) * e (σ * u₀) := by
    unfold rotD
    rw [e_add]
    have := conj_mul_self_e δ
    calc (y + (s : ℂ) * (e δ * e (σ * u₀)) - y) * (starRingEnd ℂ) (e δ)
        = (s : ℂ) * e (σ * u₀) * ((starRingEnd ℂ) (e δ) * e δ) := by ring
      _ = _ := by rw [this, mul_one]
  have hre : ((s : ℂ) * e (σ * u₀)).re = s * Real.cos u₀ := by
    rcases hσ with rfl | rfl <;> simp [e_eq, Real.cos_neg, Complex.cos_ofReal_re, Complex.sin_ofReal_re]
  have him : ((s : ℂ) * e (σ * u₀)).im = σ * (s * Real.sin u₀) := by
    rcases hσ with rfl | rfl <;> simp [e_eq, Real.sin_neg, Complex.cos_ofReal_re, Complex.sin_ofReal_re, Complex.cos_ofReal_im, Complex.sin_ofReal_im]
  have hnS : Complex.normSq ((s : ℂ) * e (σ * u₀)) = s ^ 2 := by
    rw [Complex.normSq_eq_norm_sq, norm_mul, norm_e, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hs0]; ring
  have hne : y + (s : ℂ) * e (δ + σ * u₀) ≠ y := by
    intro h
    have : (s : ℂ) * e (δ + σ * u₀) = 0 := by linear_combination h
    rcases mul_eq_zero.mp this with h1 | h1
    · exact hs0.ne' (by exact_mod_cast h1)
    · exact e_ne_zero _ h1
  have hσ2 : σ ^ 2 = 1 := by rcases hσ with rfl | rfl <;> norm_num
  refine ⟨⟨hne, ?_, ?_⟩, ?_⟩
  · rw [hζ, hnS, hre]
    have : N * s < Real.cos u₀ := by rwa [lt_div_iff₀ hN, mul_comm] at hs1
    nlinarith
  · rw [hζ, hre, him, abs_mul, abs_mul, abs_of_pos hs0, abs_of_pos (Real.sin_pos_of_pos_of_lt_pi hu₀ (by linarith)) ]
    have : |σ| = 1 := by rcases hσ with rfl | rfl <;> simp
    rw [this, one_mul]
    nlinarith
  · unfold levD; rw [hζ, hnS, him]
    field_simp; rw [hσ2]; ring_nf


/-- The arc's full curve through `y` is tangent to the direction `u` there. -/
def Arc.Tang (y u : ℂ) (a : Arc) : Prop := ((a.curveData y).2 * (starRingEnd ℂ) u).re = 0

theorem mem_curveAt_iff_rot {y u : ℂ} (hu : ‖u‖ = 1) (κ : ℝ) (b w : ℂ) :
    w ∈ curveAt y κ b ↔ κ * Complex.normSq (rotD y u w) =
      2 * ((rotD y u w).re * (b * (starRingEnd ℂ) u).re + (rotD y u w).im * (b * (starRingEnd ℂ) u).im) := by
  have h1 : (w - y) * (starRingEnd ℂ) b = rotD y u w * (starRingEnd ℂ) (b * (starRingEnd ℂ) u) := by
    have hh := rotD_eq y u w hu
    rw [map_mul, Complex.conj_conj]
    calc (w - y) * (starRingEnd ℂ) b = (rotD y u w * u) * (starRingEnd ℂ) b := by rw [← hh]
      _ = _ := by ring
  have key : ((w - y) * (starRingEnd ℂ) b).re =
      (rotD y u w).re * (b * (starRingEnd ℂ) u).re + (rotD y u w).im * (b * (starRingEnd ℂ) u).im := by
    rw [h1]; simp only [Complex.mul_re, Complex.conj_re, Complex.conj_im]; ring
  show κ * Complex.normSq (w - y) = 2 * ((w - y) * (starRingEnd ℂ) b).re ↔ _
  rw [key, ← normSq_rotD y u w hu]

theorem nontang_avoid {κ N m : ℝ} (hκ : κ = 0 ∨ κ = 1) {ζ b : ℂ} (hb1 : b.re ≠ 0)
    (hm : m * |b.im| < |b.re| / 2) (hN : 1 ≤ N * |b.re|) (hm0 : 0 < m)
    (h1 : N * Complex.normSq ζ < ζ.re) (h2 : |ζ.im| < m * ζ.re) :
    κ * Complex.normSq ζ ≠ 2 * (ζ.re * b.re + ζ.im * b.im) := by
  intro h
  have hre : 0 < ζ.re := by
    have := abs_nonneg ζ.im
    nlinarith
  have hN0 : 0 ≤ N := by
    by_contra hneg
    push Not at hneg
    have : N * |b.re| < 0 := mul_neg_of_neg_of_pos hneg (abs_pos.mpr hb1)
    linarith
  have hns : 0 ≤ Complex.normSq ζ := Complex.normSq_nonneg ζ
  have hκ1 : κ * Complex.normSq ζ ≤ Complex.normSq ζ := by
    rcases hκ with rfl | rfl <;> nlinarith
  have hX : ζ.re * |b.re| / 2 ≤ |ζ.re * b.re + ζ.im * b.im| := by
    have h3 : |ζ.re * b.re| = ζ.re * |b.re| := by rw [abs_mul, abs_of_pos hre]
    have h4 : |ζ.im * b.im| ≤ m * ζ.re * |b.im| := by
      rw [abs_mul]; exact mul_le_mul_of_nonneg_right h2.le (abs_nonneg _)
    have h5 := abs_sub_abs_le_abs_sub (ζ.re * b.re) (-(ζ.im * b.im))
    rw [abs_neg, sub_neg_eq_add] at h5
    have h6 : m * ζ.re * |b.im| ≤ ζ.re * (|b.re| / 2) := by
      nlinarith [mul_pos hre (sub_pos.2 hm)]
    nlinarith
  have hstrict : Complex.normSq ζ < 2 * |ζ.re * b.re + ζ.im * b.im| := by
    rcases eq_or_lt_of_le hns with h0 | h0
    · -- normSq = 0 forces ζ.re ≤ 0, contradiction
      rw [← h0] at h1; nlinarith
    · have : Complex.normSq ζ * 1 ≤ Complex.normSq ζ * (N * |b.re|) := mul_le_mul_of_nonneg_left hN hns
      nlinarith [mul_lt_mul_of_pos_right h1 (abs_pos.mpr hb1)]
  have : |κ * Complex.normSq ζ| = 2 * |ζ.re * b.re + ζ.im * b.im| := by
    rw [h, abs_mul, abs_of_pos (by norm_num : (0:ℝ) < 2)]
  rw [abs_of_nonneg (by rcases hκ with rfl | rfl <;> simp [hns])] at this
  linarith


theorem Rgn_subset_ball {y u : ℂ} (hu : ‖u‖ = 1) {N ρ : ℝ} (hN : 0 < N) (hρ : 1 / N ≤ ρ) (m : ℝ) :
    Rgn y u N m ⊆ ball y ρ := by
  rintro w ⟨hw, h1, -⟩
  rw [mem_ball, dist_eq_norm]
  have hn : Complex.normSq (rotD y u w) = ‖w - y‖ ^ 2 := by
    rw [normSq_rotD y u w hu, Complex.normSq_eq_norm_sq]
  have hre : (rotD y u w).re ≤ ‖w - y‖ := by
    have := Complex.re_le_norm (rotD y u w)
    unfold rotD at this
    rwa [norm_mul, Complex.norm_conj, hu, mul_one] at this
  have hp : 0 < ‖w - y‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hw)
  rw [hn] at h1
  have : N * ‖w - y‖ < 1 := by nlinarith
  calc ‖w - y‖ < 1 / N := by rw [lt_div_iff₀ hN]; linarith
    _ ≤ ρ := hρ

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **The wedge lemma**: in a good ball about `y`, for any direction `u`, a thin wedge about `u` (cone slope `m`, distance
below `1/N`) meets `Γ` only in arcs through `y` that are tangent to `u` there. -/
theorem GoodAt.exists_wedge {y : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt y ρ₀) {u : ℂ} (hu : ‖u‖ = 1) :
    ∃ m > 0, ∃ N₀ > 0, ∀ N ≥ N₀, Rgn y u N m ⊆ ball y ρ₀ ∧
      ∀ w ∈ Rgn y u N m, ∀ a ∈ F.arcs, w ∈ a.carrier → y ∈ a.carrier ∧ a.Tang y u := by
  classical
  set 𝒜 := {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ρ₀).Nonempty} with h𝒜
  have bt : ∀ a : Arc, ((a.curveData y).2 * (starRingEnd ℂ) u) = (a.curveData y).2 * (starRingEnd ℂ) u := fun _ => rfl
  have evm : ∀ᶠ m in 𝓝[>] (0 : ℝ), 0 < m ∧ ∀ a ∈ 𝒜, ¬ a.Tang y u →
      m * |((a.curveData y).2 * (starRingEnd ℂ) u).im| < |((a.curveData y).2 * (starRingEnd ℂ) u).re| / 2 := by
    have h0 : ∀ᶠ m in 𝓝[>] (0 : ℝ), 0 < m := self_mem_nhdsWithin
    refine h0.and ((eventually_all_finite hG.fin).mpr fun a _ => ?_)
    by_cases hT : a.Tang y u
    · exact Filter.Eventually.of_forall fun _ h => absurd hT h
    · have hpos : 0 < |((a.curveData y).2 * (starRingEnd ℂ) u).re| / 2 := by
        have : ((a.curveData y).2 * (starRingEnd ℂ) u).re ≠ 0 := hT
        positivity
      have hc : ContinuousAt (fun m : ℝ => m * |((a.curveData y).2 * (starRingEnd ℂ) u).im|) 0 := by fun_prop
      have := hc.eventually (gt_mem_nhds (by show (0:ℝ) * _ < _; rw [zero_mul]; exact hpos))
      exact Filter.Eventually.mono (Filter.Eventually.filter_mono nhdsWithin_le_nhds this) fun m hm _ => hm
  obtain ⟨m, hm0, hm⟩ := evm.exists
  have evN : ∀ᶠ N in atTop, 1 / ρ₀ ≤ N ∧ 0 < N ∧ ∀ a ∈ 𝒜, ¬ a.Tang y u →
      1 ≤ N * |((a.curveData y).2 * (starRingEnd ℂ) u).re| := by
    refine (eventually_ge_atTop _).and ((eventually_gt_atTop 0).and ((eventually_all_finite hG.fin).mpr fun a _ => ?_))
    by_cases hT : a.Tang y u
    · exact Filter.Eventually.of_forall fun _ h => absurd hT h
    · have hpos : 0 < |((a.curveData y).2 * (starRingEnd ℂ) u).re| := by
        have : ((a.curveData y).2 * (starRingEnd ℂ) u).re ≠ 0 := hT
        positivity
      filter_upwards [eventually_ge_atTop (1 / |((a.curveData y).2 * (starRingEnd ℂ) u).re|)] with N hN _
      rwa [div_le_iff₀ hpos] at hN
  obtain ⟨N₀, hN₀⟩ := eventually_atTop.mp evN
  refine ⟨m, hm0, max N₀ 1, by positivity, fun N hN => ?_⟩
  obtain ⟨hρN, hN0, hNb⟩ := hN₀ N (le_trans (le_max_left _ _) hN)
  have hρ0 := hG.pos
  have hball : Rgn y u N m ⊆ ball y ρ₀ := by
    refine Rgn_subset_ball hu hN0 ?_ m
    have := (div_le_iff₀ hρ0).mp hρN
    rw [div_le_iff₀ hN0]; linarith
  refine ⟨hball, ?_⟩
  · intro w hwR a ha hwa
    have hwb : w ∈ ball y ρ₀ := hball hwR
    have ha𝒜 : a ∈ 𝒜 := ⟨ha, w, hwa, hwb⟩
    have hya := hG.through a ha ⟨w, hwa, hwb⟩
    refine ⟨hya, ?_⟩
    by_contra hT
    have hcurve := Arc.carrier_subset_curve hya hwa
    have hκ := Arc.curveData_kappa y a
    rw [Arc.curve, mem_curveAt_iff_rot hu] at hcurve
    obtain ⟨hw1, hw2, hw3⟩ := hwR
    exact nontang_avoid hκ (by exact hT) (hm a ha𝒜 hT) (hNb a ha𝒜 hT) hm0 hw2 hw3 hcurve

end ArcMap


theorem countable_e_preimage (v : ℂ) : {β : ℝ | e β = v}.Countable := by
  by_cases hne : ∃ β₀, e β₀ = v
  · obtain ⟨β₀, hβ₀⟩ := hne
    refine (Set.countable_range (fun n : ℤ => β₀ + n * (2 * π))).mono ?_
    intro β hβ
    have : e β = e β₀ := hβ.trans hβ₀.symm
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp this
    exact ⟨n, by simp [hn]⟩
  · push Not at hne
    exact (Set.countable_empty).mono fun β hβ => absurd hβ (hne β)

theorem countable_tang_dirs (y : ℂ) (a : Arc) (ha : a.Nondegenerate) (hy : y ∈ a.carrier) :
    {β : ℝ | a.Tang y (e β)}.Countable := by
  have hb := Arc.curveData_ne ha hy
  have hfin := finite_perp_circle (a.curveData y).2 hb 0 1
  refine (hfin.countable.biUnion fun m _ => countable_e_preimage m).mono ?_
  intro β hβ
  refine mem_iUnion₂.mpr ⟨e β, ⟨?_, ?_⟩, rfl⟩
  · have : ((a.curveData y).2 * (starRingEnd ℂ) (e β)).re = 0 := hβ
    simpa [Complex.mul_re, mul_comm] using this
  · have := norm_e β
    have h := Complex.sq_norm (e β)
    rw [Complex.normSq_apply, this] at h
    nlinarith

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- A direction in any open interval that is tangent to none of the arcs through `y` in a good ball. -/
theorem GoodAt.exists_generic_dir {y : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt y ρ₀) {a b : ℝ} (hab : a < b) :
    ∃ β ∈ Ioo a b, ∀ a' ∈ F.arcs, (a'.carrier ∩ ball y ρ₀).Nonempty → ¬ a'.Tang y (e β) := by
  by_contra hcon
  push Not at hcon
  have hsub : Ioo a b ⊆ ⋃ a' ∈ {a' | a' ∈ F.arcs ∧ (a'.carrier ∩ ball y ρ₀).Nonempty}, {β : ℝ | a'.Tang y (e β)} := by
    intro β hβ
    obtain ⟨a', ha', hne, hT⟩ := hcon β hβ
    exact mem_iUnion₂.mpr ⟨a', ⟨ha', hne⟩, hT⟩
  have hc : (⋃ a' ∈ {a' | a' ∈ F.arcs ∧ (a'.carrier ∩ ball y ρ₀).Nonempty}, {β : ℝ | a'.Tang y (e β)}).Countable :=
    hG.fin.countable.biUnion fun a' ha' =>
      countable_tang_dirs y a' (F.nondegenerate a' ha'.1) (hG.through a' ha'.1 ha'.2)
  have h0 := (hc.mono hsub).measure_zero MeasureTheory.volume
  simp [Real.volume_Ioo] at h0
  linarith

/-- **Tiles' cones have disjoint interiors.** At a point `z` of the domain, the cones of two distinct tiles share no open
interval of directions: a direction tangent to no arc has a wedge in the interior points, which lies in one tile. -/
theorem coneAt_interiors_disjoint {T T' : Set ℂ} (hT : F.IsTile T) (hT' : F.IsTile T') (hne : T ≠ T') {z : ℂ}
    (hz : z ∈ F.dom) {a b : ℝ} (hab : a < b) (h1 : Ioo a b ⊆ coneAt T z) (h2 : Ioo a b ⊆ coneAt T' z) : False := by
  obtain ⟨ρ₀, hG⟩ := F.exists_goodAt hz
  obtain ⟨β, hβ, hgen⟩ := hG.exists_generic_dir hab
  have hu : ‖e β‖ = 1 := norm_e β
  obtain ⟨m, hm0, N₀, hN₀, hN⟩ := hG.exists_wedge hu
  set N := max N₀ 1 with hNdef
  have hN0 : 0 < N := lt_max_of_lt_right one_pos
  obtain ⟨hball, hΓ⟩ := hN N (le_max_left _ _)
  have hI : Rgn z (e β) N m ⊆ F.interiorPts := by
    intro w hw
    refine ⟨hG.subdom (hball hw), fun hwa => ?_⟩
    obtain ⟨a', ha', hwa'⟩ := mem_iUnion₂.mp hwa
    obtain ⟨-, hT''⟩ := hΓ w hw a' ha' hwa'
    exact hgen a' ha' ⟨w, hwa', hball hw⟩ hT''
  have hpre : IsPreconnected (Rgn z (e β) N m) := by
    have := isPreconnected_Rgn_lev (y := z) hu hN0 1 (I := Set.univ) ordConnected_univ (m := m)
    simpa using this
  obtain ⟨w, hwT, hwR⟩ := exists_mem_Rgn_of_mem_coneAt (h1 hβ) hN0 hm0
  obtain ⟨w', hwT', hwR'⟩ := exists_mem_Rgn_of_mem_coneAt (h2 hβ) hN0 hm0
  have e1 := hT.subset_of_preconnected hpre hI hwR hwT
  have e2 := hT'.subset_of_preconnected hpre hI hwR' hwT'
  have hwT'' : w ∈ T' := e2 hwR
  obtain ⟨x, hx, rfl⟩ := hT
  obtain ⟨x', hx', rfl⟩ := hT'
  exact hne ((connectedComponentIn_eq hwT).trans (connectedComponentIn_eq hwT'').symm)

end ArcMap

/-! ## Initial pieces from approach -/

theorem e_sub_eq (a b : ℝ) : e (a - b) = e a * (starRingEnd ℂ) (e b) := by
  rw [sub_eq_add_neg, e_add, conj_e]

/-- A circle through `y = c + ρ e θ`, tangent there to `e δ`, has `e δ = e (θ + σ π/2)` with `σ = ±1`. -/
theorem tang_circ {c y : ℂ} {ρ θ δ : ℝ} (hρ : 0 < ρ) (hy : y = c + ρ * e θ)
    (hT : ((c - y) * (starRingEnd ℂ) (e δ)).re = 0) :
    ∃ σ : ℝ, (σ = 1 ∨ σ = -1) ∧ e δ = e (θ + σ * (π / 2)) := by
  have h1 : (c - y) * (starRingEnd ℂ) (e δ) = -(ρ : ℂ) * e (θ - δ) := by
    rw [hy, e_sub_eq]; ring_nf
  rw [h1] at hT
  have hc : Real.cos (θ - δ) = 0 := by
    have : (-(ρ : ℂ) * e (θ - δ)).re = -ρ * Real.cos (θ - δ) := by
      simp only [e_eq, Complex.mul_re, Complex.neg_re, Complex.neg_im, Complex.ofReal_re, Complex.ofReal_im,
        Complex.add_re, Complex.mul_im, Complex.add_im, Complex.I_re, Complex.I_im]; ring
    rw [this] at hT
    rcases mul_eq_zero.mp hT with h | h
    · linarith
    · exact h
  have hs : Real.sin (δ - θ) = 1 ∨ Real.sin (δ - θ) = -1 := by
    have := Real.sin_sq_add_cos_sq (δ - θ)
    have hcc : Real.cos (δ - θ) = 0 := by rw [show δ - θ = -(θ - δ) by ring, Real.cos_neg]; exact hc
    have h2 : Real.sin (δ - θ) ^ 2 = 1 := by rw [hcc] at this; linarith
    exact sq_eq_one_iff.mp h2
  have hc' : Real.cos (δ - θ) = 0 := by rw [← neg_sub, Real.cos_neg]; exact hc
  have hδ : e δ = e θ * e (δ - θ) := by rw [← e_add]; ring_nf
  rcases hs with h | h
  · refine ⟨1, Or.inl rfl, ?_⟩
    rw [hδ, one_mul, e_add, e_pi_div_two]
    congr 1
    rw [e_eq, hc', h]; simp
  · refine ⟨-1, Or.inr rfl, ?_⟩
    rw [hδ, e_add, neg_one_mul, e_neg, Real.cos_pi_div_two, Real.sin_pi_div_two]
    congr 1
    rw [e_eq, hc', h]; simp

theorem e_mul_sign (σ s : ℝ) (hσ : σ = 1 ∨ σ = -1) :
    e (σ * s) = (Real.cos s : ℂ) + (σ : ℂ) * (Real.sin s : ℂ) * I := by
  rcases hσ with rfl | rfl
  · simp [e_eq]
  · rw [neg_one_mul, e_neg]; push_cast; ring

theorem rotD_circ {c : ℂ} {ρ θ δ σ s : ℝ} (hσ : σ = 1 ∨ σ = -1) (hδ : e δ = e (θ + σ * (π / 2))) :
    rotD (c + ρ * e θ) (e δ) (c + ρ * e (θ + σ * s)) =
      ((ρ * Real.sin s : ℝ) : ℂ) + ((σ * ρ * (1 - Real.cos s) : ℝ) : ℂ) * I := by
  have hδ' : e δ = e θ * ((σ : ℂ) * I) := by rw [hδ, e_add, ArcMap.e_sigma_half hσ]
  have hE := e_mul_conj_e θ
  have hσ2 : (σ : ℂ) ^ 2 = 1 := by rcases hσ with rfl | rfl <;> simp
  unfold rotD
  rw [hδ', map_mul, map_mul, Complex.conj_I, Complex.conj_ofReal, e_add, e_mul_sign σ s hσ]
  simp only [Complex.ofReal_mul, Complex.ofReal_sub, Complex.ofReal_one]
  linear_combination (ρ * ((Real.cos s : ℂ) + σ * Real.sin s * I - 1) * (-(σ : ℂ) * I)) * hE
    + (-(ρ * Real.sin s * I ^ 2 : ℂ)) * hσ2 + (-(ρ * Real.sin s : ℂ)) * Complex.I_sq

theorem circ_mem_Rgn {c : ℂ} {ρ θ δ σ : ℝ} (hρ : 0 < ρ) (hσ : σ = 1 ∨ σ = -1)
    (hδ : e δ = e (θ + σ * (π / 2))) {N m : ℝ} (hN : 0 < N) (hm : 0 < m) :
    ∃ t₁ > 0, ∀ s : ℝ, 0 < s → s ≤ t₁ → c + ρ * e (θ + σ * s) ∈ Rgn (c + ρ * e θ) (e δ) N m := by
  refine ⟨min 1 (min (1 / (2 * N * ρ)) m), by positivity, fun s hs0 hs => ?_⟩
  have hs1 : s ≤ 1 := hs.trans (min_le_left _ _)
  have hs2 : s ≤ 1 / (2 * N * ρ) := hs.trans ((min_le_right _ _).trans (min_le_left _ _))
  have hs3 : s ≤ m := hs.trans ((min_le_right _ _).trans (min_le_right _ _))
  have hsin : 3 * s / 4 ≤ Real.sin s := by
    have := Real.sin_gt_sub_cube hs0
    nlinarith [pow_pos hs0 3, pow_le_one₀ hs0.le hs1 (n := 2), mul_pos hs0 hs0]
  have hcos : 1 - Real.cos s ≤ s ^ 2 / 2 := by
    have := Real.one_sub_sq_div_two_le_cos (x := s); linarith
  have hcos0 : 0 ≤ 1 - Real.cos s := by linarith [Real.cos_le_one s]
  have hNs : N * ρ * s ≤ 1 / 2 := by
    rw [le_div_iff₀ (by positivity)] at hs2; nlinarith
  have hζ := rotD_circ (c := c) (ρ := ρ) (θ := θ) (δ := δ) (σ := σ) (s := s) hσ hδ
  have hre : (rotD (c + ρ * e θ) (e δ) (c + ρ * e (θ + σ * s))).re = ρ * Real.sin s := by rw [hζ]; simp only [Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.I_re, Complex.I_im, Complex.ofReal_im]; ring
  have him : (rotD (c + ρ * e θ) (e δ) (c + ρ * e (θ + σ * s))).im = σ * ρ * (1 - Real.cos s) := by rw [hζ]; simp only [Complex.add_im, Complex.ofReal_im, Complex.mul_im, Complex.I_re, Complex.I_im, Complex.ofReal_re]; ring
  have hns : Complex.normSq (rotD (c + ρ * e θ) (e δ) (c + ρ * e (θ + σ * s))) = 2 * ρ ^ 2 * (1 - Real.cos s) := by
    rw [Complex.normSq_apply, hre, him]
    have hσ2 : σ ^ 2 = 1 := by rcases hσ with rfl | rfl <;> norm_num
    have := Real.sin_sq_add_cos_sq s
    linear_combination ρ ^ 2 * this + (ρ ^ 2 * (1 - Real.cos s) ^ 2) * hσ2
  have hsinpos : 0 < ρ * Real.sin s := by
    have : 0 < Real.sin s := by linarith
    positivity
  refine ⟨?_, ?_, ?_⟩
  · intro h
    have : rotD (c + ρ * e θ) (e δ) (c + ρ * e (θ + σ * s)) = 0 := by
      unfold rotD; rw [h]; simp
    rw [this, Complex.zero_re] at hre; linarith
  · rw [hns, hre]
    nlinarith [mul_pos hρ hs0, mul_nonneg hρ.le hcos0]
  · rw [him, hre, abs_mul, abs_mul, abs_of_pos hρ, abs_of_nonneg hcos0]
    have : |σ| = 1 := by rcases hσ with rfl | rfl <;> simp
    rw [this, one_mul]
    nlinarith [mul_pos hρ hs0, mul_pos hm hρ]

theorem sin_half_ge {s : ℝ} (h0 : 0 < s) (h1 : s < π) : s / π ≤ Real.sin (s / 2) := by
  have := Real.mul_le_sin (x := s / 2) (by linarith) (by linarith [Real.pi_pos])
  have hπ := Real.pi_pos
  calc s / π = 2 / π * (s / 2) := by field_simp
    _ ≤ _ := this

/-- A circular arc that ends at `y` (in the sense `σ`) and does not close up has no points near `y` on the `σ` side:
`happ` would put a point of the arc, on that side, within `g` of the end. -/
theorem circ_gap_aux {c : ℂ} {ρ θ₀ θ₁ θ δ σ m : ℝ} (hρ : 0 < ρ) (hlt : θ₁ - θ₀ < 2 * π)
    (hσ : σ = 1 ∨ σ = -1)
    (hδ : e δ = e (θ + σ * (π / 2)))
    (happ : ∀ N > 0, ((Arc.circ c ρ θ₀ θ₁).carrier ∩ Rgn (c + ρ * e θ) (e δ) N m).Nonempty) :
    ∃ s : ℝ, 0 < s ∧ s < 2 * π - (θ₁ - θ₀) ∧ ∃ θN ∈ Icc θ₀ θ₁, ∃ n : ℤ, θN = θ + σ * s + n * (2 * π) := by
  have hπ := Real.pi_pos
  set g : ℝ := 2 * π - (θ₁ - θ₀) with hg
  have hg0 : 0 < g := by linarith
  set N : ℝ := π / (2 * ρ * g) + 1 with hN
  have hN0 : 0 < N := by positivity
  obtain ⟨w, ⟨θN, hθN, rfl⟩, hwR⟩ := happ N hN0
  -- the angle of `w` about `y`
  set ξ : ℂ := e θN * (starRingEnd ℂ) (e θ) with hξ
  have hξn : ‖ξ‖ = 1 := by simp [hξ]
  set τ : ℝ := Complex.arg ξ with hτ
  have hτe : e τ = ξ := by
    have := Complex.norm_mul_exp_arg_mul_I ξ
    rw [hξn, Complex.ofReal_one, one_mul] at this
    exact this
  have hθNe : e θN = e (θ + τ) := by
    rw [e_add, hτe, hξ]; linear_combination (-(e θN)) * e_mul_conj_e θ
  have hσ2 : σ * σ = 1 := by rcases hσ with rfl | rfl <;> norm_num
  set s : ℝ := σ * τ with hs
  have hτs : τ = σ * s := by rw [hs, ← mul_assoc, hσ2, one_mul]
  have hw : c + ρ * e θN = c + ρ * e (θ + σ * s) := by rw [hθNe, hτs]
  have hwR : c + ρ * e θN ∈ Rgn (c + ρ * e θ) (e δ) N m := hwR
  rw [hw] at hwR
  have hζ := rotD_circ (c := c) (ρ := ρ) (θ := θ) (δ := δ) (σ := σ) (s := s) hσ hδ
  obtain ⟨-, h1, -⟩ := hwR
  rw [hζ] at h1
  have hre : (((ρ * Real.sin s : ℝ) : ℂ) + ((σ * ρ * (1 - Real.cos s) : ℝ) : ℂ) * I).re = ρ * Real.sin s := by
    simp only [Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.I_re, Complex.I_im, Complex.ofReal_im]; ring
  have him : (((ρ * Real.sin s : ℝ) : ℂ) + ((σ * ρ * (1 - Real.cos s) : ℝ) : ℂ) * I).im = σ * ρ * (1 - Real.cos s) := by
    simp only [Complex.add_im, Complex.ofReal_im, Complex.mul_im, Complex.I_re, Complex.I_im, Complex.ofReal_re]; ring
  have hns : Complex.normSq (((ρ * Real.sin s : ℝ) : ℂ) + ((σ * ρ * (1 - Real.cos s) : ℝ) : ℂ) * I) =
      2 * ρ ^ 2 * (1 - Real.cos s) := by
    rw [Complex.normSq_apply, hre, him]
    have := Real.sin_sq_add_cos_sq s
    linear_combination ρ ^ 2 * this + (ρ ^ 2 * (1 - Real.cos s) ^ 2) * (by rcases hσ with rfl | rfl <;> norm_num : σ ^ 2 = 1)
  rw [hns, hre] at h1
  have hsin : 0 < Real.sin s := by
    by_contra hcon
    push Not at hcon
    have : ρ * Real.sin s ≤ 0 := mul_nonpos_of_nonneg_of_nonpos hρ.le hcon
    nlinarith [Real.cos_le_one s, Real.neg_one_le_cos s, mul_pos hρ hρ, mul_pos hN0 (mul_pos hρ hρ)]
  -- s ∈ (0, π)
  have hτb : -π < τ ∧ τ ≤ π := ⟨Complex.neg_pi_lt_arg ξ, Complex.arg_le_pi ξ⟩
  have hs0 : 0 < s ∧ s < π := by
    rcases hσ with rfl | rfl
    · have hs' : s = τ := by rw [hs]; ring
      have : s ≠ π := by
        intro h; rw [h, Real.sin_pi] at hsin; exact lt_irrefl _ hsin
      constructor
      · by_contra hc; push Not at hc
        have : Real.sin s ≤ 0 := Real.sin_nonpos_of_nonpos_of_neg_pi_le hc (by linarith [hτb.1])
        linarith
      · exact lt_of_le_of_ne (by linarith [hτb.2]) this
    · have hs' : s = -τ := by rw [hs]; ring
      have : s ≠ π := by
        intro h; rw [h, Real.sin_pi] at hsin; exact lt_irrefl _ hsin
      constructor
      · by_contra hc; push Not at hc
        have : Real.sin s ≤ 0 := Real.sin_nonpos_of_nonpos_of_neg_pi_le hc (by linarith [hτb.2])
        linarith
      · exact lt_of_le_of_ne (by linarith [hτb.1]) this
  obtain ⟨hs0, hsπ⟩ := hs0
  -- the size of `s`
  have hsh : 0 < Real.sin (s / 2) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
  have hch : 0 ≤ Real.cos (s / 2) := Real.cos_nonneg_of_mem_Icc ⟨by linarith, by linarith⟩
  have hc1 : Real.cos s = 1 - 2 * Real.sin (s / 2) ^ 2 := by
    have := Real.cos_two_mul (s / 2)
    rw [show 2 * (s / 2) = s by ring] at this
    nlinarith [Real.sin_sq_add_cos_sq (s / 2)]
  have hs1 : Real.sin s = 2 * Real.sin (s / 2) * Real.cos (s / 2) := by
    have := Real.sin_two_mul (s / 2)
    rwa [show 2 * (s / 2) = s by ring] at this
  have hcle : Real.cos (s / 2) ≤ 1 := Real.cos_le_one _
  have h2 : 2 * N * ρ * Real.sin (s / 2) < 1 := by
    rw [hc1, hs1] at h1
    have hpos : 0 < ρ * Real.sin (s / 2) := mul_pos hρ hsh
    by_contra hcon
    push Not at hcon
    nlinarith [mul_le_mul_of_nonneg_left hcon hpos.le, mul_nonneg hpos.le (sub_nonneg.2 hcle), mul_pos hρ hρ]
  have hjor := sin_half_ge hs0 hsπ
  have hsg : s < g := by
    have h3 : 2 * N * ρ * (s / π) < 1 := lt_of_le_of_lt (by gcongr) h2
    have h4 : 2 * N * ρ * s < π := by
      rw [mul_div_assoc', div_lt_one hπ] at h3; exact h3
    have h5 : π / (2 * ρ * g) < N := by rw [hN]; linarith
    rw [div_lt_iff₀ (by positivity)] at h5
    by_contra hcon; push Not at hcon
    nlinarith [mul_le_mul_of_nonneg_left hcon (by positivity : (0:ℝ) ≤ 2 * N * ρ)]
  obtain ⟨n, hn⟩ := e_eq_e_iff.mp hθNe
  exact ⟨s, hs0, hsg, θN, hθN, n, by rw [hn, hτs]⟩

theorem circ_gap_false {c : ℂ} {ρ θ₀ θ₁ θ δ σ m : ℝ} (hρ : 0 < ρ) (hlt : θ₁ - θ₀ < 2 * π)
    (hσ : σ = 1 ∨ σ = -1) (hend : (σ = 1 ∧ θ = θ₁) ∨ (σ = -1 ∧ θ = θ₀))
    (hδ : e δ = e (θ + σ * (π / 2)))
    (happ : ∀ N > 0, ((Arc.circ c ρ θ₀ θ₁).carrier ∩ Rgn (c + ρ * e θ) (e δ) N m).Nonempty) : False := by
  have hπ := Real.pi_pos
  obtain ⟨s, hs0, hsg, θN, ⟨hθN1, hθN2⟩, n, hn⟩ := circ_gap_aux hρ hlt hσ hδ happ
  rcases hend with ⟨rfl, hθ⟩ | ⟨rfl, hθ⟩
  · have hn' : θN = θ₁ + s + n * (2 * π) := by rw [hn, hθ]; ring
    have hn0 : (n : ℝ) < 0 := by
      by_contra hc; push Not at hc; nlinarith [mul_nonneg hc (by positivity : (0:ℝ) ≤ 2 * π)]
    have hn1 : n ≤ -1 := by
      have : n < 0 := by exact_mod_cast hn0
      omega
    have : (n : ℝ) ≤ -1 := by exact_mod_cast hn1
    have h6 := mul_le_mul_of_nonneg_right this (by positivity : (0:ℝ) ≤ 2 * π)
    linarith
  · have hn' : θN = θ₀ - s + n * (2 * π) := by rw [hn, hθ]; ring
    have hn0 : (0 : ℝ) < n := by
      by_contra hc; push Not at hc; nlinarith [mul_nonneg (neg_nonneg.2 hc) (by positivity : (0:ℝ) ≤ 2 * π)]
    have hn1 : 1 ≤ n := by
      have : 0 < n := by exact_mod_cast hn0
      omega
    have : (1 : ℝ) ≤ n := by exact_mod_cast hn1
    have h6 := mul_le_mul_of_nonneg_right this (by positivity : (0:ℝ) ≤ 2 * π)
    linarith

theorem circ_initialPiece {c : ℂ} {ρ θ₀ θ₁ θ δ σ m N' : ℝ} (hρ : 0 < ρ) (h01' : θ₁ ≤ θ₀ + 2 * π)
    (hθ : θ ∈ Icc θ₀ θ₁) (hm : 0 < m) (hN' : 0 < N') (hσ : σ = 1 ∨ σ = -1) (hδ : e δ = e (θ + σ * (π / 2)))
    (happ : ∀ N > 0, ((Arc.circ c ρ θ₀ θ₁).carrier ∩ Rgn (c + ρ * e θ) (e δ) N m).Nonempty) :
    ∃ B, (Arc.circ c ρ θ₀ θ₁).InitialPiece (c + ρ * e θ) δ B ∧
      ∀ w ∈ B, w = c + ρ * e θ ∨ w ∈ Rgn (c + ρ * e θ) (e δ) N' m := by
  have hπ := Real.pi_pos
  obtain ⟨t₁, ht₁, hRg⟩ := circ_mem_Rgn (c := c) (ρ := ρ) (θ := θ) (δ := δ) (σ := σ) hρ hσ hδ hN' hm
  -- the start of the piece
  have key : ∃ φ ε₀ : ℝ, 0 < ε₀ ∧ e φ = e θ ∧ (fun t : ℝ => φ + σ * t) '' Icc 0 ε₀ ⊆ Icc θ₀ θ₁ := by
    by_cases hfull : θ₁ - θ₀ = 2 * π
    · rcases hσ with rfl | rfl
      · by_cases hlt : θ < θ₁
        · refine ⟨θ, θ₁ - θ, by linarith, rfl, ?_⟩
          rintro _ ⟨t, ⟨ht0, ht1⟩, rfl⟩
          exact ⟨by linarith [hθ.1], by linarith⟩
        · have hθ1 : θ = θ₁ := le_antisymm hθ.2 (not_lt.mp hlt)
          refine ⟨θ₀, 2 * π, by linarith, ?_, ?_⟩
          · rw [hθ1, show θ₁ = θ₀ + 2 * π by linarith, e_add_two_pi]
          · rintro _ ⟨t, ⟨ht0, ht1⟩, rfl⟩
            exact ⟨by linarith, by linarith⟩
      · by_cases hlt : θ₀ < θ
        · refine ⟨θ, θ - θ₀, by linarith, rfl, ?_⟩
          rintro _ ⟨t, ⟨ht0, ht1⟩, rfl⟩
          exact ⟨by linarith, by linarith [hθ.2]⟩
        · have hθ1 : θ = θ₀ := le_antisymm (not_lt.mp hlt) hθ.1
          refine ⟨θ₁, 2 * π, by linarith, ?_, ?_⟩
          · rw [hθ1, show θ₁ = θ₀ + 2 * π by linarith, e_add_two_pi]
          · rintro _ ⟨t, ⟨ht0, ht1⟩, rfl⟩
            exact ⟨by linarith, by linarith⟩
    · have hlt : θ₁ - θ₀ < 2 * π := lt_of_le_of_ne (by linarith) hfull
      rcases hσ with rfl | rfl
      · by_cases hl : θ < θ₁
        · refine ⟨θ, θ₁ - θ, by linarith, rfl, ?_⟩
          rintro _ ⟨t, ⟨ht0, ht1⟩, rfl⟩
          exact ⟨by linarith [hθ.1], by linarith⟩
        · exact (circ_gap_false hρ hlt (Or.inl rfl) (Or.inl ⟨rfl, le_antisymm hθ.2 (not_lt.mp hl)⟩) hδ happ).elim
      · by_cases hl : θ₀ < θ
        · refine ⟨θ, θ - θ₀, by linarith, rfl, ?_⟩
          rintro _ ⟨t, ⟨ht0, ht1⟩, rfl⟩
          exact ⟨by linarith, by linarith [hθ.2]⟩
        · exact (circ_gap_false hρ hlt (Or.inr rfl) (Or.inr ⟨rfl, le_antisymm (not_lt.mp hl) hθ.1⟩) hδ happ).elim
  obtain ⟨φ, ε₀, hε₀, hφ, hsub⟩ := key
  set ε : ℝ := min ε₀ t₁ with hε
  have hε0 : 0 < ε := lt_min hε₀ ht₁
  have hy : c + ρ * e θ = c + ρ * e φ := by rw [hφ]
  refine ⟨(fun t : ℝ => c + ρ * e (φ + σ * t)) '' Icc 0 ε, ⟨hρ, φ, ε, σ, hσ, hε0, hy, ?_, rfl, ?_⟩, ?_⟩
  · rw [hδ, e_add, e_add, hφ]
  · exact (image_mono (Icc_subset_Icc_right (min_le_left _ _))).trans hsub
  · rintro _ ⟨t, ⟨ht0, ht1⟩, rfl⟩
    rcases eq_or_lt_of_le ht0 with h0 | h0
    · left; rw [← h0]; simp [hφ]
    · right
      have : c + ρ * e (φ + σ * t) = c + ρ * e (θ + σ * t) := by rw [e_add, e_add, hφ]
      show c + ρ * e (φ + σ * t) ∈ _
      rw [this]
      exact hRg t h0 (ht1.trans (min_le_right _ _))

theorem seg_initialPiece {p q y : ℂ} (hy : y ∈ segment ℝ p q) {δ m N' : ℝ} (hm : 0 < m) (hN' : 0 < N')
    (hT : ((I * (q - p)) * (starRingEnd ℂ) (e δ)).re = 0)
    (happ : ∀ N > 0, ((Arc.seg p q).carrier ∩ Rgn y (e δ) N m).Nonempty) :
    ∃ B, (Arc.seg p q).InitialPiece y δ B ∧ ∀ w ∈ B, w = y ∨ w ∈ Rgn y (e δ) N' m := by
  have hu : ‖e δ‖ = 1 := norm_e δ
  obtain ⟨w, hwS, hw1, hw2, hw3⟩ := happ N' hN'
  have hwS' : w ∈ segment ℝ p q := hwS
  rw [segment_eq_image'] at hy hwS'
  obtain ⟨t, ht, rfl⟩ := hy
  obtain ⟨t', ht', rfl⟩ := hwS'
  set d := q - p with hd
  set ζ := rotD (p + t • d) (e δ) (p + t' • d) with hζ
  have him0 : ζ.im = 0 := by
    have h1 : ζ = ((t' - t : ℝ) : ℂ) * (d * (starRingEnd ℂ) (e δ)) := by
      rw [hζ]; unfold rotD; simp only [Complex.real_smul]; push_cast; ring
    have h2 : (d * (starRingEnd ℂ) (e δ)).im = 0 := by
      have : ((I * d) * (starRingEnd ℂ) (e δ)).re = -(d * (starRingEnd ℂ) (e δ)).im := by
        rw [mul_assoc]; simp
      linarith
    rw [h1]; simp [h2]
  have hre : 0 < ζ.re := by
    have := Complex.normSq_nonneg ζ
    nlinarith
  set r := ζ.re with hr
  have hζr : ζ = (r : ℂ) := Complex.ext (by simp [hr]) (by simpa using him0)
  have hww : p + t' • d = (p + t • d) + (r : ℂ) * e δ := by
    have := rotD_eq (p + t • d) (e δ) (p + t' • d) hu
    rw [← hζ, hζr] at this
    linear_combination this
  have hN'r : N' * r < 1 := by
    have : N' * Complex.normSq ζ = N' * r ^ 2 := by rw [hζr, Complex.normSq_ofReal]; ring
    nlinarith
  refine ⟨segment ℝ (p + t • d) (p + t • d + (r : ℂ) * e δ), ⟨r, hre, rfl, ?_⟩, ?_⟩
  · rw [← hww]
    exact (convex_segment p q).segment_subset (by rw [segment_eq_image']; exact ⟨t, ht, rfl⟩) hwS
  · intro w' hw'
    rw [segment_eq_image'] at hw'
    obtain ⟨s, ⟨hs0, hs1⟩, rfl⟩ := hw'
    rcases eq_or_lt_of_le hs0 with h0 | h0
    · left; rw [← h0]; simp
    · right
      have hrot : rotD (p + t • d) (e δ) ((p + t • d) + s • (p + t • d + (r : ℂ) * e δ - (p + t • d))) = ((s * r : ℝ) : ℂ) := by
        unfold rotD
        have := conj_mul_self_e δ
        simp only [Complex.real_smul]
        push_cast
        linear_combination ((s : ℂ) * r) * this
      have hsr : 0 < s * r := mul_pos h0 hre
      refine ⟨?_, ?_, ?_⟩
      · intro h
        have h' : p + t • d + s • (p + t • d + (r : ℂ) * e δ - (p + t • d)) = p + t • d := h
        have h2 : rotD (p + t • d) (e δ) (p + t • d + s • (p + t • d + (r : ℂ) * e δ - (p + t • d))) = 0 := by
          unfold rotD; rw [h']; simp
        rw [hrot] at h2
        have h3 := congrArg Complex.re h2
        rw [Complex.ofReal_re, Complex.zero_re] at h3
        linarith
      · rw [hrot, Complex.normSq_ofReal]
        simp only [Complex.ofReal_re]
        have h3 : N' * (s * r) < 1 := by nlinarith [mul_le_mul_of_nonneg_left hs1 (mul_pos hN' hre).le]
        nlinarith [mul_lt_mul_of_pos_left h3 hsr]
      · rw [hrot]
        simp only [Complex.ofReal_im, abs_zero, Complex.ofReal_re]
        positivity

/-- **An arc that approaches `y` along a tangent direction has an initial piece there**, inside any given wedge. -/
theorem Arc.exists_initialPiece_of_approach {a : Arc} (ha : a.Nondegenerate) {y : ℂ} (hy : y ∈ a.carrier)
    {δ m N' : ℝ} (hm : 0 < m) (hN' : 0 < N') (hT : a.Tang y (e δ))
    (happ : ∀ N > 0, (a.carrier ∩ Rgn y (e δ) N m).Nonempty) :
    ∃ B, a.InitialPiece y δ B ∧ ∀ w ∈ B, w = y ∨ w ∈ Rgn y (e δ) N' m := by
  cases a with
  | seg p q => exact seg_initialPiece hy hm hN' hT happ
  | circ c ρ θ₀ θ₁ =>
    obtain ⟨hρ, h01, h01'⟩ := ha
    obtain ⟨θ, hθ, rfl⟩ := hy
    obtain ⟨σ, hσ, hδ⟩ := tang_circ (c := c) (y := c + ρ * e θ) hρ rfl hT
    exact circ_initialPiece hρ h01' hθ hm hN' hσ hδ happ

theorem mem_Rgn_lev_of_Kinv {y u : ℂ} (hu : ‖u‖ = 1) {N m : ℝ} {ν : ℂ} (hν : ν ∈ Kinv N m) (σ : ℝ) :
    y + invC ν * u ∈ Rgn y u N m ∧ levD y u σ (y + invC ν * u) = σ * ν.im := by
  have hν0 : ν ≠ 0 := by
    intro h; rw [h] at hν; simp [Kinv] at hν
  have hne : invC ν ≠ 0 := invC_ne_zero hν0
  have hrot : rotD y u (y + invC ν * u) = invC ν := by
    unfold rotD
    have : (starRingEnd ℂ) u * u = 1 := by
      rw [mul_comm, Complex.mul_conj, Complex.normSq_eq_norm_sq, hu]; simp
    calc (y + invC ν * u - y) * (starRingEnd ℂ) u = invC ν * (u * (starRingEnd ℂ) u) := by ring
      _ = invC ν := by rw [mul_comm u, this, mul_one]
  have hwy : y + invC ν * u ≠ y := by
    intro h
    have hu0 : u ≠ 0 := by intro h0; simp [h0] at hu
    have : invC ν * u = 0 := by linear_combination h
    rcases mul_eq_zero.mp this with h1 | h1
    · exact hne h1
    · exact hu0 h1
  refine ⟨(mem_Rgn_iff hu N m).mpr ⟨hwy, ?_⟩, ?_⟩
  · rw [hrot, invC_invC]; exact hν
  · rw [levD_eq, hrot, invC_invC]

theorem Rgn_mono {y u : ℂ} {N N' m : ℝ} (h : N ≤ N') : Rgn y u N' m ⊆ Rgn y u N m := by
  rintro w ⟨h1, h2, h3⟩
  exact ⟨h1, lt_of_le_of_lt (mul_le_mul_of_nonneg_right h (Complex.normSq_nonneg _)) h2, h3⟩

theorem isOpen_Rgn (y u : ℂ) (N m : ℝ) : IsOpen (Rgn y u N m) := by
  have hc : Continuous fun w : ℂ => rotD y u w := by unfold rotD; fun_prop
  have h1 : IsOpen {w : ℂ | w ≠ y} := isOpen_ne
  have h2 : IsOpen {w : ℂ | N * Complex.normSq (rotD y u w) < (rotD y u w).re} :=
    isOpen_lt (by fun_prop) (Complex.continuous_re.comp hc)
  have h3 : IsOpen {w : ℂ | |(rotD y u w).im| < m * (rotD y u w).re} :=
    isOpen_lt (continuous_abs.comp (Complex.continuous_im.comp hc)) (by fun_prop)
  exact h1.inter (h2.inter h3)

theorem Arc.InitialPiece.subset_carrier {a : Arc} {y : ℂ} {δ : ℝ} {B : Set ℂ} (h : a.InitialPiece y δ B) :
    B ⊆ a.carrier := by
  cases a with
  | seg p q => obtain ⟨ε, -, -, hB⟩ := h; exact hB
  | circ c ρ θ₀ θ₁ =>
    obtain ⟨-, φ, ε, σ, -, -, -, -, rfl, hsub⟩ := h
    rintro _ ⟨t, ht, rfl⟩
    exact ⟨φ + σ * t, hsub ⟨t, ht, rfl⟩, rfl⟩

theorem conj_ne_zero_of_norm {u : ℂ} (hu : ‖u‖ = 1) : (starRingEnd ℂ) u ≠ 0 := by
  intro h; rw [map_eq_zero] at h; simp [h] at hu

theorem u_conj_u {u : ℂ} (hu : ‖u‖ = 1) : u * (starRingEnd ℂ) u = 1 := by
  rw [Complex.mul_conj, Complex.normSq_eq_norm_sq, hu]; simp

theorem levD_eq_of_mem_curve {y u : ℂ} (hu : ‖u‖ = 1) {κ : ℝ} {b : ℂ} (hb : b ≠ 0)
    (hT : (b * (starRingEnd ℂ) u).re = 0) {w : ℂ} (hw : w ≠ y) (hc : w ∈ curveAt y κ b) (σ : ℝ) :
    levD y u σ w = σ * κ / (2 * (b * (starRingEnd ℂ) u).im) := by
  rw [mem_curveAt_iff_rot hu, hT] at hc
  have him : (b * (starRingEnd ℂ) u).im ≠ 0 := by
    intro h
    have : b * (starRingEnd ℂ) u = 0 := Complex.ext hT h
    rcases mul_eq_zero.mp this with h1 | h1
    · exact hb h1
    · exact conj_ne_zero_of_norm hu h1
  have hpos : 0 < Complex.normSq (rotD y u w) := Complex.normSq_pos.mpr ((rotD_ne_zero_iff y u w hu).mpr hw)
  unfold levD
  rw [div_eq_div_iff hpos.ne' (by positivity)]
  have : κ * Complex.normSq (rotD y u w) = 2 * ((rotD y u w).im * (b * (starRingEnd ℂ) u).im) := by
    linarith
  linear_combination σ * (-this)

/-- The curve through `y` on which the level function takes the value `q`. -/
def levCurve (y u : ℂ) (σ q : ℝ) : Set ℂ :=
  if q = 0 then curveAt y 0 (I * u) else curveAt y 1 ((I * σ / (2 * q) : ℂ) * u)

theorem mem_levCurve {y u : ℂ} (hu : ‖u‖ = 1) {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) {w : ℂ} (hw : w ≠ y) {q : ℝ}
    (h : levD y u σ w = q) : w ∈ levCurve y u σ q := by
  have hpos : 0 < Complex.normSq (rotD y u w) := Complex.normSq_pos.mpr ((rotD_ne_zero_iff y u w hu).mpr hw)
  have hσ0 : σ ≠ 0 := by rcases hσ with rfl | rfl <;> norm_num
  have huu := u_conj_u hu
  unfold levD at h
  unfold levCurve
  split_ifs with hq
  · rw [mem_curveAt_iff_rot hu]
    have hb : I * u * (starRingEnd ℂ) u = I := by linear_combination I * huu
    rw [hb]
    have : σ * (rotD y u w).im = 0 := by
      rw [hq] at h; rw [div_eq_zero_iff] at h; rcases h with h | h
      · exact h
      · exact absurd h hpos.ne'
    have : (rotD y u w).im = 0 := by
      rcases mul_eq_zero.mp this with h | h
      · exact absurd h hσ0
      · exact h
    simp [this]
  · rw [mem_curveAt_iff_rot hu]
    have hb : (I * σ / (2 * q) : ℂ) * u * (starRingEnd ℂ) u = I * σ / (2 * q) := by
      linear_combination (I * σ / (2 * q) : ℂ) * huu
    rw [hb]
    have hre : (I * (σ : ℂ) / (2 * (q : ℂ))).re = 0 := by
      have : (I * (σ : ℂ) / (2 * (q : ℂ))) = (((σ / (2 * q) : ℝ)) : ℂ) * I := by push_cast; ring
      rw [this]; simp only [Complex.mul_re, Complex.ofReal_re, Complex.I_re, Complex.ofReal_im, Complex.I_im]; ring
    have him : (I * (σ : ℂ) / (2 * (q : ℂ))).im = σ / (2 * q) := by
      have : (I * (σ : ℂ) / (2 * (q : ℂ))) = (((σ / (2 * q) : ℝ)) : ℂ) * I := by push_cast; ring
      rw [this]; simp only [Complex.mul_im, Complex.ofReal_re, Complex.I_re, Complex.ofReal_im, Complex.I_im]; ring
    rw [hre, him]
    rw [div_eq_iff hpos.ne'] at h
    field_simp
    nlinarith [h]

theorem isClosed_curveAt (x : ℂ) (κ : ℝ) (b : ℂ) : IsClosed (curveAt x κ b) := by
  unfold curveAt
  exact isClosed_eq (by fun_prop) (by fun_prop)

theorem exists_pt_off_levels {y u : ℂ} (hu : ‖u‖ = 1) {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) (Λ : Finset ℝ) :
    ∀ {U : Set ℂ}, IsOpen U → U.Nonempty → ∃ z ∈ U, ∀ q ∈ Λ, z ∉ levCurve y u σ q := by
  classical
  induction Λ using Finset.induction_on with
  | empty => intro U _ hne; obtain ⟨z, hz⟩ := hne; exact ⟨z, hz, by simp⟩
  | insert q Λ hq ih =>
    intro U hU hne
    have hu0 : u ≠ 0 := by intro h0; simp [h0] at hu
    have hσ0 : (σ : ℂ) ≠ 0 := by rcases hσ with rfl | rfl <;> norm_num
    have hex : ∃ w ∈ U, w ∉ levCurve y u σ q := by
      unfold levCurve
      split_ifs with hq0
      · exact exists_notMem_curveAt (Or.inl rfl) (mul_ne_zero Complex.I_ne_zero hu0) hU hne
      · refine exists_notMem_curveAt (Or.inr rfl) (mul_ne_zero ?_ hu0) hU hne
        have : (q : ℂ) ≠ 0 := by exact_mod_cast hq0
        exact div_ne_zero (mul_ne_zero Complex.I_ne_zero hσ0) (mul_ne_zero two_ne_zero this)
    obtain ⟨w, hwU, hwq⟩ := hex
    have hcl : IsClosed (levCurve y u σ q) := by
      unfold levCurve; split_ifs <;> exact isClosed_curveAt _ _ _
    obtain ⟨z, hzU, hz⟩ := ih (hU.sdiff hcl) ⟨w, hwU, hwq⟩
    refine ⟨z, hzU.1, ?_⟩
    intro q' hq'
    rcases Finset.mem_insert.mp hq' with rfl | hq'
    · exact hzU.2
    · exact hz q' hq'

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **The edge of a tile's cone is an initial piece of an arc.** At `y` in the domain, if `t` approaches `y` along `δ` but along
no direction `δ + σ u` (`σ = ±1`, `0 < u < u₁`), then some arc of the map has an initial piece leaving `y` in the direction
`δ` that lies in `cl t`. -/
theorem exists_initialPiece_of_cone {y : ℂ} (hy : y ∈ F.dom) {t : Set ℂ} (ht : F.IsTile t) {δ σ : ℝ}
    (hσ : σ = 1 ∨ σ = -1) (hδ : δ ∈ coneAt t y) {u₁ : ℝ} (hu₁ : 0 < u₁)
    (hex : ∀ u : ℝ, 0 < u → u < u₁ → δ + σ * u ∉ coneAt t y) :
    ∃ α ∈ F.arcs, ∃ B, α.InitialPiece y δ B ∧ B ⊆ closure t := by
  classical
  have hπ := Real.pi_pos
  obtain ⟨ρ₀, hG⟩ := F.exists_goodAt hy
  have hu : ‖e δ‖ = 1 := norm_e δ
  obtain ⟨m, hm0, N₀, hN₀, hN⟩ := hG.exists_wedge hu
  set 𝒜 : Set Arc := {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ρ₀).Nonempty} with h𝒜
  -- present arcs: those that approach `y` along `δ`
  let Pr : Arc → Prop := fun a => ∀ N > 0, (a.carrier ∩ Rgn y (e δ) N m).Nonempty
  have evN : ∀ᶠ N in atTop, ∀ a ∈ 𝒜, ¬ Pr a → ∀ N' ≥ N, (a.carrier ∩ Rgn y (e δ) N' m) = ∅ := by
    refine (eventually_all_finite hG.fin).mpr fun a _ => ?_
    by_cases hP : Pr a
    · exact Filter.Eventually.of_forall fun _ h => absurd hP h
    · simp only [Pr, not_forall, Set.not_nonempty_iff_eq_empty] at hP
      obtain ⟨N₂, hN₂, hemp⟩ := hP
      filter_upwards [eventually_ge_atTop N₂] with N hN2 _ N' hN'
      exact eq_empty_of_subset_empty (hemp ▸ inter_subset_inter_right _ (Rgn_mono (hN2.trans hN')))
  obtain ⟨N, hNge, hNev⟩ := ((eventually_ge_atTop (max N₀ 1)).and evN).exists
  have hN0 : 0 < N := lt_of_lt_of_le (lt_max_of_lt_right one_pos) hNge
  obtain ⟨hball, hwedge⟩ := hN N (le_trans (le_max_left _ _) hNge)
  set Lv : Arc → ℝ := fun a =>
    σ * (a.curveData y).1 / (2 * ((a.curveData y).2 * (starRingEnd ℂ) (e δ)).im) with hLv
  set Λ : Set ℝ := Lv '' {a | a ∈ 𝒜 ∧ Pr a} with hΛ
  have hΛfin : Λ.Finite := (hG.fin.subset (fun a (ha : a ∈ 𝒜 ∧ Pr a) => ha.1)).image _
  have claimA : ∀ w ∈ Rgn y (e δ) N m, ∀ a ∈ F.arcs, w ∈ a.carrier →
      a ∈ 𝒜 ∧ Pr a ∧ levD y (e δ) σ w = Lv a := by
    intro w hw a ha hwa
    have ha𝒜 : a ∈ 𝒜 := ⟨ha, w, hwa, hball hw⟩
    obtain ⟨hya, hT⟩ := hwedge w hw a ha hwa
    have hP : Pr a := by
      by_contra hP
      have := hNev a ha𝒜 hP N le_rfl
      exact (eq_empty_iff_forall_notMem.mp this) w ⟨hwa, hw⟩
    refine ⟨ha𝒜, hP, ?_⟩
    exact levD_eq_of_mem_curve hu (Arc.curveData_ne (F.nondegenerate a ha) hya) hT hw.1
      (Arc.carrier_subset_curve hya hwa) σ
  have claimΓ : ∀ w ∈ Rgn y (e δ) N m, w ∈ F.Γ → levD y (e δ) σ w ∈ Λ := by
    intro w hw hwΓ
    obtain ⟨a, ha, hwa⟩ := mem_iUnion₂.mp hwΓ.2
    obtain ⟨ha𝒜, hP, hl⟩ := claimA w hw a ha hwa
    exact ⟨a, ⟨ha𝒜, hP⟩, hl.symm⟩
  -- a point of `t` in the wedge, off every level of `Λ`
  have hUo : IsOpen (t ∩ Rgn y (e δ) N m) := ht.isOpen.inter (isOpen_Rgn _ _ _ _)
  obtain ⟨w₀, hw₀t, hw₀R⟩ := exists_mem_Rgn_of_mem_coneAt hδ hN0 hm0
  obtain ⟨z, ⟨hzt, hzR⟩, hz⟩ := exists_pt_off_levels hu hσ hΛfin.toFinset hUo ⟨w₀, hw₀t, hw₀R⟩
  have hzΛ : levD y (e δ) σ z ∉ Λ := by
    intro h
    exact hz _ (hΛfin.mem_toFinset.mpr h) (mem_levCurve hu hσ hzR.1 rfl)
  set L : ℝ := levD y (e δ) σ z with hL
  set I : Set ℝ := {q | ∀ l ∈ Λ, (l < L → l < q) ∧ (L < l → q < l)} with hI
  have hIoc : I.OrdConnected := by
    refine ⟨fun x hx y' hy' q hq l hl => ⟨fun h => ?_, fun h => ?_⟩⟩
    · exact lt_of_lt_of_le ((hx l hl).1 h) hq.1
    · exact lt_of_le_of_lt hq.2 ((hy' l hl).2 h)
  have hLI : L ∈ I := fun l _ => ⟨fun h => h, fun h => h⟩
  set Sg : Set ℂ := {w ∈ Rgn y (e δ) N m | levD y (e δ) σ w ∈ I} with hSg
  have hSgint : Sg ⊆ F.interiorPts := by
    intro w hw
    refine ⟨hG.subdom (hball hw.1), fun hwa => ?_⟩
    have hΓ : w ∈ F.Γ := ⟨hG.subdom (hball hw.1), hwa⟩
    have h1 := claimΓ w hw.1 hΓ
    have h2 := hw.2 _ h1
    have h3 : levD y (e δ) σ w = L := le_antisymm (not_lt.mp fun h => lt_irrefl _ (h2.2 h)) (not_lt.mp fun h => lt_irrefl _ (h2.1 h))
    rw [h3] at h1
    exact hzΛ h1
  have hpre : IsPreconnected Sg := isPreconnected_Rgn_lev hu hN0 σ hIoc
  have hSgt : Sg ⊆ t := ht.subset_of_preconnected hpre hSgint ⟨hzR, hLI⟩ hzt
  have hσ2 : σ * σ = 1 := by rcases hσ with rfl | rfl <;> norm_num
  by_cases hup : ∃ l ∈ Λ, L < l
  · -- the top boundary of the region is an arc leaving `y` along `δ`
    have hne : (hΛfin.toFinset.filter (fun l => L < l)).Nonempty := by
      obtain ⟨l, hl, hLl⟩ := hup
      exact ⟨l, Finset.mem_filter.mpr ⟨hΛfin.mem_toFinset.mpr hl, hLl⟩⟩
    set b := (hΛfin.toFinset.filter (fun l => L < l)).min' hne with hb
    have hbmem := Finset.mem_filter.mp (Finset.min'_mem _ hne)
    have hbΛ : b ∈ Λ := hΛfin.mem_toFinset.mp hbmem.1
    have hLb : L < b := hbmem.2
    have hbmin : ∀ l ∈ Λ, L < l → b ≤ l := fun l hl hLl =>
      Finset.min'_le _ _ (Finset.mem_filter.mpr ⟨hΛfin.mem_toFinset.mpr hl, hLl⟩)
    have hIoo : ∀ q ∈ Ioo L b, q ∈ I := fun q hq l hl =>
      ⟨fun h => lt_trans h hq.1, fun h => lt_of_lt_of_le hq.2 (hbmin l hl h)⟩
    obtain ⟨a, ⟨ha𝒜, hP⟩, hab⟩ := hbΛ
    have ha : a ∈ F.arcs := ha𝒜.1
    have hya : y ∈ a.carrier := hG.through a ha ha𝒜.2
    obtain ⟨w₁, hw₁a, hw₁R⟩ := hP N hN0
    have hT : a.Tang y (e δ) := (hwedge w₁ hw₁R a ha hw₁a).2
    obtain ⟨B, hBip, hBsub⟩ := Arc.exists_initialPiece_of_approach (F.nondegenerate a ha) hya hm0 hN0 hT hP
    refine ⟨a, ha, B, hBip, ?_⟩
    intro w hwB
    rcases hBsub w hwB with rfl | hwR
    · exact mem_closure_of_mem_coneAt hδ
    · have hwa : w ∈ a.carrier := hBip.subset_carrier hwB
      have hlev : levD y (e δ) σ w = b := by rw [(claimA w hwR a ha hwa).2.2]; exact hab
      have hν : invC (rotD y (e δ) w) ∈ Kinv N m := ((mem_Rgn_iff hu N m).mp hwR).2
      set ν := invC (rotD y (e δ) w) with hνdef
      have hνim : σ * ν.im = b := by rw [← hlev, levD_eq]
      have hKo : IsOpen (Kinv N m) := by
        have h1 : IsOpen {ν : ℂ | N < ν.re} := isOpen_lt continuous_const Complex.continuous_re
        have h2 : IsOpen {ν : ℂ | |ν.im| < m * ν.re} :=
          isOpen_lt (continuous_abs.comp Complex.continuous_im) (by fun_prop)
        exact h1.inter h2
      have hcont : Continuous fun h : ℝ => ν - ((σ * h : ℝ) : ℂ) * Complex.I := by fun_prop
      have hev1 : ∀ᶠ h in 𝓝 (0 : ℝ), ν - ((σ * h : ℝ) : ℂ) * Complex.I ∈ Kinv N m := by
        refine hcont.continuousAt.eventually (hKo.mem_nhds ?_)
        simpa using hν
      have hν0 : ν ≠ 0 := by
        intro h; rw [h] at hν; simp [Kinv] at hν
      have hgc : ContinuousAt (fun h : ℝ => y + invC (ν - ((σ * h : ℝ) : ℂ) * Complex.I) * e δ) 0 := by
        have hc2 : ContinuousAt invC (ν - ((σ * (0:ℝ) : ℝ) : ℂ) * Complex.I) := by
          simpa using continuousOn_invC.continuousAt (isOpen_ne.mem_nhds hν0)
        have h3 := (hc2.comp (f := fun h : ℝ => ν - ((σ * h : ℝ) : ℂ) * Complex.I) hcont.continuousAt).mul_const (e δ)
        exact continuousAt_const.add h3
      have hg0 : y + invC (ν - ((σ * (0:ℝ) : ℝ) : ℂ) * Complex.I) * e δ = w := by
        simp only [mul_zero, Complex.ofReal_zero, zero_mul, sub_zero, hνdef, invC_invC]
        have := rotD_eq y (e δ) w hu
        linear_combination (-1 : ℂ) * this
      have hlim : Tendsto (fun h : ℝ => y + invC (ν - ((σ * h : ℝ) : ℂ) * Complex.I) * e δ) (𝓝[>] 0) (𝓝 w) := by
        rw [← hg0]; exact hgc.tendsto.mono_left nhdsWithin_le_nhds
      refine mem_closure_of_tendsto hlim ?_
      filter_upwards [nhdsWithin_le_nhds hev1, Ioo_mem_nhdsGT (sub_pos.2 hLb)] with h hh1 hh2
      apply hSgt
      have hmem := mem_Rgn_lev_of_Kinv (y := y) hu hh1 σ
      refine ⟨hmem.1, ?_⟩
      rw [hmem.2]
      apply hIoo
      have : σ * (ν - ((σ * h : ℝ) : ℂ) * Complex.I).im = b - h := by
        simp only [Complex.sub_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, Complex.I_re, Complex.I_im]
        linear_combination hνim - h * hσ2
      rw [this]
      constructor <;> linarith [hh2.1, hh2.2]
  · -- no arc above: the region reaches the directions above `δ`, which `t` does not approach
    exfalso
    push Not at hup
    set u₀ : ℝ := min (u₁ / 2) (min (1 / 2) (m / 4)) with hu₀
    have hu₀0 : 0 < u₀ := by positivity
    have hu₀1 : u₀ < u₁ := lt_of_le_of_lt (min_le_left _ _) (by linarith)
    have hu₀2 : u₀ ≤ 1 / 2 := (min_le_right _ _).trans (min_le_left _ _)
    have hu₀3 : u₀ ≤ m / 4 := (min_le_right _ _).trans (min_le_right _ _)
    have hu₀π : u₀ < π / 2 := by linarith [Real.two_le_pi]
    have hsin : Real.sin u₀ < m * Real.cos u₀ := by
      have h1 : Real.sin u₀ ≤ u₀ := Real.sin_le hu₀0.le
      have h2 := Real.one_sub_sq_div_two_le_cos (x := u₀)
      have h3 : 1 / 2 ≤ Real.cos u₀ := by nlinarith
      nlinarith [mul_le_mul_of_nonneg_left h3 hm0.le]
    obtain ⟨s₀, hs₀, hray⟩ := ray_mem_Rgn (y := y) (δ := δ) hσ hN0 hu₀0 hu₀π hsin
    have hsinpos : 0 < Real.sin u₀ := Real.sin_pos_of_pos_of_lt_pi hu₀0 (by linarith [Real.two_le_pi])
    set s₁ : ℝ := min s₀ (Real.sin u₀ / (|L| + 1)) with hs₁
    have hs₁0 : 0 < s₁ := lt_min hs₀ (by positivity)
    have hrayt : ∀ s : ℝ, 0 < s → s < s₁ → y + (s : ℂ) * e (δ + σ * u₀) ∈ t := by
      intro s hs0 hs1
      obtain ⟨hR, hlev⟩ := hray s ⟨hs0, hs1.trans_le (min_le_left _ _)⟩
      apply hSgt
      refine ⟨hR, ?_⟩
      rw [hlev]
      have h1 : s < Real.sin u₀ / (|L| + 1) := hs1.trans_le (min_le_right _ _)
      rw [lt_div_iff₀ (by positivity)] at h1
      have h2 : |L| + 1 < Real.sin u₀ / s := by rw [lt_div_iff₀ hs0]; linarith
      intro l hl
      refine ⟨fun h => ?_, fun h => absurd (hup l hl) (not_le.mpr h)⟩
      have := le_abs_self L
      linarith
    apply hex u₀ hu₀0 hu₀1
    intro ε hε
    set s : ℝ := min (s₁ / 2) (ε / 2) with hs
    have hs0 : 0 < s := lt_min (by linarith) (by linarith)
    have hss : s < s₁ := lt_of_le_of_lt (min_le_left _ _) (by linarith)
    have hsε : s < ε := lt_of_le_of_lt (min_le_right _ _) (by linarith)
    have hd : ‖(s : ℂ) * e (δ + σ * u₀)‖ = s := by
      rw [norm_mul, Complex.norm_real, norm_e, mul_one, Real.norm_eq_abs, abs_of_pos hs0]
    refine ⟨y + (s : ℂ) * e (δ + σ * u₀), hrayt s hs0 hss, ?_, ?_, ?_⟩
    · intro h
      have : (s : ℂ) * e (δ + σ * u₀) = 0 := by linear_combination h
      rw [← norm_eq_zero, hd] at this
      exact hs0.ne' this
    · rw [dist_eq_norm, add_sub_cancel_left, hd]; exact hsε
    · rw [add_sub_cancel_left, hd]
      have : (s : ℂ) * e (δ + σ * u₀) / ((s : ℝ) : ℂ) = e (δ + σ * u₀) := by
        have : (s : ℂ) ≠ 0 := by exact_mod_cast hs0.ne'
        field_simp
      rw [this, sub_self, norm_zero]; exact hε


end ArcMap

section LocalSectors

/-! ## The sector structure at a point (`localSectors`) -/

/-- The point at distance `s` from `v` on the branch germ with tangent direction `β` and signed curvature `κ`. -/
noncomputable def branchPt (v : ℂ) (β κ s : ℝ) : ℂ := v + (s : ℂ) * e (β + Real.arcsin (κ * s / 2))

/-- The open sector between the germs `(β₁, κ₁)` and `(β₂, κ₂)`, out to radius `r`: the points `v + s e(φ)`, `0 < s < r`,
with `φ` strictly between the two germs' directions at distance `s`. -/
def sectorBetween (v : ℂ) (β₁ κ₁ β₂ κ₂ r : ℝ) : Set ℂ :=
  {z | ∃ s ∈ Ioo 0 r, ∃ φ ∈ Ioo (β₁ + Real.arcsin (κ₁ * s / 2)) (β₂ + Real.arcsin (κ₂ * s / 2)),
    z = v + (s : ℂ) * e φ}

/-- `n` branch germs, read counter-clockwise. -/
structure BranchGerms (n : ℕ) where
  /-- The tangent directions. -/
  β : Fin n → ℝ
  /-- The signed curvatures (`0` for a segment). -/
  κ : Fin n → ℝ

namespace BranchGerms

variable {n : ℕ} (G : BranchGerms n)

/-- The direction of the germ after `i` (the first one, one turn on, after the last). -/
noncomputable def nextβ (i : Fin n) : ℝ :=
  if h : i.val + 1 < n then G.β ⟨i.val + 1, h⟩ else G.β ⟨0, by omega⟩ + 2 * π

/-- The curvature of the germ after `i`. -/
noncomputable def nextκ (i : Fin n) : ℝ :=
  if h : i.val + 1 < n then G.κ ⟨i.val + 1, h⟩ else G.κ ⟨0, by omega⟩

/-- The `i`-th sector out to radius `r`: between germ `i` and the next. -/
def sector (v : ℂ) (r : ℝ) (i : Fin n) : Set ℂ := sectorBetween v (G.β i) (G.κ i) (G.nextβ i) (G.nextκ i) r

/-- The germs are sorted: strictly increasing in `(β, κ)` lexicographically, within one turn of the first. -/
def Sorted : Prop :=
  (∀ i j : Fin n, i < j → G.β i < G.β j ∨ (G.β i = G.β j ∧ G.κ i < G.κ j)) ∧
    ∀ i : Fin n, G.β i < G.nextβ i ∨ (G.β i = G.nextβ i ∧ G.κ i < G.nextκ i)

end BranchGerms

/-! ### Germ directions -/

/-- The direction from `v` of the point at distance `s` on the germ `(β, κ)`: `β + arcsin(κ s / 2)`. -/
noncomputable def germDir (β κ s : ℝ) : ℝ := β + Real.arcsin (κ * s / 2)

theorem branchPt_eq (v : ℂ) (β κ s : ℝ) : branchPt v β κ s = v + (s : ℂ) * e (germDir β κ s) := rfl

@[simp] theorem germDir_zero (β κ : ℝ) : germDir β κ 0 = β := by simp [germDir]

theorem germDir_add_two_pi (β κ s : ℝ) : germDir (β + 2 * π) κ s = germDir β κ s + 2 * π := by
  unfold germDir; ring

theorem continuous_germDir (β κ : ℝ) : Continuous (germDir β κ) :=
  continuous_const.add (Real.continuous_arcsin.comp (by fun_prop))

theorem continuous_branchPt (v : ℂ) (β κ : ℝ) : Continuous (branchPt v β κ) := by
  have h1 : Continuous fun s : ℝ => e (germDir β κ s) :=
    Complex.continuous_exp.comp ((Complex.continuous_ofReal.comp (continuous_germDir β κ)).mul continuous_const)
  exact continuous_const.add ((Complex.continuous_ofReal).mul h1)

theorem norm_mul_e {s : ℝ} (hs : 0 ≤ s) (φ : ℝ) : ‖(s : ℂ) * e φ‖ = s := by
  rw [norm_mul, Complex.norm_real, norm_e, mul_one, Real.norm_eq_abs, abs_of_nonneg hs]

theorem norm_branchPt_sub (v : ℂ) (β κ : ℝ) {s : ℝ} (hs : 0 ≤ s) : ‖branchPt v β κ s - v‖ = s := by
  rw [branchPt, add_sub_cancel_left, norm_mul_e hs]

/-- Two points `v + s e(φ)`, `v + s' e(φ')` at positive distances agree only at one distance and congruent angles. -/
theorem polar_eq_iff {v : ℂ} {s s' φ φ' : ℝ} (hs : 0 < s) (hs' : 0 < s') :
    v + (s : ℂ) * e φ = v + (s' : ℂ) * e φ' ↔ s = s' ∧ e φ = e φ' := by
  constructor
  · intro h
    have h1 : (s : ℂ) * e φ = s' * e φ' := add_left_cancel h
    have hss : s = s' := by
      have := congrArg norm h1
      rwa [norm_mul_e hs.le, norm_mul_e hs'.le] at this
    refine ⟨hss, ?_⟩
    subst hss
    have hs0 : (s : ℂ) ≠ 0 := by exact_mod_cast hs.ne'
    exact mul_left_cancel₀ hs0 h1
  · rintro ⟨rfl, h⟩; rw [h]

/-- A complex number is `‖z‖ e(arg z)`. -/
theorem eq_polar_arg (z : ℂ) : z = (‖z‖ : ℂ) * e (arg z) := by
  have := Complex.norm_mul_exp_arg_mul_I z
  simp [e, this]

/-- `e` reads an angle modulo `2π`: `e(x + 2πm) = e(x)`. -/
theorem e_add_int_mul (x : ℝ) (m : ℤ) : e (x + 2 * π * m) = e x := by
  rw [e_eq_e_iff]; exact ⟨m, by ring⟩

/-- **The local angle at a point**: near `z₀ = v + s₀ e(φ₀)`, `s₀ > 0`, every point is `v + ‖z − v‖ e(ψ z)` with `ψ` continuous
at `z₀`, `ψ z₀ = φ₀`. -/
theorem eq_polar_local {v z₀ : ℂ} {s₀ φ₀ : ℝ} (hs₀ : 0 < s₀) (hz₀ : z₀ = v + (s₀ : ℂ) * e φ₀) (z : ℂ) :
    z = v + (‖z - v‖ : ℂ) * e (φ₀ + arg ((z - v) / (z₀ - v))) := by
  have hz0v : z₀ - v = (s₀ : ℂ) * e φ₀ := by rw [hz₀]; ring
  have hne : z₀ - v ≠ 0 := by
    rw [hz0v]; exact mul_ne_zero (by exact_mod_cast hs₀.ne') (e_ne_zero _)
  set w := (z - v) / (z₀ - v) with hw
  have hnw : ‖w‖ * s₀ = ‖z - v‖ := by
    rw [hw, norm_div, hz0v, norm_mul_e hs₀.le]; field_simp
  have h1 : z - v = w * (z₀ - v) := by rw [hw]; field_simp
  have h2 := eq_polar_arg w
  calc z = v + (z - v) := by ring
    _ = v + ((‖w‖ : ℂ) * e (arg w)) * ((s₀ : ℂ) * e φ₀) := by rw [h1, ← h2, hz0v]
    _ = v + ((‖w‖ * s₀ : ℝ) : ℂ) * (e φ₀ * e (arg w)) := by push_cast; ring
    _ = _ := by rw [hnw, ← e_add]

theorem continuousAt_arg_div {v z₀ : ℂ} (hne : z₀ ≠ v) :
    ContinuousAt (fun z => arg ((z - v) / (z₀ - v))) z₀ := by
  have hne' : z₀ - v ≠ 0 := sub_ne_zero.mpr hne
  have hc : ContinuousAt (fun z : ℂ => (z - v) / (z₀ - v)) z₀ :=
    ((continuous_id.sub continuous_const).div_const _).continuousAt
  have ha : ContinuousAt arg ((z₀ - v) / (z₀ - v)) := by
    rw [div_self hne']; exact Complex.continuousAt_arg Complex.one_mem_slitPlane
  exact ContinuousAt.comp (g := arg) (f := fun z : ℂ => (z - v) / (z₀ - v)) ha hc

theorem arg_div_self {v z₀ : ℂ} (hne : z₀ ≠ v) : arg ((z₀ - v) / (z₀ - v)) = 0 := by
  rw [div_self (sub_ne_zero.mpr hne), Complex.arg_one]

/-- `‖e a − e b‖² = 2 − 2 cos (a − b)`. -/
theorem sq_norm_e_sub_e (a b : ℝ) : ‖e a - e b‖ ^ 2 = 2 - 2 * Real.cos (a - b) := by
  rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]
  simp only [Complex.sub_re, Complex.sub_im, re_e, im_e]
  rw [Real.cos_sub]
  nlinarith [Real.sin_sq_add_cos_sq a, Real.sin_sq_add_cos_sq b]

namespace BranchGerms

variable {n : ℕ} (G : BranchGerms n)

/-- The direction of germ `i` at distance `s`. -/
noncomputable def dir (i : Fin n) (s : ℝ) : ℝ := germDir (G.β i) (G.κ i) s

/-- The direction of the germ after `i` at distance `s` (one turn on after the last). -/
noncomputable def nextDir (i : Fin n) (s : ℝ) : ℝ := germDir (G.nextβ i) (G.nextκ i) s

theorem sector_eq (v : ℂ) (r : ℝ) (i : Fin n) :
    G.sector v r i = {z | ∃ s ∈ Ioo 0 r, ∃ φ ∈ Ioo (G.dir i s) (G.nextDir i s), z = v + (s : ℂ) * e φ} := rfl

/-- The germs' directions at distance `s`, as straight germs. -/
noncomputable def atRadius (s : ℝ) : BranchGerms n := ⟨fun i => G.dir i s, fun _ => 0⟩

theorem atRadius_nextβ (s : ℝ) (i : Fin n) : (G.atRadius s).nextβ i = G.nextDir i s := by
  unfold atRadius nextDir dir
  unfold nextβ nextκ
  split_ifs <;> simp [germDir_add_two_pi]

theorem nextDir_eq (i : Fin n) (s : ℝ) :
    G.nextDir i s = if h : i.val + 1 < n then G.dir ⟨i.val + 1, h⟩ s else G.dir ⟨0, i.pos⟩ s + 2 * π := by
  rw [← atRadius_nextβ]; rfl

theorem continuous_dir (i : Fin n) : Continuous (G.dir i) := continuous_germDir _ _

theorem continuous_nextDir (i : Fin n) : Continuous (G.nextDir i) := continuous_germDir _ _

/-- Consecutive directions weakly increase, round one turn. -/
def Mono : Prop := ∀ i, G.β i ≤ G.nextβ i

theorem Sorted.mono {G : BranchGerms n} (h : G.Sorted) : G.Mono := fun i =>
  (h.2 i).elim le_of_lt fun h => h.1.le

variable {G}

theorem Mono.le_add (hG : G.Mono) : ∀ (k : ℕ) (i : Fin n) (h : i.val + k < n), G.β i ≤ G.β ⟨i.val + k, h⟩
  | 0, i, _ => le_rfl
  | k + 1, i, h => by
    have h1 := hG.le_add k i (by omega)
    have h2 := hG ⟨i.val + k, by omega⟩
    simp only [nextβ, show i.val + k + 1 < n from by omega, dite_true] at h2
    exact h1.trans h2

theorem Mono.le_of_le (hG : G.Mono) {i j : Fin n} (hij : i ≤ j) : G.β i ≤ G.β j := by
  have := hG.le_add (j.val - i.val) i (by omega)
  have e1 : (⟨i.val + (j.val - i.val), by omega⟩ : Fin n) = j := Fin.ext (by simp; omega)
  rwa [e1] at this

theorem Mono.le_two_pi (hG : G.Mono) (j : Fin n) : G.β j ≤ G.β ⟨0, j.pos⟩ + 2 * π := by
  have hj := j.isLt
  have h1 := hG.le_of_le (show j ≤ ⟨n - 1, by omega⟩ from Fin.mk_le_mk.mpr (by omega))
  have h2 := hG ⟨n - 1, by omega⟩
  simp only [nextβ, show ¬ (n - 1 + 1 < n) from by omega, dite_false] at h2
  linarith

theorem Mono.nextβ_le (hG : G.Mono) (i : Fin n) : G.nextβ i ≤ G.β ⟨0, i.pos⟩ + 2 * π := by
  unfold nextβ
  split_ifs with h
  · exact hG.le_two_pi _
  · exact le_rfl

theorem Mono.zero_le (hG : G.Mono) (i : Fin n) : G.β ⟨0, i.pos⟩ ≤ G.β i :=
  hG.le_of_le (Fin.mk_le_mk.mpr (Nat.zero_le _))

theorem Mono.nextβ_le_add (hG : G.Mono) (i : Fin n) : G.nextβ i ≤ G.β i + 2 * π := by
  linarith [hG.nextβ_le i, hG.zero_le i]

theorem Mono.nextβ_le_of_lt (hG : G.Mono) {i j : Fin n} (hij : i < j) : G.nextβ i ≤ G.β j := by
  have hi : i.val + 1 < n := by have := j.isLt; have : i.val < j.val := hij; omega
  simp only [nextβ, hi, dite_true]
  exact hG.le_of_le (Fin.mk_le_mk.mpr (by have : i.val < j.val := hij; omega))

/-- **The angular intervals of distinct consecutive pairs overlap only at ends.** -/
theorem Mono.disjoint (hG : G.Mono) {i j : Fin n} (hij : i ≠ j) :
    Disjoint (angleIcc (G.β j) (G.nextβ j)) (angleIoo (G.β i) (G.nextβ i)) := by
  have hπ := Real.pi_pos
  rw [Set.disjoint_left]
  intro x hx hx'
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp hx
  obtain ⟨m', hm1', hm2'⟩ := mem_iUnion.mp hx'
  have b1 := hG.zero_le i
  have b2 := hG.zero_le j
  have b3 := hG.nextβ_le i
  have b4 := hG.nextβ_le j
  have b5 := hG i
  have b6 := hG j
  -- reduce to `m - m'`
  set d : ℤ := m - m' with hd
  have hdR : (m : ℝ) = d + m' := by rw [hd]; push_cast; ring
  rw [hdR] at hm1 hm2
  rcases lt_trichotomy d 0 with hneg | hzero | hpos
  · have : (d : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_iff.mpr hneg
    nlinarith
  · rw [hzero] at hm1 hm2
    push_cast at hm1 hm2
    rcases lt_or_gt_of_ne hij with h | h
    · have := hG.nextβ_le_of_lt h; linarith
    · have := hG.nextβ_le_of_lt h; linarith
  · have : (1 : ℝ) ≤ d := by exact_mod_cast hpos
    nlinarith

/-- **Every angle is a germ direction or in the open interval of one consecutive pair.** -/
theorem exists_angle (G : BranchGerms n) (hn : 0 < n) (φ : ℝ) :
    (∃ i, ∃ m : ℤ, φ = G.β i + 2 * π * m) ∨ ∃ i, φ ∈ angleIoo (G.β i) (G.nextβ i) := by
  have hπ := Real.pi_pos
  set z0 : Fin n := ⟨0, hn⟩
  obtain ⟨m, hm1, hm2⟩ := exists_shift_Ico (G.β z0) φ
  set φ' := φ + 2 * π * m with hφ'
  classical
  set I := Finset.univ.filter (fun i : Fin n => G.β i ≤ φ') with hI
  have hIne : I.Nonempty := ⟨z0, by simp [hI, hm1]⟩
  set i := I.max' hIne with hi
  have hiI : i ∈ I := I.max'_mem hIne
  have hiφ : G.β i ≤ φ' := (Finset.mem_filter.mp hiI).2
  have hnext : φ' < G.nextβ i := by
    unfold nextβ
    split_ifs with h
    · by_contra hc
      push Not at hc
      have hmem : (⟨i.val + 1, h⟩ : Fin n) ∈ I := by simp [hI, hc]
      have := I.le_max' _ hmem
      rw [← hi] at this
      have : i.val + 1 ≤ i.val := this
      omega
    · exact hm2
  rcases eq_or_lt_of_le hiφ with heq | hlt
  · left; exact ⟨i, -m, by push_cast; linarith⟩
  · right; exact ⟨i, mem_iUnion.mpr ⟨-m, by push_cast; constructor <;> linarith⟩⟩

/-- **No germ direction lies in the open interval of a consecutive pair.** -/
theorem Mono.not_mem_angleIoo (hG : G.Mono) (i j : Fin n) (m : ℤ) :
    G.β j + 2 * π * m ∉ angleIoo (G.β i) (G.nextβ i) := by
  have hπ := Real.pi_pos
  by_cases hij : i = j
  · subst hij
    intro h
    obtain ⟨m', h1, h2⟩ := mem_iUnion.mp h
    have b1 := hG.zero_le i
    have b3 := hG.nextβ_le i
    rcases le_or_gt m m' with hle | hgt
    · have : (m : ℝ) ≤ m' := by exact_mod_cast hle
      nlinarith
    · have : (m' : ℝ) + 1 ≤ m := by exact_mod_cast hgt
      nlinarith
  · intro h
    refine Set.disjoint_left.mp (hG.disjoint hij) ?_ h
    exact mem_iUnion.mpr ⟨m, by constructor <;> linarith [hG j]⟩


/-! ### The cyclic order at every distance -/

variable (G) in
/-- The index of the germ after `i`. -/
def next (i : Fin n) : Fin n := if h : i.val + 1 < n then ⟨i.val + 1, h⟩ else ⟨0, i.pos⟩

theorem e_nextDir (i : Fin n) (s : ℝ) : e (G.nextDir i s) = e (G.dir (next i) s) := by
  rw [nextDir_eq]
  unfold next
  split_ifs with h
  · rfl
  · exact e_add_two_pi _

theorem nextDir_of_next_eq {i : Fin n} (h : next i = i) (s : ℝ) : G.nextDir i s = G.dir i s + 2 * π := by
  rw [nextDir_eq]
  by_cases h' : i.val + 1 < n
  · simp only [next, h', dite_true] at h
    exact absurd (congrArg Fin.val h) (by simp)
  · simp only [next, h', dite_false] at h
    rw [dif_neg h', h]

theorem nextκ_eq (i : Fin n) : G.nextκ i = G.κ (next i) := by
  unfold nextκ next; split_ifs <;> rfl

variable (G) in
/-- **The cyclic order at every distance**: sorted germs whose branches are graphs over the radius and never meet at one
distance keep their order: at every `s ∈ (0, r₀)` each germ's direction lies below the next one's. -/
theorem dir_lt_nextDir (hS : G.Sorted) {r₀ : ℝ} (hcurv : ∀ i, |G.κ i| * r₀ < 2)
    (hdisj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 r₀, e (G.dir i s) ≠ e (G.dir j s)) :
    ∀ s ∈ Ioo 0 r₀, ∀ i, G.dir i s < G.nextDir i s := by
  intro s hs i
  have hπ := Real.pi_pos
  by_cases hni : next i = i
  · rw [nextDir_of_next_eq hni]; linarith
  set g : ℝ → ℝ := fun t => G.nextDir i t - G.dir i t with hg
  have hgc : Continuous g := (G.continuous_nextDir i).sub (G.continuous_dir i)
  have hg0 : ∀ t ∈ Ioo 0 r₀, g t ≠ 0 := by
    intro t ht h
    apply hdisj i (next i) (Ne.symm hni) t ht
    rw [← e_nextDir, show G.nextDir i t = G.dir i t by simp only [hg] at h; linarith]
  have hr₀ : 0 < r₀ := hs.1.trans hs.2
  have hbound : ∀ j, ∀ t ∈ Ioo 0 r₀, -1 ≤ G.κ j * t / 2 ∧ G.κ j * t / 2 ≤ 1 := by
    intro j t ht
    have h1 := hcurv j
    have h2 : |G.κ j * t| ≤ |G.κ j| * r₀ := by
      rw [abs_mul, abs_of_pos ht.1]; exact mul_le_mul_of_nonneg_left ht.2.le (abs_nonneg _)
    constructor <;> [skip; skip] <;> cases abs_le.mp (h2.trans h1.le) <;> linarith
  have hpos : ∃ t ∈ Ioo 0 r₀, 0 < g t := by
    rcases hS.2 i with hlt | ⟨heq, hκ⟩
    · have hlim : Tendsto g (𝓝 0) (𝓝 (G.nextβ i - G.β i)) := by
        have := hgc.tendsto 0
        simpa [hg, nextDir, dir] using this
      have ev : ∀ᶠ t in 𝓝[>] (0 : ℝ), 0 < g t ∧ t ∈ Ioo 0 r₀ :=
        ((hlim.eventually_const_lt (by linarith)).filter_mono nhdsWithin_le_nhds).and
          (Ioo_mem_nhdsGT hr₀)
      obtain ⟨t, h1, h2⟩ := ev.exists
      exact ⟨t, h2, h1⟩
    · refine ⟨s, hs, ?_⟩
      have hb1 := hbound i s hs
      have hb2 := hbound (next i) s hs
      have hlt : G.κ i * s / 2 < G.nextκ i * s / 2 := by
        have := mul_lt_mul_of_pos_right hκ hs.1; linarith
      rw [nextκ_eq] at hlt
      have := Real.arcsin_lt_arcsin hb1.1 hlt hb2.2
      simp only [hg, nextDir, dir, germDir, heq, nextκ_eq]
      linarith
  obtain ⟨t₀, ht₀, hgt₀⟩ := hpos
  by_contra hcon
  push Not at hcon
  have hgs : g s ≤ 0 := by simp only [hg]; linarith
  obtain ⟨t, ht, hgt⟩ := isPreconnected_Ioo.intermediate_value hs ht₀ hgc.continuousOn ⟨hgs, hgt₀.le⟩
  exact hg0 t ht hgt

/-! ### Sectors -/

variable {v : ℂ} {r₀ : ℝ}

theorem atRadius_mono (hord : ∀ s ∈ Ioo 0 r₀, ∀ i, G.dir i s < G.nextDir i s) {s : ℝ} (hs : s ∈ Ioo 0 r₀) :
    (G.atRadius s).Mono := fun i => by
  rw [atRadius_nextβ]; exact (hord s hs i).le

theorem mem_sector_iff {r : ℝ} {i : Fin n} {z : ℂ} :
    z ∈ G.sector v r i ↔ ‖z - v‖ ∈ Ioo 0 r ∧ ∃ φ ∈ Ioo (G.dir i ‖z - v‖) (G.nextDir i ‖z - v‖),
      z = v + (‖z - v‖ : ℂ) * e φ := by
  constructor
  · rintro ⟨s, hs, φ, hφ, rfl⟩
    rw [add_sub_cancel_left, norm_mul_e hs.1.le]
    exact ⟨hs, φ, hφ, rfl⟩
  · rintro ⟨hs, φ, hφ, hz⟩
    exact ⟨_, hs, φ, hφ, hz⟩

theorem sector_mono {r r' : ℝ} (h : r' ≤ r) (i : Fin n) : G.sector v r' i ⊆ G.sector v r i := by
  rintro z ⟨s, hs, φ, hφ, rfl⟩
  exact ⟨s, ⟨hs.1, hs.2.trans_le h⟩, φ, hφ, rfl⟩

theorem sector_subset_ball {r : ℝ} (i : Fin n) : G.sector v r i ⊆ ball v r := by
  rintro z ⟨s, hs, φ, -, rfl⟩
  rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_mul_e hs.1.le]; exact hs.2

/-- **Distinct sectors are disjoint.** -/
theorem sector_disjoint (hord : ∀ s ∈ Ioo 0 r₀, ∀ i, G.dir i s < G.nextDir i s) {r : ℝ} (hr : r ≤ r₀) {i j : Fin n}
    (hij : i ≠ j) : Disjoint (G.sector v r i) (G.sector v r j) := by
  rw [Set.disjoint_left]
  rintro z ⟨s, hs, φ, hφ, rfl⟩ ⟨s', hs', φ', hφ', heq⟩
  obtain ⟨rfl, he⟩ := (polar_eq_iff hs.1 hs'.1).mp heq
  obtain ⟨m, hm⟩ := e_eq_e_iff.mp he
  have hsr : s ∈ Ioo 0 r₀ := ⟨hs.1, hs.2.trans_le hr⟩
  have hM := G.atRadius_mono hord hsr
  have hφ1 : G.dir i s < φ ∧ φ < G.nextDir i s := hφ
  have hφ2 : G.dir j s < φ' ∧ φ' < G.nextDir j s := hφ'
  have h1 : φ ∈ angleIcc ((G.atRadius s).β j) ((G.atRadius s).nextβ j) := by
    rw [atRadius_nextβ]
    refine mem_iUnion.mpr ⟨m, ?_⟩
    show G.dir j s + 2 * π * m ≤ φ ∧ φ ≤ G.nextDir j s + 2 * π * m
    constructor <;> linarith [hφ2.1, hφ2.2]
  have h2 : φ ∈ angleIoo ((G.atRadius s).β i) ((G.atRadius s).nextβ i) := by
    rw [atRadius_nextβ]; exact Ioo_subset_angleIoo _ _ hφ1
  exact Set.disjoint_left.mp (hM.disjoint hij) h1 h2

/-- **Each sector is open**: near a point of it, the local angle and the distance move continuously. -/
theorem isOpen_sector (r : ℝ) (i : Fin n) : IsOpen (G.sector v r i) := by
  rw [isOpen_iff_mem_nhds]
  rintro z₀ ⟨s₀, hs₀, φ₀, hφ₀, hz₀⟩
  have hz₀v : z₀ ≠ v := by
    intro h
    have := congrArg (fun z => ‖z - v‖) hz₀
    simp only [h, sub_self, norm_zero, add_sub_cancel_left, norm_mul_e hs₀.1.le] at this
    linarith [hs₀.1]
  set ψ : ℂ → ℝ := fun z => φ₀ + arg ((z - v) / (z₀ - v)) with hψ
  have hψc : ContinuousAt ψ z₀ := continuousAt_const.add (continuousAt_arg_div hz₀v)
  have hψ0 : ψ z₀ = φ₀ := by simp [hψ, arg_div_self hz₀v]
  have hnc : ContinuousAt (fun z : ℂ => ‖z - v‖) z₀ := (continuous_norm.comp (continuous_id.sub continuous_const)).continuousAt
  have hn0 : ‖z₀ - v‖ = s₀ := by rw [hz₀, add_sub_cancel_left, norm_mul_e hs₀.1.le]
  have ev1 : ∀ᶠ z in 𝓝 z₀, ‖z - v‖ ∈ Ioo 0 r :=
    hnc.preimage_mem_nhds (by rw [hn0]; exact Ioo_mem_nhds hs₀.1 hs₀.2)
  have ev2 : ∀ᶠ z in 𝓝 z₀, G.dir i ‖z - v‖ < ψ z :=
    ContinuousAt.eventually_lt ((G.continuous_dir i).continuousAt.comp hnc) hψc
      (by simp only [hn0, hψ0]; exact hφ₀.1)
  have ev3 : ∀ᶠ z in 𝓝 z₀, ψ z < G.nextDir i ‖z - v‖ :=
    ContinuousAt.eventually_lt hψc ((G.continuous_nextDir i).continuousAt.comp hnc)
      (by simp only [hn0, hψ0]; exact hφ₀.2)
  filter_upwards [ev1, ev2, ev3] with z h1 h2 h3
  exact ⟨‖z - v‖, h1, ψ z, ⟨h2, h3⟩, eq_polar_local hs₀.1 hz₀ z⟩

/-- **Each sector is connected**: the image of `(0, r) × (0, 1)` under `(s, t) ↦ v + s e(fᵢ(s) + t (fᵢ₊₁(s) − fᵢ(s)))`. -/
theorem isPreconnected_sector (hord : ∀ s ∈ Ioo 0 r₀, ∀ i, G.dir i s < G.nextDir i s) {r : ℝ} (hr : r ≤ r₀)
    (i : Fin n) : IsPreconnected (G.sector v r i) := by
  set f : ℝ × ℝ → ℂ := fun p => v + (p.1 : ℂ) * e (G.dir i p.1 + p.2 * (G.nextDir i p.1 - G.dir i p.1)) with hf
  have hfc : Continuous f := by
    have h1 : Continuous fun p : ℝ × ℝ => G.dir i p.1 + p.2 * (G.nextDir i p.1 - G.dir i p.1) :=
      ((G.continuous_dir i).comp continuous_fst).add
        (continuous_snd.mul (((G.continuous_nextDir i).comp continuous_fst).sub ((G.continuous_dir i).comp continuous_fst)))
    have h2 : Continuous fun p : ℝ × ℝ => e (G.dir i p.1 + p.2 * (G.nextDir i p.1 - G.dir i p.1)) :=
      Complex.continuous_exp.comp ((Complex.continuous_ofReal.comp h1).mul continuous_const)
    exact continuous_const.add ((Complex.continuous_ofReal.comp continuous_fst).mul h2)
  have heq : G.sector v r i = f '' (Ioo 0 r ×ˢ Ioo 0 1) := by
    ext z
    constructor
    · rintro ⟨s, hs, φ, hφ, rfl⟩
      have hφ : G.dir i s < φ ∧ φ < G.nextDir i s := hφ
      have hgap : 0 < G.nextDir i s - G.dir i s := by linarith [hφ.1, hφ.2]
      refine ⟨(s, (φ - G.dir i s) / (G.nextDir i s - G.dir i s)), ⟨hs, ?_, ?_⟩, ?_⟩
      · exact div_pos (by linarith [hφ.1]) hgap
      · rw [div_lt_one hgap]; linarith [hφ.2]
      · simp only [hf]; congr 3; field_simp; ring
    · rintro ⟨⟨s, t⟩, ⟨hs, ht⟩, rfl⟩
      have hgap := hord s ⟨hs.1, hs.2.trans_le hr⟩ i
      refine ⟨s, hs, _, ⟨?_, ?_⟩, rfl⟩
      · show G.dir i s < G.dir i s + t * (G.nextDir i s - G.dir i s)
        nlinarith [ht.1]
      · show G.dir i s + t * (G.nextDir i s - G.dir i s) < G.nextDir i s
        nlinarith [ht.2]
  rw [heq]
  exact ((convex_Ioo 0 r).prod (convex_Ioo 0 1)).isPreconnected.image f hfc.continuousOn

/-- A direction along which the set holds points `v + t e(δ)` for arbitrarily small `t > 0` is in its cone. -/
theorem mem_coneAt_of_ray {S : Set ℂ} {δ : ℝ} (h : ∀ ε : ℝ, 0 < ε → ∃ t : ℝ, t ∈ Ioo 0 ε ∧ v + (t : ℂ) * e δ ∈ S) :
    δ ∈ coneAt S v := by
  intro ε hε
  obtain ⟨t, ht, hS⟩ := h ε hε
  refine ⟨_, hS, ?_, ?_, ?_⟩
  · intro h'
    have := congrArg (fun z => ‖z - v‖) h'
    simp only [add_sub_cancel_left, sub_self, norm_zero, norm_mul_e ht.1.le] at this
    linarith [ht.1]
  · rw [dist_eq_norm, add_sub_cancel_left, norm_mul_e ht.1.le]; exact ht.2
  · have ht0 : (t : ℂ) ≠ 0 := by exact_mod_cast ht.1.ne'
    rw [add_sub_cancel_left, norm_mul_e ht.1.le, mul_div_cancel_left₀ _ ht0, sub_self, norm_zero]; exact hε

/-- **The cone of a sector** at `v` is the angular interval of its two germs' directions (one direction at a cusp). -/
theorem coneAt_sector (hM : G.Mono) (hord : ∀ s ∈ Ioo 0 r₀, ∀ i, G.dir i s < G.nextDir i s) {r : ℝ}
    (hr : r ∈ Ioc 0 r₀) (i : Fin n) : coneAt (G.sector v r i) v = angleIcc (G.β i) (G.nextβ i) := by
  have hπ := Real.pi_pos
  have hd0 : Tendsto (G.dir i) (𝓝 0) (𝓝 (G.β i)) := by
    have := (G.continuous_dir i).tendsto 0; simpa [dir] using this
  have hn0 : Tendsto (G.nextDir i) (𝓝 0) (𝓝 (G.nextβ i)) := by
    have := (G.continuous_nextDir i).tendsto 0; simpa [nextDir] using this
  -- the open interval is approached along rays
  have hopen : Ioo (G.β i) (G.nextβ i) ⊆ coneAt (G.sector v r i) v := by
    intro δ hδ
    refine mem_coneAt_of_ray fun ε hε => ?_
    have ev : ∀ᶠ t in 𝓝[>] (0 : ℝ), (G.dir i t < δ ∧ δ < G.nextDir i t) ∧ t ∈ Ioo 0 (min r ε) :=
      (((hd0.eventually_lt_const hδ.1).and (hn0.eventually_const_lt hδ.2)).filter_mono nhdsWithin_le_nhds).and
        (Ioo_mem_nhdsGT (lt_min hr.1 hε))
    obtain ⟨t, ⟨h1, h2⟩, ht⟩ := ev.exists
    exact ⟨t, ⟨ht.1, ht.2.trans_le (min_le_right _ _)⟩, t, ⟨ht.1, ht.2.trans_le (min_le_left _ _)⟩, δ,
      ⟨h1, h2⟩, rfl⟩
  -- nothing outside the closed interval is approached
  have hsub : coneAt (G.sector v r i) v ⊆ angleIcc (G.β i) (G.nextβ i) := by
    intro β₀ hβ₀
    by_contra hnot
    have hle := hM i
    have hle2 := hM.nextβ_le_add i
    obtain ⟨m, hm1, hm2⟩ := exists_shift_Ico (G.β i) β₀
    set b := β₀ + 2 * π * m with hb
    have hbn : G.nextβ i < b := by
      by_contra hc
      push Not at hc
      exact hnot (mem_iUnion.mpr ⟨-m, by push_cast; constructor <;> linarith⟩)
    set η := min (b - G.nextβ i) (G.β i + 2 * π - b) / 2 with hη
    have hη1 : 2 * η ≤ b - G.nextβ i := by rw [hη]; linarith [min_le_left (b - G.nextβ i) (G.β i + 2 * π - b)]
    have hη2 : 2 * η ≤ G.β i + 2 * π - b := by rw [hη]; linarith [min_le_right (b - G.nextβ i) (G.β i + 2 * π - b)]
    have hη0 : 0 < η := by rw [hη]; exact half_pos (lt_min (by linarith) (by linarith))
    have hηπ : η ≤ π := by linarith
    have ev : ∀ᶠ t in 𝓝 (0 : ℝ), G.β i - η < G.dir i t ∧ G.nextDir i t < G.nextβ i + η :=
      (hd0.eventually_const_lt (by linarith)).and (hn0.eventually_lt_const (by linarith))
    obtain ⟨ρ, hρ, hρev⟩ := Metric.eventually_nhds_iff.mp ev
    set c := 1 - Real.cos η with hc
    have hc0 : 0 < c := by
      have := Real.cos_lt_cos_of_nonneg_of_le_pi le_rfl hηπ hη0
      rw [Real.cos_zero] at this; linarith
    have hc2 : c ≤ 2 := by have := Real.neg_one_le_cos η; linarith
    obtain ⟨z, hz, -, hzd, hzu⟩ := hβ₀ (min ρ c) (lt_min hρ hc0)
    obtain ⟨s, hs, φ, hφ, rfl⟩ := hz
    have hφ : G.dir i s < φ ∧ φ < G.nextDir i s := hφ
    rw [dist_eq_norm, add_sub_cancel_left, norm_mul_e hs.1.le] at hzd
    have hds := hρev (show dist s 0 < ρ by
      rw [Real.dist_eq, sub_zero, abs_of_pos hs.1]; exact hzd.trans_le (min_le_left _ _))
    have hs0 : (s : ℂ) ≠ 0 := by exact_mod_cast hs.1.ne'
    rw [add_sub_cancel_left, norm_mul_e hs.1.le, mul_div_cancel_left₀ _ hs0,
      show e β₀ = e b from (e_add_int_mul β₀ m).symm] at hzu
    have hx1 : η < b - φ := by linarith [hds.2, hφ.2]
    have hx2 : b - φ < 2 * π - η := by linarith [hds.1, hφ.1]
    have hcos : Real.cos (φ - b) ≤ Real.cos η := by
      rw [← Real.cos_neg, neg_sub]
      rcases le_total (b - φ) π with h | h
      · exact Real.cos_le_cos_of_nonneg_of_le_pi hη0.le h hx1.le
      · rw [← Real.cos_two_pi_sub]
        exact Real.cos_le_cos_of_nonneg_of_le_pi hη0.le (by linarith) (by linarith)
    have hsq := sq_norm_e_sub_e φ b
    have hlt : ‖e φ - e b‖ < c := hzu.trans_le (min_le_right _ _)
    have hn0' : 0 ≤ ‖e φ - e b‖ := norm_nonneg _
    nlinarith [mul_lt_mul'' hlt hlt hn0' hn0', mul_le_mul_of_nonneg_left hc2 hc0.le]
  -- the sector has points at every small distance
  have hnonempty : (coneAt (G.sector v r i) v).Nonempty := by
    refine coneAt_nonempty fun ε hε => ?_
    set t := min r ε / 2 with ht
    have ht0 : 0 < t := by rw [ht]; exact half_pos (lt_min hr.1 hε)
    have htr : t < r := by rw [ht]; linarith [min_le_left r ε]
    have hte : t < ε := by rw [ht]; linarith [min_le_right r ε]
    have hord' := hord t ⟨ht0, htr.trans_le hr.2⟩ i
    refine ⟨v + (t : ℂ) * e ((G.dir i t + G.nextDir i t) / 2), ⟨t, ⟨ht0, htr⟩, _, ⟨?_, ?_⟩, rfl⟩, ?_, ?_⟩
    · show G.dir i t < _; linarith
    · show _ < G.nextDir i t; linarith
    · intro h'
      have := congrArg (fun z => ‖z - v‖) h'
      simp only [add_sub_cancel_left, sub_self, norm_zero, norm_mul_e ht0.le] at this
      linarith
    · rw [dist_eq_norm, add_sub_cancel_left, norm_mul_e ht0.le]; exact hte
  have hper : ∀ β, β + 2 * π ∈ coneAt (G.sector v r i) v ↔ β ∈ coneAt (G.sector v r i) v :=
    fun β => mem_coneAt_add_two_pi
  have hIcc : Icc (G.β i) (G.nextβ i) ⊆ coneAt (G.sector v r i) v := by
    rcases eq_or_lt_of_le (hM i) with heq | hlt
    · obtain ⟨β', hβ'⟩ := hnonempty
      obtain ⟨m', hm'1, hm'2⟩ := mem_iUnion.mp (hsub hβ')
      rw [← heq] at hm'2
      have h' : β' = G.β i + 2 * π * m' := le_antisymm hm'2 hm'1
      rw [h'] at hβ'
      have hβi := (periodic_int hper (G.β i) m').mp hβ'
      intro y hy
      rw [← heq] at hy
      rw [le_antisymm hy.2 hy.1]; exact hβi
    · rw [← closure_Ioo hlt.ne]
      exact closure_minimal hopen (isClosed_coneAt _ _)
  apply Subset.antisymm hsub
  intro x hx
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp hx
  have h := hIcc (show x - 2 * π * m ∈ Icc (G.β i) (G.nextβ i) from ⟨by linarith, by linarith⟩)
  have := (periodic_int hper (x - 2 * π * m) m).mpr h
  rwa [sub_add_cancel] at this

end BranchGerms

/-! ### The germs of a line or circle through `v` -/

/-- The germ of the full curve `curveAt v κ b` (`κ ∈ {0, 1}`) leaving `v` on side `σ = ±1`: its direction, normalised into
`[0, 2π)`, and its signed curvature (`0` on a line, `±1/‖b‖` on the circle centred at `v + b`). -/
noncomputable def curveGerm (κ : ℝ) (b : ℂ) (σ : ℝ) : ℝ × ℝ :=
  (toIcoMod Real.two_pi_pos 0 (arg b - σ * (π / 2)), σ * κ / ‖b‖)

theorem curveGerm_fst_mem (κ : ℝ) (b : ℂ) (σ : ℝ) : (curveGerm κ b σ).1 ∈ Ico 0 (2 * π) := by
  have := toIcoMod_mem_Ico Real.two_pi_pos 0 (arg b - σ * (π / 2))
  simpa [curveGerm] using this

theorem e_toIcoMod_add (x y : ℝ) : e (toIcoMod Real.two_pi_pos 0 x + y) = e (x + y) := by
  have h := self_sub_toIcoMod Real.two_pi_pos 0 x
  rw [zsmul_eq_mul] at h
  rw [show toIcoMod Real.two_pi_pos 0 x + y = (x + y) + 2 * π * ((-(toIcoDiv Real.two_pi_pos 0 x) : ℤ) : ℝ) by
    push_cast; linarith]
  exact e_add_int_mul _ _

theorem branchPt_curveGerm (v : ℂ) (κ : ℝ) (b : ℂ) (σ s : ℝ) :
    branchPt v (curveGerm κ b σ).1 (curveGerm κ b σ).2 s =
      v + (s : ℂ) * e (arg b - σ * (π / 2) + Real.arcsin (σ * (κ * s / (2 * ‖b‖)))) := by
  simp only [branchPt, curveGerm]
  rw [e_toIcoMod_add]
  congr 4
  ring_nf

/-- `(s e(θ)) · conj b = s ‖b‖ e(θ − arg b)`. -/
theorem mul_e_mul_conj (s θ : ℝ) (b : ℂ) :
    (s : ℂ) * e θ * (starRingEnd ℂ) b = ((s * ‖b‖ : ℝ) : ℂ) * e (θ - arg b) := by
  conv_lhs => rw [eq_polar_arg b]
  rw [map_mul, Complex.conj_ofReal, conj_e, show θ - arg b = θ + -arg b by ring, e_add]
  push_cast; ring

/-- **A germ's branch lies on its curve** (as long as it is a graph over the radius). -/
theorem branchPt_curveGerm_mem {v : ℂ} {κ : ℝ} (hκ : 0 ≤ κ) {b : ℂ} (hb : b ≠ 0) {σ : ℝ} (hσ : σ = 1 ∨ σ = -1)
    {s : ℝ} (hs : 0 ≤ s) (hsb : κ * s ≤ 2 * ‖b‖) :
    branchPt v (curveGerm κ b σ).1 (curveGerm κ b σ).2 s ∈ curveAt v κ b := by
  have hbn : 0 < ‖b‖ := norm_pos_iff.mpr hb
  set x := κ * s / (2 * ‖b‖) with hx
  have hx0 : 0 ≤ x := by positivity
  have hx1 : x ≤ 1 := by rw [hx, div_le_one (by positivity)]; exact hsb
  set α := Real.arcsin (σ * x) with hα
  have hsα : Real.sin α = σ * x :=
    Real.sin_arcsin (by rcases hσ with rfl | rfl <;> linarith) (by rcases hσ with rfl | rfl <;> linarith)
  rw [branchPt_curveGerm]
  simp only [curveAt, mem_setOf_eq, add_sub_cancel_left]
  rw [mul_e_mul_conj, Complex.re_ofReal_mul, re_e, Complex.normSq_eq_norm_sq, norm_mul_e hs]
  have hcos : Real.cos (arg b - σ * (π / 2) + α - arg b) = σ * Real.sin α := by
    rw [show arg b - σ * (π / 2) + α - arg b = α - σ * (π / 2) by ring]
    rcases hσ with rfl | rfl
    · rw [one_mul, Real.cos_sub_pi_div_two, one_mul]
    · rw [show α - -1 * (π / 2) = α + π / 2 by ring, Real.cos_add_pi_div_two]; ring
  rw [hcos, hsα]
  have hσσ : σ * σ = 1 := by rcases hσ with rfl | rfl <;> norm_num
  rw [show σ * (σ * x) = x by rw [← mul_assoc, hσσ, one_mul], hx]
  field_simp

/-- **A curve point near `v` lies on one of the curve's two germs**, at its own distance. -/
theorem exists_eq_branchPt_curveGerm {v : ℂ} {κ : ℝ} (hκ : 0 ≤ κ) {b : ℂ} (hb : b ≠ 0) {z : ℂ}
    (hz : z ∈ curveAt v κ b) (hzv : z ≠ v) (hzb : κ * ‖z - v‖ < 2 * ‖b‖) :
    ∃ σ : ℝ, (σ = 1 ∨ σ = -1) ∧ z = branchPt v (curveGerm κ b σ).1 (curveGerm κ b σ).2 ‖z - v‖ := by
  have hbn : 0 < ‖b‖ := norm_pos_iff.mpr hb
  set s := ‖z - v‖ with hs
  have hs0 : 0 < s := norm_pos_iff.mpr (sub_ne_zero.mpr hzv)
  set φ := arg (z - v) with hφ
  have hzpol : z - v = (s : ℂ) * e φ := eq_polar_arg (z - v)
  set x := κ * s / (2 * ‖b‖) with hx
  have hx0 : 0 ≤ x := by positivity
  have hx1 : x < 1 := by rw [hx, div_lt_one (by positivity)]; exact hzb
  have hcos : Real.cos (φ - arg b) = x := by
    simp only [curveAt, mem_setOf_eq] at hz
    rw [hzpol, mul_e_mul_conj, Complex.re_ofReal_mul, re_e, Complex.normSq_eq_norm_sq, norm_mul_e hs0.le] at hz
    rw [hx, eq_div_iff (by positivity)]
    have h3 : s * (κ * s) = s * (Real.cos (φ - arg b) * (2 * ‖b‖)) := by linear_combination hz
    exact (mul_left_cancel₀ hs0.ne' h3).symm
  set α₀ := Real.arcsin x with hα₀
  have hsin : Real.sin α₀ = x := Real.sin_arcsin (by linarith) hx1.le
  have h2 : Real.cos (φ - arg b) = Real.cos (π / 2 - α₀) := by rw [Real.cos_pi_div_two_sub, hsin, hcos]
  obtain ⟨m, hm | hm⟩ := Real.cos_eq_cos_iff.mp h2
  · refine ⟨-1, Or.inr rfl, ?_⟩
    rw [branchPt_curveGerm]
    have h4 : arg b - -1 * (π / 2) + Real.arcsin (-1 * (κ * s / (2 * ‖b‖))) = φ + 2 * π * m := by
      rw [show -1 * (κ * s / (2 * ‖b‖)) = -x by rw [hx]; ring, Real.arcsin_neg]; linarith
    rw [h4, e_add_int_mul]; linear_combination hzpol
  · refine ⟨1, Or.inl rfl, ?_⟩
    rw [branchPt_curveGerm]
    have h4 : arg b - 1 * (π / 2) + Real.arcsin (1 * (κ * s / (2 * ‖b‖))) = φ + 2 * π * ((-m : ℤ) : ℝ) := by
      simp only [one_mul]; rw [← hx]; push_cast; linarith [hα₀]
    rw [h4, e_add_int_mul]; linear_combination hzpol

/-- Two normalised germs that differ have branches that never meet at one small distance. -/
theorem exists_germDir_ne {g g' : ℝ × ℝ} (hg : g.1 ∈ Ico 0 (2 * π)) (hg' : g'.1 ∈ Ico 0 (2 * π)) (hne : g ≠ g') :
    ∃ ε > 0, ∀ s ∈ Ioo 0 ε, e (germDir g.1 g.2 s) ≠ e (germDir g'.1 g'.2 s) := by
  have hπ := Real.pi_pos
  by_cases h1 : g.1 = g'.1
  · have h2 : g.2 ≠ g'.2 := fun h2 => hne (Prod.ext h1 h2)
    refine ⟨1 / (|g.2| + |g'.2| + 1), by positivity, fun s hs heq => ?_⟩
    have hsmall : ∀ κ : ℝ, |κ| ≤ |g.2| + |g'.2| → |κ * s / 2| < 1 / 2 := by
      intro κ hκ
      have hs1 : s * (|g.2| + |g'.2| + 1) < 1 := by
        have := hs.2; rw [lt_div_iff₀ (by positivity)] at this; exact this
      rw [abs_div, abs_mul, abs_of_pos hs.1, abs_two]
      have : |κ| * s ≤ (|g.2| + |g'.2|) * s := mul_le_mul_of_nonneg_right hκ hs.1.le
      nlinarith [hs.1]
    have hb1 := abs_lt.mp (hsmall g.2 (by linarith [abs_nonneg g'.2]))
    have hb2 := abs_lt.mp (hsmall g'.2 (by linarith [abs_nonneg g.2]))
    obtain ⟨m, hm⟩ := e_eq_e_iff.mp heq
    simp only [germDir, h1] at hm
    have ha1 := Real.arcsin_lt_pi_div_two.mpr (show g.2 * s / 2 < 1 by linarith)
    have ha2 := Real.neg_pi_div_two_lt_arcsin.mpr (show -1 < g.2 * s / 2 by linarith)
    have ha3 := Real.arcsin_lt_pi_div_two.mpr (show g'.2 * s / 2 < 1 by linarith)
    have ha4 := Real.neg_pi_div_two_lt_arcsin.mpr (show -1 < g'.2 * s / 2 by linarith)
    have hm0 : m = 0 := by
      rcases lt_trichotomy m 0 with h | h | h
      · have : (m : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_iff.mpr h
        nlinarith
      · exact h
      · have : (1 : ℝ) ≤ m := by exact_mod_cast h
        nlinarith
    rw [hm0] at hm
    push_cast at hm
    have h5 : Real.arcsin (g.2 * s / 2) = Real.arcsin (g'.2 * s / 2) := by linarith
    have h6 := (Real.arcsin_inj (by linarith) (by linarith) (by linarith) (by linarith)).mp h5
    exact h2 (by
      have hs0 : s ≠ 0 := hs.1.ne'
      have : (g.2 - g'.2) * s = 0 := by linarith
      rcases mul_eq_zero.mp this with h | h
      · linarith
      · exact absurd h hs0)
  · have hne' : e g.1 ≠ e g'.1 := by
      intro h
      obtain ⟨m, hm⟩ := e_eq_e_iff.mp h
      apply h1
      rcases lt_trichotomy m 0 with h' | h' | h'
      · have : (m : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_iff.mpr h'
        nlinarith [hg.1, hg.2, hg'.1, hg'.2]
      · rw [h'] at hm; simpa using hm
      · have : (1 : ℝ) ≤ m := by exact_mod_cast h'
        nlinarith [hg.1, hg.2, hg'.1, hg'.2]
    have hcont : Continuous fun s => e (germDir g.1 g.2 s) - e (germDir g'.1 g'.2 s) :=
      (continuous_e.comp (continuous_germDir _ _)).sub (continuous_e.comp (continuous_germDir _ _))
    have hopen : IsOpen {s : ℝ | e (germDir g.1 g.2 s) - e (germDir g'.1 g'.2 s) ≠ 0} :=
      hcont.isOpen_preimage _ isOpen_ne
    have h0 : (0 : ℝ) ∈ {s : ℝ | e (germDir g.1 g.2 s) - e (germDir g'.1 g'.2 s) ≠ 0} := by
      simp only [mem_setOf_eq, germDir_zero]; exact sub_ne_zero.mpr hne'
    obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp hopen 0 h0
    refine ⟨ε, hε, fun s hs heq => hball ?_ (sub_eq_zero.mpr heq)⟩
    rw [mem_ball, Real.dist_eq, sub_zero, abs_of_pos hs.1]; exact hs.2

/-! ### Arcs near a point of their own -/

/-- The end points of an arc. -/
noncomputable def Arc.ends : Arc → Set ℂ
  | .seg u w => {u, w}
  | .circ c ρ θ₀ θ₁ => {c + ρ * e θ₀, c + ρ * e θ₁}

theorem Arc.finite_ends (a : Arc) : a.ends.Finite := by
  cases a <;> exact (Set.finite_singleton _).insert _

/-- **Off its ends, an arc holds every point of its full curve nearby.** -/
theorem Arc.eventually_mem_carrier {a : Arc} (ha : a.Nondegenerate) {v y : ℂ} (hv : v ∈ a.carrier)
    (hy : y ∈ a.carrier) (hye : y ∉ a.ends) : ∀ᶠ z in 𝓝 y, z ∈ a.curve v → z ∈ a.carrier := by
  cases a with
  | seg u w =>
    have hd : w - u ≠ 0 := sub_ne_zero.mpr (Ne.symm ha)
    set d := w - u with hddef
    have hnd : 0 < Complex.normSq d := Complex.normSq_pos.mpr hd
    set τ : ℂ → ℝ := fun z => ((z - u) * (starRingEnd ℂ) d).re / Complex.normSq d with hτ
    have hτc : Continuous τ := by
      simp only [hτ]
      exact (Complex.continuous_re.comp ((continuous_id.sub continuous_const).mul continuous_const)).div_const _
    have hseg : ∀ z ∈ segment ℝ u w, ∃ t : ℝ, z = u + (t : ℂ) * d ∧ τ z = t ∧ t ∈ Icc 0 1 := by
      rintro z ⟨a1, b1, ha1, hb1, hab, rfl⟩
      have hz : a1 • u + b1 • w = u + (b1 : ℂ) * d := by
        rw [hddef, show a1 = 1 - b1 by linarith]; simp only [Complex.real_smul]; push_cast; ring
      refine ⟨b1, hz, ?_, hb1, by linarith⟩
      simp only [hτ, hz, add_sub_cancel_left]
      rw [mul_assoc, Complex.mul_conj, ← Complex.ofReal_mul, Complex.ofReal_re]
      field_simp
    have hline : ∀ z ∈ (Arc.seg u w).curve v, z = u + (τ z : ℂ) * d := by
      intro z hz
      obtain ⟨tv, hv', -, -⟩ := hseg v hv
      simp only [Arc.curve, Arc.curveData, curveAt, mem_setOf_eq, zero_mul] at hz
      rw [map_mul, Complex.conj_I, ← hddef] at hz
      have hP : ((z - u) * (starRingEnd ℂ) d).im = 0 := by
        have h1 : ((z - v) * (-I * (starRingEnd ℂ) d)).re = ((z - v) * (starRingEnd ℂ) d).im := by
          simp only [Complex.mul_re, Complex.mul_im, Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im]
          ring
        have h2 : (z - u) * (starRingEnd ℂ) d = (z - v) * (starRingEnd ℂ) d + ((tv * Complex.normSq d : ℝ) : ℂ) := by
          rw [hv', Complex.ofReal_mul, Complex.normSq_eq_conj_mul_self]; ring
        rw [h2, Complex.add_im, Complex.ofReal_im, add_zero, ← h1]
        linarith
      have hPe : (z - u) * (starRingEnd ℂ) d = (((z - u) * (starRingEnd ℂ) d).re : ℂ) :=
        Complex.ext (by simp) (by simp [hP])
      have hnd' : (Complex.normSq d : ℂ) ≠ 0 := by exact_mod_cast hnd.ne'
      have h3 : (z - u) * (Complex.normSq d : ℂ) = (((z - u) * (starRingEnd ℂ) d).re : ℂ) * d := by
        rw [Complex.normSq_eq_conj_mul_self, ← mul_assoc, ← hPe]
      have h4 : z - u = (τ z : ℂ) * d := by
        simp only [hτ]
        push_cast
        field_simp
        linear_combination h3
      linear_combination h4
    obtain ⟨ty, hyt, hτy, hty⟩ := hseg y hy
    have hty' : ty ∈ Ioo 0 1 := by
      refine ⟨lt_of_le_of_ne hty.1 ?_, lt_of_le_of_ne hty.2 ?_⟩
      · rintro rfl; apply hye; left; rw [hyt]; simp
      · rintro rfl; apply hye; right; rw [hyt, hddef]; simp
    have ev : ∀ᶠ z in 𝓝 y, τ z ∈ Ioo 0 1 :=
      hτc.continuousAt.preimage_mem_nhds (by rw [hτy]; exact Ioo_mem_nhds hty'.1 hty'.2)
    filter_upwards [ev] with z hz hzc
    rw [hline z hzc]
    refine ⟨1 - τ z, τ z, by linarith [hz.2], hz.1.le, by ring, ?_⟩
    rw [hddef]; simp only [Complex.real_smul]; push_cast; ring
  | circ c ρ θ₀ θ₁ =>
    obtain ⟨hρ, -, -⟩ := ha
    obtain ⟨θv, -, rfl⟩ := hv
    obtain ⟨θy, hθy, rfl⟩ := hy
    have hθy' : θy ∈ Ioo θ₀ θ₁ := by
      refine ⟨lt_of_le_of_ne hθy.1 ?_, lt_of_le_of_ne hθy.2 ?_⟩
      · rintro rfl; exact hye (Or.inl rfl)
      · rintro rfl; exact hye (Or.inr rfl)
    have hcurve : ∀ z ∈ (Arc.circ c ρ θ₀ θ₁).curve (c + ρ * e θv), ‖z - c‖ = ρ := by
      intro z hz
      simp only [Arc.curve, Arc.curveData, curveAt, mem_setOf_eq, one_mul] at hz
      have h1 := Complex.normSq_sub (z - (c + ρ * e θv)) (c - (c + ρ * e θv))
      rw [show z - (c + ρ * e θv) - (c - (c + ρ * e θv)) = z - c by ring] at h1
      have h2 : Complex.normSq (c - (c + ↑ρ * e θv)) = ρ ^ 2 := by
        rw [Complex.normSq_eq_norm_sq, show c - (c + ↑ρ * e θv) = -(↑ρ * e θv) by ring, norm_neg, norm_mul_e hρ.le]
      have h3 : ‖z - c‖ ^ 2 = ρ ^ 2 := by rw [← Complex.normSq_eq_norm_sq]; linarith
      exact (sq_eq_sq₀ (norm_nonneg _) hρ.le).mp h3
    have hyc : c + ↑ρ * e θy ≠ c := by
      intro h
      have := congrArg (fun z => ‖z - c‖) h
      simp only [add_sub_cancel_left, sub_self, norm_zero, norm_mul_e hρ.le] at this
      linarith
    set ψ : ℂ → ℝ := fun z => θy + arg ((z - c) / ((c + ↑ρ * e θy) - c)) with hψ
    have hψc : ContinuousAt ψ (c + ↑ρ * e θy) := continuousAt_const.add (continuousAt_arg_div hyc)
    have hψ0 : ψ (c + ↑ρ * e θy) = θy := by simp only [hψ, arg_div_self hyc, add_zero]
    have ev : ∀ᶠ z in 𝓝 (c + ↑ρ * e θy), ψ z ∈ Ioo θ₀ θ₁ :=
      hψc.preimage_mem_nhds (by rw [hψ0]; exact Ioo_mem_nhds hθy'.1 hθy'.2)
    filter_upwards [ev] with z hz hzc
    refine ⟨ψ z, Ioo_subset_Icc_self hz, ?_⟩
    have := eq_polar_local (v := c) (z₀ := c + ↑ρ * e θy) (φ₀ := θy) hρ rfl z
    rw [hcurve z hzc] at this
    exact this.symm

/-- An arc through `v` has points at every small positive distance from `v`. -/
theorem Arc.exists_near {a : Arc} (ha : a.Nondegenerate) {v : ℂ} (hv : v ∈ a.carrier) {r : ℝ} (hr : 0 < r) :
    ∃ z ∈ a.carrier, 0 < ‖z - v‖ ∧ ‖z - v‖ < r := by
  have hπ := Real.pi_pos
  have hpre : IsPreconnected a.carrier := by
    cases a with
    | seg u w => exact (convex_segment u w).isPreconnected
    | circ c ρ θ₀ θ₁ => exact isPreconnected_Icc.image _ (continuous_const.add (continuous_const.mul continuous_e)).continuousOn
  have hw : ∃ w ∈ a.carrier, w ≠ v := by
    cases a with
    | seg u w =>
      by_cases hu : u = v
      · exact ⟨w, right_mem_segment ℝ u w, fun h => ha (hu.trans h.symm)⟩
      · exact ⟨u, left_mem_segment ℝ u w, hu⟩
    | circ c ρ θ₀ θ₁ =>
      obtain ⟨hρ, h01, h01'⟩ := ha
      by_cases h0 : c + ρ * e θ₀ = v
      · refine ⟨c + ρ * e ((θ₀ + θ₁) / 2), ⟨_, ⟨by linarith, by linarith⟩, rfl⟩, ?_⟩
        rw [← h0]
        intro h
        have hρ0 : (ρ : ℂ) ≠ 0 := by exact_mod_cast hρ.ne'
        have h' : e ((θ₀ + θ₁) / 2) = e θ₀ := mul_left_cancel₀ hρ0 (add_left_cancel h)
        obtain ⟨m, hm⟩ := e_eq_e_iff.mp h'
        rcases lt_trichotomy m 0 with hm0 | hm0 | hm0
        · have : (m : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_iff.mpr hm0
          nlinarith
        · rw [hm0] at hm; push_cast at hm; linarith
        · have : (1 : ℝ) ≤ m := by exact_mod_cast hm0
          nlinarith
      · exact ⟨_, ⟨θ₀, ⟨le_rfl, h01.le⟩, rfl⟩, h0⟩
  obtain ⟨w, hw, hwv⟩ := hw
  have hd : 0 < ‖w - v‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hwv)
  have hsub := hpre.intermediate_value hv hw (f := fun z => ‖z - v‖)
    (continuous_norm.comp (continuous_id.sub continuous_const)).continuousOn
  set t := min ‖w - v‖ r / 2 with ht
  have ht0 : 0 < t := half_pos (lt_min hd hr)
  obtain ⟨z, hz, hzt⟩ := hsub (show t ∈ Icc ‖v - v‖ ‖w - v‖ from
    ⟨by rw [sub_self, norm_zero]; exact ht0.le, by rw [ht]; linarith [min_le_left ‖w - v‖ r]⟩)
  refine ⟨z, hz, ?_, ?_⟩
  · simp only at hzt; rw [hzt]; exact ht0
  · simp only at hzt; rw [hzt, ht]; linarith [min_le_right ‖w - v‖ r]

/-- **A branch lies in its arc wholly or not at all**, below the distance of the arc's far ends. -/
theorem Arc.branch_mem_of_mem {a : Arc} (ha : a.Nondegenerate) {v : ℂ} (hv : v ∈ a.carrier) {r : ℝ}
    (hends : ∀ q ∈ a.ends, q ≠ v → r ≤ ‖q - v‖) (hbig : (a.curveData v).1 * r ≤ 2 * ‖(a.curveData v).2‖)
    {σ : ℝ} (hσ : σ = 1 ∨ σ = -1)
    (h : ∃ s ∈ Ioo 0 r, branchPt v (curveGerm (a.curveData v).1 (a.curveData v).2 σ).1
      (curveGerm (a.curveData v).1 (a.curveData v).2 σ).2 s ∈ a.carrier) :
    ∀ s ∈ Ioo 0 r, branchPt v (curveGerm (a.curveData v).1 (a.curveData v).2 σ).1
      (curveGerm (a.curveData v).1 (a.curveData v).2 σ).2 s ∈ a.carrier := by
  set g := curveGerm (a.curveData v).1 (a.curveData v).2 σ with hg
  set B := branchPt v g.1 g.2 with hBdef
  have hB : Continuous B := continuous_branchPt v g.1 g.2
  have hb := Arc.curveData_ne ha hv
  have hκ0 : 0 ≤ (a.curveData v).1 := by
    rcases Arc.curveData_kappa v a with h' | h' <;> simp [h']
  have hcurve : ∀ s ∈ Ioo 0 r, B s ∈ a.curve v := fun s hs =>
    branchPt_curveGerm_mem hκ0 hb hσ hs.1.le ((mul_le_mul_of_nonneg_left hs.2.le hκ0).trans hbig)
  set U := {s : ℝ | ∀ᶠ s' in 𝓝 s, B s' ∈ a.carrier} with hU
  set V := {s : ℝ | B s ∉ a.carrier} with hV
  have hUo : IsOpen U := isOpen_setOf_eventually_nhds
  have hVo : IsOpen V := a.isClosed_carrier.isOpen_compl.preimage hB
  have hUV : Disjoint U V := Set.disjoint_left.mpr fun s hs hs' => hs' hs.self_of_nhds
  have hcov : Ioo 0 r ⊆ U ∪ V := by
    intro s hs
    by_cases hBs : B s ∈ a.carrier
    · left
      have hnorm : ‖B s - v‖ = s := norm_branchPt_sub v g.1 g.2 hs.1.le
      have hye : B s ∉ a.ends := by
        intro he
        have hne : B s ≠ v := by
          intro h'; rw [h', sub_self, norm_zero] at hnorm; linarith [hs.1]
        have := hends _ he hne
        rw [hnorm] at this
        linarith [hs.2]
      have ev1 := hB.continuousAt.tendsto.eventually (Arc.eventually_mem_carrier ha hv hBs hye)
      have ev2 : ∀ᶠ s' in 𝓝 s, s' ∈ Ioo 0 r := Ioo_mem_nhds hs.1 hs.2
      filter_upwards [ev1, ev2] with s' h1 h2
      exact h1 (hcurve s' h2)
    · right; exact hBs
  rcases isPreconnected_Ioo.subset_or_subset hUo hVo hUV hcov with hsub | hsub
  · intro s hs; exact (hsub hs).self_of_nhds
  · obtain ⟨s₀, hs₀, hB₀⟩ := h; exact absurd hB₀ (hsub hs₀)

variable {k : ℕ} (F : ArcMap k)

namespace ArcMap

/-- **The sector chart of `F` at `v` out to `r₀`** given by the germs `G`: the arcs in the punctured ball are the germs'
branches, and for every `r ≤ r₀` the interior points of the ball are the sectors between consecutive germs (the whole ball
when there is no germ) — open, connected, disjoint, each with the cone of its two germs' directions. -/
structure IsSectorChart {n : ℕ} (G : BranchGerms n) (v : ℂ) (r₀ : ℝ) : Prop where
  /-- The radius is positive. -/
  pos : 0 < r₀
  /-- The ball lies in the domain. -/
  subdom : ball v r₀ ⊆ F.dom
  /-- The germs are sorted counter-clockwise. -/
  sorted : G.Sorted
  /-- Each branch is a graph over the radius. -/
  curv : ∀ i, |G.κ i| * r₀ < 2
  /-- `v` lies on the arcs exactly when there is a germ. -/
  mem_Γ : v ∈ F.Γ ↔ 0 < n
  /-- The arcs in the punctured ball are the branches. -/
  branches : (F.Γ ∩ ball v r₀) \ {v} = ⋃ i, branchPt v (G.β i) (G.κ i) '' Ioo 0 r₀
  /-- With no germ, the ball is interior. -/
  empty : n = 0 → ball v r₀ ⊆ F.interiorPts
  /-- The interior points of a smaller ball are the sectors. -/
  cover : ∀ r ∈ Ioc 0 r₀, 0 < n → ball v r ∩ F.interiorPts = ⋃ i, G.sector v r i
  /-- Each sector is open. -/
  isOpen : ∀ r ∈ Ioc 0 r₀, ∀ i, IsOpen (G.sector v r i)
  /-- Each sector is connected. -/
  isPreconnected : ∀ r ∈ Ioc 0 r₀, ∀ i, IsPreconnected (G.sector v r i)
  /-- Distinct sectors are disjoint. -/
  disjoint : ∀ r ∈ Ioc 0 r₀, ∀ i j, i ≠ j → Disjoint (G.sector v r i) (G.sector v r j)
  /-- Each sector's cone at `v` is the interval of its two germs' directions. -/
  cone : ∀ r ∈ Ioc 0 r₀, ∀ i, coneAt (G.sector v r i) v = angleIcc (G.β i) (G.nextβ i)

/-- **A sector chart from its branch data**: sorted germs, each a graph over the radius, whose branches are the arcs of the
punctured ball and never meet at one distance, cut the ball's interior points into the sectors between consecutive germs. -/
theorem isSectorChart_of {n : ℕ} (G : BranchGerms n) {v : ℂ} {r₀ : ℝ} (pos : 0 < r₀)
    (subdom : ball v r₀ ⊆ F.dom) (sorted : G.Sorted) (curv : ∀ i, |G.κ i| * r₀ < 2)
    (mem_Γ : v ∈ F.Γ ↔ 0 < n)
    (branches : (F.Γ ∩ ball v r₀) \ {v} = ⋃ i, branchPt v (G.β i) (G.κ i) '' Ioo 0 r₀)
    (hdisj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 r₀, e (G.dir i s) ≠ e (G.dir j s)) :
    F.IsSectorChart G v r₀ := by
  have hπ := Real.pi_pos
  have hord := G.dir_lt_nextDir sorted curv hdisj
  have hM := sorted.mono
  have hΓ : ∀ z ∈ ball v r₀, z ≠ v → z ∈ ⋃ a ∈ F.arcs, a.carrier →
      ∃ j, z = branchPt v (G.β j) (G.κ j) ‖z - v‖ := by
    intro z hz hzv hza
    have hmem : z ∈ (F.Γ ∩ ball v r₀) \ {v} := ⟨⟨⟨subdom hz, hza⟩, hz⟩, hzv⟩
    rw [branches] at hmem
    obtain ⟨j, hj⟩ := mem_iUnion.mp hmem
    obtain ⟨s, hs, hsz⟩ := hj
    refine ⟨j, ?_⟩
    rw [← hsz, norm_branchPt_sub _ _ _ hs.1.le]
  refine ⟨pos, subdom, sorted, curv, mem_Γ, branches, ?_, ?_, fun r _ i => G.isOpen_sector r i,
    fun r hr i => G.isPreconnected_sector hord hr.2 i, fun r hr i j hij => G.sector_disjoint hord hr.2 hij,
    fun r hr i => G.coneAt_sector hM hord hr i⟩
  · intro hn z hz
    refine ⟨subdom hz, fun hza => ?_⟩
    by_cases hzv : z = v
    · subst hzv; exact absurd (mem_Γ.mp ⟨subdom hz, hza⟩) (by omega)
    · obtain ⟨j, -⟩ := hΓ z hz hzv hza
      exact absurd j.isLt (by omega)
  · intro r hr hn
    ext z
    constructor
    · rintro ⟨hz, hzI⟩
      have hzv : z ≠ v := by
        rintro rfl; exact hzI.2 (mem_Γ.mpr hn).2
      set s := ‖z - v‖ with hsdef
      have hs : s ∈ Ioo 0 r := ⟨norm_pos_iff.mpr (sub_ne_zero.mpr hzv), by rw [mem_ball, dist_eq_norm] at hz; exact hz⟩
      have hsr : s ∈ Ioo 0 r₀ := ⟨hs.1, hs.2.trans_le hr.2⟩
      have hzpol : z = v + (s : ℂ) * e (arg (z - v)) := by
        have := eq_polar_arg (z - v); rw [hsdef]; linear_combination this
      rcases (G.atRadius s).exists_angle hn (arg (z - v)) with ⟨j, m, hj⟩ | ⟨j, hj⟩
      · exfalso
        apply hzI.2
        have hzb : branchPt v (G.β j) (G.κ j) s = z := by
          rw [branchPt_eq, hzpol, hj, e_add_int_mul]; rfl
        have hmem : z ∈ ⋃ i, branchPt v (G.β i) (G.κ i) '' Ioo 0 r₀ := mem_iUnion.mpr ⟨j, s, hsr, hzb⟩
        rw [← branches] at hmem
        exact hmem.1.1.2
      · obtain ⟨m, hm⟩ := mem_iUnion.mp hj
        rw [BranchGerms.atRadius_nextβ] at hm
        have hm' : G.dir j s + 2 * π * m < arg (z - v) ∧ arg (z - v) < G.nextDir j s + 2 * π * m := hm
        refine mem_iUnion.mpr ⟨j, s, hs, arg (z - v) - 2 * π * m, ⟨?_, ?_⟩, ?_⟩
        · show G.dir j s < _; linarith [hm'.1]
        · show _ < G.nextDir j s; linarith [hm'.2]
        · rw [show arg (z - v) - 2 * π * m = arg (z - v) + 2 * π * ((-m : ℤ) : ℝ) by push_cast; ring,
            e_add_int_mul]
          exact hzpol
    · intro hz
      obtain ⟨j, hj⟩ := mem_iUnion.mp hz
      have hzball : z ∈ ball v r := G.sector_subset_ball j hj
      obtain ⟨s, hs, φ, hφ, rfl⟩ := hj
      have hφ : G.dir j s < φ ∧ φ < G.nextDir j s := hφ
      have hsr : s ∈ Ioo 0 r₀ := ⟨hs.1, hs.2.trans_le hr.2⟩
      refine ⟨hzball, subdom (ball_subset_ball hr.2 hzball), fun hza => ?_⟩
      have hzv : v + (s : ℂ) * e φ ≠ v := by
        intro h'
        have := congrArg (fun z => ‖z - v‖) h'
        simp only [add_sub_cancel_left, sub_self, norm_zero, norm_mul_e hs.1.le] at this
        linarith [hs.1]
      obtain ⟨l, hl⟩ := hΓ _ (ball_subset_ball hr.2 hzball) hzv hza
      rw [add_sub_cancel_left, norm_mul_e hs.1.le, branchPt_eq] at hl
      obtain ⟨-, he⟩ := (polar_eq_iff hs.1 hs.1).mp hl
      obtain ⟨m', hm'⟩ := e_eq_e_iff.mp he
      have hM' := G.atRadius_mono hord hsr
      apply hM'.not_mem_angleIoo j l m'
      rw [BranchGerms.atRadius_nextβ]
      refine Ioo_subset_angleIoo _ _ ⟨?_, ?_⟩
      · show G.dir j s < G.dir l s + 2 * π * m'
        have : G.dir l s = germDir (G.β l) (G.κ l) s := rfl
        rw [this]; linarith [hφ.1]
      · show G.dir l s + 2 * π * m' < G.nextDir j s
        have : G.dir l s = germDir (G.β l) (G.κ l) s := rfl
        rw [this]; linarith [hφ.2]

end ArcMap

/-- **`localSectors`, with its disjointness** (FS131-I4k; inventory item 244 (b)): every point of the domain has a sector chart
whose distinct germs' branches never meet at one distance below the chart's radius. The germs are those of the finitely many arcs
through `v` in a good ball (`GoodAt`), each line or circle contributing the branches it covers; the radius stays below every far
end of those arcs and below every distance at which two distinct germs' branches meet. `IsSectorChart` does not carry the
disjointness; consumers that need an arc of `Γ` near a branch point to lie on that branch alone read it here. -/
theorem localSectors_disj {v : ℂ} (hv : v ∈ F.dom) : ∃ r₀, ∃ n, ∃ G : BranchGerms n, F.IsSectorChart G v r₀ ∧
    ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 r₀, e (G.dir i s) ≠ e (G.dir j s) := by
  have hπ := Real.pi_pos
  obtain ⟨ρ₀, hG⟩ := F.exists_goodAt hv
  set 𝒜 := {a | a ∈ F.arcs ∧ (a.carrier ∩ ball v ρ₀).Nonempty} with h𝒜def
  have h𝒜 : 𝒜.Finite := hG.fin
  set C : Set (ℝ × ℝ) := ⋃ a ∈ 𝒜, ({curveGerm (a.curveData v).1 (a.curveData v).2 1,
    curveGerm (a.curveData v).1 (a.curveData v).2 (-1)} : Set (ℝ × ℝ)) with hCdef
  have hC : C.Finite := h𝒜.biUnion fun a _ => Set.toFinite _
  have hCmem : ∀ g ∈ C, ∃ a ∈ 𝒜, ∃ σ : ℝ, (σ = 1 ∨ σ = -1) ∧
      g = curveGerm (a.curveData v).1 (a.curveData v).2 σ := by
    intro g hg
    obtain ⟨a, ha, hga⟩ := mem_iUnion₂.mp hg
    rcases hga with h | h
    · exact ⟨a, ha, 1, Or.inl rfl, h⟩
    · exact ⟨a, ha, -1, Or.inr rfl, h⟩
  have hCof : ∀ a ∈ 𝒜, ∀ σ : ℝ, (σ = 1 ∨ σ = -1) → curveGerm (a.curveData v).1 (a.curveData v).2 σ ∈ C := by
    intro a ha σ hσ
    refine mem_iUnion₂.mpr ⟨a, ha, ?_⟩
    rcases hσ with rfl | rfl
    · exact Or.inl rfl
    · exact Or.inr rfl
  have hCfst : ∀ g ∈ C, g.1 ∈ Ico 0 (2 * π) := by
    intro g hg; obtain ⟨a, -, σ, -, rfl⟩ := hCmem g hg; exact curveGerm_fst_mem _ _ _
  -- the radius
  have ev1 : ∀ᶠ r in 𝓝[>] (0 : ℝ), r < ρ₀ := by
    filter_upwards [Ioo_mem_nhdsGT hG.pos] with r hr using hr.2
  have ev2 : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ a ∈ 𝒜, ∀ q ∈ a.ends, q ≠ v → r ≤ ‖q - v‖ := by
    refine (eventually_all_finite h𝒜).mpr fun a _ => (eventually_all_finite a.finite_ends).mpr fun q _ => ?_
    by_cases hq : q = v
    · exact Filter.Eventually.of_forall fun _ h => absurd hq h
    · have hpos : 0 < ‖q - v‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hq)
      filter_upwards [Ioo_mem_nhdsGT hpos] with r hr _ using hr.2.le
  have ev3 : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ g ∈ C, ∀ g' ∈ C, g ≠ g' → ∀ s ∈ Ioo 0 r,
      e (germDir g.1 g.2 s) ≠ e (germDir g'.1 g'.2 s) := by
    refine (eventually_all_finite hC).mpr fun g hg => (eventually_all_finite hC).mpr fun g' hg' => ?_
    by_cases hgg : g = g'
    · exact Filter.Eventually.of_forall fun _ h => absurd hgg h
    · obtain ⟨ε, hε, hne⟩ := exists_germDir_ne (hCfst g hg) (hCfst g' hg') hgg
      filter_upwards [Ioo_mem_nhdsGT hε] with r hr _ s hs using hne s ⟨hs.1, hs.2.trans hr.2⟩
  have ev0 : ∀ᶠ r in 𝓝[>] (0 : ℝ), r ∈ Ioi 0 := eventually_mem_nhdsWithin
  obtain ⟨r₀, hr₀, hr₁, hr₂, hr₃⟩ := (ev0.and (ev1.and (ev2.and ev3))).exists
  have hr₀ : 0 < r₀ := hr₀
  have hsub : ball v r₀ ⊆ F.dom := (ball_subset_ball hr₁.le).trans hG.subdom
  -- the arcs through `v`
  have harc : ∀ a ∈ 𝒜, a.Nondegenerate ∧ v ∈ a.carrier ∧ (a.curveData v).2 ≠ 0 ∧ 0 ≤ (a.curveData v).1 ∧
      (a.curveData v).1 * r₀ < 2 * ‖(a.curveData v).2‖ := by
    intro a ha
    have hnd := F.nondegenerate a ha.1
    have hva := hG.through a ha.1 ha.2
    have hb := Arc.curveData_ne hnd hva
    refine ⟨hnd, hva, hb, ?_, ?_⟩
    · rcases Arc.curveData_kappa v a with h | h <;> simp [h]
    · rcases Arc.curveData_kappa v a with h | h
      · rw [h, zero_mul]; exact mul_pos two_pos (norm_pos_iff.mpr hb)
      · rw [h, one_mul]; exact hr₁.trans (hG.big a ha.1 ha.2 h)
  -- the germs
  set G₀ : Set (ℝ × ℝ) := {g ∈ C | ∀ s ∈ Ioo 0 r₀, branchPt v g.1 g.2 s ∈ F.Γ} with hG₀def
  have hG₀ : G₀.Finite := hC.subset (sep_subset _ _)
  -- a point of an arc near `v` lies on a germ
  have hfound : ∀ a ∈ 𝒜, ∀ z ∈ a.carrier, z ∈ ball v r₀ → z ≠ v →
      ∃ g ∈ G₀, z = branchPt v g.1 g.2 ‖z - v‖ := by
    intro a ha z hza hz hzv
    obtain ⟨hnd, hva, hb, hκ0, hbig⟩ := harc a ha
    have hzr : ‖z - v‖ < r₀ := by rw [mem_ball, dist_eq_norm] at hz; exact hz
    have hzpos : 0 < ‖z - v‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hzv)
    obtain ⟨σ, hσ, hzeq⟩ := exists_eq_branchPt_curveGerm hκ0 hb (Arc.carrier_subset_curve hva hza) hzv
      (lt_of_le_of_lt (mul_le_mul_of_nonneg_left hzr.le hκ0) hbig)
    have hall := Arc.branch_mem_of_mem hnd hva (fun q hq hqv => hr₂ a ha q hq hqv) hbig.le hσ
      ⟨‖z - v‖, ⟨hzpos, hzr⟩, hzeq ▸ hza⟩
    refine ⟨_, ⟨hCof a ha σ hσ, fun s hs => ?_⟩, hzeq⟩
    refine ⟨hsub ?_, mem_iUnion₂.mpr ⟨a, ha.1, hall s hs⟩⟩
    rw [mem_ball, dist_eq_norm, norm_branchPt_sub _ _ _ hs.1.le]; exact hs.2
  -- sort the germs
  set S : Finset (Lex (ℝ × ℝ)) := hG₀.toFinset.map toLex.toEmbedding with hSdef
  set f := S.orderEmbOfFin rfl with hfdef
  set G : BranchGerms S.card := ⟨fun i => (ofLex (f i)).1, fun i => (ofLex (f i)).2⟩ with hGdef
  have hfG₀ : ∀ i, ofLex (f i) ∈ G₀ := by
    intro i
    have h1 : f i ∈ S := S.orderEmbOfFin_mem rfl i
    obtain ⟨g, hg, hgf⟩ := Finset.mem_map.mp h1
    rw [← hgf]
    exact (Set.Finite.mem_toFinset hG₀).mp hg
  have hG₀f : ∀ g ∈ G₀, ∃ i, ofLex (f i) = g := by
    intro g hg
    have h1 : toLex g ∈ (S : Set (Lex (ℝ × ℝ))) := by
      rw [hSdef, Finset.coe_map]
      exact ⟨g, (Set.Finite.mem_toFinset hG₀).mpr hg, rfl⟩
    rw [← Finset.range_orderEmbOfFin S rfl] at h1
    obtain ⟨i, hi⟩ := h1
    exact ⟨i, by rw [← hfdef] at hi; rw [hi]; rfl⟩
  have hfC : ∀ i, ofLex (f i) ∈ C := fun i => (hfG₀ i).1
  have hdisj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 r₀, e (G.dir i s) ≠ e (G.dir j s) := by
    -- distinct germs never meet at one distance
    intro i j hij s hs
    have hne : ofLex (f i) ≠ ofLex (f j) := fun h => hij (f.injective (by simpa using h))
    exact hr₃ _ (hfC i) _ (hfC j) hne s ⟨hs.1, hs.2.trans_le le_rfl⟩
  refine ⟨r₀, S.card, G, F.isSectorChart_of G hr₀ hsub ?_ ?_ ?_ ?_ hdisj, hdisj⟩
  · -- sorted
    have hlex : ∀ i j : Fin S.card, i < j → G.β i < G.β j ∨ (G.β i = G.β j ∧ G.κ i < G.κ j) :=
      fun i j hij => Prod.Lex.lt_iff.mp (f.strictMono hij)
    refine ⟨hlex, fun i => ?_⟩
    unfold BranchGerms.nextβ BranchGerms.nextκ
    split_ifs with h
    · exact hlex i ⟨i.val + 1, h⟩ (Fin.lt_def.mpr (by simp))
    · left
      have h1 := hCfst _ (hfC i)
      have h0 := hCfst _ (hfC ⟨0, i.pos⟩)
      show (ofLex (f i)).1 < (ofLex (f ⟨0, i.pos⟩)).1 + 2 * π
      linarith [h1.2, h0.1]
  · -- curvature
    intro i
    obtain ⟨a, ha, σ, hσ, hg⟩ := hCmem _ (hfC i)
    obtain ⟨-, -, hb, hκ0, hbig⟩ := harc a ha
    have hbn : 0 < ‖(a.curveData v).2‖ := norm_pos_iff.mpr hb
    show |(ofLex (f i)).2| * r₀ < 2
    rw [hg]
    simp only [curveGerm]
    have hσa : |σ| = 1 := by rcases hσ with rfl | rfl <;> simp
    rw [abs_div, abs_mul, hσa, one_mul, abs_of_nonneg hκ0, abs_of_pos hbn, div_mul_eq_mul_div,
      div_lt_iff₀ hbn]
    exact hbig
  · -- `v` on the arcs
    constructor
    · rintro ⟨-, hva⟩
      obtain ⟨a, haF, hva⟩ := mem_iUnion₂.mp hva
      have ha : a ∈ 𝒜 := ⟨haF, v, hva, mem_ball_self hG.pos⟩
      obtain ⟨z, hz, hz0, hzr⟩ := Arc.exists_near (F.nondegenerate a haF) hva hr₀
      have hzv : z ≠ v := fun h => by rw [h, sub_self, norm_zero] at hz0; exact lt_irrefl _ hz0
      obtain ⟨g, hg, -⟩ := hfound a ha z hz (by rw [mem_ball, dist_eq_norm]; exact hzr) hzv
      obtain ⟨i, -⟩ := hG₀f g hg
      exact Fin.pos i
    · intro hn
      obtain ⟨a, ha, -, -, -⟩ := hCmem _ (hfC ⟨0, hn⟩)
      exact ⟨hv, mem_iUnion₂.mpr ⟨a, ha.1, hG.through a ha.1 ha.2⟩⟩
  · -- the branches
    ext z
    constructor
    · rintro ⟨⟨⟨hzd, hza⟩, hz⟩, hzv⟩
      obtain ⟨a, haF, hza⟩ := mem_iUnion₂.mp hza
      have ha : a ∈ 𝒜 := ⟨haF, z, hza, ball_subset_ball hr₁.le hz⟩
      obtain ⟨g, hg, hzg⟩ := hfound a ha z hza hz hzv
      obtain ⟨i, hi⟩ := hG₀f g hg
      refine mem_iUnion.mpr ⟨i, ‖z - v‖, ⟨norm_pos_iff.mpr (sub_ne_zero.mpr hzv), ?_⟩, ?_⟩
      · rw [mem_ball, dist_eq_norm] at hz; exact hz
      · show branchPt v (ofLex (f i)).1 (ofLex (f i)).2 ‖z - v‖ = z
        rw [hi]; exact hzg.symm
    · intro hz
      obtain ⟨i, s, hs, rfl⟩ := mem_iUnion.mp hz
      have hΓ := (hfG₀ i).2 s hs
      refine ⟨⟨hΓ, ?_⟩, ?_⟩
      · rw [mem_ball, dist_eq_norm, norm_branchPt_sub _ _ _ hs.1.le]; exact hs.2
      · intro h
        have := norm_branchPt_sub v (G.β i) (G.κ i) hs.1.le
        rw [mem_singleton_iff.mp h, sub_self, norm_zero] at this
        exact hs.1.ne this

/-- **`localSectors`**: every point of the domain has a sector chart (`localSectors_disj` without its disjointness clause). -/
theorem localSectors {v : ℂ} (hv : v ∈ F.dom) : ∃ r₀, ∃ n, ∃ G : BranchGerms n, F.IsSectorChart G v r₀ := by
  obtain ⟨r₀, n, G, hC, -⟩ := localSectors_disj F hv
  exact ⟨r₀, n, G, hC⟩

/-! ### One sector per Jordan tile, and the separated interval -/

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- Two tiles sharing a point are one tile. -/
theorem IsTile.eq_of_mem {T T' : Set ℂ} (hT : F.IsTile T) (hT' : F.IsTile T') {w : ℂ} (hw : w ∈ T) (hw' : w ∈ T') :
    T = T' := by
  obtain ⟨x, -, rfl⟩ := hT
  obtain ⟨x', -, rfl⟩ := hT'
  exact (connectedComponentIn_eq hw).trans (connectedComponentIn_eq hw').symm

/-- Each sector of a chart lies in the interior points. -/
theorem IsSectorChart.sector_subset_interiorPts {n : ℕ} {G : BranchGerms n} {x : ℂ} {r₀ : ℝ}
    (hC : F.IsSectorChart G x r₀) (hn : 0 < n) {r : ℝ} (hr : r ∈ Ioc 0 r₀) (i : Fin n) :
    G.sector x r i ⊆ F.interiorPts := by
  intro z hz
  have h : z ∈ ball x r ∩ F.interiorPts := by rw [hC.cover r hr hn]; exact mem_iUnion.mpr ⟨i, hz⟩
  exact h.2

/-- Each sector of a chart is nonempty: its cone holds its first germ's direction. -/
theorem IsSectorChart.sector_nonempty {n : ℕ} {G : BranchGerms n} {x : ℂ} {r₀ : ℝ}
    (hC : F.IsSectorChart G x r₀) {r : ℝ} (hr : r ∈ Ioc 0 r₀) (i : Fin n) : (G.sector x r i).Nonempty := by
  have hβ : G.β i ∈ coneAt (G.sector x r i) x := by
    rw [hC.cone r hr i]; exact Icc_subset_angleIcc _ _ ⟨le_rfl, hC.sorted.mono i⟩
  obtain ⟨z, hz, -⟩ := hβ 1 one_pos
  exact ⟨z, hz⟩

/-- **One sector per Jordan tile** (FS131-E2-ONESECT, `plans/FS131-E2-derivation.md` § 2.3): in a sector chart at `x` with a
germ, a tile that is a Jordan domain with `x` in its closure meets the chart's ball in exactly one sector. The Jordan chart
(`IsJordanDomain.local_connected`) puts the tile's part of a small ball inside one connected piece of it, which lies in one
sector; a second sector of the tile would reach into that small ball. -/
theorem IsSectorChart.exists_tile_inter_ball {n : ℕ} {G : BranchGerms n} {x : ℂ} {r₀ : ℝ}
    (hC : F.IsSectorChart G x r₀) (hn : 0 < n) {T : Set ℂ} (hT : F.IsTile T) (hJ : IsJordanDomain T)
    (hx : x ∈ closure T) : ∃ i, T ∩ ball x r₀ = G.sector x r₀ i := by
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  have hTsub : T ∩ ball x r₀ ⊆ ⋃ i, G.sector x r₀ i := by
    rintro z ⟨hzT, hzb⟩
    rw [← hC.cover r₀ hr₀ hn]
    exact ⟨hzb, hT.subset_interiorPts hzT⟩
  obtain ⟨r', hr', K, hKT, hKb, hKpre, hKsub⟩ := hJ.local_connected hx hC.pos
  obtain ⟨z₀, hz₀T, hz₀d⟩ := Metric.mem_closure_iff.mp hx r' hr'
  have hz₀ : z₀ ∈ K := hKsub ⟨hz₀T, by rw [mem_ball, dist_comm]; exact hz₀d⟩
  obtain ⟨i₀, hi₀⟩ := mem_iUnion.mp (hTsub ⟨hKT hz₀, hKb hz₀⟩)
  have hKi : K ⊆ G.sector x r₀ i₀ := by
    refine hKpre.subset_left_of_subset_union (hC.isOpen r₀ hr₀ i₀)
      (isOpen_iUnion fun j => isOpen_iUnion fun _ : j ≠ i₀ => hC.isOpen r₀ hr₀ j) ?_ ?_ ⟨z₀, hz₀, hi₀⟩
    · rw [Set.disjoint_iUnion_right]
      intro j
      rw [Set.disjoint_iUnion_right]
      intro hj
      exact hC.disjoint r₀ hr₀ i₀ j (Ne.symm hj)
    · intro z hz
      obtain ⟨j, hj⟩ := mem_iUnion.mp (hTsub ⟨hKT hz, hKb hz⟩)
      by_cases hji : j = i₀
      · left; rw [← hji]; exact hj
      · right; exact mem_iUnion.mpr ⟨j, mem_iUnion.mpr ⟨hji, hj⟩⟩
  have hsecT : ∀ j, (G.sector x r₀ j ∩ T).Nonempty → G.sector x r₀ j ⊆ T := by
    rintro j ⟨w, hwj, hwT⟩
    exact hT.subset_of_preconnected (hC.isPreconnected r₀ hr₀ j) (hC.sector_subset_interiorPts hn hr₀ j) hwj hwT
  have hi₀T : G.sector x r₀ i₀ ⊆ T := hsecT i₀ ⟨z₀, hi₀, hKT hz₀⟩
  refine ⟨i₀, Subset.antisymm ?_ (subset_inter hi₀T (G.sector_subset_ball i₀))⟩
  rintro z ⟨hzT, hzb⟩
  obtain ⟨j, hj⟩ := mem_iUnion.mp (hTsub ⟨hzT, hzb⟩)
  by_cases hji : j = i₀
  · rw [← hji]; exact hj
  · exfalso
    have hjT : G.sector x r₀ j ⊆ T := hsecT j ⟨z, hj, hzT⟩
    have hr'' : min r' r₀ ∈ Ioc 0 r₀ := ⟨lt_min hr' hC.pos, min_le_right _ _⟩
    obtain ⟨w, hw⟩ := hC.sector_nonempty hr'' j
    have hw1 : w ∈ G.sector x r₀ j := G.sector_mono (min_le_right _ _) j hw
    have hw2 : w ∈ G.sector x r₀ i₀ :=
      hKi (hKsub ⟨hjT hw1, ball_subset_ball (min_le_left _ _) (G.sector_subset_ball j hw)⟩)
    exact Set.disjoint_left.mp (hC.disjoint r₀ hr₀ j i₀ hji) hw1 hw2

/-- **The separated interval** (FS131-E2-SEP; `plans/FS131-E2-derivation.md` § 2.7): in a simple map, a tile's cone at a
point of its closure is one closed interval whose open part meets no other tile's cone at that point — the tile is one
sector, between consecutive branches (`IsSectorChart.exists_tile_inter_ball`), and a cusp of another tile is a sector of its
own, pointing into no other sector. -/
theorem Simple.coneAt_eq_angleIcc_sep (hS : F.Simple) {T : Set ℂ} (hT : F.IsTile T) {x : ℂ} (hxd : x ∈ F.dom)
    (hx : x ∈ closure T) :
    ∃ β₁ β₂, β₁ ≤ β₂ ∧ β₂ ≤ β₁ + 2 * π ∧ coneAt T x = angleIcc β₁ β₂ ∧
      ∀ T', F.IsTile T' → T' ≠ T → x ∈ closure T' → Disjoint (coneAt T' x) (angleIoo β₁ β₂) := by
  have hπ := Real.pi_pos
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hxd
  have hloc : ∀ S : Set ℂ, coneAt S x = coneAt (S ∩ ball x r₀) x := fun S =>
    Subset.antisymm (fun β hβ => coneAt_inter_ball hC.pos hβ) (coneAt_mono inter_subset_left x)
  rcases Nat.eq_zero_or_pos n with hn | hn
  · have hball : ball x r₀ ⊆ T := by
      obtain ⟨z, hzT, hzd⟩ := Metric.mem_closure_iff.mp hx r₀ hC.pos
      exact hT.subset_of_preconnected (convex_ball x r₀).isPreconnected (hC.empty hn)
        (by rw [mem_ball, dist_comm]; exact hzd) hzT
    have hxT : x ∈ T := hball (mem_ball_self hC.pos)
    refine ⟨0, 2 * π, by positivity, by linarith, ?_, ?_⟩
    · ext β
      simp only [mem_coneAt_of_mem_isOpen hT.isOpen hxT β, true_iff]
      obtain ⟨m, hm1, hm2⟩ := exists_shift_Ico 0 β
      exact mem_iUnion.mpr ⟨-m, by push_cast; constructor <;> linarith⟩
    · intro T' hT' hne hx'
      exfalso
      obtain ⟨z, hzT', hzd⟩ := Metric.mem_closure_iff.mp hx' r₀ hC.pos
      exact hne (hT'.eq_of_mem hT hzT' (hball (by rw [mem_ball, dist_comm]; exact hzd)))
  · obtain ⟨i, hi⟩ := hC.exists_tile_inter_ball hn hT (hS.1 T hT) hx
    have hM := hC.sorted.mono
    refine ⟨G.β i, G.nextβ i, hM i, hM.nextβ_le_add i, ?_, ?_⟩
    · rw [hloc, hi, hC.cone r₀ ⟨hC.pos, le_rfl⟩ i]
    · intro T' hT' hne hx'
      obtain ⟨j, hj⟩ := hC.exists_tile_inter_ball hn hT' (hS.1 T' hT') hx'
      have hji : j ≠ i := by
        rintro rfl
        obtain ⟨w, hw⟩ := hC.sector_nonempty ⟨hC.pos, le_rfl⟩ j
        have hwT : w ∈ T := (hi.symm ▸ hw : w ∈ T ∩ ball x r₀).1
        have hwT' : w ∈ T' := (hj.symm ▸ hw : w ∈ T' ∩ ball x r₀).1
        exact hne (hT'.eq_of_mem hT hwT' hwT)
      rw [hloc, hj, hC.cone r₀ ⟨hC.pos, le_rfl⟩ j]
      exact hM.disjoint hji.symm

end ArcMap

/-! ### Spec examples -/

/-- The straight germ in direction `0` reaches `1` at distance `1`. -/
example : branchPt 0 0 0 1 = 1 := by simp [branchPt, e]

/-- The germ in direction `0` of curvature `1` bends left: at distance `1` it lies on the unit circle about `i`. -/
example : ‖branchPt 0 0 1 1 - I‖ = 1 := by
  have h : Real.arcsin (1 * 1 / 2) = π / 6 := by
    rw [show (1 : ℝ) * 1 / 2 = Real.sin (π / 6) by rw [Real.sin_pi_div_six]; norm_num]
    exact Real.arcsin_sin (by linarith [Real.pi_pos]) (by linarith [Real.pi_pos])
  rw [branchPt, zero_add, zero_add, h, Complex.ofReal_one, one_mul, e_eq, Real.cos_pi_div_six,
    Real.sin_pi_div_six, ← sq_eq_sq₀ (norm_nonneg _) zero_le_one, ← Complex.normSq_eq_norm_sq,
    Complex.normSq_apply]
  simp only [Complex.sub_re, Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.ofReal_im, Complex.I_re,
    Complex.I_im, Complex.sub_im, Complex.add_im, Complex.mul_im]
  nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ 3 by norm_num)]

/-- The upper half of the unit disc is the sector between the directions `0` and `π`. -/
example : (I / 2 : ℂ) ∈ sectorBetween 0 0 0 π 0 1 := by
  refine ⟨1 / 2, ⟨by norm_num, by norm_num⟩, π / 2, ⟨?_, ?_⟩, ?_⟩
  · simp; linarith [Real.pi_pos]
  · simp; linarith [Real.pi_pos]
  · rw [e_pi_div_two]; push_cast; ring

/-- **Adversary**: the lower half is not. -/
example : -(I / 2 : ℂ) ∉ sectorBetween 0 0 0 π 0 1 := by
  rintro ⟨s, hs, φ, hφ, h⟩
  simp only [zero_mul, zero_div, Real.arcsin_zero, add_zero, mem_Ioo] at hφ
  have him := congrArg Complex.im h
  simp only [Complex.neg_im, Complex.div_ofNat_im, Complex.I_im, zero_add, Complex.mul_im, Complex.ofReal_re,
    im_e, Complex.ofReal_im, re_e, zero_mul, add_zero] at him
  have := Real.sin_pos_of_pos_of_lt_pi hφ.1 hφ.2
  nlinarith [hs.1]

/-- The germ after the last is the first, one turn on. -/
example : (⟨![0, π], ![1, 2]⟩ : BranchGerms 2).nextβ 1 = 2 * π ∧
    (⟨![0, π], ![1, 2]⟩ : BranchGerms 2).nextβ 0 = π ∧ (⟨![0, π], ![1, 2]⟩ : BranchGerms 2).nextκ 1 = 1 := by
  simp [BranchGerms.nextβ, BranchGerms.nextκ]

/-- Two opposite rays are sorted. -/
example : (⟨![0, π], ![0, 0]⟩ : BranchGerms 2).Sorted := by
  refine ⟨fun i j hij => ?_, fun i => ?_⟩
  · fin_cases i <;> fin_cases j <;> simp_all [Real.pi_pos]
  · fin_cases i <;> simp [BranchGerms.nextβ, Real.pi_pos]

/-- A ray and a circle tangent to it at `v` are sorted by curvature: the circle bending left comes second. -/
example : (⟨![0, 0], ![0, 1]⟩ : BranchGerms 2).Sorted := by
  refine ⟨fun i j hij => ?_, fun i => ?_⟩
  · fin_cases i <;> fin_cases j <;> simp_all
  · fin_cases i <;> simp [BranchGerms.nextβ, BranchGerms.nextκ, Real.pi_pos]

/-- **Adversary**: the same pair in the other order is not sorted. -/
example : ¬ (⟨![0, 0], ![1, 0]⟩ : BranchGerms 2).Sorted := by
  intro h
  have := h.1 0 1 (by decide)
  norm_num at this

/-- The direction of a germ of curvature `2` at distance `1` is a quarter turn on. -/
example : germDir 0 2 1 = π / 2 := by simp [germDir]

/-- The circle about `v + i` leaves `v` in direction `0` with curvature `1`. -/
example : curveGerm 1 I 1 = (0, 1) := by
  have h0 : toIcoMod Real.two_pi_pos 0 (0 : ℝ) = 0 :=
    (toIcoMod_eq_self _).mpr ⟨le_rfl, by linarith [Real.pi_pos]⟩
  simp only [curveGerm, Complex.arg_I, one_mul, sub_self, Complex.norm_I, div_one, h0]

/-- The end points of a segment. -/
example : (Arc.seg 0 1).ends = {0, 1} := rfl

/-- The germ after the last is the first; the germs' directions at a distance; consecutive directions weakly increase. -/
example : BranchGerms.next (n := 2) 1 = 0 ∧ BranchGerms.next (n := 2) 0 = 1 ∧
    ((⟨![0, π], ![0, 0]⟩ : BranchGerms 2).atRadius 1).β 1 = π ∧
    (⟨![0, π], ![0, 0]⟩ : BranchGerms 2).dir 1 1 = π ∧ (⟨![0, π], ![0, 0]⟩ : BranchGerms 2).Mono := by
  refine ⟨rfl, rfl, by simp [BranchGerms.atRadius, BranchGerms.dir, germDir],
    by simp [BranchGerms.dir, germDir], fun i => ?_⟩
  fin_cases i <;> simp [BranchGerms.nextβ, Real.pi_pos.le]
  linarith [Real.pi_pos]

/-- **Inhabitant** of `ArcMap.IsSectorChart` with a germ: `halfDisc` at the origin, which lies on its segment. -/
theorem halfDisc_sectorChart : ∃ r₀ n, ∃ G : BranchGerms n, halfDisc.IsSectorChart G 0 r₀ ∧ 0 < n := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors halfDisc (show (0 : ℂ) ∈ halfDisc.dom by
    show (0 : ℂ) ∈ ball 0 (1 / 3); simp)
  refine ⟨r₀, n, G, hC, hC.mem_Γ.mp ⟨by show (0 : ℂ) ∈ ball 0 (1 / 3); simp, ?_⟩⟩
  rw [halfDisc_arcs_union]
  exact mem_segment_of_im_eq_zero (by simp) (by simp)

end LocalSectors

end HadwigerNelson.Plane
