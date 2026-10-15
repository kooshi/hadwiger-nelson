#!/usr/bin/env python3
"""FS131-ICM4 part 3: fold FS131-ICM2's odd Lemma P chain onto FS131-ICM3's `SqZeroInvT` (θ = i), by content, on a file.
Usage: fold.py IN OUT. Every cut and every replacement must match exactly once, or nothing is written (exit 1)."""
import sys

src = open(sys.argv[1]).read()


def cut(t, start, stop, keep_stop=True):
    assert t.count(start) == 1, start
    i = t.index(start)
    j = t.index(stop, i)
    return t[:i] + (t[j:] if keep_stop else t[j + len(stop):])


def rep(t, a, b):
    assert t.count(a) == 1, a
    return t.replace(a, b)


t = src
# 1. the odd algebra
t = cut(t, "section LemmaPAlgebra\n", "end LemmaPAlgebra\n\n", keep_stop=False)
# 2. its data at the residue rings
t = cut(t, "-- FS131-ICM2: the data of the abstract algebra at level `n + 2`.\n",
        "-- FS131-ICM2: `|𝓞 ⧸ P^m| = Q^{2m}` (`cardQuot_pow_of_prime`).\n")
# 3. card_Kn_at, card_fibre
t = cut(t, "-- FS131-ICM2: at level `n + 2` the `−1` part of `K` has `Q` elements.\nprivate theorem card_Kn_at ",
        "-- FS131-ICM2: the residue map from level `n + 1` to level one.\n")
# 4. card_levelSet_one … charBound_of_charBound_one
t = cut(t, "-- FS131-ICM2: `|S₁| = Q + 1` (as in `charBound_one_weil`",
        "-- FS131-ICM3: **Lemma P with no unit `2`**")
# 5. the odd prime's θ
anchor = "-- FS131-ICM3: the data of the θ-algebra at level `n + 2`.\n"
t = rep(t, anchor, """-- FS131-ICM4: at an odd stable prime conjugation moves `i` off the prime (`ī − i = −2i`, and `(ī − i)·i = 2`): the odd
-- case of Lemma P is `SqZeroInvT` at `θ = i` (FS131-ICM2's `SqZeroInv`, folded onto it).
private theorem exists_conj_sub_notMem (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) :
    ∃ a : 𝓞 (fieldI F), conjO F a - a ∉ P.P := by
  obtain ⟨i, hi2, hci⟩ := exists_I_int (F := F)
  refine ⟨i, fun h => h2 ?_⟩
  have e : (2 : 𝓞 (fieldI F)) = (conjO F i - i) * i := by
    rw [hci]
    linear_combination 2 * hi2
  rw [e]
  exact P.P.mul_mem_right i h

""" + anchor)
# 6. the readers
t = rep(t, "  rw [card_levelSet_one P h2 hQ hfin]\n",
        "  rw [card_levelSet_oneT P (exists_conj_sub_notMem P h2).choose_spec hQ hfin]\n")
t = rep(t, "  have hcard := card_levelSet_one P h2 hQ hfin\n",
        "  have hcard := card_levelSet_oneT P (exists_conj_sub_notMem P h2).choose_spec hQ hfin\n")
t = rep(t, "    charBound_of_charBound_one P h2 hQ (two_div_le_weil hQ1) (charBound_one_weil P h2 hQ) hm\n",
        "    charBound_of_charBound_oneT P (exists_conj_sub_notMem P h2).choose_spec hQ (two_div_le_weil hQ1)\n"
        "      (charBound_one_weil P h2 hQ) hm\n")
t = rep(t, "fun _ hm => charBound_of_charBound_one P h2 hQ hκQ hκ1 hm⟩",
        "fun _ hm =>\n      charBound_of_charBound_oneT P (exists_conj_sub_notMem P h2).choose_spec hQ hκQ hκ1 hm⟩")
# 7. comments that named the deleted chain
t = rep(t, "-- level (`charBound_of_charBound_one`, a named leaf).", "-- level (`charBound_of_charBound_oneT`, at `θ = i` when `2 ∉ P`).")
t = rep(t, "-- odd case `θ = ι` serves (FS131-ICM2's `SqZeroInv`); at an unramified dyadic prime",
        "-- odd case `θ = i` serves (`exists_conj_sub_notMem`; FS131-ICM2's `SqZeroInv`, folded onto this by FS131-ICM4); at an\n-- unramified dyadic prime")
