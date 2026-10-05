import Proofs.HadwigerNelson.Plane.Slack
import Proofs.HadwigerNelson.Plane.ArcMap
import Proofs.HadwigerNelson.Plane.LocalStructure
import Proofs.HadwigerNelson.UnitDistance
import Mathlib.Combinatorics.SimpleGraph.Finsubgraph

/-!
# Valid fragments on discs of every radius bound `χ_m⁰`, and N-EASY (FS-131 wave 2)

Row: **FS116-O1-YESLIM** (carrying FS129-SR2-YESLIM-EQ: its first clause is FS106-EQ's (c) ⟹ (a) composed with Lemma P;
moved from wave 3 by ruling 6). Supporting lemma **N-EASY** (row 130's free half, `χ(ℝ²) ≤ χ_m⁰(ℝ²)`, no MR; FS-103;
`[GwynStavrianos2022]` Lemma 2, Thm 2), formalized here. Plan: `plans/FS131-w2-kernel-plan.md` § 4.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric HadwigerNelson

/-- The set of angles at which a class has non-null unit pairs, as a subset of all of `ℝ`, is null. -/
theorem AeColouring.volume_badAngles_null {k : ℕ} (c : AeColouring k) (j : Fin k) :
    volume {θ : ℝ | ¬ volume {x : ℂ | x ∈ c.cls j ∧ x + e θ ∈ c.cls j} = 0} = 0 := by
  have h := (unitPairsNull_iff_ae_slice (c.measurableSet_cls j)).1 (c.unitPairsNull j)
  set Bad : Set ℝ := {θ : ℝ | ¬ volume {x : ℂ | x ∈ c.cls j ∧ x + e θ ∈ c.cls j} = 0} with hBad
  have h0 : volume (Bad ∩ Ico 0 (2 * Real.pi)) = 0 := by
    rw [ae_iff] at h
    have : arcLength {θ | ¬ volume {x : ℂ | x ∈ c.cls j ∧ x + e θ ∈ c.cls j} = 0} = 0 := h
    rw [arcLength, Measure.restrict_apply' measurableSet_Ico] at this
    simpa [hBad, inter_comm] using this
  have hper : ∀ (n : ℤ) θ, θ ∈ Bad ↔ θ - n * (2 * Real.pi) ∈ Bad := by
    intro n θ
    have : e (θ - n * (2 * Real.pi)) = e θ := by
      have h := (Function.Periodic.int_mul (fun θ : ℝ => e_add_two_pi θ) (-n)) θ
      simpa [sub_eq_add_neg, mul_comm] using h
    simp only [hBad, mem_setOf_eq, this]
  have hsub : Bad ⊆ ⋃ n : ℤ, (fun θ => θ - n * (2 * Real.pi)) ⁻¹' (Bad ∩ Ico 0 (2 * Real.pi)) := by
    intro θ hθ
    refine mem_iUnion.2 ⟨⌊θ / (2 * Real.pi)⌋, (hper _ _).1 hθ, ?_⟩
    have hp : 0 < 2 * Real.pi := by positivity
    constructor
    · have := Int.floor_le (θ / (2 * Real.pi))
      rw [le_div_iff₀ hp] at this
      linarith
    · have := Int.lt_floor_add_one (θ / (2 * Real.pi))
      rw [div_lt_iff₀ hp] at this
      linarith
  refine measure_mono_null hsub (measure_iUnion_null fun n => ?_)
  have : (fun θ : ℝ => θ - n * (2 * Real.pi)) = (fun θ => θ + (-(n * (2 * Real.pi)))) := by funext θ; ring
  rw [this, measure_preimage_add_right]
  exact h0

/-- **A good rigid motion for a finite point set**: some rotation-translation `z ↦ e θ z + v` makes `c` proper on every
unit pair of `V`. -/
theorem AeColouring.exists_motion {k : ℕ} (c : AeColouring k) {V : Set ℂ} (hV : V.Finite) :
    ∃ (θ : ℝ) (v : ℂ), ∀ u ∈ V, ∀ w ∈ V, dist u w = 1 → c.col (e θ * u + v) ≠ c.col (e θ * w + v) := by
  classical
  -- the bad angles
  set BadA : Set ℝ := ⋃ (p : ℂ × ℂ) (_ : p ∈ V ×ˢ V), ⋃ j : Fin k,
    (fun θ => θ + Complex.arg (p.2 - p.1)) ⁻¹' {θ : ℝ | ¬ volume {x : ℂ | x ∈ c.cls j ∧ x + e θ ∈ c.cls j} = 0} with hBadA
  have hBadA0 : volume BadA = 0 := by
    refine measure_biUnion_null_iff (hV.prod hV).countable |>.2 fun p _ => measure_iUnion_null fun j => ?_
    rw [measure_preimage_add_right]
    exact c.volume_badAngles_null j
  obtain ⟨θ, hθ⟩ : ∃ θ : ℝ, θ ∉ BadA := by
    by_contra hcon
    push Not at hcon
    have : (univ : Set ℝ) ⊆ BadA := fun θ _ => hcon θ
    have h2 := measure_mono (μ := (volume : Measure ℝ)) this
    rw [hBadA0] at h2
    simp at h2
  -- the bad translations
  set BadV : Set ℂ := ⋃ (p : ℂ × ℂ) (_ : p ∈ V ×ˢ V), ⋃ j : Fin k,
    (fun v => e θ * p.1 + v) ⁻¹' {x : ℂ | x ∈ c.cls j ∧ x + e (θ + Complex.arg (p.2 - p.1)) ∈ c.cls j} with hBadV
  have hBadV0 : volume BadV = 0 := by
    refine measure_biUnion_null_iff (hV.prod hV).countable |>.2 fun p hp => measure_iUnion_null fun j => ?_
    rw [measure_preimage_add]
    by_contra hne
    apply hθ
    refine mem_iUnion₂.2 ⟨p, hp, mem_iUnion.2 ⟨j, ?_⟩⟩
    exact hne
  obtain ⟨v, hv⟩ : ∃ v : ℂ, v ∉ BadV := by
    by_contra hcon
    push Not at hcon
    have : (univ : Set ℂ) ⊆ BadV := fun v _ => hcon v
    have h2 := measure_mono (μ := (volume : Measure ℂ)) this
    rw [hBadV0] at h2
    have : (volume : Measure ℂ) univ ≠ 0 := by simp
    exact this (nonpos_iff_eq_zero.1 h2)
  refine ⟨θ, v, fun u hu w hw hd heq => hv ?_⟩
  refine mem_iUnion₂.2 ⟨(u, w), ⟨hu, hw⟩, mem_iUnion.2 ⟨c.col (e θ * u + v), ?_⟩⟩
  refine ⟨?_, ?_⟩
  · show e θ * u + v ∈ c.cls _
    simp [AeColouring.cls]
  · have h1 : w - u = e (Complex.arg (w - u)) := by
      have hn : ‖w - u‖ = 1 := by rw [← dist_eq_norm, dist_comm]; exact hd
      have := self_eq_norm_mul_e_arg (w - u)
      rw [hn] at this; simpa using this
    have : e θ * u + v + e (θ + Complex.arg (w - u)) = e θ * w + v := by
      rw [e_add, ← h1]; ring
    show e θ * u + v + e (θ + Complex.arg (w - u)) ∈ c.cls _
    rw [this]
    simp [AeColouring.cls, heq]

/-- **N-EASY**: `χ(ℝ²) ≤ χ_m⁰(ℝ²)` — a measurable colouring proper at almost every unit pair, moved by an almost-every
rigid motion, colours each finite unit-distance graph properly; de Bruijn–Erdős finishes. -/
theorem chromaticNumber_plane_le_chiM0 : (unitDistance ℂ).chromaticNumber ≤ chiM0 := by
  refine le_iInf₂ fun k ⟨c⟩ => ?_
  rw [SimpleGraph.chromaticNumber_le_iff_colorable]
  refine SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom fun G' hfin => Nonempty.some (α := G'.coe.Coloring (Fin k)) ?_
  obtain ⟨θ, v, hmot⟩ := c.exists_motion hfin
  exact ⟨SimpleGraph.Coloring.mk (fun z => c.col (e θ * (z : ℂ) + v)) fun {a b} hab =>
    hmot a a.2 b b.2 (G'.adj_sub hab)⟩

/-! ## FS131-K2c: children of `chiM0_le_of_fragments` (plan `plans/FS131-w2-kernel-plan.md` § 12) -/

/-- A fragment's colour regions meet the disc it covers in measurable sets (the interior points form an open set: the arcs
are locally finite and closed inside the domain, and the colour is locally constant there). -/
theorem ArcMap.measurableSet_region_inter {k : ℕ} (F : ArcMap k) {p : ℂ} {R : ℝ} (h : F.Covers p R) (j : Fin k) :
    MeasurableSet (F.region j ∩ ball p R) := by
  have _ := h
  exact (F.isOpen_region j).measurableSet.inter measurableSet_ball

