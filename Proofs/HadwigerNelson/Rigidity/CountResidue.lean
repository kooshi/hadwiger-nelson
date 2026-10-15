import Proofs.HadwigerNelson.Rigidity.CountTorus
import Proofs.HadwigerNelson.Rigidity.TateModel
import Proofs.HadwigerNelson.Rigidity.ClassRatio
import Proofs.HadwigerNelson.Rigidity.FiniteZhang

/-!
# The count's finite levels: residues of the unit vectors, and the ratio of every level (FS-131, job FS131-K12A; module M12, block R)

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

theorem ofUnitRing_mem_localRing (P : StablePrime F) (r : unitRing F) : ofUnitRing F r ∈ P.localRing :=
  (mem_stableIntegers F).1
    (unitRing_le_stableIntegers F ((UnitRing.coe_mem_unitRingOver_iff (ofUnitRing F r)).1 r.2)) P

/-- `R → P.localRing` (`R ⊆ L` is lane T's `ofUnitRing`). -/
def toLocal (P : StablePrime F) : unitRing F →+* P.localRing :=
  RingHom.codRestrict (ofUnitRing F) P.localRing fun r => ofUnitRing_mem_localRing P r

/-- **The residue map of `R` at `P^m`.** -/
def resR (P : StablePrime F) (m : ℕ) : unitRing F →+* 𝓞 (fieldI F) ⧸ P.P ^ m := (P.residue m).comp (toLocal P)

/-- **The connection set of the level-`m` target**: the norm-one elements of `𝓞/P^m`. -/
def normOneQ (P : StablePrime F) (m : ℕ) : Set (𝓞 (fieldI F) ⧸ P.P ^ m) :=
  {x | x * Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) x = 1}

-- FS131-ICL2: the residue rings at `m ≥ 1` are not zero, so `0` is not of norm one.
omit [NumberField F] in
private theorem zero_notMem_normOneQ (P : StablePrime F) {m : ℕ} (hm : 1 ≤ m) : (0 : 𝓞 (fieldI F) ⧸ P.P ^ m) ∉ normOneQ P m := by
  intro h0
  have h1 : (0 : 𝓞 (fieldI F) ⧸ P.P ^ m) = 1 := by
    simpa only [normOneQ, Set.mem_setOf_eq, zero_mul] using h0
  have hmem : (1 : 𝓞 (fieldI F)) ∈ P.P ^ m := by
    rw [← Ideal.Quotient.eq_zero_iff_mem, map_one]
    exact h1.symm
  exact P.isMaximal.ne_top ((Ideal.eq_top_iff_one _).2 (Ideal.pow_le_self (by omega) hmem))

omit [NumberField F] in
theorem isIndepSet_levelTarget_iff (P : StablePrime F) {m : ℕ} (hm : 1 ≤ m) (s : Finset (𝓞 (fieldI F) ⧸ P.P ^ m)) :
    (levelTarget P m).IsIndepSet (s : Set _) ↔ SIndep (normOneQ P m) s := by
  constructor
  · intro h x hx y hy hxy
    by_cases hne : x = y
    · subst hne
      rw [sub_self] at hxy
      exact zero_notMem_normOneQ P hm hxy
    · exact h hy hx (Ne.symm hne) ((SimpleGraph.fromRel_adj _ _ _).2 ⟨Ne.symm hne, Or.inl hxy⟩)
  · intro h x hx y hy _ hadj
    rcases ((SimpleGraph.fromRel_adj _ _ _).1 hadj).2 with h1 | h1
    · exact h y hy x hx h1
    · exact h x hx y hy h1

omit [NumberField F] in
theorem neg_mem_normOneQ (P : StablePrime F) (m : ℕ) {x : 𝓞 (fieldI F) ⧸ P.P ^ m} (hx : x ∈ normOneQ P m) :
    -x ∈ normOneQ P m := by
  show -x * Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) (-x) = 1
  rw [map_neg, neg_mul_neg]
  exact hx

