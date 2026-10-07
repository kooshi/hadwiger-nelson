import Proofs.HadwigerNelson.Plane.RingCalculus.TilesAt
import Proofs.HadwigerNelson.Plane.ValidMap.HexRing
import Proofs.HadwigerNelson.Plane.ValidMap.Surgery

/-!
# The ring calculus: the tiles of a point from its sector chart — the lemmas two modules share

Wave 8's shared part (job FS131-I8B; `plans/FS131-I8B-implementation.md`, Stage 3). The second planning pass
(`plans/FS131-w8-kernel-plan.md` § 9.1) named, in prose, the lemmas the proofs of `Plane/RingCalculus/SemiHub` and of
`Plane/RingCalculus/SemiHubPlaces` both derive from. They are stated and proved here once, so that neither module states
one (`LEAN.md` § Searching — Lean: two branches never state one lemma under one name).

| the plan's name | declaration | what it says |
|---|---|---|
| C1 | `exists_int_of_angleIcc_subset` | an interval of directions inside the `2π`-translates of an interval shorter than `2π` lies in one translate (a corollary of wave 3's `exists_lift_of_Icc_subset_angleIcc`) |
| C2 | `int_eq_zero_of_two_pi_mul_lt`, `int_eq_zero_of_abs_two_pi_mul_lt` | an integer `m` with `|2πm| < 2π` is `0` |
| G1 | `ArcMap.mem_closure_tile_of_near` | the non-Siamese engine at a closure point of a colour class |
| — | `ArcMap.ncard_tileAt_eq` | valid, non-Siamese: as many tiles at a point as colours |
| K1 | `ArcMap.IsSectorChart.tileAt_equiv`, `ArcMap.exists_sectorChart_tileAt` | simple at `x`: the tiles of `x` are the chart's sectors, one each, with their cones; in a valid non-Siamese map the chart has one germ per colour |
| K2 | `ArcMap.IsSectorChart.exists_initialPiece_branch`, `ArcMap.IsSectorChart.exists_initialPiece_between`, `ArcMap.exists_initialPiece_of_ncard_le_three` | each branch of a chart is an initial piece of an arc of the map; two consecutive sectors share it in their closures; at a point of at most three colours any two tiles do |

K2's children are stated for reuse: `Arc.InitialPiece.exists_param` (an initial piece contains a parametrized one that
leaves its point, and every shorter one is again an initial piece — the "shrink" step), and
`ArcMap.IsSectorChart.exists_branch_of_isPreconnected` (a connected piece of `Γ` in a chart's punctured ball lies on one
branch).

**Inhabitants.** A sector chart with a germ in a map simple at the point: `halfDisc` at `0` (`halfDisc_sectorChart`,
`halfDisc_simpleOn`); the examples at the end run K1 and K2 on it. The class "valid, non-Siamese, simple at `x`" of
`ncard_tileAt_eq`, `exists_sectorChart_tileAt` and `exists_initialPiece_of_ncard_le_three` is the class of the wave's rows,
whose held models are named in `Plane/RingCalculus/Star`'s header (no Lean term of that class with three or four colours at
a point yet).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## C1, C2: intervals of directions -/

/-- **C1**: an interval of directions `[a, b]` inside the `2π`-translates of an interval `[lo, hi]` shorter than `2π` lies
in one translate. (Wave 3's `exists_lift_of_Icc_subset_angleIcc`, with the interval given as an `angleIcc` — the form a
cone at a point simple for the map has.) -/
theorem exists_int_of_angleIcc_subset {a b lo hi : ℝ} (hab : a ≤ b) (hlen : hi < lo + 2 * π)
    (h : angleIcc a b ⊆ angleIcc lo hi) : ∃ m : ℤ, lo + 2 * π * m ≤ a ∧ b ≤ hi + 2 * π * m :=
  ArcMap.exists_lift_of_Icc_subset_angleIcc (by linarith) hab ((Icc_subset_angleIcc a b).trans h)

/-- **C2**, two-sided: an integer `m` with `−2π < 2πm < 2π` is `0`. -/
theorem int_eq_zero_of_two_pi_mul_lt {m : ℤ} (h₁ : -(2 * π) < 2 * π * (m : ℝ)) (h₂ : 2 * π * (m : ℝ) < 2 * π) :
    m = 0 := by
  have hπ := Real.pi_pos
  have h1 : (-1 : ℝ) < m := by nlinarith
  have h2 : (m : ℝ) < 1 := by nlinarith
  have h1' : (-1 : ℤ) < m := by exact_mod_cast h1
  have h2' : m < 1 := by exact_mod_cast h2
  omega

/-- **C2**: an integer `m` with `|2πm| < 2π` is `0`. -/
theorem int_eq_zero_of_abs_two_pi_mul_lt {m : ℤ} (h : |2 * π * (m : ℝ)| < 2 * π) : m = 0 :=
  int_eq_zero_of_two_pi_mul_lt (abs_lt.mp h).1 (abs_lt.mp h).2

/-! ## K2's children that read no map -/

