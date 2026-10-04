import Proofs.HadwigerNelson.Plane.ValidMap.Contact

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- A branch point of curvature `m ≥ κ` is not below the arc of curvature `κ`. -/
theorem not_tanBelow_branchPt {v : ℂ} {β m κ s : ℝ} (hs : |m| * s ≤ 2) (hs0 : 0 ≤ s) (hm : κ ≤ m) :
    ¬ TanBelow v β κ (branchPt v β m s) := by
  unfold TanBelow
  rw [tanHeight_branchPt v β m κ hs hs0]
  have : 0 ≤ s ^ 2 * (m - κ) := mul_nonneg (sq_nonneg s) (by linarith)
  exact not_lt.mpr (by linarith)

/-- A branch point of curvature `m ≤ κ` is not above the arc of curvature `κ`. -/
theorem not_tanAbove_branchPt {v : ℂ} {β m κ s : ℝ} (hs : |m| * s ≤ 2) (hs0 : 0 ≤ s) (hm : m ≤ κ) :
    ¬ TanAbove v β κ (branchPt v β m s) := by
  unfold TanAbove
  rw [tanHeight_branchPt v β m κ hs hs0]
  have : s ^ 2 * (m - κ) ≤ 0 := mul_nonpos_of_nonneg_of_nonpos (sq_nonneg s) (by linarith)
  exact not_lt.mpr (by linarith)

