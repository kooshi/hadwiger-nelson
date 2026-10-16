import Proofs.HadwigerNelson.Rigidity.SqrtClassFive

/-!
# CLS in full: the stable places whose level-one target is four-colourable (FS-131, job FS131-KCS1; skeleton)

**Read aloud, against the informal claim** (`LEDGER.md` row 123; FS100-CLS: "every stable place has `r_v < 1/4` ⟺ no
stable level-one target has `χ ≤ 4` ⟺ `L(F) ≥ 5` (level-one or all-levels reading of `L`). The places with `r_v ≥ 1/4` are
exactly `q ∈ {3, 7}`, dyadic inert `Q ≤ 32`, and dyadic ramified in `L/F`"). For a real number field `F` and a stable prime
`P` of `F(i)`:

* `IsFourColourPlace P` — **the list**: `P` is ramified over `F` (conjugation trivial on `𝓞 ⧸ P`; such a `P` is dyadic,
  `UpperHalf.two_mem_of_conj_trivial`), or `|𝓞 ⧸ P| = Q²` with `Q ∈ {2, 3, 4, 7, 8, 16, 32}`. At an unramified stable
  prime `Q` is the size of `F`'s residue field (the fixed field of conjugation), so `Q ∈ {3, 7}` is "residue field `𝔽₃` or
  `𝔽₇`" and `Q = 2^f ≤ 32` is "dyadic inert of norm at most 32".
* `colorable_four_levelTarget_one_iff` — **a level-one target is four-colourable exactly at the listed places**;
  `exists_ratioAtMost_lt_quarter_iff` — **the all-levels ratio is below `1/4` exactly off the list**.
* `five_le_localBound_iff`, `tca_iff_forall_not_isFourColourPlace` — **CLS, field form**: `L(F) ≥ 5` ⟺ T-C(A) at `S = ∅`
  ⟺ no stable place is listed.
* `localBoundAllLevels`, `five_le_localBoundAllLevels_iff`, `min_localBoundAllLevels_five` — **the all-levels reading of
  `L`** agrees with the library's level-one `localBound` from five down.

**Not claimed:** anything at six colours; that the list is new mathematics (FS100-CLS: the real-quadratic case is row 117,
the general statement not found in print by X24R, who did not search it by name).

**Inhabitants.** `StablePrime` is inhabited at `ℚ` (`UpperHalf.exists_stablePrime_rat`, ramified, so listed) and at
`ℚ(√47)` above 11 (`SqrtFortySeven.exists_stablePrime_eleven`, `|𝓞 ⧸ P| = 11²`, not listed).
-/

namespace HadwigerNelson.Rigidity

open SpectralChain NumberField SimpleGraph

noncomputable section

variable {F : Subfield ℝ}

/-- **The places CLS lists** (FS100-CLS): `P` ramified over `F`, or `|𝓞 (F(i)) ⧸ P| = Q²` with
`Q ∈ {2, 3, 4, 7, 8, 16, 32}` — residue field `𝔽₃` or `𝔽₇`, or dyadic inert of norm at most 32. -/
def IsFourColourPlace (P : StablePrime F) : Prop :=
  IsRamified P ∨ ∃ Q ∈ ({2, 3, 4, 7, 8, 16, 32} : Finset ℕ), Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2

/-- **A listed place has a four-colourable level-one target**: two colours when ramified
(`colorable_two_levelTarget_one_of_isRamified`), `Γ₃`, `Γ₇` at `Q ∈ {3, 7}`, `U_Q` at `Q = 2^f ≤ 32`. -/
theorem colorable_four_levelTarget_one_of_isFourColourPlace [NumberField F] (P : StablePrime F)
    (h : IsFourColourPlace P) : (levelTarget P 1).Colorable 4 := by
  sorry

/-- **Off the list the all-levels ratio is below `1/4`**: odd by `ratioAtMost_of_two_notMem`, dyadic inert with
`Q = 2^f ≥ 64` by the large-dyadic branch of `ClassRatio`. -/
theorem exists_ratioAtMost_of_not_isFourColourPlace [NumberField F] (P : StablePrime F)
    (h : ¬ IsFourColourPlace P) : ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := by
  sorry

/-- **CLS per place, colour form**: the level-one target at a stable prime is four-colourable exactly when the place is
listed. -/
theorem colorable_four_levelTarget_one_iff [NumberField F] (P : StablePrime F) :
    (levelTarget P 1).Colorable 4 ↔ IsFourColourPlace P := by
  sorry

/-- **CLS per place, ratio form**: the all-levels four-colour ratio is below `1/4` exactly off the list. -/
theorem exists_ratioAtMost_lt_quarter_iff [NumberField F] (P : StablePrime F) :
    (∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c) ↔ ¬ IsFourColourPlace P := by
  sorry

/-- **CLS per place, chromatic form**: the level-one target needs five colours exactly off the list. -/
theorem five_le_chromaticNumber_levelTarget_one_iff [NumberField F] (P : StablePrime F) :
    5 ≤ (levelTarget P 1).chromaticNumber ↔ ¬ IsFourColourPlace P := by
  sorry

variable (F) in
/-- **CLS in full, field form** (row 123): `L(F) ≥ 5` exactly when no stable place of `F(i)` is listed — none has residue
field `𝔽₃` or `𝔽₇`, none is dyadic inert of norm at most 32, none is ramified over `F`. -/
theorem five_le_localBound_iff [NumberField F] :
    5 ≤ localBound F ↔ ∀ P : StablePrime F, ¬ IsFourColourPlace P := by
  sorry

variable (F) in
/-- **CLS in full, T-C(A) form**: T-C(A) at `S = ∅` exactly when no stable place is listed. -/
theorem tca_iff_forall_not_isFourColourPlace [NumberField F] :
    TCA F ↔ ∀ P : StablePrime F, ¬ IsFourColourPlace P := by
  sorry

/-! ### The all-levels reading of `L` -/

variable (F) in
/-- **`L(F)`, all-levels reading**: the least chromatic number among the residue targets `levelTarget P m`, every stable
prime `P` and every level `m ≥ 1`. The library's `localBound` reads level one (`CLAUDE.md` § Notation). -/
def localBoundAllLevels : ℕ∞ := ⨅ (P : StablePrime F) (m : ℕ) (_ : 1 ≤ m), (levelTarget P m).chromaticNumber

variable (F) in
/-- The all-levels bound is at most the level-one bound. -/
theorem localBoundAllLevels_le_localBound : localBoundAllLevels F ≤ localBound F := by
  sorry

variable (F) in
/-- **The upper half at every level**: `χ(F²) ≤ L_all(F)` (`UpperHalf.chromaticNumber_planeOver_le_levelTarget`). -/
theorem chromaticNumber_planeOver_le_localBoundAllLevels [NumberField F] :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ≤ localBoundAllLevels F := by
  sorry

/-- **A ratio below `1/4` needs five colours at every level** (`five_le_chromaticNumber_of_ratioAtMost` at level `m`). -/
theorem five_le_chromaticNumber_levelTarget_of_ratioAtMost [NumberField F] (P : StablePrime F) {c : ℝ}
    (hc : c < 1 / 4) (h : RatioAtMost P c) {m : ℕ} (hm : 1 ≤ m) : 5 ≤ (levelTarget P m).chromaticNumber := by
  sorry

variable (F) in
/-- **CLS's "level-one or all-levels reading"**: `L_all(F) ≥ 5` exactly when `L(F) ≥ 5`. -/
theorem five_le_localBoundAllLevels_iff [NumberField F] : 5 ≤ localBoundAllLevels F ↔ 5 ≤ localBound F := by
  sorry

variable (F) in
/-- **The two readings of `L` agree through five**: `min(L_all(F), 5) = min(L(F), 5)`. Rests on the headline's two
declared outside theorems. -/
theorem min_localBoundAllLevels_five [NumberField F] : min (localBoundAllLevels F) 5 = min (localBound F) 5 := by
  sorry

/-! ## Spec -/

-- The list's residue sizes: `Q²` for `Q ∈ {2, 3, 4, 7, 8, 16, 32}`, and `11² = 121` is not among them.
example : (({2, 3, 4, 7, 8, 16, 32} : Finset ℕ).image (· ^ 2)) = {4, 9, 16, 49, 64, 256, 1024} := by decide
example : ∀ Q ∈ ({2, 3, 4, 7, 8, 16, 32} : Finset ℕ), Q ^ 2 ≠ 121 := by decide

end

end HadwigerNelson.Rigidity
