import Proofs.HadwigerNelson.Rigidity.WanderingShells
import Proofs.HadwigerNelson.Rigidity.TateExists

/-!
# EF_F⁺ over every real number field: the proposed home of `zeroEntropyCarried`'s proof (FS-131, job FS131-K8B1; skeleton)

`Rigidity.zeroEntropyCarried` (module `Rigidity/ChainAtTA`) states EF_F⁺ under the scope `NoRamifiedStableDyadic F` and sits
upstream of everything that proves it. Its proof is here: a Tate model exists at every real number field
(`Rigidity.exists_tateModel`, lane T), and over any Tate model EF_F⁺ holds (`zeroEntropyCarried_of_tateModel`, M8b's parts
2–4). **No step reads the scope**, so the statement proved here has none (`zeroEntropyCarried_of_numberField`). At the chain's
landing `zeroEntropyCarried` moves here — downstream of M8b and lane T — or is re-stated here with its scope binder dropped
(the coordinator's ruling of inventory item 788 keeps the binder until the proof shows it unread; this module is that proof),
and the theorems of `Rigidity/ChainAtTA` that read it (`mrPlus`, `min_localBound_five_le_chromaticNumber_closed`) move with it,
as `entropySplit` moves downstream of `Rigidity/EntropySplitMax` (inventory item 761, ruling 5).

**Inhabitants.** `ZeroEntropyCarried F`'s clause: `zeroEntropyCarried_model`.
-/

namespace HadwigerNelson.Rigidity

/-- **EF_F⁺ over every real number field** (FS100-EFP; X01D § 3; [kernel] over lane T's and M8b's leaves): every
rotation-invariant probability measure on `R̂` of entropy zero under one non-torsion rotation is carried by `T + A`. -/
theorem zeroEntropyCarried_of_numberField (F : Subfield ℝ) [NumberField F] : ZeroEntropyCarried F :=
  (exists_tateModel F).elim zeroEntropyCarried_of_tateModel

end HadwigerNelson.Rigidity