/-- The arcs meeting the covered disc are finitely many (local finiteness on a compact set), each null, so the regions fill
the disc up to a null set. -/
theorem ArcMap.volume_ball_diff_region {k : ℕ} (F : ArcMap k) {p : ℂ} {R : ℝ} (h : F.Covers p R) :
    volume (ball p R \ ⋃ j, F.region j) = 0 := by
  refine measure_null_of_locally_null _ fun x hx => ?_
  have hxd : x ∈ F.dom := h (ball_subset_closedBall hx.1)
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite x hxd
  refine ⟨(ball p R \ ⋃ j, F.region j) ∩ t, inter_mem_nhdsWithin _ ht, ?_⟩
  refine measure_mono_null (t := ⋃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ t).Nonempty}, a.carrier) ?_
    ((measure_biUnion_null_iff hfin.countable).mpr fun a _ => a.volume_carrier)
  rintro y ⟨⟨hyb, hyr⟩, hyt⟩
  have hyd : y ∈ F.dom := h (ball_subset_closedBall hyb)
  have hyΓ : y ∈ ⋃ a ∈ F.arcs, a.carrier := by
    by_contra hn
    exact hyr (mem_iUnion.2 ⟨F.col y, ⟨hyd, hn⟩, rfl⟩)
  obtain ⟨a, ha, hya⟩ := mem_iUnion₂.mp hyΓ
  exact mem_iUnion₂.2 ⟨a, ⟨ha, y, hya, hyt⟩, hya⟩

