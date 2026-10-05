import Proofs.HadwigerNelson.Plane.Woodall.Merge

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

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

namespace ArcMap

variable {k : ℕ}

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

/-- `‖a + b‖² = ‖a‖² + ‖b‖² + 2 dot a b`. -/
theorem norm_add_sq_dot (a b : ℂ) : ‖a + b‖ ^ 2 = ‖a‖ ^ 2 + ‖b‖ ^ 2 + 2 * dot a b := by
  rw [← Complex.normSq_eq_norm_sq, ← Complex.normSq_eq_norm_sq, ← Complex.normSq_eq_norm_sq, Complex.normSq_add]; rfl

variable {F : ArcMap k} {c : Fin k}

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

/-- **The points a merge at a wedge creates are `NiceAt`** (development copy). -/
theorem wedgeMerge_niceAt' {v : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt v ρ₀) {ρ d₁ d₂ r₁ : ℝ} (hρ : 0 < ρ) (hρ₀ : ρ < ρ₀) (hd : d₁ < d₂)
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

end ArcMap

end HadwigerNelson.Plane
