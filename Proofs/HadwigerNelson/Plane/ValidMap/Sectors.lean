import Proofs.HadwigerNelson.Plane.ValidMap.Basic
import Mathlib.Analysis.Convex.GaugeRescale
import Mathlib.Analysis.Complex.Convex

/-!
# The bridge from wave 3's sector charts to wave 4's sectors

Wave 3's `localSectors` gives every point `v` of a map's domain a sector chart `F.IsSectorChart G v r₀`: sorted branch germs whose
sectors, for every `r ≤ r₀`, are the interior points of `B(v, r)` cut along the germs' branches (the whole ball when there is no
germ). Wave 4 reads sectors as connected components (`ArcMap.IsSector`) and horns as `hornSet`. This module identifies the two:

* `IsSectorChart.isSector_iff` — at every radius `r ∈ (0, r₀]` the sectors of `F` at `v` are exactly the chart's sectors (the ball when
  there is no germ);
* `IsSectorChart.hasDegree` — so `v` has degree `max n 1`, constant in `r` (inventory item 136, "the number of sectors is constant");
* `sector_eq_hornSet` — a chart sector between two germs of one direction is the `hornSet` of their curvatures, and otherwise its cone
  `angleIcc (β i) (nextβ i)` is a non-degenerate interval (item 136's dichotomy: `IsSectorChart.isSector_cone_or_horn`);
* `exists_hasDegree_of_chart` — every colour at `v` is a sector's colour, so `v` carries at most `max n 1` colours.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- **The connected component in a disjoint union of open connected pieces is the piece**: if `U` is the union of the open,
preconnected, pairwise disjoint sets `A i` and `x ∈ A i`, then the connected component of `x` in `U` is `A i`. -/
theorem connectedComponentIn_eq_of_iUnion {ι : Type*} {A : ι → Set ℂ} {U : Set ℂ} (hU : U = ⋃ i, A i)
    (hopen : ∀ i, IsOpen (A i)) (hpre : ∀ i, IsPreconnected (A i)) (hdisj : ∀ i j, i ≠ j → Disjoint (A i) (A j))
    {i : ι} {x : ℂ} (hx : x ∈ A i) : connectedComponentIn U x = A i := by
  have hAU : A i ⊆ U := hU ▸ subset_iUnion A i
  refine Subset.antisymm ?_ ((hpre i).subset_connectedComponentIn hx hAU)
  have hxC : x ∈ connectedComponentIn U x := mem_connectedComponentIn (hAU hx)
  refine isPreconnected_connectedComponentIn.subset_left_of_subset_union (hopen i)
    (isOpen_iUnion fun j => isOpen_iUnion fun _ : j ≠ i => hopen j) ?_ ?_ ⟨x, hxC, hx⟩
  · rw [Set.disjoint_iUnion_right]
    intro j
    rw [Set.disjoint_iUnion_right]
    intro hj
    exact hdisj i j (Ne.symm hj)
  · intro z hz
    have hzU : z ∈ U := connectedComponentIn_subset _ _ hz
    rw [hU] at hzU
    obtain ⟨j, hj⟩ := mem_iUnion.mp hzU
    by_cases hji : j = i
    · left; rw [← hji]; exact hj
    · right; exact mem_iUnion.mpr ⟨j, mem_iUnion.mpr ⟨hji, hj⟩⟩

/-! ## A sector between two germs of one direction is a horn -/

/-- The frame coordinates of a polar point: `v + s e(φ)` sits at `(s cos(φ − α), s sin(φ − α))` in the frame along `e α`. -/
theorem frame_polar (v : ℂ) (α s φ : ℝ) :
    frameX v α (v + (s : ℂ) * e φ) = s * Real.cos (φ - α) ∧ frameY v α (v + (s : ℂ) * e φ) = s * Real.sin (φ - α) := by
  have h : (v + (s : ℂ) * e φ - v) * starRingEnd ℂ (e α) = (s : ℂ) * e (φ - α) := by
    rw [add_sub_cancel_left, conj_e, mul_assoc, ← e_add, sub_eq_add_neg]
  unfold frameX frameY
  rw [h, Complex.re_ofReal_mul, Complex.im_ofReal_mul, re_e, im_e]
  exact ⟨rfl, rfl⟩

/-- The height of a polar point above the tangent circle of curvature `κ`: `s (sin(φ − α) − κ s / 2)`. -/
theorem tanHeight_polar (v : ℂ) (α κ s φ : ℝ) :
    tanHeight κ (frameX v α (v + (s : ℂ) * e φ)) (frameY v α (v + (s : ℂ) * e φ)) =
      s * (Real.sin (φ - α) - κ * s / 2) := by
  obtain ⟨hx, hy⟩ := frame_polar v α s φ
  rw [hx, hy, tanHeight]
  linear_combination (-(κ * s ^ 2 / 2)) * Real.sin_sq_add_cos_sq (φ - α)

/-- `κ s / 2 ∈ [−1, 1]` for `0 ≤ s ≤ r` when `|κ| r ≤ 2`. -/
theorem half_curv_mem_Icc {κ r s : ℝ} (hκ : |κ| * r ≤ 2) (hs0 : 0 ≤ s) (hsr : s ≤ r) : κ * s / 2 ∈ Icc (-1 : ℝ) 1 := by
  have h : |κ * s / 2| ≤ 1 := by
    rw [abs_div, abs_mul, abs_of_nonneg hs0, abs_two]
    have := mul_le_mul_of_nonneg_left hsr (abs_nonneg κ)
    rw [div_le_one two_pos]; linarith
  exact abs_le.mp h

/-- **The sector between two germs of one direction is the horn of their curvatures** (`|κᵢ| r ≤ 2`, so each germ is a graph over the
radius): `{v + s e(φ) : 0 < s < r, β + arcsin(κ₁ s/2) < φ < β + arcsin(κ₂ s/2)} = hornSet v β κ₁ κ₂ r`. -/
theorem sectorBetween_eq_hornSet (v : ℂ) (β κ₁ κ₂ r : ℝ) (h1 : |κ₁| * r ≤ 2) (h2 : |κ₂| * r ≤ 2) :
    sectorBetween v β κ₁ β κ₂ r = hornSet v β κ₁ κ₂ r := by
  have hπ := Real.pi_pos
  ext z
  constructor
  · rintro ⟨s, ⟨hs0, hsr⟩, φ, ⟨hφ1, hφ2⟩, rfl⟩
    have ha1 := half_curv_mem_Icc h1 hs0.le hsr.le
    have ha2 := half_curv_mem_Icc h2 hs0.le hsr.le
    have hψ1 : Real.arcsin (κ₁ * s / 2) < φ - β := by linarith
    have hψ2 : φ - β < Real.arcsin (κ₂ * s / 2) := by linarith
    have hlo : -(π / 2) < φ - β := lt_of_le_of_lt (Real.neg_pi_div_two_le_arcsin _) hψ1
    have hhi : φ - β < π / 2 := lt_of_lt_of_le hψ2 (Real.arcsin_le_pi_div_two _)
    refine ⟨?_, ?_, ?_, ?_⟩
    · rw [dist_eq_norm, add_sub_cancel_left, norm_mul_e hs0.le]; exact hsr
    · rw [(frame_polar v β s φ).1]; exact mul_pos hs0 (Real.cos_pos_of_mem_Ioo ⟨hlo, hhi⟩)
    · show 0 < tanHeight _ _ _
      rw [tanHeight_polar]
      have := (Real.arcsin_lt_iff_lt_sin ha1 ⟨hlo.le, hhi.le⟩).mp hψ1
      exact mul_pos hs0 (by linarith)
    · show tanHeight _ _ _ < 0
      rw [tanHeight_polar]
      have := (Real.lt_arcsin_iff_sin_lt ⟨hlo.le, hhi.le⟩ ha2).mp hψ2
      exact mul_neg_of_pos_of_neg hs0 (by linarith)
  · rintro ⟨hd, hx, hA, hB⟩
    set w := (z - v) * starRingEnd ℂ (e β) with hw
    have hwre : 0 < w.re := hx
    have hw0 : w ≠ 0 := fun h => by rw [h, Complex.zero_re] at hwre; exact lt_irrefl 0 hwre
    have hnw : ‖w‖ = ‖z - v‖ := by rw [hw, norm_mul, Complex.norm_conj, norm_e, mul_one]
    set s := ‖z - v‖ with hs
    have hs0 : 0 < s := by rw [← hnw]; exact norm_pos_iff.mpr hw0
    have hsr : s < r := by rw [hs, ← dist_eq_norm]; exact hd
    set ψ := Complex.arg w with hψ
    have hψb : |ψ| < π / 2 := Complex.abs_arg_lt_pi_div_two_iff.mpr (Or.inl hwre)
    have hlo : -(π / 2) < ψ := (abs_lt.mp hψb).1
    have hhi : ψ < π / 2 := (abs_lt.mp hψb).2
    have hzpol : z = v + (s : ℂ) * e (β + ψ) := by
      have h1 : w = (s : ℂ) * e ψ := by rw [← hnw]; exact eq_polar_arg w
      have h2 : z - v = w * e β := by
        rw [hw, mul_assoc, mul_comm (starRingEnd ℂ (e β)), e_mul_conj_e, mul_one]
      rw [e_add, ← mul_assoc, mul_comm (s : ℂ) (e β), mul_assoc, ← h1, mul_comm, ← h2]; ring
    have ha1 := half_curv_mem_Icc h1 hs0.le hsr.le
    have ha2 := half_curv_mem_Icc h2 hs0.le hsr.le
    have hA' : 0 < s * (Real.sin ψ - κ₁ * s / 2) := by
      have := hA; unfold TanAbove at this; rw [hzpol, tanHeight_polar, add_sub_cancel_left] at this; exact this
    have hB' : s * (Real.sin ψ - κ₂ * s / 2) < 0 := by
      have := hB; unfold TanBelow at this; rw [hzpol, tanHeight_polar, add_sub_cancel_left] at this; exact this
    have hsin1 : κ₁ * s / 2 < Real.sin ψ := by
      have := (pos_iff_pos_of_mul_pos hA').mp hs0; linarith
    have hsin2 : Real.sin ψ < κ₂ * s / 2 := by
      have := (neg_of_mul_neg_right hB' hs0.le); linarith
    refine ⟨s, ⟨hs0, hsr⟩, β + ψ, ⟨?_, ?_⟩, hzpol⟩
    · have := (Real.arcsin_lt_iff_lt_sin ha1 ⟨hlo.le, hhi.le⟩).mpr hsin1; linarith
    · have := (Real.lt_arcsin_iff_sin_lt ⟨hlo.le, hhi.le⟩ ha2).mpr hsin2; linarith

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- The chart's base point lies in the closure of each of its sectors (the sector's cone holds its first germ's direction). -/
theorem IsSectorChart.mem_closure_sector {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    {r : ℝ} (hr : r ∈ Ioc 0 r₀) (i : Fin n) : v ∈ closure (G.sector v r i) := by
  have hβ : G.β i ∈ coneAt (G.sector v r i) v := by
    rw [hC.cone r hr i]; exact Icc_subset_angleIcc _ _ ⟨le_rfl, hC.sorted.mono i⟩
  exact mem_closure_of_mem_coneAt hβ

/-- **Sectors from a partition**: if the interior points of `B(v, r)` are the union of open, preconnected, pairwise disjoint, non-empty sets
`A i`, each with `v` in its closure, the sectors of `F` at `v` at radius `r` are exactly the `A i`. -/
theorem isSector_iff_of_partition {ι : Type*} {A : ι → Set ℂ} {v : ℂ} {r : ℝ}
    (hU : F.interiorPts ∩ ball v r = ⋃ i, A i) (hopen : ∀ i, IsOpen (A i)) (hpre : ∀ i, IsPreconnected (A i))
    (hdisj : ∀ i j, i ≠ j → Disjoint (A i) (A j)) (hne : ∀ i, (A i).Nonempty) (hcl : ∀ i, v ∈ closure (A i))
    {S : Set ℂ} : F.IsSector v r S ↔ ∃ i, S = A i := by
  have hcomp : ∀ i, ∀ x ∈ A i, connectedComponentIn (F.interiorPts ∩ ball v r) x = A i :=
    fun i x hx => connectedComponentIn_eq_of_iUnion hU hopen hpre hdisj hx
  constructor
  · rintro ⟨x, hx, rfl, -⟩
    rw [hU] at hx
    obtain ⟨i, hi⟩ := mem_iUnion.mp hx
    exact ⟨i, hcomp i x hi⟩
  · rintro ⟨i, rfl⟩
    obtain ⟨x, hx⟩ := hne i
    refine ⟨x, ?_, (hcomp i x hx).symm, hcl i⟩
    rw [hU]; exact mem_iUnion.mpr ⟨i, hx⟩

/-- Pairwise disjoint non-empty sets are distinct. -/
theorem injective_of_disjoint {ι : Type*} {A : ι → Set ℂ} (hdisj : ∀ i j, i ≠ j → Disjoint (A i) (A j))
    (hne : ∀ i, (A i).Nonempty) : Function.Injective A := by
  intro i j hij
  by_contra h
  obtain ⟨x, hx⟩ := hne i
  exact disjoint_left.mp (hdisj i j h) hx (hij ▸ hx)

/-- **The number of sectors from a partition into `n` pieces** is `n`. -/
theorem encard_sectors_of_partition {n : ℕ} {A : Fin n → Set ℂ} {v : ℂ} {r : ℝ}
    (hU : F.interiorPts ∩ ball v r = ⋃ i, A i) (hopen : ∀ i, IsOpen (A i)) (hpre : ∀ i, IsPreconnected (A i))
    (hdisj : ∀ i j, i ≠ j → Disjoint (A i) (A j)) (hne : ∀ i, (A i).Nonempty) (hcl : ∀ i, v ∈ closure (A i)) :
    {S | F.IsSector v r S}.encard = n := by
  have : {S | F.IsSector v r S} = range A := by
    ext S; simp only [mem_setOf_eq, mem_range]
    rw [isSector_iff_of_partition hU hopen hpre hdisj hne hcl]
    exact ⟨fun ⟨i, h⟩ => ⟨i, h.symm⟩, fun ⟨i, h⟩ => ⟨i, h.symm⟩⟩
  rw [this, ← image_univ, (injective_of_disjoint hdisj hne).encard_image, encard_univ, ENat.card_eq_coe_fintype_card,
    Fintype.card_fin]

/-- **The sectors of `F` at `v` are the chart's sectors** (a chart with at least one germ): for `r ∈ (0, r₀]`, a set is a sector of
`F` at `v` at radius `r` exactly when it is one of the `n` sectors between consecutive germs. -/
theorem IsSectorChart.isSector_iff {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀) (hn : 0 < n)
    {r : ℝ} (hr : r ∈ Ioc 0 r₀) {S : Set ℂ} : F.IsSector v r S ↔ ∃ i, S = G.sector v r i :=
  isSector_iff_of_partition (by rw [inter_comm]; exact hC.cover r hr hn) (hC.isOpen r hr) (hC.isPreconnected r hr)
    (hC.disjoint r hr) (hC.sector_nonempty hr) (hC.mem_closure_sector hr)

/-- **With no germ, the one sector is the ball**: for `r ∈ (0, r₀]`, the sectors of `F` at `v` at radius `r` are `{B(v, r)}`. -/
theorem IsSectorChart.isSector_iff_of_zero {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    (hn : n = 0) {r : ℝ} (hr : r ∈ Ioc 0 r₀) {S : Set ℂ} : F.IsSector v r S ↔ S = ball v r := by
  have hball : ball v r ⊆ F.interiorPts := (ball_subset_ball hr.2).trans (hC.empty hn)
  have hU : F.interiorPts ∩ ball v r = ball v r := inter_eq_right.mpr hball
  have hcomp : ∀ x ∈ ball v r, connectedComponentIn (F.interiorPts ∩ ball v r) x = ball v r := by
    intro x hx
    rw [hU]
    exact Subset.antisymm (connectedComponentIn_subset _ _)
      ((convex_ball v r).isPreconnected.subset_connectedComponentIn hx le_rfl)
  have hv : v ∈ ball v r := mem_ball_self hr.1
  constructor
  · rintro ⟨x, hx, rfl, -⟩
    rw [hU] at hx
    exact hcomp x hx
  · rintro rfl
    exact ⟨v, by rw [hU]; exact hv, (hcomp v hv).symm, subset_closure hv⟩

/-- **The number of sectors at radius `r ∈ (0, r₀]`** is `max n 1`, whatever `r`. -/
theorem IsSectorChart.encard_sectors {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    {r : ℝ} (hr : r ∈ Ioc 0 r₀) : {S | F.IsSector v r S}.encard = (max n 1 : ℕ) := by
  rcases Nat.eq_zero_or_pos n with hn | hn
  · have : {S | F.IsSector v r S} = {ball v r} := by
      ext S; simp only [mem_setOf_eq, mem_singleton_iff]; exact hC.isSector_iff_of_zero hn hr
    rw [this, encard_singleton, hn]; rfl
  · rw [max_eq_left hn]
    exact encard_sectors_of_partition (by rw [inter_comm]; exact hC.cover r hr hn) (hC.isOpen r hr)
      (hC.isPreconnected r hr) (hC.disjoint r hr) (hC.sector_nonempty hr) (hC.mem_closure_sector hr)

/-- **The degree of the chart's point** is `max n 1` (the number of sectors is constant for `r ≤ r₀`; inventory item 136). -/
theorem IsSectorChart.hasDegree {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀) :
    F.HasDegree v (max n 1) := by
  filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
  exact hC.encard_sectors hr

/-- **Every colour at the chart's point is a sector's colour**: `v` carries at most `max n 1` colours. -/
theorem IsSectorChart.ncard_coloursAt_le {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀) :
    (F.coloursAt v).ncard ≤ max n 1 := by
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  -- a colour at `v` is the colour of a point of `B(v, r₀)` interior to the map
  have hcol : ∀ j ∈ F.coloursAt v, ∃ z ∈ F.interiorPts ∩ ball v r₀, F.col z = j := by
    intro j hj
    obtain ⟨z, hz, hzd⟩ := Metric.mem_closure_iff.mp hj r₀ hC.pos
    exact ⟨z, ⟨hz.1, by rw [mem_ball, dist_comm]; exact hzd⟩, hz.2⟩
  rcases Nat.eq_zero_or_pos n with hn | hn
  · -- the ball is interior and connected: one colour
    have hball : ball v r₀ ⊆ F.interiorPts := hC.empty hn
    have hsub : F.coloursAt v ⊆ {F.col v} := by
      intro j hj
      obtain ⟨z, hz, rfl⟩ := hcol j hj
      exact (convex_ball v r₀).isPreconnected.constant (F.continuousOn_col.mono hball) hz.2 (mem_ball_self hC.pos)
    calc (F.coloursAt v).ncard ≤ ({F.col v} : Set (Fin k)).ncard := ncard_le_ncard hsub
      _ = 1 := ncard_singleton _
      _ ≤ max n 1 := le_max_right _ _
  · -- each colour is the colour of a chosen point of some sector
    choose p hp using fun i => hC.sector_nonempty hr₀ i
    have hsub : F.coloursAt v ⊆ range (F.col ∘ p) := by
      intro j hj
      obtain ⟨z, hz, rfl⟩ := hcol j hj
      have hz' : z ∈ ⋃ i, G.sector v r₀ i := by rw [← hC.cover r₀ hr₀ hn]; exact ⟨hz.2, hz.1⟩
      obtain ⟨i, hi⟩ := mem_iUnion.mp hz'
      refine ⟨i, ?_⟩
      exact ((hC.isPreconnected r₀ hr₀ i).constant (F.continuousOn_col.mono (hC.sector_subset_interiorPts hn hr₀ i))
        (hp i) hi)
    calc (F.coloursAt v).ncard ≤ (range (F.col ∘ p)).ncard := ncard_le_ncard hsub
      _ ≤ Nat.card (Fin n) := by
          rw [← image_univ]
          exact (ncard_image_le (Set.toFinite _)).trans (by rw [ncard_univ])
      _ = n := Nat.card_eq_fintype_card.trans (Fintype.card_fin n)
      _ ≤ max n 1 := le_max_left _ _

/-- **Every point of the domain has a degree, at least its number of colours** (from `localSectors`). -/
theorem exists_hasDegree_of_chart {x : ℂ} (hx : x ∈ F.dom) : ∃ n, (F.coloursAt x).ncard ≤ n ∧ F.HasDegree x n := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hx
  exact ⟨max n 1, hC.ncard_coloursAt_le, hC.hasDegree⟩

/-- A ball's cone at its centre holds every direction. -/
theorem coneAt_ball_self (v : ℂ) {r : ℝ} (hr : 0 < r) : coneAt (ball v r) v = univ := by
  refine eq_univ_of_forall fun δ => BranchGerms.mem_coneAt_of_ray fun ε hε => ⟨min ε r / 2, ⟨by positivity, ?_⟩, ?_⟩
  · linarith [min_le_left ε r]
  · rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_mul_e (by positivity)]
    linarith [min_le_right ε r, lt_min hε hr]

/-- The germ after `i` is a graph over the radius too: `|nextκ i| r₀ < 2`. -/
theorem IsSectorChart.curv_next {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀) (i : Fin n) :
    |G.nextκ i| * r₀ < 2 := by
  unfold BranchGerms.nextκ
  split_ifs <;> exact hC.curv _

/-- **Item 136's dichotomy**: for `r ∈ (0, r₀]` every sector of `F` at `v` either has a cone with non-empty interior, or is the horn
`hornSet v β κ₁ κ₂ r` between two germs of one direction `β`, with `κ₁ < κ₂`. -/
theorem IsSectorChart.isSector_cone_or_horn {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    {r : ℝ} (hr : r ∈ Ioc 0 r₀) {S : Set ℂ} (hS : F.IsSector v r S) :
    (interior (coneAt S v)).Nonempty ∨ ∃ β κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v β κ₁ κ₂ r := by
  rcases Nat.eq_zero_or_pos n with hn | hn
  · left
    rw [(hC.isSector_iff_of_zero hn hr).mp hS, coneAt_ball_self v hr.1, interior_univ]
    exact univ_nonempty
  · obtain ⟨i, rfl⟩ := (hC.isSector_iff hn hr).mp hS
    rcases hC.sorted.2 i with hlt | ⟨heq, hκ⟩
    · left
      rw [hC.cone r hr i]
      refine ⟨(G.β i + G.nextβ i) / 2, mem_interior.mpr ⟨Ioo (G.β i) (G.nextβ i),
        Ioo_subset_Icc_self.trans (Icc_subset_angleIcc _ _), isOpen_Ioo, ⟨by linarith, by linarith⟩⟩⟩
    · right
      refine ⟨G.β i, G.κ i, G.nextκ i, hκ, ?_⟩
      have h1 : |G.κ i| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv i).le
      have h2 : |G.nextκ i| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv_next i).le
      show sectorBetween v (G.β i) (G.κ i) (G.nextβ i) (G.nextκ i) r = _
      rw [← heq]
      exact sectorBetween_eq_hornSet v _ _ _ r h1 h2

/-! ## A two-tile simple map: `halfDisc` (FS131-QA2's QA2-3) -/

/-- **An open bounded convex non-empty set is a Jordan domain**: Mathlib's gauge rescaling (`exists_homeomorph_image_interior_closure_
frontier_eq_unitBall`) carries its closure onto the closed unit disc and the set onto the open one. -/
theorem isJordanDomain_of_convex {T : Set ℂ} (hTo : IsOpen T) (hTc : Convex ℝ T) (hTb : Bornology.IsBounded T)
    (hTn : T.Nonempty) : IsJordanDomain T := by
  obtain ⟨h, hint, hcl, -⟩ := exists_homeomorph_image_interior_closure_frontier_eq_unitBall hTc
    (by rw [hTo.interior_eq]; exact hTn) hTb
  rw [hTo.interior_eq] at hint
  have himg : h.symm '' closedBall (0 : ℂ) 1 = closure T := by
    rw [← hcl, ← image_comp, Homeomorph.symm_comp_self, image_id]
  refine ⟨(h.symm.image (closedBall (0 : ℂ) 1)).trans (Homeomorph.setCongr himg), fun z => ?_⟩
  show h.symm (z : ℂ) ∈ T ↔ (z : ℂ) ∈ ball (0 : ℂ) 1
  rw [← hint]
  constructor
  · intro hz; exact ⟨_, hz, h.apply_symm_apply _⟩
  · rintro ⟨y, hy, hyz⟩
    rw [← hyz, h.symm_apply_apply]; exact hy

/-- The upper half of `halfDisc`'s disc (colour `1`). -/
def halfDiscUpper : Set ℂ := ball 0 (1 / 3) ∩ {z | 0 < z.im}

/-- The lower half of `halfDisc`'s disc (colour `0`). -/
def halfDiscLower : Set ℂ := ball 0 (1 / 3) ∩ {z | z.im < 0}

theorem isOpen_halfDiscUpper : IsOpen halfDiscUpper := isOpen_ball.inter (isOpen_lt continuous_const Complex.continuous_im)

theorem isOpen_halfDiscLower : IsOpen halfDiscLower := isOpen_ball.inter (isOpen_lt Complex.continuous_im continuous_const)

theorem convex_halfDiscUpper : Convex ℝ halfDiscUpper :=
  (convex_ball _ _).inter (convex_halfSpace_im_gt 0)

theorem convex_halfDiscLower : Convex ℝ halfDiscLower :=
  (convex_ball _ _).inter (convex_halfSpace_im_lt 0)

/-- `halfDisc`'s two half-discs as one family (`true` upper, `false` lower). -/
def halfDiscPiece (b : Bool) : Set ℂ := if b then halfDiscUpper else halfDiscLower

theorem halfDisc_interiorPts_eq : halfDisc.interiorPts = ⋃ b, halfDiscPiece b := by
  ext z
  rw [halfDisc_mem_interiorPts, mem_iUnion]
  constructor
  · rintro ⟨hz, him⟩
    rcases lt_or_gt_of_ne him with h | h
    · exact ⟨false, mem_ball_zero_iff.mpr hz, h⟩
    · exact ⟨true, mem_ball_zero_iff.mpr hz, h⟩
  · rintro ⟨b, hb⟩
    cases b
    · exact ⟨mem_ball_zero_iff.mp hb.1, ne_of_lt hb.2⟩
    · exact ⟨mem_ball_zero_iff.mp hb.1, ne_of_gt hb.2⟩

theorem isOpen_halfDiscPiece (b : Bool) : IsOpen (halfDiscPiece b) := by
  cases b
  · exact isOpen_halfDiscLower
  · exact isOpen_halfDiscUpper

theorem convex_halfDiscPiece (b : Bool) : Convex ℝ (halfDiscPiece b) := by
  cases b
  · exact convex_halfDiscLower
  · exact convex_halfDiscUpper

theorem disjoint_halfDiscPiece (b b' : Bool) (h : b ≠ b') : Disjoint (halfDiscPiece b) (halfDiscPiece b') := by
  have hUL : Disjoint halfDiscUpper halfDiscLower := disjoint_left.mpr fun z hz hz' => lt_asymm (show 0 < z.im from hz.2) (show z.im < 0 from hz'.2)
  cases b <;> cases b'
  · exact absurd rfl h
  · exact hUL.symm
  · exact hUL
  · exact absurd rfl h

/-- The tile of an interior point of `halfDisc` is its half-disc. -/
theorem halfDisc_component {b : Bool} {x : ℂ} (hx : x ∈ halfDiscPiece b) :
    connectedComponentIn halfDisc.interiorPts x = halfDiscPiece b :=
  connectedComponentIn_eq_of_iUnion halfDisc_interiorPts_eq isOpen_halfDiscPiece
    (fun b => (convex_halfDiscPiece b).isPreconnected) disjoint_halfDiscPiece hx

/-- `halfDisc`'s tiles are its two half-discs. -/
theorem halfDisc_isTile {T : Set ℂ} (hT : halfDisc.IsTile T) : T = halfDiscUpper ∨ T = halfDiscLower := by
  obtain ⟨x, hx, rfl⟩ := hT
  rw [halfDisc_interiorPts_eq] at hx
  obtain ⟨b, hb⟩ := mem_iUnion.mp hx
  rw [halfDisc_component hb]
  cases b
  · right; rfl
  · left; rfl

theorem halfDiscUpper_mem : ((1 / 6 : ℝ) : ℂ) * I ∈ halfDiscUpper := by
  refine ⟨?_, by simp⟩
  rw [mem_ball_zero_iff, norm_mul, Complex.norm_I, mul_one, Complex.norm_real, Real.norm_eq_abs]; norm_num

theorem halfDiscLower_mem : ((-1 / 6 : ℝ) : ℂ) * I ∈ halfDiscLower := by
  refine ⟨?_, by simp; norm_num⟩
  rw [mem_ball_zero_iff, norm_mul, Complex.norm_I, mul_one, Complex.norm_real, Real.norm_eq_abs]; norm_num

/-- Both half-discs are tiles of `halfDisc`, and they are distinct (so `Simple`'s second clause is exercised). -/
theorem halfDisc_two_tiles : halfDisc.IsTile halfDiscUpper ∧ halfDisc.IsTile halfDiscLower ∧ halfDiscUpper ≠ halfDiscLower := by
  have hU : halfDiscUpper = halfDiscPiece true := rfl
  have hL : halfDiscLower = halfDiscPiece false := rfl
  have hmU := halfDiscUpper_mem
  have hmL := halfDiscLower_mem
  refine ⟨⟨_, halfDisc_interiorPts_eq ▸ mem_iUnion.mpr ⟨true, hmU⟩, (halfDisc_component (b := true) hmU).symm⟩,
    ⟨_, halfDisc_interiorPts_eq ▸ mem_iUnion.mpr ⟨false, hmL⟩, (halfDisc_component (b := false) hmL).symm⟩, fun h => ?_⟩
  have := h ▸ hmU
  exact lt_asymm (show 0 < (((1 / 6 : ℝ) : ℂ) * I).im from hmU.2) (show _ < 0 from this.2)

/-- **`halfDisc` is simple** (FS131-QA2's QA2-3, the two-tile model of `Simple`): its tiles are the two open half-discs, each a Jordan
domain, and their closures, both convex, meet in a convex (so preconnected) set — the diameter. -/
theorem halfDisc_simple : halfDisc.Simple := by
  have hbU : Bornology.IsBounded halfDiscUpper := isBounded_ball.subset inter_subset_left
  have hbL : Bornology.IsBounded halfDiscLower := isBounded_ball.subset inter_subset_left
  have hnU : halfDiscUpper.Nonempty := ⟨_, halfDiscUpper_mem⟩
  have hnL : halfDiscLower.Nonempty := ⟨_, halfDiscLower_mem⟩
  refine ⟨fun T hT => ?_, fun T T' hT hT' _ => ?_⟩
  · rcases halfDisc_isTile hT with rfl | rfl
    · exact isJordanDomain_of_convex isOpen_halfDiscUpper convex_halfDiscUpper hbU hnU
    · exact isJordanDomain_of_convex isOpen_halfDiscLower convex_halfDiscLower hbL hnL
  · have hconv : ∀ T, halfDisc.IsTile T → Convex ℝ (closure T) := by
      intro T hT
      rcases halfDisc_isTile hT with rfl | rfl
      · exact convex_halfDiscUpper.closure
      · exact convex_halfDiscLower.closure
    exact ((hconv T hT).inter (hconv T' hT')).isPreconnected

/-! ## A proved horn: the two-colour cusp fragment (FS131-QA2's QA2-4)

On the disc `B(0, 1/2)`, the unit circles about `±i` are the arcs; colour `1` outside both unit discs (two horns at `0`, along `±1`,
each between `ω(−i)` below and `ω(i)` above), colour `0` inside either. The horn along `e 0` is a sector of colour `1` at every small
radius: `cuspFrag_isHorn`, the library's first proved `IsHorn` (bounding curvatures `−1`, `1`, its flanks `0` above and below). -/

/-- The whole unit circle about `c` is the carrier of the arc `circ c 1 0 (2π)`. -/
theorem carrier_circ_full (c : ℂ) : (Arc.circ c 1 0 (2 * π)).carrier = sphere c 1 := by
  ext z
  simp only [Arc.carrier, mem_image, mem_Icc, mem_sphere_iff_norm, ofReal_one, one_mul]
  constructor
  · rintro ⟨θ, -, rfl⟩
    rw [add_sub_cancel_left, norm_e]
  · intro hz
    have hpol : z - c = e (arg (z - c)) := by
      have := eq_polar_arg (z - c)
      rw [hz, ofReal_one, one_mul] at this; exact this
    have hπ := Real.pi_pos
    rcases le_or_gt 0 (arg (z - c)) with h | h
    · exact ⟨arg (z - c), ⟨h, by linarith [Complex.arg_le_pi (z - c)]⟩, by rw [← hpol]; ring⟩
    · refine ⟨arg (z - c) + 2 * π, ⟨by linarith [Complex.neg_pi_lt_arg (z - c)], by linarith⟩, ?_⟩
      rw [e_add_two_pi, ← hpol]; ring

/-- The colour of the cusp fragment: `1` outside both unit discs about `±i`, `0` inside either. -/
noncomputable def cuspCol (z : ℂ) : Fin 2 := by
  classical
  exact if 1 < ‖z - I‖ ∧ 1 < ‖z + I‖ then 1 else 0

/-- `‖z − i‖² + ‖z + i‖² = 2‖z‖² + 2`: the two unit discs about `±i` have disjoint interiors. -/
theorem norm_sub_I_sq_add (z : ℂ) : ‖z - I‖ ^ 2 + ‖z + I‖ ^ 2 = 2 * ‖z‖ ^ 2 + 2 := by
  rw [← Complex.normSq_eq_norm_sq, ← Complex.normSq_eq_norm_sq, ← Complex.normSq_eq_norm_sq]
  simp only [Complex.normSq_apply, Complex.sub_re, Complex.sub_im, Complex.add_re, Complex.add_im, Complex.I_re,
    Complex.I_im]
  ring

/-- The two-colour cusp fragment on `B(0, 1/2)`. -/
noncomputable def cuspFrag : ArcMap 2 where
  dom := ball 0 (1 / 2)
  isOpen_dom := isOpen_ball
  arcs := {Arc.circ I 1 0 (2 * π), Arc.circ (-I) 1 0 (2 * π)}
  nondegenerate := by
    intro a ha
    have hπ := Real.pi_pos
    rcases ha with rfl | rfl <;> exact ⟨one_pos, by linarith, by linarith⟩
  locallyFinite := fun _ _ => ⟨univ, univ_mem, ((finite_singleton _).insert _).subset fun _ ha => ha.1⟩
  col := cuspCol
  locallyConstant := by
    intro x _ hx
    have hx1 : ‖x - I‖ ≠ 1 := fun h => hx (mem_iUnion₂.mpr ⟨_, Or.inl rfl, by
      rw [carrier_circ_full, mem_sphere_iff_norm]; exact h⟩)
    have hx2 : ‖x + I‖ ≠ 1 := fun h => hx (mem_iUnion₂.mpr ⟨_, Or.inr rfl, by
      rw [carrier_circ_full, mem_sphere_iff_norm, sub_neg_eq_add]; exact h⟩)
    have hc1 : Continuous fun z : ℂ => ‖z - I‖ := by fun_prop
    have hc2 : Continuous fun z : ℂ => ‖z + I‖ := by fun_prop
    have e1 : ∀ᶠ z in 𝓝 x, (1 < ‖z - I‖ ↔ 1 < ‖x - I‖) := by
      rcases lt_or_gt_of_ne hx1 with h | h
      · filter_upwards [hc1.continuousAt.eventually_lt continuousAt_const h] with z hz
        exact ⟨fun h' => absurd h' (not_lt.mpr hz.le), fun h' => absurd h' (not_lt.mpr h.le)⟩
      · filter_upwards [continuousAt_const.eventually_lt hc1.continuousAt h] with z hz
        exact ⟨fun _ => h, fun _ => hz⟩
    have e2 : ∀ᶠ z in 𝓝 x, (1 < ‖z + I‖ ↔ 1 < ‖x + I‖) := by
      rcases lt_or_gt_of_ne hx2 with h | h
      · filter_upwards [hc2.continuousAt.eventually_lt continuousAt_const h] with z hz
        exact ⟨fun h' => absurd h' (not_lt.mpr hz.le), fun h' => absurd h' (not_lt.mpr h.le)⟩
      · filter_upwards [continuousAt_const.eventually_lt hc2.continuousAt h] with z hz
        exact ⟨fun _ => h, fun _ => hz⟩
    filter_upwards [e1, e2] with z h1 h2
    simp only [cuspCol, h1, h2]

/-- The interior points of the cusp fragment: the disc off the two unit circles about `±i`. -/
theorem cuspFrag_mem_interiorPts {z : ℂ} : z ∈ cuspFrag.interiorPts ↔ ‖z‖ < 1 / 2 ∧ ‖z - I‖ ≠ 1 ∧ ‖z + I‖ ≠ 1 := by
  have hU : ⋃ a ∈ cuspFrag.arcs, a.carrier = sphere I 1 ∪ sphere (-I) 1 := by
    show ⋃ a ∈ ({Arc.circ I 1 0 (2 * π), Arc.circ (-I) 1 0 (2 * π)} : Set Arc), a.carrier = _
    rw [biUnion_insert, biUnion_singleton, carrier_circ_full, carrier_circ_full]
  rw [ArcMap.interiorPts, hU]
  show z ∈ ball 0 (1 / 2) \ _ ↔ _
  simp only [Set.mem_sdiff, mem_ball_zero_iff, mem_union, mem_sphere_iff_norm, sub_neg_eq_add, not_or]

/-- The cusp fragment is valid: its domain has diameter `1`, so no two of its points are `1` apart. -/
theorem cuspFrag_valid : cuspFrag.Valid := by
  intro x hx y hy hxy
  have hx' := (cuspFrag_mem_interiorPts.mp hx).1
  have hy' := (cuspFrag_mem_interiorPts.mp hy).1
  have := dist_le_norm_add_norm x y
  rw [dist_eq_norm] at hxy
  rw [dist_eq_norm, hxy] at this
  linarith

/-- The horn along `e 0` read off: `‖z‖ < r`, `re z > 0`, outside both unit discs about `±i`. -/
theorem hornSet_cusp_iff (r : ℝ) (z : ℂ) :
    z ∈ hornSet 0 0 (-1) 1 r ↔ ‖z‖ < r ∧ 0 < z.re ∧ 1 < ‖z + I‖ ∧ 1 < ‖z - I‖ := by
  have hfx : frameX 0 0 z = z.re := by simp [frameX, e]
  simp only [hornSet, tanAbove_neg_one_iff, tanBelow_one_iff, dist_eq_norm, zero_sub, sub_neg_eq_add, sub_zero,
    mem_setOf_eq, hfx, zero_add, e_pi_div_two]

theorem isOpen_hornSet_cusp (r : ℝ) : IsOpen (hornSet 0 0 (-1) 1 r) := by
  have : hornSet 0 0 (-1) 1 r = {z : ℂ | ‖z‖ < r} ∩ {z | 0 < z.re} ∩ {z | 1 < ‖z + I‖} ∩ {z | 1 < ‖z - I‖} := by
    ext z; rw [hornSet_cusp_iff]; simp only [mem_inter_iff, mem_setOf_eq, and_assoc]
  rw [this]
  refine (((isOpen_lt (by fun_prop) continuous_const).inter (isOpen_lt continuous_const Complex.continuous_re)).inter
    (isOpen_lt continuous_const (by fun_prop))).inter (isOpen_lt continuous_const (by fun_prop))

/-- The horn along `e 0` is preconnected (it is the sector between the germs `(0, −1)` and `(0, 1)`). -/
theorem isPreconnected_hornSet_cusp {r : ℝ} (hr : r ≤ 1 / 2) : IsPreconnected (hornSet 0 0 (-1) 1 r) := by
  have hπ := Real.pi_pos
  set G : BranchGerms 2 := ⟨![0, 0], ![-1, 1]⟩ with hG
  have hsec : G.sector 0 r 0 = hornSet 0 0 (-1) 1 r := by
    have hb : G.nextβ 0 = 0 := by simp [BranchGerms.nextβ, hG]
    have hk : G.nextκ 0 = 1 := by simp [BranchGerms.nextκ, hG]
    show sectorBetween 0 (G.β 0) (G.κ 0) (G.nextβ 0) (G.nextκ 0) r = _
    rw [hb, hk]
    have h0 : G.β 0 = 0 := rfl
    have h1 : G.κ 0 = -1 := rfl
    rw [h0, h1]
    exact sectorBetween_eq_hornSet 0 0 (-1) 1 r (by rw [abs_neg, abs_one]; linarith) (by rw [abs_one]; linarith)
  rw [← hsec]
  refine G.isPreconnected_sector (r₀ := 1 / 2) (fun s hs i => ?_) hr 0
  have ha : Real.arcsin (s / 2) ≤ π / 2 := Real.arcsin_le_pi_div_two _
  have hpos : 0 < Real.arcsin (s / 2) := Real.arcsin_pos.mpr (by linarith [hs.1])
  fin_cases i
  · show germDir (G.β 0) (G.κ 0) s < germDir (G.nextβ 0) (G.nextκ 0) s
    simp only [germDir, BranchGerms.nextβ, BranchGerms.nextκ, hG]
    norm_num
    rw [neg_div, Real.arcsin_neg]; linarith
  · show germDir (G.β 1) (G.κ 1) s < germDir (G.nextβ 1) (G.nextκ 1) s
    simp only [germDir, BranchGerms.nextβ, BranchGerms.nextκ, hG]
    norm_num
    rw [neg_div, Real.arcsin_neg]; linarith

/-- The cusp fragment's interior points near `0`: the two horns and the two unit discs' parts. -/
noncomputable def cuspPiece (r : ℝ) : Fin 4 → Set ℂ :=
  ![hornSet 0 0 (-1) 1 r, (fun z => -(starRingEnd ℂ z)) '' hornSet 0 0 (-1) 1 r, ball 0 r ∩ ball I 1, ball 0 r ∩ ball (-I) 1]

theorem mem_cuspPiece_one {r : ℝ} {z : ℂ} :
    z ∈ (fun z => -(starRingEnd ℂ z)) '' hornSet 0 0 (-1) 1 r ↔ ‖z‖ < r ∧ z.re < 0 ∧ 1 < ‖z + I‖ ∧ 1 < ‖z - I‖ := by
  have hn : ∀ w : ℂ, ‖-(starRingEnd ℂ w) + I‖ = ‖w + I‖ := by
    intro w; rw [show -(starRingEnd ℂ w) + I = -(starRingEnd ℂ (w + I)) by simp [map_add]; ring, norm_neg, Complex.norm_conj]
  have hn' : ∀ w : ℂ, ‖-(starRingEnd ℂ w) - I‖ = ‖w - I‖ := by
    intro w; rw [show -(starRingEnd ℂ w) - I = -(starRingEnd ℂ (w - I)) by simp [map_sub]; ring, norm_neg,
      Complex.norm_conj]
  constructor
  · rintro ⟨w, hw, rfl⟩
    rw [hornSet_cusp_iff] at hw
    refine ⟨by rw [norm_neg, Complex.norm_conj]; exact hw.1, by simp; exact hw.2.1, by rw [hn]; exact hw.2.2.1,
      by rw [hn']; exact hw.2.2.2⟩
  · rintro ⟨h1, h2, h3, h4⟩
    refine ⟨-(starRingEnd ℂ z), ?_, by simp⟩
    rw [hornSet_cusp_iff]
    refine ⟨by rw [norm_neg, Complex.norm_conj]; exact h1, by simp; linarith, ?_, ?_⟩
    · rw [hn]; exact h3
    · rw [hn']; exact h4

/-- **The partition at the cusp**: for `r ≤ 1/2` the interior points of `B(0, r)` are the two horns and the two discs' parts. -/
theorem cuspFrag_partition {r : ℝ} (hr : r ≤ 1 / 2) : cuspFrag.interiorPts ∩ ball 0 r = ⋃ i, cuspPiece r i := by
  ext z
  rw [mem_inter_iff, cuspFrag_mem_interiorPts, mem_ball_zero_iff, mem_iUnion]
  have hsum := norm_sub_I_sq_add z
  constructor
  · rintro ⟨⟨-, h1, h2⟩, hz⟩
    rcases lt_or_gt_of_ne h1 with h1 | h1
    · exact ⟨2, mem_ball_zero_iff.mpr hz, by rw [mem_ball, dist_eq_norm]; exact h1⟩
    rcases lt_or_gt_of_ne h2 with h2 | h2
    · exact ⟨3, mem_ball_zero_iff.mpr hz, by rw [mem_ball, dist_eq_norm, sub_neg_eq_add]; exact h2⟩
    rcases lt_trichotomy z.re 0 with h | h | h
    · exact ⟨1, mem_cuspPiece_one.mpr ⟨hz, h, h2, h1⟩⟩
    · exfalso
      have e1 : ‖z - I‖ ^ 2 = z.re ^ 2 + (z.im - 1) ^ 2 := by
        rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; simp; ring
      have e2 : ‖z + I‖ ^ 2 = z.re ^ 2 + (z.im + 1) ^ 2 := by
        rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; simp; ring
      have him : |z.im| < 1 / 2 := (Complex.abs_im_le_norm z).trans_lt (hz.trans_le hr)
      have q1 : 1 < ‖z - I‖ ^ 2 := by nlinarith
      have q2 : 1 < ‖z + I‖ ^ 2 := by nlinarith
      rw [e1, h] at q1; rw [e2, h] at q2
      nlinarith [abs_lt.mp him]
    · exact ⟨0, (hornSet_cusp_iff r z).mpr ⟨hz, h, h2, h1⟩⟩
  · rintro ⟨i, hi⟩
    fin_cases i
    · obtain ⟨hz, -, h2, h1⟩ := (hornSet_cusp_iff r z).mp hi
      exact ⟨⟨by linarith, h1.ne', h2.ne'⟩, hz⟩
    · obtain ⟨hz, -, h2, h1⟩ := mem_cuspPiece_one.mp hi
      exact ⟨⟨by linarith, h1.ne', h2.ne'⟩, hz⟩
    · obtain ⟨hz, h1⟩ := hi
      rw [mem_ball_zero_iff] at hz; rw [mem_ball, dist_eq_norm] at h1
      refine ⟨⟨by linarith, h1.ne, fun h2 => ?_⟩, hz⟩
      nlinarith [norm_nonneg z, norm_nonneg (z - I)]
    · obtain ⟨hz, h2⟩ := hi
      rw [mem_ball_zero_iff] at hz; rw [mem_ball, dist_eq_norm, sub_neg_eq_add] at h2
      refine ⟨⟨by linarith, fun h1 => ?_, h2.ne⟩, hz⟩
      nlinarith [norm_nonneg z, norm_nonneg (z + I)]

/-- The four pieces at the cusp, for `0 < r ≤ 1/2`: open, preconnected, pairwise disjoint, non-empty, each with `0` in its
closure — the hypotheses of `isSector_iff_of_partition` for any map whose interior points near `0` are the cusp's (`cuspFrag`;
the bowtie, `Plane/ValidMap/BaseSteps`). -/
theorem cuspPiece_data {r : ℝ} (hr0 : 0 < r) (hr : r ≤ 1 / 2) :
    (∀ i, IsOpen (cuspPiece r i)) ∧ (∀ i, IsPreconnected (cuspPiece r i)) ∧
      (∀ i j, i ≠ j → Disjoint (cuspPiece r i) (cuspPiece r j)) ∧ (∀ i, (cuspPiece r i).Nonempty) ∧
      ∀ i, (0 : ℂ) ∈ closure (cuspPiece r i) := by
  -- representatives `t, −t, t i, −t i`
  have hrep : ∀ t : ℝ, 0 < t → t < r → (t : ℂ) ∈ cuspPiece r 0 ∧ -(t : ℂ) ∈ cuspPiece r 1 ∧
      (t : ℂ) * I ∈ cuspPiece r 2 ∧ -((t : ℂ) * I) ∈ cuspPiece r 3 := by
    intro t ht htr
    have hn : ‖(t : ℂ)‖ = t := by rw [Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht]
    have hnI : ‖(t : ℂ) * I‖ = t := by rw [norm_mul, Complex.norm_I, mul_one, hn]
    have hs1 : ‖(t : ℂ) - I‖ ^ 2 = t ^ 2 + 1 := by
      rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; simp; ring
    have hs2 : ‖(t : ℂ) + I‖ ^ 2 = t ^ 2 + 1 := by
      rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; simp; ring
    have hgt : ∀ a : ℝ, 0 ≤ a → a ^ 2 = t ^ 2 + 1 → 1 < a := fun a ha h => by nlinarith
    refine ⟨?_, ?_, ?_, ?_⟩
    · show (t : ℂ) ∈ hornSet 0 0 (-1) 1 r
      exact (hornSet_cusp_iff r _).mpr ⟨by rw [hn]; exact htr, by simpa using ht, hgt _ (norm_nonneg _) hs2,
        hgt _ (norm_nonneg _) hs1⟩
    · show -(t : ℂ) ∈ (fun z => -(starRingEnd ℂ z)) '' hornSet 0 0 (-1) 1 r
      refine mem_cuspPiece_one.mpr ⟨by rw [norm_neg, hn]; exact htr, by simpa using ht, ?_, ?_⟩
      · refine hgt _ (norm_nonneg _) ?_
        rw [show -(t : ℂ) + I = -((t : ℂ) - I) by ring, norm_neg, hs1]
      · refine hgt _ (norm_nonneg _) ?_
        rw [show -(t : ℂ) - I = -((t : ℂ) + I) by ring, norm_neg, hs2]
    · show (t : ℂ) * I ∈ ball 0 r ∩ ball I 1
      refine ⟨mem_ball_zero_iff.mpr (by rw [hnI]; exact htr), ?_⟩
      rw [mem_ball, dist_eq_norm, show (t : ℂ) * I - I = ((t - 1 : ℝ) : ℂ) * I by push_cast; ring, norm_mul,
        Complex.norm_I, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_neg (by linarith [hr])]
      linarith
    · show -((t : ℂ) * I) ∈ ball 0 r ∩ ball (-I) 1
      refine ⟨mem_ball_zero_iff.mpr (by rw [norm_neg, hnI]; exact htr), ?_⟩
      rw [mem_ball, dist_eq_norm, show -((t : ℂ) * I) - -I = ((1 - t : ℝ) : ℂ) * I by push_cast; ring, norm_mul,
        Complex.norm_I, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by linarith [hr])]
      linarith
  have hnorms : ∀ t : ℝ, 0 < t → ‖(t : ℂ)‖ = t ∧ ‖-(t : ℂ)‖ = t ∧ ‖(t : ℂ) * I‖ = t ∧ ‖-((t : ℂ) * I)‖ = t := by
    intro t ht
    have hn : ‖(t : ℂ)‖ = t := by rw [Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht]
    refine ⟨hn, by rw [norm_neg, hn], by rw [norm_mul, Complex.norm_I, mul_one, hn], by
      rw [norm_neg, norm_mul, Complex.norm_I, mul_one, hn]⟩
  refine ⟨fun i => ?_, fun i => ?_, fun i j hij => ?_, fun i => ?_, fun i => ?_⟩
  · fin_cases i
    · exact isOpen_hornSet_cusp r
    · show IsOpen {z | z ∈ (fun z => -(starRingEnd ℂ z)) '' hornSet 0 0 (-1) 1 r}
      have : {z | z ∈ (fun z => -(starRingEnd ℂ z)) '' hornSet 0 0 (-1) 1 r} =
          {z : ℂ | ‖z‖ < r} ∩ {z | z.re < 0} ∩ {z | 1 < ‖z + I‖} ∩ {z | 1 < ‖z - I‖} := by
        ext z; rw [mem_setOf_eq, mem_cuspPiece_one]; simp only [mem_inter_iff, mem_setOf_eq, and_assoc]
      rw [this]
      exact (((isOpen_lt (by fun_prop) continuous_const).inter (isOpen_lt Complex.continuous_re continuous_const)).inter
        (isOpen_lt continuous_const (by fun_prop))).inter (isOpen_lt continuous_const (by fun_prop))
    · exact isOpen_ball.inter isOpen_ball
    · exact isOpen_ball.inter isOpen_ball
  · fin_cases i
    · exact isPreconnected_hornSet_cusp hr
    · exact (isPreconnected_hornSet_cusp hr).image _ (by fun_prop)
    · exact ((convex_ball _ _).inter (convex_ball _ _)).isPreconnected
    · exact ((convex_ball _ _).inter (convex_ball _ _)).isPreconnected
  · rw [disjoint_left]
    intro z hzi hzj
    have hsum := norm_sub_I_sq_add z
    have key : ∀ i, z ∈ cuspPiece r i → (i = 0 → 0 < z.re ∧ 1 < ‖z + I‖ ∧ 1 < ‖z - I‖) ∧
        (i = 1 → z.re < 0 ∧ 1 < ‖z + I‖ ∧ 1 < ‖z - I‖) ∧ (i = 2 → ‖z - I‖ < 1) ∧ (i = 3 → ‖z + I‖ < 1) := by
      intro i hi
      fin_cases i
      · exact ⟨fun _ => ((hornSet_cusp_iff r z).mp hi).2, by simp, by simp, by simp⟩
      · exact ⟨by simp, fun _ => (mem_cuspPiece_one.mp hi).2, by simp, by simp⟩
      · exact ⟨by simp, by simp, fun _ => by have := hi.2; rwa [mem_ball, dist_eq_norm] at this, by simp⟩
      · exact ⟨by simp, by simp, by simp, fun _ => by
          have := hi.2; rwa [mem_ball, dist_eq_norm, sub_neg_eq_add] at this⟩
    have ki := key i hzi
    have kj := key j hzj
    fin_cases i <;> fin_cases j <;> simp at hij ki kj <;> nlinarith [norm_nonneg z, norm_nonneg (z - I), norm_nonneg (z + I)]
  · obtain ⟨h0, h1, h2, h3⟩ := hrep (r / 2) (by linarith [hr0]) (by linarith [hr0])
    fin_cases i
    exacts [⟨_, h0⟩, ⟨_, h1⟩, ⟨_, h2⟩, ⟨_, h3⟩]
  · rw [Metric.mem_closure_iff]
    intro ε hε
    set t := min (ε / 2) (r / 2) with ht
    have ht0 : 0 < t := lt_min (by linarith) (by linarith [hr0])
    have htε : t < ε := by linarith [min_le_left (ε / 2) (r / 2)]
    obtain ⟨h0, h1, h2, h3⟩ := hrep t ht0 (by linarith [min_le_right (ε / 2) (r / 2), hr0])
    obtain ⟨n0, n1, n2, n3⟩ := hnorms t ht0
    fin_cases i
    · exact ⟨_, h0, by rw [dist_zero_left, n0]; exact htε⟩
    · exact ⟨_, h1, by rw [dist_zero_left, n1]; exact htε⟩
    · exact ⟨_, h2, by rw [dist_zero_left, n2]; exact htε⟩
    · exact ⟨_, h3, by rw [dist_zero_left, n3]; exact htε⟩

/-- **A proved horn** (FS131-QA2's QA2-4): in the cusp fragment, colour `1` has a horn at `0` along `e 0` with bounding curvatures
`−1` (the arc of `ω(−i)`) and `1` (the arc of `ω(i)`). -/
theorem cuspFrag_isHorn : cuspFrag.IsHorn 0 0 (-1) 1 1 := by
  refine ⟨by norm_num, ?_⟩
  filter_upwards [Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 2 by norm_num)] with r hr
  obtain ⟨ho, hp, hd, hn, hc⟩ := cuspPiece_data hr.1 hr.2
  have hsec : cuspFrag.IsSector 0 r (cuspPiece r 0) :=
    (isSector_iff_of_partition (cuspFrag_partition hr.2) ho hp hd hn hc).mpr ⟨0, rfl⟩
  refine ⟨hsec, fun z hz => ?_⟩
  obtain ⟨-, -, h2, h1⟩ := (hornSet_cusp_iff r z).mp hz
  show cuspCol z = 1
  simp only [cuspCol, h1, h2, and_self, if_true]

end ArcMap

end HadwigerNelson.Plane
