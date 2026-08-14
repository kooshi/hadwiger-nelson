import Proofs.HadwigerNelson.Gadget

/-!
# Forced pairs, and the spindle that closes them

Both known rungs of this problem are one argument, one colour apart.

* The **Moser spindle** (χ ≥ 4): a rhombus paints its two far corners the same colour in every
  3-colouring; place two rhombi sharing a corner so the far corners land a unit apart; no
  3-colouring survives.
* **de Grey's graph** (χ ≥ 5): a 791-point configuration paints two of its points the same colour
  in every 4-colouring; place two copies sharing the first point so the second points land a unit
  apart; no 4-colouring survives.

Same picture, same three rewrites, and it exists nowhere in this repository as a theorem — M06
hand-composed it for one graph. This module states it once and re-derives the Moser spindle through
it.

It is also the **search's win condition**. A candidate is certified by exhibiting a forced pair and
two placements, never by refuting the assembled graph, so a forcer of `m` points buys a `2m−1`-point
witness for the price of refuting `m` once. That saving is why M06 refuted de Grey's halves rather
than his graph, measured there at 44×.

**The statement lives at `SimpleGraph`, not at edge lists**, because that is where it is true and
because the general statement is the *easier* one: pull a colouring back along each placement, apply
the forcer twice, walk the joining edge. Nothing in the argument is finite, indexed, or geometric.
The list-side bridges below are what make it decidable at a call site.
-/

namespace HadwigerNelson

variable {V W : Type*} {G : SimpleGraph V} {H : SimpleGraph W} {k : ℕ}

/-! ## The property -/

/-- Two vertices are **forced to agree** at `k` colours when no proper `k`-colouring separates them.

The whole target of the search, named. `Fin k` rather than an arbitrary colour type of size `k`
because that is what `SimpleGraph.Colorable` quantifies over, so a forcer and the thing it refutes
speak about the same colourings with no cardinality bookkeeping between them. -/
def Forces (G : SimpleGraph V) (k : ℕ) (p q : V) : Prop :=
  ∀ C : G.Coloring (Fin k), C p = C q

/-- **A forcer speaks about every graph it maps into.** Pull the ambient colouring back along the
placement and the forcer applies to it — one line, and it is the only step of the closing lemma
that does any work. -/
theorem Forces.comap {p q : V} (h : Forces G k p q) (φ : G →g H) (C : H.Coloring (Fin k)) :
    C (φ p) = C (φ q) :=
  h (C.comap φ)

-- The dual, `Separated.comap`, is in `Arity.lean` (a declaration here would rebuild this module's
-- 48 transitive dependents). It is the step Act Two of the six-colour programme travels.

/-- **More edges only force more.** The analogue of `Gadget.mono`, and free. -/
theorem Forces.mono {G' : SimpleGraph V} (hle : G ≤ G') {p q : V} (h : Forces G k p q) :
    Forces G' k p q :=
  fun C => h (C.comap (SimpleGraph.Hom.ofLE hle))

/-- **A symmetry carries a forced pair to a forced pair** — and an *endomorphism* suffices, which is
more than the search needs and a shorter statement than the automorphism version.

This is what licenses the tool to try **one pivot per symmetry orbit** rather than all of them: if
any pair is forced, so is its image under every symmetry the configuration exhibits, so a
representative pivot sees it. Worth stating here rather than in a Python comment, because it is the
completeness argument for the search and nothing else would record it.

The hypothesis is a symmetry **of the graph**, so it covers the orbit-built universe and *not* a
forcer that shrinking has made asymmetric — which is exactly where the saving stops. -/
theorem Forces.map {p q : V} (h : Forces G k p q) (σ : G →g G) : Forces G k (σ p) (σ q) :=
  fun C => h.comap σ C

/-! ## The closing lemma -/

/-- **The spindle closes a forcer.** Two copies of a configuration in which `p` forces `q`, placed
so that the copies share `p` and their two images of `q` are adjacent: the ambient graph has no
`k`-colouring.

    φ(q) ──── ψ(q)      adjacent, so their colours differ
      │         │
   forced    forced
      │         │
    φ(p) ═════ ψ(p)     the same vertex, so their colours agree

