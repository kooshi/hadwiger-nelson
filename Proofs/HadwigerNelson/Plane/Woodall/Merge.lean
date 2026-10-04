import Proofs.HadwigerNelson.Plane.Woodall.NoFourFive

/-!
# Woodall's step 3, localized: finitely many merges on a ball (FS131-E3's E3-W, E3-NICE, E3-BALL)

FS131-W3's skeleton (`plans/FS131-W-kernel-plan.md` § 14) for `exists_woodallMerged`, the modification Woodall's chain reads
(`plans/FS131-E3-derivation.md` §§ 3.2–3.4): every valid arc map of the plane has a valid arc map of the plane, Condition 5 kept, in which
every point of `closedBall 0 R` of three or more colours is `NiceAt`.

* **Recolouring** (`ArcMap.recolour`): a set `W` whose frontier lies on finitely many new arcs is given one colour; nothing else moves. Its
  validity is a statement about `W` alone (`recolour_valid`), its Condition 5 one about the new arcs (`recolour_condition5`), and off
  `closure W` and the new arcs the regions are unchanged (`recolour_region_diff`).
* **E3-W** (`clear_wedge`): two open ray segments in the closure of an open set `S` with null unit pairs, less than `π` apart, clear the wedge
  between them of `S`'s unit distance up to radius `r₁ cos(α/2)/2` (the sagitta). E3's hypothesis "`ω(v)` misses `S`" is not needed: the
  segments put `v` in `closure S`, and wave 1's `dist_ne_one_of_mem_of_mem_closure` gives it.
* **The merge at a wedge** (`wedgeMerge`, `wedgeMerge_valid`, `wedgeMerge_condition5`, `wedgeMerge_region_diff`): the recolouring of the open
  annular sector `annSector v 0 ρ d₁ d₂` with `c`, bounded by two segments and an arc of radius `ρ`.
* **Locality** (`coloursAt_congr`, `niceAt_congr`): the colours at a point and `NiceAt` depend only on the regions near it.
* **The local data at a point** (`DirColourAt`): finitely many exceptional directions, off which a thin open cone lies in one colour class.
  Wave 3's wedge lemma (`GoodAt.exists_wedge`) gives it at every point of the domain (`exists_dirColourAt`); the `NiceAt` picture is built from
  it (`niceAt_of_dirColourAt`); in a good ball only the centre carries three colours (`GoodAt.ncard_coloursAt_le_two`), so three-colour points
  are finite on compact sets (`finite_three_le_coloursAt`).
* **E3-NICE** (`exists_merge_at`): merging at one point until it, and every new point of three colours near it, is `NiceAt` — the local data
  updated by each merge (`dirColourAt_wedgeMerge`), the crossings `NiceAt` (`wedgeMerge_niceAt`).
* **E3-BALL** (`exists_woodallMerged`): finitely many such merges on `closedBall 0 R`.

No statement here reads `localSectors` (FS131-I3i): wave 3's landed `GoodAt` engine gives every local fact the merge needs (§ 14.3).