t = rep(t, "lifts at level `n + 1` (`card_fibre`, by", "lifts at level `n + 1` (`card_fibreT`, by")
# 8. the certificate link's second hypothesis as one lemma (the coordinator's constraint on the fold, FS131-IKL1)
anchor2 = "/-- **Lemma P with no unit `2`** (FS131-ICM3; KR1 § 2.6 (b), the dyadic form)"
t = rep(t, anchor2, """-- FS131-ICM4: **Lemma P's per-character bound at every level** (one lemma, for the certificate link, FS131-IKL1): at a
-- stable prime that conjugation moves, a character of `𝓞 ⧸ P^{n+1}` non-trivial on the kernel of the residue map to level
-- one sums to at most `2|S_{n+1}|/(Q + 1)` (`= 2Q^n`, `card_levelSet_succT`) in modulus over `S_{n+1}`: descend while it is
-- trivial on the kernel of the reduction (the sum is `Q` times the sum one level down, `card_fibreT`), and bound it by
-- `norm_charSum_new_leT` at the level where it is new.
private theorem norm_charSum_le_of_resT [NumberField F] (P : StablePrime F) {a : 𝓞 (fieldI F)}
    (ha : conjO F a - a ∉ P.P) {Q : ℕ} (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (n : ℕ)
    (hfin : (levelSet P (n + 1)).Finite) (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ (n + 1)) ℂ)
    (hψ : ∃ e, res P n e = 0 ∧ ψ e ≠ 1) :
    ‖∑ s ∈ hfin.toFinset, ψ s‖ ≤ 2 / ((Q : ℝ) + 1) * hfin.toFinset.card := by
  classical
  induction n with
  | zero =>
    obtain ⟨e, he, hψe⟩ := hψ
    rw [res_zero] at he
    rw [he, AddChar.map_zero_eq_one] at hψe
    exact absurd rfl hψe
  | succ n ih =>
    haveI := finite_quot_pow P (n + 1)
    have hfin' : (levelSet P (n + 1)).Finite := Set.toFinite _
    have hmaps : ∀ x ∈ hfin.toFinset, red P n x ∈ hfin'.toFinset := fun x hx =>
      hfin'.mem_toFinset.2 (red_mem_levelSet P n (hfin.mem_toFinset.1 hx))
    by_cases hK : ∀ e, red P n e = 0 → ψ e = 1
    · obtain ⟨ψ', hψ'⟩ := exists_addChar_descent P n ψ hK
      have hψ'1 : ∃ e, res P n e = 0 ∧ ψ' e ≠ 1 := by
        obtain ⟨e, he, hψe⟩ := hψ
        exact ⟨red P n e, by rw [res_red]; exact he, by rw [← hψ' e]; exact hψe⟩
      have hsum : ∑ s ∈ hfin.toFinset, ψ s = ((Q : ℝ) : ℂ) * ∑ t ∈ hfin'.toFinset, ψ' t := by
        rw [← Finset.sum_fiberwise_of_maps_to hmaps, Finset.mul_sum]
        refine Finset.sum_congr rfl fun t ht => ?_
        have hc : ∀ x ∈ hfin.toFinset.filter (fun x => red P n x = t), ψ x = ψ' t := fun x hx => by
          rw [hψ' x, (Finset.mem_filter.1 hx).2]
        rw [Finset.sum_congr rfl hc, Finset.sum_const, card_fibreT P ha hQ n hfin (hfin'.mem_toFinset.1 ht),
          nsmul_eq_mul]
        push_cast
        ring
      have hcard : (hfin.toFinset.card : ℝ) = Q * hfin'.toFinset.card := by
        rw [Finset.card_eq_sum_card_fiberwise hmaps,
          Finset.sum_congr rfl fun t ht => card_fibreT P ha hQ n hfin (hfin'.mem_toFinset.1 ht)]
        rw [Finset.sum_const, smul_eq_mul]
        push_cast
        ring
      have hih := ih hfin' ψ' hψ'1
      rw [hsum, norm_mul, Complex.norm_real, Real.norm_of_nonneg (Nat.cast_nonneg _), hcard]
      have hQ0 : (0 : ℝ) ≤ Q := Nat.cast_nonneg _
      calc (Q : ℝ) * ‖∑ t ∈ hfin'.toFinset, ψ' t‖ ≤ Q * (2 / ((Q : ℝ) + 1) * hfin'.toFinset.card) :=
            mul_le_mul_of_nonneg_left hih hQ0
        _ = 2 / ((Q : ℝ) + 1) * (Q * hfin'.toFinset.card) := by ring
    · push Not at hK
      obtain ⟨e, he, hψe⟩ := hK
      exact norm_charSum_new_leT P ha hQ n hfin ψ ⟨e, he, hψe⟩

""" + anchor2)
open(sys.argv[2], "w").write(t)
print(f"lines {src.count(chr(10))} -> {t.count(chr(10))}")
