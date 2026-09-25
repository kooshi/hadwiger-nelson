import Proofs.HadwigerNelson.SquareClass
import Proofs.HadwigerNelson.ResidueColouring
import Proofs.HadwigerNelson.ResidueTower
import Mathlib.FieldTheory.RatFunc.AsPolynomial
import Mathlib.Algebra.Ring.IsFormallyReal
import Mathlib.FieldTheory.PrimeField
import Mathlib.NumberTheory.Transcendental.Liouville.LiouvilleNumber

/-!
# Transcendence is free: `χ(F(t)²) = χ(F²)` (FS-39 route C; `[Fischer1990]` Theorem 6)

Adjoining a transcendental to a real field never changes the chromatic number of its plane. The kernel form here is
about rational functions, not about `ℝ`: for every **formally real** field `F`,

    χ(unitQuadrance (RatFunc F)) = χ(unitQuadrance F).

**The mechanism** is a place of `F(t)` with residue field `F`, the place `t = 0`, and one valuation lemma. A unit vector
`a² + b² = 1` cannot have a pole at a place whose residue ring has no square root of `−1`: if `a` had the larger pole,
`1 + (b/a)² = a⁻²` would lie in the maximal ideal, so `−1 = (b/a)²` in the residue ring. So every unit vector's
coordinates lie in the valuation subring `B`, the plane splits into cosets of `B × B` with no unit edge between cosets,
and reduction `B → F` on each coset (`cosetResidue`) carries a colouring of `F²` back to one of `F(t)²`.

**Prior art.** The statement and its proof ("Setting x = 0 …") are `[Fischer1990]` Theorem 6 (Discrete Math. 81,
p. 188): *"Let α be a real number transcendental over the field F ⊂ ℝ. Then F^d can be k-colored (has an additive
k-coloring) iff F(α)^d can be k-colored"*. The valuation form of the integrality step is `[Madore2015]` Prop. 3.2's
mechanism. What is ours is the kernel form, stated for any formally real `F`, and the valuation lemma stated for any
valuation subring whose residue ring has no square root of `−1` (it covers Theorem A's residue fields `𝔽_q`,
`q ≡ 3 (mod 4)`, and the degree-one places of `plans/M2-S1D-bridge.md` C3′ alike).

