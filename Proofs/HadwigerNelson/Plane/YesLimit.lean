import Proofs.HadwigerNelson.Plane.Slack
import Proofs.HadwigerNelson.Plane.ArcMap
import Proofs.HadwigerNelson.UnitDistance

/-!
# Valid fragments on discs of every radius bound `χ_m⁰`, and N-EASY (FS-131 wave 2)

Row: **FS116-O1-YESLIM** (carrying FS129-SR2-YESLIM-EQ: its first clause is FS106-EQ's (c) ⟹ (a) composed with Lemma P;
moved from wave 3 by ruling 6). Supporting lemma **N-EASY** (row 130's free half, `χ(ℝ²) ≤ χ_m⁰(ℝ²)`, no MR; FS-103;
`[GwynStavrianos2022]` Lemma 2, Thm 2), formalized here. Plan: `plans/FS131-w2-kernel-plan.md` § 4.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric HadwigerNelson

/-- **N-EASY**: `χ(ℝ²) ≤ χ_m⁰(ℝ²)` — a measurable colouring proper at almost every unit pair, moved by an almost-every
rigid motion, colours each finite unit-distance graph properly; de Bruijn–Erdős finishes. -/
theorem chromaticNumber_plane_le_chiM0 : (unitDistance ℂ).chromaticNumber ≤ chiM0 := by
  sorry

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
