import Proofs.HadwigerNelson.Arith.FibreShareIneq
import Proofs.HadwigerNelson.Arith.FibreCert11Bound
import Proofs.HadwigerNelson.Arith.UpperHalf
import Proofs.HadwigerNelson.Arith.StandingFive

/-!
# The certificate link: FS-66's fibre-share bound at a stable prime of residue size `q²` (FS131-IKL1)

**Read aloud, against `plans/FS131-KC13-certificates.md` § 5.2 (K3–K5) and FS-66's `data/fs66/b1/SOUNDNESS.md` §§ 1–2.**
`P` is a stable prime of `F(i)` not above `2`, with `|𝓞 ⧸ P| = q²` for a prime `q`.

* **K3**, `exists_addEquiv_zmod`: there is an additive isomorphism `𝓞 ⧸ P → (ℤ/q)²` carrying the norm-one set
  `{x : x·x̄ = 1}` onto the unit circle `{a² + b² = 1}` — the level-one target `levelTarget P 1` is `Cay((ℤ/q)², S)`.
* **K4**, `card_le_of_fibreShareBound`: given two facts about the tower — Hensel's count of norm-one lifts
  (`HenselCount`) and the bound on characters new above level one (`NewCharBound`, FS-66's L1) — every bound
  `Σ φ ≤ U` on FS-66's region `{φ : (ℤ/q)² → [0, 1], q(φ) ≥ 0}` (`FibreShareBound q U`) gives, at every level `m ≥ 1`,
  `|I| ≤ (U/q²)·|𝓞 ⧸ P^m|` for every independent set `I` of `levelTarget P m`. The fibre shares of `I` over level one
  lie in the region (FS-66's L2, `FibreShare.fibreShare_le` in the abstract), and `|I| = (|𝓞 ⧸ P^m|/q²)·Σ φ`.
* **K5** and the composition, `ratioAtMost_eleven`, `ratioAtMost_nineteen`, `ratioAtMost_cert_link`: at `q = 11` from
  FS-66's certificate (`FibreCertSound.sum_le_eleven`: `U = 28.2043…`, `U/121 = 0.2331… < 1/4`), and at `q = 19` from
  any bound `U < 361/4` taken as a hypothesis. The conclusion is `Rigidity.RatioAtMost P c`'s body written out, for
  `M13`'s leaf `ratioAtMost_cert` to read.

`HenselCount` and `NewCharBound` are theorems at every stable prime not above `2` (`Rigidity/ClassRatio`'s Lemma P,
FS131-ICM2, private there); this module, upstream of `ClassRatio`, takes them as hypotheses, and `ClassRatio`
discharges them where it reads `ratioAtMost_cert_link`.

**Models.** `fibreShareBound_eleven` is `FibreShareBound 11 U₁₁`. In `Rigidity/CertLinkModels`: a stable prime of
`ℚ(√3)` not above `2` with residue size `3²` (`exists_stablePrime_sqrt_three`, resting on Weil's bound) satisfies the
stable-prime hypotheses at `q = 3`, and K3 holds there (`exists_addEquiv_zmod_sqrt_three`); `HenselCount` and
`NewCharBound` hold at it by `ClassRatio`'s Lemma P, and FS-66's `p = 3` certificate gives `FibreShareBound 3`.
-/

namespace HadwigerNelson.CertLink

open SpectralChain NumberField FibreCertSound Finset

noncomputable section

variable {F : Subfield ℝ}

/-- **The norm-one set at level `m`**: `{x : x·x̄ = 1}` in `𝓞 ⧸ P^m`, the connection set of `levelTarget P m`. -/
def normOneSet (P : StablePrime F) (m : ℕ) : Set (𝓞 (fieldI F) ⧸ P.P ^ m) :=
  {x | x * Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) x = 1}

/-- **The quotient map from level `n + 1` to level one.** -/
def toLevelOne (P : StablePrime F) (n : ℕ) : (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) →+* (𝓞 (fieldI F) ⧸ P.P ^ 1) :=
  Ideal.Quotient.factor (Ideal.pow_le_pow_right (Nat.le_add_left 1 n))

open Classical in
/-- **Hensel's count of norm-one lifts** (FS-66's SOUNDNESS § 1): every norm-one residue at level one has exactly `Q^n`
norm-one lifts at level `n + 1`. At a stable prime not above `2` with `|𝓞 ⧸ P| = Q²` it is a theorem of
`Rigidity/ClassRatio` (Lemma P's fibre count, FS131-ICM2). -/
def HenselCount (P : StablePrime F) (Q : ℕ) : Prop :=
  ∀ (n : ℕ) (hfin : (normOneSet P (n + 1)).Finite) {t : 𝓞 (fieldI F) ⧸ P.P ^ 1}, t ∈ normOneSet P 1 →
    (hfin.toFinset.filter fun x => toLevelOne P n x = t).card = Q ^ n

/-- **The bound on characters new above level one** (FS-66's L1, SOUNDNESS § 1): every additive character of
`𝓞 ⧸ P^{n+1}` that is not trivial on the kernel of the map to level one sums over the norm-one set to at most `2Q^n`
in modulus. At a stable prime not above `2` with `|𝓞 ⧸ P| = Q²` it is a theorem of `Rigidity/ClassRatio` (Lemma P,
FS131-ICM2: X26B-L1 at each level and the descent between levels). -/
def NewCharBound (P : StablePrime F) (Q : ℕ) : Prop :=
  ∀ (n : ℕ) (hfin : (normOneSet P (n + 1)).Finite) (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) ℂ),
    (∃ e, toLevelOne P n e = 0 ∧ ψ e ≠ 1) → ‖∑ s ∈ hfin.toFinset, ψ s‖ ≤ 2 * (Q : ℝ) ^ n

/-- **FS-66's fibre-share bound at `p` with constant `U`** (SOUNDNESS § 0 and L4): every `φ : (ℤ/p)² → [0, 1]` with
`q(φ) = 2·Σ_x φ_x (1 − φ_x) − Σ_x Σ_{s ∈ S} φ_x φ_{x+s} ≥ 0` has `Σ φ ≤ U`. -/
def FibreShareBound (p : ℕ) [NeZero p] (U : ℝ) : Prop :=
  ∀ φ : V p → ℝ, (∀ x, 0 ≤ φ x) → (∀ x, φ x ≤ 1) → 0 ≤ qform p φ → ∑ x, φ x ≤ U

/-- **`FibreShareBound` at `p = 11`**, from FS-66's certificate (`FibreCertSound.sum_le_eleven`). -/
theorem fibreShareBound_eleven :
    FibreShareBound 11 ((28204320001863099628721379861820 : ℝ) / 1000000000000000000000000000000) :=
  fun φ h0 h1 hq => sum_le_eleven φ h0 h1 hq

/-! ### The tower's maps -/

/-- The residue rings at a stable prime are finite. -/
theorem finite_quotient_pow [NumberField F] (P : StablePrime F) (m : ℕ) : Finite (𝓞 (fieldI F) ⧸ P.P ^ m) :=
  Ideal.finiteQuotientOfFreeOfNeBot _ (pow_ne_zero m P.heightOne.ne_bot)

theorem toLevelOne_mk (P : StablePrime F) (n : ℕ) (a : 𝓞 (fieldI F)) :
    toLevelOne P n (Ideal.Quotient.mk _ a) = Ideal.Quotient.mk _ a := Ideal.Quotient.factor_mk _ a

theorem toLevelOne_surjective (P : StablePrime F) (n : ℕ) : Function.Surjective (toLevelOne P n) :=
  Ideal.Quotient.factor_surjective _

/-- The map to level one carries the norm-one set into the norm-one set. -/
theorem toLevelOne_mem_normOneSet (P : StablePrime F) (n : ℕ) {x : 𝓞 (fieldI F) ⧸ P.P ^ (n + 1)}
    (hx : x ∈ normOneSet P (n + 1)) : toLevelOne P n x ∈ normOneSet P 1 := by
  obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective x
  have hx' : Ideal.Quotient.mk _ a * Ideal.quotientMap (P.P ^ (n + 1)) (conjO F) (P.le_comap (n + 1))
      (Ideal.Quotient.mk _ a) = 1 := hx
  show toLevelOne P n (Ideal.Quotient.mk _ a) * Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1)
    (toLevelOne P n (Ideal.Quotient.mk _ a)) = 1
  rw [Ideal.quotientMap_mk] at hx'
  rw [toLevelOne_mk, Ideal.quotientMap_mk, ← map_mul, ← toLevelOne_mk P n, map_mul, hx', map_one]

/-- `0` is not of norm one at any level `m ≥ 1` (the residue ring is not zero). -/
theorem zero_notMem_normOneSet (P : StablePrime F) {m : ℕ} (hm : 1 ≤ m) :
    (0 : 𝓞 (fieldI F) ⧸ P.P ^ m) ∉ normOneSet P m := by
  intro h
  have h1 : (0 : 𝓞 (fieldI F) ⧸ P.P ^ m) = 1 := by
    have h' : (0 : 𝓞 (fieldI F) ⧸ P.P ^ m) * Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) 0 = 1 := h
    rw [zero_mul] at h'
    exact h'
  have hmem : (1 : 𝓞 (fieldI F)) ∈ P.P ^ m := by
    rw [← Ideal.Quotient.eq_zero_iff_mem, map_one]
    exact h1.symm
  exact P.isMaximal.ne_top ((Ideal.eq_top_iff_one _).2 (Ideal.pow_le_self (by omega) hmem))

/-! ### K3: the level-one target in coordinates -/

/-- **K3** (KC13 § 5.2): at a stable prime not above `2` with `|𝓞 ⧸ P| = q²`, `q` prime, the residue field is `(ℤ/q)²`
as an additive group, by `x ↦ (Re x, Im x)` read through `𝔽_q[i]`, and the norm-one set is the unit circle
`{a² + b² = 1}` there. (`x = a + bι` with `a = (x + x̄)/2`, `b = −ι(x − x̄)/2` in the fixed field `𝔽_q`; `x·x̄ = a² + b²`.) -/
theorem exists_addEquiv_zmod [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {q : ℕ}
    (hq : q.Prime) (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = q ^ 2) :
    ∃ e : (𝓞 (fieldI F) ⧸ P.P ^ 1) ≃+ (ZMod q × ZMod q),
      ∀ x, x ∈ normOneSet P 1 ↔ (e x).1 ^ 2 + (e x).2 ^ 2 = 1 := by
  classical
  haveI : NeZero q := ⟨hq.ne_zero⟩
  haveI hmax : (P.P ^ 1).IsMaximal := by rw [pow_one]; exact P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P ^ 1) := Ideal.Quotient.field (P.P ^ 1)
  haveI := finite_quotient_pow P 1
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
  have hk₀ : Nat.card k₀ = q := by
    have e : Nat.card k₀ ^ 2 = q ^ 2 := by rw [← hcard0, ← hQ, pow_one]
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
  obtain ⟨e⟩ := Arith.nonempty_ringEquiv_zmod_of_card hq hk₀
  -- the two coordinates, as additive maps
  let A : (𝓞 (fieldI F) ⧸ P.P ^ 1) →+ ZMod q := AddMonoidHom.mk' (fun x => e ⟨_, ha x⟩) fun x y => by
    rw [← map_add e]
    congr 1
    apply Subtype.ext
    show u * (x + y + σ (x + y)) = u * (x + σ x) + u * (y + σ y)
    rw [map_add]
    ring
  let B : (𝓞 (fieldI F) ⧸ P.P ^ 1) →+ ZMod q := AddMonoidHom.mk' (fun x => e ⟨_, hb x⟩) fun x y => by
    rw [← map_add e]
    congr 1
    apply Subtype.ext
    show -(u * ι * (x + y - σ (x + y))) = -(u * ι * (x - σ x)) + -(u * ι * (y - σ y))
    rw [map_add]
    ring
  have hA : ∀ x, A x = e ⟨_, ha x⟩ := fun _ => rfl
  have hB : ∀ x, B x = e ⟨_, hb x⟩ := fun _ => rfl
  -- every element of `k₀` is the cast of a natural number
  have hcast : ∀ y : k₀, (y : 𝓞 (fieldI F) ⧸ P.P ^ 1) = ((e y).val : 𝓞 (fieldI F) ⧸ P.P ^ 1) := by
    intro y
    have h1 : y = e.symm (((e y).val : ℕ) : ZMod q) := by rw [ZMod.natCast_zmod_val, RingEquiv.symm_apply_apply]
    conv_lhs => rw [h1, map_natCast]
    push_cast
    rfl
  have hdec : ∀ x, x = ((A x).val : 𝓞 (fieldI F) ⧸ P.P ^ 1) + ((B x).val : 𝓞 (fieldI F) ⧸ P.P ^ 1) * ι := by
    intro x
    rw [hA, hB, ← hcast ⟨_, ha x⟩, ← hcast ⟨_, hb x⟩]
    show x = u * (x + σ x) + -(u * ι * (x - σ x)) * ι
    linear_combination (-x) * hu + u * (x - σ x) * hι
  have hnorm : ∀ x, x * σ x = 1 ↔ (A x) ^ 2 + (B x) ^ 2 = 1 := by
    intro x
    have hk : (⟨_, ha x⟩ : k₀) ^ 2 + (⟨_, hb x⟩ : k₀) ^ 2 = ⟨_, hN0 x⟩ := by
      apply Subtype.ext
      push_cast
      linear_combination (2 * u + 1) * x * σ x * hu + u ^ 2 * (x - σ x) ^ 2 * hι
    have e1 : (A x) ^ 2 + (B x) ^ 2 = e ⟨_, hN0 x⟩ := by
      rw [hA, hB, ← map_pow, ← map_pow, ← map_add, hk]
    rw [e1, ← map_one e, e.injective.eq_iff, Subtype.ext_iff]
    rfl
  -- the coordinate map is a bijection onto the plane
  have hinj : Function.Injective (A.prod B) := by
    intro x y hxy
    simp only [AddMonoidHom.prod_apply, Prod.mk.injEq] at hxy
    rw [hdec x, hdec y, hxy.1, hxy.2]
  have hbij : Function.Bijective (A.prod B) := by
    refine (Fintype.bijective_iff_injective_and_card _).2 ⟨hinj, ?_⟩
    rw [Fintype.card_prod, ZMod.card, ← Nat.card_eq_fintype_card, ← sq, ← hQ, pow_one]
  refine ⟨AddEquiv.ofBijective (A.prod B) hbij, fun x => ?_⟩
  rw [AddEquiv.ofBijective_apply, AddMonoidHom.prod_apply]
  exact hnorm x

/-! ### K4: the fibre shares at every level -/

/-- **K4** (KC13 § 5.2; FS-66's L1 and L2 at a stable prime): at a stable prime not above `2` with `|𝓞 ⧸ P| = q²`, `q`
prime, Hensel's count and the bound on new characters make every bound `Σ φ ≤ U` on FS-66's region a bound
`|I| ≤ (U/q²)·|𝓞 ⧸ P^m|` on every independent set `I` of every level's target. Model of the stable-prime hypotheses:
`exists_stablePrime_sqrt_three` (`Rigidity/CertLinkModels`, `q = 3`); `HenselCount` and `NewCharBound` hold at every stable
prime not above `2` by `Rigidity/ClassRatio`'s Lemma P. -/
theorem card_le_of_fibreShareBound [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {q : ℕ}
    [NeZero q] (hq : q.Prime) (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = q ^ 2) (hH : HenselCount P q)
    (hL : NewCharBound P q) {U : ℝ} (hU : FibreShareBound q U) (m : ℕ) (hm : 1 ≤ m)
    (s : Finset (𝓞 (fieldI F) ⧸ P.P ^ m)) (hs : (levelTarget P m).IsIndepSet (s : Set _)) :
    (s.card : ℝ) ≤ U / q ^ 2 * Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) := by
  classical
  obtain ⟨n, rfl⟩ : ∃ n, m = n + 1 := ⟨m - 1, by omega⟩
  haveI := finite_quotient_pow P (n + 1)
  haveI := finite_quotient_pow P 1
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) := Fintype.ofFinite _
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ 1) := Fintype.ofFinite _
  have hfin : (normOneSet P (n + 1)).Finite := Set.toFinite _
  have hfin1 : (normOneSet P 1).Finite := Set.toFinite _
  set π : (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) →+ (𝓞 (fieldI F) ⧸ P.P ^ 1) := (toLevelOne P n).toAddMonoidHom with hπdef
  have hπ : ∀ x, π x = toLevelOne P n x := fun _ => rfl
  have hπs : Function.Surjective π := toLevelOne_surjective P n
  -- independence: no difference of `s` is of norm one
  have hI : ∀ x ∈ s, ∀ y ∈ s, x - y ∉ hfin.toFinset := by
    intro x hx y hy hxy
    rw [Set.Finite.mem_toFinset] at hxy
    by_cases hne : x = y
    · rw [hne, sub_self] at hxy
      exact zero_notMem_normOneSet P (by omega) hxy
    · exact hs hx hy hne ((SimpleGraph.fromRel_adj _ _ _).2 ⟨hne, Or.inl hxy⟩)
  -- L2 at level `n + 1`
  have hL2 := FibreShare.fibreShare_le π hπs hfin.toFinset hfin1.toFinset (q ^ n)
    (fun x hx => by
      rw [Set.Finite.mem_toFinset] at hx ⊢
      exact toLevelOne_mem_normOneSet P n hx)
    (fun t ht => by
      convert hH n hfin ((Set.Finite.mem_toFinset _).1 ht)
      all_goals rfl)
    (fun ψ hψ => by
      have hb := hL n hfin ψ hψ
      have hre := Complex.abs_re_le_norm (∑ x ∈ hfin.toFinset, ψ x)
      push_cast
      linarith [neg_abs_le (∑ x ∈ hfin.toFinset, ψ x).re])
    s hI
  -- the sizes: `|H| = q²`, every fibre has `K = |G|/|H|` points, `|s| = Σ n`
  set n' : (𝓞 (fieldI F) ⧸ P.P ^ 1) → ℝ := fun u => (FibreShare.fibreCount π s u : ℝ) with hn'
  have hHq : (Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1) : ℝ) = (q : ℝ) ^ 2 := by
    rw [← Nat.card_eq_fintype_card, pow_one, hQ]
    exact Nat.cast_pow q 2
  have hHpos : (0 : ℝ) < Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1) := by
    rw [hHq]; exact pow_pos (Nat.cast_pos.2 hq.pos) 2
  set K : ℝ := (Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) : ℝ) / Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1)
    with hKdef
  have hGK : (Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) : ℝ) = K * Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1) := by
    rw [hKdef, div_mul_cancel₀ _ hHpos.ne']
  have hfibK : ∀ u : 𝓞 (fieldI F) ⧸ P.P ^ 1, ((univ.filter fun x => π x = u).card : ℝ) = K := by
    intro u
    have h := FibreShare.card_fibre_mul π hπs u
    rw [hKdef, eq_div_iff hHpos.ne']
    exact_mod_cast h
  have hKpos : 0 < K := by
    have h := hfibK 0
    have hne : (univ.filter fun x => π x = 0).Nonempty := by
      obtain ⟨x, hx⟩ := hπs 0
      exact ⟨x, mem_filter.2 ⟨mem_univ _, hx⟩⟩
    rw [← h]
    exact_mod_cast hne.card_pos
  have hnK : ∀ u, n' u ≤ K := by
    intro u
    rw [← hfibK u]
    show ((FibreShare.fibreCount π s u : ℕ) : ℝ) ≤ _
    exact_mod_cast card_le_card (filter_subset_filter _ (subset_univ s))
  have hn0 : ∀ u, 0 ≤ n' u := fun u => Nat.cast_nonneg _
  have hsum : (s.card : ℝ) = ∑ u, n' u := by
    rw [card_eq_sum_card_fiberwise (f := π) (t := univ) (fun _ _ => mem_univ _)]
    push_cast
    rfl
  -- L2 in fibre shares: `Σ_u Σ_t n_u n_{u+t} ≤ 2 Σ_u n_u (K − n_u)`
  have hX : ∑ u, ∑ t ∈ hfin1.toFinset, n' u * n' (u + t) ≤ 2 * ∑ u, n' u * (K - n' u) := by
    have hc : (0 : ℝ) < ((q ^ n : ℕ) : ℝ) * Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1) := by
      have : (0 : ℝ) < ((q ^ n : ℕ) : ℝ) := Nat.cast_pos.2 (pow_pos hq.pos n)
      positivity
    have hs2 : ∑ u, n' u * (K - n' u) = K * ∑ u, n' u - ∑ u, n' u ^ 2 := by
      rw [mul_sum, ← sum_sub_distrib]
      exact sum_congr rfl fun u _ => by ring
    have e2 : 2 * ((q ^ n : ℕ) : ℝ) * (Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) * s.card -
        Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1) * ∑ u, n' u ^ 2) =
        ((q ^ n : ℕ) : ℝ) * Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1) * (2 * ∑ u, n' u * (K - n' u)) := by
      rw [hGK, hsum, hs2]
      ring
    have hL2' : ((q ^ n : ℕ) : ℝ) * Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1) *
        ∑ u, ∑ t ∈ hfin1.toFinset, n' u * n' (u + t) ≤
        2 * ((q ^ n : ℕ) : ℝ) * (Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) * s.card -
          Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1) * ∑ u, n' u ^ 2) := hL2
    rw [e2] at hL2'
    exact le_of_mul_le_mul_left hL2' hc
  -- K3: the fibre shares on `(ℤ/q)²`
  obtain ⟨e, he⟩ := exists_addEquiv_zmod P h2 hq hQ
  set φ : V q → ℝ := fun v => n' (e.symm v) / K with hφ
  have hφe : ∀ x, φ (e x) = n' x / K := fun x => by rw [hφ]; simp only [AddEquiv.symm_apply_apply]
  have htr : ∀ g : V q → ℝ, ∑ v, g v = ∑ x, g (e x) := fun g =>
    (Fintype.sum_equiv e.toEquiv (fun x => g (e x)) g fun _ => rfl).symm
  have hcirc : ∀ g : V q → ℝ, ∑ w ∈ FibreCertSound.unitCircle q, g w = ∑ t ∈ hfin1.toFinset, g (e t) := by
    intro g
    symm
    refine sum_nbij' (fun t => e t) (fun w => e.symm w) ?_ ?_ ?_ ?_ ?_
    · intro t ht
      rw [Set.Finite.mem_toFinset] at ht
      rw [FibreCertSound.unitCircle, mem_filter]
      exact ⟨mem_univ _, (he t).1 ht⟩
    · intro w hw
      rw [FibreCertSound.unitCircle, mem_filter] at hw
      rw [Set.Finite.mem_toFinset, he, AddEquiv.apply_symm_apply]
      exact hw.2
    · intro t _
      exact e.symm_apply_apply t
    · intro w _
      exact e.apply_symm_apply w
    · intro t _
      rfl
  have h0 : ∀ v, 0 ≤ φ v := fun v => div_nonneg (hn0 _) hKpos.le
  have h1 : ∀ v, φ v ≤ 1 := fun v => (div_le_one hKpos).2 (hnK _)
  have hqf : 0 ≤ qform q φ := by
    have hA1 : ∑ v, φ v * (1 - φ v) = ∑ u, n' u / K * (1 - n' u / K) := by
      rw [htr]
      simp only [hφe]
    have hA2 : ∑ v, ∑ w ∈ FibreCertSound.unitCircle q, φ v * φ (v + w) =
        ∑ u, ∑ t ∈ hfin1.toFinset, n' u / K * (n' (u + t) / K) := by
      rw [htr]
      refine sum_congr rfl fun u _ => ?_
      show ∑ w ∈ FibreCertSound.unitCircle q, φ (e u) * φ (e u + w) = _
      rw [hcirc]
      refine sum_congr rfl fun t _ => ?_
      show φ (e u) * φ (e u + e t) = _
      rw [← map_add e, hφe, hφe]
    have hK0 : K ≠ 0 := hKpos.ne'
    have e3 : K ^ 2 * qform q φ =
        2 * ∑ u, n' u * (K - n' u) - ∑ u, ∑ t ∈ hfin1.toFinset, n' u * n' (u + t) := by
      unfold qform
      rw [hA1, hA2, mul_sub]
      congr 1
      · rw [mul_left_comm, mul_sum]
        congr 1
        refine sum_congr rfl fun u _ => ?_
        field_simp
        try ring
      · rw [mul_sum]
        refine sum_congr rfl fun u _ => ?_
        rw [mul_sum]
        refine sum_congr rfl fun t _ => ?_
        field_simp
        try ring
    have hK2 : 0 < K ^ 2 := pow_pos hKpos 2
    have : 0 ≤ K ^ 2 * qform q φ := by rw [e3]; linarith
    exact (mul_nonneg_iff_of_pos_left hK2).1 this
  have hsumφ := hU φ h0 h1 hqf
  rw [htr] at hsumφ
  simp only [hφe] at hsumφ
  rw [← sum_div, ← hsum, div_le_iff₀ hKpos] at hsumφ
  have hq2 : (0 : ℝ) < (q : ℝ) ^ 2 := pow_pos (Nat.cast_pos.2 hq.pos) 2
  have hGq : ((Nat.card (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) : ℕ) : ℝ) = K * (q : ℝ) ^ 2 := by
    rw [Nat.card_eq_fintype_card, hGK, hHq]
  rw [hGq]
  have hq0 : (q : ℝ) ≠ 0 := Nat.cast_ne_zero.2 hq.ne_zero
  have e4 : U / (q : ℝ) ^ 2 * (K * (q : ℝ) ^ 2) = U * K := by field_simp
  rw [e4]
  exact hsumφ

