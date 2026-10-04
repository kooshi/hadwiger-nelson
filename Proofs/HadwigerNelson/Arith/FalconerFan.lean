import Mathlib.Combinatorics.SimpleGraph.Coloring.Vertex

/-!
# Falconer fans through graph homomorphisms (FS-131 wave 1)

Rows: **FS129-SA1-FALC-FAN** (carrying FS129-MA1-FALC-T and FS129-MA2-FALC-GAP4) and **FS129-SA1-FALC-DICHO-K** (carrying
FS129-MA2-FALC-DICHO). Plan: `plans/FS131-kernel-plan.md` § 6.

A **Falconer fan at `k` colours** with apex `a` and tip `t` (`a ≠ t`, not adjacent): every proper `k`-colouring of `H − a`
in which `N(a)` avoids two distinct colours `c₁, c₂` gives `t` one of `c₁, c₂`. `H − a` is the induced subgraph on
`{v | v ≠ a}`. The rows say "a finite graph"; neither argument reads finiteness, so it is not assumed (reported).
Inhabitant: the unit rhombus at four colours (`rhombus_falconerFan`).
-/

namespace HadwigerNelson.Arith

open SimpleGraph

/-- A Falconer fan at `k` colours with apex `a` and tip `t`. -/
def FalconerFan {V : Type*} (H : SimpleGraph V) (k : ℕ) (a t : V) : Prop :=
  a ≠ t ∧ ¬ H.Adj a t ∧
    ∀ C : (H.induce {v | v ≠ a}).Coloring (Fin k), ∀ c₁ c₂ : Fin k, c₁ ≠ c₂ →
      (∀ v (hv : v ≠ a), H.Adj a v → C ⟨v, hv⟩ ≠ c₁ ∧ C ⟨v, hv⟩ ≠ c₂) →
        ∀ ht : t ≠ a, C ⟨t, ht⟩ = c₁ ∨ C ⟨t, ht⟩ = c₂

/-- The unit rhombus `0 – {1, 2} – 3` with the short diagonal `1 – 2`. -/
def rhombus : SimpleGraph (Fin 4) :=
  SimpleGraph.fromRel fun i j => (i, j) ∈ [((0 : Fin 4), (1 : Fin 4)), (0, 2), (1, 2), (1, 3), (2, 3)]

/-- **Inhabitant**: the unit rhombus is a Falconer fan at four colours with apex `0` and tip `3`. -/
theorem rhombus_falconerFan : FalconerFan rhombus 4 0 3 := by
  sorry

/-- **FS129-SA1-FALC-FAN**: let `k ≥ 3`, `(H, a, t)` a Falconer fan at `k` colours, and `ρ : H →g T`. (A) For every
proper `k`-colouring `C` of `T` and every colour `γ` absent from `N_T[ρ(a)]`, `C(ρ(t)) ∈ {C(ρ(a)), γ}`, and every
colour absent from `N_T[ρ(t)]` lies in `{C(ρ(a)), γ}`. (B) Every proper `(k − 1)`-colouring of `T` gives `ρ(a)` and
`ρ(t)` one colour and leaves none of its `k − 1` colours absent from `N_T[ρ(t)]`. -/
theorem falconerFan_hom {V W : Type*} {H : SimpleGraph V} {T : SimpleGraph W} {k : ℕ} (hk : 3 ≤ k) {a t : V}
    (hfan : FalconerFan H k a t) (ρ : H →g T) :
    (∀ (C : T.Coloring (Fin k)) (γ : Fin k), (∀ x, (x = ρ a ∨ T.Adj (ρ a) x) → C x ≠ γ) →
      (C (ρ t) = C (ρ a) ∨ C (ρ t) = γ) ∧
        ∀ δ : Fin k, (∀ x, (x = ρ t ∨ T.Adj (ρ t) x) → C x ≠ δ) → δ = C (ρ a) ∨ δ = γ) ∧
    (∀ C : T.Coloring (Fin (k - 1)), C (ρ a) = C (ρ t) ∧
      ∀ δ : Fin (k - 1), ∃ x, (x = ρ t ∨ T.Adj (ρ t) x) ∧ C x = δ) := by
  sorry

/-- **FS129-SA1-FALC-DICHO-K**: a Falconer fan `(H, a, t)` at `k ≥ 3` colours has `χ(H) ≥ k − 1`, and if `χ(H) = k − 1`
every proper `(k − 1)`-colouring of `H` gives `a` and `t` one colour. -/
theorem falconerFan_chromaticNumber {V : Type*} {H : SimpleGraph V} {k : ℕ} (hk : 3 ≤ k) {a t : V}
    (hfan : FalconerFan H k a t) :
    ((k - 1 : ℕ) : ℕ∞) ≤ H.chromaticNumber ∧
      (H.chromaticNumber = ((k - 1 : ℕ) : ℕ∞) → ∀ C : H.Coloring (Fin (k - 1)), C a = C t) := by
  sorry

end HadwigerNelson.Arith
