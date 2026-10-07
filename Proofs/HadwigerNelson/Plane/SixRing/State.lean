import Proofs.HadwigerNelson.Plane.SixRing.ChartMeasure
import Proofs.HadwigerNelson.Plane.SixRing.StepLemma
import Proofs.HadwigerNelson.Outside.OAI158PaletteTransport

/-!
# The state of an orbit and what it forces near a hub (FS-132, C132-M-ORBIT steps M1, M2, M3) — SKELETON

The palette side of the exclusion. For a weak colouring `c` of **the whole plane** with any number of labels, a
centre `p`, and two labels `X`, `Y` satisfying the ring hypothesis `OutsideOrbit c hc p X Y ψ δ`, the *state* is the
set `liftPalette c hc p X` of real angles whose palette holds `X`. Near the six directions it is the complement of
the set for `Y` (M1), it flips under the rotation by `π/3` (M1), it changes at every direction of the orbit (M1),
and the colour at a chart point avoids the labels its two ring points name (M2, the derivation's (⋆)). Hence every
hub has a tip other than `X`, `Y` (M3), and where the other labels do not tip, the colouring is as `HubColours`
says.

Stands on the release's `palette_sixty_disjoint` (in its real-line form `palette_sixty_real`) and
`palette_transfer_pair`, ported in `Outside/OAI158PaletteTransport` and `Outside/OAI158PaletteDensity` (FS132-I2).
`plans/FS132-kernel-plan.md` stage 5 has the plan per leaf.
-/

open MeasureTheory Set

namespace HadwigerNelson.SixRing

open Outside.OAI158 Real

variable {k : ℕ} {c : ℂ → Fin k} {hc : Measurable c} {p : ℂ} {X Y : Fin k} {ψ δ : ℝ}

/-- An angle is in the lifted palette set of a label exactly when its palette holds the label. -/
theorem mem_liftPalette (c : ℂ → Fin k) (hc : Measurable c) (p : ℂ) (i : Fin k) (θ : ℝ) :
    θ ∈ liftPalette c hc p i ↔ i ∈ palette c hc p (θ : Angles) :=
  (mem_palette c hc p (θ : Angles) i).symm

/-- The state is a measurable set of real angles ("`s` is taken Borel (it is: `paletteSet` is measurable)",
`plans/FS132-kernel-plan.md` § 3.2). -/
theorem measurableSet_liftPalette (c : ℂ → Fin k) (hc : Measurable c) (p : ℂ) (i : Fin k) :
    MeasurableSet (liftPalette c hc p i) := by
  sorry

/-- **M1, "each holds exactly one"**: near each direction of the orbit, for almost every angle, the palette holds
`Y` exactly when it does not hold `X`. From clause (i) at two consecutive directions and `palette_sixty_disjoint`. -/
theorem OutsideOrbit.ae_iff_not (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ) :
    ∀ᵐ θ : ℝ, |θ - ψ - n * (π / 3)| < δ → (θ ∈ liftPalette c hc p Y ↔ θ ∉ liftPalette c hc p X) := by
  sorry

/-- **M1, "`s(θ + π/3) ≠ s(θ)`"**: near each direction of the orbit, for almost every angle `θ`, the palette at
`θ + π/3` holds `X` exactly when the palette at `θ` does not. -/
theorem OutsideOrbit.ae_flip (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ) :
    ∀ᵐ θ : ℝ, |θ - ψ - n * (π / 3)| < δ →
      (θ + π / 3 ∈ liftPalette c hc p X ↔ θ ∉ liftPalette c hc p X) := by
  sorry

/-- **M1, "each `ψ_k` is an essential change point"**: every neighbourhood of every direction `ψ + mπ/3` of the
orbit meets the state and its complement in positive measure. From clause (ii) at `ψ` and the flip. -/
theorem OutsideOrbit.change_at (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (m : ℤ) :
    ∀ η : ℝ, 0 < η →
      0 < volume (liftPalette c hc p X ∩ Ioo (ψ + (m : ℝ) * (π / 3) - η) (ψ + (m : ℝ) * (π / 3) + η)) ∧
      0 < volume ((liftPalette c hc p X)ᶜ ∩ Ioo (ψ + (m : ℝ) * (π / 3) - η) (ψ + (m : ℝ) * (π / 3) + η)) := by
  sorry

/-- **M2, (⋆)** ("for almost every `(α, d)` with `Z(α, d) ∈ N_k(κ)`: `c(Z(α, d)) ∉ {s(α), s(α − d)}`", for
`κ ≤ δ/2`), with the state as a set: for almost every `(α, d)` with `|α − ψ_{n+1}| < δ/2` and `|d| < δ/2`, the colour
at `chart p α d` is not `X` if `α` or `α − d` is in the state, and not `Y` if `α` or `α − d` is outside it. From
`palette_transfer_pair` at the pair of directions `(α, α − 2π/3 − d)` and M1 (the state at `α − 2π/3 − d` is the
state at `α − d`). -/
theorem OutsideOrbit.chart_avoids (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ) :
    ∀ᵐ x : ℝ × ℝ, |x.1 - (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3))| < δ / 2 → |x.2| < δ / 2 →
      (x.1 ∈ liftPalette c hc p X ∨ x.1 - x.2 ∈ liftPalette c hc p X → c (chart p x.1 x.2) ≠ X) ∧
      (x.1 ∉ liftPalette c hc p X ∨ x.1 - x.2 ∉ liftPalette c hc p X → c (chart p x.1 x.2) ≠ Y) := by
  sorry

/-- **M3, every hub has a tip** ("So some inner label has positive measure in `W_k(κ)` for every `κ`. … `Tip(k)` …
is non-empty"): under the ring hypothesis, at every hub some label other than `X` and `Y` tips. For any number of
labels: that the tip is one of the cycle's four is where six is spent (`exists_cycle_label`).

A step inside a proof by contradiction at six labels (`no_outside_orbit_points` refutes the hypotheses given a
four-cycle of exclusions); the remark on models at `OutsideOrbit` applies. -/
theorem exists_tip (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ) :
    ∃ i, i ≠ X ∧ i ≠ Y ∧ IsTip c p (hub p ψ n) i := by
  sorry

/-- **M5's last sentence with (⋆), at the hub `y_n`** ("almost every point of `B(0, 1) ∩ N_k(κ_*)` carries
`a_{τ(k)}`, `X` or `Y`"): if no label other than `b`, `X`, `Y` tips the hub `y_n`, then on some box about
`(ψ_{n+1}, 0)` the colouring is as `HubColours` says, for the state. From `chart_avoids` and
`ae_ne_of_not_isTip`. -/
theorem OutsideOrbit.hubColours (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ) {b : Fin k}
    (hnt : ∀ i, i ≠ b → i ≠ X → i ≠ Y → ¬ IsTip c p (hub p ψ n) i) :
    ∃ κ : ℝ, 0 < κ ∧
      HubColours c p b X Y (liftPalette c hc p X) (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3)) κ := by
  sorry

/-- **The same at the next hub `y_{n+1}`, read through the flip** (M7's "the second line shifts both arguments by
`−π/3`, which flips both values"): the chart is centred at `ψ_{n+1} + π/3`, and an angle `θ` there is in the state
exactly when `θ − π/3` is not. -/
theorem OutsideOrbit.hubColours_flip (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ)
    {b : Fin k} (hnt : ∀ i, i ≠ b → i ≠ X → i ≠ Y → ¬ IsTip c p (hub p ψ (n + 1)) i) :
    ∃ κ : ℝ, 0 < κ ∧
      HubColours c p b X Y {θ : ℝ | θ - π / 3 ∉ liftPalette c hc p X}
        (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3) + π / 3) κ := by
  sorry

end HadwigerNelson.SixRing
