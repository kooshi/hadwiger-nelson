import Proofs.HadwigerNelson.Arith.FibreCert3
import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Positivity
import Mathlib.Algebra.Order.BigOperators.GroupWithZero.List

/-!
# What an accepted fibre-density certificate proves (FS131-KC13 typed it; FS131-IKC1 proves it)

**Read aloud, against FS-66's `SOUNDNESS.md` § 0 and L4.** `sum_le_of_certOK`: if `certOK C = true`, then every
`φ : (ℤ/p)² → [0, 1]` with `q(φ) ≥ 0` has `Σ φ ≤ U_num / L`. Here
`q(φ) = 2·Σ_x φ_x (1 − φ_x) − Σ_x Σ_{s ∈ S} φ_x φ_{x+s}` and `S = {a² + b² = 1}`. It is the polynomial statement only.
L1 and L2, which carry it to every level of the tower, are leaves of their own (`plans/FS131-KC13-certificates.md`
§ Stage 5). `p` need not be prime: the averaging argument uses only that `z ↦ s z + t` and `z ↦ s z̄ + t` with
`N(s) = 1` are bijections of `(ℤ/p)²` preserving `S`.

`card_le_of_certOK` is level one: an independent set of `Cay((ℤ/p)², S)` has at most `U_num / L` points (`φ` its
indicator, `q(φ) = 0`).

**The proof** (`plans/FS131-IKC1-implementation.md`). The symmetrised moment `Y(m) = Σ_γ Π_{x ∈ m} φ(γ x)`, summed over
the maps `γ = (z ↦ s·z̄^e + t)` (`N(s) = 1`), is invariant under those maps and under permutation. The kernel's check
gives `Σ_ops v·Y(mono) = 0` (every op in one checked segment, every slot balanced, every key a multiset); the ops'
families give `−U_num·G + L·G·Σφ` plus non-negative terms (positive definiteness, `q(φ) ≥ 0`, box products).

**Model.** `model`: the hypotheses hold together at `cert3` (`cert3_ok`) with `φ = 0`. Every clause is satisfiable there;
`φ = 0` is a point of the region, and the conclusion `0 ≤ U` is then true.
-/

namespace HadwigerNelson.FibreCertSound

open HadwigerNelson.FibreCert

/-- The plane `(ℤ/p)²`. -/
abbrev V (p : ℕ) := ZMod p × ZMod p

/-- The unit circle `{(a, b) : a² + b² = 1}`. -/
def unitCircle (p : ℕ) [NeZero p] : Finset (V p) := Finset.univ.filter fun x => x.1 ^ 2 + x.2 ^ 2 = 1

/-- FS-66's quadratic `q(φ) = 2·Σ_x φ_x (1 − φ_x) − Σ_x Σ_{s ∈ S} φ_x φ_{x+s}` (`SOUNDNESS.md` § 0). -/
noncomputable def qform (p : ℕ) [NeZero p] (φ : V p → ℝ) : ℝ :=
  2 * ∑ x, φ x * (1 - φ x) - ∑ x, ∑ s ∈ unitCircle p, φ x * φ (x + s)

/-! ### Packed arithmetic: one digit lemma -/

private theorem lowBits_eq (x k : ℕ) : lowBits x k = x % 2 ^ k := by
  unfold lowBits
  rw [show Nat.sub (Nat.shiftLeft 1 k) 1 = 2 ^ k - 1 by simp [Nat.shiftLeft_eq]]
  exact Nat.and_two_pow_sub_one_eq_mod x k

private theorem digit_eq (x w e : ℕ) : digit x w e = x / (2 ^ w) ^ e % 2 ^ w := by
  simp [digit, lowBits_eq, Nat.shiftRight_eq_div_pow, ← pow_mul]

private theorem sum_lt_pow (B : ℕ) (c : ℕ → ℕ) (K : ℕ) (hc : ∀ i < K, c i < B) :
    ∑ i ∈ Finset.range K, c i * B ^ i < B ^ K := by
  induction K with
  | zero => simp
  | succ K ih =>
    rw [Finset.sum_range_succ, pow_succ]
    have h1 := ih fun i hi => hc i (by omega)
    have h2 : c K + 1 ≤ B := hc K (by omega)
    nlinarith [Nat.zero_le (B ^ K)]

