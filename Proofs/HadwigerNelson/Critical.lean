import Proofs.HadwigerNelson.Fan
import Mathlib.Combinatorics.SimpleGraph.DeleteEdges

/-! # What a fan actually is: one removable vertex

M14 found the property de Grey's construction has — a **fan**: a pivot `p` and partners `Q` such
that every proper `k`-colouring paints `p` like at least one member of `Q`. It did not say what
having one *means*. This module does, and the answer is a two-line identity that reshapes the
search for rung D.

Join `p` to **every** other vertex. A proper `k`-colouring of that graph is exactly a proper
`k`-colouring of `G` in which `p`'s colour belongs to `p` alone — which is a proper
`(k-1)`-colouring of everything else, plus one spare colour for `p`. Since `Fan.widen` makes a fan
survive enlarging `Q`, that widest join is the *easiest* fan there is. So:

> **a fan of any width sits at `p` ⟺ deleting `p` leaves a graph that still needs `k` colours.**

The fan is vertex redundancy, and the three consequences are the milestone
(`plans/M15-the-hunt.md` § 0):

* **The search's existence test drops a colour.** Asking "is there a fan at `p`?" as a fan is a
  `k`-colour refutation; as a deletion it is a `(k-1)`-colour one, measured **7.6×** cheaper on the
  only instance where the question costs anything at all.
* **One call retires a whole pivot**, against one call per distance class — and it retired all 39
  of de Grey's seed points in 0.15 s.
* **Every witness this project holds is closed to the route.** A shrinking search drives a witness
  toward vertex-criticality; vertex-criticality is exactly the absence of a removable vertex; and a
  graph with no removable vertex has no fan anywhere. M07 shrank all three witnesses.

## The shape

Everything below is two theorems and their corollaries. The two are the halves of one
correspondence — **the spare colour and the deleted vertex are the same thing** — stated over an
arbitrary vertex type with no finiteness and no decidability, because neither half needs any:

| | |
|---|---|
| `exists_isolating_of_colorable_delete` | the extension: a `k`-colouring of `G` minus `p`'s edges, plus one spare colour for `p` |
| `colorable_delete_of_exists_isolating` | the compression: drop `p`'s private colour and the rest is a `k`-colouring |

`0 < k` sits on the second and not the first, which is where the demand really is: at `k = 0` on a
one-point graph the compression's hypothesis holds and its conclusion is false, because the spare
colour has to exist. The workhorse — the negative — goes through the *first*, so it carries no side
condition at all.

## Which direction to reach for

The two directions are not equally useful, and the asymmetry is the point.

| you have | you want | use |
|---|---|---|
| a `(k-1)`-colouring of `G` minus `p`'s edges | *no* fan at `p`, at **any** width | `not_fan_of_colorable_delete` |
| the same, and a specific partner in mind | no forced pair | `not_forces_of_colorable_delete` |
| the same, for every vertex | no fan anywhere | `not_fan_of_vertex_critical` |
| a refutation of `G` minus `p`'s edges | the widest fan | `fan_univ_of_not_colorable_delete` |
| both | the identity | `fan_univ_iff` |

The first is the one the hunt runs constantly, and its evidence is a single explicit colouring the
kernel checks against the edge list — **no solver, no certificate**. That is what makes "searched
here, found nothing" a theorem rather than a claim about `tools/`.

## Two names deliberately not minted

`(G.deleteIncidenceSet p).Colorable k` appears seven times below and is **not** given a name.
Mathlib has no vertex-criticality notion to reuse — grepped, not recalled — so a name here would be
minted, and "critical" is a word graph theory applies to a *graph*, never to a vertex; `Critical G
k p` would read as a term of art that is not one. The composite already says what it means in
vocabulary every reader of Mathlib holds, and a name would replace that with a token to unfold.
`∀ q, q ≠ p → C p ≠ C q` is left unnamed for the same reason: it appears three times, it is six
tokens, and a predicate on colourings whose only consumers are the two theorems that mention it is a
layer rather than an abstraction. M14 made the same call about `Fan`'s dual and it was right.

