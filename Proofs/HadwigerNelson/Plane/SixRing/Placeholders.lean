import Proofs.HadwigerNelson.Plane.SixRing.Confine

/-!
# The release's statements the six-ring modules stand on (FS-132) — PLACEHOLDERS, to be deleted at the port's join

Three statements of `[OAIMath2026]` family 158, **each stated exactly as the release states it, binder for binder**
(commit `adc7f124` of the clone; the section variables `{k : ℕ} (c : ℂ → Fin k) (hc : Measurable c)` written out),
over this library's copies of the release's definitions (`Outside/OAI158Palette`). Each is a `sorry` here. The port
(job FS132-I2, branch `fs132-wi2`) proves the same statements under the same short names in the namespace
`HadwigerNelson.Outside.OAI158`; the modules that use them open that namespace, and inside
`HadwigerNelson.SixRing` a name of this namespace is found first — so **at the join this file is deleted, its
importers import the ported modules instead, and no leaf changes**.

`mem_spatialSupport_ae` (four lines in the release) is proved here by the release's own proof, for the same reason
and with the same fate.

Two statements the first skeleton also held, `outer_strip_trace` and `inner_strip_trace`, are dropped: the
exclusion's route does not use them (`plans/FS132-kernel-plan.md` § 3.3).
-/

open MeasureTheory

namespace HadwigerNelson.SixRing

open Outside.OAI158

/-- **OUTSIDE (placeholder)** — `[OAIMath2026]` `PaletteDensity.lean:143`, `palette_transfer_pair` (the manuscript's
Lemma 5.2 (1)): at a fixed centre, for almost every pair of directions, the colour at the sum avoids both palettes.
For a colouring of the whole plane, every number of labels. -/
theorem palette_transfer_pair {k : ℕ} (c : ℂ → Fin k) (hc : Measurable c) (hw : WeakColoring k c) (x : ℂ) :
    ∀ᵐ p ∂angularMeasure.prod angularMeasure,
      c (angularSum x 1 p) ∉ palette c hc x p.1 ∪ palette c hc x p.2 := by
  sorry

/-- **OUTSIDE (placeholder)** — `[OAIMath2026]` `PaletteTransport.lean:450`, `palette_sixty_disjoint` (Corollary
5.3): the palettes at `f` and at `f` rotated by `π/3` are disjoint, for almost every `f`. For a colouring of the whole
plane, every number of labels. -/
theorem palette_sixty_disjoint {k : ℕ} (c : ℂ → Fin k) (hc : Measurable c) (hw : WeakColoring k c) (x : ℂ) :
    ∀ᵐ f ∂angularMeasure, Disjoint (palette c hc x f) (palette c hc x (f + (sixty : Angles))) := by
  sorry

/-- **OUTSIDE (placeholder)** — `[OAIMath2026]` `States.lean:243`, `two_state_impossible` (the manuscript's Lemma
6.4, there at five labels for a singleton and a pair; in the release's Lean for every `k` and any two label sets whose
complement has at most two labels): no measurable two-valued state, representing `J` and `K` inside the palette,
flips under the rotation by `π/3`. -/
theorem two_state_impossible {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c)
    (x : ℂ) (J K : Finset (Fin k)) (hcard : (Finset.univ \ (J ∪ K)).card ≤ 2)
    (s : Angles → Bool) (hs : Measurable s)
    (hJ : RealState hc x {t : ℝ | s (t : Angles) = false} J)
    (hK : RealState hc x {t : ℝ | s (t : Angles) = true} K)
    (hflip : ∀ᵐ t ∂angularMeasure, s (t + (Real.pi / 3 : ℝ)) = !(s t)) : False := by
  sorry

/-- `[OAIMath2026]` `AngularBoundary.lean:309`, `mem_spatialSupport_ae`, with its proof: almost every point of the
class of `i` lies in the closed essential support of that class. -/
theorem mem_spatialSupport_ae {k : ℕ} (c : ℂ → Fin k) (hc : Measurable c) (i : Fin k) :
    ∀ᵐ z : ℂ ∂volume, c z = i → z ∈ spatialSupport c i :=
  (ae_restrict_iff' (measurableSet_eq_fun hc measurable_const)).mp
    (volume.restrict {z | c z = i}).support_mem_ae

end HadwigerNelson.SixRing
