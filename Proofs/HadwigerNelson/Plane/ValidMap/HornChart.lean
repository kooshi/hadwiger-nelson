import Proofs.HadwigerNelson.Plane.ValidMap.OpenMove
import Proofs.HadwigerNelson.Plane.ValidMap.Pushforward

/-!
# Horn counts where a collar bend needs them (FS131-KA1's skeleton; both collar bends)

The horn count is metric (`HasHornCount` counts the sectors that are `hornSet`s), so a homeomorphism does not carry it; a collar bend's
horn clause (`CollarFit.map_hornCount_le`, and the away bend's, `plans/FS131-bendaway-kernel-plan.md` § 3, lane H) is read by the place
of the point:

* where two maps agree near the point, the counts agree (`hasHornCount_iff_of_agree`, the ball form of `Procedure`'s
  `hasHornCount_iff_of_agreesOff`, which sits downstream);
* at an interior point the count is `0` (`hasHornCount_zero_of_mem_interiorPts`);
* at a point near which `Γ` lies on two circles that are not tangent there — a point of the lens curve, its corner included — the count
  is `0` (`hasHornCount_zero_of_two_spheres`);
* at an end of the bent arc, the bent map's germs are `F`'s with one germ's curvature moved inside a cusp `F.Γ` misses, so the count is
  kept (`hasHornCount_iff_of_germ_swap`).

`IsSectorChart.hasHornCount` reads the count off any sector chart (through `Near.hasHornCount_chart`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **The horn count at any sector chart with a germ** is its number of cusps: the chart extends to near data (`exists_near`'s
construction at the given chart), and `Near.hasHornCount_chart` reads the count. -/
theorem IsSectorChart.hasHornCount {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀) (hn : 0 < n) :
    F.HasHornCount v {i : Fin n | G.β i = G.nextβ i}.ncard := by
  obtain ⟨s₀, hs₀, hs₀r₀, hdisj, hord⟩ := hC.eventually_ord
  obtain ⟨ρ₀, hG⟩ := F.exists_goodAt (hC.subdom (mem_ball_self hC.pos))
  choose col hcol using hC.exists_col
  exact Near.hasHornCount_chart (X := (⟨n, G, r₀, s₀, ρ₀, col, hC, ⟨hs₀, hs₀r₀⟩, hdisj, hord, hG, hcol⟩ : F.Near v)) hn

/-- **Horn counts agree where two maps have the same interior points near the point** (sectors are read off the interior points of
small balls; mirror of `hasDegree_iff_of_agree`). **Proved (FS131-BA2)** (plan § 3, child H1; short). Inhabitant of the hypotheses: `F' = F`. -/
theorem hasHornCount_iff_of_agree {F' : ArcMap k} {v : ℂ} {r₀ : ℝ} (hr₀ : 0 < r₀)
    (hI : ∀ x ∈ ball v r₀, x ∈ F'.interiorPts ↔ x ∈ F.interiorPts) (j : ℕ) : F'.HasHornCount v j ↔ F.HasHornCount v j := by
  have hU : ∀ r ∈ Ioc 0 r₀, F'.interiorPts ∩ ball v r = F.interiorPts ∩ ball v r := by
    intro r hr
    ext x
    exact ⟨fun ⟨h1, h2⟩ => ⟨(hI x (ball_subset_ball hr.2 h2)).mp h1, h2⟩,
      fun ⟨h1, h2⟩ => ⟨(hI x (ball_subset_ball hr.2 h2)).mpr h1, h2⟩⟩
  have hS : ∀ r ∈ Ioc 0 r₀, ∀ S, F'.IsSector v r S ↔ F.IsSector v r S := by
    intro r hr S
    simp only [IsSector, hU r hr]
  have hev : ∀ᶠ r in 𝓝[>] (0 : ℝ), r ∈ Ioc 0 r₀ := Ioc_mem_nhdsGT hr₀
  refine Filter.eventually_congr (hev.mono fun r hr => ?_)
  rw [show {S | F'.IsSector v r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v α κ₁ κ₂ r} =
    {S | F.IsSector v r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v α κ₁ κ₂ r} from
    Set.ext fun S => and_congr_left fun _ => hS r hr S]

/-- **An interior point has no horn** (its only sector is the ball, which holds the point; `exists_hasHornCount`'s first case).
**Proved (FS131-BA2)** (child H2; short). -/
theorem hasHornCount_zero_of_mem_interiorPts {v : ℂ} (hv : v ∈ F.interiorPts) : F.HasHornCount v 0 := by
  obtain ⟨X⟩ := exists_near hv.1
  have hn : X.n = 0 := by
    by_contra hm
    exact hv.2 (X.hC.mem_Γ.mpr (Nat.pos_of_ne_zero hm)).2
  filter_upwards [Ioc_mem_nhdsGT X.hC.pos] with r hr
  rw [Nat.cast_zero, encard_eq_zero, eq_empty_iff_forall_notMem]
  rintro S ⟨hS, α, κ₁, κ₂, -, rfl⟩
  have hball := (X.hC.isSector_iff_of_zero hn hr).mp hS
  have hv' : v ∈ hornSet v α κ₁ κ₂ r := hball ▸ mem_ball_self hr.1
  have := hv'.2.1
  simp [frameX] at this

/-- **A branch that meets a circle at distances accumulating at `0`** passes through the circle at its base point, is tangent to it
there, and has its curvature: with `(x − q) e(−β) = u + v i`, `u = 0` and `κ v = −1`. (Real identity: `|branchPt − q|² = |x − q|² +
s (2 (u cos a + v sin a) + s)`, `a = arcsin (κ s / 2)`.) -/
theorem branch_frequently_mem_sphere {x q : ℂ} {β κ ρ : ℝ}
    (hf : ∃ᶠ s in 𝓝[>] (0 : ℝ), branchPt x β κ s ∈ sphere q ρ) :
    x ∈ sphere q ρ ∧ ((x - q) * starRingEnd ℂ (e β)).re = 0 ∧ κ * ((x - q) * starRingEnd ℂ (e β)).im = -1 := by
  have h0 : branchPt x β κ 0 = x := by simp [branchPt]
  have htend : Tendsto (branchPt x β κ) (𝓝[>] (0 : ℝ)) (𝓝 x) := by
    have := (continuous_branchPt x β κ).tendsto 0
    rw [h0] at this
    exact this.mono_left nhdsWithin_le_nhds
  have hxS : x ∈ sphere q ρ := isClosed_sphere.mem_of_frequently_of_tendsto hf htend
  have hU : ((x - q) * starRingEnd ℂ (e β)).re = (x.re - q.re) * Real.cos β + (x.im - q.im) * Real.sin β := by
    simp only [Complex.mul_re, Complex.sub_re, Complex.sub_im, Complex.conj_re, Complex.conj_im, re_e, im_e]; ring
  have hV : ((x - q) * starRingEnd ℂ (e β)).im = (x.im - q.im) * Real.cos β - (x.re - q.re) * Real.sin β := by
    simp only [Complex.mul_im, Complex.sub_re, Complex.sub_im, Complex.conj_re, Complex.conj_im, re_e, im_e]; ring
  rw [hU, hV]
  set U := (x.re - q.re) * Real.cos β + (x.im - q.im) * Real.sin β with hUdef
  set V := (x.im - q.im) * Real.cos β - (x.re - q.re) * Real.sin β with hVdef
  have hkey : ∀ s : ℝ, 0 < s → |κ * s / 2| ≤ 1 → branchPt x β κ s ∈ sphere q ρ →
      2 * (U * Real.cos (Real.arcsin (κ * s / 2)) + V * (κ * s / 2)) + s = 0 := by
    intro s hs hκs hmem
    have hsa : Real.sin (Real.arcsin (κ * s / 2)) = κ * s / 2 := Real.sin_arcsin (abs_le.mp hκs).1 (abs_le.mp hκs).2
    have h1 : dist (branchPt x β κ s) q ^ 2 = dist x q ^ 2 +
        s * (2 * (U * Real.cos (Real.arcsin (κ * s / 2)) + V * Real.sin (Real.arcsin (κ * s / 2))) + s) := by
      rw [dist_eq_norm, dist_eq_norm, Complex.sq_norm, Complex.sq_norm, Complex.normSq_apply, Complex.normSq_apply, branchPt,
        hUdef, hVdef]
      simp only [Complex.add_re, Complex.sub_re, Complex.mul_re, Complex.add_im, Complex.sub_im, Complex.mul_im,
        Complex.ofReal_re, Complex.ofReal_im, re_e, im_e, Real.cos_add, Real.sin_add]
      linear_combination s ^ 2 * (Real.cos (Real.arcsin (κ * s / 2)) ^ 2 + Real.sin (Real.arcsin (κ * s / 2)) ^ 2) *
        Real.cos_sq_add_sin_sq β + s ^ 2 * Real.cos_sq_add_sin_sq (Real.arcsin (κ * s / 2))
    rw [mem_sphere] at hmem hxS
    rw [hmem, hxS, hsa] at h1
    have h2 : s * (2 * (U * Real.cos (Real.arcsin (κ * s / 2)) + V * (κ * s / 2)) + s) = 0 := by linarith
    rcases mul_eq_zero.mp h2 with h | h
    · exact absurd h hs.ne'
    · exact h
  have hev : ∀ᶠ s in 𝓝[>] (0 : ℝ), 0 < s ∧ |κ * s / 2| ≤ 1 := by
    have hc : Continuous fun s : ℝ => κ * s / 2 := by fun_prop
    have h1 : ∀ᶠ s in 𝓝 (0 : ℝ), |κ * s / 2| < 1 := by
      have h2 : (fun s : ℝ => κ * s / 2) 0 ∈ Ioo (-1 : ℝ) 1 := by simp
      filter_upwards [hc.continuousAt.eventually (Ioo_mem_nhds h2.1 h2.2)] with s hs
      exact abs_lt.mpr hs
    filter_upwards [self_mem_nhdsWithin, h1.filter_mono nhdsWithin_le_nhds] with s hs hs'
    exact ⟨hs, hs'.le⟩
  have hfreq : ∃ᶠ s in 𝓝[>] (0 : ℝ), 2 * (U * Real.cos (Real.arcsin (κ * s / 2)) + V * (κ * s / 2)) + s = 0 ∧ 0 < s :=
    (hf.and_eventually hev).mono fun s hs => ⟨hkey s hs.2.1 hs.2.2 hs.1, hs.2.1⟩
  have hg : Continuous fun s : ℝ => 2 * (U * Real.cos (Real.arcsin (κ * s / 2)) + V * (κ * s / 2)) + s := by
    have := Real.continuous_arcsin
    fun_prop
  have hU0 : U = 0 := by
    have hmem := isClosed_singleton.mem_of_frequently_of_tendsto (hfreq.mono fun s hs => hs.1)
      ((hg.tendsto 0).mono_left nhdsWithin_le_nhds)
    simp only [mul_zero, zero_div, Real.arcsin_zero, Real.cos_zero, mul_one, add_zero, mem_singleton_iff] at hmem
    linarith
  refine ⟨hxS, hU0, ?_⟩
  obtain ⟨s, hs, hs0⟩ := hfreq.exists
  rw [hU0] at hs
  have h3 : s * (κ * V + 1) = 0 := by linarith
  rcases mul_eq_zero.mp h3 with h | h
  · exact absurd h hs0.ne'
  · linarith

/-- **Two branches of one direction on two circles that are not tangent at the base point have one curvature** (the same circle
twice is allowed). -/
theorem branch_curv_eq_of_two_spheres {x q q' : ℂ} {β β' κ κ' ρ ρ' : ℝ} (hβ : e β = e β')
    (h1 : ∃ᶠ s in 𝓝[>] (0 : ℝ), branchPt x β κ s ∈ sphere q ρ)
    (h2 : ∃ᶠ s in 𝓝[>] (0 : ℝ), branchPt x β' κ' s ∈ sphere q' ρ')
    (hnt : x ∈ sphere q ρ → x ∈ sphere q' ρ' → (q = q' ∧ ρ = ρ') ∨ ((x - q) * starRingEnd ℂ (x - q')).im ≠ 0) :
    κ = κ' := by
  obtain ⟨hx1, hu1, hv1⟩ := branch_frequently_mem_sphere h1
  obtain ⟨hx2, hu2, hv2⟩ := branch_frequently_mem_sphere h2
  rw [← hβ] at hu2 hv2
  rcases hnt hx1 hx2 with ⟨rfl, -⟩ | him
  · have hv0 : ((x - q) * starRingEnd ℂ (e β)).im ≠ 0 := by
      intro h; rw [h, mul_zero] at hv1; norm_num at hv1
    exact mul_right_cancel₀ hv0 (hv1.trans hv2.symm)
  · exfalso
    apply him
    simp only [Complex.mul_re, Complex.sub_re, Complex.sub_im, Complex.conj_re, Complex.conj_im, re_e, im_e] at hu1 hu2
    simp only [Complex.mul_im, Complex.sub_re, Complex.sub_im, Complex.conj_re, Complex.conj_im]
    have hcs := Real.cos_sq_add_sin_sq β
    have e1 : ((x.re - q.re) * -(x.im - q'.im) + (x.im - q.im) * (x.re - q'.re)) * Real.cos β = 0 := by
      linear_combination (x.im - q.im) * hu2 - (x.im - q'.im) * hu1
    have e2 : ((x.re - q.re) * -(x.im - q'.im) + (x.im - q.im) * (x.re - q'.re)) * Real.sin β = 0 := by
      linear_combination (x.re - q'.re) * hu1 - (x.re - q.re) * hu2
    linear_combination Real.cos β * e1 + Real.sin β * e2 -
      ((x.re - q.re) * -(x.im - q'.im) + (x.im - q.im) * (x.re - q'.re)) * hcs

/-- **No horn where `Γ` lies on two circles that are not tangent at the point** (the same circle twice is allowed): a horn is a sector
between two consecutive germs of one direction (`Near.sector_eq_hornSet_iff`); a germ's branch lies in `Γ`, so on one of the circles
near the point, and is tangent to it there; two germs of one direction on one circle are one germ (`Near.hdisj`), and on two circles
they make the circles tangent. **Proved (FS131-BA2)** (child H3). Inhabitant of the hypotheses: a point of a ring arc's interior with
`Γ` free near it (`q = q' = P`, `ρ = ρ' = 1`; `l60Frag`). -/
theorem hasHornCount_zero_of_two_spheres {x q q' : ℂ} {ρ ρ' r : ℝ} (hx : x ∈ F.dom) (hr : 0 < r) (hρ : 0 < ρ) (hρ' : 0 < ρ')
    (hΓ : F.Γ ∩ ball x r ⊆ sphere q ρ ∪ sphere q' ρ')
    (hnt : x ∈ sphere q ρ → x ∈ sphere q' ρ' → (q = q' ∧ ρ = ρ') ∨ ((x - q) * starRingEnd ℂ (x - q')).im ≠ 0) :
    F.HasHornCount x 0 := by
  -- the radii's positivity is not read by this proof (reported: FS131-BA2's record, a generalization)
  have _ := hρ
  have _ := hρ'
  obtain ⟨X⟩ := exists_near hx
  rcases Nat.eq_zero_or_pos X.n with hn | hn
  · filter_upwards [Ioc_mem_nhdsGT X.hC.pos] with r' hr'
    rw [Nat.cast_zero, encard_eq_zero, eq_empty_iff_forall_notMem]
    rintro S ⟨hS, α, κ₁, κ₂, -, rfl⟩
    have hball := (X.hC.isSector_iff_of_zero hn hr').mp hS
    have hv' : x ∈ hornSet x α κ₁ κ₂ r' := hball ▸ mem_ball_self hr'.1
    have := hv'.2.1
    simp [frameX] at this
  · have hfr : ∀ m : Fin X.n, (∃ᶠ s in 𝓝[>] (0 : ℝ), branchPt x (X.G.β m) (X.G.κ m) s ∈ sphere q ρ) ∨
        ∃ᶠ s in 𝓝[>] (0 : ℝ), branchPt x (X.G.β m) (X.G.κ m) s ∈ sphere q' ρ' := by
      intro m
      rw [← Filter.frequently_or_distrib]
      refine (Filter.eventually_of_mem (Ioo_mem_nhdsGT (lt_min hr X.hC.pos)) fun s hs => ?_).frequently
      refine hΓ ⟨X.hC.branchPt_mem_Γ m ⟨hs.1, hs.2.trans_le (min_le_right _ _)⟩, ?_⟩
      rw [mem_ball, dist_eq_norm, norm_branchPt_sub _ _ _ hs.1.le]
      exact hs.2.trans_le (min_le_left _ _)
    have hnt' : x ∈ sphere q' ρ' → x ∈ sphere q ρ →
        (q' = q ∧ ρ' = ρ) ∨ ((x - q') * starRingEnd ℂ (x - q)).im ≠ 0 := by
      intro h1 h2
      rcases hnt h2 h1 with ⟨h3, h4⟩ | h3
      · exact Or.inl ⟨h3.symm, h4.symm⟩
      · right
        intro h5
        apply h3
        simp only [Complex.mul_im, Complex.sub_re, Complex.sub_im, Complex.conj_re, Complex.conj_im] at h5 ⊢
        linarith
    have h0 : {i : Fin X.n | X.G.β i = X.G.nextβ i} = ∅ := by
      rw [eq_empty_iff_forall_notMem]
      intro i hi
      have hi' : X.G.β i = X.G.nextβ i := hi
      have hκ : X.G.κ i < X.G.κ (BranchGerms.next i) := by
        rcases X.hC.sorted.2 i with h | ⟨-, h⟩
        · rw [← hi'] at h; exact absurd h (lt_irrefl _)
        · rwa [X.G.nextκ_eq] at h
      have he : e (X.G.β i) = e (X.G.β (BranchGerms.next i)) := by rw [← X.G.e_nextβ i, ← hi']
      have hsame : ∀ {q₀ : ℂ} {ρ₀ : ℝ}, x ∈ sphere q₀ ρ₀ → x ∈ sphere q₀ ρ₀ →
          (q₀ = q₀ ∧ ρ₀ = ρ₀) ∨ ((x - q₀) * starRingEnd ℂ (x - q₀)).im ≠ 0 := fun _ _ => Or.inl ⟨rfl, rfl⟩
      rcases hfr i with h1 | h1 <;> rcases hfr (BranchGerms.next i) with h2 | h2
      · exact hκ.ne (branch_curv_eq_of_two_spheres he h1 h2 hsame)
      · exact hκ.ne (branch_curv_eq_of_two_spheres he h1 h2 hnt)
      · exact hκ.ne (branch_curv_eq_of_two_spheres he h1 h2 hnt')
      · exact hκ.ne (branch_curv_eq_of_two_spheres he h1 h2 hsame)
    have := X.hasHornCount_chart hn
    rwa [h0, ncard_empty] at this

/-- **Two branches that agree at distances accumulating at `0` are one germ**: one direction (mod `2π`) and one curvature. -/
theorem germ_eq_of_frequently_branchPt_eq {x : ℂ} {β β' κ κ' : ℝ}
    (hf : ∃ᶠ s in 𝓝[>] (0 : ℝ), branchPt x β κ s = branchPt x β' κ' s) : e β = e β' ∧ κ = κ' := by
  have hsmall : ∀ c : ℝ, ∀ᶠ s in 𝓝 (0 : ℝ), |c * s / 2| ≤ 1 := by
    intro c
    have hc : Continuous fun s : ℝ => c * s / 2 := by fun_prop
    have h2 : (fun s : ℝ => c * s / 2) 0 ∈ Ioo (-1 : ℝ) 1 := by simp
    filter_upwards [hc.continuousAt.eventually (Ioo_mem_nhds h2.1 h2.2)] with s hs
    exact (abs_lt.mpr hs).le
  have hev : ∀ᶠ s in 𝓝[>] (0 : ℝ), 0 < s ∧ |κ * s / 2| ≤ 1 ∧ |κ' * s / 2| ≤ 1 := by
    filter_upwards [self_mem_nhdsWithin, (hsmall κ).filter_mono nhdsWithin_le_nhds,
      (hsmall κ').filter_mono nhdsWithin_le_nhds] with s hs h1 h2
    exact ⟨hs, h1, h2⟩
  have hf' : ∃ᶠ s in 𝓝[>] (0 : ℝ), e (germDir β κ s) = e (germDir β' κ' s) ∧ 0 < s ∧ |κ * s / 2| ≤ 1 ∧ |κ' * s / 2| ≤ 1 :=
    (hf.and_eventually hev).mono fun s hs => ⟨((polar_eq_iff hs.2.1 hs.2.1).mp hs.1).2, hs.2⟩
  have he : e β = e β' := by
    have hcl : IsClosed {s : ℝ | e (germDir β κ s) = e (germDir β' κ' s)} :=
      isClosed_eq (continuous_e.comp (continuous_germDir β κ)) (continuous_e.comp (continuous_germDir β' κ'))
    have h0 : (0 : ℝ) ∈ {s : ℝ | e (germDir β κ s) = e (germDir β' κ' s)} :=
      hcl.mem_of_frequently_of_tendsto (hf'.mono fun s hs => hs.1) (tendsto_id.mono_left nhdsWithin_le_nhds)
    simpa using h0
  refine ⟨he, ?_⟩
  obtain ⟨s, hes, hs, h1, h2⟩ := hf'.exists
  unfold germDir at hes
  rw [e_add, e_add, he] at hes
  have hea : e (Real.arcsin (κ * s / 2)) = e (Real.arcsin (κ' * s / 2)) := mul_left_cancel₀ (e_ne_zero β') hes
  obtain ⟨m, hm⟩ := e_eq_e_iff.mp hea
  have ha := Real.arcsin_mem_Icc (κ * s / 2)
  have ha' := Real.arcsin_mem_Icc (κ' * s / 2)
  have hπ := Real.pi_pos
  have hm0 : m = 0 := by
    by_contra hne
    rcases lt_or_gt_of_ne hne with hneg | hpos
    · have : (m : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_of_lt hneg
      nlinarith [ha.1, ha.2, ha'.1, ha'.2]
    · have : (1 : ℝ) ≤ m := by exact_mod_cast hpos
      nlinarith [ha.1, ha.2, ha'.1, ha'.2]
  rw [hm0] at hm
  have harc : Real.arcsin (κ * s / 2) = Real.arcsin (κ' * s / 2) := by simpa using hm
  have hkk := (Real.arcsin_inj (abs_le.mp h1).1 (abs_le.mp h1).2 (abs_le.mp h2).1 (abs_le.mp h2).2).mp harc
  have h3 : s * (κ - κ') = 0 := by linarith
  rcases mul_eq_zero.mp h3 with h | h
  · exact absurd h hs.ne'
  · linarith

/-- **The horn count is kept when one germ's curvature moves inside a cusp `Γ` misses**: near `x`, `Γ_M` is `Γ_F` with the branch of
direction `β₀` and curvature `κ₀` replaced by the branch of the same direction and curvature `κ₀'`, and `Γ_F` has no point on a branch
of that direction with curvature between the two (other than `κ₀`'s own). Route: `F`'s chart at `x` (`localSectors`) has a germ
`(β₀, κ₀)` (its branch lies in `Γ`); the germs with `κ₀'` in its place are sorted (`hbetween`) and are `M`'s chart (`isSectorChart_of`,
`hM`); directions are unchanged, so the cusps `{i | β i = nextβ i}` are the same (`IsSectorChart.hasHornCount`). **Proved (FS131-BA2)**
(child H4, the hardest of lane H). Inhabitant of the hypotheses: the toward collar bend at an end of its arc (`collarModel`), with
`β₀ = θ₁ + π/2`, `κ₀ = 1`, `κ₀' = 1/R`. -/
theorem hasHornCount_iff_of_germ_swap {M : ArcMap k} {x : ℂ} {β₀ κ₀ κ₀' r : ℝ} (hx : x ∈ F.dom) (hdom : M.dom = F.dom)
    (hr : 0 < r) (hκ : |κ₀| * r < 2) (hκ' : |κ₀'| * r < 2) (hF : branchPt x β₀ κ₀ '' Ioo 0 r ⊆ F.Γ)
    (hM : (M.Γ ∩ ball x r) \ {x} =
      ((F.Γ ∩ ball x r) \ {x}) \ (branchPt x β₀ κ₀ '' Ioo 0 r) ∪ branchPt x β₀ κ₀' '' Ioo 0 r)
    (hbetween : ∀ κ, min κ₀ κ₀' ≤ κ → κ ≤ max κ₀ κ₀' → κ ≠ κ₀ → ∀ s ∈ Ioo 0 r, branchPt x β₀ κ s ∉ F.Γ) (j : ℕ) :
    M.HasHornCount x j ↔ F.HasHornCount x j := by
  -- `hκ` is not read by this proof: `F`'s own chart bounds its germ's curvature (reported: FS131-BA2's record, a generalization)
  have _ := hκ
  obtain ⟨r₀, n, G, hC, hdisjF⟩ := localSectors_disj F hx
  have hr₁ : 0 < min r r₀ := lt_min hr hC.pos
  have hnex : ∀ {β κ s : ℝ}, 0 < s → branchPt x β κ s ≠ x := by
    intro β κ s hs h
    have := norm_branchPt_sub x β κ hs.le
    rw [h, sub_self, norm_zero] at this
    exact hs.ne this
  have hdistb : ∀ {β κ s : ℝ}, 0 < s → dist (branchPt x β κ s) x = s := fun {β κ s} hs => by
    rw [dist_eq_norm, norm_branchPt_sub _ _ _ hs.le]
  -- (1) the germ `(β₀, κ₀)` is one of the chart's
  have hex : ∃ i₀ : Fin n, e (G.β i₀) = e β₀ ∧ G.κ i₀ = κ₀ := by
    by_contra hne
    push Not at hne
    have hall : ∀ i : Fin n, ∀ᶠ s in 𝓝[>] (0 : ℝ), branchPt x (G.β i) (G.κ i) s ≠ branchPt x β₀ κ₀ s := by
      intro i
      by_contra hfr
      rw [Filter.not_eventually] at hfr
      have hfr' : ∃ᶠ s in 𝓝[>] (0 : ℝ), branchPt x (G.β i) (G.κ i) s = branchPt x β₀ κ₀ s :=
        hfr.mono fun s hs => not_not.mp hs
      obtain ⟨h1, h2⟩ := germ_eq_of_frequently_branchPt_eq hfr'
      exact hne i h1 h2
    obtain ⟨s, hs, hsI⟩ := ((Filter.eventually_all.mpr hall).and (Ioo_mem_nhdsGT hr₁)).exists
    have hmem : branchPt x β₀ κ₀ s ∈ (F.Γ ∩ ball x r₀) \ {x} :=
      ⟨⟨hF ⟨s, ⟨hsI.1, hsI.2.trans_le (min_le_left _ _)⟩, rfl⟩,
        by rw [mem_ball, hdistb hsI.1]; exact hsI.2.trans_le (min_le_right _ _)⟩, hnex hsI.1⟩
    rw [hC.branches] at hmem
    obtain ⟨i, s', hs', heq⟩ := mem_iUnion.mp hmem
    have hss : s' = s := by
      have := congrArg (fun z => dist z x) heq
      simpa [hdistb hs'.1, hdistb hsI.1] using this
    subst hss
    exact hs i heq
  obtain ⟨i₀, hi₀β, hi₀κ⟩ := hex
  have hn : 0 < n := i₀.pos
  -- (2) the other germs of that direction have their curvature off the interval between `κ₀` and `κ₀'`
  have hout : ∀ j : Fin n, j ≠ i₀ → e (G.β j) = e β₀ → G.κ j < min κ₀ κ₀' ∨ max κ₀ κ₀' < G.κ j := by
    intro j hj hej
    by_contra hcon
    push Not at hcon
    have hne : G.κ j ≠ κ₀ := by rw [← hi₀κ]; exact hC.sorted.κ_ne hj (hej.trans hi₀β.symm)
    have hs : min r r₀ / 2 ∈ Ioo 0 (min r r₀) := ⟨by linarith, by linarith⟩
    refine hbetween (G.κ j) hcon.1 hcon.2 hne _ ⟨hs.1, hs.2.trans_le (min_le_left _ _)⟩ ?_
    rw [← branchPt_congr hej]
    exact hC.branchPt_mem_Γ j ⟨hs.1, hs.2.trans_le (min_le_right _ _)⟩
  -- (3) the swapped germs
  set G' : BranchGerms n := ⟨G.β, Function.update G.κ i₀ κ₀'⟩ with hG'
  have hκ'i₀ : G'.κ i₀ = κ₀' := Function.update_self _ _ _
  have hκ'ne : ∀ j, j ≠ i₀ → G'.κ j = G.κ j := fun j hj => Function.update_of_ne hj _ _
  have hord : ∀ a b : Fin n, a ≠ b → e (G.β a) = e (G.β b) → G.κ a < G.κ b → G'.κ a < G'.κ b := by
    intro a b hab he hlt
    by_cases ha : a = i₀
    · subst ha
      have hb : b ≠ a := fun h => hab h.symm
      rw [hκ'i₀, hκ'ne b hb]
      rw [hi₀κ] at hlt
      rcases hout b hb (he.symm.trans hi₀β) with h | h
      · exact absurd (h.trans_le (min_le_left _ _)) (not_lt.mpr hlt.le)
      · exact (le_max_right _ _).trans_lt h
    · by_cases hb : b = i₀
      · subst hb
        rw [hκ'i₀, hκ'ne a ha]
        rw [hi₀κ] at hlt
        rcases hout a ha (he.trans hi₀β) with h | h
        · exact h.trans_le (min_le_right _ _)
        · exact absurd ((le_max_left _ _).trans_lt h) (not_lt.mpr hlt.le)
      · rw [hκ'ne a ha, hκ'ne b hb]; exact hlt
  have hsorted : G'.Sorted := by
    refine ⟨fun i j hij => ?_, fun i => ?_⟩
    · rcases hC.sorted.1 i j hij with h | ⟨h1, h2⟩
      · exact Or.inl h
      · exact Or.inr ⟨h1, hord i j hij.ne (by rw [h1]) h2⟩
    · rcases hC.sorted.2 i with h | ⟨h1, h2⟩
      · exact Or.inl h
      · refine Or.inr ⟨h1, ?_⟩
        rw [G.nextκ_eq] at h2
        rw [G'.nextκ_eq]
        have hne : i ≠ BranchGerms.next i := fun h => by rw [← h] at h2; exact lt_irrefl _ h2
        exact hord i _ hne (by rw [← G.e_nextβ i, ← h1]) h2
  have hcurv : ∀ i, |G'.κ i| * min r r₀ < 2 := by
    intro i
    by_cases hi : i = i₀
    · subst hi
      rw [hκ'i₀]
      exact lt_of_le_of_lt (mul_le_mul_of_nonneg_left (min_le_left _ _) (abs_nonneg _)) hκ'
    · rw [hκ'ne i hi]
      exact lt_of_le_of_lt (mul_le_mul_of_nonneg_left (min_le_right _ _) (abs_nonneg _)) (hC.curv i)
  have hsub : ball x (min r r₀) ⊆ M.dom := by
    rw [hdom]; exact (ball_subset_ball (min_le_right _ _)).trans hC.subdom
  -- the new branch lies in `Γ_M`
  have hnewM : ∀ s ∈ Ioo 0 r, branchPt x β₀ κ₀' s ∈ M.Γ := by
    intro s hs
    have : branchPt x β₀ κ₀' s ∈ (M.Γ ∩ ball x r) \ {x} := by rw [hM]; exact Or.inr ⟨s, hs, rfl⟩
    exact this.1.1
  have hxM : x ∈ M.Γ := by
    by_contra hxΓ
    have hxI : x ∈ M.interiorPts := ⟨hdom ▸ hx, fun h => hxΓ ⟨hdom ▸ hx, h⟩⟩
    obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp M.isOpen_interiorPts x hxI
    have hs : min ε r / 2 ∈ Ioo 0 (min ε r) := ⟨by have := lt_min hε hr; linarith, by have := lt_min hε hr; linarith⟩
    have h1 := hnewM _ ⟨hs.1, hs.2.trans_le (min_le_right _ _)⟩
    have h2 : branchPt x β₀ κ₀' (min ε r / 2) ∈ M.interiorPts :=
      hball (by rw [mem_ball, hdistb hs.1]; exact hs.2.trans_le (min_le_left _ _))
    exact h2.2 h1.2
  have hbranches : (M.Γ ∩ ball x (min r r₀)) \ {x} = ⋃ i, branchPt x (G'.β i) (G'.κ i) '' Ioo 0 (min r r₀) := by
    ext z
    constructor
    · rintro ⟨⟨hzM, hzb⟩, hzx⟩
      have hz' : z ∈ (M.Γ ∩ ball x r) \ {x} := ⟨⟨hzM, ball_subset_ball (min_le_left _ _) hzb⟩, hzx⟩
      rw [hM] at hz'
      rcases hz' with ⟨⟨⟨hzF, -⟩, -⟩, hzB⟩ | ⟨s, hs, rfl⟩
      · have hzF' : z ∈ (F.Γ ∩ ball x r₀) \ {x} := ⟨⟨hzF, ball_subset_ball (min_le_right _ _) hzb⟩, hzx⟩
        rw [hC.branches] at hzF'
        obtain ⟨i, s, hs, rfl⟩ := mem_iUnion.mp hzF'
        rw [mem_ball, hdistb hs.1] at hzb
        have hi : i ≠ i₀ := by
          rintro rfl
          exact hzB ⟨s, ⟨hs.1, hzb.trans_le (min_le_left _ _)⟩, by rw [← hi₀κ]; exact (branchPt_congr hi₀β s).symm⟩
        exact mem_iUnion.mpr ⟨i, s, ⟨hs.1, hzb⟩, by rw [hκ'ne i hi]⟩
      · rw [mem_ball, hdistb hs.1] at hzb
        exact mem_iUnion.mpr ⟨i₀, s, ⟨hs.1, hzb⟩, by rw [hκ'i₀]; exact branchPt_congr hi₀β s⟩
    · intro hz
      obtain ⟨i, s, hs, rfl⟩ := mem_iUnion.mp hz
      have hsr : s ∈ Ioo 0 r := ⟨hs.1, hs.2.trans_le (min_le_left _ _)⟩
      have hsr₀ : s ∈ Ioo 0 r₀ := ⟨hs.1, hs.2.trans_le (min_le_right _ _)⟩
      refine ⟨⟨?_, by rw [mem_ball, hdistb hs.1]; exact hs.2⟩, hnex hs.1⟩
      by_cases hi : i = i₀
      · subst hi
        rw [hκ'i₀]
        have := hnewM s hsr
        rwa [← branchPt_congr hi₀β s] at this
      · rw [hκ'ne i hi]
        have hmem : branchPt x (G.β i) (G.κ i) s ∈ (M.Γ ∩ ball x r) \ {x} := by
          rw [hM]
          refine Or.inl ⟨⟨⟨hC.branchPt_mem_Γ i hsr₀, by rw [mem_ball, hdistb hs.1]; exact hsr.2⟩, hnex hs.1⟩, ?_⟩
          rintro ⟨s', hs', heq⟩
          have hss : s' = s := by
            have := congrArg (fun z => dist z x) heq
            simpa [hdistb hs'.1, hdistb hs.1] using this
          subst hss
          rw [← branchPt_congr hi₀β, ← hi₀κ] at heq
          exact hdisjF i i₀ hi s' hsr₀ ((polar_eq_iff hs.1 hs.1).mp heq).2.symm
        exact hmem.1.1
  have hkeyd : ∀ j : Fin n, j ≠ i₀ → ∀ s ∈ Ioo 0 (min r r₀), e (germDir (G.β i₀) κ₀' s) ≠ e (germDir (G.β j) (G.κ j) s) := by
    intro j hj s hs he
    have hsr : s ∈ Ioo 0 r := ⟨hs.1, hs.2.trans_le (min_le_left _ _)⟩
    have hsr₀ : s ∈ Ioo 0 r₀ := ⟨hs.1, hs.2.trans_le (min_le_right _ _)⟩
    by_cases hκκ : κ₀' = κ₀
    · rw [hκκ, ← hi₀κ] at he
      exact hdisjF i₀ j (Ne.symm hj) s hsr₀ he
    · have h1 : branchPt x β₀ κ₀' s = branchPt x (G.β j) (G.κ j) s := by
        rw [← branchPt_congr hi₀β, branchPt_eq, branchPt_eq, he]
      exact hbetween κ₀' (min_le_right _ _) (le_max_right _ _) hκκ s hsr (h1 ▸ hC.branchPt_mem_Γ j hsr₀)
  have hdisjM : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 (min r r₀), e (G'.dir i s) ≠ e (G'.dir j s) := by
    intro i j hij s hs
    have hsr₀ : s ∈ Ioo 0 r₀ := ⟨hs.1, hs.2.trans_le (min_le_right _ _)⟩
    show e (germDir (G.β i) (G'.κ i) s) ≠ e (germDir (G.β j) (G'.κ j) s)
    by_cases hi : i = i₀
    · subst hi
      rw [hκ'i₀, hκ'ne j (Ne.symm hij)]
      exact hkeyd j (Ne.symm hij) s hs
    · by_cases hj : j = i₀
      · subst hj
        rw [hκ'i₀, hκ'ne i hi]
        exact fun h => hkeyd i hi s hs h.symm
      · rw [hκ'ne i hi, hκ'ne j hj]
        exact hdisjF i j hij s hsr₀
  have hC' : M.IsSectorChart G' x (min r r₀) :=
    M.isSectorChart_of G' hr₁ hsub hsorted hcurv ⟨fun _ => hn, fun _ => hxM⟩ hbranches hdisjM
  have hcF : F.HasHornCount x {i : Fin n | G.β i = G.nextβ i}.ncard := hC.hasHornCount hn
  have hcM : M.HasHornCount x {i : Fin n | G.β i = G.nextβ i}.ncard := hC'.hasHornCount hn
  exact ⟨fun h => h.eq hcM ▸ hcF, fun h => h.eq hcF ▸ hcM⟩

end ArcMap

end HadwigerNelson.Plane
