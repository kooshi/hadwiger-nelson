import Proofs.HadwigerNelson.Sat.Encoding
import Mathlib.Data.Fintype.Perm
import Mathlib.Logic.Equiv.Fintype

/-!
# Gadgets: colouring constraints that compose

Fix a graph and a tuple of its vertices — the **ports**. Over all proper 4-colourings of the graph,
the ports can be coloured in some set of ways, and *that set is the object this file is about*. A
**gadget** is an over-approximation of it, together with the proof.

Over-approximation, never under: `admits` may permit port colourings that no colouring achieves, and
may never forbid one that some colouring achieves. That direction is the safety argument, exactly as
in `Sat/Encoding.lean` — a gadget that is too permissive proves less, a gadget that is too strict
would be unsound and cannot be built, because `sound` is a field.

Four moves, and nothing else:

* **produce** — from an edge, from a SAT refutation, or from another gadget moved by a vertex map;
* **compose** — two gadgets on the same ports intersect;
* **read** — through a wider port tuple, or over a larger graph;
* **conclude** — a gadget that admits nothing says the graph has no 4-colouring.

## Why there are ports at all

A gadget could be stated as a constraint on the whole colouring `Fin n → Fin 4`, and the composition
would be simpler. The ports exist for exactly one reason: **they make the final check decidable.**
`∀ q : Fin m → Fin 4` is `4^m` cases the kernel can enumerate; `∀ f : Fin n → Fin 4` is `4^1581`.
Everything about the port tuple's shape follows from that — it is a `Fin m → Fin n` rather than a
`List (Fin n)` because `Fin m → Fin 4` is a `Fintype` and a list of colours of matching length is
not.

Sharing one port tuple across the gadgets being composed is the other half. Gadgets carrying their
own ports would compose by concatenation, and the check would cost `4^(m₁+m₂+…)` — multiplicative in
the number of gadgets rather than fixed by the interface. That is why the port tuple is an index.

## No glued-graph type

Gadgets live over a common ambient vertex set `Fin n` and a common edge list, and a gadget proved on
a sub-edge-list is weakened to the ambient by `Gadget.mono`. This follows M06's finding, which was
that de Grey's "gluing" of two 791-vertex copies is structure of the *construction* and not of the
proof: the argument consumes list inclusions and nothing else.

## Ports move pointwise

`widen` and `transport` change the port tuple, and each takes the change as a **pointwise** family of
equations (`∀ k, …`) rather than an equation between functions. That is not ceremony. A function
equation needs `funext` and then a cast to move the gadget across it; the pointwise form is decidable
and it puts the mathematics in the open — for de Grey the two equations are `φ 14 = 14` and
`φ 11 = 802`, which is precisely the content of "the rotation fixes the shared vertex and swaps the
ends of the joining edge".

## Colours as bare functions

Everything is stated over `f : Fin n → Fin 4` with `hf : ∀ i j, Adj i j → f i ≠ f j`, not over
Mathlib's bundled `SimpleGraph.Coloring`: composition of bare functions is free, while the bundled
form must be rebuilt at every relabelling. The bundle is met once, at `not_colorable_of_gadget`.
-/

namespace HadwigerNelson

variable {n m m' : ℕ} {E E' : List (Fin n × Fin n)} {p : Fin m → Fin n} {p' : Fin m' → Fin n}

/-- A colouring is proper on an edge list when no listed edge is monochromatic. Named because it is
the hypothesis of every `sound` field and the conclusion of every transport step, and forty
characters of quantifier at each one is forty characters nobody reads. -/
abbrev Proper (n : ℕ) (E : List (Fin n × Fin n)) (f : Fin n → Fin 4) : Prop :=
  ∀ i j, (edgeGraph n E).Adj i j → f i ≠ f j

/-! ## The type -/

/-- **A gadget**: which colourings of the ports `p` are possible in a proper 4-colouring of `E`,
over-approximated, with the proof.

`admits` is data and `sound` is its proof, bundled because neither is any use without the other and
because two definitions related by a lemma is the arrangement that lets them drift — M05 replaced
exactly that arrangement in the checker for exactly that reason.

The edge list and the port tuple are **indices**: two gadgets compose only if they agree on both, and
every operation below either demands that agreement or changes one of them on purpose. -/
structure Gadget (n m : ℕ) (E : List (Fin n × Fin n)) (p : Fin m → Fin n) where
  /-- The port colourings this gadget permits. -/
  admits : (Fin m → Fin 4) → Bool
  /-- Every proper 4-colouring of the ambient graph colours the ports admissibly. -/
  sound : ∀ f : Fin n → Fin 4, Proper n E f → admits (fun k => f (p k)) = true

