import Proofs.HadwigerNelson.Plane.Radius
import Proofs.HadwigerNelson.Outside.OAI158Collapse

/-!
# The radius clause, on the two outside theorems: every open set has a weak colouring, and five fail on a disc (FS-124)

Claims **C124-RADIUS-DOWN** and **C124-RADIUS-FIVE** of `data/fs124/claims-K1.md` (plan:
`plans/FS124-kernel-plan.md`), and what they give with `Plane/Radius`.

* `isWeakColouringOn_univ_iff_weakColoring` — **the definition at the whole plane is the import's**: a weak
  `k`-colouring of `univ` is a Borel-measurable `c` with the release's `Outside.OAI158.WeakColoring k c`, the object
  `Outside.OAI158.proper_to_borel_weak` delivers. No axiom.
* `radius_down` (C124-RADIUS-DOWN) rests on `Outside.OAI158.proper_to_borel_weak` — `[OAIMath2026]` family 158, the
  transfer of colourability — and on nothing else outside.
* `radius_five` (C124-RADIUS-FIVE) rests on `Outside.OAI158.no_proper_five_coloring` — `[OAIMath2026]` family 158, the
  plane is not five-colourable — and on nothing else outside.
* `colorable_iff_forall_ball`, `seven_le_chromaticNumber_plane_iff_exists_ball` — the join of UP and DOWN, on
  `proper_to_borel_weak`: the plane is `k`-colourable exactly when every disc about `0` has a weak `k`-colouring, so
  seven colours are needed exactly when one disc has no weak six-colouring.
* `exists_radius_no_weak_four` — C124-RADIUS-FIVE's sentence at four colours, with no import (rung B).

**Inhabitants.** `radius_down`'s hypothesis holds at `k = 7` (`Outside.OAI158.exists_properColoring_seven`), where
its conclusion is `exists_isWeakColouringOn_seven`, with no axiom. `radius_five` has no hypothesis.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Metric HadwigerNelson

variable {k : ℕ}

/-! ## The definition at the whole plane is the import's -/

/-- **At the whole plane, a weak colouring is the import's Borel weak colouring**: `IsWeakColouringOn univ c` exactly
when `c` is measurable and a `WeakColoring` in the release's sense (`Outside.OAI158.weakColoring_iff_unitPairsNull`).
The release's `WeakColoring` asks `AEMeasurable c volume`; this library's notion asks `Measurable c`, as its
`AeColouring` does and as `Outside.OAI158.proper_to_borel_weak` delivers. No axiom. -/
theorem isWeakColouringOn_univ_iff_weakColoring {c : ℂ → Fin k} :
    IsWeakColouringOn univ c ↔ Measurable c ∧ Outside.OAI158.WeakColoring k c := by
  rw [isWeakColouringOn_univ_iff]
  exact and_congr_right fun hm => (Outside.OAI158.weakColoring_iff_unitPairsNull hm).symm

/-- The weak `k`-colourings of the whole plane exist exactly when the release's Borel weak `k`-colourings do, and
exactly when this library's `AeColouring k` is inhabited. No axiom. -/
theorem exists_isWeakColouringOn_univ_iff :
    (∃ c : ℂ → Fin k, IsWeakColouringOn univ c) ↔ Nonempty (AeColouring k) := by
  constructor
  · rintro ⟨c, hc⟩
    obtain ⟨a, -⟩ := hc.exists_aeColouring
    exact ⟨a⟩
  · rintro ⟨a⟩
    exact ⟨a.col, a.isWeakColouringOn univ⟩

/-! ## C124-RADIUS-DOWN -/

/-- **One colouring for every set**: a proper `k`-colouring of the plane gives a measurable `k`-colouring that is a
weak colouring of every set of the plane. Rests on the standard three axioms and
`Outside.OAI158.proper_to_borel_weak` (`[OAIMath2026]` family 158). Inhabitant of the hypothesis: `k = 7`
(`Outside.OAI158.exists_properColoring_seven`), where the conclusion is `exists_isWeakColouringOn_seven`. -/
theorem exists_isWeakColouringOn_of_colorable (h : (unitDistance ℂ).Colorable k) :
    ∃ c : ℂ → Fin k, ∀ U : Set ℂ, IsWeakColouringOn U c := by
  obtain ⟨a⟩ := Outside.OAI158.nonempty_aeColouring_of_colorable h
  exact ⟨a.col, a.isWeakColouringOn⟩