/-- The residue rings of a stable prime are finite (`Ideal.finiteQuotientOfFreeOfNeBot`: `P^m ≠ ⊥`). A `Prop`-valued
class, so the instance makes no diamond. -/
instance finite_quot (P : StablePrime F) (m : ℕ) : Finite (𝓞 (fieldI F) ⧸ P.P ^ m) :=
  Ideal.finiteQuotientOfFreeOfNeBot _ (pow_ne_zero m P.heightOne.ne_bot)

omit [NumberField F] in
theorem ratioLe_normOneQ (P : StablePrime F) {c : ℝ} (h : RatioAtMost P c) {m : ℕ} (hm : 1 ≤ m) :
    RatioLe (normOneQ P m) c :=
  fun s hs => h m hm s ((isIndepSet_levelTarget_iff P hm s).2 hs)

-- FS131-ICL2: Hilbert 90 modulo `P^m`, in four steps shared by the two residue leaves (FS131-K12A's scratch leaf `LeafR`,
-- cut at its joints): the norm-one condition on a lift; a `w` with `w + a w̄ ∉ P` (from `¬ IsRamified P`); `z = w + a w̄`
-- satisfies `z ≡ a z̄ (mod P^m)`; and `z / z̄` is a unit vector whose residue is `a`.

omit [NumberField F] in
private theorem mk_mem_normOneQ_iff (P : StablePrime F) (m : ℕ) (a : 𝓞 (fieldI F)) :
    Ideal.Quotient.mk (P.P ^ m) a ∈ normOneQ P m ↔ a * conjO F a - 1 ∈ P.P ^ m := by
  simp only [normOneQ, Set.mem_setOf_eq, Ideal.quotientMap_mk]
  rw [← map_mul, ← map_one (Ideal.Quotient.mk _), Ideal.Quotient.eq]

omit [NumberField F] in
private theorem exists_add_mul_conj_notMem (P : StablePrime F) (hP : ¬ IsRamified P) (a : 𝓞 (fieldI F)) :
    ∃ w : 𝓞 (fieldI F), w + a * conjO F w ∉ P.P := by
  obtain ⟨ζ, hζ⟩ : ∃ ζ : 𝓞 (fieldI F), conjO F ζ - ζ ∉ P.P := by
    by_contra h
    push Not at h
    exact hP h
  by_contra h
  push Not at h
  have h1 := h 1
  rw [map_one, mul_one] at h1
  apply hζ
  have e : conjO F ζ - ζ = (1 + a) * conjO F ζ - (ζ + a * conjO F ζ) := by ring
  rw [e]
  exact P.P.sub_mem (P.P.mul_mem_right _ h1) (h ζ)

omit [NumberField F] in
private theorem sub_mul_conj_mem (P : StablePrime F) (m : ℕ) {a : 𝓞 (fieldI F)} (ha : a * conjO F a - 1 ∈ P.P ^ m)
    (w : 𝓞 (fieldI F)) : (w + a * conjO F w) - a * conjO F (w + a * conjO F w) ∈ P.P ^ m := by
  have e : (w + a * conjO F w) - a * conjO F (w + a * conjO F w) = -(w * (a * conjO F a - 1)) := by
    rw [map_add, map_mul, UpperHalf.conjO_conjO]
    ring
  rw [e]
  exact neg_mem (Ideal.mul_mem_left _ _ ha)

omit [NumberField F] in
private theorem div_conj_mem_normOneL {z : 𝓞 (fieldI F)} (hz : (z : fieldI F) ≠ 0) :
    (z : fieldI F) / ((conjO F z : 𝓞 (fieldI F)) : fieldI F) ∈ normOneL F := by
  have hconj : ((conjO F z : 𝓞 (fieldI F)) : fieldI F) = conjOn (fieldI_conj F) (z : fieldI F) := UpperHalf.coe_conjO z
  have hzb0 : conjOn (fieldI_conj F) (z : fieldI F) ≠ 0 := (map_ne_zero _).2 hz
  show _ * _ = _
  rw [hconj, map_div₀, conjOn_conjOn]
  field_simp