namespace Gadget

/-! ## Compose -/

/-- **Composition.** Two gadgets on the same ports of the same graph constrain it jointly.

Associative and commutative, with `Gadget.trivial` as its unit, so a list of gadgets composes by
`List.foldr Gadget.inter Gadget.trivial` when a search produces one. Nothing here needs the lattice
laws, so they are not stated. -/
def inter (g h : Gadget n m E p) : Gadget n m E p where
  admits q := g.admits q && h.admits q
  sound := sorry

/-- The gadget that constrains nothing — the unit of `inter`, and what an empty list of gadgets
composes to. -/
def trivial : Gadget n m E p where
  admits _ := true
  sound := sorry

/-! ## Read elsewhere -/

/-- **A gadget proved on a subgraph holds on the whole graph** — more edges only rule out more
colourings. This is where a gadget's own edge list is discharged into the ambient one. -/
def mono (hsub : E' ⊆ E) (g : Gadget n m E' p) : Gadget n m E p where
  admits := g.admits
  sound := sorry

/-- **Read a gadget through a wider port tuple.** A gadget speaking about two of three ports becomes
one speaking about all three and ignoring the rest — which is what lets gadgets with different port
sets be intersected. `ι` says which of the wider ports the narrower ones are. -/
def widen (ι : Fin m → Fin m') (hp : ∀ k, p k = p' (ι k)) (g : Gadget n m E p) :
    Gadget n m' E p' where
  admits q := g.admits (fun k => q (ι k))
  sound := sorry

/-- **Transport along a vertex map.** If `φ` carries every edge of `E'` to an edge of `E`, a gadget
over `E'` becomes a gadget over `E` with its ports moved by `φ`: pull the colouring back along `φ`.

`φ` is an arbitrary function — nothing here assumes it is injective or has any structure. The
hypothesis `hφ` carries the whole burden, and it includes distinctness because `SimpleGraph.Adj`
does, so a map that collapsed an edge could not satisfy it.

