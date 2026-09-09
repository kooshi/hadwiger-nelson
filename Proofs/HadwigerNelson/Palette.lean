import Proofs.HadwigerNelson.Fan

/-!
# Compulsions are statements about the palette's size, not about `Fin k` (SKELETON)
-/

namespace HadwigerNelson

open SimpleGraph

variable {V α : Type*} {G : SimpleGraph V} {k : ℕ} {p q : V}

theorem Forces.eq_of_equiv (h : Forces G k p q) (e : α ≃ Fin k) (C : G.Coloring α) :
    C p = C q := sorry

theorem Forces.of_equiv (e : α ≃ Fin k) (h : ∀ C : G.Coloring α, C p = C q) :
    Forces G k p q := sorry

theorem forces_iff_forall_coloring (e : α ≃ Fin k) :
    Forces G k p q ↔ ∀ C : G.Coloring α, C p = C q := sorry

theorem Forces.eq_of_card [Fintype α] (h : Forces G k p q) (hk : Fintype.card α = k)
    (C : G.Coloring α) : C p = C q := sorry

theorem not_forces_of_coloring_ne [Fintype α] (hk : Fintype.card α = k) (C : G.Coloring α)
    (hne : C p ≠ C q) : ¬ Forces G k p q := sorry

theorem Separated.ne_of_equiv (h : Separated G k p q) (e : α ≃ Fin k) (C : G.Coloring α) :
    C p ≠ C q := sorry

theorem Separated.of_equiv (e : α ≃ Fin k) (h : ∀ C : G.Coloring α, C p ≠ C q) :
    Separated G k p q := sorry

theorem separated_iff_forall_coloring (e : α ≃ Fin k) :
    Separated G k p q ↔ ∀ C : G.Coloring α, C p ≠ C q := sorry

theorem Separated.ne_of_card [Fintype α] (h : Separated G k p q) (hk : Fintype.card α = k)
    (C : G.Coloring α) : C p ≠ C q := sorry

theorem not_separated_of_coloring_eq [Fintype α] (hk : Fintype.card α = k) (C : G.Coloring α)
    (heq : C p = C q) : ¬ Separated G k p q := sorry

end HadwigerNelson