/-- **C124-RADIUS-DOWN** (`data/fs124/claims-K1.md`): "For every integer k ≥ 1: if χ(ℝ²) ≤ k, every open set of the
plane has a weak measurable k-colouring."

Rests on the standard three axioms and the declared outside theorem `Outside.OAI158.proper_to_borel_weak`
(`[OAIMath2026]` family 158: a proper `k`-colouring of the plane gives a Borel one proper at almost every unit pair).
`χ(ℝ²)` is `(unitDistance ℂ).chromaticNumber`. Openness of `U` is the claim's word and is not used: the colouring of
`exists_isWeakColouringOn_of_colorable` serves every set. `k ≥ 1` is not a hypothesis: `χ(ℝ²) ≤ 0` is false.
Inhabitant of the hypothesis: `k = 7` (`chromaticNumber_plane_interval`), where the conclusion holds with no axiom
(`exists_isWeakColouringOn_seven`). -/
theorem radius_down (h : (unitDistance ℂ).chromaticNumber ≤ k) :
    ∀ U : Set ℂ, IsOpen U → ∃ c : ℂ → Fin k, IsWeakColouringOn U c := by
  obtain ⟨c, hc⟩ := exists_isWeakColouringOn_of_colorable (SimpleGraph.chromaticNumber_le_iff_colorable.mp h)
  exact fun U _ => ⟨c, hc U⟩

/-! ## C124-RADIUS-FIVE -/

/-- **C124-RADIUS-FIVE** (`data/fs124/claims-K1.md`): "There is R > 0 such that no open disc of radius R has a weak
measurable five-colouring."

Rests on the standard three axioms and the declared outside theorem `Outside.OAI158.no_proper_five_coloring`
(`[OAIMath2026]` family 158: no map `ℂ → Fin 5` separates every unit pair), through
`colorable_plane_of_forall_aeProperOn_ball`. The radius is not exhibited: it is the radius of a disc holding a finite
unit-distance graph with no five-colouring, which exists by de Bruijn–Erdős. The statement has no hypothesis; its
sentence at four colours is `exists_radius_no_weak_four`, with no import, and at seven it is false
(`exists_isWeakColouringOn_seven`). -/
theorem radius_five : ∃ R > (0 : ℝ), ∀ p : ℂ, ¬ ∃ c : ℂ → Fin 5, IsWeakColouringOn (ball p R) c := by
  obtain ⟨R, hR, hRp⟩ := exists_radius_of_not_colorable Outside.OAI158.not_colorable_five
  exact ⟨R, hR, fun p ⟨c, hc⟩ => hRp p c hc.aeProperOn⟩

/-- C124-RADIUS-FIVE's sentence at four colours, on the standard three axioms: some radius has no disc with a weak
measurable four-colouring (`isEmpty_coloring_plane_four`, rung B, through
`colorable_plane_of_forall_aeProperOn_ball`). -/
theorem exists_radius_no_weak_four : ∃ R > (0 : ℝ), ∀ p : ℂ, ¬ ∃ c : ℂ → Fin 4, IsWeakColouringOn (ball p R) c := by
  have h4 : ¬ (unitDistance ℂ).Colorable 4 := fun ⟨C⟩ => isEmpty_coloring_plane_four.false C
  obtain ⟨R, hR, hRp⟩ := exists_radius_of_not_colorable h4
  exact ⟨R, hR, fun p ⟨c, hc⟩ => hRp p c hc.aeProperOn⟩

/-! ## The join: the problem on discs -/

/-- **The plane is `k`-colourable exactly when every disc about the origin has a weak `k`-colouring.**

