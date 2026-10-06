import Proofs.HadwigerNelson.Plane.ValidMap.BendGap

/-! FS131-BA3's working file (iteration only, never evidence): the helpers and the two mirrors, elaborated against `BendGap`'s olean
under primed names before they are pasted into `BendGap.lean`. Since Stage 7 the helpers are declared in `BendGap` itself, so this file
no longer elaborates against the tree (its names collide with theirs); it is kept as the record of what was elaborated first. -/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

section Gap

variable {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} {ε R' R R'' : ℝ}

/-! ### The sides of a unit circle at a point of `Γ` off the open arc (FS131-BA3; mirrors of `CollarFit.exists_one_side`, `sides_end`,
`sides_eq`) -/

/-- **Near an end the collar set lies on one side of every other unit circle** — `CollarFit.exists_one_side` stated for the set
`collarK P θ₁ θ₂ R' R''` alone, which is all its proof reads of a fit (`1/2 < R'`, `1 < R''`, an arc of at most `60°`), so that it
serves the outward collar, the same set: for `Q ≠ P` and an end `x` of the arc there is a radius within which every collar point but
`x` is inside `ω(Q)`, or every one is outside. On `ω(Q)` this is `side_core` in the end's frame (`collarK_frame`); off it, continuity
of the distance. -/
theorem collarK_one_side (hR' : 1 / 2 < R') (hR'' : 1 < R'') (hℓ : θ₂ - θ₁ ≤ π / 3) {Q x : ℂ} (hQ : Q ≠ P)
    (hx : x = ringPt P θ₁ ∨ x = ringPt P θ₂) :
    ∃ ρ > 0, (∀ z ∈ collarK P θ₁ θ₂ R' R'', z ≠ x → dist z x < ρ → dist z Q < 1) ∨
      (∀ z ∈ collarK P θ₁ θ₂ R' R'', z ≠ x → dist z x < ρ → 1 < dist z Q) := by
  rcases lt_trichotomy (dist x Q) 1 with hlt | heq | hgt
  · exact ⟨1 - dist x Q, by linarith, Or.inl fun z _ _ hz => by linarith [dist_triangle z x Q]⟩
  · -- on `ω(Q)`: the frame at the end
    obtain ⟨θE, σ, hσ, rfl, hfr⟩ : ∃ θE σ : ℝ, (σ = 1 ∨ σ = -1) ∧ x = ringPt P θE ∧
        ∀ z ∈ collarK P θ₁ θ₂ R' R'', ∃ X Y : ℝ, z - ringPt P θE = ((Y : ℂ) + (X : ℂ) * I) * e θE ∧ 0 ≤ σ * X ∧
          0 ≤ 2 * R' * Y + (X ^ 2 + Y ^ 2) ∧ 2 * R'' * Y + (X ^ 2 + Y ^ 2) ≤ 0 := by
      rcases hx with rfl | rfl
      · refine ⟨θ₁, 1, Or.inl rfl, rfl, fun z hz => ?_⟩
        obtain ⟨X, Y, h0, h1, h2, h3⟩ := (collarK_frame hR' hR'' hℓ hz).1
        exact ⟨X, Y, h0, by linarith, h2, h3⟩
      · refine ⟨θ₂, -1, Or.inr rfl, rfl, fun z hz => ?_⟩
        obtain ⟨X, Y, h0, h1, h2, h3⟩ := (collarK_frame hR' hR'' hℓ hz).2
        exact ⟨X, Y, h0, by linarith, h2, h3⟩
    set m : ℂ := ringPt P θE - Q with hm
    set g : ℂ := m * starRingEnd ℂ (e θE) with hg
    have hmn : ‖m‖ = 1 := by rw [hm, ← dist_eq_norm]; exact heq
    have hgn : Complex.normSq g = 1 := by
      rw [hg, Complex.normSq_mul, Complex.normSq_conj, Complex.normSq_eq_norm_sq, Complex.normSq_eq_norm_sq, hmn, norm_e]
      norm_num
    have hαβ : g.re ^ 2 + g.im ^ 2 = 1 := by rw [← hgn, Complex.normSq_apply]; ring
    have hmg : m = g * e θE := by
      rw [hg, mul_assoc, mul_comm (starRingEnd ℂ (e θE)), e_mul_conj_e, mul_one]
    have hne : ¬ (g.re = 1 ∧ g.im = 0) := by
      rintro ⟨h1, h2⟩
      have hg1 : g = 1 := Complex.ext (by simpa using h1) (by simpa using h2)
      apply hQ
      have : ringPt P θE - Q = e θE := by rw [← hm, hmg, hg1, one_mul]
      rw [ringPt] at this
      linear_combination -this
    obtain ⟨ρ, hρ, hcore⟩ := side_core hαβ hne hσ
    -- the distance to `Q` in the frame
    have hdist : ∀ z : ℂ, ∀ X Y : ℝ, z - ringPt P θE = ((Y : ℂ) + (X : ℂ) * I) * e θE →
        dist z Q ^ 2 = X ^ 2 + Y ^ 2 + 2 * (g.re * Y + g.im * X) + 1 ∧ dist z (ringPt P θE) ^ 2 = X ^ 2 + Y ^ 2 := by
      intro z X Y hz
      have hzQ : z - Q = ((Y : ℂ) + (X : ℂ) * I + g) * e θE := by
        rw [add_mul, ← hmg, ← hz, hm]; ring
      have hre : ((Y : ℂ) + (X : ℂ) * I + g).re = Y + g.re := by simp
      have him : ((Y : ℂ) + (X : ℂ) * I + g).im = X + g.im := by simp
      refine ⟨?_, ?_⟩
      · rw [dist_eq_norm, hzQ, norm_mul, norm_e, mul_one, ← Complex.normSq_eq_norm_sq, Complex.normSq_apply, hre, him]
        linear_combination hαβ
      · rw [dist_eq_norm, hz, norm_mul, norm_e, mul_one, ← Complex.normSq_eq_norm_sq, Complex.normSq_apply]
        simp
        ring
    have hsmall : ∀ z : ℂ, z ≠ ringPt P θE → dist z (ringPt P θE) < min 1 ρ → ∀ X Y : ℝ,
        dist z (ringPt P θE) ^ 2 = X ^ 2 + Y ^ 2 → 0 < X ^ 2 + Y ^ 2 ∧ X ^ 2 + Y ^ 2 < ρ := by
      intro z hzx hzd X Y hN
      have hd0 : 0 < dist z (ringPt P θE) := dist_pos.mpr hzx
      have hd1 : dist z (ringPt P θE) < 1 := lt_of_lt_of_le hzd (min_le_left _ _)
      have hd2 : dist z (ringPt P θE) < ρ := lt_of_lt_of_le hzd (min_le_right _ _)
      rw [← hN]
      exact ⟨by positivity, by nlinarith⟩
    refine ⟨min 1 ρ, lt_min one_pos hρ, ?_⟩
    rcases hcore with hc | hc
    · refine Or.inr fun z hzK hzx hzd => ?_
      obtain ⟨X, Y, hz, hX, h1, h2⟩ := hfr z hzK
      obtain ⟨hdQ, hdx⟩ := hdist z X Y hz
      obtain ⟨hN0, hNρ⟩ := hsmall z hzx hzd X Y hdx
      have := hc X Y R' R'' hR' hR'' hX h1 h2 hN0 hNρ
      nlinarith [dist_nonneg (x := z) (y := Q)]
    · refine Or.inl fun z hzK hzx hzd => ?_
      obtain ⟨X, Y, hz, hX, h1, h2⟩ := hfr z hzK
      obtain ⟨hdQ, hdx⟩ := hdist z X Y hz
      obtain ⟨hN0, hNρ⟩ := hsmall z hzx hzd X Y hdx
      have := hc X Y R' R'' hR' hR'' hX h1 h2 hN0 hNρ
      nlinarith [dist_nonneg (x := z) (y := Q)]
  · exact ⟨dist x Q - 1, by linarith, Or.inr fun z _ _ hz => by
      have := dist_triangle x z Q
      rw [dist_comm x z] at this
      linarith⟩

/-- The outward lens profile is at least `1` (above `1` over the open sector, `1` off it). -/
theorem CollarFitOut.one_le_outerProf (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') (θ : ℝ) : 1 ≤ outerProf θ₁ θ₂ R θ := by
  rcases hfit.pushOutProfiles.cases θ with ⟨-, -, -, h, -⟩ | ⟨-, -, h, -⟩
  · exact h.le
  · exact h.ge

/-- **The closed outward lens is closed**: `{P + t e(θ) : θ ∈ [θ₁, θ₂], 1 ≤ t ≤ outerProf θ}` (mirror of
`CollarFit.isClosed_closedLens`; the lens is on the other side of `ω(P)`). -/
theorem CollarFitOut.isClosed_closedLensOut (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    IsClosed (polarSet P (Icc θ₁ θ₂) fun θ => Icc 1 (outerProf θ₁ θ₂ R θ)) :=
  (isCompact_polarSet_Icc P continuous_const hfit.pushOutProfiles.cont_l fun θ _ => hfit.one_le_outerProf θ).isClosed

/-- The outward lens with its boundary lies in the closed outward lens. -/
theorem CollarFitOut.lensOut_subset_closedLensOut (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    lensOutSet P θ₁ θ₂ R ∪ lensOutCurve P θ₁ θ₂ R ⊆ polarSet P (Icc θ₁ θ₂) fun θ => Icc 1 (outerProf θ₁ θ₂ R θ) := by
  rintro z (⟨θ, hθ, t, ht, rfl⟩ | ⟨θ, hθ, t, ht, rfl⟩)
  · exact ⟨θ, Ioo_subset_Icc_self hθ, t, ⟨ht.1, ht.2.le⟩, rfl⟩
  · rw [mem_singleton_iff] at ht
    exact ⟨θ, hθ, t, ⟨ht ▸ hfit.one_le_outerProf θ, ht.le⟩, rfl⟩

/-- **The sides of a unit circle through an end are kept** by the outward bend (mirror of `CollarFit.sides_end`; validity is not
read): near an end the homeomorphism moves points only inside the collar, which lies on one side of `ω(Q)` for `Q ≠ P`
(`collarK_one_side`), so it moves no point across `ω(Q)`, and the closures at the end of each class met with either side are carried
to themselves. No colour is named: the lens's colour — the inner one here, the outer one for the toward bend — plays no part at an
end. -/
theorem CollarFitOut.sides_end (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {Q x : ℂ} (hQ : Q ≠ P)
    (hx : x = ringPt P θ₁ ∨ x = ringPt P θ₂) :
    hfit.map.innerColours Q x = F.innerColours Q x ∧ hfit.map.outerColours Q x = F.outerColours Q x := by
  have h12 := hfit.ring.1
  obtain ⟨ρ, hρ, hside⟩ :=
    collarK_one_side hfit.params.1 (hfit.params.2.2.1.trans hfit.params.2.2.2.1) hfit.short hQ hx
  -- the end is fixed
  have hfix : hfit.homeo x = x := by
    obtain ⟨ψ, hψ, hψ', rfl⟩ : ∃ ψ, ψ ∈ Icc θ₁ θ₂ ∧ ψ ∉ Ioo θ₁ θ₂ ∧ x = ringPt P ψ := by
      rcases hx with rfl | rfl
      · exact ⟨θ₁, ⟨le_rfl, h12.le⟩, fun h => lt_irrefl _ h.1, rfl⟩
      · exact ⟨θ₂, ⟨h12.le, le_rfl⟩, fun h => lt_irrefl _ h.2, rfl⟩
    exact hfit.homeo_fix_Γ (hfit.ring.2.1 ⟨ψ, hψ, rfl⟩) (ringPt_not_mem_openArc hfit.short hψ hψ')
  -- a ball about the end whose image stays within `ρ` of it
  obtain ⟨δ, hδ, hδb⟩ := Metric.continuousAt_iff.mp hfit.homeo.continuous.continuousAt ρ hρ
  rw [hfix] at hδb
  set ρ' := min δ ρ with hρ'
  have hρ'0 : 0 < ρ' := lt_min hδ hρ
  -- on that ball the homeomorphism moves no point across `ω(Q)`
  have hiff : ∀ z ∈ ball x ρ', (dist (hfit.homeo z) Q < 1 ↔ dist z Q < 1) ∧ (dist (hfit.homeo z) Q ≤ 1 ↔ dist z Q ≤ 1) := by
    intro z hz
    by_cases hzK : z ∈ collarK P θ₁ θ₂ R' R''
    · by_cases hzx : z = x
      · rw [hzx, hfix]
        exact ⟨Iff.rfl, Iff.rfl⟩
      · have h1 : dist z x < ρ := lt_of_lt_of_le (mem_ball.mp hz) (min_le_right _ _)
        have h2 : dist (hfit.homeo z) x < ρ := hδb (lt_of_lt_of_le (mem_ball.mp hz) (min_le_left _ _))
        have hne : hfit.homeo z ≠ x := fun h => hzx (hfit.homeo.injective (h.trans hfix.symm))
        rcases hside with hs | hs
        · have a1 := hs z hzK hzx h1
          have a2 := hs _ (hfit.homeo_maps_collar hzK) hne h2
          exact ⟨iff_of_true a2 a1, iff_of_true a2.le a1.le⟩
        · have a1 := hs z hzK hzx h1
          have a2 := hs _ (hfit.homeo_maps_collar hzK) hne h2
          exact ⟨iff_of_false (not_lt.mpr a2.le) (not_lt.mpr a1.le), iff_of_false (not_le.mpr a2) (not_le.mpr a1)⟩
    · rw [(hfit.homeo_eq_self hzK).1]
      exact ⟨Iff.rfl, Iff.rfl⟩
  -- the closures at the end, of a class met with a set the homeomorphism respects near the end
  have key : ∀ S : Set ℂ, (∀ z ∈ ball x ρ', (hfit.homeo z ∈ S ↔ z ∈ S)) → ∀ d : Fin k,
      x ∈ closure (hfit.map.region d ∩ S) ↔ x ∈ closure (F.region d ∩ S) := by
    intro S hS d
    have hreg : hfit.map.region d = hfit.homeo '' F.region d := pushforward_region d
    have hWo : IsOpen (hfit.homeo '' ball x ρ') := hfit.homeo.isOpenMap _ isOpen_ball
    have hxW : x ∈ hfit.homeo '' ball x ρ' := ⟨x, mem_ball_self hρ'0, hfix⟩
    have himg : hfit.homeo '' ball x ρ' ∩ (hfit.homeo '' F.region d ∩ S) = hfit.homeo '' (ball x ρ' ∩ (F.region d ∩ S)) := by
      ext y
      constructor
      · rintro ⟨⟨z, hzW, rfl⟩, ⟨z', hz', hzz⟩, hyS⟩
        obtain rfl := hfit.homeo.injective hzz
        exact ⟨z', ⟨hzW, hz', (hS z' hzW).mp hyS⟩, rfl⟩
      · rintro ⟨z, ⟨hzW, hzr, hzS⟩, rfl⟩
        exact ⟨⟨z, hzW, rfl⟩, ⟨z, hzr, rfl⟩, (hS z hzW).mpr hzS⟩
    have hloc : x ∈ closure (hfit.homeo '' F.region d ∩ S) ↔
        x ∈ closure (hfit.homeo '' ball x ρ' ∩ (hfit.homeo '' F.region d ∩ S)) :=
      ⟨fun h => hWo.inter_closure ⟨hxW, h⟩, fun h => closure_mono inter_subset_right h⟩
    rw [hreg, hloc, himg, ← hfit.homeo.image_closure]
    constructor
    · rintro ⟨y, hy, hyx⟩
      have hyx' : y = x := hfit.homeo.injective (hyx.trans hfix.symm)
      rw [hyx'] at hy
      exact closure_mono inter_subset_right hy
    · intro h
      exact ⟨x, isOpen_ball.inter_closure ⟨mem_ball_self hρ'0, h⟩, hfix⟩
  refine ⟨Set.ext fun d => ?_, Set.ext fun d => ?_⟩
  · exact key (ball Q 1) (fun z hz => by simp only [mem_ball]; exact (hiff z hz).1) d
  · show x ∈ closure (hfit.map.region d \ closedBall Q 1) ↔ x ∈ closure (F.region d \ closedBall Q 1)
    rw [sdiff_eq, sdiff_eq]
    exact key (closedBall Q 1)ᶜ (fun z hz => by
      simp only [mem_compl_iff, mem_closedBall]; exact not_congr (hiff z hz).2) d

/-- **The sides at a point of `F.Γ` off the open arc are kept** by the outward bend (mirror of `CollarFit.sides_eq`; the common step
of R1 and R2): off the closed outward lens the two maps agree near the point (`map_agreesOff`, closures being local); on it, such a
point is an end of the arc — over the open sector the lens off `ω(P)` lies in the **outer** collar, interior in `F` (`kout_subset`;
the toward bend's lens lies in the inner collar) — where `sides_end` applies for a centre other than `P`. -/
theorem CollarFitOut.sides_eq (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {Q x : ℂ} (hxΓ : x ∈ F.Γ)
    (hxO : x ∉ ringPt P '' Ioo θ₁ θ₂) (hQ : (x = ringPt P θ₁ ∨ x = ringPt P θ₂) → Q ≠ P) :
    hfit.map.innerColours Q x = F.innerColours Q x ∧ hfit.map.outerColours Q x = F.outerColours Q x := by
  have hp := hfit.pushOutProfiles
  by_cases hxV : x ∈ polarSet P (Icc θ₁ θ₂) fun θ => Icc 1 (outerProf θ₁ θ₂ R θ)
  · obtain ⟨ψ, hψ, t, ht, hxe⟩ := hxV
    by_cases hψ' : ψ ∈ Ioo θ₁ θ₂
    · exfalso
      rcases eq_or_lt_of_le ht.1 with ht1 | ht1
      · subst ht1
        exact hxO ⟨ψ, hψ', by rw [hxe]; simp [ringPt]⟩
      · exact (hfit.kout_subset ⟨ψ, hψ', t, ⟨ht1, ht.2.trans (hp.inside ψ hψ').2.2.2.le⟩, hxe⟩).1.2 hxΓ.2
    · have ht1 : t = 1 := le_antisymm ((hp.off ψ hψ').2.1 ▸ ht.2) ht.1
      have hxe' : x = ringPt P ψ := by rw [hxe, ht1]; simp [ringPt]
      have hend : x = ringPt P θ₁ ∨ x = ringPt P θ₂ := by
        rcases eq_or_lt_of_le hψ.1 with h1 | h1
        · exact Or.inl (hxe'.trans (by rw [h1]))
        · exact Or.inr (hxe'.trans (by rw [le_antisymm hψ.2 (not_lt.mp fun h2 => hψ' ⟨h1, h2⟩)]))
      exact hfit.sides_end (hQ hend) hend
  · have hO : IsOpen (polarSet P (Icc θ₁ θ₂) fun θ => Icc 1 (outerProf θ₁ θ₂ R θ))ᶜ := hfit.isClosed_closedLensOut.isOpen_compl
    have hag : ∀ z ∈ (polarSet P (Icc θ₁ θ₂) fun θ => Icc 1 (outerProf θ₁ θ₂ R θ))ᶜ,
        (z ∈ hfit.map.interiorPts ↔ z ∈ F.interiorPts) ∧ hfit.map.col z = F.col z :=
      fun z hz => ⟨(hfit.map_agreesOff.2 z fun hzU => hz (hfit.lensOut_subset_closedLensOut hzU)).1.symm,
        (hfit.map_agreesOff.2 z fun hzU => hz (hfit.lensOut_subset_closedLensOut hzU)).2.symm⟩
    have hloc := fun j S => mem_closure_region_inter_iff_of_agree hO hxV (fun z hz => (hag z hz).1)
      (fun z hz => (hag z hz).2) j S
    refine ⟨Set.ext fun j => hloc j (ball Q 1), Set.ext fun j => ?_⟩
    show x ∈ closure (hfit.map.region j \ closedBall Q 1) ↔ x ∈ closure (F.region j \ closedBall Q 1)
    rw [sdiff_eq, sdiff_eq]
    exact hloc j (closedBall Q 1)ᶜ

/-- **The open arc is interior in the outward bent map** (`map_lens` at `t = 1`: the lens with the open arc takes the inner colour),
so off its `Γ`. -/
theorem CollarFitOut.ringPt_notMem_map_Γ (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {ψ : ℝ} (hψ : ψ ∈ Ioo θ₁ θ₂) :
    ringPt P ψ ∉ hfit.map.Γ := fun hΓ =>
  (hfit.map_lens ⟨ψ, hψ, 1, ⟨le_rfl, (hfit.pushOutProfiles.inside ψ hψ).2.2.1⟩, by simp [ringPt]⟩).1.2 hΓ.2

theorem CollarFitOut.map_R1' (hF : F.Valid) (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {Q : ℂ} {a b : ℝ} {d d' : Fin k}
    (h : hfit.map.IsRingArc Q a b d d') : F.IsRingArc Q a b d d' := by
  -- validity is not read: the clause is geometry of `Γ` and of the homeomorphism (reported: FS131-BA3's record)
  have _ := hF
  obtain ⟨hab, hsub, hsides⟩ := h
  obtain ⟨-, -, hR1, -, -⟩ := hfit.params
  have hR : 0 < R := by linarith
  have h12 := hfit.ring.1
  -- the closed arc lies in `F.Γ`: it meets the two lens arcs (radius `R ≠ 1`) finitely, and off them `M.Γ ⊆ F.Γ`
  have hfinA : ∀ a' ∈ ({collarOutArcA P θ₁ θ₂ R, collarOutArcB P θ₁ θ₂ R} : Set Arc), (a'.carrier ∩ sphere Q 1).Finite := by
    intro a' ha'
    rcases a'.finite_inter_sphere_or_eq_circ (hfit.collarOutArcs_nondegenerate a' (Or.inr ha')) Q with h | ⟨θa, θb, he⟩
    · exact h
    · exfalso
      have hu : a'.IsUnitArc := by rw [he]; rfl
      rcases ha' with rfl | rfl
      · unfold collarOutArcA at hu
        rw [germArc_isUnitArc_iff, abs_of_pos (by positivity), div_eq_one_iff_eq hR.ne'] at hu
        linarith
      · unfold collarOutArcB at hu
        rw [germArc_isUnitArc_iff, abs_neg, abs_of_pos (by positivity), div_eq_one_iff_eq hR.ne'] at hu
        linarith
  have hC : (((collarOutArcA P θ₁ θ₂ R).carrier ∪ (collarOutArcB P θ₁ θ₂ R).carrier) ∩ sphere Q 1).Finite := by
    rw [union_inter_distrib_right]
    exact (hfinA _ (Or.inl rfl)).union (hfinA _ (Or.inr rfl))
  have hΓF : ringArc Q a b ⊆ F.Γ := by
    refine F.ringArc_subset_Γ_of_finite hab (fun y hy => (hsub hy).1) hC ?_
    rintro y ⟨hy, hyC⟩
    have hyM := hsub hy
    rw [hfit.map_Γ] at hyM
    rcases hyM with ⟨hyΓ, -⟩ | hyL
    · exact hyΓ
    · refine absurd ⟨?_, ?_⟩ hyC
      · rw [collarOutArcs_carrier hR1 h12 hfit.short]; exact hyL
      · obtain ⟨θ, -, rfl⟩ := hy; exact ringPt_mem_sphere _ _
  refine ⟨hab, hΓF, fun θ hθ => ?_⟩
  have hxM : ringPt Q θ ∈ hfit.map.Γ := hsub ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩
  -- the point is off the open arc, which is interior in the bent map
  have hxO : ringPt Q θ ∉ ringPt P '' Ioo θ₁ θ₂ := by
    rintro ⟨ψ, hψ, hψe⟩
    exact hfit.ringPt_notMem_map_Γ hψ (hψe ▸ hxM)
  -- `Q ≠ P` at an end: an arc of `ω(P)` in the bent map's `Γ` through an end would continue into the open arc
  have hQ : (ringPt Q θ = ringPt P θ₁ ∨ ringPt Q θ = ringPt P θ₂) → Q ≠ P := by
    rintro hend rfl
    rcases hend with hxe | hxe
    · have he : e θ = e θ₁ := add_left_cancel hxe
      set s := min ((b - θ) / 2) ((θ₂ - θ₁) / 2) with hs
      have hs0 : 0 < s := lt_min (by linarith [hθ.2]) (by linarith)
      have hs1 : s < b - θ := lt_of_le_of_lt (min_le_left _ _) (by linarith [hθ.2])
      have hs2 : s < θ₂ - θ₁ := lt_of_le_of_lt (min_le_right _ _) (by linarith)
      have hmem := hsub ⟨θ + s, ⟨by linarith [hθ.1], by linarith⟩, rfl⟩
      have hpt : ringPt Q (θ + s) = ringPt Q (θ₁ + s) := by simp only [ringPt, e_add, he]
      rw [hpt] at hmem
      exact hfit.ringPt_notMem_map_Γ ⟨by linarith, by linarith⟩ hmem
    · have he : e θ = e θ₂ := add_left_cancel hxe
      set s := min ((θ - a) / 2) ((θ₂ - θ₁) / 2) with hs
      have hs0 : 0 < s := lt_min (by linarith [hθ.1]) (by linarith)
      have hs1 : s < θ - a := lt_of_le_of_lt (min_le_left _ _) (by linarith [hθ.1])
      have hs2 : s < θ₂ - θ₁ := lt_of_le_of_lt (min_le_right _ _) (by linarith)
      have hmem := hsub ⟨θ - s, ⟨by linarith, by linarith [hθ.2]⟩, rfl⟩
      have hpt : ringPt Q (θ - s) = ringPt Q (θ₂ - s) := by simp only [ringPt, sub_eq_add_neg, e_add, he]
      rw [hpt] at hmem
      exact hfit.ringPt_notMem_map_Γ ⟨by linarith, by linarith⟩ hmem
  obtain ⟨hin, hout⟩ := hfit.sides_eq (hΓF ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩) hxO hQ
  obtain ⟨hMin, hMout⟩ := hsides θ hθ
  exact ⟨hin ▸ hMin, hout ▸ hMout⟩

theorem CollarFitOut.map_R2' (hF : F.Valid) (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {Q : ℂ} {a b : ℝ} {d d' : Fin k}
    (h : F.IsRingArc Q a b d d') (hd : Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂)) :
    hfit.map.IsRingArc Q a b d d' := by
  -- validity is not read: the clause is geometry of `Γ` and of the homeomorphism (reported: FS131-BA3's record)
  have _ := hF
  obtain ⟨hab, hsub, hsides⟩ := h
  have h12 := hfit.ring.1
  -- no point of the closed arc lies on `α°`: near such a point `Γ` is `ω(P)` (`free_open`), whose points there are on `α°`, and the
  -- open arc of `ω(Q)` reaches it
  have hoff : ∀ θ ∈ Icc a b, ringPt Q θ ∉ ringPt P '' Ioo θ₁ θ₂ := by
    intro θ hθ hmem
    obtain ⟨ψ, hψ, hψe⟩ := hmem
    obtain ⟨r₁, hr₁, hfr⟩ := hfit.free_open ψ hψ
    obtain ⟨r₃, hr₃, hsph⟩ := exists_sphere_inter_ball_subset_openArc (p := P) hψ
    have hr : 0 < min r₁ r₃ := lt_min hr₁ hr₃
    obtain ⟨θ', hθ', hd'⟩ : ∃ θ' ∈ Ioo a b, dist (ringPt Q θ') (ringPt Q θ) < min r₁ r₃ := by
      have hba : 0 < b - a := by linarith
      set t := min 1 (min r₁ r₃ / (b - a)) with ht
      have ht0 : 0 < t := lt_min one_pos (div_pos hr hba)
      have ht1 : t ≤ 1 := min_le_left _ _
      have htr : t * (b - a) ≤ min r₁ r₃ := by
        have := min_le_right 1 (min r₁ r₃ / (b - a))
        rw [le_div_iff₀ hba] at this
        linarith
      refine ⟨θ + t * ((a + b) / 2 - θ), ⟨?_, ?_⟩, ?_⟩
      · nlinarith [mul_pos ht0 hba, mul_nonneg (sub_nonneg.mpr ht1) (sub_nonneg.mpr hθ.1)]
      · nlinarith [mul_pos ht0 hba, mul_nonneg (sub_nonneg.mpr ht1) (sub_nonneg.mpr hθ.2)]
      · refine lt_of_le_of_lt (dist_ringPt_ringPt_le Q _ _) ?_
        rw [show θ + t * ((a + b) / 2 - θ) - θ = t * ((a + b) / 2 - θ) by ring, abs_mul, abs_of_pos ht0]
        have : |(a + b) / 2 - θ| ≤ (b - a) / 2 := abs_le.mpr ⟨by linarith [hθ.2], by linarith [hθ.1]⟩
        nlinarith
    have hz : ringPt Q θ' ∈ F.Γ := hsub ⟨θ', Ioo_subset_Icc_self hθ', rfl⟩
    rw [← hψe] at hd'
    have h1 : ringPt Q θ' ∈ sphere P 1 := hfr ⟨hz, lt_of_lt_of_le hd' (min_le_left _ _)⟩
    exact disjoint_left.mp hd ⟨θ', hθ', rfl⟩ (hsph ⟨h1, lt_of_lt_of_le hd' (min_le_right _ _)⟩)
  refine ⟨hab, fun y ⟨θ, hθ, hy⟩ => ?_, fun θ hθ => ?_⟩
  · rw [hfit.map_Γ, ← hy]
    exact Or.inl ⟨hsub ⟨θ, hθ, rfl⟩, hoff θ hθ⟩
  · -- the sides: `sides_eq`, with `Q ≠ P` at an end (an arc of `ω(P)` through an end continues into `α°`)
    have hQ : (ringPt Q θ = ringPt P θ₁ ∨ ringPt Q θ = ringPt P θ₂) → Q ≠ P := by
      rintro hend rfl
      rcases hend with hxe | hxe
      · have he : e θ = e θ₁ := add_left_cancel hxe
        set s := min ((b - θ) / 2) ((θ₂ - θ₁) / 2) with hs
        have hs0 : 0 < s := lt_min (by linarith [hθ.2]) (by linarith)
        have hs1 : s < b - θ := lt_of_le_of_lt (min_le_left _ _) (by linarith [hθ.2])
        have hs2 : s < θ₂ - θ₁ := lt_of_le_of_lt (min_le_right _ _) (by linarith)
        have hpt : ringPt Q (θ + s) = ringPt Q (θ₁ + s) := by simp only [ringPt, e_add, he]
        exact disjoint_left.mp hd ⟨θ + s, ⟨by linarith [hθ.1], by linarith⟩, rfl⟩
          ⟨θ₁ + s, ⟨by linarith, by linarith⟩, hpt.symm⟩
      · have he : e θ = e θ₂ := add_left_cancel hxe
        set s := min ((θ - a) / 2) ((θ₂ - θ₁) / 2) with hs
        have hs0 : 0 < s := lt_min (by linarith [hθ.1]) (by linarith)
        have hs1 : s < θ - a := lt_of_le_of_lt (min_le_left _ _) (by linarith [hθ.1])
        have hs2 : s < θ₂ - θ₁ := lt_of_le_of_lt (min_le_right _ _) (by linarith)
        have hpt : ringPt Q (θ - s) = ringPt Q (θ₂ - s) := by simp only [ringPt, sub_eq_add_neg, e_add, he]
        exact disjoint_left.mp hd ⟨θ - s, ⟨by linarith, by linarith [hθ.2]⟩, rfl⟩
          ⟨θ₂ - s, ⟨by linarith, by linarith⟩, hpt.symm⟩
    obtain ⟨hin, hout⟩ := hfit.sides_eq (hsub ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩) (hoff θ (Ioo_subset_Icc_self hθ)) hQ
    rw [hin, hout]
    exact hsides θ hθ

end Gap

end ArcMap

end HadwigerNelson.Plane
