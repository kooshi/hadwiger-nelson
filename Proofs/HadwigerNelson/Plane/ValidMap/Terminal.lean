import Proofs.HadwigerNelson.Plane.ValidMap.Chain
import Proofs.HadwigerNelson.Plane.ValidMap.Contact
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc
import Proofs.HadwigerNelson.Plane.ValidMap.BaseSteps
import Proofs.HadwigerNelson.Plane.ValidMap.BrickMap
import Proofs.HadwigerNelson.Plane.ValidMap.FlankUA
import Proofs.HadwigerNelson.Plane.ValidMap.HornShadow

/-!
# The terminal modification `M*` and the stuck chains' ends (FS112-N2-TERM, -C-ENDS, -C-DOUBLE, FS114-CV-HD)

Wave 5's skeleton (`plans/FS131-w5-kernel-plan.md` § 3), over the foundation `Plane/ValidMap/Chain`. Frames as in wave 4: at a vertex
`v` with axis `e α`, `n = e (α + π/2)`, `N = v + n`, `S = v − n`; a horn along `e (α + π)` has `n` reversed in its own frame, so its
arc on the `N` side is its *lower* arc (curvature `−1` there means "on `ω(N)`"). Rows:

* **FS112-N2-TERM** (`exists_terminal`), with **FS112-N2-RED** merged as its lemma (`exists_red`);
* **FLANK-Q unconditional** (wave 4's obligation, inventory item 79): `flankQ_upper_of_qrOnly`, `flankQ_lower_of_qrOnly`;
* **FS114-CV-HD** (`cv_hd_main`, `cv_hd`, `cv_class`, `cv_l0`; CV-ENDS is `c_ends`);
* **FS112-C-ENDS** in its erratum's form (`c_ends`), **FS112-C-DOUBLE** (`c_double`);
* supporting lemmas: the unit-arc stuck structure (`stuck_structure_ua`, FS112-WALK's row 5 — not a backlog row), the corrected
  **FS112-Y3-END-NEEDS** (`y3_end_needs`, inventory item 69), and **FS112-N3-END's chain clause** (`n3_end_chain`, item 74);
* the inhabitant of `IsTerminalMap` at seven colours (`sevenBrickMap_isTerminalMap`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Angle arithmetic at `S′` (FS131-I5i) -/

/-- An integer between `1/2` and `1` (as a real) is `1`. -/
theorem int_eq_one_of_real {t : ℤ} (h1 : (1 : ℝ) / 2 ≤ t) (h2 : (t : ℝ) ≤ 1) : t = 1 := by
  have a : 0 < t := by exact_mod_cast (show (0 : ℝ) < t by linarith)
  have b : t ≤ 1 := by exact_mod_cast h2
  omega

/-- An integer between `0` and `1/2` (as a real) is `0`. -/
theorem int_eq_zero_of_real {t : ℤ} (h1 : (0 : ℝ) ≤ t) (h2 : (t : ℝ) ≤ 1 / 2) : t = 0 := by
  have a : 0 ≤ t := by exact_mod_cast h1
  have b : t < 1 := by exact_mod_cast (show (t : ℝ) < 1 by linarith)
  omega

/-- `|κ s / 2| < 1` below a chart radius `r₀` with `|κ| r₀ < 2` (so `arcsin (κ s / 2)` is strictly inside `(−π/2, π/2)`). -/
theorem abs_half_lt_one {κ s r₀ : ℝ} (hc : |κ| * r₀ < 2) (hs0 : 0 ≤ s) (hs : s < r₀) : |κ * s / 2| < 1 := by
  rw [abs_div, abs_mul, abs_of_nonneg hs0, abs_two]
  have : |κ| * s ≤ |κ| * r₀ := mul_le_mul_of_nonneg_left hs.le (abs_nonneg κ)
  rw [div_lt_one two_pos]; linarith

/-- An arc of directions `[b₀, b₁]` inside the closed lower half-turn `[α + π, α + 2π]` and holding both `α` and `α + π` is that half-turn
(E5 § 3.4: "its cone lies in `[α + π, α + 2π]` and holds both ends, so it **is** `[α + π, α + 2π]`"). -/
theorem angleIcc_eq_lower_half {α b₀ b₁ : ℝ} (h01 : b₀ ≤ b₁)
    (hsub : angleIcc b₀ b₁ ⊆ angleIcc (α + π) (α + 2 * π)) (hα : α ∈ angleIcc b₀ b₁) (hαπ : α + π ∈ angleIcc b₀ b₁) :
    ∃ m : ℤ, b₀ = α + π + 2 * π * m ∧ b₁ = α + 2 * π + 2 * π * m := by
  have hπ := Real.pi_pos
  obtain ⟨j, hj1, hj2⟩ := ArcMap.exists_lift_of_Icc_subset_angleIcc (A := α + π) (B := α + 2 * π) (by linarith) h01
    ((Icc_subset_angleIcc b₀ b₁).trans hsub)
  obtain ⟨k, hk1, hk2⟩ := mem_iUnion.mp hα
  obtain ⟨k', hk1', hk2'⟩ := mem_iUnion.mp hαπ
  have e1 : -k - j = 1 := int_eq_one_of_real (by push_cast; nlinarith) (by push_cast; nlinarith)
  have e2 : -k' - j = 0 := int_eq_zero_of_real (by push_cast; nlinarith) (by push_cast; nlinarith)
  have e1' : (k : ℝ) = -1 - j := by have : ((-k - j : ℤ) : ℝ) = 1 := by exact_mod_cast e1
                                    push_cast at this; linarith
  have e2' : (k' : ℝ) = -j := by have : ((-k' - j : ℤ) : ℝ) = 0 := by exact_mod_cast e2
                                 push_cast at this; linarith
  refine ⟨j, ?_, ?_⟩
  · rw [e2'] at hk1'; nlinarith
  · rw [e1'] at hk2; nlinarith

/-- An arc of directions inside `[α + π, α + 2π − φ]` (U1's cone at `S′`) whose arc meets no interior direction of the lower half-turn
`(α + π, α + 2π)` is the single direction `α + π` (E5 § 3.4: "hence equal to `{α + π}`"). -/
theorem angle_pinch {α φ b b' : ℝ} {m : ℤ} (hφ : 0 < φ) (hφπ : φ < π) (hbb : b ≤ b')
    (hsub : angleIcc b b' ⊆ angleIcc (α + π) (α + 2 * π - φ))
    (hdisj : Disjoint (angleIcc b b') (angleIoo (α + π + 2 * π * m) (α + 2 * π + 2 * π * m))) :
    b' = b ∧ ∃ m' : ℤ, b = α + π + 2 * π * m' := by
  have hπ := Real.pi_pos
  have key : ∀ x ∈ Icc b b', ∃ k : ℤ, x = α + π + 2 * π * k := by
    intro x hx
    have hxI := Icc_subset_angleIcc b b' hx
    obtain ⟨k, hk1, hk2⟩ := mem_iUnion.mp (hsub hxI)
    refine ⟨k, ?_⟩
    by_contra hne
    have hlt : α + π + 2 * π * k < x := lt_of_le_of_ne hk1 (Ne.symm hne)
    refine Set.disjoint_left.mp hdisj hxI (mem_iUnion.mpr ⟨k - m, ?_, ?_⟩) <;> push_cast <;> nlinarith
  obtain ⟨k₀, hk₀⟩ := key b ⟨le_rfl, hbb⟩
  refine ⟨?_, k₀, hk₀⟩
  by_contra hne
  have hlt : b < b' := lt_of_le_of_ne hbb (Ne.symm hne)
  set x := b + min (b' - b) π / 2 with hx
  have hm0 : 0 < min (b' - b) π := lt_min (by linarith) hπ
  obtain ⟨k₁, hk₁⟩ := key x ⟨by rw [hx]; linarith, by rw [hx]; linarith [min_le_left (b' - b) π]⟩
  have h1 : (0 : ℝ) < ((k₁ - k₀ : ℤ) : ℝ) := by push_cast; nlinarith
  have h2 : ((k₁ - k₀ : ℤ) : ℝ) < 1 := by push_cast; nlinarith [min_le_right (b' - b) π]
  have h1' : 0 < k₁ - k₀ := by exact_mod_cast h1
  have h2' : k₁ - k₀ < 1 := by exact_mod_cast h2
  omega

/-- The point of `ω(S′)` at angle `α + π/2 − t`, `S′ = v − e (α + π/2)`, in the frame at `v`: `(sin t, −(1 − cos t))`. -/
theorem ringPt_S_sub_eq_framePt (v : ℂ) (α t : ℝ) :
    ringPt (v - e (α + π / 2)) (α + π / 2 - t) = framePt v α (Real.sin t) (-(1 - Real.cos t)) := by
  unfold ringPt framePt
  rw [show α + π / 2 - t = α + (π / 2 - t) by ring, e_add, e_add, e_eq (π / 2 - t), e_eq (π / 2),
    Real.cos_pi_div_two_sub, Real.sin_pi_div_two_sub, Real.cos_pi_div_two, Real.sin_pi_div_two]
  push_cast
  ring

/-- A horn whose bounding curvatures are small against its radius is connected. -/
theorem isPreconnected_hornSet_of_abs_le {v : ℂ} {α κ₁ κ₂ r : ℝ} (h12 : κ₁ < κ₂) (h1 : |κ₁| * r ≤ 2)
    (h2 : |κ₂| * r ≤ 2) : IsPreconnected (hornSet v α κ₁ κ₂ r) := by
  have hπ := Real.pi_pos
  set G : BranchGerms 2 := ⟨![α, α], ![κ₁, κ₂]⟩ with hG
  rcases le_or_gt r 0 with hr0 | hr0
  · have : hornSet v α κ₁ κ₂ r = ∅ := by
      ext z; simp only [hornSet, mem_setOf_eq, mem_empty_iff_false, iff_false]
      rintro ⟨hz, -⟩; linarith [dist_nonneg (x := z) (y := v)]
    rw [this]; exact isPreconnected_empty
  have hsec : G.sector v r 0 = hornSet v α κ₁ κ₂ r := by
    have hb : G.nextβ 0 = α := by simp [BranchGerms.nextβ, hG]
    have hk : G.nextκ 0 = κ₂ := by simp [BranchGerms.nextκ, hG]
    show sectorBetween v (G.β 0) (G.κ 0) (G.nextβ 0) (G.nextκ 0) r = _
    rw [hb, hk]
    have h0 : G.β 0 = α := rfl
    have h1' : G.κ 0 = κ₁ := rfl
    rw [h0, h1']
    exact sectorBetween_eq_hornSet v α κ₁ κ₂ r h1 h2
  rw [← hsec]
  refine G.isPreconnected_sector (r₀ := r) (fun s hs i => ?_) le_rfl 0
  have hs0 := hs.1
  have hs1 := hs.2
  have ha1 : κ₁ * s / 2 ∈ Icc (-1 : ℝ) 1 := half_curv_mem_Icc h1 hs0.le hs1.le
  have ha2 : κ₂ * s / 2 ∈ Icc (-1 : ℝ) 1 := half_curv_mem_Icc h2 hs0.le hs1.le
  fin_cases i
  · show germDir (G.β 0) (G.κ 0) s < germDir (G.nextβ 0) (G.nextκ 0) s
    simp only [germDir, BranchGerms.nextβ, BranchGerms.nextκ, hG]
    norm_num
    exact Real.arcsin_lt_arcsin ha1.1 (by nlinarith) ha2.2
  · show germDir (G.β 1) (G.κ 1) s < germDir (G.nextβ 1) (G.nextκ 1) s
    simp only [germDir, BranchGerms.nextβ, BranchGerms.nextκ, hG]
    norm_num
    have := Real.arcsin_le_pi_div_two (κ₂ * s / 2)
    have := Real.neg_pi_div_two_le_arcsin (κ₁ * s / 2)
    linarith

/-- The direction `α` is outside U1's cone at `S′`. -/
theorem not_mem_angleIcc_S_self {α φ : ℝ} (hφ : 0 < φ) : α ∉ angleIcc (α + π) (α + 2 * π - φ) := by
  have hπ := Real.pi_pos
  intro h
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp h
  have hm0 : m < 0 := by
    have : (m : ℝ) < 0 := by nlinarith
    exact_mod_cast this
  have h2 : (m : ℝ) ≤ -1 := by
    have : m ≤ -1 := by omega
    exact_mod_cast this
  nlinarith
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

/-! ## Angles mod `2π` and germ order (FS131-I5n, for CVB § 1.6's branch `G_N`) -/

/-- A direction is a cone direction exactly as its point `e β` is: congruent angles are both in the cone or both out. -/
theorem mem_coneAt_of_e_eq {S : Set ℂ} {y : ℂ} {β β' : ℝ} (he : e β = e β') (h : β ∈ coneAt S y) : β' ∈ coneAt S y := by
  intro ε hε
  obtain ⟨z, hz, hne, hd, hdir⟩ := h ε hε
  exact ⟨z, hz, hne, hd, by rwa [← he]⟩

/-- A direction in a gap of an angular interval (between `[a, b] + 2πm` and `[a, b] + 2π(m + 1)`) is outside it. -/
theorem not_mem_angleIcc_of_gap {x a b : ℝ} (m : ℤ) (h1 : b + 2 * π * m < x) (h2 : x < a + 2 * π * (m + 1)) :
    x ∉ angleIcc a b := by
  have hπ := Real.pi_pos
  intro hx
  obtain ⟨k, hk1, hk2⟩ := mem_iUnion.mp hx
  have hkm : k < m + 1 := by
    have : (k : ℝ) < m + 1 := by nlinarith
    exact_mod_cast this
  have hkm' : (k : ℝ) ≤ m := by exact_mod_cast (show k ≤ m by omega)
  nlinarith

/-- A direction not congruent to `β` lies strictly inside the turn `(β, β + 2π)`, mod `2π`. -/
theorem mem_angleIoo_of_e_ne {x β : ℝ} (h : e x ≠ e β) : x ∈ angleIoo β (β + 2 * π) := by
  have hπ := Real.pi_pos
  set m := ⌊(x - β) / (2 * π)⌋ with hm
  have h1 : (m : ℝ) ≤ (x - β) / (2 * π) := Int.floor_le _
  have h2 : (x - β) / (2 * π) < m + 1 := Int.lt_floor_add_one _
  have h2π : (0 : ℝ) < 2 * π := by positivity
  have h1' : β + 2 * π * m ≤ x := by
    have := (le_div_iff₀ h2π).mp h1; linarith
  have h2' : x < β + 2 * π + 2 * π * m := by
    have := (div_lt_iff₀ h2π).mp h2; linarith
  refine mem_iUnion.mpr ⟨m, lt_of_le_of_ne h1' fun heq => h ?_, h2'⟩
  rw [← heq, e_add_int_mul]

/-- **The upper half-turn holds the pinch**: if `β ≡ α` and `β' ≡ α + π` with `β ≤ β' ≤ β + 2π` (so `β' = β + π`), then every direction in
both `[α + φ, α + π]` and `[α, α + π − φ']` (mod `2π`), `φ, φ' > 0`, lies strictly between `β` and `β'`. -/
theorem mem_angleIoo_half {β β' x α φ φ' : ℝ} (he : e β = e α) (he' : e β' = e (α + π)) (h1 : β ≤ β') (h2 : β' ≤ β + 2 * π)
    (hφ : 0 < φ) (hφ' : 0 < φ') (hx1 : x ∈ angleIcc (α + φ) (α + π)) (hx2 : x ∈ angleIcc α (α + π - φ')) :
    x ∈ angleIoo β β' := by
  have hπ := Real.pi_pos
  obtain ⟨m₁, hm₁⟩ := e_eq_e_iff.mp he
  obtain ⟨m₂, hm₂⟩ := e_eq_e_iff.mp he'
  have hmm : m₂ = m₁ := by
    have a1 : (0 : ℝ) ≤ π + 2 * π * ((m₂ - m₁ : ℤ) : ℝ) := by push_cast; nlinarith
    have a2 : π + 2 * π * ((m₂ - m₁ : ℤ) : ℝ) ≤ 2 * π := by push_cast; nlinarith
    have b1 : (-1 : ℝ) ≤ 2 * ((m₂ - m₁ : ℤ) : ℝ) := by
      by_contra hc; push Not at hc; nlinarith
    have b2 : 2 * ((m₂ - m₁ : ℤ) : ℝ) ≤ 1 := by
      by_contra hc; push Not at hc; nlinarith
    have c1 : -1 ≤ 2 * (m₂ - m₁) := by exact_mod_cast b1
    have c2 : 2 * (m₂ - m₁) ≤ 1 := by exact_mod_cast b2
    omega
  subst hmm
  obtain ⟨k, hk1, hk2⟩ := mem_iUnion.mp hx1
  obtain ⟨k', hk1', hk2'⟩ := mem_iUnion.mp hx2
  have hkk : k' = k := by
    have b1 : (k' : ℝ) - k ≤ 1 / 2 := by
      by_contra hc; push Not at hc; nlinarith
    have b2 : (k : ℝ) - k' < 1 / 2 := by
      by_contra hc; push Not at hc; nlinarith
    have c1 : k' - k < 1 := by
      have : ((k' - k : ℤ) : ℝ) < 1 := by push_cast; linarith
      exact_mod_cast this
    have c2 : k - k' < 1 := by
      have : ((k - k' : ℤ) : ℝ) < 1 := by push_cast; linarith
      exact_mod_cast this
    omega
  subst hkk
  refine mem_iUnion.mpr ⟨k' - m₂, ?_, ?_⟩ <;> push_cast <;> nlinarith

/-- A direction strictly inside the upper half-turn `(α, α + π)` (mod `2π`) has positive `n`-component, `n = e (α + π/2)`. -/
theorem cos_pos_of_mem_angleIoo {x α : ℝ} (hx : x ∈ angleIoo α (α + π)) : 0 < Real.cos (x - (α + π / 2)) := by
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp hx
  have : x - (α + π / 2) = (x - α - 2 * π * m - π / 2) + (m : ℤ) * (2 * π) := by ring
  rw [this, Real.cos_add_int_mul_two_pi, Real.cos_sub_pi_div_two]
  exact Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)

namespace BranchGerms

variable {n : ℕ} (G : BranchGerms n)

/-- **The germ after a sector opens the next sector**: some sector starts at the germ that ends sector `i` (mod `2π`). -/
theorem exists_succ (i : Fin n) : ∃ j : Fin n, e (G.β j) = e (G.nextβ i) ∧ G.κ j = G.nextκ i := by
  have hn := i.pos
  by_cases h : i.val + 1 < n
  · refine ⟨⟨i.val + 1, h⟩, ?_, ?_⟩
    · have : G.nextβ i = G.β ⟨i.val + 1, h⟩ := by unfold BranchGerms.nextβ; split_ifs; rfl
      rw [this]
    · have : G.nextκ i = G.κ ⟨i.val + 1, h⟩ := by unfold BranchGerms.nextκ; split_ifs; rfl
      rw [this]
  · refine ⟨⟨0, hn⟩, ?_, ?_⟩
    · have : G.nextβ i = G.β ⟨0, hn⟩ + 2 * π := by unfold BranchGerms.nextβ; split_ifs; rfl
      rw [this]
      have h2 := e_add_int_mul (G.β ⟨0, hn⟩) 1
      rw [Int.cast_one, mul_one] at h2
      exact h2.symm
    · have : G.nextκ i = G.κ ⟨0, hn⟩ := by unfold BranchGerms.nextκ; split_ifs; rfl
      rw [this]

/-- **The germ that opens a sector ends the previous one**: some sector ends at the germ that starts sector `i` (mod `2π`). -/
theorem exists_pred (i : Fin n) : ∃ p : Fin n, e (G.nextβ p) = e (G.β i) ∧ G.nextκ p = G.κ i := by
  have hn := i.pos
  by_cases h0 : 0 < i.val
  · have hlt : i.val - 1 + 1 < n := by omega
    have hi : (⟨i.val - 1 + 1, hlt⟩ : Fin n) = i := Fin.ext (by simp only; omega)
    refine ⟨⟨i.val - 1, by omega⟩, ?_, ?_⟩
    · have : G.nextβ ⟨i.val - 1, by omega⟩ = G.β i := by
        unfold BranchGerms.nextβ; split_ifs with hh
        · exact congrArg G.β hi
        · exact absurd hlt hh
      rw [this]
    · have : G.nextκ ⟨i.val - 1, by omega⟩ = G.κ i := by
        unfold BranchGerms.nextκ; split_ifs with hh
        · exact congrArg G.κ hi
        · exact absurd hlt hh
      rw [this]
  · have hi0 : (⟨0, hn⟩ : Fin n) = i := Fin.ext (by simp only; omega)
    have hlt : ¬ (n - 1 + 1 < n) := by omega
    refine ⟨⟨n - 1, by omega⟩, ?_, ?_⟩
    · have : G.nextβ ⟨n - 1, by omega⟩ = G.β ⟨0, hn⟩ + 2 * π := by
        unfold BranchGerms.nextβ; split_ifs with hh
        · exact absurd hh hlt
        · rfl
      rw [this, ← hi0]
      have h2 := e_add_int_mul (G.β ⟨0, hn⟩) 1
      rw [Int.cast_one, mul_one] at h2
      exact h2
    · have : G.nextκ ⟨n - 1, by omega⟩ = G.κ ⟨0, hn⟩ := by
        unfold BranchGerms.nextκ; split_ifs with hh
        · exact absurd hh hlt
        · rfl
      rw [this, hi0]

end BranchGerms

/-- **A sector spanning a whole turn leaves no room**: if a sector's two germs have one direction mod `2π` and the second is past the first (so a
whole turn on), every other sector's first direction is congruent to it (`Mono.disjoint`). -/
theorem BranchGerms.Mono.false_of_full {n : ℕ} {G : BranchGerms n} (hM : G.Mono) {i j : Fin n}
    (hij : i ≠ j) (he : e (G.β i) = e (G.nextβ i)) (hlt : G.β i < G.nextβ i) (hne : e (G.β j) ≠ e (G.β i)) : False := by
  have hπ := Real.pi_pos
  obtain ⟨m, hm⟩ := e_eq_e_iff.mp he.symm
  have hle := hM.nextβ_le_add i
  have hm1 : m = 1 := by
    have a1 : (0 : ℝ) < m := by
      by_contra hc; push Not at hc; nlinarith
    have a2 : (m : ℝ) ≤ 1 := by
      by_contra hc; push Not at hc; nlinarith
    have b1 : 0 < m := by exact_mod_cast a1
    have b2 : m ≤ 1 := by exact_mod_cast a2
    omega
  subst hm1
  have hfull : G.nextβ i = G.β i + 2 * π := by rw [hm]; push_cast; ring
  have h1 := mem_angleIoo_of_e_ne hne
  rw [← hfull] at h1
  exact Set.disjoint_left.mp (hM.disjoint hij) (Icc_subset_angleIcc _ _ ⟨le_rfl, hM j⟩) h1

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- `z` lies on a (Q) or an (R2) arc of some unit circle. -/
def OnQR2Arc (z : ℂ) : Prop :=
  ∃ P θ₁ θ₂, (F.IsQArc P θ₁ θ₂ ∨ F.IsR2Arc P θ₁ θ₂) ∧ z ∈ ringArc P θ₁ θ₂

/-- A horn bound of exactly `±1` at `w` along `e β` sits on a (Q) or (R2) arc: an upper arc on `ω(w + e(β + π/2))` is the start (at
`w`, angle `β − π/2`) of a (Q) or (R2) arc of that circle on the `+e β` side, and a lower arc on `ω(w − e(β + π/2))` likewise
(FLANK-Q's form). -/
def HornBoundsQR (w : ℂ) (β : ℝ) : Prop :=
  (∀ κ₁ d, F.IsHorn w β κ₁ 1 d → ∃ θ₂, β - π / 2 < θ₂ ∧
      (F.IsQArc (w + e (β + π / 2)) (β - π / 2) θ₂ ∨ F.IsR2Arc (w + e (β + π / 2)) (β - π / 2) θ₂)) ∧
    ∀ κ₂ d, F.IsHorn w β (-1) κ₂ d → ∃ θ₁, θ₁ < β + π / 2 ∧
      (F.IsQArc (w - e (β + π / 2)) θ₁ (β + π / 2) ∨ F.IsR2Arc (w - e (β + π / 2)) θ₁ (β + π / 2))

end ArcMap

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## The unit-arc stuck structure (supporting lemma: FS112-WALK's row 5, N4-STUCK (i)–(ii) with unit arcs) -/

/-- **FS110-N3-DEG's cone as horns, unit arcs allowed** (wave 4's `woodallCone_isHorn` with `woodallCone` for `woodallCone_strict`: no
Condition 5, curvatures in `[−1, 1]`): with `int D_c(v) = ∅`, every `c`-sector at `v` is a `c`-horn along `±a`. -/
theorem woodallCone_isHorn_ua (hF : F.Valid) {v : ℂ} {c : Fin k} (hv : F.Covers v 1)
    (hc : c ∈ F.coloursAt v) (hD : interior (F.allowedCone v c) = ∅) :
    ∃ α : ℝ, (F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) ∧
      (F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) ∧
      ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ S ∈ F.sectorsOf v r c, ∃ β ∈ ({α, α + π} : Set ℝ), ∃ κ₁ κ₂,
        -1 ≤ κ₁ ∧ κ₂ ≤ 1 ∧ F.IsHorn v β κ₁ κ₂ c ∧ S = hornSet v β κ₁ κ₂ r := by
  obtain ⟨α, hN, hS, hev⟩ := woodallCone hF hv hc hD
  obtain ⟨r₀, n, G, hC⟩ := localSectors F (hv (mem_closedBall_self zero_le_one))
  refine ⟨α, hN, hS, ?_⟩
  filter_upwards [hev, Ioc_mem_nhdsGT hC.pos] with r hr hrr S hS'
  obtain ⟨β, hβ, κ₁, κ₂, h1, h12, h2, hSeq⟩ := hr S hS'
  have hSec : F.IsSector v r (hornSet v β κ₁ κ₂ r) := hSeq ▸ hS'.1
  obtain ⟨i, -, -, -, -, hsec⟩ := hC.index_of_isSector_hornSet hrr h12 hSec
  have hn : 0 < n := i.pos
  obtain ⟨g, hg⟩ := hC.exists_col i
  -- the sector's colour is `c`
  have hgc : g = c := by
    obtain ⟨z, hz⟩ := hC.sector_nonempty hrr i
    have hz' : z ∈ S := by rw [hSeq, ← hsec r hrr]; exact hz
    have h1 := (hg r hrr hz).2
    have h2 := hS'.2 hz'
    exact h1.symm.trans h2
  refine ⟨β, hβ, κ₁, κ₂, h1, h2, ⟨h12, ?_⟩, hSeq⟩
  filter_upwards [Ioc_mem_nhdsGT hC.pos] with r' hr'
  rw [← hsec r' hr']
  refine ⟨(hC.isSector_iff hn hr').mpr ⟨i, rfl⟩, fun z hz => ?_⟩
  have := (hg r' hr' hz).2
  rw [hgc] at this
  exact this

/-- **N4-STUCK (i) with unit arcs** (wave 4's `stuck_horns` over `woodallCone_isHorn_ua`: no Condition 5, curvatures in `[−1, 1]`): at a stuck
vertex the colour with two or more sectors has exactly two, horns along `±a`, with out-type contacts at both poles. -/
theorem stuck_horns_ua (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) (hst : F.IsStuck v) {c : Fin k}
    {m : ℕ} (hm : 2 ≤ m) (hc : F.HasSectors v c m) :
    ∃ α κ₁ κ₂ κ₃ κ₄ : ℝ, F.IsHorn v α κ₁ κ₂ c ∧ F.IsHorn v (α + π) κ₃ κ₄ c ∧ -1 ≤ κ₁ ∧ κ₂ ≤ 1 ∧ -1 ≤ κ₃ ∧ κ₄ ≤ 1 ∧
      F.HasSectors v c 2 ∧ (F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) ∧
      (F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) := by
  have hvd : v ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  obtain ⟨hM, hR, hSh, -⟩ := hst
  have hD : interior (F.allowedCone v c) = ∅ := by
    by_contra hne
    exact hM ⟨c, m, hm, hc, nonempty_iff_ne_empty.mpr hne⟩
  have hcv : c ∈ F.coloursAt v := by
    obtain ⟨r, hr, -⟩ := (hc.and self_mem_nhdsWithin).exists
    have h1 : 1 < (F.sectorsOf v r c).encard := by rw [hr]; exact_mod_cast hm
    obtain ⟨S, -, hS, -, -⟩ := one_lt_encard_iff.mp h1
    have hS' : F.IsSector v r S ∧ S ⊆ F.col ⁻¹' {c} := hS
    obtain ⟨⟨x, -, hSx, hvS⟩, hSc⟩ := hS'
    have hSr : S ⊆ F.region c := fun z hz =>
      ⟨by rw [hSx] at hz; exact (connectedComponentIn_subset _ _ hz).1, hSc hz⟩
    exact closure_mono hSr hvS
  obtain ⟨α, hN, hS, hev⟩ := woodallCone_isHorn_ua hF hv hcv hD
  obtain ⟨r, ⟨hrH, hrm⟩, hr⟩ := ((hev.and hc).and self_mem_nhdsWithin).exists
  have h1 : 1 < (F.sectorsOf v r c).encard := by rw [hrm]; exact_mod_cast hm
  obtain ⟨x, y, hx, hy, hxy⟩ := one_lt_encard_iff.mp h1
  obtain ⟨βx, hβx, a₁, a₂, ha₁, ha₂, Hx, hxe⟩ := hrH x hx
  obtain ⟨βy, hβy, b₁, b₂, hb₁, hb₂, Hy, hye⟩ := hrH y hy
  -- one sector per ray
  have huniq : ∀ S ∈ F.sectorsOf v r c, ∀ β κ₁ κ₂, F.IsHorn v β κ₁ κ₂ c → S = hornSet v β κ₁ κ₂ r →
      ∀ S' ∈ F.sectorsOf v r c, ∀ κ₁' κ₂', F.IsHorn v β κ₁' κ₂' c → S' = hornSet v β κ₁' κ₂' r → S = S' := by
    intro S _ β κ₁ κ₂ H hSe S' _ κ₁' κ₂' H' hSe'
    obtain ⟨e1, e2⟩ := horn_unique_of_stuck hF hvd hR hSh H H'
    rw [hSe, hSe', e1, e2]
  have hβne : βx ≠ βy := by
    intro he
    rw [he] at Hx hxe
    exact hxy (huniq x hx βy a₁ a₂ Hx hxe y hy b₁ b₂ Hy hye)
  -- at most two sectors
  have hsub : F.sectorsOf v r c ⊆ {x, y} := by
    intro S hS'
    obtain ⟨β, hβ, κ₁, κ₂, -, -, H, hSe⟩ := hrH S hS'
    have hβ' : β = βx ∨ β = βy := by
      simp only [mem_insert_iff, mem_singleton_iff] at hβ hβx hβy
      rcases hβ with rfl | rfl <;> rcases hβx with rfl | rfl <;> rcases hβy with rfl | rfl <;>
        first | exact Or.inl rfl | exact Or.inr rfl | exact absurd rfl hβne
    rcases hβ' with rfl | rfl
    · exact Or.inl (huniq S hS' β κ₁ κ₂ H hSe x hx a₁ a₂ Hx hxe)
    · exact Or.inr (huniq S hS' β κ₁ κ₂ H hSe y hy b₁ b₂ Hy hye)
  have hm2 : m = 2 := by
    have hle : (F.sectorsOf v r c).encard ≤ 2 :=
      (encard_le_encard hsub).trans ((encard_insert_le _ _).trans (by rw [encard_singleton]; rfl))
    rw [hrm] at hle
    have : m ≤ 2 := by exact_mod_cast hle
    omega
  have hc2 : F.HasSectors v c 2 := hm2 ▸ hc
  simp only [mem_insert_iff, mem_singleton_iff] at hβx hβy
  rcases hβx with rfl | rfl
  · have hβy' : βy = βx + π := by
      rcases hβy with h | h
      · exact absurd h.symm hβne
      · exact h
    rw [hβy'] at Hy
    exact ⟨βx, a₁, a₂, b₁, b₂, Hx, Hy, ha₁, ha₂, hb₁, hb₂, hc2, hN, hS⟩
  · have hβy' : βy = α := by
      rcases hβy with h | h
      · exact h
      · exact absurd h.symm hβne
    rw [hβy'] at Hy
    exact ⟨α, b₁, b₂, a₁, a₂, Hy, Hx, hb₁, hb₂, ha₁, ha₂, hc2, hN, hS⟩


/-- **N4-STUCK (ii) with unit arcs: the flanks** — the open part of `stuck_structure_ua` once `stuck_horns_ua` has given the horns. At a stuck vertex
with at most three colours whose two-sector colour `c` has horns along `±e α` (curvatures in `[−1, 1]`) and out-type contacts at both poles: the
flank colours are two, `g` on the `+n` side of both horns and `h` on the `−n` side, distinct and other than `c`; they and `c` are the colours at `v`;
the degree is `4`; and off the parabola `|frameY| = ‖z − v‖²/2` the `+n` side is `g` and the `−n` side `h` (ruling 252's form (b)). FS110-N4-FLANK and
N4-SHAVE with unit arcs (S–V Prop. 7's flank argument): wave 4's `stuck_structure_flanks` proves it under Condition 5 with strict curvatures, where
a horn arc on `ω(v ± n)` cannot occur. Route (FS114-CV § 1.4's re-derivation, `Plane/ValidMap/FlankUA`): no SHAVE makes each flank colour shadow
its horn at every scale (`shadow_of_not_shave`); the upper flank's shadow comes from an in-type contact at `N` or an out-type one at `S′`, the lower
flank's from in-type at `S′` or out-type at `N` (`srcG_of_shadow`, `srcH_of_shadow`), so their allowed cones lie in `d·n ≥ 0` and `d·n ≤ 0`; the flanks
differ (`flank_ne_of_shadows`); the directions `±n` then force the turned horn's flanks to be the same two colours; every contact of `g` is in-type at `N`
or out-type at `S′` (`h` the mirror), so no MERGE leaves each one sector (`hasSectors_one_of_contacts`); the sides by `region_far_of_outType` for `c`
and `region_far_N_of_srcH`, `region_far_S_of_srcG` for the flanks. No Condition 5. Since two `c`-sectors are exactly these two horns, the statement is
`stuck_structure_ua`'s conclusion at this axis (the other axis `α + π` is the same configuration with `g ↔ h`). A step of `stuck_structure_ua`'s
proof. Inhabitant of the hypotheses: `bowtie` at `0` (`bowtie_isStuck`, `bowtie_coloursAt_zero`), with the horns `stuck_horns_ua` gives there. -/
theorem stuck_flanks_ua (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard ≤ 3)
    {c : Fin k} {α κ₁ κ₂ κ₃ κ₄ : ℝ} (Hu : F.IsHorn v α κ₁ κ₂ c) (Hd : F.IsHorn v (α + π) κ₃ κ₄ c)
    (h1 : -1 ≤ κ₁) (h2 : κ₂ ≤ 1) (h3' : -1 ≤ κ₃) (h4 : κ₄ ≤ 1) (hc2 : F.HasSectors v c 2)
    (hN : F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2)))
    (hS : F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) :
    ∃ g h : Fin k, F.HasDegree v 4 ∧ F.coloursAt v = {c, g, h} ∧ g ≠ h ∧ g ≠ c ∧ h ≠ c ∧
      F.IsFlankAbove v α κ₂ g ∧ F.IsFlankBelow v α κ₁ h ∧ F.IsFlankAbove v (α + π) κ₄ h ∧ F.IsFlankBelow v (α + π) κ₃ g ∧
      (∀ᶠ ρ in 𝓝[>] (0 : ℝ), ∀ z ∈ F.interiorPts ∩ ball v ρ,
        (‖z - v‖ ^ 2 / 2 < frameY v α z → F.col z = g) ∧ (frameY v α z < -(‖z - v‖ ^ 2 / 2) → F.col z = h)) := by
  have hvd : v ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  obtain ⟨hcNc, hcNo⟩ := hN
  obtain ⟨hcSc, hcSo⟩ := hS
  obtain ⟨hM, -, hSh, -⟩ := hst
  -- the four flanks, none of colour `c`
  obtain ⟨g, hgu⟩ := Hu.exists_flankAbove hvd
  obtain ⟨h, hhu⟩ := Hu.exists_flankBelow hvd
  obtain ⟨h', hhd⟩ := Hd.exists_flankAbove hvd
  obtain ⟨g', hgd⟩ := Hd.exists_flankBelow hvd
  have band_ne : ∀ {β κ κ' : ℝ} {j : Fin k}, κ < κ' → (∀ᶠ ρ in 𝓝[>] (0 : ℝ), hornSet v β κ κ' ρ ⊆ F.region j) →
      (∀ z ρ, z ∈ hornSet v β κ κ' ρ → (∀ r', z ∉ hornSet v α κ₁ κ₂ r') ∧ ∀ r', z ∉ hornSet v (α + π) κ₃ κ₄ r') →
      j ≠ c := by
    intro β κ κ' j hlt hev hoff hjc
    subst hjc
    exact false_of_third_point hvd hc2 Hu Hd fun ρ hρ => by
      obtain ⟨p, hp, hpb⟩ := exists_mem_hornSet_near hlt hev hρ
      exact ⟨p, hp, hpb.1, hoff p ρ hpb⟩
  have hgc : g ≠ c := by
    obtain ⟨κ', hκ', hev⟩ := id hgu
    refine band_ne hκ' hev fun z ρ hz => ⟨fun r' hz' => lt_asymm hz.2.2.1 hz'.2.2.2, fun r' hz' => ?_⟩
    have := hz'.2.1; rw [frameX_add_pi] at this; linarith [hz.2.1]
  have hhc : h ≠ c := by
    obtain ⟨κ', hκ', hev⟩ := id hhu
    refine band_ne hκ' hev fun z ρ hz => ⟨fun r' hz' => lt_asymm hz'.2.2.1 hz.2.2.2, fun r' hz' => ?_⟩
    have := hz'.2.1; rw [frameX_add_pi] at this; linarith [hz.2.1]
  have hh'c : h' ≠ c := by
    obtain ⟨κ', hκ', hev⟩ := id hhd
    refine band_ne hκ' hev fun z ρ hz => ⟨fun r' hz' => ?_, fun r' hz' => lt_asymm hz.2.2.1 hz'.2.2.2⟩
    have := hz.2.1; rw [frameX_add_pi] at this; linarith [hz'.2.1]
  have hg'c : g' ≠ c := by
    obtain ⟨κ', hκ', hev⟩ := id hgd
    refine band_ne hκ' hev fun z ρ hz => ⟨fun r' hz' => ?_, fun r' hz' => lt_asymm hz'.2.2.1 hz.2.2.2⟩
    have := hz.2.1; rw [frameX_add_pi] at this; linarith [hz'.2.1]
  -- no SHAVE: every flank colour shadows its horn at every scale, from a source at a pole
  obtain ⟨shg, shh⟩ := shadow_of_not_shave hSh Hu hgu hhu
  obtain ⟨shh', shg'⟩ := shadow_of_not_shave hSh Hd hhd hgd
  have sg := srcG_of_shadow hF hv h1 Hu.1 h2 hgu shg
  have sh := srcH_of_shadow hF hv h1 Hu.1 h2 hhu shh
  have sh' := srcG_of_shadow hF hv h3' Hd.1 h4 hhd shh'
  rw [add_e_add_pi_add, sub_e_add_pi_add] at sh'
  have sg' := srcH_of_shadow hF hv h3' Hd.1 h4 hgd shg'
  rw [sub_e_add_pi_add, add_e_add_pi_add] at sg'
  have hgh : g ≠ h := flank_ne_of_shadows hF hv h1 Hu.1 h2 hgu hhu shg shh
  -- the colours at `v`
  have hcv : c ∈ F.coloursAt v := mem_closure_of_mem_coneAt Hu.mem_coneAt_region
  have hgv : g ∈ F.coloursAt v := mem_closure_of_mem_coneAt hgu.mem_coneAt
  have hhv : h ∈ F.coloursAt v := mem_closure_of_mem_coneAt hhu.mem_coneAt
  have hcol : F.coloursAt v = {c, g, h} := by
    refine (Set.eq_of_subset_of_ncard_le ?_ ?_ (toFinite _)).symm
    · intro x hx
      simp only [mem_insert_iff, mem_singleton_iff] at hx
      rcases hx with rfl | rfl | rfl <;> assumption
    · rw [ncard_eq_three.mpr ⟨c, g, h, hgc.symm, hhc.symm, hgh, rfl⟩]
      exact h3
  -- the directions `±n` and the cones
  have hnot : ∀ {j : Fin k} {w : ℂ} {β : ℝ}, F.IsContact v j w → F.OutType v j w → e β = w - v →
      e β ∉ F.allowedCone v j := by
    intro j w β hcj ho he hD
    have := (hD w hcj).2 ho
    rw [he, dot_self_eq, ← dist_eq_norm, hcj.2.1] at this
    norm_num at this
  have hDir : ∀ β, ∃ j ∈ F.coloursAt v, e β ∈ F.allowedCone v j := fun β => by
    obtain ⟨j, hj⟩ := F.exists_mem_coneAt_region hvd β
    exact ⟨j, mem_closure_of_mem_coneAt hj, coneAt_subset_allowedCone hF hv hj⟩
  have hn_eq : e (α + π / 2) = v + e (α + π / 2) - v := by ring
  have hs_eq : e (α + π / 2 + π) = v - e (α + π / 2) - v := by rw [e_add_pi']; ring
  have hnn : dot (e (α + π / 2)) (e (α + π / 2)) = 1 := by rw [dot_self_eq, norm_e]; norm_num
  have hsn : dot (e (α + π / 2 + π)) (e (α + π / 2)) = -1 := by rw [e_add_pi', dot_neg_left, hnn]
  -- the turned horn's flanks are the same two colours
  have hg'g : g' = g := by
    have hg'v : g' ∈ F.coloursAt v := mem_closure_of_mem_coneAt hgd.mem_coneAt
    rw [hcol] at hg'v
    simp only [mem_insert_iff, mem_singleton_iff] at hg'v
    rcases hg'v with h'' | h'' | h''
    · exact absurd h'' hg'c
    · exact h''
    · exfalso
      obtain ⟨j, hj, hjD⟩ := hDir (α + π / 2 + π)
      rw [hcol] at hj
      simp only [mem_insert_iff, mem_singleton_iff] at hj
      rcases hj with rfl | rfl | rfl
      · exact hnot hcSc hcSo hs_eq hjD
      · have := dot_nonneg_of_srcG sg hjD; linarith
      · have := dot_nonneg_of_srcG (h'' ▸ sg') hjD; linarith
  have hh'h : h' = h := by
    have hh'v : h' ∈ F.coloursAt v := mem_closure_of_mem_coneAt hhd.mem_coneAt
    rw [hcol] at hh'v
    simp only [mem_insert_iff, mem_singleton_iff] at hh'v
    rcases hh'v with h'' | h'' | h''
    · exact absurd h'' hh'c
    · exfalso
      obtain ⟨j, hj, hjD⟩ := hDir (α + π / 2)
      rw [hcol] at hj
      simp only [mem_insert_iff, mem_singleton_iff] at hj
      rcases hj with rfl | rfl | rfl
      · exact hnot hcNc hcNo hn_eq hjD
      · have := dot_nonpos_of_srcH (h'' ▸ sh') hjD; linarith
      · have := dot_nonpos_of_srcH sh hjD; linarith
    · exact h''
  subst g' h'
  -- `n ∈ D_g`, `−n ∈ D_h`
  have hDgn : e (α + π / 2) ∈ F.allowedCone v g := by
    obtain ⟨j, hj, hjD⟩ := hDir (α + π / 2)
    rw [hcol] at hj
    simp only [mem_insert_iff, mem_singleton_iff] at hj
    rcases hj with rfl | rfl | rfl
    · exact absurd hjD (hnot hcNc hcNo hn_eq)
    · exact hjD
    · have := dot_nonpos_of_srcH sh hjD; linarith
  have hDhs : e (α + π / 2 + π) ∈ F.allowedCone v h := by
    obtain ⟨j, hj, hjD⟩ := hDir (α + π / 2 + π)
    rw [hcol] at hj
    simp only [mem_insert_iff, mem_singleton_iff] at hj
    rcases hj with rfl | rfl | rfl
    · exact absurd hjD (hnot hcSc hcSo hs_eq)
    · have := dot_nonneg_of_srcG sg hjD; linarith
    · exact hjD
  have hDga := coneAt_subset_allowedCone hF hv hgu.mem_coneAt
  have hDgb := coneAt_subset_allowedCone hF hv hgd.mem_coneAt
  have hDha := coneAt_subset_allowedCone hF hv hhu.mem_coneAt
  have hDhb := coneAt_subset_allowedCone hF hv hhd.mem_coneAt
  have hpi : ∀ u : ℂ, dot (e (α + π)) u = -dot (e α) u := fun u => by rw [e_add_pi', dot_neg_left]
  have hsn' : ∀ u : ℂ, dot (e (α + π / 2 + π)) u = -dot (e (α + π / 2)) u := fun u => by
    rw [e_add_pi', dot_neg_left]
  -- `g`'s contacts: in-type at `N` or out-type at `S′`; `h`'s: in-type at `S′` or out-type at `N`
  have hiiig : ∀ w, F.IsContact v g w →
      (w - v = e (α + π / 2) ∧ F.InType v g w) ∨ (w - v = -e (α + π / 2) ∧ F.OutType v g w) := by
    intro w hw
    rcases (contact_inType_or_outType hF hv hw).1 with hin | hout
    · have a1 := (hDga w hw).1 hin
      have a2 := (hDgb w hw).1 hin
      have a3 := (hDgn w hw).1 hin
      rw [hpi] at a2
      have hx0 : frameX v α w = 0 := by rw [← dot_e_sub_eq_frameX]; linarith
      rcases eq_N_or_S_of_frameX_eq_zero hw.2.1 hx0 with hN | hS
      · rw [dist_eq_zero] at hN
        subst hN
        exact Or.inl ⟨by ring, hin⟩
      · exfalso
        rw [dist_eq_zero] at hS
        subst hS
        rw [show v - e (α + π / 2) - v = -e (α + π / 2) by ring, dot_neg_right, hnn] at a3
        norm_num at a3
    · have a1 := (hDga w hw).2 hout
      have a2 := (hDgb w hw).2 hout
      have a3 := (hDgn w hw).2 hout
      rw [hpi] at a2
      have hx0 : frameX v α w = 0 := by rw [← dot_e_sub_eq_frameX]; linarith
      rcases eq_N_or_S_of_frameX_eq_zero hw.2.1 hx0 with hN | hS
      · exfalso
        rw [dist_eq_zero] at hN
        subst hN
        rw [add_sub_cancel_left, hnn] at a3
        norm_num at a3
      · rw [dist_eq_zero] at hS
        subst hS
        exact Or.inr ⟨by ring, hout⟩
  have hiiih : ∀ w, F.IsContact v h w →
      (w - v = -e (α + π / 2) ∧ F.InType v h w) ∨ (w - v = -(-e (α + π / 2)) ∧ F.OutType v h w) := by
    intro w hw
    rcases (contact_inType_or_outType hF hv hw).1 with hin | hout
    · have a1 := (hDha w hw).1 hin
      have a2 := (hDhb w hw).1 hin
      have a3 := (hDhs w hw).1 hin
      rw [hpi] at a2
      rw [hsn'] at a3
      have hx0 : frameX v α w = 0 := by rw [← dot_e_sub_eq_frameX]; linarith
      rcases eq_N_or_S_of_frameX_eq_zero hw.2.1 hx0 with hN | hS
      · exfalso
        rw [dist_eq_zero] at hN
        subst hN
        rw [add_sub_cancel_left, hnn] at a3
        norm_num at a3
      · rw [dist_eq_zero] at hS
        subst hS
        exact Or.inl ⟨by ring, hin⟩
    · have a1 := (hDha w hw).2 hout
      have a2 := (hDhb w hw).2 hout
      have a3 := (hDhs w hw).2 hout
      rw [hpi] at a2
      rw [hsn'] at a3
      have hx0 : frameX v α w = 0 := by rw [← dot_e_sub_eq_frameX]; linarith
      rcases eq_N_or_S_of_frameX_eq_zero hw.2.1 hx0 with hN | hS
      · rw [dist_eq_zero] at hN
        subst hN
        exact Or.inr ⟨by ring, hout⟩
      · exfalso
        rw [dist_eq_zero] at hS
        subst hS
        rw [show v - e (α + π / 2) - v = -e (α + π / 2) by ring, dot_neg_right, hnn] at a3
        norm_num at a3
  -- no MERGE: one sector each, degree `4`
  have hg1 : F.HasSectors v g 1 := hasSectors_one_of_contacts hF hv hM (norm_e _) hgv hiiig
  have hh1 : F.HasSectors v h 1 :=
    hasSectors_one_of_contacts hF hv hM (by rw [norm_neg, norm_e]) hhv hiiih
  have hdeg : F.HasDegree v 4 := hasDegree_of_three_colours hcol hgc.symm hhc.symm hgh hc2 hg1 hh1
  -- the sides, outside the parabolas `frameY = ±‖z − v‖²/2`
  obtain ⟨ε₁, hε₁, hf₁⟩ := region_far_of_outType hF hv hcNc hcNo
  obtain ⟨ε₂, hε₂, hf₂⟩ := region_far_N_of_srcH hF hv sh
  obtain ⟨ε₃, hε₃, hf₃⟩ := region_far_of_outType hF hv hcSc hcSo
  obtain ⟨ε₄, hε₄, hf₄⟩ := region_far_S_of_srcG hF hv sg
  have hsides : ∀ᶠ ρ in 𝓝[>] (0 : ℝ), ∀ z ∈ F.interiorPts ∩ ball v ρ,
      (‖z - v‖ ^ 2 / 2 < frameY v α z → F.col z = g) ∧ (frameY v α z < -(‖z - v‖ ^ 2 / 2) → F.col z = h) := by
    filter_upwards [eventually_col_mem_coloursAt v,
      Ioo_mem_nhdsGT (lt_min (lt_min hε₁ hε₂) (lt_min hε₃ hε₄))] with ρ hρ hρε z hz
    have hzv : dist z v < min (min ε₁ ε₂) (min ε₃ ε₄) := lt_of_lt_of_le hz.2 hρε.2.le
    have hcz := hρ z hz
    have hzr : z ∈ F.region (F.col z) := ⟨hz.1, mem_singleton _⟩
    rw [hcol] at hcz
    simp only [mem_insert_iff, mem_singleton_iff] at hcz
    constructor
    · intro hY
      have hN : dist z (v + e (α + π / 2)) < 1 := by
        rw [← tanAbove_one_iff]
        show 0 < tanHeight 1 (frameX v α z) (frameY v α z)
        unfold tanHeight
        rw [frame_normSq]
        linarith
      rcases hcz with h' | h' | h'
      · exact absurd (hf₁ z (h' ▸ hzr) (lt_of_lt_of_le hzv ((min_le_left _ _).trans (min_le_left _ _)))) (not_le.mpr hN)
      · exact h'
      · exact absurd (hf₂ z (h' ▸ hzr) (lt_of_lt_of_le hzv ((min_le_left _ _).trans (min_le_right _ _)))) (not_le.mpr hN)
    · intro hY
      have hS : dist z (v - e (α + π / 2)) < 1 := by
        rw [← tanBelow_neg_one_iff]
        show tanHeight (-1) (frameX v α z) (frameY v α z) < 0
        unfold tanHeight
        rw [frame_normSq]
        linarith
      rcases hcz with h' | h' | h'
      · exact absurd (hf₃ z (h' ▸ hzr) (lt_of_lt_of_le hzv ((min_le_right _ _).trans (min_le_left _ _)))) (not_le.mpr hS)
      · exact absurd (hf₄ z (h' ▸ hzr) (lt_of_lt_of_le hzv ((min_le_right _ _).trans (min_le_right _ _)))) (not_le.mpr hS)
      · exact h'
  exact ⟨g, h, hdeg, hcol, hgh, hgc, hhc, hgu, hhu, hhd, hgd, hsides⟩

/-- **N4-STUCK (i)–(ii) with unit arcs** (FS112-WALK, row 5; used by FS114-CV's and CVB's arguments as "N4-STUCK's structure (i)–(ii) …
in `[−1, 1]`", `plans/FS114-CVB-verification.md` § 1.3). Not a backlog row (FS112-WALK is declined, a verdict table): a supporting lemma
of wave 5. At a stuck vertex `v` of a valid map with at most three colours there, the colour `c` with two or more sectors has exactly two,
cusp horns along `±e α` with bounding curvatures in `[−1, 1]`, out-type `c`-contacts at `v ± n`; `P_cl(v) = {c, g, h}` with degree `4`,
the interior points near `v` above the parabola `frameY = ‖z − v‖²/2` of colour `g` and below `frameY = −‖z − v‖²/2` of colour `h` (the sides
clause in inventory item 252's form (b), the point form outside the parabola: both horns, of curvatures in `[−1, 1]`, lie in
`|frameY| ≤ ‖z − v‖²/2`, so "the side off the horns is filled by `g` above and `h` below", as the derivation's (ii) says), `g` the upper flank
and `h` the lower flank of both horns (the flank conjuncts, kept beside it by the same ruling). Inhabitant of the hypotheses: `bowtie` at `0`
(`bowtie_isStuck`, `bowtie_coloursAt_zero`). -/
theorem stuck_structure_ua (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) (hst : F.IsStuck v)
    (h3 : (F.coloursAt v).ncard ≤ 3) {c : Fin k} {m : ℕ} (hm : 2 ≤ m) (hc : F.HasSectors v c m) :
    ∃ α κ₁ κ₂ κ₃ κ₄ : ℝ, ∃ g h : Fin k,
      F.IsHorn v α κ₁ κ₂ c ∧ F.IsHorn v (α + π) κ₃ κ₄ c ∧ -1 ≤ κ₁ ∧ κ₂ ≤ 1 ∧ -1 ≤ κ₃ ∧ κ₄ ≤ 1 ∧
      F.HasSectors v c 2 ∧ F.HasDegree v 4 ∧ F.coloursAt v = {c, g, h} ∧ g ≠ h ∧ g ≠ c ∧ h ≠ c ∧
      F.IsFlankAbove v α κ₂ g ∧ F.IsFlankBelow v α κ₁ h ∧ F.IsFlankAbove v (α + π) κ₄ h ∧ F.IsFlankBelow v (α + π) κ₃ g ∧
      (∀ᶠ ρ in 𝓝[>] (0 : ℝ), ∀ z ∈ F.interiorPts ∩ ball v ρ,
        (‖z - v‖ ^ 2 / 2 < frameY v α z → F.col z = g) ∧ (frameY v α z < -(‖z - v‖ ^ 2 / 2) → F.col z = h)) ∧
      (F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) ∧
      (F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) := by
  obtain ⟨α, κ₁, κ₂, κ₃, κ₄, Hu, Hd, h1, h2, h3', h4, hc2, hN, hS⟩ := stuck_horns_ua hF hv hst hm hc
  obtain ⟨g, h, hdeg, hcol, hgh, hgc, hhc, fa, fb, fa', fb', hsides⟩ :=
    stuck_flanks_ua hF hv hst h3 Hu Hd h1 h2 h3' h4 hc2 hN hS
  exact ⟨α, κ₁, κ₂, κ₃, κ₄, g, h, Hu, Hd, h1, h2, h3', h4, hc2, hdeg, hcol, hgh, hgc, hhc, fa, fb, fa', fb', hsides, hN, hS⟩

/-- **Every colour at a chain vertex approaches it along both directions of one axis** (`stuck_structure_ua`: `c`'s two horns, `g` and `h`
flanking both). Inhabitant of the hypotheses: `bowtie` at `0` (`bowtie_isStuck`, `bowtie_coloursAt_zero`). -/
theorem chainVertex_antipodal (hF : F.Valid) {E : ℂ} (hv : F.Covers E 1) (hst : F.IsStuck E)
    (h3 : (F.coloursAt E).ncard ≤ 3) :
    ∃ α : ℝ, ∀ j ∈ F.coloursAt E, α ∈ coneAt (F.region j) E ∧ α + π ∈ coneAt (F.region j) E := by
  obtain ⟨c, m, hm, hc⟩ := hst.2.2.2
  obtain ⟨α, κ₁, κ₂, κ₃, κ₄, g, h, Hu, Hd, -, -, -, -, -, -, hcol, -, -, -, fa, fb, fa', fb', -⟩ :=
    stuck_structure_ua hF hv hst h3 hm hc
  refine ⟨α, fun j hj => ?_⟩
  rw [hcol] at hj
  simp only [mem_insert_iff, mem_singleton_iff] at hj
  rcases hj with rfl | rfl | rfl
  · exact ⟨Hu.mem_coneAt_region, Hd.mem_coneAt_region⟩
  · exact ⟨fa.mem_coneAt, fb'.mem_coneAt⟩
  · exact ⟨fb.mem_coneAt, fa'.mem_coneAt⟩

/-! ## FS112-N2-TERM, with FS112-N2-RED as its lemma -/

/-- **FS112-N2-RED** (merged into FS112-N2-TERM as its lemma, SR2 item 13): every valid map of the plane has a valid modification —
the same domain, no unit arc created, every point of at least four colours carrying those colours in the map itself — in which every
unit arc is (Q) or (R2). "By W-MERGE and whole-arc bends" and "the procedure terminates with no stubs" are the proof's content (the
modification is the limit of the procedure). Inhabitant of the hypotheses: `sevenBrickMap` at seven colours (no unit arc: itself). -/
theorem exists_red (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ M : ArcMap k, F.IsModification M ∧ M.Valid ∧ M.QROnly := by
  sorry

/-- **FS112-N2-TERM**: every valid six-coloured map of the plane has a valid modification `M*` (the same domain, no unit arc created,
four-colour points' colours kept) which is a terminal valid map (`IsTerminalMap`: no MERGE, MERGE-RAY or SHAVE anywhere, every unit
arc (Q) or (R2)), in which (clause 2) every vertex — a point of at least three colours or with a repeated colour — is cubic
trichromatic, carries at least four colours (an NB4P exception), or is stuck; and (clause 3) every vertex stuck along `e α` lies on a
stuck run that is not bi-infinite, each finite end (the last chain vertex) within distance `1` of a point of a (Q) or (R2) arc or of a
point of at least four colours, and every horn bound `±1` at a vertex of the run, along `±e α`, a (Q) or (R2) arc. "One-sided infinite
chains are a GAP" is a not-claimed clause: nothing is stated about them. Inhabitant of the hypotheses: none at six colours is known
(a valid six-map of the plane is FS-114's open question); the statement's class at seven colours is inhabited by `sevenBrickMap`. -/
theorem exists_terminal {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ M : ArcMap 6, F.IsModification M ∧ M.IsTerminalMap ∧
      (∀ x ∈ M.dom, 3 ≤ (M.coloursAt x).ncard ∨ M.HasRepeatedColour x →
        M.IsCubicTrichromatic x ∨ 4 ≤ (M.coloursAt x).ncard ∨ M.IsStuck x) ∧
      ∀ v α, M.StuckAlong v α → (M.coloursAt v).ncard ≤ 3 →
        M.stuckRun v α ≠ univ ∧
        (∀ j ∈ M.stuckRun v α, (j + 1 ∉ M.stuckRun v α ∨ j - 1 ∉ M.stuckRun v α) →
          ∃ z, dist z (v + (j : ℂ) * e (α + π / 2)) ≤ 1 ∧ (M.OnQR2Arc z ∨ 4 ≤ (M.coloursAt z).ncard)) ∧
        ∀ j ∈ M.stuckRun v α, M.HornBoundsQR (v + (j : ℂ) * e (α + π / 2)) α ∧
          M.HornBoundsQR (v + (j : ℂ) * e (α + π / 2)) (α + π) := by
  sorry

/-! ## FLANK-Q unconditional (wave 4's obligation, inventory item 79) -/

/-- **FS112-N2-FLANK-Q, the upper bound, unconditional** in any map whose unit arcs are all (Q) or (R2) (`QROnly`, N2-TERM's clause 1,
so in every `M*`): wave 4's `flankQ_upper` with its named hypothesis `hQR` discharged. Inhabitant of the local hypotheses: `bowtie` at
`0` (its arcs at `i` are (Q)); `QROnly` on the whole map is inhabited by the one-colour plane (`const_qrOnly`). -/
theorem flankQ_upper_of_qrOnly (hF : F.Valid) (hQR : F.QROnly) {v : ℂ} (hv : F.Covers v 1) {α κ₁ : ℝ} {c g : Fin k}
    (hH : F.IsHorn v α κ₁ 1 c) (hg : F.IsFlankAbove v α 1 g)
    (hcN : F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) :
    ∃ θ₂, α - π / 2 < θ₂ ∧ F.IsRingArc (v + e (α + π / 2)) (α - π / 2) θ₂ g c ∧
      ((F.IsQArc (v + e (α + π / 2)) (α - π / 2) θ₂ ∧
          ∃ T, F.TileOf g T ∧ T ⊆ ball v 1 ∧ v + e (α + π / 2) ∈ closure T) ∨
        (F.IsR2Arc (v + e (α + π / 2)) (α - π / 2) θ₂ ∧ g ∉ F.coloursAt (v + e (α + π / 2)) ∧
          v - e (α + π / 2) ∈ closure (F.region g) ∧ F.OutType v g (v - e (α + π / 2)) ∧
          ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ₁ 1 r ⊆ shadow (F.region g))) :=
  flankQ_upper hF hv hH hg hcN fun _ _ _ _ h => hQR _ _ _ _ _ h

/-- **FS112-N2-FLANK-Q, the lower bound, unconditional** (the mirror; `flankQ_lower` with `hQR` discharged by `QROnly`). -/
theorem flankQ_lower_of_qrOnly (hF : F.Valid) (hQR : F.QROnly) {v : ℂ} (hv : F.Covers v 1) {α κ₂ : ℝ} {c h : Fin k}
    (hH : F.IsHorn v α (-1) κ₂ c) (hh : F.IsFlankBelow v α (-1) h)
    (hcS : F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) :
    ∃ θ₁, θ₁ < α + π / 2 ∧ F.IsRingArc (v - e (α + π / 2)) θ₁ (α + π / 2) h c ∧
      ((F.IsQArc (v - e (α + π / 2)) θ₁ (α + π / 2) ∧
          ∃ T, F.TileOf h T ∧ T ⊆ ball v 1 ∧ v - e (α + π / 2) ∈ closure T) ∨
        (F.IsR2Arc (v - e (α + π / 2)) θ₁ (α + π / 2) ∧ h ∉ F.coloursAt (v - e (α + π / 2)) ∧
          v + e (α + π / 2) ∈ closure (F.region h) ∧ F.OutType v h (v + e (α + π / 2)) ∧
          ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α (-1) κ₂ r ⊆ shadow (F.region h))) :=
  flankQ_lower hF hv hH hh hcS fun _ _ _ _ h => hQR _ _ _ _ _ h

/-- **A (Q) arc read a whole number of turns later** is the same (Q) arc: `ringPt` is `2π`-periodic. -/
theorem IsQArc.add_int_mul {P : ℂ} {θ₁ θ₂ : ℝ} (h : F.IsQArc P θ₁ θ₂) (m : ℤ) :
    F.IsQArc P (θ₁ + 2 * π * m) (θ₂ + 2 * π * m) := by
  obtain ⟨d, d', ⟨h12, hsub, hcol⟩, hd, hd', h4⟩ := h
  have hpt : ∀ θ, ringPt P (θ + 2 * π * m) = ringPt P θ := fun θ => by
    simp only [ringPt, e_add_int_mul]
  have harc : ringArc P (θ₁ + 2 * π * m) (θ₂ + 2 * π * m) = ringArc P θ₁ θ₂ := by
    ext z
    simp only [ringArc, mem_image, mem_Icc]
    constructor
    · rintro ⟨θ, ⟨h1, h2⟩, rfl⟩
      exact ⟨θ - 2 * π * m, ⟨by linarith, by linarith⟩, by rw [← hpt (θ - 2 * π * m), sub_add_cancel]⟩
    · rintro ⟨θ, ⟨h1, h2⟩, rfl⟩
      exact ⟨θ + 2 * π * m, ⟨by linarith, by linarith⟩, hpt θ⟩
  refine ⟨d, d', ⟨by linarith, harc ▸ hsub, fun θ hθ => ?_⟩, hd, hd', h4⟩
  have := hcol (θ - 2 * π * m) ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
  rwa [← hpt (θ - 2 * π * m), sub_add_cancel] at this

/-! ## FS114-CV-HD: CV-L0, the main clause, the equivalences, CV-CLASS -/

/-- **FS114-CV-HD, (CV-L0)**: in a terminal valid map a stuck vertex with at most three colours centres no unit arc, so `Γ ∩ ω(E)` is
finite. No model of a stuck vertex in a terminal valid plane map is known (`GENERIC`: FS-115's question); `bowtie` inhabits the local
hypotheses on a fragment. -/
theorem cv_l0 (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard ≤ 3) :
    (∀ x, ¬ F.OnRingArc E x) ∧ (F.Γ ∩ sphere E 1).Finite := by
  obtain ⟨hF, hP, -, hQR⟩ := hM
  have hv : F.Covers E 1 := fun z _ => by rw [hP]; exact mem_univ z
  obtain ⟨c, m, hm, hc⟩ := hst.2.2.2
  obtain ⟨α, κ₁, κ₂, κ₃, κ₄, g, h, Hu, Hd, -, -, -, -, -, -, hcol, -, -, -, fa, fb, fa', fb', -⟩ :=
    stuck_structure_ua hF hv hst h3 hm hc
  -- every colour at `E` approaches `E` along `e α` and along `e (α + π)`
  have hanti : ∀ j ∈ F.coloursAt E, α ∈ coneAt (F.region j) E ∧ α + π ∈ coneAt (F.region j) E := by
    intro j hj
    rw [hcol] at hj
    simp only [mem_insert_iff, mem_singleton_iff] at hj
    rcases hj with rfl | rfl | rfl
    · exact ⟨Hu.mem_coneAt_region, Hd.mem_coneAt_region⟩
    · exact ⟨fa.mem_coneAt, fb'.mem_coneAt⟩
    · exact ⟨fb.mem_coneAt, fa'.mem_coneAt⟩
  have hno : ∀ x, ¬ F.OnRingArc E x := by
    intro x hx
    obtain ⟨a, b, d, d', hab, hR, -⟩ := exists_isRingArc_of_onRingArc hx one_pos
    -- its outer colour is carried at `E`: it is (Q) or (R2)
    have hmid : (a + b) / 2 ∈ Ioo a b := ⟨by linarith, by linarith⟩
    have hd' : d' ∈ F.coloursAt E := by
      rcases hQR _ _ _ _ _ hR with ⟨e₁, e₂, hR', -, he₂, -⟩ | ⟨e₁, e₂, hR', he₂, -, -⟩
      · have h12 := (hR.2.2 _ hmid).2.symm.trans (hR'.2.2 _ hmid).2
        rw [Set.singleton_eq_singleton_iff] at h12
        rw [h12]; exact he₂
      · have h12 := (hR.2.2 _ hmid).2.symm.trans (hR'.2.2 _ hmid).2
        rw [Set.singleton_eq_singleton_iff] at h12
        rw [h12]; exact he₂
    -- the outer colour's cone at the centre is shorter than `π` (U1), and holds `α` and `α + π`
    obtain ⟨h1, h2⟩ := hanti d' hd'
    have hcone := ringArc_cone_outer hF hR
    exact not_mem_angleIcc_add_pi (by linarith) (hcone h1) (hcone h2)
  exact ⟨hno, (F.finite_ringΓ_off_ringArc hv).subset fun x hx => ⟨hx, hno x⟩⟩

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

/-! ## NB3-END item 2: two sectors of the upper flank at `S′` (FS131-I5i, E5 § 3.4 over SEP) -/

/-- **Two sectors of one chart tangent along one direction are ordered by curvature** (E5 § 3.4, F6): if sector `j` is a horn along
`e β` (`nextβ j = β j`) and sector `i ≠ j` starts at a germ of the same direction and turns a half-turn, then `j`'s upper germ curves no
more than `i`'s first one — else the two sectors meet at small radius. -/
theorem nextκ_le_of_disjoint {P : ℂ} {n : ℕ} {G : BranchGerms n} {r₀ : ℝ} (hC : F.IsSectorChart G P r₀) {i j : Fin n}
    (hij : i ≠ j) (hj : G.nextβ j = G.β j) (hji : e (G.β j) = e (G.β i)) (hi : G.nextβ i = G.β i + π) :
    G.nextκ j ≤ G.κ i := by
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
  set x := (max (G.κ i) (G.κ j) + G.nextκ j) / 2 with hx
  have hx1 : max (G.κ i) (G.κ j) < x := by rw [hx]; linarith [max_lt hlt hκj]
  have hx2 : x < G.nextκ j := by rw [hx]; linarith [max_lt hlt hκj]
  have hbi := abs_half_lt_one (hC.curv i) hs0.le hsr
  have hbj := abs_half_lt_one (hC.curv j) hs0.le hsr
  have hbn := abs_half_lt_one (hC.curv (BranchGerms.next j)) hs0.le hsr
  have hbni := abs_half_lt_one (hC.curv (BranchGerms.next i)) hs0.le hsr
  rw [← BranchGerms.nextκ_eq] at hbn hbni
  rw [abs_lt] at hbi hbj hbn hbni
  have hxs1 : -1 ≤ x * s / 2 := by nlinarith [le_max_left (G.κ i) (G.κ j)]
  have hxs2 : x * s / 2 ≤ 1 := by nlinarith
  have hai : Real.arcsin (G.κ i * s / 2) < Real.arcsin (x * s / 2) :=
    Real.arcsin_lt_arcsin hbi.1.le (by nlinarith [le_max_left (G.κ i) (G.κ j)]) hxs2
  have haj : Real.arcsin (G.κ j * s / 2) < Real.arcsin (x * s / 2) :=
    Real.arcsin_lt_arcsin hbj.1.le (by nlinarith [le_max_right (G.κ i) (G.κ j)]) hxs2
  have han : Real.arcsin (x * s / 2) < Real.arcsin (G.nextκ j * s / 2) :=
    Real.arcsin_lt_arcsin hxs1 (by nlinarith) hbn.2.le
  have hxpi : Real.arcsin (x * s / 2) < π / 2 := by rw [Real.arcsin_lt_pi_div_two]; nlinarith
  have hni := Real.neg_pi_div_two_le_arcsin (G.nextκ i * s / 2)
  set y := P + (s : ℂ) * e (G.β j + Real.arcsin (x * s / 2)) with hy
  have hyj : y ∈ G.sector P r₀ j :=
    ⟨s, ⟨hs0, hsr⟩, G.β j + Real.arcsin (x * s / 2), ⟨by linarith, by rw [hj]; linarith⟩, rfl⟩
  have hey : e (G.β j + Real.arcsin (x * s / 2)) = e (G.β i + Real.arcsin (x * s / 2)) := by
    rw [e_add, e_add, hji]
  have hyi : y ∈ G.sector P r₀ i :=
    ⟨s, ⟨hs0, hsr⟩, G.β i + Real.arcsin (x * s / 2), ⟨by linarith, by rw [hi]; linarith⟩, by rw [hy, hey]⟩
  exact Set.disjoint_left.mp (hC.disjoint r₀ ⟨hC.pos, le_rfl⟩ i j hij) hyi hyj

/-- **A point of the lower half-disc sector on the `−a` side lies below its first germ** (sign care: a germ of direction `α + π` and
curvature `κ` is the arc of upward curvature `−κ` in the frame at `α`). -/
theorem tanBelow_of_mem_sector {P : ℂ} {α : ℝ} {n : ℕ} {G : BranchGerms n} {r₀ : ℝ} (hC : F.IsSectorChart G P r₀)
    {i : Fin n} {m : ℤ} (hβ : G.β i = α + π + 2 * π * m) (hnb : G.nextβ i = G.β i + π) {r : ℝ} (hr : r ∈ Ioc 0 r₀)
    {y : ℂ} (hy : y ∈ G.sector P r i) (hx : frameX P α y < 0) : TanBelow P α (-G.κ i) y := by
  have hπ := Real.pi_pos
  obtain ⟨s, hs, φ, hφ, rfl⟩ := hy
  obtain ⟨hX, hY⟩ := frame_polar P α s φ
  have hb := abs_half_lt_one (hC.curv i) hs.1.le (lt_of_lt_of_le hs.2 hr.2)
  rw [abs_lt] at hb
  set θ := φ - G.β i with hθ
  have hφα : φ - α = θ + π + 2 * π * m := by rw [hθ, hβ]; ring
  have hcos : Real.cos (φ - α) = -Real.cos θ := by
    rw [hφα, show θ + π + 2 * π * (m : ℝ) = (θ + π) + (m : ℤ) * (2 * π) by ring, Real.cos_add_int_mul_two_pi,
      Real.cos_add_pi]
  have hsin : Real.sin (φ - α) = -Real.sin θ := by
    rw [hφα, show θ + π + 2 * π * (m : ℝ) = (θ + π) + (m : ℤ) * (2 * π) by ring, Real.sin_add_int_mul_two_pi,
      Real.sin_add_pi]
  have hθ1 : Real.arcsin (G.κ i * s / 2) < θ := by rw [hθ]; linarith [hφ.1]
  have hθ2 : θ < π + Real.arcsin (G.nextκ i * s / 2) := by rw [hθ]; linarith [hφ.2, hnb]
  have ha1 := Real.neg_pi_div_two_le_arcsin (G.κ i * s / 2)
  have ha2 := Real.arcsin_le_pi_div_two (G.nextκ i * s / 2)
  have hcθ : 0 < Real.cos θ := by
    rw [hX, hcos] at hx; nlinarith [hs.1]
  have hθ3 : θ < π / 2 := by
    by_contra hge; push Not at hge
    have : Real.cos θ ≤ 0 := Real.cos_nonpos_of_pi_div_two_le_of_le hge (by linarith)
    linarith
  have hsinθ : G.κ i * s / 2 < Real.sin θ := by
    have := Real.sin_lt_sin_of_lt_of_le_pi_div_two ha1 hθ3.le hθ1
    rwa [Real.sin_arcsin hb.1.le hb.2.le] at this
  unfold TanBelow tanHeight
  rw [hX, hY, hcos, hsin]
  have hs2 : (s * -Real.cos θ) ^ 2 + (s * -Real.sin θ) ^ 2 = s ^ 2 := by
    nlinarith [Real.sin_sq_add_cos_sq θ]
  rw [hs2]
  nlinarith [hs.1]

/-- **A horn sector along `−a` reaches the point above every arc of upward curvature `−κ` with `κ` at least its upper germ's
curvature** (on the `−a` side, arbitrarily near the point). -/
theorem exists_tanAbove_of_sector {P : ℂ} {α κ : ℝ} {n : ℕ} {G : BranchGerms n} {r₀ : ℝ}
    (hC : F.IsSectorChart G P r₀) {j : Fin n} {m : ℤ} (hβ : G.β j = α + π + 2 * π * m) (hnb : G.nextβ j = G.β j)
    (hκ : G.nextκ j ≤ κ) {r : ℝ} (hr : r ∈ Ioc 0 r₀) :
    ∀ ρ > 0, ∃ y ∈ G.sector P r j, dist y P < ρ ∧ frameX P α y < 0 ∧ TanAbove P α (-κ) y := by
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
  have hφα : φ - α = θ + π + 2 * π * m := by rw [hφ, hβ]; ring
  have hcos : Real.cos (φ - α) = -Real.cos θ := by
    rw [hφα, show θ + π + 2 * π * (m : ℝ) = (θ + π) + (m : ℤ) * (2 * π) by ring, Real.cos_add_int_mul_two_pi,
      Real.cos_add_pi]
  refine ⟨P + (s : ℂ) * e φ, ⟨s, ⟨hs0, hsr⟩, φ, ⟨by rw [hφ, hθ]; linarith, by rw [hnb, hφ, hθ]; linarith⟩, rfl⟩,
    ?_, ?_, ?_⟩
  · rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hs0,
      mul_one]
    exact hsρ
  · rw [hX, hcos]
    have : 0 < Real.cos θ := Real.cos_pos_of_mem_Ioo ⟨by rw [hθ]; linarith, by rw [hθ]; linarith⟩
    nlinarith
  · have hsin : Real.sin (φ - α) = -Real.sin θ := by
      rw [hφα, show θ + π + 2 * π * (m : ℝ) = (θ + π) + (m : ℤ) * (2 * π) by ring, Real.sin_add_int_mul_two_pi,
        Real.sin_add_pi]
    have hsinθ : Real.sin θ < G.nextκ j * s / 2 := by
      have := Real.sin_lt_sin_of_lt_of_le_pi_div_two (by rw [hθ]; linarith) hB1.le (show θ < B by rw [hθ]; linarith)
      rwa [hB, Real.sin_arcsin hb2.1.le hb2.2.le] at this
    have hκs : G.nextκ j * s / 2 ≤ κ * s / 2 := by nlinarith
    unfold TanAbove tanHeight
    rw [hX, hY, hcos, hsin]
    have hs2 : (s * -Real.cos θ) ^ 2 + (s * -Real.sin θ) ^ 2 = s ^ 2 := by
      nlinarith [Real.sin_sq_add_cos_sq θ]
    rw [hs2]
    nlinarith

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

/-- **The opposite horn** (N4-STUCK (i) read at a given horn's axis): at a stuck vertex where `c` has two sectors, a `c`-horn along `e α`
has a partner `c`-horn along `e (α + π)`, with bounds in `[−1, 1]`. -/
theorem exists_horn_add_pi_of_stuck (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) (hst : F.IsStuck v) {c : Fin k}
    (hc2 : F.HasSectors v c 2) {α κ₁ κ₂ : ℝ} (hH : F.IsHorn v α κ₁ κ₂ c) :
    ∃ κ₃ κ₄, F.IsHorn v (α + π) κ₃ κ₄ c ∧ -1 ≤ κ₃ ∧ κ₄ ≤ 1 := by
  have hvd : v ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  obtain ⟨hM, hR, hSh, -⟩ := hst
  have hcv : c ∈ F.coloursAt v := mem_closure_of_mem_coneAt hH.mem_coneAt_region
  have hD : interior (F.allowedCone v c) = ∅ := by
    by_contra hne
    exact hM ⟨c, 2, le_rfl, hc2, nonempty_iff_ne_empty.mpr hne⟩
  obtain ⟨α', -, -, hev⟩ := woodallCone_isHorn_ua hF hv hcv hD
  obtain ⟨r, ⟨⟨hrH, hr2⟩, hrh⟩, hr0⟩ := (((hev.and hc2).and hH.2).and self_mem_nhdsWithin).exists
  have hr0' : (0 : ℝ) < r := hr0
  obtain ⟨β, hβ, κ, κ', -, -, -, hSeq⟩ := hrH _ ⟨hrh.1, hrh.2⟩
  have heq : e α = e β := by
    have := mem_coneAt_hornSet v α hH.1 hr0'
    rw [hSeq] at this
    exact e_eq_of_mem_coneAt_hornSet this
  have h1 : 1 < (F.sectorsOf v r c).encard := by rw [hr2]; norm_num
  obtain ⟨x, y, hx, hy, hxy⟩ := one_lt_encard_iff.mp h1
  obtain ⟨βx, hβx, a₁, a₂, ha₁, ha₂, Hx, hxe⟩ := hrH x hx
  obtain ⟨βy, hβy, b₁, b₂, hb₁, hb₂, Hy, hye⟩ := hrH y hy
  have hβne : βx ≠ βy := by
    intro he
    rw [he] at Hx hxe
    obtain ⟨e1, e2⟩ := horn_unique_of_stuck hF hvd hR hSh Hx Hy
    exact hxy (by rw [hxe, hye, e1, e2])
  have hαπ : e (α + π) = e (β + π) := by rw [e_add_pi, e_add_pi, heq]
  -- the direction opposite `β` among `{α', α' + π}`
  obtain ⟨γ, hγ, hγe⟩ : ∃ γ, (γ = βx ∨ γ = βy) ∧ e γ = e (β + π) := by
    simp only [mem_insert_iff, mem_singleton_iff] at hβ hβx hβy
    have h2π : e (α' + π + π) = e α' := by rw [show α' + π + π = α' + 2 * π by ring, e_add_two_pi]
    rcases hβ with rfl | rfl <;> rcases hβx with rfl | rfl <;> rcases hβy with rfl | rfl <;>
      first
      | exact absurd rfl hβne
      | exact ⟨_, Or.inl rfl, rfl⟩
      | exact ⟨_, Or.inr rfl, rfl⟩
      | exact ⟨_, Or.inl rfl, h2π.symm⟩
      | exact ⟨_, Or.inr rfl, h2π.symm⟩
  rcases hγ with rfl | rfl
  · exact ⟨a₁, a₂, Hx.congr (hγe.trans hαπ.symm), ha₁, ha₂⟩
  · exact ⟨b₁, b₂, Hy.congr (hγe.trans hαπ.symm), hb₁, hb₂⟩

/-- **NB3-END item 2, derived (E5 § 3.4)**: in `n3_end_of_not_inType`'s setting the upper flank colour `g` has at least two sectors at
`S′ = v − n` for every small radius. -/
theorem flank_two_sectors_at_S (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {α κ₂ : ℝ} {c : Fin k}
    (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) κ₂ c)
    (hno : ∀ g, F.IsFlankAbove v α κ₂ g → ¬ (F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)))) :
    ∃ g, F.IsFlankAbove v α κ₂ g ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf (v - e (α + π / 2)) r g).encard := by
  have hπ := Real.pi_pos
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  have hv := hvC v
  set S := v - e (α + π / 2) with hSdef
  set N := v + e (α + π / 2) with hNdef
  obtain ⟨κ₃, κ₄, Hd, h3', h4⟩ := exists_horn_add_pi_of_stuck hF hv hst hc2 hH
  obtain ⟨-, h2⟩ := horn_bounds_of_noMerge hF hv hst.1 le_rfl hc2 hH
  obtain ⟨hcN, hcS⟩ := horn_poles_contact hF hv hst.1 le_rfl hc2 hH
  obtain ⟨g, h, -, -, -, hgc, -, hgu, hhu, hhd, hgd, -⟩ :=
    stuck_flanks_ua hF hv hst h3.le hH Hd le_rfl h2 h3' h4 hc2 hcN hcS
  refine ⟨g, hgu, ?_⟩
  have hgv : g ∈ F.coloursAt v := mem_closure_of_mem_coneAt hgu.mem_coneAt
  have hNv : dist N v = 1 := by rw [hNdef, dist_eq_norm, add_sub_cancel_left, norm_e]
  -- `N` is not in `g`'s closure when a bound reaches `ω(N)` from the `g` side
  have hNg : κ₂ = 1 ∨ κ₃ = -1 → N ∉ closure (F.region g) := by
    intro hκ hNcl
    have hcont : F.IsContact v g N := ⟨hgv, hNv, hNcl⟩
    rcases (contact_inType_or_outType hF hv hcont).1 with hin | hout
    · exact hno g hgu ⟨hcont, hin⟩
    · rcases hκ with hκ | hκ
      · subst hκ; exact not_outType_N_of_flankAbove_one hF hv hgu hNcl hout
      · subst hκ
        have := not_outType_S_of_flankBelow_neg_one hF hv hgd (by rw [sub_e_add_pi_add]; exact hNcl)
        rw [sub_e_add_pi_add] at this
        exact this hout
  -- the `g`-shadow on both horns (no SHAVE), localized at `S′`
  obtain ⟨shH, -⟩ := shadow_of_not_shave hst.2.2.1 hH hgu hhu
  obtain ⟨-, shHd⟩ := shadow_of_not_shave hst.2.2.1 Hd hhd hgd
  have L1 := fun δ (hδ : 0 < δ) => witness_near_S_upper hF hv h2 hgu (fun h => hNg (Or.inl h)) hδ
  have L2 := fun δ (hδ : 0 < δ) => witness_near_S_lower hF hv h3' h4 hgd (fun h => hNg (Or.inr h)) hδ
  -- `g` is out-type at `S′`
  have hgS : F.IsContact v g S ∧ F.OutType v g S := by
    rcases srcG_of_shadow hF hv le_rfl hH.1 h2 hgu shH with hin | hout
    · exact absurd hin (hno g hgu)
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
  -- the witnesses, with their directions
  have W1 := exists_witness_dir (v := v) (α := α) (Or.inl rfl) (H := fun ρ => hornSet v α (-1) κ₂ ρ)
    (W := F.region g) (fun ρ z hz => ⟨hz.1, by rw [one_mul]; exact hz.2.1, abs_frameY_le_of_mem_hornSet le_rfl h2 hz,
      (tanAbove_neg_one_iff v α z).mp hz.2.2.1⟩)
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
  obtain ⟨φ, hφ, hφπ, hU1⟩ := coneAt_S_subset_of_horn hF hH h2
  have hdisj := hM.disjoint hji
  rw [hβ0, hnβ0] at hdisj
  obtain ⟨hjj, m', hβj⟩ := angle_pinch hφ hφπ (hM j) (hconej.trans hU1) hdisj
  have hβjmem : G.β j ∈ angleIcc (G.β j) (G.nextβ j) := Icc_subset_angleIcc _ _ ⟨le_rfl, hM j⟩
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

/-- **A horn whose lower arc is on `ω(S′)`, with a lower flank, is bounded by an arc of `Γ` on `ω(S′)` with constant sides** (inner colour
the flank's, outer the horn's), ending at `v`. A copy, under its own name, of wave 4's `IsHorn.isRingArc_lower` (engine 5, `UnitArc` on
`main`), which this branch does not carry (it is off wave 4's landing; `main`'s `fromFrame` is this branch's `framePt`); at the merge with
`main` it collapses to a citation of that lemma. Model of the hypotheses: `bowtie` at `0`, `α = 0` (`bowtie_isHorn`, `bowtie_flanks`). -/
theorem IsHorn.isRingArc_lower_ua {v : ℂ} (hv : F.Covers v 1) {α κ₂ : ℝ} {c h : Fin k}
    (hH : F.IsHorn v α (-1) κ₂ c) (hh : F.IsFlankBelow v α (-1) h) :
    ∃ θ₁, θ₁ < α + π / 2 ∧ F.IsRingArc (v - e (α + π / 2)) θ₁ (α + π / 2) h c := by
  have hπ := Real.pi_pos
  have hπ3 := Real.pi_gt_three
  obtain ⟨hκ₂, hHev⟩ := hH
  obtain ⟨κ', hκ', hhev⟩ := hh
  obtain ⟨r, ⟨⟨hsec, hcol⟩, hfl⟩, hr0⟩ :=
    ((hHev.and hhev).and (Ioo_mem_nhdsGT (show (0 : ℝ) < 1 / 2 by norm_num))).exists
  set S := v - e (α + π / 2) with hS
  obtain ⟨x₀, -, hHeq, hvH⟩ := hsec
  have hHI : hornSet v α (-1) κ₂ r ⊆ F.interiorPts := by
    rw [hHeq]; exact (connectedComponentIn_subset _ _).trans inter_subset_left
  have hFlI : hornSet v α κ' (-1) r ⊆ F.interiorPts := fun z hz => (hfl hz).1
  have hjoin : ∀ B : Set ℂ, IsPreconnected B → B ⊆ F.interiorPts ∩ ball v r → ∀ p ∈ B, p ∈ hornSet v α (-1) κ₂ r →
      B ⊆ hornSet v α (-1) κ₂ r := by
    intro B hB hBsub p hpB hpH
    rw [hHeq] at hpH ⊢
    rw [connectedComponentIn_eq hpH]
    exact hB.subset_connectedComponentIn hpB hBsub
  set O : Set ℂ := {z | dist z v < r ∧ 0 < frameX v α z ∧ TanAbove v α κ' z ∧ TanBelow v α κ₂ z} with hOdef
  have hOopen : IsOpen O := by
    have hfx : Continuous (frameX v α) := by unfold frameX; fun_prop
    have ht : ∀ κ : ℝ, Continuous fun z => tanHeight κ (frameX v α z) (frameY v α z) := fun κ => by
      unfold tanHeight frameX frameY; fun_prop
    exact (isOpen_lt (continuous_id.dist continuous_const) continuous_const).inter
      ((isOpen_lt continuous_const hfx).inter ((isOpen_lt continuous_const (ht κ')).inter (isOpen_lt (ht κ₂) continuous_const)))
  have hOball : O ⊆ ball v r := fun z hz => hz.1
  have hOH : ∀ z ∈ O, 1 < dist z S → z ∈ hornSet v α (-1) κ₂ r := fun z hz hz' =>
    ⟨hz.1, hz.2.1, (tanAbove_neg_one_iff v α z).mpr hz', hz.2.2.2⟩
  have hOF : ∀ z ∈ O, dist z S < 1 → z ∈ hornSet v α κ' (-1) r := fun z hz hz' =>
    ⟨hz.1, hz.2.1, hz.2.2.1, (tanBelow_neg_one_iff v α z).mpr hz'⟩
  have hHS : ∀ z ∈ hornSet v α (-1) κ₂ r, 1 < dist z S := fun z hz => (tanAbove_neg_one_iff v α z).mp hz.2.2.1
  have hdS : ∀ ρ θ : ℝ, 0 ≤ ρ → dist (S + (ρ : ℂ) * e θ) S = ρ := fun ρ θ hρ => by
    rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg hρ]
  have hdd : ∀ ρ θ : ℝ, dist (S + (ρ : ℂ) * e θ) (S + e θ) = |ρ - 1| := fun ρ θ => by
    rw [dist_eq_norm, show S + (ρ : ℂ) * e θ - (S + e θ) = ((ρ - 1 : ℝ) : ℂ) * e θ by push_cast; ring, norm_mul, norm_e, mul_one,
      Complex.norm_real, Real.norm_eq_abs]
  set τ := min (r / 2) 1 with hτ
  have hτ0 : 0 < τ := lt_min (by linarith [hr0.1]) one_pos
  have hτr : τ ≤ r / 2 := min_le_left _ _
  have hτ1 : τ ≤ 1 := min_le_right _ _
  have hapt : ∀ t, ringPt S (α + π / 2 - t) = framePt v α (Real.sin t) (-(1 - Real.cos t)) := fun t =>
    ringPt_S_sub_eq_framePt v α t
  have hadist : ∀ t, 0 ≤ t → dist (ringPt S (α + π / 2 - t)) v ≤ t := by
    intro t ht
    have h := frame_normSq v α (ringPt S (α + π / 2 - t))
    rw [hapt, frameX_framePt, frameY_framePt, ← hapt, ← dist_eq_norm] at h
    have hc := Real.one_sub_sq_div_two_le_cos (x := t)
    have hsc := Real.sin_sq_add_cos_sq t
    have h2 : dist (ringPt S (α + π / 2 - t)) v ^ 2 ≤ t ^ 2 := by nlinarith
    nlinarith [dist_nonneg (x := ringPt S (α + π / 2 - t)) (y := v)]
  have hainO : ∀ t ∈ Ioc 0 τ, ringPt S (α + π / 2 - t) ∈ O := by
    intro t ht
    have hcos : Real.cos t < 1 := by
      have := Real.cos_lt_cos_of_nonneg_of_le_pi (le_refl 0) (by linarith [ht.2, hτ1]) ht.1
      rwa [Real.cos_zero] at this
    have hsin : 0 < Real.sin t := Real.sin_pos_of_pos_of_lt_pi ht.1 (by linarith [ht.2, hτ1])
    have hsc := Real.sin_sq_add_cos_sq t
    refine ⟨by linarith [hadist t ht.1.le, hr0.1, ht.2, hτr], ?_, ?_, ?_⟩
    · rw [hapt, frameX_framePt]; exact hsin
    · unfold TanAbove; rw [hapt, frameX_framePt, frameY_framePt]; unfold tanHeight
      nlinarith
    · unfold TanBelow; rw [hapt, frameX_framePt, frameY_framePt]; unfold tanHeight
      nlinarith
  have hnotI : ∀ t ∈ Ioc 0 τ, ringPt S (α + π / 2 - t) ∉ F.interiorPts := by
    intro t ht hI
    set a := ringPt S (α + π / 2 - t) with ha
    obtain ⟨δ, hδ, hball⟩ := Metric.isOpen_iff.mp (F.isOpen_interiorPts.inter hOopen) a ⟨hI, hainO t ht⟩
    have hae : a = S + e (α + π / 2 - t) := rfl
    set s := min (δ / 2) (1 / 2) with hs
    have hs0 : 0 < s := lt_min (by linarith) (by norm_num)
    have hsδ : s < δ := lt_of_le_of_lt (min_le_left _ _) (by linarith)
    have hs1 : s ≤ 1 / 2 := min_le_right _ _
    have hout : S + ((1 + s : ℝ) : ℂ) * e (α + π / 2 - t) ∈ ball a δ := by
      rw [mem_ball, hae, hdd, abs_of_pos (by linarith)]; linarith
    have hin : S + ((1 - s : ℝ) : ℂ) * e (α + π / 2 - t) ∈ ball a δ := by
      rw [mem_ball, hae, hdd, abs_of_neg (by linarith)]; linarith
    have hBsub : ball a δ ⊆ F.interiorPts ∩ ball v r := fun z hz => ⟨(hball hz).1, hOball (hball hz).2⟩
    have houtH := hOH _ (hball hout).2 (by rw [hdS _ _ (by linarith)]; linarith)
    have hsub := hjoin (ball a δ) (convex_ball a δ).isPreconnected hBsub _ hout houtH
    have := hHS _ (hsub hin)
    rw [hdS _ _ (by linarith)] at this
    linarith
  have hvnotI : v ∉ F.interiorPts := by
    intro hI
    obtain ⟨δ, hδ, hball⟩ := Metric.isOpen_iff.mp F.isOpen_interiorPts v hI
    set δ' := min δ r with hδ'
    have hδ'0 : 0 < δ' := lt_min hδ hr0.1
    have hBsub : ball v δ' ⊆ F.interiorPts ∩ ball v r := fun z hz =>
      ⟨hball (ball_subset_ball (min_le_left _ _) hz), ball_subset_ball (min_le_right _ _) hz⟩
    obtain ⟨p, hpB, hpH⟩ := mem_closure_iff.mp hvH (ball v δ') isOpen_ball (mem_ball_self hδ'0)
    have hsub := hjoin (ball v δ') (convex_ball v δ').isPreconnected hBsub p hpB hpH
    have hq : framePt v α (-(δ' / 2)) 0 ∈ ball v δ' := by
      rw [mem_ball, dist_eq_norm]
      unfold framePt
      rw [show v + ((((-(δ' / 2) : ℝ) : ℂ) + ((0 : ℝ) : ℂ) * I)) * e α - v = ((-(δ' / 2) : ℝ) : ℂ) * e α by push_cast; ring,
        norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_neg, abs_of_pos (by linarith)]
      linarith
    have := (hsub hq).2.1
    rw [frameX_framePt] at this
    linarith
  have hdomv : ∀ z, dist z v < r → z ∈ F.dom := fun z hz => hv (by rw [mem_closedBall]; linarith [hr0.2])
  have hΓ : ringArc S (α + π / 2 - τ) (α + π / 2) ⊆ F.Γ := by
    rintro _ ⟨θ, hθ, rfl⟩
    have hθe : θ = α + π / 2 - (α + π / 2 - θ) := by ring
    rcases (show 0 ≤ α + π / 2 - θ by linarith [hθ.2]).eq_or_lt with h0 | hpos
    · have hθ0 : θ = α + π / 2 := by linarith
      have hv' : ringPt S θ = v := by
        rw [hθ0, show α + π / 2 = α + π / 2 - 0 by ring, hapt]; simp [framePt]
      rw [hv']
      exact ⟨hdomv v (by rw [dist_self]; exact hr0.1), not_not.mp fun h => hvnotI ⟨hdomv v (by rw [dist_self]; exact hr0.1), h⟩⟩
    · have ht : α + π / 2 - θ ∈ Ioc 0 τ := ⟨hpos, by linarith [hθ.1]⟩
      rw [hθe]
      have hd := hdomv _ (hainO _ ht).1
      exact ⟨hd, not_not.mp fun h => hnotI _ ht ⟨hd, h⟩⟩
  have hclean : ∀ θ ∈ Ioo (α + π / 2 - τ) (α + π / 2), ∃ δ > 0, ball (ringPt S θ) δ ⊆ F.dom ∧
      ∀ z ∈ ball (ringPt S θ) δ, z ∈ ⋃ a ∈ F.arcs, a.carrier → dist z S = 1 := by
    intro θ hθ
    have ht : α + π / 2 - θ ∈ Ioc 0 τ := ⟨by linarith [hθ.2], by linarith [hθ.1]⟩
    have hmem := hainO _ ht
    rw [show α + π / 2 - (α + π / 2 - θ) = θ by ring] at hmem
    obtain ⟨δ, hδ, hball⟩ := Metric.isOpen_iff.mp hOopen _ hmem
    refine ⟨δ, hδ, fun z hz => hdomv z (hball hz).1, fun z hz hza => ?_⟩
    have hzO := hball hz
    by_contra hne
    rcases lt_or_gt_of_ne hne with h' | h'
    · exact (hFlI (hOF z hzO h')).2 hza
    · exact (hHI (hOH z hzO h')).2 hza
  obtain ⟨c₀, c₀', hR⟩ := isRingArc_of_clean (by linarith) hΓ hclean
  set m := α + π / 2 - τ / 2 with hm
  have hmI : m ∈ Ioo (α + π / 2 - τ) (α + π / 2) := ⟨by linarith, by linarith⟩
  have hmO : ringPt S m ∈ O := hainO (τ / 2) ⟨by linarith, by linarith⟩
  obtain ⟨δ, hδ, hball⟩ := Metric.isOpen_iff.mp hOopen _ hmO
  have hme : ringPt S m = S + e m := rfl
  have hhin : h ∈ F.innerColours S (ringPt S m) := by
    show ringPt S m ∈ closure (F.region h ∩ ball S 1)
    rw [Metric.mem_closure_iff]
    intro ε hε
    set s := min (min (ε / 2) (δ / 2)) (1 / 2) with hs
    have hs0 : 0 < s := lt_min (lt_min (by linarith) (by linarith)) (by norm_num)
    have hs1 := min_le_left (min (ε / 2) (δ / 2)) (1 / 2)
    have hs2 := min_le_right (min (ε / 2) (δ / 2)) (1 / 2)
    have hs3 := min_le_left (ε / 2) (δ / 2)
    have hs4 := min_le_right (ε / 2) (δ / 2)
    have hd1 : dist (S + ((1 - s : ℝ) : ℂ) * e m) (ringPt S m) = s := by
      rw [hme, hdd, abs_of_neg (by linarith)]; ring
    have hbO : S + ((1 - s : ℝ) : ℂ) * e m ∈ O := hball (by rw [mem_ball, hd1]; linarith)
    have hbS : dist (S + ((1 - s : ℝ) : ℂ) * e m) S < 1 := by rw [hdS _ _ (by linarith)]; linarith
    refine ⟨_, ⟨hfl (hOF _ hbO hbS), hbS⟩, ?_⟩
    rw [dist_comm, hd1]; linarith
  have hcout : c ∈ F.outerColours S (ringPt S m) := by
    show ringPt S m ∈ closure (F.region c \ closedBall S 1)
    rw [Metric.mem_closure_iff]
    intro ε hε
    set s := min (ε / 2) (δ / 2) with hs
    have hs0 : 0 < s := lt_min (by linarith) (by linarith)
    have hs3 := min_le_left (ε / 2) (δ / 2)
    have hs4 := min_le_right (ε / 2) (δ / 2)
    have hd1 : dist (S + ((1 + s : ℝ) : ℂ) * e m) (ringPt S m) = s := by
      rw [hme, hdd, abs_of_pos (by linarith)]; ring
    have hbO : S + ((1 + s : ℝ) : ℂ) * e m ∈ O := hball (by rw [mem_ball, hd1]; linarith)
    have hbS : 1 < dist (S + ((1 + s : ℝ) : ℂ) * e m) S := by rw [hdS _ _ (by linarith)]; linarith
    have hbH := hOH _ hbO hbS
    refine ⟨_, ⟨⟨hHI hbH, hcol hbH⟩, by rw [mem_closedBall, not_le]; exact hbS⟩, ?_⟩
    rw [dist_comm, hd1]; linarith
  have hhc : h = c₀ := by
    have := (hR.2.2 m hmI).1 ▸ hhin; exact this
  have hcc : c = c₀' := by
    have := (hR.2.2 m hmI).2 ▸ hcout; exact this
  subst hhc hcc
  exact ⟨α + π / 2 - τ, by linarith, hR⟩

/-- **A direction of a colour's class at a point is a direction of one of its sectors** (sector chart; off the interior points). -/
theorem exists_mem_sectorsOf_of_mem_coneAt {x : ℂ} (hx : x ∈ F.dom) (hxI : x ∉ F.interiorPts) {j : Fin k} {β : ℝ}
    (hβ : β ∈ coneAt (F.region j) x) : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∃ T ∈ F.sectorsOf x r j, β ∈ coneAt T x := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hx
  have hn : 0 < n := by
    rw [← hC.mem_Γ]
    exact ⟨hx, by by_contra h; exact hxI ⟨hx, h⟩⟩
  filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
  set I : Set (Fin n) := {i | G.sector x r i ⊆ F.col ⁻¹' {j}} with hI
  have h1 := coneAt_inter_ball hr.1 hβ
  have h2 : F.region j ∩ ball x r ⊆ ⋃ i ∈ I, G.sector x r i := by
    intro y ⟨hy, hyr⟩
    have hyc : y ∈ ball x r ∩ F.interiorPts := ⟨hyr, hy.1⟩
    rw [hC.cover r hr hn] at hyc
    obtain ⟨i, hi⟩ := mem_iUnion.mp hyc
    obtain ⟨g', hg'⟩ := hC.exists_col i
    have hgg : g' = j := ((hg' r hr hi).2).symm.trans hy.2
    exact mem_iUnion₂.mpr ⟨i, fun z hz => hgg ▸ (hg' r hr hz).2, hi⟩
  obtain ⟨i, hi, hβi⟩ := coneAt_biUnion_finite (Set.toFinite I) _ (coneAt_mono h2 x h1)
  exact ⟨G.sector x r i, ⟨(hC.isSector_iff hn hr).mpr ⟨i, rfl⟩, hi⟩, hβi⟩

/-- **At a stuck point, a direction of a repeated colour's class is the axis of one of its horns**, with the colour's out-type contact
at that horn's `−n` pole (N3-DEG's horns, `woodallCone_isHorn_ua`, located by the direction). Model of the hypotheses: `bowtie` at `0`, its
colour `1`, `β = 0` (`bowtie_isStuck`, `bowtie_coloursAt_zero`, `bowtie_isHorn`). -/
theorem exists_horn_of_mem_coneAt_of_stuck (hF : F.Valid) {w : ℂ} (hv : F.Covers w 1) (hst : F.IsStuck w)
    (hwI : w ∉ F.interiorPts) {g : Fin k} {m : ℕ} (hm : 2 ≤ m) (hg : F.HasSectors w g m) {β : ℝ}
    (hβ : β ∈ coneAt (F.region g) w) :
    ∃ κ₁ κ₂, -1 ≤ κ₁ ∧ κ₂ ≤ 1 ∧ F.IsHorn w β κ₁ κ₂ g ∧
      (F.IsContact w g (w - e (β + π / 2)) ∧ F.OutType w g (w - e (β + π / 2))) := by
  have hD : interior (F.allowedCone w g) = ∅ := by
    by_contra hne
    exact hst.1 ⟨g, m, hm, hg, nonempty_iff_ne_empty.mpr hne⟩
  have hgw : g ∈ F.coloursAt w := mem_closure_of_mem_coneAt hβ
  obtain ⟨α', hN', hS', hev⟩ := woodallCone_isHorn_ua hF hv hgw hD
  obtain ⟨r, hr1, T, hT, hβT⟩ :=
    (hev.and (exists_mem_sectorsOf_of_mem_coneAt (hv (mem_closedBall_self zero_le_one)) hwI hβ)).exists
  obtain ⟨γ, hγ, κ₁, κ₂, h1, h2, HT, hTeq⟩ := hr1 T hT
  have heq : e β = e γ := e_eq_of_mem_coneAt_hornSet (hTeq ▸ hβT)
  refine ⟨κ₁, κ₂, h1, h2, HT.congr heq.symm, ?_⟩
  have hep : e (β + π / 2) = e (γ + π / 2) := by rw [e_add, e_add, heq]
  rw [hep]
  simp only [mem_insert_iff, mem_singleton_iff] at hγ
  rcases hγ with rfl | rfl
  · exact hS'
  · rw [show α' + π + π / 2 = (α' + π / 2) + π by ring, e_add_pi, sub_neg_eq_add]; exact hN'

/-- **A lower flank on `ω(S′)` is never out-type at `v`, seen from `S′`**: its band lies inside `B(S′, 1)` and has `v` in its closure.
Model of the hypothesis: `bowtie` at `0`, `α = 0`, colour `2` (`bowtie_flanks`). -/
theorem not_outType_v_of_flankBelow_neg_one {v : ℂ} {α : ℝ} {h : Fin k} (hh : F.IsFlankBelow v α (-1) h) :
    ¬ F.OutType (v - e (α + π / 2)) h v := by
  intro hout
  obtain ⟨κ', hκ', hev⟩ := hh
  set ρ := min (1 / 2) (1 / (|κ'| + 1)) with hρ
  have hρ0 : 0 < ρ := lt_min (by norm_num) (by positivity)
  obtain ⟨r, hr, hr0⟩ := (hev.and (Ioc_mem_nhdsGT hρ0)).exists
  have hrr : |κ'| * r ≤ 2 := by
    have h1 : r ≤ 1 / (|κ'| + 1) := hr0.2.trans (min_le_right _ _)
    have h2 : |κ'| * r ≤ |κ'| * (1 / (|κ'| + 1)) := mul_le_mul_of_nonneg_left h1 (abs_nonneg _)
    have h3 : |κ'| * (1 / (|κ'| + 1)) ≤ 1 := by
      rw [mul_one_div, div_le_one (by positivity)]; linarith
    linarith
  have hr1 : |(-1 : ℝ)| * r ≤ 2 := by
    rw [abs_neg, abs_one, one_mul]; linarith [hr0.2, min_le_left (1 / 2 : ℝ) (1 / (|κ'| + 1))]
  have hpre := isPreconnected_hornSet_of_abs_le (v := v) (α := α) hκ' hrr hr1
  obtain ⟨z₀, hz₀, -, -⟩ := exists_mem_hornSet_aboveBelow v α (κ₁ := κ') (κ₂ := -1) (s := (κ' - 1) / 2) (m := 0)
    hr0.1 (by linarith) (by linarith) (by intro h'; linarith)
  have hsubI : hornSet v α κ' (-1) r ⊆ F.interiorPts := fun z hz => (hr hz).1
  have hT : F.IsTile (connectedComponentIn F.interiorPts z₀) := ⟨z₀, hsubI hz₀, rfl⟩
  have hz₀T : z₀ ∈ connectedComponentIn F.interiorPts z₀ := mem_connectedComponentIn (hsubI hz₀)
  have hTh : F.TileOf h (connectedComponentIn F.interiorPts z₀) := by
    have := hT.tileOf hz₀T
    rwa [show F.col z₀ = h from (hr hz₀).2] at this
  have hsub : hornSet v α κ' (-1) r ⊆ connectedComponentIn F.interiorPts z₀ :=
    hpre.subset_connectedComponentIn hz₀ hsubI
  have hvcl : v ∈ closure (connectedComponentIn F.interiorPts z₀) :=
    closure_mono hsub (mem_closure_of_mem_coneAt (mem_coneAt_hornSet v α hκ' hr0.1))
  have hdisj := hout _ hTh hvcl
  have hz₀S : z₀ ∈ closedBall (v - e (α + π / 2)) 1 :=
    mem_closedBall.mpr ((tanBelow_neg_one_iff v α z₀).mp hz₀.2.2.2).le
  exact Set.disjoint_left.mp hdisj hz₀T hz₀S

/-- **At a terminal map a point with a repeated colour is stuck**: no move is available anywhere, and the sector count of a colour is
eventually constant (`exists_hasSectors`), so "at least two sectors" is a count of at least two. Used inside refutation-shaped rows
(`n3_end_four_colours`, `n3_end_bothKind`): no model expected. -/
theorem isStuck_of_hasRepeatedColour (hT : F.Terminal) {x : ℂ} (hx : x ∈ F.dom) (hR : F.HasRepeatedColour x) :
    F.IsStuck x := by
  obtain ⟨g, hg⟩ := hR
  obtain ⟨n, hn⟩ := exists_hasSectors hx g
  obtain ⟨r, hr1, hr2⟩ := (hn.and hg).exists
  have h2 : (2 : ℕ∞) ≤ n := hr1 ▸ hr2
  obtain ⟨hM, hRy, hS⟩ := hT x (mem_univ x)
  exact ⟨hM, hRy, hS, g, n, by exact_mod_cast h2, hn⟩

/-- **The upper flank approaches `S′` along `α`** (E5's F2–F4, the first half of `flank_two_sectors_at_S`'s proof): in
`n3_end_of_not_inType`'s setting the upper flank colour's class has the direction `α` at `S′ = v − n`. A step inside a refutation-shaped row:
no model expected. -/
theorem flank_coneAt_S (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {α κ₂ : ℝ} {c : Fin k}
    (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) κ₂ c)
    (hno : ∀ g, F.IsFlankAbove v α κ₂ g → ¬ (F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)))) :
    ∃ g, F.IsFlankAbove v α κ₂ g ∧ α ∈ coneAt (F.region g) (v - e (α + π / 2)) := by
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  have hv := hvC v
  set S := v - e (α + π / 2) with hSdef
  set N := v + e (α + π / 2) with hNdef
  obtain ⟨κ₃, κ₄, Hd, h3', h4⟩ := exists_horn_add_pi_of_stuck hF hv hst hc2 hH
  obtain ⟨-, h2⟩ := horn_bounds_of_noMerge hF hv hst.1 le_rfl hc2 hH
  obtain ⟨hcN, hcS⟩ := horn_poles_contact hF hv hst.1 le_rfl hc2 hH
  obtain ⟨g, h, -, -, -, hgc, -, hgu, hhu, -, -, -⟩ :=
    stuck_flanks_ua hF hv hst h3.le hH Hd le_rfl h2 h3' h4 hc2 hcN hcS
  refine ⟨g, hgu, ?_⟩
  have hgv : g ∈ F.coloursAt v := mem_closure_of_mem_coneAt hgu.mem_coneAt
  have hNv : dist N v = 1 := by rw [hNdef, dist_eq_norm, add_sub_cancel_left, norm_e]
  have hNg : κ₂ = 1 → N ∉ closure (F.region g) := by
    intro hκ hNcl
    have hcont : F.IsContact v g N := ⟨hgv, hNv, hNcl⟩
    rcases (contact_inType_or_outType hF hv hcont).1 with hin | hout
    · exact hno g hgu ⟨hcont, hin⟩
    · subst hκ; exact not_outType_N_of_flankAbove_one hF hv hgu hNcl hout
  obtain ⟨shH, -⟩ := shadow_of_not_shave hst.2.2.1 hH hgu hhu
  have L1 := fun δ (hδ : 0 < δ) => witness_near_S_upper hF hv h2 hgu hNg hδ
  have hgS : F.IsContact v g S ∧ F.OutType v g S := by
    rcases srcG_of_shadow hF hv le_rfl hH.1 h2 hgu shH with hin | hout
    · exact absurd hin (hno g hgu)
    · exact hout
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
  have W1 := exists_witness_dir (v := v) (α := α) (Or.inl rfl) (H := fun ρ => hornSet v α (-1) κ₂ ρ)
    (W := F.region g) (fun ρ z hz => ⟨hz.1, by rw [one_mul]; exact hz.2.1, abs_frameY_le_of_mem_hornSet le_rfl h2 hz,
      (tanAbove_neg_one_iff v α z).mp hz.2.2.1⟩)
    (fun ρ ρ' h => hornSet_mono_radius h) shH L1 hfar'
  intro ε hε
  obtain ⟨y, hy, -, -, -, hyS, hyε, -, hdir⟩ := W1 ε hε 1 one_pos
  refine ⟨y, hy, hyS, hyε, ?_⟩
  simpa using hdir

/-- **E5 § 3.4 at any bounds, over the flanks** (`flank_two_sectors_at_S_gen` with its three-colour hypothesis replaced by what it is used for:
the upper flank `g` of the `+a` horn is the lower flank of the `−a` horn, and each horn has a flank on the other side, of any colours): at a
stuck vertex whose two-sector colour `c` has horns along `±e α` with bounds in `[−1, 1]`, a flank `g ≠ c` on the `+n` side of both horns with no
in-type contact at `N` has at least two sectors at `S′ = v − n` for every small radius. FS131-I5p, for YB3 § 3.1 Step 4 at a vertex with five
colours. A step inside a refutation-shaped row: no model expected. -/
theorem flank_two_sectors_at_S_of_flanks (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {α κ₁ κ₂ κ₃ κ₄ : ℝ} {c g h₁ h₂ : Fin k}
    (hst : F.IsStuck v) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α κ₁ κ₂ c)
    (Hd : F.IsHorn v (α + π) κ₃ κ₄ c) (h1 : -1 ≤ κ₁) (h2 : κ₂ ≤ 1) (h3' : -1 ≤ κ₃) (h4 : κ₄ ≤ 1)
    (hgu : F.IsFlankAbove v α κ₂ g) (hgd : F.IsFlankBelow v (α + π) κ₃ g) (hhu : F.IsFlankBelow v α κ₁ h₁)
    (hhd : F.IsFlankAbove v (α + π) κ₄ h₂) (hgc : g ≠ c)
    (hno : ¬ (F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)))) :
    ∀ᶠ r in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf (v - e (α + π / 2)) r g).encard := by
  have hπ := Real.pi_pos
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  have hv := hvC v
  set S := v - e (α + π / 2) with hSdef
  set N := v + e (α + π / 2) with hNdef
  obtain ⟨hcN, hcS⟩ := horn_poles_contact hF hv hst.1 le_rfl hc2 hH
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

/-- **E5 § 3.4 at any bounds** (E5 § 3.5's "by § 3.4's argument with `cv_class`'s bounds"): at a stuck vertex with three colours whose
two-sector colour `c` has horns along `±e α` with bounds in `[−1, 1]`, an upper flank `g` with no in-type contact at `N` has at least two
sectors at `S′ = v − n` for every small radius. `flank_two_sectors_at_S`'s argument (E5's F1–F6), with both ends of the half-disc closed:
a `c`-horn along `−a` at `S′` by SEP with the `−a` horn (`κ₄ < 1`) or U1 (`κ₄ = 1`), one along `+a` by SEP with the `+a` horn (`κ₁ > −1`,
`sep_S`) or U1 (`κ₁ = −1`). A step inside a refutation-shaped row: no model expected. -/
theorem flank_two_sectors_at_S_gen (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {α κ₁ κ₂ κ₃ κ₄ : ℝ} {c g : Fin k}
    (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α κ₁ κ₂ c)
    (Hd : F.IsHorn v (α + π) κ₃ κ₄ c) (h1 : -1 ≤ κ₁) (h2 : κ₂ ≤ 1) (h3' : -1 ≤ κ₃) (h4 : κ₄ ≤ 1)
    (hgu : F.IsFlankAbove v α κ₂ g)
    (hno : ¬ (F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)))) :
    ∀ᶠ r in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf (v - e (α + π / 2)) r g).encard := by
  -- `flank_two_sectors_at_S_of_flanks`, its flanks read from the three colours at `v` (`stuck_flanks_ua`)
  have hv : F.Covers v 1 := fun z _ => by rw [hP]; exact mem_univ z
  obtain ⟨hcN, hcS⟩ := horn_poles_contact hF hv hst.1 le_rfl hc2 hH
  obtain ⟨g₀, h, -, -, -, hgc₀, -, hg₀u, hhu, hhd, hgd₀, -⟩ :=
    stuck_flanks_ua hF hv hst h3.le hH Hd h1 h2 h3' h4 hc2 hcN hcS
  have hgg₀ : g₀ = g := hg₀u.unique hgu
  subst hgg₀
  exact flank_two_sectors_at_S_of_flanks hF hP hst hc2 hH Hd h1 h2 h3' h4 hgu hgd₀ hhu hhd hgc₀ hno

/-- **NB3-END items 3–4** (`plans/FS112-NB3-verification.md` l. 238–241; NB3's, one mind, not re-derived by E5): in `n3_end_of_not_inType`'s
setting `S′ = v − n` carries at least four colours. Proved by a shorter route than NB3's items 3–4 (FS131-I5k): `S′` has a repeated colour
(`flank_two_sectors_at_S`) and the map is terminal, so `S′` is stuck (`isStuck_of_hasRepeatedColour`); with at most three colours it would be
a chain vertex, where every colour, `c` among them, approaches along both directions of one axis (`chainVertex_antipodal`), while U1 keeps
`c`'s cone at `S′` free of antipodal pairs (`not_antipodal_coneAt_S_of_horn`). NB3's colours `y ≠ z` beside `g`'s `+a` horn and its SHAVE
step are not needed. A step inside a refutation-shaped row: no model expected. -/
theorem n3_end_four_colours (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {v : ℂ} {α κ₂ : ℝ} {c : Fin k}
    (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) κ₂ c)
    (hno : ∀ g, F.IsFlankAbove v α κ₂ g → ¬ (F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)))) :
    4 ≤ (F.coloursAt (v - e (α + π / 2))).ncard := by
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  obtain ⟨-, h2⟩ := horn_bounds_of_noMerge hF (hvC v) hst.1 le_rfl hc2 hH
  obtain ⟨-, hcS⟩ := horn_poles_contact hF (hvC v) hst.1 le_rfl hc2 hH
  obtain ⟨g, -, hg2⟩ := flank_two_sectors_at_S hF hP hst h3 hc2 hH hno
  have hSt : F.IsStuck (v - e (α + π / 2)) := isStuck_of_hasRepeatedColour hT (by rw [hP]; exact mem_univ _) ⟨g, hg2⟩
  by_contra h4
  push Not at h4
  obtain ⟨β, hβ⟩ := chainVertex_antipodal hF (hvC _) hSt (by omega)
  obtain ⟨hb1, hb2⟩ := hβ c hcS.1.2.2
  exact not_antipodal_coneAt_S_of_horn hF hH h2 hb1 hb2

/-- **NB3-END item 5** (`plans/FS112-NB3-verification.md` l. 242–243; NB3's, one mind): in `n3_end_of_not_inType`'s setting `v − 2n` centres
a both-kind unit arc — the `y`-shadow on `g`'s `+a` horn at `S′` comes from an in-type `y`-tile at `v − 2n` Siamese to the lower flank, along
an arc of `ω(v − 2n)` with `s_in = y`, `s_out = g`, both carried at `v − 2n`. Route (FS131-I5k): `S′` is stuck; `g`'s class approaches `S′`
along `α` (`flank_coneAt_S`), so `g` has a horn along `α` at `S′` with an out-type contact at `v − 2n` (`exists_horn_of_mem_coneAt_of_stuck`);
no SHAVE makes its lower flank `y` shadow it (`shadow_of_not_shave`), from an in-type contact at `v − 2n` or an out-type one at `v`
(`srcH_of_shadow`). The second puts `y` in `P_cl(v) = {c, g, h}`: `c` is excluded by U1 (`α` is not in `c`'s cone at `S′`), `g` by validity
(its own shadow on its own horn), `h` because its flank below `c`'s horn lies in `B(S′, 1)` near `v` (`not_outType_v_of_flankBelow_neg_one`).
The first keeps `y`'s class near `S′` in `B̄(v − 2n, 1)`, so the horn's lower bound is `−1` and its lower arc is an arc of `Γ` on `ω(v − 2n)`
with inner colour `y` and outer `g` (`IsHorn.isRingArc_lower_ua`), both carried at `v − 2n`. NB3's `z ≠ y` is not needed. A step inside a
refutation-shaped row: no model expected. -/
theorem n3_end_bothKind (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {v : ℂ} {α κ₂ : ℝ} {c : Fin k}
    (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) κ₂ c)
    (hno : ∀ g, F.IsFlankAbove v α κ₂ g → ¬ (F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)))) :
    ∃ θ₁ θ₂, F.BothKind (v - 2 * e (α + π / 2)) θ₁ θ₂ := by
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  have hdom : ∀ x, x ∈ F.dom := fun x => by rw [hP]; exact mem_univ x
  set n := e (α + π / 2) with hn
  set w := v - n with hw
  have hwn : w - n = v - 2 * n := by rw [hw]; ring
  have hwv : w + n = v := by rw [hw]; ring
  -- the structure at `v`
  obtain ⟨κ₃, κ₄, Hd, h3', h4⟩ := exists_horn_add_pi_of_stuck hF (hvC v) hst hc2 hH
  obtain ⟨-, h2⟩ := horn_bounds_of_noMerge hF (hvC v) hst.1 le_rfl hc2 hH
  obtain ⟨hcN, hcS⟩ := horn_poles_contact hF (hvC v) hst.1 le_rfl hc2 hH
  obtain ⟨g₀, h, -, hcol, -, -, -, hg₀u, hhu, -, -, -⟩ :=
    stuck_flanks_ua hF (hvC v) hst h3.le hH Hd le_rfl h2 h3' h4 hc2 hcN hcS
  -- the upper flank at `S′`: two sectors, the direction `α`
  obtain ⟨g, hgu, hg2⟩ := flank_two_sectors_at_S hF hP hst h3 hc2 hH hno
  obtain ⟨g', hg'u, hαg'⟩ := flank_coneAt_S hF hP hst h3 hc2 hH hno
  obtain rfl : g' = g := hg'u.unique hgu
  have hwst : F.IsStuck w := isStuck_of_hasRepeatedColour hT (hdom w) ⟨g', hg2⟩
  obtain ⟨m, hm⟩ := exists_hasSectors (hdom w) g'
  have hm2 : 2 ≤ m := by
    obtain ⟨r, hr1, hr2⟩ := (hm.and hg2).exists
    have : (2 : ℕ∞) ≤ m := hr1 ▸ hr2
    exact_mod_cast this
  have hwI : w ∉ F.interiorPts := by
    intro hI
    have h1 := coloursAt_eq_of_mem_interiorPts hI
    have hcw : c ∈ F.coloursAt w := hcS.1.2.2
    have hgw : g' ∈ F.coloursAt w := mem_closure_of_mem_coneAt hαg'
    rw [h1] at hcw hgw
    have hgc : g' ≠ c := by
      intro hgc
      obtain ⟨φ, hφ, -, hU1⟩ := coneAt_S_subset_of_horn hF hH h2
      exact not_mem_angleIcc_S_self hφ (hU1 (hgc ▸ hαg'))
    exact hgc (hgw.trans hcw.symm)
  -- `g`'s horn along `α` at `S′`, with its out-type contact at `v − 2n`
  obtain ⟨κ₁', κ₂', h1', h2', Hg, hgP⟩ := exists_horn_of_mem_coneAt_of_stuck hF (hvC w) hwst hwI hm2 hm hαg'
  -- its flanks, and the lower flank's shadow
  obtain ⟨y, hy⟩ := Hg.exists_flankBelow (hdom w)
  obtain ⟨z, hz⟩ := Hg.exists_flankAbove (hdom w)
  obtain ⟨-, shy⟩ := shadow_of_not_shave hwst.2.2.1 Hg hz hy
  rcases srcH_of_shadow hF (hvC w) h1' Hg.1 h2' hy shy with ⟨hyc, hyin⟩ | ⟨hyc, hyout⟩
  · -- in-type at `v − 2n`: the horn's lower arc is on `ω(v − 2n)`
    have hκ : κ₁' = -1 := by
      by_contra hne
      have hlt : -1 < κ₁' := lt_of_le_of_ne h1' (Ne.symm hne)
      obtain ⟨ε, hε, hnear⟩ := region_near_of_inType hF (hvC w) hyc hyin
      obtain ⟨κ'', hκ'', hyev⟩ := hy
      obtain ⟨r, hr, hr0⟩ := (hyev.and (Ioo_mem_nhdsGT hε)).exists
      obtain ⟨z₀, hz₀, hzA, -⟩ := exists_mem_hornSet_aboveBelow w α (κ₁ := κ'') (κ₂ := κ₁')
        (s := (max κ'' (-1) + κ₁') / 2) (m := -1) hr0.1
        (by have := le_max_left κ'' (-1); linarith [max_lt hκ'' hlt]) (by linarith [max_lt hκ'' hlt])
        (by intro h'; linarith [le_max_right κ'' (-1), max_lt hκ'' hlt])
      have hzA' := hzA (by linarith [le_max_right κ'' (-1), max_lt hκ'' hlt])
      have h1 := hnear z₀ (hr hz₀) (lt_trans hz₀.1 hr0.2)
      have h2 := (tanAbove_neg_one_iff w α z₀).mp hzA'
      linarith
    subst hκ
    obtain ⟨θ₁, -, hR⟩ := Hg.isRingArc_lower_ua (hvC w) hy
    refine ⟨θ₁, α + π / 2, y, g', ?_, ?_, ?_⟩
    · rw [← hwn]; exact hR
    · rw [← hwn]; exact hyc.2.2
    · rw [← hwn]; exact hgP.1.2.2
  · -- out-type at `v`: `y` is carried at `v`, and none of `c, g, h` can be
    exfalso
    rw [hwv] at hyc hyout
    have hyv : y ∈ F.coloursAt v := hyc.2.2
    rw [hcol] at hyv
    simp only [mem_insert_iff, mem_singleton_iff] at hyv
    rcases hyv with hyc' | hyc' | hyc'
    · -- `y = c`: U1 keeps `α` out of `c`'s cone at `S′`
      obtain ⟨φ, hφ, -, hU1⟩ := coneAt_S_subset_of_horn hF hH h2
      exact not_mem_angleIcc_S_self hφ (hU1 (hyc' ▸ hy.mem_coneAt))
    · -- `y = g₀`, the upper flank at `v`, which is `g`: its own shadow on its horn
      have hgg : y = g' := hyc'.trans (hg₀u.unique hg'u)
      rw [hgg] at shy
      obtain ⟨r, hrg, hr0⟩ := (Hg.eventually_subset_region.and self_mem_nhdsWithin).exists
      obtain ⟨z₁, hz₁, y₁, hy₁, hzy⟩ := shy r hr0
      exact hF z₁ (hrg hz₁).1 y₁ hy₁.1 hzy ((hrg hz₁).2.trans hy₁.2.symm)
    · -- `y = h`: the lower flank at `v` lies inside `B(S′, 1)` near `v`
      exact not_outType_v_of_flankBelow_neg_one hhu (hyc' ▸ hyout)


/-- **FS112-N3-END, its first case** (a child of `n3_end`, FS131-I5d): with no in-type upper-flank tile at `N`, the first disjunct — four colours and
a repeated colour at `S′ = v − n`, a both-kind unit arc centred at `v − 2n`. NB3-END items 2–5 (`plans/FS112-NB3-verification.md` l. 232–243) with
item 2's premise read as "no in-type `g`-tile at `N`" (FS131-I4m's reading, inventory items 288–289: NB3 leaves the case `κ₂ = 1`, `g ∉ P_cl(N)` to its
item 1, whose conclusion is not this statement): the `g`-shadow on both horns then comes from out-type `g`-tiles at `S′` tangent to `±a` (`srcG_of_shadow`
gives "in-type at `N` or out-type at `S′`"), two sectors of `g` at `S′`; `S′` terminal makes them horns; the colours `y ≠ z` beside the `+a` horn
(SHAVE otherwise); an in-type `y`-tile at `v − 2n` Siamese to the lower flank. The open part of `n3_end`. A step inside a refutation-shaped row: no
model expected. -/
theorem n3_end_of_not_inType (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {v : ℂ} {α κ₂ : ℝ} {c : Fin k}
    (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) κ₂ c)
    (hno : ∀ g, F.IsFlankAbove v α κ₂ g → ¬ (F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)))) :
    4 ≤ (F.coloursAt (v - e (α + π / 2))).ncard ∧ F.HasRepeatedColour (v - e (α + π / 2)) ∧
      ∃ θ₁ θ₂, F.BothKind (v - 2 * e (α + π / 2)) θ₁ θ₂ := by
  obtain ⟨g, -, hg2⟩ := flank_two_sectors_at_S hF hP hst h3 hc2 hH hno
  exact ⟨n3_end_four_colours hF hP hT hst h3 hc2 hH hno, ⟨g, hg2⟩, n3_end_bothKind hF hP hT hst h3 hc2 hH hno⟩

/-- **FS112-N3-END** (NB3's corrected form): in a terminal valid map of the plane, let `v` be stuck with exactly three colours, its
two-sector colour `c` having a horn along `e α` whose lower arc has curvature `−1` (an arc of `ω(v − n)`). Then either `v − n` carries
at least four colours and a repeated colour and `v − 2n` is the centre of a both-kind unit arc, or the upper flank colour `g` is
in-type at `v + n` and both horns' upper arcs lie on `ω(v + n)` (`κ₂ = 1`; for the horn along `−a` its lower arc in its own frame).
The row's "and the chain is the single vertex" needs wave 5's stuck-chain vocabulary and is not stated here (§ 8 of the plan). -/
theorem n3_end (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {v : ℂ} {α κ₂ : ℝ} {c : Fin k} (hst : F.IsStuck v)
    (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) κ₂ c) :
    (4 ≤ (F.coloursAt (v - e (α + π / 2))).ncard ∧ F.HasRepeatedColour (v - e (α + π / 2)) ∧
        ∃ θ₁ θ₂, F.BothKind (v - 2 * e (α + π / 2)) θ₁ θ₂) ∨
      ∃ g, F.IsFlankAbove v α κ₂ g ∧ F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)) ∧ κ₂ = 1 ∧
        ∀ κ₃ κ₄, F.IsHorn v (α + π) κ₃ κ₄ c → κ₃ = -1 := by
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  by_cases hin : ∃ g, F.IsFlankAbove v α κ₂ g ∧ F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2))
  · -- an in-type upper flank at `N`: the flank lies in `B(N, 1)`, so `κ₂ = 1`, and the `−e α` horn's `+n` flank (the same colour) too
    right
    obtain ⟨g, hg, hgc, hgi⟩ := hin
    obtain ⟨-, hκ2⟩ := horn_bounds_of_noMerge hF (hvC v) hst.1 le_rfl hc2 hH
    have hk2 : κ₂ = 1 := by
      by_contra hne
      exact (contact_inType_or_outType hF (hvC v) hgc).2
        ⟨hgi, outType_N_of_flankAbove hF (hvC v) (lt_of_le_of_ne hκ2 hne) hg hgc.2.2⟩
    refine ⟨g, hg, hgc, hgi, hk2, fun κ₃ κ₄ Hd => ?_⟩
    obtain ⟨hκ3, hκ4⟩ := horn_bounds_of_noMerge hF (hvC v) hst.1 le_rfl hc2 Hd
    obtain ⟨hN, hS⟩ := horn_poles_contact hF (hvC v) hst.1 le_rfl hc2 hH
    obtain ⟨g₁, -, -, -, -, -, -, hg₁, -, -, hg₁d, -⟩ :=
      stuck_flanks_ua hF (hvC v) hst h3.le hH Hd le_rfl hκ2 hκ3 hκ4 hc2 hN hS
    have hg₁g : g₁ = g := hg₁.unique hg
    subst hg₁g
    by_contra hne
    have hout := outType_S_of_flankBelow hF (hvC v) (lt_of_le_of_ne hκ3 (Ne.symm hne)) hg₁d
      (by rw [sub_e_add_pi_add]; exact hgc.2.2)
    rw [sub_e_add_pi_add] at hout
    exact (contact_inType_or_outType hF (hvC v) hgc).2 ⟨hgi, hout⟩
  · left
    exact n3_end_of_not_inType hF hP hT hst h3 hc2 hH fun g hg hgi => hin ⟨g, hg, hgi⟩

/-- **FS112-N3-END's chain clause** ("and the chain is the single vertex", inventory item 74; wave 4's `n3_end` states the rest): in
n3_end's setting (a terminal valid plane map, `v` stuck with three colours, `c`'s horn along `e α` with lower bound `−1`), in its second
disjunct — the upper flank `g` in-type at `N` and `κ₂ = 1` — the stuck run through `v` is `{0}`: neither neighbour is a chain vertex.
Model of the local hypotheses: `bowtie` at `0` (`bowtie_isStuck`: `E` stuck, `±i` not). -/
theorem n3_end_chain (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {v : ℂ} {α : ℝ} {c g : Fin k}
    (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) 1 c)
    (hg : F.IsFlankAbove v α 1 g) (hgN : F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2))) :
    F.stuckRun v α = {0} := by
  -- the run's chain clause reads only the two unit bounds of `c`'s horn (not `hT`, the flank, nor the in-type contact)
  have _ := hT
  have _ := hg
  have _ := hgN
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  obtain ⟨⟨hcN, -⟩, ⟨hcS, -⟩⟩ := horn_poles_contact hF (hvC v) hst.1 le_rfl hc2 hH
  have hNo : ¬ F.IsChainVertex (v + e (α + π / 2)) := fun ⟨hstN, h3N⟩ => by
    obtain ⟨β, hβ⟩ := chainVertex_antipodal hF (hvC _) hstN h3N
    obtain ⟨h1, h2⟩ := hβ c hcN.2.2
    exact not_antipodal_coneAt_N_of_horn hF hH le_rfl h1 h2
  have hSo : ¬ F.IsChainVertex (v - e (α + π / 2)) := fun ⟨hstS, h3S⟩ => by
    obtain ⟨β, hβ⟩ := chainVertex_antipodal hF (hvC _) hstS h3S
    obtain ⟨h1, h2⟩ := hβ c hcS.2.2
    exact not_antipodal_coneAt_S_of_horn hF hH le_rfl h1 h2
  ext j
  simp only [stuckRun, mem_setOf_eq, mem_singleton_iff]
  constructor
  · intro hj
    by_contra hj0
    rcases lt_or_gt_of_ne hj0 with hlt | hgt
    · have := hj (-1) (by omega) (by omega)
      rw [show v + ((-1 : ℤ) : ℂ) * e (α + π / 2) = v - e (α + π / 2) by push_cast; ring] at this
      exact hSo this
    · have := hj 1 (by omega) (by omega)
      rw [show v + ((1 : ℤ) : ℂ) * e (α + π / 2) = v + e (α + π / 2) by push_cast; ring] at this
      exact hNo this
  · rintro rfl i hi1 hi2
    have hi : i = 0 := by omega
    subst hi
    rw [show v + ((0 : ℤ) : ℂ) * e (α + π / 2) = v by push_cast; ring]
    exact ⟨hst, h3.le⟩

/-! ## FS114-CV-HD's main clause and equivalences, FS112-Y3-END-NEEDS, FS112-C-DOUBLE (placed after NB3-END's lemmas, which their open
leaves read) -/

/-- **CV-HD's Siamese arrow `G_N ⇒ υ± = 1`** (`plans/FS114-CVB-verification.md` § 1.6, "the two easy arrows"): at a stuck vertex `E` with at
most three colours, an in-type upper-flank contact at `N` forces both horns' `N`-side arcs onto `ω(N)` — `κ₂ = 1` (else the flank's contact
at `N` is out-type, `outType_N_of_flankAbove`) and `κ₃ = −1` (the same for the `−e α` horn, whose `N`-side flank is `g` again,
`stuck_flanks_ua`). The argument of `n3_end`'s second branch, at any lower bounds. Inhabitant of the hypotheses: `bowtie` at `0`. -/
theorem upper_bounds_of_inType_N (hF : F.Valid) (hP : F.IsPlaneMap) {E : ℂ} (hst : F.IsStuck E)
    (h3 : (F.coloursAt E).ncard ≤ 3) {c : Fin k} (hc2 : F.HasSectors E c 2) {α κ₁ κ₂ κ₃ κ₄ : ℝ}
    (hH : F.IsHorn E α κ₁ κ₂ c) (hH' : F.IsHorn E (α + π) κ₃ κ₄ c) {g : Fin k} (hg : F.IsFlankAbove E α κ₂ g)
    (hGN : F.IsContact E g (E + e (α + π / 2)) ∧ F.InType E g (E + e (α + π / 2))) : κ₂ = 1 ∧ κ₃ = -1 := by
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  obtain ⟨h1, h2⟩ := horn_bounds_of_noMerge hF (hvC E) hst.1 le_rfl hc2 hH
  obtain ⟨h3', h4⟩ := horn_bounds_of_noMerge hF (hvC E) hst.1 le_rfl hc2 hH'
  obtain ⟨hgc, hgi⟩ := hGN
  have hk2 : κ₂ = 1 := by
    by_contra hne
    exact (contact_inType_or_outType hF (hvC E) hgc).2
      ⟨hgi, outType_N_of_flankAbove hF (hvC E) (lt_of_le_of_ne h2 hne) hg hgc.2.2⟩
  refine ⟨hk2, ?_⟩
  obtain ⟨hN, hS⟩ := horn_poles_contact hF (hvC E) hst.1 le_rfl hc2 hH
  obtain ⟨g₁, -, -, -, -, -, -, hg₁, -, -, hg₁d, -⟩ :=
    stuck_flanks_ua hF (hvC E) hst h3 hH hH' h1 h2 h3' h4 hc2 hN hS
  have hg₁g : g₁ = g := hg₁.unique hg
  subst hg₁g
  by_contra hne
  have hout := outType_S_of_flankBelow hF (hvC E) (lt_of_le_of_ne h3' (Ne.symm hne)) hg₁d
    (by rw [sub_e_add_pi_add]; exact hgc.2.2)
  rw [sub_e_add_pi_add] at hout
  exact (contact_inType_or_outType hF (hvC E) hgc).2 ⟨hgi, hout⟩

/-- **A stuck vertex in the frame turned by `π`**: at a stuck vertex `E` with at most three colours (horns of `c` along `±e α`, upper flank
`g`, lower flank `h`), the configuration read along `e (α + π)` is the same with `g ↔ h` — the horn along `α + π + π` is the horn along `α`,
`h` is the turned horn's upper flank and `g` its lower one, and the turned frame's poles are `S` and `N` (`stuck_flanks_ua`,
`IsFlankAbove.unique`, `IsFlankBelow.unique`). Inhabitant of the hypotheses: `bowtie` at `0`. -/
theorem stuck_turned_frame (hF : F.Valid) (hP : F.IsPlaneMap) {E : ℂ} (hst : F.IsStuck E)
    (h3 : (F.coloursAt E).ncard ≤ 3) {c : Fin k} (hc2 : F.HasSectors E c 2) {α κ₁ κ₂ κ₃ κ₄ : ℝ}
    (hH : F.IsHorn E α κ₁ κ₂ c) (hH' : F.IsHorn E (α + π) κ₃ κ₄ c) {g h : Fin k} (hg : F.IsFlankAbove E α κ₂ g)
    (hh : F.IsFlankBelow E α κ₁ h) :
    F.IsHorn E (α + π + π) κ₁ κ₂ c ∧ F.IsFlankAbove E (α + π) κ₄ h ∧ F.IsFlankBelow E (α + π) κ₃ g ∧
      E + e (α + π + π / 2) = E - e (α + π / 2) ∧ E - e (α + π + π / 2) = E + e (α + π / 2) := by
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  obtain ⟨h1, h2⟩ := horn_bounds_of_noMerge hF (hvC E) hst.1 le_rfl hc2 hH
  obtain ⟨h3', h4⟩ := horn_bounds_of_noMerge hF (hvC E) hst.1 le_rfl hc2 hH'
  obtain ⟨hN, hS⟩ := horn_poles_contact hF (hvC E) hst.1 le_rfl hc2 hH
  obtain ⟨g₁, h₁, -, -, -, -, -, hg₁, hh₁, hh₁d, hg₁d, -⟩ :=
    stuck_flanks_ua hF (hvC E) hst h3 hH hH' h1 h2 h3' h4 hc2 hN hS
  have hgg : g₁ = g := hg₁.unique hg
  have hhh : h₁ = h := IsFlankBelow.unique hh₁ hh
  subst hgg hhh
  exact ⟨hH.congr (by rw [show α + π + π = α + 2 * π * ((1 : ℤ) : ℝ) by push_cast; ring, e_add_int_mul]),
    hh₁d, hg₁d, add_e_add_pi_add E α, sub_e_add_pi_add E α⟩

/-- **A contact on `ω(w)` is perpendicular to an antipodal pair of the colour's cone at `w`**: if `j` approaches `w` along `±e β` and `v ∈ ω(w)`
is in `j`'s closure, then `e β ⊥ v − w` (the contact is of one type, and its half-plane holds both `e β` and `−e β`, `coneAt_subset_allowedCone`).
The engine of `stuckAlong_of_run`, stated alone for CV-HD's and Y3-END-NEEDS's levels (FS131-I5l). -/
theorem dot_eq_zero_of_antipodal_contact (hF : F.Valid) {w v : ℂ} (hv : F.Covers w 1) {j : Fin k}
    (hjv : v ∈ closure (F.region j)) (hvw : dist v w = 1) {β : ℝ} (h1 : β ∈ coneAt (F.region j) w)
    (h2 : β + π ∈ coneAt (F.region j) w) : dot (e β) (v - w) = 0 := by
  have hcont : F.IsContact w j v := ⟨mem_closure_of_mem_coneAt h1, hvw, hjv⟩
  have hA1 := coneAt_subset_allowedCone hF hv h1 v hcont
  have hA2 := coneAt_subset_allowedCone hF hv h2 v hcont
  rw [e_add_pi', dot_neg_left] at hA2
  rcases (contact_inType_or_outType hF hv hcont).1 with hi | ho
  · have := hA1.1 hi; have := hA2.1 hi; linarith
  · have := hA1.2 ho; have := hA2.2 ho; linarith

/-- **W-MERGE at `w` unless both poles carry the colour** (FS114-CVB § 1.6's repeated step: "`D_r(N)` has interior unless it is the line `±a`,
which needs a contact at `E`"): a colour with two or more sectors at `w`, approaching `w` along `e β`, and absent at one of `w ± e (β + π/2)`,
makes MERGE available at `w` — an empty `int D_j(w)` would give out-type contacts at both poles of an axis (`woodallCone`), and `e β ∈ D_j(w)`
puts that axis along `±e β`. The distinctness engine of CVB's branch `G_N` (`r₊ ≠ r₋`, `x₁ ∉ {r₊, r₋}`, `x₁ ≠ x₂`) and of YB3 § 3.1's Steps 3–4
(FS131-I5l). -/
theorem mergeAvailable_of_not_mem_pole (hF : F.Valid) {w : ℂ} (hv : F.Covers w 1) {j : Fin k} {m : ℕ} (hm : 2 ≤ m)
    (hj : F.HasSectors w j m) {β : ℝ} (hβ : β ∈ coneAt (F.region j) w)
    (hpole : w + e (β + π / 2) ∉ closure (F.region j) ∨ w - e (β + π / 2) ∉ closure (F.region j)) :
    F.MergeAvailable w := by
  by_contra hno
  have hjw : j ∈ F.coloursAt w := mem_closure_of_mem_coneAt hβ
  have hD : interior (F.allowedCone w j) = ∅ := by
    by_contra hne
    exact hno ⟨j, m, hm, hj, nonempty_iff_ne_empty.mpr hne⟩
  obtain ⟨α', ⟨hNc, hNo⟩, ⟨hSc, hSo⟩, -⟩ := woodallCone hF hv hjw hD
  have hA := coneAt_subset_allowedCone hF hv hβ
  have h1 := (hA _ hNc).2 hNo
  have h2 := (hA _ hSc).2 hSo
  rw [add_sub_cancel_left] at h1
  rw [show w - e (α' + π / 2) - w = -e (α' + π / 2) by ring, dot_neg_right] at h2
  have h0 : dot (e β) (e (α' + π / 2)) = 0 := by linarith
  rw [dot_e_e, show β - (α' + π / 2) = (β - α') - π / 2 by ring, Real.cos_sub_pi_div_two] at h0
  rcases e_eq_or_of_sin_sub_eq_zero h0 with he | he
  · have he' : e (β + π / 2) = e (α' + π / 2) := by rw [e_add_pi_div_two, e_add_pi_div_two, he]
    rw [he'] at hpole
    rcases hpole with hp | hp
    · exact hp hNc.2.2
    · exact hp hSc.2.2
  · have he' : e (β + π / 2) = -e (α' + π / 2) := by
      rw [e_add_pi_div_two, e_add_pi_div_two, he, e_add_pi']; ring
    rw [he', ← sub_eq_add_neg, sub_neg_eq_add] at hpole
    rcases hpole with hp | hp
    · exact hp hSc.2.2
    · exact hp hNc.2.2

/-- **Distinct chart sectors of one colour are distinct sectors of that colour**: at a radius up to the chart's, a colour has at least as many
sectors as there are chart indices whose sectors lie in its class. -/
theorem IsSectorChart.card_le_encard_sectorsOf {n : ℕ} {G : BranchGerms n} {w : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G w r₀)
    {r : ℝ} (hr : r ∈ Ioc 0 r₀) {j : Fin k} (s : Finset (Fin n)) (hs : ∀ i ∈ s, G.sector w r i ⊆ F.region j) :
    (s.card : ℕ∞) ≤ (F.sectorsOf w r j).encard := by
  rcases s.eq_empty_or_nonempty with rfl | ⟨i₀, hi₀⟩
  · simp
  have hn : 0 < n := i₀.pos
  have hinj : InjOn (fun i => G.sector w r i) (s : Set (Fin n)) := by
    intro i _ i' _ heq
    by_contra hne
    obtain ⟨z, hz⟩ := hC.sector_nonempty hr i
    exact Set.disjoint_left.mp (hC.disjoint r hr i i' hne) hz (by rw [← show G.sector w r i = G.sector w r i' from heq]; exact hz)
  have himg : (fun i => G.sector w r i) '' (s : Set (Fin n)) ⊆ F.sectorsOf w r j := by
    rintro T ⟨i, hi, rfl⟩
    exact ⟨(hC.isSector_iff hn hr).mpr ⟨i, rfl⟩, fun z hz => (hs i hi hz).2⟩
  calc (s.card : ℕ∞) = ((fun i => G.sector w r i) '' (s : Set (Fin n))).encard := by
        rw [hinj.encard_image, encard_coe_eq_coe_finsetCard]
    _ ≤ _ := encard_le_encard himg

/-- **Two chart sectors of one colour, absent at a pole of a cone direction, make MERGE available** (`mergeAvailable_of_not_mem_pole` with
its sector count read from the chart). -/
theorem mergeAvailable_of_two_sectors (hF : F.Valid) {w : ℂ} (hv : F.Covers w 1) {n : ℕ} {G : BranchGerms n} {r₀ : ℝ}
    (hC : F.IsSectorChart G w r₀) {i i' : Fin n} (hii : i ≠ i') {j : Fin k}
    (hi : ∀ r ∈ Ioc 0 r₀, G.sector w r i ⊆ F.region j) (hi' : ∀ r ∈ Ioc 0 r₀, G.sector w r i' ⊆ F.region j)
    {β : ℝ} (hβ : β ∈ coneAt (F.region j) w)
    (hpole : w + e (β + π / 2) ∉ closure (F.region j) ∨ w - e (β + π / 2) ∉ closure (F.region j)) :
    F.MergeAvailable w := by
  obtain ⟨m, hm⟩ := exists_hasSectors (hv (mem_closedBall_self zero_le_one)) j
  have hm2 : 2 ≤ m := by
    obtain ⟨r, hrm, hr⟩ := (hm.and (Ioc_mem_nhdsGT hC.pos)).exists
    have h2 := hC.card_le_encard_sectorsOf hr {i, i'} (by
      intro l hl
      rcases Finset.mem_insert.mp hl with rfl | hl
      · exact hi r hr
      · rw [Finset.mem_singleton.mp hl]; exact hi' r hr)
    rw [Finset.card_pair hii, hrm] at h2
    exact_mod_cast h2
  exact mergeAvailable_of_not_mem_pole hF hv hm2 hm hβ hpole

/-- **A colour carried at the chart's centre has a chart sector**, whose first direction is a direction of the colour's class. -/
theorem IsSectorChart.exists_index_of_mem_coloursAt {n : ℕ} {G : BranchGerms n} {w : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G w r₀)
    (hn : 0 < n) {j : Fin k} (hj : j ∈ F.coloursAt w) :
    ∃ i : Fin n, (∀ r ∈ Ioc 0 r₀, G.sector w r i ⊆ F.region j) ∧ G.β i ∈ coneAt (F.region j) w := by
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  obtain ⟨y, hy, hyw⟩ := Metric.mem_closure_iff.mp hj r₀ hC.pos
  obtain ⟨i, hi⟩ : ∃ i, y ∈ G.sector w r₀ i := by
    have hyc : y ∈ ball w r₀ ∩ F.interiorPts := ⟨by rw [mem_ball, dist_comm]; exact hyw, hy.1⟩
    rw [hC.cover r₀ hr₀ hn] at hyc
    exact mem_iUnion.mp hyc
  obtain ⟨j', hj'⟩ := hC.exists_col i
  have hjj : j' = j := ((hj' r₀ hr₀ hi).2).symm.trans hy.2
  subst hjj
  refine ⟨i, hj', ?_⟩
  have : G.β i ∈ coneAt (G.sector w r₀ i) w := by
    rw [hC.cone r₀ hr₀ i]; exact Icc_subset_angleIcc _ _ ⟨le_rfl, hC.sorted.mono i⟩
  exact coneAt_mono (hj' r₀ hr₀) w this

/-- **The flank after a germ, in the sector's colour** (`IsSectorChart.exists_flank_after` with the colour named: the thin horn above the germ lies
in sector `j`, hence in the class of `j`'s colour). Charts exist at every point of the domain (`localSectors`). -/
theorem IsSectorChart.isFlankAbove_of_col {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    {j : Fin n} {α κ : ℝ} (hβ : e (G.β j) = e α) (hκ : G.κ j = κ) {g : Fin k}
    (hg : ∀ r ∈ Ioc 0 r₀, G.sector v r j ⊆ F.region g) : F.IsFlankAbove v α κ g := by
  obtain ⟨m, hm⟩ := e_eq_e_iff.mp hβ
  have hcj : ∀ r ∈ Ioc 0 r₀, |κ| * r ≤ 2 := fun r hr => by
    rw [← hκ]; exact (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv j).le
  rcases hC.sorted.2 j with hlt | ⟨heq, hκ'⟩
  · -- a gap after the germ: a thin horn above it lies in sector `j`
    have hd : 0 < G.nextβ j - G.β j := sub_pos.mpr hlt
    obtain ⟨η, hη, hηa⟩ := exists_abs_arcsin_lt (half_pos hd)
    have hr₁ : 0 < min r₀ (min (1 / (|κ + 1| + 1)) (min (η / (|κ + 1| + 1)) (η / (|G.nextκ j| + 1)))) := by
      have := hC.pos; positivity
    refine ⟨κ + 1, by linarith, ?_⟩
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
    refine ⟨G.nextκ j, hκ ▸ hκ', ?_⟩
    filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
    have h2 : |G.nextκ j| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv_next j).le
    have h1 : |G.κ j| * r ≤ 2 := by rw [hκ]; exact hcj r hr
    have hsec : G.sector v r j = hornSet v α κ (G.nextκ j) r := by
      show sectorBetween v (G.β j) (G.κ j) (G.nextβ j) (G.nextκ j) r = _
      rw [← heq, sectorBetween_eq_hornSet v _ _ _ r h1 h2, hornSet_congr hβ, hκ]
    rw [← hsec]; exact hg r hr

/-- **The flank before a germ, in the sector's colour** (`IsSectorChart.exists_flank_before` with the colour named). Charts exist at every point of the domain (`localSectors`). -/
theorem IsSectorChart.isFlankBelow_of_col {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    {p : Fin n} {α κ : ℝ} (hβ : e (G.nextβ p) = e α) (hκ : G.nextκ p = κ) {h : Fin k}
    (hh : ∀ r ∈ Ioc 0 r₀, G.sector v r p ⊆ F.region h) : F.IsFlankBelow v α κ h := by
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
  · refine ⟨G.κ p, hκ ▸ hκ', ?_⟩
    filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
    have h1 : |G.κ p| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv p).le
    have h2 : |G.nextκ p| * r ≤ 2 := by rw [hκ]; exact hcp r hr
    have hβ' : e (G.β p) = e α := by rw [heq]; exact hβ
    have hsec : G.sector v r p = hornSet v α (G.κ p) κ r := by
      show sectorBetween v (G.β p) (G.κ p) (G.nextβ p) (G.nextκ p) r = _
      rw [← heq, sectorBetween_eq_hornSet v _ _ _ r h1 h2, hornSet_congr hβ', hκ]
    rw [← hsec]; exact hh r hr

/-- **An upper flank above a bound `κ ≥ −1` is never in-type at `v`, seen from `S′`**: its band lies outside `B̄(S′, 1)` and has `v` in its
closure (the mirror of `not_outType_v_of_flankBelow_neg_one`). FS131-I5p, for YB3 § 3.1 Step 4. Model of the hypotheses: `bowtie` at `0`,
`α = 0`, colour `0` (`bowtie_flanks`). -/
theorem not_inType_S_of_flankAbove {v : ℂ} {α κ : ℝ} {g : Fin k} (hg : F.IsFlankAbove v α κ g) (hκ : -1 ≤ κ) :
    ¬ F.InType (v - e (α + π / 2)) g v := by
  intro hin
  obtain ⟨κ', hκ', hev⟩ := hg
  set ρ := min (1 / 2) (1 / (|κ| + |κ'| + 1)) with hρ
  have hρ0 : 0 < ρ := lt_min (by norm_num) (by positivity)
  obtain ⟨r, hr, hr0⟩ := (hev.and (Ioc_mem_nhdsGT hρ0)).exists
  have hb : ∀ x : ℝ, |x| ≤ |κ| + |κ'| → |x| * r ≤ 2 := by
    intro x hx
    have h1 : r ≤ 1 / (|κ| + |κ'| + 1) := hr0.2.trans (min_le_right _ _)
    have h2 : |x| * r ≤ |x| * (1 / (|κ| + |κ'| + 1)) := mul_le_mul_of_nonneg_left h1 (abs_nonneg _)
    have h3 : |x| * (1 / (|κ| + |κ'| + 1)) ≤ 1 := by
      rw [mul_one_div, div_le_one (by positivity)]; linarith
    linarith
  have hpre := isPreconnected_hornSet_of_abs_le (v := v) (α := α) hκ'
    (hb κ (by linarith [abs_nonneg κ'])) (hb κ' (by linarith [abs_nonneg κ]))
  obtain ⟨z₀, hz₀, -, -⟩ := exists_mem_hornSet_aboveBelow v α (κ₁ := κ) (κ₂ := κ') (s := (κ + κ') / 2)
    (m := (κ + κ') / 2 + 1) hr0.1 (by linarith) (by linarith) (by intro h'; linarith)
  have hsubI : hornSet v α κ κ' r ⊆ F.interiorPts := fun z hz => (hr hz).1
  have hT : F.IsTile (connectedComponentIn F.interiorPts z₀) := ⟨z₀, hsubI hz₀, rfl⟩
  have hz₀T : z₀ ∈ connectedComponentIn F.interiorPts z₀ := mem_connectedComponentIn (hsubI hz₀)
  have hTg : F.TileOf g (connectedComponentIn F.interiorPts z₀) := by
    have := hT.tileOf hz₀T
    rwa [show F.col z₀ = g from (hr hz₀).2] at this
  have hsub : hornSet v α κ κ' r ⊆ connectedComponentIn F.interiorPts z₀ :=
    hpre.subset_connectedComponentIn hz₀ hsubI
  have hvcl : v ∈ closure (connectedComponentIn F.interiorPts z₀) :=
    closure_mono hsub (mem_closure_of_mem_coneAt (mem_coneAt_hornSet v α hκ' hr0.1))
  have hball := hin _ hTg hvcl hz₀T
  have hfar : 1 < dist z₀ (v - e (α + π / 2)) := (tanAbove_neg_one_iff v α z₀).mp (hz₀.2.2.1.mono hκ)
  rw [mem_ball] at hball
  linarith

/-- **A lower flank below a bound `κ ≤ 1` is never in-type at `v`, seen from `N`** (the mirror of `not_inType_S_of_flankAbove`). FS131-I5p,
for YB3 § 3.1 Step 4. Model of the hypotheses: `bowtie` at `0`, `α = 0`, colour `2` (`bowtie_flanks`). -/
theorem not_inType_N_of_flankBelow {v : ℂ} {α κ : ℝ} {h : Fin k} (hh : F.IsFlankBelow v α κ h) (hκ : κ ≤ 1) :
    ¬ F.InType (v + e (α + π / 2)) h v := by
  intro hin
  obtain ⟨κ', hκ', hev⟩ := hh
  set ρ := min (1 / 2) (1 / (|κ| + |κ'| + 1)) with hρ
  have hρ0 : 0 < ρ := lt_min (by norm_num) (by positivity)
  obtain ⟨r, hr, hr0⟩ := (hev.and (Ioc_mem_nhdsGT hρ0)).exists
  have hb : ∀ x : ℝ, |x| ≤ |κ| + |κ'| → |x| * r ≤ 2 := by
    intro x hx
    have h1 : r ≤ 1 / (|κ| + |κ'| + 1) := hr0.2.trans (min_le_right _ _)
    have h2 : |x| * r ≤ |x| * (1 / (|κ| + |κ'| + 1)) := mul_le_mul_of_nonneg_left h1 (abs_nonneg _)
    have h3 : |x| * (1 / (|κ| + |κ'| + 1)) ≤ 1 := by
      rw [mul_one_div, div_le_one (by positivity)]; linarith
    linarith
  have hpre := isPreconnected_hornSet_of_abs_le (v := v) (α := α) hκ'
    (hb κ' (by linarith [abs_nonneg κ])) (hb κ (by linarith [abs_nonneg κ']))
  obtain ⟨z₀, hz₀, -, -⟩ := exists_mem_hornSet_aboveBelow v α (κ₁ := κ') (κ₂ := κ) (s := (κ' + κ) / 2)
    (m := (κ' + κ) / 2 + 1) hr0.1 (by linarith) (by linarith) (by intro h'; linarith)
  have hsubI : hornSet v α κ' κ r ⊆ F.interiorPts := fun z hz => (hr hz).1
  have hT : F.IsTile (connectedComponentIn F.interiorPts z₀) := ⟨z₀, hsubI hz₀, rfl⟩
  have hz₀T : z₀ ∈ connectedComponentIn F.interiorPts z₀ := mem_connectedComponentIn (hsubI hz₀)
  have hTh : F.TileOf h (connectedComponentIn F.interiorPts z₀) := by
    have := hT.tileOf hz₀T
    rwa [show F.col z₀ = h from (hr hz₀).2] at this
  have hsub : hornSet v α κ' κ r ⊆ connectedComponentIn F.interiorPts z₀ :=
    hpre.subset_connectedComponentIn hz₀ hsubI
  have hvcl : v ∈ closure (connectedComponentIn F.interiorPts z₀) :=
    closure_mono hsub (mem_closure_of_mem_coneAt (mem_coneAt_hornSet v α hκ' hr0.1))
  have hball := hin _ hTh hvcl hz₀T
  have hfar : 1 < dist z₀ (v + e (α + π / 2)) := (tanBelow_one_iff v α z₀).mp (hz₀.2.2.2.mono hκ)
  rw [mem_ball] at hball
  linarith

/-- **A repeated colour at a stuck point, carried at a pole, has two horns along that pole's axis** (N3-DEG at the point, `stuck_horns_ua`,
the axis by `dot_eq_zero_of_antipodal_contact` at the contact `w − n`): exactly two sectors, cusp horns along `±e α` with bounds in
`[−1, 1]` and out-type contacts at `w ± n`. The second half of `lower_flank_horns_at_N_of`, at any point (FS131-I5p, for YB3 § 3.1 Step 4).
Model of the hypotheses at the point: `bowtie` at `0`, colour `1`, `α = 0` (`bowtie_valid`, `bowtie_isStuck`, `bowtie_coloursAt_zero`,
`bowtie_outType_one`); `Covers` is the caller's (every point of a plane map). -/
theorem horns_of_two_sectors_at (hF : F.Valid) {w : ℂ} (hv : F.Covers w 1) (hst : F.IsStuck w) {j : Fin k}
    (h2 : ∀ᶠ r in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf w r j).encard) {α : ℝ}
    (hjS : w - e (α + π / 2) ∈ closure (F.region j)) :
    F.HasSectors w j 2 ∧ ∃ μ₁ μ₂ μ₃ μ₄ : ℝ, F.IsHorn w α μ₁ μ₂ j ∧ F.IsHorn w (α + π) μ₃ μ₄ j ∧
      -1 ≤ μ₁ ∧ μ₂ ≤ 1 ∧ -1 ≤ μ₃ ∧ μ₄ ≤ 1 ∧
      (F.IsContact w j (w + e (α + π / 2)) ∧ F.OutType w j (w + e (α + π / 2))) ∧
      (F.IsContact w j (w - e (α + π / 2)) ∧ F.OutType w j (w - e (α + π / 2))) := by
  have hwd : w ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  obtain ⟨m, hm⟩ := exists_hasSectors hwd j
  have hm2 : 2 ≤ m := by
    obtain ⟨r, hr1, hr2⟩ := (hm.and h2).exists
    have : (2 : ℕ∞) ≤ m := hr1 ▸ hr2
    exact_mod_cast this
  obtain ⟨β, μ₁, μ₂, μ₃, μ₄, Hu, Hd, h1, h2', h3', h4', hh2', hcN, hcS⟩ := stuck_horns_ua hF hv hst hm2 hm
  have hEN : dist (w - e (α + π / 2)) w = 1 := by
    rw [dist_eq_norm, sub_sub_cancel_left, norm_neg, norm_e]
  have hdot := dot_eq_zero_of_antipodal_contact hF hv hjS hEN Hu.mem_coneAt_region Hd.mem_coneAt_region
  rw [sub_sub_cancel_left, dot_neg_right, dot_e_e] at hdot
  have hsin : Real.sin (β - α) = 0 := by
    have : Real.cos (β - (α + π / 2)) = 0 := by linarith
    rwa [show β - (α + π / 2) = (β - α) - π / 2 by ring, Real.cos_sub_pi_div_two] at this
  rcases e_eq_or_of_sin_sub_eq_zero hsin with he | he
  · have he' : e (β + π) = e (α + π) := by rw [e_add_pi', e_add_pi', he]
    have hn : e (β + π / 2) = e (α + π / 2) := by rw [e_add_pi_div_two, e_add_pi_div_two, he]
    rw [hn] at hcS hcN
    exact ⟨hh2', μ₁, μ₂, μ₃, μ₄, Hu.congr he, Hd.congr he', h1, h2', h3', h4', hcN, hcS⟩
  · have he' : e (β + π) = e α := by rw [e_add_pi', he, e_add_pi', neg_neg]
    have hn : e (β + π / 2) = -e (α + π / 2) := by rw [e_add_pi_div_two, e_add_pi_div_two, he, e_add_pi']; ring
    rw [hn, sub_neg_eq_add] at hcS
    rw [hn, ← sub_eq_add_neg] at hcN
    exact ⟨hh2', μ₃, μ₄, μ₁, μ₂, Hd.congr he', Hu.congr he, h3', h4', h1, h2', hcS, hcN⟩

/-- **The lower flank's two horns at `N`, over `Valid`, `IsPlaneMap` and `Terminal`** (`lower_flank_horns_at_N` with `QROnly` not read, for
`y3_end_needs`'s hypotheses, which carry no `QROnly`; FS131-I5n moved I5l's proof here unchanged). A step inside a refutation: no model expected. -/
theorem lower_flank_horns_at_N_of {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {E : ℂ} (hst : F.IsStuck E)
    (h3 : (F.coloursAt E).ncard = 3) {c : Fin 6} (hc2 : F.HasSectors E c 2) {α κ₁ κ₂ κ₄ : ℝ} (hH : F.IsHorn E α κ₁ κ₂ c)
    (hH' : F.IsHorn E (α + π) (-1) κ₄ c) {g h : Fin 6} (hg : F.IsFlankAbove E α κ₂ g) (hh : F.IsFlankBelow E α κ₁ h)
    (hnoHS : ¬ (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2)))) :
    F.IsStuck (E + e (α + π / 2)) ∧ 4 ≤ (F.coloursAt (E + e (α + π / 2))).ncard ∧ F.HasSectors (E + e (α + π / 2)) h 2 ∧
      ∃ μ₁ μ₂ μ₃ μ₄ : ℝ, F.IsHorn (E + e (α + π / 2)) α μ₁ μ₂ h ∧ F.IsHorn (E + e (α + π / 2)) (α + π) μ₃ μ₄ h ∧
        -1 ≤ μ₁ ∧ μ₂ ≤ 1 ∧ -1 ≤ μ₃ ∧ μ₄ ≤ 1 ∧
        (F.IsContact (E + e (α + π / 2)) h (E + e (α + π / 2) + e (α + π / 2)) ∧
          F.OutType (E + e (α + π / 2)) h (E + e (α + π / 2) + e (α + π / 2))) ∧
        (F.IsContact (E + e (α + π / 2)) h E ∧ F.OutType (E + e (α + π / 2)) h E) := by
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  have hdom : ∀ x, x ∈ F.dom := fun x => by rw [hP]; exact mem_univ x
  set N := E + e (α + π / 2) with hNdef
  obtain ⟨-, hhd, -, hNS, hSN⟩ := stuck_turned_frame hF hP hst h3.le hc2 hH hH' hg hh
  have hno : ∀ g', F.IsFlankAbove E (α + π) κ₄ g' →
      ¬ (F.IsContact E g' (E + e (α + π + π / 2)) ∧ F.InType E g' (E + e (α + π + π / 2))) := by
    intro g' hg' hx
    rw [hg'.unique hhd, hNS] at hx
    exact hnoHS hx
  -- E5 § 3.4 in the turned frame: the lower flank `h` has two sectors at `N`, which carries four colours (NB3-END items 2–4)
  obtain ⟨g', hg', hh2⟩ := flank_two_sectors_at_S hF hP hst h3 hc2 hH' hno
  rw [hg'.unique hhd, hSN] at hh2
  have h4 := n3_end_four_colours hF hP hT hst h3 hc2 hH' hno
  rw [hSN] at h4
  have hstN := isStuck_of_hasRepeatedColour hT (hdom N) ⟨h, hh2⟩
  obtain ⟨m, hm⟩ := exists_hasSectors (hdom N) h
  have hm2 : 2 ≤ m := by
    obtain ⟨r, hr1, hr2⟩ := (hm.and hh2).exists
    have : (2 : ℕ∞) ≤ m := hr1 ▸ hr2
    exact_mod_cast this
  obtain ⟨β, μ₁, μ₂, μ₃, μ₄, Hu, Hd, h1, h2, h3', h4', hh2', hcN, hcS⟩ := stuck_horns_ua hF (hvC N) hstN hm2 hm
  -- the axis at `N` is `±e α`: `h` is carried at `E ∈ ω(N)` and approaches `N` along `±e β`
  have hEN : dist E N = 1 := by
    rw [hNdef, dist_eq_norm, show E - (E + e (α + π / 2)) = -e (α + π / 2) by ring, norm_neg, norm_e]
  have hdot := dot_eq_zero_of_antipodal_contact hF (hvC N) (mem_closure_of_mem_coneAt hh.mem_coneAt) hEN
    Hu.mem_coneAt_region Hd.mem_coneAt_region
  rw [hNdef, show E - (E + e (α + π / 2)) = -e (α + π / 2) by ring, dot_neg_right, dot_e_e] at hdot
  have hsin : Real.sin (β - α) = 0 := by
    have : Real.cos (β - (α + π / 2)) = 0 := by linarith
    rwa [show β - (α + π / 2) = (β - α) - π / 2 by ring, Real.cos_sub_pi_div_two] at this
  have hNn : N - e (α + π / 2) = E := by rw [hNdef]; ring
  rcases e_eq_or_of_sin_sub_eq_zero hsin with he | he
  · have he' : e (β + π) = e (α + π) := by rw [e_add_pi', e_add_pi', he]
    have hn : e (β + π / 2) = e (α + π / 2) := by rw [e_add_pi_div_two, e_add_pi_div_two, he]
    rw [hn, hNn] at hcS
    rw [hn] at hcN
    exact ⟨hstN, h4, hh2', μ₁, μ₂, μ₃, μ₄, Hu.congr he, Hd.congr he', h1, h2, h3', h4', hcN, hcS⟩
  · have he' : e (β + π) = e α := by rw [e_add_pi', he, e_add_pi', neg_neg]
    have hn : e (β + π / 2) = -e (α + π / 2) := by rw [e_add_pi_div_two, e_add_pi_div_two, he, e_add_pi']; ring
    rw [hn, sub_neg_eq_add] at hcS
    rw [hn, ← sub_eq_add_neg, hNn] at hcN
    exact ⟨hstN, h4, hh2', μ₃, μ₄, μ₁, μ₂, Hd.congr he', Hu.congr he, h3', h4', h1, h2, hcS, hcN⟩

/-- **The lower flank's two horns at `N`** (FS114-CVB § 1.4 item 5 and § 1.6, YB3 § 3.1 Steps 2–3, in the setting of `cv_hd_main`'s and
`y3_end_needs`'s hypotheses with any `κ₂`): at a stuck vertex `E` with three colours whose `−e α` horn has its `N`-side arc on `ω(N)` (`κ₃ = −1`)
and no in-type lower-flank contact at `S`, the point `N` is stuck with at least four colours, and the lower flank `h` has exactly two sectors
there — cusp horns along `±e α` with bounds in `[−1, 1]` and out-type contacts at `N + n` and `E` — the `h`-tiles `Q±` of CVB. E5 § 3.4 and
NB3-END items 3–4 in the frame turned by `π` (`flank_two_sectors_at_S`, `n3_end_four_colours`), N3-DEG at `N` (`stuck_horns_ua`), the axis by
`dot_eq_zero_of_antipodal_contact` at the contact `E`. Shared first step of `cv_hd_main_inType` and `y3_end_needs` (FS131-I5l). A step inside a
refutation: no model expected. -/
theorem lower_flank_horns_at_N {F : ArcMap 6} (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E)
    (h3 : (F.coloursAt E).ncard = 3) {c : Fin 6} (hc2 : F.HasSectors E c 2) {α κ₁ κ₂ κ₄ : ℝ} (hH : F.IsHorn E α κ₁ κ₂ c)
    (hH' : F.IsHorn E (α + π) (-1) κ₄ c) {g h : Fin 6} (hg : F.IsFlankAbove E α κ₂ g) (hh : F.IsFlankBelow E α κ₁ h)
    (hnoHS : ¬ (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2)))) :
    F.IsStuck (E + e (α + π / 2)) ∧ 4 ≤ (F.coloursAt (E + e (α + π / 2))).ncard ∧ F.HasSectors (E + e (α + π / 2)) h 2 ∧
      ∃ μ₁ μ₂ μ₃ μ₄ : ℝ, F.IsHorn (E + e (α + π / 2)) α μ₁ μ₂ h ∧ F.IsHorn (E + e (α + π / 2)) (α + π) μ₃ μ₄ h ∧
        -1 ≤ μ₁ ∧ μ₂ ≤ 1 ∧ -1 ≤ μ₃ ∧ μ₄ ≤ 1 ∧
        (F.IsContact (E + e (α + π / 2)) h (E + e (α + π / 2) + e (α + π / 2)) ∧
          F.OutType (E + e (α + π / 2)) h (E + e (α + π / 2) + e (α + π / 2))) ∧
        (F.IsContact (E + e (α + π / 2)) h E ∧ F.OutType (E + e (α + π / 2)) h E) := by
  obtain ⟨hF, hP, hT, -⟩ := id hM
  exact lower_flank_horns_at_N_of hF hP hT hst h3 hc2 hH hH' hg hh hnoHS

/-- **Seven colours at `N`** (FS114-CVB § 1.6, "Branch `G_N`", with `G_N` read only as `g ∈ P_cl(N)`): in a terminal valid six-coloured map
of the plane, at a stuck vertex `E` with three colours whose horns' `N`-side arcs both lie on `ω(N)` (`κ₂ = 1`, `κ₃ = −1`), with no in-type
lower-flank contact at `S`, the upper flank colour `g` is not carried at `N`. Route (FS131-I5n; CVB's count with the four sectors flanking the `h`-horns `Q±` in place of the ring tiles):
`c, g, h`, and the colours of the sectors just after and just before `Q₊` and `Q₋` in the sector chart at `N`. Each of the four carries
`±e α` in its cone, so it is not `c` (U1 at `N`: `c`'s cone in the pinch about `+n`), not `g` (U1 for the flank: `g`'s cone in the pinch
about `−n`, `coneAt_N_subset_of_flankAbove`, `coneAt_S_subset_of_flankBelow`), not `h` (`h` has only the two sectors `Q±`), so absent at
`E = N − n`; two of them equal would be two sectors of one colour, MERGE at `N` (`mergeAvailable_of_two_sectors`), unless they are one
sector — excluded by the germ order and, for the two sides, by `c`'s sector above and `g`'s below (`Mono.disjoint`). It closes CVB's branch
`G_N` (`cv_hd_main_inType`) and Y3-END-NEEDS's case `g ∈ P_cl(N)` (`y3_end_needs`; YB3 § 3.1 Step 3 (a) shows `g ∉ P_cl(N)` there). A step
inside a proof by contradiction: no model expected. -/
theorem seven_colours_at_N {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard = 3)
    {c : Fin 6} (hc2 : F.HasSectors E c 2) {α κ₁ κ₄ : ℝ} (hH : F.IsHorn E α κ₁ 1 c)
    (hH' : F.IsHorn E (α + π) (-1) κ₄ c) {g h : Fin 6} (hg : F.IsFlankAbove E α 1 g) (hh : F.IsFlankBelow E α κ₁ h)
    (hgN : g ∈ F.coloursAt (E + e (α + π / 2)))
    (hnoHS : ¬ (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2)))) : False := by
  have hπ := Real.pi_pos
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  have hdom : ∀ x, x ∈ F.dom := fun x => by rw [hP]; exact mem_univ x
  obtain ⟨h1, -⟩ := horn_bounds_of_noMerge hF (hvC E) hst.1 le_rfl hc2 hH
  obtain ⟨-, h4⟩ := horn_bounds_of_noMerge hF (hvC E) hst.1 le_rfl hc2 hH'
  obtain ⟨hcN, hcS⟩ := horn_poles_contact hF (hvC E) hst.1 le_rfl hc2 hH
  -- `P_cl(E) = {c, g, h}`, and `g` flanks the `−e α` horn from its `N` side
  obtain ⟨g₁, h₁, -, hcolE, hgh, hgc, hhc, hg₁, hh₁, -, hg₁d, -⟩ :=
    stuck_flanks_ua hF (hvC E) hst h3.le hH hH' h1 le_rfl le_rfl h4 hc2 hcN hcS
  have hgg : g = g₁ := (hg₁.unique hg).symm
  have hhh : h = h₁ := (IsFlankBelow.unique hh₁ hh).symm
  subst hgg hhh
  -- the lower flank's two horns `Q±` at `N`, which is stuck
  obtain ⟨hstN, -, hhN2, μ₁, μ₂, μ₃, μ₄, Qp, Qm, -, -, -, -, -, -⟩ :=
    lower_flank_horns_at_N_of hF hP hT hst h3 hc2 hH hH' hg hh hnoHS
  set N := E + e (α + π / 2) with hNdef
  have hNE : N - e (α + π / 2) = E := by rw [hNdef]; ring
  have hNE' : N + e (α + π + π / 2) = E := by rw [add_e_add_pi_add, hNE]
  -- U1 at `N`: `c`'s cone in the pinch about `+n`, `g`'s in the pinch about `−n`
  obtain ⟨φc, hφc, -, hconeC1⟩ := coneAt_N_subset_of_horn hF hH h1
  obtain ⟨φc', hφc', -, hconeC2⟩ := coneAt_S_subset_of_horn hF hH' h4
  rw [sub_e_add_pi_add] at hconeC2
  obtain ⟨φg, hφg, -, hconeG1⟩ := coneAt_N_subset_of_flankAbove hF hg
  obtain ⟨φg', hφg', -, hconeG2⟩ := coneAt_S_subset_of_flankBelow hF hg₁d
  rw [sub_e_add_pi_add] at hconeG2
  have hαc : α ∉ coneAt (F.region c) N := fun hα =>
    not_mem_angleIcc_of_gap (-1) (by push_cast; linarith) (by push_cast; linarith) (hconeC1 hα)
  have hαπc : α + π ∉ coneAt (F.region c) N := fun hα =>
    not_mem_angleIcc_of_gap (-1) (by push_cast; linarith) (by push_cast; linarith) (hconeC2 hα)
  have hαg : α ∉ coneAt (F.region g) N := fun hα =>
    not_mem_angleIcc_of_gap (-1) (by push_cast; linarith) (by push_cast; linarith) (hconeG2 hα)
  have hαπg : α + π ∉ coneAt (F.region g) N := fun hα =>
    not_mem_angleIcc_of_gap (-1) (by push_cast; linarith) (by push_cast; linarith) (hconeG1 hα)
  -- the sector chart at `N`, and `Q±` in it
  obtain ⟨r₀, n, G, hC⟩ := localSectors F (hdom N)
  have hMo := hC.sorted.mono
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  obtain ⟨rq, ⟨⟨hSp, hSpc⟩, ⟨hSm, hSmc⟩⟩, hrq⟩ := ((Qp.2.and Qm.2).and (Ioc_mem_nhdsGT hC.pos)).exists
  obtain ⟨ip, hβp, hnp, hκp, hnκp, hsecp⟩ := hC.index_of_isSector_hornSet hrq Qp.1 hSp
  obtain ⟨im, hβm, hnm, hκm, hnκm, hsecm⟩ := hC.index_of_isSector_hornSet hrq Qm.1 hSm
  have hn : 0 < n := ip.pos
  -- the colour of a chart sector, read at one radius
  have colEq : ∀ (i : Fin n) (j j' : Fin 6), (∀ r ∈ Ioc 0 r₀, G.sector N r i ⊆ F.region j) →
      (∀ r ∈ Ioc 0 r₀, G.sector N r i ⊆ F.region j') → j = j' := by
    intro i j j' hj hj'
    obtain ⟨z, hz⟩ := hC.sector_nonempty hr₀ i
    exact ((hj r₀ hr₀ hz).2).symm.trans (hj' r₀ hr₀ hz).2
  have colQ : ∀ i : Fin n, ∀ {ν₁ ν₂ β : ℝ}, (∀ r' ∈ Ioc 0 r₀, G.sector N r' i = hornSet N β ν₁ ν₂ r') →
      hornSet N β ν₁ ν₂ rq ⊆ F.col ⁻¹' {h} → ∀ r ∈ Ioc 0 r₀, G.sector N r i ⊆ F.region h := by
    intro i ν₁ ν₂ β hsec hsub
    obtain ⟨h', hh'⟩ := hC.exists_col i
    obtain ⟨z, hz⟩ := hC.sector_nonempty hrq i
    have hzh : F.col z = h := by rw [hsec rq hrq] at hz; exact hsub hz
    have : h' = h := ((hh' rq hrq (by rw [hsec rq hrq] at hz ⊢; exact hz)).2).symm.trans hzh
    exact this ▸ hh'
  have colp := colQ ip hsecp hSpc
  have colm := colQ im hsecm hSmc
  -- the four sectors flanking `Q±`
  obtain ⟨a, hβa, hκa⟩ := G.exists_succ ip
  obtain ⟨b, hβb, hκb⟩ := G.exists_pred ip
  obtain ⟨c', hβc', hκc'⟩ := G.exists_pred im
  obtain ⟨d, hβd, hκd⟩ := G.exists_succ im
  rw [hnp, hβp] at hβa
  rw [hβp] at hβb
  rw [hβm] at hβc'
  rw [hnm, hβm] at hβd
  rw [hnκp] at hκa
  rw [hκp] at hκb
  rw [hκm] at hκc'
  rw [hnκm] at hκd
  have hne : e α ≠ e (α + π) := (e_add_pi_ne α).symm
  -- index distinctness from the germs
  have hipm : ip ≠ im := fun heq => hne (by rw [← hβp, ← hβm, heq])
  have hap : a ≠ ip := fun heq => by rw [heq, hκp] at hκa; exact absurd hκa (ne_of_lt Qp.1)
  have ham : a ≠ im := fun heq => hne (by rw [← hβa, ← hβm, heq])
  have hbp : b ≠ ip := fun heq => by rw [heq, hnκp] at hκb; exact absurd hκb.symm (ne_of_lt Qp.1)
  have hbm : b ≠ im := fun heq => hne (by rw [← hβb, ← hβm, ← hnm, heq])
  have hcm : c' ≠ im := fun heq => by rw [heq, hnκm] at hκc'; exact absurd hκc'.symm (ne_of_lt Qm.1)
  have hcp : c' ≠ ip := fun heq => hne (by rw [← hβc', ← hβp, ← hnp, heq])
  have hdm : d ≠ im := fun heq => by rw [heq, hκm] at hκd; exact absurd hκd (ne_of_lt Qm.1)
  have hdp : d ≠ ip := fun heq => hne (by rw [← hβd, ← hβp, heq])
  have had : a ≠ d := fun heq => hne (by rw [← hβa, ← hβd, heq])
  have hbc : b ≠ c' := fun heq => hne (by rw [← hβb, ← hβc', heq])
  have hab : a ≠ b := by
    intro heq
    subst heq
    rcases hC.sorted.2 a with hlt | ⟨-, hκlt⟩
    · exact hMo.false_of_full ham (hβa.trans hβb.symm) hlt (by rw [hβm, hβa]; exact hne.symm)
    · rw [hκa, hκb] at hκlt; exact absurd hκlt (not_lt.mpr Qp.1.le)
  have hcd : c' ≠ d := by
    intro heq
    subst heq
    rcases hC.sorted.2 c' with hlt | ⟨-, hκlt⟩
    · exact hMo.false_of_full hcp (hβd.trans hβc'.symm) hlt (by rw [hβp, hβd]; exact hne)
    · rw [hκd, hκc'] at hκlt; exact absurd hκlt (not_lt.mpr Qm.1.le)
  -- their colours, and a direction of each along the axis
  obtain ⟨xa, hxa⟩ := hC.exists_col a
  obtain ⟨xb, hxb⟩ := hC.exists_col b
  obtain ⟨xc, hxc⟩ := hC.exists_col c'
  obtain ⟨xd, hxd⟩ := hC.exists_col d
  have coneβ : ∀ (i : Fin n) (j : Fin 6), (∀ r ∈ Ioc 0 r₀, G.sector N r i ⊆ F.region j) → G.β i ∈ coneAt (F.region j) N := by
    intro i j hj
    have : G.β i ∈ coneAt (G.sector N r₀ i) N := by
      rw [hC.cone r₀ hr₀ i]; exact Icc_subset_angleIcc _ _ ⟨le_rfl, hMo i⟩
    exact coneAt_mono (hj r₀ hr₀) N this
  have coneNβ : ∀ (i : Fin n) (j : Fin 6), (∀ r ∈ Ioc 0 r₀, G.sector N r i ⊆ F.region j) →
      G.nextβ i ∈ coneAt (F.region j) N := by
    intro i j hj
    have : G.nextβ i ∈ coneAt (G.sector N r₀ i) N := by
      rw [hC.cone r₀ hr₀ i]; exact Icc_subset_angleIcc _ _ ⟨hMo i, le_rfl⟩
    exact coneAt_mono (hj r₀ hr₀) N this
  have hαa : α ∈ coneAt (F.region xa) N := mem_coneAt_of_e_eq hβa (coneβ a xa hxa)
  have hαb : α ∈ coneAt (F.region xb) N := mem_coneAt_of_e_eq hβb (coneNβ b xb hxb)
  have hαc' : α + π ∈ coneAt (F.region xc) N := mem_coneAt_of_e_eq hβc' (coneNβ c' xc hxc)
  have hαd : α + π ∈ coneAt (F.region xd) N := mem_coneAt_of_e_eq hβd (coneβ d xd hxd)
  -- none is `c` or `g` (U1 at `N`), nor `h` (`h` has exactly the two sectors `Q±` at `N`)
  obtain ⟨r2, hr2e, hr2⟩ := (hhN2.and (Ioc_mem_nhdsGT hC.pos)).exists
  have three : ∀ i : Fin n, i ≠ ip → i ≠ im → (∀ r ∈ Ioc 0 r₀, G.sector N r i ⊆ F.region h) → False := by
    intro i hip him hi
    have hle := hC.card_le_encard_sectorsOf hr2 {ip, im, i} (by
      intro l hl
      rcases Finset.mem_insert.mp hl with rfl | hl
      · exact colp r2 hr2
      rcases Finset.mem_insert.mp hl with rfl | hl
      · exact colm r2 hr2
      rw [Finset.mem_singleton.mp hl]; exact hi r2 hr2)
    rw [hr2e, Finset.card_insert_of_notMem (by simp [hipm, hip.symm]), Finset.card_pair (Ne.symm him)] at hle
    norm_num at hle
  have hxac : xa ≠ c := by rintro rfl; exact hαc hαa
  have hxbc : xb ≠ c := by rintro rfl; exact hαc hαb
  have hxcc : xc ≠ c := by rintro rfl; exact hαπc hαc'
  have hxdc : xd ≠ c := by rintro rfl; exact hαπc hαd
  have hxag : xa ≠ g := by rintro rfl; exact hαg hαa
  have hxbg : xb ≠ g := by rintro rfl; exact hαg hαb
  have hxcg : xc ≠ g := by rintro rfl; exact hαπg hαc'
  have hxdg : xd ≠ g := by rintro rfl; exact hαπg hαd
  have hxah : xa ≠ h := by rintro rfl; exact three a hap ham hxa
  have hxbh : xb ≠ h := by rintro rfl; exact three b hbp hbm hxb
  have hxch : xc ≠ h := by rintro rfl; exact three c' hcp hcm hxc
  have hxdh : xd ≠ h := by rintro rfl; exact three d hdp hdm hxd
  have hnotE : ∀ j : Fin 6, j ≠ c → j ≠ g → j ≠ h → E ∉ closure (F.region j) := by
    intro j hjc hjg hjh hj
    have hj' : j ∈ F.coloursAt E := hj
    rw [hcolE] at hj'
    simp only [mem_insert_iff, mem_singleton_iff] at hj'
    rcases hj' with rfl | rfl | rfl
    exacts [hjc rfl, hjg rfl, hjh rfl]
  -- two sectors of one of these colours at `N`: W-MERGE at `N` (the pole `N − n = E` carries none of them)
  have mergeα : ∀ i i' : Fin n, i ≠ i' → ∀ j : Fin 6, (∀ r ∈ Ioc 0 r₀, G.sector N r i ⊆ F.region j) →
      (∀ r ∈ Ioc 0 r₀, G.sector N r i' ⊆ F.region j) → α ∈ coneAt (F.region j) N → E ∉ closure (F.region j) → False :=
    fun i i' hii j hi hi' hα hE =>
      hstN.1 (mergeAvailable_of_two_sectors hF (hvC N) hC hii hi hi' hα (Or.inr (by rwa [hNE])))
  have mergeαπ : ∀ i i' : Fin n, i ≠ i' → ∀ j : Fin 6, (∀ r ∈ Ioc 0 r₀, G.sector N r i ⊆ F.region j) →
      (∀ r ∈ Ioc 0 r₀, G.sector N r i' ⊆ F.region j) → α + π ∈ coneAt (F.region j) N → E ∉ closure (F.region j) → False :=
    fun i i' hii j hi hi' hα hE =>
      hstN.1 (mergeAvailable_of_two_sectors hF (hvC N) hC hii hi hi' hα (Or.inl (by rwa [hNE'])))
  have hxab : xa ≠ xb := by
    rintro rfl; exact mergeα a b hab xa hxa hxb hαa (hnotE xa hxac hxag hxah)
  have hxad : xa ≠ xd := by
    rintro rfl; exact mergeα a d had xa hxa hxd hαa (hnotE xa hxac hxag hxah)
  have hxbc' : xb ≠ xc := by
    rintro rfl; exact mergeα b c' hbc xb hxb hxc hαb (hnotE xb hxbc hxbg hxbh)
  have hxcd : xc ≠ xd := by
    rintro rfl; exact mergeαπ c' d hcd xc hxc hxd hαc' (hnotE xc hxcc hxcg hxch)
  -- the upper side has a sector of `c` besides `a`, the lower side one of `g` besides `d`
  have hac : a ≠ c' := by
    intro heq
    subst heq
    obtain ⟨ic, hic, hβic⟩ := hC.exists_index_of_mem_coloursAt hn hcN.1.2.2
    have hica : a ≠ ic := by
      rintro rfl; exact hxac (colEq a xa c hxa hic)
    have hx2 : G.β ic ∈ angleIcc α (α + π - φc') := by
      obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp (hconeC2 hβic)
      exact mem_iUnion.mpr ⟨m + 1, by push_cast; linarith, by push_cast; linarith⟩
    have := mem_angleIoo_half hβa hβc' (hMo a) (hMo.nextβ_le_add a) hφc hφc' (hconeC1 hβic) hx2
    exact Set.disjoint_left.mp (hMo.disjoint hica) (Icc_subset_angleIcc _ _ ⟨le_rfl, hMo ic⟩) this
  have hbd : b ≠ d := by
    intro heq
    subst heq
    obtain ⟨ig, hig, hβig⟩ := hC.exists_index_of_mem_coloursAt hn hgN
    have higb : b ≠ ig := by
      rintro rfl; exact hxdg (colEq b xd g hxd hig)
    have he' : e (G.nextβ b) = e (α + π + π) := by
      rw [hβb, show α + π + π = α + 2 * π by ring, e_add_two_pi]
    have hx1 : G.β ig ∈ angleIcc (α + π + φg) (α + π + π) := by
      rw [show α + π + π = α + 2 * π by ring]; exact hconeG1 hβig
    have := mem_angleIoo_half hβd he' (hMo b) (hMo.nextβ_le_add b) hφg hφg' hx1 (hconeG2 hβig)
    exact Set.disjoint_left.mp (hMo.disjoint higb) (Icc_subset_angleIcc _ _ ⟨le_rfl, hMo ig⟩) this
  have hxac' : xa ≠ xc := by
    rintro rfl; exact mergeα a c' hac xa hxa hxc hαa (hnotE xa hxac hxag hxah)
  have hxbd : xb ≠ xd := by
    rintro rfl; exact mergeα b d hbd xb hxb hxd hαb (hnotE xb hxbc hxbg hxbh)
  -- seven distinct colours in `Fin 6`
  have hnd : [c, g, h, xa, xb, xc, xd].Nodup := by
    simp only [List.nodup_cons, List.mem_cons, List.not_mem_nil, or_false, not_or, List.nodup_nil, and_true]
    exact ⟨⟨hgc.symm, hhc.symm, hxac.symm, hxbc.symm, hxcc.symm, hxdc.symm⟩,
      ⟨hgh, hxag.symm, hxbg.symm, hxcg.symm, hxdg.symm⟩, ⟨hxah.symm, hxbh.symm, hxch.symm, hxdh.symm⟩,
      ⟨hxab, hxac', hxad⟩, ⟨hxbc', hxbd⟩, hxcd, not_false⟩
  have := hnd.length_le_card
  simp at this

/-- **FS112-Y3-END-NEEDS, the case `g ∉ P_cl(N)`** (`plans/FS112-YB3-verification.md` § 3.1 Steps 3–4, with Step 3's sharpening (a)): the case
of `y3_end_needs` that `seven_colours_at_N` leaves. Route (FS131-I5p): the four chart sectors flanking the `h`-horns `Q±` at `N` carry colours
`x₁` (above `Q₊`), `y₁` (below `Q₊`), `x₂` (above `Q₋`), `y₂` (below `Q₋`), distinct from `c`, `h` and from each other as in `seven_colours_at_N`
(the lower pair excepted), all carried at `N` while `g` is not; so `y₁ ≠ y₂` gives seven colours. Otherwise `y = y₁ = y₂` flanks both horns from
below (YB3's `y`) and Step 4 runs at `M = N + n`: no SHAVE at `N` puts in-type `x₁`- and `x₂`-contacts at `M` (`srcG_of_shadow`,
`srcH_of_shadow`, as `x_i ∉ P_cl(E)`), so `Q±`'s upper arcs lie on `ω(M)`; E5 § 3.4 at `N` in the turned frame gives `y` two sectors at `M`
(`flank_two_sectors_at_S_of_flanks`), so `M` is stuck with `y`-horns `R±` along `±e α` (`horns_of_two_sectors_at`); the upper flanks `z₁`, `z₂` of
`R±` are not `y` (two sectors), not `h` (U1 at `M`), not `x₁`, `x₂` (their tiles at `M` lie outside `B̄(N, 1)`, `not_inType_S_of_flankAbove`,
`not_inType_N_of_flankBelow`), not `c` (an out-type `c`-contact at `M` would bar `c`'s directions at `N`), so both are `g`, on two sectors at `M`
separated by `h`'s, with `g ∉ P_cl(N)`: MERGE at `M`. A step inside a proof by contradiction: no model expected. -/
theorem y3_end_needs_of_not_mem {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {E : ℂ} (hst : F.IsStuck E)
    (h3 : (F.coloursAt E).ncard = 3) {c : Fin 6} (hc2 : F.HasSectors E c 2) {α κ₁ κ₄ : ℝ}
    (hH : F.IsHorn E α κ₁ 1 c) (hH' : F.IsHorn E (α + π) (-1) κ₄ c) {g h : Fin 6} (hg : F.IsFlankAbove E α 1 g)
    (hh : F.IsFlankBelow E α κ₁ h)
    (hnoH : ¬ (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2))))
    (hgN : g ∉ F.coloursAt (E + e (α + π / 2))) : False := by
  have hπ := Real.pi_pos
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  have hdom : ∀ x, x ∈ F.dom := fun x => by rw [hP]; exact mem_univ x
  obtain ⟨h1, -⟩ := horn_bounds_of_noMerge hF (hvC E) hst.1 le_rfl hc2 hH
  obtain ⟨-, h4⟩ := horn_bounds_of_noMerge hF (hvC E) hst.1 le_rfl hc2 hH'
  obtain ⟨hcN, hcS⟩ := horn_poles_contact hF (hvC E) hst.1 le_rfl hc2 hH
  -- `P_cl(E) = {c, g, h}`, and `g` flanks the `−e α` horn from its `N` side
  obtain ⟨g₁, h₁, -, hcolE, hgh, hgc, hhc, hg₁, hh₁, -, -, -⟩ :=
    stuck_flanks_ua hF (hvC E) hst h3.le hH hH' h1 le_rfl le_rfl h4 hc2 hcN hcS
  have hgg : g = g₁ := (hg₁.unique hg).symm
  have hhh : h = h₁ := (IsFlankBelow.unique hh₁ hh).symm
  subst hgg hhh
  -- the lower flank's two horns `Q±` at `N`, which is stuck
  obtain ⟨hstN, -, hhN2, μ₁, μ₂, μ₃, μ₄, Qp, Qm, hμ₁, hμ₂, hμ₃, hμ₄, hhM, -⟩ :=
    lower_flank_horns_at_N_of hF hP hT hst h3 hc2 hH hH' hg hh hnoH
  set N := E + e (α + π / 2) with hNdef
  have hNE : N - e (α + π / 2) = E := by rw [hNdef]; ring
  have hNE' : N + e (α + π + π / 2) = E := by rw [add_e_add_pi_add, hNE]
  -- U1 at `N`: `c`'s cone in the pinch about `+n`, `g`'s in the pinch about `−n`
  obtain ⟨φc, hφc, -, hconeC1⟩ := coneAt_N_subset_of_horn hF hH h1
  obtain ⟨φc', hφc', -, hconeC2⟩ := coneAt_S_subset_of_horn hF hH' h4
  rw [sub_e_add_pi_add] at hconeC2
  have hαc : α ∉ coneAt (F.region c) N := fun hα =>
    not_mem_angleIcc_of_gap (-1) (by push_cast; linarith) (by push_cast; linarith) (hconeC1 hα)
  have hαπc : α + π ∉ coneAt (F.region c) N := fun hα =>
    not_mem_angleIcc_of_gap (-1) (by push_cast; linarith) (by push_cast; linarith) (hconeC2 hα)
  -- the sector chart at `N`, and `Q±` in it
  obtain ⟨r₀, n, G, hC⟩ := localSectors F (hdom N)
  have hMo := hC.sorted.mono
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  obtain ⟨rq, ⟨⟨hSp, hSpc⟩, ⟨hSm, hSmc⟩⟩, hrq⟩ := ((Qp.2.and Qm.2).and (Ioc_mem_nhdsGT hC.pos)).exists
  obtain ⟨ip, hβp, hnp, hκp, hnκp, hsecp⟩ := hC.index_of_isSector_hornSet hrq Qp.1 hSp
  obtain ⟨im, hβm, hnm, hκm, hnκm, hsecm⟩ := hC.index_of_isSector_hornSet hrq Qm.1 hSm
  have hn : 0 < n := ip.pos
  -- the colour of a chart sector, read at one radius
  have colEq : ∀ (i : Fin n) (j j' : Fin 6), (∀ r ∈ Ioc 0 r₀, G.sector N r i ⊆ F.region j) →
      (∀ r ∈ Ioc 0 r₀, G.sector N r i ⊆ F.region j') → j = j' := by
    intro i j j' hj hj'
    obtain ⟨z, hz⟩ := hC.sector_nonempty hr₀ i
    exact ((hj r₀ hr₀ hz).2).symm.trans (hj' r₀ hr₀ hz).2
  have colQ : ∀ i : Fin n, ∀ {ν₁ ν₂ β : ℝ}, (∀ r' ∈ Ioc 0 r₀, G.sector N r' i = hornSet N β ν₁ ν₂ r') →
      hornSet N β ν₁ ν₂ rq ⊆ F.col ⁻¹' {h} → ∀ r ∈ Ioc 0 r₀, G.sector N r i ⊆ F.region h := by
    intro i ν₁ ν₂ β hsec hsub
    obtain ⟨h', hh'⟩ := hC.exists_col i
    obtain ⟨z, hz⟩ := hC.sector_nonempty hrq i
    have hzh : F.col z = h := by rw [hsec rq hrq] at hz; exact hsub hz
    have : h' = h := ((hh' rq hrq (by rw [hsec rq hrq] at hz ⊢; exact hz)).2).symm.trans hzh
    exact this ▸ hh'
  have colp := colQ ip hsecp hSpc
  have colm := colQ im hsecm hSmc
  -- the four sectors flanking `Q±`
  obtain ⟨a, hβa, hκa⟩ := G.exists_succ ip
  obtain ⟨b, hβb, hκb⟩ := G.exists_pred ip
  obtain ⟨c', hβc', hκc'⟩ := G.exists_pred im
  obtain ⟨d, hβd, hκd⟩ := G.exists_succ im
  rw [hnp, hβp] at hβa
  rw [hβp] at hβb
  rw [hβm] at hβc'
  rw [hnm, hβm] at hβd
  rw [hnκp] at hκa
  rw [hκp] at hκb
  rw [hκm] at hκc'
  rw [hnκm] at hκd
  have hne : e α ≠ e (α + π) := (e_add_pi_ne α).symm
  -- index distinctness from the germs
  have hipm : ip ≠ im := fun heq => hne (by rw [← hβp, ← hβm, heq])
  have hap : a ≠ ip := fun heq => by rw [heq, hκp] at hκa; exact absurd hκa (ne_of_lt Qp.1)
  have ham : a ≠ im := fun heq => hne (by rw [← hβa, ← hβm, heq])
  have hbp : b ≠ ip := fun heq => by rw [heq, hnκp] at hκb; exact absurd hκb.symm (ne_of_lt Qp.1)
  have hbm : b ≠ im := fun heq => hne (by rw [← hβb, ← hβm, ← hnm, heq])
  have hcm : c' ≠ im := fun heq => by rw [heq, hnκm] at hκc'; exact absurd hκc'.symm (ne_of_lt Qm.1)
  have hcp : c' ≠ ip := fun heq => hne (by rw [← hβc', ← hβp, ← hnp, heq])
  have hdm : d ≠ im := fun heq => by rw [heq, hκm] at hκd; exact absurd hκd (ne_of_lt Qm.1)
  have hdp : d ≠ ip := fun heq => hne (by rw [← hβd, ← hβp, heq])
  have had : a ≠ d := fun heq => hne (by rw [← hβa, ← hβd, heq])
  have hbc : b ≠ c' := fun heq => hne (by rw [← hβb, ← hβc', heq])
  have hab : a ≠ b := by
    intro heq
    subst heq
    rcases hC.sorted.2 a with hlt | ⟨-, hκlt⟩
    · exact hMo.false_of_full ham (hβa.trans hβb.symm) hlt (by rw [hβm, hβa]; exact hne.symm)
    · rw [hκa, hκb] at hκlt; exact absurd hκlt (not_lt.mpr Qp.1.le)
  have hcd : c' ≠ d := by
    intro heq
    subst heq
    rcases hC.sorted.2 c' with hlt | ⟨-, hκlt⟩
    · exact hMo.false_of_full hcp (hβd.trans hβc'.symm) hlt (by rw [hβp, hβd]; exact hne)
    · rw [hκd, hκc'] at hκlt; exact absurd hκlt (not_lt.mpr Qm.1.le)
  -- their colours, and a direction of each along the axis
  obtain ⟨xa, hxa⟩ := hC.exists_col a
  obtain ⟨xb, hxb⟩ := hC.exists_col b
  obtain ⟨xc, hxc⟩ := hC.exists_col c'
  obtain ⟨xd, hxd⟩ := hC.exists_col d
  have coneβ : ∀ (i : Fin n) (j : Fin 6), (∀ r ∈ Ioc 0 r₀, G.sector N r i ⊆ F.region j) → G.β i ∈ coneAt (F.region j) N := by
    intro i j hj
    have : G.β i ∈ coneAt (G.sector N r₀ i) N := by
      rw [hC.cone r₀ hr₀ i]; exact Icc_subset_angleIcc _ _ ⟨le_rfl, hMo i⟩
    exact coneAt_mono (hj r₀ hr₀) N this
  have coneNβ : ∀ (i : Fin n) (j : Fin 6), (∀ r ∈ Ioc 0 r₀, G.sector N r i ⊆ F.region j) →
      G.nextβ i ∈ coneAt (F.region j) N := by
    intro i j hj
    have : G.nextβ i ∈ coneAt (G.sector N r₀ i) N := by
      rw [hC.cone r₀ hr₀ i]; exact Icc_subset_angleIcc _ _ ⟨hMo i, le_rfl⟩
    exact coneAt_mono (hj r₀ hr₀) N this
  have hαa : α ∈ coneAt (F.region xa) N := mem_coneAt_of_e_eq hβa (coneβ a xa hxa)
  have hαb : α ∈ coneAt (F.region xb) N := mem_coneAt_of_e_eq hβb (coneNβ b xb hxb)
  have hαc' : α + π ∈ coneAt (F.region xc) N := mem_coneAt_of_e_eq hβc' (coneNβ c' xc hxc)
  have hαd : α + π ∈ coneAt (F.region xd) N := mem_coneAt_of_e_eq hβd (coneβ d xd hxd)
  -- none is `c` or `g` (U1 at `N`), nor `h` (`h` has exactly the two sectors `Q±` at `N`)
  obtain ⟨r2, hr2e, hr2⟩ := (hhN2.and (Ioc_mem_nhdsGT hC.pos)).exists
  have three : ∀ i : Fin n, i ≠ ip → i ≠ im → (∀ r ∈ Ioc 0 r₀, G.sector N r i ⊆ F.region h) → False := by
    intro i hip him hi
    have hle := hC.card_le_encard_sectorsOf hr2 {ip, im, i} (by
      intro l hl
      rcases Finset.mem_insert.mp hl with rfl | hl
      · exact colp r2 hr2
      rcases Finset.mem_insert.mp hl with rfl | hl
      · exact colm r2 hr2
      rw [Finset.mem_singleton.mp hl]; exact hi r2 hr2)
    rw [hr2e, Finset.card_insert_of_notMem (by simp [hipm, hip.symm]), Finset.card_pair (Ne.symm him)] at hle
    norm_num at hle
  have hxac : xa ≠ c := by rintro rfl; exact hαc hαa
  have hxbc : xb ≠ c := by rintro rfl; exact hαc hαb
  have hxcc : xc ≠ c := by rintro rfl; exact hαπc hαc'
  have hxdc : xd ≠ c := by rintro rfl; exact hαπc hαd
  have hxag : xa ≠ g := by rintro rfl; exact hgN (mem_closure_of_mem_coneAt hαa)
  have hxbg : xb ≠ g := by rintro rfl; exact hgN (mem_closure_of_mem_coneAt hαb)
  have hxcg : xc ≠ g := by rintro rfl; exact hgN (mem_closure_of_mem_coneAt hαc')
  have hxdg : xd ≠ g := by rintro rfl; exact hgN (mem_closure_of_mem_coneAt hαd)
  have hxah : xa ≠ h := by rintro rfl; exact three a hap ham hxa
  have hxbh : xb ≠ h := by rintro rfl; exact three b hbp hbm hxb
  have hxch : xc ≠ h := by rintro rfl; exact three c' hcp hcm hxc
  have hxdh : xd ≠ h := by rintro rfl; exact three d hdp hdm hxd
  have hnotE : ∀ j : Fin 6, j ≠ c → j ≠ g → j ≠ h → E ∉ closure (F.region j) := by
    intro j hjc hjg hjh hj
    have hj' : j ∈ F.coloursAt E := hj
    rw [hcolE] at hj'
    simp only [mem_insert_iff, mem_singleton_iff] at hj'
    rcases hj' with rfl | rfl | rfl
    exacts [hjc rfl, hjg rfl, hjh rfl]
  -- two sectors of one of these colours at `N`: W-MERGE at `N` (the pole `N − n = E` carries none of them)
  have mergeα : ∀ i i' : Fin n, i ≠ i' → ∀ j : Fin 6, (∀ r ∈ Ioc 0 r₀, G.sector N r i ⊆ F.region j) →
      (∀ r ∈ Ioc 0 r₀, G.sector N r i' ⊆ F.region j) → α ∈ coneAt (F.region j) N → E ∉ closure (F.region j) → False :=
    fun i i' hii j hi hi' hα hE =>
      hstN.1 (mergeAvailable_of_two_sectors hF (hvC N) hC hii hi hi' hα (Or.inr (by rwa [hNE])))
  have mergeαπ : ∀ i i' : Fin n, i ≠ i' → ∀ j : Fin 6, (∀ r ∈ Ioc 0 r₀, G.sector N r i ⊆ F.region j) →
      (∀ r ∈ Ioc 0 r₀, G.sector N r i' ⊆ F.region j) → α + π ∈ coneAt (F.region j) N → E ∉ closure (F.region j) → False :=
    fun i i' hii j hi hi' hα hE =>
      hstN.1 (mergeAvailable_of_two_sectors hF (hvC N) hC hii hi hi' hα (Or.inl (by rwa [hNE'])))
  have hxab : xa ≠ xb := by
    rintro rfl; exact mergeα a b hab xa hxa hxb hαa (hnotE xa hxac hxag hxah)
  have hxad : xa ≠ xd := by
    rintro rfl; exact mergeα a d had xa hxa hxd hαa (hnotE xa hxac hxag hxah)
  have hxbc' : xb ≠ xc := by
    rintro rfl; exact mergeα b c' hbc xb hxb hxc hαb (hnotE xb hxbc hxbg hxbh)
  have hxcd : xc ≠ xd := by
    rintro rfl; exact mergeαπ c' d hcd xc hxc hxd hαc' (hnotE xc hxcc hxcg hxch)
  -- the upper side has a sector of `c` besides `a`
  have hac : a ≠ c' := by
    intro heq
    subst heq
    obtain ⟨ic, hic, hβic⟩ := hC.exists_index_of_mem_coloursAt hn hcN.1.2.2
    have hica : a ≠ ic := by
      rintro rfl; exact hxac (colEq a xa c hxa hic)
    have hx2 : G.β ic ∈ angleIcc α (α + π - φc') := by
      obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp (hconeC2 hβic)
      exact mem_iUnion.mpr ⟨m + 1, by push_cast; linarith, by push_cast; linarith⟩
    have := mem_angleIoo_half hβa hβc' (hMo a) (hMo.nextβ_le_add a) hφc hφc' (hconeC1 hβic) hx2
    exact Set.disjoint_left.mp (hMo.disjoint hica) (Icc_subset_angleIcc _ _ ⟨le_rfl, hMo ic⟩) this
  have hxac' : xa ≠ xc := by
    rintro rfl; exact mergeα a c' hac xa hxa hxc hαa (hnotE xa hxac hxag hxah)
  -- seven distinct colours in `Fin 6`
  -- the lower side: two colours give seven at `N` with `g`, which is not carried there
  by_cases hbd : xb = xd
  swap
  · have hnd : [c, g, h, xa, xb, xc, xd].Nodup := by
      simp only [List.nodup_cons, List.mem_cons, List.not_mem_nil, or_false, not_or, List.nodup_nil, and_true]
      exact ⟨⟨hgc.symm, hhc.symm, hxac.symm, hxbc.symm, hxcc.symm, hxdc.symm⟩,
        ⟨hgh, hxag.symm, hxbg.symm, hxcg.symm, hxdg.symm⟩, ⟨hxah.symm, hxbh.symm, hxch.symm, hxdh.symm⟩,
        ⟨hxab, hxac', hxad⟩, ⟨hxbc', hbd⟩, hxcd, not_false⟩
    have := hnd.length_le_card
    simp at this
  -- one colour `y = xb` below both horns `Q±` (YB3's `y`): YB3 § 3.1 Step 4 at `M = N + n`
  have hxd' : ∀ r ∈ Ioc 0 r₀, G.sector N r d ⊆ F.region xb := hbd ▸ hxd
  have flA : F.IsFlankAbove N α μ₂ xa := hC.isFlankAbove_of_col hβa hκa hxa
  have flB : F.IsFlankBelow N α μ₁ xb := hC.isFlankBelow_of_col hβb hκb hxb
  have flC : F.IsFlankBelow N (α + π) μ₃ xc := hC.isFlankBelow_of_col hβc' hκc' hxc
  have flD : F.IsFlankAbove N (α + π) μ₄ xb := hC.isFlankAbove_of_col hβd hκd hxd'
  have hxaE := hnotE xa hxac hxag hxah
  have hxbE := hnotE xb hxbc hxbg hxbh
  have hxcE := hnotE xc hxcc hxcg hxch
  set M := N + e (α + π / 2) with hMdef
  have hMN : M - e (α + π / 2) = N := by rw [hMdef]; ring
  have hMN' : M + e (α + π + π / 2) = N := by rw [add_e_add_pi_add, hMN]
  -- no SHAVE at `N`: the upper flanks' shadows come from in-type contacts at `M`, so `Q±`'s upper arcs lie on `ω(M)`
  obtain ⟨shA, -⟩ := shadow_of_not_shave hstN.2.2.1 Qp flA flB
  have hinA : F.IsContact N xa M ∧ F.InType N xa M := by
    rcases srcG_of_shadow hF (hvC N) hμ₁ Qp.1 hμ₂ flA shA with hin | hout
    · exact hin
    · exact absurd (by have := hout.1.2.2; rwa [hNE] at this) hxaE
  have hμ₂1 : μ₂ = 1 := by
    by_contra hne'
    exact (contact_inType_or_outType hF (hvC N) hinA.1).2
      ⟨hinA.2, outType_N_of_flankAbove hF (hvC N) (lt_of_le_of_ne hμ₂ hne') flA hinA.1.2.2⟩
  obtain ⟨-, shC⟩ := shadow_of_not_shave hstN.2.2.1 Qm flD flC
  have hinC : F.IsContact N xc (N - e (α + π + π / 2)) ∧ F.InType N xc (N - e (α + π + π / 2)) := by
    rcases srcH_of_shadow hF (hvC N) hμ₃ Qm.1 hμ₄ flC shC with hin | hout
    · exact hin
    · exact absurd (by have := hout.1.2.2; rwa [hNE'] at this) hxcE
  have hμ₃1 : μ₃ = -1 := by
    by_contra hne'
    exact (contact_inType_or_outType hF (hvC N) hinC.1).2
      ⟨hinC.2, outType_S_of_flankBelow hF (hvC N) (lt_of_le_of_ne hμ₃ (Ne.symm hne')) flC hinC.1.2.2⟩
  rw [sub_e_add_pi_add] at hinC
  -- `y` has two sectors at `M` (E5 § 3.4 at `N`, in the frame turned by `π`)
  have hαα : e α = e (α + π + π) := by
    rw [show α + π + π = α + 2 * π * ((1 : ℤ) : ℝ) by push_cast; ring, e_add_int_mul]
  have hy2 : ∀ᶠ r in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf M r xb).encard := by
    have := flank_two_sectors_at_S_of_flanks hF hP hstN hhN2 Qm (Qp.congr hαα) hμ₃ hμ₄ hμ₁ hμ₂ flD (flB.congr hαα) flC
      (flA.congr hαα) hxbh (fun hx => hxbE (by have := hx.1.2.2; rwa [hNE'] at this))
    rwa [sub_e_add_pi_add] at this
  -- `M` is stuck, and `y`'s two sectors there are horns `R±` along `±e α`
  have hstM : F.IsStuck M := isStuck_of_hasRepeatedColour hT (hdom M) ⟨xb, hy2⟩
  obtain ⟨hyM2, ν₁, ν₂, ν₃, ν₄, Rp, Rm, hν₁, -, -, hν₄, -, -⟩ :=
    horns_of_two_sectors_at hF (hvC M) hstM hy2 (α := α) (by rw [hMN]; exact mem_closure_of_mem_coneAt hαb)
  -- U1 at `M` for `h`: its cone there lies in the pinch about `+n`
  subst hμ₂1 hμ₃1
  obtain ⟨φh, hφh, -, hconeH1⟩ := coneAt_N_subset_of_horn hF Qp hμ₁
  obtain ⟨φh', hφh', -, hconeH2⟩ := coneAt_S_subset_of_horn hF Qm hμ₄
  rw [sub_e_add_pi_add] at hconeH2
  have hαh : α ∉ coneAt (F.region h) M := fun hα =>
    not_mem_angleIcc_of_gap (-1) (by push_cast; linarith) (by push_cast; linarith) (hconeH1 hα)
  have hαπh : α + π ∉ coneAt (F.region h) M := fun hα =>
    not_mem_angleIcc_of_gap (-1) (by push_cast; linarith) (by push_cast; linarith) (hconeH2 hα)
  -- the sector chart at `M`, `R±` in it, and the sectors just after `R₊` and just before `R₋` (the upper flanks `z₁`, `z₂`)
  obtain ⟨r₁, n', G', hC'⟩ := localSectors F (hdom M)
  have hMo' := hC'.sorted.mono
  have hr₁ : r₁ ∈ Ioc 0 r₁ := ⟨hC'.pos, le_rfl⟩
  obtain ⟨rq', ⟨⟨hSp', hSpc'⟩, ⟨hSm', hSmc'⟩⟩, hrq'⟩ := ((Rp.2.and Rm.2).and (Ioc_mem_nhdsGT hC'.pos)).exists
  obtain ⟨jp, hβjp, hnjp, hκjp, hnκjp, hsecjp⟩ := hC'.index_of_isSector_hornSet hrq' Rp.1 hSp'
  obtain ⟨jm, hβjm, hnjm, hκjm, hnκjm, hsecjm⟩ := hC'.index_of_isSector_hornSet hrq' Rm.1 hSm'
  have hn' : 0 < n' := jp.pos
  have colEq' : ∀ (i : Fin n') (j j' : Fin 6), (∀ r ∈ Ioc 0 r₁, G'.sector M r i ⊆ F.region j) →
      (∀ r ∈ Ioc 0 r₁, G'.sector M r i ⊆ F.region j') → j = j' := by
    intro i j j' hj hj'
    obtain ⟨z, hz⟩ := hC'.sector_nonempty hr₁ i
    exact ((hj r₁ hr₁ hz).2).symm.trans (hj' r₁ hr₁ hz).2
  have colQ' : ∀ i : Fin n', ∀ {ν₁ ν₂ β : ℝ}, (∀ r' ∈ Ioc 0 r₁, G'.sector M r' i = hornSet M β ν₁ ν₂ r') →
      hornSet M β ν₁ ν₂ rq' ⊆ F.col ⁻¹' {xb} → ∀ r ∈ Ioc 0 r₁, G'.sector M r i ⊆ F.region xb := by
    intro i ν₁ ν₂ β hsec hsub
    obtain ⟨h', hh'⟩ := hC'.exists_col i
    obtain ⟨z, hz⟩ := hC'.sector_nonempty hrq' i
    have hzh : F.col z = xb := by rw [hsec rq' hrq'] at hz; exact hsub hz
    have : h' = xb := ((hh' rq' hrq' (by rw [hsec rq' hrq'] at hz ⊢; exact hz)).2).symm.trans hzh
    exact this ▸ hh'
  have colp' := colQ' jp hsecjp hSpc'
  have colm' := colQ' jm hsecjm hSmc'
  obtain ⟨a₂, hβa₂, hκa₂⟩ := G'.exists_succ jp
  obtain ⟨c₂, hβc₂, hκc₂⟩ := G'.exists_pred jm
  rw [hnjp, hβjp] at hβa₂
  rw [hβjm] at hβc₂
  rw [hnκjp] at hκa₂
  rw [hκjm] at hκc₂
  have hjpm : jp ≠ jm := fun heq => hne (by rw [← hβjp, ← hβjm, heq])
  have ha₂p : a₂ ≠ jp := fun heq => by rw [heq, hκjp] at hκa₂; exact absurd hκa₂ (ne_of_lt Rp.1)
  have ha₂m : a₂ ≠ jm := fun heq => hne (by rw [← hβa₂, ← hβjm, heq])
  have hc₂m : c₂ ≠ jm := fun heq => by rw [heq, hnκjm] at hκc₂; exact absurd hκc₂.symm (ne_of_lt Rm.1)
  have hc₂p : c₂ ≠ jp := fun heq => hne (by rw [← hβc₂, ← hβjp, ← hnjp, heq])
  obtain ⟨z₁, hz₁⟩ := hC'.exists_col a₂
  obtain ⟨z₂, hz₂⟩ := hC'.exists_col c₂
  have hαz₁ : α ∈ coneAt (F.region z₁) M := by
    have : G'.β a₂ ∈ coneAt (G'.sector M r₁ a₂) M := by
      rw [hC'.cone r₁ hr₁ a₂]; exact Icc_subset_angleIcc _ _ ⟨le_rfl, hMo' a₂⟩
    exact mem_coneAt_of_e_eq hβa₂ (coneAt_mono (hz₁ r₁ hr₁) M this)
  have hαz₂ : α + π ∈ coneAt (F.region z₂) M := by
    have : G'.nextβ c₂ ∈ coneAt (G'.sector M r₁ c₂) M := by
      rw [hC'.cone r₁ hr₁ c₂]; exact Icc_subset_angleIcc _ _ ⟨hMo' c₂, le_rfl⟩
    exact mem_coneAt_of_e_eq hβc₂ (coneAt_mono (hz₂ r₁ hr₁) M this)
  -- neither is `y` (`y` has exactly the two sectors `R±` at `M`), nor `h` (U1)
  obtain ⟨r2', hr2e', hr2'⟩ := (hyM2.and (Ioc_mem_nhdsGT hC'.pos)).exists
  have three' : ∀ i : Fin n', i ≠ jp → i ≠ jm → (∀ r ∈ Ioc 0 r₁, G'.sector M r i ⊆ F.region xb) → False := by
    intro i hip him hi
    have hle := hC'.card_le_encard_sectorsOf hr2' {jp, jm, i} (by
      intro l hl
      rcases Finset.mem_insert.mp hl with rfl | hl
      · exact colp' r2' hr2'
      rcases Finset.mem_insert.mp hl with rfl | hl
      · exact colm' r2' hr2'
      rw [Finset.mem_singleton.mp hl]; exact hi r2' hr2')
    rw [hr2e', Finset.card_insert_of_notMem (by simp [hjpm, hip.symm]), Finset.card_pair (Ne.symm him)] at hle
    norm_num at hle
  have hz₁y : z₁ ≠ xb := by rintro rfl; exact three' a₂ ha₂p ha₂m hz₁
  have hz₂y : z₂ ≠ xb := by rintro rfl; exact three' c₂ hc₂p hc₂m hz₂
  have hz₁h : z₁ ≠ h := by rintro rfl; exact hαh hαz₁
  have hz₂h : z₂ ≠ h := by rintro rfl; exact hαπh hαz₂
  -- their tiles at `M` lie outside `B̄(N, 1)`: not `x₁`, `x₂` (in-type at `M`), nor `c` (an out-type `c`-contact at `M` would bar `c`'s
  -- directions above `±e α` at `N`)
  have hnz₁ : ¬ F.InType N z₁ M := by
    have := not_inType_S_of_flankAbove (hC'.isFlankAbove_of_col hβa₂ hκa₂ hz₁) (hν₁.trans Rp.1.le)
    rwa [hMN] at this
  have hnz₂ : ¬ F.InType N z₂ M := by
    have := not_inType_N_of_flankBelow (hC'.isFlankBelow_of_col hβc₂ hκc₂ hz₂) (Rm.1.le.trans hν₄)
    rwa [hMN'] at this
  have hz₁a : z₁ ≠ xa := by rintro rfl; exact hnz₁ hinA.2
  have hz₂a : z₂ ≠ xa := by rintro rfl; exact hnz₂ hinA.2
  have hz₁c' : z₁ ≠ xc := by rintro rfl; exact hnz₁ hinC.2
  have hz₂c' : z₂ ≠ xc := by rintro rfl; exact hnz₂ hinC.2
  have hcM : ∀ z : Fin 6, z = c → ¬ F.InType N z M → M ∈ closure (F.region z) → False := by
    intro z hz hnin hMcl
    rw [hz] at hnin hMcl
    have hcont : F.IsContact N c M := ⟨hcN.1.2.2, by rw [hMdef, dist_eq_norm, add_sub_cancel_left, norm_e], hMcl⟩
    have hout : F.OutType N c M := ((contact_inType_or_outType hF (hvC N) hcont).1).resolve_left hnin
    obtain ⟨ic, -, hβic⟩ := hC.exists_index_of_mem_coloursAt hn hcN.1.2.2
    have hA := (coneAt_subset_allowedCone hF (hvC N) hβic M hcont).2 hout
    rw [hMdef, add_sub_cancel_left, dot_e_e] at hA
    have hx2 : G.β ic ∈ angleIcc α (α + π - φc') := by
      obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp (hconeC2 hβic)
      exact mem_iUnion.mpr ⟨m + 1, by push_cast; linarith, by push_cast; linarith⟩
    have hIoo := mem_angleIoo_half (β := α) (β' := α + π) rfl rfl (by linarith) (by linarith) hφc hφc' (hconeC1 hβic) hx2
    exact absurd hA (not_le.mpr (cos_pos_of_mem_angleIoo hIoo))
  have hz₁c : z₁ ≠ c := fun he => hcM z₁ he hnz₁ (mem_closure_of_mem_coneAt hαz₁)
  have hz₂c : z₂ ≠ c := fun he => hcM z₂ he hnz₂ (mem_closure_of_mem_coneAt hαz₂)
  -- so both are `g`, the sixth colour
  have sixth : ∀ z : Fin 6, z ≠ c → z ≠ h → z ≠ xa → z ≠ xb → z ≠ xc → z = g := by
    intro z hzc hzh hza hzb hzc'
    by_contra hzg
    have hnd : [c, h, xa, xb, xc, g, z].Nodup := by
      simp only [List.nodup_cons, List.mem_cons, List.not_mem_nil, or_false, not_or, List.nodup_nil, and_true]
      exact ⟨⟨hhc.symm, hxac.symm, hxbc.symm, hxcc.symm, hgc.symm, Ne.symm hzc⟩,
        ⟨hxah.symm, hxbh.symm, hxch.symm, hgh.symm, Ne.symm hzh⟩, ⟨hxab, hxac', hxag, Ne.symm hza⟩,
        ⟨hxbc', hxbg, Ne.symm hzb⟩, ⟨hxcg, Ne.symm hzc'⟩, Ne.symm hzg, not_false⟩
    have := hnd.length_le_card
    simp at this
  have hz₁g := sixth z₁ hz₁c hz₁h hz₁a hz₁y hz₁c'
  have hz₂g := sixth z₂ hz₂c hz₂h hz₂a hz₂y hz₂c'
  -- the two `g`-sectors at `M` are distinct (an `h`-sector lies between them, in the pinch), and `g` is absent at `N = M − n`: MERGE at `M`
  have hhMcl : h ∈ F.coloursAt M := hhM.1.2.2
  have hac₂ : a₂ ≠ c₂ := by
    intro heq
    subst heq
    obtain ⟨ih, hih, hβih⟩ := hC'.exists_index_of_mem_coloursAt hn' hhMcl
    have hiha : a₂ ≠ ih := by
      rintro rfl; exact hz₁h (colEq' a₂ z₁ h hz₁ hih)
    have hx2 : G'.β ih ∈ angleIcc α (α + π - φh') := by
      obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp (hconeH2 hβih)
      exact mem_iUnion.mpr ⟨m + 1, by push_cast; linarith, by push_cast; linarith⟩
    have := mem_angleIoo_half hβa₂ hβc₂ (hMo' a₂) (hMo'.nextβ_le_add a₂) hφh hφh' (hconeH1 hβih) hx2
    exact Set.disjoint_left.mp (hMo'.disjoint hiha) (Icc_subset_angleIcc _ _ ⟨le_rfl, hMo' ih⟩) this
  rw [hz₁g] at hz₁ hαz₁
  rw [hz₂g] at hz₂
  exact hstM.1 (mergeAvailable_of_two_sectors hF (hvC M) hC' hac₂ hz₁ hz₂ hαz₁ (Or.inr (by rw [hMN]; exact hgN)))

/-- **FS112-Y3-END-NEEDS, corrected** (`plans/FS112-YB3-verification.md` § 3.1, YB3-NEEDS; the form FS114-CVB's `¬G_N` branch reads,
`plans/FS114-CVB-verification.md` § 1.6): in a terminal valid six-coloured map of the plane, a stuck vertex `E` with three colours whose
horns' `N`-side arcs both lie on `ω(N)` (`κ₂ = 1`, `κ₃ = −1`), with no in-type upper-flank contact at `N` and no in-type lower-flank
contact at `S` (so `λ_E > −1` on the in-type side: YB3's correction, the bowtie excluded), is impossible — its levels need a seventh
colour. Inventory item 69's supporting lemma (not a backlog row). A step inside a proof by contradiction: no model expected. -/
theorem y3_end_needs {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {E : ℂ} (hst : F.IsStuck E)
    (h3 : (F.coloursAt E).ncard = 3) {c : Fin 6} (hc2 : F.HasSectors E c 2) {α κ₁ κ₄ : ℝ}
    (hH : F.IsHorn E α κ₁ 1 c) (hH' : F.IsHorn E (α + π) (-1) κ₄ c) {g h : Fin 6} (hg : F.IsFlankAbove E α 1 g)
    (hh : F.IsFlankBelow E α κ₁ h)
    (hnoG : ¬ (F.IsContact E g (E + e (α + π / 2)) ∧ F.InType E g (E + e (α + π / 2))))
    (hnoH : ¬ (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2)))) : False := by
  -- `g ∈ P_cl(N)`: seven colours at `N` (`seven_colours_at_N`); else YB3's levels (`y3_end_needs_of_not_mem`). Neither reads `¬G_N`:
  -- the first needs only `g ∈ P_cl(N)`, and in the second `g ∉ P_cl(N)` leaves no `g`-contact at `N` at all.
  have _ := hnoG
  by_cases hgN : g ∈ F.coloursAt (E + e (α + π / 2))
  · exact seven_colours_at_N hF hP hT hst h3 hc2 hH hH' hg hh hgN hnoH
  · exact y3_end_needs_of_not_mem hF hP hT hst h3 hc2 hH hH' hg hh hnoH hgN

/-- **FS114-CV-HD's main clause, branch `G_N`** (`plans/FS114-CVB-verification.md` § 1.6, "Branch `G_N`", YB3-N5's content with its MERGE made
explicit): in a terminal valid six-coloured map, at a stuck vertex `E` with three colours whose horns' `N`-side arcs both lie on `ω(N)`
(`κ₂ = 1`, `κ₃ = −1`), an in-type upper-flank contact at `N` with no in-type lower-flank contact at `S` is impossible — at `N` there
are seven distinct colours. Proved by `seven_colours_at_N` (FS131-I5n), which reads only `g ∈ P_cl(N)` from `G_N`. A child of `cv_hd_main` (FS131-I5l), a step inside a
proof by contradiction: no model expected. -/
theorem cv_hd_main_inType {F : ArcMap 6} (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard = 3)
    {c : Fin 6} (hc2 : F.HasSectors E c 2) {α κ₁ κ₄ : ℝ} (hH : F.IsHorn E α κ₁ 1 c)
    (hH' : F.IsHorn E (α + π) (-1) κ₄ c) {g h : Fin 6} (hg : F.IsFlankAbove E α 1 g) (hh : F.IsFlankBelow E α κ₁ h)
    (hGN : F.IsContact E g (E + e (α + π / 2)) ∧ F.InType E g (E + e (α + π / 2)))
    (hnoHS : ¬ (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2)))) : False := by
  obtain ⟨hF, hP, hT, -⟩ := id hM
  exact seven_colours_at_N hF hP hT hst h3 hc2 hH hH' hg hh hGN.1.2.2 hnoHS

/-- **FS114-CV-HD, the main clause**: in a terminal valid six-coloured map, at a stuck vertex `E` with three colours whose two-sector
colour `c` has horns along `±e α`, both upper bounds `1` (the `+e α` horn's upper arc and the `−e α` horn's arc on the `N` side on
`ω(N)`: `κ₂ = 1`, `κ₃ = −1`) and no in-type lower-flank tile at `E − n` is impossible. A step inside a proof by contradiction where no
model is expected (`cv_hd`'s cycle consumes it). -/
theorem cv_hd_main {F : ArcMap 6} (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard = 3)
    {c : Fin 6} (hc2 : F.HasSectors E c 2) {α κ₁ κ₂ κ₃ κ₄ : ℝ} (hH : F.IsHorn E α κ₁ κ₂ c)
    (hH' : F.IsHorn E (α + π) κ₃ κ₄ c) {h : Fin 6} (hh : F.IsFlankBelow E α κ₁ h)
    (hυ : κ₂ = 1 ∧ κ₃ = -1)
    (hnoHS : ¬ (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2)))) : False := by
  -- CVB § 1.6's two branches on `G_N`: seven colours at `N` (`cv_hd_main_inType`), or Y3-END-NEEDS as corrected (`y3_end_needs`)
  obtain ⟨hF, hP, hT, -⟩ := id hM
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  obtain ⟨h1, h2⟩ := horn_bounds_of_noMerge hF (hvC E) hst.1 le_rfl hc2 hH
  obtain ⟨h3', h4⟩ := horn_bounds_of_noMerge hF (hvC E) hst.1 le_rfl hc2 hH'
  obtain ⟨hN, hS⟩ := horn_poles_contact hF (hvC E) hst.1 le_rfl hc2 hH
  obtain ⟨g, h₀, -, -, -, -, -, hg, hh₀, -, -, -⟩ := stuck_flanks_ua hF (hvC E) hst h3.le hH hH' h1 h2 h3' h4 hc2 hN hS
  have hhh : h₀ = h := IsFlankBelow.unique hh₀ hh
  subst hhh
  obtain ⟨rfl, rfl⟩ := hυ
  by_cases hGN : F.IsContact E g (E + e (α + π / 2)) ∧ F.InType E g (E + e (α + π / 2))
  · exact cv_hd_main_inType hM hst h3 hc2 hH hH' hg hh hGN hnoHS
  · exact y3_end_needs hF hP hT hst h3 hc2 hH hH' hg hh hGN hnoHS

/-- **FS114-CV-HD, the equivalences**: in a terminal valid six-coloured map, at a stuck vertex `E` with three colours (horns of `c` along
`±e α`, upper flank `g`, lower flank `h`), the four conditions are equivalent — `G_N` (an in-type `g`-contact at `N`), `H_S` (an in-type
`h`-contact at `S`), `υ± = 1` (`κ₂ = 1 ∧ κ₃ = −1`: both horns' `N`-side arcs on `ω(N)`) and `λ± = −1` (`κ₁ = −1 ∧ κ₄ = 1`: both `S`-side
arcs on `ω(S)`). Model of the local hypotheses with all four conditions: `bowtie` at `0` (a fragment; `GENERIC` on terminal plane maps). -/
theorem cv_hd {F : ArcMap 6} (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard = 3)
    {c : Fin 6} (hc2 : F.HasSectors E c 2) {α κ₁ κ₂ κ₃ κ₄ : ℝ} (hH : F.IsHorn E α κ₁ κ₂ c)
    (hH' : F.IsHorn E (α + π) κ₃ κ₄ c) {g h : Fin 6} (hg : F.IsFlankAbove E α κ₂ g) (hh : F.IsFlankBelow E α κ₁ h) :
    ((F.IsContact E g (E + e (α + π / 2)) ∧ F.InType E g (E + e (α + π / 2))) ↔
        (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2)))) ∧
      ((F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2))) ↔ (κ₂ = 1 ∧ κ₃ = -1)) ∧
      ((κ₂ = 1 ∧ κ₃ = -1) ↔ (κ₁ = -1 ∧ κ₄ = 1)) := by
  -- the cycle `G_N → υ± → H_S → λ± → G_N` (CVB § 1.6, "Hence"): two Siamese arrows and the main clause, each in both frames
  obtain ⟨hF, hP, -, -⟩ := id hM
  obtain ⟨hH2, hhd, hgd, hNS, hSN⟩ := stuck_turned_frame hF hP hst h3.le hc2 hH hH' hg hh
  have A : (F.IsContact E g (E + e (α + π / 2)) ∧ F.InType E g (E + e (α + π / 2))) → κ₂ = 1 ∧ κ₃ = -1 :=
    upper_bounds_of_inType_N hF hP hst h3.le hc2 hH hH' hg
  have B : κ₂ = 1 ∧ κ₃ = -1 → (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2))) := fun hυ => by
    by_contra hno
    exact cv_hd_main hM hst h3 hc2 hH hH' hh hυ hno
  have C : (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2))) → κ₁ = -1 ∧ κ₄ = 1 := fun hx => by
    have := upper_bounds_of_inType_N hF hP hst h3.le hc2 hH' hH2 hhd (by rw [hNS]; exact hx)
    exact ⟨this.2, this.1⟩
  have D : κ₁ = -1 ∧ κ₄ = 1 → (F.IsContact E g (E + e (α + π / 2)) ∧ F.InType E g (E + e (α + π / 2))) := fun hl => by
    by_contra hno
    exact cv_hd_main hM hst h3 hc2 hH' hH2 hgd ⟨hl.2, hl.1⟩ (by rw [hSN]; exact hno)
  exact ⟨⟨fun x => B (A x), fun x => D (C x)⟩, ⟨fun x => A (D (C x)), B⟩, ⟨fun x => C (B x), fun x => A (D x)⟩⟩

/-- **FS112-C-DOUBLE** (caution C116: a regrade only): in a terminal valid six-coloured map (`IsTerminalMap` — the reading of "terminal
valid map" settled here, § 2.2 of the plan: wave 4's `Terminal` and N2-TERM's clause 1), a stuck vertex `E` with three colours all
four of whose horn arcs are unit arcs (the `+e α` horn between `ω(S)` and `ω(N)`, curvatures `−1` and `1`, and the `−e α` horn likewise
in its own frame) carries an in-type tile of its upper flank colour `g` at `N` and of its lower flank colour `h` at `S`, and both `N`
and `S` carry at least four colours and centre (Q) arcs — the four horn-bounding arcs. Model of the local hypotheses: `bowtie` at `0`
(a fragment; on terminal plane maps `GENERIC`, FS-115). -/
theorem c_double {F : ArcMap 6} (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard = 3)
    {c : Fin 6} (hc2 : F.HasSectors E c 2) {α : ℝ} (hH : F.IsHorn E α (-1) 1 c) (hH' : F.IsHorn E (α + π) (-1) 1 c)
    {g h : Fin 6} (hg : F.IsFlankAbove E α 1 g) (hh : F.IsFlankBelow E α (-1) h) :
    (F.IsContact E g (E + e (α + π / 2)) ∧ F.InType E g (E + e (α + π / 2))) ∧
      (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2))) ∧
      4 ≤ (F.coloursAt (E + e (α + π / 2))).ncard ∧ 4 ≤ (F.coloursAt (E - e (α + π / 2))).ncard ∧
      (∃ θ₂, α - π / 2 < θ₂ ∧ F.IsQArc (E + e (α + π / 2)) (α - π / 2) θ₂) ∧
      (∃ θ₁, θ₁ < α - π / 2 ∧ F.IsQArc (E + e (α + π / 2)) θ₁ (α - π / 2)) ∧
      (∃ θ₁, θ₁ < α + π / 2 ∧ F.IsQArc (E - e (α + π / 2)) θ₁ (α + π / 2)) ∧
      (∃ θ₂, α + π / 2 < θ₂ ∧ F.IsQArc (E - e (α + π / 2)) (α + π / 2) θ₂) := by
  -- CV-HD's cycle gives `H_S` and `G_N`; each horn-bounding arc is FLANK-Q's ring arc, both-kind at its centre (the in-type flank colour and
  -- the out-type `c`), so not (R2): (Q) by `QROnly`, with at least four colours (FS114-CVB § 1.6, "Hence")
  obtain ⟨hF, hP, -, hQR⟩ := id hM
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  obtain ⟨-, hhd, hgd, hNS, hSN⟩ := stuck_turned_frame hF hP hst h3.le hc2 hH hH' hg hh
  obtain ⟨hGH, hHυ, -⟩ := cv_hd hM hst h3 hc2 hH hH' hg hh
  have hHS := hHυ.mpr ⟨rfl, rfl⟩
  have hGN := hGH.mpr hHS
  obtain ⟨hcN, hcS⟩ := horn_poles_contact hF (hvC E) hst.1 le_rfl hc2 hH
  -- `N`: the `+e α` horn's upper arc
  obtain ⟨θ₂, hθ₂, -, hQN₁⟩ := flankQ_upper_of_qrOnly hF hQR (hvC E) hH hg hcN
  have hQN₁' : F.IsQArc (E + e (α + π / 2)) (α - π / 2) θ₂ := by
    rcases hQN₁ with ⟨hQ, -⟩ | ⟨-, hgN, -⟩
    · exact hQ
    · exact absurd hGN.1.2.2 hgN
  -- `N`: the `−e α` horn's arc on the `N` side (its lower arc in its own frame)
  obtain ⟨θ₁, hθ₁, -, hQN₂⟩ := flankQ_lower_of_qrOnly hF hQR (hvC E) hH' hgd (by rw [hSN]; exact hcN)
  rw [hSN] at hQN₂
  have hQN₂' : F.IsQArc (E + e (α + π / 2)) θ₁ (α + π + π / 2) := by
    rcases hQN₂ with ⟨hQ, -⟩ | ⟨-, hgN, -⟩
    · exact hQ
    · exact absurd hGN.1.2.2 hgN
  -- `S`: the `+e α` horn's lower arc
  obtain ⟨θ₃, hθ₃, -, hQS₁⟩ := flankQ_lower_of_qrOnly hF hQR (hvC E) hH hh hcS
  have hQS₁' : F.IsQArc (E - e (α + π / 2)) θ₃ (α + π / 2) := by
    rcases hQS₁ with ⟨hQ, -⟩ | ⟨-, hhS, -⟩
    · exact hQ
    · exact absurd hHS.1.2.2 hhS
  -- `S`: the `−e α` horn's arc on the `S` side (its upper arc in its own frame)
  obtain ⟨θ₄, hθ₄, -, hQS₂⟩ := flankQ_upper_of_qrOnly hF hQR (hvC E) hH' hhd (by rw [hNS]; exact hcS)
  rw [hNS, show α + π - π / 2 = α + π / 2 by ring] at hQS₂
  rw [show α + π - π / 2 = α + π / 2 by ring] at hθ₄
  have hQS₂' : F.IsQArc (E - e (α + π / 2)) (α + π / 2) θ₄ := by
    rcases hQS₂ with ⟨hQ, -⟩ | ⟨-, hhS, -⟩
    · exact hQ
    · exact absurd hHS.1.2.2 hhS
  have hN2 := hQN₂'.add_int_mul (-1)
  rw [show α + π + π / 2 + 2 * π * ((-1 : ℤ) : ℝ) = α - π / 2 by push_cast; ring] at hN2
  have hN4 : 4 ≤ (F.coloursAt (E + e (α + π / 2))).ncard := by
    obtain ⟨-, -, -, -, -, h4⟩ := hQN₁'; exact h4
  have hS4 : 4 ≤ (F.coloursAt (E - e (α + π / 2))).ncard := by
    obtain ⟨-, -, -, -, -, h4⟩ := hQS₁'; exact h4
  exact ⟨hGN, hHS, hN4, hS4, ⟨θ₂, hθ₂, hQN₁'⟩,
    ⟨θ₁ + 2 * π * ((-1 : ℤ) : ℝ), by push_cast; linarith, hN2⟩, ⟨θ₃, hθ₃, hQS₁'⟩, ⟨θ₄, hθ₄, hQS₂'⟩⟩

/-! ## FS114-CV-HD, (CV-CLASS) (placed after its children) -/

/-- **FS114-CV-HD, (CV-CLASS)**: a stuck vertex of a terminal valid six-coloured map (three colours, horns of `c` along `±e α`, upper
flank `g`, lower flank `h`) is a bowtie — all four horn arcs unit arcs, both neighbours carrying at least four colours and centring
both-kind arcs, a one-vertex chain — or carries `g` twice at `E − n` and `h` twice at `E + n`, each neighbour stuck or with at least four
colours. Model of the local hypotheses (the bowtie case): `bowtie` at `0`. Route (FS131-I5k, E5 § 3.5): CV-HD's equivalences (`cv_hd`) split
the cases; with all four conditions, C-DOUBLE's (Q) arcs give both-kind arcs and four colours at `N` and `S` (`c_double`) and the chain clause
is `n3_end_chain`; with none, `g` has two sectors at `S` and `h` two at `N` (`flank_two_sectors_at_S_gen`, at `S` and in the frame turned by
`π`), so both neighbours are stuck (`isStuck_of_hasRepeatedColour`). Placed after its children. -/
theorem cv_class {F : ArcMap 6} (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard = 3)
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
  obtain ⟨hF, hP, hT, -⟩ := id hM
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  have hdom : ∀ x, x ∈ F.dom := fun x => by rw [hP]; exact mem_univ x
  obtain ⟨h1, h2⟩ := horn_bounds_of_noMerge hF (hvC E) hst.1 le_rfl hc2 hH
  obtain ⟨h3', h4⟩ := horn_bounds_of_noMerge hF (hvC E) hst.1 le_rfl hc2 hH'
  obtain ⟨hGH, hHυ, hυl⟩ := cv_hd hM hst h3 hc2 hH hH' hg hh
  by_cases hGN : F.IsContact E g (E + e (α + π / 2)) ∧ F.InType E g (E + e (α + π / 2))
  · -- the bowtie: CV-HD's four conditions, C-DOUBLE's (Q) arcs, the chain clause
    left
    have hHS := hGH.mp hGN
    obtain ⟨hk2, hk3⟩ := hHυ.mp hHS
    obtain ⟨hk1, hk4⟩ := hυl.mp ⟨hk2, hk3⟩
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
    exact ⟨hgS, hhN, Or.inl (isStuck_of_hasRepeatedColour hT (hdom _) ⟨h, hhN⟩),
      Or.inl (isStuck_of_hasRepeatedColour hT (hdom _) ⟨g, hgS⟩)⟩

/-! ## FS112-C-ENDS (placed after `cv_class`, which it reads) -/

/-- `StuckAlong` reads its axis only through `e α`. -/
theorem StuckAlong.congr {v : ℂ} {α α' : ℝ} (he : e α = e α') (h : F.StuckAlong v α) : F.StuckAlong v α' := by
  obtain ⟨hst, c, m, κ₁, κ₂, hm, hc, hH⟩ := h
  exact ⟨hst, c, m, κ₁, κ₂, hm, hc, hH.congr he⟩

/-- **The stuck structure along a given horn's axis**: at a stuck vertex with at most three colours, a horn of a colour with two or more
sectors along `e α` is one of the two horns of `stuck_structure_ua`, so its structure (the opposite horn, two sectors, three colours, the
flanks) holds along `e α` itself (`e_eq_or_of_two_horns`; along the opposite axis the flanks swap). Inhabitant of the hypotheses: `bowtie`
at `0`. -/
theorem stuck_structure_at_axis (hF : F.Valid) {w : ℂ} (hv : F.Covers w 1) (hst : F.IsStuck w)
    (h3 : (F.coloursAt w).ncard ≤ 3) {c : Fin k} {m : ℕ} (hm : 2 ≤ m) (hc : F.HasSectors w c m) {α κ₁ κ₂ : ℝ}
    (hH : F.IsHorn w α κ₁ κ₂ c) :
    ∃ κ₁' κ₂' κ₃ κ₄ : ℝ, ∃ g h : Fin k, F.IsHorn w α κ₁' κ₂' c ∧ F.IsHorn w (α + π) κ₃ κ₄ c ∧ F.HasSectors w c 2 ∧
      (F.coloursAt w).ncard = 3 ∧ F.IsFlankAbove w α κ₂' g ∧ F.IsFlankBelow w α κ₁' h := by
  obtain ⟨β, κ₁', κ₂', κ₃, κ₄, g, h, Hu, Hd, -, -, -, -, hc2, -, hcol, hgh, hgc, hhc, fa, fb, fa', fb', -⟩ :=
    stuck_structure_ua hF hv hst h3 hm hc
  have h3' : (F.coloursAt w).ncard = 3 := by
    rw [hcol, Set.ncard_insert_of_notMem (by simp [hgc.symm, hhc.symm]), Set.ncard_pair hgh]
  rcases e_eq_or_of_two_horns hc2 Hu Hd hH with he | he
  · have he' : e (β + π) = e (α + π) := by rw [e_add_pi', e_add_pi', he]
    exact ⟨κ₁', κ₂', κ₃, κ₄, g, h, Hu.congr he.symm, Hd.congr he', hc2, h3', fa.congr he.symm, fb.congr he.symm⟩
  · have he' : e β = e (α + π) := by rw [e_add_pi', he, e_add_pi', neg_neg]
    exact ⟨κ₃, κ₄, κ₁', κ₂', h, g, Hd.congr he.symm, Hu.congr he', hc2, h3', fa'.congr he.symm, fb'.congr he.symm⟩

/-- **The axis propagates to a chain neighbour** (the plan's `stuckAlong_of_run`, § 9.1: "the cone colour alternates, the axis does not"):
if `v` is stuck along `±e α` and its neighbour `w = v ± n` is a chain vertex, then `w` is stuck along `±e α`. A colour of `v` (its
two-sector colour, whose out-type contacts sit at `v ± n`) is carried at `w`, and at the chain vertex `w` every colour approaches along both
directions of `w`'s axis `β`; `v` is a contact of that colour on `ω(w)`, of one type, whose half-plane holds `e β` and `−e β`, so
`e β ⊥ v − w`. No `≤ 3` colours at `v` and no terminality are read. Inhabitant of the hypotheses: none known on a plane map (a two-vertex
stuck chain, FS-115); `GENERIC`. -/
theorem stuckAlong_of_run (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {α : ℝ}
    (hv : F.StuckAlong v α ∨ F.StuckAlong v (α + π)) {w : ℂ}
    (hw : w = v + e (α + π / 2) ∨ w = v - e (α + π / 2)) (hwc : F.IsChainVertex w) :
    F.StuckAlong w α ∨ F.StuckAlong w (α + π) := by
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  -- a colour of `v` carried at `w`: the two-sector colour, whose out-type contacts sit at `v ± n`
  have hcol : ∃ c, c ∈ F.coloursAt v ∧ c ∈ F.coloursAt w := by
    have key : ∀ α' : ℝ, F.StuckAlong v α' → (e (α' + π / 2) = e (α + π / 2) ∨ e (α' + π / 2) = -e (α + π / 2)) →
        ∃ c, c ∈ F.coloursAt v ∧ c ∈ F.coloursAt w := by
      intro α' ⟨hst, c, m, κ₁, κ₂, hm, hc, hH⟩ he
      obtain ⟨hN, hS⟩ := horn_poles_contact hF (hvC v) hst.1 hm hc hH
      refine ⟨c, hN.1.1, ?_⟩
      rcases he with he | he <;> rcases hw with rfl | rfl
      · rw [← he]; exact hN.1.2.2
      · rw [← he]; exact hS.1.2.2
      · rw [← neg_neg (e (α + π / 2)), ← he, ← sub_eq_add_neg]; exact hS.1.2.2
      · rw [sub_eq_add_neg, ← he]; exact hN.1.2.2
    rcases hv with h | h
    · exact key α h (Or.inl rfl)
    · exact key (α + π) h (Or.inr (by rw [show α + π + π / 2 = (α + π / 2) + π by ring, e_add_pi']))
  obtain ⟨c, hcv, hcw⟩ := hcol
  have hvw : dist v w = 1 := by
    rcases hw with rfl | rfl
    · rw [dist_eq_norm, show v - (v + e (α + π / 2)) = -e (α + π / 2) by ring, norm_neg, norm_e]
    · rw [dist_eq_norm, show v - (v - e (α + π / 2)) = e (α + π / 2) by ring, norm_e]
  -- the chain vertex `w`: its axis `β`, along which every colour (`c` among them) approaches both ways
  obtain ⟨hstw, h3w⟩ := hwc
  obtain ⟨c', m', hm', hc'⟩ := hstw.2.2.2
  obtain ⟨β, κ₁, κ₂, κ₃, κ₄, g, h, Hu, Hd, -, -, -, -, hc2, -, hcolw, -, -, -, fa, fb, fa', fb', -⟩ :=
    stuck_structure_ua hF (hvC w) hstw h3w hm' hc'
  have hcone : β ∈ coneAt (F.region c) w ∧ β + π ∈ coneAt (F.region c) w := by
    rw [hcolw] at hcw
    simp only [mem_insert_iff, mem_singleton_iff] at hcw
    rcases hcw with rfl | rfl | rfl
    · exact ⟨Hu.mem_coneAt_region, Hd.mem_coneAt_region⟩
    · exact ⟨fa.mem_coneAt, fb'.mem_coneAt⟩
    · exact ⟨fb.mem_coneAt, fa'.mem_coneAt⟩
  -- `v` is a contact of `c` on `ω(w)`, of one type: both `e β` and `−e β` lie in its half-plane, so `e β ⊥ v − w`
  have hcont : F.IsContact w c v := ⟨hcw, hvw, hcv⟩
  have hA1 := coneAt_subset_allowedCone hF (hvC w) hcone.1 v hcont
  have hA2 := coneAt_subset_allowedCone hF (hvC w) hcone.2 v hcont
  have hdot : dot (e β) (v - w) = 0 := by
    rw [e_add_pi', dot_neg_left] at hA2
    rcases (contact_inType_or_outType hF (hvC w) hcont).1 with hi | ho
    · have := hA1.1 hi; have := hA2.1 hi; linarith
    · have := hA1.2 ho; have := hA2.2 ho; linarith
  have hsin : Real.sin (β - α) = 0 := by
    have hcos : Real.cos (β - (α + π / 2)) = 0 := by
      rcases hw with rfl | rfl
      · rw [show v - (v + e (α + π / 2)) = -e (α + π / 2) by ring, dot_neg_right, dot_e_e] at hdot; linarith
      · rw [show v - (v - e (α + π / 2)) = e (α + π / 2) by ring, dot_e_e] at hdot; exact hdot
    rwa [show β - (α + π / 2) = (β - α) - π / 2 by ring, Real.cos_sub_pi_div_two] at hcos
  rcases e_eq_or_of_sin_sub_eq_zero hsin with he | he
  · exact Or.inl ⟨hstw, c', 2, κ₁, κ₂, le_rfl, hc2, Hu.congr he⟩
  · exact Or.inr ⟨hstw, c', 2, κ₁, κ₂, le_rfl, hc2, Hu.congr he⟩

/-- **Every vertex of the stuck run is stuck along `±e α`** (`stuckAlong_of_run` by induction on `|j|`). -/
theorem stuckAlong_of_mem_stuckRun (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {α : ℝ} (hv : F.StuckAlong v α) {j : ℤ}
    (hj : j ∈ F.stuckRun v α) :
    F.StuckAlong (v + (j : ℂ) * e (α + π / 2)) α ∨ F.StuckAlong (v + (j : ℂ) * e (α + π / 2)) (α + π) := by
  suffices H : ∀ m : ℕ, ∀ i : ℤ, i.natAbs = m → i ∈ F.stuckRun v α →
      F.StuckAlong (v + (i : ℂ) * e (α + π / 2)) α ∨ F.StuckAlong (v + (i : ℂ) * e (α + π / 2)) (α + π) from
    H _ j rfl hj
  intro m
  induction m with
  | zero =>
    intro i hi _
    rw [Int.natAbs_eq_zero.mp hi]
    left; simpa using hv
  | succ m ih =>
    intro i hi hir
    have hi0 : i ≠ 0 := by rintro rfl; simp at hi
    rcases lt_or_gt_of_ne hi0 with hneg | hpos
    · -- `i < 0`: from `i + 1`
      have hir' : i + 1 ∈ F.stuckRun v α := mem_stuckRun_of_between hir (by omega) (by omega)
      have hP' := ih (i + 1) (by omega) hir'
      refine stuckAlong_of_run hF hP hP' (Or.inr ?_) (isChainVertex_of_mem_stuckRun hir)
      push_cast; ring
    · have hir' : i - 1 ∈ F.stuckRun v α := mem_stuckRun_of_between hir (by omega) (by omega)
      have hP' := ih (i - 1) (by omega) hir'
      refine stuckAlong_of_run hF hP hP' (Or.inl ?_) (isChainVertex_of_mem_stuckRun hir)
      push_cast; ring

/-- **Each neighbour of a chain vertex along its axis carries four colours or is stuck** (CV-CLASS, `cv_class`, in both of its cases). -/
theorem four_or_stuck_of_chainVertex {F : ArcMap 6} (hM : F.IsTerminalMap) {w : ℂ} {α : ℝ} (hw : F.StuckAlong w α)
    (h3 : (F.coloursAt w).ncard ≤ 3) :
    (4 ≤ (F.coloursAt (w + e (α + π / 2))).ncard ∨ F.IsStuck (w + e (α + π / 2))) ∧
      (4 ≤ (F.coloursAt (w - e (α + π / 2))).ncard ∨ F.IsStuck (w - e (α + π / 2))) := by
  obtain ⟨hF, hP, -, -⟩ := id hM
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  obtain ⟨hst, c, m, κ₁, κ₂, hm, hc, hH⟩ := hw
  obtain ⟨κ₁', κ₂', κ₃, κ₄, g, h, Hu, Hd, hc2, h3', hg, hh⟩ := stuck_structure_at_axis hF (hvC w) hst h3 hm hc hH
  rcases cv_class hM hst h3' hc2 Hu Hd hg hh with ⟨-, -, -, -, hN, hS, -⟩ | ⟨-, -, hN, hS⟩
  · exact ⟨Or.inl hN, Or.inl hS⟩
  · exact ⟨hN.symm, hS.symm⟩

/-- **FS112-C-ENDS** in its erratum's form (caution C116; `plans/FS112-derivation.md:443` item 2) — FS114-CV-HD's (CV-ENDS): in a
terminal valid six-coloured map, the point of the normal line one step beyond each finite end of a stuck chain has at least four colours.
The chain is the stuck run through a vertex stuck along `e α`; its upper end is a member `j` with `j + 1` outside, its lower end a member
with `j − 1` outside. No model of a stuck chain in a terminal valid plane map is known (`GENERIC`, FS-115). Route (FS114-CVB § 1.8, CV-ENDS): the end vertex is a
chain vertex whose axis is `±e α` (`stuckAlong_of_mem_stuckRun`, the plan's `stuckAlong_of_run` by induction along the run); CV-CLASS there
(`cv_class`) makes each neighbour along `±n` four-coloured or stuck (`four_or_stuck_of_chainVertex`), and the neighbour beyond the end is not a
chain vertex, so a stuck one carries at least four colours. Placed after `cv_class`. -/
theorem c_ends {F : ArcMap 6} (hM : F.IsTerminalMap) {v : ℂ} {α : ℝ} (hv : F.StuckAlong v α) {j : ℤ}
    (hj : j ∈ F.stuckRun v α) :
    (j + 1 ∉ F.stuckRun v α → 4 ≤ (F.coloursAt (v + ((j + 1 : ℤ) : ℂ) * e (α + π / 2))).ncard) ∧
      (j - 1 ∉ F.stuckRun v α → 4 ≤ (F.coloursAt (v + ((j - 1 : ℤ) : ℂ) * e (α + π / 2))).ncard) := by
  obtain ⟨hF, hP, -, -⟩ := id hM
  set w := v + (j : ℂ) * e (α + π / 2) with hwdef
  have hw3 : (F.coloursAt w).ncard ≤ 3 := (isChainVertex_of_mem_stuckRun hj).2
  -- a neighbour outside the run is not a chain vertex
  have hout : ∀ s : ℤ, (s = 1 ∨ s = -1) → j + s ∉ F.stuckRun v α →
      ¬ F.IsChainVertex (v + ((j + s : ℤ) : ℂ) * e (α + π / 2)) := by
    intro s hs hns hcv
    apply hns
    intro i hi1 hi2
    by_cases hij : i = j + s
    · rw [hij]; exact hcv
    · exact isChainVertex_of_mem_stuckRun
        (mem_stuckRun_of_between hj (by rcases hs with rfl | rfl <;> omega) (by rcases hs with rfl | rfl <;> omega))
  -- each neighbour of `w` along `±n` has four colours or is stuck
  have hnb : ∀ x, (x = w + e (α + π / 2) ∨ x = w - e (α + π / 2)) → 4 ≤ (F.coloursAt x).ncard ∨ F.IsStuck x := by
    intro x hx
    rcases stuckAlong_of_mem_stuckRun hF hP hv hj with h | h
    · have := four_or_stuck_of_chainVertex hM h hw3
      rcases hx with rfl | rfl
      · exact this.1
      · exact this.2
    · have := four_or_stuck_of_chainVertex hM h hw3
      rw [sub_e_add_pi_add, add_e_add_pi_add] at this
      rcases hx with rfl | rfl
      · exact this.2
      · exact this.1
  have hfin : ∀ s : ℤ, (s = 1 ∨ s = -1) → j + s ∉ F.stuckRun v α →
      4 ≤ (F.coloursAt (v + ((j + s : ℤ) : ℂ) * e (α + π / 2))).ncard := by
    intro s hs hns
    have hx : v + ((j + s : ℤ) : ℂ) * e (α + π / 2) = w + e (α + π / 2) ∨
        v + ((j + s : ℤ) : ℂ) * e (α + π / 2) = w - e (α + π / 2) := by
      rcases hs with rfl | rfl
      · left; rw [hwdef]; push_cast; ring
      · right; rw [hwdef]; push_cast; ring
    rcases hnb _ hx with h4 | hst
    · exact h4
    · by_contra hlt
      exact hout s hs hns ⟨hst, by omega⟩
  exact ⟨fun h => hfin 1 (Or.inl rfl) h, fun h => by
    have := hfin (-1) (Or.inr rfl) (by simpa [sub_eq_add_neg] using h)
    simpa [sub_eq_add_neg] using this⟩

/-- **With no four-colour vertex, a chain vertex's neighbours along its axis are chain vertices** (FS114-CVB § 1.4 items 4–6, CV-EXISTS's step,
with no use of CV-HD): in a terminal valid six-coloured map with at most three colours at every point, at a vertex stuck along `e α` neither
flank is in-type at its pole (its horn arc would be both-kind, so (Q) by `QROnly` — four colours at the pole — or (R2), whose inner colour is
not carried there), so E5 § 3.4 (`flank_two_sectors_at_S_gen`, as in `cv_class`'s "None" case) gives the upper flank two sectors at `S` and the
lower flank two at `N`: both neighbours carry a repeated colour, so are stuck (terminal), with at most three colours. A step of `cv_exists`'s
refutation: no model expected (`GENERIC`; no valid six-map of the plane is known). -/
theorem chainVertex_neighbours_of_noFour {F : ArcMap 6} (hM : F.IsTerminalMap) (h4 : ∀ x, (F.coloursAt x).ncard ≤ 3)
    {w : ℂ} {α : ℝ} (hw : F.StuckAlong w α) :
    F.IsChainVertex (w + e (α + π / 2)) ∧ F.IsChainVertex (w - e (α + π / 2)) := by
  obtain ⟨hF, hP, hT, hQR⟩ := id hM
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  have hdom : ∀ x, x ∈ F.dom := fun x => by rw [hP]; exact mem_univ x
  obtain ⟨hst, c₀, m, κ₀, κ₀', hm, hc₀, hH₀⟩ := hw
  obtain ⟨κ₁, κ₂, κ₃, κ₄, g, h, hH, hH', hc2, h3, hg, hh⟩ := stuck_structure_at_axis hF (hvC w) hst (h4 w) hm hc₀ hH₀
  obtain ⟨h1, h2⟩ := horn_bounds_of_noMerge hF (hvC w) hst.1 le_rfl hc2 hH
  obtain ⟨h3', h4'⟩ := horn_bounds_of_noMerge hF (hvC w) hst.1 le_rfl hc2 hH'
  obtain ⟨hH2, hhd, -, hNS, hSN⟩ := stuck_turned_frame hF hP hst h3.le hc2 hH hH' hg hh
  obtain ⟨hcN, hcS⟩ := horn_poles_contact hF (hvC w) hst.1 le_rfl hc2 hH
  -- no in-type flank contact at either pole: the horn arc it bounds would be both-kind, hence (Q), with four colours
  have hGN : ¬ (F.IsContact w g (w + e (α + π / 2)) ∧ F.InType w g (w + e (α + π / 2))) := by
    intro hx
    obtain ⟨hk2, -⟩ := upper_bounds_of_inType_N hF hP hst h3.le hc2 hH hH' hg hx
    subst hk2
    obtain ⟨θ₂, -, -, hQ | ⟨-, hgN, -⟩⟩ := flankQ_upper_of_qrOnly hF hQR (hvC w) hH hg hcN
    · obtain ⟨⟨-, -, -, -, -, h4N⟩, -⟩ := hQ
      have := h4 (w + e (α + π / 2)); omega
    · exact hgN hx.1.2.2
  have hHS : ¬ (F.IsContact w h (w + e (α + π + π / 2)) ∧ F.InType w h (w + e (α + π + π / 2))) := by
    intro hx
    obtain ⟨hk4, -⟩ := upper_bounds_of_inType_N hF hP hst h3.le hc2 hH' hH2 hhd hx
    subst hk4
    obtain ⟨θ₂, -, -, hQ | ⟨-, hhN, -⟩⟩ := flankQ_upper_of_qrOnly hF hQR (hvC w) hH' hhd (by rw [hNS]; exact hcS)
    · obtain ⟨⟨-, -, -, -, -, h4N⟩, -⟩ := hQ
      have := h4 (w + e (α + π + π / 2)); omega
    · exact hhN hx.1.2.2
  -- E5 § 3.4 at both poles (`cv_class`'s "None" case): a repeated colour at each, so each is stuck
  have hgS := flank_two_sectors_at_S_gen hF hP hst h3 hc2 hH hH' h1 h2 h3' h4' hg hGN
  have hhN := flank_two_sectors_at_S_gen hF hP hst h3 hc2 hH' hH2 h3' h4' h1 h2 hhd hHS
  rw [hSN] at hhN
  exact ⟨⟨isStuck_of_hasRepeatedColour hT (hdom _) ⟨h, hhN⟩, h4 _⟩,
    ⟨isStuck_of_hasRepeatedColour hT (hdom _) ⟨g, hgS⟩, h4 _⟩⟩

/-- **With no four-colour vertex, every stuck run is bi-infinite** (FS114-CVB § 1.4 item 6, "the chain runs on"): `chainVertex_neighbours_of_noFour`
and `stuckAlong_of_run` by induction on `|j|`. A step of `cv_exists`'s refutation: no model expected. -/
theorem stuckRun_eq_univ_of_noFour {F : ArcMap 6} (hM : F.IsTerminalMap) (h4 : ∀ x, (F.coloursAt x).ncard ≤ 3)
    {v : ℂ} {α : ℝ} (hv : F.StuckAlong v α) : F.stuckRun v α = univ := by
  obtain ⟨hF, hP, -, -⟩ := id hM
  have hall : ∀ m : ℕ, ∀ i : ℤ, i.natAbs ≤ m →
      F.IsChainVertex (v + (i : ℂ) * e (α + π / 2)) ∧
        (F.StuckAlong (v + (i : ℂ) * e (α + π / 2)) α ∨ F.StuckAlong (v + (i : ℂ) * e (α + π / 2)) (α + π)) := by
    intro m
    induction m with
    | zero =>
      intro i hi
      have hi0 : i = 0 := by omega
      subst hi0
      simp only [Int.cast_zero, zero_mul, add_zero]
      exact ⟨⟨hv.1, h4 v⟩, Or.inl hv⟩
    | succ m ih =>
      intro i hi
      by_cases him : i.natAbs ≤ m
      · exact ih i him
      · have hi0 : i ≠ 0 := by omega
        -- the neighbour `w ± n` of a chain vertex `w` stuck along `±e α` is a chain vertex, and the axis propagates
        have step : ∀ j : ℤ, j.natAbs ≤ m → ∀ s : ℤ, (s = 1 ∨ s = -1) → i = j + s →
            F.IsChainVertex (v + (i : ℂ) * e (α + π / 2)) ∧
              (F.StuckAlong (v + (i : ℂ) * e (α + π / 2)) α ∨ F.StuckAlong (v + (i : ℂ) * e (α + π / 2)) (α + π)) := by
          intro j hj s hs hij
          obtain ⟨-, hax⟩ := ih j hj
          have hw : v + (i : ℂ) * e (α + π / 2) = v + (j : ℂ) * e (α + π / 2) + e (α + π / 2) ∨
              v + (i : ℂ) * e (α + π / 2) = v + (j : ℂ) * e (α + π / 2) - e (α + π / 2) := by
            rcases hs with rfl | rfl
            · left; rw [hij]; push_cast; ring
            · right; rw [hij]; push_cast; ring
          have hcv : F.IsChainVertex (v + (i : ℂ) * e (α + π / 2)) := by
            rcases hax with hax | hax
            · have := chainVertex_neighbours_of_noFour hM h4 hax
              rcases hw with hw | hw <;> rw [hw]
              · exact this.1
              · exact this.2
            · have := chainVertex_neighbours_of_noFour hM h4 hax
              rw [add_e_add_pi_add, sub_e_add_pi_add] at this
              rcases hw with hw | hw <;> rw [hw]
              · exact this.2
              · exact this.1
          exact ⟨hcv, stuckAlong_of_run hF hP hax hw hcv⟩
        rcases lt_or_gt_of_ne hi0 with hneg | hpos
        · exact step (i + 1) (by omega) (-1) (Or.inr rfl) (by ring)
        · exact step (i - 1) (by omega) 1 (Or.inl rfl) (by ring)
  exact eq_univ_of_forall fun j i _ _ => (hall _ i le_rfl).1

end ArcMap

/-! ## The inhabitant of `IsTerminalMap` -/

/-- **The inhabitant of `IsTerminalMap`** (every clause at once, at seven colours, where no theorem of this module refutes it):
the seven-brick map is valid, of the plane, has no horn and no point of a repeated colour (so no move is available anywhere: `Terminal`),
and no arc of `Γ` on any unit circle (so `QROnly` holds vacuously in its arcs' sense — every constant-sided unit arc, of which there are
none, is (Q) or (R2)). -/
theorem sevenBrickMap_isTerminalMap : sevenBrickMap.IsTerminalMap :=
  ⟨sevenBrickMap_valid, sevenBrickMap_isPlaneMap,
    fun v _ => ⟨sevenBrick_not_mergeAvailable v, fun ⟨_, _, _, _, _, _, _, H, _⟩ => sevenBrick_not_isHorn H,
      fun ⟨_, _, _, _, _, _, _, H, _⟩ => sevenBrick_not_isHorn H⟩,
    fun _ _ _ _ _ h => absurd h sevenBrick_not_isRingArc⟩

end HadwigerNelson.Plane
