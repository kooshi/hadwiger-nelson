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

/-! ### The finite check behind the three shape lemmas

`Q1` is read modulo 8 and `Q2` modulo 4, and both depend only on the residues of `a, b, c, d, N` modulo 4
(`x² ≡ (x mod 4)² (mod 8)`). So each shape lemma is one exhaustion over `4⁵` residue tuples per value of `m` modulo 8
(`shapeCheck`, by `decide +kernel`), carried to the integers once (`shape_of_check`) and read back by `omega`. The one
case the residues modulo 4 do not decide — `a, b, c, d` all odd at `m ≡ 3 (mod 8)` — is `not_odd_of_three_mod_eight`. -/

/-- The exhaustion: for every `m` of the list (a residue modulo 8) and all residues `a b c d n` modulo 4, if `Q1`
holds modulo 8, `Q2` modulo 4 and the five are not all even, then `P a b c d n`. -/
private def shapeCheck (ms : List ℕ) (P : ℕ → ℕ → ℕ → ℕ → ℕ → Prop) [∀ a b c d n, Decidable (P a b c d n)] : Bool :=
  ms.all fun m => (List.range 4).all fun a => (List.range 4).all fun b => (List.range 4).all fun c =>
    (List.range 4).all fun d => (List.range 4).all fun n =>
      decide ((a * a + c * c + m * (b * b + d * d)) % 8 = (n * n) % 8 → (a * b + c * d) % 4 = 0 →
        ¬ (a % 2 = 0 ∧ b % 2 = 0 ∧ c % 2 = 0 ∧ d % 2 = 0 ∧ n % 2 = 0) → P a b c d n)

/-- The residue of an integer modulo 4, as a natural number. -/
private theorem exists_nat_eq_emod_four (x : ℤ) : ∃ r : ℕ, r < 4 ∧ (r : ℤ) = x % 4 :=
  ⟨(x % 4).toNat, by omega, by omega⟩

/-- A square modulo 8 is read from the residue modulo 4. -/
private theorem emod_four_mul_self_modEq (x : ℤ) : x % 4 * (x % 4) ≡ x ^ 2 [ZMOD 8] := by
  have hx : x = 4 * (x / 4) + x % 4 := by omega
  generalize x / 4 = q at hx
  generalize x % 4 = r at hx
  subst hx
  rw [Int.modEq_iff_dvd]
  exact ⟨q * (2 * q + r), by ring⟩

/-- **The exhaustion, carried to the integers.** If the check passes for the residues of `m` modulo 8, an integer
solution of `Q1`, `Q2`, not all even, has residues modulo 4 satisfying `P`. -/
private theorem shape_of_check {ms : List ℕ} {P : ℕ → ℕ → ℕ → ℕ → ℕ → Prop} [∀ a b c d n, Decidable (P a b c d n)]
    (hchk : shapeCheck ms P = true) {m : ℕ} (hm : m % 8 ∈ ms) {a b c d N : ℤ}
    (h1 : a ^ 2 + c ^ 2 + (m : ℤ) * (b ^ 2 + d ^ 2) = N ^ 2) (h2 : a * b + c * d = 0)
    (hp : ¬ (2 ∣ a ∧ 2 ∣ b ∧ 2 ∣ c ∧ 2 ∣ d ∧ 2 ∣ N)) :
    ∃ ra rb rc rd rn : ℕ, (ra : ℤ) = a % 4 ∧ (rb : ℤ) = b % 4 ∧ (rc : ℤ) = c % 4 ∧ (rd : ℤ) = d % 4 ∧
      (rn : ℤ) = N % 4 ∧ P ra rb rc rd rn := by
  obtain ⟨ra, hra4, hra⟩ := exists_nat_eq_emod_four a
  obtain ⟨rb, hrb4, hrb⟩ := exists_nat_eq_emod_four b
  obtain ⟨rc, hrc4, hrc⟩ := exists_nat_eq_emod_four c
  obtain ⟨rd, hrd4, hrd⟩ := exists_nat_eq_emod_four d
  obtain ⟨rn, hrn4, hrn⟩ := exists_nat_eq_emod_four N
  refine ⟨ra, rb, rc, rd, rn, hra, hrb, hrc, hrd, hrn, ?_⟩
  have h := of_decide_eq_true (List.all_eq_true.mp (List.all_eq_true.mp (List.all_eq_true.mp (List.all_eq_true.mp
    (List.all_eq_true.mp (List.all_eq_true.mp hchk (m % 8) hm) ra (List.mem_range.mpr hra4))
    rb (List.mem_range.mpr hrb4)) rc (List.mem_range.mpr hrc4)) rd (List.mem_range.mpr hrd4))
    rn (List.mem_range.mpr hrn4))
  refine h ?_ ?_ ?_
  · have e1 : ((ra * ra + rc * rc + m % 8 * (rb * rb + rd * rd) : ℕ) : ℤ) ≡ ((rn * rn : ℕ) : ℤ) [ZMOD 8] := by
      push_cast
      rw [hra, hrb, hrc, hrd, hrn]
      calc a % 4 * (a % 4) + c % 4 * (c % 4) + (m : ℤ) % 8 * (b % 4 * (b % 4) + d % 4 * (d % 4))
          ≡ a ^ 2 + c ^ 2 + (m : ℤ) * (b ^ 2 + d ^ 2) [ZMOD 8] :=
            ((emod_four_mul_self_modEq a).add (emod_four_mul_self_modEq c)).add
              ((Int.mod_modEq (m : ℤ) 8).mul ((emod_four_mul_self_modEq b).add (emod_four_mul_self_modEq d)))
        _ = N ^ 2 := h1
        _ ≡ N % 4 * (N % 4) [ZMOD 8] := (emod_four_mul_self_modEq N).symm
    exact Int.natCast_modEq_iff.mp e1
  · have e2 : ((ra * rb + rc * rd : ℕ) : ℤ) ≡ ((0 : ℕ) : ℤ) [ZMOD 4] := by
      push_cast
      rw [hra, hrb, hrc, hrd]
      calc a % 4 * (b % 4) + c % 4 * (d % 4) ≡ a * b + c * d [ZMOD 4] :=
            ((Int.mod_modEq a 4).mul (Int.mod_modEq b 4)).add ((Int.mod_modEq c 4).mul (Int.mod_modEq d 4))
        _ = 0 := h2
    exact Int.natCast_modEq_iff.mp e2
  · intro hall
    exact hp (by omega)

