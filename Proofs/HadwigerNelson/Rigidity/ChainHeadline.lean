import Proofs.HadwigerNelson.Rigidity.ZeroEntropyClosed
import Proofs.HadwigerNelson.Rigidity.CountDescent
import Proofs.HadwigerNelson.Rigidity.APlus
import Proofs.HadwigerNelson.Rigidity.ClassRatio
import Proofs.HadwigerNelson.Plane.MOneBound
import Proofs.HadwigerNelson.Arith.ThreeFourColours

/-!
# The five-colour chain's headline, with no hypothesis (FS-131, jobs FS131-IJN1 and FS131-LCH1)

**Read aloud, against the informal claim.** For a real number field `F`, `χ(F²) ≥ min(L(F), 5)` — the main clause of the
local–global conjecture through five (`CLAUDE.md` § The local–global conjecture; `LEDGER.md` rows 120–123), its lower half
— with no hypothesis. The two it was first stated over are theorems of the library, discharged at the chain's landing
(FS131-LCH1):

* `[AmbrusEtAl2023]` Theorem 1, as printed (`Plane.OneAvoidingDensityBound`: every Lebesgue-measurable 1-avoiding planar
  set has upper density at most `0.2470`), read by the count: `Plane.oneAvoidingDensityBound` (`Plane/DensityBound/Theorem`,
  from the paper's certificate, checked by the kernel);
* row 99's lower half at `L(F) ≤ 4`: `ThreeFourColours.localBound_le_chromaticNumber_of_le_four` (FS131-LJ1, on Weil's
  bound).

**Each of the eight hypotheses of `min_localBound_five_le_chromaticNumber_of_closed`** (`Rigidity/ChainAtTA`), and what
discharges it here:

| hypothesis | discharged by |
|---|---|
| `hBH` — Herglotz–Bochner on `ℤ[U_F]` | `bochnerHerglotz_of_countable` (M2a, `Rigidity/Herglotz`) |
| `hL1` — the invariant measure on closed sets | `invariantMeasureOnClosed_of_countable` (M3, `Rigidity/InvariantMeasure`) |
| `hCount` — R88-TCA from T-C(A) | `Counting.count_of_oneAvoidingDensityBound` (M12, `Rigidity/CountDescent`) at `Plane.oneAvoidingDensityBound` |
| `hAP` — A⁺ at `S = ∅` from R88-TCA | `aPlusOfR88` (M11, `Rigidity/APlus`) |
| `hPE` — PE-2, the entropy split | `entropySplit` (M5–M7, `Rigidity/ZeroEntropyClosed`) |
| `hEF` — EF_F⁺ in its scope | `zeroEntropyCarried` (M8, `Rigidity/ZeroEntropyClosed`), which needs no scope |
| `hCLS` — CLS | `tca_of_five_le_localBound` (M13, `Rigidity/ClassRatio`) |
| `hRow99` — row 99 at `L ≤ 4` | `ThreeFourColours.localBound_le_chromaticNumber_of_le_four` (`Arith/ThreeFourColours`) |

What the statement rests on beyond the standard three axioms is what `#print axioms` prints for it: the declared outside
theorems `Rigidity.positive_entropy_rigidity` (through `entropySplit`) and `StandingFive.kloosterman_bound` (through M13),
and, until their own lines land, the leaves of other lines (record `plans/FS131-IJN1-join.md`, the headline's stage).

**Inhabitants.** The statement's only hypothesis is `[NumberField F]`; every number field is a model of it
(`Instances/UpperHalfValues.numberField_bot` at `ℚ`).
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory SimpleGraph SpectralChain SpectralInputs NumberField

/-- **The chain's headline**: for a real number field `F`, `χ(F²) ≥ min(L(F), 5)`, with no hypothesis. The conclusion is
`min_localBound_five_le_chromaticNumber_of_closed`'s, character for character; each of its eight hypotheses is a theorem
of the library (the module docstring's table), `[AmbrusEtAl2023]` Theorem 1 (`Plane.oneAvoidingDensityBound`) and row
99's lower half (`ThreeFourColours.localBound_le_chromaticNumber_of_le_four`) among them. -/
theorem min_localBound_five_le_chromaticNumber (F : Subfield ℝ) [NumberField F] :
    min (localBound F) 5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber :=
  min_localBound_five_le_chromaticNumber_of_closed F (bochnerHerglotz_of_countable (unitRing F))
    (invariantMeasureOnClosed_of_countable F) (Counting.count_of_oneAvoidingDensityBound Plane.oneAvoidingDensityBound)
    (aPlusOfR88 F) (entropySplit F) (fun _ => zeroEntropyCarried F) (tca_of_five_le_localBound F)
    (ThreeFourColours.localBound_le_chromaticNumber_of_le_four F)

end HadwigerNelson.Rigidity
