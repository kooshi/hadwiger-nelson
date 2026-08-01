import Mathlib.Combinatorics.SimpleGraph.Coloring.Vertex
import Mathlib.Combinatorics.SimpleGraph.Clique
import Mathlib.Data.ENNReal.Inv
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset

/-!
# The fractional chromatic number

`χ_f(G)`, the linear-programming relaxation of the chromatic number, and the one theorem that turns
a finite hand-checkable certificate into a lower bound on it.

Nothing in this file mentions the plane, unit distances, edge lists or `Fin n`, and nothing in it
depends on the rest of this project. Mathlib has `chromaticNumber` and, at the pin used here, has
nothing fractional at all; this module is shaped so that it could be read on its own terms.

## The definition, and why this one

A **`b`-fold `n`-colouring** gives every vertex at least `b` of the `n` colours and gives adjacent
vertices no colour in common (`FractionalColorable`). The fractional chromatic number is the
infimum of `n / b` over all of them. That is one of three standard presentations — the others being
a linear program over independent sets, and a homomorphism into a Kneser graph — and it is the one
whose proofs are shortest here, because the theorem below reads each vertex's colour set directly.

`ℝ≥0∞`, and `⨅`, for the reason `SimpleGraph.chromaticNumber` is `ℕ∞`: a graph with no fractional
colouring at all must come out `⊤`. Over `ℝ` the infimum of the empty set is `0`, and a lower bound
on it would then be *false* rather than vacuous.

## Using this file

Reason through the four named lemmas; never unfold the infimum.

* `le_fractionalChromaticNumber_iff` — what a lower bound *means*: every fractional colouring's
  ratio is at least `r`. Stated as an `iff` because both directions are one `le_iInf_iff`.
* `FractionalColorable.fractionalChromaticNumber_le` — the upper direction, from one colouring.
* `le_fractionalChromaticNumber_of_weights` — **the certificate.** Weights on the vertices and a
  bound no independent set exceeds give a lower bound. This is the theorem the milestone rests on.
* `not_colorable_of_lt_fractionalChromaticNumber` — what a fractional bound says about the ordinary
  chromatic number, which is how `χ_f(ℝ²) ≥ 65/18` re-proves `χ(ℝ²) ≥ 4`.
-/

open Finset
open scoped ENNReal

namespace SimpleGraph

universe u

variable {V W : Type*} {G : SimpleGraph V} {H : SimpleGraph W}

/-- A **`b`-fold `n`-colouring**: every vertex gets at least `b` of the `n` colours, and adjacent
vertices share none.

`b ≤ card` rather than `= card` deliberately. The two define the same predicate — a colour set with
more than `b` colours may be shrunk to exactly `b` without disturbing disjointness — and the
inequality is what every consumer here wants, while `Colorable.fractionalColorable` and
`FractionalColorable.mono_left` become one-liners. -/
def FractionalColorable (G : SimpleGraph V) (b n : ℕ) : Prop :=
  ∃ f : V → Finset (Fin n), (∀ v, b ≤ (f v).card) ∧ ∀ v w, G.Adj v w → Disjoint (f v) (f w)

/-- Fewer colours per vertex is easier. -/
theorem FractionalColorable.mono_left {b b' n : ℕ} (hb : b' ≤ b)
    (h : G.FractionalColorable b n) : G.FractionalColorable b' n := by
  obtain ⟨f, hcard, hdisj⟩ := h
  exact ⟨f, fun v => hb.trans (hcard v), hdisj⟩

/-- An ordinary `n`-colouring is a `1`-fold `n`-colouring. -/
theorem Colorable.fractionalColorable {n : ℕ} (h : G.Colorable n) :
    G.FractionalColorable 1 n := by
  obtain ⟨C⟩ := h
  exact ⟨fun v => {C v}, fun v => by simp, fun v w hvw => by
    simpa using fun hc => C.valid hvw hc⟩

/-- A fractional colouring pulls back along a graph homomorphism: colour `v` with the colours of
its image. -/
theorem FractionalColorable.comp {b n : ℕ} (φ : G →g H) (h : H.FractionalColorable b n) :
    G.FractionalColorable b n := by
  obtain ⟨f, hcard, hdisj⟩ := h
  exact ⟨f ∘ φ, fun v => hcard _, fun v w hvw => hdisj _ _ (φ.map_adj hvw)⟩

