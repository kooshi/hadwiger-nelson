# FS124-E1 — opening FS-124 and deriving its first claims: the record

*Job FS124-E1 (brief `data/fs124/briefs/FS124-E1-opening.md`), 2026-10-07 (UTC). Identity: Ephodos. The milestone's plan — the
readback, §G, §PA, §IQ, the route, the registered predictions — is `plans/FS124-tight-pairs.md`. This file is the job's record:
stages headed "Stage n — SAVED", each committed before the next. Scripts and outputs: `data/fs124/e1/`. Gate:
`python3 ../.claude/skills/ephodos/scripts/derive_gate.py all FS124-E1-derivation.md`, from `plans/`.*

## Theorems this phase proved

*One line per theorem, with its grade and its address; filled as each stage is saved. Every one is [hand] or derived from [hand]
entries, **one mind, kernel pending**.*

- **C124-RADIUS-GRAPH** — [hand], one mind — Stage 3, § Argument — a random rigid motion.
- **C124-RADIUS-COUNTABLE**, **C124-RADIUS-UP**, **C124-RADIUS-FIVE** — derived from it, one mind — Stage 3.
- **C124-RADIUS-DOWN** — [hand] over the declared outside theorem `Outside.OAI158.proper_to_borel_weak`, one mind — Stage 3, § Argument — up, down, five.

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

## Stage 3 — SAVED: C124-RADIUS

derivation: C124-RADIUS-GRAPH
  statement: Let k ≥ 1, U an open set of the plane, c a weak k-colouring of U, and V a finite subset of U. Then the rigid motions g with g(V) ⊂ U form a non-empty open set, and for almost every one of them the points g(v), g(v′) have different labels for every two points v, v′ of V at distance 1; so the unit-distance graph on V has a proper k-colouring.
  uses only: that for two points v, v′ at distance 1 the map g ↦ (g(v), g(v′) − g(v)) is a bijection of the motion group onto the pairs (point, unit vector) carrying dφ dt to Lebesgue measure times arc length; weak properness in its measure form; that V is finite and U open. No count of labels, no regularity of c, nothing about the shape of U
  not claimed: anything for an infinite V (C124-RADIUS-COUNTABLE takes countable sets with compact closure in U); that any open set has a weak k-colouring; a bound on the measure of the good motions beyond "full"
  argument: § Argument — a random rigid motion
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7, U the open disc of radius 2, c the hexagonal seven-colouring at circumradius 2/5 (colour (m + 3n) mod 7 on the hexagon about m(2√3/5, 0) + n(√3/5, 3/5)), V the seven points of a Moser spindle: of 20,000 sampled motions keeping V in U none gives a monochromatic unit pair (control `radius-motions`)
  prior art: partly: the argument for a colouring of the whole plane is `[GwynStavrianos2022]` Lemma 2 (held; read by FS-103, not re-read by me) and this library's N-EASY (`Proofs/HadwigerNelson/Plane/YesLimit.lean`, `AeColouring.exists_motion`; statement name read, proof not); for an open set — zbMATH "probabilistic Hadwiger" and "almost every" with "unit distance" and colouring (0), arXiv Hadwiger–Nelson with measurable and disc or bounded or local (3, none on point by title): not found in print
  handoff: de Bruijn — the statement as written, on the local weak colouring of an open set; it is `AeColouring.exists_motion` with "every motion" replaced by "the open set of motions keeping V in U". Read the formal statement back against "almost every motion in that open set", not "some motion"

derivation: C124-RADIUS-COUNTABLE
  statement: Let k ≥ 1, U an open set of the plane, c a weak k-colouring of U, and V a countable subset of U whose closure is a compact subset of U. Then the unit-distance graph on V has a proper k-colouring of the form v ↦ c(g(v)) for a rigid motion g with g(V) ⊂ U.
  uses only: C124-RADIUS-GRAPH's argument with countably many unit pairs; that a compact subset of an open set keeps a positive distance from its complement, so the motions near the identity keep V in U
  not claimed: anything for an uncountable V; anything for a countable V that accumulates at the boundary of U; that the colouring obtained is measurable in any sense on a larger set
  argument: § Argument — a random rigid motion
  verdict: derived
  grade: derived from: C124-RADIUS-GRAPH
  minds: 1
  model: as C124-RADIUS-GRAPH's, with V the points of the closed disc of radius 1 with both coordinates in ℚ(√3, √11) — a countable set dense in the disc holding every Moser spindle of that field inside it
  prior art: owed — not searched for in this form; for the whole plane it is the remark that N-EASY needs no compactness for a countable subfield's plane
  handoff: none — a relay-result; it says where de Bruijn–Erdős (and with it the axiom of choice) enters C124-RADIUS-UP: only in passing from countable sets to the whole plane

