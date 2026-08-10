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

private theorem sq_sqrt11 : Real.sqrt 11 * Real.sqrt 11 = 11 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sq_sqrt15 : Real.sqrt 15 * Real.sqrt 15 = 15 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sqrt15_eq : Real.sqrt 15 = Real.sqrt 3 * Real.sqrt 5 := by
  rw [show (15 : ℝ) = 3 * 5 by norm_num, Real.sqrt_mul (by norm_num)]

private theorem sqrt33_eq : Real.sqrt 33 = Real.sqrt 3 * Real.sqrt 11 := by
  rw [show (33 : ℝ) = 3 * 11 by norm_num, Real.sqrt_mul (by norm_num)]

/-! ## §1 The mod-5 kill and the integer descent -/

/-- The cleared system `A² = 5B²` reduced mod 5 has only the trivial solution — the single
`decide` the whole primitive rests on (script-verified over all 625 tuples first).
`11 ≡ 1`, `33 ≡ 3 (mod 5)` are left to the kernel's numerals. -/
private theorem mod5_kill : ∀ x y z w : ZMod 5,
    x ^ 2 + 3 * y ^ 2 + 11 * z ^ 2 + 33 * w ^ 2 = 0 → x * y + 11 * z * w = 0 →
    x * z + 3 * y * w = 0 → x * w + y * z = 0 → x = 0 ∧ y = 0 ∧ z = 0 ∧ w = 0 := by
  decide +kernel

/-- Reduce one integer equation of the cleared system to `ZMod 5` (the right side carries the
factor 5 and dies). -/
private theorem to_mod5 {L R : ℤ} (h : L = 5 * R) : (L : ZMod 5) = 0 := by
  have hc := congrArg (fun z : ℤ => (z : ZMod 5)) h
  push_cast at hc
  rw [hc, show ((5 : ZMod 5)) = 0 from by decide, zero_mul]

