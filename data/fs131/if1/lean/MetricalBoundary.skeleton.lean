import Mathlib.MeasureTheory.Covering.BesicovitchVectorSpace
import Mathlib.MeasureTheory.Measure.Lebesgue.EqHaar
import Mathlib.Analysis.Normed.Module.Convex
import Mathlib.Topology.Order.IntermediateValue

/-!
# A set that is neither null nor conull has a nonempty metrical boundary (FS131-IF1)

`[Falconer1981]` Lemma 2 (i), p. 185: *"Let S be a measurable subset of Rⁿ with v(S) > 0 and v(Rⁿ∖S) > 0 then (i) ∂S is
non-empty"*, where `∂S`, the metrical boundary, is the set of points at which the Lebesgue density of `S` fails to exist or
exists with a value other than `0` or `1`. The paper defers the proof to Croft's Lemma 4, which this project does not hold;
the argument here is its own (nested balls of ratio one half), and is not claimed to be Croft's.

Setting: a finite-dimensional real normed space `E` with an additive Haar measure `μ`, and a `μ`-null-measurable `S` — for
Lebesgue measure on `ℝⁿ`, a Lebesgue measurable set, which is the paper's hypothesis. Write
`φ_S(c, r) = μ (S ∩ B̄(c, r)) / μ (B̄(c, r))`.

1. `c ↦ μ (S ∩ B̄(c, r))` is continuous (`continuous_measure_inter_closedBall`): two balls of one radius differ by at most an
   annulus, whose measure tends to `0` with the distance of the centres.
2. Inside a closed ball whose interior holds a density point of `S` and one of `Sᶜ` there is, at every small radius, a closed
   ball with `φ_S = 1/2` (`exists_closedBall_ratio_eq_half`): at a small radius `φ_S` is above `1/2` at the first point and
   below it at the second, the centres allowed form a convex set, and the intermediate value theorem applies.
3. A ball with `φ_S = 1/2` holds a density point of each in its interior (Lebesgue's density theorem in Besicovitch's form;
   a sphere is null), so step 2 repeats: nested closed balls with `φ_S = 1/2` and radii halving
   (`exists_nested_closedBalls_ratio_eq_half`).
4. At a common point `x` of the balls, `B̄(cₙ, rₙ) ⊆ B̄(x, 2 rₙ)` and the larger ball has `2 ^ dim E` times the measure, so
   both `φ_S(x, 2 rₙ)` and `φ_{Sᶜ}(x, 2 rₙ)` are at least `1 / (2 · 2 ^ dim E)` (`exists_ratio_ge_and_compl_ge`). Neither
   ratio tends to `1` (`exists_not_tendsto_ratio_and_compl`), which is the paper's statement; the quantitative form says
   more — both `S` and `Sᶜ` have positive upper density at `x`, with an explicit bound.

`Plane/FalconerReduction` reads the last theorem at `E = ℂ`, `μ = volume` (`falconer_lemma2_nonempty`).
-/

namespace HadwigerNelson.Plane

open Set MeasureTheory Filter Topology Metric

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E] (μ : Measure E) [μ.IsAddHaarMeasure]

