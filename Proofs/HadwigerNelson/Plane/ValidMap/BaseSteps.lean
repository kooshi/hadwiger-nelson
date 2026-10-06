import Proofs.HadwigerNelson.Plane.ValidMap.Basic
import Proofs.HadwigerNelson.Plane.SVMap
import Proofs.HadwigerNelson.Plane.LocalMapExamples
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc

/-!
# The base's steps with unit arcs (FS-112's N3 round) and the bowtie fragment

Wave 4's skeleton (`plans/FS131-w4-kernel-plan.md` § 8). The vocabulary of row 134's base at a cubic trichromatic vertex `u`
(`plans/FS110-CB-verification.md` D1–D2, `plans/FS110-CE-verification.md` E6, `plans/FS112-N-proof.md` stage N3-3), point-set over
`ArcMap`:

* `pseudoColours u x` — CB's pseudo-colour `c′(x)` (S–V Def. 7): the colours at `x` not carried at `u`;
* `IsLeavingCentre u q` — `q ∈ ω(u)` carries on `ω(q)` an arc of `Γ` with constant sides ending at `u`; `leavingInner`, `leavingOuter`
  — the inner and outer colours of those arcs;
* `StripHolds u q` — CB's D2 strip at `q ∈ ω(u)`: on one side of `ω(u)` near `q` no interior point has a colour carried at `u`;
* `MIn u x` — CE5's M-in: a colour carried at `u` has `x` in the closure of its part strictly inside `ω(u)`.

Rows: **FS112-N3-PAIRS** (`pair_i`, `pair_ii`, `pair_P'`), **FS112-N3-FAIL** (`fail_leavingCentre`, `fail_colours`), **FS112-N3-ANTI**
(`anti`), **FS112-N3-END** (`n3_end`), **FS112-FLANK**'s last clause (`flank_incomplete_bowtie`), **FS112-BOWTIE** (`bowtie : ArcMap 6` and its properties — the wave's inhabitant of `IsHorn`,
`IsStuck`, `DoublyShadowed` and `TerminalOn`). FS112-N3-NOBOTH is in `Plane/ValidMap/UnitArc`; FS112-C-DOUBLE moved to wave 5 (inventory
item 69).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-! ## The base's vocabulary -/

/-- CB's **pseudo-colour** `c′(x)` relative to `u` (S–V Def. 7, `c′(x) = c(x) ∩ {1, 2, 3}` when `c(u) = {4, 5, 6}`): the colours at `x`
not carried at `u`. -/
def pseudoColours (u x : ℂ) : Set (Fin k) := F.coloursAt x \ F.coloursAt u

/-- **A leaving centre** of `u`: a point `q ∈ ω(u)` such that an arc of `Γ` on `ω(q)` with constant sides ends at `u` (FS112-N3's "the
centre of a unit arc with endpoint `u`"). -/
def IsLeavingCentre (u q : ℂ) : Prop :=
  dist q u = 1 ∧ ∃ θ₁ θ₂ c c', F.IsRingArc q θ₁ θ₂ c c' ∧ (ringPt q θ₁ = u ∨ ringPt q θ₂ = u)

/-- The inner colours (toward `q`) of the arcs of `Γ` on `ω(q)` with constant sides ending at `u`. -/
def leavingInner (u q : ℂ) : Set (Fin k) :=
  {c | ∃ θ₁ θ₂ c', F.IsRingArc q θ₁ θ₂ c c' ∧ (ringPt q θ₁ = u ∨ ringPt q θ₂ = u)}

/-- The outer colours of the arcs of `Γ` on `ω(q)` with constant sides ending at `u`. -/
def leavingOuter (u q : ℂ) : Set (Fin k) :=
  {c' | ∃ θ₁ θ₂ c, F.IsRingArc q θ₁ θ₂ c c' ∧ (ringPt q θ₁ = u ∨ ringPt q θ₂ = u)}

/-- **CB's D2 strip holds at `q`**: on one side of `ω(u)` near `q` (inside or outside), no interior point has a colour carried at `u`. -/
def StripHolds (u q : ℂ) : Prop :=
  ∃ ε > 0, (∀ z ∈ F.interiorPts ∩ ball q ε ∩ ball u 1, F.col z ∉ F.coloursAt u) ∨
    ∀ z ∈ (F.interiorPts ∩ ball q ε) \ closedBall u 1, F.col z ∉ F.coloursAt u

/-- **M-in** (CE5): some colour carried at `u` has `x` in the closure of its part strictly inside `ω(u)`. -/
def MIn (u x : ℂ) : Prop := ∃ c ∈ F.coloursAt u, x ∈ closure (F.region c ∩ ball u 1)

end ArcMap

/-! ### Spec examples -/

section Spec

/-- On the one-colour plane every colour class is the plane, so the one colour is carried everywhere. -/
theorem const_univ_coloursAt (j : Fin 2) (x : ℂ) : (ArcMap.const univ isOpen_univ j).coloursAt x = {j} := by
  ext c
  simp only [ArcMap.coloursAt, mem_setOf_eq, mem_singleton_iff]
  constructor
  · intro h
    by_contra hne
    have hreg : (ArcMap.const univ isOpen_univ j).region c = ∅ := by
      ext z; simp [ArcMap.region, ArcMap.const, ArcMap.interiorPts, Ne.symm hne]
    rw [hreg, closure_empty] at h
    exact h
  · rintro rfl
    have hreg : (ArcMap.const univ isOpen_univ c).region c = univ := by
      ext z; simp [ArcMap.region, ArcMap.const, ArcMap.interiorPts]
    rw [hreg, closure_univ]; trivial

/-- The pseudo-colours on the one-colour plane are empty. -/
example (j : Fin 2) : (ArcMap.const univ isOpen_univ j).pseudoColours 0 1 = ∅ := by
  simp [ArcMap.pseudoColours, const_univ_coloursAt]

/-- On the one-colour plane every point of `ω(0)` is M-in. -/
example (j : Fin 2) : (ArcMap.const univ isOpen_univ j).MIn 0 1 := by
  refine ⟨j, by simp [const_univ_coloursAt], ?_⟩
  have hreg : (ArcMap.const univ isOpen_univ j).region j = univ := by
    ext z; simp [ArcMap.region, ArcMap.const, ArcMap.interiorPts]
  rw [hreg, univ_inter, closure_ball _ one_ne_zero, mem_closedBall, dist_zero_right]; simp

/-- **Adversary**: on the one-colour plane the strip holds nowhere (both sides carry the colour of the centre). -/
example (j : Fin 2) : ¬ (ArcMap.const univ isOpen_univ j).StripHolds 0 1 := by
  rintro ⟨ε, hε, h | h⟩
  · refine h ((1 - min (ε / 2) (1 / 2) : ℝ) : ℂ) ⟨⟨by simp [ArcMap.const, ArcMap.interiorPts], ?_⟩, ?_⟩ ?_
    · rw [mem_ball, dist_eq_norm, ← ofReal_one, ← ofReal_sub, norm_real, Real.norm_eq_abs]
      rw [abs_of_nonpos (by linarith [min_le_left (ε / 2) (1 / 2), lt_min (half_pos hε) (by norm_num : (0:ℝ) < 1 / 2)])]
      linarith [min_le_left (ε / 2) (1 / 2)]
    · rw [mem_ball, dist_zero_right, norm_real, Real.norm_eq_abs]
      have h0 := lt_min (half_pos hε) (by norm_num : (0:ℝ) < 1 / 2)
      rw [abs_of_pos (by linarith [min_le_right (ε / 2) (1 / 2)])]; linarith
    · show j ∈ (ArcMap.const univ isOpen_univ j).coloursAt 0
      rw [const_univ_coloursAt]; rfl
  · refine h ((1 + ε / 2 : ℝ) : ℂ) ⟨⟨by simp [ArcMap.const, ArcMap.interiorPts], ?_⟩, ?_⟩ ?_
    · rw [mem_ball, dist_eq_norm, ← ofReal_one, ← ofReal_sub, norm_real, Real.norm_eq_abs,
        abs_of_pos (by linarith)]; linarith
    · rw [mem_closedBall, dist_zero_right, norm_real, Real.norm_eq_abs, abs_of_pos (by linarith)]; linarith
    · show j ∈ (ArcMap.const univ isOpen_univ j).coloursAt 0
      rw [const_univ_coloursAt]; rfl

/-- `quadRing`'s ring arc `[0°, 90°]` of `ω(0)` ends at `1`, so `0` is a leaving centre of `1`. -/
example : quadRing.IsLeavingCentre 1 0 :=
  ⟨by simp, 0, π / 2, 0, 2, quadRing_isRingArc, Or.inl (by simp [ringPt, e])⟩

/-- **Adversary**: a map with no arcs has no leaving centre. -/
example (j : Fin 2) : ¬ (ArcMap.const univ isOpen_univ j).IsLeavingCentre 1 0 := by
  rintro ⟨-, θ₁, θ₂, c, c', ⟨hlt, hsub, -⟩, -⟩
  have := hsub ⟨θ₁, ⟨le_refl _, hlt.le⟩, rfl⟩
  simp [ArcMap.Γ, ArcMap.const] at this

/-! ### The brick corner: a cubic trichromatic vertex with an M-in point (FS131-QA2's QA2-2) -/

/-- **An M-in point at the brick corner**: the far corner `x = 4/5 + 3/5 i` of the upper right cell at the corner `0` of `sevenBrickMap`
is at distance exactly `1` (3–4–5) and lies in the closure of that cell's part inside `ω(0)` — colour `0`, carried at `0`. With
`sevenBrick_corner_isCubicTrichromatic` this exercises `anti`'s hypotheses `IsCubicTrichromatic u ∧ MIn u x` on a valid map of the plane
at `k = 7`; the second, antipodal M-in point is the clause `anti` refutes (the brick's two M-in points `±4/5 + 3/5 i` are `8/5` apart). -/
theorem sevenBrick_corner_mIn :
    dist (((4 / 5 : ℝ) : ℂ) + ((3 / 5 : ℝ) : ℂ) * I) 0 = 1 ∧ sevenBrickMap.MIn 0 (((4 / 5 : ℝ) : ℂ) + ((3 / 5 : ℝ) : ℂ) * I) := by
  set x : ℂ := ((4 / 5 : ℝ) : ℂ) + ((3 / 5 : ℝ) : ℂ) * I with hx
  have hxre : x.re = 4 / 5 := by simp [hx]
  have hxim : x.im = 3 / 5 := by simp [hx]
  have hnx : ‖x‖ = 1 := by
    rw [← Real.sqrt_sq (norm_nonneg x), ← Complex.normSq_eq_norm_sq, Complex.normSq_apply, hxre, hxim]
    norm_num
  refine ⟨by rw [dist_zero_right, hnx], 0, by rw [sevenBrick_corner_coloursAt]; simp, ?_⟩
  rw [Metric.mem_closure_iff]
  intro ε hε
  set t : ℝ := min (ε / 2) (1 / 4) with ht
  have ht0 : 0 < t := lt_min (by linarith) (by norm_num)
  have ht1 : t ≤ 1 / 4 := min_le_right _ _
  set z : ℂ := ((1 - t : ℝ) : ℂ) * x with hz
  have hzre : z.re = 4 / 5 * (1 - t) := by rw [hz, Complex.re_ofReal_mul, hxre]; ring
  have hzim : z.im = 3 / 5 * (1 - t) := by rw [hz, Complex.im_ofReal_mul, hxim]; ring
  have hfl : ⌊z.im / (3 / 5)⌋ = 0 := by
    rw [Int.floor_eq_iff, hzim]; push_cast; rw [zero_add]
    constructor
    · apply div_nonneg <;> linarith
    · rw [div_lt_one (by norm_num)]; linarith
  have hnot : ∀ n : ℤ, 1 - t ≠ n := by
    intro n hn
    rcases lt_or_ge 0 n with hn0 | hn0
    · have : (1 : ℝ) ≤ n := by exact_mod_cast hn0
      linarith
    · have : (n : ℝ) ≤ 0 := by exact_mod_cast hn0
      linarith
  have hzint : z ∈ sevenBrickMap.interiorPts := by
    refine ⟨mem_univ z, not_mem_sevenBrickArcs (fun n hn => hnot n ?_) (fun n hn => hnot n ?_)⟩
    · rw [hzim] at hn; linarith
    · rw [hfl, hzre] at hn; push_cast at hn; linarith
  have hzcol : sevenBrickMap.col z = 0 := by
    rw [sevenBrick_color_eq (c := 0) (r := 0) hfl]
    · decide
    · rw [Int.floor_eq_iff, hzre]; push_cast; rw [zero_add]; simp only [mul_zero, sub_zero]
      constructor
      · apply div_nonneg <;> linarith
      · rw [div_lt_one (by norm_num)]; linarith
  have hnz : ‖z‖ = 1 - t := by
    rw [hz, norm_mul, hnx, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by linarith)]
  refine ⟨z, ⟨⟨hzint, hzcol⟩, by rw [mem_ball_zero_iff, hnz]; linarith⟩, ?_⟩
  have : x - z = ((t : ℝ) : ℂ) * x := by rw [hz]; push_cast; ring
  rw [dist_eq_norm, this, norm_mul, hnx, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]
  linarith [min_le_left (ε / 2) (1 / 4)]

end Spec

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## The colours near a vertex, and a cubic trichromatic vertex's sectors -/

/-- **Near a point of the domain every interior point carries a colour of the point** (child, from `localSectors`: the interior points
of a small ball are the sectors, each with the point in its closure). -/
theorem exists_ball_col_mem_coloursAt {x : ℂ} (hx : x ∈ F.dom) :
    ∃ r > 0, ball x r ⊆ F.dom ∧ ∀ z ∈ F.interiorPts ∩ ball x r, F.col z ∈ F.coloursAt x := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hx
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  refine ⟨r₀, hC.pos, hC.subdom, fun z hz => ?_⟩
  rcases Nat.eq_zero_or_pos n with hn | hn
  · have hball : ball x r₀ ⊆ F.interiorPts := hC.empty hn
    have hxI : x ∈ F.interiorPts := hball (mem_ball_self hC.pos)
    have : F.col z = F.col x :=
      (convex_ball x r₀).isPreconnected.constant (F.continuousOn_col.mono hball) hz.2 (mem_ball_self hC.pos)
    rw [this]
    exact subset_closure ⟨hxI, rfl⟩
  · have hz' : z ∈ ⋃ i, G.sector x r₀ i := by rw [← hC.cover r₀ hr₀ hn]; exact ⟨hz.2, hz.1⟩
    obtain ⟨i, hi⟩ := mem_iUnion.mp hz'
    have hsub : G.sector x r₀ i ⊆ F.region (F.col z) := fun w hw =>
      ⟨hC.sector_subset_interiorPts hn hr₀ i hw,
        (hC.isPreconnected r₀ hr₀ i).constant (F.continuousOn_col.mono (hC.sector_subset_interiorPts hn hr₀ i)) hw hi⟩
    exact closure_mono hsub (hC.mem_closure_sector hr₀ i)

/-- **A cubic trichromatic vertex carries no repeated colour** (child): its three sectors carry its three colours, one each. -/
theorem IsCubicTrichromatic.not_hasRepeatedColour {u : ℂ} (h : F.IsCubicTrichromatic u) (hu : u ∈ F.dom) :
    ¬ F.HasRepeatedColour u := by
  classical
  rintro ⟨c, hc⟩
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hu
  have hI : ∀ᶠ r in 𝓝[>] (0 : ℝ), r ∈ Ioc 0 r₀ := Ioc_mem_nhdsGT hC.pos
  obtain ⟨r, hr1, hr2, hr3, hr⟩ := (hI.and (hC.hasDegree.and (h.1.and hc))).exists
  have hrI : r ∈ Ioc 0 r₀ := hr1
  have hn3 : max n 1 = 3 := by
    have := hr2.symm.trans hr3
    exact_mod_cast this
  have hn : 0 < n := by omega
  have hn' : n = 3 := by omega
  choose q hq using fun i => hC.sector_nonempty hrI i
  set f : Fin n → Fin k := fun i => F.col (q i) with hf
  have hcolsec : ∀ i, ∀ w ∈ G.sector u r i, F.col w = f i := fun i w hw =>
    (hC.isPreconnected r hrI i).constant (F.continuousOn_col.mono (hC.sector_subset_interiorPts hn hrI i)) hw (hq i)
  -- every colour at `u` is a sector's colour
  have hsub : F.coloursAt u ⊆ ↑(Finset.univ.image f) := by
    intro j hj
    obtain ⟨β, hβ⟩ := coneAt_region_nonempty hj
    obtain ⟨i, -, hi⟩ := hC.exists_sector_of_mem_coneAt_region hn hrI hβ
    have : f i = j := ((hcolsec i (q i) (hq i)).symm.trans (hi (hq i)).2 : F.col (q i) = j)
    rw [Finset.coe_image]
    exact ⟨i, by simp, this⟩
  have hcard : (Finset.univ.image f).card = (Finset.univ : Finset (Fin n)).card := by
    have h1 := Set.ncard_le_ncard hsub (Finset.finite_toSet _)
    rw [Set.ncard_coe_finset, h.2] at h1
    have h2 := Finset.card_image_le (s := (Finset.univ : Finset (Fin n))) (f := f)
    rw [Finset.card_univ, Fintype.card_fin] at h2 ⊢
    omega
  have hinj : Set.InjOn f (Finset.univ : Finset (Fin n)) := Finset.card_image_iff.mp hcard
  have hle : (F.sectorsOf u r c).encard ≤ 1 := by
    rw [Set.encard_le_one_iff]
    rintro S S' ⟨hS, hSc⟩ ⟨hS', hSc'⟩
    obtain ⟨i, rfl⟩ := (hC.isSector_iff hn hrI).mp hS
    obtain ⟨i', rfl⟩ := (hC.isSector_iff hn hrI).mp hS'
    have hfi : f i = c := (hcolsec i (q i) (hq i)).symm.trans (hSc (hq i))
    have hfi' : f i' = c := (hcolsec i' (q i') (hq i')).symm.trans (hSc' (hq i'))
    rw [hinj (by simp) (by simp) (hfi.trans hfi'.symm)]
  have := hr.trans hle
  norm_num at this

end ArcMap

/-! ## The germs of a cubic trichromatic vertex and their votes (FS131-I4k)

Children of FS112-N3-PAIRS, -N3-FAIL and -N3-ANTI: the two-zeros algebra of a germ against a unit circle through its base
(`germ_eq_of_two_on_circle`, `branchPt_two_sin`), the chart of a cubic trichromatic vertex (`IsCubicTrichromatic.chart`), the isolation
of a branch near its points (`IsSectorChart.exists_ball_branch`, over `localSectors_disj`) and the arc of `Γ` along a germ tangent to a
unit circle (`IsSectorChart.exists_isRingArc_of_along`), S–V Prop. 10's vote (`stripHolds_of_two_branches`,
`exists_branch_on_circle_of_not_stripHolds`, `exists_along_of_side`), the crossing at a vertex (`closure_sector_subset_of_side`), and
the two halves of a unit circle crossing `ω(u)` transversally (`exists_side_germs_of_transversal`, `half_colour_or_bothKind`). -/

/-- A branch point of a germ lies in the closure of the sector after it and of the sector before it (child): at radius `s` the
sector's angular slice is the open interval between its two germs' directions, non-empty when the directions are ordered. -/
theorem BranchGerms.mem_closure_sector_of_lt {n : ℕ} {G : BranchGerms n} {v : ℂ} {r s : ℝ} (hs : s ∈ Ioo 0 r) (i : Fin n)
    (hlt : G.dir i s < G.nextDir i s) :
    v + (s : ℂ) * e (G.dir i s) ∈ closure (G.sector v r i) ∧ v + (s : ℂ) * e (G.nextDir i s) ∈ closure (G.sector v r i) := by
  set f : ℝ → ℂ := fun φ => v + (s : ℂ) * e φ with hf
  have hfc : Continuous f := by rw [hf]; unfold e; fun_prop
  have hsub : f '' Ioo (G.dir i s) (G.nextDir i s) ⊆ G.sector v r i := by
    rintro _ ⟨φ, hφ, rfl⟩; exact ⟨s, hs, φ, hφ, rfl⟩
  have hcl : f '' Icc (G.dir i s) (G.nextDir i s) ⊆ closure (G.sector v r i) := by
    rw [← closure_Ioo hlt.ne]
    exact (image_closure_subset_closure_image hfc).trans (closure_mono hsub)
  exact ⟨hcl ⟨_, left_mem_Icc.mpr hlt.le, rfl⟩, hcl ⟨_, right_mem_Icc.mpr hlt.le, rfl⟩⟩

/-- Among three germs, two distinct ones bound every sector (child). -/
theorem BranchGerms.fin3_adj : ∀ i k l : Fin 3, k ≠ l →
    (i = k ∨ BranchGerms.next i = k) ∨ (i = l ∨ BranchGerms.next i = l) := by decide

/-- The squared distance from `q` of a branch point, in the frame of its germ's direction (child). -/
theorem sq_dist_branchPt (u q : ℂ) (β κ s : ℝ) : dist (branchPt u β κ s) q ^ 2 =
    (((u - q) * starRingEnd ℂ (e β)).re + s * Real.cos (Real.arcsin (κ * s / 2))) ^ 2 +
      (((u - q) * starRingEnd ℂ (e β)).im + s * Real.sin (Real.arcsin (κ * s / 2))) ^ 2 := by
  set a := Real.arcsin (κ * s / 2)
  have h1 : (branchPt u β κ s - q) * starRingEnd ℂ (e β) = (u - q) * starRingEnd ℂ (e β) + (s : ℂ) * e a := by
    rw [branchPt, e_add]
    have := conj_e_mul_e β
    linear_combination ((s : ℂ) * e a) * this
  have h2 : dist (branchPt u β κ s) q = ‖(u - q) * starRingEnd ℂ (e β) + (s : ℂ) * e a‖ := by
    rw [← h1, norm_mul, Complex.norm_conj, norm_e, mul_one, dist_eq_norm]
  rw [h2, Complex.sq_norm, Complex.normSq_apply]
  simp only [Complex.add_re, Complex.add_im, Complex.re_ofReal_mul, Complex.im_ofReal_mul, re_e, im_e]
  ring

/-- Real algebra for `germ_eq_of_two_on_circle` (child). -/
theorem germ_circle_real {p r κ s C : ℝ} (hpr : p ^ 2 + r ^ 2 = 1) (hC : C ^ 2 = 1 - (κ * s / 2) ^ 2) (hs : 0 < s)
    (hd : (p + s * C) ^ 2 + (r + s * (κ * s / 2)) ^ 2 = 1) :
    4 * p ^ 2 = s ^ 2 * (p ^ 2 * κ ^ 2 + (1 + r * κ) ^ 2) := by
  have e1 : s * (2 * p * C + s * (1 + r * κ)) = 0 := by linear_combination hd - hpr - s ^ 2 * hC
  have e2 : 2 * p * C + s * (1 + r * κ) = 0 := (mul_eq_zero.mp e1).resolve_left hs.ne'
  linear_combination (-4 * p ^ 2) * hC + (2 * p * C - s * (1 + r * κ)) * e2

/-- **A germ with two branch points on a unit circle through its base lies along it** (child, the two-zeros algebra): if the
germ `(β, κ)` at `u ∈ ω(q)` has branch points on `ω(q)` at two distinct positive distances, its curvature is `±1` and its
direction is the circle's tangent `e β = i κ (u − q)`. -/
theorem germ_eq_of_two_on_circle {u q : ℂ} (hq : dist u q = 1) {β κ s₁ s₂ : ℝ} (h1 : 0 < s₁) (h2 : 0 < s₂)
    (h12 : s₁ ≠ s₂) (hκ1 : |κ| * s₁ ≤ 2) (hκ2 : |κ| * s₂ ≤ 2)
    (hd1 : dist (branchPt u β κ s₁) q = 1) (hd2 : dist (branchPt u β κ s₂) q = 1) :
    (κ = 1 ∨ κ = -1) ∧ e β = I * κ * (u - q) := by
  set y := (u - q) * starRingEnd ℂ (e β) with hy
  have hpr : y.re ^ 2 + y.im ^ 2 = 1 := by
    have : ‖y‖ = 1 := by rw [hy, norm_mul, Complex.norm_conj, norm_e, mul_one, ← dist_eq_norm, hq]
    have h := Complex.sq_norm y
    rw [this, Complex.normSq_apply] at h
    nlinarith [h]
  have key : ∀ s, 0 < s → |κ| * s ≤ 2 → dist (branchPt u β κ s) q = 1 →
      4 * y.re ^ 2 = s ^ 2 * (y.re ^ 2 * κ ^ 2 + (1 + y.im * κ) ^ 2) := by
    intro s hs hκ hd
    have hmem : κ * s / 2 ∈ Icc (-1 : ℝ) 1 := by
      have : |κ * s / 2| ≤ 1 := by
        rw [abs_div, abs_mul, abs_of_pos hs, abs_two]; linarith
      exact ⟨by linarith [neg_abs_le (κ * s / 2)], by linarith [le_abs_self (κ * s / 2)]⟩
    have hsin : Real.sin (Real.arcsin (κ * s / 2)) = κ * s / 2 := Real.sin_arcsin hmem.1 hmem.2
    have hC : Real.cos (Real.arcsin (κ * s / 2)) ^ 2 = 1 - (κ * s / 2) ^ 2 := by
      have := Real.sin_sq_add_cos_sq (Real.arcsin (κ * s / 2))
      rw [hsin] at this; linarith
    have hsq := sq_dist_branchPt u q β κ s
    rw [hd, hsin] at hsq
    exact germ_circle_real hpr hC hs (by rw [← hy] at hsq; linarith)
  have k1 := key s₁ h1 hκ1 hd1
  have k2 := key s₂ h2 hκ2 hd2
  set M := y.re ^ 2 * κ ^ 2 + (1 + y.im * κ) ^ 2 with hM
  have hM0 : M = 0 := by
    have hsq : s₁ ^ 2 ≠ s₂ ^ 2 := by
      intro h
      exact h12 (by nlinarith [sq_nonneg (s₁ - s₂), sq_nonneg (s₁ + s₂)])
    have : (s₁ ^ 2 - s₂ ^ 2) * M = 0 := by linear_combination k2 - k1
    exact (mul_eq_zero.mp this).resolve_left (sub_ne_zero.mpr hsq)
  have hp : y.re = 0 := by nlinarith [k1]
  have hrk : 1 + y.im * κ = 0 := by
    have : (1 + y.im * κ) ^ 2 = 0 := by rw [hM, hp] at hM0; linarith [hM0]
    exact pow_eq_zero_iff (two_ne_zero) |>.mp this
  have hr2 : y.im ^ 2 = 1 := by rw [hp] at hpr; linarith
  have hκr : κ = -y.im := by nlinarith [hrk, hr2]
  have hκ2' : κ ^ 2 = 1 := by rw [hκr]; linarith [hr2]
  refine ⟨?_, ?_⟩
  · have : (κ - 1) * (κ + 1) = 0 := by linear_combination hκ2'
    rcases mul_eq_zero.mp this with h | h
    · left; linarith
    · right; linarith
  · -- `y = −i κ`, `u − q = y e β`
    have hyv : y = -I * κ := by
      apply Complex.ext
      · simp [hp]
      · simp [hκr]
    have hw : u - q = y * e β := by
      rw [hy, mul_assoc, mul_comm (starRingEnd ℂ (e β)), conj_e_mul_e, mul_one]
    rw [hw, hyv]
    have hk : (κ : ℂ) ^ 2 = 1 := by exact_mod_cast hκ2'
    linear_combination (-e β) * hk + ((κ : ℂ) ^ 2 * e β) * I_mul_I

/-- **Along the circle** (child): a germ at `u ∈ ω(q)` of curvature `σ = ±1` tangent to `ω(q)` (`e β = i σ (u − q)`) has its branch point
at distance `2 sin (t/2)` at the ring point `t` along `ω(q)` from `u` in the sense `σ`. -/
theorem branchPt_two_sin {u q : ℂ} {β σ : ℝ} (hσ : σ = 1 ∨ σ = -1) (hβ : e β = I * σ * (u - q)) {t : ℝ}
    (ht0 : 0 ≤ t) (htπ : t ≤ π) :
    branchPt u β σ (2 * Real.sin (t / 2)) = q + (u - q) * e (σ * t) := by
  have hπ := Real.pi_pos
  have h1 : Real.arcsin (Real.sin (t / 2)) = t / 2 := Real.arcsin_sin (by linarith) (by linarith)
  have harc : Real.arcsin (σ * (2 * Real.sin (t / 2)) / 2) = σ * (t / 2) := by
    rcases hσ with rfl | rfl
    · rw [show (1 : ℝ) * (2 * Real.sin (t / 2)) / 2 = Real.sin (t / 2) by ring, h1]; ring
    · rw [show (-1 : ℝ) * (2 * Real.sin (t / 2)) / 2 = -Real.sin (t / 2) by ring, Real.arcsin_neg, h1]; ring
  rw [branchPt, harc, e_add, hβ]
  have hσ2 : (σ : ℂ) ^ 2 = 1 := by rcases hσ with rfl | rfl <;> norm_num
  have hid : 1 + 2 * (Real.sin (t / 2) : ℂ) * (I * σ) * e (σ * (t / 2)) = e (σ * t) := by
    rw [e_eq, e_eq]
    have hc : Real.cos (σ * t) = 1 - 2 * Real.sin (t / 2) ^ 2 := by
      rcases hσ with rfl | rfl
      · rw [one_mul, show t = 2 * (t / 2) by ring, Real.cos_two_mul, show 2 * (t / 2) / 2 = t / 2 by ring]
        linarith [Real.sin_sq_add_cos_sq (t / 2)]
      · rw [show (-1) * t = -(2 * (t / 2)) by ring, Real.cos_neg, Real.cos_two_mul]
        linarith [Real.sin_sq_add_cos_sq (t / 2)]
    have hs : Real.sin (σ * t) = σ * (2 * Real.sin (t / 2) * Real.cos (t / 2)) := by
      rcases hσ with rfl | rfl
      · rw [one_mul, one_mul, show t = 2 * (t / 2) by ring, Real.sin_two_mul, show 2 * (t / 2) / 2 = t / 2 by ring]
      · rw [show (-1) * t = -(2 * (t / 2)) by ring, Real.sin_neg, Real.sin_two_mul]; ring
    have hc' : Real.cos (σ * (t / 2)) = Real.cos (t / 2) := by
      rcases hσ with rfl | rfl
      · rw [one_mul]
      · rw [neg_one_mul, Real.cos_neg]
    have hs' : Real.sin (σ * (t / 2)) = σ * Real.sin (t / 2) := by
      rcases hσ with rfl | rfl
      · rw [one_mul, one_mul]
      · rw [neg_one_mul, neg_one_mul, Real.sin_neg]
    rw [hc, hs, hc', hs']
    set a := Real.sin (t / 2)
    set b := Real.cos (t / 2)
    push_cast
    linear_combination (2 * (a : ℂ) ^ 2 * I ^ 2) * hσ2 + (2 * (a : ℂ) ^ 2) * I_mul_I
  have : u + ((2 * Real.sin (t / 2) : ℝ) : ℂ) * (I * σ * (u - q) * e (σ * (t / 2))) =
      q + (u - q) * (1 + 2 * (Real.sin (t / 2) : ℂ) * (I * σ) * e (σ * (t / 2))) := by push_cast; ring
  rw [this, hid]

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **The chart of a cubic trichromatic vertex** (child): three germs whose branches never meet at one distance, and three sectors of
three distinct colours, which are all the colours at the vertex. -/
theorem IsCubicTrichromatic.chart {u : ℂ} (h : F.IsCubicTrichromatic u) (hu : u ∈ F.dom) :
    ∃ r₀, ∃ G : BranchGerms 3, F.IsSectorChart G u r₀ ∧
      (∀ i j, i ≠ j → ∀ s ∈ Ioo 0 r₀, e (G.dir i s) ≠ e (G.dir j s)) ∧
      ∃ f : Fin 3 → Fin k, Function.Injective f ∧ (∀ i, G.sector u r₀ i ⊆ F.region (f i)) ∧
        ∀ c ∈ F.coloursAt u, ∃ i, f i = c := by
  classical
  obtain ⟨r₀, n, G, hC, hdisj⟩ := localSectors_disj F hu
  have hn3 : n = 3 := by
    obtain ⟨r, hr2, hr3⟩ := (hC.hasDegree.and h.1).exists
    have : max n 1 = 3 := by exact_mod_cast hr2.symm.trans hr3
    omega
  subst hn3
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  have hn : (0 : ℕ) < 3 := by norm_num
  choose q hq using fun i => hC.sector_nonempty hr₀ i
  set f : Fin 3 → Fin k := fun i => F.col (q i) with hf
  have hsec : ∀ i, G.sector u r₀ i ⊆ F.region (f i) := fun i w hw =>
    ⟨hC.sector_subset_interiorPts hn hr₀ i hw,
      (hC.isPreconnected r₀ hr₀ i).constant (F.continuousOn_col.mono (hC.sector_subset_interiorPts hn hr₀ i)) hw (hq i)⟩
  have hsub : ∀ c ∈ F.coloursAt u, ∃ i, f i = c := by
    intro c hc
    obtain ⟨β, hβ⟩ := coneAt_region_nonempty hc
    obtain ⟨i, -, hi⟩ := hC.exists_sector_of_mem_coneAt_region hn hr₀ hβ
    exact ⟨i, (hi (hq i)).2⟩
  have hinj : Function.Injective f := by
    have hsub' : F.coloursAt u ⊆ ↑(Finset.univ.image f) := fun c hc => by
      obtain ⟨i, hi⟩ := hsub c hc; rw [Finset.coe_image]; exact ⟨i, by simp, hi⟩
    have h1 := Set.ncard_le_ncard hsub' (Finset.finite_toSet _)
    rw [Set.ncard_coe_finset, h.2] at h1
    have h2 : (Finset.univ.image f).card ≤ 3 := (Finset.card_image_le).trans (by simp)
    have hcard : (Finset.univ.image f).card = (Finset.univ : Finset (Fin 3)).card := by
      rw [Finset.card_univ, Fintype.card_fin]; omega
    intro i j hij
    exact Finset.card_image_iff.mp hcard (by simp) (by simp) hij
  exact ⟨r₀, G, hC, hdisj, f, hinj, hsec, hsub⟩

/-- **Near a branch point the arcs are its branch** (child): in a chart whose branches never meet at one distance, a small ball about
a branch point lies in the domain and meets the arcs only on that point's own branch. -/
theorem IsSectorChart.exists_ball_branch {n : ℕ} {G : BranchGerms n} {u : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G u r₀)
    (hdisj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 r₀, e (G.dir i s) ≠ e (G.dir j s)) (k₀ : Fin n) {s₀ : ℝ} (hs₀ : s₀ ∈ Ioo 0 r₀) :
    ∃ δ > 0, ball (branchPt u (G.β k₀) (G.κ k₀) s₀) δ ⊆ F.dom ∧
      ∀ z ∈ ball (branchPt u (G.β k₀) (G.κ k₀) s₀) δ, z ∈ ⋃ a ∈ F.arcs, a.carrier →
        ∃ s ∈ Ioo 0 r₀, z = branchPt u (G.β k₀) (G.κ k₀) s := by
  set b₀ := branchPt u (G.β k₀) (G.κ k₀) s₀ with hb₀
  have hb₀u : dist b₀ u = s₀ := by rw [hb₀, dist_eq_norm, norm_branchPt_sub _ _ _ hs₀.1.le]
  have hsep : ∀ j, j ≠ k₀ → ∀ᶠ δ in 𝓝[>] (0 : ℝ), ∀ s ∈ Ioo 0 r₀, δ ≤ dist (branchPt u (G.β j) (G.κ j) s) b₀ := by
    intro j hj
    have hne : branchPt u (G.β j) (G.κ j) s₀ ≠ b₀ := by
      intro h
      rw [hb₀, branchPt_eq, branchPt_eq] at h
      exact hdisj j k₀ hj s₀ hs₀ ((polar_eq_iff hs₀.1 hs₀.1).mp h).2
    set d := dist (branchPt u (G.β j) (G.κ j) s₀) b₀ with hd
    have hd0 : 0 < d := dist_pos.mpr hne
    obtain ⟨η, hη, hηc⟩ := Metric.continuous_iff.mp (continuous_branchPt u (G.β j) (G.κ j)) s₀ (d / 2) (half_pos hd0)
    filter_upwards [Ioo_mem_nhdsGT (lt_min hη (half_pos hd0))] with δ hδ s hs
    by_contra hlt
    push Not at hlt
    have hδη : δ < η := hδ.2.trans_le (min_le_left _ _)
    have hδd : δ < d / 2 := hδ.2.trans_le (min_le_right _ _)
    rcases lt_or_ge (dist s s₀) η with h1 | h1
    · have h2 := hηc s h1
      have h3 := dist_triangle (branchPt u (G.β j) (G.κ j) s₀) (branchPt u (G.β j) (G.κ j) s) b₀
      rw [dist_comm (branchPt u (G.β j) (G.κ j) s₀) (branchPt u (G.β j) (G.κ j) s)] at h3
      linarith
    · have h2 : |s - s₀| ≤ dist (branchPt u (G.β j) (G.κ j) s) b₀ := by
        have := abs_norm_sub_norm_le (branchPt u (G.β j) (G.κ j) s - u) (b₀ - u)
        rw [norm_branchPt_sub _ _ _ hs.1.le, hb₀, norm_branchPt_sub _ _ _ hs₀.1.le] at this
        rw [dist_eq_norm]; simpa using this
      rw [Real.dist_eq] at h1
      linarith
  have hev : ∀ᶠ δ in 𝓝[>] (0 : ℝ), (0 < δ ∧ δ ≤ min s₀ (r₀ - s₀)) ∧
      ∀ j, j ≠ k₀ → ∀ s ∈ Ioo 0 r₀, δ ≤ dist (branchPt u (G.β j) (G.κ j) s) b₀ := by
    refine Filter.Eventually.and ?_ ?_
    · filter_upwards [Ioo_mem_nhdsGT (lt_min hs₀.1 (sub_pos.mpr hs₀.2))] with δ hδ using ⟨hδ.1, hδ.2.le⟩
    · refine Filter.eventually_all.mpr fun j => ?_
      by_cases hj : j = k₀
      · exact Filter.Eventually.of_forall fun _ h => absurd hj h
      · exact (hsep j hj).mono fun _ h _ => h
  obtain ⟨δ, ⟨hδ0, hδm⟩, hδsep⟩ := hev.exists
  have hball : ∀ z ∈ ball b₀ δ, z ∈ ball u r₀ ∧ z ≠ u := by
    intro z hz
    rw [mem_ball] at hz
    have h1 := dist_triangle z b₀ u
    have h2 := dist_triangle b₀ z u
    rw [dist_comm b₀ z] at h2
    have hm1 := min_le_left s₀ (r₀ - s₀)
    have hm2 := min_le_right s₀ (r₀ - s₀)
    refine ⟨by rw [mem_ball]; linarith, ?_⟩
    rintro rfl
    rw [dist_comm] at hz
    linarith
  refine ⟨δ, hδ0, fun z hz => hC.subdom (hball z hz).1, fun z hz hza => ?_⟩
  have hmem : z ∈ (F.Γ ∩ ball u r₀) \ {u} :=
    ⟨⟨⟨hC.subdom (hball z hz).1, hza⟩, (hball z hz).1⟩, (hball z hz).2⟩
  rw [hC.branches] at hmem
  obtain ⟨j, s, hs, rfl⟩ := mem_iUnion.mp hmem
  by_cases hj : j = k₀
  · subst hj; exact ⟨s, hs, rfl⟩
  · have := hδsep j hj s hs
    rw [mem_ball] at hz
    linarith

/-- **The vote, two germs at once** (child, S–V Prop. 10's place): at a cubic trichromatic vertex `u` (its chart, its three sectors of
the three colours of `u`), if two distinct germs have their branch points at distance `s` both inside `ω(q)`, the outer strip holds at
`q`; both outside, the inner. Two germs bound all three sectors, so every colour of `u` is barred from that side near `q`: a sector of
colour `c` reaching from `u` to a branch point on the other side of `ω(z)` holds a point at distance exactly `1` from `z`. -/
theorem stripHolds_of_two_branches (hF : F.Valid) {u q : ℂ} {r₀ : ℝ} {G : BranchGerms 3}
    (hC : F.IsSectorChart G u r₀) (hord : ∀ s ∈ Ioo 0 r₀, ∀ i, G.dir i s < G.nextDir i s)
    {f : Fin 3 → Fin k} (hsec : ∀ i, G.sector u r₀ i ⊆ F.region (f i)) (hcol : ∀ c ∈ F.coloursAt u, ∃ i, f i = c)
    {s : ℝ} (hs0 : s ∈ Ioo 0 r₀) {k₁ k₂ : Fin 3} (hne : k₁ ≠ k₂)
    (h : (dist (branchPt u (G.β k₁) (G.κ k₁) s) q < 1 ∧ dist (branchPt u (G.β k₂) (G.κ k₂) s) q < 1) ∨
      (1 < dist (branchPt u (G.β k₁) (G.κ k₁) s) q ∧ 1 < dist (branchPt u (G.β k₂) (G.κ k₂) s) q)) :
    F.StripHolds u q := by
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  have hadj : ∀ i l, (i = l ∨ BranchGerms.next i = l) →
      branchPt u (G.β l) (G.κ l) s ∈ closure (G.sector u r₀ i) := by
    rintro i l (rfl | rfl)
    · exact (BranchGerms.mem_closure_sector_of_lt hs0 i (hord s hs0 i)).1
    · rw [branchPt_eq]
      have : e (germDir (G.β (BranchGerms.next i)) (G.κ (BranchGerms.next i)) s) = e (G.nextDir i s) :=
        (G.e_nextDir i s).symm
      rw [this]; exact (BranchGerms.mem_closure_sector_of_lt hs0 i (hord s hs0 i)).2
  have hcross : ∀ i z, z ∈ F.region (f i) → ∀ b ∈ closure (G.sector u r₀ i),
      (dist z u < 1 → dist z b < 1) ∧ (1 < dist z u → 1 < dist z b) := by
    intro i z hz b hb
    have hpc : IsPreconnected (closure (G.sector u r₀ i)) := (hC.isPreconnected r₀ hr₀ i).closure
    have hu := hC.mem_closure_sector hr₀ i
    rcases hF.dist_lt_or_gt_of_isPreconnected hz hpc (closure_mono (hsec i)) with h | h
    · exact ⟨fun _ => h b hb, fun h' => absurd (h u hu) (by linarith)⟩
    · exact ⟨fun h' => absurd (h u hu) (by linarith), fun _ => h b hb⟩
  set d : Fin 3 → ℝ := fun l => dist (branchPt u (G.β l) (G.κ l) s) q with hd
  have hpick : ∀ z ∈ F.interiorPts, F.col z ∈ F.coloursAt u → ∃ i l, z ∈ F.region (f i) ∧ (l = k₁ ∨ l = k₂) ∧
      branchPt u (G.β l) (G.κ l) s ∈ closure (G.sector u r₀ i) := by
    intro z hz hzc
    obtain ⟨i, hi⟩ := hcol _ hzc
    have hzr : z ∈ F.region (f i) := ⟨hz, hi.symm⟩
    rcases BranchGerms.fin3_adj i k₁ k₂ hne with h | h
    · exact ⟨i, k₁, hzr, Or.inl rfl, hadj i k₁ h⟩
    · exact ⟨i, k₂, hzr, Or.inr rfl, hadj i k₂ h⟩
  rcases h with ⟨h1, h2⟩ | ⟨h1', h2'⟩
  · refine ⟨min (1 - d k₁) (1 - d k₂), lt_min (by linarith) (by linarith), Or.inr ?_⟩
    rintro z ⟨⟨hzI, hzq⟩, hzu⟩ hzc
    obtain ⟨i, l, hzr, hl, hb⟩ := hpick z hzI hzc
    have hzu' : 1 < dist z u := by simpa [mem_closedBall, not_le] using hzu
    have hgt := (hcross i z hzr _ hb).2 hzu'
    have htri := dist_triangle z q (branchPt u (G.β l) (G.κ l) s)
    rw [mem_ball] at hzq
    rw [dist_comm q] at htri
    have hdl : d l + dist z q < 1 := by
      rcases hl with rfl | rfl
      · linarith [min_le_left (1 - d l) (1 - d k₂)]
      · linarith [min_le_right (1 - d k₁) (1 - d l)]
    have : dist (branchPt u (G.β l) (G.κ l) s) q = d l := rfl
    linarith
  · refine ⟨min (d k₁ - 1) (d k₂ - 1), lt_min (by linarith) (by linarith), Or.inl ?_⟩
    rintro z ⟨⟨hzI, hzq⟩, hzu⟩ hzc
    obtain ⟨i, l, hzr, hl, hb⟩ := hpick z hzI hzc
    rw [mem_ball] at hzu hzq
    have hlt := (hcross i z hzr _ hb).1 hzu
    have htri := dist_triangle (branchPt u (G.β l) (G.κ l) s) z q
    rw [dist_comm _ z] at htri
    have hdl : 1 + dist z q < d l := by
      rcases hl with rfl | rfl
      · linarith [min_le_left (d l - 1) (d k₂ - 1)]
      · linarith [min_le_right (d k₁ - 1) (d l - 1)]
    have : dist (branchPt u (G.β l) (G.κ l) s) q = d l := rfl
    linarith

/-- **The vote at a cubic trichromatic vertex** (child, S–V Prop. 10's place): where the strip fails at `q`, at every radius below the
chart's some germ's branch point lies on `ω(q)` (`stripHolds_of_two_branches` on two germs on one side). -/
theorem exists_branch_on_circle_of_not_stripHolds (hF : F.Valid) {u q : ℂ} {r₀ : ℝ} {G : BranchGerms 3}
    (hC : F.IsSectorChart G u r₀) (hord : ∀ s ∈ Ioo 0 r₀, ∀ i, G.dir i s < G.nextDir i s)
    {f : Fin 3 → Fin k} (hsec : ∀ i, G.sector u r₀ i ⊆ F.region (f i)) (hcol : ∀ c ∈ F.coloursAt u, ∃ i, f i = c)
    (hs : ¬ F.StripHolds u q) {s : ℝ} (hs0 : s ∈ Ioo 0 r₀) :
    ∃ l, dist (branchPt u (G.β l) (G.κ l) s) q = 1 := by
  by_contra hno
  push Not at hno
  set d : Fin 3 → ℝ := fun l => dist (branchPt u (G.β l) (G.κ l) s) q with hd
  obtain ⟨k₁, k₂, hne, heq⟩ := Fintype.exists_ne_map_eq_of_card_lt (fun l : Fin 3 => decide (d l < 1)) (by simp)
  have hiff : d k₁ < 1 ↔ d k₂ < 1 := by simpa using heq
  apply hs
  refine stripHolds_of_two_branches hF hC hord hsec hcol hs0 hne ?_
  by_cases h1 : d k₁ < 1
  · exact Or.inl ⟨h1, hiff.mp h1⟩
  · exact Or.inr ⟨lt_of_le_of_ne (not_lt.mp h1) (hno k₁).symm,
      lt_of_le_of_ne (not_lt.mp fun h => h1 (hiff.mpr h)) (hno k₂).symm⟩

/-- **The arc along a germ tangent to a unit circle** (child): in a chart at `u ∈ ω(q)` whose branches never meet at one distance, a
germ of curvature `±1` tangent to `ω(q)` gives an arc of `Γ` on `ω(q)` with constant sides ending at `u`, whose interior points are
that germ's branch points (each has a ball meeting the arcs only on the branch, which lies on `ω(q)`). -/
theorem IsSectorChart.exists_isRingArc_of_along {n : ℕ} {G : BranchGerms n} {u q : ℂ} {r₀ : ℝ}
    (hC : F.IsSectorChart G u r₀) (hdisj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 r₀, e (G.dir i s) ≠ e (G.dir j s))
    (huq : dist u q = 1) {k₀ : Fin n} (hσ : G.κ k₀ = 1 ∨ G.κ k₀ = -1) (hβ : e (G.β k₀) = I * G.κ k₀ * (u - q)) :
    ∃ θ₁ θ₂ c c', F.IsRingArc q θ₁ θ₂ c c' ∧ (ringPt q θ₁ = u ∨ ringPt q θ₂ = u) ∧
      ∀ θ ∈ Ioo θ₁ θ₂, ∃ s ∈ Ioo 0 r₀, ringPt q θ = branchPt u (G.β k₀) (G.κ k₀) s := by
  have hπ := Real.pi_pos
  have hr0 := hC.pos
  set σ := G.κ k₀ with hσdef
  have hσabs : |σ| = 1 := by rcases hσ with h | h <;> rw [h] <;> norm_num
  have hr2 : r₀ < 2 := by have := hC.curv k₀; rw [← hσdef, hσabs, one_mul] at this; exact this
  set ψ := arg (u - q) with hψdef
  have hψ : ringPt q ψ = u := ringPt_arg_sub huq
  have heψ : e ψ = u - q := by rw [← hψ, ringPt]; ring
  have hring : ∀ t, 0 ≤ t → t ≤ π → ringPt q (ψ + σ * t) = branchPt u (G.β k₀) σ (2 * Real.sin (t / 2)) := by
    intro t ht0 htπ
    rw [branchPt_two_sin hσ hβ ht0 htπ, ringPt, e_add, heψ]
  have hon : ∀ s ∈ Ioo 0 r₀, dist (branchPt u (G.β k₀) σ s) q = 1 := by
    intro s hs'
    have hs2 : s / 2 ∈ Icc (-1 : ℝ) 1 := ⟨by linarith [hs'.1], by linarith [hs'.2]⟩
    set t := 2 * Real.arcsin (s / 2) with ht
    have ht0 : 0 ≤ t := by have := Real.arcsin_nonneg.mpr (by linarith [hs'.1] : (0:ℝ) ≤ s / 2); linarith
    have htπ : t ≤ π := by have := Real.arcsin_le_pi_div_two (s / 2); linarith
    have hst : 2 * Real.sin (t / 2) = s := by
      rw [ht, show 2 * Real.arcsin (s / 2) / 2 = Real.arcsin (s / 2) by ring, Real.sin_arcsin hs2.1 hs2.2]; ring
    rw [← hst, ← hring t ht0 htπ]
    exact dist_ringPt q _
  set τ := min (r₀ / 2) 1 with hτ
  have hτ0 : 0 < τ := lt_min (by linarith) one_pos
  have hτr : τ < r₀ := (min_le_left _ _).trans_lt (by linarith)
  have hτπ : τ < π := (min_le_right _ _).trans_lt (by linarith [Real.pi_gt_three])
  have hsr : ∀ t, 0 < t → t ≤ τ → 2 * Real.sin (t / 2) ∈ Ioo 0 r₀ := fun t ht htτ => by
    refine ⟨?_, ?_⟩
    · have := Real.sin_pos_of_pos_of_lt_pi (by linarith : 0 < t / 2) (by linarith); linarith
    · have := Real.sin_le (by linarith : (0:ℝ) ≤ t / 2); linarith
  have hpt : ∀ t, 0 ≤ t → t ≤ τ → ringPt q (ψ + σ * t) ∈ F.Γ ∧ (0 < t → (∃ s ∈ Ioo 0 r₀,
      ringPt q (ψ + σ * t) = branchPt u (G.β k₀) (G.κ k₀) s) ∧ ∃ δ > 0,
      ball (ringPt q (ψ + σ * t)) δ ⊆ F.dom ∧ ∀ z ∈ ball (ringPt q (ψ + σ * t)) δ, z ∈ ⋃ a ∈ F.arcs, a.carrier → dist z q = 1) := by
    intro t ht0 htτ
    have htπ : t ≤ π := htτ.trans hτπ.le
    refine ⟨?_, fun htpos => ⟨⟨_, hsr t htpos htτ, hring t ht0 htπ⟩, ?_⟩⟩
    · rcases ht0.eq_or_lt with rfl | htpos
      · rw [mul_zero, add_zero, hψ]; exact hC.mem_Γ.mpr k₀.pos
      · rw [hring t ht0 htπ]
        have hmem : branchPt u (G.β k₀) (G.κ k₀) (2 * Real.sin (t / 2)) ∈
            ⋃ i, branchPt u (G.β i) (G.κ i) '' Ioo 0 r₀ :=
          mem_iUnion.mpr ⟨k₀, _, hsr t htpos htτ, rfl⟩
        rw [← hC.branches] at hmem
        exact hmem.1.1
    · obtain ⟨δ, hδ, hdom, hbr⟩ := hC.exists_ball_branch hdisj k₀ (hsr t htpos htτ)
      rw [hring t ht0 htπ]
      refine ⟨δ, hδ, hdom, fun z hz hza => ?_⟩
      obtain ⟨s', hs', rfl⟩ := hbr z hz hza
      exact hon s' hs'
  rcases hσ with h1 | h1
  · have hφ : ∀ φ, ψ + σ * (φ - ψ) = φ := fun φ => by rw [h1]; ring
    have hΓ : ringArc q ψ (ψ + τ) ⊆ F.Γ := by
      rintro _ ⟨φ, hφm, rfl⟩
      have := (hpt (φ - ψ) (by linarith [hφm.1]) (by linarith [hφm.2])).1
      rwa [hφ] at this
    obtain ⟨c, c', hR⟩ := isRingArc_of_clean (by linarith) hΓ fun θ hθ => by
      have := ((hpt (θ - ψ) (by linarith [hθ.1]) (by linarith [hθ.2])).2 (by linarith [hθ.1])).2
      rwa [hφ] at this
    refine ⟨ψ, ψ + τ, c, c', hR, Or.inl hψ, fun θ hθ => ?_⟩
    have := ((hpt (θ - ψ) (by linarith [hθ.1]) (by linarith [hθ.2])).2 (by linarith [hθ.1])).1
    rwa [hφ] at this
  · have hφ : ∀ φ, ψ + σ * (ψ - φ) = φ := fun φ => by rw [h1]; ring
    have hΓ : ringArc q (ψ - τ) ψ ⊆ F.Γ := by
      rintro _ ⟨φ, hφm, rfl⟩
      have := (hpt (ψ - φ) (by linarith [hφm.2]) (by linarith [hφm.1])).1
      rwa [hφ] at this
    obtain ⟨c, c', hR⟩ := isRingArc_of_clean (by linarith) hΓ fun θ hθ => by
      have := ((hpt (ψ - θ) (by linarith [hθ.2]) (by linarith [hθ.1])).2 (by linarith [hθ.2])).2
      rwa [hφ] at this
    refine ⟨ψ - τ, ψ, c, c', hR, Or.inr hψ, fun θ hθ => ?_⟩
    have := ((hpt (ψ - θ) (by linarith [hθ.2]) (by linarith [hθ.1])).2 (by linarith [hθ.2])).1
    rwa [hφ] at this

/-- **A side's bounding germs: one lies along `ω(q)`** (child): where the strip fails at `q`, if the branch points of two distinct
germs all lie in `B̄(q, 1)`, or all outside `B(q, 1)`, one of the two germs has curvature `±1` and is tangent to `ω(q)`. Off that,
each germ meets `ω(q)` at one radius at most (`germ_eq_of_two_on_circle`), so at some radius both lie strictly on one side, and the
vote makes the strip hold. -/
theorem exists_along_of_side (hF : F.Valid) {u q : ℂ} {r₀ : ℝ} {G : BranchGerms 3}
    (hC : F.IsSectorChart G u r₀) (hord : ∀ s ∈ Ioo 0 r₀, ∀ i, G.dir i s < G.nextDir i s)
    {f : Fin 3 → Fin k} (hsec : ∀ i, G.sector u r₀ i ⊆ F.region (f i)) (hcol : ∀ c ∈ F.coloursAt u, ∃ i, f i = c)
    (hs : ¬ F.StripHolds u q) (huq : dist u q = 1) {g₁ g₂ : Fin 3} (hne : g₁ ≠ g₂)
    (hside : (∀ s ∈ Ioo 0 r₀, dist (branchPt u (G.β g₁) (G.κ g₁) s) q ≤ 1 ∧ dist (branchPt u (G.β g₂) (G.κ g₂) s) q ≤ 1) ∨
      (∀ s ∈ Ioo 0 r₀, 1 ≤ dist (branchPt u (G.β g₁) (G.κ g₁) s) q ∧ 1 ≤ dist (branchPt u (G.β g₂) (G.κ g₂) s) q)) :
    ∃ g, (g = g₁ ∨ g = g₂) ∧ (G.κ g = 1 ∨ G.κ g = -1) ∧ e (G.β g) = I * G.κ g * (u - q) := by
  have hr0 := hC.pos
  by_contra hno
  push Not at hno
  have hrad : ∀ m : Fin 3, r₀ * ((m : ℝ) + 1) / 4 ∈ Ioo 0 r₀ := fun m => by
    have hm : (m : ℝ) ≤ 2 := by exact_mod_cast Nat.lt_succ_iff.mp m.isLt
    refine ⟨by positivity, ?_⟩
    rw [div_lt_iff₀ (by norm_num)]; nlinarith
  have hcurv : ∀ g, ∀ s ∈ Ioo 0 r₀, |G.κ g| * s ≤ 2 := fun g s hs' =>
    (mul_le_mul_of_nonneg_left hs'.2.le (abs_nonneg _)).trans (hC.curv g).le
  have hne' : ∀ m₁ m₂ : Fin 3, m₁ ≠ m₂ → r₀ * ((m₁ : ℝ) + 1) / 4 ≠ r₀ * ((m₂ : ℝ) + 1) / 4 := by
    intro m₁ m₂ hm h
    have h' : r₀ * ((m₁ : ℝ) + 1) = r₀ * ((m₂ : ℝ) + 1) := by linarith
    have h'' := mul_left_cancel₀ hr0.ne' h'
    apply hm; ext; exact_mod_cast (by linarith : (m₁ : ℝ) = m₂)
  -- a germ on `ω(q)` at two radii lies along it
  have halong : ∀ g, (g = g₁ ∨ g = g₂) → ∀ m₁ m₂ : Fin 3, m₁ ≠ m₂ →
      dist (branchPt u (G.β g) (G.κ g) (r₀ * ((m₁ : ℝ) + 1) / 4)) q = 1 →
      dist (branchPt u (G.β g) (G.κ g) (r₀ * ((m₂ : ℝ) + 1) / 4)) q = 1 → False := by
    intro g hg m₁ m₂ hm h1 h2
    obtain ⟨hσ, hβ⟩ := germ_eq_of_two_on_circle huq (hrad m₁).1 (hrad m₂).1 (hne' m₁ m₂ hm)
      (hcurv g _ (hrad m₁)) (hcurv g _ (hrad m₂)) h1 h2
    exact hno g hg hσ hβ
  -- some radius has both off `ω(q)`
  obtain ⟨m, hm1, hm2⟩ : ∃ m : Fin 3, dist (branchPt u (G.β g₁) (G.κ g₁) (r₀ * ((m : ℝ) + 1) / 4)) q ≠ 1 ∧
      dist (branchPt u (G.β g₂) (G.κ g₂) (r₀ * ((m : ℝ) + 1) / 4)) q ≠ 1 := by
    by_contra hall
    push Not at hall
    obtain ⟨m₁, m₂, hm, heq⟩ := Fintype.exists_ne_map_eq_of_card_lt
      (fun m : Fin 3 => decide (dist (branchPt u (G.β g₁) (G.κ g₁) (r₀ * ((m : ℝ) + 1) / 4)) q = 1)) (by simp)
    have hiff : dist (branchPt u (G.β g₁) (G.κ g₁) (r₀ * ((m₁ : ℝ) + 1) / 4)) q = 1 ↔
        dist (branchPt u (G.β g₁) (G.κ g₁) (r₀ * ((m₂ : ℝ) + 1) / 4)) q = 1 := by simpa using heq
    by_cases h1 : dist (branchPt u (G.β g₁) (G.κ g₁) (r₀ * ((m₁ : ℝ) + 1) / 4)) q = 1
    · exact halong g₁ (Or.inl rfl) m₁ m₂ hm h1 (hiff.mp h1)
    · exact halong g₂ (Or.inr rfl) m₁ m₂ hm (hall m₁ h1) (hall m₂ (fun h => h1 (hiff.mpr h)))
  apply hs
  refine stripHolds_of_two_branches hF hC hord hsec hcol (hrad m) hne ?_
  rcases hside with h | h
  · exact Or.inl ⟨lt_of_le_of_ne (h _ (hrad m)).1 hm1, lt_of_le_of_ne (h _ (hrad m)).2 hm2⟩
  · exact Or.inr ⟨lt_of_le_of_ne (h _ (hrad m)).1 (Ne.symm hm1), lt_of_le_of_ne (h _ (hrad m)).2 (Ne.symm hm2)⟩

/-- A colour of `u` that occurs on one side of `ω(u)` arbitrarily near `q` (child, from `¬ StripHolds`). -/
theorem exists_colour_near {u q : ℂ} {A : Set ℂ}
    (h : ∀ ε > 0, ∃ z ∈ F.interiorPts ∩ ball q ε ∩ A, F.col z ∈ F.coloursAt u) :
    ∃ c ∈ F.coloursAt u, q ∈ closure (F.region c ∩ A) := by
  by_contra hno
  push Not at hno
  have hev : ∀ᶠ δ in 𝓝[>] (0 : ℝ), 0 < δ ∧ ∀ c ∈ F.coloursAt u, ∀ z ∈ F.region c ∩ A, δ ≤ dist z q := by
    refine (eventually_mem_nhdsWithin).and ((eventually_all_finite (Set.toFinite _)).mpr fun c hc => ?_)
    obtain ⟨ε, hε, hball⟩ := Metric.mem_nhds_iff.mp (isOpen_compl_iff.mpr isClosed_closure |>.mem_nhds (hno c hc))
    filter_upwards [Ioo_mem_nhdsGT hε] with δ hδ z hz
    by_contra hlt
    push Not at hlt
    exact hball (by rw [mem_ball]; exact hlt.trans hδ.2) (subset_closure hz)
  obtain ⟨δ, hδ0, hδ⟩ := hev.exists
  obtain ⟨z, ⟨⟨hzI, hzq⟩, hzA⟩, hzc⟩ := h δ hδ0
  have := hδ _ hzc z ⟨⟨hzI, rfl⟩, hzA⟩
  rw [mem_ball] at hzq
  linarith

/-- **A colour of `u` on one side of `ω(u)` at `x` confines its sector** (child, the crossing at a vertex): if `f i`, the colour of the
`i`-th sector of the chart at `u`, approaches `x` from inside `ω(u)`, the sector's closure lies in `B̄(x, 1)`; from outside, its
closure lies outside `B(x, 1)`. A point `z` of colour `f i` inside `ω(u)` has `u` within `1`, so the whole closed sector is (the
crossing engine); `z → x` closes the bound. -/
theorem closure_sector_subset_of_side (hF : F.Valid) {u x : ℂ} {r₀ : ℝ} {G : BranchGerms 3}
    (hC : F.IsSectorChart G u r₀) {f : Fin 3 → Fin k} (hsec : ∀ i, G.sector u r₀ i ⊆ F.region (f i)) (i : Fin 3) :
    (x ∈ closure (F.region (f i) ∩ ball u 1) → closure (G.sector u r₀ i) ⊆ closedBall x 1) ∧
      (x ∈ closure (F.region (f i) \ closedBall u 1) → closure (G.sector u r₀ i) ⊆ {w | 1 ≤ dist w x}) := by
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  have hpc : IsPreconnected (closure (G.sector u r₀ i)) := (hC.isPreconnected r₀ hr₀ i).closure
  have hu := hC.mem_closure_sector hr₀ i
  refine ⟨fun hin w hw => ?_, fun hout w hw => ?_⟩
  · rw [mem_closedBall]
    by_contra hgt
    push Not at hgt
    obtain ⟨z, ⟨hzr, hzu⟩, hzq⟩ := Metric.mem_closure_iff.mp hin (dist w x - 1) (by linarith)
    rw [mem_ball] at hzu
    rcases hF.dist_lt_or_gt_of_isPreconnected hzr hpc (closure_mono (hsec i)) with h | h
    · have := h w hw
      have := dist_triangle w z x
      rw [dist_comm x z] at hzq
      linarith [dist_comm w z]
    · linarith [h u hu]
  · show 1 ≤ dist w x
    by_contra hlt
    push Not at hlt
    obtain ⟨z, ⟨hzr, hzu⟩, hzq⟩ := Metric.mem_closure_iff.mp hout (1 - dist w x) (by linarith)
    have hzu' : 1 < dist z u := by simpa [mem_closedBall, not_le] using hzu
    rcases hF.dist_lt_or_gt_of_isPreconnected hzr hpc (closure_mono (hsec i)) with h | h
    · linarith [h u hu]
    · have := h w hw
      have := dist_triangle z x w
      rw [dist_comm x z] at hzq
      linarith [dist_comm x w]

/-- **A unit circle through `x` crossing `ω(u)` transversally** (child): if `x ∈ ω(u) ∩ ω(y)` with `y ≠ u` and `|y − u| ≠ 2`, the
points of `ω(y)` just on one side of `x` lie strictly inside `ω(u)` and those just on the other strictly outside. With
`ζ = (x − u) conj (x − y) = P + iQ`, `|y + e(φ₀ + t) − u|² = 1 + 2(1 − P)(1 − cos t) + 2Q sin t`, and transversality is `Q ≠ 0`. -/
theorem exists_side_germs_of_transversal {u x y : ℂ} (hx : dist x u = 1) (hxy : dist x y = 1) (hyu : y ≠ u)
    (hy2 : dist y u ≠ 2) : ∃ σ : ℝ, (σ = 1 ∨ σ = -1) ∧ ∃ t₀ > 0, ∀ t ∈ Ioo 0 t₀,
      dist (ringPt y (arg (x - y) + σ * t)) u < 1 ∧ 1 < dist (ringPt y (arg (x - y) - σ * t)) u := by
  have hπ := Real.pi_pos
  set φ₀ := arg (x - y) with hφ₀
  have hx0 : ringPt y φ₀ = x := ringPt_arg_sub hxy
  have hv : e φ₀ = x - y := by rw [← hx0, ringPt]; ring
  set ζ := (x - u) * starRingEnd ℂ (e φ₀) with hζ
  have hζn : ‖ζ‖ = 1 := by rw [hζ, norm_mul, Complex.norm_conj, norm_e, mul_one, ← dist_eq_norm, hx]
  have hPQ : ζ.re ^ 2 + ζ.im ^ 2 = 1 := by
    have h := Complex.sq_norm ζ
    rw [hζn, Complex.normSq_apply] at h; nlinarith [h]
  have hP : ζ.re ≤ 1 := by nlinarith [sq_nonneg ζ.im, sq_nonneg (ζ.re - 1)]
  -- the squared distance along `ω(y)`
  have hd : ∀ t, dist (ringPt y (φ₀ + t)) u ^ 2 = 1 + 2 * (1 - ζ.re) * (1 - Real.cos t) + 2 * ζ.im * Real.sin t := by
    intro t
    have h1 : (ringPt y (φ₀ + t) - u) * starRingEnd ℂ (e φ₀) = ζ + (e t - 1) := by
      rw [ringPt, e_add, hζ]
      have := conj_e_mul_e φ₀
      have hy : y = x - e φ₀ := by rw [hv]; ring
      rw [hy]
      linear_combination (e t - 1) * this
    have h2 : dist (ringPt y (φ₀ + t)) u = ‖ζ + (e t - 1)‖ := by
      rw [← h1, norm_mul, Complex.norm_conj, norm_e, mul_one, dist_eq_norm]
    rw [h2, Complex.sq_norm, Complex.normSq_apply]
    simp only [Complex.add_re, Complex.add_im, Complex.sub_re, Complex.sub_im, re_e, im_e, Complex.one_re, Complex.one_im]
    nlinarith [Real.sin_sq_add_cos_sq t, hPQ]
  -- transversality: `Q ≠ 0`
  have hQ : ζ.im ≠ 0 := by
    intro hQ
    have hP2 : ζ.re = 1 ∨ ζ.re = -1 := by
      have : (ζ.re - 1) * (ζ.re + 1) = 0 := by rw [hQ] at hPQ; linear_combination hPQ
      rcases mul_eq_zero.mp this with h | h
      · left; linarith
      · right; linarith
    have hw : x - u = ζ * e φ₀ := by
      rw [hζ, mul_assoc, mul_comm (starRingEnd ℂ (e φ₀)), conj_e_mul_e, mul_one]
    have hζr : ζ = (ζ.re : ℂ) := by apply Complex.ext <;> simp [hQ]
    rcases hP2 with h | h
    · apply hyu
      rw [hζr, h, hv] at hw; push_cast at hw; linear_combination hw
    · apply hy2
      rw [hζr, h, hv] at hw; push_cast at hw
      have : y - u = 2 * (y - x) := by linear_combination hw
      rw [dist_eq_norm, this, norm_mul, ← dist_eq_norm, dist_comm, hxy]; norm_num
  set Q := ζ.im with hQdef
  refine ⟨-(Q / |Q|), ?_, min (π / 2) (2 * |Q| / π), lt_min (by linarith) (by positivity), fun t ht => ?_⟩
  · rcases lt_or_gt_of_ne hQ with h | h
    · left; rw [abs_of_neg h, div_neg, div_self hQ]; ring
    · right; rw [abs_of_pos h, div_self hQ]
  have ht1 : t < π / 2 := ht.2.trans_le (min_le_left _ _)
  have ht2 : t < 2 * |Q| / π := ht.2.trans_le (min_le_right _ _)
  have hsin : 2 / π * t ≤ Real.sin t := Real.mul_le_sin ht.1.le ht1.le
  have hsinpos : 0 < Real.sin t := Real.sin_pos_of_pos_of_lt_pi ht.1 (by linarith)
  have hcos : 1 - t ^ 2 / 2 ≤ Real.cos t := Real.one_sub_sq_div_two_le_cos
  have hcos1 : Real.cos t ≤ 1 := Real.cos_le_one t
  have hQQ : Q * (Q / |Q|) = |Q| := by
    rw [mul_div_assoc', ← sq, ← sq_abs, sq, mul_div_assoc, div_self (abs_ne_zero.mpr hQ), mul_one]
  have hσsq : (Q / |Q|) ^ 2 = 1 := by rw [div_pow, sq_abs, div_self (pow_ne_zero 2 hQ)]
  have hcos_neg : ∀ τ, Real.cos (-(Q / |Q|) * τ) = Real.cos τ := fun τ => by
    rcases lt_or_gt_of_ne hQ with h | h
    · rw [abs_of_neg h, div_neg, div_self hQ, neg_neg, one_mul]
    · rw [abs_of_pos h, div_self hQ, neg_one_mul, Real.cos_neg]
  have hsin_neg : ∀ τ, Real.sin (-(Q / |Q|) * τ) = -(Q / |Q|) * Real.sin τ := fun τ => by
    rcases lt_or_gt_of_ne hQ with h | h
    · rw [abs_of_neg h, div_neg, div_self hQ, neg_neg, one_mul, one_mul]
    · rw [abs_of_pos h, div_self hQ, neg_one_mul, neg_one_mul, Real.sin_neg]
  have hQabs : 0 < |Q| := abs_pos.mpr hQ
  constructor
  · have h := hd (-(Q / |Q|) * t)
    rw [hcos_neg, hsin_neg] at h
    have hlt : dist (ringPt y (φ₀ + -(Q / |Q|) * t)) u ^ 2 < 1 := by
      have : 2 * Q * (-(Q / |Q|) * Real.sin t) = -2 * |Q| * Real.sin t := by
        rw [show 2 * Q * (-(Q / |Q|) * Real.sin t) = -2 * (Q * (Q / |Q|)) * Real.sin t by ring, hQQ]
      rw [h, this]
      have hPlo : -1 ≤ ζ.re := by nlinarith [sq_nonneg ζ.im, sq_nonneg (ζ.re + 1)]
      have e1 : 2 * (1 - ζ.re) * (1 - Real.cos t) ≤ 2 * t ^ 2 := by nlinarith
      have e2 : 2 * |Q| * (2 / π * t) ≤ 2 * |Q| * Real.sin t := by nlinarith
      have e3 : 2 * t ^ 2 < 2 * |Q| * (2 / π * t) := by
        have : t * π < 2 * |Q| := by rwa [lt_div_iff₀ hπ] at ht2
        have : 2 * t ^ 2 * π < 2 * |Q| * (2 * t) := by nlinarith [ht.1]
        rw [show 2 * |Q| * (2 / π * t) = 2 * |Q| * (2 * t) / π by ring, lt_div_iff₀ hπ]; linarith
      linarith
    have := dist_nonneg (x := ringPt y (φ₀ + -(Q / |Q|) * t)) (y := u)
    nlinarith
  · have h := hd (-(-(Q / |Q|)) * t)
    rw [neg_neg] at h
    have hcos' : Real.cos (Q / |Q| * t) = Real.cos t := by
      rcases lt_or_gt_of_ne hQ with h' | h'
      · rw [abs_of_neg h', div_neg, div_self hQ, neg_one_mul, Real.cos_neg]
      · rw [abs_of_pos h', div_self hQ, one_mul]
    have hsin' : Real.sin (Q / |Q| * t) = Q / |Q| * Real.sin t := by
      rcases lt_or_gt_of_ne hQ with h' | h'
      · rw [abs_of_neg h', div_neg, div_self hQ, neg_one_mul, neg_one_mul, Real.sin_neg]
      · rw [abs_of_pos h', div_self hQ, one_mul, one_mul]
    rw [hcos', hsin'] at h
    have hgt : 1 < dist (ringPt y (φ₀ - -(Q / |Q|) * t)) u ^ 2 := by
      rw [show φ₀ - -(Q / |Q|) * t = φ₀ + Q / |Q| * t by ring, h]
      have : 2 * Q * (Q / |Q| * Real.sin t) = 2 * |Q| * Real.sin t := by
        rw [show 2 * Q * (Q / |Q| * Real.sin t) = 2 * (Q * (Q / |Q|)) * Real.sin t by ring, hQQ]
      rw [this]
      have : 0 ≤ 2 * (1 - ζ.re) * (1 - Real.cos t) := by
        apply mul_nonneg (mul_nonneg (by norm_num) (by linarith)) (by linarith)
      nlinarith
    have := dist_nonneg (x := ringPt y (φ₀ - -(Q / |Q|) * t)) (y := u)
    nlinarith

/-- **One half of `ω(y)` at `x`** (child of N3-II): if the points of `ω(y)` just on one side of `x` lie in an open set `A`, then near
`x` either some interior point of `A` has a colour outside `{a, b}`, or `y` is the centre of a both-kind arc. A half avoiding interior
points lies in `Γ`, and a sub-arc of it with constant sides (`exists_isRingArc_of_subset_Γ`) has side colours from `{a, b}` (then
both-kind, `a, b` carried at `y`) or one outside; an interior point of the half has a colour outside `{a, b}` by N-E1 at `y`. -/
theorem half_colour_or_bothKind (hF : F.Valid) {x y : ℂ} (hxy : dist x y = 1) {a b : Fin k}
    (hay : a ∈ F.coloursAt y) (hby : b ∈ F.coloursAt y) {A : Set ℂ} (hA : IsOpen A) {σ t₀ : ℝ} (hσ : σ = 1 ∨ σ = -1)
    (ht₀ : 0 < t₀) (hhalf : ∀ t ∈ Ioo 0 t₀, ringPt y (arg (x - y) + σ * t) ∈ A) {ε : ℝ} (hε : 0 < ε)
    (hdom : ball x ε ⊆ F.dom) :
    (∃ θ₁ θ₂, F.BothKind y θ₁ θ₂) ∨ ∃ z ∈ F.interiorPts ∩ ball x ε ∩ A, F.col z ≠ a ∧ F.col z ≠ b := by
  set φ₀ := arg (x - y) with hφ₀
  have hx0 : ringPt y φ₀ = x := ringPt_arg_sub hxy
  set t₂ := min (t₀ / 2) (ε / 2) with ht₂
  have ht₂0 : 0 < t₂ := lt_min (by linarith) (by linarith)
  set t₁ := t₂ / 2 with ht₁
  -- the closed arc `{φ₀ + σ t : t ∈ [t₁, t₂]}`, in `A ∩ B(x, ε)`
  have hpt : ∀ t ∈ Icc t₁ t₂, ringPt y (φ₀ + σ * t) ∈ ball x ε ∩ A := by
    intro t ht
    refine ⟨?_, hhalf t ⟨by linarith [ht.1], by linarith [ht.2, min_le_left (t₀ / 2) (ε / 2)]⟩⟩
    rw [mem_ball, ← hx0]
    refine (dist_ringPt_ringPt_le y _ _).trans_lt ?_
    have : |φ₀ + σ * t - φ₀| = t := by
      rcases hσ with rfl | rfl <;> simp [abs_of_pos (show 0 < t by linarith [ht.1])]
    rw [this]; linarith [ht.2, min_le_right (t₀ / 2) (ε / 2)]
  -- the arc as `ringArc y θ₁ θ₂`
  obtain ⟨θ₁, θ₂, h12, harc⟩ : ∃ θ₁ θ₂, θ₁ < θ₂ ∧ ∀ θ ∈ Icc θ₁ θ₂, ringPt y θ ∈ ball x ε ∩ A := by
    rcases hσ with rfl | rfl
    · refine ⟨φ₀ + t₁, φ₀ + t₂, by linarith, fun θ hθ => ?_⟩
      have := hpt (θ - φ₀) ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
      rwa [show φ₀ + 1 * (θ - φ₀) = θ by ring] at this
    · refine ⟨φ₀ - t₂, φ₀ - t₁, by linarith, fun θ hθ => ?_⟩
      have := hpt (φ₀ - θ) ⟨by linarith [hθ.2], by linarith [hθ.1]⟩
      rwa [show φ₀ + -1 * (φ₀ - θ) = θ by ring] at this
  by_cases hΓ : ringArc y θ₁ θ₂ ⊆ F.Γ
  · obtain ⟨α, β, c, c', hα, hαβ, hβ, hR⟩ := exists_isRingArc_of_subset_Γ h12 hΓ
    set m := (α + β) / 2 with hm
    have hmI : m ∈ Ioo α β := ⟨by linarith, by linarith⟩
    have hmA := harc m ⟨by linarith, by linarith⟩
    have hopen : IsOpen (ball x ε ∩ A) := isOpen_ball.inter hA
    -- a side colour has points of its class in `B(x, ε) ∩ A`
    have hnear : ∀ j, ringPt y m ∈ closure (F.region j) → ∃ z ∈ F.interiorPts ∩ ball x ε ∩ A, F.col z = j := by
      intro j hj
      obtain ⟨z, hzO, hz⟩ := mem_closure_iff.mp hj _ hopen hmA
      exact ⟨z, ⟨⟨hz.1, hzO.1⟩, hzO.2⟩, hz.2⟩
    have hc : ringPt y m ∈ closure (F.region c) := by
      have : c ∈ F.innerColours y (ringPt y m) := by rw [(hR.2.2 m hmI).1]; rfl
      exact closure_mono inter_subset_left this
    have hc' : ringPt y m ∈ closure (F.region c') := by
      have : c' ∈ F.outerColours y (ringPt y m) := by rw [(hR.2.2 m hmI).2]; rfl
      exact closure_mono sdiff_subset this
    by_cases hcab : (c = a ∨ c = b) ∧ (c' = a ∨ c' = b)
    · left
      refine ⟨α, β, c, c', hR, ?_, ?_⟩
      · rcases hcab.1 with rfl | rfl <;> assumption
      · rcases hcab.2 with rfl | rfl <;> assumption
    · right
      rw [not_and_or] at hcab
      rcases hcab with h | h
      · obtain ⟨z, hz, hzc⟩ := hnear c hc
        push Not at h
        exact ⟨z, hz, hzc ▸ h.1, hzc ▸ h.2⟩
      · obtain ⟨z, hz, hzc⟩ := hnear c' hc'
        push Not at h
        exact ⟨z, hz, hzc ▸ h.1, hzc ▸ h.2⟩
  · right
    obtain ⟨_, ⟨θ, hθ, rfl⟩, hnot⟩ := not_subset.mp hΓ
    have hmem := harc θ hθ
    have hI : ringPt y θ ∈ F.interiorPts := ⟨hdom hmem.1, fun h => hnot ⟨hdom hmem.1, h⟩⟩
    refine ⟨ringPt y θ, ⟨⟨hI, hmem.1⟩, hmem.2⟩, fun h => ?_, fun h => ?_⟩
    · exact ne1_region hF hay ⟨hI, h⟩ (dist_ringPt y θ)
    · exact ne1_region hF hby ⟨hI, h⟩ (dist_ringPt y θ)

end ArcMap

/-! ## Moving a unit pair along two unit circles (children of FS112-N3-PAIRS (i), FS131-I4l) -/

/-- **Two points at unit distance from `u` and from each other, the second at distance `2` from `u`**: the first is the midpoint
(child of N3-I; Apollonius: `|x − (u + y)/2|² = |x − u|²/2 + |x − y|²/2 − |u − y|²/4 = 0`). -/
theorem eq_midpoint_of_dist {u x y : ℂ} (hx : dist x u = 1) (hxy : dist x y = 1) (hy : dist y u = 2) : x = (u + y) / 2 := by
  have hsq : ∀ z w : ℂ, dist z w ^ 2 = (z.re - w.re) ^ 2 + (z.im - w.im) ^ 2 := by
    intro z w; rw [Complex.dist_eq, Complex.sq_norm, Complex.normSq_apply]; simp only [Complex.sub_re, Complex.sub_im]; ring
  have e1 := hsq x u
  have e2 := hsq x y
  have e3 := hsq y u
  rw [hx] at e1; rw [hxy] at e2; rw [hy] at e3
  have h0 : (x.re - (u.re + y.re) / 2) ^ 2 + (x.im - (u.im + y.im) / 2) ^ 2 = 0 := by
    linear_combination (-(1 : ℝ) / 2) * e1 + (-(1 : ℝ) / 2) * e2 + (1 / 4 : ℝ) * e3
  have hre : x.re - (u.re + y.re) / 2 = 0 := by
    nlinarith [sq_nonneg (x.re - (u.re + y.re) / 2), sq_nonneg (x.im - (u.im + y.im) / 2)]
  have him : x.im - (u.im + y.im) / 2 = 0 := by
    nlinarith [sq_nonneg (x.re - (u.re + y.re) / 2), sq_nonneg (x.im - (u.im + y.im) / 2)]
  apply Complex.ext
  · simp only [Complex.div_ofNat_re, Complex.add_re]; linarith
  · simp only [Complex.div_ofNat_im, Complex.add_im]; linarith

/-- **A unit circle meets a circle of radius `1/2` in finitely many points** (child of N3-I; wave 3's
`Arc.finite_inter_sphere_or_eq_circ` on the whole circle of radius `1/2`, which is no arc of a unit circle). -/
theorem finite_sphere_inter_sphere_half (u m : ℂ) : {z | dist z u = 1 ∧ dist z m = 1 / 2}.Finite := by
  have hπ := Real.pi_pos
  rcases Arc.finite_inter_sphere_or_eq_circ (Arc.circ m (1 / 2) (-π) π) ⟨by norm_num, by linarith, by linarith⟩ u with
    h | ⟨θ₀, θ₁, h⟩
  · refine h.subset ?_
    rintro z ⟨hzu, hzm⟩
    refine ⟨⟨arg (z - m), ⟨(neg_pi_lt_arg _).le, arg_le_pi _⟩, ?_⟩, by rw [mem_sphere]; exact hzu⟩
    have h := eq_polar_arg (z - m)
    rw [← dist_eq_norm, hzm] at h
    show m + ((1 / 2 : ℝ) : ℂ) * e (arg (z - m)) = z
    linear_combination -h
  · injection h with h1 h2
    norm_num at h2

/-- **A point of an open interval whose ring point avoids a countable set** (child of N3-I: the angles of the set's points are
countably many, `countable_ringPt_preimage`, and an open interval has positive length). -/
theorem exists_mem_Ioo_ringPt_not_mem {B : Set ℂ} (hB : B.Countable) (p : ℂ) {a b : ℝ} (hab : a < b) :
    ∃ θ ∈ Ioo a b, ringPt p θ ∉ B := by
  by_contra hno
  push Not at hno
  have hS : (ringPt p ⁻¹' B).Countable := by
    have : ringPt p ⁻¹' B = ⋃ c ∈ B, ringPt p ⁻¹' {c} := by ext θ; simp
    rw [this]; exact hB.biUnion fun c _ => ArcMap.countable_ringPt_preimage p c
  have h0 := (hS.mono fun θ hθ => hno θ hθ).measure_zero MeasureTheory.volume
  rw [Real.volume_Ioo, ENNReal.ofReal_eq_zero] at h0
  linarith

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **Near a point of `ω(u)` whose pseudo-colour is `{a}`, every point of `ω(u)` lies in the closure of `a`'s class** (child of N3-I):
an interior point of `ω(u)` near `y` has a colour of `y` that `u` does not carry (N-E1 at `u`), so `a`; an arc of `Γ` on `ω(u)` near `y`
holds a ring arc with constant sides (`exists_isRingArc_of_subset_Γ`) whose side colours are colours of `y`, both carried at `u` only if
the arc is both-kind (NOBOTH: then `u` would not be cubic trichromatic), so one is `a`. The points of `ω(u)` near `y` in the closure
are dense there, and the closure is closed. -/
theorem mem_closure_region_of_pseudo (hF : F.Valid) {u y : ℂ} (hu : F.IsCubicTrichromatic u) (hc : F.Covers u 1)
    (hy : dist y u = 1) {a : Fin k} (hay : F.pseudoColours u y = {a}) :
    ∃ r > 0, ∀ y', dist y' u = 1 → dist y' y < r → y' ∈ closure (F.region a) := by
  have hud : u ∈ F.dom := hc (mem_closedBall_self zero_le_one)
  have hyd : y ∈ F.dom := hc (by rw [mem_closedBall, hy])
  obtain ⟨r, hr, hrdom, hrcol⟩ := F.exists_ball_col_mem_coloursAt hyd
  have hmem : ∀ c, c ∈ F.pseudoColours u y ↔ c = a := fun c => by rw [hay]; rfl
  -- a colour not carried at `u` at a point near `y` is `a`
  have hnear : ∀ z ∈ ball y r, ∀ c ∈ F.coloursAt z, c ∉ F.coloursAt u → c = a := by
    intro z hz c hcz hcu
    obtain ⟨w, hwball, hwreg⟩ := mem_closure_iff.mp hcz (ball y r) isOpen_ball hz
    have hcy : c ∈ F.coloursAt y := by
      have := hrcol w ⟨hwreg.1, hwball⟩
      rwa [hwreg.2] at this
    exact (hmem c).mp ⟨hcy, hcu⟩
  have hnot : ¬ (4 ≤ (F.coloursAt u).ncard ∨ F.HasRepeatedColour u) := by
    rintro (h | h)
    · rw [hu.2] at h; norm_num at h
    · exact hu.not_hasRepeatedColour hud h
  -- every closed sub-arc of `ω(u)` near `y` meets the closure of `a`'s class
  have harc : ∀ θ₁ θ₂, θ₁ < θ₂ → ringArc u θ₁ θ₂ ⊆ ball y r →
      ∃ θ ∈ Icc θ₁ θ₂, ringPt u θ ∈ closure (F.region a) := by
    intro θ₁ θ₂ h12 hsub
    by_cases hΓ : ringArc u θ₁ θ₂ ⊆ F.Γ
    · obtain ⟨α, β, c, c', hα, hαβ, hβ, hR⟩ := exists_isRingArc_of_subset_Γ h12 hΓ
      set m := (α + β) / 2 with hm
      have hmI : m ∈ Ioo α β := ⟨by linarith, by linarith⟩
      have hmb : ringPt u m ∈ ball y r := hsub ⟨m, ⟨by linarith, by linarith⟩, rfl⟩
      have hc0 : c ∈ F.coloursAt (ringPt u m) := by
        have : c ∈ F.innerColours u (ringPt u m) := by rw [(hR.2.2 m hmI).1]; rfl
        exact closure_mono inter_subset_left this
      have hc0' : c' ∈ F.coloursAt (ringPt u m) := by
        have : c' ∈ F.outerColours u (ringPt u m) := by rw [(hR.2.2 m hmI).2]; rfl
        exact closure_mono sdiff_subset this
      refine ⟨m, ⟨by linarith, by linarith⟩, ?_⟩
      by_cases hcu : c ∈ F.coloursAt u
      · by_cases hcu' : c' ∈ F.coloursAt u
        · exact absurd (noBoth hF hud ⟨c, c', hR, hcu, hcu'⟩) hnot
        · rw [← hnear _ hmb c' hc0' hcu']; exact hc0'
      · rw [← hnear _ hmb c hc0 hcu]; exact hc0
    · obtain ⟨_, ⟨θ, hθ, rfl⟩, hnotΓ⟩ := not_subset.mp hΓ
      have hb := hsub ⟨θ, hθ, rfl⟩
      have hI : ringPt u θ ∈ F.interiorPts := ⟨hrdom hb, fun h => hnotΓ ⟨hrdom hb, h⟩⟩
      refine ⟨θ, hθ, subset_closure ⟨hI, ?_⟩⟩
      have hcu : F.col (ringPt u θ) ∉ F.coloursAt u := fun h =>
        ne1_region hF h ⟨hI, rfl⟩ (dist_ringPt u θ)
      exact hnear _ hb _ (subset_closure ⟨hI, rfl⟩) hcu
  refine ⟨r, hr, fun y' hy' hyr => ?_⟩
  rw [← closure_closure, Metric.mem_closure_iff]
  intro ε hε
  have hy'eq : ringPt u (arg (y' - u)) = y' := ringPt_arg_sub hy'
  set θ' := arg (y' - u) with hθ'
  set δ := min (ε / 2) ((r - dist y' y) / 2) with hδ
  have hδ0 : 0 < δ := lt_min (by linarith) (by linarith)
  have hδ1 := min_le_left (ε / 2) ((r - dist y' y) / 2)
  have hδ2 := min_le_right (ε / 2) ((r - dist y' y) / 2)
  have hsub : ringArc u θ' (θ' + δ) ⊆ ball y r := by
    rintro _ ⟨φ, hφ, rfl⟩
    rw [mem_ball]
    have h1 := dist_ringPt_ringPt_le u φ θ'
    rw [hy'eq] at h1
    have h2 : |φ - θ'| ≤ δ := by rw [abs_le]; constructor <;> linarith [hφ.1, hφ.2]
    have := dist_triangle (ringPt u φ) y' y
    linarith
  obtain ⟨θ, hθ, hcl⟩ := harc θ' (θ' + δ) (by linarith) hsub
  refine ⟨ringPt u θ, hcl, ?_⟩
  have h1 := dist_ringPt_ringPt_le u θ' θ
  rw [hy'eq] at h1
  have h2 : |θ' - θ| ≤ δ := by rw [abs_le]; constructor <;> linarith [hθ.1, hθ.2]
  linarith

/-- **The strip fails at finitely many points of `ω(u)`** (child of N3-I): at a cubic trichromatic `u`, a point `q ∈ ω(u)` where the
strip fails is `u + I κ e(β)` for a germ `(β, κ)` of the chart at `u` with `κ = ±1` — four radii and three germs give one germ with
branch points on `ω(q)` at two radii (`exists_branch_on_circle_of_not_stripHolds`), and then `e β = I κ (u − q)`
(`germ_eq_of_two_on_circle`). -/
theorem finite_not_stripHolds (hF : F.Valid) {u : ℂ} (hu : F.IsCubicTrichromatic u) (hc : F.Covers u 1) :
    {q | dist q u = 1 ∧ ¬ F.StripHolds u q}.Finite := by
  have hud : u ∈ F.dom := hc (mem_closedBall_self zero_le_one)
  obtain ⟨r₀, G, hC, hdisj, f, -, hsec, hcol⟩ := hu.chart hud
  have hord := G.dir_lt_nextDir hC.sorted hC.curv hdisj
  have hr0 := hC.pos
  refine (Set.finite_range fun g : Fin 3 => u + I * (G.κ g : ℂ) * e (G.β g)).subset ?_
  rintro q ⟨hq, hs⟩
  have hrad : ∀ m : Fin 4, r₀ * ((m : ℝ) + 1) / 5 ∈ Ioo 0 r₀ := fun m => by
    have hm : (m : ℝ) ≤ 3 := by exact_mod_cast Nat.lt_succ_iff.mp m.isLt
    refine ⟨by positivity, ?_⟩
    rw [div_lt_iff₀ (by norm_num)]; nlinarith
  choose l hl using fun m : Fin 4 => exists_branch_on_circle_of_not_stripHolds hF hC hord hsec hcol hs (hrad m)
  obtain ⟨m₁, m₂, hm, hlm⟩ := Fintype.exists_ne_map_eq_of_card_lt l (by simp)
  set k₀ := l m₁ with hk₀
  have hcurv : ∀ s ∈ Ioo 0 r₀, |G.κ k₀| * s ≤ 2 := fun s hs' =>
    (mul_le_mul_of_nonneg_left hs'.2.le (abs_nonneg _)).trans (hC.curv k₀).le
  have hs12 : r₀ * ((m₁ : ℝ) + 1) / 5 ≠ r₀ * ((m₂ : ℝ) + 1) / 5 := by
    intro h
    have h' : r₀ * ((m₁ : ℝ) + 1) = r₀ * ((m₂ : ℝ) + 1) := by linarith
    have h'' := mul_left_cancel₀ hr0.ne' h'
    apply hm; ext; exact_mod_cast (by linarith : (m₁ : ℝ) = m₂)
  have hl2 := hl m₂
  rw [← hlm] at hl2
  have huq : dist u q = 1 := by rw [dist_comm]; exact hq
  obtain ⟨hσ, hβ⟩ := germ_eq_of_two_on_circle huq (hrad m₁).1 (hrad m₂).1 hs12 (hcurv _ (hrad m₁)) (hcurv _ (hrad m₂))
    (hl m₁) hl2
  refine ⟨k₀, ?_⟩
  have hκ : ((G.κ k₀ : ℝ) : ℂ) ^ 2 = 1 := by rcases hσ with h | h <;> rw [h] <;> norm_num
  show u + I * (G.κ k₀ : ℂ) * e (G.β k₀) = q
  rw [hβ]
  linear_combination (u - q) * ((G.κ k₀ : ℝ) : ℂ) ^ 2 * Complex.I_sq - (u - q) * hκ

/-- **N3-I where `ω(x)` crosses `ω(u₂)` transversally at `y`** (child of FS112-N3-PAIRS (i), `|x − u₂| ≠ 2`). Move `x` to a nearby
`x′ ∈ ω(u₁)` where the strip holds and whose partner cannot be tangent (the bad points are finitely many:
`finite_not_stripHolds`, `finite_sphere_inter_sphere_half`); the intermediate value theorem along `ω(u₂)` near `y` gives `y′` with
`|x′ − y′| = 1`, in the closure of `a`'s class (`mem_closure_region_of_pseudo`). On the strip's side of `ω(u₁)` near `x′` every interior
point has colour `a`, so that side is an open set inside the closure of `a`'s class, and `ω(y′)`, transversal at `x′`, enters it at a
point at distance exactly `1` from `y′` (`Valid.dist_ne_one_of_isOpen_subset_closure`). -/
theorem pair_i_of_transversal (hF : F.Valid) {u₁ u₂ x y : ℂ} (h₁ : F.IsCubicTrichromatic u₁) (h₂ : F.IsCubicTrichromatic u₂)
    (hc₁ : F.Covers u₁ 1) (hc₂ : F.Covers u₂ 1) (hx : dist x u₁ = 1) (hy : dist y u₂ = 1) (hxy : dist x y = 1) {a : Fin k}
    (hax : F.pseudoColours u₁ x = {a}) (hay : F.pseudoColours u₂ y = {a}) (htx : dist x u₂ ≠ 2) : False := by
  have hmemx : ∀ c, c ∈ F.pseudoColours u₁ x ↔ c = a := fun c => by rw [hax]; rfl
  have hmemy : ∀ c, c ∈ F.pseudoColours u₂ y ↔ c = a := fun c => by rw [hay]; rfl
  have hax' := (hmemx a).mpr rfl
  have hay' := (hmemy a).mpr rfl
  -- `y ≠ u₁` and `x ≠ u₂`: `a` is carried at `y` and at `x`, at neither centre
  have hyu₁ : y ≠ u₁ := by rintro rfl; exact hax'.2 hay'.1
  have hxu₂ : x ≠ u₂ := by rintro rfl; exact hay'.2 hax'.1
  have hxd : x ∈ F.dom := hc₁ (by rw [mem_closedBall, hx])
  obtain ⟨r₁, hr₁, hr₁dom, hr₁col⟩ := F.exists_ball_col_mem_coloursAt hxd
  have hcolA : ∀ z ∈ F.interiorPts ∩ ball x r₁, F.col z ∉ F.coloursAt u₁ → F.col z = a := fun z hz hzu =>
    (hmemx _).mp ⟨hr₁col z hz, hzu⟩
  obtain ⟨r₂, hr₂, hr₂cl⟩ := mem_closure_region_of_pseudo hF h₂ hc₂ hy hay
  -- `ω(x)` crosses `ω(u₂)` transversally at `y`
  have hyx : dist y x = 1 := by rw [dist_comm]; exact hxy
  obtain ⟨σ, hσ, t₀, ht₀, hside⟩ := exists_side_germs_of_transversal hyx hy (Ne.symm hxu₂) (by rwa [dist_comm])
  have hy0 : ringPt u₂ (arg (y - u₂)) = y := ringPt_arg_sub hy
  set φ₀ := arg (y - u₂) with hφ₀
  have hdyu : 0 < dist y u₁ := dist_pos.mpr hyu₁
  set t₁ := min (t₀ / 2) (min (r₂ / 2) (dist y u₁ / 2)) with ht₁
  have hm1 := min_le_left (t₀ / 2) (min (r₂ / 2) (dist y u₁ / 2))
  have hm2 := min_le_right (t₀ / 2) (min (r₂ / 2) (dist y u₁ / 2))
  have hm3 := min_le_left (r₂ / 2) (dist y u₁ / 2)
  have hm4 := min_le_right (r₂ / 2) (dist y u₁ / 2)
  have ht₁0 : 0 < t₁ := lt_min (by linarith) (lt_min (by linarith) (by linarith))
  obtain ⟨hplus0, hminus0⟩ := hside t₁ ⟨ht₁0, by linarith⟩
  set dP := dist (ringPt u₂ (φ₀ + σ * t₁)) x with hdP
  set dM := dist (ringPt u₂ (φ₀ - σ * t₁)) x with hdM
  set η := min (min ((1 - dP) / 2) ((dM - 1) / 2)) (r₁ / 2) with hη
  have hη1 := min_le_left (min ((1 - dP) / 2) ((dM - 1) / 2)) (r₁ / 2)
  have hη2 := min_le_right (min ((1 - dP) / 2) ((dM - 1) / 2)) (r₁ / 2)
  have hη3 := min_le_left ((1 - dP) / 2) ((dM - 1) / 2)
  have hη4 := min_le_right ((1 - dP) / 2) ((dM - 1) / 2)
  have hη0 : 0 < η := lt_min (lt_min (by linarith) (by linarith)) (by linarith)
  have hx0 : ringPt u₁ (arg (x - u₁)) = x := ringPt_arg_sub hx
  set θ₀ := arg (x - u₁) with hθ₀
  -- the bad points of `ω(u₁)`: where the strip fails, and where a partner on `ω(u₂)` would be tangent
  set B : Set ℂ := {q | dist q u₁ = 1 ∧ ¬ F.StripHolds u₁ q} ∪ {z | dist z u₁ = 1 ∧ dist z ((u₁ + u₂) / 2) = 1 / 2} with hB
  have hBc : B.Countable :=
    ((finite_not_stripHolds hF h₁ hc₁).union (finite_sphere_inter_sphere_half u₁ ((u₁ + u₂) / 2))).countable
  obtain ⟨θ, hθ, hθB⟩ := exists_mem_Ioo_ringPt_not_mem hBc u₁ (show θ₀ - η < θ₀ + η by linarith)
  have hx'u : dist (ringPt u₁ θ) u₁ = 1 := dist_ringPt u₁ θ
  have hx'x : dist (ringPt u₁ θ) x < η := by
    have h1 := dist_ringPt_ringPt_le u₁ θ θ₀
    rw [hx0] at h1
    have : |θ - θ₀| < η := by rw [abs_lt]; constructor <;> linarith [hθ.1, hθ.2]
    linarith
  set x' := ringPt u₁ θ with hx'
  -- the partner `y'` on `ω(u₂)` near `y`, by the intermediate value theorem
  have hcont : Continuous fun t : ℝ => dist (ringPt u₂ (φ₀ + σ * t)) x' := by
    unfold ringPt e; fun_prop
  have hplus : dist (ringPt u₂ (φ₀ + σ * t₁)) x' < 1 := by
    have := dist_triangle (ringPt u₂ (φ₀ + σ * t₁)) x x'
    rw [dist_comm x x'] at this
    linarith
  have hminus : 1 < dist (ringPt u₂ (φ₀ + σ * -t₁)) x' := by
    have := dist_triangle (ringPt u₂ (φ₀ - σ * t₁)) x' x
    rw [show φ₀ + σ * -t₁ = φ₀ - σ * t₁ by ring]
    linarith
  obtain ⟨t, htI, ht⟩ : ∃ t ∈ Icc (-t₁) t₁, dist (ringPt u₂ (φ₀ + σ * t)) x' = 1 :=
    intermediate_value_Icc' (show -t₁ ≤ t₁ by linarith) hcont.continuousOn ⟨hplus.le, hminus.le⟩
  have hy'u : dist (ringPt u₂ (φ₀ + σ * t)) u₂ = 1 := dist_ringPt u₂ _
  have hy'y : dist (ringPt u₂ (φ₀ + σ * t)) y ≤ t₁ := by
    have h1 := dist_ringPt_ringPt_le u₂ (φ₀ + σ * t) φ₀
    rw [hy0] at h1
    have h2 : |φ₀ + σ * t - φ₀| ≤ t₁ := by
      rw [show φ₀ + σ * t - φ₀ = σ * t by ring, abs_mul]
      have : |σ| = 1 := by rcases hσ with rfl | rfl <;> norm_num
      rw [this, one_mul, abs_le]; exact ⟨htI.1, htI.2⟩
    linarith
  set y' := ringPt u₂ (φ₀ + σ * t) with hy'
  have hy'cl : y' ∈ closure (F.region a) := hr₂cl y' hy'u (by linarith)
  have hy'u₁ : y' ≠ u₁ := by
    intro h
    rw [h, dist_comm] at hy'y
    linarith
  have hx'y' : dist x' y' = 1 := by rw [dist_comm]; exact ht
  have hy'2 : dist y' u₁ ≠ 2 := by
    intro h2
    apply hθB
    right
    refine ⟨hx'u, ?_⟩
    have hmid := eq_midpoint_of_dist hx'u hx'y' h2
    show dist x' ((u₁ + u₂) / 2) = 1 / 2
    rw [hmid, dist_eq_norm, show (u₁ + y') / 2 - (u₁ + u₂) / 2 = (y' - u₂) / 2 by ring, norm_div, ← dist_eq_norm, hy'u]
    norm_num
  have hstrip : F.StripHolds u₁ x' := by
    by_contra hns
    exact hθB (Or.inl ⟨hx'u, hns⟩)
  -- the strip at `x'`: one side of `ω(u₁)` near `x'` has only `a`
  obtain ⟨ε, hε, hS⟩ := hstrip
  set ε' := min ε (r₁ / 2) with hε'
  have hε'1 := min_le_left ε (r₁ / 2)
  have hε'2 := min_le_right ε (r₁ / 2)
  have hε'0 : 0 < ε' := lt_min hε (by linarith)
  have hballx : ball x' ε' ⊆ ball x r₁ := by
    intro z hz
    rw [mem_ball] at hz ⊢
    have := dist_triangle z x' x
    linarith
  -- `ω(y')` crosses `ω(u₁)` transversally at `x'`
  obtain ⟨σ', hσ', t₀', ht₀', hside'⟩ := exists_side_germs_of_transversal hx'u hx'y' hy'u₁ hy'2
  have hx'0 : ringPt y' (arg (x' - y')) = x' := ringPt_arg_sub hx'y'
  set ψ := arg (x' - y') with hψ
  set τ := min (t₀' / 2) (ε' / 2) with hτ
  have hτ1 := min_le_left (t₀' / 2) (ε' / 2)
  have hτ2 := min_le_right (t₀' / 2) (ε' / 2)
  have hτ0 : 0 < τ := lt_min (by linarith) (by linarith)
  obtain ⟨hin', hout'⟩ := hside' τ ⟨hτ0, by linarith⟩
  have hσ'abs : |σ'| = 1 := by rcases hσ' with rfl | rfl <;> norm_num
  have hnear : ∀ s : ℝ, |s| ≤ τ → ringPt y' (ψ + s) ∈ ball x' ε' := by
    intro s hs
    rw [mem_ball]
    have h1 := dist_ringPt_ringPt_le y' (ψ + s) ψ
    rw [hx'0, show ψ + s - ψ = s by ring] at h1
    linarith
  -- an open side inside the closure of `a`'s class holds no point at distance `1` from `y'`
  have key : ∀ O : Set ℂ, IsOpen O → O ⊆ ball x' ε' → (∀ z ∈ F.interiorPts ∩ O, F.col z ∉ F.coloursAt u₁) →
      ∀ m ∈ O, dist m y' = 1 → False := by
    intro O hO hOsub hOcol m hm hmy
    have hOd : O ⊆ closure (F.region a) := by
      intro z hz
      have hzd : z ∈ F.dom := hr₁dom (hballx (hOsub hz))
      refine closure_mono ?_ (hO.inter_closure ⟨hz, F.dense_interiorPts hzd⟩)
      rintro w ⟨hwO, hwI⟩
      exact ⟨hwI, hcolA w ⟨hwI, hballx (hOsub hwO)⟩ (hOcol w ⟨hwI, hwO⟩)⟩
    exact hF.dist_ne_one_of_isOpen_subset_closure hy'cl hO hOd hm (by rw [dist_comm]; exact hmy)
  rcases hS with hin | hout
  · refine key (ball x' ε' ∩ ball u₁ 1) (isOpen_ball.inter isOpen_ball) inter_subset_left ?_ (ringPt y' (ψ + σ' * τ))
      ⟨hnear _ (by rw [abs_mul, hσ'abs, one_mul, abs_of_pos hτ0]), by rw [mem_ball]; exact hin'⟩ (dist_ringPt _ _)
    rintro z ⟨hzI, hzb, hzu⟩
    exact hin z ⟨⟨hzI, ball_subset_ball hε'1 hzb⟩, hzu⟩
  · refine key (ball x' ε' \ closedBall u₁ 1) (isOpen_ball.sdiff isClosed_closedBall) sdiff_subset ?_
      (ringPt y' (ψ - σ' * τ))
      ⟨by rw [sub_eq_add_neg]; exact hnear _ (by rw [abs_neg, abs_mul, hσ'abs, one_mul, abs_of_pos hτ0]), ?_⟩
      (dist_ringPt _ _)
    · rintro z ⟨hzI, hzb, hzu⟩
      exact hout z ⟨⟨hzI, ball_subset_ball hε'1 hzb⟩, hzu⟩
    · rw [mem_closedBall, not_le]; exact hout'

/-! ## FS112-N3-PAIRS -/

/-- **FS112-N3-PAIRS** (i), N3-I (CB's (i) never fails): for cubic trichromatic `u₁`, `u₂` at distance below `3` and a unit pair
`x ∈ ω(u₁)`, `y ∈ ω(u₂)`, the pseudo-colours `c′(x) = c′(y) = {a}` are impossible (`u₁ = u₂` allowed). The hypothesis `h3 : dist u₁ u₂ < 3`
(inventory item 258) excludes exactly the isolated unit pair — `u₁, x, y, u₂` collinear at spacing `1`, where N3-I's perturbation has no
nearby pair to move to (FS131-I4k, item 257); beyond `3` there is no unit pair. Inhabitant of `IsCubicTrichromatic` on a valid map of the plane: `sevenBrick_corner_isCubicTrichromatic` (`Plane/SVMap`). -/
theorem pair_i (hF : F.Valid) {u₁ u₂ x y : ℂ} (h₁ : F.IsCubicTrichromatic u₁) (h₂ : F.IsCubicTrichromatic u₂)
    (hc₁ : F.Covers u₁ 1) (hc₂ : F.Covers u₂ 1) (h3 : dist u₁ u₂ < 3) (hx : dist x u₁ = 1) (hy : dist y u₂ = 1) (hxy : dist x y = 1) {a : Fin k}
    (hax : F.pseudoColours u₁ x = {a}) (hay : F.pseudoColours u₂ y = {a}) : False := by
  by_cases htx : dist x u₂ = 2
  · -- then `y` is the midpoint of `x` and `u₂`, so `ω(y)` crosses `ω(u₁)` transversally unless `|u₁ − u₂| = 3`
    have hty : dist y u₁ ≠ 2 := by
      intro hty
      have hm1 := eq_midpoint_of_dist hx hxy hty
      have hm2 := eq_midpoint_of_dist hy (by rw [dist_comm]; exact hxy) htx
      have : u₂ - u₁ = 3 * (y - x) := by
        have e1 : 2 * x = u₁ + y := by rw [hm1]; ring
        have e2 : 2 * y = u₂ + x := by rw [hm2]; ring
        linear_combination e1 - e2
      have h3' : dist u₁ u₂ = 3 := by
        rw [dist_comm, dist_eq_norm, this, norm_mul, ← dist_eq_norm, dist_comm, hxy]; norm_num
      linarith
    exact pair_i_of_transversal hF h₂ h₁ hc₂ hc₁ hy hx (by rw [dist_comm]; exact hxy) hay hax hty
  · exact pair_i_of_transversal hF h₁ h₂ hc₁ hc₂ hx hy hxy hax hay htx

/-- **FS112-N3-PAIRS** (ii), N3-II: for a unit pair `x ∈ ω(u₁)`, `y ∈ ω(u₂)` with `c′(x) = c′(y) = {a, b}` and `ω(y)` transversal
to `ω(u₁)` at `x` (`y ≠ u₁`, `|y − u₁| ≠ 2`), `x` carries at least four colours or `y` is the centre of a both-kind unit arc. Inhabitant: none named for the hypotheses at once. `sevenBrick_corner_isCubicTrichromatic` (`Plane/SVMap`) inhabits `IsCubicTrichromatic`
alone, on a valid map of the plane where the other hypotheses cannot hold with it: `sevenBrickMap` has no unit arc and no four-colour
point, so this theorem's conclusion is false there (FS131-QA4 § 4.1). The set is satisfiable only on a map with a unit arc ending at a
cubic vertex. -/
theorem pair_ii (hF : F.Valid) {u₁ u₂ x y : ℂ} (h₁ : F.IsCubicTrichromatic u₁) (_h₂ : F.IsCubicTrichromatic u₂)
    (hc₁ : F.Covers u₁ 1) (_hc₂ : F.Covers u₂ 1) (hx : dist x u₁ = 1) (_hy : dist y u₂ = 1) (hxy : dist x y = 1)
    (htr : y ≠ u₁ ∧ dist y u₁ ≠ 2) {a b : Fin k} (hab : a ≠ b) (hax : F.pseudoColours u₁ x = {a, b})
    (hay : F.pseudoColours u₂ y = {a, b}) :
    4 ≤ (F.coloursAt x).ncard ∨ ∃ θ₁ θ₂, F.BothKind y θ₁ θ₂ := by
  classical
  by_contra hno
  rw [not_or] at hno
  obtain ⟨h4, hboth⟩ := hno
  have hmemx : ∀ c, c ∈ F.pseudoColours u₁ x ↔ c = a ∨ c = b := fun c => by rw [hax]; simp
  have hmemy : ∀ c, c ∈ F.pseudoColours u₂ y ↔ c = a ∨ c = b := fun c => by rw [hay]; simp
  have hay' : a ∈ F.coloursAt y := ((hmemy a).mpr (Or.inl rfl)).1
  have hby' : b ∈ F.coloursAt y := ((hmemy b).mpr (Or.inr rfl)).1
  have hax' := (hmemx a).mpr (Or.inl rfl)
  have hbx' := (hmemx b).mpr (Or.inr rfl)
  have hxd : x ∈ F.dom := hc₁ (by rw [mem_closedBall, hx])
  obtain ⟨r, hr, hrdom, hrcol⟩ := F.exists_ball_col_mem_coloursAt hxd
  -- a colour near `x` outside `{a, b}` is a colour of `u₁`
  have hcu : ∀ z ∈ F.interiorPts ∩ ball x r, F.col z ≠ a → F.col z ≠ b → F.col z ∈ F.coloursAt u₁ := by
    intro z hz hza hzb
    by_contra hnot
    rcases (hmemx _).mp ⟨hrcol z hz, hnot⟩ with h | h
    · exact hza h
    · exact hzb h
  obtain ⟨σ, hσ, t₀, ht₀, hside⟩ := exists_side_germs_of_transversal hx hxy htr.1 htr.2
  have hσ' : -σ = 1 ∨ -σ = -1 := by rcases hσ with rfl | rfl <;> norm_num
  -- each side of `ω(u₁)` at `x` carries a colour of `u₁`
  have hsideCol : ∀ (A : Set ℂ), IsOpen A → ∀ τ, (τ = 1 ∨ τ = -1) →
      (∀ t ∈ Ioo 0 t₀, ringPt y (arg (x - y) + τ * t) ∈ A) → ∃ d ∈ F.coloursAt u₁, x ∈ closure (F.region d ∩ A) := by
    intro A hA τ hτ hhalf
    apply exists_colour_near
    intro ε hε
    rcases half_colour_or_bothKind hF hxy hay' hby' hA hτ ht₀ hhalf (lt_min hε hr)
        ((ball_subset_ball (min_le_right _ _)).trans hrdom) with hb | ⟨z, ⟨⟨hzI, hzb⟩, hzA⟩, hza, hzb'⟩
    · exact absurd hb hboth
    · have hzr : z ∈ ball x r := ball_subset_ball (min_le_right _ _) hzb
      exact ⟨z, ⟨⟨hzI, ball_subset_ball (min_le_left _ _) hzb⟩, hzA⟩, hcu z ⟨hzI, hzr⟩ hza hzb'⟩
  obtain ⟨d₁, hd₁u, hd₁⟩ := hsideCol (ball u₁ 1) isOpen_ball σ hσ fun t ht => by
    rw [mem_ball]; exact (hside t ht).1
  obtain ⟨d₂, hd₂u, hd₂⟩ := hsideCol (closedBall u₁ 1)ᶜ isClosed_closedBall.isOpen_compl (-σ) hσ' fun t ht => by
    rw [mem_compl_iff, mem_closedBall, not_le, show arg (x - y) + -σ * t = arg (x - y) - σ * t by ring]
    exact (hside t ht).2
  -- the two side colours differ: one sector cannot lie on both sides of `ω(x)`
  have hd12 : d₁ ≠ d₂ := by
    rintro rfl
    obtain ⟨r₀, G, hC, -, f, -, hsec, hcol⟩ := h₁.chart (hc₁ (mem_closedBall_self zero_le_one))
    obtain ⟨i, rfl⟩ := hcol d₁ hd₁u
    have hin := (closure_sector_subset_of_side hF hC hsec i).1 hd₁
    have hout := (closure_sector_subset_of_side hF hC hsec i).2 hd₂
    have hsph : G.sector u₁ r₀ i ⊆ sphere x 1 := fun w hw => by
      have h1 := hin (subset_closure hw)
      have h2 : 1 ≤ dist w x := hout (subset_closure hw)
      rw [mem_closedBall] at h1
      exact le_antisymm h1 h2
    have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
    have := (hC.isOpen r₀ hr₀ i).subset_interior_iff.mpr hsph
    rw [interior_sphere x one_ne_zero] at this
    obtain ⟨w, hw⟩ := hC.sector_nonempty hr₀ i
    exact this hw
  -- four colours at `x`
  apply h4
  have hsub : (({a, b, d₁, d₂} : Finset (Fin k)) : Set (Fin k)) ⊆ F.coloursAt x := by
    intro c hc
    simp only [Finset.coe_insert, Finset.coe_singleton, mem_insert_iff, mem_singleton_iff] at hc
    rcases hc with rfl | rfl | rfl | rfl
    · exact hax'.1
    · exact hbx'.1
    · exact closure_mono inter_subset_left hd₁
    · exact closure_mono inter_subset_left hd₂
  have hcard : ({a, b, d₁, d₂} : Finset (Fin k)).card = 4 := by
    have ha1 : a ≠ d₁ := fun h => hax'.2 (h ▸ hd₁u)
    have ha2 : a ≠ d₂ := fun h => hax'.2 (h ▸ hd₂u)
    have hb1 : b ≠ d₁ := fun h => hbx'.2 (h ▸ hd₁u)
    have hb2 : b ≠ d₂ := fun h => hbx'.2 (h ▸ hd₂u)
    rw [Finset.card_insert_of_notMem (by simp [hab, ha1, ha2]), Finset.card_insert_of_notMem (by simp [hb1, hb2]),
      Finset.card_insert_of_notMem (by simp [hd12]), Finset.card_singleton]
  have := Set.ncard_le_ncard hsub (Set.toFinite _)
  rwa [Set.ncard_coe_finset, hcard] at this

/-- **FS112-N3-PAIRS**, N3-P′: two cubic trichromatic vertices with one multicolour are never at distance `1`. Inhabitant of `IsCubicTrichromatic` on a valid map of the plane: `sevenBrick_corner_isCubicTrichromatic` (`Plane/SVMap`). -/
theorem pair_P' (hF : F.Valid) {u u' : ℂ} (_h : F.IsCubicTrichromatic u) (h' : F.IsCubicTrichromatic u') (hu : u ∈ F.dom)
    (hu' : u' ∈ F.dom) (hcol : F.coloursAt u = F.coloursAt u') : dist u u' ≠ 1 := by
  intro hd
  obtain ⟨r, hr, hrdom, hrcol⟩ := F.exists_ball_col_mem_coloursAt hu
  set θu := arg (u - u') with hθu
  have hu_eq : ringPt u' θu = u := ringPt_arg_sub hd
  -- `ω(u')` near `u` lies in `Γ`: an interior point there would carry a colour of `u'` at distance `1` from it (N-E1)
  have hnear : ∀ φ, |φ - θu| < r → ringPt u' φ ∈ ball u r := fun φ hφ => by
    rw [mem_ball, ← hu_eq]; exact (dist_ringPt_ringPt_le u' φ θu).trans_lt hφ
  have hΓ : ringArc u' θu (θu + r / 2) ⊆ F.Γ := by
    rintro _ ⟨φ, hφ, rfl⟩
    have hb := hnear φ (by rw [abs_lt]; constructor <;> linarith [hφ.1, hφ.2])
    have hdom := hrdom hb
    refine ⟨hdom, ?_⟩
    by_contra hnot
    have hI : ringPt u' φ ∈ F.interiorPts := ⟨hdom, hnot⟩
    have hc := hrcol _ ⟨hI, hb⟩
    rw [hcol] at hc
    exact ne1_region hF hc ⟨hI, rfl⟩ (dist_ringPt u' φ)
  obtain ⟨a, b, c, c', ha, hab, hb, hR⟩ := exists_isRingArc_of_subset_Γ (by linarith) hΓ
  -- the side colours are colours of `u`, hence of `u'`
  set m := (a + b) / 2 with hm
  have hmI : m ∈ Ioo a b := ⟨by linarith, by linarith⟩
  have hmb : dist (ringPt u' m) u < r / 2 + r / 4 := by
    rw [← hu_eq]
    have := dist_ringPt_ringPt_le u' m θu
    have : |m - θu| ≤ r / 2 := abs_le.mpr ⟨by linarith, by linarith⟩
    linarith
  have hside : ∀ j, ringPt u' m ∈ closure (F.region j) → j ∈ F.coloursAt u' := by
    intro j hj
    obtain ⟨z, hz, hzd⟩ := Metric.mem_closure_iff.mp hj (r / 4) (by linarith)
    have hzb : z ∈ ball u r := by
      rw [mem_ball]; linarith [dist_triangle z (ringPt u' m) u, dist_comm z (ringPt u' m)]
    have hzj : F.col z = j := hz.2
    rw [← hcol, ← hzj]; exact hrcol z ⟨hz.1, hzb⟩
  have hc : c ∈ F.coloursAt u' := by
    have : c ∈ F.innerColours u' (ringPt u' m) := by rw [(hR.2.2 m hmI).1]; rfl
    exact hside c (closure_mono inter_subset_left this)
  have hc' : c' ∈ F.coloursAt u' := by
    have : c' ∈ F.outerColours u' (ringPt u' m) := by rw [(hR.2.2 m hmI).2]; rfl
    exact hside c' (closure_mono sdiff_subset this)
  rcases noBoth hF hu' ⟨c, c', hR, hc, hc'⟩ with h4 | hrep
  · rw [h'.2] at h4; norm_num at h4
  · exact h'.not_hasRepeatedColour hu' hrep

/-! ## FS112-N3-FAIL -/

/-- **FS112-N3-FAIL**, the place: at a cubic trichromatic `u`, the strip fails at `q ∈ ω(u)` only when `q` is a leaving centre of
`u`. Inhabitant: none named for the hypotheses at once. `sevenBrick_corner_isCubicTrichromatic` (`Plane/SVMap`) inhabits `IsCubicTrichromatic`
alone, on a valid map of the plane where the other hypotheses cannot hold with it: `sevenBrickMap` has no unit arc and no four-colour
point, so this theorem's conclusion is false there (FS131-QA4 § 4.1). The set is satisfiable only on a map with a unit arc ending at a
cubic vertex. -/
theorem fail_leavingCentre (hF : F.Valid) {u q : ℂ} (hu : F.IsCubicTrichromatic u) (hc : F.Covers u 1) (hq : dist q u = 1)
    (hs : ¬ F.StripHolds u q) : F.IsLeavingCentre u q := by
  have hud : u ∈ F.dom := hc (mem_closedBall_self zero_le_one)
  obtain ⟨r₀, G, hC, hdisj, f, -, hsec, hcol⟩ := hu.chart hud
  have hord := G.dir_lt_nextDir hC.sorted hC.curv hdisj
  have hr0 := hC.pos
  -- four radii, three germs: one germ has branch points on `ω(q)` at two radii
  have hrad : ∀ m : Fin 4, r₀ * ((m : ℝ) + 1) / 5 ∈ Ioo 0 r₀ := fun m => by
    have hm : (m : ℝ) ≤ 3 := by exact_mod_cast Nat.lt_succ_iff.mp m.isLt
    refine ⟨by positivity, ?_⟩
    rw [div_lt_iff₀ (by norm_num)]; nlinarith
  choose l hl using fun m : Fin 4 => exists_branch_on_circle_of_not_stripHolds hF hC hord hsec hcol hs (hrad m)
  obtain ⟨m₁, m₂, hm, hlm⟩ := Fintype.exists_ne_map_eq_of_card_lt l (by simp)
  set k₀ := l m₁ with hk₀
  have hcurv : ∀ s ∈ Ioo 0 r₀, |G.κ k₀| * s ≤ 2 := fun s hs' =>
    (mul_le_mul_of_nonneg_left hs'.2.le (abs_nonneg _)).trans (hC.curv k₀).le
  have hs12 : r₀ * ((m₁ : ℝ) + 1) / 5 ≠ r₀ * ((m₂ : ℝ) + 1) / 5 := by
    intro h
    have h' : r₀ * ((m₁ : ℝ) + 1) = r₀ * ((m₂ : ℝ) + 1) := by linarith
    have h'' := mul_left_cancel₀ hr0.ne' h'
    apply hm; ext; exact_mod_cast (by linarith : (m₁ : ℝ) = m₂)
  have hl2 := hl m₂
  rw [← hlm] at hl2
  have huq : dist u q = 1 := by rw [dist_comm]; exact hq
  obtain ⟨hσ, hβ⟩ := germ_eq_of_two_on_circle huq (hrad m₁).1 (hrad m₂).1 hs12 (hcurv _ (hrad m₁)) (hcurv _ (hrad m₂))
    (hl m₁) hl2
  -- the arc of `ω(q)` along that germ ends at `u`
  obtain ⟨θ₁, θ₂, c, c', hR, hend, -⟩ := hC.exists_isRingArc_of_along hdisj huq hσ hβ
  exact ⟨hq, θ₁, θ₂, c, c', hR, hend⟩

/-- **FS112-N3-FAIL**, the colours: where the strip fails at `q`, the colours of `c(u)` occurring inside `ω(u)` near `q` are among the
inner colours of the arcs of `ω(q)` leaving `u`, those occurring outside among their outer colours, and each side carries at least one
colour of `c(u)` (the row's "exactly", read as the proof's "only"; equality when one such arc leaves `u`).
Inhabitant: none named for the hypotheses at once. `sevenBrick_corner_isCubicTrichromatic` (`Plane/SVMap`) inhabits `IsCubicTrichromatic`
alone, on a valid map of the plane where the other hypotheses cannot hold with it: `sevenBrickMap` has no unit arc and no four-colour
point, so this theorem's conclusion is false there (FS131-QA4 § 4.1). The set is satisfiable only on a map with a unit arc ending at a
cubic vertex. -/
theorem fail_colours (hF : F.Valid) {u q : ℂ} (hu : F.IsCubicTrichromatic u) (hc : F.Covers u 1) (hq : dist q u = 1)
    (hs : ¬ F.StripHolds u q) :
    (F.innerColours u q ∩ F.coloursAt u).Nonempty ∧ F.innerColours u q ∩ F.coloursAt u ⊆ F.leavingInner u q ∧
      (F.outerColours u q ∩ F.coloursAt u).Nonempty ∧ F.outerColours u q ∩ F.coloursAt u ⊆ F.leavingOuter u q := by
  have hud : u ∈ F.dom := hc (mem_closedBall_self zero_le_one)
  obtain ⟨r₀, G, hC, hdisj, f, -, hsec, hcol⟩ := hu.chart hud
  have hord := G.dir_lt_nextDir hC.sorted hC.curv hdisj
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  have huq : dist u q = 1 := by rw [dist_comm]; exact hq
  have hns : ∀ ε > 0, (∃ z ∈ F.interiorPts ∩ ball q ε ∩ ball u 1, F.col z ∈ F.coloursAt u) ∧
      ∃ z ∈ F.interiorPts ∩ ball q ε ∩ (closedBall u 1)ᶜ, F.col z ∈ F.coloursAt u := by
    intro ε hε
    by_contra hno
    rw [not_and_or] at hno
    apply hs
    refine ⟨ε, hε, ?_⟩
    rcases hno with h | h
    · left; intro z hz hzc; exact h ⟨z, hz, hzc⟩
    · right; intro z hz hzc; exact h ⟨z, ⟨hz.1, hz.2⟩, hzc⟩
  have hcross : ∀ i z, z ∈ F.region (f i) → ∀ b ∈ closure (G.sector u r₀ i),
      (dist z u < 1 → dist z b < 1) ∧ (1 < dist z u → 1 < dist z b) := by
    intro i z hz b hb
    have hpc : IsPreconnected (closure (G.sector u r₀ i)) := (hC.isPreconnected r₀ hr₀ i).closure
    have hu := hC.mem_closure_sector hr₀ i
    rcases hF.dist_lt_or_gt_of_isPreconnected hz hpc (closure_mono (hsec i)) with h | h
    · exact ⟨fun _ => h b hb, fun h' => absurd (h u hu) (by linarith)⟩
    · exact ⟨fun h' => absurd (h u hu) (by linarith), fun _ => h b hb⟩
  -- the bounding germs' branch points lie in the closure of their sector
  have hbd : ∀ i, ∀ s ∈ Ioo 0 r₀, branchPt u (G.β i) (G.κ i) s ∈ closure (G.sector u r₀ i) ∧
      branchPt u (G.β (BranchGerms.next i)) (G.κ (BranchGerms.next i)) s ∈ closure (G.sector u r₀ i) := by
    intro i s hs0
    refine ⟨(BranchGerms.mem_closure_sector_of_lt hs0 i (hord s hs0 i)).1, ?_⟩
    rw [branchPt_eq]
    have : e (germDir (G.β (BranchGerms.next i)) (G.κ (BranchGerms.next i)) s) = e (G.nextDir i s) :=
      (G.e_nextDir i s).symm
    rw [this]; exact (BranchGerms.mem_closure_sector_of_lt hs0 i (hord s hs0 i)).2
  have hnext : ∀ i : Fin 3, i ≠ BranchGerms.next i := by decide
  -- the arc along the germ beside sector `i` on that side, whose side colour is `f i`
  have harc : ∀ i, ∀ g, (g = i ∨ g = BranchGerms.next i) → (G.κ g = 1 ∨ G.κ g = -1) →
      e (G.β g) = I * G.κ g * (u - q) → ∃ θ₁ θ₂ c c', F.IsRingArc q θ₁ θ₂ c c' ∧ (ringPt q θ₁ = u ∨ ringPt q θ₂ = u) ∧
        ringPt q ((θ₁ + θ₂) / 2) ∈ closure (G.sector u r₀ i) := by
    intro i g hg hσ hβ
    obtain ⟨θ₁, θ₂, c, c', hR, hend, hint⟩ := hC.exists_isRingArc_of_along hdisj huq hσ hβ
    obtain ⟨s, hs0, hsx⟩ := hint ((θ₁ + θ₂) / 2) ⟨by linarith [hR.1], by linarith [hR.1]⟩
    refine ⟨θ₁, θ₂, c, c', hR, hend, ?_⟩
    rw [hsx]
    rcases hg with rfl | rfl
    · exact (hbd g s hs0).1
    · exact (hbd i s hs0).2
  refine ⟨?_, ?_, ?_, ?_⟩
  · obtain ⟨c, hc, hq'⟩ := exists_colour_near (fun ε hε => (hns ε hε).1)
    exact ⟨c, hq', hc⟩
  · rintro c ⟨hcin, hcu⟩
    obtain ⟨i, rfl⟩ := hcol c hcu
    -- the sector of `f i` lies in `B̄(q, 1)`
    have hcl : closure (G.sector u r₀ i) ⊆ closedBall q 1 := by
      intro w hw
      rw [mem_closedBall]
      by_contra hgt
      push Not at hgt
      obtain ⟨z, ⟨hzr, hzu⟩, hzq⟩ := Metric.mem_closure_iff.mp hcin (dist w q - 1) (by linarith)
      rw [mem_ball] at hzu
      have := (hcross i z hzr w hw).1 hzu
      have := dist_triangle w z q
      rw [dist_comm q z] at hzq
      linarith [dist_comm w z]
    have hsub : G.sector u r₀ i ⊆ ball q 1 := by
      rw [← interior_closedBall q one_ne_zero]
      exact (hC.isOpen r₀ hr₀ i).subset_interior_iff.mpr (subset_closure.trans hcl)
    obtain ⟨g, hg, hσ, hβ⟩ := exists_along_of_side hF hC hord hsec hcol hs huq (hnext i)
      (Or.inl fun s hs0 => ⟨hcl (hbd i s hs0).1, hcl (hbd i s hs0).2⟩)
    obtain ⟨θ₁, θ₂, c, c', hR, hend, hmid⟩ := harc i g hg hσ hβ
    have hin : f i ∈ F.innerColours q (ringPt q ((θ₁ + θ₂) / 2)) :=
      closure_mono (subset_inter (hsec i) hsub) hmid
    rw [(hR.2.2 _ ⟨by linarith [hR.1], by linarith [hR.1]⟩).1] at hin
    rw [mem_singleton_iff.mp hin]
    exact ⟨θ₁, θ₂, c', hR, hend⟩
  · obtain ⟨c, hc, hq'⟩ := exists_colour_near (fun ε hε => (hns ε hε).2)
    refine ⟨c, ?_, hc⟩
    exact hq'
  · rintro c ⟨hcout, hcu⟩
    obtain ⟨i, rfl⟩ := hcol c hcu
    have hcl : closure (G.sector u r₀ i) ⊆ {w | 1 ≤ dist w q} := by
      intro w hw
      show 1 ≤ dist w q
      by_contra hlt
      push Not at hlt
      obtain ⟨z, ⟨hzr, hzu⟩, hzq⟩ := Metric.mem_closure_iff.mp hcout (1 - dist w q) (by linarith)
      have hzu' : 1 < dist z u := by simpa [mem_closedBall, not_le] using hzu
      have := (hcross i z hzr w hw).2 hzu'
      have := dist_triangle z q w
      rw [dist_comm q z] at hzq
      linarith [dist_comm q w]
    have hsub : G.sector u r₀ i ⊆ (closedBall q 1)ᶜ := by
      intro w hw
      have hint : w ∈ interior {w | 1 ≤ dist w q} :=
        (hC.isOpen r₀ hr₀ i).subset_interior_iff.mpr (subset_closure.trans hcl) hw
      have hcompl : {w : ℂ | 1 ≤ dist w q} = (ball q 1)ᶜ := by ext w; simp [mem_ball, not_lt]
      rw [hcompl, interior_compl, closure_ball q one_ne_zero] at hint
      exact hint
    obtain ⟨g, hg, hσ, hβ⟩ := exists_along_of_side hF hC hord hsec hcol hs huq (hnext i)
      (Or.inr fun s hs0 => ⟨hcl (hbd i s hs0).1, hcl (hbd i s hs0).2⟩)
    obtain ⟨θ₁, θ₂, c, c', hR, hend, hmid⟩ := harc i g hg hσ hβ
    have hout : f i ∈ F.outerColours q (ringPt q ((θ₁ + θ₂) / 2)) := by
      show ringPt q ((θ₁ + θ₂) / 2) ∈ closure (F.region (f i) \ closedBall q 1)
      exact closure_mono (t := F.region (f i) \ closedBall q 1) (fun w hw => ⟨hsec i hw, hsub hw⟩) hmid
    rw [(hR.2.2 _ ⟨by linarith [hR.1], by linarith [hR.1]⟩).2] at hout
    rw [mem_singleton_iff.mp hout]
    exact ⟨θ₁, θ₂, c, hR, hend⟩

/-! ## FS112-N3-ANTI -/

/-- **FS112-N3-ANTI** (CE5, the Antipodal Lemma, with unit arcs): at a cubic trichromatic `u`, no two points of `ω(u)` at distance `2`
are both M-in. Inhabitant of `IsCubicTrichromatic` on a valid map of the plane: `sevenBrick_corner_isCubicTrichromatic` (`Plane/SVMap`). With one M-in point: `sevenBrick_corner_mIn` (the antipodal second is the refuted clause). -/
theorem anti (hF : F.Valid) {u x y : ℂ} (hu : F.IsCubicTrichromatic u) (hc : F.Covers u 1) (hx : dist x u = 1)
    (hy : dist y u = 1) (hxy : dist x y = 2) (h1 : F.MIn u x) (h2 : F.MIn u y) : False := by
  have hud : u ∈ F.dom := hc (mem_closedBall_self zero_le_one)
  obtain ⟨r₀, G, hC, hdisj, f, -, hsec, hcol⟩ := hu.chart hud
  have hord := G.dir_lt_nextDir hC.sorted hC.curv hdisj
  obtain ⟨c₁, hc₁, hx₁⟩ := h1
  obtain ⟨c₂, hc₂, hy₂⟩ := h2
  obtain ⟨i, rfl⟩ := hcol c₁ hc₁
  obtain ⟨j, rfl⟩ := hcol c₂ hc₂
  have hi := (closure_sector_subset_of_side hF hC hsec i).1 hx₁
  have hj := (closure_sector_subset_of_side hF hC hsec j).1 hy₂
  set s := r₀ / 2 with hs
  have hs0 : s ∈ Ioo 0 r₀ := ⟨by linarith [hC.pos], by linarith [hC.pos]⟩
  -- `u` is the midpoint of `x` and `y`, so a branch point at distance `s > 0` is beyond `ω(x)` or beyond `ω(y)`
  have hsq : ∀ z w : ℂ, dist z w ^ 2 = (z.re - w.re) ^ 2 + (z.im - w.im) ^ 2 := by
    intro z w; rw [Complex.dist_eq, Complex.sq_norm, Complex.normSq_apply]; simp only [Complex.sub_re, Complex.sub_im]; ring
  have ex := hsq x u
  have ey := hsq y u
  have exy := hsq x y
  rw [hx] at ex; rw [hy] at ey; rw [hxy] at exy
  have hzero : ((x.re - u.re) + (y.re - u.re)) ^ 2 + ((x.im - u.im) + (y.im - u.im)) ^ 2 = 0 := by nlinarith
  have hre : x.re + y.re = 2 * u.re := by nlinarith [sq_nonneg ((x.re - u.re) + (y.re - u.re)), sq_nonneg ((x.im - u.im) + (y.im - u.im))]
  have him : x.im + y.im = 2 * u.im := by nlinarith [sq_nonneg ((x.re - u.re) + (y.re - u.re)), sq_nonneg ((x.im - u.im) + (y.im - u.im))]
  have hpar : ∀ b : ℂ, dist b x ^ 2 + dist b y ^ 2 = 2 * dist b u ^ 2 + 2 := by
    intro b
    rw [hsq b x, hsq b y, hsq b u]
    have hyre : y.re = 2 * u.re - x.re := by linarith
    have hyim : y.im = 2 * u.im - x.im := by linarith
    rw [hyre, hyim]; nlinarith [ex]
  have hbeyond : ∀ g : Fin 3, 1 < dist (branchPt u (G.β g) (G.κ g) s) x ∨ 1 < dist (branchPt u (G.β g) (G.κ g) s) y := by
    intro g
    by_contra hno
    push Not at hno
    have hbu : dist (branchPt u (G.β g) (G.κ g) s) u = s := by
      rw [dist_eq_norm, norm_branchPt_sub _ _ _ hs0.1.le]
    have := hpar (branchPt u (G.β g) (G.κ g) s)
    rw [hbu] at this
    nlinarith [hno.1, hno.2, dist_nonneg (x := branchPt u (G.β g) (G.κ g) s) (y := x),
      dist_nonneg (x := branchPt u (G.β g) (G.κ g) s) (y := y), hs0.1]
  have hadj : ∀ i l, (i = l ∨ BranchGerms.next i = l) →
      branchPt u (G.β l) (G.κ l) s ∈ closure (G.sector u r₀ i) := by
    rintro i l (rfl | rfl)
    · exact (BranchGerms.mem_closure_sector_of_lt hs0 i (hord s hs0 i)).1
    · rw [branchPt_eq]
      have : e (germDir (G.β (BranchGerms.next i)) (G.κ (BranchGerms.next i)) s) = e (G.nextDir i s) :=
        (G.e_nextDir i s).symm
      rw [this]; exact (BranchGerms.mem_closure_sector_of_lt hs0 i (hord s hs0 i)).2
  obtain ⟨g₁, g₂, hne, heq⟩ := Fintype.exists_ne_map_eq_of_card_lt
    (fun g : Fin 3 => decide (1 < dist (branchPt u (G.β g) (G.κ g) s) x)) (by simp)
  have hiff : 1 < dist (branchPt u (G.β g₁) (G.κ g₁) s) x ↔ 1 < dist (branchPt u (G.β g₂) (G.κ g₂) s) x := by
    simpa using heq
  by_cases hg : 1 < dist (branchPt u (G.β g₁) (G.κ g₁) s) x
  · rcases BranchGerms.fin3_adj i g₁ g₂ hne with h | h
    · have := hi (hadj i g₁ h); rw [mem_closedBall] at this; linarith
    · have := hi (hadj i g₂ h); rw [mem_closedBall] at this; linarith [hiff.mp hg]
  · have hg₁ : 1 < dist (branchPt u (G.β g₁) (G.κ g₁) s) y := (hbeyond g₁).resolve_left hg
    have hg₂ : 1 < dist (branchPt u (G.β g₂) (G.κ g₂) s) y := (hbeyond g₂).resolve_left fun h => hg (hiff.mpr h)
    rcases BranchGerms.fin3_adj j g₁ g₂ hne with h | h
    · have := hj (hadj j g₁ h); rw [mem_closedBall] at this; linarith
    · have := hj (hadj j g₂ h); rw [mem_closedBall] at this; linarith

end ArcMap

/-! ## FS112-BOWTIE: the exact fragment (`plans/FS112-YB3-verification.md` § 2.2, `tools/fs112_yb3_frags.py bowtie`) -/

/-- The point `(x, y)`. -/
def pt (x y : ℝ) : ℂ := ⟨x, y⟩

/-- The tiles of the bowtie, by inequalities (`s = 5/13`, `c = 12/13`, `ρ = 2/5`; YB3's colours `1, …, 6` are `0, …, 5`): `G` (colour
`0`, the sector of radius 1 about `N = i` of half-angle `arcsin (5/13)` pointing down), `H` (colour `2`, its mirror about `S = −i`), the
horns `C±` (colour `1`, between `ω(N)` and `ω(S)` for `0 < ±x < 5/13`), `CN`, `CS` (colour `1`, triangles at `N`, `S`), `XR`, `YR` (colour
`3`), `XL`, `YL` (colour `4`), `ZR`, `ZL` (colour `5`, closing the unit arcs' ends). -/
def bowtieG : Set ℂ := {z | ‖z - I‖ < 1 ∧ z.im < 1 ∧ 12 * |z.re| < 5 * (1 - z.im)}
/-- The sector `H` (colour `2`), the mirror of `G` about the real axis. -/
def bowtieH : Set ℂ := {z | ‖z + I‖ < 1 ∧ -1 < z.im ∧ 12 * |z.re| < 5 * (1 + z.im)}
/-- The two horns `C±` (colour `1`), between `ω(N)` and `ω(S)` for `0 < |x| < 5/13`. -/
def bowtieC : Set ℂ := {z | z.re ≠ 0 ∧ |z.re| < 5 / 13 ∧ |z.im| < 1 / 13 ∧ 1 < ‖z - I‖ ∧ 1 < ‖z + I‖}
/-- The triangle `CN` at `N` (colour `1`), directions `[45°, 135°]`. -/
def bowtieCN : Set ℂ := {z | |z.re| < z.im - 1 ∧ z.im < 7 / 5}
/-- The triangle `CS` at `S` (colour `1`), directions `[225°, 315°]`. -/
def bowtieCS : Set ℂ := {z | |z.re| < -1 - z.im ∧ -7 / 5 < z.im}
/-- The quadrilateral `XR` (`σ = 1`, colour `3`) or `XL` (`σ = −1`, colour `4`) at `N`. -/
def bowtieX (σ : ℝ) : Set ℂ := {z | 0 < 12 * (σ * z.re) + 5 * (z.im - 1) ∧ z.im - 1 < σ * z.re ∧ σ * z.re < 2 / 5 ∧ 41 / 65 < z.im}
/-- The quadrilateral `YR` (`σ = 1`, colour `3`) or `YL` (`σ = −1`, colour `4`) at `S`. -/
def bowtieY (σ : ℝ) : Set ℂ := {z | 0 < 12 * (σ * z.re) - 5 * (z.im + 1) ∧ -z.im - 1 < σ * z.re ∧ σ * z.re < 2 / 5 ∧ z.im < -41 / 65}
/-- The hexagon `ZR` (`σ = 1`) or `ZL` (`σ = −1`), colour `5`, closing the unit arcs' ends. -/
def bowtieZ (σ : ℝ) : Set ℂ := {z | 9 / 26 < σ * z.re ∧ σ * z.re < 113 / 260 ∧ |z.im| < 11 / 65 ∧
  ¬ (σ * z.re ≤ 5 / 13 ∧ 12 * (σ * z.re) + 5 * (z.im - 1) ≤ 0 ∧ 12 * (σ * z.re) - 5 * (z.im + 1) ≤ 0)}

/-- The union of the bowtie's tiles. -/
def bowtieTiles : Set ℂ :=
  bowtieG ∪ bowtieH ∪ bowtieC ∪ bowtieCN ∪ bowtieCS ∪ bowtieX 1 ∪ bowtieX (-1) ∪ bowtieY 1 ∪ bowtieY (-1) ∪ bowtieZ 1 ∪ bowtieZ (-1)

/-- The bowtie's colour by tile (YB3's colours less one). -/
noncomputable def bowtieCol (z : ℂ) : Fin 6 := by
  classical
  exact if z ∈ bowtieG then 0 else if z ∈ bowtieC ∪ bowtieCN ∪ bowtieCS then 1 else if z ∈ bowtieH then 2
    else if z ∈ bowtieX 1 ∪ bowtieY 1 then 3 else if z ∈ bowtieX (-1) ∪ bowtieY (-1) then 4 else 5

/-- `arcsin (5/13)`, the half-angle of the sectors `G`, `H`. -/
noncomputable def bowtieAngle : ℝ := Real.arcsin (5 / 13)

/-- The bowtie's boundary pieces: the unit arcs of `ω(N)` and `ω(S)` (the sectors' arcs, through `E = 0`) and the segments of every
tile's polygonal edges (shared edges listed once or twice; the set is what counts). -/
noncomputable def bowtieArcs : Set Arc :=
  {a | a ∈ [Arc.circ I 1 (3 * π / 2 - bowtieAngle) (3 * π / 2 + bowtieAngle),
    Arc.circ (-I) 1 (π / 2 - bowtieAngle) (π / 2 + bowtieAngle),
    -- G, H, the horns' closing segments
    .seg I (pt (-5/13) (1/13)), .seg (pt (5/13) (1/13)) I, .seg (-I) (pt (5/13) (-1/13)), .seg (pt (-5/13) (-1/13)) (-I),
    .seg (pt (5/13) (1/13)) (pt (5/13) (-1/13)), .seg (pt (-5/13) (-1/13)) (pt (-5/13) (1/13)),
    -- CN, CS
    .seg I (pt (2/5) (7/5)), .seg (pt (2/5) (7/5)) (pt (-2/5) (7/5)), .seg (pt (-2/5) (7/5)) I,
    .seg (-I) (pt (-2/5) (-7/5)), .seg (pt (-2/5) (-7/5)) (pt (2/5) (-7/5)), .seg (pt (2/5) (-7/5)) (-I),
    -- XR, XL, YR, YL
    .seg (pt (2/13) (41/65)) (pt (2/5) (41/65)), .seg (pt (2/5) (41/65)) (pt (2/5) (7/5)),
    .seg (pt (-2/13) (41/65)) (pt (-2/5) (41/65)), .seg (pt (-2/5) (41/65)) (pt (-2/5) (7/5)),
    .seg (pt (2/13) (-41/65)) (pt (2/5) (-41/65)), .seg (pt (2/5) (-41/65)) (pt (2/5) (-7/5)),
    .seg (pt (-2/13) (-41/65)) (pt (-2/5) (-41/65)), .seg (pt (-2/5) (-41/65)) (pt (-2/5) (-7/5)),
    -- ZR, ZL
    .seg (pt (9/26) (11/65)) (pt (113/260) (11/65)), .seg (pt (113/260) (11/65)) (pt (113/260) (-11/65)),
    .seg (pt (113/260) (-11/65)) (pt (9/26) (-11/65)),
    .seg (pt (-9/26) (11/65)) (pt (-113/260) (11/65)), .seg (pt (-113/260) (11/65)) (pt (-113/260) (-11/65)),
    .seg (pt (-113/260) (-11/65)) (pt (-9/26) (-11/65))]}

/-- Every boundary piece of the bowtie has positive length. -/
theorem bowtieArcs_nondegenerate : ∀ a ∈ bowtieArcs, a.Nondegenerate := by
  have hang : 0 < bowtieAngle := Real.arcsin_pos.2 (by norm_num)
  have hang2 : bowtieAngle ≤ π / 2 := Real.arcsin_le_pi_div_two _
  intro a ha
  simp only [bowtieArcs, mem_setOf_eq, List.mem_cons, List.not_mem_nil, or_false] at ha
  have hne : ∀ x y x' y' : ℝ, (x ≠ x' ∨ y ≠ y') → pt x y ≠ pt x' y' := by
    intro x y x' y' h hxy
    have h1 := congrArg Complex.re hxy
    have h2 := congrArg Complex.im hxy
    simp only [pt] at h1 h2
    rcases h with h | h <;> contradiction
  have hI : ∀ x y : ℝ, (x ≠ 0 ∨ y ≠ 1) → pt x y ≠ I := by
    intro x y h hxy
    have h1 := congrArg Complex.re hxy
    have h2 := congrArg Complex.im hxy
    simp only [pt, Complex.I_re, Complex.I_im] at h1 h2
    rcases h with h | h <;> contradiction
  have hnI : ∀ x y : ℝ, (x ≠ 0 ∨ y ≠ -1) → pt x y ≠ -I := by
    intro x y h hxy
    have h1 := congrArg Complex.re hxy
    have h2 := congrArg Complex.im hxy
    simp only [pt, Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im] at h1 h2
    rcases h with h | h <;> [exact h (by linarith); exact h (by linarith)]
  rcases ha with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
    rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · exact ⟨one_pos, by linarith, by linarith [Real.pi_pos]⟩
  · exact ⟨one_pos, by linarith, by linarith [Real.pi_pos]⟩
  all_goals first
    | exact (hI _ _ (by norm_num)).symm
    | exact hI _ _ (by norm_num)
    | exact (hnI _ _ (by norm_num)).symm
    | exact hnI _ _ (by norm_num)
    | exact hne _ _ _ _ (by norm_num)

/-- The bowtie has finitely many boundary pieces. -/
theorem bowtieArcs_locallyFinite : ∀ x ∈ interior (closure bowtieTiles), ∃ t ∈ 𝓝 x,
    {a | a ∈ bowtieArcs ∧ (a.carrier ∩ t).Nonempty}.Finite := by
  intro x _
  refine ⟨univ, univ_mem, ?_⟩
  have hfin : bowtieArcs.Finite := by unfold bowtieArcs; exact List.finite_toSet _
  exact hfin.subset fun a ha => ha.1

/-! ### The bowtie's colour is locally constant (FS131-I4f): each tile's closure adds only boundary pieces -/

/-- A point `p + t (q − p)`, `t ∈ [0, 1]`, given by its coordinates, lies on the segment `[p, q]`. -/
theorem mem_segment_of_coords {p q z : ℂ} (t : ℝ) (ht0 : 0 ≤ t) (ht1 : t ≤ 1) (hre : z.re = p.re + t * (q.re - p.re))
    (him : z.im = p.im + t * (q.im - p.im)) : z ∈ segment ℝ p q := by
  refine ⟨1 - t, t, by linarith, ht0, by ring, ?_⟩
  apply Complex.ext
  · simp only [Complex.add_re, Complex.smul_re, smul_eq_mul, hre]; ring
  · simp only [Complex.add_im, Complex.smul_im, smul_eq_mul, him]; ring

/-- A segment of the bowtie's list carries the points `p + t (q − p)`, `t ∈ [0, 1]`. -/
theorem mem_bowtieArcs_seg {p q z : ℂ} (ha : Arc.seg p q ∈ bowtieArcs) (t : ℝ) (ht0 : 0 ≤ t) (ht1 : t ≤ 1)
    (hre : z.re = p.re + t * (q.re - p.re)) (him : z.im = p.im + t * (q.im - p.im)) :
    z ∈ ⋃ a ∈ bowtieArcs, a.carrier :=
  mem_iUnion₂.mpr ⟨_, ha, mem_segment_of_coords t ht0 ht1 hre him⟩

/-- A point of `ω(i)` below `i` with `|re z| ≤ 5/13` lies on the bowtie's arc of `ω(i)`. -/
theorem mem_bowtieArcN_of {z : ℂ} (h1 : ‖z - I‖ = 1) (hre : |z.re| ≤ 5 / 13) (him : z.im ≤ 1) :
    z ∈ ⋃ a ∈ bowtieArcs, a.carrier := by
  refine mem_iUnion₂.mpr ⟨Arc.circ I 1 (3 * π / 2 - bowtieAngle) (3 * π / 2 + bowtieAngle), by simp [bowtieArcs], ?_⟩
  have hsq : z.re ^ 2 + (z.im - 1) ^ 2 = 1 := by
    have h2 : ‖z - I‖ ^ 2 = 1 := by rw [h1]; norm_num
    rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply] at h2
    simp only [Complex.sub_re, Complex.sub_im, Complex.I_re, Complex.I_im, sub_zero] at h2
    nlinarith
  have hx1 : -1 ≤ z.re := by linarith [(abs_le.mp hre).1]
  have hx2 : z.re ≤ 1 := by linarith [(abs_le.mp hre).2]
  have hsin : Real.sin (Real.arcsin z.re) = z.re := Real.sin_arcsin hx1 hx2
  have hcos : Real.cos (Real.arcsin z.re) = 1 - z.im := by
    rw [Real.cos_arcsin, show 1 - z.re ^ 2 = (1 - z.im) ^ 2 by nlinarith]
    exact Real.sqrt_sq (by linarith)
  have hl : -bowtieAngle ≤ Real.arcsin z.re := by
    unfold bowtieAngle; rw [← Real.arcsin_neg]; exact Real.arcsin_le_arcsin (by linarith [(abs_le.mp hre).1])
  have hu : Real.arcsin z.re ≤ bowtieAngle := Real.arcsin_le_arcsin (by linarith [(abs_le.mp hre).2])
  refine ⟨3 * π / 2 + Real.arcsin z.re, ⟨by linarith, by linarith⟩, ?_⟩
  have h3 : 3 * π / 2 + Real.arcsin z.re = (Real.arcsin z.re - π / 2) + 2 * π := by ring
  apply Complex.ext
  · simp only [Complex.add_re, Complex.I_re, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e, h3,
      Real.cos_add_two_pi, Real.sin_add_two_pi, Real.cos_sub_pi_div_two, Real.sin_sub_pi_div_two, hsin]
    ring
  · simp only [Complex.add_im, Complex.I_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e, h3,
      Real.cos_add_two_pi, Real.sin_add_two_pi, Real.cos_sub_pi_div_two, Real.sin_sub_pi_div_two, hcos]
    ring

/-- A point of `ω(−i)` above `−i` with `|re z| ≤ 5/13` lies on the bowtie's arc of `ω(−i)`. -/
theorem mem_bowtieArcS_of {z : ℂ} (h1 : ‖z + I‖ = 1) (hre : |z.re| ≤ 5 / 13) (him : -1 ≤ z.im) :
    z ∈ ⋃ a ∈ bowtieArcs, a.carrier := by
  refine mem_iUnion₂.mpr ⟨Arc.circ (-I) 1 (π / 2 - bowtieAngle) (π / 2 + bowtieAngle), by simp [bowtieArcs], ?_⟩
  have hsq : z.re ^ 2 + (z.im + 1) ^ 2 = 1 := by
    have h2 : ‖z + I‖ ^ 2 = 1 := by rw [h1]; norm_num
    rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply] at h2
    simp only [Complex.add_re, Complex.add_im, Complex.I_re, Complex.I_im, add_zero] at h2
    nlinarith
  have hx1 : -1 ≤ z.re := by linarith [(abs_le.mp hre).1]
  have hx2 : z.re ≤ 1 := by linarith [(abs_le.mp hre).2]
  have hsin : Real.sin (Real.arcsin z.re) = z.re := Real.sin_arcsin hx1 hx2
  have hcos : Real.cos (Real.arcsin z.re) = 1 + z.im := by
    rw [Real.cos_arcsin, show 1 - z.re ^ 2 = (1 + z.im) ^ 2 by nlinarith]
    exact Real.sqrt_sq (by linarith)
  have hl : -bowtieAngle ≤ Real.arcsin z.re := by
    unfold bowtieAngle; rw [← Real.arcsin_neg]; exact Real.arcsin_le_arcsin (by linarith [(abs_le.mp hre).1])
  have hu : Real.arcsin z.re ≤ bowtieAngle := Real.arcsin_le_arcsin (by linarith [(abs_le.mp hre).2])
  refine ⟨π / 2 - Real.arcsin z.re, ⟨by linarith, by linarith⟩, ?_⟩
  apply Complex.ext
  · simp only [Complex.add_re, Complex.neg_re, Complex.I_re, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, re_e,
      im_e, Real.cos_pi_div_two_sub, Real.sin_pi_div_two_sub, hsin]
    ring
  · simp only [Complex.add_im, Complex.neg_im, Complex.I_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e,
      im_e, Real.cos_pi_div_two_sub, Real.sin_pi_div_two_sub, hcos]
    ring

/-- `‖z − i‖² = re² + (im − 1)²`. -/
theorem norm_sub_I_sq (z : ℂ) : ‖z - I‖ ^ 2 = z.re ^ 2 + (z.im - 1) ^ 2 := by
  rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; simp; ring

/-- `‖z + i‖² = re² + (im + 1)²`. -/
theorem norm_add_I_sq (z : ℂ) : ‖z + I‖ ^ 2 = z.re ^ 2 + (z.im + 1) ^ 2 := by
  rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; simp; ring

/-- The closure of `G` adds only boundary pieces: its arc of `ω(i)` and its two edges through `i`. -/
theorem closure_bowtieG_subset : closure bowtieG ⊆ bowtieG ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  have hcl : closure bowtieG ⊆ {z : ℂ | ‖z - I‖ ≤ 1} ∩ {z | 12 * |z.re| ≤ 5 * (1 - z.im)} :=
    closure_minimal (fun z hz => ⟨hz.1.le, hz.2.2.le⟩)
      ((isClosed_le (by fun_prop) continuous_const).inter (isClosed_le (by fun_prop) (by fun_prop)))
  intro z hz
  obtain ⟨h1, h2⟩ := hcl hz
  simp only [mem_setOf_eq] at h1 h2
  by_cases hG : z ∈ bowtieG
  · exact Or.inl hG
  right
  have hsq := norm_sub_I_sq z
  have hn := norm_nonneg (z - I)
  have ha := abs_nonneg z.re
  have hsa := sq_abs z.re
  have him : z.im ≤ 1 := by linarith
  have hre : |z.re| ≤ 5 / 13 := by nlinarith
  rcases h1.lt_or_eq with h1 | h1
  · have h2' : 12 * |z.re| = 5 * (1 - z.im) := by
      by_contra hne
      have h2s := lt_of_le_of_ne h2 hne
      exact hG ⟨h1, by linarith, h2s⟩
    rcases le_or_gt 0 z.re with hr | hr
    · rw [abs_of_nonneg hr] at h2' hre
      exact mem_bowtieArcs_seg (p := pt (5/13) (1/13)) (q := I) (by simp [bowtieArcs]) (1 - 13 * z.re / 5)
        (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
    · rw [abs_of_neg hr] at h2' hre
      exact mem_bowtieArcs_seg (p := I) (q := pt (-5/13) (1/13)) (by simp [bowtieArcs]) (-13 * z.re / 5)
        (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcN_of h1 hre him

/-- The closure of `H` adds only boundary pieces (the mirror of `G`). -/
theorem closure_bowtieH_subset : closure bowtieH ⊆ bowtieH ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  have hcl : closure bowtieH ⊆ {z : ℂ | ‖z + I‖ ≤ 1} ∩ {z | 12 * |z.re| ≤ 5 * (1 + z.im)} :=
    closure_minimal (fun z hz => ⟨hz.1.le, hz.2.2.le⟩)
      ((isClosed_le (by fun_prop) continuous_const).inter (isClosed_le (by fun_prop) (by fun_prop)))
  intro z hz
  obtain ⟨h1, h2⟩ := hcl hz
  simp only [mem_setOf_eq] at h1 h2
  by_cases hH : z ∈ bowtieH
  · exact Or.inl hH
  right
  have hsq := norm_add_I_sq z
  have hn := norm_nonneg (z + I)
  have ha := abs_nonneg z.re
  have hsa := sq_abs z.re
  have him : -1 ≤ z.im := by linarith
  have hre : |z.re| ≤ 5 / 13 := by nlinarith
  rcases h1.lt_or_eq with h1 | h1
  · have h2' : 12 * |z.re| = 5 * (1 + z.im) := by
      by_contra hne
      have h2s := lt_of_le_of_ne h2 hne
      exact hH ⟨h1, by linarith, h2s⟩
    rcases le_or_gt 0 z.re with hr | hr
    · rw [abs_of_nonneg hr] at h2' hre
      exact mem_bowtieArcs_seg (p := -I) (q := pt (5/13) (-1/13)) (by simp [bowtieArcs]) (13 * z.re / 5)
        (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
    · rw [abs_of_neg hr] at h2' hre
      exact mem_bowtieArcs_seg (p := pt (-5/13) (-1/13)) (q := -I) (by simp [bowtieArcs]) (1 + 13 * z.re / 5)
        (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcS_of h1 hre him


/-- The closure of `C` adds only boundary pieces: the arcs of `ω(±i)` and the closing segments at `re = ±5/13`. -/
theorem closure_bowtieC_subset : closure bowtieC ⊆ bowtieC ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  have hcl : closure bowtieC ⊆ {z : ℂ | |z.re| ≤ 5 / 13} ∩ {z | |z.im| ≤ 1 / 13} ∩ {z | 1 ≤ ‖z - I‖} ∩ {z | 1 ≤ ‖z + I‖} :=
    closure_minimal (fun z hz => ⟨⟨⟨hz.2.1.le, hz.2.2.1.le⟩, hz.2.2.2.1.le⟩, hz.2.2.2.2.le⟩)
      ((((isClosed_le (by fun_prop) continuous_const).inter (isClosed_le (by fun_prop) continuous_const)).inter
        (isClosed_le continuous_const (by fun_prop))).inter (isClosed_le continuous_const (by fun_prop)))
  intro z hz
  obtain ⟨⟨⟨h1, h2⟩, h3⟩, h4⟩ := hcl hz
  simp only [mem_setOf_eq] at h1 h2 h3 h4
  by_cases hC : z ∈ bowtieC
  · exact Or.inl hC
  right
  have h2' := abs_le.mp h2
  rcases h3.lt_or_eq with h3 | h3
  swap
  · exact mem_bowtieArcN_of h3.symm h1 (by linarith)
  rcases h4.lt_or_eq with h4 | h4
  swap
  · exact mem_bowtieArcS_of h4.symm h1 (by linarith)
  have hsN := norm_sub_I_sq z
  have hsS := norm_add_I_sq z
  have hsa := sq_abs z.re
  rcases h1.lt_or_eq with h1 | h1
  · exfalso
    have him : |z.im| < 1 / 13 := by
      rcases h2.lt_or_eq with h | h
      · exact h
      · exfalso
        rcases abs_eq (by norm_num : (0:ℝ) ≤ 1 / 13) |>.mp h with h' | h'
        · rw [h'] at hsN; nlinarith [abs_nonneg z.re]
        · rw [h'] at hsS; nlinarith [abs_nonneg z.re]
    have hre : z.re ≠ 0 := by
      intro h0
      rw [h0] at hsN hsS
      have him' := abs_lt.mp him
      have e3 := (one_lt_sq_iff₀ (norm_nonneg _)).mpr h3
      have e4 := (one_lt_sq_iff₀ (norm_nonneg _)).mpr h4
      nlinarith
    exact hC ⟨hre, h1, him, h3, h4⟩
  · rcases abs_eq (by norm_num : (0:ℝ) ≤ 5 / 13) |>.mp h1 with h' | h'
    · exact mem_bowtieArcs_seg (p := pt (5/13) (1/13)) (q := pt (5/13) (-1/13)) (by simp [bowtieArcs])
        ((1 / 13 - z.im) * 13 / 2) (by linarith) (by linarith) (by simp [pt]; linarith) (by simp [pt]; ring)
    · exact mem_bowtieArcs_seg (p := pt (-5/13) (-1/13)) (q := pt (-5/13) (1/13)) (by simp [bowtieArcs])
        ((z.im + 1 / 13) * 13 / 2) (by linarith) (by linarith) (by simp [pt]; linarith) (by simp [pt]; ring)

/-- The closure of `CN` adds only its three edges. -/
theorem closure_bowtieCN_subset : closure bowtieCN ⊆ bowtieCN ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  have hcl : closure bowtieCN ⊆ {z : ℂ | |z.re| ≤ z.im - 1} ∩ {z | z.im ≤ 7 / 5} :=
    closure_minimal (fun z hz => ⟨hz.1.le, hz.2.le⟩)
      ((isClosed_le (by fun_prop) (by fun_prop)).inter (isClosed_le (by fun_prop) continuous_const))
  intro z hz
  obtain ⟨h1, h2⟩ := hcl hz
  simp only [mem_setOf_eq] at h1 h2
  by_cases hC : z ∈ bowtieCN
  · exact Or.inl hC
  right
  have ha := abs_nonneg z.re
  rcases h2.lt_or_eq with h2 | h2
  · have h1' : |z.re| = z.im - 1 := by
      by_contra hne; exact hC ⟨lt_of_le_of_ne h1 hne, h2⟩
    rcases le_or_gt 0 z.re with hr | hr
    · rw [abs_of_nonneg hr] at h1'
      exact mem_bowtieArcs_seg (p := I) (q := pt (2/5) (7/5)) (by simp [bowtieArcs]) (5 / 2 * z.re)
        (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
    · rw [abs_of_neg hr] at h1'
      exact mem_bowtieArcs_seg (p := pt (-2/5) (7/5)) (q := I) (by simp [bowtieArcs]) (1 + 5 / 2 * z.re)
        (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · have h1' := abs_le.mp (show |z.re| ≤ 2 / 5 by linarith)
    exact mem_bowtieArcs_seg (p := pt (2/5) (7/5)) (q := pt (-2/5) (7/5)) (by simp [bowtieArcs]) ((2 / 5 - z.re) * 5 / 4)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)

/-- The closure of `CS` adds only its three edges. -/
theorem closure_bowtieCS_subset : closure bowtieCS ⊆ bowtieCS ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  have hcl : closure bowtieCS ⊆ {z : ℂ | |z.re| ≤ -1 - z.im} ∩ {z | -7 / 5 ≤ z.im} :=
    closure_minimal (fun z hz => ⟨hz.1.le, hz.2.le⟩)
      ((isClosed_le (by fun_prop) (by fun_prop)).inter (isClosed_le continuous_const (by fun_prop)))
  intro z hz
  obtain ⟨h1, h2⟩ := hcl hz
  simp only [mem_setOf_eq] at h1 h2
  by_cases hC : z ∈ bowtieCS
  · exact Or.inl hC
  right
  have ha := abs_nonneg z.re
  rcases h2.lt_or_eq with h2 | h2
  · have h1' : |z.re| = -1 - z.im := by
      by_contra hne; exact hC ⟨lt_of_le_of_ne h1 hne, h2⟩
    rcases le_or_gt 0 z.re with hr | hr
    · rw [abs_of_nonneg hr] at h1'
      exact mem_bowtieArcs_seg (p := pt (2/5) (-7/5)) (q := -I) (by simp [bowtieArcs]) (1 - 5 / 2 * z.re)
        (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
    · rw [abs_of_neg hr] at h1'
      exact mem_bowtieArcs_seg (p := -I) (q := pt (-2/5) (-7/5)) (by simp [bowtieArcs]) (-5 / 2 * z.re)
        (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · have h1' := abs_le.mp (show |z.re| ≤ 2 / 5 by linarith)
    exact mem_bowtieArcs_seg (p := pt (-2/5) (-7/5)) (q := pt (2/5) (-7/5)) (by simp [bowtieArcs]) ((z.re + 2 / 5) * 5 / 4)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)


/-- A point of the closure of `X σ` outside it lies on one of the four edges, in the coordinate `u = σ re`. -/
theorem bowtieX_closure_cases (σ : ℝ) {z : ℂ} (hz : z ∈ closure (bowtieX σ)) (hX : z ∉ bowtieX σ) :
    (12 * (σ * z.re) + 5 * (z.im - 1) = 0 ∧ 0 ≤ σ * z.re ∧ σ * z.re ≤ 2 / 13) ∨
      (z.im - 1 = σ * z.re ∧ 0 ≤ σ * z.re ∧ σ * z.re ≤ 2 / 5) ∨ (σ * z.re = 2 / 5 ∧ 41 / 65 ≤ z.im ∧ z.im ≤ 7 / 5) ∨
      (z.im = 41 / 65 ∧ 2 / 13 ≤ σ * z.re ∧ σ * z.re ≤ 2 / 5) := by
  have hcl : closure (bowtieX σ) ⊆ {z : ℂ | 0 ≤ 12 * (σ * z.re) + 5 * (z.im - 1)} ∩ {z | z.im - 1 ≤ σ * z.re} ∩
      {z | σ * z.re ≤ 2 / 5} ∩ {z | 41 / 65 ≤ z.im} :=
    closure_minimal (fun z hz => ⟨⟨⟨hz.1.le, hz.2.1.le⟩, hz.2.2.1.le⟩, hz.2.2.2.le⟩)
      ((((isClosed_le continuous_const (by fun_prop)).inter (isClosed_le (by fun_prop) (by fun_prop))).inter
        (isClosed_le (by fun_prop) continuous_const)).inter (isClosed_le continuous_const (by fun_prop)))
  obtain ⟨⟨⟨h1, h2⟩, h3⟩, h4⟩ := hcl hz
  simp only [mem_setOf_eq] at h1 h2 h3 h4
  rcases h1.lt_or_eq with h1 | h1
  · rcases h2.lt_or_eq with h2 | h2
    · rcases h3.lt_or_eq with h3 | h3
      · rcases h4.lt_or_eq with h4 | h4
        · exact absurd ⟨h1, h2, h3, h4⟩ hX
        · right; right; right; exact ⟨h4.symm, by linarith, h3.le⟩
      · right; right; left; exact ⟨h3, h4, by linarith⟩
    · right; left; exact ⟨h2, by linarith, h3⟩
  · left; exact ⟨h1.symm, by linarith, by linarith⟩

/-- A point of the closure of `Y σ` outside it lies on one of the four edges, in the coordinate `u = σ re`. -/
theorem bowtieY_closure_cases (σ : ℝ) {z : ℂ} (hz : z ∈ closure (bowtieY σ)) (hY : z ∉ bowtieY σ) :
    (12 * (σ * z.re) - 5 * (z.im + 1) = 0 ∧ 0 ≤ σ * z.re ∧ σ * z.re ≤ 2 / 13) ∨
      (-z.im - 1 = σ * z.re ∧ 0 ≤ σ * z.re ∧ σ * z.re ≤ 2 / 5) ∨ (σ * z.re = 2 / 5 ∧ -7 / 5 ≤ z.im ∧ z.im ≤ -41 / 65) ∨
      (z.im = -41 / 65 ∧ 2 / 13 ≤ σ * z.re ∧ σ * z.re ≤ 2 / 5) := by
  have hcl : closure (bowtieY σ) ⊆ {z : ℂ | 0 ≤ 12 * (σ * z.re) - 5 * (z.im + 1)} ∩ {z | -z.im - 1 ≤ σ * z.re} ∩
      {z | σ * z.re ≤ 2 / 5} ∩ {z | z.im ≤ -41 / 65} :=
    closure_minimal (fun z hz => ⟨⟨⟨hz.1.le, hz.2.1.le⟩, hz.2.2.1.le⟩, hz.2.2.2.le⟩)
      ((((isClosed_le continuous_const (by fun_prop)).inter (isClosed_le (by fun_prop) (by fun_prop))).inter
        (isClosed_le (by fun_prop) continuous_const)).inter (isClosed_le (by fun_prop) continuous_const))
  obtain ⟨⟨⟨h1, h2⟩, h3⟩, h4⟩ := hcl hz
  simp only [mem_setOf_eq] at h1 h2 h3 h4
  rcases h1.lt_or_eq with h1 | h1
  · rcases h2.lt_or_eq with h2 | h2
    · rcases h3.lt_or_eq with h3 | h3
      · rcases h4.lt_or_eq with h4 | h4
        · exact absurd ⟨h1, h2, h3, h4⟩ hY
        · right; right; right; exact ⟨h4, by linarith, h3.le⟩
      · right; right; left; exact ⟨h3, by linarith, h4⟩
    · right; left; exact ⟨h2, by linarith, h3⟩
  · left; exact ⟨h1.symm, by linarith, by linarith⟩

/-- The closure of `XR` adds only its four edges. -/
theorem closure_bowtieX_one_subset : closure (bowtieX 1) ⊆ bowtieX 1 ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  intro z hz
  by_cases hX : z ∈ bowtieX 1
  · exact Or.inl hX
  right
  rcases bowtieX_closure_cases 1 hz hX with ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ <;>
    simp only [one_mul] at h1 h2 h3
  · exact mem_bowtieArcs_seg (p := pt (5/13) (1/13)) (q := I) (by simp [bowtieArcs]) (1 - 13 * z.re / 5)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcs_seg (p := I) (q := pt (2/5) (7/5)) (by simp [bowtieArcs]) (5 / 2 * z.re)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcs_seg (p := pt (2/5) (41/65)) (q := pt (2/5) (7/5)) (by simp [bowtieArcs]) ((z.im - 41 / 65) * 65 / 50)
      (by linarith) (by linarith) (by simp [pt]; linarith) (by simp [pt]; ring)
  · exact mem_bowtieArcs_seg (p := pt (2/13) (41/65)) (q := pt (2/5) (41/65)) (by simp [bowtieArcs]) ((z.re - 2 / 13) * 65 / 16)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)

/-- The closure of `XL` adds only its four edges. -/
theorem closure_bowtieX_neg_one_subset : closure (bowtieX (-1)) ⊆ bowtieX (-1) ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  intro z hz
  by_cases hX : z ∈ bowtieX (-1)
  · exact Or.inl hX
  right
  rcases bowtieX_closure_cases (-1) hz hX with ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ <;>
    simp only [neg_one_mul] at h1 h2 h3
  · exact mem_bowtieArcs_seg (p := I) (q := pt (-5/13) (1/13)) (by simp [bowtieArcs]) (-13 * z.re / 5)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcs_seg (p := pt (-2/5) (7/5)) (q := I) (by simp [bowtieArcs]) (1 + 5 / 2 * z.re)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcs_seg (p := pt (-2/5) (41/65)) (q := pt (-2/5) (7/5)) (by simp [bowtieArcs]) ((z.im - 41 / 65) * 65 / 50)
      (by linarith) (by linarith) (by simp [pt]; linarith) (by simp [pt]; ring)
  · exact mem_bowtieArcs_seg (p := pt (-2/13) (41/65)) (q := pt (-2/5) (41/65)) (by simp [bowtieArcs]) ((-z.re - 2 / 13) * 65 / 16)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)

/-- The closure of `YR` adds only its four edges. -/
theorem closure_bowtieY_one_subset : closure (bowtieY 1) ⊆ bowtieY 1 ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  intro z hz
  by_cases hY : z ∈ bowtieY 1
  · exact Or.inl hY
  right
  rcases bowtieY_closure_cases 1 hz hY with ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ <;>
    simp only [one_mul] at h1 h2 h3
  · exact mem_bowtieArcs_seg (p := -I) (q := pt (5/13) (-1/13)) (by simp [bowtieArcs]) (13 * z.re / 5)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcs_seg (p := pt (2/5) (-7/5)) (q := -I) (by simp [bowtieArcs]) (1 - 5 / 2 * z.re)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcs_seg (p := pt (2/5) (-41/65)) (q := pt (2/5) (-7/5)) (by simp [bowtieArcs]) ((-41 / 65 - z.im) * 65 / 50)
      (by linarith) (by linarith) (by simp [pt]; linarith) (by simp [pt]; ring)
  · exact mem_bowtieArcs_seg (p := pt (2/13) (-41/65)) (q := pt (2/5) (-41/65)) (by simp [bowtieArcs]) ((z.re - 2 / 13) * 65 / 16)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)

/-- The closure of `YL` adds only its four edges. -/
theorem closure_bowtieY_neg_one_subset : closure (bowtieY (-1)) ⊆ bowtieY (-1) ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  intro z hz
  by_cases hY : z ∈ bowtieY (-1)
  · exact Or.inl hY
  right
  rcases bowtieY_closure_cases (-1) hz hY with ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ <;>
    simp only [neg_one_mul] at h1 h2 h3
  · exact mem_bowtieArcs_seg (p := pt (-5/13) (-1/13)) (q := -I) (by simp [bowtieArcs]) (1 + 13 * z.re / 5)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcs_seg (p := -I) (q := pt (-2/5) (-7/5)) (by simp [bowtieArcs]) (-5 / 2 * z.re)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcs_seg (p := pt (-2/5) (-41/65)) (q := pt (-2/5) (-7/5)) (by simp [bowtieArcs]) ((-41 / 65 - z.im) * 65 / 50)
      (by linarith) (by linarith) (by simp [pt]; linarith) (by simp [pt]; ring)
  · exact mem_bowtieArcs_seg (p := pt (-2/13) (-41/65)) (q := pt (-2/5) (-41/65)) (by simp [bowtieArcs]) ((-z.re - 2 / 13) * 65 / 16)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)

/-- Membership in an open set is eventually constant near a point off `A`, when the set's closure adds only points of `A`. -/
theorem eventually_mem_iff_of_closure_subset {U A : Set ℂ} (hU : IsOpen U) (h : closure U ⊆ U ∪ A) {x : ℂ} (hx : x ∉ A) :
    ∀ᶠ y in 𝓝 x, (y ∈ U ↔ x ∈ U) := by
  by_cases hxU : x ∈ U
  · filter_upwards [hU.mem_nhds hxU] with y hy
    exact iff_of_true hy hxU
  · have hc : x ∉ closure U := fun hc => (h hc).elim hxU hx
    filter_upwards [isClosed_closure.isOpen_compl.mem_nhds hc] with y hy
    exact iff_of_false (fun h' => hy (subset_closure h')) hxU

/-- The bowtie's colour depends only on membership in its nine tiles `G`, `C`, `CN`, `CS`, `H`, `X±`, `Y±`. -/
theorem bowtieCol_eq_of_iff {x y : ℂ} (hG : y ∈ bowtieG ↔ x ∈ bowtieG) (hC : y ∈ bowtieC ↔ x ∈ bowtieC)
    (hCN : y ∈ bowtieCN ↔ x ∈ bowtieCN) (hCS : y ∈ bowtieCS ↔ x ∈ bowtieCS) (hH : y ∈ bowtieH ↔ x ∈ bowtieH)
    (hX1 : y ∈ bowtieX 1 ↔ x ∈ bowtieX 1) (hY1 : y ∈ bowtieY 1 ↔ x ∈ bowtieY 1)
    (hX2 : y ∈ bowtieX (-1) ↔ x ∈ bowtieX (-1)) (hY2 : y ∈ bowtieY (-1) ↔ x ∈ bowtieY (-1)) :
    bowtieCol y = bowtieCol x := by
  classical
  unfold bowtieCol
  simp only [mem_union, hG, hC, hCN, hCS, hH, hX1, hY1, hX2, hY2]

/-- `G` is open. -/
theorem isOpen_bowtieG : IsOpen bowtieG := by
  unfold bowtieG
  refine (isOpen_lt ?_ ?_).and ((isOpen_lt ?_ ?_).and (isOpen_lt ?_ ?_)) <;> fun_prop

/-- `H` is open. -/
theorem isOpen_bowtieH : IsOpen bowtieH := by
  unfold bowtieH
  refine (isOpen_lt ?_ ?_).and ((isOpen_lt ?_ ?_).and (isOpen_lt ?_ ?_)) <;> fun_prop

/-- `C` is open. -/
theorem isOpen_bowtieC : IsOpen bowtieC := by
  unfold bowtieC
  refine (isOpen_ne_fun ?_ ?_).and ((isOpen_lt ?_ ?_).and ((isOpen_lt ?_ ?_).and ((isOpen_lt ?_ ?_).and
    (isOpen_lt ?_ ?_)))) <;> fun_prop

/-- `CN` is open. -/
theorem isOpen_bowtieCN : IsOpen bowtieCN := by
  unfold bowtieCN
  refine (isOpen_lt ?_ ?_).and (isOpen_lt ?_ ?_) <;> fun_prop

/-- `CS` is open. -/
theorem isOpen_bowtieCS : IsOpen bowtieCS := by
  unfold bowtieCS
  refine (isOpen_lt ?_ ?_).and (isOpen_lt ?_ ?_) <;> fun_prop

/-- `X σ` is open. -/
theorem isOpen_bowtieX (σ : ℝ) : IsOpen (bowtieX σ) := by
  unfold bowtieX
  refine (isOpen_lt ?_ ?_).and ((isOpen_lt ?_ ?_).and ((isOpen_lt ?_ ?_).and (isOpen_lt ?_ ?_))) <;> fun_prop

/-- `Y σ` is open. -/
theorem isOpen_bowtieY (σ : ℝ) : IsOpen (bowtieY σ) := by
  unfold bowtieY
  refine (isOpen_lt ?_ ?_).and ((isOpen_lt ?_ ?_).and ((isOpen_lt ?_ ?_).and (isOpen_lt ?_ ?_))) <;> fun_prop

/-- The bowtie's colour is locally constant off its boundary pieces, inside its domain. -/
theorem bowtieCol_locallyConstant : ∀ x ∈ interior (closure bowtieTiles), x ∉ ⋃ a ∈ bowtieArcs, a.carrier →
    ∀ᶠ y in 𝓝 x, bowtieCol y = bowtieCol x := by
  intro x _ hx
  filter_upwards [eventually_mem_iff_of_closure_subset isOpen_bowtieG closure_bowtieG_subset hx,
    eventually_mem_iff_of_closure_subset isOpen_bowtieC closure_bowtieC_subset hx,
    eventually_mem_iff_of_closure_subset isOpen_bowtieCN closure_bowtieCN_subset hx,
    eventually_mem_iff_of_closure_subset isOpen_bowtieCS closure_bowtieCS_subset hx,
    eventually_mem_iff_of_closure_subset isOpen_bowtieH closure_bowtieH_subset hx,
    eventually_mem_iff_of_closure_subset (isOpen_bowtieX 1) closure_bowtieX_one_subset hx,
    eventually_mem_iff_of_closure_subset (isOpen_bowtieY 1) closure_bowtieY_one_subset hx,
    eventually_mem_iff_of_closure_subset (isOpen_bowtieX (-1)) closure_bowtieX_neg_one_subset hx,
    eventually_mem_iff_of_closure_subset (isOpen_bowtieY (-1)) closure_bowtieY_neg_one_subset hx]
    with y h1 h2 h3 h4 h5 h6 h7 h8 h9
  exact bowtieCol_eq_of_iff h1 h2 h3 h4 h5 h6 h7 h8 h9

/-- **FS112-BOWTIE's fragment**: the map of the interior of the closure of its tiles. -/
noncomputable def bowtie : ArcMap 6 where
  dom := interior (closure bowtieTiles)
  isOpen_dom := isOpen_interior
  arcs := bowtieArcs
  nondegenerate := bowtieArcs_nondegenerate
  locallyFinite := bowtieArcs_locallyFinite
  col := bowtieCol
  locallyConstant := bowtieCol_locallyConstant

namespace ArcMap

/-! ### The bowtie near `E = 0`: the cusp fragment's partition (FS131-I4e)

Within `1/13` of `E = 0` the bowtie's arcs are its two unit arcs alone (each of its 28 segments lies in a half-plane `re ≥ 1/13`,
`re ≤ −1/13`, `im ≥ 1/13` or `im ≤ −1/13`), so its interior points there are the cusp fragment's (`Plane/ValidMap/Sectors`): the two
horns (colour `1`), the part of `G` (colour `0`) and the part of `H` (colour `2`). -/

/-- `e (π + π/2) = −i`: the normal of the frame along `e π`. -/
theorem e_pi_add_pi_div_two : e (π + π / 2) = -I := by
  rw [e_eq, Real.cos_add_pi_div_two, Real.sin_add_pi_div_two, Real.sin_pi, Real.cos_pi]; simp

/-- A segment with both ends in one of the half-planes `re ≥ 1/13`, `re ≤ −1/13`, `im ≥ 1/13`, `im ≤ −1/13` misses `B(0, 1/13)`. -/
theorem norm_ge_of_mem_segment_far {a b z : ℂ}
    (h : (1 / 13 ≤ a.re ∧ 1 / 13 ≤ b.re) ∨ (a.re ≤ -1 / 13 ∧ b.re ≤ -1 / 13) ∨ (1 / 13 ≤ a.im ∧ 1 / 13 ≤ b.im) ∨
      (a.im ≤ -1 / 13 ∧ b.im ≤ -1 / 13)) (hz : z ∈ segment ℝ a b) : 1 / 13 ≤ ‖z‖ := by
  have hre := Complex.abs_re_le_norm z
  have him := Complex.abs_im_le_norm z
  rcases h with ⟨ha, hb⟩ | ⟨ha, hb⟩ | ⟨ha, hb⟩ | ⟨ha, hb⟩
  · have : 1 / 13 ≤ z.re := (convex_halfSpace_re_ge (1 / 13)).segment_subset ha hb hz
    linarith [le_abs_self z.re]
  · have : z.re ≤ -1 / 13 := (convex_halfSpace_re_le (-1 / 13)).segment_subset ha hb hz
    linarith [neg_le_abs z.re]
  · have : 1 / 13 ≤ z.im := (convex_halfSpace_im_ge (1 / 13)).segment_subset ha hb hz
    linarith [le_abs_self z.im]
  · have : z.im ≤ -1 / 13 := (convex_halfSpace_im_le (-1 / 13)).segment_subset ha hb hz
    linarith [neg_le_abs z.im]

/-- A point of `ω(i)` within `1/13` of `0` lies on the bowtie's arc of `ω(i)`, at the angle `3π/2 + arcsin (re z)`. -/
theorem mem_bowtieArc_N {z : ℂ} (hz : ‖z‖ < 1 / 13) (h1 : ‖z - I‖ = 1) :
    z ∈ (Arc.circ I 1 (3 * π / 2 - bowtieAngle) (3 * π / 2 + bowtieAngle)).carrier := by
  have hre : |z.re| < 1 / 13 := (Complex.abs_re_le_norm z).trans_lt hz
  have him : |z.im| < 1 / 13 := (Complex.abs_im_le_norm z).trans_lt hz
  have hsq : z.re ^ 2 + (z.im - 1) ^ 2 = 1 := by
    have h2 : ‖z - I‖ ^ 2 = 1 := by rw [h1]; norm_num
    rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply] at h2
    simp only [Complex.sub_re, Complex.sub_im, Complex.I_re, Complex.I_im, sub_zero] at h2
    nlinarith
  have hx1 : -1 ≤ z.re := by linarith [(abs_lt.mp hre).1]
  have hx2 : z.re ≤ 1 := by linarith [(abs_lt.mp hre).2]
  have hsin : Real.sin (Real.arcsin z.re) = z.re := Real.sin_arcsin hx1 hx2
  have hcos : Real.cos (Real.arcsin z.re) = 1 - z.im := by
    rw [Real.cos_arcsin, show 1 - z.re ^ 2 = (1 - z.im) ^ 2 by nlinarith]
    exact Real.sqrt_sq (by linarith [(abs_lt.mp him).2])
  have hl : -bowtieAngle ≤ Real.arcsin z.re := by
    unfold bowtieAngle; rw [← Real.arcsin_neg]; exact Real.arcsin_le_arcsin (by linarith [(abs_lt.mp hre).1])
  have hu : Real.arcsin z.re ≤ bowtieAngle := Real.arcsin_le_arcsin (by linarith [(abs_lt.mp hre).2])
  refine ⟨3 * π / 2 + Real.arcsin z.re, ⟨by linarith, by linarith⟩, ?_⟩
  have h3 : 3 * π / 2 + Real.arcsin z.re = (Real.arcsin z.re - π / 2) + 2 * π := by ring
  apply Complex.ext
  · simp only [Complex.add_re, Complex.I_re, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e, h3,
      Real.cos_add_two_pi, Real.sin_add_two_pi, Real.cos_sub_pi_div_two, Real.sin_sub_pi_div_two, hsin]
    ring
  · simp only [Complex.add_im, Complex.I_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e, h3,
      Real.cos_add_two_pi, Real.sin_add_two_pi, Real.cos_sub_pi_div_two, Real.sin_sub_pi_div_two, hcos]
    ring

/-- A point of `ω(−i)` within `1/13` of `0` lies on the bowtie's arc of `ω(−i)`, at the angle `π/2 − arcsin (re z)`. -/
theorem mem_bowtieArc_S {z : ℂ} (hz : ‖z‖ < 1 / 13) (h1 : ‖z + I‖ = 1) :
    z ∈ (Arc.circ (-I) 1 (π / 2 - bowtieAngle) (π / 2 + bowtieAngle)).carrier := by
  have hre : |z.re| < 1 / 13 := (Complex.abs_re_le_norm z).trans_lt hz
  have him : |z.im| < 1 / 13 := (Complex.abs_im_le_norm z).trans_lt hz
  have hsq : z.re ^ 2 + (z.im + 1) ^ 2 = 1 := by
    have h2 : ‖z + I‖ ^ 2 = 1 := by rw [h1]; norm_num
    rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply] at h2
    simp only [Complex.add_re, Complex.add_im, Complex.I_re, Complex.I_im, add_zero] at h2
    nlinarith
  have hx1 : -1 ≤ z.re := by linarith [(abs_lt.mp hre).1]
  have hx2 : z.re ≤ 1 := by linarith [(abs_lt.mp hre).2]
  have hsin : Real.sin (Real.arcsin z.re) = z.re := Real.sin_arcsin hx1 hx2
  have hcos : Real.cos (Real.arcsin z.re) = 1 + z.im := by
    rw [Real.cos_arcsin, show 1 - z.re ^ 2 = (1 + z.im) ^ 2 by nlinarith]
    exact Real.sqrt_sq (by linarith [(abs_lt.mp him).1])
  have hl : -bowtieAngle ≤ Real.arcsin z.re := by
    unfold bowtieAngle; rw [← Real.arcsin_neg]; exact Real.arcsin_le_arcsin (by linarith [(abs_lt.mp hre).1])
  have hu : Real.arcsin z.re ≤ bowtieAngle := Real.arcsin_le_arcsin (by linarith [(abs_lt.mp hre).2])
  refine ⟨π / 2 - Real.arcsin z.re, ⟨by linarith, by linarith⟩, ?_⟩
  apply Complex.ext
  · simp only [Complex.add_re, Complex.neg_re, Complex.I_re, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, re_e,
      im_e, Real.cos_pi_div_two_sub, Real.sin_pi_div_two_sub, hsin]
    ring
  · simp only [Complex.add_im, Complex.neg_im, Complex.I_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e,
      im_e, Real.cos_pi_div_two_sub, Real.sin_pi_div_two_sub, hcos]
    ring

/-- Within `1/13` of `0` a point lies on a boundary piece of the bowtie exactly when it lies on `ω(i)` or `ω(−i)`. -/
theorem mem_bowtieArcs_iff_of_norm_lt {z : ℂ} (hz : ‖z‖ < 1 / 13) :
    z ∈ ⋃ a ∈ bowtieArcs, a.carrier ↔ ‖z - I‖ = 1 ∨ ‖z + I‖ = 1 := by
  constructor
  · intro h
    obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
    simp only [bowtieArcs, mem_setOf_eq, List.mem_cons, List.not_mem_nil, or_false] at ha
    rcases ha with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
      rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · left; obtain ⟨θ, -, rfl⟩ := hza; simp
    · right; obtain ⟨θ, -, rfl⟩ := hza; simp
    all_goals exact absurd (norm_ge_of_mem_segment_far (by norm_num [pt]) hza) (not_le.mpr hz)
  · rintro (h | h)
    · exact mem_iUnion₂.mpr ⟨_, by simp [bowtieArcs], mem_bowtieArc_N hz h⟩
    · exact mem_iUnion₂.mpr ⟨_, by simp [bowtieArcs], mem_bowtieArc_S hz h⟩

/-- The cusp's pieces at radius `r ≤ 1/13` lie in the bowtie's tiles: the horns in `C`, the upper disc's part in `G`, the lower's in `H`. -/
theorem cuspPiece_subset_bowtie {r : ℝ} (hr : r ≤ 1 / 13) :
    cuspPiece r 0 ⊆ bowtieC ∧ cuspPiece r 1 ⊆ bowtieC ∧ cuspPiece r 2 ⊆ bowtieG ∧ cuspPiece r 3 ⊆ bowtieH := by
  have hb : ∀ z : ℂ, ‖z‖ < r → |z.re| < 1 / 13 ∧ |z.im| < 1 / 13 := fun z hz =>
    ⟨(Complex.abs_re_le_norm z).trans_lt (hz.trans_le hr), (Complex.abs_im_le_norm z).trans_lt (hz.trans_le hr)⟩
  refine ⟨fun z hz => ?_, fun z hz => ?_, fun z hz => ?_, fun z hz => ?_⟩
  · obtain ⟨h0, h1, h2, h3⟩ := (hornSet_cusp_iff r z).mp hz
    obtain ⟨hre, him⟩ := hb z h0
    exact ⟨h1.ne', by linarith, him, h3, h2⟩
  · obtain ⟨h0, h1, h2, h3⟩ := mem_cuspPiece_one.mp hz
    obtain ⟨hre, him⟩ := hb z h0
    exact ⟨h1.ne, by linarith, him, h3, h2⟩
  · obtain ⟨h0, h1⟩ := hz
    rw [mem_ball_zero_iff] at h0; rw [mem_ball, dist_eq_norm] at h1
    obtain ⟨hre, him⟩ := hb z h0
    exact ⟨h1, by linarith [(abs_lt.mp him).2], by linarith [(abs_lt.mp him).2]⟩
  · obtain ⟨h0, h1⟩ := hz
    rw [mem_ball_zero_iff] at h0; rw [mem_ball, dist_eq_norm, sub_neg_eq_add] at h1
    obtain ⟨hre, him⟩ := hb z h0
    exact ⟨h1, by linarith [(abs_lt.mp him).1], by linarith [(abs_lt.mp him).1]⟩

/-- The bowtie's colour on `G` is `0`. -/
theorem bowtieCol_of_mem_G {z : ℂ} (hz : z ∈ bowtieG) : bowtieCol z = 0 := by
  unfold bowtieCol; rw [if_pos hz]

/-- The bowtie's colour on `C` is `1` (`C` lies outside the unit disc about `i`, so off `G`). -/
theorem bowtieCol_of_mem_C {z : ℂ} (hz : z ∈ bowtieC) : bowtieCol z = 1 := by
  have hG : z ∉ bowtieG := fun h => by linarith [h.1, hz.2.2.2.1]
  unfold bowtieCol; rw [if_neg hG, if_pos (show z ∈ bowtieC ∪ bowtieCN ∪ bowtieCS from Or.inl (Or.inl hz))]

/-- The bowtie's colour on `H` is `2` (`H` misses `G`, `C`, `CN`, `CS`). -/
theorem bowtieCol_of_mem_H {z : ℂ} (hz : z ∈ bowtieH) : bowtieCol z = 2 := by
  obtain ⟨h1, h2, h3⟩ := hz
  have hsum := norm_sub_I_sq_add z
  have hG : z ∉ bowtieG := fun h => by nlinarith [h.1, norm_nonneg z, norm_nonneg (z - I), norm_nonneg (z + I)]
  have him : z.im < 0 := by
    have : |(z + I).im| < 1 := (Complex.abs_im_le_norm _).trans_lt h1
    simp only [Complex.add_im, Complex.I_im] at this
    linarith [(abs_lt.mp this).2]
  have hC : z ∉ bowtieC ∪ bowtieCN ∪ bowtieCS := by
    rintro ((h | h) | h)
    · linarith [h.2.2.2.2]
    · linarith [h.1, abs_nonneg z.re]
    · linarith [h.1, abs_nonneg z.re]
  unfold bowtieCol; rw [if_neg hG, if_neg hC, if_pos (show z ∈ bowtieH from ⟨h1, h2, h3⟩)]

/-- The bowtie's colours on the cusp's pieces at `r ≤ 1/13`: `1` on the horns, `0` on the upper disc's part, `2` on the lower's. -/
theorem bowtieCol_cuspPiece {r : ℝ} (hr : r ≤ 1 / 13) {z : ℂ} :
    (z ∈ cuspPiece r 0 → bowtieCol z = 1) ∧ (z ∈ cuspPiece r 1 → bowtieCol z = 1) ∧ (z ∈ cuspPiece r 2 → bowtieCol z = 0) ∧
      (z ∈ cuspPiece r 3 → bowtieCol z = 2) := by
  obtain ⟨h0, h1, h2, h3⟩ := cuspPiece_subset_bowtie hr
  exact ⟨fun h => bowtieCol_of_mem_C (h0 h), fun h => bowtieCol_of_mem_C (h1 h), fun h => bowtieCol_of_mem_G (h2 h),
    fun h => bowtieCol_of_mem_H (h3 h)⟩

/-- `B(0, 1/13)` lies in the bowtie's domain: off the two unit circles (a closed set with empty interior) its points lie in the cusp's
pieces, hence in the tiles. -/
theorem ball_subset_bowtie_dom : ball (0 : ℂ) (1 / 13) ⊆ bowtie.dom := by
  refine interior_maximal ?_ isOpen_ball
  have hint : interior (sphere I 1 ∪ sphere (-I) 1) = ∅ := by
    rw [interior_union_isClosed_of_interior_empty isClosed_sphere (interior_sphere _ one_ne_zero), interior_sphere _ one_ne_zero]
  have hd : Dense (sphere I 1 ∪ sphere (-I) 1)ᶜ := interior_eq_empty_iff_dense_compl.mp hint
  refine (hd.open_subset_closure_inter isOpen_ball).trans (closure_mono ?_)
  rintro z ⟨hz, hS⟩
  rw [mem_ball_zero_iff] at hz
  simp only [mem_compl_iff, mem_union, mem_sphere_iff_norm, sub_neg_eq_add, not_or] at hS
  have hI : z ∈ cuspFrag.interiorPts ∩ ball 0 (1 / 13) :=
    ⟨cuspFrag_mem_interiorPts.mpr ⟨by linarith, hS.1, hS.2⟩, mem_ball_zero_iff.mpr hz⟩
  rw [cuspFrag_partition (by norm_num), mem_iUnion] at hI
  obtain ⟨i, hi⟩ := hI
  obtain ⟨h0, h1, h2, h3⟩ := cuspPiece_subset_bowtie (r := 1 / 13) le_rfl
  simp only [bowtieTiles, mem_union]
  fin_cases i
  · exact Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inr (h0 hi)))))))))
  · exact Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inr (h1 hi)))))))))
  · exact Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (h2 hi))))))))))
  · exact Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inr (h3 hi))))))))))

/-- A line `a·re + b·im = c` (`(a, b) ≠ 0`) has empty interior: moving off it along `(a, b)` changes the left side. -/
theorem interior_line_eq_empty {a b c : ℝ} (h : a ≠ 0 ∨ b ≠ 0) : interior {z : ℂ | a * z.re + b * z.im = c} = ∅ := by
  rw [Set.eq_empty_iff_forall_notMem]
  intro z hz
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp isOpen_interior z hz
  have hab : 0 < a ^ 2 + b ^ 2 := by rcases h with h | h <;> positivity
  set t : ℝ := ε / (2 * (|a| + |b| + 1)) with ht
  have hd : 0 < 2 * (|a| + |b| + 1) := by positivity
  have ht0 : 0 < t := div_pos hε hd
  set w : ℂ := z + (t : ℂ) * ((a : ℂ) + (b : ℂ) * I) with hw
  have hwb : w ∈ ball z ε := by
    rw [mem_ball, dist_eq_norm, hw, add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]
    have h1 : ‖(a : ℂ) + (b : ℂ) * I‖ ≤ |a| + |b| := by
      refine (norm_add_le _ _).trans ?_
      rw [norm_mul, Complex.norm_I, mul_one, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs, Real.norm_eq_abs]
    have h2 : t * (|a| + |b|) < ε := by
      rw [ht, div_mul_eq_mul_div, div_lt_iff₀ hd]; nlinarith [abs_nonneg a, abs_nonneg b]
    calc t * ‖(a : ℂ) + (b : ℂ) * I‖ ≤ t * (|a| + |b|) := mul_le_mul_of_nonneg_left h1 ht0.le
      _ < ε := h2
  have h1 : a * w.re + b * w.im = c := (interior_subset (hball hwb) : w ∈ {z : ℂ | a * z.re + b * z.im = c})
  have h0 : a * z.re + b * z.im = c := (interior_subset hz : z ∈ {z : ℂ | a * z.re + b * z.im = c})
  have hre : w.re = z.re + t * a := by simp [hw]
  have him : w.im = z.im + t * b := by simp [hw]
  rw [hre, him] at h1
  nlinarith [mul_pos ht0 hab]

/-- A line `a·re + b·im = c` is closed. -/
theorem isClosed_line (a b c : ℝ) : IsClosed {z : ℂ | a * z.re + b * z.im = c} :=
  isClosed_eq (by fun_prop) continuous_const

/-- Four lines (each `(aᵢ, bᵢ) ≠ 0`) have a union with empty interior, so its complement is dense. -/
theorem dense_compl_four_lines {a₁ b₁ c₁ a₂ b₂ c₂ a₃ b₃ c₃ a₄ b₄ c₄ : ℝ} (h₁ : a₁ ≠ 0 ∨ b₁ ≠ 0) (h₂ : a₂ ≠ 0 ∨ b₂ ≠ 0)
    (h₃ : a₃ ≠ 0 ∨ b₃ ≠ 0) (h₄ : a₄ ≠ 0 ∨ b₄ ≠ 0) :
    Dense ({z : ℂ | a₁ * z.re + b₁ * z.im = c₁} ∪ {z | a₂ * z.re + b₂ * z.im = c₂} ∪ {z | a₃ * z.re + b₃ * z.im = c₃} ∪
      {z | a₄ * z.re + b₄ * z.im = c₄})ᶜ := by
  rw [← interior_eq_empty_iff_dense_compl,
    interior_union_isClosed_of_interior_empty (((isClosed_line _ _ _).union (isClosed_line _ _ _)).union (isClosed_line _ _ _))
      (interior_line_eq_empty h₄),
    interior_union_isClosed_of_interior_empty ((isClosed_line _ _ _).union (isClosed_line _ _ _)) (interior_line_eq_empty h₃),
    interior_union_isClosed_of_interior_empty (isClosed_line _ _ _) (interior_line_eq_empty h₂), interior_line_eq_empty h₁]

/-- Each tile of the bowtie lies in the union of its tiles. -/
theorem subset_bowtieTiles :
    bowtieG ⊆ bowtieTiles ∧ bowtieH ⊆ bowtieTiles ∧ bowtieCN ⊆ bowtieTiles ∧ bowtieCS ⊆ bowtieTiles ∧ bowtieX 1 ⊆ bowtieTiles ∧
      bowtieX (-1) ⊆ bowtieTiles ∧ bowtieY 1 ⊆ bowtieTiles ∧ bowtieY (-1) ⊆ bowtieTiles := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩ <;> intro z hz <;> simp only [bowtieTiles, mem_union] <;> tauto

/-- Near `N = i`, off the four edge lines through `i` (`12x ± 5(y − 1) = 0`... as `±12x + 5y = 5`, and `y − 1 = ±x`), the bowtie's tiles
`G`, `CN`, `XR`, `XL` cover `B(i, 1/10)`. -/
theorem ball_I_subset_closure_bowtieTiles : ball I (1 / 10) ⊆ closure bowtieTiles := by
  have hd := dense_compl_four_lines (a₁ := 12) (b₁ := 5) (c₁ := 5) (a₂ := -12) (b₂ := 5) (c₂ := 5) (a₃ := 1) (b₃ := -1) (c₃ := -1)
    (a₄ := 1) (b₄ := 1) (c₄ := 1) (by norm_num) (by norm_num) (by norm_num) (by norm_num)
  refine (hd.open_subset_closure_inter isOpen_ball).trans (closure_mono ?_)
  rintro z ⟨hz, hL⟩
  simp only [mem_compl_iff, mem_union, mem_setOf_eq, not_or] at hL
  obtain ⟨⟨⟨l1, l2⟩, l3⟩, l4⟩ := hL
  rw [mem_ball, dist_eq_norm] at hz
  have hx : |z.re| < 1 / 10 := by
    have := Complex.abs_re_le_norm (z - I); simp only [Complex.sub_re, Complex.I_re, sub_zero] at this; linarith
  have hy : |z.im - 1| < 1 / 10 := by
    have := Complex.abs_im_le_norm (z - I); simp only [Complex.sub_im, Complex.I_im] at this; linarith
  have hx' := abs_lt.mp hx
  have hy' := abs_lt.mp hy
  obtain ⟨tG, -, tCN, -, tXR, tXL, -, -⟩ := subset_bowtieTiles
  by_cases hG : 12 * |z.re| < 5 * (1 - z.im)
  · exact tG ⟨by linarith, by linarith [abs_nonneg z.re], hG⟩
  by_cases hC : |z.re| < z.im - 1
  · exact tCN ⟨hC, by linarith⟩
  push Not at hG hC
  have l1' : 12 * z.re + 5 * z.im ≠ 5 := l1
  have l2' : -12 * z.re + 5 * z.im ≠ 5 := l2
  have l3' : 1 * z.re + -1 * z.im ≠ -1 := l3
  have l4' : 1 * z.re + 1 * z.im ≠ 1 := l4
  rcases lt_trichotomy z.re 0 with h | h | h
  · rw [abs_of_neg h] at hG hC
    refine tXL ⟨?_, ?_, by linarith, by linarith⟩
    · rcases lt_or_gt_of_ne l2' with h' | h'
      · exfalso; linarith
      · linarith
    · rcases lt_or_gt_of_ne l4' with h' | h'
      · linarith
      · exfalso; linarith
  · exfalso
    rw [h, abs_zero] at hG hC
    apply l1'; rw [h]; linarith
  · rw [abs_of_pos h] at hG hC
    refine tXR ⟨?_, ?_, by linarith, by linarith⟩
    · rcases lt_or_gt_of_ne l1' with h' | h'
      · exfalso; linarith
      · linarith
    · rcases lt_or_gt_of_ne l3' with h' | h'
      · exfalso; linarith
      · linarith

/-- Near `S′ = −i`, the mirror: `H`, `CS`, `YR`, `YL` cover `B(−i, 1/10)` off the four edge lines through `−i`. -/
theorem ball_negI_subset_closure_bowtieTiles : ball (-I) (1 / 10) ⊆ closure bowtieTiles := by
  have hd := dense_compl_four_lines (a₁ := 12) (b₁ := -5) (c₁ := 5) (a₂ := 12) (b₂ := 5) (c₂ := -5) (a₃ := 1) (b₃ := 1) (c₃ := -1)
    (a₄ := 1) (b₄ := -1) (c₄ := 1) (by norm_num) (by norm_num) (by norm_num) (by norm_num)
  refine (hd.open_subset_closure_inter isOpen_ball).trans (closure_mono ?_)
  rintro z ⟨hz, hL⟩
  simp only [mem_compl_iff, mem_union, mem_setOf_eq, not_or] at hL
  obtain ⟨⟨⟨l1, l2⟩, l3⟩, l4⟩ := hL
  rw [mem_ball, dist_eq_norm, sub_neg_eq_add] at hz
  have hx : |z.re| < 1 / 10 := by
    have := Complex.abs_re_le_norm (z + I); simp only [Complex.add_re, Complex.I_re, add_zero] at this; linarith
  have hy : |z.im + 1| < 1 / 10 := by
    have := Complex.abs_im_le_norm (z + I); simp only [Complex.add_im, Complex.I_im] at this; linarith
  have hx' := abs_lt.mp hx
  have hy' := abs_lt.mp hy
  have hzI : ‖z + I‖ < 1 := by linarith
  obtain ⟨-, tH, -, tCS, -, -, tYR, tYL⟩ := subset_bowtieTiles
  by_cases hH : 12 * |z.re| < 5 * (1 + z.im)
  · exact tH ⟨hzI, by linarith [abs_nonneg z.re], hH⟩
  by_cases hC : |z.re| < -1 - z.im
  · exact tCS ⟨hC, by linarith⟩
  push Not at hH hC
  have l1' : 12 * z.re + -5 * z.im ≠ 5 := l1
  have l2' : 12 * z.re + 5 * z.im ≠ -5 := l2
  have l3' : 1 * z.re + 1 * z.im ≠ -1 := l3
  have l4' : 1 * z.re + -1 * z.im ≠ 1 := l4
  rcases lt_trichotomy z.re 0 with h | h | h
  · rw [abs_of_neg h] at hH hC
    refine tYL ⟨?_, ?_, by linarith, by linarith⟩
    · rcases lt_or_gt_of_ne l2' with h' | h'
      · linarith
      · exfalso; linarith
    · rcases lt_or_gt_of_ne l4' with h' | h'
      · linarith
      · exfalso; linarith
  · exfalso
    rw [h, abs_zero] at hH hC
    apply l1'; rw [h]; linarith
  · rw [abs_of_pos h] at hH hC
    refine tYR ⟨?_, ?_, by linarith, by linarith⟩
    · rcases lt_or_gt_of_ne l1' with h' | h'
      · exfalso; linarith
      · linarith
    · rcases lt_or_gt_of_ne l3' with h' | h'
      · exfalso; linarith
      · linarith

/-- **The bowtie at `E`**: for `0 < r ≤ 1/13` its interior points in `B(0, r)` are the cusp's four pieces. -/
theorem bowtie_partition {r : ℝ} (hr : r ≤ 1 / 13) : bowtie.interiorPts ∩ ball 0 r = ⋃ i, cuspPiece r i := by
  rw [← cuspFrag_partition (by linarith : r ≤ 1 / 2)]
  ext z
  simp only [mem_inter_iff, mem_ball_zero_iff]
  constructor
  · rintro ⟨⟨-, hΓ⟩, hz⟩
    refine ⟨cuspFrag_mem_interiorPts.mpr ⟨by linarith, fun h => ?_, fun h => ?_⟩, hz⟩
    · exact hΓ ((mem_bowtieArcs_iff_of_norm_lt (by linarith)).mpr (Or.inl h))
    · exact hΓ ((mem_bowtieArcs_iff_of_norm_lt (by linarith)).mpr (Or.inr h))
  · rintro ⟨hI, hz⟩
    obtain ⟨-, h1, h2⟩ := cuspFrag_mem_interiorPts.mp hI
    refine ⟨⟨ball_subset_bowtie_dom (mem_ball_zero_iff.mpr (by linarith)), fun h => ?_⟩, hz⟩
    rcases (mem_bowtieArcs_iff_of_norm_lt (by linarith)).mp h with h | h
    exacts [h1 h, h2 h]

/-- The horn along `e π` at `0` with bounding curvatures `−1`, `1` is the cusp's left horn. -/
theorem hornSet_cusp_pi_eq (r : ℝ) : hornSet 0 π (-1) 1 r = cuspPiece r 1 := by
  ext z
  show _ ↔ z ∈ (fun z => -(starRingEnd ℂ z)) '' hornSet 0 0 (-1) 1 r
  rw [mem_cuspPiece_one]
  have hfx : frameX 0 π z = -z.re := by
    simp [frameX, e_eq, Real.cos_pi, Real.sin_pi]
  simp only [hornSet, tanAbove_neg_one_iff, tanBelow_one_iff, mem_setOf_eq, hfx, e_pi_add_pi_div_two, dist_eq_norm,
    sub_zero, zero_add, sub_neg_eq_add]
  constructor
  · rintro ⟨h1, h2, h3, h4⟩; exact ⟨h1, by linarith, h4, h3⟩
  · rintro ⟨h1, h2, h3, h4⟩; exact ⟨h1, by linarith, h4, h3⟩

/-- For `0 < r ≤ 1/13`, each of the cusp's pieces is a sector of the bowtie at `0`. -/
theorem bowtie_isSector_cuspPiece {r : ℝ} (hr0 : 0 < r) (hr : r ≤ 1 / 13) (i : Fin 4) :
    bowtie.IsSector 0 r (cuspPiece r i) := by
  obtain ⟨ho, hp, hd, hn, hc⟩ := cuspPiece_data hr0 (by linarith)
  exact (isSector_iff_of_partition (bowtie_partition hr) ho hp hd hn hc).mpr ⟨i, rfl⟩

/-- For `r ≤ 1/13`, the cusp's disc parts are inside the bowtie's classes `0` (upper) and `2` (lower). -/
theorem cuspPiece_subset_bowtie_region {r : ℝ} (hr : r ≤ 1 / 13) :
    cuspPiece r 2 ⊆ bowtie.region 0 ∧ cuspPiece r 3 ⊆ bowtie.region 2 := by
  have hU := bowtie_partition hr
  have hint : ∀ i, ∀ z ∈ cuspPiece r i, z ∈ bowtie.interiorPts := fun i z hz => by
    have : z ∈ bowtie.interiorPts ∩ ball 0 r := by rw [hU]; exact mem_iUnion.mpr ⟨i, hz⟩
    exact this.1
  exact ⟨fun z hz => ⟨hint 2 z hz, (bowtieCol_cuspPiece hr).2.2.1 hz⟩,
    fun z hz => ⟨hint 3 z hz, (bowtieCol_cuspPiece hr).2.2.2 hz⟩⟩

/-! ### The bowtie is valid (FS131-I4f): YB3's same-colour pairs, by colour class -/

/-- `dist x y = 1` in coordinates. -/
theorem sq_coords_of_dist_eq_one {x y : ℂ} (h : dist x y = 1) : (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 = 1 := by
  rw [Complex.dist_eq_re_im] at h
  have h0 : 0 ≤ (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 := by positivity
  have := Real.sq_sqrt h0
  rw [h] at this; linarith

/-- Two points of the sector `G` are less than `1` apart: its half-angle `arcsin (5/13)` is below `30°`. -/
theorem dist_lt_one_of_mem_bowtieG {x y : ℂ} (hx : x ∈ bowtieG) (hy : y ∈ bowtieG) : (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 < 1 := by
  obtain ⟨hx1, -, hx3⟩ := hx
  obtain ⟨hy1, -, hy3⟩ := hy
  have nx := norm_sub_I_sq x
  have ny := norm_sub_I_sq y
  have ex : ‖x - I‖ ^ 2 < 1 := by nlinarith [norm_nonneg (x - I)]
  have ey : ‖y - I‖ ^ 2 < 1 := by nlinarith [norm_nonneg (y - I)]
  set p := 1 - x.im with hp
  set q := 1 - y.im with hq
  have hp0 : 0 < p := by linarith [abs_nonneg x.re]
  have hq0 : 0 < q := by linarith [abs_nonneg y.re]
  have hax : x.re ^ 2 * 144 < 25 * p ^ 2 := by
    have : (12 * |x.re|) ^ 2 < (5 * p) ^ 2 := by
      apply pow_lt_pow_left₀ hx3 (by positivity) (by norm_num)
    nlinarith [sq_abs x.re]
  have hay : y.re ^ 2 * 144 < 25 * q ^ 2 := by
    have : (12 * |y.re|) ^ 2 < (5 * q) ^ 2 := by
      apply pow_lt_pow_left₀ hy3 (by positivity) (by norm_num)
    nlinarith [sq_abs y.re]
  set ra := x.re ^ 2 + p ^ 2 with hra
  set rb := y.re ^ 2 + q ^ 2 with hrb
  have hra1 : ra < 1 := by rw [hra, hp]; nlinarith
  have hrb1 : rb < 1 := by rw [hrb, hq]; nlinarith
  have hpa : 144 * ra ≤ 169 * p ^ 2 := by nlinarith
  have hqb : 144 * rb ≤ 169 * q ^ 2 := by nlinarith
  have hxy : -(2 * (x.re * y.re)) ≤ 50 / 144 * (p * q) := by
    have h1 : |x.re| * 12 ≤ 5 * p := by linarith
    have h2 : |y.re| * 12 ≤ 5 * q := by linarith
    have h3 : |x.re| * |y.re| * 144 ≤ 25 * (p * q) := by
      nlinarith [abs_nonneg x.re, abs_nonneg y.re]
    have h4 : -(x.re * y.re) ≤ |x.re| * |y.re| := by rw [← abs_mul]; exact neg_le_abs _
    linarith
  have hD : (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 = ra + rb - 2 * (x.re * y.re) - 2 * (p * q) := by
    rw [hra, hrb, hp, hq]; ring
  rw [hD]
  have hra0 : 0 ≤ ra := by positivity
  have hrb0 : 0 ≤ rb := by positivity
  rcases le_total ra rb with h | h
  · have hm : 144 * ra ≤ 169 * (p * q) := by
      have hpp : 144 * ra ≤ 169 * p ^ 2 := hpa
      have hqq : 144 * ra ≤ 169 * q ^ 2 := by linarith
      by_contra hc
      push Not at hc
      have hpq0 : 0 ≤ p * q := by positivity
      have : (169 * (p * q)) ^ 2 < (144 * ra) ^ 2 := by
        apply pow_lt_pow_left₀ hc (by positivity) (by norm_num)
      nlinarith [mul_le_mul hpp hqq (by positivity) (by positivity)]
    linarith
  · have hm : 144 * rb ≤ 169 * (p * q) := by
      have hqq : 144 * rb ≤ 169 * q ^ 2 := hqb
      have hpp : 144 * rb ≤ 169 * p ^ 2 := by linarith
      by_contra hc
      push Not at hc
      have hpq0 : 0 ≤ p * q := by positivity
      have : (169 * (p * q)) ^ 2 < (144 * rb) ^ 2 := by
        apply pow_lt_pow_left₀ hc (by positivity) (by norm_num)
      nlinarith [mul_le_mul hpp hqq (by positivity) (by positivity)]
    linarith

/-- `H` is the mirror of `G` under conjugation. -/
theorem conj_mem_bowtieG_of_mem_bowtieH {z : ℂ} (hz : z ∈ bowtieH) : (starRingEnd ℂ) z ∈ bowtieG := by
  obtain ⟨h1, h2, h3⟩ := hz
  have hn : ‖(starRingEnd ℂ) z - I‖ = ‖z + I‖ := by
    rw [← Complex.norm_conj, map_sub, Complex.conj_conj, Complex.conj_I, sub_neg_eq_add]
  refine ⟨by rw [hn]; exact h1, ?_, ?_⟩
  · simp only [Complex.conj_im]; linarith
  · simp only [Complex.conj_re, Complex.conj_im]; linarith

/-- Two points of `H` are less than `1` apart. -/
theorem dist_lt_one_of_mem_bowtieH {x y : ℂ} (hx : x ∈ bowtieH) (hy : y ∈ bowtieH) : (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 < 1 := by
  have := dist_lt_one_of_mem_bowtieG (conj_mem_bowtieG_of_mem_bowtieH hx) (conj_mem_bowtieG_of_mem_bowtieH hy)
  simp only [Complex.conj_re, Complex.conj_im] at this
  nlinarith


/-- `C` is its own mirror under conjugation (the two circle conditions swap). -/
theorem conj_mem_bowtieC {z : ℂ} (hz : z ∈ bowtieC) : (starRingEnd ℂ) z ∈ bowtieC := by
  obtain ⟨h1, h2, h3, h4, h5⟩ := hz
  have hn1 : ‖(starRingEnd ℂ) z - I‖ = ‖z + I‖ := by
    rw [← Complex.norm_conj, map_sub, Complex.conj_conj, Complex.conj_I, sub_neg_eq_add]
  have hn2 : ‖(starRingEnd ℂ) z + I‖ = ‖z - I‖ := by
    rw [← Complex.norm_conj, map_add, Complex.conj_conj, Complex.conj_I, ← sub_eq_add_neg]
  refine ⟨by simpa using h1, by simpa using h2, by simpa using h3, by rw [hn1]; exact h5, by rw [hn2]; exact h4⟩

/-- `CS` is the mirror of `CN` under conjugation. -/
theorem conj_mem_bowtieCN_of_mem_bowtieCS {z : ℂ} (hz : z ∈ bowtieCS) : (starRingEnd ℂ) z ∈ bowtieCN := by
  obtain ⟨h1, h2⟩ := hz
  exact ⟨by simp only [Complex.conj_re, Complex.conj_im]; linarith, by simp only [Complex.conj_im]; linarith⟩

/-- A point of `C` and a point of `CN` are more than `1` apart: `CN` lies in the upward cone at `i`, `C` below `i` outside `ω(i)`. -/
theorem one_lt_of_mem_bowtieC_CN {x y : ℂ} (hx : x ∈ bowtieC) (hy : y ∈ bowtieCN) : 1 < (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 := by
  obtain ⟨-, hx2, hx3, hx4, -⟩ := hx
  obtain ⟨hy1, -⟩ := hy
  have nx := norm_sub_I_sq x
  have e4 := (one_lt_sq_iff₀ (norm_nonneg _)).mpr hx4
  have hb : x.im - 1 < -12 / 13 := by linarith [(abs_lt.mp hx3).2]
  have hd : 0 < y.im - 1 := by linarith [abs_nonneg y.re]
  have h1 : x.re * y.re ≤ |x.re| * |y.re| := by rw [← abs_mul]; exact le_abs_self _
  have h2 : |x.re| * |y.re| ≤ 5 / 13 * |y.re| := mul_le_mul_of_nonneg_right hx2.le (abs_nonneg _)
  have h3 : (x.im - 1) * (y.im - 1) < -12 / 13 * (y.im - 1) := mul_lt_mul_of_pos_right hb hd
  have h5 : (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 =
      (x.re ^ 2 + (x.im - 1) ^ 2) - 2 * (x.re * y.re + (x.im - 1) * (y.im - 1)) + (y.re ^ 2 + (y.im - 1) ^ 2) := by ring
  nlinarith [sq_nonneg y.re, sq_nonneg (y.im - 1)]

/-- Two points of colour `1` are never at distance `1`. -/
theorem sq_ne_one_of_bowtie_one {x y : ℂ} (hx : x ∈ bowtieC ∪ bowtieCN ∪ bowtieCS) (hy : y ∈ bowtieC ∪ bowtieCN ∪ bowtieCS) :
    (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 ≠ 1 := by
  have hCC : ∀ {x y : ℂ}, x ∈ bowtieC → y ∈ bowtieC → (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 < 1 := by
    intro x y hx hy
    obtain ⟨-, a2, a3, -, -⟩ := hx
    obtain ⟨-, b2, b3, -, -⟩ := hy
    have := abs_lt.mp a2; have := abs_lt.mp a3; have := abs_lt.mp b2; have := abs_lt.mp b3
    nlinarith
  have hNN : ∀ {x y : ℂ}, x ∈ bowtieCN → y ∈ bowtieCN → (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 < 1 := by
    intro x y hx hy
    obtain ⟨a1, a2⟩ := hx
    obtain ⟨b1, b2⟩ := hy
    have := abs_lt.mp a1; have := abs_lt.mp b1
    nlinarith [abs_nonneg x.re, abs_nonneg y.re]
  have hCS : ∀ {x y : ℂ}, x ∈ bowtieC → y ∈ bowtieCS → 1 < (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 := by
    intro x y hx hy
    have := one_lt_of_mem_bowtieC_CN (conj_mem_bowtieC hx) (conj_mem_bowtieCN_of_mem_bowtieCS hy)
    simp only [Complex.conj_re, Complex.conj_im] at this
    nlinarith
  have hSS : ∀ {x y : ℂ}, x ∈ bowtieCS → y ∈ bowtieCS → (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 < 1 := by
    intro x y hx hy
    have := hNN (conj_mem_bowtieCN_of_mem_bowtieCS hx) (conj_mem_bowtieCN_of_mem_bowtieCS hy)
    simp only [Complex.conj_re, Complex.conj_im] at this
    nlinarith
  have hNS : ∀ {x y : ℂ}, x ∈ bowtieCN → y ∈ bowtieCS → 1 < (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 := by
    intro x y hx hy
    obtain ⟨a1, -⟩ := hx
    obtain ⟨b1, -⟩ := hy
    nlinarith [abs_nonneg x.re, abs_nonneg y.re, sq_nonneg (x.re - y.re)]
  rcases hx with (hx | hx) | hx <;> rcases hy with (hy | hy) | hy
  · exact (hCC hx hy).ne
  · exact (one_lt_of_mem_bowtieC_CN hx hy).ne'
  · exact (hCS hx hy).ne'
  · have := one_lt_of_mem_bowtieC_CN hy hx; intro h; nlinarith
  · exact (hNN hx hy).ne
  · exact (hNS hx hy).ne'
  · have := hCS hy hx; intro h; nlinarith
  · have := hNS hy hx; intro h; nlinarith
  · exact (hSS hx hy).ne

/-- Two points of colour `3` (`σ = 1`) or `4` (`σ = −1`) are never at distance `1`. -/
theorem sq_ne_one_of_bowtie_XY {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) {x y : ℂ} (hx : x ∈ bowtieX σ ∪ bowtieY σ)
    (hy : y ∈ bowtieX σ ∪ bowtieY σ) : (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 ≠ 1 := by
  have hs : (x.re - y.re) ^ 2 = (σ * x.re - σ * y.re) ^ 2 := by rcases hσ with rfl | rfl <;> ring
  rw [hs]
  rcases hx with ⟨a1, a2, a3, a4⟩ | ⟨a1, a2, a3, a4⟩ <;> rcases hy with ⟨b1, b2, b3, b4⟩ | ⟨b1, b2, b3, b4⟩
  · have : 0 < σ * x.re := by linarith
    have : 0 < σ * y.re := by linarith
    nlinarith
  · nlinarith [sq_nonneg (σ * x.re - σ * y.re)]
  · nlinarith [sq_nonneg (σ * x.re - σ * y.re)]
  · have : 0 < σ * x.re := by linarith
    have : 0 < σ * y.re := by linarith
    nlinarith

/-- `Z±` lie in the box `|re| < 113/260`, `|im| < 11/65`, and so do their closures. -/
theorem closure_bowtieZ_subset {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) :
    closure (bowtieZ σ) ⊆ {z : ℂ | |z.re| ≤ 113 / 260} ∩ {z | |z.im| ≤ 11 / 65} := by
  refine closure_minimal (fun z hz => ⟨?_, hz.2.2.1.le⟩)
    ((isClosed_le (by fun_prop) continuous_const).inter (isClosed_le (by fun_prop) continuous_const))
  obtain ⟨h1, h2, -, -⟩ := hz
  show |z.re| ≤ 113 / 260
  rcases hσ with rfl | rfl
  · rw [abs_le]; constructor <;> linarith
  · rw [abs_le]; constructor <;> linarith

/-- An interior point of the bowtie lies in one of its nine open tiles `G`, `C`, `CN`, `CS`, `H`, `X±`, `Y±`, or in the closure of `Z±`
(each of the nine tiles' closures adds only boundary pieces). -/
theorem bowtie_interiorPts_cases {x : ℂ} (hx : x ∈ bowtie.interiorPts) :
    x ∈ bowtieG ∨ x ∈ bowtieC ∨ x ∈ bowtieCN ∨ x ∈ bowtieCS ∨ x ∈ bowtieH ∨ x ∈ bowtieX 1 ∨ x ∈ bowtieY 1 ∨
      x ∈ bowtieX (-1) ∨ x ∈ bowtieY (-1) ∨ x ∈ closure (bowtieZ 1) ∨ x ∈ closure (bowtieZ (-1)) := by
  obtain ⟨hd, hA⟩ := hx
  have hA' : x ∉ ⋃ a ∈ bowtieArcs, a.carrier := hA
  have hcl : x ∈ closure bowtieTiles := interior_subset hd
  simp only [bowtieTiles, closure_union, mem_union] at hcl
  have k : ∀ {U : Set ℂ}, closure U ⊆ U ∪ ⋃ a ∈ bowtieArcs, a.carrier → x ∈ closure U → x ∈ U :=
    fun h hU => (h hU).resolve_right hA'
  rcases hcl with ((((((((((h | h) | h) | h) | h) | h) | h) | h) | h) | h) | h)
  · exact Or.inl (k closure_bowtieG_subset h)
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (k closure_bowtieH_subset h)))))
  · exact Or.inr (Or.inl (k closure_bowtieC_subset h))
  · exact Or.inr (Or.inr (Or.inl (k closure_bowtieCN_subset h)))
  · exact Or.inr (Or.inr (Or.inr (Or.inl (k closure_bowtieCS_subset h))))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (k closure_bowtieX_one_subset h))))))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (k closure_bowtieX_neg_one_subset h))))))))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (k closure_bowtieY_one_subset h)))))))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (k closure_bowtieY_neg_one_subset h)))))))))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl h)))))))))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr h)))))))))

/-- The tiles each colour of the bowtie comes from (read off `bowtieCol`'s if-chain). -/
theorem bowtieCol_cases (x : ℂ) :
    (bowtieCol x = 0 → x ∈ bowtieG) ∧ (bowtieCol x = 1 → x ∈ bowtieC ∪ bowtieCN ∪ bowtieCS) ∧
      (bowtieCol x = 2 → x ∈ bowtieH) ∧ (bowtieCol x = 3 → x ∈ bowtieX 1 ∪ bowtieY 1) ∧
      (bowtieCol x = 4 → x ∈ bowtieX (-1) ∪ bowtieY (-1)) ∧
      (bowtieCol x = 5 → x ∉ bowtieG ∧ x ∉ bowtieC ∪ bowtieCN ∪ bowtieCS ∧ x ∉ bowtieH ∧ x ∉ bowtieX 1 ∪ bowtieY 1 ∧
        x ∉ bowtieX (-1) ∪ bowtieY (-1)) := by
  classical
  unfold bowtieCol
  split_ifs <;> simp_all

/-- **FS112-BOWTIE**: the fragment is valid (YB3: 21 of 21 same-colour tile pairs, exact). -/
theorem bowtie_valid : bowtie.Valid := by
  intro x hx y hy hxy hcol
  have hd := sq_coords_of_dist_eq_one hxy
  have hc : bowtieCol x = bowtieCol y := hcol
  obtain ⟨c0, c1, c2, c3, c4, -⟩ := bowtieCol_cases x
  obtain ⟨d0, d1, d2, d3, d4, -⟩ := bowtieCol_cases y
  have hbox : ∀ {z : ℂ}, z ∈ bowtie.interiorPts → bowtieCol z = 5 → |z.re| ≤ 113 / 260 ∧ |z.im| ≤ 11 / 65 := by
    intro z hz h5
    obtain ⟨n0, n1, n2, n3, n4⟩ := (bowtieCol_cases z).2.2.2.2.2 h5
    simp only [mem_union, not_or] at n1 n3 n4
    rcases bowtie_interiorPts_cases hz with h | h | h | h | h | h | h | h | h | h | h
    · exact absurd h n0
    · exact absurd h n1.1.1
    · exact absurd h n1.1.2
    · exact absurd h n1.2
    · exact absurd h n2
    · exact absurd h n3.1
    · exact absurd h n3.2
    · exact absurd h n4.1
    · exact absurd h n4.2
    · exact closure_bowtieZ_subset (Or.inl rfl) h
    · exact closure_bowtieZ_subset (Or.inr rfl) h
  generalize hj : bowtieCol y = j at hc
  fin_cases j
  · exact (dist_lt_one_of_mem_bowtieG (c0 hc) (d0 hj)).ne hd
  · exact sq_ne_one_of_bowtie_one (c1 hc) (d1 hj) hd
  · exact (dist_lt_one_of_mem_bowtieH (c2 hc) (d2 hj)).ne hd
  · exact sq_ne_one_of_bowtie_XY (Or.inl rfl) (c3 hc) (d3 hj) hd
  · exact sq_ne_one_of_bowtie_XY (Or.inr rfl) (c4 hc) (d4 hj) hd
  · obtain ⟨a1, a2⟩ := hbox hx hc
    obtain ⟨b1, b2⟩ := hbox hy hj
    have := abs_le.mp a1; have := abs_le.mp a2; have := abs_le.mp b1; have := abs_le.mp b2
    nlinarith


/-- `E = 0`, `N = i`, `S = −i` lie in the fragment's domain. -/
theorem bowtie_mem_dom : (0 : ℂ) ∈ bowtie.dom ∧ I ∈ bowtie.dom ∧ -I ∈ bowtie.dom :=
  ⟨ball_subset_bowtie_dom (mem_ball_self (by norm_num)),
    interior_maximal ball_I_subset_closure_bowtieTiles isOpen_ball (mem_ball_self (by norm_num)),
    interior_maximal ball_negI_subset_closure_bowtieTiles isOpen_ball (mem_ball_self (by norm_num))⟩

/-- `E` carries three colours: `0` (`G`), `1` (the horns), `2` (`H`); the horn colour has two sectors. -/
theorem bowtie_coloursAt_zero : bowtie.coloursAt 0 = {0, 1, 2} ∧ bowtie.HasSectors 0 1 2 := by
  have h13 : (0 : ℝ) < 1 / 13 := by norm_num
  refine ⟨?_, ?_⟩
  · obtain ⟨-, -, -, -, hc⟩ := cuspPiece_data h13 (by norm_num)
    have hU := bowtie_partition (r := 1 / 13) le_rfl
    have hcol0 : ∀ z, z ∈ cuspPiece (1 / 13) 0 → bowtieCol z = 1 := fun z => (bowtieCol_cuspPiece (r := 1 / 13) le_rfl (z := z)).1
    have hcol1 : ∀ z, z ∈ cuspPiece (1 / 13) 1 → bowtieCol z = 1 := fun z => (bowtieCol_cuspPiece (r := 1 / 13) le_rfl (z := z)).2.1
    have hcol2 : ∀ z, z ∈ cuspPiece (1 / 13) 2 → bowtieCol z = 0 := fun z => (bowtieCol_cuspPiece (r := 1 / 13) le_rfl (z := z)).2.2.1
    have hcol3 : ∀ z, z ∈ cuspPiece (1 / 13) 3 → bowtieCol z = 2 := fun z => (bowtieCol_cuspPiece (r := 1 / 13) le_rfl (z := z)).2.2.2
    have hint : ∀ i, ∀ z ∈ cuspPiece (1 / 13) i, z ∈ bowtie.interiorPts := fun i z hz => by
      have : z ∈ bowtie.interiorPts ∩ ball 0 (1 / 13) := by rw [hU]; exact mem_iUnion.mpr ⟨i, hz⟩
      exact this.1
    ext j
    simp only [mem_insert_iff, mem_singleton_iff]
    constructor
    · intro hj
      obtain ⟨z, ⟨hzI, hzc⟩, hz⟩ := Metric.mem_closure_iff.mp hj (1 / 13) h13
      have hzc' : bowtieCol z = j := hzc
      have hzU : z ∈ bowtie.interiorPts ∩ ball 0 (1 / 13) := ⟨hzI, by rw [mem_ball, dist_comm]; exact hz⟩
      rw [hU, mem_iUnion] at hzU
      obtain ⟨i, hi⟩ := hzU
      fin_cases i
      · exact Or.inr (Or.inl (hzc'.symm.trans (hcol0 z hi)))
      · exact Or.inr (Or.inl (hzc'.symm.trans (hcol1 z hi)))
      · exact Or.inl (hzc'.symm.trans (hcol2 z hi))
      · exact Or.inr (Or.inr (hzc'.symm.trans (hcol3 z hi)))
    · rintro (rfl | rfl | rfl)
      · show (0 : ℂ) ∈ closure (bowtie.region 0)
        exact closure_mono (cuspPiece_subset_bowtie_region (r := 1 / 13) le_rfl).1 (hc 2)
      · show (0 : ℂ) ∈ closure (bowtie.region 1)
        exact closure_mono (show cuspPiece (1 / 13) 0 ⊆ bowtie.region 1 from fun z hz => ⟨hint 0 z hz, hcol0 z hz⟩) (hc 0)
      · show (0 : ℂ) ∈ closure (bowtie.region 2)
        exact closure_mono (cuspPiece_subset_bowtie_region (r := 1 / 13) le_rfl).2 (hc 3)
  · filter_upwards [Ioc_mem_nhdsGT h13] with r hr
    obtain ⟨ho, hp, hd, hn, hc⟩ := cuspPiece_data hr.1 (by linarith [hr.2])
    have hU := bowtie_partition hr.2
    have hcol0 : ∀ z, z ∈ cuspPiece r 0 → bowtieCol z = 1 := fun z => (bowtieCol_cuspPiece hr.2 (z := z)).1
    have hcol1 : ∀ z, z ∈ cuspPiece r 1 → bowtieCol z = 1 := fun z => (bowtieCol_cuspPiece hr.2 (z := z)).2.1
    have hcol2 : ∀ z, z ∈ cuspPiece r 2 → bowtieCol z = 0 := fun z => (bowtieCol_cuspPiece hr.2 (z := z)).2.2.1
    have hcol3 : ∀ z, z ∈ cuspPiece r 3 → bowtieCol z = 2 := fun z => (bowtieCol_cuspPiece hr.2 (z := z)).2.2.2
    have hsec : bowtie.sectorsOf 0 r 1 = {cuspPiece r 0, cuspPiece r 1} := by
      ext S
      simp only [ArcMap.sectorsOf, mem_setOf_eq, mem_insert_iff, mem_singleton_iff]
      rw [isSector_iff_of_partition hU ho hp hd hn hc]
      constructor
      · rintro ⟨⟨i, rfl⟩, hS⟩
        fin_cases i
        · exact Or.inl rfl
        · exact Or.inr rfl
        · exfalso
          obtain ⟨z, hz⟩ := hn 2
          have h1 : bowtieCol z = 1 := hS hz
          rw [hcol2 z hz] at h1
          exact absurd h1 (by decide)
        · exfalso
          obtain ⟨z, hz⟩ := hn 3
          have h1 : bowtieCol z = 1 := hS hz
          rw [hcol3 z hz] at h1
          exact absurd h1 (by decide)
      · rintro (rfl | rfl)
        · exact ⟨⟨0, rfl⟩, fun z hz => hcol0 z hz⟩
        · exact ⟨⟨1, rfl⟩, fun z hz => hcol1 z hz⟩
    rw [hsec, Set.encard_pair]
    · rfl
    · intro h
      obtain ⟨z, hz⟩ := hn 0
      exact Set.disjoint_left.mp (hd 0 1 (by decide)) hz (h ▸ hz)

/-- **The horns**: colour `1` along `±a` (`a = e 0`), each between `ω(S)` (curvature `−1` in its frame) and `ω(N)` (curvature `1`) —
bounded by unit arcs on both sides. -/
theorem bowtie_isHorn : bowtie.IsHorn 0 0 (-1) 1 1 ∧ bowtie.IsHorn 0 π (-1) 1 1 := by
  have h13 : (0 : ℝ) < 1 / 13 := by norm_num
  refine ⟨⟨by norm_num, ?_⟩, ⟨by norm_num, ?_⟩⟩
  · filter_upwards [Ioc_mem_nhdsGT h13] with r hr
    exact ⟨bowtie_isSector_cuspPiece hr.1 hr.2 0, fun z hz => (bowtieCol_cuspPiece hr.2).1 hz⟩
  · filter_upwards [Ioc_mem_nhdsGT h13] with r hr
    rw [hornSet_cusp_pi_eq]
    exact ⟨bowtie_isSector_cuspPiece hr.1 hr.2 1, fun z hz => (bowtieCol_cuspPiece hr.2).2.1 hz⟩

/-- The horns' flanks: `G` (colour `0`) above and `H` (colour `2`) below (in the frame along `π`, `H` above and `G` below). -/
theorem bowtie_flanks : bowtie.IsFlankAbove 0 0 1 0 ∧ bowtie.IsFlankBelow 0 0 (-1) 2 ∧
    bowtie.IsFlankAbove 0 π 1 2 ∧ bowtie.IsFlankBelow 0 π (-1) 0 := by
  have h13 : (0 : ℝ) < 1 / 13 := by norm_num
  have hN : e (0 + π / 2) = I := by rw [zero_add, e_pi_div_two]
  refine ⟨⟨2, by norm_num, ?_⟩, ⟨-2, by norm_num, ?_⟩, ⟨2, by norm_num, ?_⟩, ⟨-2, by norm_num, ?_⟩⟩
  · filter_upwards [Ioc_mem_nhdsGT h13] with r hr
    rintro z ⟨h1, -, h3, -⟩
    rw [tanAbove_one_iff, hN, zero_add] at h3
    exact (cuspPiece_subset_bowtie_region hr.2).1 ⟨mem_ball.mpr h1, mem_ball.mpr h3⟩
  · filter_upwards [Ioc_mem_nhdsGT h13] with r hr
    rintro z ⟨h1, -, -, h4⟩
    rw [tanBelow_neg_one_iff, hN, zero_sub] at h4
    exact (cuspPiece_subset_bowtie_region hr.2).2 ⟨mem_ball.mpr h1, mem_ball.mpr h4⟩
  · filter_upwards [Ioc_mem_nhdsGT h13] with r hr
    rintro z ⟨h1, -, h3, -⟩
    rw [tanAbove_one_iff, e_pi_add_pi_div_two, zero_add] at h3
    exact (cuspPiece_subset_bowtie_region hr.2).2 ⟨mem_ball.mpr h1, mem_ball.mpr h3⟩
  · filter_upwards [Ioc_mem_nhdsGT h13] with r hr
    rintro z ⟨h1, -, -, h4⟩
    rw [tanBelow_neg_one_iff, e_pi_add_pi_div_two, zero_sub, neg_neg] at h4
    exact (cuspPiece_subset_bowtie_region hr.2).1 ⟨mem_ball.mpr h1, mem_ball.mpr h4⟩

/-! ### The bowtie near `N = i` and `S′ = −i`: classes `0` and `2` there, and the shadows of the horns (FS131-I4f) -/

/-- A point of a segment `[a, b]` is `a + t (b − a)` for some `t ∈ [0, 1]`, in coordinates. -/
theorem coords_of_mem_segment {a b z : ℂ} (hz : z ∈ segment ℝ a b) :
    ∃ t : ℝ, 0 ≤ t ∧ t ≤ 1 ∧ z.re = a.re + t * (b.re - a.re) ∧ z.im = a.im + t * (b.im - a.im) := by
  obtain ⟨s, t, hs, ht, hst, rfl⟩ := hz
  have hs' : s = 1 - t := by linarith
  subst hs'
  refine ⟨t, ht, by linarith, ?_, ?_⟩
  · simp only [Complex.add_re, Complex.smul_re, smul_eq_mul]; ring
  · simp only [Complex.add_im, Complex.smul_im, smul_eq_mul]; ring

/-- Within `1/10` of `N = i`, strictly inside `G`'s cone, a point lies on no boundary piece of the bowtie (the pieces near `i` are
`G`'s two edges and `CN`'s two edges through `i`). -/
theorem not_mem_bowtieArcs_near_I {z : ℂ} (hz : ‖z - I‖ < 1 / 10) (h1 : 12 * |z.re| < 5 * (1 - z.im)) :
    z ∉ ⋃ a ∈ bowtieArcs, a.carrier := by
  have hre : |z.re| < 1 / 10 := by
    have := Complex.abs_re_le_norm (z - I); simp only [Complex.sub_re, Complex.I_re, sub_zero] at this; linarith
  have him : |z.im - 1| < 1 / 10 := by
    have := Complex.abs_im_le_norm (z - I); simp only [Complex.sub_im, Complex.I_im] at this; linarith
  have hr1 := abs_lt.mp hre
  have hi1 := abs_lt.mp him
  have ha1 := le_abs_self z.re
  have ha2 := neg_le_abs z.re
  intro h
  obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
  simp only [bowtieArcs, mem_setOf_eq, List.mem_cons, List.not_mem_nil, or_false] at ha
  rcases ha with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
    rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · obtain ⟨θ, -, rfl⟩ := hza; simp at hz; norm_num at hz
  · obtain ⟨θ, -, rfl⟩ := hza
    simp only [Complex.add_im, Complex.neg_im, Complex.I_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e,
      one_mul, zero_mul, add_zero] at hi1
    linarith [Real.sin_le_one θ]
  all_goals obtain ⟨t, ht0, ht1, hre', him'⟩ := coords_of_mem_segment hza
  all_goals simp only [pt, Complex.I_re, Complex.I_im, Complex.neg_re, Complex.neg_im] at hre' him'
  all_goals linarith

/-- Within `1/10` of `S′ = −i`, strictly inside `H`'s cone, a point lies on no boundary piece of the bowtie. -/
theorem not_mem_bowtieArcs_near_negI {z : ℂ} (hz : ‖z + I‖ < 1 / 10) (h1 : 12 * |z.re| < 5 * (1 + z.im)) :
    z ∉ ⋃ a ∈ bowtieArcs, a.carrier := by
  have hre : |z.re| < 1 / 10 := by
    have := Complex.abs_re_le_norm (z + I); simp only [Complex.add_re, Complex.I_re, add_zero] at this; linarith
  have him : |z.im + 1| < 1 / 10 := by
    have := Complex.abs_im_le_norm (z + I); simp only [Complex.add_im, Complex.I_im] at this; linarith
  have hr1 := abs_lt.mp hre
  have hi1 := abs_lt.mp him
  have ha1 := le_abs_self z.re
  have ha2 := neg_le_abs z.re
  intro h
  obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
  simp only [bowtieArcs, mem_setOf_eq, List.mem_cons, List.not_mem_nil, or_false] at ha
  rcases ha with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
    rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · obtain ⟨θ, -, rfl⟩ := hza
    simp only [Complex.add_im, Complex.I_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e,
      one_mul, zero_mul, add_zero] at hi1
    linarith [Real.neg_one_le_sin θ]
  · obtain ⟨θ, -, rfl⟩ := hza; simp at hz; norm_num at hz
  all_goals obtain ⟨t, ht0, ht1, hre', him'⟩ := coords_of_mem_segment hza
  all_goals simp only [pt, Complex.I_re, Complex.I_im, Complex.neg_re, Complex.neg_im] at hre' him'
  all_goals linarith

/-- Each open tile of the bowtie lies in its domain. -/
theorem subset_bowtie_dom {U : Set ℂ} (hU : IsOpen U) (h : U ⊆ bowtieTiles) : U ⊆ bowtie.dom :=
  interior_maximal (h.trans subset_closure) hU

/-- `G` lies in the open unit disc about `E = 0`. -/
theorem bowtieG_subset_ball : bowtieG ⊆ ball 0 1 := by
  intro z ⟨h1, h2, h3⟩
  rw [mem_ball_zero_iff]
  have hs := norm_sub_I_sq z
  have e1 : ‖z - I‖ ^ 2 < 1 := by nlinarith [norm_nonneg (z - I)]
  have him : 0 < z.im := by nlinarith
  have hax : z.re ^ 2 * 144 < 25 * (1 - z.im) ^ 2 := by
    have : (12 * |z.re|) ^ 2 < (5 * (1 - z.im)) ^ 2 := pow_lt_pow_left₀ h3 (by positivity) (by norm_num)
    nlinarith [sq_abs z.re]
  have hn : ‖z‖ ^ 2 = z.re ^ 2 + z.im ^ 2 := by rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; ring
  have : ‖z‖ ^ 2 < 1 := by nlinarith
  nlinarith [norm_nonneg z]

/-- `H` lies in the open unit disc about `E = 0`. -/
theorem bowtieH_subset_ball : bowtieH ⊆ ball 0 1 := by
  intro z hz
  have := bowtieG_subset_ball (conj_mem_bowtieG_of_mem_bowtieH hz)
  rwa [mem_ball_zero_iff, Complex.norm_conj, ← mem_ball_zero_iff] at this

/-- A point of `G` within `1/10` of `i` is a point of the bowtie's class `0`. -/
theorem mem_bowtie_region_zero {z : ℂ} (hz : z ∈ bowtieG) (hI : ‖z - I‖ < 1 / 10) : z ∈ bowtie.region 0 :=
  ⟨⟨subset_bowtie_dom isOpen_bowtieG subset_bowtieTiles.1 hz, not_mem_bowtieArcs_near_I hI hz.2.2⟩, bowtieCol_of_mem_G hz⟩

/-- A point of `H` within `1/10` of `−i` is a point of the bowtie's class `2`. -/
theorem mem_bowtie_region_two {z : ℂ} (hz : z ∈ bowtieH) (hI : ‖z + I‖ < 1 / 10) : z ∈ bowtie.region 2 :=
  ⟨⟨subset_bowtie_dom isOpen_bowtieH subset_bowtieTiles.2.1 hz, not_mem_bowtieArcs_near_negI hI hz.2.2⟩, bowtieCol_of_mem_H hz⟩

/-- `i` is in the closure of the class `0` (the points `i − t i` of `G`), `−i` in the closure of the class `2`. -/
theorem I_mem_closure_bowtie_region : I ∈ closure (bowtie.region 0) ∧ -I ∈ closure (bowtie.region 2) := by
  constructor
  · rw [Metric.mem_closure_iff]
    intro ε hε
    set t : ℝ := min (ε / 2) (1 / 20) with ht
    have ht0 : 0 < t := lt_min (by linarith) (by norm_num)
    have ht1 : t ≤ 1 / 20 := min_le_right _ _
    have ht2 : t ≤ ε / 2 := min_le_left _ _
    have hn : ‖((1 - t : ℝ) : ℂ) * I - I‖ = t := by
      rw [show ((1 - t : ℝ) : ℂ) * I - I = ((-t : ℝ) : ℂ) * I by push_cast; ring, norm_mul, Complex.norm_I, mul_one,
        Complex.norm_real, Real.norm_eq_abs, abs_neg, abs_of_pos ht0]
    have hG : ((1 - t : ℝ) : ℂ) * I ∈ bowtieG := by
      refine ⟨by rw [hn]; linarith, ?_, ?_⟩ <;> simp <;> linarith
    refine ⟨_, mem_bowtie_region_zero hG (by rw [hn]; linarith), ?_⟩
    rw [dist_comm, dist_eq_norm, hn]; linarith
  · rw [Metric.mem_closure_iff]
    intro ε hε
    set t : ℝ := min (ε / 2) (1 / 20) with ht
    have ht0 : 0 < t := lt_min (by linarith) (by norm_num)
    have ht1 : t ≤ 1 / 20 := min_le_right _ _
    have ht2 : t ≤ ε / 2 := min_le_left _ _
    have hn : ‖((t - 1 : ℝ) : ℂ) * I + I‖ = t := by
      rw [show ((t - 1 : ℝ) : ℂ) * I + I = ((t : ℝ) : ℂ) * I by push_cast; ring, norm_mul, Complex.norm_I, mul_one,
        Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]
    have hH : ((t - 1 : ℝ) : ℂ) * I ∈ bowtieH := by
      refine ⟨by rw [hn]; linarith, ?_, ?_⟩ <;> simp <;> linarith
    refine ⟨_, mem_bowtie_region_two hH (by rw [hn]; linarith), ?_⟩
    rw [dist_comm, dist_eq_norm, sub_neg_eq_add, hn]; linarith

/-- Near `E = 0`, a point outside `ω(i)` sees a point of the class `0` at distance exactly `1`: the point of `G` toward `i`. -/
theorem mem_shadow_bowtie_region_zero {z : ℂ} (hz : ‖z‖ < 1 / 20) (h1 : 1 < ‖z - I‖) : z ∈ shadow (bowtie.region 0) := by
  set d := ‖z - I‖ with hd
  have hd0 : 0 < d := by linarith
  set y : ℂ := z + ((1 / d : ℝ) : ℂ) * (I - z) with hy
  have hf0 : 0 < 1 - 1 / d := by rw [sub_pos, div_lt_one hd0]; exact h1
  have hdz : d < 1 + 1 / 20 := by
    have := norm_sub_le z I; rw [Complex.norm_I] at this; linarith
  have hdist : dist z y = 1 := by
    rw [dist_eq_norm, hy, sub_add_cancel_left, norm_neg, norm_mul, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos (by positivity), norm_sub_rev, ← hd]
    field_simp
  have hyI : y - I = ((1 - 1 / d : ℝ) : ℂ) * (z - I) := by rw [hy]; push_cast; ring
  have hnyI : ‖y - I‖ = d - 1 := by
    rw [hyI, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hf0, ← hd]; field_simp
  have hre : |z.re| < 1 / 20 := (Complex.abs_re_le_norm z).trans_lt hz
  have him : |z.im| < 1 / 20 := (Complex.abs_im_le_norm z).trans_lt hz
  have hyre : y.re = (1 - 1 / d) * z.re := by rw [hy]; simp; ring
  have hyim : 1 - y.im = (1 - 1 / d) * (1 - z.im) := by rw [hy]; simp; ring
  have hz1 : 0 < 1 - z.im := by linarith [(abs_lt.mp him).2]
  have hcone : 12 * |y.re| < 5 * (1 - y.im) := by
    rw [hyre, hyim, abs_mul, abs_of_pos hf0]
    have : 12 * |z.re| < 5 * (1 - z.im) := by linarith [(abs_lt.mp him).2]
    nlinarith
  have hy1 : y.im < 1 := by nlinarith
  exact ⟨y, mem_bowtie_region_zero ⟨by rw [hnyI]; linarith, hy1, hcone⟩ (by rw [hnyI]; linarith), hdist⟩

/-- Near `E = 0`, a point outside `ω(−i)` sees a point of the class `2` at distance exactly `1`: the point of `H` toward `−i`. -/
theorem mem_shadow_bowtie_region_two {z : ℂ} (hz : ‖z‖ < 1 / 20) (h1 : 1 < ‖z + I‖) : z ∈ shadow (bowtie.region 2) := by
  set d := ‖z + I‖ with hd
  have hd0 : 0 < d := by linarith
  set y : ℂ := z + ((1 / d : ℝ) : ℂ) * (-I - z) with hy
  have hf0 : 0 < 1 - 1 / d := by rw [sub_pos, div_lt_one hd0]; exact h1
  have hdz : d < 1 + 1 / 20 := by
    have := norm_add_le z I; rw [Complex.norm_I] at this; linarith
  have hdist : dist z y = 1 := by
    rw [dist_eq_norm, hy, sub_add_cancel_left, norm_neg, norm_mul, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos (by positivity), show -I - z = -(z + I) by ring, norm_neg, ← hd]
    field_simp
  have hyI : y + I = ((1 - 1 / d : ℝ) : ℂ) * (z + I) := by rw [hy]; push_cast; ring
  have hnyI : ‖y + I‖ = d - 1 := by
    rw [hyI, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hf0, ← hd]; field_simp
  have hre : |z.re| < 1 / 20 := (Complex.abs_re_le_norm z).trans_lt hz
  have him : |z.im| < 1 / 20 := (Complex.abs_im_le_norm z).trans_lt hz
  have hyre : y.re = (1 - 1 / d) * z.re := by rw [hy]; simp; ring
  have hyim : 1 + y.im = (1 - 1 / d) * (1 + z.im) := by rw [hy]; simp; ring
  have hz1 : 0 < 1 + z.im := by linarith [(abs_lt.mp him).1]
  have hcone : 12 * |y.re| < 5 * (1 + y.im) := by
    rw [hyre, hyim, abs_mul, abs_of_pos hf0]
    have : 12 * |z.re| < 5 * (1 + z.im) := by linarith [(abs_lt.mp him).1]
    nlinarith
  have hy1 : -1 < y.im := by nlinarith
  exact ⟨y, mem_bowtie_region_two ⟨by rw [hnyI]; linarith, hy1, hcone⟩ (by rw [hnyI]; linarith), hdist⟩

/-- **Shadowed** by its flanks: each horn lies, near `E`, in the shadow of both flank colours. -/
theorem bowtie_doublyShadowed : bowtie.DoublyShadowed 0 0 (-1) 1 0 2 ∧ bowtie.DoublyShadowed 0 π (-1) 1 2 0 := by
  have h20 : (0 : ℝ) < 1 / 20 := by norm_num
  have hN : e (0 + π / 2) = I := by rw [zero_add, e_pi_div_two]
  refine ⟨⟨-1, 1, le_rfl, by norm_num, le_rfl, ?_⟩, ⟨-1, 1, le_rfl, by norm_num, le_rfl, ?_⟩⟩
  · filter_upwards [Ioc_mem_nhdsGT h20] with r hr
    rintro z ⟨h0, -, h3, h4⟩
    rw [tanAbove_neg_one_iff, hN, zero_sub, dist_eq_norm, sub_neg_eq_add] at h3
    rw [tanBelow_one_iff, hN, zero_add, dist_eq_norm] at h4
    rw [dist_zero_right] at h0
    exact ⟨mem_shadow_bowtie_region_zero (by linarith [hr.2]) h4, mem_shadow_bowtie_region_two (by linarith [hr.2]) h3⟩
  · filter_upwards [Ioc_mem_nhdsGT h20] with r hr
    rintro z ⟨h0, -, h3, h4⟩
    rw [tanAbove_neg_one_iff, e_pi_add_pi_div_two, zero_sub, neg_neg, dist_eq_norm] at h3
    rw [tanBelow_one_iff, e_pi_add_pi_div_two, zero_add, dist_eq_norm, sub_neg_eq_add] at h4
    rw [dist_zero_right] at h0
    exact ⟨mem_shadow_bowtie_region_two (by linarith [hr.2]) h4, mem_shadow_bowtie_region_zero (by linarith [hr.2]) h3⟩

/-- The flank sectors are **in-type** radius-1 sectors at `N` and `S`: contacts of colours `0` at `N` and `2` at `S`, in-type. -/
theorem bowtie_inType : (bowtie.IsContact 0 0 I ∧ bowtie.InType 0 0 I) ∧ (bowtie.IsContact 0 2 (-I) ∧ bowtie.InType 0 2 (-I)) := by
  have hc := bowtie_coloursAt_zero.1
  refine ⟨⟨⟨by rw [hc]; simp, by simp, I_mem_closure_bowtie_region.1⟩, ?_⟩, ⟨⟨by rw [hc]; simp, by simp, I_mem_closure_bowtie_region.2⟩, ?_⟩⟩
  · rintro T ⟨⟨x, hx, rfl⟩, hcol⟩ - z hz
    exact bowtieG_subset_ball ((bowtieCol_cases z).1 (hcol hz))
  · rintro T ⟨⟨x, hx, rfl⟩, hcol⟩ - z hz
    exact bowtieH_subset_ball ((bowtieCol_cases z).2.2.1 (hcol hz))

/-! ### The bowtie at `N = i` and `S′ = −i`: four sectors each (FS131-I4f) -/

/-- **Colours and sectors from a tile partition**: if near `v` the interior points are cut by `n` disjoint convex open sets `T i`, each
holding `v` in its closure and of one colour `c i` (`c` injective), then `P_cl(v)` is the range of `c` and each colour has one sector. -/
theorem coloursAt_hasSectors_of_tiles {k n : ℕ} {F : ArcMap k} {v : ℂ} {r₀ : ℝ} (hr₀ : 0 < r₀) {T : Fin n → Set ℂ}
    {c : Fin n → Fin k} (hU : ∀ r, 0 < r → r ≤ r₀ → F.interiorPts ∩ ball v r = ⋃ i, T i ∩ ball v r)
    (ho : ∀ i, IsOpen (T i)) (hcv : ∀ i, Convex ℝ (T i)) (hd : ∀ i j, i ≠ j → Disjoint (T i) (T j))
    (hcl : ∀ i, v ∈ closure (T i)) (hcol : ∀ i, ∀ z ∈ T i, F.col z = c i) (hc : Function.Injective c) :
    F.coloursAt v = range c ∧ ∀ i, F.HasSectors v (c i) 1 := by
  have hcl' : ∀ i, ∀ r, 0 < r → v ∈ closure (T i ∩ ball v r) := by
    intro i r hr
    rw [Metric.mem_closure_iff]
    intro ε hε
    obtain ⟨z, hz, hzd⟩ := Metric.mem_closure_iff.mp (hcl i) (min ε r) (lt_min hε hr)
    exact ⟨z, ⟨hz, by rw [mem_ball, dist_comm]; exact hzd.trans_le (min_le_right _ _)⟩, hzd.trans_le (min_le_left _ _)⟩
  have hreg : ∀ i, T i ∩ ball v r₀ ⊆ F.region (c i) := by
    intro i z hz
    have : z ∈ F.interiorPts ∩ ball v r₀ := by rw [hU r₀ hr₀ le_rfl]; exact mem_iUnion.mpr ⟨i, hz⟩
    exact ⟨this.1, hcol i z hz.1⟩
  refine ⟨?_, fun i => ?_⟩
  · ext j
    constructor
    · intro hj
      obtain ⟨z, ⟨hzI, hzc⟩, hzd⟩ := Metric.mem_closure_iff.mp hj r₀ hr₀
      have hz : z ∈ F.interiorPts ∩ ball v r₀ := ⟨hzI, by rw [mem_ball, dist_comm]; exact hzd⟩
      rw [hU r₀ hr₀ le_rfl, mem_iUnion] at hz
      obtain ⟨i, hi⟩ := hz
      exact ⟨i, (hcol i z hi.1).symm.trans hzc⟩
    · rintro ⟨i, rfl⟩
      exact closure_mono (hreg i) (hcl' i r₀ hr₀)
  · filter_upwards [Ioc_mem_nhdsGT hr₀] with r ⟨hr0, hr⟩
    have hp := hU r hr0 hr
    have ho' : ∀ j, IsOpen (T j ∩ ball v r) := fun j => (ho j).inter isOpen_ball
    have hpre : ∀ j, IsPreconnected (T j ∩ ball v r) := fun j => ((hcv j).inter (convex_ball v r)).isPreconnected
    have hd' : ∀ j l, j ≠ l → Disjoint (T j ∩ ball v r) (T l ∩ ball v r) :=
      fun j l h => (hd j l h).mono inter_subset_left inter_subset_left
    have hne : ∀ j, (T j ∩ ball v r).Nonempty := fun j => (mem_closure_iff_nhds.mp (hcl' j r hr0)) univ univ_mem |>.mono
      fun z hz => hz.2
    have hs : F.sectorsOf v r (c i) = {T i ∩ ball v r} := by
      ext S
      simp only [ArcMap.sectorsOf, mem_setOf_eq, mem_singleton_iff]
      rw [isSector_iff_of_partition hp ho' hpre hd' hne (fun j => hcl' j r hr0)]
      constructor
      · rintro ⟨⟨j, rfl⟩, hS⟩
        obtain ⟨z, hz⟩ := hne j
        have : c j = c i := (hcol j z hz.1).symm.trans (hS hz)
        rw [hc this]
      · rintro rfl
        refine ⟨⟨i, rfl⟩, fun z hz => hcol i z hz.1⟩
    rw [hs, encard_singleton]; rfl

/-- An open half-plane `a·re + b·im < c` is convex. -/
theorem convex_halfPlane (a b c : ℝ) : Convex ℝ {z : ℂ | a * z.re + b * z.im < c} := by
  refine convex_halfSpace_lt ⟨fun x y => ?_, fun s x => ?_⟩ c
  · simp only [Complex.add_re, Complex.add_im]; ring
  · simp only [Complex.smul_re, Complex.smul_im, smul_eq_mul]; ring

/-- Within `1/10` of `i`, a point of a boundary piece lies on one of the four edges through `i`. -/
theorem mem_bowtieArcs_near_I {z : ℂ} (hz : ‖z - I‖ < 1 / 10) (h : z ∈ ⋃ a ∈ bowtieArcs, a.carrier) :
    (12 * z.re + 5 * z.im = 5 ∧ 0 ≤ z.re ∧ z.im ≤ 1) ∨ (-12 * z.re + 5 * z.im = 5 ∧ z.re ≤ 0 ∧ z.im ≤ 1) ∨
      (z.im - 1 = z.re ∧ 0 ≤ z.re) ∨ (z.im - 1 = -z.re ∧ z.re ≤ 0) := by
  have hr1 : |z.re| < 1 / 10 := by
    have := Complex.abs_re_le_norm (z - I); simp only [Complex.sub_re, Complex.I_re, sub_zero] at this; linarith
  have hi1 : |z.im - 1| < 1 / 10 := by
    have := Complex.abs_im_le_norm (z - I); simp only [Complex.sub_im, Complex.I_im] at this; linarith
  have hr1' := abs_lt.mp hr1
  have hi1' := abs_lt.mp hi1
  obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
  simp only [bowtieArcs, mem_setOf_eq, List.mem_cons, List.not_mem_nil, or_false] at ha
  rcases ha with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
    rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · obtain ⟨θ, -, rfl⟩ := hza; simp at hz; norm_num at hz
  · obtain ⟨θ, -, rfl⟩ := hza
    simp only [Complex.add_im, Complex.neg_im, Complex.I_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e,
      one_mul, zero_mul, add_zero] at hi1'
    linarith [Real.sin_le_one θ]
  all_goals obtain ⟨t, ht0, ht1, hre', him'⟩ := coords_of_mem_segment hza
  all_goals simp only [pt, Complex.I_re, Complex.I_im, Complex.neg_re, Complex.neg_im] at hre' him'
  all_goals first
    | (exfalso; linarith)
    | (left; exact ⟨by linarith, by linarith, by linarith⟩)
    | (right; left; exact ⟨by linarith, by linarith, by linarith⟩)
    | (right; right; left; exact ⟨by linarith, by linarith⟩)
    | (right; right; right; exact ⟨by linarith, by linarith⟩)

/-- Within `1/10` of `−i`, a point of a boundary piece lies on one of the four edges through `−i`. -/
theorem mem_bowtieArcs_near_negI {z : ℂ} (hz : ‖z + I‖ < 1 / 10) (h : z ∈ ⋃ a ∈ bowtieArcs, a.carrier) :
    (12 * z.re - 5 * z.im = 5 ∧ 0 ≤ z.re ∧ -1 ≤ z.im) ∨ (-12 * z.re - 5 * z.im = 5 ∧ z.re ≤ 0 ∧ -1 ≤ z.im) ∨
      (-z.im - 1 = z.re ∧ 0 ≤ z.re) ∨ (-z.im - 1 = -z.re ∧ z.re ≤ 0) := by
  have hr1 : |z.re| < 1 / 10 := by
    have := Complex.abs_re_le_norm (z + I); simp only [Complex.add_re, Complex.I_re, add_zero] at this; linarith
  have hi1 : |z.im + 1| < 1 / 10 := by
    have := Complex.abs_im_le_norm (z + I); simp only [Complex.add_im, Complex.I_im] at this; linarith
  have hr1' := abs_lt.mp hr1
  have hi1' := abs_lt.mp hi1
  obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
  simp only [bowtieArcs, mem_setOf_eq, List.mem_cons, List.not_mem_nil, or_false] at ha
  rcases ha with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
    rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · obtain ⟨θ, -, rfl⟩ := hza
    simp only [Complex.add_im, Complex.I_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e,
      one_mul, zero_mul, add_zero] at hi1'
    linarith [Real.neg_one_le_sin θ]
  · obtain ⟨θ, -, rfl⟩ := hza; simp at hz; norm_num at hz
  all_goals obtain ⟨t, ht0, ht1, hre', him'⟩ := coords_of_mem_segment hza
  all_goals simp only [pt, Complex.I_re, Complex.I_im, Complex.neg_re, Complex.neg_im] at hre' him'
  all_goals first
    | (exfalso; linarith)
    | (left; exact ⟨by linarith, by linarith, by linarith⟩)
    | (right; left; exact ⟨by linarith, by linarith, by linarith⟩)
    | (right; right; left; exact ⟨by linarith, by linarith⟩)
    | (right; right; right; exact ⟨by linarith, by linarith⟩)

/-- The bowtie's colour on `CN` and `CS` is `1`. -/
theorem bowtieCol_of_mem_CN_CS {z : ℂ} (hz : z ∈ bowtieCN ∪ bowtieCS) : bowtieCol z = 1 := by
  have hG : z ∉ bowtieG := by
    intro h
    have hs := norm_sub_I_sq z
    have : ‖z - I‖ ^ 2 < 1 := by nlinarith [h.1, norm_nonneg (z - I)]
    rcases hz with hz | hz
    · linarith [h.2.1, hz.1, abs_nonneg z.re]
    · nlinarith [hz.1, abs_nonneg z.re, sq_nonneg z.re]
  unfold bowtieCol
  rw [if_neg hG, if_pos (by rcases hz with hz | hz; exacts [Or.inl (Or.inr hz), Or.inr hz])]

/-- The bowtie's colour on `X σ ∪ Y σ` is `3` for `σ = 1` and `4` for `σ = −1`. -/
theorem bowtieCol_of_mem_XY {z : ℂ} : (z ∈ bowtieX 1 ∪ bowtieY 1 → bowtieCol z = 3) ∧
    (z ∈ bowtieX (-1) ∪ bowtieY (-1) → bowtieCol z = 4) := by
  have hs := norm_sub_I_sq z
  have hs' := norm_add_I_sq z
  have ha1 := le_abs_self z.re
  have ha2 := neg_le_abs z.re
  have nG : ∀ σ : ℝ, (σ = 1 ∨ σ = -1) → z ∈ bowtieX σ ∪ bowtieY σ → z ∉ bowtieG := by
    rintro σ hσ (⟨h1, h2, h3, h4⟩ | ⟨h1, h2, h3, h4⟩) ⟨g1, g2, g3⟩ <;> rcases hσ with rfl | rfl
    all_goals first | linarith | nlinarith [g1, norm_nonneg (z - I)]
  have nC : ∀ σ : ℝ, (σ = 1 ∨ σ = -1) → z ∈ bowtieX σ ∪ bowtieY σ → z ∉ bowtieC ∪ bowtieCN ∪ bowtieCS := by
    rintro σ hσ (⟨h1, h2, h3, h4⟩ | ⟨h1, h2, h3, h4⟩) ((⟨c1, c2, c3, c4, c5⟩ | ⟨c1, c2⟩) | ⟨c1, c2⟩) <;> rcases hσ with rfl | rfl
    all_goals first | linarith [(abs_lt.mp c3).1, (abs_lt.mp c3).2] | linarith
  have nH : ∀ σ : ℝ, (σ = 1 ∨ σ = -1) → z ∈ bowtieX σ ∪ bowtieY σ → z ∉ bowtieH := by
    rintro σ hσ (⟨h1, h2, h3, h4⟩ | ⟨h1, h2, h3, h4⟩) ⟨g1, g2, g3⟩ <;> rcases hσ with rfl | rfl
    all_goals first | linarith | nlinarith [g1, norm_nonneg (z + I)]
  refine ⟨fun hz => ?_, fun hz => ?_⟩
  · unfold bowtieCol
    rw [if_neg (nG 1 (Or.inl rfl) hz), if_neg (nC 1 (Or.inl rfl) hz), if_neg (nH 1 (Or.inl rfl) hz), if_pos hz]
  · have nX : z ∉ bowtieX 1 ∪ bowtieY 1 := by
      rcases hz with ⟨h1, h2, h3, h4⟩ | ⟨h1, h2, h3, h4⟩ <;> rintro (⟨k1, k2, k3, k4⟩ | ⟨k1, k2, k3, k4⟩) <;> linarith
    unfold bowtieCol
    rw [if_neg (nG (-1) (Or.inr rfl) hz), if_neg (nC (-1) (Or.inr rfl) hz), if_neg (nH (-1) (Or.inr rfl) hz), if_neg nX,
      if_pos hz]

/-- `coloursAt_hasSectors_of_tiles` for four named tiles. -/
theorem coloursAt_hasSectors_of_four_tiles {k : ℕ} {F : ArcMap k} {v : ℂ} {r₀ : ℝ} (hr₀ : 0 < r₀) {T₀ T₁ T₂ T₃ : Set ℂ}
    {c₀ c₁ c₂ c₃ : Fin k}
    (hU : ∀ r, 0 < r → r ≤ r₀ → F.interiorPts ∩ ball v r = T₀ ∩ ball v r ∪ T₁ ∩ ball v r ∪ T₂ ∩ ball v r ∪ T₃ ∩ ball v r)
    (ho₀ : IsOpen T₀) (ho₁ : IsOpen T₁) (ho₂ : IsOpen T₂) (ho₃ : IsOpen T₃)
    (hv₀ : Convex ℝ T₀) (hv₁ : Convex ℝ T₁) (hv₂ : Convex ℝ T₂) (hv₃ : Convex ℝ T₃)
    (hd₀₁ : Disjoint T₀ T₁) (hd₀₂ : Disjoint T₀ T₂) (hd₀₃ : Disjoint T₀ T₃) (hd₁₂ : Disjoint T₁ T₂) (hd₁₃ : Disjoint T₁ T₃)
    (hd₂₃ : Disjoint T₂ T₃) (hl₀ : v ∈ closure T₀) (hl₁ : v ∈ closure T₁) (hl₂ : v ∈ closure T₂) (hl₃ : v ∈ closure T₃)
    (hc₀ : ∀ z ∈ T₀, F.col z = c₀) (hc₁ : ∀ z ∈ T₁, F.col z = c₁) (hc₂ : ∀ z ∈ T₂, F.col z = c₂) (hc₃ : ∀ z ∈ T₃, F.col z = c₃)
    (h01 : c₀ ≠ c₁) (h02 : c₀ ≠ c₂) (h03 : c₀ ≠ c₃) (h12 : c₁ ≠ c₂) (h13 : c₁ ≠ c₃) (h23 : c₂ ≠ c₃) :
    F.coloursAt v = {c₀, c₁, c₂, c₃} ∧ ∀ c ∈ F.coloursAt v, F.HasSectors v c 1 := by
  obtain ⟨h1, h2⟩ := coloursAt_hasSectors_of_tiles (F := F) (T := ![T₀, T₁, T₂, T₃]) (c := ![c₀, c₁, c₂, c₃]) hr₀
    (fun r hr0 hr => by
      rw [hU r hr0 hr]; ext z
      simp only [mem_iUnion, mem_union, Fin.exists_fin_succ, IsEmpty.exists_iff, or_false, Matrix.cons_val_zero,
        Matrix.cons_val_succ]
      tauto)
    (fun i => by fin_cases i <;> assumption) (fun i => by fin_cases i <;> assumption)
    (fun i j hij => by
      fin_cases i <;> fin_cases j <;> first | exact absurd rfl hij | assumption | exact Disjoint.symm (by assumption))
    (fun i => by fin_cases i <;> assumption) (fun i => by fin_cases i <;> assumption)
    (fun i j h => by fin_cases i <;> fin_cases j <;> simp_all [eq_comm])
  have hr : range ![c₀, c₁, c₂, c₃] = {c₀, c₁, c₂, c₃} := by
    ext j
    simp only [mem_range, Fin.exists_fin_succ, IsEmpty.exists_iff, or_false, Matrix.cons_val_zero, Matrix.cons_val_succ,
      mem_insert_iff, mem_singleton_iff]
    constructor <;> rintro (h | h | h | h) <;> subst h <;> simp
  refine ⟨h1.trans hr, ?_⟩
  rw [h1]
  rintro _ ⟨i, rfl⟩
  exact h2 i

/-- A point is in the closure of a set holding `v + t d` for all small `t > 0`. -/
theorem mem_closure_of_ray {T : Set ℂ} {v d : ℂ} {δ : ℝ} (hδ : 0 < δ) (h : ∀ t : ℝ, 0 < t → t < δ → v + t * d ∈ T) :
    v ∈ closure T := by
  rw [Metric.mem_closure_iff]
  intro ε hε
  have hd : 0 < 2 * (‖d‖ + 1) := by positivity
  set t := min (δ / 2) (ε / (2 * (‖d‖ + 1))) with ht
  have ht0 : 0 < t := lt_min (by linarith) (div_pos hε hd)
  refine ⟨v + t * d, h t ht0 (lt_of_le_of_lt (min_le_left _ _) (by linarith)), ?_⟩
  rw [dist_eq_norm, sub_add_cancel_left, norm_neg, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]
  have h1 : t ≤ ε / (2 * (‖d‖ + 1)) := min_le_right _ _
  have h2 : t * ‖d‖ ≤ ε / (2 * (‖d‖ + 1)) * ‖d‖ := mul_le_mul_of_nonneg_right h1 (norm_nonneg _)
  have h3 : ε / (2 * (‖d‖ + 1)) * ‖d‖ < ε := by
    rw [div_mul_eq_mul_div, div_lt_iff₀ hd]; nlinarith [norm_nonneg d]
  linarith

/-- The tiles at `i` and `−i` are convex: each is cut out by a disc and half-planes, or by half-planes. -/
theorem convex_bowtie_tiles : Convex ℝ bowtieG ∧ Convex ℝ bowtieH ∧ Convex ℝ bowtieCN ∧ Convex ℝ bowtieCS ∧
    ∀ σ, Convex ℝ (bowtieX σ) ∧ Convex ℝ (bowtieY σ) := by
  have ha1 : ∀ z : ℂ, z.re ≤ |z.re| := fun z => le_abs_self _
  have ha2 : ∀ z : ℂ, -z.re ≤ |z.re| := fun z => neg_le_abs _
  have hab : ∀ z : ℂ, ∀ X : ℝ, 12 * z.re < X → -12 * z.re < X → 12 * |z.re| < X := fun z X h1 h2 => by
    rcases abs_cases z.re with ⟨h, -⟩ | ⟨h, -⟩ <;> rw [h] <;> linarith
  have hab' : ∀ z : ℂ, ∀ X : ℝ, z.re < X → -z.re < X → |z.re| < X := fun z X h1 h2 => by
    rcases abs_cases z.re with ⟨h, -⟩ | ⟨h, -⟩ <;> rw [h] <;> linarith
  refine ⟨?_, ?_, ?_, ?_, fun σ => ⟨?_, ?_⟩⟩
  · have : bowtieG = ball I 1 ∩ ({z : ℂ | 0 * z.re + 1 * z.im < 1} ∩
        ({z | 12 * z.re + 5 * z.im < 5} ∩ {z | -12 * z.re + 5 * z.im < 5})) := by
      ext z
      simp only [bowtieG, mem_setOf_eq, mem_inter_iff, mem_ball, dist_eq_norm]
      constructor
      · rintro ⟨h1, h2, h3⟩; exact ⟨h1, by linarith, by linarith [ha1 z], by linarith [ha2 z]⟩
      · rintro ⟨h1, h2, h3, h4⟩; exact ⟨h1, by linarith, hab z _ (by linarith) (by linarith)⟩
    rw [this]
    exact (convex_ball _ _).inter ((convex_halfPlane _ _ _).inter ((convex_halfPlane _ _ _).inter (convex_halfPlane _ _ _)))
  · have : bowtieH = ball (-I) 1 ∩ ({z : ℂ | 0 * z.re + -1 * z.im < 1} ∩
        ({z | 12 * z.re + -5 * z.im < 5} ∩ {z | -12 * z.re + -5 * z.im < 5})) := by
      ext z
      simp only [bowtieH, mem_setOf_eq, mem_inter_iff, mem_ball, dist_eq_norm, sub_neg_eq_add]
      constructor
      · rintro ⟨h1, h2, h3⟩; exact ⟨h1, by linarith, by linarith [ha1 z], by linarith [ha2 z]⟩
      · rintro ⟨h1, h2, h3, h4⟩; exact ⟨h1, by linarith, hab z _ (by linarith) (by linarith)⟩
    rw [this]
    exact (convex_ball _ _).inter ((convex_halfPlane _ _ _).inter ((convex_halfPlane _ _ _).inter (convex_halfPlane _ _ _)))
  · have : bowtieCN = {z : ℂ | 1 * z.re + -1 * z.im < -1} ∩ ({z | -1 * z.re + -1 * z.im < -1} ∩ {z | 0 * z.re + 1 * z.im < 7 / 5}) := by
      ext z
      simp only [bowtieCN, mem_setOf_eq, mem_inter_iff]
      constructor
      · rintro ⟨h1, h2⟩; exact ⟨by linarith [ha1 z], by linarith [ha2 z], by linarith⟩
      · rintro ⟨h1, h2, h3⟩; exact ⟨hab' z _ (by linarith) (by linarith), by linarith⟩
    rw [this]
    exact (convex_halfPlane _ _ _).inter ((convex_halfPlane _ _ _).inter (convex_halfPlane _ _ _))
  · have : bowtieCS = {z : ℂ | 1 * z.re + 1 * z.im < -1} ∩ ({z | -1 * z.re + 1 * z.im < -1} ∩ {z | 0 * z.re + -1 * z.im < 7 / 5}) := by
      ext z
      simp only [bowtieCS, mem_setOf_eq, mem_inter_iff]
      constructor
      · rintro ⟨h1, h2⟩; exact ⟨by linarith [ha1 z], by linarith [ha2 z], by linarith⟩
      · rintro ⟨h1, h2, h3⟩; exact ⟨hab' z _ (by linarith) (by linarith), by linarith⟩
    rw [this]
    exact (convex_halfPlane _ _ _).inter ((convex_halfPlane _ _ _).inter (convex_halfPlane _ _ _))
  · have : bowtieX σ = {z : ℂ | (-12 * σ) * z.re + -5 * z.im < -5} ∩ ({z | -σ * z.re + 1 * z.im < 1} ∩
        ({z | σ * z.re + 0 * z.im < 2 / 5} ∩ {z | 0 * z.re + -1 * z.im < -41 / 65})) := by
      ext z
      simp only [bowtieX, mem_setOf_eq, mem_inter_iff]
      constructor
      · rintro ⟨h1, h2, h3, h4⟩; exact ⟨by linarith, by linarith, by linarith, by linarith⟩
      · rintro ⟨h1, h2, h3, h4⟩; exact ⟨by linarith, by linarith, by linarith, by linarith⟩
    rw [this]
    exact (convex_halfPlane _ _ _).inter ((convex_halfPlane _ _ _).inter ((convex_halfPlane _ _ _).inter (convex_halfPlane _ _ _)))
  · have : bowtieY σ = {z : ℂ | (-12 * σ) * z.re + 5 * z.im < -5} ∩ ({z | -σ * z.re + -1 * z.im < 1} ∩
        ({z | σ * z.re + 0 * z.im < 2 / 5} ∩ {z | 0 * z.re + 1 * z.im < -41 / 65})) := by
      ext z
      simp only [bowtieY, mem_setOf_eq, mem_inter_iff]
      constructor
      · rintro ⟨h1, h2, h3, h4⟩; exact ⟨by linarith, by linarith, by linarith, by linarith⟩
      · rintro ⟨h1, h2, h3, h4⟩; exact ⟨by linarith, by linarith, by linarith, by linarith⟩
    rw [this]
    exact (convex_halfPlane _ _ _).inter ((convex_halfPlane _ _ _).inter ((convex_halfPlane _ _ _).inter (convex_halfPlane _ _ _)))

/-- **The bowtie at `N = i`**: for `r ≤ 1/10` its interior points in `B(i, r)` are those of `G`, `CN`, `XR`, `XL`. -/
theorem bowtie_partition_I {r : ℝ} (hr : r ≤ 1 / 10) :
    bowtie.interiorPts ∩ ball I r = bowtieG ∩ ball I r ∪ bowtieCN ∩ ball I r ∪ bowtieX 1 ∩ ball I r ∪ bowtieX (-1) ∩ ball I r := by
  obtain ⟨tG, -, tCN, -, tX1, tXm, -, -⟩ := subset_bowtieTiles
  ext z
  simp only [mem_inter_iff, mem_union]
  constructor
  · rintro ⟨hzI, hzb⟩
    have hb : ‖z - I‖ < 1 / 10 := by rw [mem_ball, dist_eq_norm] at hzb; linarith
    have hi : |z.im - 1| < 1 / 10 := by
      have := Complex.abs_im_le_norm (z - I); simp only [Complex.sub_im, Complex.I_im] at this; linarith
    have hi' := abs_lt.mp hi
    rcases bowtie_interiorPts_cases hzI with h | h | h | h | h | h | h | h | h | h | h
    · exact Or.inl (Or.inl (Or.inl ⟨h, hzb⟩))
    · exfalso; linarith [(abs_lt.mp h.2.2.1).2]
    · exact Or.inl (Or.inl (Or.inr ⟨h, hzb⟩))
    · exfalso; linarith [h.1, abs_nonneg z.re]
    · exfalso
      have := Complex.abs_im_le_norm (z + I); simp only [Complex.add_im, Complex.I_im] at this
      linarith [h.1, (abs_le.mp this).2]
    · exact Or.inl (Or.inr ⟨h, hzb⟩)
    · exfalso; linarith [h.2.2.2]
    · exact Or.inr ⟨h, hzb⟩
    · exfalso; linarith [h.2.2.2]
    · exfalso; linarith [(abs_le.mp (show |z.im| ≤ 11 / 65 from (closure_bowtieZ_subset (Or.inl rfl) h).2)).2]
    · exfalso; linarith [(abs_le.mp (show |z.im| ≤ 11 / 65 from (closure_bowtieZ_subset (Or.inr rfl) h).2)).2]
  · have ha1 := le_abs_self z.re
    have ha2 := neg_le_abs z.re
    rintro (((⟨h, hzb⟩ | ⟨h, hzb⟩) | ⟨h, hzb⟩) | ⟨h, hzb⟩) <;>
      have hb : ‖z - I‖ < 1 / 10 := (by rw [mem_ball, dist_eq_norm] at hzb; linarith)
    · refine ⟨⟨subset_bowtie_dom isOpen_bowtieG tG h, fun hA => ?_⟩, hzb⟩
      obtain ⟨g1, g2, g3⟩ := h
      rcases mem_bowtieArcs_near_I hb hA with ⟨e1, e2, e3⟩ | ⟨e1, e2, e3⟩ | ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> linarith
    · refine ⟨⟨subset_bowtie_dom isOpen_bowtieCN tCN h, fun hA => ?_⟩, hzb⟩
      obtain ⟨g1, g2⟩ := h
      rcases mem_bowtieArcs_near_I hb hA with ⟨e1, e2, e3⟩ | ⟨e1, e2, e3⟩ | ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> linarith
    · refine ⟨⟨subset_bowtie_dom (isOpen_bowtieX 1) tX1 h, fun hA => ?_⟩, hzb⟩
      obtain ⟨g1, g2, g3, g4⟩ := h
      rcases mem_bowtieArcs_near_I hb hA with ⟨e1, e2, e3⟩ | ⟨e1, e2, e3⟩ | ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> linarith
    · refine ⟨⟨subset_bowtie_dom (isOpen_bowtieX (-1)) tXm h, fun hA => ?_⟩, hzb⟩
      obtain ⟨g1, g2, g3, g4⟩ := h
      rcases mem_bowtieArcs_near_I hb hA with ⟨e1, e2, e3⟩ | ⟨e1, e2, e3⟩ | ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> linarith

/-- **The bowtie at `S′ = −i`**: for `r ≤ 1/10` its interior points in `B(−i, r)` are those of `H`, `CS`, `YR`, `YL`. -/
theorem bowtie_partition_negI {r : ℝ} (hr : r ≤ 1 / 10) :
    bowtie.interiorPts ∩ ball (-I) r =
      bowtieH ∩ ball (-I) r ∪ bowtieCS ∩ ball (-I) r ∪ bowtieY 1 ∩ ball (-I) r ∪ bowtieY (-1) ∩ ball (-I) r := by
  obtain ⟨-, tH, -, tCS, -, -, tY1, tYm⟩ := subset_bowtieTiles
  ext z
  simp only [mem_inter_iff, mem_union]
  constructor
  · rintro ⟨hzI, hzb⟩
    have hb : ‖z + I‖ < 1 / 10 := by rw [mem_ball, dist_eq_norm, sub_neg_eq_add] at hzb; linarith
    have hi : |z.im + 1| < 1 / 10 := by
      have := Complex.abs_im_le_norm (z + I); simp only [Complex.add_im, Complex.I_im] at this; linarith
    have hi' := abs_lt.mp hi
    rcases bowtie_interiorPts_cases hzI with h | h | h | h | h | h | h | h | h | h | h
    · exfalso
      have := Complex.abs_im_le_norm (z - I); simp only [Complex.sub_im, Complex.I_im] at this
      linarith [h.1, (abs_le.mp this).1]
    · exfalso; linarith [(abs_lt.mp h.2.2.1).1]
    · exfalso; linarith [h.1, abs_nonneg z.re]
    · exact Or.inl (Or.inl (Or.inr ⟨h, hzb⟩))
    · exact Or.inl (Or.inl (Or.inl ⟨h, hzb⟩))
    · exfalso; linarith [h.2.2.2]
    · exact Or.inl (Or.inr ⟨h, hzb⟩)
    · exfalso; linarith [h.2.2.2]
    · exact Or.inr ⟨h, hzb⟩
    · exfalso; linarith [(abs_le.mp (show |z.im| ≤ 11 / 65 from (closure_bowtieZ_subset (Or.inl rfl) h).2)).1]
    · exfalso; linarith [(abs_le.mp (show |z.im| ≤ 11 / 65 from (closure_bowtieZ_subset (Or.inr rfl) h).2)).1]
  · have ha1 := le_abs_self z.re
    have ha2 := neg_le_abs z.re
    rintro (((⟨h, hzb⟩ | ⟨h, hzb⟩) | ⟨h, hzb⟩) | ⟨h, hzb⟩) <;>
      have hb : ‖z + I‖ < 1 / 10 := (by rw [mem_ball, dist_eq_norm, sub_neg_eq_add] at hzb; linarith)
    · refine ⟨⟨subset_bowtie_dom isOpen_bowtieH tH h, fun hA => ?_⟩, hzb⟩
      obtain ⟨g1, g2, g3⟩ := h
      rcases mem_bowtieArcs_near_negI hb hA with ⟨e1, e2, e3⟩ | ⟨e1, e2, e3⟩ | ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> linarith
    · refine ⟨⟨subset_bowtie_dom isOpen_bowtieCS tCS h, fun hA => ?_⟩, hzb⟩
      obtain ⟨g1, g2⟩ := h
      rcases mem_bowtieArcs_near_negI hb hA with ⟨e1, e2, e3⟩ | ⟨e1, e2, e3⟩ | ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> linarith
    · refine ⟨⟨subset_bowtie_dom (isOpen_bowtieY 1) tY1 h, fun hA => ?_⟩, hzb⟩
      obtain ⟨g1, g2, g3, g4⟩ := h
      rcases mem_bowtieArcs_near_negI hb hA with ⟨e1, e2, e3⟩ | ⟨e1, e2, e3⟩ | ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> linarith
    · refine ⟨⟨subset_bowtie_dom (isOpen_bowtieY (-1)) tYm h, fun hA => ?_⟩, hzb⟩
      obtain ⟨g1, g2, g3, g4⟩ := h
      rcases mem_bowtieArcs_near_negI hb hA with ⟨e1, e2, e3⟩ | ⟨e1, e2, e3⟩ | ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> linarith

/-- **Both neighbours four-coloured, one sector per colour**: `P_cl(N) = {0, 1, 3, 4}`, `P_cl(S) = {2, 1, 3, 4}`. -/
theorem bowtie_neighbours : bowtie.coloursAt I = {0, 1, 3, 4} ∧ bowtie.coloursAt (-I) = {2, 1, 3, 4} ∧
    (∀ c ∈ bowtie.coloursAt I, bowtie.HasSectors I c 1) ∧ ∀ c ∈ bowtie.coloursAt (-I), bowtie.HasSectors (-I) c 1 := by
  obtain ⟨cG, cH, cCN, cCS, cXY⟩ := convex_bowtie_tiles
  have dj : ∀ {A B : Set ℂ}, (∀ z, z ∈ A → z ∈ B → False) → Disjoint A B := fun h => Set.disjoint_left.mpr fun z ha hb => h z ha hb
  have hn : ∀ t : ℝ, ‖(t : ℂ) * I‖ = |t| := fun t => by rw [norm_mul, Complex.norm_I, mul_one, Complex.norm_real, Real.norm_eq_abs]
  obtain ⟨h1, h2⟩ := coloursAt_hasSectors_of_four_tiles (F := bowtie) (v := I) (r₀ := 1 / 10) (by norm_num)
    (c₀ := 0) (c₁ := 1) (c₂ := 3) (c₃ := 4) (fun r _ hr => bowtie_partition_I hr)
    isOpen_bowtieG isOpen_bowtieCN (isOpen_bowtieX 1) (isOpen_bowtieX (-1)) cG cCN (cXY 1).1 (cXY (-1)).1
    (dj fun z ⟨_, g2, _⟩ ⟨c1, _⟩ => by linarith [abs_nonneg z.re])
    (dj fun z ⟨_, _, g3⟩ ⟨x1, _, _, _⟩ => by linarith [le_abs_self z.re])
    (dj fun z ⟨_, _, g3⟩ ⟨x1, _, _, _⟩ => by linarith [neg_le_abs z.re])
    (dj fun z ⟨c1, _⟩ ⟨_, x2, _, _⟩ => by linarith [le_abs_self z.re])
    (dj fun z ⟨c1, _⟩ ⟨_, x2, _, _⟩ => by linarith [neg_le_abs z.re])
    (dj fun z ⟨x1, x2, _, _⟩ ⟨y1, y2, _, _⟩ => by linarith)
    (mem_closure_of_ray (d := -I) (δ := 1 / 20) (by norm_num) fun t ht0 ht1 => ⟨by
        rw [show I + (t : ℂ) * -I - I = ((-t : ℝ) : ℂ) * I by push_cast; ring, hn, abs_neg, abs_of_pos ht0]; linarith,
      by simp; linarith, by simp; linarith⟩)
    (mem_closure_of_ray (d := I) (δ := 1 / 20) (by norm_num) fun t ht0 ht1 => ⟨by simp; linarith, by simp; linarith⟩)
    (mem_closure_of_ray (d := 1) (δ := 1 / 20) (by norm_num) fun t ht0 ht1 =>
      ⟨by simp; linarith, by simp; linarith, by simp; linarith, by simp; norm_num⟩)
    (mem_closure_of_ray (d := -1) (δ := 1 / 20) (by norm_num) fun t ht0 ht1 =>
      ⟨by simp; linarith, by simp; linarith, by simp; linarith, by simp; norm_num⟩)
    (fun z hz => bowtieCol_of_mem_G hz) (fun z hz => bowtieCol_of_mem_CN_CS (Or.inl hz))
    (fun z hz => bowtieCol_of_mem_XY.1 (Or.inl hz)) (fun z hz => bowtieCol_of_mem_XY.2 (Or.inl hz))
    (by decide) (by decide) (by decide) (by decide) (by decide) (by decide)
  obtain ⟨h3, h4⟩ := coloursAt_hasSectors_of_four_tiles (F := bowtie) (v := -I) (r₀ := 1 / 10) (by norm_num)
    (c₀ := 2) (c₁ := 1) (c₂ := 3) (c₃ := 4) (fun r _ hr => bowtie_partition_negI hr)
    isOpen_bowtieH isOpen_bowtieCS (isOpen_bowtieY 1) (isOpen_bowtieY (-1)) cH cCS (cXY 1).2 (cXY (-1)).2
    (dj fun z ⟨_, g2, _⟩ ⟨c1, _⟩ => by linarith [abs_nonneg z.re])
    (dj fun z ⟨_, _, g3⟩ ⟨x1, _, _, _⟩ => by linarith [le_abs_self z.re])
    (dj fun z ⟨_, _, g3⟩ ⟨x1, _, _, _⟩ => by linarith [neg_le_abs z.re])
    (dj fun z ⟨c1, _⟩ ⟨_, x2, _, _⟩ => by linarith [le_abs_self z.re])
    (dj fun z ⟨c1, _⟩ ⟨_, x2, _, _⟩ => by linarith [neg_le_abs z.re])
    (dj fun z ⟨x1, x2, _, _⟩ ⟨y1, y2, _, _⟩ => by linarith)
    (mem_closure_of_ray (d := I) (δ := 1 / 20) (by norm_num) fun t ht0 ht1 => ⟨by
        rw [show -I + (t : ℂ) * I + I = ((t : ℝ) : ℂ) * I by ring, hn, abs_of_pos ht0]; linarith,
      by simp; linarith, by simp; linarith⟩)
    (mem_closure_of_ray (d := -I) (δ := 1 / 20) (by norm_num) fun t ht0 ht1 => ⟨by simp; linarith, by simp; linarith⟩)
    (mem_closure_of_ray (d := 1) (δ := 1 / 20) (by norm_num) fun t ht0 ht1 =>
      ⟨by simp; linarith, by simp; linarith, by simp; linarith, by simp; norm_num⟩)
    (mem_closure_of_ray (d := -1) (δ := 1 / 20) (by norm_num) fun t ht0 ht1 =>
      ⟨by simp; linarith, by simp; linarith, by simp; linarith, by simp; norm_num⟩)
    (fun z hz => bowtieCol_of_mem_H hz) (fun z hz => bowtieCol_of_mem_CN_CS (Or.inr hz))
    (fun z hz => bowtieCol_of_mem_XY.1 (Or.inr hz)) (fun z hz => bowtieCol_of_mem_XY.2 (Or.inr hz))
    (by decide) (by decide) (by decide) (by decide) (by decide) (by decide)
  exact ⟨h1, h3, h2, h4⟩

/-- Below an arc of curvature `κ` and above one of curvature `κ' ≥ κ`, through the same point with the same tangent: impossible. -/
theorem tanBelow_tanAbove_false {v : ℂ} {α κ κ' : ℝ} (hκ : κ ≤ κ') {z : ℂ} (h1 : TanBelow v α κ z) (h2 : TanAbove v α κ' z) :
    False := by
  unfold TanBelow TanAbove tanHeight at *
  nlinarith [sq_nonneg (frameX v α z), sq_nonneg (frameY v α z)]

/-- The frame coordinates of a point of the ray from `v` along `d`. -/
theorem frame_ray (v : ℂ) (α t : ℝ) (d : ℂ) :
    frameX v α (v + t * d) = t * (d * starRingEnd ℂ (e α)).re ∧ frameY v α (v + t * d) = t * (d * starRingEnd ℂ (e α)).im := by
  have : (v + (t : ℂ) * d - v) * starRingEnd ℂ (e α) = (t : ℂ) * (d * starRingEnd ℂ (e α)) := by ring
  unfold frameX frameY
  rw [this, Complex.re_ofReal_mul, Complex.im_ofReal_mul]
  exact ⟨rfl, rfl⟩

/-- **A ray off a horn's axis leaves every horn set near the vertex**: if `d` is not along `±e α`, the points `v + t d` lie in no
horn set at `v` along `e α`, for every small `t > 0` (a horn is tangent to its axis). -/
theorem eventually_ray_not_mem_hornSet (v : ℂ) (α κ₁ κ₂ : ℝ) {d : ℂ} (hd : (d * starRingEnd ℂ (e α)).im ≠ 0) :
    ∀ᶠ t : ℝ in 𝓝[>] (0 : ℝ), ∀ r, v + (t : ℂ) * d ∉ hornSet v α κ₁ κ₂ r := by
  set u := d * starRingEnd ℂ (e α) with hu
  set a := u.im
  set N := u.re ^ 2 + u.im ^ 2
  have hN : 0 ≤ N := by positivity
  set M := (|κ₁| + |κ₂|) * N + 1
  have hM : 0 < M := by positivity
  have ha : 0 < |a| := abs_pos.mpr hd
  filter_upwards [Ioo_mem_nhdsGT (show 0 < |a| / M by positivity)] with t ⟨ht0, ht1⟩ r hmem
  obtain ⟨-, -, hA, hB⟩ := hmem
  obtain ⟨hx, hy⟩ := frame_ray v α t d
  unfold TanAbove tanHeight at hA
  unfold TanBelow tanHeight at hB
  rw [hx, hy] at hA hB
  have hsq : (t * u.re) ^ 2 + (t * u.im) ^ 2 = t ^ 2 * N := by ring
  rw [hsq] at hA hB
  have htM : t * M < |a| := by rwa [lt_div_iff₀ hM] at ht1
  have hk1 : |κ₁| * (t * N) ≤ t * M := by
    have : |κ₁| * N ≤ M := by nlinarith [abs_nonneg κ₂, abs_nonneg κ₁]
    nlinarith
  have hk2 : |κ₂| * (t * N) ≤ t * M := by
    have : |κ₂| * N ≤ M := by nlinarith [abs_nonneg κ₂, abs_nonneg κ₁]
    nlinarith
  -- from `hA`, `hB` divided by `t > 0`: `κ₁ t N / 2 < a < κ₂ t N / 2`
  have hA' : κ₁ * (t * N) / 2 < a := by nlinarith
  have hB' : a < κ₂ * (t * N) / 2 := by nlinarith
  have h1 := neg_abs_le κ₁
  have h2 := le_abs_self κ₂
  have htN : 0 ≤ t * N := by positivity
  rcases lt_or_gt_of_ne hd with hneg | hpos
  · rw [abs_of_neg hneg] at htM
    nlinarith
  · rw [abs_of_pos hpos] at htM
    nlinarith

/-- **Two rays from `v` that are not parallel are never both in a horn set at `v`**, near `v`. -/
theorem eventually_not_two_rays_hornSet (v : ℂ) (α κ₁ κ₂ : ℝ) {d₁ d₂ : ℂ} (h : (d₁ * starRingEnd ℂ d₂).im ≠ 0) :
    ∀ᶠ t : ℝ in 𝓝[>] (0 : ℝ), ∀ r, ¬ (v + (t : ℂ) * d₁ ∈ hornSet v α κ₁ κ₂ r ∧ v + (t : ℂ) * d₂ ∈ hornSet v α κ₁ κ₂ r) := by
  by_cases h1 : (d₁ * starRingEnd ℂ (e α)).im = 0
  · by_cases h2 : (d₂ * starRingEnd ℂ (e α)).im = 0
    · exfalso
      apply h
      have hd : d₁ * starRingEnd ℂ d₂ = (d₁ * starRingEnd ℂ (e α)) * starRingEnd ℂ (d₂ * starRingEnd ℂ (e α)) := by
        rw [map_mul, Complex.conj_conj]
        calc d₁ * starRingEnd ℂ d₂ = d₁ * starRingEnd ℂ d₂ * (e α * starRingEnd ℂ (e α)) := by rw [conj_e_mul_e, mul_one]
          _ = _ := by ring
      rw [hd, Complex.mul_im, Complex.conj_re, Complex.conj_im, h1, h2]; ring
    · filter_upwards [eventually_ray_not_mem_hornSet v α κ₁ κ₂ h2] with t ht r hr
      exact ht r hr.2
  · filter_upwards [eventually_ray_not_mem_hornSet v α κ₁ κ₂ h1] with t ht r hr
    exact ht r hr.1

/-- **A horn set holding a whole unit ray from `v` points along it**: `e α = d`. -/
theorem eq_e_of_ray_subset_hornSet {v d : ℂ} (hd : ‖d‖ = 1) {α κ₁ κ₂ δ r : ℝ} (hδ : 0 < δ)
    (h : ∀ t : ℝ, 0 < t → t < δ → v + (t : ℂ) * d ∈ hornSet v α κ₁ κ₂ r) : e α = d := by
  set u := d * starRingEnd ℂ (e α) with hu
  have him : u.im = 0 := by
    by_contra hne
    obtain ⟨t, ht, ht0⟩ := ((eventually_ray_not_mem_hornSet v α κ₁ κ₂ hne).and (Ioo_mem_nhdsGT hδ)).exists
    exact ht r (h t ht0.1 ht0.2)
  have hre : 0 < u.re := by
    have hm := (h (δ / 2) (by linarith) (by linarith)).2.1
    rw [(frame_ray v α (δ / 2) d).1] at hm
    exact pos_of_mul_pos_right hm (by linarith)
  have hnorm : ‖u‖ = 1 := by rw [hu, norm_mul, Complex.norm_conj, norm_e, hd, mul_one]
  have hsq : u.re ^ 2 + u.im ^ 2 = 1 := by
    have := Complex.sq_norm u
    rw [hnorm, Complex.normSq_apply] at this
    nlinarith
  rw [him] at hsq
  have hre1 : u.re = 1 := by nlinarith
  have hu1 : u = 1 := Complex.ext (by simp [hre1]) (by simp [him])
  calc e α = u * e α := by rw [hu1, one_mul]
    _ = d * (e α * starRingEnd ℂ (e α)) := by rw [hu]; ring
    _ = d := by rw [conj_e_mul_e, mul_one]

section Sectors

variable {k : ℕ} {F : ArcMap k}

/-- A sector lies among the interior points of its ball. -/
theorem IsSector.subset {v : ℂ} {r : ℝ} {S : Set ℂ} (hS : F.IsSector v r S) : S ⊆ F.interiorPts ∩ ball v r := by
  obtain ⟨x, -, rfl, -⟩ := hS
  exact connectedComponentIn_subset _ _

/-- A sector is non-empty. -/
theorem IsSector.nonempty {v : ℂ} {r : ℝ} {S : Set ℂ} (hS : F.IsSector v r S) : S.Nonempty := by
  obtain ⟨x, hx, rfl, -⟩ := hS
  exact ⟨x, mem_connectedComponentIn hx⟩

/-- A preconnected set of interior points of the ball meeting a sector lies in it. -/
theorem IsSector.subset_of_isPreconnected {v : ℂ} {r : ℝ} {S A : Set ℂ} (hS : F.IsSector v r S) (hA : IsPreconnected A)
    (hAU : A ⊆ F.interiorPts ∩ ball v r) {a : ℂ} (haA : a ∈ A) (haS : a ∈ S) : A ⊆ S := by
  obtain ⟨x, -, rfl, -⟩ := hS
  rw [connectedComponentIn_eq haS]
  exact hA.subset_connectedComponentIn haA hAU

/-- A point of a ray from `v` within `r` of `v`. -/
theorem ray_mem_ball {v d : ℂ} {t r : ℝ} (ht : 0 < t) (h : t * (|d.re| + |d.im|) < r) : v + (t : ℂ) * d ∈ ball v r := by
  rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht]
  calc t * ‖d‖ ≤ t * (|d.re| + |d.im|) := mul_le_mul_of_nonneg_left (Complex.norm_le_abs_re_add_abs_im d) ht.le
    _ < r := h

/-- **A convex set holding two non-parallel rays from `v` misses every horn set that is a sector at `v`** (its part near `v`
would lie in the sector, a horn being tangent to its axis). -/
theorem IsSector.disjoint_of_rays {v : ℂ} {r α κ₁ κ₂ : ℝ} (hS : F.IsSector v r (hornSet v α κ₁ κ₂ r)) {T : Set ℂ}
    (hT : Convex ℝ T) (hTU : T ∩ ball v r ⊆ F.interiorPts) {d₁ d₂ : ℂ} (hd : (d₁ * starRingEnd ℂ d₂).im ≠ 0) {δ : ℝ}
    (hδ : 0 < δ) (hray : ∀ t : ℝ, 0 < t → t < δ → v + (t : ℂ) * d₁ ∈ T ∧ v + (t : ℂ) * d₂ ∈ T) :
    Disjoint (T ∩ ball v r) (hornSet v α κ₁ κ₂ r) := by
  obtain ⟨x, hx⟩ := hS.nonempty
  have hr : 0 < r := lt_of_le_of_lt dist_nonneg (mem_ball.mp (hS.subset hx).2)
  rw [Set.disjoint_left]
  intro a haA haS
  have hsub := hS.subset_of_isPreconnected (hT.inter (convex_ball v r)).isPreconnected
    (fun z hz => ⟨hTU hz, hz.2⟩) haA haS
  set M := |d₁.re| + |d₁.im| + |d₂.re| + |d₂.im| + 1
  have hM : 0 < M := by positivity
  obtain ⟨t, ht, ht0⟩ := ((eventually_not_two_rays_hornSet v α κ₁ κ₂ hd).and
    (Ioo_mem_nhdsGT (lt_min hδ (div_pos hr hM)))).exists
  have htδ : t < δ := ht0.2.trans_le (min_le_left _ _)
  have htM : t * M < r := by
    have := ht0.2.trans_le (min_le_right _ _); rwa [lt_div_iff₀ hM] at this
  obtain ⟨h1, h2⟩ := hray t ht0.1 htδ
  have hb1 : v + (t : ℂ) * d₁ ∈ ball v r := ray_mem_ball ht0.1 (by
    nlinarith [abs_nonneg d₂.re, abs_nonneg d₂.im, ht0.1])
  have hb2 : v + (t : ℂ) * d₂ ∈ ball v r := ray_mem_ball ht0.1 (by
    nlinarith [abs_nonneg d₁.re, abs_nonneg d₁.im, ht0.1])
  exact ht r ⟨hsub ⟨h1, hb1⟩, hsub ⟨h2, hb2⟩⟩

/-- Two counts of one colour's sectors agree. -/
theorem HasSectors.eq {v : ℂ} {c : Fin k} {n m : ℕ} (hn : F.HasSectors v c n) (hm : F.HasSectors v c m) : n = m := by
  obtain ⟨r, hr⟩ := (hn.and hm).exists
  exact_mod_cast hr.1.symm.trans hr.2

/-- A colour not carried at `v` has no sector there. -/
theorem HasSectors.eq_zero_of_not_mem {v : ℂ} {c : Fin k} {n : ℕ} (hn : F.HasSectors v c n) (hc : c ∉ F.coloursAt v) :
    n = 0 := by
  obtain ⟨r, hr⟩ := hn.exists
  have : F.sectorsOf v r c = ∅ := by
    ext S
    simp only [sectorsOf, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
    intro hS hSc
    apply hc
    obtain ⟨x, hx, hSeq, hvS⟩ := id hS
    exact closure_mono (show S ⊆ F.region c from fun z hz => ⟨(hS.subset hz).1, hSc hz⟩) hvS
  rw [this, encard_empty] at hr
  exact_mod_cast hr.symm

end Sectors

/-! ### The bowtie's moves (FS131-I4g) -/

/-- The coordinates of a point of the ray from `v` along `pt a b`. -/
theorem ray_coords (v : ℂ) (t a b : ℝ) :
    (v + (t : ℂ) * pt a b).re = v.re + t * a ∧ (v + (t : ℂ) * pt a b).im = v.im + t * b := by
  simp [pt]

/-- `Im (pt a b · conj (pt c d)) = b c − a d`. -/
theorem im_pt_mul_conj_pt (a b c d : ℝ) : (pt a b * starRingEnd ℂ (pt c d)).im = b * c - a * d := by
  simp [pt]; ring

/-- A point of the ray from `v` along `pt a b`, for `t (|a| + |b|) < 1`, lies in `B(v, 1)`. -/
theorem norm_ray_sub_lt_one {v : ℂ} {t a b : ℝ} (ht : 0 < t) (h : t * (|a| + |b|) < 1) : ‖v + (t : ℂ) * pt a b - v‖ < 1 := by
  have := ray_mem_ball (v := v) (d := pt a b) (r := 1) ht (by simpa [pt] using h)
  rwa [mem_ball, dist_eq_norm] at this

/-- **No horn at `N = i`**: near `i` the bowtie's sectors are its four angular tiles, each holding two non-parallel rays. -/
theorem bowtie_not_isHorn_I (α κ₁ κ₂ : ℝ) (c : Fin 6) : ¬ bowtie.IsHorn I α κ₁ κ₂ c := by
  rintro ⟨-, hH⟩
  obtain ⟨r, ⟨hsec, -⟩, hr⟩ := (hH.and (Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num))).exists
  obtain ⟨x, hx⟩ := hsec.nonempty
  have hxU := hsec.subset hx
  have hpart := bowtie_partition_I hr.2
  obtain ⟨cG, -, cCN, -, cXY⟩ := convex_bowtie_tiles
  rw [hpart] at hxU
  have hU : ∀ T : Set ℂ, T ∩ ball I r ⊆ bowtie.interiorPts ∩ ball I r → T ∩ ball I r ⊆ bowtie.interiorPts :=
    fun T h z hz => (h hz).1
  rcases hxU with ((hxT | hxT) | hxT) | hxT
  · refine disjoint_left.mp (hsec.disjoint_of_rays cG (hU _ (by rw [hpart]; intro z hz; simp [hz]))
      (d₁ := pt 0 (-1)) (d₂ := pt (1 / 5) (-1)) (by rw [im_pt_mul_conj_pt]; norm_num) (δ := 1 / 2) (by norm_num) ?_) hxT hx
    intro t ht0 ht1
    have hm : ∀ a b : ℝ, |a| + |b| ≤ 2 → b = -1 → 12 * |a| < 5 → I + (t : ℂ) * pt a b ∈ bowtieG := by
      intro a b hab hb ha
      obtain ⟨hre, him⟩ := ray_coords I t a b
      refine ⟨norm_ray_sub_lt_one ht0 (by nlinarith), ?_, ?_⟩
      · rw [him, hb]; simp; linarith
      · rw [hre, him, hb]; simp only [Complex.I_re, Complex.I_im, zero_add, abs_mul, abs_of_pos ht0]; nlinarith
    exact ⟨hm 0 (-1) (by norm_num) rfl (by norm_num), hm (1 / 5) (-1) (by norm_num [abs_of_pos]) rfl (by norm_num [abs_of_pos])⟩
  · refine disjoint_left.mp (hsec.disjoint_of_rays cCN (hU _ (by rw [hpart]; intro z hz; simp [hz]))
      (d₁ := pt 0 1) (d₂ := pt 1 2) (by rw [im_pt_mul_conj_pt]; norm_num) (δ := 1 / 5) (by norm_num) ?_) hxT hx
    intro t ht0 ht1
    have hm : ∀ a b : ℝ, |a| < b → b ≤ 2 → I + (t : ℂ) * pt a b ∈ bowtieCN := by
      intro a b hab hb
      obtain ⟨hre, him⟩ := ray_coords I t a b
      refine ⟨?_, ?_⟩
      · rw [hre, him]; simp only [Complex.I_re, Complex.I_im, zero_add, abs_mul, abs_of_pos ht0]; nlinarith
      · rw [him]; simp; nlinarith
    exact ⟨hm 0 1 (by norm_num) (by norm_num), hm 1 2 (by norm_num) le_rfl⟩
  · refine disjoint_left.mp (hsec.disjoint_of_rays (cXY 1).1 (hU _ (by rw [hpart]; intro z hz; simp [hz]))
      (d₁ := pt 1 0) (d₂ := pt 2 1) (by rw [im_pt_mul_conj_pt]; norm_num) (δ := 1 / 5) (by norm_num) ?_) hxT hx
    intro t ht0 ht1
    have hm : ∀ a b : ℝ, 0 ≤ b → b < a → a ≤ 2 → I + (t : ℂ) * pt a b ∈ bowtieX 1 := by
      intro a b hb hab ha
      obtain ⟨hre, him⟩ := ray_coords I t a b
      refine ⟨?_, ?_, ?_, ?_⟩ <;> simp only [hre, him, Complex.I_re, Complex.I_im] <;> nlinarith
    exact ⟨hm 1 0 le_rfl (by norm_num) (by norm_num), hm 2 1 (by norm_num) (by norm_num) le_rfl⟩
  · refine disjoint_left.mp (hsec.disjoint_of_rays (cXY (-1)).1 (hU _ (by rw [hpart]; intro z hz; simp [hz]))
      (d₁ := pt (-1) 0) (d₂ := pt (-2) 1) (by rw [im_pt_mul_conj_pt]; norm_num) (δ := 1 / 5) (by norm_num) ?_) hxT hx
    intro t ht0 ht1
    have hm : ∀ a b : ℝ, 0 ≤ b → b < -a → -a ≤ 2 → I + (t : ℂ) * pt a b ∈ bowtieX (-1) := by
      intro a b hb hab ha
      obtain ⟨hre, him⟩ := ray_coords I t a b
      refine ⟨?_, ?_, ?_, ?_⟩ <;> simp only [hre, him, Complex.I_re, Complex.I_im] <;> nlinarith
    exact ⟨hm (-1) 0 le_rfl (by norm_num) (by norm_num), hm (-2) 1 (by norm_num) (by norm_num) (by norm_num)⟩

/-- **No horn at `S′ = −i`**, the mirror. -/
theorem bowtie_not_isHorn_negI (α κ₁ κ₂ : ℝ) (c : Fin 6) : ¬ bowtie.IsHorn (-I) α κ₁ κ₂ c := by
  rintro ⟨-, hH⟩
  obtain ⟨r, ⟨hsec, -⟩, hr⟩ := (hH.and (Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num))).exists
  obtain ⟨x, hx⟩ := hsec.nonempty
  have hxU := hsec.subset hx
  have hpart := bowtie_partition_negI hr.2
  obtain ⟨-, cH, -, cCS, cXY⟩ := convex_bowtie_tiles
  rw [hpart] at hxU
  have hU : ∀ T : Set ℂ, T ∩ ball (-I) r ⊆ bowtie.interiorPts ∩ ball (-I) r → T ∩ ball (-I) r ⊆ bowtie.interiorPts :=
    fun T h z hz => (h hz).1
  rcases hxU with ((hxT | hxT) | hxT) | hxT
  · refine disjoint_left.mp (hsec.disjoint_of_rays cH (hU _ (by rw [hpart]; intro z hz; simp [hz]))
      (d₁ := pt 0 1) (d₂ := pt (1 / 5) 1) (by rw [im_pt_mul_conj_pt]; norm_num) (δ := 1 / 2) (by norm_num) ?_) hxT hx
    intro t ht0 ht1
    have hm : ∀ a b : ℝ, |a| + |b| ≤ 2 → b = 1 → 12 * |a| < 5 → -I + (t : ℂ) * pt a b ∈ bowtieH := by
      intro a b hab hb ha
      obtain ⟨hre, him⟩ := ray_coords (-I) t a b
      refine ⟨?_, ?_, ?_⟩
      · have := norm_ray_sub_lt_one (v := -I) ht0 (show t * (|a| + |b|) < 1 by nlinarith)
        rwa [sub_neg_eq_add] at this
      · rw [him, hb]; simp; linarith
      · rw [hre, him, hb]; simp only [Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im, neg_zero, zero_add,
          abs_mul, abs_of_pos ht0]; nlinarith
    exact ⟨hm 0 1 (by norm_num) rfl (by norm_num), hm (1 / 5) 1 (by norm_num [abs_of_pos]) rfl (by norm_num [abs_of_pos])⟩
  · refine disjoint_left.mp (hsec.disjoint_of_rays cCS (hU _ (by rw [hpart]; intro z hz; simp [hz]))
      (d₁ := pt 0 (-1)) (d₂ := pt 1 (-2)) (by rw [im_pt_mul_conj_pt]; norm_num) (δ := 1 / 5) (by norm_num) ?_) hxT hx
    intro t ht0 ht1
    have hm : ∀ a b : ℝ, |a| < -b → -b ≤ 2 → -I + (t : ℂ) * pt a b ∈ bowtieCS := by
      intro a b hab hb
      obtain ⟨hre, him⟩ := ray_coords (-I) t a b
      refine ⟨?_, ?_⟩
      · rw [hre, him]; simp only [Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im, neg_zero, zero_add, abs_mul,
          abs_of_pos ht0]; nlinarith
      · rw [him]; simp; nlinarith
    exact ⟨hm 0 (-1) (by norm_num) (by norm_num), hm 1 (-2) (by norm_num) (by norm_num)⟩
  · refine disjoint_left.mp (hsec.disjoint_of_rays (cXY 1).2 (hU _ (by rw [hpart]; intro z hz; simp [hz]))
      (d₁ := pt 1 0) (d₂ := pt 2 (-1)) (by rw [im_pt_mul_conj_pt]; norm_num) (δ := 1 / 5) (by norm_num) ?_) hxT hx
    intro t ht0 ht1
    have hm : ∀ a b : ℝ, 0 ≤ -b → -b < a → a ≤ 2 → -I + (t : ℂ) * pt a b ∈ bowtieY 1 := by
      intro a b hb hab ha
      obtain ⟨hre, him⟩ := ray_coords (-I) t a b
      refine ⟨?_, ?_, ?_, ?_⟩ <;> simp only [hre, him, Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im] <;>
        nlinarith
    exact ⟨hm 1 0 (by norm_num) (by norm_num) (by norm_num), hm 2 (-1) (by norm_num) (by norm_num) le_rfl⟩
  · refine disjoint_left.mp (hsec.disjoint_of_rays (cXY (-1)).2 (hU _ (by rw [hpart]; intro z hz; simp [hz]))
      (d₁ := pt (-1) 0) (d₂ := pt (-2) (-1)) (by rw [im_pt_mul_conj_pt]; norm_num) (δ := 1 / 5) (by norm_num) ?_) hxT hx
    intro t ht0 ht1
    have hm : ∀ a b : ℝ, 0 ≤ -b → -b < -a → -a ≤ 2 → -I + (t : ℂ) * pt a b ∈ bowtieY (-1) := by
      intro a b hb hab ha
      obtain ⟨hre, him⟩ := ray_coords (-I) t a b
      refine ⟨?_, ?_, ?_, ?_⟩ <;> simp only [hre, him, Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im] <;>
        nlinarith
    exact ⟨hm (-1) 0 (by norm_num) (by norm_num) (by norm_num), hm (-2) (-1) (by norm_num) (by norm_num) (by norm_num)⟩

/-- **A horn of the bowtie at `E = 0`** is one of the two cusp horns: its set holds the cusp's right horn and its axis is `e α = 1`,
or the left horn and `e α = −1`; and every point of it lies outside both `ω(i)` and `ω(−i)` (the disc parts hold two
non-parallel rays each, so no horn set meets them). -/
theorem bowtie_hornSet_zero {α κ₁ κ₂ r : ℝ} (hr : r ≤ 1 / 13) (hS : bowtie.IsSector 0 r (hornSet 0 α κ₁ κ₂ r)) :
    ((e α = 1 ∧ cuspPiece r 0 ⊆ hornSet 0 α κ₁ κ₂ r) ∨ (e α = -1 ∧ cuspPiece r 1 ⊆ hornSet 0 α κ₁ κ₂ r)) ∧
      ∀ z ∈ hornSet 0 α κ₁ κ₂ r, 1 < ‖z - I‖ ∧ 1 < ‖z + I‖ := by
  obtain ⟨x, hx⟩ := hS.nonempty
  have hr0 : 0 < r := lt_of_le_of_lt dist_nonneg (mem_ball.mp (hS.subset hx).2)
  have hpart := bowtie_partition hr
  obtain ⟨-, hpre, -, -, -⟩ := cuspPiece_data hr0 (by linarith)
  have hpU : ∀ i, cuspPiece r i ⊆ bowtie.interiorPts ∩ ball 0 r := fun i => by
    rw [hpart]; exact subset_iUnion (fun i => cuspPiece r i) i
  -- the disc parts miss the horn set
  have hsq : ∀ w : ℂ, ‖w‖ ^ 2 < 1 → ‖w‖ < 1 := fun w h => (sq_lt_one_iff₀ (norm_nonneg w)).mp h
  have hd2 : Disjoint (cuspPiece r 2) (hornSet 0 α κ₁ κ₂ r) := by
    have h := hS.disjoint_of_rays (convex_ball I 1) (T := ball I 1) (d₁ := pt 0 1) (d₂ := pt 1 2)
      (fun z hz => (hpU 2 (show z ∈ ball 0 r ∩ ball I 1 from ⟨hz.2, hz.1⟩)).1) (by rw [im_pt_mul_conj_pt]; norm_num)
      (δ := 1 / 2) (by norm_num) (fun t ht0 ht1 => by
        obtain ⟨a1, b1⟩ := ray_coords 0 t 0 1
        obtain ⟨a2, b2⟩ := ray_coords 0 t 1 2
        refine ⟨?_, ?_⟩ <;> rw [mem_ball, dist_eq_norm] <;> refine hsq _ ?_ <;> rw [norm_sub_I_sq]
        · rw [a1, b1]; simp only [Complex.zero_re, Complex.zero_im, zero_add, mul_zero]; nlinarith
        · rw [a2, b2]; simp only [Complex.zero_re, Complex.zero_im, zero_add]; nlinarith)
    rwa [inter_comm] at h
  have hd3 : Disjoint (cuspPiece r 3) (hornSet 0 α κ₁ κ₂ r) := by
    have h := hS.disjoint_of_rays (convex_ball (-I) 1) (T := ball (-I) 1) (d₁ := pt 0 (-1)) (d₂ := pt 1 (-2))
      (fun z hz => (hpU 3 (show z ∈ ball 0 r ∩ ball (-I) 1 from ⟨hz.2, hz.1⟩)).1) (by rw [im_pt_mul_conj_pt]; norm_num)
      (δ := 1 / 2) (by norm_num) (fun t ht0 ht1 => by
        obtain ⟨a1, b1⟩ := ray_coords 0 t 0 (-1)
        obtain ⟨a2, b2⟩ := ray_coords 0 t 1 (-2)
        refine ⟨?_, ?_⟩ <;> rw [mem_ball, dist_eq_norm, sub_neg_eq_add] <;> refine hsq _ ?_ <;> rw [norm_add_I_sq]
        · rw [a1, b1]; simp only [Complex.zero_re, Complex.zero_im, zero_add, mul_zero]; nlinarith
        · rw [a2, b2]; simp only [Complex.zero_re, Complex.zero_im, zero_add]; nlinarith)
    rwa [inter_comm] at h
  have hmem : ∀ z ∈ hornSet 0 α κ₁ κ₂ r, z ∈ cuspPiece r 0 ∨ z ∈ cuspPiece r 1 := by
    intro z hz
    have hzU := hS.subset hz
    rw [hpart, mem_iUnion] at hzU
    obtain ⟨i, hi⟩ := hzU
    fin_cases i
    · exact Or.inl hi
    · exact Or.inr hi
    · exact absurd hz (disjoint_left.mp hd2 hi)
    · exact absurd hz (disjoint_left.mp hd3 hi)
  refine ⟨?_, fun z hz => ?_⟩
  · rcases hmem x hx with hx0 | hx1
    · have hsub := hS.subset_of_isPreconnected (hpre 0) (hpU 0) hx0 hx
      refine Or.inl ⟨eq_e_of_ray_subset_hornSet (v := 0) (d := 1) (by simp) hr0 fun t ht0 htr => hsub ?_, hsub⟩
      rw [zero_add, mul_one]
      exact (hornSet_cusp_iff r _).mpr ⟨by rw [Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]; exact htr,
        by simpa using ht0, by
          refine (one_lt_sq_iff₀ (norm_nonneg _)).mp ?_; rw [norm_add_I_sq]; simp; nlinarith, by
          refine (one_lt_sq_iff₀ (norm_nonneg _)).mp ?_; rw [norm_sub_I_sq]; simp; nlinarith⟩
    · have hsub := hS.subset_of_isPreconnected (hpre 1) (hpU 1) hx1 hx
      refine Or.inr ⟨eq_e_of_ray_subset_hornSet (v := 0) (d := -1) (by simp) hr0 fun t ht0 htr => hsub ?_, hsub⟩
      rw [zero_add, mul_neg_one]
      refine mem_cuspPiece_one.mpr ⟨by rw [norm_neg, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]; exact htr,
        by simpa using ht0, ?_, ?_⟩ <;> refine (one_lt_sq_iff₀ (norm_nonneg _)).mp ?_
      · rw [norm_add_I_sq]; simp; nlinarith
      · rw [norm_sub_I_sq]; simp; nlinarith
  · rcases hmem z hz with h0 | h1
    · obtain ⟨-, -, h2, h3⟩ := (hornSet_cusp_iff r z).mp h0
      exact ⟨h3, h2⟩
    · obtain ⟨-, -, h2, h3⟩ := mem_cuspPiece_one.mp h1
      exact ⟨h3, h2⟩

/-- At `E` only the horn colour `1` has two sectors (the disc parts are one sector each, of colours `0` and `2`). -/
theorem bowtie_hasSectors_zero_two {c : Fin 6} {n : ℕ} (hn : bowtie.HasSectors 0 c n) (h2 : 2 ≤ n) : c = 1 := by
  obtain ⟨r, hrn, hr⟩ := (hn.and (Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 13 by norm_num))).exists
  have hlt : 1 < (bowtie.sectorsOf 0 r c).encard := by rw [hrn]; exact_mod_cast h2
  obtain ⟨S₁, S₂, ⟨hS₁, hc₁⟩, ⟨hS₂, hc₂⟩, hne⟩ := Set.one_lt_encard_iff.mp hlt
  obtain ⟨ho, hp, hd, hnn, hcl⟩ := cuspPiece_data hr.1 (by linarith [hr.2])
  have hpart := bowtie_partition hr.2
  obtain ⟨j₁, rfl⟩ := (isSector_iff_of_partition hpart ho hp hd hnn hcl).mp hS₁
  obtain ⟨j₂, rfl⟩ := (isSector_iff_of_partition hpart ho hp hd hnn hcl).mp hS₂
  have hcol : ∀ j, cuspPiece r j ⊆ bowtie.col ⁻¹' {c} → c = ![1, 1, 0, 2] j := by
    intro j hj
    obtain ⟨z, hz⟩ := hnn j
    have hzc : bowtie.col z = c := hj hz
    have := bowtieCol_cuspPiece hr.2 (z := z)
    fin_cases j
    · exact hzc.symm.trans (this.1 hz)
    · exact hzc.symm.trans (this.2.1 hz)
    · exact hzc.symm.trans (this.2.2.1 hz)
    · exact hzc.symm.trans (this.2.2.2 hz)
  have e1 := hcol j₁ hc₁
  have e2 := hcol j₂ hc₂
  fin_cases j₁ <;> fin_cases j₂ <;> simp_all

/-- A tile of the horn colour `1` lies in `C`, `CN` or `CS` (the three are separated open sets). -/
theorem bowtie_tileOf_one {T : Set ℂ} (hT : bowtie.TileOf 1 T) : T ⊆ bowtieC ∨ T ⊆ bowtieCN ∨ T ⊆ bowtieCS := by
  obtain ⟨⟨x, -, rfl⟩, hcol⟩ := hT
  have hpre := isPreconnected_connectedComponentIn (F := bowtie.interiorPts) (x := x)
  have hsub : connectedComponentIn bowtie.interiorPts x ⊆ bowtieC ∪ (bowtieCN ∪ bowtieCS) := by
    intro z hz
    have := (bowtieCol_cases z).2.1 (hcol hz)
    rcases this with (h | h) | h
    exacts [Or.inl h, Or.inr (Or.inl h), Or.inr (Or.inr h)]
  have hdCN : Disjoint bowtieCN bowtieCS := disjoint_left.mpr fun z h1 h2 => by
    have := abs_nonneg z.re; linarith [h1.1, h2.1]
  have hdC : Disjoint bowtieC (bowtieCN ∪ bowtieCS) := disjoint_left.mpr fun z h1 h2 => by
    have hi := abs_lt.mp h1.2.2.1
    rcases h2 with h2 | h2
    · have := abs_nonneg z.re; linarith [h2.1]
    · have := abs_nonneg z.re; linarith [h2.1]
  rcases hpre.subset_or_subset isOpen_bowtieC (isOpen_bowtieCN.union isOpen_bowtieCS) hdC hsub with h | h
  · exact Or.inl h
  · rcases hpre.subset_or_subset isOpen_bowtieCN isOpen_bowtieCS hdCN h with h' | h'
    · exact Or.inr (Or.inl h')
    · exact Or.inr (Or.inr h')

/-- The horn colour's contacts at `N = i` and `S′ = −i` on `ω(E)` are out-type. -/
theorem bowtie_outType_one : bowtie.OutType 0 1 I ∧ bowtie.OutType 0 1 (-I) := by
  have hcl : ∀ (A : Set ℂ) (a : ℝ), (∀ z ∈ A, z.im < a) → ∀ z ∈ closure A, z.im ≤ a := fun A a h z hz =>
    closure_minimal (fun w hw => (h w hw).le) (isClosed_le Complex.continuous_im continuous_const) hz
  have hcl' : ∀ (A : Set ℂ) (a : ℝ), (∀ z ∈ A, a < z.im) → ∀ z ∈ closure A, a ≤ z.im := fun A a h z hz =>
    closure_minimal (fun w hw => (h w hw).le) (isClosed_le continuous_const Complex.continuous_im) hz
  have hC : ∀ z ∈ bowtieC, |z.im| < 1 / 13 := fun z hz => hz.2.2.1
  have hCN : ∀ z ∈ bowtieCN, 1 < z.im := fun z hz => by have := abs_nonneg z.re; linarith [hz.1]
  have hCS : ∀ z ∈ bowtieCS, z.im < -1 := fun z hz => by have := abs_nonneg z.re; linarith [hz.1]
  have him : ∀ z ∈ closedBall (0 : ℂ) 1, |z.im| ≤ 1 := fun z hz => by
    rw [mem_closedBall, dist_zero_right] at hz; exact (Complex.abs_im_le_norm z).trans hz
  refine ⟨fun T hT hIT => ?_, fun T hT hIT => ?_⟩
  · rcases bowtie_tileOf_one hT with h | h | h
    · have := hcl T (1 / 13) (fun z hz => (abs_lt.mp (hC z (h hz))).2) I hIT; simp at this; norm_num at this
    · exact disjoint_left.mpr fun z hz hz' => by have := abs_le.mp (him z hz'); linarith [hCN z (h hz)]
    · have := hcl T (-1) (fun z hz => hCS z (h hz)) I hIT; simp at this; norm_num at this
  · rcases bowtie_tileOf_one hT with h | h | h
    · have := hcl' T (-1 / 13) (fun z hz => by linarith [(abs_lt.mp (hC z (h hz))).1]) (-I) hIT
      simp at this; norm_num at this
    · have := hcl' T 1 (fun z hz => hCN z (h hz)) (-I) hIT; simp at this; norm_num at this
    · exact disjoint_left.mpr fun z hz hz' => by have := abs_le.mp (him z hz'); linarith [hCS z (h hz)]

/-- **No MERGE at `E`**: only the horn colour has two sectors, and its allowed cone lies in the line `im d = 0`, its contacts at `±i`
being out-type. -/
theorem bowtie_not_merge_zero : ¬ bowtie.MergeAvailable 0 := by
  rintro ⟨c, n, hn2, hn, d, hd⟩
  obtain rfl := bowtie_hasSectors_zero_two hn hn2
  obtain ⟨hI, hnI, -, -⟩ := bowtie_neighbours
  have h1 : (1 : Fin 6) ∈ bowtie.coloursAt 0 := by rw [bowtie_coloursAt_zero.1]; simp
  have hcI : bowtie.IsContact 0 1 I := ⟨h1, by simp, show (1 : Fin 6) ∈ bowtie.coloursAt I by rw [hI]; simp⟩
  have hcnI : bowtie.IsContact 0 1 (-I) := ⟨h1, by simp, show (1 : Fin 6) ∈ bowtie.coloursAt (-I) by rw [hnI]; simp⟩
  have hsub : bowtie.allowedCone 0 1 ⊆ {z : ℂ | 0 * z.re + 1 * z.im = 0} := by
    intro w hw
    have a := (hw I hcI).2 bowtie_outType_one.1
    have b := (hw (-I) hcnI).2 bowtie_outType_one.2
    simp only [dot, sub_zero, map_neg, Complex.conj_I, neg_neg, Complex.mul_re, Complex.neg_re, Complex.neg_im,
      Complex.I_re, Complex.I_im] at a b
    simp only [mem_setOf_eq]
    linarith
  have := interior_mono hsub hd
  rw [interior_line_eq_empty (Or.inr one_ne_zero)] at this
  exact this

/-- **No MERGE-RAY at `E`**: two disjoint horn sets along one axis would both hold the same cusp horn. -/
theorem bowtie_not_ray_zero : ¬ bowtie.RayAvailable 0 := by
  rintro ⟨c, α, κ₁, κ₂, κ₃, κ₄, h23, ⟨-, h1⟩, ⟨-, h2⟩⟩
  obtain ⟨r, ⟨⟨hs1, -⟩, ⟨hs2, -⟩⟩, hr⟩ :=
    ((h1.and h2).and (Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 13 by norm_num))).exists
  obtain ⟨hA, -⟩ := bowtie_hornSet_zero hr.2 hs1
  obtain ⟨hB, -⟩ := bowtie_hornSet_zero hr.2 hs2
  have hdisj : ∀ z, z ∈ hornSet 0 α κ₁ κ₂ r → z ∈ hornSet 0 α κ₃ κ₄ r → False := fun z h h' =>
    tanBelow_tanAbove_false h23.le h.2.2.2 h'.2.2.1
  obtain ⟨-, -, -, hne, -⟩ := cuspPiece_data hr.1 (by linarith [hr.2])
  rcases hA with ⟨he, hA⟩ | ⟨he, hA⟩ <;> rcases hB with ⟨he', hB⟩ | ⟨he', hB⟩
  · obtain ⟨z, hz⟩ := hne 0; exact hdisj z (hA hz) (hB hz)
  · rw [he] at he'; norm_num at he'
  · rw [he] at he'; norm_num at he'
  · obtain ⟨z, hz⟩ := hne 1; exact hdisj z (hA hz) (hB hz)

/-- At `E`, a point of the domain near `E` on the horn's side of its normal line and off the horn has colour `0` or `2` (it lies in a
disc part: the other cusp horn is on the far side). -/
theorem bowtie_flank_colour {α κ₁ κ₂ r : ℝ} (hr : r ≤ 1 / 13) (hS : bowtie.IsSector 0 r (hornSet 0 α κ₁ κ₂ r)) {z : ℂ}
    (hz : z ∈ bowtie.interiorPts) (hzr : ‖z‖ < r) (hzx : 0 < frameX 0 α z) (hzH : z ∉ hornSet 0 α κ₁ κ₂ r) :
    bowtie.col z = 0 ∨ bowtie.col z = 2 := by
  have hzU : z ∈ bowtie.interiorPts ∩ ball 0 r := ⟨hz, mem_ball_zero_iff.mpr hzr⟩
  rw [bowtie_partition hr, mem_iUnion] at hzU
  obtain ⟨i, hi⟩ := hzU
  obtain ⟨hdir, -⟩ := bowtie_hornSet_zero hr hS
  have hfx1 : e α = 1 → frameX 0 α z = z.re := fun he => by simp [frameX, he]
  have hfx2 : e α = -1 → frameX 0 α z = -z.re := fun he => by simp [frameX, he]
  have hc := bowtieCol_cuspPiece hr (z := z)
  fin_cases i
  · exfalso
    have hre := ((hornSet_cusp_iff r z).mp hi).2.1
    rcases hdir with ⟨he, hsub⟩ | ⟨he, -⟩
    · exact hzH (hsub hi)
    · rw [hfx2 he] at hzx; linarith
  · exfalso
    have hre := (mem_cuspPiece_one.mp hi).2.1
    rcases hdir with ⟨he, -⟩ | ⟨he, hsub⟩
    · rw [hfx1 he] at hzx; linarith
    · exact hzH (hsub hi)
  · exact Or.inl (hc.2.2.1 hi)
  · exact Or.inr (hc.2.2.2 hi)

/-- **No SHAVE at `E`**: a horn there is a cusp horn, its flanks are the colours `0` and `2`, and every point of it is in the shadow
of both classes (`mem_shadow_bowtie_region_zero/two`), so neither part of any split is clear for its flank. -/
theorem bowtie_not_shave_zero : ¬ bowtie.ShaveAvailable 0 := by
  rintro ⟨c, g, h, α, κ₁, κ₂, σ, ⟨-, hH⟩, ⟨κ', hκ', hfa⟩, ⟨κ'', hκ'', hfb⟩, -, -, hsh⟩
  obtain ⟨r, ⟨⟨⟨⟨hs, -⟩, hfa'⟩, hfb'⟩, hsh'⟩, hr⟩ :=
    ((((hH.and hfa).and hfb).and hsh).and (Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 20 by norm_num))).exists
  have hr13 : r ≤ 1 / 13 := by linarith [hr.2]
  obtain ⟨-, hout⟩ := bowtie_hornSet_zero hr13 hs
  obtain ⟨z₁, hz₁, -, -⟩ := exists_mem_hornSet_aboveBelow 0 α (κ₁ := κ₂) (κ₂ := κ') (s := (κ₂ + κ') / 2) (m := κ') hr.1
    (by linarith) (by linarith) (by intro h; linarith)
  obtain ⟨z₂, hz₂, -, -⟩ := exists_mem_hornSet_aboveBelow 0 α (κ₁ := κ'') (κ₂ := κ₁) (s := (κ'' + κ₁) / 2) (m := κ₁) hr.1
    (by linarith) (by linarith) (by intro h; linarith)
  have hg : g = 0 ∨ g = 2 := by
    obtain ⟨hint, hcol⟩ := hfa' hz₁
    have := bowtie_flank_colour hr13 hs hint (by simpa using hz₁.1) hz₁.2.1
      (fun hH' => tanBelow_tanAbove_false le_rfl hH'.2.2.2 hz₁.2.2.1)
    rwa [show bowtie.col z₁ = g from hcol] at this
  have hh : h = 0 ∨ h = 2 := by
    obtain ⟨hint, hcol⟩ := hfb' hz₂
    have := bowtie_flank_colour hr13 hs hint (by simpa using hz₂.1) hz₂.2.1
      (fun hH' => tanBelow_tanAbove_false le_rfl hz₂.2.2.2 hH'.2.2.1)
    rwa [show bowtie.col z₂ = h from hcol] at this
  obtain ⟨z, hz⟩ := hs.nonempty
  obtain ⟨h1, h2⟩ := hout z hz
  have hzr : ‖z‖ < 1 / 20 := by
    have := mem_ball_zero_iff.mp (hs.subset hz).2; linarith [hr.2]
  have hnc : ∀ j : Fin 6, j = 0 ∨ j = 2 → ¬ bowtie.IsClear j z := by
    rintro j (rfl | rfl) hc
    · obtain ⟨y, hy, hyd⟩ := mem_shadow_bowtie_region_zero hzr h1; exact hc y hy hyd
    · obtain ⟨y, hy, hyd⟩ := mem_shadow_bowtie_region_two hzr h2; exact hc y hy hyd
  obtain ⟨hA, hB⟩ := hsh' z hz
  by_cases hσ : TanAbove 0 α σ z
  · exact hnc g hg (hA hσ)
  · exact hnc h hh (hB hσ)

/-- At `N = i` and `S′ = −i` every colour has at most one sector. -/
theorem bowtie_hasSectors_le_one {v : ℂ} (hv : v = I ∨ v = -I) {c : Fin 6} {n : ℕ} (hn : bowtie.HasSectors v c n) : n ≤ 1 := by
  obtain ⟨-, -, hI, hnI⟩ := bowtie_neighbours
  by_cases hc : c ∈ bowtie.coloursAt v
  · rcases hv with rfl | rfl
    · exact (hn.eq (hI c hc)).le
    · exact (hn.eq (hnI c hc)).le
  · rw [hn.eq_zero_of_not_mem hc]; exact zero_le_one

/-- No move at `±i`: no colour has two sectors, and there is no horn. -/
theorem bowtie_terminal_pm_I {v : ℂ} (hv : v = I ∨ v = -I) :
    ¬ bowtie.MergeAvailable v ∧ ¬ bowtie.RayAvailable v ∧ ¬ bowtie.ShaveAvailable v := by
  have hno : ∀ α κ₁ κ₂ c, ¬ bowtie.IsHorn v α κ₁ κ₂ c := by
    rcases hv with rfl | rfl
    exacts [bowtie_not_isHorn_I, bowtie_not_isHorn_negI]
  refine ⟨?_, ?_, ?_⟩
  · rintro ⟨c, n, h2, hn, -⟩; have := bowtie_hasSectors_le_one hv hn; omega
  · rintro ⟨c, α, κ₁, κ₂, κ₃, κ₄, -, hH, -⟩; exact hno _ _ _ _ hH
  · rintro ⟨c, g, h, α, κ₁, κ₂, σ, hH, -⟩; exact hno _ _ _ _ hH

/-- **A one-vertex stuck chain**: `E` is stuck, neither neighbour is. -/
theorem bowtie_isStuck : bowtie.IsStuck 0 ∧ ¬ bowtie.IsStuck I ∧ ¬ bowtie.IsStuck (-I) := by
  refine ⟨⟨bowtie_not_merge_zero, bowtie_not_ray_zero, bowtie_not_shave_zero, 1, 2, le_rfl, bowtie_coloursAt_zero.2⟩, ?_, ?_⟩
  · rintro ⟨-, -, -, c, n, h2, hn⟩; have := bowtie_hasSectors_le_one (Or.inl rfl) hn; omega
  · rintro ⟨-, -, -, c, n, h2, hn⟩; have := bowtie_hasSectors_le_one (Or.inr rfl) hn; omega

/-- `bowtie_isStuck`'s second clause as a closed refutation: `N = i` is not stuck. The vacuity scan's evidence that `IsStuck` is
refutable at a concrete map (`scripts/Vacuity.lean`, wave 4's carriers). -/
theorem bowtie_not_isStuck_I : ¬ bowtie.IsStuck I := bowtie_isStuck.2.1

/-- `bowtie_not_isHorn_I` at one closed instance (the horn the bowtie has at `0`, asked at `i`). The vacuity scan's evidence that
`IsHorn` is refutable at a concrete map (`scripts/Vacuity.lean`, wave 4's carriers). -/
theorem bowtie_not_isHorn_I_axis : ¬ bowtie.IsHorn I 0 (-1) 1 1 := bowtie_not_isHorn_I 0 (-1) 1 1

/-- **No MERGE, MERGE-RAY or SHAVE applies at `E`, `E ± n`.** -/
theorem bowtie_terminalOn : bowtie.TerminalOn {0, I, -I} := by
  intro v hv
  simp only [mem_insert_iff, mem_singleton_iff] at hv
  rcases hv with rfl | rfl | rfl
  · exact ⟨bowtie_not_merge_zero, bowtie_not_ray_zero, bowtie_not_shave_zero⟩
  · exact bowtie_terminal_pm_I (Or.inl rfl)
  · exact bowtie_terminal_pm_I (Or.inr rfl)

/-! ### The ends of the bowtie's unit arcs lie in its domain (FS131-I4f) -/

/-- An open set lies in the closure of `S` when it does off a closed set with empty interior. -/
theorem subset_closure_of_diff_subset {B K S : Set ℂ} (hB : IsOpen B) (hK0 : interior K = ∅) (h : B \ K ⊆ S) :
    B ⊆ closure S :=
  ((interior_eq_empty_iff_dense_compl.mp hK0).open_subset_closure_inter hB).trans
    (closure_mono fun _ hz => h ⟨hz.1, hz.2⟩)

/-- A unit circle and two lines form a closed set with empty interior. -/
theorem interior_sphere_union_lines {c : ℂ} {a₁ b₁ c₁ a₂ b₂ c₂ : ℝ} (h₁ : a₁ ≠ 0 ∨ b₁ ≠ 0) (h₂ : a₂ ≠ 0 ∨ b₂ ≠ 0) :
    IsClosed (sphere c 1 ∪ {z : ℂ | a₁ * z.re + b₁ * z.im = c₁} ∪ {z | a₂ * z.re + b₂ * z.im = c₂}) ∧
      interior (sphere c 1 ∪ {z : ℂ | a₁ * z.re + b₁ * z.im = c₁} ∪ {z | a₂ * z.re + b₂ * z.im = c₂}) = ∅ := by
  refine ⟨(isClosed_sphere.union (isClosed_line _ _ _)).union (isClosed_line _ _ _), ?_⟩
  rw [interior_union_isClosed_of_interior_empty (isClosed_sphere.union (isClosed_line _ _ _)) (interior_line_eq_empty h₂),
    interior_union_isClosed_of_interior_empty isClosed_sphere (interior_line_eq_empty h₁), interior_sphere _ one_ne_zero]

/-- The unit arcs' end `(5/13, 1/13)` lies in the bowtie's domain: off `ω(i)` and the lines `x = 5/13`, `12x + 5y = 5`, the ball of
radius `1/100` about it lies in `G ∪ C ∪ ZR`. -/
theorem bowtie_dom_end_pp : pt (5 / 13) (1 / 13) ∈ bowtie.dom := by
  obtain ⟨-, hK0⟩ := interior_sphere_union_lines (c := I) (a₁ := 1) (b₁ := 0) (c₁ := 5 / 13) (a₂ := 12) (b₂ := 5) (c₂ := 5)
    (by norm_num) (by norm_num)
  refine interior_maximal (subset_closure_of_diff_subset isOpen_ball hK0 ?_) isOpen_ball
    (mem_ball_self (by norm_num : (0:ℝ) < 1 / 100))
  rintro z ⟨hz, hK'⟩
  simp only [mem_union, mem_sphere_iff_norm, mem_setOf_eq, not_or, one_mul, zero_mul, add_zero] at hK'
  obtain ⟨⟨k1, k2⟩, k3⟩ := hK'
  rw [mem_ball, dist_eq_norm] at hz
  simp only [pt] at hz
  have hx : |z.re - 5 / 13| < 1 / 100 := by
    have := Complex.abs_re_le_norm (z - pt (5 / 13) (1 / 13)); simp only [Complex.sub_re, pt] at this; linarith
  have hy : |z.im - 1 / 13| < 1 / 100 := by
    have := Complex.abs_im_le_norm (z - pt (5 / 13) (1 / 13)); simp only [Complex.sub_im, pt] at this; linarith
  have hx' := abs_lt.mp hx
  have hy' := abs_lt.mp hy
  have hre0 : 0 < z.re := by linarith
  simp only [bowtieTiles, mem_union]
  have hZ : z ∈ bowtieZ 1 ↔ 5 / 13 < z.re ∨ 5 < 12 * z.re + 5 * z.im := by
    simp only [bowtieZ, mem_setOf_eq, one_mul]
    constructor
    · rintro ⟨-, -, -, h⟩
      by_contra hc; push Not at hc
      exact h ⟨hc.1, by linarith, by linarith⟩
    · intro h
      refine ⟨by linarith, by linarith, by rw [abs_lt]; constructor <;> linarith, ?_⟩
      rintro ⟨h1, h2, -⟩
      rcases h with h | h <;> linarith
  rcases lt_or_gt_of_ne k2 with h1 | h1
  · rcases lt_or_gt_of_ne k3 with h2 | h2
    · -- inside the corner: `G` or `C`
      have hs := norm_sub_I_sq z
      rcases lt_or_gt_of_ne k1 with h3 | h3
      · left; left; left; left; left; left; left; left; left; left
        exact ⟨h3, by linarith, by rw [abs_of_pos hre0]; linarith⟩
      · left; left; left; left; left; left; left; left; right
        have e3 := (one_lt_sq_iff₀ (norm_nonneg _)).mpr h3
        have hs2 := norm_add_I_sq z
        have him : z.im < 1 / 13 := by nlinarith
        refine ⟨hre0.ne', by rw [abs_of_pos hre0]; exact h1, by rw [abs_lt]; constructor <;> linarith, h3, ?_⟩
        have : 1 < ‖z + I‖ ^ 2 := by nlinarith
        exact (one_lt_sq_iff₀ (norm_nonneg _)).mp this
    · left; right; exact hZ.mpr (Or.inr h2)
  · left; right; exact hZ.mpr (Or.inl h1)

/-- The unit arcs' end `(−5/13, 1/13)` lies in the bowtie's domain (the mirror: `G ∪ C ∪ ZL` off `ω(i)`, `x = −5/13`, `−12x + 5y = 5`). -/
theorem bowtie_dom_end_np : pt (-5 / 13) (1 / 13) ∈ bowtie.dom := by
  obtain ⟨-, hK0⟩ := interior_sphere_union_lines (c := I) (a₁ := 1) (b₁ := 0) (c₁ := -5 / 13) (a₂ := -12) (b₂ := 5) (c₂ := 5)
    (by norm_num) (by norm_num)
  refine interior_maximal (subset_closure_of_diff_subset isOpen_ball hK0 ?_) isOpen_ball
    (mem_ball_self (by norm_num : (0:ℝ) < 1 / 100))
  rintro z ⟨hz, hK'⟩
  simp only [mem_union, mem_sphere_iff_norm, mem_setOf_eq, not_or, one_mul, zero_mul, add_zero] at hK'
  obtain ⟨⟨k1, k2⟩, k3⟩ := hK'
  rw [mem_ball, dist_eq_norm] at hz
  simp only [pt] at hz
  have hx : |z.re - -5 / 13| < 1 / 100 := by
    have := Complex.abs_re_le_norm (z - pt (-5 / 13) (1 / 13)); simp only [Complex.sub_re, pt] at this; linarith
  have hy : |z.im - 1 / 13| < 1 / 100 := by
    have := Complex.abs_im_le_norm (z - pt (-5 / 13) (1 / 13)); simp only [Complex.sub_im, pt] at this; linarith
  have hx' := abs_lt.mp hx
  have hy' := abs_lt.mp hy
  have hre0 : z.re < 0 := by linarith
  simp only [bowtieTiles, mem_union]
  have hZ : z ∈ bowtieZ (-1) ↔ z.re < -5 / 13 ∨ 5 < -12 * z.re + 5 * z.im := by
    simp only [bowtieZ, mem_setOf_eq, neg_one_mul]
    constructor
    · rintro ⟨-, -, -, h⟩
      by_contra hc; push Not at hc
      exact h ⟨by linarith, by linarith, by linarith⟩
    · intro h
      refine ⟨by linarith, by linarith, by rw [abs_lt]; constructor <;> linarith, ?_⟩
      rintro ⟨h1, h2, -⟩
      rcases h with h | h <;> linarith
  rcases lt_or_gt_of_ne k2 with h1 | h1
  · right; exact hZ.mpr (Or.inl h1)
  · rcases lt_or_gt_of_ne k3 with h2 | h2
    · have hs := norm_sub_I_sq z
      rcases lt_or_gt_of_ne k1 with h3 | h3
      · left; left; left; left; left; left; left; left; left; left
        exact ⟨h3, by linarith, by rw [abs_of_neg hre0]; linarith⟩
      · left; left; left; left; left; left; left; left; right
        have e3 := (one_lt_sq_iff₀ (norm_nonneg _)).mpr h3
        have hs2 := norm_add_I_sq z
        have him : z.im < 1 / 13 := by nlinarith
        refine ⟨hre0.ne, by rw [abs_of_neg hre0]; linarith, by rw [abs_lt]; constructor <;> linarith, h3, ?_⟩
        have : 1 < ‖z + I‖ ^ 2 := by nlinarith
        exact (one_lt_sq_iff₀ (norm_nonneg _)).mp this
    · right; exact hZ.mpr (Or.inr h2)

/-- The unit arcs' end `(5/13, −1/13)` lies in the bowtie's domain (`H ∪ C ∪ ZR` off `ω(−i)`, `x = 5/13`, `12x − 5y = 5`). -/
theorem bowtie_dom_end_pn : pt (5 / 13) (-1 / 13) ∈ bowtie.dom := by
  obtain ⟨-, hK0⟩ := interior_sphere_union_lines (c := -I) (a₁ := 1) (b₁ := 0) (c₁ := 5 / 13) (a₂ := 12) (b₂ := -5) (c₂ := 5)
    (by norm_num) (by norm_num)
  refine interior_maximal (subset_closure_of_diff_subset isOpen_ball hK0 ?_) isOpen_ball
    (mem_ball_self (by norm_num : (0:ℝ) < 1 / 100))
  rintro z ⟨hz, hK'⟩
  simp only [mem_union, mem_sphere_iff_norm, mem_setOf_eq, not_or, one_mul, zero_mul, add_zero, sub_neg_eq_add] at hK'
  obtain ⟨⟨k1, k2⟩, k3⟩ := hK'
  rw [mem_ball, dist_eq_norm] at hz
  simp only [pt] at hz
  have hx : |z.re - 5 / 13| < 1 / 100 := by
    have := Complex.abs_re_le_norm (z - pt (5 / 13) (-1 / 13)); simp only [Complex.sub_re, pt] at this; linarith
  have hy : |z.im - -1 / 13| < 1 / 100 := by
    have := Complex.abs_im_le_norm (z - pt (5 / 13) (-1 / 13)); simp only [Complex.sub_im, pt] at this; linarith
  have hx' := abs_lt.mp hx
  have hy' := abs_lt.mp hy
  have hre0 : 0 < z.re := by linarith
  simp only [bowtieTiles, mem_union]
  have hZ : z ∈ bowtieZ 1 ↔ 5 / 13 < z.re ∨ 5 < 12 * z.re + -5 * z.im := by
    simp only [bowtieZ, mem_setOf_eq, one_mul]
    constructor
    · rintro ⟨-, -, -, h⟩
      by_contra hc; push Not at hc
      exact h ⟨hc.1, by linarith, by linarith⟩
    · intro h
      refine ⟨by linarith, by linarith, by rw [abs_lt]; constructor <;> linarith, ?_⟩
      rintro ⟨h1, -, h3⟩
      rcases h with h | h <;> linarith
  rcases lt_or_gt_of_ne k2 with h1 | h1
  · rcases lt_or_gt_of_ne k3 with h2 | h2
    · have hs := norm_add_I_sq z
      rcases lt_or_gt_of_ne k1 with h3 | h3
      · left; left; left; left; left; left; left; left; left; right
        exact ⟨h3, by linarith, by rw [abs_of_pos hre0]; linarith⟩
      · left; left; left; left; left; left; left; left; right
        have e3 := (one_lt_sq_iff₀ (norm_nonneg _)).mpr h3
        have hs2 := norm_sub_I_sq z
        have him : -1 / 13 < z.im := by nlinarith
        refine ⟨hre0.ne', by rw [abs_of_pos hre0]; exact h1, by rw [abs_lt]; constructor <;> linarith, ?_, h3⟩
        have : 1 < ‖z - I‖ ^ 2 := by nlinarith
        exact (one_lt_sq_iff₀ (norm_nonneg _)).mp this
    · left; right; exact hZ.mpr (Or.inr h2)
  · left; right; exact hZ.mpr (Or.inl h1)

/-- The unit arcs' end `(−5/13, −1/13)` lies in the bowtie's domain (`H ∪ C ∪ ZL` off `ω(−i)`, `x = −5/13`, `−12x − 5y = 5`). -/
theorem bowtie_dom_end_nn : pt (-5 / 13) (-1 / 13) ∈ bowtie.dom := by
  obtain ⟨-, hK0⟩ := interior_sphere_union_lines (c := -I) (a₁ := 1) (b₁ := 0) (c₁ := -5 / 13) (a₂ := -12) (b₂ := -5) (c₂ := 5)
    (by norm_num) (by norm_num)
  refine interior_maximal (subset_closure_of_diff_subset isOpen_ball hK0 ?_) isOpen_ball
    (mem_ball_self (by norm_num : (0:ℝ) < 1 / 100))
  rintro z ⟨hz, hK'⟩
  simp only [mem_union, mem_sphere_iff_norm, mem_setOf_eq, not_or, one_mul, zero_mul, add_zero, sub_neg_eq_add] at hK'
  obtain ⟨⟨k1, k2⟩, k3⟩ := hK'
  rw [mem_ball, dist_eq_norm] at hz
  simp only [pt] at hz
  have hx : |z.re - -5 / 13| < 1 / 100 := by
    have := Complex.abs_re_le_norm (z - pt (-5 / 13) (-1 / 13)); simp only [Complex.sub_re, pt] at this; linarith
  have hy : |z.im - -1 / 13| < 1 / 100 := by
    have := Complex.abs_im_le_norm (z - pt (-5 / 13) (-1 / 13)); simp only [Complex.sub_im, pt] at this; linarith
  have hx' := abs_lt.mp hx
  have hy' := abs_lt.mp hy
  have hre0 : z.re < 0 := by linarith
  simp only [bowtieTiles, mem_union]
  have hZ : z ∈ bowtieZ (-1) ↔ z.re < -5 / 13 ∨ 5 < -12 * z.re + -5 * z.im := by
    simp only [bowtieZ, mem_setOf_eq, neg_one_mul]
    constructor
    · rintro ⟨-, -, -, h⟩
      by_contra hc; push Not at hc
      exact h ⟨by linarith, by linarith, by linarith⟩
    · intro h
      refine ⟨by linarith, by linarith, by rw [abs_lt]; constructor <;> linarith, ?_⟩
      rintro ⟨h1, -, h3⟩
      rcases h with h | h <;> linarith
  rcases lt_or_gt_of_ne k2 with h1 | h1
  · right; exact hZ.mpr (Or.inl h1)
  · rcases lt_or_gt_of_ne k3 with h2 | h2
    · have hs := norm_add_I_sq z
      rcases lt_or_gt_of_ne k1 with h3 | h3
      · left; left; left; left; left; left; left; left; left; right
        exact ⟨h3, by linarith, by rw [abs_of_neg hre0]; linarith⟩
      · left; left; left; left; left; left; left; left; right
        have e3 := (one_lt_sq_iff₀ (norm_nonneg _)).mpr h3
        have hs2 := norm_sub_I_sq z
        have him : -1 / 13 < z.im := by nlinarith
        refine ⟨hre0.ne, by rw [abs_of_neg hre0]; linarith, by rw [abs_lt]; constructor <;> linarith, ?_, h3⟩
        have : 1 < ‖z - I‖ ^ 2 := by nlinarith
        exact (one_lt_sq_iff₀ (norm_nonneg _)).mp this
    · right; exact hZ.mpr (Or.inr h2)

/-- The ends of the bowtie's unit arcs: `i + e(3π/2 ∓ arcsin(5/13)) = (∓5/13, 1/13)`, `−i + e(π/2 ∓ arcsin(5/13)) = (±5/13, −1/13)`. -/
theorem bowtie_arc_ends :
    I + (1 : ℝ) * e (3 * π / 2 - bowtieAngle) = pt (-5 / 13) (1 / 13) ∧ I + (1 : ℝ) * e (3 * π / 2 + bowtieAngle) = pt (5 / 13) (1 / 13) ∧
      -I + (1 : ℝ) * e (π / 2 - bowtieAngle) = pt (5 / 13) (-1 / 13) ∧ -I + (1 : ℝ) * e (π / 2 + bowtieAngle) = pt (-5 / 13) (-1 / 13) := by
  have hs : Real.sin bowtieAngle = 5 / 13 := Real.sin_arcsin (by norm_num) (by norm_num)
  have hc : Real.cos bowtieAngle = 12 / 13 := by
    rw [bowtieAngle, Real.cos_arcsin, show (1 : ℝ) - (5 / 13) ^ 2 = (12 / 13) ^ 2 by norm_num]
    exact Real.sqrt_sq (by norm_num)
  have h1 : 3 * π / 2 - bowtieAngle = (π / 2 - bowtieAngle) + π := by ring
  have h2 : 3 * π / 2 + bowtieAngle = (bowtieAngle + π / 2) + π := by ring
  have h3 : π / 2 + bowtieAngle = bowtieAngle + π / 2 := by ring
  refine ⟨?_, ?_, ?_, ?_⟩ <;> apply Complex.ext <;>
    simp only [Complex.add_re, Complex.add_im, Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im, Complex.mul_re,
      Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e, pt, h1, h2, h3, Real.cos_add_pi, Real.sin_add_pi,
      Real.cos_pi_div_two_sub, Real.sin_pi_div_two_sub, Real.cos_add_pi_div_two, Real.sin_add_pi_div_two, hs, hc] <;>
    norm_num

/-- **Every unit arc's end is interior** to the fragment (the arcs' ends `(±5/13, ±1/13)` lie in its domain, with their
neighbourhoods coloured). -/
theorem bowtie_unitArcEnds : ∀ a ∈ bowtie.arcs, ∀ p θ₀ θ₁, a = .circ p 1 θ₀ θ₁ →
    p + e θ₀ ∈ bowtie.dom ∧ p + e θ₁ ∈ bowtie.dom := by
  intro a ha p θ₀ θ₁ hpa
  obtain ⟨e1, e2, e3, e4⟩ := bowtie_arc_ends
  simp only [one_mul, Complex.ofReal_one] at e1 e2 e3 e4
  change a ∈ bowtieArcs at ha
  simp only [bowtieArcs, mem_setOf_eq, List.mem_cons, List.not_mem_nil, or_false] at ha
  rcases ha with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
    rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · simp only [Arc.circ.injEq] at hpa
    obtain ⟨rfl, -, rfl, rfl⟩ := hpa
    rw [e1, e2]; exact ⟨bowtie_dom_end_np, bowtie_dom_end_pp⟩
  · simp only [Arc.circ.injEq] at hpa
    obtain ⟨rfl, -, rfl, rfl⟩ := hpa
    rw [e3, e4]; exact ⟨bowtie_dom_end_pn, bowtie_dom_end_nn⟩
  all_goals exact absurd hpa (by simp)

/-- **FS112-FLANK**, its last clause, "SHAVE's criterion is incomplete there", witnessed by the bowtie: at `E = 0` neither flank colour
(`0` above the horns, `2` below) has an out-type contact at `N = i` or `S′ = −i` — so N4-FLANK's list of shadows (out-type flank tiles at
`S′` and `N` only) is empty and the criterion read from it would shave — and yet no SHAVE is available at `E`: the in-type sectors at
`N`, `S′` doubly shadow both horns (`bowtie_doublyShadowed`), whose bounds are `±1`. -/
theorem flank_incomplete_bowtie :
    (∀ j ∈ ({0, 2} : Set (Fin 6)), ∀ w ∈ ({I, -I} : Set ℂ), ¬ (bowtie.IsContact 0 j w ∧ bowtie.OutType 0 j w)) ∧
      ¬ bowtie.ShaveAvailable 0 := by
  refine ⟨?_, (bowtie_terminalOn 0 (by simp)).2.2⟩
  intro j hj w hw ⟨hcon, hout⟩
  simp only [mem_insert_iff, mem_singleton_iff] at hj hw
  obtain ⟨hI, hnI, -, -⟩ := bowtie_neighbours
  obtain ⟨⟨-, hin0⟩, ⟨-, hin2⟩⟩ := bowtie_inType
  have hcw : j ∈ bowtie.coloursAt w := hcon.2.2
  rcases hj with rfl | rfl <;> rcases hw with rfl | rfl
  · obtain ⟨T, hT, hIT⟩ := (bowtie.mem_coloursAt_iff_exists_tileOf bowtie_mem_dom.2.1).mp hcw
    obtain ⟨x, hx⟩ := hT.1.nonempty
    exact disjoint_left.mp (hout T hT hIT) hx (ball_subset_closedBall (hin0 T hT hIT hx))
  · rw [hnI] at hcw; simp at hcw
  · rw [hI] at hcw; simp at hcw
  · obtain ⟨T, hT, hIT⟩ := (bowtie.mem_coloursAt_iff_exists_tileOf bowtie_mem_dom.2.2).mp hcw
    obtain ⟨x, hx⟩ := hT.1.nonempty
    exact disjoint_left.mp (hout T hT hIT) hx (ball_subset_closedBall (hin2 T hT hIT hx))

end ArcMap

end HadwigerNelson.Plane
