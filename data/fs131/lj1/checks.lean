import Proofs
/-!
FS131-LJ1 — the landing's own kernel-checked terms and prints (not library theorems; elaborated by the gate's pass with
the lakefile's options, `lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false data/fs131/lj1/checks.lean`).

1. The headline statements by `#check`, and their axioms by `#print axioms` (the read-aloud's source, stage 6).
2. **The retired assumption** (stage 4): the four theorems that take the binder `hRow99`, each applied to
   `ThreeFourColours.localBound_le_chromaticNumber_of_le_four` — the binder's type is that theorem's type, or these
   do not elaborate — and the axioms each then rests on.
3. The models of the hypothesis-shaped headlines that no library declaration holds (stage 5).
-/
open HadwigerNelson HadwigerNelson.Arith HadwigerNelson.SpectralChain HadwigerNelson.CharacterColouring
  HadwigerNelson.SquareClass HadwigerNelson.ThreeColourCriterion HadwigerNelson.DyadicQuadratic HadwigerNelson.UpperHalf
  SimpleGraph NumberField

set_option pp.fullNames true

namespace FS131LJ1

/-! ## 1. Headlines -/
#check @ThreeFourColours.chromaticNumber_planeOver_sqrt_table
#check @ThreeFourColours.chromaticNumber_planeOver_eq_three_iff
#check @ThreeFourColours.colorable_three_planeOver_iff
#check @TorsionExtraction.four_le_chromaticNumber_planeOver_of_inv_three_mem
#check @TorsionExtraction.chromaticNumber_planeOver_ne_three_of_inv_three_mem
#check @TorsionExtraction.four_le_chromaticNumber_planeOver_of_sqrt_mem
#check @ThreeFourColours.localBound_le_chromaticNumber_of_le_four
#check @ThreeFourColours.chromaticNumber_planeOver_eq_localBound_of_le_four
#check @ThreeFourColours.chromaticNumber_planeOver_le_three_iff
#check @ThreeFourColours.localBound_le_chromaticNumber_or_four_le

#print axioms ThreeFourColours.chromaticNumber_planeOver_sqrt_table
#print axioms ThreeFourColours.chromaticNumber_planeOver_eq_three_iff
#print axioms ThreeFourColours.colorable_three_planeOver_iff
#print axioms ThreeFourColours.colorable_three_of_card_three
#print axioms TorsionExtraction.four_le_chromaticNumber_planeOver_of_inv_three_mem
#print axioms TorsionExtraction.chromaticNumber_planeOver_ne_three_of_inv_three_mem
#print axioms TorsionExtraction.four_le_chromaticNumber_planeOver_of_sqrt_mem
#print axioms TorsionExtraction.four_le_chromaticNumber_planeOver_fieldOfRadicands
#print axioms TorsionExtraction.fieldBandSet_three_eq_empty_of_sqrt_mem
#print axioms ThreeFourColours.localBound_le_chromaticNumber_or_four_le
#print axioms ThreeFourColours.localBound_le_chromaticNumber_of_le_four
#print axioms ThreeFourColours.chromaticNumber_planeOver_eq_localBound_of_le_four
#print axioms ThreeFourColours.chromaticNumber_planeOver_le_three_iff
-- each half of each exact value of the table, by name
#print axioms DyadicQuadratic.colorable_two_planeOver_sqrt
#print axioms UpperHalf.two_le_chromaticNumber_planeOver
#print axioms ThreeFourColours.colorable_three_planeOver_sqrt
#print axioms TorsionExtraction.three_le_chromaticNumber_planeOver_of_sqrt_mem
#print axioms DyadicQuadratic.colorable_four_planeOver_sqrt
#print axioms ThreeFourColours.colorable_four_planeOver_sqrt_of_seven
#print axioms ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_two
#print axioms ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_three
#print axioms ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four
#print axioms ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four_of_dyadic
#print axioms ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four_of_seven
-- where Weil's bound enters
#print axioms ThreeColourCriterion.targetFloor_four_weil
#print axioms ThreeColourCriterion.exists_maximal_card_nine_of_colorable_three
#print axioms ThreeColourCriterion.exists_maximal_conj_trivial_of_colorable_two
#print axioms UpperHalf.chromaticNumber_planeOver_le_localBound

/-! ## 2. The binder `hRow99`, discharged at each of its four sites -/

section Row99
variable {F : Subfield ℝ} [NumberField F]

/-- The binder's type, copied from `SpectralChain.lean:598`, is the theorem's. -/
theorem row99_binder :
    localBound F ≤ 4 → localBound F ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber :=
  ThreeFourColours.localBound_le_chromaticNumber_of_le_four F

/-- Site 1: `SpectralChain.min_localBound_five_le_chromaticNumber`. -/
theorem site_min (hBH : BochnerHerglotz (unitRing F)) (hL1 : InvariantMeasureOnClosed F) (I : Interface F)
    (hTR : NumberField.IsTotallyReal F → I.Count) (hCX : ¬ NumberField.IsTotallyReal F → I.Count)
    (hAP : I.APlusOfR88) (hRU : I.RU) (hMR : TCA F → I.PE2 ∧ I.EFPlus) (hCLS : 5 ≤ localBound F → TCA F) :
    min (localBound F) 5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber :=
  SpectralChain.min_localBound_five_le_chromaticNumber hBH hL1 I hTR hCX hAP hRU hMR hCLS row99_binder

/-- Site 2: `SpectralChain.min_localBound_five_le_chromaticNumber_of_totallyReal`. -/
theorem site_min_totallyReal [NumberField.IsTotallyReal F] (hBH : BochnerHerglotz (unitRing F))
    (hL1 : InvariantMeasureOnClosed F) (I : Interface F) (hCount : I.Count) (hAP : I.APlusOfR88) (hRU : I.RU)
    (hMR : TCA F → I.PE2 ∧ I.EFPlus) (hCLS : 5 ≤ localBound F → TCA F) :
    min (localBound F) 5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber :=
  SpectralChain.min_localBound_five_le_chromaticNumber_of_totallyReal hBH hL1 I hCount hAP hRU hMR hCLS row99_binder

/-- Site 3: `SpectralChain.chromaticNumber_eq_localBound` (with `hUpper` discharged as FS131-LU1 retired it). -/
theorem site_eq [NumberField.IsTotallyReal F] (hBH : BochnerHerglotz (unitRing F))
    (hL1 : InvariantMeasureOnClosed F) (I : Interface F) (hCount : I.Count) (hAP : I.APlusOfR88) (hRU : I.RU)
    (hMR : TCA F → I.PE2 ∧ I.EFPlus) (hCLS : 5 ≤ localBound F → TCA F) (hL : localBound F ≤ 5) :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber = localBound F :=
  SpectralChain.chromaticNumber_eq_localBound hBH hL1 I hCount hAP hRU hMR hCLS row99_binder
    (UpperHalf.chromaticNumber_planeOver_le_localBound F) hL

/-- Site 4: `UpperHalf.chromaticNumber_eq_localBound_of_chain` — the chain's headline with neither `hUpper` nor
`hRow99`: what its restatement would be. -/
theorem site_chain [NumberField.IsTotallyReal F] (hBH : BochnerHerglotz (unitRing F))
    (hL1 : InvariantMeasureOnClosed F) (I : Interface F) (hCount : I.Count) (hAP : I.APlusOfR88) (hRU : I.RU)
    (hMR : TCA F → I.PE2 ∧ I.EFPlus) (hCLS : 5 ≤ localBound F → TCA F) (hL : localBound F ≤ 5) :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber = localBound F :=
  UpperHalf.chromaticNumber_eq_localBound_of_chain hBH hL1 I hCount hAP hRU hMR hCLS row99_binder hL

end Row99

#print axioms row99_binder
#print axioms site_min
#print axioms site_min_totallyReal
#print axioms site_eq
#print axioms site_chain
-- the four takers themselves, as they stand (the binder still in each statement)
#print axioms SpectralChain.min_localBound_five_le_chromaticNumber
#print axioms SpectralChain.min_localBound_five_le_chromaticNumber_of_totallyReal
#print axioms SpectralChain.chromaticNumber_eq_localBound
#print axioms UpperHalf.chromaticNumber_eq_localBound_of_chain

/-! ## 3. Models -/

/-- `L(ℚ) ≤ 2`: the hypothesis `localBound F ≤ 4` (and `≤ 2`, `≤ 3`) of row 99's forms is inhabited at `ℚ`. -/
theorem localBound_rat_le_two : localBound (⊥ : Subfield ℝ) ≤ 2 := by
  obtain ⟨P, -, hram⟩ := UpperHalf.exists_stablePrime_rat
  exact (iInf_le _ P).trans (ThreeFourColours.levelTarget_colorable_two_of_ramified P hram).chromaticNumber_le

/-- `χ(ℚ²) = L(ℚ) = 2`: row 99's second sentence read at `ℚ` (on Weil's bound, as the sentence is), and the
hypothesis of `UpperHalf.chromaticNumber_planeOver_eq_two_of_localBound_le_two` inhabited. -/
theorem localBound_rat_eq_two : localBound (⊥ : Subfield ℝ) = 2 := by
  rw [← ThreeFourColours.chromaticNumber_planeOver_eq_localBound_of_le_four ⊥
    (localBound_rat_le_two.trans (by norm_num))]
  exact UpperHalf.chromaticNumber_planeOver_eq_two_of_localBound_le_two ⊥ localBound_rat_le_two

