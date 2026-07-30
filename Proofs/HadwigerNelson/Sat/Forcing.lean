import Proofs.HadwigerNelson.Sat.Encoding

/-!
# Forcing: two subgraphs that pin a colour, and an edge that forbids it

de Grey's argument, as a theorem about an arbitrary graph rather than about his. The graph plays no
part beyond three list inclusions, which is the whole finding of this module: what looked like a
*gluing* — two 791-vertex copies of one point set, sharing exactly one vertex — turns out to be
structure of the **construction**, not of the proof. The proof consumes only

* every edge of the first subgraph is an edge of the graph,
* every edge of the second subgraph is an edge of the graph,
* and one further edge joining a vertex of the first to a vertex of the second.

So there is no "glued graph" type here, and building one would index data no consumer inspects. The
vertex-sharing count, the copy structure, the 3938 + 3938 + 1 arithmetic — all of it is *spec*, pinned
by `#guard` in `Instances/DeGrey/Split.lean`, and none of it is a hypothesis.

## The shape of the argument

Suppose a graph has a proper 4-colouring. If one subgraph forces vertex `a` to take vertex `u`'s
colour, and another forces `b` to take `u`'s colour, and `a`–`b` is an edge, there is no such
colouring. Each forcing fact is bought with **one** refutation, because relabelling the colours
covers the other cases.

## Colours as bare functions, not bundled colourings

Everything here is stated over `f : Fin n → Fin 4` with `hf : ∀ i j, Adj i j → f i ≠ f j`, not over
Mathlib's `SimpleGraph.Coloring`. That is deliberate and it is about the relabelling step:
composition of bare functions is free, while the bundled form must be rebuilt at each step.
Mathlib's bundled equivalent is `SimpleGraph.recolorOfEmbedding` (and `recolorOfEquiv`), whose
coercion goes through `RelHom.comp` — more unfolding at each of the three uses below than the
one-line composition lemma is worth. The bundle is met once, at the top, where `rintro ⟨C⟩` produces
`⇑C` and `C.valid`.
-/

namespace HadwigerNelson

variable {n : ℕ}

/-- **The colour-relabelling step.** Given a proper 4-colouring and two vertices with different
colours, there is a proper 4-colouring of the same graph sending the first to colour 0 and the second
to colour 1.

This is the entire content of the symmetry argument, and it is what makes one refutation cover three
colour cases — a factor of two on the whole milestone. Two relabellings: a permutation carrying the
first vertex's colour to 0, then a swap carrying the second's to 1, which fixes 0 because the two
differ. -/
theorem exists_normalized {G : SimpleGraph (Fin n)} {f : Fin n → Fin 4} (u v : Fin n)
    (hf : ∀ i j, G.Adj i j → f i ≠ f j) (hne : f v ≠ f u) :
    ∃ g : Fin n → Fin 4, (∀ i j, G.Adj i j → g i ≠ g j) ∧ g u = 0 ∧ g v = 1 := by
  obtain ⟨σ, hσ⟩ := exists_perm_apply_eq (f u) (0 : Fin 4)
  have hg : ∀ i j, G.Adj i j → σ (f i) ≠ σ (f j) := valid_comp_of_injective hf σ.injective
  have hgne : σ (f v) ≠ (0 : Fin 4) := fun h => hne (σ.injective (h.trans hσ.symm))
  refine ⟨fun i => Equiv.swap (σ (f v)) 1 (σ (f i)),
          valid_comp_of_injective hg (Equiv.swap _ _).injective, ?_, ?_⟩
  · show Equiv.swap (σ (f v)) 1 (σ (f u)) = 0
    rw [hσ]
    exact Equiv.swap_apply_of_ne_of_ne (Ne.symm hgne) (by decide)
  · exact Equiv.swap_apply_left _ _

/-- **One refutation forces one equality.** If pinning `u` to colour 0 and `v` to colour 1 leaves the
graph 4-uncolourable, then every proper 4-colouring gives `u` and `v` the same colour.

The cube `[(u, 0), (v, 1)]` is supplied as a literal, which M03's `Cube` type permits to be
degenerate — repeated vertices, conflicting colours. **M03's reason why that is safe no longer
applies** (it was that cubes only ever arrive from `allCubes`), so here is the reason that does: at
`u = v` the pinned formula is trivially unsatisfiable *and* the conclusion `f u = f u` is trivially
true, so the degenerate case proves nothing and claims nothing. A wrong-but-non-degenerate cube is
caught earlier, by `agreesWithCNF`. -/
theorem eq_of_pinned_unsat {E : List (Fin n × Fin n)} (u v : Fin n) {f : Fin n → Fin 4}
    (hf : ∀ i j, (edgeGraph n E).Adj i j → f i ≠ f j)
    (h : (coloringCNF 4 n E ++ cubeCNF 4 n [(u, 0), (v, 1)]).Unsat) : f v = f u := by
  by_contra hne
  obtain ⟨g, hg, hu, hv⟩ := exists_normalized u v hf hne
  refine not_pinned [u, v] g hg ?_
  have hcube : cubeOf [u, v] g = [(u, 0), (v, 1)] := by simp [cubeOf, hu, hv]
  rw [hcube]
  exact h

