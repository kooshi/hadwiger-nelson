import Proofs.HadwigerNelson.Rigidity.CountTorus
import Proofs.HadwigerNelson.Rigidity.TateModel
import Proofs.HadwigerNelson.Rigidity.ClassRatio
import Proofs.HadwigerNelson.Rigidity.FiniteZhang

/-!
# The count's finite levels: residues of the unit vectors, and the ratio of every level (FS-131, job FS131-K12A; module M12, block R; skeleton)

**Read aloud, against the derivation and the claim list.** `[S9]` (NF2-LEAF-07): "at a stable prime the image of `U` in
`𝓞/P^m` is every norm-one element" — the caveat of `SpectralChain`: "`levelTarget` uses the norm-one elements of `𝓞/P^m`;
the derivation's `S_m` is the image of `U`. They agree by smoothness of the norm-one torus — [hand], not in the kernel".
Here they agree **by Hilbert 90 modulo `P^m`, with no smoothness**: for `s` with `s s̄ = 1`, `z := w + s w̄` satisfies
`z ≡ s z̄ (mod P^m)` for every `w`, and `z` is a unit for `w = 1` or for a `w` that conjugation moves modulo `P` — which
exists exactly when `P` is not ramified; then `u = z/z̄` is a unit vector with residue `s`. Ramified stable primes are
excluded by `TCA` itself (`Rigidity.noRamifiedStableDyadic_of_tca`).

* `resR P m` — the residue map of `R = ℤ[U]` at `P^m` (`R ⊆ O′ ⊆ P.localRing`, `Rigidity.unitRing_le_stableIntegers`).
* `normOneQ P m` — the connection set of `levelTarget P m`; `isIndepSet_levelTarget_iff` reads the target's independence in
  the connection set, and `ratioLe_normOneQ` turns `RatioAtMost P c` into `RatioLe (normOneQ P m) c`.
* `exists_normOneL_residue` — `[S9]` at one unramified stable prime; `exists_normOneL_residues` — jointly at finitely many
  (the Chinese remainder theorem in `𝓞 L`, `IsDedekindDomain.exists_forall_sub_mem_ideal`).