/-- An odd square is `1` modulo 8. -/
private theorem sq_emod_eight_of_odd {x : ℤ} (hx : x % 2 = 1) : x ^ 2 % 8 = 1 := by
  have h := emod_four_mul_self_modEq x
  unfold Int.ModEq at h
  have h4 : x % 4 = 1 ∨ x % 4 = 3 := by omega
  rcases h4 with h4 | h4 <;> rw [h4] at h <;> omega

/-- No square is `8` modulo 16. -/
private theorem sq_emod_sixteen_ne_eight (x : ℤ) : x ^ 2 % 16 ≠ 8 := by
  have hx : x = 4 * (x / 4) + x % 4 := by omega
  have h4 : x % 4 = 0 ∨ x % 4 = 1 ∨ x % 4 = 2 ∨ x % 4 = 3 := by omega
  generalize x / 4 = q at hx
  rcases h4 with h4 | h4 | h4 | h4 <;> rw [h4] at hx <;> subst hx <;> ring_nf <;> omega

/-- **The all-odd case at `m ≡ 3 (mod 8)`.** With `b`, `c`, `d` odd the two equations have no solution:
`(b² + d²)(c² + m b²) = (N b)²` (from `b²·Q1 − (ab − cd)·Q2`), and the left side is `2·4 ≡ 8 (mod 16)`. -/
private theorem not_odd_of_three_mod_eight {m : ℕ} (hm : m % 8 = 3) {a b c d N : ℤ}
    (h1 : a ^ 2 + c ^ 2 + (m : ℤ) * (b ^ 2 + d ^ 2) = N ^ 2) (h2 : a * b + c * d = 0)
    (hb : b % 2 = 1) (hc : c % 2 = 1) (hd : d % 2 = 1) : False := by
  have key : (b ^ 2 + d ^ 2) * (c ^ 2 + (m : ℤ) * b ^ 2) = (N * b) ^ 2 := by
    linear_combination b ^ 2 * h1 - (a * b - c * d) * h2
  have hB := sq_emod_eight_of_odd hb
  have hC := sq_emod_eight_of_odd hc
  have hD := sq_emod_eight_of_odd hd
  have hm8 : (m : ℤ) % 8 = 3 := by omega
  have hmB : (m : ℤ) * b ^ 2 % 8 = 3 := by rw [Int.mul_emod, hm8, hB]; rfl
  obtain ⟨s, hs⟩ : ∃ s, b ^ 2 + d ^ 2 = 8 * s + 2 := ⟨(b ^ 2 + d ^ 2) / 8, by omega⟩
  obtain ⟨t, ht⟩ : ∃ t, c ^ 2 + (m : ℤ) * b ^ 2 = 8 * t + 4 := ⟨(c ^ 2 + (m : ℤ) * b ^ 2) / 8, by omega⟩
  have h16 : (N * b) ^ 2 = 16 * (4 * s * t + 2 * s + t) + 8 := by
    rw [← key, hs, ht]
    ring
  exact sq_emod_sixteen_ne_eight (N * b) (by rw [h16]; omega)

