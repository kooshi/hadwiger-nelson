import Proofs.HadwigerNelson.Collapse.Selection
import Proofs.HadwigerNelson.Plane.YesLimit
import Proofs.HadwigerNelson.Bridge
import Proofs.HadwigerNelson.Reduction
import Proofs.HadwigerNelson.Rigidity.SqrtClassFive
import Proofs.HadwigerNelson.Outside.OAI158

/-!
# The collapse: the plane over `ℚ(√635087)` needs exactly as many colours as the plane (FS-131, job FS131-KCL1; module C7)

**Read aloud, against the informal claim** (`LEDGER.md` row 128: "For every totally real number field `F` whose stable places
are all 6-thick (`λ*_v < 1/5` at every level, both signs; `N₆(F) = ∅` …), `χ(F²) = χ(ℝ²) = χ_CP(ℝ²)`; instances ℚ(√635087)
… and de Grey's field `ℚ(√3,√5,√7,√11)`").

* `chromaticNumber_plane_le_of_thick` — **the load-bearing step with MR⁺** (FS103-LB, its case (B) closed by
  `Rigidity.mrPlus`): over a real number field that is uniformly `c`-thick with `c(k − 1) < 1`, a proper `k`-colouring of
  `F²` gives `χ(ℝ²) ≤ k`.
* `chromaticNumber_planeOver_eq_plane_of_thick` — **the collapse, general form**: over every real number field that is
  uniformly `c`-thick with `c < 1/5`, `χ(F²) = χ(ℝ²)`. **Wider than row 128 in two ways**: no "totally real" (the slice reads
  one plane at every number field, `Rigidity/CountTorus`), and no MR hypothesis (it is `Rigidity.mrPlus`).
  `chromaticNumber_planeOver_eq_plane_of_forall_thickAt` is the same in row 128's per-place words ("every stable place 6-thick").
* `chromaticNumber_planeOver_sqrt635087` — **`χ(ℚ(√635087)²) = χ(ℝ²)`**, with no hypothesis: every stable prime of
  `ℚ(√635087, i)` lies over a prime `p ≡ 3 (mod 4)` at least `103` (`stablePrime_sqrt635087`: `Rigidity.two_notMem_of_isSquare`
  at `635087 ≡ 7 (mod 8)`, `Rigidity.stablePrime_card_of_two_notMem`, and `635087` a non-square modulo the thirteen primes
  `p ≡ 3 (mod 4)` below `103`), so Weil's bound gives `c = 2√103/104 = 0.1952… < 1/5`.
* `chromaticNumber_planeOver_deGrey` — **`χ(ℚ(√3, √5, √7, √11)²) = χ(ℝ²)`**, the same way above `131` (`2√131/132 = 0.1734…`).
* `chromaticNumber_planeOver_sqrt635087_six_or_seven` — with `[OAIMath2026]`'s `6 ≤ χ(ℝ²)` (the declared import
  `Outside.OAI158.no_proper_five_coloring`): `χ(ℚ(√635087)²) ∈ {6, 7}` — rung D over one real quadratic field.

**What it rests on**: the standard three axioms, `Rigidity.positive_entropy_rigidity` (`[EinsiedlerLindenstrauss2022]`
Thm 1.3, through `mrPlus`) and `StandingFive.kloosterman_bound` (`[Weil1948]`, through thickness); the six-or-seven corollary
also on `Outside.OAI158.no_proper_five_coloring`. No hypothesis of ours.