/-- **A horn determines its curvatures**: `hornSet v α κ₁ κ₂ r = hornSet v α κ₁' κ₂' r` with `κ₁ < κ₂`, `κ₁' < κ₂'` and `r > 0`
gives `κ₁ = κ₁'` and `κ₂ = κ₂'` (a branch point of an intermediate curvature separates two different horns). -/
theorem hornSet_curv_eq {v : ℂ} {α κ₁ κ₂ κ₁' κ₂' r : ℝ} (h : κ₁ < κ₂) (h' : κ₁' < κ₂') (hr : 0 < r)
    (heq : hornSet v α κ₁ κ₂ r = hornSet v α κ₁' κ₂' r) : κ₁ = κ₁' ∧ κ₂ = κ₂' := by
  have key : ∀ {a₁ a₂ b₁ b₂ : ℝ}, a₁ < a₂ → b₁ < b₂ → hornSet v α a₁ a₂ r = hornSet v α b₁ b₂ r →
      a₂ ≤ b₂ ∧ b₁ ≤ a₁ := by
    intro a₁ a₂ b₁ b₂ ha hb he
    constructor
    · by_contra hlt
      push Not at hlt
      have hmax : max a₁ b₂ < a₂ := max_lt ha hlt
      have hm1 : a₁ < (max a₁ b₂ + a₂) / 2 := by have := le_max_left a₁ b₂; linarith
      have hm2 : (max a₁ b₂ + a₂) / 2 < a₂ := by linarith
      have hm3 : b₂ ≤ (max a₁ b₂ + a₂) / 2 := by have := le_max_right a₁ b₂; linarith
      obtain ⟨s, hs0, hsr, hsm⟩ := exists_small_s ((max a₁ b₂ + a₂) / 2) hr
      have hp := branchPt_mem_hornSet v α hm1 hm2 hs0 hsr hsm
      rw [he] at hp
      exact not_tanBelow_branchPt hsm.le hs0.le hm3 hp.2.2.2
    · by_contra hlt
      push Not at hlt
      have hmin : a₁ < min b₁ a₂ := lt_min hlt ha
      have hm1 : a₁ < (a₁ + min b₁ a₂) / 2 := by linarith
      have hm2 : (a₁ + min b₁ a₂) / 2 < a₂ := by have := min_le_right b₁ a₂; linarith
      have hm3 : (a₁ + min b₁ a₂) / 2 ≤ b₁ := by have := min_le_left b₁ a₂; linarith
      obtain ⟨s, hs0, hsr, hsm⟩ := exists_small_s ((a₁ + min b₁ a₂) / 2) hr
      have hp := branchPt_mem_hornSet v α hm1 hm2 hs0 hsr hsm
      rw [he] at hp
      exact not_tanAbove_branchPt hsm.le hs0.le hm3 hp.2.2.1
  obtain ⟨h1, h2⟩ := key h h' heq
  obtain ⟨h3, h4⟩ := key h' h heq.symm
  exact ⟨le_antisymm h4 h2, le_antisymm h1 h3⟩

/-- `e (α + π) ≠ e α`. -/
theorem e_add_pi_ne (α : ℝ) : e (α + π) ≠ e α := by
  intro h
  rw [e_add_pi'] at h
  have h0 : e α = 0 := by linear_combination -h / 2
  have hn := norm_e α
  rw [h0, norm_zero] at hn
  exact zero_ne_one hn

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **A horn's chart sector** (child of `stuck_structure` (i) and of `IsHorn.exists_flankAbove`): in a sector chart at `v`, a
horn along `e α` between `κ₁ < κ₂` is the sector after a germ `i` of direction `α` (mod `2π`) and curvature `κ₁`, whose next germ
has the same direction and curvature `κ₂`. -/
theorem IsHorn.exists_chart_index {v : ℂ} {α κ₁ κ₂ : ℝ} {c : Fin k} (hH : F.IsHorn v α κ₁ κ₂ c) {n : ℕ}
    {G : BranchGerms n} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀) :
    ∃ i : Fin n, e (G.β i) = e α ∧ G.nextβ i = G.β i ∧ G.κ i = κ₁ ∧ G.nextκ i = κ₂ := by
  obtain ⟨r, ⟨hS, -⟩, hr⟩ := (hH.2.and (Ioc_mem_nhdsGT hC.pos)).exists
  have hr0 : 0 < r := hr.1
  have hcone1 : ∀ β ∈ coneAt (hornSet v α κ₁ κ₂ r) v, e β = e α := fun β hβ => e_eq_of_mem_coneAt_hornSet hβ
  rcases Nat.eq_zero_or_pos n with hn | hn
  · exfalso
    have hball := (hC.isSector_iff_of_zero hn hr).mp hS
    have hmem : α + π ∈ coneAt (hornSet v α κ₁ κ₂ r) v := by rw [hball, coneAt_ball_self v hr0]; trivial
    exact e_add_pi_ne α (hcone1 _ hmem)
  obtain ⟨i, hi⟩ := (hC.isSector_iff hn hr).mp hS
  have hconei := hC.cone r hr i
  rw [← hi] at hconei
  have hβi : e (G.β i) = e α :=
    hcone1 _ (by rw [hconei]; exact Icc_subset_angleIcc _ _ ⟨le_rfl, hC.sorted.mono i⟩)
  rcases hC.sorted.2 i with hlt | ⟨heq, hκ⟩
  · exfalso
    have hd : 0 < G.nextβ i - G.β i := sub_pos.mpr hlt
    have hε0 : 0 < min (G.nextβ i - G.β i) π / 2 := by have := lt_min hd Real.pi_pos; positivity
    have hεπ : min (G.nextβ i - G.β i) π / 2 < π := by
      have := min_le_right (G.nextβ i - G.β i) π; linarith [Real.pi_pos]
    have hmem : G.β i + min (G.nextβ i - G.β i) π / 2 ∈ coneAt (hornSet v α κ₁ κ₂ r) v := by
      rw [hconei]
      refine Icc_subset_angleIcc _ _ ⟨by linarith, ?_⟩
      have := min_le_left (G.nextβ i - G.β i) π; linarith
    obtain ⟨m, hm⟩ := e_eq_e_iff.mp ((hcone1 _ hmem).trans hβi.symm)
    have hm1 : (0 : ℝ) < m := by nlinarith [Real.pi_pos]
    have hm2 : (m : ℝ) < 1 := by nlinarith [Real.pi_pos]
    have : (0 : ℤ) < m := by exact_mod_cast hm1
    have : m < 1 := by exact_mod_cast hm2
    omega
  · have h1 : |G.κ i| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv i).le
    have h2 : |G.nextκ i| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv_next i).le
    have hsec : G.sector v r i = hornSet v α (G.κ i) (G.nextκ i) r := by
      show sectorBetween v (G.β i) (G.κ i) (G.nextβ i) (G.nextκ i) r = _
      rw [← heq, sectorBetween_eq_hornSet v _ _ _ r h1 h2, hornSet_congr hβi]
    rw [hsec] at hi
    obtain ⟨hk1, hk2⟩ := hornSet_curv_eq hH.1 hκ hr0 hi
    exact ⟨i, hβi, heq.symm, hk1.symm, hk2.symm⟩

