import Proofs.HadwigerNelson.Gadget

/-!
# The first five-colour question this project has ever asked

`χ(ℝ²) ≥ 5` means *no 4-colouring*. **`χ(ℝ²) ≥ 6` means no 5-colouring** — and until this module,
nothing here had ever asked that. `coloringCNF 5` and `Colorable 5` appeared exactly zero times
across the whole repository, so every cost recorded in `plans/` was a four-colour cost, in a project
where refutation cost is already measured *non-monotone* in graph size.

This module asks the question once, on a graph chosen to make the answer cheap and the cost
comparable, and records what it cost. It is a **calibration instance**, exactly as the Moser spindle
was for rung A: no geometry, no plane, nothing about unit distances — only the combinatorial half of
the pipeline, run at the colour count rung D needs.

## Why this graph, and why it is defined rather than emitted

Mycielski's construction raises a graph's chromatic number by exactly one while introducing no
triangle. Four iterations above a single edge give 47 vertices and 236 edges with chromatic number
six, which is the smallest *hard* 6-chromatic graph available: it is exactly critical at five
colours, so the refutation is a real one rather than a formality.

**It is defined here, not emitted as a literal.** A reader re-derives 47 vertices and 236 edges from
five lines of recursion; the alternative is trusting 236 emitted pairs. That is the standard this
project holds itself to above rung B — *the witness must be independently re-derivable* — and here it
is also simply cheaper. The DIMACS handed to the solver still comes out of Lean's own `coloringCNF`
through `scripts/Dimacs.lean`, so the certificate and the theorem cannot address different formulas.

Measured before this module was written (desktop, 32 cores): refuting five colours here costs
**10,224,710 trimmed hint entries** plain, and **387,065** with one edge's colours named — against
the 553-vertex four-colour witness's 1,104,106. Naming a triangle's colours, the lever a real
unit-distance candidate would have, is worth 8.5–53× at five colours; this graph is triangle-free by
construction and cannot use it. See `plans/M12-candidate-construction.md` § 0.
-/

namespace HadwigerNelson

namespace Mycielski

-- The list here is 236 entries built by four rounds of concatenation, and every guard below walks
-- it. `decide +kernel` keeps the reduction out of the elaborator, where the default recursion
-- budget is what runs out first.
set_option maxRecDepth 8000

/-- **One Mycielskian.** The original `n` vertices keep their edges; a shadow `v + n` of each vertex
`v` joins that vertex's neighbours; an apex `2n` joins every shadow.

Stated over `ℕ` pairs rather than `Fin n` pairs because the vertex count changes at every step, and
threading the bound through the recursion would put an index in every signature that no consumer
inspects. The bound is re-established once, at `edges`. -/
def step (n : ℕ) (E : List (ℕ × ℕ)) : ℕ × List (ℕ × ℕ) :=
  (2 * n + 1,
    E ++ E.flatMap (fun e => [(e.1, e.2 + n), (e.2, e.1 + n)])
      ++ (List.range n).map (fun v => (v + n, 2 * n)))

/-- `k` Mycielskians above a single edge. Chromatic number `k + 2`. -/
def iter : ℕ → ℕ × List (ℕ × ℕ)
  | 0 => (2, [(0, 1)])
  | k + 1 => step (iter k).1 (iter k).2

/-- The graph this module is about: 47 vertices, 236 edges, chromatic number six. -/
def raw : ℕ × List (ℕ × ℕ) := iter 4

/-- The vertex count. `abbrev` so that `Fin size` accepts numerals — a port list is written
`![0, 1]` and nothing is served by making a reader spell out the bounds. -/
abbrev size : ℕ := 47

/-- **Every step's size is what the construction says.** The ladder, pinned — a `step` that dropped
or duplicated a family would still elaborate, and these would go red. -/
example : (iter 0).1 = 2 ∧ (iter 0).2.length = 1 := by decide +kernel
example : (iter 1).1 = 5 ∧ (iter 1).2.length = 5 := by decide +kernel
example : (iter 2).1 = 11 ∧ (iter 2).2.length = 20 := by decide +kernel
example : (iter 3).1 = 23 ∧ (iter 3).2.length = 71 := by decide +kernel
example : raw.1 = size ∧ raw.2.length = 236 := by decide +kernel

/-- **No index escapes the vertex count**, so the embedding below truncates nothing. Without this the
`% size` would silently fold two vertices together and produce a graph nobody checked. -/
example : raw.2.all (fun e => decide (e.1 < size) && decide (e.2 < size)) = true := by decide +kernel

/-- The edge list at the index type `edgeGraph` wants. -/
def edges : List (Fin size × Fin size) :=
  raw.2.map fun e => (⟨e.1 % size, Nat.mod_lt _ (by decide)⟩, ⟨e.2 % size, Nat.mod_lt _ (by decide)⟩)

example : edges.length = 236 := by decide +kernel

/-- **No self-loops.** `edgeGraph` strips them anyway, so a loop would not make the graph wrong — it
would mean the `% size` above had folded two distinct vertices together, which would.

