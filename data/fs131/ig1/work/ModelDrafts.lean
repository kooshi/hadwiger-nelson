import Proofs.HadwigerNelson.Rigidity.Pieces
/-!
FS131-IG1 — draft models of the hypotheses of `Rigidity/Pieces`, for the landing's reading (my record § Drafts for the
landing). Each is a model **given an admissible pair** `p`: an inhabitant of `AdmissiblePair F` is lane A's leaf
`exists_admissiblePair` (`Rigidity/UnitCircle`, open in the kernel). Elaborated against the built tree.
-/
open MeasureTheory HadwigerNelson HadwigerNelson.Rigidity SpectralChain SpectralInputs

namespace FS131IG1Models

variable {F : Subfield ℝ}

/-- **Lemma Γ's hypothesis is inhabited by the point mass at the trivial character** (given `p`): every rotation fixes
the trivial character, so the point mass is `Γ`-invariant, and each measurable set has mass `0` or `1`. -/
theorem ergodicSMul_dirac_one (p : AdmissiblePair F) :
    ErgodicSMul p.subgroup (Dual F) (Measure.dirac (1 : Dual F)) where
  measure_preimage_smul g s hs := by
    have hm : Measurable fun χ : Dual F => g • χ := measurable_rot (toUnitVector (g : unitCircle F))
    rw [Measure.dirac_apply' _ (hm hs), Measure.dirac_apply' _ hs]
    have h1 : g • (1 : Dual F) = 1 := AddChar.ext _ _ fun _ => rfl
    have e : (1 : Dual F) ∈ (fun χ => g • χ) ⁻¹' s ↔ (1 : Dual F) ∈ s := by rw [Set.mem_preimage, h1]
    by_cases h : (1 : Dual F) ∈ s
    · rw [Set.indicator_of_mem h, Set.indicator_of_mem (e.mpr h)]
    · rw [Set.indicator_of_notMem h, Set.indicator_of_notMem (mt e.mp h)]
  aeconst_of_forall_preimage_smul_ae_eq {s} hs _ := by
    refine Filter.eventuallyConst_set'.mpr ?_
    by_cases h1 : (1 : Dual F) ∈ s
    · exact Or.inr (ae_eq_univ.mpr (by rw [Measure.dirac_apply' _ hs.compl]; simp [h1]))
    · exact Or.inl (ae_eq_empty.mpr (by rw [Measure.dirac_apply' _ hs]; simp [h1]))

/-- The first piece `ℤ[Γ]·1`. -/
abbrev firstPiece (p : AdmissiblePair F) : AddSubgroup (unitRing F) :=
  AddSubgroup.closure {y | ∃ (n : Fin 2 → ℤ) (x : unitRing F), x ∈ ({1} : Finset (unitRing F)) ∧ y = p.mulR n x}

/-- **PE-1′'s non-degenerate model of the printed Theorem 1.2's hypotheses** (`Rigidity.haar_or_zero_entropy`), given
`p`: the first piece `ℤ[Γ]·1`, its dual a solenoid, the action totally irreducible and not virtually cyclic, and the
image of the point mass an invariant ergodic probability on it. -/
theorem pe1_model [NumberField F] (p : AdmissiblePair F) :
    ∃ hM : IsPiece p (firstPiece p), IsSolenoid (PieceDual (firstPiece p)) ∧
      (pieceAction hM).IsTotallyIrreducible ∧ ¬ (pieceAction hM).IsVirtuallyCyclic ∧
      IsProbabilityMeasure ((Measure.dirac (1 : Dual F)).map (toPiece (firstPiece p))) ∧
      (pieceAction hM).IsErgodicOn ⊤ ((Measure.dirac (1 : Dual F)).map (toPiece (firstPiece p))) :=
  ⟨isPiece_closure_one, isSolenoid_pieceDual, isTotallyIrreducible_pieceAction _,
    not_isVirtuallyCyclic_pieceAction _, Measure.isProbabilityMeasure_map (measurable_toPiece _).aemeasurable,
    isErgodicOn_map_toPiece _ (ergodicSMul_dirac_one p)⟩

/-- **Lemma Γ at its model** (given `p`): the point mass meets the hypotheses; its entropy is zero (`ksEntropy_dirac`). -/
example [NumberField F] (p : AdmissiblePair F) :
    IsHaarFourier (Measure.dirac (1 : Dual F)) ∨
      ∀ g ∈ p.subgroup, ksEntropy (Measure.dirac (1 : Dual F)) (rot (toUnitVector g)) = 0 :=
  isHaarFourier_or_ksEntropy_eq_zero p _ (ergodicSMul_dirac_one p)

end FS131IG1Models