Which half needs the import: `→` (a colourable plane gives every disc a weak colouring) is C124-RADIUS-DOWN,
`radius_down`, and rests on the declared outside theorem `Outside.OAI158.proper_to_borel_weak` (`[OAIMath2026]`
family 158); `←` (weak colourings of every disc colour the plane) is C124-RADIUS-UP, `radius_up`, and rests on the
standard three axioms alone. Inhabitant of either side: `k = 7`. -/
theorem colorable_iff_forall_ball :
    (unitDistance ℂ).Colorable k ↔ ∀ R > (0 : ℝ), ∃ c : ℂ → Fin k, IsWeakColouringOn (ball (0 : ℂ) R) c := by
  constructor
  · -- C124-RADIUS-DOWN: the half on the declared outside theorem
    exact fun h R _ => radius_down (SimpleGraph.chromaticNumber_le_iff_colorable.mpr h) _ isOpen_ball
  · -- C124-RADIUS-UP: no import
    exact fun h => SimpleGraph.chromaticNumber_le_iff_colorable.mp (radius_up h).2

/-- **Seven means one disc has no weak six-colouring; six means every disc has one**: `7 ≤ χ(ℝ²)` exactly when some
open disc about the origin has no weak measurable six-colouring. With `χ(ℝ²) ≤ 7` (`chromaticNumber_plane_interval`)
the left side is `χ(ℝ²) = 7`.

Which half needs the import: `→` (if the plane needs seven colours, some disc has no weak six-colouring) is the
contrapositive of C124-RADIUS-UP — `exists_radius_of_not_colorable` at `k = 6` — and rests on the standard three
axioms alone; `←` (**a disc with no weak six-colouring proves seven**) is the contrapositive of C124-RADIUS-DOWN and
rests on the declared outside theorem `Outside.OAI158.proper_to_borel_weak` (`[OAIMath2026]` family 158).
`Outside.OAI158.no_proper_five_coloring` is not used. It has no hypothesis, so no model is asked. -/
theorem seven_le_chromaticNumber_plane_iff_exists_ball :
    7 ≤ (unitDistance ℂ).chromaticNumber ↔
      ∃ R > (0 : ℝ), ¬ ∃ c : ℂ → Fin 6, IsWeakColouringOn (ball (0 : ℂ) R) c := by
  have h7 : (7 : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber ↔ ¬ (unitDistance ℂ).Colorable 6 :=
    add_one_le_chromaticNumber_iff_not_colorable (G := unitDistance ℂ) (n := 6)
  rw [h7]
  constructor
  · -- the contrapositive of C124-RADIUS-UP: no import
    intro h
    obtain ⟨R, hR, hRp⟩ := exists_radius_of_not_colorable h
    exact ⟨R, hR, fun ⟨c, hc⟩ => hRp 0 c hc.aeProperOn⟩
  · -- the contrapositive of C124-RADIUS-DOWN: the half on the declared outside theorem
    rintro ⟨R, -, hR⟩ hcol
    exact hR (radius_down (SimpleGraph.chromaticNumber_le_iff_colorable.mpr hcol) _ isOpen_ball)

/-! ## Spec examples -/

/-- **Adversary**: C124-RADIUS-FIVE's sentence at seven colours is false — every disc has a weak seven-colouring. -/
example : ¬ ∃ R > (0 : ℝ), ∀ p : ℂ, ¬ ∃ c : ℂ → Fin 7, IsWeakColouringOn (ball p R) c := by
  rintro ⟨R, -, h⟩
  obtain ⟨c, hc⟩ := exists_isWeakColouringOn_seven
  exact h 0 ⟨c, hc _⟩

/-- C124-RADIUS-DOWN run on its inhabitant: the plane is seven-colourable, so the unit disc has a weak
seven-colouring. -/
example : ∃ c : ℂ → Fin 7, IsWeakColouringOn (ball (0 : ℂ) 1) c := by
  refine radius_down ?_ _ isOpen_ball
  rw [← chromaticNumber_plane_eq_complex]
  exact chromaticNumber_plane_interval.2

end HadwigerNelson.Plane
