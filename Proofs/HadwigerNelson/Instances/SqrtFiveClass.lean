import Proofs.HadwigerNelson.Instances.SqrtClassValues
import Proofs.HadwigerNelson.Instances.LocalGlobal19
import Proofs.HadwigerNelson.Arith.ThreeFourColours
import Proofs.HadwigerNelson.Arith.StableAboveUsable

/-!
# Five colours over real quadratic fields: the dichotomy and the family (FS-131, job FS131-KCS1; skeleton)

**Read aloud, against the informal claims.**

* `five_le_chromaticNumber_planeOver_sqrt_iff` — **the dichotomy** (`plans/POROS-2026-10-13-number-field-findings.md`
  § 3.3: "For a real quadratic field `ℚ(√n)`, `n` squarefree, the plane needs at least five colours exactly when
  `n ≡ 47, 143, 167 (mod 168)`"): for squarefree `m`, `5 ≤ χ(ℚ(√m)²)` ⟺ `m % 168 ∈ {47, 143, 167}`; and its local form
  `five_le_localBound_sqrt_iff`. Below five the values are `ThreeFourColours.chromaticNumber_planeOver_sqrt_table`'s.
* `chromaticNumber_planeOver_sqrt_eq_five` — **the family** (`LEDGER.md` row 123, FS100-FAM: "`χ = 5` at every
  squarefree `d ≡ 47, 143, 167 (mod 168)` with `L = 5` (44 of the 52 with `d ≤ 3000`)", where the derivation reads `L = 5`
  as "11 or 19 stable", `plans/FS100-X21D-derivation.md` § 2.3): for squarefree `d` in the class that is a square, zero
  included, modulo 11 or modulo 19, `χ(ℚ(√d)²) = 5`; and `localBound_sqrt_eq_five`, `L(ℚ(√d)) = 5` there.

**Posed by.** `[Davies2026]` p. 5 poses the quadratic instances as open — a five-chromatic graph in, and six-colourability
of, `ℚ(√n)²` for `n ≡ 47, 143, 167 (mod 168)` (`LEDGER.md` row 123); `[Fischer1990]` §1 the question of the values
(row 99). Prior art for the values at five: not found in print (row 123).

**Not claimed:** `L(ℚ(√d)) ≥ 6` at the class members with neither 11 nor 19 stable (ℚ(√167) first; open, `χ(Γ₃₁)`
undecided); any value at those; that any value is new mathematics.

**What rests on what.** The lower halves rest on the headline's two declared outside theorems (Weil's bound and
`[EinsiedlerLindenstrauss2022]` Thm 1.3); the upper halves and the table below five on the standard three.

**Inhabitants.** Every hypothesis is arithmetic on `ℕ`: `d = 47` satisfies all of them (the spec).
-/

namespace HadwigerNelson.SqrtFiveClass

open SpectralChain NumberField SimpleGraph SquareClass UpperHalf

/-- **The dichotomy**: for squarefree `m`, the plane over `ℚ(√m)` needs at least five colours exactly when
`m ≡ 47, 143, 167 (mod 168)`. -/
theorem five_le_chromaticNumber_planeOver_sqrt_iff {m : ℕ} (hm : Squarefree m) :
    5 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber ↔
      m % 168 = 47 ∨ m % 168 = 143 ∨ m % 168 = 167 := by
  refine ⟨fun h5 => ?_, fun hcl => Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound _
    (Rigidity.five_le_localBound_of_isSquare_class _ (SqrtClassValues.isSquare_radicand rfl) hcl)⟩
  -- off the class the table gives two, three or four colours
  by_contra hcl
  obtain ⟨t2, t3, -, t4⟩ := ThreeFourColours.chromaticNumber_planeOver_sqrt_table hm
  have hχ : ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber ≤ 4 := by
    by_cases h4 : m % 4 = 3
    · by_cases h11 : m % 12 = 11
      · exact (t4 h11 ⟨by omega, by omega, by omega⟩).le
      · exact (t3 (by omega)).le.trans (by norm_num)
    · exact (t2 h4).le.trans (by norm_num)
  exact absurd (h5.trans hχ) (by norm_num)

/-- **The dichotomy, local form**: for squarefree `m`, `L(ℚ(√m)) ≥ 5` exactly when `m ≡ 47, 143, 167 (mod 168)`. -/
theorem five_le_localBound_sqrt_iff {m : ℕ} (hm : Squarefree m) :
    5 ≤ localBound (fieldOfRadicands {m}) ↔ m % 168 = 47 ∨ m % 168 = 143 ∨ m % 168 = 167 :=
  ⟨fun h5 => (five_le_chromaticNumber_planeOver_sqrt_iff hm).1
      (Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound _ h5),
    fun hcl => Rigidity.five_le_localBound_of_isSquare_class _ (SqrtClassValues.isSquare_radicand rfl) hcl⟩