derivation: C124-RADIUS-UP
  statement: For every integer k ≥ 1: if for every R > 0 the open disc of radius R about the origin has a weak measurable k-colouring, then every finite unit-distance graph in the plane has a proper k-colouring, and χ(ℝ²) ≤ k.
  uses only: C124-RADIUS-GRAPH with U a disc holding the graph; the de Bruijn–Erdős theorem for the unit-distance graph of the plane. Of the hypothesis: for each finite graph, one disc that holds it
  not claimed: an explicit radius at any k; the converse (C124-RADIUS-DOWN, which uses an import); that the hypothesis holds at k = 6; anything from one disc beyond the finite graphs that fit inside it
  argument: § Argument — up, down, five
  verdict: derived
  grade: derived from: C124-RADIUS-GRAPH
  minds: 1
  model: k = 7: the hexagonal seven-colouring at circumradius 2/5 restricted to each disc satisfies the hypothesis, and χ(ℝ²) ≤ 7 is this library's row 33
  prior art: partly: de Bruijn–Erdős is classical (recalled, not read; used in this library by `chromaticNumber_plane_le_chiM0`); for arc maps of discs the conclusion is row 145's FS116-O1-YESLIM by a weak-* limit (`chromaticNumber_plane_le_six_of_fragments`); the bounded case for proper colourings is Kruskal 2008 (Zbl 1139.05023, held at abstract); the disc form for weak colourings not found in print (the queries of C124-RADIUS-GRAPH)
  handoff: de Bruijn — the statement as written, after C124-RADIUS-GRAPH; it subsumes FS116-O1-YESLIM's use (an arc map of a disc is a weak colouring of it), with no limit taken

derivation: C124-RADIUS-DOWN
  statement: For every integer k ≥ 1: if χ(ℝ²) ≤ k, every open set of the plane has a weak measurable k-colouring.
  uses only: the declared outside theorem `Outside.OAI158.proper_to_borel_weak` ([kernel, outside]: a proper k-colouring of the plane gives a measurable one proper at almost every unit pair, at every k); that normalized angular measure and arc length have the same null sets; that the restriction of a weak colouring of the plane to an open set is a weak colouring of it
  not claimed: anything without that import; that χ(ℝ²) ≤ 6; any regularity of the colouring obtained beyond measurability
  argument: § Argument — up, down, five
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7: the hypothesis is row 33, and the conclusion holds with the hexagonal seven-colouring, with no import (in this library `proper_to_borel_weak_model`)
  prior art: known: `[OAIMath2026]` family 158, "Transfer of colorability", forward direction; the restriction is immediate
  handoff: de Bruijn — one line over the import and the local definition; with C124-RADIUS-UP it gives, at each k, that χ(ℝ²) ≤ k and "every open disc has a weak measurable k-colouring" hold together or fail together — at k = 6, with χ(ℝ²) ≤ 7 (row 33), the plane needs seven colours precisely if some open disc has no weak measurable six-colouring (C132-RADIUS, as it was posed)

derivation: C124-RADIUS-FIVE
  statement: There is R > 0 such that no open disc of radius R has a weak measurable five-colouring.
  uses only: C124-RADIUS-UP at k = 5; the declared outside theorem `Outside.OAI158.no_proper_five_coloring` ([kernel, outside]); that discs of one radius are translates
  not claimed: any value of R — the argument gives the radius of a disc holding a finite unit-distance graph that is not five-colourable, which exists by compactness and has not been exhibited; the same at six
  argument: § Argument — up, down, five
  verdict: derived
  grade: derived from: C124-RADIUS-UP
  minds: 1
  model: the statement is an existence; its analogue with an exhibited radius is at k = 3: by C124-RADIUS-GRAPH no open disc holding a Moser spindle has a weak measurable three-colouring
  prior art: partly: `[OAIMath2026]` Thm 1.4 is the statement for the whole plane; for a disc not found in the release by the asking lane's reading (`plans/STUB-q-ring.md` § The first claims), not checked by me
  handoff: de Bruijn — a corollary; the formal statement to read back is "∃ R, no weak five-colouring of the ball of radius R"