/-- The segment from `y` of length `η` along `u`, as the image of `[0, η]`. -/
theorem segment_eq_image_ray (y u : ℂ) {η : ℝ} (hη : 0 < η) :
    segment ℝ y (y + (η : ℂ) * u) = (fun t : ℝ => y + (t : ℂ) * u) '' Icc 0 η := by
  rw [segment_eq_image']
  ext z
  constructor
  · rintro ⟨θ, hθ, rfl⟩
    refine ⟨θ * η, ⟨mul_nonneg hθ.1 hη.le, by nlinarith [hθ.2]⟩, ?_⟩
    simp only [add_sub_cancel_left, Complex.real_smul]
    push_cast
    ring
  · rintro ⟨t, ht, rfl⟩
    refine ⟨t / η, ⟨div_nonneg ht.1 hη.le, (div_le_one hη).mpr ht.2⟩, ?_⟩
    have hη' : (η : ℂ) ≠ 0 := by exact_mod_cast hη.ne'
    simp only [add_sub_cancel_left, Complex.real_smul]
    push_cast
    field_simp

/-- **An initial piece contains a parametrized one that leaves its point, and every shorter one is again an initial
piece**: there are a continuous `γ` with `γ 0 = y` and `ε > 0` such that `γ t ≠ y` on `(0, ε]` and, for every
`η ∈ (0, ε]`, `γ '' [0, η]` lies in `B` and is an initial piece of the arc leaving `y` in the same direction. (The
"shrink" step of an argument near `y`; the punctured piece `γ '' (0, η]` is connected.) -/
theorem Arc.InitialPiece.exists_param {a : Arc} {y : ℂ} {δ : ℝ} {B : Set ℂ} (h : a.InitialPiece y δ B) :
    ∃ γ : ℝ → ℂ, ∃ ε > 0, Continuous γ ∧ γ 0 = y ∧ (∀ t ∈ Ioc 0 ε, γ t ≠ y) ∧
      ∀ η ∈ Ioc 0 ε, γ '' Icc 0 η ⊆ B ∧ a.InitialPiece y δ (γ '' Icc 0 η) := by
  cases a with
  | seg p q =>
    obtain ⟨ε, hε, rfl, hB⟩ := h
    refine ⟨fun t : ℝ => y + (t : ℂ) * e δ, ε, hε, by fun_prop, by simp, fun t ht hty => ?_, fun η hη => ?_⟩
    · have h0 : (t : ℂ) * e δ = 0 := by simpa using hty
      rcases mul_eq_zero.mp h0 with h0 | h0
      · exact ht.1.ne' (by exact_mod_cast h0)
      · exact e_ne_zero δ h0
    · have hsub : (fun t : ℝ => y + (t : ℂ) * e δ) '' Icc 0 η ⊆ segment ℝ y (y + (ε : ℂ) * e δ) := by
        rw [segment_eq_image_ray y (e δ) hε]
        exact image_mono (Icc_subset_Icc_right hη.2)
      exact ⟨hsub, η, hη.1, (segment_eq_image_ray y (e δ) hη.1).symm, hsub.trans hB⟩
  | circ c ρ θ₀ θ₁ =>
    obtain ⟨hρ, φ, ε, σ, hσ, hε, hy, hδ, rfl, hsub⟩ := h
    have hπ := Real.pi_pos
    refine ⟨fun t : ℝ => c + ρ * e (φ + σ * t), min ε π, lt_min hε hπ,
      continuous_const.add (continuous_const.mul (continuous_e.comp (by fun_prop))), by simp [hy],
      fun t ht hty => ?_, fun η hη => ?_⟩
    · have h1 : (ρ : ℂ) * e (φ + σ * t) = ρ * e φ := by
        rw [hy] at hty; exact add_left_cancel hty
      have h2 : e (φ + σ * t) = e φ := mul_left_cancel₀ (by exact_mod_cast hρ.ne') h1
      obtain ⟨m, hm⟩ := e_eq_e_iff.mp h2
      have htπ : t ≤ π := ht.2.trans (min_le_right _ _)
      have ht0 := ht.1
      rcases hσ with rfl | rfl
      · have hm0 : (0 : ℝ) < m := by nlinarith
        have hm1 : (1 : ℝ) ≤ m := by exact_mod_cast Int.cast_pos.mp hm0
        nlinarith
      · have hm0 : (m : ℝ) < 0 := by nlinarith
        have hm1 : (m : ℝ) ≤ -1 := by
          have : m ≤ -1 := by
            have : m < 0 := by exact_mod_cast hm0
            omega
          exact_mod_cast this
        nlinarith
    · have hηε : η ≤ ε := hη.2.trans (min_le_left _ _)
      exact ⟨image_mono (Icc_subset_Icc_right hηε), hρ, φ, η, σ, hσ, hη.1, hy, hδ, rfl,
        (image_mono (Icc_subset_Icc_right hηε)).trans hsub⟩

/-- **A branch enters every wedge about its own direction**: for every `N` and `m > 0`, the points of the branch germ
`(β, κ)` at small distances from `y` lie in the wedge `Rgn y (e β) N m`. -/
theorem branchPt_mem_Rgn (y : ℂ) (β κ N : ℝ) {m : ℝ} (hm : 0 < m) :
    ∀ᶠ s in 𝓝[>] (0 : ℝ), branchPt y β κ s ∈ Rgn y (e β) N m := by
  set a : ℝ → ℝ := fun s => Real.arcsin (κ * s / 2) with ha
  have hac : Continuous a := Real.continuous_arcsin.comp (by fun_prop)
  have ha0 : a 0 = 0 := by simp [ha]
  have e1 : ∀ᶠ s in 𝓝 (0 : ℝ), 1 / 2 < Real.cos (a s) :=
    ((Real.continuous_cos.comp hac).tendsto 0).eventually
      (lt_mem_nhds (show (1 : ℝ) / 2 < (Real.cos ∘ a) 0 by simp [ha0]; norm_num))
  have e2 : ∀ᶠ s in 𝓝 (0 : ℝ), |Real.sin (a s)| < m / 2 :=
    ((continuous_abs.comp (Real.continuous_sin.comp hac)).tendsto 0).eventually
      (gt_mem_nhds (show ((fun x : ℝ => |x|) ∘ (Real.sin ∘ a)) 0 < m / 2 by simp [ha0]; positivity))
  have e3 : ∀ᶠ s in 𝓝 (0 : ℝ), N * s < 1 / 2 :=
    ((continuous_const.mul continuous_id).tendsto 0).eventually
      (gt_mem_nhds (show N * (0 : ℝ) < 1 / 2 by norm_num))
  filter_upwards [nhdsWithin_le_nhds e1, nhdsWithin_le_nhds e2, nhdsWithin_le_nhds e3, self_mem_nhdsWithin]
    with s h1 h2 h3 hs
  have hs0 : 0 < s := hs
  have hrot : rotD y (e β) (branchPt y β κ s) = (s : ℂ) * e (a s) := by
    simp only [rotD, branchPt, add_sub_cancel_left, ha]
    rw [e_add]
    linear_combination (s : ℂ) * e (Real.arcsin (κ * s / 2)) * e_mul_conj_e β
  have hre : (rotD y (e β) (branchPt y β κ s)).re = s * Real.cos (a s) := by
    rw [hrot]; simp [re_e]
  have him : (rotD y (e β) (branchPt y β κ s)).im = s * Real.sin (a s) := by
    rw [hrot]; simp [im_e]
  have hsq : Complex.normSq (rotD y (e β) (branchPt y β κ s)) = s * s := by
    rw [hrot, Complex.normSq_mul, Complex.normSq_ofReal, Complex.normSq_eq_norm_sq, norm_e]; ring
  refine ⟨fun h => ?_, ?_, ?_⟩
  · have := norm_branchPt_sub y β κ hs0.le
    rw [h, sub_self, norm_zero] at this
    exact hs0.ne this
  · rw [hre, hsq]; nlinarith
  · rw [hre, him, abs_mul, abs_of_pos hs0]
    linarith [mul_lt_mul_of_pos_left h2 hs0, mul_pos (mul_pos hm hs0) (sub_pos.mpr h1)]

/-- **The two germs of a curve at one distance** leave its point symmetrically about the normal `b`: the sum of their
offsets is a real multiple of `b`. -/
theorem branchPt_curveGerm_add (v : ℂ) (κ : ℝ) {b : ℂ} (hb : b ≠ 0) (s : ℝ) :
    ∃ t : ℝ, (branchPt v (curveGerm κ b 1).1 (curveGerm κ b 1).2 s - v) +
      (branchPt v (curveGerm κ b (-1)).1 (curveGerm κ b (-1)).2 s - v) = (t : ℂ) * b := by
  have hbn : (‖b‖ : ℂ) ≠ 0 := by exact_mod_cast (norm_pos_iff.mpr hb).ne'
  set α := Real.arcsin (κ * s / (2 * ‖b‖)) with hα
  refine ⟨2 * s * Real.sin α / ‖b‖, ?_⟩
  rw [branchPt_curveGerm, branchPt_curveGerm, add_sub_cancel_left, add_sub_cancel_left]
  have h1 : arg b - 1 * (π / 2) + Real.arcsin (1 * (κ * s / (2 * ‖b‖))) = arg b + (α - π / 2) := by
    rw [hα, one_mul, one_mul]; ring
  have h2 : arg b - -1 * (π / 2) + Real.arcsin (-1 * (κ * s / (2 * ‖b‖))) = arg b + (π / 2 - α) := by
    rw [hα, show (-1 : ℝ) * (κ * s / (2 * ‖b‖)) = -(κ * s / (2 * ‖b‖)) by ring, Real.arcsin_neg]; ring
  rw [h1, h2, e_add, e_add, e_eq (α - π / 2), e_eq (π / 2 - α), Real.cos_sub_pi_div_two, Real.sin_sub_pi_div_two,
    Real.cos_pi_div_two_sub, Real.sin_pi_div_two_sub]
  have hpol := eq_polar_arg b
  simp only [Complex.ofReal_neg, Complex.ofReal_div, Complex.ofReal_mul, Complex.ofReal_ofNat]
  field_simp
  linear_combination (-(2 * (s : ℂ) * (Real.sin α : ℂ))) * hpol

/-- **The two germs of a curve tangent to `u` are never both in one wedge about `u`** at one distance: the sum of their
offsets is normal to `u`. -/
theorem not_both_mem_Rgn_curveGerm {v u b : ℂ} (hb : b ≠ 0) (hT : (b * (starRingEnd ℂ) u).re = 0) (κ s : ℝ)
    {N : ℝ} (hN : 0 < N) (m : ℝ) :
    ¬ (branchPt v (curveGerm κ b 1).1 (curveGerm κ b 1).2 s ∈ Rgn v u N m ∧
      branchPt v (curveGerm κ b (-1)).1 (curveGerm κ b (-1)).2 s ∈ Rgn v u N m) := by
  rintro ⟨⟨-, h1, -⟩, ⟨-, h2, -⟩⟩
  obtain ⟨t, ht⟩ := branchPt_curveGerm_add v κ hb s
  have hsum : rotD v u (branchPt v (curveGerm κ b 1).1 (curveGerm κ b 1).2 s) +
      rotD v u (branchPt v (curveGerm κ b (-1)).1 (curveGerm κ b (-1)).2 s) = (t : ℂ) * (b * (starRingEnd ℂ) u) := by
    simp only [rotD]
    linear_combination (starRingEnd ℂ) u * ht
  have hre := congrArg Complex.re hsum
  rw [Complex.add_re, Complex.re_ofReal_mul, hT, mul_zero] at hre
  nlinarith [Complex.normSq_nonneg (rotD v u (branchPt v (curveGerm κ b 1).1 (curveGerm κ b 1).2 s)),
    Complex.normSq_nonneg (rotD v u (branchPt v (curveGerm κ b (-1)).1 (curveGerm κ b (-1)).2 s))]

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## G1 and the count of tiles -/

/-- **G1, the non-Siamese engine at a closure point of a class**: in a valid non-Siamese map, a point `z` of the domain in
the closure of the class of `c`, nearer than `1` to a closure point of a tile `R` of colour `c`, lies in `closure R`.
(The class of the wave's rows; inhabitants: the module docstring.) -/
theorem mem_closure_tile_of_near (hF : F.Valid) (hN : F.NonSiamese) {c : Fin k} {R : Set ℂ} (hR : F.TileOf c R)
    {z z' : ℂ} (hzd : z ∈ F.dom) (hz : z ∈ closure (F.region c)) (hz' : z' ∈ closure R) (h : dist z z' < 1) :
    z ∈ closure R := by
  obtain ⟨T, hT, hzT⟩ := (F.mem_coloursAt_iff_exists_tileOf hzd).mp hz
  exact hN.tile_eq_of_dist_lt hF hT hR hzT hz' h ▸ hzT

/-- **As many tiles at a point as colours**, in a valid non-Siamese map: one tile per colour
(`NonSiamese.tile_eq_of_mem_closure`), and every colour at the point has one. -/
theorem ncard_tileAt_eq (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : p ∈ F.dom) :
    {T | F.TileAt p T}.ncard = (F.coloursAt p).ncard := by
  refine Set.ncard_congr (fun T hT => F.col hT.1.nonempty.some) (fun T hT => ?_) (fun T T' hT hT' h => ?_)
    (fun c hc => ?_)
  · exact mem_coloursAt_of_tileOf (hT.1.tileOf hT.1.nonempty.some_mem) hT.2
  · have h1 := hT.1.tileOf hT.1.nonempty.some_mem
    have h2 := hT'.1.tileOf hT'.1.nonempty.some_mem
    rw [← h] at h2
    exact hN.tile_eq_of_mem_closure hF h1 h2 hT.2 hT'.2
  · obtain ⟨T, hT, hpT⟩ := (F.mem_coloursAt_iff_exists_tileOf hp).mp hc
    exact ⟨T, ⟨hT.1, hpT⟩, hT.2 hT.1.nonempty.some_mem⟩

/-! ## K1: the tiles of a point are its chart's sectors -/

/-- **K1**: in a sector chart at `x` with a germ, of a map simple at `x`, the tiles of `x` are the chart's sectors, one
each: there is an injective list `τ` of the tiles of `x`, indexed as the sectors are, with `τ i` meeting the chart's ball
in the `i`-th sector exactly; so the cone of `τ i` at `x` is the interval between the `i`-th germ's direction and the next.
(No validity is read. Inhabitant: `halfDisc` at `0`, the example at the end.) -/
theorem IsSectorChart.tileAt_equiv {n : ℕ} {G : BranchGerms n} {x : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G x r₀)
    (hn : 0 < n) (hS : F.SimpleOn {x}) :
    ∃ τ : Fin n → Set ℂ, Function.Injective τ ∧ (∀ T, F.TileAt x T ↔ ∃ i, τ i = T) ∧
      (∀ i, τ i ∩ ball x r₀ = G.sector x r₀ i) ∧ ∀ i, coneAt (τ i) x = angleIcc (G.β i) (G.nextβ i) := by
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  have hex : ∀ i, ∃ T, F.IsTile T ∧ G.sector x r₀ i ⊆ T := by
    intro i
    obtain ⟨w, hw⟩ := hC.sector_nonempty hr₀ i
    have hwI := hC.sector_subset_interiorPts hn hr₀ i hw
    exact ⟨connectedComponentIn F.interiorPts w, ⟨w, hwI, rfl⟩,
      (hC.isPreconnected r₀ hr₀ i).subset_connectedComponentIn hw (hC.sector_subset_interiorPts hn hr₀ i)⟩
  choose τ hτ hsub using hex
  have hxcl : ∀ i, x ∈ closure (τ i) := fun i => by
    have hβ : G.β i ∈ coneAt (G.sector x r₀ i) x := by
      rw [hC.cone r₀ hr₀ i]; exact Icc_subset_angleIcc _ _ ⟨le_rfl, hC.sorted.mono i⟩
    exact closure_mono (hsub i) (mem_closure_of_mem_coneAt hβ)
  have hinter : ∀ i, τ i ∩ ball x r₀ = G.sector x r₀ i := by
    intro i
    obtain ⟨j, hj⟩ := hC.exists_tile_inter_ball hn (hτ i) (hS.1 (τ i) (hτ i) ⟨x, hxcl i, rfl⟩) (hxcl i)
    obtain ⟨w, hw⟩ := hC.sector_nonempty hr₀ i
    have hwj : w ∈ G.sector x r₀ j := by rw [← hj]; exact ⟨hsub i hw, G.sector_subset_ball i hw⟩
    have hij : i = j := by
      by_contra hne
      exact Set.disjoint_left.mp (hC.disjoint r₀ hr₀ i j hne) hw hwj
    rw [hj, hij]
  refine ⟨τ, fun i j hij => ?_, fun T => ⟨?_, ?_⟩, hinter, fun i => ?_⟩
  · by_contra hne
    obtain ⟨w, hw⟩ := hC.sector_nonempty hr₀ i
    have hwj : w ∈ G.sector x r₀ j := by rw [← hinter j, ← hij, hinter i]; exact hw
    exact Set.disjoint_left.mp (hC.disjoint r₀ hr₀ i j hne) hw hwj
  · rintro ⟨hT, hxT⟩
    obtain ⟨i, hi⟩ := hC.exists_tile_inter_ball hn hT (hS.1 T hT ⟨x, hxT, rfl⟩) hxT
    obtain ⟨w, hw⟩ := hC.sector_nonempty hr₀ i
    have hwT : w ∈ T := (hi.symm ▸ hw : w ∈ T ∩ ball x r₀).1
    exact ⟨i, (hτ i).eq_of_mem hT (hsub i hw) hwT⟩
  · rintro ⟨i, rfl⟩
    exact ⟨hτ i, hxcl i⟩
  · have hloc : coneAt (τ i) x = coneAt (τ i ∩ ball x r₀) x :=
      Subset.antisymm (fun β hβ => coneAt_inter_ball hC.pos hβ) (coneAt_mono inter_subset_left x)
    rw [hloc, hinter i, hC.cone r₀ hr₀ i]

/-- **K1 with the count** (the form `exists_isStar4` and FS116-N3-SEMI's three-tile case read): in a valid non-Siamese map
simple at a point `x` of the domain carrying `n ≥ 2` colours, `x` has a sector chart with **`n` germs, one per colour**,
whose branches never meet at one distance, and the tiles of `x` are its sectors, one each, with their cones. (The count is
a hypothesis `ncard = n`, so that a consumer holding `ncard = 4` gets `G : BranchGerms 4` and `τ : Fin 4 → Set ℂ` with no
cast. The class of the wave's rows; inhabitants: the module docstring.) -/
theorem exists_sectorChart_tileAt (hF : F.Valid) (hN : F.NonSiamese) {x : ℂ} (hx : x ∈ F.dom) (hS : F.SimpleOn {x})
    {n : ℕ} (hn : (F.coloursAt x).ncard = n) (h2 : 2 ≤ n) :
    ∃ r₀, ∃ G : BranchGerms n, F.IsSectorChart G x r₀ ∧
      (∀ i j, i ≠ j → ∀ s ∈ Ioo 0 r₀, e (G.dir i s) ≠ e (G.dir j s)) ∧
      ∃ τ : Fin n → Set ℂ, Function.Injective τ ∧ (∀ T, F.TileAt x T ↔ ∃ i, τ i = T) ∧
        (∀ i, τ i ∩ ball x r₀ = G.sector x r₀ i) ∧ ∀ i, coneAt (τ i) x = angleIcc (G.β i) (G.nextβ i) := by
  subst hn
  obtain ⟨r₀, n, G, hC, hdisj⟩ := localSectors_disj F hx
  have hcount := ncard_tileAt_eq hF hN hx
  rcases Nat.eq_zero_or_pos n with hn | hn
  · exfalso
    have hxI : x ∈ F.interiorPts := hC.empty hn (mem_ball_self hC.pos)
    have hone : {T | F.TileAt x T} = {connectedComponentIn F.interiorPts x} := by
      ext T
      simp only [mem_setOf_eq, mem_singleton_iff]
      constructor
      · rintro ⟨hT, hxT⟩
        obtain ⟨z, hzT, hzd⟩ := Metric.mem_closure_iff.mp hxT r₀ hC.pos
        have hball : ball x r₀ ⊆ T := hT.subset_of_preconnected (convex_ball x r₀).isPreconnected (hC.empty hn)
          (by rw [mem_ball, dist_comm]; exact hzd) hzT
        exact hT.eq_of_mem ⟨x, hxI, rfl⟩ (hball (mem_ball_self hC.pos)) (mem_connectedComponentIn hxI)
      · rintro rfl
        exact ⟨⟨x, hxI, rfl⟩, subset_closure (mem_connectedComponentIn hxI)⟩
    rw [hone, Set.ncard_singleton] at hcount
    omega
  · obtain ⟨τ, hinj, htile, hinter, hcone⟩ := hC.tileAt_equiv hn hS
    have hrange : {T | F.TileAt x T} = Set.range τ := by
      ext T; exact htile T
    have hnc : n = (F.coloursAt x).ncard := by
      rw [← hcount, hrange, ← Set.image_univ, Set.ncard_image_of_injective _ hinj, Set.ncard_univ,
        Nat.card_eq_fintype_card, Fintype.card_fin]
    subst hnc
    exact ⟨r₀, G, hC, hdisj, τ, hinj, htile, hinter, hcone⟩

/-! ## K2: each branch of a chart is an initial piece of an arc; consecutive sectors share it -/

/-- **A connected piece of `Γ` in a chart's punctured ball lies on one branch**, in a chart whose branches never meet at
one distance. -/
theorem IsSectorChart.exists_branch_of_isPreconnected {n : ℕ} {G : BranchGerms n} {x : ℂ} {r₀ : ℝ}
    (hC : F.IsSectorChart G x r₀) (hdisj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 r₀, e (G.dir i s) ≠ e (G.dir j s))
    {S : Set ℂ} (hS : IsPreconnected S) (hne : S.Nonempty) (hsub : S ⊆ (F.Γ ∩ ball x r₀) \ {x}) :
    ∃ j, S ⊆ branchPt x (G.β j) (G.κ j) '' Ioo 0 r₀ := by
  obtain ⟨w₀, hw₀⟩ := hne
  have hbr : ∀ w ∈ S, ∃ l, w ∈ branchPt x (G.β l) (G.κ l) '' Ioo 0 r₀ := fun w hw => by
    have := hsub hw
    rw [hC.branches] at this
    exact mem_iUnion.mp this
  obtain ⟨j, hj⟩ := hbr w₀ hw₀
  refine ⟨j, fun w hw => ?_⟩
  by_contra hwj
  obtain ⟨l, hl⟩ := hbr w hw
  have hlj : l ≠ j := by
    rintro rfl; exact hwj hl
  set t : Set ℂ := branchPt x (G.β j) (G.κ j) '' Icc 0 r₀ with ht
  set t' : Set ℂ := ⋃ l ∈ {l : Fin n | l ≠ j}, branchPt x (G.β l) (G.κ l) '' Icc 0 r₀ with ht'
  have htc : IsClosed t := (isCompact_Icc.image (continuous_branchPt x _ _)).isClosed
  have ht'c : IsClosed t' :=
    (Set.toFinite _).isClosed_biUnion fun l _ => (isCompact_Icc.image (continuous_branchPt x _ _)).isClosed
  have hcov : S ⊆ t ∪ t' := by
    intro z hz
    obtain ⟨l', s, hs, rfl⟩ := hbr z hz
    by_cases h : l' = j
    · left; exact ⟨s, Ioo_subset_Icc_self hs, by rw [h]⟩
    · right; exact mem_iUnion₂.mpr ⟨l', h, s, Ioo_subset_Icc_self hs, rfl⟩
  obtain ⟨z, hzS, hzt, hzt'⟩ := (isPreconnected_closed_iff.mp hS) t t' htc ht'c hcov
    ⟨w₀, hw₀, image_mono Ioo_subset_Icc_self hj⟩
    ⟨w, hw, mem_iUnion₂.mpr ⟨l, hlj, image_mono Ioo_subset_Icc_self hl⟩⟩
  obtain ⟨s, hs, hsz⟩ := hzt
  obtain ⟨l', hl', s', hs', hs'z⟩ := mem_iUnion₂.mp hzt'
  have hzx := hsub hzS
  have hn1 : ‖z - x‖ = s := by rw [← hsz]; exact norm_branchPt_sub x _ _ hs.1
  have hn2 : ‖z - x‖ = s' := by rw [← hs'z]; exact norm_branchPt_sub x _ _ hs'.1
  have hss : s' = s := by rw [← hn1, hn2]
  have hspos : 0 < s := by rw [← hn1]; exact norm_pos_iff.mpr (sub_ne_zero.mpr hzx.2)
  have hslt : s < r₀ := by rw [← hn1, ← dist_eq_norm]; exact hzx.1.2
  subst hss
  exact hl' (eq_of_branchPt_eq hdisj ⟨hspos, hslt⟩ (hs'z.trans hsz.symm))

/-- **K2, the branch**: in a chart whose branches never meet at one distance, each branch is, near the chart's point, an
initial piece of an arc of the map leaving `x` along the germ's direction. (Inhabitant: `halfDisc` at `0`, the example at
the end.) -/
theorem IsSectorChart.exists_initialPiece_branch {n : ℕ} {G : BranchGerms n} {x : ℂ} {r₀ : ℝ}
    (hC : F.IsSectorChart G x r₀) (hdisj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 r₀, e (G.dir i s) ≠ e (G.dir j s))
    (j : Fin n) :
    ∃ α ∈ F.arcs, ∃ B, α.InitialPiece x (G.β j) B ∧ B ⊆ insert x (branchPt x (G.β j) (G.κ j) '' Ioo 0 r₀) := by
  have hxd : x ∈ F.dom := hC.subdom (mem_ball_self hC.pos)
  obtain ⟨ρ₀, hG⟩ := F.exists_goodAt hxd
  have hu1 : ‖e (G.β j)‖ = 1 := norm_e _
  obtain ⟨m, hm, N₀, hN₀, hW⟩ := hG.exists_wedge hu1
  have hPΓ : ∀ s ∈ Ioo 0 r₀, branchPt x (G.β j) (G.κ j) s ∈ (F.Γ ∩ ball x r₀) \ {x} := fun s hs => by
    rw [hC.branches]; exact mem_iUnion.mpr ⟨j, s, hs, rfl⟩
  -- one arc holds branch points in every wedge
  have hpig : ∃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ ball x ρ₀).Nonempty}, ∀ N > 0, ∃ s ∈ Ioo 0 r₀,
      branchPt x (G.β j) (G.κ j) s ∈ a.carrier ∧ branchPt x (G.β j) (G.κ j) s ∈ Rgn x (e (G.β j)) N m := by
    by_contra hcon
    push Not at hcon
    have ev : ∀ᶠ N in atTop, ∀ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ ball x ρ₀).Nonempty}, ∀ s ∈ Ioo 0 r₀,
        branchPt x (G.β j) (G.κ j) s ∈ a.carrier → branchPt x (G.β j) (G.κ j) s ∉ Rgn x (e (G.β j)) N m := by
      refine (eventually_all_finite hG.fin).mpr fun a ha => ?_
      obtain ⟨N₁, -, h⟩ := hcon a ha
      filter_upwards [eventually_ge_atTop N₁] with N hN s hs hsa hsR
      exact h s hs hsa (Rgn_mono hN hsR)
    obtain ⟨N, hNge, hNev⟩ := ((eventually_ge_atTop N₀).and ev).exists
    obtain ⟨s, hsR, hs⟩ := ((branchPt_mem_Rgn x (G.β j) (G.κ j) N hm).and (Ioo_mem_nhdsGT hC.pos)).exists
    obtain ⟨a, ha, hsa⟩ := mem_iUnion₂.mp (hPΓ s hs).1.1.2
    exact hNev a ⟨ha, _, hsa, (hW N hNge).1 hsR⟩ s hs hsa hsR
  obtain ⟨a, ⟨ha, -⟩, happ⟩ := hpig
  obtain ⟨s₀, hs₀, hs₀a, hs₀R⟩ := happ N₀ hN₀
  obtain ⟨hxa, hT⟩ := (hW N₀ le_rfl).2 _ hs₀R a ha hs₀a
  have hnd := F.nondegenerate a ha
  have hb := Arc.curveData_ne hnd hxa
  have hbn : 0 < ‖(a.curveData x).2‖ := norm_pos_iff.mpr hb
  have hκ0 : 0 ≤ (a.curveData x).1 ∧ (a.curveData x).1 ≤ 1 := by
    rcases Arc.curveData_kappa x a with h | h <;> rw [h] <;> norm_num
  -- a wedge inside the chart's ball, below the curve's scale
  set N' : ℝ := max N₀ (max (1 / r₀) (1 / ‖(a.curveData x).2‖)) + 1 with hN'
  have hN'0 : 0 < N' := by
    have := le_max_left N₀ (max (1 / r₀) (1 / ‖(a.curveData x).2‖)); linarith
  have hN'r : 1 / N' ≤ r₀ := by
    have h1 : 1 / r₀ ≤ N' := by
      have := (le_max_left (1 / r₀) (1 / ‖(a.curveData x).2‖)).trans
        (le_max_right N₀ (max (1 / r₀) (1 / ‖(a.curveData x).2‖)))
      linarith
    rw [div_le_iff₀ hN'0]
    have := (div_le_iff₀ hC.pos).mp h1
    linarith
  have hN'b : 1 / N' ≤ ‖(a.curveData x).2‖ := by
    have h1 : 1 / ‖(a.curveData x).2‖ ≤ N' := by
      have := (le_max_right (1 / r₀) (1 / ‖(a.curveData x).2‖)).trans
        (le_max_right N₀ (max (1 / r₀) (1 / ‖(a.curveData x).2‖)))
      linarith
    rw [div_le_iff₀ hN'0]
    have := (div_le_iff₀ hbn).mp h1
    linarith
  have hRball : ∀ w ∈ Rgn x (e (G.β j)) N' m, ‖w - x‖ < 1 / N' := fun w hw => by
    have := Rgn_subset_ball hu1 hN'0 le_rfl m hw
    rwa [mem_ball, dist_eq_norm] at this
  obtain ⟨B, hB, hBR⟩ := Arc.exists_initialPiece_of_approach hnd hxa hm hN'0 hT
    (fun N hN => by
      obtain ⟨s, -, hsa, hsR⟩ := happ N hN
      exact ⟨_, hsa, hsR⟩)
  obtain ⟨γ, ε, hε, hγc, hγ0, hγne, hγη⟩ := hB.exists_param
  obtain ⟨hγB, hγI⟩ := hγη ε ⟨hε, le_rfl⟩
  refine ⟨a, ha, γ '' Icc 0 ε, hγI, ?_⟩
  have hSB : ∀ w ∈ γ '' Ioc 0 ε, w ∈ B ∧ w ≠ x := by
    rintro _ ⟨t, ht, rfl⟩
    exact ⟨hγB ⟨t, Ioc_subset_Icc_self ht, rfl⟩, hγne t ht⟩
  have hSR : ∀ w ∈ γ '' Ioc 0 ε, w ∈ Rgn x (e (G.β j)) N' m := fun w hw =>
    (hBR w (hSB w hw).1).resolve_left (hSB w hw).2
  have hSball : ∀ w ∈ γ '' Ioc 0 ε, w ∈ ball x r₀ := fun w hw => by
    rw [mem_ball, dist_eq_norm]; exact (hRball w (hSR w hw)).trans_le hN'r
  have hSΓ : γ '' Ioc 0 ε ⊆ (F.Γ ∩ ball x r₀) \ {x} := fun w hw =>
    ⟨⟨⟨hC.subdom (hSball w hw), mem_iUnion₂.mpr ⟨a, ha, hB.subset_carrier (hSB w hw).1⟩⟩, hSball w hw⟩,
      (hSB w hw).2⟩
  obtain ⟨l, hl⟩ := hC.exists_branch_of_isPreconnected hdisj (isPreconnected_Ioc.image γ hγc.continuousOn)
    ⟨γ ε, ε, ⟨hε, le_rfl⟩, rfl⟩ hSΓ
  have hlj : l = j := by
    by_contra hne
    have hd0 : 0 < ‖γ ε - x‖ := norm_pos_iff.mpr (sub_ne_zero.mpr (hγne ε ⟨hε, le_rfl⟩))
    have hNd : 0 < max N' (1 / ‖γ ε - x‖) := lt_max_of_lt_left hN'0
    obtain ⟨s, hs, hsa, hsR⟩ := happ (max N' (1 / ‖γ ε - x‖)) hNd
    have hsR' : branchPt x (G.β j) (G.κ j) s ∈ Rgn x (e (G.β j)) N' m := Rgn_mono (le_max_left _ _) hsR
    have hPs : ‖branchPt x (G.β j) (G.κ j) s - x‖ = s := norm_branchPt_sub x _ _ hs.1.le
    have hsd : s < ‖γ ε - x‖ := by
      have h1 := Rgn_subset_ball hu1 hNd le_rfl m hsR
      rw [mem_ball, dist_eq_norm, hPs] at h1
      calc s < 1 / max N' (1 / ‖γ ε - x‖) := h1
        _ ≤ 1 / (1 / ‖γ ε - x‖) := one_div_le_one_div_of_le (by positivity) (le_max_right _ _)
        _ = ‖γ ε - x‖ := one_div_one_div _
    have hsN : s < 1 / N' := by rw [← hPs]; exact hRball _ hsR'
    -- a point of the piece at the same distance
    obtain ⟨t, ht, hts⟩ : ∃ t ∈ Ioc 0 ε, ‖γ t - x‖ = s := by
      have hc : ContinuousOn (fun t => ‖γ t - x‖) (Icc 0 ε) :=
        (continuous_norm.comp (hγc.sub continuous_const)).continuousOn
      obtain ⟨t, ht, hts⟩ := intermediate_value_Icc hε.le hc
        (show s ∈ Icc (‖γ 0 - x‖) (‖γ ε - x‖) by rw [hγ0, sub_self, norm_zero]; exact ⟨hs.1.le, hsd.le⟩)
      refine ⟨t, ⟨lt_of_le_of_ne ht.1 ?_, ht.2⟩, hts⟩
      rintro rfl
      simp only [hγ0, sub_self, norm_zero] at hts
      exact hs.1.ne hts
    have hw : γ t ∈ γ '' Ioc 0 ε := ⟨t, ht, rfl⟩
    obtain ⟨s', hs', hs'w⟩ := hl hw
    have hs's : s' = s := by rw [← hts, ← hs'w, norm_branchPt_sub x _ _ hs'.1.le]
    subst hs's
    have hκs : (a.curveData x).1 * s' < 2 * ‖(a.curveData x).2‖ := by nlinarith [hs.1]
    have hcur1 : branchPt x (G.β j) (G.κ j) s' ∈ curveAt x (a.curveData x).1 (a.curveData x).2 :=
      Arc.carrier_subset_curve hxa hsa
    have hcur2 : γ t ∈ curveAt x (a.curveData x).1 (a.curveData x).2 :=
      Arc.carrier_subset_curve hxa (hB.subset_carrier (hSB _ hw).1)
    obtain ⟨σ₁, hσ₁, h1⟩ := exists_eq_branchPt_curveGerm hκ0.1 hb hcur1 (hPΓ s' hs).2 (by rw [hPs]; exact hκs)
    obtain ⟨σ₂, hσ₂, h2⟩ := exists_eq_branchPt_curveGerm hκ0.1 hb hcur2 (hSB _ hw).2 (by rw [hts]; exact hκs)
    rw [hPs] at h1
    rw [hts] at h2
    have hneq : branchPt x (G.β j) (G.κ j) s' ≠ γ t := fun h =>
      hne (eq_of_branchPt_eq hdisj hs (hs'w.trans h.symm))
    have hboth := not_both_mem_Rgn_curveGerm (v := x) hb hT (a.curveData x).1 s' hN'0 m
    rcases hσ₁ with rfl | rfl <;> rcases hσ₂ with rfl | rfl
    · exact hneq (h1.trans h2.symm)
    · exact hboth ⟨h1 ▸ hsR', h2 ▸ hSR _ hw⟩
    · exact hboth ⟨h2 ▸ hSR _ hw, h1 ▸ hsR'⟩
    · exact hneq (h1.trans h2.symm)
  subst hlj
  rintro _ ⟨t, ht, rfl⟩
  rcases eq_or_lt_of_le ht.1 with h0 | h0
  · left; rw [← h0, hγ0]
  · right; exact hl ⟨t, ⟨h0, ht.2⟩, rfl⟩

/-- **K2**: two consecutive sectors of a chart whose branches never meet at one distance share the branch between them —
an initial piece of an arc of the map, leaving `x` along the direction of the germ between them, in both closures.
(With `K1`'s `τ i ∩ ball x r₀ = G.sector x r₀ i`, in the closures of the two tiles `τ i`, `τ (next i)`.) -/
theorem IsSectorChart.exists_initialPiece_between {n : ℕ} {G : BranchGerms n} {x : ℂ} {r₀ : ℝ}
    (hC : F.IsSectorChart G x r₀) (hdisj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 r₀, e (G.dir i s) ≠ e (G.dir j s))
    (i : Fin n) :
    ∃ α ∈ F.arcs, ∃ B, α.InitialPiece x (G.β (BranchGerms.next i)) B ∧
      B ⊆ closure (G.sector x r₀ i) ∩ closure (G.sector x r₀ (BranchGerms.next i)) := by
  obtain ⟨α, hα, B, hB, hsub⟩ := hC.exists_initialPiece_branch hdisj (BranchGerms.next i)
  have hord := G.dir_lt_nextDir hC.sorted hC.curv hdisj
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  have hxc : ∀ l, x ∈ closure (G.sector x r₀ l) := fun l => by
    have hβ : G.β l ∈ coneAt (G.sector x r₀ l) x := by
      rw [hC.cone r₀ hr₀ l]; exact Icc_subset_angleIcc _ _ ⟨le_rfl, hC.sorted.mono l⟩
    exact mem_closure_of_mem_coneAt hβ
  refine ⟨α, hα, B, hB, fun w hw => ?_⟩
  rcases hsub hw with rfl | ⟨s, hs, rfl⟩
  · exact ⟨hxc _, hxc _⟩
  · exact ⟨IsSectorChart.branchPt_mem_closure_sector_before hord le_rfl i hs,
      IsSectorChart.branchPt_mem_closure_sector_after hord le_rfl (BranchGerms.next i) hs⟩

/-- **K2 at a point of at most three colours** (the form FS116-N3-SEMI's three-tile case reads: "any two of three tiles are
consecutive, so share an edge"): in a valid non-Siamese map simple at a point `x` of the domain carrying at most three
colours, any two distinct tiles of `x` share an initial piece of an arc of the map leaving `x`, in both closures — the
hypothesis of `isRingArc_of_edge`. (The class of the wave's rows; inhabitants: the module docstring.) -/
theorem exists_initialPiece_of_ncard_le_three (hF : F.Valid) (hN : F.NonSiamese) {x : ℂ} (hx : x ∈ F.dom)
    (hS : F.SimpleOn {x}) (h3 : (F.coloursAt x).ncard ≤ 3) {T₁ T₂ : Set ℂ} (h₁ : F.TileAt x T₁) (h₂ : F.TileAt x T₂)
    (hne : T₁ ≠ T₂) : ∃ α ∈ F.arcs, ∃ δ B, α.InitialPiece x δ B ∧ B ⊆ closure T₁ ∩ closure T₂ := by
  have h2 : 2 ≤ (F.coloursAt x).ncard := by
    rw [← ncard_tileAt_eq hF hN hx]
    exact (Set.one_lt_ncard (finite_tileAt hx)).mpr ⟨T₁, h₁, T₂, h₂, hne⟩
  obtain ⟨r₀, G, hC, hdisj, τ, -, htile, hinter, -⟩ := exists_sectorChart_tileAt hF hN hx hS rfl h2
  obtain ⟨a, rfl⟩ := (htile T₁).mp h₁
  obtain ⟨b, rfl⟩ := (htile T₂).mp h₂
  have hab : a ≠ b := fun h => hne (h ▸ rfl)
  have hτ : ∀ l, closure (G.sector x r₀ l) ⊆ closure (τ l) := fun l =>
    closure_mono (by rw [← hinter l]; exact inter_subset_left)
  rcases BranchGerms.next_adj _ h3 a b hab with h | h
  · obtain ⟨α, hα, B, hB, hsub⟩ := hC.exists_initialPiece_between hdisj a
    exact ⟨α, hα, _, B, hB, fun w hw => ⟨hτ a (hsub hw).1, hτ b (h ▸ (hsub hw).2)⟩⟩
  · obtain ⟨α, hα, B, hB, hsub⟩ := hC.exists_initialPiece_between hdisj b
    exact ⟨α, hα, _, B, hB, fun w hw => ⟨hτ a (h ▸ (hsub hw).2), hτ b (hsub hw).1⟩⟩

end ArcMap

/-! ## Spec examples and inhabitants -/

/-- C1 on numbers: `[1, 2]` lies in the translates of `[0, 3]`, an interval shorter than `2π`, so in one of them. -/
example : ∃ m : ℤ, (0 : ℝ) + 2 * π * m ≤ 1 ∧ (2 : ℝ) ≤ 3 + 2 * π * m :=
  exists_int_of_angleIcc_subset (by norm_num) (by linarith [Real.pi_gt_three]) fun x hx => by
    obtain ⟨m, h1, h2⟩ := mem_iUnion.mp hx
    exact mem_iUnion.mpr ⟨m, by linarith, by linarith⟩

/-- **Adversary** for C1's length hypothesis: with `hi = lo + 2π` the translates cover every direction, and an interval
across a seam (`[π, 3π]` in the translates of `[0, 2π]`) lies in no single one. -/
example : ¬ ∃ m : ℤ, (0 : ℝ) + 2 * π * m ≤ π ∧ 3 * π ≤ 2 * π + 2 * π * m := by
  rintro ⟨m, h1, h2⟩
  have hπ := Real.pi_pos
  have h3 : (m : ℝ) < 1 := by nlinarith
  have h4 : (0 : ℝ) < m := by nlinarith
  have h3' : m < 1 := by exact_mod_cast h3
  have h4' : 0 < m := by exact_mod_cast h4
  omega

/-- C2 reads both bounds: `m = 1` fails the upper one. -/
example : ¬ (2 * π * (((1 : ℤ) : ℝ)) < 2 * π) := by simp

/-- **Inhabitant of K1**: `halfDisc` is simple at `0` and has a sector chart there with a germ; its tiles at `0` are the
chart's sectors, one each. -/
example : ∃ r₀ n, ∃ G : BranchGerms n, halfDisc.IsSectorChart G 0 r₀ ∧ 0 < n ∧
    ∃ τ : Fin n → Set ℂ, Function.Injective τ ∧ (∀ T, halfDisc.TileAt 0 T ↔ ∃ i, τ i = T) ∧
      ∀ i, coneAt (τ i) 0 = angleIcc (G.β i) (G.nextβ i) := by
  obtain ⟨r₀, n, G, hC, hn⟩ := halfDisc_sectorChart
  obtain ⟨τ, hinj, htile, -, hcone⟩ := hC.tileAt_equiv hn (halfDisc_simpleOn _)
  exact ⟨r₀, n, G, hC, hn, τ, hinj, htile, hcone⟩

/-- **Inhabitant of K2**: `halfDisc` at `0`, a chart whose branches never meet at one distance (`localSectors_disj`) —
its first branch is an initial piece of an arc of the map, shared by the closures of two consecutive sectors. -/
example : ∃ r₀ n, ∃ G : BranchGerms n, ∃ i : Fin n, ∃ α ∈ halfDisc.arcs, ∃ B,
    α.InitialPiece 0 (G.β (BranchGerms.next i)) B ∧
      B ⊆ closure (G.sector 0 r₀ i) ∩ closure (G.sector 0 r₀ (BranchGerms.next i)) := by
  have h0 : (0 : ℂ) ∈ halfDisc.dom := by
    show (0 : ℂ) ∈ ball 0 (1 / 3); simp
  obtain ⟨r₀, n, G, hC, hdisj⟩ := localSectors_disj halfDisc h0
  have hn : 0 < n := hC.mem_Γ.mp ⟨h0, by
    rw [halfDisc_arcs_union]; exact mem_segment_of_im_eq_zero (by simp) (by simp)⟩
  obtain ⟨α, hα, B, hB, hsub⟩ := hC.exists_initialPiece_between hdisj ⟨0, hn⟩
  exact ⟨r₀, n, G, ⟨0, hn⟩, α, hα, B, hB, hsub⟩

end HadwigerNelson.Plane