private theorem residue_div_conj (P : StablePrime F) (m : ℕ) {a z : 𝓞 (fieldI F)}
    (hz : z - a * conjO F z ∈ P.P ^ m) (hzP : z ∉ P.P)
    (hx : (z : fieldI F) / ((conjO F z : 𝓞 (fieldI F)) : fieldI F) ∈ normOneL F) :
    P.residue m ⟨_, UpperHalf.mem_localRing_of_mul_conj_eq_one P hx⟩ = Ideal.Quotient.mk (P.P ^ m) a := by
  have hzb : conjO F z ∉ P.P := fun h => hzP ((UpperHalf.conjO_mem_iff P).mp h)
  have hres := UpperHalf.residue_div P m z (conjO F z) hzb
  have hunit : IsUnit (Ideal.Quotient.mk (P.P ^ m) (conjO F z)) :=
    UpperHalf.isUnit_mk_pow P m ⟨conjO F z, hzb⟩
  have hmk : Ideal.Quotient.mk (P.P ^ m) z =
      Ideal.Quotient.mk (P.P ^ m) a * Ideal.Quotient.mk (P.P ^ m) (conjO F z) := by
    rw [← map_mul, Ideal.Quotient.eq]
    exact hz
  rw [hmk] at hres
  exact hunit.mul_right_cancel hres

omit [NumberField F] in
private theorem coe_ne_zero_of_notMem (P : StablePrime F) {z : 𝓞 (fieldI F)} (hz : z ∉ P.P) : (z : fieldI F) ≠ 0 :=
  fun h0 => hz (by rw [RingOfIntegers.coe_eq_zero_iff.1 h0]; exact P.P.zero_mem)

/-- **`[S9]` at one unramified stable prime** (Hilbert 90 modulo `P^m`). -/
theorem exists_normOneL_residue (P : StablePrime F) (hP : ¬ IsRamified P) (m : ℕ) {s : 𝓞 (fieldI F) ⧸ P.P ^ m}
    (hs : s ∈ normOneQ P m) :
    ∃ (x : fieldI F) (hx : x ∈ normOneL F), P.residue m ⟨x, UpperHalf.mem_localRing_of_mul_conj_eq_one P hx⟩ = s := by
  obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective s
  have ha := (mk_mem_normOneQ_iff P m a).1 hs
  obtain ⟨w, hw⟩ := exists_add_mul_conj_notMem P hP a
  have hx := div_conj_mem_normOneL (coe_ne_zero_of_notMem P hw)
  exact ⟨_, hx, residue_div_conj P m (sub_mul_conj_mem P m ha w) hw hx⟩

