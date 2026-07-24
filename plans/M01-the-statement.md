# M01 — The statement

> The reduction, and the smallest complete instance of it. No graph data, no SAT solver.
> Everything M04/M05 will do at 1581 vertices, done here at 3.

## Why this is the first milestone

It is the only genuine leaf: `UnitDistance.lean` depends on Mathlib and nothing else of ours. It
is also the highest-stakes milestone in the project, because it fixes *what we will have proved*.
Every later milestone is a computation feeding this reduction; if the reduction says something
weaker or other than "the chromatic number of the plane is at least 5", the computations are
decoration. A wrong statement here is cheap to fix and catastrophic to discover in M05.

## Scope

**In.**

1. `unitDistance V` — the unit-distance graph on a metric space — and the adjacency
   characterisation that removes `fromRel`'s `x ≠ y` bookkeeping from every downstream proof.
2. `¬ G.Colorable n → (n+1 : ℕ∞) ≤ G.chromaticNumber` — the `ℕ∞` step, isolated so no later
   proof re-derives it.
3. The transfer: a finite graph `G` with a vertex map into `V` sending edges to unit distances
   induces `G →g unitDistance V`, hence `G.chromaticNumber ≤ (unitDistance V).chromaticNumber`.
4. Invariance of the bound under an isometry, so we may compute in `ℂ` (where rotation is
   multiplication and coordinates are pairs) and state the headline in
   `EuclideanSpace ℝ (Fin 2)` (where a reader expects it).
5. **The model of the hypotheses**: the unit equilateral triangle. `K₃`, three explicit points in
   `ℂ`, `¬ Colorable 2` by `decide`, yielding `3 ≤ χ(ℝ²)`.

**Out** (carried forward). Exact field arithmetic → M02. CNF encoding and LRAT → M03. Any graph
larger than 3 vertices → M02+.

## The specification, validated here

Item 5 is not a demo; it is the milestone's terminal test. WORKFLOW demands a concrete model of
the hypotheses before anything that assumes them is trusted, and a `∀` over an empty domain proves
everything. The triangle instantiates *every* hypothesis of the transfer with something concrete —
a real `SimpleGraph`, a real vertex map, real unit distances, a real non-colourability fact — and
produces a real (if ancient) theorem about the plane. If the reduction is vacuous or backwards, the
triangle will not compile; if it compiles, the shape is right and M02–M05 are swapping the data.

The specific mis-statements being defended against, from ARCHITECTURE § 6:

- `unitDistance` with vacuous `Adj`: countered by proving both `(unitDistance ℂ).Adj 0 1` and
  `¬ (unitDistance ℂ).Adj 0 2`.
- bound off by one (`n` vs `n+1`, `<` vs `≤`): countered by the triangle landing on exactly `3`,
  a number independently known, and by the deliberately-false variant `4 ≤ χ` being *absent*.
- `ℕ∞` truncation: the statement lives in `ℕ∞` throughout; `chromaticNumber` is never coerced
  to `ℕ`.

## Skeleton

`Proofs/HadwigerNelson/UnitDistance.lean`, every signature and full statement stated, `sorry` at
each leaf, so the specification elaborates before proof effort is spent.

```lean
def unitDistance (V : Type*) [MetricSpace V] : SimpleGraph V :=
  SimpleGraph.fromRel fun x y => dist x y = 1

theorem unitDistance_adj_iff {V} [MetricSpace V] {x y : V} :
    (unitDistance V).Adj x y ↔ dist x y = 1

theorem add_one_le_chromaticNumber_of_not_colorable {W} {G : SimpleGraph W} {n : ℕ}
    (h : ¬ G.Colorable n) : (n + 1 : ℕ∞) ≤ G.chromaticNumber

def unitDistanceHom {ι V} [MetricSpace V] (G : SimpleGraph ι) (p : ι → V)
    (hp : ∀ i j, G.Adj i j → dist (p i) (p j) = 1) : G →g unitDistance V

theorem le_chromaticNumber_unitDistance {ι V} [MetricSpace V] {G : SimpleGraph ι} {n : ℕ}
    (p : ι → V) (hp : ∀ i j, G.Adj i j → dist (p i) (p j) = 1) (hG : ¬ G.Colorable n) :
    (n + 1 : ℕ∞) ≤ (unitDistance V).chromaticNumber

theorem chromaticNumber_unitDistance_congr {V W} [MetricSpace V] [MetricSpace W] (e : V ≃ᵢ W) :
    (unitDistance V).chromaticNumber = (unitDistance W).chromaticNumber
```