/-- Two closed balls of one radius: the part of `S` in the second is the part in the first up to an annulus about the
first, whose measure depends only on the radius and the distance of the centres. -/
theorem measure_inter_closedBall_le_add (S : Set E) (c c' : E) (ρ : ℝ) :
    μ (S ∩ closedBall c' ρ) ≤
      μ (S ∩ closedBall c ρ) + (μ (closedBall (0 : E) (ρ + dist c' c)) - μ (closedBall (0 : E) ρ)) := by
  sorry

/-- The measure of the annulus between the radii `ρ` and `ρ + d` tends to `0` with `d`. -/
theorem tendsto_measure_closedBall_sub {ρ : ℝ} (hρ : 0 < ρ) :
    Tendsto (fun d : ℝ => μ (closedBall (0 : E) (ρ + d)) - μ (closedBall (0 : E) ρ)) (𝓝 0) (𝓝 0) := by
  sorry

/-- The measure of the part of any set in a closed ball of fixed positive radius is continuous in the centre. -/
theorem continuous_measure_inter_closedBall (S : Set E) {ρ : ℝ} (hρ : 0 < ρ) :
    Continuous fun c : E => μ (S ∩ closedBall c ρ) := by
  sorry

/-- On a closed ball of positive radius the ratios of a null-measurable set and of its complement sum to `1`. -/
theorem measure_inter_closedBall_div_add_compl {S : Set E} (hS : NullMeasurableSet S μ) (x : E) {r : ℝ} (hr : 0 < r) :
    μ (S ∩ closedBall x r) / μ (closedBall x r) + μ (Sᶜ ∩ closedBall x r) / μ (closedBall x r) = 1 := by
  sorry

/-- A set with positive measure in an open ball has a density point in it (Lebesgue's density theorem, in Besicovitch's
form, for an arbitrary set). -/
theorem exists_mem_ball_tendsto_ratio (A : Set E) {c : E} {ρ : ℝ} (h : μ (A ∩ ball c ρ) ≠ 0) :
    ∃ a ∈ ball c ρ, Tendsto (fun r => μ (A ∩ closedBall a r) / μ (closedBall a r)) (𝓝[>] 0) (𝓝 1) := by
  sorry

/-- A set of ratio one half in a closed ball of positive radius has positive measure in the open ball: a sphere is null. -/
theorem measure_inter_ball_ne_zero_of_ratio_eq_half {A : Set E} {c : E} {ρ : ℝ} (hρ : 0 < ρ)
    (h : μ (A ∩ closedBall c ρ) / μ (closedBall c ρ) = 1 / 2) : μ (A ∩ ball c ρ) ≠ 0 := by
  sorry

/-- **The step.** Inside a closed ball whose interior holds a density point `a` of `S` and a density point `b` of `Sᶜ`
there is, below any bound `δ`, a closed ball in which `S` has ratio exactly one half. -/
theorem exists_closedBall_ratio_eq_half {S : Set E} (hS : NullMeasurableSet S μ) {c₀ a b : E} {R δ : ℝ}
    (ha : a ∈ ball c₀ R) (hb : b ∈ ball c₀ R) (hδ : 0 < δ)
    (hSa : Tendsto (fun r => μ (S ∩ closedBall a r) / μ (closedBall a r)) (𝓝[>] 0) (𝓝 1))
    (hSb : Tendsto (fun r => μ (Sᶜ ∩ closedBall b r) / μ (closedBall b r)) (𝓝[>] 0) (𝓝 1)) :
    ∃ c ρ, 0 < ρ ∧ ρ ≤ δ ∧ closedBall c ρ ⊆ closedBall c₀ R ∧
      μ (S ∩ closedBall c ρ) / μ (closedBall c ρ) = 1 / 2 := by
  sorry

/-- A closed ball of ratio one half holds another of at most half its radius. -/
theorem exists_closedBall_subset_ratio_eq_half {S : Set E} (hS : NullMeasurableSet S μ) {c : E} {r : ℝ} (hr : 0 < r)
    (h : μ (S ∩ closedBall c r) / μ (closedBall c r) = 1 / 2) :
    ∃ c' r', 0 < r' ∧ r' ≤ r / 2 ∧ closedBall c' r' ⊆ closedBall c r ∧
      μ (S ∩ closedBall c' r') / μ (closedBall c' r') = 1 / 2 := by
  sorry

/-- A null-measurable set that is neither null nor conull has ratio exactly one half in some closed ball. -/
theorem exists_closedBall_ratio_eq_half_of_measure_ne_zero {S : Set E} (hS : NullMeasurableSet S μ) (h1 : μ S ≠ 0)
    (h2 : μ Sᶜ ≠ 0) : ∃ c r, 0 < r ∧ μ (S ∩ closedBall c r) / μ (closedBall c r) = 1 / 2 := by
  sorry

/-- Nested closed balls, radii at least halving, in each of which `S` has ratio exactly one half. -/
theorem exists_nested_closedBalls_ratio_eq_half {S : Set E} (hS : NullMeasurableSet S μ) (h1 : μ S ≠ 0)
    (h2 : μ Sᶜ ≠ 0) :
    ∃ (c : ℕ → E) (r : ℕ → ℝ), (∀ n, 0 < r n) ∧ (∀ n, r (n + 1) ≤ r n / 2) ∧
      (∀ n, closedBall (c (n + 1)) (r (n + 1)) ⊆ closedBall (c n) (r n)) ∧
      ∀ n, μ (S ∩ closedBall (c n) (r n)) / μ (closedBall (c n) (r n)) = 1 / 2 := by
  sorry

/-- At a point of a closed ball of ratio one half, the ball of twice the radius has ratio at least
`1 / (2 · 2 ^ dim E)`: it contains the first and has `2 ^ dim E` times its measure. -/
theorem ratio_two_mul_ge {A : Set E} {x c : E} {r : ℝ} (hr : 0 < r) (hx : x ∈ closedBall c r)
    (h : μ (A ∩ closedBall c r) / μ (closedBall c r) = 1 / 2) :
    (2 * 2 ^ Module.finrank ℝ E : ENNReal)⁻¹ ≤ μ (A ∩ closedBall x (2 * r)) / μ (closedBall x (2 * r)) := by
  sorry

/-- **The quantitative form.** A null-measurable set that is neither null nor conull has a point at which, along radii
tending to `0`, both it and its complement have ratio at least `1 / (2 · 2 ^ dim E)`. -/
theorem exists_ratio_ge_and_compl_ge {S : Set E} (hS : NullMeasurableSet S μ) (h1 : μ S ≠ 0) (h2 : μ Sᶜ ≠ 0) :
    ∃ (x : E) (s : ℕ → ℝ), (∀ n, 0 < s n) ∧ Tendsto s atTop (𝓝 0) ∧
      ∀ n, (2 * 2 ^ Module.finrank ℝ E : ENNReal)⁻¹ ≤ μ (S ∩ closedBall x (s n)) / μ (closedBall x (s n)) ∧
        (2 * 2 ^ Module.finrank ℝ E : ENNReal)⁻¹ ≤ μ (Sᶜ ∩ closedBall x (s n)) / μ (closedBall x (s n)) := by
  sorry

/-- A point at which a null-measurable set keeps ratio at least `κ > 0` along radii tending to `0` is no density point of
its complement. -/
theorem not_tendsto_ratio_compl_of_ratio_ge {A : Set E} (hA : NullMeasurableSet A μ) {x : E} {s : ℕ → ℝ} {κ : ENNReal}
    (hκ : κ ≠ 0) (hs : ∀ n, 0 < s n) (hs0 : Tendsto s atTop (𝓝 0))
    (h : ∀ n, κ ≤ μ (A ∩ closedBall x (s n)) / μ (closedBall x (s n))) :
    ¬ Tendsto (fun r => μ (Aᶜ ∩ closedBall x r) / μ (closedBall x r)) (𝓝[>] 0) (𝓝 1) := by
  sorry

/-- **`[Falconer1981]` Lemma 2 (i), in any finite dimension.** A null-measurable set that is neither null nor conull for an
additive Haar measure on a finite-dimensional real normed space has a point that is a density point neither of it nor of
its complement: its metrical boundary is nonempty. -/
theorem exists_not_tendsto_ratio_and_compl {S : Set E} (hS : NullMeasurableSet S μ) (h1 : μ S ≠ 0) (h2 : μ Sᶜ ≠ 0) :
    ∃ x : E, ¬ Tendsto (fun r => μ (S ∩ closedBall x r) / μ (closedBall x r)) (𝓝[>] 0) (𝓝 1) ∧
      ¬ Tendsto (fun r => μ (Sᶜ ∩ closedBall x r) / μ (closedBall x r)) (𝓝[>] 0) (𝓝 1) := by
  obtain ⟨x, s, hs, hs0, h⟩ := exists_ratio_ge_and_compl_ge μ hS h1 h2
  have hκ : (2 * 2 ^ Module.finrank ℝ E : ENNReal)⁻¹ ≠ 0 :=
    ENNReal.inv_ne_zero.2 (ENNReal.mul_ne_top ENNReal.ofNat_ne_top (ENNReal.pow_ne_top ENNReal.ofNat_ne_top))
  refine ⟨x, ?_, not_tendsto_ratio_compl_of_ratio_ge μ hS hκ hs hs0 fun n => (h n).1⟩
  have := not_tendsto_ratio_compl_of_ratio_ge μ hS.compl hκ hs hs0 fun n => (h n).2
  rwa [compl_compl] at this

end HadwigerNelson.Plane
