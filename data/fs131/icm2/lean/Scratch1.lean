import Proofs.HadwigerNelson.Arith.WeilKloosterman
import Proofs.HadwigerNelson.Rigidity.ChainAtTA

namespace HadwigerNelson.Rigidity

open Finset

-- FS131-ICM2: Lemma P's algebra, in a finite ring with an involution `σ` and an ideal `K` of square zero stable under
-- `σ`, in which `2` is a unit (`2u = 1`) and some `ι` has `ι² = −1`, `σι = −ι`. `Kn` is the `−1` part of `K`, `Kp` the
-- `+1` part.
private structure SqZeroInv (R : Type*) [CommRing R] where
  σ : R →+* R
  invol : ∀ x, σ (σ x) = x
  K : Ideal R
  sq : ∀ a ∈ K, ∀ b ∈ K, a * b = 0
  σK : ∀ a ∈ K, σ a ∈ K
  u : R
  two_u : 2 * u = 1
  ι : R
  ι_sq : ι ^ 2 = -1
  σι : σ ι = -ι

open Classical in
private noncomputable def SqZeroInv.Kn {R : Type*} [CommRing R] [Fintype R] (D : SqZeroInv R) : Finset R :=
  univ.filter fun w => w ∈ D.K ∧ D.σ w = -w

open Classical in
private noncomputable def SqZeroInv.Kp {R : Type*} [CommRing R] [Fintype R] (D : SqZeroInv R) : Finset R :=
  univ.filter fun w => w ∈ D.K ∧ D.σ w = w

open Classical in
private noncomputable def SqZeroInv.Kf {R : Type*} [CommRing R] [Fintype R] (D : SqZeroInv R) : Finset R :=
  univ.filter fun w => w ∈ D.K

section SqZeroInv

variable {R : Type*} [CommRing R] [Fintype R]

private theorem SqZeroInv.mem_Kn (D : SqZeroInv R) {w : R} : w ∈ D.Kn ↔ w ∈ D.K ∧ D.σ w = -w := by
  classical
  unfold SqZeroInv.Kn
  simp

private theorem SqZeroInv.mem_Kp (D : SqZeroInv R) {w : R} : w ∈ D.Kp ↔ w ∈ D.K ∧ D.σ w = w := by
  classical
  unfold SqZeroInv.Kp
  simp

private theorem SqZeroInv.mem_Kf (D : SqZeroInv R) {w : R} : w ∈ D.Kf ↔ w ∈ D.K := by
  classical
  unfold SqZeroInv.Kf
  simp

omit [Fintype R] in
private theorem SqZeroInv.σu (D : SqZeroInv R) : D.σ D.u = D.u := by
  have h := congrArg D.σ D.two_u
  rw [map_mul, map_ofNat, map_one] at h
  linear_combination D.u * h - D.σ D.u * D.two_u

private theorem SqZeroInv.card_Kp_eq (D : SqZeroInv R) : D.Kp.card = D.Kn.card := by
  refine card_nbij' (fun a => D.ι * a) (fun b => -(D.ι * b)) ?_ ?_ ?_ ?_
  · intro a ha
    rw [Finset.mem_coe, D.mem_Kp] at ha
    rw [Finset.mem_coe, D.mem_Kn]
    refine ⟨D.K.mul_mem_left _ ha.1, ?_⟩
    rw [map_mul, D.σι, ha.2]; ring
  · intro b hb
    rw [Finset.mem_coe, D.mem_Kn] at hb
    rw [Finset.mem_coe, D.mem_Kp]
    refine ⟨D.K.neg_mem (D.K.mul_mem_left _ hb.1), ?_⟩
    rw [map_neg, map_mul, D.σι, hb.2]; ring
  · intro a _
    show -(D.ι * (D.ι * a)) = a
    linear_combination (-a) * D.ι_sq
  · intro b _
    show D.ι * -(D.ι * b) = b
    linear_combination (-b) * D.ι_sq