/-- A valid map's regions have no unit pair (`BandFree` at `ε = 0`). -/
theorem ArcMap.bandFree_region {k : ℕ} (F : ArcMap k) (hv : F.Valid) (j : Fin k) : BandFree (F.region j) 0 := by
  intro x hx y hy
  rcases lt_trichotomy (dist x y) 1 with h | h | h
  · left; linarith
  · exact absurd ((show F.col x = j from hx.2).trans (show F.col y = j from hy.2).symm) (hv x hx.1 y hy.1 h)
  · right; linarith

/-- **Fragments at every radius fill `µ_k⁰`**: the regions on the window inscribed in the disc, periodized at side `ℓ + 2`
(`periodize`, `bandFree_periodize` at `ε = 0`, `unitPairsNull_of_bandFree`, `upperDensity_periodize`), cover density
`ℓ²/(ℓ + 2)² → 1`. -/
theorem muZero_eq_one_of_fragments {k : ℕ} (h : ∀ R > (0 : ℝ), ∃ (F : ArcMap k) (p : ℂ), F.Covers p R ∧ F.Valid) :
    muZero k = 1 := by
  refine le_antisymm (muZero_le_one k) ?_
  have key : ∀ ℓ : ℝ, 0 < ℓ → ENNReal.ofReal (ℓ ^ 2 / (ℓ + 2) ^ 2) ≤ muZero k := by
    intro ℓ hℓ
    obtain ⟨F, p, hcov, hv⟩ := h ℓ hℓ
    set z : ℂ := p - ((ℓ / 2 : ℝ) : ℂ) * (1 + I) with hz
    have hwin : squareWin z ℓ ⊆ ball p ℓ := by
      intro w ⟨h1, h2, h3, h4⟩
      simp only [hz, Complex.sub_re, Complex.sub_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re,
        Complex.ofReal_im, Complex.add_re, Complex.add_im, Complex.one_re, Complex.one_im, Complex.I_re,
        Complex.I_im] at h1 h2 h3 h4
      rw [mem_ball, dist_eq_norm]
      have hsq : ‖w - p‖ ^ 2 < ℓ ^ 2 := by
        rw [Complex.sq_norm, Complex.normSq_apply, Complex.sub_re, Complex.sub_im]
        nlinarith
      exact lt_of_pow_lt_pow_left₀ 2 hℓ.le hsq
    set T : Fin k → Set ℂ := fun j => F.region j ∩ squareWin z ℓ with hT
    have hTm : ∀ j, MeasurableSet (T j) := fun j => (F.isOpen_region j).measurableSet.inter (measurableSet_squareWin z ℓ)
    have hTw : ∀ j, T j ⊆ squareWin z ℓ := fun j => inter_subset_right
    have hTd : Pairwise (Function.onFun Disjoint T) := by
      intro j j' hjj'
      refine Set.disjoint_left.2 fun x hx hx' => hjj' ?_
      exact (show F.col x = j from hx.1.2).symm.trans (show F.col x = j' from hx'.1.2)
    set C : Fin k → Set ℂ := fun j => periodize (T j) (ℓ + 2) with hC
    have hCp : IsPartialColouring C :=
      ⟨fun j => measurableSet_periodize (hTm j) _, fun j j' hjj' => disjoint_periodize (hTw j) (hTw j') (hTd hjj')⟩
    have hCn : ∀ j, UnitPairsNull (C j) := fun j =>
      unitPairsNull_of_bandFree le_rfl (bandFree_periodize (hTw j) (by norm_num)
        fun x hx y hy => F.bandFree_region hv j x hx.1 y hy.1)
    have hUm : MeasurableSet (⋃ j, T j) := MeasurableSet.iUnion hTm
    have hvol : volume (⋃ j, T j) = ENNReal.ofReal (ℓ ^ 2) := by
      have hR : MeasurableSet (⋃ j, F.region j) := MeasurableSet.iUnion fun j => (F.isOpen_region j).measurableSet
      have e : (⋃ j, T j) = squareWin z ℓ ∩ ⋃ j, F.region j := by
        rw [hT, ← iUnion_inter, inter_comm]
      have hnull : volume (squareWin z ℓ \ ⋃ j, F.region j) = 0 :=
        measure_mono_null (sdiff_subset_sdiff_left hwin) (F.volume_ball_diff_region hcov)
      rw [e, ← volume_squareWin z hℓ.le, ← measure_inter_add_sdiff (squareWin z ℓ) hR, hnull, add_zero]
    have hd : upperDensity (⋃ j, C j) = ENNReal.ofReal (ℓ ^ 2 / (ℓ + 2) ^ 2) := by
      rw [hC, iUnion_periodize, upperDensity_periodize hUm hℓ (iUnion_subset hTw), hvol,
        ENNReal.ofReal_div_of_pos (by positivity)]
    rw [← hd]
    exact le_iSup₂ (f := fun C (_ : IsPartialColouring C ∧ ∀ j, UnitPairsNull (C j)) => upperDensity (⋃ j, C j))
      C ⟨hCp, hCn⟩
  have hlim : Tendsto (fun ℓ : ℝ => ENNReal.ofReal (ℓ ^ 2 / (ℓ + 2) ^ 2)) atTop (𝓝 1) := by
    rw [← ENNReal.ofReal_one]
    refine ENNReal.tendsto_ofReal ?_
    have h1 : Tendsto (fun ℓ : ℝ => (1 - 2 / (ℓ + 2)) ^ 2) atTop (𝓝 1) := by
      have : Tendsto (fun ℓ : ℝ => 2 / (ℓ + 2)) atTop (𝓝 0) :=
        tendsto_const_nhds.div_atTop (tendsto_atTop_add_const_right _ 2 tendsto_id)
      simpa using ((tendsto_const_nhds (x := (1 : ℝ))).sub this).pow 2
    refine h1.congr' ?_
    filter_upwards [eventually_gt_atTop 0] with ℓ hℓ
    field_simp
    ring
  exact le_of_tendsto hlim (Eventually.mono (eventually_gt_atTop (0 : ℝ)) key)

/-- **FS116-O1-YESLIM**, first clause, at every `k` (the row's `k ≥ 1` is idle: an `ArcMap 0` colours nothing): if every
radius `R > 0` has a closed disc carrying a valid `k`-coloured fragment, then `χ_m⁰(ℝ²) ≤ k`. -/
theorem chiM0_le_of_fragments {k : ℕ} (h : ∀ R > (0 : ℝ), ∃ (F : ArcMap k) (p : ℂ), F.Covers p R ∧ F.Valid) :
    chiM0 ≤ k :=
  (chiM0_le_iff_muZero_eq_one k).2 (muZero_eq_one_of_fragments h)

/-- **FS116-O1-YESLIM**, second clause: at `k = 6`, then `χ(ℝ²) ≤ 6`, with no MR. -/
theorem chromaticNumber_plane_le_six_of_fragments
    (h : ∀ R > (0 : ℝ), ∃ (F : ArcMap 6) (p : ℂ), F.Covers p R ∧ F.Valid) :
    (unitDistance ℂ).chromaticNumber ≤ 6 :=
  chromaticNumber_plane_le_chiM0.trans (by exact_mod_cast chiM0_le_of_fragments h)

end HadwigerNelson.Plane
