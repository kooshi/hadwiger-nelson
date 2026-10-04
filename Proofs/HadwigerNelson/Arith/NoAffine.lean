import Mathlib.Combinatorics.SimpleGraph.Coloring.Vertex
import Mathlib.Algebra.BigOperators.Finprod
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

/-!
# No affine identity survives a gapped target (FS-131 wave 1)

Row: **FS129-SA1-NOAFF-K** (carrying FS84-S1-S1e, FS129-OA1-NOLIN5, FS129-MA1-NOAFF5 and MA2's `k = 4` note; SA1 item 1).
Plan: `plans/FS131-kernel-plan.md` § 6. Its two-vertex case is row 66's `Slack.forces_iff_of_hom`.

A **gap** at a vertex `w` of `T` in a proper colouring `C'` is a colour absent from the closed neighbourhood `N_T[w]`.
Route (the row's `uses only:`): pull `C'` back along `ρ`, permute the palette, and repaint `u` alone with the permuted gap —
both are proper colourings of `G` differing only at `u`, so the identity forces `φ_u` to agree on every ordered pair of
distinct colours.
-/

namespace HadwigerNelson.Arith

open SimpleGraph

/-- Repainting one vertex changes the finite sum by exactly the difference at that vertex. -/
theorem finsum_update_apply {V : Type*} [DecidableEq V] {k : ℕ} (φ : V → Fin k → ℝ) (hφ : (Function.support φ).Finite)
    (D : V → Fin k) (u : V) (x : Fin k) :
    ∑ᶠ v, φ v (Function.update D u x v) + φ u (D u) = ∑ᶠ v, φ v (D v) + φ u x := by
  classical
  set S : Finset V := hφ.toFinset ∪ {u} with hS
  have hu : u ∈ S := by simp [hS]
  have hsupp : ∀ E : V → Fin k, Function.support (fun v => φ v (E v)) ⊆ ↑S := by
    intro E v hv
    have : φ v ≠ 0 := fun h => hv (by simp [h])
    simp [hS, this]
  rw [finsum_eq_sum_of_support_subset _ (hsupp _), finsum_eq_sum_of_support_subset _ (hsupp D),
    ← Finset.add_sum_erase S _ hu, ← Finset.add_sum_erase S (fun v => φ v (D v)) hu]
  have : ∑ v ∈ S.erase u, φ v (Function.update D u x v) = ∑ v ∈ S.erase u, φ v (D v) :=
    Finset.sum_congr rfl fun v hv => by rw [Function.update_of_ne (Finset.ne_of_mem_erase hv)]
  rw [this]; simp; ring

/-- Any two ordered pairs of distinct colours are related by a permutation of the palette. -/
theorem exists_perm_pair {k : ℕ} {a b i j : Fin k} (hab : a ≠ b) (hij : i ≠ j) :
    ∃ π : Equiv.Perm (Fin k), π a = i ∧ π b = j := by
  classical
  have hb' : Equiv.swap a i b ≠ i := by
    intro h
    have : Equiv.swap a i b = Equiv.swap a i a := by rw [Equiv.swap_apply_left]; exact h
    exact hab ((Equiv.swap a i).injective this).symm
  refine ⟨(Equiv.swap a i).trans (Equiv.swap (Equiv.swap a i b) j), ?_, ?_⟩
  · simp only [Equiv.trans_apply, Equiv.swap_apply_left]
    exact Equiv.swap_apply_of_ne_of_ne hb'.symm hij
  · simp

/-- **FS129-SA1-NOAFF-K**: let `k ≥ 2`, `ρ : G →g T`, and `φ_v : Fin k → ℝ` (all but finitely many identically zero) with
`Σ_v φ_v(C(v)) = b` for every proper `k`-colouring `C` of `G`. Then `φ_u` is constant at every `u` such that some proper
`k`-colouring of `T` leaves a colour absent from `N_T[ρ(u)]`; and if every vertex of `T` has such a colouring, every
`φ_v` is constant and `b` is the sum of their values. -/
theorem noAffine {V W : Type*} {G : SimpleGraph V} {T : SimpleGraph W} {k : ℕ} (hk : 2 ≤ k) (ρ : G →g T)
    (φ : V → Fin k → ℝ) (hφ : (Function.support φ).Finite) (b : ℝ)
    (hconst : ∀ C : G.Coloring (Fin k), ∑ᶠ v, φ v (C v) = b) :
    (∀ u, (∃ C' : T.Coloring (Fin k), ∃ γ : Fin k, ∀ x, (x = ρ u ∨ T.Adj (ρ u) x) → C' x ≠ γ) →
      ∀ i j, φ u i = φ u j) ∧
    ((∀ w, ∃ C' : T.Coloring (Fin k), ∃ γ : Fin k, ∀ x, (x = w ∨ T.Adj w x) → C' x ≠ γ) →
      (∀ v i j, φ v i = φ v j) ∧ b = ∑ᶠ v, φ v ⟨0, by omega⟩) := by
  classical
  have hconst1 : ∀ u, (∃ C' : T.Coloring (Fin k), ∃ γ : Fin k,
      ∀ x, (x = ρ u ∨ T.Adj (ρ u) x) → C' x ≠ γ) → ∀ i j, φ u i = φ u j := by
    rintro u ⟨C', γ, hγ⟩ i j
    by_cases hij : i = j
    · rw [hij]
    have hne : C' (ρ u) ≠ γ := hγ _ (Or.inl rfl)
    obtain ⟨π, hπ1, hπ2⟩ := exists_perm_pair hne hij
    let D : G.Coloring (Fin k) :=
      SimpleGraph.Coloring.mk (fun v => π (C' (ρ v))) (fun {v w} h hh =>
        C'.valid (ρ.map_adj h) (π.injective hh))
    have hD : ∀ v, D v = π (C' (ρ v)) := fun v => rfl
    let D' : G.Coloring (Fin k) :=
      SimpleGraph.Coloring.mk (Function.update D u (π γ)) (by
        intro v w h
        by_cases hv : v = u
        · subst hv
          have hw : w ≠ v := h.ne.symm
          rw [Function.update_self, Function.update_of_ne hw, hD]
          intro hh
          exact hγ (ρ w) (Or.inr (ρ.map_adj h)) (π.injective hh).symm
        · by_cases hw : w = u
          · subst hw
            rw [Function.update_self, Function.update_of_ne hv, hD]
            intro hh
            exact hγ (ρ v) (Or.inr (ρ.map_adj h.symm)) (π.injective hh)
          · rw [Function.update_of_ne hv, Function.update_of_ne hw]
            exact D.valid h)
    have hD' : ∀ v, D' v = Function.update D u (π γ) v := fun v => rfl
    have h1 := finsum_update_apply φ hφ D u (π γ)
    have e1 : ∑ᶠ v, φ v (D' v) = ∑ᶠ v, φ v (Function.update D u (π γ) v) := by simp only [hD']
    have := hconst D'
    have := hconst D
    rw [← e1] at h1
    have h2 : φ u (D u) = φ u (π γ) := by linarith
    rw [hD, hπ1, hπ2] at h2
    exact h2
  refine ⟨hconst1, fun hall => ⟨fun v => hconst1 v (by simpa using hall (ρ v)), ?_⟩⟩
  have hc : ∀ v i, φ v i = φ v ⟨0, by omega⟩ := fun v i => hconst1 v (by simpa using hall (ρ v)) _ _
  by_cases hV : Nonempty V
  · obtain ⟨v0⟩ := hV
    obtain ⟨C', γ, -⟩ := hall (ρ v0)
    let D : G.Coloring (Fin k) :=
      SimpleGraph.Coloring.mk (fun v => C' (ρ v)) (fun {v w} h => C'.valid (ρ.map_adj h))
    rw [← hconst D]
    exact finsum_congr fun v => hc v _
  · have : IsEmpty V := not_nonempty_iff.mp hV
    let D : G.Coloring (Fin k) := SimpleGraph.Coloring.mk (fun v => (this.false v).elim) (fun {v} => (this.false v).elim)
    rw [← hconst D]
    simp [finsum_of_isEmpty]

end HadwigerNelson.Arith
