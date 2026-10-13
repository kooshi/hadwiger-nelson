import Proofs.HadwigerNelson.Arith.PlaceHom
import Proofs.HadwigerNelson.SpectralChain
import Proofs.HadwigerNelson.TwoColourResidue
import Mathlib.RingTheory.DedekindDomain.AdicValuation

/-!
# The residue upper half: a plane over a real number field needs no more colours than any of its residue targets (FS-131, NF1)

Claims: `data/fs131/claims-NF1.md` (NF1-S1A, NF1-S1B). Plan: `plans/FS131-KN2-upper-half-plan.md`.

**Read aloud, against the informal claim.** `F ⊆ ℝ` is a number field (`F : Subfield ℝ`, `NumberField F`), its plane is
`planeOver F ⊆ ℂ`, and `χ(F²)` is `((unitDistance ℂ).induce (planeOver F)).chromaticNumber` (Mathlib's
`SimpleGraph.chromaticNumber`, an `ℕ∞`: the infimum of the `n` with a proper `n`-colouring).

* **At a usable prime** `𝔭` of `𝓞 F` (maximal, residue field of `q ≡ 3 (mod 4)` elements; `Arith.IsUsablePrime`) the plane maps
  homomorphically to `Γ_q = unitQuadrance (𝓞 F ⧸ 𝔭)`, so `χ(F²) ≤ χ(Γ_q)` (`chromaticNumber_planeOver_le_unitQuadrance`); when
  the residue field has prime order `p`, to `finitePlane p` (`chromaticNumber_planeOver_le_finitePlane`). Both are corollaries
  of `Arith.placeHom_base` and are proved here.
* **At a stable prime** `P` of `F(i)` (`SpectralChain.StablePrime`: a maximal ideal of `𝓞 (F(i))` fixed by conjugation) the
  plane maps homomorphically to the level-`m` target `Cay(𝓞 ⧸ P^m, {x : x·x̄ = 1})` for every `m ≥ 1`
  (`exists_hom_levelTarget`), given on each coset of the localization `𝓞_P` by the residue map. So
  `χ(F²) ≤ χ(levelTarget P m)`, and `χ(F²) ≤ L(F)` (`chromaticNumber_planeOver_le_localBound`), which discharges the
  hypothesis `hUpper` of `SpectralChain.chromaticNumber_eq_localBound` (`chromaticNumber_eq_localBound_of_chain`).
* **Two colours**: at a stable prime on whose residue field conjugation is the identity (ramified over `F`; it then holds
  `2`), `χ(F²) ≤ 2` (`colorable_two_planeOver_of_ramified`).
* **Conversely** every conjugation-stable valuation subring of `F(i)` other than `F(i)` is `𝓞_P` for a stable prime `P`
  (`exists_stablePrime_of_valuationSubring`), so `LEDGER.md` row 105's prime inversion reads over the stable primes:
  `1/n ∈ ℤ[U_F]` iff no stable prime of `F(i)` holds `n` (`inv_natCast_mem_unitRingOver_iff_forall_stablePrime`).