/-- Divide the carried factor 5 off an equation `25·S = 5·T`, i.e. `T = 5·S`. -/
private theorem shift5 {S T : ℤ} (h : (5 : ℤ) * (5 * S) = 5 * T) : T = 5 * S :=
  (mul_left_cancel₀ (by norm_num : (5 : ℤ) ≠ 0) h).symm

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
  induction n using Nat.strong_induction_on with
  | _ n ih =>
  intro a₀ a₁ a₂ a₃ b₀ b₁ b₂ b₃ hn h0 h1 h2 h3
  -- the a-side dies mod 5
  have m0 := to_mod5 h0
  have m1 := to_mod5 h1
  have m2 := to_mod5 h2
  have m3 := to_mod5 h3
  push_cast at m0 m1 m2 m3
  obtain ⟨z0, z1, z2, z3⟩ := mod5_kill _ _ _ _ m0 m1 m2 m3
  obtain ⟨a₀', rfl⟩ := (ZMod.intCast_zmod_eq_zero_iff_dvd a₀ 5).mp z0
  obtain ⟨a₁', rfl⟩ := (ZMod.intCast_zmod_eq_zero_iff_dvd a₁ 5).mp z1
  obtain ⟨a₂', rfl⟩ := (ZMod.intCast_zmod_eq_zero_iff_dvd a₂ 5).mp z2
  obtain ⟨a₃', rfl⟩ := (ZMod.intCast_zmod_eq_zero_iff_dvd a₃ 5).mp z3
  push_cast at h0 h1 h2 h3 hn
  -- the shifted system: the b-side now carries the factor 5
  have h0' : b₀ ^ 2 + 3 * b₁ ^ 2 + 11 * b₂ ^ 2 + 33 * b₃ ^ 2
      = 5 * (a₀' ^ 2 + 3 * a₁' ^ 2 + 11 * a₂' ^ 2 + 33 * a₃' ^ 2) :=
    shift5 (by linear_combination h0)
  have h1' : b₀ * b₁ + 11 * b₂ * b₃ = 5 * (a₀' * a₁' + 11 * a₂' * a₃') :=
    shift5 (by linear_combination h1)
  have h2' : b₀ * b₂ + 3 * b₁ * b₃ = 5 * (a₀' * a₂' + 3 * a₁' * a₃') :=
    shift5 (by linear_combination h2)
  have h3' : b₀ * b₃ + b₁ * b₂ = 5 * (a₀' * a₃' + a₁' * a₂') :=
    shift5 (by linear_combination h3)
  -- the b-side dies mod 5
  have n0 := to_mod5 h0'
  have n1 := to_mod5 h1'
  have n2 := to_mod5 h2'
  have n3 := to_mod5 h3'
  push_cast at n0 n1 n2 n3
  obtain ⟨w0, w1, w2, w3⟩ := mod5_kill _ _ _ _ n0 n1 n2 n3
  obtain ⟨b₀', rfl⟩ := (ZMod.intCast_zmod_eq_zero_iff_dvd b₀ 5).mp w0
  obtain ⟨b₁', rfl⟩ := (ZMod.intCast_zmod_eq_zero_iff_dvd b₁ 5).mp w1
  obtain ⟨b₂', rfl⟩ := (ZMod.intCast_zmod_eq_zero_iff_dvd b₂ 5).mp w2
  obtain ⟨b₃', rfl⟩ := (ZMod.intCast_zmod_eq_zero_iff_dvd b₃ 5).mp w3
  push_cast at h0' h1' h2' h3' hn
  -- the primed tuple satisfies the same system (equal-degree homogeneity)
  have H0 : a₀' ^ 2 + 3 * a₁' ^ 2 + 11 * a₂' ^ 2 + 33 * a₃' ^ 2
      = 5 * (b₀' ^ 2 + 3 * b₁' ^ 2 + 11 * b₂' ^ 2 + 33 * b₃' ^ 2) :=
    shift5 (by linear_combination h0')
  have H1 : a₀' * a₁' + 11 * a₂' * a₃' = 5 * (b₀' * b₁' + 11 * b₂' * b₃') :=
    shift5 (by linear_combination h1')
  have H2 : a₀' * a₂' + 3 * a₁' * a₃' = 5 * (b₀' * b₂' + 3 * b₁' * b₃') :=
    shift5 (by linear_combination h2')
  have H3 : a₀' * a₃' + a₁' * a₂' = 5 * (b₀' * b₃' + b₁' * b₂') :=
    shift5 (by linear_combination h3')
  -- the ℓ¹ measure drops by the factor 5
  simp only [Int.natAbs_mul, show (5 : ℤ).natAbs = 5 from rfl] at hn
  by_cases hS : a₀'.natAbs + a₁'.natAbs + a₂'.natAbs + a₃'.natAbs
      + b₀'.natAbs + b₁'.natAbs + b₂'.natAbs + b₃'.natAbs = 0
  · have e0 : a₀' = 0 := Int.natAbs_eq_zero.mp (by omega)
    have e1 : a₁' = 0 := Int.natAbs_eq_zero.mp (by omega)
    have e2 : a₂' = 0 := Int.natAbs_eq_zero.mp (by omega)
    have e3 : a₃' = 0 := Int.natAbs_eq_zero.mp (by omega)
    have f0 : b₀' = 0 := Int.natAbs_eq_zero.mp (by omega)
    have f1 : b₁' = 0 := Int.natAbs_eq_zero.mp (by omega)
    have f2 : b₂' = 0 := Int.natAbs_eq_zero.mp (by omega)
    have f3 : b₃' = 0 := Int.natAbs_eq_zero.mp (by omega)
    subst e0 e1 e2 e3 f0 f1 f2 f3
    norm_num
  · have hlt : a₀'.natAbs + a₁'.natAbs + a₂'.natAbs + a₃'.natAbs
        + b₀'.natAbs + b₁'.natAbs + b₂'.natAbs + b₃'.natAbs < n := by omega
    obtain ⟨e0, e1, e2, e3, f0, f1, f2, f3⟩ :=
      ih _ hlt a₀' a₁' a₂' a₃' b₀' b₁' b₂' b₃' (le_refl _) H0 H1 H2 H3
    subst e0 e1 e2 e3 f0 f1 f2 f3
    norm_num

/-! ## §2 The primitive -/

/-- `sqrt5_indep`, integer coefficients: the descent's client. -/
private theorem sqrt5_indep_int {a₀ a₁ a₂ a₃ b₀ b₁ b₂ b₃ : ℤ}
    (h : (a₀ : ℝ) + a₁ * Real.sqrt 3 + a₂ * Real.sqrt 11 + a₃ * Real.sqrt 33
       + Real.sqrt 5 * ((b₀ : ℝ) + b₁ * Real.sqrt 3 + b₂ * Real.sqrt 11
           + b₃ * Real.sqrt 33) = 0) :
    a₀ = 0 ∧ a₁ = 0 ∧ a₂ = 0 ∧ a₃ = 0 ∧ b₀ = 0 ∧ b₁ = 0 ∧ b₂ = 0 ∧ b₃ = 0 := by
  have h33 : Real.sqrt 33 = Real.sqrt 3 * Real.sqrt 11 := by
    rw [show (33 : ℝ) = 3 * 11 by norm_num, Real.sqrt_mul (by norm_num)]
  rw [h33] at h
  -- square the relation: A = −√5·B gives A² = 5·B², division-free
  have hx : (a₀ : ℝ) + a₁ * Real.sqrt 3 + a₂ * Real.sqrt 11
      + a₃ * (Real.sqrt 3 * Real.sqrt 11)
      = -(Real.sqrt 5 * ((b₀ : ℝ) + b₁ * Real.sqrt 3 + b₂ * Real.sqrt 11
          + b₃ * (Real.sqrt 3 * Real.sqrt 11))) := by linarith
  have hsq : ((a₀ : ℝ) + a₁ * Real.sqrt 3 + a₂ * Real.sqrt 11
        + a₃ * (Real.sqrt 3 * Real.sqrt 11)) ^ 2
      = 5 * ((b₀ : ℝ) + b₁ * Real.sqrt 3 + b₂ * Real.sqrt 11
          + b₃ * (Real.sqrt 3 * Real.sqrt 11)) ^ 2 := by
    rw [hx]
    linear_combination ((b₀ : ℝ) + b₁ * Real.sqrt 3 + b₂ * Real.sqrt 11
        + b₃ * (Real.sqrt 3 * Real.sqrt 11)) ^ 2 * sq_sqrt5
  -- read the four coefficient equations through M24's independence
  have key : (((a₀ ^ 2 + 3 * a₁ ^ 2 + 11 * a₂ ^ 2 + 33 * a₃ ^ 2
          - 5 * (b₀ ^ 2 + 3 * b₁ ^ 2 + 11 * b₂ ^ 2 + 33 * b₃ ^ 2) : ℤ) : ℚ) : ℝ)
      + (((2 * (a₀ * a₁ + 11 * a₂ * a₃) - 10 * (b₀ * b₁ + 11 * b₂ * b₃) : ℤ) : ℚ) : ℝ)
          * Real.sqrt 3
      + (((2 * (a₀ * a₂ + 3 * a₁ * a₃) - 10 * (b₀ * b₂ + 3 * b₁ * b₃) : ℤ) : ℚ) : ℝ)
          * Real.sqrt 11
      + (((2 * (a₀ * a₃ + a₁ * a₂) - 10 * (b₀ * b₃ + b₁ * b₂) : ℤ) : ℚ) : ℝ)
          * Real.sqrt 33 = 0 := by
    rw [h33]
    push_cast
    linear_combination hsq
      + (-((a₁ : ℝ) ^ 2) - 11 * a₃ ^ 2 - 2 * a₁ * a₃ * Real.sqrt 11 + 5 * b₁ ^ 2
          + 55 * b₃ ^ 2 + 10 * b₁ * b₃ * Real.sqrt 11) * sq_sqrt3
      + (-((a₂ : ℝ) ^ 2) - a₃ ^ 2 * (Real.sqrt 3 * Real.sqrt 3)
          - 2 * a₂ * a₃ * Real.sqrt 3 + 5 * b₂ ^ 2
          + 5 * b₃ ^ 2 * (Real.sqrt 3 * Real.sqrt 3)
          + 10 * b₂ * b₃ * Real.sqrt 3) * sq_sqrt11
  obtain ⟨k1, k2, k3, k4⟩ := Ladder.sqrt_indep key
  have E0 : a₀ ^ 2 + 3 * a₁ ^ 2 + 11 * a₂ ^ 2 + 33 * a₃ ^ 2
      = 5 * (b₀ ^ 2 + 3 * b₁ ^ 2 + 11 * b₂ ^ 2 + 33 * b₃ ^ 2) := by
    have := k1
    exact_mod_cast sub_eq_zero.mp (by exact_mod_cast this)
  have E1 : a₀ * a₁ + 11 * a₂ * a₃ = 5 * (b₀ * b₁ + 11 * b₂ * b₃) := by
    have h2 : (2 * (a₀ * a₁ + 11 * a₂ * a₃) - 10 * (b₀ * b₁ + 11 * b₂ * b₃) : ℤ) = 0 := by
      exact_mod_cast k2
    linarith
  have E2 : a₀ * a₂ + 3 * a₁ * a₃ = 5 * (b₀ * b₂ + 3 * b₁ * b₃) := by
    have h2 : (2 * (a₀ * a₂ + 3 * a₁ * a₃) - 10 * (b₀ * b₂ + 3 * b₁ * b₃) : ℤ) = 0 := by
      exact_mod_cast k3
    linarith
  have E3 : a₀ * a₃ + a₁ * a₂ = 5 * (b₀ * b₃ + b₁ * b₂) := by
    have h2 : (2 * (a₀ * a₃ + a₁ * a₂) - 10 * (b₀ * b₃ + b₁ * b₂) : ℤ) = 0 := by
      exact_mod_cast k4
    linarith
  exact descent _ a₀ a₁ a₂ a₃ b₀ b₁ b₂ b₃ (le_refl _) E0 E1 E2 E3

/-- Scale a rational coefficient to an integer one: `(q : ℝ)·d = q.num·m` whenever
`d = q.den · m` in ℕ — the one denominator-clearing step, stated once. -/
private theorem coeff_clear {q : ℚ} {d m : ℕ} (hdm : d = q.den * m) :
    (q : ℝ) * (d : ℝ) = ((q.num * (m : ℤ) : ℤ) : ℝ) := by
  have hden : ((q.den : ℚ)) ≠ 0 := by exact_mod_cast q.den_nz
  have h1 : q * (q.den : ℚ) = ((q.num : ℤ) : ℚ) := by
    have hnd : ((q.num : ℚ)) / ((q.den : ℚ)) = q := Rat.num_div_den q
    field_simp at hnd
    linarith [hnd]
  have hq : q * (q.den : ℚ) * (m : ℚ) = ((q.num * (m : ℤ) : ℤ) : ℚ) := by
    rw [h1]; push_cast; ring
  calc (q : ℝ) * (d : ℝ)
      = ((q * (q.den : ℚ) * (m : ℚ) : ℚ) : ℝ) := by subst hdm; push_cast; ring
    _ = _ := by rw [hq]; norm_cast

/-- A rational whose numerator times a nonzero natural vanishes is zero. -/
private theorem num_mul_nat_zero {q : ℚ} {m : ℕ} (hm : m ≠ 0)
    (h : q.num * (m : ℤ) = 0) : q = 0 := by
  rcases mul_eq_zero.mp h with hz | hz
  · exact Rat.num_eq_zero.mp hz
  · exact absurd hz (by exact_mod_cast hm)

/-- **The primitive kill** (M31's law G12, arithmetic core): a vanishing `A + √5·B` over the
biquadratic basis `{1, √3, √11, √33}` has every ℚ-coefficient zero. Division-free: square to
`A² = 5B²`, read four equations through `Ladder.sqrt_indep`, kill by mod-5 descent. The `√7`
analogue is a numeral change (mod-7, 2401 tuples). -/
theorem sqrt5_indep {a₀ a₁ a₂ a₃ b₀ b₁ b₂ b₃ : ℚ}
    (h : (a₀ : ℝ) + a₁ * Real.sqrt 3 + a₂ * Real.sqrt 11 + a₃ * Real.sqrt 33
       + Real.sqrt 5 * ((b₀ : ℝ) + b₁ * Real.sqrt 3 + b₂ * Real.sqrt 11
           + b₃ * Real.sqrt 33) = 0) :
    a₀ = 0 ∧ a₁ = 0 ∧ a₂ = 0 ∧ a₃ = 0 ∧ b₀ = 0 ∧ b₁ = 0 ∧ b₂ = 0 ∧ b₃ = 0 := by
  have c0 := coeff_clear (q := a₀)
    (d := a₀.den * a₁.den * a₂.den * a₃.den * b₀.den * b₁.den * b₂.den * b₃.den)
    (m := a₁.den * a₂.den * a₃.den * b₀.den * b₁.den * b₂.den * b₃.den) (by ring)
  have c1 := coeff_clear (q := a₁)
    (d := a₀.den * a₁.den * a₂.den * a₃.den * b₀.den * b₁.den * b₂.den * b₃.den)
    (m := a₀.den * a₂.den * a₃.den * b₀.den * b₁.den * b₂.den * b₃.den) (by ring)
  have c2 := coeff_clear (q := a₂)
    (d := a₀.den * a₁.den * a₂.den * a₃.den * b₀.den * b₁.den * b₂.den * b₃.den)
    (m := a₀.den * a₁.den * a₃.den * b₀.den * b₁.den * b₂.den * b₃.den) (by ring)
  have c3 := coeff_clear (q := a₃)
    (d := a₀.den * a₁.den * a₂.den * a₃.den * b₀.den * b₁.den * b₂.den * b₃.den)
    (m := a₀.den * a₁.den * a₂.den * b₀.den * b₁.den * b₂.den * b₃.den) (by ring)
  have c4 := coeff_clear (q := b₀)
    (d := a₀.den * a₁.den * a₂.den * a₃.den * b₀.den * b₁.den * b₂.den * b₃.den)
    (m := a₀.den * a₁.den * a₂.den * a₃.den * b₁.den * b₂.den * b₃.den) (by ring)
  have c5 := coeff_clear (q := b₁)
    (d := a₀.den * a₁.den * a₂.den * a₃.den * b₀.den * b₁.den * b₂.den * b₃.den)
    (m := a₀.den * a₁.den * a₂.den * a₃.den * b₀.den * b₂.den * b₃.den) (by ring)
  have c6 := coeff_clear (q := b₂)
    (d := a₀.den * a₁.den * a₂.den * a₃.den * b₀.den * b₁.den * b₂.den * b₃.den)
    (m := a₀.den * a₁.den * a₂.den * a₃.den * b₀.den * b₁.den * b₃.den) (by ring)
  have c7 := coeff_clear (q := b₃)
    (d := a₀.den * a₁.den * a₂.den * a₃.den * b₀.den * b₁.den * b₂.den * b₃.den)
    (m := a₀.den * a₁.den * a₂.den * a₃.den * b₀.den * b₁.den * b₂.den) (by ring)
  have h5 := congrArg (fun x : ℝ =>
    x * ((a₀.den * a₁.den * a₂.den * a₃.den * b₀.den * b₁.den * b₂.den * b₃.den : ℕ) : ℝ)) h
  simp only [zero_mul] at h5
  have h' : ((a₀.num * (a₁.den * a₂.den * a₃.den * b₀.den * b₁.den * b₂.den * b₃.den : ℕ)
        : ℤ) : ℝ)
      + ((a₁.num * (a₀.den * a₂.den * a₃.den * b₀.den * b₁.den * b₂.den * b₃.den : ℕ)
          : ℤ) : ℝ) * Real.sqrt 3
      + ((a₂.num * (a₀.den * a₁.den * a₃.den * b₀.den * b₁.den * b₂.den * b₃.den : ℕ)
          : ℤ) : ℝ) * Real.sqrt 11
      + ((a₃.num * (a₀.den * a₁.den * a₂.den * b₀.den * b₁.den * b₂.den * b₃.den : ℕ)
          : ℤ) : ℝ) * Real.sqrt 33
      + Real.sqrt 5 * (((b₀.num * (a₀.den * a₁.den * a₂.den * a₃.den * b₁.den * b₂.den
            * b₃.den : ℕ) : ℤ) : ℝ)
        + ((b₁.num * (a₀.den * a₁.den * a₂.den * a₃.den * b₀.den * b₂.den * b₃.den : ℕ)
            : ℤ) : ℝ) * Real.sqrt 3
        + ((b₂.num * (a₀.den * a₁.den * a₂.den * a₃.den * b₀.den * b₁.den * b₃.den : ℕ)
            : ℤ) : ℝ) * Real.sqrt 11
        + ((b₃.num * (a₀.den * a₁.den * a₂.den * a₃.den * b₀.den * b₁.den * b₂.den : ℕ)
            : ℤ) : ℝ) * Real.sqrt 33) = 0 := by
    rw [← c0, ← c1, ← c2, ← c3, ← c4, ← c5, ← c6, ← c7]
    linear_combination h5
  obtain ⟨z0, z1, z2, z3, w0, w1, w2, w3⟩ := sqrt5_indep_int h'
  exact ⟨num_mul_nat_zero (Nat.mul_ne_zero (Nat.mul_ne_zero (Nat.mul_ne_zero
          (Nat.mul_ne_zero (Nat.mul_ne_zero (Nat.mul_ne_zero a₁.den_nz a₂.den_nz)
            a₃.den_nz) b₀.den_nz) b₁.den_nz) b₂.den_nz) b₃.den_nz) z0,
        num_mul_nat_zero (Nat.mul_ne_zero (Nat.mul_ne_zero (Nat.mul_ne_zero
          (Nat.mul_ne_zero (Nat.mul_ne_zero (Nat.mul_ne_zero a₀.den_nz a₂.den_nz)
            a₃.den_nz) b₀.den_nz) b₁.den_nz) b₂.den_nz) b₃.den_nz) z1,
        num_mul_nat_zero (Nat.mul_ne_zero (Nat.mul_ne_zero (Nat.mul_ne_zero
          (Nat.mul_ne_zero (Nat.mul_ne_zero (Nat.mul_ne_zero a₀.den_nz a₁.den_nz)
            a₃.den_nz) b₀.den_nz) b₁.den_nz) b₂.den_nz) b₃.den_nz) z2,
        num_mul_nat_zero (Nat.mul_ne_zero (Nat.mul_ne_zero (Nat.mul_ne_zero
          (Nat.mul_ne_zero (Nat.mul_ne_zero (Nat.mul_ne_zero a₀.den_nz a₁.den_nz)
            a₂.den_nz) b₀.den_nz) b₁.den_nz) b₂.den_nz) b₃.den_nz) z3,
        num_mul_nat_zero (Nat.mul_ne_zero (Nat.mul_ne_zero (Nat.mul_ne_zero
          (Nat.mul_ne_zero (Nat.mul_ne_zero (Nat.mul_ne_zero a₀.den_nz a₁.den_nz)
            a₂.den_nz) a₃.den_nz) b₁.den_nz) b₂.den_nz) b₃.den_nz) w0,
        num_mul_nat_zero (Nat.mul_ne_zero (Nat.mul_ne_zero (Nat.mul_ne_zero
          (Nat.mul_ne_zero (Nat.mul_ne_zero (Nat.mul_ne_zero a₀.den_nz a₁.den_nz)
            a₂.den_nz) a₃.den_nz) b₀.den_nz) b₂.den_nz) b₃.den_nz) w1,
        num_mul_nat_zero (Nat.mul_ne_zero (Nat.mul_ne_zero (Nat.mul_ne_zero
          (Nat.mul_ne_zero (Nat.mul_ne_zero (Nat.mul_ne_zero a₀.den_nz a₁.den_nz)
            a₂.den_nz) a₃.den_nz) b₀.den_nz) b₁.den_nz) b₃.den_nz) w2,
        num_mul_nat_zero (Nat.mul_ne_zero (Nat.mul_ne_zero (Nat.mul_ne_zero
          (Nat.mul_ne_zero (Nat.mul_ne_zero (Nat.mul_ne_zero a₀.den_nz a₁.den_nz)
            a₂.den_nz) a₃.den_nz) b₀.den_nz) b₁.den_nz) b₂.den_nz) w3⟩

/-- **The workhorse split** the 2-adic clearings cite: `(A) + √15·(B) = 0` over the
biquadratic basis kills both blocks. `√15·(b₀ + b₁√3 + b₂√11 + b₃√33) =
√5·(3b₁ + b₀√3 + 3b₃√11 + b₂√33)` — the recombination is rational, so this is
`sqrt5_indep` re-addressed. -/
theorem sqrt15_split {a₀ a₁ a₂ a₃ b₀ b₁ b₂ b₃ : ℚ}
    (h : (a₀ : ℝ) + a₁ * Real.sqrt 3 + a₂ * Real.sqrt 11 + a₃ * Real.sqrt 33
       + Real.sqrt 15 * ((b₀ : ℝ) + b₁ * Real.sqrt 3 + b₂ * Real.sqrt 11
           + b₃ * Real.sqrt 33) = 0) :
    a₀ = 0 ∧ a₁ = 0 ∧ a₂ = 0 ∧ a₃ = 0 ∧ b₀ = 0 ∧ b₁ = 0 ∧ b₂ = 0 ∧ b₃ = 0 := by
  have h' : (a₀ : ℝ) + a₁ * Real.sqrt 3 + a₂ * Real.sqrt 11 + a₃ * Real.sqrt 33
      + Real.sqrt 5 * (((3 * b₁ : ℚ) : ℝ) + ((b₀ : ℚ) : ℝ) * Real.sqrt 3
          + ((3 * b₃ : ℚ) : ℝ) * Real.sqrt 11 + ((b₂ : ℚ) : ℝ) * Real.sqrt 33) = 0 := by
    rw [sqrt33_eq] at h ⊢
    rw [sqrt15_eq] at h
    push_cast
    linear_combination h
      - Real.sqrt 5 * ((b₁ : ℝ) + (b₃ : ℝ) * Real.sqrt 11) * sq_sqrt3
  obtain ⟨e0, e1, e2, e3, f0, f1, f2, f3⟩ := sqrt5_indep h'
  exact ⟨e0, e1, e2, e3, f1, by linarith [f0], f3, by linarith [f2]⟩

/-- The flat eight-term completeness, for the record beside M24's four-term `sqrt_indep`:
`{1, √3, √5, √11, √15, √33, √55, √165}` is ℚ-independent. -/
theorem sqrt_indep₈ {e₁ e₃ e₅ e₁₁ e₁₅ e₃₃ e₅₅ e₁₆₅ : ℚ}
    (h : (e₁ : ℝ) + e₃ * Real.sqrt 3 + e₅ * Real.sqrt 5 + e₁₁ * Real.sqrt 11
       + e₁₅ * Real.sqrt 15 + e₃₃ * Real.sqrt 33 + e₅₅ * Real.sqrt 55
       + e₁₆₅ * Real.sqrt 165 = 0) :
    e₁ = 0 ∧ e₃ = 0 ∧ e₅ = 0 ∧ e₁₁ = 0 ∧ e₁₅ = 0 ∧ e₃₃ = 0 ∧ e₅₅ = 0 ∧ e₁₆₅ = 0 := by
  have h15' : Real.sqrt 15 = Real.sqrt 5 * Real.sqrt 3 := by
    rw [show (15 : ℝ) = 5 * 3 by norm_num, Real.sqrt_mul (by norm_num)]
  have h55 : Real.sqrt 55 = Real.sqrt 5 * Real.sqrt 11 := by
    rw [show (55 : ℝ) = 5 * 11 by norm_num, Real.sqrt_mul (by norm_num)]
  have h165 : Real.sqrt 165 = Real.sqrt 5 * Real.sqrt 33 := by
    rw [show (165 : ℝ) = 5 * 33 by norm_num, Real.sqrt_mul (by norm_num)]
  have h' : (e₁ : ℝ) + e₃ * Real.sqrt 3 + e₁₁ * Real.sqrt 11 + e₃₃ * Real.sqrt 33
      + Real.sqrt 5 * ((e₅ : ℝ) + e₁₅ * Real.sqrt 3 + e₅₅ * Real.sqrt 11
          + e₁₆₅ * Real.sqrt 33) = 0 := by
    rw [h15', h55, h165] at h
    linear_combination h
  obtain ⟨k1, k2, k3, k4, m1, m2, m3, m4⟩ := sqrt5_indep h'
  exact ⟨k1, k2, m1, k3, m2, k4, m3, m4⟩

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
  have hre2 : (u * (starRingEnd ℂ) v).re = u.re * v.re + u.im * v.im := by
    simp [Complex.mul_re]
  have him2 : (u * (starRingEnd ℂ) v).im = u.im * v.re - u.re * v.im := by
    simp [Complex.mul_im]; ring
  have hre1 : (rho15 * u - v).re = 7 / 8 * u.re - Real.sqrt 15 / 8 * u.im - v.re := by
    simp [rho15, Complex.mul_re, Complex.sub_re]
  have him1 : (rho15 * u - v).im = 7 / 8 * u.im + Real.sqrt 15 / 8 * u.re - v.im := by
    simp [rho15, Complex.mul_im, Complex.sub_im]
  have h' : (7 / 8 * u.re - Real.sqrt 15 / 8 * u.im - v.re)
        * (7 / 8 * u.re - Real.sqrt 15 / 8 * u.im - v.re)
      + (7 / 8 * u.im + Real.sqrt 15 / 8 * u.re - v.im)
        * (7 / 8 * u.im + Real.sqrt 15 / 8 * u.re - v.im) = 1 := by
    rw [← hre1, ← him1, ← Complex.normSq_apply]
    exact h
  rw [hure, huim, hvre, hvim, sqrt33_eq] at h'
  -- the split hypothesis: 4·(K-block) + √15·(η-block) = 0, coefficients script-verified
  have hsplit : ((-4 + 4*(p₀:ℚ)^2 + 4*(q₀:ℚ)^2 + 4*(r₀:ℚ)^2 + 4*(s₀:ℚ)^2 + 12*(p₁:ℚ)^2
          + 12*(q₁:ℚ)^2 + 12*(r₁:ℚ)^2 + 12*(s₁:ℚ)^2 + 44*(p₂:ℚ)^2 + 44*(q₂:ℚ)^2
          + 44*(r₂:ℚ)^2 + 44*(s₂:ℚ)^2 + 132*(p₃:ℚ)^2 + 132*(q₃:ℚ)^2 + 132*(r₃:ℚ)^2
          + 132*(s₃:ℚ)^2 - 231*(p₃:ℚ)*(r₃:ℚ) - 231*(q₃:ℚ)*(s₃:ℚ) - 77*(p₂:ℚ)*(r₂:ℚ)
          - 77*(q₂:ℚ)*(s₂:ℚ) - 21*(p₁:ℚ)*(r₁:ℚ) - 21*(q₁:ℚ)*(s₁:ℚ) - 7*(p₀:ℚ)*(r₀:ℚ)
          - 7*(q₀:ℚ)*(s₀:ℚ) : ℚ) : ℝ)
      + ((-77*(p₂:ℚ)*(r₃:ℚ) - 77*(p₃:ℚ)*(r₂:ℚ) - 77*(q₂:ℚ)*(s₃:ℚ) - 77*(q₃:ℚ)*(s₂:ℚ)
          - 7*(p₀:ℚ)*(r₁:ℚ) - 7*(p₁:ℚ)*(r₀:ℚ) - 7*(q₀:ℚ)*(s₁:ℚ) - 7*(q₁:ℚ)*(s₀:ℚ)
          + 8*(p₀:ℚ)*(p₁:ℚ) + 8*(q₀:ℚ)*(q₁:ℚ) + 8*(r₀:ℚ)*(r₁:ℚ) + 8*(s₀:ℚ)*(s₁:ℚ)
          + 88*(p₂:ℚ)*(p₃:ℚ) + 88*(q₂:ℚ)*(q₃:ℚ) + 88*(r₂:ℚ)*(r₃:ℚ)
          + 88*(s₂:ℚ)*(s₃:ℚ) : ℚ) : ℝ) * Real.sqrt 3
      + ((-21*(p₁:ℚ)*(r₃:ℚ) - 21*(p₃:ℚ)*(r₁:ℚ) - 21*(q₁:ℚ)*(s₃:ℚ) - 21*(q₃:ℚ)*(s₁:ℚ)
          - 7*(p₀:ℚ)*(r₂:ℚ) - 7*(p₂:ℚ)*(r₀:ℚ) - 7*(q₀:ℚ)*(s₂:ℚ) - 7*(q₂:ℚ)*(s₀:ℚ)
          + 8*(p₀:ℚ)*(p₂:ℚ) + 8*(q₀:ℚ)*(q₂:ℚ) + 8*(r₀:ℚ)*(r₂:ℚ) + 8*(s₀:ℚ)*(s₂:ℚ)
          + 24*(p₁:ℚ)*(p₃:ℚ) + 24*(q₁:ℚ)*(q₃:ℚ) + 24*(r₁:ℚ)*(r₃:ℚ)
          + 24*(s₁:ℚ)*(s₃:ℚ) : ℚ) : ℝ) * Real.sqrt 11
      + ((-7*(p₀:ℚ)*(r₃:ℚ) - 7*(p₁:ℚ)*(r₂:ℚ) - 7*(p₂:ℚ)*(r₁:ℚ) - 7*(p₃:ℚ)*(r₀:ℚ)
          - 7*(q₀:ℚ)*(s₃:ℚ) - 7*(q₁:ℚ)*(s₂:ℚ) - 7*(q₂:ℚ)*(s₁:ℚ) - 7*(q₃:ℚ)*(s₀:ℚ)
          + 8*(p₀:ℚ)*(p₃:ℚ) + 8*(p₁:ℚ)*(p₂:ℚ) + 8*(q₀:ℚ)*(q₃:ℚ) + 8*(q₁:ℚ)*(q₂:ℚ)
          + 8*(r₀:ℚ)*(r₃:ℚ) + 8*(r₁:ℚ)*(r₂:ℚ) + 8*(s₀:ℚ)*(s₃:ℚ)
          + 8*(s₁:ℚ)*(s₂:ℚ) : ℚ) : ℝ) * Real.sqrt 33
      + Real.sqrt 15 * ((((q₀:ℚ)*(r₀:ℚ) - (p₀:ℚ)*(s₀:ℚ) - 33*(p₃:ℚ)*(s₃:ℚ)
            - 11*(p₂:ℚ)*(s₂:ℚ) - 3*(p₁:ℚ)*(s₁:ℚ) + 3*(q₁:ℚ)*(r₁:ℚ) + 11*(q₂:ℚ)*(r₂:ℚ)
            + 33*(q₃:ℚ)*(r₃:ℚ) : ℚ) : ℝ)
        + (((q₀:ℚ)*(r₁:ℚ) + (q₁:ℚ)*(r₀:ℚ) - (p₀:ℚ)*(s₁:ℚ) - (p₁:ℚ)*(s₀:ℚ)
            - 11*(p₂:ℚ)*(s₃:ℚ) - 11*(p₃:ℚ)*(s₂:ℚ) + 11*(q₂:ℚ)*(r₃:ℚ)
            + 11*(q₃:ℚ)*(r₂:ℚ) : ℚ) : ℝ) * Real.sqrt 3
        + (((q₀:ℚ)*(r₂:ℚ) + (q₂:ℚ)*(r₀:ℚ) - (p₀:ℚ)*(s₂:ℚ) - (p₂:ℚ)*(s₀:ℚ)
            - 3*(p₁:ℚ)*(s₃:ℚ) - 3*(p₃:ℚ)*(s₁:ℚ) + 3*(q₁:ℚ)*(r₃:ℚ)
            + 3*(q₃:ℚ)*(r₁:ℚ) : ℚ) : ℝ) * Real.sqrt 11
        + (((q₀:ℚ)*(r₃:ℚ) + (q₁:ℚ)*(r₂:ℚ) + (q₂:ℚ)*(r₁:ℚ) + (q₃:ℚ)*(r₀:ℚ)
            - (p₀:ℚ)*(s₃:ℚ) - (p₁:ℚ)*(s₂:ℚ) - (p₂:ℚ)*(s₁:ℚ)
            - (p₃:ℚ)*(s₀:ℚ) : ℚ) : ℝ) * Real.sqrt 33) = 0 := by
    rw [sqrt33_eq]
    push_cast
    linear_combination 4 * h'
      + (-4*(r₁:ℝ)^2 - 4*(s₁:ℝ)^2 - 49*(p₁:ℝ)^2/16 - 49*(q₁:ℝ)^2/16
        + Real.sqrt 15*((p₁:ℝ)*(s₁:ℝ) - (q₁:ℝ)*(r₁:ℝ))
        + Real.sqrt 11*(-8*(r₁:ℝ)*(r₃:ℝ) - 8*(s₁:ℝ)*(s₃:ℝ) + 7*(p₁:ℝ)*(r₃:ℝ)
          + 7*(p₃:ℝ)*(r₁:ℝ) + 7*(q₁:ℝ)*(s₃:ℝ) + 7*(q₃:ℝ)*(s₁:ℝ)
          - 49*(p₁:ℝ)*(p₃:ℝ)/8 - 49*(q₁:ℝ)*(q₃:ℝ)/8)
        + Real.sqrt 15^2*(-(p₁:ℝ)^2/16 - (q₁:ℝ)^2/16)
        + Real.sqrt 11^2*(-4*(r₃:ℝ)^2 - 4*(s₃:ℝ)^2 - 49*(p₃:ℝ)^2/16 - 49*(q₃:ℝ)^2/16
          + 7*(p₃:ℝ)*(r₃:ℝ) + 7*(q₃:ℝ)*(s₃:ℝ))
        + 7*(p₁:ℝ)*(r₁:ℝ) + 7*(q₁:ℝ)*(s₁:ℝ)
        + Real.sqrt 15*Real.sqrt 11*((p₁:ℝ)*(s₃:ℝ) + (p₃:ℝ)*(s₁:ℝ) - (q₁:ℝ)*(r₃:ℝ)
          - (q₃:ℝ)*(r₁:ℝ))
        + Real.sqrt 15*Real.sqrt 11^2*((p₃:ℝ)*(s₃:ℝ) - (q₃:ℝ)*(r₃:ℝ))
        + Real.sqrt 11*Real.sqrt 15^2*(-(p₁:ℝ)*(p₃:ℝ)/8 - (q₁:ℝ)*(q₃:ℝ)/8)
        + Real.sqrt 15^2*Real.sqrt 11^2*(-(p₃:ℝ)^2/16 - (q₃:ℝ)^2/16)) * sq_sqrt3
      + (-12*(r₃:ℝ)^2 - 12*(s₃:ℝ)^2 - 4*(r₂:ℝ)^2 - 4*(s₂:ℝ)^2 - 147*(p₃:ℝ)^2/16
        - 147*(q₃:ℝ)^2/16 - 49*(p₂:ℝ)^2/16 - 49*(q₂:ℝ)^2/16
        + Real.sqrt 15*((p₂:ℝ)*(s₂:ℝ) - (q₂:ℝ)*(r₂:ℝ) - 3*(q₃:ℝ)*(r₃:ℝ)
          + 3*(p₃:ℝ)*(s₃:ℝ))
        + Real.sqrt 3*(-8*(r₂:ℝ)*(r₃:ℝ) - 8*(s₂:ℝ)*(s₃:ℝ) + 7*(p₂:ℝ)*(r₃:ℝ)
          + 7*(p₃:ℝ)*(r₂:ℝ) + 7*(q₂:ℝ)*(s₃:ℝ) + 7*(q₃:ℝ)*(s₂:ℝ)
          - 49*(p₂:ℝ)*(p₃:ℝ)/8 - 49*(q₂:ℝ)*(q₃:ℝ)/8)
        + Real.sqrt 15^2*(-3*(p₃:ℝ)^2/16 - 3*(q₃:ℝ)^2/16 - (p₂:ℝ)^2/16 - (q₂:ℝ)^2/16)
        + 7*(p₂:ℝ)*(r₂:ℝ) + 7*(q₂:ℝ)*(s₂:ℝ) + 21*(p₃:ℝ)*(r₃:ℝ) + 21*(q₃:ℝ)*(s₃:ℝ)
        + Real.sqrt 15*Real.sqrt 3*((p₂:ℝ)*(s₃:ℝ) + (p₃:ℝ)*(s₂:ℝ) - (q₂:ℝ)*(r₃:ℝ)
          - (q₃:ℝ)*(r₂:ℝ))
        + Real.sqrt 3*Real.sqrt 15^2*(-(p₂:ℝ)*(p₃:ℝ)/8 - (q₂:ℝ)*(q₃:ℝ)/8)) * sq_sqrt11
      + (-33*(p₃:ℝ)^2/16 - 33*(q₃:ℝ)^2/16 - 11*(p₂:ℝ)^2/16 - 11*(q₂:ℝ)^2/16
        - 3*(p₁:ℝ)^2/16 - 3*(q₁:ℝ)^2/16 - (p₀:ℝ)^2/16 - (q₀:ℝ)^2/16
        + Real.sqrt 3*(-11*(p₂:ℝ)*(p₃:ℝ)/8 - 11*(q₂:ℝ)*(q₃:ℝ)/8 - (p₀:ℝ)*(p₁:ℝ)/8
          - (q₀:ℝ)*(q₁:ℝ)/8)
        + Real.sqrt 11*(-3*(p₁:ℝ)*(p₃:ℝ)/8 - 3*(q₁:ℝ)*(q₃:ℝ)/8 - (p₀:ℝ)*(p₂:ℝ)/8
          - (q₀:ℝ)*(q₂:ℝ)/8)
        + Real.sqrt 3*Real.sqrt 11*(-(p₀:ℝ)*(p₃:ℝ)/8 - (p₁:ℝ)*(p₂:ℝ)/8
          - (q₀:ℝ)*(q₃:ℝ)/8 - (q₁:ℝ)*(q₂:ℝ)/8)) * sq_sqrt15
  obtain ⟨e0, e1, e2, e3, f0, f1, f2, f3⟩ := sqrt15_split hsplit
  constructor
  · -- the collinear pin: η's four K-coefficients died in the split
    rw [him2, hure, huim, hvre, hvim, sqrt33_eq]
    have f0r := congrArg (fun x : ℚ => (x : ℝ)) f0
    have f1r := congrArg (fun x : ℚ => (x : ℝ)) f1
    have f2r := congrArg (fun x : ℚ => (x : ℝ)) f2
    have f3r := congrArg (fun x : ℚ => (x : ℝ)) f3
    push_cast at f0r f1r f2r f3r ⊢
    linear_combination f0r + Real.sqrt 3 * f1r + Real.sqrt 11 * f2r
        + Real.sqrt 3 * Real.sqrt 11 * f3r
      - ((p₁:ℝ)*(s₁:ℝ) + Real.sqrt 11*((p₁:ℝ)*(s₃:ℝ) + (p₃:ℝ)*(s₁:ℝ) - (q₁:ℝ)*(r₃:ℝ)
          - (q₃:ℝ)*(r₁:ℝ)) + Real.sqrt 11^2*((p₃:ℝ)*(s₃:ℝ) - (q₃:ℝ)*(r₃:ℝ))
          - (q₁:ℝ)*(r₁:ℝ)) * sq_sqrt3
      - ((p₂:ℝ)*(s₂:ℝ) + Real.sqrt 3*((p₂:ℝ)*(s₃:ℝ) + (p₃:ℝ)*(s₂:ℝ) - (q₂:ℝ)*(r₃:ℝ)
          - (q₃:ℝ)*(r₂:ℝ)) - (q₂:ℝ)*(r₂:ℝ) - 3*(q₃:ℝ)*(r₃:ℝ)
          + 3*(p₃:ℝ)*(s₃:ℝ)) * sq_sqrt11
  · -- the conic: the K-block's four coefficients died in the split
    rw [Complex.normSq_apply, Complex.normSq_apply, hre2, hure, huim, hvre, hvim,
      sqrt33_eq]
    have e0r := congrArg (fun x : ℚ => (x : ℝ)) e0
    have e1r := congrArg (fun x : ℚ => (x : ℝ)) e1
    have e2r := congrArg (fun x : ℚ => (x : ℝ)) e2
    have e3r := congrArg (fun x : ℚ => (x : ℝ)) e3
    push_cast at e0r e1r e2r e3r ⊢
    linear_combination (1 / 4 : ℝ) * e0r + Real.sqrt 3 / 4 * e1r + Real.sqrt 11 / 4 * e2r
        + Real.sqrt 3 * Real.sqrt 11 / 4 * e3r
      - (-(p₁:ℝ)^2 - (q₁:ℝ)^2 - (r₁:ℝ)^2 - (s₁:ℝ)^2
          + Real.sqrt 11*(-2*(p₁:ℝ)*(p₃:ℝ) - 2*(q₁:ℝ)*(q₃:ℝ) - 2*(r₁:ℝ)*(r₃:ℝ)
            - 2*(s₁:ℝ)*(s₃:ℝ) + 7*(p₁:ℝ)*(r₃:ℝ)/4 + 7*(p₃:ℝ)*(r₁:ℝ)/4
            + 7*(q₁:ℝ)*(s₃:ℝ)/4 + 7*(q₃:ℝ)*(s₁:ℝ)/4)
          + Real.sqrt 11^2*(-(p₃:ℝ)^2 - (q₃:ℝ)^2 - (r₃:ℝ)^2 - (s₃:ℝ)^2
            + 7*(p₃:ℝ)*(r₃:ℝ)/4 + 7*(q₃:ℝ)*(s₃:ℝ)/4)
          + 7*(p₁:ℝ)*(r₁:ℝ)/4 + 7*(q₁:ℝ)*(s₁:ℝ)/4) * sq_sqrt3
      - (-(p₂:ℝ)^2 - (q₂:ℝ)^2 - (r₂:ℝ)^2 - (s₂:ℝ)^2 - 3*(p₃:ℝ)^2 - 3*(q₃:ℝ)^2
          - 3*(r₃:ℝ)^2 - 3*(s₃:ℝ)^2
          + Real.sqrt 3*(-2*(p₂:ℝ)*(p₃:ℝ) - 2*(q₂:ℝ)*(q₃:ℝ) - 2*(r₂:ℝ)*(r₃:ℝ)
            - 2*(s₂:ℝ)*(s₃:ℝ) + 7*(p₂:ℝ)*(r₃:ℝ)/4 + 7*(p₃:ℝ)*(r₂:ℝ)/4
            + 7*(q₂:ℝ)*(s₃:ℝ)/4 + 7*(q₃:ℝ)*(s₂:ℝ)/4)
          + 7*(p₂:ℝ)*(r₂:ℝ)/4 + 7*(q₂:ℝ)*(s₂:ℝ)/4 + 21*(p₃:ℝ)*(r₃:ℝ)/4
          + 21*(q₃:ℝ)*(s₃:ℝ)/4) * sq_sqrt11

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
