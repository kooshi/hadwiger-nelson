import Proofs.HadwigerNelson.Arith.FibreCert3
import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

/-!
# What an accepted fibre-density certificate proves (FS131-KC13; skeleton)

**Read aloud, against FS-66's `SOUNDNESS.md` § 0 and L4.** `sum_le_of_certOK`: if `certOK C = true`, then every
`φ : (ℤ/p)² → [0, 1]` with `q(φ) ≥ 0` has `Σ φ ≤ U_num / L`. Here
`q(φ) = 2·Σ_x φ_x (1 − φ_x) − Σ_x Σ_{s ∈ S} φ_x φ_{x+s}` and `S = {a² + b² = 1}`. It is the polynomial statement only.
L1 and L2, which carry it to every level of the tower, are leaves of their own (`plans/FS131-KC13-certificates.md`
§ Stage 5). `p` need not be prime: the averaging argument uses only that `z ↦ s z` and `z ↦ s z̄` with `N(s) = 1` are
bijections of `(ℤ/p)²` preserving `S`.

`card_le_of_certOK` is level one: an independent set of `Cay((ℤ/p)², S)` has at most `U_num / L` points (`φ` its
indicator, `q(φ) = 0`).

**Model.** `model`: the hypotheses hold together at `cert3` (`cert3_ok`) with `φ = 0`. Every clause is satisfiable there;
`φ = 0` is a point of the region, and the conclusion `0 ≤ U` is then true.
-/

namespace HadwigerNelson.FibreCertSound

open HadwigerNelson.FibreCert

/-- The plane `(ℤ/p)²`. -/
abbrev V (p : ℕ) := ZMod p × ZMod p

/-- The unit circle `{(a, b) : a² + b² = 1}`. -/
def unitCircle (p : ℕ) [NeZero p] : Finset (V p) := Finset.univ.filter fun x => x.1 ^ 2 + x.2 ^ 2 = 1

/-- FS-66's quadratic `q(φ) = 2·Σ_x φ_x (1 − φ_x) − Σ_x Σ_{s ∈ S} φ_x φ_{x+s}` (`SOUNDNESS.md` § 0). -/
noncomputable def qform (p : ℕ) [NeZero p] (φ : V p → ℝ) : ℝ :=
  2 * ∑ x, φ x * (1 - φ x) - ∑ x, ∑ s ∈ unitCircle p, φ x * φ (x + s)

/-- **An accepted certificate bounds the fibre-density region** (`SOUNDNESS.md` L4): `Σ φ ≤ U_num / L` for every
`φ ∈ [0, 1]^V` with `q(φ) ≥ 0`. The plan of its proof is `plans/FS131-KC13-certificates.md` § 5.2. -/
theorem sum_le_of_certOK (C : Cert) [NeZero C.p] (hC : certOK C = true) (φ : V C.p → ℝ)
    (h0 : ∀ x, 0 ≤ φ x) (h1 : ∀ x, φ x ≤ 1) (hq : 0 ≤ qform C.p φ) :
    ∑ x, φ x ≤ (C.unum : ℝ) / C.scale := by
  sorry

/-- **Level one**: an independent set of `Cay((ℤ/p)², S)` has at most `U_num / L` points. -/
theorem card_le_of_certOK (C : Cert) [NeZero C.p] (hC : certOK C = true) (I : Finset (V C.p))
    (hI : ∀ x ∈ I, ∀ y ∈ I, y - x ∉ unitCircle C.p) : (I.card : ℝ) ≤ (C.unum : ℝ) / C.scale := by
  sorry

/-- The hypotheses of `sum_le_of_certOK` hold together at `cert3`. -/
theorem model : certOK cert3 = true ∧
    ∃ φ : V 3 → ℝ, (∀ x, 0 ≤ φ x) ∧ (∀ x, φ x ≤ 1) ∧ 0 ≤ qform 3 φ :=
  ⟨cert3_ok, fun _ => 0, fun _ => le_rfl, fun _ => zero_le_one, by simp [qform]⟩

end HadwigerNelson.FibreCertSound