/-- **de Grey's argument, over any graph.** Two subgraphs, each forcing its own vertex to take a
shared vertex's colour, and an edge between those two vertices: no 4-colouring.

Stated at four colours because that is what `exists_normalized`'s `0 ≠ 1` needs and what every rung of
this project's ratchet below six colours asks for; generalising to `k` would add a `1 < k` hypothesis
for no present use.

The four colour cases per subgraph are covered by one refutation each, and the graph itself enters
only through the three inclusions. -/
theorem not_colorable_of_forcing {E EA EB : List (Fin n × Fin n)} {u a b : Fin n}
    (hA : EA ⊆ E) (hB : EB ⊆ E) (hcross : (a, b) ∈ E) (hab : a ≠ b)
    (hforceA : (coloringCNF 4 n EA ++ cubeCNF 4 n [(u, 0), (a, 1)]).Unsat)
    (hforceB : (coloringCNF 4 n EB ++ cubeCNF 4 n [(u, 0), (b, 1)]).Unsat) :
    ¬ (edgeGraph n E).Colorable 4 := by
  rintro ⟨C⟩
  have hC : ∀ i j, (edgeGraph n E).Adj i j → C i ≠ C j := fun _ _ h => C.valid h
  -- A colouring of the whole graph is a colouring of each subgraph.
  have ha : C a = C u :=
    eq_of_pinned_unsat u a (fun i j h => hC i j (edgeGraph_adj_mono hA h)) hforceA
  have hb : C b = C u :=
    eq_of_pinned_unsat u b (fun i j h => hC i j (edgeGraph_adj_mono hB h)) hforceB
  exact hC a b (edgeGraph_adj_of_mem hab hcross) (ha.trans hb.symm)

/-! ## Spec

The hypotheses are not vacuous, and the theorem is not vacuous either — both need exhibiting, because
a `∀` over an empty domain proves everything.

The witness is the **triangle**: three mutually adjacent vertices, where forcing is trivial. Pin
vertex 0 to colour 0 and vertex 1 to colour 1 in the subgraph `[(0,1)]` — that is *satisfiable*, so
the triangle is the wrong shape for `not_colorable_of_forcing` and gives an honest negative control
instead. What a model of the hypotheses looks like at small size is a graph where a subgraph really
does force, and the smallest such thing is exactly what M06's certificates provide; below that scale
no example exists, which is itself worth stating. -/

section Spec

-- **A model of `exists_normalized`'s hypotheses**, so the relabelling lemma is not vacuous: the
-- 3-cycle, properly 4-coloured, with two differently-coloured vertices.
example : ∃ g : Fin 3 → Fin 4,
    (∀ i j, (edgeGraph 3 [(0, 1), (1, 2), (0, 2)]).Adj i j → g i ≠ g j) ∧ g 0 = 0 ∧ g 1 = 1 :=
  exists_normalized (f := fun i => i.castLE (by norm_num)) 0 1
    (fun i j h => by
      simp only [edgeGraph_adj] at h
      exact fun hg => h.1 (Fin.castLE_injective (by norm_num) hg))
    (by decide)

-- **The negative control on the forcing hypothesis.** `not_colorable_of_forcing` would be worthless
-- if the pinned formula were unsatisfiable for trivial reasons, so here is a pinned formula that is
-- *satisfiable*: one edge, its endpoints given different colours. A certificate for this cannot
-- exist, which is what makes the hypothesis in the theorem above a real obligation.
example : ∃ a, Std.Sat.CNF.Sat a
    (coloringCNF 4 2 [(0, 1)] ++ cubeCNF 4 2 (cubeOf [0, 1] (fun i => i.castLE (by norm_num)))) :=
  exists_sat_coloringCNF_cube [0, 1]
    (SimpleGraph.Coloring.mk (fun i : Fin 2 => i.castLE (by norm_num)) (by
      intro i j h
      simp only [edgeGraph_adj] at h
      exact fun hg => h.1 (Fin.castLE_injective (by norm_num) hg)))

end Spec

end HadwigerNelson