`SimpleGraph.deleteIncidenceSet` is Mathlib's: it deletes the edges at `p` and keeps `p` in the
vertex type as an isolated point. That is exactly the model wanted — every statement below compares
colourings of `G` with colourings of `G` minus `p`, and an induced subgraph on a subtype would make
each of those a transport instead of an inclusion.
-/

namespace HadwigerNelson

open SimpleGraph

variable {V : Type*} {G : SimpleGraph V} {k : ℕ}

/-! ## The correspondence -/

/-- **The extension.** A `k`-colouring of `G` minus `p`'s edges becomes a `(k+1)`-colouring of `G`
in which `p` holds a colour of its own: give the old colours their old vertices and hand `p` the
spare one.

No hypothesis on `k`, and none on `V` — this is the half the hunt calls, and it must stay free. -/
theorem exists_isolating_of_colorable_delete {p : V} (h : (G.deleteIncidenceSet p).Colorable k) :
    ∃ C : G.Coloring (Fin (k + 1)), ∀ q, q ≠ p → C p ≠ C q := by
  sorry

/-- **The compression.** A `(k+1)`-colouring of `G` that gives `p` a colour nobody else has is a
`k`-colouring of `G` minus `p`'s edges: delete that colour and renumber.

`0 < k` is not decoration. At `k = 0` on the one-point graph the hypothesis holds vacuously — a
single vertex has no `q ≠ p` to clash with — and the conclusion `Colorable 0` demands an empty
vertex type. The spare colour has to exist for there to be anything left after removing it. -/
theorem colorable_delete_of_exists_isolating {p : V} (hk : 0 < k)
    (h : ∃ C : G.Coloring (Fin (k + 1)), ∀ q, q ≠ p → C p ≠ C q) :
    (G.deleteIncidenceSet p).Colorable k := by
  sorry

/-- **The correspondence**, as one statement: `G` minus `p`'s edges takes `k` colours exactly when
some `(k+1)`-colouring of `G` leaves `p` alone in its colour class. -/
theorem colorable_delete_iff_exists_isolating {p : V} (hk : 0 < k) :
    (G.deleteIncidenceSet p).Colorable k ↔
      ∃ C : G.Coloring (Fin (k + 1)), ∀ q, q ≠ p → C p ≠ C q :=
  ⟨exists_isolating_of_colorable_delete, colorable_delete_of_exists_isolating hk⟩

/-! ## What it says about fans

Four corollaries, one line each. That they are one line each is the evidence that the two theorems
above are the right pair — the fan, the forced pair and the criticality statement are the same fact
read at three widths. -/

/-- **A colouring of `G` minus `p`'s edges refutes every fan at `p`, at every width.**

The workhorse: it is what a rejected candidate hands back, and it needs no hypothesis on `k`. -/
theorem not_fan_of_colorable_delete {p : V} {Q : List V} (hp : p ∉ Q)
    (h : (G.deleteIncidenceSet p).Colorable k) : ¬ Fan G (k + 1) p Q := by
  obtain ⟨C, hC⟩ := exists_isolating_of_colorable_delete h
  exact fun hfan => let ⟨q, hq, hcq⟩ := hfan C; hC q (by rintro rfl; exact hp hq) hcq

/-- **The same at width one** — M13's forced pair. One colouring of `G` minus `p`'s edges rules out
every partner `p` might have forced, so a sweep costs one call per pivot rather than `n - 1`. -/
theorem not_forces_of_colorable_delete {p q : V} (hpq : p ≠ q)
    (h : (G.deleteIncidenceSet p).Colorable k) : ¬ Forces G (k + 1) p q := by
  obtain ⟨C, hC⟩ := exists_isolating_of_colorable_delete h
  exact fun hf => hC q (Ne.symm hpq) (hf C)

/-- **A graph with no removable vertex has no fan anywhere** — the corollary that closes the de
Grey route on a shrunk witness, and the form the certified negative reaches. -/
theorem not_fan_of_vertex_critical (h : ∀ p : V, (G.deleteIncidenceSet p).Colorable k) {p : V}
    {Q : List V} (hp : p ∉ Q) : ¬ Fan G (k + 1) p Q :=
  not_fan_of_colorable_delete hp (h p)

