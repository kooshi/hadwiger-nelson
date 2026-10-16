import Proofs.HadwigerNelson.Rigidity.ChainHeadline

/-!
# The main clause through five, as one theorem (FS-131, job FS131-IL5)

**Read aloud, against the informal claim.** For a real number field `F` (`F : Subfield ℝ` with `[NumberField F]`) whose
local bound is at most five, the plane over `F` needs exactly `L(F)` colours: `χ(F²) = L(F)` whenever `L(F) ≤ 5` — the
main clause of the local–global conjecture through five (`CLAUDE.md` § The local–global conjecture; `LEDGER.md` row 123),
with no hypothesis beyond `L(F) ≤ 5` (`chromaticNumber_planeOver_eq_localBound_of_le_five`). Beside it, the same clause
with no hypothesis at all: `min(χ(F²), 5) = min(L(F), 5)` at every real number field — the chromatic number and the local
bound agree through five (`min_chromaticNumber_five_eq_min_localBound_five`). It implies the first theorem and the
headline's lower bound, and not the upper half above five.

Each is the composition of two theorems of the library:

* **the upper half**, `χ(F²) ≤ L(F)` at every real number field (`UpperHalf.chromaticNumber_planeOver_le_localBound`, on
  the standard three axioms) — the residue map at a stable prime realising `L(F)`. The bound is prior art (`LEDGER.md`
  row 52: `[Moorhouse2010]` §8.2/§10.3, `[Manturov2012]` Thms 17–19, `[Madore2015]` Cor. 3.4); its kernel proof is this
  project's;
