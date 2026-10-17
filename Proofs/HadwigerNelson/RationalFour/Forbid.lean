import Proofs.HadwigerNelson.RationalFour.Compulsion

/-!
# Which distances a four-colouring of rational four-space can forbid beside 1 (FS-131, FS131-KFS1, FS131-IRF1)

**The question** (`[Johnson2006]` p. 212): *"For which d > 0 does there exist a 4-coloring of ℚ⁴ which forbids both distances 1
and d?"*

**Read aloud, against the informal claim** (`CLOSED-QUESTIONS.md` § 3; LX-T6). For `d > 0`, a proper four-colouring of the
unit-distance graph on `ℚ⁴` in which no two points at distance `d` share a colour exists iff `d²` is not rational, or
`d² = p/q` with `p` and `q` odd natural numbers (`exists_coloring_forbidding_iff`). For `d² = p/q`, `p, q` odd, every proper
four-colouring forbids `d` (`coloring_forbids_of_odd`). On the rationals: for `r > 0`, a proper four-colouring forbidding
squared distance `r` exists iff `v₂(r) = 0` (`exists_coloring_forbidding_iff_padicValRat`).

**What it rests on:** the standard three axioms (`#print axioms`, audited at the gate); no outside theorem. The *if* half is `[Johnson1990]` Thm 3; the *only if* half, which
p. 212 calls open, is the compulsion law (`RationalFour/Compulsion`) with a rational similarity of ratio `d`.

**Not claimed:** anything about colourings with more than four colours; novelty (prior art: not found in print
(FS131-PAS2, FS131-PAS3; `CLOSED-QUESTIONS.md` § 3)).
-/

namespace HadwigerNelson.RationalFour

open Quaternion

/-- **Lagrange over `ℚ`**: every positive rational is a squared distance in `ℚ⁴`. -/
theorem exists_sqDist4_eq {r : ℚ} (hr : 0 < r) : ∃ x : Fin 4 → ℚ, sqDist4 x 0 = r := by
  obtain ⟨a, b, c, d, h⟩ := Nat.sum_four_squares (r.num.toNat * r.den)
  have hden : (r.den : ℚ) ≠ 0 := by positivity
  have hnum : ((r.num.toNat : ℤ) : ℚ) = r.num := by
    exact_mod_cast Int.toNat_of_nonneg (Rat.num_pos.2 hr).le
  have h' : (a : ℚ) ^ 2 + b ^ 2 + c ^ 2 + d ^ 2 = r.num * r.den := by
    rw [← hnum]
    exact_mod_cast h
  refine ⟨![a / r.den, b / r.den, c / r.den, d / r.den], ?_⟩
  rw [sqDist4, Fin.sum_univ_four]
  simp only [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two, Matrix.cons_val_three,
    Matrix.head_cons, Matrix.tail_cons, Pi.zero_apply, sub_zero]
  nth_rewrite 5 [← Rat.num_div_den r]
  field_simp
  linear_combination h'

/-- A positive rational has `v₂ = 0` iff it is a quotient of two odd natural numbers. -/
theorem padicValRat_eq_zero_iff_odd {r : ℚ} (hr : 0 < r) :
    padicValRat 2 r = 0 ↔ ∃ p q : ℕ, Odd p ∧ Odd q ∧ r = p / q := by
  have odd_of : ∀ n : ℕ, n ≠ 0 → padicValNat 2 n = 0 → Odd n := fun n hn h => by
    have : ¬ 2 ∣ n := fun h2 => (dvd_iff_padicValNat_ne_zero hn).1 h2 h
    exact Nat.odd_iff.2 (by omega)
  constructor
  · intro h
    have hnum : 0 < r.num := Rat.num_pos.2 hr
    set p := r.num.toNat with hpdef
    have hp : (p : ℤ) = r.num := Int.toNat_of_nonneg hnum.le
    have hp0 : p ≠ 0 := by omega
    have hr' : r = (p : ℚ) / r.den := by
      conv_lhs => rw [← Rat.num_div_den r]
      rw [← hp]
      rfl
    have hcop : Nat.Coprime p r.den := by
      have := r.reduced
      rwa [show r.num.natAbs = p by omega] at this
    rw [hr', padicValRat.div (by exact_mod_cast hp0) (by positivity), padicValRat.of_nat, padicValRat.of_nat,
      sub_eq_zero, Nat.cast_inj] at h
    -- `v₂(p) = v₂(q)`, and `p`, `q` are coprime: both are odd
    have hboth : padicValNat 2 p = 0 := by
      by_contra hne
      have h2p : 2 ∣ p := (dvd_iff_padicValNat_ne_zero hp0).2 hne
      have h2q : 2 ∣ r.den := (dvd_iff_padicValNat_ne_zero r.den_nz).2 (h ▸ hne)
      have h21 : 2 ∣ 1 := hcop ▸ Nat.dvd_gcd h2p h2q
      exact absurd h21 (by decide)
    exact ⟨p, r.den, odd_of p hp0 hboth, odd_of r.den r.den_nz (h ▸ hboth), hr'⟩
  · rintro ⟨p, q, hp, hq, rfl⟩
    have h2p : ¬ 2 ∣ p := fun h => by have := Nat.odd_iff.1 hp; omega
    have h2q : ¬ 2 ∣ q := fun h => by have := Nat.odd_iff.1 hq; omega
    rw [padicValRat.div (by exact_mod_cast hp.pos.ne') (by exact_mod_cast hq.pos.ne'), padicValRat.of_nat,
      padicValRat.of_nat, padicValNat.eq_zero_of_not_dvd h2p, padicValNat.eq_zero_of_not_dvd h2q]
    rfl

