import Proofs.HadwigerNelson.Plane.DensityBound.Bessel

/-!
# The ODE comparison lemma for the Bessel system (FS-131, FS131-KDB1; skeleton)

The kernel certifies `J₀` on an interval by any differentiable pair `p = (p₀, p₁)` whose **defect** against the Bessel
system `J₀′ = −J₁`, `J₁′ = J₀ − J₁/x` is small: the error `e = J − p` satisfies `e′ = A(x)e − δ` with
`⟨e, A(x)e⟩ = −e₁²/x ≤ 0` for `x > 0`, so `|e|` grows at most at rate `|δ|` — errors add, they never compound. This is
what lets one chain of polynomial cells run from `x = 0` to `x = 1833` with a final radius of `10⁻¹⁰`
(`data/fs131/kdb1/proto/`). At `a = 0` the hypothesis is only on the open interval, so the singular coefficient `1/x`
is harmless when `p₁(0) = 0`. Plan: `plans/FS131-KDB1-density-bound.md` § 3.
-/

namespace HadwigerNelson.DensityBound

open Real Set

/-- The Euclidean distance of `(J₀ x, J₁ x)` from `(u, v)`. -/
noncomputable def jdist (x u v : ℝ) : ℝ := Real.sqrt ((J0 x - u) ^ 2 + (J1 x - v) ^ 2)

/-- **The comparison lemma.** If `p₀, p₁` have derivatives `q₀, q₁` on `[a, b]` (`0 ≤ a`) and their defect
`|q₀ + p₁| + |q₁ − p₀ + p₁/x|` is at most `D` on `(a, b)`, then `|J(x) − p(x)| ≤ |J(a) − p(a)| + (x − a)D` on `[a, b]`. -/
theorem jdist_le_of_defect {a b D : ℝ} (ha : 0 ≤ a) {p0 p1 q0 q1 : ℝ → ℝ}
    (hp0 : ∀ x ∈ Icc a b, HasDerivAt p0 (q0 x) x) (hp1 : ∀ x ∈ Icc a b, HasDerivAt p1 (q1 x) x)
    (hδ : ∀ x ∈ Ioo a b, |q0 x + p1 x| + |q1 x - p0 x + p1 x / x| ≤ D) {x : ℝ} (hx : x ∈ Icc a b) :
    jdist x (p0 x) (p1 x) ≤ jdist a (p0 a) (p1 a) + (x - a) * D := by
  sorry

/-- `|J₀ x − u| ≤ jdist x u v`: a cell's bound on the pair bounds `J₀`. -/
theorem abs_J0_sub_le_jdist (x u v : ℝ) : |J0 x - u| ≤ jdist x u v := by
  sorry

/-- **The tail read off one state**: for `x ≥ a ≥ 0`, `|J₀ x| ≤ √(u² + v²) + jdist a u v` — the energy is antitone
(`antitoneOn_energy`) and the state `(u, v)` is within `jdist a u v` of `J(a)`. -/
theorem abs_J0_le_of_le {a x : ℝ} (ha : 0 ≤ a) (hax : a ≤ x) (u v : ℝ) :
    |J0 x| ≤ Real.sqrt (u ^ 2 + v ^ 2) + jdist a u v := by
  sorry

/-- **A model of the comparison lemma's hypotheses** with a nonzero defect: the constant pair `p = (1, 0)` on `[0, 1]`
has defect `|0 + 0| + |0 − 1 + 0| = 1`, so `D = 1`. -/
example : ∀ x ∈ Ioo (0 : ℝ) 1, |(0 : ℝ) + 0| + |(0 : ℝ) - 1 + 0 / x| ≤ 1 := by
  intro x _; norm_num

end HadwigerNelson.DensityBound
