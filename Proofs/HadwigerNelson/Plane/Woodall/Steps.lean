import Proofs.HadwigerNelson.Plane.Woodall.Merge

/-!
# Maps need six, almost everywhere: Woodall's Theorem 6 as repaired and restored (FS106-AE-MAP6, FS106-WO)

FS131-W's skeleton (`plans/FS131-W-kernel-plan.md` § 3), re-planned by FS131-W2 (§§ 6–9) on FS131-E1's restoration
(`plans/FS131-E1-derivation.md` § 3.8, E1-MAPS6), over arc maps (inventory item 89: the general Jordan form owed). A five-coloured arc map of the
plane, **valid** (D-AEMAP: no two interior points of one colour at distance exactly `1`; boundaries carry no colour), does not exist.

The chain, region-only, on the picture at a point (`ArcMap.SectorsAt`), re-planned by FS131-W3 (§§ 11–15) on FS131-E3's ∃-forms
(`plans/FS131-E3-derivation.md` § 4.1):
* **step 3** (`exists_woodallMerged`, `Plane/Woodall/Merge`, E3-BALL): a valid map can be modified, by finitely many merges in `closedBall 0 R`,
  into one in which every point of the ball of three or more colours is `NiceAt` (a modification; it keeps validity, the plane, and
  Condition 5);
