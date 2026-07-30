import Proofs.HadwigerNelson.Instances.DeGrey.HalfA.Cert
import Proofs.HadwigerNelson.Instances.DeGrey.HalfB.Cert

/-!
# Each half forces its end of the joining edge

The two lemmas de Grey's argument turns on, and the only place colour symmetry is used.

## What the certificates say, and what these lemmas say

A certificate refutes **one** pinned instance: the shared vertex at colour 0, the joining edge's
endpoint at colour 1. The lemma below says something stronger and colour-blind — *whatever* colour
the shared vertex has, the endpoint has the same one — and the gap between them is exactly two
relabellings of the four colours:

* one permutation carries the shared vertex's colour to 0;
* one swap carries the endpoint's colour to 1, and fixes 0 because the two differ.

Composing a proper colouring with an injection is a proper colouring, so both moves are free. That
is worth a factor of two on the whole milestone: three colour cases per half, one certificate
(`plans/M06-chi-ge-five.md` § 2.5).

## The half that is *not* refuted, and why it is the important one

Pinning the endpoint to the shared vertex's own colour is **satisfiable** — measured, and stated here
because it is the reason these lemmas are equalities rather than something stronger. A checker that
"refuted" that case too would be refuting a colouring that exists.
-/

namespace HadwigerNelson

variable {n : ℕ}

/-- **The colour-relabelling step, once, for both halves.** Given a proper colouring of a graph and
two vertices with different colours, there is a proper colouring of the same graph sending the first
to colour 0 and the second to colour 1.

Split out because it is the entire content of the symmetry argument, and because stating it once
makes the two forcing lemmas a change of argument rather than a second copy of the proof. -/
theorem exists_normalized {G : SimpleGraph (Fin n)} {f : Fin n → Fin 4} (u v : Fin n)
    (hf : ∀ i j, G.Adj i j → f i ≠ f j) (hne : f v ≠ f u) :
    ∃ g : Fin n → Fin 4, (∀ i j, G.Adj i j → g i ≠ g j) ∧ g u = 0 ∧ g v = 1 := by
  obtain ⟨σ, hσ⟩ := exists_perm_apply_eq (f u) (0 : Fin 4)
  have hg : ∀ i j, G.Adj i j → σ (f i) ≠ σ (f j) := valid_comp_of_injective hf σ.injective
  have hgne : σ (f v) ≠ (0 : Fin 4) := fun h => hne (σ.injective (h.trans hσ.symm))
  -- A swap that moves the endpoint's colour to 1 and leaves 0 alone, because neither side is 0.
  refine ⟨fun i => Equiv.swap (σ (f v)) 1 (σ (f i)),
          valid_comp_of_injective hg (Equiv.swap _ _).injective, ?_, ?_⟩
  · show Equiv.swap (σ (f v)) 1 (σ (f u)) = 0
    rw [hσ]
    exact Equiv.swap_apply_of_ne_of_ne (Ne.symm hgne) (by decide)
  · exact Equiv.swap_apply_left _ _

/-- **The forcing step, once, for both halves.** Any proper colouring of a graph in which the pinned
instance `[(u, 0), (v, 1)]` is unsatisfiable gives `u` and `v` the same colour. -/
theorem eq_of_pinned_unsat {E : List (Fin n × Fin n)} (u v : Fin n) {f : Fin n → Fin 4}
    (hf : ∀ i j, (edgeGraph n E).Adj i j → f i ≠ f j)
    (h : (coloringCNF 4 n E ++ cubeCNF 4 n [(u, 0), (v, 1)]).Unsat) : f v = f u := by
  by_contra hne
  obtain ⟨g, hg, hu, hv⟩ := exists_normalized u v hf hne
  refine not_pinned [u, v] g hg ?_
  have : cubeOf [u, v] g = [(u, 0), (v, 1)] := by simp [cubeOf, hu, hv]
  rw [this]
  exact h

/-- **Half A forces vertex 11.** In every proper 4-colouring of the first copy, vertex 11 takes
vertex 14's colour. -/
theorem halfA_forces {f : Fin 1581 → Fin 4}
    (hf : ∀ i j, (edgeGraph 1581 deGreyHalfAEdges).Adj i j → f i ≠ f j) : f 11 = f 14 :=
  eq_of_pinned_unsat 14 11 hf halfA_unsat

/-- **Half B forces vertex 802.** In every proper 4-colouring of the second copy, vertex 802 takes
vertex 14's colour. -/
theorem halfB_forces {f : Fin 1581 → Fin 4}
    (hf : ∀ i j, (edgeGraph 1581 deGreyHalfBEdges).Adj i j → f i ≠ f j) : f 802 = f 14 :=
  eq_of_pinned_unsat 14 802 hf halfB_unsat

end HadwigerNelson