/-- **A usable prime of residue field `𝔽_p` above a square or a once-dividing prime**: for squarefree `d` that is a square
modulo the odd prime `p` (zero included), `ℚ(√d)` has a maximal ideal with `p` elements in its quotient. -/
theorem exists_maximal_card_eq_of_isSquare {d p : ℕ} (hd : Squarefree d) (hp : p.Prime) (hp2 : p ≠ 2)
    (hsq : IsSquare (d : ZMod p)) :
    ∃ 𝔭 : Ideal (𝓞 (fieldOfRadicands {d})), 𝔭.IsMaximal ∧ Nat.card (𝓞 (fieldOfRadicands {d}) ⧸ 𝔭) = p := by
  by_cases h0 : (d : ZMod p) = 0
  · -- `p ∣ d` once: the ramified prime above `p`
    have hpd : p ∣ d := (ZMod.natCast_eq_zero_iff d p).1 h0
    have hp2d : ¬ p ^ 2 ∣ d := fun h => by
      have hu := hd p (by rwa [← sq])
      exact hp.one_lt.ne' (Nat.isUnit_iff.1 hu)
    obtain ⟨𝔭, hmax, hcard⟩ := QuadraticPrime.exists_maximal_card_eq_of_ramified ∅ d hp hp2 (by simp) hpd hp2d
    rw [show ({d} : Set ℕ) = insert d ∅ from (insert_empty_eq d).symm]
    exact ⟨𝔭, hmax, hcard⟩
  · exact QuadraticPrime.exists_maximal_card_eq {d} hp hp2 fun d' hd' => by
      rw [Set.mem_singleton_iff.1 hd']; exact ⟨h0, hsq⟩

/-- **The upper half of the family**: for squarefree `d` a square modulo 11 or modulo 19, `ℚ(√d)²` is five-colourable. -/
theorem colorable_five_planeOver_sqrt {d : ℕ} (hd : Squarefree d)
    (h : IsSquare (d : ZMod 11) ∨ IsSquare (d : ZMod 19)) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {d}))).Colorable 5 := by
  rcases h with h | h
  · obtain ⟨𝔭, hmax, hcard⟩ := exists_maximal_card_eq_of_isSquare hd (by norm_num : Nat.Prime 11) (by norm_num) h
    exact colorable_planeOver_of_finitePlane _ ⟨hmax, by rw [hcard]⟩ (by norm_num) hcard finitePlane11_colorable_five
  · obtain ⟨𝔭, hmax, hcard⟩ := exists_maximal_card_eq_of_isSquare hd (by norm_num : Nat.Prime 19) (by norm_num) h
    exact colorable_planeOver_of_finitePlane _ ⟨hmax, by rw [hcard]⟩ (by norm_num) hcard finitePlane19_colorable_five

/-- **The family**: `χ(ℚ(√d)²) = 5` for squarefree `d ≡ 47, 143, 167 (mod 168)` that is a square, zero included, modulo 11
or modulo 19. -/
theorem chromaticNumber_planeOver_sqrt_eq_five {d : ℕ} (hd : Squarefree d)
    (hcl : d % 168 = 47 ∨ d % 168 = 143 ∨ d % 168 = 167) (h : IsSquare (d : ZMod 11) ∨ IsSquare (d : ZMod 19)) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {d}))).chromaticNumber = 5 :=
  le_antisymm (colorable_five_planeOver_sqrt hd h).chromaticNumber_le
    ((five_le_chromaticNumber_planeOver_sqrt_iff hd).2 hcl)

/-- **`L(ℚ(√d)) ≤ 5`** for squarefree `d` a square modulo 11 or modulo 19: the level-one target above the usable prime
(`UpperHalf.localBound_le_finitePlane`). -/
theorem localBound_sqrt_le_five {d : ℕ} (hd : Squarefree d) (h : IsSquare (d : ZMod 11) ∨ IsSquare (d : ZMod 19)) :
    localBound (fieldOfRadicands {d}) ≤ 5 := by
  rcases h with h | h
  · obtain ⟨𝔭, hmax, hcard⟩ := exists_maximal_card_eq_of_isSquare hd (by norm_num : Nat.Prime 11) (by norm_num) h
    exact (localBound_le_finitePlane _ ⟨hmax, by rw [hcard]⟩ (by norm_num) hcard).trans
      finitePlane11_colorable_five.chromaticNumber_le
  · obtain ⟨𝔭, hmax, hcard⟩ := exists_maximal_card_eq_of_isSquare hd (by norm_num : Nat.Prime 19) (by norm_num) h
    exact (localBound_le_finitePlane _ ⟨hmax, by rw [hcard]⟩ (by norm_num) hcard).trans
      finitePlane19_colorable_five.chromaticNumber_le

/-- **`L(ℚ(√d)) = 5`** on the family. -/
theorem localBound_sqrt_eq_five {d : ℕ} (hd : Squarefree d)
    (hcl : d % 168 = 47 ∨ d % 168 = 143 ∨ d % 168 = 167) (h : IsSquare (d : ZMod 11) ∨ IsSquare (d : ZMod 19)) :
    localBound (fieldOfRadicands {d}) = 5 :=
  le_antisymm (localBound_sqrt_le_five hd h) ((five_le_localBound_sqrt_iff hd).2 hcl)

/-! ## Spec -/

-- `47` meets every hypothesis of the family: squarefree (a prime; `decide` on `Squarefree` sticks at `Nat.minSqFac`),
-- `47 % 168 = 47`, `47 ≡ 3 = 5² (mod 11)`.
example : Squarefree 47 ∧ 47 % 168 = 47 ∧ IsSquare (47 : ZMod 11) :=
  ⟨(by norm_num : Nat.Prime 47).prime.squarefree, rfl, ⟨5, by decide⟩⟩
-- `167` is in the class and a square neither modulo 11 nor modulo 19: the family theorem does not reach it.
example : 167 % 168 = 167 ∧ ¬ IsSquare (167 : ZMod 11) ∧ ¬ IsSquare (167 : ZMod 19) := by decide

end HadwigerNelson.SqrtFiveClass
