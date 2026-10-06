import Proofs.HadwigerNelson.Plane.ValidMap.BaseWalk

/-! Scratch for FS131-I5q: `exists_preBend`'s three children, iterated upstream of `BaseDense` (whose olean waits on the build).
The declarations marked COPY are `BaseDense`'s, restated here (their proofs are in the library). -/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

-- COPY
def maxRingArcs (F : ArcMap k) (u : ℂ) : Set (Set ℂ) :=
  {S | ∃ P ∈ closedBall u 1, ∃ θ₁ θ₂ c c', F.IsRingArc P θ₁ θ₂ c c' ∧ S = ringArc P θ₁ θ₂ ∧
    ∀ θ₁' θ₂', ringArc P θ₁ θ₂ ⊆ ringArc P θ₁' θ₂' → F.IsRingArc P θ₁' θ₂' c c' → ringArc P θ₁' θ₂' = ringArc P θ₁ θ₂}

-- COPY
theorem IsRingArc.shift {P : ℂ} {s t : ℝ} {c c' : Fin k} (hA : F.IsRingArc P s t c c') (n : ℤ) :
    F.IsRingArc P (s + 2 * π * n) (t + 2 * π * n) c c' := by
  refine ⟨by linarith [hA.1], by rw [ringArc_add_two_pi_mul]; exact hA.2.1, fun θ hθ => ?_⟩
  have h := hA.2.2 (θ - 2 * π * n) ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
  have hr : ringPt P (θ - 2 * π * n) = ringPt P θ := by
    rw [show θ - 2 * π * n = θ + 2 * π * ((-n : ℤ) : ℝ) by push_cast; ring, ringPt_add_int_mul]
  rwa [hr] at h

-- COPY (proof in the library)
theorem exists_maxRingArc (hF : F.Valid) {u P : ℂ} (hu : F.Covers u 2) (hP : P ∈ closedBall u 1) {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hA : F.IsRingArc P θ₁ θ₂ c c') :
    ∃ a b, ringArc P θ₁ θ₂ ⊆ ringArc P a b ∧ F.IsRingArc P a b c c' ∧
      ∀ θ₁' θ₂', ringArc P a b ⊆ ringArc P θ₁' θ₂' → F.IsRingArc P θ₁' θ₂' c c' → ringArc P θ₁' θ₂' = ringArc P a b := by
  sorry

-- COPY (proof in the library)
theorem ncard_coloursAt_le_two_of_mem_openArc {P : ℂ} {θ₁ θ₂ θ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hθ : θ ∈ Ioo θ₁ θ₂) : (F.coloursAt (ringPt P θ)).ncard ≤ 2 := by
  sorry

/-! ## New: helpers -/

/-- Ring points at angles less than a turn apart differ. -/
theorem ringPt_ne_of_abs_sub_lt (p : ℂ) {s t : ℝ} (h0 : s ≠ t) (h : |s - t| < 2 * π) : ringPt p s ≠ ringPt p t := by
  intro he
  have he' : e s = e t := by simpa [ringPt] using he
  obtain ⟨n, hn⟩ := e_eq_e_iff.mp he'
  have hπ := Real.pi_pos
  have h1 : |(n : ℝ)| * (2 * π) < 2 * π := by
    have : s - t = n * (2 * π) := by linarith
    rw [this, abs_mul, abs_of_pos (by positivity : 0 < 2 * π)] at h
    exact h
  have hn0 : n = 0 := by
    by_contra hne
    have : (1 : ℝ) ≤ |(n : ℝ)| := by
      have : (1 : ℤ) ≤ |n| := Int.one_le_abs hne
      exact_mod_cast this
    nlinarith
  rw [hn0] at hn
  exact h0 (by simpa using hn)

/-- A closed sub-arc of positive length of a unit circle has a point off any finite set. -/
theorem exists_mem_ringArc_notMem (p : ℂ) {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) {C : Set ℂ} (hC : C.Finite) :
    ∃ y ∈ ringArc p θ₁ θ₂, y ∉ C := by
  have h := mem_closure_ringArc_diff_finite h12 hC (y := ringPt p θ₁) ⟨θ₁, ⟨le_rfl, h12.le⟩, rfl⟩
  obtain ⟨y, hy⟩ := closure_nonempty_iff.mp ⟨_, h⟩
  exact ⟨y, hy.1, hy.2⟩

/-- **A unit circle is fixed by any of its arcs of positive length**: an arc of `ω(Q)` inside `ω(P)` has `Q = P`. -/
theorem eq_of_ringArc_subset_sphere {Q P : ℂ} {s t : ℝ} (hst : s < t) (h : ringArc Q s t ⊆ sphere P 1) : Q = P := by
  have hπ := Real.pi_pos
  set t' := min t (s + 1) with ht'
  have hst' : s < t' := lt_min hst (by linarith)
  have hnd : (Arc.circ Q 1 s t').Nondegenerate := ⟨one_pos, hst', (min_le_right _ _).trans (by linarith [Real.pi_gt_three])⟩
  have hcar : (Arc.circ Q 1 s t').carrier = ringArc Q s t' := by
    simp [Arc.carrier, ringArc, ringPt]
  rcases Arc.finite_inter_sphere_or_eq_circ _ hnd P with hfin | ⟨θ₀, θ₁, heq⟩
  · exfalso
    obtain ⟨y, hy, hyC⟩ := exists_mem_ringArc_notMem Q hst' hfin
    refine hyC ⟨hcar ▸ hy, h ?_⟩
    obtain ⟨θ, hθ, rfl⟩ := hy
    exact ⟨θ, ⟨hθ.1, hθ.2.trans (min_le_left _ _)⟩, rfl⟩
  · exact (Arc.circ.inj heq).1

/-- Two arcs of one unit circle with constant sides that share an interior point have the same sides. -/
theorem IsRingArc.sides_eq_of_ringPt_eq {p : ℂ} {a b a' b' : ℝ} {c c' d d' : Fin k} (h : F.IsRingArc p a b c c')
    (h' : F.IsRingArc p a' b' d d') {t t' : ℝ} (ht : t ∈ Ioo a b) (ht' : t' ∈ Ioo a' b') (he : ringPt p t = ringPt p t') :
    c = d ∧ c' = d' := by
  have h1 := h.2.2 t ht
  have h2 := h'.2.2 t' ht'
  rw [he] at h1
  exact ⟨singleton_eq_singleton_iff.mp (h1.1.symm.trans h2.1), singleton_eq_singleton_iff.mp (h1.2.symm.trans h2.2)⟩

/-- Two arcs of one unit circle with the same constant sides whose parameter intervals overlap join into one. -/
theorem IsRingArc.union_of_overlap {p : ℂ} {a b a' b' : ℝ} {c c' : Fin k} (h : F.IsRingArc p a b c c')
    (h' : F.IsRingArc p a' b' c c') (hov : max a a' < min b b') : F.IsRingArc p (min a a') (max b b') c c' := by
  obtain ⟨⟨h1, h3⟩, h2, h4⟩ : (a < b ∧ a' < b) ∧ a < b' ∧ a' < b' := by
    simpa only [max_lt_iff, lt_min_iff] using hov
  refine ⟨lt_of_le_of_lt (min_le_left _ _) (lt_of_lt_of_le h1 (le_max_left _ _)), ?_, fun θ hθ => ?_⟩
  · rintro _ ⟨θ, hθ, rfl⟩
    have hl := min_le_iff.mp hθ.1
    have hr := le_max_iff.mp hθ.2
    by_cases hin : θ ∈ Icc a b
    · exact h.2.1 ⟨θ, hin, rfl⟩
    · refine h'.2.1 ⟨θ, ?_, rfl⟩
      rw [mem_Icc, not_and_or, not_le, not_le] at hin
      rcases hin with hin | hin
      · exact ⟨by rcases hl with hl | hl <;> [linarith; exact hl], by linarith⟩
      · exact ⟨by linarith, by rcases hr with hr | hr <;> [linarith; exact hr]⟩
  · have hl := min_lt_iff.mp hθ.1
    have hr := lt_max_iff.mp hθ.2
    by_cases hin : θ ∈ Ioo a b
    · exact h.2.2 θ hin
    · refine h'.2.2 θ ?_
      rw [mem_Ioo, not_and_or, not_lt, not_lt] at hin
      rcases hin with hin | hin
      · exact ⟨by rcases hl with hl | hl <;> [linarith; exact hl], by linarith⟩
      · exact ⟨by linarith, by rcases hr with hr | hr <;> [linarith; exact hr]⟩

/-- **The ends of a maximal arc are irregular angles**: at a regular end the arc would continue past it with the same sides
(`RegularAt`, `IsRingArc.union_of_overlap`), and an arc of at most `60°` (`l60_le`) is not the set of a longer one. -/
theorem IsRingArc.not_regularAt_of_max (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hmax : ∀ θ₁' θ₂', ringArc P θ₁ θ₂ ⊆ ringArc P θ₁' θ₂' → F.IsRingArc P θ₁' θ₂' c c' →
      ringArc P θ₁' θ₂' = ringArc P θ₁ θ₂) :
    ¬ F.RegularAt P θ₁ ∧ ¬ F.RegularAt P θ₂ := by
  have hπ := Real.pi_pos
  have h12 : θ₁ < θ₂ := hA.1
  -- a regular angle of the closed arc is interior to an arc with the same sides, and the union is the arc itself
  have key : ∀ θ ∈ Icc θ₁ θ₂, F.RegularAt P θ → ∃ a b, a < θ ∧ θ < b ∧ F.IsRingArc P (min θ₁ a) (max θ₂ b) c c' ∧
      ringArc P (min θ₁ a) (max θ₂ b) = ringArc P θ₁ θ₂ := by
    rintro θ hθ (hΓ | ⟨φ₁, φ₂, d, d', hD, φ, hφ, heφ⟩)
    · exact absurd (hA.2.1 ⟨θ, hθ, rfl⟩) hΓ
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp heφ
    have hD' := hD.shift (-n)
    set a := φ₁ + 2 * π * ((-n : ℤ) : ℝ) with ha
    set b := φ₂ + 2 * π * ((-n : ℤ) : ℝ) with hb
    have haθ : a < θ := by rw [ha]; push_cast; linarith [hφ.1]
    have hθb : θ < b := by rw [hb]; push_cast; linarith [hφ.2]
    have hov : max θ₁ a < min θ₂ b := by
      rw [max_lt_iff, lt_min_iff, lt_min_iff]
      exact ⟨⟨h12, lt_of_le_of_lt hθ.1 hθb⟩, lt_of_lt_of_le haθ hθ.2, haθ.trans hθb⟩
    obtain ⟨t, ht, ht'⟩ : ∃ t, t ∈ Ioo θ₁ θ₂ ∧ t ∈ Ioo a b := by
      refine ⟨(max θ₁ a + min θ₂ b) / 2, ⟨?_, ?_⟩, ⟨?_, ?_⟩⟩ <;>
        linarith [le_max_left θ₁ a, le_max_right θ₁ a, min_le_left θ₂ b, min_le_right θ₂ b]
    obtain ⟨rfl, rfl⟩ := hA.sides_eq_of_ringPt_eq hD' ht ht' rfl
    have hU := hA.union_of_overlap hD' hov
    refine ⟨a, b, haθ, hθb, hU, hmax _ _ ?_ hU⟩
    rintro _ ⟨ψ, hψ, rfl⟩
    exact ⟨ψ, ⟨(min_le_left _ _).trans hψ.1, hψ.2.trans (le_max_left _ _)⟩, rfl⟩
  constructor
  · intro hreg
    obtain ⟨a, b, haθ, hθb, hU, heq⟩ := key θ₁ ⟨le_rfl, h12.le⟩ hreg
    have hl := l60_le hF hU
    have hmem : ringPt P (min θ₁ a) ∈ ringArc P θ₁ θ₂ := by
      rw [← heq]; exact ⟨_, ⟨le_rfl, hU.1.le⟩, rfl⟩
    obtain ⟨ψ, hψ, hψe⟩ := hmem
    have hmin : min θ₁ a = a := min_eq_right haθ.le
    refine ringPt_ne_of_abs_sub_lt P (s := ψ) (t := min θ₁ a) (by rw [hmin]; linarith [hψ.1]) ?_ hψe
    rw [abs_of_pos (by rw [hmin]; linarith [hψ.1])]
    linarith [hψ.2, le_max_left θ₂ b]
  · intro hreg
    obtain ⟨a, b, haθ, hθb, hU, heq⟩ := key θ₂ ⟨h12.le, le_rfl⟩ hreg
    have hl := l60_le hF hU
    have hmem : ringPt P (max θ₂ b) ∈ ringArc P θ₁ θ₂ := by
      rw [← heq]; exact ⟨_, ⟨hU.1.le, le_rfl⟩, rfl⟩
    obtain ⟨ψ, hψ, hψe⟩ := hmem
    have hmaxb : max θ₂ b = b := max_eq_right hθb.le
    refine ringPt_ne_of_abs_sub_lt P (s := max θ₂ b) (t := ψ) (by rw [hmaxb]; linarith [hψ.2]) ?_ hψe.symm
    rw [abs_of_pos (by rw [hmaxb]; linarith [hψ.2])]
    linarith [hψ.1, min_le_left θ₁ a]

/-- **Finitely many arcs meet a compact part of the domain** (local finiteness and compactness). -/
theorem finite_arcs_meeting_compact (F : ArcMap k) {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ F.dom) :
    {a | a ∈ F.arcs ∧ (a.carrier ∩ K).Nonempty}.Finite := by
  choose! t ht hfin using F.locallyFinite
  obtain ⟨S, hSK, hcov⟩ := hK.elim_nhds_subcover t fun y hy => ht y (hKd hy)
  refine (S.finite_toSet.biUnion fun y hy => hfin y (hKd (hSK y hy))).subset ?_
  rintro a ⟨ha, z, hza, hzK⟩
  obtain ⟨y, hyS, hzy⟩ := mem_iUnion₂.mp (hcov hzK)
  exact mem_iUnion₂.mpr ⟨y, hyS, ha, z, hza, hzy⟩

/-! ## The three children -/

theorem finite_maxRingArcs (hF : F.Valid) {u : ℂ} (hu : F.Covers u 2) : (F.maxRingArcs u).Finite := by
  have hπ := Real.pi_pos
  -- the arcs meeting `B̄(u, 2)`, and the centres of the unit circles among them
  set 𝒜 : Set Arc := {a | a ∈ F.arcs ∧ (a.carrier ∩ closedBall u 2).Nonempty} with h𝒜def
  have h𝒜 : 𝒜.Finite := F.finite_arcs_meeting_compact (isCompact_closedBall u 2) hu
  set 𝒞 : Set ℂ := ⋃ a ∈ 𝒜, {v | ∃ θ₀ θ₁, a = Arc.circ v 1 θ₀ θ₁} with h𝒞def
  have h𝒞 : 𝒞.Finite := by
    refine h𝒜.biUnion fun a _ => Set.Subsingleton.finite ?_
    rintro v ⟨θ₀, θ₁, rfl⟩ w ⟨θ₀', θ₁', h⟩
    exact (Arc.circ.inj h).1
  -- the irregular angles of each centre's ring
  set Z : ℂ → Set ℝ := fun P => {θ | θ ∈ Icc 0 (4 * π) ∧ ¬ F.RegularAt P θ} with hZdef
  have hcov : ∀ P ∈ closedBall u 1, F.Covers P 1 := by
    intro P hP z hz
    apply hu
    rw [mem_closedBall] at hP hz ⊢
    linarith [dist_triangle z P u]
  have hZ : ∀ P ∈ closedBall u 1, (Z P).Finite := fun P hP => finite_not_regular (hcov P hP) (4 * π)
  refine ((h𝒞.inter_of_left (closedBall u 1)).biUnion fun P hP =>
    ((hZ P hP.2).prod (hZ P hP.2)).image fun q : ℝ × ℝ => ringArc P q.1 q.2).subset ?_
  rintro S ⟨P, hP, θ₁, θ₂, c, c', hA, rfl, hmax⟩
  have h12 := hA.1
  -- the centre is one of the circles' centres
  have hP𝒞 : P ∈ 𝒞 := by
    by_contra hno
    simp only [h𝒞def, mem_iUnion, not_exists] at hno
    have hC : (⋃ a ∈ 𝒜, a.carrier ∩ sphere P 1).Finite := by
      refine h𝒜.biUnion fun a ha => ?_
      rcases Arc.finite_inter_sphere_or_eq_circ a (F.nondegenerate a ha.1) P with h | ⟨θ₀, θ₁', rfl⟩
      · exact h
      · exact absurd ⟨θ₀, θ₁', rfl⟩ (hno _ ha)
    obtain ⟨y, hy, hyC⟩ := exists_mem_ringArc_notMem P h12 hC
    apply hyC
    obtain ⟨a, ha, hya⟩ := mem_iUnion₂.mp (hA.2.1 hy).2
    obtain ⟨θ, -, rfl⟩ := hy
    exact mem_iUnion₂.mpr ⟨a, ⟨ha, _, hya, hcov P hP |> fun _ => by
      rw [mem_closedBall] at hP ⊢
      have := dist_ringPt P θ
      linarith [dist_triangle (ringPt P θ) P u]⟩, hya, ringPt_mem_sphere P θ⟩
  -- the arc read in the lift that starts in `[0, 2π)`
  set n := ⌊θ₁ / (2 * π)⌋ with hn
  have h2π : 0 < 2 * π := by positivity
  have hn1 : (n : ℝ) ≤ θ₁ / (2 * π) := Int.floor_le _
  have hn2 : θ₁ / (2 * π) < n + 1 := Int.lt_floor_add_one _
  have hA' := hA.shift (-n)
  set φ₁ := θ₁ + 2 * π * ((-n : ℤ) : ℝ) with hφ₁
  set φ₂ := θ₂ + 2 * π * ((-n : ℤ) : ℝ) with hφ₂
  have hlo : 0 ≤ φ₁ := by
    rw [hφ₁]; push_cast
    have := (le_div_iff₀ h2π).mp hn1
    linarith
  have hhi : φ₁ < 2 * π := by
    rw [hφ₁]; push_cast
    have := (div_lt_iff₀ h2π).mp hn2
    linarith
  have heq : ringArc P φ₁ φ₂ = ringArc P θ₁ θ₂ := ringArc_add_two_pi_mul P θ₁ θ₂ (-n)
  have hl := l60_le hF hA'
  obtain ⟨hr1, hr2⟩ := hA'.not_regularAt_of_max hF (by rw [heq]; exact hmax)
  refine mem_iUnion₂.mpr ⟨P, ⟨hP𝒞, hP⟩, (φ₁, φ₂), ⟨⟨⟨hlo, by linarith⟩, hr1⟩, ⟨by linarith [hA'.1], by linarith⟩, hr2⟩, heq⟩

theorem hfree_of_baseHyp (hF : F.Valid) {u P : ℂ} (hu : F.Covers u 2) (hH : F.BaseHyp u) (hP : P ∈ closedBall u 1)
    {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') :
    ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1 := by
  intro θ hθ
  have hπ := Real.pi_gt_three
  set x := ringPt P θ with hx
  have hxΓ : x ∈ F.Γ := hA.2.1 ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩
  have hxB : x ∈ closedBall u 2 := by
    rw [mem_closedBall] at hP ⊢
    have := dist_ringPt P θ
    linarith [dist_triangle x P u]
  have hxbad : x ∉ F.fourSet ∪ F.repSet := fun h => Set.disjoint_left.mp hH hxB h
  obtain ⟨r₀, n, G, hC, -, -, f, hf, hsec⟩ := exists_chart_of_noRep hxΓ.1 hxbad
  -- at most two germs: the sectors' colours are distinct colours at `x`, which carries at most two
  have hn2 : n ≤ 2 := by
    have hmem : ∀ i, f i ∈ F.coloursAt x := fun i =>
      closure_mono (hsec i) (hC.mem_closure_sector ⟨hC.pos, le_rfl⟩ i)
    have h2 : (F.coloursAt x).ncard ≤ 2 := ncard_coloursAt_le_two_of_mem_openArc hA hθ
    have hcard : (Finset.univ.image f).card = n := by
      rw [Finset.card_image_of_injective _ hf, Finset.card_univ, Fintype.card_fin]
    have hsub : (↑(Finset.univ.image f) : Set (Fin k)) ⊆ F.coloursAt x := by
      intro c hc; simp only [Finset.coe_image, Finset.coe_univ, image_univ, mem_range] at hc
      obtain ⟨i, rfl⟩ := hc; exact hmem i
    have := Set.ncard_le_ncard hsub (Set.toFinite _)
    rw [Set.ncard_coe_finset, hcard] at this
    omega
  -- a point of `Γ` near `x`, off `x`, is a branch point at its distance from `x`
  have hbr : ∀ z ∈ F.Γ, z ≠ x → dist z x < r₀ → ∃ l, z = branchPt x (G.β l) (G.κ l) (dist z x) := by
    intro z hz hzx hd
    have hmem : z ∈ (F.Γ ∩ ball x r₀) \ {x} := ⟨⟨hz, hd⟩, hzx⟩
    rw [hC.branches] at hmem
    obtain ⟨l, s, hs, rfl⟩ := mem_iUnion.mp hmem
    exact ⟨l, by rw [dist_eq_norm, norm_branchPt_sub _ _ _ hs.1.le]⟩
  set δ := min (min (θ - θ₁) (θ₂ - θ)) 1 with hδ
  have hδ0 : 0 < δ := lt_min (lt_min (by linarith [hθ.1]) (by linarith [hθ.2])) one_pos
  have hδ1 : δ ≤ 1 := min_le_right _ _
  have hδa : δ ≤ θ - θ₁ := (min_le_left _ _).trans (min_le_left _ _)
  have hδb : δ ≤ θ₂ - θ := (min_le_left _ _).trans (min_le_right _ _)
  have hsin : 0 < Real.sin (δ / 2) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
  refine ⟨min r₀ (2 * Real.sin (δ / 2)), lt_min hC.pos (by linarith), ?_⟩
  rintro z ⟨hz, hzb⟩
  by_cases hzx : z = x
  · rw [hzx]; exact ringPt_mem_sphere P θ
  rw [mem_ball] at hzb
  set s := dist z x with hs
  have hs0 : 0 < s := dist_pos.mpr hzx
  have hsr : s < r₀ := lt_of_lt_of_le hzb (min_le_left _ _)
  have hsδ : s / 2 < Real.sin (δ / 2) := by linarith [lt_of_lt_of_le hzb (min_le_right r₀ (2 * Real.sin (δ / 2)))]
  -- the two points of `ω(P)` at distance `s` from `x`
  set t := 2 * Real.arcsin (s / 2) with ht
  have ht0 : 0 < t := by
    have := Real.arcsin_pos.mpr (by linarith : 0 < s / 2)
    linarith
  have htδ : t < δ := by
    have h1 : Real.arcsin (s / 2) < Real.arcsin (Real.sin (δ / 2)) :=
      Real.arcsin_lt_arcsin (by linarith) hsδ (Real.sin_le_one _)
    rw [Real.arcsin_sin (by linarith) (by linarith)] at h1
    linarith
  have hsin_t : 2 * Real.sin (t / 2) = s := by
    rw [ht, show 2 * Real.arcsin (s / 2) / 2 = Real.arcsin (s / 2) by ring,
      Real.sin_arcsin (by linarith) (by linarith [Real.sin_le_one (δ / 2)])]
    ring
  have hdist : ∀ σ : ℝ, (σ = 1 ∨ σ = -1) → dist (ringPt P (θ + σ * t)) x = s := by
    intro σ hσ
    have habs : |θ + σ * t - θ| = t := by
      rcases hσ with rfl | rfl <;> simp [abs_of_pos ht0]
    rw [hx, dist_ringPt_ringPt P (by rw [habs]; linarith), habs, hsin_t]
  have hΓ : ∀ σ : ℝ, (σ = 1 ∨ σ = -1) → ringPt P (θ + σ * t) ∈ F.Γ := by
    intro σ hσ
    refine hA.2.1 ⟨_, ?_, rfl⟩
    rcases hσ with rfl | rfl <;> constructor <;> linarith
  have hne : ∀ σ : ℝ, (σ = 1 ∨ σ = -1) → ringPt P (θ + σ * t) ≠ x := fun σ hσ h => by
    have := hdist σ hσ; rw [h, dist_self] at this; linarith
  obtain ⟨i, hi⟩ := hbr _ (hΓ 1 (Or.inl rfl)) (hne 1 (Or.inl rfl)) (by rw [hdist 1 (Or.inl rfl)]; exact hsr)
  obtain ⟨j, hj⟩ := hbr _ (hΓ (-1) (Or.inr rfl)) (hne (-1) (Or.inr rfl)) (by rw [hdist (-1) (Or.inr rfl)]; exact hsr)
  rw [hdist 1 (Or.inl rfl)] at hi
  rw [hdist (-1) (Or.inr rfl)] at hj
  have hij : i ≠ j := by
    rintro rfl
    refine ringPt_ne_of_abs_sub_lt P (s := θ + 1 * t) (t := θ + -1 * t) (by linarith) ?_ (hi.trans hj.symm)
    rw [abs_of_pos (by linarith)]; linarith
  obtain ⟨l, hl⟩ := hbr z hz hzx hsr
  have hlij : l = i ∨ l = j := by
    have h1 := l.isLt; have h2 := i.isLt; have h3 := j.isLt
    have h4 : (i : ℕ) ≠ j := fun h => hij (Fin.ext h)
    rcases (by omega : (l : ℕ) = i ∨ (l : ℕ) = j) with h | h
    · exact Or.inl (Fin.ext h)
    · exact Or.inr (Fin.ext h)
  rcases hlij with rfl | rfl
  · rw [hl, ← hi]; exact ringPt_mem_sphere P _
  · rw [hl, ← hj]; exact ringPt_mem_sphere P _

theorem maxRingArcs_subset_of_bend (hF : F.Valid) {M : ArcMap k} (hM : M.Valid) {u P : ℂ} (hu : F.Covers u 2)
    (hMu : M.Covers u 2) (hP : P ∈ closedBall u 1) {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hmax : ∀ θ₁' θ₂', ringArc P θ₁ θ₂ ⊆ ringArc P θ₁' θ₂' → F.IsRingArc P θ₁' θ₂' c c' →
      ringArc P θ₁' θ₂' = ringArc P θ₁ θ₂)
    (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1)
    (hR1 : ∀ Q a b d d', M.IsRingArc Q a b d d' → F.IsRingArc Q a b d d')
    (hR2 : ∀ Q a b d d', F.IsRingArc Q a b d d' → Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) →
      M.IsRingArc Q a b d d')
    (hR3 : ∀ θ ∈ Ioo θ₁ θ₂, ¬ M.OnRingArc P (ringPt P θ)) :
    M.maxRingArcs u ⊆ F.maxRingArcs u \ {ringArc P θ₁ θ₂} := by
  rintro S ⟨Q, hQ, a, b, d, d', hB, rfl, hBmax⟩
  have hBF := hR1 Q a b d d' hB
  obtain ⟨a', b', hsub, hG, hGmax⟩ := exists_maxRingArc hF hu hQ hBF
  -- the open arc of `F`'s maximal arc through `β` misses the bent arc's
  have hdisj : Disjoint (ringPt Q '' Ioo a' b') (ringPt P '' Ioo θ₁ θ₂) := by
    rw [Set.disjoint_left]
    rintro x ⟨ψ, hψ, rfl⟩ ⟨θ, hθ, hx⟩
    obtain ⟨r, hr, hfr⟩ := hfree θ hθ
    -- the centres agree: a short arc of `ω(Q)` about the common point lies on `ω(P)`
    have hQP : Q = P := by
      set δ := min (min (ψ - a') (b' - ψ)) (r / 2) with hδ
      have hδ0 : 0 < δ := lt_min (lt_min (by linarith [hψ.1]) (by linarith [hψ.2])) (by linarith)
      have hδa : δ ≤ ψ - a' := (min_le_left _ _).trans (min_le_left _ _)
      have hδb : δ ≤ b' - ψ := (min_le_left _ _).trans (min_le_right _ _)
      have hδr : δ ≤ r / 2 := min_le_right _ _
      refine eq_of_ringArc_subset_sphere (s := ψ - δ) (t := ψ + δ) (by linarith) ?_
      rintro _ ⟨φ, hφ, rfl⟩
      refine hfr ⟨hG.2.1 ⟨φ, ⟨by linarith [hφ.1], by linarith [hφ.2]⟩, rfl⟩, ?_⟩
      rw [hx, mem_ball]
      calc dist (ringPt Q φ) (ringPt Q ψ) ≤ |φ - ψ| := dist_ringPt_ringPt_le Q φ ψ
        _ ≤ δ := by rw [abs_le]; constructor <;> linarith [hφ.1, hφ.2]
        _ < r := by linarith
    subst hQP
    -- the same sides, and so one maximal arc
    obtain ⟨rfl, rfl⟩ := hG.sides_eq_of_ringPt_eq hA hψ hθ hx.symm
    have he : e ψ = e θ := by simpa [ringPt] using hx.symm
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp he
    have hA' := hA.shift n
    have hov : max a' (θ₁ + 2 * π * n) < min b' (θ₂ + 2 * π * n) := by
      rw [max_lt_iff, lt_min_iff, lt_min_iff]
      exact ⟨⟨hG.1, by linarith [hψ.1, hθ.2]⟩, by linarith [hψ.2, hθ.1], by linarith [hA.1]⟩
    have hU := hG.union_of_overlap hA' hov
    have e1 := hGmax _ _ (by
      rintro _ ⟨φ, hφ, rfl⟩
      exact ⟨φ, ⟨(min_le_left _ _).trans hφ.1, hφ.2.trans (le_max_left _ _)⟩, rfl⟩) hU
    have e2 := hmax _ _ (by
      rw [← ringArc_add_two_pi_mul Q θ₁ θ₂ n]
      rintro _ ⟨φ, hφ, rfl⟩
      exact ⟨φ, ⟨(min_le_right _ _).trans hφ.1, hφ.2.trans (le_max_right _ _)⟩, rfl⟩) hU
    have hβα : ringArc Q a b ⊆ ringArc Q θ₁ θ₂ := by rw [← e2, e1]; exact hsub
    -- a point of `β` inside the open bent arc lies on a unit arc of `M` about `P`: against R3
    obtain ⟨y, hyβ, hyC⟩ := exists_mem_ringArc_notMem Q hB.1 (toFinite {ringPt Q θ₁, ringPt Q θ₂})
    obtain ⟨φ, hφ, rfl⟩ := hβα hyβ
    have hφ' : φ ∈ Ioo θ₁ θ₂ :=
      ⟨lt_of_le_of_ne hφ.1 fun h => hyC (by rw [← h]; exact mem_insert _ _),
        lt_of_le_of_ne hφ.2 fun h => hyC (by rw [h]; exact mem_insert_of_mem _ (mem_singleton _))⟩
    exact hR3 φ hφ' ⟨a, b, hB.1, hyβ, hB.2.1⟩
  have hGM := hR2 Q a' b' d d' hG hdisj
  have heq := hBmax a' b' hsub hGM
  refine ⟨⟨Q, hQ, a', b', d, d', hG, heq.symm, hGmax⟩, fun hS => ?_⟩
  rw [mem_singleton_iff] at hS
  have hmid : (θ₁ + θ₂) / 2 ∈ Ioo θ₁ θ₂ := ⟨by linarith [hA.1], by linarith [hA.1]⟩
  exact hR3 _ hmid ⟨θ₁, θ₂, hA.1, ⟨_, Ioo_subset_Icc_self hmid, rfl⟩, hS ▸ hB.2.1⟩

end ArcMap

end HadwigerNelson.Plane
