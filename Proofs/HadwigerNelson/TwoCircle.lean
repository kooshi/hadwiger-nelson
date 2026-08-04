import Proofs.HadwigerNelson.UnitDistance
import Mathlib.Analysis.Complex.Basic
import Mathlib.Data.ZMod.Basic

/-!
# The two-circle theorem (M19)

**Every unit-distance graph whose vertices lie on the two circles of radius `1` and `1/√3`
about a common point is 3-colourable.**

This is the local ceiling that explains M18's flat measurement: at a 120°-class pivot `p`,
the whole cover set `N(p) ∪ C` lives on these two circles, so no gadget placed inside the
cover set can ever force a fourth colour there — the rainbow floor (`minCov = 3`, measured
at all 4,615 + 1,558 pivots) is not an accident of our constructions but a theorem of the
geometry. The boundary of the barrier is stated with the same care: a fourth colour is *not*
excluded — it must be forced from outside the two circles, by structure that restricts which
3-colourings extend. That question is M20's.

## The shape of the proof

Work multiplicatively on the unit circle of ℂ. Unit chords on the radius-1 circle subtend
exactly 60°, so their endpoint ratio is `zeta6^{±1}`; unit chords on the radius-`1/√3`
circle subtend exactly 120° (`zeta6^{±2}` — the ℤ/3 triangles); cross chords have ratio
`seam^{±1}` where `seam = (√3 + i·√33)/6` — the √33 family's true geometric identity.
`seam` has **infinite order** (its trace `√3/3` squares to `1/3`, which is no integer, so
`seam` is no root of unity) — hence every point of a `⟨zeta6, seam⟩`-orbit carries a unique
label `(i, j) ∈ ℤ/6 × ℤ`, the only unit edges are four label steps, and the explicit
colouring `e = [1,2,0,2,1,0]` / `o = [0,0,1,1,2,2]` (outer/inner circle, `j`-independent)
is proper on all four. Verified numerically on a 324-point instance before formalizing
(`plans/M19-coverage-driven-construction.md` §0(e)).
-/

namespace HadwigerNelson
namespace TwoCircle

open Complex

/-- `e^{iπ/3}`: the ratio between endpoints of a unit chord of the unit circle. -/
noncomputable def zeta6 : ℂ := ⟨1 / 2, Real.sqrt 3 / 2⟩

/-- `(√3 + i·√33)/6`: the ratio (inner point over outer point, as unit-circle phases) across
a unit cross-chord between the circles of radius `1/√3` and `1`. Its real part `√3/6` is the
cross-chord's cosine; its imaginary part carries the `√33` that M17's resistance histogram
kept surfacing — the seam was geometry, not colour forcing. -/
noncomputable def seam : ℂ := ⟨Real.sqrt 3 / 6, Real.sqrt 33 / 6⟩

theorem norm_zeta6 : ‖zeta6‖ = 1 := sorry

theorem norm_seam : ‖seam‖ = 1 := sorry

theorem zeta6_ne_zero : zeta6 ≠ 0 := sorry

theorem seam_ne_zero : seam ≠ 0 := sorry

theorem zeta6_pow_six : zeta6 ^ 6 = 1 := sorry

/-- The order of `zeta6` is exactly 6: `zeta6^i = 1` iff `6 ∣ i`. -/
theorem zeta6_zpow_eq_one_iff {i : ℤ} : zeta6 ^ i = 1 ↔ (6 : ℤ) ∣ i := sorry

/-- **The infinite-order lemma.** `seam` is no root of unity: were `seam^n = 1`, `seam` and
its conjugate `seam⁻¹` would be algebraic integers, hence so would their sum `√3/3`, hence
so would its square `1/3` — a rational algebraic integer that is not an integer. This is
the fact that makes the `(i, j)` labels unique, and it is the exact reason the two-circle
graph is a strip `ℤ/6 × ℤ` and not a torus. -/
theorem seam_pow_ne_one (n : ℕ) (hn : n ≠ 0) : seam ^ n ≠ 1 := sorry

theorem seam_zpow_eq_one_iff {j : ℤ} : seam ^ j = 1 ↔ j = 0 := sorry

/-! ### The three chord classifications

Everything is componentwise algebra on `re`/`im` — no angles, no `arccos`, in the style of
M18's `ClassGeometry` engine. Each says: the metric hypothesis pins the ratio to one of two
named constants. -/

