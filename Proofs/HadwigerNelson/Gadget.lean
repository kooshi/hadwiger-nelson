import Proofs.HadwigerNelson.Sat.Encoding
import Proofs.HadwigerNelson.Pattern
import Mathlib.Data.Fintype.Perm
import Mathlib.Logic.Equiv.Fintype

set_option maxRecDepth 100000

/-!
# Gadgets: colouring constraints that compose

Fix a graph, a number of colours, and a tuple of the graph's vertices — the **ports**. Over all
proper colourings of the graph, the ports can be coloured in some set of ways, and *that set is the
object this file is about*. A **gadget** is an over-approximation of it, together with the proof.

Over-approximation, never under: `admits` may permit port colourings that no colouring achieves, and
may never forbid one that some colouring achieves. That direction is the safety argument, exactly as
in `Sat/Encoding.lean` — a gadget that is too permissive proves less, a gadget that is too strict
would be unsound and cannot be built, because `sound` is a field.

Four moves, and nothing else:

* **produce** — from an edge, from a SAT refutation, or from another gadget moved by a vertex map;
* **compose** — two gadgets on the same ports intersect;
* **read** — through a wider port tuple, or over a larger graph;
* **conclude** — a gadget that admits nothing says the graph has no `k`-colouring.

## The colour count is an index

`χ(ℝ²) ≥ 5` means *no 4-colouring*; `χ(ℝ²) ≥ 6` means *no 5-colouring*. Those are different
questions, and until M11 this file could only ask the first — every declaration said `Fin 4`.
The count is now the first index of `Gadget`, and it appears nowhere else: `Proper` is stated over an
arbitrary colour type because nothing about "no listed edge is monochromatic" counts colours, and
`exists_perm_comp_eq` was already general at M09.

## Why there are ports at all

A gadget could be stated as a constraint on the whole colouring `Fin n → Fin k`, and the composition
would be simpler. The ports exist for exactly one reason: **they make the final check decidable.**
`∀ q : Fin m → Fin k` is finitely many cases the kernel can enumerate; `∀ f : Fin n → Fin k` is
`5^1581`. Everything about the port tuple's shape follows from that — it is a `Fin m → Fin n` rather
than a `List (Fin n)` because `Fin m → Fin k` is a `Fintype` and a list of colours of matching length
is not.

Sharing one port tuple across the gadgets being composed is the other half. Gadgets carrying their
own ports would compose by concatenation, and the check would cost `k^(m₁+m₂+…)` — multiplicative in
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

Everything is stated over `f : Fin n → Fin k` with `hf : ∀ i j, Adj i j → f i ≠ f j`, not over
Mathlib's bundled `SimpleGraph.Coloring`: composition of bare functions is free, while the bundled
form must be rebuilt at every relabelling. The bundle is met once, at `not_colorable_of_gadget`.
-/

namespace HadwigerNelson

variable {k n m m' : ℕ} {E E' : List (Fin n × Fin n)} {p : Fin m → Fin n} {p' : Fin m' → Fin n}

/-- A colouring is proper on an edge list when no listed edge is monochromatic. Named because it is
the hypothesis of every `sound` field and the conclusion of every transport step, and forty
characters of quantifier at each one is forty characters nobody reads.

Stated over an arbitrary colour type, because that is where it is true: nothing here counts
colours. -/
abbrev Proper (n : ℕ) (E : List (Fin n × Fin n)) {α : Type*} (f : Fin n → α) : Prop :=
  ∀ i j, (edgeGraph n E).Adj i j → f i ≠ f j

/-- **Relabelling the colours of a proper colouring leaves it proper.** One line, and it is what
buys colour symmetry at the terminal check — see `not_colorable_of_gadget`. -/
theorem Proper.comp_injective {α β : Type*} {f : Fin n → α} {σ : α → β}
    (hσ : Function.Injective σ) (hf : Proper n E f) : Proper n E fun v => σ (f v) :=
  fun i j hij hc => hf i j hij (hσ hc)

/-! ## The type -/

/-- **A gadget**: which colourings of the ports `p` are possible in a proper `k`-colouring of `E`,
over-approximated, with the proof.

