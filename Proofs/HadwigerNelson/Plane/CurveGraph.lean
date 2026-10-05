import Proofs.HadwigerNelson.Plane.LocalStructure

/-!
# The handshake for compact sets made of lines and circles (the boundary graph, BG)

The parity step that wave 5's planar leaves read (FS131-KP, `plans/FS131-planar-kernel-plan.md` § 4, child **BG**; job FS131-IP3): a
compact set `C` of the plane that is, near each of its points `z`, a **star of curve rays** — finitely many rays leaving `z`, each a graph
over the distance from `z` and locally a piece of a line or a circle — is a finite graph, so the degrees at its finitely many non-regular
points have an even sum (`even_sum_deg`). A point is *regular* when `C` is a line or a circle near it; every other point is a vertex.

The proof cuts each vertex `v` out by a small disc `B(v, ρ)`; the rays meet the circle `∂B(v, ρ)` in `deg v` **ports**; what is left of `C`
is regular, so each of its components holding a port lies in one line or circle (`IsCurve.eq_of_inter_ball_subset`), is an arc of it
(`IsCurve.exists_param`), and has exactly two ports, its ends. The ports are paired by a fixed-point-free involution, so they are even in
number, and they are `∑ deg v` in number.

No Jordan-type theorem is read: only that two distinct lines or circles share at most two points, and the order topology of `ℝ`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Curves: lines and circles -/

/-- **A curve**: a line `{x + t d : t ∈ ℝ}` (`d ≠ 0`) or a circle of positive radius. -/
def IsCurve (L : Set ℂ) : Prop :=
  (∃ x d : ℂ, d ≠ 0 ∧ L = range fun t : ℝ => x + (t : ℂ) * d) ∨ ∃ c : ℂ, ∃ R : ℝ, 0 < R ∧ L = sphere c R

/-- **`C` is regular at `z`**: near `z`, `C` is a line or a circle. -/
def IsRegularAt (C : Set ℂ) (z : ℂ) : Prop :=
  ∃ L, IsCurve L ∧ ∃ ε > 0, C ∩ ball z ε = L ∩ ball z ε

/-- **A star of `n` curve rays at `z`**: out to some radius `r`, `C` is `z` and `n` rays, each a continuous graph over the distance from
`z`, pairwise disjoint, each near each of its points a piece of a line or a circle. -/
def HasCurveStar (C : Set ℂ) (z : ℂ) (n : ℕ) : Prop :=
  ∃ r > 0, ∃ b : Fin n → ℝ → ℂ, (∀ i, ContinuousOn (b i) (Ioo 0 r)) ∧ (∀ i, ∀ s ∈ Ioo 0 r, ‖b i s - z‖ = s) ∧
    (∀ i j, i ≠ j → ∀ s ∈ Ioo 0 r, b i s ≠ b j s) ∧ C ∩ ball z r = insert z (⋃ i, b i '' Ioo 0 r) ∧
    ∀ i, ∀ s ∈ Ioo 0 r, ∃ L, IsCurve L ∧ ∃ ε > 0, b i '' Ioo 0 r ∩ ball (b i s) ε = L ∩ ball (b i s) ε

/-- A line through two of its distinct points is the line they span. -/
theorem line_eq_span {x d p₁ p₂ : ℂ} (h₁ : p₁ ∈ range fun t : ℝ => x + (t : ℂ) * d)
    (h₂ : p₂ ∈ range fun t : ℝ => x + (t : ℂ) * d) (h12 : p₁ ≠ p₂) :
    (range fun t : ℝ => x + (t : ℂ) * d) = range fun s : ℝ => p₁ + (s : ℂ) * (p₂ - p₁) := by
  obtain ⟨t₁, rfl⟩ := h₁
  obtain ⟨t₂, rfl⟩ := h₂
  have ht : t₂ - t₁ ≠ 0 := by
    intro h
    apply h12
    rw [show t₂ = t₁ by linarith]
  have htc : ((t₂ - t₁ : ℝ) : ℂ) ≠ 0 := by exact_mod_cast ht
  ext z
  simp only [mem_range]
  constructor
  · rintro ⟨t, rfl⟩
    refine ⟨(t - t₁) / (t₂ - t₁), ?_⟩
    push_cast at htc ⊢
    field_simp
    ring
  · rintro ⟨s, rfl⟩
    exact ⟨t₁ + s * (t₂ - t₁), by push_cast; ring⟩

