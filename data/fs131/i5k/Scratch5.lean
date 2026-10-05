import Proofs.HadwigerNelson.Plane.ValidMap.Terminal

namespace HadwigerNelson.Plane
open Complex Real Set Filter Topology Metric

/-- An arc of directions inside the closed lower half-turn `[α + π, α + 2π]` whose arc meets no interior direction of it is one of its two
ends: the single direction `α + π` or `α` (E5 § 3.5's "a horn along `+a` or `−a`"; `angle_pinch` without U1). -/
theorem angle_pinch_ends {α b b' : ℝ} {m : ℤ} (hbb : b ≤ b')
    (hsub : angleIcc b b' ⊆ angleIcc (α + π) (α + 2 * π))
    (hdisj : Disjoint (angleIcc b b') (angleIoo (α + π + 2 * π * m) (α + 2 * π + 2 * π * m))) :
    b' = b ∧ ∃ m' : ℤ, b = α + π + 2 * π * m' ∨ b = α + 2 * π + 2 * π * m' := by
  have hπ := Real.pi_pos
  have key : ∀ x ∈ Icc b b', ∃ k : ℤ, x = α + π + 2 * π * k ∨ x = α + 2 * π + 2 * π * k := by
    intro x hx
    have hxI := Icc_subset_angleIcc b b' hx
    obtain ⟨k, hk1, hk2⟩ := mem_iUnion.mp (hsub hxI)
    refine ⟨k, ?_⟩
    by_contra hne
    push Not at hne
    have hlt : α + π + 2 * π * k < x := lt_of_le_of_ne hk1 (Ne.symm hne.1)
    have hlt' : x < α + 2 * π + 2 * π * k := lt_of_le_of_ne hk2 hne.2
    refine Set.disjoint_left.mp hdisj hxI (mem_iUnion.mpr ⟨k - m, ?_, ?_⟩) <;> push_cast <;> nlinarith
  obtain ⟨k₀, hk₀⟩ := key b ⟨le_rfl, hbb⟩
  refine ⟨?_, k₀, hk₀⟩
  by_contra hne
  have hlt : b < b' := lt_of_le_of_ne hbb (Ne.symm hne)
  set x := b + min (b' - b) π / 2 with hx
  have hm0 : 0 < min (b' - b) π := lt_min (by linarith) hπ
  have hm1 := min_le_right (b' - b) π
  obtain ⟨k₁, hk₁⟩ := key x ⟨by rw [hx]; linarith, by rw [hx]; linarith [min_le_left (b' - b) π]⟩
  -- `x − b ∈ (0, π/2]`, but both are ends, which differ by a multiple of `π`
  have hxb : 0 < x - b ∧ x - b ≤ π / 2 := ⟨by rw [hx]; linarith, by rw [hx]; linarith⟩
  rcases hk₀ with h0 | h0 <;> rcases hk₁ with h1 | h1
  · have a1 : (0 : ℝ) < ((k₁ - k₀ : ℤ) : ℝ) := by push_cast; nlinarith
    have a2 : ((k₁ - k₀ : ℤ) : ℝ) < 1 := by push_cast; nlinarith
    have : 0 < k₁ - k₀ := by exact_mod_cast a1
    have : k₁ - k₀ < 1 := by exact_mod_cast a2
    omega
  · have a1 : (-1 : ℝ) / 2 < ((k₁ - k₀ : ℤ) : ℝ) := by push_cast; nlinarith
    have a2 : ((k₁ - k₀ : ℤ) : ℝ) < 0 := by push_cast; nlinarith
    have : -1 < 2 * (k₁ - k₀) := by have : (-1 : ℝ) < 2 * ((k₁ - k₀ : ℤ) : ℝ) := by linarith
                                    exact_mod_cast this
    have : k₁ - k₀ < 0 := by exact_mod_cast a2
    omega
  · have a1 : (0 : ℝ) < ((k₁ - k₀ : ℤ) : ℝ) := by push_cast; nlinarith
    have a2 : ((k₁ - k₀ : ℤ) : ℝ) < 1 := by push_cast; nlinarith
    have : 0 < k₁ - k₀ := by exact_mod_cast a1
    have : k₁ - k₀ < 1 := by exact_mod_cast a2
    omega
  · have a1 : (0 : ℝ) < ((k₁ - k₀ : ℤ) : ℝ) := by push_cast; nlinarith
    have a2 : ((k₁ - k₀ : ℤ) : ℝ) < 1 := by push_cast; nlinarith
    have : 0 < k₁ - k₀ := by exact_mod_cast a1
    have : k₁ - k₀ < 1 := by exact_mod_cast a2
    omega

/-- A direction `α + 2πk` is outside U1's cone at `S′`. -/
theorem not_mem_angleIcc_S_add {α φ : ℝ} (hφ : 0 < φ) (k : ℤ) : α + 2 * π * k ∉ angleIcc (α + π) (α + 2 * π - φ) := by
  have hπ := Real.pi_pos
  intro h
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp h
  have hm0 : k - m - 1 < 0 := by
    have : ((k - m - 1 : ℤ) : ℝ) < 0 := by push_cast; nlinarith
    exact_mod_cast this
  have h2 : ((k - m - 1 : ℤ) : ℝ) ≤ -1 := by
    have : k - m - 1 ≤ -1 := by omega
    exact_mod_cast this
  push_cast at h2
  nlinarith

namespace ArcMap
variable {k : ℕ} {F : ArcMap k}

/-- **Two sectors of one chart tangent along one direction are ordered by curvature, at the far end** (the mirror of
`nextκ_le_of_disjoint`): if sector `j` is a horn along `e β` and sector `i ≠ j` turns a half-turn and ends at a germ of the same
direction, then `j`'s lower germ curves at least as much as `i`'s last one — else the two sectors meet at small radius. -/
theorem κ_le_of_disjoint_end {P : ℂ} {n : ℕ} {G : BranchGerms n} {r₀ : ℝ} (hC : F.IsSectorChart G P r₀) {i j : Fin n}
    (hij : i ≠ j) (hj : G.nextβ j = G.β j) (hji : e (G.β j) = e (G.nextβ i)) (hi : G.nextβ i = G.β i + π) :
    G.nextκ i ≤ G.κ j := by
  have hπ := Real.pi_pos
  by_contra hlt
  push Not at hlt
  have hκj : G.κ j < G.nextκ j := by
    rcases hC.sorted.2 j with h | h
    · rw [hj] at h; exact absurd h (lt_irrefl _)
    · exact h.2
  set s := r₀ / 2 with hsdef
  have hs0 : 0 < s := by rw [hsdef]; linarith [hC.pos]
  have hsr : s < r₀ := by rw [hsdef]; linarith [hC.pos]
  set x := (G.κ j + min (G.nextκ i) (G.nextκ j)) / 2 with hx
  have hx1 : G.κ j < x := by rw [hx]; linarith [lt_min hlt hκj]
  have hx2 : x < min (G.nextκ i) (G.nextκ j) := by rw [hx]; linarith [lt_min hlt hκj]
  have hx3 := min_le_left (G.nextκ i) (G.nextκ j)
  have hx4 := min_le_right (G.nextκ i) (G.nextκ j)
  have hbi := abs_half_lt_one (hC.curv i) hs0.le hsr
  have hbj := abs_half_lt_one (hC.curv j) hs0.le hsr
  have hbn := abs_half_lt_one (hC.curv (BranchGerms.next j)) hs0.le hsr
  have hbni := abs_half_lt_one (hC.curv (BranchGerms.next i)) hs0.le hsr
  rw [← BranchGerms.nextκ_eq] at hbn hbni
  rw [abs_lt] at hbi hbj hbn hbni
  have hxs1 : -1 ≤ x * s / 2 := by nlinarith
  have hxs2 : x * s / 2 ≤ 1 := by nlinarith
  have haj : Real.arcsin (G.κ j * s / 2) < Real.arcsin (x * s / 2) :=
    Real.arcsin_lt_arcsin hbj.1.le (by nlinarith) hxs2
  have han : Real.arcsin (x * s / 2) < Real.arcsin (G.nextκ j * s / 2) :=
    Real.arcsin_lt_arcsin hxs1 (by nlinarith) hbn.2.le
  have hani : Real.arcsin (x * s / 2) < Real.arcsin (G.nextκ i * s / 2) :=
    Real.arcsin_lt_arcsin hxs1 (by nlinarith) hbni.2.le
  have hxpi := Real.neg_pi_div_two_le_arcsin (x * s / 2)
  have hai : Real.arcsin (G.κ i * s / 2) < π / 2 := by rw [Real.arcsin_lt_pi_div_two]; linarith
  set y := P + (s : ℂ) * e (G.β j + Real.arcsin (x * s / 2)) with hy
  have hyj : y ∈ G.sector P r₀ j :=
    ⟨s, ⟨hs0, hsr⟩, G.β j + Real.arcsin (x * s / 2), ⟨by linarith, by rw [hj]; linarith⟩, rfl⟩
  have hey : e (G.β j + Real.arcsin (x * s / 2)) = e (G.nextβ i + Real.arcsin (x * s / 2)) := by
    rw [e_add, e_add, hji]
  have hyi : y ∈ G.sector P r₀ i :=
    ⟨s, ⟨hs0, hsr⟩, G.nextβ i + Real.arcsin (x * s / 2), ⟨by rw [hi]; linarith, by linarith⟩, by rw [hy, hey]⟩
  exact Set.disjoint_left.mp (hC.disjoint r₀ ⟨hC.pos, le_rfl⟩ i j hij) hyi hyj

/-- **A point of the lower half-disc sector on the `+a` side lies below its last germ** (the mirror of `tanBelow_of_mem_sector`: a germ
of direction `α` and curvature `κ` is the arc of upward curvature `κ` in the frame at `α`). -/
theorem tanBelow_of_mem_sector_end {P : ℂ} {α : ℝ} {n : ℕ} {G : BranchGerms n} {r₀ : ℝ} (hC : F.IsSectorChart G P r₀)
    {i : Fin n} {m : ℤ} (hβ : G.nextβ i = α + 2 * π * m) (hnb : G.nextβ i = G.β i + π) {r : ℝ} (hr : r ∈ Ioc 0 r₀)
    {y : ℂ} (hy : y ∈ G.sector P r i) (hx : 0 < frameX P α y) : TanBelow P α (G.nextκ i) y := by
  have hπ := Real.pi_pos
  obtain ⟨s, hs, φ, hφ, rfl⟩ := hy
  obtain ⟨hX, hY⟩ := frame_polar P α s φ
  have hb := abs_half_lt_one (hC.curv (BranchGerms.next i)) hs.1.le (lt_of_lt_of_le hs.2 hr.2)
  rw [← BranchGerms.nextκ_eq] at hb
  rw [abs_lt] at hb
  set θ := φ - G.nextβ i with hθ
  have hφα : φ - α = θ + 2 * π * m := by rw [hθ, hβ]; ring
  have hcos : Real.cos (φ - α) = Real.cos θ := by
    rw [hφα, show θ + 2 * π * (m : ℝ) = θ + (m : ℤ) * (2 * π) by ring, Real.cos_add_int_mul_two_pi]
  have hsin : Real.sin (φ - α) = Real.sin θ := by
    rw [hφα, show θ + 2 * π * (m : ℝ) = θ + (m : ℤ) * (2 * π) by ring, Real.sin_add_int_mul_two_pi]
  have hθ1 : -π + Real.arcsin (G.κ i * s / 2) < θ := by rw [hθ, hnb]; linarith [hφ.1]
  have hθ2 : θ < Real.arcsin (G.nextκ i * s / 2) := by rw [hθ]; linarith [hφ.2]
  have ha1 := Real.neg_pi_div_two_le_arcsin (G.κ i * s / 2)
  have ha2 := Real.arcsin_le_pi_div_two (G.nextκ i * s / 2)
  have hcθ : 0 < Real.cos θ := by
    rw [hX, hcos] at hx; nlinarith [hs.1]
  have hθ3 : -(π / 2) < θ := by
    by_contra hge; push Not at hge
    have : Real.cos θ ≤ 0 := by
      have := Real.cos_nonpos_of_pi_div_two_le_of_le (x := -θ) (by linarith) (by linarith)
      rwa [Real.cos_neg] at this
    linarith
  have hsinθ : Real.sin θ < G.nextκ i * s / 2 := by
    have := Real.sin_lt_sin_of_lt_of_le_pi_div_two hθ3.le ha2 hθ2
    rwa [Real.sin_arcsin hb.1.le hb.2.le] at this
  unfold TanBelow tanHeight
  rw [hX, hY, hcos, hsin]
  have hs2 : (s * Real.cos θ) ^ 2 + (s * Real.sin θ) ^ 2 = s ^ 2 := by
    nlinarith [Real.sin_sq_add_cos_sq θ]
  rw [hs2]
  nlinarith [hs.1]

/-- **A horn sector along `+a` reaches the point above every arc of upward curvature `κ` with `κ` at most its lower germ's curvature**
(on the `+a` side, arbitrarily near the point; the mirror of `exists_tanAbove_of_sector`). -/
theorem exists_tanAbove_of_sector_end {P : ℂ} {α κ : ℝ} {n : ℕ} {G : BranchGerms n} {r₀ : ℝ}
    (hC : F.IsSectorChart G P r₀) {j : Fin n} {m : ℤ} (hβ : G.β j = α + 2 * π * m) (hnb : G.nextβ j = G.β j)
    (hκ : κ ≤ G.κ j) {r : ℝ} (hr : r ∈ Ioc 0 r₀) :
    ∀ ρ > 0, ∃ y ∈ G.sector P r j, dist y P < ρ ∧ 0 < frameX P α y ∧ TanAbove P α κ y := by
  intro ρ hρ
  have hπ := Real.pi_pos
  set s := min ρ r / 2 with hsdef
  have hs0 : 0 < s := by have := lt_min hρ hr.1; rw [hsdef]; linarith
  have hsr : s < r := by rw [hsdef]; linarith [min_le_right ρ r, hr.1]
  have hsρ : s < ρ := by rw [hsdef]; linarith [min_le_left ρ r, hρ]
  have hκj : G.κ j < G.nextκ j := by
    rcases hC.sorted.2 j with h | h
    · rw [hnb] at h; exact absurd h (lt_irrefl _)
    · exact h.2
  have hb1 := abs_half_lt_one (hC.curv j) hs0.le (lt_of_lt_of_le hsr hr.2)
  have hb2 := abs_half_lt_one (hC.curv (BranchGerms.next j)) hs0.le (lt_of_lt_of_le hsr hr.2)
  rw [← BranchGerms.nextκ_eq] at hb2
  rw [abs_lt] at hb1 hb2
  set A := Real.arcsin (G.κ j * s / 2) with hA
  set B := Real.arcsin (G.nextκ j * s / 2) with hB
  have hAB : A < B := Real.arcsin_lt_arcsin hb1.1.le (by nlinarith) hb2.2.le
  have hA1 : -(π / 2) < A := by rw [hA, Real.neg_pi_div_two_lt_arcsin]; linarith
  have hB1 : B < π / 2 := by rw [hB, Real.arcsin_lt_pi_div_two]; linarith
  set θ := (A + B) / 2 with hθ
  set φ := G.β j + θ with hφ
  obtain ⟨hX, hY⟩ := frame_polar P α s φ
  have hφα : φ - α = θ + 2 * π * m := by rw [hφ, hβ]; ring
  have hcos : Real.cos (φ - α) = Real.cos θ := by
    rw [hφα, show θ + 2 * π * (m : ℝ) = θ + (m : ℤ) * (2 * π) by ring, Real.cos_add_int_mul_two_pi]
  refine ⟨P + (s : ℂ) * e φ, ⟨s, ⟨hs0, hsr⟩, φ, ⟨by rw [hφ, hθ]; linarith, by rw [hnb, hφ, hθ]; linarith⟩, rfl⟩,
    ?_, ?_, ?_⟩
  · rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hs0,
      mul_one]
    exact hsρ
  · rw [hX, hcos]
    have : 0 < Real.cos θ := Real.cos_pos_of_mem_Ioo ⟨by rw [hθ]; linarith, by rw [hθ]; linarith⟩
    nlinarith
  · have hsin : Real.sin (φ - α) = Real.sin θ := by
      rw [hφα, show θ + 2 * π * (m : ℝ) = θ + (m : ℤ) * (2 * π) by ring, Real.sin_add_int_mul_two_pi]
    have hsinθ : G.κ j * s / 2 < Real.sin θ := by
      have := Real.sin_lt_sin_of_lt_of_le_pi_div_two hA1.le (by rw [hθ]; linarith) (show A < θ by rw [hθ]; linarith)
      rwa [hA, Real.sin_arcsin hb1.1.le hb1.2.le] at this
    have hκs : κ * s / 2 ≤ G.κ j * s / 2 := by nlinarith
    unfold TanAbove tanHeight
    rw [hX, hY, hcos, hsin]
    have hs2 : (s * Real.cos θ) ^ 2 + (s * Real.sin θ) ^ 2 = s ^ 2 := by
      nlinarith [Real.sin_sq_add_cos_sq θ]
    rw [hs2]
    nlinarith

theorem flank_two_sectors_at_S_gen (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {α κ₁ κ₂ κ₃ κ₄ : ℝ} {c g : Fin k}
    (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α κ₁ κ₂ c)
    (Hd : F.IsHorn v (α + π) κ₃ κ₄ c) (h1 : -1 ≤ κ₁) (h2 : κ₂ ≤ 1) (h3' : -1 ≤ κ₃) (h4 : κ₄ ≤ 1)
    (hgu : F.IsFlankAbove v α κ₂ g)
    (hno : ¬ (F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)))) :
    ∀ᶠ r in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf (v - e (α + π / 2)) r g).encard := by
  have hπ := Real.pi_pos
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  have hv := hvC v
  set S := v - e (α + π / 2) with hSdef
  set N := v + e (α + π / 2) with hNdef
  obtain ⟨hcN, hcS⟩ := horn_poles_contact hF hv hst.1 le_rfl hc2 hH
  obtain ⟨g₀, h, -, -, -, hgc₀, -, hg₀u, hhu, hhd, hgd₀, -⟩ :=
    stuck_flanks_ua hF hv hst h3.le hH Hd h1 h2 h3' h4 hc2 hcN hcS
  have hgg₀ : g₀ = g := hg₀u.unique hgu
  have hgc : g ≠ c := hgg₀ ▸ hgc₀
  have hgd : F.IsFlankBelow v (α + π) κ₃ g := hgg₀ ▸ hgd₀
  have hgv : g ∈ F.coloursAt v := mem_closure_of_mem_coneAt hgu.mem_coneAt
  have hNv : dist N v = 1 := by rw [hNdef, dist_eq_norm, add_sub_cancel_left, norm_e]
  -- `N` is not in `g`'s closure when a bound reaches `ω(N)` from the `g` side
  have hNg : κ₂ = 1 ∨ κ₃ = -1 → N ∉ closure (F.region g) := by
    intro hκ hNcl
    have hcont : F.IsContact v g N := ⟨hgv, hNv, hNcl⟩
    rcases (contact_inType_or_outType hF hv hcont).1 with hin | hout
    · exact hno ⟨hcont, hin⟩
    · rcases hκ with hκ | hκ
      · subst hκ; exact not_outType_N_of_flankAbove_one hF hv hgu hNcl hout
      · subst hκ
        have := not_outType_S_of_flankBelow_neg_one hF hv hgd (by rw [sub_e_add_pi_add]; exact hNcl)
        rw [sub_e_add_pi_add] at this
        exact this hout
  -- the `g`-shadow on both horns (no SHAVE), localized at `S′`
  obtain ⟨shH, -⟩ := shadow_of_not_shave hst.2.2.1 hH hgu hhu
  obtain ⟨-, shHd⟩ := shadow_of_not_shave hst.2.2.1 Hd hhd hgd
  have L1 : ∀ δ > 0, ∃ ρ > 0, ∀ z ∈ hornSet v α κ₁ κ₂ ρ, ∀ y ∈ F.region g, dist z y = 1 → dist y S < δ := by
    intro δ hδ
    obtain ⟨ρ, hρ, hL⟩ := witness_near_S_upper hF hv h2 hgu (fun h => hNg (Or.inl h)) hδ
    exact ⟨ρ, hρ, fun z hz => hL z (hornSet_mono h1 le_rfl hz)⟩
  have L2 := fun δ (hδ : 0 < δ) => witness_near_S_lower hF hv h3' h4 hgd (fun h => hNg (Or.inr h)) hδ
  -- `g` is out-type at `S′`
  have hgS : F.IsContact v g S ∧ F.OutType v g S := by
    rcases srcG_of_shadow hF hv h1 hH.1 h2 hgu shH with hin | hout
    · exact absurd hin hno
    · exact hout
  -- the sector chart at `S′`
  obtain ⟨r₀, n, G, hC⟩ := localSectors F (hvC S (mem_closedBall_self zero_le_one))
  have hcSc : c ∈ F.coloursAt S := hcS.1.2.2
  have hgSc : g ∈ F.coloursAt S := hgS.1.2.2
  have hn : 0 < n := by
    rw [← hC.mem_Γ]
    by_contra hΓ
    have hSi : S ∈ F.interiorPts := ⟨hvC S (mem_closedBall_self zero_le_one), fun hS => hΓ ⟨hvC S
      (mem_closedBall_self zero_le_one), hS⟩⟩
    have h1 := coloursAt_eq_of_mem_interiorPts hSi
    rw [h1] at hcSc hgSc
    exact hgc (hgSc.trans hcSc.symm)
  have hfar := far_of_outType_chart hgS.2 hC hn
  have hfar' : ∃ r > 0, ∀ y ∈ F.region g, dist y S < r → 1 < dist y v := ⟨r₀, hC.pos, hfar⟩
  have hfarc := far_of_outType_chart hcS.2 hC hn
  -- the witnesses, with their directions
  have W1 := exists_witness_dir (v := v) (α := α) (Or.inl rfl) (H := fun ρ => hornSet v α κ₁ κ₂ ρ)
    (W := F.region g) (fun ρ z hz => ⟨hz.1, by rw [one_mul]; exact hz.2.1, abs_frameY_le_of_mem_hornSet h1 h2 hz,
      (tanAbove_neg_one_iff v α z).mp (hz.2.2.1.mono h1)⟩)
    (fun ρ ρ' h => hornSet_mono_radius h) shH L1 hfar'
  have W2 := exists_witness_dir (v := v) (α := α) (Or.inr rfl) (H := fun ρ => hornSet v (α + π) κ₃ κ₄ ρ)
    (W := F.region g) (fun ρ z hz => ⟨hz.1, by have := hz.2.1; rw [frameX_add_pi] at this; linarith,
      by have := abs_frameY_le_of_mem_hornSet h3' h4 hz; rwa [frameY_add_pi, abs_neg] at this,
      by have := (tanBelow_one_iff v (α + π) z).mp (hz.2.2.2.mono h4); rwa [add_e_add_pi_add] at this⟩)
    (fun ρ ρ' h => hornSet_mono_radius h) shHd L2 hfar'
  have hαg : α ∈ coneAt (F.region g) S := by
    intro ε hε
    obtain ⟨y, hy, -, -, -, hyS, hyε, -, hdir⟩ := W1 ε hε 1 one_pos
    refine ⟨y, hy, hyS, hyε, ?_⟩
    simpa using hdir
  have hαπg : α + π ∈ coneAt (F.region g) S := by
    intro ε hε
    obtain ⟨y, hy, -, -, -, hyS, hyε, -, hdir⟩ := W2 ε hε 1 one_pos
    refine ⟨y, hy, hyS, hyε, ?_⟩
    rw [e_add_pi]
    simpa using hdir
  -- suppose `g` had at most one sector at some small radius
  by_contra hcon
  obtain ⟨r, hrlt, hr⟩ := ((not_eventually.mp hcon).and_eventually (Ioc_mem_nhdsGT hC.pos)).exists
  push Not at hrlt
  -- the indices of `g`'s sectors
  set gI : Set (Fin n) := {i | ∀ r' ∈ Ioc 0 r₀, G.sector S r' i ⊆ F.region g} with hgI
  have hgIu : ∀ i ∈ gI, ∀ i' ∈ gI, i = i' := by
    intro i hi i' hi'
    by_contra hne
    have hmem : ∀ j ∈ gI, G.sector S r j ∈ F.sectorsOf S r g := fun j hj =>
      ⟨(hC.isSector_iff hn hr).mpr ⟨j, rfl⟩, fun z hz => (hj r hr hz).2⟩
    have hne' : G.sector S r i ≠ G.sector S r i' := by
      intro heq
      obtain ⟨z, hz⟩ := hC.sector_nonempty hr i
      exact Set.disjoint_left.mp (hC.disjoint r hr i i' hne) hz (heq ▸ hz)
    have : 2 ≤ (F.sectorsOf S r g).encard := by
      rw [show (2 : ℕ∞) = ({G.sector S r i, G.sector S r i'} : Set (Set ℂ)).encard by
        rw [encard_pair hne']]
      exact encard_le_encard (by
        intro T hT; rcases hT with rfl | rfl
        · exact hmem i hi
        · exact hmem i' hi')
    exact absurd this (not_le.mpr hrlt)
  have hcolI : ∀ y ∈ F.region g, dist y S < r → ∃ i ∈ gI, y ∈ G.sector S r i := by
    intro y hy hyr
    have hyc : y ∈ ball S r ∩ F.interiorPts := ⟨hyr, hy.1⟩
    rw [hC.cover r hr hn] at hyc
    obtain ⟨i, hi⟩ := mem_iUnion.mp hyc
    obtain ⟨g', hg'⟩ := hC.exists_col i
    have hgg : g' = g := ((hg' r hr hi).2).symm.trans hy.2
    exact ⟨i, fun r' hr' => hgg ▸ hg' r' hr', hi⟩
  have hconeI : ∀ β ∈ coneAt (F.region g) S, ∃ i ∈ gI, β ∈ angleIcc (G.β i) (G.nextβ i) := by
    intro β hβ
    have h1 := coneAt_inter_ball hr.1 hβ
    have h2 : F.region g ∩ ball S r ⊆ ⋃ i ∈ gI, G.sector S r i := by
      intro y ⟨hy, hyr⟩
      obtain ⟨i, hi, hyi⟩ := hcolI y hy hyr
      exact mem_iUnion₂.mpr ⟨i, hi, hyi⟩
    obtain ⟨i, hi, hβi⟩ := coneAt_biUnion_finite (Set.toFinite gI) _ (coneAt_mono h2 S h1)
    exact ⟨i, hi, by rwa [hC.cone r hr i] at hβi⟩
  obtain ⟨i₀, hi₀, hαi⟩ := hconeI α hαg
  obtain ⟨i₁, hi₁, hαπi⟩ := hconeI (α + π) hαπg
  obtain rfl := hgIu i₀ hi₀ i₁ hi₁
  have hM := hC.sorted.mono
  -- `g`'s sector is the lower half-disc: its cone is `[α + π, α + 2π]`
  have hcone0 : angleIcc (G.β i₀) (G.nextβ i₀) ⊆ angleIcc (α + π) (α + 2 * π) := by
    rw [← hC.cone r hr i₀]
    exact coneAt_subset_of_far ⟨r, hr.1, fun y hy hyr => (hfar y (hi₀ r hr hy) (lt_of_lt_of_le hyr hr.2)).le⟩
  obtain ⟨m, hβ0, hnβ0⟩ := angleIcc_eq_lower_half (hM i₀) hcone0 hαi hαπi
  -- a sector of `c` at `S′`
  obtain ⟨y₁, hy₁, hy₁S⟩ := Metric.mem_closure_iff.mp hcSc r hr.1
  obtain ⟨j, hj⟩ : ∃ j, y₁ ∈ G.sector S r j := by
    have hyc : y₁ ∈ ball S r ∩ F.interiorPts := ⟨by rw [mem_ball, dist_comm]; exact hy₁S, hy₁.1⟩
    rw [hC.cover r hr hn] at hyc
    exact mem_iUnion.mp hyc
  obtain ⟨c', hc'⟩ := hC.exists_col j
  have hcc : c' = c := ((hc' r hr hj).2).symm.trans hy₁.2
  subst hcc
  have hji : i₀ ≠ j := by
    rintro rfl
    exact hgc (((hi₀ r hr hj).2).symm.trans hy₁.2)
  have hconej : angleIcc (G.β j) (G.nextβ j) ⊆ coneAt (F.region c') S := by
    rw [← hC.cone r hr j]; exact coneAt_mono (hc' r hr) S
  have hcfar : coneAt (F.region c') S ⊆ angleIcc (α + π) (α + 2 * π) :=
    coneAt_subset_of_far ⟨r₀, hC.pos, fun y hy hyr => (hfarc y hy hyr).le⟩
  have hdisj := hM.disjoint hji
  rw [hβ0, hnβ0] at hdisj
  obtain ⟨hjj, m', hβj | hβj⟩ := angle_pinch_ends (hM j) (hconej.trans hcfar) hdisj
  all_goals have hβjmem : G.β j ∈ angleIcc (G.β j) (G.nextβ j) := Icc_subset_angleIcc _ _ ⟨le_rfl, hM j⟩
  rotate_left
  · -- a `c`-horn along `+a` at `S′`: SEP with the `+a` horn (`κ₁ > −1`), or U1 on its arc of `ω(S′)` (`κ₁ = −1`)
    rcases lt_or_eq_of_le h1 with h1' | h1'
    · have hκ := κ_le_of_disjoint_end hC hji hjj (by rw [hβj, hnβ0, e_add_int_mul, e_add_int_mul])
        (by rw [hnβ0, hβ0]; ring)
      obtain ⟨r', hr'c, hr'0⟩ := ((hH.eventually_subset_region.and (Ioc_mem_nhdsGT (by norm_num : (0 : ℝ) < 1 / 2))).and
        self_mem_nhdsWithin).exists
      obtain ⟨y₀, hy₀g, z₀, hz₀, hz₀y₀, -, hy₀S, hy₀X, -⟩ := W1 r hr.1 r' hr'0
      obtain ⟨i', hi', hy₀i⟩ := hcolI y₀ hy₀g hy₀S
      obtain rfl := hgIu i' hi' i₀ hi₀
      have hy₀X' : 0 < frameX S α y₀ := by rw [frameX_base_S]; linarith
      have hy₀T := tanBelow_of_mem_sector_end hC (m := m + 1) (by rw [hnβ0]; push_cast; ring)
        (by rw [hnβ0, hβ0]; ring) hr hy₀i hy₀X'
      have hK := exists_tanAbove_of_sector_end (α := α) hC (m := m' + 1) (by rw [hβj]; push_cast; ring) hjj hκ hr
      obtain ⟨y, hyK, z, hz, hyz⟩ := sep_S h1' hH.1 h2 hr'0 hr'c.2.2 ⟨z₀, hz₀, by rw [dist_comm]; exact hz₀y₀⟩
        hy₀T (K := G.sector S r j) (fun ρ hρ => by
          obtain ⟨y, hy, hyρ, hyX, hyT⟩ := hK ρ hρ
          exact ⟨y, hy, hyρ, by rw [← frameX_base_S]; exact hyX, hyT⟩)
      have hyc := hc' r hr hyK
      have hzc := hr'c.1 hz
      exact hF y hyc.1 z hzc.1 hyz (hyc.2.trans hzc.2.symm)
    · subst h1'
      obtain ⟨φ, hφ, -, hU1⟩ := coneAt_S_subset_of_horn hF hH h2
      have hmem := hU1 (hconej hβjmem)
      rw [hβj, show α + 2 * π + 2 * π * (m' : ℝ) = α + 2 * π * ((m' + 1 : ℤ) : ℝ) by push_cast; ring] at hmem
      exact not_mem_angleIcc_S_add hφ (m' + 1) hmem
  rcases lt_or_eq_of_le h4 with h4' | h4'
  · -- `κ₄ < 1`: SEP at `S′` with the `−a` horn
    have hκ := nextκ_le_of_disjoint hC hji hjj (by rw [hβj, hβ0, e_add_int_mul, e_add_int_mul])
      (by rw [hnβ0, hβ0]; ring)
    obtain ⟨r', hr'c, hr'0⟩ := ((Hd.eventually_subset_region.and (Ioc_mem_nhdsGT (by norm_num : (0 : ℝ) < 1 / 2))).and
      self_mem_nhdsWithin).exists
    obtain ⟨y₀, hy₀g, z₀, hz₀, hz₀y₀, -, hy₀S, hy₀X, -⟩ := W2 r hr.1 r' hr'0
    obtain ⟨i', hi', hy₀i⟩ := hcolI y₀ hy₀g hy₀S
    obtain rfl := hgIu i' hi' i₀ hi₀
    have hy₀X' : frameX S α y₀ < 0 := by rw [frameX_base_S]; linarith
    have hy₀T := tanBelow_of_mem_sector hC hβ0 (by rw [hnβ0, hβ0]; ring) hr hy₀i hy₀X'
    have hK := exists_tanAbove_of_sector (α := α) hC hβj hjj hκ hr
    obtain ⟨y, hyK, z, hz, hyz⟩ := sep_add_pi_S h3' Hd.1 h4' hr'0 hr'c.2.2 ⟨z₀, hz₀, by rw [dist_comm]; exact hz₀y₀⟩
      hy₀T (K := G.sector S r j) (fun ρ hρ => by
        obtain ⟨y, hy, hyρ, hyX, hyT⟩ := hK ρ hρ
        exact ⟨y, hy, hyρ, by rw [← frameX_base_S]; exact hyX, hyT⟩)
    have hyc := hc' r hr hyK
    have hzc := hr'c.1 hz
    exact hF y hyc.1 z hzc.1 hyz (hyc.2.trans hzc.2.symm)
  · -- `κ₄ = 1`: U1 on the `−a` horn's arc of `ω(S′)` removes `α + π` from `c`'s cone
    subst h4'
    obtain ⟨φ', hφ', hφ'π, hU1'⟩ := coneAt_N_subset_of_horn hF Hd h3'
    rw [add_e_add_pi_add] at hU1'
    have := hU1' (hconej hβjmem)
    rw [show α + π + π = α + 2 * π by ring] at this
    exact angle_pinch_false hφ' hφ'π ⟨m', hβj⟩ this

theorem isStuck_of_hasRepeatedColour' (hT : F.Terminal) {x : ℂ} (hx : x ∈ F.dom) (hR : F.HasRepeatedColour x) :
    F.IsStuck x := by
  obtain ⟨g, hg⟩ := hR
  obtain ⟨n, hn⟩ := exists_hasSectors hx g
  obtain ⟨r, hr1, hr2⟩ := (hn.and hg).exists
  have h2 : (2 : ℕ∞) ≤ n := hr1 ▸ hr2
  obtain ⟨hM, hRy, hS⟩ := hT x (mem_univ x)
  exact ⟨hM, hRy, hS, g, n, by exact_mod_cast h2, hn⟩

/-- **One colour flanks a horn from below** (the mirror of `IsFlankAbove.unique`): two lower flanks at one bound share the band between it
and the higher of their lower limits. Model of the hypotheses: `bowtie` at `0` (`bowtie_flanks`). -/
theorem IsFlankBelow.unique {v : ℂ} {α κ : ℝ} {h h' : Fin k} (hh : F.IsFlankBelow v α κ h) (hh' : F.IsFlankBelow v α κ h') :
    h = h' := by
  obtain ⟨a, ha, hev⟩ := hh
  obtain ⟨b, hb, hev'⟩ := hh'
  obtain ⟨r, ⟨hr1, hr2⟩, hr0⟩ := ((hev.and hev').and self_mem_nhdsWithin).exists
  have hab := max_lt ha hb
  obtain ⟨z, hz, -, -⟩ := exists_mem_hornSet_aboveBelow v α (κ₁ := max a b) (κ₂ := κ) (s := (max a b + κ) / 2)
    (m := κ + 1) hr0 (by linarith) (by linarith) (by intro h; linarith)
  have z1 := hr1 (hornSet_mono (le_max_left a b) le_rfl hz)
  have z2 := hr2 (hornSet_mono (le_max_right a b) le_rfl hz)
  exact z1.2.symm.trans z2.2

theorem cv_class' {F : ArcMap 6} (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard = 3)
    {c : Fin 6} (hc2 : F.HasSectors E c 2) {α κ₁ κ₂ κ₃ κ₄ : ℝ} (hH : F.IsHorn E α κ₁ κ₂ c)
    (hH' : F.IsHorn E (α + π) κ₃ κ₄ c) {g h : Fin 6} (hg : F.IsFlankAbove E α κ₂ g) (hh : F.IsFlankBelow E α κ₁ h) :
    (κ₂ = 1 ∧ κ₃ = -1 ∧ κ₁ = -1 ∧ κ₄ = 1 ∧
        4 ≤ (F.coloursAt (E + e (α + π / 2))).ncard ∧ 4 ≤ (F.coloursAt (E - e (α + π / 2))).ncard ∧
        (∃ θ₁ θ₂, F.BothKind (E + e (α + π / 2)) θ₁ θ₂) ∧ (∃ θ₁ θ₂, F.BothKind (E - e (α + π / 2)) θ₁ θ₂) ∧
        F.stuckRun E α = {0}) ∨
      ((∀ᶠ r in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf (E - e (α + π / 2)) r g).encard) ∧
        (∀ᶠ r in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf (E + e (α + π / 2)) r h).encard) ∧
        (F.IsStuck (E + e (α + π / 2)) ∨ 4 ≤ (F.coloursAt (E + e (α + π / 2))).ncard) ∧
        (F.IsStuck (E - e (α + π / 2)) ∨ 4 ≤ (F.coloursAt (E - e (α + π / 2))).ncard)) := by
  obtain ⟨hF, hP, hT, -⟩ := hM
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  have hdom : ∀ x, x ∈ F.dom := fun x => by rw [hP]; exact mem_univ x
  obtain ⟨h1, h2⟩ := horn_bounds_of_noMerge hF (hvC E) hst.1 le_rfl hc2 hH
  obtain ⟨h3', h4⟩ := horn_bounds_of_noMerge hF (hvC E) hst.1 le_rfl hc2 hH'
  obtain ⟨hGH, hHυ, hυλ⟩ := cv_hd hM hst h3 hc2 hH hH' hg hh
  by_cases hGN : F.IsContact E g (E + e (α + π / 2)) ∧ F.InType E g (E + e (α + π / 2))
  · -- the bowtie: CV-HD's four conditions, C-DOUBLE's (Q) arcs, the chain clause
    left
    have hHS := hGH.mp hGN
    obtain ⟨hk2, hk3⟩ := hHυ.mp hHS
    obtain ⟨hk1, hk4⟩ := hυλ.mp ⟨hk2, hk3⟩
    subst hk1 hk2 hk3 hk4
    obtain ⟨-, -, hN4, hS4, ⟨θ₂, -, hQN⟩, -, ⟨θ₁, -, hQS⟩, -⟩ := c_double hM hst h3 hc2 hH hH' hg hh
    refine ⟨rfl, rfl, rfl, rfl, hN4, hS4, ?_, ?_, n3_end_chain hF hP hT hst h3 hc2 hH hg hGN⟩
    · obtain ⟨d, d', hR, hd, hd', -⟩ := hQN
      exact ⟨_, _, d, d', hR, hd, hd'⟩
    · obtain ⟨d, d', hR, hd, hd', -⟩ := hQS
      exact ⟨_, _, d, d', hR, hd, hd'⟩
  · -- "None": `g` twice at `S′` (E5 § 3.4 at general bounds), `h` twice at `N` (the same in the turned frame)
    right
    have hHS : ¬ (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2))) := fun hx => hGN (hGH.mpr hx)
    have hgS := flank_two_sectors_at_S_gen hF hP hst h3 hc2 hH hH' h1 h2 h3' h4 hg hGN
    obtain ⟨hcN, hcS⟩ := horn_poles_contact hF (hvC E) hst.1 le_rfl hc2 hH
    obtain ⟨-, h₀, -, -, -, -, -, -, hh₀, hh₀d, -, -⟩ :=
      stuck_flanks_ua hF (hvC E) hst h3.le hH hH' h1 h2 h3' h4 hc2 hcN hcS
    have hhh : h₀ = h := hh₀.unique hh
    have hhd : F.IsFlankAbove E (α + π) κ₄ h := hhh ▸ hh₀d
    have he2 : e (α + π + π / 2) = -e (α + π / 2) := by
      rw [show α + π + π / 2 = (α + π / 2) + π by ring, e_add_pi]
    have hH2 : F.IsHorn E (α + π + π) κ₁ κ₂ c := hH.congr (by
      rw [show α + π + π = α + 2 * π * ((1 : ℤ) : ℝ) by push_cast; ring, e_add_int_mul])
    have hHS' : ¬ (F.IsContact E h (E + e (α + π + π / 2)) ∧ F.InType E h (E + e (α + π + π / 2))) := by
      rw [he2, ← sub_eq_add_neg]; exact hHS
    have hhN := flank_two_sectors_at_S_gen hF hP hst h3 hc2 hH' hH2 h3' h4 h1 h2 hhd hHS'
    rw [he2, sub_neg_eq_add] at hhN
    exact ⟨hgS, hhN, Or.inl (isStuck_of_hasRepeatedColour' hT (hdom _) ⟨h, hhN⟩),
      Or.inl (isStuck_of_hasRepeatedColour' hT (hdom _) ⟨g, hgS⟩)⟩

end ArcMap
end HadwigerNelson.Plane