/-- **The shape of a unit vector, `m ≡ 1 (mod 4)`.** An integer solution of `a² + c² + m(b² + d²) = N²`, `ab + cd = 0`,
not all even: `N` is odd and `a + b + c + d` is odd, or `N ≡ 2 (mod 4)`, `a ≡ b`, `c ≡ d (mod 2)` and
`(a − b + c − d)/2` is odd. -/
theorem dyadic_shape_one_mod_four {m : ℕ} (hm : m % 4 = 1) {a b c d N : ℤ}
    (h1 : a ^ 2 + c ^ 2 + (m : ℤ) * (b ^ 2 + d ^ 2) = N ^ 2) (h2 : a * b + c * d = 0)
    (hp : ¬ (2 ∣ a ∧ 2 ∣ b ∧ 2 ∣ c ∧ 2 ∣ d ∧ 2 ∣ N)) :
    (Odd N ∧ Odd (a + b + c + d)) ∨
      (N % 4 = 2 ∧ 2 ∣ a - b ∧ 2 ∣ c - d ∧ Odd ((a - b + c - d) / 2)) := by
  have hm8 : m % 8 ∈ [1, 5] := by
    simp only [List.mem_cons, List.not_mem_nil, or_false]
    omega
  obtain ⟨ra, rb, rc, rd, rn, hra, hrb, hrc, hrd, hrn, h⟩ := shape_of_check
    (P := fun a b c d n => (n % 2 = 1 ∧ (a + b + c + d) % 2 = 1) ∨
      (n % 4 = 2 ∧ (a + b) % 2 = 0 ∧ (c + d) % 2 = 0 ∧ (a + 3 * b + c + 3 * d) % 4 = 2))
    (by decide +kernel) hm8 h1 h2 hp
  simp only [Int.odd_iff]
  omega

/-- **The shape of a unit vector, `m ≡ 2 (mod 4)`.** As above: `N` is odd and `a + c` is odd, or `N ≡ 2 (mod 4)`,
`a` and `c` are even, `b` and `d` are odd and `a/2 + c/2 + d` is odd. -/
theorem dyadic_shape_two_mod_four {m : ℕ} (hm : m % 4 = 2) {a b c d N : ℤ}
    (h1 : a ^ 2 + c ^ 2 + (m : ℤ) * (b ^ 2 + d ^ 2) = N ^ 2) (h2 : a * b + c * d = 0)
    (hp : ¬ (2 ∣ a ∧ 2 ∣ b ∧ 2 ∣ c ∧ 2 ∣ d ∧ 2 ∣ N)) :
    (Odd N ∧ Odd (a + c)) ∨
      (N % 4 = 2 ∧ 2 ∣ a ∧ 2 ∣ c ∧ Odd b ∧ Odd d ∧ Odd (a / 2 + c / 2 + d)) := by
  have hm8 : m % 8 ∈ [2, 6] := by
    simp only [List.mem_cons, List.not_mem_nil, or_false]
    omega
  obtain ⟨ra, rb, rc, rd, rn, hra, hrb, hrc, hrd, hrn, h⟩ := shape_of_check
    (P := fun a b c d n => (n % 2 = 1 ∧ (a + c) % 2 = 1) ∨
      (n % 4 = 2 ∧ a % 2 = 0 ∧ c % 2 = 0 ∧ b % 2 = 1 ∧ d % 2 = 1 ∧ (a / 2 + c / 2 + d) % 2 = 1))
    (by decide +kernel) hm8 h1 h2 hp
  simp only [Int.odd_iff]
  omega

/-- **The shape of a unit vector, `m ≡ 3 (mod 8)`.** As above: `N` is odd and `a + b + c + d` is odd, or
`N ≡ 2 (mod 4)`, `a ≡ d`, `b ≡ c (mod 2)` and `b + d` is odd. (At `m ≡ 7 (mod 8)` it fails: `(3 + i√7)/4`.) -/
theorem dyadic_shape_three_mod_eight {m : ℕ} (hm : m % 8 = 3) {a b c d N : ℤ}
    (h1 : a ^ 2 + c ^ 2 + (m : ℤ) * (b ^ 2 + d ^ 2) = N ^ 2) (h2 : a * b + c * d = 0)
    (hp : ¬ (2 ∣ a ∧ 2 ∣ b ∧ 2 ∣ c ∧ 2 ∣ d ∧ 2 ∣ N)) :
    (Odd N ∧ Odd (a + b + c + d)) ∨ (N % 4 = 2 ∧ 2 ∣ a - d ∧ 2 ∣ b - c ∧ Odd (b + d)) := by
  have hm8 : m % 8 ∈ [3] := by
    simp only [List.mem_cons, List.not_mem_nil, or_false]
    omega
  obtain ⟨ra, rb, rc, rd, rn, hra, hrb, hrc, hrd, hrn, h⟩ := shape_of_check
    (P := fun a b c d n => (b % 2 = 1 ∧ c % 2 = 1 ∧ d % 2 = 1) ∨ (n % 2 = 1 ∧ (a + b + c + d) % 2 = 1) ∨
      (n % 4 = 2 ∧ (a + d) % 2 = 0 ∧ (b + c) % 2 = 0 ∧ (b + d) % 2 = 1))
    (by decide +kernel) hm8 h1 h2 hp
  rcases h with hodd | h
  · exact (not_odd_of_three_mod_eight hm h1 h2 (by omega) (by omega) (by omega)).elim
  · simp only [Int.odd_iff]
    omega

