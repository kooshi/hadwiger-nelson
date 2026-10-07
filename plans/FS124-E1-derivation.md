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
- **C124-SHADOW-OPEN** — [hand], one mind — Stage 4, § Argument — the unit shadow of an open piece.
- **C124-OPEN** — [hand], one mind; **C124-CENTRE**, **C124-STRADDLE**, **C124-ANTIPODE** — derived from C124-SHADOW-OPEN, one mind; **C124-COMPLETION** — derived from C124-STRADDLE — Stage 4, § Argument — the centre, the straddle, the antipode.
- **C124-KIND** — [hand], one mind, by formula with exact margins — Stage 5, § Argument — the capped honeycomb.
- **C124-SIX-CONES**, **C124-SIX** — derived from C124-CENTRE, one mind — Stage 5, § Argument — three half-planes. No object meets C124-SIX's hypothesis.
- **C124-HALF**, **C124-HALF-TWO** — [hand] over the inherited C132-WIT-SIDE, one mind — Stage 5, § Argument — the half. No held object meets C124-HALF's hypothesis.

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

*Correction, dated 2026-10-07 (filed by FS-124's record job, FS124-Z1; source: the kernel
planner's record `plans/FS124-kernel-plan.md` § 4.1 on branch `fs124-wk1`, the row "the bad pairs `N`" of its table; inventory
item 19, "For the deriver's entry"):* in § Argument — a random rigid motion, the sentence "The set `N` of pairs `(z, u)` … is
measurable (`c` is) and null (weak properness)" has one clause that no later line uses. The planner: "the hand argument's clause
"measurable (`c` is)" is not used by any later line, and the entry's own *uses only* says "no regularity of `c`"; the kernel
statement is `AeProperOn`, for any function". The step reads only that `N` is null. The entry's statement, verdict, grade and
count of minds are unchanged; that the result holds for any function proper at almost every unit pair is the planner's own
generalization, recorded in `plans/FS124-derivation.md` § 1 and not entered.

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

## Stage 4 — SAVED: the first-order rule — the shadow lemma, the centre, the completions, the straddle, the antipode

derivation: C124-SHADOW-OPEN
  statement: Let U be an open set of the plane, c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, i a label, and W an open subset of U almost every point of which has the label i. Then the set of points of U at distance exactly 1 from some point of W is open, and almost every point of it has a label other than i.
  uses only: that W is open; Fubini for (p, u) ↦ p + u; weak properness in its measure form. No count of labels, no connectedness of W, no direction, no second label
  not claimed: anything for a set W that is not open; anything at a point whose unit circle meets only the boundary of W; that any weak colouring has an open one-label set
  argument: § Argument — the unit shadow of an open piece
  verdict: derived
  grade: hand
  minds: 1
  model: R7 at seven (the Reuleaux triangle on the lattice points (m, n), (m + 1, n), (m, n + 1) coloured 2(m mod 2) + (n mod 2), the down triangle between coloured 4 + ((m − n) mod 3)): W the interior of the up tile at the origin, label 0 — the points at distance 1 from W carry no 0, and the tile's three arcs are where that set's boundary touches W's own (control `r7-tight`)
  prior art: partly: it is the second half of the argument of C132-SHADOW (`plans/FS132-E6-derivation.md` § Argument — the shadow of an open piece, read whole), whose statement keeps a segment and a direction the half never reads; G84's shadow identity for an open piece; in print the mechanism of `[OAIMath2026]` Lemma 8.1 by FS132-E5's reading (not read by me); for sets avoiding a distance and Minkowski sums with a circle the plan's §PA queries found no statement of it
  handoff: de Bruijn — the statement as written: one open set, one Fubini; C132-SHADOW is its corollary by one intermediate value, and every entry of this stage is this lemma and a computation with circles

derivation: C124-OPEN
  statement: If (q, z) is tight for (a, b) with radius ρ, then (q, z′) is tight for (a, b) for every point z′ with |z′ − q| = 1 and |z′ − z| < ρ.
  uses only: B(z′, ρ − |z′ − z|) ⊂ B(z, ρ)
  not claimed: anything at an end of a maximal arc of tight far ends; that such an arc has ends in U
  argument: § Argument — the centre, the straddle, the antipode
  verdict: derived
  grade: hand
  minds: 1
  model: R7 at the origin: the far ends tight for (0, 4) are the open arc of directions (0°, 60°), read as (0.5°, 59.5°) at the control's resolution (control `r7-tight`)
  prior art: owed — a remark on a definition of this milestone
  handoff: none — a relay-result: the object is an arc with ends; the kernel lane needs it only if a later statement is about a maximal arc

