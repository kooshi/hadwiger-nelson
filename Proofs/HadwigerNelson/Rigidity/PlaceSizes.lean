import Proofs.HadwigerNelson.Rigidity.TateCharacter
import Mathlib.NumberTheory.NumberField.ProductFormula
import Mathlib.NumberTheory.NumberField.InfinitePlace.Embeddings

/-!
# The places of `W`, their sizes, and the product-formula gap (FS-131, job FS131-K8B1; module M8b-2a)

The arithmetic M8b's three parts read (`plans/FS131-K8B1-zero-entropy-second.md`; X01D §§ 3.1–3.2, `plans/FS100-X01D-derivation.md`
ll. 203–219). `L = F(i)` is `fieldI F`; `W = SAdeleRing F`, the mixed space of `L` times the split adeles (`Rigidity/TateModel`).

**Read aloud.**

* **The places of `W`** (`WPlace F`, X01D l. 118): the archimedean places of `L` and its split primes — the stable primes do not
  appear in `W`. At a place `p`, a point `a ∈ W` has a **size** (`WPlace.size`): the ordinary modulus of its archimedean
  component (`normAtPlace`), or the normalised absolute value of its component in `L_w` (Mathlib's norm on `adicCompletion`,
  `‖x‖ = N𝔓^{−v(x)}`); an element `x ∈ L` has an **absolute value** there (`WPlace.absAt`), `v x` or `‖x‖_w`, and the size of
  `ι(x)·a` is `|x|_p` times the size of `a` (`size_toSAdele_mul`). "Ordinary moduli inside, normalised outside" (X01D l. 226)
  is this pair with the archimedean factors raised to `v.mult` (`= 2`: `L` is totally complex).
* **The hyperplane** `W_p := {a : a_p = 0}` (`hyperplane`, X01D l. 211) meets the diagonal only in `0`
  (`eq_zero_of_toSAdele_mem_hyperplane`): "an element of a field with a zero component is `0`".
