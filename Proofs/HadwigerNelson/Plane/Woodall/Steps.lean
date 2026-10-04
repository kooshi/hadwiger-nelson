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

/-- **Woodall's step 5, strict** (`[Woodall1973]` p. 198, repaired): in a valid map of the plane with at most five colours, no sector of angle
`< π/3` lies between two neighbours of distinct colours (at a point of at least three sectors) — the inner arc opposite it, of length
`> 2π/3`, is coloured by the two remaining colours, against `woodall_step4`. -/
theorem step5_lt (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ}
    {c : Fin n → Fin k} (h : F.SectorsAt v n d c) (hn : 3 ≤ n) (i : Fin n) (hang : d i.succ - d i.castSucc < π / 3)
    (hnb : c (finRotate n i) ≠ c ((finRotate n).symm i)) : False := by
  sorry

/-- **Steps 3 and 5 give the normal form, so a merged map does not exist**: in a valid map of the plane with at most five colours whose repeated
colours sit on horns only, every point of three or more sectors has distinct colours (a horn between two neighbours of distinct colours dies
by `step5_lt`; a horn between two of one colour has horns for neighbours, and the chain of horns ends at a sector of positive angle) and every
angle at least `π/3` (`step5_lt`, strict step 5 only); `aeMap6_normal` finishes. Stated with conclusion `False`, not `WoodallNormal`: its domain
is empty (by this very chain), so the intermediate normal-form statement would be vacuous. -/
theorem aeMap6_merged (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) (hM : F.WoodallMerged) : False := by
  sorry

/-! ## Woodall's step 6, and E1-NO45 in place of his steps 7–8 -/

/-- **Woodall's step 6, repaired by Townsend's `π/3` lemma** (`[Woodall1973]` p. 198; `[Townsend1979ms]` Thm 4's Corollary): in a valid map of
the plane with at most five colours, no point has a picture of three sectors of distinct colours, each of angle at least `π/3`. The three
excluded sets of the sectors' colours leave two colours around `ω(v)`; collars exist about every angle except the edges' normals; at each edge one
normal carries a collar by the refined second-order lemma (`SectorsAt.exists_normal_collarAt`), so at most three cut angles; some one-sided arc
exceeds `π/3` (a sector of angle `< 2π/3`, or, all three `2π/3`, a certified normal). -/
theorem step6 (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {d : Fin 4 → ℝ} {c : Fin 3 → Fin k}
    (h : F.SectorsAt v 3 d c) (hc : Function.Injective c) (hang : ∀ i : Fin 3, π / 3 ≤ d i.succ - d i.castSucc) : False := by
  sorry

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