/-- A stable prime of `ℚ(√3)(i)` with nine elements in its quotient: the hypothesis of
`levelTarget_colorable_three_of_card_nine` and `exists_maximal_card_three_of_stablePrime_card_nine`. -/
theorem stablePrime_nine_sqrt_three :
    ∃ P : StablePrime (fieldOfRadicands {3}), Nat.card (𝓞 (fieldI (fieldOfRadicands {3})) ⧸ P.P ^ 1) = 9 := by
  obtain ⟨𝔪, h𝔪, h9⟩ := ThreeFourColours.exists_maximal_card_nine_sqrt_three
  exact ThreeFourColours.exists_stablePrime_card_nine h𝔪 h9

/-- `L(ℚ(√3)) = 3 = χ(ℚ(√3)²)`: row 99's forms at a field with `L = 3`. -/
theorem localBound_sqrt_three : localBound (fieldOfRadicands {3}) = 3 := by
  obtain ⟨P, hP⟩ := stablePrime_nine_sqrt_three
  have hle : localBound (fieldOfRadicands {3}) ≤ 3 :=
    (iInf_le _ P).trans (ThreeFourColours.levelTarget_colorable_three_of_card_nine P hP).chromaticNumber_le
  rw [← ThreeFourColours.chromaticNumber_planeOver_eq_localBound_of_le_four _ (hle.trans (by norm_num))]
  exact ThreeFourColours.chromaticNumber_planeOver_sqrt_three