private theorem SqZeroInv.card_Kf_eq (D : SqZeroInv R) : D.Kf.card = D.Kp.card * D.Kn.card := by
  rw [← card_product]
  symm
  refine card_nbij' (fun p => p.1 + p.2) (fun f => (D.u * (f + D.σ f), D.u * (f - D.σ f))) ?_ ?_ ?_ ?_
  · rintro ⟨a, b⟩ hab
    rw [Finset.mem_coe, mem_product, D.mem_Kp, D.mem_Kn] at hab
    rw [Finset.mem_coe, D.mem_Kf]
    exact D.K.add_mem hab.1.1 hab.2.1
  · intro f hf
    rw [Finset.mem_coe, D.mem_Kf] at hf
    rw [Finset.mem_coe, mem_product, D.mem_Kp, D.mem_Kn]
    have hσf := D.σK f hf
    refine ⟨⟨D.K.mul_mem_left _ (D.K.add_mem hf hσf), ?_⟩, ⟨D.K.mul_mem_left _ (D.K.sub_mem hf hσf), ?_⟩⟩
    · rw [map_mul, map_add, D.invol, D.σu]; ring
    · rw [map_mul, map_sub, D.invol, D.σu]; ring
  · rintro ⟨a, b⟩ hab
    rw [Finset.mem_coe, mem_product, D.mem_Kp, D.mem_Kn] at hab
    simp only [map_add, hab.1.2, hab.2.2, Prod.mk.injEq]
    constructor
    · linear_combination a * D.two_u
    · linear_combination b * D.two_u
  · intro f _
    show D.u * (f + D.σ f) + D.u * (f - D.σ f) = f
    linear_combination f * D.two_u

/-- The `−1` part of `K` has a square's worth of `K`. -/
private theorem SqZeroInv.card_Kn_sq (D : SqZeroInv R) : D.Kn.card ^ 2 = D.Kf.card := by
  rw [D.card_Kf_eq, D.card_Kp_eq, pow_two]

