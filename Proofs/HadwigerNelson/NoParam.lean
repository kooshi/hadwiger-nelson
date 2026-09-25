import Mathlib.NumberTheory.FLT.Polynomial
import Mathlib.RingTheory.Polynomial.RationalRoot
import Mathlib.Algebra.Algebra.Hom.Rat
import Proofs.HadwigerNelson.Transcendental

/-!
# No rational parametrisation of `y² = x³ − x` (Lemma NP), and Fischer's Remark 1 refuted in one variable

`plans/M2-S1D-bridge.md` §2.3, Lemma NP: *"There is no nonconstant `a ∈ ℂ(t)` for which `a³ − a` is a square in
`ℂ(t)`."* Here for every field `k` with `2 ≠ 0` (`not_isSquare_cube_sub_self`), which is what the one-variable C3 needs
(`k` a subfield of `ℝ`, not `ℂ`).

**The proof.** Write `a = p/q` in lowest terms. If `b² = a³ − a`, then `(b·q²)² = p·q·(p² − q²)`, a polynomial, so
`b·q²` is a polynomial `g` (`k[X]` is integrally closed). The three factors `p`, `q`, `p² − q²` are pairwise coprime, so
each is a unit times a square: `p = r₁α²`, `q = r₂β²`, `p² − q² = r₃γ²`. Then

    r₁²·α⁴ − r₂²·β⁴ − r₃·γ² = 0,

a Fermat–Catalan equation of signature `(4, 4, 2)`. Since `1/4 + 1/4 + 1/2 ≤ 1`, Mathlib's `Polynomial.flt_catalan`
(Mason–Stothers, `Polynomial.abc`) makes `α` and `β` constant, so `a` is constant. The hand proof's `(p − q)(p + q)` split
and its degree count are not needed: `p² − q²` enters as one factor, and the degree count is `flt_catalan`'s.

**Where the genus enters.** The signature condition `qr + rp + pq ≤ pqr` is the curve's genus. On the genus-0 twin
`a² − 1` the same route reaches the signature `(2, 2, 1)`, where it fails (`8 ≤ 4`), and the twin is false:
`a = (X² + 1)/(2X)` (`isSquare_twin_sq_sub_one`). In characteristic 2 NP itself is false: `a = X²`
(`isSquare_cube_sub_self_X_sq_zmod_two`).

**C3, one-variable form.** For `F : Subfield ℝ` with every element algebraic over `ℚ` and `t` transcendental over `F`,
`x := 2 + L` (`L` Liouville's constant) and `√(x³ − x)` do not both lie in `F(t)`
(`not_mem_adjoinTranscendental_liouville`): `F(t) ≅ F(X)`, and NP over `F` would make `x` a constant, i.e. in `F`,
hence algebraic.

**C3⁺.** The curve has no new points in any purely transcendental tower `K ⊆ K(t₁) ⊆ ⋯` (`mem_of_isPureTower`, by NP one
step at a time), so no subfield of `ℝ` holding `x` and `√(x³ − x)` embeds in such a tower over a field algebraic over `ℚ`
(`not_forall_mem_isPureTower`). What is not in the kernel: that a purely transcendental extension `F′(t₁, …, t_m)` (an
algebraically independent family) is a tower in this sense, and the transcendence-degree step that reduces `[Fischer1990]`
Remark 1's `F(T)` to one variable (`plans/M2-S1D-bridge.md` §2.3's proof of C3).
-/

set_option autoImplicit false

namespace HadwigerNelson
namespace NoParam

open Polynomial

section Core

variable {k : Type*} [Field k]

/-- A factor coprime to its cofactor in a square is a unit times a square. -/
theorem exists_eq_C_mul_sq_of_mul_eq_sq {x y g : k[X]} (hxy : IsCoprime x y) (h : x * y = g ^ 2) :
    ∃ (r : k) (α : k[X]), r ≠ 0 ∧ α ^ 2 * C r = x := by
  obtain ⟨α, u, hu⟩ := exists_associated_pow_of_mul_eq_pow' hxy h
  obtain ⟨r, hr, hC⟩ := Polynomial.isUnit_iff.mp u.isUnit
  exact ⟨r, α, hr.ne_zero, by rw [hC]; exact hu⟩