/-- `L(ℚ(√11)) = 4 = χ(ℚ(√11)²)`: row 99's forms at a field with `L = 4`, the boundary of `localBound F ≤ 4` — the
stable prime above 2 with four elements (`exists_stablePrime_card_four_sqrt`) has a target on four vertices. -/
theorem localBound_sqrt_eleven : localBound (fieldOfRadicands {11}) = 4 := by
  obtain ⟨P, -, h4⟩ := ThreeFourColours.exists_stablePrime_card_four_sqrt (m := 11) (by norm_num)
  have hfin : Finite (𝓞 (fieldI (fieldOfRadicands {11})) ⧸ P.P ^ 1) :=
    Nat.finite_of_card_ne_zero (by rw [h4]; norm_num)
  letI := Fintype.ofFinite (𝓞 (fieldI (fieldOfRadicands {11})) ⧸ P.P ^ 1)
  have hcol : (levelTarget P 1).Colorable 4 := by
    have h := (levelTarget P 1).colorable_of_fintype
    rwa [Fintype.card_eq_nat_card, h4] at h
  have hle : localBound (fieldOfRadicands {11}) ≤ 4 := (iInf_le _ P).trans hcol.chromaticNumber_le
  rw [← ThreeFourColours.chromaticNumber_planeOver_eq_localBound_of_le_four _ hle]
  exact ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four_of_dyadic (m := 11) (by norm_num)

