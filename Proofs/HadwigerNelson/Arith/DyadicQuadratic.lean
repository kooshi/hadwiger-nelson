import Proofs.HadwigerNelson.Arith.TorsionExtraction

/-!
# Two and four colours at the dyadic prime of a real quadratic field, in the unit-vector ring (FS-131, NF4)

**Read aloud, against the claim** (`data/fs131/claims-NF4.md`, the dated lines of 2026-10-13 17:59 UTC).
* NF4-DYADIC-TWO: *"'= 2 for squarefree m not 3 mod 4' needs a stable prime of Q(sqrt m)(i) above 2 ramified over
  Q(sqrt m)"* — its kernel form is the colouring the table's row reads: `colorable_two_planeOver_sqrt`.
* NF4-DYADIC-FOUR: *"'= 4 for m = 11 mod 24' needs the stable prime above 2 with residue field F_4 (inert in F(i)/F
  exactly when m = 3 mod 8; the target then has four vertices)"* — `colorable_four_planeOver_sqrt`, for every
  `m ≡ 3 (mod 8)`.
The primes themselves (`SpectralChain.StablePrime`) are corollaries in the joining module, through
`ThreeColourCriterion.exists_maximal_conj_trivial_of_colorable_two` and `fs131-wnf`'s prime inversion over the stable
primes; no consumer of the table reads them.

**Both values are prior art** (`[Fischer1990]`, `[Johnson2000]`; `LEDGER.md` § The claim list): nothing here is claimed
as this project's but the kernel form.

**The route.** `colorable_of_ringHom`: a ring homomorphism from `ℤ[U_F]` into a nontrivial finite ring `k` colours `F²`
with `|k|` colours — a unit vector is a unit of the ring (`u·ū = 1`), so its image is not `0`. The two leaves then build
the homomorphism from an explicit order `𝓞' ⊂ F(i)` holding `π = 1 + i` (`π̄ = −iπ`) and a conjugation-stable prime
`𝔮 ∋ π` at which `π` is a uniformizer: every unit vector is `z/z̄` with `z ∈ 𝓞'`, `z = πᵏ z₀/y` with `z₀, y ∉ 𝔮`, so
`z/z̄ = iᵏ z₀ȳ/(y z̄₀)` lies in the localization at `𝔮`, which maps to the finite field `𝓞'/𝔮`
(`plans/FS131-KN4-three-four-colours-plan.md` § 4.5).

**Inhabitants.** `colorable_of_ringHom` at `F = ℚ`, `k = ZMod 2` (Woodall's two-colouring of the rational plane);
`colorable_two_planeOver_sqrt` at `m = 2`, `5`, `17`; `colorable_four_planeOver_sqrt` at `m = 3`, `11`.
-/

namespace HadwigerNelson.DyadicQuadratic

open HadwigerNelson.CharacterColouring HadwigerNelson.SpectralChain HadwigerNelson.SquareClass SimpleGraph

/-- **The residue bound in the ring's words**: a ring homomorphism from `ℤ[U_F]` into a nontrivial finite ring `k`
gives a proper colouring of the plane over `F` with `|k|` colours. Every subfield `F ⊆ ℝ`. -/
theorem colorable_of_ringHom {F : Subfield ℝ} {k : Type} [CommRing k] [Finite k] [Nontrivial k]
    (φ : unitRing F →+* k) : ((unitDistance ℂ).induce (planeOver F)).Colorable (Nat.card k) := by
  sorry

/-- **NF4-DYADIC-TWO, kernel form** (`[Fischer1990]`'s value; prior art): the plane over `ℚ(√m)` is two-colourable for
squarefree `m ≢ 3 (mod 4)`. (`m = 1` is `ℚ`.) -/
theorem colorable_two_planeOver_sqrt {m : ℕ} (hm : Squarefree m) (h4 : m % 4 ≠ 3) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).Colorable 2 := by
  sorry

/-- **NF4-DYADIC-FOUR, kernel form** (prior art: the residue colouring at the dyadic prime, `𝔽₄`-valued): the plane over
`ℚ(√m)` is four-colourable for `m ≡ 3 (mod 8)`. -/
theorem colorable_four_planeOver_sqrt {m : ℕ} (h8 : m % 8 = 3) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).Colorable 4 := by
  sorry

/-! ## Spec -/

-- The classes: `2`, `5`, `17` are not `3 (mod 4)`; `3`, `11`, `35` are `3 (mod 8)`; `7`, `23`, `47` are neither.
example : 2 % 4 ≠ 3 ∧ 5 % 4 ≠ 3 ∧ 17 % 4 ≠ 3 ∧ 3 % 8 = 3 ∧ 11 % 8 = 3 ∧ 35 % 8 = 3 ∧ 47 % 8 ≠ 3 := by norm_num
example : ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).Colorable 4 :=
  colorable_four_planeOver_sqrt (by norm_num)

end HadwigerNelson.DyadicQuadratic
