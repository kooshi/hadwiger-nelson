import Proofs.HadwigerNelson.Plane.DensityBound.Autocorr

/-!
# Dual certificates and the pattern expectation (FS-131, FS131-KDB1; skeleton)

`[AmbrusEtAl2023]` Proposition 1 (pp. 13–14) is LP weak duality over the atoms of a Venn diagram, written for a periodic
set and an O(2)-average. Here it is one expectation over a **finite window**: for a bounded Borel 1-avoiding `E` and a
point configuration `X`, the *pattern* `pat(y, θ, b) = {i : y + ρ_{θ,b}(X i) ∈ E}` (`ρ_{θ,b}(z) = e^{iθ}(b ? z̄ : z)`) is
an independent set of `X`'s unit-distance graph; integrating over `y ∈ ℂ` (Lebesgue, unnormalized) and `(θ, b)`,
`N(I) := ∫ [I ⊆ pat]` is `4π vol E` on singletons, `4π F̊(|X i − X j|)` on pairs, and equal on congruent index sets, while
the nonempty patterns have total mass at most `4π vol B(x₀, R + D)`. A certificate whose `L(S) ≤ bound` on every nonempty
independent `S` therefore gives `w₁ vol E + Σ w₂ F̊ ≤ bound · vol B(x₀, R + D)`: no boundary error, because normalization
comes only at the end. Plan: `plans/FS131-KDB1-density-bound.md` § 3.
-/

namespace HadwigerNelson.DensityBound

open Real MeasureTheory Set Metric
open scoped ENNReal

/-- **A dual certificate** on `n` points: `[AmbrusEtAl2023]` Proposition 1's data without `w₀` (which lives on the
Fourier side): the points, the singleton weights `w₁`, the pair weights `w₂`, the congruence weights `w_c` and the bound
(`w_T + ν`). -/
structure DualCert (n : ℕ) where
  /-- The points. -/
  X : Fin n → ℂ
  /-- `w₁(i)`. -/
  w1 : Fin n → ℝ
  /-- `w₂(i, j)`, as a list of `(i, j, w)`. -/
  w2 : List (Fin n × Fin n × ℝ)
  /-- `w_c(I, J)`, as a list of `(I, J, w)`. -/
  wc : List (Finset (Fin n) × Finset (Fin n) × ℝ)
  /-- `w_T + ν`. -/
  bound : ℝ

namespace DualCert

variable {n : ℕ} (C : DualCert n)

/-- `L(S) = w_T − V(S)` of the paper's eq. (20): `Σ_{i∈S} w₁ + Σ_{i,j∈S} w₂ − Σ w_c([I ⊆ S] − [J ⊆ S])`. -/
noncomputable def L (S : Finset (Fin n)) : ℝ :=
  ∑ i ∈ S, C.w1 i + (C.w2.map fun e => if e.1 ∈ S ∧ e.2.1 ∈ S then e.2.2 else 0).sum -
    (C.wc.map fun e => e.2.2 * ((if e.1 ⊆ S then 1 else 0) - (if e.2.1 ⊆ S then 1 else 0))).sum

/-- `S` is independent in the unit-distance graph on `X`. -/
def IsIndep (S : Finset (Fin n)) : Prop := ∀ i ∈ S, ∀ j ∈ S, dist (C.X i) (C.X j) ≠ 1

/-- `X '' I` and `X '' J` are congruent: some isometry `z ↦ u·z + v` or `z ↦ u·z̄ + v` (`‖u‖ = 1`) carries one onto the
other. -/
def Congruent (I J : Finset (Fin n)) : Prop :=
  ∃ (u v : ℂ) (b : Bool), ‖u‖ = 1 ∧
    (fun z => u * (if b then (starRingEnd ℂ) z else z) + v) '' (C.X '' (I : Set (Fin n))) = C.X '' (J : Set (Fin n))

/-- **The certificate's hypotheses** (`[AmbrusEtAl2023]` Proposition 1's `V(ε) ≥ 0`, read with `ν` inside `bound`, on the
nonempty independent atoms only; the congruences of `C(X)`). -/
structure Valid : Prop where
  cong : ∀ e ∈ C.wc, C.Congruent e.1 e.2.1
  atoms : ∀ S : Finset (Fin n), S.Nonempty → C.IsIndep S → C.L S ≤ C.bound
  bound_nonneg : 0 ≤ C.bound

/-- The Fourier-side function `ϕ(t) = w₀ J₀(t) + Σ w₁ + Σ w₂ J₀(t |X i − X j|)` (eq. (22)). -/
noncomputable def phi (w0 t : ℝ) : ℝ :=
  w0 * J0 t + ∑ i, C.w1 i + (C.w2.map fun e => e.2.2 * J0 (t * ‖C.X e.1 - C.X e.2.1‖)).sum

/-- **The pattern expectation** (the atom half of Proposition 1, finite-window form). -/
theorem window_bound (hC : C.Valid) {E : Set ℂ} (hE : MeasurableSet E) (h1 : ∀ a ∈ E, ∀ b ∈ E, dist a b ≠ 1)
    {x₀ : ℂ} {R D : ℝ} (hER : E ⊆ ball x₀ R) (hD : ∀ i, ‖C.X i‖ ≤ D) :
    (∑ i, C.w1 i) * (volume E).toReal +
        (C.w2.map fun e => e.2.2 * circleAvg (autocorr E) ‖C.X e.1 - C.X e.2.1‖).sum ≤
      C.bound * (volume (ball x₀ (R + D))).toReal := by
  sorry

end DualCert

/-- **A model of `DualCert.Valid`** with every field exercised at a nonzero value: one point, `w₁ = 1`, bound `1`; the
only nonempty set is `{0}`, independent, with `L = 1`. (It gives the trivial bound `vol E ≤ vol B(x₀, R)`.) -/
noncomputable def trivialCert : DualCert 1 := ⟨fun _ => 0, fun _ => 1, [], [], 1⟩

theorem trivialCert_valid : trivialCert.Valid := by
  sorry

end HadwigerNelson.DensityBound
