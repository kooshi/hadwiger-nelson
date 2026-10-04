import Proofs.HadwigerNelson.Plane.Tiles
import Proofs.HadwigerNelson.Plane.Chord
import Proofs.HadwigerNelson.Plane.SixFragment
import Mathlib.Analysis.Real.Pi.Bounds

/-!
# The ring of a point: twist, the closed set `D`, germs and cones, change points, (Q)-free and five- and six-colour rings,
# touch points, the echo, unit arcs' cones, the flank

Wave 3's ring rows (`plans/FS131-w3-kernel-plan.md`, stage 3), Siamese pairs allowed throughout. Each is stated at the class
its argument reads (inventory items 26–27): where a hypothesis of the row is idle it is dropped, and where the argument reads
the number of colours absent at `p` rather than the number of colours, the theorem is stated at every `k` with that count (the
row is the instance `k = 6`). The rows' "on a closed disc of radius above 1 about `p`" is `F.Covers p 1`
(`ArcMap.covers_one_iff`), and "a vertex of at least four colours" is `4 ≤ (F.coloursAt p).ncard`.

| row | declarations |
|---|---|
| FS116-V4-TWIST | `not_germIn_closure_rotate`, `not_mem_coloursAt_of_mem_sphere` |
| FS116-N1-TWIST-D | `ringD`, `isClosed_ringD`, `finite_ringD_off_ringArc`, `ringD_subset_Γ` |
| FS116-N1-GERM-R | `germR_vMinus`, `germR_vPlus`, `germR_uMinus`, `germR_uPlus` |
| FS116-N1-GERM-S | `germS_absent`, `germS_inward`, `germS_outward`, `germS_four` |
| FS116-RING-Q-PRIME-S (carrying FS116-RING-Q-PRIME) | `ringQPrimeS` |
| FS116-N1-QFREE4 | `qfree4` |
| FS116-N2-FIVERING (carrying FS112-SIX's and FS116-RING-TRANSFER-C's five-colour clauses) | `fiveRing_no_changePoint`, `fiveRing_finite_off_Q`, `fiveRing_length`, `fiveRing_no_hub` |
| FS129-SR1-SIXQ (carrying FS112-SIX's six-colour clause) | `sixQ_sphere_subset_Γ`, `sixQ_sides`, `sixQ_isQArc`; inhabitant `sixQ_inhabited` |
| FS129-SR2-TOUCHW (carrying FS116-N1-TOUCH) | `touchW` |
| FS116-N1-ECHO | `echo_unique`, `echo_of_mem_closure`, `echo` |
| FS116-V5-U1 | `ringArc_cone_inner`, `ringArc_cone_outer`, `ringArc_sideCone_inner`, `ringArc_sideCone_outer`, `ringArc_sideCone_other`, `four_of_bothKind`, `four_of_bothKind_simple` |
| FS116-Y4-FLANK | `flank_cone`, `flank_edge_exists`, `flank_initialPieces`, `flank` |

**Inhabitants.** Six colours at a vertex: `sixFrag` (`Plane/SixFragment`), the inhabitant of SIXQ (`sixQ_inhabited`). A
vertex of four colours with a change point (GERM-S, RING-Q-PRIME-S, TOUCHW, QFREE4's class): FS114-Y2-BOWTIE (wave 7) and
FS114-Y-DIAL's strip; none in this wave. A five-colour vertex (FIVERING): none known, and none claimed to exist (its
not-claimed line).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## The crossing lemma and ring comparisons (children of engine 1) -/

/-- **The crossing lemma** (engine 1 at a closure point): in a valid map, a point `a` of the closure of the class of `c` and
a preconnected `S` inside that closure cannot hold both a point nearer than `1` to `a` and a point farther than `1`. -/
theorem Valid.false_of_crossing (hF : F.Valid) {c : Fin k} {a : ℂ} (ha : a ∈ closure (F.region c)) {S : Set ℂ}
    (hS : IsPreconnected S) (hSc : S ⊆ closure (F.region c)) {u v : ℂ} (hu : u ∈ S) (hv : v ∈ S)
    (hau : dist a u < 1) (hav : 1 < dist a v) : False := by
  set m := min (1 - dist a u) (dist a v - 1) with hm
  have hm0 : 0 < m := lt_min (by linarith) (by linarith)
  obtain ⟨z, hz, hza⟩ := Metric.mem_closure_iff.mp ha m hm0
  have hzu : dist z u < 1 := by
    have h1 : dist a z < 1 - dist a u := lt_of_lt_of_le hza (min_le_left _ _)
    have := dist_triangle z a u
    rw [dist_comm z a] at this
    linarith
  have hzv : 1 < dist z v := by
    have h1 : dist a z < dist a v - 1 := lt_of_lt_of_le hza (min_le_right _ _)
    have := dist_triangle a z v
    linarith
  rcases hF.dist_lt_or_gt_of_isPreconnected hz hS hSc with h | h
  · exact absurd (h v hv) (not_lt.mpr hzv.le)
  · exact absurd (h u hu) (not_lt.mpr hzu.le)

/-- A germ is preconnected (the image of an interval). -/
theorem isPreconnected_germ (p : ℂ) (θ : ℝ) (s : Side) (δ : ℝ) : IsPreconnected (germ p θ s δ) := by
  have hc : Continuous fun t : ℝ => ringPt p (θ + s.sign * t) := by unfold ringPt e; fun_prop
  exact isPreconnected_Ioo.image _ hc.continuousOn

/-- Two ring points `π/3 + d` apart (`|d| ≤ 1`): nearer than `1` for `d < 0`, farther for `d > 0`. -/
theorem dist_ringPt_shift_cmp (p : ℂ) (α d : ℝ) (hd : |d| ≤ 1) :
    (d < 0 → dist (ringPt p α) (ringPt p (α + π / 3 + d)) < 1) ∧
    (0 < d → 1 < dist (ringPt p α) (ringPt p (α + π / 3 + d))) := by
  have hπ := Real.pi_gt_three
  have hd1 := abs_le.mp hd
  have habs : |α - (α + π / 3 + d)| = π / 3 + d := by
    rw [show α - (α + π / 3 + d) = -(π / 3 + d) by ring, abs_neg, abs_of_pos (by linarith)]
  have hle : |α - (α + π / 3 + d)| ≤ π := by rw [habs]; linarith
  have h := dist_ringPt_ringPt_cmp_one p hle
  rw [habs] at h
  exact ⟨fun hneg => h.2.1.mpr (by linarith), fun hpos => h.2.2.mpr (by linarith)⟩

/-- The expansion of the square of a sum in coordinates. -/
theorem norm_add_sq_eq (d h : ℂ) : ‖d + h‖ ^ 2 = ‖d‖ ^ 2 + 2 * (d * (starRingEnd ℂ) h).re + ‖h‖ ^ 2 := by
  simp only [Complex.sq_norm, Complex.normSq_apply, Complex.add_re, Complex.add_im, Complex.mul_re,
    Complex.conj_re, Complex.conj_im]
  ring

/-- The first-order step of a cone argument: a point `y + h` with unit direction `u` within `ε` of `e β`, `‖d‖ = 1`:
`‖d + h‖² − 1 = ‖h‖ (2 Re(d ū) + ‖h‖)` and `|Re(d ū) − Re(d conj(e β))| ≤ ε`. -/
theorem cone_expand {d h : ℂ} (hd : ‖d‖ = 1) (hh : h ≠ 0) {β ε : ℝ}
    (hu : ‖h / (‖h‖ : ℂ) - e β‖ < ε) :
    ‖d + h‖ ^ 2 - 1 = ‖h‖ * (2 * (d * (starRingEnd ℂ) (h / (‖h‖ : ℂ))).re + ‖h‖) ∧
      |(d * (starRingEnd ℂ) (h / (‖h‖ : ℂ))).re - (d * (starRingEnd ℂ) (e β)).re| ≤ ε := by
  have hn : (‖h‖ : ℂ) ≠ 0 := by exact_mod_cast norm_ne_zero_iff.mpr hh
  have hhu : h = (‖h‖ : ℂ) * (h / (‖h‖ : ℂ)) := by field_simp
  constructor
  · rw [norm_add_sq_eq, hd]
    conv_lhs => rw [hhu]
    simp only [map_mul, Complex.conj_ofReal, one_pow]
    have : (d * ((‖h‖ : ℂ) * (starRingEnd ℂ) (h / (‖h‖ : ℂ)))).re
        = ‖h‖ * (d * (starRingEnd ℂ) (h / (‖h‖ : ℂ))).re := by
      rw [show d * ((‖h‖ : ℂ) * (starRingEnd ℂ) (h / (‖h‖ : ℂ))) =
        (‖h‖ : ℂ) * (d * (starRingEnd ℂ) (h / (‖h‖ : ℂ))) by ring, Complex.re_ofReal_mul]
    rw [this]
    simp only [norm_mul, Complex.norm_real, norm_norm]
    have : ‖h / (‖h‖ : ℂ)‖ = 1 := by
      rw [norm_div, Complex.norm_real, norm_norm, div_self (norm_ne_zero_iff.mpr hh)]
    rw [this]
    ring
  · rw [← Complex.sub_re, ← mul_sub, ← map_sub]
    calc |(d * (starRingEnd ℂ) (h / (‖h‖ : ℂ) - e β)).re| ≤ ‖d * (starRingEnd ℂ) (h / (‖h‖ : ℂ) - e β)‖ :=
          Complex.abs_re_le_norm _
      _ = ‖h / (‖h‖ : ℂ) - e β‖ := by rw [norm_mul, hd, one_mul, Complex.norm_conj]
      _ ≤ ε := hu.le

/-- The distance between two ring points on one side of `r(φ₀)` and `r(φ₀)` itself is at most the angle. -/
theorem dist_ringPt_germ_le (p : ℂ) (φ₀ : ℝ) (s : Side) {t : ℝ} (ht : 0 ≤ t) :
    dist (ringPt p φ₀) (ringPt p (φ₀ + s.sign * t)) ≤ t := by
  have h := norm_e_sub_e_le φ₀ (φ₀ + s.sign * t)
  have hs : |s.sign| = 1 := by cases s <;> simp [Side.sign]
  rw [dist_eq_norm]
  simp only [ringPt, add_sub_add_left_eq_sub]
  calc _ ≤ |φ₀ - (φ₀ + s.sign * t)| := h
    _ = t := by rw [show φ₀ - (φ₀ + s.sign * t) = -(s.sign * t) by ring, abs_neg, abs_mul, hs, one_mul,
      abs_of_nonneg ht]

/-- **The germ half-plane lemma, far case** (child of GERM-R): if the germ of `ω(p)` on side `s` of `w₀ = r(φ₀)` lies in
the closure of the class of `c`, `y` is at distance `1` from `w₀` and farther than `1` from the germ's points, then the
class approaches `y` only along directions `β` with `Re((y − w₀) conj e β) ≥ 0`. -/
theorem Valid.cone_re_nonneg_of_germ (hF : F.Valid) {p : ℂ} {φ₀ : ℝ} {s : Side} {c : Fin k}
    (h : GermIn p φ₀ s (closure (F.region c))) {y : ℂ} (hy : ‖y - ringPt p φ₀‖ = 1)
    (hfar : ∃ δ₀ > 0, ∀ t ∈ Ioo 0 δ₀, 1 < dist y (ringPt p (φ₀ + s.sign * t))) :
    ∀ β ∈ coneAt (F.region c) y, 0 ≤ ((y - ringPt p φ₀) * (starRingEnd ℂ) (e β)).re := by
  intro β hβ
  by_contra hneg
  push Not at hneg
  obtain ⟨δ, hδ, hsub⟩ := h
  obtain ⟨δ₀, hδ₀, hfar⟩ := hfar
  set δ' := min δ δ₀ with hδ'
  have hδ'0 : 0 < δ' := lt_min hδ hδ₀
  have hS : germ p φ₀ s δ' ⊆ closure (F.region c) := (germ_mono (min_le_left _ _)).trans hsub
  have ht₀ : δ' / 2 ∈ Ioo 0 δ' := ⟨by linarith, by linarith⟩
  set w₀ := ringPt p φ₀
  set w₁ := ringPt p (φ₀ + s.sign * (δ' / 2)) with hw₁
  have hm : 1 < dist y w₁ := hfar _ ⟨ht₀.1, lt_of_lt_of_le ht₀.2 (min_le_right _ _)⟩
  set κ := -((y - w₀) * (starRingEnd ℂ) (e β)).re with hκ
  have hκ0 : 0 < κ := by rw [hκ]; linarith
  set ε := min (dist y w₁ - 1) (κ / 2) with hε
  have hε0 : 0 < ε := lt_min (by linarith) (by linarith)
  obtain ⟨z, hz, hzy, hzd, hzu⟩ := hβ ε hε0
  have hh : z - y ≠ 0 := sub_ne_zero.mpr hzy
  have hhn : ‖z - y‖ < ε := by rwa [← dist_eq_norm]
  rcases hF.dist_lt_or_gt_of_isPreconnected hz (isPreconnected_germ p φ₀ s δ') hS with hlt | hgt
  · exfalso
    have h1 := hlt w₁ ⟨δ' / 2, ht₀, rfl⟩
    have h2 := dist_triangle y z w₁
    have h3 : dist y z < ε := by rw [dist_comm]; exact hzd
    have : ε ≤ dist y w₁ - 1 := min_le_left _ _
    linarith
  · have hz0 : 1 ≤ dist z w₀ := by
      by_contra hlt
      push Not at hlt
      set η := 1 - dist z w₀ with hη
      have hη0 : 0 < η := by rw [hη]; linarith
      set t := min (η / 2) (δ' / 2) with ht
      have ht0 : 0 < t := lt_min (by linarith) (by linarith)
      have htδ : t ∈ Ioo 0 δ' := ⟨ht0, lt_of_le_of_lt (min_le_right _ _) (by linarith)⟩
      have h1 := hgt _ ⟨t, htδ, rfl⟩
      have h2 := dist_triangle z w₀ (ringPt p (φ₀ + s.sign * t))
      have h3 := dist_ringPt_germ_le p φ₀ s ht0.le
      have : t ≤ η / 2 := min_le_left _ _
      linarith
    have hd : ‖y - w₀‖ = 1 := hy
    have hexp := cone_expand (d := y - w₀) (h := z - y) hd hh hzu
    have hsum : y - w₀ + (z - y) = z - w₀ := by ring
    rw [hsum] at hexp
    obtain ⟨hA, hB⟩ := hexp
    have hz1 : 1 ≤ ‖z - w₀‖ ^ 2 := by
      rw [← dist_eq_norm]; nlinarith
    have hpos : 0 < ‖z - y‖ := norm_pos_iff.mpr hh
    have h0 : 0 ≤ 2 * ((y - w₀) * (starRingEnd ℂ) ((z - y) / (‖z - y‖ : ℂ))).re + ‖z - y‖ := by
      by_contra hn; push Not at hn
      have := mul_neg_of_pos_of_neg hpos hn
      linarith
    have hε' : ε ≤ κ / 2 := min_le_right _ _
    have hB' := (abs_le.mp hB).2
    linarith

/-- **The germ half-plane lemma, near case** (child of GERM-R): as above with the germ's points nearer than `1` to `y`;
then `Re((y − w₀) conj e β) ≤ 0` along every direction `β` of the cone. -/
theorem Valid.cone_re_nonpos_of_germ (hF : F.Valid) {p : ℂ} {φ₀ : ℝ} {s : Side} {c : Fin k}
    (h : GermIn p φ₀ s (closure (F.region c))) {y : ℂ} (hy : ‖y - ringPt p φ₀‖ = 1)
    (hnear : ∃ δ₀ > 0, ∀ t ∈ Ioo 0 δ₀, dist y (ringPt p (φ₀ + s.sign * t)) < 1) :
    ∀ β ∈ coneAt (F.region c) y, ((y - ringPt p φ₀) * (starRingEnd ℂ) (e β)).re ≤ 0 := by
  intro β hβ
  by_contra hneg
  push Not at hneg
  obtain ⟨δ, hδ, hsub⟩ := h
  obtain ⟨δ₀, hδ₀, hnear⟩ := hnear
  set δ' := min δ δ₀ with hδ'
  have hδ'0 : 0 < δ' := lt_min hδ hδ₀
  have hS : germ p φ₀ s δ' ⊆ closure (F.region c) := (germ_mono (min_le_left _ _)).trans hsub
  have ht₀ : δ' / 2 ∈ Ioo 0 δ' := ⟨by linarith, by linarith⟩
  set w₀ := ringPt p φ₀
  set w₁ := ringPt p (φ₀ + s.sign * (δ' / 2)) with hw₁
  have hm : dist y w₁ < 1 := hnear _ ⟨ht₀.1, lt_of_lt_of_le ht₀.2 (min_le_right _ _)⟩
  set κ := ((y - w₀) * (starRingEnd ℂ) (e β)).re with hκ
  have hκ0 : 0 < κ := hneg
  set ε := min (1 - dist y w₁) (κ / 2) with hε
  have hε0 : 0 < ε := lt_min (by linarith) (by linarith)
  obtain ⟨z, hz, hzy, hzd, hzu⟩ := hβ ε hε0
  have hh : z - y ≠ 0 := sub_ne_zero.mpr hzy
  have hhn : ‖z - y‖ < ε := by rwa [← dist_eq_norm]
  rcases hF.dist_lt_or_gt_of_isPreconnected hz (isPreconnected_germ p φ₀ s δ') hS with hlt | hgt
  · have hz0 : dist z w₀ ≤ 1 := by
      by_contra hgt'
      push Not at hgt'
      set η := dist z w₀ - 1 with hη
      have hη0 : 0 < η := by rw [hη]; linarith
      set t := min (η / 2) (δ' / 2) with ht
      have ht0 : 0 < t := lt_min (by linarith) (by linarith)
      have htδ : t ∈ Ioo 0 δ' := ⟨ht0, lt_of_le_of_lt (min_le_right _ _) (by linarith)⟩
      have h1 := hlt _ ⟨t, htδ, rfl⟩
      have h2 := dist_triangle z (ringPt p (φ₀ + s.sign * t)) w₀
      have h3 := dist_ringPt_germ_le p φ₀ s ht0.le
      rw [dist_comm (ringPt p (φ₀ + s.sign * t)) w₀] at h2
      have : t ≤ η / 2 := min_le_left _ _
      linarith
    have hd : ‖y - w₀‖ = 1 := hy
    have hexp := cone_expand (d := y - w₀) (h := z - y) hd hh hzu
    have hsum : y - w₀ + (z - y) = z - w₀ := by ring
    rw [hsum] at hexp
    obtain ⟨hA, hB⟩ := hexp
    have hz1 : ‖z - w₀‖ ^ 2 ≤ 1 := by
      rw [← dist_eq_norm]
      have := dist_nonneg (x := z) (y := w₀)
      nlinarith
    have hpos : 0 < ‖z - y‖ := norm_pos_iff.mpr hh
    have h0 : 2 * ((y - w₀) * (starRingEnd ℂ) ((z - y) / (‖z - y‖ : ℂ))).re + ‖z - y‖ ≤ 0 := by
      by_contra hn; push Not at hn
      have := mul_pos hpos hn
      linarith
    have hε' : ε ≤ κ / 2 := min_le_right _ _
    have hB' := (abs_le.mp hB).1
    linarith
  · exfalso
    have h1 := hgt w₁ ⟨δ' / 2, ht₀, rfl⟩
    have h2 := dist_triangle z y w₁
    have : ε ≤ 1 - dist y w₁ := min_le_left _ _
    linarith

/-- `e π = −1`. -/
theorem e_pi : e π = -1 := by
  rw [e_eq]; simp

/-- `Re(e a · conj(e b)) = cos(a − b)`. -/
theorem re_e_mul_conj_e (a b : ℝ) : (e a * (starRingEnd ℂ) (e b)).re = Real.cos (a - b) := by
  rw [e_eq, e_eq, Real.cos_sub]
  simp [Complex.mul_re, -Complex.ofReal_cos, -Complex.ofReal_sin]

/-- The chord from `r(ψ − π/3)` to `r(ψ)` is `e(ψ + π/3)`. -/
theorem ringPt_sub_ringPt_minus_third (p : ℂ) (ψ : ℝ) :
    ringPt p ψ - ringPt p (ψ - π / 3) = e (ψ + π / 3) := by
  rw [ringPt_sub_ringPt p (ψ - π / 3) ψ]
  have h1 : (ψ - (ψ - π / 3)) / 2 = π / 6 := by ring
  have h2 : (ψ - π / 3 + ψ) / 2 + π / 2 = ψ + π / 3 := by ring
  rw [h1, h2, Real.sin_pi_div_six]
  push_cast; ring

/-- The chord from `r(ψ + π/3)` to `r(ψ)` is `e(ψ − π/3)`. -/
theorem ringPt_sub_ringPt_plus_third (p : ℂ) (ψ : ℝ) :
    ringPt p ψ - ringPt p (ψ + π / 3) = e (ψ - π / 3) := by
  have h := ringPt_sub_ringPt_minus_third p (ψ + π / 3)
  rw [add_sub_cancel_right] at h
  have h2 : e (ψ + π / 3 + π / 3) = - e (ψ - π / 3) := by
    have : ψ + π / 3 + π / 3 = (ψ - π / 3) + π := by ring
    rw [this, e_add, e_pi]; ring
  rw [h2] at h
  linear_combination -h

/-! ## FS116-V4-TWIST -/

/-- **FS116-V4-TWIST**, first clause (class form; the covering hypothesis is idle): no colour class has in its closure both
a germ `g` of `ω(p)` and its rotation `σg` by `60°` about `p` (σ⁻¹`g` is the same statement at `θ − π/3`). -/
theorem not_germIn_closure_rotate (hF : F.Valid) (p : ℂ) (θ : ℝ) (s : Side) (c : Fin k) :
    ¬ (GermIn p θ s (closure (F.region c)) ∧ GermIn p (θ + π / 3) s (closure (F.region c))) := by
  rintro ⟨⟨δ₁, hδ₁, h₁⟩, ⟨δ₂, hδ₂, h₂⟩⟩
  set δ := min (min δ₁ δ₂) 1 with hδ
  have hδ0 : 0 < δ := lt_min (lt_min hδ₁ hδ₂) one_pos
  have hδ1 : δ ≤ 1 := min_le_right _ _
  have hg₁ : germ p θ s δ ⊆ closure (F.region c) := (germ_mono ((min_le_left _ _).trans (min_le_left _ _))).trans h₁
  have hg₂ : germ p (θ + π / 3) s δ ⊆ closure (F.region c) :=
    (germ_mono ((min_le_left _ _).trans (min_le_right _ _))).trans h₂
  -- the pivot point and two points of the rotated germ on either side of its distance-one point
  have key : ∀ t₀ t₁ t₂ : ℝ, t₀ ∈ Ioo 0 δ → t₁ ∈ Ioo 0 δ → t₂ ∈ Ioo 0 δ → s.sign * (t₁ - t₀) < 0 →
      0 < s.sign * (t₂ - t₀) → False := by
    intro t₀ t₁ t₂ h0 h1 h2 hneg hpos
    have hs1 : |s.sign| = 1 := by cases s <;> simp [Side.sign]
    have hb : ∀ t ∈ Ioo 0 δ, |s.sign * (t - t₀)| ≤ 1 := by
      intro t ht
      rw [abs_mul, hs1, one_mul, abs_le]
      constructor <;> linarith [ht.1, ht.2, h0.1, h0.2]
    have hring : ∀ t, θ + π / 3 + s.sign * t = (θ + s.sign * t₀) + π / 3 + s.sign * (t - t₀) := by
      intro t; ring
    refine hF.false_of_crossing (a := ringPt p (θ + s.sign * t₀)) (hg₁ ⟨t₀, h0, rfl⟩)
      (isPreconnected_germ p (θ + π / 3) s δ) hg₂ (u := ringPt p ((θ + π / 3) + s.sign * t₁))
      (v := ringPt p ((θ + π / 3) + s.sign * t₂)) ⟨t₁, h1, rfl⟩ ⟨t₂, h2, rfl⟩ ?_ ?_
    · have := (dist_ringPt_shift_cmp p (θ + s.sign * t₀) _ (hb t₁ h1)).1 hneg
      rwa [← hring] at this
    · have := (dist_ringPt_shift_cmp p (θ + s.sign * t₀) _ (hb t₂ h2)).2 hpos
      rwa [← hring] at this
  have m1 : δ / 2 ∈ Ioo 0 δ := ⟨by linarith, by linarith⟩
  have m2 : δ / 4 ∈ Ioo 0 δ := ⟨by linarith, by linarith⟩
  have m3 : 3 * δ / 4 ∈ Ioo 0 δ := ⟨by linarith, by linarith⟩
  cases s
  · exact key (δ / 2) (3 * δ / 4) (δ / 4) m1 m3 m2 (by simp [Side.sign]; linarith) (by simp [Side.sign]; linarith)
  · exact key (δ / 2) (δ / 4) (3 * δ / 4) m1 m2 m3 (by simp [Side.sign]; linarith) (by simp [Side.sign]; linarith)

/-- **FS116-V4-TWIST**, second clause ("when `p` is a vertex" is idle): a point of `ω(p)` inside a tile of colour `c` has `c`
absent at `p`. -/
theorem not_mem_coloursAt_of_mem_sphere (hF : F.Valid) {p z : ℂ} (hz : z ∈ sphere p 1) {c : Fin k}
    (hzc : z ∈ F.region c) : c ∉ F.coloursAt p := fun hc =>
  ne1_region hF hc hzc (mem_sphere.mp hz)

/-! ## FS116-N1-TWIST-D -/

/-- The set `D` of FS116-N1-TWIST-D: the points of `ω(p)` in the closure of a tile of one of `p`'s colours (class form; equal
to the tile form on a covered ring, `mem_coloursAt_iff_exists_tileOf`). -/
def ringD (F : ArcMap k) (p : ℂ) : Set ℂ := {x | x ∈ sphere p 1 ∧ ∃ c ∈ F.coloursAt p, x ∈ closure (F.region c)}

/-- **FS116-N1-TWIST-D**, `D` is closed. -/
theorem isClosed_ringD (p : ℂ) : IsClosed (F.ringD p) := by
  have : F.ringD p = sphere p 1 ∩ ⋃ c ∈ F.coloursAt p, closure (F.region c) := by
    ext x; simp [ringD]
  rw [this]
  exact isClosed_sphere.inter ((Set.toFinite _).isClosed_biUnion fun c _ => isClosed_closure)

/-- A point of the domain off `Γ` is an interior point. -/
theorem mem_interiorPts_of_notMem_Γ {x : ℂ} (hx : x ∈ F.dom) (hΓ : x ∉ F.Γ) : x ∈ F.interiorPts :=
  ⟨hx, fun h => hΓ ⟨hx, h⟩⟩

/-- A point of the closure of one class that is interior has that class's colour. -/
theorem col_eq_of_mem_closure_region {x : ℂ} (hx : x ∈ F.interiorPts) {c : Fin k}
    (hc : x ∈ closure (F.region c)) : F.col x = c := by
  obtain ⟨y, hy, hyc⟩ := mem_closure_iff.mp hc (F.region (F.col x)) (F.isOpen_region _) ⟨hx, rfl⟩
  exact ((hyc.2 : F.col y = c).symm.trans hy.2).symm

/-- **FS116-N1-TWIST-D** ("vertex" idle; any point `p`): `D` lies in `Γ`. -/
theorem ringD_subset_Γ (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) : F.ringD p ⊆ F.Γ := by
  rintro x ⟨hxs, c, hc, hxc⟩
  by_contra hΓ
  have hxd : x ∈ F.dom := hp (sphere_subset_closedBall hxs)
  have hxI := F.mem_interiorPts_of_notMem_Γ hxd hΓ
  have hcol := F.col_eq_of_mem_closure_region hxI hxc
  subst hcol
  exact not_mem_coloursAt_of_mem_sphere hF hxs ⟨hxI, rfl⟩ hc

/-- **FS116-N1-TWIST-D**: `D` lies in the union of the arcs of `Γ` on `ω(p)` and finitely many points. -/
theorem finite_ringD_off_ringArc (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) :
    (F.ringD p \ {x | F.OnRingArc p x}).Finite :=
  (F.finite_ringΓ_off_ringArc hp).subset fun _ hx =>
    ⟨⟨F.ringD_subset_Γ hF hp hx.1, hx.1.1⟩, hx.2⟩

/-! ## FS116-N1-GERM-R (any valid map: the covering hypothesis is idle) -/

/-- **FS116-N1-GERM-R**, `v⁻`: if the germ just clockwise of `r(ψ − 60°)` lies in the closure of the class of `c`, the class
approaches `y = r(ψ)` along no direction `β` with `β − ψ ∈ (150°, 330°)`. -/
theorem germR_vMinus (hF : F.Valid) {p : ℂ} {ψ : ℝ} {c : Fin k}
    (h : GermIn p (ψ - π / 3) .cw (closure (F.region c))) :
    ∀ β ∈ Ioo (ψ + 5 * π / 6) (ψ + 11 * π / 6), β ∉ coneAt (F.region c) (ringPt p ψ) := by
  intro β hβ hcone
  have hd := ringPt_sub_ringPt_minus_third p ψ
  have hy : ‖ringPt p ψ - ringPt p (ψ - π / 3)‖ = 1 := by rw [hd, norm_e]
  have hfar : ∃ δ₀ > 0, ∀ t ∈ Ioo 0 δ₀, 1 < dist (ringPt p ψ) (ringPt p (ψ - π / 3 + Side.sign .cw * t)) := by
    refine ⟨1, one_pos, fun t ht => ?_⟩
    have := (dist_ringPt_shift_cmp p (ψ - π / 3 + Side.sign .cw * t) t
      (by rw [abs_of_pos ht.1]; exact ht.2.le)).2 ht.1
    rw [dist_comm]
    convert this using 3
    simp [Side.sign]; ring
  have := hF.cone_re_nonneg_of_germ h hy hfar β hcone
  rw [hd, re_e_mul_conj_e] at this
  have hcos : Real.cos (ψ + π / 3 - β) < 0 := by
    rw [← Real.cos_neg, neg_sub]
    exact Real.cos_neg_of_pi_div_two_lt_of_lt (by linarith [hβ.1]) (by linarith [hβ.2])
  linarith

/-- **FS116-N1-GERM-R**, `v⁺`: the germ just counter-clockwise of `r(ψ − 60°)`; the interval `(−30°, 150°)`. -/
theorem germR_vPlus (hF : F.Valid) {p : ℂ} {ψ : ℝ} {c : Fin k}
    (h : GermIn p (ψ - π / 3) .ccw (closure (F.region c))) :
    ∀ β ∈ Ioo (ψ - π / 6) (ψ + 5 * π / 6), β ∉ coneAt (F.region c) (ringPt p ψ) := by
  intro β hβ hcone
  have hd := ringPt_sub_ringPt_minus_third p ψ
  have hy : ‖ringPt p ψ - ringPt p (ψ - π / 3)‖ = 1 := by rw [hd, norm_e]
  have hnear : ∃ δ₀ > 0, ∀ t ∈ Ioo 0 δ₀, dist (ringPt p ψ) (ringPt p (ψ - π / 3 + Side.sign .ccw * t)) < 1 := by
    refine ⟨1, one_pos, fun t ht => ?_⟩
    have := (dist_ringPt_shift_cmp p (ψ - π / 3 + Side.sign .ccw * t) (-t)
      (by rw [abs_neg, abs_of_pos ht.1]; exact ht.2.le)).1 (by linarith [ht.1])
    rw [dist_comm]
    convert this using 3
    simp [Side.sign]; ring
  have := hF.cone_re_nonpos_of_germ h hy hnear β hcone
  rw [hd, re_e_mul_conj_e] at this
  have hcos : 0 < Real.cos (ψ + π / 3 - β) := by
    rw [← Real.cos_neg, neg_sub]
    exact Real.cos_pos_of_mem_Ioo ⟨by linarith [hβ.1, Real.pi_pos], by linarith [hβ.2, Real.pi_pos]⟩
  linarith

/-- **FS116-N1-GERM-R**, `u⁻`: the germ just clockwise of `r(ψ + 60°)`; the interval `(−150°, 30°)`. -/
theorem germR_uMinus (hF : F.Valid) {p : ℂ} {ψ : ℝ} {c : Fin k}
    (h : GermIn p (ψ + π / 3) .cw (closure (F.region c))) :
    ∀ β ∈ Ioo (ψ - 5 * π / 6) (ψ + π / 6), β ∉ coneAt (F.region c) (ringPt p ψ) := by
  intro β hβ hcone
  have hd := ringPt_sub_ringPt_plus_third p ψ
  have hy : ‖ringPt p ψ - ringPt p (ψ + π / 3)‖ = 1 := by rw [hd, norm_e]
  have hnear : ∃ δ₀ > 0, ∀ t ∈ Ioo 0 δ₀, dist (ringPt p ψ) (ringPt p (ψ + π / 3 + Side.sign .cw * t)) < 1 := by
    refine ⟨1, one_pos, fun t ht => ?_⟩
    have := (dist_ringPt_shift_cmp p ψ (-t)
      (by rw [abs_neg, abs_of_pos ht.1]; exact ht.2.le)).1 (by linarith [ht.1])
    convert this using 3
    simp [Side.sign]
  have := hF.cone_re_nonpos_of_germ h hy hnear β hcone
  rw [hd, re_e_mul_conj_e] at this
  have hcos : 0 < Real.cos (ψ - π / 3 - β) := by
    rw [← Real.cos_neg, neg_sub]
    exact Real.cos_pos_of_mem_Ioo ⟨by linarith [hβ.1, Real.pi_pos], by linarith [hβ.2, Real.pi_pos]⟩
  linarith

/-- **FS116-N1-GERM-R**, `u⁺`: the germ just counter-clockwise of `r(ψ + 60°)`; the interval `(30°, 210°)`. -/
theorem germR_uPlus (hF : F.Valid) {p : ℂ} {ψ : ℝ} {c : Fin k}
    (h : GermIn p (ψ + π / 3) .ccw (closure (F.region c))) :
    ∀ β ∈ Ioo (ψ + π / 6) (ψ + 7 * π / 6), β ∉ coneAt (F.region c) (ringPt p ψ) := by
  intro β hβ hcone
  have hd := ringPt_sub_ringPt_plus_third p ψ
  have hy : ‖ringPt p ψ - ringPt p (ψ + π / 3)‖ = 1 := by rw [hd, norm_e]
  have hfar : ∃ δ₀ > 0, ∀ t ∈ Ioo 0 δ₀, 1 < dist (ringPt p ψ) (ringPt p (ψ + π / 3 + Side.sign .ccw * t)) := by
    refine ⟨1, one_pos, fun t ht => ?_⟩
    have := (dist_ringPt_shift_cmp p ψ t
      (by rw [abs_of_pos ht.1]; exact ht.2.le)).2 ht.1
    convert this using 3
    simp [Side.sign]
  have := hF.cone_re_nonneg_of_germ h hy hfar β hcone
  rw [hd, re_e_mul_conj_e] at this
  have hcos : Real.cos (ψ - π / 3 - β) < 0 := by
    rw [← Real.cos_neg, neg_sub]
    exact Real.cos_neg_of_pi_div_two_lt_of_lt (by linarith [hβ.1]) (by linarith [hβ.2])
  linarith

/-! ## FS116-N1-GERM-S (at every `k` with at most two colours absent at `p`; the row is `k = 6`) -/

/-- A germ of `ω(p)` (on either side) has a point in any set it lies in; a point of `ω(p)`. -/
theorem GermIn.exists_mem_sphere {p : ℂ} {θ : ℝ} {s : Side} {S : Set ℂ} (h : GermIn p θ s S) :
    ∃ z ∈ S, z ∈ sphere p 1 := by
  obtain ⟨δ, hδ, hsub⟩ := h
  have hmem : ringPt p (θ + s.sign * (δ / 2)) ∈ germ p θ s δ :=
    ⟨δ / 2, ⟨half_pos hδ, by linarith⟩, rfl⟩
  exact ⟨_, hsub hmem, ringPt_mem_sphere _ _⟩

/-- The two colours of a change point are absent at `p`. -/
theorem IsChangePoint.not_mem_coloursAt (hF : F.Valid) {p : ℂ} {ψ : ℝ} {X X' : Fin k}
    (hy : F.IsChangePoint p ψ X X') : X ∉ F.coloursAt p ∧ X' ∉ F.coloursAt p := by
  obtain ⟨-, -, hX, hX'⟩ := hy
  obtain ⟨z, hz, hzs⟩ := GermIn.exists_mem_sphere hX
  obtain ⟨z', hz', hzs'⟩ := GermIn.exists_mem_sphere hX'
  exact ⟨not_mem_coloursAt_of_mem_sphere hF hzs hz, not_mem_coloursAt_of_mem_sphere hF hzs' hz'⟩

/-- The count of absent colours: a change point leaves at least two colours absent. -/
theorem IsChangePoint.ncard_add_two_le (hF : F.Valid) {p : ℂ} {ψ : ℝ} {X X' : Fin k}
    (hy : F.IsChangePoint p ψ X X') : (F.coloursAt p).ncard + 2 ≤ k := by
  obtain ⟨h1, h2⟩ := hy.not_mem_coloursAt hF
  have hsub : ({X, X'} : Set (Fin k)) ⊆ (F.coloursAt p)ᶜ := by
    rintro _ (rfl | rfl) <;> assumption
  have hc := Set.ncard_le_ncard hsub (Set.toFinite _)
  rw [Set.ncard_pair hy.2.1] at hc
  have := Set.ncard_add_ncard_compl (F.coloursAt p)
  rw [Nat.card_eq_fintype_card, Fintype.card_fin] at this
  omega

/-- **FS116-N1-GERM-S**, the count: at a change point `y = r(ψ)` of the ring of a vertex `p` of at least four colours with at
most two colours absent, exactly two are absent — `X` (the ring's colour just counter-clockwise of `y`) and `X'` (`X̄`, just
clockwise). At `k = 6`: "`p` has four colours and no more, `X` and `X̄` are the colours absent at `p`". -/
theorem germS_absent (hF : F.Valid) {p : ℂ} (_hp : F.Covers p 1) (_h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k} (hy : F.IsChangePoint p ψ X X') :
    (F.coloursAt p).ncard + 2 = k ∧ (F.coloursAt p)ᶜ = {X, X'} := by
  have hle := hy.ncard_add_two_le hF
  refine ⟨by omega, ?_⟩
  obtain ⟨h1, h2⟩ := hy.not_mem_coloursAt hF
  have hsub : ({X, X'} : Set (Fin k)) ⊆ (F.coloursAt p)ᶜ := by
    rintro _ (rfl | rfl) <;> assumption
  have hcard := Set.ncard_add_ncard_compl (F.coloursAt p)
  rw [Nat.card_eq_fintype_card, Fintype.card_fin] at hcard
  refine (Set.eq_of_subset_of_ncard_le hsub ?_ (Set.toFinite _)).symm
  rw [Set.ncard_pair hy.2.1]
  omega

/-- **FS116-N1-GERM-S** (i): if neither `v⁻` nor `u⁺` lies on a (Q) arc, every direction at `y` in the open `60°` cone about
the direction to `p` lies in the cone of a colour `c` of `p` every tile of `p` of which colour lies in `B̄(y, 1)`. -/
theorem germS_inward (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k} (hy : F.IsChangePoint p ψ X X')
    (hv : ¬ F.GermOnQ p (ψ - π / 3) .cw) (hu : ¬ F.GermOnQ p (ψ + π / 3) .ccw) :
    ∀ β ∈ Ioo (ψ + 5 * π / 6) (ψ + 7 * π / 6), ∃ c ∈ F.coloursAt p,
      β ∈ coneAt (F.region c) (ringPt p ψ) ∧
        ∀ A, F.TileOf c A → p ∈ closure A → A ⊆ closedBall (ringPt p ψ) 1 := by
  sorry

/-- **FS116-N1-GERM-S** (ii): if neither `u⁻` nor `v⁺` lies on a (Q) arc, every direction at `y` in the open `60°` cone about
the direction away from `p` lies in the cone of a tile, not a tile of `p`, of a colour `c` of `p` every tile of `p` of which
colour misses `B(y, 1)`. "A tile, not a tile of `p`" is the part of the class outside `B̄(p, 1)`, which no tile of `p` meets
(`IsTile.subset_ball`); in this window of directions the two readings have the same cone. -/
theorem germS_outward (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k} (hy : F.IsChangePoint p ψ X X')
    (hu : ¬ F.GermOnQ p (ψ + π / 3) .cw) (hv : ¬ F.GermOnQ p (ψ - π / 3) .ccw) :
    ∀ β ∈ Ioo (ψ - π / 6) (ψ + π / 6), ∃ c ∈ F.coloursAt p,
      β ∈ coneAt (F.region c \ closedBall p 1) (ringPt p ψ) ∧
        ∀ A, F.TileOf c A → p ∈ closure A → Disjoint A (ball (ringPt p ψ) 1) := by
  sorry

/-- **FS116-N1-GERM-S** (iii): if none of the four germs at `ψ ± 60°` lies on a (Q) arc, `y` is a vertex of at least four
colours. -/
theorem germS_four (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k} (hy : F.IsChangePoint p ψ X X')
    (hq : ∀ s, ¬ F.GermOnQ p (ψ + π / 3) s ∧ ¬ F.GermOnQ p (ψ - π / 3) s) :
    4 ≤ (F.coloursAt (ringPt p ψ)).ncard := by
  sorry

/-! ## FS116-RING-Q-PRIME-S -/

/-- The base point of a germ lies in the closure of the germ. -/
theorem ringPt_mem_closure_germ (p : ℂ) (θ : ℝ) (s : Side) {δ : ℝ} (hδ : 0 < δ) :
    ringPt p θ ∈ closure (germ p θ s δ) := by
  rw [Metric.mem_closure_iff]
  intro ε hε
  set t := min (ε / 2) (δ / 2) with ht
  have ht0 : 0 < t := lt_min (by linarith) (by linarith)
  refine ⟨ringPt p (θ + s.sign * t), ⟨t, ⟨ht0, lt_of_le_of_lt (min_le_right _ _) (by linarith)⟩, rfl⟩, ?_⟩
  have h1 := dist_ringPt_germ_le p θ s ht0.le
  have : t ≤ ε / 2 := min_le_left _ _
  linarith

/-- A germ on a (Q) arc puts its base point on a closed (Q) arc (the arc is closed). -/
theorem onQArc_of_germOnQ {p : ℂ} {θ : ℝ} {s : Side} (h : F.GermOnQ p θ s) : F.OnQArc p (ringPt p θ) := by
  obtain ⟨θ₁, θ₂, hQ, δ, hδ, hsub⟩ := h
  refine ⟨θ₁, θ₂, hQ, ?_⟩
  have hc : IsClosed (ringArc p θ₁ θ₂) := by
    have hcont : Continuous (ringPt p) := by unfold ringPt e; fun_prop
    exact (isCompact_Icc.image hcont).isClosed
  exact hc.closure_subset_iff.mpr hsub (ringPt_mem_closure_germ p θ s hδ)

/-- **FS116-RING-Q-PRIME-S** (carrying FS116-RING-Q-PRIME; at every `k` with at most two colours absent): a change point of
the ring of a vertex of at least four colours whose points at `±60°` lie on no closed (Q) arc is a vertex of at least four
colours. -/
theorem ringQPrimeS (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k} (hy : F.IsChangePoint p ψ X X')
    (hu : ¬ F.OnQArc p (ringPt p (ψ + π / 3))) (hv : ¬ F.OnQArc p (ringPt p (ψ - π / 3))) :
    4 ≤ (F.coloursAt (ringPt p ψ)).ncard :=
  germS_four hF hp h4 hk hy fun _ => ⟨fun hg => hu (onQArc_of_germOnQ hg), fun hg => hv (onQArc_of_germOnQ hg)⟩

/-! ## FS116-N1-QFREE4 (at every `k`) -/

/-- **FS116-N1-QFREE4** (at every `k`: the argument reads that at least two colours are absent): at a vertex of at least four
colours whose ring carries no (Q) arc, at least two colours are absent. At `k = 6`: "`p` has four colours and no more". -/
theorem qfree4 (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hq : ∀ θ₁ θ₂, ¬ F.IsQArc p θ₁ θ₂) : (F.coloursAt p).ncard + 2 ≤ k := by
  sorry

/-! ## FS116-N2-FIVERING (at every `k` with exactly one colour absent; the row is `k = 6`) -/

/-- **FS116-N2-FIVERING**, first clause (and FS116-RING-TRANSFER-C's "a ring of five colours has no change point"): the ring
of a vertex of at least four colours with exactly one colour absent has no change point. -/
theorem fiveRing_no_changePoint (hF : F.Valid) {p : ℂ} (_hp : F.Covers p 1) (_h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : (F.coloursAt p).ncard + 1 = k) (ψ : ℝ) (X X' : Fin k) : ¬ F.IsChangePoint p ψ X X' := by
  intro hy
  have := hy.ncard_add_two_le hF
  omega

/-- **FS116-N2-FIVERING**: for every `θ` outside a finite set, `r(θ)` or `r(θ + 60°)` lies on a (Q) arc. -/
theorem fiveRing_finite_off_Q (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : (F.coloursAt p).ncard + 1 = k) :
    {θ | θ ∈ Ico 0 (2 * π) ∧ ¬ F.OnQArc p (ringPt p θ) ∧ ¬ F.OnQArc p (ringPt p (θ + π / 3))}.Finite := by
  sorry

/-- **FS116-N2-FIVERING** (and FS112-SIX's five-colour clause): the (Q) arcs of the ring have total length at least `180°`
(arc-length of the set of angles in `[0, 2π)` whose ring point lies on a closed (Q) arc). -/
theorem fiveRing_length (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : (F.coloursAt p).ncard + 1 = k) : ENNReal.ofReal π ≤ arcLength {θ | F.OnQArc p (ringPt p θ)} := by
  sorry

/-- **FS116-N2-FIVERING**, last clause (and FS116-RING-TRANSFER-C's "places no vertex through RING-GERM"): `p` has no hub. -/
theorem fiveRing_no_hub (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : (F.coloursAt p).ncard + 1 = k) (ψ : ℝ) : ¬ F.IsHub p ψ := by
  rintro ⟨⟨X, X', hy⟩, -⟩
  exact fiveRing_no_changePoint hF hp h4 hk ψ X X' hy

/-! ## FS129-SR1-SIXQ -/

/-- **FS129-SR1-SIXQ** (carrying FS112-SIX's "its whole unit circle lies in `Γ`"): at a point carrying all `k` colours, on a
covered ring, `ω(p)` lies in `Γ`. -/
theorem sixQ_sphere_subset_Γ (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (hall : F.coloursAt p = univ) :
    sphere p 1 ⊆ F.Γ := by
  intro z hz
  by_contra hΓ
  have hzI := F.mem_interiorPts_of_notMem_Γ (hp (sphere_subset_closedBall hz)) hΓ
  exact not_mem_coloursAt_of_mem_sphere hF hz ⟨hzI, rfl⟩ (by rw [hall]; exact mem_univ _)

/-- **FS129-SR1-SIXQ**: both side colours of every arc of `Γ` on `ω(p)` are carried at `p`. -/
theorem sixQ_sides {p : ℂ} (hall : F.coloursAt p = univ) {θ₁ θ₂ : ℝ} {c c' : Fin k} (_hA : F.IsRingArc p θ₁ θ₂ c c') :
    c ∈ F.coloursAt p ∧ c' ∈ F.coloursAt p := by
  rw [hall]; exact ⟨mem_univ _, mem_univ _⟩

/-- **FS129-SR1-SIXQ**, the (Q) clause (at every `k ≥ 4`; the row is `k = 6`, "every arc of kind both" of FS112-SIX): when
`p` carries all colours, every arc of `Γ` on `ω(p)` is a (Q) arc. -/
theorem sixQ_isQArc (hk : 4 ≤ k) {p : ℂ} (hall : F.coloursAt p = univ) {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (h : F.IsRingArc p θ₁ θ₂ c c') : F.IsQArc p θ₁ θ₂ := by
  refine ⟨c, c', h, by rw [hall]; exact mem_univ _, by rw [hall]; exact mem_univ _, ?_⟩
  rw [hall, Set.ncard_univ, Nat.card_eq_fintype_card, Fintype.card_fin]
  exact hk

/-- SIXQ's hypotheses are inhabited by FS116-Y2-SIXFRAG: a valid six-coloured fragment covering `B̄(0, 1)` with all six
colours at `0`, and an arc of `Γ` on `ω(0)`. -/
theorem sixQ_inhabited : sixFrag.Valid ∧ sixFrag.Covers 0 1 ∧ sixFrag.coloursAt 0 = univ ∧
    sixFrag.IsRingArc 0 0 (π / 6) 0 2 :=
  ⟨sixFrag_valid, sixFrag_covers (by norm_num), sixFrag_coloursAt_zero, sixFrag_isRingArc⟩

/-! ## FS129-SR2-TOUCHW (at every `k` with exactly two colours absent; the row is `k = 6`) -/

/-- **FS129-SR2-TOUCHW** (carrying FS116-N1-TOUCH, its idle hypothesis "w in the closure of a tile of one of `p`'s colours"
dropped): at a vertex of at least four colours with exactly two colours absent, let `w = r(ψ)` be no change point, on no arc
of `Γ` on `ω(p)`, with none of the four germs at `ψ ± 60°` on a (Q) arc. Then the ring just clockwise and just
counter-clockwise of `w` lies in one colour `X` absent at `p`; each of the four germs lies in the closure of the class of the
other absent colour `X'` (`X̄`) and has no point in the closure of the class of `X`; and `X'` is not carried at `w`. -/
theorem touchW (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : (F.coloursAt p).ncard + 2 = k) {ψ : ℝ} (hnc : ∀ X X', ¬ F.IsChangePoint p ψ X X')
    (hna : ¬ F.OnRingArc p (ringPt p ψ))
    (hq : ∀ s, ¬ F.GermOnQ p (ψ + π / 3) s ∧ ¬ F.GermOnQ p (ψ - π / 3) s) :
    ∃ X X', X ≠ X' ∧ (F.coloursAt p)ᶜ = {X, X'} ∧
      GermIn p ψ .cw (F.region X) ∧ GermIn p ψ .ccw (F.region X) ∧
      (∀ θ ∈ ({ψ + π / 3, ψ - π / 3} : Set ℝ), ∀ s,
        GermIn p θ s (closure (F.region X')) ∧ GermIn p θ s (closure (F.region X))ᶜ) ∧
      X' ∉ F.coloursAt (ringPt p ψ) := by
  sorry

/-! ## FS116-N1-ECHO (any valid map; the radius-2 hypothesis is idle) -/

/-- **FS116-N1-ECHO**, the engine: if the ring just clockwise and just counter-clockwise of `w = r(ψ)` lies in the class of a
colour `X` absent at `p`, the only point of the closure of the class of `X` at distance `1` from `w` is `2w − p`. -/
theorem echo_unique (hF : F.Valid) {p : ℂ} {ψ : ℝ} {X : Fin k} (hcw : GermIn p ψ .cw (F.region X))
    (hccw : GermIn p ψ .ccw (F.region X)) (hX : X ∉ F.coloursAt p) {x : ℂ} (hx : x ∈ closure (F.region X))
    (h1 : dist x (ringPt p ψ) = 1) : x = 2 * ringPt p ψ - p := by
  set B : ℂ := (x - p) * (starRingEnd ℂ) (e ψ) with hB
  have hconj : (starRingEnd ℂ) (e ψ) * e ψ = 1 := by
    rw [mul_comm, Complex.mul_conj, Complex.normSq_eq_norm_sq, norm_e]; simp
  have hxp : x - p = B * e ψ := by rw [hB, mul_assoc, hconj, mul_one]
  have hB1 : ‖B - 1‖ = 1 := by
    have : x - ringPt p ψ = (B - 1) * e ψ := by
      simp only [ringPt]; rw [sub_mul, one_mul, ← hxp]; ring
    rw [dist_eq_norm, this, norm_mul, norm_e, mul_one] at h1
    exact h1
  have hdist : ∀ τ : ℝ, ‖x - ringPt p (ψ + τ)‖ = ‖B - e τ‖ := by
    intro τ
    have : x - ringPt p (ψ + τ) = (B - e τ) * e ψ := by
      simp only [ringPt]; rw [e_add, sub_mul, ← hxp]; ring
    rw [this, norm_mul, norm_e, mul_one]
  have hcirc : (B.re - 1) ^ 2 + B.im ^ 2 = 1 := by
    have h := congrArg (· ^ 2) hB1
    simp only [Complex.sq_norm, Complex.normSq_apply, Complex.sub_re, Complex.one_re, Complex.sub_im,
      Complex.one_im] at h
    nlinarith [h]
  have hg : ∀ τ : ℝ, ‖B - e τ‖ ^ 2 - 1 = -2 * (B.re * (Real.cos τ - 1) + B.im * Real.sin τ) := by
    intro τ
    have h1' := hcirc
    rw [Complex.sq_norm, Complex.normSq_apply, e_eq]
    simp only [Complex.sub_re, Complex.sub_im, Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im,
      Complex.ofReal_re, Complex.ofReal_im, Complex.I_re, Complex.I_im]
    nlinarith [Real.sin_sq_add_cos_sq τ]
  by_cases hb2 : B.im = 0
  · -- the radial case
    have hb1 : B.re = 0 ∨ B.re = 2 := by
      have := hcirc
      rw [hb2] at this
      have h2 : B.re * (B.re - 2) = 0 := by nlinarith [this]
      rcases mul_eq_zero.mp h2 with h | h
      · exact Or.inl h
      · exact Or.inr (by linarith)
    rcases hb1 with h0 | h2
    · exfalso
      have hBz : B = 0 := Complex.ext (by simpa using h0) (by simpa using hb2)
      have hxp0 : x = p := by rw [hBz, zero_mul] at hxp; exact sub_eq_zero.mp hxp
      apply hX
      show p ∈ closure (F.region X)
      rw [← hxp0]; exact hx
    · have hBz : B = 2 := Complex.ext (by simpa using h2) (by simpa using hb2)
      rw [hBz] at hxp
      simp only [ringPt]
      linear_combination hxp
  · exfalso
    obtain ⟨δ₁, hδ₁, hsub₁⟩ := hcw
    obtain ⟨δ₂, hδ₂, hsub₂⟩ := hccw
    set δ := min δ₁ δ₂ with hδ
    have hδ0 : 0 < δ := lt_min hδ₁ hδ₂
    have hSsub : (fun τ : ℝ => ringPt p (ψ + τ)) '' Ioo (-δ) δ ⊆ closure (F.region X) := by
      rintro _ ⟨τ, hτ, rfl⟩
      show ringPt p (ψ + τ) ∈ closure (F.region X)
      rcases lt_trichotomy τ 0 with hneg | hzero | hpos
      · refine subset_closure (hsub₁ ?_)
        refine ⟨-τ, ⟨by linarith, by linarith [hτ.1, min_le_left δ₁ δ₂]⟩, ?_⟩
        simp [Side.sign]
      · rw [hzero, add_zero]
        rw [Metric.mem_closure_iff]
        intro ε hε
        set t := min (ε / 2) (δ₂ / 2) with ht
        have ht0 : 0 < t := lt_min (by linarith) (by linarith)
        have hmem : ringPt p (ψ + Side.sign .ccw * t) ∈ F.region X :=
          hsub₂ ⟨t, ⟨ht0, lt_of_le_of_lt (min_le_right _ _) (by linarith)⟩, rfl⟩
        refine ⟨_, hmem, ?_⟩
        have := dist_ringPt_germ_le p ψ .ccw ht0.le
        have : t ≤ ε / 2 := min_le_left _ _
        linarith [dist_ringPt_germ_le p ψ .ccw ht0.le]
      · refine subset_closure (hsub₂ ?_)
        exact ⟨τ, ⟨hpos, by linarith [hτ.2, min_le_right δ₁ δ₂]⟩, by simp [Side.sign]⟩
    have hSc : IsPreconnected ((fun τ : ℝ => ringPt p (ψ + τ)) '' Ioo (-δ) δ) := by
      have hc : Continuous fun τ : ℝ => ringPt p (ψ + τ) := by unfold ringPt e; fun_prop
      exact isPreconnected_Ioo.image _ hc.continuousOn
    set s := min (min 1 (|B.im| / 4)) (δ / 2) with hs
    have hs0 : 0 < s := lt_min (lt_min one_pos (by positivity)) (by linarith)
    have hs1 : s ≤ 1 := (min_le_left _ _).trans (min_le_left _ _)
    have hs2 : s ≤ |B.im| / 4 := (min_le_left _ _).trans (min_le_right _ _)
    have hs3 : s ≤ δ / 2 := min_le_right _ _
    have hBn : ‖B‖ ≤ 2 := by
      have := norm_le_norm_add_norm_sub' B 1
      calc ‖B‖ ≤ ‖B - 1‖ + ‖(1 : ℂ)‖ := by simpa using norm_sub_norm_le B 1 |> fun _ => (by
            have := norm_add_le (B - 1) 1; simpa using this)
        _ = 2 := by rw [hB1]; norm_num
    have hb1 : |B.re| ≤ 2 := (Complex.abs_re_le_norm B).trans hBn
    have hcos : |Real.cos s - 1| ≤ s ^ 2 / 2 := by
      have h1 := Real.one_sub_sq_div_two_le_cos (x := s)
      have h2 := Real.cos_le_one s
      rw [abs_le]; constructor <;> linarith
    have hsin : s / 2 ≤ Real.sin s := by
      have h := Real.mul_le_sin hs0.le (by linarith [Real.pi_gt_three] : s ≤ π / 2)
      have h4 : π ≤ 4 := Real.pi_le_four
      have : s / 2 ≤ 2 / π * s := by
        rw [div_mul_eq_mul_div, le_div_iff₀ Real.pi_pos]; nlinarith
      linarith
    have hsin0 : 0 < Real.sin s := lt_of_lt_of_le (by linarith) hsin
    have hk : |B.re * (Real.cos s - 1)| < |B.im * Real.sin s| := by
      rw [abs_mul, abs_mul, abs_of_pos hsin0]
      have hb2' : 0 < |B.im| := abs_pos.mpr hb2
      calc |B.re| * |Real.cos s - 1| ≤ 2 * (s ^ 2 / 2) := by gcongr
        _ = s ^ 2 := by ring
        _ < |B.im| * (s / 2) := by nlinarith
        _ ≤ |B.im| * Real.sin s := by gcongr
    have hu_mem : ringPt p (ψ + s) ∈ (fun τ : ℝ => ringPt p (ψ + τ)) '' Ioo (-δ) δ :=
      ⟨s, ⟨by linarith, by linarith⟩, rfl⟩
    have hv_mem : ringPt p (ψ + (-s)) ∈ (fun τ : ℝ => ringPt p (ψ + τ)) '' Ioo (-δ) δ :=
      ⟨-s, ⟨by linarith, by linarith⟩, rfl⟩
    have hgs := hg s
    have hgm : ‖B - e (-s)‖ ^ 2 - 1 = -2 * (B.re * (Real.cos s - 1) - B.im * Real.sin s) := by
      rw [hg (-s), Real.cos_neg, Real.sin_neg]; ring
    have hdu : dist x (ringPt p (ψ + s)) = ‖B - e s‖ := by rw [dist_eq_norm, hdist]
    have hdv : dist x (ringPt p (ψ + (-s))) = ‖B - e (-s)‖ := by rw [dist_eq_norm, hdist]
    have hlt : ∀ r : ℝ, 0 ≤ r → r ^ 2 - 1 < 0 → r < 1 := fun r hr h => by nlinarith
    have hgt : ∀ r : ℝ, 0 ≤ r → 0 < r ^ 2 - 1 → 1 < r := fun r hr h => by nlinarith
    rcases lt_or_gt_of_ne hb2 with hneg | hpos
    · -- B.im < 0 : the point at ψ - s is nearer, ψ + s is farther
      have hm : B.im * Real.sin s < 0 := mul_neg_of_neg_of_pos hneg hsin0
      have hk' := abs_lt.mp hk
      rw [abs_of_neg hm] at hk'
      refine hF.false_of_crossing hx hSc hSsub hv_mem hu_mem (hdv ▸ hlt _ (norm_nonneg _) (by linarith [hgm, hk'.1, hk'.2]))
        (hdu ▸ hgt _ (norm_nonneg _) (by linarith [hgs, hk'.1, hk'.2]))
    · have hm : 0 < B.im * Real.sin s := mul_pos hpos hsin0
      have hk' := abs_lt.mp hk
      rw [abs_of_pos hm] at hk'
      refine hF.false_of_crossing hx hSc hSsub hu_mem hv_mem (hdu ▸ hlt _ (norm_nonneg _) (by linarith [hgs, hk'.1, hk'.2]))
        (hdv ▸ hgt _ (norm_nonneg _) (by linarith [hgm, hk'.1, hk'.2]))

/-- **FS116-N1-ECHO** at the class its argument reads: some point of the closure of the class of `X` at distance `1` from `w`
puts `2w − p` in that closure. -/
theorem echo_of_mem_closure (hF : F.Valid) {p : ℂ} {ψ : ℝ} {X : Fin k} (hcw : GermIn p ψ .cw (F.region X))
    (hccw : GermIn p ψ .ccw (F.region X)) (hX : X ∉ F.coloursAt p)
    (hpt : ∃ x ∈ closure (F.region X), dist x (ringPt p ψ) = 1) : X ∈ F.coloursAt (2 * ringPt p ψ - p) := by
  obtain ⟨x, hx, h1⟩ := hpt
  have := echo_unique hF hcw hccw hX hx h1
  rw [← this]; exact hx

/-- **FS116-N1-ECHO**, the row's form (reading (B)): if `w` is an essential boundary point at which the map is saturated and
`X` is in `w`'s essential multicolour, `2w − p` lies in the closure of the class of `X`. -/
theorem echo (hF : F.Valid) {p : ℂ} {ψ : ℝ} {X : Fin k} (hcw : GermIn p ψ .cw (F.region X))
    (hccw : GermIn p ψ .ccw (F.region X)) (hX : X ∉ F.coloursAt p) (_hess : F.IsEssBoundary (ringPt p ψ))
    (hsat : F.SaturatedAt (ringPt p ψ)) (hXw : X ∈ F.essColours (ringPt p ψ)) :
    X ∈ F.coloursAt (2 * ringPt p ψ - p) := by
  obtain ⟨x, hx, h1⟩ := hsat X hXw
  refine echo_of_mem_closure hF hcw hccw hX ⟨x, ?_, h1⟩
  rw [Metric.mem_closure_iff]
  intro ε hε
  have hpos := hx ε hε
  obtain ⟨z, hz⟩ := MeasureTheory.nonempty_of_measure_ne_zero hpos.ne'
  exact ⟨z, hz.1, by rw [dist_comm]; exact hz.2⟩

/-! ## FS116-V5-U1 (any valid map) -/

/-- A side of a ring arc: if every colour whose class meets the open set `O` arbitrarily near `a` is `c`, then a small ball
about `a` meets `O` only inside the closure of the class of `c` (the interior points are dense). -/
theorem side_ball_subset_closure {O : Set ℂ} (hO : IsOpen O) {a : ℂ} (ha : a ∈ F.dom) {c : Fin k}
    (hc : ∀ d, a ∈ closure (F.region d ∩ O) → d = c) : ∃ ε > 0, ball a ε ∩ O ⊆ closure (F.region c) := by
  classical
  have hev : ∀ᶠ y in 𝓝 a, ∀ d, d ≠ c → y ∉ F.region d ∩ O := by
    refine Filter.eventually_all.2 fun d => ?_
    by_cases hd : d = c
    · exact Filter.Eventually.of_forall fun y h => absurd hd h
    · have : a ∉ closure (F.region d ∩ O) := fun h => hd (hc d h)
      exact (isClosed_closure.isOpen_compl.eventually_mem this).mono fun y hy _ hy' => hy (subset_closure hy')
  obtain ⟨ε, hε, hball⟩ := Metric.mem_nhds_iff.mp (hev.and (F.isOpen_dom.mem_nhds ha))
  refine ⟨ε, hε, ?_⟩
  rintro y ⟨hya, hyO⟩
  rw [_root_.mem_closure_iff]
  intro o ho hyo
  have hyd : y ∈ F.dom := (hball hya).2
  have hy' := F.dense_interiorPts hyd
  obtain ⟨w, hw, hwI⟩ := _root_.mem_closure_iff.mp hy' (o ∩ (ball a ε ∩ O)) (ho.inter (isOpen_ball.inter hO))
    ⟨hyo, hya, hyO⟩
  refine ⟨w, hw.1, ?_⟩
  have hcol : F.col w = c := by
    by_contra hne
    exact (hball hw.2.1).1 (F.col w) hne ⟨⟨hwI, rfl⟩, hw.2.2⟩
  exact ⟨hwI, hcol⟩

/-- `‖a − b‖²` in terms of `Re(a b̄)`. -/
theorem norm_sub_sq_eq (a b : ℂ) : ‖a - b‖ ^ 2 = ‖a‖ ^ 2 - 2 * (a * (starRingEnd ℂ) b).re + ‖b‖ ^ 2 := by
  simp only [Complex.sq_norm, Complex.normSq_apply, Complex.sub_re, Complex.sub_im, Complex.mul_re,
    Complex.conj_re, Complex.conj_im]
  ring

/-- The distance from `z + h` to the radial point `z + t e θ`, squared. -/
theorem norm_sq_sub_radial (h : ℂ) (t θ : ℝ) :
    ‖h - (t : ℂ) * e θ‖ ^ 2 = ‖h‖ ^ 2 - 2 * t * (h * (starRingEnd ℂ) (e θ)).re + t ^ 2 := by
  rw [norm_sub_sq_eq, norm_mul, norm_e, Complex.norm_real, Real.norm_eq_abs, mul_one, sq_abs, map_mul,
    Complex.conj_ofReal, show h * ((t : ℂ) * (starRingEnd ℂ) (e θ)) = (t : ℂ) * (h * (starRingEnd ℂ) (e θ)) by ring,
    Complex.re_ofReal_mul]
  ring

/-- Re(h ē θ) in terms of a cone direction: for `h ≠ 0` with `‖h/‖h‖ − e β‖ < ε`,
`|Re(h conj eθ) − ‖h‖ cos(β − θ)| ≤ ‖h‖ ε`. -/
theorem re_mul_conj_e_bound {h : ℂ} (hh : h ≠ 0) {β θ ε : ℝ} (hu : ‖h / (‖h‖ : ℂ) - e β‖ < ε) :
    |(h * (starRingEnd ℂ) (e θ)).re - ‖h‖ * Real.cos (β - θ)| ≤ ‖h‖ * ε := by
  have hn : (‖h‖ : ℂ) ≠ 0 := by exact_mod_cast norm_ne_zero_iff.mpr hh
  have hhu : h = (‖h‖ : ℂ) * (h / (‖h‖ : ℂ)) := by field_simp
  have key : (h * (starRingEnd ℂ) (e θ)).re = ‖h‖ * ((h / (‖h‖ : ℂ)) * (starRingEnd ℂ) (e θ)).re := by
    have : h * (starRingEnd ℂ) (e θ) = (‖h‖ : ℂ) * ((h / (‖h‖ : ℂ)) * (starRingEnd ℂ) (e θ)) := by
      field_simp
    rw [this, Complex.re_ofReal_mul]
  have h1 : (h * (starRingEnd ℂ) (e θ)).re - ‖h‖ * Real.cos (β - θ) =
      ‖h‖ * ((h / (‖h‖ : ℂ) - e β) * (starRingEnd ℂ) (e θ)).re := by
    rw [key, sub_mul, Complex.sub_re, ← re_e_mul_conj_e β θ]
    ring
  rw [h1, abs_mul, abs_of_nonneg (norm_nonneg h)]
  refine mul_le_mul_of_nonneg_left ?_ (norm_nonneg h)
  calc |((h / (‖h‖ : ℂ) - e β) * (starRingEnd ℂ) (e θ)).re|
      ≤ ‖(h / (‖h‖ : ℂ) - e β) * (starRingEnd ℂ) (e θ)‖ := Complex.abs_re_le_norm _
    _ = ‖h / (‖h‖ : ℂ) - e β‖ := by rw [norm_mul, Complex.norm_conj, norm_e, mul_one]
    _ ≤ ε := hu.le

/-- **The radial lemma, inner side** (child of FS116-V5-U1): if the radial segment `z + t e θ`, `t ∈ (1 − η₀, 1)`, lies in
the closure of the class of `c`, the class approaches `z` only along directions `β` with `cos(β − θ) ≥ 0`. -/
theorem Valid.cos_nonneg_of_radial_inner (hF : F.Valid) {z : ℂ} {θ : ℝ} {c : Fin k} {η₀ : ℝ} (hη₀ : 0 < η₀)
    (hseg : ∀ t ∈ Ioo (1 - η₀) 1, z + (t : ℂ) * e θ ∈ closure (F.region c)) :
    ∀ β ∈ coneAt (F.region c) z, 0 ≤ Real.cos (β - θ) := by
  intro β hβ
  by_contra hneg
  push Not at hneg
  set κ := -Real.cos (β - θ) with hκ
  have hκ0 : 0 < κ := by rw [hκ]; linarith
  have hκ1 : κ ≤ 1 := by rw [hκ]; linarith [Real.neg_one_le_cos (β - θ)]
  set ε := min (min (η₀ / 4) (κ / 2)) (1 / 4) with hε
  have hε0 : 0 < ε := lt_min (lt_min (by linarith) (by linarith)) (by norm_num)
  have hε1 : ε ≤ η₀ / 4 := (min_le_left _ _).trans (min_le_left _ _)
  have hε2 : ε ≤ κ / 2 := (min_le_left _ _).trans (min_le_right _ _)
  have hε3 : ε ≤ 1 / 4 := min_le_right _ _
  obtain ⟨z', hz', hzz, hzd, hzu⟩ := hβ ε hε0
  set h := z' - z with hh
  have hh0 : h ≠ 0 := sub_ne_zero.mpr hzz
  set ρ := ‖h‖ with hρ
  have hρ0 : 0 < ρ := norm_pos_iff.mpr hh0
  have hρε : ρ < ε := by rw [hρ, hh, ← dist_eq_norm]; exact hzd
  have hre := re_mul_conj_e_bound hh0 (θ := θ) hzu
  have hre' : (h * (starRingEnd ℂ) (e θ)).re ≤ ρ * (-κ + ε) := by
    have := (abs_le.mp hre).2
    rw [hκ] at *; nlinarith
  have hreneg : (h * (starRingEnd ℂ) (e θ)).re ≤ -(ρ * κ / 2) := by nlinarith
  have hdist : ∀ t : ℝ, dist z' (z + (t : ℂ) * e θ) ^ 2 =
      ρ ^ 2 - 2 * t * (h * (starRingEnd ℂ) (e θ)).re + t ^ 2 := by
    intro t
    rw [dist_eq_norm, show z' - (z + (t : ℂ) * e θ) = h - (t : ℂ) * e θ by rw [hh]; ring, norm_sq_sub_radial]
  have hS : IsPreconnected ((fun t : ℝ => z + (t : ℂ) * e θ) '' Ioo (1 - η₀) 1) := by
    have hc : Continuous fun t : ℝ => z + (t : ℂ) * e θ := by fun_prop
    exact isPreconnected_Ioo.image _ hc.continuousOn
  have hSc : (fun t : ℝ => z + (t : ℂ) * e θ) '' Ioo (1 - η₀) 1 ⊆ closure (F.region c) := by
    rintro _ ⟨t, ht, rfl⟩; exact hseg t ht
  -- the near point `t = 1 − 2ρ` and the far point `t = 1 − κρ/4`
  have htn : (1 - 2 * ρ) ∈ Ioo (1 - η₀) 1 := ⟨by linarith, by linarith⟩
  have htf : (1 - κ * ρ / 4) ∈ Ioo (1 - η₀) 1 :=
    ⟨by nlinarith, by nlinarith⟩
  refine hF.false_of_crossing (subset_closure hz') hS hSc (u := z + ((1 - 2 * ρ : ℝ) : ℂ) * e θ)
    (v := z + ((1 - κ * ρ / 4 : ℝ) : ℂ) * e θ) ⟨_, htn, rfl⟩ ⟨_, htf, rfl⟩ ?_ ?_
  · have h1 := hdist (1 - 2 * ρ)
    have hd0 := dist_nonneg (x := z') (y := z + ((1 - 2 * ρ : ℝ) : ℂ) * e θ)
    have hRe : -(ρ) ≤ (h * (starRingEnd ℂ) (e θ)).re := by
      have := Complex.abs_re_le_norm (h * (starRingEnd ℂ) (e θ))
      rw [norm_mul, Complex.norm_conj, norm_e, mul_one] at this
      linarith [neg_abs_le (h * (starRingEnd ℂ) (e θ)).re]
    by_contra hge
    push Not at hge
    nlinarith
  · have h1 := hdist (1 - κ * ρ / 4)
    have hd0 := dist_nonneg (x := z') (y := z + ((1 - κ * ρ / 4 : ℝ) : ℂ) * e θ)
    set x := κ * ρ / 4 with hx
    have hx0 : 0 < x := by positivity
    have hx1 : x ≤ 1 / 16 := by
      have : κ * ρ ≤ 1 * ε := mul_le_mul hκ1 hρε.le hρ0.le (by norm_num)
      rw [hx]; linarith
    have hR : (h * (starRingEnd ℂ) (e θ)).re ≤ -(2 * x) := by rw [hx]; linarith
    have h2 : 4 * x * (1 - x) ≤ -2 * (1 - x) * (h * (starRingEnd ℂ) (e θ)).re := by
      nlinarith
    have h3 : 1 < dist z' (z + ((1 - x : ℝ) : ℂ) * e θ) ^ 2 := by
      rw [h1]; nlinarith [sq_nonneg ρ, mul_pos hρ0 hρ0]
    by_contra hle
    push Not at hle
    nlinarith

/-- Arithmetic of the outer radial lemma, near point. -/
theorem outer_near_arith {ρ κ R x : ℝ} (hρ0 : 0 < ρ) (hκ0 : 0 < κ) (hκ1 : κ ≤ 1) (hρκ : ρ ≤ κ / 4)
    (hR : ρ * κ * (3 / 4) ≤ R) (hx : x = κ * ρ / 2) : ρ ^ 2 - 2 * (1 + x) * R + (1 + x) ^ 2 < 1 := by
  have hr : 0 < ρ * κ := mul_pos hρ0 hκ0
  have hx0 : 0 < x := by rw [hx]; positivity
  have h1 : -2 * (1 + x) * R ≤ -(3 / 2) * (1 + x) * (ρ * κ) := by nlinarith
  have h2 : ρ ^ 2 ≤ ρ * κ / 4 := by nlinarith
  have h3 : x ≤ ρ / 2 := by rw [hx]; nlinarith
  have h4 : x ^ 2 ≤ ρ * κ / 16 := by
    have e1 : x ^ 2 = κ ^ 2 * ρ ^ 2 / 4 := by rw [hx]; ring
    have e2 : κ ^ 2 * ρ ^ 2 ≤ κ ^ 2 * (ρ * κ / 4) := mul_le_mul_of_nonneg_left h2 (sq_nonneg κ)
    have e3 : ρ * κ * κ ^ 2 ≤ ρ * κ := mul_le_of_le_one_right hr.le (by nlinarith)
    nlinarith
  have hx2 : 2 * x = κ * ρ := by rw [hx]; ring
  have h5 : 0 ≤ x * (ρ * κ) := by positivity
  nlinarith

/-- Arithmetic of the outer radial lemma, far point. -/
theorem outer_far_arith {ρ R : ℝ} (hρ0 : 0 < ρ) (hR : R ≤ ρ) : 1 < ρ ^ 2 - 2 * (1 + 2 * ρ) * R + (1 + 2 * ρ) ^ 2 := by
  have : -2 * (1 + 2 * ρ) * R ≥ -2 * (1 + 2 * ρ) * ρ := by nlinarith
  nlinarith

/-- **The radial lemma, outer side** (child of FS116-V5-U1): if the radial segment `z + t e θ`, `t ∈ (1, 1 + η₀)`, lies in
the closure of the class of `c'`, the class approaches `z` only along directions `β` with `cos(β − θ) ≤ 0`. -/
theorem Valid.cos_nonpos_of_radial_outer (hF : F.Valid) {z : ℂ} {θ : ℝ} {c : Fin k} {η₀ : ℝ} (hη₀ : 0 < η₀)
    (hseg : ∀ t ∈ Ioo 1 (1 + η₀), z + (t : ℂ) * e θ ∈ closure (F.region c)) :
    ∀ β ∈ coneAt (F.region c) z, Real.cos (β - θ) ≤ 0 := by
  intro β hβ
  by_contra hneg
  push Not at hneg
  set κ := Real.cos (β - θ) with hκ
  have hκ0 : 0 < κ := hneg
  have hκ1 : κ ≤ 1 := Real.cos_le_one _
  set ε := min (min (η₀ / 4) (κ / 4)) (1 / 4) with hε
  have hε0 : 0 < ε := lt_min (lt_min (by linarith) (by linarith)) (by norm_num)
  have hε1 : ε ≤ η₀ / 4 := (min_le_left _ _).trans (min_le_left _ _)
  have hε2 : ε ≤ κ / 4 := (min_le_left _ _).trans (min_le_right _ _)
  obtain ⟨z', hz', hzz, hzd, hzu⟩ := hβ ε hε0
  set h := z' - z with hh
  have hh0 : h ≠ 0 := sub_ne_zero.mpr hzz
  set ρ := ‖h‖ with hρ
  have hρ0 : 0 < ρ := norm_pos_iff.mpr hh0
  have hρε : ρ < ε := by rw [hρ, hh, ← dist_eq_norm]; exact hzd
  have hre := re_mul_conj_e_bound hh0 (θ := θ) hzu
  set R := (h * (starRingEnd ℂ) (e θ)).re with hR
  have hR1 : ρ * (κ - ε) ≤ R := by
    have := (abs_le.mp hre).1
    rw [← hρ, ← hκ] at this; nlinarith
  have hR2 : R ≤ ρ := by
    have := Complex.abs_re_le_norm (h * (starRingEnd ℂ) (e θ))
    rw [norm_mul, Complex.norm_conj, norm_e, mul_one] at this
    linarith [le_abs_self R]
  have hRpos : ρ * κ * (3 / 4) ≤ R := by nlinarith
  have hdist : ∀ t : ℝ, dist z' (z + (t : ℂ) * e θ) ^ 2 = ρ ^ 2 - 2 * t * R + t ^ 2 := by
    intro t
    rw [dist_eq_norm, show z' - (z + (t : ℂ) * e θ) = h - (t : ℂ) * e θ by rw [hh]; ring, norm_sq_sub_radial]
  have hS : IsPreconnected ((fun t : ℝ => z + (t : ℂ) * e θ) '' Ioo 1 (1 + η₀)) := by
    have hc : Continuous fun t : ℝ => z + (t : ℂ) * e θ := by fun_prop
    exact isPreconnected_Ioo.image _ hc.continuousOn
  have hSc : (fun t : ℝ => z + (t : ℂ) * e θ) '' Ioo 1 (1 + η₀) ⊆ closure (F.region c) := by
    rintro _ ⟨t, ht, rfl⟩; exact hseg t ht
  have hxρ : κ * ρ / 2 ≤ ρ / 2 := by nlinarith
  have htn : (1 + κ * ρ / 2) ∈ Ioo 1 (1 + η₀) := ⟨by nlinarith [mul_pos hκ0 hρ0], by nlinarith⟩
  have htf : (1 + 2 * ρ) ∈ Ioo 1 (1 + η₀) := ⟨by linarith, by linarith⟩
  refine hF.false_of_crossing (subset_closure hz') hS hSc (u := z + ((1 + κ * ρ / 2 : ℝ) : ℂ) * e θ)
    (v := z + ((1 + 2 * ρ : ℝ) : ℂ) * e θ) ⟨_, htn, rfl⟩ ⟨_, htf, rfl⟩ ?_ ?_
  · have h1 := hdist (1 + κ * ρ / 2)
    have hd0 := dist_nonneg (x := z') (y := z + ((1 + κ * ρ / 2 : ℝ) : ℂ) * e θ)
    have h3 := outer_near_arith hρ0 hκ0 hκ1 (by linarith) hRpos rfl
    rw [← h1] at h3
    by_contra hge
    push Not at hge
    nlinarith
  · have h1 := hdist (1 + 2 * ρ)
    have hd0 := dist_nonneg (x := z') (y := z + ((1 + 2 * ρ : ℝ) : ℂ) * e θ)
    have h3 := outer_far_arith hρ0 hR2
    rw [← h1] at h3
    by_contra hle
    push Not at hle
    nlinarith

/-- Cosine nonnegative against every angle of `(θ₁, θ₂)` puts `β` in the angular interval `[θ₂ − 90°, θ₁ + 90°]`. -/
theorem mem_angleIcc_of_cos_nonneg {θ₁ θ₂ β : ℝ} (h12 : θ₁ < θ₂)
    (h : ∀ θ ∈ Ioo θ₁ θ₂, 0 ≤ Real.cos (β - θ)) : β ∈ angleIcc (θ₂ - π / 2) (θ₁ + π / 2) := by
  have hπ := Real.pi_pos
  have hcl : IsClosed {θ : ℝ | 0 ≤ Real.cos (β - θ)} :=
    isClosed_le continuous_const (by fun_prop)
  have hIcc : ∀ θ ∈ Icc θ₁ θ₂, 0 ≤ Real.cos (β - θ) := by
    have : closure (Ioo θ₁ θ₂) ⊆ {θ : ℝ | 0 ≤ Real.cos (β - θ)} := closure_minimal h hcl
    rw [closure_Ioo h12.ne] at this
    exact fun θ hθ => this hθ
  set m : ℤ := round ((β - θ₁) / (2 * π)) with hm
  set β₀ := β - 2 * π * m with hβ₀
  have hcosβ₀ : ∀ θ, Real.cos (β₀ - θ) = Real.cos (β - θ) := by
    intro θ
    rw [hβ₀, show β - 2 * π * m - θ = (β - θ) - m * (2 * π) by ring, Real.cos_sub_int_mul_two_pi]
  have hr : |(β - θ₁) / (2 * π) - m| ≤ 1 / 2 := abs_sub_round _
  have hβ₀θ : |β₀ - θ₁| ≤ π := by
    have : β₀ - θ₁ = 2 * π * ((β - θ₁) / (2 * π) - m) := by
      rw [hβ₀]; field_simp; ring
    rw [this, abs_mul, abs_of_pos (by positivity : 0 < 2 * π)]
    nlinarith [abs_nonneg ((β - θ₁) / (2 * π) - m)]
  have hc1 : 0 ≤ Real.cos (β₀ - θ₁) := by rw [hcosβ₀]; exact hIcc θ₁ ⟨le_rfl, h12.le⟩
  have hβ₀1 : |β₀ - θ₁| ≤ π / 2 := by
    by_contra hgt
    push Not at hgt
    rcases le_or_gt 0 (β₀ - θ₁) with hpos | hneg
    · rw [abs_of_nonneg hpos] at hgt hβ₀θ
      have := Real.cos_neg_of_pi_div_two_lt_of_lt hgt (by linarith)
      linarith
    · rw [abs_of_neg hneg] at hgt hβ₀θ
      have := Real.cos_neg_of_pi_div_two_lt_of_lt (x := θ₁ - β₀) (by linarith) (by linarith)
      rw [← Real.cos_neg, neg_sub] at hc1
      linarith
  have hβ₀2 : θ₂ - π / 2 ≤ β₀ := by
    by_contra hlt
    push Not at hlt
    set ε₀ := min (π / 2) ((θ₂ - (β₀ + π / 2)) / 2) with hε₀
    have hε0 : 0 < ε₀ := lt_min (by linarith) (by linarith)
    have hε1 : ε₀ ≤ π / 2 := min_le_left _ _
    have hε2 : ε₀ ≤ (θ₂ - (β₀ + π / 2)) / 2 := min_le_right _ _
    have hθ : β₀ + π / 2 + ε₀ ∈ Ioo θ₁ θ₂ := by
      constructor
      · have := (abs_le.mp hβ₀1).1; linarith
      · linarith
    have := h _ hθ
    rw [← hcosβ₀, show β₀ - (β₀ + π / 2 + ε₀) = -(π / 2 + ε₀) by ring, Real.cos_neg] at this
    have := Real.cos_neg_of_pi_div_two_lt_of_lt (x := π / 2 + ε₀) (by linarith) (by linarith)
    linarith
  refine mem_iUnion.mpr ⟨m, ?_, ?_⟩
  · have : β = β₀ + 2 * π * m := by rw [hβ₀]; ring
    linarith
  · have : β = β₀ + 2 * π * m := by rw [hβ₀]; ring
    have := (abs_le.mp hβ₀1).2
    linarith

/-- The radial segment just inside an arc of `Γ` on `ω(z)` lies in the closure of the inner colour's class. -/
theorem IsRingArc.radial_inner {z : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') {θ : ℝ}
    (hθ : θ ∈ Ioo θ₁ θ₂) : ∃ η₀ : ℝ, 0 < η₀ ∧ ∀ t ∈ Ioo (1 - η₀) 1, z + (t : ℂ) * e θ ∈ closure (F.region c) := by
  have ha : ringPt z θ ∈ F.dom := (hA.2.1 ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩).1
  have hin := (hA.2.2 θ hθ).1
  obtain ⟨ε, hε, hball⟩ := F.side_ball_subset_closure (O := ball z 1) isOpen_ball ha (c := c) fun d hd => by
    have : d ∈ F.innerColours z (ringPt z θ) := hd
    rw [hin] at this; exact this
  refine ⟨min ε 1, lt_min hε one_pos, fun t ht => hball ⟨?_, ?_⟩⟩
  · rw [mem_ball, dist_eq_norm, show z + (t : ℂ) * e θ - ringPt z θ = ((t - 1 : ℝ) : ℂ) * e θ by
      simp only [ringPt]; push_cast; ring, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs,
      abs_of_neg (by linarith [ht.2])]
    linarith [ht.1, min_le_left ε 1]
  · rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real,
      Real.norm_eq_abs, abs_of_pos (by linarith [ht.1, min_le_right ε 1])]
    exact ht.2

/-- The radial segment just outside an arc of `Γ` on `ω(z)` lies in the closure of the outer colour's class. -/
theorem IsRingArc.radial_outer {z : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') {θ : ℝ}
    (hθ : θ ∈ Ioo θ₁ θ₂) : ∃ η₀ : ℝ, 0 < η₀ ∧ ∀ t ∈ Ioo 1 (1 + η₀), z + (t : ℂ) * e θ ∈ closure (F.region c') := by
  have ha : ringPt z θ ∈ F.dom := (hA.2.1 ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩).1
  have hout := (hA.2.2 θ hθ).2
  obtain ⟨ε, hε, hball⟩ := F.side_ball_subset_closure (O := (closedBall z 1)ᶜ) isClosed_closedBall.isOpen_compl ha
    (c := c') fun d hd => by
    have : d ∈ F.outerColours z (ringPt z θ) := by
      show ringPt z θ ∈ closure (F.region d \ closedBall z 1)
      rwa [Set.sdiff_eq]
    rw [hout] at this; exact this
  refine ⟨ε, hε, fun t ht => hball ⟨?_, ?_⟩⟩
  · rw [mem_ball, dist_eq_norm, show z + (t : ℂ) * e θ - ringPt z θ = ((t - 1 : ℝ) : ℂ) * e θ by
      simp only [ringPt]; push_cast; ring, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos (by linarith [ht.1])]
    linarith [ht.2]
  · rw [mem_compl_iff, mem_closedBall, dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one,
      Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by linarith [ht.1])]
    linarith [ht.1]

/-- Angular intervals `[A, B]` and `(C, D)` are disjoint when `D ≤ A` and `B ≤ C + 2π`. -/
theorem disjoint_angleIcc_angleIoo_of_le {A B C D : ℝ} (h1 : D ≤ A) (h2 : B ≤ C + 2 * π) :
    Disjoint (angleIcc A B) (angleIoo C D) := by
  have hπ := Real.pi_pos
  rw [Set.disjoint_left]
  rintro x hx hx'
  obtain ⟨n, hn1, hn2⟩ := mem_iUnion.mp hx
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp hx'
  rcases lt_trichotomy n m with h | h | h
  · have : (n : ℝ) + 1 ≤ m := by exact_mod_cast h
    nlinarith
  · subst h; linarith
  · have : (m : ℝ) + 1 ≤ n := by exact_mod_cast h
    nlinarith

/-- Angular intervals `[A, B]` and `(C, D)` are disjoint when `B ≤ C` and `D ≤ A + 2π`. -/
theorem disjoint_angleIcc_angleIoo_of_le' {A B C D : ℝ} (h1 : B ≤ C) (h2 : D ≤ A + 2 * π) :
    Disjoint (angleIcc A B) (angleIoo C D) := by
  have hπ := Real.pi_pos
  rw [Set.disjoint_left]
  rintro x hx hx'
  obtain ⟨n, hn1, hn2⟩ := mem_iUnion.mp hx
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp hx'
  rcases lt_trichotomy n m with h | h | h
  · have : (n : ℝ) + 1 ≤ m := by exact_mod_cast h
    nlinarith
  · subst h; linarith
  · have : (m : ℝ) + 1 ≤ n := by exact_mod_cast h
    nlinarith

/-- **FS116-V5-U1**, inner side: if `A = r([θ₁, θ₂])` (about `z`) is an arc of `Γ` on `ω(z)` with inner colour `c`, the class
of `c` approaches `z` only within the closed cone `[θ₂ − 90°, θ₁ + 90°]` facing `A`. -/
theorem ringArc_cone_inner (hF : F.Valid) {z : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') :
    coneAt (F.region c) z ⊆ angleIcc (θ₂ - π / 2) (θ₁ + π / 2) := by
  intro β hβ
  refine mem_angleIcc_of_cos_nonneg hA.1 fun θ hθ => ?_
  obtain ⟨η₀, hη₀, hseg⟩ := hA.radial_inner hθ
  exact hF.cos_nonneg_of_radial_inner hη₀ hseg β hβ

/-- **FS116-V5-U1**, outer side: the class of the outer colour `c'` approaches `z` only within the closed cone
`[θ₂ + 90°, θ₁ + 270°]` facing away from `A`. -/
theorem ringArc_cone_outer (hF : F.Valid) {z : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') :
    coneAt (F.region c') z ⊆ angleIcc (θ₂ + π / 2) (θ₁ + 3 * π / 2) := by
  intro β hβ
  have h : β - π ∈ angleIcc (θ₂ - π / 2) (θ₁ + π / 2) := by
    refine mem_angleIcc_of_cos_nonneg hA.1 fun θ hθ => ?_
    obtain ⟨η₀, hη₀, hseg⟩ := hA.radial_outer hθ
    have := hF.cos_nonpos_of_radial_outer hη₀ hseg β hβ
    have h2 : Real.cos (β - π - θ) = -Real.cos (β - θ) := by
      rw [show β - π - θ = (β - θ) - π by ring, Real.cos_sub_pi]
    linarith
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp h
  exact mem_iUnion.mpr ⟨m, by linarith, by linarith⟩

/-- **FS116-V5-U1**: the open side cone `(θ₁ − 90°, θ₂ − 90°)` holds neither side colour. -/
theorem ringArc_sideCone_inner (hF : F.Valid) {z : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') :
    Disjoint (coneAt (F.region c) z ∪ coneAt (F.region c') z) (angleIoo (θ₁ - π / 2) (θ₂ - π / 2)) := by
  have hπ := Real.pi_pos
  rw [Set.disjoint_union_left]
  exact ⟨(disjoint_angleIcc_angleIoo_of_le (by linarith) (by linarith)).mono_left (ringArc_cone_inner hF hA),
    (disjoint_angleIcc_angleIoo_of_le (by linarith) (by linarith)).mono_left (ringArc_cone_outer hF hA)⟩

/-- **FS116-V5-U1**: the open side cone `(θ₁ + 90°, θ₂ + 90°)` holds neither side colour. -/
theorem ringArc_sideCone_outer (hF : F.Valid) {z : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') :
    Disjoint (coneAt (F.region c) z ∪ coneAt (F.region c') z) (angleIoo (θ₁ + π / 2) (θ₂ + π / 2)) := by
  have hπ := Real.pi_pos
  rw [Set.disjoint_union_left]
  exact ⟨(disjoint_angleIcc_angleIoo_of_le' (by linarith) (by linarith)).mono_left (ringArc_cone_inner hF hA),
    (disjoint_angleIcc_angleIoo_of_le (by linarith) (by linarith)).mono_left (ringArc_cone_outer hF hA)⟩

/-- **FS116-V5-U1**, "the side cones hold two further colours": at a point `z` of the domain, every direction of either open
side cone lies in the cone of a colour other than `c` and `c'`. (`z ∈ F.dom` is a hypothesis the row leaves implicit: off
the domain a side cone may hold no colour at all — plan § 3.3.) -/
theorem ringArc_sideCone_other (hF : F.Valid) {z : ℂ} (hz : z ∈ F.dom) {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hA : F.IsRingArc z θ₁ θ₂ c c') {β : ℝ}
    (hβ : β ∈ angleIoo (θ₁ - π / 2) (θ₂ - π / 2) ∪ angleIoo (θ₁ + π / 2) (θ₂ + π / 2)) :
    ∃ d, d ≠ c ∧ d ≠ c' ∧ β ∈ coneAt (F.region d) z := by
  obtain ⟨d, hd⟩ := F.exists_mem_coneAt_region hz β
  refine ⟨d, ?_, ?_, hd⟩
  · rintro rfl
    rcases hβ with h | h
    · exact Set.disjoint_left.mp (ringArc_sideCone_inner hF hA) (Or.inl hd) h
    · exact Set.disjoint_left.mp (ringArc_sideCone_outer hF hA) (Or.inl hd) h
  · rintro rfl
    rcases hβ with h | h
    · exact Set.disjoint_left.mp (ringArc_sideCone_inner hF hA) (Or.inr hd) h
    · exact Set.disjoint_left.mp (ringArc_sideCone_outer hF hA) (Or.inr hd) h

/-- **FS116-V5-U1**, the four-colour clause at the class it reads: if `z` (in the domain) carries both side colours of an arc
of `Γ` on `ω(z)` (the arc is both-kind), each colour has at most one tile with `z` in its closure, and each such tile's cone
at `z` is one closed angular interval, then `z` carries at least four colours. -/
theorem four_of_bothKind (hF : F.Valid) {z : ℂ} (hz : z ∈ F.dom) {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hA : F.IsRingArc z θ₁ θ₂ c c') (hc : c ∈ F.coloursAt z) (hc' : c' ∈ F.coloursAt z)
    (hone : ∀ d T T', F.TileOf d T → F.TileOf d T' → z ∈ closure T → z ∈ closure T' → T = T')
    (hint : ∀ T, F.IsTile T → z ∈ closure T → ∃ β₁ β₂, β₁ ≤ β₂ ∧ β₂ ≤ β₁ + 2 * π ∧ coneAt T z = angleIcc β₁ β₂) :
    4 ≤ (F.coloursAt z).ncard := by
  sorry

/-- **FS116-V5-U1**, the row's four-colour clause: in a non-Siamese simple map, a point `z` of the domain carrying both side
colours of an arc of `Γ` on `ω(z)` carries at least four colours. -/
theorem four_of_bothKind_simple (hF : F.Valid) (hN : F.NonSiamese) (hS : F.Simple) {z : ℂ} (hz : z ∈ F.dom)
    {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') (hc : c ∈ F.coloursAt z)
    (hc' : c' ∈ F.coloursAt z) : 4 ≤ (F.coloursAt z).ncard := by
  refine four_of_bothKind hF hz hA hc hc' (fun d T T' hT hT' hzT hzT' => ?_)
    (fun T hT hzT => hS.coneAt_eq_angleIcc hT hz hzT)
  exact hN.eq_of_unitNear hT hT' (unitNear_of_mem_closure hF hT hT' hzT hzT' (by simp))

/-! ## FS116-Y4-FLANK (any valid map; the covering hypothesis is idle) -/

/-- Cosine nonnegative against one angle `γ` puts `β` in the angular interval `[γ − 90°, γ + 90°]`. -/
theorem mem_angleIcc_of_cos_nonneg_single {γ β : ℝ} (h : 0 ≤ Real.cos (β - γ)) :
    β ∈ angleIcc (γ - π / 2) (γ + π / 2) := by
  have hπ := Real.pi_pos
  set m : ℤ := round ((β - γ) / (2 * π)) with hm
  set β₀ := β - 2 * π * m with hβ₀
  have hcos : Real.cos (β₀ - γ) = Real.cos (β - γ) := by
    rw [hβ₀, show β - 2 * π * m - γ = (β - γ) - m * (2 * π) by ring, Real.cos_sub_int_mul_two_pi]
  have hr : |(β - γ) / (2 * π) - m| ≤ 1 / 2 := abs_sub_round _
  have hβ₀θ : |β₀ - γ| ≤ π := by
    have : β₀ - γ = 2 * π * ((β - γ) / (2 * π) - m) := by
      rw [hβ₀]; field_simp; ring
    rw [this, abs_mul, abs_of_pos (by positivity : 0 < 2 * π)]
    nlinarith [abs_nonneg ((β - γ) / (2 * π) - m)]
  have hβ₀1 : |β₀ - γ| ≤ π / 2 := by
    by_contra hgt
    push Not at hgt
    rcases le_or_gt 0 (β₀ - γ) with hpos | hneg
    · rw [abs_of_nonneg hpos] at hgt hβ₀θ
      have := Real.cos_neg_of_pi_div_two_lt_of_lt hgt (by linarith)
      linarith
    · rw [abs_of_neg hneg] at hgt hβ₀θ
      have := Real.cos_neg_of_pi_div_two_lt_of_lt (x := γ - β₀) (by linarith) (by linarith)
      rw [← Real.cos_neg, neg_sub] at hcos
      linarith
  obtain ⟨h1, h2⟩ := abs_le.mp hβ₀1
  exact mem_iUnion.mpr ⟨m, by linarith, by linarith⟩

/-- **The tangent cone of a unit disc at a boundary point**: a set inside `B̄(y + e γ, 1)` approaches `y` only along directions
`β` with `cos(β − γ) ≥ 0`. -/
theorem cos_nonneg_of_mem_coneAt {S : Set ℂ} {y : ℂ} {γ : ℝ} (hS : S ⊆ closedBall (y + e γ) 1) {β : ℝ}
    (hβ : β ∈ coneAt S y) : 0 ≤ Real.cos (β - γ) := by
  by_contra hneg
  push Not at hneg
  obtain ⟨z, hzS, hzy, -, hdir⟩ := hβ (-Real.cos (β - γ)) (by linarith)
  set w := z - y with hw
  set n := ‖w‖ with hn
  have hw0 : w ≠ 0 := sub_ne_zero.mpr hzy
  have hn0 : 0 < n := norm_pos_iff.mpr hw0
  have hz1 : ‖w - e γ‖ ≤ 1 := by
    have := mem_closedBall.mp (hS hzS)
    rwa [dist_eq_norm, show z - (y + e γ) = w - e γ by rw [hw]; ring] at this
  have hsq : n ^ 2 ≤ 2 * (w * (starRingEnd ℂ) (e γ)).re := by
    have h1 : ‖w - e γ‖ ^ 2 ≤ 1 := by nlinarith [norm_nonneg (w - e γ)]
    rw [Complex.sq_norm, Complex.normSq_apply] at h1
    have h2 : n ^ 2 = w.re ^ 2 + w.im ^ 2 := by
      rw [hn, Complex.sq_norm, Complex.normSq_apply]; ring
    have h3 := e_eq γ
    have h4 : (e γ).re ^ 2 + (e γ).im ^ 2 = 1 := by
      rw [re_e, im_e]; exact Real.cos_sq_add_sin_sq γ
    simp only [Complex.sub_re, Complex.sub_im] at h1
    simp only [Complex.mul_re, Complex.conj_re, Complex.conj_im]
    nlinarith [h1, h2, h4]
  have hdre : 0 ≤ (w / (n : ℂ) * (starRingEnd ℂ) (e γ)).re := by
    rw [div_mul_eq_mul_div, Complex.div_ofReal_re]
    exact div_nonneg (by nlinarith [sq_nonneg n]) hn0.le
  have hre : (e β * (starRingEnd ℂ) (e γ)).re = Real.cos (β - γ) := re_e_mul_conj_e β γ
  have hdiff : (w / (n : ℂ) * (starRingEnd ℂ) (e γ)).re - (e β * (starRingEnd ℂ) (e γ)).re
      ≤ ‖w / (n : ℂ) - e β‖ := by
    have : (w / (n : ℂ) * (starRingEnd ℂ) (e γ)).re - (e β * (starRingEnd ℂ) (e γ)).re
        = ((w / (n : ℂ) - e β) * (starRingEnd ℂ) (e γ)).re := by simp [sub_mul]
    rw [this]
    calc _ ≤ ‖(w / (n : ℂ) - e β) * (starRingEnd ℂ) (e γ)‖ := Complex.re_le_norm _
      _ = ‖w / (n : ℂ) - e β‖ := by rw [norm_mul, Complex.norm_conj, norm_e, mul_one]
  rw [hre] at hdiff
  have hdir' : ‖w / (n : ℂ) - e β‖ < -Real.cos (β - γ) := hdir
  linarith

/-- **FS116-Y4-FLANK**, the cones: let `t` be a tile with `y = r(ψ)` and `y' = r(ψ + 60°)` in its closure, its cone at `y`
containing `(ψ + 150°, ψ + 210°)` and its cone at `y'` containing `(ψ + 210°, ψ + 270°)`; then its cone at `y` lies in
`[ψ + 30°, ψ + 210°]` and holds `ψ + 210°` (it ends there), and its cone at `y'` lies in `[ψ + 210°, ψ + 390°]` and holds
`ψ + 210°` (it begins there). -/
theorem flank_cone (hF : F.Valid) {t : Set ℂ} (ht : F.IsTile t) {p : ℂ} {ψ : ℝ} (hy : ringPt p ψ ∈ closure t)
    (hy' : ringPt p (ψ + π / 3) ∈ closure t) (hcy : Ioo (ψ + 5 * π / 6) (ψ + 7 * π / 6) ⊆ coneAt t (ringPt p ψ))
    (hcy' : Ioo (ψ + 7 * π / 6) (ψ + 3 * π / 2) ⊆ coneAt t (ringPt p (ψ + π / 3))) :
    coneAt t (ringPt p ψ) ⊆ angleIcc (ψ + π / 6) (ψ + 7 * π / 6) ∧ ψ + 7 * π / 6 ∈ coneAt t (ringPt p ψ) ∧
      coneAt t (ringPt p (ψ + π / 3)) ⊆ angleIcc (ψ + 7 * π / 6) (ψ + 13 * π / 6) ∧
      ψ + 7 * π / 6 ∈ coneAt t (ringPt p (ψ + π / 3)) := by
  have hπ := Real.pi_pos
  have hyy' : ringPt p (ψ + π / 3) = ringPt p ψ + e (ψ + 2 * π / 3) := by
    have h := ringPt_sub_ringPt_plus_third p ψ
    have h2 : e (ψ + 2 * π / 3) = - e (ψ - π / 3) := by
      have : ψ + 2 * π / 3 = (ψ - π / 3) + π := by ring
      rw [this, e_add, e_pi]; ring
    rw [h2, ← h]; ring
  have hty' : t ⊆ closedBall (ringPt p (ψ + π / 3)) 1 :=
    subset_closure.trans (ht.closure_subset_closedBall hF hy')
  have hty : t ⊆ closedBall (ringPt p ψ) 1 := subset_closure.trans (ht.closure_subset_closedBall hF hy)
  have hy1 : t ⊆ closedBall (ringPt p ψ + e (ψ + 2 * π / 3)) 1 := by rw [← hyy']; exact hty'
  have hy2 : t ⊆ closedBall (ringPt p (ψ + π / 3) + e (ψ + 2 * π / 3 + π)) 1 := by
    have : ringPt p (ψ + π / 3) + e (ψ + 2 * π / 3 + π) = ringPt p ψ := by
      rw [e_add, e_pi, hyy']; ring
    rw [this]; exact hty
  refine ⟨?_, ?_, ?_, ?_⟩
  · intro β hβ
    have h := mem_angleIcc_of_cos_nonneg_single (cos_nonneg_of_mem_coneAt hy1 hβ)
    convert h using 2 <;> ring
  · have : closure (Ioo (ψ + 5 * π / 6) (ψ + 7 * π / 6)) ⊆ coneAt t (ringPt p ψ) :=
      closure_minimal hcy (isClosed_coneAt t _)
    rw [closure_Ioo (by linarith)] at this
    exact this ⟨by linarith, le_rfl⟩
  · intro β hβ
    have h := mem_angleIcc_of_cos_nonneg_single (cos_nonneg_of_mem_coneAt hy2 hβ)
    convert h using 2 <;> ring
  · have : closure (Ioo (ψ + 7 * π / 6) (ψ + 3 * π / 2)) ⊆ coneAt t (ringPt p (ψ + π / 3)) :=
      closure_minimal hcy' (isClosed_coneAt t _)
    rw [closure_Ioo (by linarith)] at this
    exact this ⟨le_rfl, by linarith⟩

/-- **FS116-Y4-FLANK**, the edges exist: at `y` (in the domain) under the cone hypotheses, `t`'s edge leaving `y` in the
direction `ψ + 210°` is an initial piece of an arc of the map lying in `cl t`; likewise at `y'`. -/
theorem flank_edge_exists (hF : F.Valid) {t : Set ℂ} (ht : F.IsTile t) {p : ℂ} {ψ : ℝ}
    (hyd : ringPt p ψ ∈ F.dom) (hy'd : ringPt p (ψ + π / 3) ∈ F.dom) (hy : ringPt p ψ ∈ closure t)
    (hy' : ringPt p (ψ + π / 3) ∈ closure t) (hcy : Ioo (ψ + 5 * π / 6) (ψ + 7 * π / 6) ⊆ coneAt t (ringPt p ψ))
    (hcy' : Ioo (ψ + 7 * π / 6) (ψ + 3 * π / 2) ⊆ coneAt t (ringPt p (ψ + π / 3))) :
    (∃ α ∈ F.arcs, ∃ B, α.InitialPiece (ringPt p ψ) (ψ + 7 * π / 6) B ∧ B ⊆ closure t) ∧
      ∃ α' ∈ F.arcs, ∃ B', α'.InitialPiece (ringPt p (ψ + π / 3)) (ψ + 7 * π / 6) B' ∧ B' ⊆ closure t := by
  sorry

/-- `e(σ π/2) = σ i` for `σ = ±1`. -/
theorem e_sigma_half {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) : e (σ * (π / 2)) = (σ : ℂ) * I := by
  rcases hσ with rfl | rfl
  · simp [e_pi_div_two]
  · rw [show (-1 : ℝ) * (π / 2) = -(π / 2) by ring, e_neg]; simp

/-- An initial piece of an arc leaving `y` in the direction `i m` (`‖m‖ = 1`): either the arc is a segment and the piece
contains `y + ε i m`, or it is circular and contains the points `y + σρ m (e(σt) − 1)`, `0 ≤ t ≤ ε`, `σ = ±1`. -/
theorem initialPiece_cases {α : Arc} {y m : ℂ} {δ : ℝ} {B : Set ℂ} (hδ : e δ = I * m)
    (hB : α.InitialPiece y δ B) :
    (∃ ε : ℝ, 0 < ε ∧ y + (ε : ℂ) * (I * m) ∈ B) ∨
      ∃ ρ : ℝ, 0 < ρ ∧ ∃ ε : ℝ, 0 < ε ∧ ∃ σ : ℝ, (σ = 1 ∨ σ = -1) ∧
        ∀ t ∈ Icc 0 ε, y + ((σ * ρ : ℝ) : ℂ) * m * (e (σ * t) - 1) ∈ B := by
  cases α with
  | seg a b =>
    obtain ⟨ε, hε, hBeq, -⟩ := hB
    left
    refine ⟨ε, hε, ?_⟩
    rw [hBeq, hδ]
    exact right_mem_segment ℝ _ _
  | circ c ρ θ₀ θ₁ =>
    obtain ⟨hρ, φ, ε, σ, hσ, hε, hy, hδφ, hBeq, -⟩ := hB
    right
    refine ⟨ρ, hρ, ε, hε, σ, hσ, fun t ht => ?_⟩
    have hE0 : e φ ≠ 0 := fun h => by simpa [h] using norm_e φ
    have hφm : e φ = (σ : ℂ) * m := by
      have h1 : e δ = e φ * ((σ : ℂ) * I) := by rw [hδφ, e_add, e_sigma_half hσ]
      have hI : (I : ℂ) ≠ 0 := Complex.I_ne_zero
      have h2 : (I : ℂ) * (e φ * σ) = I * (σ * σ * m) := by
        have hσσ : (σ : ℂ) * σ = 1 := by rcases hσ with rfl | rfl <;> simp
        calc (I : ℂ) * (e φ * σ) = e φ * (σ * I) := by ring
          _ = e δ := h1.symm
          _ = I * m := hδ
          _ = I * (σ * σ * m) := by rw [hσσ, one_mul]
      have h3 := mul_left_cancel₀ hI h2
      have hσσ : (σ : ℂ) * σ = 1 := by rcases hσ with rfl | rfl <;> simp
      calc e φ = e φ * (σ * σ) := by rw [hσσ, mul_one]
        _ = (e φ * σ) * σ := by ring
        _ = (σ * σ * m) * σ := by rw [h3]
        _ = σ * m * (σ * σ) := by ring
        _ = σ * m := by rw [hσσ, mul_one]
    rw [hBeq]
    refine ⟨t, ht, ?_⟩
    simp only
    have hc : c = y - ρ * e φ := by rw [hy]; ring
    rw [hc, e_add, hφm]
    push_cast
    have hσσ : (σ : ℂ) * σ = 1 := by rcases hσ with rfl | rfl <;> simp
    ring


/-- The squared norm of `σρ(e(σt) − 1) − 1` (the offset of a point of a piece from the far point). -/
theorem sq_norm_pieceB {σ ρ : ℝ} (hσ : σ = 1 ∨ σ = -1) (t : ℝ) :
    ‖((σ * ρ : ℝ) : ℂ) * (e (σ * t) - 1) - 1‖ ^ 2 = 1 + 2 * ρ * (ρ + σ) * (1 - Real.cos t) := by
  rw [sq_norm_eq]
  simp only [Complex.sub_re, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, Complex.one_re, Complex.sub_im,
    Complex.mul_im, Complex.one_im, re_e, im_e, zero_mul, sub_zero, add_zero]
  rcases hσ with rfl | rfl
  · simp only [one_mul]
    linear_combination ρ ^ 2 * Real.sin_sq_add_cos_sq t
  · simp only [neg_mul, one_mul, Real.cos_neg, Real.sin_neg]
    linear_combination ρ ^ 2 * Real.sin_sq_add_cos_sq t

/-- The squared norm of `1 + σρ(e(σt) − 1)` (the offset of a point of a piece at the far end from the near point). -/
theorem sq_norm_pieceB' {σ ρ : ℝ} (hσ : σ = 1 ∨ σ = -1) (t : ℝ) :
    ‖1 + ((σ * ρ : ℝ) : ℂ) * (e (σ * t) - 1)‖ ^ 2 = 1 + 2 * ρ * (ρ - σ) * (1 - Real.cos t) := by
  rw [sq_norm_eq]
  simp only [Complex.add_re, Complex.sub_re, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, Complex.one_re,
    Complex.add_im, Complex.sub_im, Complex.mul_im, Complex.one_im, re_e, im_e, zero_mul, sub_zero,
    add_zero]
  rcases hσ with rfl | rfl
  · simp only [one_mul]
    linear_combination ρ ^ 2 * Real.sin_sq_add_cos_sq t
  · simp only [neg_mul, one_mul, Real.cos_neg, Real.sin_neg]
    linear_combination ρ ^ 2 * Real.sin_sq_add_cos_sq t


/-- **FS116-Y4-FLANK**, the geometry (TWOCIRC in place of its identity step, SR1 item 1): two initial pieces of arcs leaving
`y` and `y'` (with `y' − y = e(ψ + 120°)`) in the direction `ψ + 210°`, the first inside `B̄(y', 1)` and the second inside
`B̄(y, 1)`, have points nearer than `1`. (Staying in the disc forces each to curve toward the other centre with radius at most
`1`: a segment, or an arc curving away, leaves the disc.) -/
theorem flank_initialPieces {y y' : ℂ} {ψ : ℝ} (hyy' : y' - y = e (ψ + 2 * π / 3)) {α α' : Arc} {B B' : Set ℂ}
    (hB : α.InitialPiece y (ψ + 7 * π / 6) B) (hB' : α'.InitialPiece y' (ψ + 7 * π / 6) B')
    (hBd : B ⊆ closedBall y' 1) (hB'd : B' ⊆ closedBall y 1) : ∃ z ∈ B, ∃ z' ∈ B', dist z z' < 1 := by
  set m : ℂ := e (ψ + 2 * π / 3) with hm
  have hmn : ‖m‖ = 1 := norm_e _
  have hδ : e (ψ + 7 * π / 6) = I * m := by
    rw [show ψ + 7 * π / 6 = (ψ + 2 * π / 3) + π / 2 by ring, e_add, e_pi_div_two, mul_comm]
  have hy' : y' = y + m := by rw [← hyy']; ring
  have hπ := Real.pi_gt_three
  have he0 : e 0 = 1 := by simp [e]
  have hIε : ∀ ε : ℝ, 0 < ε → 1 < ‖(ε : ℂ) * I - 1‖ := by
    intro ε hε
    have h := sq_norm_eq ((ε : ℂ) * I - 1)
    simp only [Complex.sub_re, Complex.mul_re, Complex.ofReal_re, Complex.I_re, Complex.ofReal_im, Complex.I_im,
      Complex.one_re, Complex.sub_im, Complex.mul_im, Complex.one_im] at h
    norm_num at h
    nlinarith [norm_nonneg ((ε : ℂ) * I - 1)]
  have hIε' : ∀ ε : ℝ, 0 < ε → 1 < ‖1 + (ε : ℂ) * I‖ := by
    intro ε hε
    have h := sq_norm_eq (1 + (ε : ℂ) * I)
    simp only [Complex.add_re, Complex.mul_re, Complex.ofReal_re, Complex.I_re, Complex.ofReal_im, Complex.I_im,
      Complex.one_re, Complex.add_im, Complex.mul_im, Complex.one_im] at h
    norm_num at h
    nlinarith [norm_nonneg (1 + (ε : ℂ) * I)]
  rcases initialPiece_cases hδ hB with ⟨ε, hε, hz⟩ | ⟨ρ, hρ, ε, hε, σ, hσ, hpts⟩
  · exfalso
    have h := mem_closedBall.mp (hBd hz)
    rw [dist_eq_norm, hy', show y + (ε : ℂ) * (I * m) - (y + m) = m * ((ε : ℂ) * I - 1) by ring, norm_mul, hmn,
      one_mul] at h
    exact absurd (hIε ε hε) (not_lt.mpr h)
  rcases initialPiece_cases hδ hB' with ⟨ε', hε', hz'⟩ | ⟨ρ', hρ', ε', hε', σ', hσ', hpts'⟩
  · exfalso
    have h := mem_closedBall.mp (hB'd hz')
    rw [dist_eq_norm, hy', show y + m + (ε' : ℂ) * (I * m) - y = m * (1 + (ε' : ℂ) * I) by ring, norm_mul, hmn,
      one_mul] at h
    exact absurd (hIε' ε' hε') (not_lt.mpr h)
  -- both pieces are circular
  set t0 : ℝ := min (min ε ε') 1 with ht0
  have ht0pos : 0 < t0 := lt_min (lt_min hε hε') one_pos
  have ht0ε : t0 ≤ ε := (min_le_left _ _).trans (min_le_left _ _)
  have ht0ε' : t0 ≤ ε' := (min_le_left _ _).trans (min_le_right _ _)
  have ht01 : t0 ≤ 1 := min_le_right _ _
  have hc1 : Real.cos t0 < 1 := by
    have := Real.cos_lt_cos_of_nonneg_of_le_pi (le_refl 0) (by linarith : t0 ≤ π) ht0pos
    simpa using this
  have hcpos : 0 < Real.cos t0 := Real.cos_pos_of_mem_Ioo ⟨by linarith, by linarith⟩
  have hzmem : y + ((σ * ρ : ℝ) : ℂ) * m * (e (σ * t0) - 1) ∈ B := hpts t0 ⟨ht0pos.le, ht0ε⟩
  have hz'mem : y' + ((σ' * ρ' : ℝ) : ℂ) * m * (e (σ' * t0) - 1) ∈ B' := hpts' t0 ⟨ht0pos.le, ht0ε'⟩
  -- distances of the two pieces' points to the far centres
  have hdB : dist (y + ((σ * ρ : ℝ) : ℂ) * m * (e (σ * t0) - 1)) y' ^ 2 = 1 + 2 * ρ * (ρ + σ) * (1 - Real.cos t0) := by
    rw [dist_eq_norm, hy', show y + ((σ * ρ : ℝ) : ℂ) * m * (e (σ * t0) - 1) - (y + m)
      = m * (((σ * ρ : ℝ) : ℂ) * (e (σ * t0) - 1) - 1) by ring, norm_mul, hmn, one_mul]
    exact sq_norm_pieceB hσ t0
  have hdB' : dist (y' + ((σ' * ρ' : ℝ) : ℂ) * m * (e (σ' * t0) - 1)) y ^ 2 = 1 + 2 * ρ' * (ρ' - σ') * (1 - Real.cos t0) := by
    rw [dist_eq_norm, hy', show y + m + ((σ' * ρ' : ℝ) : ℂ) * m * (e (σ' * t0) - 1) - y
      = m * (1 + ((σ' * ρ' : ℝ) : ℂ) * (e (σ' * t0) - 1)) by ring, norm_mul, hmn, one_mul]
    exact sq_norm_pieceB' hσ' t0
  have hle : dist (y + ((σ * ρ : ℝ) : ℂ) * m * (e (σ * t0) - 1)) y' ≤ 1 := mem_closedBall.mp (hBd hzmem)
  have hle' : dist (y' + ((σ' * ρ' : ℝ) : ℂ) * m * (e (σ' * t0) - 1)) y ≤ 1 := mem_closedBall.mp (hB'd hz'mem)
  have h1c : 0 < 1 - Real.cos t0 := by linarith
  have hsq : ∀ d : ℝ, 0 ≤ d → d ≤ 1 → d ^ 2 ≤ 1 := fun d h0 h1 => by nlinarith
  have hσ1 : σ = -1 ∧ ρ ≤ 1 := by
    have h2 := hsq _ dist_nonneg hle
    rw [hdB] at h2
    have h3 : ρ * (ρ + σ) ≤ 0 := by
      by_contra hcon
      push Not at hcon
      nlinarith [mul_pos hcon h1c]
    rcases hσ with rfl | rfl
    · nlinarith
    · exact ⟨rfl, by nlinarith⟩
  have hσ1' : σ' = 1 ∧ ρ' ≤ 1 := by
    have h2 := hsq _ dist_nonneg hle'
    rw [hdB'] at h2
    have h3 : ρ' * (ρ' - σ') ≤ 0 := by
      by_contra hcon
      push Not at hcon
      nlinarith [mul_pos hcon h1c]
    rcases hσ' with rfl | rfl
    · exact ⟨rfl, by nlinarith⟩
    · nlinarith
  obtain ⟨rfl, hρ1⟩ := hσ1
  obtain ⟨rfl, hρ1'⟩ := hσ1'
  rcases lt_or_eq_of_le hρ1 with hρlt | rfl
  · refine ⟨_, hzmem, y', ?_, ?_⟩
    · have := hpts' 0 ⟨le_rfl, hε'.le⟩
      simpa [he0] using this
    · have h2 : dist (y + ((-1 * ρ : ℝ) : ℂ) * m * (e (-1 * t0) - 1)) y' ^ 2 < 1 := by
        rw [hdB]; nlinarith [mul_pos (mul_pos hρ (sub_pos.mpr hρlt)) h1c]
      nlinarith [dist_nonneg (x := y + ((-1 * ρ : ℝ) : ℂ) * m * (e (-1 * t0) - 1)) (y := y')]
  rcases lt_or_eq_of_le hρ1' with hρlt' | rfl
  · refine ⟨y, ?_, _, hz'mem, ?_⟩
    · have := hpts 0 ⟨le_rfl, hε.le⟩
      simpa [he0] using this
    · have h2 : dist (y' + ((1 * ρ' : ℝ) : ℂ) * m * (e (1 * t0) - 1)) y ^ 2 < 1 := by
        rw [hdB']; nlinarith [mul_pos (mul_pos hρ' (sub_pos.mpr hρlt')) h1c]
      rw [dist_comm]
      nlinarith [dist_nonneg (x := y' + ((1 * ρ' : ℝ) : ℂ) * m * (e (1 * t0) - 1)) (y := y)]
  · refine ⟨_, hzmem, _, hz'mem, ?_⟩
    have hcc : (1 - e (-t0) - e t0 : ℂ) = ((1 - 2 * Real.cos t0 : ℝ) : ℂ) := by
      rw [e_neg, e_eq]; push_cast; ring
    rw [dist_eq_norm, hy', show y + ((-1 * 1 : ℝ) : ℂ) * m * (e (-1 * t0) - 1)
        - (y + m + ((1 * 1 : ℝ) : ℂ) * m * (e (1 * t0) - 1)) = m * (1 - e (-t0) - e t0) by
        simp only [neg_mul, one_mul]; push_cast; ring, norm_mul, hmn, one_mul, hcc, Complex.norm_real,
      Real.norm_eq_abs, abs_lt]
    constructor <;> linarith


/-- **FS116-Y4-FLANK**, the row's last clause (for any sets `a`, `b` whose closures hold the two edges: the row's tiles
bordering `t` along them, or `t` itself): some point of `cl a` and some point of `cl b` are nearer than `1`. -/
theorem flank (hF : F.Valid) {t : Set ℂ} (ht : F.IsTile t) {p : ℂ} {ψ : ℝ} (hy : ringPt p ψ ∈ closure t)
    (hy' : ringPt p (ψ + π / 3) ∈ closure t) {α α' : Arc} {B B' : Set ℂ}
    (hB : α.InitialPiece (ringPt p ψ) (ψ + 7 * π / 6) B) (hB' : α'.InitialPiece (ringPt p (ψ + π / 3)) (ψ + 7 * π / 6) B')
    (hBt : B ⊆ closure t) (hB't : B' ⊆ closure t) {a b : Set ℂ} (ha : B ⊆ closure a) (hb : B' ⊆ closure b) :
    ∃ z ∈ closure a, ∃ z' ∈ closure b, dist z z' < 1 := by
  have hyy' : ringPt p (ψ + π / 3) - ringPt p ψ = e (ψ + 2 * π / 3) := by
    have h := ringPt_sub_ringPt_plus_third p ψ
    have h2 : e (ψ + 2 * π / 3) = - e (ψ - π / 3) := by
      have : ψ + 2 * π / 3 = (ψ - π / 3) + π := by ring
      rw [this, e_add, e_pi]; ring
    rw [h2, ← h]; ring
  obtain ⟨z, hz, z', hz', hlt⟩ := flank_initialPieces hyy' hB hB'
    (hBt.trans (ht.closure_subset_closedBall hF hy')) (hB't.trans (ht.closure_subset_closedBall hF hy))
  exact ⟨z, ha hz, z', hb hz', hlt⟩

end ArcMap

end HadwigerNelson.Plane
