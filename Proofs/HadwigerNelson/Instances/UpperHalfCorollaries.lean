import Proofs.HadwigerNelson.Instances.UpperHalfValues
import Proofs.HadwigerNelson.Instances.FinitePlane11
import Proofs.HadwigerNelson.Instances.SevenUnitRing

/-!
# Corollaries of the residue upper half, one application each (FS-131, NF1; stated by FS131-KJ1)

The landing of the residue module (`Arith/UpperHalf`, `Arith/QuadraticPrime`, `Instances/UpperHalfValues`; FS131-LU1)
named three corollaries "one line away that no file states" (`plans/FS131-close-inventory.md`, item 702). They are here.

* `chromaticNumber_planeOver_eq_two_of_localBound_le_two` — a real number field whose local bound is two has a plane
  needing exactly two colours.
* `chromaticNumber_planeOver_sqrt_five_le_five`, `chromaticNumber_planeOver_sqrt_247_le_five` — the upper halves of the
  two values of `LEDGER.md` row 52: over `K(√5) = ℚ(√3, √5, √11)` and `K(√247) = ℚ(√3, √11, √247)` five colours suffice,
  through a prime with residue field `𝔽₁₁` (ramified at `√11`; `3`, `5` and `247` are nonzero squares modulo 11) and the
  five-colouring of the plane over `𝔽₁₁`.
* `two_notMem_stablePrime_seven` — `LEDGER.md` row 105's reading at `K(√7) = ℚ(√3, √7, √11)`: no stable prime of
  `K(√7)(i)` holds 2 (every prime of `K(√7)` above 2 splits in `K(√7)(i)`), from `1/2 ∈ ℤ[U]` there.

**Nothing here is new mathematics.** Every upper bound is prior art: the residue bound is `[Moorhouse2010]` §8.2/§10.3,
`[Manturov2012]` Thms 17–19 and `[Madore2015]` Cor. 3.4, and `χ(𝔽₁₁²) = 5` is Moorhouse's Table 6.1; the kernel proofs
are what is here. **Not here:** the lower halves of row 52's two values (`χ ≥ 5` over `K(√5)` and `K(√247)`), which no
declaration of the library states for these fields — the two values stay `[hand + tools]` on their lower side.

**Inhabitants.** `localBound F ≤ 2` holds at `F = ℚ` in mathematics (the target at the stable prime `(1 + i)` of
`UpperHalf.exists_stablePrime_rat` is one edge on `𝔽₂`); **no declaration of the library proves it** — no upper bound on a
level target's chromatic number is stated anywhere, which is also what the joining module's
`localBound_le_chromaticNumber_or_four_le` waits on. `StablePrime F7` is inhabited in mathematics (by Chebotarev some
prime of `K(√7)` is inert in `K(√7)(i)`); no declaration exhibits one, so the kernel does not know that
`two_notMem_stablePrime_seven` is about a non-empty type.
-/

namespace HadwigerNelson.UpperHalf

open HadwigerNelson HadwigerNelson.Arith HadwigerNelson.SpectralChain HadwigerNelson.SquareClass SimpleGraph NumberField

/-- **A local bound of two gives the value two**: for a real number field `F` with `L(F) ≤ 2`, `χ(F²) = 2` (the upper
half `χ ≤ L` and the edge `0 — 1`). The two-colour theorem at a ramified dyadic prime is `[Fischer1990]` Thm 1(iii) read
at a prime (an outside model's classification; `LEDGER.md` § B); what is here is the composition. -/
theorem chromaticNumber_planeOver_eq_two_of_localBound_le_two (F : Subfield ℝ) [NumberField F]
    (h : localBound F ≤ 2) : ((unitDistance ℂ).induce (planeOver F)).chromaticNumber = 2 :=
  le_antisymm ((chromaticNumber_planeOver_le_localBound F).trans h) (two_le_chromaticNumber_planeOver F)

/-- **Row 52, the upper half at `K(√5)`**: `χ(ℚ(√3, √5, √11)²) ≤ 5` — a prime with residue field `𝔽₁₁` (`3 ≡ 5²`,
`5 ≡ 4² (mod 11)`; ramified at `√11`) and `finitePlane11_colorable_five`. Prior art. -/
theorem chromaticNumber_planeOver_sqrt_five_le_five :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11, 3, 5}))).chromaticNumber ≤ 5 := by
  have hp : Nat.Prime 11 := by norm_num
  obtain ⟨𝔭, h𝔭, hcard⟩ := QuadraticPrime.exists_maximal_card_eq_of_ramified {3, 5} 11 hp (by norm_num)
    (by
      rintro d (rfl | rfl)
      · exact ⟨by decide, ⟨5, by decide⟩⟩
      · exact ⟨by decide, ⟨4, by decide⟩⟩)
    (dvd_refl 11) (by norm_num)
  exact (colorable_planeOver_of_finitePlane _ ⟨h𝔭, by rw [hcard]⟩ hp hcard finitePlane11_colorable_five).chromaticNumber_le

/-- **Row 52, the upper half at `K(√247)`**: `χ(ℚ(√3, √11, √247)²) ≤ 5` (`247 = 13·19 ≡ 5 ≡ 4² (mod 11)`). Prior art. -/
theorem chromaticNumber_planeOver_sqrt_247_le_five :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11, 3, 247}))).chromaticNumber ≤ 5 := by
  have hp : Nat.Prime 11 := by norm_num
  obtain ⟨𝔭, h𝔭, hcard⟩ := QuadraticPrime.exists_maximal_card_eq_of_ramified {3, 247} 11 hp (by norm_num)
    (by
      rintro d (rfl | rfl)
      · exact ⟨by decide, ⟨5, by decide⟩⟩
      · exact ⟨by decide, ⟨4, by decide⟩⟩)
    (dvd_refl 11) (by norm_num)
  exact (colorable_planeOver_of_finitePlane _ ⟨h𝔭, by rw [hcard]⟩ hp hcard finitePlane11_colorable_five).chromaticNumber_le

/-- **Row 105's reading at `K(√7)`**: no stable prime of `K(√7)(i)` holds `2` — the 2-adic wall is broken over
`K(√7) = ℚ(√3, √7, √11)`, in the words of primes. (`SevenUnitRing.inv_two_mem_unitRingOver_seven`, `1/2 ∈ ℤ[U]`, read
through `inv_natCast_mem_unitRingOver_iff_forall_stablePrime`.) -/
theorem two_notMem_stablePrime_seven (P : StablePrime SevenConditional.F7) :
    (2 : 𝓞 (fieldI SevenConditional.F7)) ∉ P.P := by
  have h := (inv_natCast_mem_unitRingOver_iff_forall_stablePrime SevenConditional.F7 (n := 2) two_ne_zero).mp
    (by exact_mod_cast SevenUnitRing.inv_two_mem_unitRingOver_seven) P
  simpa using h

-- The two fields of row 52 are number fields, and `11` is usable (`11 ≡ 3 (mod 4)`).
example : NumberField (fieldOfRadicands {11, 3, 5}) ∧ NumberField (fieldOfRadicands {11, 3, 247}) ∧ 11 % 4 = 3 :=
  ⟨inferInstance, inferInstance, rfl⟩

end HadwigerNelson.UpperHalf
