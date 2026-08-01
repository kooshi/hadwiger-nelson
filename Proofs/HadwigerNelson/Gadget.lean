import Proofs.HadwigerNelson.Sat.Encoding
import Mathlib.Data.Fintype.Perm
import Mathlib.Logic.Equiv.Fintype

set_option maxRecDepth 100000

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
  sound f hf := by simp [g.sound f hf, h.sound f hf]

/-- The gadget that constrains nothing — the unit of `inter`, and what an empty list of gadgets
composes to. -/
def trivial : Gadget n m E p where
  admits _ := true
  sound _ _ := rfl

/-! ## Read elsewhere -/

/-- **A gadget proved on a subgraph holds on the whole graph** — more edges only rule out more
colourings. This is where a gadget's own edge list is discharged into the ambient one. -/
def mono (hsub : E' ⊆ E) (g : Gadget n m E' p) : Gadget n m E p where
  admits := g.admits
  sound f hf := g.sound f fun i j hij => hf i j (edgeGraph_adj_mono hsub hij)

/-- **Read a gadget through a wider port tuple.** A gadget speaking about two of three ports becomes
one speaking about all three and ignoring the rest — which is what lets gadgets with different port
sets be intersected. `ι` says which of the wider ports the narrower ones are. -/
def widen (ι : Fin m → Fin m') (hp : ∀ k, p k = p' (ι k)) (g : Gadget n m E p) :
    Gadget n m' E p' where
  admits q := g.admits (fun k => q (ι k))
  sound f hf := by simpa only [← hp] using g.sound f hf

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
def edge (i j : Fin m) (h : (edgeGraph n E).Adj (p i) (p j)) : Gadget n m E p where
  admits q := q i != q j
  sound f hf := by simpa using hf _ _ h

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

**And the number of colours turns out to play no part.** A canonical normal form would have needed
"at most four blocks, because there are four colours"; the relational form is handed both colourings
and never counts blocks, so the lemma below is stated where it is actually true — over any finite
port set and any target type. That is the second thing choosing the relation bought. -/

/-- Two port colourings induce the same partition of the ports: the same ports agree, and the same
ports differ. -/
def samePattern {m : ℕ} (a b : Fin m → Fin 4) : Bool := decide (∀ i j, a i = a j ↔ b i = b j)

/-- **Colour symmetry.** Two colourings of a finite set that induce the same partition of it differ
by a permutation of the colours.

Stated over an arbitrary finite domain and an arbitrary target rather than over `Fin m → Fin 4`,
because that is where it is true and because the general statement is the *easier* one: `a` and `b`
having the same kernel means both factor injectively through one quotient, and two injections from a
finite type are related by a permutation of the target — `Equiv.Perm.exists_extending_pair`.

