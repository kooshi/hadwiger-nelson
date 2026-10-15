import Proofs.HadwigerNelson.Rigidity.ZeroEntropyClosed
import Proofs.HadwigerNelson.Rigidity.CountDescent
import Proofs.HadwigerNelson.Rigidity.APlus
import Proofs.HadwigerNelson.Rigidity.ClassRatio

/-!
# The five-colour chain's headline, with every hypothesis the chain proves discharged (FS-131, job FS131-IJN1)

**Read aloud, against the informal claim.** For a real number field `F`, `χ(F²) ≥ min(L(F), 5)` — the main clause of the
local–global conjecture through five (`CLAUDE.md` § The local–global conjecture; `LEDGER.md` rows 120–123), its lower half
— given two statements only:

* `hOA` — `[AmbrusEtAl2023]` Theorem 1, as printed (`Plane.OneAvoidingDensityBound`: every Lebesgue-measurable 1-avoiding
  planar set has upper density at most `0.2470`), a named hypothesis standing for an outside theorem, read by the count;
* `hRow99` — row 99's lower half at `L(F) ≤ 4`, a theorem on `main` (`ThreeFourColours.localBound_le_chromaticNumber_of_le_four`,
  FS131-LJ1, on Weil's bound), which this branch does not hold.

**Each of the eight hypotheses of `min_localBound_five_le_chromaticNumber_of_closed`** (`Rigidity/ChainAtTA`), and what
discharges it here:

| hypothesis | discharged by |
|---|---|
| `hBH` — Herglotz–Bochner on `ℤ[U_F]` | `bochnerHerglotz_of_countable` (M2a, `Rigidity/Herglotz`) |
| `hL1` — the invariant measure on closed sets | `invariantMeasureOnClosed_of_countable` (M3, `Rigidity/InvariantMeasure`) |
| `hCount` — R88-TCA from T-C(A) | `Counting.count_of_oneAvoidingDensityBound` (M12, `Rigidity/CountDescent`), over `hOA` |
| `hAP` — A⁺ at `S = ∅` from R88-TCA | `aPlusOfR88` (M11, `Rigidity/APlus`) |
| `hPE` — PE-2, the entropy split | `entropySplit` (M5–M7, `Rigidity/ZeroEntropyClosed`) |
| `hEF` — EF_F⁺ in its scope | `zeroEntropyCarried` (M8, `Rigidity/ZeroEntropyClosed`), which needs no scope |
| `hCLS` — CLS | `tca_of_five_le_localBound` (M13, `Rigidity/ClassRatio`) |
| `hRow99` — row 99 at `L ≤ 4` | kept: `hRow99` |

What the statement rests on beyond the standard three axioms is what `#print axioms` prints for it: the declared outside
theorems `Rigidity.positive_entropy_rigidity` (through `entropySplit`) and `StandingFive.kloosterman_bound` (through M13),
and, until their own lines land, the leaves of other lines (record `plans/FS131-IJN1-join.md`, the headline's stage).

**Inhabitants.** `hOA`'s clause: `Plane.oneAvoidingDensityBound_model` (the open ball of radius `1/2`). `hRow99`: on `main`
it is a theorem at every real number field (`ThreeFourColours.localBound_le_chromaticNumber_of_le_four`), so there every
number field is a model of both of the statement's hypotheses but `hOA`, which is an outside theorem; this branch holds no
such theorem. Every number field is a model of `[NumberField F]` (`Instances/UpperHalfValues.numberField_bot` at `ℚ`).
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory SimpleGraph SpectralChain SpectralInputs NumberField

/-- **The chain's headline, every hypothesis it proves discharged**: for a real number field `F`, `χ(F²) ≥ min(L(F), 5)`,
given `[AmbrusEtAl2023]` Theorem 1 as printed (`hOA`, read by the count) and row 99's lower half at `L(F) ≤ 4` (`hRow99`).
The conclusion is `min_localBound_five_le_chromaticNumber_of_closed`'s, character for character; the other six of its
hypotheses are the chain's theorems (the module docstring's table). -/
theorem min_localBound_five_le_chromaticNumber (F : Subfield ℝ) [NumberField F]
    (hOA : Plane.OneAvoidingDensityBound)
    (hRow99 : localBound F ≤ 4 → localBound F ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber) :
    min (localBound F) 5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber :=
  min_localBound_five_le_chromaticNumber_of_closed F (bochnerHerglotz_of_countable (unitRing F))
    (invariantMeasureOnClosed_of_countable F) (Counting.count_of_oneAvoidingDensityBound hOA) (aPlusOfR88 F)
    (entropySplit F) (fun _ => zeroEntropyCarried F) (tca_of_five_le_localBound F) hRow99

end HadwigerNelson.Rigidity
