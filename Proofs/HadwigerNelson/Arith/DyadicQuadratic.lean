import Proofs.HadwigerNelson.SpectralChain
import Mathlib.NumberTheory.Real.Irrational

/-!
# Two and four colours at the dyadic prime of a real quadratic field (FS-131, NF4; planners FS131-KN4, FS131-KN5)

**Read aloud, against the claim** (`data/fs131/claims-NF4.md`, the dated lines of 2026-10-13 17:59 UTC).
* NF4-DYADIC-TWO: *"'= 2 for squarefree m not 3 mod 4' needs a stable prime of Q(sqrt m)(i) above 2 ramified over
  Q(sqrt m)"* — its kernel form is the colouring the table's row reads: `colorable_two_planeOver_sqrt`.
* NF4-DYADIC-FOUR: *"'= 4 for m = 11 mod 24' needs the stable prime above 2 with residue field F_4 (inert in F(i)/F
  exactly when m = 3 mod 8; the target then has four vertices)"* — `colorable_four_planeOver_sqrt`, for every
  `m ≡ 3 (mod 8)`.
The primes themselves (`SpectralChain.StablePrime`) are corollaries in the joining module; no consumer of the table
reads them.

**Both values are prior art** (`[Fischer1990]`, `[Johnson2000]`; `LEDGER.md` § The claim list): nothing here is claimed
as this project's but the kernel form.

**This module reads nothing of the three-colour line** (its imports are `SpectralChain` and Mathlib), so it can be built
beside it.

**The route** (`plans/FS131-KN5-three-four-colours-passes.md` § Stage 5): integers only — no order of `ℚ(√m, i)`, no
valuation, no localization. A unit vector of `ℚ(√m)²` is `u = (a + b√m + c·i + d·i√m)/N` with integers
(`exists_rat_add_mul_sqrt_eq`, `exists_int_solution_of_mem_unitVectors`), and `|u| = 1` reads `a² + c² + m(b² + d²) = N²`,
`ab + cd = 0` (`√m` is irrational in each class). For a solution not all even, the class of `m` fixes the shape of `(a, b, c, d, N)` modulo 4
(`dyadic_shape_one_mod_four`, `…_two_mod_four`, `…_three_mod_eight`): `N` is odd or twice an odd number, and one
additive map `ψ` on the lattice of points of that shape — into `𝔽₂`, or into `𝔽₂ × 𝔽₂` when `m ≡ 3 (mod 8)` — is never
`0` at a unit vector (`exists_addMonoidHom_…`). `colorable_planeOver_of_addMonoidHom` — the residue colouring,
`colorable_of_residue` of `ResidueColouring.lean`, read at the plane — then colours with `|𝔽₂| = 2` or `|𝔽₂ × 𝔽₂| = 4` colours.
(`ψ` is the reduction at the dyadic prime written in coordinates: `i ↦ 1`, and `(1 + √m)/2`, `√m(1 + i)/2` or
`(1 + i√m)/2` to its residue. Nothing in the proof needs to know that.)