/-- **The polynomial core of Lemma NP.** If `p` and `q` are coprime and `p·q·(p² − q²)` is a square, then `p` and `q`
are constants (for `2 ≠ 0` in `k`). -/
theorem natDegree_eq_zero_of_mul_mul_sub_eq_sq (h2 : (2 : k) ≠ 0) {p q g : k[X]} (hpq : IsCoprime p q)
    (hg : p * q * (p ^ 2 - q ^ 2) = g ^ 2) : p.natDegree = 0 ∧ q.natDegree = 0 := by
  -- the degenerate cases: one of `p`, `q`, `p² − q²` is zero
  have hunit : ∀ {x : k[X]}, IsUnit x → x.natDegree = 0 := fun hx => natDegree_eq_zero_of_isUnit hx
  by_cases hp0 : p = 0
  · subst hp0
    exact ⟨natDegree_zero, hunit (isCoprime_zero_left.mp hpq)⟩
  by_cases hq0 : q = 0
  · subst hq0
    exact ⟨hunit (isCoprime_zero_right.mp hpq), natDegree_zero⟩
  -- the three factors are pairwise coprime
  have hp_s : IsCoprime p (p ^ 2 - q ^ 2) := by
    have := (hpq.pow_right (n := 2)).neg_right.add_mul_left_right p
    rwa [show -q ^ 2 + p * p = p ^ 2 - q ^ 2 by ring] at this
  have hq_s : IsCoprime q (p ^ 2 - q ^ 2) := by
    have := (hpq.symm.pow_right (n := 2)).add_mul_left_right (-q)
    rwa [show p ^ 2 + q * -q = p ^ 2 - q ^ 2 by ring] at this
  by_cases hs0 : p ^ 2 - q ^ 2 = 0
  · have hpq2 : p ^ 2 = q ^ 2 := sub_eq_zero.mp hs0
    refine ⟨hunit ((hpq.pow_right (n := 2)).isUnit_of_dvd' dvd_rfl ⟨p, by rw [← hpq2]; ring⟩),
      hunit ((hpq.symm.pow_right (n := 2)).isUnit_of_dvd' dvd_rfl ⟨q, by rw [hpq2]; ring⟩)⟩
  -- each factor is a unit times a square
  obtain ⟨r₁, α, hr₁, hα⟩ := exists_eq_C_mul_sq_of_mul_eq_sq (hpq.mul_right hp_s)
    (show p * (q * (p ^ 2 - q ^ 2)) = g ^ 2 by rw [← hg]; ring)
  obtain ⟨r₂, β, hr₂, hβ⟩ := exists_eq_C_mul_sq_of_mul_eq_sq (hpq.symm.mul_right hq_s)
    (show q * (p * (p ^ 2 - q ^ 2)) = g ^ 2 by rw [← hg]; ring)
  obtain ⟨r₃, γ, hr₃, hγ⟩ := exists_eq_C_mul_sq_of_mul_eq_sq (hp_s.symm.mul_right hq_s.symm)
    (show (p ^ 2 - q ^ 2) * (p * q) = g ^ 2 by rw [← hg]; ring)
  have hα0 : α ≠ 0 := by rintro rfl; apply hp0; rw [← hα]; ring
  have hβ0 : β ≠ 0 := by rintro rfl; apply hq0; rw [← hβ]; ring
  have hγ0 : γ ≠ 0 := by rintro rfl; apply hs0; rw [← hγ]; ring
  have hαβ : IsCoprime α β := by
    rw [← hα, ← hβ] at hpq
    exact (IsCoprime.pow_iff two_pos two_pos).mp hpq.of_mul_left_left.of_mul_right_left
  -- the Fermat–Catalan equation of signature (4, 4, 2)
  have heq : C (r₁ ^ 2) * α ^ 4 + C (-r₂ ^ 2) * β ^ 4 + C (-r₃) * γ ^ 2 = 0 := by
    simp only [map_pow, map_neg]
    linear_combination (α ^ 2 * C r₁ + p) * hα - (β ^ 2 * C r₂ + q) * hβ - hγ
  have h4 : ((4 : ℕ) : k) ≠ 0 := by
    rw [show ((4 : ℕ) : k) = 2 * 2 by norm_num]; exact mul_ne_zero h2 h2
  obtain ⟨hαd, hβd, -⟩ := Polynomial.flt_catalan (p := 4) (q := 4) (r := 2) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) h4 h4 (by exact_mod_cast h2) hα0 hβ0 hγ0 hαβ (pow_ne_zero 2 hr₁)
    (neg_ne_zero.mpr (pow_ne_zero 2 hr₂)) (neg_ne_zero.mpr hr₃) heq
  refine ⟨?_, ?_⟩
  · rw [← hα, natDegree_mul_C hr₁, natDegree_pow, hαd, mul_zero]
  · rw [← hβ, natDegree_mul_C hr₂, natDegree_pow, hβd, mul_zero]

/-- A rational function whose square is a polynomial is a polynomial (`k[X]` is integrally closed). -/
theorem exists_algebraMap_eq_of_sq_eq {B : RatFunc k} {P : k[X]} (h : B ^ 2 = algebraMap k[X] (RatFunc k) P) :
    ∃ g : k[X], algebraMap k[X] (RatFunc k) g = B :=
  IsIntegrallyClosed.exists_algebraMap_eq_of_isIntegral_pow two_pos (h ▸ isIntegral_algebraMap)

/-- **Lemma NP** (`plans/M2-S1D-bridge.md` §2.3), over every field with `2 ≠ 0`: no nonconstant rational function `a`
has `a³ − a` a square. -/
theorem not_isSquare_cube_sub_self (h2 : (2 : k) ≠ 0) {a : RatFunc k}
    (ha : a ∉ Set.range (RatFunc.C (K := k))) : ¬ IsSquare (a ^ 3 - a) := by
  rintro ⟨b, hb⟩
  have hQ : algebraMap k[X] (RatFunc k) a.denom ≠ 0 := RatFunc.algebraMap_ne_zero a.denom_ne_zero
  have haQ : algebraMap k[X] (RatFunc k) a.num = a * algebraMap k[X] (RatFunc k) a.denom :=
    (div_eq_iff hQ).mp (RatFunc.num_div_denom a)
  -- `(b·q²)² = p·q·(p² − q²)`
  have hB : (b * algebraMap k[X] (RatFunc k) a.denom ^ 2) ^ 2 =
      algebraMap k[X] (RatFunc k) (a.num * a.denom * (a.num ^ 2 - a.denom ^ 2)) := by
    simp only [map_mul, map_sub, map_pow]
    set P := algebraMap k[X] (RatFunc k) a.num
    set Q := algebraMap k[X] (RatFunc k) a.denom
    linear_combination (-(Q ^ 4)) * hb - (Q * ((a * Q) ^ 2 + a * Q * P + P ^ 2) - Q ^ 3) * haQ
  obtain ⟨g, hg⟩ := exists_algebraMap_eq_of_sq_eq hB
  have hg2 : a.num * a.denom * (a.num ^ 2 - a.denom ^ 2) = g ^ 2 := by
    apply RatFunc.algebraMap_injective k
    rw [map_pow, hg, hB]
  obtain ⟨hp, hq⟩ := natDegree_eq_zero_of_mul_mul_sub_eq_sq h2 (RatFunc.isCoprime_num_denom a) hg2
  refine ha ⟨a.num.coeff 0 / a.denom.coeff 0, ?_⟩
  rw [map_div₀, ← RatFunc.algebraMap_C, ← RatFunc.algebraMap_C, ← eq_C_of_natDegree_eq_zero hp,
    ← eq_C_of_natDegree_eq_zero hq, RatFunc.num_div_denom]

/-- **The curve has no new points over `k(X)`**: `b² = a³ − a` in `k(X)` forces `a` and `b` constant (`2 ≠ 0`). NP gives `a`;
then `b²` is a constant, so `b` is a polynomial of degree 0. -/
theorem mem_range_C_of_sq_eq_cube_sub_self (h2 : (2 : k) ≠ 0) {a b : RatFunc k} (h : b ^ 2 = a ^ 3 - a) :
    a ∈ Set.range (RatFunc.C (K := k)) ∧ b ∈ Set.range (RatFunc.C (K := k)) := by
  have ha : a ∈ Set.range (RatFunc.C (K := k)) := by
    by_contra ha
    exact not_isSquare_cube_sub_self h2 ha ⟨b, by rw [← h, sq]⟩
  refine ⟨ha, ?_⟩
  obtain ⟨a₀, rfl⟩ := ha
  have hb : b ^ 2 = algebraMap k[X] (RatFunc k) (C (a₀ ^ 3 - a₀)) := by
    rw [h, RatFunc.algebraMap_C, map_sub, map_pow]
  obtain ⟨g, rfl⟩ := exists_algebraMap_eq_of_sq_eq hb
  have hg : g ^ 2 = C (a₀ ^ 3 - a₀) := RatFunc.algebraMap_injective k (by rw [map_pow, hb])
  have hg0 : g.natDegree = 0 := by
    have := congrArg natDegree hg
    rw [natDegree_pow, natDegree_C] at this
    omega
  exact ⟨g.coeff 0, by rw [← RatFunc.algebraMap_C, ← eq_C_of_natDegree_eq_zero hg0]⟩

/-- Lemma NP in the brief's form: characteristic zero. -/
theorem not_isSquare_cube_sub_self_of_charZero [CharZero k] {a : RatFunc k}
    (ha : a ∉ Set.range (RatFunc.C (K := k))) : ¬ IsSquare (a ^ 3 - a) :=
  not_isSquare_cube_sub_self two_ne_zero ha

end Core

/-! ### The controls: the genus-0 twin, and characteristic 2 -/

section Controls

variable (k : Type*) [Field k]

/-- The twin's witness `(X² + 1)/(2X)`. -/
noncomputable def twin : RatFunc k := (RatFunc.X ^ 2 + 1) / (2 * RatFunc.X)

/-- The twin's witness is not constant. -/
theorem twin_not_mem_range_C (h2 : (2 : k) ≠ 0) : twin k ∉ Set.range (RatFunc.C (K := k)) := by
  rintro ⟨c, hc⟩
  have h2' : (2 : RatFunc k) ≠ 0 := by
    rw [← map_ofNat (RatFunc.C (K := k)) 2]; exact (_root_.map_ne_zero _).mpr h2
  have hR : RatFunc.C c * (2 * RatFunc.X) = RatFunc.X ^ 2 + 1 := by
    rw [hc, twin, div_mul_cancel₀ _ (mul_ne_zero h2' RatFunc.X_ne_zero)]
  have hpoly : (C c * (2 * X) : k[X]) = X ^ 2 + 1 := by
    apply RatFunc.algebraMap_injective k
    simpa only [map_mul, map_add, map_pow, map_one, map_ofNat, RatFunc.algebraMap_C, RatFunc.algebraMap_X] using hR
  simpa using congrArg (eval 0) hpoly

/-- **The genus-0 twin of NP is false**: `a² − 1` is a square at the nonconstant `a = (X² + 1)/(2X)`, since
`a² − 1 = ((X² − 1)/(2X))²`. -/
theorem isSquare_twin_sq_sub_one (h2 : (2 : k) ≠ 0) : IsSquare (twin k ^ 2 - 1) := by
  have h2' : (2 : RatFunc k) ≠ 0 := by
    rw [← map_ofNat (RatFunc.C (K := k)) 2]; exact (_root_.map_ne_zero _).mpr h2
  have hX : (RatFunc.X : RatFunc k) ≠ 0 := RatFunc.X_ne_zero
  refine ⟨(RatFunc.X ^ 2 - 1) / (2 * RatFunc.X), ?_⟩
  rw [twin]
  field_simp
  ring

/-- `X²` is not constant. -/
theorem X_sq_not_mem_range_C : (RatFunc.X : RatFunc k) ^ 2 ∉ Set.range (RatFunc.C (K := k)) := by
  rintro ⟨c, hc⟩
  have hpoly : (C c : k[X]) = X ^ 2 := by
    apply RatFunc.algebraMap_injective k
    rw [RatFunc.algebraMap_C, map_pow, RatFunc.algebraMap_X, hc]
  simpa using congrArg natDegree hpoly

/-- **NP is false in characteristic 2**: over `𝔽₂`, `a = X²` has `a³ − a = (X(X² + 1))²`. The hypothesis `2 ≠ 0` of
`not_isSquare_cube_sub_self` is not idle. -/
theorem isSquare_cube_sub_self_X_sq_zmod_two :
    IsSquare (((RatFunc.X : RatFunc (ZMod 2)) ^ 2) ^ 3 - RatFunc.X ^ 2) := by
  have h2 : (2 : RatFunc (ZMod 2)) = 0 := by
    rw [← map_ofNat (RatFunc.C (K := ZMod 2)) 2, show (2 : ZMod 2) = 0 from rfl, map_zero]
  exact ⟨RatFunc.X * (RatFunc.X ^ 2 + 1), by linear_combination (-(RatFunc.X ^ 4 + RatFunc.X ^ 2)) * h2⟩

end Controls

/-! ### C3, one-variable containment form -/

open RouteC

/-- **The containment core.** For `F ⊆ ℝ`, `t` transcendental over `F`, and `x ∉ F`, no `y` with `y² = x³ − x` lies in
`F(t)` together with `x`: under `F(t) ≅ F(X)`, NP makes the image of `x` a constant, hence `x ∈ F`. -/
theorem not_mem_adjoinTranscendental_of_sq_eq (F : Subfield ℝ) {t : ℝ} (ht : Transcendental F t) {x y : ℝ}
    (hx : x ∉ F) (hxy : y ^ 2 = x ^ 3 - x) :
    ¬ (x ∈ adjoinTranscendental F t ∧ y ∈ adjoinTranscendental F t) := by
  rintro ⟨hxm, hym⟩
  let e := adjoinTranscendentalEquiv F ht
  have h2 : (2 : F) ≠ 0 := fun h => two_ne_zero (congrArg ((↑) : F → ℝ) h)
  have hsq : IsSquare (e ⟨x, hxm⟩ ^ 3 - e ⟨x, hxm⟩) := ⟨e ⟨y, hym⟩, by
    rw [← map_pow, ← map_sub, ← map_mul]
    congr 1
    apply Subtype.ext
    push_cast
    rw [← hxy, sq]⟩
  obtain ⟨f, hf⟩ : e ⟨x, hxm⟩ ∈ Set.range (RatFunc.C (K := F)) := by
    by_contra hC
    exact not_isSquare_cube_sub_self h2 hC hsq
  apply hx
  have hxf : (⟨x, hxm⟩ : adjoinTranscendental F t) = e.symm (RatFunc.C f) := by
    rw [hf, RingEquiv.symm_apply_apply]
  have hval : ((e.symm (RatFunc.C f) : adjoinTranscendental F t) : ℝ) = f :=
    congrArg Subtype.val ((RatFunc.algEquivOfTranscendental t ht).commutes f)
  have hxv : x = f := by rw [← hval, ← hxf]
  rw [hxv]
  exact f.2

/-- `2 + L` is transcendental over `ℚ` (`L` Liouville's constant). -/
theorem transcendental_two_add_liouvilleNumber : Transcendental ℚ (2 + liouvilleNumber 10) := by
  have hZ : Transcendental ℤ (liouvilleNumber 10) := transcendental_liouvilleNumber (by norm_num)
  have hQ : Transcendental ℚ (liouvilleNumber 10) := by
    haveI : Algebra.IsAlgebraic ℤ ℚ := IsLocalization.isAlgebraic ℚ (nonZeroDivisors ℤ)
    exact (Algebra.IsAlgebraic.transcendental_iff ℤ ℚ).mp hZ
  intro h
  apply hQ
  have := h.sub (isAlgebraic_algebraMap (R := ℚ) (A := ℝ) 2)
  simpa using this

/-- **C3, one-variable containment form** (J17-T5's kernel form): for `F : Subfield ℝ` with every element algebraic
over `ℚ` and `t` transcendental over `F`, the reals `x := 2 + L` and `√(x³ − x)` do not both lie in `F(t)`. -/
theorem not_mem_adjoinTranscendental_liouville (F : Subfield ℝ) (hF : ∀ z ∈ F, IsAlgebraic ℚ z) {t : ℝ}
    (ht : Transcendental F t) :
    ¬ (2 + liouvilleNumber 10 ∈ adjoinTranscendental F t ∧
      Real.sqrt ((2 + liouvilleNumber 10) ^ 3 - (2 + liouvilleNumber 10)) ∈ adjoinTranscendental F t) := by
  have hL : 0 ≤ liouvilleNumber 10 := tsum_nonneg fun i => by positivity
  refine not_mem_adjoinTranscendental_of_sq_eq F ht (fun hx => transcendental_two_add_liouvilleNumber (hF _ hx)) ?_
  rw [Real.sq_sqrt]
  nlinarith [mul_nonneg hL hL, mul_nonneg (mul_nonneg hL hL) hL]

/-- **The inhabitant of C3's hypotheses**: `F = ℚ` (the bottom subfield), `t = L`. There `x = 2 + L` does lie in `ℚ(L)`,
so C3 says `√((2 + L)³ − (2 + L)) ∉ ℚ(L)`. -/
theorem sqrt_not_mem_adjoinTranscendental_bot_liouville :
    Real.sqrt ((2 + liouvilleNumber 10) ^ 3 - (2 + liouvilleNumber 10)) ∉
      adjoinTranscendental ⊥ (liouvilleNumber 10) := by
  intro hy
  refine not_mem_adjoinTranscendental_liouville ⊥ ?_ transcendental_liouvilleNumber_bot
    ⟨add_mem (ofNat_mem _ 2) (mem_adjoinTranscendental_self _ _), hy⟩
  intro z hz
  rw [Subfield.bot_eq_of_charZero] at hz
  obtain ⟨q, rfl⟩ := hz
  simpa using isAlgebraic_algebraMap (R := ℚ) (A := ℝ) q

/-! ### C3⁺: no embedding into a purely transcendental tower -/

/-- **A purely transcendental tower**: `L` arises from `K` by finitely many simple transcendental adjunctions inside `Ω`,
`K ⊆ K(t₁) ⊆ K(t₁)(t₂) ⊆ ⋯`, each `tᵢ` transcendental over the field before it. A purely transcendental extension
`F′(t₁, …, t_m)` is such a tower over `F′` (algebraic independence is successive transcendence). Inhabited below at
`ℚ ⊆ ℚ(L)` (`isPureTower_bot_liouville`). -/
inductive IsPureTower {Ω : Type*} [Field Ω] (K : Subfield Ω) : Subfield Ω → Prop
  | refl : IsPureTower K K
  | adjoin {L : Subfield Ω} (t : Ω) : IsPureTower K L → Transcendental L t →
      IsPureTower K (IntermediateField.adjoin L {t}).toSubfield

/-- **The curve has no new points in a pure tower**: if `L` is a purely transcendental tower over `K` inside `Ω` (`2 ≠ 0`),
every point `(a, b)` of `y² = x³ − x` with coordinates in `L` has them in `K`. Induction on the tower, one step being
`mem_range_C_of_sq_eq_cube_sub_self` through `K(t) ≅ K(X)`. -/
theorem mem_of_isPureTower {Ω : Type*} [Field Ω] (h2 : (2 : Ω) ≠ 0) {K L : Subfield Ω}
    (hKL : IsPureTower K L) {a b : Ω} (ha : a ∈ L) (hb : b ∈ L) (h : b ^ 2 = a ^ 3 - a) : a ∈ K ∧ b ∈ K := by
  induction hKL generalizing a b with
  | refl => exact ⟨ha, hb⟩
  | @adjoin L t _ ht ih =>
    let e := RatFunc.algEquivOfTranscendental t ht
    have h2L : (2 : L) ≠ 0 := fun h0 => h2 (congrArg ((↑) : L → Ω) h0)
    have hAB : (e.symm ⟨b, hb⟩) ^ 2 = (e.symm ⟨a, ha⟩) ^ 3 - e.symm ⟨a, ha⟩ := by
      apply e.injective
      simp only [map_pow, map_sub, AlgEquiv.apply_symm_apply]
      exact Subtype.ext (by push_cast; exact h)
    obtain ⟨⟨a₀, ha₀⟩, ⟨b₀, hb₀⟩⟩ := mem_range_C_of_sq_eq_cube_sub_self h2L hAB
    have hval : ∀ {z : Ω} (hz : z ∈ (IntermediateField.adjoin L {t}).toSubfield) (z₀ : L),
        RatFunc.C z₀ = e.symm ⟨z, hz⟩ → z = z₀ := by
      intro z hz z₀ hz₀
      calc z = ((⟨z, hz⟩ : IntermediateField.adjoin L {t}) : Ω) := rfl
        _ = ((e (RatFunc.C z₀) : IntermediateField.adjoin L {t}) : Ω) := by
          rw [hz₀, AlgEquiv.apply_symm_apply]
        _ = z₀ := congrArg Subtype.val (e.commutes z₀)
    rw [hval ha a₀ ha₀, hval hb b₀ hb₀] at h
    rw [hval ha a₀ ha₀, hval hb b₀ hb₀]
    exact ih a₀.2 b₀.2 h

/-- **C3⁺** (J17-T6, `plans/M2-S1D-bridge.md` §2.3: "`E` embeds in **no** purely transcendental extension `F′(t₁, …, t_m)` of
any number field `F′`"): for every subfield `E ⊆ ℝ` holding `x = 2 + L` and `√(x³ − x)`, every field `Ω` of characteristic 0, and
every purely transcendental tower `L` over a subfield `K` algebraic over `ℚ`, no ring hom `E → Ω` lands in `L`: the image of
`x` would lie in `K`, hence be algebraic, hence so would `x`. -/
theorem not_forall_mem_isPureTower (E : Subfield ℝ) (hxE : 2 + liouvilleNumber 10 ∈ E)
    (hyE : Real.sqrt ((2 + liouvilleNumber 10) ^ 3 - (2 + liouvilleNumber 10)) ∈ E)
    {Ω : Type*} [Field Ω] [CharZero Ω] {K L : Subfield Ω} (hKL : IsPureTower K L)
    (hK : ∀ z ∈ K, IsAlgebraic ℚ z) (φ : E →+* Ω) : ¬ ∀ z, φ z ∈ L := by
  intro hφ
  have hL : 0 ≤ liouvilleNumber 10 := tsum_nonneg fun i => by positivity
  have hxy : (⟨_, hyE⟩ : E) ^ 2 = ⟨_, hxE⟩ ^ 3 - ⟨_, hxE⟩ := by
    apply Subtype.ext
    push_cast
    rw [Real.sq_sqrt]
    nlinarith [mul_nonneg hL hL, mul_nonneg (mul_nonneg hL hL) hL]
  have hmem := (mem_of_isPureTower two_ne_zero hKL (hφ ⟨_, hxE⟩) (hφ ⟨_, hyE⟩)
    (by rw [← map_pow, ← map_pow, ← map_sub, hxy])).1
  have hE : IsAlgebraic ℚ (⟨_, hxE⟩ : E) :=
    (isAlgebraic_algHom_iff φ.toRatAlgHom φ.injective).mp (hK _ hmem)
  exact transcendental_two_add_liouvilleNumber
    ((isAlgebraic_algHom_iff E.subtype.toRatAlgHom Subtype.val_injective).mpr hE)

/-- The inhabitant of `IsPureTower`'s step: `ℚ(L) ⊆ ℝ` is a one-step tower over `ℚ`. -/
theorem isPureTower_bot_liouville :
    IsPureTower (⊥ : Subfield ℝ) (adjoinTranscendental ⊥ (liouvilleNumber 10)) :=
  IsPureTower.adjoin _ IsPureTower.refl transcendental_liouvilleNumber_bot

/-- The inhabitant of C3⁺'s hypotheses: `E = ℝ`, the tower `ℚ ⊆ ℚ(L)` in `Ω = ℝ`, `φ` the identity. It says `ℝ ⊄ ℚ(L)`. -/
theorem not_forall_mem_adjoinTranscendental_bot_liouville :
    ¬ ∀ z : (⊤ : Subfield ℝ), (⊤ : Subfield ℝ).subtype z ∈ adjoinTranscendental ⊥ (liouvilleNumber 10) :=
  not_forall_mem_isPureTower ⊤ trivial trivial isPureTower_bot_liouville
    (fun z hz => by
      rw [Subfield.bot_eq_of_charZero] at hz
      obtain ⟨q, rfl⟩ := hz
      simpa using isAlgebraic_algebraMap (R := ℚ) (A := ℝ) q) _

/-! ### Spec examples -/

-- NP at `a = X²` over `ℚ`: `(X²)³ − X²` is not a square — the same function is a square over `𝔽₂`
-- (`isSquare_cube_sub_self_X_sq_zmod_two`).
example : ¬ IsSquare (((RatFunc.X : RatFunc ℚ) ^ 2) ^ 3 - RatFunc.X ^ 2) :=
  not_isSquare_cube_sub_self two_ne_zero (X_sq_not_mem_range_C ℚ)

-- The twin's witness clears to `X² + 1` against `2X`.
example : twin ℚ * (2 * RatFunc.X) = RatFunc.X ^ 2 + 1 :=
  div_mul_cancel₀ _ (mul_ne_zero two_ne_zero RatFunc.X_ne_zero)
-- A constant is a square minus itself only trivially: NP says nothing about constants (`a = 2` gives `6`, a square in `ℝ`).
example : IsSquare ((RatFunc.C (2 : ℝ)) ^ 3 - RatFunc.C 2) :=
  ⟨RatFunc.C (Real.sqrt 6), by
    rw [← map_pow, ← map_sub, ← map_mul, Real.mul_self_sqrt (by norm_num)]; norm_num⟩

end NoParam
end HadwigerNelson