/-! ## §3 The lattice and its additive map, class by class -/

/-! ### Reduction modulo 2 on the rationals of odd denominator

The additive map of each class is `red ∘ s` for one integer form `s` on `ℚ⁴` (two forms when `m ≡ 3 (mod 8)`), on the
subgroup of `ℚ⁴` where `s` has odd denominator, carried to `ℂ` by the coordinates `(p₁ + p₂√m) + (p₃ + p₄√m)·i`. That
subgroup is larger than the lattice of points of the unit vectors' shape; the leaves ask only for some subgroup. -/

/-- The rationals of odd denominator, an additive subgroup of `ℚ` (the localization of `ℤ` at 2). -/
private def oddDen : AddSubgroup ℚ where
  carrier := {q | Odd q.den}
  zero_mem' := by
    show Odd (0 : ℚ).den
    rw [Rat.den_zero]
    exact odd_one
  add_mem' := fun {q r} hq hr => Odd.of_dvd_nat (Odd.mul hq hr) (Rat.add_den_dvd q r)
  neg_mem' := fun {q} hq => by
    show Odd (-q).den
    rw [Rat.neg_den]
    exact hq

private theorem natCast_den_ne_zero {q : ℚ} (hq : q ∈ oddDen) : ((q.den : ℕ) : ZMod 2) ≠ 0 := by
  rw [Ne, ZMod.natCast_eq_zero_iff_even]
  exact Nat.not_even_iff_odd.mpr hq

/-- Reduction modulo 2 on the rationals of odd denominator: `Rat.cast` into the field `ZMod 2`, additive there. -/
private def red : oddDen →+ ZMod 2 where
  toFun q := ((q : ℚ) : ZMod 2)
  map_zero' := Rat.cast_zero
  map_add' q r := Rat.cast_add_of_ne_zero (natCast_den_ne_zero q.2) (natCast_den_ne_zero r.2)

/-- An integer over an odd integer has odd denominator. -/
private theorem mem_oddDen_of_eq_div {q : ℚ} {z M : ℤ} (hM : Odd M) (h : q = (z : ℚ) / M) : q ∈ oddDen := by
  have hdvd : ((q.den : ℕ) : ℤ) ∣ M := by
    rw [h, ← Rat.divInt_eq_div]
    exact Rat.den_dvd z M
  show Odd q.den
  rw [← Nat.not_even_iff_odd, even_iff_two_dvd]
  intro h2
  have h2M : (2 : ℤ) ∣ M := dvd_trans (by exact_mod_cast h2) hdvd
  exact Int.not_even_iff_odd.mpr hM (even_iff_two_dvd.mpr h2M)

/-- An odd integer over an integer, of odd denominator, does not reduce to `0`. -/
private theorem red_ne_zero {q : ℚ} (hq : q ∈ oddDen) {z M : ℤ} (hz : Odd z) (h : (M : ℚ) * q = z) :
    red ⟨q, hq⟩ ≠ 0 := by
  intro h0
  have hzmem : (z : ℚ) ∈ oddDen := by
    show Odd (z : ℚ).den
    rw [Rat.den_intCast]
    exact odd_one
  have hsm : M • (⟨q, hq⟩ : oddDen) = ⟨(z : ℚ), hzmem⟩ :=
    Subtype.ext (by rw [AddSubgroup.coe_zsmul, zsmul_eq_mul]; exact h)
  have hred : red ⟨(z : ℚ), hzmem⟩ = (z : ZMod 2) := Rat.cast_intCast z
  have h2 := congrArg red hsm
  rw [map_zsmul, h0, smul_zero, hred] at h2
  have hdvd : ((2 : ℕ) : ℤ) ∣ z := (ZMod.intCast_zmod_eq_zero_iff_dvd z 2).mp h2.symm
  have hodd := Int.odd_iff.mp hz
  omega

/-- The integer form `k₁p₁ + k₂p₂ + k₃p₃ + k₄p₄` on `ℚ⁴`. -/
private def form (k₁ k₂ k₃ k₄ : ℤ) : ℚ × ℚ × ℚ × ℚ →+ ℚ :=
  AddMonoidHom.mk' (fun p => k₁ * p.1 + k₂ * p.2.1 + k₃ * p.2.2.1 + k₄ * p.2.2.2)
    (fun p q => by simp only [Prod.fst_add, Prod.snd_add]; ring)

