import Proofs.HadwigerNelson.Arith.WeilKloosterman
import Proofs.HadwigerNelson.Rigidity.ChainAtTA
import Proofs.HadwigerNelson.Arith.GapSeven
import Proofs.HadwigerNelson.Arith.CircleCos
import Proofs.HadwigerNelson.Arith.DyadicCerts
import Proofs.HadwigerNelson.Rigidity.CertLink
import Proofs.HadwigerNelson.Arith.FibreCert19Bound

/-!
# CLS: a local bound of at least five gives T-C(A) at `S = ∅`; the uniform tail (FS-131, job FS131-KR1; module M13; composed by FS131-ICM1 over six named private leaves)

**Read aloud, against the informal claim.** `RatioAtMost P c` says that at the stable prime `P` every independent set of
every level's residue target `levelTarget P m` (`m ≥ 1`) holds at most the fraction `c` of `𝓞 ⧸ P^m`; T-C(A) at `S = ∅`,
the library's `SpectralChain.TCA`, is "every stable prime has some `c < 1/4`" (`tca_iff`, by `Iff.rfl`). Then:

* `ratioAtMost_of_five_le_chromaticNumber` — **a stable prime whose level-one target needs five colours has an all-levels
  ratio below `1/4`** (FS100-CLS, -DLP, -G27; X26B-L1; EN1-UQ4): the residue sizes the hypothesis leaves are odd inert
  `q ∉ {3, 7}` and dyadic inert `Q ≥ 64` (a stable prime ramified in `F(i)/F` is dyadic and its level-one target is
  two-colourable, `colorable_two_levelTarget_one_of_isRamified`); Lemma P carries level one to every level; level one by Weil
  for `q ≥ 37` (the declared import `kloosterman_bound`), exact spectra at 23, 27, 31 and 64, `Floor128` at 128, the
  fourth-moment count EN1-UQ4 for `Q ≥ 256`, and FS-66's fibre-share bound with its certificates at 11 and 19, read
  through the certificate link `Rigidity/CertLink` (FS131-IKL1; joined by FS131-LCH1).
* `tca_of_five_le_localBound` — **CLS**, the headline's `hCLS`: composed here from the per-prime statement.
* `exists_uniform_tail` — **one constant for all but finitely many stable primes**: every stable prime of absolute norm
  above some `B` has all-levels ratio at most one `c < 1/4` (Weil and Lemma P; R88-J28V-3's tail). And `tca_uniform`: T-C(A)
  with **one** constant for every stable prime — the form the count reads (module M12: the product of the stable factors has
  ratio `sup_P c_P`, which `TCA F` alone does not bound below `1/4`). Placed here, upstream of both M12 and M13, by the
  coordinator's ruling of 2026-10-14 on FS131-KR1's notice.

**Models.** `5 ≤ localBound F` holds at `ℚ(√47)` (module M15, `plans/FS131-KR1-chain-map.md` § 2.7) and at the standing
field (`StandingFive.le_localBound`, at seven); it fails at `ℚ`, whose prime `(1 + i)` is ramified. `RatioAtMost P 1` holds
at every `P` (an independent set is a subset), and `RatioAtMost P c` fails for `c < 1/2` at a ramified stable prime.
-/

namespace HadwigerNelson.Rigidity

open SpectralChain NumberField

noncomputable section

variable {F : Subfield ℝ}

/-- **The all-levels ratio at a stable prime is at most `c`.** -/
def RatioAtMost (P : StablePrime F) (c : ℝ) : Prop :=
  ∀ m : ℕ, 1 ≤ m → ∀ s : Finset (𝓞 (fieldI F) ⧸ P.P ^ m),
    (levelTarget P m).IsIndepSet (s : Set _) → (s.card : ℝ) ≤ c * Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m)

variable (F) in
/-- T-C(A) at `S = ∅`, read through `RatioAtMost`. -/
theorem tca_iff : TCA F ↔ ∀ P : StablePrime F, ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := Iff.rfl

-- FS131-ICM1: the road, as private helpers. `levelSet P m` is the connection set of `levelTarget P m`; `CharBound P m κ`
-- says every non-trivial additive character of `𝓞 ⧸ P^m` sums to real part at least `−κ·|S_m|` over it. The ratio bound
-- (`RatioBound.card_mul_le_of_indep`) turns a bound at every level into `RatioAtMost P (κ/(1 + κ))`; Weil gives level one
-- at an odd stable prime (`κ = 2√Q/(Q + 1)`, `|𝓞 ⧸ P| = Q²`); Lemma P carries any level-one bound `κ ≥ 2/(Q + 1)` to every
-- level (`charBound_of_charBound_oneT`, at `θ = i` when `2 ∉ P`).

-- FS131-ICM1: a larger constant bounds the ratio as well.
private theorem ratioAtMost_mono {P : StablePrime F} {c c' : ℝ} (h : RatioAtMost P c) (hc : c ≤ c') :
    RatioAtMost P c' := fun m hm s hs =>
  (h m hm s hs).trans (mul_le_mul_of_nonneg_right hc (Nat.cast_nonneg _))

-- FS131-ICM1: the residue rings of a stable prime are finite.
private theorem finite_quot_pow [NumberField F] (P : StablePrime F) (m : ℕ) : Finite (𝓞 (fieldI F) ⧸ P.P ^ m) :=
  Ideal.finiteQuotientOfFreeOfNeBot _ (pow_ne_zero m P.heightOne.ne_bot)

-- FS131-ICM1: a stable prime is determined by its ideal.
private theorem stablePrime_ext {P P' : StablePrime F} (h : P.P = P'.P) : P = P' := by
  cases P
  cases P'
  cases h
  rfl

-- FS131-ICM1: finitely many stable primes have norm at most `B`.
private theorem finite_stablePrime_absNorm_le [NumberField F] (B : ℕ) :
    {P : StablePrime F | Ideal.absNorm P.P ≤ B}.Finite := by
  refine Set.Finite.of_finite_image ((Ideal.finite_setOf_absNorm_le (S := 𝓞 (fieldI F)) B).subset ?_)
    fun P _ P' _ h => stablePrime_ext h
  rintro _ ⟨P, hP, rfl⟩
  exact hP

/-- The connection set of the level-`m` target. -/
private def levelSet (P : StablePrime F) (m : ℕ) : Set (𝓞 (fieldI F) ⧸ P.P ^ m) :=
  {x | x * Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) x = 1}

/-- **The character bound at level `m`**: every non-trivial additive character sums to real part at least `−κ·|S_m|`. -/
private def CharBound (P : StablePrime F) (m : ℕ) (κ : ℝ) : Prop :=
  ∀ (hfin : (levelSet P m).Finite) (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ m) ℂ), ψ ≠ 1 →
    -(κ * hfin.toFinset.card) ≤ (∑ s ∈ hfin.toFinset, ψ s).re

-- FS131-ICM1: the ratio bound at every level (Hoffman, `RatioBound.card_mul_le_of_indep`).
/-- **Hoffman at every level** (`RatioBound.card_mul_le_of_indep`): if at every level `m ≥ 1` every non-trivial additive
character of `𝓞 ⧸ P^m` sums over the norm-one elements to real part at least `−κ` times their number (`CharBound P m κ`),
then every independent set of every level's target holds at most `κ/(1 + κ)` of it. Public since FS131-IFR1 (the
coordinator's ruling, inventory item 1021), for the density form of the collapse (`Collapse.ratioAtMost_of_thickAt`). -/
theorem ratioAtMost_of_charBound [NumberField F] (P : StablePrime F) {κ : ℝ} (hκ : 0 ≤ κ)
    (h : ∀ m : ℕ, 1 ≤ m → CharBound P m κ) : RatioAtMost P (κ / (1 + κ)) := by
  classical
  intro m hm s hs
  haveI := finite_quot_pow P m
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ m) := Fintype.ofFinite _
  have hfin : (levelSet P m).Finite := Set.toFinite _
  set S := hfin.toFinset with hSdef
  -- the residue ring at `m ≥ 1` is not zero
  have hne : (1 : 𝓞 (fieldI F) ⧸ P.P ^ m) ≠ 0 := by
    intro h1
    have hmem : (1 : 𝓞 (fieldI F)) ∈ P.P ^ m := by
      rw [← Ideal.Quotient.eq_zero_iff_mem, map_one]
      exact h1
    exact P.isMaximal.ne_top ((Ideal.eq_top_iff_one _).2 (Ideal.pow_le_self (by omega) hmem))
  have hone : (1 : 𝓞 (fieldI F) ⧸ P.P ^ m) ∈ S := by
    rw [hSdef, Set.Finite.mem_toFinset]
    show 1 * Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) 1 = 1
    rw [map_one, one_mul]
  have hSpos : (0 : ℝ) < S.card := by exact_mod_cast Finset.card_pos.2 ⟨1, hone⟩
  have hI : ∀ x ∈ s, ∀ y ∈ s, x - y ∉ S := by
    intro x hx y hy hxy
    rw [hSdef, Set.Finite.mem_toFinset] at hxy
    have hxy' : (x - y) * Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) (x - y) = 1 := hxy
    have hneq : x ≠ y := by
      rintro rfl
      rw [sub_self, zero_mul] at hxy'
      exact hne hxy'.symm
    exact hs hx hy hneq ((SimpleGraph.fromRel_adj _ _ _).2 ⟨hneq, Or.inl hxy'⟩)
  have hkey := RatioBound.card_mul_le_of_indep S (mul_nonneg hκ hSpos.le) (h m hm hfin) s hI
  rw [Nat.card_eq_fintype_card]
  have h1κ : 0 < 1 + κ := by linarith
  rw [div_mul_eq_mul_div, le_div_iff₀ h1κ]
  have e : (s.card : ℝ) * (S.card + κ * S.card) = (s.card * (1 + κ)) * S.card := by ring
  have e2 : κ * S.card * (Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ m) : ℝ) =
      (κ * Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ m)) * S.card := by ring
  rw [e, e2] at hkey
  exact le_of_mul_le_mul_right hkey hSpos

-- FS131-ICM1: at an odd stable prime the residue field has `Q²` elements, `Q ≡ 3 (mod 4)`
-- (`StandingFive.card_fixed_of_involution` at the residue of `i`).
private theorem exists_card_sq [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) :
    ∃ Q : ℕ, Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2 ∧ Q % 4 = 3 := by
  haveI := P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P) := Ideal.Quotient.field P.P
  haveI : Finite (𝓞 (fieldI F) ⧸ P.P) := Ideal.finiteQuotientOfFreeOfNeBot _ P.heightOne.ne_bot
  let σ : (𝓞 (fieldI F) ⧸ P.P) →+* (𝓞 (fieldI F) ⧸ P.P) := Ideal.quotientMap P.P (conjO F) P.comap_conj.ge
  have hσmk : ∀ x, σ (Ideal.Quotient.mk P.P x) = Ideal.Quotient.mk P.P (conjO F x) := fun x => Ideal.quotientMap_mk
  have hσ : ∀ x, σ (σ x) = x := fun x => by
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
    rw [hσmk, hσmk, UpperHalf.conjO_conjO]
  obtain ⟨i, hi2, hci⟩ := UpperHalf.exists_I_integer (F := F)
  have h2k : (2 : 𝓞 (fieldI F) ⧸ P.P) ≠ 0 := by
    rw [← map_ofNat (Ideal.Quotient.mk P.P) 2, Ne, Ideal.Quotient.eq_zero_iff_mem]; exact h2
  obtain ⟨hcard, hmod⟩ := StandingFive.card_fixed_of_involution σ hσ (ι := Ideal.Quotient.mk P.P i)
    (by rw [← map_pow, hi2, map_neg, map_one]) (by rw [hσmk, hci, map_neg]) h2k
  exact ⟨_, hcard, hmod⟩

-- FS131-ICM1: no field has `15²` elements (a finite field has a prime-power size).
private theorem card_ne_fifteen_sq [NumberField F] (P : StablePrime F) : Nat.card (𝓞 (fieldI F) ⧸ P.P) ≠ 15 ^ 2 := by
  haveI := P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P) := Ideal.Quotient.field P.P
  haveI : Finite (𝓞 (fieldI F) ⧸ P.P) := Ideal.finiteQuotientOfFreeOfNeBot _ P.heightOne.ne_bot
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P) := Fintype.ofFinite _
  obtain ⟨p, hchar⟩ := CharP.exists (𝓞 (fieldI F) ⧸ P.P)
  obtain ⟨n, hp, hcard⟩ := FiniteField.card (𝓞 (fieldI F) ⧸ P.P) p
  rw [Nat.card_eq_fintype_card, hcard]
  intro h
  have h3 : 3 ∣ p ^ (n : ℕ) := by rw [h]; norm_num
  have hp3 : p = 3 := ((Nat.prime_dvd_prime_iff_eq Nat.prime_three hp).1 (Nat.prime_three.dvd_of_dvd_pow h3)).symm
  have h5 : 5 ∣ p ^ (n : ℕ) := by rw [h]; norm_num
  rw [hp3] at h5
  exact absurd (Nat.prime_five.dvd_of_dvd_pow h5) (by norm_num)

section LemmaPAlgebraT

open Finset

