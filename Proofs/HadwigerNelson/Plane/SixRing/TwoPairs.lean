import Proofs.HadwigerNelson.Plane.SixRing.Excl

/-!
# The ring is not two disjoint pairs alternating (FS-132, C132-DIAG-WIDE) — the release's theorem, read at six

For a weak measurable colouring of **the whole plane**. `no_alternating_groups` is the release's
`two_state_impossible` (`[OAIMath2026]` `States.lean:243`, every number of labels) reworded from its `RealState`
form on `ℝ` to a statement almost everywhere on the circle of angles (proved here from that statement and
`ae_real_of_ae_angles`); `no_alternating_pairs` is its instance at six
labels and two disjoint pairs — C132-DIAG-WIDE at `U = ℂ`. Not a result of this milestone: a corollary of the
release's Lean (`plans/FS132-derivation.md` § 1).
-/

open MeasureTheory

namespace HadwigerNelson.SixRing

open Outside.OAI158

/-- **C132-DIAG-WIDE at its class**: for every number of labels `k` and any two label sets `J`, `K` whose complement
has at most two labels, no measurable `w` from the circle to `{J, K}` has `w(e)` inside the palette and
`w(Re) ≠ w(e)` almost everywhere. The release's `two_state_impossible` in palette form. Where the hypotheses can
hold: nowhere, by this theorem, when `WeakColoring k c` does (`k = 7`: `proper_to_borel_weak_model`); with three or
more labels outside `J ∪ K` the statement is not claimed. -/
theorem no_alternating_groups {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ)
    {J K : Finset (Fin k)} (hcard : (Finset.univ \ (J ∪ K)).card ≤ 2)
    (w : Angles → Bool) (hwm : Measurable w)
    (hsub : ∀ᵐ t ∂angularMeasure, (if w t then K else J) ⊆ palette c hc p t)
    (halt : ∀ᵐ t ∂angularMeasure, w (t + (sixty : Angles)) ≠ w t) : False := by
  have hreal := ae_real_of_ae_angles hsub
  have hmk : Measurable fun t : ℝ => w (t : Angles) := hwm.comp AddCircle.measurable_mk'
  refine two_state_impossible hc hw p J K hcard w hwm
    ⟨hmk (measurableSet_singleton false), fun i hi => ?_⟩
    ⟨hmk (measurableSet_singleton true), fun i hi => ?_⟩ ?_
  · filter_upwards [hreal] with θ hθ hθf
    have hθf' : w (θ : Angles) = false := hθf
    simp only [hθf', Bool.false_eq_true, if_false] at hθ
    exact (mem_palette c hc p _ i).mp (hθ hi)
  · filter_upwards [hreal] with θ hθ hθt
    have hθt' : w (θ : Angles) = true := hθt
    simp only [hθt', if_true] at hθ
    exact (mem_palette c hc p _ i).mp (hθ hi)
  · filter_upwards [halt] with t ht
    have h60 : ((Real.pi / 3 : ℝ) : Angles) = (sixty : Angles) := rfl
    rw [h60]
    cases h1 : w (t + (sixty : Angles)) <;> cases h2 : w t <;> simp_all

/-- **C132-DIAG-WIDE** (the instance `U = ℂ`, **the whole plane**): for a weak measurable six-colouring of the
plane, a centre `p` and two disjoint pairs of labels `D`, `D'`, there is no measurable map `w` from the circle to
`{D, D'}` (`false ↦ D`, `true ↦ D'`) with `w(e) ⊆ P_p(e)` and `w(Re) ≠ w(e)` for almost every direction. Whether a
weak six-colouring of the plane exists is the open question (`χ(ℝ²) = 6` or `7`); at `k = 7`
(`proper_to_borel_weak_model`) two disjoint pairs leave three labels outside and the statement is not claimed. -/
theorem no_alternating_pairs {c : ℂ → Fin 6} (hc : Measurable c) (hw : WeakColoring 6 c) (p : ℂ)
    {D D' : Finset (Fin 6)} (hD : D.card = 2) (hD' : D'.card = 2) (hdisj : Disjoint D D')
    (w : Angles → Bool) (hwm : Measurable w)
    (hsub : ∀ᵐ t ∂angularMeasure, (if w t then D' else D) ⊆ palette c hc p t)
    (halt : ∀ᵐ t ∂angularMeasure, w (t + (sixty : Angles)) ≠ w t) : False := by
  refine no_alternating_groups hc hw p (J := D) (K := D') ?_ w hwm hsub halt
  have h1 : (D ∪ D').card = 4 := by rw [Finset.card_union_of_disjoint hdisj, hD, hD']
  have h2 : (Finset.univ \ (D ∪ D')).card = 6 - 4 := by
    rw [Finset.card_sdiff_of_subset (Finset.subset_univ _), Finset.card_univ, Fintype.card_fin, h1]
  omega

end HadwigerNelson.SixRing