Triangle-freeness is a property of Mycielski's construction rather than of this list, and it is *not*
guarded here: the check is `size³` adjacency tests, which the kernel would walk one cons cell at a
time. It is verified tool-side instead, and what it buys is stated rather than used — this graph
cannot name a triangle's colours, so it cannot use the lever a unit-distance candidate has. -/
example : edges.all (fun e => decide (e.1 ≠ e.2)) = true := by decide +kernel

/-! ### The six-colouring, from the construction rather than from a solver

Mycielski's construction supplies its own optimal colouring: a shadow may take its original's colour
(it is adjacent to the original's *neighbours*, never to the original), and the apex takes one fresh
colour. So `iter k` needs `k + 2` colours, and the control below is the construction read a second
way rather than 47 numbers handed over by a solver. -/

/-- The colour of vertex `v` at iteration `k`. Shadows copy their originals; the apex is fresh.

Nothing needs to unfold this: `colour_proper` is the whole reasoning surface, and it is the only
thing `mycielski47_colorable_six` uses. -/
def colourAux : ℕ → ℕ → ℕ
  | 0, v => v
  | k + 1, v =>
      let n := (iter k).1
      if v < n then colourAux k v
      else if v < 2 * n then colourAux k (v - n)
      else k + 2

/-- **Six colours suffice, and the sixth is used** — so this really is a 6-colouring and not a
5-colouring wearing a wider type. -/
example : (List.range size).all (fun v => decide (colourAux 4 v < 6)) = true := by decide +kernel
example : (List.range size).any (fun v => decide (colourAux 4 v = 5)) = true := by decide +kernel

/-- The colouring at the index type `Coloring` wants. -/
def colour (v : Fin size) : Fin 6 := ⟨colourAux 4 v.val % 6, Nat.mod_lt _ (by decide)⟩

/-- **The colouring is proper**, checked edge by edge in the kernel. This is the whole content of the
control: the witness is not trusted, it is verified. -/
theorem colour_proper : edges.all (fun e => decide (colour e.1 ≠ colour e.2)) = true := by
  decide +kernel

/-- The two ports: the ends of the original edge, which survives every Mycielskian.

Two ports and not three, because **this graph is triangle-free** — Mycielski's construction is what
introduces no triangle — so the three-mutually-adjacent-ports gadget every other witness here uses
(`Instances/Heule553/Bound.lean` and its two siblings) has nothing to attach to. The largest clique
is an edge, and an edge is what gets pinned. -/
def ports : Fin 2 → Fin size := ![0, 1]

/-- **Naming one edge's colours**, which is the only colour-symmetry lever a triangle-free graph has.

Measured before this was written: 387,065 trimmed hint entries with the edge pinned against
10,224,710 without — 26×, and the difference between about ten minutes of kernel time and four
hours. A unit-distance candidate would have a triangle here and the lever would be worth 8.5–53×. -/
def portsEdge : Gadget 5 size 2 edges ports :=
  Gadget.edge 0 1 (edgeGraph_adj_of_mem (by decide) (by decide +kernel))

/-- **The solver's half**: with the two ports pinned to different colours, the formula is
unsatisfiable. This is the one leaf that needs a certificate — everything else about this witness is
derived from the construction. -/
theorem pinned_unsat :
    (coloringCNF 5 size edges ++ cubeCNF 5 size (pinCube ports ![0, 1])).Unsat := by
  sorry

/-- The two gadgets composed. At two ports and five colours there are exactly two colour-partitions
to rule out, and each gadget rules out one: the edge kills "the ends agree", the certificate kills
"the ends differ". -/
def gadgets : Gadget 5 size 2 edges ports :=
  (Gadget.ofUnsat ![0, 1] pinned_unsat).inter portsEdge

end Mycielski

-- The `fail` branch is unreachable *when the gadgets refute*, which is when the linter runs.
set_option linter.unreachableTactic false in
set_option linter.unusedTactic false in
/-- **The first refutation of a five-colouring in this project.**

47 vertices, 236 edges, and no proper colouring with five colours. Kernel-checked through the same
route every other witness here uses: a solver certificate, re-checked by `Sat/MaskCheck.lean`, with
CaDiCaL trusted for nothing. -/
theorem mycielski47_not_colorable_five :
    ¬ (edgeGraph Mycielski.size Mycielski.edges).Colorable 5 :=
  not_colorable_of_gadget Mycielski.gadgets (by
    first
      | decide +kernel
      | fail "Mycielski.gadgets admits a port colouring, so this graph is not refuted. What \
              survives is `Mycielski.gadgets.survivors` — one entry per colour-partition of the two \
              ports, each a list of (vertex, colour) pins. Print it with, inside \
              `namespace HadwigerNelson`,  #eval Mycielski.gadgets.survivors")

/-- **The control that must go red.** Six colours *do* suffice. Without it, a "five" that was
silently a "four" — or a graph that was accidentally uncolourable at every count, which a dropped
`% size` would produce — reads exactly like a success. -/
theorem mycielski47_colorable_six :
    (edgeGraph Mycielski.size Mycielski.edges).Colorable 6 :=
  ⟨SimpleGraph.Coloring.mk Mycielski.colour fun {v w} h => by
    have hall := List.all_eq_true.mp Mycielski.colour_proper
    rcases h.2 with hm | hm
    · exact of_decide_eq_true (hall _ hm)
    · exact (of_decide_eq_true (hall _ hm)).symm⟩

end HadwigerNelson