-- FS131-ICM3: Lemma P's algebra with no unit `2`: a finite ring with an involution `σ`, a `σ`-stable ideal `K` of square
-- zero, and an element `θ` with `θ − σθ` a unit (inverse `δ`). `Kn` is the trace-zero part `{w ∈ K : σw = −w}`. In the
-- odd case `θ = i` serves (`exists_conj_sub_notMem`; FS131-ICM2's `SqZeroInv`, folded onto this by FS131-ICM4); at an
-- unramified dyadic prime, any `θ` that conjugation moves off
-- the prime. `K = Kn ⊕ θ·Kn` (`card_Kn_sq`), and the norm-one lifts of a residue are a coset of `(σx₀)⁻¹·Kn`.
private structure SqZeroInvT (R : Type*) [CommRing R] where
  σ : R →+* R
  invol : ∀ x, σ (σ x) = x
  K : Ideal R
  sq : ∀ a ∈ K, ∀ b ∈ K, a * b = 0
  σK : ∀ a ∈ K, σ a ∈ K
  θ : R
  δ : R
  δ_mul : (θ - σ θ) * δ = 1

open Classical in
private noncomputable def SqZeroInvT.Kn {R : Type*} [CommRing R] [Fintype R] (D : SqZeroInvT R) : Finset R :=
  univ.filter fun w => w ∈ D.K ∧ D.σ w = -w

open Classical in
private noncomputable def SqZeroInvT.Kf {R : Type*} [CommRing R] [Fintype R] (D : SqZeroInvT R) : Finset R :=
  univ.filter fun w => w ∈ D.K

section SqZeroInvT

variable {R : Type*} [CommRing R] [Fintype R]

private theorem SqZeroInvT.mem_Kn (D : SqZeroInvT R) {w : R} : w ∈ D.Kn ↔ w ∈ D.K ∧ D.σ w = -w := by
  classical
  unfold SqZeroInvT.Kn
  simp

private theorem SqZeroInvT.mem_Kf (D : SqZeroInvT R) {w : R} : w ∈ D.Kf ↔ w ∈ D.K := by
  classical
  unfold SqZeroInvT.Kf
  simp

omit [Fintype R] in
/-- `σδ = −δ`: apply `σ` to `(θ − σθ)δ = 1`. -/
private theorem SqZeroInvT.σδ (D : SqZeroInvT R) : D.σ D.δ = -D.δ := by
  have h := congrArg D.σ D.δ_mul
  rw [map_mul, map_sub, D.invol, map_one] at h
  linear_combination (-D.σ D.δ) * D.δ_mul + (-D.δ) * h

/-- **`K = Kn ⊕ θ·Kn`**: `(a, b) ↦ a + θb`, inverse `f ↦ (f − θb, b)` with `b = δ(f + σf)`. -/
private theorem SqZeroInvT.card_Kn_sq (D : SqZeroInvT R) : D.Kn.card ^ 2 = D.Kf.card := by
  rw [pow_two, ← card_product]
  refine card_nbij' (fun p => p.1 + D.θ * p.2)
    (fun f => (f - D.θ * (D.δ * (f + D.σ f)), D.δ * (f + D.σ f))) ?_ ?_ ?_ ?_
  · rintro ⟨a, b⟩ hab
    rw [Finset.mem_coe, mem_product, D.mem_Kn, D.mem_Kn] at hab
    rw [Finset.mem_coe, D.mem_Kf]
    exact D.K.add_mem hab.1.1 (D.K.mul_mem_left _ hab.2.1)
  · intro f hf
    rw [Finset.mem_coe, D.mem_Kf] at hf
    rw [Finset.mem_coe, mem_product, D.mem_Kn, D.mem_Kn]
    have hσf := D.σK f hf
    have hb : D.δ * (f + D.σ f) ∈ D.K := D.K.mul_mem_left _ (D.K.add_mem hf hσf)
    have hσb : D.σ (D.δ * (f + D.σ f)) = -(D.δ * (f + D.σ f)) := by
      rw [map_mul, map_add, D.invol, D.σδ]; ring
    refine ⟨⟨D.K.sub_mem hf (D.K.mul_mem_left _ hb), ?_⟩, ⟨hb, hσb⟩⟩
    rw [map_sub, map_mul, hσb]
    linear_combination (-(f + D.σ f)) * D.δ_mul
  · rintro ⟨a, b⟩ hab
    rw [Finset.mem_coe, mem_product, D.mem_Kn, D.mem_Kn] at hab
    have hσ : D.σ (a + D.θ * b) = -a - D.σ D.θ * b := by rw [map_add, map_mul, hab.1.2, hab.2.2]; ring
    have hb : D.δ * (a + D.θ * b + D.σ (a + D.θ * b)) = b := by
      rw [hσ]; linear_combination b * D.δ_mul
    simp only [hb, Prod.mk.injEq, and_true]
    ring
  · intro f _
    show f - D.θ * (D.δ * (f + D.σ f)) + D.θ * (D.δ * (f + D.σ f)) = f
    ring

open Classical in
/-- **Hensel in the abstract, with no unit `2`**: the lifts `x₀ + e`, `e ∈ K`, of norm one are as many as `Kn`, whenever
`N(x₀) ≡ 1 (mod K)` — they are `e = z(w + f₀)`, `w ∈ Kn`, `z = (σx₀)⁻¹`, `f₀ = −θδd`, `d = N(x₀) − 1`. -/
private theorem SqZeroInvT.card_lift (D : SqZeroInvT R) {x₀ : R} (hx₀ : x₀ * D.σ x₀ - 1 ∈ D.K) :
    (D.Kf.filter fun e => (x₀ + e) * D.σ (x₀ + e) = 1).card = D.Kn.card := by
  obtain ⟨d, hd⟩ : ∃ d, x₀ * D.σ x₀ - 1 = d := ⟨_, rfl⟩
  rw [hd] at hx₀
  have hxy : x₀ * D.σ x₀ = 1 + d := by rw [← hd]; ring
  have hσd : D.σ d = d := by rw [← hd, map_sub, map_mul, D.invol, map_one]; ring
  have hdd : d * d = 0 := D.sq d hx₀ d hx₀
  have hyz : D.σ x₀ * (x₀ * (1 - d)) = 1 := by linear_combination (1 - d) * hxy - hdd
  have hf₀ : -(D.θ * D.δ * d) ∈ D.K := D.K.neg_mem (D.K.mul_mem_left _ hx₀)
  have hσf₀ : D.σ (-(D.θ * D.δ * d)) = D.σ D.θ * D.δ * d := by
    rw [map_neg, map_mul, map_mul, D.σδ, hσd]; ring
  symm
  refine card_nbij' (fun w => x₀ * (1 - d) * (w + -(D.θ * D.δ * d))) (fun e => D.σ x₀ * e - -(D.θ * D.δ * d))
    ?_ ?_ ?_ ?_
  · intro w hw
    rw [Finset.mem_coe, D.mem_Kn] at hw
    rw [Finset.mem_coe, Finset.mem_filter, D.mem_Kf]
    have heK : x₀ * (1 - d) * (w + -(D.θ * D.δ * d)) ∈ D.K :=
      D.K.mul_mem_left _ (D.K.add_mem hw.1 hf₀)
    refine ⟨heK, ?_⟩
    have hee := D.sq _ heK _ (D.σK _ heK)
    have heσ : x₀ * (1 - d) * (w + -(D.θ * D.δ * d)) * D.σ x₀ = w + -(D.θ * D.δ * d) := by
      linear_combination (w + -(D.θ * D.δ * d)) * hyz
    have hσe' : D.σ (x₀ * (1 - d) * (w + -(D.θ * D.δ * d))) =
        D.σ x₀ * (1 - d) * (-w + D.σ D.θ * D.δ * d) := by
      rw [map_mul, map_mul, map_sub, map_one, hσd, map_add, hw.2, hσf₀]
    have hσe : x₀ * D.σ (x₀ * (1 - d) * (w + -(D.θ * D.δ * d))) = -w + D.σ D.θ * D.δ * d := by
      rw [hσe']
      linear_combination (1 - d) * (-w + D.σ D.θ * D.δ * d) * hxy - (-w + D.σ D.θ * D.δ * d) * hdd
    rw [map_add]
    linear_combination hxy + hσe + heσ + hee - d * D.δ_mul
  · intro e he
    rw [Finset.mem_coe, Finset.mem_filter, D.mem_Kf] at he
    rw [Finset.mem_coe, D.mem_Kn]
    refine ⟨D.K.sub_mem (D.K.mul_mem_left _ he.1) hf₀, ?_⟩
    have hee : e * D.σ e = 0 := D.sq e he.1 _ (D.σK e he.1)
    have hN := he.2
    rw [map_add] at hN
    rw [map_sub, map_mul, D.invol, hσf₀]
    linear_combination hN - hxy - hee + d * D.δ_mul
  · intro w _
    show D.σ x₀ * (x₀ * (1 - d) * (w + -(D.θ * D.δ * d))) - -(D.θ * D.δ * d) = w
    linear_combination (w + -(D.θ * D.δ * d)) * hyz
  · intro e _
    show x₀ * (1 - d) * (D.σ x₀ * e - -(D.θ * D.δ * d) + -(D.θ * D.δ * d)) = e
    linear_combination e * hyz

private theorem SqZeroInvT.add_mem_Kn (D : SqZeroInvT R) {w w₁ : R} (hw : w ∈ D.Kn) (hw₁ : w₁ ∈ D.Kn) :
    w + w₁ ∈ D.Kn := by
  rw [D.mem_Kn] at hw hw₁ ⊢
  exact ⟨D.K.add_mem hw.1 hw₁.1, by rw [map_add, hw.2, hw₁.2]; ring⟩

private theorem SqZeroInvT.sub_mem_Kn (D : SqZeroInvT R) {w w₁ : R} (hw : w ∈ D.Kn) (hw₁ : w₁ ∈ D.Kn) :
    w - w₁ ∈ D.Kn := by
  rw [D.mem_Kn] at hw hw₁ ⊢
  exact ⟨D.K.sub_mem hw.1 hw₁.1, by rw [map_sub, hw.2, hw₁.2]; ring⟩

/-- A character's sum over `x·Kn` is `|Kn|` if it is trivial there and `0` otherwise. -/
private theorem SqZeroInvT.sum_Kn (D : SqZeroInvT R) (ψ : AddChar R ℂ) (x : R) [Decidable (∀ w ∈ D.Kn, ψ (x * w) = 1)] :
    ∑ w ∈ D.Kn, ψ (x * w) = if (∀ w ∈ D.Kn, ψ (x * w) = 1) then (D.Kn.card : ℂ) else 0 := by
  split_ifs with hg
  · rw [Finset.sum_congr rfl hg, sum_const, nsmul_eq_mul, mul_one]
  · push Not at hg
    obtain ⟨w₁, hw₁, hψ₁⟩ := hg
    have hshift : ∑ w ∈ D.Kn, ψ (x * w) = ψ (x * w₁) * ∑ w ∈ D.Kn, ψ (x * w) := by
      rw [mul_sum]
      refine sum_nbij' (fun w => w - w₁) (fun w => w + w₁) (fun w hw => D.sub_mem_Kn hw hw₁)
        (fun w hw => D.add_mem_Kn hw hw₁) (fun w _ => by ring) (fun w _ => by ring) ?_
      intro w _
      rw [← AddChar.map_add_eq_mul]
      congr 1
      ring
    have h0 : (1 - ψ (x * w₁)) * ∑ w ∈ D.Kn, ψ (x * w) = 0 := by linear_combination hshift
    rcases mul_eq_zero.1 h0 with h | h
    · exact absurd (sub_eq_zero.1 h).symm hψ₁
    · exact h

open Classical in
/-- **Averaging over `1 + Kn`**: the sum of a character over the norm-one set is at most, in modulus, the number of
norm-one `x` whose line `x·Kn` it kills. -/
private theorem SqZeroInvT.norm_sum_le (D : SqZeroInvT R) (ψ : AddChar R ℂ) :
    ‖∑ x ∈ univ.filter (fun x => x * D.σ x = 1), ψ x‖ ≤
      ((univ.filter fun x => x * D.σ x = 1).filter fun x => ∀ w ∈ D.Kn, ψ (x * w) = 1).card := by
  set S := univ.filter (fun x : R => x * D.σ x = 1) with hS
  have hmemS : ∀ x, x ∈ S ↔ x * D.σ x = 1 := fun x => by simp [hS]
  have hww : ∀ w ∈ D.Kn, w * w = 0 := fun w hw => by
    rw [D.mem_Kn] at hw
    exact D.sq w hw.1 w hw.1
  -- each translate by `1 + w` permutes `S`
  have htr : ∀ w ∈ D.Kn, ∑ x ∈ S, ψ x = ∑ x ∈ S, ψ (x * (1 + w)) := by
    intro w hw
    have hσw : D.σ w = -w := (D.mem_Kn.1 hw).2
    refine sum_nbij' (fun x => x * (1 - w)) (fun x => x * (1 + w)) ?_ ?_ ?_ ?_ ?_
    · intro x hx
      rw [hmemS] at hx ⊢
      rw [map_mul, map_sub, map_one, hσw]
      linear_combination (1 - w * w) * hx - hww w hw
    · intro x hx
      rw [hmemS] at hx ⊢
      rw [map_mul, map_add, map_one, hσw]
      linear_combination (1 - w * w) * hx - hww w hw
    · intro x _
      show x * (1 - w) * (1 + w) = x
      linear_combination (-x) * hww w hw
    · intro x _
      show x * (1 + w) * (1 - w) = x
      linear_combination (-x) * hww w hw
    · intro x _
      show ψ x = ψ (x * (1 - w) * (1 + w))
      congr 1
      linear_combination x * hww w hw
  have hmain : (D.Kn.card : ℂ) * ∑ x ∈ S, ψ x =
      ∑ x ∈ S, ψ x * (if (∀ w ∈ D.Kn, ψ (x * w) = 1) then (D.Kn.card : ℂ) else 0) := by
    calc (D.Kn.card : ℂ) * ∑ x ∈ S, ψ x = ∑ w ∈ D.Kn, ∑ x ∈ S, ψ (x * (1 + w)) := by
          rw [Finset.sum_congr rfl (fun w hw => (htr w hw).symm), sum_const, nsmul_eq_mul]
      _ = ∑ x ∈ S, ∑ w ∈ D.Kn, ψ x * ψ (x * w) := by
          rw [Finset.sum_comm]
          refine Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun w _ => ?_
          rw [← AddChar.map_add_eq_mul]
          congr 1
          ring
      _ = _ := by
          refine Finset.sum_congr rfl fun x _ => ?_
          rw [← mul_sum, D.sum_Kn ψ x]
  have hpos : (0 : ℝ) < D.Kn.card := by
    have : (0 : R) ∈ D.Kn := by rw [D.mem_Kn]; exact ⟨D.K.zero_mem, by simp⟩
    exact_mod_cast Finset.card_pos.2 ⟨0, this⟩
  have hle : (D.Kn.card : ℝ) * ‖∑ x ∈ S, ψ x‖ ≤
      (D.Kn.card : ℝ) * (S.filter fun x => ∀ w ∈ D.Kn, ψ (x * w) = 1).card := by
    have h1 : ‖(D.Kn.card : ℂ) * ∑ x ∈ S, ψ x‖ = (D.Kn.card : ℝ) * ‖∑ x ∈ S, ψ x‖ := by
      rw [norm_mul, Complex.norm_natCast]
    rw [← h1, hmain]
    refine (_root_.norm_sum_le _ _).trans ?_
    have h2 : ∀ x ∈ S, ‖ψ x * (if (∀ w ∈ D.Kn, ψ (x * w) = 1) then (D.Kn.card : ℂ) else 0)‖ =
        if (∀ w ∈ D.Kn, ψ (x * w) = 1) then (D.Kn.card : ℝ) else 0 := by
      intro x _
      rw [norm_mul, AddChar.norm_apply, one_mul]
      split_ifs <;> simp
    rw [Finset.sum_congr rfl h2, Finset.sum_ite, sum_const_zero, add_zero, sum_const, nsmul_eq_mul]
    rw [mul_comm]
  exact le_of_mul_le_mul_left hle hpos

/-- **Two lines in the kernel of a character are one**: if `ψ` is non-trivial on `K` and kills both `x·Kn` and
`x'·Kn` (`x`, `x'` of norm one), then `x' ≡ ±x` modulo a prime `M` outside which every element is a unit. -/
private theorem SqZeroInvT.pm_of_good (D : SqZeroInvT R) (M : Ideal R) [hMp : M.IsPrime]
    (hM : ∀ x, x ∉ M → IsUnit x) (ψ : AddChar R ℂ) (hψ : ∃ e ∈ D.K, ψ e ≠ 1) {x x' : R}
    (hx : x * D.σ x = 1) (hx' : x' * D.σ x' = 1) (gx : ∀ w ∈ D.Kn, ψ (x * w) = 1)
    (gx' : ∀ w ∈ D.Kn, ψ (x' * w) = 1) : x' - x ∈ M ∨ x' + x ∈ M := by
  classical
  by_contra hcon
  push Not at hcon
  obtain ⟨e, he, hψe⟩ := hψ
  apply hψe
  have hμ : IsUnit (D.σ x' * x - x' * D.σ x) := by
    refine hM _ fun hμ => ?_
    have h1 : (x' - x) * (x' + x) ∈ M := by
      have h := M.mul_mem_left (x * x') hμ
      have e : x * x' * (D.σ x' * x - x' * D.σ x) = -((x' - x) * (x' + x)) := by
        linear_combination x ^ 2 * hx' - x' ^ 2 * hx
      rw [e] at h
      exact (M.neg_mem_iff).1 h
    rcases hMp.mem_or_mem h1 with h | h
    · exact hcon.1 h
    · exact hcon.2 h
  have hx'u : IsUnit x' := IsUnit.of_mul_eq_one _ hx'
  have hinj : ∀ (p : R × R) (hp : p ∈ D.Kn ×ˢ D.Kn) (p' : R × R) (hp' : p' ∈ D.Kn ×ˢ D.Kn),
      x * p.1 + x' * p.2 = x * p'.1 + x' * p'.2 → p = p' := by
    rintro ⟨a, b⟩ hp ⟨a', b'⟩ hp' heq
    rw [mem_product] at hp hp'
    have hc := D.sub_mem_Kn hp.1 hp'.1
    have hd := D.sub_mem_Kn hp'.2 hp.2
    have hxc : x * (a - a') = x' * (b' - b) := by linear_combination heq
    have hσxc : D.σ x * (a - a') = D.σ x' * (b' - b) := by
      have := congrArg D.σ hxc
      rw [map_mul, map_mul, (D.mem_Kn.1 hc).2, (D.mem_Kn.1 hd).2] at this
      linear_combination -this
    have hc0 : (D.σ x' * x - x' * D.σ x) * (a - a') = 0 := by
      linear_combination D.σ x' * hxc - x' * hσxc
    have ha : a - a' = 0 := (hμ.mul_right_eq_zero).1 hc0
    have hb : x' * (b' - b) = 0 := by rw [← hxc, ha, mul_zero]
    have hb' : b' - b = 0 := (hx'u.mul_right_eq_zero).1 hb
    simp only [Prod.mk.injEq]
    exact ⟨sub_eq_zero.1 ha, (sub_eq_zero.1 hb').symm⟩
  have hsurj := Finset.surj_on_of_inj_on_of_card_le (s := D.Kn ×ˢ D.Kn) (t := D.Kf)
    (fun p _ => x * p.1 + x' * p.2)
    (fun p hp => by
      rw [mem_product, D.mem_Kn, D.mem_Kn] at hp
      rw [D.mem_Kf]
      exact D.K.add_mem (D.K.mul_mem_left _ hp.1.1) (D.K.mul_mem_left _ hp.2.1))
    (fun p p' hp hp' h => hinj p hp p' hp' h)
    (by rw [card_product, ← pow_two, D.card_Kn_sq])
  obtain ⟨⟨a, b⟩, hab, rfl⟩ := hsurj e (D.mem_Kf.2 he)
  rw [mem_product] at hab
  rw [AddChar.map_add_eq_mul, gx a hab.1, gx' b hab.2, one_mul]

end SqZeroInvT

end LemmaPAlgebraT

-- FS131-ICM1: the named leaves.

-- FS131-ICM1: the reduction from level `n + 2` to level `n + 1`.
private def red (P : StablePrime F) (n : ℕ) : (𝓞 (fieldI F) ⧸ P.P ^ (n + 2)) →+* (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) :=
  Ideal.Quotient.factor (Ideal.pow_le_pow_right (Nat.le_succ (n + 1)))

private theorem red_mk (P : StablePrime F) (n : ℕ) (a : 𝓞 (fieldI F)) :
    red P n (Ideal.Quotient.mk _ a) = Ideal.Quotient.mk _ a := Ideal.Quotient.factor_mk _ a

-- FS131-ICM1: the reduction carries the norm-one set into the norm-one set.
private theorem red_mem_levelSet (P : StablePrime F) (n : ℕ) {x : 𝓞 (fieldI F) ⧸ P.P ^ (n + 2)}
    (hx : x ∈ levelSet P (n + 2)) : red P n x ∈ levelSet P (n + 1) := by
  obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective x
  have hx' : Ideal.Quotient.mk _ a * Ideal.quotientMap (P.P ^ (n + 2)) (conjO F) (P.le_comap (n + 2))
      (Ideal.Quotient.mk _ a) = 1 := hx
  show red P n (Ideal.Quotient.mk _ a) * Ideal.quotientMap (P.P ^ (n + 1)) (conjO F) (P.le_comap (n + 1))
    (red P n (Ideal.Quotient.mk _ a)) = 1
  rw [Ideal.quotientMap_mk] at hx'
  rw [red_mk, Ideal.quotientMap_mk, ← map_mul, ← red_mk, map_mul, hx', map_one]

-- FS131-ICM1: a character trivial on the kernel of the reduction descends to level `n + 1`.
private theorem exists_addChar_descent (P : StablePrime F) (n : ℕ) (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ (n + 2)) ℂ)
    (hψ : ∀ e, red P n e = 0 → ψ e = 1) :
    ∃ ψ' : AddChar (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) ℂ, ∀ x, ψ x = ψ' (red P n x) := by
  have hsurj : Function.Surjective (red P n) := Ideal.Quotient.factor_surjective _
  have hs : ∀ y, red P n (Function.surjInv hsurj y) = y := Function.surjInv_eq hsurj
  have hker : ∀ x x', red P n x = red P n x' → ψ x = ψ x' := by
    intro x x' h
    have h0 : red P n (x - x') = 0 := by rw [map_sub, h, sub_self]
    calc ψ x = ψ (x - x' + x') := by rw [sub_add_cancel]
      _ = ψ (x - x') * ψ x' := AddChar.map_add_eq_mul ψ _ _
      _ = ψ x' := by rw [hψ _ h0, one_mul]
  refine ⟨{ toFun := fun y => ψ (Function.surjInv hsurj y), map_zero_eq_one' := ?_, map_add_eq_mul' := ?_ },
    fun x => hker _ _ (hs _).symm⟩
  · show ψ (Function.surjInv hsurj 0) = 1
    rw [hker _ 0 (by rw [hs, map_zero]), AddChar.map_zero_eq_one]
  · intro a b
    show ψ (Function.surjInv hsurj (a + b)) = ψ (Function.surjInv hsurj a) * ψ (Function.surjInv hsurj b)
    rw [hker _ (Function.surjInv hsurj a + Function.surjInv hsurj b) (by rw [hs, map_add, hs, hs]),
      AddChar.map_add_eq_mul]

-- FS131-ICM2: Lemma P at the residue rings — the abstract algebra above at `R = 𝓞 ⧸ P^{n+2}`, `K = ker red`.

-- FS131-ICM2: an element outside `P` is a unit modulo every power of `P` (`ya + i = 1`, `i ∈ P`, and a geometric sum).
private theorem isUnit_mk_of_notMem (P : StablePrime F) (m : ℕ) {a : 𝓞 (fieldI F)} (ha : a ∉ P.P) :
    IsUnit (Ideal.Quotient.mk (P.P ^ m) a) := by
  obtain ⟨y, i, hi, hyi⟩ := P.isMaximal.exists_inv ha
  refine IsUnit.of_mul_eq_one (Ideal.Quotient.mk _ (y * ∑ j ∈ Finset.range m, i ^ j)) ?_
  have e : a * (y * ∑ j ∈ Finset.range m, i ^ j) = 1 - i ^ m := by
    rw [← mul_neg_geom_sum]
    linear_combination (∑ j ∈ Finset.range m, i ^ j) * hyi
  rw [← map_mul, e, map_sub, map_one, Ideal.Quotient.eq_zero_iff_mem.2 (Ideal.pow_mem_pow hi m), sub_zero]

-- FS131-ICM2: a residue at level `n + 2` lies over `0` at level `n + 1` exactly when it comes from `P^{n+1}`.
private theorem mk_mem_ker_red (P : StablePrime F) (n : ℕ) (a : 𝓞 (fieldI F)) :
    Ideal.Quotient.mk (P.P ^ (n + 2)) a ∈ RingHom.ker (red P n) ↔ a ∈ P.P ^ (n + 1) := by
  rw [RingHom.mem_ker, red_mk, Ideal.Quotient.eq_zero_iff_mem]

-- FS131-ICM2: conjugation is an involution at every level.
private theorem conj_conj_at (P : StablePrime F) (m : ℕ) (x : 𝓞 (fieldI F) ⧸ P.P ^ m) :
    Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) (Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) x) =
      x := by
  obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective x
  rw [Ideal.quotientMap_mk, Ideal.quotientMap_mk, UpperHalf.conjO_conjO]

-- FS131-ICM2: the reduction commutes with conjugation.
private theorem red_conj (P : StablePrime F) (n : ℕ) (x : 𝓞 (fieldI F) ⧸ P.P ^ (n + 2)) :
    red P n (Ideal.quotientMap (P.P ^ (n + 2)) (conjO F) (P.le_comap (n + 2)) x) =
      Ideal.quotientMap (P.P ^ (n + 1)) (conjO F) (P.le_comap (n + 1)) (red P n x) := by
  obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective x
  rw [Ideal.quotientMap_mk, red_mk, red_mk, Ideal.quotientMap_mk]

-- FS131-ICM2: `|𝓞 ⧸ P^m| = Q^{2m}` (`cardQuot_pow_of_prime`).
private theorem natCard_quot_pow [NumberField F] (P : StablePrime F) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (m : ℕ) : Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) = Q ^ (2 * m) := by
  haveI := P.isMaximal.isPrime
  have h := cardQuot_pow_of_prime (S := 𝓞 (fieldI F)) (P := P.P) P.heightOne.ne_bot (i := m)
  rw [Submodule.cardQuot_apply, Submodule.cardQuot_apply, hQ, ← pow_mul] at h
  exact h

-- FS131-ICM2: the kernel of the reduction has `Q²` elements.
private theorem natCard_ker_red [NumberField F] (P : StablePrime F) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (n : ℕ) : Nat.card (RingHom.ker (red P n)) = Q ^ 2 := by
  have h := Submodule.card_eq_card_quotient_mul_card (RingHom.ker (red P n))
  rw [Nat.card_congr (RingHom.quotientKerEquivOfSurjective (f := red P n)
    (Ideal.Quotient.factor_surjective _ : Function.Surjective (red P n))).toEquiv,
    natCard_quot_pow P hQ, natCard_quot_pow P hQ] at h
  have hQ0 : 0 < Q := by
    rcases Nat.eq_zero_or_pos Q with h0 | h0
    · haveI : Finite (𝓞 (fieldI F) ⧸ P.P) := Ideal.finiteQuotientOfFreeOfNeBot _ P.heightOne.ne_bot
      have hpos : 0 < Nat.card (𝓞 (fieldI F) ⧸ P.P) := Nat.card_pos
      rw [hQ, h0] at hpos
      norm_num at hpos
    · exact h0
  have e : Q ^ (2 * (n + 2)) = Q ^ 2 * Q ^ (2 * (n + 1)) := by ring
  rw [e] at h
  exact (Nat.eq_of_mul_eq_mul_right (pow_pos hQ0 _) h).symm

-- FS131-ICM2: the residue map from level `n + 1` to level one.
private def res (P : StablePrime F) (n : ℕ) : (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) →+* (𝓞 (fieldI F) ⧸ P.P ^ 1) :=
  Ideal.Quotient.factor (Ideal.pow_le_pow_right (Nat.le_add_left 1 n))

private theorem res_mk (P : StablePrime F) (n : ℕ) (a : 𝓞 (fieldI F)) :
    res P n (Ideal.Quotient.mk _ a) = Ideal.Quotient.mk _ a := Ideal.Quotient.factor_mk _ a

private theorem res_red (P : StablePrime F) (n : ℕ) (x : 𝓞 (fieldI F) ⧸ P.P ^ (n + 2)) :
    res P n (red P n x) = res P (n + 1) x := by
  obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective x
  rw [red_mk, res_mk, res_mk]

private theorem res_zero (P : StablePrime F) (x : 𝓞 (fieldI F) ⧸ P.P ^ (0 + 1)) : res P 0 x = x := by
  obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective x
  exact res_mk P 0 a

-- FS131-ICM2: the residue map carries the norm-one set into the norm-one set at level one.
private theorem res_mem_levelSet (P : StablePrime F) (n : ℕ) {x : 𝓞 (fieldI F) ⧸ P.P ^ (n + 1)}
    (hx : x ∈ levelSet P (n + 1)) : res P n x ∈ levelSet P 1 := by
  obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective x
  have hx' : Ideal.Quotient.mk _ a * Ideal.quotientMap (P.P ^ (n + 1)) (conjO F) (P.le_comap (n + 1))
      (Ideal.Quotient.mk _ a) = 1 := hx
  show res P n (Ideal.Quotient.mk _ a) * Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1)
    (res P n (Ideal.Quotient.mk _ a)) = 1
  rw [Ideal.quotientMap_mk] at hx'
  rw [res_mk, Ideal.quotientMap_mk, ← map_mul, ← res_mk P n, map_mul, hx', map_one]

private theorem neg_mem_levelSet (P : StablePrime F) (m : ℕ) {x : 𝓞 (fieldI F) ⧸ P.P ^ m}
    (hx : x ∈ levelSet P m) : -x ∈ levelSet P m := by
  show -x * Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) (-x) = 1
  rw [map_neg, neg_mul_neg]
  exact hx

-- FS131-ICM3: **Lemma P with no unit `2`** — the residue rings at a stable prime that conjugation moves (`conjO a − a ∉ P`,
-- so `¬ IsRamified P`), in any residue characteristic: the algebra `SqZeroInvT` at `θ = a`, and FS131-ICM2's chain of
-- counts and bounds, each restated with `a` in place of the unit `2`.

-- FS131-ICM3: `a − ā ∉ P` when `ā − a ∉ P`.
private theorem sub_conjO_notMem (P : StablePrime F) {a : 𝓞 (fieldI F)} (ha : conjO F a - a ∉ P.P) :
    a - conjO F a ∉ P.P := fun h => ha (by
  have h' := P.P.neg_mem h
  rwa [neg_sub] at h')

-- FS131-ICM4: at an odd stable prime conjugation moves `i` off the prime (`ī − i = −2i`, and `(ī − i)·i = 2`): the odd
-- case of Lemma P is `SqZeroInvT` at `θ = i` (FS131-ICM2's `SqZeroInv`, folded onto it).
private theorem exists_conj_sub_notMem (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) :
    ∃ a : 𝓞 (fieldI F), conjO F a - a ∉ P.P := by
  obtain ⟨i, hi2, hci⟩ := UpperHalf.exists_I_integer (F := F)
  refine ⟨i, fun h => h2 ?_⟩
  have e : (2 : 𝓞 (fieldI F)) = (conjO F i - i) * i := by
    rw [hci]
    linear_combination 2 * hi2
  rw [e]
  exact P.P.mul_mem_right i h

-- FS131-ICM3: the data of the θ-algebra at level `n + 2`.
private noncomputable def sqZeroInvTAt (P : StablePrime F) {a : 𝓞 (fieldI F)} (ha : conjO F a - a ∉ P.P) (n : ℕ) :
    SqZeroInvT (𝓞 (fieldI F) ⧸ P.P ^ (n + 2)) where
  σ := Ideal.quotientMap (P.P ^ (n + 2)) (conjO F) (P.le_comap (n + 2))
  invol := conj_conj_at P (n + 2)
  K := RingHom.ker (red P n)
  sq := by
    intro a ha b hb
    obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective a
    obtain ⟨b, rfl⟩ := Ideal.Quotient.mk_surjective b
    rw [mk_mem_ker_red] at ha hb
    rw [← map_mul, Ideal.Quotient.eq_zero_iff_mem]
    have h := Ideal.mul_mem_mul ha hb
    rw [← pow_add] at h
    exact Ideal.pow_le_pow_right (by omega) h
  σK := by
    intro a ha
    obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective a
    rw [mk_mem_ker_red] at ha
    rw [Ideal.quotientMap_mk, mk_mem_ker_red]
    exact P.le_comap (n + 1) ha
  θ := Ideal.Quotient.mk _ a
  δ := ((isUnit_mk_of_notMem P (n + 2) (sub_conjO_notMem P ha)).unit⁻¹ : (𝓞 (fieldI F) ⧸ P.P ^ (n + 2))ˣ)
  δ_mul := by
    rw [Ideal.quotientMap_mk, ← map_sub]
    exact (isUnit_mk_of_notMem P (n + 2) (sub_conjO_notMem P ha)).mul_val_inv

-- FS131-ICM3: `|S₁| = Q + 1` at a stable prime that conjugation moves (`σ = (·)^Q`, `card_normOne`).
private theorem card_levelSet_oneT [NumberField F] (P : StablePrime F) {a : 𝓞 (fieldI F)} (ha : conjO F a - a ∉ P.P)
    {Q : ℕ} (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hfin : (levelSet P 1).Finite) :
    hfin.toFinset.card = Q + 1 := by
  classical
  haveI hmax : (P.P ^ 1).IsMaximal := by rw [pow_one]; exact P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P ^ 1) := Ideal.Quotient.field (P.P ^ 1)
  haveI := finite_quot_pow P 1
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ 1) := Fintype.ofFinite _
  set σ : (𝓞 (fieldI F) ⧸ P.P ^ 1) →+* (𝓞 (fieldI F) ⧸ P.P ^ 1) :=
    Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) with hσdef
  have hσmk : ∀ x, σ (Ideal.Quotient.mk (P.P ^ 1) x) = Ideal.Quotient.mk (P.P ^ 1) (conjO F x) := fun x =>
    Ideal.quotientMap_mk
  have hσ : ∀ x, σ (σ x) = x := fun x => by
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
    rw [hσmk, hσmk, UpperHalf.conjO_conjO]
  have hne : σ ≠ RingHom.id _ := by
    intro h
    have h1 : σ (Ideal.Quotient.mk (P.P ^ 1) a) = Ideal.Quotient.mk (P.P ^ 1) a := by rw [h]; rfl
    rw [hσmk, ← sub_eq_zero, ← map_sub, Ideal.Quotient.eq_zero_iff_mem, pow_one] at h1
    exact ha h1
  have hcardk : Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1) = Q ^ 2 := by
    rw [← Nat.card_eq_fintype_card, ← hQ, pow_one]
  have hpow := StandingFive.involution_eq_pow σ hσ hne hcardk
  have hS : hfin.toFinset = Finset.univ.filter fun u : 𝓞 (fieldI F) ⧸ P.P ^ 1 => u ^ (Q + 1) = 1 := by
    ext u
    rw [Set.Finite.mem_toFinset, Finset.mem_filter]
    simp only [Finset.mem_univ, true_and]
    show u * σ u = 1 ↔ u ^ (Q + 1) = 1
    rw [hpow, ← pow_succ']
  rw [hS, StandingFive.card_normOne hcardk]

private theorem sqZeroInvTAt_σ (P : StablePrime F) {a : 𝓞 (fieldI F)} (ha : conjO F a - a ∉ P.P) (n : ℕ) :
    (sqZeroInvTAt P ha n).σ = Ideal.quotientMap (P.P ^ (n + 2)) (conjO F) (P.le_comap (n + 2)) := rfl

private theorem sqZeroInvTAt_K (P : StablePrime F) {a : 𝓞 (fieldI F)} (ha : conjO F a - a ∉ P.P) (n : ℕ) :
    (sqZeroInvTAt P ha n).K = RingHom.ker (red P n) := rfl

-- FS131-ICM2: at level `n + 2` the `−1` part of `K` has `Q` elements.
private theorem card_KnT_at [NumberField F] (P : StablePrime F) {a : 𝓞 (fieldI F)} (ha : conjO F a - a ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (n : ℕ) [Fintype (𝓞 (fieldI F) ⧸ P.P ^ (n + 2))] :
    (sqZeroInvTAt P ha n).Kn.card = Q := by
  classical
  have hKf : (sqZeroInvTAt P ha n).Kf.card = Q ^ 2 := by
    rw [← natCard_ker_red P hQ n, ← sqZeroInvTAt_K P ha n, Nat.card_eq_fintype_card, Fintype.card_subtype]
    unfold SqZeroInvT.Kf
    congr 1
  have h := (sqZeroInvTAt P ha n).card_Kn_sq
  rw [hKf] at h
  exact Nat.pow_left_injective two_ne_zero h

open Classical in
/-- **Hensel at level `n + 2`, with no unit `2`** (FS131-ICM3): at a stable prime that conjugation moves
(`conjO a − a ∉ P`) with `|𝓞 ⧸ P| = Q²`, every norm-one residue at level `n + 1` has exactly `Q` norm-one lifts at
level `n + 2` — a coset of `(σx₀)⁻¹·Kn` (`SqZeroInvT.card_lift`). -/
private theorem card_fibreT [NumberField F] (P : StablePrime F) {a : 𝓞 (fieldI F)} (ha : conjO F a - a ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (n : ℕ) (hfin : (levelSet P (n + 2)).Finite)
    {t : 𝓞 (fieldI F) ⧸ P.P ^ (n + 1)} (ht : t ∈ levelSet P (n + 1)) :
    (hfin.toFinset.filter fun x => red P n x = t).card = Q := by
  haveI := finite_quot_pow P (n + 2)
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ (n + 2)) := Fintype.ofFinite _
  set D := sqZeroInvTAt P ha n with hD
  obtain ⟨x₀, hx₀⟩ : ∃ x₀, red P n x₀ = t := Ideal.Quotient.factor_surjective _ t
  have hσ : ∀ x, D.σ x = Ideal.quotientMap (P.P ^ (n + 2)) (conjO F) (P.le_comap (n + 2)) x := fun _ => rfl
  have hK : ∀ x, x ∈ D.K ↔ red P n x = 0 := fun _ => RingHom.mem_ker
  have hmem : ∀ x, x ∈ hfin.toFinset ↔ x * D.σ x = 1 := fun x => by
    rw [Set.Finite.mem_toFinset, hσ]; exact Iff.rfl
  have ht' : t * Ideal.quotientMap (P.P ^ (n + 1)) (conjO F) (P.le_comap (n + 1)) t = 1 := ht
  have hxK : x₀ * D.σ x₀ - 1 ∈ D.K := by
    rw [hK, hσ, map_sub, map_mul, map_one, red_conj, hx₀, ht', sub_self]
  rw [← card_KnT_at P ha hQ n, ← D.card_lift hxK]
  refine Finset.card_nbij' (fun x => x - x₀) (fun e => x₀ + e) ?_ ?_ ?_ ?_
  · intro x hx
    rw [Finset.mem_coe, Finset.mem_filter, hmem] at hx
    rw [Finset.mem_coe, Finset.mem_filter, D.mem_Kf, hK, map_sub, hx.2, hx₀, sub_self, add_sub_cancel]
    exact ⟨rfl, hx.1⟩
  · intro e he
    rw [Finset.mem_coe, Finset.mem_filter, D.mem_Kf, hK] at he
    rw [Finset.mem_coe, Finset.mem_filter, hmem]
    refine ⟨he.2, ?_⟩
    show red P n (x₀ + e) = t
    rw [map_add, he.1, hx₀, add_zero]
  · intro x _
    show x₀ + (x - x₀) = x
    ring
  · intro e _
    show x₀ + e - x₀ = e
    ring

open Classical in
-- FS131-ICM2: every norm-one residue at level one has `Q^n` norm-one lifts at level `n + 1` (`card_fibreT`, by
-- induction).
private theorem card_res_fibreT [NumberField F] (P : StablePrime F) {a : 𝓞 (fieldI F)} (ha : conjO F a - a ∉ P.P)
    {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (n : ℕ) (hfin : (levelSet P (n + 1)).Finite)
    {s : 𝓞 (fieldI F) ⧸ P.P ^ 1} (hs : s ∈ levelSet P 1) :
    (hfin.toFinset.filter fun x => res P n x = s).card = Q ^ n := by
  induction n with
  | zero =>
    rw [pow_zero, Finset.card_eq_one]
    refine ⟨s, Finset.ext fun x => ?_⟩
    rw [Finset.mem_filter, Set.Finite.mem_toFinset, Finset.mem_singleton, res_zero]
    constructor
    · rintro ⟨_, h⟩
      exact h
    · rintro rfl
      exact ⟨hs, rfl⟩
  | succ n ih =>
    haveI := finite_quot_pow P (n + 1)
    have hfin' : (levelSet P (n + 1)).Finite := Set.toFinite _
    have hmaps : ∀ x ∈ hfin.toFinset.filter (fun x => res P (n + 1) x = s),
        red P n x ∈ hfin'.toFinset.filter (fun y => res P n y = s) := by
      intro x hx
      rw [Finset.mem_filter, Set.Finite.mem_toFinset] at hx ⊢
      exact ⟨red_mem_levelSet P n hx.1, by rw [res_red]; exact hx.2⟩
    rw [Finset.card_eq_sum_card_fiberwise hmaps]
    have hfib : ∀ y ∈ hfin'.toFinset.filter (fun y => res P n y = s),
        ((hfin.toFinset.filter fun x => res P (n + 1) x = s).filter fun x => red P n x = y).card = Q := by
      intro y hy
      rw [Finset.mem_filter, Set.Finite.mem_toFinset] at hy
      rw [Finset.filter_filter, ← card_fibreT P ha hQ n hfin hy.1]
      congr 1
      refine Finset.filter_congr fun x _ => ?_
      constructor
      · exact fun h => h.2
      · intro h
        exact ⟨by rw [← res_red, h, hy.2], h⟩
    rw [Finset.sum_congr rfl hfib, Finset.sum_const, smul_eq_mul, ih hfin', pow_succ, mul_comm]

-- FS131-ICM2: `|S_{n+1}| = Q^n (Q + 1)`.
private theorem card_levelSet_succT [NumberField F] (P : StablePrime F) {a : 𝓞 (fieldI F)} (ha : conjO F a - a ∉ P.P)
    {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (n : ℕ) (hfin : (levelSet P (n + 1)).Finite) :
    hfin.toFinset.card = Q ^ n * (Q + 1) := by
  classical
  haveI := finite_quot_pow P 1
  have hfin1 : (levelSet P 1).Finite := Set.toFinite _
  rw [Finset.card_eq_sum_card_fiberwise (f := res P n) (t := hfin1.toFinset) (fun x hx =>
    hfin1.mem_toFinset.2 (res_mem_levelSet P n (hfin.mem_toFinset.1 hx)))]
  rw [Finset.sum_congr rfl fun s hs => card_res_fibreT P ha hQ n hfin (hfin1.mem_toFinset.1 hs),
    Finset.sum_const, card_levelSet_oneT P ha hQ hfin1, smul_eq_mul, mul_comm]

/-- **A character new at level `n + 2`, with no unit `2`** (FS131-ICM3): at a stable prime that conjugation moves
(`conjO a − a ∉ P`) with `|𝓞 ⧸ P| = Q²`, a character non-trivial on the kernel of the reduction sums to at most
`2|S_{n+2}|/(Q + 1)` in modulus over `S_{n+2}` (averaging over `1 + Kn`; the good residues lie in two classes modulo `P`,
one when `2 ∈ P`). -/
private theorem norm_charSum_new_leT [NumberField F] (P : StablePrime F) {a : 𝓞 (fieldI F)} (ha : conjO F a - a ∉ P.P)
    {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (n : ℕ) (hfin : (levelSet P (n + 2)).Finite)
    (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ (n + 2)) ℂ) (hψ : ∃ e, red P n e = 0 ∧ ψ e ≠ 1) :
    ‖∑ s ∈ hfin.toFinset, ψ s‖ ≤ 2 / ((Q : ℝ) + 1) * hfin.toFinset.card := by
  classical
  haveI := finite_quot_pow P (n + 2)
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ (n + 2)) := Fintype.ofFinite _
  set D := sqZeroInvTAt P ha n with hD
  have hσ : ∀ x, D.σ x = Ideal.quotientMap (P.P ^ (n + 2)) (conjO F) (P.le_comap (n + 2)) x := fun _ => rfl
  have hmem : ∀ x, x ∈ hfin.toFinset ↔ x * D.σ x = 1 := fun x => by
    rw [Set.Finite.mem_toFinset, hσ]; exact Iff.rfl
  have hS : hfin.toFinset = Finset.univ.filter fun x => x * D.σ x = 1 := by
    ext x
    rw [hmem, Finset.mem_filter]
    simp only [Finset.mem_univ, true_and]
  haveI : (P.P ^ 1).IsPrime := by rw [pow_one]; exact P.isMaximal.isPrime
  haveI : (RingHom.ker (res P (n + 1))).IsPrime := RingHom.ker_isPrime _
  have hM : ∀ x, x ∉ RingHom.ker (res P (n + 1)) → IsUnit x := by
    intro x hx
    obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective x
    refine isUnit_mk_of_notMem P (n + 2) fun hb' => hx ?_
    rw [RingHom.mem_ker, res_mk, Ideal.Quotient.eq_zero_iff_mem, pow_one]
    exact hb'
  have hψ' : ∃ e ∈ D.K, ψ e ≠ 1 := by
    obtain ⟨e, he, hψe⟩ := hψ
    exact ⟨e, RingHom.mem_ker.2 he, hψe⟩
  have h1 := D.norm_sum_le ψ
  rw [← hS] at h1
  have hG : (hfin.toFinset.filter fun x => ∀ w ∈ D.Kn, ψ (x * w) = 1).card ≤ 2 * Q ^ (n + 1) := by
    rcases (hfin.toFinset.filter fun x => ∀ w ∈ D.Kn, ψ (x * w) = 1).eq_empty_or_nonempty with hG | ⟨x₀, hx₀⟩
    · rw [hG, Finset.card_empty]
      exact Nat.zero_le _
    · rw [Finset.mem_filter] at hx₀
      have hx₀S : x₀ * D.σ x₀ = 1 := (hmem x₀).1 hx₀.1
      have hs : res P (n + 1) x₀ ∈ levelSet P 1 := res_mem_levelSet P (n + 1) (hfin.mem_toFinset.1 hx₀.1)
      have hsub : (hfin.toFinset.filter fun x => ∀ w ∈ D.Kn, ψ (x * w) = 1) ⊆
          (hfin.toFinset.filter fun x => res P (n + 1) x = res P (n + 1) x₀) ∪
            (hfin.toFinset.filter fun x => res P (n + 1) x = -res P (n + 1) x₀) := by
        intro x hx
        rw [Finset.mem_filter] at hx
        have hxS : x * D.σ x = 1 := (hmem x).1 hx.1
        rcases D.pm_of_good _ hM ψ hψ' hx₀S hxS hx₀.2 hx.2 with h | h
        · refine Finset.mem_union_left _ (Finset.mem_filter.2 ⟨hx.1, ?_⟩)
          rw [RingHom.mem_ker, map_sub, sub_eq_zero] at h
          exact h
        · refine Finset.mem_union_right _ (Finset.mem_filter.2 ⟨hx.1, ?_⟩)
          rw [RingHom.mem_ker, map_add, add_eq_zero_iff_eq_neg] at h
          exact h
      refine (Finset.card_le_card hsub).trans ((Finset.card_union_le _ _).trans ?_)
      rw [card_res_fibreT P ha hQ (n + 1) hfin hs, card_res_fibreT P ha hQ (n + 1) hfin (neg_mem_levelSet P 1 hs),
        two_mul]
  rw [card_levelSet_succT P ha hQ (n + 1) hfin]
  have hQ1 : (0 : ℝ) < (Q : ℝ) + 1 := by positivity
  calc ‖∑ s ∈ hfin.toFinset, ψ s‖ ≤ ((hfin.toFinset.filter fun x => ∀ w ∈ D.Kn, ψ (x * w) = 1).card : ℝ) := h1
    _ ≤ ((2 * Q ^ (n + 1) : ℕ) : ℝ) := by exact_mod_cast hG
    _ = 2 / ((Q : ℝ) + 1) * ((Q ^ (n + 1) * (Q + 1) : ℕ) : ℝ) := by
      push_cast
      rw [div_mul_eq_mul_div, eq_div_iff hQ1.ne']
      ring

-- FS131-ICM4: **Lemma P's per-character bound at every level** (one lemma, for the certificate link, FS131-IKL1): at a
-- stable prime that conjugation moves, a character of `𝓞 ⧸ P^{n+1}` non-trivial on the kernel of the residue map to level
-- one sums to at most `2|S_{n+1}|/(Q + 1)` (`= 2Q^n`, `card_levelSet_succT`) in modulus over `S_{n+1}`: descend while it is
-- trivial on the kernel of the reduction (the sum is `Q` times the sum one level down, `card_fibreT`), and bound it by
-- `norm_charSum_new_leT` at the level where it is new.
private theorem norm_charSum_le_of_resT [NumberField F] (P : StablePrime F) {a : 𝓞 (fieldI F)}
    (ha : conjO F a - a ∉ P.P) {Q : ℕ} (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (n : ℕ)
    (hfin : (levelSet P (n + 1)).Finite) (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) ℂ)
    (hψ : ∃ e, res P n e = 0 ∧ ψ e ≠ 1) :
    ‖∑ s ∈ hfin.toFinset, ψ s‖ ≤ 2 / ((Q : ℝ) + 1) * hfin.toFinset.card := by
  classical
  induction n with
  | zero =>
    obtain ⟨e, he, hψe⟩ := hψ
    rw [res_zero] at he
    rw [he, AddChar.map_zero_eq_one] at hψe
    exact absurd rfl hψe
  | succ n ih =>
    haveI := finite_quot_pow P (n + 1)
    have hfin' : (levelSet P (n + 1)).Finite := Set.toFinite _
    have hmaps : ∀ x ∈ hfin.toFinset, red P n x ∈ hfin'.toFinset := fun x hx =>
      hfin'.mem_toFinset.2 (red_mem_levelSet P n (hfin.mem_toFinset.1 hx))
    by_cases hK : ∀ e, red P n e = 0 → ψ e = 1
    · obtain ⟨ψ', hψ'⟩ := exists_addChar_descent P n ψ hK
      have hψ'1 : ∃ e, res P n e = 0 ∧ ψ' e ≠ 1 := by
        obtain ⟨e, he, hψe⟩ := hψ
        exact ⟨red P n e, by rw [res_red]; exact he, by rw [← hψ' e]; exact hψe⟩
      have hsum : ∑ s ∈ hfin.toFinset, ψ s = ((Q : ℝ) : ℂ) * ∑ t ∈ hfin'.toFinset, ψ' t := by
        rw [← Finset.sum_fiberwise_of_maps_to hmaps, Finset.mul_sum]
        refine Finset.sum_congr rfl fun t ht => ?_
        have hc : ∀ x ∈ hfin.toFinset.filter (fun x => red P n x = t), ψ x = ψ' t := fun x hx => by
          rw [hψ' x, (Finset.mem_filter.1 hx).2]
        rw [Finset.sum_congr rfl hc, Finset.sum_const, card_fibreT P ha hQ n hfin (hfin'.mem_toFinset.1 ht),
          nsmul_eq_mul]
        push_cast
        ring
      have hcard : (hfin.toFinset.card : ℝ) = Q * hfin'.toFinset.card := by
        rw [Finset.card_eq_sum_card_fiberwise hmaps,
          Finset.sum_congr rfl fun t ht => card_fibreT P ha hQ n hfin (hfin'.mem_toFinset.1 ht)]
        rw [Finset.sum_const, smul_eq_mul]
        push_cast
        ring
      have hih := ih hfin' ψ' hψ'1
      rw [hsum, norm_mul, Complex.norm_real, Real.norm_of_nonneg (Nat.cast_nonneg _), hcard]
      have hQ0 : (0 : ℝ) ≤ Q := Nat.cast_nonneg _
      calc (Q : ℝ) * ‖∑ t ∈ hfin'.toFinset, ψ' t‖ ≤ Q * (2 / ((Q : ℝ) + 1) * hfin'.toFinset.card) :=
            mul_le_mul_of_nonneg_left hih hQ0
        _ = 2 / ((Q : ℝ) + 1) * (Q * hfin'.toFinset.card) := by ring
    · push Not at hK
      obtain ⟨e, he, hψe⟩ := hK
      exact norm_charSum_new_leT P ha hQ n hfin ψ ⟨e, he, hψe⟩

/-- **Lemma P with no unit `2`** (FS131-ICM3; KR1 § 2.6 (b), the dyadic form): at a stable prime that conjugation moves
(`conjO a − a ∉ P`) with `|𝓞 ⧸ P| = Q²`, a level-one character bound `κ ≥ 2/(Q + 1)` holds at every level. -/
private theorem charBound_of_charBound_oneT [NumberField F] (P : StablePrime F) {a : 𝓞 (fieldI F)} (ha : conjO F a - a ∉ P.P)
    {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) {κ : ℝ} (hκ : 2 / ((Q : ℝ) + 1) ≤ κ) (h1 : CharBound P 1 κ) {m : ℕ}
    (hm : 1 ≤ m) : CharBound P m κ := by
  classical
  have hκ0 : 0 ≤ κ := le_trans (by positivity) hκ
  obtain ⟨n, rfl⟩ : ∃ n, m = n + 1 := ⟨m - 1, by omega⟩
  clear hm
  induction n with
  | zero => exact h1
  | succ n ih =>
    intro hfin ψ hψ
    haveI := finite_quot_pow P (n + 1)
    have hfin' : (levelSet P (n + 1)).Finite := Set.toFinite _
    have hmaps : ∀ x ∈ hfin.toFinset, red P n x ∈ hfin'.toFinset := fun x hx =>
      hfin'.mem_toFinset.2 (red_mem_levelSet P n (hfin.mem_toFinset.1 hx))
    by_cases hK : ∀ e, red P n e = 0 → ψ e = 1
    · obtain ⟨ψ', hψ'⟩ := exists_addChar_descent P n ψ hK
      have hψ'1 : ψ' ≠ 1 := by
        intro h
        apply hψ
        ext x
        rw [hψ' x, h, AddChar.one_apply, AddChar.one_apply]
      have hsum : ∑ s ∈ hfin.toFinset, ψ s = ((Q : ℝ) : ℂ) * ∑ t ∈ hfin'.toFinset, ψ' t := by
        rw [← Finset.sum_fiberwise_of_maps_to hmaps, Finset.mul_sum]
        refine Finset.sum_congr rfl fun t ht => ?_
        have hc : ∀ x ∈ hfin.toFinset.filter (fun x => red P n x = t), ψ x = ψ' t := fun x hx => by
          rw [hψ' x, (Finset.mem_filter.1 hx).2]
        rw [Finset.sum_congr rfl hc, Finset.sum_const, card_fibreT P ha hQ n hfin (hfin'.mem_toFinset.1 ht),
          nsmul_eq_mul]
        push_cast
        ring
      have hcard : (hfin.toFinset.card : ℝ) = Q * hfin'.toFinset.card := by
        rw [Finset.card_eq_sum_card_fiberwise hmaps,
          Finset.sum_congr rfl fun t ht => card_fibreT P ha hQ n hfin (hfin'.mem_toFinset.1 ht)]
        rw [Finset.sum_const, smul_eq_mul]
        push_cast
        ring
      have hih := ih hfin' ψ' hψ'1
      rw [hsum, Complex.re_ofReal_mul, hcard]
      have hQ0 : (0 : ℝ) ≤ Q := Nat.cast_nonneg _
      have hm := mul_le_mul_of_nonneg_left hih hQ0
      linarith
    · push Not at hK
      obtain ⟨e, he, hψe⟩ := hK
      have hb := norm_charSum_new_leT P ha hQ n hfin ψ ⟨e, he, hψe⟩
      have hre := Complex.abs_re_le_norm (∑ s ∈ hfin.toFinset, ψ s)
      have hc : (0 : ℝ) ≤ hfin.toFinset.card := Nat.cast_nonneg _
      have : 2 / ((Q : ℝ) + 1) * hfin.toFinset.card ≤ κ * hfin.toFinset.card := mul_le_mul_of_nonneg_right hκ hc
      linarith [neg_abs_le (∑ s ∈ hfin.toFinset, ψ s).re]

/-- **Weil at level one, two-sided** (`StandingFive.norm_normOne_charSum_le`, over the declared import
`kloosterman_bound`): at an odd stable prime with `|𝓞 ⧸ P| = Q²`, every non-trivial character sums to modulus at most `2√Q`
over the `Q + 1` norm-one residues. -/
private theorem norm_charSum_one_weil [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hfin : (levelSet P 1).Finite)
    (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ 1) ℂ) (hψ : ψ ≠ 1) :
    ‖∑ s ∈ hfin.toFinset, ψ s‖ ≤ 2 * Real.sqrt Q / ((Q : ℝ) + 1) * hfin.toFinset.card := by
  classical
  haveI hmax : (P.P ^ 1).IsMaximal := by rw [pow_one]; exact P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P ^ 1) := Ideal.Quotient.field (P.P ^ 1)
  haveI := finite_quot_pow P 1
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ 1) := Fintype.ofFinite _
  set σ : (𝓞 (fieldI F) ⧸ P.P ^ 1) →+* (𝓞 (fieldI F) ⧸ P.P ^ 1) :=
    Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) with hσdef
  have hσmk : ∀ x, σ (Ideal.Quotient.mk (P.P ^ 1) x) = Ideal.Quotient.mk (P.P ^ 1) (conjO F x) := fun x =>
    Ideal.quotientMap_mk
  have hσ : ∀ x, σ (σ x) = x := fun x => by
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
    rw [hσmk, hσmk, UpperHalf.conjO_conjO]
  obtain ⟨i, hi2, hci⟩ := UpperHalf.exists_I_integer (F := F)
  have h2k : (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1) ≠ 0 := by
    rw [← map_ofNat (Ideal.Quotient.mk (P.P ^ 1)) 2, Ne, Ideal.Quotient.eq_zero_iff_mem, pow_one]; exact h2
  have hι : Ideal.Quotient.mk (P.P ^ 1) i ^ 2 = -1 := by rw [← map_pow, hi2, map_neg, map_one]
  have hσι : σ (Ideal.Quotient.mk (P.P ^ 1) i) = -Ideal.Quotient.mk (P.P ^ 1) i := by rw [hσmk, hci, map_neg]
  have hne : σ ≠ RingHom.id _ := by
    intro h
    have h1 : σ (Ideal.Quotient.mk (P.P ^ 1) i) = Ideal.Quotient.mk (P.P ^ 1) i := by rw [h]; rfl
    rw [hσι] at h1
    have hz : (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1) * Ideal.Quotient.mk (P.P ^ 1) i = 0 := by linear_combination -h1
    rcases mul_eq_zero.1 hz with h0 | h0
    · exact h2k h0
    · have : (Ideal.Quotient.mk (P.P ^ 1) i) ^ 2 = 0 := by rw [h0]; ring
      rw [hι] at this
      exact one_ne_zero (neg_eq_zero.1 this)
  have hcardk : Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1) = Q ^ 2 := by
    rw [← Nat.card_eq_fintype_card, ← hQ, pow_one]
  obtain ⟨hcard0, hmod0⟩ := StandingFive.card_fixed_of_involution σ hσ hι hσι h2k
  have hQ4 : Q % 4 = 3 := by
    have e : Nat.card (σ.eqLocusField (RingHom.id _)) ^ 2 = Q ^ 2 := by
      rw [← hcard0, Nat.card_eq_fintype_card, hcardk]
    rw [← Nat.pow_left_injective two_ne_zero e]
    exact hmod0
  have hpow := StandingFive.involution_eq_pow σ hσ hne hcardk
  have hS : hfin.toFinset = Finset.univ.filter fun u : 𝓞 (fieldI F) ⧸ P.P ^ 1 => u ^ (Q + 1) = 1 := by
    ext u
    rw [Set.Finite.mem_toFinset, Finset.mem_filter]
    simp only [Finset.mem_univ, true_and]
    show u * σ u = 1 ↔ u ^ (Q + 1) = 1
    rw [hpow, ← pow_succ']
  have hK : ∀ (F' : Type) [Field F'] [Fintype F'] [DecidableEq F'], Fintype.card F' = Q →
      StandingFive.KloostermanBound F' := fun F' _ _ _ hF' =>
    StandingFive.kloostermanBound_of_ringChar_ne_two F'
      (StandingFive.ringChar_ne_two_of_card_mod_four (by rw [hF']; exact hQ4))
  have hW := StandingFive.norm_normOne_charSum_le hQ4 hcardk hK ψ hψ
  rw [hS, StandingFive.card_normOne hcardk]
  have hpos : (0 : ℝ) < (Q : ℝ) + 1 := by positivity
  have e : 2 * Real.sqrt Q / ((Q : ℝ) + 1) * ((Q + 1 : ℕ) : ℝ) = 2 * Real.sqrt Q := by
    push_cast
    field_simp
  rw [e]
  exact hW

/-- **Weil at level one** (`StandingFive.normOne_charSum_ge`'s form, over the declared import `kloosterman_bound`): at an odd
stable prime with `|𝓞 ⧸ P| = Q²`, every non-trivial character sums to real part at least `−2√Q` over the `Q + 1` norm-one
residues — the real part of `norm_charSum_one_weil`. -/
private theorem charBound_one_weil [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) : CharBound P 1 (2 * Real.sqrt Q / ((Q : ℝ) + 1)) := fun hfin ψ hψ =>
  neg_le_of_abs_le ((Complex.abs_re_le_norm _).trans (norm_charSum_one_weil P h2 hQ hfin ψ hψ))

-- FS131-ICM3: **the dyadic branch, cut** (KR1 § 2.6 (c); X26B-T1; EN1-UQ4). At an unramified dyadic stable prime the
-- residue field has `Q²` elements, `Q = 2^f` (`exists_card_two_pow_sq`); `f ≤ 5` is excluded by a four-colouring
-- (`colorable_four_dyadic_small`, a named child at `f ∈ {2, …, 5}`; `f ≤ 1` here); level one is `charSum_64_ge` (a named
-- child), `Floor128.charSum_128_ge`, or the fourth-moment count at `f ≥ 8` (`charSum_dyadic_large`, a named child);
-- Lemma P with no unit `2` (`charBound_of_charBound_oneT`) carries level one to every level.

-- FS131-ICM3: a finite field with an involution that moves `θ` has the square of its fixed field's size
-- (`(a, b) ↦ a + θb` is a bijection from pairs of fixed elements).
private theorem card_eq_sq_of_involution {k : Type*} [Field k] [Fintype k] [DecidableEq k] (σ : k →+* k)
    (hσ : ∀ x, σ (σ x) = x) {θ : k} (hθ : σ θ ≠ θ) :
    Fintype.card k = (Finset.univ.filter fun x : k => σ x = x).card ^ 2 := by
  have hδ : θ - σ θ ≠ 0 := sub_ne_zero.2 (Ne.symm hθ)
  rw [sq, ← Finset.card_product, ← Finset.card_univ]
  symm
  refine Finset.card_nbij' (fun p => p.1 + θ * p.2)
    (fun x => (x - θ * ((x - σ x) / (θ - σ θ)), (x - σ x) / (θ - σ θ))) ?_ ?_ ?_ ?_
  · intro p _
    exact Finset.mem_coe.2 (Finset.mem_univ _)
  · intro x _
    have hb : σ ((x - σ x) / (θ - σ θ)) = (x - σ x) / (θ - σ θ) := by
      rw [map_div₀, map_sub, map_sub, hσ, hσ, ← neg_sub x (σ x), ← neg_sub θ (σ θ), neg_div_neg_eq]
    have hb' : (θ - σ θ) * ((x - σ x) / (θ - σ θ)) = x - σ x := mul_div_cancel₀ _ hδ
    rw [Finset.mem_coe, Finset.mem_product, Finset.mem_filter, Finset.mem_filter]
    refine ⟨⟨Finset.mem_univ _, ?_⟩, ⟨Finset.mem_univ _, hb⟩⟩
    rw [map_sub, map_mul, hb]
    linear_combination hb'
  · rintro ⟨a, b⟩ hab
    rw [Finset.mem_coe, Finset.mem_product, Finset.mem_filter, Finset.mem_filter] at hab
    have hx : (a + θ * b) - σ (a + θ * b) = (θ - σ θ) * b := by
      rw [map_add, map_mul, hab.1.2, hab.2.2]; ring
    have hb : ((a + θ * b) - σ (a + θ * b)) / (θ - σ θ) = b := by
      rw [hx, mul_div_cancel_left₀ _ hδ]
    simp only [hb, Prod.mk.injEq, and_true]
    ring
  · intro x _
    show x - θ * ((x - σ x) / (θ - σ θ)) + θ * ((x - σ x) / (θ - σ θ)) = x
    ring

/-- **The residue size at a dyadic stable prime that conjugation moves** (FS131-ICM3): `|𝓞 ⧸ P| = (2^f)²` — the residue
field is a square of its fixed field's size (`card_eq_sq_of_involution`), a power of 2. Public since FS131-ICS1 (inventory
item 1029). -/
theorem exists_card_two_pow_sq [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∈ P.P)
    {a : 𝓞 (fieldI F)} (ha : conjO F a - a ∉ P.P) : ∃ f : ℕ, Nat.card (𝓞 (fieldI F) ⧸ P.P) = (2 ^ f) ^ 2 := by
  classical
  haveI := P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P) := Ideal.Quotient.field P.P
  haveI : Finite (𝓞 (fieldI F) ⧸ P.P) := Ideal.finiteQuotientOfFreeOfNeBot _ P.heightOne.ne_bot
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P) := Fintype.ofFinite _
  let σ : (𝓞 (fieldI F) ⧸ P.P) →+* (𝓞 (fieldI F) ⧸ P.P) := Ideal.quotientMap P.P (conjO F) P.comap_conj.ge
  have hσmk : ∀ x, σ (Ideal.Quotient.mk P.P x) = Ideal.Quotient.mk P.P (conjO F x) := fun x => Ideal.quotientMap_mk
  have hσ : ∀ x, σ (σ x) = x := fun x => by
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
    rw [hσmk, hσmk, UpperHalf.conjO_conjO]
  have hθ : σ (Ideal.Quotient.mk P.P a) ≠ Ideal.Quotient.mk P.P a := by
    rw [hσmk]
    intro h
    exact ha (Ideal.Quotient.eq.1 h)
  have hc := card_eq_sq_of_involution σ hσ hθ
  haveI : CharP (𝓞 (fieldI F) ⧸ P.P) 2 := by
    refine CharTwo.of_one_ne_zero_of_two_eq_zero one_ne_zero ?_
    rw [← map_ofNat (Ideal.Quotient.mk P.P) 2, Ideal.Quotient.eq_zero_iff_mem]
    exact h2
  obtain ⟨n, -, hn⟩ := FiniteField.card (𝓞 (fieldI F) ⧸ P.P) 2
  have hdvd : (Finset.univ.filter fun x => σ x = x).card ∣ 2 ^ (n : ℕ) := ⟨_, by rw [← hn, hc, sq]⟩
  obtain ⟨m, -, hm⟩ := (Nat.dvd_prime_pow Nat.prime_two).1 hdvd
  exact ⟨m, by rw [Nat.card_eq_fintype_card, hc, hm]⟩

-- FS131-ICM3: at a stable prime that conjugation moves, a bound on the norm-one character sums of every field of `Q²`
-- elements is a level-one character bound (as `charBound_one_weil`, with the bound as a hypothesis).
private theorem charBound_one_of_charSum [NumberField F] (P : StablePrime F) {a : 𝓞 (fieldI F)}
    (ha : conjO F a - a ∉ P.P) {Q : ℕ} (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) {m : ℝ}
    (hm : ∀ (k : Type) [Field k] [Fintype k] [DecidableEq k], Fintype.card k = Q ^ 2 → ∀ ψ : AddChar k ℂ, ψ ≠ 1 →
      -m ≤ (∑ u ∈ Finset.univ.filter (fun u : k => u ^ (Q + 1) = 1), ψ u).re) :
    CharBound P 1 (m / ((Q : ℝ) + 1)) := by
  classical
  intro hfin ψ hψ
  haveI hmax : (P.P ^ 1).IsMaximal := by rw [pow_one]; exact P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P ^ 1) := Ideal.Quotient.field (P.P ^ 1)
  haveI := finite_quot_pow P 1
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ 1) := Fintype.ofFinite _
  set σ : (𝓞 (fieldI F) ⧸ P.P ^ 1) →+* (𝓞 (fieldI F) ⧸ P.P ^ 1) :=
    Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) with hσdef
  have hσmk : ∀ x, σ (Ideal.Quotient.mk (P.P ^ 1) x) = Ideal.Quotient.mk (P.P ^ 1) (conjO F x) := fun x =>
    Ideal.quotientMap_mk
  have hσ : ∀ x, σ (σ x) = x := fun x => by
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
    rw [hσmk, hσmk, UpperHalf.conjO_conjO]
  have hne : σ ≠ RingHom.id _ := by
    intro h
    have h1 : σ (Ideal.Quotient.mk (P.P ^ 1) a) = Ideal.Quotient.mk (P.P ^ 1) a := by rw [h]; rfl
    rw [hσmk, ← sub_eq_zero, ← map_sub, Ideal.Quotient.eq_zero_iff_mem, pow_one] at h1
    exact ha h1
  have hcardk : Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1) = Q ^ 2 := by
    rw [← Nat.card_eq_fintype_card, ← hQ, pow_one]
  have hpow := StandingFive.involution_eq_pow σ hσ hne hcardk
  have hS : hfin.toFinset = Finset.univ.filter fun u : 𝓞 (fieldI F) ⧸ P.P ^ 1 => u ^ (Q + 1) = 1 := by
    ext u
    rw [Set.Finite.mem_toFinset, Finset.mem_filter]
    simp only [Finset.mem_univ, true_and]
    show u * σ u = 1 ↔ u ^ (Q + 1) = 1
    rw [hpow, ← pow_succ']
  have hW := hm (𝓞 (fieldI F) ⧸ P.P ^ 1) hcardk ψ hψ
  rw [hS, StandingFive.card_normOne hcardk]
  have hpos : (0 : ℝ) < (Q : ℝ) + 1 := by positivity
  have e : m / ((Q : ℝ) + 1) * ((Q + 1 : ℕ) : ℝ) = m := by
    push_cast
    field_simp
  rw [e]
  exact hW

/-- **The exclusions at dyadic `Q = 2^f`, `2 ≤ f ≤ 5`** (X26B-T1, `tools/x26b_uq_colour.py`): `U_Q` is four-colourable
by an `𝔽₂`-linear colouring — a codimension-2 `𝔽₂`-subspace of `𝔽_{Q²}` avoiding `μ_{Q+1}`. A closed statement about
finite fields; its proof is a certificate in a model of `𝔽_{Q²}` (as `Arith/Floor128`'s at `2¹⁴`). -/
private theorem colorable_four_dyadic_small {f : ℕ} (hf2 : 2 ≤ f) (hf5 : f ≤ 5) (k : Type) [Field k] [Fintype k]
    (hk : Fintype.card k = (2 ^ f) ^ 2) :
    (SimpleGraph.fromRel fun x y : k => (x - y) ^ (2 ^ f + 1) = 1).Colorable 4 :=
  -- FS131-ICM4: `Arith/DyadicCerts`' certificates, read through `Arith/BinaryField`'s bridge
  DyadicCerts.colorable_four_two_pow hf2 hf5 k hk

/-- **The exact spectrum at `Q = 64`** (X26B-T1: `λ_min(U₆₄) = −15`, ratio `3/16`): every non-trivial additive character of a
field of `64²` elements sums to real part at least `−15` over `μ₆₅`. A closed statement about finite fields, of
`Floor128.charSum_128_ge`'s shape at `2¹²`. -/
private theorem charSum_64_ge {k : Type} [Field k] [Fintype k] [DecidableEq k] (hcard : Fintype.card k = 64 ^ 2)
    (ψ : AddChar k ℂ) (hψ : ψ ≠ 1) :
    -(15 : ℝ) ≤ (∑ u ∈ Finset.univ.filter (fun u : k => u ^ (64 + 1) = 1), ψ u).re :=
  -- FS131-ICM4: `Arith/DyadicCerts`' class counts at degree 12, read through `Arith/BinaryField`'s bridge
  DyadicCerts.charSum_64_ge hcard ψ hψ

-- FS131-ICM3: **EN1-UQ4, the fourth-moment count** (`plans/FS131-EN1-derivation.md` § 7.3), over a field `k` of `Q²`
-- elements of characteristic 2: `uqSum b = Σ_{u ∈ μ} ψ(bu)`; `Σ_b uqSum(b)⁴ = |k|·N`, `N` the solutions of
-- `u₁ + u₂ + u₃ + u₄ = 0` in `μ⁴`; `N ≤ 3(Q + 1)²` (`r(s) ≤ 2` off `0`); `uqSum` is real and constant on `μ`.
section UQ4

open Finset

variable {k : Type} [Field k] [Fintype k] [DecidableEq k]

-- the norm-one set `μ = {u : u^(Q+1) = 1}`
private abbrev uqMu (k : Type) [Field k] [Fintype k] [DecidableEq k] (Q : ℕ) : Finset k :=
  univ.filter fun u : k => u ^ (Q + 1) = 1

-- for `s ≠ 0`, at most two `u ∈ μ` have `s + u ∈ μ`: `s^Q u² + s^{Q+1} u + s = 0`
private theorem card_shift_le_two {Q : ℕ} (hfrob : ∀ x y : k, (x + y) ^ Q = x ^ Q + y ^ Q) {s : k} (hs : s ≠ 0) :
    ((uqMu k Q).filter fun u => (s + u) ^ (Q + 1) = 1).card ≤ 2 := by
  classical
  set p : Polynomial k := Polynomial.C (s ^ Q) * Polynomial.X ^ 2 + Polynomial.C (s ^ (Q + 1)) * Polynomial.X +
    Polynomial.C s with hp
  have hcoeff : p.coeff 0 = s := by simp [hp]
  have hp0 : p ≠ 0 := fun h => hs (by rw [← hcoeff, h, Polynomial.coeff_zero])
  have hdeg : p.natDegree ≤ 2 := by
    rw [hp]
    compute_degree
  refine (Polynomial.card_le_degree_of_subset_roots ?_).trans hdeg
  intro u hu
  rw [Finset.mem_val, Finset.mem_filter, Finset.mem_filter] at hu
  obtain ⟨⟨-, hu1⟩, hsu⟩ := hu
  rw [Polynomial.mem_roots hp0, Polynomial.IsRoot.def, hp]
  simp only [Polynomial.eval_add, Polynomial.eval_mul, Polynomial.eval_C, Polynomial.eval_pow, Polynomial.eval_X]
  have h1 : (s ^ Q + u ^ Q) * (s + u) = 1 := by rw [← hfrob, ← pow_succ]; exact hsu
  linear_combination u * h1 - (s + u) * hu1

-- `uqSum(b) = Σ_{u ∈ μ} ψ(b u)`
private noncomputable def uqSum (ψ : AddChar k ℂ) (Q : ℕ) (b : k) : ℂ := ∑ u ∈ uqMu k Q, ψ (b * u)

-- the fourth moment: `Σ_b uqSum(b)⁴ = |k| · #{(p, q) ∈ (μ × μ)² : p₁ + p₂ + q₁ + q₂ = 0}`
private theorem sum_uqSum_pow_four (ψ : AddChar k ℂ) (hψ : ψ ≠ 1) (Q : ℕ) :
    ∑ b : k, uqSum ψ Q b ^ 4 = (Fintype.card k : ℂ) *
      (((uqMu k Q ×ˢ uqMu k Q) ×ˢ (uqMu k Q ×ˢ uqMu k Q)).filter fun z => z.1.1 + z.1.2 + (z.2.1 + z.2.2) = 0).card := by
  have hsq : ∀ b, uqSum ψ Q b ^ 2 = ∑ p ∈ uqMu k Q ×ˢ uqMu k Q, ψ (b * (p.1 + p.2)) := by
    intro b
    rw [uqSum, sq, Finset.sum_mul_sum, ← Finset.sum_product']
    refine Finset.sum_congr rfl fun p _ => ?_
    rw [← AddChar.map_add_eq_mul, mul_add]
  have h4 : ∀ b, uqSum ψ Q b ^ 4 = ∑ z ∈ (uqMu k Q ×ˢ uqMu k Q) ×ˢ (uqMu k Q ×ˢ uqMu k Q),
      ψ (b * (z.1.1 + z.1.2 + (z.2.1 + z.2.2))) := by
    intro b
    rw [show uqSum ψ Q b ^ 4 = uqSum ψ Q b ^ 2 * uqSum ψ Q b ^ 2 by ring, hsq, Finset.sum_mul_sum, ← Finset.sum_product']
    refine Finset.sum_congr rfl fun z _ => ?_
    rw [← AddChar.map_add_eq_mul]
    congr 1
    ring
  have hprim := AddChar.IsPrimitive.of_ne_one hψ
  rw [Finset.sum_congr rfl fun b _ => h4 b, Finset.sum_comm]
  rw [Finset.sum_congr rfl fun z _ => AddChar.sum_mulShift _ hprim]
  simp only [Nat.cast_ite, Nat.cast_zero]
  rw [Finset.sum_ite, Finset.sum_const_zero, add_zero, Finset.sum_const, nsmul_eq_mul, mul_comm]

-- in characteristic 2 a character takes the values `±1`
omit [Fintype k] [DecidableEq k] in
private theorem addChar_eq_ofReal_re [CharP k 2] (ψ : AddChar k ℂ) (x : k) : ψ x = ((ψ x).re : ℂ) := by
  have h : ψ x * ψ x = 1 := by rw [← AddChar.map_add_eq_mul, CharTwo.add_self_eq_zero, AddChar.map_zero_eq_one]
  rcases mul_self_eq_one_iff.1 h with h1 | h1 <;> rw [h1] <;> simp

private theorem uqSum_eq_ofReal_re [CharP k 2] (ψ : AddChar k ℂ) (Q : ℕ) (b : k) : uqSum ψ Q b = ((uqSum ψ Q b).re : ℂ) := by
  rw [uqSum, Complex.re_sum, Complex.ofReal_sum]
  exact Finset.sum_congr rfl fun u _ => addChar_eq_ofReal_re ψ _

-- `uqSum` is constant on `b·μ`: `u ↦ vu` permutes `μ`
private theorem uqSum_mul_mem (ψ : AddChar k ℂ) (Q : ℕ) {v : k} (hv : v ∈ uqMu k Q) (b : k) : uqSum ψ Q (b * v) = uqSum ψ Q b := by
  rw [Finset.mem_filter] at hv
  have hv0 : v ≠ 0 := by
    rintro rfl
    rw [zero_pow (Nat.succ_ne_zero Q)] at hv
    exact zero_ne_one hv.2
  rw [uqSum, uqSum]
  refine Finset.sum_nbij' (fun u => v * u) (fun u => v⁻¹ * u) ?_ ?_ ?_ ?_ ?_
  · intro u hu
    rw [Finset.mem_filter] at hu ⊢
    exact ⟨Finset.mem_univ _, by rw [mul_pow, hv.2, hu.2, one_mul]⟩
  · intro u hu
    rw [Finset.mem_filter] at hu ⊢
    exact ⟨Finset.mem_univ _, by rw [mul_pow, inv_pow, hv.2, hu.2, inv_one, one_mul]⟩
  · intro u _
    show v⁻¹ * (v * u) = u
    rw [← mul_assoc, inv_mul_cancel₀ hv0, one_mul]
  · intro u _
    show v * (v⁻¹ * u) = u
    rw [← mul_assoc, mul_inv_cancel₀ hv0, one_mul]
  · intro u _
    show ψ (b * v * u) = ψ (b * (v * u))
    rw [mul_assoc]

-- the count: `N ≤ 3(Q + 1)²` (a pair `p` with `p₁ ≠ p₂` has at most two completions, `p₁ = p₂` at most `Q + 1`)
private theorem card_quad_le [CharP k 2] {Q : ℕ} (hfrob : ∀ x y : k, (x + y) ^ Q = x ^ Q + y ^ Q)
    (hμ : (uqMu k Q).card = Q + 1) :
    (((uqMu k Q ×ˢ uqMu k Q) ×ˢ (uqMu k Q ×ˢ uqMu k Q)).filter fun z => z.1.1 + z.1.2 + (z.2.1 + z.2.2) = 0).card ≤
      3 * (Q + 1) ^ 2 := by
  classical
  set A := uqMu k Q with hA
  have e : (((A ×ˢ A) ×ˢ (A ×ˢ A)).filter fun z => z.1.1 + z.1.2 + (z.2.1 + z.2.2) = 0).card =
      ∑ p ∈ A ×ˢ A, ((A ×ˢ A).filter fun q => p.1 + p.2 + (q.1 + q.2) = 0).card := by
    rw [Finset.card_eq_sum_ones, Finset.sum_filter, Finset.sum_product]
    refine Finset.sum_congr rfl fun p _ => ?_
    rw [Finset.card_eq_sum_ones, Finset.sum_filter]
  have hp : ∀ p ∈ A ×ˢ A, ((A ×ˢ A).filter fun q => p.1 + p.2 + (q.1 + q.2) = 0).card ≤
      2 + (if p.1 = p.2 then Q + 1 else 0) := by
    intro p _
    have hle : ((A ×ˢ A).filter fun q => p.1 + p.2 + (q.1 + q.2) = 0).card ≤
        (A.filter fun u => (p.1 + p.2 + u) ^ (Q + 1) = 1).card := by
      refine Finset.card_le_card_of_injOn (fun q => q.1) ?_ ?_
      · intro q hq
        rw [Finset.mem_coe, Finset.mem_filter, Finset.mem_product] at hq
        rw [Finset.mem_coe, Finset.mem_filter]
        have h2 : q.2 = p.1 + p.2 + q.1 := by
          have := hq.2
          rw [← CharTwo.neg_eq (p.1 + p.2 + q.1)]
          linear_combination this
        refine ⟨hq.1.1, ?_⟩
        have hq2 := hq.1.2
        rw [hA, Finset.mem_filter] at hq2
        rw [← h2]
        exact hq2.2
      · intro q hq q' hq' h
        rw [Finset.mem_coe, Finset.mem_filter] at hq hq'
        have h2 : q.2 = p.1 + p.2 + q.1 := by
          rw [← CharTwo.neg_eq (p.1 + p.2 + q.1)]
          linear_combination hq.2
        have h2' : q'.2 = p.1 + p.2 + q'.1 := by
          rw [← CharTwo.neg_eq (p.1 + p.2 + q'.1)]
          linear_combination hq'.2
        have h1 : q.1 = q'.1 := h
        exact Prod.ext h1 (by rw [h2, h2', h1])
    refine hle.trans ?_
    split_ifs with heq
    · exact (Finset.card_filter_le _ _).trans (by rw [hμ]; omega)
    · have hc : p.1 + p.2 ≠ 0 := by
        intro h0
        apply heq
        rw [← CharTwo.neg_eq p.2]
        linear_combination h0
      exact (card_shift_le_two hfrob hc).trans (by omega)
  have hdiag : ((A ×ˢ A).filter fun p : k × k => p.1 = p.2).card = Q + 1 := by
    rw [← hμ]
    refine Finset.card_nbij' (fun p => p.1) (fun u => (u, u)) ?_ ?_ ?_ ?_
    · intro p hp
      rw [Finset.mem_coe, Finset.mem_filter, Finset.mem_product] at hp
      exact hp.1.1
    · intro u hu
      rw [Finset.mem_coe] at hu
      rw [Finset.mem_coe, Finset.mem_filter, Finset.mem_product]
      exact ⟨⟨hu, hu⟩, rfl⟩
    · intro p hp
      rw [Finset.mem_coe, Finset.mem_filter] at hp
      exact Prod.ext rfl hp.2
    · intro u _
      rfl
  rw [e]
  refine (Finset.sum_le_sum hp).trans ?_
  rw [Finset.sum_add_distrib, Finset.sum_const, Finset.sum_ite, Finset.sum_const, Finset.sum_const_zero, add_zero,
    hdiag, Finset.card_product, hμ, smul_eq_mul, smul_eq_mul]
  nlinarith

-- the arithmetic: `t³ + s⁴ ≤ 3(t − 1)²t` with `t ≥ 257` gives `s ≥ −3t/10`
private theorem fourth_moment_arith {t s : ℝ} (ht : 257 ≤ t) (h : t ^ 4 + t * s ^ 4 ≤ 3 * (t - 1) ^ 2 * t ^ 2) :
    -(3 * t / 10) ≤ s := by
  by_contra hlt
  push Not at hlt
  have ht0 : 0 < t := by linarith
  have hc : 0 < 3 * t / 10 := by positivity
  have hs : 3 * t / 10 < -s := by linarith
  have h4 : (3 * t / 10) ^ 4 < (-s) ^ 4 := pow_lt_pow_left₀ hs hc.le (by norm_num)
  have h4' : (-s) ^ 4 = s ^ 4 := by ring
  rw [h4'] at h4
  have h1 : t ^ 3 + s ^ 4 ≤ 3 * (t - 1) ^ 2 * t := by
    have := h
    have e : t ^ 4 + t * s ^ 4 = t * (t ^ 3 + s ^ 4) := by ring
    have e2 : 3 * (t - 1) ^ 2 * t ^ 2 = t * (3 * (t - 1) ^ 2 * t) := by ring
    rw [e, e2] at this
    exact le_of_mul_le_mul_left this ht0
  have h2 : 81 * t ^ 4 < 10000 * (2 * t ^ 3 - 6 * t ^ 2 + 3 * t) := by nlinarith
  have h3 : 81 * t ^ 3 < 10000 * (2 * t ^ 2 - 6 * t + 3) := by
    have e : 81 * t ^ 4 = t * (81 * t ^ 3) := by ring
    have e2 : 10000 * (2 * t ^ 3 - 6 * t ^ 2 + 3 * t) = t * (10000 * (2 * t ^ 2 - 6 * t + 3)) := by ring
    rw [e, e2] at h2
    exact lt_of_mul_lt_mul_left h2 ht0.le
  have h5 : 81 * 257 * t ^ 2 ≤ 81 * t ^ 3 := by
    have : 0 ≤ t ^ 2 := sq_nonneg t
    nlinarith
  nlinarith

end UQ4

/-- **The fourth-moment count at `Q = 2^f ≥ 256`** (EN1-UQ4, `plans/FS131-EN1-derivation.md` § 7.3): every non-trivial
eigenvalue `λ` of `U_Q` has `|λ|⁴ ≤ 2Q³ − 2Q² − 3Q − 1`, so `λ ≥ −(3/10)(Q + 1)`. A closed statement about finite fields
of characteristic 2. -/
private theorem charSum_dyadic_large {f : ℕ} (hf : 8 ≤ f) {k : Type} [Field k] [Fintype k] [DecidableEq k]
    (hcard : Fintype.card k = (2 ^ f) ^ 2) (ψ : AddChar k ℂ) (hψ : ψ ≠ 1) :
    -(3 * (((2 ^ f : ℕ) : ℝ) + 1) / 10) ≤
      (∑ u ∈ Finset.univ.filter (fun u : k => u ^ (2 ^ f + 1) = 1), ψ u).re := by
  classical
  set Q := 2 ^ f with hQdef
  -- characteristic 2
  haveI : CharP k 2 := by
    refine CharTwo.of_one_ne_zero_of_two_eq_zero one_ne_zero ?_
    have h := FiniteField.cast_card_eq_zero k
    rw [hcard, hQdef, ← pow_mul] at h
    push_cast at h
    exact pow_eq_zero_iff (by omega) |>.1 h
  haveI : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  have hfrob : ∀ x y : k, (x + y) ^ Q = x ^ Q + y ^ Q := fun x y => add_pow_char_pow x y 2 f
  have hμ : (uqMu k Q).card = Q + 1 := HadwigerNelson.StandingFive.card_normOne hcard
  -- the fourth moment, in `ℝ`
  set s : k → ℝ := fun b => (uqSum ψ Q b).re with hsdef
  have hS : ∀ b, uqSum ψ Q b = (s b : ℂ) := fun b => uqSum_eq_ofReal_re ψ Q b
  have hmom : ∑ b : k, s b ^ 4 = (Fintype.card k : ℝ) *
      (((uqMu k Q ×ˢ uqMu k Q) ×ˢ (uqMu k Q ×ˢ uqMu k Q)).filter fun z => z.1.1 + z.1.2 + (z.2.1 + z.2.2) = 0).card := by
    have h := sum_uqSum_pow_four ψ hψ Q
    simp only [hS] at h
    exact_mod_cast h
  have hN := card_quad_le hfrob hμ
  -- the class of `1`: `s v = s 1` on `μ`, and `s 0 = Q + 1`
  have hs0 : s 0 = Q + 1 := by
    rw [hsdef]
    simp only [uqSum, zero_mul, AddChar.map_zero_eq_one, Finset.sum_const, nsmul_eq_mul, mul_one, Complex.natCast_re]
    rw [hμ]
    push_cast
    ring
  have hsv : ∀ v ∈ uqMu k Q, s v = s 1 := fun v hv => by
    rw [hsdef]
    simp only
    rw [← uqSum_mul_mem ψ Q hv 1, one_mul]
  have h0 : (0 : k) ∉ uqMu k Q := by
    rw [Finset.mem_filter]
    rintro ⟨-, h⟩
    rw [zero_pow (Nat.succ_ne_zero Q)] at h
    exact zero_ne_one h
  have hlow : s 0 ^ 4 + (Q + 1 : ℝ) * s 1 ^ 4 ≤ ∑ b : k, s b ^ 4 := by
    have hsub : insert 0 (uqMu k Q) ⊆ Finset.univ := Finset.subset_univ _
    refine le_trans ?_ (Finset.sum_le_sum_of_subset_of_nonneg hsub fun b _ _ => by positivity)
    rw [Finset.sum_insert h0, Finset.sum_congr rfl fun v hv => by rw [hsv v hv], Finset.sum_const, hμ, nsmul_eq_mul]
    push_cast
    rfl
  -- assemble
  have hQ256 : (256 : ℝ) ≤ Q := by
    have : 2 ^ 8 ≤ 2 ^ f := Nat.pow_le_pow_right (by norm_num) hf
    exact_mod_cast (by simpa [hQdef] using this)
  have hcardR : (Fintype.card k : ℝ) = (Q : ℝ) ^ 2 := by rw [hcard]; push_cast; ring
  have hNR : ((((uqMu k Q ×ˢ uqMu k Q) ×ˢ (uqMu k Q ×ˢ uqMu k Q)).filter fun z => z.1.1 + z.1.2 + (z.2.1 + z.2.2) = 0).card : ℝ)
      ≤ 3 * ((Q : ℝ) + 1) ^ 2 := by exact_mod_cast hN
  have hkey : ((Q : ℝ) + 1) ^ 4 + ((Q : ℝ) + 1) * s 1 ^ 4 ≤ 3 * (((Q : ℝ) + 1) - 1) ^ 2 * ((Q : ℝ) + 1) ^ 2 := by
    have := hlow.trans hmom.le
    rw [hs0, hcardR] at this
    have hQ0 : (0 : ℝ) ≤ (Q : ℝ) ^ 2 := sq_nonneg _
    have := this.trans (mul_le_mul_of_nonneg_left hNR hQ0)
    nlinarith [this]
  have hfin := fourth_moment_arith (by linarith) hkey
  have htarget : (∑ u ∈ Finset.univ.filter (fun u : k => u ^ (Q + 1) = 1), ψ u).re = s 1 := by
    rw [hsdef]
    simp only [uqSum, one_mul]
  rw [htarget]
  exact hfin

/-- **The exclusions at dyadic `Q = 2^f`, `f ≤ 5`** (X26B-T1; FS131-ICM3): at a stable prime that conjugation moves
(`conjO a − a ∉ P`) with `|𝓞 ⧸ P| = (2^f)²`, `f ≤ 5`, the level-one target `Cay(k, {u : u^(Q+1) = 1})` is
four-colourable — one colour per residue at `Q = 2`, `U_Q`'s `𝔽₂`-linear colouring at `4 ≤ Q ≤ 32`. Public since
FS131-ICS1 (inventory item 1027). -/
theorem chromaticNumber_le_four_dyadic [NumberField F] (P : StablePrime F) {a : 𝓞 (fieldI F)}
    (ha : conjO F a - a ∉ P.P) {f : ℕ} (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = (2 ^ f) ^ 2) (hf : f ≤ 5) :
    (levelTarget P 1).chromaticNumber ≤ 4 := by
  classical
  haveI hmax : (P.P ^ 1).IsMaximal := by rw [pow_one]; exact P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P ^ 1) := Ideal.Quotient.field (P.P ^ 1)
  haveI := finite_quot_pow P 1
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ 1) := Fintype.ofFinite _
  have hcardk : Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1) = (2 ^ f) ^ 2 := by
    rw [← Nat.card_eq_fintype_card, ← hQ, pow_one]
  rcases (show f = 0 ∨ f = 1 ∨ 2 ≤ f by omega) with hf0 | hf1 | hf2
  · -- `|k| = 1` is not a field
    exfalso
    have h1 := Fintype.one_lt_card (α := 𝓞 (fieldI F) ⧸ P.P ^ 1)
    rw [hcardk, hf0] at h1
    norm_num at h1
  · -- `|k| = 4`: one colour per element
    have hc := (levelTarget P 1).colorable_of_fintype
    rw [hcardk, hf1] at hc
    exact hc.chromaticNumber_le
  · set σ : (𝓞 (fieldI F) ⧸ P.P ^ 1) →+* (𝓞 (fieldI F) ⧸ P.P ^ 1) :=
      Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) with hσdef
    have hσmk : ∀ x, σ (Ideal.Quotient.mk (P.P ^ 1) x) = Ideal.Quotient.mk (P.P ^ 1) (conjO F x) := fun x =>
      Ideal.quotientMap_mk
    have hσ : ∀ x, σ (σ x) = x := fun x => by
      obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
      rw [hσmk, hσmk, UpperHalf.conjO_conjO]
    have hne : σ ≠ RingHom.id _ := by
      intro h
      have h1 : σ (Ideal.Quotient.mk (P.P ^ 1) a) = Ideal.Quotient.mk (P.P ^ 1) a := by rw [h]; rfl
      rw [hσmk, ← sub_eq_zero, ← map_sub, Ideal.Quotient.eq_zero_iff_mem, pow_one] at h1
      exact ha h1
    have hpow := StandingFive.involution_eq_pow σ hσ hne hcardk
    have hle : levelTarget P 1 ≤ SimpleGraph.fromRel fun x y : 𝓞 (fieldI F) ⧸ P.P ^ 1 => (x - y) ^ (2 ^ f + 1) = 1 := by
      intro x y hxy
      rw [levelTarget, SimpleGraph.fromRel_adj] at hxy
      rw [SimpleGraph.fromRel_adj]
      refine ⟨hxy.1, ?_⟩
      have e : ∀ z, z * σ z = z ^ (2 ^ f + 1) := fun z => by rw [hpow, ← pow_succ']
      rcases hxy.2 with h | h
      · exact Or.inl (by rw [← e]; exact h)
      · exact Or.inr (by rw [← e]; exact h)
    exact ((colorable_four_dyadic_small hf2 hf _ hcardk).mono_left hle).chromaticNumber_le

/-- **The dyadic branch** (KR1 § 2.6 (c): `Q = 64` exact, `128` by `Floor128`, `Q ≥ 256` by EN1-UQ4): an unramified dyadic
stable prime whose level-one target needs five colours has an all-levels ratio below `1/4`. -/
private theorem ratioAtMost_dyadic [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∈ P.P)
    (hP : ¬ IsRamified P) (h : 5 ≤ (levelTarget P 1).chromaticNumber) : ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := by
  -- FS131-ICM3: by residue size `Q = 2^f`, then Lemma P with no unit `2`
  classical
  obtain ⟨a, ha⟩ : ∃ a : 𝓞 (fieldI F), conjO F a - a ∉ P.P := by
    by_contra hcon
    push Not at hcon
    exact hP hcon
  obtain ⟨f, hQ⟩ := exists_card_two_pow_sq P h2 ha
  have hlevel : ∃ κ : ℝ, κ < 1 / 3 ∧ 2 / (((2 ^ f : ℕ) : ℝ) + 1) ≤ κ ∧ CharBound P 1 κ := by
    rcases (show f ≤ 5 ∨ f = 6 ∨ f = 7 ∨ 8 ≤ f by omega) with hf | hf | hf | hf
    · exact absurd (h.trans (chromaticNumber_le_four_dyadic P ha hQ hf)) (by norm_num)
    · subst hf
      refine ⟨15 / (((2 ^ 6 : ℕ) : ℝ) + 1), by norm_num, by norm_num, charBound_one_of_charSum P ha hQ ?_⟩
      intro k _ _ _ hk ψ hψ
      exact charSum_64_ge hk ψ hψ
    · subst hf
      refine ⟨19 / (((2 ^ 7 : ℕ) : ℝ) + 1), by norm_num, by norm_num, charBound_one_of_charSum P ha hQ ?_⟩
      intro k _ _ _ hk ψ hψ
      exact Floor128.charSum_128_ge hk ψ hψ
    · have hQ1 : (0 : ℝ) < ((2 ^ f : ℕ) : ℝ) + 1 := by positivity
      have h256 : (256 : ℝ) ≤ ((2 ^ f : ℕ) : ℝ) := by
        have : 2 ^ 8 ≤ 2 ^ f := Nat.pow_le_pow_right (by norm_num) hf
        exact_mod_cast (by simpa using this)
      refine ⟨3 * (((2 ^ f : ℕ) : ℝ) + 1) / 10 / (((2 ^ f : ℕ) : ℝ) + 1), ?_, ?_,
        charBound_one_of_charSum P ha hQ fun k _ _ _ hk ψ hψ => charSum_dyadic_large hf hk ψ hψ⟩
      · rw [div_lt_iff₀ hQ1]; linarith
      · rw [div_le_div_iff₀ hQ1 hQ1]; nlinarith
  obtain ⟨κ, hκ3, hκQ, hκ1⟩ := hlevel
  have hκ0 : 0 ≤ κ := le_trans (by positivity) hκQ
  refine ⟨κ / (1 + κ), ?_, ratioAtMost_of_charBound P hκ0 fun _ hm => charBound_of_charBound_oneT P ha hQ hκQ hκ1 hm⟩
  rw [div_lt_iff₀ (by linarith)]
  linarith

/-- **The large dyadic branch** (KR1 § 2.6 (c); X26B-T1; EN1-UQ4): at a stable prime that conjugation moves
(`conjO a − a ∉ P`) with `|𝓞 ⧸ P| = (2^f)²` and `f ≥ 6` — a dyadic inert place of norm at least `64²` — the all-levels
ratio is below `1/4`, with no colouring hypothesis: level one by the exact spectrum at `Q = 64`, `Floor128` at `128`, the
fourth-moment count at `Q ≥ 256`; Lemma P with no unit `2` carries it to every level. `ratioAtMost_dyadic`'s `f ≥ 6`
branch, stated alone (FS131-ICS1, inventory item 1027). -/
theorem ratioAtMost_dyadic_of_six_le [NumberField F] (P : StablePrime F) {a : 𝓞 (fieldI F)}
    (ha : conjO F a - a ∉ P.P) {f : ℕ} (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = (2 ^ f) ^ 2) (hf : 6 ≤ f) :
    ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := by
  classical
  have hlevel : ∃ κ : ℝ, κ < 1 / 3 ∧ 2 / (((2 ^ f : ℕ) : ℝ) + 1) ≤ κ ∧ CharBound P 1 κ := by
    rcases (show f = 6 ∨ f = 7 ∨ 8 ≤ f by omega) with hf | hf | hf
    · subst hf
      refine ⟨15 / (((2 ^ 6 : ℕ) : ℝ) + 1), by norm_num, by norm_num, charBound_one_of_charSum P ha hQ ?_⟩
      intro k _ _ _ hk ψ hψ
      exact charSum_64_ge hk ψ hψ
    · subst hf
      refine ⟨19 / (((2 ^ 7 : ℕ) : ℝ) + 1), by norm_num, by norm_num, charBound_one_of_charSum P ha hQ ?_⟩
      intro k _ _ _ hk ψ hψ
      exact Floor128.charSum_128_ge hk ψ hψ
    · have hQ1 : (0 : ℝ) < ((2 ^ f : ℕ) : ℝ) + 1 := by positivity
      have h256 : (256 : ℝ) ≤ ((2 ^ f : ℕ) : ℝ) := by
        have : 2 ^ 8 ≤ 2 ^ f := Nat.pow_le_pow_right (by norm_num) hf
        exact_mod_cast (by simpa using this)
      refine ⟨3 * (((2 ^ f : ℕ) : ℝ) + 1) / 10 / (((2 ^ f : ℕ) : ℝ) + 1), ?_, ?_,
        charBound_one_of_charSum P ha hQ fun k _ _ _ hk ψ hψ => charSum_dyadic_large hf hk ψ hψ⟩
      · rw [div_lt_iff₀ hQ1]; linarith
      · rw [div_le_div_iff₀ hQ1 hQ1]; nlinarith
  obtain ⟨κ, hκ3, hκQ, hκ1⟩ := hlevel
  have hκ0 : 0 ≤ κ := le_trans (by positivity) hκQ
  refine ⟨κ / (1 + κ), ?_, ratioAtMost_of_charBound P hκ0 fun _ hm => charBound_of_charBound_oneT P ha hQ hκQ hκ1 hm⟩
  rw [div_lt_iff₀ (by linarith)]
  linarith

/-- **The exclusions at `q ∈ {3, 7}`** (KR1 § 2.6 (a)): there the level-one target is four-colourable (`Γ₃`, `Γ₇`).
Public since FS131-ICS1 (inventory item 1027). -/
theorem chromaticNumber_le_four_of_small [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P)
    {Q : ℕ} (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hQ37 : Q = 3 ∨ Q = 7) :
    (levelTarget P 1).chromaticNumber ≤ 4 := by
  classical
  haveI hmax : (P.P ^ 1).IsMaximal := by rw [pow_one]; exact P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P ^ 1) := Ideal.Quotient.field (P.P ^ 1)
  haveI := finite_quot_pow P 1
  set σ : (𝓞 (fieldI F) ⧸ P.P ^ 1) →+* (𝓞 (fieldI F) ⧸ P.P ^ 1) :=
    Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) with hσdef
  have hσmk : ∀ x, σ (Ideal.Quotient.mk (P.P ^ 1) x) = Ideal.Quotient.mk (P.P ^ 1) (conjO F x) := fun x =>
    Ideal.quotientMap_mk
  have hσ : ∀ x, σ (σ x) = x := fun x => by
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
    rw [hσmk, hσmk, UpperHalf.conjO_conjO]
  obtain ⟨i, hi2, hci⟩ := UpperHalf.exists_I_integer (F := F)
  have h2k : (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1) ≠ 0 := by
    rw [← map_ofNat (Ideal.Quotient.mk (P.P ^ 1)) 2, Ne, Ideal.Quotient.eq_zero_iff_mem, pow_one]; exact h2
  set ι := Ideal.Quotient.mk (P.P ^ 1) i with hιdef
  have hι : ι ^ 2 = -1 := by rw [hιdef, ← map_pow, hi2, map_neg, map_one]
  have hσι : σ ι = -ι := by rw [hιdef, hσmk, hci, map_neg]
  obtain ⟨hcard0, -⟩ := StandingFive.card_fixed_of_involution σ hσ hι hσι h2k
  set k₀ := σ.eqLocusField (RingHom.id _) with hk₀def
  have hk₀ : Nat.card k₀ = Q := by
    have e : Nat.card k₀ ^ 2 = Q ^ 2 := by rw [← hcard0, ← hQ, pow_one]
    exact Nat.pow_left_injective two_ne_zero e
  set u : 𝓞 (fieldI F) ⧸ P.P ^ 1 := (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1)⁻¹ with hudef
  have hu : 2 * u = 1 := mul_inv_cancel₀ h2k
  have hσu : σ u = u := by rw [hudef, map_inv₀, map_ofNat]
  -- the coordinates `x = a + bι` with `a, b` fixed by `σ`
  have ha : ∀ x, u * (x + σ x) ∈ k₀ := fun x => by
    show σ (u * (x + σ x)) = u * (x + σ x)
    rw [map_mul, map_add, hσ, hσu]; ring
  have hb : ∀ x, -(u * ι * (x - σ x)) ∈ k₀ := fun x => by
    show σ (-(u * ι * (x - σ x))) = -(u * ι * (x - σ x))
    rw [map_neg, map_mul, map_mul, map_sub, hσ, hσu, hσι]; ring
  let φ : levelTarget P 1 →g unitQuadrance k₀ :=
    { toFun := fun x => (⟨_, ha x⟩, ⟨_, hb x⟩)
      map_rel' := by
        intro x y hxy
        rw [unitQuadrance_adj]
        obtain ⟨hne, hN⟩ := (SimpleGraph.fromRel_adj _ _ _).1 hxy
        have hN' : (x - y) * σ (x - y) = 1 := by
          rcases hN with h | h
          · exact h
          · have e : (y - x) * σ (y - x) = (x - y) * σ (x - y) := by rw [map_sub, map_sub]; ring
            rw [← e]; exact h
        refine ⟨fun heq => hne ?_, ?_⟩
        · have h1 := congrArg (fun p : k₀ × k₀ => (p.1 : 𝓞 (fieldI F) ⧸ P.P ^ 1)) heq
          have h2' := congrArg (fun p : k₀ × k₀ => (p.2 : 𝓞 (fieldI F) ⧸ P.P ^ 1)) heq
          simp only at h1 h2'
          linear_combination h1 + ι * h2' - (x - y) * hu + u * (x - y - (σ x - σ y)) * hι
        · apply Subtype.ext
          push_cast
          rw [map_sub] at hN'
          linear_combination (2 * u + 1) * (x - y) * (σ x - σ y) * hu + hN' +
            u ^ 2 * (x - y - (σ x - σ y)) ^ 2 * hι }
  haveI : Fact Q.Prime := ⟨by rcases hQ37 with rfl | rfl <;> norm_num⟩
  obtain ⟨e⟩ := Arith.nonempty_ringEquiv_zmod_of_card (Fact.out : Q.Prime) hk₀
  have hcol : (finitePlane Q).Colorable 4 := by
    rcases hQ37 with rfl | rfl
    · exact finitePlane3_colorable_three.mono (by norm_num)
    · exact ⟨SimpleGraph.Coloring.mk GapSeven.gamma fun {u v} h => GapSeven.gamma_proper u v h⟩
  exact (hcol.of_hom ((unitQuadrance.map e.toRingHom).comp φ)).chromaticNumber_le

/-- **Hensel's count in the certificate link's words** (FS131-IKL1): at a stable prime not above `2` with
`|𝓞 ⧸ P| = Q²`, every norm-one residue at level one has `Q^n` norm-one lifts at level `n + 1` (`card_res_fibreT` at
`θ = i`, `exists_conj_sub_notMem`). -/
theorem henselCount_of_two_notMem [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) : CertLink.HenselCount P Q :=
  fun n hfin _ ht => card_res_fibreT P (exists_conj_sub_notMem P h2).choose_spec hQ n hfin ht

/-- **The bound on new characters in the certificate link's words** (FS131-IKL1; FS-66's L1): at a stable prime not
above `2` with `|𝓞 ⧸ P| = Q²`, a character of level `n + 1` not trivial on the kernel of the map to level one sums to at
most `2Q^n` in modulus over the norm-one set (`norm_charSum_le_of_resT` at `θ = i`, and `|S_{n+1}| = Q^n(Q + 1)`,
`card_levelSet_succT`). -/
theorem newCharBound_of_two_notMem [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) : CertLink.NewCharBound P Q := by
  intro n hfin ψ hψ
  have ha := (exists_conj_sub_notMem P h2).choose_spec
  have hb := norm_charSum_le_of_resT P ha hQ n hfin ψ hψ
  rw [card_levelSet_succT P ha hQ n hfin] at hb
  have hQ1 : (0 : ℝ) < (Q : ℝ) + 1 := by positivity
  refine hb.trans (le_of_eq ?_)
  push_cast
  field_simp

-- FS131-ICO1: **Lemma P with norms** — a level-one bound in modulus, `κ ≥ 2/(Q + 1)`, holds at every level in modulus
-- (`charBound_of_charBound_oneT`'s induction, with norms in place of real parts).
private theorem norm_charSum_le_of_one [NumberField F] (P : StablePrime F) {a : 𝓞 (fieldI F)} (ha : conjO F a - a ∉ P.P)
    {Q : ℕ} (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) {κ : ℝ} (hκ : 2 / ((Q : ℝ) + 1) ≤ κ)
    (h1 : ∀ (hfin : (levelSet P 1).Finite) (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ 1) ℂ), ψ ≠ 1 →
      ‖∑ s ∈ hfin.toFinset, ψ s‖ ≤ κ * hfin.toFinset.card) (n : ℕ) :
    ∀ (hfin : (levelSet P (n + 1)).Finite) (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) ℂ), ψ ≠ 1 →
      ‖∑ s ∈ hfin.toFinset, ψ s‖ ≤ κ * hfin.toFinset.card := by
  classical
  induction n with
  | zero => exact h1
  | succ n ih =>
    intro hfin ψ hψ
    haveI := finite_quot_pow P (n + 1)
    have hfin' : (levelSet P (n + 1)).Finite := Set.toFinite _
    have hmaps : ∀ x ∈ hfin.toFinset, red P n x ∈ hfin'.toFinset := fun x hx =>
      hfin'.mem_toFinset.2 (red_mem_levelSet P n (hfin.mem_toFinset.1 hx))
    by_cases hK : ∀ e, red P n e = 0 → ψ e = 1
    · obtain ⟨ψ', hψ'⟩ := exists_addChar_descent P n ψ hK
      have hψ'1 : ψ' ≠ 1 := by
        intro h
        apply hψ
        ext x
        rw [hψ' x, h, AddChar.one_apply, AddChar.one_apply]
      have hsum : ∑ s ∈ hfin.toFinset, ψ s = ((Q : ℝ) : ℂ) * ∑ t ∈ hfin'.toFinset, ψ' t := by
        rw [← Finset.sum_fiberwise_of_maps_to hmaps, Finset.mul_sum]
        refine Finset.sum_congr rfl fun t ht => ?_
        have hc : ∀ x ∈ hfin.toFinset.filter (fun x => red P n x = t), ψ x = ψ' t := fun x hx => by
          rw [hψ' x, (Finset.mem_filter.1 hx).2]
        rw [Finset.sum_congr rfl hc, Finset.sum_const, card_fibreT P ha hQ n hfin (hfin'.mem_toFinset.1 ht),
          nsmul_eq_mul]
        push_cast
        ring
      have hcard : (hfin.toFinset.card : ℝ) = Q * hfin'.toFinset.card := by
        rw [Finset.card_eq_sum_card_fiberwise hmaps,
          Finset.sum_congr rfl fun t ht => card_fibreT P ha hQ n hfin (hfin'.mem_toFinset.1 ht)]
        rw [Finset.sum_const, smul_eq_mul]
        push_cast
        ring
      have hih := ih hfin' ψ' hψ'1
      rw [hsum, norm_mul, Complex.norm_real, Real.norm_of_nonneg (Nat.cast_nonneg _), hcard]
      have hQ0 : (0 : ℝ) ≤ Q := Nat.cast_nonneg _
      calc (Q : ℝ) * ‖∑ t ∈ hfin'.toFinset, ψ' t‖ ≤ Q * (κ * hfin'.toFinset.card) :=
            mul_le_mul_of_nonneg_left hih hQ0
        _ = κ * (Q * hfin'.toFinset.card) := by ring
    · push Not at hK
      obtain ⟨e, he, hψe⟩ := hK
      have hb := norm_charSum_new_leT P ha hQ n hfin ψ ⟨e, he, hψe⟩
      have hc : (0 : ℝ) ≤ hfin.toFinset.card := Nat.cast_nonneg _
      exact hb.trans (mul_le_mul_of_nonneg_right hκ hc)

/-- **FS-66's fibre-share bound at `p = 19`, in the certificate link's words** (FS131-LCH1, from FS131-IKL1's draft): some
`U < 361/4` bounds `∑ φ` over `(ℤ/19)²` for every `φ` with values in `[0, 1]` and `qform 19 φ ≥ 0`
(`FibreCertSound.sum_le_nineteen`, the p = 19 certificate checked by the kernel). -/
theorem _root_.HadwigerNelson.CertLink.exists_fibreShareBound_nineteen :
    ∃ U : ℝ, U < 361 / 4 ∧ CertLink.FibreShareBound 19 U :=
  ⟨_, by norm_num, FibreCertSound.sum_le_nineteen⟩

/-- **The certificate branch at `q ∈ {11, 19}`**: `CertLink.ratioAtMost_cert_link` with Hensel's count
and the bound on new characters from Lemma P (`henselCount_of_two_notMem`, `newCharBound_of_two_notMem`) and FS-66's
bound at 19 (`FibreCertSound.sum_le_nineteen`). -/
private theorem ratioAtMost_cert [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hQ1119 : Q = 11 ∨ Q = 19) :
    ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c :=
  CertLink.ratioAtMost_cert_link P h2 hQ hQ1119 (henselCount_of_two_notMem P h2 hQ) (newCharBound_of_two_notMem P h2 hQ) CertLink.exists_fibreShareBound_nineteen

-- FS131-ICM2: **the level-one bound at a prime `Q`, in coordinates.** Through `k = k₀ ⊕ k₀ι` and `k₀ ≅ ZMod Q`, a character
-- of the residue field is `x ↦ ζ^{αA(x) + βB(x)}` (`ζ = e^{2πi/Q}`, `(α, β) ≠ 0`), and the norm-one set is carried onto the
-- circle `a² + b² = 1` of `UD(𝔽_Q, 2)`; so a lower bound on the circle's cosine sums is the level-one character bound.
open Classical in
private theorem charBound_one_of_circleCos [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P)
    {Q : ℕ} (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hp : Q.Prime) [NeZero Q] {κ : ℝ}
    (hcos : ∀ α β : ℕ, α < Q → β < Q → (α ≠ 0 ∨ β ≠ 0) →
      -(κ * ((Q : ℝ) + 1)) ≤ ∑ v ∈ Finset.univ.filter (fun v : ZMod Q × ZMod Q => v.1 ^ 2 + v.2 ^ 2 = 1),
        Real.cos (2 * Real.pi * (((α * v.1.val + β * v.2.val) % Q : ℕ) : ℝ) / Q)) :
    CharBound P 1 κ := by
  intro hfin ψ hψ
  rw [card_levelSet_oneT P (exists_conj_sub_notMem P h2).choose_spec hQ hfin]
  haveI hmax : (P.P ^ 1).IsMaximal := by rw [pow_one]; exact P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P ^ 1) := Ideal.Quotient.field (P.P ^ 1)
  haveI := finite_quot_pow P 1
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ 1) := Fintype.ofFinite _
  set σ : (𝓞 (fieldI F) ⧸ P.P ^ 1) →+* (𝓞 (fieldI F) ⧸ P.P ^ 1) :=
    Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) with hσdef
  have hσmk : ∀ x, σ (Ideal.Quotient.mk (P.P ^ 1) x) = Ideal.Quotient.mk (P.P ^ 1) (conjO F x) := fun x =>
    Ideal.quotientMap_mk
  have hσ : ∀ x, σ (σ x) = x := fun x => by
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
    rw [hσmk, hσmk, UpperHalf.conjO_conjO]
  obtain ⟨i, hi2, hci⟩ := UpperHalf.exists_I_integer (F := F)
  have h2k : (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1) ≠ 0 := by
    rw [← map_ofNat (Ideal.Quotient.mk (P.P ^ 1)) 2, Ne, Ideal.Quotient.eq_zero_iff_mem, pow_one]; exact h2
  set ι := Ideal.Quotient.mk (P.P ^ 1) i with hιdef
  have hι : ι ^ 2 = -1 := by rw [hιdef, ← map_pow, hi2, map_neg, map_one]
  have hσι : σ ι = -ι := by rw [hιdef, hσmk, hci, map_neg]
  obtain ⟨hcard0, -⟩ := StandingFive.card_fixed_of_involution σ hσ hι hσι h2k
  set k₀ := σ.eqLocusField (RingHom.id _) with hk₀def
  have hk₀ : Nat.card k₀ = Q := by
    have e : Nat.card k₀ ^ 2 = Q ^ 2 := by rw [← hcard0, ← hQ, pow_one]
    exact Nat.pow_left_injective two_ne_zero e
  set u : 𝓞 (fieldI F) ⧸ P.P ^ 1 := (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1)⁻¹ with hudef
  have hu : 2 * u = 1 := mul_inv_cancel₀ h2k
  have hσu : σ u = u := by rw [hudef, map_inv₀, map_ofNat]
  have ha : ∀ x, u * (x + σ x) ∈ k₀ := fun x => by
    show σ (u * (x + σ x)) = u * (x + σ x)
    rw [map_mul, map_add, hσ, hσu]; ring
  have hb : ∀ x, -(u * ι * (x - σ x)) ∈ k₀ := fun x => by
    show σ (-(u * ι * (x - σ x))) = -(u * ι * (x - σ x))
    rw [map_neg, map_mul, map_mul, map_sub, hσ, hσu, hσι]; ring
  have hN0 : ∀ x, x * σ x ∈ k₀ := fun x => by
    show σ (x * σ x) = x * σ x
    rw [map_mul, hσ, mul_comm]
  haveI : Fact Q.Prime := ⟨hp⟩
  obtain ⟨e⟩ := Arith.nonempty_ringEquiv_zmod_of_card hp hk₀
  -- the coordinates, and every element of `k₀` as the cast of a natural number
  set A : (𝓞 (fieldI F) ⧸ P.P ^ 1) → ZMod Q := fun x => e ⟨_, ha x⟩ with hAdef
  set B : (𝓞 (fieldI F) ⧸ P.P ^ 1) → ZMod Q := fun x => e ⟨_, hb x⟩ with hBdef
  have hcast : ∀ y : k₀, (y : 𝓞 (fieldI F) ⧸ P.P ^ 1) = ((e y).val : 𝓞 (fieldI F) ⧸ P.P ^ 1) := by
    intro y
    have h1 : y = e.symm (((e y).val : ℕ) : ZMod Q) := by rw [ZMod.natCast_zmod_val, RingEquiv.symm_apply_apply]
    conv_lhs => rw [h1, map_natCast]
    push_cast
    rfl
  have hdec : ∀ x, x = ((A x).val : 𝓞 (fieldI F) ⧸ P.P ^ 1) + ((B x).val : 𝓞 (fieldI F) ⧸ P.P ^ 1) * ι := by
    intro x
    rw [← hcast ⟨_, ha x⟩, ← hcast ⟨_, hb x⟩]
    show x = u * (x + σ x) + -(u * ι * (x - σ x)) * ι
    linear_combination (-x) * hu + u * (x - σ x) * hι
  have hnorm : ∀ x, x * σ x = 1 ↔ (A x) ^ 2 + (B x) ^ 2 = 1 := by
    intro x
    have hk : (⟨_, ha x⟩ : k₀) ^ 2 + (⟨_, hb x⟩ : k₀) ^ 2 = ⟨_, hN0 x⟩ := by
      apply Subtype.ext
      push_cast
      linear_combination (2 * u + 1) * x * σ x * hu + u ^ 2 * (x - σ x) ^ 2 * hι
    have e1 : (A x) ^ 2 + (B x) ^ 2 = e ⟨_, hN0 x⟩ := by
      rw [hAdef, hBdef]; simp only; rw [← map_pow, ← map_pow, ← map_add, hk]
    rw [e1, ← map_one e, e.injective.eq_iff, Subtype.ext_iff]
    rfl
  -- the coordinate map is a bijection onto the plane
  have hTinj : Function.Injective fun x => (A x, B x) := by
    intro x y hxy
    simp only [Prod.mk.injEq] at hxy
    rw [hdec x, hdec y, hxy.1, hxy.2]
  have hTbij : Function.Bijective fun x => (A x, B x) := by
    refine (Fintype.bijective_iff_injective_and_card _).2 ⟨hTinj, ?_⟩
    rw [Fintype.card_prod, ZMod.card, ← Nat.card_eq_fintype_card, ← sq, ← hQ, pow_one]
  -- the character in coordinates
  have hQk : ((Q : ℕ) : 𝓞 (fieldI F) ⧸ P.P ^ 1) = 0 := by
    have h : ((Q : ℕ) : k₀) = 0 := by
      rw [← map_natCast e.symm Q, ZMod.natCast_self, map_zero]
    have h' := congrArg (fun y : k₀ => (y : 𝓞 (fieldI F) ⧸ P.P ^ 1)) h
    simpa using h'
  have hpow1 : ψ 1 ^ Q = 1 := by
    rw [← AddChar.map_nsmul_eq_pow, nsmul_one, hQk, AddChar.map_zero_eq_one]
  have hpowι : ψ ι ^ Q = 1 := by
    rw [← AddChar.map_nsmul_eq_pow, nsmul_eq_mul, hQk, zero_mul, AddChar.map_zero_eq_one]
  have hζ := Complex.isPrimitiveRoot_exp Q hp.ne_zero
  obtain ⟨α, hα, hαz⟩ := hζ.eq_pow_of_pow_eq_one hpow1
  obtain ⟨β, hβ, hβz⟩ := hζ.eq_pow_of_pow_eq_one hpowι
  set ζ := Complex.exp (2 * Real.pi * Complex.I / Q) with hζdef
  have hψx : ∀ x, ψ x = ζ ^ ((α * (A x).val + β * (B x).val) % Q) := by
    intro x
    have e2 : ζ ^ ((α * (A x).val + β * (B x).val) % Q) = ζ ^ (α * (A x).val + β * (B x).val) := by
      conv_rhs => rw [← Nat.div_add_mod (α * (A x).val + β * (B x).val) Q]
      rw [pow_add, pow_mul, hζ.pow_eq_one, one_pow, one_mul]
    rw [e2, pow_add, pow_mul, pow_mul, hαz, hβz, ← AddChar.map_nsmul_eq_pow, ← AddChar.map_nsmul_eq_pow,
      ← AddChar.map_add_eq_mul, nsmul_one, nsmul_eq_mul, ← hdec x]
  have hαβ : α ≠ 0 ∨ β ≠ 0 := by
    by_contra h
    push Not at h
    apply hψ
    ext x
    rw [hψx, h.1, h.2, zero_mul, zero_mul, add_zero, Nat.zero_mod, pow_zero, AddChar.one_apply]
  have hre : ∀ m : ℕ, (ζ ^ m).re = Real.cos (2 * Real.pi * (m : ℝ) / Q) := by
    intro m
    rw [hζdef, ← Complex.exp_nat_mul]
    have : (m : ℂ) * (2 * Real.pi * Complex.I / Q) = ((2 * Real.pi * (m : ℝ) / Q : ℝ) : ℂ) * Complex.I := by
      push_cast; ring
    rw [this, Complex.exp_ofReal_mul_I_re]
  have hS : hfin.toFinset = Finset.univ.filter fun x => x * σ x = 1 := by
    ext x
    rw [Set.Finite.mem_toFinset, Finset.mem_filter]
    simp only [Finset.mem_univ, true_and]
    exact Iff.rfl
  have hsum : (∑ s ∈ hfin.toFinset, ψ s).re = ∑ v ∈ Finset.univ.filter (fun v : ZMod Q × ZMod Q => v.1 ^ 2 + v.2 ^ 2 = 1),
      Real.cos (2 * Real.pi * (((α * v.1.val + β * v.2.val) % Q : ℕ) : ℝ) / Q) := by
    rw [Complex.re_sum, hS]
    refine Finset.sum_nbij (fun x => (A x, B x)) ?_ (hTinj.injOn) ?_ ?_
    · intro x hx
      rw [Finset.mem_filter] at hx ⊢
      exact ⟨Finset.mem_univ _, (hnorm x).1 hx.2⟩
    · intro v hv
      rw [Finset.mem_coe, Finset.mem_filter] at hv
      obtain ⟨x, hx⟩ := hTbij.2 v
      refine ⟨x, ?_, hx⟩
      rw [Finset.mem_coe, Finset.mem_filter]
      refine ⟨Finset.mem_univ _, (hnorm x).2 ?_⟩
      have h := hv.2
      rw [← hx] at h
      exact h
    · intro x _
      rw [hψx, hre]
  rw [hsum]
  push_cast
  exact hcos α β hα hβ hαβ

/-- **The circle's cosine sums at `Q ∈ {23, 31}`** (KC13 § 5.3; FS131-ICM2's split of `charBound_one_exact`): a closed
statement about `UD(𝔽_Q, 2)`, with no number field — over the circle `a² + b² = 1`, every non-trivial character
`(a, b) ↦ e^{2πi(αa + βb)/Q}` has real part at least `−κ(Q + 1)` for one `κ < 1/3` with `κ ≥ 2/(Q + 1)`. Its truth rests on
KC13 § 5.3's spectrum (normalised least eigenvalue above `−1/3` by `1.6·10⁻³` at 23 and `4.9·10⁻⁶` at 31, in floating
point); its proof is rational bounds on `cos(2πj/Q)` and the kernel's count of the circle. -/
private theorem circleCos_bound {Q : ℕ} (hQ : Q = 23 ∨ Q = 31) [NeZero Q] :
    ∃ κ : ℝ, κ < 1 / 3 ∧ 2 / ((Q : ℝ) + 1) ≤ κ ∧ ∀ α β : ℕ, α < Q → β < Q → (α ≠ 0 ∨ β ≠ 0) →
      -(κ * ((Q : ℝ) + 1)) ≤ ∑ v ∈ Finset.univ.filter (fun v : ZMod Q × ZMod Q => v.1 ^ 2 + v.2 ^ 2 = 1),
        Real.cos (2 * Real.pi * (((α * v.1.val + β * v.2.val) % Q : ℕ) : ℝ) / Q) :=
  -- FS131-ICM3: the certificate of `Arith/CircleCos` (rational cosine bounds and one kernel pass over the circle)
  CircleCos.circleCos_ge hQ

/-- **The exact spectrum at `Q = 27`** (KC13 § 5.3; FS100-G27; FS131-ICM2's split of `charBound_one_exact`): the
level-one target's least eigenvalue is `−8`, so `κ = 8/28` serves — a character sum in characteristic `3` over
`𝔽₇₂₉`. -/
private theorem charBound_one_exact_27 [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hQ27 : Q = 27) :
    ∃ κ : ℝ, κ < 1 / 3 ∧ 2 / ((Q : ℝ) + 1) ≤ κ ∧ CharBound P 1 κ := by
  -- FS131-ICM3: Weil's level-one bound `−2√27 > −10.4`, sharpened by the arithmetic of characteristic 3. A character
  -- takes cube roots of unity, so `Re Σ = N₀ − (28 − N₀)/2` with `N₀ = #{s : ψ s = 1}`; `s ↦ −s` pairs those `s`
  -- with no fixed point, so `N₀` is even; Weil gives `N₀ ≥ 3`, hence `N₀ ≥ 4` and `Re Σ ≥ −8 = −(2/7)·28`.
  classical
  subst hQ27
  refine ⟨2 / 7, by norm_num, by norm_num, ?_⟩
  intro hfin ψ hψ
  have hW := charBound_one_weil P h2 hQ hfin ψ hψ
  have hcard := card_levelSet_oneT P (exists_conj_sub_notMem P h2).choose_spec hQ hfin
  rw [hcard] at hW ⊢
  set S := hfin.toFinset with hSdef
  haveI hmax : (P.P ^ 1).IsMaximal := by rw [pow_one]; exact P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P ^ 1) := Ideal.Quotient.field (P.P ^ 1)
  haveI := finite_quot_pow P 1
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ 1) := Fintype.ofFinite _
  -- characteristic 3
  have h3 : (3 : 𝓞 (fieldI F) ⧸ P.P ^ 1) = 0 := by
    obtain ⟨p, hchar⟩ := CharP.exists (𝓞 (fieldI F) ⧸ P.P ^ 1)
    obtain ⟨n, hp, hpn⟩ := FiniteField.card (𝓞 (fieldI F) ⧸ P.P ^ 1) p
    have hc : Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1) = 3 ^ 6 := by
      rw [← Nat.card_eq_fintype_card, pow_one, hQ]; norm_num
    rw [hc] at hpn
    have h3p : p ∣ 3 ^ 6 := by rw [hpn]; exact dvd_pow_self p n.ne_zero
    have hp3 : p = 3 := (Nat.prime_dvd_prime_iff_eq hp Nat.prime_three).1 (hp.dvd_of_dvd_pow h3p)
    subst hp3
    exact_mod_cast CharP.cast_eq_zero (𝓞 (fieldI F) ⧸ P.P ^ 1) 3
  have hcube : ∀ x, ψ x ^ 3 = 1 := fun x => by
    rw [← AddChar.map_nsmul_eq_pow, nsmul_eq_mul, Nat.cast_ofNat, h3, zero_mul, AddChar.map_zero_eq_one]
  -- a cube root of unity other than `1` has real part `−1/2`
  have hre : ∀ x, ψ x ≠ 1 → (ψ x).re = -1 / 2 := by
    intro x hx
    have h := hcube x
    have hq : ψ x ^ 2 + ψ x + 1 = 0 := by
      have e : (ψ x - 1) * (ψ x ^ 2 + ψ x + 1) = 0 := by linear_combination h
      rcases mul_eq_zero.1 e with e | e
      · exact absurd (sub_eq_zero.1 e) hx
      · exact e
    have hr := congrArg Complex.re hq
    have hi := congrArg Complex.im hq
    simp only [sq, Complex.add_re, Complex.mul_re, Complex.one_re, Complex.zero_re, Complex.add_im, Complex.mul_im,
      Complex.one_im, Complex.zero_im] at hr hi
    have hb : (ψ x).im * (2 * (ψ x).re + 1) = 0 := by linarith
    rcases mul_eq_zero.1 hb with hb | hb
    · rw [hb] at hr
      nlinarith [sq_nonneg ((ψ x).re + 1 / 2)]
    · linarith
  -- the real part counts `N₀`
  set T := S.filter fun s => ψ s = 1 with hTdef
  set U := S.filter fun s => ¬ ψ s = 1 with hUdef
  have hTU : T.card + U.card = 27 + 1 := by
    rw [hTdef, hUdef, Finset.card_filter_add_card_filter_not, hcard]
  have hsplit : (∑ s ∈ S, ψ s).re = (T.card : ℝ) - (U.card : ℝ) / 2 := by
    rw [← Finset.sum_filter_add_sum_filter_not S (fun s => ψ s = 1), Complex.add_re, Complex.re_sum, Complex.re_sum,
      ← hTdef, ← hUdef]
    have e1 : ∑ s ∈ T, (ψ s).re = ∑ s ∈ T, (1 : ℝ) := Finset.sum_congr rfl fun s hs => by
      rw [(Finset.mem_filter.1 hs).2, Complex.one_re]
    have e2 : ∑ s ∈ U, (ψ s).re = ∑ s ∈ U, (-1 / 2 : ℝ) := Finset.sum_congr rfl fun s hs =>
      hre s (Finset.mem_filter.1 hs).2
    rw [e1, e2, Finset.sum_const, Finset.sum_const, nsmul_eq_mul, nsmul_eq_mul, mul_one]
    ring
  -- `s ↦ −s` is a fixed-point-free involution of `T`
  have hnegT : ∀ s ∈ T, -s ∈ T := by
    intro s hs
    obtain ⟨hsS, hψs⟩ := Finset.mem_filter.1 hs
    refine Finset.mem_filter.2 ⟨?_, ?_⟩
    · rw [hSdef, Set.Finite.mem_toFinset] at hsS ⊢
      exact neg_mem_levelSet P 1 hsS
    · rw [AddChar.map_neg_eq_inv, hψs, inv_one]
  have h2k : (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1) ≠ 0 := by
    rw [← map_ofNat (Ideal.Quotient.mk (P.P ^ 1)) 2, Ne, Ideal.Quotient.eq_zero_iff_mem, pow_one]; exact h2
  have hne : ∀ s ∈ T, -s ≠ s := by
    intro s hs he
    obtain ⟨hsS, -⟩ := Finset.mem_filter.1 hs
    rw [hSdef, Set.Finite.mem_toFinset] at hsS
    have h0 : (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1) * s = 0 := by linear_combination -he
    rcases mul_eq_zero.1 h0 with h0 | h0
    · exact h2k h0
    · have h1 : s * Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) s = 1 := hsS
      rw [h0, zero_mul] at h1
      exact zero_ne_one h1
  have hpar : Even T.card := by
    let f : Function.End {x // x ∈ T} := fun x => ⟨-x.1, hnegT x.1 x.2⟩
    have hf2 : f ^ 2 ^ 1 = 1 := by
      funext x
      apply Subtype.ext
      show -(-x.1) = x.1
      exact neg_neg _
    haveI : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
    have h := Equiv.Perm.card_fixedPoints_modEq (f := f) (p := 2) (n := 1) hf2
    have hfix : Fintype.card (Function.fixedPoints f) = 0 := by
      rw [Fintype.card_eq_zero_iff]
      constructor
      rintro ⟨x, hx⟩
      exact hne x.1 x.2 (congrArg Subtype.val hx)
    rw [hfix, Fintype.card_coe] at h
    exact Nat.even_iff.2 h
  -- Weil: `Re Σ ≥ −2√27 > −10.4`, so `N₀ ≥ 3`, hence `N₀ ≥ 4`
  have hsqrt : Real.sqrt 27 < 26 / 5 := by
    rw [Real.sqrt_lt' (by norm_num)]
    norm_num
  have hW' : -(2 * Real.sqrt 27) ≤ (∑ s ∈ S, ψ s).re := by
    have e : 2 * Real.sqrt ((27 : ℕ) : ℝ) / (((27 : ℕ) : ℝ) + 1) * (((27 + 1 : ℕ)) : ℝ) = 2 * Real.sqrt 27 := by
      push_cast
      field_simp
      norm_num
    rw [e] at hW
    exact hW
  have hU : (U.card : ℝ) = 28 - T.card := by
    have := hTU
    have h' : ((T.card + U.card : ℕ) : ℝ) = ((27 + 1 : ℕ) : ℝ) := by rw [this]
    push_cast at h'
    linarith
  have hT3 : 3 ≤ T.card := by
    by_contra hlt
    have hle : (T.card : ℝ) ≤ 2 := by exact_mod_cast (by omega : T.card ≤ 2)
    rw [hsplit, hU] at hW'
    linarith
  have hT4 : 4 ≤ T.card := by
    obtain ⟨k, hk⟩ := hpar
    omega
  have hT4r : (4 : ℝ) ≤ T.card := by exact_mod_cast hT4
  rw [hsplit, hU]
  push_cast
  linarith

/-- **Exact spectra at `q ∈ {23, 27, 31}`** (KC13 § 5.3; FS100-G27 at 27): level one's normalised least eigenvalue is above
`−1/3`, so some level-one bound `κ < 1/3` with `κ ≥ 2/(Q + 1)` holds. -/
private theorem charBound_one_exact [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hQ' : Q = 23 ∨ Q = 27 ∨ Q = 31) :
    ∃ κ : ℝ, κ < 1 / 3 ∧ 2 / ((Q : ℝ) + 1) ≤ κ ∧ CharBound P 1 κ := by
  -- FS131-ICM2: at the primes `23` and `31` through the circle's cosine sums; at `27` its own leaf
  haveI : NeZero Q := ⟨by omega⟩
  rcases hQ' with hq | hq | hq
  · obtain ⟨κ, hκ3, hκQ, hc⟩ := circleCos_bound (Q := Q) (Or.inl hq)
    exact ⟨κ, hκ3, hκQ, charBound_one_of_circleCos P h2 hQ (by rw [hq]; norm_num) hc⟩
  · exact charBound_one_exact_27 P h2 hQ hq
  · obtain ⟨κ, hκ3, hκQ, hc⟩ := circleCos_bound (Q := Q) (Or.inr hq)
    exact ⟨κ, hκ3, hκQ, charBound_one_of_circleCos P h2 hQ (by rw [hq]; norm_num) hc⟩

-- FS131-ICM1: composed over them.

-- FS131-ICM1: `2√Q ≥ 2` for `Q ≥ 1`, so Weil's level-one constant meets Lemma P's floor.
private theorem two_div_le_weil {Q : ℕ} (hQ : 1 ≤ Q) : 2 / ((Q : ℝ) + 1) ≤ 2 * Real.sqrt Q / ((Q : ℝ) + 1) := by
  have h1 : (1 : ℝ) ≤ Real.sqrt Q := by
    rw [show (1 : ℝ) = Real.sqrt 1 from Real.sqrt_one.symm]
    exact Real.sqrt_le_sqrt (by exact_mod_cast hQ)
  have hpos : (0 : ℝ) < (Q : ℝ) + 1 := by positivity
  exact div_le_div_of_nonneg_right (by linarith) hpos.le

-- FS131-ICM1: **the Weil branch**: at an odd stable prime, ratio at most `κ/(1 + κ)`, `κ = 2√Q/(Q + 1)`.
private theorem ratioAtMost_weil [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hQ1 : 1 ≤ Q) :
    RatioAtMost P (2 * Real.sqrt Q / ((Q : ℝ) + 1) / (1 + 2 * Real.sqrt Q / ((Q : ℝ) + 1))) :=
  ratioAtMost_of_charBound P (by positivity) fun _ hm =>
    charBound_of_charBound_oneT P (exists_conj_sub_notMem P h2).choose_spec hQ (two_div_le_weil hQ1)
      (charBound_one_weil P h2 hQ) hm

-- FS131-ICM1: the Weil constant is below `1/4` from `Q ≥ 35` (`6√Q < Q + 1`), and at most `2/9` from `Q ≥ 49`.
private theorem weil_ratio_le {Q : ℕ} {c : ℝ} (hQc : 2 * Real.sqrt Q * (1 - c) ≤ c * ((Q : ℝ) + 1)) :
    2 * Real.sqrt Q / ((Q : ℝ) + 1) / (1 + 2 * Real.sqrt Q / ((Q : ℝ) + 1)) ≤ c := by
  have hpos : (0 : ℝ) < (Q : ℝ) + 1 := by positivity
  set κ := 2 * Real.sqrt Q / ((Q : ℝ) + 1) with hκ
  have hκ0 : 0 ≤ κ := by positivity
  have hκQ : κ * ((Q : ℝ) + 1) = 2 * Real.sqrt Q := by rw [hκ]; field_simp
  have e : (κ - c * (1 + κ)) * ((Q : ℝ) + 1) = 2 * Real.sqrt Q * (1 - c) - c * ((Q : ℝ) + 1) := by
    linear_combination (1 - c) * hκQ
  have hle : κ - c * (1 + κ) ≤ 0 := by
    by_contra hcon
    push Not at hcon
    have := mul_pos hcon hpos
    linarith
  rw [div_le_iff₀ (by linarith)]
  linarith

private theorem sqrt_ge_of_sq_le {Q a : ℕ} (h : a ^ 2 ≤ Q) : (a : ℝ) ≤ Real.sqrt Q := by
  rw [Real.le_sqrt (by positivity) (by positivity)]
  exact_mod_cast h

-- FS131-ICM1: **the odd branch at `Q ≥ 35`**.
private theorem ratioAtMost_weil_lt [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hQ35 : 35 ≤ Q) : ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := by
  refine ⟨249 / 1000, by norm_num, ratioAtMost_mono (ratioAtMost_weil P h2 hQ (by omega)) (weil_ratio_le ?_)⟩
  have hs : (59 / 10 : ℝ) ≤ Real.sqrt Q := by
    rw [Real.le_sqrt (by norm_num) (by positivity)]
    have : (35 : ℝ) ≤ Q := by exact_mod_cast hQ35
    linarith
  have hsq := Real.sq_sqrt (show (0 : ℝ) ≤ Q by positivity)
  nlinarith [mul_nonneg (sub_nonneg.2 hs) (sub_nonneg.2 hs)]

/-- **The odd branch, by residue size** (FS131-ICM3, at the coordinator's ruling of 2026-10-14 for M15): at a stable
prime not above 2 whose residue field has neither `9` nor `49` elements — the two sizes, `q ∈ {3, 7}`, at which the
level-one target is four-colourable (`chromaticNumber_le_four_of_small`) — the all-levels ratio is below `1/4`: Weil at
`q ≥ 35`, the exact spectra at 23, 27, 31 with Lemma P, the certificate link at 11 and 19. -/
theorem ratioAtMost_of_two_notMem [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) (h9 : Nat.card (𝓞 (fieldI F) ⧸ P.P) ≠ 9) (h49 : Nat.card (𝓞 (fieldI F) ⧸ P.P) ≠ 49) : ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := by
  obtain ⟨Q, hQ, hQ4⟩ := exists_card_sq P h2
  by_cases hQ35 : 35 ≤ Q
  · exact ratioAtMost_weil_lt P h2 hQ hQ35
  have hcases : Q = 3 ∨ Q = 7 ∨ Q = 11 ∨ Q = 15 ∨ Q = 19 ∨ Q = 23 ∨ Q = 27 ∨ Q = 31 := by omega
  -- the exact spectra at 23, 27, 31, then Lemma P and the ratio bound
  have hexact : Q = 23 ∨ Q = 27 ∨ Q = 31 → ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := fun hq => by
    obtain ⟨κ, hκ3, hκQ, hκ1⟩ := charBound_one_exact P h2 hQ hq
    have hκ0 : 0 ≤ κ := le_trans (by positivity) hκQ
    refine ⟨κ / (1 + κ), ?_, ratioAtMost_of_charBound P hκ0 fun _ hm =>
      charBound_of_charBound_oneT P (exists_conj_sub_notMem P h2).choose_spec hQ hκQ hκ1 hm⟩
    rw [div_lt_iff₀ (by linarith)]
    linarith
  rcases hcases with hq | hq | hq | hq | hq | hq | hq | hq
  · exact absurd (by rw [hQ, hq]; norm_num) h9
  · exact absurd (by rw [hQ, hq]; norm_num) h49
  · exact ratioAtMost_cert P h2 hQ (Or.inl hq)
  · exact absurd (hq ▸ hQ) (card_ne_fifteen_sq P)
  · exact ratioAtMost_cert P h2 hQ (Or.inr hq)
  · exact hexact (Or.inl hq)
  · exact hexact (Or.inr (Or.inl hq))
  · exact hexact (Or.inr (Or.inr hq))

/-- **Per prime**: five colours at level one give an all-levels ratio below `1/4`. -/
theorem ratioAtMost_of_five_le_chromaticNumber [NumberField F] (P : StablePrime F)
    (h : 5 ≤ (levelTarget P 1).chromaticNumber) : ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := by
  -- (a) a ramified stable prime has a two-colourable level-one target
  by_cases hram : IsRamified P
  · exfalso
    have h2c := (colorable_two_levelTarget_one_of_isRamified hram).chromaticNumber_le
    have : (5 : ℕ∞) ≤ 2 := h.trans h2c
    exact absurd this (by norm_num)
  by_cases h2 : (2 : 𝓞 (fieldI F)) ∈ P.P
  · exact ratioAtMost_dyadic P h2 hram h
  -- (b, c) the odd branch, by residue size (FS131-ICM3): `q ∈ {3, 7}` are four-colourable
  refine ratioAtMost_of_two_notMem P h2 (fun h9 => ?_) (fun h49 => ?_)
  · exact absurd (h.trans (chromaticNumber_le_four_of_small P h2 (Q := 3) (by rw [h9]; norm_num) (Or.inl rfl))) (by norm_num)
  · exact absurd (h.trans (chromaticNumber_le_four_of_small P h2 (Q := 7) (by rw [h49]; norm_num) (Or.inr rfl))) (by norm_num)

variable (F) in
/-- **CLS** (FS100-CLS): `L(F) ≥ 5` gives T-C(A) at `S = ∅`. -/
theorem tca_of_five_le_localBound [NumberField F] (h : 5 ≤ localBound F) : TCA F := fun P =>
  ratioAtMost_of_five_le_chromaticNumber P (h.trans (iInf_le _ P))

variable (F) in
/-- **The uniform tail**: one `c < 1/4` bounds the all-levels ratio at every stable prime of absolute norm above `B`. -/
theorem exists_uniform_tail [NumberField F] :
    ∃ c : ℝ, c < 1 / 4 ∧ ∃ B : ℕ, ∀ P : StablePrime F, B < Ideal.absNorm P.P → RatioAtMost P c := by
  refine ⟨2 / 9, by norm_num, max (2 ^ Module.finrank ℤ (𝓞 (fieldI F))) 2401, fun P hP => ?_⟩
  -- a stable prime of norm above `2^[L : ℚ]` does not hold `2`
  have h2 : (2 : 𝓞 (fieldI F)) ∉ P.P := by
    intro h2
    have hle : Ideal.span {((2 : ℕ) : 𝓞 (fieldI F))} ≤ P.P := by
      rw [Ideal.span_le, Set.singleton_subset_iff]
      exact_mod_cast h2
    have hdvd := Ideal.absNorm_dvd_absNorm_of_le hle
    rw [Ideal.absNorm_span_natCast] at hdvd
    have := Nat.le_of_dvd (by positivity) hdvd
    omega
  obtain ⟨Q, hQ, -⟩ := exists_card_sq P h2
  have hN : Ideal.absNorm P.P = Q ^ 2 := by rw [Ideal.absNorm_apply, Submodule.cardQuot_apply]; exact hQ
  have hQ49 : 49 ≤ Q := by
    by_contra hlt
    have : Q ^ 2 ≤ 48 ^ 2 := Nat.pow_le_pow_left (by omega) 2
    omega
  refine ratioAtMost_mono (ratioAtMost_weil P h2 hQ (by omega)) (weil_ratio_le ?_)
  have hs : (7 : ℝ) ≤ Real.sqrt Q := by exact_mod_cast sqrt_ge_of_sq_le (a := 7) (by omega)
  have hQr : (49 : ℝ) ≤ Q := by exact_mod_cast hQ49
  nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ Q by positivity), Real.sqrt_nonneg (Q : ℝ)]

variable (F) in
/-- **T-C(A) with one constant** — the form the count reads: the tail's constant and the finitely many primes below `B`
(`Ideal.finite_setOf_absNorm_le`). -/
theorem tca_uniform [NumberField F] (h : TCA F) : ∃ c : ℝ, c < 1 / 4 ∧ ∀ P : StablePrime F, RatioAtMost P c := by
  obtain ⟨c₀, hc₀, B, hB⟩ := exists_uniform_tail F
  have hfin := finite_stablePrime_absNorm_le (F := F) B
  choose cP hcP hRP using (tca_iff F).1 h
  obtain ⟨m, hm, hmle⟩ : ∃ m : ℝ, m < 1 / 4 ∧ ∀ P : StablePrime F, Ideal.absNorm P.P ≤ B → cP P ≤ m := by
    rcases hfin.toFinset.eq_empty_or_nonempty with he | hne
    · refine ⟨0, by norm_num, fun P hP => absurd (hfin.mem_toFinset.2 hP) ?_⟩
      rw [he]
      exact Finset.notMem_empty P
    · obtain ⟨P₀, -, hmax⟩ := hfin.toFinset.exists_max_image cP hne
      exact ⟨cP P₀, hcP P₀, fun P hP => hmax P (hfin.mem_toFinset.2 hP)⟩
  refine ⟨max c₀ m, max_lt hc₀ hm, fun P => ?_⟩
  by_cases hPB : B < Ideal.absNorm P.P
  · exact ratioAtMost_mono (hB P hPB) (le_max_left _ _)
  · exact ratioAtMost_mono (hRP P) ((hmle P (not_lt.1 hPB)).trans (le_max_right _ _))

/-- **Weil at level one and Lemma P above it, two-sided** (FS131-ICO1; the planner's drafted edit D-E2, approved): at a
stable prime not above `2` with `|𝓞 ⧸ P| = Q²`, every non-trivial additive character of `𝓞 ⧸ P^m`, `m ≥ 1`, sums over the
norm-one set to at most `2√Q/(Q + 1)` of its size in modulus — `StandingFive.norm_normOne_charSum_le` at level one, over the
declared import `StandingFive.kloosterman_bound`, and the descent of Lemma P (`newCharBound_of_two_notMem`'s) above it. -/
theorem norm_charSum_le_weil [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hQ1 : 1 ≤ Q) {m : ℕ} (hm : 1 ≤ m)
    (hfin : (CertLink.normOneSet P m).Finite) (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ m) ℂ) (hψ : ψ ≠ 1) :
    ‖∑ s ∈ hfin.toFinset, ψ s‖ ≤ 2 * Real.sqrt Q / ((Q : ℝ) + 1) * hfin.toFinset.card := by
  obtain ⟨n, rfl⟩ : ∃ n, m = n + 1 := ⟨m - 1, by omega⟩
  exact norm_charSum_le_of_one P (exists_conj_sub_notMem P h2).choose_spec hQ (two_div_le_weil hQ1)
    (norm_charSum_one_weil P h2 hQ) n hfin ψ hψ

end

end HadwigerNelson.Rigidity