derivation: C124-CENTRE
  statement: Let c be a weak k-colouring of an open set U, q and z points of U with |q − z| = 1, and (q, z) tight for (a, b). Then there is η > 0 such that almost every point w of B(q, η) with |w − z| > 1 has a label other than a, and almost every point w of B(q, η) with |w − z| < 1 has a label other than b.
  uses only: C124-SHADOW-OPEN for the two collars; for a point p near q, the point of S(p) on the line through p and z, which lies in the inner collar when |p − z| > 1 and in the outer one when |p − z| < 1
  not claimed: that a or b is present at q (C124-KIND: neither need be); anything about the other labels near q; that this is all a tight pair forces at q — with a second tight far end z′ for the same (a, b) the conclusions intersect, and near q the label a is confined to B̄(z, 1) ∩ B̄(z′, 1), a region with angle π − ∠zqz′ at q
  argument: § Argument — the centre, the straddle, the antipode
  verdict: derived
  grade: derived from: C124-SHADOW-OPEN
  minds: 1
  model: R7 at seven, q the origin, z any point of its ring in directions (0°, 60°), (a, b) = (0, 4): near q the label 0 fills a 120° sector, all of it within 1 of z, and the label 4 is present along one ray only, the cusp at 210°, at distance at least 1 from z (control `r7-tight`: 3,213 samples with the inside label, 27 with the outside label, no violation); at six, 62 unit arcs of FS-112's strip and disk, 58 of kind both (control `maps-tight`)
  prior art: partly: in the map class it is row 138's cone form ("every tile's cone and colour is pinned by the half-planes facing the edges' centres", FS-114) and FS121-DB1's cone lemma on R7 (`tools/fs121_db1_r7cones.py`); as an instance of C132-SHADOW it was matched sign by sign by the asking lane (`plans/POROS-2026-10-07-fs124-question.md` Stage 2); for a weak colouring not found in print (plan §PA)
  handoff: de Bruijn — the statement as written, after C124-SHADOW-OPEN: two inclusions of a half-ball in a set of the form W + S¹

derivation: C124-COMPLETION
  statement: Let c be a weak k-colouring of U, (q, z) tight for (a, b), and w a rhombus completion of the pair lying in U. Then there is η > 0 such that almost every point of B(w, η) has a label other than a and other than b.
  uses only: C124-STRADDLE at p = w, which is one unit from z and is neither q nor 2z − q
  not claimed: that any given label is present at w; that w is an end of a tight pair, or carries more than one label (in R7 it is an interior point of a tile); anything that spends the number of labels; anything special to tight pairs — the conclusion holds beside every interface between two open one-label pieces
  argument: § Argument — the centre, the straddle, the antipode
  verdict: derived
  grade: derived from: C124-STRADDLE
  minds: 1
  model: R7 at seven: the completions of every far end read lie in tiles of the label 3 (control `r7-tight`); at six: 114 completions of the strip's and the disk's unit arcs that lie in the fragments, 2,850 samples, none with a label of its pair (control `maps-tight`)
  prior art: partly: in the map class it is the 60° rule of the ring calculus (G91; FS116-RING-TWIST-C) and the edge exclusion (`[SokolovVoronov2025]` Props. 1–2 by row 134; C132-WITNESS for a region of a weak colouring); posed for a weak colouring by the asking lane; not found in print for a weak colouring (plan §PA)
  handoff: none — subsumed by C124-STRADDLE, which crosses

derivation: C124-STRADDLE
  statement: Let c be a weak k-colouring of U, (q, z) tight for (a, b), and p a point of U with |p − z| = 1, p ≠ q and p ≠ 2z − q. Then there is η > 0 such that almost every point of B(p, η) has a label other than a and other than b.
  uses only: C124-SHADOW-OPEN for the two collars; that two distinct unit circles through z are tangent there only when their centres are equal or symmetric about z, and otherwise cross, each passing from the inside of the other to its outside. Of tightness: that z lies in the closure of both collars and that they lie on the two sides of S(q) near z
  not claimed: a uniform η as p tends to q or to 2z − q (it tends to 0); anything at those two points (C124-CENTRE, C124-ANTIPODE); anything that reads the radius of the interface — for an interface of any shape the statement at a point whose unit circle crosses it is C132-WITNESS's
  argument: § Argument — the centre, the straddle, the antipode
  verdict: derived
  grade: derived from: C124-SHADOW-OPEN
  minds: 1
  model: as C124-COMPLETION's; and as a statement about circles alone: 11,000 points near eleven points one unit from z (10° to 350° round z, the completions at 120° and 240°), every one with its unit circle meeting both collars (control `shadow-geometry`)
  prior art: partly: C132-WITNESS (`plans/FS132-derivation.md` § 2) gives it for a connected open one-label region and a compact piece of its boundary; the map class's edge exclusion; not found in print for a weak colouring
  handoff: de Bruijn — the statement as written; one derivative of a trigonometric function and two uses of C124-SHADOW-OPEN

derivation: C124-ANTIPODE
  statement: Let c be a weak k-colouring of U, (q, z) tight for (a, b), and suppose p = 2z − q lies in U. Then there is η > 0 such that almost every point of B(p, η) has a label other than b, and almost every point w of B(p, η) with |w − q| < 2 has a label other than a.
  uses only: C124-SHADOW-OPEN for the two collars; that S(w) ∩ B̄(q, 1) is an arc whose length tends to 0 as |w − q| tends to 2, and is non-empty with interior exactly when |w − q| < 2; that w ↦ w + (q − w)/|q − w| is continuous
  not claimed: that a is present near p; that the circle of radius 2 about q is an interface there; anything about the points near p at distance more than 2 from q beyond the absence of b
  argument: § Argument — the centre, the straddle, the antipode
  verdict: derived
  grade: derived from: C124-SHADOW-OPEN
  minds: 1
  model: R7 at seven, q the origin, (a, b) = (0, 4): near the points at distance 2 in directions (0°, 60°) no sample carries 4 and none inside the circle of radius 2 carries 0 (control `r7-tight`: 1,080 samples); as a statement about circles, 4,000 points near 2z − q, 2,006 of them inside the circle of radius 2 (control `shadow-geometry`)
  prior art: partly: G85's unit parallels (row 140, for saturated colourings) and row 135's radius-2 configuration (R2) are the map-class neighbours; this statement, for a weak colouring and with no saturation, not found in this project's files by grep of the entries I read, nor in print — owed beyond that
  handoff: de Bruijn — the statement as written; it is the far half of what a tight pair forces and is not posed on the card

