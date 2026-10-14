import Proofs.HadwigerNelson.Arith.Floor128

/-!
# Binary fields from a primitive polynomial: the generic form of `Floor128`'s bridge (FS131-ICM4)

**Read aloud.** A code `x < 2ⁿ` is an element of `𝔽₂[x]` of degree below `n` (bit `i` the coefficient of `xⁱ`;
`Floor128.ev` reads it at a point). `step n P` multiplies a code by `x` modulo a polynomial `P` of degree `n`. When the
register's orbit of `1` returns to `1` first after `2ⁿ − 1` steps (`IsPrimitiveCode n P`, decided by `primCheck`), then
in **every** field `k` of `2ⁿ` elements:

* `P` has a root `g` (`exists_root`): the orbit says `P ∣ x^(2ⁿ−1) − 1` in `k[x]`, and `x^|k| − x` splits in `k`;
* the codes below `2ⁿ` are the elements of `k`, additively (`exists_code_fun`: `x ↦` its code turns `+` into `^^^`),
  and the code of `gᵐ` is the register's `m`-th state, so `g` generates `kˣ` (`exists_root_pow_eq`);
* the norm-one set `μ_{Q+1}`, `Q² = 2ⁿ`, is `{g^((Q−1)j) : j ≤ Q}` (`normOne_eq_image`);
* `x ↦ (−1)^(bit 0 of the code of x)` is a non-trivial additive character (`exists_addChar`).

Two consumers, each a statement about every field of `Q² = 2ⁿ` elements read from a finite check on the register:

