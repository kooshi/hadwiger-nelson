import Proofs.HadwigerNelson.Plane.Woodall.Basic
import Proofs.HadwigerNelson.Plane.SVMap

/-!
# Two colours about a unit circle: Woodall's step-4 lemma, Townsend's `π/3` lemma (FS106-WO, FS106-TW)

FS131-W's skeleton (`plans/FS131-W-kernel-plan.md` § 3). Region-only throughout: two open colour classes `A`, `B`, no two points of one class
at distance exactly `1`, and sets lying in `closure (A ∪ B)` — the two-coloured sets of lemma (L) (`lemmaL`, FS106-L). Every theorem here is one
move: a change point `b` (both colours arbitrarily near) inside a collar, whose unit circle crosses `ω(u)` at `θ_b ± arccos(|b − u|/2)` and meets
a collar there, against lemma (L).

* **FS106-WO, the step-4 lemma** (`woodall_step4`): a collar of positive thickness about every angle of an open arc of length `> 2π/3`, on one
  side of `ω(u)`, cannot be two-coloured. **Sharp**: `not_woodall_step4_two_thirds` is Townsend's counterexample at length `2π/3`
  (`[Townsend1979ms]` p. 2, `[Townsend1981]` p. 114).
* **FS106-TW, Townsend's `π/3` lemma** (`townsend_lemma`, `[Townsend1979ms]` Thm 1 in the form its proof reads): if every angle off a finite set
  of cut angles carries a one-sided collar, and one side carries collars over a closed arc of length `> π/3`, the two-colouring fails.
* **The excluded set** (`collarAt_shadow_outer`, `collarAt_shadow_inner`, `ArcMap.col_not_mem_of_mem_shadow`): the cone of a connected piece of
  a class at `u` decides on which side of `ω(u)`, about which angles, the unit circles meet the piece; region points whose circles meet every
  class of `T` carry no colour of `T`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Annular sectors and collars: geometry -/

/-- An annular sector of non-negative inner radius is open (polar coordinates are a local homeomorphism off the centre). -/
theorem isOpen_annSector (u : ℂ) {r₁ : ℝ} (hr : 0 ≤ r₁) (r₂ θ₁ θ₂ : ℝ) : IsOpen (annSector u r₁ r₂ θ₁ θ₂) := by
  sorry

/-- An annular sector is preconnected: the image of a convex set under a continuous map. -/
theorem isPreconnected_annSector (u : ℂ) (r₁ r₂ θ₁ θ₂ : ℝ) : IsPreconnected (annSector u r₁ r₂ θ₁ θ₂) := by
  sorry

/-- A collar of thickness at most `1` is open. -/
theorem isOpen_collar (u : ℂ) (s : Rim) (θ₁ θ₂ : ℝ) {h : ℝ} (hh : h ≤ 1) : IsOpen (collar u s θ₁ θ₂ h) := by
  sorry

/-- Collars shrink with their angles and their thickness. -/
theorem collar_subset_collar (u : ℂ) (s : Rim) {θ₁ θ₂ θ₁' θ₂' h h' : ℝ} (h₁ : θ₁ ≤ θ₁') (h₂ : θ₂' ≤ θ₂) (hh : h' ≤ h) :
    collar u s θ₁' θ₂' h' ⊆ collar u s θ₁ θ₂ h := by
  sorry

/-- **Collars about every angle of a compact arc give one collar over it**: if `S` carries a collar on the side `s` about every angle of
`[θ₁, θ₂]`, some collar of positive thickness over `(θ₁, θ₂)` lies in `S`. -/
theorem exists_collar_of_collarAt {S : Set ℂ} {u : ℂ} {s : Rim} {θ₁ θ₂ : ℝ} (hS : ∀ θ ∈ Icc θ₁ θ₂, CollarAt S u s θ) :
    ∃ h > 0, collar u s θ₁ θ₂ h ⊆ S := by
  sorry

