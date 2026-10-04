import Proofs.HadwigerNelson.Plane.Suprema
import Proofs.HadwigerNelson.Plane.CPColouring

/-!
# Rescaling, the suprema's limits, the equivalence, kept points, the face lemma (FS-131 wave 2)

Rows: **FS111-V0-RESCALE**, **FS129-SR2-SUPK** (carrying FS106-SUP), **FS106-EQ**, **FS106-COMP** (second clause),
**FS106-REM**, **FS121-D4-FACE** (with FS121-V5-FACE-SHARP's hypothesis), **FS121-V5-FACE-SHARP**.
Plan: `plans/FS131-w2-kernel-plan.md` § 4.

**Named hypothesis from outside the backlog** (`plans/FS131-kernel-plan.md` § 7.4): `Row130M1`, FS-103's M1 in its
hard direction (`χ_m⁰(ℝ²) ≤ k ⟹ χ_CP(ℝ²) ≤ k`, row 130's last equality; [hand, two minds]) — a stationary limit of
translates (Krylov–Bogolyubov) with the Rajchman step. It enters only FS106-EQ's `χ_CP` clause; its own path to the kernel is
a separate planner-and-implementer job (FS-103's M1 module). The easy direction is formalized here unconditionally.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

/-- **FS111-V0-RESCALE**: if an a.e.-proper measurable `k`-colouring exists, a tight one exists. -/
theorem AeColouring.exists_tight (c : AeColouring k) : ∃ c' : AeColouring k, c'.Tight := by
  sorry

/-- **FS111-V0-RESCALE**, second clause: a tight a.e.-proper `k`-colouring exists iff `χ_m⁰(ℝ²) ≤ k`. -/
theorem exists_tight_iff_chiM0_le : (∃ c : AeColouring k, c.Tight) ↔ chiM0 ≤ k := by
  sorry

/-- **FS129-SR2-SUPK** (carrying FS106-SUP's first clause, at every `k`): `µ_k⁰ = lim_{ε→0} µ_k(ε)`. -/
theorem tendsto_mu (k : ℕ) : Tendsto (mu k) (𝓝[>] 0) (𝓝 (muZero k)) := by
  sorry

/-- **FS129-SR2-SUPK**: `µ_k⁰ = lim_{ε→0} µ_k^tile(ε)`. -/
theorem tendsto_muTile (k : ℕ) : Tendsto (muTile k) (𝓝[>] 0) (𝓝 (muZero k)) := by
  sorry

/-- **FS129-SR2-SUPK**: `µ_k⁰ = lim_{ε→0} µ_k^per(ε)`. -/
theorem tendsto_muPer (k : ℕ) : Tendsto (muPer k) (𝓝[>] 0) (𝓝 (muZero k)) := by
  sorry

/-- FS-103's M1, hard direction, as the named hypothesis FS106-EQ's `χ_CP` clause reads (outside the backlog). -/
def Row130M1 : Prop := ∀ k : ℕ, chiM0 ≤ k → chiCP ≤ k

/-- FS-103's M1, easy direction (TQ § 2.3, steps 1 and 3): a CP `k`-colouring has a jointly measurable modification whose
realisations are a.e.-proper, so `χ_m⁰(ℝ²) ≤ χ_CP(ℝ²)`. Formalized here; no hypothesis. -/
theorem chiM0_le_chiCP : chiM0 ≤ chiCP := by
  sorry

/-- **FS106-EQ**, (a) ⟺ (c), and FS106-COMP's first clause as (c) ⟹ (a) at every `k` (SR2 item 11):
`χ_m⁰(ℝ²) ≤ k ⟺ µ_k⁰ = 1`. -/
theorem chiM0_le_iff_muZero_eq_one (k : ℕ) : chiM0 ≤ k ↔ muZero k = 1 := by
  sorry

/-- **FS106-EQ**, (a) ⟺ (b), given FS-103's M1 (`Row130M1`, named): `χ_m⁰(ℝ²) ≤ k ⟺ χ_CP(ℝ²) ≤ k`. -/
theorem chiM0_le_iff_chiCP_le (hM1 : Row130M1) (k : ℕ) : chiM0 ≤ k ↔ chiCP ≤ k :=
  ⟨hM1 k, fun h => chiM0_le_chiCP.trans h⟩

/-- **FS106-EQ**, (c) ⟺ (d) (SUPK at the value `1`): `µ_k⁰ = 1 ⟺ lim_{ε→0} µ_k(ε) = 1`. -/
theorem muZero_eq_one_iff_tendsto (k : ℕ) : muZero k = 1 ↔ Tendsto (mu k) (𝓝[>] 0) (𝓝 1) := by
  sorry

/-- **FS106-EQ**, (a) ⟺ (e): `χ_m⁰(ℝ²) ≤ k` iff for every `δ > 0` there are `ε > 0` and a periodic partial `k`-colouring by
half-open grid squares with no monochromatic pair at any distance in `[1 − ε, 1 + ε]`, covering upper density at least
`1 − δ`. -/
theorem chiM0_le_iff_periodic (k : ℕ) :
    chiM0 ≤ k ↔ ∀ δ > 0, ∃ ε > 0, ∃ C : Fin k → Set ℂ, IsPartialColouring C ∧ IsTiled C ∧ IsPeriodic C ∧
      (∀ j, BandFree (C j) ε) ∧ 1 - ENNReal.ofReal δ ≤ upperDensity (⋃ j, C j) := by
  sorry

/-- **FS106-EQ**, at `k = 6`: `χ_m⁰(ℝ²) ≥ 7 ⟺ lim_{ε→0} µ₆(ε) < 1` (the limit is the supremum over `ε > 0`, `µ₆` being
antitone). -/
theorem seven_le_chiM0_iff : 7 ≤ chiM0 ↔ (⨆ ε > (0 : ℝ), mu 6 ε) < 1 := by
  sorry

/-- `[Voronov2023]` Thm 1.1 (Euclidean norm, six colours), as a statement: for every `ε > 0` no six-colouring of the plane
is proper for the forbidden interval `[1 − ε, 1 + ε]` (D-VPROP). Named here, not imported (FS106-COMP's clause is an
equivalence, not a use). -/
def Voronov11 : Prop :=
  ∀ ε > 0, ¬ ∃ f : ℂ → Fin 6, ∀ x y, 1 - ε ≤ dist x y → dist x y ≤ 1 + ε → f x ≠ f y

/-- **FS106-SUP's attainment clause, at the value FS106-COMP reads** (carried content of FS129-SR2-SUPK's merged row, inventory
item 23): if `µ_k(ε) = 1`, some partial `k`-colouring whose classes are band-null at `ε` covers almost every point. QB § 2.7
reaches it through SUP's stationary attaining family (mean coverage `1`); FS106-QB § 2.4's compactness argument for (c) ⟹ (a)
gives it directly at every `k` — translates to windows of small hole measure, a weak-* limit, the band form continuous because
its kernel `1_{annulus}` is `L¹` (no Rajchman step, no Krylov–Bogolyubov), and support selection. -/
theorem exists_bandNull_aeCover_of_mu_eq_one {k : ℕ} {ε : ℝ} (hε : 0 < ε) (h : mu k ε = 1) :
    ∃ C : Fin k → Set ℂ, IsPartialColouring C ∧ (∀ j, BandNull (C j) ε) ∧ ∀ᵐ x ∂volume, ∃ j, x ∈ C j := by
  sorry

/-- **FS106-COMP**, second clause: "`µ₆(ε) < 1` for every `ε > 0`" is equivalent to `[Voronov2023]` Thm 1.1. -/
theorem forall_mu_six_lt_one_iff : (∀ ε > (0 : ℝ), mu 6 ε < 1) ↔ Voronov11 := by
  sorry

/-- `x` is **kept** at scale `ε` for the class `A` with threshold `η`: the balls of radii `ε/2` and `2ε` about `x` are at
least `1 − η` full of `Ã` (FS106-TQ § 2.2). -/
def KeptAt (A : Set ℂ) (η ε : ℝ) (x : ℂ) : Prop :=
  ∀ ρ ∈ ({ε / 2, 2 * ε} : Set ℝ), ENNReal.ofReal (1 - η) * volume (ball x ρ) ≤ volume (ball x ρ ∩ densitySet A)

/-- **FS106-REM**, first clause (one class, G92): for a measurable `A` with null unit pairs, any `η < 1/(1 + 4π)` and every
`ε > 0`, two points kept at scale `ε` are never at a distance in `[1 − ε, 1 + ε]`. (The row reads kept points of one
colour of a partial colouring; membership of the points in `A` is not used — a generalization.) -/
theorem keptAt_band {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {η : ℝ} (hη0 : 0 ≤ η)
    (hη : η < 1 / (1 + 4 * Real.pi)) {ε : ℝ} (hε : 0 < ε) {x y : ℂ} (hx : KeptAt A η ε x) (hy : KeptAt A η ε y) :
    dist x y < 1 - ε ∨ 1 + ε < dist x y := by
  sorry

/-- **FS106-REM**, second clause: for a CP colouring, `P(0 is not kept at scale ε) → 0`, "kept" read in a jointly
measurable modification `c̃` of the realisations. -/
theorem CPColouring.tendsto_not_kept (c : CPColouring k) {η : ℝ} (hη0 : 0 < η) :
    ∃ ct : (ℂ → Fin k) → ℂ → Fin k, Measurable (Function.uncurry ct) ∧ (∀ x, c.law {f | ct f x ≠ f x} = 0) ∧
      Tendsto (fun ε => c.law {f | ¬ KeptAt (ct f ⁻¹' {ct f 0}) η ε 0}) (𝓝[>] 0) (𝓝 0) := by
  sorry

/-- **FS106-REM**, third clause: the uniform form is FALSE — some measurable colouring proper at every unit pair (the
zigzag colouring, FS106-TQ's control C2) has, at every `ε`, translates of the unit square holding non-kept points of
measure bounded below. -/
theorem exists_not_uniform_kept {η : ℝ} (hη0 : 0 < η) :
    ∃ (k : ℕ) (f : ℂ → Fin k), Measurable f ∧ (∀ x y, dist x y = 1 → f x ≠ f y) ∧ ∃ m > (0 : ENNReal),
      ∀ ε > (0 : ℝ), ∃ z : ℂ, m ≤ volume {x | x - z ∈ {w : ℂ | 0 ≤ w.re ∧ w.re ≤ 1 ∧ 0 ≤ w.im ∧ w.im ≤ 1} ∧
        ¬ KeptAt (f ⁻¹' {f x}) η ε x} := by
  sorry

/-- The open half-box `{x − s e + t e⊥ : 0 < s < ε, |t| < ε}`, `e = e θ`, `e⊥ = i e θ`. -/
def halfBox (x : ℂ) (θ ε : ℝ) : Set ℂ :=
  {z | ∃ s t : ℝ, 0 < s ∧ s < ε ∧ |t| < ε ∧ z = x + e θ * (-s + t * I)}

/-- The open far box `{x + s e + t e⊥ : g < s < g + ε′, |t| < ρ}`. -/
def farBox (x : ℂ) (θ g ε' ρ : ℝ) : Set ℂ :=
  {z | ∃ s t : ℝ, g < s ∧ s < g + ε' ∧ |t| < ρ ∧ z = x + e θ * (s + t * I)}

/-- **FS121-D4-FACE** with **FS121-V5-FACE-SHARP**'s hypothesis `ρ² ≥ 2g − g²` (SR1 item 6), one class (G92: the argument
reads only `A`'s own unit pairs): if the half-box and the far box lie almost everywhere in `A`, no point of `supp A` is at
distance exactly `1` from `x`. The far box lies between `x` and `x + e` (`g < 1`; ruling, `plans/FS131-close-inventory.md` item
37: for `g > 2` the sharp hypothesis holds for every `ρ` and the clause is false — a far box beyond `x + 2e` meets no unit circle
about the points near `x + e`). -/
theorem face {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {x : ℂ} {θ ε ε' g ρ : ℝ} (hε : 0 < ε)
    (hε' : 0 < ε') (hg : 0 < g) (hg1 : g < 1) (hρ : 0 < ρ) (hsharp : 2 * g - g ^ 2 ≤ ρ ^ 2)
    (hhalf : volume (halfBox x θ ε \ A) = 0) (hfar : volume (farBox x θ g ε' ρ \ A) = 0) :
    ∀ y ∈ essSupport A, dist x y ≠ 1 := by
  sorry

/-- **FS121-D4-FACE**, last clause: so in a saturated colouring the colour has density `1` at `x` (`g < 1`, ruling item 37). -/
theorem face_densitySet {C : Fin k → Set ℂ} (hadm : IsAdmissible C) (hsat : Saturated C) {j : Fin k} {x : ℂ}
    {θ ε ε' g ρ : ℝ} (hε : 0 < ε) (hε' : 0 < ε') (hg : 0 < g) (hg1 : g < 1) (hρ : 0 < ρ)
    (hsharp : 2 * g - g ^ 2 ≤ ρ ^ 2)
    (hhalf : volume (halfBox x θ ε \ C j) = 0) (hfar : volume (farBox x θ g ε' ρ \ C j) = 0) :
    x ∈ densitySet (C j) := by
  sorry

/-- **FS121-V5-FACE-SHARP**, its failure half: whenever `ρ² < 2g − g²` the first clause fails for some a.e.-proper colouring
(V5 § 2.2's explicit colouring at `g = 1/10`, `ρ = 2/5`, generalized). -/
theorem exists_face_fails {g ρ : ℝ} (hg : 0 < g) (hρ : 0 < ρ) (hlt : ρ ^ 2 < 2 * g - g ^ 2) :
    ∃ (k : ℕ) (c : AeColouring k) (j : Fin k) (x : ℂ) (θ ε ε' : ℝ), 0 < ε ∧ 0 < ε' ∧
      volume (halfBox x θ ε \ c.cls j) = 0 ∧ volume (farBox x θ g ε' ρ \ c.cls j) = 0 ∧
      ∃ y ∈ essSupport (c.cls j), dist x y = 1 := by
  sorry

end HadwigerNelson.Plane
