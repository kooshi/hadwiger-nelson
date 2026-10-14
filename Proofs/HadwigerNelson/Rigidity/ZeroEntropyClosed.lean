import Proofs.HadwigerNelson.Rigidity.WanderingShells
import Proofs.HadwigerNelson.Rigidity.TateExists
import Proofs.HadwigerNelson.Rigidity.EntropySplitMax

/-!
# EF_F⁺ and PE-2 over every real number field, and MR⁺ from them (FS-131, jobs FS131-K8B1 and FS131-IJN1)

**EF_F⁺.** A Tate model exists at every real number field (`Rigidity.exists_tateModel`, lane T), and over any Tate model
EF_F⁺ holds (`zeroEntropyCarried_of_tateModel`, M8b's parts 2–4). **No step reads the scope**, so the statement proved here
has none (`zeroEntropyCarried`). The chain's leaf `zeroEntropyCarried` moved here from `Rigidity/ChainAtTA` at the chain's
join (FS131-IJN1; the coordinator's ruling of inventory item 811), its scope binder `NoRamifiedStableDyadic F` dropped,
unread; the second name it had beside it for the same statement was removed at the chain's landing (FS131-LCH1).

**PE-2 at one non-torsion rotation.** The chain's leaf `entropySplit` moved here from `Rigidity/ChainAtTA` at the same join
(inventory item 761, ruling 5): `entropySplit_of_admissiblePair` (`Rigidity/EntropySplitMax`) at the admissible pair that
lane A supplies (`Rigidity.exists_admissiblePair`). It rests on the declared outside theorem
`Rigidity.positive_entropy_rigidity` (`[EinsiedlerLindenstrauss2022]` Thm 1.3) through Lemma Γ.

**MR⁺.** The two readers of `zeroEntropyCarried` moved with it: `mrPlus` (MR⁺ over every real number field — its scope
binder dropped, unread once `zeroEntropyCarried` has none) and `min_localBound_five_le_chromaticNumber_closed` (the
headline over the two classical theorems and the chain's four other hand results). The headline with every proved
hypothesis discharged is `Rigidity.min_localBound_five_le_chromaticNumber` (`Rigidity/ChainHeadline`).

**Inhabitants.** `ZeroEntropyCarried F`'s clause: `zeroEntropyCarried_model`. `EntropySplit F`'s hypotheses (a finite
rotation-invariant measure): `dualHaar` and the point mass at the trivial character (`Rigidity/EntropySplitMax`).
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory SimpleGraph SpectralChain SpectralInputs NumberField

/-- **PE-2 at one non-torsion rotation** (FS100-PE2; [hand], X02D and X02V; the variant EN2-PE2-MAX of
`plans/FS131-EN2-derivation.md` § 5.2): the entropy split holds over every real number field, with the entropy zero at a
rotation of one admissible `Γ` — `entropySplit_of_admissiblePair` at the pair of `exists_admissiblePair`. Rests on
`Rigidity.positive_entropy_rigidity` through `Rigidity.haar_or_zero_entropy` on the pieces `M̂`; needs no Lemma W for
every vector and no torsion case (FS131-KN7). -/
theorem entropySplit (F : Subfield ℝ) [NumberField F] : EntropySplit F :=
  entropySplit_of_admissiblePair (exists_admissiblePair (F := F)).some

/-- **EF_F⁺ over every real number field** (FS100-EFP; X01D § 3, X12B, FS105-B; [kernel] over lane T's and M8b's
leaves): every rotation-invariant probability measure on `R̂` of entropy zero under one non-torsion rotation is carried
by `T + A` — a Tate model (`exists_tateModel`) and `zeroEntropyCarried_of_tateModel`. The scope
`NoRamifiedStableDyadic F` it was first stated under is read by no step (FS131-K8B1) and was dropped when it moved here
(FS131-IJN1). -/
theorem zeroEntropyCarried (F : Subfield ℝ) [NumberField F] : ZeroEntropyCarried F :=
  (exists_tateModel F).elim zeroEntropyCarried_of_tateModel

/-- **MR⁺(F)**, for every real number field: PE-2 and EF_F⁺ by `mrPlus_of_split_of_carried`. -/
theorem mrPlus (F : Subfield ℝ) [NumberField F] : MRPlus F :=
  mrPlus_of_split_of_carried F (entropySplit F) (zeroEntropyCarried F)

/-- **The headline over the two classical theorems and the chain's four other hand results**: PE-2 and EF_F⁺ are the
theorems above. -/
theorem min_localBound_five_le_chromaticNumber_closed (F : Subfield ℝ) [NumberField F]
    (hBH : BochnerHerglotz (unitRing F))
    (hL1 : InvariantMeasureOnClosed F) (hCount : (chainInterface F).Count) (hAP : (chainInterface F).APlusOfR88)
    (hCLS : 5 ≤ localBound F → TCA F)
    (hRow99 : localBound F ≤ 4 → localBound F ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber) :
    min (localBound F) 5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber :=
  min_localBound_five_le_chromaticNumber_of_closed F hBH hL1 hCount hAP (entropySplit F)
    (fun _ => zeroEntropyCarried F) hCLS hRow99

end HadwigerNelson.Rigidity