`Proofs/HadwigerNelson/Instances/Triangle.lean`:

```lean
def trianglePoints : Fin 3 → ℂ
theorem trianglePoints_dist : ∀ i j, i ≠ j → dist (trianglePoints i) (trianglePoints j) = 1
theorem three_le_chromaticNumber_plane : 3 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber
```

## Domain-modeling pass — findings (step 5, applied)

The four questions below were carried into a fresh `debruijn-domain-modeling` pass. Its results,
and the reasoning that produced them, because the reasoning is what a later milestone will need
when it wants to revisit a call:

**The pipeline's load-bearing fact.** Trace what each consumer needs from the graph and the shape
falls out. The CNF encoder (M03) needs `listed edge → Adj`, to turn a colouring into a satisfying
assignment. The geometry (M04) needs `Adj → listed edge`, to build the homomorphism. Both
directions are required, so the graph must be *exactly* the graph of the edge list, not merely
contain it. That is intrinsic, not a convenience.

**`Adj` is never evaluated at scale.** The geometry check iterates the edge *list*; the CNF encoder
iterates the edge *list*; only the 3- and 7-vertex instances ever `decide` a colouring. So the
adjacency test needs no efficient representation — which kills the `Bool` adjacency matrix
(2.5M entries at n = 1581) as structure incidental to a performance worry that does not exist.

1. **Unit-distance adjacency → direct `SimpleGraph.mk`, not `fromRel`.** `fromRel r` yields
   `Adj x y ↔ x ≠ y ∧ (r x y ∨ r y x)`, and both extra conjuncts are redundant here: `dist` is
   symmetric, and `dist x x = 0 ≠ 1` gives looplessness. Defining `Adj x y := dist x y = 1`
   directly makes `unitDistance_adj_iff` literally `Iff.rfl` and spares every downstream proof the
   peeling. The `@[simp]` lemma still earns its place as the reasoning surface — nobody should
   unfold `Adj` — it just costs nothing to prove.

2. **The finite witness → `edgeGraph n E` over `E : List (Fin n × Fin n)`**, with
   `Adj i j := i ≠ j ∧ ((i,j) ∈ E ∨ (j,i) ∈ E)`. Symmetry and looplessness are then *structural*:
   the definition is total on any list, so there is no well-formedness hypothesis, no smart
   constructor, and no `Subtype` — a malformed list simply denotes a graph without those loops.
   `Fin n` rather than `ℕ` because it buys **discharged** totality on the vertex lookup
   (`p : Fin n → V`, `verts[i]` with `i : Fin n`), keeping the `!`-flavoured denial off the
   certificate path entirely.

   *The consequence M03 must honour*: because `edgeGraph` strips loops structurally, the CNF
   encoder must strip them too, or `Colorable k G → Sat cnf` is **false** — a self-loop makes the
   CNF trivially unsatisfiable while leaving the graph colourable. Both objects derive from `E` by
   the same loop-stripping convention, and then the correspondence holds unconditionally. This is
   the single sharpest trap in the milestone chain and it is recorded here because it is invisible
   until M03 and fatal there.

3. **The drawing stays extrinsic — no bundling.** The CNF side is independent of the geometry: it
   consumes `n` and `E` and never `p` or `V`. Bundling `p` with `E` would hand the encoder an
   object it mostly ignores — an index no consumer inspects. The three arguments at the M05 call
   site (`p`, the distance proof, the non-colourability fact) are independently meaningful and
   independently produced, with no must-agree relationship beyond the graph they share. A
   `UnitDistanceWitness` structure would be speculative structure with one use. *Revisit trigger*:
   M06 (shrinking) manipulates many witnesses at once; if it accumulates N identical call sites,
   collapsing them into one type is subtraction and should happen then, not now.