/-- **The fractional chromatic number**: the infimum of `n / b` over `b`-fold `n`-colourings, and
`⊤` when there are none.

Never unfold this. `le_fractionalChromaticNumber_iff` and
`FractionalColorable.fractionalChromaticNumber_le` are the whole reasoning surface. -/
noncomputable def fractionalChromaticNumber (G : SimpleGraph V) : ℝ≥0∞ :=
  ⨅ (b : ℕ) (n : ℕ) (_ : 0 < b) (_ : G.FractionalColorable b n), (n : ℝ≥0∞) / b

/-- **What a lower bound means.** An `iff`, because both directions are `le_iInf_iff` and stating
only the one this project uses would implicate that the other is hard. -/
theorem le_fractionalChromaticNumber_iff {r : ℝ≥0∞} :
    r ≤ G.fractionalChromaticNumber ↔
      ∀ b n : ℕ, 0 < b → G.FractionalColorable b n → r ≤ (n : ℝ≥0∞) / b := by
  simp only [fractionalChromaticNumber, le_iInf_iff]

/-- One colouring bounds the infimum from above. -/
theorem FractionalColorable.fractionalChromaticNumber_le {b n : ℕ} (hb : 0 < b)
    (h : G.FractionalColorable b n) : G.fractionalChromaticNumber ≤ (n : ℝ≥0∞) / b := by
  refine iInf_le_of_le b (iInf_le_of_le n (iInf_le_of_le hb (iInf_le_of_le h le_rfl)))

/-- The fractional chromatic number does not increase along a homomorphism. -/
theorem fractionalChromaticNumber_mono_of_hom (φ : G →g H) :
    G.fractionalChromaticNumber ≤ H.fractionalChromaticNumber :=
  le_fractionalChromaticNumber_iff.mpr fun _ _ hb hc =>
    (hc.comp φ).fractionalChromaticNumber_le hb

/-- **A graph below its fractional bound is not `k`-colourable.** The bridge from a fractional lower
bound to an ordinary one, and the analogue of `lt_chromaticNumber_iff_not_colorable`.

Stated in place of `χ_f ≤ χ`: that inequality pushes a coercion through an infimum, which no
consumer here needs, and this is what the corollary actually calls. -/
theorem not_colorable_of_lt_fractionalChromaticNumber {k : ℕ}
    (h : (k : ℝ≥0∞) < G.fractionalChromaticNumber) : ¬ G.Colorable k := fun hc => by
  refine absurd (hc.fractionalColorable.fractionalChromaticNumber_le Nat.one_pos) (not_le.mpr ?_)
  simpa using h

/-! ## The certificate -/

variable [Fintype V] [DecidableEq V]

/-- **The double count**, isolated: `n` independent sets covering every vertex at least `b` times,
against a bound no independent set's weight exceeds.

