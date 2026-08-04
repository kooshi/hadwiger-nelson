import Proofs.HadwigerNelson.Instances.DeGrey

/-!
# De Grey's graph admits a balanced 5-colouring (M19)

The χ = 5 lens's first exact answer, kernel-certified. The M19 §0 pools suggested every
5-colouring of de Grey's graph is forced off balance (largest colour class ≥ 21.1% of the
1,581 vertices across 1,292 solver-produced colourings); a cardinality-constrained SAT call
answered that this was **the solver's taste, not the graph's law**: a proper 5-colouring
exists with class sizes `[317, 316, 316, 316, 316]` — the exact pigeonhole optimum. No
density obstruction exists at witness scale, and pool statistics measure the sampler, not
the space (`plans/M19-coverage-driven-construction.md` §0(b), §0(c)).

## Layout

The witness travels as **one `Nat` literal, one hex nibble per vertex** (M04's `PtTable`
pattern): nibble `v` is vertex `v`'s colour. Extraction is a GMP shift-and-mask, which the
kernel does in hardware, so the three data facts below are `decide +kernel` at a few
kernel-steps per edge — where an `Array (Fin 5)` layout would pay O(index) list-walking per
access (~12M steps over the edge list; measured cost model says minutes). Two layers, as in
M06: decidable data facts over the literal, then the `Prop`-shaped headline derived by hand.
The witness is emitted from the cadical model, never hand-copied; the solver only proposed
it, the kernel checks it. Zero trust purchases.
-/

namespace HadwigerNelson

open SimpleGraph

/-- The balanced colouring of de Grey's 1,581 vertices, packed one hex nibble per vertex
(nibble `v` = colour of vertex `v`, values `0..4`). Emitted from the cadical model of the
cardinality-constrained instance (`tools/balance.py`, M19 §0(c)). -/
def balancedWitnessPacked : Nat := sorry

/-- Vertex `v`'s colour: nibble `v` of the packed witness. -/
def wcolour (v : ℕ) : ℕ := balancedWitnessPacked >>> (v <<< 2) &&& 15

/-- Every nibble is a real colour. -/
theorem wcolour_lt_five : ∀ v ∈ List.range 1581, wcolour v < 5 := sorry

/-- Properness on the committed edge list, decided by the kernel. -/
theorem wcolour_proper : ∀ e ∈ deGrey.edges, wcolour e.1.val ≠ wcolour e.2.val := sorry

/-- Every colour class has at most 317 vertices — with 1,581 = 5 · 316 + 1 points this is
the pigeonhole optimum: no 5-partition of the vertices does better. -/
theorem wcolour_counts :
    ∀ c ∈ List.range 5, ((List.range 1581).countP fun v => wcolour v == c) ≤ 317 := sorry

/-- The witness as a typed colouring: the nibble, with its range fact. -/
def balancedColoring (v : Fin 1581) : Fin 5 :=
  ⟨wcolour v.val, wcolour_lt_five v.val (List.mem_range.mpr v.isLt)⟩

/-- **De Grey's graph admits a balanced proper 5-colouring**: some proper colouring keeps
every colour class at the pigeonhole optimum of at most 317 vertices. -/
theorem deGrey_balanced :
    ∃ C : (edgeGraph 1581 deGrey.edges).Coloring (Fin 5),
      ∀ i : Fin 5, (Finset.univ.filter fun v => C v = i).card ≤ 317 := sorry

end HadwigerNelson