* **The split height** `∏_{w split} max(1, |x|_w)` (`splitHeight`, X01D l. 226), a finite product for every `x`.
* **Lemma PF** (X01D l. 208): for `x ∈ O′ ∖ 0`, `∏_{v|∞} |x|_v^{mult} · ∏_{w ∈ T} |x|_w ≥ 1` for every finite set `T` of split
  primes outside which `|x|_w ≤ 1` (`one_le_prod_absAt_of_mem_stableIntegers`: the product formula, with the stable factors
  at most `1`); for the lattice `Λ` of a Tate model a gap `C > 0` with the same property (`TateModel.IsGap`,
  `TateModel.exists_isGap`: `C = d^{−[L:ℚ]}` from `Λ ⊆ d⁻¹O′`, X01D's `1/C_Λ`).
* **Step 0, an expanding place** (X01D § 3.2): a non-torsion unit vector `u*` has `|u*|_p > 1` at some place `p` of `W`
  (`exists_one_lt_absAt`) — at a split prime if `u*` is not integral (it is integral at the stable primes, `R ⊆ O′`), at an
  archimedean place if it is (else every `|u*|_v = 1`, since `|ū*|_v = |u*|_{v∘σ}` and `u* ū* = 1`, and Kronecker).
* **The shells' multiplier** (X01D § 3.8, without the class group): at every split prime `w` a unit vector `g = γ/γ̄`,
  `γ ∈ 𝔓_w ∖ σ𝔓_w`, with `|g|_w < 1` (`exists_unitVector_absAt_lt_one`).
* `SplitPlace F` and `L` are countable (`countable_splitPlace`, `countable_fieldI`).

**Inhabitants.** Every statement is about every real number field and every point; the spec examples below fix each
definition. `TateModel.IsGap` is a property of a constant; its model is `exists_isGap`'s constant at any Tate model
(`Rigidity.exists_tateModel` supplies one). `exists_one_lt_absAt`'s hypothesis is inhabited at `(3 + 4i)/5`
(`exists_nonTorsion_unitVector`).
-/

namespace HadwigerNelson.Rigidity

open SpectralChain NumberField IsDedekindDomain IsDedekindDomain.HeightOneSpectrum

open scoped RestrictedProduct

noncomputable section

variable (F : Subfield ℝ) [NumberField F]

/-- **The places of `W`** (X01D l. 118): the archimedean places of `L = F(i)` and its split primes. -/
inductive WPlace : Type
  /-- An archimedean place of `L`. -/
  | arch (v : InfinitePlace (fieldI F))
  /-- A split prime of `L`. -/
  | split (w : SplitPlace F)

variable {F}

namespace WPlace

/-- **The size of a point of `W` at a place**: the ordinary modulus of the archimedean component, or the normalised absolute
value of the component at a split prime. -/
def size : WPlace F → SAdeleRing F → ℝ
  | .arch v, a => mixedEmbedding.normAtPlace v a.1
  | .split w, a => ‖a.2 w‖

/-- **The absolute value of `x ∈ L` at a place of `W`**: `v x` (ordinary) at an archimedean place, `‖x‖_w` (normalised) at a
split prime. -/
def absAt : WPlace F → fieldI F → ℝ
  | .arch v, x => v x
  | .split w, x => ‖(x : w.1.adicCompletion (fieldI F))‖

example (v : InfinitePlace (fieldI F)) (a : SAdeleRing F) :
    (WPlace.arch v).size a = mixedEmbedding.normAtPlace v a.1 := rfl

example (w : SplitPlace F) (a : SAdeleRing F) : (WPlace.split w).size a = ‖a.2 w‖ := rfl

example (v : InfinitePlace (fieldI F)) (x : fieldI F) : (WPlace.arch v).absAt x = v x := rfl

example (w : SplitPlace F) (x : fieldI F) :
    (WPlace.split w).absAt x = ‖(x : w.1.adicCompletion (fieldI F))‖ := rfl

/-- The norm of `L_v` is at most `1` exactly on the integers (`FinitePlace.norm_def`, `toNNReal` monotone). -/
private theorem norm_le_one_iff_valued (v : HeightOneSpectrum (𝓞 (fieldI F))) (z : v.adicCompletion (fieldI F)) :
    ‖z‖ ≤ 1 ↔ Valued.v z ≤ 1 := by
  rw [FinitePlace.norm_def, ← NNReal.coe_one, NNReal.coe_le_coe]
  exact WithZeroMulInt.toNNReal_le_one_iff (NumberField.HeightOneSpectrum.one_lt_absNorm_nnreal v)

/-- The norm of `L_v` is less than `1` exactly on the valuation's `< 1` part. -/
private theorem norm_lt_one_iff_valued (v : HeightOneSpectrum (𝓞 (fieldI F))) (z : v.adicCompletion (fieldI F)) :
    ‖z‖ < 1 ↔ Valued.v z < 1 := by
  rw [lt_iff_le_and_ne, lt_iff_le_and_ne, norm_le_one_iff_valued, FinitePlace.norm_def, ← NNReal.coe_one, Ne,
    NNReal.coe_inj, ← map_one (WithZeroMulInt.toNNReal (NumberField.HeightOneSpectrum.absNorm_ne_zero v)),
    (WithZeroMulInt.toNNReal_strictMono (NumberField.HeightOneSpectrum.one_lt_absNorm_nnreal v)).injective.eq_iff]

/-- The norm of an element of `L` in `L_v` is at most `1` exactly when its valuation is. -/
private theorem norm_coe_le_one_iff (v : HeightOneSpectrum (𝓞 (fieldI F))) (x : fieldI F) :
    ‖(x : v.adicCompletion (fieldI F))‖ ≤ 1 ↔ v.valuation (fieldI F) x ≤ 1 := by
  rw [norm_le_one_iff_valued, valuedAdicCompletion_eq_valuation']

private theorem coe_natCast_completion (v : HeightOneSpectrum (𝓞 (fieldI F))) (n : ℕ) :
    ((n : fieldI F) : v.adicCompletion (fieldI F)) = (n : v.adicCompletion (fieldI F)) :=
  map_natCast (algebraMap (fieldI F) (v.adicCompletion (fieldI F))) n

private theorem coe_mul_completion (v : HeightOneSpectrum (𝓞 (fieldI F))) (x y : fieldI F) :
    ((x * y : fieldI F) : v.adicCompletion (fieldI F)) = (x : v.adicCompletion (fieldI F)) * (y : _) :=
  map_mul (algebraMap (fieldI F) (v.adicCompletion (fieldI F))) x y

/-- The size of a diagonal point is the absolute value. -/
theorem size_toSAdele (p : WPlace F) (x : fieldI F) : p.size (toSAdele F x) = p.absAt x := by
  cases p with
  | arch v => exact mixedEmbedding.normAtPlace_apply v x
  | split w => rfl

/-- **Sizes are multiplicative along the diagonal**: `|ι(x)·a|_p = |x|_p·|a|_p`. -/
theorem size_toSAdele_mul (p : WPlace F) (x : fieldI F) (a : SAdeleRing F) :
    p.size (toSAdele F x * a) = p.absAt x * p.size a := by
  cases p with
  | arch v =>
    show mixedEmbedding.normAtPlace v (mixedEmbedding (fieldI F) x * a.1) = v x * mixedEmbedding.normAtPlace v a.1
    rw [map_mul, mixedEmbedding.normAtPlace_apply]
  | split w => exact norm_mul _ _

/-- The triangle inequality at every place. -/
theorem size_add_le (p : WPlace F) (a b : SAdeleRing F) : p.size (a + b) ≤ p.size a + p.size b := by
  cases p with
  | arch v => exact mixedEmbedding.normAtPlace_add_le v a.1 b.1
  | split w => exact norm_add_le _ _

/-- **The ultrametric inequality at a split prime.** -/
theorem size_add_le_max (w : SplitPlace F) (a b : SAdeleRing F) :
    (WPlace.split w).size (a + b) ≤ max ((WPlace.split w).size a) ((WPlace.split w).size b) :=
  IsUltrametricDist.norm_add_le_max (a.2 w) (b.2 w)

theorem size_neg (p : WPlace F) (a : SAdeleRing F) : p.size (-a) = p.size a := by
  cases p with
  | arch v => exact mixedEmbedding.normAtPlace_neg v a.1
  | split w => exact norm_neg _

theorem size_nonneg (p : WPlace F) (a : SAdeleRing F) : 0 ≤ p.size a := by
  cases p with
  | arch v => exact mixedEmbedding.normAtPlace_nonneg v a.1
  | split w => exact norm_nonneg _

theorem continuous_size (p : WPlace F) : Continuous p.size := by
  cases p with
  | arch v => exact (mixedEmbedding.continuous_normAtPlace v).comp continuous_fst
  | split w => exact continuous_norm.comp ((RestrictedProduct.continuous_eval w).comp continuous_snd)

theorem absAt_mul (p : WPlace F) (x y : fieldI F) : p.absAt (x * y) = p.absAt x * p.absAt y := by
  cases p with
  | arch v => exact map_mul v x y
  | split w =>
    show ‖((x * y : fieldI F) : w.1.adicCompletion (fieldI F))‖ = _
    rw [coe_mul_completion, norm_mul]; rfl

theorem absAt_nonneg (p : WPlace F) (x : fieldI F) : 0 ≤ p.absAt x := by
  cases p with
  | arch v => exact apply_nonneg v x
  | split w => exact norm_nonneg _

theorem absAt_eq_zero (p : WPlace F) {x : fieldI F} : p.absAt x = 0 ↔ x = 0 := by
  cases p with
  | arch v => exact map_eq_zero v
  | split w =>
    show ‖(x : w.1.adicCompletion (fieldI F))‖ = 0 ↔ x = 0
    rw [norm_eq_zero]
    exact map_eq_zero (algebraMap (fieldI F) (w.1.adicCompletion (fieldI F)))

/-- An integer has absolute value at most `1` at a split prime. -/
theorem absAt_natCast_le_one (w : SplitPlace F) (n : ℕ) : (WPlace.split w).absAt (n : fieldI F) ≤ 1 := by
  show ‖((n : fieldI F) : w.1.adicCompletion (fieldI F))‖ ≤ 1
  rw [coe_natCast_completion, norm_le_one_iff_valued]
  exact (mem_adicCompletionIntegers _ _ _).1 (natCast_mem _ n)

/-- A point of the split box (integral at `w`) has size at most `1` there. -/
theorem size_le_one_iff (w : SplitPlace F) (a : SAdeleRing F) :
    (WPlace.split w).size a ≤ 1 ↔ a.2 w ∈ w.1.adicCompletionIntegers (fieldI F) := by
  rw [mem_adicCompletionIntegers]
  exact norm_le_one_iff_valued w.1 (a.2 w)

end WPlace

open WPlace

/-- **The hyperplane `W_p = {a : a_p = 0}`** (X01D l. 211). -/
def hyperplane (p : WPlace F) : Set (SAdeleRing F) := {a | p.size a = 0}

example (p : WPlace F) (a : SAdeleRing F) : a ∈ hyperplane p ↔ p.size a = 0 := Iff.rfl

theorem isClosed_hyperplane (p : WPlace F) : IsClosed (hyperplane p) :=
  isClosed_eq (continuous_size p) continuous_const

/-- The hyperplane is stable under multiplication by the diagonal. -/
theorem toSAdele_mul_mem_hyperplane (p : WPlace F) (x : fieldI F) {a : SAdeleRing F} (ha : a ∈ hyperplane p) :
    toSAdele F x * a ∈ hyperplane p := by
  show p.size _ = 0
  rw [size_toSAdele_mul, ha.out, mul_zero]

/-- **`W_p ∩ L = 0`** (X01D l. 211): an element of a field with a zero component is `0`. -/
theorem eq_zero_of_toSAdele_mem_hyperplane {p : WPlace F} {x : fieldI F} (h : toSAdele F x ∈ hyperplane p) : x = 0 :=
  (absAt_eq_zero p).mp ((size_toSAdele p x).symm.trans h)

/-- **The split height** `∏_{w split} max(1, |x|_w)` (X01D l. 226): a finite product (`hasFiniteMulSupport_splitHeight`). -/
def splitHeight (x : fieldI F) : ℝ := ∏ᶠ w : SplitPlace F, max 1 ((WPlace.split w).absAt x)

example (x : fieldI F) : splitHeight x = ∏ᶠ w : SplitPlace F, max 1 ((WPlace.split w).absAt x) := rfl

/-- `x` is integral at all but finitely many split primes (`HeightOneSpectrum.Support.finite`). -/
theorem exists_finset_absAt_le_one (x : fieldI F) :
    ∃ T : Finset (SplitPlace F), ∀ w ∉ T, (WPlace.split w).absAt x ≤ 1 := by
  have hfin := (HeightOneSpectrum.Support.finite (𝓞 (fieldI F)) x).preimage
    (f := fun w : SplitPlace F => w.1) Subtype.val_injective.injOn
  refine ⟨hfin.toFinset, fun w hw => ?_⟩
  have hv : w.1.valuation (fieldI F) x ≤ 1 := not_lt.1 fun h => hw (hfin.mem_toFinset.2 h)
  exact (norm_coe_le_one_iff w.1 x).2 hv

/-- The split height is the finite product over any finite set outside which `x` is integral. -/
theorem splitHeight_eq_prod (x : fieldI F) (T : Finset (SplitPlace F))
    (hT : ∀ w ∉ T, (WPlace.split w).absAt x ≤ 1) :
    splitHeight x = ∏ w ∈ T, max 1 ((WPlace.split w).absAt x) := by
  refine finprod_eq_prod_of_mulSupport_subset _ fun w hw => ?_
  by_contra h
  exact hw (max_eq_left (hT w h))

theorem one_le_splitHeight (x : fieldI F) : 1 ≤ splitHeight x := by
  obtain ⟨T, hT⟩ := exists_finset_absAt_le_one x
  rw [splitHeight_eq_prod x T hT]
  exact Finset.one_le_prod fun w _ => le_max_left _ _

theorem absAt_le_splitHeight (w : SplitPlace F) (x : fieldI F) : (WPlace.split w).absAt x ≤ splitHeight x := by
  classical
  obtain ⟨T, hT⟩ := exists_finset_absAt_le_one x
  have hT' : ∀ w' ∉ insert w T, (WPlace.split w').absAt x ≤ 1 := fun w' hw' => hT w' fun h => hw' (Finset.mem_insert_of_mem h)
  rw [splitHeight_eq_prod x _ hT', ← Finset.mul_prod_erase _ _ (Finset.mem_insert_self w T)]
  exact (le_max_right _ _).trans (le_mul_of_one_le_right (zero_le_one.trans (le_max_left _ _))
    (Finset.one_le_prod fun w' _ => le_max_left _ _))

/-- **Lemma PF for `O′`** (X01D l. 208, "for `y ∈ R ∖ {0}` the bound is `≥ 1`", read for `O′ ⊇ R`): the product formula,
with every stable factor at most `1`. -/
theorem one_le_prod_absAt_of_mem_stableIntegers {x : fieldI F} (hx : x ∈ stableIntegers F) (hx0 : x ≠ 0)
    (T : Finset (SplitPlace F)) (hT : ∀ w ∉ T, (WPlace.split w).absAt x ≤ 1) :
    1 ≤ (∏ v : InfinitePlace (fieldI F), v x ^ v.mult) * ∏ w ∈ T, (WPlace.split w).absAt x := by
  classical
  -- the product formula, its finite part read over `HeightOneSpectrum` as `‖x‖_v`
  let f : HeightOneSpectrum (𝓞 (fieldI F)) → ℝ := fun v => ‖(x : v.adicCompletion (fieldI F))‖
  have hf : ∀ v, (FinitePlace.equivHeightOneSpectrum.symm v) x = f v := fun v =>
    FinitePlace.equivHeightOneSpectrum_symm_apply v x
  have hPF := prod_abs_eq_one hx0
  rw [← finprod_comp_equiv FinitePlace.equivHeightOneSpectrum.symm, finprod_congr hf] at hPF
  have hfin : (Function.mulSupport f).Finite := by
    refine ((FinitePlace.hasFiniteMulSupport hx0).preimage
      FinitePlace.equivHeightOneSpectrum.symm.injective.injOn).subset fun v hv => ?_
    show (FinitePlace.equivHeightOneSpectrum.symm v) x ≠ 1
    rw [hf]; exact hv
  let S := hfin.toFinset ∪ T.image Subtype.val
  have hS : ∏ᶠ v, f v = ∏ v ∈ S, f v :=
    finprod_eq_prod_of_mulSupport_subset f fun v hv => Finset.mem_union_left _ (hfin.mem_toFinset.2 hv)
  -- the factors outside `T` are at most `1`: the stable ones (`x ∈ O′`) and the split ones off `T`
  have hle : ∏ v ∈ S, f v ≤ ∏ w ∈ T, (WPlace.split w).absAt x := by
    rw [← Finset.prod_sdiff (Finset.subset_union_right : T.image Subtype.val ⊆ S),
      Finset.prod_image Subtype.val_injective.injOn]
    refine mul_le_of_le_one_left (Finset.prod_nonneg fun w _ => norm_nonneg _)
      (Finset.prod_le_one (fun v _ => norm_nonneg _) fun v hv => ?_)
    have hvT : v ∉ T.image Subtype.val := (Finset.mem_sdiff.1 hv).2
    by_cases hst : IsStablePlace F v
    · exact (norm_coe_le_one_iff v x).2 ((mem_stableIntegers_iff_valuation F).1 hx v hst)
    · exact hT ⟨v, hst⟩ fun h => hvT (Finset.mem_image_of_mem _ h)
  have hA : 0 ≤ ∏ v : InfinitePlace (fieldI F), v x ^ v.mult :=
    Finset.prod_nonneg fun v _ => pow_nonneg (apply_nonneg v x) _
  calc (1 : ℝ) = (∏ v : InfinitePlace (fieldI F), v x ^ v.mult) * ∏ v ∈ S, f v := by rw [← hS]; exact hPF.symm
    _ ≤ _ := mul_le_mul_of_nonneg_left hle hA

/-- The ring `R` lies in `O′`, read through `ofUnitRing` (`unitRing_le_stableIntegers`). -/
theorem ofUnitRing_mem_stableIntegers (r : unitRing F) : ofUnitRing F r ∈ stableIntegers F :=
  unitRing_le_stableIntegers F ((UnitRing.coe_mem_unitRingOver_iff (ofUnitRing F r)).1 r.2)

omit [NumberField F] in
/-- A unit vector read in `L` is its element of `R` read in `L`. -/
theorem unitL_eq_ofUnitRing (u : unitVectors F) : unitL u = ofUnitRing F (uvRing u) := rfl

/-- **A product-formula gap for the lattice of `D`** (X01D § 3.1, Lemma PF, with `C = 1/C_Λ`): a nonzero point of `Λ` that is
integral outside a finite set `T` of split primes has `∏_{v|∞} |y|_v^{mult} · ∏_{w ∈ T} |y|_w ≥ C`. -/
def TateModel.IsGap (D : TateModel F) (C : ℝ) : Prop :=
  ∀ y ∈ D.Λ, ∀ T : Finset (SplitPlace F), (∀ w ∉ T, (WPlace.split w).absAt y ≤ 1) →
    (∏ v : InfinitePlace (fieldI F), v y ^ v.mult) * ∏ w ∈ T, (WPlace.split w).absAt y < C → y = 0

example (D : TateModel F) (C : ℝ) : D.IsGap C ↔ ∀ y ∈ D.Λ, ∀ T : Finset (SplitPlace F),
    (∀ w ∉ T, (WPlace.split w).absAt y ≤ 1) →
    (∏ v : InfinitePlace (fieldI F), v y ^ v.mult) * ∏ w ∈ T, (WPlace.split w).absAt y < C → y = 0 := Iff.rfl

/-- **Lemma PF for `Λ`** (X01D l. 208): `C := d^{−[L:ℚ]}` is a gap, where `d·Λ ⊆ O′` (`exists_nat_mul_mem`). -/
theorem TateModel.exists_isGap (D : TateModel F) : ∃ C : ℝ, 0 < C ∧ D.IsGap C := by
  obtain ⟨d, hd0, hd⟩ := D.exists_nat_mul_mem
  have hdpos : (0 : ℝ) < d := Nat.cast_pos.2 (Nat.pos_of_ne_zero hd0)
  refine ⟨((d : ℝ)⁻¹) ^ Module.finrank ℚ (fieldI F), by positivity, fun y hy T hT hlt => ?_⟩
  by_contra hy0
  have hdy : (d : fieldI F) * y ∈ stableIntegers F := hd y hy
  have hdy0 : (d : fieldI F) * y ≠ 0 := mul_ne_zero (Nat.cast_ne_zero.2 hd0) hy0
  have hTd : ∀ w ∉ T, (WPlace.split w).absAt ((d : fieldI F) * y) ≤ 1 := fun w hw => by
    rw [absAt_mul]
    exact mul_le_one₀ (absAt_natCast_le_one w d) (absAt_nonneg _ _) (hT w hw)
  have hPF := one_le_prod_absAt_of_mem_stableIntegers hdy hdy0 T hTd
  -- archimedean: `v(d y)^{mult} = d^{mult} v(y)^{mult}`, and `∑ mult = [L:ℚ]`
  have harch : (∏ v : InfinitePlace (fieldI F), v ((d : fieldI F) * y) ^ v.mult) =
      (d : ℝ) ^ Module.finrank ℚ (fieldI F) * ∏ v : InfinitePlace (fieldI F), v y ^ v.mult := by
    rw [Finset.prod_congr rfl fun v _ => by rw [map_mul, InfinitePlace.map_natCast, mul_pow],
      Finset.prod_mul_distrib, Finset.prod_pow_eq_pow_sum, InfinitePlace.sum_mult_eq]
  have hsplit : ∏ w ∈ T, (WPlace.split w).absAt ((d : fieldI F) * y) ≤ ∏ w ∈ T, (WPlace.split w).absAt y := by
    refine Finset.prod_le_prod (fun w _ => absAt_nonneg _ _) fun w _ => ?_
    rw [absAt_mul]
    exact mul_le_of_le_one_left (absAt_nonneg _ _) (absAt_natCast_le_one w d)
  have hA : 0 ≤ ∏ v : InfinitePlace (fieldI F), v y ^ v.mult :=
    Finset.prod_nonneg fun v _ => pow_nonneg (apply_nonneg v y) _
  have hdn : 0 < (d : ℝ) ^ Module.finrank ℚ (fieldI F) := by positivity
  have hup : (d : ℝ) ^ Module.finrank ℚ (fieldI F) * ((∏ v : InfinitePlace (fieldI F), v y ^ v.mult) *
      ∏ w ∈ T, (WPlace.split w).absAt y) < 1 := by
    calc _ < (d : ℝ) ^ Module.finrank ℚ (fieldI F) * ((d : ℝ)⁻¹) ^ Module.finrank ℚ (fieldI F) :=
          mul_lt_mul_of_pos_left hlt hdn
      _ = 1 := by rw [← mul_pow, mul_inv_cancel₀ hdpos.ne', one_pow]
  have hlow : 1 ≤ (d : ℝ) ^ Module.finrank ℚ (fieldI F) * ((∏ v : InfinitePlace (fieldI F), v y ^ v.mult) *
      ∏ w ∈ T, (WPlace.split w).absAt y) := by
    calc (1 : ℝ) ≤ _ := hPF
      _ = (d : ℝ) ^ Module.finrank ℚ (fieldI F) * (∏ v : InfinitePlace (fieldI F), v y ^ v.mult) *
          ∏ w ∈ T, (WPlace.split w).absAt ((d : fieldI F) * y) := by rw [harch]
      _ ≤ (d : ℝ) ^ Module.finrank ℚ (fieldI F) * (∏ v : InfinitePlace (fieldI F), v y ^ v.mult) *
          ∏ w ∈ T, (WPlace.split w).absAt y := mul_le_mul_of_nonneg_left hsplit (mul_nonneg hdn.le hA)
      _ = _ := by ring
  linarith

/-- **Step 0, an expanding place** (X01D § 3.2): a unit vector that is not a root of unity has absolute value `> 1` at some
place of `W`. -/
theorem exists_one_lt_absAt (u : unitVectors F) (hu : ∀ n : ℕ, n ≠ 0 → (u : ℂ) ^ n ≠ 1) :
    ∃ p : WPlace F, 1 < p.absAt (unitL u) := by
  by_contra hcon
  push Not at hcon
  set x := unitL u with hxdef
  let σ := conjOn (fieldI_conj F)
  have hxσ : x * σ x = 1 := Subtype.ext (by
    show (u : ℂ) * (starRingEnd ℂ) (u : ℂ) = 1
    rw [Complex.mul_conj, Complex.normSq_eq_norm_sq, u.2.2]
    norm_num)
  -- integral at every prime: the stable ones (`R ⊆ O′`), the split ones (`hcon`)
  have hxO : x ∈ stableIntegers F := by
    rw [hxdef, unitL_eq_ofUnitRing]; exact ofUnitRing_mem_stableIntegers _
  have hval : ∀ v : HeightOneSpectrum (𝓞 (fieldI F)), v.valuation (fieldI F) x ≤ 1 := fun v => by
    by_cases hv : IsStablePlace F v
    · exact (mem_stableIntegers_iff_valuation F).1 hxO v hv
    · exact (norm_coe_le_one_iff v x).1 (hcon (.split ⟨v, hv⟩))
  obtain ⟨y, hy⟩ := mem_integers_of_valuation_le_one (fieldI F) x hval
  have hint : IsIntegral ℤ x := hy ▸ RingOfIntegers.isIntegral_coe y
  -- every archimedean `v x = 1`: `v x ≤ 1`, `v (σ x) = (v ∘ σ) x ≤ 1`, and `v x · v (σ x) = 1`
  have harch : ∀ v : InfinitePlace (fieldI F), v x = 1 := fun v => by
    have h1 : v x ≤ 1 := hcon (.arch v)
    have h2 : v (σ x) ≤ 1 := by
      rw [← InfinitePlace.comap_apply]; exact hcon (.arch (v.comap σ))
    have h3 : v x * v (σ x) = 1 := by rw [← map_mul, hxσ, map_one]
    refine le_antisymm h1 (not_lt.1 fun hlt => ?_)
    have : v x * v (σ x) < 1 :=
      lt_of_le_of_lt (mul_le_of_le_one_right (apply_nonneg v x) h2) hlt
    linarith
  have hnorm : ∀ φ : fieldI F →+* ℂ, ‖φ x‖ = 1 := fun φ => by
    rw [← InfinitePlace.apply]; exact harch _
  obtain ⟨n, hn, hxn⟩ := Embeddings.pow_eq_one_of_norm_eq_one (fieldI F) ℂ hint hnorm
  refine hu n hn.ne' ?_
  have := congrArg (fun z : fieldI F => (z : ℂ)) hxn
  simpa [hxdef, unitL] using this

/-- **The shells' multiplier** (X01D § 3.8, without the class group): at a split prime `w`, `g = γ/γ̄` for `γ ∈ 𝔓_w ∖ σ𝔓_w`
is a unit vector with `|g|_w < 1`. -/
theorem exists_unitVector_absAt_lt_one (w : SplitPlace F) :
    ∃ g : unitVectors F, (WPlace.split w).absAt (unitL g) < 1 := by
  -- `𝔓_w` and `σ⁻¹𝔓_w` are distinct maximal ideals, so `𝔓_w ⊄ σ⁻¹𝔓_w`: some `γ ∈ 𝔓_w` has `σγ ∉ 𝔓_w`
  have hne : ¬ w.1.asIdeal ≤ w.1.asIdeal.comap (conjO F) := fun hle =>
    w.2 (w.1.isMaximal.eq_of_le (Ideal.comap_ne_top _ w.1.isMaximal.ne_top) hle).symm
  obtain ⟨γ, hγ, hσγ⟩ := SetLike.not_le_iff_exists.1 hne
  have hσγ' : conjO F γ ∉ w.1.asIdeal := hσγ
  have hγne : γ ≠ 0 := by
    rintro rfl
    exact hσγ' (by rw [map_zero]; exact zero_mem _)
  have hγL : (γ : fieldI F) ≠ 0 := RingOfIntegers.coe_ne_zero_iff.2 hγne
  have hγC : ((γ : fieldI F) : ℂ) ≠ 0 := fun h => hγL (Subtype.ext h)
  let g : fieldI F := (γ : fieldI F) / ((conjO F γ : 𝓞 (fieldI F)) : fieldI F)
  have hgC : ((g : fieldI F) : ℂ) = ((γ : fieldI F) : ℂ) / (starRingEnd ℂ) ((γ : fieldI F) : ℂ) := by
    show (((γ : fieldI F) / ((conjO F γ : 𝓞 (fieldI F)) : fieldI F) : fieldI F) : ℂ) = _
    rw [Subfield.coe_div, UpperHalf.coe_conjO, coe_conjOn]
  have hg : (g : ℂ) ∈ unitVectors F := ⟨g.2, by
    rw [hgC, norm_div, Complex.norm_conj, div_self (norm_ne_zero_iff.2 hγC)]⟩
  refine ⟨⟨g, hg⟩, ?_⟩
  show ‖((g : fieldI F) : w.1.adicCompletion (fieldI F))‖ < 1
  have hdiv : ((g : fieldI F) : w.1.adicCompletion (fieldI F)) =
      ((γ : fieldI F) : w.1.adicCompletion (fieldI F)) /
        (((conjO F γ : 𝓞 (fieldI F)) : fieldI F) : w.1.adicCompletion (fieldI F)) :=
    map_div₀ (algebraMap (fieldI F) (w.1.adicCompletion (fieldI F))) _ _
  have h1 : ‖((γ : fieldI F) : w.1.adicCompletion (fieldI F))‖ < 1 :=
    (FinitePlace.norm_lt_one_iff_mem (fieldI F) w.1 γ).2 hγ
  have h2 : ‖(((conjO F γ : 𝓞 (fieldI F)) : fieldI F) : w.1.adicCompletion (fieldI F))‖ = 1 :=
    (FinitePlace.norm_eq_one_iff_notMem (fieldI F) w.1 _).2 hσγ'
  rw [hdiv, norm_div, h2, div_one]
  exact h1

/-- `L` is countable: finite-dimensional over `ℚ`. -/
theorem countable_fieldI : Countable (fieldI F) :=
  Finsupp.Countable.of_moduleFinite (R := ℚ)

/-- **The split primes are countable**: the ideals of `𝓞 L` of each norm are finitely many (`Ideal.finite_setOf_absNorm_eq`). -/
instance countable_splitPlace : Countable (SplitPlace F) := by
  have hU : (⋃ n : ℕ, {I : Ideal (𝓞 (fieldI F)) | Ideal.absNorm I = n}) = Set.univ :=
    Set.iUnion_eq_univ_iff.2 fun I => ⟨Ideal.absNorm I, rfl⟩
  have hc : (Set.univ : Set (Ideal (𝓞 (fieldI F)))).Countable := by
    rw [← hU]
    exact Set.countable_iUnion fun n => (Ideal.finite_setOf_absNorm_eq n).countable
  haveI : Countable (Ideal (𝓞 (fieldI F))) := Set.countable_univ_iff.1 hc
  exact Function.Injective.countable (f := fun w : SplitPlace F => w.1.asIdeal)
    fun a b h => Subtype.ext (HeightOneSpectrum.ext h)

end

end HadwigerNelson.Rigidity