* `exists_mem_nsmul_of_resR_eq_zero` — **Lemma C (d)** (item 791's question (4)): residues zero at finitely many stable
  primes put an element of `R` in `N·R`. From `c·O′ ⊆ R` (`Rigidity.exists_mul_stableIntegers_le`), with no scope: the
  count reads neither `R = O′` nor `NoRamifiedStableDyadic`.
* `level F k` — the stable primes of absolute norm at most `k`; `Lev F k = ∏_{P ∈ level k} 𝓞/P^k`, `levR F k` the joint
  residue map, `normOneLev F k` the product connection set.
* `ratioLe_levR_range` — **every level has ratio at most `c`**: `[S9]` jointly makes the image of `U` the whole product
  connection set, a subgroup holding it has the group's ratio (`ratioLe_subgroup`), and the product has the factors' ratio
  (`ratioLe_pi`, Zhang).

**Models.** `F = ℚ`: its one dyadic stable prime `(1 + i)` is ramified (the hypotheses `¬ IsRamified P` fail there, as they
must: at a ramified stable prime the norm-one residues are `{1}` at level one); every inert `p ≡ 3 (mod 4)` is a stable,
unramified prime of `ℚ(i)`, where `s = −1` takes `w = i`.
-/

namespace HadwigerNelson.Rigidity.Counting

open SpectralChain NumberField

noncomputable section

variable (F : Subfield ℝ) [NumberField F]

variable {F}

theorem ofUnitRing_mem_localRing (P : StablePrime F) (r : unitRing F) : ofUnitRing F r ∈ P.localRing := by
  sorry

/-- `R → P.localRing` (`R ⊆ L` is lane T's `ofUnitRing`). -/
def toLocal (P : StablePrime F) : unitRing F →+* P.localRing :=
  RingHom.codRestrict (ofUnitRing F) P.localRing fun r => ofUnitRing_mem_localRing P r

/-- **The residue map of `R` at `P^m`.** -/
def resR (P : StablePrime F) (m : ℕ) : unitRing F →+* 𝓞 (fieldI F) ⧸ P.P ^ m := (P.residue m).comp (toLocal P)

/-- **The connection set of the level-`m` target**: the norm-one elements of `𝓞/P^m`. -/
def normOneQ (P : StablePrime F) (m : ℕ) : Set (𝓞 (fieldI F) ⧸ P.P ^ m) :=
  {x | x * Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) x = 1}

theorem isIndepSet_levelTarget_iff (P : StablePrime F) {m : ℕ} (hm : 1 ≤ m) (s : Finset (𝓞 (fieldI F) ⧸ P.P ^ m)) :
    (levelTarget P m).IsIndepSet (s : Set _) ↔ SIndep (normOneQ P m) s := by
  sorry

theorem neg_mem_normOneQ (P : StablePrime F) (m : ℕ) {x : 𝓞 (fieldI F) ⧸ P.P ^ m} (hx : x ∈ normOneQ P m) :
    -x ∈ normOneQ P m := by
  sorry

/-- The residue rings of a stable prime are finite (`Ideal.finiteQuotientOfFreeOfNeBot`: `P^m ≠ ⊥`). A `Prop`-valued
class, so the instance makes no diamond. -/
instance finite_quot (P : StablePrime F) (m : ℕ) : Finite (𝓞 (fieldI F) ⧸ P.P ^ m) := by
  sorry

theorem ratioLe_normOneQ (P : StablePrime F) {c : ℝ} (h : RatioAtMost P c) {m : ℕ} (hm : 1 ≤ m) :
    RatioLe (normOneQ P m) c := by
  sorry

/-- **`[S9]` at one unramified stable prime** (Hilbert 90 modulo `P^m`). -/
theorem exists_normOneL_residue (P : StablePrime F) (hP : ¬ IsRamified P) (m : ℕ) {s : 𝓞 (fieldI F) ⧸ P.P ^ m}
    (hs : s ∈ normOneQ P m) :
    ∃ (x : fieldI F) (hx : x ∈ normOneL F), P.residue m ⟨x, UpperHalf.mem_localRing_of_mul_conj_eq_one P hx⟩ = s := by
  sorry

/-- **`[S9]` jointly at finitely many unramified stable primes.** -/
theorem exists_normOneL_residues (Φ : Finset (StablePrime F)) (hΦ : ∀ P ∈ Φ, ¬ IsRamified P) (m : ℕ)
    (s : ∀ P ∈ Φ, 𝓞 (fieldI F) ⧸ P.P ^ m) (hs : ∀ P hP, s P hP ∈ normOneQ P m) :
    ∃ (x : fieldI F) (hx : x ∈ normOneL F), ∀ P hP,
      P.residue m ⟨x, UpperHalf.mem_localRing_of_mul_conj_eq_one P hx⟩ = s P hP := by
  sorry

/-- A norm-one element of `L` is (the image of) an element of `R`. -/
theorem exists_unitRing_of_normOneL {x : fieldI F} (hx : x ∈ normOneL F) :
    ∃ r : unitRing F, ofUnitRing F r = x ∧ ((r : ℂ) ∈ unitVectors F) := by
  sorry

/-- **Lemma C (d)**, from `c·O′ ⊆ R`: residues zero at finitely many stable primes put an element of `R` in `N·R`. -/
theorem exists_mem_nsmul_of_resR_eq_zero {N : ℕ} (hN : N ≠ 0) :
    ∃ (Φ : Finset (StablePrime F)) (m : ℕ), ∀ r : unitRing F, (∀ P ∈ Φ, resR P m r = 0) → ∃ y : unitRing F, r = N • y := by
  sorry

/-- A residue zero at `P^k` is zero at every coarser power. -/
theorem resR_eq_zero_of_le (P : StablePrime F) {m k : ℕ} (hmk : m ≤ k) {r : unitRing F} (hr : resR P k r = 0) :
    resR P m r = 0 := by
  sorry

theorem ratio_unramified_of_tca (h : TCA F) (P : StablePrime F) : ¬ IsRamified P :=
  (noRamifiedStableDyadic_iff F).mp (noRamifiedStableDyadic_of_tca F h) P

variable (F)

omit [NumberField F] in
theorem stablePrime_injective : Function.Injective (fun P : StablePrime F => P.P) := by
  rintro ⟨P, h1, h2⟩ ⟨Q, h3, h4⟩ (h : P = Q)
  subst h
  rfl

/-- **The stable primes of level `k`**: absolute norm at most `k`. -/
def level (k : ℕ) : Finset (StablePrime F) :=
  (Set.Finite.preimage (stablePrime_injective F).injOn
    (Ideal.finite_setOf_absNorm_le (S := 𝓞 (fieldI F)) k)).toFinset

theorem mem_level {k : ℕ} {P : StablePrime F} : P ∈ level F k ↔ Ideal.absNorm P.P ≤ k := by
  sorry

/-- **The level-`k` residue ring** `∏_{P ∈ level k} 𝓞/P^k`. A `def`, not an `abbrev`: the completion puts the discrete
topology on it (`Rigidity/CountCompletion`), and an instance on this synonym speaks only of the count's levels — an
instance on Mathlib's `𝓞 L ⧸ I` (which carries none at the pin) would be speech into every future search. -/
def Lev (k : ℕ) : Type _ := ∀ P : level F k, 𝓞 (fieldI F) ⧸ P.1.P ^ k

instance (k : ℕ) : CommRing (Lev F k) := inferInstanceAs (CommRing (∀ P : level F k, 𝓞 (fieldI F) ⧸ P.1.P ^ k))

instance (k : ℕ) : Finite (Lev F k) := inferInstanceAs (Finite (∀ P : level F k, 𝓞 (fieldI F) ⧸ P.1.P ^ k))

/-- **The joint residue map of level `k`.** -/
def levR (k : ℕ) : unitRing F →+* Lev F k := RingHom.pi fun P : level F k => resR P.1 k

/-- **The product connection set of level `k`.** -/
def normOneLev (k : ℕ) : Set (Lev F k) := {d | ∀ P : level F k, d P ∈ normOneQ P.1 k}

/-- **Lemma C (d) in level form** — what the completion reads: some level's residues zero put an element of `R` in
`N·R` (`exists_mem_nsmul_of_resR_eq_zero`, then `k` past `m` and past every norm in `Φ`). -/
theorem exists_level_mem_nsmul {N : ℕ} (hN : N ≠ 0) :
    ∃ k : ℕ, ∀ r : unitRing F, levR F k r = 0 → ∃ y : unitRing F, r = N • y := by
  sorry

/-- **`[S9]` at level `k`**: the unit vectors map onto the product connection set. -/
theorem image_levR_unitVectors (h : TCA F) (k : ℕ) :
    levR F k '' {r | (r : ℂ) ∈ unitVectors F} = normOneLev F k := by
  sorry

/-- **Every level has ratio at most `c`.** -/
theorem ratioLe_levR_range (h : TCA F) {c : ℝ} (hc0 : 0 ≤ c) (hc : ∀ P : StablePrime F, RatioAtMost P c) {k : ℕ}
    (hk : 1 ≤ k) :
    RatioLe {d : (levR F k).range.toAddSubgroup | (d : Lev F k) ∈ normOneLev F k} c := by
  sorry

/-! ## Spec examples -/

example (P : StablePrime F) (m : ℕ) (x : 𝓞 (fieldI F) ⧸ P.P ^ m) :
    x ∈ normOneQ P m ↔ x * Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) x = 1 := Iff.rfl

end

end HadwigerNelson.Rigidity.Counting