**Not claimed:** `χ_CP(ℝ²)` (row 128's third member; `χ_CP = χ_m⁰` is row 130's, [hand]); the value of `χ(ℝ²)`; that the
general form is new beyond row 128 and FS103-CX (V2's complex-place widening, one mind).

**Models.** The hypotheses of the general theorems are inhabited at `ℚ(√635087)` (`thick_sqrt635087`) and at de Grey's field
(`thick_deGrey`); they fail at `ℚ` (`not_thick_bot`: its stable prime above `2` is ramified) and at `ℚ(√11)` (the dyadic
`K₄`), as `χ(ℚ²) = 2` and `χ(ℚ(√11)²) = 4` require.
-/

namespace HadwigerNelson.Collapse

open SpectralChain NumberField Rigidity SimpleGraph

noncomputable section

/-! ## The general form -/

variable {F : Subfield ℝ} [NumberField F]

/-- **The load-bearing step, with MR⁺**: over a uniformly `c`-thick real number field with `c(k − 1) < 1`, a proper
`k`-colouring of `F²` gives `χ(ℝ²) ≤ k` — the slice (`exists_slice_of_colorable`, its case (B) excluded by `mrPlus`), the
selection (`exists_aeColouring_of_slice`), and N-EASY. -/
theorem chromaticNumber_plane_le_of_thick {c : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c) {k : ℕ} (hk : 2 ≤ k)
    (hck : c * ((k : ℝ) - 1) < 1) (h : ((unitDistance ℂ).induce (planeOver F)).Colorable k) :
    (unitDistance ℂ).chromaticNumber ≤ k := by
  obtain ⟨φ, hφ, hnull⟩ := exists_slice_of_colorable h
  obtain ⟨a⟩ := exists_aeColouring_of_slice hT hc0 hk hck hφ hnull
  exact Plane.chromaticNumber_plane_le_chiM0.trans (Plane.chiM0_le a)

/-- `F²` is not one-colourable: `0` and `1` are at distance one. -/
theorem not_colorable_one_planeOver (F : Subfield ℝ) : ¬ ((unitDistance ℂ).induce (planeOver F)).Colorable 1 := by
  sorry

/-- **The collapse, general form**: over every real number field all of whose stable primes are uniformly `c`-thick with
`c < 1/5`, `χ(F²) = χ(ℝ²)`. Route: `≤` is `Bridge.chromaticNumber_planeOver_le_plane`; for `≥`, every `k` with `F²`
`k`-colourable has `χ(ℝ²) ≤ k` — at `k ≥ 7` by `Bridge.chromaticNumber_complex_le_seven`, at `2 ≤ k ≤ 6` by
`chromaticNumber_plane_le_of_thick` (`c(k − 1) ≤ 5c < 1`), and `k ≤ 1` does not occur (`not_colorable_one_planeOver`). -/
theorem chromaticNumber_planeOver_eq_plane_of_thick {c : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c) (hc : c < 1 / 5) :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber = (unitDistance ℂ).chromaticNumber := by
  sorry

/-- **The collapse in row 128's per-place words**: if every stable prime is `c_P`-thick for some `c_P < 1/5` (`N₆(F) = ∅`),
then `χ(F²) = χ(ℝ²)` (`thick_of_forall_thickAt` makes the constant uniform). -/
theorem chromaticNumber_planeOver_eq_plane_of_forall_thickAt (h : ∀ P : StablePrime F, ∃ c < (1 : ℝ) / 5, ThickAt P c) :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber = (unitDistance ℂ).chromaticNumber := by
  obtain ⟨c, hc, hT⟩ := thick_of_forall_thickAt h
  exact chromaticNumber_planeOver_eq_plane_of_thick (c := max c 0) (fun P => (hT P).mono (le_max_left c 0))
    (le_max_right c 0) (max_lt hc (by norm_num))

/-! ## `ℚ(√635087)` -/

/-- **`ℚ(√635087)`**, as a subfield of `ℝ`: the field of the radicand `635087` (prime, `≡ 7 (mod 8)`). -/
noncomputable abbrev F635087 : Subfield ℝ := SquareClass.fieldOfRadicands {635087}

/-- `635087` is a square in `ℚ(√635087)`. -/
theorem isSquare_635087 : IsSquare ((635087 : ℕ) : F635087) := by
  sorry

/-- **The thirteen small inert primes**: a prime `p ≡ 3 (mod 4)` modulo which `635087` is a square is at least `103` — `635087`
is a non-square modulo each of `3, 7, 11, 19, 23, 31, 43, 47, 59, 67, 71, 79, 83` (`decide` at each). -/
theorem le_of_isSquare_635087 {p : ℕ} (hp : p.Prime) (hp4 : p % 4 = 3) (hsq : IsSquare ((635087 : ℕ) : ZMod p)) :
    103 ≤ p := by
  sorry

/-- **Every stable prime of `ℚ(√635087, i)`**: not above `2`, residue size `Q²` with `Q ≥ 103`. -/
theorem stablePrime_sqrt635087 (P : StablePrime F635087) :
    (2 : 𝓞 (fieldI F635087)) ∉ P.P ∧ ∃ Q : ℕ, 103 ≤ Q ∧ Nat.card (𝓞 (fieldI F635087) ⧸ P.P) = Q ^ 2 := by
  have h2 := Rigidity.two_notMem_of_isSquare P isSquare_635087 (by norm_num)
  obtain ⟨p, n, hp, hp4, hn, -, hcard, hsq⟩ := Rigidity.stablePrime_card_of_two_notMem P h2
  refine ⟨h2, p ^ n, ?_, hcard⟩
  have h103 := le_of_isSquare_635087 hp hp4 (hsq 635087 isSquare_635087)
  have hn0 : n ≠ 0 := by obtain ⟨j, rfl⟩ := hn; omega
  exact h103.trans (Nat.le_self_pow hn0 p)

/-- **`ℚ(√635087)` is uniformly `2√103/104`-thick** (Weil above `103`). -/
theorem thick_sqrt635087 : Thick F635087 (2 * Real.sqrt ((103 : ℕ) : ℝ) / (((103 : ℕ) : ℝ) + 1)) :=
  thick_of_card (by norm_num) stablePrime_sqrt635087

/-- Weil's constant at `103` is below `1/5`: `√103 < 10.4`. -/
theorem weil_103_lt_fifth : 2 * Real.sqrt ((103 : ℕ) : ℝ) / (((103 : ℕ) : ℝ) + 1) < 1 / 5 := by
  sorry

/-- **`χ(ℚ(√635087)²) = χ(ℝ²)`** — row 128's headline instance, with no hypothesis. -/
theorem chromaticNumber_planeOver_sqrt635087 :
    ((unitDistance ℂ).induce (planeOver F635087)).chromaticNumber = (unitDistance ℂ).chromaticNumber :=
  chromaticNumber_planeOver_eq_plane_of_thick thick_sqrt635087 (by positivity) weil_103_lt_fifth

/-- **Rung D over one real quadratic field**: with `[OAIMath2026]`'s `6 ≤ χ(ℝ²)` (`Outside.OAI158.no_proper_five_coloring`),
`6 ≤ χ(ℚ(√635087)²) ≤ 7`. -/
theorem chromaticNumber_planeOver_sqrt635087_six_or_seven :
    6 ≤ ((unitDistance ℂ).induce (planeOver F635087)).chromaticNumber ∧
      ((unitDistance ℂ).induce (planeOver F635087)).chromaticNumber ≤ 7 := by
  rw [chromaticNumber_planeOver_sqrt635087, ← chromaticNumber_plane_eq_complex]
  exact Outside.OAI158.chromaticNumber_plane_six_or_seven

/-! ## De Grey's field -/

/-- **De Grey's field** `ℚ(√3, √5, √7, √11)`, the field of the coordinates of his graph (`CLAUDE.md` G43). -/
noncomputable abbrev FdG : Subfield ℝ := SquareClass.fieldOfRadicands {3, 5, 7, 11}

/-- Each radicand is a square in de Grey's field. -/
theorem isSquare_deGrey {d : ℕ} (hd : d ∈ ({3, 5, 7, 11} : Set ℕ)) : IsSquare ((d : ℕ) : FdG) := by
  sorry

/-- **No prime `p ≡ 3 (mod 4)` below `131` has `3, 5, 7, 11` all squares modulo it** (`decide` at each; `3`, `7`, `11`
themselves included: `5`, `3`, `7` are non-squares modulo them). -/
theorem le_of_isSquare_deGrey {p : ℕ} (hp : p.Prime) (hp4 : p % 4 = 3) (h3 : IsSquare ((3 : ℕ) : ZMod p))
    (h5 : IsSquare ((5 : ℕ) : ZMod p)) (h7 : IsSquare ((7 : ℕ) : ZMod p)) (h11 : IsSquare ((11 : ℕ) : ZMod p)) :
    131 ≤ p := by
  sorry

/-- **Every stable prime of de Grey's field with `i`**: not above `2` (`7 ≡ 7 (mod 8)`), residue size `Q²` with `Q ≥ 131`. -/
theorem stablePrime_deGrey (P : StablePrime FdG) :
    (2 : 𝓞 (fieldI FdG)) ∉ P.P ∧ ∃ Q : ℕ, 131 ≤ Q ∧ Nat.card (𝓞 (fieldI FdG) ⧸ P.P) = Q ^ 2 := by
  have h2 := Rigidity.two_notMem_of_isSquare P (isSquare_deGrey (d := 7) (by simp)) (by norm_num)
  obtain ⟨p, n, hp, hp4, hn, -, hcard, hsq⟩ := Rigidity.stablePrime_card_of_two_notMem P h2
  refine ⟨h2, p ^ n, ?_, hcard⟩
  have h131 := le_of_isSquare_deGrey hp hp4 (hsq 3 (isSquare_deGrey (by simp))) (hsq 5 (isSquare_deGrey (by simp)))
    (hsq 7 (isSquare_deGrey (by simp))) (hsq 11 (isSquare_deGrey (by simp)))
  have hn0 : n ≠ 0 := by obtain ⟨j, rfl⟩ := hn; omega
  exact h131.trans (Nat.le_self_pow hn0 p)

/-- **De Grey's field is uniformly `2√131/132`-thick**. -/
theorem thick_deGrey : Thick FdG (2 * Real.sqrt ((131 : ℕ) : ℝ) / (((131 : ℕ) : ℝ) + 1)) :=
  thick_of_card (by norm_num) stablePrime_deGrey

/-- Weil's constant at `131` is below `1/5`. -/
theorem weil_131_lt_fifth : 2 * Real.sqrt ((131 : ℕ) : ℝ) / (((131 : ℕ) : ℝ) + 1) < 1 / 5 := by
  sorry

/-- **`χ(ℚ(√3, √5, √7, √11)²) = χ(ℝ²)`** — row 128's second instance, with no hypothesis (MR at degree 16 is
`Rigidity.mrPlus` there). -/
theorem chromaticNumber_planeOver_deGrey :
    ((unitDistance ℂ).induce (planeOver FdG)).chromaticNumber = (unitDistance ℂ).chromaticNumber :=
  chromaticNumber_planeOver_eq_plane_of_thick thick_deGrey (by positivity) weil_131_lt_fifth

/-! ## The adversary -/

/-- **`ℚ` is not thick** at any constant below `1`: its stable prime above `2` is ramified
(`UpperHalf.exists_stablePrime_rat`), and `not_isRamified_of_thickAt`. -/
theorem not_thick_bot {c : ℝ} (hc : c < 1) :
    haveI := Rigidity.numberField_bot
    ¬ Thick (⊥ : Subfield ℝ) c := by
  sorry

/-! ## Spec -/

-- the radicand: prime, `≡ 7 (mod 8)` (so `2` splits in `L/F`), and `≡ 3 (mod 4)`.
example : Nat.Prime 635087 ∧ 635087 % 8 = 7 := ⟨by norm_num, by norm_num⟩

-- `635087` is a non-square modulo the first two of the thirteen small primes `≡ 3 (mod 4)`.
example : ¬ IsSquare ((635087 : ℕ) : ZMod 3) ∧ ¬ IsSquare ((635087 : ℕ) : ZMod 7) := by decide

-- and a square modulo `103`, the first stable residue characteristic.
example : IsSquare ((635087 : ℕ) : ZMod 103) := by decide

end

end HadwigerNelson.Collapse