**Inhabitants.** `recolour`, `wedgeMerge` and `DirColourAt` are defined for any arc map; the theorems over a valid map of the plane with any
number of colours are inhabited by `sevenBrickMap` (`sevenBrickMap_valid`, `sevenBrickMap_isPlaneMap`, `Plane/SVMap`); `DirColourAt` has its spec
example on the one-colour plane below; `clear_wedge` is region-only (any open set with null unit pairs and two such segments: E3's model, a
two-sector colour class of diameter below `1`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- `φ` is off the finitely many directions `D`, mod `2π`. -/
def OffDirs (D : Finset ℝ) (φ : ℝ) : Prop := ∀ δ ∈ D, ∀ m : ℤ, φ ≠ δ + 2 * π * m

/-- `OffDirs` is `2π`-periodic. -/
theorem offDirs_add_int {D : Finset ℝ} {φ : ℝ} (m : ℤ) : OffDirs D (φ + 2 * π * m) ↔ OffDirs D φ := by
  constructor
  · intro h δ hδ n hn
    exact h δ hδ (n + m) (by rw [hn]; push_cast; ring)
  · intro h δ hδ n hn
    exact h δ hδ (n - m) (by push_cast; linarith)

/-- **The directions of `D` are isolated mod `2π`**: near any angle every other angle is off `D`. -/
theorem exists_offDirs_punctured (D : Finset ℝ) (β : ℝ) : ∃ t > 0, ∀ φ, φ ≠ β → |φ - β| < t → OffDirs D φ := by
  classical
  have hp : (0 : ℝ) < 2 * π := by positivity
  set P : Finset ℝ := (D.image (toIcoMod hp (β - π))).erase β with hP
  obtain ⟨t, ht, hball⟩ := Metric.isOpen_iff.mp P.finite_toSet.isClosed.isOpen_compl β (by simp [hP])
  refine ⟨min t π, lt_min ht Real.pi_pos, fun φ hφ hφt δ hδ m hm => ?_⟩
  have h1 : |φ - β| < t := hφt.trans_le (min_le_left _ _)
  have h2 := abs_lt.mp (hφt.trans_le (min_le_right _ _))
  have hφP : φ ∈ P := by
    refine Finset.mem_erase.mpr ⟨hφ, Finset.mem_image.mpr ⟨δ, hδ, ?_⟩⟩
    rw [toIcoMod_eq_iff]
    refine ⟨⟨by linarith, by linarith⟩, -m, ?_⟩
    rw [hm, zsmul_eq_mul]; push_cast; ring
  exact hball (by rw [mem_ball, Real.dist_eq]; exact h1) (Finset.mem_coe.mpr hφP)

/-- Every open interval holds a direction off `D`. -/
theorem exists_offDirs_Ioo (D : Finset ℝ) {a b : ℝ} (hab : a < b) : ∃ φ ∈ Ioo a b, OffDirs D φ := by
  obtain ⟨t, ht, h⟩ := exists_offDirs_punctured D a
  have hu0 : 0 < min t (b - a) := lt_min ht (by linarith)
  have hu1 := min_le_left t (b - a)
  have hu2 := min_le_right t (b - a)
  refine ⟨a + min t (b - a) / 2, ⟨by linarith, by linarith⟩, h _ (by intro h'; linarith) ?_⟩
  rw [abs_of_pos (by linarith)]; linarith

/-- Every point of a closed interval is a limit of directions off `D` inside the open interval. -/
theorem mem_closure_offDirs_Ioo (D : Finset ℝ) {a b y : ℝ} (hab : a < b) (hy : y ∈ Icc a b) :
    y ∈ closure {φ | φ ∈ Ioo a b ∧ OffDirs D φ} := by
  obtain ⟨t, ht, h⟩ := exists_offDirs_punctured D y
  rw [Metric.mem_closure_iff]
  intro ε hε
  rcases lt_or_eq_of_le hy.2 with hyb | hyb
  · have hu0 : 0 < min (min t ε) (b - y) := lt_min (lt_min ht hε) (by linarith)
    have hu1 := min_le_left (min t ε) (b - y)
    have hu2 := min_le_right (min t ε) (b - y)
    have hu3 := min_le_left t ε
    have hu4 := min_le_right t ε
    refine ⟨y + min (min t ε) (b - y) / 2, ⟨⟨by linarith [hy.1], by linarith⟩, h _ (by intro h'; linarith) ?_⟩, ?_⟩
    · rw [abs_of_pos (by linarith)]; linarith
    · rw [Real.dist_eq, abs_of_neg (by linarith)]; linarith
  · have hu0 : 0 < min (min t ε) (b - a) := lt_min (lt_min ht hε) (by linarith)
    have hu1 := min_le_left (min t ε) (b - a)
    have hu2 := min_le_right (min t ε) (b - a)
    have hu3 := min_le_left t ε
    have hu4 := min_le_right t ε
    refine ⟨y - min (min t ε) (b - a) / 2, ⟨⟨by linarith, by linarith⟩, h _ (by intro h'; linarith) ?_⟩, ?_⟩
    · rw [abs_of_neg (by linarith)]; linarith
    · rw [Real.dist_eq, abs_of_pos (by linarith)]; linarith

/-- The rotation of `Fin n` in values: `i ↦ i + 1`, and the last to `0`. -/
theorem finRotate_val {n : ℕ} (i : Fin n) : ((finRotate n i : Fin n) : ℕ) = if (i : ℕ) + 1 < n then (i : ℕ) + 1 else 0 := by
  cases n with
  | zero => exact i.elim0
  | succ m =>
    rw [coe_finRotate]
    by_cases h : i = Fin.last m
    · subst h; simp
    · have : (i : ℕ) < m := Fin.val_lt_last h
      rw [if_neg h, if_pos (by omega)]

/-- A radius about `β` inside which every other angle is off `D` (`exists_offDirs_punctured`). -/
noncomputable def isoRad (D : Finset ℝ) (β : ℝ) : ℝ := Classical.choose (exists_offDirs_punctured D β)

theorem isoRad_pos (D : Finset ℝ) (β : ℝ) : 0 < isoRad D β := (Classical.choose_spec (exists_offDirs_punctured D β)).1

theorem offDirs_of_isoRad {D : Finset ℝ} {β φ : ℝ} (h : φ ≠ β) (h' : |φ - β| < isoRad D β) : OffDirs D φ :=
  (Classical.choose_spec (exists_offDirs_punctured D β)).2 φ h h'

/-- The colour just counter-clockwise of the direction `β`, read off `σ`. -/
noncomputable def rightCol {k : ℕ} (D : Finset ℝ) (σ : ℝ → Fin k) (β : ℝ) : Fin k := σ (β + isoRad D β / 2)

/-- The colour just clockwise of the direction `β`, read off `σ`. -/
noncomputable def leftCol {k : ℕ} (D : Finset ℝ) (σ : ℝ → Fin k) (β : ℝ) : Fin k := σ (β - isoRad D β / 2)

/-- `dot` is real-linear in its second argument. -/
theorem dot_real_mul_right (a b : ℂ) (r : ℝ) : dot a ((r : ℂ) * b) = r * dot a b := by
  simp only [dot_eq, Complex.re_ofReal_mul, Complex.im_ofReal_mul]; ring

/-- The zeros of `cos (φ − a)` are `a ± π/2` mod `2π`. -/
theorem eq_of_cos_sub_eq_zero {φ a : ℝ} (h : Real.cos (φ - a) = 0) :
    ∃ m : ℤ, φ = a + π / 2 + 2 * π * m ∨ φ = a - π / 2 + 2 * π * m := by
  obtain ⟨k, hk⟩ := Real.cos_eq_zero_iff.mp h
  obtain ⟨m, rfl | rfl⟩ := Int.even_or_odd' k
  · exact ⟨m, Or.inl (by push_cast at hk; linear_combination hk)⟩
  · exact ⟨m + 1, Or.inr (by push_cast at hk ⊢; linear_combination hk)⟩

/-- Where the cosine is positive the angle is within `π/2` of a multiple of `2π`. -/
theorem exists_mem_Ioo_of_cos_pos {x : ℝ} (h : 0 < Real.cos x) : ∃ m : ℤ, x - 2 * π * m ∈ Ioo (-(π / 2)) (π / 2) := by
  have hπ := Real.pi_pos
  obtain ⟨m, hm⟩ := exists_shift_Ico (-(π / 2)) x
  have hc : Real.cos (x + 2 * π * m) = Real.cos x := by
    rw [show x + 2 * π * m = x + m * (2 * π) by ring, Real.cos_add_int_mul_two_pi]
  refine ⟨-m, ?_, ?_⟩
  · push_cast
    rcases eq_or_lt_of_le hm.1 with h' | h'
    · exfalso
      have : Real.cos (x + 2 * π * m) = 0 := by rw [← h']; simp
      linarith
    · linarith
  · push_cast
    by_contra h'
    push Not at h'
    have := Real.cos_nonpos_of_pi_div_two_le_of_le (x := x + 2 * π * m) (by linarith) (by linarith [hm.2])
    linarith

/-- **Two directions of an open half-circle**: the shorter arc between them lies in it (and it is the one of length `< π`). -/
theorem cos_pos_arc {a φ₁ φ₂ : ℝ} (h12 : φ₁ < φ₂) (h21 : φ₂ < φ₁ + 2 * π) (h1 : 0 < Real.cos (φ₁ - a))
    (h2 : 0 < Real.cos (φ₂ - a)) :
    (φ₂ - φ₁ < π ∧ ∀ φ ∈ Ioo φ₁ φ₂, 0 < Real.cos (φ - a)) ∨
      (π < φ₂ - φ₁ ∧ ∀ φ ∈ Ioo φ₂ (φ₁ + 2 * π), 0 < Real.cos (φ - a)) := by
  have hπ := Real.pi_pos
  obtain ⟨m₁, hm₁⟩ := exists_mem_Ioo_of_cos_pos h1
  obtain ⟨m₂, hm₂⟩ := exists_mem_Ioo_of_cos_pos h2
  have hpos : ∀ φ (m : ℤ), φ - a - 2 * π * m ∈ Ioo (-(π / 2)) (π / 2) → 0 < Real.cos (φ - a) := fun φ m hm => by
    have := Real.cos_pos_of_mem_Ioo hm
    rwa [show φ - a - 2 * π * m = (φ - a) - m * (2 * π) by ring, Real.cos_sub_int_mul_two_pi] at this
  have hA : ((m₂ - m₁ : ℤ) : ℝ) > -1 := by
    push_cast; nlinarith [hm₁.1, hm₁.2, hm₂.1, hm₂.2]
  have hB : ((m₂ - m₁ : ℤ) : ℝ) < 2 := by
    push_cast; nlinarith [hm₁.1, hm₁.2, hm₂.1, hm₂.2]
  have hA' : m₂ - m₁ > -1 := by exact_mod_cast hA
  have hB' : m₂ - m₁ < 2 := by exact_mod_cast hB
  rcases (show m₂ = m₁ ∨ m₂ = m₁ + 1 by omega) with h | h
  · subst h
    left
    exact ⟨by linarith [hm₁.1, hm₂.2], fun φ hφ => hpos φ m₂ ⟨by linarith [hφ.1, hm₁.1], by linarith [hφ.2, hm₂.2]⟩⟩
  · subst h
    right
    push_cast at hm₂
    exact ⟨by linarith [hm₁.2, hm₂.1], fun φ hφ => hpos φ (m₁ + 1) ⟨by push_cast; linarith [hφ.1, hm₂.1],
      by push_cast; linarith [hφ.2, hm₁.2]⟩⟩

/-- **A thin cone keeps the sign of a first-order term**: off the zeros of `dot (e φ) n`, for small `s` and nearby `ψ` the quantity
`2 dot (s e ψ) n + κ s²` (`|κ| ≤ 1`) has the sign of `dot (e φ) n`. -/
theorem exists_sign_near {n : ℂ} {κ : ℝ} (hκ : |κ| ≤ 1) {φ : ℝ} (hφ : dot (e φ) n ≠ 0) :
    ∃ r > 0, ∀ s ∈ Ioo 0 r, ∀ ψ ∈ Ioo (φ - r) (φ + r),
      (0 < dot (e φ) n → 0 < 2 * dot ((s : ℂ) * e ψ) n + κ * s ^ 2) ∧
      (dot (e φ) n < 0 → 2 * dot ((s : ℂ) * e ψ) n + κ * s ^ 2 < 0) := by
  have hA : 0 < |dot (e φ) n| := abs_pos.mpr hφ
  have hn := norm_nonneg n
  set r := |dot (e φ) n| / (2 * ‖n‖ + 1) with hrdef
  have hr0 : 0 < r := by positivity
  have hr : r * (2 * ‖n‖ + 1) = |dot (e φ) n| := div_mul_cancel₀ _ (by positivity)
  refine ⟨r, hr0, fun s hs ψ hψ => ?_⟩
  have hd : |dot (e ψ) n - dot (e φ) n| ≤ |ψ - φ| * ‖n‖ := by
    rw [← dot_sub_left]
    calc |dot (e ψ - e φ) n| ≤ ‖e ψ - e φ‖ * ‖n‖ := abs_dot_le _ _
      _ ≤ |ψ - φ| * ‖n‖ := mul_le_mul_of_nonneg_right (norm_e_sub_e_le ψ φ) hn
  have hψφ : |ψ - φ| < r := abs_lt.mpr ⟨by linarith [hψ.1], by linarith [hψ.2]⟩
  have e2 : |ψ - φ| * ‖n‖ ≤ r * ‖n‖ := mul_le_mul_of_nonneg_right hψφ.le hn
  have h1 := abs_le.mp hd
  have hκs : |κ * s ^ 2| ≤ s ^ 2 := by
    rw [abs_mul, abs_of_nonneg (sq_nonneg s)]; nlinarith [abs_nonneg κ, sq_nonneg s]
  have h2 := abs_le.mp hκs
  have p2 : 0 < s * (r - s) := mul_pos hs.1 (by linarith [hs.2])
  rw [dot_real_mul_left]
  constructor
  · intro hpos
    rw [abs_of_pos hpos] at hr
    have p1 : 0 ≤ s * (dot (e ψ) n - (dot (e φ) n - r * ‖n‖)) := mul_nonneg hs.1.le (by linarith [h1.1])
    have p3 : s * (r * (2 * ‖n‖ + 1)) = s * dot (e φ) n := by rw [hr]
    nlinarith [mul_pos hs.1 hpos]
  · intro hneg
    rw [abs_of_neg hneg] at hr
    have p1 : 0 ≤ s * ((dot (e φ) n + r * ‖n‖) - dot (e ψ) n) := mul_nonneg hs.1.le (by linarith [h1.2])
    have p3 : s * (r * (2 * ‖n‖ + 1)) = s * -dot (e φ) n := by rw [hr]
    nlinarith [mul_pos hs.1 (neg_pos.mpr hneg)]

/-- **A set kept off the open side of a circle through `w`** (or a line, `‖z − w‖²` dropped) **approaches `w` only from the closed other
side**: its cone at `w` lies in the closed half-plane `dot (e β) n ≥ 0`. -/
theorem coneAt_subset_halfPlane {S : Set ℂ} {w n : ℂ} {η : ℝ} (hη : 0 < η)
    (hS : ∀ z ∈ S, z ∈ ball w η → 0 ≤ 2 * dot (z - w) n + ‖z - w‖ ^ 2) {β : ℝ} (hβ : β ∈ coneAt S w) :
    0 ≤ dot (e β) n := by
  by_contra hneg
  push Not at hneg
  have hn := norm_nonneg n
  set A := -dot (e β) n with hAdef
  have hA : 0 < A := by linarith
  set ε := min η (A / (‖n‖ + 1)) with hε
  have hε0 : 0 < ε := lt_min hη (by positivity)
  have hε1 : ε ≤ A / (‖n‖ + 1) := min_le_right _ _
  have hε2 : ε * (‖n‖ + 1) ≤ A := (le_div_iff₀ (by positivity)).mp hε1
  obtain ⟨z, hzS, hzw, hzd, hdir⟩ := hβ ε hε0
  have ht : 0 < ‖z - w‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hzw)
  have htε : ‖z - w‖ < ε := by rw [← dist_eq_norm]; exact hzd
  set u := (z - w) / ((‖z - w‖ : ℝ) : ℂ) with hu
  have hzu : z - w = ((‖z - w‖ : ℝ) : ℂ) * u := by
    rw [hu, mul_div_cancel₀ _ (by exact_mod_cast ht.ne')]
  have hdu : dot u n ≤ -A + ε * ‖n‖ := by
    have h1 := abs_dot_le (u - e β) n
    rw [dot_sub_left] at h1
    have h2 : ‖u - e β‖ * ‖n‖ ≤ ε * ‖n‖ := mul_le_mul_of_nonneg_right hdir.le hn
    linarith [(abs_le.mp h1).2]
  have hz := hS z hzS (by rw [mem_ball]; exact hzd.trans_le (min_le_left _ _))
  rw [hzu, dot_real_mul_left, ← hzu] at hz
  nlinarith [mul_le_mul_of_nonneg_left hdu ht.le, mul_lt_mul_of_pos_left htε ht]

/-- `‖a + b‖² = ‖a‖² + ‖b‖² + 2 dot a b`. -/
theorem norm_add_sq_dot (a b : ℂ) : ‖a + b‖ ^ 2 = ‖a‖ ^ 2 + ‖b‖ ^ 2 + 2 * dot a b := by
  rw [← Complex.normSq_eq_norm_sq, ← Complex.normSq_eq_norm_sq, ← Complex.normSq_eq_norm_sq, Complex.normSq_add]; rfl

/-- An annular sector of non-negative inner radius lies in the ball of its outer radius. -/
theorem annSector_subset_ball (u : ℂ) {r₁ : ℝ} (hr : 0 ≤ r₁) (r₂ θ₁ θ₂ : ℝ) : annSector u r₁ r₂ θ₁ θ₂ ⊆ ball u r₂ := by
  rintro _ ⟨⟨s, θ⟩, ⟨hs, -⟩, rfl⟩
  rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_real_mul_e (hr.trans hs.1.le)]
  exact hs.2

/-- Annular sectors grow with the outer radius. -/
theorem annSector_mono_r₂ (u : ℂ) {r₁ r₂ r₂' θ₁ θ₂ : ℝ} (h : r₂ ≤ r₂') : annSector u r₁ r₂ θ₁ θ₂ ⊆ annSector u r₁ r₂' θ₁ θ₂ := by
  rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
  exact ⟨(s, θ), ⟨⟨hs.1, hs.2.trans_le h⟩, hθ⟩, rfl⟩

/-- A point `u + s e(d)`, `0 ≤ s ≤ ρ`, lies on the segment from `u` to `u + ρ e(d)`. -/
theorem mem_segment_ray {u : ℂ} {ρ s : ℝ} (hρ : 0 < ρ) (hs0 : 0 ≤ s) (hsρ : s ≤ ρ) (d : ℝ) :
    u + (s : ℂ) * e d ∈ segment ℝ u (u + (ρ : ℂ) * e d) := by
  refine ⟨1 - s / ρ, s / ρ, by rw [sub_nonneg, div_le_one hρ]; exact hsρ, div_nonneg hs0 hρ.le, by ring, ?_⟩
  simp only [Complex.real_smul]
  have : (ρ : ℂ) ≠ 0 := by exact_mod_cast hρ.ne'
  push_cast
  field_simp
  ring

/-- A point of the punctured disc off the two edge rays at `d₁` and `d₂` lies in one of the open sectors `(d₁, d₂)`, `(d₂, d₁ + 2π)` (either
empty when `d₂` is outside `(d₁, d₁ + 2π)`). -/
theorem mem_annSector_union_of_ne {v q : ℂ} {d₁ d₂ r : ℝ} (hq : q ≠ v)
    (hqr : ‖q - v‖ < r) (h₁ : ∀ s : ℝ, 0 < s → s < r → q ≠ v + (s : ℂ) * e d₁)
    (h₂ : ∀ s : ℝ, 0 < s → s < r → q ≠ v + (s : ℂ) * e d₂) :
    q ∈ annSector v 0 r d₁ d₂ ∪ annSector v 0 r d₂ (d₁ + 2 * π) := by
  have hpol := eq_add_norm_mul_e v q (d₁ + π)
  set ψ := d₁ + π + Complex.arg ((q - v) * starRingEnd ℂ (e (d₁ + π))) with hψ
  have ha1 := Complex.neg_pi_lt_arg ((q - v) * starRingEnd ℂ (e (d₁ + π)))
  have ha2 := Complex.arg_le_pi ((q - v) * starRingEnd ℂ (e (d₁ + π)))
  have hs0 : 0 < ‖q - v‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hq)
  rcases lt_trichotomy ψ d₂ with h | h | h
  · exact Or.inl ⟨(‖q - v‖, ψ), ⟨⟨hs0, hqr⟩, ⟨by linarith, h⟩⟩, hpol.symm⟩
  · exact absurd (h ▸ hpol) (h₂ _ hs0 hqr)
  · rcases lt_or_eq_of_le (show ψ ≤ d₁ + 2 * π by linarith) with h' | h'
    · exact Or.inr ⟨(‖q - v‖, ψ), ⟨⟨hs0, hqr⟩, ⟨h, h'⟩⟩, hpol.symm⟩
    · refine absurd ?_ (h₁ _ hs0 hqr)
      calc q = v + (‖q - v‖ : ℂ) * e ψ := hpol
        _ = v + (‖q - v‖ : ℂ) * e d₁ := by rw [h', e_add_two_pi]

/-- The two open sectors between the edge rays at `d₁ < d₂ < d₁ + 2π` are disjoint. -/
theorem disjoint_annSector_wedges (v : ℂ) {d₁ d₂ r : ℝ} :
    Disjoint (annSector v 0 r d₁ d₂) (annSector v 0 r d₂ (d₁ + 2 * π)) := by
  rw [Set.disjoint_left]
  rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ ⟨⟨s', θ'⟩, ⟨hs', hθ'⟩, h⟩
  simp only at hs hθ hs' hθ' h
  have h1 : (s' : ℂ) * e θ' = (s : ℂ) * e θ := by linear_combination h
  have hss : s' = s := by
    have := congrArg norm h1
    rwa [norm_real_mul_e hs'.1.le, norm_real_mul_e hs.1.le] at this
  rw [hss] at h1
  have he : e θ' = e θ := mul_left_cancel₀ (by exact_mod_cast hs.1.ne') h1
  obtain ⟨n, hn⟩ := e_eq_e_iff.mp he
  have hπ := Real.pi_pos
  have h0 : (0 : ℝ) * (2 * π) < n * (2 * π) := by linarith [hθ.2, hθ'.1]
  have h1' : (n : ℝ) * (2 * π) < 1 * (2 * π) := by linarith [hθ.1, hθ'.2]
  have hn1 : (0 : ℝ) < n := lt_of_mul_lt_mul_right h0 (by positivity)
  have hn2 : (n : ℝ) < 1 := lt_of_mul_lt_mul_right h1' (by positivity)
  have : (0 : ℤ) < n := by exact_mod_cast hn1
  have : n < 1 := by exact_mod_cast hn2
  omega

/-- **E3-W, Woodall's criterion with a radius** (`plans/FS131-E3-derivation.md` § 3.2; `[Woodall1973]` p. 197, step 3, asserts it without a
radius: "each unit circle through Q, except for those through P, passes through X or Y"): if the open segments from `v` in the directions
`d₁ < d₂ < d₁ + π`, of length `r₁ < cos(α/2)/2` (`α = d₂ − d₁`), lie in the closure of an open set `S` with null unit pairs, then no point of the
open wedge between them within `r₁ cos(α/2)/2` of `v` is at distance `1` from a point of `S`. -/
theorem clear_wedge {S : Set ℂ} (hS : IsOpen S) (hnull : UnitPairsNull S) {v : ℂ} {d₁ d₂ r₁ : ℝ} (hd : d₁ < d₂)
    (hπ : d₂ - d₁ < π) (hr₁ : 0 < r₁) (hr₁c : r₁ < Real.cos ((d₂ - d₁) / 2) / 2)
    (hseg : ∀ s ∈ Ioo 0 r₁, v + (s : ℂ) * e d₁ ∈ closure S ∧ v + (s : ℂ) * e d₂ ∈ closure S) :
    ∀ z ∈ annSector v 0 (r₁ * Real.cos ((d₂ - d₁) / 2) / 2) d₁ d₂, ∀ y ∈ S, dist z y ≠ 1 := by
  have hpi := Real.pi_pos
  have hγ0 : 0 < Real.cos ((d₂ - d₁) / 2) := Real.cos_pos_of_mem_Ioo ⟨by linarith, by linarith⟩
  have hγ1 : Real.cos ((d₂ - d₁) / 2) ≤ 1 := Real.cos_le_one _
  generalize hγdef : Real.cos ((d₂ - d₁) / 2) = γ at hγ0 hγ1 hr₁c
  have hr₁h : r₁ < 1 / 2 := by linarith
  rintro _ ⟨⟨s₀, θ₀⟩, ⟨hs₀, hθ₀⟩, rfl⟩ y hy hzy
  simp only at hs₀ hθ₀ hzy
  -- closure points of `S` are never at distance `1` from `y`, and `v` is one
  have hcl : ∀ q ∈ closure S, dist q y ≠ 1 := fun q hq h =>
    dist_ne_one_of_mem_of_mem_closure hS hnull hy hq (by rw [dist_comm]; exact h)
  have hvS : v ∈ closure S := by
    rw [← closure_closure, Metric.mem_closure_iff]
    intro ε hε
    refine ⟨v + ((min ε r₁ / 2 : ℝ) : ℂ) * e d₁, (hseg _ ⟨by positivity, by linarith [min_le_right ε r₁]⟩).1, ?_⟩
    rw [dist_eq_norm, show v - (v + ((min ε r₁ / 2 : ℝ) : ℂ) * e d₁) = -(((min ε r₁ / 2 : ℝ) : ℂ) * e d₁) by ring,
      norm_neg, norm_real_mul_e (by positivity)]
    linarith [min_le_left ε r₁]
  -- the unit circle about `y`, and the distance of its points from `v`
  set p : ℝ → ℂ := fun t => y + e t with hp
  have hpc : Continuous p := by have := continuous_e; fun_prop
  set f : ℝ → ℝ := fun t => ‖p t - v‖ with hf
  have hfc : Continuous f := by fun_prop
  have hzv : ‖v + (s₀ : ℂ) * e θ₀ - v‖ = s₀ := by rw [add_sub_cancel_left, norm_real_mul_e hs₀.1.le]
  have hγs : r₁ * γ / 2 < r₁ := by nlinarith
  have hs₀r : s₀ < r₁ := hs₀.2.trans hγs
  obtain ⟨tz, htz⟩ : ∃ tz, p tz = v + (s₀ : ℂ) * e θ₀ := by
    have h1 : ‖v + (s₀ : ℂ) * e θ₀ - y‖ = 1 := by rw [← dist_eq_norm]; exact hzy
    have := eq_add_norm_mul_e y (v + (s₀ : ℂ) * e θ₀) 0
    rw [h1, Complex.ofReal_one, one_mul] at this
    exact ⟨_, this.symm⟩
  have hftz : f tz < r₁ := by simp only [hf, htz, hzv]; exact hs₀r
  have hepi : ∀ t, e (t + π) = - e t := fun t => by
    rw [e_add]; simp [e, Complex.exp_pi_mul_I]
  have hfar : ∀ t, e t = - e tz → r₁ < f t := by
    intro t ht
    have h1 : p t - v = (v + (s₀ : ℂ) * e θ₀ - v) - 2 * e tz := by
      rw [← htz]; simp only [hp, ht]; ring
    have h2 : ‖(2 : ℂ) * e tz‖ = 2 := by rw [norm_mul, norm_e, mul_one]; norm_num
    have h3 := norm_sub_norm_le ((2 : ℂ) * e tz) (v + (s₀ : ℂ) * e θ₀ - v)
    simp only [hf, h1]
    rw [norm_sub_rev ((2 : ℂ) * e tz)] at h3
    linarith
  -- `b`: the first return to the circle of radius `r₁` after `tz`; `a`: the last one before it
  set B := {t | tz ≤ t ∧ r₁ ≤ f t} with hBdef
  have hBne : B.Nonempty := ⟨tz + π, by linarith, (hfar _ (hepi tz)).le⟩
  have hBbdd : BddBelow B := ⟨tz, fun t ht => ht.1⟩
  have hBcl : IsClosed B := (isClosed_le continuous_const continuous_id).inter (isClosed_le continuous_const hfc)
  have hbB : sInf B ∈ B := hBcl.csInf_mem hBne hBbdd
  set b := sInf B with hbdef
  have hlowb : ∀ t, tz ≤ t → t < b → f t < r₁ := fun t h1 h2 => by
    by_contra h
    exact absurd (csInf_le hBbdd ⟨h1, not_lt.mp h⟩) (not_le.mpr h2)
  have htzb : tz < b := lt_of_le_of_ne hbB.1 fun h => by rw [← h] at hbB; linarith [hbB.2]
  have hfb : f b = r₁ := by
    refine le_antisymm ?_ hbB.2
    by_contra h
    push Not at h
    obtain ⟨ε, hε, hball⟩ := Metric.eventually_nhds_iff.mp ((hfc.tendsto b).eventually (lt_mem_nhds h))
    have h1 := hball (show dist (max tz (b - ε / 2)) b < ε by
      rw [Real.dist_eq, abs_lt]; constructor <;> [linarith [le_max_right tz (b - ε / 2)]; linarith [max_lt htzb (by linarith : b - ε / 2 < b)]])
    linarith [hlowb _ (le_max_left _ _) (max_lt htzb (show b - ε / 2 < b by linarith))]
  set A := {t | t ≤ tz ∧ r₁ ≤ f t} with hAdef
  have hAne : A.Nonempty := ⟨tz - π, by linarith, (hfar _ (by have := hepi (tz - π); rw [sub_add_cancel] at this; rw [this]; ring)).le⟩
  have hAbdd : BddAbove A := ⟨tz, fun t ht => ht.1⟩
  have hAcl : IsClosed A := (isClosed_le continuous_id continuous_const).inter (isClosed_le continuous_const hfc)
  have haA : sSup A ∈ A := hAcl.csSup_mem hAne hAbdd
  set a := sSup A with hadef
  have hlowa : ∀ t, a < t → t ≤ tz → f t < r₁ := fun t h1 h2 => by
    by_contra h
    exact absurd (le_csSup hAbdd ⟨h2, not_lt.mp h⟩) (not_le.mpr h1)
  have hatz : a < tz := lt_of_le_of_ne haA.1 fun h => by rw [h] at haA; linarith [haA.2]
  have hfa : f a = r₁ := by
    refine le_antisymm ?_ haA.2
    by_contra h
    push Not at h
    obtain ⟨ε, hε, hball⟩ := Metric.eventually_nhds_iff.mp ((hfc.tendsto a).eventually (lt_mem_nhds h))
    have h1 := hball (show dist (min tz (a + ε / 2)) a < ε by
      rw [Real.dist_eq, abs_lt]; constructor <;> [linarith [lt_min hatz (by linarith : a < a + ε / 2)]; linarith [min_le_right tz (a + ε / 2)]])
    linarith [hlowa _ (lt_min hatz (show a < a + ε / 2 by linarith)) (min_le_left _ _)]
  have hin : ∀ t ∈ Ioo a b, f t < r₁ := fun t ht => by
    by_cases h : t ≤ tz
    · exact hlowa t ht.1 h
    · exact hlowb t (le_of_lt (not_le.mp h)) ht.2
  -- the arc between `a` and `b` stays in the open wedge (it cannot cross the edges, which lie in `closure S`)
  have hd2 : d₂ < d₁ + 2 * π := by linarith
  have hIW : p '' Ioo a b ⊆ annSector v 0 r₁ d₁ d₂ := by
    have hsub : p '' Ioo a b ⊆ annSector v 0 r₁ d₁ d₂ ∪ annSector v 0 r₁ d₂ (d₁ + 2 * π) := by
      rintro _ ⟨t, ht, rfl⟩
      have hpy : dist (p t) y = 1 := by simp only [hp, dist_eq_norm, add_sub_cancel_left, norm_e]
      refine mem_annSector_union_of_ne (fun h => hcl v hvS (h ▸ hpy)) (hin t ht)
        (fun s hs1 hs2 h => hcl _ (hseg s ⟨hs1, hs2⟩).1 (h ▸ hpy)) (fun s hs1 hs2 h => hcl _ (hseg s ⟨hs1, hs2⟩).2 (h ▸ hpy))
    exact (isPreconnected_Ioo.image p hpc.continuousOn).subset_left_of_subset_union
      (isOpen_annSector v le_rfl _ _ _) (isOpen_annSector v le_rfl _ _ _) (disjoint_annSector_wedges v) hsub
      ⟨_, ⟨tz, ⟨hatz, htzb⟩, htz⟩, ⟨(s₀, θ₀), ⟨⟨hs₀.1, hs₀r⟩, hθ₀⟩, rfl⟩⟩
  -- its ends lie on the circle of radius `r₁` about `v`, in the closed wedge
  have hab : a < b := hatz.trans htzb
  have hend : ∀ t, t = a ∨ t = b → ∃ θ ∈ Icc d₁ d₂, p t = v + (r₁ : ℂ) * e θ := by
    intro t ht
    have hcl1 : t ∈ closure (Ioo a b) := by
      rw [closure_Ioo hab.ne]; rcases ht with rfl | rfl <;> constructor <;> linarith
    have hpt : p t ∈ closure (annSector v 0 r₁ d₁ d₂) := closure_mono hIW (map_mem_closure hpc hcl1 (mapsTo_image p _))
    obtain ⟨⟨s, θ⟩, ⟨hs, hθ⟩, hst⟩ := closure_annSector_subset v hr₁.le hd.le hpt
    simp only at hs hθ hst
    have hft : f t = r₁ := by rcases ht with rfl | rfl; exacts [hfa, hfb]
    have hsr : s = r₁ := by
      rw [← hft]; simp only [hf, ← hst, add_sub_cancel_left, norm_real_mul_e hs.1]
    exact ⟨θ, hθ, by rw [← hst, hsr]⟩
  -- the arc is at most a half circle
  have hshort : b - a ≤ π := by
    by_contra h
    push Not at h
    have h1 : (a + b) / 2 - π / 2 ∈ Ioo a b := ⟨by linarith, by linarith⟩
    have h2 : (a + b) / 2 - π / 2 + π ∈ Ioo a b := ⟨by linarith, by linarith⟩
    have h3 : ‖p ((a + b) / 2 - π / 2 + π) - p ((a + b) / 2 - π / 2)‖ = 2 := by
      simp only [hp, hepi]
      rw [show y + -e ((a + b) / 2 - π / 2) - (y + e ((a + b) / 2 - π / 2)) = -(2 * e ((a + b) / 2 - π / 2)) by ring,
        norm_neg, norm_mul, norm_e, mul_one]; norm_num
    have h4 := norm_sub_le_norm_sub_add_norm_sub (p ((a + b) / 2 - π / 2 + π)) v (p ((a + b) / 2 - π / 2))
    have h5 := hin _ h1
    have h6 := hin _ h2
    simp only [hf] at h5 h6
    rw [norm_sub_rev v] at h4
    linarith
  -- the chord: `2 sin h ≤ 2 r₁`, `h = (b − a)/2`
  obtain ⟨θa, hθa, hpa⟩ := hend a (Or.inl rfl)
  obtain ⟨θb, hθb, hpb⟩ := hend b (Or.inr rfl)
  have hh0 : 0 < (b - a) / 2 := by linarith
  have hhπ : (b - a) / 2 ≤ π / 2 := by linarith
  have hsinh0 : 0 < Real.sin ((b - a) / 2) := Real.sin_pos_of_pos_of_lt_pi hh0 (by linarith)
  have hcosh0 : 0 ≤ Real.cos ((b - a) / 2) := Real.cos_nonneg_of_mem_Icc ⟨by linarith, hhπ⟩
  have hchord : Real.sin ((b - a) / 2) ≤ r₁ := by
    have e1 : p b - p a = -(e a * (1 - e (2 * ((b - a) / 2)))) := by
      simp only [hp]
      rw [show 2 * ((b - a) / 2) = b - a by ring, mul_sub, mul_one, ← e_add, show a + (b - a) = b by ring]
      ring
    have e2 : ‖p b - p a‖ = 2 * Real.sin ((b - a) / 2) := by
      rw [e1, norm_neg, norm_mul, norm_e, one_mul, one_sub_e_two_mul, norm_mul, norm_e, mul_one, Complex.norm_real,
        Real.norm_eq_abs, abs_of_pos (by positivity)]
    have e3 := norm_sub_le_norm_sub_add_norm_sub (p b) v (p a)
    rw [norm_sub_rev v, e2] at e3
    have : f a + f b = 2 * r₁ := by rw [hfa, hfb]; ring
    simp only [hf] at this
    linarith
  -- the bisector projection: `K + cos (t − β)`
  have hg : ∀ t, ((p t - v) * starRingEnd ℂ (e ((d₁ + d₂) / 2))).re =
      ((y - v) * starRingEnd ℂ (e ((d₁ + d₂) / 2))).re + Real.cos (t - (d₁ + d₂) / 2) := by
    intro t
    simp only [hp]
    rw [show y + e t - v = (y - v) + e t by ring, add_mul, Complex.add_re, ← e_sub_eq, e_eq (t - (d₁ + d₂) / 2)]
    simp only [Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.ofReal_im, Complex.I_re, Complex.I_im]
    ring
  have hga : ∀ θ ∈ Icc d₁ d₂, r₁ * γ ≤ ((v + (r₁ : ℂ) * e θ - v) * starRingEnd ℂ (e ((d₁ + d₂) / 2))).re := by
    intro θ hθ
    rw [add_sub_cancel_left, mul_assoc, ← e_sub_eq, e_eq]
    simp only [Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, Complex.add_re, Complex.add_im, Complex.mul_im,
      Complex.I_re, Complex.I_im]
    have habs : |θ - (d₁ + d₂) / 2| ≤ (d₂ - d₁) / 2 := abs_le.mpr ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
    have hc := Real.cos_le_cos_of_nonneg_of_le_pi (abs_nonneg _) (by linarith) habs
    rw [Real.cos_abs, hγdef] at hc
    nlinarith
  have hKa := hga θa hθa
  have hKb := hga θb hθb
  rw [← hpa, hg] at hKa
  rw [← hpb, hg] at hKb
  have hKz : ((y - v) * starRingEnd ℂ (e ((d₁ + d₂) / 2))).re + Real.cos (tz - (d₁ + d₂) / 2) ≤ s₀ := by
    rw [← hg, htz]
    calc _ ≤ ‖(v + (s₀ : ℂ) * e θ₀ - v) * starRingEnd ℂ (e ((d₁ + d₂) / 2))‖ := Complex.re_le_norm _
      _ = s₀ := by rw [norm_mul, Complex.norm_conj, norm_e, mul_one, hzv]
  generalize ((y - v) * starRingEnd ℂ (e ((d₁ + d₂) / 2))).re = K at hKa hKb hKz
  -- the sinusoid lies above its chord, up to the sagitta `1 − cos h ≤ sin² h ≤ r₁²`
  set u := tz - (a + b) / 2 with hu
  set h := (b - a) / 2 with hh
  set m := (a + b) / 2 - (d₁ + d₂) / 2 with hm
  have ha' : a - (d₁ + d₂) / 2 = m - h := by rw [hm, hh]; ring
  have hb' : b - (d₁ + d₂) / 2 = m + h := by rw [hm, hh]; ring
  have hz' : tz - (d₁ + d₂) / 2 = m + u := by rw [hm, hu]; ring
  rw [ha', Real.cos_sub] at hKa
  rw [hb', Real.cos_add] at hKb
  rw [hz', Real.cos_add] at hKz
  have hu1 : |u| ≤ h := abs_le.mpr ⟨by rw [hu, hh]; linarith, by rw [hu, hh]; linarith⟩
  have hcu : Real.cos h ≤ Real.cos u := by
    have := Real.cos_le_cos_of_nonneg_of_le_pi (abs_nonneg u) (by linarith) hu1
    rwa [Real.cos_abs] at this
  have hsu : |Real.sin u| ≤ Real.sin h := by
    have h1 : Real.sin u ^ 2 ≤ Real.sin h ^ 2 := by
      have e1 := Real.sin_sq_add_cos_sq u
      have e2 := Real.sin_sq_add_cos_sq h
      have e3 := pow_le_pow_left₀ hcosh0 hcu 2
      linarith
    exact abs_le_of_sq_le_sq' h1 hsinh0.le |> fun h2 => abs_le.mpr h2
  have hC1 := Real.neg_one_le_cos m
  have hC2 := Real.cos_le_one m
  have hcu1 := Real.cos_le_one u
  have hsag : 1 - Real.cos h ≤ r₁ ^ 2 := by
    have e1 := Real.sin_sq_add_cos_sq h
    have e2 := mul_nonneg hcosh0 (sub_nonneg.mpr (Real.cos_le_one h))
    have e3 := pow_le_pow_left₀ hsinh0.le hchord 2
    have e4 : Real.cos h * (1 - Real.cos h) = Real.cos h - Real.cos h ^ 2 := by ring
    linarith
  have hkey : K + Real.cos m * Real.cos h - |Real.sin m| * Real.sin h ≥ r₁ * γ := by
    rcases le_total 0 (Real.sin m) with hs | hs
    · rw [abs_of_nonneg hs]; linarith
    · rw [abs_of_nonpos hs]; linarith
  have hprod : Real.sin m * Real.sin u ≤ |Real.sin m| * Real.sin h := by
    calc Real.sin m * Real.sin u ≤ |Real.sin m * Real.sin u| := le_abs_self _
      _ = |Real.sin m| * |Real.sin u| := abs_mul _ _
      _ ≤ |Real.sin m| * Real.sin h := mul_le_mul_of_nonneg_left hsu (abs_nonneg _)
  have hcm : Real.cos m * Real.cos u - Real.cos m * Real.cos h ≥ -(Real.cos u - Real.cos h) := by
    have e1 := mul_nonneg (show 0 ≤ Real.cos m + 1 by linarith) (sub_nonneg.mpr hcu)
    have e2 : (Real.cos m + 1) * (Real.cos u - Real.cos h) =
        Real.cos m * Real.cos u - Real.cos m * Real.cos h + (Real.cos u - Real.cos h) := by ring
    linarith
  have hr₁2 : r₁ ^ 2 < r₁ * γ / 2 := by
    have e1 := mul_pos hr₁ (show 0 < γ / 2 - r₁ by linarith)
    have e2 : r₁ * (γ / 2 - r₁) = r₁ * γ / 2 - r₁ ^ 2 := by ring
    linarith
  linarith [hs₀.2]

/-- The boundary of the open annular sector `annSector v 0 ρ d₁ d₂`: its two edges and its outer arc. -/
noncomputable def wedgeArcs (v : ℂ) (ρ d₁ d₂ : ℝ) : Set Arc :=
  {Arc.seg v (v + (ρ : ℂ) * e d₁), Arc.seg v (v + (ρ : ℂ) * e d₂), Arc.circ v ρ d₁ d₂}

/-- The wedge's arcs have positive length. -/
theorem wedgeArcs_nondegenerate {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π) :
    ∀ a ∈ wedgeArcs v ρ d₁ d₂, a.Nondegenerate := by
  have hseg : ∀ d : ℝ, v ≠ v + (ρ : ℂ) * e d := fun d h => by
    have : (ρ : ℂ) * e d = 0 := by linear_combination -h
    rcases mul_eq_zero.mp this with h1 | h1
    · exact hρ.ne' (by exact_mod_cast h1)
    · exact e_ne_zero _ h1
  intro a ha
  simp only [wedgeArcs, mem_insert_iff, mem_singleton_iff] at ha
  rcases ha with rfl | rfl | rfl
  · exact hseg d₁
  · exact hseg d₂
  · exact ⟨hρ, hd, hd2⟩

/-- The wedge's arcs lie in the polar image of its closed radii and closed angles. -/
theorem wedgeArcs_subset_polar {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ ≤ d₂) :
    ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier ⊆ (fun q : ℝ × ℝ => v + (q.1 : ℂ) * e q.2) '' (Icc 0 ρ ×ˢ Icc d₁ d₂) := by
  refine iUnion₂_subset fun a ha => ?_
  have hseg : ∀ d ∈ Icc d₁ d₂, segment ℝ v (v + (ρ : ℂ) * e d) ⊆
      (fun q : ℝ × ℝ => v + (q.1 : ℂ) * e q.2) '' (Icc 0 ρ ×ˢ Icc d₁ d₂) := by
    rintro d hd' _ ⟨a', b', ha', hb', hab, rfl⟩
    refine ⟨(b' * ρ, d), ⟨⟨by positivity, by nlinarith⟩, hd'⟩, ?_⟩
    simp only [Complex.real_smul]
    rw [show (a' : ℂ) = 1 - b' by rw [show a' = 1 - b' by linarith]; push_cast; ring]
    push_cast; ring
  simp only [wedgeArcs, mem_insert_iff, mem_singleton_iff] at ha
  rcases ha with rfl | rfl | rfl
  · exact hseg d₁ ⟨le_rfl, hd⟩
  · exact hseg d₂ ⟨hd, le_rfl⟩
  · rintro _ ⟨θ, hθ, rfl⟩
    exact ⟨(ρ, θ), ⟨⟨hρ.le, le_rfl⟩, hθ⟩, rfl⟩

/-- A point at a direction in `(d₂, d₁ + 2π)` is off the polar image of `[0, ρ] × [d₁, d₂]`. -/
theorem polar_notMem {v : ℂ} {ρ d₁ d₂ s θ : ℝ} (hs : 0 < s) (hθ : θ ∈ Ioo d₂ (d₁ + 2 * π)) :
    v + (s : ℂ) * e θ ∉ (fun q : ℝ × ℝ => v + (q.1 : ℂ) * e q.2) '' (Icc 0 ρ ×ˢ Icc d₁ d₂) := by
  rintro ⟨⟨s', θ'⟩, ⟨hs', hθ'⟩, h⟩
  simp only at h hs' hθ'
  exact e_ne_e_of_lt (show θ' < θ by linarith [hθ.1, hθ'.2]) (by linarith [hθ.2, hθ'.1])
    (polar_inj hs hs'.1 h.symm).2.symm

/-- The open wedge meets none of its arcs. -/
theorem annSector_notMem_wedgeArcs {v : ℂ} {ρ d₁ d₂ : ℝ} (hd2 : d₂ ≤ d₁ + 2 * π) {z : ℂ}
    (hz : z ∈ annSector v 0 ρ d₁ d₂) : z ∉ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier := by
  obtain ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ := hz
  simp only at hs hθ
  intro h
  obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
  have hseg : ∀ d : ℝ, v + (s : ℂ) * e θ ∈ segment ℝ v (v + (ρ : ℂ) * e d) → e θ = e d := by
    rintro d ⟨a', b', ha', hb', hab, he⟩
    have he' : v + (s : ℂ) * e θ = v + ((b' * ρ : ℝ) : ℂ) * e d := by
      rw [← he]; simp only [Complex.real_smul]
      rw [show (a' : ℂ) = 1 - b' by rw [show a' = 1 - b' by linarith]; push_cast; ring]
      push_cast; ring
    exact (polar_inj hs.1 (by have := hs.1; nlinarith [hs.2]) he').2
  simp only [wedgeArcs, mem_insert_iff, mem_singleton_iff] at ha
  rcases ha with rfl | rfl | rfl
  · exact e_ne_e_of_lt hθ.1 (by linarith [hθ.2]) (hseg d₁ hza).symm
  · exact e_ne_e_of_lt (show θ < d₂ from hθ.2) (by linarith [hθ.1]) (hseg d₂ hza)
  · obtain ⟨θ', -, h'⟩ := hza
    have := (polar_inj hs.1 (le_of_lt (hs.1.trans hs.2)) h'.symm).1
    linarith [hs.2]

/-- The frontier of the open annular sector lies on its two edges and its outer arc. -/
theorem frontier_annSector_subset {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π) :
    frontier (annSector v 0 ρ d₁ d₂) ⊆ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier := by
  have _ := hd2
  intro z hz
  rw [(isOpen_annSector v le_rfl ρ d₁ d₂).frontier_eq] at hz
  obtain ⟨hzc, hzW⟩ := hz
  obtain ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ := closure_annSector_subset v hρ.le hd.le hzc
  simp only at hs hθ hzW ⊢
  by_cases h0 : s = 0
  · subst h0
    refine mem_iUnion₂.mpr ⟨_, Or.inl rfl, ?_⟩
    simp only [Complex.ofReal_zero, zero_mul, add_zero]
    exact left_mem_segment ℝ _ _
  by_cases hρs : s = ρ
  · subst hρs
    exact mem_iUnion₂.mpr ⟨_, Or.inr (Or.inr rfl), ⟨θ, hθ, rfl⟩⟩
  by_cases h1 : θ = d₁
  · subst h1
    exact mem_iUnion₂.mpr ⟨_, Or.inl rfl, mem_segment_ray hρ hs.1 hs.2 _⟩
  by_cases h2 : θ = d₂
  · subst h2
    exact mem_iUnion₂.mpr ⟨_, Or.inr (Or.inl rfl), mem_segment_ray hρ hs.1 hs.2 _⟩
  exact absurd ⟨(s, θ), ⟨⟨lt_of_le_of_ne hs.1 (Ne.symm h0), lt_of_le_of_ne hs.2 hρs⟩,
    ⟨lt_of_le_of_ne hθ.1 (Ne.symm h1), lt_of_le_of_ne hθ.2 h2⟩⟩, rfl⟩ hzW

namespace ArcMap

variable {k : ℕ}

/-! ## Recolouring a set bounded by new arcs -/

/-- **Recolouring** `W` with the colour `c`: the arcs of `F` and the finitely many arcs `B`, which carry the frontier of `W`; the colour `c` on
`W` and `F`'s colour elsewhere. The colour is locally constant off the arcs because a point off `frontier W` lies in the interior of `W` or of
its complement. -/
noncomputable def recolour (F : ArcMap k) (W : Set ℂ) (B : Set Arc) (hB : ∀ a ∈ B, a.Nondegenerate) (hBf : B.Finite)
    (hW : frontier W ⊆ ⋃ a ∈ B, a.carrier) (c : Fin k) : ArcMap k where
  dom := F.dom
  isOpen_dom := F.isOpen_dom
  arcs := F.arcs ∪ B
  nondegenerate := fun a ha => ha.elim (F.nondegenerate a) (hB a)
  locallyFinite := fun x hx => by
    obtain ⟨t, ht, hfin⟩ := F.locallyFinite x hx
    refine ⟨t, ht, (hfin.union hBf).subset ?_⟩
    rintro a ⟨ha | ha, hne⟩
    · exact Or.inl ⟨ha, hne⟩
    · exact Or.inr ha
  col := by classical exact fun z => if z ∈ W then c else F.col z
  locallyConstant := by
    classical
    intro x hx hxΓ
    have hxF : x ∉ ⋃ a ∈ F.arcs, a.carrier := fun h => hxΓ (by
      obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp h
      exact mem_iUnion₂.mpr ⟨a, Or.inl ha, hxa⟩)
    have hxW : x ∉ frontier W := fun h => hxΓ (by
      obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp (hW h)
      exact mem_iUnion₂.mpr ⟨a, Or.inr ha, hxa⟩)
    by_cases hx' : x ∈ W
    · have hint : x ∈ interior W := by
        by_contra hni
        exact hxW ⟨subset_closure hx', hni⟩
      filter_upwards [mem_interior_iff_mem_nhds.mp hint] with y hy
      simp [hy, hx']
    · have hcl : x ∉ closure W := fun h => hxW ⟨h, fun hi => hx' (interior_subset hi)⟩
      filter_upwards [isClosed_closure.isOpen_compl.mem_nhds hcl, F.locallyConstant x hx hxF] with y hy hyc
      have hyW : y ∉ W := fun h => hy (subset_closure h)
      simp [hyW, hx', hyc]

variable {F : ArcMap k} {W : Set ℂ} {B : Set Arc} {hB : ∀ a ∈ B, a.Nondegenerate} {hBf : B.Finite}
  {hW : frontier W ⊆ ⋃ a ∈ B, a.carrier} {c : Fin k}

/-- Recolouring keeps the domain, so a map of the plane stays one. -/
theorem recolour_isPlaneMap (hP : F.IsPlaneMap) : (F.recolour W B hB hBf hW c).IsPlaneMap := hP

/-- The interior points of the recoloured map are interior points of `F` (the arcs only grow). -/
theorem interiorPts_recolour_subset : (F.recolour W B hB hBf hW c).interiorPts ⊆ F.interiorPts := by
  rintro x ⟨hx, hxΓ⟩
  exact ⟨hx, fun h => hxΓ (by
    obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp h
    exact mem_iUnion₂.mpr ⟨a, Or.inl ha, hxa⟩)⟩

/-- **Validity of a recolouring** is a statement about `W`: no unit pair inside `W`, and none between `W` and `F`'s class of `c`. -/
theorem recolour_valid (hF : F.Valid) (hWW : ∀ x ∈ W, ∀ y ∈ W, dist x y ≠ 1)
    (hWc : ∀ x ∈ W, ∀ y ∈ F.region c, dist x y ≠ 1) : (F.recolour W B hB hBf hW c).Valid := by
  classical
  intro x hx y hy hxy
  have hx' := interiorPts_recolour_subset hx
  have hy' := interiorPts_recolour_subset hy
  change (if x ∈ W then c else F.col x) ≠ (if y ∈ W then c else F.col y)
  split_ifs with h1 h2 h2
  · exact absurd hxy (hWW x h1 y h2)
  · intro hc
    exact hWc x h1 y ⟨hy', hc.symm⟩ hxy
  · intro hc
    exact hWc y h2 x ⟨hx', hc⟩ (by rw [dist_comm]; exact hxy)
  · exact hF x hx' y hy' hxy

/-- **Condition 5 is kept** when no new arc meets a unit circle in infinitely many points. -/
theorem recolour_condition5 (h5 : F.Condition5) (hB5 : ∀ a ∈ B, ∀ p, (a.carrier ∩ sphere p 1).Finite) :
    (F.recolour W B hB hBf hW c).Condition5 := by
  rintro a (ha | ha) p
  · exact h5 a ha p
  · exact (hB5 a ha p).subset fun z hz => ⟨hz.1.1, hz.2⟩

/-- **Off `closure W` and the new arcs, the regions are unchanged.** -/
theorem recolour_region_diff (j : Fin k) :
    (F.recolour W B hB hBf hW c).region j \ (closure W ∪ ⋃ a ∈ B, a.carrier) =
      F.region j \ (closure W ∪ ⋃ a ∈ B, a.carrier) := by
  classical
  ext z
  simp only [Set.mem_sdiff, mem_union, not_or]
  constructor
  · rintro ⟨⟨⟨hzd, hzΓ⟩, hcol⟩, hcl, hB'⟩
    have hzW : z ∉ W := fun h => hcl (subset_closure h)
    refine ⟨⟨⟨hzd, fun h => hzΓ ?_⟩, ?_⟩, hcl, hB'⟩
    · obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
      exact mem_iUnion₂.mpr ⟨a, Or.inl ha, hza⟩
    · have : (if z ∈ W then c else F.col z) = j := hcol
      rw [if_neg hzW] at this
      exact this
  · rintro ⟨⟨⟨hzd, hzΓ⟩, hcol⟩, hcl, hB'⟩
    have hzW : z ∉ W := fun h => hcl (subset_closure h)
    refine ⟨⟨⟨hzd, fun h => ?_⟩, ?_⟩, hcl, hB'⟩
    · obtain ⟨a, ha | ha, hza⟩ := mem_iUnion₂.mp h
      · exact hzΓ (mem_iUnion₂.mpr ⟨a, ha, hza⟩)
      · exact hB' (mem_iUnion₂.mpr ⟨a, ha, hza⟩)
    · show (if z ∈ W then c else F.col z) = j
      rw [if_neg hzW]
      exact hcol

/-! ## The merge at a wedge -/

/-- **The merge at a wedge** (E3-NICE's single merge): `F` recoloured with `c` on the open annular sector of radius `ρ` between the directions
`d₁ < d₂ ≤ d₁ + 2π`, its two edges and its outer arc added to the arcs. -/
noncomputable def wedgeMerge (F : ArcMap k) (v : ℂ) {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π)
    (c : Fin k) : ArcMap k :=
  F.recolour (annSector v 0 ρ d₁ d₂) (wedgeArcs v ρ d₁ d₂) (wedgeArcs_nondegenerate hρ hd hd2)
    (((finite_singleton _).insert _).insert _) (frontier_annSector_subset hρ hd hd2) c

/-- **The merge at a wedge is valid** (E3-W): the two edges in the closure of `F`'s class of `c`, less than `π` apart, and the radius within
E3-W's bound. -/
theorem wedgeMerge_valid (hF : F.Valid) {v : ℂ} {ρ d₁ d₂ r₁ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hπ : d₂ - d₁ < π) (hr₁ : 0 < r₁)
    (hr₁c : r₁ < Real.cos ((d₂ - d₁) / 2) / 2) (hρr : ρ ≤ r₁ * Real.cos ((d₂ - d₁) / 2) / 2)
    (hseg : ∀ s ∈ Ioo 0 r₁, v + (s : ℂ) * e d₁ ∈ closure (F.region c) ∧ v + (s : ℂ) * e d₂ ∈ closure (F.region c)) :
    (F.wedgeMerge v hρ hd (by linarith [Real.pi_pos]) c).Valid := by
  have hcos : Real.cos ((d₂ - d₁) / 2) ≤ 1 := Real.cos_le_one _
  have hcos0 : 0 < Real.cos ((d₂ - d₁) / 2) := Real.cos_pos_of_mem_Ioo ⟨by linarith [Real.pi_pos], by linarith⟩
  have hρ4 : ρ < 1 / 4 := by nlinarith
  refine recolour_valid hF (fun x hx y hy hxy => ?_) (fun x hx y hy => ?_)
  · have h1 := annSector_subset_ball v le_rfl ρ d₁ d₂ hx
    have h2 := annSector_subset_ball v le_rfl ρ d₁ d₂ hy
    rw [mem_ball] at h1 h2
    have := dist_triangle_right x y v
    linarith
  · exact clear_wedge (F.isOpen_region c) (hF.unitPairsNull_region c) hd hπ hr₁ hr₁c hseg x
      (annSector_mono_r₂ v hρr hx) y hy

/-- **The merge at a wedge keeps Condition 5**: its new arcs are two segments and an arc of radius `ρ < 1`. -/
theorem wedgeMerge_condition5 (h5 : F.Condition5) {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hρ1 : ρ < 1) (hd : d₁ < d₂)
    (hd2 : d₂ ≤ d₁ + 2 * π) : (F.wedgeMerge v hρ hd hd2 c).Condition5 := by
  refine recolour_condition5 h5 fun a ha p => ?_
  rcases Arc.finite_inter_sphere_or_eq_circ a (wedgeArcs_nondegenerate hρ hd hd2 a ha) p with h | ⟨θ₀, θ₁, rfl⟩
  · exact h
  · exfalso
    simp only [wedgeArcs, mem_insert_iff, mem_singleton_iff] at ha
    rcases ha with h | h | h
    · exact Arc.noConfusion h
    · exact Arc.noConfusion h
    · injection h with _ h1
      linarith

/-- **The merge at a wedge changes nothing off `closedBall v ρ`.** -/
theorem wedgeMerge_region_diff {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π) (j : Fin k) :
    (F.wedgeMerge v hρ hd hd2 c).region j \ closedBall v ρ = F.region j \ closedBall v ρ := by
  have hX : closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier ⊆ closedBall v ρ := by
    refine union_subset (closure_minimal ((annSector_subset_ball v le_rfl ρ d₁ d₂).trans ball_subset_closedBall)
      isClosed_closedBall) (iUnion₂_subset fun a ha => ?_)
    have hend : ∀ d : ℝ, v + (ρ : ℂ) * e d ∈ closedBall v ρ := fun d => by
      rw [mem_closedBall, dist_eq_norm, add_sub_cancel_left, norm_real_mul_e hρ.le]
    simp only [wedgeArcs, mem_insert_iff, mem_singleton_iff] at ha
    rcases ha with rfl | rfl | rfl
    · exact (convex_closedBall v ρ).segment_subset (mem_closedBall_self hρ.le) (hend d₁)
    · exact (convex_closedBall v ρ).segment_subset (mem_closedBall_self hρ.le) (hend d₂)
    · rintro _ ⟨θ, -, rfl⟩; exact hend θ
  have key := recolour_region_diff (F := F) (W := annSector v 0 ρ d₁ d₂) (B := wedgeArcs v ρ d₁ d₂)
    (hB := wedgeArcs_nondegenerate hρ hd hd2) (hBf := ((finite_singleton _).insert _).insert _)
    (hW := frontier_annSector_subset hρ hd hd2) (c := c) j
  have e1 : ∀ A : Set ℂ, A \ closedBall v ρ =
      (A \ (closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier)) \ closedBall v ρ := fun A => by
    ext z
    simp only [Set.mem_sdiff]
    exact ⟨fun h => ⟨⟨h.1, fun h' => h.2 (hX h')⟩, h.2⟩, fun h => ⟨h.1.1, h.2⟩⟩
  rw [e1, e1 (F.region j)]
  exact congrArg (· \ closedBall v ρ) key

/-! ## Locality -/

/-- **The colours at a point depend only on the regions near it.** -/
theorem coloursAt_congr {F F' : ArcMap k} {w : ℂ} {U : Set ℂ} (hU : U ∈ 𝓝 w)
    (h : ∀ j, F.region j ∩ U = F'.region j ∩ U) : F.coloursAt w = F'.coloursAt w := by
  have key : ∀ S : Set ℂ, w ∈ closure S ↔ w ∈ closure (S ∩ U) := fun S => by
    refine ⟨fun hS => ?_, fun hS => closure_mono inter_subset_left hS⟩
    rw [mem_closure_iff_nhds] at hS ⊢
    intro t ht
    obtain ⟨y, hy1, hy2⟩ := hS (t ∩ U) (inter_mem ht hU)
    exact ⟨y, hy1.1, hy2, hy1.2⟩
  ext j
  simp only [coloursAt, mem_setOf_eq]
  rw [key, h j, ← key]

/-- **`NiceAt` depends only on the regions near the point** (and on its being in the domain): pictures read cones, and cones are local. -/
theorem niceAt_congr {F F' : ArcMap k} {w : ℂ} {U : Set ℂ} (hU : U ∈ 𝓝 w) (hdom : w ∈ F.dom ↔ w ∈ F'.dom)
    (h : ∀ j, F.region j ∩ U = F'.region j ∩ U) : F.NiceAt w ↔ F'.NiceAt w := by
  obtain ⟨r, hr, hrU⟩ := Metric.mem_nhds_iff.mp hU
  have key : ∀ S : Set ℂ, coneAt S w = coneAt (S ∩ U) w := fun S =>
    Subset.antisymm (fun β hβ => coneAt_mono (inter_subset_inter_right S hrU) w (coneAt_inter_ball hr hβ))
      (coneAt_mono inter_subset_left w)
  have hcone : ∀ j, coneAt (F.region j) w = coneAt (F'.region j) w := fun j => by rw [key, h j, ← key]
  have hS : ∀ n d c, F.SectorsAt w n d c ↔ F'.SectorsAt w n d c := fun n d c => by
    simp only [SectorsAt, hcone, hdom]
  simp only [NiceAt, hS]

/-! ## The local data at a point -/

/-- **The local data at `v`**: off the finitely many directions `D` (mod `2π`), a thin open cone about each direction `φ` lies in the colour
class `σ φ`. With `D` the tangent directions at `v` of the arcs through `v`, wave 3's wedge lemma gives it at every point of the domain
(`exists_dirColourAt`). `D` may hold invisible directions (an arc between two sides of one colour); the colour classes' cones off `D` are read
from `σ` alone. -/
def DirColourAt (F : ArcMap k) (v : ℂ) (D : Finset ℝ) (σ : ℝ → Fin k) : Prop :=
  ∀ φ : ℝ, OffDirs D φ → ∃ r > 0, annSector v 0 r (φ - r) (φ + r) ⊆ F.region (σ φ)

/-- Spec example: the one-colour plane has the local data `D = ∅`, `σ = 0` at every point. -/
example (v : ℂ) : (ArcMap.const univ isOpen_univ (0 : Fin 1)).DirColourAt v ∅ fun _ => 0 :=
  fun _ _ => ⟨1, one_pos, fun _ _ => ⟨by simp, rfl⟩⟩

/-- **The local data exists at every point of the domain** — from `exists_goodAt` and `GoodAt.exists_wedge` (wave 3, landed); no
`localSectors`. -/
theorem exists_dirColourAt {v : ℂ} (hv : v ∈ F.dom) : ∃ (D : Finset ℝ) (σ : ℝ → Fin k), F.DirColourAt v D σ := by
  classical
  obtain ⟨ρ₀, hG⟩ := F.exists_goodAt hv
  set 𝒜 := {a | a ∈ F.arcs ∧ (a.carrier ∩ ball v ρ₀).Nonempty} with h𝒜
  -- the unit vectors tangent at `v` to an arc of the good ball: finitely many
  set M : Set ℂ := ⋃ a ∈ 𝒜, {m : ℂ | m.re * (a.curveData v).2.re + m.im * (a.curveData v).2.im = 0 ∧
    m.re ^ 2 + m.im ^ 2 = 1} with hM
  have hMfin : M.Finite := hG.fin.biUnion fun a ha =>
    finite_perp_circle _ (Arc.curveData_ne (F.nondegenerate a ha.1) (hG.through a ha.1 ha.2)) 0 1
  refine ⟨hMfin.toFinset.image Complex.arg, ?_⟩
  have hgen : ∀ φ : ℝ, OffDirs (hMfin.toFinset.image Complex.arg) φ → ∀ a ∈ F.arcs,
      (a.carrier ∩ ball v ρ₀).Nonempty → ¬ a.Tang v (e φ) := by
    intro φ hφ a ha hne hT
    have hmem : e φ ∈ M := by
      refine mem_iUnion₂.mpr ⟨a, ⟨ha, hne⟩, ?_, ?_⟩
      · have : ((a.curveData v).2 * (starRingEnd ℂ) (e φ)).re = 0 := hT
        simpa [Complex.mul_re, mul_comm] using this
      · have := norm_e φ
        have h := Complex.sq_norm (e φ)
        rw [Complex.normSq_apply, this] at h
        nlinarith
    have harg : e (Complex.arg (e φ)) = e φ := by
      have h := Complex.norm_mul_exp_arg_mul_I (e φ)
      rw [norm_e, Complex.ofReal_one, one_mul] at h
      exact h
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp harg.symm
    exact hφ _ (Finset.mem_image.mpr ⟨e φ, hMfin.mem_toFinset.mpr hmem, rfl⟩) n (hn.trans (by ring))
  have hex : ∀ φ : ℝ, OffDirs (hMfin.toFinset.image Complex.arg) φ →
      ∃ g : Fin k, ∃ r > 0, annSector v 0 r (φ - r) (φ + r) ⊆ F.region g := by
    intro φ hφ
    have hu : ‖e φ‖ = 1 := norm_e φ
    obtain ⟨m, hm0, N₀, hN₀, hN⟩ := hG.exists_wedge hu
    set N := max N₀ 1 with hNdef
    have hN0 : 0 < N := lt_max_of_lt_right one_pos
    obtain ⟨hball, hΓ⟩ := hN N (le_max_left _ _)
    have hI : Rgn v (e φ) N m ⊆ F.interiorPts := by
      intro w hw
      refine ⟨hG.subdom (hball hw), fun hwa => ?_⟩
      obtain ⟨a', ha', hwa'⟩ := mem_iUnion₂.mp hwa
      obtain ⟨-, hT⟩ := hΓ w hw a' ha' hwa'
      exact hgen φ hφ a' ha' ⟨w, hwa', hball hw⟩ hT
    have hpre : IsPreconnected (Rgn v (e φ) N m) := by
      have := isPreconnected_Rgn_lev (y := v) hu hN0 1 (I := Set.univ) ordConnected_univ (m := m)
      simpa using this
    set r := min (1 / 2) (min (1 / (2 * N)) (m / 2)) with hr
    have hr0 : 0 < r := by positivity
    have hr1 : r ≤ 1 / 2 := min_le_left _ _
    have hr2 : r ≤ 1 / (2 * N) := (min_le_right _ _).trans (min_le_left _ _)
    have hr3 : r ≤ m / 2 := (min_le_right _ _).trans (min_le_right _ _)
    have hsub : annSector v 0 r (φ - r) (φ + r) ⊆ Rgn v (e φ) N m := by
      rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
      simp only at hs hθ
      have hrot : rotD v (e φ) (v + (s : ℂ) * e θ) = (s : ℂ) * e (θ - φ) := by
        unfold rotD; rw [e_sub_eq]; ring
      have ht : |θ - φ| < r := abs_sub_lt_iff.mpr ⟨by linarith [hθ.2], by linarith [hθ.1]⟩
      have hcos : 1 / 2 < Real.cos (θ - φ) := by
        have h1 := Real.one_sub_sq_div_two_le_cos (x := θ - φ)
        have h2 : (θ - φ) ^ 2 < 1 / 4 := by
          have := sq_abs (θ - φ); nlinarith [abs_nonneg (θ - φ)]
        linarith
      have hsin : |Real.sin (θ - φ)| < m / 2 := lt_of_le_of_lt Real.abs_sin_le_abs (ht.trans_le hr3)
      have hre : ((s : ℂ) * e (θ - φ)).re = s * Real.cos (θ - φ) := by
        rw [e_eq]; simp only [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im, Complex.ofReal_re,
          Complex.ofReal_im, Complex.I_re, Complex.I_im]; ring
      have him : ((s : ℂ) * e (θ - φ)).im = s * Real.sin (θ - φ) := by
        rw [e_eq]; simp only [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im, Complex.ofReal_re,
          Complex.ofReal_im, Complex.I_re, Complex.I_im]; ring
      have hns : Complex.normSq ((s : ℂ) * e (θ - φ)) = s ^ 2 := by
        rw [Complex.normSq_eq_norm_sq, norm_real_mul_e hs.1.le]
      have hsN : N * s < 1 / 2 := by
        have := hs.2.trans_le hr2
        rw [lt_div_iff₀ (by positivity)] at this; linarith
      show v + (s : ℂ) * e θ ∈ Rgn v (e φ) N m
      refine ⟨fun h => ?_, ?_, ?_⟩
      · have h' : (s : ℂ) * e θ = 0 := by linear_combination h
        rcases mul_eq_zero.mp h' with h1 | h1
        · exact hs.1.ne' (by exact_mod_cast h1)
        · exact e_ne_zero _ h1
      · rw [hrot, hns, hre]; nlinarith [hs.1]
      · rw [hrot, him, hre, abs_mul, abs_of_pos hs.1]
        have : m / 2 < m * Real.cos (θ - φ) := by nlinarith
        nlinarith [hs.1]
    set p := v + ((r / 2 : ℝ) : ℂ) * e φ with hp
    have hpA : p ∈ annSector v 0 r (φ - r) (φ + r) := ⟨(r / 2, φ), ⟨⟨by positivity, by linarith⟩, ⟨by linarith, by linarith⟩⟩, rfl⟩
    have hpI : p ∈ F.interiorPts := hI (hsub hpA)
    have hT : F.IsTile (connectedComponentIn F.interiorPts p) := ⟨p, hpI, rfl⟩
    have hRT := hT.subset_of_preconnected hpre hI (hsub hpA) (mem_connectedComponentIn hpI)
    refine ⟨F.col p, r, hr0, fun w hw => ⟨hI (hsub hw), ?_⟩⟩
    exact hT.col_eq (hRT (hsub hw)) (hRT (hsub hpA))
  haveI : Nonempty (Fin k) := ⟨F.col v⟩
  choose! σ r hr hσ using hex
  exact ⟨σ, fun φ hφ => ⟨r φ, hr φ hφ, hσ φ hφ⟩⟩

/-- **Two preconnected sides bound the colours at a point by two**: if every nonempty open subset of a neighbourhood `N` of `z` meets one
of two preconnected sets of interior points, the colours at `z` are among the colours of those two sets (one each: a preconnected set of
interior points lies in one tile). -/
theorem ncard_coloursAt_le_two_of_sides {z : ℂ} {N N₁ N₂ : Set ℂ} (hN : N ∈ 𝓝 z) (h₁ : IsPreconnected N₁)
    (h₂ : IsPreconnected N₂) (hI₁ : N₁ ⊆ F.interiorPts) (hI₂ : N₂ ⊆ F.interiorPts)
    (hcov : ∀ O : Set ℂ, IsOpen O → O ⊆ N → O.Nonempty → (O ∩ (N₁ ∪ N₂)).Nonempty) : (F.coloursAt z).ncard ≤ 2 := by
  have hsub : F.coloursAt z ⊆ F.col '' N₁ ∪ F.col '' N₂ := by
    intro j hj
    have hO : (F.region j ∩ interior N).Nonempty :=
      (mem_closure_iff.mp hj _ isOpen_interior (mem_interior_iff_mem_nhds.mpr hN)).mono fun y hy => ⟨hy.2, hy.1⟩
    obtain ⟨y, ⟨hyj, -⟩, hy⟩ :=
      hcov _ ((F.isOpen_region j).inter isOpen_interior) (inter_subset_right.trans interior_subset) hO
    rcases hy with hy | hy
    · exact Or.inl ⟨y, hy, hyj.2⟩
    · exact Or.inr ⟨y, hy, hyj.2⟩
  have hone : ∀ {M : Set ℂ}, IsPreconnected M → M ⊆ F.interiorPts → (F.col '' M).ncard ≤ 1 := by
    intro M hM hMI
    refine (Set.ncard_le_one_iff (Set.toFinite _)).mpr ?_
    rintro _ _ ⟨p, hp, rfl⟩ ⟨q, hq, rfl⟩
    have hT : F.IsTile (connectedComponentIn F.interiorPts p) := ⟨p, hMI hp, rfl⟩
    have hs := hT.subset_of_preconnected hM hMI hp (mem_connectedComponentIn (hMI hp))
    exact hT.col_eq (hs hp) (hs hq)
  calc (F.coloursAt z).ncard ≤ (F.col '' N₁ ∪ F.col '' N₂).ncard := Set.ncard_le_ncard hsub
    _ ≤ (F.col '' N₁).ncard + (F.col '' N₂).ncard := Set.ncard_union_le _ _
    _ ≤ 1 + 1 := add_le_add (hone h₁ hI₁) (hone h₂ hI₂)

/-- The circle through `x` about `x + b` is the curve with data `(1, b)`. -/
theorem mem_curveAt_one_iff (x b y : ℂ) : y ∈ curveAt x 1 b ↔ ‖y - (x + b)‖ = ‖b‖ := by
  have h : Complex.normSq (y - (x + b)) = Complex.normSq (y - x) + Complex.normSq b - 2 * ((y - x) * (starRingEnd ℂ) b).re := by
    rw [show y - (x + b) = (y - x) - b by ring, Complex.normSq_sub]
  simp only [curveAt, mem_setOf_eq, one_mul]
  rw [← sq_eq_sq₀ (norm_nonneg _) (norm_nonneg _), ← Complex.normSq_eq_norm_sq, ← Complex.normSq_eq_norm_sq, h]
  constructor <;> intro h' <;> linarith

/-- **In a good ball only the centre carries three colours**: every other point lies on at most one full curve of arcs
(`GoodAt.exists_local_curve`), which it has two sides of. -/
theorem GoodAt.ncard_coloursAt_le_two {x : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt x ρ₀) {z : ℂ} (hz : z ∈ ball x ρ₀) (hzx : z ≠ x) :
    (F.coloursAt z).ncard ≤ 2 := by
  classical
  by_cases hΓ : z ∈ ⋃ a ∈ F.arcs, a.carrier
  · obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp hΓ
    obtain ⟨δ, hδ, hδsub, hcurve⟩ := hG.exists_local_curve hz hzx ha hza
    have hxa : x ∈ a.carrier := hG.through a ha ⟨z, hza, hz⟩
    have hb := Arc.curveData_ne (F.nondegenerate a ha) hxa
    have hzC : z ∈ curveAt x (a.curveData x).1 (a.curveData x).2 := Arc.carrier_subset_curve hxa hza
    have hint : ∀ y ∈ ball z δ, y ∉ curveAt x (a.curveData x).1 (a.curveData x).2 → y ∈ F.interiorPts :=
      fun y hy hyC => ⟨hG.subdom (hδsub hy), fun h => by
        obtain ⟨a', ha', hya'⟩ := mem_iUnion₂.mp h
        exact hyC (hcurve y hy a' ha' hya')⟩
    have hoff := fun O (hO : IsOpen O) (hne : O.Nonempty) =>
      exists_notMem_curveAt (x := x) (Arc.curveData_kappa x a) hb hO hne
    have hκ := Arc.curveData_kappa x a
    generalize (a.curveData x).1 = κ at hκ hzC hint hoff
    generalize (a.curveData x).2 = b at hb hzC hint hoff
    by_cases h0 : κ = 0
    · subst h0
      have hC : ∀ y, y ∈ curveAt x 0 b ↔ (y * (starRingEnd ℂ) b).re = (x * (starRingEnd ℂ) b).re := fun y => by
        simp only [curveAt, mem_setOf_eq, zero_mul, sub_mul, Complex.sub_re]
        constructor <;> intro h <;> linarith
      have hlin : IsLinearMap ℝ fun y : ℂ => (y * (starRingEnd ℂ) b).re :=
        ⟨fun p q => by simp [add_mul], fun r p => by simp [Complex.real_smul, mul_assoc]⟩
      refine ncard_coloursAt_le_two_of_sides (ball_mem_nhds z hδ)
        ((convex_ball z δ).inter (convex_halfSpace_gt hlin (x * (starRingEnd ℂ) b).re)).isPreconnected
        ((convex_ball z δ).inter (convex_halfSpace_lt hlin (x * (starRingEnd ℂ) b).re)).isPreconnected
        (fun y hy => hint y hy.1 fun h => (ne_of_gt hy.2) ((hC y).mp h))
        (fun y hy => hint y hy.1 fun h => (ne_of_lt hy.2) ((hC y).mp h)) fun O hO hON hne => ?_
      obtain ⟨w, hwO, hwC⟩ := hoff O hO hne
      rcases lt_or_gt_of_ne (fun h => hwC ((hC w).mpr h)) with h | h
      · exact ⟨w, hwO, Or.inr ⟨hON hwO, h⟩⟩
      · exact ⟨w, hwO, Or.inl ⟨hON hwO, h⟩⟩
    · -- a circle through `x`: two thin annular sectors about its centre
      obtain rfl : κ = 1 := hκ.resolve_left h0
      have hR0 : 0 < ‖b‖ := norm_pos_iff.mpr hb
      have hC : ∀ y, y ∈ curveAt x 1 b ↔ ‖y - (x + b)‖ = ‖b‖ := fun y => mem_curveAt_one_iff x b y
      have hzpol : z = (x + b) + (‖b‖ : ℂ) * e (0 + Complex.arg ((z - (x + b)) * starRingEnd ℂ (e 0))) := by
        have := eq_add_norm_mul_e (x + b) z 0
        rwa [(hC z).mp hzC] at this
      generalize 0 + Complex.arg ((z - (x + b)) * starRingEnd ℂ (e 0)) = θz at hzpol
      generalize x + b = c at hC hzpol
      generalize ‖b‖ = R at hR0 hC hzpol
      set η := min (R / 2) (δ / (2 * (1 + R))) with hη
      have hη0 : 0 < η := lt_min (by positivity) (by positivity)
      have hηR : η ≤ R / 2 := min_le_left _ _
      have hηδ : η * (2 * (1 + R)) ≤ δ := (le_div_iff₀ (by positivity)).mp (min_le_right _ _)
      have hpol : ∀ s θ : ℝ, 0 ≤ s → ‖c + (s : ℂ) * e θ - c‖ = s := fun s θ hs => by
        rw [add_sub_cancel_left, norm_real_mul_e hs]
      have hNδ : annSector c (R - η) (R + η) (θz - η) (θz + η) ⊆ ball z δ := by
        rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
        simp only at hs hθ
        rw [mem_ball, dist_eq_norm, hzpol]
        have h1 : c + (s : ℂ) * e θ - (c + (R : ℂ) * e θz) = ((s - R : ℝ) : ℂ) * e θ + (R : ℂ) * (e θ - e θz) := by
          push_cast; ring
        have h2 : |s - R| < η := abs_sub_lt_iff.mpr ⟨by linarith [hs.2], by linarith [hs.1]⟩
        have h3 : |θ - θz| < η := abs_sub_lt_iff.mpr ⟨by linarith [hθ.2], by linarith [hθ.1]⟩
        have h4 : ‖e θ - e θz‖ ≤ |θ - θz| := norm_e_sub_e_le θ θz
        rw [h1]
        calc ‖((s - R : ℝ) : ℂ) * e θ + (R : ℂ) * (e θ - e θz)‖
            ≤ ‖((s - R : ℝ) : ℂ) * e θ‖ + ‖(R : ℂ) * (e θ - e θz)‖ := norm_add_le _ _
          _ = |s - R| + R * ‖e θ - e θz‖ := by
              rw [norm_mul, norm_mul, norm_e, mul_one, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs,
                Real.norm_eq_abs, abs_of_pos hR0]
          _ < δ := by nlinarith
      have hNopen : IsOpen (annSector c (R - η) (R + η) (θz - η) (θz + η)) := isOpen_annSector c (by linarith) _ _ _
      have hzN : z ∈ annSector c (R - η) (R + η) (θz - η) (θz + η) :=
        ⟨(R, θz), ⟨⟨by linarith, by linarith⟩, ⟨by linarith, by linarith⟩⟩, hzpol.symm⟩
      have hside : ∀ s θ, s ∈ Ioo (R - η) (R + η) → θ ∈ Ioo (θz - η) (θz + η) → s ≠ R →
          c + (s : ℂ) * e θ ∈ F.interiorPts := fun s θ hs hθ hsR =>
        hint _ (hNδ ⟨(s, θ), ⟨hs, hθ⟩, rfl⟩) fun h => hsR (by rw [← (hC _).mp h, hpol s θ (by linarith [hs.1])])
      refine ncard_coloursAt_le_two_of_sides (hNopen.mem_nhds hzN) (isPreconnected_annSector c (R - η) R (θz - η) (θz + η))
        (isPreconnected_annSector c R (R + η) (θz - η) (θz + η)) ?_ ?_ fun O hO hON hne => ?_
      · rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
        exact hside s θ ⟨hs.1, by linarith [hs.2]⟩ hθ hs.2.ne
      · rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
        exact hside s θ ⟨by linarith [hs.1], hs.2⟩ hθ hs.1.ne'
      · obtain ⟨w, hwO, hwC⟩ := hoff O hO hne
        obtain ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ := hON hwO
        have hsR : s ≠ R := fun h => hwC ((hC _).mpr (by rw [hpol s θ (by linarith [hs.1]), h]))
        rcases lt_or_gt_of_ne hsR with h | h
        · exact ⟨_, hwO, Or.inl ⟨(s, θ), ⟨⟨hs.1, h⟩, hθ⟩, rfl⟩⟩
        · exact ⟨_, hwO, Or.inr ⟨(s, θ), ⟨⟨h, hs.2⟩, hθ⟩, rfl⟩⟩
  · have hzI : z ∈ F.interiorPts := ⟨hG.subdom hz, hΓ⟩
    obtain ⟨r, hr, hrI⟩ := Metric.isOpen_iff.mp F.isOpen_interiorPts z hzI
    exact ncard_coloursAt_le_two_of_sides (ball_mem_nhds z hr) (convex_ball z r).isPreconnected
      (convex_ball z r).isPreconnected hrI hrI fun O _ hON hne => hne.mono fun y hy => ⟨hy, Or.inl (hON hy)⟩

/-- **Points of three or more colours are finite on a compact subset of the domain** (finitely many good balls cover it, each holding at
most its centre). -/
theorem finite_three_le_coloursAt {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ F.dom) :
    {v ∈ K | 3 ≤ (F.coloursAt v).ncard}.Finite := by
  classical
  have hex : ∀ x ∈ K, ∃ ρ₀, F.GoodAt x ρ₀ := fun x hx => F.exists_goodAt (hKd hx)
  choose! ρ hρ using hex
  obtain ⟨t, htK, hcov⟩ := hK.elim_nhds_subcover (fun x => ball x (ρ x)) fun x hx => ball_mem_nhds x (hρ x hx).pos
  refine t.finite_toSet.subset ?_
  rintro v ⟨hvK, hv3⟩
  obtain ⟨x, hxt, hvx⟩ := mem_iUnion₂.mp (hcov hvK)
  by_contra hvt
  have hne : v ≠ x := fun h => hvt (h ▸ hxt)
  have := (hρ x (htK x hxt)).ncard_coloursAt_le_two hvx hne
  omega

/-! ## The picture from the local data (FS131-IWd): side colours, runs and horns -/

/-- **Cones are local in direction**: a set approaching `v` along `δ` does so inside every thin truncated cone about `δ`. -/
theorem mem_coneAt_inter_annSector {S : Set ℂ} {v : ℂ} {δ : ℝ} (h : δ ∈ coneAt S v) {r η : ℝ} (hr : 0 < r) (hη : 0 < η) :
    δ ∈ coneAt (S ∩ annSector v 0 r (δ - η) (δ + η)) v := by
  have hcont : ContinuousAt Complex.arg 1 := Complex.continuousAt_arg (by simp [Complex.slitPlane])
  obtain ⟨κ, hκ, hball⟩ := Metric.continuousAt_iff.mp hcont η hη
  intro ε hε
  obtain ⟨z, hzS, hzv, hzd, hdir⟩ := h (min ε (min r κ)) (by positivity)
  refine ⟨z, ⟨hzS, ?_⟩, hzv, hzd.trans_le (min_le_left _ _), hdir.trans_le (min_le_left _ _)⟩
  have hn : 0 < ‖z - v‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hzv)
  have hpol := eq_add_norm_mul_e v z δ
  set u := (z - v) / (‖z - v‖ : ℂ) * starRingEnd ℂ (e δ) with hu
  have hu1 : dist u 1 < κ := by
    rw [dist_eq_norm, hu, show (z - v) / (‖z - v‖ : ℂ) * starRingEnd ℂ (e δ) - 1 =
      ((z - v) / (‖z - v‖ : ℂ) - e δ) * starRingEnd ℂ (e δ) by rw [sub_mul, e_mul_conj_e], norm_mul,
      Complex.norm_conj, norm_e, mul_one]
    exact hdir.trans_le ((min_le_right _ _).trans (min_le_right _ _))
  have hn' : ((‖z - v‖ : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hn.ne'
  have harg : Complex.arg ((z - v) * starRingEnd ℂ (e δ)) = Complex.arg u := by
    rw [hu, show (z - v) * starRingEnd ℂ (e δ) = ((‖z - v‖ : ℝ) : ℂ) * ((z - v) / (‖z - v‖ : ℂ) * starRingEnd ℂ (e δ)) by
      field_simp, Complex.arg_real_mul _ hn]
  have h1 := hball hu1
  rw [Complex.arg_one, Real.dist_eq, sub_zero] at h1
  rw [← harg] at h1
  have h2 := abs_lt.mp h1
  refine ⟨(‖z - v‖, δ + Complex.arg ((z - v) * starRingEnd ℂ (e δ))), ⟨⟨hn, ?_⟩, ⟨by linarith, by linarith⟩⟩, hpol.symm⟩
  rw [← dist_eq_norm]; exact hzd.trans_le ((min_le_right _ _).trans (min_le_left _ _))

section DirColour

variable {v : ℂ} {D : Finset ℝ} {σ : ℝ → Fin k}

/-- Off `D`, a direction is in the cone of its own colour's class. -/
theorem DirColourAt.mem_coneAt (hD : F.DirColourAt v D σ) {φ : ℝ} (hφ : OffDirs D φ) :
    φ ∈ coneAt (F.region (σ φ)) v := by
  obtain ⟨r, hr, hsub⟩ := hD φ hφ
  exact coneAt_mono hsub v (mem_coneAt_annSector v hr ⟨by linarith, by linarith⟩)

/-- Off `D`, only the direction's own colour approaches along it. -/
theorem DirColourAt.eq_of_mem_coneAt (hD : F.DirColourAt v D σ) {φ : ℝ} (hφ : OffDirs D φ) {j : Fin k}
    (h : φ ∈ coneAt (F.region j) v) : j = σ φ := by
  obtain ⟨r, hr, hsub⟩ := hD φ hφ
  obtain ⟨z, ⟨hzj, hzA⟩, -⟩ := mem_coneAt_inter_annSector h hr hr 1 one_pos
  have h1 : F.col z = j := hzj.2
  have h2 : F.col z = σ φ := (hsub hzA).2
  exact h1.symm.trans h2

/-- The colour is locally constant off `D`. -/
theorem DirColourAt.eq_of_near (hD : F.DirColourAt v D σ) {φ : ℝ} (hφ : OffDirs D φ) :
    ∃ r > 0, ∀ ψ, |ψ - φ| < r → OffDirs D ψ → σ ψ = σ φ := by
  obtain ⟨r, hr, hsub⟩ := hD φ hφ
  refine ⟨r, hr, fun ψ hψ hψD => (hD.eq_of_mem_coneAt hψD ?_).symm⟩
  have := abs_lt.mp hψ
  exact coneAt_mono hsub v (mem_coneAt_annSector v hr ⟨by linarith, by linarith⟩)

/-- The colour is `2π`-periodic off `D`. -/
theorem DirColourAt.eq_add_int (hD : F.DirColourAt v D σ) {φ : ℝ} (hφ : OffDirs D φ) (m : ℤ) :
    σ (φ + 2 * π * m) = σ φ :=
  (hD.eq_of_mem_coneAt ((offDirs_add_int m).mpr hφ)
    ((periodic_int (fun _ => mem_coneAt_add_two_pi) φ m).mpr (hD.mem_coneAt hφ))).symm

/-- The colour is constant on an open interval of directions off `D`. -/
theorem DirColourAt.eq_of_Ioo (hD : F.DirColourAt v D σ) {a b : ℝ} (hab : ∀ φ ∈ Ioo a b, OffDirs D φ) {φ ψ : ℝ}
    (hφ : φ ∈ Ioo a b) (hψ : ψ ∈ Ioo a b) : σ φ = σ ψ := by
  refine isPreconnected_Ioo.constant (fun x hx => ?_) hφ hψ
  obtain ⟨r, hr, h⟩ := hD.eq_of_near (hab x hx)
  refine (tendsto_nhds_of_eventually_eq ?_ : Tendsto σ (𝓝[Ioo a b] x) (𝓝 (σ x)))
  filter_upwards [nhdsWithin_le_nhds (Metric.ball_mem_nhds x hr), self_mem_nhdsWithin] with y hy hyI
  exact h y (by rw [mem_ball, Real.dist_eq] at hy; exact hy) (hab y hyI)

/-- Just counter-clockwise of `β` the colour is `rightCol`. -/
theorem DirColourAt.eq_rightCol (hD : F.DirColourAt v D σ) {β φ : ℝ} (hφ : φ ∈ Ioo β (β + isoRad D β)) :
    σ φ = rightCol D σ β := by
  have hoff : ∀ ψ ∈ Ioo β (β + isoRad D β), OffDirs D ψ := fun ψ hψ =>
    offDirs_of_isoRad (ne_of_gt hψ.1) (by rw [abs_of_pos (by linarith [hψ.1])]; linarith [hψ.2])
  have := isoRad_pos D β
  exact hD.eq_of_Ioo hoff hφ ⟨by linarith, by linarith⟩

/-- Just clockwise of `β` the colour is `leftCol`. -/
theorem DirColourAt.eq_leftCol (hD : F.DirColourAt v D σ) {β φ : ℝ} (hφ : φ ∈ Ioo (β - isoRad D β) β) :
    σ φ = leftCol D σ β := by
  have hoff : ∀ ψ ∈ Ioo (β - isoRad D β) β, OffDirs D ψ := fun ψ hψ =>
    offDirs_of_isoRad (ne_of_lt hψ.2) (by rw [abs_of_neg (by linarith [hψ.2])]; linarith [hψ.1])
  have := isoRad_pos D β
  exact hD.eq_of_Ioo hoff hφ ⟨by linarith, by linarith⟩

/-- `rightCol` is the colour of any right half-neighbourhood. -/
theorem DirColourAt.rightCol_eq_of (hD : F.DirColourAt v D σ) {β t : ℝ} {c : Fin k} (ht : 0 < t)
    (h : ∀ φ ∈ Ioo β (β + t), OffDirs D φ → σ φ = c) : rightCol D σ β = c := by
  have h0 := lt_min ht (isoRad_pos D β)
  obtain ⟨φ, hφ, hφD⟩ := exists_offDirs_Ioo D (show β < β + min t (isoRad D β) by linarith)
  rw [← hD.eq_rightCol ⟨hφ.1, hφ.2.trans_le (by linarith [min_le_right t (isoRad D β)])⟩]
  exact h φ ⟨hφ.1, hφ.2.trans_le (by linarith [min_le_left t (isoRad D β)])⟩ hφD

/-- `leftCol` is the colour of any left half-neighbourhood. -/
theorem DirColourAt.leftCol_eq_of (hD : F.DirColourAt v D σ) {β t : ℝ} {c : Fin k} (ht : 0 < t)
    (h : ∀ φ ∈ Ioo (β - t) β, OffDirs D φ → σ φ = c) : leftCol D σ β = c := by
  have h0 := lt_min ht (isoRad_pos D β)
  obtain ⟨φ, hφ, hφD⟩ := exists_offDirs_Ioo D (show β - min t (isoRad D β) < β by linarith)
  rw [← hD.eq_leftCol ⟨(by linarith [min_le_right t (isoRad D β)] : β - isoRad D β ≤ β - min t (isoRad D β)).trans_lt hφ.1, hφ.2⟩]
  exact h φ ⟨(by linarith [min_le_left t (isoRad D β)] : β - t ≤ β - min t (isoRad D β)).trans_lt hφ.1, hφ.2⟩ hφD

/-- Off `D` both side colours are the colour itself. -/
theorem DirColourAt.rightCol_of_offDirs (hD : F.DirColourAt v D σ) {β : ℝ} (hβ : OffDirs D β) :
    rightCol D σ β = σ β ∧ leftCol D σ β = σ β := by
  have hoff : ∀ ψ ∈ Ioo (β - isoRad D β) (β + isoRad D β), OffDirs D ψ := fun ψ hψ => by
    by_cases h : ψ = β
    · rw [h]; exact hβ
    · exact offDirs_of_isoRad h (abs_lt.mpr ⟨by linarith [hψ.1], by linarith [hψ.2]⟩)
  have := isoRad_pos D β
  exact ⟨hD.eq_of_Ioo hoff ⟨by linarith, by linarith⟩ ⟨by linarith, by linarith⟩,
    hD.eq_of_Ioo hoff ⟨by linarith, by linarith⟩ ⟨by linarith, by linarith⟩⟩

/-- `rightCol` is `2π`-periodic. -/
theorem DirColourAt.rightCol_add_int (hD : F.DirColourAt v D σ) (β : ℝ) (m : ℤ) :
    rightCol D σ (β + 2 * π * m) = rightCol D σ β := by
  refine hD.rightCol_eq_of (isoRad_pos D β) fun φ hφ hφD => ?_
  have h1 : φ - 2 * π * m ∈ Ioo β (β + isoRad D β) := ⟨by linarith [hφ.1], by linarith [hφ.2]⟩
  have h2 : OffDirs D (φ - 2 * π * m) := (offDirs_add_int m).mp (by rwa [sub_add_cancel])
  have h3 := hD.eq_add_int h2 m
  rw [sub_add_cancel] at h3
  rw [h3]; exact hD.eq_rightCol h1

/-- `leftCol` is `2π`-periodic. -/
theorem DirColourAt.leftCol_add_int (hD : F.DirColourAt v D σ) (β : ℝ) (m : ℤ) :
    leftCol D σ (β + 2 * π * m) = leftCol D σ β := by
  refine hD.leftCol_eq_of (isoRad_pos D β) fun φ hφ hφD => ?_
  have h1 : φ - 2 * π * m ∈ Ioo (β - isoRad D β) β := ⟨by linarith [hφ.1], by linarith [hφ.2]⟩
  have h2 : OffDirs D (φ - 2 * π * m) := (offDirs_add_int m).mp (by rwa [sub_add_cancel])
  have h3 := hD.eq_add_int h2 m
  rw [sub_add_cancel] at h3
  rw [h3]; exact hD.eq_leftCol h1

/-- The right colour approaches along `β`. -/
theorem DirColourAt.rightCol_mem_coneAt (hD : F.DirColourAt v D σ) (β : ℝ) :
    β ∈ coneAt (F.region (rightCol D σ β)) v := by
  have hI : Ioo β (β + isoRad D β) ⊆ coneAt (F.region (rightCol D σ β)) v := fun φ hφ => by
    have hφD : OffDirs D φ := offDirs_of_isoRad (ne_of_gt hφ.1) (by rw [abs_of_pos (by linarith [hφ.1])]; linarith [hφ.2])
    rw [← hD.eq_rightCol hφ]; exact hD.mem_coneAt hφD
  have := isoRad_pos D β
  exact closure_minimal hI (isClosed_coneAt _ _) (by rw [closure_Ioo (ne_of_lt (by linarith))]; exact ⟨le_rfl, by linarith⟩)

/-- The left colour approaches along `β`. -/
theorem DirColourAt.leftCol_mem_coneAt (hD : F.DirColourAt v D σ) (β : ℝ) :
    β ∈ coneAt (F.region (leftCol D σ β)) v := by
  have hI : Ioo (β - isoRad D β) β ⊆ coneAt (F.region (leftCol D σ β)) v := fun φ hφ => by
    have hφD : OffDirs D φ := offDirs_of_isoRad (ne_of_lt hφ.2) (by rw [abs_of_neg (by linarith [hφ.2])]; linarith [hφ.1])
    rw [← hD.eq_leftCol hφ]; exact hD.mem_coneAt hφD
  have := isoRad_pos D β
  exact closure_minimal hI (isClosed_coneAt _ _) (by rw [closure_Ioo (ne_of_lt (by linarith))]; exact ⟨by linarith, le_rfl⟩)

/-- A change of colour happens only at a direction of `D` (mod `2π`). -/
theorem DirColourAt.not_offDirs_of_ne (hD : F.DirColourAt v D σ) {β : ℝ} (h : leftCol D σ β ≠ rightCol D σ β) :
    ¬ OffDirs D β := fun hβ => h (by rw [(hD.rightCol_of_offDirs hβ).1, (hD.rightCol_of_offDirs hβ).2])

/-- **Between two directions with no change of colour strictly between, the colour is constant.** -/
theorem DirColourAt.const_of_noChange (hD : F.DirColourAt v D σ) {a b : ℝ} (hab : a < b)
    (hno : ∀ y ∈ Ioo a b, leftCol D σ y = rightCol D σ y) :
    rightCol D σ a = leftCol D σ b ∧ ∀ y ∈ Ioo a b, OffDirs D y → σ y = rightCol D σ a := by
  have hloc : ∀ y ∈ Ioo a b, ∀ z, |z - y| < isoRad D y → rightCol D σ z = rightCol D σ y := by
    intro y hy z hz
    by_cases hzy : z = y
    · rw [hzy]
    have hzD : OffDirs D z := offDirs_of_isoRad hzy hz
    rw [(hD.rightCol_of_offDirs hzD).1]
    rcases lt_or_gt_of_ne hzy with h | h
    · rw [← hno y hy]; exact hD.eq_leftCol ⟨by linarith [(abs_lt.mp hz).1], h⟩
    · exact hD.eq_rightCol ⟨h, by linarith [(abs_lt.mp hz).2]⟩
  have hconst : ∀ y ∈ Ioo a b, ∀ z ∈ Ioo a b, rightCol D σ y = rightCol D σ z := fun y hy z hz => by
    refine isPreconnected_Ioo.constant (fun x hx => ?_) hy hz
    refine (tendsto_nhds_of_eventually_eq ?_ : Tendsto (rightCol D σ) (𝓝[Ioo a b] x) (𝓝 (rightCol D σ x)))
    filter_upwards [nhdsWithin_le_nhds (Metric.ball_mem_nhds x (isoRad_pos D x))] with z hz
    exact hloc x hx z (by rw [mem_ball, Real.dist_eq] at hz; exact hz)
  have ha := isoRad_pos D a
  have hb := isoRad_pos D b
  have hu1 := min_le_left (isoRad D a) (b - a)
  have hu2 := min_le_right (isoRad D a) (b - a)
  have hu3 := min_le_left (isoRad D b) (b - a)
  have hu4 := min_le_right (isoRad D b) (b - a)
  have hu5 : 0 < min (isoRad D a) (b - a) := lt_min ha (by linarith)
  have hu6 : 0 < min (isoRad D b) (b - a) := lt_min hb (by linarith)
  set y₁ := a + min (isoRad D a) (b - a) / 2 with hy₁
  set y₂ := b - min (isoRad D b) (b - a) / 2 with hy₂
  have hy₁I : y₁ ∈ Ioo a b := ⟨by linarith, by linarith⟩
  have hy₂I : y₂ ∈ Ioo a b := ⟨by linarith, by linarith⟩
  have hy₁D : OffDirs D y₁ := offDirs_of_isoRad (β := a) (by linarith) (by rw [abs_of_pos (by linarith)]; linarith)
  have hy₂D : OffDirs D y₂ := offDirs_of_isoRad (β := b) (by linarith) (by rw [abs_of_neg (by linarith)]; linarith)
  have e1 : rightCol D σ a = rightCol D σ y₁ := by
    rw [(hD.rightCol_of_offDirs hy₁D).1]; exact (hD.eq_rightCol ⟨by linarith, by linarith⟩).symm
  have e2 : leftCol D σ b = rightCol D σ y₂ := by
    rw [(hD.rightCol_of_offDirs hy₂D).1]; exact (hD.eq_leftCol ⟨by linarith, by linarith⟩).symm
  refine ⟨by rw [e1, e2]; exact hconst _ hy₁I _ hy₂I, fun y hy hyD => ?_⟩
  rw [e1, ← (hD.rightCol_of_offDirs hyD).1]; exact hconst _ hy _ hy₁I

/-- A colour constant on an interval leaves no change of colour inside it. -/
theorem DirColourAt.noChange_of_const (hD : F.DirColourAt v D σ) {a b y : ℝ} {c : Fin k} (hy : y ∈ Ioo a b)
    (h : ∀ φ ∈ Ioo a b, OffDirs D φ → σ φ = c) : leftCol D σ y = rightCol D σ y := by
  rw [hD.leftCol_eq_of (sub_pos.mpr hy.1) (fun φ hφ hφD => h φ ⟨by linarith [hφ.1], hφ.2.trans hy.2⟩ hφD),
    hD.rightCol_eq_of (sub_pos.mpr hy.2) (fun φ hφ hφD => h φ ⟨hy.1.trans hφ.1, by linarith [hφ.2]⟩ hφD)]

end DirColour

/-- **The `NiceAt` picture from the local data** (E3-NICE's last paragraph): if every colour's directions off `D` form one arc of the circle
(`hrun`) and no colour's cone meets a direction of `D` strictly inside another colour's arc (`hpoke`), a point of three or more colours is
`NiceAt` — the arcs, in order, are the positive sectors, and at each change of colour the other colours whose cones hold that direction are
horns, each once. -/
theorem niceAt_of_dirColourAt {v : ℂ} (hv : v ∈ F.dom) {D : Finset ℝ} {σ : ℝ → Fin k} (hD : F.DirColourAt v D σ)
    (hrun : ∀ φ₁ φ₂ : ℝ, OffDirs D φ₁ → OffDirs D φ₂ → φ₁ < φ₂ → φ₂ < φ₁ + 2 * π → σ φ₁ = σ φ₂ →
      (∀ φ ∈ Ioo φ₁ φ₂, OffDirs D φ → σ φ = σ φ₁) ∨ (∀ φ ∈ Ioo φ₂ (φ₁ + 2 * π), OffDirs D φ → σ φ = σ φ₁))
    (hpoke : ∀ δ ∈ D, ∀ j c : Fin k, δ ∈ coneAt (F.region j) v →
      (∃ t > 0, ∀ φ ∈ Ioo (δ - t) (δ + t), OffDirs D φ → σ φ = c) → j = c)
    (h3 : 3 ≤ (F.coloursAt v).ncard) : F.NiceAt v := by
  classical
  have _ := h3
  have hπ := Real.pi_pos
  have hp : (0 : ℝ) < 2 * π := by positivity
  -- at a direction with no change of colour, only the run's colour approaches `v` (`hpoke`, at every direction)
  have hnc : ∀ β (j : Fin k), leftCol D σ β = rightCol D σ β → β ∈ coneAt (F.region j) v → j = rightCol D σ β := by
    intro β j hLR hj
    by_cases hβ : OffDirs D β
    · rw [hD.eq_of_mem_coneAt hβ hj, (hD.rightCol_of_offDirs hβ).1]
    · simp only [OffDirs, not_forall, not_not] at hβ
      obtain ⟨δ, hδ, m, rfl⟩ := hβ
      refine hpoke δ hδ j _ ((periodic_int (fun _ => mem_coneAt_add_two_pi) δ m).mp hj)
        ⟨isoRad D (δ + 2 * π * m), isoRad_pos _ _, fun φ hφ hφD => ?_⟩
      rw [← hD.eq_add_int hφD m]
      rcases lt_trichotomy (φ + 2 * π * m) (δ + 2 * π * m) with h | h | h
      · rw [← hLR]; exact hD.eq_leftCol ⟨by linarith [hφ.1], h⟩
      · exact absurd (show φ = δ + 2 * π * ((0 : ℤ) : ℝ) by push_cast; linarith) (hφD δ hδ 0)
      · exact hD.eq_rightCol ⟨h, by linarith [hφ.2]⟩
  -- a window `[θ₀, θ₀ + 2π)` starting off `D`, and the directions of `D` in it
  obtain ⟨θ₀, -, hθ₀⟩ := exists_offDirs_Ioo D zero_lt_one
  obtain ⟨Pw, hPw⟩ : ∃ Pw : Finset ℝ, ∀ y, y ∈ Pw ↔ y ∈ Ico θ₀ (θ₀ + 2 * π) ∧ ¬ OffDirs D y := by
    refine ⟨D.image (toIcoMod hp θ₀), fun y => ⟨fun hy => ?_, fun ⟨hy1, hy2⟩ => ?_⟩⟩
    · obtain ⟨δ, hδ, rfl⟩ := Finset.mem_image.mp hy
      refine ⟨toIcoMod_mem_Ico hp θ₀ δ, fun h => h δ hδ (-toIcoDiv hp θ₀ δ) ?_⟩
      rw [← self_sub_toIcoDiv_zsmul, zsmul_eq_mul]; push_cast; ring
    · simp only [OffDirs, not_forall, not_not] at hy2
      obtain ⟨δ, hδ, m, hm⟩ := hy2
      refine Finset.mem_image.mpr ⟨δ, hδ, ?_⟩
      rw [toIcoMod_eq_iff]
      exact ⟨hy1, -m, by rw [hm, zsmul_eq_mul]; push_cast; ring⟩
  have hPw_win : ∀ y ∈ Pw, y ∈ Ioo θ₀ (θ₀ + 2 * π) := fun y hy => by
    obtain ⟨h1, h2⟩ := (hPw y).mp hy
    exact ⟨lt_of_le_of_ne h1.1 fun h => h2 (h ▸ hθ₀), h1.2⟩
  -- the horn colours at a direction
  obtain ⟨Hs, hHs⟩ : ∃ Hs : ℝ → Finset (Fin k), ∀ q j, j ∈ Hs q ↔
      (q ∈ coneAt (F.region j) v ∧ j ≠ leftCol D σ q ∧ j ≠ rightCol D σ q) :=
    ⟨fun q => Finset.univ.filter fun j => q ∈ coneAt (F.region j) v ∧ j ≠ leftCol D σ q ∧ j ≠ rightCol D σ q,
      fun q j => by simp⟩
  have hHs_ne : ∀ q (j : Fin k), j ∈ Hs q → j ≠ leftCol D σ q ∧ j ≠ rightCol D σ q := fun q j h =>
    ⟨((hHs q j).mp h).2.1, ((hHs q j).mp h).2.2⟩
  -- the sectors as (direction, rank): rank `j < k` a horn of colour `j`, rank `k` the run starting there
  obtain ⟨S0, hS0mem⟩ : ∃ S0 : Finset (ℝ × ℕ), ∀ p, p ∈ S0 ↔ p.1 ∈ Pw ∧
      ((p.2 < k ∧ ∃ j ∈ Hs p.1, (j : ℕ) = p.2) ∨ (p.2 = k ∧ leftCol D σ p.1 ≠ rightCol D σ p.1)) := by
    refine ⟨(Pw ×ˢ Finset.range (k + 1)).filter fun p =>
      (p.2 < k ∧ ∃ j ∈ Hs p.1, (j : ℕ) = p.2) ∨ (p.2 = k ∧ leftCol D σ p.1 ≠ rightCol D σ p.1), fun p => ?_⟩
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_range]
    constructor
    · rintro ⟨⟨h1, -⟩, h2⟩; exact ⟨h1, h2⟩
    · rintro ⟨h1, h2⟩
      refine ⟨⟨h1, ?_⟩, h2⟩
      rcases h2 with ⟨h, -⟩ | ⟨h, -⟩ <;> omega
  have hch : ∀ p ∈ S0, leftCol D σ p.1 ≠ rightCol D σ p.1 := by
    intro p hp
    rcases ((hS0mem p).mp hp).2 with ⟨-, j, hj, -⟩ | ⟨-, h⟩
    · intro hLR
      exact (hHs_ne _ _ hj).2 (hnc _ _ hLR ((hHs _ _).mp hj).1)
    · exact h
  have hrun_mem : ∀ p ∈ S0, (p.1, k) ∈ S0 := fun p hp =>
    (hS0mem _).mpr ⟨((hS0mem p).mp hp).1, Or.inr ⟨rfl, hch p hp⟩⟩
  have hrank : ∀ p ∈ S0, p.2 ≤ k := fun p hp => by
    rcases ((hS0mem p).mp hp).2 with ⟨h, -⟩ | ⟨h, -⟩ <;> omega
  by_cases hS : S0 = ∅
  · -- no change of colour anywhere: one run, one sector
    have hno : ∀ y, leftCol D σ y = rightCol D σ y := by
      intro y
      by_contra hy
      obtain ⟨m, hm⟩ := exists_shift_Ico θ₀ y
      have hy' : leftCol D σ (y + 2 * π * m) ≠ rightCol D σ (y + 2 * π * m) := by
        rwa [hD.leftCol_add_int, hD.rightCol_add_int]
      have := (hS0mem (y + 2 * π * m, k)).mpr ⟨(hPw _).mpr ⟨hm, hD.not_offDirs_of_ne hy'⟩, Or.inr ⟨rfl, hy'⟩⟩
      rw [hS] at this; simp at this
    have hconst := hD.const_of_noChange (show θ₀ - 2 * π < θ₀ + 2 * π by linarith) fun y _ => hno y
    have hσ : ∀ φ, OffDirs D φ → σ φ = σ θ₀ := by
      intro φ hφ
      obtain ⟨m, hm⟩ := exists_shift_Ico θ₀ φ
      rw [← hD.eq_add_int hφ m, hconst.2 _ ⟨by linarith [hm.1], hm.2⟩ ((offDirs_add_int m).mpr hφ),
        ← hconst.2 θ₀ ⟨by linarith, by linarith⟩ hθ₀]
    have hRc : ∀ β, rightCol D σ β = σ θ₀ := fun β => by
      obtain ⟨φ, hφ, hφD⟩ := exists_offDirs_Ioo D (show β < β + isoRad D β by linarith [isoRad_pos D β])
      rw [← hD.eq_rightCol hφ]; exact hσ φ hφD
    have hall : angleIcc θ₀ (θ₀ + 2 * π) = univ := eq_univ_of_forall fun β => by
      obtain ⟨m, hm⟩ := exists_shift_Ico θ₀ β
      exact mem_iUnion.mpr ⟨-m, by push_cast; constructor <;> linarith [hm.1, hm.2]⟩
    refine ⟨1, ![θ₀, θ₀ + 2 * π], fun _ => σ θ₀, ⟨one_pos, fun a b hab => ?_, by simp, fun h => by omega, hv, fun j => ?_⟩,
      fun i j hij => absurd (Subsingleton.elim i j) hij, fun i hi => ?_⟩
    · fin_cases a <;> fin_cases b <;> simp at hab ⊢
      linarith
    · ext β
      simp only [mem_iUnion, mem_setOf_eq, exists_prop]
      by_cases h : σ θ₀ = j
      · subst h
        refine ⟨fun _ => ⟨0, rfl, ?_⟩, fun _ => by rw [← hRc β]; exact hD.rightCol_mem_coneAt β⟩
        show β ∈ angleIcc θ₀ (θ₀ + 2 * π)
        rw [hall]; trivial
      · exact ⟨fun hβ => absurd ((hnc β j (hno β) hβ).trans (hRc β)).symm h, fun ⟨_, h', _⟩ => absurd h' h⟩
    · fin_cases i
      have : θ₀ = θ₀ + 2 * π := hi
      linarith
  -- sort the sectors
  obtain ⟨n, pf, hn0, hpfS, hS0pf, hpflt⟩ : ∃ (n : ℕ) (pf : Fin n → ℝ × ℕ), 0 < n ∧ (∀ i, pf i ∈ S0) ∧
      (∀ p ∈ S0, ∃ i, pf i = p) ∧
      ∀ i j, i < j ↔ ((pf i).1 < (pf j).1 ∨ ((pf i).1 = (pf j).1 ∧ (pf i).2 < (pf j).2)) := by
    set S : Finset (Lex (ℝ × ℕ)) := S0.map toLex.toEmbedding with hSdef
    set f := S.orderEmbOfFin rfl
    refine ⟨S.card, fun i => ofLex (f i), ?_, fun i => ?_, fun p hp => ?_, fun i j => ?_⟩
    · exact Finset.card_pos.mpr ((Finset.nonempty_iff_ne_empty.mpr hS).map)
    · obtain ⟨p, hp, hpf⟩ := Finset.mem_map.mp (S.orderEmbOfFin_mem rfl i)
      show ofLex (f i) ∈ S0
      rw [← hpf]; exact hp
    · have h1 : toLex p ∈ (S : Set (Lex (ℝ × ℕ))) := by rw [hSdef, Finset.coe_map]; exact ⟨p, hp, rfl⟩
      rw [← Finset.range_orderEmbOfFin S rfl] at h1
      obtain ⟨i, hi⟩ := h1
      exact ⟨i, by show ofLex (f i) = p; rw [hi]; rfl⟩
    · show i < j ↔ (ofLex (f i)).1 < (ofLex (f j)).1 ∨ ((ofLex (f i)).1 = (ofLex (f j)).1 ∧ (ofLex (f i)).2 < (ofLex (f j)).2)
      rw [← Prod.Lex.lt_iff]; exact f.lt_iff_lt.symm
  have hle : ∀ i j : Fin n, i ≤ j → (pf i).1 ≤ (pf j).1 := fun i j h => by
    rcases eq_or_lt_of_le h with rfl | h
    · exact le_rfl
    · rcases (hpflt i j).mp h with h' | h'
      · exact h'.le
      · exact h'.1.le
  have hinj : ∀ i j : Fin n, pf i = pf j → i = j := fun i j h => by
    by_contra hne
    rcases lt_or_gt_of_ne hne with h' | h'
    · rcases (hpflt i j).mp h' with h'' | h''
      · rw [h] at h''; exact lt_irrefl _ h''
      · rw [h] at h''; exact lt_irrefl _ h''.2
    · rcases (hpflt j i).mp h' with h'' | h''
      · rw [h] at h''; exact lt_irrefl _ h''
      · rw [h] at h''; exact lt_irrefl _ h''.2
  have hq_win : ∀ i, (pf i).1 ∈ Ioo θ₀ (θ₀ + 2 * π) := fun i => hPw_win _ ((hS0mem _).mp (hpfS i)).1
  obtain ⟨d, hdc, hds1, hds2, hlast, hmono⟩ : ∃ d : Fin (n + 1) → ℝ, (∀ i : Fin n, d i.castSucc = (pf i).1) ∧
      (∀ (i : Fin n) (h : (i : ℕ) + 1 < n), d i.succ = (pf ⟨i + 1, h⟩).1) ∧
      (∀ i : Fin n, ¬ (i : ℕ) + 1 < n → d i.succ = (pf ⟨0, hn0⟩).1 + 2 * π) ∧
      d (Fin.last n) = d 0 + 2 * π ∧ Monotone d := by
    refine ⟨fun i => if h : (i : ℕ) < n then (pf ⟨i, h⟩).1 else (pf ⟨0, hn0⟩).1 + 2 * π, fun i => ?_, fun i h => ?_,
      fun i h => ?_, ?_, fun a b hab => ?_⟩
    · simp [i.isLt]
    · simp [h]
    · simp [h]
    · simp [hn0]
    · simp only
      split_ifs with h1 h2 h2
      · exact hle _ _ (Fin.le_def.mpr (Fin.le_def.mp hab))
      · linarith [(hq_win ⟨a, h1⟩).2, (hq_win ⟨0, hn0⟩).1]
      · exact absurd ((Fin.le_def.mp hab).trans_lt h2) h1
      · exact le_rfl
  obtain ⟨c, hc_horn, hc_run⟩ : ∃ c : Fin n → Fin k, (∀ i (h : (pf i).2 < k), c i = ⟨(pf i).2, h⟩) ∧
      (∀ i, (pf i).2 = k → c i = rightCol D σ (pf i).1) :=
    ⟨fun i => if h : (pf i).2 < k then ⟨(pf i).2, h⟩ else rightCol D σ (pf i).1, fun i h => dif_pos h,
      fun i h => dif_neg (by omega)⟩
  have hfr_succ : ∀ (i : Fin n) (h : (i : ℕ) + 1 < n), finRotate n i = ⟨i + 1, h⟩ := fun i h =>
    Fin.ext (by rw [finRotate_val, if_pos h])
  have hfr_last : ∀ i : Fin n, ¬ (i : ℕ) + 1 < n → finRotate n i = ⟨0, hn0⟩ := fun i h =>
    Fin.ext (by rw [finRotate_val, if_neg h])
  have hhornHs : ∀ (i : Fin n) (h : (pf i).2 < k), (⟨(pf i).2, h⟩ : Fin k) ∈ Hs (pf i).1 := by
    intro i h
    rcases ((hS0mem _).mp (hpfS i)).2 with ⟨-, j, hj, hjv⟩ | ⟨h', -⟩
    · have : j = ⟨(pf i).2, h⟩ := Fin.ext hjv
      rwa [← this]
    · omega
  -- after a horn comes the next sector at the same direction
  have hnext_horn : ∀ i : Fin n, (pf i).2 < k →
      ∃ h : (i : ℕ) + 1 < n, (pf ⟨i + 1, h⟩).1 = (pf i).1 ∧ (pf i).2 < (pf ⟨i + 1, h⟩).2 := by
    intro i hik
    obtain ⟨i', hi'⟩ := hS0pf _ (hrun_mem _ (hpfS i))
    have hii' : i < i' := (hpflt i i').mpr (Or.inr ⟨by rw [hi'], by rw [hi']; exact hik⟩)
    have h : (i : ℕ) + 1 < n := by have := i'.isLt; have : (i : ℕ) < i' := hii'; omega
    refine ⟨h, ?_⟩
    have h1 : i < ⟨i + 1, h⟩ := Fin.lt_def.mpr (by show (i : ℕ) < i + 1; omega)
    have h2 : (⟨i + 1, h⟩ : Fin n) ≤ i' := Fin.le_def.mpr (by show (i : ℕ) + 1 ≤ i'; have : (i : ℕ) < i' := hii'; omega)
    have e1 := hle _ _ h2
    rw [hi'] at e1; dsimp only at e1
    rcases (hpflt _ _).mp h1 with h3 | h3
    · linarith
    · exact ⟨h3.1.symm, h3.2⟩
  have hhorn_eq : ∀ i : Fin n, (pf i).2 < k → d i.succ = d i.castSucc := fun i hik => by
    obtain ⟨h, h1, -⟩ := hnext_horn i hik
    rw [hds1 i h, hdc, h1]
  -- a run reaches the next change of colour, and none lies inside it
  have harc : ∀ i : Fin n, (pf i).2 = k →
      (pf i).1 < d i.succ ∧ ∀ y ∈ Ioo (pf i).1 (d i.succ), leftCol D σ y = rightCol D σ y := by
    intro i hik
    by_cases h : (i : ℕ) + 1 < n
    · rw [hds1 i h]
      have h1 : i < ⟨i + 1, h⟩ := Fin.lt_def.mpr (by show (i : ℕ) < i + 1; omega)
      have hlt : (pf i).1 < (pf ⟨i + 1, h⟩).1 := by
        rcases (hpflt _ _).mp h1 with h3 | h3
        · exact h3
        · have := hrank _ (hpfS ⟨i + 1, h⟩); omega
      refine ⟨hlt, fun y hy => ?_⟩
      by_contra hne
      have hyP : y ∈ Pw := (hPw y).mpr ⟨⟨by linarith [(hq_win i).1, hy.1], by linarith [(hq_win ⟨i + 1, h⟩).2, hy.2]⟩,
        hD.not_offDirs_of_ne hne⟩
      obtain ⟨i'', hi''⟩ := hS0pf (y, k) ((hS0mem (y, k)).mpr ⟨hyP, Or.inr ⟨rfl, hne⟩⟩)
      have a1 : i < i'' := (hpflt _ _).mpr (Or.inl (by rw [hi'']; exact hy.1))
      have a2 : i'' < ⟨i + 1, h⟩ := (hpflt _ _).mpr (Or.inl (by rw [hi'']; exact hy.2))
      simp only [Fin.lt_def] at a1 a2; omega
    · rw [hds2 i h]
      refine ⟨by linarith [(hq_win i).2, (hq_win ⟨0, hn0⟩).1], fun y hy => ?_⟩
      by_contra hne
      by_cases hy2 : y < θ₀ + 2 * π
      · have hyP : y ∈ Pw := (hPw y).mpr ⟨⟨by linarith [(hq_win i).1, hy.1], hy2⟩, hD.not_offDirs_of_ne hne⟩
        obtain ⟨i'', hi''⟩ := hS0pf (y, k) ((hS0mem (y, k)).mpr ⟨hyP, Or.inr ⟨rfl, hne⟩⟩)
        have a1 : i < i'' := (hpflt _ _).mpr (Or.inl (by rw [hi'']; exact hy.1))
        have := Fin.lt_def.mp a1; have := i''.isLt; omega
      · have hne' : leftCol D σ (y + 2 * π * ((-1 : ℤ) : ℝ)) ≠ rightCol D σ (y + 2 * π * ((-1 : ℤ) : ℝ)) := by
          rwa [hD.leftCol_add_int, hD.rightCol_add_int]
        have hyP : y + 2 * π * ((-1 : ℤ) : ℝ) ∈ Pw := (hPw _).mpr ⟨⟨by push_cast; linarith,
          by push_cast; linarith [(hq_win ⟨0, hn0⟩).2, hy.2]⟩, hD.not_offDirs_of_ne hne'⟩
        obtain ⟨i'', hi''⟩ := hS0pf (y + 2 * π * ((-1 : ℤ) : ℝ), k) ((hS0mem (y + 2 * π * ((-1 : ℤ) : ℝ), k)).mpr ⟨hyP, Or.inr ⟨rfl, hne'⟩⟩)
        have a1 := hle ⟨0, hn0⟩ i'' (Fin.le_def.mpr (Nat.zero_le _))
        rw [hi''] at a1; dsimp only at a1; push_cast at a1; linarith [hy.2]
  have hrun_col : ∀ i : Fin n, (pf i).2 = k → ∀ y, (pf i).1 ≤ y → y < d i.succ →
      rightCol D σ y = rightCol D σ (pf i).1 := by
    intro i hik y hy1 hy2
    rcases eq_or_lt_of_le hy1 with h | h
    · rw [h]
    · obtain ⟨hlt, hno⟩ := harc i hik
      exact hD.rightCol_eq_of (sub_pos.mpr hy2) fun φ hφ hφD =>
        (hD.const_of_noChange hlt hno).2 φ ⟨h.trans hφ.1, by linarith [hφ.2]⟩ hφD
  have harc_col : ∀ i : Fin n, (pf i).2 = k → rightCol D σ (pf i).1 = leftCol D σ (pf (finRotate n i)).1 := by
    intro i hik
    obtain ⟨hlt, hno⟩ := harc i hik
    rw [(hD.const_of_noChange hlt hno).1]
    by_cases h : (i : ℕ) + 1 < n
    · rw [hds1 i h, hfr_succ i h]
    · rw [hds2 i h, hfr_last i h, show (pf ⟨0, hn0⟩).1 + 2 * π = (pf ⟨0, hn0⟩).1 + 2 * π * ((1 : ℤ) : ℝ) by push_cast; ring,
        hD.leftCol_add_int]
  have hchsucc : ∀ i : Fin n, leftCol D σ (d i.succ) ≠ rightCol D σ (d i.succ) := by
    intro i
    by_cases h : (i : ℕ) + 1 < n
    · rw [hds1 i h]; exact hch _ (hpfS _)
    · rw [hds2 i h, show (pf ⟨0, hn0⟩).1 + 2 * π = (pf ⟨0, hn0⟩).1 + 2 * π * ((1 : ℤ) : ℝ) by push_cast; ring,
        hD.leftCol_add_int, hD.rightCol_add_int]
      exact hch _ (hpfS _)
  -- every direction lies in a run (half-open on the right)
  have hloc : ∀ y, ∃ i : Fin n, (pf i).2 = k ∧ ∃ m : ℤ, (pf i).1 ≤ y + 2 * π * m ∧ y + 2 * π * m < d i.succ := by
    intro y
    obtain ⟨m, hm⟩ := exists_shift_Ico θ₀ y
    by_cases hA : ∃ i : Fin n, (pf i).2 = k ∧ (pf i).1 ≤ y + 2 * π * m
    · obtain ⟨i, hi, himax⟩ := (Finset.univ.filter fun i : Fin n => (pf i).2 = k ∧ (pf i).1 ≤ y + 2 * π * m).exists_max_image
        (fun i => (pf i).1) (by obtain ⟨i, hi⟩ := hA; exact ⟨i, by simp [hi]⟩)
      simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hi himax
      refine ⟨i, hi.1, m, hi.2, ?_⟩
      by_cases h : (i : ℕ) + 1 < n
      · rw [hds1 i h]
        by_contra hle'
        push Not at hle'
        obtain ⟨i'', hi''⟩ := hS0pf _ (hrun_mem _ (hpfS ⟨i + 1, h⟩))
        have h1 := himax i'' ⟨by rw [hi''], by rw [hi'']; exact hle'⟩
        have h2 := (harc i hi.1).1
        rw [hds1 i h] at h2
        rw [hi''] at h1; dsimp only at h1; linarith
      · rw [hds2 i h]; linarith [(hq_win ⟨0, hn0⟩).1, hm.2]
    · push Not at hA
      have hlt0 : y + 2 * π * m < (pf ⟨0, hn0⟩).1 := by
        obtain ⟨i0, hi0⟩ := hS0pf _ (hrun_mem _ (hpfS ⟨0, hn0⟩))
        have := hA i0 (by rw [hi0])
        rw [hi0] at this; exact this
      have hil : n - 1 < n := by omega
      have hilk : (pf ⟨n - 1, hil⟩).2 = k := by
        obtain ⟨i'', hi''⟩ := hS0pf _ (hrun_mem _ (hpfS ⟨n - 1, hil⟩))
        have h1 : i'' ≤ ⟨n - 1, hil⟩ := Fin.le_def.mpr (by have := i''.isLt; show (i'' : ℕ) ≤ n - 1; omega)
        rcases eq_or_lt_of_le h1 with h | h
        · rw [← h, hi'']
        · rcases (hpflt _ _).mp h with h' | h'
          · rw [hi''] at h'; dsimp only at h'; linarith
          · rw [hi''] at h'; have := h'.2; have := hrank _ (hpfS ⟨n - 1, hil⟩); dsimp only at *; omega
      refine ⟨⟨n - 1, hil⟩, hilk, m + 1, ?_, ?_⟩
      · push_cast; linarith [(hq_win ⟨n - 1, hil⟩).2, hm.1]
      · rw [hds2 _ (by show ¬ (n - 1 + 1 < n); omega)]; push_cast; linarith
  -- the cone clause
  have hcone : ∀ j : Fin k, coneAt (F.region j) v = ⋃ i ∈ {i : Fin n | c i = j}, angleIcc (d i.castSucc) (d i.succ) := by
    intro j
    apply Subset.antisymm
    · intro β hβ
      simp only [mem_iUnion, mem_setOf_eq, exists_prop]
      by_cases hjR : j = rightCol D σ β
      · obtain ⟨i, hik, m, hm1, hm2⟩ := hloc β
        refine ⟨i, ?_, mem_iUnion.mpr ⟨-m, ?_⟩⟩
        · rw [hc_run i hik, ← hrun_col i hik _ hm1 hm2, hD.rightCol_add_int, hjR]
        · rw [hdc]; push_cast; constructor <;> linarith
      by_cases hjL : j = leftCol D σ β
      · have ht := isoRad_pos D β
        have hφ₀ : OffDirs D (β - isoRad D β / 2) :=
          offDirs_of_isoRad (β := β) (by linarith) (by rw [abs_of_neg (by linarith)]; linarith)
        have hL₀ : leftCol D σ β = rightCol D σ (β - isoRad D β / 2) := by
          rw [(hD.rightCol_of_offDirs hφ₀).1]; exact (hD.eq_leftCol ⟨by linarith, by linarith⟩).symm
        obtain ⟨i, hik, m, hm1, hm2⟩ := hloc (β - isoRad D β / 2)
        have hm3 : β + 2 * π * m ≤ d i.succ := by
          by_contra hlt
          push Not at hlt
          apply hchsucc i
          have hoff : OffDirs D (d i.succ + 2 * π * ((-m : ℤ) : ℝ)) :=
            offDirs_of_isoRad (β := β) (by push_cast; linarith) (by rw [abs_lt]; push_cast; constructor <;> linarith)
          have h' := hD.rightCol_of_offDirs ((offDirs_add_int (-m)).mp hoff)
          rw [h'.1, h'.2]
        refine ⟨i, ?_, mem_iUnion.mpr ⟨-m, ?_⟩⟩
        · rw [hc_run i hik, ← hrun_col i hik _ hm1 hm2, hD.rightCol_add_int, hjL, hL₀]
        · rw [hdc]; push_cast; constructor <;> linarith
      -- a horn at `β`
      have hchβ : leftCol D σ β ≠ rightCol D σ β := fun h => hjR (hnc β j h hβ)
      obtain ⟨m, hm⟩ := exists_shift_Ico θ₀ β
      have hβP : β + 2 * π * m ∈ Pw :=
        (hPw _).mpr ⟨hm, hD.not_offDirs_of_ne (by rwa [hD.leftCol_add_int, hD.rightCol_add_int])⟩
      have hjH : j ∈ Hs (β + 2 * π * m) := (hHs _ _).mpr ⟨(periodic_int (fun _ => mem_coneAt_add_two_pi) β m).mpr hβ,
        by rwa [hD.leftCol_add_int], by rwa [hD.rightCol_add_int]⟩
      obtain ⟨i, hi⟩ := hS0pf (β + 2 * π * m, j) ((hS0mem _).mpr ⟨hβP, Or.inl ⟨j.isLt, j, hjH, rfl⟩⟩)
      have hik : (pf i).2 < k := by rw [hi]; exact j.isLt
      refine ⟨i, ?_, mem_iUnion.mpr ⟨-m, ?_⟩⟩
      · rw [hc_horn i hik]; exact Fin.ext (show (pf i).2 = (j : ℕ) by rw [hi])
      · rw [hhorn_eq i hik, hdc, hi]; dsimp only; push_cast; constructor <;> linarith
    · intro β hβ
      simp only [mem_iUnion, mem_setOf_eq, exists_prop] at hβ
      obtain ⟨i, hci, hβ⟩ := hβ
      obtain ⟨m, hm⟩ := mem_iUnion.mp hβ
      rcases lt_or_eq_of_le (hrank _ (hpfS i)) with hik | hik
      · rw [hhorn_eq i hik, hdc] at hm
        have hβq : β = (pf i).1 + 2 * π * m := le_antisymm hm.2 hm.1
        rw [hβq, periodic_int (fun _ => mem_coneAt_add_two_pi), ← hci, hc_horn i hik]
        exact ((hHs _ _).mp (hhornHs i hik)).1
      · rw [← hci, hc_run i hik]
        obtain ⟨hlt, hno⟩ := harc i hik
        have hIcc : Icc (pf i).1 (d i.succ) ⊆ coneAt (F.region (rightCol D σ (pf i).1)) v := by
          intro y hy
          refine closure_minimal (fun φ hφ => ?_) (isClosed_coneAt _ _) (mem_closure_offDirs_Ioo D hlt hy)
          rw [← (hD.const_of_noChange hlt hno).2 φ hφ.1 hφ.2]; exact hD.mem_coneAt hφ.2
        rw [hdc] at hm
        have h1 := hIcc (show β - 2 * π * m ∈ Icc _ _ from ⟨by linarith [hm.1], by linarith [hm.2]⟩)
        rwa [show β - 2 * π * m = β + 2 * π * ((-m : ℤ) : ℝ) by push_cast; ring,
          periodic_int (fun _ => mem_coneAt_add_two_pi)] at h1
  -- adjacent sectors have different colours
  have hadj : ∀ i : Fin n, c i ≠ c (finRotate n i) := by
    intro i
    rcases lt_or_eq_of_le (hrank _ (hpfS i)) with hik | hik
    · obtain ⟨h, h1, h2⟩ := hnext_horn i hik
      rw [hfr_succ i h, hc_horn i hik]
      rcases lt_or_eq_of_le (hrank _ (hpfS ⟨i + 1, h⟩)) with h3 | h3
      · rw [hc_horn _ h3]; intro he; have h4 : (pf i).2 = (pf ⟨i + 1, h⟩).2 := congrArg Fin.val he; omega
      · rw [hc_run _ h3, h1]; exact (hHs_ne _ _ (hhornHs i hik)).2
    · rw [hc_run i hik, harc_col i hik]
      rcases lt_or_eq_of_le (hrank _ (hpfS (finRotate n i))) with h3 | h3
      · rw [hc_horn _ h3]; exact (hHs_ne _ _ (hhornHs _ h3)).1.symm
      · rw [hc_run _ h3]; exact hch _ (hpfS _)
  -- two runs never share a colour (`hrun`)
  have hruns : ∀ i j : Fin n, (pf i).2 = k → (pf j).2 = k → (pf i).1 < (pf j).1 →
      rightCol D σ (pf i).1 ≠ rightCol D σ (pf j).1 := by
    intro i j hik hjk hij hR
    obtain ⟨hi1, hi2⟩ := harc i hik
    obtain ⟨hj1, hj2⟩ := harc j hjk
    have hci := (hD.const_of_noChange hi1 hi2).2
    have hcj := (hD.const_of_noChange hj1 hj2).2
    obtain ⟨φ₁, hφ₁, hφ₁D⟩ := exists_offDirs_Ioo D hi1
    obtain ⟨φ₂, hφ₂, hφ₂D⟩ := exists_offDirs_Ioo D hj1
    have hlt : i < j := (hpflt i j).mpr (Or.inl hij)
    have hsi : d i.succ ≤ (pf j).1 := by
      have h : (i : ℕ) + 1 < n := by have := j.isLt; have : (i : ℕ) < j := hlt; omega
      rw [hds1 i h]
      exact hle _ _ (Fin.le_def.mpr (by show (i : ℕ) + 1 ≤ j; have : (i : ℕ) < j := hlt; omega))
    have hsj : d j.succ ≤ (pf i).1 + 2 * π := by
      by_cases h : (j : ℕ) + 1 < n
      · rw [hds1 j h]; linarith [(hq_win ⟨j + 1, h⟩).2, (hq_win i).1]
      · rw [hds2 j h]; linarith [hle ⟨0, hn0⟩ i (Fin.le_def.mpr (Nat.zero_le _))]
    have hσ : σ φ₁ = σ φ₂ := by rw [hci φ₁ hφ₁ hφ₁D, hcj φ₂ hφ₂ hφ₂D, hR]
    rcases hrun φ₁ φ₂ hφ₁D hφ₂D (by linarith [hφ₁.2, hφ₂.1]) (by linarith [hφ₂.2, hφ₁.1]) hσ with h | h
    · exact hchsucc i (hD.noChange_of_const ⟨hφ₁.2, by linarith [hφ₂.1]⟩ h)
    · exact hchsucc j (hD.noChange_of_const ⟨hφ₂.2, by linarith [hφ₁.1]⟩ h)
  refine ⟨n, d, c, ⟨hn0, hmono, hlast, fun _ => hadj, hv, hcone⟩, fun i j hij hcij => ?_, fun i hi => ?_⟩
  · -- positive sectors have distinct colours
    rcases lt_or_eq_of_le (hrank _ (hpfS i)) with hik | hik
    · exact Or.inl (hhorn_eq i hik).symm
    rcases lt_or_eq_of_le (hrank _ (hpfS j)) with hjk | hjk
    · exact Or.inr (hhorn_eq j hjk).symm
    exfalso
    rw [hc_run i hik, hc_run j hjk] at hcij
    have hne : (pf i).1 ≠ (pf j).1 := fun h => hij (hinj i j (Prod.ext h (hik.trans hjk.symm)))
    rcases lt_or_gt_of_ne hne with h | h
    · exact hruns i j hik hjk h hcij
    · exact hruns j i hjk hik h hcij.symm
  · -- a horn sits between distinct colours
    have hik : (pf i).2 < k := by
      rcases lt_or_eq_of_le (hrank _ (hpfS i)) with h | h
      · exact h
      · exact absurd hi (ne_of_lt (by rw [hdc]; exact (harc i h).1))
    obtain ⟨h, h1, h2⟩ := hnext_horn i hik
    obtain ⟨j, hji⟩ : ∃ j, finRotate n j = i := ⟨(finRotate n).symm i, Equiv.apply_symm_apply _ _⟩
    have hjs : (finRotate n).symm i = j := by rw [← hji, Equiv.symm_apply_apply]
    rw [hjs, hfr_succ i h]
    have hnext : (c ⟨i + 1, h⟩ ∈ Hs (pf i).1 ∧ (pf i).2 < (c ⟨i + 1, h⟩ : ℕ)) ∨ c ⟨i + 1, h⟩ = rightCol D σ (pf i).1 := by
      rcases lt_or_eq_of_le (hrank _ (hpfS ⟨i + 1, h⟩)) with h3 | h3
      · left; rw [hc_horn _ h3]; exact ⟨h1 ▸ hhornHs _ h3, h2⟩
      · right; rw [hc_run _ h3, h1]
    have hprev : (c j ∈ Hs (pf i).1 ∧ (c j : ℕ) < (pf i).2) ∨ c j = leftCol D σ (pf i).1 := by
      rcases lt_or_eq_of_le (hrank _ (hpfS j)) with h3 | h3
      · left
        obtain ⟨h', h1', h2'⟩ := hnext_horn j h3
        have hj1 : (⟨j + 1, h'⟩ : Fin n) = i := by rw [← hji, hfr_succ j h']
        rw [hj1] at h1' h2'
        rw [hc_horn _ h3]; exact ⟨h1' ▸ hhornHs _ h3, h2'⟩
      · right; rw [hc_run _ h3, harc_col j h3, hji]
    rcases hprev with ⟨hp1, hp2⟩ | hp <;> rcases hnext with ⟨hn1, hn2⟩ | hn
    · intro he; rw [he] at hp2; omega
    · rw [hn]; exact (hHs_ne _ _ hp1).2
    · rw [hp]; exact (hHs_ne _ _ hn1).1.symm
    · rw [hp, hn]; exact hch _ (hpfS i)

/-- **The local data after a merge at a wedge**: off `D` and the two edge directions, a direction strictly inside the wedge now carries `c`,
and every other one keeps its colour (for a small enough cone the wedge either contains it or misses it and the new arcs). -/
theorem dirColourAt_wedgeMerge {v : ℂ} {D : Finset ℝ} {σ : ℝ → Fin k} (hD : F.DirColourAt v D σ) {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ)
    (hd : d₁ < d₂) (hd2 : d₂ < d₁ + 2 * π) :
    (F.wedgeMerge v hρ hd hd2.le c).DirColourAt v (insert d₁ (insert d₂ D))
      (fun φ => by classical exact if φ ∈ angleIoo d₁ d₂ then c else σ φ) := by
  classical
  intro φ hφ
  have hφ1 : ∀ m : ℤ, φ ≠ d₁ + 2 * π * m := hφ d₁ (Finset.mem_insert_self _ _)
  have hφ2 : ∀ m : ℤ, φ ≠ d₂ + 2 * π * m := hφ d₂ (Finset.mem_insert_of_mem (Finset.mem_insert_self _ _))
  have hφD : OffDirs D φ := fun δ hδ => hφ δ (Finset.mem_insert_of_mem (Finset.mem_insert_of_mem hδ))
  obtain ⟨r, hr, hsub⟩ := hD φ hφD
  have hπ := Real.pi_pos
  have hmono : ∀ r' ≤ r, annSector v 0 r' (φ - r') (φ + r') ⊆ annSector v 0 r (φ - r) (φ + r) := by
    rintro r' hr' _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
    exact ⟨(s, θ), ⟨⟨hs.1, hs.2.trans_le hr'⟩, ⟨by linarith [hθ.1], by linarith [hθ.2]⟩⟩, rfl⟩
  by_cases hin : φ ∈ angleIoo d₁ d₂
  · obtain ⟨m, hm⟩ := mem_iUnion.mp hin
    set r' := min r (min ρ (min (φ - (d₁ + 2 * π * m)) (d₂ + 2 * π * m - φ))) with hr'
    have hr'0 : 0 < r' := lt_min hr (lt_min hρ (lt_min (by linarith [hm.1]) (by linarith [hm.2])))
    have h1 : r' ≤ r := min_le_left _ _
    have h2 : r' ≤ ρ := (min_le_right _ _).trans (min_le_left _ _)
    have h3 : r' ≤ φ - (d₁ + 2 * π * m) := (min_le_right _ _).trans ((min_le_right _ _).trans (min_le_left _ _))
    have h4 : r' ≤ d₂ + 2 * π * m - φ := (min_le_right _ _).trans ((min_le_right _ _).trans (min_le_right _ _))
    refine ⟨r', hr'0, fun w hw => ?_⟩
    have hwF := hsub (hmono r' h1 hw)
    obtain ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ := hw
    simp only at hs hθ hwF ⊢
    have hW : v + (s : ℂ) * e θ ∈ annSector v 0 ρ d₁ d₂ := by
      refine ⟨(s, θ + 2 * π * ((-m : ℤ) : ℝ)), ⟨⟨hs.1, hs.2.trans_le h2⟩, ?_, ?_⟩, ?_⟩
      · push_cast; linarith [hθ.1]
      · push_cast; linarith [hθ.2]
      · simp only [e_add_two_pi_mul_int]
    rw [if_pos hin]
    refine ⟨⟨hwF.1.1, fun h => ?_⟩, ?_⟩
    · obtain ⟨a, ha | ha, hza⟩ := mem_iUnion₂.mp h
      · exact hwF.1.2 (mem_iUnion₂.mpr ⟨a, ha, hza⟩)
      · exact annSector_notMem_wedgeArcs hd2.le hW (mem_iUnion₂.mpr ⟨a, ha, hza⟩)
    · show (if v + (s : ℂ) * e θ ∈ annSector v 0 ρ d₁ d₂ then c else F.col (v + (s : ℂ) * e θ)) = c
      rw [if_pos hW]
  · obtain ⟨n, hn⟩ := exists_shift_Ico d₁ φ
    have hn1 : d₁ < φ + 2 * π * n := lt_of_le_of_ne hn.1 fun h => hφ1 (-n) (by push_cast; linarith)
    have hn2 : d₂ < φ + 2 * π * n := by
      rcases lt_trichotomy (φ + 2 * π * n) d₂ with h | h | h
      · exact absurd (mem_iUnion.mpr ⟨-n, by push_cast; constructor <;> linarith⟩) hin
      · exact absurd (by push_cast; linarith : φ = d₂ + 2 * π * ((-n : ℤ) : ℝ)) (hφ2 (-n))
      · exact h
    set r' := min r (min (φ + 2 * π * n - d₂) (d₁ + 2 * π - (φ + 2 * π * n))) with hr'
    have hr'0 : 0 < r' := lt_min hr (lt_min (by linarith) (by linarith [hn.2]))
    have h1 : r' ≤ r := min_le_left _ _
    have h3 : r' ≤ φ + 2 * π * n - d₂ := (min_le_right _ _).trans (min_le_left _ _)
    have h4 : r' ≤ d₁ + 2 * π - (φ + 2 * π * n) := (min_le_right _ _).trans (min_le_right _ _)
    refine ⟨r', hr'0, fun w hw => ?_⟩
    have hwF := hsub (hmono r' h1 hw)
    obtain ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ := hw
    simp only at hs hθ hwF ⊢
    rw [if_neg hin]
    have hoff : v + (s : ℂ) * e θ ∉ closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier := by
      have hP := polar_notMem (v := v) (ρ := ρ) (d₁ := d₁) (d₂ := d₂) hs.1
        (show θ + 2 * π * n ∈ Ioo d₂ (d₁ + 2 * π) from ⟨by linarith [hθ.1], by linarith [hθ.2]⟩)
      rw [e_add_two_pi_mul_int] at hP
      rintro (h | h)
      · exact hP (closure_annSector_subset v hρ.le hd.le h)
      · exact hP (wedgeArcs_subset_polar hρ hd.le h)
    have key := recolour_region_diff (F := F) (W := annSector v 0 ρ d₁ d₂) (B := wedgeArcs v ρ d₁ d₂)
      (hB := wedgeArcs_nondegenerate hρ hd hd2.le) (hBf := ((finite_singleton _).insert _).insert _)
      (hW := frontier_annSector_subset hρ hd hd2.le) (c := c) (σ φ)
    have : v + (s : ℂ) * e θ ∈ F.region (σ φ) \ (closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier) :=
      ⟨hwF, hoff⟩
    rw [← key] at this
    exact this.1

/-! ## Cones after a merge (children of `exists_merge_at`'s measure, FS131-IWc) -/

/-- An angle lies in `angleIcc a b` exactly when its direction is one of `[a, b]`. -/
theorem mem_angleIcc_iff_e {a b β : ℝ} : β ∈ angleIcc a b ↔ e β ∈ e '' Icc a b := by
  constructor
  · intro hβ
    obtain ⟨m, hm⟩ := mem_iUnion.mp hβ
    refine ⟨β + 2 * π * ((-m : ℤ) : ℝ), ⟨by push_cast; linarith [hm.1], by push_cast; linarith [hm.2]⟩, ?_⟩
    rw [e_add_two_pi_mul_int]
  · rintro ⟨θ, hθ, he⟩
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp he.symm
    exact mem_iUnion.mpr ⟨n, by rw [hn]; constructor <;> linarith [hθ.1, hθ.2]⟩

/-- Angular intervals are closed. -/
theorem isClosed_angleIcc (a b : ℝ) : IsClosed (angleIcc a b) := by
  have : angleIcc a b = e ⁻¹' (e '' Icc a b) := Set.ext fun β => mem_angleIcc_iff_e
  rw [this]
  exact (isCompact_Icc.image continuous_e).isClosed.preimage continuous_e

/-- **Off the closed wedge, a merge leaves the cones at `v` alone.** -/
theorem coneAt_wedgeMerge_of_notMem {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π) {δ : ℝ}
    (hδ : δ ∉ angleIcc d₁ d₂) (j : Fin k) :
    δ ∈ coneAt ((F.wedgeMerge v hρ hd hd2 c).region j) v ↔ δ ∈ coneAt (F.region j) v := by
  obtain ⟨η, hη, hηsub⟩ := Metric.isOpen_iff.mp (isClosed_angleIcc d₁ d₂).isOpen_compl δ hδ
  have hoff : ∀ z ∈ annSector v 0 ρ (δ - η) (δ + η),
      z ∉ closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier := by
    rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ hX
    simp only at hs hθ hX
    have hP := hX.elim (fun h => closure_annSector_subset v hρ.le hd.le h) (fun h => wedgeArcs_subset_polar hρ hd.le h)
    obtain ⟨⟨s', θ'⟩, ⟨hs', hθ'⟩, h⟩ := hP
    simp only at h hs' hθ'
    have he := (polar_inj hs.1 hs'.1 h.symm).2
    exact hηsub (show θ ∈ Metric.ball δ η by rw [Metric.mem_ball, Real.dist_eq, abs_lt]; constructor <;> linarith [hθ.1, hθ.2])
      (mem_angleIcc_iff_e.mpr ⟨θ', hθ', he.symm⟩)
  have key := recolour_region_diff (F := F) (W := annSector v 0 ρ d₁ d₂) (B := wedgeArcs v ρ d₁ d₂)
    (hB := wedgeArcs_nondegenerate hρ hd hd2) (hBf := ((finite_singleton _).insert _).insert _)
    (hW := frontier_annSector_subset hρ hd hd2) (c := c) j
  have hA : (F.wedgeMerge v hρ hd hd2 c).region j ∩ annSector v 0 ρ (δ - η) (δ + η) =
      F.region j ∩ annSector v 0 ρ (δ - η) (δ + η) := by
    ext z
    constructor
    · rintro ⟨hz, hzA⟩
      have : z ∈ (F.wedgeMerge v hρ hd hd2 c).region j \ (closure (annSector v 0 ρ d₁ d₂) ∪
        ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier) := ⟨hz, hoff z hzA⟩
      exact ⟨(key ▸ this : z ∈ F.region j \ _).1, hzA⟩
    · rintro ⟨hz, hzA⟩
      have : z ∈ F.region j \ (closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier) := ⟨hz, hoff z hzA⟩
      exact ⟨(key.symm ▸ this : z ∈ (F.wedgeMerge v hρ hd hd2 c).region j \ _).1, hzA⟩
  constructor
  · intro h
    have := mem_coneAt_inter_annSector h hρ hη
    rw [hA] at this
    exact coneAt_mono inter_subset_left v this
  · intro h
    have := mem_coneAt_inter_annSector h hρ hη
    rw [← hA] at this
    exact coneAt_mono inter_subset_left v this

/-- **Inside the wedge, after a merge only `c` approaches `v`.** -/
theorem eq_of_mem_coneAt_wedgeMerge {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π) {δ : ℝ}
    (hδ : δ ∈ angleIoo d₁ d₂) {j : Fin k} (h : δ ∈ coneAt ((F.wedgeMerge v hρ hd hd2 c).region j) v) : j = c := by
  classical
  obtain ⟨m, hm⟩ := mem_iUnion.mp hδ
  have hη : 0 < min (δ - (d₁ + 2 * π * m)) (d₂ + 2 * π * m - δ) := lt_min (by linarith [hm.1]) (by linarith [hm.2])
  obtain ⟨z, ⟨hzR, hzA⟩, -⟩ := mem_coneAt_inter_annSector h hρ hη 1 one_pos
  obtain ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ := hzA
  simp only at hs hθ hzR
  have h1 := min_le_left (δ - (d₁ + 2 * π * m)) (d₂ + 2 * π * m - δ)
  have h2 := min_le_right (δ - (d₁ + 2 * π * m)) (d₂ + 2 * π * m - δ)
  have hzW : v + (s : ℂ) * e θ ∈ annSector v 0 ρ d₁ d₂ := by
    refine ⟨(s, θ + 2 * π * ((-m : ℤ) : ℝ)), ⟨hs, ?_, ?_⟩, ?_⟩
    · push_cast; linarith [hθ.1]
    · push_cast; linarith [hθ.2]
    · simp only [e_add_two_pi_mul_int]
  have hcol : (if v + (s : ℂ) * e θ ∈ annSector v 0 ρ d₁ d₂ then c else F.col (v + (s : ℂ) * e θ)) = j := hzR.2
  rw [if_pos hzW] at hcol
  exact hcol.symm

/-- **Along a direction whose thin cone lies in `F`'s class of `c`, after a merge only `c` approaches `v`** (the merge recolours with
`c`, and leaves the rest of that cone alone). -/
theorem eq_of_mem_coneAt_wedgeMerge_of_subset {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π)
    {d r : ℝ} (hr : 0 < r) (hF : annSector v 0 r (d - r) (d + r) ⊆ F.region c) {j : Fin k}
    (h : d ∈ coneAt ((F.wedgeMerge v hρ hd hd2 c).region j) v) : j = c := by
  classical
  obtain ⟨z, ⟨hzR, hzA⟩, -⟩ := mem_coneAt_inter_annSector h hr hr 1 one_pos
  have hcol : (if z ∈ annSector v 0 ρ d₁ d₂ then c else F.col z) = j := hzR.2
  by_cases hzW : z ∈ annSector v 0 ρ d₁ d₂
  · rw [if_pos hzW] at hcol; exact hcol.symm
  · rw [if_neg hzW] at hcol; rw [← hcol]; exact (hF hzA).2

/-! ## The crossings a merge creates (FS131-IWd) -/

/-- **A transversal crossing of two curves through `w` is `NiceAt`** (E3-NICE's crossings, region-only): near `w` the open inner side
of a circle through `w` (`2 dot (z − w) (pO e θ) + ‖z − w‖² < 0`) carries `c`, and the outer side is split by a second curve through `w`
(`2 dot (z − w) (pC e α) + κ ‖z − w‖² ≷ 0`, `κ ∈ {0, 1}`) into `x` and `y`. If three colours meet at `w`, `σ` is `c` on the
inner half and `x`, `y` on the two outer pieces, and `niceAt_of_dirColourAt` gives the picture (no transversality is needed: a tangency
would leave a colour only a horn). -/
theorem niceAt_of_crossing {G : ArcMap k} {w : ℂ} {θ α pO pC κ η : ℝ} {c x y : Fin k} (hw : w ∈ G.dom)
    (hκ : κ = 0 ∨ κ = 1) (hpO : 0 < pO) (hpC : 0 < pC) (hη : 0 < η)
    (hin : ∀ z ∈ ball w η, ∀ j, z ∈ G.region j → 2 * dot (z - w) ((pO : ℂ) * e θ) + ‖z - w‖ ^ 2 < 0 → j = c)
    (hint : ∀ z ∈ ball w η, 2 * dot (z - w) ((pO : ℂ) * e θ) + ‖z - w‖ ^ 2 < 0 →
      2 * dot (z - w) ((pC : ℂ) * e α) + κ * ‖z - w‖ ^ 2 ≠ 0 → z ∈ G.interiorPts)
    (hx : ∀ z ∈ ball w η, 0 < 2 * dot (z - w) ((pO : ℂ) * e θ) + ‖z - w‖ ^ 2 →
      0 < 2 * dot (z - w) ((pC : ℂ) * e α) + κ * ‖z - w‖ ^ 2 → z ∈ G.region x)
    (hy : ∀ z ∈ ball w η, 0 < 2 * dot (z - w) ((pO : ℂ) * e θ) + ‖z - w‖ ^ 2 →
      2 * dot (z - w) ((pC : ℂ) * e α) + κ * ‖z - w‖ ^ 2 < 0 → z ∈ G.region y)
    (h3 : 3 ≤ (G.coloursAt w).ncard) : G.NiceAt w := by
  classical
  have hπ := Real.pi_pos
  have hdotre : ∀ a b : ℂ, dot a b = (a * starRingEnd ℂ b).re := fun _ _ => rfl
  have hcurve : ∀ (κ' : ℝ) (b z : ℂ), z ∈ curveAt w κ' (-b) ↔ 2 * dot (z - w) b + κ' * ‖z - w‖ ^ 2 = 0 := by
    intro κ' b z
    simp only [curveAt, mem_setOf_eq, map_neg, mul_neg, Complex.neg_re, Complex.normSq_eq_norm_sq, hdotre]
    constructor <;> intro h <;> linarith
  have hreg : ∀ {z : ℂ} {i j : Fin k}, z ∈ G.region i → z ∈ G.region j → i = j := fun hi hj => by
    have h1 : G.col _ = _ := hi.2
    have h2 : G.col _ = _ := hj.2
    exact h1.symm.trans h2
  have hbO : -((pO : ℂ) * e θ) ≠ 0 := neg_ne_zero.mpr (mul_ne_zero (by exact_mod_cast hpO.ne') (e_ne_zero θ))
  have hbC : -((pC : ℂ) * e α) ≠ 0 := neg_ne_zero.mpr (mul_ne_zero (by exact_mod_cast hpC.ne') (e_ne_zero α))
  -- the colours at `w` are `c`, `x`, `y`
  have hcols : G.coloursAt w ⊆ {c, x, y} := by
    intro j hj
    obtain ⟨z₀, hz₀b, hz₀j⟩ := mem_closure_iff_nhds.mp hj (ball w η) (ball_mem_nhds w hη)
    have hOo : IsOpen (G.region j ∩ ball w η) := (G.isOpen_region j).inter isOpen_ball
    obtain ⟨z₁, hz₁, hz₁C⟩ := exists_notMem_curveAt (x := w) (Or.inr rfl) hbO hOo ⟨z₀, hz₀j, hz₀b⟩
    obtain ⟨z, ⟨⟨hzj, hzb⟩, hzC1⟩, hzC2⟩ := exists_notMem_curveAt (x := w) hκ hbC
      (hOo.inter (isClosed_curveAt w 1 _).isOpen_compl) ⟨z₁, hz₁, hz₁C⟩
    have hg : 2 * dot (z - w) ((pO : ℂ) * e θ) + 1 * ‖z - w‖ ^ 2 ≠ 0 := fun h => hzC1 ((hcurve 1 _ z).mpr h)
    have hf : 2 * dot (z - w) ((pC : ℂ) * e α) + κ * ‖z - w‖ ^ 2 ≠ 0 := fun h => hzC2 ((hcurve κ _ z).mpr h)
    rw [one_mul] at hg
    rcases lt_or_gt_of_ne hg with h1 | h1
    · rw [hin z hzb j hzj h1]; exact Or.inl rfl
    · rcases lt_or_gt_of_ne hf with h2 | h2
      · rw [hreg hzj (hy z hzb h1 h2)]; exact Or.inr (Or.inr rfl)
      · rw [hreg hzj (hx z hzb h1 h2)]; exact Or.inr (Or.inl rfl)
  have hne : c ≠ x ∧ c ≠ y ∧ x ≠ y := by
    have key : ∀ a b : Fin k, G.coloursAt w ⊆ {a, b} → False := fun a b h => by
      have h1 := Set.ncard_le_ncard h (Set.toFinite _)
      have h2 := Set.ncard_insert_le a {b}
      rw [Set.ncard_singleton] at h2
      omega
    refine ⟨fun h => key c y fun j hj => ?_, fun h => key c x fun j hj => ?_, fun h => key c x fun j hj => ?_⟩
    · rcases hcols hj with rfl | rfl | rfl
      · exact Or.inl rfl
      · exact Or.inl h.symm
      · exact Or.inr rfl
    · rcases hcols hj with rfl | rfl | rfl
      · exact Or.inl rfl
      · exact Or.inr rfl
      · exact Or.inl h.symm
    · rcases hcols hj with rfl | rfl | rfl
      · exact Or.inl rfl
      · exact Or.inr rfl
      · exact Or.inr h.symm
  -- the local data: the four tangent directions
  set D : Finset ℝ := {θ + π / 2, θ - π / 2, α + π / 2, α - π / 2} with hD
  set σ : ℝ → Fin k := fun φ => if Real.cos (φ - θ) < 0 then c else if 0 < Real.cos (φ - α) then x else y with hσ
  have hσc : ∀ φ, σ φ = c ↔ Real.cos (φ - θ) < 0 := fun φ => by
    simp only [hσ]
    split_ifs with h1 h2
    · exact ⟨fun _ => h1, fun _ => rfl⟩
    · exact ⟨fun h => absurd h.symm hne.1, fun h => absurd h h1⟩
    · exact ⟨fun h => absurd h.symm hne.2.1, fun h => absurd h h1⟩
  have hoff : ∀ φ, OffDirs D φ → Real.cos (φ - θ) ≠ 0 ∧ Real.cos (φ - α) ≠ 0 := by
    intro φ hφ
    constructor
    · intro h
      obtain ⟨m, hm | hm⟩ := eq_of_cos_sub_eq_zero h
      · exact hφ _ (by simp [hD]) m hm
      · exact hφ _ (by simp [hD]) m hm
    · intro h
      obtain ⟨m, hm | hm⟩ := eq_of_cos_sub_eq_zero h
      · exact hφ _ (by simp [hD]) m hm
      · exact hφ _ (by simp [hD]) m hm
  have hdO : ∀ φ, dot (e φ) ((pO : ℂ) * e θ) = pO * Real.cos (φ - θ) := fun φ => by rw [dot_real_mul_right, dot_e_e]
  have hdC : ∀ φ, dot (e φ) ((pC : ℂ) * e α) = pC * Real.cos (φ - α) := fun φ => by rw [dot_real_mul_right, dot_e_e]
  have hDC : G.DirColourAt w D σ := by
    intro φ hφ
    obtain ⟨h1, h2⟩ := hoff φ hφ
    obtain ⟨r₁, hr₁, hs₁⟩ := exists_sign_near (n := (pO : ℂ) * e θ) (κ := 1) (by norm_num) (φ := φ)
      (by rw [hdO]; exact mul_ne_zero hpO.ne' h1)
    obtain ⟨r₂, hr₂, hs₂⟩ := exists_sign_near (n := (pC : ℂ) * e α) (κ := κ) (by rcases hκ with rfl | rfl <;> norm_num)
      (φ := φ) (by rw [hdC]; exact mul_ne_zero hpC.ne' h2)
    have hm1 := min_le_left (min r₁ r₂) η
    have hm2 := min_le_right (min r₁ r₂) η
    have hm3 := min_le_left r₁ r₂
    have hm4 := min_le_right r₁ r₂
    refine ⟨min (min r₁ r₂) η, lt_min (lt_min hr₁ hr₂) hη, ?_⟩
    rintro _ ⟨⟨s, ψ⟩, ⟨hs, hψ⟩, rfl⟩
    simp only at hs hψ
    have hzw : w + (s : ℂ) * e ψ - w = (s : ℂ) * e ψ := add_sub_cancel_left _ _
    have hns : ‖w + (s : ℂ) * e ψ - w‖ = s := by rw [hzw, norm_real_mul_e hs.1.le]
    have hzb : w + (s : ℂ) * e ψ ∈ ball w η := by rw [mem_ball, dist_eq_norm, hns]; linarith [hs.2]
    have hS₁ := hs₁ s ⟨hs.1, by linarith [hs.2]⟩ ψ ⟨by linarith [hψ.1], by linarith [hψ.2]⟩
    have hS₂ := hs₂ s ⟨hs.1, by linarith [hs.2]⟩ ψ ⟨by linarith [hψ.1], by linarith [hψ.2]⟩
    have keyO : 2 * dot (w + (s : ℂ) * e ψ - w) ((pO : ℂ) * e θ) + ‖w + (s : ℂ) * e ψ - w‖ ^ 2 =
        2 * dot ((s : ℂ) * e ψ) ((pO : ℂ) * e θ) + 1 * s ^ 2 := by rw [hzw, norm_real_mul_e hs.1.le, one_mul]
    have keyC : 2 * dot (w + (s : ℂ) * e ψ - w) ((pC : ℂ) * e α) + κ * ‖w + (s : ℂ) * e ψ - w‖ ^ 2 =
        2 * dot ((s : ℂ) * e ψ) ((pC : ℂ) * e α) + κ * s ^ 2 := by rw [hzw, norm_real_mul_e hs.1.le]
    rw [hdO] at hS₁
    rw [hdC] at hS₂
    have hfne : 2 * dot (w + (s : ℂ) * e ψ - w) ((pC : ℂ) * e α) + κ * ‖w + (s : ℂ) * e ψ - w‖ ^ 2 ≠ 0 := by
      rw [keyC]
      rcases lt_or_gt_of_ne h2 with h | h
      · exact (hS₂.2 (mul_neg_of_pos_of_neg hpC h)).ne
      · exact (hS₂.1 (mul_pos hpC h)).ne'
    by_cases hc1 : Real.cos (φ - θ) < 0
    · have hg : 2 * dot (w + (s : ℂ) * e ψ - w) ((pO : ℂ) * e θ) + ‖w + (s : ℂ) * e ψ - w‖ ^ 2 < 0 := by
        rw [keyO]; exact hS₁.2 (mul_neg_of_pos_of_neg hpO hc1)
      have hI := hint _ hzb hg hfne
      have hcol := hin _ hzb (G.col (w + (s : ℂ) * e ψ)) ⟨hI, rfl⟩ hg
      simp only [hσ, if_pos hc1]
      exact ⟨hI, hcol⟩
    · have hc1' : 0 < Real.cos (φ - θ) := lt_of_le_of_ne (not_lt.mp hc1) (Ne.symm h1)
      have hg : 0 < 2 * dot (w + (s : ℂ) * e ψ - w) ((pO : ℂ) * e θ) + ‖w + (s : ℂ) * e ψ - w‖ ^ 2 := by
        rw [keyO]; exact hS₁.1 (mul_pos hpO hc1')
      simp only [hσ, if_neg hc1]
      split_ifs with hc2
      · exact hx _ hzb hg (by rw [keyC]; exact hS₂.1 (mul_pos hpC hc2))
      · exact hy _ hzb hg (by rw [keyC]; exact hS₂.2 (mul_neg_of_pos_of_neg hpC (lt_of_le_of_ne (not_lt.mp hc2) h2)))
  -- each colour class is an open half-circle or an intersection of two: the run condition
  have hcpi : ∀ φ a, Real.cos (φ - (a + π)) = -Real.cos (φ - a) := fun φ a => by
    rw [show φ - (a + π) = (φ - a) - π by ring, Real.cos_sub_pi]
  have hrun : ∀ φ₁ φ₂ : ℝ, OffDirs D φ₁ → OffDirs D φ₂ → φ₁ < φ₂ → φ₂ < φ₁ + 2 * π → σ φ₁ = σ φ₂ →
      (∀ φ ∈ Ioo φ₁ φ₂, OffDirs D φ → σ φ = σ φ₁) ∨ (∀ φ ∈ Ioo φ₂ (φ₁ + 2 * π), OffDirs D φ → σ φ = σ φ₁) := by
    intro φ₁ φ₂ hφ₁ hφ₂ h12 h21 hσ12
    obtain ⟨a1, b1⟩ := hoff φ₁ hφ₁
    obtain ⟨a2, b2⟩ := hoff φ₂ hφ₂
    by_cases c1 : Real.cos (φ₁ - θ) < 0
    · have c2 : Real.cos (φ₂ - θ) < 0 := (hσc φ₂).mp (hσ12 ▸ (hσc φ₁).mpr c1)
      rw [(hσc φ₁).mpr c1]
      rcases cos_pos_arc (a := θ + π) h12 h21 (by rw [hcpi]; linarith) (by rw [hcpi]; linarith) with ⟨-, h⟩ | ⟨-, h⟩
      · exact Or.inl fun φ hφ _ => (hσc φ).mpr (by have := h φ hφ; rw [hcpi] at this; linarith)
      · exact Or.inr fun φ hφ _ => (hσc φ).mpr (by have := h φ hφ; rw [hcpi] at this; linarith)
    · have c1' : 0 < Real.cos (φ₁ - θ) := lt_of_le_of_ne (not_lt.mp c1) (Ne.symm a1)
      have c2' : 0 < Real.cos (φ₂ - θ) := by
        rcases lt_or_gt_of_ne a2 with h | h
        · exact absurd ((hσc φ₁).mp (hσ12.trans ((hσc φ₂).mpr h))) c1
        · exact h
      have hσ1 : σ φ₁ = if 0 < Real.cos (φ₁ - α) then x else y := by simp only [hσ, if_neg c1]
      have hσ2 : σ φ₂ = if 0 < Real.cos (φ₂ - α) then x else y := by simp only [hσ, if_neg (not_lt.mpr c2'.le)]
      have hσo : ∀ φ, 0 < Real.cos (φ - θ) → σ φ = if 0 < Real.cos (φ - α) then x else y := fun φ h => by
        simp only [hσ, if_neg (not_lt.mpr h.le)]
      rcases cos_pos_arc (a := θ) h12 h21 c1' c2' with ⟨hl, hθ⟩ | ⟨hl, hθ⟩ <;>
        by_cases d1 : 0 < Real.cos (φ₁ - α)
      · have d2 : 0 < Real.cos (φ₂ - α) := by
          by_contra d2; rw [hσ1, hσ2, if_pos d1, if_neg d2] at hσ12; exact hne.2.2 hσ12
        rcases cos_pos_arc (a := α) h12 h21 d1 d2 with ⟨-, hα⟩ | ⟨hl', -⟩
        · exact Or.inl fun φ hφ _ => by rw [hσo φ (hθ φ hφ), hσ1, if_pos d1, if_pos (hα φ hφ)]
        · linarith
      · have d1' : 0 < Real.cos (φ₁ - (α + π)) := by rw [hcpi]; linarith [lt_of_le_of_ne (not_lt.mp d1) b1]
        have d2 : ¬ 0 < Real.cos (φ₂ - α) := by
          intro d2; rw [hσ1, hσ2, if_neg d1, if_pos d2] at hσ12; exact hne.2.2 hσ12.symm
        have d2' : 0 < Real.cos (φ₂ - (α + π)) := by rw [hcpi]; linarith [lt_of_le_of_ne (not_lt.mp d2) b2]
        rcases cos_pos_arc (a := α + π) h12 h21 d1' d2' with ⟨-, hα⟩ | ⟨hl', -⟩
        · refine Or.inl fun φ hφ _ => ?_
          have := hα φ hφ; rw [hcpi] at this
          rw [hσo φ (hθ φ hφ), hσ1, if_neg d1, if_neg (by linarith)]
        · linarith
      · have d2 : 0 < Real.cos (φ₂ - α) := by
          by_contra d2; rw [hσ1, hσ2, if_pos d1, if_neg d2] at hσ12; exact hne.2.2 hσ12
        rcases cos_pos_arc (a := α) h12 h21 d1 d2 with ⟨hl', -⟩ | ⟨-, hα⟩
        · linarith
        · exact Or.inr fun φ hφ _ => by rw [hσo φ (hθ φ hφ), hσ1, if_pos d1, if_pos (hα φ hφ)]
      · have d1' : 0 < Real.cos (φ₁ - (α + π)) := by rw [hcpi]; linarith [lt_of_le_of_ne (not_lt.mp d1) b1]
        have d2 : ¬ 0 < Real.cos (φ₂ - α) := by
          intro d2; rw [hσ1, hσ2, if_neg d1, if_pos d2] at hσ12; exact hne.2.2 hσ12.symm
        have d2' : 0 < Real.cos (φ₂ - (α + π)) := by rw [hcpi]; linarith [lt_of_le_of_ne (not_lt.mp d2) b2]
        rcases cos_pos_arc (a := α + π) h12 h21 d1' d2' with ⟨hl', -⟩ | ⟨-, hα⟩
        · linarith
        · refine Or.inr fun φ hφ _ => ?_
          have := hα φ hφ; rw [hcpi] at this
          rw [hσo φ (hθ φ hφ), hσ1, if_neg d1, if_neg (by linarith)]
  -- at a tangent direction the two sides differ, except inside the circle, where only `c` approaches
  have hpoke : ∀ δ ∈ D, ∀ j c' : Fin k, δ ∈ coneAt (G.region j) w →
      (∃ t > 0, ∀ φ ∈ Ioo (δ - t) (δ + t), OffDirs D φ → σ φ = c') → j = c' := by
    rintro δ hδ j c' hj ⟨t, ht, hσt⟩
    have hδ0 : Real.cos (δ - θ) = 0 ∨ Real.cos (δ - α) = 0 := by
      simp only [hD, Finset.mem_insert, Finset.mem_singleton] at hδ
      rcases hδ with rfl | rfl | rfl | rfl
      · left; rw [add_sub_cancel_left, Real.cos_pi_div_two]
      · left; rw [sub_sub_cancel_left, Real.cos_neg, Real.cos_pi_div_two]
      · right; rw [add_sub_cancel_left, Real.cos_pi_div_two]
      · right; rw [sub_sub_cancel_left, Real.cos_neg, Real.cos_pi_div_two]
    obtain ⟨t₀, ht₀, hiso⟩ := exists_offDirs_punctured D δ
    -- a small step `s` to either side
    have hside : ∀ s, 0 < s → s < t → s < t₀ → OffDirs D (δ + s) ∧ OffDirs D (δ - s) ∧ σ (δ + s) = c' ∧ σ (δ - s) = c' := by
      intro s hs hst hst₀
      have h1 : OffDirs D (δ + s) := hiso _ (by linarith) (by rw [add_sub_cancel_left, abs_of_pos hs]; exact hst₀)
      have h2 : OffDirs D (δ - s) := hiso _ (by linarith) (by rw [sub_sub_cancel_left, abs_neg, abs_of_pos hs]; exact hst₀)
      exact ⟨h1, h2, hσt _ ⟨by linarith, by linarith⟩ h1, hσt _ ⟨by linarith, by linarith⟩ h2⟩
    rcases lt_trichotomy (Real.cos (δ - θ)) 0 with hδθ | hδθ | hδθ
    · -- inside the circle: only `c` approaches, and `σ = c` nearby
      set s := min (min t t₀) (-Real.cos (δ - θ)) / 2 with hsdef
      have hs0 : 0 < s := by have := lt_min (lt_min ht ht₀) (neg_pos.mpr hδθ); positivity
      have hs1 := min_le_left (min t t₀) (-Real.cos (δ - θ))
      have hs2 := min_le_right (min t t₀) (-Real.cos (δ - θ))
      have hs3 := min_le_left t t₀
      have hs4 := min_le_right t t₀
      obtain ⟨-, -, hσp, -⟩ := hside s hs0 (by linarith) (by linarith)
      have hcs : Real.cos (δ + s - θ) < 0 := by
        have := Real.abs_cos_sub_cos_le (δ + s - θ) (δ - θ)
        rw [show δ + s - θ - (δ - θ) = s by ring, abs_of_pos hs0] at this
        linarith [(abs_le.mp this).2]
      have hc' : c' = c := hσp.symm.trans ((hσc _).mpr hcs)
      rw [hc']
      by_contra hjc
      have hhalf := coneAt_subset_halfPlane (S := G.region j) (n := (pO : ℂ) * e θ) hη
        (fun z hz hzb => not_lt.mp fun hlt => hjc (hin z hzb j hz hlt)) hj
      rw [hdO] at hhalf
      nlinarith
    · -- on the circle's tangent: `c` on one side, `x` or `y` on the other
      exfalso
      have hsin : Real.sin (δ - θ) ≠ 0 := fun h => by
        have := Real.cos_sq_add_sin_sq (δ - θ); rw [hδθ, h] at this; norm_num at this
      set s := min (min t t₀) (π / 2) / 2 with hsdef
      have hs0 : 0 < s := by have := lt_min (lt_min ht ht₀) (by positivity : (0 : ℝ) < π / 2); positivity
      have hs1 := min_le_left (min t t₀) (π / 2)
      have hs2 := min_le_right (min t t₀) (π / 2)
      have hs3 := min_le_left t t₀
      have hs4 := min_le_right t t₀
      obtain ⟨-, -, hσp, hσm⟩ := hside s hs0 (by linarith) (by linarith)
      have hsins : 0 < Real.sin s := Real.sin_pos_of_pos_of_lt_pi hs0 (by linarith)
      have ep : Real.cos (δ + s - θ) = -Real.sin (δ - θ) * Real.sin s := by
        rw [show δ + s - θ = (δ - θ) + s by ring, Real.cos_add, hδθ]; ring
      have em : Real.cos (δ - s - θ) = Real.sin (δ - θ) * Real.sin s := by
        rw [show δ - s - θ = (δ - θ) - s by ring, Real.cos_sub, hδθ]; ring
      have hpm : σ (δ + s) = σ (δ - s) := hσp.trans hσm.symm
      rcases lt_or_gt_of_ne hsin with h | h
      · have h1 : ¬ Real.cos (δ + s - θ) < 0 := by rw [ep]; nlinarith
        have h2 : Real.cos (δ - s - θ) < 0 := by rw [em]; nlinarith
        exact h1 ((hσc _).mp (hpm.trans ((hσc _).mpr h2)))
      · have h1 : Real.cos (δ + s - θ) < 0 := by rw [ep]; nlinarith
        have h2 : ¬ Real.cos (δ - s - θ) < 0 := by rw [em]; nlinarith
        exact h2 ((hσc _).mp (hpm.symm.trans ((hσc _).mpr h1)))
    · -- outside the circle, on the second curve's tangent: `x` on one side, `y` on the other
      exfalso
      have hδα : Real.cos (δ - α) = 0 := hδ0.resolve_left hδθ.ne'
      have hsin : Real.sin (δ - α) ≠ 0 := fun h => by
        have := Real.cos_sq_add_sin_sq (δ - α); rw [hδα, h] at this; norm_num at this
      set s := min (min (min t t₀) (π / 2)) (Real.cos (δ - θ)) / 2 with hsdef
      have hs0 : 0 < s := by
        have := lt_min (lt_min (lt_min ht ht₀) (by positivity : (0 : ℝ) < π / 2)) hδθ; positivity
      have hs1 := min_le_left (min (min t t₀) (π / 2)) (Real.cos (δ - θ))
      have hs2 := min_le_right (min (min t t₀) (π / 2)) (Real.cos (δ - θ))
      have hs5 := min_le_left (min t t₀) (π / 2)
      have hs6 := min_le_right (min t t₀) (π / 2)
      have hs3 := min_le_left t t₀
      have hs4 := min_le_right t t₀
      obtain ⟨-, -, hσp, hσm⟩ := hside s hs0 (by linarith) (by linarith)
      have hcp : 0 < Real.cos (δ + s - θ) := by
        have := Real.abs_cos_sub_cos_le (δ + s - θ) (δ - θ)
        rw [show δ + s - θ - (δ - θ) = s by ring, abs_of_pos hs0] at this
        linarith [(abs_le.mp this).1]
      have hcm : 0 < Real.cos (δ - s - θ) := by
        have := Real.abs_cos_sub_cos_le (δ - s - θ) (δ - θ)
        rw [show δ - s - θ - (δ - θ) = -s by ring, abs_neg, abs_of_pos hs0] at this
        linarith [(abs_le.mp this).1]
      have hsins : 0 < Real.sin s := Real.sin_pos_of_pos_of_lt_pi hs0 (by linarith)
      have ep : Real.cos (δ + s - α) = -Real.sin (δ - α) * Real.sin s := by
        rw [show δ + s - α = (δ - α) + s by ring, Real.cos_add, hδα]; ring
      have em : Real.cos (δ - s - α) = Real.sin (δ - α) * Real.sin s := by
        rw [show δ - s - α = (δ - α) - s by ring, Real.cos_sub, hδα]; ring
      have hp' : σ (δ + s) = if 0 < Real.cos (δ + s - α) then x else y := by simp only [hσ, if_neg (not_lt.mpr hcp.le)]
      have hm' : σ (δ - s) = if 0 < Real.cos (δ - s - α) then x else y := by simp only [hσ, if_neg (not_lt.mpr hcm.le)]
      have hpm : σ (δ + s) = σ (δ - s) := hσp.trans hσm.symm
      rw [hp', hm'] at hpm
      rcases lt_or_gt_of_ne hsin with h | h
      · rw [if_pos (by rw [ep]; nlinarith), if_neg (by rw [em]; nlinarith)] at hpm; exact hne.2.2 hpm
      · rw [if_neg (by rw [ep]; nlinarith), if_pos (by rw [em]; nlinarith)] at hpm; exact hne.2.2 hpm.symm
  exact niceAt_of_dirColourAt hw hDC hrun hpoke h3

/-- **The two sides of the curve through a point of a good ball** (`GoodAt.ncard_coloursAt_le_two`'s construction, kept): near `z ≠ x`
on an arc, every point off the arc's full curve is an interior point, and the points on either side of the curve (by the sign of
`κ ‖y − x‖² − 2 dot (y − x) b`, `(κ, b)` the curve data) lie in one preconnected set of interior points each. -/
theorem GoodAt.exists_sides {x : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt x ρ₀) {z : ℂ} (hz : z ∈ ball x ρ₀) (hzx : z ≠ x)
    {a : Arc} (ha : a ∈ F.arcs) (hza : z ∈ a.carrier) :
    ∃ N ∈ 𝓝 z, N ⊆ ball x ρ₀ ∧ (∀ y ∈ N, y ∉ curveAt x (a.curveData x).1 (a.curveData x).2 → y ∈ F.interiorPts) ∧
      ∃ N₁ N₂ : Set ℂ, IsPreconnected N₁ ∧ IsPreconnected N₂ ∧ N₁ ⊆ F.interiorPts ∧ N₂ ⊆ F.interiorPts ∧
        (∀ y ∈ N, 0 < (a.curveData x).1 * ‖y - x‖ ^ 2 - 2 * dot (y - x) (a.curveData x).2 → y ∈ N₁) ∧
        (∀ y ∈ N, (a.curveData x).1 * ‖y - x‖ ^ 2 - 2 * dot (y - x) (a.curveData x).2 < 0 → y ∈ N₂) := by
  classical
  obtain ⟨δ, hδ, hδsub, hcurve⟩ := hG.exists_local_curve hz hzx ha hza
  have hxa : x ∈ a.carrier := hG.through a ha ⟨z, hza, hz⟩
  have hb := Arc.curveData_ne (F.nondegenerate a ha) hxa
  have hzC : z ∈ curveAt x (a.curveData x).1 (a.curveData x).2 := Arc.carrier_subset_curve hxa hza
  have hint : ∀ y ∈ ball z δ, y ∉ curveAt x (a.curveData x).1 (a.curveData x).2 → y ∈ F.interiorPts :=
    fun y hy hyC => ⟨hG.subdom (hδsub hy), fun h => by
      obtain ⟨a', ha', hya'⟩ := mem_iUnion₂.mp h
      exact hyC (hcurve y hy a' ha' hya')⟩
  have hκ := Arc.curveData_kappa x a
  generalize (a.curveData x).1 = κ at hκ hzC hint ⊢
  generalize (a.curveData x).2 = b at hb hzC hint ⊢
  have hdotre : ∀ p q : ℂ, dot p q = (p * starRingEnd ℂ q).re := fun _ _ => rfl
  rcases hκ with rfl | rfl
  · -- a line through `x`: two open half-discs
    have hlin : IsLinearMap ℝ fun y : ℂ => (y * (starRingEnd ℂ) b).re :=
      ⟨fun p q => by simp [add_mul], fun r p => by simp [Complex.real_smul, mul_assoc]⟩
    have hval : ∀ y : ℂ, 0 * ‖y - x‖ ^ 2 - 2 * dot (y - x) b =
        2 * ((x * (starRingEnd ℂ) b).re - (y * (starRingEnd ℂ) b).re) := fun y => by
      rw [hdotre, sub_mul, Complex.sub_re]; ring
    refine ⟨ball z δ, ball_mem_nhds z hδ, hδsub, hint, ball z δ ∩ {y | (y * (starRingEnd ℂ) b).re < (x * (starRingEnd ℂ) b).re},
      ball z δ ∩ {y | (x * (starRingEnd ℂ) b).re < (y * (starRingEnd ℂ) b).re},
      ((convex_ball z δ).inter (convex_halfSpace_lt hlin _)).isPreconnected,
      ((convex_ball z δ).inter (convex_halfSpace_gt hlin _)).isPreconnected, ?_, ?_,
      fun y hy h => ⟨hy, by rw [hval] at h; simp only [mem_setOf_eq]; linarith⟩,
      fun y hy h => ⟨hy, by rw [hval] at h; simp only [mem_setOf_eq]; linarith⟩⟩
    · rintro y ⟨hy, hy'⟩
      refine hint y hy fun h => ?_
      simp only [curveAt, mem_setOf_eq, zero_mul, sub_mul, Complex.sub_re] at h hy'
      linarith
    · rintro y ⟨hy, hy'⟩
      refine hint y hy fun h => ?_
      simp only [curveAt, mem_setOf_eq, zero_mul, sub_mul, Complex.sub_re] at h hy'
      linarith
  · -- a circle through `x`: two thin annular sectors about its centre
    have hR0 : 0 < ‖b‖ := norm_pos_iff.mpr hb
    have hC : ∀ y, y ∈ curveAt x 1 b ↔ ‖y - (x + b)‖ = ‖b‖ := fun y => mem_curveAt_one_iff x b y
    have hval : ∀ y : ℂ, 1 * ‖y - x‖ ^ 2 - 2 * dot (y - x) b = ‖y - (x + b)‖ ^ 2 - ‖b‖ ^ 2 := fun y => by
      rw [show y - (x + b) = (y - x) + (-b) by ring, norm_add_sq_dot, norm_neg, dot_eq, dot_eq, Complex.neg_re,
        Complex.neg_im]; ring
    have hzpol : z = (x + b) + (‖b‖ : ℂ) * e (0 + Complex.arg ((z - (x + b)) * starRingEnd ℂ (e 0))) := by
      have := eq_add_norm_mul_e (x + b) z 0
      rwa [(hC z).mp hzC] at this
    generalize 0 + Complex.arg ((z - (x + b)) * starRingEnd ℂ (e 0)) = θz at hzpol
    generalize x + b = c' at hC hzpol hval
    generalize ‖b‖ = R at hR0 hC hzpol hval
    set η := min (R / 2) (δ / (2 * (1 + R))) with hη
    have hη0 : 0 < η := lt_min (by positivity) (by positivity)
    have hηR : η ≤ R / 2 := min_le_left _ _
    have hηδ : η * (2 * (1 + R)) ≤ δ := (le_div_iff₀ (by positivity)).mp (min_le_right _ _)
    have hpol : ∀ s θ : ℝ, 0 ≤ s → ‖c' + (s : ℂ) * e θ - c'‖ = s := fun s θ hs => by
      rw [add_sub_cancel_left, norm_real_mul_e hs]
    have hNδ : annSector c' (R - η) (R + η) (θz - η) (θz + η) ⊆ ball z δ := by
      rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
      simp only at hs hθ
      rw [mem_ball, dist_eq_norm, hzpol]
      have h1 : c' + (s : ℂ) * e θ - (c' + (R : ℂ) * e θz) = ((s - R : ℝ) : ℂ) * e θ + (R : ℂ) * (e θ - e θz) := by
        push_cast; ring
      have h2 : |s - R| < η := abs_sub_lt_iff.mpr ⟨by linarith [hs.2], by linarith [hs.1]⟩
      have h3 : |θ - θz| < η := abs_sub_lt_iff.mpr ⟨by linarith [hθ.2], by linarith [hθ.1]⟩
      have h4 : ‖e θ - e θz‖ ≤ |θ - θz| := norm_e_sub_e_le θ θz
      rw [h1]
      calc ‖((s - R : ℝ) : ℂ) * e θ + (R : ℂ) * (e θ - e θz)‖
          ≤ ‖((s - R : ℝ) : ℂ) * e θ‖ + ‖(R : ℂ) * (e θ - e θz)‖ := norm_add_le _ _
        _ = |s - R| + R * ‖e θ - e θz‖ := by
            rw [norm_mul, norm_mul, norm_e, mul_one, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs,
              Real.norm_eq_abs, abs_of_pos hR0]
        _ < δ := by nlinarith
    have hNopen : IsOpen (annSector c' (R - η) (R + η) (θz - η) (θz + η)) := isOpen_annSector c' (by linarith) _ _ _
    have hzN : z ∈ annSector c' (R - η) (R + η) (θz - η) (θz + η) :=
      ⟨(R, θz), ⟨⟨by linarith, by linarith⟩, ⟨by linarith, by linarith⟩⟩, hzpol.symm⟩
    have hside : ∀ s θ, s ∈ Ioo (R - η) (R + η) → θ ∈ Ioo (θz - η) (θz + η) → s ≠ R →
        c' + (s : ℂ) * e θ ∈ F.interiorPts := fun s θ hs hθ hsR =>
      hint _ (hNδ ⟨(s, θ), ⟨hs, hθ⟩, rfl⟩) fun h => hsR (by rw [← (hC _).mp h, hpol s θ (by linarith [hs.1])])
    refine ⟨_, hNopen.mem_nhds hzN, hNδ.trans hδsub, fun y hy hyC => hint y (hNδ hy) hyC,
      annSector c' R (R + η) (θz - η) (θz + η), annSector c' (R - η) R (θz - η) (θz + η),
      isPreconnected_annSector _ _ _ _ _, isPreconnected_annSector _ _ _ _ _, ?_, ?_, ?_, ?_⟩
    · rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
      exact hside s θ ⟨by linarith [hs.1], hs.2⟩ hθ hs.1.ne'
    · rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
      exact hside s θ ⟨hs.1, by linarith [hs.2]⟩ hθ hs.2.ne
    · rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ h
      rw [hval, hpol s θ (by linarith [hs.1])] at h
      exact ⟨(s, θ), ⟨⟨by nlinarith [hs.1], hs.2⟩, hθ⟩, rfl⟩
    · rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ h
      rw [hval, hpol s θ (by linarith [hs.1])] at h
      exact ⟨(s, θ), ⟨⟨hs.1, by nlinarith [hs.1]⟩, hθ⟩, rfl⟩

/-- **The crossing case of `wedgeMerge_niceAt`**: `w = v + ρ e θ` on the merge's outer arc strictly inside the wedge, and on an arc of
`F`. Inside the circle near `w` is inside the wedge (colour `c`); outside, `G` is `F`, whose colours there are those of the two sides of
the one curve of `F` through `w` (`GoodAt.exists_sides`); `niceAt_of_crossing` finishes. -/
theorem wedgeMerge_crossing {v : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt v ρ₀) {ρ d₁ d₂ θ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂)
    (hd2 : d₂ ≤ d₁ + 2 * π) (hθ1 : d₁ < θ) (hθ2 : θ < d₂) {w : ℂ} (hwθ : w = v + (ρ : ℂ) * e θ) (hwv : w ≠ v)
    (hwball : w ∈ ball v ρ₀) (hΓ : w ∈ ⋃ a ∈ F.arcs, a.carrier)
    (h3 : 3 ≤ ((F.wedgeMerge v hρ hd hd2 c).coloursAt w).ncard) : (F.wedgeMerge v hρ hd hd2 c).NiceAt w := by
  classical
  set G := F.wedgeMerge v hρ hd hd2 c with hGdef
  have hcolG : ∀ z, G.col z = if z ∈ annSector v 0 ρ d₁ d₂ then c else F.col z := fun z => rfl
  obtain ⟨a, ha, hwa⟩ := mem_iUnion₂.mp hΓ
  obtain ⟨N, hN, -, hNint, N₁, N₂, hN₁, hN₂, hI₁, hI₂, hs₁, hs₂⟩ := hG.exists_sides hwball hwv ha hwa
  have hva : v ∈ a.carrier := hG.through a ha ⟨w, hwa, hwball⟩
  have hwC : w ∈ curveAt v (a.curveData v).1 (a.curveData v).2 := Arc.carrier_subset_curve hva hwa
  have hb := Arc.curveData_ne (F.nondegenerate a ha) hva
  have hκ := Arc.curveData_kappa v a
  generalize (a.curveData v).1 = κ at hκ hwC hNint hs₁ hs₂
  generalize (a.curveData v).2 = b at hb hwC hNint hs₁ hs₂
  -- the colours of the two sides
  have hone : ∀ {M : Set ℂ}, IsPreconnected M → M ⊆ F.interiorPts → ∃ x : Fin k, ∀ y ∈ M, F.col y = x := by
    intro M hM hMI
    by_cases hne : M.Nonempty
    · obtain ⟨p, hp⟩ := hne
      refine ⟨F.col p, fun q hq => ?_⟩
      have hT : F.IsTile (connectedComponentIn F.interiorPts p) := ⟨p, hMI hp, rfl⟩
      have hs := hT.subset_of_preconnected hM hMI hp (mem_connectedComponentIn (hMI hp))
      exact hT.col_eq (hs hq) (hs hp)
    · exact ⟨c, fun q hq => absurd ⟨q, hq⟩ hne⟩
  obtain ⟨x, hx⟩ := hone hN₁ hI₁
  obtain ⟨y, hy⟩ := hone hN₂ hI₂
  -- the two quadratic forms at `w`
  have hdotre : ∀ p q : ℂ, dot p q = (p * starRingEnd ℂ q).re := fun _ _ => rfl
  have hwv' : w - v = (ρ : ℂ) * e θ := by rw [hwθ]; ring
  have hgO : ∀ z, 2 * dot (z - w) ((ρ : ℂ) * e θ) + ‖z - w‖ ^ 2 = ‖z - v‖ ^ 2 - ρ ^ 2 := fun z => by
    rw [show z - v = (z - w) + (ρ : ℂ) * e θ by rw [← hwv']; ring, norm_add_sq_dot, norm_real_mul_e hρ.le]; ring
  have hcw : κ * ‖w - v‖ ^ 2 - 2 * dot (w - v) b = 0 := by
    simp only [curveAt, mem_setOf_eq, Complex.normSq_eq_norm_sq] at hwC
    rw [hdotre]; linarith
  set nC : ℂ := (κ : ℂ) * (w - v) - b with hnC
  have hfC : ∀ z, 2 * dot (z - w) nC + κ * ‖z - w‖ ^ 2 = κ * ‖z - v‖ ^ 2 - 2 * dot (z - v) b := fun z => by
    rw [show z - v = (z - w) + (w - v) by ring, norm_add_sq_dot, dot_add_left, hnC, dot_sub_right, dot_real_mul_right]
    linear_combination (-1 : ℝ) * hcw
  have hdd : dot (w - v) (w - v) = ‖w - v‖ ^ 2 := by
    rw [hdotre, Complex.mul_conj, Complex.ofReal_re, Complex.normSq_eq_norm_sq]
  have hnC0 : nC ≠ 0 := by
    intro h0
    have hbκ : b = (κ : ℂ) * (w - v) := by rw [hnC] at h0; linear_combination -h0
    rw [hbκ, dot_real_mul_right, hdd] at hcw
    have hwv2 : 0 < ‖w - v‖ ^ 2 := by have := norm_pos_iff.mpr (sub_ne_zero.mpr hwv); positivity
    rcases hκ with rfl | rfl
    · exact hb (by rw [hbκ]; simp)
    · linarith
  have hnCe : ((‖nC‖ : ℝ) : ℂ) * e (Complex.arg nC) = nC := by
    have := Complex.norm_mul_exp_arg_mul_I nC
    rw [e]; exact this
  -- the radius
  have hδθ : 0 < min (θ - d₁) (d₂ - θ) := lt_min (by linarith) (by linarith)
  have hev := eventually_abs_arg_lt v θ hρ hδθ
  rw [← hwθ] at hev
  obtain ⟨η, hη, hηsub⟩ := Metric.mem_nhds_iff.mp (inter_mem (inter_mem hN hev) (ball_mem_nhds w (half_pos hρ)))
  have hball : ∀ z ∈ ball w η, z ∈ N ∧ |Complex.arg ((z - v) * starRingEnd ℂ (e θ))| < min (θ - d₁) (d₂ - θ) ∧
      z ∈ ball w (ρ / 2) := fun z hz => ⟨(hηsub hz).1.1, (hηsub hz).1.2, (hηsub hz).2⟩
  have hwvn : ‖w - v‖ = ρ := by rw [hwv', norm_real_mul_e hρ.le]
  -- inside the circle near `w` is inside the wedge
  have hinW : ∀ z ∈ ball w η, ‖z - v‖ < ρ → z ∈ annSector v 0 ρ d₁ d₂ := by
    intro z hz hzρ
    obtain ⟨-, harg, hzb⟩ := hball z hz
    have hzv : 0 < ‖z - v‖ := by
      have h1 := norm_sub_norm_le (w - v) (z - v)
      rw [hwvn, show w - v - (z - v) = w - z by ring] at h1
      have h4 : ‖w - z‖ < ρ / 2 := by rw [← dist_eq_norm, dist_comm]; exact hzb
      linarith
    have h2 := abs_lt.mp (harg.trans_le (min_le_left _ _))
    have h3 := abs_lt.mp (harg.trans_le (min_le_right _ _))
    exact ⟨(‖z - v‖, θ + Complex.arg ((z - v) * starRingEnd ℂ (e θ))), ⟨⟨hzv, hzρ⟩, ⟨by linarith [h2.1], by linarith [h3.2]⟩⟩,
      (eq_add_norm_mul_e v z θ).symm⟩
  have hout : ∀ z, ρ < ‖z - v‖ → ∀ j, z ∈ F.region j → z ∈ G.region j := by
    intro z hz j hzj
    have hzc : z ∉ closedBall v ρ := by rw [mem_closedBall, dist_eq_norm]; linarith
    have := wedgeMerge_region_diff (F := F) (v := v) (c := c) hρ hd hd2 j
    have h' : z ∈ F.region j \ closedBall v ρ := ⟨hzj, hzc⟩
    rw [← this] at h'
    exact h'.1
  refine niceAt_of_crossing (G := G) (θ := θ) (α := Complex.arg nC) (pO := ρ) (pC := ‖nC‖) (κ := κ) (η := η)
    (c := c) (x := x) (y := y) (hG.subdom hwball) hκ hρ (norm_pos_iff.mpr hnC0) hη ?_ ?_ ?_ ?_ h3
  · intro z hz j hzj hg
    rw [hgO] at hg
    have hzW := hinW z hz (by nlinarith [norm_nonneg (z - v)])
    have h1 : G.col z = j := hzj.2
    rw [hcolG, if_pos hzW] at h1
    exact h1.symm
  · intro z hz hg hf
    rw [hgO] at hg
    rw [hnCe, hfC] at hf
    have hzW := hinW z hz (by nlinarith [norm_nonneg (z - v)])
    have hzI : z ∈ F.interiorPts := hNint z (hball z hz).1 fun hC => hf (by
      simp only [curveAt, mem_setOf_eq, Complex.normSq_eq_norm_sq] at hC
      rw [hdotre]; linarith)
    refine ⟨hzI.1, fun h => ?_⟩
    obtain ⟨a', ha', hza'⟩ := mem_iUnion₂.mp h
    rcases ha' with ha' | ha'
    · exact hzI.2 (mem_iUnion₂.mpr ⟨a', ha', hza'⟩)
    · exact annSector_notMem_wedgeArcs hd2 hzW (mem_iUnion₂.mpr ⟨a', ha', hza'⟩)
  · intro z hz hg hf
    rw [hgO] at hg
    rw [hnCe, hfC] at hf
    have hzρ : ρ < ‖z - v‖ := by nlinarith [norm_nonneg (z - v)]
    have hz₁ := hs₁ z (hball z hz).1 hf
    exact hout z hzρ x ⟨hI₁ hz₁, hx z hz₁⟩
  · intro z hz hg hf
    rw [hgO] at hg
    rw [hnCe, hfC] at hf
    have hzρ : ρ < ‖z - v‖ := by nlinarith [norm_nonneg (z - v)]
    have hz₂ := hs₂ z (hball z hz).1 hf
    exact hout z hzρ y ⟨hI₂ hz₂, hy z hz₂⟩

/-- **The points a merge at a wedge creates are `NiceAt`** (E3-NICE's crossings): inside a good ball of `F` at `v`, with the two edges in
`F`'s class of `c` a little beyond the radius `ρ`, every point of `closedBall v ρ` other than `v` that carries three or more colours after the
merge is `NiceAt` — it is a transversal crossing of the outer arc with a branch through `v`, `c` on the inner half and two other colours outside
(a three-sector picture); every other such point carries at most two colours. -/
theorem wedgeMerge_niceAt {v : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt v ρ₀) {ρ d₁ d₂ r₁ : ℝ} (hρ : 0 < ρ) (hρ₀ : ρ < ρ₀) (hd : d₁ < d₂)
    (hπ : d₂ - d₁ < π) (hρr : ρ < r₁)
    (hc : ∀ s ∈ Ioo 0 r₁, v + (s : ℂ) * e d₁ ∈ F.region c ∧ v + (s : ℂ) * e d₂ ∈ F.region c)
    {w : ℂ} (hw : w ∈ closedBall v ρ) (hwv : w ≠ v)
    (h3 : 3 ≤ ((F.wedgeMerge v hρ hd (by linarith [Real.pi_pos]) c).coloursAt w).ncard) :
    (F.wedgeMerge v hρ hd (by linarith [Real.pi_pos]) c).NiceAt w := by
  classical
  have hpi := Real.pi_pos
  have hd2 : d₂ ≤ d₁ + 2 * π := by linarith
  set G := F.wedgeMerge v hρ hd hd2 c with hGdef
  show G.NiceAt w
  have h3' : 3 ≤ (G.coloursAt w).ncard := h3
  have hcolG : ∀ z, G.col z = if z ∈ annSector v 0 ρ d₁ d₂ then c else F.col z := fun z => rfl
  have htwo : ∀ a b : Fin k, G.coloursAt w ⊆ {a, b} → False := fun a b h => by
    have h1 := Set.ncard_le_ncard h (Set.toFinite _)
    have h2 := Set.ncard_insert_le a {b}
    rw [Set.ncard_singleton] at h2
    omega
  have hsub : ∀ {U : Set ℂ} {T : Set (Fin k)}, U ∈ 𝓝 w → (∀ j, ∀ z ∈ G.region j, z ∈ U → j ∈ T) →
      G.coloursAt w ⊆ T := fun hU h j hj => by
    obtain ⟨z, hzU, hz⟩ := mem_closure_iff_nhds.mp hj _ hU
    exact h j z hz hzU
  have hregcol : ∀ {j : Fin k} {z : ℂ}, z ∈ G.region j → G.col z = j := fun hz => hz.2
  -- polar position of `w`
  have hwv0 : 0 < ‖w - v‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hwv)
  have hwρ : ‖w - v‖ ≤ ρ := by rw [← dist_eq_norm]; exact hw
  have hwball : w ∈ ball v ρ₀ := by rw [mem_ball, dist_eq_norm]; linarith
  obtain ⟨m, hm⟩ := exists_shift_Ico d₁ (d₁ + Complex.arg ((w - v) * starRingEnd ℂ (e d₁)))
  set θ := d₁ + Complex.arg ((w - v) * starRingEnd ℂ (e d₁)) + 2 * π * m with hθ
  have hwθ : w = v + (‖w - v‖ : ℂ) * e θ := by
    rw [hθ, e_add_two_pi_mul_int]; exact eq_add_norm_mul_e v w d₁
  -- on an edge: `F`'s class of `c` surrounds `w`, so `G` has one colour there
  have hedge : w ∈ F.region c → False := fun hwc =>
    htwo c c (hsub ((F.isOpen_region c).mem_nhds hwc) fun j z hz hzU => by
      have h1 := hregcol hz
      have h2 : F.col z = c := hzU.2
      rw [hcolG, h2] at h1
      split_ifs at h1 <;> exact Or.inl h1.symm)
  rcases lt_trichotomy θ d₂ with hθ2 | hθ2 | hθ2
  · rcases eq_or_lt_of_le hm.1 with hθ1 | hθ1
    · exfalso
      have := (hc ‖w - v‖ ⟨hwv0, by linarith⟩).1
      rw [hθ1, ← hwθ] at this
      exact hedge this
    rcases lt_or_eq_of_le hwρ with hwρ' | hwρ'
    · -- inside the open wedge: one colour
      exfalso
      have hwW : w ∈ annSector v 0 ρ d₁ d₂ := ⟨(‖w - v‖, θ), ⟨⟨hwv0, hwρ'⟩, ⟨hθ1, hθ2⟩⟩, hwθ.symm⟩
      refine htwo c c (hsub ((isOpen_annSector v le_rfl ρ d₁ d₂).mem_nhds hwW) fun j z hz hzU => ?_)
      have h1 := hregcol hz
      rw [hcolG, if_pos hzU] at h1
      exact Or.inl h1.symm
    · -- on the outer arc, strictly inside: the crossing
      have hwθρ : w = v + (ρ : ℂ) * e θ := by rw [← hwρ']; exact hwθ
      by_cases hΓ : w ∈ ⋃ a ∈ F.arcs, a.carrier
      · exact wedgeMerge_crossing hG hρ hd hd2 hθ1 hθ2 hwθρ hwv hwball hΓ h3'
      · exfalso
        have hwI : w ∈ F.interiorPts := ⟨hG.subdom hwball, hΓ⟩
        refine htwo c (F.col w) (hsub (F.locallyConstant w hwI.1 hΓ) fun j z hz hzU => ?_)
        have h1 := hregcol hz
        have h2 : F.col z = F.col w := hzU
        rw [hcolG] at h1
        split_ifs at h1
        · exact Or.inl h1.symm
        · exact Or.inr (h1.symm.trans h2)
  · exfalso
    have := (hc ‖w - v‖ ⟨hwv0, by linarith⟩).2
    rw [← hθ2, ← hwθ] at this
    exact hedge this
  · -- off the closed wedge: `G` is `F` near `w`, which has at most two colours there
    exfalso
    set P := (fun q : ℝ × ℝ => v + (q.1 : ℂ) * e q.2) '' (Icc 0 ρ ×ˢ Icc d₁ d₂) with hP
    have hPc : IsClosed P := ((isCompact_Icc.prod isCompact_Icc).image (by have := continuous_e; fun_prop)).isClosed
    have hwP : w ∉ P := by rw [hwθ]; exact polar_notMem hwv0 ⟨hθ2, hm.2⟩
    have hXP : closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier ⊆ P :=
      union_subset (closure_annSector_subset v hρ.le hd.le) (wedgeArcs_subset_polar hρ hd.le)
    have hreg : ∀ j, G.region j ∩ Pᶜ = F.region j ∩ Pᶜ := fun j => by
      have key : G.region j \ (closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier) =
          F.region j \ (closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier) :=
        recolour_region_diff (F := F) (W := annSector v 0 ρ d₁ d₂) (B := wedgeArcs v ρ d₁ d₂)
          (hB := wedgeArcs_nondegenerate hρ hd hd2) (hBf := ((finite_singleton _).insert _).insert _)
          (hW := frontier_annSector_subset hρ hd hd2) (c := c) j
      ext z
      constructor
      · rintro ⟨hz, hzP⟩
        have : z ∈ G.region j \ (closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier) :=
          ⟨hz, fun h => hzP (hXP h)⟩
        rw [key] at this
        exact ⟨this.1, hzP⟩
      · rintro ⟨hz, hzP⟩
        have : z ∈ F.region j \ (closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier) :=
          ⟨hz, fun h => hzP (hXP h)⟩
        rw [← key] at this
        exact ⟨this.1, hzP⟩
    have := coloursAt_congr (hPc.isOpen_compl.mem_nhds hwP) hreg
    have h2 := hG.ncard_coloursAt_le_two hwball hwv
    rw [← this] at h2
    omega

/-! ## E3-NICE and E3-BALL -/

/-- **E3-NICE, the merge at one point** (`plans/FS131-E3-derivation.md` § 3.3): for every `ε > 0` there are `ρ ∈ (0, ε)` and a valid map of the
plane, Condition 5 kept, equal to `F` off `closedBall v ρ`, in which every point of `closedBall v ρ` of three or more colours is `NiceAt` —
finitely many merges at wedges (`wedgeMerge`) of decreasing radii, each across a gap of angle `< π` between two arcs of one colour, or across a
colour poking into another's arc, until the local data at `v` satisfies `niceAt_of_dirColourAt`; the new points of three colours are crossings
of the merges' outer arcs with branches, `NiceAt` by the same lemma. -/
theorem exists_merge_at (hF : F.Valid) (hP : F.IsPlaneMap) (v : ℂ) {ε : ℝ} (hε : 0 < ε) :
    ∃ ρ ∈ Ioo 0 ε, ∃ F' : ArcMap k, F'.Valid ∧ F'.IsPlaneMap ∧ (F.Condition5 → F'.Condition5) ∧
      (∀ j, F'.region j \ closedBall v ρ = F.region j \ closedBall v ρ) ∧ F'.WoodallMerged (closedBall v ρ) := by
  sorry

/-- **Woodall's step 3, localized** (FS131-E3's E3-BALL, `plans/FS131-E3-derivation.md` § 3.4; `[Woodall1973]` p. 197 for the merge): every
valid map of the plane has a valid map of the plane, Condition 5 kept, in which every point of `closedBall 0 R` of three or more colours is
`NiceAt` — the points of three colours in the ball are finite (`finite_three_le_coloursAt`), and one merge (`exists_merge_at`), within less
than their distance to the others, removes one bad point and adds none (`coloursAt_congr`, `niceAt_congr` off the merged ball). Not claimed:
Woodall's horn-only conclusion, at every point (a GAP past Condition 5, inventory item 161 (b)). -/
theorem exists_woodallMerged (hF : F.Valid) (hP : F.IsPlaneMap) (R : ℝ) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.IsPlaneMap ∧ F'.WoodallMerged (closedBall 0 R) ∧ (F.Condition5 → F'.Condition5) := by
  classical
  -- the bad points of a map: points of the ball of three or more colours that are not `NiceAt`
  let bad : ArcMap k → Set ℂ := fun G => {w | w ∈ closedBall 0 R ∧ 3 ≤ (G.coloursAt w).ncard ∧ ¬ G.NiceAt w}
  suffices key : ∀ (n : ℕ) (S : Finset ℂ), S.card = n → ∀ G : ArcMap k, G.Valid → G.IsPlaneMap → bad G ⊆ ↑S →
      ∃ F' : ArcMap k, F'.Valid ∧ F'.IsPlaneMap ∧ F'.WoodallMerged (closedBall 0 R) ∧ (G.Condition5 → F'.Condition5) by
    have hfin := finite_three_le_coloursAt (F := F) (isCompact_closedBall (0 : ℂ) R) (by rw [hP]; exact subset_univ _)
    exact key _ hfin.toFinset rfl F hF hP fun w hw => hfin.mem_toFinset.mpr ⟨hw.1, hw.2.1⟩
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
  intro S hS G hG hGP hbad
  by_cases hne : (bad G).Nonempty
  · obtain ⟨v, hv⟩ := hne
    have hvS : v ∈ S := hbad hv
    obtain ⟨ρ, hρ, G₁, hG₁, hG₁P, h5, hdiff, hM⟩ := exists_merge_at hG hGP v one_pos
    have hsub : bad G₁ ⊆ ↑(S.erase v) := by
      rintro w ⟨hwR, hw3, hwn⟩
      by_cases hwv : w ∈ closedBall v ρ
      · exact absurd (hM w hwv hw3) hwn
      · have hU : (closedBall v ρ)ᶜ ∈ 𝓝 w := isClosed_closedBall.isOpen_compl.mem_nhds hwv
        have hreg : ∀ j, G₁.region j ∩ (closedBall v ρ)ᶜ = G.region j ∩ (closedBall v ρ)ᶜ := fun j => by
          simpa [Set.sdiff_eq] using hdiff j
        have hcol := coloursAt_congr hU hreg
        have hnice := niceAt_congr hU (by rw [hG₁P, hGP]) hreg
        have hwG : w ∈ bad G := ⟨hwR, hcol ▸ hw3, fun h => hwn (hnice.mpr h)⟩
        refine Finset.mem_coe.mpr (Finset.mem_erase.mpr ⟨?_, hbad hwG⟩)
        rintro rfl
        exact hwv (mem_closedBall_self hρ.1.le)
    have hlt : (S.erase v).card < n := by
      rw [← hS]; exact Finset.card_erase_lt_of_mem hvS
    obtain ⟨F', hF', hF'P, hF'M, hF'5⟩ := ih _ hlt (S.erase v) rfl G₁ hG₁ hG₁P hsub
    exact ⟨F', hF', hF'P, hF'M, fun h => hF'5 (h5 h)⟩
  · refine ⟨G, hG, hGP, fun w hw h3 => ?_, id⟩
    by_contra hn
    exact hne ⟨w, hw, h3, hn⟩

end ArcMap

end HadwigerNelson.Plane
