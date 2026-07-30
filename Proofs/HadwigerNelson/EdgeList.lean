import Proofs.HadwigerNelson.UnitDistance

/-!
# Graphs presented by an edge list

The presentation every certificate uses. A finite graph arrives from an untrusted generator as a
vertex count and a list of index pairs; `edgeGraph` is how that list becomes a `SimpleGraph`, and
`edgeGraph_adj` is the bridge both consumers cross.

## Why this shape

Trace what the two consumers need and the definition is forced. M03's CNF encoder needs
`listed edge → Adj`, to turn a colouring into a satisfying assignment; M04's geometry needs
`Adj → listed edge`, to build the homomorphism. Both directions, so the graph must be *exactly*
the graph of the list.

Symmetry and looplessness are structural rather than hypotheses on `E`: the `i ≠ j` conjunct
strips loops and the disjunction symmetrises, so `edgeGraph` is total on *any* list and no
well-formedness check, smart constructor, or `Subtype` is needed. A malformed list simply denotes
a graph without those loops.

**The consequence M03 must honour**: because loops are stripped here, the CNF encoder must strip
them too. A self-loop left in the clause set makes the CNF trivially unsatisfiable while leaving
the graph colourable, which would make `Colorable k G → Sat cnf` *false*. Both objects derive from
`E` under the same convention, and then the correspondence is unconditional.

`Fin n` rather than `ℕ` indices because it buys discharged totality on the vertex lookup — `verts[i]`
with `i : Fin n` needs no `!` and no bounds side condition on the certificate path.
-/

namespace HadwigerNelson

open SimpleGraph

variable {n : ℕ}

/-- The graph on `Fin n` whose edges are exactly the listed pairs, symmetrised, with loops
stripped. Reason about it through `edgeGraph_adj` and `edgeGraph_adj_of_mem`, never by unfolding. -/
def edgeGraph (n : ℕ) (E : List (Fin n × Fin n)) : SimpleGraph (Fin n) where
  Adj i j := i ≠ j ∧ ((i, j) ∈ E ∨ (j, i) ∈ E)
  symm := ⟨fun _ _ h => ⟨h.1.symm, h.2.symm⟩⟩
  loopless := ⟨fun _ h => h.1 rfl⟩

/-- Adjacency in `edgeGraph` unfolded — the reasoning surface. `@[simp]` toward the same
destination as `unitDistance_adj`: goals leave graph vocabulary for list membership, where
`decide` and `List` lemmas close them. -/
@[simp]
theorem edgeGraph_adj {E : List (Fin n × Fin n)} {i j : Fin n} :
    (edgeGraph n E).Adj i j ↔ i ≠ j ∧ ((i, j) ∈ E ∨ (j, i) ∈ E) := Iff.rfl

/-- A listed non-loop pair is an edge — the direction M03's CNF soundness proof consumes, packaged
so that proof never has to reconstruct the `Or`. -/
theorem edgeGraph_adj_of_mem {E : List (Fin n × Fin n)} {i j : Fin n}
    (hne : i ≠ j) (hmem : (i, j) ∈ E) : (edgeGraph n E).Adj i j := ⟨hne, Or.inl hmem⟩

/-- **A graph presented by a longer list contains one presented by a shorter.** The direction M06
consumes: a proper colouring of the whole graph restricts to a proper colouring of each half, and
the halves are literal segments of `deGrey.edges`, so the inclusion is `List.subset_append_left`
with no kernel computation in it — where deciding a 3,938-against-7,877 inclusion would be
3.1 × 10⁷ pair comparisons. -/
theorem edgeGraph_adj_mono {E₁ E₂ : List (Fin n × Fin n)} (h : E₁ ⊆ E₂) {i j : Fin n}
    (hij : (edgeGraph n E₁).Adj i j) : (edgeGraph n E₂).Adj i j :=
  ⟨hij.1, hij.2.imp (fun m => h m) (fun m => h m)⟩

/-- **The reduction, in the certificate's own vocabulary.** The hypothesis `hp` is exactly what
M04's exact-arithmetic edge check produces: one unit-distance fact per listed pair, with no
`Adj` in sight. This is the call site for the whole project's headline. -/
theorem add_one_le_chromaticNumber_unitDistance_edgeList {V : Type*} [MetricSpace V] {k : ℕ}
    (E : List (Fin n × Fin n)) (p : Fin n → V)
    (hp : ∀ e ∈ E, dist (p e.1) (p e.2) = 1)
    (hG : ¬ (edgeGraph n E).Colorable k) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance V).chromaticNumber := by
  refine add_one_le_chromaticNumber_unitDistance p ?_ hG
  -- Every edge of `edgeGraph` is a listed pair (up to direction); feed each to `hp`.
  rintro i j ⟨-, hij | hji⟩
  · exact hp (i, j) hij
  · rw [dist_comm]; exact hp (j, i) hji

end HadwigerNelson
