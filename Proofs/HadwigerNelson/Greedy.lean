import Mathlib.Combinatorics.SimpleGraph.Coloring.Vertex
import Mathlib.Combinatorics.SimpleGraph.Finite

/-!
# Greedy colouring: every degree below `k` makes a graph `k`-colourable

The classical bound `χ(G) ≤ Δ(G) + 1`, in the form the greedy argument actually proves and M18
consumes: a finite graph all of whose degrees are strictly below `k` admits a proper
`k`-colouring. Searched for and not found in Mathlib at this pin (2026-08-03, twice per the
claims-of-absence rule: no greedy, no `Δ + 1`, no degeneracy colouring anywhere under the
`Colorable`/`degree`/`maxDegree` vocabulary, and the full `Colorable` theorem inventory of
`Coloring/Vertex.lean` names nothing degree-shaped) — so this smallest of classical facts is,
apparently, new to the library, and a candidate for upstreaming.

M18 uses it at `k = 3`: a distance class's internal unit-distance graph has maximum degree 2
(`ClassGeometry.lean`), so three colours always suffice for a class by itself — which is why no
class can confine a five-colour fan alone.
-/

namespace SimpleGraph

/-- **Greedy colouring.** A finite graph each of whose vertices has degree strictly less than
`k` is `k`-colourable. -/
theorem colorable_of_degree_lt {V : Type*} [Fintype V] (G : SimpleGraph V)
    [DecidableRel G.Adj] {k : ℕ} (h : ∀ v, G.degree v < k) : G.Colorable k := by
  classical
  cases k with
  | zero =>
    cases isEmpty_or_nonempty V with
    | inl hV => exact Colorable.of_isEmpty 0
    | inr hV => exact absurd (h hV.some) (Nat.not_lt_zero _)
  | succ k =>
    -- the strengthened claim: a total colouring proper on `s`, junk-coloured outside it —
    -- the accumulator that lets the induction remove one vertex at a time
    suffices aux : ∀ s : Finset V, ∃ C : V → Fin (k + 1),
        ∀ v ∈ s, ∀ w ∈ s, G.Adj v w → C v ≠ C w by
      obtain ⟨C, hC⟩ := aux Finset.univ
      exact ⟨SimpleGraph.Coloring.mk C fun {v w} hadj =>
        hC v (Finset.mem_univ v) w (Finset.mem_univ w) hadj⟩
    intro s
    induction s using Finset.strongInduction with
    | _ s ih =>
      rcases Finset.eq_empty_or_nonempty s with rfl | ⟨v, hv⟩
      · exact ⟨fun _ => 0, by simp⟩
      obtain ⟨C, hC⟩ := ih (s.erase v) (Finset.erase_ssubset hv)
      -- the colours v's neighbours already wear inside the smaller set: fewer than k + 1,
      -- so some colour is free for v — the greedy step
      obtain ⟨c, hc⟩ : ∃ c : Fin (k + 1), c ∉ (s.erase v ∩ G.neighborFinset v).image C := by
        by_contra hall
        push Not at hall
        have hcard : ((s.erase v ∩ G.neighborFinset v).image C).card < k + 1 :=
          lt_of_le_of_lt
            (le_trans Finset.card_image_le (Finset.card_le_card Finset.inter_subset_right))
            (h v)
        rw [Finset.eq_univ_iff_forall.mpr hall, Finset.card_univ, Fintype.card_fin] at hcard
        exact lt_irrefl _ hcard
      refine ⟨Function.update C v c, fun x hx y hy hadj => ?_⟩
      have hmem : ∀ {w : V}, w ∈ s → w ≠ v → G.Adj v w →
          C w ∈ (s.erase v ∩ G.neighborFinset v).image C := fun hw hwv hadj =>
        Finset.mem_image_of_mem C (Finset.mem_inter.mpr
          ⟨Finset.mem_erase.mpr ⟨hwv, hw⟩, (G.mem_neighborFinset ..).mpr hadj⟩)
      by_cases hxv : x = v <;> by_cases hyv : y = v
      · subst hxv; subst hyv; exact absurd rfl (G.ne_of_adj hadj)
      · subst hxv
        rw [Function.update_self .., Function.update_of_ne hyv]
        exact fun heq => hc (heq ▸ hmem hy hyv hadj)
      · subst hyv
        rw [Function.update_self .., Function.update_of_ne hxv]
        exact fun heq => hc (heq ▸ hmem hx hxv hadj.symm)
      · rw [Function.update_of_ne hxv, Function.update_of_ne hyv]
        exact hC x (Finset.mem_erase.mpr ⟨hxv, hx⟩) y (Finset.mem_erase.mpr ⟨hyv, hy⟩) hadj

/-! ## Specification

One example per reading of the bound, and the tightness control that keeps the strict `<`
honest. -/

/-- The edgeless graph has every degree below 1, so one colour suffices. -/
example : (⊥ : SimpleGraph (Fin 4)).Colorable 1 :=
  colorable_of_degree_lt _ fun v => by simp

/-- The triangle has every degree below 3, so three colours suffice. -/
example : (⊤ : SimpleGraph (Fin 3)).Colorable 3 :=
  colorable_of_degree_lt _ fun v => by simp [complete_graph_degree]

/-- **The bound is tight**: the triangle refuses two colours, so the strict `<` in
`colorable_of_degree_lt` cannot be weakened to `≤`. Three pairwise-distinct values cannot
fit in `Fin 2`. -/
example : ¬ (⊤ : SimpleGraph (Fin 3)).Colorable 2 := by
  rintro ⟨C⟩
  have h3 : 2 < ({C 0, C 1, C 2} : Finset (Fin 2)).card :=
    Finset.two_lt_card_iff.mpr ⟨C 0, C 1, C 2, by simp, by simp, by simp,
      C.valid (by decide), C.valid (by decide), C.valid (by decide)⟩
  have hle := Finset.card_le_univ ({C 0, C 1, C 2} : Finset (Fin 2))
  simp only [Fintype.card_fin] at hle
  omega

-- The misuse control, pinned: handing the theorem a false degree bound is caught by name at
-- the hypothesis, never silently accepted.
/--
error: Tactic `decide` proved that the proposition
  ∀ (v : Fin 3), ⊤.degree v < 2
is false
-/
#guard_msgs in
example : (⊤ : SimpleGraph (Fin 3)).Colorable 2 :=
  colorable_of_degree_lt _ (by decide)

end SimpleGraph