/-- **The answer on the rationals**: for `r > 0`, some proper four-colouring of `ℚ⁴` gives every pair at squared distance `r`
two colours iff `v₂(r) = 0`. -/
theorem exists_coloring_forbidding_iff_padicValRat {r : ℚ} (hr : 0 < r) :
    (∃ c : ratFourGraph.Coloring (Fin 4), ∀ x y, sqDist4 x y = r → c x ≠ c y) ↔ padicValRat 2 r = 0 := by
  constructor
  · rintro ⟨c, hc⟩
    by_contra hv
    rcases lt_or_gt_of_ne hv with hneg | hpos
    · -- `v₂(r) < 0`: the similarity `z ↦ z·q`, `|q|² = r`, makes `c` a colouring forbidding `1/r`, where `v₂ ≥ 1`
      obtain ⟨x₀, hx₀⟩ := exists_sqDist4_eq hr
      set q : ℍ[ℚ] := toQuat x₀ with hq
      have h0 : toQuat 0 = 0 := by ext <;> rfl
      have hqn : normSq q = r := by
        rw [← hx₀, ← sqDist_toQuat, sqDist, h0, sub_zero]
      have hsim : ∀ z w : ℍ[ℚ], sqDist4 (toQuat.symm (z * q)) (toQuat.symm (w * q)) = sqDist z w * r := by
        intro z w
        rw [← sqDist_toQuat, Equiv.apply_symm_apply, Equiv.apply_symm_apply, sqDist, sqDist, ← sub_mul, map_mul,
          hqn]
      let c' : quatGraph.Coloring (Fin 4) := SimpleGraph.Coloring.mk (fun z => c (toQuat.symm (z * q)))
        fun {z w} h => hc _ _ (by rw [hsim, quatGraph_adj.1 h, one_mul])
      obtain ⟨x₁, hx₁⟩ := exists_sqDist4_eq (inv_pos.2 hr)
      have hv1 : 1 ≤ val (toQuat x₁ - toQuat 0) := by
        show 1 ≤ padicValRat 2 (sqDist (toQuat x₁) (toQuat 0))
        rw [sqDist_toQuat, hx₁, padicValRat.inv]
        omega
      have heq := coloring_eq_of_mem_pr c' ((mem_pr_iff _).2 (Or.inr hv1))
      have hadj : ratFourGraph.Adj (toQuat.symm (toQuat x₁ * q)) (toQuat.symm (toQuat 0 * q)) := by
        rw [ratFourGraph_adj, hsim, sqDist_toQuat, hx₁, inv_mul_cancel₀ hr.ne']
      exact c.valid hadj heq
    · -- `v₂(r) ≥ 1`: a pair at squared distance `r` is forced to one colour
      obtain ⟨x, hx⟩ := exists_sqDist4_eq hr
      exact hc x 0 hx (coloring_eq_of_one_le_padicValRat c (by rw [hx]; omega))
  · intro hv
    obtain ⟨c⟩ := nonempty_ratFourGraph_coloring
    refine ⟨c, fun x y hxy => coloring_ne_of_padicValRat_eq_zero c ?_ (by rw [hxy]; exact hv)⟩
    rintro rfl
    have h0 : sqDist4 x x = 0 := by simp [sqDist4]
    rw [h0] at hxy
    exact hr.ne hxy

/-- **Every proper four-colouring of `ℚ⁴` forbids `√(p/q)`** for odd `p` and `q` (`[Zaks1999]` Theorem 3 is `q = 1`, `p` an odd
square). -/
theorem coloring_forbids_of_odd {p q : ℕ} (hp : Odd p) (hq : Odd q) (c : ratFourGraph.Coloring (Fin 4))
    {x y : Fin 4 → ℚ} (h : sqDist4 x y = p / q) : c x ≠ c y := by
  have hpos : (0 : ℚ) < p / q := div_pos (by exact_mod_cast hp.pos) (by exact_mod_cast hq.pos)
  refine coloring_ne_of_padicValRat_eq_zero c ?_ ?_
  · rintro rfl
    have h0 : sqDist4 x x = 0 := by simp [sqDist4]
    rw [h0] at h
    exact hpos.ne h
  · rw [h]
    exact (padicValRat_eq_zero_iff_odd hpos).2 ⟨p, q, hp, hq, rfl⟩

/-- **Which distances a four-colouring of `ℚ⁴` can forbid beside 1** (`[Johnson2006]` p. 212's question): for `d > 0`, a proper
four-colouring of the unit-distance graph on `ℚ⁴` forbidding distance `d` exists iff `d²` is irrational (no pair of `ℚ⁴` is at
distance `d`) or `d² = p/q` with `p, q` odd. The *if* half is `[Johnson1990]` Thm 3; the *only if* half is the compulsion
law with a rational similarity of ratio `d`. -/
theorem exists_coloring_forbidding_iff {d : ℝ} (hd : 0 < d) :
    (∃ c : ratFourGraph.Coloring (Fin 4), ∀ x y, (sqDist4 x y : ℝ) = d ^ 2 → c x ≠ c y) ↔
      (∀ r : ℚ, (r : ℝ) ≠ d ^ 2) ∨ ∃ p q : ℕ, Odd p ∧ Odd q ∧ d ^ 2 = (p : ℝ) / q := by
  by_cases hrat : ∃ r : ℚ, (r : ℝ) = d ^ 2
  · obtain ⟨r, hr⟩ := hrat
    have hr0 : 0 < r := by
      have : (0 : ℝ) < d ^ 2 := by positivity
      rw [← hr] at this
      exact_mod_cast this
    have hl : (∃ c : ratFourGraph.Coloring (Fin 4), ∀ x y, (sqDist4 x y : ℝ) = d ^ 2 → c x ≠ c y) ↔
        ∃ c : ratFourGraph.Coloring (Fin 4), ∀ x y, sqDist4 x y = r → c x ≠ c y := by
      simp only [← hr, Rat.cast_inj]
    rw [hl, exists_coloring_forbidding_iff_padicValRat hr0, padicValRat_eq_zero_iff_odd hr0]
    constructor
    · rintro ⟨p, q, hp, hq, rfl⟩
      exact Or.inr ⟨p, q, hp, hq, by rw [← hr]; push_cast; ring⟩
    · rintro (h | ⟨p, q, hp, hq, h⟩)
      · exact absurd hr (h r)
      · refine ⟨p, q, hp, hq, ?_⟩
        have : ((r : ℚ) : ℝ) = ((p / q : ℚ) : ℝ) := by rw [hr, h]; push_cast; ring
        exact_mod_cast this
  · push Not at hrat
    obtain ⟨c⟩ := nonempty_ratFourGraph_coloring
    exact iff_of_true ⟨c, fun x y h => absurd h (hrat _)⟩ (Or.inl hrat)

/-! ## Spec: Johnson's guess, and his `K` -/

/-- `√2` cannot be forbidden (`[Zaks1999]` Lemma 1; `v₂(2) = 1`). -/
example : ¬ ∃ c : ratFourGraph.Coloring (Fin 4), ∀ x y, sqDist4 x y = 2 → c x ≠ c y := by
  rw [exists_coloring_forbidding_iff_padicValRat (by norm_num)]
  have : padicValRat 2 (2 : ℚ) = 1 := padicValRat.self (p := 2) (by norm_num)
  rw [this]
  norm_num

/-- `√(1/2)` cannot be forbidden either (`v₂ = −1`: the similarity argument). -/
example : ¬ ∃ c : ratFourGraph.Coloring (Fin 4), ∀ x y, sqDist4 x y = 1 / 2 → c x ≠ c y := by
  rw [exists_coloring_forbidding_iff_padicValRat (by norm_num), one_div, padicValRat.inv]
  have : padicValRat 2 (2 : ℚ) = 1 := padicValRat.self (p := 2) (by norm_num)
  rw [this]
  norm_num

/-- `√(3/5)` is forbidden by every proper four-colouring. -/
example (c : ratFourGraph.Coloring (Fin 4)) {x y : Fin 4 → ℚ} (h : sqDist4 x y = 3 / 5) : c x ≠ c y :=
  coloring_forbids_of_odd (p := 3) (q := 5) (by decide) (by decide) c (by rw [h]; norm_num)

end HadwigerNelson.RationalFour