**What this does not prove.** Nothing here reaches a finitely generated real field that is not purely transcendental
over a number field (`plans/M2-S1D-bridge.md` §2.3: `[Fischer1990]` Remark 1's first sentence is false), and nothing
here says `χ(ℚ²) = 2`: the inhabitant below is the equality with `χ(ℚ²)`, whatever that value is in the kernel.

## What is here

* `planeOverIso` — the plane over `L ⊆ ℝ` is `unitQuadrance L`, as graphs.
* `unitQuadrance_colorable_of_subring` — colourability pulls back through any subring holding every unit vector's
  coordinates, along any ring hom out of it (the coset step, by `cosetResidue`).
* `mem_valuationSubring_of_sq_add_sq_eq_one` — the valuation lemma.
* `unitQuadrance_colorable_of_valuationSubring` — the two composed: a residue hom killing the maximal ideal into a ring
  with no square root of `−1` pulls colourings back.
* `zeroPlace`, `evalZero` — the place `t = 0` of `RatFunc F` and evaluation there.
* `chromaticNumber_unitQuadrance_ratFunc_of_one_add_sq_ne_zero` — the engine: any field in which `−1` is not a square.
* `chromaticNumber_unitQuadrance_ratFunc` — **the theorem**, for formally real `F`; inhabitant `F = ℚ`.
* `adjoinTranscendental F t` — `F(t) ⊆ ℝ`, and `adjoinTranscendentalEquiv`, its identification with `RatFunc F` when `t` is
  transcendental over `F` (Mathlib's `RatFunc.algEquivOfTranscendental`).
* `chromaticNumber_planeOver_adjoin_transcendental_eq` — the theorem over `ℝ`: `χ(F(t)²) = χ(F²)`; inhabitant
  `chromaticNumber_planeOver_liouville` (`F = ℚ`, `t` Liouville's constant).
-/

set_option autoImplicit false

namespace HadwigerNelson
namespace RouteC

open SimpleGraph Polynomial

/-! ### The plane over a real field, in coordinates -/

/-- The plane over `L ⊆ ℝ` is the unit-quadrance graph of `L`, vertex by vertex. -/
noncomputable def planeOverEquiv (L : Subfield ℝ) : planeOver L ≃ L × L where
  toFun z := (⟨(z : ℂ).re, z.2.1⟩, ⟨(z : ℂ).im, z.2.2⟩)
  invFun p := ⟨⟨p.1, p.2⟩, p.1.2, p.2.2⟩
  left_inv _ := rfl
  right_inv _ := rfl

/-- Unit distance in `ℂ` is unit quadrance of the coordinates. -/
theorem dist_eq_one_iff_quadrance (z w : ℂ) :
    dist z w = 1 ↔ (z.re - w.re) ^ 2 + (z.im - w.im) ^ 2 = 1 := by
  rw [Complex.dist_eq, Complex.norm_def, Real.sqrt_eq_one, Complex.normSq_apply]
  simp only [Complex.sub_re, Complex.sub_im]
  constructor <;> intro h <;> linarith [h]

/-- **The plane over `L` is `unitQuadrance L`** as graphs. -/
noncomputable def planeOverIso (L : Subfield ℝ) :
    (unitDistance ℂ).induce (planeOver L) ≃g unitQuadrance L where
  toEquiv := planeOverEquiv L
  map_rel_iff' {z w} := by
    rw [unitQuadrance_adj_iff_quadrance]
    simp only [SimpleGraph.comap_adj, Function.Embedding.coe_subtype, unitDistance_adj,
      dist_eq_one_iff_quadrance, planeOverEquiv, Equiv.coe_fn_mk]
    constructor
    · intro h
      have := congrArg (fun x : L => (x : ℝ)) h
      simpa using this
    · intro h
      apply Subtype.ext
      simpa using h

/-- Isomorphic graphs have one chromatic number. Inhabited by `planeOverIso`. -/
theorem chromaticNumber_eq_of_iso {V W : Type*} {G : SimpleGraph V} {H : SimpleGraph W} (e : G ≃g H) :
    G.chromaticNumber = H.chromaticNumber :=
  le_antisymm (chromaticNumber_le_of_forall_imp fun _ h => h.of_hom e.toHom)
    (chromaticNumber_le_of_forall_imp fun _ h => h.of_hom e.symm.toHom)

/-- The chromatic number of the plane over `L ⊆ ℝ` is that of `unitQuadrance L`. -/
theorem chromaticNumber_planeOver_eq (L : Subfield ℝ) :
    ((unitDistance ℂ).induce (planeOver L)).chromaticNumber = (unitQuadrance L).chromaticNumber :=
  chromaticNumber_eq_of_iso (planeOverIso L)

/-! ### The coset step -/

/-- **Colourability pulls back through a subring that holds every unit vector.** The plane over `R` splits into cosets
of `A × A` with no edge between cosets (edge differences are unit vectors, in `A × A`); on each coset `cosetResidue`
of `φ × φ` is additive, so a unit edge maps to a unit edge of `S²`. Fischer's evaluation at `0` is `φ`. Inhabited in this
file at `A = zeroPlace ℚ`, `φ = evalZero ℚ` (through `chromaticNumber_unitQuadrance_ratFunc_rat`). -/
theorem unitQuadrance_colorable_of_subring {R S : Type*} [CommRing R] [CommRing S] [Nontrivial S]
    (A : Subring R) (hA : ∀ v : R × R, v.1 ^ 2 + v.2 ^ 2 = 1 → v.1 ∈ A ∧ v.2 ∈ A)
    (φ : A →+* S) {k : ℕ} (h : (unitQuadrance S).Colorable k) : (unitQuadrance R).Colorable k := by
  obtain ⟨C⟩ := h
  let P : AddSubgroup (R × R) := A.toAddSubgroup.prod A.toAddSubgroup
  let ψ : P →+ S × S :=
    { toFun := fun v => (φ ⟨v.1.1, v.2.1⟩, φ ⟨v.1.2, v.2.2⟩)
      map_zero' := by ext <;> simp <;> exact map_zero φ
      map_add' := fun v w => by
        ext
        · exact map_add φ ⟨v.1.1, v.2.1⟩ ⟨w.1.1, w.2.1⟩
        · exact map_add φ ⟨v.1.2, v.2.2⟩ ⟨w.1.2, w.2.2⟩ }
  refine ⟨Coloring.mk (fun z => C (cosetResidue ψ z)) fun {u v} huv => ?_⟩
  rw [unitQuadrance_adj] at huv
  obtain ⟨-, hq⟩ := huv
  have hmem : u - v ∈ P := hA (u - v) (by simpa using hq)
  apply C.valid
  rw [unitQuadrance_adj_iff_quadrance]
  have hsub := cosetResidue_sub ψ hmem
  rw [cosetResidue_apply_of_mem ψ hmem] at hsub
  have h1 : (cosetResidue ψ u).1 - (cosetResidue ψ v).1 = φ ⟨(u - v).1, hmem.1⟩ :=
    congrArg Prod.fst hsub
  have h2 : (cosetResidue ψ u).2 - (cosetResidue ψ v).2 = φ ⟨(u - v).2, hmem.2⟩ :=
    congrArg Prod.snd hsub
  rw [h1, h2, ← map_pow, ← map_pow, ← map_add]
  have : (⟨(u - v).1, hmem.1⟩ : A) ^ 2 + ⟨(u - v).2, hmem.2⟩ ^ 2 = 1 :=
    Subtype.ext (by simpa using hq)
  rw [this, map_one]

/-! ### The valuation lemma -/

/-- **Unit vectors are integral at a place whose residue ring has no square root of `−1`.** If `1 + x²` is a unit of
the valuation subring `B` for every `x ∈ B`, then `a² + b² = 1` forces `a, b ∈ B`: were `a` the coordinate with the
larger pole, `b/a ∈ B` and `1 + (b/a)² = a⁻²` would be a non-unit. Inhabited in this file at `B = zeroPlace ℚ`. -/
theorem mem_valuationSubring_of_sq_add_sq_eq_one {K : Type*} [Field K] (B : ValuationSubring K)
    (hB : ∀ x ∈ B, 1 + x ^ 2 ∉ B.nonunits) {a b : K} (h : a ^ 2 + b ^ 2 = 1) : a ∈ B ∧ b ∈ B := by
  have key : ∀ {a b : K}, a ^ 2 + b ^ 2 = 1 → B.valuation b ≤ B.valuation a → a ∈ B := by
    intro a b h hba
    by_contra ha
    have hv : 1 < B.valuation a := by
      rw [← B.valuation_le_one_iff] at ha
      exact not_le.mp ha
    have ha0 : a ≠ 0 := by
      rintro rfl
      simp at hv
    have hw : b / a ∈ B := by
      rw [← B.valuation_le_one_iff, map_div₀]
      exact div_le_one_of_le₀ hba zero_le
    apply hB _ hw
    rw [B.mem_nonunits_iff]
    have : 1 + (b / a) ^ 2 = a⁻¹ ^ 2 := by
      field_simp
      linear_combination h
    rw [this, map_pow, map_inv₀]
    exact pow_lt_one₀ zero_le (inv_lt_one_of_one_lt₀ hv) two_ne_zero
  rcases le_total (B.valuation b) (B.valuation a) with hba | hab
  · have ha := key h hba
    exact ⟨ha, (B.valuation_le_one_iff _).mp (hba.trans ((B.valuation_le_one_iff _).mpr ha))⟩
  · have hb := key (by linear_combination h) hab
    exact ⟨(B.valuation_le_one_iff _).mp (hab.trans ((B.valuation_le_one_iff _).mpr hb)), hb⟩

/-- In a nontrivial formally real ring `−1` is not a square: `1 + s² ≠ 0`. -/
theorem one_add_sq_ne_zero {S : Type*} [CommRing S] [Nontrivial S] [IsFormallyReal S] (s : S) :
    1 + s ^ 2 ≠ 0 := fun h =>
  one_ne_zero (IsFormallyReal.eq_zero_of_add_right IsSumSq.one (by simp [sq]) h)

/-- **Colourings pull back through a place whose residue ring has no square root of `−1`.** A ring hom `φ` out of a
valuation subring `B` of `K` that kills its maximal ideal, into a ring `S` in which `1 + s² ≠ 0`: every unit vector of
`K²` lies in `B²` (the valuation lemma), so the coset step carries every colouring of `S²` to `K²`. Inhabited in this file
at `B = zeroPlace ℚ`, `φ = evalZero ℚ`, `S = ℚ`. -/
theorem unitQuadrance_colorable_of_valuationSubring {K S : Type*} [Field K] [CommRing S] [Nontrivial S]
    (B : ValuationSubring K) (φ : B →+* S) (hφ : ∀ x ∈ IsLocalRing.maximalIdeal B, φ x = 0)
    (hS : ∀ s : S, 1 + s ^ 2 ≠ 0) {k : ℕ} (h : (unitQuadrance S).Colorable k) :
    (unitQuadrance K).Colorable k := by
  have hB : ∀ x ∈ B, 1 + x ^ 2 ∉ B.nonunits := by
    intro x hx hn
    have hmem : (1 + x ^ 2 : K) ∈ B := add_mem (one_mem B) (pow_mem hx 2)
    have hmax : (⟨1 + x ^ 2, hmem⟩ : B) ∈ IsLocalRing.maximalIdeal B :=
      (B.valuation_lt_one_iff _).mpr (B.mem_nonunits_iff.mp hn)
    have h0 := hφ _ hmax
    have heq : (⟨1 + x ^ 2, hmem⟩ : B) = 1 + (⟨x, hx⟩ : B) ^ 2 := rfl
    rw [heq, map_add, map_one, map_pow] at h0
    exact hS _ h0
  exact unitQuadrance_colorable_of_subring B.toSubring
    (fun v hv => mem_valuationSubring_of_sq_add_sq_eq_one B hB hv) φ h

/-! ### The place `t = 0` of `RatFunc F` -/

section AtZero

variable (F : Type*) [Field F]

/-- A divisor of a polynomial that does not vanish at `0` does not vanish at `0`. -/
theorem eval_zero_ne_zero_of_dvd {F : Type*} [Field F] {p q : F[X]} (h : p ∣ q) (hq : q.eval 0 ≠ 0) :
    p.eval 0 ≠ 0 :=
  fun hp => hq (Polynomial.eval₂_eq_zero_of_dvd_of_eval₂_eq_zero _ _ h hp)

/-- The rational functions with no pole at `0`: reduced denominator nonzero at `0`. -/
noncomputable def zeroIntegral : Subring (RatFunc F) where
  carrier := {f | (RatFunc.denom f).eval 0 ≠ 0}
  zero_mem' := by simp [RatFunc.denom_zero]
  one_mem' := by simp [RatFunc.denom_one]
  add_mem' {x y} hx hy := eval_zero_ne_zero_of_dvd (RatFunc.denom_add_dvd x y)
    (by rw [Polynomial.eval_mul]; exact mul_ne_zero hx hy)
  mul_mem' {x y} hx hy := eval_zero_ne_zero_of_dvd (RatFunc.denom_mul_dvd x y)
    (by rw [Polynomial.eval_mul]; exact mul_ne_zero hx hy)
  neg_mem' {x} hx := by
    have h1 : (RatFunc.denom (-1 : RatFunc F)).eval 0 ≠ 0 := by
      rw [show (-1 : RatFunc F) = algebraMap F[X] _ (-1) by simp, RatFunc.denom_algebraMap]
      simp
    have := eval_zero_ne_zero_of_dvd (RatFunc.denom_mul_dvd (-1) x)
      (by rw [Polynomial.eval_mul]; exact mul_ne_zero h1 hx)
    simpa using this

/-- Membership in `zeroIntegral F` is the defining condition on the reduced denominator. -/
theorem mem_zeroIntegral {f : RatFunc F} : f ∈ zeroIntegral F ↔ (RatFunc.denom f).eval 0 ≠ 0 := Iff.rfl

/-- Polynomials have no pole. -/
theorem algebraMap_mem_zeroIntegral (p : F[X]) : algebraMap F[X] (RatFunc F) p ∈ zeroIntegral F := by
  simp [mem_zeroIntegral, RatFunc.denom_algebraMap]

/-- The inverse of a polynomial not vanishing at `0` has no pole at `0`. -/
theorem inv_algebraMap_mem_zeroIntegral {p : F[X]} (hp : p.eval 0 ≠ 0) :
    (algebraMap F[X] (RatFunc F) p)⁻¹ ∈ zeroIntegral F := by
  have : (algebraMap F[X] (RatFunc F) p)⁻¹ = algebraMap F[X] _ 1 / algebraMap F[X] _ p := by simp
  rw [mem_zeroIntegral, this]
  exact eval_zero_ne_zero_of_dvd (RatFunc.denom_div_dvd 1 p) hp

/-- **The inverse lemma.** A rational function with a pole at `0` has an inverse with no pole there, and that inverse
vanishes at `0`: `X` divides the reduced denominator, so not the numerator, and `f⁻¹ = denom f · (num f)⁻¹`. -/
theorem inv_mem_zeroIntegral_of_not_mem {f : RatFunc F} (hf : f ∉ zeroIntegral F) :
    ∃ _ : f⁻¹ ∈ zeroIntegral F, RatFunc.eval (RingHom.id F) 0 f⁻¹ = 0 := by
  rw [mem_zeroIntegral, not_not] at hf
  have hnum : (RatFunc.num f).eval 0 ≠ 0 := by
    intro hn
    have hX : IsUnit (X : F[X]) := (RatFunc.isCoprime_num_denom f).isUnit_of_dvd'
      (X_dvd_iff.mpr (by rw [coeff_zero_eq_eval_zero]; exact hn))
      (X_dvd_iff.mpr (by rw [coeff_zero_eq_eval_zero]; exact hf))
    exact not_isUnit_X hX
  have hinv : f⁻¹ = algebraMap F[X] (RatFunc F) (RatFunc.denom f) *
      (algebraMap F[X] (RatFunc F) (RatFunc.num f))⁻¹ := by
    conv_lhs => rw [← RatFunc.num_div_denom f]
    rw [inv_div, div_eq_mul_inv]
  have hmem₁ := algebraMap_mem_zeroIntegral F (RatFunc.denom f)
  have hmem₂ := inv_algebraMap_mem_zeroIntegral F hnum
  refine ⟨hinv ▸ (zeroIntegral F).mul_mem hmem₁ hmem₂, ?_⟩
  rw [hinv, RatFunc.eval_mul _ _ hmem₁ hmem₂, RatFunc.eval_algebraMap]
  simp only [Algebra.algebraMap_self, RingHom.id_apply]
  rw [show Polynomial.eval₂ (RingHom.id F) 0 (RatFunc.denom f) = (RatFunc.denom f).eval 0 from rfl, hf,
    zero_mul]

/-- **The place `t = 0`**: the rational functions with no pole at `0`, a valuation subring of `RatFunc F` (every `f`
or its inverse has no pole, by the inverse lemma). -/
noncomputable def zeroPlace : ValuationSubring (RatFunc F) :=
  { zeroIntegral F with
    mem_or_inv_mem' := fun f =>
      (em (f ∈ zeroIntegral F)).imp id fun h => (inv_mem_zeroIntegral_of_not_mem F h).1 }

/-- Membership in `zeroPlace F` is the defining condition on the reduced denominator. -/
theorem mem_zeroPlace {f : RatFunc F} : f ∈ zeroPlace F ↔ (RatFunc.denom f).eval 0 ≠ 0 := Iff.rfl

/-- **Evaluation at `t = 0`**, the residue map of `zeroPlace F`: a ring hom onto `F` (`RatFunc.eval_add` and
`RatFunc.eval_mul` hold exactly where both denominators survive at `0`, which is membership). -/
noncomputable def evalZero : zeroPlace F →+* F where
  toFun f := RatFunc.eval (RingHom.id F) 0 f
  map_one' := by simp
  map_zero' := by simp
  map_add' x y := RatFunc.eval_add _ _ x.2 y.2
  map_mul' x y := RatFunc.eval_mul _ _ x.2 y.2

/-- `evalZero F` is `RatFunc.eval` at `0`. -/
theorem evalZero_apply (f : zeroPlace F) : evalZero F f = RatFunc.eval (RingHom.id F) 0 (f : RatFunc F) := rfl

/-- **The residue map kills the maximal ideal**: a non-unit of `zeroPlace F` is `0` or the inverse of a function with a
pole at `0`, and the inverse lemma says that inverse vanishes there. -/
theorem evalZero_eq_zero_of_mem_maximalIdeal (x : zeroPlace F) (hx : x ∈ IsLocalRing.maximalIdeal (zeroPlace F)) :
    evalZero F x = 0 := by
  by_cases hx0 : (x : RatFunc F) = 0
  · rw [evalZero_apply, hx0, RatFunc.eval_zero]
  have hinv : (x : RatFunc F)⁻¹ ∉ zeroIntegral F := by
    intro hmem
    apply (IsLocalRing.mem_maximalIdeal _).mp hx
    exact IsUnit.of_mul_eq_one ⟨_, hmem⟩ (Subtype.ext (mul_inv_cancel₀ hx0))
  obtain ⟨-, h0⟩ := inv_mem_zeroIntegral_of_not_mem F hinv
  rw [inv_inv] at h0
  exact h0

end AtZero

/-! ### The theorem -/

/-- **The engine, at its proof's level**: for every field `F` in which `−1` is not a square, `χ(F(t)²) = χ(F²)`. Formal
reality is one way to supply the hypothesis (`chromaticNumber_unitQuadrance_ratFunc`, inhabited at `ℚ`); a finite field
`𝔽_q` with `q ≡ 3 (mod 4)` is another, not instantiated here. -/
theorem chromaticNumber_unitQuadrance_ratFunc_of_one_add_sq_ne_zero {F : Type*} [Field F]
    (hF : ∀ s : F, 1 + s ^ 2 ≠ 0) :
    (unitQuadrance (RatFunc F)).chromaticNumber = (unitQuadrance F).chromaticNumber :=
  le_antisymm
    (chromaticNumber_le_of_forall_imp fun _ hk =>
      unitQuadrance_colorable_of_valuationSubring (zeroPlace F) (evalZero F)
        (evalZero_eq_zero_of_mem_maximalIdeal F) hF hk)
    (chromaticNumber_le_of_forall_imp fun _ hk =>
      unitQuadrance_colorable_of_ringHom (algebraMap F (RatFunc F)) hk)

/-- **Transcendence is free** (`[Fischer1990]` Theorem 6; `CLAUDE.md` G63): for every formally real field `F`, the plane
over the rational function field `F(t)` needs exactly as many colours as the plane over `F`. `≥`: `F ⊆ F(t)`. `≤`: the
place `t = 0` has residue field `F`, in which `−1` is not a square. -/
theorem chromaticNumber_unitQuadrance_ratFunc {F : Type*} [Field F] [IsFormallyReal F] :
    (unitQuadrance (RatFunc F)).chromaticNumber = (unitQuadrance F).chromaticNumber :=
  chromaticNumber_unitQuadrance_ratFunc_of_one_add_sq_ne_zero one_add_sq_ne_zero

/-- The inhabitant of `chromaticNumber_unitQuadrance_ratFunc`'s hypotheses: `F = ℚ`, formally real by its order.
`χ(ℚ(t)²) = χ(ℚ²)`. -/
theorem chromaticNumber_unitQuadrance_ratFunc_rat :
    (unitQuadrance (RatFunc ℚ)).chromaticNumber = (unitQuadrance ℚ).chromaticNumber :=
  chromaticNumber_unitQuadrance_ratFunc

/-! ### The plane over `F(t) ⊆ ℝ` -/

/-- A ring isomorphism is a graph isomorphism of unit-quadrance graphs, so it keeps the chromatic number. Inhabited by
`adjoinTranscendentalEquiv` at Liouville's constant (`chromaticNumber_planeOver_liouville`). -/
theorem chromaticNumber_unitQuadrance_eq_of_ringEquiv {R S : Type*} [CommRing R] [CommRing S] [Nontrivial R]
    [Nontrivial S] (e : R ≃+* S) : (unitQuadrance R).chromaticNumber = (unitQuadrance S).chromaticNumber :=
  le_antisymm
    (chromaticNumber_le_of_forall_imp fun _ hk => unitQuadrance_colorable_of_ringHom e.toRingHom hk)
    (chromaticNumber_le_of_forall_imp fun _ hk => unitQuadrance_colorable_of_ringHom e.symm.toRingHom hk)

/-- A subfield of `ℝ` has no square root of `−1`. (Mathlib holds no `IsFormallyReal` instance on `↥F` for `F : Subfield ℝ`;
the engine's hypothesis is the one fact used.) -/
theorem one_add_sq_ne_zero_of_subfield (F : Subfield ℝ) (s : F) : 1 + s ^ 2 ≠ 0 := fun h => by
  have h' : (1 : ℝ) + (s : ℝ) ^ 2 = 0 := by exact_mod_cast congrArg ((↑) : F → ℝ) h
  nlinarith [sq_nonneg (s : ℝ)]

/-- **`F(t)` inside `ℝ`**: the subfield generated by `F` and `t`, as `IntermediateField.adjoin`. No transcendence is
assumed here; the theorems that need it take it as a hypothesis. -/
noncomputable def adjoinTranscendental (F : Subfield ℝ) (t : ℝ) : Subfield ℝ :=
  (IntermediateField.adjoin F {t}).toSubfield

/-- `F ≤ F(t)`. -/
theorem le_adjoinTranscendental (F : Subfield ℝ) (t : ℝ) : F ≤ adjoinTranscendental F t := fun x hx =>
  (IntermediateField.adjoin F {t}).algebraMap_mem ⟨x, hx⟩

/-- `t ∈ F(t)`. -/
theorem mem_adjoinTranscendental_self (F : Subfield ℝ) (t : ℝ) : t ∈ adjoinTranscendental F t :=
  IntermediateField.mem_adjoin_simple_self F t

/-- **The lift equivalence**: for `t` transcendental over `F`, `F(t) ⊆ ℝ` is the rational function field over `F`
(Mathlib's `RatFunc.algEquivOfTranscendental`). -/
noncomputable def adjoinTranscendentalEquiv (F : Subfield ℝ) {t : ℝ} (ht : Transcendental F t) :
    adjoinTranscendental F t ≃+* RatFunc F :=
  (RatFunc.algEquivOfTranscendental t ht).symm.toRingEquiv

/-- **Transcendence is free, over `ℝ`** (`[Fischer1990]` Theorem 6 at `d = 2`; `CLAUDE.md` G63; FS-39 route C): for a
subfield `F ⊆ ℝ` and `t ∈ ℝ` transcendental over `F`, the plane over `F(t)` needs exactly as many colours as the
plane over `F`. -/
theorem chromaticNumber_planeOver_adjoin_transcendental_eq (F : Subfield ℝ) {t : ℝ} (ht : Transcendental F t) :
    ((unitDistance ℂ).induce (planeOver (adjoinTranscendental F t))).chromaticNumber =
      ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  rw [chromaticNumber_planeOver_eq, chromaticNumber_planeOver_eq,
    chromaticNumber_unitQuadrance_eq_of_ringEquiv (adjoinTranscendentalEquiv F ht),
    chromaticNumber_unitQuadrance_ratFunc_of_one_add_sq_ne_zero (one_add_sq_ne_zero_of_subfield F)]

/-- Liouville's constant is transcendental over `ℚ = ⊥`, the prime subfield of `ℝ` (from Mathlib's transcendence over
`ℤ`; π's transcendence is not in Mathlib). -/
theorem transcendental_liouvilleNumber_bot : Transcendental (⊥ : Subfield ℝ) (liouvilleNumber 10) := by
  have hZ : Transcendental ℤ (liouvilleNumber 10) := transcendental_liouvilleNumber (by norm_num)
  have hQ : Transcendental ℚ (liouvilleNumber 10) := by
    haveI : Algebra.IsAlgebraic ℤ ℚ := IsLocalization.isAlgebraic ℚ (nonZeroDivisors ℤ)
    exact (Algebra.IsAlgebraic.transcendental_iff ℤ ℚ).mp hZ
  refine hQ.ringHom_of_comp_eq (algebraMap ℚ (⊥ : Subfield ℝ)) (RingHom.id ℝ) ?_ Function.injective_id ?_
  · rintro ⟨y, hy⟩
    rw [Subfield.bot_eq_of_charZero] at hy
    obtain ⟨q, rfl⟩ := hy
    exact ⟨q, Subtype.ext (by simp)⟩
  · ext q
    simp

/-- **The inhabitant**: `χ(ℚ(L)²) = χ(ℚ²)`, `L` Liouville's constant `∑ 10^(−n!)`. -/
theorem chromaticNumber_planeOver_liouville :
    ((unitDistance ℂ).induce (planeOver (adjoinTranscendental ⊥ (liouvilleNumber 10)))).chromaticNumber =
      ((unitDistance ℂ).induce (planeOver ⊥)).chromaticNumber :=
  chromaticNumber_planeOver_adjoin_transcendental_eq ⊥ transcendental_liouvilleNumber_bot

/-! ### Spec examples -/

-- `X` has no pole at `0`; `1/X` has one.
example : (RatFunc.X : RatFunc ℚ) ∈ zeroPlace ℚ := by
  rw [mem_zeroPlace, RatFunc.denom_X]; simp
example : (RatFunc.X : RatFunc ℚ)⁻¹ ∉ zeroPlace ℚ := by
  intro h
  have hX : (RatFunc.X : RatFunc ℚ) ∈ zeroPlace ℚ := by rw [mem_zeroPlace, RatFunc.denom_X]; simp
  have := map_mul (evalZero ℚ) ⟨_, hX⟩ ⟨_, h⟩
  rw [show (⟨_, hX⟩ * ⟨_, h⟩ : zeroPlace ℚ) = 1 from Subtype.ext (mul_inv_cancel₀ RatFunc.X_ne_zero), map_one,
    evalZero_apply, RatFunc.eval_X, zero_mul] at this
  exact one_ne_zero this
-- `F(t)` holds `F` and `t`.
example : Real.sqrt 2 ∈ adjoinTranscendental (adjoinTranscendental ⊥ (Real.sqrt 2)) (liouvilleNumber 10) :=
  le_adjoinTranscendental _ _ (mem_adjoinTranscendental_self _ _)
-- Evaluation at `0` sends `3` to `3` and `X` to `0`.
example : evalZero ℚ ⟨RatFunc.C 3, by simp⟩ = 3 := by
  rw [evalZero_apply]; exact RatFunc.eval_C _ _
example : evalZero ℚ ⟨RatFunc.X, by rw [mem_zeroPlace, RatFunc.denom_X]; simp⟩ = 0 := by
  rw [evalZero_apply]; exact RatFunc.eval_X _ _

end RouteC
end HadwigerNelson