Summing the weight of each of the `n` classes counts each vertex once per class containing it, so
at least `b` times — and each class weighs at most `D`. -/
private theorem weight_le_of_indepSet_cover (w : V → ℕ) {b n D : ℕ} (S : Fin n → Finset V)
    (hind : ∀ c, G.IsIndepSet (S c : Set V))
    (hcov : ∀ v, b ≤ #{c | v ∈ S c})
    (hD : ∀ I : Finset V, G.IsIndepSet (I : Set V) → ∑ v ∈ I, w v ≤ D) :
    b * ∑ v, w v ≤ n * D := by
  calc b * ∑ v, w v
      = ∑ v, b * w v := Finset.mul_sum _ _ _
    _ ≤ ∑ v, #{c | v ∈ S c} * w v :=
        Finset.sum_le_sum fun v _ => Nat.mul_le_mul_right _ (hcov v)
    _ = ∑ v, ∑ c : Fin n, if v ∈ S c then w v else 0 := by
        refine Finset.sum_congr rfl fun v _ => ?_
        rw [← Finset.sum_filter, Finset.sum_const, smul_eq_mul]
    _ = ∑ c : Fin n, ∑ v, if v ∈ S c then w v else 0 := Finset.sum_comm
    _ = ∑ c : Fin n, ∑ v ∈ S c, w v := by
        refine Finset.sum_congr rfl fun c _ => ?_
        rw [← Finset.sum_filter, Finset.filter_univ_mem]
    _ ≤ ∑ _c : Fin n, D := Finset.sum_le_sum fun c _ => hD _ (hind c)
    _ = n * D := by simp [Finset.sum_const]

/-- **The certificate theorem.** Natural-number weights on the vertices and a bound `D` that no
independent set's weight exceeds give a lower bound on the fractional chromatic number.

This is the whole of "a finite graph certifies a fractional bound", and the proof is one double
count: in any `b`-fold `n`-colouring each colour class is independent, so weighs at most `D`, and
summing over the `n` colours counts every vertex at least `b` times.

The bound is stated at any `S / T` the weights support. `hST` is `S / T ≤ (∑ w) / D` written
without division, so the obligation a caller discharges stays in `ℕ` — which is what lets the
headline read `65 / 18` rather than the `260 / 72` the weights literally produce. For the bound the
weights give directly, pass `S := ∑ v, w v`, `T := D` and `hST := le_of_eq (mul_comm _ _)`. -/
theorem le_fractionalChromaticNumber_of_weights (w : V → ℕ) {S T D : ℕ}
    (hD : 0 < D) (hST : S * D ≤ T * ∑ v, w v)
    (hI : ∀ I : Finset V, G.IsIndepSet (I : Set V) → ∑ v ∈ I, w v ≤ D) :
    (S : ℝ≥0∞) / T ≤ G.fractionalChromaticNumber := by
  refine le_fractionalChromaticNumber_iff.mpr fun b n hb ⟨f, hcard, hdisj⟩ => ?_
  -- Every colour class is independent, and every vertex lies in at least `b` of them.
  have hclass : ∀ c : Fin n, G.IsIndepSet (({v | c ∈ f v} : Finset V) : Set V) := by
    intro c x hx y hy hxy hadj
    simp only [Finset.coe_filter, Set.mem_setOf_eq, Finset.mem_univ, true_and] at hx hy
    exact Finset.disjoint_left.mp (hdisj x y hadj) hx hy
  have hcov : ∀ v, b ≤ #{c | v ∈ ({v | c ∈ f v} : Finset V)} := fun v =>
    (hcard v).trans (le_of_eq (congrArg Finset.card (by ext c; simp)).symm)
  -- The double count, then cross-multiply out of `ℝ≥0∞`.
  have key : b * ∑ v, w v ≤ n * D := weight_le_of_indepSet_cover w _ hclass hcov hI
  have hnat : S * b ≤ n * T := by
    refine Nat.le_of_mul_le_mul_right ?_ hD
    calc S * b * D = S * D * b := by ring
      _ ≤ T * (∑ v, w v) * b := Nat.mul_le_mul_right _ hST
      _ = T * (b * ∑ v, w v) := by ring
      _ ≤ T * (n * D) := Nat.mul_le_mul_left _ key
      _ = n * T * D := by ring
  have hb0 : (b : ℝ≥0∞) ≠ 0 := by exact_mod_cast hb.ne'
  rcases Nat.eq_zero_or_pos T with rfl | hT
  · -- `T = 0` forces `S = 0`, and `0 / 0 = 0` in `ℝ≥0∞`.
    have h0 : S * b = 0 := Nat.le_zero.mp (by simpa using hnat)
    have hS0 : S = 0 := (Nat.mul_eq_zero.mp h0).resolve_right hb.ne'
    simp [hS0]
  have hT0 : (T : ℝ≥0∞) ≠ 0 := by exact_mod_cast hT.ne'
  rw [ENNReal.div_le_iff_le_mul (Or.inl hT0) (Or.inl (by simp)), mul_comm, ← mul_div_assoc,
    ENNReal.le_div_iff_mul_le (Or.inl hb0) (Or.inl (by simp))]
  exact_mod_cast hnat.trans_eq (Nat.mul_comm n T)

/-- The uniform case: no independent set larger than `a`, so `|V| / a` is a lower bound. -/
theorem le_fractionalChromaticNumber_of_indepNum {a : ℕ} (ha : 0 < a)
    (h : ∀ I : Finset V, G.IsIndepSet (I : Set V) → I.card ≤ a) :
    ((Fintype.card V : ℕ) : ℝ≥0∞) / a ≤ G.fractionalChromaticNumber := by
  refine le_fractionalChromaticNumber_of_weights (fun _ => 1) ha ?_ ?_
  · simp [Finset.card_univ, mul_comm]
  · intro I hI; simpa using h I hI

end SimpleGraph