/-- A unit chord of the unit circle: the endpoint ratio is `zeta6` or its inverse. -/
theorem ratio_of_unit_chord {w w' : ℂ} (hw : ‖w‖ = 1) (hw' : ‖w'‖ = 1)
    (h : ‖w' - w‖ = 1) : w' = zeta6 * w ∨ w' = zeta6⁻¹ * w := sorry

/-- A chord of length `√3` of the unit circle (the inner circle's unit chords, rescaled):
the ratio is `zeta6^2` or its inverse — the 120° step of the ℤ/3 triangles. -/
theorem ratio_of_sqrt3_chord {v v' : ℂ} (hv : ‖v‖ = 1) (hv' : ‖v'‖ = 1)
    (h : ‖v' - v‖ = Real.sqrt 3) : v' = zeta6 ^ 2 * v ∨ v' = (zeta6 ^ 2)⁻¹ * v := sorry

/-- A unit cross-chord between the circles: `w` on the unit circle, `v/√3` on the inner
circle, at distance 1 — the phase ratio is `seam` or its inverse. -/
theorem ratio_of_cross_chord {w v : ℂ} (hw : ‖w‖ = 1) (hv : ‖v‖ = 1)
    (h : ‖(Real.sqrt 3 : ℂ)⁻¹ * v - w‖ = 1) : v = seam * w ∨ v = seam⁻¹ * w := sorry

/-! ### Labels -/

/-- Two phases in one `⟨zeta6, seam⟩`-orbit. The group is abelian, so membership is exactly
a two-exponent normal form — no word problem. -/
def SameOrbit (x y : ℂ) : Prop := ∃ i j : ℤ, y = zeta6 ^ i * seam ^ j * x

theorem SameOrbit.refl (x : ℂ) : SameOrbit x x := sorry
theorem SameOrbit.symm {x y : ℂ} : SameOrbit x y → SameOrbit y x := sorry
theorem SameOrbit.trans {x y z : ℂ} : SameOrbit x y → SameOrbit y z → SameOrbit x z := sorry

/-- **Label uniqueness**: the exponent pair of an orbit element is unique up to the order of
`zeta6` — `j` on the nose, `i` mod 6. Rides entirely on `seam_pow_ne_one`. -/
theorem label_unique {i i' j j' : ℤ}
    (h : zeta6 ^ i * seam ^ j = zeta6 ^ i' * seam ^ j') :
    j = j' ∧ (i : ZMod 6) = (i' : ZMod 6) := sorry

/-! ### The strip colouring -/

/-- Colour table for the outer (radius-1) circle. `j`-independent by design: any wrap in `j`
that irrationality cannot forbid still respects it. -/
def eTable : ZMod 6 → Fin 3 := ![1, 2, 0, 2, 1, 0]

/-- Colour table for the inner (radius-`1/√3`) circle. -/
def oTable : ZMod 6 → Fin 3 := ![0, 0, 1, 1, 2, 2]

/-- The outer table breaks every 60° step. -/
theorem eTable_step (i : ZMod 6) : eTable (i + 1) ≠ eTable i := by decide +revert

/-- The inner table breaks every 120° step — it is exactly a proper 3-colouring of the two
ℤ/3 triangles. -/
theorem oTable_step (i : ZMod 6) : oTable (i + 2) ≠ oTable i := by decide +revert

/-- The tables disagree at equal label — which is precisely where cross chords land. -/
theorem eTable_ne_oTable (i : ZMod 6) : eTable i ≠ oTable i := by decide +revert

/-! ### The theorem -/

/-- **The two-circle theorem, induced form.** The unit-distance graph on the *entire* set
`{z | dist z p = 1 ∨ dist z p = 1/√3}` — both circles about `p`, all of them, uncountably
many points — is 3-colourable. -/
theorem colorable_three_two_circles (p : ℂ) :
    ((unitDistance ℂ).induce
      {z : ℂ | dist z p = 1 ∨ dist z p = Real.sqrt 3 / 3}).Colorable 3 := sorry

/-- **The two-circle theorem, mapped form** — the shape a cover-set application consumes:
any family of points on the two circles about `p`, however indexed, spans a 3-colourable
unit-distance graph. -/
theorem colorable_three_of_two_circles {ι : Type*} (f : ι → ℂ) (p : ℂ)
    (hf : ∀ v, dist (f v) p = 1 ∨ dist (f v) p = Real.sqrt 3 / 3) :
    ((unitDistance ℂ).comap f).Colorable 3 := sorry

end TwoCircle
end HadwigerNelson
