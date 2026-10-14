import Proofs.HadwigerNelson.Rigidity.ContinuityGroup
import Proofs.HadwigerNelson.Rigidity.Herglotz
import Mathlib.Analysis.Fourier.FiniteAbelian.PontryaginDuality
import Mathlib.Algebra.Order.Chebyshev

/-!
# Bochner's theorem for the topology `τ′_∅` (FS-131, job FS131-KR1; module M2b)

**Read aloud, against the informal claim.** `bochnerOn_tauPrime : BochnerOn (tauPrime F)`: a finite measure on the dual of
`R = ℤ[U_F]` whose Fourier transform is continuous for the profinite-plus-archimedean topology is carried by the continuous
characters, which are `T + A` (`contChars_tauPrime`). It is J45 N2's `⟸` at `S = ∅` (`plans/FS84-SI-D-derivation.md`
ll. 128–130), the hypothesis `SpectralInputs.spectral_carried_iff` takes. The printed source of the step is Bochner's
theorem on a locally compact abelian group (`[Rudin1962]` 1.4.3, not held); this module proves it with no Bochner theorem on
`ℝ^m` and no profinite completion (`plans/FS131-KR1-chain-map.md` § 2.1, M2b).

**Route.** (1) `archimedean_support`: a measure whose transform is continuous for `archTop` is carried by `A` — restrict to
the lattices `5^{−k}c₀𝓞_L ⊆ R`, lift from their dual tori to `V*` through a box fundamental domain, bound the mass far out by
a one-variable Dirichlet-kernel inequality (tightness, uniform in `k`), take a limit by Prokhorov
(`isCompact_closure_of_isTightMeasureSet`), and compare the limit's characteristic function with the transform on the dense
subgroup `ℤ[1/5]c₀𝓞_L`; uniqueness (`measure_eq_of_fourier`) concludes. (2) `finite_quotient_nsmul` (J28V-7, `[LevitzMott1972]`
Thm 2.3): `R ⧸ N·R` is finite. (3) The profinite part: twisted Riemann sums over `R ⧸ N′·R` split `φ` into `Σ_{t ∈ T} ψ_t` with
each `t̄·ψ_t` positive-definite and archimedean-continuous; (1) carries each piece by `t·A`.

**Models.** `F = ⊥`; the point mass at the trivial character has constant transform, continuous for every topology, and is
carried by `TA F` (`one_mem_TA`).
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory SpectralChain SpectralInputs NumberField Filter Topology

noncomputable section

variable (F : Subfield ℝ)

/-- The inclusion `R → L`, additive. -/
private def toFieldI : unitRing F →+ fieldI F where
  toFun r := ⟨(r : ℂ), UnitRing.unitRingOver_le_planeOverSubring F r.2⟩
  map_zero' := rfl
  map_add' _ _ := rfl

private theorem toFieldI_injective : Function.Injective (toFieldI F) := fun _ _ h =>
  Subtype.ext (congrArg (fun z : fieldI F => (z : ℂ)) h)