The placements are graph homomorphisms and nothing more, so this serves `Assembly`'s copies, a
hand-written embedding, and a search's output without adaptation — and says nothing about geometry,
which is discharged separately by `UDCert.Valid`. The two meet at exactly one place: whether the
partners are an edge. -/
theorem not_colorable_of_spindled_forcer {p q : V} (φ ψ : G →g H)
    (hpiv : φ p = ψ p) (hjoin : H.Adj (φ q) (ψ q)) (h : Forces G k p q) :
    ¬ H.Colorable k := by
  rintro ⟨C⟩
  exact C.valid hjoin ((h.comap φ C).symm.trans (hpiv ▸ h.comap ψ C))

/-! ## The bridges to edge lists, where `decide` lives

`SimpleGraph.Adj` is not decidable here and deliberately so — `Sat/Encoding.lean` records that there
is no `DecidableRel (edgeGraph n E).Adj` instance on purpose. So each hypothesis a caller must
*check* is restated over the edge list, exactly as `Gadget.ofExhaustion` restates properness. -/

/-- **A forcer, from exhausting the colourings.** The hypothesis reads *"every colouring either
paints some listed edge one colour, or agrees on `p` and `q`"* — the contrapositive, and the same
shape `Gadget.ofExhaustion` uses, for the same reason: it is decidable, so a caller writes
`by decide +kernel`.

The ceiling is `k ^ n` colourings; beyond it, `Forces.of_gadget` takes a certificate instead. -/
theorem Forces.of_edges {n : ℕ} {E : List (Fin n × Fin n)} {p q : Fin n}
    (h : ∀ f : Fin n → Fin k, (∃ e ∈ E, e.1 ≠ e.2 ∧ f e.1 = f e.2) ∨ f p = f q) :
    Forces (edgeGraph n E) k p q := by
  intro C
  rcases h C with ⟨e, he, hne, heq⟩ | hpq
  · exact absurd heq (C.valid (edgeGraph_adj_of_mem hne he))
  · exact hpq

/-- **A forcer, from a two-port gadget.** The route that scales: `Gadget.ofUnsat` turns one SAT
refutation into a gadget, and a gadget that admits no pattern separating its two ports is exactly a
forced pair. This is how de Grey's 791-point forcer would be built, where exhaustion is hopeless. -/
theorem Forces.of_gadget {n : ℕ} {E : List (Fin n × Fin n)} {p q : Fin n}
    (g : Gadget k n 2 E ![p, q])
    (hsep : ∀ r : Fin 2 → Fin k, r 0 ≠ r 1 → g.admits r = false) :
    Forces (edgeGraph n E) k p q := by
  intro C
  by_contra hne
  exact absurd (g.sound C fun _ _ hij => C.valid hij)
    (by simpa using hsep (fun i => C (![p, q] i)) (by simpa using hne))

/-- **A forcer straight from a refutation** — the producer that scales, and the one M14 will write.

`Forces.of_gadget` above takes the separation condition as a hypothesis, and a caller cannot
discharge it with `by decide` when the certificate is still abstract: the goal mentions the
refutation, so `decide` refuses on a free variable even though `admits` does not depend on it. That
is an argument every user would have to pass explicitly, which makes it the bug rather than their
mistake. So the condition is discharged once, here.

