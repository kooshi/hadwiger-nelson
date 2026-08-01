import Proofs.HadwigerNelson.Sat.Encoding
import Mathlib.Data.Fintype.Perm
import Mathlib.Logic.Equiv.Fintype

/-!
# Gadgets: colouring constraints that compose

A **gadget** is a proven constraint on how a proper 4-colouring may colour a designated tuple of
vertices — its *ports*. That is the whole idea, and everything here is one of four moves on it:

* **produce** a gadget — from an edge, from a SAT refutation, or from another gadget moved by a
  vertex map;
* **compose** two gadgets on the same ports — their constraints intersect;
* **read** a gadget through a wider port tuple, or over a larger graph;
* **conclude** — a gadget that admits nothing says the graph has no 4-colouring.

The point of the abstraction is that a search runs over *constraints* rather than over vertices. A
composite graph never has to be handed to a solver: the pieces are certified once and the composition
is a `decide` over the port colourings, of which there are `4^m` rather than `4^n`.

## No glued-graph type

Gadgets live over a common ambient vertex set `Fin n` and a common edge list `E`, and a gadget proved
on a sub-edge-list is weakened to the ambient by `Gadget.mono`. This follows M06's finding, which was
that de Grey's "gluing" of two 791-vertex copies is structure of the *construction* and not of the
proof: the argument consumes list inclusions and nothing else. Building a composite graph type would
index data no consumer inspects.

## Colours as bare functions

Everything is stated over `f : Fin n → Fin 4` with `hf : ∀ i j, Adj i j → f i ≠ f j`, not over
Mathlib's bundled `SimpleGraph.Coloring`. Composition of bare functions is free; the bundled form
must be rebuilt at each step, and the colour-relabelling step rebuilds it three times. The bundle is
met once, at `not_colorable_of_gadget`, where `rintro ⟨C⟩` produces `⇑C` and `C.valid`.
-/

namespace HadwigerNelson

variable {n m m' : ℕ} {E E' : List (Fin n × Fin n)} {p : Fin m → Fin n} {p' : Fin m' → Fin n}

/-! ## The type -/

/-- **A gadget**: a constraint on how a proper 4-colouring may colour the ports `p`, together with
the proof that every proper colouring of `E` satisfies it.

`admits` is data and `sound` is its proof, bundled because neither is any use without the other. The
edge list and the port tuple are *indices*: two gadgets compose only if they agree on both, so every
consumer must know them. -/
structure Gadget (n m : ℕ) (E : List (Fin n × Fin n)) (p : Fin m → Fin n) where
  /-- The port colourings this gadget permits. -/
  admits : (Fin m → Fin 4) → Bool
  /-- Every proper 4-colouring of the ambient graph colours the ports admissibly. -/
  sound : ∀ f : Fin n → Fin 4, (∀ i j, (edgeGraph n E).Adj i j → f i ≠ f j) →
    admits (fun k => f (p k)) = true

namespace Gadget

/-! ## Composition, and the conclusion -/

/-- **Composition.** Two gadgets on the same ports of the same graph constrain it jointly. -/
def inter (g h : Gadget n m E p) : Gadget n m E p where
  admits q := g.admits q && h.admits q
  sound := sorry

/-- **A gadget that admits nothing.** If no colouring of the ports is permitted, no proper
4-colouring of the graph exists — because a colouring would colour the ports somehow.

This is the terminal move of the algebra, and the only one that mentions `Colorable`. -/
theorem _root_.HadwigerNelson.not_colorable_of_gadget (g : Gadget n m E p)
    (h : ∀ q, g.admits q = false) : ¬ (edgeGraph n E).Colorable 4 := sorry

/-! ## Reading a gadget elsewhere -/

/-- **A gadget proved on a subgraph holds on the whole graph** — more edges only rule out more
colourings. This is where a gadget's own edge list is discharged into the ambient one. -/
def mono (hsub : E' ⊆ E) (g : Gadget n m E' p) : Gadget n m E p where
  admits := g.admits
  sound := sorry

/-- **Read a gadget through a wider port tuple.** A gadget speaking about two of three ports becomes
one speaking about all three and ignoring the rest — which is what lets gadgets with different port
sets be intersected. -/
def widen (ι : Fin m → Fin m') (hp : p = fun k => p' (ι k)) (g : Gadget n m E p) :
    Gadget n m' E p' where
  admits q := g.admits (fun k => q (ι k))
  sound := sorry

/-- **Transport along a vertex map.** If `φ` carries every edge of `E'` to an edge of `E`, a gadget
over `E'` becomes a gadget over `E` with its ports moved by `φ`: pull the colouring back along `φ`.