### Argument — a random rigid motion

Write `g = g_{φ,t}`, `g(v) = R_φ v + t`. The set `G` of motions with `g(V) ⊂ U` is the intersection of the finitely many open sets
`{g : g(v) ∈ U}` and contains the identity. Fix two points `v, v′` of `V` at distance 1 and put `u₀ = v′ − v`. The map
`Φ(φ, t) = (R_φ v + t, R_φ u₀)` is a bijection onto (point, unit vector): the second coordinate gives `φ`, then the first gives
`t`. In the coordinates `(φ, t) ↦ (t + R_φ v, φ + arg u₀)` its Jacobian matrix is triangular with unit diagonal, so `Φ` carries
`dφ dt` to Lebesgue measure times arc length. The set `N` of pairs `(z, u)` with `z ∈ U`, `z + u ∈ U`, `c(z) = c(z + u)` is
measurable (`c` is) and null (weak properness). So `{g ∈ G : c(g(v)) = c(g(v′))} = G ∩ Φ⁻¹(N)` is null. The union over the unit
pairs of `V` is null; `G` is open and non-empty, hence of positive measure; almost every `g ∈ G` is outside the union, and for
such a `g` the map `v ↦ c(g(v))` is a proper colouring of the unit-distance graph on `V`. ∎

*Countable `V` with compact closure in `U`.* The unit pairs are countably many, so the union is still null; and the closure
of `V` keeps a positive distance from the complement of `U`, so every motion close enough to the identity keeps `V` in `U`: `G`
contains a non-empty open set. The rest is the same. ∎

### Argument — up, down, five

*Up.* Let `Γ` be a finite unit-distance graph with vertex set `V`, and `R` larger than every `|v|`. A weak `k`-colouring of the
open disc of radius `R` and C124-RADIUS-GRAPH give a proper `k`-colouring of `Γ`. Every finite subgraph of the unit-distance graph
of the plane being `k`-colourable, so is the whole graph (de Bruijn–Erdős). ∎

*Down.* `χ(ℝ²) ≤ k` gives a proper colouring `ℂ → Fin k`; the import gives a measurable `d` with `d(z) ≠ d(z + u)` for almost
every `(z, u)`; the pairs with `z, z + u` in an open set `U` and equal labels are a subset of that null set. ∎

*Five.* If every open disc about the origin had a weak five-colouring, *Up* would give a proper five-colouring of the plane,
which the import forbids. So some disc about the origin has none, and its translates have none. (A larger disc then has none
either, by restriction.) ∎

control: radius-motions
  of: C124-RADIUS-GRAPH — the conclusion on its model: sampled rigid motions of a Moser spindle into the disc of radius 2 under the hexagonal seven-colouring at circumradius 2/5; the fault colours by hexagons of circumradius 3/5, of diameter 6/5, which is not a weak colouring
  run: python3 ../data/fs124/e1/tight_checks.py radius
  expect: circumradius=0.4 disc-radius=2.0 motions=20000 unit-pairs-per-motion=11 monochromatic-pairs=0
  fault: python3 ../data/fs124/e1/tight_checks.py radius --fault

**What rests on these.** C124-RADIUS-UP and C124-RADIUS-DOWN are the statement through which either answer of the milestone is
consumed: a NO becomes "this disc has no weak six-colouring", a YES a family of weak six-colourings of discs, of any regularity.
C124-RADIUS-GRAPH is the form to plan in Lean; it reads one open set and one finite set. **Tight on the model?** The control's
colouring has a margin (circumradius 2/5): it tests the motion argument, which reads no margin; its fault is a colouring that is
not weak. **Predictions scored**: P1 — met on both halves (up derived as posed and in the wider form; down at every `k`).

**Stage 3 — SAVED** (2026-10-07).