/-- A line meets a circle in at most two points. -/
theorem line_inter_sphere_two {x d c : ℂ} {R : ℝ} (hd : d ≠ 0) {t₁ t₂ t₃ : ℝ} (h12 : t₁ ≠ t₂) (h13 : t₁ ≠ t₃)
    (h23 : t₂ ≠ t₃) (h₁ : x + (t₁ : ℂ) * d ∈ sphere c R) (h₂ : x + (t₂ : ℂ) * d ∈ sphere c R)
    (h₃ : x + (t₃ : ℂ) * d ∈ sphere c R) : False := by
  have hq : ∀ t : ℝ, x + (t : ℂ) * d ∈ sphere c R →
      (x.re - c.re + t * d.re) ^ 2 + (x.im - c.im + t * d.im) ^ 2 = R ^ 2 := by
    intro t ht
    rw [mem_sphere, dist_eq_norm] at ht
    rw [← ht, ← Complex.normSq_eq_norm_sq, Complex.normSq_apply]
    simp only [Complex.sub_re, Complex.add_re, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im,
      Complex.sub_im, Complex.add_im, Complex.mul_im]
    ring
  have q₁ := hq t₁ h₁
  have q₂ := hq t₂ h₂
  have q₃ := hq t₃ h₃
  have hA : 0 < d.re ^ 2 + d.im ^ 2 := by
    rcases ne_or_eq d.re 0 with h | h
    · positivity
    · have : d.im ≠ 0 := fun h' => hd (Complex.ext h h')
      positivity
  set A := d.re ^ 2 + d.im ^ 2
  set B := (x.re - c.re) * d.re + (x.im - c.im) * d.im
  have e12 : 2 * B + (t₁ + t₂) * A = 0 := by
    have : (t₁ - t₂) * (2 * B + (t₁ + t₂) * A) = 0 := by linear_combination q₁ - q₂
    exact (mul_eq_zero.mp this).resolve_left (sub_ne_zero.mpr h12)
  have e13 : 2 * B + (t₁ + t₃) * A = 0 := by
    have : (t₁ - t₃) * (2 * B + (t₁ + t₃) * A) = 0 := by linear_combination q₁ - q₃
    exact (mul_eq_zero.mp this).resolve_left (sub_ne_zero.mpr h13)
  have : (t₂ - t₃) * A = 0 := by linear_combination e12 - e13
  exact (mul_ne_zero (sub_ne_zero.mpr h23) hA.ne') this

/-- **Two curves with three distinct common points are equal.** -/
theorem IsCurve.eq_of_three {L L' : Set ℂ} (hL : IsCurve L) (hL' : IsCurve L') {p₁ p₂ p₃ : ℂ} (h12 : p₁ ≠ p₂) (h13 : p₁ ≠ p₃)
    (h23 : p₂ ≠ p₃) (h₁ : p₁ ∈ L ∩ L') (h₂ : p₂ ∈ L ∩ L') (h₃ : p₃ ∈ L ∩ L') : L = L' := by
  -- a line and a circle share at most two points
  have mixed : ∀ {x d c : ℂ} {R : ℝ}, d ≠ 0 → p₁ ∈ (range fun t : ℝ => x + (t : ℂ) * d) ∩ sphere c R →
      p₂ ∈ (range fun t : ℝ => x + (t : ℂ) * d) ∩ sphere c R → p₃ ∈ (range fun t : ℝ => x + (t : ℂ) * d) ∩ sphere c R →
      False := by
    intro x d c R hd ⟨⟨t₁, e₁⟩, s₁⟩ ⟨⟨t₂, e₂⟩, s₂⟩ ⟨⟨t₃, e₃⟩, s₃⟩
    subst e₁ e₂ e₃
    refine line_inter_sphere_two hd ?_ ?_ ?_ s₁ s₂ s₃
    · rintro rfl; exact h12 rfl
    · rintro rfl; exact h13 rfl
    · rintro rfl; exact h23 rfl
  rcases hL with ⟨x, d, hd, rfl⟩ | ⟨c, R, hR, rfl⟩ <;> rcases hL' with ⟨x', d', hd', rfl⟩ | ⟨c', R', hR', rfl⟩
  · rw [line_eq_span h₁.1 h₂.1 h12, line_eq_span h₁.2 h₂.2 h12]
  · exact (mixed hd h₁ h₂ h₃).elim
  · exact (mixed hd' ⟨h₁.2, h₁.1⟩ ⟨h₂.2, h₂.1⟩ ⟨h₃.2, h₃.1⟩).elim
  · by_cases hc : c = c'
    · subst hc
      have : R = R' := by rw [← mem_sphere.mp h₁.1, ← mem_sphere.mp h₁.2]
      rw [this]
    · have := EuclideanGeometry.eq_of_dist_eq_of_dist_eq_of_finrank_eq_two (V := ℂ) (P := ℂ) Complex.finrank_real_complex
        hc h12 h₁.1 h₂.1 h₃.1 h₁.2 h₂.2 h₃.2
      rcases this with h | h
      · exact (h13 h.symm).elim
      · exact (h23 h.symm).elim

/-- **A curve has three distinct points in every disc about one of its points.** -/
theorem IsCurve.three_mem_ball {L : Set ℂ} (hL : IsCurve L) {w : ℂ} (hw : w ∈ L) {δ : ℝ} (hδ : 0 < δ) :
    ∃ p₁ p₂ p₃, p₁ ≠ p₂ ∧ p₁ ≠ p₃ ∧ p₂ ≠ p₃ ∧ p₁ ∈ L ∩ ball w δ ∧ p₂ ∈ L ∩ ball w δ ∧ p₃ ∈ L ∩ ball w δ := by
  have hπ := Real.pi_pos
  rcases hL with ⟨x, d, hd, rfl⟩ | ⟨c, R, hR, rfl⟩
  · obtain ⟨t₀, rfl⟩ := hw
    have hdn : 0 < ‖d‖ := norm_pos_iff.mpr hd
    set η := δ / (3 * ‖d‖) with hη
    have hη0 : 0 < η := by positivity
    have hpt : ∀ k : ℝ, 0 ≤ k → k < 3 → x + ((t₀ + k * η : ℝ) : ℂ) * d ∈ (range fun t : ℝ => x + (t : ℂ) * d) ∩
        ball (x + (t₀ : ℂ) * d) δ := by
      intro k hk0 hk3
      refine ⟨⟨_, rfl⟩, ?_⟩
      rw [mem_ball, dist_eq_norm]
      have : x + ((t₀ + k * η : ℝ) : ℂ) * d - (x + (t₀ : ℂ) * d) = ((k * η : ℝ) : ℂ) * d := by push_cast; ring
      rw [this, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (by positivity), hη]
      field_simp
      nlinarith
    have hinj : ∀ a b : ℝ, x + (a : ℂ) * d = x + (b : ℂ) * d → a = b := by
      intro a b h
      have h' : ((a - b : ℝ) : ℂ) * d = 0 := by push_cast; linear_combination h
      rcases mul_eq_zero.mp h' with h'' | h''
      · exact_mod_cast sub_eq_zero.mp (by exact_mod_cast h'')
      · exact absurd h'' hd
    refine ⟨_, _, _, ?_, ?_, ?_, hpt 0 le_rfl (by norm_num), hpt 1 zero_le_one (by norm_num), hpt 2 zero_le_two (by norm_num)⟩
    · intro h; have := hinj _ _ h; nlinarith
    · intro h; have := hinj _ _ h; nlinarith
    · intro h; have := hinj _ _ h; nlinarith
  · have hwc : w = c + (R : ℂ) * e (arg (w - c)) := by
      have h1 := eq_polar_arg (w - c)
      rw [show ‖w - c‖ = R by rw [← dist_eq_norm]; exact mem_sphere.mp hw] at h1
      linear_combination h1
    set φ := arg (w - c)
    set η := min (δ / (3 * R)) 1 with hη
    have hη0 : 0 < η := lt_min (by positivity) one_pos
    have hη1 : η ≤ 1 := min_le_right _ _
    have hηR : η * R ≤ δ / 3 := by
      have := min_le_left (δ / (3 * R)) 1
      rw [← hη] at this
      calc η * R ≤ δ / (3 * R) * R := mul_le_mul_of_nonneg_right this hR.le
        _ = δ / 3 := by field_simp
    have hpt : ∀ k : ℝ, 0 ≤ k → k < 3 → c + (R : ℂ) * e (φ + k * η) ∈ sphere c R ∩ ball w δ := by
      intro k hk0 hk3
      refine ⟨by rw [mem_sphere, dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, norm_e, mul_one,
        Real.norm_eq_abs, abs_of_pos hR], ?_⟩
      rw [mem_ball, dist_eq_norm]
      conv_lhs => rw [hwc]
      have e1 : c + (R : ℂ) * e (φ + k * η) - (c + (R : ℂ) * e φ) = (R : ℂ) * (e (φ + k * η) - e φ) := by ring
      rw [e1, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hR]
      have hsq := sq_norm_e_sub_e (φ + k * η) φ
      have hcos := Real.one_sub_sq_div_two_le_cos (x := φ + k * η - φ)
      have hle : ‖e (φ + k * η) - e φ‖ ≤ k * η := by
        have h0 : 0 ≤ ‖e (φ + k * η) - e φ‖ := norm_nonneg _
        have h1 : ‖e (φ + k * η) - e φ‖ ^ 2 ≤ (k * η) ^ 2 := by
          rw [hsq]; nlinarith
        nlinarith [sq_nonneg (‖e (φ + k * η) - e φ‖ - k * η), sq_nonneg (‖e (φ + k * η) - e φ‖ + k * η),
          mul_nonneg hk0 hη0.le]
      calc R * ‖e (φ + k * η) - e φ‖ ≤ R * (k * η) := mul_le_mul_of_nonneg_left hle hR.le
        _ = k * (η * R) := by ring
        _ ≤ k * (δ / 3) := mul_le_mul_of_nonneg_left hηR hk0
        _ < δ := by nlinarith
    have hne : ∀ k k' : ℝ, 0 ≤ k → k < 3 → 0 ≤ k' → k' < 3 → k ≠ k' →
        c + (R : ℂ) * e (φ + k * η) ≠ c + (R : ℂ) * e (φ + k' * η) := by
      intro k k' hk0 hk3 hk0' hk3' hkk h
      have hR0 : (R : ℂ) ≠ 0 := by exact_mod_cast hR.ne'
      have h1 : e (φ + k * η) = e (φ + k' * η) := mul_left_cancel₀ hR0 (add_left_cancel h)
      have h2 : e ((k - k') * η) = 1 := by
        have : e (φ + k * η) = e (φ + k' * η) * e ((k - k') * η) := by rw [← e_add]; ring_nf
        rw [h1] at this
        have hne0 : e (φ + k' * η) ≠ 0 := by
          intro h0; simpa [h0] using norm_e (φ + k' * η)
        exact (mul_eq_left₀ hne0).mp this.symm
      refine e_ne_one ?_ ?_ h2
      · exact mul_ne_zero (sub_ne_zero.mpr hkk) hη0.ne'
      · rw [abs_mul, abs_of_pos hη0]
        have : |k - k'| < 3 := by rw [abs_lt]; constructor <;> linarith
        nlinarith [abs_nonneg (k - k'), Real.two_le_pi]
    refine ⟨_, _, _, hne 0 1 le_rfl (by norm_num) zero_le_one (by norm_num) (by norm_num),
      hne 0 2 le_rfl (by norm_num) zero_le_two (by norm_num) (by norm_num),
      hne 1 2 zero_le_one (by norm_num) zero_le_two (by norm_num) (by norm_num),
      hpt 0 le_rfl (by norm_num), hpt 1 zero_le_one (by norm_num), hpt 2 zero_le_two (by norm_num)⟩

/-- **A curve lying near one of its points inside another curve is that curve.** -/
theorem IsCurve.eq_of_inter_ball_subset {L L' : Set ℂ} (hL : IsCurve L) (hL' : IsCurve L') {w : ℂ} (hw : w ∈ L) {δ : ℝ}
    (hδ : 0 < δ) (h : L ∩ ball w δ ⊆ L') : L = L' := by
  obtain ⟨p₁, p₂, p₃, h12, h13, h23, h₁, h₂, h₃⟩ := hL.three_mem_ball hw hδ
  exact hL.eq_of_three hL' h12 h13 h23 ⟨h₁.1, h h₁⟩ ⟨h₂.1, h h₂⟩ ⟨h₃.1, h h₃⟩

/-- A line is injective in its parameter. -/
theorem line_param_inj {x d : ℂ} (hd : d ≠ 0) {a b : ℝ} (h : x + (a : ℂ) * d = x + (b : ℂ) * d) : a = b := by
  have h' : ((a - b : ℝ) : ℂ) * d = 0 := by push_cast; linear_combination h
  rcases mul_eq_zero.mp h' with h'' | h''
  · exact sub_eq_zero.mp (by exact_mod_cast h'')
  · exact absurd h'' hd

/-- A circle is injective in its angle over an interval shorter than a turn. -/
theorem circle_param_injOn {c : ℂ} {R : ℝ} (hR : R ≠ 0) {α β : ℝ} (hαβ : β - α < 2 * π) :
    InjOn (fun t : ℝ => c + (R : ℂ) * e t) (Icc α β) := by
  intro a ha b hb h
  have hR0 : (R : ℂ) ≠ 0 := by exact_mod_cast hR
  have h1 : e a = e b := mul_left_cancel₀ hR0 (add_left_cancel h)
  obtain ⟨m, hm⟩ := e_eq_e_iff.mp h1
  have hπ := Real.pi_pos
  rcases lt_trichotomy m 0 with hm0 | hm0 | hm0
  · have : (m : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_iff.mpr hm0
    nlinarith [ha.1, ha.2, hb.1, hb.2]
  · subst hm0; simpa using hm
  · have : (1 : ℝ) ≤ m := by exact_mod_cast hm0
    nlinarith [ha.1, ha.2, hb.1, hb.2]

/-- **A compact proper part of a curve lies on an arc of it**: a compact `Q` inside a curve `L`, not all of `L`, lies in the image of an open
interval `(α, β)` under a continuous map into `L` injective on `[α, β]` (a line by its parameter; a circle by its angle, cut at a point
off `Q`). -/
theorem IsCurve.exists_param {L Q : Set ℂ} (hL : IsCurve L) (hQ : IsCompact Q) (hQL : Q ⊆ L) (hne : Q ≠ L) :
    ∃ (γ : ℝ → ℂ) (α β : ℝ), Continuous γ ∧ InjOn γ (Icc α β) ∧ γ '' Icc α β ⊆ L ∧ Q ⊆ γ '' Ioo α β := by
  have hπ := Real.pi_pos
  have hπ2 := Real.two_le_pi
  rcases hL with ⟨x, d, hd, rfl⟩ | ⟨c, R, hR, rfl⟩
  · obtain ⟨M, hM⟩ := hQ.isBounded.subset_closedBall 0
    have hdn : 0 < ‖d‖ := norm_pos_iff.mpr hd
    set K := (M + ‖x‖) / ‖d‖ + 1 with hK
    refine ⟨fun t => x + (t : ℂ) * d, -K, K, by fun_prop, fun a _ b _ h => line_param_inj hd h,
      by rintro _ ⟨t, -, rfl⟩; exact ⟨t, rfl⟩, ?_⟩
    intro q hq
    obtain ⟨t, rfl⟩ := hQL hq
    have hqM := hM hq
    rw [mem_closedBall, dist_zero_right] at hqM
    have h1 : |t| * ‖d‖ ≤ M + ‖x‖ := by
      have : ‖(t : ℂ) * d‖ ≤ ‖x + (t : ℂ) * d‖ + ‖x‖ := by
        have := norm_sub_le (x + (t : ℂ) * d) x
        simpa using this
      rw [norm_mul, Complex.norm_real, Real.norm_eq_abs] at this
      linarith
    have h2 : |t| ≤ (M + ‖x‖) / ‖d‖ := by rw [le_div_iff₀ hdn]; exact h1
    refine ⟨t, ⟨?_, ?_⟩, rfl⟩ <;> cases abs_le.mp h2 <;> linarith
  · obtain ⟨w₀, hw₀L, hw₀Q⟩ : ∃ w₀ ∈ sphere c R, w₀ ∉ Q := by
      by_contra h
      push Not at h
      exact hne (Subset.antisymm hQL h)
    set γ : ℝ → ℂ := fun t => c + (R : ℂ) * e t with hγ
    have hγc : Continuous γ := continuous_const.add (continuous_const.mul continuous_e)
    have hγL : ∀ t, γ t ∈ sphere c R := fun t => by
      simp only [hγ, mem_sphere, dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, norm_e, mul_one,
        Real.norm_eq_abs, abs_of_pos hR]
    have hsurj : ∀ q ∈ sphere c R, ∀ θ₀ : ℝ, ∃ ψ ∈ Icc θ₀ (θ₀ + 2 * π), γ ψ = q := by
      intro q hq θ₀
      obtain ⟨ψ, hψ, hψe⟩ := exists_mem_Icc_e_eq θ₀ (arg (q - c))
      refine ⟨ψ, hψ, ?_⟩
      have h1 := eq_polar_arg (q - c)
      rw [show ‖q - c‖ = R by rw [← dist_eq_norm]; exact mem_sphere.mp hq] at h1
      simp only [hγ, hψe]
      linear_combination -h1
    obtain ⟨θ₀, -, hθ₀⟩ := hsurj w₀ hw₀L 0
    set K := Icc θ₀ (θ₀ + 2 * π) ∩ γ ⁻¹' Q with hKdef
    have hKc : IsCompact K := isCompact_Icc.inter_right (hQ.isClosed.preimage hγc)
    by_cases hK : K.Nonempty
    · set m := sInf K
      set M := sSup K
      have hmK : m ∈ K := hKc.sInf_mem hK
      have hMK : M ∈ K := hKc.sSup_mem hK
      have hm : θ₀ < m := by
        rcases eq_or_lt_of_le hmK.1.1 with h | h
        · exact absurd (h ▸ hmK.2 : γ θ₀ ∈ Q) (hθ₀ ▸ hw₀Q)
        · exact h
      have hM : M < θ₀ + 2 * π := by
        rcases eq_or_lt_of_le hMK.1.2 with h | h
        · have : γ (θ₀ + 2 * π) = γ θ₀ := by simp only [hγ, e_add_two_pi]
          exact absurd (h ▸ hMK.2 : γ (θ₀ + 2 * π) ∈ Q) (by rw [this, hθ₀]; exact hw₀Q)
        · exact h
      have hmM : m ≤ M := csInf_le hKc.bddBelow hMK
      refine ⟨γ, (θ₀ + m) / 2, (M + θ₀ + 2 * π) / 2, hγc, circle_param_injOn hR.ne' (by linarith),
        by rintro _ ⟨t, -, rfl⟩; exact hγL t, ?_⟩
      intro q hq
      obtain ⟨ψ, hψ, rfl⟩ := hsurj q (hQL hq) θ₀
      have hψK : ψ ∈ K := ⟨hψ, hq⟩
      have h1 : m ≤ ψ := csInf_le hKc.bddBelow hψK
      have h2 : ψ ≤ M := le_csSup hKc.bddAbove hψK
      exact ⟨ψ, ⟨by linarith, by linarith⟩, rfl⟩
    · refine ⟨γ, θ₀ + 1, θ₀ + 2, hγc, circle_param_injOn hR.ne' (by linarith), by rintro _ ⟨t, -, rfl⟩; exact hγL t, ?_⟩
      intro q hq
      obtain ⟨ψ, hψ, rfl⟩ := hsurj q (hQL hq) θ₀
      exact absurd ⟨ψ, hψ, hq⟩ hK

/-! ## Stars: off the centre a star is regular, and the non-regular points of a compact star set are finitely many -/

/-- **Near a point of a ray, a star is that ray alone** (the other rays and the centre stay away). -/
theorem star_local_ray {C : Set ℂ} {z : ℂ} {n : ℕ} {r : ℝ} {b : Fin n → ℝ → ℂ} (hcont : ∀ i, ContinuousOn (b i) (Ioo 0 r))
    (hnorm : ∀ i, ∀ s ∈ Ioo 0 r, ‖b i s - z‖ = s) (hdisj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 r, b i s ≠ b j s)
    (heq : C ∩ ball z r = insert z (⋃ i, b i '' Ioo 0 r)) {i : Fin n} {s : ℝ} (hs : s ∈ Ioo 0 r) :
    ∃ ε > 0, C ∩ ball (b i s) ε = b i '' Ioo 0 r ∩ ball (b i s) ε := by
  set w := b i s with hw
  have hwz : ‖w - z‖ = s := hnorm i s hs
  -- the other rays stay away from `w`
  have havoid : ∀ j, ∀ᶠ y in 𝓝 w, j ≠ i → y ∉ b j '' Ioo 0 r := by
    intro j
    by_cases hji : j = i
    · exact Eventually.of_forall fun _ h => absurd hji h
    have hca : ContinuousAt (b j) s := (hcont j).continuousAt (Ioo_mem_nhds hs.1 hs.2)
    have hd₀ : 0 < dist (b j s) w := dist_pos.mpr (hdisj j i hji s hs)
    obtain ⟨η, hη, hηc⟩ := Metric.continuousAt_iff.mp hca (dist (b j s) w / 2) (by linarith)
    filter_upwards [ball_mem_nhds w (lt_min hη (half_pos hd₀))] with y hy _ ⟨s', hs', hys'⟩
    rw [mem_ball] at hy
    have hs's : |s' - s| < η := by
      have h1 : ‖y - z‖ = s' := hys' ▸ hnorm j s' hs'
      have h2 := abs_norm_sub_norm_le (y - z) (w - z)
      rw [h1, hwz, show y - z - (w - z) = y - w by ring, ← dist_eq_norm] at h2
      exact lt_of_le_of_lt h2 (lt_of_lt_of_le hy (min_le_left _ _))
    have h3 := hηc (show dist s' s < η by rwa [Real.dist_eq])
    rw [hys'] at h3
    have := dist_triangle (b j s) y w
    rw [dist_comm] at h3
    linarith [lt_of_lt_of_le hy (min_le_right _ _)]
  have hwb : w ∈ ball z r := by rw [mem_ball, dist_eq_norm, hwz]; exact hs.2
  have hwne : w ≠ z := by intro h; rw [h, sub_self, norm_zero] at hwz; exact hs.1.ne hwz
  have hb1 : ∀ᶠ y in 𝓝 w, y ∈ ball z r := isOpen_ball.mem_nhds hwb
  have hb2 : ∀ᶠ y in 𝓝 w, y ≠ z := eventually_ne_nhds hwne
  have hev : ∀ᶠ y in 𝓝 w, (∀ j, j ≠ i → y ∉ b j '' Ioo 0 r) ∧ y ∈ ball z r ∧ y ≠ z :=
    (eventually_all.mpr havoid).and (hb1.and hb2)
  obtain ⟨ε, hε, hεP⟩ := Metric.eventually_nhds_iff.mp hev
  refine ⟨ε, hε, Subset.antisymm ?_ ?_⟩
  · rintro y ⟨hyC, hyb⟩
    obtain ⟨hy1, hy2, hy3⟩ := hεP hyb
    have : y ∈ C ∩ ball z r := ⟨hyC, hy2⟩
    rw [heq] at this
    rcases this with rfl | hy
    · exact absurd rfl hy3
    · obtain ⟨j, hj⟩ := mem_iUnion.mp hy
      by_cases hji : j = i
      · exact ⟨hji ▸ hj, hyb⟩
      · exact absurd hj (hy1 j hji)
  · rintro y ⟨hy, hyb⟩
    have : y ∈ insert z (⋃ j, b j '' Ioo 0 r) := Or.inr (mem_iUnion.mpr ⟨i, hy⟩)
    rw [← heq] at this
    exact ⟨this.1, hyb⟩

/-- **Off its centre a star is regular**: near a point of a ray, `C` is the ray, which is a curve there. -/
theorem HasCurveStar.isRegularAt {C : Set ℂ} {z : ℂ} {n : ℕ} (h : HasCurveStar C z n) :
    ∃ r > 0, ∀ w ∈ C ∩ ball z r, w ≠ z → IsRegularAt C w := by
  obtain ⟨r, hr, b, hcont, hnorm, hdisj, heq, hcurve⟩ := h
  refine ⟨r, hr, fun w hw hwz => ?_⟩
  have hw' := hw
  rw [heq] at hw'
  rcases hw' with rfl | hw'
  · exact absurd rfl hwz
  obtain ⟨i, s, hs, rfl⟩ := mem_iUnion.mp hw'
  obtain ⟨ε, hε, hεeq⟩ := star_local_ray hcont hnorm hdisj heq hs
  obtain ⟨L, hL, ε₀, hε₀, hL0⟩ := hcurve i s hs
  refine ⟨L, hL, min ε ε₀, lt_min hε hε₀, ?_⟩
  have e1 : ball (b i s) (min ε ε₀) = ball (b i s) ε ∩ ball (b i s) ε₀ := by
    ext y; simp [mem_ball]
  rw [e1, ← inter_assoc, hεeq, inter_assoc, inter_comm (ball (b i s) ε), ← inter_assoc, hL0, inter_assoc]

/-- **A compact set with a curve star at each point has finitely many non-regular points**: each is isolated (the stars are regular off
their centres), and finitely many star discs cover. -/
theorem finite_nonRegular {C : Set ℂ} (hC : IsCompact C) (h : ∀ z ∈ C, ∃ n, HasCurveStar C z n) :
    {z | z ∈ C ∧ ¬ IsRegularAt C z}.Finite := by
  have h' : ∀ z ∈ C, ∃ r > 0, ∀ w ∈ C ∩ ball z r, w ≠ z → IsRegularAt C w := fun z hz =>
    let ⟨_, hn⟩ := h z hz; hn.isRegularAt
  choose! r hr hreg using h'
  obtain ⟨t, htC, hcov⟩ := hC.elim_nhds_subcover (fun z => ball z (r z)) fun z hz => ball_mem_nhds z (hr z hz)
  refine t.finite_toSet.subset ?_
  rintro z ⟨hzC, hzr⟩
  obtain ⟨x, hx, hzx⟩ := mem_iUnion₂.mp (hcov hzC)
  by_contra hzt
  have hne : z ≠ x := fun h' => hzt (h' ▸ hx)
  exact hzr (hreg x (htC x hx) z ⟨hzC, hzx⟩ hne)

/-! ## The ports, paired; the handshake -/

/-- The set of points near which `C` agrees with a curve of a given kind is open. -/
theorem isOpen_setOf_agree (C : Set ℂ) (Pr : Set ℂ → Prop) :
    IsOpen {z | ∃ L', Pr L' ∧ ∃ ε > 0, C ∩ ball z ε = L' ∩ ball z ε} := by
  rw [Metric.isOpen_iff]
  rintro z ⟨L', hP, ε, hε, hzε⟩
  refine ⟨ε / 2, half_pos hε, fun z' hz' => ⟨L', hP, ε / 2, half_pos hε, ?_⟩⟩
  have hsub : ball z' (ε / 2) ⊆ ball z ε := by
    intro y hy; rw [mem_ball] at hy hz' ⊢; linarith [dist_triangle y z' z]
  calc C ∩ ball z' (ε / 2) = C ∩ (ball z ε ∩ ball z' (ε / 2)) := by rw [inter_eq_right.mpr hsub]
    _ = (L' ∩ ball z ε) ∩ ball z' (ε / 2) := by rw [← inter_assoc, hzε]
    _ = L' ∩ ball z' (ε / 2) := by rw [inter_assoc, inter_eq_right.mpr hsub]

/-- **The arc of a port** (FS131-RW2, WALK's C5a; the body of `port_pair`, its arc exposed): with the vertices `N` cut out by discs of radius
`ρ`, what is left, `C'`, is regular; the component of `C'` through a port `p` is an arc `γ '' [a, b]` of one curve, `γ` injective on
`[a, b]`, from `γ a = p` to a second port `γ b`, and holds no other port. -/
theorem port_arc {C C' P : Set ℂ} {N : Finset ℂ} {ρ : ℝ} (hρ : 0 < ρ) (hC'c : IsCompact C')
    (hC' : C' = C \ ⋃ v ∈ N, ball v ρ) (hreg : ∀ z ∈ C', IsRegularAt C z)
    (hP : ∀ z, z ∈ P ↔ z ∈ C ∧ ∃ v ∈ N, dist z v = ρ)
    (hray : ∀ p ∈ P, ∃ v ∈ N, ∃ (f : ℝ → ℂ) (r : ℝ), ρ < r ∧ ContinuousOn f (Ioo 0 r) ∧
      (∀ s ∈ Ioo 0 r, ‖f s - v‖ = s) ∧ f ρ = p ∧ ∃ ε > 0, C ∩ ball p ε = f '' Ioo 0 r ∩ ball p ε)
    (hsep : ∀ v ∈ N, ∀ v' ∈ N, v ≠ v' → 2 * ρ < dist v v') {p : ℂ} (hp : p ∈ P) :
    ∃ (γ : ℝ → ℂ) (a b : ℝ), a < b ∧ Continuous γ ∧ InjOn γ (Icc a b) ∧ connectedComponentIn C' p = γ '' Icc a b ∧ γ a = p ∧
      γ b ∈ P ∧ ∀ q' ∈ P, q' ∈ connectedComponentIn C' p → q' = p ∨ q' = γ b := by
  classical
  have hC'C : C' ⊆ C := by rw [hC']; exact sdiff_subset
  have hnotball : ∀ z ∈ C', ∀ v ∈ N, ¬ dist z v < ρ := by
    intro z hz v hv h
    rw [hC'] at hz
    exact hz.2 (mem_iUnion₂.mpr ⟨v, hv, h⟩)
  have hmemC' : ∀ z ∈ C, (∀ v ∈ N, ρ ≤ dist z v) → z ∈ C' := by
    intro z hz hfar
    rw [hC']
    refine ⟨hz, fun h => ?_⟩
    obtain ⟨v, hv, hb⟩ := mem_iUnion₂.mp h
    rw [mem_ball] at hb
    linarith [hfar v hv]
  -- ports lie in `C'`, far from the other vertices
  have hother : ∀ z v, v ∈ N → dist z v = ρ → ∀ v' ∈ N, v' ≠ v → ρ < dist z v' := by
    intro z v hv hzv v' hv' hne
    have h1 := hsep v hv v' hv' (Ne.symm hne)
    have h2 := dist_triangle v z v'
    rw [dist_comm v z] at h2
    linarith
  have hPC' : ∀ z ∈ P, z ∈ C' := by
    intro z hz
    obtain ⟨hzC, v, hv, hzv⟩ := (hP z).mp hz
    refine hmemC' z hzC fun v' hv' => ?_
    by_cases h : v' = v
    · rw [h, hzv]
    · exact (hother z v hv hzv v' hv' h).le
  set Q := connectedComponentIn C' p with hQdef
  have hpC' := hPC' p hp
  have hpQ : p ∈ Q := mem_connectedComponentIn hpC'
  have hQC' : Q ⊆ C' := connectedComponentIn_subset _ _
  have hQpre : IsPreconnected Q := isPreconnected_connectedComponentIn
  have hQcl : IsClosed Q := by
    refine isClosed_of_closure_subset ?_
    exact hQpre.closure.subset_connectedComponentIn (subset_closure hpQ) (closure_minimal hQC' hC'c.isClosed)
  have hQcpt : IsCompact Q := hC'c.of_isClosed_subset hQcl hQC'
  have hsubQ : ∀ {S : Set ℂ} {z : ℂ}, IsPreconnected S → z ∈ S → z ∈ Q → S ⊆ C' → S ⊆ Q := by
    intro S z hS hzS hzQ hSC'
    have h := hS.subset_connectedComponentIn hzS hSC'
    rwa [← connectedComponentIn_eq hzQ] at h
  -- the curve of `p`, and `Q` inside it
  obtain ⟨L, hL, εp, hεp, hLp⟩ := hreg p hpC'
  set u := {z | ∃ L', L' = L ∧ ∃ ε > 0, C ∩ ball z ε = L' ∩ ball z ε} with hudef
  set w := {z | ∃ L', (IsCurve L' ∧ L' ≠ L) ∧ ∃ ε > 0, C ∩ ball z ε = L' ∩ ball z ε} with hwdef
  have hconflict : ∀ z ∈ C, ∀ L', IsCurve L' → L' ≠ L → ∀ ε₁ > 0, ∀ ε₂ > 0, C ∩ ball z ε₁ = L ∩ ball z ε₁ →
      C ∩ ball z ε₂ = L' ∩ ball z ε₂ → False := by
    intro z hzC L' hL' hne ε₁ hε₁ ε₂ hε₂ h1 h2
    have hzL : z ∈ L := by
      have : z ∈ C ∩ ball z ε₁ := ⟨hzC, mem_ball_self hε₁⟩
      rw [h1] at this; exact this.1
    refine hne (hL.eq_of_inter_ball_subset hL' hzL (lt_min hε₁ hε₂) ?_).symm
    rintro y ⟨hyL, hy⟩
    have hy1 : y ∈ ball z ε₁ := ball_subset_ball (min_le_left _ _) hy
    have hy2 : y ∈ ball z ε₂ := ball_subset_ball (min_le_right _ _) hy
    have h3 : y ∈ C ∩ ball z ε₁ := by rw [h1]; exact ⟨hyL, hy1⟩
    have h4 : y ∈ C ∩ ball z ε₂ := ⟨h3.1, hy2⟩
    rw [h2] at h4
    exact h4.1
  have hQuw : Q ⊆ u ∪ w := by
    intro z hz
    obtain ⟨L', hL', ε, hε, h⟩ := hreg z (hQC' hz)
    by_cases hLL : L' = L
    · exact Or.inl ⟨L', hLL, ε, hε, h⟩
    · exact Or.inr ⟨L', ⟨hL', hLL⟩, ε, hε, h⟩
  have hdisj : Q ∩ (u ∩ w) = ∅ := by
    ext z
    simp only [mem_inter_iff, mem_empty_iff_false, iff_false]
    rintro ⟨hz, ⟨L₁, rfl, ε₁, hε₁, h1⟩, ⟨L', ⟨hL', hne⟩, ε₂, hε₂, h2⟩⟩
    exact hconflict z (hC'C (hQC' hz)) L' hL' hne ε₁ hε₁ ε₂ hε₂ h1 h2
  have hpu : p ∈ u := ⟨L, rfl, εp, hεp, hLp⟩
  have hQu : ∀ z ∈ Q, ∃ ε > 0, C ∩ ball z ε = L ∩ ball z ε := by
    rcases (isPreconnected_iff_subset_of_disjoint.mp hQpre) u w (isOpen_setOf_agree C _) (isOpen_setOf_agree C _) hQuw
      hdisj with h | h
    · intro z hz
      obtain ⟨L₁, rfl, h'⟩ := h hz
      exact h'
    · exfalso
      have : p ∈ Q ∩ (u ∩ w) := ⟨hpQ, hpu, h hpQ⟩
      rw [hdisj] at this
      exact this
  have hQL : Q ⊆ L := by
    intro z hz
    obtain ⟨ε, hε, h⟩ := hQu z hz
    have : z ∈ C ∩ ball z ε := ⟨hC'C (hQC' hz), mem_ball_self hε⟩
    rw [h] at this
    exact this.1
  -- `Q` is not the whole curve: the ray through `p` dips into `B(v, ρ)`
  obtain ⟨v₀, hv₀, f₀, r₀, hρr₀, hf₀c, hf₀n, hf₀p, εf, hεf, hf₀eq⟩ := hray p hp
  have hQne : Q ≠ L := by
    intro hQLeq
    have hca : ContinuousAt f₀ ρ := hf₀c.continuousAt (Ioo_mem_nhds hρ hρr₀)
    obtain ⟨η, hη, hηc⟩ := Metric.continuousAt_iff.mp hca (min εf εp) (lt_min hεf hεp)
    set s := ρ - min (η / 2) (ρ / 2) with hsdef
    have hm0 : 0 < min (η / 2) (ρ / 2) := lt_min (half_pos hη) (half_pos hρ)
    have hm1 : min (η / 2) (ρ / 2) ≤ ρ / 2 := min_le_right _ _
    have hm2 : min (η / 2) (ρ / 2) ≤ η / 2 := min_le_left _ _
    have hs : s ∈ Ioo 0 r₀ := ⟨by linarith, by linarith⟩
    have hfs : dist (f₀ s) p < min εf εp := by
      rw [← hf₀p]; apply hηc; rw [Real.dist_eq, abs_lt]; constructor <;> linarith
    have hfsC : f₀ s ∈ C := by
      have : f₀ s ∈ f₀ '' Ioo 0 r₀ ∩ ball p εf := ⟨⟨s, hs, rfl⟩, lt_of_lt_of_le hfs (min_le_left _ _)⟩
      rw [← hf₀eq] at this; exact this.1
    have hfsL : f₀ s ∈ L := by
      have : f₀ s ∈ C ∩ ball p εp := ⟨hfsC, lt_of_lt_of_le hfs (min_le_right _ _)⟩
      rw [hLp] at this; exact this.1
    have hfsQ : f₀ s ∈ Q := by rw [hQLeq]; exact hfsL
    exact hnotball _ (hQC' hfsQ) v₀ hv₀ (by rw [dist_eq_norm, hf₀n s hs]; linarith)
  -- an arc of the curve carries `Q`; its parameter set `J` is an interval `[a, b]`
  obtain ⟨γ, α, β, hγc, hγinj, hγL, hQγ⟩ := hL.exists_param hQcpt hQL hQne
  set J := Icc α β ∩ γ ⁻¹' Q with hJdef
  have hJc : IsCompact J := isCompact_Icc.inter_right (hQcl.preimage hγc)
  have hQJ : Q = γ '' J := by
    apply Subset.antisymm
    · intro q hq
      obtain ⟨t, ht, rfl⟩ := hQγ hq
      exact ⟨t, ⟨Ioo_subset_Icc_self ht, hq⟩, rfl⟩
    · rintro _ ⟨t, ht, rfl⟩
      exact ht.2
  have hJpre : IsPreconnected J := by
    rw [isPreconnected_closed_iff]
    intro A B hA hB hJAB hJA hJB
    by_contra hcon
    rw [not_nonempty_iff_eq_empty] at hcon
    have hcA : IsCompact (J ∩ A) := hJc.inter_right hA
    have hcB : IsCompact (J ∩ B) := hJc.inter_right hB
    have key := (isPreconnected_closed_iff.mp hQpre) (γ '' (J ∩ A)) (γ '' (J ∩ B)) (hcA.image hγc).isClosed
      (hcB.image hγc).isClosed ?_ ?_ ?_
    · obtain ⟨_, -, ⟨t₁, ht₁, rfl⟩, ⟨t₂, ht₂, he⟩⟩ := key
      have h12 := hγinj ht₂.1.1 ht₁.1.1 he
      subst h12
      have : t₂ ∈ J ∩ (A ∩ B) := ⟨ht₂.1, ht₁.2, ht₂.2⟩
      rw [hcon] at this
      exact this
    · rw [hQJ]
      rintro _ ⟨t, ht, rfl⟩
      rcases hJAB ht with h | h
      · exact Or.inl ⟨t, ⟨ht, h⟩, rfl⟩
      · exact Or.inr ⟨t, ⟨ht, h⟩, rfl⟩
    · obtain ⟨t, ht⟩ := hJA
      exact ⟨γ t, ht.1.2, t, ht, rfl⟩
    · obtain ⟨t, ht⟩ := hJB
      exact ⟨γ t, ht.1.2, t, ht, rfl⟩
  have hJIoo : ∀ t ∈ J, t ∈ Ioo α β := by
    intro t ht
    obtain ⟨t', ht', he⟩ := hQγ ht.2
    rwa [hγinj (Ioo_subset_Icc_self ht') ht.1 he] at ht'
  -- a non-port point of `Q` is interior to `J`
  have hint : ∀ t ∈ J, γ t ∉ P → ∃ δ > 0, Ioo (t - δ) (t + δ) ⊆ J := by
    intro t ht htP
    have hzQ : γ t ∈ Q := ht.2
    have hzC : γ t ∈ C := hC'C (hQC' hzQ)
    obtain ⟨εz, hεz, hzeq⟩ := hQu _ hzQ
    have hfar : ∀ v ∈ N, ρ < dist (γ t) v := by
      intro v hv
      have h1 := hnotball _ (hQC' hzQ) v hv
      have h2 : dist (γ t) v ≠ ρ := fun h => htP ((hP _).mpr ⟨hzC, v, hv, h⟩)
      push Not at h1
      exact lt_of_le_of_ne h1 (Ne.symm h2)
    have hev : ∀ᶠ y in 𝓝 (γ t), y ∈ ball (γ t) εz ∧ ∀ v ∈ N, ρ < dist y v :=
      (show ∀ᶠ y in 𝓝 (γ t), y ∈ ball (γ t) εz from ball_mem_nhds _ hεz).and ((Finset.eventually_all N).mpr fun v hv =>
        (isOpen_lt continuous_const (continuous_id.dist continuous_const)).mem_nhds (hfar v hv))
    have hev' : ∀ᶠ t' in 𝓝 t, t' ∈ Ioo α β ∧ (γ t' ∈ ball (γ t) εz ∧ ∀ v ∈ N, ρ < dist (γ t') v) :=
      (show ∀ᶠ t' in 𝓝 t, t' ∈ Ioo α β from isOpen_Ioo.mem_nhds (hJIoo t ht)).and (hγc.continuousAt.eventually hev)
    obtain ⟨δ, hδ, hδP⟩ := Metric.eventually_nhds_iff.mp hev'
    have hin : ∀ t' ∈ Ioo (t - δ) (t + δ), dist t' t < δ := by
      intro t' ht'; rw [Real.dist_eq, abs_lt]; constructor <;> linarith [ht'.1, ht'.2]
    have hC'mem : ∀ t' ∈ Ioo (t - δ) (t + δ), γ t' ∈ C' := by
      intro t' ht'
      obtain ⟨hI, hb, hN⟩ := hδP (hin t' ht')
      have hLm : γ t' ∈ L := hγL ⟨t', Ioo_subset_Icc_self hI, rfl⟩
      have hCm : γ t' ∈ C := by
        have : γ t' ∈ L ∩ ball (γ t) εz := ⟨hLm, hb⟩
        rw [← hzeq] at this; exact this.1
      exact hmemC' _ hCm fun v hv => (hN v hv).le
    have hsub : γ '' Ioo (t - δ) (t + δ) ⊆ Q :=
      hsubQ (isPreconnected_Ioo.image _ hγc.continuousOn) ⟨t, ⟨by linarith, by linarith⟩, rfl⟩ hzQ
        (by rintro _ ⟨t', ht', rfl⟩; exact hC'mem t' ht')
    exact ⟨δ, hδ, fun t' ht' => ⟨Ioo_subset_Icc_self (hδP (hin t' ht')).1, hsub ⟨t', ht', rfl⟩⟩⟩
  -- a port of `Q` is one-sided in `J`
  have hend : ∀ t ∈ J, γ t ∈ P → ∃ δ > 0, ((∀ t' ∈ Ioo (t - δ) t, t' ∉ J) ∧ ∀ t' ∈ Ioo t (t + δ), t' ∈ J) ∨
      ((∀ t' ∈ Ioo t (t + δ), t' ∉ J) ∧ ∀ t' ∈ Ioo (t - δ) t, t' ∈ J) := by
    intro t ht htP
    have hzQ : γ t ∈ Q := ht.2
    obtain ⟨εz, hεz, hzeq⟩ := hQu _ hzQ
    obtain ⟨v, hv, f, r, hρr, hfc, hfn, hfp, εf, hεf, hfeq⟩ := hray _ htP
    have hvz : dist (γ t) v = ρ := by rw [← hfp, dist_eq_norm, hfn ρ ⟨hρ, hρr⟩]
    have hev : ∀ᶠ y in 𝓝 (γ t), y ∈ ball (γ t) (min εz εf) ∧ ∀ v' ∈ N, v' ≠ v → ρ < dist y v' :=
      (show ∀ᶠ y in 𝓝 (γ t), y ∈ ball (γ t) (min εz εf) from ball_mem_nhds _ (lt_min hεz hεf)).and
        ((Finset.eventually_all N).mpr fun v' hv' => by
        by_cases hvv : v' = v
        · exact Eventually.of_forall fun _ h => absurd hvv h
        · exact Filter.Eventually.mono (show ∀ᶠ y in 𝓝 (γ t), ρ < dist y v' from
            (isOpen_lt continuous_const (continuous_id.dist continuous_const)).mem_nhds
            (hother _ v hv hvz v' hv' hvv)) fun y hy _ => hy)
    have hev' : ∀ᶠ t' in 𝓝 t, t' ∈ Ioo α β ∧ (γ t' ∈ ball (γ t) (min εz εf) ∧ ∀ v' ∈ N, v' ≠ v → ρ < dist (γ t') v') :=
      (show ∀ᶠ t' in 𝓝 t, t' ∈ Ioo α β from isOpen_Ioo.mem_nhds (hJIoo t ht)).and (hγc.continuousAt.eventually hev)
    obtain ⟨δ, hδ, hδP⟩ := Metric.eventually_nhds_iff.mp hev'
    have hin : ∀ t' ∈ Ioo (t - δ) (t + δ), dist t' t < δ := by
      intro t' ht'; rw [Real.dist_eq, abs_lt]; constructor <;> linarith [ht'.1, ht'.2]
    set g : ℝ → ℝ := fun t' => dist (γ t') v with hg
    have hgc : Continuous g := hγc.dist continuous_const
    have hgt : g t = ρ := hvz
    have hray' : ∀ t' ∈ Ioo (t - δ) (t + δ), t' ∈ Icc α β ∧ γ t' ∈ C ∧ f (g t') = γ t' ∧
        ∀ v' ∈ N, v' ≠ v → ρ < dist (γ t') v' := by
      intro t' ht'
      obtain ⟨hI, hb, hN⟩ := hδP (hin t' ht')
      have hLm : γ t' ∈ L := hγL ⟨t', Ioo_subset_Icc_self hI, rfl⟩
      have hCm : γ t' ∈ C := by
        have : γ t' ∈ L ∩ ball (γ t) εz := ⟨hLm, ball_subset_ball (min_le_left _ _) hb⟩
        rw [← hzeq] at this; exact this.1
      have hf : γ t' ∈ f '' Ioo 0 r := by
        have : γ t' ∈ C ∩ ball (γ t) εf := ⟨hCm, ball_subset_ball (min_le_right _ _) hb⟩
        rw [hfeq] at this; exact this.1
      obtain ⟨s, hs, hfs⟩ := hf
      have hgs : g t' = s := by simp only [hg]; rw [dist_eq_norm, ← hfs, hfn s hs]
      exact ⟨Ioo_subset_Icc_self hI, hCm, by rw [hgs, hfs], hN⟩
    have hginj : InjOn g (Ioo (t - δ) (t + δ)) := by
      intro t₁ h₁ t₂ h₂ he
      have e1 := (hray' t₁ h₁).2.2.1
      have e2 := (hray' t₂ h₂).2.2.1
      exact hγinj (hray' t₁ h₁).1 (hray' t₂ h₂).1 (by rw [← e1, ← e2, he])
    have htin : t ∈ Ioo (t - δ) (t + δ) := ⟨by linarith, by linarith⟩
    -- the side where the ray leaves `B(v, ρ)` lies in `J`
    have hgood : ∀ t₁ t₂, t₁ ∈ Ioo (t - δ) (t + δ) → t₂ ∈ Ioo (t - δ) (t + δ) → (∀ t'' ∈ uIcc t₁ t₂, ρ ≤ g t'') →
        t₁ = t → t₂ ∈ J := by
      intro t₁ t₂ h₁ h₂ hge ht₁
      have hsubI : uIcc t₁ t₂ ⊆ Ioo (t - δ) (t + δ) := (ordConnected_Ioo).uIcc_subset h₁ h₂
      have hC'mem : ∀ t'' ∈ uIcc t₁ t₂, γ t'' ∈ C' := by
        intro t'' ht''
        obtain ⟨-, hCm, -, hN⟩ := hray' t'' (hsubI ht'')
        refine hmemC' _ hCm fun v' hv' => ?_
        by_cases hvv : v' = v
        · rw [hvv]; exact hge t'' ht''
        · exact (hN v' hv' hvv).le
      have hsub : γ '' uIcc t₁ t₂ ⊆ Q :=
        hsubQ (isPreconnected_uIcc.image _ hγc.continuousOn) ⟨t₁, left_mem_uIcc, ht₁ ▸ rfl⟩ hzQ
          (by rintro _ ⟨t'', h, rfl⟩; exact hC'mem t'' h)
      exact ⟨(hray' t₂ h₂).1, hsub ⟨t₂, right_mem_uIcc, rfl⟩⟩
    have hbad : ∀ t' ∈ Ioo (t - δ) (t + δ), g t' < ρ → t' ∉ J := fun t' _ hlt hJ =>
      hnotball _ (hQC' hJ.2) v hv hlt
    refine ⟨δ, hδ, ?_⟩
    rcases hgc.continuousOn.strictMonoOn_of_injOn_Ioo (by linarith) hginj with hmono | hanti
    · refine Or.inl ⟨fun t' ht' => hbad t' ⟨ht'.1, by linarith [ht'.2]⟩ (hgt ▸ hmono ⟨ht'.1, by linarith [ht'.2]⟩ htin ht'.2),
        fun t' ht' => hgood t t' htin ⟨by linarith [ht'.1], ht'.2⟩ ?_ rfl⟩
      intro t'' ht''
      rw [uIcc_of_le ht'.1.le] at ht''
      rcases eq_or_lt_of_le ht''.1 with h | h
      · rw [← h, hgt]
      · exact (hgt ▸ hmono htin ⟨by linarith, by linarith [ht''.2, ht'.2]⟩ h).le
    · refine Or.inr ⟨fun t' ht' => hbad t' ⟨by linarith [ht'.1], ht'.2⟩ (hgt ▸ hanti htin ⟨by linarith [ht'.1], ht'.2⟩ ht'.1),
        fun t' ht' => hgood t t' htin ⟨ht'.1, by linarith [ht'.2]⟩ ?_ rfl⟩
      intro t'' ht''
      rw [uIcc_of_ge ht'.2.le] at ht''
      rcases eq_or_lt_of_le ht''.2 with h | h
      · rw [h, hgt]
      · exact (hgt ▸ hanti ⟨by linarith [ht''.1, ht'.1], by linarith⟩ htin h).le
  -- the ends
  obtain ⟨tp, htpJ, htp⟩ : p ∈ γ '' J := hQJ ▸ hpQ
  have hJne : J.Nonempty := ⟨tp, htpJ⟩
  set a := sInf J with hadef
  set b := sSup J with hbdef
  have haJ : a ∈ J := hJc.sInf_mem hJne
  have hbJ : b ∈ J := hJc.sSup_mem hJne
  have hJeq : J = Icc a b := by
    apply Subset.antisymm
    · intro t ht; exact ⟨csInf_le hJc.bddBelow ht, le_csSup hJc.bddAbove ht⟩
    · exact hJpre.Icc_subset haJ hbJ
  have haP : γ a ∈ P := by
    by_contra h
    obtain ⟨δ, hδ, hsub⟩ := hint a haJ h
    have h1 : a - δ / 2 ∈ J := hsub ⟨by linarith, by linarith⟩
    have h2 : a ≤ a - δ / 2 := csInf_le hJc.bddBelow h1
    linarith
  have hbP : γ b ∈ P := by
    by_contra h
    obtain ⟨δ, hδ, hsub⟩ := hint b hbJ h
    have h1 : b + δ / 2 ∈ J := hsub ⟨by linarith, by linarith⟩
    have h2 : b + δ / 2 ≤ b := le_csSup hJc.bddAbove h1
    linarith
  have hports : ∀ t ∈ J, γ t ∈ P → (t = a ∨ t = b) ∧ a < b := by
    intro t ht htP
    have hab := hJeq ▸ ht
    obtain ⟨δ, hδ, h | h⟩ := hend t ht htP
    · have hta : t = a := by
        by_contra hne
        have hat : a < t := lt_of_le_of_ne hab.1 (Ne.symm hne)
        refine h.1 (max a (t - δ / 2)) ⟨lt_max_of_lt_right (by linarith), max_lt hat (by linarith)⟩ ?_
        rw [hJeq]
        exact ⟨le_max_left _ _, (max_le hab.1 (by linarith)).trans hab.2⟩
      refine ⟨Or.inl hta, ?_⟩
      have h1 : t + δ / 2 ∈ J := h.2 _ ⟨by linarith, by linarith⟩
      have h2 : t + δ / 2 ≤ b := le_csSup hJc.bddAbove h1
      linarith
    · have htb : t = b := by
        by_contra hne
        have htb : t < b := lt_of_le_of_ne hab.2 hne
        refine h.1 (min b (t + δ / 2)) ⟨lt_min htb (by linarith), min_lt_of_right_lt (by linarith)⟩ ?_
        rw [hJeq]
        exact ⟨hab.1.trans (le_min hab.2 (by linarith)), min_le_left _ _⟩
      refine ⟨Or.inr htb, ?_⟩
      have h1 : t - δ / 2 ∈ J := h.2 _ ⟨by linarith, by linarith⟩
      have h2 : a ≤ t - δ / 2 := csInf_le hJc.bddBelow h1
      linarith
  obtain ⟨htpab, hab⟩ := hports tp htpJ (htp ▸ hp)
  have huniq : ∀ q' ∈ P, q' ∈ Q → q' = γ a ∨ q' = γ b := by
    intro q' hq' hq'Q
    obtain ⟨t', ht', rfl⟩ : q' ∈ γ '' J := hQJ ▸ hq'Q
    rcases (hports t' ht' hq').1 with rfl | rfl
    · exact Or.inl rfl
    · exact Or.inr rfl
  have hQab : Q = γ '' Icc a b := by rw [hQJ, hJeq]
  have hinjab : InjOn γ (Icc a b) := hγinj.mono (Icc_subset_Icc haJ.1.1 hbJ.1.2)
  rcases htpab with rfl | rfl
  · refine ⟨γ, a, b, hab, hγc, hinjab, hQab, htp, hbP, fun q' hq' hq'Q => ?_⟩
    rcases huniq q' hq' hq'Q with h | h
    · exact Or.inl (h.trans htp)
    · exact Or.inr h
  · -- the arc read backwards, so that it starts at `p`
    have hrefl : ∀ t ∈ Icc a b, a + b - t ∈ Icc a b := fun t ht => ⟨by linarith [ht.2], by linarith [ht.1]⟩
    refine ⟨fun t => γ (a + b - t), a, b, hab, hγc.comp (by fun_prop), fun t₁ h₁ t₂ h₂ he => ?_, ?_,
      by simp only [add_sub_cancel_left]; exact htp, by simp only [add_sub_cancel_right]; exact haP, fun q' hq' hq'Q => ?_⟩
    · have := hinjab (hrefl t₁ h₁) (hrefl t₂ h₂) he
      linarith
    · rw [hQab]
      ext w
      constructor
      · rintro ⟨t, ht, rfl⟩
        exact ⟨a + b - t, hrefl t ht, by simp only [sub_sub_cancel]⟩
      · rintro ⟨t, ht, rfl⟩
        exact ⟨a + b - t, hrefl t ht, rfl⟩
    · rcases huniq q' hq' hq'Q with h | h
      · exact Or.inr (by simp only [add_sub_cancel_right]; exact h)
      · exact Or.inl (h.trans htp)

/-- **Each port has exactly one partner** (the heart of the handshake): with the vertices `N` cut out by discs of radius `ρ`, what is left,
`C'`, is regular; the component of `C'` through a port `p` lies in one curve, is an arc of it, and holds exactly two ports, its ends. -/
theorem port_pair {C C' P : Set ℂ} {N : Finset ℂ} {ρ : ℝ} (hρ : 0 < ρ) (hC'c : IsCompact C')
    (hC' : C' = C \ ⋃ v ∈ N, ball v ρ) (hreg : ∀ z ∈ C', IsRegularAt C z)
    (hP : ∀ z, z ∈ P ↔ z ∈ C ∧ ∃ v ∈ N, dist z v = ρ)
    (hray : ∀ p ∈ P, ∃ v ∈ N, ∃ (f : ℝ → ℂ) (r : ℝ), ρ < r ∧ ContinuousOn f (Ioo 0 r) ∧
      (∀ s ∈ Ioo 0 r, ‖f s - v‖ = s) ∧ f ρ = p ∧ ∃ ε > 0, C ∩ ball p ε = f '' Ioo 0 r ∩ ball p ε)
    (hsep : ∀ v ∈ N, ∀ v' ∈ N, v ≠ v' → 2 * ρ < dist v v') {p : ℂ} (hp : p ∈ P) :
    ∃ q ∈ P, q ≠ p ∧ q ∈ connectedComponentIn C' p ∧ ∀ q' ∈ P, q' ∈ connectedComponentIn C' p → q' = p ∨ q' = q := by
  obtain ⟨γ, a, b, hab, -, hinj, hQ, hγa, hγb, huniq⟩ := port_arc hρ hC'c hC' hreg hP hray hsep hp
  refine ⟨γ b, hγb, fun h => hab.ne (hinj ⟨le_rfl, hab.le⟩ ⟨hab.le, le_rfl⟩ (hγa.trans h.symm)), ?_, huniq⟩
  rw [hQ]
  exact ⟨b, ⟨hab.le, le_rfl⟩, rfl⟩

/-- **The handshake** (BG): in a compact set with a curve star of `n z` rays at each point `z`, the degrees at the non-regular points have an
even sum. The ports of the vertices (their rays' points at a small radius `ρ`) number `∑ n v` and are paired by `port_pair`. -/
theorem even_sum_deg {C : Set ℂ} (hC : IsCompact C) {n : ℂ → ℕ} (hn : ∀ z ∈ C, HasCurveStar C z (n z)) {N : Finset ℂ}
    (hN : ∀ z, z ∈ N ↔ z ∈ C ∧ ¬ IsRegularAt C z) : Even (∑ v ∈ N, n v) := by
  classical
  choose! r hr b hbc hbn hbd hbeq hbcurve using hn
  have hNC : ∀ v ∈ N, v ∈ C := fun v hv => ((hN v).mp hv).1
  -- the radius of the cut
  have hev : ∀ᶠ ρ in 𝓝[>] (0 : ℝ), 0 < ρ ∧ (∀ v ∈ N, ρ < r v) ∧ ∀ v ∈ N, ∀ v' ∈ N, v ≠ v' → 2 * ρ < dist v v' := by
    refine (show ∀ᶠ ρ in 𝓝[>] (0 : ℝ), 0 < ρ from self_mem_nhdsWithin).and (((Finset.eventually_all N).mpr fun v hv => ?_).and
      ((Finset.eventually_all N).mpr fun v hv => (Finset.eventually_all N).mpr fun v' hv' => ?_))
    · exact Filter.Eventually.mono (Ioo_mem_nhdsGT (hr v (hNC v hv))) fun ρ h => h.2
    · by_cases hvv : v = v'
      · exact Eventually.of_forall fun _ h => absurd hvv h
      · have hd : 0 < dist v v' := dist_pos.mpr hvv
        exact Filter.Eventually.mono (Ioo_mem_nhdsGT (half_pos hd)) fun ρ h _ => by linarith [h.2]
  obtain ⟨ρ, hρ, hρr, hsep⟩ := hev.exists
  set C' := C \ ⋃ v ∈ N, ball v ρ with hC'def
  have hC'c : IsCompact C' := hC.diff (isOpen_biUnion fun v _ => isOpen_ball)
  have hreg : ∀ z ∈ C', IsRegularAt C z := by
    intro z hz
    by_contra h
    have hzN : z ∈ N := (hN z).mpr ⟨hz.1, h⟩
    exact hz.2 (mem_iUnion₂.mpr ⟨z, hzN, mem_ball_self hρ⟩)
  -- the ports
  set Pf : Finset ℂ := N.biUnion fun v => Finset.univ.image fun i => b v i ρ with hPfdef
  have hρI : ∀ v ∈ N, ρ ∈ Ioo 0 (r v) := fun v hv => ⟨hρ, hρr v hv⟩
  have hport_of : ∀ z ∈ C, ∀ v ∈ N, dist z v = ρ → ∃ i, b v i ρ = z := by
    intro z hz v hv hzv
    have hzb : z ∈ C ∩ ball v (r v) := ⟨hz, by rw [mem_ball, hzv]; exact hρr v hv⟩
    rw [hbeq v (hNC v hv)] at hzb
    rcases hzb with rfl | hzb
    · rw [dist_self] at hzv; exact absurd hzv hρ.ne
    · obtain ⟨i, s, hs, hsz⟩ := mem_iUnion.mp hzb
      have : s = ρ := by rw [← hbn v (hNC v hv) i s hs, hsz, ← dist_eq_norm, hzv]
      exact ⟨i, this ▸ hsz⟩
  have hb_mem : ∀ v ∈ N, ∀ i, b v i ρ ∈ C ∧ dist (b v i ρ) v = ρ := by
    intro v hv i
    have : b v i ρ ∈ insert v (⋃ j, b v j '' Ioo 0 (r v)) := Or.inr (mem_iUnion.mpr ⟨i, ρ, hρI v hv, rfl⟩)
    rw [← hbeq v (hNC v hv)] at this
    exact ⟨this.1, by rw [dist_eq_norm, hbn v (hNC v hv) i ρ (hρI v hv)]⟩
  have hPf : ∀ z, z ∈ (Pf : Set ℂ) ↔ z ∈ C ∧ ∃ v ∈ N, dist z v = ρ := by
    intro z
    simp only [hPfdef, Finset.coe_biUnion, Finset.coe_image, Finset.coe_univ, image_univ, mem_iUnion, mem_range,
      Finset.mem_coe, exists_prop]
    constructor
    · rintro ⟨v, hv, i, rfl⟩
      exact ⟨(hb_mem v hv i).1, v, hv, (hb_mem v hv i).2⟩
    · rintro ⟨hz, v, hv, hzv⟩
      exact ⟨v, hv, hport_of z hz v hv hzv⟩
  have hray : ∀ p ∈ (Pf : Set ℂ), ∃ v ∈ N, ∃ (f : ℝ → ℂ) (r' : ℝ), ρ < r' ∧ ContinuousOn f (Ioo 0 r') ∧
      (∀ s ∈ Ioo 0 r', ‖f s - v‖ = s) ∧ f ρ = p ∧ ∃ ε > 0, C ∩ ball p ε = f '' Ioo 0 r' ∩ ball p ε := by
    intro p hp
    obtain ⟨hpC, v, hv, hpv⟩ := (hPf p).mp hp
    obtain ⟨i, rfl⟩ := hport_of p hpC v hv hpv
    have hvC := hNC v hv
    exact ⟨v, hv, b v i, r v, hρr v hv, hbc v hvC i, hbn v hvC i, rfl,
      star_local_ray (hbc v hvC) (hbn v hvC) (hbd v hvC) (hbeq v hvC) (hρI v hv)⟩
  -- the number of ports
  have hcard : Pf.card = ∑ v ∈ N, n v := by
    rw [hPfdef, Finset.card_biUnion]
    · refine Finset.sum_congr rfl fun v hv => ?_
      rw [Finset.card_image_of_injective _ fun i j h => ?_, Finset.card_univ, Fintype.card_fin]
      by_contra hij
      exact hbd v (hNC v hv) i j hij ρ (hρI v hv) h
    · intro v hv v' hv' hvv
      simp only [Function.onFun]
      rw [Finset.disjoint_left]
      intro z hz hz'
      obtain ⟨i, -, rfl⟩ := Finset.mem_image.mp hz
      obtain ⟨j, -, hj⟩ := Finset.mem_image.mp hz'
      have h1 := (hb_mem v hv i).2
      have h2 := (hb_mem v' hv' j).2
      rw [← hj] at h1
      have := hsep v hv v' hv' hvv
      have := dist_triangle v (b v' j ρ) v'
      rw [dist_comm v (b v' j ρ)] at this
      linarith
  -- the pairing
  have hpair := fun p (hp : p ∈ (Pf : Set ℂ)) => port_pair hρ hC'c rfl hreg hPf hray hsep hp
  choose! σ hσP hσne hσQ hσuniq using hpair
  have hinv : ∀ p ∈ Pf, σ (σ p) = p := by
    intro p hp
    have hq := hσP p hp
    have hQeq : connectedComponentIn C' (σ p) = connectedComponentIn C' p := (connectedComponentIn_eq (hσQ p hp)).symm
    have h1 := hσQ (σ p) hq
    rw [hQeq] at h1
    rcases hσuniq p hp (σ (σ p)) (hσP (σ p) hq) h1 with h | h
    · exact h
    · exact absurd h (hσne (σ p) hq)
  have hsum : ∑ x ∈ Pf, (1 : ZMod 2) = 0 :=
    Finset.sum_involution (fun p _ => σ p) (fun _ _ => by decide) (fun p hp _ => hσne p hp) (fun p hp => hσP p hp)
      (fun p hp => hinv p hp)
  rw [Finset.sum_const, nsmul_eq_mul, mul_one] at hsum
  rw [← hcard]
  exact ZMod.natCast_eq_zero_iff_even.mp hsum

/-- **The handshake, with its vertex set**: the non-regular points of a compact set with a curve star at each point are finitely many, and
their degrees have an even sum. -/
theorem exists_finset_even_sum_deg {C : Set ℂ} (hC : IsCompact C) {n : ℂ → ℕ} (hn : ∀ z ∈ C, HasCurveStar C z (n z)) :
    ∃ N : Finset ℂ, (∀ z, z ∈ N ↔ z ∈ C ∧ ¬ IsRegularAt C z) ∧ Even (∑ v ∈ N, n v) := by
  have hfin := finite_nonRegular hC fun z hz => ⟨n z, hn z hz⟩
  refine ⟨hfin.toFinset, fun z => by simp, even_sum_deg hC hn fun z => by simp⟩

/-! ## The branches of a sector chart are curve rays -/

/-- A line `curveAt v 0 b` and a circle `curveAt v 1 b` (`b ≠ 0`) are curves. -/
theorem isCurve_curveAt (v : ℂ) {κ : ℝ} (hκ : κ = 0 ∨ κ = 1) {b : ℂ} (hb : b ≠ 0) : IsCurve (curveAt v κ b) := by
  have hnb : 0 < Complex.normSq b := Complex.normSq_pos.mpr hb
  rcases hκ with rfl | rfl
  · left
    refine ⟨v, I * b, mul_ne_zero I_ne_zero hb, ?_⟩
    ext z
    simp only [curveAt, mem_setOf_eq, zero_mul, mem_range]
    constructor
    · intro h
      refine ⟨((z - v) * (starRingEnd ℂ) b).im / Complex.normSq b, ?_⟩
      have hre : ((z - v) * (starRingEnd ℂ) b).re = 0 := by linarith
      have key : (z - v) * (starRingEnd ℂ) b * b = (z - v) * Complex.normSq b := by
        rw [mul_assoc, ← Complex.normSq_eq_conj_mul_self]
      have hw : (z - v) * (starRingEnd ℂ) b = (((z - v) * (starRingEnd ℂ) b).im : ℂ) * I := by
        apply Complex.ext <;> simp [hre]
      have hnb' : (Complex.normSq b : ℂ) ≠ 0 := by exact_mod_cast hnb.ne'
      rw [hw] at key
      have h' : (((z - v) * (starRingEnd ℂ) b).im : ℂ) / (Complex.normSq b : ℂ) * (I * b) = z - v := by
        rw [div_mul_eq_mul_div, div_eq_iff hnb']
        linear_combination key
      push_cast
      linear_combination h'
    · rintro ⟨t, rfl⟩
      have : (v + (t : ℂ) * (I * b) - v) * (starRingEnd ℂ) b = ((t * Complex.normSq b : ℝ) : ℂ) * I := by
        rw [show v + (t : ℂ) * (I * b) - v = (t : ℂ) * I * b by ring, mul_assoc, Complex.mul_conj]; push_cast; ring
      rw [this]; simp
  · right
    refine ⟨v + b, ‖b‖, norm_pos_iff.mpr hb, ?_⟩
    ext z
    simp only [curveAt, mem_setOf_eq, one_mul, mem_sphere, dist_eq_norm]
    have e1 : ‖z - (v + b)‖ ^ 2 = Complex.normSq (z - v) - 2 * ((z - v) * (starRingEnd ℂ) b).re + ‖b‖ ^ 2 := by
      rw [show z - (v + b) = (z - v) - b by ring, ← Complex.normSq_eq_norm_sq, ← Complex.normSq_eq_norm_sq,
        Complex.normSq_sub]
      ring
    constructor
    · intro h
      have : ‖z - (v + b)‖ ^ 2 = ‖b‖ ^ 2 := by rw [e1, h]; ring
      exact (pow_left_inj₀ (norm_nonneg _) (norm_nonneg _) two_ne_zero).mp this
    · intro h
      rw [h] at e1; linarith

/-- `e (arg (c e φ)) = e φ` for `c > 0`. -/
theorem e_arg_mul_e {c : ℝ} (hc : 0 < c) (φ : ℝ) : e (arg ((c : ℂ) * e φ)) = e φ := by
  have h1 := eq_polar_arg ((c : ℂ) * e φ)
  rw [norm_mul_e hc.le] at h1
  have hc0 : (c : ℂ) ≠ 0 := by exact_mod_cast hc.ne'
  exact (mul_left_cancel₀ hc0 h1).symm

/-- A branch point reads its direction modulo `2π`. -/
theorem branchPt_congr {v : ℂ} {β₁ β₂ : ℝ} (h : e β₁ = e β₂) (κ t : ℝ) : branchPt v β₁ κ t = branchPt v β₂ κ t := by
  simp only [branchPt, e_add, h]

/-- **Every branch germ is a curve germ**: `(β, κ)` with `|κ| r < 2` is the germ of a line or a circle through `v` on one side. -/
theorem exists_curveGerm_eq (v : ℂ) (β κ : ℝ) {r : ℝ} (hκr : |κ| * r < 2) :
    ∃ κ' b σ, (κ' = 0 ∨ κ' = 1) ∧ b ≠ 0 ∧ (σ = 1 ∨ σ = -1) ∧ κ' * r ≤ 2 * ‖b‖ ∧
      ∀ t, branchPt v β κ t = branchPt v (curveGerm κ' b σ).1 (curveGerm κ' b σ).2 t := by
  have hπ := Real.pi_pos
  by_cases hκ : κ = 0
  · subst hκ
    refine ⟨0, e (β + π / 2), 1, Or.inl rfl, fun h => by simpa [h] using norm_e (β + π / 2), Or.inl rfl,
      by rw [zero_mul]; positivity, fun t => ?_⟩
    have h2 : (curveGerm 0 (e (β + π / 2)) 1).2 = 0 := by simp [curveGerm]
    rw [h2]
    refine branchPt_congr ?_ 0 t
    simp only [curveGerm]
    rw [show toIcoMod Real.two_pi_pos 0 (arg (e (β + π / 2)) - 1 * (π / 2)) =
      toIcoMod Real.two_pi_pos 0 (arg (e (β + π / 2)) - 1 * (π / 2)) + 0 by ring, e_toIcoMod_add, add_zero,
      show arg (e (β + π / 2)) - 1 * (π / 2) = arg (e (β + π / 2)) + -(π / 2) by ring, e_add]
    have h3 : e (arg (e (β + π / 2))) = e (β + π / 2) := by
      have := e_arg_mul_e one_pos (β + π / 2); simpa using this
    rw [h3, ← e_add]; ring_nf
  · set σ : ℝ := if 0 < κ then 1 else -1 with hσ
    have hσ1 : σ = 1 ∨ σ = -1 := by rw [hσ]; split_ifs <;> simp
    have hσκ : σ * |κ| = κ := by
      rw [hσ]; split_ifs with h
      · rw [one_mul, abs_of_pos h]
      · rw [abs_of_neg (lt_of_le_of_ne (not_lt.mp h) hκ)]; ring
    have hκa : 0 < |κ| := abs_pos.mpr hκ
    set b : ℂ := ((1 / |κ| : ℝ) : ℂ) * e (β + σ * (π / 2)) with hb
    have hbn : ‖b‖ = 1 / |κ| := norm_mul_e (by positivity) _
    have hb0 : b ≠ 0 := by intro h; rw [h, norm_zero] at hbn; have : 0 < 1 / |κ| := by positivity
                           linarith
    refine ⟨1, b, σ, Or.inr rfl, hb0, hσ1, ?_, fun t => ?_⟩
    · rw [hbn, one_mul]
      rw [show 2 * (1 / |κ|) = 2 / |κ| by ring, le_div_iff₀ hκa]
      nlinarith
    · have h2 : (curveGerm 1 b σ).2 = κ := by
        simp only [curveGerm]; rw [hbn]; field_simp; linarith [hσκ]
      rw [h2]
      refine branchPt_congr ?_ κ t
      simp only [curveGerm]
      rw [show toIcoMod Real.two_pi_pos 0 (arg b - σ * (π / 2)) = toIcoMod Real.two_pi_pos 0 (arg b - σ * (π / 2)) + 0 by
        ring, e_toIcoMod_add, add_zero, show arg b - σ * (π / 2) = arg b + -(σ * (π / 2)) by ring, e_add,
        hb, e_arg_mul_e (by positivity), ← e_add]
      ring_nf

/-- **A branch is locally a curve**: the branch of the germ `(β, κ)` out to `r` (`|κ| r < 2`, a graph over the radius) agrees near each of
its points with the line or circle carrying it. -/
theorem branch_locally_curve (v : ℂ) (β κ : ℝ) {r : ℝ} (hκr : |κ| * r < 2) {s : ℝ} (hs : s ∈ Ioo 0 r) :
    ∃ L, IsCurve L ∧ ∃ ε > 0, branchPt v β κ '' Ioo 0 r ∩ ball (branchPt v β κ s) ε =
      L ∩ ball (branchPt v β κ s) ε := by
  have hπ := Real.pi_pos
  obtain ⟨κ', b, σ, hκ', hb, hσ, hbig, hbr⟩ := exists_curveGerm_eq v β κ hκr
  have hκ0 : 0 ≤ κ' := by rcases hκ' with h | h <;> simp [h]
  have hbn : 0 < ‖b‖ := norm_pos_iff.mpr hb
  have hσ' : -σ = 1 ∨ -σ = -1 := by rcases hσ with h | h <;> simp [h]
  have hsmall : ∀ t ∈ Ioo 0 r, κ' * t < 2 * ‖b‖ := by
    intro t ht
    rcases hκ' with h | h
    · rw [h, zero_mul]; positivity
    · rw [h, one_mul] at hbig ⊢; linarith [ht.2]
  have hpL : ∀ t ∈ Ioo 0 r, branchPt v β κ t ∈ curveAt v κ' b := by
    intro t ht
    rw [hbr t]
    exact branchPt_curveGerm_mem hκ0 hb hσ ht.1.le (hsmall t ht).le
  set q := branchPt v (curveGerm κ' b (-σ)).1 (curveGerm κ' b (-σ)).2 with hq
  -- the other germ of the curve stays away from `branchPt v β κ s`
  have hqp : q s ≠ branchPt v β κ s := by
    simp only [hq]
    rw [hbr s, branchPt_curveGerm, branchPt_curveGerm]
    intro h
    rw [polar_eq_iff (v := v) hs.1 hs.1] at h
    set x := κ' * s / (2 * ‖b‖) with hx
    have hx0 : 0 ≤ x := div_nonneg (mul_nonneg hκ0 hs.1.le) (by positivity)
    have hx1 : x < 1 := by rw [hx, div_lt_one (by positivity)]; exact hsmall s hs
    have ha0 : 0 ≤ Real.arcsin x := Real.arcsin_nonneg.mpr hx0
    have ha1 : Real.arcsin x < π / 2 := by
      rw [← Real.arcsin_one]; exact Real.arcsin_lt_arcsin (by linarith) hx1 le_rfl
    have hd : e ((arg b - -σ * (π / 2) + Real.arcsin (-σ * x)) - (arg b - σ * (π / 2) + Real.arcsin (σ * x))) = 1 := by
      rw [show (arg b - -σ * (π / 2) + Real.arcsin (-σ * x)) - (arg b - σ * (π / 2) + Real.arcsin (σ * x)) =
        (arg b - -σ * (π / 2) + Real.arcsin (-σ * x)) + -(arg b - σ * (π / 2) + Real.arcsin (σ * x)) by ring, e_add, h.2,
        ← e_add, add_neg_cancel]
      simp [e]
    refine e_ne_one ?_ ?_ hd <;> rcases hσ with rfl | rfl <;>
      simp only [neg_neg, one_mul, neg_mul, Real.arcsin_neg] <;>
      first
      | (intro h0; linarith)
      | (rw [abs_lt]; constructor <;> linarith)
  have hd : 0 < ‖q s - branchPt v β κ s‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hqp)
  have hqc : ContinuousAt q s := (continuous_branchPt v _ _).continuousAt
  obtain ⟨η, hη, hηc⟩ := Metric.continuousAt_iff.mp hqc (‖q s - branchPt v β κ s‖ / 2) (by linarith)
  set ε := min (min s (r - s)) (min η (‖q s - branchPt v β κ s‖ / 2)) with hε
  have hε0 : 0 < ε := lt_min (lt_min hs.1 (by linarith [hs.2])) (lt_min hη (by linarith))
  refine ⟨curveAt v κ' b, isCurve_curveAt v hκ' hb, ε, hε0, Subset.antisymm ?_ ?_⟩
  · rintro _ ⟨⟨t, ht, rfl⟩, hb'⟩
    exact ⟨hpL t ht, hb'⟩
  · rintro w ⟨hwL, hwb⟩
    rw [mem_ball] at hwb
    have hps : ‖branchPt v β κ s - v‖ = s := norm_branchPt_sub v β κ hs.1.le
    have hwv : |‖w - v‖ - s| ≤ dist w (branchPt v β κ s) := by
      have := abs_norm_sub_norm_le (w - v) (branchPt v β κ s - v)
      rw [hps, show w - v - (branchPt v β κ s - v) = w - branchPt v β κ s by ring] at this
      rw [dist_eq_norm]; exact this
    have hεs : ε ≤ s := (min_le_left _ _).trans (min_le_left _ _)
    have hεr : ε ≤ r - s := (min_le_left _ _).trans (min_le_right _ _)
    have hεη : ε ≤ η := (min_le_right _ _).trans (min_le_left _ _)
    have hεd : ε ≤ ‖q s - branchPt v β κ s‖ / 2 := (min_le_right _ _).trans (min_le_right _ _)
    have hwI : ‖w - v‖ ∈ Ioo 0 r := by
      constructor <;> cases abs_le.mp hwv <;> linarith
    have hwne : w ≠ v := by intro h; rw [h, sub_self, norm_zero] at hwI; exact lt_irrefl _ hwI.1
    obtain ⟨σ', hσ'', hw⟩ := exists_eq_branchPt_curveGerm hκ0 hb hwL hwne (hsmall _ hwI)
    have hσσ : σ' = σ ∨ σ' = -σ := by
      rcases hσ with rfl | rfl <;> rcases hσ'' with rfl | rfl <;> norm_num
    rcases hσσ with rfl | rfl
    · refine ⟨⟨‖w - v‖, hwI, ?_⟩, hwb⟩
      rw [hbr]; exact hw.symm
    · exfalso
      have hwq : w = q ‖w - v‖ := hw
      have h1 : dist (q ‖w - v‖) (q s) < ‖q s - branchPt v β κ s‖ / 2 := by
        apply hηc
        rw [Real.dist_eq]
        exact lt_of_le_of_lt hwv (lt_of_lt_of_le hwb hεη)
      have h2 := dist_triangle (q s) w (branchPt v β κ s)
      rw [dist_comm (q s) w, dist_eq_norm (q s)] at h2
      rw [← hwq] at h1
      linarith

/-- **One branch is a curve star of one ray.** -/
theorem hasCurveStar_of_branch {C : Set ℂ} {v : ℂ} (β κ : ℝ) {r : ℝ} (hr : 0 < r) (hcurv : |κ| * r < 2)
    (heq : C ∩ ball v r = insert v (branchPt v β κ '' Ioo 0 r)) : HasCurveStar C v 1 := by
  refine ⟨r, hr, fun _ => branchPt v β κ, fun _ => (continuous_branchPt v _ _).continuousOn,
    fun _ s hs => norm_branchPt_sub v _ _ hs.1.le, fun i j hij => absurd (Subsingleton.elim i j) hij, ?_,
    fun _ s hs => branch_locally_curve v _ _ hcurv hs⟩
  rw [heq]
  congr 1
  ext w
  simp

/-- **Stars pass to components**: a curve star of `C` at a point of a component of `C` is one of the component (each ray with the centre is
connected). -/
theorem HasCurveStar.connectedComponentIn {C : Set ℂ} {z x : ℂ} {n : ℕ} (h : HasCurveStar C z n)
    (hz : z ∈ connectedComponentIn C x) : HasCurveStar (connectedComponentIn C x) z n := by
  obtain ⟨r, hr, b, hcont, hnorm, hdisj, heq, hcurve⟩ := h
  refine ⟨r, hr, b, hcont, hnorm, hdisj, Subset.antisymm ?_ ?_, hcurve⟩
  · rw [← heq]
    exact inter_subset_inter_left _ (connectedComponentIn_subset _ _)
  · -- the star is connected and lies in `C`
    have hray : ∀ i, IsPreconnected (insert z (b i '' Ioo 0 r)) := by
      intro i
      have hpre : IsPreconnected (b i '' Ioo 0 r) := isPreconnected_Ioo.image _ (hcont i)
      refine hpre.subset_closure (subset_insert _ _) (insert_subset_iff.mpr ⟨?_, subset_closure⟩)
      rw [Metric.mem_closure_iff]
      intro ε hε
      refine ⟨b i (min ε r / 2), ⟨min ε r / 2, ⟨by positivity, by linarith [min_le_right ε r]⟩, rfl⟩, ?_⟩
      rw [dist_comm, dist_eq_norm, hnorm i _ ⟨by positivity, by linarith [min_le_right ε r]⟩]
      linarith [min_le_left ε r, lt_min hε hr]
    have hstar : IsPreconnected (insert z (⋃ i, b i '' Ioo 0 r)) := by
      refine isPreconnected_of_forall z fun y hy => ?_
      rcases hy with rfl | hy
      · exact ⟨{y}, singleton_subset_iff.mpr (mem_insert _ _), rfl, rfl, isPreconnected_singleton⟩
      · obtain ⟨i, hi⟩ := mem_iUnion.mp hy
        exact ⟨insert z (b i '' Ioo 0 r), insert_subset_insert (subset_iUnion (fun i => b i '' Ioo 0 r) i),
          mem_insert _ _, mem_insert_of_mem _ hi, hray i⟩
    have hsub : insert z (⋃ i, b i '' Ioo 0 r) ⊆ C := by
      rw [← heq]; exact inter_subset_left
    have h1 := hstar.subset_connectedComponentIn (mem_insert _ _) hsub
    rw [← connectedComponentIn_eq hz] at h1
    intro w hw
    have hwC : w ∈ C ∩ ball z r := by rw [heq]; exact hw
    exact ⟨h1 hw, hwC.2⟩

/-- **A curve has two points at every small distance from each of its points.** -/
theorem IsCurve.exists_two_mem_sphere {L : Set ℂ} (hL : IsCurve L) {z : ℂ} (hz : z ∈ L) :
    ∃ s₀ > 0, ∀ s ∈ Ioo 0 s₀, ∃ p₁ ∈ L, ∃ p₂ ∈ L, p₁ ≠ p₂ ∧ ‖p₁ - z‖ = s ∧ ‖p₂ - z‖ = s := by
  have hπ := Real.pi_pos
  rcases hL with ⟨x, d, hd, rfl⟩ | ⟨c, R, hR, rfl⟩
  · obtain ⟨t₀, rfl⟩ := hz
    have hdn : 0 < ‖d‖ := norm_pos_iff.mpr hd
    refine ⟨1, one_pos, fun s hs => ⟨x + ((t₀ + s / ‖d‖ : ℝ) : ℂ) * d, ⟨_, rfl⟩, x + ((t₀ - s / ‖d‖ : ℝ) : ℂ) * d, ⟨_, rfl⟩,
      ?_, ?_, ?_⟩⟩
    · intro h
      have h1 := line_param_inj hd h
      have : 0 < s / ‖d‖ := div_pos hs.1 hdn
      linarith
    · rw [show x + ((t₀ + s / ‖d‖ : ℝ) : ℂ) * d - (x + (t₀ : ℂ) * d) = ((s / ‖d‖ : ℝ) : ℂ) * d by push_cast; ring,
        norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (div_pos hs.1 hdn)]
      field_simp
    · rw [show x + ((t₀ - s / ‖d‖ : ℝ) : ℂ) * d - (x + (t₀ : ℂ) * d) = ((-(s / ‖d‖) : ℝ) : ℂ) * d by push_cast; ring,
        norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_neg, abs_of_pos (div_pos hs.1 hdn)]
      field_simp
  · have hzc : z = c + (R : ℂ) * e (arg (z - c)) := by
      have h1 := eq_polar_arg (z - c)
      rw [show ‖z - c‖ = R by rw [← dist_eq_norm]; exact mem_sphere.mp hz] at h1
      linear_combination h1
    set φ := arg (z - c)
    refine ⟨2 * R, by positivity, fun s hs => ?_⟩
    set y := 1 - s ^ 2 / (2 * R ^ 2) with hy
    have hy1 : y < 1 := by have : 0 < s ^ 2 / (2 * R ^ 2) := by have := hs.1; positivity
                           linarith
    have hy2 : -1 < y := by
      have : s ^ 2 / (2 * R ^ 2) < 2 := by
        rw [div_lt_iff₀ (by positivity)]; nlinarith [hs.1, hs.2]
      linarith
    set α := Real.arccos y with hα
    have hα0 : 0 < α := Real.arccos_pos.mpr hy1
    have hαπ : α < π := Real.arccos_lt_pi.mpr hy2
    have hcos : Real.cos α = y := Real.cos_arccos (by linarith) hy1.le
    have hpt : ∀ σ : ℝ, (σ = 1 ∨ σ = -1) → c + (R : ℂ) * e (φ + σ * α) ∈ sphere c R ∧
        ‖c + (R : ℂ) * e (φ + σ * α) - z‖ = s := by
      intro σ hσ
      refine ⟨by rw [mem_sphere, dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, norm_e, mul_one,
        Real.norm_eq_abs, abs_of_pos hR], ?_⟩
      conv_lhs => rw [hzc]
      rw [show c + (R : ℂ) * e (φ + σ * α) - (c + (R : ℂ) * e φ) = (R : ℂ) * (e (φ + σ * α) - e φ) by ring,
        norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hR]
      have hsq := sq_norm_e_sub_e (φ + σ * α) φ
      have hc2 : Real.cos (φ + σ * α - φ) = y := by
        rw [show φ + σ * α - φ = σ * α by ring]
        rcases hσ with rfl | rfl
        · rw [one_mul, hcos]
        · rw [neg_one_mul, Real.cos_neg, hcos]
      rw [hc2, hy] at hsq
      have hn : ‖e (φ + σ * α) - e φ‖ = s / R := by
        have h0 : 0 ≤ ‖e (φ + σ * α) - e φ‖ := norm_nonneg _
        have h1 : ‖e (φ + σ * α) - e φ‖ ^ 2 = (s / R) ^ 2 := by rw [hsq]; field_simp; ring
        exact (pow_left_inj₀ h0 (div_pos hs.1 hR).le two_ne_zero).mp h1
      rw [hn]; field_simp
    obtain ⟨h1L, h1s⟩ := hpt 1 (Or.inl rfl)
    obtain ⟨h2L, h2s⟩ := hpt (-1) (Or.inr rfl)
    refine ⟨_, h1L, _, h2L, ?_, h1s, h2s⟩
    intro h
    have hR0 : (R : ℂ) ≠ 0 := by exact_mod_cast hR.ne'
    have h1 : e (φ + 1 * α) = e (φ + -1 * α) := mul_left_cancel₀ hR0 (add_left_cancel h)
    have h2 : e (2 * α) = 1 := by
      have : e (φ + 1 * α) = e (φ + -1 * α) * e (2 * α) := by rw [← e_add]; ring_nf
      rw [h1] at this
      have hne0 : e (φ + -1 * α) ≠ 0 := by
        intro h0; have := norm_e (φ + -1 * α); rw [h0, norm_zero] at this; exact zero_ne_one this
      exact (mul_eq_left₀ hne0).mp this.symm
    refine e_ne_one (by positivity) ?_ h2
    rw [abs_of_pos (by positivity)]; linarith

/-- **A star of one ray is not regular**: a curve has two points at each small distance, the ray one. -/
theorem not_isRegularAt_of_hasCurveStar_one {C : Set ℂ} {z : ℂ} (h : HasCurveStar C z 1) : ¬ IsRegularAt C z := by
  rintro ⟨L, hL, ε, hε, hCL⟩
  obtain ⟨r, hr, b, -, hnorm, -, heq, -⟩ := h
  have hzC : z ∈ C := by
    have : z ∈ insert z (⋃ i, b i '' Ioo 0 r) := mem_insert _ _
    rw [← heq] at this; exact this.1
  have hzL : z ∈ L := by
    have : z ∈ C ∩ ball z ε := ⟨hzC, mem_ball_self hε⟩
    rw [hCL] at this; exact this.1
  obtain ⟨s₀, hs₀, htwo⟩ := hL.exists_two_mem_sphere hzL
  set s := min (min s₀ ε) r / 2 with hsdef
  have hm : 0 < min (min s₀ ε) r := lt_min (lt_min hs₀ hε) hr
  have hs0 : 0 < s := half_pos hm
  have hss₀ : s < s₀ := by linarith [min_le_left (min s₀ ε) r, min_le_left s₀ ε]
  have hsε : s < ε := by linarith [min_le_left (min s₀ ε) r, min_le_right s₀ ε]
  have hsr : s < r := by linarith [min_le_right (min s₀ ε) r]
  obtain ⟨p₁, hp₁, p₂, hp₂, hne, h1, h2⟩ := htwo s ⟨hs0, hss₀⟩
  have key : ∀ p ∈ L, ‖p - z‖ = s → p = b 0 s := by
    intro p hp hps
    have hpC : p ∈ C := by
      have : p ∈ L ∩ ball z ε := ⟨hp, by rw [mem_ball, dist_eq_norm, hps]; exact hsε⟩
      rw [← hCL] at this; exact this.1
    have hpb : p ∈ C ∩ ball z r := ⟨hpC, by rw [mem_ball, dist_eq_norm, hps]; exact hsr⟩
    rw [heq] at hpb
    rcases hpb with rfl | hp'
    · rw [sub_self, norm_zero] at hps; exact absurd hps.symm hs0.ne'
    · obtain ⟨i, s', hs', rfl⟩ := mem_iUnion.mp hp'
      have hs's : s' = s := by rw [← hnorm i s' hs', hps]
      rw [hs's, Subsingleton.elim i 0]
  exact hne ((key p₁ hp₁ h1).trans (key p₂ hp₂ h2).symm)

/-! ## Spec examples -/

/-- The unit circle is a curve. -/
example : IsCurve (sphere (0 : ℂ) 1) := Or.inr ⟨0, 1, one_pos, rfl⟩

/-- The empty set is no curve (a drift check on `IsCurve`: lines and circles of positive radius are nonempty). -/
example : ¬ IsCurve (∅ : Set ℂ) := by
  rintro (⟨x, d, -, h⟩ | ⟨c, R, hR, h⟩)
  · have : x + ((0 : ℝ) : ℂ) * d ∈ (∅ : Set ℂ) := by rw [h]; exact ⟨0, rfl⟩
    exact this
  · have : c + (R : ℂ) * e 0 ∈ (∅ : Set ℂ) := by
      rw [h, mem_sphere, dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, norm_e, mul_one, Real.norm_eq_abs,
        abs_of_pos hR]
    exact this

/-- **An inhabitant of `HasCurveStar`, every clause exercised**: the closed half-line `[0, ∞)` has a star of one ray at `0` (the branch of the
straight germ of direction `0`), and is not regular there. -/
theorem halfLine_hasCurveStar : HasCurveStar {z : ℂ | ∃ t : ℝ, 0 ≤ t ∧ z = t} 0 1 ∧
    ¬ IsRegularAt {z : ℂ | ∃ t : ℝ, 0 ≤ t ∧ z = t} 0 := by
  have hb : ∀ s : ℝ, branchPt 0 0 0 s = (s : ℂ) := fun s => by simp [branchPt, e]
  have hstar : HasCurveStar {z : ℂ | ∃ t : ℝ, 0 ≤ t ∧ z = t} 0 1 := by
    refine hasCurveStar_of_branch 0 0 one_pos (by simp) ?_
    ext z
    simp only [mem_inter_iff, mem_setOf_eq, mem_ball, dist_zero_right, mem_insert_iff, mem_image, hb]
    constructor
    · rintro ⟨⟨t, ht, rfl⟩, hz⟩
      rcases eq_or_lt_of_le ht with h | h
      · left; rw [← h]; simp
      · right
        rw [Complex.norm_real, Real.norm_eq_abs, abs_of_pos h] at hz
        exact ⟨t, ⟨h, hz⟩, rfl⟩
    · rintro (rfl | ⟨t, ht, rfl⟩)
      · exact ⟨⟨0, le_rfl, by simp⟩, by simp⟩
      · refine ⟨⟨t, ht.1.le, rfl⟩, ?_⟩
        rw [Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht.1]; exact ht.2
  exact ⟨hstar, not_isRegularAt_of_hasCurveStar_one hstar⟩

end HadwigerNelson.Plane
