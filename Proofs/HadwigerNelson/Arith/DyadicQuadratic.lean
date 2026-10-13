import Proofs.HadwigerNelson.Arith.TorsionExtraction

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

**The route** (`plans/FS131-KN5-three-four-colours-passes.md` § Stage 5): integers only — no order of `ℚ(√m, i)`, no
valuation, no localization. A unit vector of `ℚ(√m)²` is `u = (a + b√m + c·i + d·i√m)/N` with integers
(`exists_rat_add_mul_sqrt_eq`), and `|u| = 1` reads `a² + c² + m(b² + d²) = N²`, `ab + cd = 0` (`√m` is irrational in
each class). For a solution not all even, the class of `m` fixes the shape of `(a, b, c, d, N)` modulo 4
(`dyadic_shape_one_mod_four`, `…_two_mod_four`, `…_three_mod_eight`): `N` is odd or twice an odd number, and one
additive map `ψ` on the lattice of points of that shape — into `𝔽₂`, or into `𝔽₂ × 𝔽₂` when `m ≡ 3 (mod 8)` — is never
`0` at a unit vector (`exists_addMonoidHom_…`). `colorable_planeOver_of_addMonoidHom` — the residue colouring,
`ResidueColouring.colorable_of_residue`, read at the plane — then colours with `|𝔽₂| = 2` or `|𝔽₂ × 𝔽₂| = 4` colours.
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

open HadwigerNelson.CharacterColouring HadwigerNelson.SpectralChain HadwigerNelson.SquareClass SimpleGraph

/-! ## §1 The residue colouring, read at the plane -/

/-- **An additive map that is never `0` at a unit vector colours the plane.** `Λ` an additive subgroup of `ℂ` holding
the unit vectors of `F²`, `ψ : Λ →+ G` into a finite group with `ψ u ≠ 0` at each of them: the plane over `F` is
`|G|`-colourable (colour each coset of `Λ` by `ψ`; `ResidueColouring.colorable_of_residue`). Every subfield `F ⊆ ℝ`.
Its case `Λ = ℤ[U_F]`, `ψ` a ring homomorphism, is `ResidueColouring.colorable_unitDistance_induce_of_residue`. -/
theorem colorable_planeOver_of_addMonoidHom {F : Subfield ℝ} {Λ : AddSubgroup ℂ} {G : Type*} [AddCommGroup G]
    [Finite G] (ψ : Λ →+ G) (h : ∀ u ∈ unitVectors F, ∃ hu : u ∈ Λ, ψ ⟨u, hu⟩ ≠ 0) :
    ((unitDistance ℂ).induce (planeOver F)).Colorable (Nat.card G) := by
  sorry

/-! ## §2 Coordinates, and the shape of a unit vector modulo 4 -/

/-- **Coordinates in `ℚ(√m)`**: every element is `p + q√m` with `p, q` rational. -/
theorem exists_rat_add_mul_sqrt_eq {m : ℕ} {x : ℝ} (hx : x ∈ fieldOfRadicands {m}) :
    ∃ p q : ℚ, x = p + q * Real.sqrt m := by
  sorry

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