**Not claimed:** any lower bound; that `levelTarget P m` is the image of the unit vectors (it is every norm-one element of the
quotient — `SpectralChain`'s caveat); the identification of `levelTarget P 1` at an odd inert prime with `Γ_q`.

**The localization** is Mathlib's `IsDedekindDomain.HeightOneSpectrum.valuationSubringAtPrime`, at the height-one prime
`P.heightOne`; `P.localRing` abbreviates it and `P.residue m : P.localRing →+* 𝓞 ⧸ P^m` is `IsLocalization.lift` of the
quotient map (an element outside `P` is a unit modulo `P^m`: `Ideal.IsMaximal.exists_inv_pow`).

**Inhabitants.** `IsUsablePrime` and `StablePrime F` are the hypotheses that are structures. A usable prime with its
residue field is exhibited at `ℚ(√11)`, `ℚ(√47)` and `ℚ(√167)` in `Instances/UpperHalf` (through `Arith/QuadraticPrime`), and a
stable prime of `ℚ(i)` there too; `StandingFive.exists_stablePrime_two` exhibits a stable prime of another field.
-/

namespace HadwigerNelson.UpperHalf

open HadwigerNelson HadwigerNelson.Arith HadwigerNelson.SpectralChain SimpleGraph NumberField IsDedekindDomain

/-! ## NF1-S1A: at a usable prime of `F` -/

/-- **The residue homomorphism at a usable prime**: `F² → Γ_q`, `q = |𝓞 F ⧸ 𝔭| ≡ 3 (mod 4)`. `Arith.exists_placeHom` at no
transcendental, without the detour through `pureTranscendental`. -/
theorem nonempty_hom_unitQuadrance (F : Subfield ℝ) [NumberField F] {𝔭 : Ideal (𝓞 F)} (h𝔭 : IsUsablePrime 𝔭) :
    Nonempty ((unitDistance ℂ).induce (planeOver F) →g unitQuadrance (𝓞 F ⧸ 𝔭)) := by
  haveI : 𝔭.IsMaximal := h𝔭.1
  obtain ⟨V, φ, hφ⟩ := placeHom_base F h𝔭
  obtain ⟨h, -⟩ := exists_hom_of_isPlaceHom hφ
  exact ⟨h⟩

/-- The same into `finitePlane p = UD(𝔽_p, 2)` when the residue field has prime order `p`. -/
theorem nonempty_hom_finitePlane (F : Subfield ℝ) [NumberField F] {𝔭 : Ideal (𝓞 F)} (h𝔭 : IsUsablePrime 𝔭) {p : ℕ}
    (hp : p.Prime) (hcard : Nat.card (𝓞 F ⧸ 𝔭) = p) :
    Nonempty ((unitDistance ℂ).induce (planeOver F) →g finitePlane p) := by
  obtain ⟨h⟩ := nonempty_hom_unitQuadrance F h𝔭
  obtain ⟨e⟩ := nonempty_ringEquiv_zmod_of_card hp hcard
  haveI : Fact p.Prime := ⟨hp⟩
  exact ⟨(unitQuadrance.map e.toRingHom).comp h⟩

/-- **NF1-S1A, first clause**: `χ(F²) ≤ χ(Γ_q)` at a usable prime with residue field `𝔽_q`. -/
theorem chromaticNumber_planeOver_le_unitQuadrance (F : Subfield ℝ) [NumberField F] {𝔭 : Ideal (𝓞 F)}
    (h𝔭 : IsUsablePrime 𝔭) :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ≤ (unitQuadrance (𝓞 F ⧸ 𝔭)).chromaticNumber :=
  let ⟨h⟩ := nonempty_hom_unitQuadrance F h𝔭
  chromaticNumber_mono_of_hom h

/-- **NF1-S1A, second clause**: `χ(F²) ≤ χ(UD(𝔽_p, 2))` at a usable prime whose residue field has prime order `p`. -/
theorem chromaticNumber_planeOver_le_finitePlane (F : Subfield ℝ) [NumberField F] {𝔭 : Ideal (𝓞 F)}
    (h𝔭 : IsUsablePrime 𝔭) {p : ℕ} (hp : p.Prime) (hcard : Nat.card (𝓞 F ⧸ 𝔭) = p) :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ≤ (finitePlane p).chromaticNumber :=
  let ⟨h⟩ := nonempty_hom_finitePlane F h𝔭 hp hcard
  chromaticNumber_mono_of_hom h

/-- The form the instances call: a `k`-colouring of `UD(𝔽_p, 2)` pulls back to the plane over `F`. -/
theorem colorable_planeOver_of_finitePlane (F : Subfield ℝ) [NumberField F] {𝔭 : Ideal (𝓞 F)} (h𝔭 : IsUsablePrime 𝔭)
    {p : ℕ} (hp : p.Prime) (hcard : Nat.card (𝓞 F ⧸ 𝔭) = p) {k : ℕ} (hk : (finitePlane p).Colorable k) :
    ((unitDistance ℂ).induce (planeOver F)).Colorable k :=
  let ⟨h⟩ := nonempty_hom_finitePlane F h𝔭 hp hcard
  hk.of_hom h

/-! ## NF1-S1B: at a stable prime of `F(i)` -/

section Stable

variable {F : Subfield ℝ} [NumberField F]

/-- A stable prime as a height-one prime of `𝓞 (F(i))`: maximal, and not `⊥` because `𝓞 (F(i))` is not a field. -/
def _root_.HadwigerNelson.SpectralChain.StablePrime.heightOne (P : StablePrime F) : HeightOneSpectrum (𝓞 (fieldI F)) where
  asIdeal := P.P
  isPrime := P.isMaximal.isPrime
  ne_bot := Ring.ne_bot_of_isMaximal_of_not_isField P.isMaximal (RingOfIntegers.not_isField (fieldI F))

@[simp] theorem heightOne_asIdeal (P : StablePrime F) : P.heightOne.asIdeal = P.P := rfl

/-- **`𝓞_P`**, the localization of `𝓞 (F(i))` at a stable prime, as a valuation subring of `F(i)`: Mathlib's
`valuationSubringAtPrime`. -/
noncomputable abbrev _root_.HadwigerNelson.SpectralChain.StablePrime.localRing (P : StablePrime F) : ValuationSubring (fieldI F) :=
  HeightOneSpectrum.valuationSubringAtPrime (fieldI F) P.heightOne

/-- Its elements are the `a / s` with `a, s ∈ 𝓞 (F(i))`, `s ∉ P`. -/
theorem mem_localRing (P : StablePrime F) {x : fieldI F} :
    x ∈ P.localRing ↔ ∃ a s : 𝓞 (fieldI F), s ∉ P.P ∧ x = (a : fieldI F) / (s : fieldI F) := by
  sorry

omit [NumberField F] in
/-- Conjugation on `𝓞 (F(i))` is conjugation on `F(i)`. -/
theorem coe_conjO (a : 𝓞 (fieldI F)) : ((conjO F a : 𝓞 (fieldI F)) : fieldI F) = conjOn (fieldI_conj F) (a : fieldI F) :=
  rfl

omit [NumberField F] in
/-- Conjugation on `𝓞 (F(i))` is an involution. -/
theorem conjO_conjO (a : 𝓞 (fieldI F)) : conjO F (conjO F a) = a :=
  RingOfIntegers.ext (conjOn_conjOn (fieldI_conj F) _)

omit [NumberField F] in
/-- A stable prime holds `ā` exactly when it holds `a`. -/
theorem conjO_mem_iff (P : StablePrime F) {a : 𝓞 (fieldI F)} : conjO F a ∈ P.P ↔ a ∈ P.P := by
  conv_rhs => rw [← P.comap_conj]
  rfl

/-- **`𝓞_P` is conjugation-stable** (`a / s ↦ ā / s̄`, and `s̄ ∉ P`). -/
theorem conj_mem_localRing (P : StablePrime F) : ∀ z ∈ P.localRing, conjOn (fieldI_conj F) z ∈ P.localRing := by
  sorry

/-- **Every unit vector of `F²` lies in `𝓞_P`**: `u·ū = 1` and `𝓞_P` is a conjugation-stable valuation subring
(`normOne_subset_valuationSubring`, Theorem A's integrality step). -/
theorem mem_localRing_of_mul_conj_eq_one (P : StablePrime F) {u : fieldI F} (hu : u * conjOn (fieldI_conj F) u = 1) :
    u ∈ P.localRing :=
  normOne_subset_valuationSubring (P.localRing) (conj_mem_localRing P) (conjOn_conjOn (fieldI_conj F)) hu

/-- An element of `𝓞 (F(i))` outside `P` is a unit modulo `P^m` (`Ideal.IsMaximal.exists_inv_pow`). -/
theorem isUnit_mk_pow (P : StablePrime F) (m : ℕ) (y : P.heightOne.asIdeal.primeCompl) :
    IsUnit (Ideal.Quotient.mk (P.P ^ m) (y : 𝓞 (fieldI F))) := by
  sorry

/-- **The residue map at level `m`**, `𝓞_P → 𝓞 ⧸ P^m`: the extension of the quotient map to the localization. -/
noncomputable def _root_.HadwigerNelson.SpectralChain.StablePrime.residue (P : StablePrime F) (m : ℕ) : P.localRing →+* 𝓞 (fieldI F) ⧸ P.P ^ m :=
  IsLocalization.lift (M := P.heightOne.asIdeal.primeCompl) (g := Ideal.Quotient.mk (P.P ^ m)) (isUnit_mk_pow P m)

/-- On `𝓞 (F(i))` the residue map is the quotient map. -/
theorem residue_algebraMap (P : StablePrime F) (m : ℕ) (a : 𝓞 (fieldI F)) :
    P.residue m (algebraMap (𝓞 (fieldI F)) (P.localRing) a) = Ideal.Quotient.mk (P.P ^ m) a :=
  IsLocalization.lift_eq _ a

/-- `res(a / s) · s̄ = ā`: the residue map on a fraction. -/
theorem residue_div (P : StablePrime F) (m : ℕ) (a s : 𝓞 (fieldI F)) (hs : s ∉ P.P) :
    P.residue m ⟨(a : fieldI F) / (s : fieldI F), (mem_localRing P).2 ⟨a, s, hs, rfl⟩⟩ * Ideal.Quotient.mk (P.P ^ m) s =
      Ideal.Quotient.mk (P.P ^ m) a := by
  sorry

/-- **The residue map commutes with conjugation**: `res(z̄) = (res z)‾`, the bar on the right being the involution
`levelTarget` is built on. -/
theorem residue_conj (P : StablePrime F) (m : ℕ) (z : P.localRing) :
    P.residue m ⟨conjOn (fieldI_conj F) z, conj_mem_localRing P z z.2⟩ =
      Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) (P.residue m z) := by
  sorry

/-- An integer of `F(i)` is a non-unit of `𝓞_P` exactly when it lies in `P`. -/
theorem coe_mem_nonunits_localRing_iff (P : StablePrime F) (a : 𝓞 (fieldI F)) :
    (a : fieldI F) ∈ (P.localRing).nonunits ↔ a ∈ P.P := by
  sorry

/-- `𝓞_P` is not all of `F(i)`. -/
theorem localRing_ne_top (P : StablePrime F) : P.localRing ≠ ⊤ := by
  sorry

/-- **NF1-S1B, the homomorphism, at every level `m ≥ 1`**: the unit-distance graph on `F²` maps to
`levelTarget P m = Cay(𝓞 ⧸ P^m, {x : x·x̄ = 1})`, and on each coset of `𝓞_P` the map is the residue map: for `x, y ∈ F²` with
`x − y ∈ 𝓞_P`, `h x − h y = res(x − y)`. (A unit edge's difference `u` has `u·ū = 1`, so `u ∈ 𝓞_P` and
`res(u)·res(u)‾ = 1`; `res(u) ≠ 0` because `𝓞 ⧸ P^m` is not the zero ring for `m ≥ 1`.) At `m = 0` the target is one vertex
with no edge and there is no homomorphism. -/
theorem exists_hom_levelTarget (P : StablePrime F) {m : ℕ} (hm : 1 ≤ m) :
    ∃ h : (unitDistance ℂ).induce (planeOver F) →g levelTarget P m,
      ∀ (x y : planeOver F) (hd : (⟨x, x.2⟩ - ⟨y, y.2⟩ : fieldI F) ∈ P.localRing), h x - h y = P.residue m ⟨_, hd⟩ := by
  sorry

/-- **NF1-S1B, first clause, as claimed**: a graph homomorphism from the unit-distance graph on `F²` into the level-one
target at a stable prime. -/
theorem nonempty_hom_levelTarget_one (P : StablePrime F) :
    Nonempty ((unitDistance ℂ).induce (planeOver F) →g levelTarget P 1) :=
  let ⟨h, _⟩ := exists_hom_levelTarget P le_rfl
  ⟨h⟩

/-- `χ(F²) ≤ χ(levelTarget P m)` at every stable prime and every level `m ≥ 1`. -/
theorem chromaticNumber_planeOver_le_levelTarget (P : StablePrime F) {m : ℕ} (hm : 1 ≤ m) :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ≤ (levelTarget P m).chromaticNumber :=
  let ⟨h, _⟩ := exists_hom_levelTarget P hm
  chromaticNumber_mono_of_hom h

variable (F) in
/-- **NF1-S1B, second clause — the upper half**: `χ(F²) ≤ L(F)` for every real number field. (If `F(i)` had no stable
prime the right side would be `⊤`.) -/
theorem chromaticNumber_planeOver_le_localBound :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ≤ localBound F :=
  le_iInf fun P => chromaticNumber_planeOver_le_levelTarget P le_rfl

/-- **`SpectralChain.chromaticNumber_eq_localBound` with its hypothesis `hUpper` discharged**: `χ(F²) = L(F)` for `L(F) ≤ 5`
at every totally real number field, given the headline's other inputs (each a named hypothesis there, unchanged here). -/
theorem chromaticNumber_eq_localBound_of_chain [NumberField.IsTotallyReal F]
    (hBH : BochnerHerglotz (unitRing F)) (hL1 : InvariantMeasureOnClosed F) (I : Interface F) (hCount : I.Count)
    (hAP : I.APlusOfR88) (hRU : I.RU) (hMR : TCA F → I.PE2 ∧ I.EFPlus) (hCLS : 5 ≤ localBound F → TCA F)
    (hRow99 : localBound F ≤ 4 → localBound F ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber)
    (hL : localBound F ≤ 5) :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber = localBound F :=
  SpectralChain.chromaticNumber_eq_localBound hBH hL1 I hCount hAP hRU hMR hCLS hRow99
    (chromaticNumber_planeOver_le_localBound F) hL

omit [NumberField F] in
/-- A stable prime modulo which conjugation is the identity holds `2`: `ī − i = −2i` and `i` is a unit. -/
theorem two_mem_of_conj_trivial (P : StablePrime F) (hram : ∀ x : 𝓞 (fieldI F), conjO F x - x ∈ P.P) :
    (2 : 𝓞 (fieldI F)) ∈ P.P := by
  sorry

/-- **Two colours at a ramified stable prime** (`LEDGER.md` row 63's two-colour theorem, at a real number field): if
conjugation is the identity modulo a stable prime `P` of `F(i)` — `P` is ramified over `F`, and then dyadic
(`two_mem_of_conj_trivial`) — the plane over `F` is two-colourable. (`colorable_two_unitDistance_induce_of_valuationSubring`
at `𝓞_P` with the residue map into the field `𝓞 ⧸ P` of characteristic 2, on which conjugation acts trivially.) -/
theorem colorable_two_planeOver_of_ramified (P : StablePrime F) (hram : ∀ x : 𝓞 (fieldI F), conjO F x - x ∈ P.P) :
    ((unitDistance ℂ).induce (planeOver F)).Colorable 2 := by
  sorry

/-! ### The converse half (row 105's reading) -/

/-- **NF1-S1B, converse half**: a conjugation-stable valuation subring of `F(i)` other than `F(i)` is the localization at a
stable prime. (Its centre on `𝓞 (F(i))` is a nonzero prime `P`, fixed by conjugation; `𝓞_P ≤ A`, and a discrete valuation
ring is a maximal proper subring of its fraction field: `ValuationSubring.eq_of_le_of_ne_top`.) -/
theorem exists_stablePrime_of_valuationSubring (A : ValuationSubring (fieldI F)) (hA : A ≠ ⊤)
    (hσ : ∀ z ∈ A, conjOn (fieldI_conj F) z ∈ A) : ∃ P : StablePrime F, P.localRing = A := by
  sorry

variable (F) in
/-- **Row 105 over the stable primes**: for a real number field `F` and `n ≠ 0`, `1/n` lies in the ring `ℤ[U_F]` generated
by the unit vectors of `F²` iff no stable prime of `F(i)` holds `n`. (`UnitRing.inv_natCast_mem_unitRingOver_iff` with the
conjugation-stable valuation subrings read as the stable primes.) -/
theorem inv_natCast_mem_unitRingOver_iff_forall_stablePrime {n : ℕ} (hn : n ≠ 0) :
    (n : ℂ)⁻¹ ∈ UnitRing.unitRingOver F ↔ ∀ P : StablePrime F, (n : 𝓞 (fieldI F)) ∉ P.P := by
  sorry

end Stable

end HadwigerNelson.UpperHalf