/-! ### K5 and the composition -/

/-- **The level-all ratio at `q = 11`** (K5 with FS-66's certificate): `U₁₁/121 = 0.2331… < 1/4`. -/
theorem ratioAtMost_eleven [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P)
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = 11 ^ 2) (hH : HenselCount P 11) (hL : NewCharBound P 11) :
    ∃ c : ℝ, c < 1 / 4 ∧ ∀ m : ℕ, 1 ≤ m → ∀ s : Finset (𝓞 (fieldI F) ⧸ P.P ^ m),
      (levelTarget P m).IsIndepSet (s : Set _) → (s.card : ℝ) ≤ c * Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) :=
  ⟨_, by norm_num, fun m hm s hs =>
    card_le_of_fibreShareBound P h2 (by norm_num) hQ hH hL fibreShareBound_eleven m hm s hs⟩

/-- **The level-all ratio at `q = 19`** over a fibre-share bound below `361/4`. -/
theorem ratioAtMost_nineteen [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P)
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = 19 ^ 2) (hH : HenselCount P 19) (hL : NewCharBound P 19)
    (h19 : ∃ U : ℝ, U < 361 / 4 ∧ FibreShareBound 19 U) :
    ∃ c : ℝ, c < 1 / 4 ∧ ∀ m : ℕ, 1 ≤ m → ∀ s : Finset (𝓞 (fieldI F) ⧸ P.P ^ m),
      (levelTarget P m).IsIndepSet (s : Set _) → (s.card : ℝ) ≤ c * Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) := by
  obtain ⟨U, hU, hb⟩ := h19
  refine ⟨U / ((19 : ℕ) : ℝ) ^ 2, ?_, fun m hm s hs =>
    card_le_of_fibreShareBound P h2 (by norm_num) hQ hH hL hb m hm s hs⟩
  rw [div_lt_iff₀ (by norm_num)]
  push_cast
  linarith

/-- **The certificate branch at `q ∈ {11, 19}`** (KC13 § 5.2, K1–K5): the statement `Rigidity/ClassRatio`'s leaf
`ratioAtMost_cert` asks for, with `RatioAtMost P c`'s body written out — at `q = 11` from FS-66's certificate, at
`q = 19` from a fibre-share bound below `361/4`; Hensel's count and the bound on new characters as hypotheses. -/
theorem ratioAtMost_cert_link [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hQ1119 : Q = 11 ∨ Q = 19) (hH : HenselCount P Q)
    (hL : NewCharBound P Q) (h19 : ∃ U : ℝ, U < 361 / 4 ∧ FibreShareBound 19 U) :
    ∃ c : ℝ, c < 1 / 4 ∧ ∀ m : ℕ, 1 ≤ m → ∀ s : Finset (𝓞 (fieldI F) ⧸ P.P ^ m),
      (levelTarget P m).IsIndepSet (s : Set _) → (s.card : ℝ) ≤ c * Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) := by
  rcases hQ1119 with rfl | rfl
  · exact ratioAtMost_eleven P h2 hQ hH hL
  · exact ratioAtMost_nineteen P h2 hQ hH hL h19

end

end HadwigerNelson.CertLink