/-- **J28V-7**: `N·R` has finite index in `R = ℤ[U_F]` for every `N ≥ 1` (`R` is torsion-free of rank `[L : ℚ]`). -/
theorem finite_quotient_nsmul [NumberField F] (N : ℕ) (hN : N ≠ 0) :
    Finite (unitRing F ⧸ (nsmulAddMonoidHom (α := unitRing F) N).range) := by
  classical
  haveI : NeZero N := ⟨hN⟩
  set H := (nsmulAddMonoidHom (α := unitRing F) N).range with hH
  set d := Module.finrank ℚ (fieldI F) with hd
  by_contra hfin
  rw [not_finite_iff_infinite] at hfin
  obtain ⟨s, hs⟩ := Infinite.exists_subset_card_eq (unitRing F ⧸ H) (N ^ d + 1)
  -- lifts of the members of `s`, and the finitely generated group `B` they span
  let lift : s → unitRing F := fun g => Quotient.out (g : unitRing F ⧸ H)
  have hlift : ∀ g : s, ((lift g : unitRing F) : unitRing F ⧸ H) = g := fun g => QuotientAddGroup.out_eq' _
  let B : Submodule ℤ (unitRing F) := Submodule.span ℤ (Set.range lift)
  haveI : Module.Finite ℤ B := Module.Finite.span_of_finite ℤ (Set.finite_range lift)
  haveI : Module.Free ℤ B := Module.free_of_finite_type_torsion_free'
  set r := Module.finrank ℤ B with hr
  let bB := Module.finBasis ℤ B
  -- the rank of `B` is at most `[L : ℚ]`
  have hrd : r ≤ d := by
    let f : B →ₗ[ℤ] fieldI F := (toFieldI F).toIntLinearMap.comp B.subtype
    have hf : LinearMap.ker f = ⊥ := LinearMap.ker_eq_bot.2 fun a b hab =>
      Subtype.ext (toFieldI_injective F hab)
    have hli : LinearIndependent ℤ (f ∘ bB) := bB.linearIndependent.map' f hf
    have := ((LinearIndependent.iff_fractionRing ℤ ℚ).mp hli).fintype_card_le_finrank
    simpa using this
  -- the coordinates modulo `N`: two members of `s` agree, so they are equal
  let mem : ∀ g : s, lift g ∈ B := fun g => Submodule.subset_span ⟨g, rfl⟩
  let co : s → (Fin r → ZMod N) := fun g i => ((bB.repr ⟨lift g, mem g⟩ i : ℤ) : ZMod N)
  have hcard : Fintype.card (Fin r → ZMod N) < Fintype.card s := by
    rw [Fintype.card_fun, ZMod.card, Fintype.card_fin, Fintype.card_coe, hs]
    have : N ^ r ≤ N ^ d := Nat.pow_le_pow_right (Nat.pos_of_ne_zero hN) hrd
    omega
  obtain ⟨g₁, g₂, hne, heq⟩ := Fintype.exists_ne_map_eq_of_card_lt co hcard
  apply hne
  -- the difference has coordinates divisible by `N`
  have hdiv : ∀ i, ∃ e : ℤ, bB.repr (⟨lift g₁, mem g₁⟩ - ⟨lift g₂, mem g₂⟩) i = N * e := by
    intro i
    have h := congrFun heq i
    rw [map_sub, Finsupp.sub_apply]
    have h' : (((bB.repr ⟨lift g₁, mem g₁⟩ i - bB.repr ⟨lift g₂, mem g₂⟩ i : ℤ)) : ZMod N) = 0 := by
      push_cast
      exact sub_eq_zero.2 h
    exact (ZMod.intCast_zmod_eq_zero_iff_dvd _ N).1 h'
  choose e he using hdiv
  have hv : (⟨lift g₁, mem g₁⟩ - ⟨lift g₂, mem g₂⟩ : B) = (N : ℤ) • ∑ i, e i • bB i := by
    rw [← bB.sum_repr (⟨lift g₁, mem g₁⟩ - ⟨lift g₂, mem g₂⟩), Finset.smul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [he i, smul_smul]
  have hmem : -lift g₁ + lift g₂ ∈ H := by
    have h2 := congrArg (fun v : B => (v : unitRing F)) hv
    simp only [Submodule.coe_sub, Submodule.coe_smul] at h2
    refine ⟨-((∑ i, e i • bB i : B) : unitRing F), ?_⟩
    rw [nsmulAddMonoidHom_apply, smul_neg, ← natCast_zsmul, ← h2]
    abel
  apply Subtype.ext
  rw [← hlift g₁, ← hlift g₂]
  exact QuotientAddGroup.eq.2 hmem

/-! ### Private helpers for `archimedean_support`: coordinates in `R`, the lattices `5^{−k}`, tightness, the limit -/

section ArchSupport

/-- `c·𝓞_L ⊆ R` (`ContinuityGroup`'s private `exists_nat_mul_integers_mem`, restated with its proof). -/
private theorem as_natMul_integers_mem [NumberField F] : ∃ c : ℕ, c ≠ 0 ∧ ∀ a : 𝓞 (fieldI F),
    (c : fieldI F) * (a : fieldI F) ∈ UnitRing.unitRing (conjOn (fieldI_conj F)) := by
  obtain ⟨c, hc, hcO⟩ := exists_mul_stableIntegers_le F
  refine ⟨c, hc, fun a => hcO _ ((mem_stableIntegers F).2 fun P => (UpperHalf.mem_localRing P).2
    ⟨a, 1, fun h => P.isMaximal.ne_top ((Ideal.eq_top_iff_one _).2 h), by simp⟩)⟩

open scoped Classical in
/-- **Rational coordinates along a `ℚ`-basis of `L` lying in `R`**: `q j (b i) = δ_{ij}`, and the coordinates of a point
determine it. (`b i = c·ω_i` for an integral basis `ω` and `c·𝓞_L ⊆ R`.) -/
private theorem as_exists_coords [NumberField F] :
    ∃ (ι : Type) (_ : Fintype ι) (b : ι → unitRing F) (q : ι → unitRing F →+ ℚ),
      (∀ i j, q j (b i) = if i = j then 1 else 0) ∧ Function.Injective (fun y j => q j y) := by
  classical
  obtain ⟨c, hc, hcR⟩ := as_natMul_integers_mem F
  let B := RingOfIntegers.basis (fieldI F)
  let β := integralBasis (fieldI F)
  have hβ : ∀ i, β i = (B i : fieldI F) := fun i => integralBasis_apply _ i
  have hc' : (c : ℚ) ≠ 0 := Nat.cast_ne_zero.2 hc
  let b : Module.Free.ChooseBasisIndex ℤ (𝓞 (fieldI F)) → unitRing F := fun i =>
    ⟨(((c : fieldI F) * (B i : fieldI F) : fieldI F) : ℂ), (UnitRing.coe_mem_unitRingOver_iff _).2 (hcR (B i))⟩
  let q : Module.Free.ChooseBasisIndex ℤ (𝓞 (fieldI F)) → unitRing F →+ ℚ := fun j =>
    AddMonoidHom.mk' (fun y => β.repr (toFieldI F y) j / c) fun y y' => by
      rw [map_add, map_add, Finsupp.add_apply, add_div]
  refine ⟨_, inferInstance, b, q, fun i j => ?_, fun y y' h => ?_⟩
  · have hb : toFieldI F (b i) = (c : ℚ) • β i := by
      rw [Rat.smul_def, Rat.cast_natCast, hβ]
      rfl
    show β.repr (toFieldI F (b i)) j / c = _
    rw [hb, map_smul, β.repr_self, Finsupp.smul_apply, Finsupp.single_apply, smul_eq_mul]
    split_ifs <;> simp [hc']
  · have hr : β.repr (toFieldI F y) = β.repr (toFieldI F y') := by
      ext j
      have := congrFun h j
      simp only [q, AddMonoidHom.mk'_apply] at this
      exact (div_left_inj' hc').1 this
    exact toFieldI_injective F (β.repr.injective hr)

variable {F}

/-- A character of `R` on a finite sum is the product of its values. -/
private theorem as_char_sum {ι : Type} (χ : Dual F) (s : Finset ι) (f : ι → unitRing F) :
    χ (∑ i ∈ s, f i) = ∏ i ∈ s, χ (f i) := by
  classical
  refine Finset.induction_on s (by simp [AddChar.map_zero_eq_one]) ?_
  intro a s ha ih
  rw [Finset.sum_insert ha, Finset.prod_insert ha, AddChar.map_add_eq_mul, ih]

/-- `Circle.exp` of a finite sum is the product. -/
private theorem as_exp_sum {ι : Type} (s : Finset ι) (f : ι → ℝ) :
    Circle.exp (∑ i ∈ s, f i) = ∏ i ∈ s, Circle.exp (f i) := by
  classical
  refine Finset.induction_on s (by simp [Circle.exp_zero]) ?_
  intro a s ha ih
  rw [Finset.sum_insert ha, Finset.prod_insert ha, Circle.exp_add, ih]

open scoped Classical in
/-- **The coordinates of a lattice point**: `5^k · q j (Σ_i z_i • b_i/5^k) = z_j`. -/
private theorem as_q_lat {ι : Type} [Fintype ι] {b : ι → unitRing F} {q : ι → unitRing F →+ ℚ}
    (hqb : ∀ i j, q j (b i) = if i = j then 1 else 0) (k : ℕ) (z : ι → ℤ) (j : ι) :
    (5 : ℚ) ^ k * q j (∑ i, z i • fivePow F k (b i)) = z j := by
  classical
  have h5 : ∀ i, (5 : ℚ) ^ k * q j (fivePow F k (b i)) = if i = j then 1 else 0 := by
    intro i
    rw [← hqb i j]
    conv_rhs => rw [← nsmul_fivePow F k (b i)]
    rw [map_nsmul, nsmul_eq_mul]
    push_cast
    ring
  rw [map_sum, Finset.mul_sum]
  simp only [map_zsmul]
  simp only [zsmul_eq_mul]
  calc ∑ i, (5 : ℚ) ^ k * ((z i : ℚ) * q j (fivePow F k (b i)))
      = ∑ i, (z i : ℚ) * ((5 : ℚ) ^ k * q j (fivePow F k (b i))) :=
        Finset.sum_congr rfl fun i _ => by ring
    _ = z j := by simp only [h5, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]

open scoped Classical in
/-- **A point with integral scaled coordinates is the lattice point** with those coordinates. -/
private theorem as_eq_lat {ι : Type} [Fintype ι] {b : ι → unitRing F} {q : ι → unitRing F →+ ℚ}
    (hqb : ∀ i j, q j (b i) = if i = j then 1 else 0) (hinj : Function.Injective (fun y j => q j y)) (k : ℕ)
    (y : unitRing F) (z : ι → ℤ) (hz : ∀ j, (5 : ℚ) ^ k * q j y = z j) :
    y = ∑ i, z i • fivePow F k (b i) := by
  apply hinj
  funext j
  have h5 : (5 : ℚ) ^ k ≠ 0 := pow_ne_zero _ (by norm_num)
  exact mul_left_cancel₀ h5 ((hz j).trans (as_q_lat hqb k z j).symm)

/-- A character at a lattice point, through the arguments at the scaled basis. -/
private theorem as_char_lat {ι : Type} [Fintype ι] (b : ι → unitRing F) (χ : Dual F) (k : ℕ) (z : ι → ℤ) :
    χ (∑ i, z i • fivePow F k (b i)) =
      Circle.exp (∑ i, (z i : ℝ) * Complex.arg (χ (fivePow F k (b i)) : ℂ)) := by
  rw [as_char_sum, as_exp_sum]
  refine Finset.prod_congr rfl fun i _ => ?_
  rw [AddChar.map_zsmul_eq_zpow, Circle.exp_intCast_mul, Circle.exp_arg]

open scoped Classical in
/-- **The archimedean size is bounded by the coordinates**: `‖ι(y)‖ ≤ Σ_j |q_j(y)|·‖ι(b_j)‖` (a common denominator `N`
makes `N•y` an integral combination of the `b_j`). -/
private theorem as_norm_archHom_le [NumberField F] {ι : Type} [Fintype ι] {b : ι → unitRing F}
    {q : ι → unitRing F →+ ℚ} (hqb : ∀ i j, q j (b i) = if i = j then 1 else 0)
    (hinj : Function.Injective (fun y j => q j y)) (y : unitRing F) :
    ‖archHom F y‖ ≤ ∑ j, |(q j y : ℝ)| * ‖archHom F (b j)‖ := by
  set N : ℕ := ∏ j, (q j y).den with hN
  have hN0 : N ≠ 0 := Finset.prod_ne_zero_iff.2 fun j _ => (q j y).den_nz
  have hdvd : ∀ j, (q j y).den ∣ N := fun j => Finset.dvd_prod_of_mem _ (Finset.mem_univ j)
  let w : ι → ℤ := fun j => ((N / (q j y).den : ℕ) : ℤ) * (q j y).num
  have hw : ∀ j, (w j : ℚ) = N * q j y := by
    intro j
    obtain ⟨m, hm⟩ := hdvd j
    have hmd : N / (q j y).den = m := by
      rw [hm, Nat.mul_div_cancel_left _ (Nat.pos_of_ne_zero (q j y).den_nz)]
    simp only [w, hmd]
    rw [Int.cast_mul, Int.cast_natCast, ← Rat.mul_den_eq_num, hm]
    push_cast
    ring
  have hNy : N • y = ∑ j, w j • b j := by
    apply hinj
    funext j'
    show q j' (N • y) = q j' (∑ j, w j • b j)
    rw [map_nsmul, map_sum, nsmul_eq_mul, ← hw j']
    simp only [map_zsmul, hqb]
    simp only [smul_ite, smul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true, zsmul_eq_mul, mul_one]
  have hNpos : (0 : ℝ) < N := Nat.cast_pos.2 (Nat.pos_of_ne_zero hN0)
  have hwj : ∀ j, |(w j : ℝ)| = N * |(q j y : ℝ)| := by
    intro j
    have : (w j : ℝ) = N * (q j y : ℝ) := by exact_mod_cast hw j
    rw [this, abs_mul, Nat.abs_cast]
  have h1 : (N : ℝ) * ‖archHom F y‖ ≤ (N : ℝ) * ∑ j, |(q j y : ℝ)| * ‖archHom F (b j)‖ := by
    rw [← norm_archHom_nsmul, hNy, map_sum, Finset.mul_sum]
    calc ‖∑ j, archHom F (w j • b j)‖ ≤ ∑ j, ‖archHom F (w j • b j)‖ := norm_sum_le _ _
      _ = ∑ j, (N : ℝ) * (|(q j y : ℝ)| * ‖archHom F (b j)‖) := by
          refine Finset.sum_congr rfl fun j _ => ?_
          rw [map_zsmul, ← Int.cast_smul_eq_zsmul ℝ, norm_smul, Real.norm_eq_abs, hwj, mul_assoc]
  exact le_of_mul_le_mul_left h1 hNpos

/-- **The one-variable Dirichlet bound**: for `|θ| ≤ π` and `L·|θ| ≥ 2π`, `Σ_{n<L} (1 − cos nθ) ≥ L/2`
(`|Σ_{n<L} e^{inθ}| ≤ 2/|e^{iθ} − 1| ≤ π/|θ|`). -/
private theorem as_dirichlet {θ : ℝ} (hθ : |θ| ≤ Real.pi) {L : ℕ} (h : 2 * Real.pi ≤ L * |θ|) :
    (L : ℝ) / 2 ≤ ∑ n ∈ Finset.range L, (1 - Real.cos (n * θ)) := by
  have hpi := Real.pi_pos
  have hθ0 : θ ≠ 0 := by
    intro h0
    rw [h0, abs_zero, mul_zero] at h
    linarith
  have habs : 0 < |θ| := abs_pos.2 hθ0
  set w : ℂ := Complex.exp (θ * Complex.I) with hw
  have hsin : 2 * |θ| / Real.pi ≤ ‖w - 1‖ := by
    have hw' : w = Complex.exp (Complex.I * θ) := by rw [hw, mul_comm]
    rw [hw', Complex.norm_exp_I_mul_ofReal_sub_one, norm_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_two]
    have h1 : |Real.sin (θ / 2)| = |Real.sin (|θ| / 2)| := by
      rcases abs_cases θ with ⟨hh, _⟩ | ⟨hh, _⟩
      · rw [hh]
      · rw [hh, neg_div, Real.sin_neg, abs_neg]
    have h2 := Real.mul_le_sin (x := |θ| / 2) (by positivity) (by linarith)
    have key : |θ| / Real.pi ≤ |Real.sin (θ / 2)| := by
      rw [h1]
      calc |θ| / Real.pi = 2 / Real.pi * (|θ| / 2) := by ring
        _ ≤ Real.sin (|θ| / 2) := h2
        _ ≤ |Real.sin (|θ| / 2)| := le_abs_self _
    calc 2 * |θ| / Real.pi = 2 * (|θ| / Real.pi) := by ring
      _ ≤ 2 * |Real.sin (θ / 2)| := by linarith
  have hpos : 0 < 2 * |θ| / Real.pi := by positivity
  have hw1 : w ≠ 1 := by
    intro h1
    rw [h1, sub_self, norm_zero] at hsin
    linarith
  have hre : ∑ n ∈ Finset.range L, Real.cos (n * θ) = (∑ n ∈ Finset.range L, w ^ n).re := by
    rw [Complex.re_sum]
    refine Finset.sum_congr rfl fun n _ => ?_
    rw [hw, ← Complex.exp_nat_mul]
    have : (n : ℂ) * (θ * Complex.I) = ((n * θ : ℝ) : ℂ) * Complex.I := by push_cast; ring
    rw [this, Complex.exp_ofReal_mul_I_re]
  have hgeom : ‖∑ n ∈ Finset.range L, w ^ n‖ ≤ Real.pi / |θ| := by
    rw [geom_sum_eq hw1, norm_div]
    have hwn : ‖w‖ = 1 := by rw [hw]; exact Complex.norm_exp_ofReal_mul_I θ
    have hnum : ‖w ^ L - 1‖ ≤ 2 := by
      calc ‖w ^ L - 1‖ ≤ ‖w ^ L‖ + ‖(1 : ℂ)‖ := norm_sub_le _ _
        _ = 2 := by rw [norm_pow, hwn, one_pow, norm_one]; norm_num
    have hden : 0 < ‖w - 1‖ := lt_of_lt_of_le hpos hsin
    rw [div_le_iff₀ hden]
    calc ‖w ^ L - 1‖ ≤ 2 := hnum
      _ = Real.pi / |θ| * (2 * |θ| / Real.pi) := by field_simp
      _ ≤ Real.pi / |θ| * ‖w - 1‖ := mul_le_mul_of_nonneg_left hsin (by positivity)
  have hL : Real.pi / |θ| ≤ L / 2 := by
    rw [div_le_iff₀ habs]
    linarith
  have hcos : ∑ n ∈ Finset.range L, Real.cos (n * θ) ≤ L / 2 := by
    rw [hre]
    exact (Complex.re_le_norm _).trans (hgeom.trans hL)
  rw [Finset.sum_sub_distrib, Finset.sum_const, Finset.card_range, nsmul_eq_mul, mul_one]
  linarith

/-- Each evaluation is integrable for a finite measure. -/
private theorem as_integrable_eval (σ : Measure (Dual F)) [IsFiniteMeasure σ] (y : unitRing F) :
    Integrable (fun χ : Dual F => (χ y : ℂ)) σ :=
  Integrable.of_bound (measurable_evalChar y).aestronglyMeasurable 1
    (Eventually.of_forall fun χ => by rw [Circle.norm_coe])

/-- `Re χ(n•y) = cos(n · arg χ(y))`. -/
private theorem as_re_char_nsmul (χ : Dual F) (n : ℕ) (y : unitRing F) :
    (χ (n • y) : ℂ).re = Real.cos (n * Complex.arg (χ y : ℂ)) := by
  have e := Circle.exp_arg (χ y)
  rw [AddChar.map_nsmul_eq_pow]
  calc ((χ y ^ n : Circle) : ℂ).re = ((Circle.exp (Complex.arg (χ y : ℂ)) ^ n : Circle) : ℂ).re := by rw [e]
    _ = Real.cos (n * Complex.arg (χ y : ℂ)) := by
        rw [← Circle.exp_natCast_mul, Circle.coe_exp, Complex.exp_ofReal_mul_I_re]

/-- **The mass far out at one coordinate**: if `1 − Re φ(n•y₀) ≤ η` for every `n` below `3π·5^k/M`, the characters
whose argument at `y₀`, scaled by `5^k`, exceeds `M` have mass at most `2η` (`as_dirichlet`, averaged; Markov). -/
private theorem as_measure_far_le (ρ : Measure (Dual F)) [IsProbabilityMeasure ρ] (y₀ : unitRing F) (k : ℕ)
    {M η : ℝ} (hM : 0 < M)
    (hη : ∀ n : ℕ, (n : ℝ) < 3 * Real.pi * 5 ^ k / M → 1 - (∫ χ, (χ (n • y₀) : ℂ) ∂ρ).re ≤ η) :
    ρ.real {χ : Dual F | M < 5 ^ k * |Complex.arg (χ y₀ : ℂ)|} ≤ 2 * η := by
  have hpi := Real.pi_pos
  have h5 : (0 : ℝ) < 5 ^ k := by positivity
  have hη0 : 0 ≤ η := by
    have := hη 0 (by rw [Nat.cast_zero]; positivity)
    simpa [AddChar.map_zero_eq_one] using this
  by_cases hMk : Real.pi * 5 ^ k ≤ M
  · have hE : {χ : Dual F | M < 5 ^ k * |Complex.arg (χ y₀ : ℂ)|} = ∅ := by
      ext χ
      simp only [Set.mem_setOf_eq, Set.mem_empty_iff_false, iff_false, not_lt]
      have := abs_le.2 ⟨(Complex.neg_pi_lt_arg (χ y₀ : ℂ)).le, Complex.arg_le_pi (χ y₀ : ℂ)⟩
      nlinarith
    rw [hE, measureReal_empty]
    linarith
  push Not at hMk
  set L : ℕ := ⌈2 * Real.pi * 5 ^ k / M⌉₊ with hL
  have hLge : 2 * Real.pi * 5 ^ k / M ≤ L := Nat.le_ceil _
  have hLpos : (0 : ℝ) < L := lt_of_lt_of_le (by positivity) hLge
  have hLlt : (L : ℝ) < 3 * Real.pi * 5 ^ k / M := by
    have h1 := Nat.ceil_lt_add_one (by positivity : (0 : ℝ) ≤ 2 * Real.pi * 5 ^ k / M)
    have h2 : (1 : ℝ) < Real.pi * 5 ^ k / M := by rw [lt_div_iff₀ hM]; linarith
    calc (L : ℝ) < 2 * Real.pi * 5 ^ k / M + 1 := h1
      _ < 2 * Real.pi * 5 ^ k / M + Real.pi * 5 ^ k / M := by linarith
      _ = 3 * Real.pi * 5 ^ k / M := by ring
  set f : Dual F → ℝ := fun χ => (2 / L) * ∑ n ∈ Finset.range L, (1 - (χ (n • y₀) : ℂ).re) with hf
  have hterm : ∀ (χ : Dual F) (n : ℕ), 0 ≤ 1 - (χ (n • y₀) : ℂ).re := by
    intro χ n
    have := Complex.re_le_norm (χ (n • y₀) : ℂ)
    rw [Circle.norm_coe] at this
    linarith
  have hf0 : ∀ χ, 0 ≤ f χ := fun χ =>
    mul_nonneg (by positivity) (Finset.sum_nonneg fun n _ => hterm χ n)
  have hre : ∀ n : ℕ, Integrable (fun χ : Dual F => (χ (n • y₀) : ℂ).re) ρ := fun n =>
    (as_integrable_eval ρ (n • y₀)).re
  have hreint : ∀ n : ℕ, ∫ χ, (χ (n • y₀) : ℂ).re ∂ρ = (∫ χ, (χ (n • y₀) : ℂ) ∂ρ).re := fun n =>
    integral_re (as_integrable_eval ρ (n • y₀))
  have hint : ∀ n : ℕ, Integrable (fun χ : Dual F => 1 - (χ (n • y₀) : ℂ).re) ρ := fun n =>
    (integrable_const 1).sub (hre n)
  have hfint : Integrable f ρ := (integrable_finsetSum _ fun n _ => hint n).const_mul _
  have hsub : {χ : Dual F | M < 5 ^ k * |Complex.arg (χ y₀ : ℂ)|} ⊆ {χ | 1 ≤ f χ} := by
    intro χ hχ
    simp only [Set.mem_setOf_eq] at hχ ⊢
    set θ := Complex.arg (χ y₀ : ℂ) with hθ
    have hθπ : |θ| ≤ Real.pi := abs_le.2 ⟨(Complex.neg_pi_lt_arg _).le, Complex.arg_le_pi _⟩
    have hLθ : 2 * Real.pi ≤ L * |θ| := by
      have h1 : 2 * Real.pi * 5 ^ k / M * |θ| ≤ L * |θ| := mul_le_mul_of_nonneg_right hLge (abs_nonneg _)
      have h2 : 2 * Real.pi < 2 * Real.pi * 5 ^ k / M * |θ| := by
        rw [div_mul_eq_mul_div, lt_div_iff₀ hM]
        nlinarith
      linarith
    have hd := as_dirichlet hθπ hLθ
    have hsum : ∑ n ∈ Finset.range L, (1 - (χ (n • y₀) : ℂ).re) = ∑ n ∈ Finset.range L, (1 - Real.cos (n * θ)) :=
      Finset.sum_congr rfl fun n _ => by rw [as_re_char_nsmul]
    show 1 ≤ (2 / L) * ∑ n ∈ Finset.range L, (1 - (χ (n • y₀) : ℂ).re)
    rw [hsum]
    calc (1 : ℝ) = (2 / L) * (L / 2) := by field_simp
      _ ≤ (2 / L) * ∑ n ∈ Finset.range L, (1 - Real.cos (n * θ)) := mul_le_mul_of_nonneg_left hd (by positivity)
  have hmarkov := mul_meas_ge_le_integral_of_nonneg (Eventually.of_forall hf0) hfint 1
  rw [one_mul] at hmarkov
  have hintf : ∫ χ, f χ ∂ρ = (2 / L) * ∑ n ∈ Finset.range L, (1 - (∫ χ, (χ (n • y₀) : ℂ) ∂ρ).re) := by
    rw [hf, integral_const_mul, integral_finsetSum _ fun n _ => hint n]
    congr 1
    refine Finset.sum_congr rfl fun n _ => ?_
    rw [integral_sub (integrable_const _) (hre n), integral_const, probReal_univ, one_smul, hreint n]
  have hbound : (2 / L) * ∑ n ∈ Finset.range L, (1 - (∫ χ, (χ (n • y₀) : ℂ) ∂ρ).re) ≤ 2 * η := by
    have h1 : ∑ n ∈ Finset.range L, (1 - (∫ χ, (χ (n • y₀) : ℂ) ∂ρ).re) ≤ ∑ n ∈ Finset.range L, η :=
      Finset.sum_le_sum fun n hn => hη n (lt_trans (by exact_mod_cast Finset.mem_range.1 hn) hLlt)
    rw [Finset.sum_const, Finset.card_range, nsmul_eq_mul] at h1
    calc (2 / L) * ∑ n ∈ Finset.range L, (1 - (∫ χ, (χ (n • y₀) : ℂ) ∂ρ).re) ≤ (2 / L) * (L * η) :=
          mul_le_mul_of_nonneg_left h1 (by positivity)
      _ = 2 * η := by field_simp
  calc ρ.real {χ : Dual F | M < 5 ^ k * |Complex.arg (χ y₀ : ℂ)|} ≤ ρ.real {χ | 1 ≤ f χ} := measureReal_mono hsub
    _ ≤ ∫ χ, f χ ∂ρ := hmarkov
    _ ≤ 2 * η := by rw [hintf]; exact hbound


/-- The scaled arguments of `χ` at the points `b_j/5^k`: `t_k(χ)_j = 5^k · arg χ(b_j/5^k)`. -/
private def asT {ι : Type} (b : ι → unitRing F) (k : ℕ) (χ : Dual F) : ι → ℝ :=
  fun j => 5 ^ k * Complex.arg (χ (fivePow F k (b j)) : ℂ)

private theorem measurable_asT {ι : Type} (b : ι → unitRing F) (k : ℕ) : Measurable (asT b k) :=
  measurable_pi_lambda _ fun _ => measurable_const.mul (Complex.measurable_arg.comp (measurable_evalChar _))

/-- `s ↦ exp(i⟨s, v⟩)` on `ℝ^ι`. -/
private def asEv {ι : Type} [Fintype ι] (v s : ι → ℝ) : ℂ := (Circle.exp (∑ j, s j * v j) : ℂ)

private theorem continuous_asEv {ι : Type} [Fintype ι] (v : ι → ℝ) : Continuous (asEv v) :=
  continuous_subtype_val.comp (Circle.exp.continuous.comp
    (continuous_finsetSum _ fun j _ => (continuous_apply j).mul continuous_const))

private theorem continuous_asEv_left {ι : Type} [Fintype ι] (s : ι → ℝ) : Continuous fun v : ι → ℝ => asEv v s :=
  continuous_subtype_val.comp (Circle.exp.continuous.comp
    (continuous_finsetSum _ fun j _ => continuous_const.mul (continuous_apply j)))

private theorem norm_asEv {ι : Type} [Fintype ι] (v s : ι → ℝ) : ‖asEv v s‖ = 1 := Circle.norm_coe _

open scoped Classical in
/-- **The transform at a lattice point, read through `t_k`**: if `5^k·q(y)` is integral, `χ(y) = exp(i⟨t_k χ, q(y)⟩)`. -/
private theorem as_char_eq_asEv {ι : Type} [Fintype ι] {b : ι → unitRing F} {q : ι → unitRing F →+ ℚ}
    (hqb : ∀ i j, q j (b i) = if i = j then 1 else 0) (hinj : Function.Injective (fun y j => q j y)) (k : ℕ)
    (y : unitRing F) (z : ι → ℤ) (hz : ∀ j, (5 : ℚ) ^ k * q j y = z j) (χ : Dual F) :
    (χ y : ℂ) = asEv (fun j => (q j y : ℝ)) (asT b k χ) := by
  have hy := as_eq_lat hqb hinj k y z hz
  have e1 : (χ y : ℂ) = (Circle.exp (∑ i, (z i : ℝ) * Complex.arg (χ (fivePow F k (b i)) : ℂ)) : ℂ) := by
    conv_lhs => rw [hy]
    rw [as_char_lat]
  rw [e1]
  show (Circle.exp _ : ℂ) = (Circle.exp (∑ j, asT b k χ j * (q j y : ℝ)) : ℂ)
  congr 2
  refine Finset.sum_congr rfl fun j _ => ?_
  have hzj : (5 : ℝ) ^ k * (q j y : ℝ) = z j := by exact_mod_cast hz j
  show (z j : ℝ) * _ = 5 ^ k * _ * (q j y : ℝ)
  rw [← hzj]
  ring

/-- The bound of the tightness step: `n·(a/5^k) < δ` for `n < 3π·5^k/R`, `a ≤ B`, `R = 3π(B + 1)/δ + 1`. -/
private theorem as_aux_lt {n a B δ : ℝ} (k : ℕ) (hn0 : 0 ≤ n) (ha : a ≤ B) (hB : 0 ≤ B) (hδ : 0 < δ)
    (hn : n < 3 * Real.pi * 5 ^ k / (3 * Real.pi * (B + 1) / δ + 1)) : n * (a / 5 ^ k) < δ := by
  have hpi := Real.pi_pos
  have h5 : (0 : ℝ) < 5 ^ k := by positivity
  set R : ℝ := 3 * Real.pi * (B + 1) / δ + 1 with hR
  have hR0 : 0 < R := by positivity
  have h1 : n * (a / 5 ^ k) ≤ n * ((B + 1) / 5 ^ k) :=
    mul_le_mul_of_nonneg_left (div_le_div_of_nonneg_right (by linarith) h5.le) hn0
  have h2 : n * ((B + 1) / 5 ^ k) < (3 * Real.pi * 5 ^ k / R) * ((B + 1) / 5 ^ k) :=
    mul_lt_mul_of_pos_right hn (by positivity)
  have h3 : (3 * Real.pi * 5 ^ k / R) * ((B + 1) / 5 ^ k) = 3 * Real.pi * (B + 1) / R := by
    field_simp
  have h4 : 3 * Real.pi * (B + 1) / R < δ := by
    rw [div_lt_iff₀ hR0]
    have : δ * R = 3 * Real.pi * (B + 1) + δ := by
      rw [hR]
      field_simp
    linarith
  linarith

open scoped Classical in
/-- **Tightness, uniform in `k`**: the push-forwards of `ρ` by the `t_k` put mass at most `ε` outside one closed ball. -/
private theorem as_tight [NumberField F] {ι : Type} [Fintype ι] (b : ι → unitRing F) (ρ : Measure (Dual F))
    [IsProbabilityMeasure ρ] (h : @Continuous (unitRing F) ℂ (archTop F) _ fun y => ∫ χ, (χ y : ℂ) ∂ρ) :
    IsTightMeasureSet {x | ∃ k : ℕ, ρ.map (asT b k) = x} := by
  set φ : unitRing F → ℂ := fun y => ∫ χ, (χ y : ℂ) ∂ρ with hφ
  have hφ0 : φ 0 = 1 := by simp [hφ, AddChar.map_zero_eq_one]
  set Bs : ℝ := ∑ j, ‖archHom F (b j)‖ with hBs
  have hBs0 : 0 ≤ Bs := Finset.sum_nonneg fun j _ => norm_nonneg _
  have hBj : ∀ j, ‖archHom F (b j)‖ ≤ Bs := fun j =>
    Finset.single_le_sum (f := fun j => ‖archHom F (b j)‖) (fun j _ => norm_nonneg _) (Finset.mem_univ j)
  rw [isTightMeasureSet_iff_exists_isCompact_measure_compl_le]
  intro ε hε
  obtain ⟨r, hr0, hrε⟩ : ∃ r : ℝ, 0 < r ∧ ENNReal.ofReal r ≤ ε := by
    by_cases hεt : ε = ⊤
    · exact ⟨1, one_pos, by rw [hεt]; exact le_top⟩
    · exact ⟨ε.toReal, ENNReal.toReal_pos hε.ne' hεt, by rw [ENNReal.ofReal_toReal hεt]⟩
  set η : ℝ := r / (2 * (Fintype.card ι + 1)) with hηdef
  have hη0 : 0 < η := by positivity
  have hct := @Continuous.tendsto _ _ (archTop F) _ φ h 0
  have hev : ∀ᶠ y in @nhds _ (archTop F) 0, ‖φ y - φ 0‖ < η := by
    have := (Metric.tendsto_nhds.1 hct) η hη0
    simpa [dist_eq_norm] using this
  obtain ⟨δ, hδ0, hδ⟩ := (eventually_archTop F (p := fun y => ‖φ y - φ 0‖ < η)).1 hev
  have hsmall : ∀ y : unitRing F, ‖archHom F y‖ < δ → 1 - (φ y).re ≤ η := by
    intro y hy
    have h1 := hδ y hy
    rw [hφ0] at h1
    have h2 := Complex.abs_re_le_norm (φ y - 1)
    rw [Complex.sub_re, Complex.one_re] at h2
    linarith [neg_abs_le ((φ y).re - 1)]
  set R : ℝ := 3 * Real.pi * (Bs + 1) / δ + 1 with hR
  have hR0 : 0 < R := by positivity
  refine ⟨Metric.closedBall 0 R, isCompact_closedBall _ _, ?_⟩
  rintro _ ⟨k, rfl⟩
  rw [Measure.map_apply (measurable_asT b k) Metric.isClosed_closedBall.measurableSet.compl]
  have h5 : (0 : ℝ) < 5 ^ k := by positivity
  have hcover : asT b k ⁻¹' (Metric.closedBall 0 R)ᶜ ⊆
      ⋃ j, {χ : Dual F | R < 5 ^ k * |Complex.arg (χ (fivePow F k (b j)) : ℂ)|} := by
    intro χ hχ
    simp only [Set.mem_preimage, Set.mem_compl_iff, Metric.mem_closedBall, dist_zero_right, not_le] at hχ
    by_contra hno
    simp only [Set.mem_iUnion, Set.mem_setOf_eq, not_exists, not_lt] at hno
    have : ‖asT b k χ‖ ≤ R := (pi_norm_le_iff_of_nonneg hR0.le).2 fun j => by
      show ‖5 ^ k * Complex.arg (χ (fivePow F k (b j)) : ℂ)‖ ≤ R
      rw [Real.norm_eq_abs, abs_mul, abs_of_pos h5]
      exact hno j
    linarith
  have hfar : ∀ j, ρ {χ : Dual F | R < 5 ^ k * |Complex.arg (χ (fivePow F k (b j)) : ℂ)|} ≤
      ENNReal.ofReal (2 * η) := by
    intro j
    rw [← ofReal_measureReal]
    refine ENNReal.ofReal_le_ofReal (as_measure_far_le ρ (fivePow F k (b j)) k hR0 fun n hn => ?_)
    refine hsmall _ ?_
    have hsz : ‖archHom F (fivePow F k (b j))‖ = ‖archHom F (b j)‖ / 5 ^ k := by
      have := norm_archHom_nsmul F (5 ^ k) (fivePow F k (b j))
      rw [nsmul_fivePow] at this
      rw [this]
      push_cast
      field_simp
    rw [norm_archHom_nsmul, hsz]
    exact as_aux_lt k (Nat.cast_nonneg n) (hBj j) hBs0 hδ0 hn
  calc ρ (asT b k ⁻¹' (Metric.closedBall 0 R)ᶜ)
      ≤ ρ (⋃ j, {χ : Dual F | R < 5 ^ k * |Complex.arg (χ (fivePow F k (b j)) : ℂ)|}) := measure_mono hcover
    _ ≤ ∑ j, ρ {χ : Dual F | R < 5 ^ k * |Complex.arg (χ (fivePow F k (b j)) : ℂ)|} :=
        measure_iUnion_fintype_le _ _
    _ ≤ ∑ _j : ι, ENNReal.ofReal (2 * η) := Finset.sum_le_sum fun j _ => hfar j
    _ = ENNReal.ofReal (Fintype.card ι * (2 * η)) := by
        rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul, ENNReal.ofReal_mul (Nat.cast_nonneg _),
          ENNReal.ofReal_natCast]
    _ ≤ ENNReal.ofReal r := by
        refine ENNReal.ofReal_le_ofReal ?_
        have hc : (0 : ℝ) ≤ Fintype.card ι := Nat.cast_nonneg _
        have e : (Fintype.card ι : ℝ) * (2 * η) = r * (Fintype.card ι / (Fintype.card ι + 1)) := by
          rw [hηdef]
          field_simp
        have h1 : (Fintype.card ι : ℝ) / (Fintype.card ι + 1) ≤ 1 := by
          rw [div_le_one (by positivity)]
          linarith
        rw [e]
        calc r * (Fintype.card ι / (Fintype.card ι + 1)) ≤ r * 1 := mul_le_mul_of_nonneg_left h1 hr0.le
          _ = r := mul_one r
    _ ≤ ε := hrε

open scoped Classical in
/-- **A limit point of the push-forwards** (Prokhorov, along an ultrafilter): a probability on `ℝ^ι` whose transform at
`q(y)` is `φ(y)` at every lattice point `y`. -/
private theorem as_exists_limit [NumberField F] {ι : Type} [Fintype ι] {b : ι → unitRing F}
    {q : ι → unitRing F →+ ℚ} (hqb : ∀ i j, q j (b i) = if i = j then 1 else 0)
    (hinj : Function.Injective (fun y j => q j y)) (ρ : Measure (Dual F)) [IsProbabilityMeasure ρ]
    (h : @Continuous (unitRing F) ℂ (archTop F) _ fun y => ∫ χ, (χ y : ℂ) ∂ρ) :
    ∃ μ : ProbabilityMeasure (ι → ℝ), ∀ (K : ℕ) (y : unitRing F) (z : ι → ℤ),
      (∀ j, (5 : ℚ) ^ K * q j y = z j) →
        ∫ s, asEv (fun j => (q j y : ℝ)) s ∂(μ : Measure (ι → ℝ)) = ∫ χ, (χ y : ℂ) ∂ρ := by
  let P : ℕ → ProbabilityMeasure (ι → ℝ) := fun k =>
    ⟨ρ.map (asT b k), Measure.isProbabilityMeasure_map (measurable_asT b k).aemeasurable⟩
  have hset : {x | ∃ μ ∈ Set.range P, (μ : Measure (ι → ℝ)) = x} = {x | ∃ k : ℕ, ρ.map (asT b k) = x} := by
    ext x
    constructor
    · rintro ⟨_, ⟨k, rfl⟩, rfl⟩
      exact ⟨k, rfl⟩
    · rintro ⟨k, rfl⟩
      exact ⟨P k, ⟨k, rfl⟩, rfl⟩
  have hcomp := isCompact_closure_of_isTightMeasureSet (S := Set.range P) (by rw [hset]; exact as_tight b ρ h)
  have hU : ((Ultrafilter.of (atTop : Filter ℕ) : Ultrafilter ℕ) : Filter ℕ) ≤ atTop := Ultrafilter.of_le atTop
  obtain ⟨μ, -, hμ⟩ := hcomp.ultrafilter_le_nhds ((Ultrafilter.of (atTop : Filter ℕ)).map P) (by
    rw [Ultrafilter.coe_map, Filter.le_principal_iff, Filter.mem_map]
    exact Filter.univ_mem' fun k => subset_closure ⟨k, rfl⟩)
  have hlim : Tendsto P (Ultrafilter.of (atTop : Filter ℕ) : Filter ℕ) (𝓝 μ) := by
    rw [Filter.Tendsto, ← Ultrafilter.coe_map]
    exact hμ
  have hconv := (ProbabilityMeasure.tendsto_iff_forall_integral_rclike_tendsto ℂ).1 hlim
  refine ⟨μ, fun K y z hz => ?_⟩
  let g : BoundedContinuousFunction (ι → ℝ) ℂ :=
    BoundedContinuousFunction.ofNormedAddCommGroup (asEv fun j => (q j y : ℝ)) (continuous_asEv _) 1
      fun s => (norm_asEv _ _).le
  have h1 := hconv g
  have h2 : ∀ᶠ k in (Ultrafilter.of (atTop : Filter ℕ) : Filter ℕ),
      ∫ s, g s ∂(P k : Measure (ι → ℝ)) = ∫ χ, (χ y : ℂ) ∂ρ := by
    refine hU (eventually_atTop.2 ⟨K, fun k hk => ?_⟩)
    have hz' : ∀ j, (5 : ℚ) ^ k * q j y = ((5 : ℤ) ^ (k - K) * z j : ℤ) := by
      intro j
      push_cast
      rw [← hz j, ← mul_assoc, ← pow_add, Nat.sub_add_cancel hk]
    show ∫ s, asEv (fun j => (q j y : ℝ)) s ∂(ρ.map (asT b k)) = ∫ χ, (χ y : ℂ) ∂ρ
    rw [integral_map (measurable_asT b k).aemeasurable (continuous_asEv _).aestronglyMeasurable]
    exact integral_congr_ae (Eventually.of_forall fun χ => (as_char_eq_asEv hqb hinj k y _ hz' χ).symm)
  exact tendsto_nhds_unique h1 (tendsto_const_nhds.congr' (h2.mono fun k hk => hk.symm))

open scoped Classical in
/-- **The limit's transform on all of `R`**, from the lattice points by density: `q(d_m) → q(y)` and
`ι(d_m − y) → 0` for `d_m` the lattice point with coordinates `⌊5^m q(y)⌋/5^m`. -/
private theorem as_transform_eq [NumberField F] {ι : Type} [Fintype ι] {b : ι → unitRing F}
    {q : ι → unitRing F →+ ℚ} (hqb : ∀ i j, q j (b i) = if i = j then 1 else 0)
    (hinj : Function.Injective (fun y j => q j y)) (ρ : Measure (Dual F)) [IsProbabilityMeasure ρ]
    (h : @Continuous (unitRing F) ℂ (archTop F) _ fun y => ∫ χ, (χ y : ℂ) ∂ρ) (μ : Measure (ι → ℝ))
    [IsProbabilityMeasure μ]
    (hμ : ∀ (K : ℕ) (y : unitRing F) (z : ι → ℤ), (∀ j, (5 : ℚ) ^ K * q j y = z j) →
      ∫ s, asEv (fun j => (q j y : ℝ)) s ∂μ = ∫ χ, (χ y : ℂ) ∂ρ) (y : unitRing F) :
    ∫ s, asEv (fun j => (q j y : ℝ)) s ∂μ = ∫ χ, (χ y : ℂ) ∂ρ := by
  set φ : unitRing F → ℂ := fun y => ∫ χ, (χ y : ℂ) ∂ρ with hφ
  set Bs : ℝ := ∑ j, ‖archHom F (b j)‖ with hBs
  let z : ℕ → ι → ℤ := fun m j => ⌊(5 : ℚ) ^ m * q j y⌋
  let d : ℕ → unitRing F := fun m => ∑ j, z m j • fivePow F m (b j)
  have hqd : ∀ m j, (5 : ℚ) ^ m * q j (d m) = z m j := fun m j => as_q_lat hqb m (z m) j
  have hcoord : ∀ m j, |(q j (d m) : ℝ) - (q j y : ℝ)| ≤ (1 / 5 : ℝ) ^ m := by
    intro m j
    have h5 : (0 : ℝ) < 5 ^ m := by positivity
    have e1 : (5 : ℝ) ^ m * (q j (d m) : ℝ) = (z m j : ℝ) := by exact_mod_cast hqd m j
    have a1q : ((z m j : ℤ) : ℚ) ≤ (5 : ℚ) ^ m * q j y := Int.floor_le _
    have a2q : (5 : ℚ) ^ m * q j y < ((z m j : ℤ) : ℚ) + 1 := Int.lt_floor_add_one _
    have a1 : ((z m j : ℤ) : ℝ) ≤ (5 : ℝ) ^ m * (q j y : ℝ) := by exact_mod_cast a1q
    have a2 : (5 : ℝ) ^ m * (q j y : ℝ) < ((z m j : ℤ) : ℝ) + 1 := by exact_mod_cast a2q
    have e2 : (q j (d m) : ℝ) - (q j y : ℝ) = ((z m j : ℝ) - (5 : ℝ) ^ m * (q j y : ℝ)) / 5 ^ m := by
      rw [← e1]
      field_simp
    rw [e2, abs_div, abs_of_pos h5, div_le_iff₀ h5, one_div_pow, one_div_mul_cancel h5.ne', abs_le]
    constructor <;> linarith
  have hpow : Tendsto (fun m : ℕ => (1 / 5 : ℝ) ^ m) atTop (𝓝 0) :=
    tendsto_pow_atTop_nhds_zero_of_lt_one (by norm_num) (by norm_num)
  have hQ : Tendsto (fun m => fun j => (q j (d m) : ℝ)) atTop (𝓝 fun j => (q j y : ℝ)) := by
    refine tendsto_pi_nhds.2 fun j => ?_
    rw [tendsto_iff_norm_sub_tendsto_zero]
    refine squeeze_zero (fun m => norm_nonneg _) (fun m => ?_) hpow
    rw [Real.norm_eq_abs]
    exact hcoord m j
  have hd : Tendsto d atTop (@nhds _ (archTop F) y) := by
    rw [archTop_eq, nhds_induced, tendsto_comap_iff, tendsto_iff_norm_sub_tendsto_zero]
    have hpB : Tendsto (fun m : ℕ => (1 / 5 : ℝ) ^ m * Bs) atTop (𝓝 0) := by
      simpa using hpow.mul_const Bs
    refine squeeze_zero (fun m => norm_nonneg _) (fun m => ?_) hpB
    show ‖archHom F (d m) - archHom F y‖ ≤ (1 / 5 : ℝ) ^ m * Bs
    rw [← map_sub]
    refine (as_norm_archHom_le hqb hinj _).trans ?_
    rw [hBs, Finset.mul_sum]
    refine Finset.sum_le_sum fun j _ => mul_le_mul_of_nonneg_right ?_ (norm_nonneg _)
    rw [map_sub, Rat.cast_sub]
    exact hcoord m j
  have h1 : Tendsto (fun m => φ (d m)) atTop (𝓝 (φ y)) :=
    (@Continuous.tendsto _ _ (archTop F) _ φ h y).comp hd
  have h2 : Tendsto (fun m => ∫ s, asEv (fun j => (q j (d m) : ℝ)) s ∂μ) atTop
      (𝓝 (∫ s, asEv (fun j => (q j y : ℝ)) s ∂μ)) := by
    refine tendsto_integral_of_dominated_convergence (fun _ => (1 : ℝ))
      (fun m => (continuous_asEv _).aestronglyMeasurable) (integrable_const _)
      (fun m => Eventually.of_forall fun s => (norm_asEv _ _).le) (Eventually.of_forall fun s => ?_)
    exact ((continuous_asEv_left s).tendsto _).comp hQ
  have h3 : ∀ m, ∫ s, asEv (fun j => (q j (d m) : ℝ)) s ∂μ = φ (d m) := fun m => hμ m (d m) (z m) (hqd m)
  exact tendsto_nhds_unique (h2.congr h3) h1

open scoped Classical in
/-- **`archimedean_support` for a probability measure**: the limit `μ` pushed to `R̂` by `s ↦ exp(i⟨s, q(·)⟩)` has the
transform of `ρ`, so it is `ρ` (`measure_eq_of_fourier`), and it is carried by the range of that map, a measurable set
of archimedean characters. -/
private theorem as_support_prob [NumberField F] (ρ : Measure (Dual F)) [IsProbabilityMeasure ρ]
    (h : @Continuous (unitRing F) ℂ (archTop F) _ fun y => ∫ χ, (χ y : ℂ) ∂ρ) :
    ρ (archChars (unitRing F))ᶜ = 0 := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  obtain ⟨ι, _, b, q, hqb, hinj⟩ := as_exists_coords F
  obtain ⟨μ, hμ⟩ := as_exists_limit hqb hinj ρ h
  have hall := as_transform_eq hqb hinj ρ h (μ : Measure (ι → ℝ)) hμ
  let e : (ι → ℝ) → Dual F := fun s =>
    { toFun := fun r => Circle.exp (∑ j, s j * (q j r : ℝ))
      map_zero_eq_one' := by simp
      map_add_eq_mul' := fun r r' => by
        rw [← Circle.exp_add, ← Finset.sum_add_distrib]
        congr 1
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [map_add, Rat.cast_add, mul_add] }
  have he : Continuous e := by
    refine continuous_induced_rng.2 (continuous_pi fun r => ?_)
    exact continuous_subtype_val.comp (Circle.exp.continuous.comp
      (continuous_finsetSum _ fun j _ => (continuous_apply j).mul continuous_const))
  have hem : Measurable e := he.measurable
  have hfour : ∀ y : unitRing F, ∫ χ, (χ y : ℂ) ∂ρ = ∫ χ, (χ y : ℂ) ∂((μ : Measure (ι → ℝ)).map e) := by
    intro y
    rw [integral_map hem.aemeasurable (continuous_evalChar (unitRing F) y).aestronglyMeasurable]
    exact (hall y).symm
  have heq : ρ = (μ : Measure (ι → ℝ)).map e := measure_eq_of_fourier hfour
  have hrange : MeasurableSet (Set.range e) := by
    have : Set.range e = ⋃ n : ℕ, e '' Metric.closedBall 0 n := by
      ext χ
      simp only [Set.mem_range, Set.mem_iUnion, Set.mem_image]
      constructor
      · rintro ⟨s, rfl⟩
        obtain ⟨n, hn⟩ := exists_nat_ge ‖s‖
        exact ⟨n, s, mem_closedBall_zero_iff.2 hn, rfl⟩
      · rintro ⟨n, s, -, rfl⟩
        exact ⟨s, rfl⟩
    rw [this]
    exact MeasurableSet.iUnion fun n => ((isCompact_closedBall _ _).image he).isClosed.measurableSet
  have hsub : Set.range e ⊆ archChars (unitRing F) := by
    rintro _ ⟨s, rfl⟩
    refine ⟨AddMonoidHom.mk' (fun r => ∑ j, s j * (q j r : ℝ)) fun r r' => ?_, fun r => rfl⟩
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [map_add, Rat.cast_add, mul_add]
  refine nonpos_iff_eq_zero.1 ?_
  calc ρ (archChars (unitRing F))ᶜ ≤ ρ (Set.range e)ᶜ := measure_mono (Set.compl_subset_compl.2 hsub)
    _ = 0 := by
      rw [heq, Measure.map_apply hem hrange.compl]
      have : e ⁻¹' (Set.range e)ᶜ = ∅ := by
        ext s
        simp
      rw [this, measure_empty]

end ArchSupport

/-- **Bochner in support form for the archimedean topology**: a finite measure on `R̂` whose transform is continuous for
`archTop F` is carried by the archimedean characters. -/
theorem archimedean_support [NumberField F] (ρ : Measure (Dual F)) [IsFiniteMeasure ρ]
    (h : @Continuous (unitRing F) ℂ (archTop F) _ fun y => ∫ χ, (χ y : ℂ) ∂ρ) : ρ (archChars (unitRing F))ᶜ = 0 := by
  -- normalise to a probability measure (`as_support_prob`)
  by_cases h0 : ρ = 0
  · rw [h0, Measure.coe_zero, Pi.zero_apply]
  have hu : ρ Set.univ ≠ 0 := by rwa [Ne, Measure.measure_univ_eq_zero]
  have hut : ρ Set.univ ≠ ⊤ := measure_ne_top _ _
  set c : ENNReal := (ρ Set.univ)⁻¹ with hc
  haveI : IsProbabilityMeasure (c • ρ) :=
    ⟨by rw [Measure.smul_apply, smul_eq_mul, hc, ENNReal.inv_mul_cancel hu hut]⟩
  have h' : @Continuous (unitRing F) ℂ (archTop F) _ fun y => ∫ χ, (χ y : ℂ) ∂(c • ρ) := by
    simp only [integral_smul_measure]
    exact @Continuous.comp (unitRing F) ℂ ℂ (archTop F) _ _ _ _ (continuous_const_smul c.toReal) h
  have hc0 := as_support_prob (c • ρ) h'
  rw [Measure.smul_apply, smul_eq_mul, mul_eq_zero] at hc0
  rcases hc0 with h1 | h1
  · exact absurd h1 (ENNReal.inv_ne_zero.2 hut)
  · exact h1



section TwistedHelpers

/-! ### Private helpers: the subgroups `N·R`, small representatives of their cosets -/

/-- `N·R`. -/
private abbrev nR (N : ℕ) : AddSubgroup (unitRing F) := (nsmulAddMonoidHom (α := unitRing F) N).range

private theorem coe_fivePow (k : ℕ) (r : unitRing F) : ((fivePow F k r : unitRing F) : ℂ) = (5 : ℂ)⁻¹ ^ k * r :=
  rfl

/-- `1/5`, an element of `R`. -/
private def uFive : unitRing F := ⟨(5 : ℂ)⁻¹, inv_five_mem F⟩

private theorem five_mul_uFive : (5 : unitRing F) * uFive F = 1 := by
  apply Subtype.ext
  have h5 : ((5 : unitRing F) : ℂ) = 5 := map_ofNat (unitRing F).subtype 5
  rw [Subring.coe_mul, Subring.coe_one, h5]
  show (5 : ℂ) * (5 : ℂ)⁻¹ = 1
  norm_num

private theorem fivePow_eq (k : ℕ) (r : unitRing F) : fivePow F k r = uFive F ^ k * r := by
  apply Subtype.ext
  rw [coe_fivePow, Subring.coe_mul, Subring.coe_pow]
  rfl

private theorem fivePow_mem_nR {N : ℕ} (k : ℕ) {w : unitRing F} (h : w ∈ nR F N) : fivePow F k w ∈ nR F N := by
  obtain ⟨s, rfl⟩ := h
  refine ⟨fivePow F k s, ?_⟩
  simp only [nsmulAddMonoidHom_apply, fivePow_eq, nsmul_eq_mul]
  ring

private theorem fivePow_fivePow (a b : ℕ) (r : unitRing F) : fivePow F a (fivePow F b r) = fivePow F (a + b) r := by
  simp only [fivePow_eq, pow_add]
  ring

private theorem fivePow_sub (k : ℕ) (r s : unitRing F) : fivePow F k (r - s) = fivePow F k r - fivePow F k s := by
  simp only [fivePow_eq]
  ring

private theorem fivePow_zero (r : unitRing F) : fivePow F 0 r = r := by
  simp only [fivePow_eq, pow_zero, one_mul]

open scoped Classical in
private theorem norm_archHom_fivePow [NumberField F] (k : ℕ) (r : unitRing F) :
    ‖archHom F (fivePow F k r)‖ = ‖archHom F r‖ / 5 ^ k := by
  have h := norm_archHom_nsmul F (5 ^ k) (fivePow F k r)
  rw [nsmul_fivePow] at h
  rw [h]
  push_cast
  field_simp

open scoped Classical in
/-- Every coset of `N·R` has a member of archimedean size below any `δ > 0`: `r ↦ r/5` permutes the finite quotient,
so some power `r/5^{e}` lies in the coset of `r`, and so do all `r/5^{ek}`. -/
private theorem exists_small_rep [NumberField F] (N : ℕ) (hN : N ≠ 0) (r : unitRing F) {δ : ℝ} (hδ : 0 < δ) :
    ∃ x : unitRing F, x - r ∈ nR F N ∧ ‖archHom F x‖ < δ := by
  haveI := finite_quotient_nsmul F N hN
  obtain ⟨i, j, hij, hq⟩ := Finite.exists_ne_map_eq_of_infinite
    (fun k : ℕ => (QuotientAddGroup.mk (fivePow F k r) : unitRing F ⧸ nR F N))
  have key : ∀ i j : ℕ, i < j → (QuotientAddGroup.mk (fivePow F i r) : unitRing F ⧸ nR F N) =
      QuotientAddGroup.mk (fivePow F j r) → ∃ e, 0 < e ∧ fivePow F e r - r ∈ nR F N := by
    intro i j hij h
    refine ⟨j - i, by omega, ?_⟩
    rw [QuotientAddGroup.eq] at h
    have e : fivePow F (j - i) r - r = (5 ^ i) • (-fivePow F i r + fivePow F j r) := by
      have h5 : (5 : unitRing F) ^ i * uFive F ^ i = 1 := by rw [← mul_pow, five_mul_uFive, one_pow]
      have hj : uFive F ^ j = uFive F ^ (j - i) * uFive F ^ i := by rw [← pow_add, Nat.sub_add_cancel hij.le]
      rw [fivePow_eq, fivePow_eq, fivePow_eq, nsmul_eq_mul, hj]
      push_cast
      linear_combination (r - uFive F ^ (j - i) * r) * h5
    rw [e]
    exact (nR F N).nsmul_mem h _
  obtain ⟨e, he, hmem⟩ : ∃ e, 0 < e ∧ fivePow F e r - r ∈ nR F N := by
    rcases lt_or_gt_of_ne hij with h | h
    · exact key i j h hq
    · exact key j i h hq.symm
  have hiter : ∀ k, fivePow F (e * k) r - r ∈ nR F N := by
    intro k
    induction k with
    | zero => rw [Nat.mul_zero, fivePow_zero, sub_self]; exact (nR F N).zero_mem
    | succ k ih =>
      have h2 : fivePow F (e * (k + 1)) r - r = fivePow F e (fivePow F (e * k) r - r) + (fivePow F e r - r) := by
        rw [fivePow_sub, fivePow_fivePow, Nat.mul_succ, Nat.add_comm (e * k) e]
        abel
      rw [h2]
      exact add_mem (fivePow_mem_nR F e ih) hmem
  obtain ⟨k, hk⟩ : ∃ k : ℕ, ‖archHom F r‖ / δ < 5 ^ k := pow_unbounded_of_one_lt _ (by norm_num)
  refine ⟨fivePow F (e * k) r, hiter k, ?_⟩
  rw [norm_archHom_fivePow, div_lt_iff₀ (by positivity)]
  have h1 : ‖archHom F r‖ < δ * 5 ^ k := by
    rw [div_lt_iff₀ hδ] at hk
    linarith
  have h2 : (5 : ℝ) ^ k ≤ 5 ^ (e * k) := pow_le_pow_right₀ (by norm_num) (Nat.le_mul_of_pos_left k he)
  nlinarith

open scoped Classical in
/-- A section of the quotient by `N·R` by small representatives. -/
private theorem exists_reps [NumberField F] (N : ℕ) (hN : N ≠ 0) {δ : ℝ} (hδ : 0 < δ) :
    ∃ x : unitRing F ⧸ nR F N → unitRing F,
      (∀ c, (x c : unitRing F ⧸ nR F N) = c) ∧ ∀ c, ‖archHom F (x c)‖ < δ := by
  have h : ∀ c : unitRing F ⧸ nR F N, ∃ x : unitRing F, (x : unitRing F ⧸ nR F N) = c ∧ ‖archHom F x‖ < δ := by
    intro c
    obtain ⟨r, rfl⟩ := QuotientAddGroup.mk_surjective c
    obtain ⟨x, hx, hxs⟩ := exists_small_rep F N hN r hδ
    refine ⟨x, ?_, hxs⟩
    rw [QuotientAddGroup.eq]
    have : -x + r = -(x - r) := by abel
    rw [this]
    exact (nR F N).neg_mem hx
  choose x hx1 hx2 using h
  exact ⟨x, hx1, hx2⟩

/-! ### Private helpers: characters of the finite quotients -/

variable {F}

/-- A complex character of a finite quotient of `R`, read as a character of `R`. -/
private def liftChar {H : AddSubgroup (unitRing F)} [Finite (unitRing F ⧸ H)] (ψ : AddChar (unitRing F ⧸ H) ℂ) :
    Dual F where
  toFun r := ⟨ψ (r : unitRing F ⧸ H), mem_sphere_zero_iff_norm.2 (AddChar.norm_apply ψ _)⟩
  map_zero_eq_one' := Circle.ext (by simp)
  map_add_eq_mul' a b := Circle.ext (by simp [AddChar.map_add_eq_mul])

private theorem coe_liftChar {H : AddSubgroup (unitRing F)} [Finite (unitRing F ⧸ H)]
    (ψ : AddChar (unitRing F ⧸ H) ℂ) (r : unitRing F) : ((liftChar ψ r : Circle) : ℂ) = ψ (r : unitRing F ⧸ H) :=
  rfl

private theorem liftChar_injective {H : AddSubgroup (unitRing F)} [Finite (unitRing F ⧸ H)] :
    Function.Injective (liftChar (H := H)) := by
  intro ψ ψ' h
  refine AddChar.ext _ _ fun g => ?_
  obtain ⟨r, rfl⟩ := QuotientAddGroup.mk_surjective g
  have := congrArg (fun χ : Dual F => ((χ r : Circle) : ℂ)) h
  simpa only [coe_liftChar] using this

/-- A character of `R` trivial on `H`, as a complex character of `R ⧸ H`. -/
private def descChar {H : AddSubgroup (unitRing F)} (t : Dual F) (ht : ∀ w ∈ H, t w = 1) :
    AddChar (unitRing F ⧸ H) ℂ where
  toFun g := Quotient.liftOn' g (fun r => ((t r : Circle) : ℂ)) fun a b hab => by
    have h1 : t (-a + b) = 1 := ht _ (QuotientAddGroup.leftRel_apply.1 hab)
    have h2 : t b = t a * t (-a + b) := by rw [← AddChar.map_add_eq_mul, add_neg_cancel_left]
    rw [h2, h1, mul_one]
  map_zero_eq_one' := by
    show ((t 0 : Circle) : ℂ) = 1
    rw [AddChar.map_zero_eq_one, Circle.coe_one]
  map_add_eq_mul' g g' := by
    induction g using QuotientAddGroup.induction_on with
    | H a =>
    induction g' using QuotientAddGroup.induction_on with
    | H b =>
    show ((t (a + b) : Circle) : ℂ) = (t a : ℂ) * (t b : ℂ)
    rw [AddChar.map_add_eq_mul, Circle.coe_mul]

private theorem liftChar_descChar {H : AddSubgroup (unitRing F)} [Finite (unitRing F ⧸ H)] (t : Dual F)
    (ht : ∀ w ∈ H, t w = 1) : liftChar (descChar t ht) = t :=
  AddChar.ext _ _ fun _ => Circle.ext rfl

/-- `conj (ψ g) = ψ (−g)` for a complex character of a finite group. -/
private theorem conj_addChar {G : Type*} [AddCommGroup G] [Finite G] (ψ : AddChar G ℂ) (g : G) :
    (starRingEnd ℂ) (ψ g) = ψ (-g) := by
  have h1 := AddChar.norm_apply ψ g
  have h2 : ψ (-g) * ψ g = 1 := by rw [← AddChar.map_add_eq_mul, neg_add_cancel, AddChar.map_zero_eq_one]
  have h3 : (starRingEnd ℂ) (ψ g) * ψ g = 1 := by
    rw [mul_comm, Complex.mul_conj, Complex.normSq_eq_norm_sq, h1]
    norm_num
  have h0 : ψ g ≠ 0 := fun h => by simp [h] at h1
  exact mul_right_cancel₀ h0 (h3.trans h2.symm)

/-- **Orthogonality**: `Σ_ψ conj ψ(g) = |G|·[g = 0]`. -/
private theorem sum_conj_addChar {G : Type*} [AddCommGroup G] [Fintype G] [DecidableEq G] (g : G) :
    ∑ ψ : AddChar G ℂ, (starRingEnd ℂ) (ψ g) = if g = 0 then (Fintype.card G : ℂ) else 0 := by
  simp only [conj_addChar]
  rw [AddChar.sum_apply_eq_ite]
  simp only [neg_eq_zero]

/-- `t (a − b) = t a · conj (t b)`. -/
private theorem coe_char_sub (t : Dual F) (a b : unitRing F) :
    ((t (a - b) : Circle) : ℂ) = (t a : ℂ) * (starRingEnd ℂ) (t b : ℂ) := by
  have h : t (a - b) = t a * (t b)⁻¹ := by
    rw [sub_eq_add_neg, AddChar.map_add_eq_mul, AddChar.map_neg_eq_inv]
  rw [h, Circle.coe_mul, Circle.coe_inv_eq_conj]

/-! ### Private helpers: the twisted weights at one level -/

section Level

variable {G : Type*} [Fintype G]

/-- The twisted sum `Σ_c t̄(x_c) χ(x_c)`. -/
private def twSum (x : G → unitRing F) (t χ : Dual F) : ℂ :=
  ∑ c, (starRingEnd ℂ) (t (x c) : ℂ) * (χ (x c) : ℂ)

/-- The weight `|Σ_c t̄(x_c) χ(x_c)|² / |G|²`, in `[0, 1]`. -/
private def twW (x : G → unitRing F) (t χ : Dual F) : ℝ := ‖twSum x t χ‖ ^ 2 / (Fintype.card G : ℝ) ^ 2

private theorem norm_twSum_le (x : G → unitRing F) (t χ : Dual F) : ‖twSum x t χ‖ ≤ Fintype.card G := by
  refine (norm_sum_le _ _).trans ?_
  simp only [norm_mul, RCLike.norm_conj, Circle.norm_coe, mul_one, Finset.sum_const, Finset.card_univ,
    nsmul_eq_mul]
  rfl

private theorem twW_nonneg (x : G → unitRing F) (t χ : Dual F) : 0 ≤ twW x t χ := by
  unfold twW
  positivity

private theorem twW_le_one [Nonempty G] (x : G → unitRing F) (t χ : Dual F) : twW x t χ ≤ 1 := by
  unfold twW
  have hG : (0 : ℝ) < Fintype.card G := by exact_mod_cast Fintype.card_pos
  rw [div_le_one (by positivity)]
  exact pow_le_pow_left₀ (norm_nonneg _) (norm_twSum_le x t χ) 2

private theorem measurable_twW (x : G → unitRing F) (t : Dual F) : Measurable (twW x t) := by
  unfold twW twSum
  refine Measurable.div_const (Measurable.pow_const ?_ 2) _
  exact (Finset.measurable_sum _ fun c _ => (measurable_evalChar (x c)).const_mul _).norm

/-- The weight as a double sum: `|G|² · twW = Σ_{c,c'} conj t(x_c − x_c') · χ(x_c − x_c')`. -/
private theorem twW_eq (x : G → unitRing F) (t χ : Dual F) :
    ((twW x t χ : ℝ) : ℂ) = ((Fintype.card G : ℂ) ^ 2)⁻¹ *
      ∑ c, ∑ c', (starRingEnd ℂ) (t (x c - x c') : ℂ) * (χ (x c - x c') : ℂ) := by
  unfold twW
  push_cast
  rw [div_eq_inv_mul]
  congr 1
  rw [← Complex.ofReal_pow, ← Complex.normSq_eq_norm_sq, ← Complex.mul_conj, twSum, map_sum, Finset.sum_mul_sum]
  refine Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun c' _ => ?_
  rw [coe_char_sub, coe_char_sub]
  simp only [map_mul, Complex.conj_conj]
  ring

end Level


/-- `t (a + b) = t a · t b`, in `ℂ`. -/
private theorem coe_char_add (t : Dual F) (a b : unitRing F) :
    ((t (a + b) : Circle) : ℂ) = (t a : ℂ) * (t b : ℂ) := by
  rw [AddChar.map_add_eq_mul, Circle.coe_mul]

/-! ### Private helpers: the measure side -/

section MeasureSide

variable (σ : Measure (Dual F)) [IsFiniteMeasure σ]

private theorem integrable_eval (y : unitRing F) : Integrable (fun χ : Dual F => (χ y : ℂ)) σ :=
  Integrable.of_bound (measurable_evalChar y).aestronglyMeasurable 1
    (Eventually.of_forall fun χ => by rw [Circle.norm_coe])

private theorem integrable_eval_mul (y : unitRing F) {V : Dual F → ℝ} (hV : Measurable V) (hV0 : ∀ χ, 0 ≤ V χ)
    (hV1 : ∀ χ, V χ ≤ 1) : Integrable (fun χ : Dual F => (χ y : ℂ) * (V χ : ℂ)) σ :=
  Integrable.of_bound ((measurable_evalChar y).mul (Complex.measurable_ofReal.comp hV)).aestronglyMeasurable 1
    (Eventually.of_forall fun χ => by
      rw [norm_mul, Circle.norm_coe, one_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (hV0 χ)]
      exact hV1 χ)

private theorem integrable_real {V : Dual F → ℝ} (hV : Measurable V) (hV0 : ∀ χ, 0 ≤ V χ) (hV1 : ∀ χ, V χ ≤ 1) :
    Integrable V σ :=
  Integrable.of_bound hV.aestronglyMeasurable 1
    (Eventually.of_forall fun χ => by rw [Real.norm_eq_abs, abs_of_nonneg (hV0 χ)]; exact hV1 χ)

/-- **A bounded non-negative weight on a finite measure, twisted by a character, has a positive-definite
transform.** -/
private theorem posDef_twisted (V : Dual F → ℝ) (hV : Measurable V) (hV0 : ∀ χ, 0 ≤ V χ) (hV1 : ∀ χ, V χ ≤ 1)
    (t : Dual F) :
    PosDef fun y => (starRingEnd ℂ) (t y : ℂ) * ∫ χ, (χ y : ℂ) * (V χ : ℂ) ∂σ := by
  intro s z
  set S : Dual F → ℂ := fun χ => ∑ a ∈ s, z a * (starRingEnd ℂ) (t a : ℂ) * (χ a : ℂ) with hS
  have hpt : ∀ χ : Dual F, (∑ a ∈ s, ∑ b ∈ s, z a * star (z b) *
      ((starRingEnd ℂ) (t (a - b) : ℂ) * ((χ (a - b) : ℂ) * (V χ : ℂ)))) =
      (((Complex.normSq (S χ) * V χ : ℝ)) : ℂ) := by
    intro χ
    rw [Complex.ofReal_mul, ← Complex.mul_conj, hS, map_sum, Finset.sum_mul_sum, Finset.sum_mul]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.sum_mul]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [coe_char_sub, coe_char_sub]
    simp only [map_mul, Complex.conj_conj, Complex.star_def]
    ring
  have hint : ∀ a b : unitRing F, Integrable (fun χ : Dual F => (χ (a - b) : ℂ) * (V χ : ℂ)) σ :=
    fun a b => integrable_eval_mul σ (a - b) hV hV0 hV1
  have hsum : (∑ a ∈ s, ∑ b ∈ s, z a * star (z b) *
      ((starRingEnd ℂ) (t (a - b) : ℂ) * ∫ χ, (χ (a - b) : ℂ) * (V χ : ℂ) ∂σ)) =
      ∫ χ, (((Complex.normSq (S χ) * V χ : ℝ)) : ℂ) ∂σ := by
    rw [← integral_congr_ae (Eventually.of_forall hpt),
      integral_finsetSum _ fun a _ => integrable_finsetSum _ fun b _ => ((hint a b).const_mul _).const_mul _]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [integral_finsetSum _ fun b _ => ((hint a b).const_mul _).const_mul _]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [integral_const_mul, integral_const_mul]
  dsimp only
  rw [hsum, integral_complex_ofReal]
  exact ⟨Complex.ofReal_im _, by
    rw [Complex.ofReal_re]
    exact integral_nonneg fun χ => mul_nonneg (Complex.normSq_nonneg _) (hV0 χ)⟩

/-- `Re u ≥ 1 − ‖u − 1‖`. -/
private theorem one_sub_norm_le_re (u : ℂ) : 1 - ‖u - 1‖ ≤ u.re := by
  have h := Complex.abs_re_le_norm (u - 1)
  rw [Complex.sub_re, Complex.one_re] at h
  linarith [neg_abs_le (u.re - 1)]

/-- `∫ Re χ(w) ≥ σ(univ) − ∫ ‖χ(w) − 1‖`. -/
private theorem re_integral_ge (w : unitRing F) :
    σ.real Set.univ - ∫ χ, ‖(χ w : ℂ) - 1‖ ∂σ ≤ (∫ χ, (χ w : ℂ) ∂σ).re := by
  have hre : ∫ χ, (χ w : ℂ).re ∂σ = (∫ χ, (χ w : ℂ) ∂σ).re := integral_re (integrable_eval σ w)
  rw [← hre]
  have h1 : Integrable (fun χ : Dual F => ‖(χ w : ℂ) - 1‖) σ := ((integrable_eval σ w).sub (integrable_const 1)).norm
  have h2 : ∫ χ, (1 - ‖(χ w : ℂ) - 1‖) ∂σ ≤ ∫ χ, (χ w : ℂ).re ∂σ :=
    integral_mono ((integrable_const (1 : ℝ)).sub h1) (integrable_eval σ w).re fun χ => one_sub_norm_le_re (χ w : ℂ)
  rw [integral_sub (integrable_const _) h1, integral_const, smul_eq_mul, mul_one] at h2
  exact h2

open scoped Classical in
/-- **The modulus of the transform at `M·R ∩ B_δ`**: from `τ′_∅`-continuity, `∫ ‖χ(w) − 1‖ dσ` is small on
`M·R ∩ B_δ` for some `M ≠ 0` and `δ > 0` (`‖u − 1‖ ≤ η + (2 − 2 Re u)/η` on the circle). -/
private theorem exists_E_small [NumberField F]
    (h : @Continuous (unitRing F) ℂ (tauPrime F) _ fun y => ∫ χ, (χ y : ℂ) ∂σ) {ε : ℝ} (hε : 0 < ε) :
    ∃ M : ℕ, M ≠ 0 ∧ ∃ δ > 0, ∀ s : unitRing F, ‖archHom F (M • s)‖ < δ →
      ∫ χ, ‖(χ (M • s) : ℂ) - 1‖ ∂σ < ε := by
  set m := σ.real Set.univ with hm
  set φ : unitRing F → ℂ := fun y => ∫ χ, (χ y : ℂ) ∂σ with hφ
  have hm0 : 0 ≤ m := measureReal_nonneg
  set η : ℝ := ε / (2 * (m + 1)) with hη
  have hη0 : 0 < η := by positivity
  have hct := @Continuous.tendsto _ _ (tauPrime F) _ φ h 0
  have hev : ∀ᶠ w in @nhds _ (tauPrime F) 0, ‖φ w - φ 0‖ < η * ε / 4 := by
    have := (Metric.tendsto_nhds.1 hct) (η * ε / 4) (by positivity)
    simpa [dist_eq_norm] using this
  rw [nhds_inf (t₁ := profTop F) (t₂ := archTop F)] at hev
  obtain ⟨t₁, ht₁, t₂, ht₂, hsub⟩ := Filter.mem_inf_iff_superset.1 hev
  obtain ⟨M, hM, hMt⟩ := exists_nsmul_mem_of_mem_nhds_profTop F ht₁
  obtain ⟨δ, hδ, hδt⟩ := (eventually_archTop F (p := fun r => r ∈ t₂)).1 ht₂
  refine ⟨M, hM, δ, hδ, fun s hs => ?_⟩
  have hw : ‖φ (M • s) - φ 0‖ < η * ε / 4 := hsub ⟨hMt s, hδt _ hs⟩
  have hφ0 : φ 0 = (m : ℂ) := by
    simp only [hφ, AddChar.map_zero_eq_one, Circle.coe_one, integral_const, Complex.real_smul, mul_one, hm]
  have hpt : ∀ χ : Dual F, ‖(χ (M • s) : ℂ) - 1‖ ≤ (η + 2 / η) - (2 / η) * (χ (M • s) : ℂ).re := by
    intro χ
    set u : ℂ := (χ (M • s) : ℂ)
    have hu : ‖u‖ = 1 := Circle.norm_coe _
    have hsq : ‖u - 1‖ ^ 2 = 2 - 2 * u.re := by
      have h1 := Complex.normSq_eq_norm_sq (u - 1)
      have h2 := Complex.normSq_eq_norm_sq u
      rw [hu, Complex.normSq_apply] at h2
      rw [← h1, Complex.normSq_apply]
      simp only [Complex.sub_re, Complex.one_re, Complex.sub_im, Complex.one_im, sub_zero]
      nlinarith
    have hfin : (η + 2 / η) - (2 / η) * u.re = η + (2 - 2 * u.re) / η := by ring
    rw [hfin, ← hsq]
    by_cases hle : ‖u - 1‖ ≤ η
    · have : 0 ≤ ‖u - 1‖ ^ 2 / η := by positivity
      linarith
    · push Not at hle
      have : ‖u - 1‖ ≤ ‖u - 1‖ ^ 2 / η := by
        rw [le_div_iff₀ hη0, sq]
        exact mul_le_mul_of_nonneg_left hle.le (norm_nonneg _)
      linarith
  have hint1 : Integrable (fun χ : Dual F => ‖(χ (M • s) : ℂ) - 1‖) σ :=
    ((integrable_eval σ (M • s)).sub (integrable_const 1)).norm
  have hintre : Integrable (fun χ : Dual F => (χ (M • s) : ℂ).re) σ := (integrable_eval σ (M • s)).re
  have hint2 : Integrable (fun χ : Dual F => (η + 2 / η) - (2 / η) * (χ (M • s) : ℂ).re) σ :=
    (integrable_const _).sub (hintre.const_mul _)
  have hre : ∫ χ, (χ (M • s) : ℂ).re ∂σ = (φ (M • s)).re := integral_re (integrable_eval σ (M • s))
  have hgap : m - (φ (M • s)).re < η * ε / 4 := by
    have := Complex.abs_re_le_norm (φ (M • s) - φ 0)
    rw [Complex.sub_re, hφ0, Complex.ofReal_re] at this
    rw [hφ0] at hw
    linarith [neg_abs_le ((φ (M • s)).re - m)]
  calc ∫ χ, ‖(χ (M • s) : ℂ) - 1‖ ∂σ ≤ ∫ χ, ((η + 2 / η) - (2 / η) * (χ (M • s) : ℂ).re) ∂σ :=
        integral_mono hint1 hint2 hpt
    _ = η * m + (2 / η) * (m - (φ (M • s)).re) := by
        rw [integral_sub (integrable_const _) (hintre.const_mul _), integral_const, integral_const_mul, hre,
          smul_eq_mul, ← hm]
        ring
    _ < ε / 2 + (2 / η) * (η * ε / 4) := by
        have h1 : η * m < ε / 2 := by
          rw [hη, div_mul_eq_mul_div, div_lt_div_iff₀ (by positivity) (by norm_num)]
          nlinarith
        have h2 : (2 / η) * (m - (φ (M • s)).re) < (2 / η) * (η * ε / 4) :=
          mul_lt_mul_of_pos_left hgap (by positivity)
        linarith
    _ = ε := by field_simp; ring

/-- The level-`n` twisted part `∫ χ(y) · twW(t, χ) dσ`. -/
private def twK {G : Type*} [Fintype G] (x : G → unitRing F) (t : Dual F) (y : unitRing F) : ℂ :=
  ∫ χ, (χ y : ℂ) * (twW x t χ : ℂ) ∂σ

section Level2

variable {G : Type*} [Fintype G] [Nonempty G]

omit [IsFiniteMeasure σ] [Nonempty G] in
private theorem twK_zero (x : G → unitRing F) (t : Dual F) :
    twK σ x t 0 = ((∫ χ, twW x t χ ∂σ : ℝ) : ℂ) := by
  simp only [twK, AddChar.map_zero_eq_one, Circle.coe_one, one_mul, integral_complex_ofReal]

private theorem norm_twK_le (x : G → unitRing F) (t : Dual F) (y : unitRing F) :
    ‖twK σ x t y‖ ≤ σ.real Set.univ := by
  have h := norm_integral_le_of_norm_le_const (μ := σ) (f := fun χ : Dual F => (χ y : ℂ) * (twW x t χ : ℂ))
    (C := 1) (Eventually.of_forall fun χ => by
      rw [norm_mul, Circle.norm_coe, one_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (twW_nonneg _ _ _)]
      exact twW_le_one _ _ _)
  rw [one_mul] at h
  exact h

private theorem posDef_twK (x : G → unitRing F) (t : Dual F) :
    PosDef fun y => (starRingEnd ℂ) (t y : ℂ) * twK σ x t y :=
  posDef_twisted σ (twW x t) (measurable_twW x t) (twW_nonneg x t) (twW_le_one x t) t

end Level2

section Level3

variable {N : ℕ} [Fintype (unitRing F ⧸ nR F N)]

/-- **Parseval at one level**: the weights of the characters of `R ⧸ N·R` sum to `1`. -/
private theorem sum_twW_liftChar (x : unitRing F ⧸ nR F N → unitRing F)
    (hx : ∀ c, (x c : unitRing F ⧸ nR F N) = c) (χ : Dual F) :
    ∑ ψ : AddChar (unitRing F ⧸ nR F N) ℂ, twW x (liftChar ψ) χ = 1 := by
  classical
  apply Complex.ofReal_injective
  rw [Complex.ofReal_sum]
  simp only [twW_eq, coe_liftChar]
  rw [← Finset.mul_sum, Finset.sum_comm]
  have hin : ∀ c : unitRing F ⧸ nR F N, ∑ c', ∑ ψ : AddChar (unitRing F ⧸ nR F N) ℂ,
      (starRingEnd ℂ) (ψ ((x c - x c' : unitRing F) : unitRing F ⧸ nR F N)) * (χ (x c - x c') : ℂ) =
      Fintype.card (unitRing F ⧸ nR F N) := by
    intro c
    simp only [← Finset.sum_mul, sum_conj_addChar, QuotientAddGroup.mk_sub, hx, sub_eq_zero, ite_mul, zero_mul]
    rw [Finset.sum_ite_eq]
    simp
  rw [Finset.sum_congr rfl fun c _ => (Finset.sum_comm.trans (hin c)), Finset.sum_const, Finset.card_univ,
    nsmul_eq_mul, Complex.ofReal_one]
  have hG : (Fintype.card (unitRing F ⧸ nR F N) : ℂ) ≠ 0 := Nat.cast_ne_zero.2 Fintype.card_ne_zero
  field_simp

/-- A character of `R` trivial on `N·R`, unless `false`, read back from the quotient (the descent, or `1`). -/
private def descOr (t : Dual F) : AddChar (unitRing F ⧸ nR F N) ℂ :=
  open Classical in if h : ∀ w ∈ nR F N, t w = 1 then descChar t h else 1

/-- **Bessel at one level**: distinct characters trivial on `N·R` carry total weight at most `1`. -/
private theorem sum_twW_le (x : unitRing F ⧸ nR F N → unitRing F) (hx : ∀ c, (x c : unitRing F ⧸ nR F N) = c)
    (S : Finset (Dual F)) (hS : ∀ t ∈ S, ∀ w ∈ nR F N, t w = 1) (χ : Dual F) :
    ∑ t ∈ S, twW x t χ ≤ 1 := by
  classical
  have hld : ∀ t ∈ S, liftChar (descOr (N := N) t) = t := fun t ht => by
    rw [descOr, dif_pos (hS t ht), liftChar_descChar]
  have hinj : Set.InjOn (descOr (N := N)) (S : Set (Dual F)) := by
    intro a ha b hb hab
    rw [← hld a (Finset.mem_coe.1 ha), ← hld b (Finset.mem_coe.1 hb), hab]
  calc ∑ t ∈ S, twW x t χ = ∑ t ∈ S, twW x (liftChar (descOr (N := N) t)) χ :=
        Finset.sum_congr rfl fun t ht => by rw [hld t ht]
    _ = ∑ ψ ∈ S.image (descOr (N := N)), twW x (liftChar ψ) χ :=
        (Finset.sum_image (f := fun ψ => twW x (liftChar ψ) χ) hinj).symm
    _ ≤ ∑ ψ : AddChar (unitRing F ⧸ nR F N) ℂ, twW x (liftChar ψ) χ :=
        Finset.sum_le_univ_sum_of_nonneg fun ψ => twW_nonneg x _ χ
    _ = 1 := sum_twW_liftChar x hx χ

/-- **The remainder at one level**: `‖φ(y) − Σ_{t ∈ S} K_t(y)‖ ≤ σ(univ) − Σ_{t ∈ S} K_t(0)`. -/
private theorem norm_sub_sum_twK_le (x : unitRing F ⧸ nR F N → unitRing F)
    (hx : ∀ c, (x c : unitRing F ⧸ nR F N) = c) (S : Finset (Dual F)) (hS : ∀ t ∈ S, ∀ w ∈ nR F N, t w = 1)
    (y : unitRing F) :
    ‖(∫ χ, (χ y : ℂ) ∂σ) - ∑ t ∈ S, twK σ x t y‖ ≤ σ.real Set.univ - ∑ t ∈ S, ∫ χ, twW x t χ ∂σ := by
  set V : Dual F → ℝ := fun χ => 1 - ∑ t ∈ S, twW x t χ with hV
  have hV0 : ∀ χ, 0 ≤ V χ := fun χ => sub_nonneg.2 (sum_twW_le x hx S hS χ)
  have hVm : Measurable V := measurable_const.sub (Finset.measurable_sum _ fun t _ => measurable_twW x t)
  have hint : ∀ t ∈ S, Integrable (fun χ : Dual F => (χ y : ℂ) * (twW x t χ : ℂ)) σ := fun t _ =>
    integrable_eval_mul σ y (measurable_twW x t) (twW_nonneg x t) (twW_le_one x t)
  have hintW : ∀ t ∈ S, Integrable (twW x t) σ := fun t _ =>
    integrable_real σ (measurable_twW x t) (twW_nonneg x t) (twW_le_one x t)
  have h1 : (∫ χ, (χ y : ℂ) ∂σ) - ∑ t ∈ S, twK σ x t y = ∫ χ, (χ y : ℂ) * (V χ : ℂ) ∂σ := by
    have : (fun χ : Dual F => (χ y : ℂ) * (V χ : ℂ)) =
        fun χ => (χ y : ℂ) - ∑ t ∈ S, (χ y : ℂ) * (twW x t χ : ℂ) := by
      funext χ
      simp only [hV]
      push_cast
      rw [mul_sub, mul_one, Finset.mul_sum]
    rw [this, integral_sub (integrable_eval σ y) (integrable_finsetSum _ hint), integral_finsetSum _ hint]
    rfl
  rw [h1]
  refine (norm_integral_le_integral_norm _).trans (le_of_eq ?_)
  have h2 : (fun χ : Dual F => ‖(χ y : ℂ) * (V χ : ℂ)‖) = V := by
    funext χ
    rw [norm_mul, Circle.norm_coe, one_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (hV0 χ)]
  rw [h2, hV, integral_sub (integrable_const _) (integrable_finsetSum _ hintW), integral_finsetSum _ hintW,
    integral_const, smul_eq_mul, mul_one]

end Level3

end MeasureSide

/-! ### Private helpers: concentration on a fixed finite level, and continuity -/

section MeasureSide3

variable (σ : Measure (Dual F)) [IsFiniteMeasure σ]

/-- `|G|² ≤ |G₀| · #{(c, c') : π c = π c'}` (Cauchy–Schwarz on the fibre sizes). -/
private theorem card_sq_le_pairs {G G₀ : Type*} [Fintype G] [Fintype G₀] [DecidableEq G₀] (π : G → G₀) :
    ((Fintype.card G : ℝ)) ^ 2 ≤ Fintype.card G₀ * ∑ c : G, ∑ c' : G, if π c = π c' then (1 : ℝ) else 0 := by
  set f : G₀ → ℝ := fun g => ((Finset.univ.filter fun c => π c = g).card : ℝ) with hf
  have h1 : ∑ g, f g = Fintype.card G := by
    have := Finset.card_eq_sum_card_fiberwise (s := (Finset.univ : Finset G)) (t := (Finset.univ : Finset G₀))
      (f := π) fun _ _ => Finset.mem_coe.2 (Finset.mem_univ _)
    rw [Finset.card_univ] at this
    simp only [hf]
    exact_mod_cast this.symm
  have h2 : ∑ c : G, ∑ c' : G, (if π c = π c' then (1 : ℝ) else 0) = ∑ g, f g ^ 2 := by
    have hc : ∀ c : G, ∑ c' : G, (if π c = π c' then (1 : ℝ) else 0) = f (π c) := by
      intro c
      rw [Finset.sum_boole, hf]
      congr 2
      ext c'
      simp only [Finset.mem_filter, Finset.mem_univ, true_and, eq_comm]
    simp only [hc]
    rw [← Finset.sum_fiberwise (s := Finset.univ) (g := π) (f := fun c => f (π c))]
    refine Finset.sum_congr rfl fun g _ => ?_
    rw [Finset.sum_congr rfl fun c hc => by rw [(Finset.mem_filter.1 hc).2], Finset.sum_const, nsmul_eq_mul, sq]
  rw [h2, ← h1]
  have := sq_sum_le_card_mul_sum_sq (s := (Finset.univ : Finset G₀)) (f := f)
  rwa [Finset.card_univ] at this

open scoped Classical in
/-- **Concentration on a fixed level**: at any finer level whose representatives are small, the characters of
`R ⧸ N₀·R` carry weight at least `σ(univ) − ε`, once `∫ ‖χ(w) − 1‖ < ε` on `M·R ∩ B_δ` with `M ∣ N₀`. -/
private theorem concentration [NumberField F] {N N₀ : ℕ} [Fintype (unitRing F ⧸ nR F N)]
    [Fintype (unitRing F ⧸ nR F N₀)] (x : unitRing F ⧸ nR F N → unitRing F) {r : ℝ}
    (hr : ∀ c, ‖archHom F (x c)‖ < r) {M : ℕ} (hM : M ∣ N₀) {δ ε : ℝ} (hrδ : 2 * r ≤ δ)
    (hE : ∀ s, ‖archHom F (M • s)‖ < δ → ∫ χ, ‖(χ (M • s) : ℂ) - 1‖ ∂σ < ε) :
    σ.real Set.univ - ε ≤ ∑ ψ : AddChar (unitRing F ⧸ nR F N₀) ℂ, ∫ χ, twW x (liftChar ψ) χ ∂σ := by
  set m := σ.real Set.univ with hm
  set π : unitRing F ⧸ nR F N → unitRing F ⧸ nR F N₀ := fun c => ((x c : unitRing F) : unitRing F ⧸ nR F N₀)
    with hπ
  have hcard : (0 : ℝ) < Fintype.card (unitRing F ⧸ nR F N) := by exact_mod_cast Fintype.card_pos
  have hcard₀ : (0 : ℝ) < Fintype.card (unitRing F ⧸ nR F N₀) := by exact_mod_cast Fintype.card_pos
  -- the pairs in one fibre are close in `N₀·R ∩ B_δ`
  have hpair : ∀ c c', π c = π c' → m - ε ≤ (∫ χ, (χ (x c - x c') : ℂ) ∂σ).re := by
    intro c c' h
    have hmem : x c - x c' ∈ nR F N₀ := by
      have h' := QuotientAddGroup.eq.1 h
      have e : x c - x c' = -(-x c + x c') := by abel
      rw [e]
      exact (nR F N₀).neg_mem h'
    obtain ⟨s, hs⟩ := hmem
    obtain ⟨k, hk⟩ := hM
    have hw : x c - x c' = M • (k • s) := by
      rw [← hs, nsmulAddMonoidHom_apply, hk, mul_nsmul']
    have hsmall : ‖archHom F (M • (k • s))‖ < δ := by
      rw [← hw, map_sub]
      calc ‖archHom F (x c) - archHom F (x c')‖ ≤ ‖archHom F (x c)‖ + ‖archHom F (x c')‖ := norm_sub_le _ _
        _ < r + r := add_lt_add (hr c) (hr c')
        _ = 2 * r := by ring
        _ ≤ δ := hrδ
    have h1 := hE (k • s) hsmall
    rw [← hw] at h1
    have h2 := re_integral_ge σ (x c - x c')
    linarith
  -- the weights of the level-`N₀` characters, as a double sum over the pairs in one fibre
  have hC : ∀ χ : Dual F, ((∑ ψ : AddChar (unitRing F ⧸ nR F N₀) ℂ, twW x (liftChar ψ) χ : ℝ) : ℂ) =
      ((Fintype.card (unitRing F ⧸ nR F N) : ℂ) ^ 2)⁻¹ * ∑ c, ∑ c',
        (if π c = π c' then (Fintype.card (unitRing F ⧸ nR F N₀) : ℂ) else 0) * (χ (x c - x c') : ℂ) := by
    intro χ
    rw [Complex.ofReal_sum]
    simp only [twW_eq, coe_liftChar]
    rw [← Finset.mul_sum, Finset.sum_comm]
    congr 1
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun c' _ => ?_
    rw [← Finset.sum_mul, sum_conj_addChar, QuotientAddGroup.mk_sub]
    simp only [hπ, sub_eq_zero]
  have hintW : ∀ ψ : AddChar (unitRing F ⧸ nR F N₀) ℂ, Integrable (twW x (liftChar ψ)) σ := fun ψ =>
    integrable_real σ (measurable_twW x _) (twW_nonneg x _) (twW_le_one x _)
  rw [← integral_finsetSum _ fun ψ _ => hintW ψ]
  set I := ∫ χ, ∑ ψ : AddChar (unitRing F ⧸ nR F N₀) ℂ, twW x (liftChar ψ) χ ∂σ with hI
  have hI0 : 0 ≤ I := integral_nonneg fun χ => Finset.sum_nonneg fun ψ _ => twW_nonneg x _ χ
  have hIC : (I : ℂ) = ((Fintype.card (unitRing F ⧸ nR F N) : ℂ) ^ 2)⁻¹ * ∑ c, ∑ c',
      (if π c = π c' then (Fintype.card (unitRing F ⧸ nR F N₀) : ℂ) else 0) * ∫ χ, (χ (x c - x c') : ℂ) ∂σ := by
    rw [hI, ← integral_complex_ofReal, integral_congr_ae (Eventually.of_forall hC), integral_const_mul,
      integral_finsetSum _ fun c _ => integrable_finsetSum _ fun c' _ => (integrable_eval σ _).const_mul _]
    congr 1
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [integral_finsetSum _ fun c' _ => (integrable_eval σ _).const_mul _]
    refine Finset.sum_congr rfl fun c' _ => ?_
    rw [integral_const_mul]
  have hIre : I = ((Fintype.card (unitRing F ⧸ nR F N) : ℝ) ^ 2)⁻¹ * ∑ c, ∑ c',
      (if π c = π c' then (Fintype.card (unitRing F ⧸ nR F N₀) : ℝ) * (∫ χ, (χ (x c - x c') : ℂ) ∂σ).re else 0) := by
    have := congrArg Complex.re hIC
    rw [Complex.ofReal_re] at this
    rw [this]
    have e : ((Fintype.card (unitRing F ⧸ nR F N) : ℂ) ^ 2)⁻¹ =
        (((Fintype.card (unitRing F ⧸ nR F N) : ℝ) ^ 2)⁻¹ : ℝ) := by push_cast; rfl
    rw [e, Complex.re_ofReal_mul, Complex.re_sum]
    congr 1
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [Complex.re_sum]
    refine Finset.sum_congr rfl fun c' _ => ?_
    split_ifs
    · rw [← Complex.ofReal_natCast, Complex.re_ofReal_mul]
    · rw [zero_mul, Complex.zero_re]
  by_cases hme : m - ε ≤ 0
  · linarith
  push Not at hme
  have hlow : ((Fintype.card (unitRing F ⧸ nR F N₀) : ℝ) * (m - ε)) *
      (∑ c, ∑ c', if π c = π c' then (1 : ℝ) else 0) ≤
      ∑ c, ∑ c', (if π c = π c' then (Fintype.card (unitRing F ⧸ nR F N₀) : ℝ) *
        (∫ χ, (χ (x c - x c') : ℂ) ∂σ).re else 0) := by
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun c _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun c' _ => ?_
    split_ifs with h
    · rw [mul_one]
      exact mul_le_mul_of_nonneg_left (hpair c c' h) hcard₀.le
    · rw [mul_zero]
  have hcs := card_sq_le_pairs π
  rw [hIre]
  rw [← div_eq_inv_mul, le_div_iff₀ (pow_pos hcard 2)]
  nlinarith

open scoped Classical in
/-- **Continuity at one level**: the twisted part moves by at most `ε` under a shift `z` with
`‖z‖ + 2r < δ`, once `∫ ‖χ(w) − 1‖ < ε` on `M·R ∩ B_δ` with `M ∣ N` (reindex the cosets by `c ↦ c + [z]`). -/
private theorem twK_cont [NumberField F] {N : ℕ} [Fintype (unitRing F ⧸ nR F N)]
    (x : unitRing F ⧸ nR F N → unitRing F) (hx : ∀ c, (x c : unitRing F ⧸ nR F N) = c) {r : ℝ}
    (hr : ∀ c, ‖archHom F (x c)‖ < r) {t : Dual F} (ht : ∀ w ∈ nR F N, t w = 1) {M : ℕ} (hMN : M ∣ N)
    {δ ε : ℝ} (hE : ∀ s, ‖archHom F (M • s)‖ < δ → ∫ χ, ‖(χ (M • s) : ℂ) - 1‖ ∂σ < ε)
    (y z : unitRing F) (hz : ‖archHom F z‖ + 2 * r < δ) :
    ‖(starRingEnd ℂ) (t (y + z) : ℂ) * twK σ x t (y + z) - (starRingEnd ℂ) (t y : ℂ) * twK σ x t y‖ ≤ ε := by
  have hcard : (0 : ℝ) < Fintype.card (unitRing F ⧸ nR F N) := by exact_mod_cast Fintype.card_pos
  set zq : (unitRing F ⧸ nR F N) := (z : (unitRing F ⧸ nR F N)) with hzq
  set w : (unitRing F ⧸ nR F N) → unitRing F := fun c => z + x c - x (c + zq) with hw
  have hwmem : ∀ c, w c ∈ nR F N := by
    intro c
    rw [← QuotientAddGroup.eq_zero_iff, hw]
    simp only [QuotientAddGroup.mk_sub, QuotientAddGroup.mk_add, hx, hzq]
    abel
  have hwE : ∀ c, ∫ χ, ‖(χ (w c) : ℂ) - 1‖ ∂σ < ε := by
    intro c
    obtain ⟨s, hs⟩ := hwmem c
    obtain ⟨k, hk⟩ := hMN
    have hw' : w c = M • (k • s) := by rw [← hs, nsmulAddMonoidHom_apply, hk, mul_nsmul']
    rw [hw']
    refine hE (k • s) ?_
    rw [← hw', hw, map_sub, map_add]
    calc ‖archHom F z + archHom F (x c) - archHom F (x (c + zq))‖
        ≤ ‖archHom F z‖ + ‖archHom F (x c)‖ + ‖archHom F (x (c + zq))‖ := by
          refine (norm_sub_le _ _).trans ?_
          gcongr
          exact norm_add_le _ _
      _ < ‖archHom F z‖ + r + r := by linarith [hr c, hr (c + zq)]
      _ < δ := by linarith
  -- pointwise: `‖t̄(z)χ(z) − 1‖ · twW ≤ |(unitRing F ⧸ nR F N)|⁻¹ Σ_c ‖χ(w_c) − 1‖`
  have hpt : ∀ χ : Dual F, ‖(starRingEnd ℂ) (t z : ℂ) * (χ z : ℂ) - 1‖ * twW x t χ ≤
      (Fintype.card (unitRing F ⧸ nR F N) : ℝ)⁻¹ * ∑ c, ‖(χ (w c) : ℂ) - 1‖ := by
    intro χ
    set a : (unitRing F ⧸ nR F N) → ℂ := fun c => (starRingEnd ℂ) (t (x c) : ℂ) * (χ (x c) : ℂ) with ha
    have hna : ∀ c, ‖a c‖ = 1 := fun c => by
      rw [ha, norm_mul, RCLike.norm_conj, Circle.norm_coe, Circle.norm_coe, one_mul]
    set v : ℂ := (starRingEnd ℂ) (t z : ℂ) * (χ z : ℂ) with hv
    have hA : twSum x t χ = ∑ c, a c := rfl
    have hshift : ∑ c, a c = ∑ c, a (c + zq) :=
      (Fintype.sum_equiv (Equiv.addRight zq) (fun c => a (c + zq)) a fun c => rfl).symm
    have hva : ∀ c, v * a c = a (c + zq) * (χ (w c) : ℂ) := by
      intro c
      have e : z + x c = x (c + zq) + w c := by
        show z + x c = x (c + zq) + (z + x c - x (c + zq))
        exact (add_sub_cancel _ _).symm
      have htw : ((t (w c) : Circle) : ℂ) = 1 := by rw [ht _ (hwmem c), Circle.coe_one]
      have h1 : v * a c = (starRingEnd ℂ) (t (z + x c) : ℂ) * (χ (z + x c) : ℂ) := by
        rw [hv, ha, coe_char_add, coe_char_add, map_mul]
        ring
      rw [h1, e, coe_char_add, coe_char_add, map_mul, htw, map_one, ha]
      ring
    have hdiff : ‖v * twSum x t χ - twSum x t χ‖ ≤ ∑ c, ‖(χ (w c) : ℂ) - 1‖ := by
      rw [hA, Finset.mul_sum, Finset.sum_congr rfl fun c _ => hva c, hshift, ← Finset.sum_sub_distrib]
      refine (norm_sum_le _ _).trans (Finset.sum_le_sum fun c _ => ?_)
      rw [← mul_sub_one, norm_mul, hna, one_mul]
    have hnA := norm_twSum_le x t χ
    have hkey : ‖v - 1‖ * ‖twSum x t χ‖ ≤ ∑ c, ‖(χ (w c) : ℂ) - 1‖ := by
      rw [← norm_mul, sub_one_mul]
      exact hdiff
    unfold twW
    rw [mul_div_assoc', div_le_iff₀ (by positivity)]
    have hS0 : 0 ≤ ∑ c, ‖(χ (w c) : ℂ) - 1‖ := Finset.sum_nonneg fun c _ => norm_nonneg _
    calc ‖v - 1‖ * ‖twSum x t χ‖ ^ 2 = (‖v - 1‖ * ‖twSum x t χ‖) * ‖twSum x t χ‖ := by ring
      _ ≤ (∑ c, ‖(χ (w c) : ℂ) - 1‖) * Fintype.card (unitRing F ⧸ nR F N) :=
          mul_le_mul hkey hnA (norm_nonneg _) hS0
      _ = (Fintype.card (unitRing F ⧸ nR F N) : ℝ)⁻¹ * (∑ c, ‖(χ (w c) : ℂ) - 1‖) * (Fintype.card (unitRing F ⧸ nR F N) : ℝ) ^ 2 := by
          field_simp
  -- integrate
  have hint : ∀ u : unitRing F, Integrable (fun χ : Dual F => (χ u : ℂ) * (twW x t χ : ℂ)) σ := fun u =>
    integrable_eval_mul σ u (measurable_twW x t) (twW_nonneg x t) (twW_le_one x t)
  have hdiffK : (starRingEnd ℂ) (t (y + z) : ℂ) * twK σ x t (y + z) - (starRingEnd ℂ) (t y : ℂ) * twK σ x t y =
      ∫ χ, ((starRingEnd ℂ) (t y : ℂ) * (χ y : ℂ)) * (((starRingEnd ℂ) (t z : ℂ) * (χ z : ℂ) - 1) *
        (twW x t χ : ℂ)) ∂σ := by
    rw [twK, twK, ← integral_const_mul, ← integral_const_mul, ← integral_sub ((hint _).const_mul _)
      ((hint _).const_mul _)]
    refine integral_congr_ae (Eventually.of_forall fun χ => ?_)
    simp only [coe_char_add, map_mul]
    ring
  rw [hdiffK]
  have hintS : Integrable (fun χ : Dual F => (Fintype.card (unitRing F ⧸ nR F N) : ℝ)⁻¹ * ∑ c, ‖(χ (w c) : ℂ) - 1‖) σ :=
    (integrable_finsetSum _ fun c _ => ((integrable_eval σ (w c)).sub (integrable_const 1)).norm).const_mul _
  calc ‖∫ χ, ((starRingEnd ℂ) (t y : ℂ) * (χ y : ℂ)) * (((starRingEnd ℂ) (t z : ℂ) * (χ z : ℂ) - 1) *
        (twW x t χ : ℂ)) ∂σ‖
      ≤ ∫ χ, (Fintype.card (unitRing F ⧸ nR F N) : ℝ)⁻¹ * ∑ c, ‖(χ (w c) : ℂ) - 1‖ ∂σ := by
        refine norm_integral_le_of_norm_le hintS (Eventually.of_forall fun χ => ?_)
        rw [norm_mul, norm_mul, norm_mul, RCLike.norm_conj, Circle.norm_coe, Circle.norm_coe, one_mul, one_mul,
          Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (twW_nonneg x t χ)]
        exact hpt χ
    _ = (Fintype.card (unitRing F ⧸ nR F N) : ℝ)⁻¹ * ∑ c, ∫ χ, ‖(χ (w c) : ℂ) - 1‖ ∂σ := by
        rw [integral_const_mul, integral_finsetSum (f := fun c (χ : Dual F) => ‖(χ (w c) : ℂ) - 1‖) _ fun c _ =>
          ((integrable_eval σ (w c)).sub (integrable_const 1)).norm]
    _ ≤ (Fintype.card (unitRing F ⧸ nR F N) : ℝ)⁻¹ * ∑ _c : (unitRing F ⧸ nR F N), ε := by
        gcongr with c
        exact (hwE c).le
    _ = ε := by
        rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
        field_simp

end MeasureSide3

/-- A character of `R ⧸ N·R`, read on `R`, kills `N·R`. -/
private theorem liftChar_eq_one {N : ℕ} [Finite (unitRing F ⧸ nR F N)] (ψ : AddChar (unitRing F ⧸ nR F N) ℂ)
    {w : unitRing F} (hw : w ∈ nR F N) : liftChar ψ w = 1 :=
  Circle.ext (by
    rw [coe_liftChar, (QuotientAddGroup.eq_zero_iff w).2 hw, AddChar.map_zero_eq_one, Circle.coe_one])

private theorem nR_mono {N N' : ℕ} (h : N ∣ N') : nR F N' ≤ nR F N := by
  rintro w ⟨s, rfl⟩
  obtain ⟨k, rfl⟩ := h
  exact ⟨k • s, by rw [nsmulAddMonoidHom_apply, nsmulAddMonoidHom_apply, mul_nsmul']⟩

end TwistedHelpers

/-- **The twisted parts** (the profinite step; the hard leaf of M2b): a finite measure on `R̂` with `τ′_∅`-continuous transform
`φ` has `φ = Σ_{t ∈ T} ψ_t` pointwise, with each `t̄·ψ_t` positive-definite and continuous for `archTop`, and the masses
`ψ_t 0` summable. `ψ_t(y) = lim_{N′} |R ⧸ N′R|⁻¹ Σ_c t̄(x_c) φ(y + x_c)` over arch-small representatives `x_c`. -/
theorem exists_twisted_parts [NumberField F] (σ : Measure (Dual F)) [IsFiniteMeasure σ]
    (h : @Continuous (unitRing F) ℂ (tauPrime F) _ fun y => ∫ χ, (χ y : ℂ) ∂σ) :
    ∃ ψ : torsionChars (unitRing F) → unitRing F → ℂ,
      (∀ t : torsionChars (unitRing F), PosDef fun y => (starRingEnd ℂ) ((t : Dual F) y : ℂ) * ψ t y) ∧
      (∀ t : torsionChars (unitRing F),
        @Continuous (unitRing F) ℂ (archTop F) _ fun y => (starRingEnd ℂ) ((t : Dual F) y : ℂ) * ψ t y) ∧
      Summable (fun t => (ψ t 0).re) ∧ ∀ y, HasSum (fun t => ψ t y) (∫ χ, (χ y : ℂ) ∂σ) := by
  classical
  set m := σ.real Set.univ with hm
  set φ : unitRing F → ℂ := fun y => ∫ χ, (χ y : ℂ) ∂σ with hφ
  -- the levels `(n + 1)!` and their small representatives
  have hNn0 : ∀ n : ℕ, (n + 1).factorial ≠ 0 := fun n => Nat.factorial_ne_zero _
  have hdvd : ∀ M : ℕ, M ≠ 0 → ∀ n : ℕ, M ≤ n + 1 → M ∣ (n + 1).factorial := fun M hM n hn =>
    Nat.dvd_factorial (Nat.pos_of_ne_zero hM) hn
  letI hfin : ∀ n : ℕ, Fintype (unitRing F ⧸ nR F (n + 1).factorial) := fun n =>
    @Fintype.ofFinite _ (finite_quotient_nsmul F _ (hNn0 n))
  have hrep := fun n : ℕ => exists_reps F ((n + 1).factorial) (hNn0 n) (δ := 1 / ((n : ℝ) + 1)) (by positivity)
  choose x hx hxr using hrep
  have hsmallr : ∀ η > 0, ∀ᶠ n : ℕ in atTop, 2 * (1 / ((n : ℝ) + 1)) < η := by
    intro η hη
    have h0 : Tendsto (fun n : ℕ => 2 * (1 / ((n : ℝ) + 1))) atTop (𝓝 0) := by
      simpa using tendsto_one_div_add_atTop_nhds_zero_nat.const_mul (2 : ℝ)
    exact h0.eventually (gt_mem_nhds hη)
  -- every torsion character is trivial on `(n + 1)!·R` from some level on
  have htriv : ∀ t : torsionChars (unitRing F), ∀ᶠ n : ℕ in atTop,
      ∀ w ∈ nR F (n + 1).factorial, (t : Dual F) w = 1 := by
    rintro ⟨t, N₀, hN₀, ht⟩
    filter_upwards [eventually_ge_atTop N₀] with n hn
    rintro w ⟨s, rfl⟩
    obtain ⟨k, hk⟩ := hdvd N₀ hN₀ n (by omega)
    show t (((n + 1).factorial) • s) = 1
    rw [hk, mul_nsmul', AddChar.map_nsmul_eq_pow, ← AddChar.pow_apply, ht, AddChar.one_apply]
  -- the parts at level `n`
  set P : ℕ → torsionChars (unitRing F) → unitRing F → ℂ := fun n t y =>
    if ∀ w ∈ nR F (n + 1).factorial, (t : Dual F) w = 1 then twK σ (x n) t y else 0 with hP
  have hPb : ∀ n t y, ‖P n t y‖ ≤ m := by
    intro n t y
    simp only [hP]
    split_ifs
    · exact norm_twK_le σ (x n) t y
    · rw [norm_zero]
      exact measureReal_nonneg
  -- an ultrafilter limit of the parts
  set U : Ultrafilter ℕ := Ultrafilter.of atTop with hUdef
  have hU : (U : Filter ℕ) ≤ atTop := Ultrafilter.of_le atTop
  have hlim : ∀ t y, ∃ L, Tendsto (fun n => P n t y) (U : Filter ℕ) (𝓝 L) := by
    intro t y
    obtain ⟨L, -, hL⟩ := (isCompact_closedBall (0 : ℂ) m).ultrafilter_le_nhds (U.map fun n => P n t y) (by
      rw [Ultrafilter.coe_map]
      exact Filter.le_principal_iff.2 (Filter.mem_map.2 (Filter.univ_mem' fun n =>
        mem_closedBall_zero_iff.2 (hPb n t y))))
    exact ⟨L, by rw [Ultrafilter.coe_map] at hL; exact hL⟩
  choose ψ hψ using hlim
  have hev : ∀ t : torsionChars (unitRing F), ∀ᶠ n in (U : Filter ℕ), P n t = twK σ (x n) t := fun t =>
    ((htriv t).filter_mono hU).mono fun n hn => funext fun y => by simp only [hP, if_pos hn]
  -- (1) each `t̄·ψ_t` is positive-definite: a limit of positive-definite functions
  have hPD : ∀ t : torsionChars (unitRing F), PosDef fun y => (starRingEnd ℂ) ((t : Dual F) y : ℂ) * ψ t y := by
    intro t s z
    set Q : ℕ → ℂ := fun n => ∑ a ∈ s, ∑ b ∈ s, z a * star (z b) *
      ((starRingEnd ℂ) ((t : Dual F) (a - b) : ℂ) * P n t (a - b)) with hQ
    have hQt : Tendsto Q (U : Filter ℕ) (𝓝 (∑ a ∈ s, ∑ b ∈ s, z a * star (z b) *
        ((starRingEnd ℂ) ((t : Dual F) (a - b) : ℂ) * ψ t (a - b)))) :=
      tendsto_finsetSum _ fun a _ => tendsto_finsetSum _ fun b _ => ((hψ t (a - b)).const_mul _).const_mul _
    have hQev : ∀ᶠ n in (U : Filter ℕ), (Q n).im = 0 ∧ 0 ≤ (Q n).re := (hev t).mono fun n hn => by
      have h1 := posDef_twK σ (x n) (t : Dual F) s z
      simp only [hQ, hn]
      exact h1
    have him := (Complex.continuous_im.tendsto _).comp hQt
    have hre := (Complex.continuous_re.tendsto _).comp hQt
    exact ⟨tendsto_nhds_unique him (tendsto_const_nhds.congr' (hQev.mono fun n hn => hn.1.symm)),
      ge_of_tendsto hre (hQev.mono fun n hn => hn.2)⟩
  -- (2) each `t̄·ψ_t` is continuous for `archTop`: the level estimate passes to the limit
  have hcont : ∀ t : torsionChars (unitRing F),
      @Continuous (unitRing F) ℂ (archTop F) _ fun y => (starRingEnd ℂ) ((t : Dual F) y : ℂ) * ψ t y := by
    intro t
    refine (@continuous_iff_continuousAt _ _ (archTop F) _ _).2 fun y => ?_
    show Tendsto _ (@nhds _ (archTop F) y) _
    rw [archTop_eq, nhds_induced, Metric.tendsto_nhds]
    intro ε hε
    obtain ⟨M, hM, δ, hδ, hE⟩ := exists_E_small σ h (half_pos hε)
    have hball : (archHom F) ⁻¹' Metric.ball (archHom F y) (δ / 2) ∈
        Filter.comap (archHom F) (𝓝 (archHom F y)) :=
      Filter.preimage_mem_comap (Metric.ball_mem_nhds _ (half_pos hδ))
    filter_upwards [hball] with y' hy'
    rw [Set.mem_preimage, Metric.mem_ball, dist_eq_norm] at hy'
    have hyz : y + (y' - y) = y' := by abel
    have hzn : ‖archHom F (y' - y)‖ < δ / 2 := by rw [map_sub]; exact hy'
    have hlev : ∀ᶠ n in (U : Filter ℕ), ‖(starRingEnd ℂ) ((t : Dual F) y' : ℂ) * P n t y' -
        (starRingEnd ℂ) ((t : Dual F) y : ℂ) * P n t y‖ ≤ ε / 2 := by
      filter_upwards [hev t, (htriv t).filter_mono hU, (eventually_ge_atTop M).filter_mono hU, (hsmallr (δ / 2) (half_pos hδ)).filter_mono hU]
        with n hn hn1 hn2 hn3
      rw [hn, ← hyz]
      exact twK_cont σ (x n) (hx n) (hxr n) hn1 (hdvd M hM n (by omega)) hE y (y' - y) (by linarith)
    have hl := (((hψ t y').const_mul ((starRingEnd ℂ) ((t : Dual F) y' : ℂ))).sub
      ((hψ t y).const_mul ((starRingEnd ℂ) ((t : Dual F) y : ℂ)))).norm
    have := le_of_tendsto hl hlev
    rw [dist_eq_norm]
    linarith
  -- the remainder at level `n`, for a finite set of torsion characters
  have hlevS : ∀ n (S : Finset (torsionChars (unitRing F))) y,
      ‖φ y - ∑ t ∈ S, P n t y‖ ≤ m - ∑ t ∈ S, (P n t 0).re := by
    intro n S y
    set S' : Finset (Dual F) := (S.filter fun t : torsionChars (unitRing F) => ∀ w ∈ nR F (n + 1).factorial, (t : Dual F) w = 1).map
      (Function.Embedding.subtype _) with hS'
    have hS'triv : ∀ t ∈ S', ∀ w ∈ nR F (n + 1).factorial, t w = 1 := by
      intro t ht
      rw [hS', Finset.mem_map] at ht
      obtain ⟨t', ht', rfl⟩ := ht
      exact (Finset.mem_filter.1 ht').2
    have hsum : ∀ y, ∑ t ∈ S, P n t y = ∑ t ∈ S', twK σ (x n) t y := by
      intro y
      rw [hS', Finset.sum_map, Finset.sum_filter]
      rfl
    have hsum0 : ∑ t ∈ S, (P n t 0).re = ∑ t ∈ S', ∫ χ, twW (x n) t χ ∂σ := by
      rw [← Complex.re_sum, hsum 0, Complex.re_sum]
      refine Finset.sum_congr rfl fun t _ => ?_
      rw [twK_zero, Complex.ofReal_re]
    rw [hsum y, hsum0]
    exact norm_sub_sum_twK_le σ (x n) (hx n) S' hS'triv y
  -- (3) the masses: non-negative, with partial sums at most `σ(univ)`
  have hre0 : ∀ t, 0 ≤ (ψ t 0).re := fun t =>
    ge_of_tendsto ((Complex.continuous_re.tendsto _).comp (hψ t 0)) (Eventually.of_forall fun n => by
      simp only [Function.comp, hP]
      split_ifs
      · rw [twK_zero, Complex.ofReal_re]
        exact integral_nonneg fun χ => twW_nonneg _ _ _
      · rw [Complex.zero_re])
  have hpart : ∀ (S : Finset (torsionChars (unitRing F))) y,
      ‖φ y - ∑ t ∈ S, ψ t y‖ ≤ m - ∑ t ∈ S, (ψ t 0).re := by
    intro S y
    have h1 : Tendsto (fun n => ‖φ y - ∑ t ∈ S, P n t y‖) (U : Filter ℕ) (𝓝 ‖φ y - ∑ t ∈ S, ψ t y‖) :=
      (tendsto_const_nhds.sub (tendsto_finsetSum _ fun t _ => hψ t y)).norm
    have h2 : Tendsto (fun n => m - ∑ t ∈ S, (P n t 0).re) (U : Filter ℕ) (𝓝 (m - ∑ t ∈ S, (ψ t 0).re)) :=
      tendsto_const_nhds.sub (tendsto_finsetSum _ fun t _ => (Complex.continuous_re.tendsto _).comp (hψ t 0))
    exact le_of_tendsto_of_tendsto' h1 h2 fun n => hlevS n S y
  have hsummable : Summable fun t => (ψ t 0).re := summable_of_sum_le (fun t => hre0 t) fun S => by
    have := hpart S 0
    linarith [norm_nonneg (φ 0 - ∑ t ∈ S, ψ t 0)]
  -- (4) concentration on the characters of one finite level
  have hconc : ∀ ε > 0, ∃ S₀ : Finset (torsionChars (unitRing F)), m - ε ≤ ∑ t ∈ S₀, (ψ t 0).re := by
    intro ε hε
    obtain ⟨M, hM, δ, hδ, hE⟩ := exists_E_small σ h hε
    have hMN₀ : M ∣ (M + 1).factorial := hdvd M hM M (by omega)
    let lt : AddChar (unitRing F ⧸ nR F (M + 1).factorial) ℂ → torsionChars (unitRing F) := fun ψ' =>
      ⟨liftChar ψ', (M + 1).factorial, hNn0 M, AddChar.ext _ _ fun r => by
        rw [AddChar.pow_apply, ← AddChar.map_nsmul_eq_pow, AddChar.one_apply]
        exact liftChar_eq_one ψ' ⟨r, rfl⟩⟩
    have hlt_inj : Function.Injective lt := fun a b hab => liftChar_injective (congrArg Subtype.val hab)
    refine ⟨Finset.univ.image lt, ?_⟩
    rw [Finset.sum_image fun a _ b _ hab => hlt_inj hab]
    have hlev : ∀ᶠ n in (U : Filter ℕ), m - ε ≤ ∑ ψ' : AddChar (unitRing F ⧸ nR F (M + 1).factorial) ℂ,
        (P n (lt ψ') 0).re := by
      filter_upwards [(eventually_ge_atTop M).filter_mono hU, (hsmallr δ hδ).filter_mono hU] with n hn1 hn2
      have hdiv : (M + 1).factorial ∣ (n + 1).factorial := Nat.factorial_dvd_factorial (by omega)
      have htr : ∀ ψ' : AddChar (unitRing F ⧸ nR F (M + 1).factorial) ℂ,
          ∀ w ∈ nR F (n + 1).factorial, ((lt ψ' : torsionChars (unitRing F)) : Dual F) w = 1 :=
        fun ψ' w hw => liftChar_eq_one ψ' (nR_mono hdiv hw)
      have hval : ∀ ψ', (P n (lt ψ') 0).re = ∫ χ, twW (x n) (liftChar ψ') χ ∂σ := fun ψ' => by
        simp only [hP, if_pos (htr ψ')]
        rw [twK_zero, Complex.ofReal_re]
      simp only [hval]
      exact concentration σ (x n) (hxr n) hMN₀ hn2.le hE
    exact ge_of_tendsto (tendsto_finsetSum _ fun ψ' _ => (Complex.continuous_re.tendsto _).comp (hψ (lt ψ') 0))
      hlev
  refine ⟨ψ, hPD, hcont, hsummable, fun y => ?_⟩
  unfold HasSum
  rw [SummationFilter.unconditional_filter, Metric.tendsto_atTop]
  intro ε hε
  obtain ⟨S₀, hS₀⟩ := hconc (ε / 2) (half_pos hε)
  refine ⟨S₀, fun S hS => ?_⟩
  have h1 := hpart S y
  have h2 : ∑ t ∈ S₀, (ψ t 0).re ≤ ∑ t ∈ S, (ψ t 0).re :=
    Finset.sum_le_sum_of_subset_of_nonneg hS fun t _ _ => hre0 t
  rw [dist_eq_norm, norm_sub_rev]
  linarith

/-- **Bochner's theorem for `τ′_∅`** (J45 N2's `⟸` at `S = ∅`): each `t̄·ψ_t` of `exists_twisted_parts` is the transform of a
measure `ρ_t` (`bochnerHerglotz_of_countable`), carried by `A` (`archimedean_support`); `Σ_t (t ·)_* ρ_t` has transform `φ`
and is carried by `T·A`; uniqueness (`measure_eq_of_fourier`) identifies it with `σ`. -/
theorem bochnerOn_tauPrime [NumberField F] : BochnerOn (tauPrime F) := by
  intro σ hσ hc
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  rw [contChars_tauPrime]
  obtain ⟨ψ, hPD, hcont, hsum, hhas⟩ := exists_twisted_parts F σ hc
  -- each twisted part is the transform of a finite measure carried by `A`
  have hρ : ∀ t : torsionChars (unitRing F), ∃ ρ : Measure (Dual F), IsFiniteMeasure ρ ∧
      (∀ y, ∫ χ, (χ y : ℂ) ∂ρ = (starRingEnd ℂ) ((t : Dual F) y : ℂ) * ψ t y) ∧
      ρ (archChars (unitRing F))ᶜ = 0 := by
    intro t
    obtain ⟨ρ, hρf, hρF, -⟩ := bochnerHerglotz_of_countable (unitRing F) _ (hPD t)
    haveI := hρf
    refine ⟨ρ, hρf, hρF, archimedean_support F ρ ?_⟩
    have e : (fun y => ∫ χ, (χ y : ℂ) ∂ρ) = fun y => (starRingEnd ℂ) ((t : Dual F) y : ℂ) * ψ t y := funext hρF
    rw [e]
    exact hcont t
  choose ρ hρf hρF hρA using hρ
  have h0 : ∀ t, (((ρ t).real Set.univ : ℝ) : ℂ) = ψ t 0 := fun t => by
    haveI := hρf t
    have h := hρF t 0
    simp only [AddChar.map_zero_eq_one, Circle.coe_one, map_one, one_mul, integral_const, Complex.real_smul,
      mul_one] at h
    exact h
  have hre0 : ∀ t, 0 ≤ (ψ t 0).re := fun t => by
    rw [← h0 t, Complex.ofReal_re]
    exact measureReal_nonneg
  have hmass : ∀ t, ρ t Set.univ = ENNReal.ofReal (ψ t 0).re := fun t => by
    haveI := hρf t
    rw [← h0 t, Complex.ofReal_re, measureReal_def, ENNReal.ofReal_toReal (measure_ne_top _ _)]
  -- the sum of the twisted measures, each moved to its coset `t·A`
  set ν : Measure (Dual F) := Measure.sum fun t : torsionChars (unitRing F) => (ρ t).map (· * (t : Dual F))
    with hν
  have hνuniv : ν Set.univ = ENNReal.ofReal (∑' t, (ψ t 0).re) := by
    rw [hν, Measure.sum_apply _ MeasurableSet.univ]
    simp only [Measure.map_apply (measurable_mulRight _) MeasurableSet.univ, Set.preimage_univ, hmass]
    exact (ENNReal.ofReal_tsum_of_nonneg hre0 hsum).symm
  haveI hνf : IsFiniteMeasure ν := ⟨by rw [hνuniv]; exact ENNReal.ofReal_lt_top⟩
  -- its transform is `φ`
  have hνF : ∀ y, ∫ χ, (χ y : ℂ) ∂ν = ∫ χ, (χ y : ℂ) ∂σ := by
    intro y
    have hint : Integrable (fun χ : Dual F => (χ y : ℂ)) ν :=
      Integrable.of_bound (measurable_evalChar y).aestronglyMeasurable 1
        (Eventually.of_forall fun χ => by rw [Circle.norm_coe])
    rw [hν, integral_sum_measure hint]
    have ht : ∀ t : torsionChars (unitRing F), ∫ χ, (χ y : ℂ) ∂((ρ t).map (· * (t : Dual F))) = ψ t y := by
      intro t
      haveI := hρf t
      rw [integral_map (measurable_mulRight _).aemeasurable (measurable_evalChar y).aestronglyMeasurable]
      simp only [AddChar.mul_apply, Circle.coe_mul]
      rw [integral_mul_const, hρF t y]
      have hu : (starRingEnd ℂ) ((t : Dual F) y : ℂ) * ((t : Dual F) y : ℂ) = 1 := by
        rw [mul_comm, Complex.mul_conj, Complex.normSq_eq_norm_sq, Circle.norm_coe]
        norm_num
      linear_combination ψ t y * hu
    simp only [ht]
    exact (hhas y).tsum_eq
  have hσν : σ = ν := measure_eq_of_fourier fun r => (hνF r).symm
  -- `ν` is carried by `T·A`
  rw [hσν, hν, Measure.sum_apply _ (measurableSet_TA F).compl]
  refine ENNReal.tsum_eq_zero.2 fun t => ?_
  rw [Measure.map_apply (measurable_mulRight _) (measurableSet_TA F).compl]
  have hsub : (fun χ : Dual F => χ * (t : Dual F)) ⁻¹' (TA F)ᶜ ⊆ (archChars (unitRing F))ᶜ := by
    intro χ hχ hA
    apply hχ
    show χ * (t : Dual F) ∈ TA F
    rw [mul_comm]
    exact Set.mul_mem_mul t.2 hA
  exact measure_mono_null hsub (hρA t)

end

end HadwigerNelson.Rigidity