4. **Bound normal form → the strict, arithmetic-free `(n : ℕ∞) < χ` as the primitive.** It is the
   exact contrapositive of `chromaticNumber_le_iff_colorable` and carries no `ℕ∞` arithmetic at
   all. `ENat.coe_add_one_le_iff : ↑m + 1 ≤ n ↔ ↑m < n` converts to the `≤` form at the three
   headlines that want a numeral. Arithmetic stays in `ℕ`; `ℕ∞` sees only the coercion and the
   order.

**Seams checked.** No adversarial instance survives: the hypotheses are self-defending. A constant
`p` forces `dist (p i) (p i) = 1`, i.e. `0 = 1`, so it admits only edgeless graphs, which are
colourable; `E = []` and `n = 0` both make `¬ Colorable k` false rather than the conclusion wrong.
The remaining admitted-but-harmless states — duplicate edges, reversed duplicates — denote the same
graph. The predicted next lemma (M06's "deleting a vertex preserves non-colourability") states as a
filter on `E`, in the existing vocabulary.

**Scope change this pass caused.** `edgeGraph` and the edge-list specialization of the reduction
move *into* M01, and the triangle is built twice — once as `⊤ : SimpleGraph (Fin 3)` through the
general reduction, once as an explicit edge list through the specialization. Pinning the decision
in elaborated code rather than prose is the point; the double construction cross-checks
`edgeGraph` against Mathlib's `⊤` at a scale where both are obviously right.

## Open representational questions — carried into the pass above

Deliberately *not* decided here; these are exactly the "which shape is true" calls the skill
exists to make, and getting them wrong taxes every later milestone.

1. **Edge hypothesis shape.** `∀ i j, G.Adj i j → dist (p i) (p j) = 1` (extrinsic side condition)
   versus bundling `p` and its proof into a structure `UnitDistanceEmbedding G V`. The bundled form
   is what M04 will actually construct from certificate data; the loose form is what is easiest to
   prove. Which is the real object?
2. **`ℂ` versus `EuclideanSpace ℝ (Fin 2)` as the working plane.** *Partly answered while making
   the skeleton elaborate*: Mathlib has `Complex.orthonormalBasisOneI : OrthonormalBasis (Fin 2) ℝ ℂ`
   (`Analysis/InnerProductSpace/PiL2.lean`), whose `.repr` is a `ℂ ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin 2)`,
   so no isometry needs building. Still open: whether `chromaticNumber_unitDistance_congr` should
   take `V ≃ᵢ W` (weakest hypothesis, what the proof actually needs) or a `LinearIsometryEquiv`
   (what the call site has), and which direction the transport should run.
3. **How the finite graph is presented.** `SimpleGraph (Fin n)` built from an edge list, versus a
   `Fintype`-indexed relation, versus an adjacency `Bool` matrix. M03's CNF encoder and M04's
   certificate both consume this; picking the shape that makes *those* short is the whole game, and
   the choice is invisible at 3 vertices and painful at 1581.
4. **Whether `n + 1` or `n < χ`** is the normal form for the bound, i.e. which side of `Order.succ`
   the simp set should drive toward.

## Obligation-modeling pass — findings (step 6, applied)

Fresh `debruijn-obligation-modeling` pass over the 13 open obligations. Most are two-liners once
the right statement exists; the pass's job was finding which statements those are.

**The decomposition, with each proof's shape named.**

| Obligation | Shape | Derives from |
|---|---|---|
| `lt_chromaticNumber_of_not_colorable` | one line | `not_le.mp` on `chromaticNumber_le_iff_colorable` |
| `unitDistanceHom.map_rel'` | one line | `hp` directly — `unitDistance_adj_iff` is `Iff.rfl` |
| `lt_chromaticNumber_unitDistance` | two-step `calc` | the primitive, then `chromaticNumber_mono_of_hom` |
| `chromaticNumber_unitDistance_congr` | `le_antisymm` of two homs | **no new lemma** — `unitDistanceHom` already generalizes it, applied with `e` and `e.symm` |
| `lt_chromaticNumber_unitDistance_edgeList` | `rcases` on the `Or` | two cases; the second is `dist_comm` |
| `trianglePoints_dist` | 9-case bash over three real facts | three named `dist_ij` leaves |
| `not_colorable_two_top_fin_three` | three lines | `chromaticNumber_top` + `Fintype.card_fin` |
| `edgeGraph_triangleEdges_eq_top` | `ext i j; revert i j; decide` | the argument *is* "check all 9"; the kernel checks all 9 |
| the three headlines | `simpa` | the numeral-form corollary below |

**Three statements the pass added, each removing repeated work.**

1. `add_one_le_chromaticNumber_of_not_colorable` and `add_one_le_chromaticNumber_unitDistance` —
   the numeral forms, `((n + 1 : ℕ) : ℕ∞) ≤ χ`, derived once from the strict primitive via
   `ENat.coe_add_one_le_iff`. Without them each of the three headlines re-derives the same `ℕ∞`
   step. The domain pass's ruling stands — the primitive is strict and arithmetic-free — and these
   are its stated corollaries, not a replacement.
2. Three private leaves `dist_01`, `dist_02`, `dist_12`. The triangle's 9 cases collapse to three
   real-number facts plus `dist_comm` plus `absurd rfl`; naming them turns a `nlinarith`-soup case
   bash into a case bash that *cites*.

**A definition reshaped backward from its proof.** `trianglePoints` moves from a `match` on `Fin 3`
literals to the vector literal `![0, 1, ⟨1/2, √3/2⟩]`. `fin_cases i <;> simp` is reliable against
`Matrix.cons_val_*`; against a bare `match` on `Fin` literals it is not, and the difference is a
proof that transcribes versus a proof that fights. Back's corollary: the definition is the
readout, the proof is the artifact.

**Mutation audit — planned, and part of the gate.** A statement whose weakenings all still prove
was vacuous. Each of these must *break*:

- drop `h : i ≠ j` from `trianglePoints_dist` — must fail (`dist p₀ p₀ = 0`);
- weaken `not_colorable_two_top_fin_three` to `¬ Colorable 3` — must fail (K₃ *is* 3-colourable);
- weaken a headline from `3 ≤ χ` to `4 ≤ χ` — must fail.

## Experience-modeling pass — findings (step 7, applied)

M01 defines the vocabulary every later milestone and every outside reader consumes, so the surface
pass earns its place. Three changes crossed the wire:

1. **Namespace `HadwigerNelson`, not `Proofs.HadwigerNelson`.** Mathlib namespaces by mathematical
   content, never by library name, so `exact?` returns `HadwigerNelson.add_one_le_chromaticNumber_unitDistance`
   and it reads as the theorem it is. (`Proofs.Basic` keeps its own namespace; the two coexist.)

2. **`unitDistance_adj` / `edgeGraph_adj`, dropping the `_iff` suffix.** Mathlib's
   adjacency-unfolding lemmas are `top_adj`, `fromRel_adj`, `bot_adj` — `X_adj`, not `X_adj_iff`.
   A user predicting the name from convention guesses `unitDistance_adj`; the deviant name would
   plant a false belief across every future guess. Both drive the **same** normal form: goals leave
   graph vocabulary — `unitDistance_adj` into metric vocabulary (`dist`, where `norm_num`/`positivity`
   live), `edgeGraph_adj` into list membership (where `decide` closes). Stated destination, so no
   user infers their own.

3. **`lt_chromaticNumber_iff_not_colorable` and `add_one_le_chromaticNumber_iff_not_colorable` as
   `iff`s.** The obligation pass found both directions used; stating one direction implies (Gricean
   implicature) the other is false or hard. The `iff` says both hold and lets `simp`/`rw` travel
   either way. The reduction wrappers stay one-directional — they consume a certificate and produce
   a bound, and that asymmetry is real.

**Docstrings carry the contract "do not unfold."** `unitDistance` and `edgeGraph` each say, in
words, which lemma to reason through and that the definitional shape is not a promise. The
API-only-proof test (prove downstream facts with `unfold` forbidden) is folded into the M01 gate:
if a later milestone reaches for the source, the surface has a hole.

## Terminal test (the M01 gate)

- `lake build` green; zero `sorry`; `lake lint` silent.
- `#print axioms three_le_chromaticNumber_plane` shows only `propext`, `Classical.choice`,
  `Quot.sound`.
- `(unitDistance ℂ).Adj 0 1` and `¬ (unitDistance ℂ).Adj 0 2` both proved.
- The headline reads, out loud, as "at least three colours are needed to colour the plane so that
  no two points at distance one share a colour" — and is known-true independently.
