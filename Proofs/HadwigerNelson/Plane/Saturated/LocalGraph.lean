import Proofs.HadwigerNelson.Plane.Saturated.Pinch
import Proofs.HadwigerNelson.Plane.Saturated.Curve

/-!
# The local structure off the singular set (FS-131 wave 6: FS131-E8-LOCAL, FS131-E8-DELTA)

`plans/FS131-E8-derivation.md` §§ 3.1, 3.5 ([hand], one mind, until this module lands), at the class each argument
reads (`plans/FS131-w6-kernel-plan.md` § 11):

* **FS131-E8-DELTA** — `ae_one_colour_of_isConnected`: a connected open set meeting no essential boundary and no cusp
  is almost everywhere of one colour.
* `closure_essBdry_subset` — the closure of the essential boundary lies in the essential boundary and the cusps
  (§ 3.1 (0); FS121-V5-OFF; no saturation); `notMem_essBdry_of_mem_densitySet`. With `local_graph` these are
  FS121-V5-LOC (i), (ii).
* `IsInterfaceChart A B N y Q γ ψ h` — in the open set `Q ∋ y` the common essential boundary of `A`, `B` is the
  injective unit-speed curve `γ` of curvature at most `1` through `y`, with the two tangent unit discs at each of its
  points (normal `i e(ψ s)` into `B`) and one set on each side.
* **FS131-E8-LOCAL** — `local_graph`: for two sets on a two-colour open set `N` and an open `U ⊆ N` with no cusp of
  either, saturated at its essential boundary points, every essential boundary point of `U` has a chart inside `U`.
  This is **FS111-M-C11 (ii)** with the hypothesis "no cusp in the neighbourhood" (the deriver's erratum), and
  FS111-W-NOBEND (no corner: `γ` is `C¹`; curvature at most `1`: `ψ` is 1-Lipschitz). `AeColouring.local_graph` is
  its form at an essential boundary point of a colouring off `Σ` — FS121-V5-LOC (ii).

**The singular set is not read by `local_graph`**: its hypotheses are `TwoColourOn A B N` and "no cusp in `U`", so the
frozen centred-ball `Σ` serves (ruling, inventory item 495).

**Inhabitant.** `sq9` at `sqEdgePt`, `N = U = B(sqEdgePt, 1/8)`: `sq9_twoColourNhd`, saturated by
`sq9_tight_saturated`; that no cusp lies in the ball is owed with `local_graph`'s proof (the model of
`sq9_not_isCuspAt_near_vertex`, `Plane/Saturated/FanExamples`); the chart is the segment `s ↦ sqEdgePt + i s`.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

/-! ## FS131-E8-DELTA and the closure of the essential boundary -/

/-- A density point of a class of a colouring is no essential boundary point of the colouring. -/
theorem AeColouring.notMem_essBdry_of_mem_densitySet (c : AeColouring k) {j : Fin k} {x : ℂ}
    (hx : x ∈ densitySet (c.cls j)) : x ∉ c.essBdry := by
  sorry

/-- **FS131-E8-DELTA.** In a measurable colouring, a connected open set that meets the essential boundary of no class
and holds no cusp of any class is almost everywhere of one colour. Unit pairs and saturation are not read. -/
theorem AeColouring.ae_one_colour_of_isConnected (c : AeColouring k) {W : Set ℂ} (hW : IsOpen W)
    (hWc : IsConnected W) (hb : Disjoint W c.essBdry) (hcusp : Disjoint W (cuspSet c.cls)) :
    ∃ j, (W : Set ℂ) ≤ᵐ[volume] c.cls j := by
  sorry

/-- **The closure of the essential boundary lies in the essential boundary and the cusps** (FS131-E8 § 3.1 (0);
FS121-V5-OFF; FS121-V5-LOC (i): `cl 𝓘 ∖ Σ ⊆ 𝓘`, since the cusps lie in `Σ`). No saturation. -/
theorem AeColouring.closure_essBdry_subset (c : AeColouring k) : closure c.essBdry ⊆ c.essBdry ∪ cuspSet c.cls := by
  sorry

/-! ## The chart, and FS131-E8-LOCAL -/

