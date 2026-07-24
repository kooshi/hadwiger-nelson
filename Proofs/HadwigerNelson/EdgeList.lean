import Proofs.HadwigerNelson.UnitDistance

/-!
# Graphs presented by an edge list

The presentation every certificate uses. A finite graph arrives from an untrusted generator as a
vertex count and a list of index pairs; `edgeGraph` is how that list becomes a `SimpleGraph`, and
`edgeGraph_adj_iff` is the bridge both consumers cross.

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

namespace Proofs.HadwigerNelson

open SimpleGraph

variable {n : ℕ}

/-- The graph on `Fin n` whose edges are exactly the listed pairs, symmetrised, with loops
stripped. -/
def edgeGraph (n : ℕ) (E : List (Fin n × Fin n)) : SimpleGraph (Fin n) where
  Adj i j := i ≠ j ∧ ((i, j) ∈ E ∨ (j, i) ∈ E)
  symm := ⟨fun _ _ h => ⟨h.1.symm, h.2.symm⟩⟩
  loopless := ⟨fun _ h => h.1 rfl⟩

/-- Adjacency in `edgeGraph` unfolded. True by `rfl`; stated so no downstream proof unfolds
`Adj`. -/
@[simp]
theorem edgeGraph_adj_iff {E : List (Fin n × Fin n)} {i j : Fin n} :
    (edgeGraph n E).Adj i j ↔ i ≠ j ∧ ((i, j) ∈ E ∨ (j, i) ∈ E) := Iff.rfl

/-- A listed non-loop pair is an edge — the direction M03's CNF soundness proof consumes. -/
theorem edgeGraph_adj_of_mem {E : List (Fin n × Fin n)} {i j : Fin n}
    (hne : i ≠ j) (hmem : (i, j) ∈ E) : (edgeGraph n E).Adj i j := ⟨hne, Or.inl hmem⟩

/-- **The reduction, in the certificate's own vocabulary.** The hypothesis `hp` is exactly what
M04's exact-arithmetic edge check produces: one unit-distance fact per listed pair, with no
`Adj` in sight. -/
theorem lt_chromaticNumber_unitDistance_edgeList {V : Type*} [MetricSpace V] {k : ℕ}
    (E : List (Fin n × Fin n)) (p : Fin n → V)
    (hp : ∀ e ∈ E, dist (p e.1) (p e.2) = 1)
    (hG : ¬ (edgeGraph n E).Colorable k) :
    (k : ℕ∞) < (unitDistance V).chromaticNumber := by
  sorry

end Proofs.HadwigerNelson
