/-! ## Non-Siamese: the pieces of colour `0` are connected subsets of the interior points -/

/-- `e α + e θ = 2 cos((θ − α)/2) e((α + θ)/2)`. -/
theorem e_add_e_eq (α θ : ℝ) : e α + e θ = ((2 * Real.cos ((θ - α) / 2) : ℝ) : ℂ) * e ((α + θ) / 2) := by
  have h1 : e α = e ((α + θ) / 2) * e (-((θ - α) / 2)) := by rw [← e_add]; congr 1; ring
  have h2 : e θ = e ((α + θ) / 2) * e ((θ - α) / 2) := by rw [← e_add]; congr 1; ring
  rw [h1, h2, ← mul_add, mul_comm]
  congr 1
  rw [e_eq, e_eq, Real.cos_neg, Real.sin_neg]
  push_cast; ring

/-- A positive multiple of `e m` has argument `m` up to whole turns. -/
theorem exists_int_arg_eq {z : ℂ} {ρ m : ℝ} (hρ : 0 < ρ) (hz : z = (ρ : ℂ) * e m) :
    ∃ n : ℤ, m = Complex.arg z + n * (2 * π) := by
  have hz0 : z ≠ 0 := by rw [hz]; exact mul_ne_zero (by exact_mod_cast hρ.ne') (e_ne_zero' m)
  have hn : ‖z‖ = ρ := by rw [hz, norm_polar hρ.le]
  have hze := eq_norm_mul_e_arg (x := z)
  rw [hn] at hze
  have : e m = e (Complex.arg z) := by
    have h := hz.symm.trans hze
    exact mul_left_cancel₀ (by exact_mod_cast hρ.ne') h
  exact exists_int_of_e_eq_e this

/-- **The arcs in polar form**: a point of `Γ` is in the closed unit disc, or lies on the circle about a lens centre
`e(60°j ∓ 30°)` with its argument (up to whole turns) in the half of `[60°j − 30°, 60°j + 30°]` on that side. -/
theorem sixArcs_polar {z : ℂ} (hz : z ∈ ⋃ a ∈ sixArcs, a.carrier) :
    ‖z‖ ≤ 1 ∨ ∃ (j : ℕ) (n : ℤ), j < 6 ∧
      ((dist z (e (j * (π / 3) - π / 6)) = 1 ∧ (j : ℝ) * (π / 3) ≤ Complex.arg z + n * (2 * π) ∧
          Complex.arg z + n * (2 * π) ≤ j * (π / 3) + π / 6) ∨
        (dist z (e (j * (π / 3) + π / 6)) = 1 ∧ (j : ℝ) * (π / 3) - π / 6 ≤ Complex.arg z + n * (2 * π) ∧
          Complex.arg z + n * (2 * π) ≤ j * (π / 3))) := by
  have hπ := Real.pi_pos
  obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp hz
  rcases ha with ((⟨j, rfl⟩ | ha) | ⟨j, rfl⟩) | ⟨j, rfl⟩
  · left
    obtain ⟨u, v, hu, hv, huv, rfl⟩ := hza
    simp only [smul_zero, zero_add, Complex.real_smul, norm_mul, norm_e, mul_one, Complex.norm_real,
      Real.norm_of_nonneg hv]
    linarith
  · left
    rw [mem_singleton_iff] at ha
    subst ha
    obtain ⟨θ, -, rfl⟩ := hza
    simp
  · right
    obtain ⟨θ, hθ, rfl⟩ := hza
    have hz' : e ((j : ℕ) * (π / 3) - π / 6) + ((1 : ℝ) : ℂ) * e θ =
        ((2 * Real.cos ((θ - ((j : ℕ) * (π / 3) - π / 6)) / 2) : ℝ) : ℂ) *
          e ((((j : ℕ) * (π / 3) - π / 6) + θ) / 2) := by
      rw [Complex.ofReal_one, one_mul]; exact e_add_e_eq _ _
    have hρ : 0 < 2 * Real.cos ((θ - ((j : ℕ) * (π / 3) - π / 6)) / 2) := by
      have := Real.cos_pos_of_mem_Ioo (x := (θ - ((j : ℕ) * (π / 3) - π / 6)) / 2)
        ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
      linarith
    obtain ⟨n, hn⟩ := exists_int_arg_eq hρ hz'
    refine ⟨j, n, j.isLt, Or.inl ⟨?_, ?_, ?_⟩⟩
    · show dist (e _ + ((1 : ℝ) : ℂ) * e θ) _ = 1
      rw [Complex.dist_eq, add_sub_cancel_left, Complex.ofReal_one, one_mul, norm_e]
    · show _ ≤ Complex.arg (e _ + ((1 : ℝ) : ℂ) * e θ) + _
      linarith [hθ.1]
    · show Complex.arg (e _ + ((1 : ℝ) : ℂ) * e θ) + _ ≤ _
      linarith [hθ.2]
  · right
    obtain ⟨θ, hθ, rfl⟩ := hza
    have hz' : e ((j : ℕ) * (π / 3) + π / 6) + ((1 : ℝ) : ℂ) * e θ =
        ((2 * Real.cos ((θ - ((j : ℕ) * (π / 3) + π / 6)) / 2) : ℝ) : ℂ) *
          e ((((j : ℕ) * (π / 3) + π / 6) + θ) / 2) := by
      rw [Complex.ofReal_one, one_mul]; exact e_add_e_eq _ _
    have hρ : 0 < 2 * Real.cos ((θ - ((j : ℕ) * (π / 3) + π / 6)) / 2) := by
      have := Real.cos_pos_of_mem_Ioo (x := (θ - ((j : ℕ) * (π / 3) + π / 6)) / 2)
        ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
      linarith
    obtain ⟨n, hn⟩ := exists_int_arg_eq hρ hz'
    refine ⟨j, n, j.isLt, Or.inr ⟨?_, ?_, ?_⟩⟩
    · show dist (e _ + ((1 : ℝ) : ℂ) * e θ) _ = 1
      rw [Complex.dist_eq, add_sub_cancel_left, Complex.ofReal_one, one_mul, norm_e]
    · show _ ≤ Complex.arg (e _ + ((1 : ℝ) : ℂ) * e θ) + _
      linarith [hθ.1]
    · show Complex.arg (e _ + ((1 : ℝ) : ℂ) * e θ) + _ ≤ _
      linarith [hθ.2]

/-- An inequality between integer multiples of `π` is an inequality between the integers. -/
theorem int_lt_of_mul_pi_lt {a b : ℤ} (h : (a : ℝ) * π < b * π) : a < b := by
  have := lt_of_mul_lt_mul_right h Real.pi_pos.le
  exact_mod_cast this

/-- `Q_4` lies in the interior points: its angles meet no lens side but its own, and it is open inside those. -/
private theorem sixQ_interior {z : ℂ} (h : sixQ z) : z ∈ sixFrag.interiorPts := by
  have hπ := Real.pi_pos
  obtain ⟨h1, h2, h3, h4, h5, h6⟩ := h
  refine ⟨by show z ∈ ball (0 : ℂ) (3 / 2); rw [mem_ball_zero_iff]; exact h2, fun hz => ?_⟩
  rcases sixArcs_polar hz with hn | ⟨j, n, hj, ⟨hd, b1, b2⟩ | ⟨hd, b1, b2⟩⟩
  · linarith
  · have i1 := int_lt_of_mul_pi_lt (a := 2 * j - 12 * n + 3) (b := 0) (by push_cast; linarith)
    have i2 := int_lt_of_mul_pi_lt (a := 12 * n - 6) (b := 2 * j) (by push_cast; linarith)
    have hj4 : j = 4 := by omega
    have hn1 : n = 1 := by omega
    subst hj4
    have : e (((4 : ℕ) : ℝ) * (π / 3) - π / 6) = e (-(5 * π / 6)) := by
      rw [← e_add_two_pi (-(5 * π / 6))]; congr 1; push_cast; ring
    rw [this] at hd; linarith
  · have i1 := int_lt_of_mul_pi_lt (a := 2 * j - 12 * n + 2) (b := 0) (by push_cast; linarith)
    have i2 := int_lt_of_mul_pi_lt (a := 12 * n - 5) (b := 2 * j) (by push_cast; linarith)
    have hj4 : j = 4 := by omega
    subst hj4
    have : e (((4 : ℕ) : ℝ) * (π / 3) + π / 6) = e (-(π / 2)) := by
      rw [← e_add_two_pi (-(π / 2))]; congr 1; push_cast; ring
    rw [this] at hd; linarith

/-- `G_2` lies in the interior points. -/
private theorem sixG_interior {z : ℂ} (h : sixG z) : z ∈ sixFrag.interiorPts := by
  have hπ := Real.pi_pos
  obtain ⟨h1, h2, h3, h4, h5, h6⟩ := h
  refine ⟨by show z ∈ ball (0 : ℂ) (3 / 2); rw [mem_ball_zero_iff]; exact h2, fun hz => ?_⟩
  rcases sixArcs_polar hz with hn | ⟨j, n, hj, ⟨hd, b1, b2⟩ | ⟨hd, b1, b2⟩⟩
  · linarith
  · have i1 := int_lt_of_mul_pi_lt (a := 2 * j) (b := 6 + 12 * n) (by push_cast; linarith)
    have i2 := int_lt_of_mul_pi_lt (a := 3 + 12 * n) (b := 2 * j) (by push_cast; linarith)
    have hj2 : j = 2 := by omega
    subst hj2
    have : e (((2 : ℕ) : ℝ) * (π / 3) - π / 6) = e (π / 2) := by congr 1; push_cast; ring
    rw [this] at hd; linarith
  · have i1 := int_lt_of_mul_pi_lt (a := 2 * j) (b := 7 + 12 * n) (by push_cast; linarith)
    have i2 := int_lt_of_mul_pi_lt (a := 4 + 12 * n) (b := 2 * j) (by push_cast; linarith)
    have hj3 : j = 3 := by omega
    subst hj3
    have : e (((3 : ℕ) : ℝ) * (π / 3) + π / 6) = e (-(5 * π / 6)) := by
      rw [← e_add_two_pi (-(5 * π / 6))]; congr 1; push_cast; ring
    rw [this] at hd; linarith

/-- A **polar band**: the points `r e(φ)`, `φ ∈ J`, `r` between `ℓ(φ)` and `u(φ)`, as the image of `J × (0, 1)`. -/
theorem isPreconnected_polarBand {J : Set ℝ} (hJ : IsPreconnected J) {ℓ u : ℝ → ℝ} (hℓ : ContinuousOn ℓ J)
    (hu : ContinuousOn u J) :
    IsPreconnected ((fun p : ℝ × ℝ => ((ℓ p.1 + p.2 * (u p.1 - ℓ p.1) : ℝ) : ℂ) * e p.1) '' (J ×ˢ Ioo 0 1)) := by
  refine (hJ.prod isPreconnected_Ioo).image _ ?_
  have h1 : ContinuousOn (fun p : ℝ × ℝ => ℓ p.1) (J ×ˢ Ioo 0 1) := hℓ.comp continuousOn_fst fun p hp => hp.1
  have h2 : ContinuousOn (fun p : ℝ × ℝ => u p.1) (J ×ˢ Ioo 0 1) := hu.comp continuousOn_fst fun p hp => hp.1
  refine ContinuousOn.mul ?_ ((continuous_e.comp continuous_fst).continuousOn)
  exact Complex.continuous_ofReal.comp_continuousOn (h1.add (continuousOn_snd.mul (h2.sub h1)))

/-- A point strictly between `ℓ` and `u` on the ray `φ` lies in the band. -/
theorem mem_polarBand {J : Set ℝ} {ℓ u : ℝ → ℝ} {φ r : ℝ} (hφ : φ ∈ J) (h1 : ℓ φ < r) (h2 : r < u φ) :
    (r : ℂ) * e φ ∈ (fun p : ℝ × ℝ => ((ℓ p.1 + p.2 * (u p.1 - ℓ p.1) : ℝ) : ℂ) * e p.1) '' (J ×ˢ Ioo 0 1) := by
  have hpos : 0 < u φ - ℓ φ := by linarith
  refine ⟨(φ, (r - ℓ φ) / (u φ - ℓ φ)), ⟨hφ, div_pos (by linarith) hpos, (div_lt_one hpos).mpr (by linarith)⟩, ?_⟩
  simp only
  congr 2
  field_simp
  ring

/-- The points of a band are strictly between `ℓ` and `u` when `ℓ < u` on `J`. -/
theorem polarBand_bounds {J : Set ℝ} {ℓ u : ℝ → ℝ} (hlu : ∀ φ ∈ J, ℓ φ < u φ) {z : ℂ}
    (hz : z ∈ (fun p : ℝ × ℝ => ((ℓ p.1 + p.2 * (u p.1 - ℓ p.1) : ℝ) : ℂ) * e p.1) '' (J ×ˢ Ioo 0 1)) :
    ∃ φ ∈ J, ∃ r, ℓ φ < r ∧ r < u φ ∧ z = (r : ℂ) * e φ := by
  obtain ⟨⟨φ, t⟩, ⟨hφ, ht0, ht1⟩, rfl⟩ := hz
  have := hlu φ hφ
  refine ⟨φ, hφ, ℓ φ + t * (u φ - ℓ φ), by nlinarith, by nlinarith, rfl⟩

/-- The sector `S_0` lies in a connected set of interior points. -/
private theorem sixS_connected : ∃ C : Set ℂ, IsPreconnected C ∧ C ⊆ sixFrag.interiorPts ∧ ∀ z, sixS z → z ∈ C := by
  have hπ := Real.pi_pos
  refine ⟨_, isPreconnected_polarBand (J := Ioo 0 (π / 3)) (ℓ := fun _ => 0) (u := fun _ => 1) isPreconnected_Ioo
    continuousOn_const continuousOn_const, ?_, ?_⟩
  · intro z hz
    obtain ⟨φ, hφ, r, h1, h2, rfl⟩ := polarBand_bounds (fun _ _ => zero_lt_one) hz
    exact sixFrag_mem_interiorPts (j := 0) h1 h2 (by simpa using hφ.1) (by simpa using hφ.2)
  · intro z ⟨h1, h2, h3⟩
    have hz0 : z ≠ 0 := by rintro rfl; simp at h2
    rw [eq_norm_mul_e_arg (x := z)]
    exact mem_polarBand (J := Ioo 0 (π / 3)) (ℓ := fun _ => 0) (u := fun _ => 1)
      (show Complex.arg z ∈ Ioo 0 (π / 3) from ⟨h2, h3⟩) (norm_pos_iff.mpr hz0) h1

/-- The upper radius of `Q_4` on the ray `φ`. -/
private noncomputable def uQ (φ : ℝ) : ℝ := min (3 / 2) (min (2 * Real.cos (φ + 5 * π / 6)) (2 * Real.cos (φ + π / 2)))

/-- The lens `Q_4` lies in a connected set of interior points. -/
private theorem sixQ_connected : ∃ C : Set ℂ, IsPreconnected C ∧ C ⊆ sixFrag.interiorPts ∧ ∀ z, sixQ z → z ∈ C := by
  have hπ := Real.pi_pos
  have hcont : ContinuousOn uQ (Ioo (-(5 * π / 6)) (-(π / 2))) := by
    unfold uQ; fun_prop
  have hlu : ∀ φ ∈ Ioo (-(5 * π / 6)) (-(π / 2)), (fun _ => (1 : ℝ)) φ < uQ φ := by
    intro φ hφ
    have c1 : 1 / 2 < Real.cos (φ + 5 * π / 6) := by
      rw [← Real.cos_pi_div_three]
      exact Real.cos_lt_cos_of_nonneg_of_le_pi (by linarith [hφ.1]) (by linarith) (by linarith [hφ.2])
    have c2 : 1 / 2 < Real.cos (φ + π / 2) := by
      rw [← Real.cos_pi_div_three, ← Real.cos_neg (φ + π / 2)]
      exact Real.cos_lt_cos_of_nonneg_of_le_pi (by linarith [hφ.2]) (by linarith) (by linarith [hφ.1])
    simp only [uQ, lt_min_iff]
    exact ⟨by norm_num, by linarith, by linarith⟩
  refine ⟨_, isPreconnected_polarBand (J := Ioo (-(5 * π / 6)) (-(π / 2))) (ℓ := fun _ => 1) (u := uQ)
    isPreconnected_Ioo continuousOn_const hcont, ?_, ?_⟩
  · intro w hw
    obtain ⟨φ, hφ, r, h1, h2, rfl⟩ := polarBand_bounds hlu hw
    simp only [uQ, lt_min_iff] at h2
    have hr : 0 < r := by linarith [show (1 : ℝ) < r from h1]
    apply sixQ_interior
    refine ⟨by rw [norm_polar hr.le]; exact h1, by rw [norm_polar hr.le]; exact h2.1, ?_, ?_, ?_, ?_⟩
    · rw [arg_polar hr ⟨by linarith [hφ.1], by linarith [hφ.2]⟩]; exact hφ.1
    · rw [arg_polar hr ⟨by linarith [hφ.1], by linarith [hφ.2]⟩]; exact hφ.2
    · rw [dist_polar_lt_one_iff hr, show φ - -(5 * π / 6) = φ + 5 * π / 6 by ring]; exact h2.2.1
    · rw [dist_polar_lt_one_iff hr, show φ - -(π / 2) = φ + π / 2 by ring]; exact h2.2.2
  · intro z ⟨h1, h2, h3, h4, h5, h6⟩
    have hz0 : z ≠ 0 := by rintro rfl; simp at h1; linarith
    have d1 := (dist_lt_one_iff_arg hz0 _).mp h5
    have d2 := (dist_lt_one_iff_arg hz0 _).mp h6
    rw [show Complex.arg z - -(5 * π / 6) = Complex.arg z + 5 * π / 6 by ring] at d1
    rw [show Complex.arg z - -(π / 2) = Complex.arg z + π / 2 by ring] at d2
    rw [eq_norm_mul_e_arg (x := z)]
    refine mem_polarBand (ℓ := fun _ => 1) ⟨h3, h4⟩ h1 ?_
    simp only [uQ, lt_min_iff]
    exact ⟨h2, d1, d2⟩

/-- The lower radius of `G_2` on the ray `φ`. -/
private noncomputable def ℓG (φ : ℝ) : ℝ := max 1 (max (2 * Real.sin φ) (2 * Real.cos (φ + 5 * π / 6)))

/-- The angles of `G_2`: an interval. -/
private theorem ordConnected_JG : (Ioo (2 * π / 3) π ∩ {φ | ℓG φ < 3 / 2}).OrdConnected := by
  have hπ := Real.pi_pos
  refine ⟨fun a ha b hb c hc => ⟨⟨by linarith [ha.1.1, hc.1], by linarith [hb.1.2, hc.2]⟩, ?_⟩⟩
  have ha' := ha.2; have hb' := hb.2
  simp only [ℓG, mem_setOf_eq, max_lt_iff] at ha' hb' ⊢
  refine ⟨by norm_num, ?_, ?_⟩
  · have : Real.sin c ≤ Real.sin a := by
      rw [← Real.sin_pi_sub c, ← Real.sin_pi_sub a]
      exact Real.sin_le_sin_of_le_of_le_pi_div_two (by linarith [hc.2, hb.1.2]) (by linarith [ha.1.1])
        (by linarith [hc.1])
    linarith [ha'.2.1]
  · have : Real.cos (c + 5 * π / 6) ≤ Real.cos (b + 5 * π / 6) := by
      rw [← Real.cos_sub_two_pi (c + 5 * π / 6), ← Real.cos_neg (c + 5 * π / 6 - 2 * π),
        ← Real.cos_sub_two_pi (b + 5 * π / 6), ← Real.cos_neg (b + 5 * π / 6 - 2 * π)]
      exact Real.cos_le_cos_of_nonneg_of_le_pi (by linarith [hb.1.2]) (by linarith [hc.1, ha.1.1])
        (by linarith [hc.2])
    linarith [hb'.2.2]

/-- The gap tile `G_2` lies in a connected set of interior points. -/
private theorem sixG_connected : ∃ C : Set ℂ, IsPreconnected C ∧ C ⊆ sixFrag.interiorPts ∧ ∀ z, sixG z → z ∈ C := by
  have hπ := Real.pi_pos
  have hcont : ContinuousOn ℓG (Ioo (2 * π / 3) π ∩ {φ | ℓG φ < 3 / 2}) := by
    unfold ℓG; fun_prop
  refine ⟨_, isPreconnected_polarBand (u := fun _ => 3 / 2) ordConnected_JG.isPreconnected hcont continuousOn_const,
    ?_, ?_⟩
  · intro w hw
    obtain ⟨φ, hφ, r, h1, h2, rfl⟩ := polarBand_bounds (J := Ioo (2 * π / 3) π ∩ {φ | ℓG φ < 3 / 2}) (ℓ := ℓG)
      (u := fun _ => 3 / 2) (fun φ hφ => show ℓG φ < 3 / 2 from hφ.2) hw
    replace h2 : r < 3 / 2 := h2
    simp only [ℓG, max_lt_iff] at h1
    have hr : 0 < r := by linarith [h1.1]
    have harg : Complex.arg ((r : ℂ) * e φ) = φ := arg_polar hr ⟨by linarith [hφ.1.1], hφ.1.2.le⟩
    have hw0 : (r : ℂ) * e φ ≠ 0 := mul_ne_zero (by exact_mod_cast hr.ne') (e_ne_zero' φ)
    apply sixG_interior
    refine ⟨by rw [norm_polar hr.le]; exact h1.1, by rw [norm_polar hr.le]; exact h2, by rw [harg]; exact hφ.1.1,
      by rw [harg]; exact hφ.1.2, ?_, ?_⟩
    · rw [one_lt_dist_iff_arg hw0, harg, norm_polar hr.le, Real.cos_sub_pi_div_two]; exact h1.2.1
    · rw [one_lt_dist_iff_arg hw0, harg, norm_polar hr.le, show φ - -(5 * π / 6) = φ + 5 * π / 6 by ring]
      exact h1.2.2
  · intro z ⟨h1, h2, h3, h4, h5, h6⟩
    have hz0 : z ≠ 0 := by rintro rfl; simp at h1; linarith
    have d1 := (one_lt_dist_iff_arg hz0 _).mp h5
    have d2 := (one_lt_dist_iff_arg hz0 _).mp h6
    rw [Real.cos_sub_pi_div_two] at d1
    rw [show Complex.arg z - -(5 * π / 6) = Complex.arg z + 5 * π / 6 by ring] at d2
    have hl : ℓG (Complex.arg z) < ‖z‖ := by
      simp only [ℓG, max_lt_iff]; exact ⟨h1, d1, d2⟩
    rw [eq_norm_mul_e_arg (x := z)]
    exact mem_polarBand (J := Ioo (2 * π / 3) π ∩ {φ | ℓG φ < 3 / 2}) (ℓ := ℓG) (u := fun _ => 3 / 2)
      (show Complex.arg z ∈ Ioo (2 * π / 3) π ∩ {φ | ℓG φ < 3 / 2} from ⟨⟨h3, h4⟩, hl.trans h2⟩) hl h2

/-- Two interior points of colour `0` less than `1` apart lie in one connected set of interior points: the pieces
`S_0`, `Q_4`, `G_2` are connected, and points of different pieces are more than `1` apart. -/
private theorem connected_of_zero {x y : ℂ} (hx : x ∈ sixFrag.interiorPts) (hy : y ∈ sixFrag.interiorPts)
    (hcx : sixCol x = 0) (hcy : sixCol y = 0) (hd : dist x y < 1) :
    ∃ C : Set ℂ, IsPreconnected C ∧ C ⊆ sixFrag.interiorPts ∧ x ∈ C ∧ y ∈ C := by
  rcases sixCol_zero_cases hx hcx with h1 | h1 | h1 <;> rcases sixCol_zero_cases hy hcy with h2 | h2 | h2
  · obtain ⟨C, hC, hCi, hS⟩ := sixS_connected; exact ⟨C, hC, hCi, hS x h1, hS y h2⟩
  · exact absurd hd (sixS_sixQ h1 h2).not_gt
  · exact absurd hd (sixS_sixG h1 h2).not_gt
  · rw [dist_comm] at hd; exact absurd hd (sixS_sixQ h2 h1).not_gt
  · obtain ⟨C, hC, hCi, hQ⟩ := sixQ_connected; exact ⟨C, hC, hCi, hQ x h1, hQ y h2⟩
  · exact absurd hd (sixQ_sixG h1 h2).not_gt
  · rw [dist_comm] at hd; exact absurd hd (sixS_sixG h2 h1).not_gt
  · rw [dist_comm] at hd; exact absurd hd (sixQ_sixG h2 h1).not_gt
  · obtain ⟨C, hC, hCi, hG⟩ := sixG_connected; exact ⟨C, hC, hCi, hG x h1, hG y h2⟩