/-- **A chart of the common essential boundary of `A` and `B` at `y`**: in the open set `Q ∋ y`, `Q ⊆ N`, the
essential boundary of `A` is the image of the injective unit-speed curve `γ` of curvature at most `1` on `(−h, h)`,
`γ 0 = y`; every point of it carries the two tangent unit discs with normal `i e(ψ s)` into `B`; and `Q` off the
curve is two connected open sets, one almost everywhere in `A`, the other in `B`. -/
structure IsInterfaceChart (A B N : Set ℂ) (y : ℂ) (Q : Set ℂ) (γ : ℝ → ℂ) (ψ : ℝ → ℝ) (h : ℝ) : Prop where
  /-- The half-length is positive. -/
  pos : 0 < h
  /-- The chart's domain is open. -/
  isOpen : IsOpen Q
  /-- The point lies in it. -/
  mem : y ∈ Q
  /-- It lies in the two-colour open set. -/
  subset : Q ⊆ N
  /-- The curve has unit speed and curvature at most `1`. -/
  curve : IsUnitCurve γ ψ (Ioo (-h) h)
  /-- The curve passes through `y` at `0`. -/
  zero : γ 0 = y
  /-- The curve does not meet itself. -/
  injOn : InjOn γ (Ioo (-h) h)
  /-- In `Q` the essential boundary of `A` is the curve. -/
  bdry : essBoundary A ∩ Q = γ '' Ioo (-h) h
  /-- The two tangent unit discs at every point of the curve, the normal `i e(ψ s)` into `B`. -/
  discs : ∀ s ∈ Ioo (-h) h, HasTwoDiscsAt A B N (γ s) (I * e (ψ s))
  /-- Off the curve, `Q` is two connected open sets, one almost everywhere in `A` and one in `B`. -/
  sides : ∃ Qa Qb : Set ℂ, IsOpen Qa ∧ IsOpen Qb ∧ IsConnected Qa ∧ IsConnected Qb ∧
    Q \ γ '' Ioo (-h) h = Qa ∪ Qb ∧ (Qa : Set ℂ) ≤ᵐ[volume] A ∧ (Qb : Set ℂ) ≤ᵐ[volume] B

/-- **FS131-E8-LOCAL** (FS111-M-C11 (ii) with "no cusp in the neighbourhood"; FS111-W-NOBEND), at the class its
argument reads: `A`, `B` measurable with null unit pairs on a two-colour open set `N`; `U ⊆ N` open, with no cusp of
`A` or of `B`, each essential boundary point of `U` a contact point of the set it bounds. Then every essential boundary
point `y` of `U` has a chart inside `U`. No colouring, no third class and no singular set is read; the chart's size
is not bounded below (it shrinks toward the cusps and the edge of `U`). -/
theorem local_graph {A B N : Set ℂ} (hA : MeasurableSet A) (hAn : UnitPairsNull A) (hB : MeasurableSet B)
    (hBn : UnitPairsNull B) (h : TwoColourOn A B N) {U : Set ℂ} (hU : IsOpen U) (hUN : U ⊆ N)
    (hcusp : ∀ x ∈ U, ¬ IsCuspAt A x ∧ ¬ IsCuspAt B x) (hsatA : ∀ x ∈ essBoundary A ∩ U, IsContactFor A x)
    (hsatB : ∀ x ∈ essBoundary B ∩ U, IsContactFor B x) {y : ℂ} (hy : y ∈ essBoundary A ∩ U) :
    ∃ Q γ ψ h', Q ⊆ U ∧ IsInterfaceChart A B N y Q γ ψ h' := by
  sorry

/-- **FS131-E8-LOCAL for a colouring** (FS121-V5-LOC (ii)): if the open set `U` holds no singular point and the
colouring is saturated on `U`, every essential boundary point `y` of `U` has a two-colour ball centred at it and a
chart inside `U`. -/
theorem AeColouring.local_graph (c : AeColouring k) {U : Set ℂ} (hU : IsOpen U) (hS : Disjoint U c.singularSet)
    (hsat : SaturatedOn c.cls U) {y : ℂ} (hy : y ∈ c.essBdry ∩ U) :
    ∃ ρ a b Q γ ψ h, TwoColourNhd c.cls (ball y ρ) a b ∧ Q ⊆ U ∧
      IsInterfaceChart (c.cls a) (c.cls b) (ball y ρ) y Q γ ψ h := by
  sorry

end HadwigerNelson.Plane