/-- **`[S9]` jointly at finitely many unramified stable primes.** -/
theorem exists_normOneL_residues (Φ : Finset (StablePrime F)) (hΦ : ∀ P ∈ Φ, ¬ IsRamified P) (m : ℕ)
    (s : ∀ P ∈ Φ, 𝓞 (fieldI F) ⧸ P.P ^ m) (hs : ∀ P hP, s P hP ∈ normOneQ P m) :
    ∃ (x : fieldI F) (hx : x ∈ normOneL F), ∀ P hP,
      P.residue m ⟨x, UpperHalf.mem_localRing_of_mul_conj_eq_one P hx⟩ = s P hP := by
  classical
  rcases Φ.eq_empty_or_nonempty with rfl | ⟨P₀, hP₀⟩
  · refine ⟨1, ?_, fun P hP => absurd hP (Finset.notMem_empty P)⟩
    show (1 : fieldI F) * conjOn (fieldI_conj F) 1 = 1
    rw [map_one, one_mul]
  have hprime : ∀ P ∈ Φ, Prime P.P := fun P _ =>
    Ideal.prime_of_isPrime P.heightOne.ne_bot P.isMaximal.isPrime
  have hdist : ∀ P ∈ Φ, ∀ Q ∈ Φ, P ≠ Q → P.P ≠ Q.P := by
    rintro ⟨P, h1, h2⟩ - ⟨Q, h3, h4⟩ - hne (e : P = Q)
    subst e
    exact hne rfl
  -- one lift `a` of every `s P` (the Chinese remainder theorem at the exponent `m`)
  choose a₀ ha₀ using fun P : Φ => Ideal.Quotient.mk_surjective (s P.1 P.2)
  obtain ⟨a, ha⟩ := IsDedekindDomain.exists_forall_sub_mem_ideal (s := Φ) (fun P => P.P) (fun _ => m) hprime hdist a₀
  have hmk : ∀ P (hP : P ∈ Φ), Ideal.Quotient.mk (P.P ^ m) a = s P hP := fun P hP => by
    rw [← ha₀ ⟨P, hP⟩, Ideal.Quotient.eq]
    exact ha P hP
  have hnorm : ∀ P (hP : P ∈ Φ), a * conjO F a - 1 ∈ P.P ^ m := fun P hP =>
    (mk_mem_normOneQ_iff P m a).1 (by rw [hmk P hP]; exact hs P hP)
  -- one `w` with `w + a w̄ ∉ P` at every `P` (the theorem again, at the exponent `1`)
  choose w₀ hw₀ using fun P : Φ => exists_add_mul_conj_notMem P.1 (hΦ P.1 P.2) a
  obtain ⟨w, hw⟩ := IsDedekindDomain.exists_forall_sub_mem_ideal (s := Φ) (fun P => P.P) (fun _ => 1) hprime hdist w₀
  have hwP : ∀ P (hP : P ∈ Φ), w + a * conjO F w ∉ P.P := fun P hP hmem => by
    apply hw₀ ⟨P, hP⟩
    have h1 : w - w₀ ⟨P, hP⟩ ∈ P.P := by simpa using hw P hP
    have h2 : conjO F (w - w₀ ⟨P, hP⟩) ∈ P.P := (UpperHalf.conjO_mem_iff P).2 h1
    have e : w₀ ⟨P, hP⟩ + a * conjO F (w₀ ⟨P, hP⟩) =
        (w + a * conjO F w) - ((w - w₀ ⟨P, hP⟩) + a * conjO F (w - w₀ ⟨P, hP⟩)) := by
      rw [map_sub]
      ring
    rw [e]
    exact P.P.sub_mem hmem (P.P.add_mem h1 (P.P.mul_mem_left _ h2))
  have hx := div_conj_mem_normOneL (coe_ne_zero_of_notMem P₀ (hwP P₀ hP₀))
  refine ⟨_, hx, fun P hP => ?_⟩
  rw [← hmk P hP]
  exact residue_div_conj P m (sub_mul_conj_mem P m (hnorm P hP) w) (hwP P hP) hx

omit [NumberField F] in
/-- A norm-one element of `L` is (the image of) an element of `R`. -/
theorem exists_unitRing_of_normOneL {x : fieldI F} (hx : x ∈ normOneL F) :
    ∃ r : unitRing F, ofUnitRing F r = x ∧ ((r : ℂ) ∈ unitVectors F) :=
  ⟨⟨(x : ℂ), unitVectors_subset_unitRing F ((mem_normOneL_iff F).1 hx)⟩, rfl, (mem_normOneL_iff F).1 hx⟩

-- FS131-ICL2: a stable prime has absolute norm at least `2` (it is neither `⊥` nor `⊤`).
private theorem two_le_absNorm (P : StablePrime F) : 2 ≤ Ideal.absNorm P.P := by
  have h0 : Ideal.absNorm P.P ≠ 0 := fun h => P.heightOne.ne_bot (Ideal.absNorm_eq_zero_iff.1 h)
  have h1 : Ideal.absNorm P.P ≠ 1 := fun h => P.isMaximal.ne_top (Ideal.absNorm_eq_one_iff.1 h)
  omega