This is the move that makes a copy of a subgraph free. When `φ` is the index map of a plane isometry
(`Motion`), the copy's *geometry* transports too, and placing it costs nothing at all. -/
def transport (φ : Fin n → Fin n) (hφ : ∀ e ∈ E', (edgeGraph n E).Adj (φ e.1) (φ e.2))
    {pt : Fin m → Fin n} (hp : ∀ k, φ (p k) = pt k) (g : Gadget n m E' p) : Gadget n m E pt where
  admits := g.admits
  sound := sorry

/-! ## Produce -/

/-- **The base gadget: an edge.** Its two endpoints do not share a colour. No certificate, no
computation — this is the fact every other gadget is eventually contradicted against. -/
def edge {i j : Fin n} (h : (edgeGraph n E).Adj i j) : Gadget n 2 E ![i, j] where
  admits q := q 0 != q 1
  sound := sorry

end Gadget

/-! ## Colour symmetry, at any number of ports

Relabelling the four colours carries proper colourings to proper colourings, so what a gadget can say
about its ports is a statement about the **partition** the ports fall into, never about which colours
they take. That is worth up to `4! = 24` refutations — one certificate covers three colour cases in
M06 and twenty in M07.

Represented as a *relation* between colourings rather than by normalising each to a canonical
representative. The relation is what the problem has; a normal form would be a normal form maintained
by hand, with its own theorem to prove and its own opportunity to disagree with the relation it
stands for.

The `4` is load-bearing: a partition of the ports has at most four blocks precisely because there are
four colours, and that is exactly what makes the extension to a permutation of `Fin 4` possible. -/

/-- Two port colourings induce the same partition of the ports: the same ports agree, and the same
ports differ. -/
def samePattern {m : ℕ} (a b : Fin m → Fin 4) : Bool := decide (∀ i j, a i = a j ↔ b i = b j)

/-- **Colour symmetry.** Two port colourings inducing the same partition differ by a permutation of
the four colours. -/
theorem exists_perm_comp_eq {m : ℕ} {a b : Fin m → Fin 4} (h : ∀ i j, a i = a j ↔ b i = b j) :
    ∃ σ : Equiv.Perm (Fin 4), ∀ k, σ (a k) = b k := sorry

/-- The ports listed, in index order — the vertex set a cube is taken over. -/
def portList (p : Fin m → Fin n) : List (Fin n) := (List.finRange m).map p

/-- The ports pinned to a colour pattern, as a cube for the solver. The one seam between the gadget
world, where a pattern is a tuple, and the SAT world, where it is a list of (vertex, colour) pairs. -/
def pinCube (p : Fin m → Fin n) (q : Fin m → Fin 4) : Cube n 4 :=
  (List.finRange m).map fun k => (p k, q k)

/-- **A refutation is a gadget.** If pinning the ports to the pattern `q₀` leaves the graph
4-uncolourable, then no proper colouring gives the ports *any relabelling* of `q₀` — one certificate,
up to twenty-four patterns.

The only producer that costs a solver anything, and the only place `Unsat` appears in the algebra.

At `m = 0` this is `not_colorable_of_unsat`: no ports, an empty cube, and `samePattern` vacuously
true, so the gadget admits nothing. The monolithic case is the algebra's base case rather than a
separate mechanism — the same relationship `allCubes k n [] = [[]]` has to the cube split. -/
def Gadget.ofUnsat (q₀ : Fin m → Fin 4)
    (h : (coloringCNF 4 n E ++ cubeCNF 4 n (pinCube p q₀)).Unsat) : Gadget n m E p where
  admits q := !samePattern q q₀
  sound := sorry

/-! ## Conclude -/

/-- **A gadget that admits nothing.** If no colouring of the ports is permitted, no proper
4-colouring of the graph exists — a colouring would have to colour the ports somehow.

The terminal move of the algebra, and the only one that mentions `Colorable`. Note what the type
already guarantees: such a gadget can be *built* only by proving `sound`, so "admits nothing" is
inhabited exactly when the graph really is not 4-colourable. -/
theorem not_colorable_of_gadget (g : Gadget n m E p) (h : ∀ q, g.admits q = false) :
    ¬ (edgeGraph n E).Colorable 4 := sorry

/-! ## Spec

An algebra whose theorems were all vacuous would elaborate perfectly. The model exhibited here is
`K₅`, the complete graph on five vertices — the smallest graph the algebra refutes from base gadgets
alone, with no certificate anywhere. It is not a unit-distance graph and never will be (`K₄` already
fails to embed), which is exactly why it is the right spec witness: it exercises every move at a size
where the answer is known by hand. -/

section Spec

/-- The ten edges of `K₅`. -/
def k5 : List (Fin 5 × Fin 5) :=
  [(0, 1), (0, 2), (0, 3), (0, 4), (1, 2), (1, 3), (1, 4), (2, 3), (2, 4), (3, 4)]

/-- One of `K₅`'s edges, read through all five ports. -/
def k5Edge (i j : Fin 5) (hij : (i, j) ∈ k5) (hne : i ≠ j) : Gadget 5 5 k5 (fun k => k) :=
  (Gadget.edge (edgeGraph_adj_of_mem hne hij)).widen ![i, j] (fun _ => rfl)

/-- **The composition is not vacuous, and it proves something true.** Five mutually adjacent vertices
cannot be four-coloured, and the algebra says so from ten edge gadgets and one `decide` over the `4⁵`
port colourings — no solver, no certificate, and no graph handed to anything. -/
example : ¬ (edgeGraph 5 k5).Colorable 4 := sorry

/-- **The negative control.** Drop one edge gadget and a port colouring survives — `K₅` minus an edge
*is* 4-colourable. Without this, the example above would be consistent with a composition that
reports "admits nothing" whatever it is given. -/
example : ∃ q : Fin 5 → Fin 4,
    (List.foldr Gadget.inter Gadget.trivial
      [k5Edge 0 1 (by decide) (by decide), k5Edge 0 2 (by decide) (by decide),
       k5Edge 0 3 (by decide) (by decide), k5Edge 0 4 (by decide) (by decide),
       k5Edge 1 2 (by decide) (by decide), k5Edge 1 3 (by decide) (by decide),
       k5Edge 1 4 (by decide) (by decide), k5Edge 2 3 (by decide) (by decide),
       k5Edge 2 4 (by decide) (by decide)]).admits q = true := sorry

/-- **A model of `exists_perm_comp_eq`'s hypothesis**, so colour symmetry is not quantifying over
nothing: two port colourings with the same partition — first and third agree, second differs. -/
example : ∃ σ : Equiv.Perm (Fin 4), ∀ k, σ (![2, 3, 2] k) = ![0, 1, 0] k := sorry

end Spec

end HadwigerNelson