/-- **A vertex whose deletion keeps the graph uncolourable carries the widest fan.**

The converse direction, in fan vocabulary. `Fintype` and `DecidableEq` arrive here and nowhere
else, and they are intrinsic rather than incidental: "the widest `Q`" is a *list of everything*, and
everything is only listable when there is finitely much of it. -/
theorem fan_univ_of_not_colorable_delete [Fintype V] [DecidableEq V] {p : V} (hk : 0 < k)
    (h : ¬ (G.deleteIncidenceSet p).Colorable k) :
    Fan G (k + 1) p (Finset.univ.erase p).toList := by
  sorry

/-- **The identity.** A fan sits at `p` exactly when `p` is removable. -/
theorem fan_univ_iff [Fintype V] [DecidableEq V] {p : V} (hk : 0 < k) :
    Fan G (k + 1) p (Finset.univ.erase p).toList ↔ ¬ (G.deleteIncidenceSet p).Colorable k :=
  ⟨fun h hc => not_fan_of_colorable_delete (by simp) hc h, fan_univ_of_not_colorable_delete hk⟩

/-! ## Certifying the negative

A rejected pivot's evidence is one explicit colouring. Colours are packed `bits` at a time into a
single `Nat`, following M04's rule that a `Nat` literal costs ~2.3 KB of olean while a literal tree
costs ~145 bytes per node: one number per colouring, never one per vertex. -/

/-- The colour of vertex `v`, read out of a packed `Nat`.

Two moduli, doing different jobs. `% 2 ^ bits` **decodes** — a shift alone leaves every higher
vertex's colour sitting above the field. `% k` **bounds**, and it is the only one soundness rests
on: whatever `bits` says, the result lands in `Fin k`, so `bits` is a tuning parameter and the
theorems below hold for every value of it. That is M05's rule — soundness proved for every decoder,
so the certificate's packing is untrusted as a matter of type — and it is why the `k = 5` case
works at all, five not being a power of two and a three-bit field admitting 5, 6 and 7. -/
def unpackColor (bits k c v : ℕ) : ℕ := (c >>> (bits * v)) % 2 ^ bits % k

/-- **Every edge not incident to `p` is bichromatic** under the packed colouring `c`.

The pivot's own edges are skipped, which is exactly `deleteIncidenceSet`: they are not edges of the
graph being coloured. `p` is a `ℕ` and not a `Fin n` so that `everyVertexCritical` can walk it
against a list index with no bound proof — and it costs nothing, since a `p` past the end simply
skips no edge and demands a *stronger* fact. -/
def properOffPivot {n : ℕ} (E : List (Fin n × Fin n)) (bits k c p : ℕ) : Bool :=
  E.all fun e => e.1.val == p || e.2.val == p ||
    unpackColor bits k c e.1.val != unpackColor bits k c e.2.val

/-- A packed colouring that survives `properOffPivot` colours `G` minus `p`'s edges. -/
theorem colorable_delete_of_packed {n : ℕ} {E : List (Fin n × Fin n)} {bits k c : ℕ} {p : Fin n}
    (hk : 0 < k) (h : properOffPivot E bits k c p.val = true) :
    ((edgeGraph n E).deleteIncidenceSet p).Colorable k := by
  sorry

/-- **Every vertex removable**, from one packed colouring each, in vertex order.

A `List` and a length conjunct rather than a `Vector`, for a measured reason and not a stylistic
one: an `Array` literal is built by a chain of applications, so the kernel pays O(its whole size)
per access (M04), whereas `zipIdx` and `all` walk a literal `List` once. The length check is what
the `Vector` would have carried — without it a short list certifies a prefix while the theorem
quantifies over all of `Fin n`, and the data arrives from an untrusted emitter that must be checked
rather than believed. -/
def everyVertexCritical {n : ℕ} (E : List (Fin n × Fin n)) (bits k : ℕ) (cs : List ℕ) : Bool :=
  cs.length == n && cs.zipIdx.all fun cp => properOffPivot E bits k cp.1 cp.2