/-- **Lemma C (d)**, from `c·O′ ⊆ R`: residues zero at finitely many stable primes put an element of `R` in `N·R`. -/
theorem exists_mem_nsmul_of_resR_eq_zero {N : ℕ} (hN : N ≠ 0) :
    ∃ (Φ : Finset (StablePrime F)) (m : ℕ), ∀ r : unitRing F, (∀ P ∈ Φ, resR P m r = 0) → ∃ y : unitRing F, r = N • y := by
  -- Route: `M = N c` with `c·O′ ⊆ R`; at `m = absNorm (M)` no stable prime's `m`-th power holds `M`, so residues zero at the
  -- stable primes over `M` put `r / M` in every `𝓞_P` (a valuation ring: else `M ∈ r·𝓞_P`, whose residues are zero); then
  -- `c·(r/M) = r/N ∈ R`.
  obtain ⟨c, hc, hcO⟩ := exists_mul_stableIntegers_le (F := F)
  set M : ℕ := N * c with hM
  have hM0 : M ≠ 0 := mul_ne_zero hN hc
  set m : ℕ := Ideal.absNorm (Ideal.span {((M : ℕ) : 𝓞 (fieldI F))}) with hm
  have hm0 : m ≠ 0 := by
    rw [hm, Ne, Ideal.absNorm_eq_zero_iff, Ideal.span_singleton_eq_bot]
    exact_mod_cast hM0
  have hdvd : ∀ P : StablePrime F, ∀ e : ℕ, ((M : ℕ) : 𝓞 (fieldI F)) ∈ P.P ^ e → Ideal.absNorm P.P ^ e ≤ m := by
    intro P e hmem
    have hle : Ideal.span {((M : ℕ) : 𝓞 (fieldI F))} ≤ P.P ^ e := (Ideal.span_singleton_le_iff_mem _).2 hmem
    have h := Ideal.absNorm_dvd_absNorm_of_le hle
    rw [map_pow] at h
    exact Nat.le_of_dvd (Nat.pos_of_ne_zero hm0) h
  have hMpow : ∀ P : StablePrime F, ((M : ℕ) : 𝓞 (fieldI F)) ∉ P.P ^ m := by
    intro P hmem
    have h1 := hdvd P m hmem
    have h2 : 2 ^ m ≤ Ideal.absNorm P.P ^ m := Nat.pow_le_pow_left (two_le_absNorm P) m
    have h3 : m < 2 ^ m := Nat.lt_two_pow_self
    omega
  -- the stable primes of absolute norm at most `m` (the set `level F m`, which is declared further down)
  have hinjP : Function.Injective (fun P : StablePrime F => P.P) := by
    rintro ⟨P, h1, h2⟩ ⟨Q, h3, h4⟩ (e : P = Q)
    subst e
    rfl
  have hfin : ((fun P : StablePrime F => P.P) ⁻¹' {I | Ideal.absNorm I ≤ m}).Finite :=
    Set.Finite.preimage hinjP.injOn (Ideal.finite_setOf_absNorm_le (S := 𝓞 (fieldI F)) m)
  refine ⟨hfin.toFinset, m, fun r hr => ?_⟩
  set x := ofUnitRing F r with hxdef
  have hxM : x / (M : fieldI F) ∈ stableIntegers F := by
    rw [mem_stableIntegers]
    intro P
    by_cases hMP : ((M : ℕ) : 𝓞 (fieldI F)) ∈ P.P
    · have hPl : P ∈ hfin.toFinset := hfin.mem_toFinset.2 (by simpa using hdvd P 1 (by simpa using hMP))
      have hr0 : P.residue m ⟨x, ofUnitRing_mem_localRing P r⟩ = 0 := hr P hPl
      by_cases hx0 : x = 0
      · rw [hx0, zero_div]
        exact P.localRing.zero_mem
      rcases P.localRing.mem_or_inv_mem (x / M) with h | h
      · exact h
      · exfalso
        apply hMpow P
        have e : algebraMap (𝓞 (fieldI F)) P.localRing ((M : ℕ) : 𝓞 (fieldI F)) =
            ⟨x, ofUnitRing_mem_localRing P r⟩ * ⟨(x / M)⁻¹, h⟩ := by
          apply Subtype.ext
          show (((M : ℕ) : 𝓞 (fieldI F)) : fieldI F) = x * (x / M)⁻¹
          rw [inv_div, mul_div_cancel₀ _ hx0]
          simp
        have h0 : P.residue m (algebraMap (𝓞 (fieldI F)) P.localRing ((M : ℕ) : 𝓞 (fieldI F))) = 0 := by
          rw [e, map_mul, hr0, zero_mul]
        rwa [UpperHalf.residue_algebraMap, Ideal.Quotient.eq_zero_iff_mem] at h0
    · have hinv : (M : fieldI F)⁻¹ ∈ P.localRing :=
        (UpperHalf.mem_localRing P).2 ⟨1, (M : 𝓞 (fieldI F)), hMP, by simp⟩
      rw [div_eq_mul_inv]
      exact mul_mem (ofUnitRing_mem_localRing P r) hinv
  have hy := hcO _ hxM
  refine ⟨⟨(((c : fieldI F) * (x / M) : fieldI F) : ℂ), (UnitRing.coe_mem_unitRingOver_iff _).2 hy⟩, ?_⟩
  have hinj : ∀ a b : unitRing F, ofUnitRing F a = ofUnitRing F b → a = b := fun a b h =>
    Subtype.ext (show (a : ℂ) = (b : ℂ) from congrArg (fun z : fieldI F => (z : ℂ)) h)
  apply hinj
  rw [map_nsmul, nsmul_eq_mul]
  show x = (N : fieldI F) * ((c : fieldI F) * (x / M))
  have hN' : (N : fieldI F) ≠ 0 := Nat.cast_ne_zero.2 hN
  have hc' : (c : fieldI F) ≠ 0 := Nat.cast_ne_zero.2 hc
  rw [hM, Nat.cast_mul]
  field_simp

/-- A residue zero at `P^k` is zero at every coarser power. -/
theorem resR_eq_zero_of_le (P : StablePrime F) {m k : ℕ} (hmk : m ≤ k) {r : unitRing F} (hr : resR P k r = 0) :
    resR P m r = 0 := by
  have hfac : (Ideal.Quotient.factor (Ideal.pow_le_pow_right hmk)).comp (P.residue k) = P.residue m :=
    IsLocalization.ringHom_ext P.heightOne.asIdeal.primeCompl (RingHom.ext fun a => by
      simp only [RingHom.comp_apply, UpperHalf.residue_algebraMap, Ideal.Quotient.factor_mk])
  have e : resR P m r = Ideal.Quotient.factor (Ideal.pow_le_pow_right hmk) (resR P k r) := by
    show P.residue m (toLocal P r) = Ideal.Quotient.factor _ (P.residue k (toLocal P r))
    rw [← hfac, RingHom.comp_apply]
  rw [e, hr, map_zero]

-- `[NumberField F]` is read by no step since `noRamifiedStableDyadic_of_tca` dropped it (FS131-IJN1; the coordinator's
-- ruling, the cascade of that drop)
omit [NumberField ↥F] in
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
  simp only [level, Set.Finite.mem_toFinset, Set.mem_preimage, Set.mem_setOf_eq]

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
  obtain ⟨Φ, m, hΦ⟩ := exists_mem_nsmul_of_resR_eq_zero (F := F) hN
  have key : ∀ K, m ≤ K → (∀ P ∈ Φ, Ideal.absNorm P.P ≤ K) →
      ∀ r : unitRing F, levR F K r = 0 → ∃ y : unitRing F, r = N • y := by
    intro K hmK hΦK r hr
    refine hΦ r fun P hP => resR_eq_zero_of_le P hmK ?_
    have hPk : P ∈ level F K := (mem_level F).2 (hΦK P hP)
    have h1 : (levR F K r : ∀ P : level F K, 𝓞 (fieldI F) ⧸ P.1.P ^ K) ⟨P, hPk⟩ = resR P K r := rfl
    rw [← h1, hr]
    rfl
  -- a bound for the norms in `Φ`, stated for any function first: `Finset.le_sup` unified at `Ideal.absNorm P.P` runs out
  -- of heartbeats in `whnf` (`data/fs131/icl2/probes/LevelProbe2.lean`, `LevelProbe3.lean`)
  have hgen : ∀ (s : Finset (StablePrime F)) (f : StablePrime F → ℕ), ∃ B : ℕ, ∀ P ∈ s, f P ≤ B :=
    fun s f => ⟨s.sup f, fun P hP => Finset.le_sup hP⟩
  obtain ⟨B, hB⟩ := hgen Φ fun P => Ideal.absNorm P.P
  exact ⟨m + B, key _ (Nat.le_add_right m B) fun P hP => le_trans (hB P hP) (Nat.le_add_left B m)⟩

/-- **`[S9]` at level `k`**: the unit vectors map onto the product connection set. -/
theorem image_levR_unitVectors (h : TCA F) (k : ℕ) :
    levR F k '' {r | (r : ℂ) ∈ unitVectors F} = normOneLev F k := by
  ext d
  constructor
  · rintro ⟨r, hr, rfl⟩ P
    have hx : ofUnitRing F r ∈ normOneL F := (mem_normOneL_iff F).2 hr
    show P.1.residue k (toLocal P.1 r) *
      Ideal.quotientMap (P.1.P ^ k) (conjO F) (P.1.le_comap k) (P.1.residue k (toLocal P.1 r)) = 1
    rw [← UpperHalf.residue_conj, ← map_mul, ← map_one (P.1.residue k)]
    congr 1
    exact Subtype.ext hx
  · intro hd
    obtain ⟨x, hx, hres⟩ := exists_normOneL_residues (level F k) (fun P _ => ratio_unramified_of_tca h P) k
      (fun P hP => (d : ∀ P : level F k, 𝓞 (fieldI F) ⧸ P.1.P ^ k) ⟨P, hP⟩) (fun P hP => hd ⟨P, hP⟩)
    obtain ⟨r, hrx, hru⟩ := exists_unitRing_of_normOneL hx
    refine ⟨r, hru, funext fun P => ?_⟩
    show P.1.residue k (toLocal P.1 r) = _
    have e : toLocal P.1 r = ⟨x, UpperHalf.mem_localRing_of_mul_conj_eq_one P.1 hx⟩ := Subtype.ext hrx
    rw [e]
    exact hres P.1 P.2

/-- **Every level has ratio at most `c`.** -/
theorem ratioLe_levR_range (h : TCA F) {c : ℝ} (hc0 : 0 ≤ c) (hc : ∀ P : StablePrime F, RatioAtMost P c) {k : ℕ}
    (hk : 1 ≤ k) :
    RatioLe {d : (levR F k).range.toAddSubgroup | (d : Lev F k) ∈ normOneLev F k} c := by
  have hpi : RatioLe (normOneLev F k) c :=
    ratioLe_pi (H := fun P : level F k => 𝓞 (fieldI F) ⧸ P.1.P ^ k) (S := fun P => normOneQ P.1 k) hc0
      (fun P _ hs => neg_mem_normOneQ P.1 k hs) (fun P => ratioLe_normOneQ P.1 (hc P.1) hk)
  refine ratioLe_subgroup (levR F k).range.toAddSubgroup ?_ hpi
  intro d hd
  rw [← image_levR_unitVectors F h k] at hd
  obtain ⟨r, _, rfl⟩ := hd
  exact ⟨r, rfl⟩

/-! ## Spec examples -/

example (P : StablePrime F) (m : ℕ) (x : 𝓞 (fieldI F) ⧸ P.P ^ m) :
    x ∈ normOneQ P m ↔ x * Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) x = 1 := Iff.rfl

end

end HadwigerNelson.Rigidity.Counting
