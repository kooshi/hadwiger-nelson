import Proofs.HadwigerNelson.Collapse.Thick
import Proofs.HadwigerNelson.Arith.RatioBound

/-!
# Mixing on the completion: two sets with null edges across the unit vectors cannot both be large (FS-131, job FS131-KCL1; module C5)

**Read aloud, against the informal claim** (V1-L6's edge inequality, `plans/FS103-V1-verification.md` ll. 143–158; V2 L3,
ll. 153–160): for measurable `A, B` in the compact part `K` of the completion with `Haar(A ∩ (B − ιK u)) = 0` at every unit
vector `u`, and `a = Haar A`, `b = Haar B`,

  `ab ≤ c·√(a(1 − a))·√(b(1 − b))`

over a uniformly `c`-thick field. With `a, b ≥ θ > c/(1 + c)` the inequality fails, so two such sets are not both of measure
at least `θ` — the edge inequality the selection reads (`Collapse/Selection`).

**Route — the finite levels, no Fourier analysis on `K`** (record § 3.2, decision 3). At level `k` let `E_k` average over the
cosets of `ker (proj k)`. It commutes with every translation, so the edge integral splits into
* a **finite-group term** on the level group `LevImg F k` with connection set `levU F k` — `finite_mixing`, Fourier analysis on a
  finite abelian group (`RatioBound`'s technique, two-sided, for `[0, 1]`-valued functions), fed by `levelThick`; and
* a **remainder** bounded by `√(levelResid A k)·√(levelResid B k)` (Cauchy–Schwarz; the translations preserve Haar measure),
which tends to `0` (`tendsto_levelResid`, from `Rigidity.Counting.tendsto_haarK_bad`). So `mixing_at_level` holds at every level,
and `mixing_K` in the limit.

**Models.** `finite_mixing` at `G = ZMod 2`, `S = {1}`, `c = 1` (a spec example). `mixing_K`'s hypotheses hold with `B = ∅` at
every field; with `A, B` of positive measure they hold at a thick field exactly when the sets are spread over different cosets at
every level, as the slice's colour fibres are at the edges the selection reads.
-/

namespace HadwigerNelson.Collapse

open SpectralChain NumberField Rigidity Rigidity.Counting MeasureTheory Filter Topology

noncomputable section

/-! ## The finite-group mixing inequality -/

/-- **The expander mixing inequality on a finite abelian group, two-sided, for `[0, 1]`-valued functions**: if every
non-trivial character sums over `S` to at most `c·|S|` in modulus, then for `f, g : G → [0, 1]` of means `a, b`,
`E_x f(x)·E_{s ∈ S} g(x + s) ≥ ab − c·√(a(1 − a))·√(b(1 − b))`. Route: expand in characters (orthogonality,
`AddChar.sum_apply_eq_ite`); the trivial character gives `ab`; the others are bounded by `c` times Cauchy–Schwarz over the
non-trivial Fourier coefficients, whose squares sum to `E f² − a² ≤ a − a²` (Parseval, as in `RatioBound.sum_fourier_sq`). -/
theorem finite_mixing {G : Type*} [AddCommGroup G] [Fintype G] [DecidableEq G] (S : Finset G) (hS : S.Nonempty)
    {c : ℝ} (hc : 0 ≤ c) (hchar : ∀ ψ : AddChar G ℂ, ψ ≠ 1 → ‖∑ s ∈ S, ψ s‖ ≤ c * S.card)
    (f g : G → ℝ) (hf0 : ∀ x, 0 ≤ f x) (hf1 : ∀ x, f x ≤ 1) (hg0 : ∀ x, 0 ≤ g x) (hg1 : ∀ x, g x ≤ 1) {a b : ℝ}
    (ha : ∑ x, f x = a * Fintype.card G) (hb : ∑ x, g x = b * Fintype.card G) :
    a * b - c * Real.sqrt (a * (1 - a)) * Real.sqrt (b * (1 - b)) ≤
      (∑ x, f x * ∑ s ∈ S, g (x + s)) / (S.card * Fintype.card G) := by
  sorry

/-! ## The levels of the completion -/

variable (F : Subfield ℝ) [NumberField F]

/-- **The level-`k` fill of `A` at `x`**: the Haar fraction of the level-`k` coset of `x` that `A` occupies — `E_k 1_A`. -/
def levelFill (A : Set (K F)) (k : ℕ) (x : K F) : ℝ :=
  (haarK F (A ∩ proj F k ⁻¹' {proj F k x})).toReal / (haarK F (proj F k ⁻¹' {proj F k x})).toReal

/-- **The level-`k` residual of `A`**: `‖1_A − E_k 1_A‖₂²`. -/
def levelResid (A : Set (K F)) (k : ℕ) : ℝ :=
  ∫ x, (A.indicator (fun _ => (1 : ℝ)) x - levelFill F A k x) ^ 2 ∂haarK F

variable {F}

/-- The residual is non-negative. -/
theorem levelResid_nonneg (A : Set (K F)) (k : ℕ) : 0 ≤ levelResid F A k :=
  integral_nonneg fun _ => sq_nonneg _

/-- **The residual tends to `0`** (the martingale convergence the selection needs, from density along cosets): with
`∫_{Aᶜ} E_k 1_A = ∫_A (1 − E_k 1_A)`, the residual is at most `2∫_A (1 − E_k 1_A)`, which is at most `2κ` plus twice the
Haar measure of the points of `A` whose coset `A` fills to at most `1 − κ` — and that tends to `0`
(`Rigidity.Counting.tendsto_haarK_bad`). -/
theorem tendsto_levelResid {A : Set (K F)} (hA : MeasurableSet A) : Tendsto (levelResid F A) atTop (𝓝 0) := by
  sorry

/-- **The mixing inequality at level `k`**: over a uniformly `c`-thick field, two measurable sets with null edges across every
unit vector satisfy `ab − c√(a(1 − a))√(b(1 − b)) ≤ √(levelResid A k)·√(levelResid B k)`. Route: average the null edge
integrals over representatives `u_s ∈ U` of the level's connection set; split `1_A = E_k 1_A + (1_A − E_k 1_A)` and likewise
`1_B`; the cross terms vanish (`E_k` commutes with translations); the first term is `finite_mixing` on `LevImg F k` with
`levelThick` (coset measures `1/|LevImg F k|`, `Rigidity.Counting.haarK_proj_preimage`; `0 ≤ E_k 1_A ≤ 1`); the last is bounded
by Cauchy–Schwarz. -/
theorem mixing_at_level {c : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c) (hc : c < 1) {k : ℕ} (hk : 1 ≤ k) {A B : Set (K F)}
    (hA : MeasurableSet A) (hB : MeasurableSet B)
    (hnull : ∀ u ∈ unitVectorsR F, haarK F (A ∩ (fun x => x + ιK F u) ⁻¹' B) = 0) :
    (haarK F A).toReal * (haarK F B).toReal -
        c * Real.sqrt ((haarK F A).toReal * (1 - (haarK F A).toReal)) *
          Real.sqrt ((haarK F B).toReal * (1 - (haarK F B).toReal)) ≤
      Real.sqrt (levelResid F A k) * Real.sqrt (levelResid F B k) := by
  sorry

/-- **The mixing inequality on `K`**: the levels' bound in the limit (`tendsto_levelResid` at `A` and at `B`). -/
theorem mixing_K {c : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c) (hc : c < 1) {A B : Set (K F)} (hA : MeasurableSet A)
    (hB : MeasurableSet B) (hnull : ∀ u ∈ unitVectorsR F, haarK F (A ∩ (fun x => x + ιK F u) ⁻¹' B) = 0) :
    (haarK F A).toReal * (haarK F B).toReal ≤
      c * Real.sqrt ((haarK F A).toReal * (1 - (haarK F A).toReal)) *
        Real.sqrt ((haarK F B).toReal * (1 - (haarK F B).toReal)) := by
  have hlim : Tendsto (fun k => Real.sqrt (levelResid F A k) * Real.sqrt (levelResid F B k)) atTop (𝓝 0) := by
    have h1 := ((Real.continuous_sqrt.tendsto 0).comp (tendsto_levelResid hA)).mul
      ((Real.continuous_sqrt.tendsto 0).comp (tendsto_levelResid hB))
    simpa using h1
  have hle : ∀ᶠ k in atTop, (haarK F A).toReal * (haarK F B).toReal -
      c * Real.sqrt ((haarK F A).toReal * (1 - (haarK F A).toReal)) *
        Real.sqrt ((haarK F B).toReal * (1 - (haarK F B).toReal)) ≤
      Real.sqrt (levelResid F A k) * Real.sqrt (levelResid F B k) :=
    eventually_atTop.2 ⟨1, fun k hk => mixing_at_level hT hc0 hc hk hA hB hnull⟩
  have h0 := ge_of_tendsto hlim hle
  linarith

/-- **Two large sets cannot have null edges**: if `a, b ≥ θ > c/(1 + c)`, the mixing inequality fails — the form the selection
reads. -/
theorem not_both_ge_of_mixing {c θ a b : ℝ} (hc0 : 0 ≤ c) (hθ : c / (1 + c) < θ) (ha : θ ≤ a) (hb : θ ≤ b) (ha1 : a ≤ 1)
    (hb1 : b ≤ 1) : ¬ a * b ≤ c * Real.sqrt (a * (1 - a)) * Real.sqrt (b * (1 - b)) := by
  sorry

/-! ## Spec -/

-- the threshold arithmetic the selection reads: at `c = 1/5`, `θ = 1/5` exceeds `c/(1 + c) = 1/6`, and two masses of `1/5`
-- violate the inequality (`1/25 > (1/5)·(4/25)`).
example : ¬ (1 / 5 : ℝ) * (1 / 5) ≤ 1 / 5 * Real.sqrt (1 / 5 * (1 - 1 / 5)) * Real.sqrt (1 / 5 * (1 - 1 / 5)) :=
  not_both_ge_of_mixing (by norm_num) (by norm_num) le_rfl le_rfl (by norm_num) (by norm_num)

end

end HadwigerNelson.Collapse