/-- **A unit pair in every thin collar over an arc longer than `π/3`**: on either side of `ω(u)`, a collar of any positive thickness over an
open arc of length `> π/3` holds two points at distance exactly `1` (a chord of `ω(u)`'s concentric circle near radius `1`). -/
theorem exists_unit_pair_collar (u : ℂ) (s : Rim) {θ₁ θ₂ h : ℝ} (hlen : π / 3 < θ₂ - θ₁) (hh : 0 < h) :
    ∃ x ∈ collar u s θ₁ θ₂ h, ∃ y ∈ collar u s θ₁ θ₂ h, dist x y = 1 := by
  sorry

/-! ## Two colours: change points -/

/-- **A two-coloured connected open set holding a unit pair has a change point**: neither class can be dense in it alone (a dense open class
would hold a unit pair, by sweeping unit circles), so by connectedness the closures of the two classes meet inside it. -/
theorem exists_changePt {A B W : Set ℂ} (hA : IsOpen A) (hB : IsOpen B) (hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1)
    (hBu : ∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) (hW : IsOpen W) (hWc : IsPreconnected W) (hWAB : W ⊆ closure (A ∪ B))
    {x y : ℂ} (hx : x ∈ W) (hy : y ∈ W) (hxy : dist x y = 1) : ∃ b ∈ W, b ∈ closure A ∧ b ∈ closure B := by
  sorry

/-! ## The landing: the unit circle about a point near `ω(u)` -/

/-- **The landing.** The unit circle about `b = u + ρ e(θ)`, `0 < ρ < 2`, crosses `ω(u)` transversally at the angles `θ ± arccos(ρ/2)`; if a
set carries a collar (either side) about one of them, the circle meets it. -/
theorem sphere_meets_of_collarAt {W : Set ℂ} {u : ℂ} {ρ θ σ : ℝ} (hρ : 0 < ρ) (hρ2 : ρ < 2) (hσ : σ = 1 ∨ σ = -1) {s : Rim}
    (hW : CollarAt W u s (θ + σ * Real.arccos (ρ / 2))) : (sphere (u + (ρ : ℂ) * e θ) 1 ∩ W).Nonempty := by
  sorry

/-! ## FS106-WO: Woodall's step-4 lemma, strict, and its sharpness -/

/-- **FS106-WO, the step-4 lemma** (`[Woodall1973]` p. 198, as repaired: length **strictly** above `2π/3`): if, on one side `s` of `ω(u)`,
every angle of an open arc of length `> 2π/3` carries a collar inside `closure (A ∪ B)` — `A`, `B` open with no unit pair in either — then
`False`. (A collar about each angle is Woodall's "unit arc of positive thickness" with its thickness `f(θ)` locally bounded away from the
circle.) -/
theorem woodall_step4 {A B : Set ℂ} (hA : IsOpen A) (hB : IsOpen B) (hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1)
    (hBu : ∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) {u : ℂ} (s : Rim) {θ₁ θ₂ : ℝ} (hlen : 2 * π / 3 < θ₂ - θ₁)
    (hW : ∀ θ ∈ Ioo θ₁ θ₂, CollarAt (closure (A ∪ B)) u s θ) : False := by
  sorry

/-- **The step-4 lemma is false at length `2π/3`** — Townsend's counterexample (`[Townsend1979ms]` p. 2; `[Townsend1981]` p. 114): the inner
collar of `ω(0)` over `(0, 2π/3)`, cut by the arc of `ω(1)` through `e(π/3)` into `A` (inside `B(1, 1)`) and `B` (outside `B̄(1, 1)`), has no unit
pair in either part. The strictness in `woodall_step4` cannot be dropped; this is the assertion `[Woodall1973]` step 4 ("The lower bound `⅔π` is
critical here") made and Townsend refuted. -/
theorem not_woodall_step4_two_thirds :
    ¬ ∀ (A B : Set ℂ) (u : ℂ) (s : Rim) (θ₁ θ₂ : ℝ), IsOpen A → IsOpen B → (∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1) →
      (∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) → 2 * π / 3 ≤ θ₂ - θ₁ →
      (∀ θ ∈ Ioo θ₁ θ₂, CollarAt (closure (A ∪ B)) u s θ) → False := by
  sorry

/-! ## FS106-TW: Townsend's `π/3` lemma -/

/-- **FS106-TW, Townsend's `π/3` lemma** (`[Townsend1979ms]` Thm 1, = `[Townsend1981]`'s lemma, in the form its proof reads): `A`, `B` open with
no unit pair in either; every angle off a finite set `K` of cut angles (and their `2π`-translates) carries a collar, on one side or the other of
`ω(u)`, inside `closure (A ∪ B)`; and one side carries collars about every angle of a closed arc of length `> π/3` (the seed: Townsend's "segment
of length greater than ⅓π containing no cut points"). Then `False`. -/
theorem townsend_lemma {A B : Set ℂ} (hA : IsOpen A) (hB : IsOpen B) (hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1)
    (hBu : ∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) {u : ℂ} {K : Set ℝ} (hK : K.Finite)
    (hcollar : ∀ θ : ℝ, (∀ κ ∈ K, ∀ m : ℤ, θ ≠ κ + 2 * π * m) → ∃ s, CollarAt (closure (A ∪ B)) u s θ)
    (hseed : ∃ (s : Rim) (θ₁ θ₂ : ℝ), π / 3 < θ₂ - θ₁ ∧ ∀ θ ∈ Icc θ₁ θ₂, CollarAt (closure (A ∪ B)) u s θ) : False := by
  sorry

/-! ## The excluded set: cones decide the collars -/

/-- **Outer collars from a cone direction**: a preconnected `R` with `u ∈ closure R` approaching `u` along `β` meets the unit circle about
every point of some outer collar about `ψ` whenever `cos (β − ψ) > 0` (such a point `z` has `u` outside `B̄(z, 1)` and points of `R` inside). -/
theorem collarAt_shadow_outer {R : Set ℂ} (hRc : IsPreconnected R) {u : ℂ} {β ψ : ℝ} (hβ : β ∈ coneAt R u)
    (hcos : 0 < Real.cos (β - ψ)) : CollarAt (shadow R) u .outer ψ := by
  sorry

/-- **Inner collars from a cone direction**: the same for inner collars when `cos (β − ψ) < 0` (such a point `z` has `u` inside `B(z, 1)` and
points of `R` outside). -/
theorem collarAt_shadow_inner {R : Set ℂ} (hRc : IsPreconnected R) {u : ℂ} {β ψ : ℝ} (hβ : β ∈ coneAt R u)
    (hcos : Real.cos (β - ψ) < 0) : CollarAt (shadow R) u .inner ψ := by
  sorry

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **The excluded set carries no colour of `T`**: an interior point of a valid map whose unit circle meets the class of every colour of `T`
does not carry a colour of `T`. -/
theorem col_not_mem_of_mem_shadow (hF : F.Valid) {T : Finset (Fin k)} {z : ℂ} (hz : z ∈ F.interiorPts)
    (hzT : ∀ c ∈ T, z ∈ shadow (F.region c)) : F.col z ∉ T := by
  sorry

/-- **An open subset of the excluded set is coloured by the other colours**: in a valid map of the plane, an open set whose points' unit
circles meet every class of `T` lies in the closure of the union of the classes of the colours outside `T`. -/
theorem subset_closure_of_subset_shadow (hF : F.Valid) (hP : F.IsPlaneMap) {T : Finset (Fin k)} {W : Set ℂ} (hW : IsOpen W)
    (hWT : ∀ c ∈ T, W ⊆ shadow (F.region c)) : W ⊆ closure (⋃ c ∈ (Tᶜ : Finset (Fin k)), F.region c) := by
  sorry

end ArcMap

end HadwigerNelson.Plane
