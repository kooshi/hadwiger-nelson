import Proofs.HadwigerNelson.SpectralChain
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

/-!
# The standing five: `F = K·E₇`, a field containing `K` whose plane needs five colours given MR (FS-131 wave 10; TC1-STANDING-FIVE)

**Read aloud, against the informal claim.** `plans/TC1-derivation.md:60`: "F = K·E₇, with K = ℚ(√3,√11) and E₇ the degree-7
subfield of ℚ(ζ₂₉), is a totally real field of degree 28 containing K; its two places above 2 are inert in F(i), each of norm
128, and none of its places has a usable residue field of size at most 47; so L(F) ≥ 7, and given MR, χ(F²) ≥ 5".

**The field.** `E₇ = ℚ(η)` with `η = ζ + ζ¹² + ζ¹⁷ + ζ²⁸ = 2cos(2π/29) + 2cos(24π/29)`, the Gaussian period of the subgroup
`{1, 12, 17, 28}` of order 4 of `(ℤ/29)ˣ` (`12² ≡ −1`); `standingField = ℚ(√3, √11, η) ⊆ ℝ`.

**What is unconditional** (leaves of this module): the field is a totally real number field of degree 28 containing `√3` and
`√11`; exactly two primes of `F(i)` lie above 2, both stable, each with residue field of `128²` elements on which conjugation
is not the identity (inert, norm 128); every usable residue field of `F` — a residue field of `𝓞 F` with `q ≡ 3 (mod 4)`
elements — has at least 347 elements (`usable_card_ge`; the row's "at most 47" is `no_small_usable`). The least is 347 by exact
arithmetic on the splitting law (`tools/fs131_k10_usable.py`): 347 splits completely, and the four smaller `p ≡ 3 (mod 4)` with
`p⁴ ≡ 1 (mod 29)` — 59, 191, 307, 331 — have even residue degree in `K`.

**What is not** (the statement defect FS131-K10 reported, inventory items 477–478): "so `L(F) ≥ 7`" needs a lower bound on the
chromatic number of every level-one target of `F` — an infinite family — which the row took from G56 (Weil's bound from 98 up,
`U₁₂₈`'s Hoffman floor) and which is neither in the kernel nor in the backlog. It enters as the named hypothesis
`StandingFloor n`: the floor at `U₁₂₈` and at every `Γ_Q` with `Q ≡ 3 (mod 4)`, `Q ≥ 347` (the Weil range only: no certificate
at 59–83 is an input at this field). The MR clause takes a second named hypothesis, `Row123Chain` in the plan's table: the
conclusion of `SpectralChain.min_localBound_five_le_chromaticNumber`, `min (L(F)) 5 ≤ χ(F²)`.

**Inhabitants.** `TargetFloor 0 Q` holds for every `Q` (`targetFloor_zero`), so `StandingFloor` is satisfiable at `n = 0`; at
`n = 7` it is G56's claim, [tools]/[hand] on Weil. A finite field with an involution of the stated shape exists for every prime
power `Q` (`GaloisField`), so `TargetFloor` does not quantify over an empty domain.
-/

namespace HadwigerNelson.StandingFive

open SpectralChain NumberField SimpleGraph

/-- The Gaussian period `η = ζ + ζ¹² + ζ¹⁷ + ζ²⁸` of conductor 29, as a real number. -/
noncomputable def eta : ℝ := 2 * Real.cos (2 * Real.pi / 29) + 2 * Real.cos (24 * Real.pi / 29)

/-- `E₇ = ℚ(η)`, the degree-7 subfield of `ℚ(ζ₂₉)`. -/
noncomputable def E7 : Subfield ℝ := Subfield.closure {eta}

/-- **`F = K·E₇ = ℚ(√3, √11, η)`.** -/
noncomputable def standingField : Subfield ℝ := Subfield.closure {Real.sqrt 3, Real.sqrt 11, eta}

theorem sqrt_three_mem : Real.sqrt 3 ∈ standingField := Subfield.subset_closure (by simp)

theorem sqrt_eleven_mem : Real.sqrt 11 ∈ standingField := Subfield.subset_closure (by simp)

theorem eta_mem : eta ∈ standingField := Subfield.subset_closure (by simp)

/-- `E₇ ⊆ F`. -/
theorem E7_le : E7 ≤ standingField := Subfield.closure_mono (by simp)

/-- `K = ℚ(√3, √11) ⊆ F`: "containing K". -/
theorem K_le : Subfield.closure {Real.sqrt 3, Real.sqrt 11} ≤ standingField :=
  Subfield.closure_mono (by intro x hx; rcases hx with rfl | rfl <;> simp)

/-! ### The unconditional clauses -/

/-- `F` is a number field. -/
theorem numberField_standingField : NumberField standingField := by
  sorry

/-- "of degree 28". -/
theorem finrank_standingField : Module.finrank ℚ standingField = 28 := by
  sorry

/-- "a totally real field": every embedding of `F` into `ℂ` is real (`F/ℚ` is Galois and `F ⊆ ℝ`). -/
theorem isTotallyReal_standingField (φ : standingField →+* ℂ) (x : standingField) : (φ x).im = 0 := by
  sorry

/-- "its two places above 2": exactly two primes of `F(i)` lie above 2. -/
theorem ncard_primes_above_two :
    Set.ncard {P : Ideal (𝓞 (fieldI standingField)) | P.IsMaximal ∧ (2 : 𝓞 (fieldI standingField)) ∈ P} = 2 := by
  sorry

/-- "are inert in F(i)", first half: every prime of `F(i)` above 2 is fixed by conjugation (a place of `F` not split). -/
theorem comap_conj_of_two_mem (P : Ideal (𝓞 (fieldI standingField))) (hP : P.IsMaximal)
    (h2 : (2 : 𝓞 (fieldI standingField)) ∈ P) : P.comap (conjO standingField) = P := by
  sorry

/-- "inert in F(i), each of norm 128": at a stable prime above 2 the residue field has `128²` elements and conjugation is not the
identity on it — so its fixed field, the residue field of `F`, has 128. -/
theorem card_quotient_of_two_mem (P : StablePrime standingField) (h2 : (2 : 𝓞 (fieldI standingField)) ∈ P.P) :
    Nat.card (𝓞 (fieldI standingField) ⧸ P.P) = 128 ^ 2 ∧
      ∃ x : 𝓞 (fieldI standingField), conjO standingField x - x ∉ P.P := by
  sorry

/-- **Every usable residue field of `F` has at least 347 elements** (the row's clause, sharpened to the least value). -/
theorem usable_card_ge (w : Ideal (𝓞 standingField)) (hw : w.IsMaximal)
    (h : Nat.card (𝓞 standingField ⧸ w) % 4 = 3) : 347 ≤ Nat.card (𝓞 standingField ⧸ w) := by
  sorry

/-- "none of its places has a usable residue field of size at most 47" — the row's words. -/
theorem no_small_usable (w : Ideal (𝓞 standingField)) (hw : w.IsMaximal)
    (h : Nat.card (𝓞 standingField ⧸ w) % 4 = 3) : 47 < Nat.card (𝓞 standingField ⧸ w) :=
  lt_of_lt_of_le (by norm_num) (usable_card_ge w hw h)

/-- The same on the stable primes of `F(i)`, the form `localBound` reads: a stable prime is dyadic of residue size `128²`, or
its residue field has `Q²` elements with `Q ≡ 3 (mod 4)`, `Q ≥ 347`. -/
theorem stablePrime_card (P : StablePrime standingField) :
    Nat.card (𝓞 (fieldI standingField) ⧸ P.P) = 128 ^ 2 ∨
      ∃ Q : ℕ, Q % 4 = 3 ∧ 347 ≤ Q ∧ Nat.card (𝓞 (fieldI standingField) ⧸ P.P) = Q ^ 2 := by
  sorry

/-! ### The floor, a named hypothesis from outside the backlog, and the two conditional clauses -/

/-- The level-one residue target of a field `k` with an involution `σ`: `Cay(k, {x : x·σ(x) = 1})` — `Γ_Q` when `k = 𝔽_{Q²}`
with `Q ≡ 3 (mod 4)`, `U_Q` when `Q` is a power of 2. -/
def normOneCayley (k : Type*) [Field k] (σ : k →+* k) : SimpleGraph k :=
  SimpleGraph.fromRel fun x y => (x - y) * σ (x - y) = 1

/-- **The floor at one residue size**: every field of `Q²` elements with a non-trivial involution has a level-one target
needing at least `n` colours. -/
def TargetFloor (n Q : ℕ) : Prop :=
  ∀ (k : Type) [Field k] [Finite k] (σ : k →+* k), (∀ x, σ (σ x) = x) → σ ≠ RingHom.id k → Nat.card k = Q ^ 2 →
    (n : ℕ∞) ≤ (normOneCayley k σ).chromaticNumber

/-- **The floor this field reads — a named hypothesis from outside the backlog (G56).** At `n = 7`: `χ(U₁₂₈) ≥ 7` ("U₁₂₈'s
Hoffman floor is 8") and `χ(Γ_Q) ≥ 7` for every `Q ≡ 3 (mod 4)`, `Q ≥ 347` ("by Weil from 98"). [tools]/[hand], not kernel. -/
def StandingFloor (n : ℕ) : Prop :=
  TargetFloor n 128 ∧ ∀ Q : ℕ, Q % 4 = 3 → 347 ≤ Q → TargetFloor n Q

theorem targetFloor_zero (Q : ℕ) : TargetFloor 0 Q := fun _ _ _ _ _ _ _ => by simp

/-- **"so `L(F) ≥ n`", given the floor at `n`.** -/
theorem le_localBound (n : ℕ) (hFloor : StandingFloor n) : (n : ℕ∞) ≤ localBound standingField := by
  sorry

/-- **"so L(F) ≥ 7"**, given the floor (G56) as a named hypothesis. -/
theorem seven_le_localBound (hFloor : StandingFloor 7) : 7 ≤ localBound standingField :=
  le_localBound 7 hFloor

/-- **"and given MR, χ(F²) ≥ 5"**: from the floor at five and row 123's chain (`hRow123`, the conclusion of
`SpectralChain.min_localBound_five_le_chromaticNumber`; MR is inside it and is never imported here). -/
theorem five_le_chromaticNumber (hFloor : StandingFloor 5)
    (hRow123 : min (localBound standingField) 5 ≤ ((unitDistance ℂ).induce (planeOver standingField)).chromaticNumber) :
    5 ≤ ((unitDistance ℂ).induce (planeOver standingField)).chromaticNumber := by
  have h5 : (5 : ℕ∞) ≤ localBound standingField := le_localBound 5 hFloor
  rwa [min_eq_right h5] at hRow123

/-! ## Spec -/

-- the period is real and built from two cosines: `η = 2cos(2π/29) + 2cos(24π/29)`.
example : eta = 2 * Real.cos (2 * Real.pi / 29) + 2 * Real.cos (24 * Real.pi / 29) := rfl
-- `{1, 12, 17, 28}` is the subgroup of fourth roots of unity mod 29, and `2` generates `(ℤ/29)ˣ` (so `f = 7` in `E₇`).
example : ∀ h ∈ ([1, 12, 17, 28] : List (ZMod 29)), h ^ 4 = 1 := by decide
example : orderOf (2 : ZMod 29) = 28 := by
  rw [orderOf_eq_iff (by norm_num)]
  exact ⟨by decide, by decide⟩
-- `normOneCayley` on `ℂ` with conjugation is the unit-distance relation: `1` and `0` are adjacent.
example : (normOneCayley ℂ (starRingEnd ℂ)).Adj 1 0 := by
  simp [normOneCayley, SimpleGraph.fromRel_adj]

end HadwigerNelson.StandingFive