The colour count is written `k + 2` because the argument genuinely needs two colours to exist — a
pattern that separates two ports has to name two of them — and carrying it in the type beats a side
condition every caller repeats. A literal `4` or `5` unifies with it. -/
theorem Forces.of_unsat {n k : ℕ} {E : List (Fin n × Fin n)} {p q : Fin n}
    (h : (coloringCNF (k + 2) n E ++ cubeCNF (k + 2) n (pinCube ![p, q] ![0, 1])).Unsat) :
    Forces (edgeGraph n E) (k + 2) p q := by
  refine Forces.of_gadget (Gadget.ofUnsat ![0, 1] h) ?_
  intro r hr
  simp only [Gadget.ofUnsat, Bool.not_eq_false', samePattern_iff]
  intro i j
  fin_cases i <;> fin_cases j <;> simp_all
  exact fun hc => hr hc.symm

/-- **A vertex map that carries every listed edge to a listed edge is a placement.** The decidable
hypothesis the closing lemma's homomorphisms come from: for each listed non-loop, the images differ
and are themselves listed, in one orientation or the other. -/
def edgeHom {n N : ℕ} {E : List (Fin n × Fin n)} {F : List (Fin N × Fin N)} (φ : Fin n → Fin N)
    (h : ∀ e ∈ E, e.1 ≠ e.2 → φ e.1 ≠ φ e.2 ∧ ((φ e.1, φ e.2) ∈ F ∨ (φ e.2, φ e.1) ∈ F)) :
    edgeGraph n E →g edgeGraph N F where
  toFun := φ
  map_rel' := by
    rintro i j ⟨hne, hij | hij⟩
    · exact h (i, j) hij hne
    · have hji : (edgeGraph N F).Adj (φ j) (φ i) := h (j, i) hij hne.symm
      exact hji.symm

/-! ## The spindle as a construction, which is what the search's output plugs into

The lemma above takes the ambient graph as given and asks whether each placement lands edges on
edges. Checked by membership search that is `|E| × |F|` list comparisons — **31 million** at a
791-point forcer, which is the same trap M06 hit and escaped by ordering the edge list so each half
was a contiguous segment.

So do not check it: **define** the assembled edge list as the two placed copies followed by the
joining edge. Then each placement is a homomorphism *structurally*, and the only per-edge obligation
left is that the placement does not collapse an edge to a loop — one disequality per edge, not one
search per edge. -/

/-- The spindle's edge list: one copy of `E` under each placement, then the joining edge. -/
def spindleEdges {n N : ℕ} (φ ψ : Fin n → Fin N) (E : List (Fin n × Fin n))
    (j : Fin N × Fin N) : List (Fin N × Fin N) :=
  (E.map fun e => (φ e.1, φ e.2)) ++ (E.map fun e => (ψ e.1, ψ e.2)) ++ [j]

/-- The first copy is a placement into the spindle, with no membership search. -/
def spindleHomLeft {n N : ℕ} {E : List (Fin n × Fin n)} {j : Fin N × Fin N} (φ ψ : Fin n → Fin N)
    (hφ : ∀ e ∈ E, e.1 ≠ e.2 → φ e.1 ≠ φ e.2) :
    edgeGraph n E →g edgeGraph N (spindleEdges φ ψ E j) :=
  edgeHom φ fun e he hne =>
    ⟨hφ e he hne, Or.inl (List.mem_append_left _ (List.mem_append_left _
      (List.mem_map_of_mem he)))⟩

/-- The second copy, likewise. -/
def spindleHomRight {n N : ℕ} {E : List (Fin n × Fin n)} {j : Fin N × Fin N} (φ ψ : Fin n → Fin N)
    (hψ : ∀ e ∈ E, e.1 ≠ e.2 → ψ e.1 ≠ ψ e.2) :
    edgeGraph n E →g edgeGraph N (spindleEdges φ ψ E j) :=
  edgeHom ψ fun e he hne =>
    ⟨hψ e he hne, Or.inl (List.mem_append_left _ (List.mem_append_right _
      (List.mem_map_of_mem he)))⟩

/-- **The search's win condition, cashed.** A forced pair plus two placements that share the pivot
and separate the partner: the spindled graph has no `k`-colouring.

Every hypothesis is decidable and linear in the forcer's edge list — no membership search, and the
joining edge is free because it is the list's last element by construction. This is the theorem a
candidate the search proposes is certified through. -/
theorem not_colorable_spindleEdges {n N k : ℕ} {E : List (Fin n × Fin n)} {p q : Fin n}
    (φ ψ : Fin n → Fin N)
    (hφ : ∀ e ∈ E, e.1 ≠ e.2 → φ e.1 ≠ φ e.2)
    (hψ : ∀ e ∈ E, e.1 ≠ e.2 → ψ e.1 ≠ ψ e.2)
    (hpiv : φ p = ψ p) (hjne : φ q ≠ ψ q) (hforce : Forces (edgeGraph n E) k p q) :
    ¬ (edgeGraph N (spindleEdges φ ψ E (φ q, ψ q))).Colorable k := by
  refine not_colorable_of_spindled_forcer (spindleHomLeft φ ψ hφ) (spindleHomRight φ ψ hψ)
    hpiv ?_ hforce
  show (edgeGraph N _).Adj (φ q) (ψ q)
  exact ⟨hjne, Or.inl (List.mem_append_right _ (List.mem_singleton_self _))⟩

/-! ## Spec — `rhombus`, and the controls that must go red

The instantiations live where the instances do: `Instances/SpindleBound.lean` re-derives the Moser
spindle through both routes, beside the certificate route it is an alternative to. What stays here
is the forcer the whole file is about and the claims that must be *false*. -/

/-- **The rhombus forces its far corners at three colours**, over all `3⁴ = 81` colourings.

Proved directly rather than through `rhombusGadget`, which states the same fact through the gadget
algebra: two routes to one claim, so the algebra is cross-checked rather than trusted. -/
theorem rhombus_forces : Forces (edgeGraph 4 rhombus) 3 0 3 :=
  Forces.of_edges (by decide +kernel)

/-! ### The controls

Each is a countermodel rather than a build failure: a claim that is *false*, exhibited, so that
dropping the hypothesis it guards could not be papered over. -/

-- **The forcer is colour-count-specific.** At *four* colours the rhombus forces nothing — here is
-- the colouring that separates its far corners.
example : ¬ Forces (edgeGraph 4 rhombus) 4 0 3 := fun h => by
  have := h (SimpleGraph.Coloring.mk (![0, 1, 2, 3] : Fin 4 → Fin 4)
    (by simp only [edgeGraph_adj]; decide))
  simp only [SimpleGraph.Coloring.mk] at this
  exact absurd this (by decide)

-- **The forced pair is the far corners and no other pair.** Vertices `0` and `1` are adjacent in
-- the rhombus, so they are forced *apart* — a forcer filed at the wrong pair is false, not weaker.
example : ¬ Forces (edgeGraph 4 rhombus) 3 0 1 := fun h => by
  have := h (SimpleGraph.Coloring.mk (![0, 1, 2, 0] : Fin 4 → Fin 3)
    (by simp only [edgeGraph_adj]; decide))
  simp only [SimpleGraph.Coloring.mk] at this
  exact absurd this (by decide)

-- **The joining edge is load-bearing.** Delete `(3,6)` and the remaining ten edges are 3-colourable,
-- so `hjoin` cannot be dropped from the closing lemma.
example : (edgeGraph 7 [(0,1), (0,2), (0,4), (0,5), (1,2), (1,3), (2,3), (4,5), (4,6), (5,6)]
    ).Colorable 3 :=
  colorable_iff_exists.mpr ⟨![0, 1, 2, 0, 1, 2, 0], by simp only [edgeGraph_adj]; decide⟩

-- **The shared pivot is load-bearing, and this is the control easiest to get wrong.** Place the
-- second rhombus on four *fresh* vertices, keep both forcers and keep the joining edge `(3,7)`, and
-- the union is 3-colourable after all. Each copy still forces its own pair; what fails is that the
-- two forced colours are now unrelated.
example : (edgeGraph 8 [(0,1), (0,2), (1,2), (1,3), (2,3),
                        (4,5), (4,6), (5,6), (5,7), (6,7), (3,7)]).Colorable 3 :=
  colorable_iff_exists.mpr ⟨![0, 1, 2, 0, 1, 0, 2, 1], by simp only [edgeGraph_adj]; decide⟩

/-! ### The seams

`p = q` and `φ = ψ` both make `hjoin` a self-loop, which `SimpleGraph` forbids — so the degenerate
placements are excluded by the model rather than by a hypothesis anybody has to remember. Recorded
because it is the reason no `p ≠ q` side condition appears above. -/
example {p : V} (φ : G →g H) : ¬ H.Adj (φ p) (φ p) := SimpleGraph.irrefl H

-- A model of every hypothesis at once lives in `Instances/SpindleBound.lean`, where the Moser
-- spindle inhabits them all — so nothing here is a theorem about an empty domain.

end HadwigerNelson