* **strict step 5** (`step5_lt`): no sector of angle `< π/3` between two neighbours of distinct colours, so a `NiceAt` picture is a normal one,
  angles `≥ π/3` (`NiceAt.normal`) — no angle equal to `π/3` is ever read (FS131-E1's E1-Q1);
* **step 6** (`step6`, by Townsend's `π/3` lemma `townsend_lemma`): no point of three sectors in normal form;
* **E1-NO45** (`false_of_four_le_sectors`, from `Plane/Woodall/NoFourFive`): no point of four or five sectors in normal form, with at most five
  colours, its auxiliary point's normal picture read from `WoodallNormal (sphere v 1)` — in place of Woodall's steps 7–8, whose printed forms
  have GAPs (FS131-W § 1.4: F1, F2);
* **a vertex** (E1-NOBRANCH's conclusion): `ts_t` (FS106-TS-T) gives a point of three or more colours within `1/√2 + 1 < 2` of `0`, so
  inside `closedBall 0 3` with its unit circle (E3-CHAIN; no Jordan curve theorem).

**The rows.** FS106-AE-MAP6 is `ArcMap.aeMap6`, with `ArcMap.aeMap6_of_condition5` its corollary under Condition 5; FS106-WO's Theorem 6 is
`woodall_thm6` (everywhere-proper sets divisible into regions, a corollary), its step-4 lemma `woodall_step4` (`Plane/Woodall/Collar`); FS106-TW is
`townsend_lemma` (`Plane/Woodall/Collar`), whose Theorem 4 Corollary is `step6`.

**The model** (FS131-QA2's QA2-1; `LEAN.md` § The gate's inhabitant rule): the theorems above are refutations at `k ≤ 5`, and their hypotheses
hold together at `k = 7` on a map of the plane — `sevenBrickMap_woodallModel` (M36's brick colouring: valid, a plane map, Condition 5, in
normal form and merged on the whole plane, a point of three colours) and `sevenBrickMap_thm6Model` (`woodall_thm6`'s colouring). Its points
of three or more colours are the T-junctions of the brick tiling (`sevenBrickMap_tJunction`), each with angles `π/2, π/2, π`. The adversaries
`threeSectorDisc_not_sectorsAt_one`, `threeSectorDisc_not_niceAt_one` and `puncturedThreeSectorDisc_not_woodallMerged`/`_not_woodallNormal`
show the pictures read the domain.
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
    have := e_add_two_pi_mul_int β₁ m
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

/-- **Steps 3 and 5 give the normal form** (FS131-E3's `NiceAt.normal`): at a point of three or more colours, a `NiceAt` picture has no horn (a horn
sits between distinct colours and dies by `step5_lt`), so its colours are distinct (`NiceAt`'s second clause), and every angle is at least `π/3`
(`step5_lt`, strict step 5 only). **Private** (inventory item 167 (b)): its hypotheses — a valid map of the plane with at most five colours — are
unsatisfiable by `aeMap6`, the refutation this lemma is a step of, and a public statement over that class must conclude `False` (W's § 3.1 rule); the
vacuity scan does not track `ArcMap` binders, so a `VACUITY DECLARED` marker here would go unchecked. It is a step of `aeMap6_merged` only, never a
structure lemma, and its argument is exercised on `threeSectorDisc` (`threeSectorDisc_niceAt`, `threeSectorDisc_woodallNormal`). -/
private theorem NiceAt.normal (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} (h : F.NiceAt v)
    (h3 : 3 ≤ (F.coloursAt v).ncard) :
    ∃ n d c, F.SectorsAt v n d c ∧ Function.Injective c ∧ ∀ i : Fin n, π / 3 ≤ d i.succ - d i.castSucc := by
  obtain ⟨n, d, c, hS, h2, h3'⟩ := h
  have hn3 : 3 ≤ n := by
    rw [hS.coloursAt_eq] at h3
    have hrange : (range c).ncard ≤ n := by
      rw [← Nat.card_coe_set_eq]; simpa using Finite.card_range_le c
    omega
  have hpos : ∀ i : Fin n, d i.castSucc ≠ d i.succ := fun i hi =>
    step5_lt hk hF hP hS hn3 i (by rw [hi, sub_self]; positivity) (h3' i hi).symm
  have hinj : Function.Injective c := fun i j hij => by
    by_contra hne
    rcases h2 i j hne hij with h | h
    · exact hpos i h
    · exact hpos j h
  refine ⟨n, d, c, hS, hinj, fun i => ?_⟩
  by_contra hlt
  push Not at hlt
  exact step5_lt hk hF hP hS hn3 i hlt (fun heq => finRotate_ne_symm hn3 i (hinj heq))

/-- **E1-NO45** (`plans/FS131-E1-derivation.md` § 3.6): in a valid map of the plane with at most five colours in normal form, no point has a
picture of four or more sectors (so of four or five: the colours are distinct). Angles `≥ π/3` at four or five sectors are `≤ π`; E1-BAD
(`SectorsAt.exists_two_absent`) leaves at most five angles at which a point of `ω(v)` may keep all but one of `v`'s colours; an arc of length `2π/5`
avoids them (`exists_Ioo_avoiding`), and by E1-COVER (`SectorsAt.false_of_ncard_le_two_on_arc`, at most one colour absent from `v`) it holds a point
of three or more colours; that point lacks two of `v`'s colours, so it carries exactly three, its normal picture (from `hN`, FS131-E3) has three
sectors, and `step6` excludes it. Replaces Woodall's steps 7–8 (FS131-E1's E1-Q2) and step 5's equality case (E1-Q1).
A refutation step: no model of the hypotheses is expected. Its background (`Valid`, `IsPlaneMap`; the normal form where it is assumed) is
inhabited at seven colours by `sevenBrickMap_woodallModel` (`Plane/Woodall/Steps`). -/
theorem false_of_four_le_sectors (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {n : ℕ}
    {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k} (h : F.SectorsAt v n d c) (hn : 4 ≤ n) (hc : Function.Injective c)
    (hang : ∀ i : Fin n, π / 3 ≤ d i.succ - d i.castSucc) (hN : F.WoodallNormal (sphere v 1)) : False := by
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
  -- its normal picture, from `hN` (the point lies on `ω(v)`): three sectors
  have hmem : v + e θ' ∈ sphere v 1 := by rw [mem_sphere, dist_eq_norm, add_sub_cancel_left, norm_e]
  obtain ⟨n', d', c', h', hinj', hang'⟩ := hN (v + e θ') hmem hθ'3
  have hcol := h'.coloursAt_eq
  have hrn : (range c').ncard = n' := by
    rw [← Set.image_univ, Set.ncard_image_of_injective _ hinj', Set.ncard_univ]; simp
  have hn'3 : 3 ≤ n' := by rw [← hrn, ← hcol]; exact hθ'3
  have hn'le : n' ≤ 3 := by rw [← hrn, ← hcol]; exact hnc
  obtain rfl : n' = 3 := by omega
  exact step6 hk hF hP h' hinj' hang'

/-! ## The theorems -/

/-- **Maps in Woodall's normal form on `closedBall 0 3` need six** (FS131-E1's E1-MAPS6, localized by FS131-E3's E3-CHAIN): a valid map of the
plane with at most five colours in normal form at every point of `closedBall 0 3` of three or more colours does not exist. `ts_t` gives a point
`v` of three or more colours with `‖v‖ < 1/√2 + 1 < 2`; its normal picture has `3 ≤ n ≤ 5` distinct colours; `step6` at three,
`false_of_four_le_sectors` at four and five, its auxiliary points on `ω(v) ⊆ closedBall 0 3`. -/
theorem aeMap6_normal (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) (hN : F.WoodallNormal (closedBall 0 3)) : False := by
  obtain ⟨v, hv, hv3⟩ := ts_t hF hP 0 (ε := 1) one_pos
  have hs : 1 / Real.sqrt 2 < 1 := by
    rw [div_lt_one (Real.sqrt_pos.mpr two_pos)]
    exact (Real.lt_sqrt zero_le_one).mpr (by norm_num)
  have hv2 : ‖v‖ < 2 := by rw [dist_zero_right] at hv; linarith
  obtain ⟨n, d, c, hS, hinj, hang⟩ := hN v (by rw [mem_closedBall, dist_zero_right]; linarith) hv3
  have hnk : n ≤ k := by simpa using Fintype.card_le_of_injective c hinj
  have hrn : (range c).ncard = n := by
    rw [← Set.image_univ, Set.ncard_image_of_injective _ hinj, Set.ncard_univ]; simp
  have hn3 : 3 ≤ n := by rw [← hrn, ← hS.coloursAt_eq]; exact hv3
  by_cases h4 : 4 ≤ n
  · refine false_of_four_le_sectors hk hF hP hS h4 hinj hang fun w hw hw3 => hN w ?_ hw3
    rw [mem_sphere, dist_eq_norm] at hw
    rw [mem_closedBall, dist_zero_right]
    linarith [norm_le_norm_add_norm_sub' w v]
  · obtain rfl : n = 3 := by omega
    exact step6 hk hF hP hS hinj hang

/-- **Steps 3 and 5 give the normal form, so a merged map does not exist** (FS131-E3's `aeMap6_merged`): `NiceAt.normal` at every point of
`closedBall 0 3` of three or more colours, then `aeMap6_normal`. -/
theorem aeMap6_merged (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) (hM : F.WoodallMerged (closedBall 0 3)) : False :=
  aeMap6_normal hk hF hP fun v hv h3 => (hM v hv h3).normal hk hF hP h3

/-- **FS106-AE-MAP6** (arc maps): no map of the plane bounded by a locally finite family of segments and circular arcs, coloured with at most
five colours, is almost-everywhere proper (no two interior points of one colour at distance exactly `1`; boundary points carry no colour).
"Boundaries of measure 0" is not used (the row's last clause). The chain: steps 1–2 (free for arcs), step 3 localized to `closedBall 0 3`
(`exists_woodallMerged`, FS131-E3's E3-BALL), strict step 5, step 6, E1-NO45, and a vertex from FS106-TS-T (FS131-E1's E1-MAPS6, E3-CHAIN);
no step reads an angle equal to `π/3`, and nothing of Woodall's steps 7–8 is used. -/
theorem aeMap6 (F : ArcMap k) (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) : False := by
  obtain ⟨F', hv, hp, hM, -⟩ := exists_woodallMerged hF hP 3
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

/-! ## The plane-map model (FS131-QA2's QA2-1): the brick map in Woodall's normal form on the whole plane -/

namespace ArcMap

variable {k : ℕ}

/-- **The cone clause of a picture from sectors** (region-only): if each open sector `annSector v 0 ρ (d i) (d (i+1))` lies in the class
of colour `c i`, and every interior point near `v` lies in one of them, the cone of each colour class at `v` is the union of its closed
angular intervals. -/
theorem coneAt_region_of_sectors (F : ArcMap k) {v : ℂ} {ρ : ℝ} (hρ : 0 < ρ) {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (hd : ∀ i : Fin n, d i.castSucc < d i.succ) (hsub : ∀ i : Fin n, annSector v 0 ρ (d i.castSucc) (d i.succ) ⊆ F.region (c i))
    (hcov : ∀ z ∈ F.interiorPts, z ∈ ball v ρ → ∃ i : Fin n, z ∈ annSector v 0 ρ (d i.castSucc) (d i.succ)) (j : Fin k) :
    coneAt (F.region j) v = ⋃ i ∈ {i : Fin n | c i = j}, angleIcc (d i.castSucc) (d i.succ) := by
  apply Subset.antisymm
  · intro β hβ
    have hsub' : F.region j ∩ ball v ρ ⊆ ⋃ i ∈ {i : Fin n | c i = j}, annSector v 0 ρ (d i.castSucc) (d i.succ) := by
      rintro z ⟨hz, hzb⟩
      obtain ⟨i, hi⟩ := hcov z hz.1 hzb
      have hci : F.col z = c i := (hsub i hi).2
      have hj : F.col z = j := hz.2
      exact mem_iUnion₂.mpr ⟨i, show c i = j from hci ▸ hj, hi⟩
    obtain ⟨i, hi, hβi⟩ := coneAt_biUnion_finite (Set.toFinite _) _ (coneAt_mono hsub' v (coneAt_inter_ball hρ hβ))
    rw [coneAt_annSector_eq v hρ (hd i)] at hβi
    exact mem_iUnion₂.mpr ⟨i, hi, hβi⟩
  · intro β hβ
    obtain ⟨i, hi, hβi⟩ := mem_iUnion₂.mp hβ
    have hi : c i = j := hi
    rw [← coneAt_annSector_eq v hρ (hd i)] at hβi
    exact coneAt_mono (hi ▸ hsub i) v hβi

/-- A picture with distinct colours and positive angles is `NiceAt` (no colour repeats, no horn). -/
theorem niceAt_of_injective {F : ArcMap k} {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (hc : Function.Injective c) (hd : ∀ i : Fin n, d i.castSucc < d i.succ) : F.NiceAt v :=
  ⟨n, d, c, h, fun _ _ hij hcij => absurd (hc hcij) hij, fun i hi => absurd hi (hd i).ne⟩

end ArcMap

/-- The colour of the brick cell `(c, r)` (column `c` of row `r`) of `sevenBrick`. -/
def brickCellCol (c r : ℤ) : Fin 7 := sevenBrick.table (zmodIdx 7 (by norm_num) c) (zmodIdx 7 (by norm_num) r)

/-- Two cells whose indices `c + 3r` differ by a non-multiple of `7` carry different colours (`table i j = i + 3j mod 7`). -/
theorem brickCellCol_ne {c r c' r' : ℤ} (h : ¬ (7 : ℤ) ∣ (c + 3 * r) - (c' + 3 * r')) : brickCellCol c r ≠ brickCellCol c' r' := by
  intro heq
  have := congrArg Fin.val heq
  simp only [brickCellCol, sevenBrick, cosetBrick, zmodIdx] at this
  omega

/-- The polar point `v + s e(θ)` in coordinates. -/
theorem polar_re_im (v : ℂ) (s θ : ℝ) :
    (v + (s : ℂ) * e θ).re = v.re + s * Real.cos θ ∧ (v + (s : ℂ) * e θ).im = v.im + s * Real.sin θ := by
  rw [e_eq]
  constructor <;> simp [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, -Complex.ofReal_cos, -Complex.ofReal_sin]

/-- **A point strictly inside the brick cell `(c, r)` is an interior point of colour `brickCellCol c r`.** -/
theorem sevenBrickMap_mem_region_of_cell {z : ℂ} {c r : ℤ} (h1 : 3 / 5 * (r : ℝ) < z.im) (h2 : z.im < 3 / 5 * r + 3 / 5)
    (h3 : 2 / 5 * (r : ℝ) + 4 / 5 * c < z.re) (h4 : z.re < 2 / 5 * r + 4 / 5 * c + 4 / 5) :
    z ∈ sevenBrickMap.region (brickCellCol c r) := by
  have hfl : ⌊z.im / (3 / 5)⌋ = r := by
    rw [Int.floor_eq_iff]; constructor
    · rw [le_div_iff₀ (by norm_num)]; linarith
    · rw [div_lt_iff₀ (by norm_num)]; linarith
  have hcl : ⌊(z.re - 2 / 5 * r) / (4 / 5)⌋ = c := by
    rw [Int.floor_eq_iff]; constructor
    · rw [le_div_iff₀ (by norm_num)]; linarith
    · rw [div_lt_iff₀ (by norm_num)]; linarith
  refine ⟨⟨mem_univ z, not_mem_sevenBrickArcs (fun n hn => ?_) (fun n hn => ?_)⟩, ?_⟩
  · have h5 : (r : ℝ) < n := by linarith
    have h6 : (n : ℝ) < r + 1 := by linarith
    have h5' : r < n := by exact_mod_cast h5
    have h6' : n < r + 1 := by exact_mod_cast h6
    omega
  · rw [hfl] at hn
    have h5 : (c : ℝ) < n := by linarith
    have h6 : (n : ℝ) < c + 1 := by linarith
    have h5' : c < n := by exact_mod_cast h5
    have h6' : n < c + 1 := by exact_mod_cast h6
    omega
  · show sevenBrickMap.col z = brickCellCol c r
    exact sevenBrick_color_eq hfl hcl

/-- A point near `v` other than `v` in polar form about `v`, with its angle in `(0, 2π]`. -/
theorem exists_polar_Ioc {v z : ℂ} {ρ : ℝ} (hz : z ∈ ball v ρ) (hne : z ≠ v) :
    ∃ s θ : ℝ, 0 < s ∧ s < ρ ∧ θ ∈ Ioc 0 (2 * π) ∧ z = v + (s : ℂ) * e θ := by
  refine ⟨‖z - v‖, π + Complex.arg (-(z - v)), norm_pos_iff.mpr (sub_ne_zero.mpr hne), ?_, pi_add_arg_neg_mem _, ?_⟩
  · rw [mem_ball, dist_eq_norm] at hz; exact hz
  · have := eq_norm_mul_e_pi_add_arg (z - v)
    linear_combination this

/-! ### The T-junctions of the brick map

The brick map's cells are the rectangles `[2/5 r + 4/5 c, 2/5 r + 4/5 (c + 1)] × [3/5 r, 3/5 (r + 1)]`. Its points of three colours are the
**upward T-junctions** `brickCorner c r` (the lower left corner of the cell `(c, r)`: cells `(c, r)`, `(c − 1, r)` above, `(c, r − 1)` below)
and the **downward T-junctions** `brickCorner c r − 2/5` (the upper left corner of the cell `(c, r − 1)`: cell `(c − 1, r)` above, cells
`(c − 1, r − 1)`, `(c, r − 1)` below); each has angles `π/2, π/2, π` and three distinct colours. -/

/-- The directions of the upward T-junction's sectors: upper right, upper left, lower. -/
noncomputable def tUpDirs : Fin 4 → ℝ := ![0, π / 2, π, 2 * π]

/-- The colours of the upward T-junction `brickCorner c r`'s sectors. -/
def tUpCols (c r : ℤ) : Fin 3 → Fin 7 := ![brickCellCol c r, brickCellCol (c - 1) r, brickCellCol c (r - 1)]

/-- The directions of the downward T-junction's sectors: upper, lower left, lower right. -/
noncomputable def tDownDirs : Fin 4 → ℝ := ![0, π, 3 * π / 2, 2 * π]

/-- The colours of the downward T-junction `brickCorner c r − 2/5`'s sectors. -/
def tDownCols (c r : ℤ) : Fin 3 → Fin 7 := ![brickCellCol (c - 1) r, brickCellCol (c - 1) (r - 1), brickCellCol c (r - 1)]

-- Spec examples: the corner `0` is the upward T-junction `brickCorner 0 0` with colours `0, 6, 4` (as `sevenBrick_corner_col` computes
-- them independently), and `−2/5` the downward one `brickCorner 0 0 − 2/5` with colours `6, 3, 4`; the directions are the quarter turns.
example : tUpCols 0 0 = ![0, 6, 4] := by decide
example : tDownCols 0 0 = ![6, 3, 4] := by decide
example : tUpDirs 1 = π / 2 ∧ tDownDirs 2 = 3 * π / 2 := by simp [tUpDirs, tDownDirs]

theorem tUpCols_injective (c r : ℤ) : Function.Injective (tUpCols c r) := by
  intro i j hij
  fin_cases i <;> fin_cases j <;> simp [tUpCols] at hij ⊢ <;> exact absurd hij (brickCellCol_ne (by omega))

theorem tDownCols_injective (c r : ℤ) : Function.Injective (tDownCols c r) := by
  intro i j hij
  fin_cases i <;> fin_cases j <;> simp [tDownCols] at hij ⊢ <;> exact absurd hij (brickCellCol_ne (by omega))

theorem tUpDirs_lt (i : Fin 3) : tUpDirs i.castSucc < tUpDirs i.succ := by
  have hπ := Real.pi_pos
  fin_cases i <;> simp [tUpDirs] <;> linarith

theorem tDownDirs_lt (i : Fin 3) : tDownDirs i.castSucc < tDownDirs i.succ := by
  have hπ := Real.pi_pos
  fin_cases i <;> simp [tDownDirs] <;> linarith

theorem tUpDirs_ge (i : Fin 3) : π / 3 ≤ tUpDirs i.succ - tUpDirs i.castSucc := by
  have hπ := Real.pi_pos
  fin_cases i <;> simp [tUpDirs] <;> linarith

theorem tDownDirs_ge (i : Fin 3) : π / 3 ≤ tDownDirs i.succ - tDownDirs i.castSucc := by
  have hπ := Real.pi_pos
  fin_cases i <;> simp [tDownDirs] <;> linarith

/-- The brick corner `brickCorner c r` lies on a cell edge. -/
theorem brickCorner_mem_arcs (c r : ℤ) : brickCorner c r ∈ ⋃ a ∈ sevenBrickArcs, a.carrier :=
  mem_sevenBrickArcs_of_bottom (by rw [brickCorner_im]) (by rw [brickCorner_re]) (by rw [brickCorner_re]; linarith)

/-- **The upward T-junction's sectors lie in their cells.** -/
theorem tUp_sub (c r : ℤ) (i : Fin 3) :
    annSector (brickCorner c r) 0 (1 / 5) (tUpDirs i.castSucc) (tUpDirs i.succ) ⊆ sevenBrickMap.region (tUpCols c r i) := by
  have hπ := Real.pi_pos
  rintro z ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
  simp only at hs hθ ⊢
  obtain ⟨hre, him⟩ := polar_re_im (brickCorner c r) s θ
  rw [brickCorner_re] at hre
  rw [brickCorner_im] at him
  have hc1 := Real.abs_cos_le_one θ
  have hs1 := Real.abs_sin_le_one θ
  have hsc : |s * Real.cos θ| < 1 / 5 := by
    rw [abs_mul, abs_of_pos hs.1]
    calc s * |Real.cos θ| ≤ s * 1 := mul_le_mul_of_nonneg_left hc1 hs.1.le
      _ < 1 / 5 := by linarith [hs.2]
  have hss : |s * Real.sin θ| < 1 / 5 := by
    rw [abs_mul, abs_of_pos hs.1]
    calc s * |Real.sin θ| ≤ s * 1 := mul_le_mul_of_nonneg_left hs1 hs.1.le
      _ < 1 / 5 := by linarith [hs.2]
  obtain ⟨hsc1, hsc2⟩ := abs_lt.mp hsc
  obtain ⟨hss1, hss2⟩ := abs_lt.mp hss
  fin_cases i <;> simp [tUpDirs] at hθ <;> simp only [tUpCols, Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Matrix.cons_val_zero,
    Matrix.cons_val_one, Matrix.cons_val_two]
  · have hcos : 0 < Real.cos θ := Real.cos_pos_of_mem_Ioo ⟨by linarith, hθ.2⟩
    have hsin : 0 < Real.sin θ := Real.sin_pos_of_pos_of_lt_pi hθ.1 (by linarith)
    have : 0 < s * Real.cos θ := mul_pos hs.1 hcos
    have : 0 < s * Real.sin θ := mul_pos hs.1 hsin
    exact sevenBrickMap_mem_region_of_cell (by linarith) (by linarith) (by linarith) (by linarith)
  · have hcos : Real.cos θ < 0 := Real.cos_neg_of_pi_div_two_lt_of_lt hθ.1 (by linarith)
    have hsin : 0 < Real.sin θ := Real.sin_pos_of_pos_of_lt_pi (by linarith) hθ.2
    have : s * Real.cos θ < 0 := mul_neg_of_pos_of_neg hs.1 hcos
    have : 0 < s * Real.sin θ := mul_pos hs.1 hsin
    exact sevenBrickMap_mem_region_of_cell (by linarith) (by linarith) (by push_cast; linarith) (by push_cast; linarith)
  · have hsin : Real.sin θ < 0 := by
      rw [← Real.sin_sub_two_pi]; exact Real.sin_neg_of_neg_of_neg_pi_lt (by linarith) (by linarith)
    have : s * Real.sin θ < 0 := mul_neg_of_pos_of_neg hs.1 hsin
    exact sevenBrickMap_mem_region_of_cell (by push_cast; linarith) (by push_cast; linarith) (by push_cast; linarith)
      (by push_cast; linarith)

/-- **The downward T-junction's sectors lie in their cells.** -/
theorem tDown_sub (c r : ℤ) (i : Fin 3) :
    annSector (brickCorner c r - 2 / 5) 0 (1 / 5) (tDownDirs i.castSucc) (tDownDirs i.succ) ⊆
      sevenBrickMap.region (tDownCols c r i) := by
  have hπ := Real.pi_pos
  rintro z ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
  simp only at hs hθ ⊢
  obtain ⟨hre, him⟩ := polar_re_im (brickCorner c r - 2 / 5) s θ
  have hvre : (brickCorner c r - 2 / 5).re = 2 / 5 * r + 4 / 5 * c - 2 / 5 := by
    rw [Complex.sub_re, brickCorner_re]; norm_num
  have hvim : (brickCorner c r - 2 / 5).im = 3 / 5 * r := by
    rw [Complex.sub_im, brickCorner_im]; norm_num
  rw [hvre] at hre
  rw [hvim] at him
  have hc1 := Real.abs_cos_le_one θ
  have hs1 := Real.abs_sin_le_one θ
  have hsc : |s * Real.cos θ| < 1 / 5 := by
    rw [abs_mul, abs_of_pos hs.1]
    calc s * |Real.cos θ| ≤ s * 1 := mul_le_mul_of_nonneg_left hc1 hs.1.le
      _ < 1 / 5 := by linarith [hs.2]
  have hss : |s * Real.sin θ| < 1 / 5 := by
    rw [abs_mul, abs_of_pos hs.1]
    calc s * |Real.sin θ| ≤ s * 1 := mul_le_mul_of_nonneg_left hs1 hs.1.le
      _ < 1 / 5 := by linarith [hs.2]
  obtain ⟨hsc1, hsc2⟩ := abs_lt.mp hsc
  obtain ⟨hss1, hss2⟩ := abs_lt.mp hss
  fin_cases i <;> simp [tDownDirs] at hθ <;> simp only [tDownCols, Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Matrix.cons_val_zero,
    Matrix.cons_val_one, Matrix.cons_val_two]
  · have hsin : 0 < Real.sin θ := Real.sin_pos_of_pos_of_lt_pi hθ.1 hθ.2
    have : 0 < s * Real.sin θ := mul_pos hs.1 hsin
    exact sevenBrickMap_mem_region_of_cell (by linarith) (by linarith) (by push_cast; linarith) (by push_cast; linarith)
  · have hcos : Real.cos θ < 0 := Real.cos_neg_of_pi_div_two_lt_of_lt (by linarith) (by linarith)
    have hsin : Real.sin θ < 0 := by
      rw [← Real.sin_sub_two_pi]; exact Real.sin_neg_of_neg_of_neg_pi_lt (by linarith) (by linarith)
    have : s * Real.cos θ < 0 := mul_neg_of_pos_of_neg hs.1 hcos
    have : s * Real.sin θ < 0 := mul_neg_of_pos_of_neg hs.1 hsin
    exact sevenBrickMap_mem_region_of_cell (by push_cast; linarith) (by push_cast; linarith) (by push_cast; linarith)
      (by push_cast; linarith)
  · have hcos : 0 < Real.cos θ := by
      rw [← Real.cos_sub_two_pi]; exact Real.cos_pos_of_mem_Ioo ⟨by linarith, by linarith⟩
    have hsin : Real.sin θ < 0 := by
      rw [← Real.sin_sub_two_pi]; exact Real.sin_neg_of_neg_of_neg_pi_lt (by linarith) (by linarith)
    have : 0 < s * Real.cos θ := mul_pos hs.1 hcos
    have : s * Real.sin θ < 0 := mul_neg_of_pos_of_neg hs.1 hsin
    exact sevenBrickMap_mem_region_of_cell (by push_cast; linarith) (by push_cast; linarith) (by push_cast; linarith)
      (by push_cast; linarith)

/-- **Every interior point near an upward T-junction lies in one of its three sectors** (the angles `π/2`, `π`, `2π` are cell edges). -/
theorem tUp_cov (c r : ℤ) : ∀ z ∈ sevenBrickMap.interiorPts, z ∈ ball (brickCorner c r) (1 / 5) →
    ∃ i : Fin 3, z ∈ annSector (brickCorner c r) 0 (1 / 5) (tUpDirs i.castSucc) (tUpDirs i.succ) := by
  have hπ := Real.pi_pos
  intro z hz hzb
  have hne : z ≠ brickCorner c r := fun h => hz.2 (h ▸ brickCorner_mem_arcs c r)
  obtain ⟨s, θ, hs0, hsρ, hθ, rfl⟩ := exists_polar_Ioc hzb hne
  obtain ⟨hre, him⟩ := polar_re_im (brickCorner c r) s θ
  rw [brickCorner_re] at hre
  rw [brickCorner_im] at him
  have hmem : ∀ a b : ℝ, θ ∈ Ioo a b → brickCorner c r + (s : ℂ) * e θ ∈ annSector (brickCorner c r) 0 (1 / 5) a b :=
    fun a b hab => ⟨(s, θ), ⟨⟨hs0, hsρ⟩, hab⟩, rfl⟩
  have harc : brickCorner c r + (s : ℂ) * e θ ∉ ⋃ a ∈ sevenBrickArcs, a.carrier := hz.2
  rcases lt_trichotomy θ (π / 2) with h1 | h1 | h1
  · exact ⟨0, hmem _ _ (by simp [tUpDirs]; exact ⟨hθ.1, h1⟩)⟩
  · exfalso; apply harc
    subst h1
    simp only [Real.cos_pi_div_two, Real.sin_pi_div_two, mul_zero, mul_one, add_zero] at hre him
    exact mem_sevenBrickArcs_of_left (c := c) (r := r) (by linarith) (by rw [him]; linarith)
      (by rw [him]; linarith)
  rcases lt_trichotomy θ π with h2 | h2 | h2
  · exact ⟨1, hmem _ _ (by simp [tUpDirs]; exact ⟨h1, h2⟩)⟩
  · exfalso; apply harc
    subst h2
    simp only [Real.cos_pi, Real.sin_pi, mul_zero, mul_neg, mul_one, add_zero] at hre him
    exact mem_sevenBrickArcs_of_bottom (c := c - 1) (r := r) (by linarith) (by rw [hre]; push_cast; linarith)
      (by rw [hre]; push_cast; linarith)
  rcases lt_or_eq_of_le hθ.2 with h3 | h3
  · exact ⟨2, hmem _ _ (by simp [tUpDirs]; exact ⟨h2, h3⟩)⟩
  · exfalso; apply harc
    subst h3
    simp only [Real.cos_two_pi, Real.sin_two_pi, mul_zero, mul_one, add_zero] at hre him
    exact mem_sevenBrickArcs_of_bottom (c := c) (r := r) (by linarith) (by rw [hre]; linarith)
      (by rw [hre]; linarith)

/-- **Every interior point near a downward T-junction lies in one of its three sectors** (the angles `π`, `3π/2`, `2π` are cell edges). -/
theorem tDown_cov (c r : ℤ) : ∀ z ∈ sevenBrickMap.interiorPts, z ∈ ball (brickCorner c r - 2 / 5) (1 / 5) →
    ∃ i : Fin 3, z ∈ annSector (brickCorner c r - 2 / 5) 0 (1 / 5) (tDownDirs i.castSucc) (tDownDirs i.succ) := by
  have hπ := Real.pi_pos
  intro z hz hzb
  have hvre : (brickCorner c r - 2 / 5).re = 2 / 5 * r + 4 / 5 * c - 2 / 5 := by
    rw [Complex.sub_re, brickCorner_re]; norm_num
  have hvim : (brickCorner c r - 2 / 5).im = 3 / 5 * r := by
    rw [Complex.sub_im, brickCorner_im]; norm_num
  have hv : brickCorner c r - 2 / 5 ∈ ⋃ a ∈ sevenBrickArcs, a.carrier :=
    mem_sevenBrickArcs_of_bottom (c := c - 1) (r := r) hvim (by rw [hvre]; push_cast; linarith) (by rw [hvre]; push_cast; linarith)
  have hne : z ≠ brickCorner c r - 2 / 5 := fun h => hz.2 (h ▸ hv)
  obtain ⟨s, θ, hs0, hsρ, hθ, rfl⟩ := exists_polar_Ioc hzb hne
  obtain ⟨hre, him⟩ := polar_re_im (brickCorner c r - 2 / 5) s θ
  rw [hvre] at hre
  rw [hvim] at him
  have hmem : ∀ a b : ℝ, θ ∈ Ioo a b →
      brickCorner c r - 2 / 5 + (s : ℂ) * e θ ∈ annSector (brickCorner c r - 2 / 5) 0 (1 / 5) a b :=
    fun a b hab => ⟨(s, θ), ⟨⟨hs0, hsρ⟩, hab⟩, rfl⟩
  have harc : brickCorner c r - 2 / 5 + (s : ℂ) * e θ ∉ ⋃ a ∈ sevenBrickArcs, a.carrier := hz.2
  rcases lt_trichotomy θ π with h1 | h1 | h1
  · exact ⟨0, hmem _ _ (by simp [tDownDirs]; exact ⟨hθ.1, h1⟩)⟩
  · exfalso; apply harc
    subst h1
    simp only [Real.cos_pi, Real.sin_pi, mul_zero, mul_neg, mul_one, add_zero] at hre him
    exact mem_sevenBrickArcs_of_bottom (c := c - 1) (r := r) (by linarith) (by rw [hre]; push_cast; linarith)
      (by rw [hre]; push_cast; linarith)
  have hc32 : Real.cos (3 * π / 2) = 0 := by
    rw [show 3 * π / 2 = π / 2 + π by ring, Real.cos_add_pi, Real.cos_pi_div_two, neg_zero]
  have hs32 : Real.sin (3 * π / 2) = -1 := by
    rw [show 3 * π / 2 = π / 2 + π by ring, Real.sin_add_pi, Real.sin_pi_div_two]
  rcases lt_trichotomy θ (3 * π / 2) with h2 | h2 | h2
  · exact ⟨1, hmem _ _ (by simp [tDownDirs]; exact ⟨h1, h2⟩)⟩
  · exfalso; apply harc
    subst h2
    simp only [hc32, hs32, mul_zero, mul_neg, mul_one, add_zero] at hre him
    exact mem_sevenBrickArcs_of_left (c := c) (r := r - 1) (by rw [hre]; push_cast; ring) (by rw [him]; push_cast; linarith)
      (by rw [him]; push_cast; linarith)
  rcases lt_or_eq_of_le hθ.2 with h3 | h3
  · exact ⟨2, hmem _ _ (by simp [tDownDirs]; exact ⟨h2, h3⟩)⟩
  · exfalso; apply harc
    subst h3
    simp only [Real.cos_two_pi, Real.sin_two_pi, mul_zero, mul_one, add_zero] at hre him
    exact mem_sevenBrickArcs_of_bottom (c := c - 1) (r := r) (by linarith) (by rw [hre]; push_cast; linarith)
      (by rw [hre]; push_cast; linarith)

/-- **Woodall's picture at an upward T-junction**: three sectors (angles `π/2, π/2, π`), colours `brickCellCol c r`,
`brickCellCol (c − 1) r`, `brickCellCol c (r − 1)`. -/
theorem sevenBrickMap_sectorsAt_tUp (c r : ℤ) : sevenBrickMap.SectorsAt (brickCorner c r) 3 tUpDirs (tUpCols c r) := by
  have hπ := Real.pi_pos
  refine ⟨by norm_num, ?_, by simp [tUpDirs], fun _ i => (tUpCols_injective c r).ne (by fin_cases i <;> decide), mem_univ _,
    sevenBrickMap.coneAt_region_of_sectors (by norm_num) tUpDirs_lt (tUp_sub c r) (tUp_cov c r)⟩
  rw [Fin.monotone_iff_le_succ]; intro i; fin_cases i <;> simp [tUpDirs] <;> linarith

/-- **Woodall's picture at a downward T-junction**: three sectors (angles `π, π/2, π/2`), colours `brickCellCol (c − 1) r`,
`brickCellCol (c − 1) (r − 1)`, `brickCellCol c (r − 1)`. -/
theorem sevenBrickMap_sectorsAt_tDown (c r : ℤ) :
    sevenBrickMap.SectorsAt (brickCorner c r - 2 / 5) 3 tDownDirs (tDownCols c r) := by
  have hπ := Real.pi_pos
  refine ⟨by norm_num, ?_, by simp [tDownDirs], fun _ i => (tDownCols_injective c r).ne (by fin_cases i <;> decide), mem_univ _,
    sevenBrickMap.coneAt_region_of_sectors (by norm_num) tDownDirs_lt (tDown_sub c r) (tDown_cov c r)⟩
  rw [Fin.monotone_iff_le_succ]; intro i; fin_cases i <;> simp [tDownDirs] <;> linarith

-- Spec example: the picture's colours at the corner `0` are the colours wave 4 computed there (`sevenBrick_corner_coloursAt`).
example : range (tUpCols 0 0) = ({0, 6, 4} : Set (Fin 7)) := by
  have h0 : brickCorner 0 0 = 0 := by simp [brickCorner]
  have h := (sevenBrickMap_sectorsAt_tUp 0 0).coloursAt_eq
  rw [h0, sevenBrick_corner_coloursAt] at h
  exact h.symm

/-! ### The points of three colours are the T-junctions -/

/-- The closed brick cell `(c, r)`: the rectangle `[2/5 r + 4/5 c, 2/5 r + 4/5 (c + 1)] × [3/5 r, 3/5 (r + 1)]`. -/
def brickClosedCell (c r : ℤ) : Set ℂ :=
  {z | 3 / 5 * (r : ℝ) ≤ z.im ∧ z.im ≤ 3 / 5 * r + 3 / 5 ∧ 2 / 5 * (r : ℝ) + 4 / 5 * c ≤ z.re ∧ z.re ≤ 2 / 5 * r + 4 / 5 * c + 4 / 5}

-- Spec example: the corner `0` lies in the three closed cells of its T, `(0, 0)`, `(−1, 0)`, `(0, −1)`, and not in `(1, 0)`.
example : (0 : ℂ) ∈ brickClosedCell 0 0 ∧ (0 : ℂ) ∈ brickClosedCell (-1) 0 ∧ (0 : ℂ) ∈ brickClosedCell 0 (-1) ∧
    (0 : ℂ) ∉ brickClosedCell 1 0 := by
  simp only [brickClosedCell, mem_setOf_eq, Complex.zero_re, Complex.zero_im]; norm_num

theorem isClosed_brickClosedCell (c r : ℤ) : IsClosed (brickClosedCell c r) := by
  have h1 : IsClosed {z : ℂ | 3 / 5 * (r : ℝ) ≤ z.im} := isClosed_le continuous_const Complex.continuous_im
  have h2 : IsClosed {z : ℂ | z.im ≤ 3 / 5 * r + 3 / 5} := isClosed_le Complex.continuous_im continuous_const
  have h3 : IsClosed {z : ℂ | 2 / 5 * (r : ℝ) + 4 / 5 * c ≤ z.re} := isClosed_le continuous_const Complex.continuous_re
  have h4 : IsClosed {z : ℂ | z.re ≤ 2 / 5 * r + 4 / 5 * c + 4 / 5} := isClosed_le Complex.continuous_re continuous_const
  exact h1.inter (h2.inter (h3.inter h4))

/-- **Every colour at a point is the colour of a closed cell through it**: near `z` the class of colour `j` lies in the finitely many
closed cells of colour `j` within a row and a column of `z`'s cell. -/
theorem sevenBrickMap_mem_coloursAt {z : ℂ} {j : Fin 7} (hj : j ∈ sevenBrickMap.coloursAt z) :
    ∃ c r : ℤ, brickCellCol c r = j ∧ z ∈ brickClosedCell c r := by
  set R := ⌊z.im / (3 / 5)⌋ with hR
  set C := ⌊(z.re - 2 / 5 * R) / (4 / 5)⌋ with hC
  have hR' := Int.floor_eq_iff.mp hR.symm
  have hC' := Int.floor_eq_iff.mp hC.symm
  rw [le_div_iff₀ (by norm_num), div_lt_iff₀ (by norm_num)] at hR' hC'
  let N : Set (ℤ × ℤ) := {X | X.1 ∈ Icc (C - 1) (C + 1) ∧ X.2 ∈ Icc (R - 1) (R + 1) ∧ brickCellCol X.1 X.2 = j}
  have hN : N.Finite := ((Set.finite_Icc (C - 1) (C + 1)).prod (Set.finite_Icc (R - 1) (R + 1))).subset
    (fun X hX => ⟨hX.1, hX.2.1⟩)
  have hsub : sevenBrickMap.region j ∩ ball z (1 / 10) ⊆ ⋃ X ∈ N, brickClosedCell X.1 X.2 := by
    rintro w ⟨hw, hwb⟩
    set Rw := ⌊w.im / (3 / 5)⌋ with hRw
    set Cw := ⌊(w.re - 2 / 5 * Rw) / (4 / 5)⌋ with hCw
    have hRw' := Int.floor_eq_iff.mp hRw.symm
    have hCw' := Int.floor_eq_iff.mp hCw.symm
    rw [le_div_iff₀ (by norm_num), div_lt_iff₀ (by norm_num)] at hRw' hCw'
    have hcol : sevenBrickMap.col w = brickCellCol Cw Rw := sevenBrick_color_eq hRw.symm hCw.symm
    have hd : ‖w - z‖ < 1 / 10 := by rw [← dist_eq_norm]; exact hwb
    have hre := (abs_lt.mp ((Complex.abs_re_le_norm (w - z)).trans_lt hd))
    have him := (abs_lt.mp ((Complex.abs_im_le_norm (w - z)).trans_lt hd))
    rw [Complex.sub_re] at hre
    rw [Complex.sub_im] at him
    have hr1 : (Rw : ℝ) < R + 2 := by linarith
    have hr2 : (R : ℝ) - 2 < Rw := by linarith
    have hr1' : Rw < R + 2 := by exact_mod_cast hr1
    have hr2' : R - 2 < Rw := by exact_mod_cast hr2
    have hrw1 : (Rw : ℝ) ≤ R + 1 := by exact_mod_cast (show Rw ≤ R + 1 by omega)
    have hrw2 : (R : ℝ) - 1 ≤ Rw := by exact_mod_cast (show R - 1 ≤ Rw by omega)
    have hc1 : (Cw : ℝ) < C + 2 := by linarith
    have hc2 : (C : ℝ) - 2 < Cw := by linarith
    have hc1' : Cw < C + 2 := by exact_mod_cast hc1
    have hc2' : C - 2 < Cw := by exact_mod_cast hc2
    refine mem_iUnion₂.mpr ⟨(Cw, Rw), ⟨⟨by omega, by omega⟩, ⟨by omega, by omega⟩, ?_⟩, ?_⟩
    · rw [← hcol]; exact hw.2
    · exact ⟨by linarith, by linarith, by linarith, by linarith⟩
  have hz : z ∈ closure (sevenBrickMap.region j ∩ ball z (1 / 10)) := by
    rw [Metric.mem_closure_iff]
    intro ε hε
    obtain ⟨b, hb, hzb⟩ := Metric.mem_closure_iff.mp hj (min ε (1 / 10)) (lt_min hε (by norm_num))
    exact ⟨b, ⟨hb, by rw [mem_ball, dist_comm]; exact hzb.trans_le (min_le_right _ _)⟩, hzb.trans_le (min_le_left _ _)⟩
  have hz' := closure_mono hsub hz
  rw [hN.closure_biUnion] at hz'
  obtain ⟨X, hX, hzX⟩ := mem_iUnion₂.mp hz'
  rw [(isClosed_brickClosedCell _ _).closure_eq] at hzX
  exact ⟨X.1, X.2, hX.2.2, hzX⟩

/-- Two closed cells of one row through a point: the columns are adjacent and the point is on the edge between them. -/
theorem brickClosedCell_same_row {z : ℂ} {a b r : ℤ} (ha : z ∈ brickClosedCell a r) (hb : z ∈ brickClosedCell b r) (hab : a < b) :
    b = a + 1 ∧ z.re = 2 / 5 * r + 4 / 5 * b := by
  obtain ⟨-, -, ha3, ha4⟩ := ha
  obtain ⟨-, -, hb3, hb4⟩ := hb
  have h : (b : ℝ) ≤ a + 1 := by linarith
  have h' : b ≤ a + 1 := by exact_mod_cast h
  have hb1 : b = a + 1 := by omega
  refine ⟨hb1, ?_⟩
  have : (b : ℝ) = a + 1 := by exact_mod_cast hb1
  linarith

/-- Two closed cells of different rows through a point: the rows are adjacent and the point is on the line between them. -/
theorem brickClosedCell_rows {z : ℂ} {a b r r' : ℤ} (ha : z ∈ brickClosedCell a r) (hb : z ∈ brickClosedCell b r') (hrr : r < r') :
    r' = r + 1 ∧ z.im = 3 / 5 * r' := by
  obtain ⟨ha1, ha2, -, -⟩ := ha
  obtain ⟨hb1, hb2, -, -⟩ := hb
  have h : (r' : ℝ) ≤ r + 1 := by linarith
  have h' : r' ≤ r + 1 := by exact_mod_cast h
  have hr1 : r' = r + 1 := by omega
  refine ⟨hr1, ?_⟩
  have : (r' : ℝ) = r + 1 := by exact_mod_cast hr1
  linarith

/-- Two closed cells of one row through `z` and a third of another row: `z` is a T-junction. -/
theorem tJunction_of_pair {z : ℂ} {a b r c' r' : ℤ} (ha : z ∈ brickClosedCell a r) (hb : z ∈ brickClosedCell b r) (hab : a < b)
    (hc : z ∈ brickClosedCell c' r') (hr : r' ≠ r) : ∃ c r : ℤ, z = brickCorner c r ∨ z = brickCorner c r - 2 / 5 := by
  obtain ⟨-, hre⟩ := brickClosedCell_same_row ha hb hab
  rcases lt_or_gt_of_ne hr with h | h
  · -- the third cell below: `z` is the upward T-junction `brickCorner b r`
    obtain ⟨-, him⟩ := brickClosedCell_rows hc ha h
    refine ⟨b, r, Or.inl (Complex.ext ?_ ?_)⟩
    · rw [hre, brickCorner_re]
    · rw [him, brickCorner_im]
  · -- the third cell above: `z` is the downward T-junction `brickCorner b (r + 1) − 2/5`
    obtain ⟨hr1, him⟩ := brickClosedCell_rows ha hc h
    refine ⟨b, r', Or.inr (Complex.ext ?_ ?_)⟩
    · rw [Complex.sub_re, hre, brickCorner_re, hr1]; push_cast; norm_num; ring
    · rw [Complex.sub_im, him, brickCorner_im]; norm_num

/-- Three distinct closed cells through `z`: `z` is a T-junction. -/
theorem tJunction_of_three {z : ℂ} {c₁ r₁ c₂ r₂ c₃ r₃ : ℤ} (h₁ : z ∈ brickClosedCell c₁ r₁) (h₂ : z ∈ brickClosedCell c₂ r₂)
    (h₃ : z ∈ brickClosedCell c₃ r₃) (h12 : (c₁, r₁) ≠ (c₂, r₂)) (h13 : (c₁, r₁) ≠ (c₃, r₃)) (h23 : (c₂, r₂) ≠ (c₃, r₃)) :
    ∃ c r : ℤ, z = brickCorner c r ∨ z = brickCorner c r - 2 / 5 := by
  -- two cells of one row (rows lie within one of each other), and the third, of another row
  have hrow : ∀ {a b r r' : ℤ}, z ∈ brickClosedCell a r → z ∈ brickClosedCell b r' → r ≤ r' + 1 := by
    intro a b r r' ha hb
    have h : (r : ℝ) ≤ r' + 1 := by linarith [ha.1, hb.2.1]
    exact_mod_cast h
  have hcol : ∀ {a b r : ℤ}, z ∈ brickClosedCell a r → z ∈ brickClosedCell b r → a ≤ b + 1 := by
    intro a b r ha hb
    have h : (a : ℝ) ≤ b + 1 := by linarith [ha.2.2.1, hb.2.2.2]
    exact_mod_cast h
  have pair : ∀ {a b r c' r' : ℤ}, z ∈ brickClosedCell a r → z ∈ brickClosedCell b r → a ≠ b → z ∈ brickClosedCell c' r' →
      (r' = r → c' ≠ a ∧ c' ≠ b) → ∃ c r : ℤ, z = brickCorner c r ∨ z = brickCorner c r - 2 / 5 := by
    intro a b r c' r' ha hb hab hc hdist
    have hr : r' ≠ r := by
      rintro rfl
      obtain ⟨h1, h2⟩ := hdist rfl
      have := hcol ha hb; have := hcol hb ha; have := hcol hc ha; have := hcol ha hc; have := hcol hc hb; have := hcol hb hc
      omega
    rcases lt_or_gt_of_ne hab with h | h
    · exact tJunction_of_pair ha hb h hc hr
    · exact tJunction_of_pair hb ha h hc hr
  by_cases e12 : r₁ = r₂
  · subst e12
    exact pair h₁ h₂ (fun h => h12 (by rw [h])) h₃ (fun h => ⟨fun h' => h13 (by rw [h, h']), fun h' => h23 (by rw [h, h'])⟩)
  by_cases e13 : r₁ = r₃
  · subst e13
    exact pair h₁ h₃ (fun h => h13 (by rw [h])) h₂ (fun h => ⟨fun h' => h12 (by rw [h, h']), fun h' => h23 (by rw [h, h'])⟩)
  by_cases e23 : r₂ = r₃
  · subst e23
    exact pair h₂ h₃ (fun h => h23 (by rw [h])) h₁ (fun h => ⟨fun h' => h12 (by rw [h, h']), fun h' => h13 (by rw [h, h'])⟩)
  exfalso
  have := hrow h₁ h₂; have := hrow h₂ h₁; have := hrow h₁ h₃; have := hrow h₃ h₁; have := hrow h₂ h₃; have := hrow h₃ h₂
  omega

/-- **The points of three or more colours of the brick map are its T-junctions.** -/
theorem sevenBrickMap_tJunction {z : ℂ} (hz : 3 ≤ (sevenBrickMap.coloursAt z).ncard) :
    ∃ c r : ℤ, z = brickCorner c r ∨ z = brickCorner c r - 2 / 5 := by
  obtain ⟨a, ha, b, hb, d, hd, hab, had, hbd⟩ := (Set.two_lt_ncard (Set.toFinite _)).mp hz
  obtain ⟨c₁, r₁, hc₁, h₁⟩ := sevenBrickMap_mem_coloursAt ha
  obtain ⟨c₂, r₂, hc₂, h₂⟩ := sevenBrickMap_mem_coloursAt hb
  obtain ⟨c₃, r₃, hc₃, h₃⟩ := sevenBrickMap_mem_coloursAt hd
  refine tJunction_of_three h₁ h₂ h₃ ?_ ?_ ?_ <;> intro h <;> simp only [Prod.mk.injEq] at h <;> obtain ⟨rfl, rfl⟩ := h
  · exact hab (hc₁.symm.trans hc₂)
  · exact had (hc₁.symm.trans hc₃)
  · exact hbd (hc₂.symm.trans hc₃)

/-! ### The model -/

/-- **`sevenBrickMap` satisfies Condition 5**: its arcs are segments, and a segment meets a unit circle in finitely many points. -/
theorem sevenBrickMap_condition5 : sevenBrickMap.Condition5 := by
  intro a ha p
  rcases a.finite_inter_sphere_or_eq_circ (sevenBrickMap.nondegenerate a ha) p with h | ⟨θ₀, θ₁, rfl⟩
  · exact h.subset fun z hz => ⟨hz.1.1, hz.2⟩
  · exfalso
    change Arc.circ p 1 θ₀ θ₁ ∈ sevenBrickArcs at ha
    simp only [sevenBrickArcs, mem_iUnion, mem_insert_iff, mem_singleton_iff] at ha
    obtain ⟨c, r, h | h⟩ := ha <;> cases h

/-- **QA2-1's plane-map model: the brick map is in Woodall's normal form on the whole plane.** Every point of `sevenBrickMap` (valid, a
map of the plane, seven colours) carrying three or more colours is a T-junction (`sevenBrickMap_tJunction`), whose picture has three
distinct colours and angles `π/2, π/2, π` (`sevenBrickMap_sectorsAt_tUp`, `sevenBrickMap_sectorsAt_tDown`). -/
theorem sevenBrickMap_woodallNormal : sevenBrickMap.WoodallNormal univ := by
  intro v _ hv
  obtain ⟨c, r, rfl | rfl⟩ := sevenBrickMap_tJunction hv
  · exact ⟨3, tUpDirs, tUpCols c r, sevenBrickMap_sectorsAt_tUp c r, tUpCols_injective c r, tUpDirs_ge⟩
  · exact ⟨3, tDownDirs, tDownCols c r, sevenBrickMap_sectorsAt_tDown c r, tDownCols_injective c r, tDownDirs_ge⟩

/-- **QA2-1's plane-map model, merged form**: every point of `sevenBrickMap` of three or more colours is `NiceAt`. -/
theorem sevenBrickMap_woodallMerged : sevenBrickMap.WoodallMerged univ := by
  intro v _ hv
  obtain ⟨c, r, rfl | rfl⟩ := sevenBrickMap_tJunction hv
  · exact ArcMap.niceAt_of_injective (sevenBrickMap_sectorsAt_tUp c r) (tUpCols_injective c r) tUpDirs_lt
  · exact ArcMap.niceAt_of_injective (sevenBrickMap_sectorsAt_tDown c r) (tDownCols_injective c r) tDownDirs_lt

/-- **The model of Woodall's chain's hypotheses on a plane map** (FS131-QA2's QA2-1; `LEAN.md` § The gate's inhabitant rule): at `k = 7`,
a parameter the refutations (`k ≤ 5`) leave alive, `sevenBrickMap` is valid, a map of the plane, satisfies Condition 5, and is in Woodall's
normal form and merged on the whole plane — so on `closedBall 0 3`, the set `ArcMap.aeMap6_normal` and `ArcMap.aeMap6_merged` read — all at
once: every hypothesis of `ArcMap.aeMap6`, `ArcMap.aeMap6_of_condition5`, `ArcMap.aeMap6_normal` and `ArcMap.aeMap6_merged` but `k ≤ 5`.
The normal form is exercised: the corner `0` carries three colours (`sevenBrick_corner_coloursAt`), and every point of three or more colours
is a T-junction with a picture of three distinct colours (`sevenBrickMap_tJunction`). -/
theorem sevenBrickMap_woodallModel :
    sevenBrickMap.Valid ∧ sevenBrickMap.IsPlaneMap ∧ sevenBrickMap.Condition5 ∧ sevenBrickMap.WoodallNormal univ ∧
      sevenBrickMap.WoodallMerged univ ∧ (sevenBrickMap.coloursAt 0).ncard = 3 := by
  refine ⟨sevenBrickMap_valid, sevenBrickMap_isPlaneMap, sevenBrickMap_condition5, sevenBrickMap_woodallNormal,
    sevenBrickMap_woodallMerged, ?_⟩
  rw [sevenBrick_corner_coloursAt, ncard_insert_of_notMem (by decide), ncard_insert_of_notMem (by decide), ncard_singleton]

/-- **The model of Woodall's Theorem 6's hypotheses on a plane map** (`woodall_thm6`; `LEAN.md` § The gate's inhabitant rule): at `k = 7`
the brick colouring itself agrees with `sevenBrickMap` at its interior points and is proper at every unit pair (`Brick.avoids`, M36). -/
theorem sevenBrickMap_thm6Model :
    sevenBrickMap.IsPlaneMap ∧ (∀ x ∈ sevenBrickMap.interiorPts, sevenBrickMap.col x = sevenBrickMap.col x) ∧
      ∀ x y : ℂ, dist x y = 1 → sevenBrickMap.col x ≠ sevenBrickMap.col y :=
  ⟨sevenBrickMap_isPlaneMap, fun _ _ => rfl, fun x y hxy =>
    sevenBrick.avoids (List.mem_singleton.mpr rfl) sevenBrick_check (by rw [hxy]; simp)⟩

/-! ### Adversaries: a picture, and so the normal forms, exist only at points of the domain -/

namespace ArcMap

/-- **Adversary — a picture exists only at a point of the domain** (`SectorsAt`'s fifth clause, inventory item 155): `1` is not in
`threeSectorDisc`'s disc of radius `1/3`. A closed refutation, so a theorem taking this picture as a hypothesis is caught by the vacuity
scan. -/
theorem threeSectorDisc_not_sectorsAt_one : ¬ threeSectorDisc.SectorsAt 1 1 ![0, 2 * π] ![0] := by
  intro h
  have h1 : (1 : ℂ) ∈ ball (0 : ℂ) (1 / 3) := h.2.2.2.2.1
  rw [mem_ball, dist_zero_right, norm_one] at h1
  norm_num at h1

/-- **Adversary — `NiceAt` off the domain**: no picture, so no nice one, at `1 ∉ dom`. -/
theorem threeSectorDisc_not_niceAt_one : ¬ threeSectorDisc.NiceAt 1 := by
  rintro ⟨n, d, c, h, -⟩
  have h1 : (1 : ℂ) ∈ ball (0 : ℂ) (1 / 3) := h.2.2.2.2.1
  rw [mem_ball, dist_zero_right, norm_one] at h1
  norm_num at h1

/-- **A punctured three-sector disc**: `threeSectorDisc` with its centre removed from the domain. -/
noncomputable def puncturedThreeSectorDisc : ArcMap 3 where
  dom := ball 0 (1 / 3) \ {0}
  isOpen_dom := isOpen_ball.sdiff isClosed_singleton
  arcs := threeCuts
  nondegenerate := threeSectorDisc.nondegenerate
  locallyFinite := fun x hx => threeSectorDisc.locallyFinite x hx.1
  col := threeCol
  locallyConstant := fun x hx hcut => threeSectorDisc.locallyConstant x hx.1 hcut

-- Spec example: the centre is not in the punctured disc's domain.
example : (0 : ℂ) ∉ puncturedThreeSectorDisc.dom := fun h => h.2 rfl

/-- The centre lies on the cuts. -/
theorem zero_mem_threeCuts : (0 : ℂ) ∈ ⋃ a ∈ threeCuts, a.carrier :=
  mem_iUnion₂.mpr ⟨Arc.seg 0 (e 0 / 2), by simp [threeCuts], left_mem_segment ℝ _ _⟩

/-- Puncturing changes no colour class: the centre was on the cuts. -/
theorem puncturedThreeSectorDisc_region (j : Fin 3) : puncturedThreeSectorDisc.region j = threeSectorDisc.region j := by
  ext z
  constructor
  · rintro ⟨⟨⟨hz, -⟩, hcut⟩, hj⟩
    exact ⟨⟨hz, hcut⟩, hj⟩
  · rintro ⟨⟨hz, hcut⟩, hj⟩
    refine ⟨⟨⟨hz, fun h0 => hcut ?_⟩, hcut⟩, hj⟩
    rw [mem_singleton_iff.mp h0]; exact zero_mem_threeCuts

/-- The centre of the punctured disc still carries three colours. -/
theorem puncturedThreeSectorDisc_coloursAt_zero : (puncturedThreeSectorDisc.coloursAt 0).ncard = 3 := by
  have h : puncturedThreeSectorDisc.coloursAt 0 = threeSectorDisc.coloursAt 0 := by
    ext j; simp only [coloursAt, mem_setOf_eq, puncturedThreeSectorDisc_region]
  rw [h, threeSectorDisc_sectorsAt.coloursAt_eq]
  have : range (![0, 1, 2] : Fin 3 → Fin 3) = univ := by
    ext j; fin_cases j <;> simp
  rw [this, ncard_univ, Nat.card_eq_fintype_card, Fintype.card_fin]

/-- **Adversary — the normal forms read the domain**: the punctured disc's centre carries three colours and lies outside its domain, so
no picture exists there and the map is not merged on the plane (FS131-QA2's lesson: a hypothesis is modelled where the theorem's others
hold — `aeMap6` asks for a map of the plane, and `exists_woodallMerged` gives the merged form only there). -/
theorem puncturedThreeSectorDisc_not_woodallMerged : ¬ puncturedThreeSectorDisc.WoodallMerged univ := by
  intro h
  obtain ⟨n, d, c, hS, -⟩ := h 0 (mem_univ _) puncturedThreeSectorDisc_coloursAt_zero.ge
  exact hS.2.2.2.2.1.2 rfl

/-- **Adversary — not in normal form**: as `puncturedThreeSectorDisc_not_woodallMerged`. -/
theorem puncturedThreeSectorDisc_not_woodallNormal : ¬ puncturedThreeSectorDisc.WoodallNormal univ := by
  intro h
  obtain ⟨n, d, c, hS, -⟩ := h 0 (mem_univ _) puncturedThreeSectorDisc_coloursAt_zero.ge
  exact hS.2.2.2.2.1.2 rfl

end ArcMap

end HadwigerNelson.Plane
