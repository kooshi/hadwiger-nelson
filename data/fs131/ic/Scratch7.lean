import Proofs.HadwigerNelson.Plane.ValidMap.Contact

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- Real arithmetic for N4-FLANK: a point `p` behind the pole `S′` (`x_p ≤ 0`), outside `B̄(v, 1)` and within `1` of `S′`, is
farther than `1` from a point `z` near the axis on the `+a` side outside `B̄(S′, 1)` (frame at `v`; `w` is `z`'s height above
`S′`, `Y` is `p`'s). -/
theorem flank_back_aux {x w X Y : ℝ} (hx : 0 < x) (hw : |w - 1| ≤ x) (hw0 : 0 ≤ w) (hz : 1 < x ^ 2 + w ^ 2)
    (hX : X ≤ 0) (hY1 : Y ≤ 1) (hp : 1 ≤ X ^ 2 + (Y - 1) ^ 2) : 1 < (x - X) ^ 2 + (w - Y) ^ 2 := by
  rcases le_or_gt Y 0 with hY | hY
  · nlinarith [mul_nonneg hx.le (neg_nonneg.mpr hX), mul_nonneg hw0 (neg_nonneg.mpr hY)]
  · have hXY : Y ≤ -X := by nlinarith
    have hwY : (w - 1) * Y ≤ x * Y := by have := (abs_le.mp hw).2; nlinarith
    have hxX : x * Y ≤ x * (-X) := mul_le_mul_of_nonneg_left hXY hx.le
    nlinarith

/-- Real arithmetic for N4-FLANK: on a circle about `S′`, moving up (`Y₀ < Y₁`, both on the `+a` side) brings a point nearer to
`z = (x, w)` when `x` is small and `w ≥ 1/2`. -/
theorem flank_higher_aux {x w X₀ Y₀ X₁ Y₁ : ℝ} (hX₀ : 0 < X₀) (hX₁ : 0 < X₁) (hsq : X₀ ^ 2 + Y₀ ^ 2 = X₁ ^ 2 + Y₁ ^ 2)
    (hY : Y₀ < Y₁) (hb : |Y₀ + Y₁| ≤ 4 * X₁) (hx : 0 ≤ x) (hx8 : x < 1 / 8) (hw : 1 / 2 ≤ w) :
    (x - X₁) ^ 2 + (w - Y₁) ^ 2 < (x - X₀) ^ 2 + (w - Y₀) ^ 2 := by
  have hb' := (abs_le.mp hb).2
  have key : 0 < (Y₁ - Y₀) * (w * (X₀ + X₁) - x * (Y₀ + Y₁)) := by
    apply mul_pos (by linarith)
    nlinarith
  have hid : (X₀ + X₁) * (x * (X₁ - X₀) + w * (Y₁ - Y₀)) = (Y₁ - Y₀) * (w * (X₀ + X₁) - x * (Y₀ + Y₁)) := by
    have : X₁ ^ 2 - X₀ ^ 2 = Y₀ ^ 2 - Y₁ ^ 2 := by linarith
    linear_combination x * this
  have hpos : 0 < x * (X₁ - X₀) + w * (Y₁ - Y₀) := by
    rw [← hid] at key
    exact pos_of_mul_pos_right key (by linarith)
  nlinarith

/-- `sin ψ < t` for `ψ ∈ (−3π/2, arcsin t)` on the `+a` side (`cos ψ > 0`). -/
theorem sin_lt_of_cos_pos {ψ t : ℝ} (ht : t ∈ Icc (-1 : ℝ) 1) (hlo : -(3 * π / 2) < ψ) (hhi : ψ < Real.arcsin t)
    (hc : 0 < Real.cos ψ) : Real.sin ψ < t := by
  have hπ := Real.pi_pos
  have hψ : -(π / 2) < ψ := by
    by_contra hle
    push Not at hle
    have : Real.cos (ψ + 2 * π) ≤ 0 :=
      Real.cos_nonpos_of_pi_div_two_le_of_le (by linarith) (by linarith)
    rw [Real.cos_add_two_pi] at this
    linarith
  have := Real.sin_lt_sin_of_lt_of_le_pi_div_two hψ.le (Real.arcsin_le_pi_div_two t) hhi
  rwa [Real.sin_arcsin ht.1 ht.2] at this

/-- `t < sin ψ` for `ψ ∈ (arcsin t, 3π/2)` on the `+a` side (`cos ψ > 0`): the mirror of `sin_lt_of_cos_pos`. -/
theorem lt_sin_of_cos_pos {ψ t : ℝ} (ht : t ∈ Icc (-1 : ℝ) 1) (hlo : Real.arcsin t < ψ) (hhi : ψ < 3 * π / 2)
    (hc : 0 < Real.cos ψ) : t < Real.sin ψ := by
  have h := sin_lt_of_cos_pos (ψ := -ψ) (t := -t) ⟨by linarith [ht.2], by linarith [ht.1]⟩ (by linarith)
    (by rw [Real.arcsin_neg]; linarith) (by rwa [Real.cos_neg])
  rw [Real.sin_neg] at h
  linarith

/-- `s/2 ≤ X` on a circle of radius `s` where `|Y| ≤ s/2` and `X > 0`. -/
theorem flank_half_le_aux {X Y s : ℝ} (hX : 0 < X) (hsq : X ^ 2 + Y ^ 2 = s ^ 2) (hY : |Y| ≤ s / 2) :
    s / 2 ≤ X := by
  nlinarith [abs_le.mp hY, sq_abs Y]

/-- A horn point near `v` (curvatures in `[−1, 1]`) has height at most its `a`-coordinate. -/
theorem abs_frameY_of_horn_le {v z : ℂ} {α κ₁ κ₂ r : ℝ} (h1 : -1 < κ₁) (h2 : κ₂ < 1) (hz : z ∈ hornSet v α κ₁ κ₂ r)
    (hz1 : dist z v ≤ 1) : |frameY v α z| ≤ frameX v α z := by
  have hY := abs_frameY_le_of_mem_hornSet h1.le h2.le hz
  have hn1 : ‖z - v‖ ≤ 1 := by rw [← dist_eq_norm]; exact hz1
  have hX := half_norm_le_frameX hn1 hz.2.1 hY
  have : ‖z - v‖ ^ 2 ≤ ‖z - v‖ := by nlinarith [norm_nonneg (z - v)]
  linarith

/-- A non-negative number whose square is below `1` is below `1`. -/
theorem flank_lt_one_aux {d : ℝ} (hd : 0 ≤ d) (h : d ^ 2 < 1) : d < 1 := by nlinarith

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **A pole in the closure of an upper flank's colour is an out-type contact** (N4-FLANK: "in-type `g` at `S′` would be Siamese
with the flank sector"; the tail of `outType_S_of_shadow`). -/
theorem outType_S_of_mem_closure (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₂ : ℝ} {g : Fin k}
    (hκ2 : -1 ≤ κ₂) (hg : F.IsFlankAbove v α κ₂ g) (hScl : v - e (α + π / 2) ∈ closure (F.region g)) :
    F.OutType v g (v - e (α + π / 2)) := by
  have hgv : g ∈ F.coloursAt v := mem_closure_of_mem_coneAt hg.mem_coneAt
  have hSv : dist (v - e (α + π / 2)) v = 1 := by rw [dist_eq_norm, sub_sub_cancel_left, norm_neg, norm_e]
  have hSdom : v - e (α + π / 2) ∈ F.dom := hv (by rw [mem_closedBall, hSv])
  have hcont : F.IsContact v g (v - e (α + π / 2)) := ⟨hgv, hSv, hScl⟩
  rcases (contact_inType_or_outType hF hv hcont).1 with hin | hout
  · exfalso
    obtain ⟨T, hT, hST⟩ := (F.mem_coloursAt_iff_exists_tileOf hSdom).mp hScl
    obtain ⟨t, ht⟩ := hT.1.nonempty
    have htv : dist t v < 1 := hin T hT hST ht
    obtain ⟨κ', hκ', hev⟩ := hg
    obtain ⟨p, hpg, hp⟩ := exists_mem_hornSet_near hκ' hev (show 0 < 1 - dist t v by linarith)
    have hpS : 1 < dist p (v - e (α + π / 2)) := by
      rw [← tanAbove_neg_one_iff]
      exact lt_of_lt_of_le hp.2.2.1 (tanHeight_anti hκ2 _ _)
    have hpt : dist p t < 1 := by
      have := dist_triangle p v t
      rw [dist_comm v t] at this
      linarith [hp.1]
    obtain ⟨hAp, hpA⟩ := tileOf_component hpg
    exact false_of_pole hF hT hAp hST ht hpA hpS hpt
  · exact hout

/-- A chart sector at `P` of colour `g` lies in a `g`-tile whose closure holds `P`. -/
theorem IsSectorChart.sector_subset_tile {n : ℕ} {G : BranchGerms n} {P : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G P r₀)
    {r : ℝ} (hr : r ∈ Ioc 0 r₀) {i : Fin n} {g : Fin k} (hi : G.sector P r i ⊆ F.region g) {y : ℂ}
    (hy : y ∈ G.sector P r i) :
    F.TileOf g (connectedComponentIn F.interiorPts y) ∧ G.sector P r i ⊆ connectedComponentIn F.interiorPts y ∧
      P ∈ closure (connectedComponentIn F.interiorPts y) := by
  have hn : 0 < n := i.pos
  have hsub : G.sector P r i ⊆ connectedComponentIn F.interiorPts y :=
    (hC.isPreconnected r hr i).subset_connectedComponentIn hy (hC.sector_subset_interiorPts hn hr i)
  exact ⟨(tileOf_component (hi hy)).1, hsub, closure_mono hsub (hC.mem_closure_sector hr i)⟩

/-- **An out-type colour's sectors at `S′` look down** (N4-FLANK, the shape of an out-type tile at `S′`): every direction of
such a sector's cone has `sin(φ − α) ≤ 0`; so its two germs' directions lie in one lift `[α + 2πm − π, α + 2πm]`. -/
theorem IsSectorChart.exists_lift_lower {n : ℕ} {G : BranchGerms n} {r₀ : ℝ} {v : ℂ} {α : ℝ} {g : Fin k}
    (hC : F.IsSectorChart G (v - e (α + π / 2)) r₀) (i : Fin n)
    (hi : G.sector (v - e (α + π / 2)) r₀ i ⊆ F.region g) (hout : F.OutType v g (v - e (α + π / 2))) :
    ∃ m : ℤ, α + 2 * π * m - π ≤ G.β i ∧ G.nextβ i ≤ α + 2 * π * m := by
  have hπ := Real.pi_pos
  set P := v - e (α + π / 2) with hPdef
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  have hA : ∀ φ ∈ Icc (G.β i) (G.nextβ i), Real.sin (φ - α) ≤ 0 := by
    intro φ hφ
    by_contra hpos
    push Not at hpos
    have hcone : φ ∈ coneAt (G.sector P r₀ i) P := by
      rw [hC.cone r₀ hr₀ i]; exact Icc_subset_angleIcc _ _ hφ
    set c₀ := Real.sin (φ - α) / 2 with hc₀
    have hc₀pos : 0 < c₀ := by positivity
    obtain ⟨p, hp, hpP, hpd, hpdir⟩ := hcone c₀ hc₀pos
    set s := ‖p - P‖ with hs
    have hs0 : 0 < s := norm_pos_iff.mpr (sub_ne_zero.mpr hpP)
    have hsd : s < c₀ := by rw [hs, ← dist_eq_norm]; exact hpd
    -- the height of `p` above `S′`
    have hY : s * c₀ < frameY P α p := by
      have hsC : (s : ℂ) ≠ 0 := by exact_mod_cast hs0.ne'
      have hu : (p - P) = (s : ℂ) * ((p - P) / (s : ℂ)) := by
        field_simp
      have h1 : frameY P α p = s * ((p - P) / (s : ℂ) * starRingEnd ℂ (e α)).im := by
        unfold frameY
        conv_lhs => rw [hu]
        rw [mul_assoc, Complex.im_ofReal_mul]
      have h2 : (e φ * starRingEnd ℂ (e α)).im = Real.sin (φ - α) := by
        rw [conj_e, ← e_add, im_e, sub_eq_add_neg]
      have h3 : |((p - P) / (s : ℂ) * starRingEnd ℂ (e α)).im - (e φ * starRingEnd ℂ (e α)).im| < c₀ := by
        rw [← Complex.sub_im, ← sub_mul]
        refine lt_of_le_of_lt (Complex.abs_im_le_norm _) ?_
        rw [norm_mul, RCLike.norm_conj, norm_e, mul_one]
        exact hpdir
      rw [h2] at h3
      have h4 := (abs_lt.mp h3).1
      rw [h1]
      have : c₀ < ((p - P) / (s : ℂ) * starRingEnd ℂ (e α)).im := by linarith
      exact mul_lt_mul_of_pos_left this hs0
    have hpv : dist p v < 1 := by
      have hN : P + e (α + π / 2) = v := by rw [hPdef]; ring
      have h := sq_dist_N P α p
      rw [hN] at h
      have hn := frame_normSq P α p
      rw [← hs] at hn
      have : dist p v ^ 2 < 1 := by nlinarith
      nlinarith [dist_nonneg (x := p) (y := v)]
    obtain ⟨hT, -, hPT⟩ := hC.sector_subset_tile hr₀ hi hp
    exact (hout _ hT hPT).ne_of_mem (mem_connectedComponentIn (hC.sector_subset_interiorPts i.pos hr₀ i hp))
      (mem_closedBall.mpr hpv.le) rfl
  have hmono := hC.sorted.mono i
  set m : ℤ := ⌈(G.nextβ i - α) / (2 * π)⌉ with hm
  have hm1 : (G.nextβ i - α) / (2 * π) ≤ m := Int.le_ceil _
  have hm2 : (m : ℝ) < (G.nextβ i - α) / (2 * π) + 1 := Int.ceil_lt_add_one _
  have hup : G.nextβ i ≤ α + 2 * π * m := by
    rw [div_le_iff₀ (by positivity)] at hm1; linarith
  have hlow : α + 2 * π * m - 2 * π < G.nextβ i := by
    have := (lt_div_iff₀ (by positivity : (0 : ℝ) < 2 * π)).mp (by linarith : (m : ℝ) - 1 < (G.nextβ i - α) / (2 * π))
    linarith
  have hsinpos : ∀ φ, α + 2 * π * m - 2 * π < φ → φ < α + 2 * π * m - π → 0 < Real.sin (φ - α) := by
    intro φ h1 h2
    have : Real.sin (φ - α) = Real.sin ((φ - α - 2 * π * m) + 2 * π) := by
      rw [Real.sin_add_two_pi]
      have := Real.sin_sub_int_mul_two_pi (φ - α) m
      rw [← this]; congr 1; ring
    rw [this]
    exact Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
  refine ⟨m, ?_, hup⟩
  have hβ' : α + 2 * π * m - π ≤ G.nextβ i := by
    by_contra hlt; push Not at hlt
    exact absurd (hA _ ⟨hmono, le_rfl⟩) (not_le.mpr (hsinpos _ hlow hlt))
  by_contra hlt; push Not at hlt
  set φ := max (G.β i) (α + 2 * π * m - 3 * π / 2) with hφ
  have hφ1 : G.β i ≤ φ := le_max_left _ _
  have hφ2 : φ ≤ G.nextβ i := max_le hmono (by linarith)
  have hφ3 : α + 2 * π * m - 2 * π < φ := lt_of_lt_of_le (by linarith) (le_max_right _ _)
  have hφ4 : φ < α + 2 * π * m - π := max_lt hlt (by linarith)
  exact absurd (hA φ ⟨hφ1, hφ2⟩) (not_le.mpr (hsinpos φ hφ3 hφ4))

/-- **A sector point on the `+a` side, below its upper germ, in frame coordinates**: if the sector's lower germ looks no lower than
`α + 2πm − π` and its upper germ at the point's distance looks no higher than `α + 2πm + arcsin t`, then `y_P < ‖y − P‖ t`. -/
theorem _root_.HadwigerNelson.Plane.BranchGerms.frameY_lt_of_mem {n : ℕ} {G : BranchGerms n} {P : ℂ} {r : ℝ} {i : Fin n} {α : ℝ} {m : ℤ} (hlo : α + 2 * π * m - π ≤ G.β i) {y : ℂ}
    (hy : y ∈ G.sector P r i) (hX : 0 < frameX P α y) {t : ℝ} (ht : t ∈ Icc (-1 : ℝ) 1)
    (hup : G.nextDir i ‖y - P‖ ≤ α + 2 * π * m + Real.arcsin t) : frameY P α y < ‖y - P‖ * t := by
  have hπ := Real.pi_pos
  obtain ⟨hs, φ, hφ, hyφ⟩ := (BranchGerms.mem_sector_iff (G := G)).mp hy
  set s := ‖y - P‖ with hsdef
  obtain ⟨hXφ, hYφ⟩ := frame_polar P α s φ
  rw [← hyφ] at hXφ hYφ
  have hcos : 0 < Real.cos (φ - α) := by
    rw [hXφ] at hX; exact pos_of_mul_pos_right hX hs.1.le
  have hper : ∀ f : ℝ → ℝ, (∀ x, f (x - (m : ℝ) * (2 * π)) = f x) → f (φ - α) = f (φ - α - 2 * π * m) := by
    intro f hf; rw [← hf (φ - α)]; congr 1; ring
  have hcos' : 0 < Real.cos (φ - α - 2 * π * m) := by
    rw [← hper Real.cos (fun x => Real.cos_sub_int_mul_two_pi x m)]; exact hcos
  have hdir : G.dir i s = G.β i + Real.arcsin (G.κ i * s / 2) := rfl
  have hlo' : -(3 * π / 2) < φ - α - 2 * π * m := by
    have := Real.neg_pi_div_two_le_arcsin (G.κ i * s / 2)
    have := hφ.1; rw [hdir] at this; linarith
  have hhi' : φ - α - 2 * π * m < Real.arcsin t := by linarith [hφ.2]
  have hsin := sin_lt_of_cos_pos ht hlo' hhi' hcos'
  rw [← hper Real.sin (fun x => Real.sin_sub_int_mul_two_pi x m)] at hsin
  rw [hYφ]
  exact mul_lt_mul_of_pos_left hsin hs.1

/-- **The thin horn below a germ lies in the sector before it** (the sector-level form of `exists_flank_before`). -/
theorem IsSectorChart.exists_horn_before {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    {p : Fin n} {α κ : ℝ} (hβ : e (G.nextβ p) = e α) (hκ : G.nextκ p = κ) :
    ∃ κ', κ' < κ ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), r ∈ Ioc 0 r₀ ∧ hornSet v α κ' κ r ⊆ G.sector v r p := by
  obtain ⟨m, hm⟩ := e_eq_e_iff.mp hβ
  have hcp : ∀ r ∈ Ioc 0 r₀, |κ| * r ≤ 2 := fun r hr => by
    rw [← hκ]; exact (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv_next p).le
  rcases hC.sorted.2 p with hlt | ⟨heq, hκ'⟩
  · have hd : 0 < G.nextβ p - G.β p := sub_pos.mpr hlt
    obtain ⟨η, hη, hηa⟩ := exists_abs_arcsin_lt (half_pos hd)
    have hr₁ : 0 < min r₀ (min (1 / (|κ - 1| + 1)) (min (η / (|κ - 1| + 1)) (η / (|G.κ p| + 1)))) := by
      have := hC.pos; positivity
    refine ⟨κ - 1, by linarith, ?_⟩
    filter_upwards [Ioo_mem_nhdsGT hr₁] with r hr
    have hrr₀ : r ∈ Ioc 0 r₀ := ⟨hr.1, hr.2.le.trans (min_le_left _ _)⟩
    refine ⟨hrr₀, ?_⟩
    have hr2 : r < min (1 / (|κ - 1| + 1)) (min (η / (|κ - 1| + 1)) (η / (|G.κ p| + 1))) :=
      lt_of_lt_of_le hr.2 (min_le_right _ _)
    have h1 : |κ - 1| * r ≤ 2 := by
      have := abs_half_lt one_pos hr.1 (lt_of_lt_of_le hr2 (min_le_left _ _))
      rw [abs_div, abs_mul, abs_of_pos hr.1, abs_two] at this; linarith
    intro z hz
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
  · refine ⟨G.κ p, hκ ▸ hκ', ?_⟩
    filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
    refine ⟨hr, ?_⟩
    have h1 : |G.κ p| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv p).le
    have h2 : |G.nextκ p| * r ≤ 2 := by rw [hκ]; exact hcp r hr
    have hβ' : e (G.β p) = e α := by rw [heq]; exact hβ
    have hsec : G.sector v r p = hornSet v α (G.κ p) κ r := by
      show sectorBetween v (G.β p) (G.κ p) (G.nextβ p) (G.nextκ p) r = _
      rw [← heq, sectorBetween_eq_hornSet v _ _ _ r h1 h2, hornSet_congr hβ', hκ]
    rw [← hsec]

/-- **A point near a pole's sector at distance below `1`, the pole beyond `1`: a shadow** (the intermediate value theorem on the
connected sector, which reaches the pole). -/
theorem IsSectorChart.mem_shadow_of_mem {n : ℕ} {G : BranchGerms n} {P : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G P r₀)
    {i : Fin n} {g : Fin k} (hi : G.sector P r₀ i ⊆ F.region g) {z p : ℂ} (hp : p ∈ G.sector P r₀ i)
    (hzp : dist z p < 1) (hzP : 1 < dist z P) : z ∈ shadow (F.region g) := by
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  obtain ⟨q, hq, hqP⟩ := Metric.mem_closure_iff.mp (hC.mem_closure_sector hr₀ i) (dist z P - 1) (by linarith)
  have hzq : 1 < dist z q := by
    have := dist_triangle z q P
    rw [dist_comm q P] at this; linarith
  have hcont : ContinuousOn (fun y => dist z y) (G.sector P r₀ i) := (continuous_const.dist continuous_id).continuousOn
  obtain ⟨y, hy, hyd⟩ := (hC.isPreconnected r₀ hr₀ i).intermediate_value hp hq hcont ⟨hzp.le, hzq.le⟩
  exact ⟨y, hi hy, hyd⟩