open Classical in
/-- **Hensel in the abstract**: the lifts `x₀ + e`, `e ∈ K`, of norm one are as many as the `−1` part of `K`, whenever
`N(x₀) ≡ 1 (mod K)` — they are `e = z(w − u·d)`, `w` in the `−1` part, `d = N(x₀) − 1`, `z = (σx₀)⁻¹`. -/
private theorem SqZeroInv.card_lift (D : SqZeroInv R) {x₀ : R} (hx₀ : x₀ * D.σ x₀ - 1 ∈ D.K) :
    (D.Kf.filter fun e => (x₀ + e) * D.σ (x₀ + e) = 1).card = D.Kn.card := by
  obtain ⟨d, hd⟩ : ∃ d, x₀ * D.σ x₀ - 1 = d := ⟨_, rfl⟩
  rw [hd] at hx₀
  have hxy : x₀ * D.σ x₀ = 1 + d := by rw [← hd]; ring
  have hσd : D.σ d = d := by rw [← hd, map_sub, map_mul, D.invol, map_one]; ring
  have hdd : d * d = 0 := D.sq d hx₀ d hx₀
  have hyz : D.σ x₀ * (x₀ * (1 - d)) = 1 := by linear_combination (1 - d) * hxy - hdd
  symm
  refine card_nbij' (fun w => x₀ * (1 - d) * (w - D.u * d)) (fun e => D.σ x₀ * e + D.u * d) ?_ ?_ ?_ ?_
  · intro w hw
    rw [Finset.mem_coe, D.mem_Kn] at hw
    rw [Finset.mem_coe, Finset.mem_filter, D.mem_Kf]
    have heK : x₀ * (1 - d) * (w - D.u * d) ∈ D.K :=
      D.K.mul_mem_left _ (D.K.sub_mem hw.1 (D.K.mul_mem_left _ hx₀))
    refine ⟨heK, ?_⟩
    have hee := D.sq _ heK _ (D.σK _ heK)
    have heσ : x₀ * (1 - d) * (w - D.u * d) * D.σ x₀ = w - D.u * d := by
      linear_combination (w - D.u * d) * hyz
    have hσe' : D.σ (x₀ * (1 - d) * (w - D.u * d)) = D.σ x₀ * (1 - d) * (-w - D.u * d) := by
      simp only [map_mul, map_sub, map_one, hσd, hw.2, D.σu]
    have hσe : x₀ * D.σ (x₀ * (1 - d) * (w - D.u * d)) = -w - D.u * d := by
      rw [hσe']
      linear_combination (1 - d) * (-w - D.u * d) * hxy - (-w - D.u * d) * hdd
    rw [map_add]
    linear_combination hxy + hσe + heσ + hee - d * D.two_u
  · intro e he
    rw [Finset.mem_coe, Finset.mem_filter, D.mem_Kf] at he
    rw [Finset.mem_coe, D.mem_Kn]
    refine ⟨D.K.add_mem (D.K.mul_mem_left _ he.1) (D.K.mul_mem_left _ hx₀), ?_⟩
    have hee : e * D.σ e = 0 := D.sq e he.1 _ (D.σK e he.1)
    have hN := he.2
    rw [map_add] at hN
    rw [map_add, map_mul, map_mul, D.invol, D.σu, hσd]
    linear_combination hN - hxy - hee + d * D.two_u
  · intro w _
    show D.σ x₀ * (x₀ * (1 - d) * (w - D.u * d)) + D.u * d = w
    linear_combination (w - D.u * d) * hyz
  · intro e _
    show x₀ * (1 - d) * (D.σ x₀ * e + D.u * d - D.u * d) = e
    linear_combination e * hyz

/-- The `−1` part of `K` is closed under adding one of its own. -/
private theorem SqZeroInv.add_mem_Kn (D : SqZeroInv R) {w w₁ : R} (hw : w ∈ D.Kn) (hw₁ : w₁ ∈ D.Kn) :
    w + w₁ ∈ D.Kn := by
  rw [D.mem_Kn] at hw hw₁ ⊢
  exact ⟨D.K.add_mem hw.1 hw₁.1, by rw [map_add, hw.2, hw₁.2]; ring⟩

private theorem SqZeroInv.sub_mem_Kn (D : SqZeroInv R) {w w₁ : R} (hw : w ∈ D.Kn) (hw₁ : w₁ ∈ D.Kn) :
    w - w₁ ∈ D.Kn := by
  rw [D.mem_Kn] at hw hw₁ ⊢
  exact ⟨D.K.sub_mem hw.1 hw₁.1, by rw [map_sub, hw.2, hw₁.2]; ring⟩

/-- A character's sum over `x·Kn` is `|Kn|` if it is trivial there and `0` otherwise. -/
private theorem SqZeroInv.sum_Kn (D : SqZeroInv R) (ψ : AddChar R ℂ) (x : R) [Decidable (∀ w ∈ D.Kn, ψ (x * w) = 1)] :
    ∑ w ∈ D.Kn, ψ (x * w) = if (∀ w ∈ D.Kn, ψ (x * w) = 1) then (D.Kn.card : ℂ) else 0 := by
  split_ifs with hg
  · rw [Finset.sum_congr rfl hg, sum_const, nsmul_eq_mul, mul_one]
  · push Not at hg
    obtain ⟨w₁, hw₁, hψ₁⟩ := hg
    have hshift : ∑ w ∈ D.Kn, ψ (x * w) = ψ (x * w₁) * ∑ w ∈ D.Kn, ψ (x * w) := by
      rw [mul_sum]
      refine sum_nbij' (fun w => w - w₁) (fun w => w + w₁) (fun w hw => D.sub_mem_Kn hw hw₁)
        (fun w hw => D.add_mem_Kn hw hw₁) (fun w _ => by ring) (fun w _ => by ring) ?_
      intro w _
      rw [← AddChar.map_add_eq_mul]
      congr 1
      ring
    have h0 : (1 - ψ (x * w₁)) * ∑ w ∈ D.Kn, ψ (x * w) = 0 := by linear_combination hshift
    rcases mul_eq_zero.1 h0 with h | h
    · exact absurd (sub_eq_zero.1 h).symm hψ₁
    · exact h

open Classical in
/-- **Averaging over `1 + Kn`**: the sum of a character over the norm-one set is at most, in modulus, the number of
norm-one `x` whose line `x·Kn` it kills. -/
private theorem SqZeroInv.norm_sum_le (D : SqZeroInv R) (ψ : AddChar R ℂ) :
    ‖∑ x ∈ univ.filter (fun x => x * D.σ x = 1), ψ x‖ ≤
      ((univ.filter fun x => x * D.σ x = 1).filter fun x => ∀ w ∈ D.Kn, ψ (x * w) = 1).card := by
  set S := univ.filter (fun x : R => x * D.σ x = 1) with hS
  have hmemS : ∀ x, x ∈ S ↔ x * D.σ x = 1 := fun x => by simp [hS]
  have hww : ∀ w ∈ D.Kn, w * w = 0 := fun w hw => by
    rw [D.mem_Kn] at hw
    exact D.sq w hw.1 w hw.1
  -- each translate by `1 + w` permutes `S`
  have htr : ∀ w ∈ D.Kn, ∑ x ∈ S, ψ x = ∑ x ∈ S, ψ (x * (1 + w)) := by
    intro w hw
    have hσw : D.σ w = -w := (D.mem_Kn.1 hw).2
    refine sum_nbij' (fun x => x * (1 - w)) (fun x => x * (1 + w)) ?_ ?_ ?_ ?_ ?_
    · intro x hx
      rw [hmemS] at hx ⊢
      rw [map_mul, map_sub, map_one, hσw]
      linear_combination (1 - w * w) * hx - hww w hw
    · intro x hx
      rw [hmemS] at hx ⊢
      rw [map_mul, map_add, map_one, hσw]
      linear_combination (1 - w * w) * hx - hww w hw
    · intro x _
      show x * (1 - w) * (1 + w) = x
      linear_combination (-x) * hww w hw
    · intro x _
      show x * (1 + w) * (1 - w) = x
      linear_combination (-x) * hww w hw
    · intro x _
      show ψ x = ψ (x * (1 - w) * (1 + w))
      congr 1
      linear_combination x * hww w hw
  have hmain : (D.Kn.card : ℂ) * ∑ x ∈ S, ψ x =
      ∑ x ∈ S, ψ x * (if (∀ w ∈ D.Kn, ψ (x * w) = 1) then (D.Kn.card : ℂ) else 0) := by
    calc (D.Kn.card : ℂ) * ∑ x ∈ S, ψ x = ∑ w ∈ D.Kn, ∑ x ∈ S, ψ (x * (1 + w)) := by
          rw [Finset.sum_congr rfl (fun w hw => (htr w hw).symm), sum_const, nsmul_eq_mul]
      _ = ∑ x ∈ S, ∑ w ∈ D.Kn, ψ x * ψ (x * w) := by
          rw [Finset.sum_comm]
          refine Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun w _ => ?_
          rw [← AddChar.map_add_eq_mul]
          congr 1
          ring
      _ = _ := by
          refine Finset.sum_congr rfl fun x _ => ?_
          rw [← mul_sum, D.sum_Kn ψ x]
  have hpos : (0 : ℝ) < D.Kn.card := by
    have : (0 : R) ∈ D.Kn := by rw [D.mem_Kn]; exact ⟨D.K.zero_mem, by simp⟩
    exact_mod_cast Finset.card_pos.2 ⟨0, this⟩
  have hle : (D.Kn.card : ℝ) * ‖∑ x ∈ S, ψ x‖ ≤
      (D.Kn.card : ℝ) * (S.filter fun x => ∀ w ∈ D.Kn, ψ (x * w) = 1).card := by
    have h1 : ‖(D.Kn.card : ℂ) * ∑ x ∈ S, ψ x‖ = (D.Kn.card : ℝ) * ‖∑ x ∈ S, ψ x‖ := by
      rw [norm_mul, Complex.norm_natCast]
    rw [← h1, hmain]
    refine (_root_.norm_sum_le _ _).trans ?_
    have h2 : ∀ x ∈ S, ‖ψ x * (if (∀ w ∈ D.Kn, ψ (x * w) = 1) then (D.Kn.card : ℂ) else 0)‖ =
        if (∀ w ∈ D.Kn, ψ (x * w) = 1) then (D.Kn.card : ℝ) else 0 := by
      intro x _
      rw [norm_mul, AddChar.norm_apply, one_mul]
      split_ifs <;> simp
    rw [Finset.sum_congr rfl h2, Finset.sum_ite, sum_const_zero, add_zero, sum_const, nsmul_eq_mul]
    rw [mul_comm]
  exact le_of_mul_le_mul_left hle hpos

/-- **Two lines in the kernel of a character are one**: if `ψ` is non-trivial on `K` and kills both `x·Kn` and
`x'·Kn` (`x`, `x'` of norm one), then `x' ≡ ±x` modulo a prime `M` outside which every element is a unit. -/
private theorem SqZeroInv.pm_of_good (D : SqZeroInv R) (M : Ideal R) [hMp : M.IsPrime]
    (hM : ∀ x, x ∉ M → IsUnit x) (ψ : AddChar R ℂ) (hψ : ∃ e ∈ D.K, ψ e ≠ 1) {x x' : R}
    (hx : x * D.σ x = 1) (hx' : x' * D.σ x' = 1) (gx : ∀ w ∈ D.Kn, ψ (x * w) = 1)
    (gx' : ∀ w ∈ D.Kn, ψ (x' * w) = 1) : x' - x ∈ M ∨ x' + x ∈ M := by
  classical
  by_contra hcon
  push Not at hcon
  obtain ⟨e, he, hψe⟩ := hψ
  apply hψe
  have hμ : IsUnit (D.σ x' * x - x' * D.σ x) := by
    refine hM _ fun hμ => ?_
    have h1 : (x' - x) * (x' + x) ∈ M := by
      have h := M.mul_mem_left (x * x') hμ
      have e : x * x' * (D.σ x' * x - x' * D.σ x) = -((x' - x) * (x' + x)) := by
        linear_combination x ^ 2 * hx' - x' ^ 2 * hx
      rw [e] at h
      exact (M.neg_mem_iff).1 h
    rcases hMp.mem_or_mem h1 with h | h
    · exact hcon.1 h
    · exact hcon.2 h
  have hx'u : IsUnit x' := IsUnit.of_mul_eq_one _ hx'
  have hinj : ∀ (p : R × R) (hp : p ∈ D.Kn ×ˢ D.Kn) (p' : R × R) (hp' : p' ∈ D.Kn ×ˢ D.Kn),
      x * p.1 + x' * p.2 = x * p'.1 + x' * p'.2 → p = p' := by
    rintro ⟨a, b⟩ hp ⟨a', b'⟩ hp' heq
    rw [mem_product] at hp hp'
    have hc := D.sub_mem_Kn hp.1 hp'.1
    have hd := D.sub_mem_Kn hp'.2 hp.2
    have hxc : x * (a - a') = x' * (b' - b) := by linear_combination heq
    have hσxc : D.σ x * (a - a') = D.σ x' * (b' - b) := by
      have := congrArg D.σ hxc
      rw [map_mul, map_mul, (D.mem_Kn.1 hc).2, (D.mem_Kn.1 hd).2] at this
      linear_combination -this
    have hc0 : (D.σ x' * x - x' * D.σ x) * (a - a') = 0 := by
      linear_combination D.σ x' * hxc - x' * hσxc
    have ha : a - a' = 0 := (hμ.mul_right_eq_zero).1 hc0
    have hb : x' * (b' - b) = 0 := by rw [← hxc, ha, mul_zero]
    have hb' : b' - b = 0 := (hx'u.mul_right_eq_zero).1 hb
    simp only [Prod.mk.injEq]
    exact ⟨sub_eq_zero.1 ha, (sub_eq_zero.1 hb').symm⟩
  have hsurj := Finset.surj_on_of_inj_on_of_card_le (s := D.Kn ×ˢ D.Kn) (t := D.Kf)
    (fun p _ => x * p.1 + x' * p.2)
    (fun p hp => by
      rw [mem_product, D.mem_Kn, D.mem_Kn] at hp
      rw [D.mem_Kf]
      exact D.K.add_mem (D.K.mul_mem_left _ hp.1.1) (D.K.mul_mem_left _ hp.2.1))
    (fun p p' hp hp' h => hinj p hp p' hp' h)
    (by rw [card_product, ← pow_two, D.card_Kn_sq])
  obtain ⟨⟨a, b⟩, hab, rfl⟩ := hsurj e (D.mem_Kf.2 he)
  rw [mem_product] at hab
  rw [AddChar.map_add_eq_mul, gx a hab.1, gx' b hab.2, one_mul]

end SqZeroInv

end HadwigerNelson.Rigidity