/-- **The digit lemma**: digit `e` of `Σ_{i<K} c_i B^i` is `c_e` when every `c_i < B`. -/
private theorem sum_digit (B : ℕ) (c : ℕ → ℕ) (K : ℕ) (hc : ∀ i < K, c i < B) (e : ℕ) (he : e < K) :
    (∑ i ∈ Finset.range K, c i * B ^ i) / B ^ e % B = c e := by
  have hB : 0 < B := lt_of_le_of_lt (Nat.zero_le _) (hc e he)
  obtain ⟨k, rfl⟩ : ∃ k, K = e + 1 + k := ⟨K - (e + 1), by omega⟩
  induction k with
  | zero =>
    rw [Nat.add_zero, Finset.sum_range_succ]
    have hl := sum_lt_pow B c e fun i hi => hc i (by omega)
    rw [Nat.add_mul_div_right _ _ (pow_pos hB e), Nat.div_eq_of_lt hl, zero_add, Nat.mod_eq_of_lt (hc e (by omega))]
  | succ k ih =>
    rw [show e + 1 + (k + 1) = (e + 1 + k) + 1 by omega, Finset.sum_range_succ,
      show B ^ (e + 1 + k) = B ^ e * (B * B ^ k) by rw [← pow_succ', ← pow_add]; ring_nf]
    rw [show c (e + 1 + k) * (B ^ e * (B * B ^ k)) = (c (e + 1 + k) * (B * B ^ k)) * B ^ e by ring,
      Nat.add_mul_div_right _ _ (pow_pos hB e), show c (e + 1 + k) * (B * B ^ k) = (c (e + 1 + k) * B ^ k) * B by ring,
      Nat.add_mul_mod_self_right]
    exact ih (fun i hi => hc i (by omega)) (by omega)

private theorem lsum_range {M : Type*} [AddCommMonoid M] (f : ℕ → M) (n : ℕ) :
    ((List.range n).map f).sum = ∑ i ∈ Finset.range n, f i := by
  induction n with
  | zero => simp
  | succ n ih => rw [List.range_succ, List.map_append, List.sum_append, ih, Finset.sum_range_succ]; simp

/-! ### Bag keys: the base-8 digits of `Σ 8^x` are the multiplicities -/

private theorem shl_one (k : ℕ) : Nat.shiftLeft 1 k = 2 ^ k := by
  rw [show Nat.shiftLeft 1 k = 1 <<< k from rfl, Nat.one_shiftLeft]

private theorem bag_eq (l : List ℕ) : bag l = (l.map fun x => 8 ^ x).sum := by
  suffices ∀ a, l.foldl (fun a x => Nat.add a (Nat.shiftLeft 1 (Nat.mul 3 x))) a = a + (l.map fun x => 8 ^ x).sum by
    exact (this 0).trans (zero_add _)
  induction l with
  | nil => simp
  | cons x l ih =>
    intro a
    rw [List.foldl_cons, ih, List.map_cons, List.sum_cons, shl_one, Nat.mul_eq, Nat.add_eq, pow_mul]
    norm_num [add_assoc]

/-- The multiset a key names, read off its base-8 digits below `n`. -/
private def dec (n K : ℕ) : List ℕ := (List.range n).flatMap fun x => List.replicate (K / 8 ^ x % 8) x

private theorem bag_eq_sum (n : ℕ) (l : List ℕ) (hx : ∀ x ∈ l, x < n) :
    bag l = ∑ x ∈ Finset.range n, l.count x * 8 ^ x := by
  classical
  rw [bag_eq, Finset.sum_list_map_count]
  refine Finset.sum_subset (fun x hx' => Finset.mem_range.2 (hx x (List.mem_toFinset.1 hx'))) ?_
  intro x _ hx'
  simp [List.count_eq_zero_of_not_mem (fun h => hx' (List.mem_toFinset.2 h))]

/-- **A key names its multiset**: at most seven points, every one below `n`. -/
private theorem dec_bag (n : ℕ) (l : List ℕ) (hl : l.length < 8) (hx : ∀ x ∈ l, x < n) :
    (dec n (bag l)).Perm l := by
  classical
  rw [List.perm_iff_count]
  intro y
  have hd : ∀ x < n, bag l / 8 ^ x % 8 = l.count x := fun x hx' => by
    rw [bag_eq_sum n l hx]
    exact sum_digit 8 (fun x => l.count x) n (fun i _ => lt_of_le_of_lt List.count_le_length hl) x hx'
  simp only [dec, List.count_flatMap, Function.comp_def, List.count_replicate, beq_iff_eq]
  rw [lsum_range, Finset.sum_ite_eq']
  by_cases hy : y < n
  · simp [hy, hd y hy]
  · simp only [Finset.mem_range, hy, if_false]
    exact (List.count_eq_zero_of_not_mem fun h => hy (hx y h)).symm

/-! ### The symmetrised moments -/

/-- The point coded `x = a·p + b`. -/
private def pt (p x : ℕ) : V p := (((x / p : ℕ) : ZMod p), ((x % p : ℕ) : ZMod p))

/-- Multiplication in `(ℤ/p)[i]`. -/
private def cmul {p : ℕ} (a b : V p) : V p := (a.1 * b.1 - a.2 * b.2, a.1 * b.2 + a.2 * b.1)

/-- Conjugation, when `e`. -/
private def cj {p : ℕ} (e : Bool) (z : V p) : V p := if e then (z.1, -z.2) else z

/-- The map `z ↦ s·z̄^e + t` of `γ = (t, s, e)`. -/
private def act {p : ℕ} (γ : V p × V p × Bool) (z : V p) : V p := cmul γ.2.1 (cj γ.2.2 z) + γ.1

/-- The maps averaged over: `t` any point, `s` on the unit circle, `e` either. -/
private def affs (p : ℕ) [NeZero p] : Finset (V p × V p × Bool) := Finset.univ ×ˢ (unitCircle p ×ˢ Finset.univ)

/-- The symmetrised moment of a monomial (a list of codes), unnormalised. -/
private noncomputable def Ym (p : ℕ) [NeZero p] (φ : V p → ℝ) (m : List ℕ) : ℝ :=
  ∑ γ ∈ affs p, (m.map fun x => φ (act γ (pt p x))).prod

/-! ### The maps form a group: composition, inverse, reindexing -/

private theorem cmul_comm {p : ℕ} (a b : V p) : cmul a b = cmul b a := by
  simp only [cmul, Prod.mk.injEq]; constructor <;> ring
private theorem cmul_assoc {p : ℕ} (a b c : V p) : cmul (cmul a b) c = cmul a (cmul b c) := by
  simp only [cmul, Prod.mk.injEq]; constructor <;> ring
private theorem cmul_add {p : ℕ} (a b c : V p) : cmul a (b + c) = cmul a b + cmul a c := by
  simp only [cmul, Prod.fst_add, Prod.snd_add, Prod.mk_add_mk, Prod.mk.injEq]; constructor <;> ring
private theorem cmul_neg {p : ℕ} (a b : V p) : cmul a (-b) = -cmul a b := by
  simp only [cmul, Prod.fst_neg, Prod.snd_neg, Prod.neg_mk, Prod.mk.injEq]; constructor <;> ring
private theorem cmul_one {p : ℕ} (a : V p) : cmul a (1, 0) = a := by simp [cmul]
private theorem one_cmul' {p : ℕ} (a : V p) : cmul (1, 0) a = a := by rw [cmul_comm, cmul_one]
private theorem cj_false {p : ℕ} (a : V p) : cj false a = a := by simp [cj]
private theorem cmul_zero {p : ℕ} (a : V p) : cmul a 0 = 0 := by simp [cmul]
private theorem cj_add {p : ℕ} (e : Bool) (a b : V p) : cj e (a + b) = cj e a + cj e b := by
  cases e <;> simp [cj, add_comm]
private theorem cj_neg {p : ℕ} (e : Bool) (a : V p) : cj e (-a) = -cj e a := by cases e <;> simp [cj]
private theorem cj_cmul {p : ℕ} (e : Bool) (a b : V p) : cj e (cmul a b) = cmul (cj e a) (cj e b) := by
  cases e
  · simp [cj]
  · simp only [cj, cmul, Prod.mk.injEq, if_true]; constructor <;> ring
private theorem cj_cj {p : ℕ} (e e' : Bool) (a : V p) : cj e (cj e' a) = cj (xor e e') a := by
  cases e <;> cases e' <;> simp [cj]
private theorem cj_zero {p : ℕ} (e : Bool) : cj e (0 : V p) = 0 := by cases e <;> simp [cj]
private theorem cj_one {p : ℕ} (e : Bool) : cj e ((1, 0) : V p) = (1, 0) := by cases e <;> simp [cj]
private theorem cmul_cj_self {p : ℕ} (a : V p) : cmul a (cj true a) = (a.1 ^ 2 + a.2 ^ 2, 0) := by
  simp only [cmul, cj, if_true, Prod.mk.injEq]; constructor <;> ring

/-- `γ ∘ δ`. -/
private def comp {p : ℕ} (γ δ : V p × V p × Bool) : V p × V p × Bool :=
  (cmul γ.2.1 (cj γ.2.2 δ.1) + γ.1, cmul γ.2.1 (cj γ.2.2 δ.2.1), xor γ.2.2 δ.2.2)

/-- `δ⁻¹`, for `N(s) = 1`. -/
private def inv {p : ℕ} (δ : V p × V p × Bool) : V p × V p × Bool :=
  (-(cj δ.2.2 (cmul (cj true δ.2.1) δ.1)), cj δ.2.2 (cj true δ.2.1), δ.2.2)

private theorem act_comp {p : ℕ} (γ δ : V p × V p × Bool) (z : V p) : act (comp γ δ) z = act γ (act δ z) := by
  simp only [act, comp, cj_add, cj_cmul, cj_cj, cmul_add, cmul_assoc, add_assoc]

private theorem comp_assoc {p : ℕ} (γ δ ε : V p × V p × Bool) : comp (comp γ δ) ε = comp γ (comp δ ε) := by
  simp only [comp, cj_add, cj_cmul, cj_cj, cmul_add, cmul_assoc, Bool.xor_assoc, add_assoc]

private theorem comp_one {p : ℕ} (γ : V p × V p × Bool) : comp γ (0, (1, 0), false) = γ := by
  simp [comp, cj_zero, cj_one, cmul_zero, cmul_one]

private theorem mem_unitCircle {p : ℕ} [NeZero p] (s : V p) : s ∈ unitCircle p ↔ s.1 ^ 2 + s.2 ^ 2 = 1 := by
  simp [unitCircle]

private theorem mem_affs {p : ℕ} [NeZero p] (γ : V p × V p × Bool) :
    γ ∈ affs p ↔ γ.2.1.1 ^ 2 + γ.2.1.2 ^ 2 = 1 := by
  simp [affs, mem_unitCircle]

private theorem norm_cmul {p : ℕ} (a b : V p) :
    (cmul a b).1 ^ 2 + (cmul a b).2 ^ 2 = (a.1 ^ 2 + a.2 ^ 2) * (b.1 ^ 2 + b.2 ^ 2) := by simp [cmul]; ring
private theorem norm_cj {p : ℕ} (e : Bool) (a : V p) : (cj e a).1 ^ 2 + (cj e a).2 ^ 2 = a.1 ^ 2 + a.2 ^ 2 := by
  cases e <;> simp [cj]

private theorem comp_mem {p : ℕ} [NeZero p] {γ δ : V p × V p × Bool} (hγ : γ ∈ affs p) (hδ : δ ∈ affs p) :
    comp γ δ ∈ affs p := by
  rw [mem_affs] at *; simp only [comp, norm_cmul, norm_cj, hγ, hδ, one_mul]

private theorem inv_mem {p : ℕ} [NeZero p] {δ : V p × V p × Bool} (hδ : δ ∈ affs p) : inv δ ∈ affs p := by
  rw [mem_affs] at *; simp only [inv, norm_cj, hδ]

private theorem comp_inv {p : ℕ} [NeZero p] {δ : V p × V p × Bool} (hδ : δ ∈ affs p) :
    comp δ (inv δ) = (0, (1, 0), false) := by
  rw [mem_affs] at hδ
  have h : cmul δ.2.1 (cj true δ.2.1) = (1, 0) := by rw [cmul_cj_self, hδ]
  simp only [comp, inv, cj_neg, cj_cj, Bool.xor_self, cj_false, cmul_neg, ← cmul_assoc, h, one_cmul',
    neg_add_cancel, ← Bool.xor_assoc, Bool.false_xor]

private theorem inv_comp {p : ℕ} [NeZero p] {δ : V p × V p × Bool} (hδ : δ ∈ affs p) :
    comp (inv δ) δ = (0, (1, 0), false) := by
  rw [mem_affs] at hδ
  have h : cmul (cj true δ.2.1) δ.2.1 = (1, 0) := by rw [cmul_comm, cmul_cj_self, hδ]
  simp only [comp, inv, ← cj_cmul, h, cj_one, add_neg_cancel, Bool.xor_self]

/-- **Reindexing**: precomposing every map with one of them permutes the maps. -/
private theorem sum_affs_comp {p : ℕ} [NeZero p] {δ : V p × V p × Bool} (hδ : δ ∈ affs p)
    (F : (V p × V p × Bool) → ℝ) : ∑ γ ∈ affs p, F (comp γ δ) = ∑ γ ∈ affs p, F γ :=
  Finset.sum_nbij' (fun γ => comp γ δ) (fun γ => comp γ (inv δ)) (fun γ h => comp_mem h hδ)
    (fun γ h => comp_mem h (inv_mem hδ)) (fun γ _ => by rw [comp_assoc, comp_inv hδ, comp_one])
    (fun γ _ => by rw [comp_assoc, inv_comp hδ, comp_one]) (fun _ _ => rfl)

/-- The moment of a monomial of points. -/
private noncomputable def Yv (p : ℕ) [NeZero p] (φ : V p → ℝ) (m : List (V p)) : ℝ :=
  ∑ γ ∈ affs p, (m.map fun z => φ (act γ z)).prod

private theorem Ym_eq (p : ℕ) [NeZero p] (φ : V p → ℝ) (m : List ℕ) : Ym p φ m = Yv p φ (m.map (pt p)) := by
  simp [Ym, Yv, List.map_map, Function.comp_def]

/-- **Invariance**: the moment of the image of a monomial under one of the maps is the moment of the monomial. -/
private theorem Yv_map_act {p : ℕ} [NeZero p] (φ : V p → ℝ) {δ : V p × V p × Bool} (hδ : δ ∈ affs p)
    (m : List (V p)) : Yv p φ (m.map (act δ)) = Yv p φ m := by
  unfold Yv
  conv_rhs => rw [← sum_affs_comp hδ]
  simp [List.map_map, Function.comp_def, act_comp]

private theorem Yv_perm {p : ℕ} [NeZero p] (φ : V p → ℝ) {m m' : List (V p)} (h : m.Perm m') :
    Yv p φ m = Yv p φ m' := by
  unfold Yv; exact Finset.sum_congr rfl fun γ _ => (h.map _).prod_eq

/-! ### Codes and points -/

private theorem nmod (x p : ℕ) : Nat.mod x p = x % p := rfl
private theorem ndiv (x p : ℕ) : Nat.div x p = x / p := rfl

private theorem mkP_div (p a b : ℕ) (hb : b < p) : mkP p a b / p = a := by
  have hp : 0 < p := lt_of_le_of_lt (Nat.zero_le _) hb
  simp only [mkP, Nat.add_eq, Nat.mul_eq]
  rw [add_comm, Nat.add_mul_div_right _ _ hp, Nat.div_eq_of_lt hb, zero_add]

private theorem mkP_mod (p a b : ℕ) (hb : b < p) : mkP p a b % p = b := by
  simp only [mkP, Nat.add_eq, Nat.mul_eq]
  rw [add_comm, Nat.add_mul_mod_self_right, Nat.mod_eq_of_lt hb]

private theorem pt_mkP (p a b : ℕ) (hb : b < p) : pt p (mkP p a b) = ((a : ZMod p), (b : ZMod p)) := by
  simp [pt, mkP_div p a b hb, mkP_mod p a b hb]

private theorem mkP_lt (p a b : ℕ) (ha : a < p) (hb : b < p) : mkP p a b < p * p := by
  simp only [mkP, Nat.add_eq, Nat.mul_eq]; nlinarith

private theorem cast_sub_mod (p y z : ℕ) (hz : z < p) :
    (((Nat.sub (Nat.add y p) z) % p : ℕ) : ZMod p) = (y : ZMod p) - z := by
  rw [ZMod.natCast_mod, Nat.sub_eq, Nat.add_eq, Nat.cast_sub (by omega), Nat.cast_add, ZMod.natCast_self, add_zero]

private theorem pt_subP (p : ℕ) [NeZero p] (x o : ℕ) : pt p (subP p x o) = pt p x - pt p o := by
  have hp : 0 < p := Nat.pos_of_ne_zero (NeZero.ne p)
  unfold subP
  simp only [nmod, ndiv]
  rw [pt_mkP _ _ _ (Nat.mod_lt _ hp), cast_sub_mod _ _ _ (Nat.mod_lt _ hp), cast_sub_mod _ _ _ (Nat.mod_lt _ hp)]
  simp [pt, ZMod.natCast_mod]

private theorem pt_addP (p : ℕ) [NeZero p] (x y : ℕ) : pt p (addP p x y) = pt p x + pt p y := by
  have hp : 0 < p := Nat.pos_of_ne_zero (NeZero.ne p)
  unfold addP
  simp only [nmod, ndiv]
  rw [pt_mkP _ _ _ (Nat.mod_lt _ hp)]
  simp [pt, ZMod.natCast_mod]

private theorem pt_gmap (p : ℕ) [NeZero p] (c d e x : ℕ) (hc : c ≤ p) (hd : d ≤ p) :
    pt p (gmap p c d e x) = cmul ((c : ZMod p), (d : ZMod p)) (cj (!Nat.beq e 0) (pt p x)) := by
  have hp : 0 < p := Nat.pos_of_ne_zero (NeZero.ne p)
  unfold gmap
  simp only [nmod, ndiv]
  cases h : Nat.beq e 0
  · simp only [cond_false, Bool.not_false]
    rw [pt_mkP _ _ _ (Nat.mod_lt _ hp)]
    simp only [pt, cj, cmul, if_true, ZMod.natCast_mod, Nat.add_eq, Nat.mul_eq, Nat.sub_eq, Nat.cast_add,
      Nat.cast_mul, Nat.cast_sub hc, ZMod.natCast_self, Prod.mk.injEq]
    constructor <;> ring
  · simp only [cond_true, Bool.not_true]
    rw [pt_mkP _ _ _ (Nat.mod_lt _ hp)]
    simp only [pt, cj, cmul, Bool.false_eq_true, if_false, ZMod.natCast_mod, Nat.add_eq, Nat.mul_eq, Nat.sub_eq,
      Nat.cast_add, Nat.cast_mul, Nat.cast_sub hd, ZMod.natCast_self, Prod.mk.injEq]
    constructor <;> ring

private theorem gmap_lt (p : ℕ) [NeZero p] (c d e x : ℕ) : gmap p c d e x < p * p := by
  have hp : 0 < p := Nat.pos_of_ne_zero (NeZero.ne p)
  unfold gmap; simp only [nmod, ndiv]; cases Nat.beq e 0 <;> exact mkP_lt _ _ _ (Nat.mod_lt _ hp) (Nat.mod_lt _ hp)

private theorem isUnit_norm (p : ℕ) [NeZero p] (c d : ℕ) (h : isUnit p c d = true) :
    ((c : ZMod p), (d : ZMod p)).1 ^ 2 + ((c : ZMod p), (d : ZMod p)).2 ^ 2 = 1 := by
  simp only [isUnit, Nat.beq_eq, Nat.add_eq, Nat.mul_eq, nmod] at h
  have := congrArg (fun k : ℕ => (k : ZMod p)) h
  simp only [ZMod.natCast_mod, Nat.cast_add, Nat.cast_mul, Nat.cast_one] at this
  simpa [sq] using this

/-- **A witness map is one of the maps averaged over**: `x ↦ g(x − o)`, read on points. -/
private theorem pt_witness (p : ℕ) [NeZero p] (c d e o : ℕ) (hc : c ≤ p) (hd : d ≤ p) (h : isUnit p c d = true) :
    ∃ δ ∈ affs p, ∀ x, pt p (gmap p c d e (subP p x o)) = act δ (pt p x) := by
  refine ⟨(-cmul ((c : ZMod p), (d : ZMod p)) (cj (!Nat.beq e 0) (pt p o)), ((c : ZMod p), (d : ZMod p)),
    !Nat.beq e 0), (mem_affs _).2 (isUnit_norm p c d h), fun x => ?_⟩
  rw [pt_gmap p c d e _ hc hd, pt_subP, act, sub_eq_add_neg, cj_add, cmul_add, cj_neg, cmul_neg]

private theorem Ym_witness (p : ℕ) [NeZero p] (φ : V p → ℝ) (c d e o : ℕ) (hc : c ≤ p) (hd : d ≤ p)
    (h : isUnit p c d = true) (m : List ℕ) : Ym p φ (m.map fun x => gmap p c d e (subP p x o)) = Ym p φ m := by
  obtain ⟨δ, hδ, hw⟩ := pt_witness p c d e o hc hd h
  rw [Ym_eq, Ym_eq, List.map_map, ← Yv_map_act φ hδ (m.map (pt p)), List.map_map]
  congr 1; exact List.map_congr_left fun x _ => hw x

/-- An op's value. -/
private def opVal (o : Op) : ℤ := (o.vp : ℤ) - o.vn

/-- The identity at the moments: the sum of every op's value times its moment. -/
private noncomputable def opSum (p : ℕ) [NeZero p] (φ : V p → ℝ) (l : List Op) : ℝ :=
  (l.map fun o => (opVal o : ℝ) * Ym p φ (o.mono p)).sum

private theorem opSum_append (p : ℕ) [NeZero p] (φ : V p → ℝ) (l l' : List Op) :
    opSum p φ (l ++ l') = opSum p φ l + opSum p φ l' := by
  simp [opSum]

/-! ### The computation half: a segment's fold -/

private theorem getD_modify {α : Type*} (l : List α) (i j : ℕ) (f : α → α) (d : α) (hj : j < l.length) :
    (l.modify i f).getD j d = if i = j then f (l.getD j d) else l.getD j d := by
  rw [List.getD_eq_getElem?_getD, List.getElem?_modify, List.getD_eq_getElem?_getD, List.getElem?_eq_getElem hj]
  simp

private theorem getD_mem {α : Type*} (l : List α) (i : ℕ) (d : α) (h : i < l.length) : l.getD i d ∈ l := by
  rw [List.getD_eq_getElem?_getD, List.getElem?_eq_getElem h]; exact List.getElem_mem h

private theorem bagMap_eq (g : ℕ → ℕ) (l : List ℕ) : bagMap g l = bag (l.map g) := by
  unfold bagMap
  split <;> simp [bag_eq, Nat.mul_eq, Nat.add_eq, Nat.one_shiftLeft, pow_mul, add_assoc]

private theorem lenU_eq (l : List ℕ) : lenU l = l.length := by unfold lenU; split <;> rfl

private theorem fKey_eq (C : Cert) (f : ℕ) (o : Op) : fKey C f o = bag ((o.mono C.p).map (fImg C f)) := by
  simp only [fKey, bagMap_eq, Op.mono, List.map_append, List.map_map, bag_eq, List.sum_append, Nat.add_eq]
  rfl

private theorem Ym_perm (p : ℕ) [NeZero p] (φ : V p → ℝ) {m m' : List ℕ} (h : m.Perm m') :
    Ym p φ m = Ym p φ m' := by rw [Ym_eq, Ym_eq]; exact Yv_perm φ (h.map _)

/-- The op-stream reader after an op. -/
private def rdNext (C : Cert) (rd : Rd) (o : Op) : Rd :=
  cond (Nat.beq (o.vp + o.vn) 0) rd (rd.read (C.kw + C.ko) C.pero).2

/-- An op's term in segment `seg`'s sum: its value times its moment, if its stream entry names the segment. -/
private noncomputable def contrib (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (seg : ℕ) (rd : Rd) (o : Op) : ℝ :=
  if Nat.beq (o.vp + o.vn) 0 = true then 0
  else if fSeg C (rd.read (C.kw + C.ko) C.pero).1 = seg then (opVal o : ℝ) * Ym C.p φ (o.mono C.p) else 0

/-- Segment `seg`'s part of the identity. -/
private noncomputable def shadow (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (seg : ℕ) : List Op → Rd → ℝ
  | [], _ => 0
  | o :: l, rd => contrib C φ seg rd o + shadow C φ seg l (rdNext C rd o)

/-- Every op's stream entry names a segment below `nseg`. -/
private def covered (C : Cert) : List Op → Rd → Prop
  | [], _ => True
  | o :: l, rd => (Nat.beq (o.vp + o.vn) 0 = false → fSeg C (rd.read (C.kw + C.ko) C.pero).1 < C.nseg) ∧
      covered C l (rdNext C rd o)

private theorem opVal_zero (o : Op) (h : Nat.beq (o.vp + o.vn) 0 = true) : opVal o = 0 := by
  simp only [Nat.beq_eq] at h; simp [opVal]; omega

/-- **The segments add up to the identity** when every op is covered. -/
private theorem sum_shadow (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) :
    ∀ (l : List Op) (rd : Rd), covered C l rd →
      ∑ seg ∈ Finset.range C.nseg, shadow C φ seg l rd = opSum C.p φ l
  | [], _, _ => by simp [shadow, opSum]
  | o :: l, rd, ⟨hc, hl⟩ => by
    simp only [shadow, Finset.sum_add_distrib, sum_shadow C φ l _ hl, opSum, List.map_cons, List.sum_cons]
    congr 1
    unfold contrib
    by_cases h0 : Nat.beq (o.vp + o.vn) 0 = true
    · simp [h0, opVal_zero o h0]
    · simp only [h0, if_false, Bool.false_eq_true]
      rw [Finset.sum_ite_eq (Finset.range C.nseg) _ (fun _ => (opVal o : ℝ) * Ym C.p φ (o.mono C.p))]
      simp [hc (Bool.eq_false_iff.2 h0)]

/-- What a segment's state holds, read with ghost slot totals `P`, `N` and salts `S`: every leaf is its keys,
`S + Σ_s P_s 2^{w(s+1)}` and `S + Σ_s N_s 2^{w(s+1)}`; every slot total is at most the in-range total; and while every
check has passed, the segment's sum so far is `Σ (P − N)·Y(the multiset the slot's key names)`. -/
private def Inv (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (keys : List ℕ) (st : St) (A : ℝ) : Prop :=
  ∃ P N : ℕ → ℕ → ℕ, ∃ S : ℕ → ℕ,
    st.leaves.length = 2 ^ C.ds ∧
    (∀ ℓ < 2 ^ C.ds, st.leaves.getD ℓ (0, 0, 0) = (keys.getD ℓ 0,
      S ℓ + ∑ s ∈ Finset.range (2 ^ C.lb), P ℓ s * (2 ^ C.w) ^ (s + 1),
      S ℓ + ∑ s ∈ Finset.range (2 ^ C.lb), N ℓ s * (2 ^ C.w) ^ (s + 1))) ∧
    (∀ ℓ s, P ℓ s + N ℓ s ≤ st.tot) ∧
    (st.ok = true → A = ∑ ℓ ∈ Finset.range (2 ^ C.ds), ∑ s ∈ Finset.range (2 ^ C.lb),
      ((P ℓ s : ℝ) - N ℓ s) * Ym C.p φ (dec (C.p * C.p) (lowBits (Nat.shiftRight (keys.getD ℓ 0) (Nat.mul C.kb s)) C.kb)))

private theorem lowBits_lt (x k : ℕ) : lowBits x k < 2 ^ k := by rw [lowBits_eq]; exact Nat.mod_lt _ (by positivity)

private theorem leaf_sum (K w s0 S v salt : ℕ) (Q : ℕ → ℕ) (hs0 : s0 < K) :
    Nat.add (S + ∑ s ∈ Finset.range K, Q s * (2 ^ w) ^ (s + 1))
      (Nat.add (Nat.shiftLeft v (Nat.mul w (Nat.add s0 1))) salt) =
    S + salt + ∑ s ∈ Finset.range K, (Q s + if s = s0 then v else 0) * (2 ^ w) ^ (s + 1) := by
  rw [show Nat.shiftLeft v (Nat.mul w (Nat.add s0 1)) = v * (2 ^ w) ^ (s0 + 1) from by
    rw [show Nat.shiftLeft v (Nat.mul w (Nat.add s0 1)) = v <<< (w * (s0 + 1)) from rfl, Nat.shiftLeft_eq, pow_mul]]
  simp only [add_mul, Finset.sum_add_distrib, ite_mul, zero_mul, Finset.sum_ite_eq', Finset.mem_range, hs0, if_true,
    Nat.add_eq]
  ring

/-- One op preserves the invariant. -/
private theorem Inv_step (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (seg : ℕ) (keys : List ℕ) (st : St) (A : ℝ)
    (o : Op) (h : Inv C φ keys st A) :
    Inv C φ keys (St.op C seg st o) (A + contrib C φ seg st.rd o) ∧ (St.op C seg st o).rd = rdNext C st.rd o ∧
      ((St.op C seg st o).ok = true → st.ok = true ∧
        (Nat.beq (o.vp + o.vn) 0 = false → fSeg C (st.rd.read (C.kw + C.ko) C.pero).1 < C.nseg)) := by
  obtain ⟨P, N, S, hlen, hleaf, htot, hA⟩ := h
  by_cases h0 : Nat.beq (o.vp + o.vn) 0 = true
  · have e : St.op C seg st o = st := by simp [St.op, h0]
    refine ⟨?_, by simp [e, rdNext, h0], fun hok => ⟨by rwa [e] at hok, fun h => by simp [h0] at h⟩⟩
    rw [e, show contrib C φ seg st.rd o = 0 by simp [contrib, h0], add_zero]
    exact ⟨P, N, S, hlen, hleaf, htot, hA⟩
  have h0' : Nat.beq (o.vp + o.vn) 0 = false := Bool.eq_false_iff.2 h0
  have eop : St.op C seg st o = St.op1 C seg st o (st.rd.read (C.kw + C.ko) C.pero) := by simp [St.op, h0']
  have ec : contrib C φ seg st.rd o = if fSeg C (st.rd.read (C.kw + C.ko) C.pero).1 = seg then
      (opVal o : ℝ) * Ym C.p φ (o.mono C.p) else 0 := by simp [contrib, h0']
  have enx : rdNext C st.rd o = (st.rd.read (C.kw + C.ko) C.pero).2 := by simp [rdNext, h0']
  rw [eop, ec, enx]
  generalize st.rd.read (C.kw + C.ko) C.pero = r
  by_cases hs : Nat.beq (fSeg C r.1) seg = true
  · -- the op's own segment
    have hs' : fSeg C r.1 = seg := by simpa using hs
    have hli : lowBits (fLeaf C r.1) C.ds < 2 ^ C.ds := lowBits_lt _ _
    have hs0 : lowBits (fSlot C r.1) C.lb < 2 ^ C.lb := lowBits_lt _ _
    generalize hli' : lowBits (fLeaf C r.1) C.ds = li at hli
    generalize hs0' : lowBits (fSlot C r.1) C.lb = s0 at hs0
    have e : St.op1 C seg st o r = ⟨r.2, st.leaves.modify li (leafAdd C r.1 o.vp o.vn (Nat.add 1 (lowBits st.tot 16))),
        Nat.add st.tot (Nat.add o.vp o.vn), st.ok && Nat.blt (fSeg C r.1) C.nseg &&
        opGood C r.1 (st.leaves.getD li (0, 0, 0)).1 o⟩ := by
      simp only [St.op1, hs, cond_true, hli']
    rw [e, if_pos hs']
    refine ⟨⟨fun ℓ s => P ℓ s + if ℓ = li ∧ s = s0 then o.vp else 0,
      fun ℓ s => N ℓ s + if ℓ = li ∧ s = s0 then o.vn else 0,
      fun ℓ => S ℓ + if ℓ = li then Nat.add 1 (lowBits st.tot 16) else 0, ?_, ?_, ?_, ?_⟩, rfl, ?_⟩
    · simp [hlen]
    · intro ℓ hℓ
      simp only
      rw [getD_modify _ _ _ _ _ (by rw [hlen]; exact hℓ)]
      by_cases hl : li = ℓ
      · subst hl
        rw [if_pos rfl, hleaf li hli]
        simp only [leafAdd, if_true, Prod.mk.injEq, true_and]
        rw [hs0']
        exact ⟨leaf_sum _ _ _ _ _ _ _ hs0, leaf_sum _ _ _ _ _ _ _ hs0⟩
      · rw [if_neg hl, hleaf ℓ hℓ]
        simp [Ne.symm hl]
    · intro ℓ s
      have := htot ℓ s
      simp only [Nat.add_eq]
      split_ifs <;> omega
    · intro hok
      simp only [Bool.and_eq_true] at hok
      obtain ⟨⟨hok0, -⟩, hgood⟩ := hok
      rw [hA hok0]
      simp only [opGood, Bool.and_eq_true, Nat.beq_eq, Nat.blt_eq] at hgood
      obtain ⟨⟨hkey, hunit⟩, hlenm⟩ := hgood
      have hkeys : (st.leaves.getD li (0, 0, 0)).1 = keys.getD li 0 := by rw [hleaf li hli]
      rw [hkeys, slotKey, hs0'] at hkey
      have hY : Ym C.p φ (dec (C.p * C.p) (lowBits (Nat.shiftRight (keys.getD li 0) (Nat.mul C.kb s0)) C.kb)) =
          Ym C.p φ (o.mono C.p) := by
        rw [hkey, fKey_eq, Ym_perm C.p φ (dec_bag _ _ ?_ ?_)]
        · exact Ym_witness C.p φ _ _ _ _ (Nat.le_of_lt (Nat.mod_lt _ (Nat.pos_of_ne_zero (NeZero.ne _))))
            (Nat.le_of_lt (Nat.mod_lt _ (Nat.pos_of_ne_zero (NeZero.ne _)))) hunit _
        · rw [List.length_map]; simpa [Op.mono, lenU_eq] using hlenm
        · intro x hx
          obtain ⟨y, -, rfl⟩ := List.mem_map.1 hx
          exact gmap_lt _ _ _ _ _
      have hsplit : ∀ (F : ℕ → ℕ → ℝ), ∑ ℓ ∈ Finset.range (2 ^ C.ds), ∑ s ∈ Finset.range (2 ^ C.lb),
          (((P ℓ s + if ℓ = li ∧ s = s0 then o.vp else 0 : ℕ) : ℝ) -
            ((N ℓ s + if ℓ = li ∧ s = s0 then o.vn else 0 : ℕ) : ℝ)) * F ℓ s =
          ∑ ℓ ∈ Finset.range (2 ^ C.ds), ∑ s ∈ Finset.range (2 ^ C.lb),
          ((P ℓ s : ℝ) - N ℓ s) * F ℓ s + ((o.vp : ℝ) - o.vn) * F li s0 := by
        intro F
        have : ∀ ℓ s, (((P ℓ s + if ℓ = li ∧ s = s0 then o.vp else 0 : ℕ) : ℝ) -
            ((N ℓ s + if ℓ = li ∧ s = s0 then o.vn else 0 : ℕ) : ℝ)) * F ℓ s = ((P ℓ s : ℝ) - N ℓ s) * F ℓ s +
            if ℓ = li ∧ s = s0 then ((o.vp : ℝ) - o.vn) * F ℓ s else 0 := by
          intro ℓ s
          split_ifs <;> push_cast <;> ring
        simp only [this, Finset.sum_add_distrib]
        congr 1
        rw [Finset.sum_eq_single_of_mem li (Finset.mem_range.2 hli) (fun ℓ _ hl => Finset.sum_eq_zero fun s _ => by
          simp [hl]), Finset.sum_eq_single_of_mem s0 (Finset.mem_range.2 hs0) (fun s _ hs => by simp [hs])]
        simp
      rw [hsplit, hY, opVal]
      push_cast; ring
    · intro hok
      simp only [Bool.and_eq_true, Nat.blt_eq] at hok
      exact ⟨hok.1.1, fun _ => hok.1.2⟩
  · -- another segment's op
    have hs' : Nat.beq (fSeg C r.1) seg = false := Bool.eq_false_iff.2 hs
    have hs'' : fSeg C r.1 ≠ seg := fun h => hs (by rw [h]; exact Nat.beq_refl seg)
    have e : St.op1 C seg st o r = ⟨r.2, st.leaves, st.tot, st.ok && Nat.blt (fSeg C r.1) C.nseg⟩ := by
      simp only [St.op1, hs', cond_false]
    rw [e, if_neg hs'', add_zero]
    refine ⟨⟨P, N, S, hlen, hleaf, htot, fun hok => hA ?_⟩, rfl, fun hok => ?_⟩
    · simp only [Bool.and_eq_true] at hok; exact hok.1
    · simp only [Bool.and_eq_true, Nat.blt_eq] at hok; exact ⟨hok.1, fun _ => hok.2⟩

private theorem Inv_fold (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (seg : ℕ) (keys : List ℕ) :
    ∀ (l : List Op) (st : St) (A : ℝ), Inv C φ keys st A →
      Inv C φ keys (l.foldl (St.op C seg) st) (A + shadow C φ seg l st.rd) ∧
      ((l.foldl (St.op C seg) st).ok = true → st.ok = true ∧ covered C l st.rd)
  | [], st, A, h => by simpa [shadow, covered] using h
  | o :: l, st, A, h => by
    obtain ⟨h1, h2, h3⟩ := Inv_step C φ seg keys st A o h
    have ih := Inv_fold C φ seg keys l _ _ h1
    rw [h2] at ih
    simp only [List.foldl_cons, shadow, covered]
    refine ⟨by rw [← add_assoc]; exact ih.1, fun hok => ?_⟩
    obtain ⟨hok', hcov⟩ := ih.2 hok
    obtain ⟨hst, hc⟩ := h3 hok'
    exact ⟨hst, hc, hcov⟩

/-- Equal packed sums with digits below the base have equal digits. -/
private theorem digits_eq (B K : ℕ) (hB : 0 < B) (P N : ℕ → ℕ) (hP : ∀ s, P s < B) (hN : ∀ s, N s < B)
    (h : ∑ s ∈ Finset.range K, P s * B ^ (s + 1) = ∑ s ∈ Finset.range K, N s * B ^ (s + 1)) :
    ∀ s < K, P s = N s := by
  have h' : (∑ s ∈ Finset.range K, P s * B ^ s) * B = (∑ s ∈ Finset.range K, N s * B ^ s) * B := by
    simp only [Finset.sum_mul, mul_assoc, ← pow_succ]; exact h
  have h'' := Nat.eq_of_mul_eq_mul_right hB h'
  intro s hs
  rw [← sum_digit B P K (fun i _ => hP i) s hs, ← sum_digit B N K (fun i _ => hN i) s hs, h'']

/-- **One segment**: its part of the identity is zero, and every op's entry names a checked segment. -/
private theorem seg_shadow (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (seg : ℕ) (h : segCheck C seg = true) :
    shadow C φ seg (opList C (orbRows C) (qcoefs C)) ⟨0, 0, C.ops⟩ = 0 ∧
      covered C (opList C (orbRows C) (qcoefs C)) ⟨0, 0, C.ops⟩ := by
  let keys := (List.range (2 ^ C.ds)).map fun k => C.keys.getD (Nat.add (Nat.mul seg (2 ^ C.ds)) k) 0
  have h0 : Inv C φ keys ⟨⟨0, 0, C.ops⟩, (List.range (2 ^ C.ds)).map fun k =>
      (C.keys.getD (Nat.add (Nat.mul seg (2 ^ C.ds)) k) 0, 0, 0), 0, true⟩ 0 := by
    refine ⟨fun _ _ => 0, fun _ _ => 0, fun _ => 0, by simp, fun ℓ hℓ => ?_, fun _ _ => le_rfl, fun _ => by simp⟩
    simp only [keys, List.getD_eq_getElem?_getD, List.getElem?_map, List.getElem?_range hℓ]
    simp
  simp only [segCheck, shl_one, Bool.and_eq_true, Nat.blt_eq, List.all_eq_true, Nat.beq_eq] at h
  obtain ⟨⟨hok, htot⟩, hbal⟩ := h
  obtain ⟨⟨P, N, S, hlen, hleaf, hPN, hA⟩, hcov⟩ := Inv_fold C φ seg keys _ _ 0 h0
  simp only [zero_add] at hA
  refine ⟨?_, (hcov hok).2⟩
  rw [hA hok]
  refine Finset.sum_eq_zero fun ℓ hℓ => Finset.sum_eq_zero fun s hs => ?_
  rw [Finset.mem_range] at hℓ hs
  have hb := hbal _ (getD_mem _ ℓ (0, 0, 0) (by rw [hlen]; exact hℓ))
  rw [hleaf ℓ hℓ] at hb
  have hB : (0 : ℕ) < 2 ^ C.w := by positivity
  have hlt : ∀ ℓ s, P ℓ s < 2 ^ C.w ∧ N ℓ s < 2 ^ C.w := fun ℓ s =>
    ⟨by have := hPN ℓ s; omega, by have := hPN ℓ s; omega⟩
  have := digits_eq _ _ hB (P ℓ) (N ℓ) (fun s => (hlt ℓ s).1) (fun s => (hlt ℓ s).2) (by simpa using hb) s hs
  simp [this]

/-! ### The children (FS131-IKC1 § 3: each a leaf until proved) -/

/-- **The computation half** (K2a–d, K2i): an accepted certificate's ops sum to zero at the moments. -/
private theorem opSum_eq_zero (C : Cert) [NeZero C.p] (hC : certOK C = true) (φ : V C.p → ℝ) :
    opSum C.p φ (opList C (orbRows C) (qcoefs C)) = 0 := by
  have hn : 0 < C.nseg := by
    simp only [certOK, globalOK, Bool.and_eq_true, Nat.blt_eq] at hC
    exact hC.1.1.1.1.1.1.1.1.1.2
  have hseg : ∀ seg < C.nseg, segCheck C seg = true := by
    simp only [certOK, segAll, Bool.and_eq_true, List.all_eq_true, List.mem_range] at hC
    exact hC.1.2
  rw [← sum_shadow C φ _ _ (seg_shadow C φ 0 (hseg 0 hn)).2]
  exact Finset.sum_eq_zero fun seg h => (seg_shadow C φ seg (hseg seg (Finset.mem_range.1 h))).1

/-- The number of maps averaged over. -/
private noncomputable def gsize (p : ℕ) [NeZero p] : ℝ := ((affs p).card : ℝ)

private theorem mono_nil (p : ℕ) (a : List ℕ) (t vp vn : ℕ) : Op.mono p ⟨a, t, [], vp, vn⟩ = a := by
  simp [Op.mono]

private theorem act_zero {p : ℕ} (γ : V p × V p × Bool) : act γ 0 = γ.1 := by
  rcases γ with ⟨t, s, e⟩
  cases e <;> simp [act, cmul, cj]

private theorem pt_zero (p : ℕ) : pt p 0 = 0 := by simp [pt]

private theorem Ym_nil (p : ℕ) [NeZero p] (φ : V p → ℝ) : Ym p φ [] = gsize p := by simp [Ym, gsize]

private theorem gsize_eq (p : ℕ) [NeZero p] :
    gsize p = ((p * p : ℕ) : ℝ) * ((unitCircle p ×ˢ (Finset.univ : Finset Bool)).card : ℝ) := by
  simp [gsize, affs, Finset.card_product, ZMod.card]

private theorem Ym_zero (p : ℕ) [NeZero p] (φ : V p → ℝ) :
    Ym p φ [0] = ((unitCircle p ×ˢ (Finset.univ : Finset Bool)).card : ℝ) * ∑ x, φ x := by
  simp only [Ym, affs, List.map_cons, List.map_nil, List.prod_cons, List.prod_nil, mul_one, pt_zero, act_zero]
  rw [Finset.sum_product, Finset.mul_sum]
  refine Finset.sum_congr rfl fun t _ => ?_
  simp [mul_comm]

/-- **(O1)** the left side: `−U_num·G + L·G·Σφ`. -/
private theorem opSum_O1 (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) :
    opSum C.p φ (opsO1 C) = -(C.unum : ℝ) * gsize C.p + (C.scale : ℝ) * gsize C.p * ∑ x, φ x := by
  simp only [opSum, opsO1, List.map_cons, List.map_nil, List.sum_cons, List.sum_nil, mono_nil, Ym_nil, Ym_zero,
    opVal, gsize_eq, Nat.mul_eq]
  push_cast
  ring

/-- A block's matrix is positive semidefinite on its `m` indices. -/
private def PSDN (tri : List (List ℤ)) (m : ℕ) : Prop :=
  ∀ v : ℕ → ℝ, 0 ≤ ∑ i ∈ Finset.range m, ∑ j ∈ Finset.range m, (triGet tri i j : ℝ) * v i * v j

/-! ### Leaf L1: the PSD check certifies its block's matrix -/

/-- Rows `1..` of a block's triangle, as `Blk.tri` decodes them. -/
private def trows (wr per : ℕ) (toI : List ℕ → List ℤ) (n : ℕ) : ℕ → Rd → List (List ℤ) :=
  Nat.rec (motive := fun _ => ℕ → Rd → List (List ℤ)) (fun _ _ => [])
    (fun _ ih len r => let x := Rd.readK wr per len r; toI x.1 :: ih (Nat.sub len 1) x.2) n

private theorem tri_eq (b : Blk) : b.tri = (readN b.wr b.per b.m b.row0).map (fun x => sfield x b.wr) ::
    trows b.wr b.per (fun l => l.map fun x => sfield x b.wr) (Nat.sub b.m 1) (Nat.sub b.m 1) ⟨0, 0, b.rest⟩ := rfl

private theorem readK_length (k per : ℕ) : ∀ (cnt : ℕ) (r : Rd), (Rd.readK k per cnt r).1.length = cnt
  | 0, _ => rfl
  | cnt + 1, r => by
    show ((r.read k per).1 :: (Rd.readK k per cnt (r.read k per).2).1).length = cnt + 1
    rw [List.length_cons, readK_length k per cnt]

private theorem trows_length (wr per : ℕ) (toI : List ℕ → List ℤ) (htoI : ∀ l, (toI l).length = l.length) :
    ∀ (n len : ℕ) (r : Rd), (trows wr per toI n len r).length = n ∧
      ∀ k < n, ((trows wr per toI n len r).getD k []).length = len - k
  | 0, _, _ => ⟨rfl, fun k hk => absurd hk (Nat.not_lt_zero k)⟩
  | n + 1, len, r => by
    have e : trows wr per toI (n + 1) len r = toI (Rd.readK wr per len r).1 ::
        trows wr per toI n (Nat.sub len 1) (Rd.readK wr per len r).2 := rfl
    obtain ⟨h1, h2⟩ := trows_length wr per toI htoI n (Nat.sub len 1) (Rd.readK wr per len r).2
    rw [e]
    refine ⟨by rw [List.length_cons, h1], fun k hk => ?_⟩
    cases k with
    | zero => simp [htoI, readK_length]
    | succ k => rw [List.getD_cons_succ, h2 k (by omega), Nat.sub_eq]; omega

/-- `Blk.tri` decodes rows of exactly `m − k` entries. -/
private theorem tri_rows (b : Blk) (hm : 0 < b.m) : ∀ k < b.m, (b.tri.getD k []).length = b.m - k := by
  intro k hk
  have htoI : ∀ l : List ℕ, (l.map fun x => sfield x b.wr).length = l.length := fun l => List.length_map _
  obtain ⟨-, h2⟩ := trows_length b.wr b.per _ htoI (Nat.sub b.m 1) (Nat.sub b.m 1) ⟨0, 0, b.rest⟩
  rw [tri_eq]
  cases k with
  | zero => simp [readN, readK_length]
  | succ k => rw [List.getD_cons_succ, h2 k (by simp only [Nat.sub_eq]; omega), Nat.sub_eq]; omega

private theorem rec_iter {α : Type} (f : α → α) : ∀ (n : ℕ) (s : α),
    (Nat.rec (motive := fun _ => α → α) (fun s => s) (fun _ ih s => ih (f s)) n) s = f^[n] s
  | 0, _ => rfl
  | n + 1, s => by
    show (Nat.rec (motive := fun _ => α → α) (fun s => s) (fun _ ih s => ih (f s)) n) (f s) = f^[n + 1] s
    rw [rec_iter f n, Function.iterate_succ_apply]

/-- One step of `symRows`. -/
private def symStep (s : List (List ℤ) × List (List ℤ) × List (List ℤ)) :
    List (List ℤ) × List (List ℤ) × List (List ℤ) :=
  let r := s.2.1.headD []
  (s.1 ++ [s.2.2.map (fun t => t.headD 0) ++ r], s.2.1.tail, s.2.2.map List.tail ++ [r.tail])

private theorem symRows_iter (tri : List (List ℤ)) (m : ℕ) : symRows tri m = (symStep^[m] ([], tri, [])).1 := by
  unfold symRows
  exact congrArg Prod.fst (rec_iter symStep m _)

private theorem headD_drop {α : Type} (l : List α) (j : ℕ) (d : α) : (l.drop j).headD d = l.getD j d := by
  simp [List.headD_eq_head?_getD, List.head?_drop, List.getD_eq_getElem?_getD]

private theorem map_range_getD {α : Type} (l : List α) (d : α) :
    (List.range l.length).map (fun i => l.getD i d) = l := by
  refine List.ext_getElem (by simp) fun i h1 h2 => ?_
  simp [List.getD_eq_getElem?_getD, List.getElem?_eq_getElem h2]

private theorem triGet_lt (tri : List (List ℤ)) (i j : ℕ) (h : j < i) :
    triGet tri i j = (tri.getD j []).getD (i - j) 0 := by
  have : Nat.ble i j = false := Bool.eq_false_iff.2 fun h' => by rw [Nat.ble_eq] at h'; omega
  simp [triGet, this]

private theorem triGet_le (tri : List (List ℤ)) (i j : ℕ) (h : i ≤ j) :
    triGet tri i j = (tri.getD i []).getD (j - i) 0 := by
  have : Nat.ble i j = true := by rw [Nat.ble_eq]; exact h
  simp [triGet, this]

private theorem triGet_symm (tri : List (List ℤ)) (i j : ℕ) : triGet tri i j = triGet tri j i := by
  rcases lt_trichotomy i j with h | rfl | h
  · rw [triGet_le _ _ _ h.le, triGet_lt _ _ _ h]
  · rfl
  · rw [triGet_lt _ _ _ h, triGet_le _ _ _ h.le]

private theorem symRow (tri : List (List ℤ)) (m k : ℕ) (hk : k < m) (hl : (tri.getD k []).length = m - k) :
    (List.range k).map (fun c => ((tri.getD c []).drop (k - c)).headD 0) ++ (tri.drop k).headD [] =
      (List.range m).map (triGet tri k) := by
  rw [headD_drop, show m = k + (m - k) by omega, List.range_add, List.map_append, List.map_map]
  congr 1
  · refine List.map_congr_left fun c hc => ?_
    rw [headD_drop, triGet_lt _ _ _ (List.mem_range.1 hc)]
  · conv_lhs => rw [← map_range_getD (tri.getD k []) 0, hl]
    refine List.map_congr_left fun j _ => ?_
    simp only [Function.comp_apply]
    rw [triGet_le _ _ _ (Nat.le_add_right k j), Nat.add_sub_cancel_left]

private theorem symStep_iter (tri : List (List ℤ)) (m : ℕ) (hl : ∀ k < m, (tri.getD k []).length = m - k) :
    ∀ k ≤ m, symStep^[k] ([], tri, []) = ((List.range k).map (fun i => (List.range m).map (triGet tri i)),
      tri.drop k, (List.range k).map fun c => (tri.getD c []).drop (k - c))
  | 0, _ => rfl
  | k + 1, hk => by
    rw [Function.iterate_succ_apply', symStep_iter tri m hl k (by omega)]
    simp only [symStep, List.range_succ, List.map_append, List.map_cons, List.map_nil, List.map_map]
    refine Prod.ext ?_ (Prod.ext ?_ ?_)
    · simp only [List.append_cancel_left_eq, List.cons.injEq, and_true]
      exact symRow tri m k (by omega) (hl k (by omega))
    · exact List.tail_drop
    · simp only
      congr 1
      · refine List.map_congr_left fun c hc => ?_
        have := List.mem_range.1 hc
        simp only [Function.comp_apply, List.tail_drop]
        congr 1; omega
      · simp only [List.cons.injEq, and_true]
        rw [headD_drop, Nat.add_sub_cancel_left, List.drop_one]

/-- With rows of exactly `m − k` entries, `symRows` is `triGet` on `m × m`. -/
private theorem symRows_eq (tri : List (List ℤ)) (m : ℕ) (hl : ∀ k < m, (tri.getD k []).length = m - k) :
    symRows tri m = (List.range m).map fun i => (List.range m).map (triGet tri i) := by
  rw [symRows_iter, symStep_iter tri m hl m le_rfl]

/-! The PSD check's parts, named (`psdCheck_eq` is `rfl`). -/

private def pB (b : Blk) : ℕ := Nat.shiftLeft 1 b.wB
private def pCm (b : Blk) : ℕ := Nat.add (Nat.shiftLeft 1 (Nat.sub b.wm 1)) 1
private def pDigs (b : Blk) : List (List ℕ) := b.mrows.map fun f => (List.range (Nat.add b.m 1)).map (digit f b.wB)
private def pRev (b : Blk) : List ℕ :=
  (pDigs b).map fun ds => Nat.add (ds.headD 0) (Nat.mul (ds.tail.foldl (fun a d => Nat.add (Nat.mul a (pB b)) d) 0) (pB b))
private def pSig (b : Blk) : List ℕ := (pDigs b).map fun ds => ds.tail.foldl Nat.add 0
private def pE (b : Blk) (fi si : ℕ) (x : ℤ × ℕ × ℕ) : ℤ :=
  Int.sub (Int.mul (Int.ofNat (Nat.add (Nat.shiftLeft 1 b.sb) 1)) x.1)
    (Int.add (Int.subNatNat (digit (Nat.mul fi x.2.1) b.wB (Nat.add b.m 1)) (Nat.mul (pCm b) (Nat.add si x.2.2)))
      (Int.ofNat (Nat.mul b.m (Nat.mul (pCm b) (pCm b)))))
private def pFold (b : Blk) (i fi si : ℕ) (Ri : List ℤ) : ℕ × ℤ × ℤ :=
  (Ri.zip ((pRev b).zip (pSig b))).foldl (fun (a : ℕ × ℤ × ℤ) x =>
    cond (Nat.beq a.1 i) (Nat.add a.1 1, pE b fi si x, a.2.2)
      (Nat.add a.1 1, a.2.1, Int.add a.2.2 (Int.ofNat (Int.natAbs (pE b fi si x))))) (0, 0, 0)
private def pRowOK (b : Blk) (i fi si : ℕ) (Ri : List ℤ) : Bool :=
  nonneg (Int.sub (pFold b i fi si Ri).2.1 (pFold b i fi si Ri).2.2)
private def pAll (b : Blk) : ℕ × Bool :=
  ((b.mrows.zip (pSig b)).zip (symRows b.tri b.m)).foldl (fun (a : ℕ × Bool) x =>
    (Nat.add a.1 1, a.2 && pRowOK b a.1 x.1.1 x.1.2 x.2)) (0, true)
private def pOkB (b : Blk) : Bool :=
  Nat.beq b.mrows.length b.m && b.mrows.all (fun f => Nat.blt f (Nat.shiftLeft 1 (Nat.mul b.wB (Nat.add b.m 1)))) &&
    (pDigs b).all (fun ds => ds.all fun x => Nat.blt x (Nat.shiftLeft 1 b.wm)) &&
    Nat.blt (Nat.mul (Nat.add b.m 1) (Nat.mul (Nat.shiftLeft 1 b.wm) (Nat.shiftLeft 1 b.wm))) (pB b)

private theorem psdCheck_eq (b : Blk) : psdCheck b = (pOkB b && (pAll b).2) := rfl

private theorem nonneg_iff (x : ℤ) : nonneg x = true ↔ 0 ≤ x := by
  cases x with
  | ofNat n => simp [nonneg]
  | negSucc n => simp [nonneg]

private theorem zip_range {α β : Type} (f : ℕ → α) (g : ℕ → β) (n : ℕ) :
    ((List.range n).map f).zip ((List.range n).map g) = (List.range n).map fun i => (f i, g i) :=
  List.ext_getElem (by simp) fun i h1 h2 => by simp

private theorem rowFold {α : Type} (i : ℕ) (e : α → ℤ) (h : ℕ → α) : ∀ n : ℕ,
    ((List.range n).map h).foldl (fun (a : ℕ × ℤ × ℤ) x => cond (Nat.beq a.1 i) (Nat.add a.1 1, e x, a.2.2)
      (Nat.add a.1 1, a.2.1, Int.add a.2.2 (Int.ofNat (Int.natAbs (e x))))) (0, 0, 0) =
      (n, if i < n then e (h i) else 0, ∑ j ∈ Finset.range n, if j = i then 0 else |e (h j)|)
  | 0 => by simp
  | n + 1 => by
    rw [List.range_succ, List.map_append, List.foldl_append, rowFold i e h n]
    simp only [List.map_cons, List.map_nil, List.foldl_cons, List.foldl_nil, Finset.sum_range_succ]
    by_cases hn : n = i
    · subst hn
      simp [Nat.beq_refl]
    · have hb : Nat.beq n i = false := Bool.eq_false_iff.2 fun h' => hn (Nat.eq_of_beq_eq_true h')
      have hlt : (i < n + 1) = (i < n) := by apply propext; omega
      simp only [hb, cond_false, hlt, hn, if_false, Int.ofNat_eq_natCast, Int.natCast_natAbs, Nat.add_eq]
      rfl

private theorem allFold {α : Type} (R : ℕ → α → Bool) (h : ℕ → α) : ∀ n : ℕ,
    ((List.range n).map h).foldl (fun (a : ℕ × Bool) x => (Nat.add a.1 1, a.2 && R a.1 x)) (0, true) =
      (n, (List.range n).all fun i => R i (h i))
  | 0 => rfl
  | n + 1 => by
    rw [List.range_succ, List.map_append, List.foldl_append, allFold R h n]
    simp [List.all_append]

/-- A number below `B^K` is the sum of its base-`B` digits. -/
private theorem base_expand (B K x : ℕ) (hx : x < B ^ K) : x = ∑ k ∈ Finset.range K, x / B ^ k % B * B ^ k := by
  have : ∀ K, x % B ^ K = ∑ k ∈ Finset.range K, x / B ^ k % B * B ^ k := by
    intro K
    induction K with
    | zero => simp [Nat.mod_one]
    | succ K ih => rw [Nat.mod_pow_succ, ih, Finset.sum_range_succ, mul_comm (B ^ K)]
  rw [← this K, Nat.mod_eq_of_lt hx]

private theorem horner (B : ℕ) (h : ℕ → ℕ) : ∀ n : ℕ,
    ((List.range n).map h).foldl (fun a d => Nat.add (Nat.mul a B) d) 0 = ∑ r ∈ Finset.range n, h (n - 1 - r) * B ^ r
  | 0 => rfl
  | n + 1 => by
    rw [List.range_succ, List.map_append, List.foldl_append, horner B h n]
    simp only [List.map_cons, List.map_nil, List.foldl_cons, List.foldl_nil, Nat.mul_eq, Nat.add_eq,
      Finset.sum_range_succ', Finset.sum_mul, Nat.add_sub_cancel, Nat.sub_zero, pow_zero, mul_one]
    congr 1
    refine Finset.sum_congr rfl fun r hr => ?_
    have := Finset.mem_range.1 hr
    rw [mul_assoc, ← pow_succ]; congr 2; omega

/-- **The Cauchy product** of two base-`B` numbers of `K` digits, coefficient by coefficient. -/
private theorem cauchy (B K : ℕ) (a c : ℕ → ℕ) :
    (∑ l ∈ Finset.range K, a l * B ^ l) * (∑ r ∈ Finset.range K, c r * B ^ r) =
      ∑ n ∈ Finset.range (2 * K), (∑ l ∈ Finset.range K, if l ≤ n ∧ n - l < K then a l * c (n - l) else 0) * B ^ n := by
  rw [Finset.sum_mul_sum]
  simp only [Finset.sum_mul]
  conv_rhs => rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun l hl => ?_
  have hl' := Finset.mem_range.1 hl
  simp only [ite_mul, zero_mul]
  rw [← Finset.sum_filter]
  have hf : (Finset.range (2 * K)).filter (fun n => l ≤ n ∧ n - l < K) = (Finset.range K).map (addLeftEmbedding l) := by
    ext n
    simp only [Finset.mem_filter, Finset.mem_range, Finset.mem_map, addLeftEmbedding_apply]
    constructor
    · rintro ⟨h1, h2, h3⟩; exact ⟨n - l, h3, by omega⟩
    · rintro ⟨r, hr, rfl⟩; omega
  rw [hf, Finset.sum_map]
  refine Finset.sum_congr rfl fun r _ => ?_
  simp only [addLeftEmbedding_apply, Nat.add_sub_cancel_left, pow_add]; ring

/-- **The Kronecker digit**: digit `m + 1` of `row_i · rev_j` is `Σ_{k=1}^m d_ik d_jk` when every digit is below `A`
and `(m + 1)·A² < B`. -/
private theorem kron (B A m : ℕ) (d e : ℕ → ℕ) (hd : ∀ k < m + 1, d k < A) (he : ∀ k < m + 1, e k < A)
    (hAB : (m + 1) * (A * A) < B) :
    (∑ l ∈ Finset.range (m + 1), d l * B ^ l) * (e 0 + (∑ r ∈ Finset.range m, e (m - r) * B ^ r) * B) /
      B ^ (m + 1) % B = ∑ k ∈ Finset.range m, d (k + 1) * e (k + 1) := by
  let e' : ℕ → ℕ := fun r => if r = 0 then e 0 else e (m + 1 - r)
  have hrev : e 0 + (∑ r ∈ Finset.range m, e (m - r) * B ^ r) * B =
      ∑ r ∈ Finset.range (m + 1), e' r * B ^ r := by
    rw [Finset.sum_range_succ', Finset.sum_mul]
    simp only [e', Nat.add_one_ne_zero, if_false, if_true, pow_zero, mul_one, add_comm (e 0)]
    congr 1
    refine Finset.sum_congr rfl fun r hr => ?_
    rw [mul_assoc, ← pow_succ]; congr 2; omega
  have he' : ∀ r < m + 1, e' r < A := fun r hr => by
    simp only [e']; split_ifs
    · exact he 0 (by omega)
    · exact he _ (by omega)
  rw [hrev, cauchy]
  have hc : ∀ n < 2 * (m + 1), (∑ l ∈ Finset.range (m + 1),
      if l ≤ n ∧ n - l < m + 1 then d l * e' (n - l) else 0) < B := by
    intro n _
    refine lt_of_le_of_lt ?_ hAB
    calc _ ≤ ∑ _l ∈ Finset.range (m + 1), A * A := Finset.sum_le_sum fun l hl => by
            split_ifs with h
            · exact Nat.mul_le_mul (hd l (Finset.mem_range.1 hl)).le (he' _ h.2).le
            · exact Nat.zero_le _
      _ = (m + 1) * (A * A) := by simp
  rw [sum_digit B _ (2 * (m + 1)) hc (m + 1) (by omega), Finset.sum_range_succ']
  simp only [Nat.zero_le, Nat.sub_zero, lt_irrefl, and_false, if_false, add_zero]
  refine Finset.sum_congr rfl fun k hk => ?_
  have := Finset.mem_range.1 hk
  rw [if_pos (by omega)]
  simp only [e']
  rw [if_neg (by omega)]
  congr 2; omega

/-- **Diagonal dominance**: a symmetric matrix whose every diagonal entry is at least its row's off-diagonal mass is
positive semidefinite. -/
private theorem dd_nonneg (m : ℕ) (E : ℕ → ℕ → ℝ) (hsym : ∀ i < m, ∀ j < m, E i j = E j i)
    (hdom : ∀ i < m, ∑ j ∈ Finset.range m, (if j = i then 0 else |E i j|) ≤ E i i) (v : ℕ → ℝ) :
    0 ≤ ∑ i ∈ Finset.range m, ∑ j ∈ Finset.range m, E i j * v i * v j := by
  let T : ℕ → ℕ → ℝ := fun i j => if j = i then 0 else |E i j|
  have hT : ∀ i < m, ∀ j < m, T i j = T j i := fun i hi j hj => by
    simp only [T]; by_cases h : j = i
    · subst h; rfl
    · rw [if_neg h, if_neg (Ne.symm h), hsym i hi j hj]
  have key : ∀ i j, 2 * (if j = i then E i i * v i ^ 2 else 0) - T i j * (v i ^ 2 + v j ^ 2) ≤
      2 * (E i j * v i * v j) := by
    intro i j
    simp only [T]
    by_cases h : j = i
    · subst h; simp; ring_nf; rfl
    · simp only [if_neg h, mul_zero, zero_sub]
      have h1 : 2 * |E i j * v i * v j| ≤ |E i j| * (v i ^ 2 + v j ^ 2) := by
        rw [abs_mul, abs_mul, mul_assoc]
        have := two_mul_le_add_sq |v i| |v j|
        rw [sq_abs, sq_abs] at this
        nlinarith [abs_nonneg (E i j)]
      linarith [neg_abs_le (E i j * v i * v j)]
  have hswap : ∑ i ∈ Finset.range m, ∑ j ∈ Finset.range m, T i j * v j ^ 2 =
      ∑ i ∈ Finset.range m, ∑ j ∈ Finset.range m, T i j * v i ^ 2 := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun i hi => Finset.sum_congr rfl fun j hj => ?_
    rw [hT j (Finset.mem_range.1 hj) i (Finset.mem_range.1 hi)]
  have hsum : ∑ i ∈ Finset.range m, ∑ j ∈ Finset.range m,
      (2 * (if j = i then E i i * v i ^ 2 else 0) - T i j * (v i ^ 2 + v j ^ 2)) =
      2 * ∑ i ∈ Finset.range m, (E i i - ∑ j ∈ Finset.range m, T i j) * v i ^ 2 := by
    simp only [Finset.sum_sub_distrib, mul_add, Finset.sum_add_distrib, hswap, ← Finset.mul_sum,
      Finset.sum_ite_eq', Finset.mem_range]
    rw [Finset.sum_congr rfl fun i hi => if_pos (Finset.mem_range.1 hi)]
    simp only [sub_mul, Finset.sum_sub_distrib, Finset.sum_mul]
    ring
  have h0 : 0 ≤ ∑ i ∈ Finset.range m, (E i i - ∑ j ∈ Finset.range m, T i j) * v i ^ 2 :=
    Finset.sum_nonneg fun i hi => mul_nonneg (sub_nonneg.2 (hdom i (Finset.mem_range.1 hi))) (sq_nonneg _)
  have h2 := Finset.sum_le_sum fun i (_ : i ∈ Finset.range m) =>
    Finset.sum_le_sum fun j (_ : j ∈ Finset.range m) => key i j
  rw [hsum] at h2
  simp only [← Finset.mul_sum] at h2
  linarith

private theorem foldl_nadd (l : List ℕ) (a : ℕ) : l.foldl Nat.add a = a + l.sum := by
  induction l generalizing a with
  | nil => simp
  | cons x l ih => rw [List.foldl_cons, ih, List.sum_cons, Nat.add_eq, add_assoc]

private theorem tail_digits (g : ℕ → ℕ) (m : ℕ) :
    ((List.range (m + 1)).map g).tail = (List.range m).map fun k => g (k + 1) := by
  rw [List.range_succ_eq_map, List.map_cons, List.tail_cons, List.map_map]; rfl

private theorem head_digits (g : ℕ → ℕ) (m : ℕ) : ((List.range (m + 1)).map g).headD 0 = g 0 := by
  rw [List.range_succ_eq_map, List.map_cons]; rfl

/-- The Gram matrix of integer vectors is positive semidefinite. -/
private theorem gram_sum (m : ℕ) (u : ℕ → ℕ → ℝ) (v : ℕ → ℝ) :
    ∑ i ∈ Finset.range m, ∑ j ∈ Finset.range m, (∑ k ∈ Finset.range m, u i k * u j k) * v i * v j =
      ∑ k ∈ Finset.range m, (∑ i ∈ Finset.range m, u i k * v i) ^ 2 := by
  calc _ = ∑ i ∈ Finset.range m, ∑ j ∈ Finset.range m, ∑ k ∈ Finset.range m, u i k * v i * (u j k * v j) := by
          refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
          rw [Finset.sum_mul, Finset.sum_mul]; exact Finset.sum_congr rfl fun k _ => by ring
    _ = ∑ i ∈ Finset.range m, ∑ k ∈ Finset.range m, ∑ j ∈ Finset.range m, u i k * v i * (u j k * v j) :=
          Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ k ∈ Finset.range m, ∑ i ∈ Finset.range m, ∑ j ∈ Finset.range m, u i k * v i * (u j k * v j) :=
          Finset.sum_comm
    _ = _ := by simp only [sq, Finset.sum_mul_sum]

private theorem pE_val (b : Blk) (fv si : ℕ) (x : ℤ) (rv sj : ℕ) : pE b fv si (x, rv, sj) =
    ((Nat.add (Nat.shiftLeft 1 b.sb) 1 : ℕ) : ℤ) * x - (Int.subNatNat (digit (Nat.mul fv rv) b.wB (Nat.add b.m 1))
      (Nat.mul (pCm b) (Nat.add si sj)) + ((Nat.mul b.m (Nat.mul (pCm b) (pCm b)) : ℕ) : ℤ)) := rfl

/-- The check's entry: `s·R − (Σ_k (M + Cm)_ik (M + Cm)_jk − Cm(σ_i + σ_j) + m·Cm²)` is `s·R − Σ_k M_ik M_jk`. -/
private theorem pE_eq (b : Blk) (a c : ℕ → ℕ) (si sj : ℕ) (x : ℤ) (fv rv : ℕ)
    (hd : digit (Nat.mul fv rv) b.wB (Nat.add b.m 1) = ∑ k ∈ Finset.range b.m, a k * c k)
    (hsi : si = ∑ k ∈ Finset.range b.m, a k) (hsj : sj = ∑ k ∈ Finset.range b.m, c k) :
    pE b fv si (x, rv, sj) = ((2 ^ b.sb + 1 : ℕ) : ℤ) * x -
      ∑ k ∈ Finset.range b.m, (((a k : ℕ) : ℤ) - (pCm b : ℤ)) * (((c k : ℕ) : ℤ) - (pCm b : ℤ)) := by
  have e1 : ∑ k ∈ Finset.range b.m, (((a k : ℕ) : ℤ) - (pCm b : ℤ)) * (((c k : ℕ) : ℤ) - (pCm b : ℤ)) =
      ∑ k ∈ Finset.range b.m, ((a k : ℤ) * (c k : ℤ)) - (pCm b : ℤ) * (∑ k ∈ Finset.range b.m, (a k : ℤ)) -
        (pCm b : ℤ) * (∑ k ∈ Finset.range b.m, (c k : ℤ)) +
        (b.m : ℤ) * ((pCm b : ℤ) * (pCm b : ℤ)) := by
    rw [Finset.sum_congr rfl fun k _ => show (((a k : ℕ) : ℤ) - (pCm b : ℤ)) * (((c k : ℕ) : ℤ) - (pCm b : ℤ)) =
        (a k : ℤ) * (c k : ℤ) - (pCm b : ℤ) * (a k : ℤ) - (pCm b : ℤ) * (c k : ℤ) + (pCm b : ℤ) * (pCm b : ℤ) by ring]
    simp only [Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, Finset.sum_const, Finset.card_range,
      nsmul_eq_mul]
    ring
  rw [e1, pE_val, Int.subNatNat_eq_coe, hd, hsi, hsj, shl_one]
  simp only [Nat.mul_eq, Nat.add_eq]
  push_cast
  ring

/-- **Leaf L1** (K2b, K2g): the PSD check certifies its block's matrix. -/
private theorem psd_of_psdCheck (b : Blk) (h : psdCheck b = true) : PSDN b.tri b.m := by
  intro v
  rcases Nat.eq_zero_or_pos b.m with hm0 | hm
  · simp [hm0]
  rw [psdCheck_eq, Bool.and_eq_true] at h
  obtain ⟨hok, hall⟩ := h
  simp only [pOkB, Bool.and_eq_true, Nat.beq_eq, List.all_eq_true, Nat.blt_eq] at hok
  obtain ⟨⟨⟨hlen, hrow⟩, hdig⟩, hAB⟩ := hok
  have hpB : pB b = 2 ^ b.wB := shl_one _
  let f : ℕ → ℕ := fun i => b.mrows.getD i 0
  let d : ℕ → ℕ → ℕ := fun i k => digit (f i) b.wB k
  have hmrows : b.mrows = (List.range b.m).map f := by
    conv_lhs => rw [← map_range_getD b.mrows 0, hlen]
  have hdigs : pDigs b = (List.range b.m).map fun i => (List.range (b.m + 1)).map (d i) := by
    simp only [pDigs, hmrows, List.map_map]; rfl
  have hdlt : ∀ i < b.m, ∀ k < b.m + 1, d i k < 2 ^ b.wm := fun i hi k hk => by
    have := hdig _ (by rw [hdigs]; exact List.mem_map.2 ⟨i, List.mem_range.2 hi, rfl⟩) (d i k)
      (List.mem_map.2 ⟨k, List.mem_range.2 hk, rfl⟩)
    rwa [shl_one] at this
  have hfexp : ∀ i < b.m, f i = ∑ l ∈ Finset.range (b.m + 1), d i l * (2 ^ b.wB) ^ l := fun i hi => by
    have hlt := hrow (f i) (by rw [hmrows]; exact List.mem_map.2 ⟨i, List.mem_range.2 hi, rfl⟩)
    rw [shl_one, Nat.mul_eq, Nat.add_eq, pow_mul] at hlt
    conv_lhs => rw [base_expand _ _ _ hlt]
    exact Finset.sum_congr rfl fun l _ => by simp only [d, digit_eq]
  let sg : ℕ → ℕ := fun i => ∑ k ∈ Finset.range b.m, d i (k + 1)
  let rv : ℕ → ℕ := fun i => d i 0 + (∑ r ∈ Finset.range b.m, d i (b.m - r) * (2 ^ b.wB) ^ r) * 2 ^ b.wB
  have hsig : pSig b = (List.range b.m).map sg := by
    simp only [pSig, hdigs, List.map_map]
    refine List.map_congr_left fun i _ => ?_
    simp only [Function.comp_apply, tail_digits, foldl_nadd, zero_add, sg, lsum_range]
  have hrev : pRev b = (List.range b.m).map rv := by
    simp only [pRev, hdigs, List.map_map]
    refine List.map_congr_left fun i _ => ?_
    simp only [Function.comp_apply]
    rw [tail_digits, head_digits, horner, hpB]
    simp only [rv, Nat.add_eq, Nat.mul_eq]
    have : ∀ r ∈ Finset.range b.m, d i (b.m - 1 - r + 1) * (2 ^ b.wB) ^ r = d i (b.m - r) * (2 ^ b.wB) ^ r :=
      fun r hr => by have := Finset.mem_range.1 hr; congr 2; omega
    rw [Finset.sum_congr rfl this]
  have hsym := symRows_eq b.tri b.m (tri_rows b hm)
  have hrows : ∀ i < b.m, pRowOK b i (f i) (sg i) ((List.range b.m).map (triGet b.tri i)) = true := by
    simp only [pAll, hmrows, hsig, hsym, zip_range] at hall
    have := allFold (fun i (x : (ℕ × ℕ) × List ℤ) => pRowOK b i x.1.1 x.1.2 x.2)
      (fun i => ((f i, sg i), (List.range b.m).map (triGet b.tri i))) b.m
    rw [this] at hall
    simpa only [List.all_eq_true, List.mem_range] using hall
  have hAB' : (b.m + 1) * (2 ^ b.wm * 2 ^ b.wm) < 2 ^ b.wB := by
    simpa only [shl_one, hpB, Nat.mul_eq, Nat.add_eq] using hAB
  -- the entries of `E`
  let s : ℕ := 2 ^ b.sb + 1
  let G : ℕ → ℕ → ℤ := fun i j =>
    ∑ k ∈ Finset.range b.m, (((d i (k + 1) : ℕ) : ℤ) - (pCm b : ℤ)) * (((d j (k + 1) : ℕ) : ℤ) - (pCm b : ℤ))
  let Ez : ℕ → ℕ → ℤ := fun i j => (s : ℤ) * triGet b.tri i j - G i j
  have hE : ∀ i < b.m, ∀ j < b.m, pE b (f i) (sg i) (triGet b.tri i j, rv j, sg j) = Ez i j := by
    intro i hi j hj
    have hd : digit (Nat.mul (f i) (rv j)) b.wB (Nat.add b.m 1) =
        ∑ k ∈ Finset.range b.m, d i (k + 1) * d j (k + 1) := by
      rw [digit_eq, Nat.mul_eq, Nat.add_eq, hfexp i hi]
      exact kron _ _ _ (d i) (d j) (hdlt i hi) (hdlt j hj) hAB'
    exact pE_eq b (fun k => d i (k + 1)) (fun k => d j (k + 1)) (sg i) (sg j) (triGet b.tri i j) (f i) (rv j) hd rfl rfl
  -- every row is dominated
  have hdomz : ∀ i < b.m, ∑ j ∈ Finset.range b.m, (if j = i then 0 else |Ez i j|) ≤ Ez i i := by
    intro i hi
    have hr := hrows i hi
    simp only [pRowOK, nonneg_iff] at hr
    have hfold : pFold b i (f i) (sg i) ((List.range b.m).map (triGet b.tri i)) =
        (b.m, if i < b.m then pE b (f i) (sg i) (triGet b.tri i i, rv i, sg i) else 0,
          ∑ j ∈ Finset.range b.m, if j = i then 0 else |pE b (f i) (sg i) (triGet b.tri i j, rv j, sg j)|) := by
      simp only [pFold, hrev, hsig, zip_range]
      exact rowFold i (pE b (f i) (sg i)) (fun j => (triGet b.tri i j, rv j, sg j)) b.m
    rw [hfold] at hr
    simp only [if_pos hi] at hr
    rw [hE i hi i hi, Finset.sum_congr rfl fun j hj => by rw [hE i hi j (Finset.mem_range.1 hj)]] at hr
    change 0 ≤ Ez i i - _ at hr
    linarith
  -- the real matrices
  let E : ℕ → ℕ → ℝ := fun i j => (Ez i j : ℝ)
  have hEsym : ∀ i < b.m, ∀ j < b.m, E i j = E j i := fun i _ j _ => by
    simp only [E, Ez, G, triGet_symm b.tri i j]
    congr 2
    exact Finset.sum_congr rfl fun k _ => mul_comm _ _
  have hEdom : ∀ i < b.m, ∑ j ∈ Finset.range b.m, (if j = i then 0 else |E i j|) ≤ E i i := fun i hi => by
    have := hdomz i hi
    have h' : ((∑ j ∈ Finset.range b.m, (if j = i then 0 else |Ez i j|) : ℤ) : ℝ) ≤ (Ez i i : ℝ) := by exact_mod_cast this
    simpa [E, apply_ite (Int.cast : ℤ → ℝ), Int.cast_abs] using h'
  have hdd := dd_nonneg b.m E hEsym hEdom v
  have hgram := gram_sum b.m (fun i k => ((d i (k + 1) : ℕ) : ℝ) - (pCm b : ℝ)) v
  have hsplit : ∀ i j, (s : ℝ) * (triGet b.tri i j : ℝ) =
      (∑ k ∈ Finset.range b.m, (((d i (k + 1) : ℕ) : ℝ) - (pCm b : ℝ)) * (((d j (k + 1) : ℕ) : ℝ) - (pCm b : ℝ))) +
        E i j := fun i j => by
    simp only [E, Ez, G]; push_cast; ring
  have hs : (0 : ℝ) < s := by positivity
  have htot : (s : ℝ) * ∑ i ∈ Finset.range b.m, ∑ j ∈ Finset.range b.m, (triGet b.tri i j : ℝ) * v i * v j =
      ∑ k ∈ Finset.range b.m, (∑ i ∈ Finset.range b.m, (((d i (k + 1) : ℕ) : ℝ) - (pCm b : ℝ)) * v i) ^ 2 +
        ∑ i ∈ Finset.range b.m, ∑ j ∈ Finset.range b.m, E i j * v i * v j := by
    rw [← hgram, ← Finset.sum_add_distrib, Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [show (s : ℝ) * ((triGet b.tri i j : ℝ) * v i * v j) = ((s : ℝ) * (triGet b.tri i j : ℝ)) * v i * v j by ring,
      hsplit]
    ring
  have hsq : 0 ≤ ∑ k ∈ Finset.range b.m,
      (∑ i ∈ Finset.range b.m, (((d i (k + 1) : ℕ) : ℝ) - (pCm b : ℝ)) * v i) ^ 2 :=
    Finset.sum_nonneg fun k _ => sq_nonneg _
  by_contra hneg
  push Not at hneg
  have := mul_neg_of_pos_of_neg hs hneg
  linarith

/-! ### Codes, weights and moments, read on points (for L2–L4) -/

/-- The code `a·p + b` of a point. -/
private def code {p : ℕ} (z : V p) : ℕ := z.1.val * p + z.2.val

/-- **Codes below `p²` are the points.** -/
private theorem sum_codes (p : ℕ) [NeZero p] {M : Type*} [AddCommMonoid M] (F : V p → M) :
    ∑ t ∈ Finset.range (p * p), F (pt p t) = ∑ z : V p, F z := by
  have hp : 0 < p := Nat.pos_of_ne_zero (NeZero.ne p)
  refine Finset.sum_nbij' (pt p) code (fun _ _ => Finset.mem_univ _) (fun z _ => ?_) (fun t ht => ?_)
    (fun z _ => ?_) (fun _ _ => rfl)
  · simp only [Finset.mem_range, code]
    have h1 := z.1.val_lt; have h2 := z.2.val_lt
    nlinarith
  · have ht' := Finset.mem_range.1 ht
    simp only [code, pt, ZMod.val_natCast]
    rw [Nat.mod_eq_of_lt (Nat.div_lt_of_lt_mul ht'), Nat.mod_mod]
    exact Nat.div_add_mod' t p
  · simp only [code, pt]
    have h2 := z.2.val_lt
    rw [add_comm, Nat.add_mul_div_right _ _ hp, Nat.div_eq_of_lt h2, zero_add, Nat.add_mul_mod_self_right,
      Nat.mod_eq_of_lt h2]
    simp

private theorem sum_range_zmod (p : ℕ) [NeZero p] {M : Type*} [AddCommMonoid M] (G : ℕ → M) :
    ∑ j ∈ Finset.range p, G j = ∑ j : ZMod p, G j.val :=
  Finset.sum_nbij' (fun j => (j : ZMod p)) (fun j => j.val) (fun _ _ => Finset.mem_univ _)
    (fun j _ => Finset.mem_range.2 (ZMod.val_lt j)) (fun j hj => ZMod.val_cast_of_lt (Finset.mem_range.1 hj))
    (fun j _ => ZMod.natCast_zmod_val j) (fun j hj => by rw [ZMod.val_cast_of_lt (Finset.mem_range.1 hj)])

private theorem foldl_iadd {α : Type} (l : List α) (g : α → ℤ) (a : ℤ) :
    l.foldl (fun a j => Int.add a (g j)) a = a + (l.map g).sum := by
  induction l generalizing a with
  | nil => simp
  | cons x l ih => rw [List.foldl_cons, ih, List.map_cons, List.sum_cons]; show a + g x + _ = _; ring

/-- `⟨u, z⟩` for a direction given by its code. -/
private def dz {p : ℕ} (u : ℕ) (z : V p) : ZMod p := (pt p u).1 * z.1 + (pt p u).2 * z.2

private theorem dz_sub {p : ℕ} (u : ℕ) (z z' : V p) : dz u z' - dz u z = dz u (z' - z) := by
  simp only [dz, Prod.fst_sub, Prod.snd_sub]; ring

private theorem dotP_eq (p : ℕ) [NeZero p] (u t : ℕ) : dotP p u t = (dz u (pt p t)).val := by
  have e : dz u (pt p t) = ((u / p * (t / p) + u % p * (t % p) : ℕ) : ZMod p) := by
    simp only [dz, pt]; push_cast; ring
  rw [e, ZMod.val_natCast]; rfl

/-- `f` of a weight, read on `ZMod p`. -/
private def fz (C : Cert) [NeZero C.p] (fp : ℕ) (r : ZMod C.p) : ℤ := fval C fp r.val

/-- The virtual weight `x ↦ f(j + ⟨u, x⟩)` (`u ≠ 0`), `x ↦ f(0)` (`u = 0`). -/
private def gw (C : Cert) [NeZero C.p] (u fp : ℕ) (j : ZMod C.p) (z : V C.p) : ℤ :=
  if u = 0 then fz C fp 0 else fz C fp (j + dz u z)

/-- `κ` read on points. -/
private def kz (C : Cert) [NeZero C.p] (u fp : ℕ) (z : V C.p) : ℤ :=
  if u = 0 then ((C.p * C.p : ℕ) : ℤ) * (fz C fp 0 * fz C fp 0)
  else (C.p : ℤ) * ∑ j : ZMod C.p, fz C fp j * fz C fp (j + dz u z)

private theorem getD_of_lt {α : Type*} (l : List α) (d : α) {n : ℕ} (h : n < l.length) : l.getD n d = l[n] := by
  rw [List.getD_eq_getElem?_getD, List.getElem?_eq_getElem h]; rfl

private theorem weight_mem (C : Cert) (wi : ℕ) (hwi : wi < C.weights.length) :
    C.weights.getD wi (0, 0, 0) ∈ C.weights := getD_mem _ _ _ hwi

private theorem kappa_eq (C : Cert) [NeZero C.p] (wi : ℕ) (hwi : wi < C.weights.length) (t : ℕ) :
    kappa C wi t = kz C (C.weights.getD wi (0, 0, 0)).2.1 (C.weights.getD wi (0, 0, 0)).2.2 (pt C.p t) := by
  have hp : 0 < C.p := Nat.pos_of_ne_zero (NeZero.ne C.p)
  have hw : (wtab C).getD wi (0, []) = ((C.weights.getD wi (0, 0, 0)).2.1,
      (List.range C.p).map (autoc C (C.weights.getD wi (0, 0, 0)).2.1 (C.weights.getD wi (0, 0, 0)).2.2)) := by
    rw [getD_of_lt _ _ (by simpa [wtab] using hwi), getD_of_lt _ _ hwi]
    simp [wtab]
  generalize C.weights.getD wi (0, 0, 0) = W at hw
  obtain ⟨c0, u, fp⟩ := W
  simp only [kappa, kap, hw]
  have hidx : cond (Nat.beq u 0) 0 (dotP C.p u t) < C.p := by
    cases Nat.beq u 0
    · rw [dotP_eq]; exact ZMod.val_lt _
    · exact hp
  rw [getD_of_lt _ _ (by simpa using hidx), List.getElem_map, List.getElem_range]
  unfold autoc kz
  by_cases hu : u = 0
  · subst hu; simp [fz, ZMod.val_zero]
  · have hb : Nat.beq u 0 = false := Bool.eq_false_iff.2 fun h' => hu (Nat.eq_of_beq_eq_true h')
    simp only [hb, cond_false, hu, if_false]
    rw [foldl_iadd, zero_add, lsum_range, sum_range_zmod]
    show (C.p : ℤ) * _ = _
    congr 1
    refine Finset.sum_congr rfl fun j _ => ?_
    simp only [fz, dotP_eq, ZMod.val_add, Nat.add_eq]
    rfl

private theorem sigma_eq (C : Cert) [NeZero C.p] (wi : ℕ) (z : V C.p) :
    sigma C wi = (C.p : ℤ) * ∑ j : ZMod C.p,
      gw C (C.weights.getD wi (0, 0, 0)).2.1 (C.weights.getD wi (0, 0, 0)).2.2 j z := by
  unfold sigma
  generalize C.weights.getD wi (0, 0, 0) = W
  obtain ⟨c0, u, fp⟩ := W
  by_cases hu : u = 0
  · subst hu
    simp [gw, fz, ZMod.val_zero, Finset.sum_const, Finset.card_univ, ZMod.card]
    ring
  · have hb : Nat.beq u 0 = false := Bool.eq_false_iff.2 fun h' => hu (Nat.eq_of_beq_eq_true h')
    simp only [hb, cond_false, gw, hu, if_false]
    rw [foldl_iadd, zero_add, lsum_range, sum_range_zmod]
    show (C.p : ℤ) * _ = _
    congr 1
    exact (Fintype.sum_equiv (Equiv.addRight (dz u z)) (fun x => fz C fp (x + dz u z)) (fz C fp)
      fun x => rfl).symm

/-- **The autocorrelation**: `p · Σ_j g_j(z) g_j(z') = κ(z' − z)`. -/
private theorem sum_gw_mul (C : Cert) [NeZero C.p] (u fp : ℕ) (z z' : V C.p) :
    (C.p : ℤ) * ∑ j : ZMod C.p, gw C u fp j z * gw C u fp j z' = kz C u fp (z' - z) := by
  unfold gw kz
  by_cases hu : u = 0
  · subst hu
    simp [Finset.sum_const, Finset.card_univ, ZMod.card]; ring
  · simp only [hu, if_false]
    congr 1
    rw [← dz_sub]
    refine Fintype.sum_equiv (Equiv.addRight (dz u z)) _ _ fun j => ?_
    simp only [Equiv.coe_addRight]
    congr 2; ring

/-- The factor of a monomial at one translate: `Π_{y ∈ A} φ(γ(y + z))`. -/
private noncomputable def Psi {p : ℕ} (φ : V p → ℝ) (γ : V p × V p × Bool) (A : List ℕ) (z : V p) : ℝ :=
  (A.map fun y => φ (act γ (pt p y + z))).prod

private theorem act_trans {p : ℕ} (z w : V p) : act (z, ((1 : ZMod p), (0 : ZMod p)), false) w = w + z := by
  simp [act, cmul, cj]

private theorem trans_mem {p : ℕ} [NeZero p] (z : V p) : (z, ((1 : ZMod p), (0 : ZMod p)), false) ∈ affs p := by
  rw [mem_affs]; simp

/-- **(S1)** a translate's factor averages to the moment. -/
private theorem sum_Psi (p : ℕ) [NeZero p] (φ : V p → ℝ) (A : List ℕ) (z : V p) :
    ∑ γ ∈ affs p, Psi φ γ A z = Ym p φ A := by
  rw [Ym_eq, ← Yv_map_act φ (trans_mem z)]
  unfold Yv Psi
  refine Finset.sum_congr rfl fun γ _ => ?_
  simp only [List.map_map, Function.comp_def, act_trans]

/-- **(S2)** two translates' factors average to the moment of the pair, moved by the first translate. -/
private theorem sum_Psi_mul (p : ℕ) [NeZero p] (φ : V p → ℝ) (A A' : List ℕ) (z z' : V p) :
    ∑ γ ∈ affs p, Psi φ γ A z * Psi φ γ A' z' = Yv p φ (A.map (pt p) ++ (A'.map (pt p)).map (· + (z' - z))) := by
  rw [← Yv_map_act φ (trans_mem z)]
  unfold Yv Psi
  refine Finset.sum_congr rfl fun γ _ => ?_
  simp only [List.map_append, List.map_map, Function.comp_def, act_trans, List.prod_append]
  congr 3; funext y; congr 2; ring

private theorem Ym_pair (p : ℕ) [NeZero p] (φ : V p → ℝ) (A A' : List ℕ) (t : ℕ) :
    Ym p φ (A ++ A'.map fun x => addP p x t) = Yv p φ (A.map (pt p) ++ (A'.map (pt p)).map (· + pt p t)) := by
  rw [Ym_eq]; simp only [List.map_append, List.map_map, Function.comp_def, pt_addP]

/-- A map of `affs` is a bijection of `V`. -/
private theorem sum_act (p : ℕ) [NeZero p] {γ : V p × V p × Bool} (hγ : γ ∈ affs p) (F : V p → ℝ) :
    ∑ z : V p, F (act γ z) = ∑ z : V p, F z := by
  refine Fintype.sum_equiv ⟨act γ, act (inv γ), fun z => ?_, fun z => ?_⟩ _ _ fun z => rfl
  · rw [← act_comp, inv_comp hγ]; simp [act, cmul, cj]
  · rw [← act_comp, comp_inv hγ]; simp [act, cmul, cj]

/-- A block's terms at the moments, over a list of representative monomials: for each of its weights
`R₀₀ c² Y([]) + Σ_a 2 R₀,₁₊ₐ c σ Y(a) + Σ_{a,a'} R₁₊ₐ,₁₊ₐ' Σ_t κ(t) Y(a ∪ (a' + t))` (`SOUNDNESS.md` § 4). -/
private noncomputable def blockT (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (b : Blk) (reps : List (List ℕ)) : ℝ :=
  (b.wts.map fun wi =>
    (triGet b.tri 0 0 : ℝ) * (cval C wi : ℝ) ^ 2 * Ym C.p φ [] +
    ∑ a ∈ Finset.range reps.length,
      2 * (triGet b.tri 0 (1 + a) : ℝ) * (cval C wi : ℝ) * (sigma C wi : ℝ) * Ym C.p φ (reps.getD a []) +
    ∑ a ∈ Finset.range reps.length, ∑ a' ∈ Finset.range reps.length, (triGet b.tri (1 + a) (1 + a') : ℝ) *
      ∑ t ∈ Finset.range (C.p * C.p),
        (kappa C wi t : ℝ) * Ym C.p φ (reps.getD a [] ++ (reps.getD a' []).map fun x => addP C.p x t)).sum

/-- A quadratic form on a vector `(c, w₀, …, w_{N−1}, 0, …)`. -/
private theorem bvec_quad (tri : List (List ℤ)) (m N : ℕ) (c : ℝ) (w : ℕ → ℝ) (hm : N + 1 ≤ m) :
    ∑ i ∈ Finset.range m, ∑ l ∈ Finset.range m, (triGet tri i l : ℝ) *
      (if i = 0 then c else if i - 1 < N then w (i - 1) else 0) *
      (if l = 0 then c else if l - 1 < N then w (l - 1) else 0) =
    (triGet tri 0 0 : ℝ) * c ^ 2 + ∑ a ∈ Finset.range N, 2 * (triGet tri 0 (1 + a) : ℝ) * c * w a +
      ∑ a ∈ Finset.range N, ∑ a' ∈ Finset.range N, (triGet tri (1 + a) (1 + a') : ℝ) * (w a * w a') := by
  let v : ℕ → ℝ := fun k => if k = 0 then c else if k - 1 < N then w (k - 1) else 0
  let v' : ℕ → ℝ := fun k => if k = 0 then c else w (k - 1)
  have hv0 : ∀ k, N + 1 ≤ k → v k = 0 := fun k hk => by
    simp only [v]; rw [if_neg (by omega), if_neg (by omega)]
  have hvv : ∀ k ∈ Finset.range (N + 1), v k = v' k := fun k hk => by
    have := Finset.mem_range.1 hk
    simp only [v, v']; split_ifs <;> first | rfl | omega
  have hsub := Finset.range_subset_range.2 hm
  show ∑ i ∈ Finset.range m, ∑ l ∈ Finset.range m, (triGet tri i l : ℝ) * v i * v l = _
  rw [← Finset.sum_subset hsub fun i _ hi => Finset.sum_eq_zero fun l _ => by
    rw [hv0 i (by simpa using hi)]; ring]
  rw [Finset.sum_congr rfl fun i _ => (Finset.sum_subset hsub fun l _ hl => by
    rw [hv0 l (by simpa using hl)]; ring).symm]
  rw [Finset.sum_congr rfl fun i hi => Finset.sum_congr rfl fun l hl => by rw [hvv i hi, hvv l hl]]
  simp only [Finset.sum_range_succ', v', if_true, Nat.add_one_ne_zero, if_false, Nat.add_sub_cancel]
  rw [Finset.sum_add_distrib]
  have e1 : ∑ a ∈ Finset.range N, (triGet tri (a + 1) 0 : ℝ) * w a * c +
      ∑ a ∈ Finset.range N, (triGet tri 0 (a + 1) : ℝ) * c * w a =
      ∑ a ∈ Finset.range N, 2 * (triGet tri 0 (1 + a) : ℝ) * c * w a := by
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [triGet_symm tri (a + 1) 0, add_comm a 1]; ring
  have e2 : ∑ a ∈ Finset.range N, ∑ a' ∈ Finset.range N, (triGet tri (a + 1) (a' + 1) : ℝ) * w a * w a' =
      ∑ a ∈ Finset.range N, ∑ a' ∈ Finset.range N, (triGet tri (1 + a) (1 + a') : ℝ) * (w a * w a') :=
    Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun a' _ => by rw [add_comm a 1, add_comm a' 1]; ring
  rw [← e1, ← e2]; ring

/-- Sums over the pairs `(γ, j)`, expanded. -/
private theorem quad_expand {ι : Type*} (X : Finset ι) (N : ℕ) (K : ℝ) (L : ℕ → ℝ) (M : ℕ → ℕ → ℝ) (f : ι → ℕ → ℝ) :
    ∑ x ∈ X, (K + ∑ a ∈ Finset.range N, L a * f x a + ∑ a ∈ Finset.range N, ∑ a' ∈ Finset.range N,
      M a a' * (f x a * f x a')) =
    X.card * K + ∑ a ∈ Finset.range N, L a * ∑ x ∈ X, f x a +
      ∑ a ∈ Finset.range N, ∑ a' ∈ Finset.range N, M a a' * ∑ x ∈ X, f x a * f x a' := by
  rw [Finset.sum_add_distrib, Finset.sum_add_distrib, Finset.sum_const, nsmul_eq_mul]
  congr 2
  · rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun a _ => (Finset.mul_sum _ _ _).symm
  · rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun a' _ => (Finset.mul_sum _ _ _).symm

/-- The virtual coordinate `w_a(γ, j) = Σ_z g_j(z) Ψ_γ(A_a, z)`. -/
private noncomputable def wv (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (u fp : ℕ) (A : List ℕ)
    (x : (V C.p × V C.p × Bool) × ZMod C.p) : ℝ :=
  ∑ z : V C.p, (gw C u fp x.2 z : ℝ) * Psi φ x.1 A z

private theorem card_V (p : ℕ) [NeZero p] : ((Finset.univ : Finset (V p)).card : ℝ) = (p * p : ℕ) := by
  simp [Finset.card_univ, ZMod.card]

/-- **(H1)** the linear coordinate, summed: `p · Σ w_a = n · σ · Y(A_a)`. -/
private theorem sum_wv (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (wi : ℕ) (A : List ℕ) :
    (C.p : ℝ) * ∑ x ∈ affs C.p ×ˢ (Finset.univ : Finset (ZMod C.p)),
      wv C φ (C.weights.getD wi (0, 0, 0)).2.1 (C.weights.getD wi (0, 0, 0)).2.2 A x =
    ((C.p * C.p : ℕ) : ℝ) * (sigma C wi : ℝ) * Ym C.p φ A := by
  set u := (C.weights.getD wi (0, 0, 0)).2.1
  set fp := (C.weights.getD wi (0, 0, 0)).2.2
  unfold wv
  rw [Finset.sum_comm, Finset.mul_sum]
  have : ∀ z : V C.p, (C.p : ℝ) * ∑ x ∈ affs C.p ×ˢ (Finset.univ : Finset (ZMod C.p)),
      (gw C u fp x.2 z : ℝ) * Psi φ x.1 A z = (sigma C wi : ℝ) * Ym C.p φ A := fun z => by
    rw [Finset.sum_product, Finset.sum_comm, ← sum_Psi C.p φ A z]
    simp only [← Finset.mul_sum]
    rw [← Finset.sum_mul, ← mul_assoc]
    congr 1
    rw [sigma_eq C wi z]; push_cast; rfl
  rw [Finset.sum_congr rfl fun z _ => this z, Finset.sum_const, nsmul_eq_mul, card_V]; ring

/-- **(H2)** the quadratic coordinate, summed: `p · Σ w_a w_a' = n · Σ_t κ(t) Y(A_a ∪ (A_a' + t))`. -/
private theorem sum_wv_mul (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (wi : ℕ) (hwi : wi < C.weights.length)
    (A A' : List ℕ) :
    (C.p : ℝ) * ∑ x ∈ affs C.p ×ˢ (Finset.univ : Finset (ZMod C.p)),
      wv C φ (C.weights.getD wi (0, 0, 0)).2.1 (C.weights.getD wi (0, 0, 0)).2.2 A x *
      wv C φ (C.weights.getD wi (0, 0, 0)).2.1 (C.weights.getD wi (0, 0, 0)).2.2 A' x =
    ((C.p * C.p : ℕ) : ℝ) * ∑ t ∈ Finset.range (C.p * C.p),
      (kappa C wi t : ℝ) * Ym C.p φ (A ++ A'.map fun x => addP C.p x t) := by
  set u := (C.weights.getD wi (0, 0, 0)).2.1
  set fp := (C.weights.getD wi (0, 0, 0)).2.2
  unfold wv
  simp only [Finset.sum_mul_sum]
  rw [Finset.sum_comm]
  have inner : ∀ z z' : V C.p, (C.p : ℝ) * ∑ x ∈ affs C.p ×ˢ (Finset.univ : Finset (ZMod C.p)),
      (gw C u fp x.2 z : ℝ) * Psi φ x.1 A z * ((gw C u fp x.2 z' : ℝ) * Psi φ x.1 A' z') =
      (kz C u fp (z' - z) : ℝ) * Yv C.p φ (A.map (pt C.p) ++ (A'.map (pt C.p)).map (· + (z' - z))) := fun z z' => by
    rw [Finset.sum_product, Finset.sum_comm, ← sum_Psi_mul C.p φ A A' z z', ← sum_gw_mul C u fp z z']
    push_cast
    rw [mul_assoc, Finset.sum_mul]
    congr 1
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun γ _ => ?_
    ring
  have hz : ∀ z : V C.p, (C.p : ℝ) * ∑ x ∈ affs C.p ×ˢ (Finset.univ : Finset (ZMod C.p)), ∑ z' : V C.p,
      (gw C u fp x.2 z : ℝ) * Psi φ x.1 A z * ((gw C u fp x.2 z' : ℝ) * Psi φ x.1 A' z') =
      ∑ w : V C.p, (kz C u fp w : ℝ) * Yv C.p φ (A.map (pt C.p) ++ (A'.map (pt C.p)).map (· + w)) := fun z => by
    rw [Finset.sum_comm, Finset.mul_sum, Finset.sum_congr rfl fun z' _ => inner z z']
    exact Fintype.sum_equiv (Equiv.subRight z) _ _ fun z' => rfl
  rw [Finset.mul_sum, Finset.sum_congr rfl fun z _ => hz z, Finset.sum_const, nsmul_eq_mul, card_V]
  congr 1
  rw [← sum_codes C.p]
  refine Finset.sum_congr rfl fun t _ => ?_
  rw [kappa_eq C wi hwi t, Ym_pair]

/-- One weight's terms are non-negative. -/
private theorem weight_nonneg (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (b : Blk) (reps : List (List ℕ))
    (hpsd : PSDN b.tri b.m) (hm : reps.length + 1 ≤ b.m) (wi : ℕ) (hwi : wi < C.weights.length) :
    0 ≤ (triGet b.tri 0 0 : ℝ) * (cval C wi : ℝ) ^ 2 * Ym C.p φ [] +
    ∑ a ∈ Finset.range reps.length,
      2 * (triGet b.tri 0 (1 + a) : ℝ) * (cval C wi : ℝ) * (sigma C wi : ℝ) * Ym C.p φ (reps.getD a []) +
    ∑ a ∈ Finset.range reps.length, ∑ a' ∈ Finset.range reps.length, (triGet b.tri (1 + a) (1 + a') : ℝ) *
      ∑ t ∈ Finset.range (C.p * C.p),
        (kappa C wi t : ℝ) * Ym C.p φ (reps.getD a [] ++ (reps.getD a' []).map fun x => addP C.p x t) := by
  set u := (C.weights.getD wi (0, 0, 0)).2.1
  set fp := (C.weights.getD wi (0, 0, 0)).2.2
  set c := (cval C wi : ℝ)
  set N := reps.length
  let X := affs C.p ×ˢ (Finset.univ : Finset (ZMod C.p))
  let f : (V C.p × V C.p × Bool) × ZMod C.p → ℕ → ℝ := fun x a => wv C φ u fp (reps.getD a []) x
  have hQ : ∀ x ∈ X, 0 ≤ (triGet b.tri 0 0 : ℝ) * c ^ 2 +
      ∑ a ∈ Finset.range N, 2 * (triGet b.tri 0 (1 + a) : ℝ) * c * f x a +
      ∑ a ∈ Finset.range N, ∑ a' ∈ Finset.range N, (triGet b.tri (1 + a) (1 + a') : ℝ) * (f x a * f x a') :=
    fun x _ => by
      have := hpsd fun k => if k = 0 then c else if k - 1 < N then f x (k - 1) else 0
      rwa [bvec_quad b.tri b.m N c (f x) hm] at this
  have hsum := Finset.sum_nonneg hQ
  rw [quad_expand X N _ (fun a => 2 * (triGet b.tri 0 (1 + a) : ℝ) * c) (fun a a' => (triGet b.tri (1 + a) (1 + a') : ℝ)) f] at hsum
  have hp : (0 : ℝ) < C.p := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne C.p)
  have hX : (X.card : ℝ) = gsize C.p * C.p := by
    simp [X, gsize, Finset.card_product, Finset.card_univ, ZMod.card]
  have key : (C.p : ℝ) * ((X.card : ℝ) * ((triGet b.tri 0 0 : ℝ) * c ^ 2) +
      ∑ a ∈ Finset.range N, 2 * (triGet b.tri 0 (1 + a) : ℝ) * c * ∑ x ∈ X, f x a +
      ∑ a ∈ Finset.range N, ∑ a' ∈ Finset.range N, (triGet b.tri (1 + a) (1 + a') : ℝ) * ∑ x ∈ X, f x a * f x a') =
      ((C.p * C.p : ℕ) : ℝ) * ((triGet b.tri 0 0 : ℝ) * c ^ 2 * Ym C.p φ [] +
    ∑ a ∈ Finset.range N,
      2 * (triGet b.tri 0 (1 + a) : ℝ) * c * (sigma C wi : ℝ) * Ym C.p φ (reps.getD a []) +
    ∑ a ∈ Finset.range N, ∑ a' ∈ Finset.range N, (triGet b.tri (1 + a) (1 + a') : ℝ) *
      ∑ t ∈ Finset.range (C.p * C.p),
        (kappa C wi t : ℝ) * Ym C.p φ (reps.getD a [] ++ (reps.getD a' []).map fun x => addP C.p x t)) := by
    rw [mul_add, mul_add, mul_add, mul_add, Finset.mul_sum, Finset.mul_sum, Finset.mul_sum, Finset.mul_sum]
    congr 1; congr 1
    · rw [hX, Ym_nil]; push_cast; ring
    · refine Finset.sum_congr rfl fun a _ => ?_
      have := sum_wv C φ wi (reps.getD a [])
      calc (C.p : ℝ) * (2 * (triGet b.tri 0 (1 + a) : ℝ) * c * ∑ x ∈ X, f x a) =
          2 * (triGet b.tri 0 (1 + a) : ℝ) * c * ((C.p : ℝ) * ∑ x ∈ X, f x a) := by ring
        _ = _ := by rw [this]; ring
    · refine Finset.sum_congr rfl fun a _ => ?_
      rw [Finset.mul_sum, Finset.mul_sum]
      refine Finset.sum_congr rfl fun a' _ => ?_
      have := sum_wv_mul C φ wi hwi (reps.getD a []) (reps.getD a' [])
      calc (C.p : ℝ) * ((triGet b.tri (1 + a) (1 + a') : ℝ) * ∑ x ∈ X, f x a * f x a') =
          (triGet b.tri (1 + a) (1 + a') : ℝ) * ((C.p : ℝ) * ∑ x ∈ X, f x a * f x a') := by ring
        _ = _ := by rw [this]; ring
  have hn : (0 : ℝ) < ((C.p * C.p : ℕ) : ℝ) := by
    have := Nat.pos_of_ne_zero (NeZero.ne C.p); exact_mod_cast Nat.mul_pos this this
  have h2 := mul_nonneg hp.le hsum
  rw [key] at h2
  by_contra hneg
  push Not at hneg
  have := mul_neg_of_pos_of_neg hn hneg
  linarith

/-- **Leaf L2** (K2g, `SOUNDNESS.md` M6): a block whose matrix is positive semidefinite contributes a non-negative
number, for any `φ` — `p·T = Σ_j Σ_γ vᵀ R v` with `v₀ = c`, `v₁₊ₐ = Σ_x f(j + ⟨u, x⟩) Π_{a}(φ ∘ γ ∘ (· + x))`. -/
private theorem blockT_nonneg (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (b : Blk) (reps : List (List ℕ))
    (hpsd : PSDN b.tri b.m) (hm : reps.length + 1 ≤ b.m) (hw : ∀ wi ∈ b.wts, wi < C.weights.length) :
    0 ≤ blockT C φ b reps := by
  unfold blockT
  refine List.sum_nonneg fun x hx => ?_
  obtain ⟨wi, hwi, rfl⟩ := List.mem_map.1 hx
  exact weight_nonneg C φ b reps hpsd hm wi (hw wi hwi)

/-! ### Leaf L4: the q-part -/

private theorem opVal_opI (a : List ℕ) (t : ℕ) (b : List ℕ) (v : ℤ) : opVal (opI a t b v) = v := by
  simp only [opVal, opI]; exact Int.toNat_sub_toNat_neg v

private theorem opSum_cons (p : ℕ) [NeZero p] (φ : V p → ℝ) (o : Op) (l : List Op) :
    opSum p φ (o :: l) = (opVal o : ℝ) * Ym p φ (o.mono p) + opSum p φ l := by simp [opSum]

private theorem opSum_flatMap {α : Type} (p : ℕ) [NeZero p] (φ : V p → ℝ) (g : α → List Op) (l : List α) :
    opSum p φ (l.flatMap g) = (l.map fun x => opSum p φ (g x)).sum := by
  induction l with
  | nil => simp [opSum]
  | cons x l ih => rw [List.flatMap_cons, opSum_append, ih, List.map_cons, List.sum_cons]

private theorem opSum_map {α : Type} (p : ℕ) [NeZero p] (φ : V p → ℝ) (g : α → Op) (l : List α) :
    opSum p φ (l.map g) = (l.map fun x => (opVal (g x) : ℝ) * Ym p φ ((g x).mono p)).sum := by
  simp [opSum, List.map_map, Function.comp_def]

/-- The factor of a monomial under one map. -/
private noncomputable def Pm {p : ℕ} (φ : V p → ℝ) (γ : V p × V p × Bool) (m : List ℕ) : ℝ :=
  (m.map fun y => φ (act γ (pt p y))).prod

private theorem Ym_append (p : ℕ) [NeZero p] (φ : V p → ℝ) (m l : List ℕ) :
    Ym p φ (m ++ l) = ∑ γ ∈ affs p, Pm φ γ m * Pm φ γ l := by
  simp [Ym, Pm, List.map_append, List.prod_append]

private theorem act_add {p : ℕ} (γ : V p × V p × Bool) (z s : V p) :
    act γ (z + s) = act γ z + act (0, γ.2.1, γ.2.2) s := by
  simp only [act, cj_add, cmul_add, add_zero]; exact add_right_comm _ _ _

private theorem lin_mem {p : ℕ} [NeZero p] {γ : V p × V p × Bool} (hγ : γ ∈ affs p) : ((0 : V p), γ.2.1, γ.2.2) ∈ affs p := by
  rw [mem_affs] at *; exact hγ

private theorem act_lin_mem {p : ℕ} [NeZero p] {δ : V p × V p × Bool} (hδ : δ ∈ affs p) (h0 : δ.1 = 0) {s : V p}
    (hs : s ∈ unitCircle p) : act δ s ∈ unitCircle p := by
  rw [mem_unitCircle] at *; rw [mem_affs] at hδ
  simp only [act, h0, add_zero, norm_cmul, norm_cj, hδ, hs, one_mul]

/-- The linear part of a map of `affs` is a bijection of `S`. -/
private theorem sum_lin_S (p : ℕ) [NeZero p] {γ : V p × V p × Bool} (hγ : γ ∈ affs p) (F : V p → ℝ) :
    ∑ s ∈ unitCircle p, F (act (0, γ.2.1, γ.2.2) s) = ∑ s ∈ unitCircle p, F s := by
  have hδ := lin_mem hγ
  have hδ' := inv_mem hδ
  have hinv0 : (inv ((0 : V p), γ.2.1, γ.2.2)).1 = 0 := by simp [inv, cmul_zero, cj_zero]
  refine Finset.sum_nbij' (act (0, γ.2.1, γ.2.2)) (act (inv (0, γ.2.1, γ.2.2))) (fun s hs => act_lin_mem hδ rfl hs)
    (fun s hs => act_lin_mem hδ' hinv0 hs) (fun s _ => ?_) (fun s _ => ?_) (fun _ _ => rfl)
  · rw [← act_comp, inv_comp hδ]; simp [act, cmul, cj]
  · rw [← act_comp, comp_inv hδ]; simp [act, cmul, cj]

private theorem sum_filter_range (P : ℕ → Bool) (g : ℕ → ℝ) : ∀ n : ℕ,
    (((List.range n).filter P).map g).sum = ∑ x ∈ Finset.range n, if P x = true then g x else 0
  | 0 => rfl
  | n + 1 => by
    rw [List.range_succ, List.filter_append, List.map_append, List.sum_append, sum_filter_range P g n,
      Finset.sum_range_succ]
    cases h : P n <;> simp [List.filter, h]

private theorem isUnit_iff (p : ℕ) [NeZero p] (hp : 2 ≤ p) (x : ℕ) :
    isUnit p (Nat.div x p) (Nat.mod x p) = true ↔ pt p x ∈ unitCircle p := by
  rw [mem_unitCircle]
  simp only [isUnit, Nat.beq_eq, nmod, ndiv, Nat.add_eq, Nat.mul_eq, pt]
  rw [show ((x / p : ℕ) : ZMod p) ^ 2 + ((x % p : ℕ) : ZMod p) ^ 2 = (((x / p) * (x / p) + (x % p) * (x % p) : ℕ) : ZMod p)
    by push_cast; ring, show (1 : ZMod p) = ((1 : ℕ) : ZMod p) by simp, ZMod.natCast_eq_natCast_iff' _ _ p,
    Nat.mod_eq_of_lt (by omega : 1 < p)]

/-- The unit circle's codes, summed. -/
private theorem sum_sList (p : ℕ) [NeZero p] (hp : 2 ≤ p) (G : V p → ℝ) :
    ((sList p).map fun s => G (pt p s)).sum = ∑ s ∈ unitCircle p, G s := by
  unfold sList
  rw [show Nat.mul p p = p * p from rfl, sum_filter_range, ← Finset.sum_filter]
  rw [show ∑ x ∈ Finset.range (p * p) with isUnit p (Nat.div x p) (Nat.mod x p) = true, G (pt p x) =
      ∑ x ∈ Finset.range (p * p), (if pt p x ∈ unitCircle p then G (pt p x) else 0) by
    rw [Finset.sum_filter]; exact Finset.sum_congr rfl fun x _ => by simp only [isUnit_iff p hp]]
  rw [sum_codes p (fun z => if z ∈ unitCircle p then G z else 0), ← Finset.sum_filter]
  congr 1; ext z; simp [unitCircle]

private theorem sum_sList' (p : ℕ) [NeZero p] (hp : 2 ≤ p) (g : ℕ → ℝ) (G : V p → ℝ) (h : ∀ s, g s = G (pt p s)) :
    ((sList p).map g).sum = ∑ s ∈ unitCircle p, G s := by
  rw [List.map_congr_left fun s _ => h s]; exact sum_sList p hp G

private theorem mono_opI (p : ℕ) (a : List ℕ) (t : ℕ) (b : List ℕ) (v : ℤ) :
    (opI a t b v).mono p = a ++ b.map fun x => addP p x t := rfl

private theorem Ym_Pm (p : ℕ) [NeZero p] (φ : V p → ℝ) (m : List ℕ) : Ym p φ m = ∑ γ ∈ affs p, Pm φ γ m := rfl

/-- The bracket of `Q` at one map is `q(φ)`. -/
private theorem qbracket (p : ℕ) [NeZero p] (φ : V p → ℝ) {γ : V p × V p × Bool} (hγ : γ ∈ affs p) :
    ∑ z : V p, (2 * φ (act γ z) - 2 * (φ (act γ z) * φ (act γ z)) -
      ∑ s ∈ unitCircle p, φ (act γ z) * φ (act γ (z + s))) = qform p φ := by
  have h1 : ∀ z, ∑ s ∈ unitCircle p, φ (act γ z) * φ (act γ (z + s)) =
      ∑ s ∈ unitCircle p, φ (act γ z) * φ (act γ z + s) := fun z => by
    simp only [act_add]; exact sum_lin_S p hγ (fun s => φ (act γ z) * φ (act γ z + s))
  simp only [h1]
  rw [sum_act p hγ (fun w => 2 * φ w - 2 * (φ w * φ w) - ∑ s ∈ unitCircle p, φ w * φ (w + s))]
  unfold qform
  rw [Finset.sum_sub_distrib, Finset.sum_sub_distrib, Finset.mul_sum]
  congr 1
  rw [← Finset.sum_sub_distrib]
  exact Finset.sum_congr rfl fun z _ => by ring

/-- **One q-form** `Q(m)`: its ops evaluate to `cf · q(φ) · Y(m)`. -/
private theorem opSum_qmono (C : Cert) [NeZero C.p] (hp : 2 ≤ C.p) (φ : V C.p → ℝ) (m : List ℕ) (cf : ℤ) :
    opSum C.p φ ((List.range (C.p * C.p)).flatMap fun x =>
      opI m 0 [x] (Int.mul 2 cf) :: opI m 0 [x, x] (Int.neg (Int.mul 2 cf)) ::
        (sList C.p).map fun s => opI m 0 [x, addP C.p x s] (Int.neg cf)) =
      (cf : ℝ) * qform C.p φ * Ym C.p φ m := by
  rw [opSum_flatMap, lsum_range]
  have hx : ∀ x, opSum C.p φ (opI m 0 [x] (Int.mul 2 cf) :: opI m 0 [x, x] (Int.neg (Int.mul 2 cf)) ::
      (sList C.p).map fun s => opI m 0 [x, addP C.p x s] (Int.neg cf)) =
      ∑ γ ∈ affs C.p, Pm φ γ m * ((cf : ℝ) * (2 * φ (act γ (pt C.p x)) -
        2 * (φ (act γ (pt C.p x)) * φ (act γ (pt C.p x))) -
        ∑ s ∈ unitCircle C.p, φ (act γ (pt C.p x)) * φ (act γ (pt C.p x + s)))) := by
    intro x
    rw [opSum_cons, opSum_cons, opSum_map]
    simp only [opVal_opI, mono_opI, Ym_append]
    rw [sum_sList' C.p hp _ (fun w => ((Int.neg cf : ℤ) : ℝ) * ∑ γ ∈ affs C.p, Pm φ γ m *
      (φ (act γ (pt C.p x)) * φ (act γ (pt C.p x + w)))) fun s => by simp [Pm, pt_addP, pt_zero]]
    simp only [Pm, List.map_cons, List.map_nil, List.prod_cons, List.prod_nil, mul_one, pt_addP, pt_zero, add_zero]
    simp only [show Int.mul 2 cf = 2 * cf from rfl, show Int.neg (2 * cf) = -(2 * cf) from rfl,
      show Int.neg cf = -cf from rfl, Finset.mul_sum]
    rw [Finset.sum_comm (s := unitCircle C.p), ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun γ _ => ?_
    simp only [← mul_assoc, ← Finset.mul_sum]
    push_cast; ring
  rw [Finset.sum_congr rfl fun x _ => hx x, Finset.sum_comm]
  rw [Ym_Pm, Finset.mul_sum]
  refine Finset.sum_congr rfl fun γ hγ => ?_
  rw [← Finset.mul_sum, ← Finset.mul_sum]
  rw [sum_codes C.p (fun z => 2 * φ (act γ z) - 2 * (φ (act γ z) * φ (act γ z)) -
    ∑ s ∈ unitCircle C.p, φ (act γ z) * φ (act γ (z + s))), qbracket C.p φ hγ]
  ring

private theorem qfold {T : Type} (F : T → ℕ → ℤ) : ∀ (l : List (List ℕ × T)) (a0 : ℤ),
    l.foldl (fun a b => b.1.foldl (fun a wi => Int.add a (F b.2 wi)) a) a0 =
      a0 + (l.map fun b => (b.1.map (F b.2)).sum).sum
  | [], a0 => by simp
  | b :: l, a0 => by
    rw [List.foldl_cons, qfold F l, foldl_iadd, List.map_cons, List.sum_cons]; ring

private theorem foldl_cond {α : Type} (P : α → Bool) (g : α → ℤ) : ∀ (l : List α) (a : ℤ),
    l.foldl (fun s x => cond (P x) (Int.add s (g x)) s) a = a + (l.map fun x => if P x = true then g x else 0).sum
  | [], a => by simp
  | x :: l, a => by
    rw [List.foldl_cons, foldl_cond P g l, List.map_cons, List.sum_cons]
    cases h : P x
    · simp
    · simp only [cond_true, if_true]; show a + g x + _ = _; ring

private theorem finset_list_comm {α : Type} {M : Type*} [AddCommMonoid M] (s : Finset ℕ) (L : List α) (g : ℕ → α → M) :
    ∑ ν ∈ s, (L.map (g ν)).sum = (L.map fun b => ∑ ν ∈ s, g ν b).sum := by
  induction L with
  | nil => simp
  | cons b L ih => simp only [List.map_cons, List.sum_cons, Finset.sum_add_distrib, ih]

private theorem gList_bound (p : ℕ) (hp : 0 < p) : ∀ g ∈ gList p, g.1 < p ∧ g.2.1 < p := by
  suffices h : ∀ (l : List ℕ), (∀ x ∈ l, x < p * p) → ∀ g ∈ l.foldr (fun x acc =>
      cond (isUnit p (Nat.div x p) (Nat.mod x p)) ((Nat.div x p, Nat.mod x p, 0) :: (Nat.div x p, Nat.mod x p, 1) :: acc)
        acc) [], g.1 < p ∧ g.2.1 < p from h _ fun x hx => List.mem_range.1 hx
  intro l hl
  induction l with
  | nil => simp
  | cons x l ih =>
    intro g hg
    rw [List.foldr_cons] at hg
    have hx := hl x List.mem_cons_self
    have h1 : x / p < p := Nat.div_lt_of_lt_mul hx
    have h2 : x % p < p := Nat.mod_lt _ hp
    have ih' := ih fun y hy => hl y (List.mem_cons_of_mem _ hy)
    cases hu : isUnit p (Nat.div x p) (Nat.mod x p) <;> simp only [hu, cond_true, cond_false] at hg
    · exact ih' g hg
    · rcases List.mem_cons.1 hg with rfl | hg
      · exact ⟨h1, h2⟩
      rcases List.mem_cons.1 hg with rfl | hg
      · exact ⟨h1, h2⟩
      exact ih' g hg

private theorem getD_cases {α : Type*} (l : List α) (k : ℕ) (d : α) : l.getD k d ∈ l ∨ l.getD k d = d := by
  rw [List.getD_eq_getElem?_getD]
  cases h : l[k]? with
  | none => right; rfl
  | some a => left; exact List.mem_of_getElem? h

/-- A map of `gList` (or the default) has coordinates at most `p`. -/
private theorem gList_getD_le (p : ℕ) (hp : 0 < p) (k : ℕ) :
    ((gList p).getD k (0, 0, 0)).1 ≤ p ∧ ((gList p).getD k (0, 0, 0)).2.1 ≤ p := by
  rcases getD_cases (gList p) k (0, 0, 0) with h | h
  · exact ⟨(gList_bound p hp _ h).1.le, (gList_bound p hp _ h).2.le⟩
  · rw [h]; exact ⟨Nat.zero_le _, Nat.zero_le _⟩

/-- **The q-part's transporter**: `g(t₀) = t` with `g` a unit map gives `Y([0, t]) = Y([0, t₀])`. -/
private theorem Ym_transport (p : ℕ) [NeZero p] (φ : V p → ℝ) (c d e t0 t : ℕ) (hc : c ≤ p) (hd : d ≤ p)
    (hu : isUnit p c d = true) (h : gmap p c d e t0 = t) :
    Ym p φ ([0] ++ [0].map fun x => addP p x t) = Ym p φ [0, t0] := by
  have hδ : ((0 : V p), ((c : ZMod p), (d : ZMod p)), !Nat.beq e 0) ∈ affs p := (mem_affs _).2 (isUnit_norm p c d hu)
  rw [Ym_eq, Ym_eq]
  conv_rhs => rw [← Yv_map_act φ hδ]
  congr 1
  simp only [List.cons_append, List.nil_append, List.map_cons, List.map_nil, pt_addP, pt_zero, zero_add, ← h,
    pt_gmap p c d e t0 hc hd, act, cj_zero, cmul_zero, add_zero]

private theorem zip_range_map {α β : Type} (l : List α) (g : α → β) (d : α) (n : ℕ) (hl : l.length = n) :
    (List.range n).zip (l.map g) = (List.range n).map fun i => (i, g (l.getD i d)) := by
  subst hl
  refine List.ext_getElem (by simp) fun i h1 h2 => ?_
  simp only [List.getElem_zip, List.getElem_range, List.getElem_map]
  rw [getD_of_lt _ _ (by simpa using h2)]

/-- A double list sum over blocks and their weights. -/
private def Lam (L : List Blk) (F : Blk → ℕ → ℝ) : ℝ := (L.map fun b => (b.wts.map (F b)).sum).sum

private theorem Lam_add (L : List Blk) (F G : Blk → ℕ → ℝ) : Lam L (fun b wi => F b wi + G b wi) = Lam L F + Lam L G := by
  simp only [Lam, List.sum_map_add]

private theorem Lam_mul (L : List Blk) (F : Blk → ℕ → ℝ) (y : ℝ) : Lam L F * y = Lam L fun b wi => F b wi * y := by
  simp only [Lam, ← List.sum_map_mul_right]

private theorem Lam_fsum (L : List Blk) (s : Finset ℕ) (G : ℕ → Blk → ℕ → ℝ) :
    ∑ ν ∈ s, Lam L (G ν) = Lam L fun b wi => ∑ ν ∈ s, G ν b wi := by
  simp only [Lam]
  rw [finset_list_comm]
  congr 1; refine List.map_congr_left fun b _ => ?_
  exact finset_list_comm s b.wts fun ν => G ν b

private theorem Lam_congr (L : List Blk) (F G : Blk → ℕ → ℝ) (h : ∀ b ∈ L, ∀ wi ∈ b.wts, F b wi = G b wi) :
    Lam L F = Lam L G := by
  simp only [Lam]; congr 1; refine List.map_congr_left fun b hb => ?_
  congr 1; exact List.map_congr_left fun wi hwi => h b hb wi hwi

private theorem zip_map_range {α β : Type} (l : List α) (g : ℕ → β) (d : α) :
    l.zip ((List.range l.length).map g) = (List.range l.length).map fun i => (l.getD i d, g i) := by
  refine List.ext_getElem (by simp) fun i h1 h2 => ?_
  simp only [List.getElem_zip, List.getElem_range, List.getElem_map]
  rw [getD_of_lt _ _ (by simpa using h2)]

/-! ### Leaf L3: phase 1's buckets -/

/-- Buckets of at most 16, every one but the last full. -/
private def Bk {α : Type} (L : List (List α)) : Prop :=
  ∀ k < L.length, (L.getD k []).length ≤ 16 ∧ (k + 1 < L.length → (L.getD k []).length = 16)

private theorem Bk_cons {α : Type} {b : List α} {L : List (List α)} (h : Bk (b :: L)) :
    b.length ≤ 16 ∧ (L ≠ [] → b.length = 16) ∧ Bk L := by
  refine ⟨(h 0 (by simp)).1, fun hL => (h 0 (by simp)).2 (by simpa using List.length_pos_of_ne_nil hL),
    fun k hk => ?_⟩
  have := h (k + 1) (by simp; omega)
  simp only [List.getD_cons_succ, List.length_cons] at this
  exact ⟨this.1, fun h' => this.2 (by omega)⟩

private theorem modify_append {α : Type} (f : α → α) : ∀ (l l' : List α) (r : ℕ),
    (l ++ l').modify r f = if r < l.length then l.modify r f ++ l' else l ++ l'.modify (r - l.length) f
  | [], l', r => by simp
  | a :: l, l', r => by
    rw [List.cons_append, List.modify_cons, List.modify_cons]
    cases r with
    | zero => simp
    | succ r =>
      simp only [Nat.add_one_ne_zero, if_false, Nat.add_sub_cancel, modify_append f l l' r, List.length_cons]
      by_cases h : r < l.length
      · rw [if_pos h, if_pos (by omega)]; rfl
      · rw [if_neg h, if_neg (by omega), Nat.add_sub_add_right]; rfl

private theorem getD_app {α : Type} (l l' : List α) (d : α) {n : ℕ} (h : n < l.length) :
    (l ++ l').getD n d = l.getD n d := by
  rw [List.getD_eq_getElem?_getD, List.getElem?_append_left h, ← List.getD_eq_getElem?_getD]

private theorem getD_app_right {α : Type} (l l' : List α) (d : α) {n : ℕ} (h : l.length ≤ n) :
    (l ++ l').getD n d = l'.getD (n - l.length) d := by
  rw [List.getD_eq_getElem?_getD, List.getElem?_append_right h, ← List.getD_eq_getElem?_getD]

private theorem getD_default {α : Type} (l : List α) (d : α) {n : ℕ} (h : l.length ≤ n) : l.getD n d = d := by
  rw [List.getD_eq_getElem?_getD, List.getElem?_eq_none h]; rfl

private theorem Bk_getD {α : Type} (d : α) : ∀ (L : List (List α)), Bk L → ∀ r,
    L.flatten.getD r d = (L.getD (r / 16) []).getD (r % 16) d
  | [], _, r => by simp
  | b :: L, h, r => by
    obtain ⟨hb, hb16, hL⟩ := Bk_cons h
    rw [List.flatten_cons]
    by_cases hr : r < 16
    · rw [Nat.div_eq_of_lt hr, Nat.mod_eq_of_lt hr, List.getD_cons_zero]
      by_cases hrb : r < b.length
      · exact getD_app _ _ _ hrb
      · by_cases hL0 : L = []
        · subst hL0; simp
        · exact absurd (hb16 hL0) (by omega)
    · have e1 : r / 16 = (r - 16) / 16 + 1 := by omega
      have e2 : r % 16 = (r - 16) % 16 := by omega
      rw [e1, e2, List.getD_cons_succ]
      by_cases hL0 : L = []
      · subst hL0; simp only [List.flatten_nil, List.append_nil, List.getD_nil]
        rw [getD_default _ _ (by omega)]
      · rw [getD_app_right _ _ _ (by rw [hb16 hL0]; omega), hb16 hL0]
        exact Bk_getD d L hL (r - 16)

private theorem Bk_mem (L : List (List ORow)) (h : Bk L) (r : ℕ) : bmem L r = true ↔ r < L.flatten.length := by
  induction L generalizing r with
  | nil => simp [bmem]
  | cons b L ih =>
    obtain ⟨hb, hb16, hL⟩ := Bk_cons h
    simp only [bmem, Bool.and_eq_true, Nat.blt_eq, ndiv, nmod, List.flatten_cons, List.length_append,
      List.length_cons] at ih ⊢
    by_cases hr : r < 16
    · rw [Nat.div_eq_of_lt hr, Nat.mod_eq_of_lt hr, List.getD_cons_zero]
      by_cases hL0 : L = []
      · subst hL0; simp
      · rw [hb16 hL0]; omega
    · have e1 : r / 16 = (r - 16) / 16 + 1 := by omega
      have e2 : r % 16 = (r - 16) % 16 := by omega
      rw [e1, e2, List.getD_cons_succ]
      by_cases hL0 : L = []
      · subst hL0; simp; omega
      · rw [hb16 hL0]
        have := ih hL (r - 16)
        constructor
        · rintro ⟨h1, h2⟩; have := this.1 ⟨by omega, h2⟩; omega
        · intro h'; have := this.2 (by omega); exact ⟨by omega, this.2⟩

private theorem Bk_mod (L : List (List ORow)) (h : Bk L) (r : ℕ) (f : ORow → ORow) :
    Bk (bmod L r f) ∧ (bmod L r f).flatten = L.flatten.modify r f := by
  constructor
  · intro k hk
    simp only [bmod, List.length_modify] at hk ⊢
    rw [getD_modify _ _ _ _ _ hk]
    split_ifs
    · rw [List.length_modify]; exact h k hk
    · exact h k hk
  · induction L generalizing r with
    | nil => simp [bmod]
    | cons b L ih =>
      obtain ⟨hb, hb16, hL⟩ := Bk_cons h
      simp only [bmod, ndiv, nmod] at ih ⊢
      rw [List.modify_cons, List.flatten_cons, modify_append]
      by_cases hr : r < 16
      · rw [if_pos (Nat.div_eq_of_lt hr), Nat.mod_eq_of_lt hr, List.flatten_cons]
        by_cases hrb : r < b.length
        · rw [if_pos hrb]
        · by_cases hL0 : L = []
          · subst hL0; rw [if_neg hrb, List.modify_eq_self (by omega)]; simp
          · exact absurd (hb16 hL0) (by omega)
      · rw [if_neg (by omega), List.flatten_cons]
        by_cases hL0 : L = []
        · subst hL0; simp only [List.modify_nil, List.flatten_nil, List.append_nil]
          rw [if_neg (by omega)]
        · rw [if_neg (by rw [hb16 hL0]; omega), hb16 hL0]
          have e1 : r / 16 - 1 = (r - 16) / 16 := by omega
          have e2 : r % 16 = (r - 16) % 16 := by omega
          rw [e1, e2, ih hL (r - 16)]

private theorem bget_eq (L : List (List ORow)) (h : Bk L) (r : ℕ) : bget L r = L.flatten.getD r ([], [], 0, 0) := by
  rw [Bk_getD _ L h r]; rfl

/-- `bucket16`'s recursion. -/
private def brec {α : Type} (n : ℕ) : List α → List (List α) :=
  Nat.rec (motive := fun _ => List α → List (List α)) (fun _ => [])
    (fun _ ih l => cond l.isEmpty [] (l.take 16 :: ih (l.drop 16))) n

private theorem brec_spec {α : Type} : ∀ (n : ℕ) (l : List α), l.length ≤ 16 * n →
    (brec n l).flatten = l ∧ Bk (brec n l) ∧ (brec n l = [] → l = [])
  | 0, l, h => by
    have : l = [] := List.eq_nil_of_length_eq_zero (by omega)
    subst this; exact ⟨rfl, fun k hk => absurd hk (by simp [brec]), fun _ => rfl⟩
  | n + 1, l, h => by
    have e : brec (n + 1) l = cond l.isEmpty [] (l.take 16 :: brec n (l.drop 16)) := rfl
    cases hl : l.isEmpty
    · rw [e, hl, cond_false]
      have hne : l ≠ [] := by intro h'; subst h'; simp at hl
      obtain ⟨h1, h2, h3⟩ := brec_spec n (l.drop 16) (by rw [List.length_drop]; omega)
      refine ⟨by rw [List.flatten_cons, h1, List.take_append_drop], fun k hk => ?_, fun h' => by simp at h'⟩
      cases k with
      | zero =>
        simp only [List.getD_cons_zero, List.length_take, List.length_cons]
        refine ⟨min_le_left _ _, fun h' => ?_⟩
        have : brec n (l.drop 16) ≠ [] := by intro h0; rw [h0] at h'; simp at h'
        have : l.drop 16 ≠ [] := fun h0 => this (by rw [h0]; cases n <;> rfl)
        have : 16 < l.length := by
          by_contra hc; exact this (List.drop_eq_nil_of_le (by omega))
        omega
      | succ k =>
        simp only [List.getD_cons_succ, List.length_cons] at hk ⊢
        exact ⟨(h2 k (by omega)).1, fun h' => (h2 k (by omega)).2 (by omega)⟩
    · have : l = [] := List.isEmpty_iff.1 hl
      subst this; rw [e]; exact ⟨rfl, fun k hk => absurd hk (by simp), fun _ => rfl⟩

private theorem bucket16_spec {α : Type} (l : List α) : (bucket16 l).flatten = l ∧ Bk (bucket16 l) := by
  obtain ⟨h1, h2, -⟩ := brec_spec (Nat.add (Nat.div l.length 16) 1) l
    (by simp only [Nat.add_eq, ndiv]; omega)
  exact ⟨h1, h2⟩

/-! ### Leaf L3: the transport, the swap and the pairs -/

private theorem kz_neg (C : Cert) [NeZero C.p] (u fp : ℕ) (w : V C.p) : kz C u fp (-w) = kz C u fp w := by
  unfold kz
  split_ifs with hu
  · rfl
  · congr 1
    have hd : dz u (-w) = -dz u w := by simp only [dz, Prod.fst_neg, Prod.snd_neg]; ring
    rw [hd]
    refine Fintype.sum_equiv (Equiv.addRight (-dz u w)) _ _ fun j => ?_
    simp only [Equiv.coe_addRight, neg_add_cancel_right]; ring

/-- The moment of `X ∪ (Y + w)`, read from `Y`'s side. -/
private theorem act_trans_fun {p : ℕ} (z : V p) : act (z, ((1 : ZMod p), (0 : ZMod p)), false) = fun w => w + z :=
  funext (act_trans z)

private theorem Yv_pair_swap (p : ℕ) [NeZero p] (φ : V p → ℝ) (X Y : List (V p)) (w : V p) :
    Yv p φ (X ++ Y.map (· + w)) = Yv p φ (Y ++ X.map (· + -w)) := by
  rw [← Yv_map_act φ (trans_mem (-w))]
  refine Yv_perm φ ?_
  simp only [List.map_append, List.map_map, Function.comp_def, act_trans_fun, add_neg_cancel_right, List.map_id']
  exact List.perm_append_comm

/-- **The swap**: `Σ_w κ(w) Y(Y_j ∪ (Y_i + w)) = Σ_w κ(w) Y(Y_i ∪ (Y_j + w))` (`κ` even). -/
private theorem sum_pair_swap (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (u fp : ℕ) (X Y : List (V C.p)) :
    ∑ w : V C.p, (kz C u fp w : ℝ) * Yv C.p φ (Y ++ X.map (· + w)) =
      ∑ w : V C.p, (kz C u fp w : ℝ) * Yv C.p φ (X ++ Y.map (· + w)) := by
  simp only [Yv_pair_swap C.p φ Y X]
  refine Fintype.sum_equiv (Equiv.neg _) _ _ fun w => ?_
  simp only [Equiv.neg_apply, kz_neg]

private theorem act_lin_add {p : ℕ} (s : V p) (e : Bool) (y z : V p) :
    act ((0 : V p), s, e) (y + z) = act (0, s, e) y + act (0, s, e) z := by
  simp only [act, cj_add, cmul_add, add_zero]

/-- **The transport** of one orbit row onto its pair, for one weight. -/
private theorem transport_w (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (u fp : ℕ) (A0 A1 ai aj : List ℕ)
    (c d e : ℕ) (hc : c ≤ C.p) (hd : d ≤ C.p) (hu : isUnit C.p c d = true)
    (hsw : ((A0.map (gmap C.p c d e)).Perm ai ∧ (A1.map (gmap C.p c d e)).Perm aj) ∨
      ((A0.map (gmap C.p c d e)).Perm aj ∧ (A1.map (gmap C.p c d e)).Perm ai)) :
    ∑ t ∈ Finset.range (C.p * C.p), (kz C u fp (pt C.p (gmap C.p c d e t)) : ℝ) *
      Ym C.p φ (A0 ++ A1.map fun x => addP C.p x t) =
    ∑ t ∈ Finset.range (C.p * C.p), (kz C u fp (pt C.p t) : ℝ) * Ym C.p φ (ai ++ aj.map fun x => addP C.p x t) := by
  set δ : V C.p × V C.p × Bool := ((0 : V C.p), ((c : ZMod C.p), (d : ZMod C.p)), !Nat.beq e 0)
  have hδ : δ ∈ affs C.p := (mem_affs _).2 (isUnit_norm C.p c d hu)
  have hg : ∀ x, pt C.p (gmap C.p c d e x) = act δ (pt C.p x) := fun x => by
    rw [pt_gmap C.p c d e x hc hd]; simp [δ, act]
  simp only [Ym_pair, hg]
  rw [sum_codes C.p (fun z => (kz C u fp (act δ z) : ℝ) * Yv C.p φ (A0.map (pt C.p) ++ (A1.map (pt C.p)).map (· + z))),
    sum_codes C.p (fun z => (kz C u fp z : ℝ) * Yv C.p φ (ai.map (pt C.p) ++ (aj.map (pt C.p)).map (· + z)))]
  have hlin : ∀ y z : V C.p, act δ (y + z) = act δ y + act δ z := act_lin_add _ _
  have himg : ∀ z, Yv C.p φ (A0.map (pt C.p) ++ (A1.map (pt C.p)).map (· + z)) =
      Yv C.p φ ((A0.map (gmap C.p c d e)).map (pt C.p) ++ ((A1.map (gmap C.p c d e)).map (pt C.p)).map (· + act δ z)) :=
    fun z => by
      rw [← Yv_map_act φ hδ]
      congr 1
      simp only [List.map_append, List.map_map, Function.comp_def, hg, hlin]
  simp only [himg]
  rcases hsw with ⟨h0, h1⟩ | ⟨h0, h1⟩
  · simp only [Yv_perm φ ((h0.map (pt C.p)).append ((h1.map (pt C.p)).map _))]
    exact sum_act C.p hδ (fun w => (kz C u fp w : ℝ) * Yv C.p φ (ai.map (pt C.p) ++ (aj.map (pt C.p)).map (· + w)))
  · simp only [Yv_perm φ ((h0.map (pt C.p)).append ((h1.map (pt C.p)).map _))]
    rw [sum_act C.p hδ (fun w => (kz C u fp w : ℝ) * Yv C.p φ (aj.map (pt C.p) ++ (ai.map (pt C.p)).map (· + w)))]
    exact sum_pair_swap C φ u fp _ _

/-- `W(i, j)`, the pair's moment sum, is symmetric. -/
private theorem W_symm (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (u fp : ℕ) (ai aj : List ℕ) :
    ∑ t ∈ Finset.range (C.p * C.p), (kz C u fp (pt C.p t) : ℝ) * Ym C.p φ (aj ++ ai.map fun x => addP C.p x t) =
    ∑ t ∈ Finset.range (C.p * C.p), (kz C u fp (pt C.p t) : ℝ) * Ym C.p φ (ai ++ aj.map fun x => addP C.p x t) := by
  simp only [Ym_pair]
  rw [sum_codes C.p (fun z => (kz C u fp z : ℝ) * Yv C.p φ (aj.map (pt C.p) ++ (ai.map (pt C.p)).map (· + z))),
    sum_codes C.p (fun z => (kz C u fp z : ℝ) * Yv C.p φ (ai.map (pt C.p) ++ (aj.map (pt C.p)).map (· + z)))]
  exact sum_pair_swap C φ u fp _ _

/-- The pairs `i ≤ j`, as a double sum. -/
private theorem repPairs_sum {M : Type*} [AddCommMonoid M] (G : ℕ × ℕ → M) (N : ℕ) :
    ((repPairs N).map G).sum = ∑ i ∈ Finset.range N, ∑ k ∈ Finset.range (N - i), G (i, i + k) := by
  have hfm : ∀ (l : List ℕ) (f : ℕ → List (ℕ × ℕ)), ((l.flatMap f).map G).sum = (l.map fun i => ((f i).map G).sum).sum := by
    intro l f; induction l with
    | nil => rfl
    | cons x l ih => rw [List.flatMap_cons, List.map_append, List.sum_append, ih, List.map_cons, List.sum_cons]
  rw [repPairs, hfm, lsum_range]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [List.range'_eq_map_range, List.map_map, List.map_map, lsum_range]; rfl

/-- **Doubling**: over the pairs `i ≤ j`, `mult·F` sums to the full double sum of a symmetric `F`. -/
private theorem pairs_double (F : ℕ → ℕ → ℝ) (hF : ∀ i j, F i j = F j i) : ∀ N : ℕ,
    ∑ i ∈ Finset.range N, ∑ k ∈ Finset.range (N - i), (if i = i + k then (1 : ℝ) else 2) * F i (i + k) =
      ∑ a ∈ Finset.range N, ∑ a' ∈ Finset.range N, F a a'
  | 0 => by simp
  | N + 1 => by
    have hrow : ∀ i ∈ Finset.range N, ∑ k ∈ Finset.range (N + 1 - i), (if i = i + k then (1 : ℝ) else 2) * F i (i + k) =
        ∑ k ∈ Finset.range (N - i), (if i = i + k then (1 : ℝ) else 2) * F i (i + k) + 2 * F i N := fun i hi => by
      have := Finset.mem_range.1 hi
      rw [show N + 1 - i = (N - i) + 1 by omega, Finset.sum_range_succ, if_neg (by omega),
        show i + (N - i) = N by omega]
    rw [Finset.sum_range_succ, Finset.sum_congr rfl hrow, Finset.sum_add_distrib, pairs_double F hF N]
    simp only [Nat.add_sub_cancel_left, Finset.sum_range_one, add_zero, if_pos, one_mul]
    rw [Finset.sum_range_succ, Finset.sum_range_succ]
    simp only [Finset.sum_range_succ, Finset.sum_add_distrib]
    rw [← Finset.mul_sum]
    have : ∑ a ∈ Finset.range N, F N a = ∑ a ∈ Finset.range N, F a N := Finset.sum_congr rfl fun a _ => hF N a
    rw [this]; ring

/-! ### Leaf L3: one pair of phase 1 -/

private theorem shl_eq (a k : ℕ) : Nat.shiftLeft a k = a * 2 ^ k := by
  rw [show Nat.shiftLeft a k = a <<< k from rfl, Nat.shiftLeft_eq]

private theorem foldl_nadd' {α : Type} (l : List α) (h : α → ℕ) (a : ℕ) :
    l.foldl (fun a x => Nat.add a (h x)) a = a + (l.map h).sum := by
  induction l generalizing a with
  | nil => simp
  | cons x l ih => rw [List.foldl_cons, ih, List.map_cons, List.sum_cons, Nat.add_eq, add_assoc]

private theorem zip_map_same {α β γ : Type} (l : List α) (f : α → β) (g : α → γ) :
    (l.map f).zip (l.map g) = l.map fun x => (f x, g x) := by
  induction l with
  | nil => rfl
  | cons x l ih => simp [ih]

private theorem list_sum_comm {α β : Type} (l1 : List α) (l2 : List β) (f : α → β → ℝ) :
    (l1.map fun x => (l2.map (f x)).sum).sum = (l2.map fun y => (l1.map fun x => f x y).sum).sum := by
  induction l1 with
  | nil => simp
  | cons x l1 ih => simp only [List.map_cons, List.sum_cons, ih, ← List.sum_map_add]

private theorem list_sub_sum {α : Type} (l : List α) (f g : α → ℝ) :
    (l.map f).sum - (l.map g).sum = (l.map fun x => f x - g x).sum := by
  induction l with
  | nil => simp
  | cons x l ih => simp only [List.map_cons, List.sum_cons, ← ih]; ring

/-- Two lists of at most seven points with one bag key are one multiset. -/
private theorem bag_perm (l l' : List ℕ) (h : bag l = bag l') (hl : l.length < 8) (hl' : l'.length < 8) : l.Perm l' := by
  have hx : ∀ x ∈ l, x < l.sum + l'.sum + 1 := fun x hx => by have := List.le_sum_of_mem hx; omega
  have hx' : ∀ x ∈ l', x < l.sum + l'.sum + 1 := fun x hx => by have := List.le_sum_of_mem hx; omega
  have h1 := dec_bag _ l hl hx
  have h2 := dec_bag _ l' hl' hx'
  rw [h] at h1
  exact h1.symm.trans h2

private theorem pack_succ (B : ℕ) (a : ℕ → ℕ) (k n : ℕ) :
    (∑ i ∈ Finset.range n, a (k + 1 + i) * B ^ i) * B + a k = ∑ i ∈ Finset.range (n + 1), a (k + i) * B ^ i := by
  rw [Finset.sum_range_succ', Finset.sum_mul]
  simp only [add_zero, pow_zero, mul_one]
  congr 1
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [pow_succ, ← mul_assoc, show k + 1 + i = k + (i + 1) by omega]

/-- `krow` packs `t ↦ max(±v_t, 0)` at width `w`. -/
private theorem krow_eq (C : Cert) (bt : List (ℕ × List ℤ)) (c d e : ℕ) :
    krow C bt c d e = (∑ t ∈ Finset.range (C.p * C.p), Int.toNat (kblock C bt (gmap C.p c d e t)) * (2 ^ C.w) ^ t,
      ∑ t ∈ Finset.range (C.p * C.p), Int.toNat (Int.neg (kblock C bt (gmap C.p c d e t))) * (2 ^ C.w) ^ t) := by
  unfold krow
  rw [show Nat.mul C.p C.p = C.p * C.p from rfl, List.range_eq_range']
  generalize C.p * C.p = n
  suffices ∀ k, (List.range' k n).foldr (fun t acc =>
      (Nat.add (Nat.shiftLeft acc.1 C.w) (Int.toNat (kblock C bt (gmap C.p c d e t))),
        Nat.add (Nat.shiftLeft acc.2 C.w) (Int.toNat (Int.neg (kblock C bt (gmap C.p c d e t)))))) (0, 0) =
      (∑ i ∈ Finset.range n, Int.toNat (kblock C bt (gmap C.p c d e (k + i))) * (2 ^ C.w) ^ i,
        ∑ i ∈ Finset.range n, Int.toNat (Int.neg (kblock C bt (gmap C.p c d e (k + i)))) * (2 ^ C.w) ^ i) by
    simpa using this 0
  induction n with
  | zero => intro k; rfl
  | succ n ih =>
    intro k
    rw [List.range'_succ, List.foldr_cons, ih (k + 1)]
    simp only [shl_eq, Nat.add_eq]
    exact Prod.ext (pack_succ _ (fun t => Int.toNat (kblock C bt (gmap C.p c d e t))) k n)
      (pack_succ _ (fun t => Int.toNat (Int.neg (kblock C bt (gmap C.p c d e t)))) k n)

private theorem kmax_ge (C : Cert) (b : Blk) (x : ℕ) (hx : x < C.p * C.p) :
    Int.natAbs (kblock C (btab C b) x) ≤ kmax C b := by
  unfold kmax
  have : ∀ (l : List ℕ) (a : ℕ), (x ∈ l → Int.natAbs (kblock C (btab C b) x) ≤
      l.foldl (fun a x => Nat.max a (Int.natAbs (kblock C (btab C b) x))) a) ∧
      a ≤ l.foldl (fun a x => Nat.max a (Int.natAbs (kblock C (btab C b) x))) a := by
    intro l
    induction l with
    | nil => intro a; simp
    | cons y l ih =>
      intro a
      rw [List.foldl_cons]
      obtain ⟨h1, h2⟩ := ih (Nat.max a (Int.natAbs (kblock C (btab C b) y)))
      refine ⟨fun hm => ?_, le_trans (Nat.le_max_left _ _) h2⟩
      rcases List.mem_cons.1 hm with rfl | hm
      · exact le_trans (Nat.le_max_right _ _) h2
      · exact h1 hm
  exact (this _ 0).1 (List.mem_range.2 hx)

/-- `K_b` as a sum over the block's weights. -/
private theorem kblock_eq (C : Cert) (b : Blk) (x : ℕ) :
    kblock C (btab C b) x = (b.wts.map fun wi => kappa C wi x).sum := by
  unfold kblock btab
  rw [foldl_iadd, zero_add, List.map_map]; rfl

/-! ### Leaf L3: phase 1's invariant -/

/-- Orbit row `r`'s representative pair. -/
private def orb (C : Cert) (r : ℕ) : List ℕ × List ℕ := C.orbits.getD r ([], [])

private def p1f (C : Cert) (s : P1St) : ℕ := (s.2.2.2.1.read C.k1 C.per1).1
private def p1rho (C : Cert) (s : P1St) : ℕ := Nat.div (Nat.div (p1f C s) 2) (Nat.mul 2 (Nat.add C.p 1))
private def p1ent (C : Cert) (kt : List ((ℕ × ℕ × ℕ) × List (ℕ × ℕ))) (s : P1St) : (ℕ × ℕ × ℕ) × List (ℕ × ℕ) :=
  kt.getD (Nat.mod (Nat.div (p1f C s) 2) (Nat.mul 2 (Nat.add C.p 1))) ((0, 0, 0), [])
private def p1coefs (s : P1St) (ij : ℕ × ℕ) : List ℤ :=
  s.2.2.2.2.map fun l => Int.mul (cond (Nat.beq ij.1 ij.2) 1 2) (l.headD 0)
private def p1addP (C : Cert) (kt : List ((ℕ × ℕ × ℕ) × List (ℕ × ℕ))) (s : P1St) (ij : ℕ × ℕ) : ℕ :=
  ((p1coefs s ij).zip (p1ent C kt s).2).foldl (fun a x =>
    Nat.add a (Nat.add (Nat.mul (Int.toNat x.1) x.2.1) (Nat.mul (Int.toNat (Int.neg x.1)) x.2.2))) 0
private def p1addN (C : Cert) (kt : List ((ℕ × ℕ × ℕ) × List (ℕ × ℕ))) (s : P1St) (ij : ℕ × ℕ) : ℕ :=
  ((p1coefs s ij).zip (p1ent C kt s).2).foldl (fun a x =>
    Nat.add a (Nat.add (Nat.mul (Int.toNat x.1) x.2.2) (Nat.mul (Int.toNat (Int.neg x.1)) x.2.1))) 0
private def p1bnd (km : List ℕ) (s : P1St) (ij : ℕ × ℕ) : ℕ :=
  ((p1coefs s ij).zip km).foldl (fun a x => Nat.add a (Nat.mul (Int.natAbs x.1) x.2)) 0
private def p1good (C : Cert) (kt : List ((ℕ × ℕ × ℕ) × List (ℕ × ℕ))) (s : P1St) (ij : ℕ × ℕ) : Bool :=
  (cond (Nat.beq (Nat.mod (p1f C s) 2) 0)
      (Nat.beq (bag ((bget s.1 (p1rho C s)).1.map (gmap C.p (p1ent C kt s).1.1 (p1ent C kt s).1.2.1 (p1ent C kt s).1.2.2)))
          (bag (C.reps.getD ij.1 [])) &&
        Nat.beq (bag ((bget s.1 (p1rho C s)).2.1.map (gmap C.p (p1ent C kt s).1.1 (p1ent C kt s).1.2.1 (p1ent C kt s).1.2.2)))
          (bag (C.reps.getD ij.2 [])))
      (Nat.beq (bag ((bget s.1 (p1rho C s)).1.map (gmap C.p (p1ent C kt s).1.1 (p1ent C kt s).1.2.1 (p1ent C kt s).1.2.2)))
          (bag (C.reps.getD ij.2 [])) &&
        Nat.beq (bag ((bget s.1 (p1rho C s)).2.1.map (gmap C.p (p1ent C kt s).1.1 (p1ent C kt s).1.2.1 (p1ent C kt s).1.2.2)))
          (bag (C.reps.getD ij.1 [])))) &&
    bmem s.1 (p1rho C s) && isUnit C.p (p1ent C kt s).1.1 (p1ent C kt s).1.2.1 &&
    Nat.blt ((bget s.1 (p1rho C s)).1.map (gmap C.p (p1ent C kt s).1.1 (p1ent C kt s).1.2.1 (p1ent C kt s).1.2.2)).length 8 &&
    Nat.blt ((bget s.1 (p1rho C s)).2.1.map (gmap C.p (p1ent C kt s).1.1 (p1ent C kt s).1.2.1 (p1ent C kt s).1.2.2)).length 8 &&
    Nat.blt (C.reps.getD ij.1 []).length 8 && Nat.blt (C.reps.getD ij.2 []).length 8

private theorem p1step_eq (C : Cert) (kt : List ((ℕ × ℕ × ℕ) × List (ℕ × ℕ))) (km : List ℕ) (s : P1St) (ij : ℕ × ℕ) :
    p1step C kt km s ij = (bmod s.1 (p1rho C s) (fun o => (o.1, o.2.1, Nat.add o.2.2.1 (p1addP C kt s ij),
      Nat.add o.2.2.2 (p1addN C kt s ij))), s.2.1 && p1good C kt s ij, Nat.add s.2.2.1 (p1bnd km s ij),
      (s.2.2.2.1.read C.k1 C.per1).2, s.2.2.2.2.map List.tail) := rfl

/-- A times-1 coefficient of a pair. -/
private def R1 (b : Blk) (ij : ℕ × ℕ) : ℤ := triGet b.tri (1 + ij.1) (1 + ij.2)
/-- The multiplicity of a pair `i ≤ j`. -/
private def mlt (ij : ℕ × ℕ) : ℤ := if ij.1 = ij.2 then 1 else 2

/-- `W_b(i, j) = Σ_{ŵ ∈ b} Σ_t κ_ŵ(t) Y(a_i ∪ (a_j + t))`. -/
private noncomputable def Wb (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (b : Blk) (ij : ℕ × ℕ) : ℝ :=
  (b.wts.map fun wi => ∑ t ∈ Finset.range (C.p * C.p),
    (kappa C wi t : ℝ) * Ym C.p φ (C.reps.getD ij.1 [] ++ (C.reps.getD ij.2 []).map fun x => addP C.p x t)).sum

/-- A pair's share of the identity. -/
private noncomputable def contrib1 (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (ij : ℕ × ℕ) : ℝ :=
  (C.blocks1.map fun b => ((mlt ij * R1 b ij : ℤ) : ℝ) * Wb C φ b ij).sum

/-- The rows hold `(A0, A1, Σ_t P_t B^t, Σ_t N_t B^t)`, in buckets. -/
private def RowsOK (C : Cert) (L : List (List ORow)) (P N : ℕ → ℕ → ℕ) : Prop :=
  Bk L ∧ L.flatten.length = C.orbits.length ∧ ∀ r < C.orbits.length, L.flatten.getD r ([], [], 0, 0) =
    ((orb C r).1, (orb C r).2, ∑ t ∈ Finset.range (C.p * C.p), P r t * (2 ^ C.w) ^ t,
      ∑ t ∈ Finset.range (C.p * C.p), N r t * (2 ^ C.w) ^ t)

/-- The orbit rows at the moments. -/
private noncomputable def rowSum (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (P N : ℕ → ℕ → ℕ) : ℝ :=
  ∑ r ∈ Finset.range C.orbits.length, ∑ t ∈ Finset.range (C.p * C.p),
    ((P r t : ℝ) - N r t) * Ym C.p φ ((orb C r).1 ++ (orb C r).2.map fun x => addP C.p x t)

/-- **Phase 1's invariant.** -/
private def Inv1 (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (s : P1St) (Φ : ℝ) : Prop :=
  ∃ P N : ℕ → ℕ → ℕ, RowsOK C s.1 P N ∧ (∀ r t, P r t + N r t ≤ s.2.2.1) ∧ (s.2.1 = true → rowSum C φ P N = Φ)

private theorem ktable_getD (C : Cert) (k : ℕ) :
    (ktable C).getD k ((0, 0, 0), []) = ((0, 0, 0), []) ∨
      ((ktable C).getD k ((0, 0, 0), [])).1 ∈ gList C.p ∧ ((ktable C).getD k ((0, 0, 0), [])).2 =
        C.blocks1.map fun b => krow C (btab C b) ((ktable C).getD k ((0, 0, 0), [])).1.1
          ((ktable C).getD k ((0, 0, 0), [])).1.2.1 ((ktable C).getD k ((0, 0, 0), [])).1.2.2 := by
  by_cases hk : k < (ktable C).length
  · right
    have hk' : k < (gList C.p).length := by simpa [ktable] using hk
    rw [getD_of_lt _ _ hk]
    simp only [ktable, List.getElem_map, List.map_map, Function.comp_def]
    exact ⟨List.getElem_mem hk', trivial⟩
  · left; exact getD_default _ _ (by omega)

/-- The transport of one pair, for one block: the orbit row's slots read at the pair. -/
private theorem transport_b (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) (b : Blk)
    (hw : ∀ wi ∈ b.wts, wi < C.weights.length) (A0 A1 : List ℕ) (ij : ℕ × ℕ) (c d e : ℕ) (hc : c ≤ C.p) (hd : d ≤ C.p)
    (hu : isUnit C.p c d = true)
    (hsw : ((A0.map (gmap C.p c d e)).Perm (C.reps.getD ij.1 []) ∧ (A1.map (gmap C.p c d e)).Perm (C.reps.getD ij.2 [])) ∨
      ((A0.map (gmap C.p c d e)).Perm (C.reps.getD ij.2 []) ∧ (A1.map (gmap C.p c d e)).Perm (C.reps.getD ij.1 []))) :
    ∑ t ∈ Finset.range (C.p * C.p), (kblock C (btab C b) (gmap C.p c d e t) : ℝ) *
      Ym C.p φ (A0 ++ A1.map fun x => addP C.p x t) = Wb C φ b ij := by
  simp only [kblock_eq, Int.cast_list_sum, List.map_map, Function.comp_def, ← List.sum_map_mul_right]
  rw [finset_list_comm]
  unfold Wb
  congr 1; refine List.map_congr_left fun wi hwi => ?_
  simp only [kappa_eq C wi (hw wi hwi)]
  exact transport_w C φ _ _ A0 A1 _ _ c d e hc hd hu hsw

private theorem Inv1_step (C : Cert) [NeZero C.p] (hp : 2 ≤ C.p)
    (hw : ∀ b ∈ C.blocks1, ∀ wi ∈ b.wts, wi < C.weights.length) (φ : V C.p → ℝ) (s : P1St) (Φ : ℝ) (ij : ℕ × ℕ)
    (rest : List (ℕ × ℕ)) (h : Inv1 C φ s Φ) (hco : s.2.2.2.2 = C.blocks1.map fun b => (ij :: rest).map (R1 b)) :
    Inv1 C φ (p1step C (ktable C) (C.blocks1.map (kmax C)) s ij) (Φ + contrib1 C φ ij) ∧
      (p1step C (ktable C) (C.blocks1.map (kmax C)) s ij).2.2.2.2 = C.blocks1.map (fun b => rest.map (R1 b)) ∧
      ((p1step C (ktable C) (C.blocks1.map (kmax C)) s ij).2.1 = true → s.2.1 = true) ∧
      s.2.2.1 ≤ (p1step C (ktable C) (C.blocks1.map (kmax C)) s ij).2.2.1 := by
  rw [p1step_eq]
  obtain ⟨P, N, ⟨hBk, hlen, hrow⟩, hbnd, hsum⟩ := h
  have hp0 : 0 < C.p := by omega
  -- the coefficients and the bound
  have hcoef : p1coefs s ij = C.blocks1.map fun b => mlt ij * R1 b ij := by
    simp only [p1coefs, hco, List.map_map, Function.comp_def, List.map_cons, List.headD_cons]
    refine List.map_congr_left fun b _ => ?_
    simp only [mlt]; cases h : Nat.beq ij.1 ij.2
    · rw [if_neg (fun h' => by rw [h', Nat.beq_refl] at h; exact absurd h (by simp))]; rfl
    · rw [if_pos (Nat.eq_of_beq_eq_true h)]; rfl
  have hbq : p1bnd (C.blocks1.map (kmax C)) s ij =
      (C.blocks1.map fun b => Int.natAbs (mlt ij * R1 b ij) * kmax C b).sum := by
    rw [p1bnd, hcoef, zip_map_same, foldl_nadd', zero_add, List.map_map]; rfl
  refine ⟨?_, by simp [hco, List.map_map, Function.comp_def], fun hok => by
    simp only [Bool.and_eq_true] at hok; exact hok.1, Nat.le_add_right _ _⟩
  -- the entry
  set e := p1ent C (ktable C) s with he_def
  have hele : e.1.1 ≤ C.p ∧ e.1.2.1 ≤ C.p := by
    rcases ktable_getD C (Nat.mod (Nat.div (p1f C s) 2) (Nat.mul 2 (Nat.add C.p 1))) with h0 | ⟨h1, -⟩
    · rw [he_def, p1ent, h0]; exact ⟨Nat.zero_le _, Nat.zero_le _⟩
    · exact ⟨(gList_bound C.p hp0 _ h1).1.le, (gList_bound C.p hp0 _ h1).2.le⟩
  rcases ktable_getD C (Nat.mod (Nat.div (p1f C s) 2) (Nat.mul 2 (Nat.add C.p 1))) with h0 | ⟨-, h2⟩
  · -- the default entry adds nothing and fails the unit check
    have he0 : e = ((0, 0, 0), []) := by rw [he_def, p1ent, h0]
    have hP : p1addP C (ktable C) s ij = 0 := by simp [p1addP, ← he_def, he0]
    have hN : p1addN C (ktable C) s ij = 0 := by simp [p1addN, ← he_def, he0]
    have hg : p1good C (ktable C) s ij = false := by
      have hu : isUnit C.p 0 0 = false := by
        simp only [isUnit]
        exact Bool.eq_false_iff.2 fun h' => by
          have := Nat.eq_of_beq_eq_true h'
          rw [show Nat.mod 0 C.p = 0 % C.p from rfl, Nat.zero_mod] at this; omega
      simp [p1good, ← he_def, he0, hu]
    refine ⟨P, N, ⟨(Bk_mod _ hBk _ _).1, ?_, fun r hr => ?_⟩, fun r t => le_trans (hbnd r t) (Nat.le_add_right _ _),
      fun hok => by simp [hg] at hok⟩
    · rw [(Bk_mod _ hBk _ _).2, List.length_modify, hlen]
    · rw [(Bk_mod _ hBk _ _).2, getD_modify _ _ _ _ _ (by rw [hlen]; exact hr), hrow r hr, hP, hN]
      split_ifs <;> rfl
  -- a map of `gList`: the packed rows of every block
  let K : Blk → ℕ → ℤ := fun b t => kblock C (btab C b) (gmap C.p e.1.1 e.1.2.1 e.1.2.2 t)
  let cb : Blk → ℤ := fun b => mlt ij * R1 b ij
  let IP : ℕ → ℕ := fun t => (C.blocks1.map fun b =>
    Int.toNat (cb b) * Int.toNat (K b t) + Int.toNat (Int.neg (cb b)) * Int.toNat (Int.neg (K b t))).sum
  let IN : ℕ → ℕ := fun t => (C.blocks1.map fun b =>
    Int.toNat (cb b) * Int.toNat (Int.neg (K b t)) + Int.toNat (Int.neg (cb b)) * Int.toNat (K b t)).sum
  have he2 : e.2 = C.blocks1.map fun b => krow C (btab C b) e.1.1 e.1.2.1 e.1.2.2 := h2
  have hzip : (p1coefs s ij).zip e.2 = C.blocks1.map fun b => (cb b, krow C (btab C b) e.1.1 e.1.2.1 e.1.2.2) := by
    rw [hcoef, he2, zip_map_same]
  have hpack : ∀ (F G : Blk → ℕ → ℕ) (u v : Blk → ℕ),
      (C.blocks1.map fun b => u b * (∑ t ∈ Finset.range (C.p * C.p), F b t * (2 ^ C.w) ^ t) +
        v b * (∑ t ∈ Finset.range (C.p * C.p), G b t * (2 ^ C.w) ^ t)).sum =
      ∑ t ∈ Finset.range (C.p * C.p), (C.blocks1.map fun b => u b * F b t + v b * G b t).sum * (2 ^ C.w) ^ t := by
    intro F G u v
    simp only [← List.sum_map_mul_right]
    rw [finset_list_comm]
    congr 1; refine List.map_congr_left fun b _ => ?_
    rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun t _ => by ring
  have hP : p1addP C (ktable C) s ij = ∑ t ∈ Finset.range (C.p * C.p), IP t * (2 ^ C.w) ^ t := by
    rw [p1addP, ← he_def, hzip, foldl_nadd', zero_add, List.map_map]
    simp only [Function.comp_def, krow_eq, Nat.add_eq, Nat.mul_eq]
    exact hpack _ _ _ _
  have hN : p1addN C (ktable C) s ij = ∑ t ∈ Finset.range (C.p * C.p), IN t * (2 ^ C.w) ^ t := by
    rw [p1addN, ← he_def, hzip, foldl_nadd', zero_add, List.map_map]
    simp only [Function.comp_def, krow_eq, Nat.add_eq, Nat.mul_eq]
    exact hpack _ _ _ _
  have hIPN : ∀ t, IP t + IN t ≤ p1bnd (C.blocks1.map (kmax C)) s ij := fun t => by
    rw [hbq]
    simp only [IP, IN, ← List.sum_map_add]
    refine List.sum_le_sum fun b _ => ?_
    have h1 : Int.toNat (cb b) * Int.toNat (K b t) + Int.toNat (Int.neg (cb b)) * Int.toNat (Int.neg (K b t)) +
        (Int.toNat (cb b) * Int.toNat (Int.neg (K b t)) + Int.toNat (Int.neg (cb b)) * Int.toNat (K b t)) =
        (Int.toNat (cb b) + Int.toNat (Int.neg (cb b))) * (Int.toNat (K b t) + Int.toNat (Int.neg (K b t))) := by ring
    rw [h1, show Int.neg (cb b) = -cb b from rfl, show Int.neg (K b t) = -K b t from rfl,
      Int.toNat_add_toNat_neg_eq_natAbs, Int.toNat_add_toNat_neg_eq_natAbs]
    exact Nat.mul_le_mul_left _ (kmax_ge C b _ (gmap_lt _ _ _ _ _))
  have hdiff : ∀ t, ((IP t : ℝ) - IN t) = (C.blocks1.map fun b => (cb b : ℝ) * (K b t : ℝ)).sum := fun t => by
    simp only [IP, IN, Nat.cast_list_sum, List.map_map, Function.comp_def, list_sub_sum]
    congr 1; refine List.map_congr_left fun b _ => ?_
    have hc : ((Int.toNat (cb b) : ℝ) - (Int.toNat (Int.neg (cb b)) : ℝ)) = (cb b : ℝ) := by
      exact_mod_cast Int.toNat_sub_toNat_neg (cb b)
    have hk : ((Int.toNat (K b t) : ℝ) - (Int.toNat (Int.neg (K b t)) : ℝ)) = (K b t : ℝ) := by
      exact_mod_cast Int.toNat_sub_toNat_neg (K b t)
    rw [← hc, ← hk]; push_cast; ring
  set ρ := p1rho C s with hρ
  refine ⟨fun r t => P r t + if r = ρ then IP t else 0, fun r t => N r t + if r = ρ then IN t else 0,
    ⟨(Bk_mod _ hBk _ _).1, ?_, fun r hr => ?_⟩, fun r t => ?_, fun hok => ?_⟩
  · rw [(Bk_mod _ hBk _ _).2, List.length_modify, hlen]
  · rw [(Bk_mod _ hBk _ _).2, getD_modify _ _ _ _ _ (by rw [hlen]; exact hr), hrow r hr, hP, hN]
    by_cases hr' : ρ = r
    · subst hr'
      simp only [if_true, Nat.add_eq, add_mul, Finset.sum_add_distrib]
    · simp only [hr', if_false, Ne.symm hr', add_zero]
  · have := hbnd r t
    have := hIPN t
    dsimp only
    split_ifs <;> simp only [Nat.add_eq] <;> omega
  -- the identity's share: only row `ρ` moves, by the pair's transported terms
  simp only [Bool.and_eq_true] at hok
  obtain ⟨hok0, hgood⟩ := hok
  simp only [p1good, Bool.and_eq_true, Nat.blt_eq, ← he_def, ← hρ] at hgood
  obtain ⟨⟨⟨⟨⟨⟨hbag, hmem⟩, hu⟩, hl0⟩, hl1⟩, hli⟩, hlj⟩ := hgood
  have hρlt : ρ < C.orbits.length := by rw [← hlen]; exact (Bk_mem _ hBk ρ).1 hmem
  have hget : bget s.1 ρ = ((orb C ρ).1, (orb C ρ).2, ∑ t ∈ Finset.range (C.p * C.p), P ρ t * (2 ^ C.w) ^ t,
      ∑ t ∈ Finset.range (C.p * C.p), N ρ t * (2 ^ C.w) ^ t) := by rw [bget_eq _ hBk, hrow ρ hρlt]
  rw [hget] at hbag hl0 hl1
  have hsw : (((orb C ρ).1.map (gmap C.p e.1.1 e.1.2.1 e.1.2.2)).Perm (C.reps.getD ij.1 []) ∧
      ((orb C ρ).2.map (gmap C.p e.1.1 e.1.2.1 e.1.2.2)).Perm (C.reps.getD ij.2 [])) ∨
      (((orb C ρ).1.map (gmap C.p e.1.1 e.1.2.1 e.1.2.2)).Perm (C.reps.getD ij.2 []) ∧
      ((orb C ρ).2.map (gmap C.p e.1.1 e.1.2.1 e.1.2.2)).Perm (C.reps.getD ij.1 [])) := by
    cases hs : Nat.beq (Nat.mod (p1f C s) 2) 0 <;> simp only [hs, cond_true, cond_false, Bool.and_eq_true,
      Nat.beq_eq] at hbag
    · exact Or.inr ⟨bag_perm _ _ hbag.1 hl0 hlj, bag_perm _ _ hbag.2 hl1 hli⟩
    · exact Or.inl ⟨bag_perm _ _ hbag.1 hl0 hli, bag_perm _ _ hbag.2 hl1 hlj⟩
  have hrs : rowSum C φ (fun r t => P r t + if r = ρ then IP t else 0) (fun r t => N r t + if r = ρ then IN t else 0) =
      rowSum C φ P N + ∑ t ∈ Finset.range (C.p * C.p), ((IP t : ℝ) - IN t) *
        Ym C.p φ ((orb C ρ).1 ++ (orb C ρ).2.map fun x => addP C.p x t) := by
    unfold rowSum
    have hr : ∀ r ∈ Finset.range C.orbits.length, ∑ t ∈ Finset.range (C.p * C.p),
        (((P r t + if r = ρ then IP t else 0 : ℕ) : ℝ) - ((N r t + if r = ρ then IN t else 0 : ℕ) : ℝ)) *
          Ym C.p φ ((orb C r).1 ++ (orb C r).2.map fun x => addP C.p x t) =
        ∑ t ∈ Finset.range (C.p * C.p), ((P r t : ℝ) - N r t) *
          Ym C.p φ ((orb C r).1 ++ (orb C r).2.map fun x => addP C.p x t) +
        if r = ρ then ∑ t ∈ Finset.range (C.p * C.p), ((IP t : ℝ) - IN t) *
          Ym C.p φ ((orb C r).1 ++ (orb C r).2.map fun x => addP C.p x t) else 0 := fun r _ => by
      split_ifs with h'
      · rw [← Finset.sum_add_distrib]; refine Finset.sum_congr rfl fun t _ => ?_; push_cast; ring
      · simp
    simp only []
    rw [Finset.sum_congr rfl hr, Finset.sum_add_distrib, Finset.sum_ite_eq', if_pos (Finset.mem_range.2 hρlt)]
  rw [hrs, hsum hok0]
  congr 1
  simp only [hdiff, ← List.sum_map_mul_right]
  rw [finset_list_comm]
  unfold contrib1
  congr 1; refine List.map_congr_left fun b hb => ?_
  simp only [mul_assoc, ← Finset.mul_sum]
  congr 1
  exact transport_b C φ b (hw b hb) _ _ ij _ _ _ hele.1 hele.2 hu hsw

/-! ### Leaf L3: the fold, its start and its end -/

private theorem Inv1_fold (C : Cert) [NeZero C.p] (hp : 2 ≤ C.p)
    (hw : ∀ b ∈ C.blocks1, ∀ wi ∈ b.wts, wi < C.weights.length) (φ : V C.p → ℝ) :
    ∀ (rest : List (ℕ × ℕ)) (s : P1St) (Φ : ℝ), Inv1 C φ s Φ → s.2.2.2.2 = C.blocks1.map (fun b => rest.map (R1 b)) →
      Inv1 C φ (rest.foldl (p1step C (ktable C) (C.blocks1.map (kmax C))) s) (Φ + (rest.map (contrib1 C φ)).sum) ∧
      ((rest.foldl (p1step C (ktable C) (C.blocks1.map (kmax C))) s).2.1 = true → s.2.1 = true)
  | [], s, Φ, h, _ => by simpa using h
  | ij :: rest, s, Φ, h, hco => by
    obtain ⟨h1, h2, h3, -⟩ := Inv1_step C hp hw φ s Φ ij rest h hco
    have ih := Inv1_fold C hp hw φ rest _ _ h1 h2
    rw [List.foldl_cons, List.map_cons, List.sum_cons, ← add_assoc]
    exact ⟨ih.1, fun hok => h3 (ih.2 hok)⟩

private theorem flatMap_eq {α β : Type} (l : List α) (f : α → List β) : l.flatMap f = (l.map f).flatten := by
  induction l with
  | nil => rfl
  | cons x l ih => rw [List.flatMap_cons, ih, List.map_cons, List.flatten_cons]

private theorem tri_length (b : Blk) (hm : 0 < b.m) : b.tri.length = b.m := by
  have htoI : ∀ l : List ℕ, (l.map fun x => sfield x b.wr).length = l.length := fun l => List.length_map _
  rw [tri_eq, List.length_cons, (trows_length b.wr b.per _ htoI (Nat.sub b.m 1) (Nat.sub b.m 1) ⟨0, 0, b.rest⟩).1,
    Nat.sub_eq]; omega

/-- **Phase 1's coefficients** are the triangle's rows `1..`, read along the pairs. -/
private theorem pairCoefs_eq (b : Blk) (N : ℕ) (hm : b.m = N + 1) : b.pairCoefs = (repPairs N).map (R1 b) := by
  have hrows := tri_rows b (by omega)
  have hlen := tri_length b (by omega)
  unfold Blk.pairCoefs repPairs
  rw [List.map_flatMap, flatMap_eq]
  congr 1
  refine List.ext_getElem (by simp [hlen, hm]) fun i h1 h2 => ?_
  have hi : i < N := by simpa using h2
  simp only [List.getElem_drop, List.getElem_map, List.getElem_range]
  rw [← getD_of_lt b.tri [] (by omega)]
  conv_lhs => rw [← map_range_getD (b.tri.getD (1 + i) []) 0, hrows (1 + i) (by omega)]
  rw [List.range'_eq_map_range, List.map_map, show b.m - (1 + i) = N - i by omega]
  simp only [List.map_map, Function.comp_def, show N.sub i = N - i from rfl]
  refine List.map_congr_left fun k _ => ?_
  simp only [R1]
  rw [triGet_le _ _ _ (by omega), show 1 + (i + k) - (1 + i) = k by omega]

private theorem orb_getD (C : Cert) (f : List ℕ × List ℕ → ORow) (r : ℕ) (hr : r < C.orbits.length) :
    (C.orbits.map f).getD r ([], [], 0, 0) = f (orb C r) := by
  rw [getD_of_lt _ _ (by simpa using hr), List.getElem_map, orb, getD_of_lt _ _ hr]

private theorem Inv1_init (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) :
    Inv1 C φ (bucket16 (C.orbits.map fun o => (o.1, o.2, 0, 0)), true, 0, ⟨0, 0, C.p1⟩, C.blocks1.map Blk.pairCoefs) 0 := by
  obtain ⟨h1, h2⟩ := bucket16_spec (C.orbits.map fun o => ((o.1, o.2, 0, 0) : ORow))
  refine ⟨fun _ _ => 0, fun _ _ => 0, ⟨h2, by rw [h1, List.length_map], fun r hr => ?_⟩, fun _ _ => le_rfl,
    fun _ => by simp [rowSum]⟩
  rw [h1, orb_getD C _ r hr]; simp

/-- The sum over the pairs, regrouped: `Σ_{i ≤ j} mult·R·W = Σ_{a,a'} R·W` per block, then per weight. -/
private theorem contrib_sum (C : Cert) [NeZero C.p] (φ : V C.p → ℝ)
    (hw : ∀ b ∈ C.blocks1, ∀ wi ∈ b.wts, wi < C.weights.length) :
    ((repPairs C.reps.length).map (contrib1 C φ)).sum = (C.blocks1.map fun b => (b.wts.map fun wi =>
      ∑ a ∈ Finset.range C.reps.length, ∑ a' ∈ Finset.range C.reps.length, (triGet b.tri (1 + a) (1 + a') : ℝ) *
        ∑ t ∈ Finset.range (C.p * C.p), (kappa C wi t : ℝ) *
          Ym C.p φ (C.reps.getD a [] ++ (C.reps.getD a' []).map fun x => addP C.p x t)).sum).sum := by
  unfold contrib1
  rw [list_sum_comm]
  congr 1; refine List.map_congr_left fun b hb => ?_
  have hsym : ∀ i j, (R1 b (i, j) : ℝ) * Wb C φ b (i, j) = (R1 b (j, i) : ℝ) * Wb C φ b (j, i) := fun i j => by
    congr 1
    · simp only [R1, triGet_symm]
    · unfold Wb; congr 1; refine List.map_congr_left fun wi hwi => ?_
      simp only [kappa_eq C wi (hw b hb wi hwi)]
      exact (W_symm C φ _ _ _ _).symm
  rw [repPairs_sum]
  have e1 : ∀ i k, ((mlt (i, i + k) * R1 b (i, i + k) : ℤ) : ℝ) * Wb C φ b (i, i + k) =
      (if i = i + k then (1 : ℝ) else 2) * ((R1 b (i, i + k) : ℝ) * Wb C φ b (i, i + k)) := fun i k => by
    simp only [mlt]; split_ifs <;> push_cast <;> ring
  simp only [e1]
  rw [pairs_double (fun i j => (R1 b (i, j) : ℝ) * Wb C φ b (i, j)) hsym]
  simp only [Wb, R1, ← List.sum_map_mul_left]
  rw [Finset.sum_congr rfl fun a _ => finset_list_comm _ _ _, finset_list_comm]

/-- (O2) term by term. -/
private theorem opSum_O2 (C : Cert) [NeZero C.p] (φ : V C.p → ℝ) :
    opSum C.p φ (opsO2 C) = (C.blocks1.map fun b => (b.wts.map fun wi =>
      (triGet b.tri 0 0 : ℝ) * (cval C wi : ℝ) ^ 2 * Ym C.p φ [] +
      ∑ a ∈ Finset.range C.reps.length,
        2 * (triGet b.tri 0 (1 + a) : ℝ) * (cval C wi : ℝ) * (sigma C wi : ℝ) * Ym C.p φ (C.reps.getD a [])).sum).sum := by
  unfold opsO2
  rw [opSum_flatMap]
  congr 1; refine List.map_congr_left fun b _ => ?_
  rw [opSum_flatMap]
  congr 1; refine List.map_congr_left fun wi _ => ?_
  rw [opSum_cons, opSum_map, opVal_opI, mono_opI]
  simp only [opVal_opI, mono_opI, List.map_nil, List.append_nil, lsum_range]
  congr 1
  · show ((triGet b.tri 0 0 * (cval C wi * cval C wi) : ℤ) : ℝ) * _ = _; push_cast; ring
  · refine Finset.sum_congr rfl fun a _ => ?_
    show ((2 * triGet b.tri 0 (1 + a) * (cval C wi * sigma C wi) : ℤ) : ℝ) * _ = _; push_cast; ring

private theorem digit_sum (w n : ℕ) (c : ℕ → ℕ) (hc : ∀ t, c t < 2 ^ w) (t' : ℕ) (ht : t' < n) :
    digit (∑ t ∈ Finset.range n, c t * (2 ^ w) ^ t) w t' = c t' := by
  rw [digit_eq]; exact sum_digit _ c n (fun i _ => hc i) t' ht

/-- **Leaf L3** (K2h): the times-1 families are the blocks' terms — the orbit rows are phase 1's (`orowsOK`), each
pair's transporter moves its term onto its orbit's representative, `R` is symmetric and `κ` even. -/
private theorem opSum_O23_eq (C : Cert) [NeZero C.p] (hC : globalOK C = true) (φ : V C.p → ℝ) :
    opSum C.p φ (opsO2 C ++ opsO3 C (orbRows C)) = (C.blocks1.map fun b => blockT C φ b C.reps).sum := by
  have hg := hC
  simp only [globalOK, Bool.and_eq_true, Nat.ble_eq, Nat.blt_eq, List.all_eq_true, Nat.beq_eq] at hg
  obtain ⟨⟨⟨⟨⟨⟨⟨⟨⟨hp2, -⟩, -⟩, hok⟩, hbw⟩, horows⟩, -⟩, hm⟩, -⟩, hw'⟩ := hg
  have hw : ∀ b ∈ C.blocks1, ∀ wi ∈ b.wts, wi < C.weights.length := fun b hb => hw' b (List.mem_append_left _ hb)
  -- phase 1 run through its invariant
  have hco0 : (C.blocks1.map Blk.pairCoefs) = C.blocks1.map (fun b => (repPairs C.reps.length).map (R1 b)) :=
    List.map_congr_left fun b hb => pairCoefs_eq b _ (hm b hb)
  obtain ⟨⟨P, N, ⟨hBk, hlen, hrow⟩, hbnd, hsum⟩, -⟩ := Inv1_fold C hp2 hw φ (repPairs C.reps.length) _ 0
    (Inv1_init C φ) hco0
  set fin := (repPairs C.reps.length).foldl (p1step C (ktable C) (C.blocks1.map (kmax C)))
    (bucket16 (C.orbits.map fun o => (o.1, o.2, 0, 0)), true, 0, ⟨0, 0, C.p1⟩, C.blocks1.map Blk.pairCoefs) with hfin
  have hph : phase1 C = (fin.1.flatten, fin.2.1, fin.2.2.1) := rfl
  rw [hph] at hok hbw
  have hbw' : fin.2.2.1 < 2 ^ C.w := by simpa only [shl_one] using hbw
  have hPlt : ∀ r t, P r t < 2 ^ C.w := fun r t => by have := hbnd r t; omega
  have hNlt : ∀ r t, N r t < 2 ^ C.w := fun r t => by have := hbnd r t; omega
  -- the literal rows are phase 1's
  simp only [orowsOK, hph, Bool.and_eq_true, Nat.beq_eq, List.all_eq_true] at horows
  obtain ⟨⟨hl1, hl2⟩, hall⟩ := horows
  have hob : orbRows C = (List.range C.orbits.length).map fun k => ((orb C k).1, (orb C k).2,
      ∑ t ∈ Finset.range (C.p * C.p), P k t * (2 ^ C.w) ^ t, ∑ t ∈ Finset.range (C.p * C.p), N k t * (2 ^ C.w) ^ t) := by
    refine List.ext_getElem (by simp [orbRows, hl2]) fun k h1 h2 => ?_
    have hk : k < C.orbits.length := by simpa using h2
    have hk' : k < fin.1.flatten.length := by rw [hlen]; exact hk
    have hz := hall _ (List.getElem_mem (l := fin.1.flatten.zip C.orows) (n := k)
      (by rw [List.length_zip, hlen, hl2, min_self]; rw [hl2] at hk; exact hk))
    simp only [List.getElem_zip] at hz
    have hr := hrow k hk
    rw [getD_of_lt _ _ hk'] at hr
    rw [hr] at hz
    simp only [orbRows, List.getElem_map, List.getElem_zip, List.getElem_range, orb, getD_of_lt _ _ hk]
    rw [← hz.1, ← hz.2]
  have h3 : opSum C.p φ (opsO3 C (orbRows C)) = rowSum C φ P N := by
    unfold opsO3 rowSum
    rw [opSum_flatMap, hob, List.map_map, lsum_range]
    refine Finset.sum_congr rfl fun k _ => ?_
    simp only [Function.comp_apply, opSum_map, show Nat.mul C.p C.p = C.p * C.p from rfl, lsum_range]
    refine Finset.sum_congr rfl fun t ht => ?_
    rw [digit_sum _ _ _ (hPlt k) t (Finset.mem_range.1 ht), digit_sum _ _ _ (hNlt k) t (Finset.mem_range.1 ht)]
    simp only [opVal, Op.mono]; push_cast; rfl
  rw [opSum_append, opSum_O2, h3, hsum hok, zero_add, contrib_sum C φ hw]
  unfold blockT
  rw [← List.sum_map_add]
  congr 1; refine List.map_congr_left fun b _ => ?_
  rw [← List.sum_map_add]

/-- **Leaf L4** (the q-part): the times-q family is `q(φ)` times the q-blocks' terms over the one monomial `[0]` —
`Q(m)(Y) = q(φ)·Y(m)` (`q(φ∘γ) = q(φ)`), and every `t` moved onto its class's representative. -/
private theorem opSum_O4_eq (C : Cert) [NeZero C.p] (hC : globalOK C = true) (φ : V C.p → ℝ) :
    opSum C.p φ (opsO4 C (qcoefs C)) = qform C.p φ * (C.blocksq.map fun b => blockT C φ b [[0]]).sum := by
  have hp2 : 2 ≤ C.p := by
    simp only [globalOK, Bool.and_eq_true, Nat.ble_eq] at hC; exact hC.1.1.1.1.1.1.1.1.1
  have hok : (qcoefs C).2.2.2 = true := by
    simp only [globalOK, Bool.and_eq_true] at hC; exact hC.1.1.1.2
  have hp : 0 < C.p := by omega
  -- the ops
  have h1 : opSum C.p φ (opsO4 C (qcoefs C)) =
      ((qmonos C (qcoefs C)).map fun mc => (mc.2 : ℝ) * qform C.p φ * Ym C.p φ mc.1).sum := by
    unfold opsO4; rw [opSum_flatMap]; congr 1
    exact List.map_congr_left fun mc _ => opSum_qmono C hp2 φ mc.1 mc.2
  rw [h1]
  -- the classes and their transporters
  let ng := Nat.mul 2 (Nat.add C.p 1)
  let fs := readN C.kq C.perq (Nat.mul C.p C.p) C.qt
  have hfs : fs.length = C.p * C.p := readK_length _ _ _ _
  let cl : ℕ → ℕ := fun t => Nat.div (fs.getD t 0) ng
  have htr : ∀ t < C.p * C.p, cl t < C.tnu.length ∧
      Ym C.p φ ([0] ++ [0].map fun x => addP C.p x t) = Ym C.p φ [0, C.tnu.getD (cl t) 0] := by
    intro t ht
    have hall : ((List.range (Nat.mul C.p C.p)).zip (fs.map id)).all (fun x =>
        Nat.blt (Nat.div x.2 ng) C.tnu.length && isUnit C.p ((gList C.p).getD (Nat.mod x.2 ng) (0, 0, 0)).1
          ((gList C.p).getD (Nat.mod x.2 ng) (0, 0, 0)).2.1 &&
        Nat.beq (gmap C.p ((gList C.p).getD (Nat.mod x.2 ng) (0, 0, 0)).1
          ((gList C.p).getD (Nat.mod x.2 ng) (0, 0, 0)).2.1 ((gList C.p).getD (Nat.mod x.2 ng) (0, 0, 0)).2.2
          (C.tnu.getD (Nat.div x.2 ng) 0)) x.1) = true := by
      rw [List.map_id]; exact hok
    rw [zip_range_map fs id 0 (Nat.mul C.p C.p) hfs, List.all_eq_true] at hall
    have := hall _ (List.mem_map.2 ⟨t, List.mem_range.2 ht, rfl⟩)
    simp only [Bool.and_eq_true, Nat.blt_eq, Nat.beq_eq, id] at this
    obtain ⟨⟨hν, hu⟩, hg⟩ := this
    have hb := gList_getD_le C.p hp (Nat.mod (fs.getD t 0) ng)
    exact ⟨hν, Ym_transport C.p φ _ _ _ _ t hb.1 hb.2 hu hg⟩
  -- the coefficients
  have ha0 : ((qcoefs C).1 : ℝ) = (C.blocksq.map fun b => (b.wts.map fun wi =>
      (triGet b.tri 0 0 : ℝ) * ((cval C wi : ℝ) * (cval C wi : ℝ))).sum).sum := by
    have h := qfold (fun (tri : List (List ℤ)) wi => Int.mul (triGet tri 0 0) (Int.mul (cval C wi) (cval C wi)))
      (C.blocksq.map fun b => (b.wts, b.tri)) 0
    have e : (qcoefs C).1 = _ := h
    rw [e]; push_cast; simp [List.map_map, Function.comp_def]
  have ha1 : ((qcoefs C).2.1 : ℝ) = (C.blocksq.map fun b => (b.wts.map fun wi =>
      2 * (triGet b.tri 0 1 : ℝ) * ((cval C wi : ℝ) * (sigma C wi : ℝ))).sum).sum := by
    have h := qfold (fun (tri : List (List ℤ)) wi => Int.mul (Int.mul 2 (triGet tri 0 1)) (Int.mul (cval C wi) (sigma C wi)))
      (C.blocksq.map fun b => (b.wts, b.tri)) 0
    have e : (qcoefs C).2.1 = _ := h
    rw [e]; push_cast; simp [List.map_map, Function.comp_def]
  have hbeta : ∀ ν, ((((C.blocksq.map fun b => (b.wts, b.tri)).foldl (fun a b => b.1.foldl (fun a wi =>
      Int.add a (Int.mul (triGet b.2 1 1) (((List.range (Nat.mul C.p C.p)).zip (fs.map fun f => Nat.div f ng)).foldl
        (fun s x => cond (Nat.beq x.2 ν) (Int.add s (kappa C wi x.1)) s) 0))) a) 0) : ℤ) : ℝ) =
      (C.blocksq.map fun b => (b.wts.map fun wi => (triGet b.tri 1 1 : ℝ) *
        ∑ t ∈ Finset.range (C.p * C.p), if cl t = ν then (kappa C wi t : ℝ) else 0).sum).sum := by
    intro ν
    have h := qfold (fun (tri : List (List ℤ)) wi => Int.mul (triGet tri 1 1)
      (((List.range (Nat.mul C.p C.p)).zip (fs.map fun f => Nat.div f ng)).foldl
        (fun s x => cond (Nat.beq x.2 ν) (Int.add s (kappa C wi x.1)) s) 0)) (C.blocksq.map fun b => (b.wts, b.tri)) 0
    rw [h]
    push_cast
    simp only [zero_add, List.map_map, Function.comp_def]
    congr 1; refine List.map_congr_left fun b _ => ?_
    rw [Int.cast_list_sum, List.map_map]
    congr 1; refine List.map_congr_left fun wi _ => ?_
    have h2 := foldl_cond (fun x : ℕ × ℕ => Nat.beq x.2 ν) (fun x => kappa C wi x.1)
      ((List.range (Nat.mul C.p C.p)).zip (fs.map fun f => Nat.div f ng)) 0
    simp only [Function.comp_apply]
    show ((triGet b.tri 1 1 * _ : ℤ) : ℝ) = _
    rw [h2, zip_range_map fs _ 0 (Nat.mul C.p C.p) hfs]
    push_cast
    simp only [zero_add, List.map_map, Function.comp_def]
    rw [lsum_range]
    congr 1
    refine Finset.sum_congr rfl fun t _ => ?_
    simp only [Nat.beq_eq, cl]
    split_ifs <;> simp
  -- the left side, term by term
  have hq : (qcoefs C).2.2.1 = (List.range C.tnu.length).map fun ν =>
      (C.blocksq.map fun b => (b.wts, b.tri)).foldl (fun a b => b.1.foldl (fun a wi =>
        Int.add a (Int.mul (triGet b.2 1 1) (((List.range (Nat.mul C.p C.p)).zip (fs.map fun f => Nat.div f ng)).foldl
          (fun s x => cond (Nat.beq x.2 ν) (Int.add s (kappa C wi x.1)) s) 0))) a) 0 := rfl
  simp only [qmonos, List.map_cons, List.sum_cons, List.map_map, Function.comp_def]
  rw [hq, zip_map_range C.tnu _ 0, List.map_map, lsum_range]
  simp only [Function.comp_def, hbeta, ha0, ha1]
  -- the right side
  have hR : (C.blocksq.map fun b => blockT C φ b [[0]]).sum = Lam C.blocksq fun b wi =>
      (triGet b.tri 0 0 : ℝ) * ((cval C wi : ℝ) * (cval C wi : ℝ)) * Ym C.p φ [] +
      2 * (triGet b.tri 0 1 : ℝ) * ((cval C wi : ℝ) * (sigma C wi : ℝ)) * Ym C.p φ [0] +
      ∑ ν ∈ Finset.range C.tnu.length, (triGet b.tri 1 1 : ℝ) *
        (∑ t ∈ Finset.range (C.p * C.p), if cl t = ν then (kappa C wi t : ℝ) else 0) * Ym C.p φ [0, C.tnu.getD ν 0] := by
    simp only [Lam, blockT]
    congr 1; refine List.map_congr_left fun b _ => ?_
    congr 1; refine List.map_congr_left fun wi _ => ?_
    simp only [List.length_singleton, Finset.sum_range_one, List.getD_cons_zero, add_zero]
    congr 1
    · ring
    · simp only [Finset.mul_sum, Finset.sum_mul, ite_mul, zero_mul, mul_ite, mul_zero]
      rw [Finset.sum_comm]
      refine Finset.sum_congr rfl fun t ht => ?_
      obtain ⟨hcl, hY⟩ := htr t (Finset.mem_range.1 ht)
      rw [Finset.sum_ite_eq, if_pos (Finset.mem_range.2 hcl), hY]
      ring
  rw [hR]
  have hL : ∀ F : Blk → ℕ → ℝ, (C.blocksq.map fun b => (b.wts.map (F b)).sum).sum = Lam C.blocksq F := fun F => rfl
  simp only [hL, Lam_mul]
  rw [Lam_fsum, ← Lam_add, ← Lam_add, mul_comm (qform C.p φ), Lam_mul]
  refine Lam_congr _ _ _ fun b _ wi _ => ?_
  rw [add_mul, add_mul, Finset.sum_mul, add_assoc]
  congr 1
  · ring
  congr 1
  · ring
  · exact Finset.sum_congr rfl fun ν _ => by ring

private theorem globalOK_of (C : Cert) (hC : certOK C = true) : globalOK C = true := by
  simp only [certOK, Bool.and_eq_true] at hC; exact hC.1.1

private theorem psdAll_of (C : Cert) (hC : certOK C = true) : ∀ b ∈ C.blocks1 ++ C.blocksq, psdCheck b = true := by
  simp only [certOK, psdAll, Bool.and_eq_true, List.all_eq_true] at hC; exact hC.2

private theorem shape_of (C : Cert) (hC : globalOK C = true) :
    (∀ b ∈ C.blocks1, b.m = C.reps.length + 1) ∧ (∀ b ∈ C.blocksq, 2 ≤ b.m) ∧
    (∀ b ∈ C.blocks1 ++ C.blocksq, ∀ wi ∈ b.wts, wi < C.weights.length) := by
  simp only [globalOK, Bool.and_eq_true, List.all_eq_true, Nat.beq_eq, Nat.ble_eq, Nat.blt_eq] at hC
  exact ⟨hC.1.1.2, hC.1.2, hC.2⟩

/-- **The times-1 blocks** (K2g, K2h): their constant, linear and quadratic terms sum to a non-negative number. -/
private theorem opSum_O23_nonneg (C : Cert) [NeZero C.p] (hC : certOK C = true) (φ : V C.p → ℝ) :
    0 ≤ opSum C.p φ (opsO2 C ++ opsO3 C (orbRows C)) := by
  have hg := globalOK_of C hC
  obtain ⟨hm, -, hw⟩ := shape_of C hg
  rw [opSum_O23_eq C hg]
  refine List.sum_nonneg fun x hx => ?_
  obtain ⟨b, hb, rfl⟩ := List.mem_map.1 hx
  exact blockT_nonneg C φ b C.reps (psd_of_psdCheck b (psdAll_of C hC b (List.mem_append_left _ hb)))
    (hm b hb).ge (hw b (List.mem_append_left _ hb))

/-- **The times-q blocks** (K2g, the q-part): `q(φ)` times a non-negative number. -/
private theorem opSum_O4_nonneg (C : Cert) [NeZero C.p] (hC : certOK C = true) (φ : V C.p → ℝ)
    (hq : 0 ≤ qform C.p φ) :
    0 ≤ opSum C.p φ (opsO4 C (qcoefs C)) := by
  have hg := globalOK_of C hC
  obtain ⟨-, hm, hw⟩ := shape_of C hg
  rw [opSum_O4_eq C hg]
  refine mul_nonneg hq (List.sum_nonneg fun x hx => ?_)
  obtain ⟨b, hb, rfl⟩ := List.mem_map.1 hx
  exact blockT_nonneg C φ b [[0]] (psd_of_psdCheck b (psdAll_of C hC b (List.mem_append_right _ hb)))
    (hm b hb) (hw b (List.mem_append_right _ hb))

/-- A row's ops evaluate to `± lam · Σ_γ Π_A φ∘γ · Π_B (1 − φ∘γ)`. -/
private theorem opSum_boxOps (p : ℕ) [NeZero p] (φ : V p → ℝ) (lam : ℕ) : ∀ (B A : List ℕ) (neg : Bool),
    opSum p φ (boxOps A lam B neg) = (if neg then -1 else 1) * (lam : ℝ) *
      ∑ γ ∈ affs p, (A.map fun x => φ (act γ (pt p x))).prod * (B.map fun x => 1 - φ (act γ (pt p x))).prod
  | [], A, neg => by cases neg <;> simp [boxOps, opSum, opVal, mono_nil, Ym]
  | b :: B, A, neg => by
      rw [boxOps, opSum_append, opSum_boxOps p φ lam B A neg, opSum_boxOps p φ lam B (A ++ [b]) (!neg)]
      have : ∀ γ, ((A ++ [b]).map fun x => φ (act γ (pt p x))).prod *
          (B.map fun x => 1 - φ (act γ (pt p x))).prod =
          (A.map fun x => φ (act γ (pt p x))).prod * (B.map fun x => 1 - φ (act γ (pt p x))).prod -
          (A.map fun x => φ (act γ (pt p x))).prod * ((b :: B).map fun x => 1 - φ (act γ (pt p x))).prod := by
        intro γ; simp [List.map_append, List.prod_append]; ring
      simp only [this, Finset.sum_sub_distrib]
      cases neg <;> simp <;> ring

/-- **The rows** (K2f): box products with non-negative multipliers. -/
private theorem opSum_O5_nonneg (C : Cert) [NeZero C.p] (φ : V C.p → ℝ)
    (h0 : ∀ x, 0 ≤ φ x) (h1 : ∀ x, φ x ≤ 1) :
    0 ≤ opSum C.p φ (opsO5 C) := by
  unfold opsO5
  induction rowList C with
  | nil => simp [opSum]
  | cons r rs ih =>
    rw [List.flatMap_cons, opSum_append]
    refine add_nonneg ?_ ih
    rw [opSum_boxOps]
    simp only [Bool.false_eq_true, ↓reduceIte, one_mul]
    refine mul_nonneg (Nat.cast_nonneg _) (Finset.sum_nonneg fun γ _ => mul_nonneg ?_ ?_)
    · exact List.prod_nonneg fun y hy => by
        obtain ⟨x, -, rfl⟩ := List.mem_map.1 hy; exact h0 _
    · exact List.prod_nonneg fun y hy => by
        obtain ⟨x, -, rfl⟩ := List.mem_map.1 hy; exact sub_nonneg.2 (h1 _)

private theorem gsize_pos (p : ℕ) [NeZero p] : 0 < gsize p := by
  unfold gsize affs
  have : ((0 : V p), ((1 : ZMod p), (0 : ZMod p)), false) ∈
      (Finset.univ ×ˢ (unitCircle p ×ˢ Finset.univ) : Finset (V p × V p × Bool)) := by
    simp [unitCircle]
  exact_mod_cast Finset.card_pos.mpr ⟨_, this⟩

private theorem scale_pos (C : Cert) (hC : certOK C = true) : 0 < C.scale := by
  simp only [certOK, globalOK, Bool.and_eq_true, Nat.blt_eq] at hC
  exact hC.1.1.1.1.1.1.1.1.1.1.2

/-- **An accepted certificate bounds the fibre-density region** (`SOUNDNESS.md` L4): `Σ φ ≤ U_num / L` for every
`φ ∈ [0, 1]^V` with `q(φ) ≥ 0`. The plan of its proof is `plans/FS131-KC13-certificates.md` § 5.2. -/
theorem sum_le_of_certOK (C : Cert) [NeZero C.p] (hC : certOK C = true) (φ : V C.p → ℝ)
    (h0 : ∀ x, 0 ≤ φ x) (h1 : ∀ x, φ x ≤ 1) (hq : 0 ≤ qform C.p φ) :
    ∑ x, φ x ≤ (C.unum : ℝ) / C.scale := by
  have hz := opSum_eq_zero C hC φ
  simp only [opList, opSum_append] at hz
  rw [opSum_O1] at hz
  have h23 := opSum_O23_nonneg C hC φ
  rw [opSum_append] at h23
  have h4 := opSum_O4_nonneg C hC φ hq
  have h5 := opSum_O5_nonneg C φ h0 h1
  have hG := gsize_pos C.p
  have hL : (0 : ℝ) < C.scale := by exact_mod_cast scale_pos C hC
  rw [le_div_iff₀ hL]
  have : (∑ x, φ x * C.scale) * gsize C.p ≤ (C.unum : ℝ) * gsize C.p := by
    rw [← Finset.sum_mul]; linarith
  rw [Finset.sum_mul]
  exact le_of_mul_le_mul_right this hG

/-- **Level one**: an independent set of `Cay((ℤ/p)², S)` has at most `U_num / L` points. -/
theorem card_le_of_certOK (C : Cert) [NeZero C.p] (hC : certOK C = true) (I : Finset (V C.p))
    (hI : ∀ x ∈ I, ∀ y ∈ I, y - x ∉ unitCircle C.p) : (I.card : ℝ) ≤ (C.unum : ℝ) / C.scale := by
  classical
  have h := sum_le_of_certOK C hC (fun x => if x ∈ I then 1 else 0) (fun x => by split_ifs <;> norm_num)
    (fun x => by split_ifs <;> norm_num) (by
      unfold qform
      have e1 : ∀ x : V C.p, (if x ∈ I then (1 : ℝ) else 0) * (1 - if x ∈ I then 1 else 0) = 0 := by
        intro x; split_ifs <;> norm_num
      have e2 : ∀ x : V C.p, ∑ s ∈ unitCircle C.p,
          (if x ∈ I then (1 : ℝ) else 0) * (if x + s ∈ I then 1 else 0) = 0 := by
        intro x
        refine Finset.sum_eq_zero fun s hs => ?_
        by_cases hx : x ∈ I
        · by_cases hy : x + s ∈ I
          · exact absurd (by simpa using hs) (hI x hx (x + s) hy)
          · simp [hy]
        · simp [hx]
      rw [Finset.sum_congr rfl (fun x _ => e1 x), Finset.sum_congr rfl (fun x _ => e2 x)]
      simp)
  simpa [Finset.sum_ite_mem, Finset.univ_inter] using h

/-- The hypotheses of `sum_le_of_certOK` hold together at `cert3`. -/
theorem model : certOK cert3 = true ∧
    ∃ φ : V 3 → ℝ, (∀ x, 0 ≤ φ x) ∧ (∀ x, φ x ≤ 1) ∧ 0 ≤ qform 3 φ :=
  ⟨cert3_ok, fun _ => 0, fun _ => le_rfl, fun _ => zero_le_one, by simp [qform]⟩

#print axioms sum_le_of_certOK
#print axioms card_le_of_certOK
#print axioms psd_of_psdCheck
#print axioms blockT_nonneg
#print axioms opSum_O23_eq
#print axioms opSum_O4_eq

end HadwigerNelson.FibreCertSound