/-- The branch of the germ after a sector lies on the arcs: none of its points is interior. -/
theorem IsSectorChart.branchPt_next_not_mem {n : ℕ} {G : BranchGerms n} {P : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G P r₀)
    (i : Fin n) {s : ℝ} (hs : s ∈ Ioo 0 r₀) : branchPt P (G.nextβ i) (G.nextκ i) s ∉ F.interiorPts := by
  have hmem : branchPt P (G.nextβ i) (G.nextκ i) s ∈ (F.Γ ∩ ball P r₀) \ {P} := by
    rw [hC.branches]
    refine mem_iUnion.mpr ⟨BranchGerms.next i, ⟨s, hs, ?_⟩⟩
    simp only [branchPt_eq]
    rw [show germDir (G.nextβ i) (G.nextκ i) s = G.nextDir i s from rfl, BranchGerms.e_nextDir]
    rfl
  exact fun hI => hI.2 hmem.1.1.2

/-- **The shadow near `v` of one `g`-sector at `S′`** (N4-FLANK, per sector): a sector of an upper flank's colour at `S′` is
tangent to `+a` from below, with upper curvature `υ < 1`, and then its points on the `+a` side shadow near `v` only points below
the concentric circle of curvature `f̃(υ)` (N4-SHADOW); or it is not, and then they shadow no point near `v` above the arc `κ₁`
(its directions stay below `+a`, so it lies below a line of very negative curvature). -/
theorem sector_shadow_S (hF : F.Valid) (h5 : F.Condition5) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {g : Fin k}
    (h1 : -1 < κ₁) (h12 : κ₁ < κ₂) (hg : F.IsFlankAbove v α κ₂ g)
    {n : ℕ} {G : BranchGerms n} {r₀ : ℝ} (hC : F.IsSectorChart G (v - e (α + π / 2)) r₀) (i : Fin n)
    (hi : ∀ r ∈ Ioc 0 r₀, G.sector (v - e (α + π / 2)) r i ⊆ F.region g) :
    ∃ σ, (σ = κ₁ ∨ (σ = curvUp (G.nextκ i) ∧ G.nextκ i < 1 ∧ ∃ m : ℤ, G.nextβ i = α + 2 * π * m)) ∧
      ∀ᶠ δ in 𝓝[>] (0 : ℝ), ∀ᶠ z in 𝓝 v, 0 < frameX v α z → TanAbove v α κ₁ z →
        ∀ y ∈ G.sector (v - e (α + π / 2)) δ i, 0 < frameX v α y → dist z y = 1 → TanBelow v α σ z := by
  have hπ := Real.pi_pos
  set P := v - e (α + π / 2) with hPdef
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  have hPv : P + e (α + π / 2) = v := by rw [hPdef]; ring
  have hScl : P ∈ closure (F.region g) := closure_mono (hi r₀ hr₀) (hC.mem_closure_sector hr₀ i)
  have hout := outType_S_of_mem_closure hF hv (by linarith) hg hScl
  obtain ⟨m, hlo, hup⟩ := hC.exists_lift_lower i (hi r₀ hr₀) hout
  -- a sector point on the `+a` side, in the frame at `S′`
  have hnorm : ∀ y, frameX P α y ^ 2 + frameY P α y ^ 2 = ‖y - P‖ ^ 2 := fun y => frame_normSq P α y
  by_cases ht : G.nextβ i = α + 2 * π * m
  · -- tangent: the upper curvature is below `1`
    set υ := G.nextκ i with hυdef
    have heα : e (G.nextβ i) = e α := by rw [ht, e_add_int_mul]
    have hυ1 : υ < 1 := by
      obtain ⟨κ'', hκ'', hev⟩ := hC.exists_horn_before heα rfl
      obtain ⟨r₁, ⟨hr₁mem, hr₁sub⟩, hr₁pos⟩ := (hev.and self_mem_nhdsWithin).exists
      rcases lt_trichotomy υ 1 with hlt | heq | hgt
      · exact hlt
      · -- `υ = 1`: the germ lies on `ω(v)`, against Condition 5
        exfalso
        have hPdom : P ∈ F.dom := hC.subdom (mem_ball_self hC.pos)
        obtain ⟨ε, hε, hεd, hfin⟩ := F.exists_ball_finite hPdom
        have hr : 0 < min (min r₀ ε) 1 := lt_min (lt_min hC.pos hε) one_pos
        refine false_of_branch_on_sphere h5 (κ := 1) (β := α) (q := v) hr ((min_le_left _ _).trans (min_le_right _ _))
          hεd hfin (fun s hs => ?_) (fun s hs => ?_)
        · have hb : branchPt P α 1 s = branchPt P (G.nextβ i) (G.nextκ i) s := by
            simp only [branchPt]; rw [ht, ← heq, show α + 2 * π * m + Real.arcsin (υ * s / 2) =
              (α + Real.arcsin (υ * s / 2)) + 2 * π * m by ring, e_add_int_mul]
          rw [hb]
          exact hC.branchPt_next_not_mem i ⟨hs.1, hs.2.trans_le ((min_le_left _ _).trans (min_le_left _ _))⟩
        · rw [mem_sphere, ← hPv]
          exact dist_branchPt_one P α hs.1.le (by linarith [hs.2, min_le_right (min r₀ ε) 1])
      · -- `υ > 1`: points just below the germ lie inside `B(v, 1)`, against out-type
        exfalso
        set m' := (max κ'' 1 + υ) / 2 with hm'
        have hm'1 : max κ'' 1 < m' := by rw [hm']; linarith [max_lt hκ'' hgt]
        have hm'2 : m' < υ := by rw [hm']; linarith [max_lt hκ'' hgt]
        obtain ⟨s, hs0, hsr, hsm⟩ := exists_small_s m' hr₁pos
        have hq := branchPt_mem_hornSet P α (κ₁ := κ'') (κ₂ := υ) (lt_of_le_of_lt (le_max_left _ _) hm'1) hm'2 hs0 hsr hsm
        have hqs := hr₁sub hq
        have hqv : dist (branchPt P α m' s) v < 1 := by
          rw [← hPv, ← tanAbove_one_iff]
          show 0 < tanHeight _ _ _
          rw [tanHeight_branchPt P α m' 1 hsm.le hs0.le]
          have : 1 < m' := lt_of_le_of_lt (le_max_right _ _) hm'1
          have := mul_pos (pow_pos hs0 2) (sub_pos.mpr this)
          linarith
        obtain ⟨hT, -, hPT⟩ := hC.sector_subset_tile hr₁mem (hi r₁ hr₁mem) hqs
        exact (hout _ hT hPT).ne_of_mem (mem_connectedComponentIn (hC.sector_subset_interiorPts i.pos hr₁mem i hqs))
          (mem_closedBall.mpr hqv.le) rfl
    refine ⟨curvUp υ, Or.inr ⟨rfl, hυ1, m, ht⟩, ?_⟩
    filter_upwards [Ioc_mem_nhdsGT hC.pos] with δ hδ
    obtain ⟨ε, hε, H⟩ := shadow_farSide_below v α hυ1 hδ.1
    refine Metric.eventually_nhds_iff.mpr ⟨ε, hε, fun z hz hX _ y hy hyX hzy => ?_⟩
    have hyb : TanBelow P α υ y := by
      have hs := ((BranchGerms.mem_sector_iff (G := G)).mp hy).1
      have hcurv : |υ| * ‖y - P‖ < 2 := lt_of_le_of_lt (mul_le_mul_of_nonneg_left (hs.2.le.trans hδ.2) (abs_nonneg _))
        (hC.curv_next i)
      have ht' : υ * ‖y - P‖ / 2 ∈ Icc (-1 : ℝ) 1 := half_curv_mem_Icc hcurv.le (norm_nonneg _) le_rfl
      have hlt := BranchGerms.frameY_lt_of_mem hlo hy (by rw [frameX_base_S]; exact hyX) ht'
        (by show G.nextβ i + Real.arcsin (G.nextκ i * ‖y - P‖ / 2) ≤ _; rw [ht])
      show tanHeight υ _ _ < 0
      unfold tanHeight
      rw [hnorm y]
      have : ‖y - P‖ * (υ * ‖y - P‖ / 2) = υ * ‖y - P‖ ^ 2 / 2 := by ring
      linarith
    have hyP : dist y P < δ := by
      rw [dist_eq_norm]; exact ((BranchGerms.mem_sector_iff (G := G)).mp hy).1.2
    exact (H z hz hX).mp ⟨y, ⟨hyP, by rw [frameX_base_S]; exact hyX, hyb⟩, hzy⟩
  · -- not tangent: the sector's directions stay a margin `θ` below `+a`
    have hθ : 0 < α + 2 * π * m - G.nextβ i := sub_pos.mpr (lt_of_le_of_ne hup ht)
    set θ := α + 2 * π * m - G.nextβ i with hθdef
    have hθπ : θ ≤ π := by have := hC.sorted.mono i; linarith
    set K := 1 / (1 + κ₁) with hK
    have hKpos : 0 < K := by rw [hK]; exact div_pos one_pos (by linarith)
    have hKc : curvUp (-K) ≤ κ₁ := by
      have hc : curvUp (-K) = -1 / (2 + κ₁) := by
        have h1' : 1 + κ₁ ≠ 0 := by linarith
        have h2' : 2 + κ₁ ≠ 0 := by linarith
        have h3' : 1 - -(1 / (1 + κ₁)) ≠ 0 := by
          rw [sub_neg_eq_add]; have : 0 < 1 / (1 + κ₁) := div_pos one_pos (by linarith); linarith
        rw [curvUp, hK, div_eq_div_iff h3' h2']; field_simp; ring
      rw [hc, div_le_iff₀ (by linarith)]; nlinarith [sq_nonneg (κ₁ + 1)]
    have hsθ : 0 < Real.sin (θ / 2) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
    obtain ⟨η, hη, hηa⟩ := exists_abs_arcsin_lt (half_pos hθ)
    have hδ₁ : 0 < min r₀ (min (η / (|G.nextκ i| + 1)) (2 * Real.sin (θ / 2) / K)) := by
      have := hC.pos; positivity
    refine ⟨κ₁, Or.inl rfl, ?_⟩
    filter_upwards [Ioo_mem_nhdsGT hδ₁] with δ hδ
    obtain ⟨ε, hε, H⟩ := shadow_farSide_below v α (υ := -K) (by linarith) hδ.1
    refine Metric.eventually_nhds_iff.mpr ⟨ε, hε, fun z hz hX hA y hy hyX hzy => ?_⟩
    exfalso
    have hs := ((BranchGerms.mem_sector_iff (G := G)).mp hy).1
    set s := ‖y - P‖ with hsdef
    have hsδ : s < min (η / (|G.nextκ i| + 1)) (2 * Real.sin (θ / 2) / K) :=
      lt_trans hs.2 (lt_of_lt_of_le hδ.2 (min_le_right _ _))
    have ha := hηa _ (abs_half_lt hη hs.1 (lt_of_lt_of_le hsδ (min_le_left _ _)))
    have hsin : Real.sin (-(θ / 2)) ∈ Icc (-1 : ℝ) 1 := ⟨Real.neg_one_le_sin _, Real.sin_le_one _⟩
    have harc : Real.arcsin (Real.sin (-(θ / 2))) = -(θ / 2) := Real.arcsin_sin (by linarith) (by linarith)
    have hlt := BranchGerms.frameY_lt_of_mem hlo hy (by rw [frameX_base_S]; exact hyX) hsin
      (by show G.nextβ i + Real.arcsin (G.nextκ i * s / 2) ≤ _; rw [harc]; linarith [(abs_lt.mp ha).2])
    rw [Real.sin_neg] at hlt
    have hyb : TanBelow P α (-K) y := by
      show tanHeight (-K) _ _ < 0
      unfold tanHeight
      rw [hnorm y]
      have h2 : s * K < 2 * Real.sin (θ / 2) := by
        have := (lt_div_iff₀ hKpos).mp (lt_of_lt_of_le hsδ (min_le_right _ _)); linarith
      have h3 := mul_pos hs.1 (show 0 < 2 * Real.sin (θ / 2) - s * K by linarith)
      have : ‖y - P‖ ^ 2 = s * s := by rw [hsdef]; ring
      rw [this]
      linarith
    have hyP : dist y P < δ := by rw [dist_eq_norm]; exact hs.2
    have hzb := (H z hz hX).mp ⟨y, ⟨hyP, by rw [frameX_base_S]; exact hyX, hyb⟩, hzy⟩
    exact absurd (lt_of_lt_of_le hA (tanHeight_anti hKc _ _)) (not_lt.mpr hzb.le)

/-- **The converse, one tangent sector** (N4-SHADOW's "the nearest point lies on `A`"): a `g`-sector at `S′` tangent to `+a` from
below with upper curvature `υ < 1` shadows every point near `v` on the `+a` side, outside `B̄(S′, 1)`, below the concentric circle
of curvature `f̃(υ)` — not only the horn's. -/
theorem shadow_of_tangent_sector_S {v : ℂ} {α : ℝ} {g : Fin k} {n : ℕ} {G : BranchGerms n} {r₀ : ℝ}
    (hC : F.IsSectorChart G (v - e (α + π / 2)) r₀) (i : Fin n)
    (hi : G.sector (v - e (α + π / 2)) r₀ i ⊆ F.region g) {m : ℤ} (hm : G.nextβ i = α + 2 * π * m)
    (hυ : G.nextκ i < 1) :
    ∀ᶠ z in 𝓝 v, 0 < frameX v α z → TanAbove v α (-1) z → TanBelow v α (curvUp (G.nextκ i)) z →
      z ∈ shadow (F.region g) := by
  set P := v - e (α + π / 2) with hPdef
  set υ := G.nextκ i with hυdef
  have heα : e (G.nextβ i) = e α := by rw [hm, e_add_int_mul]
  obtain ⟨κ'', hκ'', hev⟩ := hC.exists_horn_before heα rfl
  obtain ⟨r₁, ⟨hr₁mem, hr₁sub⟩, hr₁pos⟩ := (hev.and self_mem_nhdsWithin).exists
  have hr₁pos' : (0 : ℝ) < r₁ := hr₁pos
  set δ' := min r₁ (1 / (|υ| + 1)) with hδ'
  have hδ'pos : 0 < δ' := lt_min hr₁pos' (by positivity)
  obtain ⟨ε, hε, H⟩ := shadow_farSide_below v α hυ hδ'pos
  refine Metric.eventually_nhds_iff.mpr ⟨min ε (1 / 16), lt_min hε (by norm_num), fun z hz hX hA hB => ?_⟩
  have hzε : dist z v < ε := lt_of_lt_of_le hz (min_le_left _ _)
  have hz16 : dist z v < 1 / 16 := lt_of_lt_of_le hz (min_le_right _ _)
  obtain ⟨y₀, ⟨hy₀d, hy₀X, hy₀B⟩, hzy₀⟩ := (H z hzε hX).mpr hB
  set s₀ := ‖y₀ - P‖ with hs₀
  have hs₀pos : 0 < s₀ := norm_pos_of_frameX_pos hy₀X
  have hs₀δ : s₀ < δ' := by rw [hs₀, ← dist_eq_norm]; exact hy₀d
  have hs₀r : s₀ < r₁ := lt_of_lt_of_le hs₀δ (min_le_left _ _)
  have hυs : (|υ| + 1) * s₀ < 1 := by
    have := lt_of_lt_of_le hs₀δ (min_le_right _ _)
    rwa [lt_div_iff₀ (by positivity), mul_comm] at this
  have hυs1 : |υ| * s₀ ≤ 1 := by
    have := mul_le_mul_of_nonneg_right (by linarith : |υ| ≤ |υ| + 1) hs₀pos.le; linarith
  have hυs2 : |υ| * s₀ < 2 := by linarith
  -- the point of the germ at the same distance from `S′`, nearer to `z`
  set q₀ := branchPt P α υ s₀ with hq₀
  have hX₁ : 0 < frameX P α q₀ := frameX_branchPt_pos P α υ hυs2 hs₀pos
  have hY₁ : frameY P α q₀ = υ * s₀ ^ 2 / 2 := by
    have := tanHeight_branchPt P α υ 0 hυs2.le hs₀pos.le
    unfold tanHeight at this; linarith
  have hsq₁ : frameX P α q₀ ^ 2 + frameY P α q₀ ^ 2 = s₀ ^ 2 := by
    rw [frame_normSq, norm_branchPt_sub P α υ hs₀pos.le]
  have hsq₀ : frameX P α y₀ ^ 2 + frameY P α y₀ ^ 2 = s₀ ^ 2 := frame_normSq P α y₀
  have hY₀₁ : frameY P α y₀ < frameY P α q₀ := by
    have : tanHeight υ (frameX P α y₀) (frameY P α y₀) < 0 := hy₀B
    unfold tanHeight at this; rw [hsq₀] at this; rw [hY₁]; linarith
  have hb : |frameY P α y₀ + frameY P α q₀| ≤ 4 * frameX P α q₀ := by
    have hY0 : |frameY P α y₀| ≤ s₀ := by
      rw [hs₀]; exact abs_frameY_le_norm P α y₀
    have hY1 : |frameY P α q₀| ≤ s₀ / 2 := by
      rw [hY₁, abs_div, abs_mul, abs_two, abs_of_nonneg (sq_nonneg s₀)]
      have : |υ| * s₀ ^ 2 = (|υ| * s₀) * s₀ := by ring
      rw [this]
      have := mul_le_of_le_one_left hs₀pos.le hυs1
      linarith
    have hX1 : s₀ / 2 ≤ frameX P α q₀ := by
      exact flank_half_le_aux hX₁ hsq₁ hY1
    calc |frameY P α y₀ + frameY P α q₀| ≤ |frameY P α y₀| + |frameY P α q₀| := abs_add_le _ _
      _ ≤ 4 * frameX P α q₀ := by linarith
  have hxz : frameX P α z < 1 / 8 := by
    have := abs_frameX_sub_le v α z v
    rw [frameX_self, sub_zero] at this
    rw [frameX_base_S]; linarith [le_abs_self (frameX v α z)]
  have hwz : 1 / 2 ≤ frameY P α z := by
    have := abs_frameY_le_norm v α z
    rw [← dist_eq_norm] at this
    rw [frameY_base_S]; linarith [neg_abs_le (frameY v α z)]
  have hq₀z : dist z q₀ < 1 := by
    have h1 := sq_dist_frame P α z q₀
    have h0 := sq_dist_frame P α z y₀
    rw [hzy₀] at h0
    have hx0 : 0 ≤ frameX P α z := by rw [frameX_base_S]; exact hX.le
    have := flank_higher_aux (x := frameX P α z) (w := frameY P α z) (X₀ := frameX P α y₀) (Y₀ := frameY P α y₀)
      (X₁ := frameX P α q₀) (Y₁ := frameY P α q₀) hy₀X hX₁ (hsq₀.trans hsq₁.symm) hY₀₁ hb hx0 hxz hwz
    exact flank_lt_one_aux dist_nonneg (by linarith)
  -- a nearby point of the thin horn below the germ, in the sector
  have hcont : Continuous fun μ : ℝ => dist z (branchPt P α μ s₀) :=
    continuous_const.dist (continuous_branchPt_curv P α s₀)
  have hev1 : ∀ᶠ μ in 𝓝 υ, dist z (branchPt P α μ s₀) < 1 :=
    hcont.continuousAt.eventually_lt continuousAt_const hq₀z
  obtain ⟨μ, hμ1, hμ2⟩ := ((hev1.filter_mono nhdsWithin_le_nhds).and
    (Ioo_mem_nhdsLT (max_lt hκ'' (by linarith : υ - 1 < υ)))).exists
  have hμs : |μ| * s₀ < 2 := by
    have : |μ| ≤ |υ| + 1 := by
      rw [abs_le]; constructor
      · linarith [neg_abs_le υ, le_max_right κ'' (υ - 1), hμ2.1]
      · linarith [le_abs_self υ, hμ2.2]
    have := mul_le_mul_of_nonneg_right this hs₀pos.le
    linarith
  have hqh := branchPt_mem_hornSet P α (κ₁ := κ'') (κ₂ := υ) (lt_of_le_of_lt (le_max_left _ _) hμ2.1) hμ2.2
    hs₀pos hs₀r hμs
  have hqs := G.sector_mono hr₁mem.2 i (hr₁sub hqh)
  exact hC.mem_shadow_of_mem hi hqs hμ1 (by rw [← tanAbove_neg_one_iff]; exact hA)

/-- **N4-FLANK, the upper flank's half**: with an upper flank `g` above a horn along `a` with curvatures in `(−1, 1)`, the horn's
points near `v` in the shadow of `g`'s class are exactly those below a tangent circle of curvature `σ_g ∈ [κ₁, κ₂]` — the largest
`f̃(υ)` over the `g`-sectors at `S′` tangent to `+a` from below (`σ_g = κ₁` when there is none). -/
theorem flank_shadow_g (hF : F.Valid) (h5 : F.Condition5) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {g : Fin k}
    (h1 : -1 < κ₁) (h12 : κ₁ < κ₂) (h2 : κ₂ < 1) (hg : F.IsFlankAbove v α κ₂ g) :
    ∃ σg, κ₁ ≤ σg ∧ σg ≤ κ₂ ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₁ κ₂ r,
      (z ∈ shadow (F.region g) ↔ TanBelow v α σg z) := by
  classical
  set P := v - e (α + π / 2) with hPdef
  have hPv : dist P v = 1 := by rw [hPdef, dist_eq_norm, sub_sub_cancel_left, norm_neg, norm_e]
  have hPdom : P ∈ F.dom := hv (by rw [mem_closedBall, hPv])
  have hgv : g ∈ F.coloursAt v := mem_closure_of_mem_coneAt hg.mem_coneAt
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hPdom
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  set J : Fin n → Prop := fun i => ∀ r ∈ Ioc 0 r₀, G.sector P r i ⊆ F.region g with hJ
  have hQ : ∀ i, ∃ σ, (¬ J i → σ = κ₁) ∧ (J i → (σ = κ₁ ∨ (σ = curvUp (G.nextκ i) ∧ G.nextκ i < 1 ∧
      ∃ m : ℤ, G.nextβ i = α + 2 * π * m)) ∧
      ∀ᶠ δ in 𝓝[>] (0 : ℝ), ∀ᶠ z in 𝓝 v, 0 < frameX v α z → TanAbove v α κ₁ z →
        ∀ y ∈ G.sector P δ i, 0 < frameX v α y → dist z y = 1 → TanBelow v α σ z) := by
    intro i
    by_cases hJi : J i
    · obtain ⟨σ, h₁, h₂⟩ := sector_shadow_S hF h5 hv h1 h12 hg hC i hJi
      exact ⟨σ, fun h => absurd hJi h, fun _ => ⟨h₁, h₂⟩⟩
    · exact ⟨κ₁, fun _ => rfl, fun h => absurd h hJi⟩
  choose σ hσ using hQ
  -- every tangent `g`-sector's circle stays below the horn's upper arc (else its shadow would reach the flank)
  have hσκ₂ : ∀ i, σ i ≤ κ₂ := by
    intro i
    by_cases hJi : J i
    · rcases ((hσ i).2 hJi).1 with heq | ⟨heq, hυ, m, hm⟩
      · rw [heq]; exact h12.le
      · rw [heq]
        by_contra hlt
        push Not at hlt
        obtain ⟨ε, hε, hB⟩ := Metric.eventually_nhds_iff.mp (shadow_of_tangent_sector_S hC i (hJi r₀ hr₀) hm hυ)
        obtain ⟨κ', hκ', hev⟩ := hg
        have hev' : ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ₂ (min κ' (curvUp (G.nextκ i))) r ⊆ F.region g := by
          filter_upwards [hev] with r hr
          exact (hornSet_mono le_rfl (min_le_left _ _)).trans hr
        obtain ⟨p, hpg, hp⟩ := exists_mem_hornSet_near (lt_min hκ' hlt) hev' hε
        obtain ⟨y, hy, hpy⟩ := hB hp.1 hp.2.1
          (lt_of_lt_of_le hp.2.2.1 (tanHeight_anti (by linarith) _ _))
          (lt_of_le_of_lt (tanHeight_anti (min_le_right _ _) _ _) hp.2.2.2)
        exact hF p hpg.1 y hy.1 hpy (hpg.2.trans hy.2.symm)
    · rw [(hσ i).1 hJi]; exact h12.le
  set Sset : Finset ℝ := insert κ₁ (Finset.univ.image σ) with hSset
  have hne : Sset.Nonempty := Finset.insert_nonempty _ _
  set σg := Sset.max' hne with hσg
  have hle : ∀ i, σ i ≤ σg := fun i => Finset.le_max' _ _ (Finset.mem_insert_of_mem (Finset.mem_image_of_mem _
    (Finset.mem_univ i)))
  refine ⟨σg, Finset.le_max' _ _ (Finset.mem_insert_self _ _), Finset.max'_le _ _ _ ?_, ?_⟩
  · intro s hs
    rcases Finset.mem_insert.mp hs with rfl | hs
    · exact h12.le
    · obtain ⟨i, -, rfl⟩ := Finset.mem_image.mp hs; exact hσκ₂ i
  -- the radius `δ*` of the sources, and the uniform neighbourhood of `v`
  have hδall : ∀ᶠ δ in 𝓝[>] (0 : ℝ), ∀ i, J i → ∀ᶠ z in 𝓝 v, 0 < frameX v α z → TanAbove v α κ₁ z →
      ∀ y ∈ G.sector P δ i, 0 < frameX v α y → dist z y = 1 → TanBelow v α (σ i) z := by
    refine Filter.eventually_all.mpr fun i => ?_
    by_cases hJi : J i
    · filter_upwards [((hσ i).2 hJi).2] with δ hδ _ using hδ
    · exact Filter.Eventually.of_forall fun δ h => absurd h hJi
  obtain ⟨δ, ⟨hδJ, hδmem⟩, hδpos⟩ := ((hδall.and (Ioc_mem_nhdsGT (lt_min hC.pos one_pos))).and
    self_mem_nhdsWithin).exists
  have hδpos' : (0 : ℝ) < δ := hδpos
  have hδr₀ : δ ∈ Ioc 0 r₀ := ⟨hδpos', hδmem.2.trans (min_le_left _ _)⟩
  have hδ1 : δ ≤ 1 := hδmem.2.trans (min_le_right _ _)
  have hzall : ∀ᶠ z in 𝓝 v, (∀ i, J i → 0 < frameX v α z → TanAbove v α κ₁ z →
      ∀ y ∈ G.sector P δ i, 0 < frameX v α y → dist z y = 1 → TanBelow v α (σ i) z) ∧
      (∀ i, J i → σ i ≠ κ₁ → 0 < frameX v α z → TanAbove v α (-1) z → TanBelow v α (σ i) z →
        z ∈ shadow (F.region g)) := by
    refine (Filter.eventually_all.mpr fun i => ?_).and (Filter.eventually_all.mpr fun i => ?_)
    · by_cases hJi : J i
      · filter_upwards [hδJ i hJi] with z hz _ using hz
      · exact Filter.Eventually.of_forall fun z h => absurd h hJi
    · by_cases hJi : J i
      · rcases ((hσ i).2 hJi).1 with heq | ⟨heq, hυ, m, hm⟩
        · exact Filter.Eventually.of_forall fun z _ h => absurd heq h
        · filter_upwards [shadow_of_tangent_sector_S hC i (hJi r₀ hr₀) hm hυ] with z hz _ _ hX hA hB
          exact hz hX hA (heq ▸ hB)
      · exact Filter.Eventually.of_forall fun z h => absurd h hJi
  obtain ⟨ε, hε, hzε⟩ := Metric.eventually_nhds_iff.mp hzall
  obtain ⟨ρ, hρ, hloc⟩ := horn_shadow_near_S hF hv h1.le h2 hg hδpos'
  filter_upwards [Ioo_mem_nhdsGT (lt_min (lt_min hε hρ) (show (0 : ℝ) < 1 / 4 by norm_num))] with r hr
  intro z hz
  have hzv : dist z v < r := hz.1
  have hzε' : dist z v < ε := lt_of_lt_of_le (hzv.trans hr.2) ((min_le_left _ _).trans (min_le_left _ _))
  have hzρ : z ∈ hornSet v α κ₁ κ₂ ρ :=
    hornSet_mono_radius (hr.2.le.trans ((min_le_left _ _).trans (min_le_right _ _))) hz
  have hz4 : dist z v < 1 / 4 := lt_of_lt_of_le (hzv.trans hr.2) (min_le_right _ _)
  obtain ⟨hzA, hzB⟩ := hzε hzε'
  have hzneg : TanAbove v α (-1) z := lt_of_lt_of_le hz.2.2.1 (tanHeight_anti h1.le _ _)
  constructor
  · rintro ⟨y, hy, hzy⟩
    have hyP : dist y P < δ := hloc z hzρ y hy hzy
    rcases Nat.eq_zero_or_pos n with hn | hn
    · -- no germ at `S′`: the ball is one colour, `g`, and `S′ ∈ ω(v)` would carry it (N-E1)
      exfalso
      have hball := hC.empty hn
      have hyb : y ∈ ball P r₀ := mem_ball.mpr (lt_of_lt_of_le hyP hδr₀.2)
      have hcol : F.col P = F.col y := (convex_ball P r₀).isPreconnected.constant (F.continuousOn_col.mono hball)
        (mem_ball_self hC.pos) hyb
      have hPg : P ∈ F.region g := ⟨hball (mem_ball_self hC.pos), hcol.trans hy.2⟩
      exact ne1_region hF hgv hPg hPv
    · have hyU : y ∈ ⋃ i, G.sector P δ i := by
        rw [← hC.cover δ hδr₀ hn]; exact ⟨mem_ball.mpr hyP, hy.1⟩
      obtain ⟨i, hi⟩ := mem_iUnion.mp hyU
      obtain ⟨g', hg'⟩ := hC.exists_col i
      have hgg : g' = g := ((hg' δ hδr₀ hi).2.symm.trans hy.2)
      have hJi : J i := fun r hr => hgg ▸ hg' r hr
      by_cases hyX : 0 < frameX v α y
      · exact lt_of_le_of_lt (tanHeight_anti (hle i) _ _) (hzA i hJi hz.2.1 hz.2.2.1 y hi hyX hzy)
      · -- a source behind the pole: out of reach (`flank_back_aux`)
        exfalso
        push Not at hyX
        have hout := outType_S_of_mem_closure hF hv (by linarith) hg
          (closure_mono (hJi r₀ hr₀) (hC.mem_closure_sector hr₀ i))
        obtain ⟨hT, -, hPT⟩ := hC.sector_subset_tile hδr₀ (hJi δ hδr₀) hi
        have hyv : 1 < dist y v := by
          by_contra hle'
          push Not at hle'
          exact (hout _ hT hPT).ne_of_mem (mem_connectedComponentIn (hC.sector_subset_interiorPts hn hδr₀ i hi))
            (mem_closedBall.mpr hle') rfl
        have hzX : |frameX v α z| ≤ dist z v := by
          have := abs_frameX_sub_le v α z v; rwa [frameX_self, sub_zero] at this
        have hzY := abs_frameY_of_horn_le h1 h2 hz (by linarith)
        have hw : |frameY P α z - 1| ≤ frameX P α z := by
          rw [frameY_base_S, frameX_base_S, add_sub_cancel_right]; exact hzY
        have hYy : frameY P α y ≤ 1 := by
          have := abs_frameY_le_norm P α y
          rw [← dist_eq_norm] at this
          linarith [le_abs_self (frameY P α y)]
        have hpv : 1 ≤ frameX P α y ^ 2 + (frameY P α y - 1) ^ 2 := by
          rw [frameX_base_S, frameY_base_S, add_sub_cancel_right, frame_normSq, ← dist_eq_norm]
          nlinarith [dist_nonneg (x := y) (y := v)]
        have hzP : 1 < frameX P α z ^ 2 + frameY P α z ^ 2 := by
          rw [frameX_base_S, frameY_base_S, ← sq_dist_S]
          exact one_lt_pow₀ ((tanAbove_neg_one_iff v α z).mp hzneg) two_ne_zero
        have hw0 : 0 ≤ frameY P α z := by
          rw [frameY_base_S]; have := abs_frameY_le_norm v α z; rw [← dist_eq_norm] at this
          linarith [neg_abs_le (frameY v α z)]
        have hX0 : 0 < frameX P α z := by rw [frameX_base_S]; exact hz.2.1
        have := flank_back_aux hX0 hw hw0 hzP (by rw [frameX_base_S]; exact hyX) hYy hpv
        rw [← sq_dist_frame, hzy] at this
        norm_num at this
  · intro hB
    rcases Finset.mem_insert.mp (Finset.max'_mem Sset hne) with heq | hmem
    · rw [← hσg] at heq
      rw [heq] at hB
      exact absurd hz.2.2.1 (not_lt.mpr hB.le)
    · obtain ⟨i, -, hi⟩ := Finset.mem_image.mp hmem
      rw [← hσg] at hi
      rw [← hi] at hB
      by_cases hJi : J i
      · by_cases hκ : σ i = κ₁
        · rw [hκ] at hB; exact absurd hz.2.2.1 (not_lt.mpr hB.le)
        · exact hzB i hJi hκ hz.2.1 hzneg hB
      · rw [(hσ i).1 hJi] at hB; exact absurd hz.2.2.1 (not_lt.mpr hB.le)

/-! ### The lower flank's half (the mirror at `N`) -/

/-- **A pole `N` in the closure of a lower flank's colour is an out-type contact** (the mirror of `outType_S_of_mem_closure`). -/
theorem outType_N_of_mem_closure (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ : ℝ} {h : Fin k}
    (hκ1 : κ₁ ≤ 1) (hh : F.IsFlankBelow v α κ₁ h) (hNcl : v + e (α + π / 2) ∈ closure (F.region h)) :
    F.OutType v h (v + e (α + π / 2)) := by
  have hhv : h ∈ F.coloursAt v := mem_closure_of_mem_coneAt hh.mem_coneAt
  have hNv : dist (v + e (α + π / 2)) v = 1 := by rw [dist_eq_norm, add_sub_cancel_left, norm_e]
  have hNdom : v + e (α + π / 2) ∈ F.dom := hv (by rw [mem_closedBall, hNv])
  have hcont : F.IsContact v h (v + e (α + π / 2)) := ⟨hhv, hNv, hNcl⟩
  rcases (contact_inType_or_outType hF hv hcont).1 with hin | hout
  · exfalso
    obtain ⟨T, hT, hNT⟩ := (F.mem_coloursAt_iff_exists_tileOf hNdom).mp hNcl
    obtain ⟨t, ht⟩ := hT.1.nonempty
    have htv : dist t v < 1 := hin T hT hNT ht
    obtain ⟨κ', hκ', hev⟩ := hh
    obtain ⟨p, hph, hp⟩ := exists_mem_hornSet_near hκ' hev (show 0 < 1 - dist t v by linarith)
    have hpN : 1 < dist p (v + e (α + π / 2)) := by
      rw [← tanBelow_one_iff]
      exact lt_of_le_of_lt (tanHeight_anti hκ1 _ _) hp.2.2.2
    have hpt : dist p t < 1 := by
      have := dist_triangle p v t
      rw [dist_comm v t] at this
      linarith [hp.1]
    obtain ⟨hAp, hpA⟩ := tileOf_component hph
    exact false_of_pole hF hT hAp hNT ht hpA hpN hpt
  · exact hout

/-- **An out-type colour's sectors at `N` look up** (the mirror of `exists_lift_lower`): their germs' directions lie in one lift
`[α + 2πm, α + 2πm + π]`. -/
theorem IsSectorChart.exists_lift_upper {n : ℕ} {G : BranchGerms n} {r₀ : ℝ} {v : ℂ} {α : ℝ} {h : Fin k}
    (hC : F.IsSectorChart G (v + e (α + π / 2)) r₀) (i : Fin n)
    (hi : G.sector (v + e (α + π / 2)) r₀ i ⊆ F.region h) (hout : F.OutType v h (v + e (α + π / 2))) :
    ∃ m : ℤ, α + 2 * π * m ≤ G.β i ∧ G.nextβ i ≤ α + 2 * π * m + π := by
  have hπ := Real.pi_pos
  set P := v + e (α + π / 2) with hPdef
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  have hA : ∀ φ ∈ Icc (G.β i) (G.nextβ i), 0 ≤ Real.sin (φ - α) := by
    intro φ hφ
    by_contra hneg
    push Not at hneg
    have hcone : φ ∈ coneAt (G.sector P r₀ i) P := by
      rw [hC.cone r₀ hr₀ i]; exact Icc_subset_angleIcc _ _ hφ
    set c₀ := -Real.sin (φ - α) / 2 with hc₀
    have hc₀pos : 0 < c₀ := by rw [hc₀]; linarith
    obtain ⟨p, hp, hpP, hpd, hpdir⟩ := hcone c₀ hc₀pos
    set s := ‖p - P‖ with hs
    have hs0 : 0 < s := norm_pos_iff.mpr (sub_ne_zero.mpr hpP)
    have hsd : s < c₀ := by rw [hs, ← dist_eq_norm]; exact hpd
    have hY : frameY P α p < -(s * c₀) := by
      have hsC : (s : ℂ) ≠ 0 := by exact_mod_cast hs0.ne'
      have hu : (p - P) = (s : ℂ) * ((p - P) / (s : ℂ)) := by
        field_simp
      have h1 : frameY P α p = s * ((p - P) / (s : ℂ) * starRingEnd ℂ (e α)).im := by
        unfold frameY
        conv_lhs => rw [hu]
        rw [mul_assoc, Complex.im_ofReal_mul]
      have h2 : (e φ * starRingEnd ℂ (e α)).im = Real.sin (φ - α) := by
        rw [conj_e, ← e_add, im_e, sub_eq_add_neg]
      have h3 : |((p - P) / (s : ℂ) * starRingEnd ℂ (e α)).im - (e φ * starRingEnd ℂ (e α)).im| < c₀ := by
        rw [← Complex.sub_im, ← sub_mul]
        refine lt_of_le_of_lt (Complex.abs_im_le_norm _) ?_
        rw [norm_mul, RCLike.norm_conj, norm_e, mul_one]
        exact hpdir
      rw [h2] at h3
      have h4 := (abs_lt.mp h3).2
      rw [h1]
      have : ((p - P) / (s : ℂ) * starRingEnd ℂ (e α)).im < -c₀ := by linarith
      have := mul_lt_mul_of_pos_left this hs0
      linarith
    have hpv : dist p v < 1 := by
      have hS : P - e (α + π / 2) = v := by rw [hPdef]; ring
      have h := sq_dist_S P α p
      rw [hS] at h
      have hn := frame_normSq P α p
      rw [← hs] at hn
      have : dist p v ^ 2 < 1 := by nlinarith
      exact flank_lt_one_aux dist_nonneg this
    obtain ⟨hT, -, hPT⟩ := hC.sector_subset_tile hr₀ hi hp
    exact (hout _ hT hPT).ne_of_mem (mem_connectedComponentIn (hC.sector_subset_interiorPts i.pos hr₀ i hp))
      (mem_closedBall.mpr hpv.le) rfl
  have hmono := hC.sorted.mono i
  set m : ℤ := ⌊(G.β i - α) / (2 * π)⌋ with hm
  have hm1 : (m : ℝ) ≤ (G.β i - α) / (2 * π) := Int.floor_le _
  have hm2 : (G.β i - α) / (2 * π) < m + 1 := Int.lt_floor_add_one _
  have hlo : α + 2 * π * m ≤ G.β i := by
    rw [le_div_iff₀ (by positivity)] at hm1; linarith
  have hhi : G.β i < α + 2 * π * m + 2 * π := by
    rw [div_lt_iff₀ (by positivity)] at hm2; linarith
  have hsinneg : ∀ φ, α + 2 * π * m + π < φ → φ < α + 2 * π * m + 2 * π → Real.sin (φ - α) < 0 := by
    intro φ h1 h2
    have : Real.sin (φ - α) = Real.sin (φ - α - 2 * π * m) := by
      have := Real.sin_sub_int_mul_two_pi (φ - α) m
      rw [← this]; congr 1; ring
    rw [this]
    have := Real.sin_pos_of_pos_of_lt_pi (x := φ - α - 2 * π * m - π) (by linarith) (by linarith)
    rw [Real.sin_sub_pi] at this; linarith
  refine ⟨m, hlo, ?_⟩
  have hβ' : G.β i ≤ α + 2 * π * m + π := by
    by_contra hlt; push Not at hlt
    exact absurd (hA _ ⟨le_rfl, hmono⟩) (not_le.mpr (hsinneg _ hlt hhi))
  by_contra hlt; push Not at hlt
  set φ := min (G.nextβ i) (α + 2 * π * m + 3 * π / 2) with hφ
  have hφ1 : G.β i ≤ φ := le_min hmono (by linarith)
  have hφ2 : φ ≤ G.nextβ i := min_le_left _ _
  have hφ3 : α + 2 * π * m + π < φ := lt_min hlt (by linarith)
  have hφ4 : φ < α + 2 * π * m + 2 * π := lt_of_le_of_lt (min_le_right _ _) (by linarith)
  exact absurd (hA φ ⟨hφ1, hφ2⟩) (not_le.mpr (hsinneg φ hφ3 hφ4))

/-- **A sector point on the `+a` side, above its lower germ** (the mirror of `BranchGerms.frameY_lt_of_mem`). -/
theorem _root_.HadwigerNelson.Plane.BranchGerms.lt_frameY_of_mem {n : ℕ} {G : BranchGerms n} {P : ℂ} {r : ℝ} {i : Fin n}
    {α : ℝ} {m : ℤ} (hhi : G.nextβ i ≤ α + 2 * π * m + π) {y : ℂ}
    (hy : y ∈ G.sector P r i) (hX : 0 < frameX P α y) {t : ℝ} (ht : t ∈ Icc (-1 : ℝ) 1)
    (hlo : α + 2 * π * m + Real.arcsin t ≤ G.dir i ‖y - P‖) : ‖y - P‖ * t < frameY P α y := by
  have hπ := Real.pi_pos
  obtain ⟨hs, φ, hφ, hyφ⟩ := (BranchGerms.mem_sector_iff (G := G)).mp hy
  set s := ‖y - P‖ with hsdef
  obtain ⟨hXφ, hYφ⟩ := frame_polar P α s φ
  rw [← hyφ] at hXφ hYφ
  have hcos : 0 < Real.cos (φ - α) := by
    rw [hXφ] at hX; exact pos_of_mul_pos_right hX hs.1.le
  have hper : ∀ f : ℝ → ℝ, (∀ x, f (x - (m : ℝ) * (2 * π)) = f x) → f (φ - α) = f (φ - α - 2 * π * m) := by
    intro f hf; rw [← hf (φ - α)]; congr 1; ring
  have hcos' : 0 < Real.cos (φ - α - 2 * π * m) := by
    rw [← hper Real.cos (fun x => Real.cos_sub_int_mul_two_pi x m)]; exact hcos
  have hnd : G.nextDir i s = G.nextβ i + Real.arcsin (G.nextκ i * s / 2) := rfl
  have hhi' : φ - α - 2 * π * m < 3 * π / 2 := by
    have := Real.arcsin_le_pi_div_two (G.nextκ i * s / 2)
    have := hφ.2; rw [hnd] at this; linarith
  have hlo' : Real.arcsin t < φ - α - 2 * π * m := by linarith [hφ.1]
  have hsin := lt_sin_of_cos_pos ht hlo' hhi' hcos'
  rw [← hper Real.sin (fun x => Real.sin_sub_int_mul_two_pi x m)] at hsin
  rw [hYφ]
  exact mul_lt_mul_of_pos_left hsin hs.1

/-- **The thin horn above a germ lies in the sector after it** (the sector-level form of `exists_flank_after`). -/
theorem IsSectorChart.exists_horn_after {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    {j : Fin n} {α κ : ℝ} (hβ : e (G.β j) = e α) (hκ : G.κ j = κ) :
    ∃ κ', κ < κ' ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), r ∈ Ioc 0 r₀ ∧ hornSet v α κ κ' r ⊆ G.sector v r j := by
  obtain ⟨m, hm⟩ := e_eq_e_iff.mp hβ
  have hcj : ∀ r ∈ Ioc 0 r₀, |κ| * r ≤ 2 := fun r hr => by
    rw [← hκ]; exact (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv j).le
  rcases hC.sorted.2 j with hlt | ⟨heq, hκ'⟩
  · have hd : 0 < G.nextβ j - G.β j := sub_pos.mpr hlt
    obtain ⟨η, hη, hηa⟩ := exists_abs_arcsin_lt (half_pos hd)
    have hr₁ : 0 < min r₀ (min (1 / (|κ + 1| + 1)) (min (η / (|κ + 1| + 1)) (η / (|G.nextκ j| + 1)))) := by
      have := hC.pos; positivity
    refine ⟨κ + 1, by linarith, ?_⟩
    filter_upwards [Ioo_mem_nhdsGT hr₁] with r hr
    have hrr₀ : r ∈ Ioc 0 r₀ := ⟨hr.1, hr.2.le.trans (min_le_left _ _)⟩
    refine ⟨hrr₀, ?_⟩
    have hr2 : r < min (1 / (|κ + 1| + 1)) (min (η / (|κ + 1| + 1)) (η / (|G.nextκ j| + 1))) :=
      lt_of_lt_of_le hr.2 (min_le_right _ _)
    have h2 : |κ + 1| * r ≤ 2 := by
      have := abs_half_lt one_pos hr.1 (lt_of_lt_of_le hr2 (min_le_left _ _))
      rw [abs_div, abs_mul, abs_of_pos hr.1, abs_two] at this; linarith
    intro z hz
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
  · refine ⟨G.nextκ j, hκ ▸ hκ', ?_⟩
    filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
    refine ⟨hr, ?_⟩
    have h2 : |G.nextκ j| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv_next j).le
    have h1 : |G.κ j| * r ≤ 2 := by rw [hκ]; exact hcj r hr
    have hsec : G.sector v r j = hornSet v α κ (G.nextκ j) r := by
      show sectorBetween v (G.β j) (G.κ j) (G.nextβ j) (G.nextκ j) r = _
      rw [← heq, sectorBetween_eq_hornSet v _ _ _ r h1 h2, hornSet_congr hβ, hκ]
    rw [← hsec]

/-- The branch of a sector's own germ lies on the arcs. -/
theorem IsSectorChart.branchPt_not_mem {n : ℕ} {G : BranchGerms n} {P : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G P r₀)
    (i : Fin n) {s : ℝ} (hs : s ∈ Ioo 0 r₀) : branchPt P (G.β i) (G.κ i) s ∉ F.interiorPts := by
  have hmem : branchPt P (G.β i) (G.κ i) s ∈ (F.Γ ∩ ball P r₀) \ {P} := by
    rw [hC.branches]; exact mem_iUnion.mpr ⟨i, ⟨s, hs, rfl⟩⟩
  exact fun hI => hI.2 hmem.1.1.2

/-- **The shadow near `v` of one `h`-sector at `N`** (the mirror of `sector_shadow_S`): tangent to `+a` from above with lower
curvature `μ > −1`, it shadows near `v` only points above the concentric circle of curvature `f(μ)`; otherwise none below the
horn's upper arc. -/
theorem sector_shadow_N (hF : F.Valid) (h5 : F.Condition5) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {h : Fin k}
    (h12 : κ₁ < κ₂) (h2 : κ₂ < 1) (hh : F.IsFlankBelow v α κ₁ h)
    {n : ℕ} {G : BranchGerms n} {r₀ : ℝ} (hC : F.IsSectorChart G (v + e (α + π / 2)) r₀) (i : Fin n)
    (hi : ∀ r ∈ Ioc 0 r₀, G.sector (v + e (α + π / 2)) r i ⊆ F.region h) :
    ∃ σ, (σ = κ₂ ∨ (σ = curvDown (G.κ i) ∧ -1 < G.κ i ∧ ∃ m : ℤ, G.β i = α + 2 * π * m)) ∧
      ∀ᶠ δ in 𝓝[>] (0 : ℝ), ∀ᶠ z in 𝓝 v, 0 < frameX v α z → TanBelow v α κ₂ z →
        ∀ y ∈ G.sector (v + e (α + π / 2)) δ i, 0 < frameX v α y → dist z y = 1 → TanAbove v α σ z := by
  have hπ := Real.pi_pos
  set P := v + e (α + π / 2) with hPdef
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  have hPv : P - e (α + π / 2) = v := by rw [hPdef]; ring
  have hNcl : P ∈ closure (F.region h) := closure_mono (hi r₀ hr₀) (hC.mem_closure_sector hr₀ i)
  have hout := outType_N_of_mem_closure hF hv (by linarith) hh hNcl
  obtain ⟨m, hlo, hhi⟩ := hC.exists_lift_upper i (hi r₀ hr₀) hout
  have hnorm : ∀ y, frameX P α y ^ 2 + frameY P α y ^ 2 = ‖y - P‖ ^ 2 := fun y => frame_normSq P α y
  by_cases ht : G.β i = α + 2 * π * m
  · set μ := G.κ i with hμdef
    have heα : e (G.β i) = e α := by rw [ht, e_add_int_mul]
    have hμ1 : -1 < μ := by
      obtain ⟨κ'', hκ'', hev⟩ := hC.exists_horn_after heα rfl
      obtain ⟨r₁, ⟨hr₁mem, hr₁sub⟩, hr₁pos⟩ := (hev.and self_mem_nhdsWithin).exists
      rcases lt_trichotomy μ (-1) with hlt | heq | hgt
      · exfalso
        set m' := (μ + min κ'' (-1)) / 2 with hm'
        have hm'1 : μ < m' := by rw [hm']; linarith [lt_min hκ'' hlt]
        have hm'2 : m' < min κ'' (-1) := by rw [hm']; linarith [lt_min hκ'' hlt]
        obtain ⟨s, hs0, hsr, hsm⟩ := exists_small_s m' hr₁pos
        have hq := branchPt_mem_hornSet P α (κ₁ := μ) (κ₂ := κ'') hm'1 (lt_of_lt_of_le hm'2 (min_le_left _ _)) hs0 hsr hsm
        have hqs := hr₁sub hq
        have hqv : dist (branchPt P α m' s) v < 1 := by
          rw [← hPv, ← tanBelow_neg_one_iff]
          show tanHeight _ _ _ < 0
          rw [tanHeight_branchPt P α m' (-1) hsm.le hs0.le]
          have : m' < -1 := lt_of_lt_of_le hm'2 (min_le_right _ _)
          have := mul_pos (pow_pos hs0 2) (show 0 < -1 - m' by linarith)
          linarith
        obtain ⟨hT, -, hPT⟩ := hC.sector_subset_tile hr₁mem (hi r₁ hr₁mem) hqs
        exact (hout _ hT hPT).ne_of_mem (mem_connectedComponentIn (hC.sector_subset_interiorPts i.pos hr₁mem i hqs))
          (mem_closedBall.mpr hqv.le) rfl
      · exfalso
        have hPdom : P ∈ F.dom := hC.subdom (mem_ball_self hC.pos)
        obtain ⟨ε, hε, hεd, hfin⟩ := F.exists_ball_finite hPdom
        have hr : 0 < min (min r₀ ε) 1 := lt_min (lt_min hC.pos hε) one_pos
        refine false_of_branch_on_sphere h5 (κ := -1) (β := α) (q := v) hr ((min_le_left _ _).trans (min_le_right _ _))
          hεd hfin (fun s hs => ?_) (fun s hs => ?_)
        · have hb : branchPt P α (-1) s = branchPt P (G.β i) (G.κ i) s := by
            simp only [branchPt]; rw [ht, ← hμdef, ← heq, show α + 2 * π * m + Real.arcsin (μ * s / 2) =
              (α + Real.arcsin (μ * s / 2)) + 2 * π * m by ring, e_add_int_mul]
          rw [hb]
          exact hC.branchPt_not_mem i ⟨hs.1, hs.2.trans_le ((min_le_left _ _).trans (min_le_left _ _))⟩
        · rw [mem_sphere, ← hPv]
          exact dist_branchPt_neg_one P α hs.1.le (by linarith [hs.2, min_le_right (min r₀ ε) 1])
      · exact hgt
    refine ⟨curvDown μ, Or.inr ⟨rfl, hμ1, m, ht⟩, ?_⟩
    filter_upwards [Ioc_mem_nhdsGT hC.pos] with δ hδ
    obtain ⟨ε, hε, H⟩ := shadow_farSide_above v α hμ1 hδ.1
    refine Metric.eventually_nhds_iff.mpr ⟨ε, hε, fun z hz hX _ y hy hyX hzy => ?_⟩
    have hya : TanAbove P α μ y := by
      have hs := ((BranchGerms.mem_sector_iff (G := G)).mp hy).1
      have hcurv : |μ| * ‖y - P‖ < 2 := lt_of_le_of_lt (mul_le_mul_of_nonneg_left (hs.2.le.trans hδ.2) (abs_nonneg _))
        (hC.curv i)
      have ht' : μ * ‖y - P‖ / 2 ∈ Icc (-1 : ℝ) 1 := half_curv_mem_Icc hcurv.le (norm_nonneg _) le_rfl
      have hlt := BranchGerms.lt_frameY_of_mem hhi hy (by rw [frameX_base_N]; exact hyX) ht'
        (by show _ ≤ G.β i + Real.arcsin (G.κ i * ‖y - P‖ / 2); rw [ht])
      show 0 < tanHeight μ _ _
      unfold tanHeight
      rw [hnorm y]
      have : ‖y - P‖ * (μ * ‖y - P‖ / 2) = μ * ‖y - P‖ ^ 2 / 2 := by ring
      linarith
    have hyP : dist y P < δ := by
      rw [dist_eq_norm]; exact ((BranchGerms.mem_sector_iff (G := G)).mp hy).1.2
    exact (H z hz hX).mp ⟨y, ⟨hyP, by rw [frameX_base_N]; exact hyX, hya⟩, hzy⟩
  · have hθ : 0 < G.β i - (α + 2 * π * m) := sub_pos.mpr (lt_of_le_of_ne hlo (Ne.symm ht))
    set θ := G.β i - (α + 2 * π * m) with hθdef
    have hθπ : θ ≤ π := by have := hC.sorted.mono i; linarith
    set K := 1 / (1 - κ₂) with hK
    have hKpos : 0 < K := by rw [hK]; exact div_pos one_pos (by linarith)
    have hKc : κ₂ ≤ curvDown K := by
      have hc : curvDown K = 1 / (2 - κ₂) := by
        have h1' : 1 - κ₂ ≠ 0 := by linarith
        have h2' : 2 - κ₂ ≠ 0 := by linarith
        have h3' : 1 + 1 / (1 - κ₂) ≠ 0 := by
          have : 0 < 1 / (1 - κ₂) := div_pos one_pos (by linarith); linarith
        rw [curvDown, hK, div_eq_div_iff h3' h2']; field_simp; ring
      rw [hc, le_div_iff₀ (by linarith)]; nlinarith [sq_nonneg (κ₂ - 1)]
    have hsθ : 0 < Real.sin (θ / 2) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
    obtain ⟨η, hη, hηa⟩ := exists_abs_arcsin_lt (half_pos hθ)
    have hδ₁ : 0 < min r₀ (min (η / (|G.κ i| + 1)) (2 * Real.sin (θ / 2) / K)) := by
      have := hC.pos; positivity
    refine ⟨κ₂, Or.inl rfl, ?_⟩
    filter_upwards [Ioo_mem_nhdsGT hδ₁] with δ hδ
    obtain ⟨ε, hε, H⟩ := shadow_farSide_above v α (μ := K) (by linarith) hδ.1
    refine Metric.eventually_nhds_iff.mpr ⟨ε, hε, fun z hz hX hB y hy hyX hzy => ?_⟩
    exfalso
    have hs := ((BranchGerms.mem_sector_iff (G := G)).mp hy).1
    set s := ‖y - P‖ with hsdef
    have hsδ : s < min (η / (|G.κ i| + 1)) (2 * Real.sin (θ / 2) / K) :=
      lt_trans hs.2 (lt_of_lt_of_le hδ.2 (min_le_right _ _))
    have ha := hηa _ (abs_half_lt hη hs.1 (lt_of_lt_of_le hsδ (min_le_left _ _)))
    have hsin : Real.sin (θ / 2) ∈ Icc (-1 : ℝ) 1 := ⟨Real.neg_one_le_sin _, Real.sin_le_one _⟩
    have harc : Real.arcsin (Real.sin (θ / 2)) = θ / 2 := Real.arcsin_sin (by linarith) (by linarith)
    have hlt := BranchGerms.lt_frameY_of_mem hhi hy (by rw [frameX_base_N]; exact hyX) hsin
      (by show _ ≤ G.β i + Real.arcsin (G.κ i * s / 2); rw [harc]; linarith [(abs_lt.mp ha).1])
    have hya : TanAbove P α K y := by
      show 0 < tanHeight K _ _
      unfold tanHeight
      rw [hnorm y]
      have h2 : s * K < 2 * Real.sin (θ / 2) := by
        have := (lt_div_iff₀ hKpos).mp (lt_of_lt_of_le hsδ (min_le_right _ _)); linarith
      have h3 := mul_pos hs.1 (show 0 < 2 * Real.sin (θ / 2) - s * K by linarith)
      have : ‖y - P‖ ^ 2 = s * s := by rw [hsdef]; ring
      rw [this]
      linarith
    have hyP : dist y P < δ := by rw [dist_eq_norm]; exact hs.2
    have hza := (H z hz hX).mp ⟨y, ⟨hyP, by rw [frameX_base_N]; exact hyX, hya⟩, hzy⟩
    exact absurd (lt_of_le_of_lt (tanHeight_anti hKc _ _) hB) (not_lt.mpr hza.le)

/-- **The converse, one tangent sector at `N`** (the mirror of `shadow_of_tangent_sector_S`). -/
theorem shadow_of_tangent_sector_N {v : ℂ} {α : ℝ} {h : Fin k} {n : ℕ} {G : BranchGerms n} {r₀ : ℝ}
    (hC : F.IsSectorChart G (v + e (α + π / 2)) r₀) (i : Fin n)
    (hi : G.sector (v + e (α + π / 2)) r₀ i ⊆ F.region h) {m : ℤ} (hm : G.β i = α + 2 * π * m)
    (hμ : -1 < G.κ i) :
    ∀ᶠ z in 𝓝 v, 0 < frameX v α z → TanBelow v α 1 z → TanAbove v α (curvDown (G.κ i)) z →
      z ∈ shadow (F.region h) := by
  set P := v + e (α + π / 2) with hPdef
  set μ := G.κ i with hμdef
  have heα : e (G.β i) = e α := by rw [hm, e_add_int_mul]
  obtain ⟨κ'', hκ'', hev⟩ := hC.exists_horn_after heα rfl
  obtain ⟨r₁, ⟨hr₁mem, hr₁sub⟩, hr₁pos⟩ := (hev.and self_mem_nhdsWithin).exists
  have hr₁pos' : (0 : ℝ) < r₁ := hr₁pos
  set δ' := min r₁ (1 / (|μ| + 1)) with hδ'
  have hδ'pos : 0 < δ' := lt_min hr₁pos' (by positivity)
  obtain ⟨ε, hε, H⟩ := shadow_farSide_above v α hμ hδ'pos
  refine Metric.eventually_nhds_iff.mpr ⟨min ε (1 / 16), lt_min hε (by norm_num), fun z hz hX hB hA => ?_⟩
  have hzε : dist z v < ε := lt_of_lt_of_le hz (min_le_left _ _)
  have hz16 : dist z v < 1 / 16 := lt_of_lt_of_le hz (min_le_right _ _)
  obtain ⟨y₀, ⟨hy₀d, hy₀X, hy₀A⟩, hzy₀⟩ := (H z hzε hX).mpr hA
  set s₀ := ‖y₀ - P‖ with hs₀
  have hs₀pos : 0 < s₀ := norm_pos_of_frameX_pos hy₀X
  have hs₀δ : s₀ < δ' := by rw [hs₀, ← dist_eq_norm]; exact hy₀d
  have hs₀r : s₀ < r₁ := lt_of_lt_of_le hs₀δ (min_le_left _ _)
  have hμs : (|μ| + 1) * s₀ < 1 := by
    have := lt_of_lt_of_le hs₀δ (min_le_right _ _)
    rwa [lt_div_iff₀ (by positivity), mul_comm] at this
  have hμs1 : |μ| * s₀ ≤ 1 := by
    have := mul_le_mul_of_nonneg_right (by linarith : |μ| ≤ |μ| + 1) hs₀pos.le; linarith
  have hμs2 : |μ| * s₀ < 2 := by linarith
  set q₀ := branchPt P α μ s₀ with hq₀
  have hX₁ : 0 < frameX P α q₀ := frameX_branchPt_pos P α μ hμs2 hs₀pos
  have hY₁ : frameY P α q₀ = μ * s₀ ^ 2 / 2 := by
    have := tanHeight_branchPt P α μ 0 hμs2.le hs₀pos.le
    unfold tanHeight at this; linarith
  have hsq₁ : frameX P α q₀ ^ 2 + frameY P α q₀ ^ 2 = s₀ ^ 2 := by
    rw [frame_normSq, norm_branchPt_sub P α μ hs₀pos.le]
  have hsq₀ : frameX P α y₀ ^ 2 + frameY P α y₀ ^ 2 = s₀ ^ 2 := frame_normSq P α y₀
  have hY₁₀ : frameY P α q₀ < frameY P α y₀ := by
    have : 0 < tanHeight μ (frameX P α y₀) (frameY P α y₀) := hy₀A
    unfold tanHeight at this; rw [hsq₀] at this; rw [hY₁]; linarith
  have hb : |-frameY P α y₀ + -frameY P α q₀| ≤ 4 * frameX P α q₀ := by
    have hY0 : |frameY P α y₀| ≤ s₀ := by
      rw [hs₀]; exact abs_frameY_le_norm P α y₀
    have hY1 : |frameY P α q₀| ≤ s₀ / 2 := by
      rw [hY₁, abs_div, abs_mul, abs_two, abs_of_nonneg (sq_nonneg s₀)]
      have : |μ| * s₀ ^ 2 = (|μ| * s₀) * s₀ := by ring
      rw [this]
      have := mul_le_of_le_one_left hs₀pos.le hμs1
      linarith
    have hX1 : s₀ / 2 ≤ frameX P α q₀ := flank_half_le_aux hX₁ hsq₁ hY1
    rw [← neg_add, abs_neg]
    calc |frameY P α y₀ + frameY P α q₀| ≤ |frameY P α y₀| + |frameY P α q₀| := abs_add_le _ _
      _ ≤ 4 * frameX P α q₀ := by linarith
  have hxz : frameX P α z < 1 / 8 := by
    have := abs_frameX_sub_le v α z v
    rw [frameX_self, sub_zero] at this
    rw [frameX_base_N]; linarith [le_abs_self (frameX v α z)]
  have hwz : 1 / 2 ≤ -frameY P α z := by
    have := abs_frameY_le_norm v α z
    rw [← dist_eq_norm] at this
    rw [frameY_base_N]; linarith [le_abs_self (frameY v α z)]
  have hq₀z : dist z q₀ < 1 := by
    have h1 := sq_dist_frame P α z q₀
    have h0 := sq_dist_frame P α z y₀
    rw [hzy₀] at h0
    have hx0 : 0 ≤ frameX P α z := by rw [frameX_base_N]; exact hX.le
    have hsq : frameX P α y₀ ^ 2 + (-frameY P α y₀) ^ 2 = frameX P α q₀ ^ 2 + (-frameY P α q₀) ^ 2 := by
      rw [neg_sq, neg_sq]; exact hsq₀.trans hsq₁.symm
    have := flank_higher_aux (x := frameX P α z) (w := -frameY P α z) (X₀ := frameX P α y₀) (Y₀ := -frameY P α y₀)
      (X₁ := frameX P α q₀) (Y₁ := -frameY P α q₀) hy₀X hX₁ hsq (neg_lt_neg hY₁₀) hb hx0 hxz hwz
    have e1 : (-frameY P α z - -frameY P α q₀) ^ 2 = (frameY P α z - frameY P α q₀) ^ 2 := by ring
    have e0 : (-frameY P α z - -frameY P α y₀) ^ 2 = (frameY P α z - frameY P α y₀) ^ 2 := by ring
    rw [e1, e0] at this
    exact flank_lt_one_aux dist_nonneg (by linarith)
  have hcont : Continuous fun ν : ℝ => dist z (branchPt P α ν s₀) :=
    continuous_const.dist (continuous_branchPt_curv P α s₀)
  have hev1 : ∀ᶠ ν in 𝓝 μ, dist z (branchPt P α ν s₀) < 1 :=
    hcont.continuousAt.eventually_lt continuousAt_const hq₀z
  obtain ⟨ν, hν1, hν2⟩ := ((hev1.filter_mono nhdsWithin_le_nhds).and
    (Ioo_mem_nhdsGT (lt_min hκ'' (by linarith : μ < μ + 1)))).exists
  have hνs : |ν| * s₀ < 2 := by
    have : |ν| ≤ |μ| + 1 := by
      rw [abs_le]; constructor
      · linarith [neg_abs_le μ, hν2.1]
      · linarith [le_abs_self μ, min_le_right κ'' (μ + 1), hν2.2]
    have := mul_le_mul_of_nonneg_right this hs₀pos.le
    linarith
  have hqh := branchPt_mem_hornSet P α (κ₁ := μ) (κ₂ := κ'') hν2.1 (lt_of_lt_of_le hν2.2 (min_le_left _ _))
    hs₀pos hs₀r hνs
  have hqs := G.sector_mono hr₁mem.2 i (hr₁sub hqh)
  exact hC.mem_shadow_of_mem hi hqs hν1 (by rw [← tanBelow_one_iff]; exact hB)

/-- **N4-FLANK, the lower flank's half** (the mirror of `flank_shadow_g`): the horn's points near `v` in the shadow of `h`'s class
are exactly those above a tangent circle of curvature `σ_h ∈ [κ₁, κ₂]`. -/
theorem flank_shadow_h (hF : F.Valid) (h5 : F.Condition5) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {h : Fin k}
    (h1 : -1 < κ₁) (h12 : κ₁ < κ₂) (h2 : κ₂ < 1) (hh : F.IsFlankBelow v α κ₁ h) :
    ∃ σh, κ₁ ≤ σh ∧ σh ≤ κ₂ ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₁ κ₂ r,
      (z ∈ shadow (F.region h) ↔ TanAbove v α σh z) := by
  classical
  set P := v + e (α + π / 2) with hPdef
  have hPv : dist P v = 1 := by rw [hPdef, dist_eq_norm, add_sub_cancel_left, norm_e]
  have hPdom : P ∈ F.dom := hv (by rw [mem_closedBall, hPv])
  have hhv : h ∈ F.coloursAt v := mem_closure_of_mem_coneAt hh.mem_coneAt
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hPdom
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  set J : Fin n → Prop := fun i => ∀ r ∈ Ioc 0 r₀, G.sector P r i ⊆ F.region h with hJ
  have hQ : ∀ i, ∃ σ, (¬ J i → σ = κ₂) ∧ (J i → (σ = κ₂ ∨ (σ = curvDown (G.κ i) ∧ -1 < G.κ i ∧
      ∃ m : ℤ, G.β i = α + 2 * π * m)) ∧
      ∀ᶠ δ in 𝓝[>] (0 : ℝ), ∀ᶠ z in 𝓝 v, 0 < frameX v α z → TanBelow v α κ₂ z →
        ∀ y ∈ G.sector P δ i, 0 < frameX v α y → dist z y = 1 → TanAbove v α σ z) := by
    intro i
    by_cases hJi : J i
    · obtain ⟨σ, h₁, h₂⟩ := sector_shadow_N hF h5 hv h12 h2 hh hC i hJi
      exact ⟨σ, fun hc => absurd hJi hc, fun _ => ⟨h₁, h₂⟩⟩
    · exact ⟨κ₂, fun _ => rfl, fun hc => absurd hc hJi⟩
  choose σ hσ using hQ
  have hσκ₁ : ∀ i, κ₁ ≤ σ i := by
    intro i
    by_cases hJi : J i
    · rcases ((hσ i).2 hJi).1 with heq | ⟨heq, hμ, m, hm⟩
      · rw [heq]; exact h12.le
      · rw [heq]
        by_contra hlt
        push Not at hlt
        obtain ⟨ε, hε, hB⟩ := Metric.eventually_nhds_iff.mp (shadow_of_tangent_sector_N hC i (hJi r₀ hr₀) hm hμ)
        obtain ⟨κ', hκ', hev⟩ := hh
        have hev' : ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α (max κ' (curvDown (G.κ i))) κ₁ r ⊆ F.region h := by
          filter_upwards [hev] with r hr
          exact (hornSet_mono (le_max_left _ _) le_rfl).trans hr
        obtain ⟨p, hph, hp⟩ := exists_mem_hornSet_near (max_lt hκ' hlt) hev' hε
        obtain ⟨y, hy, hpy⟩ := hB hp.1 hp.2.1
          (lt_of_le_of_lt (tanHeight_anti (by linarith) _ _) hp.2.2.2)
          (lt_of_lt_of_le hp.2.2.1 (tanHeight_anti (le_max_right _ _) _ _))
        exact hF p hph.1 y hy.1 hpy (hph.2.trans hy.2.symm)
    · rw [(hσ i).1 hJi]; exact h12.le
  set Sset : Finset ℝ := insert κ₂ (Finset.univ.image σ) with hSset
  have hne : Sset.Nonempty := Finset.insert_nonempty _ _
  set σh := Sset.min' hne with hσh
  have hge : ∀ i, σh ≤ σ i := fun i => Finset.min'_le _ _ (Finset.mem_insert_of_mem (Finset.mem_image_of_mem _
    (Finset.mem_univ i)))
  refine ⟨σh, Finset.le_min' _ _ _ ?_, Finset.min'_le _ _ (Finset.mem_insert_self _ _), ?_⟩
  · intro s hs
    rcases Finset.mem_insert.mp hs with rfl | hs
    · exact h12.le
    · obtain ⟨i, -, rfl⟩ := Finset.mem_image.mp hs; exact hσκ₁ i
  have hδall : ∀ᶠ δ in 𝓝[>] (0 : ℝ), ∀ i, J i → ∀ᶠ z in 𝓝 v, 0 < frameX v α z → TanBelow v α κ₂ z →
      ∀ y ∈ G.sector P δ i, 0 < frameX v α y → dist z y = 1 → TanAbove v α (σ i) z := by
    refine Filter.eventually_all.mpr fun i => ?_
    by_cases hJi : J i
    · filter_upwards [((hσ i).2 hJi).2] with δ hδ _ using hδ
    · exact Filter.Eventually.of_forall fun δ hc => absurd hc hJi
  obtain ⟨δ, ⟨hδJ, hδmem⟩, hδpos⟩ := ((hδall.and (Ioc_mem_nhdsGT (lt_min hC.pos one_pos))).and
    self_mem_nhdsWithin).exists
  have hδpos' : (0 : ℝ) < δ := hδpos
  have hδr₀ : δ ∈ Ioc 0 r₀ := ⟨hδpos', hδmem.2.trans (min_le_left _ _)⟩
  have hzall : ∀ᶠ z in 𝓝 v, (∀ i, J i → 0 < frameX v α z → TanBelow v α κ₂ z →
      ∀ y ∈ G.sector P δ i, 0 < frameX v α y → dist z y = 1 → TanAbove v α (σ i) z) ∧
      (∀ i, J i → σ i ≠ κ₂ → 0 < frameX v α z → TanBelow v α 1 z → TanAbove v α (σ i) z →
        z ∈ shadow (F.region h)) := by
    refine (Filter.eventually_all.mpr fun i => ?_).and (Filter.eventually_all.mpr fun i => ?_)
    · by_cases hJi : J i
      · filter_upwards [hδJ i hJi] with z hz _ using hz
      · exact Filter.Eventually.of_forall fun z hc => absurd hc hJi
    · by_cases hJi : J i
      · rcases ((hσ i).2 hJi).1 with heq | ⟨heq, hμ, m, hm⟩
        · exact Filter.Eventually.of_forall fun z _ hc => absurd heq hc
        · filter_upwards [shadow_of_tangent_sector_N hC i (hJi r₀ hr₀) hm hμ] with z hz _ _ hX hB hA
          exact hz hX hB (heq ▸ hA)
      · exact Filter.Eventually.of_forall fun z hc => absurd hc hJi
  obtain ⟨ε, hε, hzε⟩ := Metric.eventually_nhds_iff.mp hzall
  obtain ⟨ρ, hρ, hloc⟩ := horn_shadow_near_N hF hv h1 h2.le hh hδpos'
  filter_upwards [Ioo_mem_nhdsGT (lt_min (lt_min hε hρ) (show (0 : ℝ) < 1 / 4 by norm_num))] with r hr
  intro z hz
  have hzv : dist z v < r := hz.1
  have hzε' : dist z v < ε := lt_of_lt_of_le (hzv.trans hr.2) ((min_le_left _ _).trans (min_le_left _ _))
  have hzρ : z ∈ hornSet v α κ₁ κ₂ ρ :=
    hornSet_mono_radius (hr.2.le.trans ((min_le_left _ _).trans (min_le_right _ _))) hz
  have hz4 : dist z v < 1 / 4 := lt_of_lt_of_le (hzv.trans hr.2) (min_le_right _ _)
  obtain ⟨hzA, hzB⟩ := hzε hzε'
  have hzone : TanBelow v α 1 z := lt_of_le_of_lt (tanHeight_anti h2.le _ _) hz.2.2.2
  constructor
  · rintro ⟨y, hy, hzy⟩
    have hyP : dist y P < δ := hloc z hzρ y hy hzy
    rcases Nat.eq_zero_or_pos n with hn | hn
    · exfalso
      have hball := hC.empty hn
      have hyb : y ∈ ball P r₀ := mem_ball.mpr (lt_of_lt_of_le hyP hδr₀.2)
      have hcol : F.col P = F.col y := (convex_ball P r₀).isPreconnected.constant (F.continuousOn_col.mono hball)
        (mem_ball_self hC.pos) hyb
      have hPh : P ∈ F.region h := ⟨hball (mem_ball_self hC.pos), hcol.trans hy.2⟩
      exact ne1_region hF hhv hPh hPv
    · have hyU : y ∈ ⋃ i, G.sector P δ i := by
        rw [← hC.cover δ hδr₀ hn]; exact ⟨mem_ball.mpr hyP, hy.1⟩
      obtain ⟨i, hi⟩ := mem_iUnion.mp hyU
      obtain ⟨h', hh'⟩ := hC.exists_col i
      have hhh : h' = h := ((hh' δ hδr₀ hi).2.symm.trans hy.2)
      have hJi : J i := fun r hr => hhh ▸ hh' r hr
      by_cases hyX : 0 < frameX v α y
      · exact lt_of_lt_of_le (hzA i hJi hz.2.1 hz.2.2.2 y hi hyX hzy) (tanHeight_anti (hge i) _ _)
      · exfalso
        push Not at hyX
        have hout := outType_N_of_mem_closure hF hv (by linarith) hh
          (closure_mono (hJi r₀ hr₀) (hC.mem_closure_sector hr₀ i))
        obtain ⟨hT, -, hPT⟩ := hC.sector_subset_tile hδr₀ (hJi δ hδr₀) hi
        have hyv : 1 < dist y v := by
          by_contra hle'
          push Not at hle'
          exact (hout _ hT hPT).ne_of_mem (mem_connectedComponentIn (hC.sector_subset_interiorPts hn hδr₀ i hi))
            (mem_closedBall.mpr hle') rfl
        have hzY := abs_frameY_of_horn_le h1 h2 hz (by linarith)
        have hw : |-frameY P α z - 1| ≤ frameX P α z := by
          rw [frameY_base_N, frameX_base_N, show -(frameY v α z - 1) - 1 = -frameY v α z by ring, abs_neg]
          exact hzY
        have hYy : -frameY P α y ≤ 1 := by
          have := abs_frameY_le_norm P α y
          rw [← dist_eq_norm] at this
          linarith [neg_abs_le (frameY P α y), hδmem.2, min_le_right r₀ 1]
        have hpv : 1 ≤ frameX P α y ^ 2 + (-frameY P α y - 1) ^ 2 := by
          rw [frameX_base_N, frameY_base_N, show -(frameY v α y - 1) - 1 = -frameY v α y by ring, neg_sq,
            frame_normSq, ← dist_eq_norm]
          nlinarith [dist_nonneg (x := y) (y := v)]
        have hzP : 1 < frameX P α z ^ 2 + (-frameY P α z) ^ 2 := by
          rw [neg_sq, frameX_base_N, frameY_base_N, show frameY v α z - 1 = frameY v α z + -1 by ring]
          have h := sq_dist_N v α z
          rw [show frameY v α z - 1 = frameY v α z + -1 by ring] at h
          rw [← h]
          exact one_lt_pow₀ ((tanBelow_one_iff v α z).mp hzone) two_ne_zero
        have hw0 : 0 ≤ -frameY P α z := by
          rw [frameY_base_N]; have := abs_frameY_le_norm v α z; rw [← dist_eq_norm] at this
          linarith [le_abs_self (frameY v α z)]
        have hX0 : 0 < frameX P α z := by rw [frameX_base_N]; exact hz.2.1
        have := flank_back_aux hX0 hw hw0 hzP (by rw [frameX_base_N]; exact hyX) hYy hpv
        have e1 : (-frameY P α z - -frameY P α y) ^ 2 = (frameY P α z - frameY P α y) ^ 2 := by ring
        rw [e1, ← sq_dist_frame, hzy] at this
        norm_num at this
  · intro hA
    rcases Finset.mem_insert.mp (Finset.min'_mem Sset hne) with heq | hmem
    · rw [← hσh] at heq
      rw [heq] at hA
      exact absurd hz.2.2.2 (not_lt.mpr hA.le)
    · obtain ⟨i, -, hi⟩ := Finset.mem_image.mp hmem
      rw [← hσh] at hi
      rw [← hi] at hA
      by_cases hJi : J i
      · by_cases hκ : σ i = κ₂
        · rw [hκ] at hA; exact absurd hz.2.2.2 (not_lt.mpr hA.le)
        · exact hzB i hJi hκ hz.2.1 hzone hA
      · rw [(hσ i).1 hJi] at hA; exact absurd hz.2.2.2 (not_lt.mpr hA.le)

theorem flank_shadows_test (hF : F.Valid) (h5 : F.Condition5) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c g h : Fin k}
    (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : -1 < κ₁) (h2 : κ₂ < 1) (hg : F.IsFlankAbove v α κ₂ g)
    (hh : F.IsFlankBelow v α κ₁ h) (hgc : g ≠ c) (hhc : h ≠ c) :
    ∃ σg σh, κ₁ ≤ σg ∧ σg ≤ κ₂ ∧ κ₁ ≤ σh ∧ σh ≤ κ₂ ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₁ κ₂ r,
      (z ∈ shadow (F.region g) ↔ TanBelow v α σg z) ∧ (z ∈ shadow (F.region h) ↔ TanAbove v α σh z) := by
  obtain ⟨σg, hg1, hg2, hevg⟩ := flank_shadow_g hF h5 hv h1 hH.1 h2 hg
  obtain ⟨σh, hh1, hh2, hevh⟩ := flank_shadow_h hF h5 hv h1 hH.1 h2 hh
  refine ⟨σg, σh, hg1, hg2, hh1, hh2, ?_⟩
  filter_upwards [hevg, hevh] with r hr hr' z hz using ⟨hr z hz, hr' z hz⟩

end ArcMap

end HadwigerNelson.Plane