/-- The value of a form at `(a, b, c, d)/N`, as an integer over an odd one. -/
private theorem form_div_eq {k₁ k₂ k₃ k₄ a b c d N z M : ℤ} (hN : N ≠ 0) (hM : Odd M)
    (e : (k₁ * a + k₂ * b + k₃ * c + k₄ * d) * M = z * N) :
    form k₁ k₂ k₃ k₄ ((a : ℚ) / N, (b : ℚ) / N, (c : ℚ) / N, (d : ℚ) / N) = (z : ℚ) / M := by
  have hN' : (N : ℚ) ≠ 0 := by exact_mod_cast hN
  have hM' : (M : ℚ) ≠ 0 := by
    have hodd := Int.odd_iff.mp hM
    have hM0 : M ≠ 0 := by omega
    exact_mod_cast hM0
  have e' : ((k₁ : ℚ) * a + k₂ * b + k₃ * c + k₄ * d) * M = z * N := by exact_mod_cast e
  simp only [form, AddMonoidHom.mk'_apply]
  rw [eq_div_iff hM']
  field_simp
  linear_combination e'

/-- The coordinates: `(p₁, p₂, p₃, p₄) ↦ (p₁ + p₂√m) + (p₃ + p₄√m)·i`, an additive map `ℚ⁴ → ℂ`. -/
private noncomputable def coordHom (m : ℕ) : ℚ × ℚ × ℚ × ℚ →+ ℂ :=
  AddMonoidHom.mk' (fun p => (((p.1 : ℝ) + (p.2.1 : ℝ) * Real.sqrt m : ℝ) : ℂ) +
      (((p.2.2.1 : ℝ) + (p.2.2.2 : ℝ) * Real.sqrt m : ℝ) : ℂ) * Complex.I)
    (fun p q => by simp only [Prod.fst_add, Prod.snd_add]; push_cast; ring)

private theorem coordHom_injective {m : ℕ} (hsq : ¬ IsSquare m) : Function.Injective (coordHom m) := by
  rw [injective_iff_map_eq_zero]
  intro p hp
  have hirr : Irrational (Real.sqrt m) := irrational_sqrt_natCast_iff.mpr hsq
  have hre : (p.1 : ℝ) + (p.2.1 : ℝ) * Real.sqrt m = 0 := by
    have h := congrArg Complex.re hp
    simpa [coordHom] using h
  have him : (p.2.2.1 : ℝ) + (p.2.2.2 : ℝ) * Real.sqrt m = 0 := by
    have h := congrArg Complex.im hp
    simpa [coordHom] using h
  obtain ⟨h1, h2⟩ := rat_eq_zero_of_add_mul_irrational hirr hre
  obtain ⟨h3, h4⟩ := rat_eq_zero_of_add_mul_irrational hirr him
  exact Prod.ext h1 (Prod.ext h2 (Prod.ext h3 h4))

/-- **From `ℚ⁴` to the plane.** An additive map on a subgroup `Γ` of `ℚ⁴` that is not `0` at `(a, b, c, d)/N` for
every integer solution not all even gives one on a subgroup of `ℂ` that is not `0` at any unit vector of `ℚ(√m)²`
(the image of `Γ` under the coordinates, which are injective: `√m` is irrational). -/
private theorem exists_addMonoidHom_of_lattice {m : ℕ} (hsq : ¬ IsSquare m) {G : Type*} [AddCommGroup G]
    (Γ : AddSubgroup (ℚ × ℚ × ℚ × ℚ)) (ψ₀ : Γ →+ G)
    (h : ∀ a b c d N : ℤ, N ≠ 0 → ¬ (2 ∣ a ∧ 2 ∣ b ∧ 2 ∣ c ∧ 2 ∣ d ∧ 2 ∣ N) →
      a ^ 2 + c ^ 2 + (m : ℤ) * (b ^ 2 + d ^ 2) = N ^ 2 → a * b + c * d = 0 →
      ∃ hmem : ((a : ℚ) / N, (b : ℚ) / N, (c : ℚ) / N, (d : ℚ) / N) ∈ Γ, ψ₀ ⟨_, hmem⟩ ≠ 0) :
    ∃ (Λ : AddSubgroup ℂ) (ψ : Λ →+ G),
      ∀ u ∈ unitVectors (fieldOfRadicands {m}), ∃ hu : u ∈ Λ, ψ ⟨u, hu⟩ ≠ 0 := by
  have he := coordHom_injective hsq
  refine ⟨Γ.map (coordHom m), ψ₀.comp (Γ.equivMapOfInjective (coordHom m) he).symm.toAddMonoidHom, ?_⟩
  intro u hu
  obtain ⟨a, b, c, d, N, hN, hp, h1, h2, h3⟩ := exists_int_solution_of_mem_unitVectors hsq hu
  obtain ⟨hmem, hne⟩ := h a b c d N hN hp h1 h2
  have hu_eq : coordHom m ((a : ℚ) / N, (b : ℚ) / N, (c : ℚ) / N, (d : ℚ) / N) = u := by
    have hN' : (N : ℂ) ≠ 0 := by exact_mod_cast hN
    apply mul_left_cancel₀ hN'
    rw [h3]
    simp only [coordHom, AddMonoidHom.mk'_apply]
    push_cast
    field_simp
  have hmemΛ : u ∈ Γ.map (coordHom m) := ⟨_, hmem, hu_eq⟩
  refine ⟨hmemΛ, ?_⟩
  have hsymm : (Γ.equivMapOfInjective (coordHom m) he).symm ⟨u, hmemΛ⟩ = ⟨_, hmem⟩ := by
    rw [AddEquiv.symm_apply_eq]
    exact Subtype.ext hu_eq.symm
  show ψ₀ ((Γ.equivMapOfInjective (coordHom m) he).symm ⟨u, hmemΛ⟩) ≠ 0
  rw [hsymm]
  exact hne

/-- **One form.** If an integer form takes at every integer solution not all even a value `z·N/M` with `z` and `M`
odd, the form's reduction modulo 2 is the additive map of the class. -/
private theorem exists_addMonoidHom_of_form {m : ℕ} (hsq : ¬ IsSquare m) (k₁ k₂ k₃ k₄ : ℤ)
    (h : ∀ a b c d N : ℤ, N ≠ 0 → ¬ (2 ∣ a ∧ 2 ∣ b ∧ 2 ∣ c ∧ 2 ∣ d ∧ 2 ∣ N) →
      a ^ 2 + c ^ 2 + (m : ℤ) * (b ^ 2 + d ^ 2) = N ^ 2 → a * b + c * d = 0 →
      ∃ M z : ℤ, Odd M ∧ Odd z ∧ (k₁ * a + k₂ * b + k₃ * c + k₄ * d) * M = z * N) :
    ∃ (Λ : AddSubgroup ℂ) (ψ : Λ →+ ZMod 2),
      ∀ u ∈ unitVectors (fieldOfRadicands {m}), ∃ hu : u ∈ Λ, ψ ⟨u, hu⟩ ≠ 0 := by
  refine exists_addMonoidHom_of_lattice hsq (oddDen.comap (form k₁ k₂ k₃ k₄))
    (red.comp ((form k₁ k₂ k₃ k₄).addSubgroupComap oddDen)) ?_
  intro a b c d N hN hp h1 h2
  obtain ⟨M, z, hM, hz, e⟩ := h a b c d N hN hp h1 h2
  have hq := form_div_eq hN hM e
  have hmem : form k₁ k₂ k₃ k₄ ((a : ℚ) / N, (b : ℚ) / N, (c : ℚ) / N, (d : ℚ) / N) ∈ oddDen :=
    mem_oddDen_of_eq_div hM hq
  have hM' : (M : ℚ) ≠ 0 := by
    have hodd := Int.odd_iff.mp hM
    have hM0 : M ≠ 0 := by omega
    exact_mod_cast hM0
  exact ⟨hmem, red_ne_zero hmem hz (M := M) (by rw [hq]; field_simp)⟩

/-- No natural number that is `2` or `3` modulo 4 is a square. -/
private theorem not_isSquare_of_mod_four {m : ℕ} (h : m % 4 = 2 ∨ m % 4 = 3) : ¬ IsSquare m := by
  rintro ⟨r, rfl⟩
  have hmul := Nat.mul_mod r r 4
  have hr : r % 4 = 0 ∨ r % 4 = 1 ∨ r % 4 = 2 ∨ r % 4 = 3 := by omega
  rcases hr with hr | hr | hr | hr <;> rw [hr] at hmul <;> omega

/-- **`m ≡ 1 (mod 4)`, not a square**: an additive map into `𝔽₂`, on a subgroup of `ℂ` holding the unit vectors of
`ℚ(√m)²`, that is not `0` at any of them. (Points `(a + b√m + c·i + d·i√m)/(2N)`, `N` odd, `a ≡ b`, `c ≡ d (mod 2)`;
`ψ = (a − b + c − d)/2 mod 2`.) -/
theorem exists_addMonoidHom_one_mod_four {m : ℕ} (hm : m % 4 = 1) (hsq : ¬ IsSquare m) :
    ∃ (Λ : AddSubgroup ℂ) (ψ : Λ →+ ZMod 2),
      ∀ u ∈ unitVectors (fieldOfRadicands {m}), ∃ hu : u ∈ Λ, ψ ⟨u, hu⟩ ≠ 0 := by
  -- the form `p₁ − p₂ + p₃ − p₄`
  refine exists_addMonoidHom_of_form hsq 1 (-1) 1 (-1) fun a b c d N hN hp h1 h2 => ?_
  rcases dyadic_shape_one_mod_four hm h1 h2 hp with ⟨hNodd, hodd⟩ | ⟨hN4, hab, hcd, hodd⟩
  · refine ⟨N, 1 * a + -1 * b + 1 * c + -1 * d, hNodd, ?_, rfl⟩
    rw [Int.odd_iff] at hodd ⊢
    omega
  · obtain ⟨M, rfl⟩ : ∃ M, N = 2 * M := ⟨N / 2, by omega⟩
    obtain ⟨z, hz⟩ : ∃ z, a - b + c - d = 2 * z := ⟨(a - b + c - d) / 2, by omega⟩
    refine ⟨M, z, ?_, ?_, by linear_combination M * hz⟩
    · rw [Int.odd_iff]
      omega
    · rw [Int.odd_iff] at hodd ⊢
      omega

/-- **`m ≡ 2 (mod 4)`**: the same. (Points with `a`, `c` even and `b ≡ d (mod 2)`; `ψ = a/2 + c/2 + d mod 2`.) -/
theorem exists_addMonoidHom_two_mod_four {m : ℕ} (hm : m % 4 = 2) :
    ∃ (Λ : AddSubgroup ℂ) (ψ : Λ →+ ZMod 2),
      ∀ u ∈ unitVectors (fieldOfRadicands {m}), ∃ hu : u ∈ Λ, ψ ⟨u, hu⟩ ≠ 0 := by
  -- the form `p₁ + p₃ + 2p₄`
  refine exists_addMonoidHom_of_form (not_isSquare_of_mod_four (Or.inl hm)) 1 0 1 2
    fun a b c d N hN hp h1 h2 => ?_
  rcases dyadic_shape_two_mod_four hm h1 h2 hp with ⟨hNodd, hodd⟩ | ⟨hN4, ha, hc, -, hd, hodd⟩
  · refine ⟨N, 1 * a + 0 * b + 1 * c + 2 * d, hNodd, ?_, rfl⟩
    rw [Int.odd_iff] at hodd ⊢
    omega
  · obtain ⟨M, rfl⟩ : ∃ M, N = 2 * M := ⟨N / 2, by omega⟩
    obtain ⟨z, hz⟩ : ∃ z, a + c + 2 * d = 2 * z := ⟨a / 2 + c / 2 + d, by omega⟩
    refine ⟨M, z, ?_, ?_, by linear_combination M * hz⟩
    · rw [Int.odd_iff]
      omega
    · rw [Int.odd_iff] at hodd ⊢
      omega

/-- **`m ≡ 3 (mod 8)`**: an additive map into `𝔽₂ × 𝔽₂` that is not `0` at any unit vector of `ℚ(√m)²`. (Points with
`a ≡ d`, `b ≡ c (mod 2)`; `ψ = ((a − d + b + c)/2, b + d) mod 2`.) -/
theorem exists_addMonoidHom_three_mod_eight {m : ℕ} (hm : m % 8 = 3) :
    ∃ (Λ : AddSubgroup ℂ) (ψ : Λ →+ ZMod 2 × ZMod 2),
      ∀ u ∈ unitVectors (fieldOfRadicands {m}), ∃ hu : u ∈ Λ, ψ ⟨u, hu⟩ ≠ 0 := by
  have hsq : ¬ IsSquare m := not_isSquare_of_mod_four (Or.inr (by omega))
  -- the forms `s₁ = p₁ + p₂ + p₃ − p₄` and `s₂ = 2p₄ − 2p₂`, on the subgroup where both have odd denominator
  refine exists_addMonoidHom_of_lattice hsq (oddDen.comap (form 1 1 1 (-1)) ⊓ oddDen.comap (form 0 (-2) 0 2))
    ((red.comp (((form 1 1 1 (-1)).addSubgroupComap oddDen).comp (AddSubgroup.inclusion inf_le_left))).prod
      (red.comp (((form 0 (-2) 0 2).addSubgroupComap oddDen).comp (AddSubgroup.inclusion inf_le_right))))
    fun a b c d N hN hp h1 h2 => ?_
  -- it is enough to write both forms' values over one odd `M`, one of the two numerators odd
  suffices hMz : ∃ M z₁ z₂ : ℤ, Odd M ∧ (1 * a + 1 * b + 1 * c + -1 * d) * M = z₁ * N ∧
      (0 * a + -2 * b + 0 * c + 2 * d) * M = z₂ * N ∧ (Odd z₁ ∨ Odd z₂) by
    obtain ⟨M, z₁, z₂, hM, e₁, e₂, hodd⟩ := hMz
    have hq₁ := form_div_eq hN hM e₁
    have hq₂ := form_div_eq hN hM e₂
    have hmem₁ := mem_oddDen_of_eq_div hM hq₁
    have hmem₂ := mem_oddDen_of_eq_div hM hq₂
    have hM' : (M : ℚ) ≠ 0 := by
      have hodd' := Int.odd_iff.mp hM
      have hM0 : M ≠ 0 := by omega
      exact_mod_cast hM0
    refine ⟨⟨hmem₁, hmem₂⟩, fun h0 => ?_⟩
    rcases hodd with hz | hz
    · exact red_ne_zero hmem₁ hz (M := M) (by rw [hq₁]; field_simp) (congrArg Prod.fst h0)
    · exact red_ne_zero hmem₂ hz (M := M) (by rw [hq₂]; field_simp) (congrArg Prod.snd h0)
  rcases dyadic_shape_three_mod_eight hm h1 h2 hp with ⟨hNodd, hodd⟩ | ⟨hN4, had, hbc, hodd⟩
  · refine ⟨N, 1 * a + 1 * b + 1 * c + -1 * d, 0 * a + -2 * b + 0 * c + 2 * d, hNodd, rfl, rfl, Or.inl ?_⟩
    rw [Int.odd_iff] at hodd ⊢
    omega
  · obtain ⟨M, rfl⟩ : ∃ M, N = 2 * M := ⟨N / 2, by omega⟩
    obtain ⟨z, hz⟩ : ∃ z, a + b + c - d = 2 * z := ⟨(a + b + c - d) / 2, by omega⟩
    refine ⟨M, z, d - b, ?_, by linear_combination M * hz, by ring, Or.inr ?_⟩
    · rw [Int.odd_iff]
      omega
    · rw [Int.odd_iff] at hodd ⊢
      omega

/-! ## §4 The two rows -/

/-- **NF4-DYADIC-TWO, kernel form** (`[Fischer1990]`'s value; prior art): the plane over `ℚ(√m)` is two-colourable for
squarefree `m ≢ 3 (mod 4)`. (`m = 1` is `ℚ`, a subfield of `ℚ(√2)`. Squarefreeness is read twice: `4 ∤ m`, and `m` is
not a square unless `m = 1`.) -/
theorem colorable_two_planeOver_sqrt {m : ℕ} (hm : Squarefree m) (h4 : m % 4 ≠ 3) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).Colorable 2 := by
  -- an additive map into `𝔽₂` is a two-colouring
  have key : ∀ {k : ℕ}, (∃ (Λ : AddSubgroup ℂ) (ψ : Λ →+ ZMod 2),
      ∀ u ∈ unitVectors (fieldOfRadicands {k}), ∃ hu : u ∈ Λ, ψ ⟨u, hu⟩ ≠ 0) →
      ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {k}))).Colorable 2 := by
    rintro k ⟨Λ, ψ, h⟩
    have hcol := colorable_planeOver_of_addMonoidHom ψ h
    rwa [Nat.card_zmod] at hcol
  have hmod : m % 4 = 0 ∨ m % 4 = 1 ∨ m % 4 = 2 := by omega
  rcases hmod with h0 | h1 | h2
  · -- `4 ∣ m` is against squarefreeness
    have hdvd : 2 * 2 ∣ m := ⟨m / 4, by omega⟩
    exact absurd (Nat.isUnit_iff.mp (hm 2 hdvd)) (by norm_num)
  · by_cases hm1 : m = 1
    · -- `ℚ(√1) = ℚ` lies in `ℚ(√2)`
      subst hm1
      have hle : fieldOfRadicands {1} ≤ fieldOfRadicands {2} := by
        refine Subfield.closure_le.mpr ?_
        rintro x ⟨d, hd, rfl⟩
        rw [Set.mem_singleton_iff] at hd
        subst hd
        simp only [Nat.cast_one, Real.sqrt_one]
        exact one_mem _
      have hsub : planeOver (fieldOfRadicands {1}) ⊆ planeOver (fieldOfRadicands {2}) :=
        fun z hz => ⟨hle hz.1, hle hz.2⟩
      exact SimpleGraph.Colorable.of_hom (SimpleGraph.induceHomOfLE _ hsub).toHom
        (key (exists_addMonoidHom_two_mod_four (by norm_num)))
    · -- a squarefree square is `1`
      have hsq : ¬ IsSquare m := by
        rintro ⟨r, rfl⟩
        have hr : r = 1 := Nat.isUnit_iff.mp (hm r (dvd_refl _))
        subst hr
        exact hm1 rfl
      exact key (exists_addMonoidHom_one_mod_four h1 hsq)
  · exact key (exists_addMonoidHom_two_mod_four h2)

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
