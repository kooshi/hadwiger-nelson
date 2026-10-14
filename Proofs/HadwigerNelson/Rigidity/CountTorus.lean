import Proofs.HadwigerNelson.Rigidity.ContinuityGroup
import Mathlib.Analysis.SpecialFunctions.Complex.Log

/-!
# The count's archimedean factor: one plane, at every number field (FS-131, job FS131-K12A; module M12, block A; skeleton)

**Read aloud, against the derivation** (J28D § 3.2 C3: "`T_S := ∏_v T(F_v)` … is the closure of `U` in `G_S` (weak
approximation, CLG-c (W))"; FS100-TCA's "C14.3's induction" at `n` real places; FS100-CX at a complex place). The count
needs of the archimedean places only this: **inside `L ⊗ ℝ` (Mathlib's mixed space of `L = F(i)`) sits the plane
`Δ = ℚ(i) ⊗ ℝ`**, the real span of the images of `1` and `i` (`Delta F`, an `ℝ`-linear map from `ℂ`), and its unit circle
is approximated by the unit vectors of `F²` — even by their `h`-th powers:

* `Delta_ratCast` — on `ℚ(i)` the plane is the canonical embedding: `Δ(q₁ + q₂ i) = e(q₁ + q₂ i)`.
* `Delta_circle_mem_closure` — every point `Δ(e^{iθ})` of the unit circle of `Δ` is a limit of images of unit vectors: the
  rational points of the circle, `(1 − t² + 2ti)/(1 + t²)` with `t ∈ ℚ`, are dense in it.
* `mem_closure_pow` — **the weak approximation the count reads**: for every unit vector `u` of `F²` and every `h ≥ 1`,
  `e(u)` is a limit of `e(w)^h` with `w` a unit vector. Route: `u = φ(t₀) = (1 + it₀)/(1 − it₀)` with `t₀ ∈ F`
  (`u ≠ −1`; `−1 = i²`); `φ(t)^h = φ(R_h(t))` for the rational function `R_h = Im (1 + it)^h / Re (1 + it)^h`; at every
  place `v` of `F` (Mathlib's mixed space of `F`) pick `y_v` with `R_h(y_v) = σ_v(t₀)` — `y_v = (ξ − 1)/(i(ξ + 1))` for the
  principal `h`-th root `ξ = exp(log φ(σ_v t₀) / h) ≠ −1`, real at a real place — then `t ∈ F` close to `(y_v)`
  (`F` is dense in its mixed space: a full lattice and its rational multiples).

With these the slices `Δ × K` of the completion carry `UD(ℝ²) ⊗ Cay(K, U)` (module `Rigidity/CountCompletion`,
`mem_closure_ιG`): one plane for every number field, totally real or not; C14.3's induction over the real places and
FS100-CX's restriction at the complex places are not on this route (both are the case `Δ` of dropping edges, which is the
safe direction for a ratio).

**Models.** `F = ℚ` (`⊥`): `L = ℚ(i)`, `Δ` is the whole mixed space's real form; `u = (3 + 4i)/5`.
-/

namespace HadwigerNelson.Rigidity.Counting

open SpectralChain NumberField Filter Topology

noncomputable section

variable (F : Subfield ℝ)

/-- `i`, as an element of `L = F(i)`. -/
def iL : fieldI F := ⟨Complex.I, by simp⟩

/-- **The norm-one elements of `L`**: `x · x̄ = 1` — the unit vectors of `F²`, read in `L`. -/
def normOneL : Set (fieldI F) := {x | x * conjOn (fieldI_conj F) x = 1}

theorem mem_normOneL_iff {x : fieldI F} : x ∈ normOneL F ↔ (x : ℂ) ∈ unitVectors F := by
  sorry

variable [NumberField F]

/-- **The plane `Δ = ℚ(i) ⊗ ℝ` inside `L ⊗ ℝ`**: `z ↦ Re z · e(1) + Im z · e(i)`. -/
def Delta : ℂ →ₗ[ℝ] NumberField.mixedEmbedding.mixedSpace (fieldI F) :=
  Complex.reLm.smulRight (NumberField.mixedEmbedding (fieldI F) 1) +
    Complex.imLm.smulRight (NumberField.mixedEmbedding (fieldI F) (iL F))

/-- On `ℚ(i)`, `Δ` is the canonical embedding. -/
theorem Delta_ratCast (q₁ q₂ : ℚ) :
    Delta F ((q₁ : ℂ) + (q₂ : ℂ) * Complex.I) =
      NumberField.mixedEmbedding (fieldI F) ((q₁ : fieldI F) + (q₂ : fieldI F) * iL F) := by
  sorry

/-- **The unit circle of `Δ` lies in the closure of the unit vectors.** -/
theorem Delta_circle_mem_closure (θ : ℝ) :
    Delta F (Complex.exp (θ * Complex.I)) ∈ closure (NumberField.mixedEmbedding (fieldI F) '' normOneL F) := by
  sorry

/-- **Weak approximation by `h`-th powers** — what the count reads of the archimedean torus. -/
theorem mem_closure_pow {x : fieldI F} (hx : x ∈ normOneL F) {h : ℕ} (hh : 1 ≤ h) :
    NumberField.mixedEmbedding (fieldI F) x ∈
      closure (NumberField.mixedEmbedding (fieldI F) '' ((· ^ h) '' normOneL F)) := by
  sorry

/-- **What the completion reads**: `Δ(e^{iθ}) · e(x)` is a limit of images of `h`-th powers of unit vectors — the closure
of a multiplicatively closed set is multiplicatively closed (`Submonoid.topologicalClosure`), and it holds `Δ(S¹)` and
`e(U)` (the two theorems above). -/
theorem Delta_circle_mul_mem_closure_pow (θ : ℝ) {x : fieldI F} (hx : x ∈ normOneL F) {h : ℕ} (hh : 1 ≤ h) :
    Delta F (Complex.exp (θ * Complex.I)) * NumberField.mixedEmbedding (fieldI F) x ∈
      closure (NumberField.mixedEmbedding (fieldI F) '' ((· ^ h) '' normOneL F)) := by
  sorry

theorem pow_mem_normOneL {x : fieldI F} (hx : x ∈ normOneL F) (h : ℕ) : x ^ h ∈ normOneL F := by
  sorry

theorem mul_mem_normOneL {x y : fieldI F} (hx : x ∈ normOneL F) (hy : y ∈ normOneL F) : x * y ∈ normOneL F := by
  sorry

/-! ## Spec examples -/

example : ((iL F : fieldI F) : ℂ) = Complex.I := rfl

end

end HadwigerNelson.Rigidity.Counting