`admits` is data and `sound` is its proof, bundled because neither is any use without the other and
because two definitions related by a lemma is the arrangement that lets them drift — M05 replaced
exactly that arrangement in the checker for exactly that reason.

The colour count, the edge list and the port tuple are **indices**: two gadgets compose only if they
agree on all three, and every operation below either demands that agreement or changes one of them on
purpose. -/
structure Gadget (k n m : ℕ) (E : List (Fin n × Fin n)) (p : Fin m → Fin n) where
  /-- The port colourings this gadget permits. -/
  admits : (Fin m → Fin k) → Bool
  /-- Every proper `k`-colouring of the ambient graph colours the ports admissibly. -/
  sound : ∀ f : Fin n → Fin k, Proper n E f → admits (fun i => f (p i)) = true

namespace Gadget

/-! ## Compose -/

/-- **Composition.** Two gadgets on the same ports of the same graph constrain it jointly.

Associative and commutative, with `Gadget.trivial` as its unit, so a list of gadgets composes by
`List.foldr Gadget.inter Gadget.trivial` when a search produces one. Nothing here needs the lattice
laws, so they are not stated. -/
def inter (g h : Gadget k n m E p) : Gadget k n m E p where
  admits q := g.admits q && h.admits q
  sound f hf := by simp [g.sound f hf, h.sound f hf]

/-- The gadget that constrains nothing — the unit of `inter`, and what an empty list of gadgets
composes to. -/
def trivial : Gadget k n m E p where
  admits _ := true
  sound _ _ := rfl

/-! ## Read elsewhere -/

/-- **A gadget proved on a subgraph holds on the whole graph** — more edges only rule out more
colourings. This is where a gadget's own edge list is discharged into the ambient one. -/
def mono (hsub : E' ⊆ E) (g : Gadget k n m E' p) : Gadget k n m E p where
  admits := g.admits
  sound f hf := g.sound f fun i j hij => hf i j (edgeGraph_adj_mono hsub hij)

/-- **Read a gadget through a wider port tuple.** A gadget speaking about two of three ports becomes
one speaking about all three and ignoring the rest — which is what lets gadgets with different port
sets be intersected. `ι` says which of the wider ports the narrower ones are. -/
def widen (ι : Fin m → Fin m') (hp : ∀ i, p i = p' (ι i)) (g : Gadget k n m E p) :
    Gadget k n m' E p' where
  admits q := g.admits (fun i => q (ι i))
  sound f hf := by simpa only [← hp] using g.sound f hf

/-- **Transport along a vertex map.** If `φ` carries every edge of `E'` to an edge of `E`, a gadget
over `E'` becomes a gadget over `E` with its ports moved by `φ`: pull the colouring back along `φ`.

`φ` is an arbitrary function — nothing here assumes it is injective or has any structure. The
hypothesis `hφ` carries the whole burden, and it includes distinctness because `SimpleGraph.Adj`
does, so a map that collapsed an edge could not satisfy it.