**Inhabitants.** `colorable_planeOver_of_addMonoidHom` at `F = ℚ`, the lattice `{(a + c·i)/N : N odd}` and
`ψ = a + c mod 2` (Woodall's two-colouring of the rational plane); the three shape lemmas at
`(a, b, c, d, N) = (1, 0, 0, 0, 1)` (the vector `1`, `N` odd) and, with `N` even, at `(1 + i√3)/2` and `(√2 + i√2)/2`
(the Spec section) — every alternative of every class is met by solutions (`data/fs131/kn5/dyadic_check.py`: 96, 176
and 272 solutions with `N` even in its box). `colorable_two_planeOver_sqrt` at `m = 2`, `5`, `17`;
`colorable_four_planeOver_sqrt` at `m = 3`, `11`.
-/

namespace HadwigerNelson.DyadicQuadratic

open HadwigerNelson.SpectralChain HadwigerNelson.SquareClass SimpleGraph

/-! ## §1 The residue colouring, read at the plane -/

/-- **An additive map that is never `0` at a unit vector colours the plane.** `Λ` an additive subgroup of `ℂ` holding
the unit vectors of `F²`, `ψ : Λ →+ G` into a finite group with `ψ u ≠ 0` at each of them: the plane over `F` is
`|G|`-colourable (colour each coset of `Λ` by `ψ`; `HadwigerNelson.colorable_of_residue`). Every subfield `F ⊆ ℝ`.
Its case `Λ = ℤ[U_F]`, `ψ` a ring homomorphism, is `HadwigerNelson.colorable_unitDistance_induce_of_residue`. -/
theorem colorable_planeOver_of_addMonoidHom {F : Subfield ℝ} {Λ : AddSubgroup ℂ} {G : Type*} [AddCommGroup G]
    [Finite G] (ψ : Λ →+ G) (h : ∀ u ∈ unitVectors F, ∃ hu : u ∈ Λ, ψ ⟨u, hu⟩ ≠ 0) :
    ((unitDistance ℂ).induce (planeOver F)).Colorable (Nat.card G) := by
  haveI := Fintype.ofFinite G
  rw [Nat.card_eq_fintype_card]
  -- an edge's difference is a unit vector of `F²`
  have hunit : ∀ ⦃v w : planeOver F⦄, ((unitDistance ℂ).induce (planeOver F)).Adj v w →
      (v : ℂ) - (w : ℂ) ∈ unitVectors F := by
    intro v w hvw
    have hd : dist (v : ℂ) (w : ℂ) = 1 := unitDistance_adj.mp hvw
    refine ⟨⟨?_, ?_⟩, ?_⟩
    · rw [Complex.sub_re]
      exact F.sub_mem v.2.1 w.2.1
    · rw [Complex.sub_im]
      exact F.sub_mem v.2.2 w.2.2
    · rw [← Complex.dist_eq]
      exact hd
  refine HadwigerNelson.colorable_of_residue _ (fun v : planeOver F => (v : ℂ)) ψ
    (fun v w hvw => (h _ (hunit hvw)).1) (fun v w hvw => ?_)
  obtain ⟨hu, hne⟩ := h _ (hunit hvw)
  rw [HadwigerNelson.cosetResidue_apply_of_mem ψ hu]
  exact hne

/-! ## §2 Coordinates, and the shape of a unit vector modulo 4 -/

/-- **Coordinates in `ℚ(√m)`**: every element is `p + q√m` with `p, q` rational. -/
theorem exists_rat_add_mul_sqrt_eq {m : ℕ} {x : ℝ} (hx : x ∈ fieldOfRadicands {m}) :
    ∃ p q : ℚ, x = p + q * Real.sqrt m := by
  have hs : Real.sqrt m * Real.sqrt m = m := Real.mul_self_sqrt (Nat.cast_nonneg m)
  refine Subfield.closure_induction (p := fun x _ => ∃ p q : ℚ, x = p + q * Real.sqrt m)
    ?_ ?_ ?_ ?_ ?_ ?_ hx
  · rintro x ⟨d, hd, rfl⟩
    rw [Set.mem_singleton_iff] at hd
    subst hd
    exact ⟨0, 1, by push_cast; ring⟩
  · exact ⟨1, 0, by push_cast; ring⟩
  · rintro x y - - ⟨p, q, rfl⟩ ⟨p', q', rfl⟩
    exact ⟨p + p', q + q', by push_cast; ring⟩
  · rintro x - ⟨p, q, rfl⟩
    exact ⟨-p, -q, by push_cast; ring⟩
  · rintro x - ⟨p, q, rfl⟩
    -- the conjugate `p - q√m`: if it is `0` then `x = 2p`; otherwise `x⁻¹ = (p - q√m) / (p² - m q²)`
    by_cases hy : (p : ℝ) - q * Real.sqrt m = 0
    · refine ⟨(2 * p)⁻¹, 0, ?_⟩
      have hx2 : (p : ℝ) + q * Real.sqrt m = 2 * p := by linarith
      rw [hx2]
      push_cast
      ring
    · by_cases hx0 : (p : ℝ) + q * Real.sqrt m = 0
      · exact ⟨0, 0, by rw [hx0]; push_cast; ring⟩
      · have hn : ((p : ℝ) + q * Real.sqrt m) * ((p : ℝ) - q * Real.sqrt m) = ((p ^ 2 - m * q ^ 2 : ℚ) : ℝ) := by
          push_cast
          linear_combination (-(q : ℝ) ^ 2) * hs
        have hn0 : ((p ^ 2 - m * q ^ 2 : ℚ) : ℝ) ≠ 0 := by
          rw [← hn]
          exact mul_ne_zero hx0 hy
        refine ⟨p / (p ^ 2 - m * q ^ 2), -q / (p ^ 2 - m * q ^ 2), ?_⟩
        rw [inv_eq_iff_eq_inv, eq_comm]
        apply inv_eq_of_mul_eq_one_left
        rw [Rat.cast_div, Rat.cast_div, Rat.cast_neg]
        field_simp
        linear_combination hn
  · rintro x y - - ⟨p, q, rfl⟩ ⟨p', q', rfl⟩
    exact ⟨p * p' + q * q' * m, p * q' + q * p', by push_cast; linear_combination ((q : ℝ) * q') * hs⟩

/-- A rational combination `A + B·x` of `1` and an irrational `x` that vanishes has `A = B = 0`. -/
private theorem rat_eq_zero_of_add_mul_irrational {x : ℝ} (hx : Irrational x) {A B : ℚ}
    (h : (A : ℝ) + B * x = 0) : A = 0 ∧ B = 0 := by
  have hB : B = 0 := by
    by_contra hB
    have hB' : (B : ℝ) ≠ 0 := by exact_mod_cast hB
    refine hx ⟨-A / B, ?_⟩
    push_cast
    field_simp
    linarith
  subst hB
  refine ⟨?_, rfl⟩
  have h0 : (A : ℝ) = 0 := by simpa using h
  exact_mod_cast h0

/-- **Halving.** An integer representation `N·u = (a + b√m) + (c + d√m)·i` of a point, with `N ≠ 0` and the two
equations, can be taken not all even: an all-even one halves, and `|N|` drops. (Induction on `|N|`; nothing about `m`
or `u` is read.) -/
private theorem exists_not_all_even {m : ℕ} {u : ℂ} : ∀ (n : ℕ) (a b c d N : ℤ), N.natAbs = n → N ≠ 0 →
    a ^ 2 + c ^ 2 + (m : ℤ) * (b ^ 2 + d ^ 2) = N ^ 2 → a * b + c * d = 0 →
    (N : ℂ) * u = (((a : ℝ) + (b : ℝ) * Real.sqrt m : ℝ) : ℂ) +
      (((c : ℝ) + (d : ℝ) * Real.sqrt m : ℝ) : ℂ) * Complex.I →
    ∃ a b c d N : ℤ, N ≠ 0 ∧ ¬ (2 ∣ a ∧ 2 ∣ b ∧ 2 ∣ c ∧ 2 ∣ d ∧ 2 ∣ N) ∧
      a ^ 2 + c ^ 2 + (m : ℤ) * (b ^ 2 + d ^ 2) = N ^ 2 ∧ a * b + c * d = 0 ∧
      (N : ℂ) * u = (((a : ℝ) + (b : ℝ) * Real.sqrt m : ℝ) : ℂ) +
        (((c : ℝ) + (d : ℝ) * Real.sqrt m : ℝ) : ℂ) * Complex.I := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    intro a b c d N hn hN h1 h2 h3
    by_cases hp : 2 ∣ a ∧ 2 ∣ b ∧ 2 ∣ c ∧ 2 ∣ d ∧ 2 ∣ N
    · obtain ⟨⟨a', rfl⟩, ⟨b', rfl⟩, ⟨c', rfl⟩, ⟨d', rfl⟩, ⟨N', rfl⟩⟩ := hp
      have hN' : N' ≠ 0 := by
        rintro rfl
        exact hN (mul_zero 2)
      refine ih N'.natAbs ?_ a' b' c' d' N' rfl hN' ?_ ?_ ?_
      · have hpos : 0 < N'.natAbs := Int.natAbs_pos.mpr hN'
        have hmul : (2 * N').natAbs = 2 * N'.natAbs := Int.natAbs_mul 2 N'
        rw [← hn, hmul]
        omega
      · have h4 : (4 : ℤ) * (a' ^ 2 + c' ^ 2 + (m : ℤ) * (b' ^ 2 + d' ^ 2)) = 4 * N' ^ 2 := by
          linear_combination h1
        exact mul_left_cancel₀ (by norm_num) h4
      · have h4 : (4 : ℤ) * (a' * b' + c' * d') = 4 * 0 := by linear_combination h2
        exact mul_left_cancel₀ (by norm_num) h4
      · have h2u : (2 : ℂ) * ((N' : ℂ) * u) = 2 * ((((a' : ℝ) + (b' : ℝ) * Real.sqrt m : ℝ) : ℂ) +
            (((c' : ℝ) + (d' : ℝ) * Real.sqrt m : ℝ) : ℂ) * Complex.I) := by
          push_cast at h3 ⊢
          linear_combination h3
        exact mul_left_cancel₀ two_ne_zero h2u
    · exact ⟨a, b, c, d, N, hN, hp, h1, h2, h3⟩

/-- **A unit vector in integers.** For `m` not a square, a unit vector `u` of `ℚ(√m)²` is `(a + b√m + (c + d√m)·i)/N`
with integers not all even, and `|u| = 1` reads `a² + c² + m(b² + d²) = N²`, `ab + cd = 0` (the rational part and the
`√m` part of `u·ū = 1`; `√m` is irrational). -/
theorem exists_int_solution_of_mem_unitVectors {m : ℕ} (hsq : ¬ IsSquare m) {u : ℂ}
    (hu : u ∈ unitVectors (fieldOfRadicands {m})) :
    ∃ a b c d N : ℤ, N ≠ 0 ∧ ¬ (2 ∣ a ∧ 2 ∣ b ∧ 2 ∣ c ∧ 2 ∣ d ∧ 2 ∣ N) ∧
      a ^ 2 + c ^ 2 + (m : ℤ) * (b ^ 2 + d ^ 2) = N ^ 2 ∧ a * b + c * d = 0 ∧
      (N : ℂ) * u = (((a : ℝ) + (b : ℝ) * Real.sqrt m : ℝ) : ℂ) +
        (((c : ℝ) + (d : ℝ) * Real.sqrt m : ℝ) : ℂ) * Complex.I := by
  obtain ⟨⟨hre, him⟩, hnorm⟩ := hu
  obtain ⟨p₁, p₂, h_re⟩ := exists_rat_add_mul_sqrt_eq hre
  obtain ⟨p₃, p₄, h_im⟩ := exists_rat_add_mul_sqrt_eq him
  have hs : Real.sqrt m * Real.sqrt m = m := Real.mul_self_sqrt (Nat.cast_nonneg m)
  have hirr : Irrational (Real.sqrt m) := irrational_sqrt_natCast_iff.mpr hsq
  -- `|u|² = 1`, split into its rational part and its `√m` part
  have hsq1 : u.re * u.re + u.im * u.im = 1 := by
    have h := Complex.sq_norm u
    rw [hnorm, Complex.normSq_apply] at h
    linarith
  have hsplit : ((p₁ ^ 2 + p₃ ^ 2 + m * (p₂ ^ 2 + p₄ ^ 2) - 1 : ℚ) : ℝ) +
      ((2 * (p₁ * p₂ + p₃ * p₄) : ℚ) : ℝ) * Real.sqrt m = 0 := by
    rw [h_re, h_im] at hsq1
    push_cast
    linear_combination hsq1 - ((p₂ : ℝ) ^ 2 + (p₄ : ℝ) ^ 2) * hs
  obtain ⟨hA, hB⟩ := rat_eq_zero_of_add_mul_irrational hirr hsplit
  -- clear denominators: `D` the product of the four, `a = p₁ D`, …
  obtain ⟨D, hD0, hD⟩ : ∃ D : ℤ, D ≠ 0 ∧ (D : ℚ) = p₁.den * p₂.den * p₃.den * p₄.den :=
    ⟨p₁.den * p₂.den * p₃.den * p₄.den,
      mul_ne_zero (mul_ne_zero (mul_ne_zero (Int.natCast_ne_zero.mpr p₁.den_ne_zero)
        (Int.natCast_ne_zero.mpr p₂.den_ne_zero)) (Int.natCast_ne_zero.mpr p₃.den_ne_zero))
        (Int.natCast_ne_zero.mpr p₄.den_ne_zero), by push_cast; ring⟩
  have e₁ : (p₁.num : ℚ) = p₁ * p₁.den := (Rat.mul_den_eq_num p₁).symm
  have e₂ : (p₂.num : ℚ) = p₂ * p₂.den := (Rat.mul_den_eq_num p₂).symm
  have e₃ : (p₃.num : ℚ) = p₃ * p₃.den := (Rat.mul_den_eq_num p₃).symm
  have e₄ : (p₄.num : ℚ) = p₄ * p₄.den := (Rat.mul_den_eq_num p₄).symm
  obtain ⟨a, ha⟩ : ∃ a : ℤ, (a : ℚ) = p₁ * D :=
    ⟨p₁.num * (p₂.den * p₃.den * p₄.den), by push_cast; rw [e₁, hD]; ring⟩
  obtain ⟨b, hb⟩ : ∃ b : ℤ, (b : ℚ) = p₂ * D :=
    ⟨p₂.num * (p₁.den * p₃.den * p₄.den), by push_cast; rw [e₂, hD]; ring⟩
  obtain ⟨c, hc⟩ : ∃ c : ℤ, (c : ℚ) = p₃ * D :=
    ⟨p₃.num * (p₁.den * p₂.den * p₄.den), by push_cast; rw [e₃, hD]; ring⟩
  obtain ⟨d, hd⟩ : ∃ d : ℤ, (d : ℚ) = p₄ * D :=
    ⟨p₄.num * (p₁.den * p₂.den * p₃.den), by push_cast; rw [e₄, hD]; ring⟩
  have h1 : a ^ 2 + c ^ 2 + (m : ℤ) * (b ^ 2 + d ^ 2) = D ^ 2 := by
    have h : ((a ^ 2 + c ^ 2 + (m : ℤ) * (b ^ 2 + d ^ 2) : ℤ) : ℚ) = ((D ^ 2 : ℤ) : ℚ) := by
      push_cast
      rw [ha, hb, hc, hd]
      linear_combination (D : ℚ) ^ 2 * hA
    exact_mod_cast h
  have h2 : a * b + c * d = 0 := by
    have h : ((a * b + c * d : ℤ) : ℚ) = ((0 : ℤ) : ℚ) := by
      push_cast
      rw [ha, hb, hc, hd]
      linear_combination ((D : ℚ) ^ 2 / 2) * hB
    exact_mod_cast h
  have ha' : (a : ℝ) = p₁ * D := by exact_mod_cast congrArg (Rat.cast : ℚ → ℝ) ha
  have hb' : (b : ℝ) = p₂ * D := by exact_mod_cast congrArg (Rat.cast : ℚ → ℝ) hb
  have hc' : (c : ℝ) = p₃ * D := by exact_mod_cast congrArg (Rat.cast : ℚ → ℝ) hc
  have hd' : (d : ℝ) = p₄ * D := by exact_mod_cast congrArg (Rat.cast : ℚ → ℝ) hd
  have h3 : (D : ℂ) * u = (((a : ℝ) + (b : ℝ) * Real.sqrt m : ℝ) : ℂ) +
      (((c : ℝ) + (d : ℝ) * Real.sqrt m : ℝ) : ℂ) * Complex.I := by
    apply Complex.ext
    · have hr : (D : ℝ) * u.re = (a : ℝ) + (b : ℝ) * Real.sqrt m := by
        rw [h_re, ha', hb']
        ring
      simpa using hr
    · have hi : (D : ℝ) * u.im = (c : ℝ) + (d : ℝ) * Real.sqrt m := by
        rw [h_im, hc', hd']
        ring
      simpa using hi
  exact exists_not_all_even D.natAbs a b c d D rfl hD0 h1 h2 h3

/-- **The shape of a unit vector, `m ≡ 1 (mod 4)`.** An integer solution of `a² + c² + m(b² + d²) = N²`, `ab + cd = 0`,
not all even: `N` is odd and `a + b + c + d` is odd, or `N ≡ 2 (mod 4)`, `a ≡ b`, `c ≡ d (mod 2)` and
`(a − b + c − d)/2` is odd. -/
theorem dyadic_shape_one_mod_four {m : ℕ} (hm : m % 4 = 1) {a b c d N : ℤ}
    (h1 : a ^ 2 + c ^ 2 + (m : ℤ) * (b ^ 2 + d ^ 2) = N ^ 2) (h2 : a * b + c * d = 0)
    (hp : ¬ (2 ∣ a ∧ 2 ∣ b ∧ 2 ∣ c ∧ 2 ∣ d ∧ 2 ∣ N)) :
    (Odd N ∧ Odd (a + b + c + d)) ∨
      (N % 4 = 2 ∧ 2 ∣ a - b ∧ 2 ∣ c - d ∧ Odd ((a - b + c - d) / 2)) := by
  sorry

/-- **The shape of a unit vector, `m ≡ 2 (mod 4)`.** As above: `N` is odd and `a + c` is odd, or `N ≡ 2 (mod 4)`,
`a` and `c` are even, `b` and `d` are odd and `a/2 + c/2 + d` is odd. -/
theorem dyadic_shape_two_mod_four {m : ℕ} (hm : m % 4 = 2) {a b c d N : ℤ}
    (h1 : a ^ 2 + c ^ 2 + (m : ℤ) * (b ^ 2 + d ^ 2) = N ^ 2) (h2 : a * b + c * d = 0)
    (hp : ¬ (2 ∣ a ∧ 2 ∣ b ∧ 2 ∣ c ∧ 2 ∣ d ∧ 2 ∣ N)) :
    (Odd N ∧ Odd (a + c)) ∨
      (N % 4 = 2 ∧ 2 ∣ a ∧ 2 ∣ c ∧ Odd b ∧ Odd d ∧ Odd (a / 2 + c / 2 + d)) := by
  sorry

/-- **The shape of a unit vector, `m ≡ 3 (mod 8)`.** As above: `N` is odd and `a + b + c + d` is odd, or
`N ≡ 2 (mod 4)`, `a ≡ d`, `b ≡ c (mod 2)` and `b + d` is odd. (At `m ≡ 7 (mod 8)` it fails: `(3 + i√7)/4`.) -/
theorem dyadic_shape_three_mod_eight {m : ℕ} (hm : m % 8 = 3) {a b c d N : ℤ}
    (h1 : a ^ 2 + c ^ 2 + (m : ℤ) * (b ^ 2 + d ^ 2) = N ^ 2) (h2 : a * b + c * d = 0)
    (hp : ¬ (2 ∣ a ∧ 2 ∣ b ∧ 2 ∣ c ∧ 2 ∣ d ∧ 2 ∣ N)) :
    (Odd N ∧ Odd (a + b + c + d)) ∨ (N % 4 = 2 ∧ 2 ∣ a - d ∧ 2 ∣ b - c ∧ Odd (b + d)) := by
  sorry

/-! ## §3 The lattice and its additive map, class by class -/

/-- **`m ≡ 1 (mod 4)`, not a square**: an additive map into `𝔽₂`, on a subgroup of `ℂ` holding the unit vectors of
`ℚ(√m)²`, that is not `0` at any of them. (Points `(a + b√m + c·i + d·i√m)/(2N)`, `N` odd, `a ≡ b`, `c ≡ d (mod 2)`;
`ψ = (a − b + c − d)/2 mod 2`.) -/
theorem exists_addMonoidHom_one_mod_four {m : ℕ} (hm : m % 4 = 1) (hsq : ¬ IsSquare m) :
    ∃ (Λ : AddSubgroup ℂ) (ψ : Λ →+ ZMod 2),
      ∀ u ∈ unitVectors (fieldOfRadicands {m}), ∃ hu : u ∈ Λ, ψ ⟨u, hu⟩ ≠ 0 := by
  sorry

/-- **`m ≡ 2 (mod 4)`**: the same. (Points with `a`, `c` even and `b ≡ d (mod 2)`; `ψ = a/2 + c/2 + d mod 2`.) -/
theorem exists_addMonoidHom_two_mod_four {m : ℕ} (hm : m % 4 = 2) :
    ∃ (Λ : AddSubgroup ℂ) (ψ : Λ →+ ZMod 2),
      ∀ u ∈ unitVectors (fieldOfRadicands {m}), ∃ hu : u ∈ Λ, ψ ⟨u, hu⟩ ≠ 0 := by
  sorry

/-- **`m ≡ 3 (mod 8)`**: an additive map into `𝔽₂ × 𝔽₂` that is not `0` at any unit vector of `ℚ(√m)²`. (Points with
`a ≡ d`, `b ≡ c (mod 2)`; `ψ = ((a − d + b + c)/2, b + d) mod 2`.) -/
theorem exists_addMonoidHom_three_mod_eight {m : ℕ} (hm : m % 8 = 3) :
    ∃ (Λ : AddSubgroup ℂ) (ψ : Λ →+ ZMod 2 × ZMod 2),
      ∀ u ∈ unitVectors (fieldOfRadicands {m}), ∃ hu : u ∈ Λ, ψ ⟨u, hu⟩ ≠ 0 := by
  sorry

/-! ## §4 The two rows -/

/-- **NF4-DYADIC-TWO, kernel form** (`[Fischer1990]`'s value; prior art): the plane over `ℚ(√m)` is two-colourable for
squarefree `m ≢ 3 (mod 4)`. (`m = 1` is `ℚ`, a subfield of `ℚ(√2)`. Squarefreeness is read twice: `4 ∤ m`, and `m` is
not a square unless `m = 1`.) -/
theorem colorable_two_planeOver_sqrt {m : ℕ} (hm : Squarefree m) (h4 : m % 4 ≠ 3) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).Colorable 2 := by
  sorry

/-- **NF4-DYADIC-FOUR, kernel form** (prior art: the residue colouring at the dyadic prime, `𝔽₄`-valued): the plane over
`ℚ(√m)` is four-colourable for `m ≡ 3 (mod 8)`. -/
theorem colorable_four_planeOver_sqrt {m : ℕ} (h8 : m % 8 = 3) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).Colorable 4 := by
  obtain ⟨Λ, ψ, h⟩ := exists_addMonoidHom_three_mod_eight h8
  have hcard : Nat.card (ZMod 2 × ZMod 2) = 4 := by
    rw [Nat.card_eq_fintype_card]; rfl
  have hcol := colorable_planeOver_of_addMonoidHom ψ h
  rwa [hcard] at hcol

/-! ## Spec -/

-- The classes: `2`, `5`, `17` are not `3 (mod 4)`; `3`, `11`, `35` are `3 (mod 8)`; `7`, `23`, `47` are neither.
example : 2 % 4 ≠ 3 ∧ 5 % 4 ≠ 3 ∧ 17 % 4 ≠ 3 ∧ 3 % 8 = 3 ∧ 11 % 8 = 3 ∧ 35 % 8 = 3 ∧ 47 % 8 ≠ 3 := by norm_num
example : ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).Colorable 4 :=
  colorable_four_planeOver_sqrt (by norm_num)
-- The shape lemmas' hypotheses and both alternatives at solutions: `1` itself (`N` odd), and with `N ≡ 2 (mod 4)`
-- the vector `(1 + i√3)/2` at `m = 3` and `(√2 + i√2)/2` at `m = 2`.
example : (1 : ℤ) ^ 2 + 0 ^ 2 + (3 : ℕ) * (0 ^ 2 + 1 ^ 2) = 2 ^ 2 ∧ (1 : ℤ) * 0 + 0 * 1 = 0 ∧
    (2 : ℤ) % 4 = 2 ∧ (2 : ℤ) ∣ 1 - 1 ∧ (2 : ℤ) ∣ 0 - 0 ∧ Odd ((0 : ℤ) + 1) := by decide
example : (0 : ℤ) ^ 2 + 0 ^ 2 + (2 : ℕ) * (1 ^ 2 + 1 ^ 2) = 2 ^ 2 ∧ (2 : ℤ) % 4 = 2 ∧
    Odd ((0 : ℤ) / 2 + 0 / 2 + 1) := by decide

end HadwigerNelson.DyadicQuadratic