`φ` is an arbitrary function and nothing here assumes it is injective or has any structure — the
hypothesis `hφ` carries the whole burden, and it includes `≠` because `SimpleGraph.Adj` does. A map
that collapsed an edge could not satisfy it. -/
def transport (φ : Fin n → Fin n) (hφ : ∀ e ∈ E', (edgeGraph n E).Adj (φ e.1) (φ e.2))
    (g : Gadget n m E' p) : Gadget n m E (fun k => φ (p k)) where
  admits := g.admits
  sound := sorry

/-! ## The producers -/

/-- **The base gadget: an edge.** Its two endpoints do not share a colour. No certificate, no
computation — this is the fact that every other gadget is eventually contradicted against. -/
def edge {i j : Fin n} (h : (edgeGraph n E).Adj i j) : Gadget n 2 E ![i, j] where
  admits q := q 0 != q 1
  sound := sorry

end Gadget

/-! ## Colour symmetry, at any number of ports

Relabelling the four colours carries proper colourings to proper colourings, so what a gadget can say
about its ports is really a statement about the *partition* the ports fall into — not about which
colours they take. That is worth a factor of up to `4! = 24` on the number of refutations a gadget
needs, and it is why one certificate covers three colour cases in M06 and twenty in M07.

M06 and M07 each proved the case they needed — two ports and three ports. Those were the same lemma
twice; here it is once. -/

/-- Two port colourings induce the same partition of the ports: the same ports agree, and the same
ports differ. -/
def samePattern {m : ℕ} (a b : Fin m → Fin 4) : Bool := decide (∀ i j, a i = a j ↔ b i = b j)

/-- **Colour symmetry.** Two port colourings inducing the same partition differ by a permutation of
the four colours.

The bound `4` is not incidental: the partition can have at most four blocks precisely because there
are four colours, which is what makes the extension to a permutation possible. -/
theorem exists_perm_comp_eq {m : ℕ} {a b : Fin m → Fin 4} (h : ∀ i j, a i = a j ↔ b i = b j) :
    ∃ σ : Equiv.Perm (Fin 4), ∀ k, σ (a k) = b k := sorry

/-- The ports pinned to a specific colour pattern, as a cube for the solver. -/
def pinCube (p : Fin m → Fin n) (q : Fin m → Fin 4) : Cube n 4 :=
  (List.finRange m).map fun k => (p k, q k)

/-- **A refutation is a gadget.** If pinning the ports to the pattern `q₀` leaves the graph
4-uncolourable, then no proper colouring gives the ports *any relabelling* of `q₀` — one certificate,
up to twenty-four patterns.

This is the only producer that costs a SAT solver anything, and the only place `Unsat` appears in the
algebra. -/
def Gadget.ofUnsat (q₀ : Fin m → Fin 4)
    (h : (coloringCNF 4 n E ++ cubeCNF 4 n (pinCube p q₀)).Unsat) : Gadget n m E p where
  admits q := !samePattern q q₀
  sound := sorry

/-! ## Spec

A gadget algebra whose theorems were all vacuous would elaborate perfectly. The model exhibited here
is `K₅`, the complete graph on five vertices — the smallest graph the algebra can refute from base
gadgets alone, with no certificate anywhere. It is *not* a unit-distance graph and never will be
(`K₄` already fails to embed), which is exactly why it is the right spec witness: it exercises every
move of the algebra at a size where the answer is known by hand. -/

section Spec

/-- The ten edges of `K₅`. -/
def k5 : List (Fin 5 × Fin 5) :=
  [(0, 1), (0, 2), (0, 3), (0, 4), (1, 2), (1, 3), (1, 4), (2, 3), (2, 4), (3, 4)]

/-- One of `K₅`'s edges as a gadget on all five ports. -/
def k5Edge (i j : Fin 5) (hij : (i, j) ∈ k5) (hne : i ≠ j) :
    Gadget 5 5 k5 (fun k => k) :=
  ((Gadget.edge (edgeGraph_adj_of_mem hne hij)).widen ![i, j] (by funext k; fin_cases k <;> rfl))

/-- **The composition is not vacuous, and it proves something true.** Five colours' worth of mutually
adjacent vertices cannot be four-coloured, and the algebra says so from ten edge gadgets and one
`decide` over the `4⁵` port colourings — with no solver, no certificate, and no graph handed to
anything. -/
example : ¬ (edgeGraph 5 k5).Colorable 4 := sorry

/-- **The negative control.** Delete one edge gadget and the intersection admits a colouring again —
`K₅` minus an edge *is* 4-colourable. Without this, the example above would be consistent with a
composition that reports "admits nothing" whatever it is given. -/
example : ∃ q : Fin 5 → Fin 4,
    (k5Edge 0 1 (by decide) (by decide)).admits q = true ∧
    (k5Edge 0 2 (by decide) (by decide)).admits q = true := sorry

/-- **A model of `exists_perm_comp_eq`'s hypothesis**, so the colour-symmetry lemma is not
quantifying over nothing: two port colourings with the same partition — first and third agree, second
differs — related by a relabelling. -/
example : ∃ σ : Equiv.Perm (Fin 4), ∀ k, σ (![2, 3, 2] k) = ![0, 1, 0] k := sorry

end Spec

end HadwigerNelson
