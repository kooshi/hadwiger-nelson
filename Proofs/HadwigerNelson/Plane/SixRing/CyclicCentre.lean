import Proofs.HadwigerNelson.Outside.OAI158Palette
import Mathlib.Combinatorics.SimpleGraph.Acyclic
import Proofs.HadwigerNelson.Topology.LebesgueCovering

/-!
# A cyclic centre in every disc of radius above one, at every number of colours (FS-132, C132-CORES-FREE) — SKELETON

The transition graph `Γ_x` of a colouring at a point (`[OAIMath2026]` Definition 6.1) has an edge `ij` when
translation differences between the classes `i` and `j` have area of order `|h|` in every ball about `x`
(`Outside.OAI158.TransitionEdge`, for every `k`). The release defines the graph and its cyclic centres at five
labels (`CyclicCore.lean:213–218`); here they are defined for every `k`, in the same words.

`exists_cyclicCentre` is the release's cover argument (its §7.2–7.3) with the count of core discs removed: on a
closed disc with no cyclic centre every transition graph is a forest, the thresholded disc averages extend to a
continuous map into the complete graph on the labels off no core disc at all, the positive-coordinate components
are an open cover of multiplicity two and mesh `1 + o(1)`, and a square of side above `1` has no such cover
(`no_fine_cover_square`, from this library's Lebesgue covering theorem — so the radius `1` of the claim improves
to `1/√2`). **Status: skeleton; the release types this argument at five labels and at fixed radii
(`plans/FS132-kernel-plan.md` stage 3 says what is general already).**
-/

open MeasureTheory Filter Topology

namespace HadwigerNelson.SixRing

open Outside.OAI158

/-- The transition graph of a `k`-colouring at `x`: `[OAIMath2026]` Definition 6.1, and the release's
`transitionGraph` (`CyclicCore.lean:213`, there for `Fin 5`) for every `k`. -/
def transitionGraph {k : ℕ} (c : ℂ → Fin k) (x : ℂ) : SimpleGraph (Fin k) where
  Adj i j := TransitionEdge c i j x
  symm := ⟨fun i j h => by
    have hset : transitionSet c j i = transitionSet c i j := by
      funext x R h; ext q; simp only [transitionSet, Set.mem_setOf_eq, or_comm]
    have hratio : transitionRatio c j i = transitionRatio c i j := by
      funext x R h; simp only [transitionRatio, hset]
    exact ⟨h.1.symm, by rw [hratio]; exact h.2⟩⟩
  loopless := ⟨fun i h => h.1 rfl⟩

/-- A cyclic centre: a point whose transition graph contains a cycle (the release's `CyclicCore`, for every `k`). -/
def CyclicCentre {k : ℕ} (c : ℂ → Fin k) : Set ℂ := {x | ¬ (transitionGraph c x).IsAcyclic}

/-- **The cover obstruction on a square, from Lebesgue's covering theorem**: a closed square of side `s` has no
cover by open sets, no point of the square in three of them, whose traces on the square have diameter at most
`m < s`. From this library's `lebesgue_covering_square` (a set of diameter below `s` does not meet two opposite
sides) after a closed shrinking of a finite subcover. The release's `compact_open_cover_impossible`
(`PlanarCovers.lean:374`) is a disc of radius `5` and diameters at most `2`, through a degree argument. No
colouring. Inhabitant of the hypotheses other than the diameter bound: one open set containing the square. -/
theorem no_fine_cover_square {ι : Type*} (o : ℂ) {s m : ℝ} (hs : 0 < s) (hm : m < s) (U : ι → Set ℂ)
    (ho : ∀ i, IsOpen (U i)) (hcov : LebesgueCovering.closedSquare o s ⊆ ⋃ i, U i)
    (hmul : ∀ z ∈ LebesgueCovering.closedSquare o s, ∀ i j l, z ∈ U i → z ∈ U j → z ∈ U l →
      i = j ∨ i = l ∨ j = l)
    (hd : ∀ i, ∀ x ∈ U i ∩ LebesgueCovering.closedSquare o s, ∀ y ∈ U i ∩ LebesgueCovering.closedSquare o s,
      dist x y ≤ m) : False := by
  sorry

/-- **C132-CORES-FREE at the class its argument reaches (planner's finding)**: for every weak measurable
`k`-colouring of the plane, every closed square of side greater than `1` contains a cyclic centre. Inhabitant of
the hypotheses: `k = 7`, `Outside.OAI158.proper_to_borel_weak_model`. -/
theorem exists_cyclicCentre_square {k : ℕ} (hk : 1 ≤ k) {c : ℂ → Fin k} (hc : Measurable c)
    (hw : WeakColoring k c) (o : ℂ) {s : ℝ} (hs : 1 < s) :
    ∃ x ∈ LebesgueCovering.closedSquare o s, x ∈ CyclicCentre c := by
  sorry

/-- A closed disc of radius `ρ` contains a closed square of side `s` whenever `s ≤ √2 ρ`. -/
theorem closedSquare_subset_closedBall (o : ℂ) {ρ s : ℝ} (hs : 0 ≤ s) (h : s ≤ Real.sqrt 2 * ρ) :
    LebesgueCovering.closedSquare (o - ⟨s / 2, s / 2⟩) s ⊆ Metric.closedBall o ρ := by
  sorry

/-- **C132-CORES-FREE**: for every `k ≥ 1` and every weak measurable `k`-colouring of the plane, every closed disc
of radius greater than `1` contains a cyclic centre — and so does every closed disc of radius greater than `1/√2`
(`exists_cyclicCentre_square`; stated here as claimed). Inhabitant of the hypotheses: `k = 7`,
`Outside.OAI158.proper_to_borel_weak_model`. The colouring is Borel measurable, as in the release; a Lebesgue
measurable one agrees with a Borel one off a null set, and neither `WeakColoring` nor `TransitionEdge` sees a null
set. -/
theorem exists_cyclicCentre {k : ℕ} (hk : 1 ≤ k) {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c)
    (o : ℂ) {ρ : ℝ} (hρ : 1 < ρ) : ∃ x ∈ Metric.closedBall o ρ, x ∈ CyclicCentre c := by
  have h2 : (1 : ℝ) < Real.sqrt 2 := by
    have h := Real.sqrt_lt_sqrt (by norm_num : (0 : ℝ) ≤ 1) (by norm_num : (1 : ℝ) < 2)
    rwa [Real.sqrt_one] at h
  have hs : (1 : ℝ) < Real.sqrt 2 * ρ := by nlinarith
  obtain ⟨x, hx, hxc⟩ := exists_cyclicCentre_square hk hc hw (o - ⟨Real.sqrt 2 * ρ / 2, Real.sqrt 2 * ρ / 2⟩) hs
  exact ⟨x, closedSquare_subset_closedBall o (by positivity) le_rfl hx, hxc⟩

end HadwigerNelson.SixRing
