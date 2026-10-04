import Proofs.HadwigerNelson.Plane.ValidMap.Sectors
import Proofs.HadwigerNelson.Instances.Seven
import Proofs.HadwigerNelson.Topology.LebesgueCovering
import Proofs.HadwigerNelson.Plane.Diameter

/-!
# Almost-everywhere-proper maps, region-only: lemma (L) and TS-T (FS-106)

Wave 4's skeleton (`plans/FS131-w4-kernel-plan.md` § 7), the two rows FS131-W (Woodall's chain: FS106-WO, FS106-TW, FS106-AE-MAP6,
inventory ruling 54) branches from. Both rows are **region-only** (`plans/FS106-derivation.md`'s header: "a step that reads no colour at
a boundary point"), so both are stated over open colour classes, never over a map's boundaries:

* **FS106-L** (`lemmaL`): in a two-coloured open set `W` (`W ⊆ cl (A ∪ B)`, `A`, `B` open, no two points of one class at distance
  exactly `1`), a point `b ∈ W` with both colours arbitrarily near has its unit circle outside `W`. `b ∈ W` cannot be dropped
  (`not_lemmaL_of_not_mem`: a counterexample with `b` on the frontier of `W`).
* **The regions of an almost-everywhere-proper map** (`AeProperRegions k`, D-AEMAP read region-only): `k` open colour classes, no two
  points of one class at distance `1`, dense union, finitely many components of the classes near every point (S–V's Condition 3). The
  **multicolour** (`multicolour`, D-VMC and S–V's Definition 2) is the set of colours whose class has the point in its closure; its
  `ncard` is the chromaticity. A valid map of the plane gives one (`ArcMap.toAeProperRegions`), and `ArcMap.coloursAt` is its
  multicolour by definition.
* **FS106-TS-T**: a point of chromaticity `≥ 3` within `1/√2 + ε` of every point
  (`AeProperRegions.exists_three_le_multicolour`, SB's route through **Lebesgue's covering theorem** for the square,
  `lebesgue_covering_square` — held in the kernel by FS131-LEB, `Topology/LebesgueCovering`) and within `1` (TS's form); for arc maps (`ArcMap.ts_t`), a point of chromaticity `≥ 3` has degree `≥ 3` (`ArcMap.exists_hasDegree_of_mem_dom`), at most
  three colours everywhere (S–V Lemma 2's conclusion under Condition 5, not a backlog row) makes it trichromatic, and Condition 6
  (`ArcMap.Condition6`) of degree `3`.
* **The inhabitant**: `sevenBrickMap`, the brick seven-colouring of `Instances/Seven` (M36) as an arc map of the plane, valid.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## FS106-L -/

/-- `e α · e β = cos (α − β)` (the real dot product of two unit vectors). -/
theorem dot_e_e (α β : ℝ) : dot (e α) (e β) = Real.cos (α - β) := by
  unfold dot
  rw [conj_e, ← e_add, e_eq, Complex.add_re, Complex.ofReal_re, Complex.mul_I_re, Complex.ofReal_im, neg_zero, add_zero,
    sub_eq_add_neg]

/-- The dot product is real-linear in its first argument: scaling. -/
theorem dot_ofReal_mul (t : ℝ) (d u : ℂ) : dot ((t : ℂ) * d) u = t * dot d u := by
  unfold dot; rw [mul_assoc, Complex.re_ofReal_mul]

/-- The dot product is additive in its first argument. -/
theorem dot_add_left (d d' u : ℂ) : dot (d + d') u = dot d u + dot d' u := by
  unfold dot; rw [add_mul, Complex.add_re]

/-- Against a unit vector the dot product is at most the norm. -/
theorem abs_dot_e_le (d : ℂ) (θ : ℝ) : |dot d (e θ)| ≤ ‖d‖ := by
  unfold dot
  calc |(d * starRingEnd ℂ (e θ)).re| ≤ ‖d * starRingEnd ℂ (e θ)‖ := Complex.abs_re_le_norm _
    _ = ‖d‖ := by rw [norm_mul, RCLike.norm_conj, norm_e, mul_one]

/-- `|p + e θ − w|² = 1 − 2 (w − p)·e θ + |w − p|²`. -/
theorem dist_add_e_sq (p w : ℂ) (θ : ℝ) : dist (p + e θ) w ^ 2 = 1 - 2 * dot (w - p) (e θ) + ‖w - p‖ ^ 2 := by
  have hu : (e θ).re ^ 2 + (e θ).im ^ 2 = 1 := by
    have h := Complex.sq_norm (e θ)
    rw [norm_e, Complex.normSq_apply] at h
    nlinarith [h]
  rw [dist_eq_norm, Complex.sq_norm, Complex.sq_norm, Complex.normSq_apply, Complex.normSq_apply]
  unfold dot
  simp only [Complex.add_re, Complex.add_im, Complex.sub_re, Complex.sub_im, Complex.mul_re,
    Complex.conj_re, Complex.conj_im]
  linear_combination hu

/-- **A unit circle through `p` meets `ω(w)` near the direction `θ₀`**: if `(w − p)·e θ` crosses `|w − p|²/2` between `θ₀ − δ'` and
`θ₀ + δ'`, some `θ` in between has `|p + e θ − w| = 1` (the intermediate value theorem). -/
theorem exists_dist_add_e_eq_one {p w : ℂ} {θ₀ δ' : ℝ} (hδ' : 0 ≤ δ')
    (h1 : ‖w - p‖ ^ 2 / 2 < dot (w - p) (e (θ₀ + δ'))) (h2 : dot (w - p) (e (θ₀ - δ')) < ‖w - p‖ ^ 2 / 2) :
    ∃ θ ∈ Icc (θ₀ - δ') (θ₀ + δ'), dist (p + e θ) w = 1 := by
  have hcont : ContinuousOn (fun θ => dot (w - p) (e θ)) (Icc (θ₀ - δ') (θ₀ + δ')) := by
    unfold dot e; fun_prop
  obtain ⟨θ, hθ, hval⟩ := intermediate_value_Icc (by linarith) hcont ⟨h2.le, h1.le⟩
  refine ⟨θ, hθ, ?_⟩
  have h := dist_add_e_sq p w θ
  simp only at hval
  rw [hval] at h
  have h' : dist (p + e θ) w ^ 2 = 1 := by rw [h]; ring
  have := dist_nonneg (x := p + e θ) (y := w)
  nlinarith [h']

/-- **The geometric step of FS106-L** (the two-dimensional step the sweep route needs, FS131-I4c): for `q ∈ ω(b)` and any `δ`, `η > 0`,
any two points `a`, `a'` close enough to `b` have a common point `w` within `η` of `b` lying on a unit circle about a point `c` of
`ω(a)` and on one about a point `c'` of `ω(a')`, with `c`, `c'` within `δ` of `q`. (`w = a + t·i(q − b)`, `t = sin δ'/2`; each `c` by the
intermediate value theorem on `ω(·)` near the direction of `q − b`.) -/
theorem exists_double_unit_circle {b q : ℂ} (hq : dist q b = 1) {δ η : ℝ} (hδ : 0 < δ) (hη : 0 < η) :
    ∃ ε > 0, ∀ a a' : ℂ, dist a b < ε → dist a' b < ε → ∃ w ∈ ball b η, ∃ c ∈ ball q δ, ∃ c' ∈ ball q δ,
      dist w c = 1 ∧ dist c a = 1 ∧ dist w c' = 1 ∧ dist c' a' = 1 := by
  set θ₀ := Complex.arg (q - b) with hθ₀
  have hqb : q = b + e θ₀ := by
    have h := Complex.norm_mul_exp_arg_mul_I (q - b)
    rw [← dist_eq_norm, hq, Complex.ofReal_one, one_mul] at h
    rw [show e θ₀ = q - b from h]; ring
  set δ' := min (min (δ / 2) η) 1 with hδ'_def
  have hδ'pos : 0 < δ' := lt_min (lt_min (by linarith) hη) one_pos
  have hδ'δ : δ' ≤ δ / 2 := (min_le_left _ _).trans (min_le_left _ _)
  have hδ'η : δ' ≤ η := (min_le_left _ _).trans (min_le_right _ _)
  have hδ'1 : δ' ≤ 1 := min_le_right _ _
  set s := Real.sin δ' with hs_def
  have hs : 0 < s := Real.sin_pos_of_pos_of_lt_pi hδ'pos (by linarith [Real.two_le_pi])
  have hsδ : s ≤ δ' := Real.sin_le hδ'pos.le
  set t := s / 2 with ht_def
  have ht : 0 < t := by positivity
  set ε := min (s ^ 2 / 32) (min (δ / 4) (η / 4)) with hε_def
  have hε1 : ε ≤ s ^ 2 / 32 := min_le_left _ _
  have hε2 : ε ≤ δ / 4 := (min_le_right _ _).trans (min_le_left _ _)
  have hε3 : ε ≤ η / 4 := (min_le_right _ _).trans (min_le_right _ _)
  refine ⟨ε, by positivity, fun a a' ha ha' => ?_⟩
  set n := e (θ₀ + π / 2) with hn
  set w := a + (t : ℂ) * n with hw
  have hdot_n : ∀ φ, dot n (e (θ₀ + φ)) = Real.sin φ := by
    intro φ; rw [hn, dot_e_e, show θ₀ + π / 2 - (θ₀ + φ) = π / 2 - φ by ring, Real.cos_pi_div_two_sub]
  have hdot_n' : dot n (e (θ₀ - δ')) = -s := by
    rw [sub_eq_add_neg, hdot_n, Real.sin_neg]
  -- the circle step, for any centre `p` near `b`
  have key : ∀ p : ℂ, dist p b < δ / 2 → ‖w - p‖ ^ 2 / 2 < dot (w - p) (e (θ₀ + δ')) →
      dot (w - p) (e (θ₀ - δ')) < ‖w - p‖ ^ 2 / 2 → ∃ c ∈ ball q δ, dist w c = 1 ∧ dist c p = 1 := by
    intro p hp h1 h2
    obtain ⟨θ, hθ, hd⟩ := exists_dist_add_e_eq_one hδ'pos.le h1 h2
    refine ⟨p + e θ, ?_, by rw [dist_comm]; exact hd, by rw [dist_comm, dist_self_add_right, norm_e]⟩
    have hθ' : |θ - θ₀| ≤ δ' := abs_le.mpr ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
    rw [mem_ball, hqb, dist_eq_norm]
    calc ‖p + e θ - (b + e θ₀)‖ = ‖(p - b) + (e θ - e θ₀)‖ := by ring_nf
      _ ≤ ‖p - b‖ + ‖e θ - e θ₀‖ := norm_add_le _ _
      _ ≤ dist p b + |θ - θ₀| := by rw [dist_eq_norm]; exact add_le_add le_rfl (norm_e_sub_e_le θ θ₀)
      _ < δ / 2 + δ' := by linarith
      _ ≤ δ := by linarith
  have hwa : w - a = (t : ℂ) * n := by rw [hw]; ring
  have hnn : ‖n‖ = 1 := norm_e _
  have hnorm_tn : ‖(t : ℂ) * n‖ = t := by rw [norm_mul, hnn, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht]
  -- the circle about a point of `ω(a)`
  obtain ⟨c, hc, hwc, hca⟩ := key a (by linarith [hε2]) (by
      rw [hwa, hnorm_tn, dot_ofReal_mul, hdot_n, ht_def]; nlinarith)
    (by rw [hwa, hnorm_tn, dot_ofReal_mul, hdot_n']; nlinarith)
  -- the circle about a point of `ω(a')`
  set e₀ := a - a' with he₀
  have he₀n : ‖e₀‖ < 2 * ε := by
    rw [he₀]
    calc ‖a - a'‖ = dist a a' := (dist_eq_norm _ _).symm
      _ ≤ dist a b + dist a' b := dist_triangle_right _ _ _
      _ < ε + ε := add_lt_add ha ha'
      _ = 2 * ε := by ring
  have hwa' : w - a' = (t : ℂ) * n + e₀ := by rw [hw, he₀]; ring
  have hnorm' : ‖w - a'‖ ≤ t + ‖e₀‖ := by rw [hwa']; exact (norm_add_le _ _).trans (by rw [hnorm_tn])
  have hs1 : s ≤ 1 := Real.sin_le_one _
  have he₀s : ‖e₀‖ < s ^ 2 / 16 := by linarith
  have hsq : ‖w - a'‖ ^ 2 ≤ (t + ‖e₀‖) ^ 2 := pow_le_pow_left₀ (norm_nonneg _) hnorm' 2
  have hd1 := (abs_le.mp (abs_dot_e_le e₀ (θ₀ + δ'))).1
  have hd2 := (abs_le.mp (abs_dot_e_le e₀ (θ₀ - δ'))).2
  have hen := norm_nonneg e₀
  have hs2 : 0 < s ^ 2 := by positivity
  have hts : t * s = s ^ 2 / 2 := by rw [ht_def]; ring
  have hsq2 : ‖(t : ℂ) * n + e₀‖ ^ 2 ≤ 81 * s ^ 2 / 256 := by
    have h9 : t + ‖e₀‖ ≤ 9 * s / 16 := by rw [ht_def]; nlinarith
    rw [hwa'] at hsq
    calc ‖(t : ℂ) * n + e₀‖ ^ 2 ≤ (t + ‖e₀‖) ^ 2 := hsq
      _ ≤ (9 * s / 16) ^ 2 := pow_le_pow_left₀ (by positivity) h9 2
      _ = 81 * s ^ 2 / 256 := by ring
  obtain ⟨c', hc', hwc', hca'⟩ := key a' (by linarith [hε2, dist_nonneg (x := a') (y := b)])
    (by
      rw [hwa', dot_add_left, dot_ofReal_mul, hdot_n, ← hs_def]
      linarith)
    (by
      rw [hwa', dot_add_left, dot_ofReal_mul, hdot_n']
      have hts' : t * -s = -(s ^ 2 / 2) := by rw [mul_neg, hts]
      nlinarith [sq_nonneg ‖(t : ℂ) * n + e₀‖])
  refine ⟨w, ?_, c, hc, c', hc', hwc, hca, hwc', hca'⟩
  rw [mem_ball, hw, dist_eq_norm]
  calc ‖a + (t : ℂ) * n - b‖ = ‖(a - b) + (t : ℂ) * n‖ := by ring_nf
    _ ≤ ‖a - b‖ + ‖(t : ℂ) * n‖ := norm_add_le _ _
    _ = dist a b + t := by rw [hnorm_tn, dist_eq_norm]
    _ < η := by linarith

/-- The shadow of an open set is open: moving a point of the shadow moves its witness with it. -/
theorem isOpen_shadow {O : Set ℂ} (hO : IsOpen O) : IsOpen (shadow O) := by
  rw [Metric.isOpen_iff]
  rintro z ⟨y, hy, hzy⟩
  obtain ⟨ρ, hρ, hball⟩ := Metric.isOpen_iff.mp hO y hy
  refine ⟨ρ, hρ, fun z' hz' => ⟨y + (z' - z), hball ?_, ?_⟩⟩
  · rw [mem_ball, dist_eq_norm, show y + (z' - z) - y = z' - z by ring, ← dist_eq_norm]; exact hz'
  · rw [dist_eq_norm, show z' - (y + (z' - z)) = z - y by ring, ← dist_eq_norm, hzy]

/-- No point of a set with no unit pair lies in the shadow of a part of it. -/
theorem disjoint_shadow {A O : Set ℂ} (hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1) (hO : O ⊆ A) : Disjoint (shadow O) A := by
  rw [disjoint_left]
  rintro z ⟨y, hy, hzy⟩ hz
  exact hAu z hz y (hO hy) hzy

/-- A dense part of `V` has a shadow dense in `V`'s shadow. -/
theorem shadow_subset_closure_shadow {V S : Set ℂ} (h : V ⊆ closure S) : shadow V ⊆ closure (shadow S) := by
  rintro z ⟨y, hy, hzy⟩
  rw [Metric.mem_closure_iff]
  intro ε hε
  obtain ⟨y', hy', hyy'⟩ := Metric.mem_closure_iff.mp (h hy) ε hε
  refine ⟨z + (y' - y), ⟨y', hy', ?_⟩, ?_⟩
  · rw [dist_eq_norm, show z + (y' - y) - y' = z - y by ring, ← dist_eq_norm, hzy]
  · rw [dist_eq_norm, show z - (z + (y' - y)) = y - y' by ring, ← dist_eq_norm]; exact hyy'

/-- **FS106-L** (lemma (L), `plans/FS106-V-verification.md` V3 stage 1, region-only): in a two-coloured open set `W` with no
monochrome unit — `W ⊆ cl (A ∪ B)` for open classes `A`, `B`, no two points of one class at distance exactly `1` — a two-colour
change point `b` of `W` (a point of `W` with both colours arbitrarily near) has its unit circle outside `W`. (Disjointness of `A` and
`B` is not read.) The proof (FS131-I4c, closing the plan's sweep route): for `q ∈ ω(b) ∩ W`, the open sets `V_A = Sh(A) ∩ B(q, δ)`
and `V_B = Sh(B) ∩ B(q, δ)` miss `A` and `B`, so `B` is dense in `V_A` and `A` in `V_B`; their shadows' dense parts `Sh(V_A ∩ B)`,
`Sh(V_B ∩ A)` miss `B` and `A`; and a point `w` near `b` in both `Sh(V_A)` and `Sh(V_B)` (`exists_double_unit_circle`) gives a
non-empty open subset of `W` missing `A ∪ B`. -/
theorem lemmaL {A B W : Set ℂ} (hA : IsOpen A) (hB : IsOpen B) (hW : IsOpen W) (hWAB : W ⊆ closure (A ∪ B))
    (hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1) (hBu : ∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) {b : ℂ} (hbW : b ∈ W)
    (hbA : b ∈ closure A) (hbB : b ∈ closure B) : Disjoint (sphere b 1) W := by
  rw [disjoint_left]
  intro q hq hqW
  rw [mem_sphere] at hq
  obtain ⟨δ, hδ, hδW⟩ := Metric.isOpen_iff.mp hW q hqW
  obtain ⟨η, hη, hηW⟩ := Metric.isOpen_iff.mp hW b hbW
  -- an open subset of `W` missing a class is in the closure of the other
  have hdense : ∀ {V X Y : Set ℂ}, IsOpen V → V ⊆ W → Disjoint V X → (X ∪ Y = A ∪ B) → V ⊆ closure (V ∩ Y) := by
    intro V X Y hV hVW hVX hXY z hz
    have h1 := hV.inter_closure ⟨hz, hWAB (hVW hz)⟩
    rw [← hXY, inter_union_distrib_left, disjoint_iff_inter_eq_empty.mp hVX, empty_union] at h1
    exact h1
  set VA := shadow A ∩ ball q δ with hVA
  set VB := shadow B ∩ ball q δ with hVB
  have hVAo : IsOpen VA := (isOpen_shadow hA).inter isOpen_ball
  have hVBo : IsOpen VB := (isOpen_shadow hB).inter isOpen_ball
  have hVAd : VA ⊆ closure (VA ∩ B) :=
    hdense hVAo (inter_subset_right.trans hδW) ((disjoint_shadow hAu subset_rfl).mono_left inter_subset_left) rfl
  have hVBd : VB ⊆ closure (VB ∩ A) :=
    hdense hVBo (inter_subset_right.trans hδW) ((disjoint_shadow hBu subset_rfl).mono_left inter_subset_left)
      (union_comm B A)
  -- a point near `b` in both shadows
  obtain ⟨ε, hε, hgeo⟩ := exists_double_unit_circle (b := b) (q := q) hq hδ hη
  obtain ⟨a, ha, hab⟩ := Metric.mem_closure_iff.mp hbA ε hε
  obtain ⟨a', ha', hab'⟩ := Metric.mem_closure_iff.mp hbB ε hε
  obtain ⟨w, hw, c, hc, c', hc', hwc, hca, hwc', hca'⟩ :=
    hgeo a a' (by rw [dist_comm]; exact hab) (by rw [dist_comm]; exact hab')
  have hcVA : c ∈ VA := ⟨⟨a, ha, hca⟩, hc⟩
  have hc'VB : c' ∈ VB := ⟨⟨a', ha', hca'⟩, hc'⟩
  set N := shadow VA ∩ shadow VB ∩ ball b η with hN
  have hNo : IsOpen N := ((isOpen_shadow hVAo).inter (isOpen_shadow hVBo)).inter isOpen_ball
  have hwN : w ∈ N := ⟨⟨⟨c, hcVA, hwc⟩, ⟨c', hc'VB, hwc'⟩⟩, hw⟩
  set SA := shadow (VA ∩ B) with hSA
  set SB := shadow (VB ∩ A) with hSB
  have hSAo : IsOpen SA := isOpen_shadow (hVAo.inter hB)
  have hSBo : IsOpen SB := isOpen_shadow (hVBo.inter hA)
  have hSAB : Disjoint SA B := disjoint_shadow hBu inter_subset_right
  have hSBA : Disjoint SB A := disjoint_shadow hAu inter_subset_right
  have hSAcl : shadow VA ⊆ closure SA := shadow_subset_closure_shadow hVAd
  have hSBcl : shadow VB ⊆ closure SB := shadow_subset_closure_shadow hVBd
  -- `N ∩ SA ∩ SB` is a non-empty open subset of `W` missing `A ∪ B`
  obtain ⟨x, hxN, hxSA⟩ := mem_closure_iff.mp (hSAcl hwN.1.1) N hNo hwN
  obtain ⟨y, ⟨hyN, hySA⟩, hySB⟩ := mem_closure_iff.mp (hSBcl hxN.1.2) (N ∩ SA) (hNo.inter hSAo) ⟨hxN, hxSA⟩
  obtain ⟨z, ⟨⟨-, hzSA⟩, hzSB⟩, hzAB⟩ := mem_closure_iff.mp (hWAB (hηW hyN.2)) (N ∩ SA ∩ SB)
    ((hNo.inter hSAo).inter hSBo) ⟨⟨hyN, hySA⟩, hySB⟩
  rcases hzAB with hzA | hzB
  · exact disjoint_left.mp hSBA hzSB hzA
  · exact disjoint_left.mp hSAB hzSA hzB

/-- **Adversary for FS106-L's reading**: the change point must lie in `W`. With `b = 0` on the frontier of `W`, `A` a thin cone at
`0` pointing away from `1` together with the part of `B(1, r)` outside `B̄(0, 1)`, and `B` the opposite cone together with the part of
`B(1, r)` inside, both classes avoid the unit distance, `0 ∈ cl A ∩ cl B`, and `1 ∈ ω(0) ∩ W`. -/
theorem not_lemmaL_of_not_mem :
    ¬ ∀ (A B W : Set ℂ) (b : ℂ), IsOpen A → IsOpen B → IsOpen W → W ⊆ closure (A ∪ B) →
      (∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1) → (∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) → b ∈ closure A → b ∈ closure B →
      Disjoint (sphere b 1) W := by
  intro h
  have hdist : ∀ x y : ℂ, dist x y ^ 2 = (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 := by
    intro x y
    rw [Complex.dist_eq, Complex.sq_norm, Complex.normSq_apply]; simp; ring
  have hne : ∀ x y : ℂ, (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 ≠ 1 → dist x y ≠ 1 := by
    intro x y hxy hd; apply hxy; rw [← hdist, hd]; norm_num
  have hlt : ∀ x y : ℂ, (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 < 1 → dist x y ≠ 1 := by
    intro x y hxy; exact hne x y hxy.ne
  have hgt : ∀ x y : ℂ, 1 < (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 → dist x y ≠ 1 := by
    intro x y hxy; exact hne x y hxy.ne'
  -- the sets
  set A0 : Set ℂ := {z | z.re < 0 ∧ 2 * |z.im| < -z.re ∧ z.re ^ 2 + z.im ^ 2 < 1 / 16} with hA0
  set B0 : Set ℂ := {z | 0 < z.re ∧ 2 * |z.im| < z.re ∧ z.re ^ 2 + z.im ^ 2 < 1 / 16} with hB0
  set A1 : Set ℂ := {z | (z.re - 1) ^ 2 + z.im ^ 2 < 1 / 100 ∧ 1 < z.re ^ 2 + z.im ^ 2} with hA1
  set B1 : Set ℂ := {z | (z.re - 1) ^ 2 + z.im ^ 2 < 1 / 100 ∧ z.re ^ 2 + z.im ^ 2 < 1} with hB1
  set W : Set ℂ := {z | (z.re - 1) ^ 2 + z.im ^ 2 < 1 / 100} with hW
  have lt_open : ∀ f g : ℂ → ℝ, Continuous f → Continuous g → IsOpen {z : ℂ | f z < g z} :=
    fun f g hf hg => isOpen_lt hf hg
  have cre : Continuous fun z : ℂ => z.re := Complex.continuous_re
  have cim : Continuous fun z : ℂ => z.im := Complex.continuous_im
  have cq : Continuous fun z : ℂ => z.re ^ 2 + z.im ^ 2 := by fun_prop
  have cd : Continuous fun z : ℂ => (z.re - 1) ^ 2 + z.im ^ 2 := by fun_prop
  have cabs : Continuous fun z : ℂ => 2 * |z.im| := by fun_prop
  have cneg : Continuous fun z : ℂ => -z.re := by fun_prop
  have cc : ∀ c : ℝ, Continuous fun _ : ℂ => c := fun c => continuous_const
  have oA0 : IsOpen A0 := (lt_open _ _ cre (cc 0)).inter ((lt_open _ _ cabs cneg).inter (lt_open _ _ cq (cc _)))
  have oB0 : IsOpen B0 := (lt_open _ _ (cc 0) cre).inter ((lt_open _ _ cabs cre).inter (lt_open _ _ cq (cc _)))
  have oA1 : IsOpen A1 := (lt_open _ _ cd (cc _)).inter (lt_open _ _ (cc 1) cq)
  have oB1 : IsOpen B1 := (lt_open _ _ cd (cc _)).inter (lt_open _ _ cq (cc 1))
  have oW : IsOpen W := lt_open _ _ cd (cc _)
  -- unit-freeness
  have uA0 : ∀ x ∈ A0, ∀ y ∈ A0, dist x y ≠ 1 := by
    rintro x ⟨hx1, hx2, hx3⟩ y ⟨hy1, hy2, hy3⟩
    apply hlt
    nlinarith [sq_nonneg (x.re + y.re), sq_nonneg (x.im + y.im), sq_nonneg (x.re - y.re), sq_nonneg (x.im - y.im)]
  have uB0 : ∀ x ∈ B0, ∀ y ∈ B0, dist x y ≠ 1 := by
    rintro x ⟨hx1, hx2, hx3⟩ y ⟨hy1, hy2, hy3⟩
    apply hlt
    nlinarith [sq_nonneg (x.re + y.re), sq_nonneg (x.im + y.im), sq_nonneg (x.re - y.re), sq_nonneg (x.im - y.im)]
  have uA1 : ∀ x ∈ A1, ∀ y ∈ A1, dist x y ≠ 1 := by
    rintro x ⟨hx1, hx2⟩ y ⟨hy1, hy2⟩
    apply hlt
    nlinarith [sq_nonneg (x.re + y.re - 2), sq_nonneg (x.im + y.im), sq_nonneg (x.re - y.re), sq_nonneg (x.im - y.im)]
  have uB1 : ∀ x ∈ B1, ∀ y ∈ B1, dist x y ≠ 1 := by
    rintro x ⟨hx1, hx2⟩ y ⟨hy1, hy2⟩
    apply hlt
    nlinarith [sq_nonneg (x.re + y.re - 2), sq_nonneg (x.im + y.im), sq_nonneg (x.re - y.re), sq_nonneg (x.im - y.im)]
  have uA01 : ∀ x ∈ A0, ∀ y ∈ A1, dist x y ≠ 1 := by
    rintro x ⟨hx1, hx2, hx3⟩ y ⟨hy1, hy2⟩
    apply hgt
    have hyre : 9 / 10 < y.re := by nlinarith [sq_nonneg y.im]
    have hyim : |y.im| < 1 / 10 := by
      rw [abs_lt]; constructor <;> nlinarith [sq_nonneg (y.re - 1), sq_nonneg y.im]
    have hxim := abs_nonneg x.im
    have hcross : y.re * x.re + y.im * x.im ≤ 0 := by
      have h1 : y.im * x.im ≤ |y.im| * |x.im| := by
        calc y.im * x.im ≤ |y.im * x.im| := le_abs_self _
          _ = _ := abs_mul _ _
      have h2 : |y.im| * |x.im| ≤ (1 / 10) * (-x.re / 2) := by
        apply mul_le_mul hyim.le (by linarith) (abs_nonneg _) (by norm_num)
      nlinarith
    nlinarith [sq_nonneg x.re, sq_nonneg x.im]
  have uB01 : ∀ x ∈ B0, ∀ y ∈ B1, dist x y ≠ 1 := by
    rintro x ⟨hx1, hx2, hx3⟩ y ⟨hy1, hy2⟩
    apply hlt
    have hyre : 9 / 10 < y.re := by nlinarith [sq_nonneg y.im]
    have hyim : |y.im| < 1 / 10 := by
      rw [abs_lt]; constructor <;> nlinarith [sq_nonneg (y.re - 1), sq_nonneg y.im]
    have hcross : (17 / 20) * x.re ≤ y.re * x.re + y.im * x.im := by
      have h1 : -(|y.im| * |x.im|) ≤ y.im * x.im := by
        calc -(|y.im| * |x.im|) = -|y.im * x.im| := by rw [abs_mul]
          _ ≤ _ := neg_abs_le _
      have h2 : |y.im| * |x.im| ≤ (1 / 10) * (x.re / 2) := by
        apply mul_le_mul hyim.le (by linarith) (abs_nonneg _) (by norm_num)
      nlinarith
    have hxre : x.re < 1 / 4 := by nlinarith [sq_nonneg x.im]
    have hxsq : x.re ^ 2 + x.im ^ 2 ≤ (5 / 4) * x.re ^ 2 := by
      have : x.im ^ 2 ≤ (x.re / 2) ^ 2 := by
        have := abs_nonneg x.im
        nlinarith [sq_abs x.im]
      nlinarith
    nlinarith [sq_nonneg x.re, mul_pos hx1 hx1]
  have hAu : ∀ x ∈ A0 ∪ A1, ∀ y ∈ A0 ∪ A1, dist x y ≠ 1 := by
    rintro x (hx | hx) y (hy | hy)
    · exact uA0 x hx y hy
    · exact uA01 x hx y hy
    · rw [dist_comm]; exact uA01 y hy x hx
    · exact uA1 x hx y hy
  have hBu : ∀ x ∈ B0 ∪ B1, ∀ y ∈ B0 ∪ B1, dist x y ≠ 1 := by
    rintro x (hx | hx) y (hy | hy)
    · exact uB0 x hx y hy
    · exact uB01 x hx y hy
    · rw [dist_comm]; exact uB01 y hy x hx
    · exact uB1 x hx y hy
  -- the change point
  have h0A : (0 : ℂ) ∈ closure (A0 ∪ A1) := by
    refine Metric.mem_closure_iff.2 fun δ hδ => ?_
    set t : ℝ := min (δ / 2) (1 / 8) with ht
    have ht0 : 0 < t := lt_min (by linarith) (by norm_num)
    have ht1 : t ≤ 1 / 8 := min_le_right _ _
    have htδ : t < δ := lt_of_le_of_lt (min_le_left _ _) (by linarith)
    refine ⟨((-t : ℝ) : ℂ), Or.inl ⟨by simpa using ht0, by simpa using ht0, by simp; nlinarith⟩, ?_⟩
    rw [dist_zero_left, Complex.norm_real, Real.norm_eq_abs, abs_neg, abs_of_pos ht0]; exact htδ
  have h0B : (0 : ℂ) ∈ closure (B0 ∪ B1) := by
    refine Metric.mem_closure_iff.2 fun δ hδ => ?_
    set t : ℝ := min (δ / 2) (1 / 8) with ht
    have ht0 : 0 < t := lt_min (by linarith) (by norm_num)
    have ht1 : t ≤ 1 / 8 := min_le_right _ _
    have htδ : t < δ := lt_of_le_of_lt (min_le_left _ _) (by linarith)
    refine ⟨((t : ℝ) : ℂ), Or.inl ⟨by simpa using ht0, by simpa using ht0, by simp; nlinarith⟩, ?_⟩
    rw [dist_zero_left, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]; exact htδ
  -- W lies in the closure
  have hWcl : W ⊆ closure ((A0 ∪ A1) ∪ (B0 ∪ B1)) := by
    intro z hz
    have hzW : (z.re - 1) ^ 2 + z.im ^ 2 < 1 / 100 := hz
    by_cases hq : z.re ^ 2 + z.im ^ 2 = 1
    · refine Metric.mem_closure_iff.2 fun δ hδ => ?_
      obtain ⟨d, hd⟩ : ∃ d : ℝ, d = (z.re - 1) ^ 2 + z.im ^ 2 := ⟨_, rfl⟩
      rw [← hd] at hzW
      obtain ⟨t, ht⟩ : ∃ t : ℝ, t = min (δ / 4) ((1 / 100 - d) / 4) := ⟨_, rfl⟩
      have ht0 : 0 < t := by rw [ht]; exact lt_min (by linarith) (by linarith)
      have ht1 : t ≤ (1 / 100 - d) / 4 := by rw [ht]; exact min_le_right _ _
      have ht2 : t ≤ δ / 4 := by rw [ht]; exact min_le_left _ _
      have hd0 : 0 ≤ d := by rw [hd]; positivity
      refine ⟨((1 + t : ℝ) : ℂ) * z, Or.inl (Or.inr ⟨?_, ?_⟩), ?_⟩
      · simp only [Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, zero_mul, sub_zero, add_zero]
        have h1 : ((1 + t) * z.re - 1) ^ 2 + ((1 + t) * z.im) ^ 2 = (1 + t) * d + t ^ 2 := by
          rw [hd]; linear_combination (t * (1 + t)) * hq
        have h2 : t * (d + t) ≤ t * 1 := mul_le_mul_of_nonneg_left (by linarith) ht0.le
        rw [h1]; nlinarith
      · simp only [Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, zero_mul, sub_zero, add_zero]
        have h1 : ((1 + t) * z.re) ^ 2 + ((1 + t) * z.im) ^ 2 = (1 + t) ^ 2 := by linear_combination (1 + t) ^ 2 * hq
        rw [h1]; nlinarith
      · rw [dist_eq_norm, show z - ((1 + t : ℝ) : ℂ) * z = -((t : ℂ) * z) by push_cast; ring, norm_neg, norm_mul,
          Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]
        have hz1 : ‖z‖ = 1 := by
          have : ‖z‖ ^ 2 = 1 := by rw [Complex.sq_norm, Complex.normSq_apply]; linarith
          nlinarith [norm_nonneg z]
        rw [hz1]; linarith
    · apply subset_closure
      rcases lt_or_gt_of_ne hq with h | h
      · exact Or.inr (Or.inr ⟨hzW, h⟩)
      · exact Or.inl (Or.inr ⟨hzW, h⟩)
  have := h (A0 ∪ A1) (B0 ∪ B1) W 0 (oA0.union oA1) (oB0.union oB1) oW hWcl hAu hBu h0A h0B
  refine Set.disjoint_left.1 this (show (1 : ℂ) ∈ sphere (0 : ℂ) 1 by simp) ?_
  show ((1 : ℂ).re - 1) ^ 2 + (1 : ℂ).im ^ 2 < 1 / 100
  simp

/-! ## The regions of an almost-everywhere-proper map, and the multicolour -/

/-- **The multicolour** of `x` for the colour classes `S` (D-VMC; S–V's Definition 2, "the set of colors assigned to the regions
whose closure contains `u`"): the colours whose class has `x` in its closure. Its `ncard` is the chromaticity of `x`. -/
def multicolour {k : ℕ} (S : Fin k → Set ℂ) (x : ℂ) : Set (Fin k) := {j | x ∈ closure (S j)}

/-- **The regions of an almost-everywhere-proper map-type colouring** (D-AEMAP, region-only): `k` open colour classes (each the union
of the open regions of one colour), no two points of one class at distance exactly `1`, whose union is dense (every point lies in the
closure of a region), with finitely many connected components of the classes meeting a neighbourhood of each point (S–V's
Condition 3, read on regions). Boundaries and vertices are never read. -/
structure AeProperRegions (k : ℕ) where
  /-- The colour classes: the union of the open regions of each colour. -/
  cls : Fin k → Set ℂ
  /-- Each class is open. -/
  isOpen_cls : ∀ j, IsOpen (cls j)
  /-- Almost-everywhere-properness: no two points of one class at distance exactly `1`. -/
  dist_ne_one : ∀ j, ∀ x ∈ cls j, ∀ y ∈ cls j, dist x y ≠ 1
  /-- Every point lies in the closure of a region. -/
  dense : Dense (⋃ j, cls j)
  /-- Finitely many regions (components of the classes) meet a neighbourhood of each point. -/
  locallyFinite : ∀ x, ∃ t ∈ 𝓝 x,
    {C : Set ℂ | ∃ j, ∃ y ∈ cls j, C = connectedComponentIn (cls j) y ∧ (C ∩ t).Nonempty}.Finite

/-- The multicolour reads the closures of the classes: with classes `B(0, 1)` and `B(2, 1)`, both colours are at `1`. -/
example : multicolour (![ball (0 : ℂ) 1, ball 2 1] : Fin 2 → Set ℂ) 1 = univ := by
  ext j
  simp only [multicolour, mem_setOf_eq, mem_univ, iff_true]
  fin_cases j
  · show (1 : ℂ) ∈ closure (ball 0 1)
    rw [closure_ball _ one_ne_zero, mem_closedBall, dist_zero_right]; simp
  · show (1 : ℂ) ∈ closure (ball 2 1)
    rw [closure_ball _ one_ne_zero, mem_closedBall, dist_comm, dist_eq_norm]; norm_num

/-- **Adversary**: a point outside every closure has empty multicolour. -/
example : multicolour (![ball (0 : ℂ) 1, ball 2 1] : Fin 2 → Set ℂ) (5 * I) = ∅ := by
  ext j
  simp only [multicolour, mem_setOf_eq, mem_empty_iff_false, iff_false]
  fin_cases j
  · show (5 * I : ℂ) ∉ closure (ball 0 1)
    rw [closure_ball _ one_ne_zero, mem_closedBall, dist_zero_right]; simp
  · show (5 * I : ℂ) ∉ closure (ball 2 1)
    rw [closure_ball _ one_ne_zero, mem_closedBall, dist_eq_norm]
    have : ‖(5 * I - 2 : ℂ)‖ ^ 2 = 29 := by
      rw [← Complex.normSq_eq_norm_sq]; simp [Complex.normSq_apply]; norm_num
    nlinarith [norm_nonneg (5 * I - 2 : ℂ)]

/-! ## Lebesgue's covering theorem for the square (an outside theorem) -/

/-- The closed axis-parallel square `[c.re, c.re + s] × [c.im, c.im + s]`. -/
def closedSquare (c : ℂ) (s : ℝ) : Set ℂ := {z | c.re ≤ z.re ∧ z.re ≤ c.re + s ∧ c.im ≤ z.im ∧ z.im ≤ c.im + s}

/-- **Lebesgue's covering theorem for the square** (`n = 2`): if a closed square is covered by finitely many closed sets none of
which meets two opposite sides, some point of the square lies in three of them. `[HurewiczWallman1948]` Thm IV 2, p. 42 (the
`n`-cube, `n + 1` sets); SB's step 6 (`plans/FS106-SB-verification.md` § 2.5). Proved in the kernel by FS131-LEB
(`HadwigerNelson.LebesgueCovering.lebesgue_covering_square`, `Topology/LebesgueCovering`, through Sperner's lemma on the grid). -/
theorem lebesgue_covering_square {m : ℕ} (c : ℂ) {s : ℝ} (hs : 0 < s) (F : Fin m → Set ℂ) (hF : ∀ i, IsClosed (F i))
    (hcov : closedSquare c s ⊆ ⋃ i, F i)
    (hLR : ∀ i, ¬ ((∃ z ∈ F i ∩ closedSquare c s, z.re = c.re) ∧ ∃ z ∈ F i ∩ closedSquare c s, z.re = c.re + s))
    (hBT : ∀ i, ¬ ((∃ z ∈ F i ∩ closedSquare c s, z.im = c.im) ∧ ∃ z ∈ F i ∩ closedSquare c s, z.im = c.im + s)) :
    ∃ z ∈ closedSquare c s, ∃ i j l : Fin m, i ≠ j ∧ i ≠ l ∧ j ≠ l ∧ z ∈ F i ∧ z ∈ F j ∧ z ∈ F l :=
  LebesgueCovering.lebesgue_covering_square c hs F hF hcov hLR hBT

/-! ## FS106-TS-T, region-only -/

namespace AeProperRegions

variable {k : ℕ} (R : AeProperRegions k)

/-- No class of an almost-everywhere-proper map has a unit pair, so its unit pairs are null (the measure form wave 1's chain lemma
reads). -/
theorem unitPairsNull_cls (j : Fin k) : UnitPairsNull (R.cls j) := by
  have h : unitPairSet (R.cls j) = ∅ := by
    ext q
    simp only [unitPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
    intro h1 h2
    exact R.dist_ne_one j _ h1 _ h2 (by rw [dist_self_add_right, norm_e])
  unfold UnitPairsNull
  rw [h, MeasureTheory.measure_empty]

/-- **A region** of `R`: a pair `(j, C)` with `C` a connected component of the class `cls j` (pairs, since two classes may share a
component as a set). -/
def IsRegion (q : Fin k × Set ℂ) : Prop := ∃ y ∈ R.cls q.1, q.2 = connectedComponentIn (R.cls q.1) y

variable {R}

theorem IsRegion.subset {q : Fin k × Set ℂ} (h : R.IsRegion q) : q.2 ⊆ R.cls q.1 := by
  obtain ⟨y, -, hq⟩ := h; rw [hq]; exact connectedComponentIn_subset _ _

theorem IsRegion.isPreconnected {q : Fin k × Set ℂ} (h : R.IsRegion q) : IsPreconnected q.2 := by
  obtain ⟨y, -, hq⟩ := h; rw [hq]; exact isPreconnected_connectedComponentIn

/-- One link of a chain of regions of one colour (wave 1's `chain_step`): a point of the class within `1` of all of a region is
within `1` of all of any region of the same colour whose closure meets the first one's. -/
theorem IsRegion.chain_step {j : Fin k} {C C' : Set ℂ} (h : R.IsRegion (j, C)) (h' : R.IsRegion (j, C'))
    (hmeet : (closure C ∩ closure C').Nonempty) {x : ℂ} (hx : x ∈ R.cls j) (hnear : ∀ s ∈ C, dist x s < 1) :
    ∀ s ∈ C', dist x s < 1 :=
  Plane.chain_step (R.isOpen_cls j) (R.unitPairsNull_cls j) h.subset h'.subset h'.isPreconnected hx hnear hmeet

/-- A region has every two points nearer than `1` (wave 1's FS106-DIAM (i)). -/
theorem IsRegion.dist_lt_one {q : Fin k × Set ℂ} (h : R.IsRegion q) : ∀ x ∈ q.2, ∀ y ∈ q.2, dist x y < 1 :=
  dist_lt_one_of_forall_dist_ne_one h.isPreconnected fun x hx y hy =>
    R.dist_ne_one q.1 x (h.subset hx) y (h.subset hy)

variable (R)

/-- **FS106-TS-T** (SB's form, `plans/FS106-SB-verification.md` § 2.5): every point `z` of an almost-everywhere-proper map has a point
of chromaticity at least `3` within `1/√2 + ε`, for every `ε > 0`. SB's route: the closures of the chain classes of regions (same
colour, closures meeting in sequence) that meet a closed square of side `1 + ε` about `z` are finitely many closed sets of diameter at
most `1` covering it, none meeting two opposite sides; Lebesgue's covering theorem puts a point in three of them, and two classes
of one colour whose closures meet are one class, so the three have three colours. -/
theorem exists_three_le_multicolour (z : ℂ) {ε : ℝ} (hε : 0 < ε) :
    ∃ x, dist x z < 1 / Real.sqrt 2 + ε ∧ 3 ≤ (multicolour R.cls x).ncard := by
  classical
  -- the square of side `s = 1 + ε` centred at `z`
  set s : ℝ := 1 + ε with hs_def
  have hs : 0 < s := by linarith
  set c : ℂ := z - ((s / 2 : ℝ) : ℂ) - ((s / 2 : ℝ) : ℂ) * I with hc_def
  have hcre : c.re = z.re - s / 2 := by simp [hc_def]
  have hcim : c.im = z.im - s / 2 := by simp [hc_def]
  set Q := closedSquare c s with hQ
  have hdistQ : ∀ p ∈ Q, dist p z ^ 2 ≤ s ^ 2 / 2 := by
    rintro p ⟨h1, h2, h3, h4⟩
    rw [Complex.dist_eq, Complex.sq_norm, Complex.normSq_apply]
    simp only [Complex.sub_re, Complex.sub_im]
    rw [hcre] at h1 h2; rw [hcim] at h3 h4
    nlinarith
  have hQclosed : IsClosed Q := by
    have hre := Complex.continuous_re
    have him := Complex.continuous_im
    exact ((isClosed_le continuous_const hre).inter ((isClosed_le hre continuous_const).inter
      ((isClosed_le continuous_const him).inter (isClosed_le him continuous_const))))
  have hQbdd : Bornology.IsBounded Q := by
    refine (Metric.isBounded_closedBall (x := z) (r := s)).subset fun p hp => ?_
    rw [mem_closedBall]
    have h := hdistQ p hp
    nlinarith [dist_nonneg (x := p) (y := z)]
  have hQc : IsCompact Q := Metric.isCompact_of_isClosed_isBounded hQclosed hQbdd
  -- a finite open cover of the square by neighbourhoods meeting finitely many regions
  choose t ht htf using R.locallyFinite
  obtain ⟨u, -, hcover⟩ := hQc.elim_nhds_subcover (fun x => interior (t x)) (fun x _ => interior_mem_nhds.mpr (ht x))
  set U := ⋃ x ∈ u, interior (t x) with hU
  have hUo : IsOpen U := isOpen_biUnion fun _ _ => isOpen_interior
  -- the regions meeting `U`: finitely many
  set 𝒞 : Set (Fin k × Set ℂ) := {q | R.IsRegion q ∧ (q.2 ∩ U).Nonempty} with h𝒞
  have h𝒞f : 𝒞.Finite := by
    have hA : (⋃ x ∈ u, {C : Set ℂ | ∃ j, ∃ y ∈ R.cls j, C = connectedComponentIn (R.cls j) y ∧ (C ∩ t x).Nonempty}).Finite :=
      u.finite_toSet.biUnion fun x _ => htf x
    refine ((Set.finite_univ (α := Fin k)).prod hA).subset ?_
    rintro ⟨j, C⟩ ⟨⟨y, hy, hC⟩, w, hwC, hwU⟩
    simp only [hU, mem_iUnion] at hwU
    obtain ⟨x, hx, hw⟩ := hwU
    refine ⟨mem_univ _, ?_⟩
    simp only [mem_iUnion, mem_setOf_eq]
    exact ⟨x, hx, j, y, hy, hC, w, hwC, interior_subset hw⟩
  haveI : Finite 𝒞 := h𝒞f.to_subtype
  -- the chain relation on those regions, and the closed set of each class
  let r : 𝒞 → 𝒞 → Prop := fun a b => a.1.1 = b.1.1 ∧ (closure a.1.2 ∩ closure b.1.2).Nonempty
  let Fc : 𝒞 → Set ℂ := fun a => ⋃ b ∈ {b : 𝒞 | Relation.EqvGen r a b}, closure b.1.2
  have hcol : ∀ a b, Relation.EqvGen r a b → a.1.1 = b.1.1 := by
    intro a b h
    induction h with
    | rel x y h => exact h.1
    | refl => rfl
    | symm x y _ ih => exact ih.symm
    | trans x y w _ _ ih1 ih2 => exact ih1.trans ih2
  have hFc_eq : ∀ a b, Relation.EqvGen r a b → Fc a = Fc b := by
    intro a b h
    ext p
    simp only [Fc, mem_iUnion, mem_setOf_eq, exists_prop]
    constructor
    · rintro ⟨b', hb', hp⟩; exact ⟨b', Relation.EqvGen.trans _ _ _ (Relation.EqvGen.symm _ _ h) hb', hp⟩
    · rintro ⟨b', hb', hp⟩; exact ⟨b', Relation.EqvGen.trans _ _ _ h hb', hp⟩
  -- along a chain, "within `1` of a whole region" passes from region to region
  have hpass : ∀ a b, Relation.EqvGen r a b → ∀ x ∈ R.cls a.1.1,
      ((∀ y ∈ a.1.2, dist x y < 1) ↔ ∀ y ∈ b.1.2, dist x y < 1) := by
    intro a b h
    induction h with
    | rel a b h =>
      intro x hx
      have ha : R.IsRegion (a.1.1, a.1.2) := a.2.1
      have hb : R.IsRegion (a.1.1, b.1.2) := by rw [h.1]; exact b.2.1
      exact ⟨fun H => ha.chain_step hb h.2 hx H,
        fun H => hb.chain_step ha (by rw [inter_comm]; exact h.2) hx H⟩
    | refl => intro x _; exact Iff.rfl
    | symm a b hab ih =>
      intro x hx
      rw [← hcol a b hab] at hx
      exact (ih x hx).symm
    | trans a b w hab _ ih1 ih2 =>
      intro x hx
      have hx' : x ∈ R.cls b.1.1 := by rw [← hcol a b hab]; exact hx
      exact (ih1 x hx).trans (ih2 x hx')
  have hdiam : ∀ a, ∀ p ∈ Fc a, ∀ q ∈ Fc a, dist p q ≤ 1 := by
    intro a p hp q hq
    simp only [Fc, mem_iUnion, mem_setOf_eq, exists_prop] at hp hq
    obtain ⟨b, hb, hpb⟩ := hp
    obtain ⟨b', hb', hqb'⟩ := hq
    have hbb' : Relation.EqvGen r b b' := Relation.EqvGen.trans _ _ _ (Relation.EqvGen.symm _ _ hb) hb'
    have hnear : ∀ x ∈ b.1.2, ∀ y ∈ b'.1.2, dist x y < 1 := fun x hx =>
      (hpass b b' hbb' x (b.2.1.subset hx)).mp fun y hy => b.2.1.dist_lt_one x hx y hy
    have h1 : ∀ x ∈ b.1.2, closure b'.1.2 ⊆ closedBall x 1 := fun x hx =>
      closure_minimal (fun y hy => by rw [mem_closedBall, dist_comm]; exact (hnear x hx y hy).le) isClosed_closedBall
    have h2 : closure b.1.2 ⊆ closedBall q 1 :=
      closure_minimal (fun x hx => by rw [mem_closedBall, dist_comm]; exact h1 x hx hqb') isClosed_closedBall
    have := h2 hpb
    rwa [mem_closedBall] at this
  have hFc_closed : ∀ a, IsClosed (Fc a) := fun a =>
    Set.Finite.isClosed_biUnion (Set.toFinite _) fun _ _ => isClosed_closure
  -- every point of the square lies in the closure of a region meeting `U`
  have hcovFc : ∀ p ∈ Q, ∃ a, p ∈ Fc a := by
    intro p hp
    have hpU : p ∈ U := hcover hp
    set N := interior (t p) ∩ U with hN
    have hNo : IsOpen N := isOpen_interior.inter hUo
    have hpN : p ∈ N := ⟨mem_interior_iff_mem_nhds.mpr (ht p), hpU⟩
    set 𝒟 : Set (Fin k × Set ℂ) := {q | R.IsRegion q ∧ (q.2 ∩ N).Nonempty} with h𝒟
    have h𝒟f : 𝒟.Finite := by
      refine ((Set.finite_univ (α := Fin k)).prod (htf p)).subset ?_
      rintro ⟨j, C⟩ ⟨⟨y, hy, hC⟩, w, hwC, hwN⟩
      exact ⟨mem_univ _, j, y, hy, hC, w, hwC, interior_subset hwN.1⟩
    have hsub : N ∩ ⋃ j, R.cls j ⊆ ⋃ q ∈ 𝒟, q.2 := by
      rintro y ⟨hyN, hy⟩
      obtain ⟨j, hj⟩ := mem_iUnion.mp hy
      refine mem_biUnion (x := (j, connectedComponentIn (R.cls j) y)) ⟨⟨y, hj, rfl⟩, y, ?_, hyN⟩ ?_ <;>
        exact mem_connectedComponentIn hj
    have hpcl : p ∈ closure (⋃ q ∈ 𝒟, q.2) := closure_mono hsub (hNo.inter_closure ⟨hpN, R.dense p⟩)
    rw [h𝒟f.closure_biUnion] at hpcl
    obtain ⟨q, ⟨hqR, w, hwq, hwN⟩, hpq⟩ := mem_iUnion₂.mp hpcl
    refine ⟨⟨q, hqR, w, hwq, hwN.2⟩, ?_⟩
    simp only [Fc, mem_iUnion, mem_setOf_eq, exists_prop]
    exact ⟨_, Relation.EqvGen.refl _, hpq⟩
  -- the distinct class sets, enumerated
  obtain ⟨m, ⟨eqv⟩⟩ := Finite.exists_equiv_fin (range Fc)
  set G : Fin m → Set ℂ := fun i => (eqv.symm i).1 with hG
  have hGinj : Function.Injective G := fun i j h => eqv.symm.injective (Subtype.ext h)
  have hGrange : ∀ i, ∃ a, G i = Fc a := fun i => by
    obtain ⟨a, ha⟩ := (eqv.symm i).2; exact ⟨a, ha.symm⟩
  have hGof : ∀ a, ∃ i, G i = Fc a := fun a =>
    ⟨eqv ⟨Fc a, a, rfl⟩, by simp [hG]⟩
  have hside : ∀ i, ∀ p ∈ G i, ∀ q ∈ G i, |p.re - q.re| ≤ 1 ∧ |p.im - q.im| ≤ 1 := by
    intro i p hp q hq
    obtain ⟨a, ha⟩ := hGrange i
    rw [ha] at hp hq
    have hd := hdiam a p hp q hq
    rw [Complex.dist_eq] at hd
    exact ⟨by have := Complex.abs_re_le_norm (p - q); rw [Complex.sub_re] at this; linarith,
      by have := Complex.abs_im_le_norm (p - q); rw [Complex.sub_im] at this; linarith⟩
  obtain ⟨p, hpQ, i, j, l, hij, hil, hjl, hpi, hpj, hpl⟩ := lebesgue_covering_square c hs G
    (fun i => by obtain ⟨a, ha⟩ := hGrange i; rw [ha]; exact hFc_closed a)
    (fun p hp => by
      obtain ⟨a, ha⟩ := hcovFc p hp
      obtain ⟨i, hi⟩ := hGof a
      exact mem_iUnion.mpr ⟨i, hi ▸ ha⟩)
    (fun i ⟨⟨z1, ⟨hz1, _⟩, h1⟩, ⟨z2, ⟨hz2, _⟩, h2⟩⟩ => by
      have := (hside i z1 hz1 z2 hz2).1
      rw [h1, h2, show c.re - (c.re + s) = -s by ring, abs_neg, abs_of_pos hs] at this
      linarith)
    (fun i ⟨⟨z1, ⟨hz1, _⟩, h1⟩, ⟨z2, ⟨hz2, _⟩, h2⟩⟩ => by
      have := (hside i z1 hz1 z2 hz2).2
      rw [h1, h2, show c.im - (c.im + s) = -s by ring, abs_neg, abs_of_pos hs] at this
      linarith)
  refine ⟨p, ?_, ?_⟩
  · -- the square lies within `1/√2 + ε` of `z`
    have h2 : (0 : ℝ) < Real.sqrt 2 := Real.sqrt_pos.mpr (by norm_num)
    have h22 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
    have hlt2 : Real.sqrt 2 < 2 := by nlinarith
    have hinv : (1 / Real.sqrt 2) ^ 2 = 1 / 2 := by rw [div_pow, h22]; norm_num
    have hhalf : 1 / 2 < 1 / Real.sqrt 2 := by rw [div_lt_div_iff₀ (by norm_num) h2]; linarith
    have key : dist p z ^ 2 < (1 / Real.sqrt 2 + ε) ^ 2 := by
      have := hdistQ p hpQ
      rw [hs_def] at this
      nlinarith
    exact lt_of_pow_lt_pow_left₀ 2 (by positivity) key
  · -- three classes at `p`, of three colours
    obtain ⟨ai, hai⟩ := hGrange i
    obtain ⟨aj, haj⟩ := hGrange j
    obtain ⟨al, hal⟩ := hGrange l
    rw [hai] at hpi; rw [haj] at hpj; rw [hal] at hpl
    simp only [Fc, mem_iUnion, mem_setOf_eq, exists_prop] at hpi hpj hpl
    obtain ⟨bi, hbi, hpbi⟩ := hpi
    obtain ⟨bj, hbj, hpbj⟩ := hpj
    obtain ⟨bl, hbl, hpbl⟩ := hpl
    have hne : ∀ {i j : Fin m} {ai aj bi bj : 𝒞}, i ≠ j → G i = Fc ai → G j = Fc aj → Relation.EqvGen r ai bi →
        Relation.EqvGen r aj bj → p ∈ closure bi.1.2 → p ∈ closure bj.1.2 → bi.1.1 ≠ bj.1.1 := by
      intro i j ai aj bi bj hij hai haj hbi hbj hpi hpj heq
      apply hij
      apply hGinj
      rw [hai, haj]
      apply hFc_eq
      exact Relation.EqvGen.trans _ _ _ hbi (Relation.EqvGen.trans _ _ _ (Relation.EqvGen.rel _ _ ⟨heq, p, hpi, hpj⟩)
        (Relation.EqvGen.symm _ _ hbj))
    have hm : ∀ b : 𝒞, p ∈ closure b.1.2 → b.1.1 ∈ multicolour R.cls p := fun b hb =>
      closure_mono b.2.1.subset hb
    have h3 : ({bi.1.1, bj.1.1, bl.1.1} : Set (Fin k)).ncard = 3 :=
      Set.ncard_eq_three.mpr ⟨_, _, _, hne hij hai haj hbi hbj hpbi hpbj, hne hil hai hal hbi hbl hpbi hpbl,
        hne hjl haj hal hbj hbl hpbj hpbl, rfl⟩
    rw [← h3]
    refine Set.ncard_le_ncard ?_ (Set.toFinite _)
    rintro x (rfl | rfl | rfl)
    · exact hm bi hpbi
    · exact hm bj hpbj
    · exact hm bl hpbl

/-- **FS106-TS-T** in TS's form (`plans/FS106-TS-derivation.md` § 2.4): a point of chromaticity at least `3` within distance `1`
(strictly). -/
theorem exists_three_le_multicolour_lt_one (z : ℂ) : ∃ x, dist x z < 1 ∧ 3 ≤ (multicolour R.cls x).ncard := by
  obtain ⟨x, hx, h3⟩ := R.exists_three_le_multicolour z (ε := 1 / 5) (by norm_num)
  refine ⟨x, lt_of_lt_of_le hx ?_, h3⟩
  have h54 : 5 / 4 ≤ Real.sqrt 2 := by
    nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ 2 by norm_num), Real.sqrt_nonneg 2]
  have hs : (0 : ℝ) < Real.sqrt 2 := by linarith
  have : 1 / Real.sqrt 2 ≤ 4 / 5 := by rw [div_le_iff₀ hs]; linarith
  linarith

end AeProperRegions

/-! ## FS106-TS-T for arc maps, with Conditions 5 and 6 -/

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- The colours at a point are the multicolour of the colour classes (by definition). -/
theorem coloursAt_eq_multicolour (x : ℂ) : F.coloursAt x = multicolour F.region x := rfl

variable {F}

/-- In a map of the plane, finitely many tiles meet a neighbourhood of each point, and the components of a colour class are its
tiles — so the regions are locally finite (wave 3's `finite_tiles_near`). -/
theorem region_locallyFinite (hP : F.IsPlaneMap) (x : ℂ) : ∃ t ∈ 𝓝 x,
    {C : Set ℂ | ∃ j, ∃ y ∈ F.region j, C = connectedComponentIn (F.region j) y ∧ (C ∩ t).Nonempty}.Finite := by
  obtain ⟨r, hr, hfin⟩ := F.finite_tiles_near (hP ▸ mem_univ x)
  refine ⟨ball x r, ball_mem_nhds x hr, hfin.subset ?_⟩
  rintro C ⟨j, y, hy, rfl, hne⟩
  have hT : F.IsTile (connectedComponentIn F.interiorPts y) := ⟨y, hy.1, rfl⟩
  have hEq : connectedComponentIn (F.region j) y = connectedComponentIn F.interiorPts y := by
    refine le_antisymm (connectedComponentIn_mono y (F.region_subset_interiorPts j)) ?_
    refine hT.isPreconnected.subset_connectedComponentIn (mem_connectedComponentIn hy.1) ?_
    intro z hz
    refine ⟨hT.subset_interiorPts hz, ?_⟩
    have := hT.col_eq hz (mem_connectedComponentIn hy.1)
    rw [mem_preimage, this, hy.2]
    rfl
  rw [hEq] at hne ⊢
  exact ⟨hT, hne⟩

/-- In a map of the plane the colour classes have dense union (wave 3's `dense_interiorPts`). -/
theorem dense_iUnion_region (hP : F.IsPlaneMap) : Dense (⋃ j, F.region j) := by
  have hU : (⋃ j, F.region j) = F.interiorPts := by
    ext z
    simp only [mem_iUnion]
    constructor
    · rintro ⟨j, hj⟩; exact hj.1
    · intro hz; exact ⟨F.col z, hz, rfl⟩
  rw [hU, dense_iff_closure_eq, eq_univ_iff_forall]
  intro x
  exact F.dense_interiorPts (hP ▸ mem_univ x)

/-- **A valid map of the plane gives the regions of an almost-everywhere-proper map**: its colour classes. -/
noncomputable def toAeProperRegions (hF : F.Valid) (hP : F.IsPlaneMap) : AeProperRegions k where
  cls := F.region
  isOpen_cls := F.isOpen_region
  dist_ne_one := fun j x hx y hy hxy => hF x hx.1 y hy.1 hxy (by rw [hx.2, hy.2])
  dense := dense_iUnion_region hP
  locallyFinite := region_locallyFinite hP

/-- **FS106-TS-T for a valid map of the plane**: a point of at least three colours within `1/√2 + ε` of every point. -/
theorem ts_t (hF : F.Valid) (hP : F.IsPlaneMap) (z : ℂ) {ε : ℝ} (hε : 0 < ε) :
    ∃ x, dist x z < 1 / Real.sqrt 2 + ε ∧ 3 ≤ (F.coloursAt x).ncard :=
  (F.toAeProperRegions hF hP).exists_three_le_multicolour z hε

/-- **TS-T's vertex step**: a point of the domain has a finite degree, at least its number of colours (each colour at the point
contributes a sector). So a point of chromaticity `≥ 3` is a vertex of degree `≥ 3`. -/
theorem exists_hasDegree_of_mem_dom {x : ℂ} (hx : x ∈ F.dom) : ∃ n, (F.coloursAt x).ncard ≤ n ∧ F.HasDegree x n :=
  exists_hasDegree_of_chart hx

/-- **FS106-TS-T, Condition 5's clause**, over its conclusion: where every point carries at most three colours (S–V Lemma 2 almost
everywhere under Condition 5 — SB § 2.1 A5, not a backlog row; for arc maps FS110-NB-4's conclusion, as inventory ruling 53 states
FS110-N4-STUCK), the point TS-T finds is trichromatic, of degree at least `3`. -/
theorem ts_t_trichromatic (hF : F.Valid) (hP : F.IsPlaneMap) (h3 : ∀ x, (F.coloursAt x).ncard ≤ 3) (z : ℂ) {ε : ℝ}
    (hε : 0 < ε) : ∃ x, dist x z < 1 / Real.sqrt 2 + ε ∧ (F.coloursAt x).ncard = 3 ∧ ∃ n, 3 ≤ n ∧ F.HasDegree x n := by
  obtain ⟨x, hx, h3x⟩ := ts_t hF hP z hε
  have heq : (F.coloursAt x).ncard = 3 := le_antisymm (h3 x) h3x
  obtain ⟨n, hn, hdeg⟩ := exists_hasDegree_of_mem_dom (F := F) (hP ▸ mem_univ x)
  exact ⟨x, hx, heq, n, heq ▸ hn, hdeg⟩

/-- **FS106-TS-T, Condition 6's clause** (closing S–V Lemma 4 (a) under Conditions 5–6): with at most three colours everywhere and
Condition 6, the point TS-T finds is a trichromatic vertex of degree exactly `3`. -/
theorem ts_t_degree_three (hF : F.Valid) (hP : F.IsPlaneMap) (h3 : ∀ x, (F.coloursAt x).ncard ≤ 3) (h6 : F.Condition6)
    (z : ℂ) {ε : ℝ} (hε : 0 < ε) :
    ∃ x, dist x z < 1 / Real.sqrt 2 + ε ∧ (F.coloursAt x).ncard = 3 ∧ F.HasDegree x 3 := by
  obtain ⟨x, hx, heq, n, hn, hdeg⟩ := ts_t_trichromatic hF hP h3 z hε
  have hn3 : n ≤ 3 := h6 x n heq hdeg
  have : n = 3 := le_antisymm hn3 hn
  exact ⟨x, hx, heq, this ▸ hdeg⟩

end ArcMap

/-! ## The inhabitant: the brick seven-colouring as an arc map of the plane -/

/-- The lower-left corner `((2/5) r + (4/5) c, (3/5) r)` of the cell `(c, r)` of `sevenBrick` (`Instances/Seven`). -/
noncomputable def brickCorner (c r : ℤ) : ℂ := ((2 / 5 * r + 4 / 5 * c : ℝ) : ℂ) + ((3 / 5 * r : ℝ) : ℂ) * I

/-- The cell edges of `sevenBrick`: each cell's bottom edge and left edge. -/
noncomputable def sevenBrickArcs : Set Arc :=
  ⋃ c : ℤ, ⋃ r : ℤ, {Arc.seg (brickCorner c r) (brickCorner (c + 1) r),
    Arc.seg (brickCorner c r) (brickCorner c r + ((3 / 5 : ℝ) : ℂ) * I)}

/-- Every cell edge has positive length. -/
theorem sevenBrickArcs_nondegenerate : ∀ a ∈ sevenBrickArcs, a.Nondegenerate := by
  intro a ha
  simp only [sevenBrickArcs, mem_iUnion, mem_insert_iff, mem_singleton_iff] at ha
  obtain ⟨c, r, rfl | rfl⟩ := ha
  · intro h
    have := congrArg Complex.re h
    simp only [brickCorner, Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.ofReal_im, Complex.I_re,
      Complex.I_im, mul_zero, sub_zero, zero_mul, add_zero, Int.cast_add, Int.cast_one] at this
    linarith
  · intro h
    have := congrArg Complex.im h
    simp [brickCorner] at this

/-- The real part of the cell corner. -/
theorem brickCorner_re (c r : ℤ) : (brickCorner c r).re = 2 / 5 * r + 4 / 5 * c := by
  simp [brickCorner]

/-- The imaginary part of the cell corner. -/
theorem brickCorner_im (c r : ℤ) : (brickCorner c r).im = 3 / 5 * r := by
  simp [brickCorner]

/-- The floor is locally constant at a non-integer. -/
theorem eventually_floor_eq {t : ℝ} (ht : ∀ n : ℤ, t ≠ n) : ∀ᶠ u in 𝓝 t, ⌊u⌋ = ⌊t⌋ := by
  have h1 : (⌊t⌋ : ℝ) < t := lt_of_le_of_ne (Int.floor_le t) (Ne.symm (ht _))
  have h2 : t < ⌊t⌋ + 1 := Int.lt_floor_add_one t
  filter_upwards [Ioo_mem_nhds h1 h2] with u hu
  rw [Int.floor_eq_iff]; exact ⟨hu.1.le, hu.2⟩

/-- The brick height as a real number. -/
theorem sevenBrick_h : ((sevenBrick.h : ℚ) : ℝ) = 3 / 5 := by
  simp [sevenBrick, cosetBrick]

/-- The brick width as a real number. -/
theorem sevenBrick_w : ((sevenBrick.w : ℚ) : ℝ) = 4 / 5 := by
  simp [sevenBrick, cosetBrick]

/-- The brick shear as a real number. -/
theorem sevenBrick_s : ((sevenBrick.s : ℚ) : ℝ) = 2 / 5 := by
  simp [sevenBrick, cosetBrick]

/-- Finitely many cell edges meet a neighbourhood of each point. -/
theorem sevenBrickArcs_locallyFinite : ∀ x ∈ (univ : Set ℂ), ∃ t ∈ 𝓝 x,
    {a | a ∈ sevenBrickArcs ∧ (a.carrier ∩ t).Nonempty}.Finite := by
  intro x _
  refine ⟨ball x 1, ball_mem_nhds x one_pos, ?_⟩
  obtain ⟨B, hB⟩ := exists_nat_gt (|x.im| * 5 / 3 + 3)
  obtain ⟨C, hC⟩ := exists_nat_gt (|x.re| * 5 / 4 + 2 * B + 5)
  let box : Set (ℤ × ℤ) := Icc (-(C : ℤ), -(B : ℤ)) ((C : ℤ), (B : ℤ))
  have hbox : box.Finite := Set.finite_Icc _ _
  let f : ℤ × ℤ × Bool → Arc := fun q =>
    if q.2.2 then Arc.seg (brickCorner q.1 q.2.1) (brickCorner (q.1 + 1) q.2.1)
    else Arc.seg (brickCorner q.1 q.2.1) (brickCorner q.1 q.2.1 + ((3 / 5 : ℝ) : ℂ) * I)
  have hfin : (((fun q : ℤ × ℤ => (q.1, q.2, true)) '' box) ∪ ((fun q : ℤ × ℤ => (q.1, q.2, false)) '' box)).Finite :=
    (hbox.image _).union (hbox.image _)
  refine (hfin.image f).subset ?_
  rintro a ⟨ha, p, hpa, hpx⟩
  rw [mem_ball] at hpx
  have hpx' : |p.re - x.re| < 1 ∧ |p.im - x.im| < 1 := by
    have h1 := Complex.abs_re_le_norm (p - x)
    have h2 := Complex.abs_im_le_norm (p - x)
    rw [← dist_eq_norm] at h1 h2
    exact ⟨by simpa using h1.trans_lt hpx, by simpa using h2.trans_lt hpx⟩
  simp only [sevenBrickArcs, mem_iUnion, mem_insert_iff, mem_singleton_iff] at ha
  obtain ⟨c, r, rfl | rfl⟩ := ha
  · -- bottom edge
    obtain ⟨s, hs, hp⟩ : ∃ s ∈ Icc (0 : ℝ) 1, p = brickCorner c r + (s : ℂ) * (brickCorner (c + 1) r - brickCorner c r) := by
      rw [Arc.carrier, segment_eq_image'] at hpa
      obtain ⟨s, hs, hsp⟩ := hpa
      exact ⟨s, hs, by rw [← hsp]; simp [Complex.real_smul]⟩
    have him : p.im = 3 / 5 * r := by
      rw [hp]; simp [brickCorner]
    have hre : p.re = 2 / 5 * r + 4 / 5 * c + s * (4 / 5) := by
      rw [hp, Complex.add_re, Complex.re_ofReal_mul, Complex.sub_re, brickCorner_re, brickCorner_re]
      push_cast; ring
    have hs0 := hs.1; have hs1 := hs.2
    obtain ⟨hx1, hx2⟩ := abs_lt.mp hpx'.1
    obtain ⟨hy1, hy2⟩ := abs_lt.mp hpx'.2
    have hxa := neg_abs_le x.re; have hxb := le_abs_self x.re
    have hya := neg_abs_le x.im; have hyb := le_abs_self x.im
    have hr1 : (r : ℝ) < B := by rw [him] at hy2; linarith
    have hr2 : -(B : ℝ) < r := by rw [him] at hy1; linarith
    have hc1 : (c : ℝ) < C := by rw [hre] at hx2; linarith
    have hc2 : -(C : ℝ) < c := by rw [hre] at hx1; linarith
    have hrB : r ∈ Icc (-(B : ℤ)) B := ⟨by exact_mod_cast hr2.le, by exact_mod_cast hr1.le⟩
    have hcC : c ∈ Icc (-(C : ℤ)) C := ⟨by exact_mod_cast hc2.le, by exact_mod_cast hc1.le⟩
    refine ⟨(c, r, true), Or.inl ⟨(c, r), ⟨⟨hcC.1, hrB.1⟩, ⟨hcC.2, hrB.2⟩⟩, rfl⟩, ?_⟩
    simp [f]
  · -- left edge
    obtain ⟨s, hs, hp⟩ : ∃ s ∈ Icc (0 : ℝ) 1, p = brickCorner c r + (s : ℂ) * (((3 / 5 : ℝ) : ℂ) * I) := by
      rw [Arc.carrier, segment_eq_image'] at hpa
      obtain ⟨s, hs, hsp⟩ := hpa
      exact ⟨s, hs, by rw [← hsp]; simp [Complex.real_smul]⟩
    have him : p.im = 3 / 5 * r + s * (3 / 5) := by
      rw [hp, Complex.add_im, brickCorner_im]
      simp
    have hre : p.re = 2 / 5 * r + 4 / 5 * c := by
      rw [hp, Complex.add_re, brickCorner_re]
      simp
    have hs0 := hs.1; have hs1 := hs.2
    obtain ⟨hx1, hx2⟩ := abs_lt.mp hpx'.1
    obtain ⟨hy1, hy2⟩ := abs_lt.mp hpx'.2
    have hxa := neg_abs_le x.re; have hxb := le_abs_self x.re
    have hya := neg_abs_le x.im; have hyb := le_abs_self x.im
    have hr1 : (r : ℝ) < B := by rw [him] at hy2; linarith
    have hr2 : -(B : ℝ) < r := by rw [him] at hy1; linarith
    have hc1 : (c : ℝ) < C := by rw [hre] at hx2; linarith
    have hc2 : -(C : ℝ) < c := by rw [hre] at hx1; linarith
    have hrB : r ∈ Icc (-(B : ℤ)) B := ⟨by exact_mod_cast hr2.le, by exact_mod_cast hr1.le⟩
    have hcC : c ∈ Icc (-(C : ℤ)) C := ⟨by exact_mod_cast hc2.le, by exact_mod_cast hc1.le⟩
    refine ⟨(c, r, false), Or.inr ⟨(c, r), ⟨⟨hcC.1, hrB.1⟩, ⟨hcC.2, hrB.2⟩⟩, rfl⟩, ?_⟩
    simp [f]

/-- The brick colour is locally constant off the cell edges. -/
theorem sevenBrick_color_locallyConstant : ∀ x ∈ (univ : Set ℂ), x ∉ ⋃ a ∈ sevenBrickArcs, a.carrier →
    ∀ᶠ y in 𝓝 x, sevenBrick.color y = sevenBrick.color x := by
  intro x _ hx
  have hrow : ∀ n : ℤ, x.im / (3 / 5 : ℝ) ≠ n := by
    intro n hn
    have him : x.im = 3 / 5 * n := by field_simp at hn; linarith
    set c : ℤ := ⌊(x.re - 2 / 5 * n) / (4 / 5)⌋ with hc
    have h0 : (c : ℝ) ≤ (x.re - 2 / 5 * n) / (4 / 5) := Int.floor_le _
    have h1 : (x.re - 2 / 5 * n) / (4 / 5) < c + 1 := Int.lt_floor_add_one _
    refine hx (mem_iUnion₂.mpr ⟨Arc.seg (brickCorner c n) (brickCorner (c + 1) n), ?_, ?_⟩)
    · simp only [sevenBrickArcs, mem_iUnion, mem_insert_iff, mem_singleton_iff]
      exact ⟨c, n, Or.inl rfl⟩
    · rw [Arc.carrier, segment_eq_image']
      refine ⟨(x.re - 2 / 5 * n - 4 / 5 * c) / (4 / 5), ⟨?_, ?_⟩, ?_⟩
      · rw [le_div_iff₀ (by norm_num)]; rw [div_lt_iff₀ (by norm_num)] at h1; rw [le_div_iff₀ (by norm_num)] at h0; linarith
      · rw [div_le_one (by norm_num)]; rw [div_lt_iff₀ (by norm_num)] at h1; linarith
      · apply Complex.ext
        · simp only [Complex.add_re, Complex.smul_re, Complex.sub_re, smul_eq_mul, brickCorner_re]
          push_cast; field_simp; ring
        · simp only [Complex.add_im, Complex.smul_im, Complex.sub_im, smul_eq_mul, brickCorner_im]
          rw [him]; ring
  have hrowE : ∀ᶠ y in 𝓝 x, sevenBrick.row y = sevenBrick.row x := by
    have hcont : Tendsto (fun y : ℂ => y.im / (3 / 5 : ℝ)) (𝓝 x) (𝓝 (x.im / (3 / 5 : ℝ))) :=
      ((Complex.continuous_im.div_const _).tendsto x)
    filter_upwards [hcont.eventually (eventually_floor_eq hrow)] with y hy
    unfold Brick.row; rw [sevenBrick_h]; exact hy
  set r := sevenBrick.row x with hr
  have hrr : (r : ℝ) < x.im / (3 / 5) ∧ x.im / (3 / 5) < r + 1 := by
    have h1 : (r : ℝ) ≤ x.im / (3 / 5) := by rw [hr]; unfold Brick.row; rw [sevenBrick_h]; exact Int.floor_le _
    have h2 : x.im / (3 / 5) < r + 1 := by rw [hr]; unfold Brick.row; rw [sevenBrick_h]; exact Int.lt_floor_add_one _
    exact ⟨lt_of_le_of_ne h1 (fun h => hrow r h.symm), h2⟩
  have hcol : ∀ n : ℤ, (x.re - 2 / 5 * r) / (4 / 5) ≠ n := by
    intro n hn
    have hre : x.re = 2 / 5 * r + 4 / 5 * n := by field_simp at hn; linarith
    obtain ⟨hr1, hr2⟩ := hrr
    rw [lt_div_iff₀ (by norm_num)] at hr1; rw [div_lt_iff₀ (by norm_num)] at hr2
    refine hx (mem_iUnion₂.mpr ⟨Arc.seg (brickCorner n r) (brickCorner n r + ((3 / 5 : ℝ) : ℂ) * I), ?_, ?_⟩)
    · simp only [sevenBrickArcs, mem_iUnion, mem_insert_iff, mem_singleton_iff]
      exact ⟨n, r, Or.inr rfl⟩
    · rw [Arc.carrier, segment_eq_image']
      refine ⟨(x.im - 3 / 5 * r) / (3 / 5), ⟨?_, ?_⟩, ?_⟩
      · exact div_nonneg (by linarith) (by norm_num)
      · rw [div_le_one (by norm_num)]; linarith
      · apply Complex.ext
        · simp only [Complex.add_re, Complex.sub_re, Complex.smul_re, smul_eq_mul, brickCorner_re, Complex.mul_re, Complex.ofReal_re,
            Complex.ofReal_im, Complex.I_re, Complex.I_im]
          rw [hre]; ring
        · simp only [Complex.add_im, Complex.sub_im, Complex.smul_im, smul_eq_mul, brickCorner_im, Complex.mul_im, Complex.ofReal_re,
            Complex.ofReal_im, Complex.I_re, Complex.I_im]
          field_simp; ring
  have hcolE : ∀ᶠ y in 𝓝 x, ⌊(y.re - 2 / 5 * (r : ℝ)) / (4 / 5)⌋ = ⌊(x.re - 2 / 5 * (r : ℝ)) / (4 / 5)⌋ := by
    have hcont : Tendsto (fun y : ℂ => (y.re - 2 / 5 * (r : ℝ)) / (4 / 5)) (𝓝 x) (𝓝 ((x.re - 2 / 5 * (r : ℝ)) / (4 / 5))) :=
      (((Complex.continuous_re.sub continuous_const).div_const _).tendsto x)
    exact hcont.eventually (eventually_floor_eq hcol)
  filter_upwards [hrowE, hcolE] with y hy1 hy2
  have hcy : sevenBrick.col y = sevenBrick.col x := by
    unfold Brick.col
    rw [hy1, sevenBrick_s, sevenBrick_w]
    exact hy2
  unfold Brick.color
  rw [hcy, hy1]

/-- **The brick seven-colouring as an arc map of the plane** — the inhabitant of "a valid map of the plane". -/
noncomputable def sevenBrickMap : ArcMap 7 where
  dom := univ
  isOpen_dom := isOpen_univ
  arcs := sevenBrickArcs
  nondegenerate := sevenBrickArcs_nondegenerate
  locallyFinite := sevenBrickArcs_locallyFinite
  col := sevenBrick.color
  locallyConstant := sevenBrick_color_locallyConstant

/-- `sevenBrickMap` is a map of the plane. -/
theorem sevenBrickMap_isPlaneMap : sevenBrickMap.IsPlaneMap := rfl

/-- `sevenBrickMap` is valid: the brick colouring is proper at every unit pair (`Brick.avoids`, M36). -/
theorem sevenBrickMap_valid : sevenBrickMap.Valid := fun x _ y _ hxy =>
  sevenBrick.avoids (List.mem_singleton.mpr rfl) sevenBrick_check (by rw [hxy]; simp)

/-! ## The brick corner: a cubic trichromatic vertex, with an M-in point (FS131-QA2's QA2-2)

At the corner `0 = brickCorner 0 0` three cells meet in a T: the upper right cell `(0, 0)` (colour `0`), the upper left `(−1, 0)`
(colour `6`), and the lower `(0, −1)` (colour `4`), whose top edge runs through `0`. So `0` has degree `3` and three colours
(`tools/fs131_qa2_brick.py`, check 1–2), and the far corner `4/5 + 3/5 i` of the upper right cell is at distance exactly `1` (3–4–5),
an M-in point of `0` (check 3). -/

/-- A point is on no cell edge when its height is not a multiple of `3/5` and its sheared abscissa `re − (2/5)⌊im/(3/5)⌋` is not a
multiple of `4/5`. -/
theorem not_mem_sevenBrickArcs {z : ℂ} (hrow : ∀ n : ℤ, z.im ≠ 3 / 5 * n)
    (hcol : ∀ n : ℤ, z.re - 2 / 5 * ⌊z.im / (3 / 5)⌋ ≠ 4 / 5 * n) : z ∉ ⋃ a ∈ sevenBrickArcs, a.carrier := by
  simp only [mem_iUnion, exists_prop, not_exists, not_and]
  intro a ha hz
  simp only [sevenBrickArcs, mem_iUnion, mem_insert_iff, mem_singleton_iff] at ha
  obtain ⟨c, r, rfl | rfl⟩ := ha
  · obtain ⟨s, t, -, -, hst, rfl⟩ := hz
    apply hrow r
    simp only [Complex.add_im, Complex.smul_im, smul_eq_mul, brickCorner_im]
    linear_combination (3 / 5 * (r : ℝ)) * hst
  · obtain ⟨s, t, hs, ht, hst, rfl⟩ := hz
    set z := s • brickCorner c r + t • (brickCorner c r + ((3 / 5 : ℝ) : ℂ) * I) with hz
    have him : z.im = 3 / 5 * r + 3 / 5 * t := by
      simp only [hz, Complex.add_im, Complex.smul_im, smul_eq_mul, brickCorner_im, Complex.mul_im, Complex.ofReal_re,
        Complex.ofReal_im, Complex.I_re, Complex.I_im]
      linear_combination (3 / 5 * (r : ℝ)) * hst
    have hre : z.re = 2 / 5 * r + 4 / 5 * c := by
      simp only [hz, Complex.add_re, Complex.smul_re, smul_eq_mul, brickCorner_re, Complex.mul_re, Complex.ofReal_re,
        Complex.ofReal_im, Complex.I_re, Complex.I_im]
      linear_combination (2 / 5 * (r : ℝ) + 4 / 5 * c) * hst
    rcases eq_or_lt_of_le ht with ht0 | ht0
    · exact hrow r (by rw [him, ← ht0]; ring)
    rcases eq_or_lt_of_le (show t ≤ 1 by linarith) with ht1 | ht1
    · exact hrow (r + 1) (by rw [him, ht1]; push_cast; ring)
    have hfl : ⌊z.im / (3 / 5)⌋ = r := by
      rw [Int.floor_eq_iff, him]
      constructor <;> · field_simp; linarith
    apply hcol c
    rw [hfl, hre]; ring

/-- A horizontal cell edge holds the points of its line between its ends. -/
theorem mem_sevenBrickArcs_of_bottom {c r : ℤ} {z : ℂ} (him : z.im = 3 / 5 * r)
    (hlo : 2 / 5 * r + 4 / 5 * c ≤ z.re) (hhi : z.re ≤ 2 / 5 * r + 4 / 5 * (c + 1)) : z ∈ ⋃ a ∈ sevenBrickArcs, a.carrier := by
  refine mem_iUnion₂.mpr ⟨Arc.seg (brickCorner c r) (brickCorner (c + 1) r), ?_, ?_⟩
  · simp only [sevenBrickArcs, mem_iUnion, mem_insert_iff, mem_singleton_iff]; exact ⟨c, r, Or.inl rfl⟩
  · set t := (z.re - (2 / 5 * r + 4 / 5 * c)) / (4 / 5) with ht
    have ht0 : 0 ≤ t := by rw [ht]; apply div_nonneg <;> linarith
    have ht1 : t ≤ 1 := by rw [ht, div_le_one (by norm_num)]; linarith
    refine ⟨1 - t, t, by linarith, ht0, by ring, ?_⟩
    apply Complex.ext
    · simp only [Complex.add_re, Complex.smul_re, smul_eq_mul, brickCorner_re]; push_cast; rw [ht]; field_simp; ring
    · simp only [Complex.add_im, Complex.smul_im, smul_eq_mul, brickCorner_im, him]; ring

/-- A vertical cell edge holds the points of its line between its ends. -/
theorem mem_sevenBrickArcs_of_left {c r : ℤ} {z : ℂ} (hre : z.re = 2 / 5 * r + 4 / 5 * c)
    (hlo : 3 / 5 * r ≤ z.im) (hhi : z.im ≤ 3 / 5 * r + 3 / 5) : z ∈ ⋃ a ∈ sevenBrickArcs, a.carrier := by
  refine mem_iUnion₂.mpr ⟨Arc.seg (brickCorner c r) (brickCorner c r + ((3 / 5 : ℝ) : ℂ) * I), ?_, ?_⟩
  · simp only [sevenBrickArcs, mem_iUnion, mem_insert_iff, mem_singleton_iff]; exact ⟨c, r, Or.inr rfl⟩
  · set t := (z.im - 3 / 5 * r) / (3 / 5) with ht
    have ht0 : 0 ≤ t := by rw [ht]; apply div_nonneg <;> linarith
    have ht1 : t ≤ 1 := by rw [ht, div_le_one (by norm_num)]; linarith
    refine ⟨1 - t, t, by linarith, ht0, by ring, ?_⟩
    apply Complex.ext
    · simp only [Complex.add_re, Complex.smul_re, smul_eq_mul, brickCorner_re, Complex.mul_re, Complex.ofReal_re,
        Complex.ofReal_im, Complex.I_re, Complex.I_im, hre]; ring
    · simp only [Complex.add_im, Complex.smul_im, smul_eq_mul, brickCorner_im, Complex.mul_im, Complex.ofReal_re,
        Complex.ofReal_im, Complex.I_re, Complex.I_im]; rw [ht]; field_simp; ring

/-- The three cells at the corner `0`, within `ρ`: upper right (colour `0`), upper left (colour `6`), lower (colour `4`). -/
def brickCornerSector (ρ : ℝ) : Fin 3 → Set ℂ :=
  ![ball 0 ρ ∩ {z | 0 < z.re} ∩ {z | 0 < z.im}, ball 0 ρ ∩ {z | z.re < 0} ∩ {z | 0 < z.im}, ball 0 ρ ∩ {z | z.im < 0}]

theorem mem_brickCornerSector_iUnion {ρ : ℝ} {z : ℂ} : z ∈ ⋃ i, brickCornerSector ρ i ↔
    (z ∈ ball 0 ρ ∧ 0 < z.re ∧ 0 < z.im) ∨ (z ∈ ball 0 ρ ∧ z.re < 0 ∧ 0 < z.im) ∨ (z ∈ ball 0 ρ ∧ z.im < 0) := by
  rw [mem_iUnion]
  constructor
  · rintro ⟨i, hi⟩
    fin_cases i
    · exact Or.inl ⟨hi.1.1, hi.1.2, hi.2⟩
    · exact Or.inr (Or.inl ⟨hi.1.1, hi.1.2, hi.2⟩)
    · exact Or.inr (Or.inr ⟨hi.1, hi.2⟩)
  · rintro (⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2⟩)
    · exact ⟨0, ⟨h1, h2⟩, h3⟩
    · exact ⟨1, ⟨h1, h2⟩, h3⟩
    · exact ⟨2, h1, h2⟩

theorem brickCornerSector_subset_ball (ρ : ℝ) (i : Fin 3) : brickCornerSector ρ i ⊆ ball 0 ρ := by
  fin_cases i
  · exact fun z h => h.1.1
  · exact fun z h => h.1.1
  · exact fun z h => h.1

/-- Points of a ball of radius at most `1/5` about `0` have both coordinates below `1/5` in size. -/
theorem abs_re_im_lt_of_mem_ball {ρ : ℝ} (hρ : ρ ≤ 1 / 5) {z : ℂ} (hz : z ∈ ball (0 : ℂ) ρ) :
    |z.re| < 1 / 5 ∧ |z.im| < 1 / 5 := by
  rw [mem_ball_zero_iff] at hz
  exact ⟨(Complex.abs_re_le_norm z).trans_lt (hz.trans_le hρ), (Complex.abs_im_le_norm z).trans_lt (hz.trans_le hρ)⟩

/-- **The interior points near the corner are the three cells**: for `0 < ρ ≤ 1/5` the interior points of `B(0, ρ)` are the three
corner sectors — the edges there are the horizontal line and the vertical half-line up from `0`. -/
theorem sevenBrick_corner_interior {ρ : ℝ} (hρ : ρ ≤ 1 / 5) :
    sevenBrickMap.interiorPts ∩ ball 0 ρ = ⋃ i, brickCornerSector ρ i := by
  have hint : ∀ z, z ∈ sevenBrickMap.interiorPts ↔ z ∉ ⋃ a ∈ sevenBrickArcs, a.carrier := fun z =>
    ⟨fun h => h.2, fun h => ⟨mem_univ z, h⟩⟩
  ext z
  rw [mem_inter_iff, hint, mem_brickCornerSector_iUnion]
  constructor
  · rintro ⟨hz, hb⟩
    obtain ⟨hre, him⟩ := abs_re_im_lt_of_mem_ball hρ hb
    rcases lt_trichotomy z.im 0 with h | h | h
    · exact Or.inr (Or.inr ⟨hb, h⟩)
    · exfalso
      rcases le_or_gt 0 z.re with h0 | h0
      · exact hz (mem_sevenBrickArcs_of_bottom (c := 0) (r := 0) (by rw [h]; simp) (by simpa using h0)
          (by push_cast; linarith [(abs_lt.mp hre).2]))
      · exact hz (mem_sevenBrickArcs_of_bottom (c := -1) (r := 0) (by rw [h]; simp)
          (by push_cast; linarith [(abs_lt.mp hre).1]) (by push_cast; linarith))
    · rcases lt_trichotomy z.re 0 with h' | h' | h'
      · exact Or.inr (Or.inl ⟨hb, h', h⟩)
      · exfalso
        exact hz (mem_sevenBrickArcs_of_left (c := 0) (r := 0) (by rw [h']; simp) (by simpa using h.le)
          (by push_cast; linarith [(abs_lt.mp him).2]))
      · exact Or.inl ⟨hb, h', h⟩
  · have hupper : ∀ z : ℂ, z ∈ ball (0 : ℂ) ρ → 0 < z.im → z.re ≠ 0 → z ∉ ⋃ a ∈ sevenBrickArcs, a.carrier := by
      intro z hb him0 hre0
      obtain ⟨hre, him⟩ := abs_re_im_lt_of_mem_ball hρ hb
      have hfl : ⌊z.im / (3 / 5)⌋ = 0 := by
        rw [Int.floor_eq_iff]; push_cast; rw [zero_add]
        constructor
        · exact div_nonneg him0.le (by norm_num)
        · rw [div_lt_one (by norm_num)]; linarith [(abs_lt.mp him).2]
      refine not_mem_sevenBrickArcs (fun n hn => ?_) (fun n hn => ?_)
      · rcases lt_or_ge 0 n with hn0 | hn0
        · have : (1 : ℝ) ≤ n := by exact_mod_cast hn0
          linarith [(abs_lt.mp him).2]
        · have : (n : ℝ) ≤ 0 := by exact_mod_cast hn0
          linarith
      · rw [hfl] at hn; push_cast at hn
        rcases lt_trichotomy n 0 with hn0 | hn0 | hn0
        · have : (n : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_of_lt hn0
          linarith [(abs_lt.mp hre).1]
        · rw [hn0] at hn; push_cast at hn; exact hre0 (by linarith)
        · have : (1 : ℝ) ≤ n := by exact_mod_cast hn0
          linarith [(abs_lt.mp hre).2]
    rintro (⟨hb, hre, him⟩ | ⟨hb, hre, him⟩ | ⟨hb, him⟩)
    · exact ⟨hupper z hb him hre.ne', hb⟩
    · exact ⟨hupper z hb him hre.ne, hb⟩
    · refine ⟨?_, hb⟩
      obtain ⟨hre, him'⟩ := abs_re_im_lt_of_mem_ball hρ hb
      have hfl : ⌊z.im / (3 / 5)⌋ = -1 := by
        rw [Int.floor_eq_iff]; push_cast
        constructor
        · rw [le_div_iff₀ (by norm_num)]; linarith [(abs_lt.mp him').1]
        · rw [div_lt_iff₀ (by norm_num)]; linarith
      refine not_mem_sevenBrickArcs (fun n hn => ?_) (fun n hn => ?_)
      · rcases lt_or_ge n 0 with hn0 | hn0
        · have : (n : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_of_lt hn0
          linarith [(abs_lt.mp him').1]
        · have : (0 : ℝ) ≤ n := by exact_mod_cast hn0
          linarith
      · rw [hfl] at hn; push_cast at hn
        rcases lt_or_ge 0 n with hn0 | hn0
        · have : (1 : ℝ) ≤ n := by exact_mod_cast hn0
          linarith [(abs_lt.mp hre).2]
        · have : (n : ℝ) ≤ 0 := by exact_mod_cast hn0
          linarith [(abs_lt.mp hre).1]

/-- The corner sectors' representatives `t(1 + i)`, `t(−1 + i)`, `−t i`, for `0 < t`. -/
noncomputable def brickCornerPt (t : ℝ) : Fin 3 → ℂ := ![(t : ℂ) + (t : ℂ) * I, -(t : ℂ) + (t : ℂ) * I, -((t : ℂ) * I)]

theorem brickCornerPt_mem {ρ t : ℝ} (ht : 0 < t) (htρ : 2 * t < ρ) (i : Fin 3) : brickCornerPt t i ∈ brickCornerSector ρ i := by
  have hn : ∀ a b : ℝ, |a| ≤ t → |b| ≤ t → ‖(a : ℂ) + (b : ℂ) * I‖ < ρ := by
    intro a b ha hb
    calc ‖(a : ℂ) + (b : ℂ) * I‖ ≤ ‖(a : ℂ)‖ + ‖(b : ℂ) * I‖ := norm_add_le _ _
      _ = |a| + |b| := by rw [norm_mul, Complex.norm_I, mul_one, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs,
          Real.norm_eq_abs]
      _ < ρ := by linarith
  fin_cases i
  · refine ⟨⟨mem_ball_zero_iff.mpr (hn t t (abs_of_pos ht).le (abs_of_pos ht).le), by simp [brickCornerPt, ht]⟩, by
      simp [brickCornerPt, ht]⟩
  · refine ⟨⟨mem_ball_zero_iff.mpr ?_, by simp [brickCornerPt, ht]⟩, by simp [brickCornerPt, ht]⟩
    have := hn (-t) t (by rw [abs_neg, abs_of_pos ht]) (abs_of_pos ht).le
    simpa [brickCornerPt] using this
  · refine ⟨mem_ball_zero_iff.mpr ?_, by simp [brickCornerPt, ht]⟩
    have := hn 0 (-t) (by simp; exact ht.le) (by rw [abs_neg, abs_of_pos ht])
    simpa [brickCornerPt] using this

/-- **The brick corner has degree `3`**: for every `ρ ≤ 1/5` its sectors are the three cells. -/
theorem sevenBrick_corner_hasDegree : sevenBrickMap.HasDegree 0 3 := by
  filter_upwards [Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 5 by norm_num)] with ρ hρ
  refine ArcMap.encard_sectors_of_partition (sevenBrick_corner_interior hρ.2) (fun i => ?_) (fun i => ?_)
    (fun i j hij => ?_) (fun i => ⟨_, brickCornerPt_mem (t := ρ / 4) (by linarith [hρ.1]) (by linarith [hρ.1]) i⟩)
    (fun i => ?_)
  · fin_cases i
    · exact (isOpen_ball.inter (isOpen_lt continuous_const Complex.continuous_re)).inter
        (isOpen_lt continuous_const Complex.continuous_im)
    · exact (isOpen_ball.inter (isOpen_lt Complex.continuous_re continuous_const)).inter
        (isOpen_lt continuous_const Complex.continuous_im)
    · exact isOpen_ball.inter (isOpen_lt Complex.continuous_im continuous_const)
  · fin_cases i
    · exact (((convex_ball _ _).inter (convex_halfSpace_re_gt 0)).inter (convex_halfSpace_im_gt 0)).isPreconnected
    · exact (((convex_ball _ _).inter (convex_halfSpace_re_lt 0)).inter (convex_halfSpace_im_gt 0)).isPreconnected
    · exact ((convex_ball _ _).inter (convex_halfSpace_im_lt 0)).isPreconnected
  · rw [disjoint_left]
    intro z hzi hzj
    fin_cases i <;> fin_cases j <;> simp_all [brickCornerSector] <;> linarith
  · rw [Metric.mem_closure_iff]
    intro ε hε
    set t := min (ε / 4) (ρ / 4) with ht
    have ht0 : 0 < t := lt_min (by linarith) (by linarith [hρ.1])
    refine ⟨brickCornerPt t i, brickCornerPt_mem ht0 (by linarith [min_le_right (ε / 4) (ρ / 4), hρ.1]) i, ?_⟩
    have hmem := brickCornerPt_mem (ρ := ε) ht0 (by linarith [min_le_left (ε / 4) (ρ / 4)]) i
    have hb : brickCornerPt t i ∈ ball (0 : ℂ) ε := brickCornerSector_subset_ball ε i hmem
    rw [dist_comm]; exact hb

/-- The brick colour of a point of a cell: column `c`, row `r` (both read by the floors). -/
theorem sevenBrick_color_eq {z : ℂ} {c r : ℤ} (hr : ⌊z.im / (3 / 5)⌋ = r) (hc : ⌊(z.re - 2 / 5 * r) / (4 / 5)⌋ = c) :
    sevenBrickMap.col z = sevenBrick.table (zmodIdx 7 (by norm_num) c) (zmodIdx 7 (by norm_num) r) := by
  have hrow : sevenBrick.row z = r := by
    show ⌊z.im / ((sevenBrick.h : ℚ) : ℝ)⌋ = r
    rw [sevenBrick_h]; exact hr
  have hcol : sevenBrick.col z = c := by
    show ⌊(z.re - ((sevenBrick.s : ℚ) : ℝ) * sevenBrick.row z) / ((sevenBrick.w : ℚ) : ℝ)⌋ = c
    rw [sevenBrick_s, sevenBrick_w, hrow]; exact hc
  show sevenBrick.color z = _
  unfold Brick.color
  rw [hcol, hrow]; rfl

/-- The colours of the three corner cells: `0`, `6`, `4`. -/
theorem sevenBrick_corner_col {ρ : ℝ} (hρ : ρ ≤ 1 / 5) {z : ℂ} :
    (z ∈ brickCornerSector ρ 0 → sevenBrickMap.col z = 0) ∧ (z ∈ brickCornerSector ρ 1 → sevenBrickMap.col z = 6) ∧
      (z ∈ brickCornerSector ρ 2 → sevenBrickMap.col z = 4) := by
  refine ⟨fun hz => ?_, fun hz => ?_, fun hz => ?_⟩
  · obtain ⟨⟨hb, hre⟩, him⟩ := hz
    have hre : 0 < z.re := hre
    have him : 0 < z.im := him
    obtain ⟨hre', him'⟩ := abs_re_im_lt_of_mem_ball hρ hb
    rw [sevenBrick_color_eq (c := 0) (r := 0)]
    · decide
    · rw [Int.floor_eq_iff]; push_cast; rw [zero_add]; constructor
      · exact div_nonneg him.le (by norm_num)
      · rw [div_lt_one (by norm_num)]; linarith [(abs_lt.mp him').2]
    · rw [Int.floor_eq_iff]; push_cast; rw [zero_add]; simp only [mul_zero, sub_zero]; constructor
      · exact div_nonneg hre.le (by norm_num)
      · rw [div_lt_one (by norm_num)]; linarith [(abs_lt.mp hre').2]
  · obtain ⟨⟨hb, hre⟩, him⟩ := hz
    have hre : z.re < 0 := hre
    have him : 0 < z.im := him
    obtain ⟨hre', him'⟩ := abs_re_im_lt_of_mem_ball hρ hb
    rw [sevenBrick_color_eq (c := -1) (r := 0)]
    · decide
    · rw [Int.floor_eq_iff]; push_cast; rw [zero_add]; constructor
      · exact div_nonneg him.le (by norm_num)
      · rw [div_lt_one (by norm_num)]; linarith [(abs_lt.mp him').2]
    · rw [Int.floor_eq_iff]; push_cast; simp only [mul_zero, sub_zero]; constructor
      · rw [le_div_iff₀ (by norm_num)]; linarith [(abs_lt.mp hre').1]
      · rw [div_lt_iff₀ (by norm_num)]; linarith
  · obtain ⟨hb, him⟩ := hz
    have him : z.im < 0 := him
    obtain ⟨hre', him'⟩ := abs_re_im_lt_of_mem_ball hρ hb
    rw [sevenBrick_color_eq (c := 0) (r := -1)]
    · decide
    · rw [Int.floor_eq_iff]; push_cast; constructor
      · rw [le_div_iff₀ (by norm_num)]; linarith [(abs_lt.mp him').1]
      · rw [div_lt_iff₀ (by norm_num)]; linarith
    · rw [Int.floor_eq_iff]; push_cast; constructor
      · rw [le_div_iff₀ (by norm_num)]; linarith [(abs_lt.mp hre').1]
      · rw [div_lt_iff₀ (by norm_num)]; linarith [(abs_lt.mp hre').2]

/-- **The brick corner carries three colours**: `P_cl(0) = {0, 6, 4}`. -/
theorem sevenBrick_corner_coloursAt : sevenBrickMap.coloursAt 0 = {0, 6, 4} := by
  have h5 : (1 / 5 : ℝ) ≤ 1 / 5 := le_rfl
  have hU := sevenBrick_corner_interior h5
  ext j
  simp only [mem_insert_iff, mem_singleton_iff]
  constructor
  · intro hj
    obtain ⟨z, hz, hzd⟩ := Metric.mem_closure_iff.mp hj (1 / 5) (by norm_num)
    have hzU : z ∈ sevenBrickMap.interiorPts ∩ ball 0 (1 / 5) := ⟨hz.1, by rw [mem_ball, dist_comm]; exact hzd⟩
    rw [hU] at hzU
    obtain ⟨i, hi⟩ := mem_iUnion.mp hzU
    have hzj : sevenBrickMap.col z = j := hz.2
    obtain ⟨h0, h1, h2⟩ := sevenBrick_corner_col h5 (z := z)
    fin_cases i
    · left; rw [← hzj]; exact h0 hi
    · right; left; rw [← hzj]; exact h1 hi
    · right; right; rw [← hzj]; exact h2 hi
  · have key : ∀ i : Fin 3, sevenBrickMap.col (brickCornerPt (1 / 40) i) ∈ sevenBrickMap.coloursAt 0 := by
      intro i
      rw [ArcMap.coloursAt, mem_setOf_eq, Metric.mem_closure_iff]
      intro ε hε
      set t := min (ε / 4) (1 / 40) with ht
      have ht0 : 0 < t := lt_min (by linarith) (by norm_num)
      have hmem := brickCornerPt_mem (ρ := 1 / 5) ht0 (by linarith [min_le_right (ε / 4) (1 / 40)]) i
      have hmem' := brickCornerPt_mem (ρ := 1 / 5) (t := 1 / 40) (by norm_num) (by norm_num) i
      have hint : brickCornerPt t i ∈ sevenBrickMap.interiorPts := by
        have : brickCornerPt t i ∈ ⋃ i, brickCornerSector (1 / 5) i := mem_iUnion.mpr ⟨i, hmem⟩
        rw [← hU] at this; exact this.1
      have hball := brickCornerPt_mem (ρ := ε) ht0 (by linarith [min_le_left (ε / 4) (1 / 40)]) i
      obtain ⟨h0, h1, h2⟩ := sevenBrick_corner_col h5 (z := brickCornerPt t i)
      obtain ⟨h0', h1', h2'⟩ := sevenBrick_corner_col h5 (z := brickCornerPt (1 / 40) i)
      refine ⟨brickCornerPt t i, ⟨hint, ?_⟩, ?_⟩
      · show sevenBrickMap.col _ = sevenBrickMap.col _
        fin_cases i
        · rw [h0 hmem, h0' hmem']
        · rw [h1 hmem, h1' hmem']
        · rw [h2 hmem, h2' hmem']
      · rw [dist_comm]; exact brickCornerSector_subset_ball ε i hball
    obtain ⟨h0, h1, h2⟩ := sevenBrick_corner_col h5 (z := brickCornerPt (1 / 40) 0)
    rintro (rfl | rfl | rfl)
    · have := key 0
      rwa [h0 (brickCornerPt_mem (by norm_num) (by norm_num) 0)] at this
    · have := key 1
      rwa [(sevenBrick_corner_col h5).2.1 (brickCornerPt_mem (by norm_num) (by norm_num) 1)] at this
    · have := key 2
      rwa [(sevenBrick_corner_col h5).2.2 (brickCornerPt_mem (by norm_num) (by norm_num) 2)] at this

/-- **The brick corner is a cubic trichromatic vertex** (FS131-QA2's QA2-2): the inhabitant of `IsCubicTrichromatic` on a valid map of
the plane at `k = 7`, for `pair_i`, `pair_ii`, `pair_P'`, `fail_*`, `anti`. -/
theorem sevenBrick_corner_isCubicTrichromatic : sevenBrickMap.IsCubicTrichromatic 0 := by
  refine ⟨sevenBrick_corner_hasDegree, ?_⟩
  rw [sevenBrick_corner_coloursAt]
  rw [ncard_insert_of_notMem (by decide), ncard_insert_of_notMem (by decide), ncard_singleton]


/-- The regions of an almost-everywhere-proper map exist: `sevenBrickMap`'s (the inhabitant of `AeProperRegions`). -/
noncomputable def sevenBrickRegions : AeProperRegions 7 :=
  sevenBrickMap.toAeProperRegions sevenBrickMap_valid sevenBrickMap_isPlaneMap

end HadwigerNelson.Plane
