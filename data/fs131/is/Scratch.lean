import Proofs.HadwigerNelson.Plane.ValidMap.Terminal
import Proofs.HadwigerNelson.Plane.StuckChain

/-! FS131-IS1 scratch: the children of `stuckRun_ne_univ`, developed against the built `Terminal` (iteration only, never evidence). -/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## HornShadow's end: N4-SHADOW's two inequalities -/

theorem le_curvDown_of_flankBelow_of_horn (hF : F.Valid) {w : ℂ} {α a a' b' : ℝ} {h : Fin k}
    (hh : F.IsFlankBelow w α a h) (H' : F.IsHorn (w + e (α + π / 2)) α a' b' h) (ha' : -1 < a') (hb' : b' ≤ 1) :
    a ≤ curvDown a' := by
  by_contra hlt
  rw [not_le] at hlt
  obtain ⟨κ', hκ', hev⟩ := hh
  -- a radius at which the horn at `N` lies in its colour's class
  obtain ⟨r₁, hr₁, hr₁0, hr₁2⟩ : ∃ r₁, hornSet (w + e (α + π / 2)) α a' b' r₁ ⊆ F.region h ∧ 0 < r₁ ∧ r₁ ≤ 1 / 2 := by
    obtain ⟨r, hr, hr0⟩ :=
      (H'.eventually_subset_region.and (Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 2 by norm_num))).exists
    exact ⟨r, hr, hr0.1, hr0.2⟩
  obtain ⟨ρ, hρ, Hsh⟩ := mem_shadow_hornSet_S (v := w + e (α + π / 2)) (α := α) ha' H'.1 hb' hr₁0 hr₁2
  rw [add_sub_cancel_right] at Hsh
  -- a radius below `ρ` at which the flank's band lies in its colour's class
  obtain ⟨r₂, hr₂, hr₂0, hr₂ρ⟩ : ∃ r₂, hornSet w α κ' a r₂ ⊆ F.region h ∧ 0 < r₂ ∧ r₂ ≤ ρ := by
    obtain ⟨r, hr, hr0⟩ := (hev.and (Ioc_mem_nhdsGT hρ)).exists
    exact ⟨r, hr, hr0.1, hr0.2⟩
  have hs1 : κ' ≤ max κ' (curvDown a') := le_max_left _ _
  have hs2 : curvDown a' ≤ max κ' (curvDown a') := le_max_right _ _
  have hsa : max κ' (curvDown a') < a := max_lt hκ' hlt
  obtain ⟨y, hy, hyA, -⟩ := exists_mem_hornSet_aboveBelow w α (κ₁ := max κ' (curvDown a')) (κ₂ := a)
    (s := (max κ' (curvDown a') + a) / 2) (m := curvDown a') hr₂0 (by linarith) (by linarith) (by intro h0; linarith)
  have hyT : TanAbove w α (curvDown a') y := hyA (by linarith)
  have hyR : y ∈ F.region h := hr₂ (hornSet_mono hs1 le_rfl hy)
  obtain ⟨z, hz, hyz⟩ := Hsh y (lt_of_lt_of_le hy.1 hr₂ρ) (by rw [frameX_base_N]; exact hy.2.1) hyT
  have hzR : z ∈ F.region h := hr₁ hz
  have hcy : F.col y = h := hyR.2
  have hcz : F.col z = h := hzR.2
  exact hF y hyR.1 z hzR.1 hyz (hcy.trans hcz.symm)

theorem curvUp_le_of_horn_of_flankAbove (hF : F.Valid) {w : ℂ} {α a b b' : ℝ} {g : Fin k}
    (H : F.IsHorn w α a b g) (hg : F.IsFlankAbove (w + e (α + π / 2)) α b' g) (ha : -1 ≤ a) (hb : b < 1) :
    curvUp b ≤ b' := by
  by_contra hlt
  rw [not_le] at hlt
  obtain ⟨κ', hκ', hev⟩ := hg
  obtain ⟨r₁, hr₁, hr₁0, hr₁2⟩ : ∃ r₁, hornSet w α a b r₁ ⊆ F.region g ∧ 0 < r₁ ∧ r₁ ≤ 1 / 2 := by
    obtain ⟨r, hr, hr0⟩ :=
      (H.eventually_subset_region.and (Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 2 by norm_num))).exists
    exact ⟨r, hr, hr0.1, hr0.2⟩
  obtain ⟨ρ, hρ, Hsh⟩ := mem_shadow_hornSet_N (v := w) (α := α) ha H.1 hb hr₁0 hr₁2
  obtain ⟨r₂, hr₂, hr₂0, hr₂ρ⟩ :
      ∃ r₂, hornSet (w + e (α + π / 2)) α b' κ' r₂ ⊆ F.region g ∧ 0 < r₂ ∧ r₂ ≤ ρ := by
    obtain ⟨r, hr, hr0⟩ := (hev.and (Ioc_mem_nhdsGT hρ)).exists
    exact ⟨r, hr, hr0.1, hr0.2⟩
  have hs1 : min κ' (curvUp b) ≤ κ' := min_le_left _ _
  have hs2 : min κ' (curvUp b) ≤ curvUp b := min_le_right _ _
  have hsb : b' < min κ' (curvUp b) := lt_min hκ' hlt
  obtain ⟨y, hy, -, hyB⟩ := exists_mem_hornSet_aboveBelow (w + e (α + π / 2)) α (κ₁ := b') (κ₂ := min κ' (curvUp b))
    (s := (b' + min κ' (curvUp b)) / 2) (m := curvUp b) hr₂0 (by linarith) (by linarith) (by intro h0; linarith)
  have hyT : TanBelow (w + e (α + π / 2)) α (curvUp b) y := hyB (by linarith)
  have hyR : y ∈ F.region g := hr₂ (hornSet_mono le_rfl hs1 hy)
  obtain ⟨z, hz, hyz⟩ := Hsh y (lt_of_lt_of_le hy.1 hr₂ρ) (by rw [← frameX_base_N]; exact hy.2.1) hyT
  have hzR : z ∈ F.region g := hr₁ hz
  have hcy : F.col y = g := hyR.2
  have hcz : F.col z = g := hzR.2
  exact hF y hyR.1 z hzR.1 hyz (hcy.trans hcz.symm)

/-! ## Terminal: the chain's colours and bounds -/

theorem horn_colour_eq_of_isChainVertex (hF : F.Valid) {w : ℂ} (hv : F.Covers w 1) (hw : F.IsChainVertex w)
    {β a b β' a' b' : ℝ} {d d' : Fin k} (H : F.IsHorn w β a b d) (H' : F.IsHorn w β' a' b' d') : d = d' := by
  obtain ⟨hst, h3⟩ := hw
  obtain ⟨c, m, hm, hc⟩ := hst.2.2.2
  obtain ⟨α₀, κ₁, κ₂, κ₃, κ₄, g, h, Hu, Hd, -, -, -, -, -, hdeg, -⟩ := stuck_structure_ua hF hv hst h3 hm hc
  have hwd : w ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  obtain ⟨X⟩ := exists_near hwd
  have hn4 : X.n = 4 := by
    obtain ⟨r, h1, h2⟩ := (hdeg.and X.hC.hasDegree).exists
    rw [h1] at h2
    have : (4 : ℕ) = max X.n 1 := by exact_mod_cast h2
    omega
  obtain ⟨iu, hβu, hnβu, -, -, hcu, -⟩ := X.horn_index Hu
  obtain ⟨ip, hβp, hnβp, -, -, hcp, -⟩ := X.horn_index Hd
  classical
  let P : Fin X.n → Bool := fun j => decide (e (X.G.β j) = e α₀)
  have hnext : ∀ j, X.G.nextβ j = X.G.β j → e (X.G.β (BranchGerms.next j)) = e (X.G.β j) := fun j hj => by
    rw [← BranchGerms.e_nextβ, hj]
  have hpne : e (α₀ + π) ≠ e α₀ := e_add_pi_ne α₀
  have hPu : P iu = true := by simp [P, hβu]
  have hPu' : P (BranchGerms.next iu) = true := by simp [P, hnext iu hnβu, hβu]
  have hPp : P ip = false := by simp [P, hβp, hpne]
  have hPp' : P (BranchGerms.next ip) = false := by simp [P, hnext ip hnβp, hβp, hpne]
  -- every horn's colour is `c`
  have key : ∀ {γ p q : ℝ} {j : Fin k}, F.IsHorn w γ p q j → j = c := by
    intro γ p q j Hj
    obtain ⟨i, -, hnβi, -, -, hci, -⟩ := X.horn_index Hj
    have hPi : P (BranchGerms.next i) = P i := by simp [P, hnext i hnβi]
    rcases BranchGerms.horn_cases_four hn4 P iu ip i hPu hPu' hPp hPp' hPi with rfl | rfl
    · exact hci.symm.trans hcu
    · exact hci.symm.trans hcp
  exact (key H).trans (key H').symm

theorem eq_horn_colour_of_two_sectors (hF : F.Valid) {w : ℂ} (hv : F.Covers w 1) (hw : F.IsChainVertex w)
    {β a b : ℝ} {d j : Fin k} (H : F.IsHorn w β a b d)
    (h2 : ∀ᶠ r in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf w r j).encard) : j = d := by
  have hwd : w ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  obtain ⟨m, hm⟩ := exists_hasSectors hwd j
  have hm2 : 2 ≤ m := by
    obtain ⟨r, hr1, hr2⟩ := (hm.and h2).exists
    have : (2 : ℕ∞) ≤ m := hr1 ▸ hr2
    exact_mod_cast this
  obtain ⟨β', μ₁, μ₂, μ₃, μ₄, Hu, -⟩ := stuck_horns_ua hF hv hw.1 hm2 hm
  exact horn_colour_eq_of_isChainVertex hF hv hw Hu H

theorem horn_upper_ne_one (hM : F.IsTerminalMap) {w : ℂ} {β : ℝ} (hw : F.IsChainVertex w)
    (hN : F.IsChainVertex (w + e (β + π / 2))) {a b : ℝ} {d : Fin k} (H : F.IsHorn w β a b d) : b ≠ 1 := by
  rintro rfl
  obtain ⟨θ₂, hθ, hQR⟩ := (hornBoundsQR_of_isChainVertex hM hw β).1 a d H
  have hR : ∃ c c', F.IsRingArc (w + e (β + π / 2)) (β - π / 2) θ₂ c c' := by
    rcases hQR with ⟨c, c', hR, -⟩ | ⟨c, c', hR, -⟩ <;> exact ⟨c, c', hR⟩
  obtain ⟨c, c', hR⟩ := hR
  exact (cv_l0 hM hN.1 hN.2).1 (ringPt (w + e (β + π / 2)) (β - π / 2))
    ⟨β - π / 2, θ₂, hθ, ⟨β - π / 2, ⟨le_rfl, hθ.le⟩, rfl⟩, hR.2.1⟩

theorem horn_lower_ne_neg_one (hM : F.IsTerminalMap) {w : ℂ} {β : ℝ} (hw : F.IsChainVertex w)
    (hS : F.IsChainVertex (w - e (β + π / 2))) {a b : ℝ} {d : Fin k} (H : F.IsHorn w β a b d) : a ≠ -1 := by
  rintro rfl
  obtain ⟨θ₁, hθ, hQR⟩ := (hornBoundsQR_of_isChainVertex hM hw β).2 b d H
  have hR : ∃ c c', F.IsRingArc (w - e (β + π / 2)) θ₁ (β + π / 2) c c' := by
    rcases hQR with ⟨c, c', hR, -⟩ | ⟨c, c', hR, -⟩ <;> exact ⟨c, c', hR⟩
  obtain ⟨c, c', hR⟩ := hR
  exact (cv_l0 hM hS.1 hS.2).1 (ringPt (w - e (β + π / 2)) θ₁)
    ⟨θ₁, β + π / 2, hθ, ⟨θ₁, ⟨le_rfl, hθ.le⟩, rfl⟩, hR.2.1⟩

theorem shadow_recursion {F : ArcMap 6} (hM : F.IsTerminalMap) {w : ℂ} {α : ℝ} (hw : F.IsChainVertex w)
    (hN : F.IsChainVertex (w + e (α + π / 2))) {a b a' b' : ℝ} {d d' : Fin 6} (H : F.IsHorn w α a b d)
    (H' : F.IsHorn (w + e (α + π / 2)) α a' b' d') :
    a ≤ curvDown a' ∧ curvUp b ≤ b' := by
  obtain ⟨hF, hP, -, -⟩ := id hM
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  have hNS : w + e (α + π / 2) - e (α + π / 2) = w := by ring
  -- the structure at `w`
  obtain ⟨hd2, g, h, hg, hh⟩ := horn_flanks_of_isChainVertex hF (hvC w) hw H
  obtain ⟨κ₃, κ₄, Hd, -, -⟩ := exists_horn_add_pi_of_stuck hF (hvC w) hw.1 hd2 H
  obtain ⟨h1, h2⟩ := horn_bounds_of_noMerge hF (hvC w) hw.1.1 le_rfl hd2 H
  obtain ⟨-, -, -, -, -, -, -, -, -, h3w, -, -⟩ := stuck_structure_at_axis hF (hvC w) hw.1 hw.2 le_rfl hd2 H
  -- the structure at `N = w + n`
  obtain ⟨hd2', g', h', hg', hh'⟩ := horn_flanks_of_isChainVertex hF (hvC _) hN H'
  obtain ⟨μ₃, μ₄, Hd', -, -⟩ := exists_horn_add_pi_of_stuck hF (hvC _) hN.1 hd2' H'
  obtain ⟨h1', h2'⟩ := horn_bounds_of_noMerge hF (hvC _) hN.1.1 le_rfl hd2' H'
  obtain ⟨-, -, -, -, -, -, -, -, -, h3N, -, -⟩ := stuck_structure_at_axis hF (hvC _) hN.1 hN.2 le_rfl hd2' H'
  -- no bound `±1` between two chain vertices
  have hb : b ≠ 1 := horn_upper_ne_one hM hw hN H
  have ha' : a' ≠ -1 := horn_lower_ne_neg_one hM hN (by rw [hNS]; exact hw) H'
  -- CV-CLASS at `w` is not the bowtie: the lower flank `h` is carried twice at `N`, so it is the horn's colour there
  have hhd' : h = d' := by
    rcases cv_class hM hw.1 h3w hd2 H Hd hg hh with ⟨hk2, -⟩ | ⟨-, hhN, -, -⟩
    · exact absurd hk2 hb
    · exact eq_horn_colour_of_two_sectors hF (hvC _) hN H' hhN
  -- CV-CLASS at `N` likewise: the upper flank `g'` is carried twice at `N − n = w`, so it is the horn's colour there
  have hg'd : g' = d := by
    rcases cv_class hM hN.1 h3N hd2' H' Hd' hg' hh' with ⟨-, -, hk1, -⟩ | ⟨hgS, -, -, -⟩
    · exact absurd hk1 ha'
    · rw [hNS] at hgS
      exact eq_horn_colour_of_two_sectors hF (hvC w) hw H hgS
  subst hhd' hg'd
  exact ⟨le_curvDown_of_flankBelow_of_horn hF hh H' (lt_of_le_of_ne h1' (Ne.symm ha')) h2',
    curvUp_le_of_horn_of_flankAbove hF H hg' h1 (lt_of_le_of_ne h2 hb)⟩

theorem stuckRun_ne_univ' {F : ArcMap 6} (hM : F.IsTerminalMap) {v : ℂ} {α : ℝ} (hv : F.StuckAlong v α)
    (h3 : (F.coloursAt v).ncard ≤ 3) : F.stuckRun v α ≠ univ := by
  -- the colour count at `v` is not read: on a bi-infinite run `v` is a chain vertex already
  have _ := h3
  intro hU
  obtain ⟨hF, hP, -, -⟩ := id hM
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  have hrun : ∀ j : ℤ, j ∈ F.stuckRun v α := fun j => hU ▸ mem_univ j
  have hcv : ∀ j : ℤ, F.IsChainVertex (v + (j : ℂ) * e (α + π / 2)) := fun j =>
    isChainVertex_of_mem_stuckRun (hrun j)
  -- a horn along `e α` at every vertex of the line
  have hhorn : ∀ j : ℤ, ∃ a b : ℝ, ∃ d : Fin 6, F.IsHorn (v + (j : ℂ) * e (α + π / 2)) α a b d := by
    intro j
    rcases stuckAlong_of_mem_stuckRun hF hP hv (hrun j) with
      ⟨-, c, m, κ₁, κ₂, -, -, hH⟩ | ⟨hst, c, m, κ₁, κ₂, hm, hc, hH⟩
    · exact ⟨κ₁, κ₂, c, hH⟩
    · obtain ⟨-, -, κ₃, κ₄, -, -, -, hH', -⟩ := stuck_structure_at_axis hF (hvC _) hst (hcv j).2 hm hc hH
      exact ⟨κ₃, κ₄, c, hH'.congr (e_add_pi_add_pi α)⟩
  choose l u c H using hhorn
  have hstep : ∀ j : ℤ,
      v + ((j + 1 : ℤ) : ℂ) * e (α + π / 2) = v + (j : ℂ) * e (α + π / 2) + e (α + π / 2) := fun j => by
    push_cast; ring
  have hback : ∀ j : ℤ,
      v + ((j - 1 : ℤ) : ℂ) * e (α + π / 2) = v + (j : ℂ) * e (α + π / 2) - e (α + π / 2) := fun j => by
    push_cast; ring
  -- N4-SHADOW's two inequalities between consecutive vertices
  have hrec : ∀ j : ℤ, l j ≤ curvDown (l (j + 1)) ∧ curvUp (u j) ≤ u (j + 1) := fun j =>
    shadow_recursion hM (hcv j) (by rw [← hstep j]; exact hcv (j + 1)) (H j) (by rw [← hstep j]; exact H (j + 1))
  -- the bounds lie in `[−1, 1]` and are not `±1`
  have hbd : ∀ j : ℤ, -1 < l j ∧ u j < 1 := fun j => by
    obtain ⟨hd2, -⟩ := horn_flanks_of_isChainVertex hF (hvC _) (hcv j) (H j)
    obtain ⟨h1, h2⟩ := horn_bounds_of_noMerge hF (hvC _) (hcv j).1.1 le_rfl hd2 (H j)
    have hl : l j ≠ -1 := horn_lower_ne_neg_one hM (hcv j) (by rw [← hback j]; exact hcv (j - 1)) (H j)
    have hu : u j ≠ 1 := horn_upper_ne_one hM (hcv j) (by rw [← hstep j]; exact hcv (j + 1)) (H j)
    exact ⟨lt_of_le_of_ne h1 (Ne.symm hl), lt_of_le_of_ne h2 hu⟩
  refine n4_fin ⟨l, u, fun k => ⟨(hbd k).1, (H k).1, (hbd k).2, (hrec k).1, ?_⟩⟩
  have := (hrec (k - 1)).2
  rwa [sub_add_cancel] at this

end ArcMap

end HadwigerNelson.Plane

#print axioms HadwigerNelson.Plane.ArcMap.le_curvDown_of_flankBelow_of_horn
#print axioms HadwigerNelson.Plane.ArcMap.curvUp_le_of_horn_of_flankAbove
#print axioms HadwigerNelson.Plane.ArcMap.horn_colour_eq_of_isChainVertex
#print axioms HadwigerNelson.Plane.ArcMap.eq_horn_colour_of_two_sectors
#print axioms HadwigerNelson.Plane.ArcMap.horn_upper_ne_one
#print axioms HadwigerNelson.Plane.ArcMap.horn_lower_ne_neg_one
#print axioms HadwigerNelson.Plane.ArcMap.shadow_recursion
#print axioms HadwigerNelson.Plane.ArcMap.stuckRun_ne_univ'
#print axioms HadwigerNelson.Plane.ArcMap.stuckRun_ne_univ
