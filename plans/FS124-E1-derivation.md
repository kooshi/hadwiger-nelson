# FS124-E1 — opening FS-124 and deriving its first claims: the record

*Job FS124-E1 (brief `data/fs124/briefs/FS124-E1-opening.md`), 2026-10-07 (UTC). Identity: Ephodos. The milestone's plan — the
readback, §G, §PA, §IQ, the route, the registered predictions — is `plans/FS124-tight-pairs.md`. This file is the job's record:
stages headed "Stage n — SAVED", each committed before the next. Scripts and outputs: `data/fs124/e1/`. Gate:
`python3 ../.claude/skills/ephodos/scripts/derive_gate.py all FS124-E1-derivation.md`, from `plans/`.*

## Theorems this phase proved

*One line per theorem, with its grade and its address; filled as each stage is saved. Every one is [hand] or derived from [hand]
entries, **one mind, kernel pending**.*

- (none yet — Stage 1 is the opening)

## Notation used by every entry

`S(p)` is the unit circle about `p`, `B(p, r)` the open disc, `B̄(p, r)` the closed one. A *weak `k`-colouring* of an open set `U`,
*present*, *tight for `(a, b)`*, *centre*, *far end*, *rhombus completions*, *of kind both*: as fixed in `data/fs124/claims.md` § The
class and § The object. "Almost every" is for plane Lebesgue measure, and for pairs `(z, u)` of a point and a unit vector the
product of Lebesgue measure and arc length. For a tight pair `(q, z)` with radius `ρ`, its **collars** are the open sets
`W_a = B(z, ρ) ∩ B(q, 1)` (label `a` almost everywhere) and `W_b = B(z, ρ) ∖ B̄(q, 1)` (label `b` almost everywhere). A *rigid
motion* is `g(v) = R_φ v + t`, a rotation followed by a translation, with the measure `dφ dt`.

## Stage 1 — SAVED: the opening, the claims as my verdicts will be about them, and one draft

**The opening** is `plans/FS124-tight-pairs.md`: readback (16 of 16 quotations match; `data/fs124/e1/quote_check.py`, exit 0, and
exit 1 with its fault), §G (24 entries bear, the rest listed silent or retired), §PA (run; listings only), §IQ, the route, seven
registered predictions.

### 1.1 The claims, as stated to the coordinator

*Each claim of the list is kept **as posed** unless a line says "restated". Added statements are marked "added" with the reason.
Every *not claimed* line is mine. Tags: P = per class (true at every number of labels, silent alone on six against seven);
X = across classes (spends the count).*

1. **C124-RADIUS-GRAPH** (added: the relay under (up), and the form the kernel lane should plan; P). *Let `k ≥ 1`, `U` an open set
   of the plane, `c` a weak `k`-colouring of `U`, and `V` a finite subset of `U`. Then the rigid motions `g` with `g(V) ⊂ U` form
   a non-empty open set, and for almost every one of them the points `g(v)`, `g(v′)` have different labels for every two points
   `v, v′` of `V` at distance 1; so the unit-distance graph on `V` has a proper `k`-colouring.* **Not claimed**: anything for an
   infinite `V`; that any open set has a weak `k`-colouring; a bound on the measure of the good motions beyond "full".
2. **C124-RADIUS (up)** — as posed. **Not claimed**: an explicit radius at any `k`; the converse, which is (down) and uses an
   import; that the hypothesis holds at `k = 6`; anything from one disc beyond the finite graphs that fit inside it.
3. **C124-RADIUS (down)** — **restated at every `k` and every open set**: *For every integer `k ≥ 1`: if `χ(ℝ²) ≤ k`, every open
   set of the plane has a weak measurable `k`-colouring.* The claim as posed (`k = 6`, discs) is its instance. Why: the import it
   uses is stated at every `k`, and nothing in the restriction reads a disc. **Not claimed**: anything without the declared outside
   theorem `Outside.OAI158.proper_to_borel_weak`; that `χ(ℝ²) ≤ 6`; any regularity of the colouring obtained.
