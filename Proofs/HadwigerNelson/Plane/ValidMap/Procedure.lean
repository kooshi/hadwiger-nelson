import Proofs.HadwigerNelson.Plane.ValidMap.Limit
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc
import Proofs.HadwigerNelson.Plane.ValidMap.OpenMove
import Proofs.HadwigerNelson.Plane.ValidMap.FlankUA

/-!
# The terminal procedure: FS112-N2-RED's bends with FS110-N4-TERM's moves, as one locally finite sequence (FS131-KL1)

Wave 5's construction behind `exists_red` and `exists_terminal` (`plans/FS131-limit-kernel-plan.md` §§ 3–4): **every valid map of the
plane has a modification that is a terminal valid map** (`exists_terminalMap`, every `k`). Clean the map (`exists_clean`), then run
one procedure over its *treatment points* (`treatPts`: the sites and the centres of unit arcs, never created afterwards): at the
least-index point with something to do, apply a **vertex step** (MERGE, MERGE-RAY, SHAVE or OPEN at a site, then cleaned: its
potential, degree plus number of horns, drops — FS131-E6-ROUTE, inventory items 382–385; `exists_vertexStep`) or an **arc step** (a
toward or away bend of a maximal bad unit arc, then cleaned: the point's count of maximal bad arcs drops, `exists_arcStep`). A site is
the centre of at most its initial potential many vertex steps; a centre's bad count rises only at the finitely many vertex steps
within distance `4` and at the at most `k` stages where it loses a colour, so it too is treated finitely often
(`exists_terminalSeq`). The supports are then locally finite, and the limit (`Plane/ValidMap/Limit`) is the terminal map.

**Where the steps' proofs live** (inventory items 371–372, 411): `exists_vertexStep` and `exists_arcStep` read the moves' constructions —
`Moves` (`exists_shave_aux`, `exists_rayMerge_aux` through `Near.move`), `MergeMove` (`exists_merge_aux`), `OpenMove` (`exists_open`) and
`UnitArc` (`bend_toward`, `bend_away_whole`, the N2-TAN bend) — each cleaned with its colour kept (`cleanKeep`, `LocalStep.cleanKeep`:
`ArcMap.clean` itself is no local step, its colour function being a choice on the arcs); they are stated here and are open until
proved from those constructions (the plan's § 3.3; new declarations downstream only). A move's surgery is a local step on its closed
ball (`surgery_localStep`).
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

/-- **Finitely many maximal arcs about a point** of a valid map of the plane: the ends of a maximal arc are irregular angles of the
ring (`IsMaxRingArc.not_regularAt`), finitely many in a bounded range (`finite_not_regular`), and a maximal arc starts in `[0, 2π)` and
is at most `60°` long (`l60_le`). The plane hypothesis (inventory item 380) gives `ω(P)` in the domain; no cleanness is needed (its
hypothesis dropped by inventory item 389 (a)). -/
theorem badCount_lt_top (hF : F.Valid) (hP : F.IsPlaneMap) (P : ℂ) : F.badCount P < ⊤ := by
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

/-! ## Cleaning a step: the clean map with the colour kept on the essential set (FS131-IR1)

The steps are "a move, then cleaned". `exists_clean` alone gives no `LocalStep`, and `ArcMap.clean` itself cannot be the cleaned step:
it sets the colour function to `cleanCol` at every point, and at a point of two colours `cleanCol` is a choice among them that nothing
ties to the colour function before the step — while `LocalStep` (through `AgreesOff`) compares the colour functions at every point
off the support, the points of arcs included. `cleanKeep` changes the colour function only on the new interior; then a local step
from a clean map, on a closed support, stays a local step after cleaning (`LocalStep.cleanKeep`). -/

/-- A non-degenerate arc is its own sub-arc over its whole parameter interval. -/
theorem _root_.HadwigerNelson.Plane.Arc.exists_params_eq_Icc {a : Arc} (ha : a.Nondegenerate) :
    ∃ lo hi : ℝ, lo < hi ∧ a.params = Icc lo hi ∧ a.sub lo hi = a := by
  cases a with
  | seg p q => exact ⟨0, 1, zero_lt_one, rfl, by simp [Arc.sub]⟩
  | circ c R θ₀ θ₁ => exact ⟨θ₀, θ₁, ha.2.1, rfl, rfl⟩

/-- The order-connected component of a point of a closed interval in it is the interval. -/
theorem _root_.HadwigerNelson.Plane.ordConnectedComponent_Icc {lo hi u : ℝ} (hu : u ∈ Icc lo hi) : (Icc lo hi).ordConnectedComponent u = Icc lo hi := by
  ext y
  rw [mem_ordConnectedComponent]
  exact ⟨fun h => h right_mem_uIcc, fun hy => ordConnected_Icc.uIcc_subset hu hy⟩

open scoped Classical in
variable (F) in
/-- **The clean map with `F`'s colour kept off the new interior** (`ArcMap.clean` with the colour function changed only where the
clean map reads it): `F`'s domain, the clean arcs, the clean colour at the points of one colour and `F.col` elsewhere. `ArcMap.clean`
sets the colour function to `cleanCol` everywhere, so on an arc far from a step it need not agree with the map before the step —
and `LocalStep` (through `AgreesOff`) compares the colour functions at every point off the support, the points of arcs included.
This variant is the cleaned step (`LocalStep.cleanKeep`). -/
noncomputable def cleanKeep : ArcMap k where
  dom := F.dom
  isOpen_dom := F.isOpen_dom
  arcs := F.cleanArcs
  nondegenerate := fun _ hb => cleanArcs_nondegenerate hb
  locallyFinite := fun _ hx => cleanArcs_locallyFinite hx
  col := fun z => if z ∈ F.dom \ F.essSet then F.cleanCol z else F.col z
  locallyConstant := by
    intro x hx hxn
    have hxE : x ∉ F.essSet := fun h => hxn (essSet_subset_cleanArcs h)
    have hmem : ∀ᶠ y in 𝓝 x, y ∈ F.dom \ F.essSet := isOpen_dom_diff_essSet.mem_nhds ⟨hx, hxE⟩
    filter_upwards [F.clean.locallyConstant x hx hxn, hmem] with y hy hyd
    rw [if_pos hyd, if_pos (show x ∈ F.dom \ F.essSet from ⟨hx, hxE⟩)]
    exact hy

/-- The kept-colour clean map has the clean map's `Γ`. -/
theorem cleanKeep_Γ : F.cleanKeep.Γ = F.essSet := clean_Γ

/-- The kept-colour clean map has the clean map's interior points. -/
theorem cleanKeep_interiorPts : F.cleanKeep.interiorPts = F.dom \ F.essSet := clean_interiorPts

/-- At its interior points the kept-colour clean map has the clean colour. -/
theorem cleanKeep_col {z : ℂ} (hz : z ∈ F.dom \ F.essSet) : F.cleanKeep.col z = F.cleanCol z := by
  classical
  show (if z ∈ F.dom \ F.essSet then F.cleanCol z else F.col z) = _
  rw [if_pos hz]

/-- Off its interior points the kept-colour clean map keeps `F`'s colour function. -/
theorem cleanKeep_col_of_not_mem {z : ℂ} (hz : z ∉ F.dom \ F.essSet) : F.cleanKeep.col z = F.col z := by
  classical
  show (if z ∈ F.dom \ F.essSet then F.cleanCol z else F.col z) = _
  rw [if_neg hz]

/-- The kept-colour clean map has the clean map's colour classes. -/
theorem cleanKeep_region (j : Fin k) : F.cleanKeep.region j = F.clean.region j := by
  ext z
  show z ∈ F.cleanKeep.interiorPts ∧ F.cleanKeep.col z ∈ ({j} : Set (Fin k)) ↔
    z ∈ F.clean.interiorPts ∧ F.clean.col z ∈ ({j} : Set (Fin k))
  rw [cleanKeep_interiorPts, clean_interiorPts]
  refine and_congr_right fun hz => ?_
  rw [cleanKeep_col hz]
  rfl

/-- **The kept-colour clean map keeps the colours at every point.** -/
theorem coloursAt_cleanKeep (x : ℂ) : F.cleanKeep.coloursAt x = F.coloursAt x := by
  have h : F.cleanKeep.coloursAt x = F.clean.coloursAt x := by
    ext j
    show x ∈ closure (F.cleanKeep.region j) ↔ x ∈ closure (F.clean.region j)
    rw [cleanKeep_region]
  rw [h, coloursAt_clean]

/-- The kept-colour clean map of a valid map is valid. -/
theorem cleanKeep_valid (hF : F.Valid) : F.cleanKeep.Valid := by
  intro x hx y hy hxy
  rw [cleanKeep_interiorPts] at hx hy
  rw [cleanKeep_col hx, cleanKeep_col hy]
  exact clean_valid hF x (clean_interiorPts ▸ hx) y (clean_interiorPts ▸ hy) hxy

/-- The kept-colour clean map is clean. -/
theorem cleanKeep_isClean : F.cleanKeep.IsClean := by
  intro x hx
  rw [cleanKeep_Γ] at hx
  rw [coloursAt_cleanKeep]
  exact hx.2

/-- The kept-colour clean map is a modification. -/
theorem cleanKeep_isModification : F.IsModification F.cleanKeep :=
  ⟨rfl, fun _ _ ⟨θ₁, θ₂, h12, hx, hsub⟩ => ⟨θ₁, θ₂, h12, hx, hsub.trans (cleanKeep_Γ.symm ▸ essSet_subset_Γ)⟩,
    fun x _ => (coloursAt_cleanKeep x).subset⟩

/-- **Off the closed support of a step from a clean map, every parameter of an arc of the old map is essential in the new one**
(its point, where it lies in the domain, carries its two old colours). -/
theorem essParams_eq_params_of_disjoint {F' : ArcMap k} {U : Set ℂ} (hc : F.IsClean) (hU : IsClosed U)
    (h : F'.AgreesOff F U) {a : Arc} (ha : a ∈ F.arcs) (hd : Disjoint a.carrier U) : F'.essParams a = a.params := by
  refine Subset.antisymm (fun t ht => ht.1) fun t ht => ⟨ht, ?_⟩
  have hta : a.pt t ∈ a.carrier := by rw [a.carrier_eq_image]; exact ⟨t, ht, rfl⟩
  have htU : a.pt t ∉ U := fun hU' => Set.disjoint_left.mp hd hta hU'
  by_cases htd : a.pt t ∈ F'.dom
  · refine Or.inr ⟨htd, ?_⟩
    have hΓ : a.pt t ∈ F.Γ := ⟨h.1 ▸ htd, mem_biUnion ha hta⟩
    rw [coloursAt_eq_of_agreesOn (W := Uᶜ) (by rwa [compl_compl]) hU.isOpen_compl htU]
    exact hc _ hΓ
  · exact Or.inl htd

/-- **Cleaning a step.** A local step from a clean map, on a closed support, is still a local step after the new map is cleaned
with its colour kept (`cleanKeep`): off the support the new interior is the old one (the old map is clean), with its colours; an
old arc missing the support stays whole (each of its points keeps its two colours); a clean arc is a piece of an arc of the step.
Inhabitant of the hypotheses: the idle step of a clean map (`LocalStep.refl`; the spec example below). -/
theorem LocalStep.cleanKeep {F' : ArcMap k} {U : Set ℂ} (hc : F.IsClean) (hU : IsClosed U) (h : LocalStep F F' U) :
    LocalStep F F'.cleanKeep U where
  agreesOff := by
    refine ⟨h.agreesOff.1, fun z hz => ?_⟩
    have hcol : F'.coloursAt z = F.coloursAt z :=
      coloursAt_eq_of_agreesOn (W := Uᶜ) (by rw [compl_compl]; exact h.agreesOff) hU.isOpen_compl hz
    have hiff : z ∈ F.interiorPts ↔ z ∈ F'.dom \ F'.essSet := by
      constructor
      · intro hzI
        refine ⟨h.agreesOff.1 ▸ hzI.1, fun hE => ?_⟩
        have h2 := hE.2
        rw [hcol, coloursAt_eq_singleton_of_interior hzI, ncard_singleton] at h2
        omega
      · rintro ⟨hzd, hzE⟩
        have hzd' : z ∈ F.dom := h.agreesOff.1 ▸ hzd
        by_contra hzI
        exact hzE ⟨hzd, hcol ▸ hc z ((mem_Γ_iff F).mpr ⟨hzd', hzI⟩)⟩
    rw [cleanKeep_interiorPts]
    refine ⟨hiff, ?_⟩
    by_cases hzm : z ∈ F'.dom \ F'.essSet
    · rw [cleanKeep_col hzm]
      exact (cleanCol_eq (hcol.trans (coloursAt_eq_singleton_of_interior (hiff.mpr hzm)))).symm
    · rw [cleanKeep_col_of_not_mem hzm]
      exact (h.agreesOff.2 z hz).2
  keep := by
    intro a ha hd
    obtain ⟨lo, hi, hlt, hpar, hsub⟩ := Arc.exists_params_eq_Icc (F.nondegenerate a ha)
    have hess := essParams_eq_params_of_disjoint hc hU h.agreesOff ha hd
    have hlo : lo ∈ Icc lo hi := ⟨le_rfl, hlt.le⟩
    refine ⟨a, h.keep a ha hd, lo, by rw [hess, hpar]; exact hlo, ?_, ?_⟩ <;>
      rw [hess, hpar, ordConnectedComponent_Icc hlo, csInf_Icc hlt.le, csSup_Icc hlt.le]
    · exact hlt
    · exact hsub.symm
  new := by
    rintro b ⟨a', ha', u, hu, hlt, rfl⟩ hbF
    have hsub : (a'.sub (sInf ((F'.essParams a').ordConnectedComponent u))
        (sSup ((F'.essParams a').ordConnectedComponent u))).carrier ⊆ a'.carrier := by
      rw [a'.carrier_sub hlt.le, a'.carrier_eq_image, ← essComp_eq_Icc a' hu]
      exact image_mono fun t ht => (ordConnectedComponent_subset ht).1
    by_cases haF : a' ∈ F.arcs
    · by_cases hd : Disjoint a'.carrier U
      · exfalso
        obtain ⟨lo, hi, hlt', hpar, hsub'⟩ := Arc.exists_params_eq_Icc (F.nondegenerate a' haF)
        have hess := essParams_eq_params_of_disjoint hc hU h.agreesOff haF hd
        have hu' : u ∈ Icc lo hi := by rw [← hpar, ← hess]; exact hu
        apply hbF
        rw [hess, hpar, ordConnectedComponent_Icc hu', csInf_Icc hlt'.le, csSup_Icc hlt'.le, hsub']
        exact haF
      · exact Or.inr ⟨a', haF, Set.not_disjoint_iff_nonempty_inter.mp hd, hsub⟩
    · rcases h.new a' ha' haF with hU' | ⟨a, ha, hne, hsub'⟩
      · exact Or.inl (hsub.trans hU')
      · exact Or.inr ⟨a, ha, hne, hsub.trans hsub'⟩

/-- **A cleaned step exists**: a local step from a clean map to a valid map, on a closed support, has a clean valid form that is
still a local step on that support, with the same colours at every point and no new point of `Γ` (the witness: `cleanKeep`). -/
theorem LocalStep.exists_clean {F' : ArcMap k} {U : Set ℂ} (hc : F.IsClean) (hU : IsClosed U) (hF' : F'.Valid)
    (h : LocalStep F F' U) :
    ∃ F'' : ArcMap k, F''.IsClean ∧ F''.Valid ∧ LocalStep F F'' U ∧ F'.IsModification F'' ∧
      (∀ x, F''.coloursAt x = F'.coloursAt x) ∧ F''.Γ ⊆ F'.Γ :=
  ⟨F'.cleanKeep, cleanKeep_isClean, cleanKeep_valid hF', h.cleanKeep hc hU, cleanKeep_isModification, coloursAt_cleanKeep,
    cleanKeep_Γ.symm ▸ essSet_subset_Γ⟩

/-- **A surgery is a local step on its closed ball** (the moves' constructions — MERGE's and OPEN's `surgery`, MERGE-RAY's and
SHAVE's `Near.move` — are all of this form, their new arcs inside the closed ball: `mergeArcs_subset_closedBall`,
`openArcs_subset_closedBall`, `newArcs_subset_closedBall`): an arc of `F` missing the closed ball misses `v` and is kept whole by
`trimArcs`; a trimmed arc that is not an arc of `F` is an outer piece of an arc through `v`; a new arc lies in the closed ball. Inhabitants of the hypotheses:
each move's construction, e.g. OPEN's (`openArcs_subset_closedBall`, and its colouring off the ball as in `Near.open_agreesOff`). -/
theorem surgery_localStep {v : ℂ} {ρ : ℝ} {A : Set Arc} {col' : ℂ → Fin k} {hv : v ∈ F.dom} {hρ : 0 < ρ}
    {hA : ∀ a ∈ A, a.Nondegenerate} {hAf : A.Finite}
    {hlc : ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ A, a.carrier → ∀ᶠ y in 𝓝 x, col' y = col' x}
    (hAin : ∀ a ∈ A, a.carrier ⊆ closedBall v ρ) (hcol : ∀ z ∉ closedBall v ρ, col' z = F.col z) :
    LocalStep F (F.surgery v ρ A col' hv hρ hA hAf hlc) (closedBall v ρ) where
  agreesOff := surgery_agreesOff hAin hcol
  keep := fun a ha hd => Or.inl (Or.inl ⟨ha, fun hva => Set.disjoint_left.mp hd hva (mem_closedBall_self hρ.le)⟩)
  new := by
    rintro b (hb | hb) hbF
    · rcases hb with ⟨hb, -⟩ | hb
      · exact absurd hb hbF
      · obtain ⟨a, ⟨ha, hva⟩, hba⟩ := mem_iUnion₂.mp hb
        obtain ⟨h1, -⟩ := Arc.outer_spec (F.nondegenerate a ha) hva hρ
        exact Or.inr ⟨a, ha, ⟨v, hva, mem_closedBall_self hρ.le⟩, (h1 b hba).2.1⟩
    · exact Or.inl (hAin b hb)

/-- **A cleaned surgery is a local step on its closed ball**, from a clean map (`surgery_localStep`, `LocalStep.cleanKeep`): the form
in which each of the four moves enters `exists_vertexStep`. -/
theorem surgery_cleanKeep_localStep (hc : F.IsClean) {v : ℂ} {ρ : ℝ} {A : Set Arc} {col' : ℂ → Fin k} {hv : v ∈ F.dom} {hρ : 0 < ρ}
    {hA : ∀ a ∈ A, a.Nondegenerate} {hAf : A.Finite}
    {hlc : ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ A, a.carrier → ∀ᶠ y in 𝓝 x, col' y = col' x}
    (hAin : ∀ a ∈ A, a.carrier ⊆ closedBall v ρ) (hcol : ∀ z ∉ closedBall v ρ, col' z = F.col z) :
    LocalStep F (F.surgery v ρ A col' hv hρ hA hAf hlc).cleanKeep (closedBall v ρ) :=
  (surgery_localStep hAin hcol).cleanKeep hc isClosed_closedBall

/-! ## Comparing the sectors of two maps at a point: the potential under a step (FS131-IR2)

The vertex step's count. A step's cleaned map is compared with the map before it through their sectors at one radius, as sets:
if every sector of the new map contains a sector of the old one, the new map has at most as many sectors and at most as many horns
(`pot_le_of_sectors`: distinct sectors are disjoint, and a chart sector inside a horn set is a horn set); if moreover one old
sector is never needed, the degree drops (`pot_lt_of_sectors`). Cleaning is the first case (`cleanKeep_pot_le`: a sector of the
cleaned map is a union of chart sectors of one colour and the germs between them, so it contains one); a move that keeps every old
interior point interior and makes one old germ interior is the second (`pot_lt_of_interior`). No chart of the new map is built. -/

/-- With at least two germs, the next germ is another germ. -/
theorem _root_.HadwigerNelson.Plane.BranchGerms.next_ne_self {n : ℕ} (hn : 2 ≤ n) (p : Fin n) : BranchGerms.next p ≠ p := by
  intro h
  have h' := congrArg Fin.val h
  rw [BranchGerms.next] at h'
  split_ifs at h' with h1
  · simp at h'
  · simp at h'; omega

/-- Two sectors at one radius that meet are equal. -/
theorem IsSector.eq_of_inter_nonempty {v : ℂ} {r : ℝ} {S S' : Set ℂ} (h : F.IsSector v r S)
    (h' : F.IsSector v r S') (hne : (S ∩ S').Nonempty) : S = S' := by
  obtain ⟨x, -, rfl, -⟩ := h
  obtain ⟨x', -, rfl, -⟩ := h'
  obtain ⟨z, hz, hz'⟩ := hne
  exact (connectedComponentIn_eq hz).trans (connectedComponentIn_eq hz').symm

/-- **Counting sectors by containment**: if each sector of `F₂` in a family `𝒜` contains a sector of `F₁` in a family `ℬ`, then
`𝒜` has at most as many members as `ℬ` (the contained sectors are distinct: sectors of `F₂` are disjoint). -/
theorem encard_le_of_forall_exists_subset {F₁ F₂ : ArcMap k} {v : ℂ} {r : ℝ} {𝒜 ℬ : Set (Set ℂ)}
    (h𝒜 : ∀ S ∈ 𝒜, F₂.IsSector v r S) (hℬ : ∀ S ∈ ℬ, F₁.IsSector v r S)
    (h : ∀ S₂ ∈ 𝒜, ∃ S₁ ∈ ℬ, S₁ ⊆ S₂) : 𝒜.encard ≤ ℬ.encard := by
  classical
  choose! f hf using h
  refine encard_le_encard_of_injOn (fun S hS => (hf S hS).1) fun S hS S' hS' hSS' => ?_
  obtain ⟨z, hz⟩ := (hℬ _ (hf S hS).1).nonempty
  exact (h𝒜 S hS).eq_of_inter_nonempty (h𝒜 S' hS') ⟨z, (hf S hS).2 hz, (hf S' hS').2 (hSS' ▸ hz)⟩

/-- **A sector inside a horn set is a horn set** (at a chart radius: `Near.horn_of_sector_subset_hornSet`; with no germ the one
sector is the ball, which holds `v`). -/
theorem IsSector.hornSet_of_subset {v : ℂ} (X : F.Near v) {r : ℝ} (hr : r ∈ Ioc 0 X.r₀) {S : Set ℂ}
    (hS : F.IsSector v r S) {α a b : ℝ} (hsub : S ⊆ hornSet v α a b r) :
    ∃ α' κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v α' κ₁ κ₂ r := by
  rcases Nat.eq_zero_or_pos X.n with hn | hn
  · exfalso
    have hball := (X.hC.isSector_iff_of_zero hn hr).mp hS
    have hv' : v ∈ hornSet v α a b r := hsub (hball ▸ mem_ball_self hr.1)
    have := hv'.2.1
    simp [frameX] at this
  · obtain ⟨i, rfl⟩ := (X.hC.isSector_iff hn hr).mp hS
    obtain ⟨-, -, hlt, hsec⟩ := X.horn_of_sector_subset_hornSet hr hsub
    exact ⟨α, _, _, hlt, hsec r hr⟩

/-- The two counts at one chart radius: sectors against a family `ℬ` of old sectors, and horn sectors against horn sectors. -/
theorem encard_sectors_le_aux {F₁ F₂ : ArcMap k} {v : ℂ} (X : F₁.Near v) {r : ℝ} (hr : r ∈ Ioc 0 X.r₀) {ℬ : Set (Set ℂ)}
    (hℬ : ∀ S ∈ ℬ, F₁.IsSector v r S) (h : ∀ S₂, F₂.IsSector v r S₂ → ∃ S₁ ∈ ℬ, S₁ ⊆ S₂) :
    {S | F₂.IsSector v r S}.encard ≤ ℬ.encard ∧
      {S | F₂.IsSector v r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v α κ₁ κ₂ r}.encard ≤
        {S | F₁.IsSector v r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v α κ₁ κ₂ r}.encard := by
  refine ⟨encard_le_of_forall_exists_subset (fun S hS => hS) hℬ fun S₂ hS₂ => h S₂ hS₂, ?_⟩
  refine encard_le_of_forall_exists_subset (F₁ := F₁) (F₂ := F₂) (fun S hS => hS.1) (fun S hS => hS.1) ?_
  rintro S₂ ⟨hS₂, α, κ₁, κ₂, -, rfl⟩
  obtain ⟨S₁, hS₁, hsub⟩ := h _ hS₂
  exact ⟨S₁, ⟨hℬ S₁ hS₁, IsSector.hornSet_of_subset X hr (hℬ S₁ hS₁) hsub⟩, hsub⟩

/-- **The potential does not rise** when, at every small radius, every sector of `F₂` at `v` contains a sector of `F₁`: neither
the degree nor the horn count rises. -/
theorem pot_le_of_sectors {F₁ F₂ : ArcMap k} {v : ℂ} (hv : v ∈ F₁.dom)
    (h : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ S₂, F₂.IsSector v r S₂ → ∃ S₁, F₁.IsSector v r S₁ ∧ S₁ ⊆ S₂)
    {m₁ j₁ m₂ j₂ : ℕ} (hm₁ : F₁.HasDegree v m₁) (hj₁ : F₁.HasHornCount v j₁) (hm₂ : F₂.HasDegree v m₂)
    (hj₂ : F₂.HasHornCount v j₂) : m₂ ≤ m₁ ∧ j₂ ≤ j₁ := by
  obtain ⟨X⟩ := exists_near hv
  obtain ⟨r, ⟨⟨⟨⟨h, h1⟩, h2⟩, h3⟩, h4⟩, hr⟩ :=
    (((((h.and hm₁).and hj₁).and hm₂).and hj₂).and (Ioc_mem_nhdsGT X.hC.pos)).exists
  have key := encard_sectors_le_aux X hr (ℬ := {S | F₁.IsSector v r S}) (fun S hS => hS) h
  rw [h1, h2, h3, h4] at key
  exact ⟨by exact_mod_cast key.1, by exact_mod_cast key.2⟩

/-- **The potential drops** when, at every small radius, some sector `H` of `F₁` at `v` is such that every sector of `F₂` contains
a sector of `F₁` other than `H`: the degree drops and the horn count does not rise. -/
theorem pot_lt_of_sectors {F₁ F₂ : ArcMap k} {v : ℂ} (hv : v ∈ F₁.dom)
    (h : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∃ H, F₁.IsSector v r H ∧
      ∀ S₂, F₂.IsSector v r S₂ → ∃ S₁, F₁.IsSector v r S₁ ∧ S₁ ≠ H ∧ S₁ ⊆ S₂)
    {m₁ j₁ m₂ j₂ : ℕ} (hm₁ : F₁.HasDegree v m₁) (hj₁ : F₁.HasHornCount v j₁) (hm₂ : F₂.HasDegree v m₂)
    (hj₂ : F₂.HasHornCount v j₂) : m₂ + j₂ < m₁ + j₁ := by
  obtain ⟨X⟩ := exists_near hv
  obtain ⟨r, ⟨⟨⟨⟨⟨H, hH, h⟩, h1⟩, h2⟩, h3⟩, h4⟩, hr⟩ :=
    (((((h.and hm₁).and hj₁).and hm₂).and hj₂).and (Ioc_mem_nhdsGT X.hC.pos)).exists
  have key := encard_sectors_le_aux X hr (ℬ := {S | F₁.IsSector v r S} \ {H}) (fun S hS => hS.1)
    (fun S₂ hS₂ => by obtain ⟨S₁, a, b, c⟩ := h S₂ hS₂; exact ⟨S₁, ⟨a, b⟩, c⟩)
  have hH1 : ({S | F₁.IsSector v r S} \ {H}).encard + 1 = m₁ := by
    rw [encard_sdiff_singleton_add_one (show H ∈ {S | F₁.IsSector v r S} from hH), h1]
  rw [h3, h4, h2] at key
  have h5 : (m₂ : ℕ∞) + 1 ≤ m₁ := by rw [← hH1]; gcongr; exact key.1
  have h6 : m₂ + 1 ≤ m₁ := by exact_mod_cast h5
  have h7 : j₂ ≤ j₁ := by exact_mod_cast key.2
  omega

/-- **Every sector of `F₂` contains a sector of `F₁`** when the interior points of `F₁` near `v` are interior points of `F₂`: an
open set of the ball holds an interior point of `F₁`, whose component is a chart sector of `F₁`, connected and interior to `F₂`. -/
theorem exists_isSector_subset {F₁ F₂ : ArcMap k} {v : ℂ} (X : F₁.Near v) {r : ℝ} (hr : r ∈ Ioc 0 X.r₀)
    (hsub : F₁.interiorPts ∩ ball v r ⊆ F₂.interiorPts) {S₂ : Set ℂ} (hS₂ : F₂.IsSector v r S₂) :
    ∃ S₁, F₁.IsSector v r S₁ ∧ S₁ ⊆ S₂ := by
  obtain ⟨x, hx, rfl, -⟩ := hS₂
  have hopen : IsOpen (connectedComponentIn (F₂.interiorPts ∩ ball v r) x) :=
    (F₂.isOpen_interiorPts.inter isOpen_ball).connectedComponentIn
  have hxd : x ∈ F₁.dom := X.hC.subdom (ball_subset_ball hr.2 hx.2)
  obtain ⟨z, hz, hzI⟩ := mem_closure_iff.mp (F₁.dense_interiorPts hxd) _ hopen (mem_connectedComponentIn hx)
  have hzb : z ∈ ball v r := (connectedComponentIn_subset _ _ hz).2
  have hzU : z ∈ F₁.interiorPts ∩ ball v r := ⟨hzI, hzb⟩
  refine ⟨connectedComponentIn (F₁.interiorPts ∩ ball v r) z, ⟨z, hzU, rfl, ?_⟩, ?_⟩
  · rcases Nat.eq_zero_or_pos X.n with hn | hn
    · have hball : ball v r ⊆ F₁.interiorPts ∩ ball v r := fun y hy =>
        ⟨X.hC.empty hn (ball_subset_ball hr.2 hy), hy⟩
      exact subset_closure ((convex_ball v r).isPreconnected.subset_connectedComponentIn hzb hball (mem_ball_self hr.1))
    · have hz' : z ∈ ⋃ i, X.G.sector v r i := by rw [← X.hC.cover r hr hn]; exact ⟨hzb, hzI⟩
      obtain ⟨i, hi⟩ := mem_iUnion.mp hz'
      rw [connectedComponentIn_eq_of_iUnion (by rw [inter_comm]; exact X.hC.cover r hr hn) (X.hC.isOpen r hr)
        (X.hC.isPreconnected r hr) (X.hC.disjoint r hr) hi]
      exact X.hC.mem_closure_sector hr i
  · rw [connectedComponentIn_eq hz]
    exact isPreconnected_connectedComponentIn.subset_connectedComponentIn (mem_connectedComponentIn hzU)
      ((connectedComponentIn_subset _ _).trans fun y hy => ⟨hsub hy, hy.2⟩)

/-- **… and one other than the sector before a germ that became interior**: if a point of the germ after the chart sector `p`
of `F₁` is interior to `F₂`, every sector of `F₂` that contains the sector `p` contains the next one too. -/
theorem exists_isSector_ne_subset {F₁ F₂ : ArcMap k} {v : ℂ} (X : F₁.Near v) (hn : 2 ≤ X.n) {r : ℝ} (hr : r ∈ Ioc 0 X.s₀)
    (hsub : F₁.interiorPts ∩ ball v r ⊆ F₂.interiorPts) {p : Fin X.n} {s : ℝ} (hs : s ∈ Ioo 0 r)
    (hx : branchPt v (X.G.β (BranchGerms.next p)) (X.G.κ (BranchGerms.next p)) s ∈ F₂.interiorPts)
    {S₂ : Set ℂ} (hS₂ : F₂.IsSector v r S₂) :
    ∃ S₁, F₁.IsSector v r S₁ ∧ S₁ ≠ X.G.sector v r p ∧ S₁ ⊆ S₂ := by
  have hr' : r ∈ Ioc 0 X.r₀ := ⟨hr.1, hr.2.trans X.hs₀.2⟩
  have hn0 : 0 < X.n := by omega
  obtain ⟨S₁, hS₁, hS₁₂⟩ := exists_isSector_subset X hr' hsub hS₂
  by_cases hne : S₁ = X.G.sector v r p
  swap
  · exact ⟨S₁, hS₁, hne, hS₁₂⟩
  subst hne
  set q := BranchGerms.next p with hq
  set x := branchPt v (X.G.β q) (X.G.κ q) s with hxdef
  have hxb : x ∈ ball v r := by
    rw [mem_ball, dist_eq_norm, norm_branchPt_sub v _ _ hs.1.le]; exact hs.2
  set U := F₂.interiorPts ∩ ball v r with hU
  have hUo : IsOpen U := F₂.isOpen_interiorPts.inter isOpen_ball
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp hUo x ⟨hx, hxb⟩
  have hsecU : ∀ i, X.G.sector v r i ⊆ U := fun i y hy =>
    ⟨hsub ⟨X.hC.sector_subset_interiorPts hn0 hr' i hy, (X.hC.cover r hr' hn0 ▸ mem_iUnion.mpr ⟨i, hy⟩ :
      y ∈ ball v r ∩ F₁.interiorPts).1⟩, (X.hC.cover r hr' hn0 ▸ mem_iUnion.mpr ⟨i, hy⟩ : y ∈ ball v r ∩ F₁.interiorPts).1⟩
  obtain ⟨x₀, hx₀, rfl, -⟩ := hS₂
  -- the small ball about `x` lies in the component
  obtain ⟨y, hy, hyx⟩ := Metric.mem_closure_iff.mp
    (IsSectorChart.branchPt_mem_closure_sector_before X.hord hr.2 p hs) ε hε
  have hyS : y ∈ connectedComponentIn U x₀ := hS₁₂ hy
  have hyb : y ∈ ball x ε := by rw [mem_ball]; rw [dist_comm] at hyx; exact hyx
  have hballS : ball x ε ⊆ connectedComponentIn U x₀ := by
    rw [connectedComponentIn_eq hyS]
    exact (convex_ball x ε).isPreconnected.subset_connectedComponentIn hyb hball
  obtain ⟨y', hy', hy'x⟩ := Metric.mem_closure_iff.mp
    (IsSectorChart.branchPt_mem_closure_sector_after X.hord hr.2 q hs) ε hε
  have hy'S : y' ∈ connectedComponentIn U x₀ := hballS (by rw [mem_ball]; rw [dist_comm] at hy'x; exact hy'x)
  refine ⟨X.G.sector v r q, (X.hC.isSector_iff hn0 hr').mpr ⟨q, rfl⟩, fun heq => ?_, ?_⟩
  · have hd := X.hC.disjoint r hr' q p (BranchGerms.next_ne_self hn p)
    rw [heq] at hd
    obtain ⟨w, hw⟩ := X.hC.sector_nonempty hr' p
    exact disjoint_left.mp hd hw hw
  · rw [connectedComponentIn_eq hy'S]
    exact (X.hC.isPreconnected r hr' q).subset_connectedComponentIn hy' (hsecU q)

/-- **The potential drops under a step that keeps the old interior and makes one germ interior**: `F₁` has at least two germs at
`v`, its interior points near `v` are interior points of `F₂`, and so are the points near `v` of one of its germs. -/
theorem pot_lt_of_interior {F₁ F₂ : ArcMap k} {v : ℂ} (X : F₁.Near v) (hn : 2 ≤ X.n)
    (hsub : ∀ᶠ r in 𝓝[>] (0 : ℝ), F₁.interiorPts ∩ ball v r ⊆ F₂.interiorPts) {p : Fin X.n}
    (hdrop : ∀ᶠ s in 𝓝[>] (0 : ℝ),
      branchPt v (X.G.β (BranchGerms.next p)) (X.G.κ (BranchGerms.next p)) s ∈ F₂.interiorPts)
    {m₁ j₁ m₂ j₂ : ℕ} (hm₁ : F₁.HasDegree v m₁) (hj₁ : F₁.HasHornCount v j₁) (hm₂ : F₂.HasDegree v m₂)
    (hj₂ : F₂.HasHornCount v j₂) : m₂ + j₂ < m₁ + j₁ := by
  refine pot_lt_of_sectors X.mem_dom ?_ hm₁ hj₁ hm₂ hj₂
  obtain ⟨u, hu, huP⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp hdrop
  have hu0 : (0 : ℝ) < u := hu
  filter_upwards [hsub, Ioc_mem_nhdsGT X.hs₀.1, Ioo_mem_nhdsGT hu0] with r hr1 hr2 hr3
  refine ⟨X.G.sector v r p, (X.hC.isSector_iff (by omega) ⟨hr2.1, hr2.2.trans X.hs₀.2⟩).mpr ⟨p, rfl⟩, fun S₂ hS₂ => ?_⟩
  exact exists_isSector_ne_subset X hn hr2 hr1 ⟨half_pos hr2.1, half_lt_self hr2.1⟩
    (huP ⟨half_pos hr2.1, by linarith [hr3.2]⟩) hS₂

/-- An interior point stays interior under cleaning (it carries one colour). -/
theorem interiorPts_subset_cleanKeep (M : ArcMap k) : M.interiorPts ⊆ M.cleanKeep.interiorPts := by
  intro z hz
  rw [cleanKeep_interiorPts]
  refine ⟨hz.1, fun hE => ?_⟩
  have := hE.2
  rw [coloursAt_eq_singleton_of_interior hz, ncard_singleton] at this
  omega

/-- **Cleaning raises neither the degree nor the horn count** at any point of the domain. -/
theorem cleanKeep_pot_le {M : ArcMap k} {v : ℂ} (hv : v ∈ M.dom) {m j m' j' : ℕ} (hm : M.HasDegree v m)
    (hj : M.HasHornCount v j) (hm' : M.cleanKeep.HasDegree v m') (hj' : M.cleanKeep.HasHornCount v j') :
    m' ≤ m ∧ j' ≤ j := by
  obtain ⟨X⟩ := exists_near hv
  refine pot_le_of_sectors hv ?_ hm hj hm' hj'
  filter_upwards [Ioc_mem_nhdsGT X.hC.pos] with r hr S₂ hS₂
  exact exists_isSector_subset X hr (inter_subset_left.trans M.interiorPts_subset_cleanKeep) hS₂

/-- **Cleaning creates no repeated colour**: two sectors of one colour of the cleaned map hold two of the map. -/
theorem hasRepeatedColour_of_cleanKeep {M : ArcMap k} {x : ℂ} (hx : x ∈ M.dom) (h : M.cleanKeep.HasRepeatedColour x) :
    M.HasRepeatedColour x := by
  obtain ⟨c, hc⟩ := h
  obtain ⟨X⟩ := exists_near hx
  refine ⟨c, ?_⟩
  filter_upwards [hc, Ioc_mem_nhdsGT X.hC.pos] with r h2 hr
  refine h2.trans (encard_le_of_forall_exists_subset (F₁ := M) (F₂ := M.cleanKeep) (v := x) (r := r)
    (fun S hS => hS.1) (fun S hS => hS.1) ?_)
  rintro S₂ ⟨hS₂, hcol⟩
  obtain ⟨S₁, hS₁, hsub⟩ := exists_isSector_subset X hr (inter_subset_left.trans M.interiorPts_subset_cleanKeep) hS₂
  refine ⟨S₁, ⟨hS₁, fun z hz => ?_⟩, hsub⟩
  have hzI : z ∈ M.interiorPts := by
    obtain ⟨y, -, rfl, -⟩ := hS₁
    exact (connectedComponentIn_subset _ _ hz).1
  have hzE : z ∈ M.dom \ M.essSet := by rw [← cleanKeep_interiorPts]; exact M.interiorPts_subset_cleanKeep hzI
  have h1 : M.cleanKeep.col z = c := hcol (hsub hz)
  rw [cleanKeep_col hzE, cleanCol_eq (coloursAt_eq_singleton_of_interior hzI)] at h1
  exact h1

/-- **A point with no horn and no repeated colour is no site after cleaning.** -/
theorem not_isSite_cleanKeep {M : ArcMap k} {x : ℂ} (hx : x ∈ M.dom) (h0 : M.HasHornCount x 0)
    (hrep : ¬ M.HasRepeatedColour x) : ¬ M.cleanKeep.IsSite x := by
  rintro ⟨-, hr | ⟨α, κ₁, κ₂, c, hlt, hH⟩⟩
  · exact hrep (hasRepeatedColour_of_cleanKeep hx hr)
  · obtain ⟨X⟩ := exists_near hx
    obtain ⟨r, ⟨⟨hS, -⟩, h0r⟩, hr⟩ := ((hH.and h0).and (Ioc_mem_nhdsGT X.hC.pos)).exists
    obtain ⟨S₁, hS₁, hsub⟩ :=
      exists_isSector_subset X hr (inter_subset_left.trans M.interiorPts_subset_cleanKeep) hS
    rw [Nat.cast_zero, encard_eq_zero] at h0r
    exact (eq_empty_iff_forall_notMem.mp h0r) S₁ ⟨hS₁, IsSector.hornSet_of_subset X hr hS₁ hsub⟩

/-! ## Points of a step's disc other than its centre: no horn, no repeated colour (FS131-IR2)

A point `x ≠ v` of a move's closed disc lies on at most two curves of the new map (a germ or a new arc; at a junction, also the
rim circle). Read at `x`: if the arcs near `x` lie on finitely many branches from `x` with pairwise distinct directions, no sector
at `x` is a horn and the degree is at most the number of branches — one fewer if one branch is dead
(`hasHornCount_zero_of_germs`); a clean map has no repeated colour at a point of degree at most three
(`not_hasRepeatedColour_of_degree_le_three`: its consecutive sectors differ in colour, `Near.col_ne_next_of_isClean`). -/

/-- **In a clean map consecutive chart sectors have different colours** (a point of the germ between them carries only their
colours, and at least two). -/
theorem Near.col_ne_next_of_isClean {F : ArcMap k} {v : ℂ} (X : F.Near v) (hc : F.IsClean) (p : Fin X.n) :
    X.col p ≠ X.col (BranchGerms.next p) := by
  intro heq
  have hn : 0 < X.n := p.pos
  set q := BranchGerms.next p with hq
  have hs : X.s₀ / 2 ∈ Ioo 0 X.s₀ := ⟨by linarith [X.hs₀.1], by linarith [X.hs₀.1]⟩
  set x := branchPt v (X.G.β q) (X.G.κ q) (X.s₀ / 2) with hx
  have hxΓ : x ∈ F.Γ := X.hC.branchPt_mem_Γ q ⟨hs.1, hs.2.trans_le X.hs₀.2⟩
  have hnorm := norm_branchPt_sub v (X.G.β q) (X.G.κ q) hs.1.le
  have hxs : x ∈ ball v X.s₀ := by rw [mem_ball, dist_eq_norm, hnorm]; exact hs.2
  have hsub : F.coloursAt x ⊆ {X.col q} := by
    intro j hj
    obtain ⟨i, hi, rfl⟩ := X.hC.coloursAt_subset_image hn X.hs₀ X.hcol₀ hxs hj
    rcases X.hC.eq_or_next_eq_of_mem_closure X.hs₀.2 X.hdisj hs hi with h | h
    · rw [h]; exact mem_singleton _
    · have hip : i = p := BranchGerms.next_injective h
      rw [hip, heq]; exact mem_singleton _
  have h1 := ncard_le_ncard hsub (finite_singleton _)
  rw [ncard_singleton] at h1
  have h2 := hc x hxΓ
  omega

/-- A clean map has at least two germs at a point of its arcs (one germ would have one sector on both sides). -/
theorem Near.two_le_of_isClean {F : ArcMap k} {v : ℂ} (X : F.Near v) (hc : F.IsClean) (hn : 0 < X.n) : 2 ≤ X.n := by
  by_contra h
  have h1 : X.n = 1 := by omega
  have hp : BranchGerms.next (⟨0, hn⟩ : Fin X.n) = ⟨0, hn⟩ := by
    apply Fin.ext
    unfold BranchGerms.next
    split_ifs with h2
    · simp at h2; omega
    · rfl
  exact X.col_ne_next_of_isClean hc ⟨0, hn⟩ (by rw [hp])

/-- **A clean map has no repeated colour at a point of degree at most three**: two sectors of one colour would be consecutive. -/
theorem not_hasRepeatedColour_of_degree_le_three {F : ArcMap k} (hc : F.IsClean) {x : ℂ} (hx : x ∈ F.dom) {m : ℕ}
    (hm : F.HasDegree x m) (h3 : m ≤ 3) : ¬ F.HasRepeatedColour x := by
  obtain ⟨X⟩ := exists_near hx
  have hn3 : X.n ≤ 3 := by
    have := hm.eq X.hC.hasDegree
    omega
  rintro ⟨c, hrep⟩
  obtain ⟨r, h2, hr⟩ := (hrep.and (Ioc_mem_nhdsGT X.hC.pos)).exists
  rcases Nat.eq_zero_or_pos X.n with hn | hn
  · have h1 := h2.trans (encard_le_encard (show F.sectorsOf x r c ⊆ {ball x r} from fun S hS =>
      (X.hC.isSector_iff_of_zero hn hr).mp hS.1))
    rw [encard_singleton] at h1
    norm_num at h1
  · rw [X.hC.encard_sectorsOf hn hr (fun i => X.hcol i r hr) c] at h2
    obtain ⟨i, j, hi, hj, hij⟩ := one_lt_encard_iff.mp (lt_of_lt_of_le (by norm_num) h2)
    have hi : X.col i = c := hi
    have hj : X.col j = c := hj
    have hadj : BranchGerms.next i = j ∨ BranchGerms.next j = i := by
      have hi' := i.isLt
      have hj' := j.isLt
      have hne : i.val ≠ j.val := fun h => hij (Fin.ext h)
      by_cases h1 : (BranchGerms.next i).val = j.val
      · exact Or.inl (Fin.ext h1)
      · right
        apply Fin.ext
        unfold BranchGerms.next at h1 ⊢
        split_ifs at h1 ⊢ with ha hb <;> simp at h1 ⊢ <;> omega
    rcases hadj with h | h
    · exact X.col_ne_next_of_isClean hc i (by rw [h, hi, hj])
    · exact X.col_ne_next_of_isClean hc j (by rw [h, hi, hj])

/-- **A point whose arcs lie on finitely many branches with distinct directions**: if every point of `Γ` near `x` other than `x`
lies, at its own distance, on one of finitely many branches from `x` whose directions at `x` are pairwise distinct, then no sector
at `x` is a horn, and `x` has at most as many germs as there are branches — one fewer if some branch has points off `Γ` arbitrarily
near `x`. (The chart's germs are among the branches: two germs with one direction would be two branches with one direction.) -/
theorem hasHornCount_zero_of_germs {M : ArcMap k} {x : ℂ} (hx : x ∈ M.dom) (𝒟 : Finset (ℝ × ℝ))
    (hdir : ∀ g ∈ 𝒟, ∀ g' ∈ 𝒟, e g.1 = e g'.1 → g = g') {ρ : ℝ} (hρ : 0 < ρ)
    (hΓ : ∀ z ∈ M.Γ, z ∈ ball x ρ → z ≠ x → ∃ g ∈ 𝒟, z = branchPt x g.1 g.2 ‖z - x‖) :
    M.HasHornCount x 0 ∧ (∀ m, M.HasDegree x m → m ≤ max 𝒟.card 1) ∧
      ∀ g₀ ∈ 𝒟, (∃ᶠ s in 𝓝[>] (0 : ℝ), branchPt x g₀.1 g₀.2 s ∉ M.Γ) → ∀ m, M.HasDegree x m → m ≤ max (𝒟.card - 1) 1 := by
  classical
  obtain ⟨X⟩ := exists_near hx
  have hmin : 0 < min ρ X.s₀ := lt_min hρ X.hs₀.1
  have hg : ∀ i : Fin X.n, ∀ s ∈ Ioo 0 (min ρ X.s₀), ∃ g ∈ 𝒟,
      branchPt x (X.G.β i) (X.G.κ i) s = branchPt x g.1 g.2 s := by
    intro i s hs
    have hsr : s ∈ Ioo 0 X.r₀ := ⟨hs.1, hs.2.trans_le ((min_le_right _ _).trans X.hs₀.2)⟩
    have hnorm := norm_branchPt_sub x (X.G.β i) (X.G.κ i) hs.1.le
    obtain ⟨g, hg, heq⟩ := hΓ _ (X.hC.branchPt_mem_Γ i hsr)
      (by rw [mem_ball, dist_eq_norm, hnorm]; exact hs.2.trans_le (min_le_left _ _))
      (fun h => by rw [h, sub_self, norm_zero] at hnorm; linarith [hs.1])
    rw [hnorm] at heq
    exact ⟨g, hg, heq⟩
  have hdirs : ∀ {β κ β' κ' s : ℝ}, 0 < s → branchPt x β κ s = branchPt x β' κ' s →
      e (germDir β κ s) = e (germDir β' κ' s) := by
    intro β κ β' κ' s hs heq
    rw [branchPt_eq, branchPt_eq] at heq
    have hs0 : (s : ℂ) ≠ 0 := by exact_mod_cast hs.ne'
    exact mul_left_cancel₀ hs0 (add_left_cancel heq)
  have hinj : ∀ i j : Fin X.n, ∀ s ∈ Ioo 0 (min ρ X.s₀),
      branchPt x (X.G.β i) (X.G.κ i) s = branchPt x (X.G.β j) (X.G.κ j) s → i = j := by
    intro i j s hs heq
    by_contra hij
    exact X.hdisj i j hij s ⟨hs.1, hs.2.trans_le (min_le_right _ _)⟩ (hdirs hs.1 heq)
  -- no two germs share a direction
  have hcusp : ∀ i : Fin X.n, X.G.β i ≠ X.G.nextβ i := by
    intro i hβ
    set j := BranchGerms.next i with hj
    have hij : i ≠ j := BranchGerms.ne_next_of_nextβ_eq hβ.symm
    have hej : e (X.G.β j) = e (X.G.β i) := by rw [← X.G.e_nextβ i, ← hβ]
    have hf : Tendsto (fun s => ‖e (germDir (X.G.β i) (X.G.κ i) s) - e (germDir (X.G.β j) (X.G.κ j) s)‖)
        (𝓝[>] 0) (𝓝 0) := by
      have hcont : Continuous (fun s => ‖e (germDir (X.G.β i) (X.G.κ i) s) - e (germDir (X.G.β j) (X.G.κ j) s)‖) := by
        unfold germDir e; fun_prop
      have := (hcont.tendsto 0).mono_left (nhdsWithin_le_nhds (s := Ioi 0))
      simpa [germDir_zero, hej] using this
    have hpair : ∀ g ∈ 𝒟, ∀ g' ∈ 𝒟, g ≠ g' → ∀ᶠ s in 𝓝[>] (0 : ℝ),
        ‖e (germDir (X.G.β i) (X.G.κ i) s) - e (germDir (X.G.β j) (X.G.κ j) s)‖ <
          ‖e (germDir g.1 g.2 s) - e (germDir g'.1 g'.2 s)‖ := by
      intro g hg g' hg' hne
      have hd : 0 < ‖e g.1 - e g'.1‖ := norm_pos_iff.mpr (sub_ne_zero.mpr fun h => hne (hdir g hg g' hg' h))
      have hh : Tendsto (fun s => ‖e (germDir g.1 g.2 s) - e (germDir g'.1 g'.2 s)‖) (𝓝[>] 0)
          (𝓝 ‖e g.1 - e g'.1‖) := by
        have hcont : Continuous (fun s => ‖e (germDir g.1 g.2 s) - e (germDir g'.1 g'.2 s)‖) := by
          unfold germDir e; fun_prop
        have := (hcont.tendsto 0).mono_left (nhdsWithin_le_nhds (s := Ioi 0))
        simpa [germDir_zero] using this
      filter_upwards [hf.eventually (gt_mem_nhds (half_pos hd)), hh.eventually (lt_mem_nhds (half_lt_self hd))]
        with s h1 h2
      exact h1.trans h2
    have hall : ∀ᶠ s in 𝓝[>] (0 : ℝ), ∀ g ∈ 𝒟, ∀ g' ∈ 𝒟, g ≠ g' →
        ‖e (germDir (X.G.β i) (X.G.κ i) s) - e (germDir (X.G.β j) (X.G.κ j) s)‖ <
          ‖e (germDir g.1 g.2 s) - e (germDir g'.1 g'.2 s)‖ := by
      refine (Filter.eventually_all_finset 𝒟).mpr fun g hg => (Filter.eventually_all_finset 𝒟).mpr fun g' hg' => ?_
      by_cases hne : g = g'
      · exact Filter.Eventually.of_forall fun _ h => absurd hne h
      · exact (hpair g hg g' hg' hne).mono fun s h _ => h
    obtain ⟨s, hs1, hs⟩ := (hall.and (Ioo_mem_nhdsGT hmin)).exists
    obtain ⟨g, hg𝒟, hgeq⟩ := hg i s hs
    obtain ⟨g', hg'𝒟, hg'eq⟩ := hg j s hs
    have hne : g ≠ g' := fun h => hij (hinj i j s hs (by rw [hgeq, hg'eq, h]))
    have := hs1 g hg𝒟 g' hg'𝒟 hne
    rw [hdirs hs.1 hgeq, hdirs hs.1 hg'eq] at this
    exact lt_irrefl _ this
  have hcard : ∀ s ∈ Ioo 0 (min ρ X.s₀), ∀ 𝒟' : Finset (ℝ × ℝ),
      (∀ g ∈ 𝒟, branchPt x g.1 g.2 s ∈ M.Γ → g ∈ 𝒟') → X.n ≤ 𝒟'.card := by
    intro s hs 𝒟' h𝒟'
    choose g hg𝒟 hgeq using fun i : Fin X.n => hg i s hs
    have hsr : s ∈ Ioo 0 X.r₀ := ⟨hs.1, hs.2.trans_le ((min_le_right _ _).trans X.hs₀.2)⟩
    have h1 : (Finset.univ : Finset (Fin X.n)).card ≤ 𝒟'.card :=
      Finset.card_le_card_of_injOn g (fun i _ => h𝒟' _ (hg𝒟 i) (hgeq i ▸ X.hC.branchPt_mem_Γ i hsr))
        (fun i _ j _ hij => hinj i j s hs (by rw [hgeq i, hgeq j, hij]))
    simpa using h1
  have hhalf : min ρ X.s₀ / 2 ∈ Ioo 0 (min ρ X.s₀) := ⟨by positivity, by linarith⟩
  refine ⟨?_, fun m hm => ?_, fun g₀ hg₀ hdead m hm => ?_⟩
  · rcases Nat.eq_zero_or_pos X.n with hn | hn
    · filter_upwards [Ioc_mem_nhdsGT X.hC.pos] with r hr
      rw [Nat.cast_zero, encard_eq_zero, eq_empty_iff_forall_notMem]
      rintro S ⟨hS, α, κ₁, κ₂, -, rfl⟩
      have hball := (X.hC.isSector_iff_of_zero hn hr).mp hS
      have hv' : x ∈ hornSet x α κ₁ κ₂ r := hball ▸ mem_ball_self hr.1
      have := hv'.2.1
      simp [frameX] at this
    · have h0 : {i : Fin X.n | X.G.β i = X.G.nextβ i} = ∅ := eq_empty_iff_forall_notMem.mpr fun i hi => hcusp i hi
      have h := X.hasHornCount_chart hn
      rw [h0, ncard_empty] at h
      exact h
  · have h1 := hm.eq X.hC.hasDegree
    have h2 := hcard _ hhalf 𝒟 (fun g hg _ => hg)
    omega
  · have h1 := hm.eq X.hC.hasDegree
    obtain ⟨s, hsdead, hs⟩ := (hdead.and_eventually (Ioo_mem_nhdsGT hmin)).exists
    have h2 := hcard s hs (𝒟.erase g₀) (fun g hg hgΓ => Finset.mem_erase.mpr ⟨fun h => hsdead (h ▸ hgΓ), hg⟩)
    rw [Finset.card_erase_of_mem hg₀] at h2
    omega

/-! ### A point on one curve (FS131-IR2)

The first instance of `hasHornCount_zero_of_germs`: near a point `x ≠ v` of a move's disc that is no junction, `Γ` lies on one
germ-like arc from `v`, hence on one line or circle through `x` (`exists_curveAt_of_branch`), whose two germs at `x` leave in
opposite directions; so `x` is no site of a clean map and carries at most two colours (`not_isSite_of_curve`). -/

/-- A point with no horn sector and no repeated colour is no site. -/
theorem not_isSite_of_hasHornCount_zero {M : ArcMap k} {x : ℂ} (h0 : M.HasHornCount x 0)
    (hrep : ¬ M.HasRepeatedColour x) : ¬ M.IsSite x := by
  rintro ⟨-, hr | ⟨α, κ₁, κ₂, c, hlt, hH⟩⟩
  · exact hrep hr
  · obtain ⟨r, ⟨hS, -⟩, h0r⟩ := (hH.and h0).exists
    rw [Nat.cast_zero, encard_eq_zero] at h0r
    exact (eq_empty_iff_forall_notMem.mp h0r) _ ⟨hS, α, κ₁, κ₂, hlt, rfl⟩

/-- The two germs of a line or circle leave its point in opposite directions. -/
theorem _root_.HadwigerNelson.Plane.e_curveGerm_ne (κ : ℝ) (b : ℂ) : e (curveGerm κ b 1).1 ≠ e (curveGerm κ b (-1)).1 := by
  have e1 : e (curveGerm κ b 1).1 = e (arg b - π / 2) := by
    have := e_toIcoMod_add (arg b - 1 * (π / 2)) 0
    rw [add_zero, add_zero] at this
    rw [curveGerm]; dsimp only; rw [this, one_mul]
  have e2 : e (curveGerm κ b (-1)).1 = - e (arg b - π / 2) := by
    have := e_toIcoMod_add (arg b - -1 * (π / 2)) 0
    rw [add_zero, add_zero] at this
    rw [curveGerm]; dsimp only
    rw [this, show arg b - -1 * (π / 2) = (arg b - π / 2) + π by ring, e_add_pi]
  rw [e1, e2]
  intro h
  have h2 : (2 : ℂ) * e (arg b - π / 2) = 0 := by linear_combination h
  have h3 := congrArg norm h2
  rw [norm_mul, norm_e, Complex.norm_two, norm_zero] at h3
  norm_num at h3

/-- **A point of a clean map near which `Γ` lies on one line or circle through it is no site**, and carries at most two colours
(the form in which a point of a move's disc on one germ or one new arc is read; `not_isSite_of_goodAt` is the case of a good ball). -/
theorem not_isSite_of_curve {M : ArcMap k} (hc : M.IsClean) {x : ℂ} (hx : x ∈ M.dom) {κ : ℝ} (hκ : 0 ≤ κ) {b : ℂ}
    (hb : b ≠ 0) {ρ : ℝ} (hρ : 0 < ρ) (hΓ : ∀ z ∈ M.Γ, z ∈ ball x ρ → z ∈ curveAt x κ b) :
    ¬ M.IsSite x ∧ (M.coloursAt x).ncard ≤ 2 := by
  classical
  have hbn : 0 < ‖b‖ := norm_pos_iff.mpr hb
  obtain ⟨ρ', hρ', hρ'ρ, hκρ'⟩ : ∃ ρ' > 0, ρ' ≤ ρ ∧ κ * ρ' < 2 * ‖b‖ := by
    refine ⟨min ρ (‖b‖ / (κ + 1)), lt_min hρ (by positivity), min_le_left _ _, ?_⟩
    have h1 : min ρ (‖b‖ / (κ + 1)) ≤ ‖b‖ / (κ + 1) := min_le_right _ _
    have h2 : κ * (‖b‖ / (κ + 1)) ≤ ‖b‖ := by
      rw [← mul_div_assoc, div_le_iff₀ (by linarith)]
      nlinarith [hbn.le, hκ]
    nlinarith [mul_le_mul_of_nonneg_left h1 hκ]
  set 𝒟 : Finset (ℝ × ℝ) := {curveGerm κ b 1, curveGerm κ b (-1)} with h𝒟
  have hdir : ∀ g ∈ 𝒟, ∀ g' ∈ 𝒟, e g.1 = e g'.1 → g = g' := by
    intro g hg g' hg' h
    simp only [h𝒟, Finset.mem_insert, Finset.mem_singleton] at hg hg'
    rcases hg with rfl | rfl <;> rcases hg' with rfl | rfl
    · rfl
    · exact absurd h (e_curveGerm_ne κ b)
    · exact absurd h.symm (e_curveGerm_ne κ b)
    · rfl
  obtain ⟨h0, hdeg, -⟩ := hasHornCount_zero_of_germs hx 𝒟 hdir hρ' (fun z hz hzb hzx => by
    have hzb' : ‖z - x‖ < ρ' := by rwa [mem_ball, dist_eq_norm] at hzb
    obtain ⟨σ, hσ, hzσ⟩ := exists_eq_branchPt_curveGerm hκ hb (hΓ z hz (ball_subset_ball hρ'ρ hzb)) hzx
      (by nlinarith [mul_le_mul_of_nonneg_left hzb'.le hκ])
    rcases hσ with rfl | rfl
    · exact ⟨_, by simp [h𝒟], hzσ⟩
    · exact ⟨_, by simp [h𝒟], hzσ⟩)
  obtain ⟨m, hcol, hm⟩ := exists_hasDegree_of_mem_dom hx
  have hm2 : m ≤ 2 := by
    have h1 := hdeg m hm
    have h2 : 𝒟.card ≤ 2 := (Finset.card_insert_le _ _).trans (by simp)
    omega
  exact ⟨not_isSite_of_hasHornCount_zero h0 (not_hasRepeatedColour_of_degree_le_three hc hx hm (by omega)),
    hcol.trans hm2⟩

/-- **A line or circle through `v`, read from another of its points** `y`: the same curve, with the data at `y`. -/
theorem _root_.HadwigerNelson.Plane.curveAt_rebase {v y : ℂ} {κ : ℝ} {b : ℂ} (hy : y ∈ curveAt v κ b) :
    curveAt v κ b = curveAt y κ (b + (κ : ℂ) * (v - y)) := by
  ext z
  simp only [curveAt, mem_setOf_eq, Complex.normSq_apply, Complex.mul_re, Complex.sub_re, Complex.sub_im, Complex.conj_re,
    Complex.conj_im, Complex.add_re, Complex.add_im, Complex.ofReal_re, Complex.ofReal_im, Complex.mul_im] at hy ⊢
  constructor <;> intro h
  · linear_combination h - hy
  · linear_combination h + hy

/-- **A germ's branch from `v`, read from one of its points**: it lies on one line or circle through that point (the hypothesis
of `not_isSite_of_curve` at a point of a kept germ, of SHAVE's arc or of OPEN's ray). -/
theorem _root_.HadwigerNelson.Plane.exists_curveAt_of_branch (v : ℂ) (β κ : ℝ) {r : ℝ} (hκr : |κ| * r < 2) {s₁ : ℝ}
    (hs₁ : s₁ ∈ Icc 0 r) :
    ∃ κ' : ℝ, ∃ b : ℂ, 0 ≤ κ' ∧ b ≠ 0 ∧ ∀ t ∈ Icc 0 r, branchPt v β κ t ∈ curveAt (branchPt v β κ s₁) κ' b := by
  obtain ⟨κ', b, σ, hκ', hb, hσ, hκb, heq⟩ := exists_curveGerm_eq v β κ hκr
  have hκ0 : 0 ≤ κ' := by rcases hκ' with h | h <;> simp [h]
  have hmem : ∀ t ∈ Icc 0 r, branchPt v β κ t ∈ curveAt v κ' b := fun t ht => by
    rw [heq t]
    exact branchPt_curveGerm_mem hκ0 hb hσ ht.1 ((mul_le_mul_of_nonneg_left ht.2 hκ0).trans hκb)
  have hy := hmem s₁ hs₁
  refine ⟨κ', b + (κ' : ℂ) * (v - branchPt v β κ s₁), hκ0, ?_, fun t ht => by
    rw [← curveAt_rebase hy]; exact hmem t ht⟩
  rcases hκ' with h | h
  · rw [h]; simpa using hb
  · intro h0
    rw [h] at h0 hy
    have hyv : branchPt v β κ s₁ - v = b := by
      have h0' : b + (v - branchPt v β κ s₁) = 0 := by simpa using h0
      linear_combination -h0'
    have h1 : Complex.normSq b = 2 * Complex.normSq b := by
      have h2 := hy
      rw [curveAt, mem_setOf_eq, hyv, one_mul, Complex.mul_conj, Complex.ofReal_re] at h2
      exact h2
    exact hb (Complex.normSq_eq_zero.mp (by linarith))

/-! ## The vertex step's four cases (FS131-IR2): one statement per move, in the vertex step's own conclusion

`exists_vertexStep` is their case split (FS131-E6-ROUTE). Each takes its move's hypotheses (`exists_merge_aux`, `exists_rayMerge_aux`,
`exists_shave_aux`, `exists_open`) with cleanness and the two counts, and concludes the step. They are open (`sorry`) until proved
from the constructions; the routes are in `plans/FS131-limit-kernel-plan.md`, Stage 20. -/

/-- A colour with a horn at `v` has at least one sector there. -/
theorem one_le_of_isHorn {v : ℂ} (hv : v ∈ F.dom) {α κ₁ κ₂ : ℝ} {c : Fin k} (hH : F.IsHorn v α κ₁ κ₂ c) {n : ℕ}
    (hn : F.HasSectors v c n) : 1 ≤ n := by
  obtain ⟨X⟩ := exists_near hv
  obtain ⟨i, -, -, -, -, hci, -⟩ := X.horn_index hH
  have h := X.encard_col_eq i.pos hn
  have h1 : (1 : ℕ∞) ≤ {i | X.col i = c}.encard := one_le_encard_iff_nonempty.mpr ⟨i, hci⟩
  rw [h] at h1
  exact_mod_cast h1

/-- A colour with two horns at `v` of different lower curvatures has at least two sectors there. -/
theorem two_le_of_isHorn_of_isHorn {v : ℂ} (hv : v ∈ F.dom) {α α' κ₁ κ₂ κ₃ κ₄ : ℝ} {c : Fin k} (hH : F.IsHorn v α κ₁ κ₂ c)
    (hH' : F.IsHorn v α' κ₃ κ₄ c) (hne : κ₁ ≠ κ₃) {n : ℕ} (hn : F.HasSectors v c n) : 2 ≤ n := by
  obtain ⟨X⟩ := exists_near hv
  obtain ⟨i, -, -, hκ, -, hci, -⟩ := X.horn_index hH
  obtain ⟨i', -, -, hκ', -, hci', -⟩ := X.horn_index hH'
  have hii : i ≠ i' := fun h => hne (by rw [← hκ, ← hκ', h])
  have h := X.encard_col_eq i.pos hn
  have h1 : (1 : ℕ∞) < {i | X.col i = c}.encard := one_lt_encard_iff.mpr ⟨i, i', hci, hci', hii⟩
  rw [h] at h1
  have h2 : 1 < n := by exact_mod_cast h1
  omega

/-- **The vertex step, MERGE's case** (FS110-W-MERGE, cleaned): `exists_merge_aux`'s hypotheses at a point of a clean map, with the
two counts; the vertex step's conclusion. Open: its map is `MergeMove`'s surgery at a radius also below `δ`, then `cleanKeep`
(`surgery_cleanKeep_localStep`, `pot_lt_of_interior` at a germ of the gap). Inhabitant: none in Lean (as `exists_vertexStep`). -/
theorem exists_mergeStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)
    (hn : F.HasSectors v c (n + 1)) (hD : (interior (F.allowedCone v c)).Nonempty) {m j : ℕ} (hdeg : F.HasDegree v m)
    (hhorn : F.HasHornCount v j) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ, 0 < ρ ∧ ρ < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  sorry

/-- **The vertex step, MERGE-RAY's case** (FS110-N4-RAY, cleaned): `exists_rayMerge_aux`'s hypotheses at a point of a clean map.
Open: its map is `Moves`' `RayConfig.exists_merge` construction (`Near.move` with the kept germs `rayKeep`) at a radius also below
`δ`, then `cleanKeep`; the count is `pot_lt_of_interior` at the lower horn's upper germ. In a clean map the two horns are never
adjacent (`Near.col_ne_next_of_isClean`), so `exists_rayMerge_of_clear`'s cut case does not occur. Inhabitant: none in Lean. -/
theorem exists_rayStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ κ₃ κ₄ : ℝ} {c : Fin k} {n : ℕ}
    (hn : F.HasSectors v c (n + 1)) (h23 : κ₂ < κ₃) (hH : F.IsHorn v α κ₁ κ₂ c) (hH' : F.IsHorn v α κ₃ κ₄ c)
    (h1 : -1 ≤ κ₁) (h4 : κ₄ ≤ 1) {m j : ℕ} (hdeg : F.HasDegree v m) (hhorn : F.HasHornCount v j) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ, 0 < ρ ∧ ρ < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  sorry

/-- **The vertex step, SHAVE's case** (FS110-N4-SHAVE, cleaned): `exists_shave_aux`'s hypotheses at a point of a clean map. Open:
its map is `exists_shave_recolour`'s (`Near.move` with `shaveArcs` and `shaveCol`; in a clean map neither flank has the horn's
colour, so the two cut cases do not occur) at a radius also below `δ`, then `cleanKeep`; the count is `pot_lt_of_sectors` with `H`
the shaved horn. Inhabitant: none in Lean. -/
theorem exists_shaveStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ σ : ℝ} {c g h : Fin k} {n : ℕ}
    (hn : F.HasSectors v c (n + 1)) (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : -1 ≤ κ₁) (h2 : κ₂ ≤ 1)
    (hg : F.IsFlankAbove v α κ₂ g) (hh : F.IsFlankBelow v α κ₁ h) (hσ₁ : κ₁ ≤ σ) (hσ₂ : σ ≤ κ₂)
    (hclear : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₁ κ₂ r,
      (TanAbove v α σ z → F.IsClear g z) ∧ (¬ TanAbove v α σ z → F.IsClear h z))
    {m j : ℕ} (hdeg : F.HasDegree v m) (hhorn : F.HasHornCount v j) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ, 0 < ρ ∧ ρ < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  sorry

/-- **The vertex step, OPEN's case** (FS131-E6-OPEN, cleaned): `exists_open`'s hypotheses at a point of a clean map. Open: its map
is `OpenMove`'s surgery (radius below `δ` already), then `cleanKeep`; the count is `exists_open`'s clause and `cleanKeep_pot_le`.
Inhabitant: none in Lean (FS131-E6's twelve-colour map at [hand], as `exists_open`'s note says). -/
theorem exists_openStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}
    (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : F.HasSectors v c 1) (hD : (interior (F.allowedCone v c)).Nonempty) {m j : ℕ}
    (hdeg : F.HasDegree v m) (hhorn : F.HasHornCount v j) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ, 0 < ρ ∧ ρ < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  sorry

/-! ## The two steps (the strengthened moves, cleaned) -/

/-- **The vertex step** (FS131-E6-ROUTE: MERGE; else MERGE-RAY; else SHAVE where the horn's colour has an allowed cone with empty
interior; else OPEN — each followed by `exists_clean`): at a point of a clean valid map whose closed unit disc lies in the domain
(`F.Covers v 1`, what each of the four moves takes — inventory item 423) and where a move is available, for every bound
`δ > 0`, a clean valid modification that is a local step on `B̄(v, ρ)`, `ρ < δ`, in which `v`'s **potential — its degree plus its
number of horns — drops**, `v` gains no colour, and no other point of the disc is a site. The degree alone need not drop: at
FS131-E6's twelve-colour model (a lone horn shaveable only along a unit circle) no local step lowers it (E6-NODROP), and OPEN removes
the horn at the same degree. Route: with MERGE available, `exists_merge_aux`; else two horns of one colour along one ray have outer
bounds in `[−1, 1]` (`horn_bounds_of_noMerge`), `exists_rayMerge_aux`; else SHAVE is available through a `c`-horn — if
`int D_c(v) = ∅` its bounds lie in `[−1, 1]` (`horn_bounds_of_interior_empty`), `exists_shave_aux`; otherwise `c` has one sector there
(two would make MERGE available) and `exists_open` applies. Then the move's map is cleaned with its colour kept (`cleanKeep`: it
drops the kept germs that now have one colour on both sides and the one-coloured parts of the rim — FS131-KL1's finding: without it
SHAVE raises `v`'s degree); `LocalStep` is read off each construction's `surgery` (`trimArcs_spec`) and survives the cleaning
(`LocalStep.cleanKeep`). No Lean model of the hypotheses is on file (a clean valid map with a move
available at a point): FS131-E6's twelve-colour map (derivation §§ 3.1–3.3) satisfies them at [hand] grade, as `exists_open`'s note says. -/
theorem exists_vertexStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1)
    (hav : F.MergeAvailable v ∨ F.RayAvailable v ∨ F.ShaveAvailable v) {m j : ℕ} (hdeg : F.HasDegree v m)
    (hhorn : F.HasHornCount v j) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ, 0 < ρ ∧ ρ < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  have hvd : v ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  by_cases hM : F.MergeAvailable v
  · obtain ⟨c, n, hn2, hn, hD⟩ := hM
    obtain ⟨n', rfl⟩ : ∃ n', n = n' + 1 := ⟨n - 1, by omega⟩
    exact exists_mergeStep hF hc hv (by omega) hn hD hdeg hhorn hδ
  rcases hav with hM' | hR | hS
  · exact absurd hM' hM
  · obtain ⟨c, α, κ₁, κ₂, κ₃, κ₄, h23, hH, hH'⟩ := hR
    obtain ⟨n, hn⟩ := exists_hasSectors hvd c
    have hn2 : 2 ≤ n := two_le_of_isHorn_of_isHorn hvd hH hH' (by linarith [hH.1]) hn
    obtain ⟨n', rfl⟩ : ∃ n', n = n' + 1 := ⟨n - 1, by omega⟩
    exact exists_rayStep hF hc hv hn h23 hH hH' (horn_bounds_of_noMerge hF hv hM hn2 hn hH).1
      (horn_bounds_of_noMerge hF hv hM hn2 hn hH').2 hdeg hhorn hδ
  · obtain ⟨c, g, h, α, κ₁, κ₂, σ, hH, hg, hh, hσ₁, hσ₂, hclear⟩ := hS
    obtain ⟨n, hn⟩ := exists_hasSectors hvd c
    have hn1 : 1 ≤ n := one_le_of_isHorn hvd hH hn
    obtain ⟨n', rfl⟩ : ∃ n', n = n' + 1 := ⟨n - 1, by omega⟩
    by_cases hD : interior (F.allowedCone v c) = ∅
    · obtain ⟨h1, h2⟩ := horn_bounds_of_interior_empty hF hv hH hD
      exact exists_shaveStep hF hc hv hn hH h1 h2 hg hh hσ₁ hσ₂ hclear hdeg hhorn hδ
    · have hD' : (interior (F.allowedCone v c)).Nonempty := nonempty_iff_ne_empty.mpr hD
      have hn0 : n' = 0 := by
        by_contra h0
        exact hM ⟨c, n' + 1, by omega, hn, hD'⟩
      subst hn0
      exact exists_openStep hF hc hv hH hn hD' hdeg hhorn hδ

/-- **The arc step** (a bend of a maximal bad unit arc, then `exists_clean`): at a maximal unit arc about `P`, neither (Q) nor (R2),
whose side colours are not both carried at `P`, for every `δ > 0` and every locally finite set `T` (the treatment points), a clean
valid modification that is a local step on the closed `ε`-neighbourhood of the arc, `ε < δ`, lowering `P`'s bad count, creating no
site, changing no point's degree and raising no point's horn count (FS131-E6's clause, inventory item 385 (a): the bent curve must
not become tangent to another arc at an end vertex — a choice of the bend's profile), and at every other point of `T` adding no
colour and — unless it loses one — raising no bad count. The toward bend (`bend_toward`) when the outer colour is absent at `P`; else the away bend (`bend_away_whole`, or N2-TAN's
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
      (∀ x j, F.HasHornCount x j → ∃ j' ≤ j, F'.HasHornCount x j') ∧
      ∀ Q ∈ T, Q ≠ P → F'.coloursAt Q ⊆ F.coloursAt Q ∧
        (F'.coloursAt Q = F.coloursAt Q → F'.badCount Q ≤ F.badCount Q) := by
  sorry

/-! ## The run: locality off a step's support, the potential, one step, fairness (FS131-IR1)

`exists_terminalSeq` over the two steps. A stage satisfies `ProcInv` (clean, valid, of the plane, a modification of the initial map,
its sites among the initial treatment points); one step (`ProcStep`, built by `exists_procStep`) acts at the least-index treatment
point with something to do (`Todo`). Three counts make each treatment point acted at finitely often (`ProcRun.finite_acted`): its
potential `pot` (degree plus horns, FS131-E6) never rises and falls at each vertex step at it; its colours only shrink; its bad
count falls at each arc step at it and rises only when it loses a colour or a vertex step acts within `4` of it. Then the supports
are locally finite (`ProcRun.locallyFinite`) and nothing is left to do at any point from some stage on
(`ProcRun.eventually_not_todo`). Inhabitants: `ProcStep.refl`, `ProcRun.const`; of `ProcInv`, the initial map itself. -/

/-! ### Locality off a closed support (small radii) -/

section LocalitySmall

variable {M : ArcMap k} {U : Set ℂ}

/-- Off a closed set, the small balls about a point miss it. -/
theorem eventually_ball_subset_compl (hU : IsClosed U) {x : ℂ} (hx : x ∉ U) : ∀ᶠ r in 𝓝[>] (0 : ℝ), ball x r ⊆ Uᶜ := by
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp hU.isOpen_compl x hx
  filter_upwards [Ioo_mem_nhdsGT hε] with r hr
  exact (ball_subset_ball hr.2.le).trans hball

/-- **The degree of a point off the closed support of a step is unchanged.** -/
theorem hasDegree_iff_of_agreesOff (h : M.AgreesOff F U) (hU : IsClosed U) {x : ℂ} (hx : x ∉ U) (m : ℕ) :
    M.HasDegree x m ↔ F.HasDegree x m := by
  have h' : M.AgreesOff F Uᶜᶜ := by rwa [compl_compl]
  refine eventually_congr ?_
  filter_upwards [eventually_ball_subset_compl hU hx] with r hr
  have : {S | M.IsSector x r S} = {S | F.IsSector x r S} := by
    ext S; exact isSector_iff_of_agreesOn h' hr
  rw [this]

/-- **The horn count of a point off the closed support of a step is unchanged.** -/
theorem hasHornCount_iff_of_agreesOff (h : M.AgreesOff F U) (hU : IsClosed U) {x : ℂ} (hx : x ∉ U) (j : ℕ) :
    M.HasHornCount x j ↔ F.HasHornCount x j := by
  have h' : M.AgreesOff F Uᶜᶜ := by rwa [compl_compl]
  refine eventually_congr ?_
  filter_upwards [eventually_ball_subset_compl hU hx] with r hr
  have : {S | M.IsSector x r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet x α κ₁ κ₂ r} =
      {S | F.IsSector x r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet x α κ₁ κ₂ r} := by
    ext S; exact and_congr_left fun _ => isSector_iff_of_agreesOn h' hr
  rw [this]

/-- **Sites off the closed support of a step are unchanged.** -/
theorem isSite_iff_of_agreesOff (h : M.AgreesOff F U) (hU : IsClosed U) {x : ℂ} (hx : x ∉ U) :
    M.IsSite x ↔ F.IsSite x := by
  have h' : M.AgreesOff F Uᶜᶜ := by rwa [compl_compl]
  have hev := eventually_ball_subset_compl hU hx
  unfold IsSite
  rw [h.1]
  refine and_congr_right fun _ => or_congr ?_ ?_
  · refine exists_congr fun c => eventually_congr ?_
    filter_upwards [hev] with r hr
    rw [sectorsOf_eq_of_agreesOn h' hr]
  · refine exists_congr fun α => exists_congr fun κ₁ => exists_congr fun κ₂ => exists_congr fun c =>
      and_congr_right fun _ => eventually_congr ?_
    filter_upwards [hev] with r hr
    refine and_congr (isSector_iff_of_agreesOn h' hr) ⟨fun hc z hz => ?_, fun hc z hz => ?_⟩
    · have := hc hz
      simp only [mem_preimage, mem_singleton_iff] at this ⊢
      rw [← this]; exact (h.2 z (hr (hornSet_subset_ball _ _ _ _ _ hz))).2
    · have := hc hz
      simp only [mem_preimage, mem_singleton_iff] at this ⊢
      rw [← this]; exact (h.2 z (hr (hornSet_subset_ball _ _ _ _ _ hz))).2.symm

/-- **The bad count of a point whose closed disc of radius `3` misses the closed support of a step is unchanged.** -/
theorem badCount_eq_of_agreesOff (h : M.AgreesOff F U) (hU : IsClosed U) {P : ℂ} (hP : Disjoint (closedBall P 3) U) :
    M.badCount P = F.badCount P := by
  have h' : M.AgreesOff F Uᶜᶜ := by rwa [compl_compl]
  have hsub : closedBall P 3 ⊆ Uᶜ := fun z hz hzU => (Set.disjoint_left.mp hP) hz hzU
  have hW := hU.isOpen_compl
  unfold badCount IsMaxRingArc
  simp only [isRingArc_iff_of_agreesOn h' hW hsub, isQArc_iff_of_agreesOn h' hW hsub, isR2Arc_iff_of_agreesOn h' hW hsub]

end LocalitySmall

/-! ### The potential of a site -/

/-- The horn count exists at every point of the domain. -/
theorem exists_hasHornCount {v : ℂ} (hv : v ∈ F.dom) : ∃ j, F.HasHornCount v j := by
  obtain ⟨X⟩ := exists_near hv
  rcases Nat.eq_zero_or_pos X.n with hn | hn
  · refine ⟨0, ?_⟩
    filter_upwards [Ioc_mem_nhdsGT X.hC.pos] with r hr
    rw [Nat.cast_zero, encard_eq_zero, eq_empty_iff_forall_notMem]
    rintro S ⟨hS, α, κ₁, κ₂, -, rfl⟩
    have hball := (X.hC.isSector_iff_of_zero hn hr).mp hS
    have hv' : v ∈ hornSet v α κ₁ κ₂ r := hball ▸ mem_ball_self hr.1
    have := hv'.2.1
    simp [frameX] at this
  · exact ⟨_, X.hasHornCount_chart hn⟩

/-- **The potential of a point**: its degree plus its number of horns (`0` where either is undefined). The procedure's vertex
steps lower it (FS131-E6-ROUTE). -/
noncomputable def pot (F : ArcMap k) (v : ℂ) : ℕ := by
  classical
  exact if h : ∃ s : ℕ, ∃ m j, F.HasDegree v m ∧ F.HasHornCount v j ∧ s = m + j then h.choose else 0

/-- The potential is the degree plus the horn count. -/
theorem pot_eq {v : ℂ} {m j : ℕ} (hm : F.HasDegree v m) (hj : F.HasHornCount v j) : F.pot v = m + j := by
  have h : ∃ s : ℕ, ∃ m j, F.HasDegree v m ∧ F.HasHornCount v j ∧ s = m + j := ⟨_, m, j, hm, hj, rfl⟩
  unfold pot
  rw [dif_pos h]
  obtain ⟨m', j', hm', hj', hs⟩ := h.choose_spec
  rw [hs, hm.eq hm', hj.eq hj']

/-- **A sequence of naturals that rises only at finitely many stages falls at finitely many stages.** -/
theorem finite_strict_of_antitone_off (b : ℕ → ℕ) {R : Set ℕ} (hR : R.Finite) (h : ∀ n ∉ R, b (n + 1) ≤ b n) :
    {n | b (n + 1) < b n}.Finite := by
  obtain ⟨N, hN⟩ := hR.bddAbove
  have hanti : ∀ s, N < s → ∀ n, s ≤ n → b n ≤ b s := by
    intro s hs n hn
    induction n, hn using Nat.le_induction with
    | base => exact le_rfl
    | succ n hn ih => exact (h n fun hnR => absurd (hN hnR) (by omega)).trans ih
  have key : ∀ B s, N < s → b s ≤ B → ∃ M, ∀ n, M ≤ n → ¬ b (n + 1) < b n := by
    intro B
    induction B with
    | zero =>
      intro s hs hb
      refine ⟨s, fun n hn hlt => ?_⟩
      have := hanti s hs n hn
      omega
    | succ B ih =>
      intro s hs hb
      by_cases hex : ∃ n, s ≤ n ∧ b (n + 1) < b n
      · obtain ⟨n₀, hn₀, hlt⟩ := hex
        have := hanti s hs n₀ hn₀
        exact ih (n₀ + 1) (by omega) (by omega)
      · push Not at hex
        exact ⟨s, fun n hn hlt => absurd hlt (not_lt.mpr (hex n hn))⟩
  obtain ⟨M, hM⟩ := key (b (N + 1)) (N + 1) (by omega) le_rfl
  refine (finite_lt_nat M).subset fun n hn => ?_
  by_contra hge
  exact hM n (by simpa using hge) hn

/-! ### The procedure's invariant and one step -/

/-- A move is available at `v`. -/
def MoveAt (F : ArcMap k) (v : ℂ) : Prop := F.MergeAvailable v ∨ F.RayAvailable v ∨ F.ShaveAvailable v

/-- Something is left to do at `v`: a move is available, or a maximal unit arc about `v` is neither (Q) nor (R2). -/
def Todo (F : ArcMap k) (v : ℂ) : Prop := F.MoveAt v ∨ F.badCount v ≠ 0

/-- **The procedure's invariant** at a stage `G` of the run from `F`: a clean valid map of the plane, a modification of `F`,
whose sites are treatment points of `F`. -/
structure ProcInv (F G : ArcMap k) : Prop where
  /-- Valid. -/
  valid : G.Valid
  /-- Clean. -/
  clean : G.IsClean
  /-- Of the plane. -/
  plane : G.IsPlaneMap
  /-- A modification of the initial map. -/
  modif : F.IsModification G
  /-- No site but at an initial treatment point. -/
  sites : ∀ x, G.IsSite x → x ∈ F.treatPts

/-- A clean valid map of the plane satisfies the invariant over itself (the inhabitant of `ProcInv`; the run's first stage). -/
theorem ProcInv.refl (hF : F.Valid) (hP : F.IsPlaneMap) (hc : F.IsClean) : ProcInv F F :=
  ⟨hF, hc, hP, IsModification.refl F, fun _ hx => Or.inl hx⟩

/-- Under the invariant, something is left to do only at the initial map's treatment points. -/
theorem ProcInv.mem_treatPts_of_todo {G : ArcMap k} (h : ProcInv F G) {v : ℂ} (hv : G.Todo v) : v ∈ F.treatPts := by
  rcases hv with hmv | hb
  · refine h.sites v ?_
    by_contra hs
    have := not_available_of_not_isSite (by rw [h.plane]; trivial) hs
    exact hmv.elim this.1 fun h' => h'.elim this.2.1 this.2.2
  · rw [badCount, Ne, encard_eq_zero, ← Ne, ← nonempty_iff_ne_empty] at hb
    obtain ⟨⟨θ₁, θ₂⟩, c, c', hmax, -, -⟩ := hb
    have hA := hmax.1
    exact Or.inr ⟨ringPt v θ₁, h.modif.ringArcsWithin v _ ⟨θ₁, θ₂, hA.1, ⟨θ₁, ⟨le_rfl, hA.1.le⟩, rfl⟩, hA.2.1⟩⟩

/-- **One step of the procedure** from `G` to `G'` with support `U`, acting at `a` (`none`: idle; `some (t, true)`: a vertex step
at `t`; `some (t, false)`: an arc step at `t`), over the treatment points `T` indexed by `f`. -/
structure ProcStep (T : Set ℂ) (f : ℂ → ℕ) (G G' : ArcMap k) (U : Set ℂ) (a : Option (ℂ × Bool)) : Prop where
  /-- A local step. -/
  step : LocalStep G G' U
  /-- Its support is compact. -/
  isCompact : IsCompact U
  /-- No treatment point's potential rises. -/
  pot_le : ∀ x ∈ T, G'.pot x ≤ G.pot x
  /-- No treatment point gains a colour. -/
  col_sub : ∀ x ∈ T, G'.coloursAt x ⊆ G.coloursAt x
  /-- The idle step: nothing is left to do. -/
  idle : a = none → G' = G ∧ U = ∅ ∧ ∀ t ∈ T, ¬ G.Todo t
  /-- The point acted at is the least-index treatment point with something to do; the support is within `2` of it. -/
  least : ∀ t b, a = some (t, b) → t ∈ T ∧ G.Todo t ∧ (∀ t' ∈ T, G.Todo t' → f t ≤ f t') ∧ U ⊆ closedBall t 2
  /-- A vertex step lowers its point's potential. -/
  vert : ∀ t, a = some (t, true) → G'.pot t < G.pot t
  /-- An arc step lowers its point's bad count. -/
  arc : ∀ t, a = some (t, false) → G'.badCount t < G.badCount t
  /-- A treatment point's bad count rises only when it loses a colour or at a vertex step within `4` of it. -/
  bad_le : ∀ x ∈ T, G'.badCount x ≤ G.badCount x ∨ G'.coloursAt x ≠ G.coloursAt x ∨ ∃ t, a = some (t, true) ∧ dist x t ≤ 4

/-- **The idle step** (nothing left to do at any treatment point): the map kept, the empty support. The inhabitant of `ProcStep`. -/
theorem ProcStep.refl {T : Set ℂ} (f : ℂ → ℕ) {G : ArcMap k} (h : ∀ t ∈ T, ¬ G.Todo t) : ProcStep T f G G ∅ none :=
  ⟨LocalStep.refl G ∅, isCompact_empty, fun _ _ => le_rfl, fun _ _ => subset_rfl,
    fun _ => ⟨rfl, rfl, h⟩, fun _ _ h => absurd h (by simp), fun _ h => absurd h (by simp), fun _ h => absurd h (by simp),
    fun _ _ => Or.inl le_rfl⟩

/-- A ring arc is compact. -/
theorem isCompact_ringArc (p : ℂ) (θ₁ θ₂ : ℝ) : IsCompact (ringArc p θ₁ θ₂) :=
  isCompact_Icc.image (continuous_const.add continuous_e)

/-- A point of the closed `ε`-neighbourhood of a ring arc about `p` is at distance between `1 − ε` and `1 + ε` from `p`. -/
theorem dist_of_mem_cthickening_ringArc {p z : ℂ} {θ₁ θ₂ ε : ℝ} (hε : 0 ≤ ε) (hz : z ∈ cthickening ε (ringArc p θ₁ θ₂)) :
    1 - ε ≤ dist z p ∧ dist z p ≤ 1 + ε := by
  rw [(isCompact_ringArc p θ₁ θ₂).cthickening_eq_biUnion_closedBall hε] at hz
  obtain ⟨_, ⟨θ, -, rfl⟩, hzy⟩ := mem_iUnion₂.mp hz
  rw [mem_closedBall] at hzy
  have h1 := dist_triangle z (ringPt p θ) p
  have h2 := dist_triangle (ringPt p θ) z p
  rw [dist_ringPt] at h1 h2
  rw [dist_comm (ringPt p θ) z] at h2
  exact ⟨by linarith, by linarith⟩

/-- **The procedure's step exists**: at the least-index treatment point with something to do, a vertex step if a move is
available (`exists_vertexStep`, its radius below the distance to every other treatment point), else an arc step at a bad maximal
arc (`exists_arcStep`; its sides are not both at the centre, `mergeAvailable_of_bothKind`); idle if nothing is left. -/
theorem exists_procStep (hP : F.IsPlaneMap) (hc : F.IsClean) (f : ℂ → ℕ) {G : ArcMap k} (hG : ProcInv F G) :
    ∃ G' U a, ProcInv F G' ∧ ProcStep F.treatPts f G G' U a := by
  classical
  have hGd : ∀ x, x ∈ G.dom := fun x => by rw [hG.plane]; trivial
  have hT : ∀ K, IsCompact K → (K ∩ F.treatPts).Finite := fun K hK =>
    treatPts_inter_finite hP hc hK (by rw [hP]; exact subset_univ _)
  by_cases hex : ∃ t ∈ F.treatPts, G.Todo t
  swap
  · push Not at hex
    exact ⟨G, ∅, none, hG, ProcStep.refl f hex⟩
  -- the least-index point with something to do
  obtain ⟨t, ⟨htT, htodo⟩, hmin⟩ : ∃ t, (t ∈ F.treatPts ∧ G.Todo t) ∧
      ∀ t', t' ∈ F.treatPts ∧ G.Todo t' → f t ≤ f t' := by
    obtain ⟨t₀, ht₀⟩ := hex
    have hne : (f '' {t | t ∈ F.treatPts ∧ G.Todo t}).Nonempty := ⟨f t₀, t₀, ht₀, rfl⟩
    obtain ⟨t, ht, hft⟩ := Nat.sInf_mem hne
    exact ⟨t, ht, fun t' ht' => hft ▸ Nat.sInf_le ⟨t', ht', rfl⟩⟩
  have hleast : ∀ t' ∈ F.treatPts, G.Todo t' → f t ≤ f t' := fun t' h1 h2 => hmin t' ⟨h1, h2⟩
  by_cases hmv : G.MoveAt t
  · -- a vertex step
    obtain ⟨m, -, hdeg⟩ := exists_hasDegree_of_mem_dom (hGd t)
    obtain ⟨j, hhorn⟩ := exists_hasHornCount (hGd t)
    obtain ⟨δ, hδ0, hδ2, hδT⟩ : ∃ δ : ℝ, 0 < δ ∧ δ ≤ 1 / 2 ∧ ∀ x ∈ F.treatPts, x ≠ t → δ < dist x t := by
      have hfin : ((closedBall t 1 ∩ F.treatPts) \ {t}).Finite := (hT _ (isCompact_closedBall t 1)).sdiff
      obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp hfin.isClosed.isOpen_compl t (by simp)
      refine ⟨min (1 / 2) (ε / 2), by positivity, min_le_left _ _, fun x hx hxt => ?_⟩
      by_cases hx1 : dist x t ≤ 1
      · have : x ∉ ball t ε := fun hxb => hball hxb ⟨⟨mem_closedBall.mpr hx1, hx⟩, hxt⟩
        rw [mem_ball, not_lt] at this
        exact lt_of_lt_of_le (lt_of_le_of_lt (min_le_right _ _) (by linarith)) this
      · push Not at hx1
        exact lt_of_le_of_lt (min_le_left _ _) (by linarith)
    obtain ⟨ρ, hρ0, hρδ, G', hV, hC, hstep, hmod, ⟨m', j', hlt, hdeg', hhorn'⟩, hcol, hsite⟩ :=
      exists_vertexStep hG.valid hG.clean (covers_of_isPlaneMap hG.plane t 1) hmv hdeg hhorn hδ0
    have hUc : IsClosed (closedBall t ρ) := isClosed_closedBall
    have hoff : ∀ x ∈ F.treatPts, x ≠ t → x ∉ closedBall t ρ := fun x hx hxt hxb => by
      have := hδT x hx hxt; rw [mem_closedBall] at hxb; linarith
    have hpot : G'.pot t < G.pot t := by rw [pot_eq hdeg' hhorn', pot_eq hdeg hhorn]; exact hlt
    refine ⟨G', closedBall t ρ, some (t, true), ⟨hV, hC, ?_, hG.modif.trans hmod, ?_⟩,
      ⟨hstep, isCompact_closedBall t ρ, ?_, ?_, fun h => absurd h (by simp), ?_, ?_, fun _ h => absurd h (by simp), ?_⟩⟩
    · show G'.dom = univ
      rw [← hstep.agreesOff.1]; exact hG.plane
    · intro x hx
      by_cases hxb : x ∈ closedBall t ρ
      · by_cases hxt : x = t
        · exact hxt ▸ htT
        · exact absurd hx (hsite x hxb hxt)
      · exact hG.sites x ((isSite_iff_of_agreesOff hstep.agreesOff hUc hxb).mp hx)
    · intro x hx
      by_cases hxt : x = t
      · subst hxt; exact hpot.le
      · have hxb := hoff x hx hxt
        obtain ⟨mx, -, hmx⟩ := exists_hasDegree_of_mem_dom (hGd x)
        obtain ⟨jx, hjx⟩ := exists_hasHornCount (hGd x)
        rw [pot_eq ((hasDegree_iff_of_agreesOff hstep.agreesOff hUc hxb mx).mpr hmx)
          ((hasHornCount_iff_of_agreesOff hstep.agreesOff hUc hxb jx).mpr hjx), pot_eq hmx hjx]
    · intro x hx
      by_cases hxt : x = t
      · subst hxt; exact hcol
      · have hxb := hoff x hx hxt
        exact (coloursAt_eq_of_agreesOn (W := (closedBall t ρ)ᶜ) (by rw [compl_compl]; exact hstep.agreesOff)
          hUc.isOpen_compl hxb).subset
    · intro t' b h
      cases h
      exact ⟨htT, htodo, hleast, closedBall_subset_closedBall (by linarith)⟩
    · intro t' h
      cases h
      exact hpot
    · intro x hx
      by_cases hd : dist x t ≤ 4
      · exact Or.inr (Or.inr ⟨t, rfl, hd⟩)
      · push Not at hd
        refine Or.inl (le_of_eq (badCount_eq_of_agreesOff hstep.agreesOff hUc ?_))
        rw [Set.disjoint_left]
        intro z hz hz'
        rw [mem_closedBall] at hz hz'
        have := dist_triangle x z t
        rw [dist_comm x z] at this
        linarith
  · -- an arc step
    have hb : G.badCount t ≠ 0 := htodo.resolve_left hmv
    have hb' := hb
    rw [badCount, Ne, encard_eq_zero, ← Ne, ← nonempty_iff_ne_empty] at hb'
    obtain ⟨⟨θ₁, θ₂⟩, c, c', hmax, hQ, hR⟩ := hb'
    have hnb : ¬ (c ∈ G.coloursAt t ∧ c' ∈ G.coloursAt t) := by
      rintro ⟨h1, h2⟩
      by_cases h4 : 4 ≤ (G.coloursAt t).ncard
      · exact hQ ⟨c, c', hmax.1, h1, h2, h4⟩
      · exact hmv (Or.inl (mergeAvailable_of_bothKind hG.valid hG.plane hmax.1 h1 h2 (by omega)))
    obtain ⟨ε, hε0, hε2, G', hV, hC, hstep, hmod, hbad, hsites, hdegs, hhorns, hQs⟩ :=
      exists_arcStep hG.valid hG.clean hmax hQ hR hnb hT (show (0 : ℝ) < 1 / 2 by norm_num)
    have hUc : IsClosed (cthickening ε (ringArc t θ₁ θ₂)) := isClosed_cthickening
    have htU : t ∉ cthickening ε (ringArc t θ₁ θ₂) := fun h => by
      have := (dist_of_mem_cthickening_ringArc hε0.le h).1
      rw [dist_self] at this; linarith
    refine ⟨G', cthickening ε (ringArc t θ₁ θ₂), some (t, false), ⟨hV, hC, ?_, hG.modif.trans hmod,
      fun x hx => hG.sites x (hsites x hx)⟩,
      ⟨hstep, (isCompact_ringArc t θ₁ θ₂).cthickening, ?_, ?_, fun h => absurd h (by simp), ?_, fun _ h => absurd h (by simp), ?_, ?_⟩⟩
    · show G'.dom = univ
      rw [← hstep.agreesOff.1]; exact hG.plane
    · intro x _
      obtain ⟨mx, -, hmx⟩ := exists_hasDegree_of_mem_dom (hGd x)
      obtain ⟨jx, hjx⟩ := exists_hasHornCount (hGd x)
      obtain ⟨j', hj', hjx'⟩ := hhorns x jx hjx
      rw [pot_eq (hdegs x mx hmx) hjx', pot_eq hmx hjx]
      omega
    · intro x hx
      by_cases hxt : x = t
      · subst hxt
        exact (coloursAt_eq_of_agreesOn (W := (cthickening ε (ringArc x θ₁ θ₂))ᶜ)
          (by rw [compl_compl]; exact hstep.agreesOff) hUc.isOpen_compl htU).subset
      · exact (hQs x hx hxt).1
    · intro t' b h
      cases h
      refine ⟨htT, htodo, hleast, fun z hz => ?_⟩
      rw [mem_closedBall]
      linarith [(dist_of_mem_cthickening_ringArc hε0.le hz).2]
    · intro t' h
      cases h
      exact hbad
    · intro x hx
      by_cases hxt : x = t
      · subst hxt; exact Or.inl hbad.le
      · by_cases heq : G'.coloursAt x = G.coloursAt x
        · exact Or.inl ((hQs x hx hxt).2 heq)
        · exact Or.inr (Or.inl heq)

/-! ### A run of the procedure -/

/-- **A run of the procedure** from `F`: the stages, the supports, the points acted at. -/
structure ProcRun (F : ArcMap k) (f : ℂ → ℕ) where
  /-- The stages. -/
  G : ℕ → ArcMap k
  /-- The supports. -/
  U : ℕ → Set ℂ
  /-- The point acted at after stage `n`, and whether by a vertex step. -/
  a : ℕ → Option (ℂ × Bool)
  /-- Every stage satisfies the invariant. -/
  inv : ∀ n, ProcInv F (G n)
  /-- Every step is a step of the procedure. -/
  spec : ∀ n, ProcStep F.treatPts f (G n) (G (n + 1)) (U n) (a n)

/-- **The idle run** (the inhabitant of `ProcRun`): from a map satisfying the invariant with nothing left to do, every step
idle. -/
def ProcRun.const (f : ℂ → ℕ) (hInv : ProcInv F F) (h : ∀ t ∈ F.treatPts, ¬ F.Todo t) : ProcRun F f where
  G := fun _ => F
  U := fun _ => ∅
  a := fun _ => none
  inv := fun _ => hInv
  spec := fun _ => ProcStep.refl f h

namespace ProcRun

variable {f : ℂ → ℕ} (R : ProcRun F f)

/-- A treatment point is the centre of finitely many vertex steps (each lowers its potential, which never rises). -/
theorem finite_vert {x : ℂ} (hx : x ∈ F.treatPts) : {n | R.a n = some (x, true)}.Finite := by
  refine (finite_strict_of_antitone_off (fun n => (R.G n).pot x) finite_empty
    fun n _ => (R.spec n).pot_le x hx).subset ?_
  intro n hn
  exact (R.spec n).vert x hn

/-- A treatment point's colours change at finitely many stages (they only shrink). -/
theorem finite_colChange {x : ℂ} (hx : x ∈ F.treatPts) :
    {n | (R.G (n + 1)).coloursAt x ≠ (R.G n).coloursAt x}.Finite := by
  refine (finite_strict_of_antitone_off (fun n => ((R.G n).coloursAt x).ncard) finite_empty
    fun n _ => ncard_le_ncard ((R.spec n).col_sub x hx) (toFinite _)).subset ?_
  intro n hn
  exact ncard_lt_ncard (ssubset_of_subset_of_ne ((R.spec n).col_sub x hx) hn) (toFinite _)

/-- A treatment point is the centre of finitely many arc steps: each lowers its bad count, which rises only at the finitely
many stages where it loses a colour or a vertex step acts within `4` of it. -/
theorem finite_arc (hP : F.IsPlaneMap) (hc : F.IsClean) {x : ℂ} (hx : x ∈ F.treatPts) :
    {n | R.a n = some (x, false)}.Finite := by
  have hnear : (closedBall x 4 ∩ F.treatPts).Finite :=
    treatPts_inter_finite hP hc (isCompact_closedBall x 4) (by rw [hP]; exact subset_univ _)
  have hRfin : ({n | (R.G (n + 1)).coloursAt x ≠ (R.G n).coloursAt x} ∪
      ⋃ t ∈ closedBall x 4 ∩ F.treatPts, {n | R.a n = some (t, true)}).Finite :=
    (R.finite_colChange hx).union (hnear.biUnion fun t ht => R.finite_vert ht.2)
  have hfinite : ∀ n, (R.G n).badCount x ≠ ⊤ := fun n =>
    (badCount_lt_top (R.inv n).valid (R.inv n).plane x).ne
  refine (finite_strict_of_antitone_off (fun n => ((R.G n).badCount x).toNat) hRfin fun n hn => ?_).subset ?_
  · rcases (R.spec n).bad_le x hx with h | h | ⟨t, ht, hd⟩
    · exact ENat.toNat_le_toNat h (hfinite n)
    · exact absurd (Or.inl h) hn
    · refine absurd (Or.inr ?_) hn
      have htT := ((R.spec n).least t true ht).1
      exact mem_biUnion (show t ∈ closedBall x 4 ∩ F.treatPts from
        ⟨by rw [mem_closedBall, dist_comm]; exact hd, htT⟩) ht
  · intro n hn
    have hlt := (R.spec n).arc x hn
    obtain ⟨b, hb⟩ := ENat.ne_top_iff_exists.mp (hfinite n)
    obtain ⟨b', hb'⟩ := ENat.ne_top_iff_exists.mp (hfinite (n + 1))
    show ((R.G (n + 1)).badCount x).toNat < ((R.G n).badCount x).toNat
    rw [← hb, ← hb'] at hlt ⊢
    simpa using hlt

/-- **Each treatment point is acted at finitely often** (FS110-N4-TERM's count, with FS131-E6's potential). -/
theorem finite_acted (hP : F.IsPlaneMap) (hc : F.IsClean) {x : ℂ} (hx : x ∈ F.treatPts) :
    {n | ∃ b, R.a n = some (x, b)}.Finite := by
  refine ((R.finite_vert hx).union (R.finite_arc hP hc hx)).subset ?_
  rintro n ⟨b, hb⟩
  cases b
  · exact Or.inr hb
  · exact Or.inl hb

/-- **The supports are locally finite**: a support meeting `B(x, 1)` belongs to a step at a treatment point within `3` of `x`. -/
theorem locallyFinite (hP : F.IsPlaneMap) (hc : F.IsClean) : LocallyFinite R.U := by
  intro x
  refine ⟨ball x 1, ball_mem_nhds x one_pos, ?_⟩
  have hnear : (closedBall x 3 ∩ F.treatPts).Finite :=
    treatPts_inter_finite hP hc (isCompact_closedBall x 3) (by rw [hP]; exact subset_univ _)
  refine (hnear.biUnion fun t ht => R.finite_acted hP hc ht.2).subset ?_
  rintro n ⟨z, hzU, hzb⟩
  rcases h : R.a n with _ | ⟨t, b⟩
  · rw [((R.spec n).idle h).2.1] at hzU; exact absurd hzU (notMem_empty z)
  · obtain ⟨htT, -, -, hsub⟩ := (R.spec n).least t b h
    have hz2 := hsub hzU
    refine mem_biUnion (show t ∈ closedBall x 3 ∩ F.treatPts from ⟨?_, htT⟩) ⟨b, h⟩
    rw [mem_closedBall] at hz2 ⊢
    rw [mem_ball] at hzb
    have := dist_triangle t z x
    rw [dist_comm t z] at this
    linarith

/-- **Fairness**: at every point, from some stage on, nothing is left to do — past the finitely many stages acting at the
treatment points of index at most its own, a point with something to do would be the least-index choice. -/
theorem eventually_not_todo (hP : F.IsPlaneMap) (hc : F.IsClean) (hf : InjOn f F.treatPts) (v : ℂ) :
    ∀ᶠ n in atTop, ¬ (R.G n).Todo v := by
  by_cases hv : v ∈ F.treatPts
  swap
  · exact Eventually.of_forall fun n h => hv ((R.inv n).mem_treatPts_of_todo h)
  have hJ : {t | t ∈ F.treatPts ∧ f t ≤ f v}.Finite := by
    refine Set.Finite.of_finite_image ((finite_le_nat (f v)).subset ?_) (hf.mono fun t ht => ht.1)
    rintro _ ⟨t, ht, rfl⟩; exact ht.2
  have hfin : (⋃ t ∈ {t | t ∈ F.treatPts ∧ f t ≤ f v}, {n | ∃ b, R.a n = some (t, b)}).Finite :=
    hJ.biUnion fun t ht => R.finite_acted hP hc ht.1
  obtain ⟨N, hN⟩ := hfin.bddAbove
  filter_upwards [eventually_gt_atTop N] with n hn htodo
  rcases h : R.a n with _ | ⟨t, b⟩
  · exact ((R.spec n).idle h).2.2 v hv htodo
  · obtain ⟨htT, -, hmin, -⟩ := (R.spec n).least t b h
    have : n ≤ N := hN (mem_biUnion (show t ∈ {t | t ∈ F.treatPts ∧ f t ≤ f v} from
      ⟨htT, hmin v hv htodo⟩) ⟨b, h⟩)
    omega

end ProcRun

/-! ## The procedure and the terminal map -/

/-- **The procedure** (N4-TERM's enumeration with N2-RED's bends; FS131-E6's potential): from a clean valid plane map, a locally
finite sequence of local steps through clean valid modifications, after which, at every point, from some stage on, no move is
available and every unit arc about it is (Q) or (R2). Index `treatPts F` injectively by `ℕ` (countable: `treatPts_inter_finite` on
the discs `B̄(0, n)`); iterate `exists_procStep` (at the least-index point with something to do: a vertex step if a move is available,
`exists_vertexStep`, its radius below the distance to every other treatment point; else an arc step at a bad maximal arc, whose
sides are then not both at the centre by `mergeAvailable_of_bothKind`, `exists_arcStep`; idle if nothing is left). Each treatment
point is acted at finitely often (`ProcRun.finite_acted`), so the supports are locally finite (`ProcRun.locallyFinite`) and a point
with something to do from some stage on would be chosen (`ProcRun.eventually_not_todo`). Inhabitant of the hypotheses: a clean valid
plane map, e.g. `exists_clean` of `sevenBrickMap` (`sevenBrickMap_valid`, `sevenBrickMap_isPlaneMap`), as `exists_terminalMap` uses it. -/
theorem exists_terminalSeq (hF : F.Valid) (hP : F.IsPlaneMap) (hc : F.IsClean) :
    ∃ S : LocalSeq k, S.F 0 = F ∧ (∀ n, (S.F n).Valid ∧ F.IsModification (S.F n)) ∧
      ∀ v, ∀ᶠ n in atTop, ¬ (S.F n).MergeAvailable v ∧ ¬ (S.F n).RayAvailable v ∧ ¬ (S.F n).ShaveAvailable v ∧
        ∀ θ₁ θ₂ c c', (S.F n).IsRingArc v θ₁ θ₂ c c' → (S.F n).IsQArc v θ₁ θ₂ ∨ (S.F n).IsR2Arc v θ₁ θ₂ := by
  classical
  -- an injective index on the treatment points
  have hcount : F.treatPts.Countable := by
    have : F.treatPts = ⋃ n : ℕ, closedBall (0 : ℂ) n ∩ F.treatPts := by
      ext z
      simp only [mem_iUnion, mem_inter_iff, mem_closedBall, dist_zero_right]
      exact ⟨fun hz => ⟨⌈‖z‖⌉₊, Nat.le_ceil _, hz⟩, fun ⟨_, _, hz⟩ => hz⟩
    rw [this]
    exact countable_iUnion fun n =>
      (treatPts_inter_finite hP hc (isCompact_closedBall 0 n) (by rw [hP]; exact subset_univ _)).countable
  obtain ⟨f, hf⟩ := Set.countable_iff_exists_injOn.mp hcount
  have hInv0 : ProcInv F F := ProcInv.refl hF hP hc
  haveI : Nonempty (ArcMap k) := ⟨F⟩
  choose! nG nU na hn using fun (G : ArcMap k) (hG : ProcInv F G) => exists_procStep hP hc f hG
  let Gs : ℕ → ArcMap k := fun n => nG^[n] F
  have hInv : ∀ n, ProcInv F (Gs n) := by
    intro n
    induction n with
    | zero => exact hInv0
    | succ n ih =>
      show ProcInv F (nG^[n + 1] F)
      rw [Function.iterate_succ_apply']
      exact (hn _ ih).1
  have hSpec : ∀ n, ProcStep F.treatPts f (Gs n) (Gs (n + 1)) (nU (Gs n)) (na (Gs n)) := by
    intro n
    show ProcStep F.treatPts f (Gs n) (nG^[n + 1] F) _ _
    rw [Function.iterate_succ_apply']
    exact (hn _ (hInv n)).2
  let R : ProcRun F f := ⟨Gs, fun n => nU (Gs n), fun n => na (Gs n), hInv, hSpec⟩
  refine ⟨⟨Gs, R.U, fun n => (hSpec n).step, fun n => (hSpec n).isCompact, R.locallyFinite hP hc⟩, rfl,
    fun n => ⟨(hInv n).valid, (hInv n).modif⟩, fun v => ?_⟩
  filter_upwards [R.eventually_not_todo hP hc hf v] with n hn
  have hnm : ¬ (Gs n).MoveAt v := fun h => hn (Or.inl h)
  refine ⟨fun h => hnm (Or.inl h), fun h => hnm (Or.inr (Or.inl h)), fun h => hnm (Or.inr (Or.inr h)), ?_⟩
  have hb : (Gs n).badCount v = 0 := by
    by_contra hb
    exact hn (Or.inr hb)
  exact (badCount_eq_zero_iff (hInv n).valid (hInv n).plane v).mp hb

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
theorem const_treatPts (j : Fin 2) : (ArcMap.const univ isOpen_univ j).treatPts = ∅ := by
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


/-- Nothing is left to do on the one-colour plane (a spec example for `MoveAt` and `Todo`: no site, so no move, `const_treatPts`;
no ring arc, so no bad arc). -/
example (j : Fin 2) (v : ℂ) : ¬ (ArcMap.const univ isOpen_univ j).Todo v := by
  rintro (hmv | hb)
  · have hs : ¬ (ArcMap.const univ isOpen_univ j).IsSite v := fun hs =>
      (const_treatPts j ▸ (Or.inl hs : v ∈ (ArcMap.const univ isOpen_univ j).treatPts) : v ∈ (∅ : Set ℂ))
    have := not_available_of_not_isSite (F := ArcMap.const univ isOpen_univ j) (mem_univ v) hs
    exact hmv.elim this.1 fun h' => h'.elim this.2.1 this.2.2
  · refine hb ?_
    rw [ArcMap.badCount, encard_eq_zero, eq_empty_iff_forall_notMem]
    rintro ⟨θ₁, θ₂⟩ ⟨c, c', ⟨⟨h12, hsub, -⟩, -⟩, -⟩
    have := hsub ⟨θ₁, ⟨le_rfl, h12.le⟩, rfl⟩
    simp [ArcMap.Γ, ArcMap.const] at this

/-- **Adversary** for `Todo`: a bad maximal arc alone is something to do, and so is an available MERGE alone. -/
example {k : ℕ} (F : ArcMap k) (v : ℂ) (h : F.badCount v ≠ 0) : F.Todo v := Or.inr h

example {k : ℕ} (F : ArcMap k) (v : ℂ) (h : F.MergeAvailable v) : F.Todo v := Or.inl (Or.inl h)

/-- The potential is the degree plus the horn count wherever the map is defined (a spec example for `pot`: both exist at every
point of the domain, and `pot` is their sum — not `0`, its value where either is undefined). -/
example {k : ℕ} (F : ArcMap k) {v : ℂ} (hv : v ∈ F.dom) :
    ∃ m j, 1 ≤ m ∧ F.HasDegree v m ∧ F.HasHornCount v j ∧ F.pot v = m + j := by
  obtain ⟨X⟩ := exists_near hv
  obtain ⟨j, hj⟩ := exists_hasHornCount hv
  exact ⟨max X.n 1, j, le_max_right _ _, X.hC.hasDegree, hj, pot_eq X.hC.hasDegree hj⟩

/-- A clean valid map of the plane satisfies the procedure's invariant over itself (a spec example for `ProcInv`; the run's
first stage). -/
example {k : ℕ} {F : ArcMap k} (hF : F.Valid) (hP : F.IsPlaneMap) (hc : F.IsClean) :
    ProcInv F F ∧ ∀ x, F.IsSite x → x ∈ F.treatPts :=
  ⟨ProcInv.refl hF hP hc, (ProcInv.refl hF hP hc).sites⟩

/-- **Adversary** for `ProcStep`: an idle step is not a vertex step — its acted point is `none`, so no potential is claimed to
fall (the `vert` clause is read only at `some (t, true)`). -/
example {k : ℕ} {T : Set ℂ} (f : ℂ → ℕ) {G : ArcMap k} (h : ∀ t ∈ T, ¬ G.Todo t) (t : ℂ) :
    (none : Option (ℂ × Bool)) ≠ some (t, true) ∧ ProcStep T f G G ∅ none :=
  ⟨by simp, ProcStep.refl f h⟩


/-- A one-coloured segment is dropped by the kept-colour clean map too (a spec example for `cleanKeep`: its `Γ` is the essential
set, `halfDiscMono_essSet`). -/
example : halfDiscMono.cleanKeep.Γ = ∅ := cleanKeep_Γ.trans halfDiscMono_essSet

/-- **Adversary** for `cleanKeep`: on the essential set it keeps the old colour function — what `ArcMap.clean` does not promise and
`LocalStep` reads. -/
example {k : ℕ} (F : ArcMap k) {z : ℂ} (hz : z ∈ F.essSet) : F.cleanKeep.col z = F.col z :=
  cleanKeep_col_of_not_mem fun h => h.2 hz

/-- Cleaning a clean map is an idle step (the inhabitant of `LocalStep.cleanKeep`'s hypotheses: the idle step of a clean map, on the
empty support). -/
example {k : ℕ} {F : ArcMap k} (hc : F.IsClean) : LocalStep F F.cleanKeep ∅ := (LocalStep.refl F ∅).cleanKeep hc isClosed_empty

end Spec

end HadwigerNelson.Plane