### Argument — the unit shadow of an open piece

Put `Ω = {p ∈ U : S(p) ∩ W ≠ ∅}`. If `p + u₀ ∈ W` then `p′ + u₀ ∈ W` for `p′` near `p`: `Ω` is open. Let
`G = {(p, u) : p ∈ Ω, |u| = 1, p + u ∈ W}`, open in `Ω × S¹`; each fibre `G_p` is a non-empty open subset of the circle, of
positive length. The pairs of `G` with `c(p + u) ≠ i` are null (for each `u`, the `p` with `p + u` in the null set `W ∖ c⁻¹(i)`
form a translate of a null set). The pairs with `c(p) = c(p + u)` are null (weak properness: both points are in `U`). Off both,
`c(p) ≠ i`. By Fubini, for almost every `p ∈ Ω` almost every `u ∈ G_p` is off both, and `G_p` is not null; so `c(p) ≠ i` for
almost every `p ∈ Ω`. ∎ (E6's second paragraph, with its set `S` replaced by `Ω`.)

### Argument — the centre, the straddle, the antipode

Throughout, `(q, z)` is tight for `(a, b)` with radius `ρ`, `W_a` and `W_b` are its collars, and by C124-SHADOW-OPEN it suffices
to show that the points named lie in `W_a + S¹`, or in `W_b + S¹`.

*Open.* `B(z′, ρ − |z′ − z|) ⊂ B(z, ρ)`, and the two conditions of tightness restrict to it. ∎

*The centre.* Take `η ≤ 1/2`, `η < ρ`, `B(q, η) ⊂ U`, and `p ∈ B(q, η)`. Put `n = (z − p)/|z − p|` and `m = p + n`, a point of
`S(p)` on the line through `p` and `z`, with `|m − z| = | |z − p| − 1 | ≤ |p − q| < ρ`; and `n·(z − q) = (1 − (p − q)·(z −
q))/|z − p| ≥ (1 − η)/(1 + η) ≥ 1/3`. If `|p − z| > 1`, then `m = z − t n` with `0 < t ≤ η`, and `|m − q|² = 1 − 2t n·(z − q) +
t² ≤ 1 − t(2/3 − 1/2) < 1`: `m ∈ W_a`. If `|p − z| < 1`, then `m = z + t n` with `0 < t ≤ η`, and `|m − q|² = 1 + 2t n·(z − q) +
t² > 1`: `m ∈ W_b`. ∎

*The straddle.* Let `|p − z| = 1`, `p ∉ {q, 2z − q}`, and `x(s) = p + R_s(z − p)`, the point of `S(p)` at angle `s` from `z`.
The function `f(s) = |x(s) − q|² − 1 = |p − q|² + 2(p − q)·R_s(z − p)` is smooth, `f(0) = 0`, and `f′(0) = 2(p − q)·τ = 2(z −
q)·τ`, where `τ = R_{π/2}(z − p)` is the unit tangent of `S(p)` at `z` (and `(p − z)·τ = 0`). The unit vectors `z − q` and
`z − p` are neither equal nor opposite, so `(z − q)·τ ≠ 0`: `f` changes sign at 0. Choose `s₀` with `0 < s₀ < ρ` and `f(s₀)`,
`f(−s₀)` of opposite signs; `|x(±s₀) − z| ≤ s₀ < ρ`, so one of the two points lies in `W_a` and the other in `W_b`. Both sets
are open, so for `p′` close to `p` the points `x(±s₀) + (p′ − p)` of `S(p′)` lie in them still: a ball about `p` lies in
`(W_a + S¹) ∩ (W_b + S¹)`. A rhombus completion is such a `p`: it is one unit from `z`, and it is neither `q` (it is one unit
from `q`) nor `2z − q` (which is two units from `q`). ∎

*The antipode.* Let `p₀ = 2z − q` and `w` near `p₀`, `D = |w − q|`. The arc `S(w) ∩ B(z, ρ)` has length tending to that of
`S(p₀) ∩ B(z, ρ)`, which is positive; the arc `S(w) ∩ B̄(q, 1)` is empty for `D > 2` and has angular length `2 arccos(D/2)` for
`D ≤ 2`, tending to 0 as `D → 2`. So for `w` close to `p₀` the first arc is not inside the second: `S(w)` has a point in
`B(z, ρ)` outside `B̄(q, 1)`, a point of `W_b`. And if `D < 2`, the point `x* = w + (q − w)/D` of `S(w)` has `|x* − q| = D − 1
< 1`, and it tends to `p₀ + (q − p₀)/2 = z` as `w → p₀`; so for `w` close to `p₀` it lies in `B(z, ρ) ∩ B(q, 1) = W_a`. ∎

control: shadow-geometry
  of: C124-STRADDLE — the three computations as statements about circles, no colouring: for sampled points near q, near eleven points one unit from z, and near 2z − q, whether the unit circle meets each collar (ρ = 0.05), against the claims of C124-CENTRE, C124-STRADDLE and C124-ANTIPODE; the fault takes an interface arc of radius 0.9 about q, for which the centre's and the antipode's predicates must fail
  run: python3 ../data/fs124/e1/tight_checks.py geometry
  expect: arc-radius=1.0 centre-samples-far,near=1961,2039 straddle-samples=11000 antipode-samples,inside-radius-2=4000,2006 disagreements=0
  fault: python3 ../data/fs124/e1/tight_checks.py geometry --fault

control: r7-tight
  of: C124-CENTRE — on R7 by formula, at a lattice point: the tight windows of its ring with their label pairs; near the centre, the samples with the inside and the outside label and those on the wrong side; the labels at the completions; the antipode; and which points centre tight arcs — the six ends of the three windows, and six completions of interior far ends. Tight on this model: R7 has no margin. The fault colours the up tiles by n mod 2 only (an improper colouring that keeps the arcs)
  run: python3 ../data/fs124/e1/tight_checks.py r7
  expect: windows=3 (0.5,59.5):0|4 (120.5,179.5):2|5 (240.5,299.5):1|6 centre-samples=9720 with-inside-label=3213 with-outside-label=27 centre-violations=0 completion-labels=[3] completion-violations=0 antipode-samples=1080 antipode-violations=0 ends-centring-tight-arcs=6/6 completions-centring-tight-arcs=0/6
  fault: python3 ../data/fs124/e1/tight_checks.py r7 --fault

control: maps-tight
  of: C124-COMPLETION — the held six-coloured maps, read from their own tiles (FS-112's strip, tiles −4 to 6, and its disk, through `tools/fs116_n1_ring.py`'s loader and `tools/fs116_n3_semi.py`'s two-ray point location): every boundary piece of radius 1 read as a tight pair at its midpoint; C124-CENTRE at its centre; C124-COMPLETION at its two completions. The fault recolours the tile at one completion with the pair's inside label, and reads the centres with the two labels exchanged
  run: python3 ../data/fs124/e1/tight_checks.py maps
  expect: strip: unit-arcs=46 tight=42 centres-in-fragment=42 of-kind-both=38 centre-samples-inside-label,outside-label=1514,1366 centre-violations=0 completions-in-fragment=74 completion-samples=1850 completion-violations=0 ; disk: unit-arcs=20 tight=20 centres-in-fragment=20 of-kind-both=20 centre-samples-inside-label,outside-label=720,720 centre-violations=0 completions-in-fragment=40 completion-samples=1000 completion-violations=0
  fault: python3 ../data/fs124/e1/tight_checks.py maps --fault

control: hex-half-none
  of: C124-CENTRE — where the hypothesis is not met it must not be read as met: on the hexagonal seven-colouring at circumradius 1/2 a vertex's unit circle passes through three vertices and no edge lies on it — no direction of its ring reads as tight; the fault reads R7's ring with the same reader
  run: python3 ../data/fs124/e1/tight_checks.py hexhalf
  expect: colouring=hex7 circumradius=0.5 labels-at-vertex=3 three-label-points-on-its-ring=3 ring-directions=720 tight-directions=0
  fault: python3 ../data/fs124/e1/tight_checks.py hexhalf --fault

**Reading the controls** (what each count is, and what was not read). *The strip*: 46 boundary pieces of radius 1 after
identifying the two tiles' copies; 42 read as tight at their midpoint and 4 not — the four pieces at the two cut ends of the window
(centres `(−2.5, 0)` and `(3, 0)`), where one side is outside the fragment; of the 42, 38 are of kind both and 4 are not — their
centres `(−2, 0)` and `(3.5, 0)` lie on the window's cut, where two of the strip's four labels are read. So row 136's "every unit
arc of kind both" is met at every arc whose centre is inside the window. The loader is FS-112's strip as printed (row 136), not
FS-114's capped strip: its midline vertices are the same points; the caps are not loaded. *The disk*: 20 of 20 tight, 20 of kind
both. *Not run*: fragment T2, the bowtie fragment, FS116-Y2-SIXFRAG and the Searcher's kept model (their loaders were not opened
by this job) — owed, named in the report. *An instrument defect met and repaired on the way*: the first tightness reader took radial offsets of
`10⁻³` with an angular spread of `10⁻³`; on R7 it reported nine windows (the outside label misread within 2° of an arc's end,
where the down tile is a cusp of width `φ²`) and "tight" directions at two of six completions (a boundary merely crossing the
ring). Its 18 centre violations and 324 antipode violations were all from those misreadings; with offsets of `10⁻⁶` and a spread
of `10⁻²` they are 0 and the windows are three. Recorded because the defect flattered nothing and would have been kept if it had
(G21).

### What the datum at a completion is, and whether the completion is again an end of a tight pair

At a rhombus completion `w` of a tight pair `(q, z)` for `(a, b)` the first-order rule forces one thing: a full neighbourhood of
`w` carries neither `a` nor `b` (C124-COMPLETION) — at every number of labels, and with no other content. **That is not a property
of tight pairs.** It holds at every point one unit from `z` whose unit circle crosses the interface (C124-STRADDLE), and the
argument never reads the interface's radius: every interface between two open one-label pieces passes the same absence to every
point whose unit circle crosses it. **The completion is not forced to be an end of a tight pair**: in R7 the completions of the
interior far ends read are interior points of a tile of the single label absent at the centre, and none centres a tight arc
(0 of 6); in C124-KIND's colouring (Stage 5) they are interior points of tiles, and that colouring has one maximal tight arc and
nothing else curved. What tightness itself adds sits at the two points of `S(z)` where the unit circle is tangent to the arc
instead of crossing it: the centre `q`, where each label of the pair is confined to one side of `S(z)` — for an arc, to a wedge of
angle `π` minus the arc's angle — and `2z − q`, where `b` is absent and `a` is absent inside the circle of radius 2 about `q`
(C124-CENTRE, C124-ANTIPODE). **So of the card's three branches, for one tight pair and first-order tools, it is the third:
nothing is forced beyond the first step, and the first step is not special to tight pairs.** **Where the held objects do repeat, read by formula — and it
is not one place.** In R7 each of the six ends of the three windows at a lattice point is a lattice point that centres three
tight arcs (6 of 6; control `r7-tight`). On FS-112's disk 10 of the 40 ends of its unit-arc pieces are centres of unit arcs — the
five sides of the central Reuleaux pentagon — and 30 are not. On FS-112's strip **no** end of a unit-arc piece is a centre of one
(0 of 92; control `maps-ends`): its centres are the midline vertices and its arcs end elsewhere. So "the recurrence sits at the
ends of maximal tight arcs", which the plan's §IQ proposed before the derivation, is R7's shape and the pentagon's, and is
**false of the strip**; neither the completions nor the ends are where every held six-coloured object carries its tight arcs
on. What all three share is at the centre: each centre is of kind both for several arcs at once (three at an R7 lattice point;
"four arcs at each midline vertex of the strip and at each corner of the disk's central Reuleaux pentagon", row 136). Whether
anything is forced at an end, or at a centre, beyond C124-CENTRE is not a first-order statement at any number of labels (at
seven C124-KIND's arc ends at two corners where two labels meet, and its centre carries one label); it is where a count across
classes, or binding (FS-125, FS-128), has to enter. **For the next round**: the unit to pose is the centre with all its tight
arcs — which windows of its ring are tight, for which ordered pairs, against which cones of presence (C124-CENTRE gives the
polarity; C124-SIX is its first count) — and the first reading owed is the strip's: where its arcs end, and what those ends are
one unit from.

control: maps-ends
  of: C124-OPEN — the ends of the tight arcs on the held six-coloured maps: for every boundary piece of radius 1 of FS-112's strip and disk, whether its two end points are centres of boundary pieces of radius 1; the fault shifts every end point by 0.01
  run: python3 ../data/fs124/e1/tight_checks.py ends
  expect: strip: unit-arc-pieces=46 ends=92 ends-that-centre-a-unit-arc=0 ; disk: unit-arc-pieces=20 ends=40 ends-that-centre-a-unit-arc=10
  fault: python3 ../data/fs124/e1/tight_checks.py ends --fault

**Predictions scored.** P2 — met on all four parts (C124-CENTRE and C124-COMPLETION as posed; C124-STRADDLE; C124-ANTIPODE).
P3 — met on both parts as registered (nothing forced at interior completions; R7's ends 6 of 6, completions 0 of 6). **The §IQ
assessment's (a) — "if anything recurs it is at the ends" — is wrong beyond R7**: the strip's ends centre nothing (0 of 92). Its
(b), the polarity at a centre, is C124-CENTRE's *not claimed* line made positive, and is what the three held objects share.

**Stage 4 — SAVED** (2026-10-07).

## Stage 5 — SAVED: C124-KIND, C124-SIX, C124-HALF

derivation: C124-KIND
  statement: There is a weak measurable seven-colouring of the plane, by formula, with a tight pair (q, z) for (a, b) at which neither a nor b is present at q.
  uses only: the hexagonal seven-colouring at circumradius 2/5 (hexagon about m(2√3/5, 0) + n(√3/5, 3/5) coloured (m + 3n) mod 7) and the cap K = {(x, y) : x > √3/5, |(x, y) − q| < 1} with q = (√3/5 − 60/61, 0), recoloured 0; the Pythagorean triple (11, 60, 61); comparisons of rationals and of √3, √21 with rationals
  not claimed: anything at six; that a tight pair with neither label present at its centre occurs in any weak six-colouring; that the colouring is saturated or honest; that the margin is what the construction uses — it does not (the same cap on the honeycomb at circumradius 1/2 is a weak seven-colouring too)
  argument: § Argument — the capped honeycomb
  verdict: derived
  grade: hand
  minds: 1
  model: the colouring itself: (q, z) with z = q + (1, 0) is tight for (0, 1); the tight far ends are the open arc of half-angle arcsin(11/61) ≈ 10.39° about z (196 of 3,600 directions at the reader's spread); only the label 6 is read at q, and the labels 2 and 4 at the two completions; of 200,000 sampled unit pairs none is monochromatic (control `kind-cap`)
  prior art: partly: G95's local slack at seven (EXT-OAI2 § 4.3, islands and stripes in the hexagonal seven-colouring) is the neighbouring construction; a unit arc planted in it not found in this project's files or in print — owed beyond the plan's §PA
  handoff: de Bruijn — only with a consumer: a calibration; the formal content is four inequalities and one inclusion

derivation: C124-SIX-CONES
  statement: In the setting of C124-SIX, there is η > 0 such that almost every point of B(q, η) with a label among a, b, a′, b′ lies in a closed set that is the union of at most four regions, each bounded near q by two unit circles through q meeting at the angle π/3, or reduced to {q}.
  uses only: C124-CENTRE at the six pairs; that three unit vectors 120° apart sum to 0, and that every direction is within 60° of one of them
  not claimed: that any of the four labels is present at q; that the four regions are disjoint beyond q; anything for far ends that are not 120° apart
  argument: § Argument — three half-planes
  verdict: derived
  grade: derived from: C124-CENTRE
  minds: 1
  model: the count itself, as a pattern: over the eight sign patterns of three tight pairs 120° apart the inside label's region has angle 0° at q when the three agree and 60° when they do not (control `six-cones`); no colouring meeting C124-SIX's hypothesis is held at any number of labels
  prior art: partly: the asking lane's count (`tools/fs124_p1_cones.py`; `plans/POROS-2026-10-07-fs124-question.md` § 1.3), there with the step from discs to directions asserted; in the map class the cone calculus of FS-116 (G91); not searched in print — owed
  handoff: none — subsumed by C124-SIX, which crosses

derivation: C124-SIX
  statement: Let k ≥ 4, U an open set containing the closed unit disc about q, c a weak k-colouring of U, ψ an angle, z_j = q + e(ψ + jπ/3) for j = 0, …, 5, and a, b, a′, b′ four distinct labels such that for j = 0, 2, 4 the pair (q, z_j) is tight for (a, b) or for (b, a), and for j = 1, 3, 5 the pair (q, z_j) is tight for (a′, b′) or for (b′, a′). Then a label other than a, b, a′, b′ is present at q.
  uses only: C124-SIX-CONES; that a direction strictly outside a region's tangent cone leaves the region at once or for all small radii; that finitely many labels share a set of positive measure in every ball
  not claimed: that the configuration exists at any k — no held object meets the hypothesis, and none was built; which label the fifth one is, or that five suffice; anything when the six pairs use three or more label pairs (R7's centres: three windows, three disjoint pairs, no orbit of six tight far ends)
  argument: § Argument — three half-planes
  verdict: derived
  grade: derived from: C124-SIX-CONES
  minds: 1
  model: none satisfying every hypothesis is known at any number of labels; the statement may hold of an empty class. What is exhibited is the count (control `six-cones`: four labels cover at most 240° of 360°), and its failure when the far ends are 90° apart (the fault: 360°)
  prior art: partly: as C124-SIX-CONES; the statement is the asking lane's hunch `four-labels-cannot-centre-six-tight-pairs`
  handoff: de Bruijn — after C124-CENTRE: three linear inequalities per label and a positive-measure cone; read the formal statement back against "present at q"

derivation: C124-HALF
  statement: In the setting of C132-COMP-SHARP (plans/FS132-derivation.md § 4), suppose exactly one of the six sets, K_0, a set of x with labels t_0, t_1, is contained in the unit circle about the common unit point w, and at least two of the three sets of y have a point strictly inside the unit circle about w. Then, after exchanging the names t_0, t_1 if need be, there is η > 0 such that almost every point of B(w, η) outside the unit circle about y has the label t_1 if it lies inside the unit circle about x and the label t_0 if it lies outside it.
  uses only: C132-WIT-SIDE (`plans/FS132-derivation.md` § 2; [hand], one mind, inherited — statement read, argument not) at w for x's sets K_1, K_2 and for two sets of y; that two edges of a triangle carry its three labels; that the unit circles about x and y cross at w (0 < |x − y| < 2), so each of the four quadrants at w is a non-empty open set; that six labels are all the labels
  not claimed: that a label of y is present at w; anything inside the unit circle about y; that the class is inhabited at six (no held object meets the hypothesis); that (x, w) is a tight pair — it is tight on one side of the unit circle about y only
  argument: § Argument — the half
  verdict: derived
  grade: hand
  minds: 1
  model: none is known: in fragment T2 three of the six sets lie on that circle and in the Searcher's kept model two (the card's reading, `plans/STUB-q-ring.md` § The first claims; not re-read by me). What is exhibited is the count: of the nine side patterns of K_1 and K_2 two leave a label in both quadrants outside S(y), with one label each (control `half-sides`)
  prior art: partly: in the map class row 135's rhombus lemma (FS112-N3-COR3); in measure it is C132-CROSS's count run with one set on the circle, posed as C132-ARC and by the asking lane; not searched in print — owed
  handoff: de Bruijn — after C132-WIT-SIDE's module: a case split on the sides of two sets

*Correction, dated 2026-10-07 (filed by FS-124's record job, FS124-Z1; source:
`data/fs124/reports/FS124-E2.md`, INVENTORY, "correction owed" — the second deriver's drafted line, verbatim):* "2026-10-07
(FS124-E2): fragment S1 meets the hypothesis, its set on the circle being the single point x; the conclusion holds there and
carries no arc (plans/FS124-E2-derivation.md, C124-LONE-EXISTS)." It corrects four places that stand above and below: this
entry's *not claimed* clause "that the class is inhabited at six (no held object meets the hypothesis)"; its *model* line's "none
is known"; "No held object meets C124-HALF's hypothesis" in § Theorems this phase proved; and "No held object meets its
hypothesis" in Stage 5's "Read against the card". The entry's statement, verdict, grade and count of minds are unchanged.

derivation: C124-HALF-TWO
  statement: In the setting of C132-COMP-SHARP, if exactly K_0 and one set K′_0 of y, with labels t′_0, t′_1, are contained in the unit circle about w, x's two other sets have points strictly on opposite sides of that circle, and y's two other sets have points strictly on opposite sides of that circle, then almost every point near w has one of the four labels t_0, t_1, t′_0, t′_1.
  uses only: C132-WIT-SIDE at w for the four other sets; that six labels are all the labels
  not claimed: which of the four labels lies in which quadrant beyond C124-HALF's reading on each side; that any of the four is present at w; that K_0 and K′_0 are tight arcs
  argument: § Argument — the half
  verdict: derived
  grade: hand
  minds: 1
  model: the card names the Searcher's kept model at w = y_1 (labels 1234, the two third labels absent; control `kept-model` of `plans/FS132-derivation.md` § 2 prints those labels); its opposite-sides hypothesis was not read off the model by me — owed
  prior art: partly: as C124-HALF
  handoff: none — subsumed by C124-HALF's module (the same case split)

### Argument — the capped honeycomb

Let `r = 2/5`, `ap = √3 r/2 = √3/5` (the hexagons' inradius), `H(m, n)` the closed hexagon about `m(2ap, 0) + n(ap, 3r/2)`, and
`d = 60/61`, `s = 11/61`, `h = 1/61` (`d² + s² = 1`). The cap `K` lies beyond the edge `x = ap`, `|y| ≤ r/2` of `H(0, 0)`: its
chord has half-length `s < 1/5 = r/2` and its height is `h`; so `K ⊂ H(1, 0)`, of colour 1. Recolour `K` with 0.
*Colour 0 stays proper.* For a vertex `P` of `H(0, 0)` the vector `q − P` has negative first coordinate (the largest is
`2ap − d < 0`, as `2√3/5 < 60/61`), so on the arc `x = q + e(θ)`, `|θ| ≤ arcsin s`, the distance `|x − P|` is largest at an end
of the arc — a point of the chord, in `H(0, 0)`. Distance being convex, `H(0, 0) ∪ K` has the hexagon's diameter, `4/5 < 1`.
Two hexagons of one colour have centres at least `√21 r` apart, so every other hexagon of colour 0 is farther than
`√21 r − 2r − h` from `H(0, 0) ∪ K`, and that exceeds 1 (`21 · 4/25 > (554/305)²`). The other classes only shrink.
*The pair.* `z = q + (1, 0) = (ap + h, 0)`. For `ρ ≤ h`, `B(z, ρ) ∩ B(q, 1) ⊂ K` (label 0) and `B(z, ρ) ∖ B̄(q, 1)` lies in the
interior of `H(1, 0)` off `K̄` (label 1). *The centre.* `q` is at distance `3ap − d ≈ 0.056 < ap` from the centre of
`H(−1, 0)`, of colour 6: only 6 is present at `q`. ∎ At `r = 1/2` every line holds with "diameter 1", and two points of a hexagon
at distance exactly 1 are opposite vertices: a null set of pairs. So the cap is a weak seven-colouring there too.

### Argument — three half-planes

Take `η` at most the six radii of C124-CENTRE and put `e_j = z_j − q`. For a label `ℓ` of the pair at `z_j`, almost every point
`q + δ` of `B(q, η)` with label `ℓ` has `2δ·e_j ≥ |δ|²` if `ℓ` is the inside label there (`|δ − e_j| ≤ 1`) and `2δ·e_j ≤ |δ|²` if
it is the outside label. Fix `ℓ = a`; `j` runs over `0, 2, 4` and `e_0 + e_2 + e_4 = 0`. *Inside at all three*: adding,
`0 ≥ 3|δ|²`, so `δ = 0`. *Outside at all three*: some `e_j` is within 60° of `δ`, so `2δ·e_j ≥ |δ| > |δ|²` for `0 < |δ| < 1`:
again `δ = 0`. *Inside at two, `e_i`, `e_j`*: the region lies in `{δ·e_i ≥ 0, δ·e_j ≥ 0}` to first order — bounded by the unit
circles about `z_i` and `z_j`, which meet at `q` at the angle `π/3` — and a direction with `δ·e_i < 0` leaves it at once.
*Inside at one, `e_l`, outside at `e_i`, `e_j`*: the region lies between the unit circles about `z_i` and `z_j` on the side
`{δ·e_i ≤ 0, δ·e_j ≤ 0}` to first order, again of angle `π/3`, and a direction with `δ·e_i > 0` leaves it for all radii below
`2 δ̂·e_i`. The same for `b`, and for `a′`, `b′` with `j = 1, 3, 5`. So the four regions have tangent cones of total angle at
most `4π/3`; a closed cone of directions of positive angle lies strictly outside all four, and on it, within a small ball, almost
every point has a label outside `{a, b, a′, b′}`. That set has positive measure in every ball about `q`; the labels being
finitely many, one of them has positive measure in every ball about `q`. ∎

### Argument — the half

Outside `S(y)` near `w`: each of the two sets of `y` with a point strictly inside `S(w)` excludes its two labels there
(C132-WIT-SIDE with centre `y`), and two edges of a triangle carry its three labels; so almost every point there has a label
among `t_0, t_1, t_2`. `K_1` (labels `t_1, t_2`) and `K_2` (labels `t_2, t_0`) are not contained in `S(w)`. A set with a point
strictly inside `S(w)` excludes its labels outside `S(x)` near `w`; with a point strictly outside, inside `S(x)`. If `K_1` and
`K_2` both had a point strictly inside, all of `t_0, t_1, t_2` would be excluded on the quadrant outside `S(x)` and outside
`S(y)`, a non-empty open set: impossible. Likewise both outside. A set with points on both sides excludes its labels on both
quadrants, and then the other set empties one of them. So one of them lies in the closed disc with a point strictly inside and
the other in the closed complement with a point strictly outside. If it is `K_1` inside: outside `S(x)` only `t_0` is left,
inside `S(x)` only `t_1`. If it is `K_2`: the same with the names exchanged. ∎ *Two sets.* `x`'s two other sets on opposite sides
exclude `t_2` on both sides of `S(x)` near `w`, `y`'s exclude `t′_2` on both sides of `S(y)`: four labels are left. ∎

control: kind-cap
  of: C124-KIND — the capped honeycomb at circumradius 2/5 and at 1/2: the four exact comparisons, the tight pair and its window read by formula, the labels at the centre and at the completions, sampled unit pairs; the fault is circumradius 3/5 (tiles of diameter 6/5: not a weak colouring)
  run: python3 ../data/fs124/e1/tight_checks.py kind
  expect: cap:height=1/61,half-chord=11/61(2*asin=20.78deg) ; circumradius=2/5: cap-inside-edge=True enlarged-tile-diameter=4/5 weakly-proper-by-margins=True centre-inside-opposite-tile=True tight-pair=(0, 1) tight-directions=196/3600 labels-at-centre=[6] labels-at-completions=[2, 4] monochromatic-of-200000-unit-pairs=0 ; circumradius=1/2: cap-inside-edge=True enlarged-tile-diameter=1 weakly-proper-by-margins=True centre-inside-opposite-tile=True tight-pair=(0, 1) tight-directions=196/3600 labels-at-centre=[6] labels-at-completions=[2, 4] monochromatic-of-200000-unit-pairs=0
  fault: python3 ../data/fs124/e1/tight_checks.py kind --fault

control: six-cones
  of: C124-SIX-CONES — the angle at q of the region left to the inside label by three tight pairs 120° apart, over the eight sign patterns, read on the true regions at radius 10⁻⁴; the fault puts the far ends 90° apart
  run: python3 ../data/fs124/e1/tight_checks.py cones
  expect: angle-between-far-ends=120 equal-signs=[0, 0] mixed-signs-widths=[60] most-covered-by-two-pairs=240 of 360
  fault: python3 ../data/fs124/e1/tight_checks.py cones --fault

control: half-sides
  of: C124-HALF — the nine side patterns of x's two other sets (strictly inside, strictly outside, both) against the labels left on the two quadrants outside S(y); the fault leaves one label of y there (only one of y's sets with a point strictly inside S(w))
  run: python3 ../data/fs124/e1/tight_checks.py half
  expect: side-patterns=9 consistent=2 K1=in,K2=out:inside-x=t1;outside-x=t0 K1=out,K2=in:inside-x=t0;outside-x=t1
  fault: python3 ../data/fs124/e1/tight_checks.py half --fault

*A wording change in C124-HALF-TWO, for the claim list*: the card's "and `y`'s two other sets likewise" is written out ("have points
strictly on opposite sides of that circle") — the same hypothesis; the gate reads "likewise" as a scope rider.

**Read against the card.** *C124-KIND*: true, and for a reason the card's control did not expect — "the same arc at circumradius
`1/2` must be refused by the check" is false of the object: there the cap is still a weak seven-colouring. The honeycomb at 1/2
is tight at its vertices only; its edges have room. So "of kind both" is a hypothesis at seven even on that model, and R7 is the
model with no room. *C124-SIX*: derived as posed, and it says less than its wording in one respect — its class has no known
member at any number of labels, so it excludes nothing held; a member at seven or more by formula, or a first-order reason none
exists, is owed (the report's construction request). *C124-HALF*: derived as posed; its conclusion is half a tight pair `(x, w)`
— tight on the side of `S(y)` away from `y` — reached from exclusion sets with no open piece assumed; C124-SHADOW-OPEN then
applies to the two open quadrant pieces it produces. No held object meets its hypothesis.

**Predictions scored.** P4 — met (and at 1/2 too, against the card's control). P5 — met on both parts (derived as posed; says
less than its wording: an uninhabited class). P6 — met. P7 — met as registered (C124-SIX is a first-order statement that
forbids six unit arcs about ring points at a four-label centre), with the caution that it bounds a configuration nobody has
exhibited: G97's line is crossed by a statement, not yet by an object.

**Stage 5 — SAVED** (2026-10-07).

## Stage 6 — SAVED: the second prior-art pass, the INVENTORY, and where a successor takes over

**The second §PA pass** (13:26 UTC, in the words the recognition gave; listings in `data/fs124/e1/pa/zb-log.txt`).
`(ab:"Minkowski sum" | ab:"parallel curve" | ab:"parallel set" | ab:"offset curve") & (ab:"unit distance" | ab:"distance-avoiding" |
…| ab:"chromatic number of the plane")` — 1 hit, off the object (crossing numbers of Hamming graphs). `(ab:"ball-polar" | ab:"ball
polar" | ab:"spindle convex") & (ab:coloring | ab:colouring | ab:"chromatic" | ab:"distance graph" | ab:"diameter graph")` — 0. It
added nothing; no paper was opened by either pass. The gate's items 4, 5, 7, 8 (outside arXiv, the citation graph of the paper
that posed the question, two databases, author listings) were not done and are debts.

**Where a successor takes over.** Every claim of the list is at a verdict. What is owed, in the order of bearing:
1. *The strip's ends* — the reading the paragraph of Stage 4 names: where FS-112's strip's unit arcs end, how many labels meet
   there, and which centres those ends are one unit from (`tools/fs116_n1_ring.py`'s loader; `tight_checks.py ends` is the start).
2. *The controls not run*: fragment T2 and the bowtie fragment (`tools/fs110_y_fragments.py`), FS116-Y2-SIXFRAG, FS-114's capped
   strip's caps, and the Searcher's kept model for C124-COMPLETION, C124-SIX ("must not fire": three consecutive ring points
   only) and C124-HALF-TWO at `w = y_1` — `maps` in `tight_checks.py` takes any loader that yields tiles with arc pieces.
3. *An inhabitant of C124-SIX's hypothesis*, at seven labels or more, by formula — or a first-order reason none exists.
4. *The next round's statement*: at a centre, the tight windows of its ring with their ordered pairs against the cones of
   presence (C124-CENTRE's polarity), and what six labels allow — posed by the asking lane, not by this job.

**Stage 6 — SAVED** (2026-10-07).