/-- Clause (b), the side where the prime exists: `ℚ(√3)` — not bipartite, three-chromatic, and a prime with
residue field `𝔽₃`. -/
theorem clause_b_true_side :
    ¬ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {3}))).Colorable 2 ∧
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {3}))).chromaticNumber = 3 ∧
    ∃ 𝔭 : Ideal (𝓞 (fieldOfRadicands {3})), 𝔭.IsMaximal ∧ Nat.card (𝓞 (fieldOfRadicands {3}) ⧸ 𝔭) = 3 := by
  have hnb : ¬ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {3}))).Colorable 2 :=
    TorsionExtraction.not_colorable_two_of_sqrt_mem (d := 3) (by norm_num)
      (sqrt_mem_fieldOfRadicands (Set.mem_singleton 3))
  exact ⟨hnb, ThreeFourColours.chromaticNumber_planeOver_sqrt_three,
    (ThreeFourColours.chromaticNumber_planeOver_eq_three_iff _ hnb).mp
      ThreeFourColours.chromaticNumber_planeOver_sqrt_three⟩

/-- Clause (b), the side where no prime exists: `ℚ(√11)` — not bipartite, four-chromatic, and no prime with residue
field `𝔽₃` (3 is inert). The hypothesis `hnb` is satisfiable with either side of the iff. -/
theorem clause_b_false_side :
    ¬ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).Colorable 2 ∧
    ¬ ∃ 𝔭 : Ideal (𝓞 (fieldOfRadicands {11})), 𝔭.IsMaximal ∧ Nat.card (𝓞 (fieldOfRadicands {11}) ⧸ 𝔭) = 3 := by
  have hnb : ¬ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).Colorable 2 :=
    TorsionExtraction.not_colorable_two_of_sqrt_mem (d := 11) (by norm_num)
      (sqrt_mem_fieldOfRadicands (Set.mem_singleton 11))
  refine ⟨hnb, fun h => ?_⟩
  have h3 := (ThreeFourColours.chromaticNumber_planeOver_eq_three_iff _ hnb).mpr h
  have h4 := ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four_of_dyadic (m := 11) (by norm_num)
  rw [h3] at h4
  exact absurd h4 (by norm_num)

/-- Clause (c), both hypotheses at once: `ℚ(√11)` holds `1/3` in its unit-vector ring and is not bipartite. -/
theorem clause_c_model :
    (3 : ℂ)⁻¹ ∈ unitRing (fieldOfRadicands {11}) ∧
    ¬ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).Colorable 2 :=
  ⟨TorsionExtraction.inv_three_mem_unitRing_of_sqrt_mem (d := 11) (by norm_num)
      (sqrt_mem_fieldOfRadicands (Set.mem_singleton 11)),
    TorsionExtraction.not_colorable_two_of_sqrt_mem (d := 11) (by norm_num)
      (sqrt_mem_fieldOfRadicands (Set.mem_singleton 11))⟩

/-- Clause (c)'s hypothesis `1/3 ∈ ℤ[U_F]` is a real condition: it fails at `ℚ(√3)` (there the plane is exactly
three-chromatic, which the clause's dated widening excludes). -/
theorem inv_three_notMem_sqrt_three : (3 : ℂ)⁻¹ ∉ unitRing (fieldOfRadicands {3}) := fun h =>
  TorsionExtraction.chromaticNumber_planeOver_ne_three_of_inv_three_mem h
    ThreeFourColours.chromaticNumber_planeOver_sqrt_three

/-- The table's row at 4 at the three radicands of row 73 that the module holds only as the theorem read by hand:
71, 95 and 191 (23 is the module's own `example`). -/
theorem table_at_71_95_191 :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {71}))).chromaticNumber = 4 ∧
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {95}))).chromaticNumber = 4 ∧
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {191}))).chromaticNumber = 4 :=
  ⟨ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four (by decide +kernel) (by norm_num) (by norm_num),
   ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four (by decide +kernel) (by norm_num) (by norm_num),
   ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four (by decide +kernel) (by norm_num) (by norm_num)⟩

end FS131LJ1

#print axioms FS131LJ1.localBound_rat_le_two
#print axioms FS131LJ1.localBound_rat_eq_two
#print axioms FS131LJ1.stablePrime_nine_sqrt_three
#print axioms FS131LJ1.localBound_sqrt_three
#print axioms FS131LJ1.localBound_sqrt_eleven
#print axioms FS131LJ1.clause_b_true_side
#print axioms FS131LJ1.clause_b_false_side
#print axioms FS131LJ1.clause_c_model
#print axioms FS131LJ1.inv_three_notMem_sqrt_three
#print axioms FS131LJ1.table_at_71_95_191
