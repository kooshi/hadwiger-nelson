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

## Open representational questions — for the domain-modeling pass (step 5)

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

## Terminal test (the M01 gate)

- `lake build` green; zero `sorry`; `lake lint` silent.
- `#print axioms three_le_chromaticNumber_plane` shows only `propext`, `Classical.choice`,
  `Quot.sound`.
- `(unitDistance ℂ).Adj 0 1` and `¬ (unitDistance ℂ).Adj 0 2` both proved.
- The headline reads, out loud, as "at least three colours are needed to colour the plane so that
  no two points at distance one share a colour" — and is known-true independently.
