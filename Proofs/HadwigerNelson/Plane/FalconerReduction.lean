import Proofs.HadwigerNelson.Plane.Cover
import Proofs.HadwigerNelson.Arith.FalconerFan
import Proofs.HadwigerNelson.UnitDistance
import Mathlib.NumberTheory.Real.Irrational

/-!
# Falconer's reduction: a Falconer fan with an irrational angle gives `χ_m(ℝ²) ≥ k + 1` (FS-131 wave 2)

Row: **FS129-SA1-FALC-RED** (FS129-OA1-FALC-RED's statement from FS129-SA1-FALC-RED's argument, SA1 item 6). Plan:
`plans/FS131-w2-kernel-plan.md` §§ 3–4. `[Falconer1981]` Lemma 1 is **formalized**, not imported, in the measurable form
the argument reads (`falconer_lemma1`), through the two-circle lemma (`twoCircle_preimage_null`), which the Rajchman step
of `Plane/Slack` also uses. Lemmas 2–4 are the argument's children (the implementer's).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric HadwigerNelson HadwigerNelson.Arith

/-- `χ_m(ℝ²)` (Falconer's, everywhere-proper): the least `k` with a measurable `k`-colouring proper at every unit pair. -/
noncomputable def chiM : ℕ∞ :=
  ⨅ (k : ℕ) (_ : ∃ f : ℂ → Fin k, Measurable f ∧ ∀ x y, dist x y = 1 → f x ≠ f y), (k : ℕ∞)

/-- Spec: `sq9` bounds `χ_m(ℝ²)` by `9`. -/
example : chiM ≤ 9 := iInf₂_le 9 ⟨sq9Col, measurable_sq9Col, fun _ _ h => sq9Col_ne_of_dist_eq_one h⟩

/-- **The two-circle lemma**: for `r₁, r₂ > 0`, `(s, φ) ↦ z₀ + r₁ e s + r₂ e φ` pulls null sets back to null sets. -/
theorem twoCircle_preimage_null (z₀ : ℂ) {r₁ r₂ : ℝ} (h₁ : 0 < r₁) (h₂ : 0 < r₂) {N : Set ℂ} (hN : volume N = 0) :
    (volume : Measure (ℝ × ℝ)) ((fun q : ℝ × ℝ => z₀ + r₁ * e q.1 + r₂ * e q.2) ⁻¹' N) = 0 := by
  sorry

/-- **`[Falconer1981]` Lemma 1, measurable form** (formalized; the paper's statement is for every null `E`, its proof is
not printed): for a nonempty measurable null `E`, a countable configuration `C` and `x ∈ C`, some translation `p` puts
`p x ∈ E` with almost every rotation `ρ` of `p(C)` about `p x` meeting `E` only at `p x`. -/
theorem falconer_lemma1 {E : Set ℂ} (hEm : MeasurableSet E) (hE : E.Nonempty) (hE0 : volume E = 0) {C : Set ℂ}
    (hC : C.Countable) {x : ℂ} (hx : x ∈ C) :
    ∃ v : ℂ, x + v ∈ E ∧ ∀ᵐ θ ∂arcLength, ∀ y ∈ C, x + v + e θ * (y - x) ∈ E → y = x := by
  sorry

/-- **FS129-SA1-FALC-RED**: if a finite unit-distance graph `H ⊂ ℝ²` has a Falconer fan at `k` colours with apex `a` and
tip `t`, `|t − a| = r > 1/2` and `arcsin(1/(2r))/π` irrational, then every cover of the plane by `k` measurable sets has
two points at distance `1` inside one of the sets. -/
theorem falconer_reduction {k : ℕ} (V : Finset ℂ) {a t : ℂ} (ha : a ∈ V) (ht : t ∈ V)
    (hfan : FalconerFan ((unitDistance ℂ).induce (V : Set ℂ)) k ⟨a, ha⟩ ⟨t, ht⟩) (hr : 1 / 2 < dist t a)
    (hirr : Irrational (Real.arcsin (1 / (2 * dist t a)) / Real.pi)) (S : Fin k → Set ℂ)
    (hS : ∀ j, MeasurableSet (S j)) (hcov : ⋃ j, S j = univ) :
    ∃ j, ∃ x ∈ S j, ∃ y ∈ S j, dist x y = 1 := by
  sorry

/-- **FS129-SA1-FALC-RED**, its conclusion for Falconer's chromatic number: `χ_m(ℝ²) ≥ k + 1`. -/
theorem le_chiM_of_falconerFan {k : ℕ} (V : Finset ℂ) {a t : ℂ} (ha : a ∈ V) (ht : t ∈ V)
    (hfan : FalconerFan ((unitDistance ℂ).induce (V : Set ℂ)) k ⟨a, ha⟩ ⟨t, ht⟩) (hr : 1 / 2 < dist t a)
    (hirr : Irrational (Real.arcsin (1 / (2 * dist t a)) / Real.pi)) : ((k + 1 : ℕ) : ℕ∞) ≤ chiM := by
  refine le_iInf₂ fun k' ⟨f, hfm, hfp⟩ => ?_
  by_contra hlt
  have hk : k' ≤ k := by
    have : (k' : ℕ∞) < ((k + 1 : ℕ) : ℕ∞) := not_le.1 hlt
    have := Nat.lt_succ_iff.1 (by exact_mod_cast this)
    exact this
  classical
  let S : Fin k → Set ℂ := fun j => if h : (j : ℕ) < k' then f ⁻¹' {⟨j, h⟩} else ∅
  have hSm : ∀ j, MeasurableSet (S j) := fun j => by
    by_cases h : (j : ℕ) < k'
    · simp only [S, dif_pos h]; exact hfm (measurableSet_singleton _)
    · simp only [S, dif_neg h]; exact MeasurableSet.empty
  have hcov : ⋃ j, S j = univ := by
    refine eq_univ_of_forall fun z => mem_iUnion.2 ⟨⟨(f z : ℕ), lt_of_lt_of_le (f z).isLt hk⟩, ?_⟩
    simp only [S, dif_pos (f z).isLt]
    simp
  obtain ⟨j, x, hx, y, hy, hxy⟩ := falconer_reduction V ha ht hfan hr hirr S hSm hcov
  by_cases h : (j : ℕ) < k'
  · simp only [S, dif_pos h, mem_preimage, mem_singleton_iff] at hx hy
    exact hfp x y hxy (hx.trans hy.symm)
  · simp [S, dif_neg h] at hx

end HadwigerNelson.Plane