* **the lower half**, `min(L(F), 5) ≤ χ(F²)` at every real number field (`Rigidity.min_localBound_five_le_chromaticNumber`,
  the five-colour chain's headline) — this project's derivation (rows 120–123; the conjecture is G48's); at `ℚ(√47)`,
  where it gives `χ ≥ 5`, prior art: not found in print (row 121).

**What it rests on.** Beyond the standard three axioms, the two declared outside theorems the headline rests on:
`Rigidity.positive_entropy_rigidity` (`[EinsiedlerLindenstrauss2022]` Thm 1.3) and `StandingFive.kloosterman_bound`
(Weil's bound, `[Weil1948]` p. 207). The upper half adds none.

**Inhabitants.** The hypotheses are `[NumberField F]` and, for the first theorem, `localBound F ≤ 5`. Both hold at once at
`F = ℚ`: `UpperHalf.instNumberFieldBot`, and `localBound_bot_le_two` here — `L(ℚ) ≤ 2`, the level-one target at the
ramified stable prime above 2 (`UpperHalf.exists_stablePrime_rat`) being two-colourable
(`colorable_two_levelTarget_one_of_isRamified`), on the standard three axioms. The spec reads the first theorem there:
`L(ℚ) = χ(ℚ²) = 2` (`UpperHalf.chromaticNumber_planeOver_rat`, Woodall's value). Where `L(F) = 5` the theorem's content is
`χ(F²) = 5`, held at `ℚ(√47)` by `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five` (downstream of this module);
no declaration states `L(ℚ(√47)) ≤ 5`, so the kernel's model of the hypothesis is the one at `ℚ`.
-/

namespace HadwigerNelson.Rigidity

open SimpleGraph SpectralChain

/-- **The main clause through five, as one theorem**: for a real number field `F` with `L(F) ≤ 5`, `χ(F²) = L(F)`. The
upper half `χ(F²) ≤ L(F)` (`UpperHalf.chromaticNumber_planeOver_le_localBound`; prior art, `LEDGER.md` row 52, the kernel
proof this project's) and the five-colour chain's headline `min(L(F), 5) ≤ χ(F²)`
(`min_localBound_five_le_chromaticNumber`; this project's derivation, rows 120–123 — at `ℚ(√47)` prior art: not found in
print, row 121), read at `L(F) ≤ 5`, where `min(L(F), 5) = L(F)`. Rests on the declared outside theorems
`positive_entropy_rigidity` (`[EinsiedlerLindenstrauss2022]` Thm 1.3) and `StandingFive.kloosterman_bound`
(`[Weil1948]` p. 207), through the headline. -/
theorem chromaticNumber_planeOver_eq_localBound_of_le_five (F : Subfield ℝ) [NumberField F] (h : localBound F ≤ 5) :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber = localBound F :=
  le_antisymm (UpperHalf.chromaticNumber_planeOver_le_localBound F)
    ((min_eq_left h).symm.le.trans (min_localBound_five_le_chromaticNumber F))

/-- **The main clause through five, with no hypothesis**: for every real number field `F`,
`min(χ(F²), 5) = min(L(F), 5)` — the chromatic number of the plane over `F` and its local bound agree through five. It
implies `chromaticNumber_planeOver_eq_localBound_of_le_five` and the headline's lower bound; it does not give the upper
half `χ(F²) ≤ L(F)` when `L(F) > 5`. The same two theorems composed: the upper half
(`UpperHalf.chromaticNumber_planeOver_le_localBound`; prior art, row 52) under `min · 5`, and the headline
(`min_localBound_five_le_chromaticNumber`; this project's derivation, rows 120–123). Rests on the declared outside theorems
`positive_entropy_rigidity` (`[EinsiedlerLindenstrauss2022]` Thm 1.3) and `StandingFive.kloosterman_bound`
(`[Weil1948]` p. 207), through the headline. -/
theorem min_chromaticNumber_five_eq_min_localBound_five (F : Subfield ℝ) [NumberField F] :
    min ((unitDistance ℂ).induce (planeOver F)).chromaticNumber 5 = min (localBound F) 5 :=
  le_antisymm (min_le_min (UpperHalf.chromaticNumber_planeOver_le_localBound F) le_rfl)
    (le_min (min_localBound_five_le_chromaticNumber F) (min_le_right _ _))

/-- **A model of the hypotheses, at `ℚ`**: `L(ℚ) ≤ 2`, so `localBound F ≤ 5` holds at `F = ℚ` together with
`[NumberField ℚ]` (`UpperHalf.instNumberFieldBot`). The stable prime of `ℚ(i)` above 2 is ramified over `ℚ`
(`UpperHalf.exists_stablePrime_rat`: conjugation is the identity modulo it), so its level-one target is two-colourable
(`colorable_two_levelTarget_one_of_isRamified`), and `L(ℚ)` is at most that target's chromatic number. On the standard
three axioms. -/
theorem localBound_bot_le_two : localBound (⊥ : Subfield ℝ) ≤ 2 := by
  obtain ⟨P, -, hram⟩ := UpperHalf.exists_stablePrime_rat
  exact (iInf_le _ P).trans (colorable_two_levelTarget_one_of_isRamified hram).chromaticNumber_le

/-! ## Spec -/

-- The first theorem at its model `ℚ`: with `χ(ℚ²) = 2` it gives `L(ℚ) = 2`. A statement drifted to either half alone
-- gives one inequality, not this equation.
example : localBound (⊥ : Subfield ℝ) = 2 :=
  (chromaticNumber_planeOver_eq_localBound_of_le_five ⊥ (localBound_bot_le_two.trans (by norm_num))).symm.trans
    UpperHalf.chromaticNumber_planeOver_rat

-- The `min` form at `ℚ`, with no hypothesis supplied: `min(L(ℚ), 5) = min(χ(ℚ²), 5) = 2`.
example : min (localBound (⊥ : Subfield ℝ)) 5 = 2 := by
  rw [← min_chromaticNumber_five_eq_min_localBound_five, UpperHalf.chromaticNumber_planeOver_rat]
  exact min_eq_left (by norm_num)

end HadwigerNelson.Rigidity
