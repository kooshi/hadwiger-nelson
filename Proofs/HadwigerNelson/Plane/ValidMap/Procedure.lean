import Proofs.HadwigerNelson.Plane.ValidMap.Limit
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc

/-!
# The terminal procedure: FS112-N2-RED's bends with FS110-N4-TERM's moves, as one locally finite sequence (FS131-KL1)

Wave 5's construction behind `exists_red` and `exists_terminal` (`plans/FS131-limit-kernel-plan.md` §§ 3–4): **every valid map of the
plane has a modification that is a terminal valid map** (`exists_terminalMap`, every `k`). Clean the map (`exists_clean`), then run
one procedure over its *treatment points* (`treatPts`: the sites and the centres of unit arcs, never created afterwards): at the
least-index point with something to do, apply a **vertex step** (MERGE, MERGE-RAY or SHAVE at a site, then cleaned: its degree drops,
`exists_vertexStep`) or an **arc step** (a toward or away bend of a maximal bad unit arc, then cleaned: the point's count of maximal
bad arcs drops, `exists_arcStep`). A site is treated at most its initial degree times; a centre's bad count rises only at the finitely
many vertex steps within distance `3` and at the at most `k` stages where it loses a colour, so it too is treated finitely often
(`exists_terminalSeq`). The supports are then locally finite, and the limit (`Plane/ValidMap/Limit`) is the terminal map.

