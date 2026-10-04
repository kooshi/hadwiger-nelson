import Proofs.HadwigerNelson.Plane.Woodall.NoFourFive

/-!
# Maps need six, almost everywhere: Woodall's Theorem 6 as repaired and restored (FS106-AE-MAP6, FS106-WO)

FS131-W's skeleton (`plans/FS131-W-kernel-plan.md` § 3), re-planned by FS131-W2 (§§ 6–9) on FS131-E1's restoration
(`plans/FS131-E1-derivation.md` § 3.8, E1-MAPS6), over arc maps (inventory item 89: the general Jordan form owed). A five-coloured arc map of the
plane, **valid** (D-AEMAP: no two interior points of one colour at distance exactly `1`; boundaries carry no colour), does not exist.

The chain, region-only, on the picture at a point (`ArcMap.SectorsAt`):
* `exists_sectorsAt`: every point of a map of the plane has a picture (Woodall's steps 1–2 are free for arcs);
* **step 3** (`exists_woodallMerged`): a valid map can be recoloured, near its vertices, into one whose repeated colours sit on zero-angle sectors
  only (a modification; it keeps validity, the plane, and Condition 5);
* **strict step 5** (`step5_lt`): no sector of angle `< π/3` between two neighbours of distinct colours, so a merged map is in normal form, angles
  `≥ π/3` (inside `aeMap6_merged`) — no angle equal to `π/3` is ever read (FS131-E1's E1-Q1);
* **step 6** (`step6`, by Townsend's `π/3` lemma `townsend_lemma`): no point of three sectors in normal form;
* **E1-NO45** (`false_of_four_le_sectors`, from `Plane/Woodall/NoFourFive`): no point of four or five sectors in normal form, with at most five
  colours — in place of Woodall's steps 7–8, whose printed forms have GAPs (FS131-W § 1.4: F1, F2);
* **E1-NOBRANCH**: a point of at least three sectors exists (`exists_three_le_sectors`, from FS106-TS-T, `ArcMap.ts_t`; no Jordan curve theorem).

**The rows.** FS106-AE-MAP6 is `ArcMap.aeMap6`, with `ArcMap.aeMap6_of_condition5` its corollary under Condition 5; FS106-WO's Theorem 6 is
`woodall_thm6` (everywhere-proper sets divisible into regions, a corollary), its step-4 lemma `woodall_step4` (`Plane/Woodall/Collar`); FS106-TW is
`townsend_lemma` (`Plane/Woodall/Collar`), whose Theorem 4 Corollary is `step6`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

theorem finRotate_ne_symm {n : ℕ} (hn : 3 ≤ n) (i : Fin n) : finRotate n i ≠ (finRotate n).symm i := by
  obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 := ⟨n - 1, by omega⟩
  intro h
  have h2 : finRotate (m + 1) (finRotate (m + 1) i) = i := by
    conv_lhs => rw [h]
    exact (finRotate (m + 1)).apply_symm_apply i
  rw [finRotate_apply, finRotate_apply] at h2
  have h3 : (1 + 1 : Fin (m + 1)) = 0 := by
    have : i + (1 + 1) = i + 0 := by rw [add_zero, ← add_assoc]; exact h2
    exact add_left_cancel this
  have h4 := congrArg Fin.val h3
  rw [Fin.val_add] at h4
  simp at h4
  rw [Nat.mod_eq_of_lt (by omega)] at h4
  omega

/-! ## Collars and normals: the real-variable children of steps 5 and 6 (FS131-IWb) -/

/-- Finitely many collars about one angle, on one side, intersect in a collar. -/
theorem collarAt_setOf_forall_mem {ι : Type*} (T : Finset ι) (S : ι → Set ℂ) {u : ℂ} {s : Rim} {θ : ℝ}
    (h : ∀ i ∈ T, CollarAt (S i) u s θ) : CollarAt {z | ∀ i ∈ T, z ∈ S i} u s θ := by
  classical
  induction T using Finset.induction_on with
  | empty => exact ⟨1, one_pos, fun z _ i hi => absurd hi (Finset.notMem_empty i)⟩
  | insert a T ha ih =>
    have h1 := h a (Finset.mem_insert_self a T)
    have h2 := ih (fun i hi => h i (Finset.mem_insert_of_mem hi))
    refine (h1.inter h2).mono ?_
    rintro z ⟨hz1, hz2⟩ i hi
    rcases Finset.mem_insert.mp hi with rfl | hi
    · exact hz1
    · exact hz2 i hi

/-- A collar of thickness `h` about `y` is a collar about every angle within `h/2` of `y`. -/
theorem CollarAt.of_abs_sub_lt {S : Set ℂ} {u : ℂ} {s : Rim} {y h : ℝ} (hh : 0 < h) (hsub : collar u s (y - h) (y + h) h ⊆ S)
    {y' : ℝ} (hy : |y' - y| < h / 2) : CollarAt S u s y' := by
  obtain ⟨h1, h2⟩ := abs_lt.mp hy
  exact ⟨h / 2, by linarith, (collar_subset_collar u s (by linarith) (by linarith) (by linarith)).trans hsub⟩

/-- `cos (γ − θ)` does not vanish on a whole interval of positive length (its zeros are `π` apart). -/
theorem false_of_cos_eq_zero_on_Icc {a b θ : ℝ} (hab : a < b) (h : ∀ γ ∈ Icc a b, Real.cos (γ - θ) = 0) : False := by
  set t := min (b - a) 1 with ht
  have ht0 : 0 < t := lt_min (by linarith) one_pos
  have htb : a + t ≤ b := by linarith [min_le_left (b - a) 1]
  have htπ : t < π := by linarith [min_le_right (b - a) 1, Real.two_le_pi]
  have h1 := h a ⟨le_rfl, hab.le⟩
  have h2 := h (a + t) ⟨by linarith, htb⟩
  rw [show a + t - θ = (a - θ) + t by ring, Real.cos_add, h1, zero_mul, zero_sub, neg_eq_zero] at h2
  have hs : Real.sin (a - θ) ^ 2 = 1 := by have := Real.sin_sq_add_cos_sq (a - θ); rw [h1] at this; linarith
  have hst : Real.sin t = 0 := by
    rcases mul_eq_zero.mp h2 with h3 | h3
    · rw [h3] at hs; norm_num at hs
    · exact h3
  exact absurd hst (Real.sin_pos_of_pos_of_lt_pi ht0 htπ).ne'

/-- If `cos (e − θ) = 0`, then `θ` is a normal `e ± π/2` of the direction `e`, mod `2π`. -/
theorem exists_eq_add_half_pi_of_cos_eq_zero {e θ : ℝ} (h : Real.cos (e - θ) = 0) :
    ∃ σ : ℝ, (σ = 1 ∨ σ = -1) ∧ ∃ m : ℤ, θ = e + σ * (π / 2) + 2 * π * m := by
  obtain ⟨n, hn⟩ := Real.cos_eq_zero_iff.mp h
  obtain ⟨m, rfl | rfl⟩ := Int.even_or_odd' n
  · exact ⟨-1, Or.inr rfl, -m, by push_cast at hn ⊢; linear_combination -hn⟩
  · exact ⟨1, Or.inl rfl, -m - 1, by push_cast at hn ⊢; linear_combination -hn⟩

/-- `cos` is negative on `(π/2, 3π/2)`. -/
theorem cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two {x : ℝ} (h1 : π / 2 < x) (h2 : x < 3 * π / 2) : Real.cos x < 0 :=
  Real.cos_neg_of_pi_div_two_lt_of_lt h1 (by linarith)

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## The picture at a point -/

/-- **Every point of a map of the plane has a picture**: finitely many arcs pass near `v`, each leaves `v` in a direction (segments and circular
arcs have tangents); the sectors between consecutive directions (two tangent arcs bounding a horn), with adjacent sectors of one colour
merged, are the picture. -/
theorem exists_sectorsAt (hP : F.IsPlaneMap) (v : ℂ) : ∃ n d c, F.SectorsAt v n d c := by
  sorry

/-- **A point in the closure of a set is approached along some direction** (compactness of the circle of directions). -/
theorem coneAt_nonempty_of_mem_closure_region (j : Fin k) {v : ℂ} (hv : v ∈ closure (F.region j)) :
    (coneAt (F.region j) v).Nonempty := by
  by_contra hempty
  rw [Set.not_nonempty_iff_eq_empty] at hempty
  -- every direction has a radius `ε_β` and a window with no point of `region j` approaching along it
  have hno : ∀ β : ℝ, ∃ ε > 0, ∀ z ∈ F.region j, z ≠ v → dist z v < ε → ε ≤ ‖(z - v) / (‖z - v‖ : ℂ) - e β‖ := by
    intro β
    have hβ : β ∉ coneAt (F.region j) v := by rw [hempty]; exact id
    simp only [coneAt, mem_setOf_eq, not_forall, not_exists, not_and, not_lt] at hβ
    obtain ⟨ε, hε, h⟩ := hβ
    exact ⟨ε, hε, fun z hz hne hd => h z hz hne hd⟩
  choose ε hε hεno using hno
  have hopen : ∀ β ∈ Icc (0 : ℝ) (2 * π), IsOpen {β' : ℝ | ‖e β' - e β‖ < ε β / 2} := fun β _ =>
    isOpen_lt (by have := continuous_e; fun_prop) continuous_const
  obtain ⟨t, htsub, htfin, htcov⟩ := isCompact_Icc.elim_finite_subcover_image hopen
    (fun β hβ => mem_iUnion₂.mpr ⟨β, hβ, by simp [hε β]⟩)
  obtain ⟨ε', hε', hle⟩ := exists_pos_le_finset htfin.toFinset (fun β => ε β / 2) (fun β => by have := hε β; positivity)
  -- a point of the class near `v`, other than `v`
  obtain ⟨z, hz, hzv, hzd⟩ : ∃ z ∈ F.region j, z ≠ v ∧ dist z v < ε' := by
    obtain ⟨z, hz, hd⟩ := Metric.mem_closure_iff.mp hv ε' hε'
    by_cases hne : z = v
    · subst hne
      obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp (F.isOpen_region j) z hz
      refine ⟨z + ((min r ε' / 2 : ℝ) : ℂ), hball ?_, ?_, ?_⟩
      · rw [Metric.mem_ball, dist_eq_norm, add_sub_cancel_left, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by positivity)]
        have := min_le_left r ε'; linarith
      · intro h0
        have := congrArg (fun w => w - z) h0
        simp only [add_sub_cancel_left, sub_self] at this
        have h1 : (0 : ℝ) < min r ε' / 2 := by positivity
        exact h1.ne' (by exact_mod_cast this)
      · rw [dist_eq_norm, add_sub_cancel_left, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by positivity)]
        have := min_le_right r ε'; linarith
    · exact ⟨z, hz, hne, by rw [dist_comm]; exact hd⟩
  -- its direction is `e β₁` for some `β₁ ∈ [0, 2π]`
  have hp : (0 : ℝ) < 2 * π := by positivity
  set β₀ := Complex.arg (z - v) with hβ₀
  have hdir : (z - v) / (‖z - v‖ : ℂ) = e β₀ := by
    have hn : (‖z - v‖ : ℂ) ≠ 0 := by exact_mod_cast norm_ne_zero_iff.mpr (sub_ne_zero.mpr hzv)
    rw [div_eq_iff hn, e, mul_comm]
    exact (Complex.norm_mul_exp_arg_mul_I (z - v)).symm
  set β₁ := toIcoMod hp 0 β₀ with hβ₁
  have hβ₁I : β₁ ∈ Icc (0 : ℝ) (2 * π) := ⟨(toIcoMod_mem_Ico hp 0 β₀).1, by have := (toIcoMod_mem_Ico hp 0 β₀).2; linarith⟩
  have heβ₁ : e β₁ = e β₀ := by
    obtain ⟨-, m, hm⟩ := (toIcoMod_eq_iff hp (a := 0) (b := β₀) (c := β₁)).mp rfl
    rw [hm, zsmul_eq_mul]
    have := e_add_int_mul_two_pi β₁ m
    rw [show β₁ + (m : ℝ) * (2 * π) = β₁ + 2 * π * m by ring] at *
    exact this.symm ▸ rfl
  obtain ⟨β, hβt, hβ₁β⟩ := mem_iUnion₂.mp (htcov hβ₁I)
  have hlt : ‖e β₁ - e β‖ < ε β / 2 := hβ₁β
  have hεβ : ε' ≤ ε β / 2 := hle β (htfin.mem_toFinset.mpr hβt)
  have := hεno β z hz hzv (by linarith)
  rw [hdir, ← heβ₁] at this
  linarith

/-- The colours at a point are the colours of its picture's sectors. -/
theorem SectorsAt.coloursAt_eq {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k} (h : F.SectorsAt v n d c) :
    F.coloursAt v = range c := by
  ext j
  constructor
  · intro hj
    obtain ⟨β, hβ⟩ := coneAt_nonempty_of_mem_closure_region j hj
    rw [h.2.2.2.2.2 j] at hβ
    obtain ⟨i, hi, -⟩ := mem_iUnion₂.mp hβ
    exact ⟨i, hi⟩
  · rintro ⟨i, rfl⟩
    have hcone : d i.castSucc ∈ coneAt (F.region (c i)) v := by
      rw [h.2.2.2.2.2]
      exact mem_iUnion₂.mpr ⟨i, rfl, mem_iUnion.mpr ⟨0, by simp [h.2.1 (Fin.castSucc_le_succ i)]⟩⟩
    exact mem_closure_of_mem_coneAt hcone

/-! ## Woodall's step 3: merging repeated colours at a vertex (a modification) -/

/-- **Woodall's step 3** (`[Woodall1973]` p. 197): a valid map of the plane can be recoloured near its vertices — two sectors of one colour at
`P` are joined across a run of sectors of angle `< π` between them (every unit circle through a point of the run near `P`, except those through
`P`, passes through one of the two; the run is clear for their colour), and two horns in Woodall's cone fill it — into a valid map of the plane
whose repeated colours sit on zero-angle sectors only. The new boundary arcs are circles of small radius about the vertices, so Condition 5 is
kept. -/
theorem exists_woodallMerged (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.IsPlaneMap ∧ F'.WoodallMerged ∧ (F.Condition5 → F'.Condition5) := by
  sorry

/-! ## Woodall's step 5, strict: every angle at least `π/3` -/

/-- In a valid map no colour class holds a unit pair. -/
theorem Valid.region_dist_ne_one (hF : F.Valid) (j : Fin k) : ∀ x ∈ F.region j, ∀ y ∈ F.region j, dist x y ≠ 1 :=
  fun x hx y hy hd => hF x hx.1 y hy.1 hd ((show F.col x = j from hx.2).trans (show F.col y = j from hy.2).symm)

/-- With at most five colours, the colours outside a set of at least three are covered by two. -/
theorem exists_two_cover_of_three_le_card (hk : k ≤ 5) {T : Finset (Fin k)} (hT : 3 ≤ T.card) :
    ∃ X Y : Fin k, ∀ c ∉ T, c = X ∨ c = Y := by
  classical
  obtain ⟨x₀, -⟩ := Finset.card_pos.mp (by omega : 0 < T.card)
  have hc : Tᶜ.card ≤ 2 := by rw [Finset.card_compl, Fintype.card_fin]; omega
  interval_cases h : Tᶜ.card
  · exact ⟨x₀, x₀, fun c hc' => absurd (Finset.mem_compl.mpr hc') (by rw [Finset.card_eq_zero.mp h]; simp)⟩
  · obtain ⟨a, ha⟩ := Finset.card_eq_one.mp h
    exact ⟨a, a, fun c hc' => Or.inl (by simpa [ha] using Finset.mem_compl.mpr hc')⟩
  · obtain ⟨a, b, -, hab⟩ := Finset.card_eq_two.mp h
    exact ⟨a, b, fun c hc' => by simpa [hab] using Finset.mem_compl.mpr hc'⟩

/-- **The excluded set as a collar**: in a valid map of the plane, if a collar about `θ` (side `s`) lies in the shadow of every colour of `T`, and the
colours outside `T` are among `X`, `Y`, then a collar about `θ` lies in `closure (region X ∪ region Y)` (`subset_closure_of_subset_shadow`). -/
theorem collarAt_closure_of_forall_shadow (hF : F.Valid) (hP : F.IsPlaneMap) {T : Finset (Fin k)} {X Y : Fin k}
    (hXY : ∀ c ∉ T, c = X ∨ c = Y) {v : ℂ} {s : Rim} {θ : ℝ}
    (hT : ∀ c ∈ T, CollarAt (shadow (F.region c)) v s θ) :
    CollarAt (closure (F.region X ∪ F.region Y)) v s θ := by
  obtain ⟨h, hh, hsub⟩ := collarAt_setOf_forall_mem T (fun c => shadow (F.region c)) hT
  have hh'0 : 0 < min h 1 := lt_min hh one_pos
  have hW : collar v s (θ - min h 1) (θ + min h 1) (min h 1) ⊆ collar v s (θ - h) (θ + h) h :=
    collar_subset_collar v s (by linarith [min_le_left h 1]) (by linarith [min_le_left h 1]) (min_le_left _ _)
  refine ⟨min h 1, hh'0, ?_⟩
  have := subset_closure_of_subset_shadow hF hP (T := T) (isOpen_collar v s _ _ (min_le_right h 1))
    (fun c hc z hz => hsub (hW hz) c hc)
  refine this.trans (closure_mono ?_)
  intro z hz
  obtain ⟨c, hc, hzc⟩ := mem_iUnion₂.mp hz
  rcases hXY c (Finset.mem_compl.mp hc) with rfl | rfl
  · exact Or.inl hzc
  · exact Or.inr hzc

/-- **The inner arc opposite a sector** (step 5's set-up): for `ψ` in `(d i.succ − 3π/2, d i.castSucc − π/2)`, the colours of sector `i` and of its two
neighbours all put an inner collar about `ψ` in their shadows — the two edges of sector `i` lie in the far half `(ψ + π/2, ψ + 3π/2)` and in the cones of
the three colours (the cone clause; the neighbours' cones hold the shared edges, mod `2π`), and the connected piece (`collarAt_shadow_inner_of_mem_coneAt`)
turns each into a collar. A horn (sector `i` or a neighbour of angle `0`) needs nothing more. -/
theorem SectorsAt.collarAt_opposite {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (i : Fin n) {ψ : ℝ} (hψ : ψ ∈ Ioo (d i.succ - 3 * π / 2) (d i.castSucc - π / 2)) :
    ∀ x ∈ ({c i, c (finRotate n i), c ((finRotate n).symm i)} : Finset (Fin k)), CollarAt (shadow (F.region x)) v .inner ψ := by
  have hv : v ∈ F.dom := h.2.2.2.2.1
  have hle : d i.castSucc ≤ d i.succ := h.2.1 (Fin.castSucc_le_succ i)
  have hc1 : Real.cos (d i.castSucc - ψ) < 0 := cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two (by linarith [hψ.2]) (by linarith [hψ.1])
  have hc2 : Real.cos (d i.succ - ψ) < 0 := cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two (by linarith [hψ.2]) (by linarith [hψ.1])
  have hi1 : d i.castSucc ∈ coneAt (F.region (c i)) v := h.mem_coneAt_of_mem_Icc i ⟨le_rfl, hle⟩
  have hp : d i.castSucc ∈ coneAt (F.region (c ((finRotate n).symm i))) v := by
    have hm := h.mem_coneAt_of_mem_Icc ((finRotate n).symm i) ⟨h.2.1 (Fin.castSucc_le_succ _), le_rfl⟩
    rcases d_prev_succ h.2.2.1 i with ⟨he, -⟩ | ⟨he, -⟩
    · rwa [he] at hm
    · rw [he] at hm; exact mem_coneAt_add_two_pi.mp hm
  have hnx : d i.succ ∈ coneAt (F.region (c (finRotate n i))) v := by
    have hm := h.mem_coneAt_of_mem_Icc (finRotate n i) ⟨le_rfl, h.2.1 (Fin.castSucc_le_succ _)⟩
    have hpi : (finRotate n).symm (finRotate n i) = i := (finRotate n).symm_apply_apply i
    rcases d_prev_succ h.2.2.1 (finRotate n i) with ⟨he, -⟩ | ⟨he, -⟩
    · rw [hpi] at he; rwa [he]
    · rw [hpi] at he; rw [he]; exact mem_coneAt_add_two_pi.mpr hm
  intro x hx
  simp only [Finset.mem_insert, Finset.mem_singleton] at hx
  rcases hx with rfl | rfl | rfl
  · exact collarAt_shadow_inner_of_mem_coneAt hv hi1 hc1
  · exact collarAt_shadow_inner_of_mem_coneAt hv hnx hc2
  · exact collarAt_shadow_inner_of_mem_coneAt hv hp hc1


/-- **Woodall's step 5, strict** (`[Woodall1973]` p. 198, repaired): in a valid map of the plane with at most five colours, no sector of angle
`< π/3` lies between two neighbours of distinct colours (at a point of at least three sectors) — the inner arc opposite it, of length
`> 2π/3`, is coloured by the two remaining colours, against `woodall_step4`. -/
theorem step5_lt (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ}
    {c : Fin n → Fin k} (h : F.SectorsAt v n d c) (hn : 3 ≤ n) (i : Fin n) (hang : d i.succ - d i.castSucc < π / 3)
    (hnb : c (finRotate n i) ≠ c ((finRotate n).symm i)) : False := by
  classical
  have hadj := h.2.2.2.1 (by omega)
  have h1 : c i ≠ c (finRotate n i) := hadj i
  have h2 : c i ≠ c ((finRotate n).symm i) := by
    have := hadj ((finRotate n).symm i)
    rw [(finRotate n).apply_symm_apply i] at this
    exact Ne.symm this
  have hT : ({c i, c (finRotate n i), c ((finRotate n).symm i)} : Finset (Fin k)).card = 3 :=
    Finset.card_eq_three.mpr ⟨_, _, _, h1, h2, hnb, rfl⟩
  obtain ⟨X, Y, hXY⟩ := exists_two_cover_of_three_le_card hk hT.ge
  exact woodall_step4 (F.isOpen_region X) (F.isOpen_region Y) (hF.region_dist_ne_one X) (hF.region_dist_ne_one Y)
    (u := v) .inner (θ₁ := d i.succ - 3 * π / 2) (θ₂ := d i.castSucc - π / 2) (by linarith)
    (fun ψ hψ => collarAt_closure_of_forall_shadow hF hP hXY (h.collarAt_opposite i hψ))


/-! ## Woodall's step 6, and E1-NO45 in place of his steps 7–8 -/

/-- **Woodall's step 6, repaired by Townsend's `π/3` lemma** (`[Woodall1973]` p. 198; `[Townsend1979ms]` Thm 4's Corollary): in a valid map of
the plane with at most five colours, no point has a picture of three sectors of distinct colours, each of angle at least `π/3`. The three
excluded sets of the sectors' colours leave two colours around `ω(v)`; collars exist about every angle except the edges' normals; at each edge one
normal carries a collar by the refined second-order lemma (`SectorsAt.exists_normal_collarAt`), so at most three cut angles; some one-sided arc
exceeds `π/3` (a sector of angle `< 2π/3`, or, all three `2π/3`, a certified normal). -/
theorem step6 (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {d : Fin 4 → ℝ} {c : Fin 3 → Fin k}
    (h : F.SectorsAt v 3 d c) (hc : Function.Injective c) (hang : ∀ i : Fin 3, π / 3 ≤ d i.succ - d i.castSucc) : False := by
  classical
  have hv : v ∈ F.dom := h.2.2.2.2.1
  have hpi := Real.pi_pos
  have hlast : d 3 = d 0 + 2 * π := h.2.2.1
  have ha0 : π / 3 ≤ d 1 - d 0 := hang 0
  have ha1 : π / 3 ≤ d 2 - d 1 := hang 1
  have ha2 : π / 3 ≤ d 3 - d 2 := hang 2
  have hS0 : d 0 < d 1 := by linarith
  have hS1 : d 1 < d 2 := by linarith
  have hS2 : d 2 < d 3 := by linarith
  have hc3 : ∀ θ, Real.cos (d 3 - θ) = Real.cos (d 0 - θ) := fun θ => by
    rw [hlast, show d 0 + 2 * π - θ = (d 0 - θ) + 2 * π by ring, Real.cos_add_two_pi]
  -- the three colours, and the two others
  have hT : ({c 0, c 1, c 2} : Finset (Fin k)).card = 3 :=
    Finset.card_eq_three.mpr ⟨_, _, _, fun h' => absurd (hc h') (by decide), fun h' => absurd (hc h') (by decide),
      fun h' => absurd (hc h') (by decide), rfl⟩
  obtain ⟨X, Y, hXY⟩ := exists_two_cover_of_three_le_card hk hT.ge
  -- first order: a direction of every sector on the far (near) side of `ψ` gives an inner (outer) collar
  have hin : ∀ ψ : ℝ, ((∃ γ ∈ Icc (d 0) (d 1), Real.cos (γ - ψ) < 0) ∧ (∃ γ ∈ Icc (d 1) (d 2), Real.cos (γ - ψ) < 0) ∧
        (∃ γ ∈ Icc (d 2) (d 3), Real.cos (γ - ψ) < 0)) → CollarAt (closure (F.region X ∪ F.region Y)) v .inner ψ := by
    rintro ψ ⟨⟨γ₀, h₀, c₀⟩, ⟨γ₁, h₁, c₁⟩, ⟨γ₂, h₂, c₂⟩⟩
    refine collarAt_closure_of_forall_shadow hF hP hXY fun x hx => ?_
    simp only [Finset.mem_insert, Finset.mem_singleton] at hx
    rcases hx with rfl | rfl | rfl
    · exact collarAt_shadow_inner_of_mem_coneAt hv (h.mem_coneAt_of_mem_Icc 0 h₀) c₀
    · exact collarAt_shadow_inner_of_mem_coneAt hv (h.mem_coneAt_of_mem_Icc 1 h₁) c₁
    · exact collarAt_shadow_inner_of_mem_coneAt hv (h.mem_coneAt_of_mem_Icc 2 h₂) c₂
  have hout : ∀ ψ : ℝ, ((∃ γ ∈ Icc (d 0) (d 1), 0 < Real.cos (γ - ψ)) ∧ (∃ γ ∈ Icc (d 1) (d 2), 0 < Real.cos (γ - ψ)) ∧
        (∃ γ ∈ Icc (d 2) (d 3), 0 < Real.cos (γ - ψ))) → CollarAt (closure (F.region X ∪ F.region Y)) v .outer ψ := by
    rintro ψ ⟨⟨γ₀, h₀, c₀⟩, ⟨γ₁, h₁, c₁⟩, ⟨γ₂, h₂, c₂⟩⟩
    refine collarAt_closure_of_forall_shadow hF hP hXY fun x hx => ?_
    simp only [Finset.mem_insert, Finset.mem_singleton] at hx
    rcases hx with rfl | rfl | rfl
    · exact collarAt_shadow_outer_of_mem_coneAt hv (h.mem_coneAt_of_mem_Icc 0 h₀) c₀
    · exact collarAt_shadow_outer_of_mem_coneAt hv (h.mem_coneAt_of_mem_Icc 1 h₁) c₁
    · exact collarAt_shadow_outer_of_mem_coneAt hv (h.mem_coneAt_of_mem_Icc 2 h₂) c₂
  -- the cut angles: the normals of the three edges
  set K : Set ℝ := (fun p : Fin 3 × ℝ => d p.1.castSucc + p.2 * (π / 2)) '' (univ ×ˢ {1, -1}) with hK
  have hKfin : K.Finite := (Set.finite_univ.prod (Set.toFinite _)).image _
  have hKmem : ∀ (j : Fin 3) (σ : ℝ), (σ = 1 ∨ σ = -1) → d j.castSucc + σ * (π / 2) ∈ K :=
    fun j σ hσ => ⟨(j, σ), ⟨mem_univ _, by rcases hσ with rfl | rfl <;> simp⟩, rfl⟩
  -- off the cut angles, one side works at first order (two sectors failing on opposite sides share an edge whose normal is `θ`)
  have hside : ∀ θ : ℝ, (∀ κ ∈ K, ∀ m : ℤ, θ ≠ κ + 2 * π * m) →
      ((∃ γ ∈ Icc (d 0) (d 1), Real.cos (γ - θ) < 0) ∧ (∃ γ ∈ Icc (d 1) (d 2), Real.cos (γ - θ) < 0) ∧
        (∃ γ ∈ Icc (d 2) (d 3), Real.cos (γ - θ) < 0)) ∨
      ((∃ γ ∈ Icc (d 0) (d 1), 0 < Real.cos (γ - θ)) ∧ (∃ γ ∈ Icc (d 1) (d 2), 0 < Real.cos (γ - θ)) ∧
        (∃ γ ∈ Icc (d 2) (d 3), 0 < Real.cos (γ - θ))) := by
    intro θ hθ
    have hne : ∀ j : Fin 3, Real.cos (d j.castSucc - θ) ≠ 0 := by
      intro j hcos
      obtain ⟨σ, hσ, m, hm⟩ := exists_eq_add_half_pi_of_cos_eq_zero hcos
      exact hθ _ (hKmem j σ hσ) m hm
    have key : ∀ a b : ℝ, a < b → (∀ γ ∈ Icc a b, 0 ≤ Real.cos (γ - θ)) → (∀ γ ∈ Icc a b, Real.cos (γ - θ) ≤ 0) → False :=
      fun a b hab h1 h2 => false_of_cos_eq_zero_on_Icc hab fun γ hγ => le_antisymm (h2 γ hγ) (h1 γ hγ)
    by_contra hcon
    rw [not_or] at hcon
    obtain ⟨hni, hno⟩ := hcon
    have hA : (∀ γ ∈ Icc (d 0) (d 1), 0 ≤ Real.cos (γ - θ)) ∨ (∀ γ ∈ Icc (d 1) (d 2), 0 ≤ Real.cos (γ - θ)) ∨
        (∀ γ ∈ Icc (d 2) (d 3), 0 ≤ Real.cos (γ - θ)) := by
      by_contra hh; push Not at hh; exact hni ⟨hh.1, hh.2.1, hh.2.2⟩
    have hB : (∀ γ ∈ Icc (d 0) (d 1), Real.cos (γ - θ) ≤ 0) ∨ (∀ γ ∈ Icc (d 1) (d 2), Real.cos (γ - θ) ≤ 0) ∨
        (∀ γ ∈ Icc (d 2) (d 3), Real.cos (γ - θ) ≤ 0) := by
      by_contra hh; push Not at hh; exact hno ⟨hh.1, hh.2.1, hh.2.2⟩
    rcases hA with hA | hA | hA <;> rcases hB with hB | hB | hB
    · exact key _ _ hS0 hA hB
    · exact hne 1 (le_antisymm (hB (d 1) ⟨le_rfl, hS1.le⟩) (hA (d 1) ⟨hS0.le, le_rfl⟩))
    · exact hne 0 (show Real.cos (d 0 - θ) = 0 from le_antisymm (by rw [← hc3]; exact hB (d 3) ⟨hS2.le, le_rfl⟩) (hA (d 0) ⟨le_rfl, hS0.le⟩))
    · exact hne 1 (le_antisymm (hB (d 1) ⟨hS0.le, le_rfl⟩) (hA (d 1) ⟨le_rfl, hS1.le⟩))
    · exact key _ _ hS1 hA hB
    · exact hne 2 (le_antisymm (hB (d 2) ⟨le_rfl, hS2.le⟩) (hA (d 2) ⟨hS1.le, le_rfl⟩))
    · exact hne 0 (show Real.cos (d 0 - θ) = 0 from le_antisymm (hB (d 0) ⟨le_rfl, hS0.le⟩) (by rw [← hc3]; exact hA (d 3) ⟨hS2.le, le_rfl⟩))
    · exact hne 2 (le_antisymm (hB (d 2) ⟨hS1.le, le_rfl⟩) (hA (d 2) ⟨le_rfl, hS2.le⟩))
    · exact key _ _ hS2 hA hB
  have hcollar : ∀ θ : ℝ, (∀ κ ∈ K, ∀ m : ℤ, θ ≠ κ + 2 * π * m) →
      ∃ s, CollarAt (closure (F.region X ∪ F.region Y)) v s θ := by
    intro θ hθ
    rcases hside θ hθ with hI | hO
    · exact ⟨.inner, hin θ hI⟩
    · exact ⟨.outer, hout θ hO⟩
  -- the arc opposite each sector carries inner collars (first order)
  have hopp0 : ∀ ψ ∈ Ioo (d 1 - 3 * π / 2) (d 0 - π / 2), CollarAt (closure (F.region X ∪ F.region Y)) v .inner ψ := by
    intro ψ hψ
    obtain ⟨h1, h2⟩ := hψ
    refine hin ψ ⟨⟨d 0, ⟨le_rfl, hS0.le⟩, cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two (by linarith) (by linarith)⟩,
      ⟨d 1, ⟨le_rfl, hS1.le⟩, cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two (by linarith) (by linarith)⟩,
      ⟨d 3, ⟨hS2.le, le_rfl⟩, by rw [hc3]; exact cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two (by linarith) (by linarith)⟩⟩
  have hopp1 : ∀ ψ ∈ Ioo (d 2 - 3 * π / 2) (d 1 - π / 2), CollarAt (closure (F.region X ∪ F.region Y)) v .inner ψ := by
    intro ψ hψ
    obtain ⟨h1, h2⟩ := hψ
    refine hin ψ ⟨⟨d 1, ⟨hS0.le, le_rfl⟩, cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two (by linarith) (by linarith)⟩,
      ⟨d 1, ⟨le_rfl, hS1.le⟩, cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two (by linarith) (by linarith)⟩,
      ⟨d 2, ⟨le_rfl, hS2.le⟩, cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two (by linarith) (by linarith)⟩⟩
  have hopp2 : ∀ ψ ∈ Ioo (d 3 - 3 * π / 2) (d 2 - π / 2), CollarAt (closure (F.region X ∪ F.region Y)) v .inner ψ := by
    intro ψ hψ
    obtain ⟨h1, h2⟩ := hψ
    refine hin ψ ⟨⟨d 0, ⟨le_rfl, hS0.le⟩, by rw [← hc3]; exact cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two (by linarith) (by linarith)⟩,
      ⟨d 2, ⟨hS1.le, le_rfl⟩, cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two (by linarith) (by linarith)⟩,
      ⟨d 2, ⟨le_rfl, hS2.le⟩, cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two (by linarith) (by linarith)⟩⟩
  -- a closed sub-arc of an open arc of length above `π/3`
  have hsub : ∀ a b : ℝ, π / 3 < b - a → (∀ ψ ∈ Ioo a b, CollarAt (closure (F.region X ∪ F.region Y)) v .inner ψ) →
      ∃ (s : Rim) (θ₁ θ₂ : ℝ), π / 3 < θ₂ - θ₁ ∧ ∀ θ ∈ Icc θ₁ θ₂, CollarAt (closure (F.region X ∪ F.region Y)) v s θ := by
    intro a b hab hI
    refine ⟨.inner, a + (b - a - π / 3) / 4, b - (b - a - π / 3) / 4, by linarith, fun θ hθ => hI θ ⟨?_, ?_⟩⟩
    · linarith [hθ.1]
    · linarith [hθ.2]
  have hseed : ∃ (s : Rim) (θ₁ θ₂ : ℝ), π / 3 < θ₂ - θ₁ ∧
      ∀ θ ∈ Icc θ₁ θ₂, CollarAt (closure (F.region X ∪ F.region Y)) v s θ := by
    by_cases h0 : d 1 - d 0 < 2 * π / 3
    · exact hsub _ _ (by linarith) hopp0
    by_cases h1 : d 2 - d 1 < 2 * π / 3
    · exact hsub _ _ (by linarith) hopp1
    by_cases h2 : d 3 - d 2 < 2 * π / 3
    · exact hsub _ _ (by linarith) hopp2
    -- all three angles are `2π/3`: a certified normal of the edge `d 0` (the refined second-order lemma) extends an opposite arc
    push Not at h0 h1 h2
    have e1 : d 1 = d 0 + 2 * π / 3 := by linarith
    have e2 : d 2 = d 0 + 4 * π / 3 := by linarith
    have hpos : ∀ j : Fin 3, 0 < d j.succ - d j.castSucc := fun j => by linarith [hang j]
    obtain ⟨σ, hσ, hcol⟩ := h.exists_normal_collarAt hP (by norm_num) hpos 0
    have hprev : (finRotate 3).symm 0 = 2 := by decide
    rw [hprev] at hcol
    set ψ₀ := d 0 + σ * (π / 2) with hψ₀
    have hψ₀' : d (Fin.castSucc 0) + σ * (π / 2) = ψ₀ := rfl
    rw [hψ₀'] at hcol
    have hc1 : CollarAt (shadow (F.region (c 1))) v .inner ψ₀ := by
      rcases hσ with rfl | rfl
      · exact collarAt_shadow_inner_of_mem_coneAt hv (h.mem_coneAt_of_mem_Icc 1 (γ := d 2) ⟨hS1.le, le_rfl⟩)
          (cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two (by rw [hψ₀]; linarith) (by rw [hψ₀]; linarith))
      · exact collarAt_shadow_inner_of_mem_coneAt hv (h.mem_coneAt_of_mem_Icc 1 (γ := d 1) ⟨le_rfl, hS1.le⟩)
          (cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two (by rw [hψ₀]; linarith) (by rw [hψ₀]; linarith))
    have hall : CollarAt (closure (F.region X ∪ F.region Y)) v .inner ψ₀ := by
      refine collarAt_closure_of_forall_shadow hF hP hXY fun x hx => ?_
      simp only [Finset.mem_insert, Finset.mem_singleton] at hx
      rcases hx with rfl | rfl | rfl
      · exact hcol.mono inter_subset_right
      · exact hc1
      · exact hcol.mono inter_subset_left
    obtain ⟨h₀, hh₀, hsub₀⟩ := hall
    set t := min (h₀ / 4) (π / 12) with ht
    have ht0 : 0 < t := lt_min (by linarith) (by linarith)
    have ht1 : t ≤ h₀ / 4 := min_le_left _ _
    have ht2 : t ≤ π / 12 := min_le_right _ _
    have hnear : ∀ θ : ℝ, |θ - ψ₀| ≤ t → CollarAt (closure (F.region X ∪ F.region Y)) v .inner θ :=
      fun θ hθ => CollarAt.of_abs_sub_lt hh₀ hsub₀ (by linarith)
    rcases hσ with rfl | rfl
    · -- `ψ₀ = d 0 + π/2`, the start of the arc opposite sector 2, `(d 0 + π/2, d 0 + 5π/6)`
      refine ⟨.inner, ψ₀ - t, d 0 + 5 * π / 6 - t / 2, by rw [hψ₀]; linarith, fun θ hθ => ?_⟩
      by_cases hle : θ ≤ ψ₀ + t
      · exact hnear θ (abs_le.mpr ⟨by linarith [hθ.1], by linarith⟩)
      · push Not at hle
        exact hopp2 θ ⟨by rw [hlast]; rw [hψ₀] at hle; linarith, by rw [e2]; linarith [hθ.2]⟩
    · -- `ψ₀ = d 0 − π/2`, the end of the arc opposite sector 0, `(d 0 − 5π/6, d 0 − π/2)`
      refine ⟨.inner, d 0 - 5 * π / 6 + t / 2, ψ₀ + t, by rw [hψ₀]; linarith, fun θ hθ => ?_⟩
      by_cases hle : ψ₀ - t ≤ θ
      · exact hnear θ (abs_le.mpr ⟨by linarith, by linarith [hθ.2]⟩)
      · push Not at hle
        exact hopp0 θ ⟨by rw [e1]; linarith [hθ.1], by rw [hψ₀] at hle; linarith⟩
  exact townsend_lemma (F.isOpen_region X) (F.isOpen_region Y) (hF.region_dist_ne_one X) (hF.region_dist_ne_one Y)
    (u := v) hKfin hcollar hseed

/-- **E1-NO45** (`plans/FS131-E1-derivation.md` § 3.6): in a valid map of the plane with at most five colours in normal form, no point has a
picture of four or more sectors (so of four or five: the colours are distinct). Angles `≥ π/3` at four or five sectors are `≤ π`; E1-BAD
(`SectorsAt.exists_two_absent`) leaves at most five angles at which a point of `ω(v)` may keep all but one of `v`'s colours; an arc of length `2π/5`
avoids them (`exists_Ioo_avoiding`), and by E1-COVER (`SectorsAt.false_of_ncard_le_two_on_arc`, at most one colour absent from `v`) it holds a point
of three or more colours; that point lacks two of `v`'s colours, so it carries exactly three, its picture has three sectors in normal form, and
`step6` excludes it. Replaces Woodall's steps 7–8 (FS131-E1's E1-Q2) and step 5's equality case (E1-Q1). -/
theorem false_of_four_le_sectors (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) (hN : F.WoodallNormal) {v : ℂ} {n : ℕ}
    {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k} (h : F.SectorsAt v n d c) (hn : 4 ≤ n) : False := by
  obtain ⟨hc, hang⟩ := hN v n d c h (by omega)
  have hpi := Real.pi_pos
  have hnk : n ≤ k := by simpa using Fintype.card_le_of_injective c hc
  have hpos : ∀ i : Fin n, 0 < d i.succ - d i.castSucc := fun i => by linarith [hang i]
  -- each angle is at most `π`: the other `n − 1 ≥ 3` angles are at least `π/3` each
  have hπ : ∀ i : Fin n, d i.succ - d i.castSucc ≤ π := by
    intro i
    have hsum := sum_width h.2.2.1
    rw [← Finset.add_sum_erase Finset.univ _ (Finset.mem_univ i)] at hsum
    have hge : (Finset.univ.erase i).card • (π / 3) ≤ ∑ j ∈ Finset.univ.erase i, (d j.succ - d j.castSucc) :=
      Finset.card_nsmul_le_sum _ _ _ fun j _ => hang j
    rw [Finset.card_erase_of_mem (Finset.mem_univ i), Finset.card_univ, Fintype.card_fin, nsmul_eq_mul] at hge
    have : (3 : ℝ) ≤ ((n - 1 : ℕ) : ℝ) := by
      have : 3 ≤ n - 1 := by omega
      exact_mod_cast this
    nlinarith
  -- at most one colour is absent from the picture
  have habs : ∀ X Y : Fin k, X ∉ Set.range c → Y ∉ Set.range c → X = Y := by
    intro X Y hX hY
    by_contra hXY
    have hsub : Finset.univ.image c ⊆ (Finset.univ.erase X).erase Y := by
      intro j hj
      obtain ⟨i, -, rfl⟩ := Finset.mem_image.mp hj
      exact Finset.mem_erase.mpr ⟨fun hh => hY ⟨i, hh⟩, Finset.mem_erase.mpr ⟨fun hh => hX ⟨i, hh⟩, Finset.mem_univ _⟩⟩
    have h1 := Finset.card_le_card hsub
    rw [Finset.card_image_of_injective _ hc, Finset.card_univ, Fintype.card_fin,
      Finset.card_erase_of_mem (Finset.mem_erase.mpr ⟨Ne.symm hXY, Finset.mem_univ _⟩), Finset.card_erase_of_mem (Finset.mem_univ _),
      Finset.card_univ, Fintype.card_fin] at h1
    omega
  obtain ⟨K, hK, hoff⟩ := SectorsAt.exists_two_absent hF hP h (by omega) hc hpos hπ
  obtain ⟨θ, hθ⟩ := exists_Ioo_avoiding K (by omega)
  -- an arc of length `2π/5 > π/3` free of cut angles holds a point of three colours
  obtain ⟨θ', hθ'I, hθ'3⟩ : ∃ θ' ∈ Ioo θ (θ + 2 * π / 5), 3 ≤ (F.coloursAt (v + e θ')).ncard := by
    by_contra hcon
    push Not at hcon
    exact SectorsAt.false_of_ncard_le_two_on_arc hF hP h hpos habs (θ₁ := θ) (θ₂ := θ + 2 * π / 5) (by linarith)
      (fun θ' hθ' => by have := hcon θ' hθ'; omega)
  obtain ⟨i, j, hij, hi, hj⟩ := hoff θ' (fun κ hκ m hm => hθ κ hκ m (hm ▸ hθ'I))
  -- that point lacks two of `v`'s colours, so it carries exactly three
  have hsub : F.coloursAt (v + e θ') ⊆ ((Finset.univ.erase (c i)).erase (c j) : Finset (Fin k)) := by
    intro x hx
    exact Finset.mem_coe.mpr (Finset.mem_erase.mpr ⟨fun hh => hj (hh ▸ hx), Finset.mem_erase.mpr ⟨fun hh => hi (hh ▸ hx), Finset.mem_univ _⟩⟩)
  have hnc : (F.coloursAt (v + e θ')).ncard ≤ 3 := by
    have h1 := Set.ncard_le_ncard hsub (Finset.finite_toSet _)
    rw [Set.ncard_coe_finset, Finset.card_erase_of_mem (Finset.mem_erase.mpr ⟨hij.symm, Finset.mem_univ _⟩),
      Finset.card_erase_of_mem (Finset.mem_univ _), Finset.card_univ, Fintype.card_fin] at h1
    omega
  -- its picture has three sectors in normal form
  obtain ⟨n', d', c', h'⟩ := exists_sectorsAt hP (v + e θ')
  have hcol := h'.coloursAt_eq
  have hrange : (range c').ncard ≤ n' := by
    rw [← Nat.card_coe_set_eq]; simpa using Finite.card_range_le c'
  have hn'3 : 3 ≤ n' := by rw [hcol] at hθ'3; omega
  obtain ⟨hinj', hang'⟩ := hN (v + e θ') n' d' c' h' hn'3
  have hrn : (range c').ncard = n' := by
    rw [← Set.image_univ, Set.ncard_image_of_injective _ hinj', Set.ncard_univ]; simp
  have hn'le : n' ≤ 3 := by rw [← hrn, ← hcol]; exact hnc
  obtain rfl : n' = 3 := by omega
  exact step6 hk hF hP h' hinj' hang'

/-! ## A vertex exists -/

/-- **A point of at least three sectors** — FS131-E1's **E1-NOBRANCH** (`plans/FS131-E1-derivation.md` § 3.7), in a stronger form (any `k`, no
(N1)), and without its Jordan curve theorem (FS131-W2 § 7.5): FS106-TS-T (`ts_t`, over Lebesgue's covering theorem) gives a point carrying at
least three colours; its picture has at least three sectors. Woodall's "no vertices at all … is clearly impossible", in the form his map
conditions do not give for arc maps. -/
theorem exists_three_le_sectors (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ v n d c, F.SectorsAt v n d c ∧ 3 ≤ n := by
  obtain ⟨x, -, hx3⟩ := ts_t hF hP 0 (ε := 1) one_pos
  obtain ⟨n, d, c, h⟩ := exists_sectorsAt hP x
  refine ⟨x, n, d, c, h, ?_⟩
  have hrange : (range c).ncard ≤ n := by
    rw [← Nat.card_coe_set_eq]; simpa using Finite.card_range_le c
  rw [h.coloursAt_eq] at hx3
  omega

/-! ## The theorems -/

/-- **Maps in Woodall's normal form need six** (FS131-E1's E1-MAPS6): a valid map of the plane with at most five colours in normal form does not
exist (a point of `n ≥ 3` sectors, `exists_three_le_sectors`, has `n ≤ 5` distinct colours; `step6` at three, `false_of_four_le_sectors` at four
and five). -/
theorem aeMap6_normal (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) (hN : F.WoodallNormal) : False := by
  obtain ⟨v, n, d, c, hS, h3⟩ := exists_three_le_sectors hF hP
  obtain ⟨hinj, hang⟩ := hN v n d c hS h3
  have hnk : n ≤ k := by simpa using Fintype.card_le_of_injective c hinj
  by_cases h4 : 4 ≤ n
  · exact false_of_four_le_sectors hk hF hP hN hS h4
  · obtain rfl : n = 3 := by omega
    exact step6 hk hF hP hS hinj hang

open Fin.NatCast in
/-- **Steps 3 and 5 give the normal form, so a merged map does not exist**: in a valid map of the plane with at most five colours whose repeated
colours sit on horns only, every point of three or more sectors has distinct colours (a horn between two neighbours of distinct colours dies
by `step5_lt`; a horn between two of one colour has horns for neighbours, and the chain of horns ends at a sector of positive angle) and every
angle at least `π/3` (`step5_lt`, strict step 5 only); `aeMap6_normal` finishes. Stated with conclusion `False`, not `WoodallNormal`: its domain
is empty (by this very chain), so the intermediate normal-form statement would be vacuous. -/
theorem aeMap6_merged (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) (hM : F.WoodallMerged) : False := by
  have hN : F.WoodallNormal := by
    intro v n d c h hn3
    have hlast := h.2.2.1
    have hmono := h.2.1
    have hw0 : ∀ i : Fin n, 0 ≤ d i.succ - d i.castSucc := fun i => sub_nonneg.mpr (hmono (Fin.castSucc_le_succ i))
    -- a repeated colour sits on horns, and a horn dies: every sector has positive width
    have hpos : ∀ i : Fin n, 0 < d i.succ - d i.castSucc := by
      by_contra hcon
      push Not at hcon
      obtain ⟨i₀, hi₀⟩ := hcon
      have hz : ∀ i : Fin n, d i.succ - d i.castSucc = 0 → d (finRotate n i).succ - d (finRotate n i).castSucc = 0 ∨
          ∃ j : Fin n, d j.succ - d j.castSucc = 0 ∧ 0 < d (finRotate n j).succ - d (finRotate n j).castSucc := by
        intro i hi
        rcases (hw0 (finRotate n i)).eq_or_lt with h0 | h0
        · exact Or.inl h0.symm
        · exact Or.inr ⟨i, hi, h0⟩
      obtain ⟨j, hj0, hjp⟩ : ∃ j : Fin n, d j.succ - d j.castSucc = 0 ∧ 0 < d (finRotate n j).succ - d (finRotate n j).castSucc := by
        by_contra hno
        push Not at hno
        have hall : ∀ i : Fin n, d i.succ - d i.castSucc = 0 := by
          obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 := ⟨n - 1, by omega⟩
          have hstep : ∀ i : Fin (m + 1), d i.succ - d i.castSucc = 0 → d (i + 1).succ - d (i + 1).castSucc = 0 := by
            intro i hi
            rw [← finRotate_apply]
            exact le_antisymm (hno i hi) (hw0 _)
          have hind : ∀ q : ℕ, d (i₀ + (q : Fin (m + 1))).succ - d (i₀ + (q : Fin (m + 1))).castSucc = 0 := by
            intro q
            induction q with
            | zero => simpa using le_antisymm hi₀ (hw0 i₀)
            | succ q ih =>
              have := hstep _ ih
              rwa [Nat.cast_succ, ← add_assoc]
          intro i
          have := hind (i - i₀).val
          rwa [Fin.cast_val_eq_self, add_sub_cancel] at this
        have hs := sum_width hlast
        rw [Finset.sum_eq_zero fun i _ => hall i] at hs
        linarith [Real.pi_pos]
      -- the next sector's colour is not repeated, so it differs from the previous sector's
      have hnr : ∀ l : Fin n, l ≠ finRotate n j → c l ≠ c (finRotate n j) := by
        intro l hl hcl
        have := (hM v n d c h l (finRotate n j) hl hcl).2
        linarith [this]
      refine step5_lt hk hF hP h hn3 j (by rw [hj0]; positivity) ?_
      exact fun heq => hnr _ (finRotate_ne_symm hn3 j).symm heq.symm
    have hinj : Function.Injective c := by
      intro i j hij
      by_contra hne
      have := (hM v n d c h i j hne hij).1
      linarith [hpos i]
    refine ⟨hinj, fun i => ?_⟩
    by_contra hlt
    push Not at hlt
    exact step5_lt hk hF hP h hn3 i hlt (fun heq => finRotate_ne_symm hn3 i (hinj heq))
  exact aeMap6_normal hk hF hP hN


/-- **FS106-AE-MAP6** (arc maps): no map of the plane bounded by a locally finite family of segments and circular arcs, coloured with at most
five colours, is almost-everywhere proper (no two interior points of one colour at distance exactly `1`; boundary points carry no colour).
"Boundaries of measure 0" is not used (the row's last clause). The chain: steps 1–3, strict step 5, step 6, E1-NO45, E1-NOBRANCH (FS131-E1's
E1-MAPS6); no step reads an angle equal to `π/3`, and nothing of Woodall's steps 7–8 is used. -/
theorem aeMap6 (F : ArcMap k) (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) : False := by
  obtain ⟨F', hv, hp, hM, -⟩ := exists_woodallMerged hF hP
  exact aeMap6_merged hk hv hp hM

/-- **FS106-AE-MAP6 under Condition 5** (no boundary meets a unit circle in infinitely many points): a corollary of `aeMap6`, Condition 5 unused
(FS131-E1: "the Condition-5 form becomes a corollary"). -/
theorem aeMap6_of_condition5 (F : ArcMap k) (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) (h5 : F.Condition5) : False := by
  have _ := h5
  exact aeMap6 F hk hF hP

end ArcMap

/-- **FS106-WO, Woodall's Theorem 6** ("R(b) ≥ 6", `[Woodall1973]` p. 195), for arc maps: the plane is not covered by five sets
simultaneously divisible into regions by one map of the plane (each region in one set, every point in exactly one set) with no set realizing
the distance `1` — a colouring `col` agreeing with the map's colour at its interior points and proper at every unit pair. A corollary of
`ArcMap.aeMap6`: properness at every pair gives validity. -/
theorem woodall_thm6 {k : ℕ} (hk : k ≤ 5) (F : ArcMap k) (hP : F.IsPlaneMap) (col : ℂ → Fin k)
    (hdiv : ∀ x ∈ F.interiorPts, col x = F.col x) (hproper : ∀ x y : ℂ, dist x y = 1 → col x ≠ col y) : False := by
  refine ArcMap.aeMap6 F hk (fun x hx y hy hd => ?_) hP
  rw [← hdiv x hx, ← hdiv y hy]
  exact hproper x y hd

end HadwigerNelson.Plane
