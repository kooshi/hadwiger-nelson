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

/-- An op's value. -/
private def opVal (o : Op) : ℤ := (o.vp : ℤ) - o.vn

/-- The identity at the moments: the sum of every op's value times its moment. -/
private noncomputable def opSum (p : ℕ) [NeZero p] (φ : V p → ℝ) (l : List Op) : ℝ :=
  (l.map fun o => (opVal o : ℝ) * Ym p φ (o.mono p)).sum

private theorem opSum_append (p : ℕ) [NeZero p] (φ : V p → ℝ) (l l' : List Op) :
    opSum p φ (l ++ l') = opSum p φ l + opSum p φ l' := by
  simp [opSum]

/-! ### The children (FS131-IKC1 § 3: each a leaf until proved) -/

/-- **The computation half** (K2a–d, K2i): an accepted certificate's ops sum to zero at the moments. -/
private theorem opSum_eq_zero (C : Cert) [NeZero C.p] (hC : certOK C = true) (φ : V C.p → ℝ) :
    opSum C.p φ (opList C (orbRows C) (qcoefs C)) = 0 := by
  sorry

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

/-- **The times-1 blocks** (K2g, K2h): their constant, linear and quadratic terms sum to a non-negative number. -/
private theorem opSum_O23_nonneg (C : Cert) [NeZero C.p] (hC : certOK C = true) (φ : V C.p → ℝ)
    (h0 : ∀ x, 0 ≤ φ x) (h1 : ∀ x, φ x ≤ 1) :
    0 ≤ opSum C.p φ (opsO2 C ++ opsO3 C (orbRows C)) := by
  sorry

/-- **The times-q blocks** (K2g, the q-part): `q(φ)` times a non-negative number. -/
private theorem opSum_O4_nonneg (C : Cert) [NeZero C.p] (hC : certOK C = true) (φ : V C.p → ℝ)
    (h0 : ∀ x, 0 ≤ φ x) (h1 : ∀ x, φ x ≤ 1) (hq : 0 ≤ qform C.p φ) :
    0 ≤ opSum C.p φ (opsO4 C (qcoefs C)) := by
  sorry

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
  have h23 := opSum_O23_nonneg C hC φ h0 h1
  rw [opSum_append] at h23
  have h4 := opSum_O4_nonneg C hC φ h0 h1 hq
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

end HadwigerNelson.FibreCertSound