Subsumes the two-port relabelling M06 needed and the three-port one M07 needed, which were the same
lemma written twice; `Sat/Forcing.lean`, which held both, is deleted. -/
theorem exists_perm_comp_eq {α β : Type*} [Finite α] {a b : α → β}
    (h : ∀ i j, a i = a j ↔ b i = b j) : ∃ σ : Equiv.Perm β, ∀ k, σ (a k) = b k := by
  classical
  -- `a` and `b` have the same kernel, so both factor *injectively* through one quotient — and two
  -- injections out of a finite type are related by a permutation of the target.
  obtain ⟨σ, hσ⟩ := Equiv.Perm.exists_extending_pair
    (α := Quotient (Setoid.ker a))
    (Quotient.lift a fun _ _ hij => hij)
    (Quotient.lift b fun i j hij => (h i j).mp hij)
    (by rintro ⟨i⟩ ⟨j⟩ hij; exact Quotient.sound hij)
    (by rintro ⟨i⟩ ⟨j⟩ hij; exact Quotient.sound ((h i j).mpr hij))
  exact ⟨σ, fun k => hσ (Quotient.mk _ k)⟩

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
  sound f hf := by
    simp only [Bool.not_eq_true', samePattern, decide_eq_false_iff_not]
    intro hsame
    -- The ports take a relabelling of the refuted pattern, so *some* relabelling of `f` pins them
    -- to it exactly — and that colouring satisfies a formula with a refutation.
    obtain ⟨σ, hσ⟩ := exists_perm_comp_eq hsame
    refine not_pinned (portList p) (fun v => σ (f v)) (valid_comp_of_injective hf σ.injective) ?_
    have hcube : cubeOf (portList p) (fun v => σ (f v)) = pinCube p q₀ := by
      simp only [cubeOf, portList, pinCube, List.map_map, Function.comp_def, hσ]
    rw [hcube]; exact h

/-! ## Conclude — and the same computation reports the failure

The terminal check is an exhaustive search over the `4^m` port colourings, and during a gadget search
it **fails far more often than it succeeds** — that is what searching is. So the check is defined as
*"the search came back empty"* rather than as a separate `∀`, and the thing that comes back is the
list of colourings that survived.

One computation, two readings: the build consumes `survivors = []`, and a reader runs
`#eval g.survivors` and sees exactly what is not yet ruled out. They cannot disagree, because there is
nothing for them to disagree about — M05 replaced a checker and a fault-reporter related by a lemma
with precisely this arrangement, and `ARCHITECTURE.md` § 6 lists the weaker version as a defect. -/

/-- Every colouring of `m` ports with four colours — `4 ^ m` of them, in a fixed order. -/
def allPatterns : (m : ℕ) → List (Fin m → Fin 4)
  | 0 => [Fin.elim0]
  | m + 1 => (List.finRange 4).flatMap fun c => (allPatterns m).map fun q => Fin.cons c q

/-- The enumeration is complete — the local obligation that makes the exhaustive search exhaustive. -/
theorem mem_allPatterns : ∀ {m : ℕ} (q : Fin m → Fin 4), q ∈ allPatterns m
  | 0, q => by simpa [allPatterns] using (funext fun i => i.elim0 : q = Fin.elim0)
  | _ + 1, q => by
      simp only [allPatterns, List.mem_flatMap, List.mem_map, List.mem_finRange]
      exact ⟨q 0, trivial, Fin.tail q, mem_allPatterns _, Fin.cons_self_tail q⟩

/-- **The port colourings this gadget has not ruled out.**

Empty is the condition `not_colorable_of_gadget` consumes; non-empty is the report a reader needs,
rendered as one list of colours per port. Run it with `#eval` on the composite when a build fails and
the surviving colourings say which constraint is missing. -/
def Gadget.survivors (g : Gadget n m E p) : List (List (Fin 4)) :=
  ((allPatterns m).filter g.admits).map (List.ofFn ·)

/-- **A gadget that admits nothing.** If no colouring of the ports survives, no proper 4-colouring of
the graph exists — a colouring would have to colour the ports somehow.

The terminal move of the algebra, and the only one that mentions `Colorable`. Note what the type
already guarantees: such a gadget can be *built* only by proving `sound`, so "admits nothing" is
inhabited exactly when the graph really is not 4-colourable. -/
theorem not_colorable_of_gadget (g : Gadget n m E p) (h : g.survivors = []) :
    ¬ (edgeGraph n E).Colorable 4 := by
  rintro ⟨C⟩
  have hadm : g.admits (fun k => C (p k)) = true := g.sound _ fun _ _ hij => C.valid hij
  have : (fun k => C (p k)) ∈ (allPatterns m).filter g.admits :=
    List.mem_filter.mpr ⟨mem_allPatterns _, hadm⟩
  simp only [Gadget.survivors, List.map_eq_nil_iff] at h
  simp [h] at this

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

/-- One of `K₅`'s edges as a gadget on its five ports, which are its five vertices. -/
def k5Edge (i j : Fin 5) (hij : (i, j) ∈ k5) (hne : i ≠ j) : Gadget 5 5 k5 (fun k => k) :=
  Gadget.edge i j (edgeGraph_adj_of_mem hne hij)

/-- All ten of them, composed. -/
def k5Gadget : Gadget 5 5 k5 (fun k => k) :=
  List.foldr Gadget.inter Gadget.trivial
    [k5Edge 0 1 (by decide) (by decide), k5Edge 0 2 (by decide) (by decide),
     k5Edge 0 3 (by decide) (by decide), k5Edge 0 4 (by decide) (by decide),
     k5Edge 1 2 (by decide) (by decide), k5Edge 1 3 (by decide) (by decide),
     k5Edge 1 4 (by decide) (by decide), k5Edge 2 3 (by decide) (by decide),
     k5Edge 2 4 (by decide) (by decide), k5Edge 3 4 (by decide) (by decide)]

/-- **The composition is not vacuous, and it proves something true.** Five mutually adjacent vertices
cannot be four-coloured, and the algebra says so from ten edge gadgets and one `decide` over the `4⁵`
port colourings — no solver, no certificate, and no graph handed to anything. -/
example : ¬ (edgeGraph 5 k5).Colorable 4 := not_colorable_of_gadget k5Gadget (by decide)

-- **The negative control**, and the report a failing search gets. Drop one edge gadget and 24 port
-- colourings survive — `K₅` minus an edge *is* 4-colourable, and the survivors all give the two
-- now-unjoined vertices the same colour. Without this, the example above would be consistent with a
-- composition that reports "admits nothing" whatever it is handed.
--
-- The rendered output is pinned rather than described: it is what a reader meets on the day a search
-- does not close, and an unreadable one would be discovered on that day rather than this one.
/-- info: 24 -/
#guard_msgs in
#eval (List.foldr Gadget.inter Gadget.trivial
  [k5Edge 0 1 (by decide) (by decide), k5Edge 0 2 (by decide) (by decide),
   k5Edge 0 3 (by decide) (by decide), k5Edge 0 4 (by decide) (by decide),
   k5Edge 1 2 (by decide) (by decide), k5Edge 1 3 (by decide) (by decide),
   k5Edge 1 4 (by decide) (by decide), k5Edge 2 3 (by decide) (by decide),
   k5Edge 2 4 (by decide) (by decide)]).survivors.length

/-- info: [[0, 1, 2, 3, 3], [0, 1, 3, 2, 2]] -/
#guard_msgs in
#eval (List.foldr Gadget.inter Gadget.trivial
  [k5Edge 0 1 (by decide) (by decide), k5Edge 0 2 (by decide) (by decide),
   k5Edge 0 3 (by decide) (by decide), k5Edge 0 4 (by decide) (by decide),
   k5Edge 1 2 (by decide) (by decide), k5Edge 1 3 (by decide) (by decide),
   k5Edge 1 4 (by decide) (by decide), k5Edge 2 3 (by decide) (by decide),
   k5Edge 2 4 (by decide) (by decide)]).survivors.take 2

/-- **A model of `exists_perm_comp_eq`'s hypothesis**, so colour symmetry is not quantifying over
nothing: two port colourings with the same partition — first and third agree, second differs. -/
example : ∃ σ : Equiv.Perm (Fin 4), ∀ k, σ (![2, 3, 2] k) = ![0, 1, 0] k :=
  exists_perm_comp_eq (by intro i j; fin_cases i <;> fin_cases j <;> simp)

end Spec

end HadwigerNelson
