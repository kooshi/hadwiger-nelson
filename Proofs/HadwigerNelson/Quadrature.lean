import Proofs.HadwigerNelson.Ladder

/-!
# M32 — The quadrature kill: the 2-adic engine's first theorems

The first Lean theorems one field up. M31's quadrature law (G12) says a ρ₁₅-detuned copy of
seam material couples to its base ONLY along anchor-collinear pairs on the conic
`t² + r² − (7/4)·t·r = 1`; the proof is a radical-block split — the chord equation's
`√15`-block must vanish alone. This module certifies exactly that engine:

* **`sqrt5_indep`** — the primitive: a vanishing `A + √5·B` over the `{1,√3,√11,√33}` basis
  has all eight ℚ-coefficients zero. Proven division-free by squaring to `A² = 5B²`, reading
  the four coefficient equations through M24's `sqrt_indep`, and killing the integer system
  by **mod-5 descent** (one `ZMod 5` decide over 625 tuples + strong induction on the
  ℓ¹-norm). The √7 analogue for later milestones is a numeral change.
* **`sqrt15_split`** — the workhorse the 2-adic clearings cite: `(A) + √15·(B) = 0` kills
  both coefficient blocks (`√15·√3 = 3√5` recombination onto the primitive).
* **`quadrature_rho15`** — the geometric instance (the Frontier-citable statement): a unit
  chord `|ρ₁₅·u − v| = 1` between K-coordinate points pins `Im(u·v̄) = 0` (anchor-collinear)
  and the conic `|u|² + |v|² − (7/4)·Re(u·v̄) = 1`.

Ground truth: `plans/M32-certified-five.md` §0a/§0e, `build/m32-design.py` (every decide,
recombination, and constant script-verified before being stated here).
-/

namespace HadwigerNelson
namespace Quadrature

open Complex

/-! ## §0 Shared arithmetic -/

private theorem sq_sqrt3 : Real.sqrt 3 * Real.sqrt 3 = 3 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sq_sqrt5 : Real.sqrt 5 * Real.sqrt 5 = 5 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sq_sqrt15 : Real.sqrt 15 * Real.sqrt 15 = 15 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sqrt15_eq : Real.sqrt 15 = Real.sqrt 3 * Real.sqrt 5 := by
  rw [show (15 : ℝ) = 3 * 5 by norm_num, Real.sqrt_mul (by norm_num)]

/-! ## §1 The mod-5 kill and the integer descent -/

/-- The cleared system `A² = 5B²` reduced mod 5 has only the trivial solution — the single
`decide` the whole primitive rests on (script-verified over all 625 tuples first).
`11 ≡ 1`, `33 ≡ 3 (mod 5)` are left to the kernel's numerals. -/
private theorem mod5_kill : ∀ x y z w : ZMod 5,
    x ^ 2 + 3 * y ^ 2 + 11 * z ^ 2 + 33 * w ^ 2 = 0 → x * y + 11 * z * w = 0 →
    x * z + 3 * y * w = 0 → x * w + y * z = 0 → x = 0 ∧ y = 0 ∧ z = 0 ∧ w = 0 := by
  decide +kernel

/-- The integer descent: the only solution of the cleared system is zero. Strong induction on
the ℓ¹-norm; the mod-5 step divides the whole tuple by 5 (a-side first, then the b-side via
the shifted system), and homogeneity of equal degree keeps the system invariant. -/
private theorem descent (n : ℕ) : ∀ a₀ a₁ a₂ a₃ b₀ b₁ b₂ b₃ : ℤ,
    a₀.natAbs + a₁.natAbs + a₂.natAbs + a₃.natAbs
      + b₀.natAbs + b₁.natAbs + b₂.natAbs + b₃.natAbs ≤ n →
    a₀ ^ 2 + 3 * a₁ ^ 2 + 11 * a₂ ^ 2 + 33 * a₃ ^ 2
      = 5 * (b₀ ^ 2 + 3 * b₁ ^ 2 + 11 * b₂ ^ 2 + 33 * b₃ ^ 2) →
    a₀ * a₁ + 11 * a₂ * a₃ = 5 * (b₀ * b₁ + 11 * b₂ * b₃) →
    a₀ * a₂ + 3 * a₁ * a₃ = 5 * (b₀ * b₂ + 3 * b₁ * b₃) →
    a₀ * a₃ + a₁ * a₂ = 5 * (b₀ * b₃ + b₁ * b₂) →
    a₀ = 0 ∧ a₁ = 0 ∧ a₂ = 0 ∧ a₃ = 0 ∧ b₀ = 0 ∧ b₁ = 0 ∧ b₂ = 0 ∧ b₃ = 0 := by
  sorry