/-- **A chart sector lies in one colour's class**, at every radius up to the chart's. -/
theorem IsSectorChart.exists_col {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    (j : Fin n) : ∃ g, ∀ r ∈ Ioc 0 r₀, G.sector v r j ⊆ F.region g := by
  have hn : 0 < n := j.pos
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  obtain ⟨p, hp⟩ := hC.sector_nonempty hr₀ j
  refine ⟨F.col p, fun r hr z hz => ?_⟩
  have hmono : G.sector v r j ⊆ G.sector v r₀ j := by
    rintro w ⟨s, hs, φ, hφ, rfl⟩
    exact ⟨s, ⟨hs.1, hs.2.trans_le hr.2⟩, φ, hφ, rfl⟩
  refine ⟨hC.sector_subset_interiorPts hn hr j hz, ?_⟩
  show F.col z = F.col p
  exact (hC.isPreconnected r₀ hr₀ j).constant (F.continuousOn_col.mono (hC.sector_subset_interiorPts hn hr₀ j))
    (hmono hz) hp

/-- `arcsin` is small near `0`: for `d > 0` there is `η > 0` with `|arcsin x| < d` when `|x| < η`. -/
theorem exists_abs_arcsin_lt {d : ℝ} (hd : 0 < d) : ∃ η > 0, ∀ x : ℝ, |x| < η → |Real.arcsin x| < d := by
  obtain ⟨η, hη, hηa⟩ := Metric.continuousAt_iff.mp Real.continuous_arcsin.continuousAt d hd
  refine ⟨η, hη, fun x hx => ?_⟩
  have := @hηa x (by rw [Real.dist_eq, sub_zero]; exact hx)
  rwa [Real.dist_eq, Real.arcsin_zero, sub_zero] at this

/-- A curvature times a radius below `η/(|κ| + 1)` halves to below `η`. -/
theorem abs_half_lt {κ s η : ℝ} (hη : 0 < η) (hs0 : 0 < s) (hs : s < η / (|κ| + 1)) : |κ * s / 2| < η := by
  have h1 : 0 < |κ| + 1 := by positivity
  have h2 : s * (|κ| + 1) < η := (lt_div_iff₀ h1).mp hs
  rw [abs_div, abs_mul, abs_of_pos hs0, abs_two]
  nlinarith [abs_nonneg κ]

/-- **The flank after a germ** (child of `IsHorn.exists_flankAbove`): in a sector chart at `v`, above a germ of direction `α` (mod
`2π`) and curvature `κ` a thin horn `hornSet v α κ κ' r` lies, for all small `r`, in the class of the sector's colour. -/
theorem IsSectorChart.exists_flank_after {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    {j : Fin n} {α κ : ℝ} (hβ : e (G.β j) = e α) (hκ : G.κ j = κ) :
    ∃ g κ', κ < κ' ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ κ' r ⊆ F.region g := by
  obtain ⟨g, hg⟩ := hC.exists_col j
  obtain ⟨m, hm⟩ := e_eq_e_iff.mp hβ
  have hcj : ∀ r ∈ Ioc 0 r₀, |κ| * r ≤ 2 := fun r hr => by
    rw [← hκ]; exact (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv j).le
  rcases hC.sorted.2 j with hlt | ⟨heq, hκ'⟩
  · -- a gap after the germ: a thin horn above it lies in sector `j`
    have hd : 0 < G.nextβ j - G.β j := sub_pos.mpr hlt
    obtain ⟨η, hη, hηa⟩ := exists_abs_arcsin_lt (half_pos hd)
    have hr₁ : 0 < min r₀ (min (1 / (|κ + 1| + 1)) (min (η / (|κ + 1| + 1)) (η / (|G.nextκ j| + 1)))) := by
      have := hC.pos; positivity
    refine ⟨g, κ + 1, by linarith, ?_⟩
    filter_upwards [Ioo_mem_nhdsGT hr₁] with r hr
    have hrr₀ : r ∈ Ioc 0 r₀ := ⟨hr.1, hr.2.le.trans (min_le_left _ _)⟩
    have hr2 : r < min (1 / (|κ + 1| + 1)) (min (η / (|κ + 1| + 1)) (η / (|G.nextκ j| + 1))) :=
      lt_of_lt_of_le hr.2 (min_le_right _ _)
    have h2 : |κ + 1| * r ≤ 2 := by
      have := abs_half_lt one_pos hr.1 (lt_of_lt_of_le hr2 (min_le_left _ _))
      rw [abs_div, abs_mul, abs_of_pos hr.1, abs_two] at this; linarith
    intro z hz
    apply hg r hrr₀
    rw [← sectorBetween_eq_hornSet v α κ (κ + 1) r (hcj r hrr₀) h2] at hz
    obtain ⟨s, hs, φ, hφ, rfl⟩ := hz
    have hsr : s < r := hs.2
    have ha1 := hηa _ (abs_half_lt hη hs.1 (lt_trans hsr (lt_of_lt_of_le hr2
      ((min_le_right _ _).trans (min_le_left _ _)))))
    have ha2 := hηa _ (abs_half_lt hη hs.1 (lt_trans hsr (lt_of_lt_of_le hr2
      ((min_le_right _ _).trans (min_le_right _ _)))))
    rw [abs_lt] at ha1 ha2
    refine ⟨s, hs, φ + 2 * π * m, ⟨?_, ?_⟩, ?_⟩
    · rw [hm, hκ]; linarith [hφ.1]
    · show φ + 2 * π * m < G.nextβ j + Real.arcsin (G.nextκ j * s / 2)
      linarith [hφ.2]
    · rw [e_add_int_mul]
  · -- the next germ has the same direction: sector `j` is the horn above the germ
    refine ⟨g, G.nextκ j, hκ ▸ hκ', ?_⟩
    filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
    have h2 : |G.nextκ j| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv_next j).le
    have h1 : |G.κ j| * r ≤ 2 := by rw [hκ]; exact hcj r hr
    have hsec : G.sector v r j = hornSet v α κ (G.nextκ j) r := by
      show sectorBetween v (G.β j) (G.κ j) (G.nextβ j) (G.nextκ j) r = _
      rw [← heq, sectorBetween_eq_hornSet v _ _ _ r h1 h2, hornSet_congr hβ, hκ]
    rw [← hsec]; exact hg r hr

/-- **The flank before a germ** (child of `IsHorn.exists_flankBelow`): in a sector chart at `v`, below the germ after sector `p`, of
direction `α` (mod `2π`) and curvature `κ`, a thin horn `hornSet v α κ' κ r` lies, for all small `r`, in sector `p`'s colour. -/
theorem IsSectorChart.exists_flank_before {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    {p : Fin n} {α κ : ℝ} (hβ : e (G.nextβ p) = e α) (hκ : G.nextκ p = κ) :
    ∃ h κ', κ' < κ ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ' κ r ⊆ F.region h := by
  obtain ⟨h, hh⟩ := hC.exists_col p
  obtain ⟨m, hm⟩ := e_eq_e_iff.mp hβ
  have hcp : ∀ r ∈ Ioc 0 r₀, |κ| * r ≤ 2 := fun r hr => by
    rw [← hκ]; exact (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv_next p).le
  rcases hC.sorted.2 p with hlt | ⟨heq, hκ'⟩
  · have hd : 0 < G.nextβ p - G.β p := sub_pos.mpr hlt
    obtain ⟨η, hη, hηa⟩ := exists_abs_arcsin_lt (half_pos hd)
    have hr₁ : 0 < min r₀ (min (1 / (|κ - 1| + 1)) (min (η / (|κ - 1| + 1)) (η / (|G.κ p| + 1)))) := by
      have := hC.pos; positivity
    refine ⟨h, κ - 1, by linarith, ?_⟩
    filter_upwards [Ioo_mem_nhdsGT hr₁] with r hr
    have hrr₀ : r ∈ Ioc 0 r₀ := ⟨hr.1, hr.2.le.trans (min_le_left _ _)⟩
    have hr2 : r < min (1 / (|κ - 1| + 1)) (min (η / (|κ - 1| + 1)) (η / (|G.κ p| + 1))) :=
      lt_of_lt_of_le hr.2 (min_le_right _ _)
    have h1 : |κ - 1| * r ≤ 2 := by
      have := abs_half_lt one_pos hr.1 (lt_of_lt_of_le hr2 (min_le_left _ _))
      rw [abs_div, abs_mul, abs_of_pos hr.1, abs_two] at this; linarith
    intro z hz
    apply hh r hrr₀
    rw [← sectorBetween_eq_hornSet v α (κ - 1) κ r h1 (hcp r hrr₀)] at hz
    obtain ⟨s, hs, φ, hφ, rfl⟩ := hz
    have hsr : s < r := hs.2
    have ha1 := hηa _ (abs_half_lt hη hs.1 (lt_trans hsr (lt_of_lt_of_le hr2
      ((min_le_right _ _).trans (min_le_left _ _)))))
    have ha2 := hηa _ (abs_half_lt hη hs.1 (lt_trans hsr (lt_of_lt_of_le hr2
      ((min_le_right _ _).trans (min_le_right _ _)))))
    rw [abs_lt] at ha1 ha2
    refine ⟨s, hs, φ + 2 * π * m, ⟨?_, ?_⟩, ?_⟩
    · show G.β p + Real.arcsin (G.κ p * s / 2) < φ + 2 * π * m
      linarith [hφ.1]
    · show φ + 2 * π * m < G.nextβ p + Real.arcsin (G.nextκ p * s / 2)
      rw [hm, hκ]; linarith [hφ.2]
    · rw [e_add_int_mul]
  · refine ⟨h, G.κ p, hκ ▸ hκ', ?_⟩
    filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
    have h1 : |G.κ p| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv p).le
    have h2 : |G.nextκ p| * r ≤ 2 := by rw [hκ]; exact hcp r hr
    have hβ' : e (G.β p) = e α := by rw [heq]; exact hβ
    have hsec : G.sector v r p = hornSet v α (G.κ p) κ r := by
      show sectorBetween v (G.β p) (G.κ p) (G.nextβ p) (G.nextκ p) r = _
      rw [← heq, sectorBetween_eq_hornSet v _ _ _ r h1 h2, hornSet_congr hβ', hκ]
    rw [← hsec]; exact hh r hr

/-- **A horn has an upper flank** (FS131-IC2's finding 1): at a point of the domain, the colour of the sector after a horn's lies
directly above the horn's upper arc. -/
theorem IsHorn.exists_flankAbove {v : ℂ} {α κ₁ κ₂ : ℝ} {c : Fin k} (hv : v ∈ F.dom) (hH : F.IsHorn v α κ₁ κ₂ c) :
    ∃ g, F.IsFlankAbove v α κ₂ g := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hv
  obtain ⟨i, hβi, hnext, -, hκ₂⟩ := hH.exists_chart_index hC
  have hn := i.pos
  obtain ⟨j, hβj, hκj⟩ : ∃ j : Fin n, e (G.β j) = e α ∧ G.κ j = κ₂ := by
    by_cases h : i.val + 1 < n
    · refine ⟨⟨i.val + 1, h⟩, ?_, ?_⟩
      · have : G.nextβ i = G.β ⟨i.val + 1, h⟩ := by unfold BranchGerms.nextβ; split_ifs; rfl
        rw [← this, hnext, hβi]
      · have : G.nextκ i = G.κ ⟨i.val + 1, h⟩ := by unfold BranchGerms.nextκ; split_ifs; rfl
        rw [← this, hκ₂]
    · refine ⟨⟨0, hn⟩, ?_, ?_⟩
      · have : G.nextβ i = G.β ⟨0, hn⟩ + 2 * π := by unfold BranchGerms.nextβ; split_ifs; rfl
        have h2 := e_add_int_mul (G.β ⟨0, hn⟩) 1
        rw [Int.cast_one, mul_one, ← this, hnext, hβi] at h2
        exact h2.symm
      · have : G.nextκ i = G.κ ⟨0, hn⟩ := by unfold BranchGerms.nextκ; split_ifs; rfl
        rw [← this, hκ₂]
  obtain ⟨g, κ', hκ', hev⟩ := hC.exists_flank_after hβj hκj
  exact ⟨g, κ', hκ', hev⟩

/-- **A horn has a lower flank** (the mirror of `IsHorn.exists_flankAbove`): the colour of the sector before a horn's lies directly
below the horn's lower arc. -/
theorem IsHorn.exists_flankBelow {v : ℂ} {α κ₁ κ₂ : ℝ} {c : Fin k} (hv : v ∈ F.dom) (hH : F.IsHorn v α κ₁ κ₂ c) :
    ∃ h, F.IsFlankBelow v α κ₁ h := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hv
  obtain ⟨i, hβi, -, hκ₁, -⟩ := hH.exists_chart_index hC
  have hn := i.pos
  obtain ⟨p, hβp, hκp⟩ : ∃ p : Fin n, e (G.nextβ p) = e α ∧ G.nextκ p = κ₁ := by
    by_cases h0 : 0 < i.val
    · have hlt : i.val - 1 + 1 < n := by omega
      have hi : (⟨i.val - 1 + 1, hlt⟩ : Fin n) = i := Fin.ext (by simp only; omega)
      refine ⟨⟨i.val - 1, by omega⟩, ?_, ?_⟩
      · have : G.nextβ ⟨i.val - 1, by omega⟩ = G.β i := by
          unfold BranchGerms.nextβ; split_ifs with hh
          · exact congrArg G.β hi
          · exact absurd hlt hh
        rw [this, hβi]
      · have : G.nextκ ⟨i.val - 1, by omega⟩ = G.κ i := by
          unfold BranchGerms.nextκ; split_ifs with hh
          · exact congrArg G.κ hi
          · exact absurd hlt hh
        rw [this, hκ₁]
    · have hi0 : (⟨0, hn⟩ : Fin n) = i := Fin.ext (by simp only; omega)
      have hlt : ¬ (n - 1 + 1 < n) := by omega
      refine ⟨⟨n - 1, by omega⟩, ?_, ?_⟩
      · have : G.nextβ ⟨n - 1, by omega⟩ = G.β ⟨0, hn⟩ + 2 * π := by
          unfold BranchGerms.nextβ; split_ifs with hh
          · exact absurd hh hlt
          · rfl
        have h2 := e_add_int_mul (G.β ⟨0, hn⟩) 1
        rw [Int.cast_one, mul_one, ← this, hi0, hβi] at h2
        exact h2
      · have : G.nextκ ⟨n - 1, by omega⟩ = G.κ ⟨0, hn⟩ := by
          unfold BranchGerms.nextκ; split_ifs with hh
          · exact absurd hh hlt
          · rfl
        rw [this, hi0, hκ₁]
  obtain ⟨h, κ', hκ', hev⟩ := hC.exists_flank_before hβp hκp
  exact ⟨h, κ', hκ', hev⟩

end ArcMap

end HadwigerNelson.Plane