**Where the steps' proofs live** (inventory items 371–372): `exists_vertexStep` and `exists_arcStep` read the moves' constructions —
`main`'s `Moves` (`exists_shave_aux`, `exists_rayMerge_aux` through `Near.move`), `MergeMove` (`exists_merge_aux`) and `UnitArc`
(`bend_toward`, `bend_away_whole`, the N2-TAN bend) — followed by `exists_clean`; they are stated here and proved after this branch
merges `main`, in this module with those imports (or a module between them; the plan's § 4.3). Until then they are `sorry`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-! ## Maximal unit arcs, bad arcs, treatment points -/

/-- **A maximal constant-sided unit arc** of `ω(P)`: a ring arc with sides `c`, `c'`, its start normalised to `[0, 2π)`, not contained
in a longer one with the same sides. (In a valid map ring arcs are at most `60°` long, `l60_le`, so every ring arc lies in a maximal
one.) -/
def IsMaxRingArc (P : ℂ) (θ₁ θ₂ : ℝ) (c c' : Fin k) : Prop :=
  F.IsRingArc P θ₁ θ₂ c c' ∧ θ₁ ∈ Ico 0 (2 * π) ∧
    ∀ θ₁' θ₂', θ₁' ≤ θ₁ → θ₂ ≤ θ₂' → F.IsRingArc P θ₁' θ₂' c c' → θ₁' = θ₁ ∧ θ₂' = θ₂

/-- **The bad count at `P`**: the number of maximal unit arcs about `P` that are neither (Q) nor (R2) (as `encard`). A maximal arc is
bad exactly when some sub-arc is neither — (Q) is read on the sides and `P`, and (R2) of the whole arc gives (R2) of every sub-arc —
so `badCount F P = 0` is "every ring arc about `P` is (Q) or (R2)" (`badCount_eq_zero_iff`). -/
noncomputable def badCount (P : ℂ) : ℕ∞ :=
  {p : ℝ × ℝ | ∃ c c', F.IsMaxRingArc P p.1 p.2 c c' ∧ ¬ F.IsQArc P p.1 p.2 ∧ ¬ F.IsR2Arc P p.1 p.2}.encard

/-- **Treatment points**: the sites and the centres of unit arcs of `Γ` — where a step may act. No step creates one
(`exists_vertexStep`, `exists_arcStep`), so the initial map's enumerate every stage's. -/
def treatPts : Set ℂ := {v | F.IsSite v ∨ ∃ x, F.OnRingArc v x}

variable {F}

/-! ## Ring arcs under a turn, on sub-arcs and unions (FS131-IL2) -/

/-- A ring point is unchanged by whole turns. -/
theorem ringPt_add_int (p : ℂ) (θ : ℝ) (m : ℤ) : ringPt p (θ + 2 * π * m) = ringPt p θ := by
  rw [ringPt, ringPt, e_add_int_mul]

/-- A radius-two arc is unchanged by whole turns of both ends. -/
theorem radiusTwoArc_add_int (p : ℂ) (a b : ℝ) (m : ℤ) :
    radiusTwoArc p (a + 2 * π * m) (b + 2 * π * m) = radiusTwoArc p a b := by
  ext z
  simp only [radiusTwoArc, mem_image, mem_Icc]
  constructor
  · rintro ⟨θ, ⟨h1, h2⟩, rfl⟩
    refine ⟨θ - 2 * π * m, ⟨by linarith, by linarith⟩, ?_⟩
    rw [← e_add_int_mul (θ - 2 * π * m) m, sub_add_cancel]
  · rintro ⟨θ, ⟨h1, h2⟩, rfl⟩
    exact ⟨θ + 2 * π * m, ⟨by linarith, by linarith⟩, by rw [e_add_int_mul]⟩

/-- A ring arc with constant sides is one after whole turns of both ends. -/
theorem isRingArc_add_int {p : ℂ} {a b : ℝ} {c c' : Fin k} (m : ℤ) :
    F.IsRingArc p (a + 2 * π * m) (b + 2 * π * m) c c' ↔ F.IsRingArc p a b c c' := by
  unfold IsRingArc
  rw [ringArc_add_two_pi_mul]
  constructor
  · rintro ⟨h1, h2, h3⟩
    refine ⟨by linarith, h2, fun θ hθ => ?_⟩
    have := h3 (θ + 2 * π * m) ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
    rwa [ringPt_add_int] at this
  · rintro ⟨h1, h2, h3⟩
    refine ⟨by linarith, h2, fun θ hθ => ?_⟩
    have := h3 (θ - 2 * π * m) ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
    rwa [← ringPt_add_int p (θ - 2 * π * m) m, sub_add_cancel] at this

/-- (Q) is unchanged by whole turns. -/
theorem isQArc_add_int {p : ℂ} {a b : ℝ} (m : ℤ) : F.IsQArc p (a + 2 * π * m) (b + 2 * π * m) ↔ F.IsQArc p a b := by
  unfold IsQArc
  simp only [isRingArc_add_int]

/-- (R2) is unchanged by whole turns. -/
theorem isR2Arc_add_int {p : ℂ} {a b : ℝ} (m : ℤ) : F.IsR2Arc p (a + 2 * π * m) (b + 2 * π * m) ↔ F.IsR2Arc p a b := by
  unfold IsR2Arc
  simp only [isRingArc_add_int, radiusTwoArc_add_int]

/-- Two ring arcs sharing an interior angle have the same sides. -/
theorem IsRingArc.sides_eq {p : ℂ} {a b a' b' : ℝ} {c c' d d' : Fin k} (h : F.IsRingArc p a b c c')
    (h' : F.IsRingArc p a' b' d d') {θ : ℝ} (hθ : θ ∈ Ioo a b) (hθ' : θ ∈ Ioo a' b') : c = d ∧ c' = d' := by
  obtain ⟨h1, h2⟩ := h.2.2 θ hθ
  obtain ⟨h1', h2'⟩ := h'.2.2 θ hθ'
  exact ⟨singleton_injective (h1.symm.trans h1'), singleton_injective (h2.symm.trans h2')⟩

/-- A ring arc's sub-arc is a ring arc with the same sides. -/
theorem IsRingArc.mono {p : ℂ} {a b a' b' : ℝ} {c c' : Fin k} (h : F.IsRingArc p a b c c') (ha : a ≤ a')
    (hab : a' < b') (hb : b' ≤ b) : F.IsRingArc p a' b' c c' :=
  ⟨hab, (ringArc_subset_ringArc ha hb).trans h.2.1, fun θ hθ => h.2.2 θ ⟨by linarith [hθ.1], by linarith [hθ.2]⟩⟩

/-- Two overlapping intervals cover their union (open form). -/
theorem mem_Ioo_or_of_overlap {a b a' b' θ : ℝ} (hov : max a a' < min b b') (h1 : min a a' < θ) (h2 : θ < max b b') :
    θ ∈ Ioo a b ∨ θ ∈ Ioo a' b' := by
  rw [max_lt_iff, lt_min_iff, lt_min_iff] at hov
  rw [min_lt_iff] at h1
  rw [lt_max_iff] at h2
  by_cases ha : a < θ
  · by_cases hb : θ < b
    · exact Or.inl ⟨ha, hb⟩
    · push Not at hb
      right
      refine ⟨by linarith [hov.2.1], ?_⟩
      rcases h2 with h2 | h2
      · linarith
      · exact h2
  · push Not at ha
    right
    rcases h1 with h1 | h1
    · linarith
    · exact ⟨h1, by linarith [hov.1.2]⟩

/-- **Two ring arcs with the same sides and a common interior point unite.** -/
theorem IsRingArc.union {p : ℂ} {a b a' b' : ℝ} {c c' : Fin k} (h : F.IsRingArc p a b c c')
    (h' : F.IsRingArc p a' b' c c') (hov : max a a' < min b b') : F.IsRingArc p (min a a') (max b b') c c' := by
  have hab : min a a' < max b b' := lt_of_le_of_lt (min_le_left _ _)
    (lt_of_lt_of_le ((le_max_left a a').trans_lt (hov.trans_le (min_le_left _ _))) (le_max_left _ _))
  refine ⟨hab, ?_, fun θ hθ => ?_⟩
  · rintro _ ⟨θ, ⟨h1, h2⟩, rfl⟩
    rcases eq_or_lt_of_le h1 with h1 | h1
    · rcases min_choice a a' with hm | hm
      · rw [hm] at h1; exact h.2.1 ⟨θ, ⟨h1.le, by rw [← h1]; exact h.1.le⟩, rfl⟩
      · rw [hm] at h1; exact h'.2.1 ⟨θ, ⟨h1.le, by rw [← h1]; exact h'.1.le⟩, rfl⟩
    rcases eq_or_lt_of_le h2 with h2 | h2
    · rcases max_choice b b' with hm | hm
      · rw [hm] at h2; exact h.2.1 ⟨θ, ⟨by rw [h2]; exact h.1.le, h2.le⟩, rfl⟩
      · rw [hm] at h2; exact h'.2.1 ⟨θ, ⟨by rw [h2]; exact h'.1.le, h2.le⟩, rfl⟩
    rcases mem_Ioo_or_of_overlap hov h1 h2 with h3 | h3
    · exact h.2.1 ⟨θ, Ioo_subset_Icc_self h3, rfl⟩
    · exact h'.2.1 ⟨θ, Ioo_subset_Icc_self h3, rfl⟩
  · rcases mem_Ioo_or_of_overlap hov hθ.1 hθ.2 with h3 | h3
    · exact h.2.2 θ h3
    · exact h'.2.2 θ h3

/-- A (Q) arc's sub-arcs with constant sides are (Q). -/
theorem IsQArc.of_subarc {p : ℂ} {a b a' b' : ℝ} {c c' : Fin k} (hQ : F.IsQArc p a b) (hA : F.IsRingArc p a' b' c c')
    (ha : a ≤ a') (hb : b' ≤ b) : F.IsQArc p a' b' := by
  obtain ⟨d, d', hD, hd, hd', h4⟩ := hQ
  obtain ⟨rfl, rfl⟩ := hD.sides_eq hA (θ := (a' + b') / 2) ⟨by linarith [hA.1], by linarith [hA.1]⟩
    ⟨by linarith [hA.1], by linarith [hA.1]⟩
  exact ⟨d, d', hA, hd, hd', h4⟩

/-- An (R2) arc's sub-arcs with constant sides are (R2). -/
theorem IsR2Arc.of_subarc {p : ℂ} {a b a' b' : ℝ} {c c' : Fin k} (hR : F.IsR2Arc p a b) (hA : F.IsRingArc p a' b' c c')
    (ha : a ≤ a') (hb : b' ≤ b) : F.IsR2Arc p a' b' := by
  obtain ⟨d, d', hD, hd', hd, hsub⟩ := hR
  obtain ⟨rfl, rfl⟩ := hD.sides_eq hA (θ := (a' + b') / 2) ⟨by linarith [hA.1], by linarith [hA.1]⟩
    ⟨by linarith [hA.1], by linarith [hA.1]⟩
  refine ⟨d, d', hA, hd', hd, fun z hz => hsub ?_⟩
  obtain ⟨θ, hθ, rfl⟩ := hz
  exact ⟨θ, ⟨ha.trans hθ.1, hθ.2.trans hb⟩, rfl⟩

/-- `Γ` of a map of the plane is closed (its complement is the interior points). -/
theorem isClosed_Γ_of_isPlaneMap (hP : F.IsPlaneMap) : IsClosed F.Γ := by
  have h : F.Γ = F.interiorPtsᶜ := by
    ext z
    rw [mem_Γ_iff, mem_compl_iff]
    have : z ∈ F.dom := by rw [hP]; trivial
    exact ⟨fun h => h.2, fun h => ⟨this, h⟩⟩
  rw [h]
  exact F.isOpen_interiorPts.isClosed_compl

/-- **Every ring arc of a valid map of the plane lies in a maximal one** (after a whole turn normalising its start): the
union of the ring arcs with the same sides containing it is one (each at most `60°` long, `l60_le`; its ends are limits of
points of `Γ`, which is closed in the plane). -/
theorem exists_isMaxRingArc (hF : F.Valid) (hP : F.IsPlaneMap) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hA : F.IsRingArc P θ₁ θ₂ c c') :
    ∃ m : ℤ, ∃ φ₁ φ₂, F.IsMaxRingArc P φ₁ φ₂ c c' ∧ φ₁ ≤ θ₁ + 2 * π * m ∧ θ₂ + 2 * π * m ≤ φ₂ := by
  have hπ := Real.pi_pos
  set S : Set (ℝ × ℝ) := {q | q.1 ≤ θ₁ ∧ θ₂ ≤ q.2 ∧ F.IsRingArc P q.1 q.2 c c'} with hSdef
  have hS0 : (θ₁, θ₂) ∈ S := ⟨le_rfl, le_rfl, hA⟩
  have hlen : ∀ q ∈ S, q.2 - q.1 ≤ π / 3 := fun q hq => l60_le hF hq.2.2
  have hne1 : (Prod.fst '' S).Nonempty := ⟨θ₁, _, hS0, rfl⟩
  have hne2 : (Prod.snd '' S).Nonempty := ⟨θ₂, _, hS0, rfl⟩
  have hbdd1 : BddBelow (Prod.fst '' S) := ⟨θ₂ - π / 3, by
    rintro _ ⟨q, hq, rfl⟩; linarith [hlen q hq, hq.2.1]⟩
  have hbdd2 : BddAbove (Prod.snd '' S) := ⟨θ₁ + π / 3, by
    rintro _ ⟨q, hq, rfl⟩; linarith [hlen q hq, hq.1]⟩
  set φ₁ := sInf (Prod.fst '' S) with hφ₁
  set φ₂ := sSup (Prod.snd '' S) with hφ₂
  have hφ1 : φ₁ ≤ θ₁ := csInf_le hbdd1 ⟨_, hS0, rfl⟩
  have hφ2 : θ₂ ≤ φ₂ := le_csSup hbdd2 ⟨_, hS0, rfl⟩
  have h12 : θ₁ < θ₂ := hA.1
  -- every interior angle of `[φ₁, φ₂]` is interior to a member
  have hcover : ∀ θ ∈ Ioo φ₁ φ₂, ∃ q ∈ S, θ ∈ Ioo q.1 q.2 := by
    intro θ hθ
    by_cases hθ2 : θ < θ₂
    · obtain ⟨_, ⟨q, hq, rfl⟩, hlt⟩ := exists_lt_of_csInf_lt hne1 hθ.1
      exact ⟨q, hq, hlt, hθ2.trans_le hq.2.1⟩
    · push Not at hθ2
      obtain ⟨_, ⟨q, hq, rfl⟩, hlt⟩ := exists_lt_of_lt_csSup hne2 hθ.2
      exact ⟨q, hq, by linarith [hq.1], hlt⟩
  have hring : F.IsRingArc P φ₁ φ₂ c c' := by
    refine ⟨by linarith, ?_, fun θ hθ => ?_⟩
    · have hIoo : ringPt P '' Ioo φ₁ φ₂ ⊆ F.Γ := by
        rintro _ ⟨θ, hθ, rfl⟩
        obtain ⟨q, hq, hθq⟩ := hcover θ hθ
        exact hq.2.2.2.1 ⟨θ, Ioo_subset_Icc_self hθq, rfl⟩
      have hcont : Continuous (ringPt P) := continuous_const.add continuous_e
      calc ringArc P φ₁ φ₂ = ringPt P '' closure (Ioo φ₁ φ₂) := by
            rw [closure_Ioo (by linarith : φ₁ ≠ φ₂)]; rfl
        _ ⊆ closure (ringPt P '' Ioo φ₁ φ₂) := image_closure_subset_closure_image hcont
        _ ⊆ closure F.Γ := closure_mono hIoo
        _ = F.Γ := (isClosed_Γ_of_isPlaneMap hP).closure_eq
    · obtain ⟨q, hq, hθq⟩ := hcover θ hθ
      exact hq.2.2.2.2 θ hθq
  have hmaxl : ∀ φ₁' φ₂', φ₁' ≤ φ₁ → φ₂ ≤ φ₂' → F.IsRingArc P φ₁' φ₂' c c' → φ₁' = φ₁ ∧ φ₂' = φ₂ := by
    intro φ₁' φ₂' h1 h2 h
    have hq : (φ₁', φ₂') ∈ S := ⟨h1.trans hφ1, hφ2.trans h2, h⟩
    exact ⟨le_antisymm h1 (csInf_le hbdd1 ⟨_, hq, rfl⟩), le_antisymm (le_csSup hbdd2 ⟨_, hq, rfl⟩) h2⟩
  -- normalise the start to `[0, 2π)`
  set n := ⌊φ₁ / (2 * π)⌋ with hn
  have hn1 : (n : ℝ) ≤ φ₁ / (2 * π) := Int.floor_le _
  have hn2 : φ₁ / (2 * π) < n + 1 := Int.lt_floor_add_one _
  have h2π : 0 < 2 * π := by positivity
  have hlo : 0 ≤ φ₁ + 2 * π * ((-n : ℤ) : ℝ) := by
    push_cast
    have := (le_div_iff₀ h2π).mp hn1
    linarith
  have hhi : φ₁ + 2 * π * ((-n : ℤ) : ℝ) < 2 * π := by
    push_cast
    have := (div_lt_iff₀ h2π).mp hn2
    linarith
  refine ⟨-n, φ₁ + 2 * π * ((-n : ℤ) : ℝ), φ₂ + 2 * π * ((-n : ℤ) : ℝ),
    ⟨(isRingArc_add_int (-n)).mpr hring, ⟨hlo, hhi⟩, fun ψ₁ ψ₂ h1 h2 h => ?_⟩, by linarith, by linarith⟩
  have h' : F.IsRingArc P (ψ₁ + 2 * π * ((n : ℤ) : ℝ)) (ψ₂ + 2 * π * ((n : ℤ) : ℝ)) c c' := (isRingArc_add_int n).mpr h
  have key := hmaxl _ _ (by push_cast at h1 ⊢; linarith) (by push_cast at h2 ⊢; linarith) h'
  constructor
  · push_cast at key ⊢; linarith [key.1]
  · push_cast at key ⊢; linarith [key.2]

/-- **The ends of a maximal arc are irregular angles** (at a regular end the arc would continue past it with the same sides). -/
theorem IsMaxRingArc.not_regularAt {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hmax : F.IsMaxRingArc P θ₁ θ₂ c c') :
    ¬ F.RegularAt P θ₁ ∧ ¬ F.RegularAt P θ₂ := by
  have hA := hmax.1
  have h12 : θ₁ < θ₂ := hA.1
  have hπ := Real.pi_pos
  -- an arc through a regular angle `θ`, turned to hold `θ` in its interior
  have hturn : ∀ θ, F.RegularAt P θ → θ ∈ Icc θ₁ θ₂ →
      ∃ a b, F.IsRingArc P a b c c' ∧ θ ∈ Ioo a b := by
    rintro θ (hΓ | ⟨φ₁, φ₂, d, d', hD, φ, hφ, heφ⟩) hθ
    · exact absurd (hA.2.1 ⟨θ, hθ, rfl⟩) hΓ
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp heφ
    have hD' := (isRingArc_add_int (a := φ₁) (b := φ₂) (-n)).mpr hD
    have hθ' : θ ∈ Ioo (φ₁ + 2 * π * ((-n : ℤ) : ℝ)) (φ₂ + 2 * π * ((-n : ℤ) : ℝ)) := by
      push_cast; constructor <;> linarith [hφ.1, hφ.2]
    -- the sides agree with `c`, `c'` at an angle of both
    have hs : ∃ t, t ∈ Ioo θ₁ θ₂ ∧ t ∈ Ioo (φ₁ + 2 * π * ((-n : ℤ) : ℝ)) (φ₂ + 2 * π * ((-n : ℤ) : ℝ)) := by
      set a := φ₁ + 2 * π * ((-n : ℤ) : ℝ)
      set b := φ₂ + 2 * π * ((-n : ℤ) : ℝ)
      refine ⟨(max θ₁ a + min θ₂ b) / 2, ⟨?_, ?_⟩, ⟨?_, ?_⟩⟩ <;>
        · have h1 : max θ₁ a < min θ₂ b := by
            rw [max_lt_iff, lt_min_iff, lt_min_iff]
            exact ⟨⟨h12, lt_of_le_of_lt hθ.1 hθ'.2⟩, ⟨lt_of_lt_of_le hθ'.1 hθ.2, by linarith [hθ'.1, hθ'.2]⟩⟩
          linarith [le_max_left θ₁ a, le_max_right θ₁ a, min_le_left θ₂ b, min_le_right θ₂ b]
    obtain ⟨t, ht, ht'⟩ := hs
    obtain ⟨rfl, rfl⟩ := hA.sides_eq hD' ht ht'
    exact ⟨_, _, hD', hθ'⟩
  constructor
  · intro hreg
    obtain ⟨a, b, hD, hθ⟩ := hturn θ₁ hreg ⟨le_rfl, h12.le⟩
    have hov : max θ₁ a < min θ₂ b := by
      rw [max_lt_iff, lt_min_iff, lt_min_iff]
      exact ⟨⟨h12, hθ.2⟩, ⟨hθ.1.trans h12, hθ.1.trans hθ.2⟩⟩
    have hU := hA.union hD hov
    have := (hmax.2.2 _ _ (min_le_left _ _) (le_max_left _ _) hU).1
    rw [min_eq_right (hθ.1.le)] at this
    linarith [hθ.1]
  · intro hreg
    obtain ⟨a, b, hD, hθ⟩ := hturn θ₂ hreg ⟨h12.le, le_rfl⟩
    have hov : max θ₁ a < min θ₂ b := by
      rw [max_lt_iff, lt_min_iff, lt_min_iff]
      exact ⟨⟨h12, h12.trans hθ.2⟩, ⟨hθ.1, hθ.1.trans hθ.2⟩⟩
    have hU := hA.union hD hov
    have := (hmax.2.2 _ _ (min_le_left _ _) (le_max_left _ _) hU).2
    rw [max_eq_right (hθ.2.le)] at this
    linarith [hθ.2]

/-- **The sites of a clean map in a compact part of the domain are finitely many** (each is isolated). -/
theorem finite_sites_inter_compact (hc : F.IsClean) {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ F.dom) :
    (K ∩ {v | F.IsSite v}).Finite := by
  refine hK.induction_on (p := fun s => (s ∩ {v | F.IsSite v}).Finite) ?_ ?_ ?_ ?_
  · simp
  · intro s t hst ht
    exact ht.subset (inter_subset_inter_left _ hst)
  · intro s t hs ht
    rw [union_inter_distrib_right]
    exact hs.union ht
  · intro x hx
    have hev := hc.eventually_not_isSite (hKd hx)
    rw [eventually_nhdsWithin_iff] at hev
    refine ⟨_, mem_nhdsWithin_of_mem_nhds hev, (finite_singleton x).subset ?_⟩
    rintro y ⟨hyU, hy⟩
    by_contra hyx
    exact hyU hyx hy

/-- A ring arc of positive length has infinitely many points. -/
theorem infinite_ringArc (p : ℂ) {θ₁ θ₂ : ℝ} (h : θ₁ < θ₂) : (ringArc p θ₁ θ₂).Infinite := by
  have hπ := Real.pi_pos
  set b := min θ₂ (θ₁ + π) with hb
  have hb1 : θ₁ < b := lt_min h (by linarith)
  refine ((Icc_infinite hb1).image fun s hs t ht hst => ?_).mono (image_mono (Icc_subset_Icc le_rfl (min_le_left _ _)))
  have he : e s = e t := by
    have := hst; simp only [ringPt] at this; exact add_left_cancel this
  obtain ⟨n, hn⟩ := e_eq_e_iff.mp he
  have hs' := hs; have ht' := ht
  have hb2 : b ≤ θ₁ + π := min_le_right _ _
  have h1 : (n : ℝ) * (2 * π) < 2 * π := by linarith [hs'.1, hs'.2, ht'.1, ht'.2]
  have h2 : -(2 * π) < (n : ℝ) * (2 * π) := by linarith [hs'.1, hs'.2, ht'.1, ht'.2]
  have hn1 : (n : ℝ) < 1 := by nlinarith
  have hn2 : (-1 : ℝ) < n := by nlinarith
  have hn0 : n = 0 := by
    have a1 : n < 1 := by exact_mod_cast hn1
    have a2 : -1 < n := by exact_mod_cast hn2
    omega
  rw [hn, hn0]; simp

/-- **The centres of unit arcs in a compact set are finitely many** in a map of the plane: such a centre's ring arc meets
infinitely many points of one of the finitely many arcs near `K`, which is then an arc of its unit circle. -/
theorem finite_centres_inter_compact (hP : F.IsPlaneMap) {K : Set ℂ} (hK : IsCompact K) :
    (K ∩ {v | ∃ x, F.OnRingArc v x}).Finite := by
  have hK' : IsCompact (cthickening 1 K) := hK.cthickening
  have hK'd : cthickening 1 K ⊆ F.dom := by rw [hP]; exact subset_univ _
  have h𝒜 := F.finite_arcs_inter_compact hK' hK'd
  refine (h𝒜.biUnion fun a _ => (show {v : ℂ | ∃ θ₀ θ₁, a = Arc.circ v 1 θ₀ θ₁}.Subsingleton from ?_).finite).subset ?_
  · rintro v ⟨θ₀, θ₁, rfl⟩ w ⟨θ₀', θ₁', h⟩
    exact (Arc.circ.inj h).1
  · rintro v ⟨hvK, x, θ₁, θ₂, h12, -, hsub⟩
    by_contra hno
    simp only [mem_iUnion, not_exists] at hno
    apply infinite_ringArc v h12
    refine (h𝒜.biUnion (t := fun a => a.carrier ∩ sphere v 1) fun a ha => ?_).subset ?_
    · rcases Arc.finite_inter_sphere_or_eq_circ a (F.nondegenerate a ha.1) v with h | ⟨θ₀, θ₁', rfl⟩
      · exact h
      · exact absurd ⟨θ₀, θ₁', rfl⟩ (hno _ ha)
    · rintro z ⟨θ, hθ, rfl⟩
      have hz := hsub ⟨θ, hθ, rfl⟩
      obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp hz.2
      have hzK : ringPt v θ ∈ cthickening 1 K :=
        mem_cthickening_of_dist_le _ v 1 K hvK (by simp [ringPt, dist_eq_norm])
      refine mem_iUnion₂.mpr ⟨a, ⟨ha, _, hza, hzK⟩, hza, ?_⟩
      simp [ringPt]

/-- `badCount F P = 0` exactly when every ring arc about `P` is (Q) or (R2) (every ring arc lies in a maximal one, `l60_le`). Of the
plane (FS131-IL1, inventory item 380): on a smaller domain a ring arc whose ends leave the domain lies in no maximal one, and the
lemma is false (an open annular sector carrying one unit arc, `plans/FS131-limit-kernel-plan.md` Stage 7). -/
theorem badCount_eq_zero_iff (hF : F.Valid) (hP : F.IsPlaneMap) (P : ℂ) :
    F.badCount P = 0 ↔ ∀ θ₁ θ₂ c c', F.IsRingArc P θ₁ θ₂ c c' → F.IsQArc P θ₁ θ₂ ∨ F.IsR2Arc P θ₁ θ₂ := by
  rw [badCount, encard_eq_zero, eq_empty_iff_forall_notMem]
  constructor
  · intro h θ₁ θ₂ c c' hA
    obtain ⟨m, φ₁, φ₂, hmax, h1, h2⟩ := exists_isMaxRingArc hF hP hA
    have hgood : F.IsQArc P φ₁ φ₂ ∨ F.IsR2Arc P φ₁ φ₂ := by
      by_contra hno
      push Not at hno
      exact h (φ₁, φ₂) ⟨c, c', hmax, hno.1, hno.2⟩
    have hA' : F.IsRingArc P (θ₁ + 2 * π * m) (θ₂ + 2 * π * m) c c' := (isRingArc_add_int m).mpr hA
    rcases hgood with hQ | hR
    · exact Or.inl ((isQArc_add_int m).mp (hQ.of_subarc hA' h1 h2))
    · exact Or.inr ((isR2Arc_add_int m).mp (hR.of_subarc hA' h1 h2))
  · rintro h ⟨θ₁, θ₂⟩ ⟨c, c', hmax, hQ, hR⟩
    rcases h θ₁ θ₂ c c' hmax.1 with h' | h'
    · exact hQ h'
    · exact hR h'

/-- **Finitely many maximal arcs about a point** of a clean valid map of the plane: the ends of a maximal arc are irregular angles of
the ring (`IsMaxRingArc.not_regularAt`), finitely many in a bounded range (`finite_not_regular`), and a maximal arc starts in `[0, 2π)`
and is at most `60°` long (`l60_le`). The plane hypothesis (inventory item 380) gives `ω(P)` in the domain; cleanness is not used. -/
theorem badCount_lt_top (hF : F.Valid) (hP : F.IsPlaneMap) (hc : F.IsClean) (P : ℂ) : F.badCount P < ⊤ := by
  have _ := hc
  have hπ := Real.pi_pos
  rw [badCount, encard_lt_top_iff]
  have hcov : F.Covers P 1 := fun z _ => by rw [hP]; trivial
  have hZ := finite_not_regular hcov (4 * π)
  refine (hZ.prod hZ).subset ?_
  rintro ⟨θ₁, θ₂⟩ ⟨c, c', hmax, -, -⟩
  have hl := l60_le hF hmax.1
  have h0 := hmax.2.1
  have h12 : θ₁ < θ₂ := hmax.1.1
  obtain ⟨hn1, hn2⟩ := hmax.not_regularAt
  exact ⟨⟨⟨h0.1, by linarith [h0.2]⟩, hn1⟩, ⟨⟨by linarith [h0.1], by linarith [h0.2]⟩, hn2⟩⟩

/-- **Treatment points are locally finite** in a clean map of the plane: sites are isolated (`IsClean.eventually_not_isSite`) and
closed; the centres of the unit arcs meeting a compact set are finitely many (local finiteness of the arcs on `cthickening 1 K`,
which the plane hypothesis, inventory item 380, keeps inside the domain). -/
theorem treatPts_inter_finite (hP : F.IsPlaneMap) (hc : F.IsClean) {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ F.dom) :
    (K ∩ F.treatPts).Finite := by
  refine ((finite_sites_inter_compact hc hK hKd).union (finite_centres_inter_compact hP hK)).subset ?_
  rintro v ⟨hvK, hv | hv⟩
  · exact Or.inl ⟨hvK, hv⟩
  · exact Or.inr ⟨hvK, hv⟩

/-- **A both-kind arc at a centre of at most three colours makes MERGE available there** (N2-RED's parenthesis: by U1 the side
cones hold neither side colour, and a colour holding both side cones is a colour of two sectors with a non-empty allowed cone). So
an arc step is needed only at in-only, out-only and inert arcs. -/
theorem mergeAvailable_of_bothKind (hF : F.Valid) (hP : F.IsPlaneMap) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hA : F.IsRingArc P θ₁ θ₂ c c') (hc : c ∈ F.coloursAt P) (hc' : c' ∈ F.coloursAt P) (h3 : (F.coloursAt P).ncard ≤ 3) :
    F.MergeAvailable P := by
  have hπ := Real.pi_pos
  have h12 : θ₁ < θ₂ := hA.1
  have hl60 := l60_le hF hA
  have hPd : P ∈ F.dom := by rw [hP]; trivial
  have hcov : F.Covers P 1 := fun z _ => by rw [hP]; trivial
  -- the side colours differ: their cones lie in the facing and the away intervals (U1)
  have hcc' : c ≠ c' := by
    rintro rfl
    obtain ⟨γ, hγ⟩ := coneAt_region_nonempty hc
    obtain ⟨i, hi1, hi2⟩ := mem_iUnion.mp (ringArc_cone_inner hF hA hγ)
    obtain ⟨j, hj1, hj2⟩ := mem_iUnion.mp (ringArc_cone_outer hF hA hγ)
    exact disj_lifts h12 i j ⟨hi1, hi2⟩ ⟨hj1, hj2⟩
  set μ := (θ₁ + θ₂) / 2 with hμ
  set w := (θ₂ - θ₁) / 2 with hwdef
  have hw : 0 < w := by linarith
  have hw' : w ≤ π / 6 := by linarith
  -- every direction of the two open side cones is a direction of a colour other than `c`, `c'` (U1), and there is one such colour
  have hside : ∀ β ∈ angleIoo (θ₁ - π / 2) (θ₂ - π / 2) ∪ angleIoo (θ₁ + π / 2) (θ₂ + π / 2),
      ∃ d, d ≠ c ∧ d ≠ c' ∧ d ∈ F.coloursAt P ∧ β ∈ coneAt (F.region d) P := by
    intro β hβ
    obtain ⟨d, hdc, hdc', hβd⟩ := ringArc_sideCone_other hF hPd hA hβ
    exact ⟨d, hdc, hdc', mem_closure_of_mem_coneAt hβd, hβd⟩
  have huniq : ∀ d₁ d₂, d₁ ≠ c → d₁ ≠ c' → d₁ ∈ F.coloursAt P → d₂ ≠ c → d₂ ≠ c' → d₂ ∈ F.coloursAt P → d₁ = d₂ := by
    intro d₁ d₂ h1 h1' hd₁ h2 h2' hd₂
    by_contra hne
    have hsub : ({c, c', d₁, d₂} : Set (Fin k)) ⊆ F.coloursAt P := by
      rintro x (rfl | rfl | rfl | rfl)
      · exact hc
      · exact hc'
      · exact hd₁
      · exact hd₂
    have h4 : ({c, c', d₁, d₂} : Set (Fin k)).ncard = 4 := by
      rw [ncard_insert_of_notMem, ncard_insert_of_notMem, ncard_pair hne]
      · simp only [mem_insert_iff, mem_singleton_iff, not_or]
        exact ⟨Ne.symm h1', Ne.symm h2'⟩
      · simp only [mem_insert_iff, mem_singleton_iff, not_or]
        exact ⟨hcc', Ne.symm h1, Ne.symm h2⟩
    have := ncard_le_ncard hsub (toFinite _)
    omega
  have hL : μ - π / 2 ∈ angleIoo (θ₁ - π / 2) (θ₂ - π / 2) :=
    mem_iUnion.mpr ⟨0, by simp only [Int.cast_zero, mul_zero, add_zero]; exact ⟨by linarith, by linarith⟩⟩
  have hL2 : μ - π / 2 + w / 2 ∈ angleIoo (θ₁ - π / 2) (θ₂ - π / 2) :=
    mem_iUnion.mpr ⟨0, by simp only [Int.cast_zero, mul_zero, add_zero]; exact ⟨by linarith, by linarith⟩⟩
  have hR : μ + π / 2 ∈ angleIoo (θ₁ + π / 2) (θ₂ + π / 2) :=
    mem_iUnion.mpr ⟨0, by simp only [Int.cast_zero, mul_zero, add_zero]; exact ⟨by linarith, by linarith⟩⟩
  obtain ⟨d, hdc, hdc', hd, -⟩ := hside _ (Or.inl hL)
  have hdcone : ∀ β ∈ angleIoo (θ₁ - π / 2) (θ₂ - π / 2) ∪ angleIoo (θ₁ + π / 2) (θ₂ + π / 2),
      β ∈ coneAt (F.region d) P := by
    intro β hβ
    obtain ⟨d', h1, h2, hd', hβ'⟩ := hside β hβ
    rwa [huniq d' d h1 h2 hd' hdc hdc' hd] at hβ'
  -- the chart at `P`
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hPd
  have hn : 0 < n := by
    by_contra h0
    push Not at h0
    have h1 := hC.ncard_coloursAt_le
    have h2 : 2 ≤ (F.coloursAt P).ncard := by
      have := ncard_le_ncard (show ({c, c'} : Set (Fin k)) ⊆ F.coloursAt P by
        rintro x (rfl | rfl)
        · exact hc
        · exact hc') (toFinite _)
      rwa [ncard_pair hcc'] at this
    rw [show n = 0 by omega] at h1
    simp only [zero_le, max_eq_right] at h1
    omega
  have hM := hC.sorted.mono
  have hmemS : ∀ r ∈ Ioc 0 r₀, ∀ l, G.sector P r l ⊆ F.region d → G.sector P r l ∈ F.sectorsOf P r d :=
    fun r hr l hl => ⟨(hC.isSector_iff hn hr).mpr ⟨l, rfl⟩, fun z hz => (hl hz).2⟩
  obtain ⟨m, hm⟩ := exists_hasSectors hPd d
  refine ⟨d, m, ?_, hm, ?_⟩
  · -- two `d`-sectors: one would hold both side cones, so the facing or the away interval inside its cone interval
    by_contra hlt
    push Not at hlt
    obtain ⟨r, hrm, hr⟩ := (hm.and (Ioc_mem_nhdsGT hC.pos)).exists
    obtain ⟨i, hi, hisub⟩ := hC.exists_sector_of_mem_coneAt_region hn hr (hdcone _ (Or.inl hL))
    obtain ⟨j, hj, hjsub⟩ := hC.exists_sector_of_mem_coneAt_region hn hr (hdcone _ (Or.inr hR))
    have hij : i = j := by
      by_contra hij
      have h2 : ({G.sector P r i, G.sector P r j} : Set (Set ℂ)) ⊆ F.sectorsOf P r d := by
        rintro S (rfl | rfl)
        · exact hmemS r hr i hisub
        · exact hmemS r hr j hjsub
      have hne : G.sector P r i ≠ G.sector P r j := fun h => by
        obtain ⟨z, hz⟩ := hC.sector_nonempty hr i
        exact disjoint_left.mp (hC.disjoint r hr i j hij) hz (h ▸ hz)
      have := encard_le_encard h2
      rw [encard_pair hne, hrm] at this
      have : (2 : ℕ) ≤ m := by exact_mod_cast this
      omega
    subst hij
    rw [hC.cone r hr i] at hi hj
    obtain ⟨m₁, h11, h12'⟩ := mem_iUnion.mp hi
    obtain ⟨m₂, h21, h22⟩ := mem_iUnion.mp hj
    have hab := hM i
    have hba := hM.nextβ_le_add i
    -- a direction strictly inside sector `i`'s interval lies in no other sector's cone
    have hother : ∀ e' : Fin k, e' ≠ d → ∀ γ ∈ coneAt (F.region e') P, γ ∉ angleIoo (G.β i) (G.nextβ i) := by
      intro e' he' γ hγ hγi
      obtain ⟨j', hj', hj'sub⟩ := hC.exists_sector_of_mem_coneAt_region hn hr hγ
      have hij' : i ≠ j' := by
        rintro rfl
        obtain ⟨z, hz⟩ := hC.sector_nonempty hr i
        have h1 := (hisub hz).2
        have h2 := (hj'sub hz).2
        simp only [mem_preimage, mem_singleton_iff] at h1 h2
        exact he' (h2.symm.trans h1)
      rw [hC.cone r hr j'] at hj'
      exact disjoint_left.mp (hM.disjoint hij') hj' hγi
    have hk1 : (m₂ : ℝ) - m₁ < 2 := by nlinarith
    have hk2 : (-1 : ℝ) < (m₂ : ℝ) - m₁ := by nlinarith
    have hk : m₂ = m₁ ∨ m₂ = m₁ + 1 := by
      have a1 : m₂ - m₁ < 2 := by exact_mod_cast hk1
      have a2 : -1 < m₂ - m₁ := by exact_mod_cast hk2
      omega
    rcases hk with hk | hk
    · -- the facing interval inside: a direction of `c` strictly inside sector `i`'s interval
      obtain ⟨γ, hγ⟩ := coneAt_region_nonempty hc
      obtain ⟨m₃, h31, h32⟩ := mem_iUnion.mp (ringArc_cone_inner hF hA hγ)
      refine hother c (Ne.symm hdc) γ hγ (mem_iUnion.mpr ⟨m₁ + m₃, ?_, ?_⟩)
      · push_cast; linarith
      · rw [hk] at h22; push_cast; linarith
    · -- the away interval inside: a direction of `c'`
      obtain ⟨γ, hγ⟩ := coneAt_region_nonempty hc'
      obtain ⟨m₃, h31, h32⟩ := mem_iUnion.mp (ringArc_cone_outer hF hA hγ)
      refine hother c' (Ne.symm hdc') γ hγ (mem_iUnion.mpr ⟨m₂ + m₃, ?_, ?_⟩)
      · push_cast; linarith
      · rw [hk] at h22 ⊢; push_cast at h22 ⊢; linarith
  · -- the allowed cone has interior: else every `d`-sector is a horn along one axis (`woodallCone`), but `d` holds a side cone
    by_contra hD
    rw [not_nonempty_iff_eq_empty] at hD
    obtain ⟨α, -, -, hev⟩ := woodallCone hF hcov hd hD
    obtain ⟨r, hrS, hr⟩ := (hev.and (Ioc_mem_nhdsGT hC.pos)).exists
    have hdir : ∀ β ∈ angleIoo (θ₁ - π / 2) (θ₂ - π / 2), ∃ n : ℤ, β = α + n * π := by
      intro β hβ
      obtain ⟨i, hi, hisub⟩ := hC.exists_sector_of_mem_coneAt_region hn hr (hdcone β (Or.inl hβ))
      obtain ⟨β', hβ', κ₁, κ₂, -, -, -, hS⟩ := hrS _ (hmemS r hr i hisub)
      rw [hS] at hi
      have he := e_eq_of_mem_coneAt_hornSet hi
      simp only [mem_insert_iff, mem_singleton_iff] at hβ'
      rcases hβ' with rfl | rfl
      · obtain ⟨n, hn⟩ := e_eq_e_iff.mp he
        exact ⟨2 * n, by rw [hn]; push_cast; ring⟩
      · obtain ⟨n, hn⟩ := e_eq_e_iff.mp he
        exact ⟨2 * n + 1, by rw [hn]; push_cast; ring⟩
    obtain ⟨n₁, hn₁⟩ := hdir _ hL
    obtain ⟨n₂, hn₂⟩ := hdir _ hL2
    have h1 : 0 < ((n₂ : ℝ) - n₁) * π := by nlinarith
    have h2 : ((n₂ : ℝ) - n₁) * π < π := by nlinarith
    have a1 : (0 : ℝ) < (n₂ : ℝ) - n₁ := by nlinarith
    have a2 : (n₂ : ℝ) - n₁ < 1 := by nlinarith
    have b1 : 0 < n₂ - n₁ := by exact_mod_cast a1
    have b2 : n₂ - n₁ < 1 := by exact_mod_cast a2
    omega

/-! ## The two steps (the strengthened moves, cleaned) -/

/-- **The vertex step** (MERGE, MERGE-RAY or SHAVE at a site, then `exists_clean`): at a point of a clean valid map where a move is
available, for every bound `δ > 0`, a clean valid modification that is a local step on `B̄(v, ρ)`, `ρ < δ`, in which `v`'s degree
drops, `v` gains no colour, and no other point of the disc is a site. Proof after the merge with `main`: the move's construction
(`exists_merge_aux`, `exists_rayMerge_aux`, `exists_shave_aux` — `Near.move`/`surgery`, whose arcs are `trimArcs` plus new arcs in the
disc: `LocalStep` from `trimArcs_spec`), then `exists_clean` (which drops the kept germs that now have one colour on both sides and
the one-coloured parts of the rim circle — FS131-KL1's finding: without it SHAVE raises `v`'s degree). -/
theorem exists_vertexStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : v ∈ F.dom)
    (hav : F.MergeAvailable v ∨ F.RayAvailable v ∨ F.ShaveAvailable v) {m : ℕ} (hdeg : F.HasDegree v m) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ, 0 < ρ ∧ ρ < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' < m, F'.HasDegree v m') ∧ F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  sorry

/-- **The arc step** (a bend of a maximal bad unit arc, then `exists_clean`): at a maximal unit arc about `P`, neither (Q) nor (R2),
whose side colours are not both carried at `P`, for every `δ > 0` and every locally finite set `T` (the treatment points), a clean
valid modification that is a local step on the closed `ε`-neighbourhood of the arc, `ε < δ`, lowering `P`'s bad count, creating no
site and changing no site's degree, and at every other point of `T` adding no colour and — unless it loses one — raising no bad
count. The toward bend (`bend_toward`) when the outer colour is absent at `P`; else the away bend (`bend_away_whole`, or N2-TAN's
tangent bend on the parts of the arc with no radius-2 witness). **The last clause is FS131-KL1's question (5)** (inventory item 372):
a bend's lens never cuts another arc's (R2) witness — a witness arc `R₂(β)` cannot cross the bent arc's open part, since past it
`R₂(β)` would lie in the outer tile, outside the closure of the inner colour's class (one mind's sketch; this child is its check). -/
theorem exists_arcStep (hF : F.Valid) (hc : F.IsClean) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hmax : F.IsMaxRingArc P θ₁ θ₂ c c') (hQ : ¬ F.IsQArc P θ₁ θ₂) (hR : ¬ F.IsR2Arc P θ₁ θ₂)
    (hnb : ¬ (c ∈ F.coloursAt P ∧ c' ∈ F.coloursAt P)) {T : Set ℂ}
    (hT : ∀ K, IsCompact K → (K ∩ T).Finite) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ε, 0 < ε ∧ ε < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧
      LocalStep F F' (cthickening ε (ringArc P θ₁ θ₂)) ∧ F.IsModification F' ∧
      F'.badCount P < F.badCount P ∧ (∀ x, F'.IsSite x → F.IsSite x) ∧
      (∀ x m, F.HasDegree x m → F'.HasDegree x m) ∧
      ∀ Q ∈ T, Q ≠ P → F'.coloursAt Q ⊆ F.coloursAt Q ∧
        (F'.coloursAt Q = F.coloursAt Q → F'.badCount Q ≤ F.badCount Q) := by
  sorry

/-! ## The procedure and the terminal map -/

/-- **The procedure** (N4-TERM's enumeration with N2-RED's bends): from a clean valid plane map, a locally finite sequence of local
steps through clean valid modifications, after which, at every point, from some stage on, no move is available and every unit arc
about it is (Q) or (R2). Enumerate `treatPts F` (countable: `treatPts_inter_finite`); at each stage act at the least-index point with
something to do (an available move: `exists_vertexStep`; else a bad maximal arc, whose sides are then not both at `P` by
`mergeAvailable_of_bothKind`: `exists_arcStep`), with the step's radius below a third of the distance to the other treatment points
nearby; idle (`LocalStep.refl`) if nothing is left. Each point is acted on finitely often (degree; bad count between its finitely
many rises), so the supports are locally finite, and a point with something to do from some stage on would be chosen infinitely
often. -/
theorem exists_terminalSeq (hF : F.Valid) (hP : F.IsPlaneMap) (hc : F.IsClean) :
    ∃ S : LocalSeq k, S.F 0 = F ∧ (∀ n, (S.F n).Valid ∧ F.IsModification (S.F n)) ∧
      ∀ v, ∀ᶠ n in atTop, ¬ (S.F n).MergeAvailable v ∧ ¬ (S.F n).RayAvailable v ∧ ¬ (S.F n).ShaveAvailable v ∧
        ∀ θ₁ θ₂ c c', (S.F n).IsRingArc v θ₁ θ₂ c c' → (S.F n).IsQArc v θ₁ θ₂ ∨ (S.F n).IsR2Arc v θ₁ θ₂ := by
  sorry

/-- **Every valid map of the plane has a modification that is a terminal valid map** (FS112-N2-TERM's construction, every `k`; the
shorter route of FS131-KL1, inventory item 372: `exists_red` and `exists_terminal` are read off it). Clean (`exists_clean`), run the
procedure (`exists_terminalSeq`), take the limit (`LocalSeq.limit_isModification`, `LocalSeq.limit_isTerminalMap`). Inhabitant of the
hypotheses: `sevenBrickMap` at seven colours (`sevenBrickMap_valid`, `sevenBrickMap_isPlaneMap`). -/
theorem exists_terminalMap (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ M : ArcMap k, F.IsModification M ∧ M.IsTerminalMap := by
  obtain ⟨F₀, hc, hF₀, hmod₀, -, -⟩ := exists_clean hF
  have hP₀ : F₀.IsPlaneMap := by
    show F₀.dom = univ
    rw [hmod₀.dom_eq]; exact hP
  obtain ⟨S, hS0, hS, hev⟩ := exists_terminalSeq hF₀ hP₀ hc
  have hmod : ∀ n, (S.F 0).IsModification (S.F n) := fun n => by rw [hS0]; exact (hS n).2
  have hlim := S.limit_isModification hmod
  rw [hS0] at hlim
  exact ⟨S.limit, hmod₀.trans hlim, S.limit_isTerminalMap (by rw [hS0]; exact hP₀) (fun n => (hS n).1) hev⟩

end ArcMap

/-! ### Spec examples -/

section Spec

open ArcMap

/-- The one-colour plane has no ring arc, so no maximal one (a spec example for `IsMaxRingArc`). -/
example (j : Fin 2) (P : ℂ) (θ₁ θ₂ : ℝ) (c c' : Fin 2) :
    ¬ (ArcMap.const univ isOpen_univ j).IsMaxRingArc P θ₁ θ₂ c c' := by
  rintro ⟨⟨h12, hsub, -⟩, -⟩
  have := hsub ⟨θ₁, ⟨le_rfl, h12.le⟩, rfl⟩
  simp [ArcMap.Γ, ArcMap.const] at this

/-- The one-colour plane's bad count is `0` everywhere (a spec example for `badCount`). -/
example (j : Fin 2) (P : ℂ) : (ArcMap.const univ isOpen_univ j).badCount P = 0 := by
  rw [ArcMap.badCount, encard_eq_zero, eq_empty_iff_forall_notMem]
  rintro ⟨θ₁, θ₂⟩ ⟨c, c', ⟨⟨h12, hsub, -⟩, -⟩, -⟩
  have := hsub ⟨θ₁, ⟨le_rfl, h12.le⟩, rfl⟩
  simp [ArcMap.Γ, ArcMap.const] at this

/-- **Adversary**: the centre of `unitArcPlane`'s unit arc is a treatment point (a spec example for `treatPts`: the centres of
unit arcs are in it). -/
example : (0 : ℂ) ∈ unitArcPlane.treatPts := by
  refine Or.inr ⟨ringPt 0 0, 0, π, pi_pos, ⟨0, ⟨le_rfl, pi_pos.le⟩, rfl⟩, ?_⟩
  rintro _ ⟨θ, hθ, rfl⟩
  refine ⟨mem_univ _, mem_biUnion (mem_singleton _) ⟨θ, hθ, ?_⟩⟩
  simp [ringPt]

/-- The one-colour plane has no treatment point: no unit arc, and at each point the one sector is the ball, so no repeated
colour and no horn (a spec example for `treatPts`). -/
example (j : Fin 2) : (ArcMap.const univ isOpen_univ j).treatPts = ∅ := by
  set F := ArcMap.const univ isOpen_univ j with hFdef
  have hsec : ∀ v r S, 0 < r → F.IsSector v r S → S = ball v r := by
    rintro v r S hr ⟨x, hx, rfl, -⟩
    have hI : F.interiorPts ∩ ball v r = ball v r := by rw [hFdef, const_interiorPts, univ_inter]
    rw [hI] at hx ⊢
    exact (convex_ball v r).isPreconnected.connectedComponentIn hx
  refine eq_empty_iff_forall_notMem.mpr fun v hv => ?_
  rcases hv with ⟨-, ⟨c, hc⟩ | ⟨α, κ₁, κ₂, c, -, hH⟩⟩ | ⟨x, θ₁, θ₂, h12, -, hsub⟩
  · obtain ⟨r, hr2, hr⟩ := (hc.and self_mem_nhdsWithin).exists
    have hle : (F.sectorsOf v r c).encard ≤ 1 := by
      refine (encard_le_encard (show F.sectorsOf v r c ⊆ {ball v r} from fun S hS =>
        hsec v r S hr hS.1)).trans (by rw [encard_singleton])
    have := hr2.trans hle
    norm_num at this
  · obtain ⟨r, ⟨hS, -⟩, hr⟩ := (hH.and self_mem_nhdsWithin).exists
    have hr : (0 : ℝ) < r := hr
    have heq := hsec v r _ hr hS
    have hm : v - ((r / 2 : ℝ) : ℂ) * e α ∈ ball v r := by
      rw [mem_ball, dist_eq_norm, sub_sub_cancel_left, norm_neg, norm_mul_e (by positivity)]; linarith
    rw [← heq] at hm
    have hx := hm.2.1
    simp only [frameX, sub_sub_cancel_left, neg_mul, mul_assoc, conj_e_mul_e, mul_one, Complex.neg_re,
      Complex.ofReal_re] at hx
    linarith
  · have := hsub ⟨θ₁, ⟨le_rfl, h12.le⟩, rfl⟩
    simp [hFdef, ArcMap.Γ, ArcMap.const] at this

end Spec

end HadwigerNelson.Plane
