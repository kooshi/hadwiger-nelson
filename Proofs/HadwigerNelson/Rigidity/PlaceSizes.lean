import Proofs.HadwigerNelson.Rigidity.TateCharacter
import Mathlib.NumberTheory.NumberField.ProductFormula
import Mathlib.NumberTheory.NumberField.InfinitePlace.Embeddings

/-!
# The places of `W`, their sizes, and the product-formula gap (FS-131, job FS131-K8B1; module M8b-2a; skeleton)

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

/-- The size of a diagonal point is the absolute value. -/
theorem size_toSAdele (p : WPlace F) (x : fieldI F) : p.size (toSAdele F x) = p.absAt x := by
  sorry

/-- **Sizes are multiplicative along the diagonal**: `|ι(x)·a|_p = |x|_p·|a|_p`. -/
theorem size_toSAdele_mul (p : WPlace F) (x : fieldI F) (a : SAdeleRing F) :
    p.size (toSAdele F x * a) = p.absAt x * p.size a := by
  sorry

/-- The triangle inequality at every place. -/
theorem size_add_le (p : WPlace F) (a b : SAdeleRing F) : p.size (a + b) ≤ p.size a + p.size b := by
  sorry

/-- **The ultrametric inequality at a split prime.** -/
theorem size_add_le_max (w : SplitPlace F) (a b : SAdeleRing F) :
    (WPlace.split w).size (a + b) ≤ max ((WPlace.split w).size a) ((WPlace.split w).size b) := by
  sorry

theorem size_neg (p : WPlace F) (a : SAdeleRing F) : p.size (-a) = p.size a := by
  sorry

theorem size_nonneg (p : WPlace F) (a : SAdeleRing F) : 0 ≤ p.size a := by
  sorry

theorem continuous_size (p : WPlace F) : Continuous p.size := by
  sorry

theorem absAt_mul (p : WPlace F) (x y : fieldI F) : p.absAt (x * y) = p.absAt x * p.absAt y := by
  sorry

theorem absAt_nonneg (p : WPlace F) (x : fieldI F) : 0 ≤ p.absAt x := by
  sorry

theorem absAt_eq_zero (p : WPlace F) {x : fieldI F} : p.absAt x = 0 ↔ x = 0 := by
  sorry

/-- An integer has absolute value at most `1` at a split prime. -/
theorem absAt_natCast_le_one (w : SplitPlace F) (n : ℕ) : (WPlace.split w).absAt (n : fieldI F) ≤ 1 := by
  sorry

/-- A point of the split box (integral at `w`) has size at most `1` there. -/
theorem size_le_one_iff (w : SplitPlace F) (a : SAdeleRing F) :
    (WPlace.split w).size a ≤ 1 ↔ a.2 w ∈ w.1.adicCompletionIntegers (fieldI F) := by
  sorry

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
  sorry

/-- The split height is the finite product over any finite set outside which `x` is integral. -/
theorem splitHeight_eq_prod (x : fieldI F) (T : Finset (SplitPlace F))
    (hT : ∀ w ∉ T, (WPlace.split w).absAt x ≤ 1) :
    splitHeight x = ∏ w ∈ T, max 1 ((WPlace.split w).absAt x) := by
  sorry

theorem one_le_splitHeight (x : fieldI F) : 1 ≤ splitHeight x := by
  sorry

theorem absAt_le_splitHeight (w : SplitPlace F) (x : fieldI F) : (WPlace.split w).absAt x ≤ splitHeight x := by
  sorry

/-- **Lemma PF for `O′`** (X01D l. 208, "for `y ∈ R ∖ {0}` the bound is `≥ 1`", read for `O′ ⊇ R`): the product formula,
with every stable factor at most `1`. -/
theorem one_le_prod_absAt_of_mem_stableIntegers {x : fieldI F} (hx : x ∈ stableIntegers F) (hx0 : x ≠ 0)
    (T : Finset (SplitPlace F)) (hT : ∀ w ∉ T, (WPlace.split w).absAt x ≤ 1) :
    1 ≤ (∏ v : InfinitePlace (fieldI F), v x ^ v.mult) * ∏ w ∈ T, (WPlace.split w).absAt x := by
  sorry

/-- The ring `R` lies in `O′`, read through `ofUnitRing` (`unitRing_le_stableIntegers`). -/
theorem ofUnitRing_mem_stableIntegers (r : unitRing F) : ofUnitRing F r ∈ stableIntegers F := by
  sorry

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
  sorry

/-- **Step 0, an expanding place** (X01D § 3.2): a unit vector that is not a root of unity has absolute value `> 1` at some
place of `W`. -/
theorem exists_one_lt_absAt (u : unitVectors F) (hu : ∀ n : ℕ, n ≠ 0 → (u : ℂ) ^ n ≠ 1) :
    ∃ p : WPlace F, 1 < p.absAt (unitL u) := by
  sorry

/-- **The shells' multiplier** (X01D § 3.8, without the class group): at a split prime `w`, `g = γ/γ̄` for `γ ∈ 𝔓_w ∖ σ𝔓_w`
is a unit vector with `|g|_w < 1`. -/
theorem exists_unitVector_absAt_lt_one (w : SplitPlace F) :
    ∃ g : unitVectors F, (WPlace.split w).absAt (unitL g) < 1 := by
  sorry

/-- `L` is countable: finite-dimensional over `ℚ`. -/
theorem countable_fieldI : Countable (fieldI F) := by
  sorry

/-- **The split primes are countable**: the ideals of `𝓞 L` of each norm are finitely many (`Ideal.finite_setOf_absNorm_eq`). -/
instance countable_splitPlace : Countable (SplitPlace F) := by
  sorry

end

end HadwigerNelson.Rigidity