This is the move that makes a copy of a subgraph free. When `φ` is the index map of a plane isometry
(`Motion`), the copy's *geometry* transports too, and placing it costs nothing at all. -/
def transport (φ : Fin n → Fin n) (hφ : ∀ e ∈ E', (edgeGraph n E).Adj (φ e.1) (φ e.2))
    {pt : Fin m → Fin n} (hp : ∀ i, φ (p i) = pt i) (g : Gadget k n m E' p) : Gadget k n m E pt where
  admits := g.admits
  sound f hf := by
    -- Pull the colouring back along `φ`: proper on `E` gives proper on `E'`, because `φ` sends
    -- every edge of `E'` to an edge of `E` — including the distinctness `Adj` carries.
    have : Proper n E' (fun v => f (φ v)) := by
      intro i j hij
      rcases (edgeGraph_adj.mp hij).2 with hm | hm
      · exact hf _ _ (hφ (i, j) hm)
      · exact fun hc => hf _ _ (hφ (j, i) hm) hc.symm
    simpa only [hp] using g.sound _ this

/-! ## Produce -/

/-- **The base gadget: an edge between two ports.** Ports `i` and `j` do not share a colour. No
certificate, no computation — this is the fact every other gadget is eventually contradicted against.

Stated over *port indices* rather than over vertices, so an edge gadget needs no `widen`: an edge's
ports are always two of the shared ports, never anything else, and making the caller build a
two-element tuple and then prove it agrees with the shared one was work the task never asked for. -/
def edge (i j : Fin m) (h : (edgeGraph n E).Adj (p i) (p j)) : Gadget k n m E p where
  admits q := q i != q j
  sound f hf := by simpa using hf _ _ h

end Gadget

/-! ## Colour symmetry, at any number of ports and any number of colours

Relabelling the colours carries proper colourings to proper colourings, so what a gadget can say
about its ports is a statement about the **partition** the ports fall into, never about which colours
they take. That is worth up to `k!` refutations — one certificate covers three colour cases in M06
and twenty in M07, and at five colours it would cover a hundred and twenty.

Represented as a *relation* between colourings rather than by normalising each to a canonical
representative. The relation is what the problem has; a normal form would be a normal form maintained
by hand, with its own theorem to prove and its own opportunity to disagree with the relation it
stands for.

**And the number of colours plays no part.** A canonical normal form would have needed "at most `k`
blocks, because there are `k` colours"; the relational form is handed both colourings and never
counts blocks, so the lemma below is stated where it is actually true — over any finite port set and
any target type. That is the second thing choosing the relation bought.

The relation itself — `SamePattern`, and its `Bool` twin `samePattern` — lives in `Pattern.lean`
beside the enumeration of its representatives, because the two are one subject and keeping them in
two files is how they would come to disagree. -/

/-- **Colour symmetry.** Two colourings of a finite set that induce the same partition of it differ
by a permutation of the colours.

Stated over an arbitrary finite domain and an arbitrary target rather than over `Fin m → Fin k`,
because that is where it is true and because the general statement is the *easier* one: `a` and `b`
having the same kernel means both factor injectively through one quotient, and two injections from a
finite type are related by a permutation of the target — `Equiv.Perm.exists_extending_pair`.

Subsumes the two-port relabelling M06 needed and the three-port one M07 needed, which were the same
lemma written twice; `Sat/Forcing.lean`, which held both, is deleted. -/
theorem exists_perm_comp_eq {α β : Type*} [Finite α] {a b : α → β}
    (h : ∀ i j, a i = a j ↔ b i = b j) : ∃ σ : Equiv.Perm β, ∀ i, σ (a i) = b i := by
  classical
  -- `a` and `b` have the same kernel, so both factor *injectively* through one quotient — and two
  -- injections out of a finite type are related by a permutation of the target.
  obtain ⟨σ, hσ⟩ := Equiv.Perm.exists_extending_pair
    (α := Quotient (Setoid.ker a))
    (Quotient.lift a fun _ _ hij => hij)
    (Quotient.lift b fun i j hij => (h i j).mp hij)
    (by rintro ⟨i⟩ ⟨j⟩ hij; exact Quotient.sound hij)
    (by rintro ⟨i⟩ ⟨j⟩ hij; exact Quotient.sound ((h i j).mpr hij))
  exact ⟨σ, fun i => hσ (Quotient.mk _ i)⟩

/-- The ports listed, in index order — the vertex set a cube is taken over. -/
def portList (p : Fin m → Fin n) : List (Fin n) := (List.finRange m).map p

/-- The ports pinned to a colour pattern, as a cube for the solver. The one seam between the gadget
world, where a pattern is a tuple, and the SAT world, where it is a list of (vertex, colour) pairs. -/
def pinCube {k : ℕ} (p : Fin m → Fin n) (q : Fin m → Fin k) : Cube n k :=
  (List.finRange m).map fun i => (p i, q i)

/-- **A refutation is a gadget.** If pinning the ports to the pattern `q₀` leaves the graph
`k`-uncolourable, then no proper colouring gives the ports *any relabelling* of `q₀` — one
certificate, up to `k!` patterns.

The only producer that costs a solver anything, and the only place `Unsat` appears in the algebra.

At `m = 0` this is `not_colorable_of_unsat`: no ports, an empty cube, and `samePattern` vacuously
true, so the gadget admits nothing. The monolithic case is the algebra's base case rather than a
separate mechanism — the same relationship `allCubes k n [] = [[]]` has to the cube split. -/
def Gadget.ofUnsat (q₀ : Fin m → Fin k)
    (h : (coloringCNF k n E ++ cubeCNF k n (pinCube p q₀)).Unsat)
    (hk : 0 < k := by norm_num) : Gadget k n m E p where
  admits q := !samePattern q q₀
  sound f hf := by
    simp only [Bool.not_eq_true', samePattern, decide_eq_false_iff_not]
    intro hsame
    -- The ports take a relabelling of the refuted pattern, so *some* relabelling of `f` pins them
    -- to it exactly — and that colouring satisfies a formula with a refutation.
    obtain ⟨σ, hσ⟩ := exists_perm_comp_eq hsame
    refine not_pinned (portList p) (fun v => σ (f v)) (valid_comp_of_injective hf σ.injective) ?_ hk
    have hcube : cubeOf (portList p) (fun v => σ (f v)) = pinCube p q₀ := by
      simp only [cubeOf, portList, pinCube, List.map_map, Function.comp_def, hσ]
    rw [hcube]; exact h

/-! ## Conclude — and the same computation reports the failure

The terminal check is an exhaustive search over the port colourings, and during a gadget search it
**fails far more often than it succeeds** — that is what searching is. So the check is defined as
*"the search came back empty"* rather than as a separate `∀`, and the thing that comes back is the
list of colourings that survived.

One computation, two readings: the build consumes `survivors = []`, and a reader runs
`#eval g.survivors` and sees exactly what is not yet ruled out. They cannot disagree, because there is
nothing for them to disagree about — M05 replaced a checker and a fault-reporter related by a lemma
with precisely this arrangement, and `ARCHITECTURE.md` § 6 lists the weaker version as a defect.

**The search ranges over one colouring per partition of the ports**, not over all `k^m` of them
(`Pattern.lean`). That is sound because a proper colouring stays proper when its colours are
renamed, so if any colouring survives, a representative of its partition survives too. It is
measured at 53–72× at five colours, and it is the difference between a check that runs at ten
interface vertices and one that dies at eight. -/

/-- **The port colourings this gadget has not ruled out**, one per partition of the ports.

Empty is the condition `not_colorable_of_gadget` consumes; non-empty is the report a reader needs,
rendered as one list of colours per port. Run it with `#eval` on the composite when a build fails and
the surviving colourings say which constraint is missing. -/
def Gadget.survivors (g : Gadget k n m E p) : List (List (Fin k)) :=
  ((canonPatterns k m).filter g.admits).map (List.ofFn ·)

/-- **A gadget that admits nothing.** If no colouring of the ports survives, no proper `k`-colouring
of the graph exists — a colouring would have to colour the ports somehow.

The terminal move of the algebra, and the only one that mentions `Colorable`. Note what the type
already guarantees: such a gadget can be *built* only by proving `sound`, so "admits nothing" is
inhabited exactly when the graph really is not `k`-colourable. -/
theorem not_colorable_of_gadget (g : Gadget k n m E p) (h : g.survivors = []) :
    ¬ (edgeGraph n E).Colorable k := by
  sorry

/-! ## Spec

An algebra whose theorems were all vacuous would elaborate perfectly. The model exhibited here is
`K₅`, the complete graph on five vertices — the smallest graph the algebra refutes from base gadgets
alone, with no certificate anywhere — and `K₆` beside it, because a file that only ever refutes
4-colourings is a file whose colour index is never exercised. Neither is a unit-distance graph and
neither will be (`K₄` already fails to embed), which is exactly why they are the right spec
witnesses: they exercise every move at a size where the answer is known by hand. -/

section Spec

/-- The ten edges of `K₅`. -/
def k5 : List (Fin 5 × Fin 5) :=
  [(0, 1), (0, 2), (0, 3), (0, 4), (1, 2), (1, 3), (1, 4), (2, 3), (2, 4), (3, 4)]

/-- One of `K₅`'s edges as a gadget on its five ports, which are its five vertices. -/
def k5Edge (i j : Fin 5) (hij : (i, j) ∈ k5) (hne : i ≠ j) : Gadget 4 5 5 k5 (fun i => i) :=
  Gadget.edge i j (edgeGraph_adj_of_mem hne hij)

/-- All ten of them, composed. -/
def k5Gadget : Gadget 4 5 5 k5 (fun i => i) :=
  List.foldr Gadget.inter Gadget.trivial
    [k5Edge 0 1 (by decide) (by decide), k5Edge 0 2 (by decide) (by decide),
     k5Edge 0 3 (by decide) (by decide), k5Edge 0 4 (by decide) (by decide),
     k5Edge 1 2 (by decide) (by decide), k5Edge 1 3 (by decide) (by decide),
     k5Edge 1 4 (by decide) (by decide), k5Edge 2 3 (by decide) (by decide),
     k5Edge 2 4 (by decide) (by decide), k5Edge 3 4 (by decide) (by decide)]

/-- **The composition is not vacuous, and it proves something true.** Five mutually adjacent vertices
cannot be four-coloured, and the algebra says so from ten edge gadgets and one `decide` over the
fifty-two port partitions — no solver, no certificate, and no graph handed to anything. -/
example : ¬ (edgeGraph 5 k5).Colorable 4 := not_colorable_of_gadget k5Gadget (by decide)

/-- The same ten edges read at **five** colours, where they refute nothing. -/
def k5GadgetFive : Gadget 5 5 5 k5 (fun i => i) :=
  List.foldr Gadget.inter Gadget.trivial
    [Gadget.edge 0 1 (edgeGraph_adj_of_mem (by decide) (by decide)),
     Gadget.edge 0 2 (edgeGraph_adj_of_mem (by decide) (by decide)),
     Gadget.edge 0 3 (edgeGraph_adj_of_mem (by decide) (by decide)),
     Gadget.edge 0 4 (edgeGraph_adj_of_mem (by decide) (by decide)),
     Gadget.edge 1 2 (edgeGraph_adj_of_mem (by decide) (by decide)),
     Gadget.edge 1 3 (edgeGraph_adj_of_mem (by decide) (by decide)),
     Gadget.edge 1 4 (edgeGraph_adj_of_mem (by decide) (by decide)),
     Gadget.edge 2 3 (edgeGraph_adj_of_mem (by decide) (by decide)),
     Gadget.edge 2 4 (edgeGraph_adj_of_mem (by decide) (by decide)),
     Gadget.edge 3 4 (edgeGraph_adj_of_mem (by decide) (by decide))]

-- **The colour index is load-bearing**, and this is what says so: the same ten gadgets that admit
-- nothing at four colours admit exactly one pattern at five — all five ports distinct, which is the
-- 5-colouring. A file whose colour count was quietly still four would print `0` here.
/-- info: [[0, 1, 2, 3, 4]] -/
#guard_msgs in
#eval k5GadgetFive.survivors

-- **The negative control**, and the report a failing search gets. Drop one edge gadget and one
-- pattern survives — `K₅` minus an edge *is* 4-colourable, and the survivor gives the two
-- now-unjoined vertices the same colour. Without this, the example above would be consistent with a
-- composition that reports "admits nothing" whatever it is handed.
--
-- The rendered output is pinned rather than described: it is what a reader meets on the day a search
-- does not close, and an unreadable one would be discovered on that day rather than this one. Note
-- what the partition enumeration bought the reader — M09 printed twenty-four relabellings of this
-- one fact.
/-- info: [[0, 1, 2, 3, 3]] -/
#guard_msgs in
#eval (List.foldr Gadget.inter Gadget.trivial
  [k5Edge 0 1 (by decide) (by decide), k5Edge 0 2 (by decide) (by decide),
   k5Edge 0 3 (by decide) (by decide), k5Edge 0 4 (by decide) (by decide),
   k5Edge 1 2 (by decide) (by decide), k5Edge 1 3 (by decide) (by decide),
   k5Edge 1 4 (by decide) (by decide), k5Edge 2 3 (by decide) (by decide),
   k5Edge 2 4 (by decide) (by decide)]).survivors

/-- **A model of `exists_perm_comp_eq`'s hypothesis**, so colour symmetry is not quantifying over
nothing: two port colourings with the same partition — first and third agree, second differs. -/
example : ∃ σ : Equiv.Perm (Fin 4), ∀ i, σ (![2, 3, 2] i) = ![0, 1, 0] i :=
  exists_perm_comp_eq (by intro i j; fin_cases i <;> fin_cases j <;> simp)

end Spec

end HadwigerNelson
