import Proofs.HadwigerNelson.Arith.UpperHalf

/-!
# A usable prime's plane is a level-one target: `L(F) ≤ χ(Γ_q)` (FS-131, job FS131-KCS1; skeleton)

**Read aloud, against the informal claim** (`CLAUDE.md` § Notation: "**L(F)**, F's *local bound*: the least chromatic number
among the residue targets its conjugation-fixed primes supply"; row 52's upper half). For a real number field `F` and a
usable prime `𝔭` of `F` (residue field `𝔽_q`, `q ≡ 3 (mod 4)`):

* `exists_stablePrime_card_eq_sq` — **some stable prime `P` of `F(i)` has `|𝓞 (F(i)) ⧸ P| = q²`**: the prime above `𝔭`,
  inert in `F(i)` because `−1` is no square in `𝔽_q`.
* `nonempty_hom_levelTarget_one_unitQuadrance` — at an odd stable prime with `Q²` residues, **the level-one target maps
  homomorphically to `Γ_Q` over any field of `Q` elements** (coordinates `x = a + bι`, `a, b` fixed by conjugation).
* `localBound_le_unitQuadrance`, `localBound_le_finitePlane` — **`L(F) ≤ χ(Γ_q)`**: row 52's upper half in `L`'s own words.
  With `UpperHalf.chromaticNumber_planeOver_le_localBound` it recovers `χ(F²) ≤ χ(Γ_q)`
  (`chromaticNumber_planeOver_le_unitQuadrance`), and it is what "`L = 5`" asks at a field with 11 or 19 usable.

**Not claimed:** that the stable prime above `𝔭` is unique, or that every stable prime arises this way (a ramified or a
dyadic inert one does not).

**Inhabitants.** A usable prime: `ℚ(√47)` above 11 (`QuadraticPrime.exists_maximal_card_eq {47}` at `p = 11`).
-/

namespace HadwigerNelson.UpperHalf

open SpectralChain NumberField SimpleGraph Arith

variable {F : Subfield ℝ} [NumberField F]

/-- **The stable prime above a usable prime** has `q²` residues, `q = |𝓞 F ⧸ 𝔭|`. -/
theorem exists_stablePrime_card_eq_sq {𝔭 : Ideal (𝓞 F)} (h𝔭 : IsUsablePrime 𝔭) :
    ∃ P : StablePrime F, Nat.card (𝓞 (fieldI F) ⧸ P.P) = Nat.card (𝓞 F ⧸ 𝔭) ^ 2 := by
  sorry

/-- **The level-one target at an odd stable prime with `Q²` residues maps to `Γ_Q`** over any finite field `k` of `Q`
elements. -/
theorem nonempty_hom_levelTarget_one_unitQuadrance (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P)
    (k : Type*) [Field k] [Finite k] (hk : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Nat.card k ^ 2) :
    Nonempty (levelTarget P 1 →g unitQuadrance k) := by
  sorry

variable (F) in
/-- **`L(F) ≤ χ(Γ_q)`** at a usable prime with residue field `𝔽_q`. -/
theorem localBound_le_unitQuadrance {𝔭 : Ideal (𝓞 F)} (h𝔭 : IsUsablePrime 𝔭) :
    localBound F ≤ (unitQuadrance (𝓞 F ⧸ 𝔭)).chromaticNumber := by
  sorry

variable (F) in
/-- **`L(F) ≤ χ(Γ_p)`** at a usable prime whose residue field has prime order `p`. -/
theorem localBound_le_finitePlane {𝔭 : Ideal (𝓞 F)} (h𝔭 : IsUsablePrime 𝔭) {p : ℕ} (hp : p.Prime)
    (hcard : Nat.card (𝓞 F ⧸ 𝔭) = p) : localBound F ≤ (finitePlane p).chromaticNumber := by
  sorry

/-! ## Spec -/

-- The residue sizes the head statement is read at: `11 ≡ 19 ≡ 3 (mod 4)`, and `47` a nonzero square mod 11.
example : 11 % 4 = 3 ∧ 19 % 4 = 3 ∧ (47 : ZMod 11) ≠ 0 ∧ IsSquare (47 : ZMod 11) := by decide

end HadwigerNelson.UpperHalf
