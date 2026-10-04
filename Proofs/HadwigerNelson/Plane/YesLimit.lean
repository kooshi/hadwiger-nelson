import Proofs.HadwigerNelson.Plane.Slack
import Proofs.HadwigerNelson.Plane.ArcMap
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
      have := eq_norm_mul_e_arg (w - u)
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

/-- **FS116-O1-YESLIM**, first clause, at every `k` (the row's `k ≥ 1` is idle: an `ArcMap 0` colours nothing): if every
radius `R > 0` has a closed disc carrying a valid `k`-coloured fragment, then `χ_m⁰(ℝ²) ≤ k`. -/
theorem chiM0_le_of_fragments {k : ℕ} (h : ∀ R > (0 : ℝ), ∃ (F : ArcMap k) (p : ℂ), F.Covers p R ∧ F.Valid) :
    chiM0 ≤ k := by
  sorry

/-- **FS116-O1-YESLIM**, second clause: at `k = 6`, then `χ(ℝ²) ≤ 6`, with no MR. -/
theorem chromaticNumber_plane_le_six_of_fragments
    (h : ∀ R > (0 : ℝ), ∃ (F : ArcMap 6) (p : ℂ), F.Covers p R ∧ F.Valid) :
    (unitDistance ℂ).chromaticNumber ≤ 6 :=
  chromaticNumber_plane_le_chiM0.trans (by exact_mod_cast chiM0_le_of_fragments h)

end HadwigerNelson.Plane