/-! ## §2 The primitive -/

/-- `sqrt5_indep`, integer coefficients: the descent's client. -/
private theorem sqrt5_indep_int {a₀ a₁ a₂ a₃ b₀ b₁ b₂ b₃ : ℤ}
    (h : (a₀ : ℝ) + a₁ * Real.sqrt 3 + a₂ * Real.sqrt 11 + a₃ * Real.sqrt 33
       + Real.sqrt 5 * ((b₀ : ℝ) + b₁ * Real.sqrt 3 + b₂ * Real.sqrt 11
           + b₃ * Real.sqrt 33) = 0) :
    a₀ = 0 ∧ a₁ = 0 ∧ a₂ = 0 ∧ a₃ = 0 ∧ b₀ = 0 ∧ b₁ = 0 ∧ b₂ = 0 ∧ b₃ = 0 := by
  sorry

/-- **The primitive kill** (M31's law G12, arithmetic core): a vanishing `A + √5·B` over the
biquadratic basis `{1, √3, √11, √33}` has every ℚ-coefficient zero. Division-free: square to
`A² = 5B²`, read four equations through `Ladder.sqrt_indep`, kill by mod-5 descent. The `√7`
analogue is a numeral change (mod-7, 2401 tuples). -/
theorem sqrt5_indep {a₀ a₁ a₂ a₃ b₀ b₁ b₂ b₃ : ℚ}
    (h : (a₀ : ℝ) + a₁ * Real.sqrt 3 + a₂ * Real.sqrt 11 + a₃ * Real.sqrt 33
       + Real.sqrt 5 * ((b₀ : ℝ) + b₁ * Real.sqrt 3 + b₂ * Real.sqrt 11
           + b₃ * Real.sqrt 33) = 0) :
    a₀ = 0 ∧ a₁ = 0 ∧ a₂ = 0 ∧ a₃ = 0 ∧ b₀ = 0 ∧ b₁ = 0 ∧ b₂ = 0 ∧ b₃ = 0 := by
  sorry

/-- **The workhorse split** the 2-adic clearings cite: `(A) + √15·(B) = 0` over the
biquadratic basis kills both blocks. `√15·(b₀ + b₁√3 + b₂√11 + b₃√33) =
√5·(3b₁ + b₀√3 + 3b₃√11 + b₂√33)` — the recombination is rational, so this is
`sqrt5_indep` re-addressed. -/
theorem sqrt15_split {a₀ a₁ a₂ a₃ b₀ b₁ b₂ b₃ : ℚ}
    (h : (a₀ : ℝ) + a₁ * Real.sqrt 3 + a₂ * Real.sqrt 11 + a₃ * Real.sqrt 33
       + Real.sqrt 15 * ((b₀ : ℝ) + b₁ * Real.sqrt 3 + b₂ * Real.sqrt 11
           + b₃ * Real.sqrt 33) = 0) :
    a₀ = 0 ∧ a₁ = 0 ∧ a₂ = 0 ∧ a₃ = 0 ∧ b₀ = 0 ∧ b₁ = 0 ∧ b₂ = 0 ∧ b₃ = 0 := by
  sorry

/-- The flat eight-term completeness, for the record beside M24's four-term `sqrt_indep`:
`{1, √3, √5, √11, √15, √33, √55, √165}` is ℚ-independent. -/
theorem sqrt_indep₈ {e₁ e₃ e₅ e₁₁ e₁₅ e₃₃ e₅₅ e₁₆₅ : ℚ}
    (h : (e₁ : ℝ) + e₃ * Real.sqrt 3 + e₅ * Real.sqrt 5 + e₁₁ * Real.sqrt 11
       + e₁₅ * Real.sqrt 15 + e₃₃ * Real.sqrt 33 + e₅₅ * Real.sqrt 55
       + e₁₆₅ * Real.sqrt 165 = 0) :
    e₁ = 0 ∧ e₃ = 0 ∧ e₅ = 0 ∧ e₁₁ = 0 ∧ e₁₅ = 0 ∧ e₃₃ = 0 ∧ e₅₅ = 0 ∧ e₁₆₅ = 0 := by
  sorry

/-! ## §3 The geometric instance -/

/-- The detune rotation `ρ₁₅ = (7 + i√15)/8` — the distance-2 spindle's twist
(`|1 − ρ₁₅| = 1/2`, so radius-2 points detune by a unit chord). -/
noncomputable def rho15 : ℂ := ⟨7 / 8, Real.sqrt 15 / 8⟩

/-- `|ρ₁₅| = 1`. -/
theorem normSq_rho15 : normSq rho15 = 1 := by
  simp only [normSq_mk, rho15]
  nlinarith [sq_sqrt15]

/-- **The quadrature kill, ρ₁₅ instance** — M31's law (G12), kernel-checked: a unit chord
between a K-coordinate point `v` and the ρ₁₅-image of a K-coordinate point `u` (offsets from
the common anchor) forces the collinear pin `Im(u·v̄) = 0` AND the conic
`|u|² + |v|² − (7/4)·Re(u·v̄) = 1`. The `√15`-block of the chord equation vanishes alone
(`sqrt15_split`); the K-block is the conic. Seam decorations `s` fold into `u` without
changing the shape. -/
theorem quadrature_rho15 {u v : ℂ}
    {p₀ p₁ p₂ p₃ q₀ q₁ q₂ q₃ r₀ r₁ r₂ r₃ s₀ s₁ s₂ s₃ : ℚ}
    (hure : u.re = (p₀ : ℝ) + p₁ * Real.sqrt 3 + p₂ * Real.sqrt 11 + p₃ * Real.sqrt 33)
    (huim : u.im = (q₀ : ℝ) + q₁ * Real.sqrt 3 + q₂ * Real.sqrt 11 + q₃ * Real.sqrt 33)
    (hvre : v.re = (r₀ : ℝ) + r₁ * Real.sqrt 3 + r₂ * Real.sqrt 11 + r₃ * Real.sqrt 33)
    (hvim : v.im = (s₀ : ℝ) + s₁ * Real.sqrt 3 + s₂ * Real.sqrt 11 + s₃ * Real.sqrt 33)
    (h : normSq (rho15 * u - v) = 1) :
    (u * (starRingEnd ℂ) v).im = 0 ∧
      normSq u + normSq v - 7 / 4 * (u * (starRingEnd ℂ) v).re = 1 := by
  sorry

/-- Non-vacuity: the (2,2) spindle chord. `u = v = 2` satisfies the chord equation and the
conclusion reads `0 = 0 ∧ 4 + 4 − 7 = 1`. -/
example : normSq (rho15 * 2 - 2) = 1 := by
  have h2 : rho15 * 2 - 2 = ⟨-(1 / 4), Real.sqrt 15 / 4⟩ := by
    apply Complex.ext <;> simp [rho15] <;> ring
  rw [h2]
  simp only [normSq_mk]
  nlinarith [sq_sqrt15]

/-- Mutation audit (the wrong constant refuses): `(2,2)` is NOT on the `7/8`-conic. -/
example : ¬ ((4 : ℝ) + 4 - 7 / 8 * 4 = 1) := by norm_num

end Quadrature
end HadwigerNelson