4. **C124-RADIUS-FIVE** (added: the card's control "at `k = 5` (up) must fire", as a statement; P). *There is `R > 0` such that no
   open disc of radius `R` has a weak measurable five-colouring.* **Not claimed**: any value of `R` — the argument gives the radius
   of a disc holding a finite unit-distance graph that is not five-colourable, which exists by compactness and has not been
   exhibited; the same at six.
5. **C124-SHADOW-OPEN** (added: the one lemma; it is the second half of C132-SHADOW's own argument, G92; P). *Let `U` be an open
   set of the plane, `c` a measurable map from `U` to a finite set of labels with `c(z) ≠ c(z + u)` for almost every pair of a point
   `z` of `U` and a unit vector `u` with `z + u` in `U`, `i` a label, and `W` an open subset of `U` almost every point of which has
   the label `i`. Then the set of points of `U` at distance exactly 1 from some point of `W` is open, and almost every point of it
   has a label other than `i`.* **Not claimed**: anything for a set `W` that is not open; anything at a point whose unit circle
   meets only the boundary of `W`.
6. **C124-OPEN** (added: the object has ends; P). *If `(q, z)` is tight for `(a, b)` with radius `ρ`, then `(q, z′)` is tight for
   `(a, b)` for every point `z′` with `|z′ − q| = 1` and `|z′ − z| < ρ`.* **Not claimed**: anything at an end of a maximal arc of
   tight far ends; that such an arc has ends in `U`.
7. **C124-CENTRE** — as posed. **Not claimed**: that `a` or `b` is present at `q` (C124-KIND); anything about the other labels near
   `q`; that this is all a tight pair forces at `q` — with a second tight far end `z′` for the same `(a, b)` the two conclusions
   intersect, and near `q` the label `a` is confined to `B̄(z, 1) ∩ B̄(z′, 1)`, a region with angle `π − ∠zqz′` at `q`.
8. **C124-COMPLETION** — as posed. **Not claimed**: that any given label is present at `w`; that `w` is an end of a tight pair, or
   carries more than one label; anything that spends the number of labels.
9. **C124-STRADDLE** (added: the wider form the argument carries; P). *Let `c` be a weak `k`-colouring of `U`, `(q, z)` tight for
   `(a, b)`, and `p` a point of `U` with `|p − z| = 1`, `p ≠ q` and `p ≠ 2z − q`. Then there is `η > 0` such that almost every
   point of `B(p, η)` has a label other than `a` and other than `b`.* The rhombus completions are the two such points at distance 1
   from `q`. **Not claimed**: a uniform `η` as `p` tends to `q` or to `2z − q`; anything at those two points.
10. **C124-ANTIPODE** (added: the far unit parallel, G85; P). *Let `c` be a weak `k`-colouring of `U`, `(q, z)` tight for `(a, b)`,
    and suppose `p = 2z − q` lies in `U`. Then there is `η > 0` such that almost every point of `B(p, η)` has a label other than
    `b`, and almost every point `w` of `B(p, η)` with `|w − q| < 2` has a label other than `a`.* **Not claimed**: that `a` is
    present near `p`; that the circle of radius 2 about `q` is an interface there.
11. **C124-KIND** — as posed, with the colouring named: the hexagonal seven-colouring at circumradius 2/5 with one tile enlarged by
    a cap of a unit disc of height 1/61 over the middle of one edge. **Not claimed**: anything at six; that a tight pair with
    neither label present at its centre occurs in any weak six-colouring; that the modified colouring is saturated or honest.
12. **C124-SIX** — as posed. **Not claimed**: that the configuration exists at any `k` (no held object meets the hypothesis);
    which label the fifth one is, or that five suffice; anything when the six pairs use three or more label pairs (R7's centres).
    Its smallest form is stated as its own relay, **C124-SIX-CONES** (X): *in the setting of C124-SIX, there is `η > 0` such that
    almost every point of `B(q, η)` with a label among `a, b, a′, b′` lies in a closed set that is the union of at most four
    regions, each bounded near `q` by two unit circles through `q` meeting at the angle `π/3`, or reduced to `{q}`.*
13. **C124-HALF** — as posed (both statements). **Not claimed**: that a label of `y` is present at `w`; anything inside the unit
    circle about `y` for the first statement; that the first statement's class is inhabited at six.

### 1.2 Draft for the stub — a replacement for its "Provisional bearings" lines of 2026-10-07

*Slot: `plans/STUB-q-ring.md` § Provisional bearings, the paragraph beginning "*For the question of 2026-10-07 (Poros, FS124-P1; one
line of why each, which the opening job's re-grokking replaces):*" through "Entries C132-SHADOW, C132-CROSS, C132-COMP-SHARP,
C132-PLACED-RING, C132-M-EXCL (`plans/FS132-derivation.md`)." — replace that paragraph by the one below. The paragraphs above and
below it stand. The correction inventory item 2 (c) names is already filed there as a dated correction (ll. 456–458) and needs no
further draft.*

> *For the question of 2026-10-07 (the opening job's re-grokking, FS124-E1; `plans/FS124-tight-pairs.md` §G):* G92 and G84 (the
> first-order rule is one lemma — the class of a label is null on the unit circles about an open piece of that label — and every
> claim at a tight pair is the computation of one open set; kind both is contact from both sides, never assumed); G85, G88, G16 (the
> unit parallels of the arc are its centre and the arc of radius 2: a tight pair speaks at `2z − q` as well as at the completions);
> G91 (tightness is open along the ring, so the object is an arc with ends, and what a ring passes on is passed at ends); G83 (the
> first-order rule is not the kill: the straddle between two pieces of one label pinned by two tight pairs is the next round's
> first test); G96 (a tight pair is ball data at its far end and circle data at its centre); G97 (falsifiable here: a first-order
> count that bounds unit arcs about ring points); G95 (C124-KIND is the planted slack at seven); G60 (per-class statements hold at
> every number of labels: only a count across classes at a point can spend six); G89 (where tightness is not forced by a count, the
> question is binding: FS-125, FS-128); G94 (the class with a tight pair is not known to be every weak six-colouring); G79 (read R7,
> the strip and the disk at their tight arcs first); G82, G93 (C124-RADIUS: a random rigid motion on one open set per finite graph);
> G86 (no claim reads a tile as one piece of diameter at most 1); G21 (every control on a model with no margin, its non-vacuous
> count in its line); G13, G22, G90, G98 (one line each in the plan). Rows 135 (the rhombus; (Q) as a normal form reached by a
> move), 136 (the stop), 138 (the cone form), 145 (fragments at every radius, for maps). Entries C132-SHADOW (whose argument is
> the lemma), C132-WITNESS, C132-WIT-SIDE, C132-CROSS, C132-COMP-SHARP (`plans/FS132-derivation.md`).

*Gate at this stage*: `derive_gate.py all` reports one failure by construction — "no derivation entry" — the record holds no entry
until recognition is saved (Stage 2) and the first derivation (Stage 3); every later stage is committed with the gate at exit 0.

**Stage 1 — SAVED** (2026-10-07).

## Stage 2 — SAVED: recognition (`ephodos-recognition`, invoked fresh) on the claims this job takes

**The stall read.** None of the claims has stalled; the card's own shape is two of the skill's conditions. *A result proved only at
instances*: the claims are posed at three named points (`q` and the two completions), each as C132-SHADOW with a named direction.
*A clause per case*: "a direction `v` in it with `v·(z − w) > 0`; then one with `v·(z − w) < 0`" — four applications for one
statement. Both say the description splits one class along an accompaniment.

**For a stranger** (a geometer who knows Minkowski sums and measure; no word of this project). *A measurable set `A` of the plane
almost avoids distance 1: `A ∩ (A + u)` is null for almost every unit vector `u`. An open set `W` lies in `A` up to a null set.
Then `A` is null on the open set `W + S¹`, the points at distance exactly 1 from a point of `W`. Now let `W` be one side of a short
arc of a unit circle about a point `q`, near a point `z` of it: compute `W + S¹`.* **This is a** Minkowski sum of an open set with
the unit circle, and its boundary is the envelope of the unit circles centred on the arc — the arc's two unit parallels, which for
an arc of radius 1 are the point `q` and the arc of radius 2. The reader stops at no word: "tight", "collar", "present" were not
needed to state it.

**The features, sorted** (receipt beside each):

| feature | sort | receipt |
|---|---|---|
| weak properness; measurability of `c` | determines | Fubini consumes both; a constant map satisfies the rest and fails every conclusion |
| `W` open | determines | the fibre of directions must have positive length at every point; C132-SHADOW's own *not claimed* line for sets of positive density |
| C132-SHADOW's segment `p′ + sv` and direction `v` | accompanies — it **splits**: consumed only as "some point of `S(p)` lies in `W`" | E6's argument, second paragraph, never reads `v` (`plans/FS132-E6-derivation.md` ll. 282–287); C124-SHADOW-OPEN's argument runs without it |
| the number of labels | accompanies, for every P-claim | no step reads it |
| the point is `q`, or a completion | accompanies | the conclusion is a property of the open set `W + S¹`; control `shadow-geometry` reads it at eleven kinds of point |
| the interface is an arc of radius **exactly 1** about `q` | determines, for C124-CENTRE and C124-ANTIPODE | control `shadow-geometry`'s fault: with radius 0.9 the predicates at `q` fail |
| the same feature, for C124-COMPLETION and C124-STRADDLE | **accompanies** | the argument uses only that `S(p)` crosses the interface at `z`, from one collar into the other; for any interface between two open one-label pieces that is the map class's edge exclusion (C132-WITNESS) |
| the far end is one point `z` | accompanies | tightness is open along the circle (C124-OPEN): the object is an arc |
| `U` a disc; "radius above the diameter" (C124-RADIUS) | accompanies — splits: consumed only as "`V` fits in `U` after a motion" | C124-RADIUS-GRAPH's argument, any open `U` |
| `V` finite (C124-RADIUS-GRAPH) | accompanies — splits: consumed as "countably many unit pairs" and "the motions keeping `V` in `U` are a set of positive measure" | the argument runs for a countable `V` with compact closure in `U` (entry C124-RADIUS-COUNTABLE) |

**The homes** (several; each tested):

1. *Sets avoiding a distance, in Minkowski's words* — the object is `W + S¹`; the theorem held there is one line of Fubini
   (in this project C132-SHADOW's second half and G84's shadow identity; in print the mechanism of `[OAIMath2026]` Lemma 8.1 by
   FS132-E5's reading, not read by me). **Adopted.** The old proof applies at once; the four direction cases become one set; the
   dictionary holds both ways (label `i` ↔ the set `A`; open one-label piece ↔ `W`).
2. *Envelopes and parallel curves* (Huygens) — `∂(W + S¹)` for a collar of an arc is the pair of parallels at distance 1. **Adopted
   as the computing tool.** It predicts neighbours the card did not pose: of the points one unit from `z`, exactly two are
   exceptional — `q` and `2z − q`, where the circle about the point is tangent to the arc — and at `2z − q` the statement is
   one-sided for `a` and two-sided for `b` (C124-ANTIPODE). And it says what tightness *is*: the interface's inner unit parallel
   has collapsed to a point, so one point sees the whole interface at distance exactly 1.
3. *Kinematic measure on the motion group* — for C124-RADIUS: an edge `{v, v′}` sends a motion `g` to the pair `(g(v), g(v′) −
   g(v))`, a measure-preserving bijection of the group onto (point, unit vector). Theorem held there: invariance of Haar measure;
   in print `[GwynStavrianos2022]` Lemma 2 (held), in this library N-EASY (`AeColouring.exists_motion`, statement name read, proof
   not). **Adopted.** The one changed step: the plane becomes an open set, so "every motion" becomes "the open, non-empty set of
   motions keeping `V` inside".
4. *Ball-polarity* (ball-polyhedra, spindle convexity: the dual of a set `X` is `⋂_{x ∈ X} B̄(x, 1)`) — names the relation at the
   centre: near `q` the inside label lies in the ball-polar of the tight arc. **Not adopted as a home**: recalled, not read; its
   theorems concern one body, and the name predicts nothing here the envelope did not (the asking lane's frame F3, scored at the
   close). Its vocabulary was used for §PA's queries.

**The transfer.** The theorem read: E6's argument for C132-SHADOW (read whole); C132-WITNESS and C132-WIT-SIDE at their entries
(statement, *uses only*, *not claimed*), their arguments not read. Hypotheses to discharge in each entry: `W` open with one label;
weak properness on `U`; the point's unit circle meets `W`. The changed step, named: none for home 1; for home 3 the one above.
**The remaining step is not the problem renamed**: after the lemma each claim is a finite computation with circles.

**The class.** C124-SHADOW-OPEN at every open `W`; C124-STRADDLE at every point whose unit circle crosses the arc; C124-RADIUS-GRAPH
at every open set. **A recognition that differs from the plan's and the card's**: C124-COMPLETION is not a property of tight pairs —
it holds at every interface between two open one-label pieces, of any shape; what tightness adds is at the two envelope points only
(C124-CENTRE, C124-ANTIPODE). So "what a tight pair passes on to its rhombus completions" is what any interface passes on.

**Stage 2 — SAVED** (2026-10-07).