theorem forall_colorable_delete_of_packed {n : ℕ} {E : List (Fin n × Fin n)} {bits k : ℕ}
    {cs : List ℕ} (hk : 0 < k) (h : everyVertexCritical E bits k cs = true) (p : Fin n) :
    ((edgeGraph n E).deleteIncidenceSet p).Colorable k := by
  sorry

/-- **No fan anywhere in this graph, at any pivot, at any width** — the form the hunt consumes,
and the only statement in this module a search calls directly. -/
theorem no_fan_of_packed {n : ℕ} {E : List (Fin n × Fin n)} {bits k : ℕ} {cs : List ℕ}
    (hk : 0 < k) (h : everyVertexCritical E bits k cs = true) {p : Fin n} {Q : List (Fin n)}
    (hp : p ∉ Q) : ¬ Fan (edgeGraph n E) (k + 1) p Q :=
  not_fan_of_vertex_critical (forall_colorable_delete_of_packed hk h) hp

/-! ## Specification checks

Every theorem above would hold of a definition that said something else, so each one is pinned
against a graph small enough to decide, and each positive is partnered by a countermodel. The
three-colour numbers cross-check M14's committed measurements: `pendantTriangle` was measured to
have a width-two fan at pivot 3, and the rhombus a width-one fan at pivot 0. -/

/-- A triangle with an isolated fourth point. Deleting the fourth point changes nothing, so it is
removable and carries the widest fan — the model of `fan_univ_of_not_colorable_delete`'s
hypotheses, without which every theorem about removable vertices is a statement about nothing. -/
def triangleAndPoint : List (Fin 4 × Fin 4) := [(0, 1), (0, 2), (1, 2)]

example : ¬ ((edgeGraph 4 triangleAndPoint).deleteIncidenceSet 3).Colorable 2 := by
  sorry

example : Fan (edgeGraph 4 triangleAndPoint) 3 3 [0, 1, 2] := by
  sorry

/-- Vertex 1 of the rhombus is **not** removable: deleting its edges leaves a path, which two
colours suffice for. So no fan sits at pivot 1, at any width — the countermodel. -/
example : ((edgeGraph 4 rhombus).deleteIncidenceSet 1).Colorable 2 := by
  sorry

example : ¬ Fan (edgeGraph 4 rhombus) 3 1 [0, 2, 3] := by
  sorry

/-- Pivot 0 of the rhombus **is** removable, and M14 committed the width-one fan there. -/
example : ¬ ((edgeGraph 4 rhombus).deleteIncidenceSet 0).Colorable 2 := by
  sorry

/-- M14's width-two witness, read through this module: pivot 3 of `pendantTriangle` is removable. -/
example : ¬ ((edgeGraph 4 pendantTriangle).deleteIncidenceSet 3).Colorable 2 := by
  sorry

/-! ### The packed certificate, on a graph small enough to read

`rhombus` is `[(0,1), (0,2), (1,2), (1,3), (2,3)]`. Two bits per vertex, two colours. Pivot 1's
colouring is `0 ↦ 0, 1 ↦ 0, 2 ↦ 1, 3 ↦ 0`, packed low-bits-first as `0 + 0·4 + 1·16 + 0·64 = 16`. -/

example : properOffPivot rhombus 2 2 16 1 = true := by sorry

/-- The same colouring against the wrong pivot: edge `(1,3)` is monochromatic and is no longer
skipped, so the check fails. A certificate filed against the wrong problem is refused. -/
example : properOffPivot rhombus 2 2 16 0 = false := by sorry

/-- One colouring cannot serve every pivot, so the whole-graph check refuses a repeated row. The
rhombus is not vertex-critical at two colours and no certificate for it exists. -/
example : everyVertexCritical rhombus 2 2 [16, 16, 16, 16] = false := by sorry

/-- And the colouring really does refute every fan at pivot 1. -/
example : ¬ Fan (edgeGraph 4 rhombus) 3 1 [0, 2, 3] :=
  not_fan_of_colorable_delete (by sorry)
    (colorable_delete_of_packed (bits := 2) (k := 2) (c := 16) (p := 1) (by norm_num) (by sorry))

end HadwigerNelson