* `charSum_ge_of_classes` — if every class `r < Q − 1` of the orbit's bit-0 sequence has at most `B` ones among
  `(Q − 1)j + r`, `j ≤ Q`, every non-trivial character sums to real part at least `Q + 1 − 2B` over `μ_{Q+1}`
  (`Floor128.charSum_128_ge`'s argument, for any `n`, `P`, `Q`); the class counts are read from one `pass`
  (`pass_class`);
* `colorable_four_of_check` — if every `u ∈ μ_{Q+1}` has `L₀(g^{e₁}u) = 1` or `L₀(g^{e₂}u) = 1` (`L₀` the coordinate-0
  functional; `colourCheck`), then `x ↦ (L₀(g^{e₁}x), L₀(g^{e₂}x))` is a proper four-colouring of `Cay(k, μ_{Q+1})`: its
  colour classes are the cosets of a codimension-2 `𝔽₂`-subspace avoiding `μ_{Q+1}` (X26B-T1's linear colourings).

**`Floor128` is left as it is** (FS131-ICM4's choice): its certificate is proved, its bridge is the instance of this one at
`n = 14`, and reading it through this module would rebuild it and its dependents for no change of statement. This module
reuses its generic `ev` lemmas (`ev_xor`, `ev_clmul`'s neighbours, `coeff_ev_X`, `map_ev`) and `digit_sum`,
`sum_range_mul_eq`. Unlike `Floor128` the root is found with no cofactor certificate: the orbit itself is the divisibility.

**Inhabitants.** `IsPrimitiveCode 2 7` (`x² + x + 1`) is proved in the Spec; the five instances used are in
`Arith/DyadicCerts`, each with `GaloisField 2 n` as the model of the field hypotheses.
-/

namespace HadwigerNelson.BinaryField

open Finset StandingFive
open Floor128 (ev ev_zero ev_eq ev_one ev_xor ev_shiftLeft_one coeff_ev_X map_ev digit_sum sum_range_mul_eq)

/-! ### The register -/

/-- Multiplication by `x` on the codes below `2ⁿ` of `𝔽₂[x]/(P)`, for `P` of degree `n`: a shift, and the reduction by
`P` when bit `n − 1` was set. (`Floor128.step` is this at `n = 14`, `P = 16427`.) -/
def step (n P x : ℕ) : ℕ := if x.testBit (n - 1) then (x <<< 1) ^^^ P else x <<< 1

/-- `orbitOk n P fuel x`: none of the `fuel` states `x, step x, …` before the `fuel`-th is `1`, and the `fuel`-th is. -/
def orbitOk (n P : ℕ) : ℕ → ℕ → Bool
  | 0, x => x == 1
  | fuel + 1, x => x != 1 && orbitOk n P fuel (step n P x)

/-- **The primitivity check**: `P` has degree exactly `n ≥ 1`, and the register's orbit of `1` returns to `1` first after
`2ⁿ − 1` steps. -/
def primCheck (n P : ℕ) : Bool := decide (0 < n) && P >>> n == 1 && orbitOk n P (2 ^ n - 2) (step n P 1)

/-- `P` is a primitive polynomial of degree `n` over `𝔽₂`, as its register sees it: degree `n`, and multiplication by `x`
has order exactly `2ⁿ − 1` at `1`. Decided by `primCheck` (`isPrimitiveCode_of_check`). -/
structure IsPrimitiveCode (n P : ℕ) : Prop where
  /-- The degree is positive. -/
  pos : 0 < n
  /-- `P` has degree exactly `n`: bit `n` is its top bit. -/
  deg : P >>> n = 1
  /-- The orbit of `1` closes after `2ⁿ − 1` steps. -/
  period : (step n P)^[2 ^ n - 1] 1 = 1
  /-- … and not before. -/
  first : ∀ j, 0 < j → j < 2 ^ n - 1 → (step n P)^[j] 1 ≠ 1

/-- What `orbitOk` checks. -/
theorem orbitOk_iff (n P : ℕ) : ∀ fuel x, orbitOk n P fuel x = true ↔
    (∀ j < fuel, (step n P)^[j] x ≠ 1) ∧ (step n P)^[fuel] x = 1
  | 0, x => by simp [orbitOk]
  | fuel + 1, x => by
    rw [orbitOk, Bool.and_eq_true, bne_iff_ne, orbitOk_iff n P fuel (step n P x)]
    constructor
    · rintro ⟨h1, h2, h3⟩
      refine ⟨fun j hj => ?_, by rwa [Function.iterate_succ_apply]⟩
      rcases j with _ | j
      · simpa using h1
      · rw [Function.iterate_succ_apply]
        exact h2 j (by omega)
    · rintro ⟨h1, h2⟩
      refine ⟨by simpa using h1 0 (by omega), fun j hj => ?_, by rwa [← Function.iterate_succ_apply]⟩
      rw [← Function.iterate_succ_apply]
      exact h1 (j + 1) (by omega)

/-- `primCheck` decides `IsPrimitiveCode`. -/
theorem isPrimitiveCode_of_check {n P : ℕ} (h : primCheck n P = true) : IsPrimitiveCode n P := by
  simp only [primCheck, Bool.and_eq_true, decide_eq_true_eq, beq_iff_eq] at h
  obtain ⟨⟨hn, hdeg⟩, horb⟩ := h
  rw [orbitOk_iff] at horb
  have h2 : 2 ≤ 2 ^ n := Nat.le_self_pow hn.ne' 2
  refine ⟨hn, hdeg, ?_, fun j hj0 hj => ?_⟩
  · rw [show 2 ^ n - 1 = (2 ^ n - 2) + 1 by omega, Function.iterate_succ_apply]
    exact horb.2
  · obtain ⟨j, rfl⟩ : ∃ i, j = i + 1 := ⟨j - 1, by omega⟩
    rw [Function.iterate_succ_apply]
    exact horb.1 j (by omega)

variable {n P : ℕ}

namespace IsPrimitiveCode

/-- Bit `n` of `P` is set. -/
theorem testBit_deg (hP : IsPrimitiveCode n P) : P.testBit n = true := by
  have h := Nat.testBit_shiftRight (i := n) (j := 0) P
  rw [hP.deg, Nat.add_zero] at h
  rw [← h]
  rfl

/-- No bit of `P` above `n` is set. -/
theorem testBit_gt (hP : IsPrimitiveCode n P) {i : ℕ} (hi : n < i) : P.testBit i = false := by
  have h := Nat.testBit_shiftRight (i := n) (j := i - n) P
  rw [hP.deg, Nat.add_sub_cancel' hi.le] at h
  rw [← h]
  exact Nat.testBit_lt_two_pow (Nat.one_lt_two_pow (by omega))

/-- `2ⁿ − 1 ≥ 1`. -/
theorem one_le (hP : IsPrimitiveCode n P) : 1 ≤ 2 ^ n - 1 := by
  have := Nat.le_self_pow hP.pos.ne' 2
  omega

end IsPrimitiveCode

/-- `step` keeps the codes below `2ⁿ`: the shift's bit `n` is cancelled by `P`'s. -/
theorem step_lt (hP : IsPrimitiveCode n P) {x : ℕ} (hx : x < 2 ^ n) : step n P x < 2 ^ n := by
  refine Nat.lt_pow_two_of_testBit _ fun i hi => ?_
  have hx' : ∀ j, n ≤ j → x.testBit j = false := fun j hj =>
    Nat.testBit_lt_two_pow (lt_of_lt_of_le hx (Nat.pow_le_pow_right two_pos hj))
  have hn := hP.pos
  unfold step
  split_ifs with h
  · rw [Nat.testBit_xor, Nat.testBit_shiftLeft]
    rcases Nat.eq_or_lt_of_le hi with rfl | hi'
    · have h1 : n ≥ 1 := hn
      simp [h, hP.testBit_deg, h1]
    · rw [hP.testBit_gt hi', hx' (i - 1) (by omega)]
      simp
  · rw [Nat.testBit_shiftLeft]
    rcases Nat.eq_or_lt_of_le hi with rfl | hi'
    · simp [h]
    · rw [hx' (i - 1) (by omega)]
      simp

/-- The zero code is fixed. -/
theorem step_zero : step n P 0 = 0 := by simp [step]

/-- The states of the register stay below `2ⁿ`. -/
theorem iterate_step_lt (hP : IsPrimitiveCode n P) (m : ℕ) : (step n P)^[m] 1 < 2 ^ n := by
  induction m with
  | zero => exact Nat.one_lt_two_pow hP.pos.ne'
  | succ m ih => rw [Function.iterate_succ_apply']; exact step_lt hP ih

/-- The states of the register are non-zero: `0` is fixed, and the orbit returns to `1`. -/
theorem iterate_step_ne_zero (hP : IsPrimitiveCode n P) (m : ℕ) : (step n P)^[m] 1 ≠ 0 := by
  intro h
  have hper : (step n P)^[(2 ^ n - 1) * (m + 1)] 1 = 1 :=
    Function.IsPeriodicPt.mul_const (show Function.IsPeriodicPt (step n P) (2 ^ n - 1) 1 from hP.period) _
  have hle : m ≤ (2 ^ n - 1) * (m + 1) := by
    have := hP.one_le
    nlinarith
  rw [show (2 ^ n - 1) * (m + 1) = ((2 ^ n - 1) * (m + 1) - m) + m by omega, Function.iterate_add_apply, h,
    Function.iterate_fixed step_zero] at hper
  exact zero_ne_one hper

/-- **The register has period exactly `2ⁿ − 1` at 1.** -/
theorem minimalPeriod_step (hP : IsPrimitiveCode n P) : Function.minimalPeriod (step n P) 1 = 2 ^ n - 1 := by
  have hN : 0 < 2 ^ n - 1 := hP.one_le
  have hper : Function.IsPeriodicPt (step n P) (2 ^ n - 1) 1 := hP.period
  have hle := hper.minimalPeriod_le hN
  by_contra hne
  exact hP.first _ (hper.minimalPeriod_pos hN) (lt_of_le_of_ne hle hne) Function.iterate_minimalPeriod

/-- The first `2ⁿ − 1` states of the register are distinct. -/
theorem iterate_step_injOn (hP : IsPrimitiveCode n P) :
    Set.InjOn (fun m => (step n P)^[m] 1) (Set.Iio (2 ^ n - 1)) := by
  have h := Function.iterate_injOn_Iio_minimalPeriod (f := step n P) (x := 1)
  rwa [minimalPeriod_step hP] at h

/-- **Every non-zero code below `2ⁿ` is a state of the register**: `2ⁿ − 1` distinct states among `2ⁿ − 1` codes. -/
theorem exists_iterate_step_eq (hP : IsPrimitiveCode n P) {m : ℕ} (hm : m < 2 ^ n) (h0 : m ≠ 0) :
    ∃ j < 2 ^ n - 1, (step n P)^[j] 1 = m := by
  have hsub : (range (2 ^ n - 1)).image (fun j => (step n P)^[j] 1) ⊆ (range (2 ^ n)).erase 0 := by
    intro x hx
    obtain ⟨j, -, rfl⟩ := mem_image.mp hx
    exact mem_erase.mpr ⟨iterate_step_ne_zero hP j, mem_range.mpr (iterate_step_lt hP j)⟩
  have hcard : ((range (2 ^ n)).erase 0).card ≤ ((range (2 ^ n - 1)).image (fun j => (step n P)^[j] 1)).card := by
    rw [card_image_of_injOn (by simpa using iterate_step_injOn hP), card_erase_of_mem (by simp), card_range,
      card_range]
  have hmem : m ∈ (range (2 ^ n - 1)).image (fun j => (step n P)^[j] 1) := by
    rw [eq_of_subset_of_card_le hsub hcard]
    exact mem_erase.mpr ⟨h0, mem_range.mpr hm⟩
  obtain ⟨j, hj, rfl⟩ := mem_image.mp hmem
  exact ⟨j, mem_range.mp hj, rfl⟩

/-! ### The register evaluated at a point -/

section CharTwo

variable {R : Type*} [CommRing R] [CharP R 2]

/-- At a root `g` of `P`, `step` is multiplication by `g`. -/
theorem ev_step {g : R} (hg : ev g P = 0) (x : ℕ) : ev g (step n P x) = g * ev g x := by
  unfold step
  split_ifs
  · rw [ev_xor, ev_shiftLeft_one, hg, add_zero]
  · rw [ev_shiftLeft_one]

/-- At a root `g` of `P`, `m` steps of the register multiply by `gᵐ`. -/
theorem ev_iterate_step {g : R} (hg : ev g P = 0) (m x : ℕ) : ev g ((step n P)^[m] x) = g ^ m * ev g x := by
  induction m generalizing x with
  | zero => simp
  | succ m ih => rw [Function.iterate_succ_apply, ih, ev_step hg, pow_succ, mul_assoc]

/-- Modulo `P` the register multiplies by `t`, at any point: `ev t (stepᵐ 1) = tᵐ + ev t P · c`. -/
theorem exists_ev_iterate_step (t : R) (m : ℕ) : ∃ c : R, ev t ((step n P)^[m] 1) = t ^ m + ev t P * c := by
  induction m with
  | zero => exact ⟨0, by simp [ev_one]⟩
  | succ m ih =>
    obtain ⟨c, hc⟩ := ih
    rw [Function.iterate_succ_apply']
    generalize (step n P)^[m] 1 = y at hc ⊢
    unfold step
    split_ifs
    · exact ⟨t * c + 1, by rw [ev_xor, ev_shiftLeft_one, hc]; ring⟩
    · exact ⟨t * c, by rw [ev_shiftLeft_one, hc]; ring⟩

end CharTwo

/-! ### A root of `P` in every field of `2ⁿ` elements -/

/-- A field of `2ⁿ` elements has characteristic 2. -/
theorem charP_two_of_card {k : Type*} [Field k] [Fintype k] (hk : Fintype.card k = 2 ^ n) : CharP k 2 := by
  haveI : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  exact charP_of_card_eq_prime_pow hk

open Polynomial in
/-- **`P` has a root in every field of `2ⁿ` elements.** The orbit closes, so in `k[x]` `1 = x^(2ⁿ−1) + P·c`
(`exists_ev_iterate_step` at `t = x`): `P` divides `x^|k| − x`, which splits in `k`. No cofactor certificate. -/
theorem exists_root (hP : IsPrimitiveCode n P) {k : Type*} [Field k] [Fintype k] (hk : Fintype.card k = 2 ^ n) :
    ∃ g : k, ev g P = 0 := by
  classical
  haveI := charP_two_of_card hk
  obtain ⟨c, hc⟩ := exists_ev_iterate_step (n := n) (P := P) (X : k[X]) (2 ^ n - 1)
  rw [hP.period, ev_one] at hc
  have hdvd : ev (X : k[X]) P ∣ X ^ Fintype.card k - X := by
    refine ⟨-(X * c), ?_⟩
    have h1 := hP.one_le
    rw [show Fintype.card k = (2 ^ n - 1) + 1 by omega, pow_succ]
    linear_combination (-X) * hc
  have hs : Splits (X ^ Fintype.card k - X : k[X]) := by
    rw [splits_iff_card_roots, FiniteField.roots_X_pow_card_sub_X,
      FiniteField.X_pow_card_sub_X_natDegree_eq k Fintype.one_lt_card, ← Finset.card_def, Finset.card_univ]
  have hdeg : degree (ev (X : k[X]) P) ≠ 0 := by
    intro h
    have h1 := coeff_ev_X (R := k) P n
    rw [hP.testBit_deg, if_pos rfl,
      coeff_eq_zero_of_natDegree_lt (by rw [natDegree_eq_zero_iff_degree_le_zero.mpr h.le]; exact hP.pos)] at h1
    exact zero_ne_one h1
  obtain ⟨g, hg⟩ :=
    (hs.of_dvd (FiniteField.X_pow_card_sub_X_ne_zero k Fintype.one_lt_card) hdvd).exists_eval_eq_zero hdeg
  refine ⟨g, ?_⟩
  have h := map_ev (X : k[X]) (evalRingHom g) P
  rw [coe_evalRingHom, eval_X] at h
  rw [← h]
  exact hg

/-! ### The field: the codes below `2ⁿ` are its elements, the register's states are the powers of `g` -/

section Field

variable {k : Type*} [Field k] [CharP k 2] {g : k}

/-- A root of `P` has `g ^ (2ⁿ − 1) = 1`: the register closes. -/
theorem root_pow_eq_one (hP : IsPrimitiveCode n P) (hg : ev g P = 0) : g ^ (2 ^ n - 1) = 1 := by
  have h := ev_iterate_step (n := n) hg (2 ^ n - 1) 1
  rw [hP.period, ev_one, mul_one] at h
  exact h.symm

/-- A non-zero code below `2ⁿ` has a non-zero value at a root of `P`: it is a state, whose value is a power of `g`. -/
theorem ev_ne_zero (hP : IsPrimitiveCode n P) (hg : ev g P = 0) {m : ℕ} (hm : m < 2 ^ n) (h0 : m ≠ 0) :
    ev g m ≠ 0 := by
  have hg0 : g ≠ 0 := by
    rintro rfl
    have h := root_pow_eq_one hP (g := (0 : k)) hg
    rw [zero_pow (by have := hP.one_le; omega)] at h
    exact zero_ne_one h
  obtain ⟨j, -, rfl⟩ := exists_iterate_step_eq hP hm h0
  rw [ev_iterate_step hg, ev_one, mul_one]
  exact pow_ne_zero _ hg0

/-- The codes below `2ⁿ` have distinct values at a root of `P`: `1, g, …, gⁿ⁻¹` are independent over `𝔽₂`. -/
theorem ev_inj (hP : IsPrimitiveCode n P) (hg : ev g P = 0) {a b : ℕ} (ha : a < 2 ^ n) (hb : b < 2 ^ n)
    (h : ev g a = ev g b) : a = b := by
  by_contra hne
  refine ev_ne_zero hP hg (Nat.xor_lt_two_pow ha hb) (fun h0 => hne (Nat.xor_eq_zero_iff.mp h0)) ?_
  rw [ev_xor, h, CharTwo.add_self_eq_zero]

/-- The powers `gʲ`, `j < 2ⁿ − 1`, of a root of `P` are distinct. -/
theorem root_pow_inj (hP : IsPrimitiveCode n P) (hg : ev g P = 0) {i j : ℕ} (hi : i < 2 ^ n - 1) (hj : j < 2 ^ n - 1)
    (h : g ^ i = g ^ j) : i = j := by
  refine iterate_step_injOn hP hi hj (ev_inj hP hg (iterate_step_lt hP i) (iterate_step_lt hP j) ?_)
  rw [ev_iterate_step hg, ev_iterate_step hg, ev_one, mul_one, mul_one, h]

/-- Every element of a field of `2ⁿ` elements is the value at a root of `P` of a code below `2ⁿ`. -/
theorem exists_code (hP : IsPrimitiveCode n P) [Fintype k] (hk : Fintype.card k = 2 ^ n) (hg : ev g P = 0) (x : k) :
    ∃ m < 2 ^ n, ev g m = x := by
  have hinj : Function.Injective fun m : Fin (2 ^ n) => ev g (m : ℕ) := fun a b h => Fin.ext (ev_inj hP hg a.2 b.2 h)
  have hbij := (Fintype.bijective_iff_injective_and_card _).mpr ⟨hinj, by rw [Fintype.card_fin, hk]⟩
  obtain ⟨m, hm⟩ := hbij.2 x
  exact ⟨m, m.2, hm⟩

/-- **The code map**: `x ↦` its code is additive (`+` to `^^^`), and the code of `gᵐ` is the register's `m`-th state. -/
theorem exists_code_fun (hP : IsPrimitiveCode n P) [Fintype k] (hk : Fintype.card k = 2 ^ n) (hg : ev g P = 0) :
    ∃ c : k → ℕ, (∀ x, c x < 2 ^ n) ∧ (∀ x y, c (x + y) = c x ^^^ c y) ∧ ∀ m, c (g ^ m) = (step n P)^[m] 1 := by
  choose c hc_lt hc using exists_code hP hk hg
  have hc_ev : ∀ {m}, m < 2 ^ n → c (ev g m) = m := fun hm => ev_inj hP hg (hc_lt _) hm (hc _)
  refine ⟨c, hc_lt, fun x y => ev_inj hP hg (hc_lt _) (Nat.xor_lt_two_pow (hc_lt x) (hc_lt y))
    (by rw [hc, ev_xor, hc, hc]), fun m => ?_⟩
  have h := hc_ev (iterate_step_lt hP m)
  rwa [ev_iterate_step hg, ev_one, mul_one] at h

/-- Every non-zero element is a power `gʲ`, `j < 2ⁿ − 1`: a root of `P` generates the multiplicative group. -/
theorem exists_root_pow_eq (hP : IsPrimitiveCode n P) [Fintype k] (hk : Fintype.card k = 2 ^ n) (hg : ev g P = 0)
    {x : k} (hx : x ≠ 0) : ∃ j < 2 ^ n - 1, g ^ j = x := by
  obtain ⟨m, hm, rfl⟩ := exists_code hP hk hg x
  have h0 : m ≠ 0 := by
    rintro rfl
    exact hx (ev_zero g)
  obtain ⟨j, hj, rfl⟩ := exists_iterate_step_eq hP hm h0
  exact ⟨j, hj, by rw [ev_iterate_step hg, ev_one, mul_one]⟩

/-- `Q² = 2ⁿ` with `n ≥ 1` gives `Q ≥ 2` and `(Q − 1)(Q + 1) = 2ⁿ − 1`. -/
theorem sq_facts (hP : IsPrimitiveCode n P) {Q : ℕ} (hQ : Q ^ 2 = 2 ^ n) : 2 ≤ Q ∧ (Q - 1) * (Q + 1) = 2 ^ n - 1 := by
  have h2 : 2 ≤ 2 ^ n := Nat.le_self_pow hP.pos.ne' 2
  have hQ2 : 2 ≤ Q := by
    by_contra h
    interval_cases Q <;> simp_all
  refine ⟨hQ2, ?_⟩
  obtain ⟨m, rfl⟩ : ∃ m, Q = m + 1 := ⟨Q - 1, by omega⟩
  rw [← hQ, Nat.add_sub_cancel]
  exact (Nat.sub_eq_of_eq_add (by ring)).symm

/-- **The norm-one set is the `Q + 1` powers of `g ^ (Q − 1)`**, `Q² = 2ⁿ`. -/
theorem normOne_eq_image (hP : IsPrimitiveCode n P) [Fintype k] [DecidableEq k] {Q : ℕ} (hQ : Q ^ 2 = 2 ^ n)
    (hk : Fintype.card k = Q ^ 2) (hg : ev g P = 0) :
    univ.filter (fun u : k => u ^ (Q + 1) = 1) = (range (Q + 1)).image fun j => g ^ ((Q - 1) * j) := by
  obtain ⟨hQ2, hQN⟩ := sq_facts hP hQ
  symm
  refine eq_of_subset_of_card_le ?_ ?_
  · intro u hu
    obtain ⟨j, -, rfl⟩ := mem_image.mp hu
    have h1 : (g ^ ((Q - 1) * j)) ^ (Q + 1) = 1 := by
      rw [← pow_mul, show (Q - 1) * j * (Q + 1) = (Q - 1) * (Q + 1) * j by ring, hQN, pow_mul,
        root_pow_eq_one hP hg, one_pow]
    exact mem_filter.mpr ⟨mem_univ _, h1⟩
  · rw [StandingFive.card_normOne hk, card_image_of_injOn, card_range]
    intro j hj j' hj' h
    have hj := mem_range.mp (mem_coe.mp hj)
    have hj' := mem_range.mp (mem_coe.mp hj')
    have hlt : ∀ i, i < Q + 1 → (Q - 1) * i < 2 ^ n - 1 := fun i hi => by
      rw [← hQN]
      exact Nat.mul_lt_mul_of_pos_left hi (by omega)
    have := root_pow_inj hP hg (hlt j hj) (hlt j' hj') h
    exact Nat.eq_of_mul_eq_mul_left (by omega) this

/-- **The coordinate-0 character**: `x ↦ (−1)^(bit 0 of the code of x)` is a non-trivial additive character, and at
`gᵐ` it reads the low bit of the register's `m`-th state. -/
theorem exists_addChar (hP : IsPrimitiveCode n P) [Fintype k] (hk : Fintype.card k = 2 ^ n) (hg : ev g P = 0) :
    ∃ ψ₀ : AddChar k ℂ, ψ₀ ≠ 1 ∧ ∀ m, ψ₀ (g ^ m) = 1 - 2 * (((step n P)^[m] 1 % 2 : ℕ) : ℂ) := by
  obtain ⟨c, -, hadd, hpow⟩ := exists_code_fun hP hk hg
  have hpm1 : ∀ m : ℕ, (-1 : ℂ) ^ m = 1 - 2 * ((m % 2 : ℕ) : ℂ) := by
    intro m
    rw [neg_one_pow_eq_pow_mod_two]
    rcases Nat.mod_two_eq_zero_or_one m with h | h <;> rw [h] <;> norm_num
  have hc0 : c 0 = 0 := by
    have h := hadd 0 0
    rwa [add_zero, Nat.xor_self] at h
  have hc1 : c 1 = 1 := by simpa using hpow 0
  refine ⟨⟨fun x => (-1) ^ c x, ?_, ?_⟩, ?_, ?_⟩
  · show (-1 : ℂ) ^ c 0 = 1
    rw [hc0, pow_zero]
  · intro x y
    show (-1 : ℂ) ^ c (x + y) = (-1) ^ c x * (-1) ^ c y
    rw [hadd, neg_one_pow_eq_pow_mod_two, Nat.xor_mod_two_eq, ← neg_one_pow_eq_pow_mod_two, pow_add]
  · intro h
    have h1 : (-1 : ℂ) ^ c 1 = 1 := DFunLike.congr_fun h 1
    rw [hc1] at h1
    norm_num at h1
  · intro m
    show (-1 : ℂ) ^ c (g ^ m) = _
    rw [hpow, hpm1]

end Field

/-! ### The spectrum from the class counts -/

/-- **The character sums of `μ_{Q+1}` from the class counts.** In a field of `Q² = 2ⁿ` elements, if every class
`r < Q − 1` of the register's bit-0 sequence has at most `B` ones among the indices `(Q − 1)j + r`, `j ≤ Q`, then every
non-trivial additive character sums to real part at least `Q + 1 − 2B` over `μ_{Q+1}`: every such character is
`ψ₀(gⁱ ·)`, and `Σ_{u ∈ μ} ψ₀(gⁱu) = Σ_{j ≤ Q} (1 − 2·s((Q − 1)j + i mod (Q − 1)))` (`Floor128.charSum_128_ge`'s argument,
for any primitive `P`). -/
theorem charSum_ge_of_classes (hP : IsPrimitiveCode n P) {Q B : ℕ} (hQ : Q ^ 2 = 2 ^ n)
    (hB : ∀ r < Q - 1, ∑ j ∈ range (Q + 1), (step n P)^[(Q - 1) * j + r] 1 % 2 ≤ B)
    {k : Type*} [Field k] [Fintype k] [DecidableEq k] (hk : Fintype.card k = Q ^ 2) (ψ : AddChar k ℂ) (hψ : ψ ≠ 1) :
    ((Q : ℝ) + 1) - 2 * B ≤ (∑ u ∈ univ.filter (fun u : k => u ^ (Q + 1) = 1), ψ u).re := by
  have hk' : Fintype.card k = 2 ^ n := hk.trans hQ
  haveI := charP_two_of_card hk'
  obtain ⟨hQ2, hQN⟩ := sq_facts hP hQ
  obtain ⟨g, hg⟩ := exists_root hP hk'
  obtain ⟨ψ₀, hψ₀, hval⟩ := exists_addChar hP hk' hg
  obtain ⟨a, rfl⟩ := StandingFive.exists_mulShift_eq ψ₀ hψ₀ ψ
  have ha : a ≠ 0 := by
    rintro rfl
    exact hψ (AddChar.mulShift_zero ψ₀)
  obtain ⟨i, -, rfl⟩ := exists_root_pow_eq hP hk' hg ha
  -- `g ^ i = g ^ (i % (Q − 1)) · v`, `v = g ^ ((Q − 1)(i / (Q − 1)))` in the norm-one set, which `v ·` permutes
  have hv : (g ^ ((Q - 1) * (i / (Q - 1)))) ^ (Q + 1) = 1 := by
    rw [← pow_mul, show (Q - 1) * (i / (Q - 1)) * (Q + 1) = (Q - 1) * (Q + 1) * (i / (Q - 1)) by ring, hQN, pow_mul,
      root_pow_eq_one hP hg, one_pow]
  have hv0 : g ^ ((Q - 1) * (i / (Q - 1))) ≠ 0 := by
    intro h
    rw [h, zero_pow (by omega)] at hv
    exact zero_ne_one hv
  have hsum : ∑ u ∈ univ.filter (fun u : k => u ^ (Q + 1) = 1), ψ₀.mulShift (g ^ i) u
      = ∑ j ∈ range (Q + 1), (1 - 2 * (((step n P)^[(Q - 1) * j + i % (Q - 1)] 1 % 2 : ℕ) : ℂ)) := by
    calc ∑ u ∈ univ.filter (fun u : k => u ^ (Q + 1) = 1), ψ₀.mulShift (g ^ i) u
        = ∑ u ∈ univ.filter (fun u : k => u ^ (Q + 1) = 1), ψ₀ (g ^ (i % (Q - 1)) * u) := by
          refine Finset.sum_equiv (Equiv.mulLeft₀ _ hv0) (fun u => ?_) (fun u _ => ?_)
          · simp only [mem_filter, mem_univ, true_and, Equiv.mulLeft₀_apply, mul_pow, hv, one_mul]
          · rw [AddChar.mulShift_apply, Equiv.mulLeft₀_apply, ← mul_assoc, ← pow_add, Nat.mod_add_div]
      _ = ∑ j ∈ range (Q + 1), ψ₀ (g ^ (i % (Q - 1)) * g ^ ((Q - 1) * j)) := by
          rw [normOne_eq_image hP hQ hk hg, Finset.sum_image]
          intro j hj j' hj' h
          have hj := mem_range.mp hj
          have hj' := mem_range.mp hj'
          have hlt : ∀ i, i < Q + 1 → (Q - 1) * i < 2 ^ n - 1 := fun i hi => by
            rw [← hQN]
            exact Nat.mul_lt_mul_of_pos_left hi (by omega)
          exact Nat.eq_of_mul_eq_mul_left (by omega) (root_pow_inj hP hg (hlt j hj) (hlt j' hj') h)
      _ = ∑ j ∈ range (Q + 1), (1 - 2 * (((step n P)^[(Q - 1) * j + i % (Q - 1)] 1 % 2 : ℕ) : ℂ)) := by
          refine Finset.sum_congr rfl fun j _ => ?_
          rw [← pow_add, add_comm, hval]
  have hle := hB (i % (Q - 1)) (Nat.mod_lt i (by omega))
  have hle' : ((∑ j ∈ range (Q + 1), (step n P)^[(Q - 1) * j + i % (Q - 1)] 1 % 2 : ℕ) : ℝ) ≤ B := by
    exact_mod_cast hle
  rw [hsum, Finset.sum_sub_distrib, Finset.sum_const, card_range, ← Finset.mul_sum, ← Nat.cast_sum]
  simp only [nsmul_eq_mul, mul_one, Complex.sub_re, Complex.mul_re, Complex.natCast_re, Complex.natCast_im,
    Complex.re_ofNat, Complex.im_ofNat, zero_mul, sub_zero]
  push_cast at hle' ⊢
  linarith

/-! ### The class counts from one pass of the register -/

/-- One pass of the register: from the state `x` at class index `i < d`, over `fuel` steps, adding the coordinate-0 bit of
each state into the `i`-th packed 8-bit counter (the index advancing modulo `d`). Returns the last state and the
counters. (`Floor128.pass` is this at `n = 14`, `d = 127`.) -/
def pass (n P d : ℕ) : ℕ → ℕ → ℕ → ℕ → ℕ × ℕ
  | 0, x, _, acc => (x, acc)
  | fuel + 1, x, i, acc =>
    pass n P d fuel (step n P x) (if i = d - 1 then 0 else i + 1) (acc + ((x &&& 1) <<< (8 * i)))

/-- The counters after `fuel` steps of `pass`: the low bit of each state, added at the position of its index mod `d`. -/
theorem pass_snd (d : ℕ) (fuel x i acc : ℕ) (hi : i < d) :
    (pass n P d fuel x i acc).2 = acc + ∑ m ∈ range fuel, (step n P)^[m] x % 2 * 2 ^ (8 * ((i + m) % d)) := by
  induction fuel generalizing x i acc with
  | zero => simp [pass]
  | succ fuel ih =>
    have hi' : (if i = d - 1 then 0 else i + 1) < d := by split_ifs <;> omega
    have hmod : ∀ m, ((if i = d - 1 then 0 else i + 1) + m) % d = (i + (m + 1)) % d := by
      intro m
      split_ifs with h
      · rw [show i + (m + 1) = m + d by omega, Nat.add_mod_right, zero_add]
      · rw [show i + 1 + m = i + (m + 1) by omega]
    rw [pass, ih _ _ _ hi', Finset.sum_range_succ', Nat.and_one_is_mod, Nat.shiftLeft_eq]
    simp only [Function.iterate_succ_apply, hmod, Function.iterate_zero, id, add_zero, Nat.mod_eq_of_lt hi]
    ring

/-- **The counters are the classes**, for a pass of `d·b` steps from any state `x`: the `r`-th packed counter is the
number of `j < b` with the low bit of the state `d·j + r` set. (Stated with `x` and `b` free, as `Floor128.pass_class`.) -/
theorem pass_class (d x b : ℕ) (hb : b < 256) (r : ℕ) (hr : r < d) :
    (pass n P d (d * b) x 0 0).2 / 2 ^ (8 * r) % 256 = ∑ j ∈ range b, (step n P)^[d * j + r] x % 2 := by
  have hc : (pass n P d (d * b) x 0 0).2 =
      ∑ r ∈ range d, (∑ j ∈ range b, (step n P)^[d * j + r] x % 2) * 256 ^ r := by
    rw [pass_snd _ _ _ _ _ (by omega), zero_add, sum_range_mul_eq]
    refine Finset.sum_congr rfl fun r hr => ?_
    rw [Finset.sum_mul]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [zero_add, Nat.mul_add_mod, Nat.mod_eq_of_lt (mem_range.mp hr), pow_mul]
    norm_num
  have hd : ∀ r, (∑ j ∈ range b, (step n P)^[d * j + r] x % 2) < 256 := by
    intro r
    calc ∑ j ∈ range b, (step n P)^[d * j + r] x % 2 ≤ ∑ _j ∈ range b, 1 :=
          Finset.sum_le_sum fun j _ => Nat.le_of_lt_succ (Nat.mod_lt _ two_pos)
      _ = b := by simp
      _ < 256 := hb
  rw [hc, pow_mul, show (2 : ℕ) ^ 8 = 256 from rfl]
  exact digit_sum _ hd d r hr

/-! ### Four-colourings by two coordinate functionals -/

/-- **The colouring check**: every `u = g^((Q−1)j)`, `j ≤ Q`, of `μ_{Q+1}` has `L₀(g^{e₁}u) = 1` or `L₀(g^{e₂}u) = 1`
(`L₀` the coordinate-0 functional, read as bit 0 of the register's state). -/
def colourCheck (n P Q e₁ e₂ : ℕ) : Bool :=
  (List.range (Q + 1)).all fun j =>
    (step n P)^[e₁ + (Q - 1) * j] 1 % 2 == 1 || (step n P)^[e₂ + (Q - 1) * j] 1 % 2 == 1

/-- **A four-colouring of `Cay(k, μ_{Q+1})` from two functionals.** In a field of `Q² = 2ⁿ` elements, if `colourCheck`
passes, `x ↦ (L₀(g^{e₁}x), L₀(g^{e₂}x))` is a proper colouring with four colours: an edge `x ~ y` has `x − y = x + y ∈
μ_{Q+1}`, and the two functionals are additive, so equal colours would give `L₀(g^{e₁}u) = L₀(g^{e₂}u) = 0`. -/
theorem colorable_four_of_check (hP : IsPrimitiveCode n P) {Q e₁ e₂ : ℕ} (hQ : Q ^ 2 = 2 ^ n)
    (hc : colourCheck n P Q e₁ e₂ = true) (k : Type*) [Field k] [Fintype k] (hk : Fintype.card k = Q ^ 2) :
    (SimpleGraph.fromRel fun x y : k => (x - y) ^ (Q + 1) = 1).Colorable 4 := by
  classical
  have hk' : Fintype.card k = 2 ^ n := hk.trans hQ
  haveI := charP_two_of_card hk'
  obtain ⟨g, hg⟩ := exists_root hP hk'
  obtain ⟨c, -, hadd, hpow⟩ := exists_code_fun hP hk' hg
  let col : k → Bool × Bool := fun x => (decide (c (g ^ e₁ * x) % 2 = 1), decide (c (g ^ e₂ * x) % 2 = 1))
  have hcol : ∀ x y : k, (x - y) ^ (Q + 1) = 1 → col x ≠ col y := by
    intro x y hxy hcxy
    have hmem : x - y ∈ univ.filter (fun u : k => u ^ (Q + 1) = 1) := mem_filter.mpr ⟨mem_univ _, hxy⟩
    rw [normOne_eq_image hP hQ hk hg] at hmem
    obtain ⟨j, hj, hj'⟩ := mem_image.mp hmem
    have h := (List.all_eq_true.mp hc) j (List.mem_range.mpr (mem_range.mp hj))
    have key : ∀ e, (step n P)^[e + (Q - 1) * j] 1 % 2 = (c (g ^ e * x) + c (g ^ e * y)) % 2 := by
      intro e
      rw [← hpow, pow_add, hj', CharTwo.sub_eq_add, mul_add, hadd, Nat.xor_mod_two_eq]
    simp only [col, Prod.mk.injEq, decide_eq_decide] at hcxy
    rw [Bool.or_eq_true, beq_iff_eq, beq_iff_eq, key, key] at h
    omega
  have hC := (SimpleGraph.Coloring.mk col fun {x y} hadj => by
    rw [SimpleGraph.fromRel_adj] at hadj
    rcases hadj.2 with h | h
    · exact hcol x y h
    · exact (hcol y x h).symm).colorable
  exact hC

/-! ## Spec -/

-- `step` multiplies by `x` and reduces by `P`: at `x² + x + 1` (code 7), `x · x = x²` reduces to `x + 1` (code 3).
example : step 2 7 2 = 3 := by decide
example : step 2 7 1 = 2 := by decide
-- `orbitOk` checks the first return: the orbit of 1 under `x² + x + 1` is `1, 2, 3, 1`.
example : orbitOk 2 7 2 2 = true := by decide
example : orbitOk 2 7 1 2 = false := by decide
-- the model of `IsPrimitiveCode`: `x² + x + 1` is primitive; `x² + 1` (code 5) is not (`x² = 1`), nor is `x⁴ + x³ +
-- x² + x + 1` (code 31; `x⁵ = 1`, order 5 < 15) — the check refuses an irreducible polynomial that is not primitive.
example : IsPrimitiveCode 2 7 := isPrimitiveCode_of_check (by decide)
example : primCheck 2 5 = false := by decide
example : primCheck 4 31 = false := by decide
-- `pass` with no fuel returns its state and counters unchanged; one step adds the low bit of the state at the index.
example : pass 2 7 3 0 5 1 7 = (5, 7) := rfl
example : pass 2 7 3 1 5 1 0 = (step 2 7 5, 256) := by decide
-- `colourCheck` at `Q = 2` (`𝔽₄`, `μ₃ = 𝔽₄ˣ`): the functionals `L₀` and `L₀(g ·)` avoid `μ₃` (every non-zero element of
-- `𝔽₄` has a non-zero coordinate in the basis `1, g`), and `L₀` alone does not (`L₀(g) = 0`).
example : colourCheck 2 7 2 0 1 = true := by decide
example : colourCheck 2 7 2 0 0 = false := by decide

end HadwigerNelson.BinaryField
