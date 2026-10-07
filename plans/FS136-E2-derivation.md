# FS136-E2 — the second round: the table run forward: the record

*FS136-E2 (Ephodos), 2026-10-07 (UTC). Brief `data/fs136/briefs/FS136-E2-forward.md`; the card `plans/STUB-covering-pairs.md`
§ The question, second round; the claim list `data/fs136/claims.md` (its last dated block); the first round's record
`plans/FS136-E1-derivation.md`; working files `data/fs136/e2/`. **Every statement below is about a weak colouring that has
the named corners (its seed); no entry says that a weak six-colouring has a piece, a corner or a seed, and none is known to
have one.** Nothing here fixes or bears on the value of the chromatic number of the plane.*

## Theorems this phase proved

*(one line per theorem, with its grade and its address in this file; one mind each; kernel pending; filled as the stages are
saved)*

- **C136-CORNERS** — [hand] — Stage 2: unit circles through a point cut `2m` connected corners there; two share all their
  sides only as the two horns outside two circles tangent at the point.
- **C136-CLASS** — [hand] — Stage 2: inner, outer or crossing is betweenness in the cyclic order of curves by direction and
  signed curvature.
- **C136-FORCED** — [hand] over C136-TABLE and C136-CORNERS — Stage 2: a corner at `w` on which the pieces at the points one
  unit away bar every label but one is a piece of that label; two adjacent forced corners of different labels meet along a
  member's unit circle.
- **C136-CLOSE** — derived from C136-FORCED — Stage 3: a colouring that has a set of labelled corners has its forced closure
  in the open set, and the closure empties no corner. **A closure is a family of germs at isolated points, never a region.**
- **C136-CLOSE-R7** — computed, exact in ℚ(√3) — Stage 3: two adjacent lattice points of the tight seven-colouring force
  three corners and no more.
- **C136-CLOSE-FLOWER** — computed, exact in ℚ(√3, √7) — Stage 4: the flower's pair forces six corners at two points in the
  fragment's disc (eight at three in the plane) and no more.
- **C136-CLOSE-STRIP** — computed, exact in ℚ(√3, √5) and one extension — Stage 5: two four-label points of the strip force
  ten corners at six points and no more; the first round's pair of three-label points forces nothing.
- **C136-STOP-GERMS** — derived from C136-CLOSE with exact signs — Stage 6: the strip's, the disk's and the bowtie fragment's
  stops are excluded for every weak six-colouring that keeps the parts of the named tiles within any `r > 0` of the two members.
- **C136-COLLAR** — derived from C136-FORCED — Stage 8: a point whose corners carry all labels but one forces the missing
  label on a one-sided collar of every open arc of its unit circle along which none of its own labels is pure on that
  side — a region of definite length and no definite width. Inhabited at six by the bowtie fragment's two five-label points.
- **C136-STOP-GERMS-RADIUS** — [hand] over C124-SHADOW-OPEN — Stage 6: at all three the corner outside both members' unit
  circles is closed to the colouring's domain within `c·r` of the point — first order, the bowtie fragment included.

## Notation used by every entry

`S(p)` is the unit circle about `p`, `B(p, r)` the open disc. A *weak `k`-colouring*, a *piece*: `data/fs136/claims.md`
§ Definitions. A *family of pieces at `x`*, a label *inner-pure*, *outer-pure*, *barred at `w`*: the same file, "Added by
this plan" (FS136-E1's). **Added by this round** (Stage 1, § The statements): a *corner*, a *labelled corner*, *has*, a
corner *inner*, *outer* or *crossing at `w`*, *the corners at `w` cut by* finitely many unit circles, *forces*, *empties*,
*the forced closure in `U`*.

## Stage 0 — SAVED: the readback, and the grokkings walked again from inside the new unit

### 0.1 The readback

**Quotations.** `data/fs136/e2/quote_check.py` (the first round's script, the brief's path changed): the brief's 14 block
quotations against their sources — `quotations=14 mismatches=0`, exit 0 (`data/fs136/e2/quote_check.out`); with one
character of the first altered, `mismatches=1`, exit 1 (`quote_check.fault.out`). No mismatch.

**Read, and how far.** Whole: the brief; `plans/STANDING-RULES.md`; the card's section (stub ll. 167–318) and the stub's
head; the first round's record (all seven stages); the asking lane's record (Stages 0–4); the claim list's definitions and
its first-round block; the plan's readback, §G, §IQ and § The claims; `plans/FS124-derivation.md` § 2 (C124-SHADOW-OPEN,
C124-TYPE) and § 5 (C124-SIX, C124-SIX-CONES) at their entries; C124-TYPE's argument (`plans/FS124-E2-derivation.md`
§ Argument — one piece, one side); `plans/FS132-E3-derivation.md` § The coordinator's question (the paragraph, whole);
`plans/STUB-seed-remainder.md` question 3; `plans/FS132-derivation.md` § 1's step table (ll. 85–122); the first round's
reader and checker (`data/fs136/e1/rings_read.py`, `stop_check.py`) and `tools/fs114_yb_exact.py` ll. 1–300 and its `Tile`.
Read at a statement only: nothing else. **Not read**: the map entries the claim list names for "placing"
(FS116-RING-TRANSFER-QC, -N3-SEMI, -N2-STAR, -N2-RECIP) — cited as the asking lane read them; the asking lane's reader
`data/fs136/p1/germs_read.py` (its outputs are quoted from its record); `RUNNING.md` beyond § Make the gate fail.

**What the job is, in my words.** A finite family of labelled *corners* — a point, two curves from it, a label, meaning that
the colouring has that label almost everywhere between the curves near the point. Seen from a point `w` one unit away, a
corner bars its label on one side of its own point's unit circle, or on both. The unit circles about the family's points
through `w` cut a neighbourhood of `w` into corners; where all labels but one are barred on one of them, that corner is
almost all the one label — a new labelled corner, at `w`. Three claims: that step; the least family closed under it, and
its value on three seeds, the tight seven-colouring first; and three of the first round's exclusions with corners in
place of whole tiles.

### 0.2 Three findings about the brief and the card, before any derivation

1. **The card's third seed is not an object of the strip as worded.** "(c) the strip — the six tiles of a covering pair at
   one of its 34 three-label coloured points": read from the first round's own output (`data/fs136/e1/out/strip.txt`, 105
   pair lines with a point inside): the 34 three-label coloured points are the common unit points of pairs of
   **four-label** members (distances `0.5` and `1.0`; eight tiles), and the 71 points of pairs of three-label members (six
   tiles) carry four labels with two labels left in every cell — "0:71 3:34" in the asking lane's own count. So the seed
   with singleton cells has eight corners, and the six-tile seed has none. **Both are run** (Stage 5): (c1) the eight
   corners at `(0, 0)` and `(1/2, 0)`; (c2) the six corners at `(−1/4, √15/4)` and `(1/2, √3/2)`, the first round's pair.
2. **The prior-art paragraph, read at its source.** `plans/FS132-E3-derivation.md` ll. 513–515: "**(a)** a region near a ring
   point in which the transfer (⋆) leaves one label, so the colouring is forced there". It is the forward step **in the
   palette calculus** (supports and states at the hubs of one ring), used inside C132-M-ORBIT's argument (M3–M5, "every hub
   has a tip"; `plans/FS132-derivation.md` l. 102: the kernel planner reached "a forced label inside the ring from strips"
   blind) and never entered as a statement. C124-SIX-CONES confines four labels to regions bounded by unit circles through a
   point for tight pairs — a confinement, with no label forced. Searched by file (`rg -i` for "forced label", "is forced
   there", "leaves one label", "only one label", "exactly one label", "single label", "the remaining one" in
   `plans/FS107-`, `FS110-`, `FS112-`, `FS114-`, `FS116-`, `FS124-` and `FS132-derivation.md`): three hits, all
   `FS132-derivation.md` ll. 80, 102, 116 (that step), and one control line of C124-HALF. **So the forward step is held as a
   step inside one argument about palettes, and for pieces it is not held**: the card's failure clause ("already held")
   does not fire; each *prior art* line says "partly".
3. **The coordinator's question (where does the forced cell's connectedness come from) has an answer that changes two
   statements** — Stage 1: a cell is one connected corner except in one configuration (two members antipodal about `w`,
   the cell outside both: two horns); and the thing that is forced is a germ, with a radius no statement bounds below, so
   the closure is a family of corners at isolated points and never a region.

### 0.3 §G — the grokkings walked again from inside the new unit (a seed, and what it forces)

*The unit changed between the plan's §G (a point across of a covering pair) and this round (a finite family of labelled
corners and its closure under one step), so the walk is redone, every entry by its body.*

**Bears** (what it says about a seed and its closure, and what it changes here):

- **G96** (ball data and circle data; the one free passage is a connected piece of definite size) — the forced step is the
  first passage from ball data at two points to ball data at a third, and what it yields has **no definite size**: its
  radius is half the least witness depth of the bars used. *Instruction (C136-CLOSE)*: define the closure on germs — what
  every radius has — and say in its *not claimed* line that nothing of definite size is forced.
- **G13** (coverage is a `k`-set property; a gap frees) — a forced corner is coverage with exactly one label left, read
  per corner; a corner with two labels left is the gap at which propagation stops. *Instruction (C136-FORCED)*: state the
  step per corner, not per pair; list free corners with their labels.
- **G84** (contact: classes are carved by unit circles about their own points), **G90** (the sagitta: second order is
  where the plane's curvature enters) — a corner tangent at its point to the unit circle about `w` is classed by the
  curvature of its edge, not by its cone; and two adjacent forced corners of different labels meet along an arc of a
  member's unit circle. *Instruction*: the class of a corner is read from direction **and** curvature (2-jets), exactly;
  the radius law of the third claim is first order or second order by which of the two decides a bar.
- **G86** (count labels, not tiles) — a label is barred at a member as soon as one of its corners there is on the wrong
  side; purity is over all corners of the label.
- **G54** (tight forces, slack only permits gaps) and **G95** (plant the seven-colouring) — R7 is tight at seven, and the
  stub's table expects "tightness at seven is rigid from two points". *Falsifiable here, registered (Q2)*: the corner
  closure of two adjacent lattice points of R7 stalls after three corners; tightness of the colouring is not rigidity of
  the closure.
- **G91** (the ring's change points place four-colour vertices) with **G99** (the local theory with pieces is the map
  class's; name the map entry) — for maps a forced step is *placing*; the claim list names FS116-RING-TRANSFER-QC, -N3-SEMI,
  -N2-STAR, -N2-RECIP. *Instruction (every verdict)*: the *prior art* line names them (as the asking lane read them) and
  FS-132's step; G91's Do — "ask whether the type is inhabited: the structure that pins it is usually its kill" — is the
  empty corner to look for first when a closure runs. **G99's killing test is in play**: C136-FORCED is the asking lane's
  candidate for "a local statement in the piece class with no map antecedent that changes a move".
- **G92** (a held result reaches as far as its argument; search the derivation files) — C136-FORCED is C136-TABLE's argument
  read for the half two *not claimed* lines declined; the search is § 0.2 item 2.
- **G97 as amended** (pieces at named points; no weak six-colouring is known to have them) — every headline says so.
- **G21** (a zero measures its enumeration) — "the closure stalls" is a statement about which points and which bars were
  enumerated. *Instruction*: the headline of each computed closure says *corners, not whole tiles*, the open set, and that
  points with one member are covered (a member with at least `k − 1` labels is scanned along its whole unit circle).
- **G82** (price a certificate at its feature's scale) — an empty corner in a closure of germs would exclude the seed's
  two vertex figures from every weak colouring of any open set containing the finitely many points of the chain: a
  certificate with no scale. Registered (Q5).
- **G79** (the example's invariant) — the closure is what every colouring with the seed carries, by construction.
- **G93** — the class: weak measurable colourings. **G87** — lookout kept; § Stage 1 logs one whiff.

**Silent**: G1–G12, G14–G20, G22–G29, G31–G45, G48, G52, G53, G55–G66, G68–G71, G73–G78, G80, G81, G83 (the first round
found its vertex is an index), G85, G88, G89, G94, G98; and the retired pointers G30, G46, G47, G49, G50, G51, G67, G72.

**What the re-walk changed.** (1) The closure is defined on corners (germs), with the radius said to be unbounded below
(G96, G90). (2) The forced step is stated per corner, with a lemma on how unit circles through a point cut it (G13). (3) A
prediction against "tight is rigid" is registered on R7 (G54). (4) The class of a corner is decided by direction and
curvature, exactly, which is what makes each closure a finite exact computation (G84).

### 0.4 Registered predictions (before any computation; each with the decision it bears on)

- **Q1** — C136-FORCED derived, with the corner lemma added and its second sentence restated: **0.95**. *Decides*: whether
  the closure is posed on corners.
- **Q2** — R7's pair: no corner emptied **0.99**; the closure is the twelve seed corners and exactly three more — the
  Reuleaux corner at the up apex and two 60° wedges at the down apex — and then stalls: **0.8**. *Not blind*: worked by
  hand before the script was written. *Decides*: whether a second round of the script's loop is ever entered at seven.
- **Q3** — the flower's pair: all four corners at `(−1, −1)` forced `0, 1, 0, 1` **0.9**; a forced corner at a further
  point **0.85** (not blind: at `(−1 + √3/2, −1/2)` worked by hand — label 4 outside the unit circle about `e(180°)`);
  the closure still adding corners after four rounds **0.3**. *Decides*: the stop rule of the flower's run.
- **Q4** — the strip: (c1) forces three corners at each common unit point **0.9** and reaches a third point with a forced
  corner **0.5**; (c2) forces nothing inside the strip **0.85**.
- **Q5** — an empty corner in a closure of corners, at a point other than the seed pair's two common unit points, on any
  six-coloured seed tried: **0.15**. *Decides*: a message at once.
- **Q6** — C136-STOP-GERMS: all three stops emptied by corners **0.95**; every bar first order on the strip and the disk
  **0.85**; on the bowtie fragment some label barred only at second order in each emptied corner **0.8**.

## Stage 1 — SAVED: recognition (`ephodos-recognition`, invoked fresh) on the three claims; the statements

**The stall read.** *A result proved only at instances*: forty entries of two milestones read pieces somebody keeps and
conclude an exclusion; the forward half of their own head statement is declined twice. *A known theorem that almost
applies*: C136-TABLE gives a label almost everywhere on a cell; "a piece" asks for a connected set, and "a member at the
next point" asks for a class that does not depend on a radius nobody controls. *A wall that describes a counterexample*,
flipped (G79): what every colouring with a seed carries.

**For a stranger** (someone who works on constraint satisfaction, and a geometer beside them). *Given*: an open set `U` of
the plane, `k` labels, a measurable labelling of `U` in which almost no two points at distance 1 share a label; and
finitely many **labelled corners** — a point `x`, two curves from `x` (each a ray or a circular arc), a label `a` — each
meaning: for some `ρ > 0` the open region between the curves within `ρ` of `x` has the label `a` almost everywhere.
*Unknown*: the other labelled corners the labelling must then have. *Condition*, one fact: an open set almost all of one
label bars that label at almost every point whose unit circle meets it. From a point `w` one unit from `x`, the unit circle
about a point `z` near `w` passes near `x`, and whether it meets the corner at every radius depends only on the side of
`S(x)` on which `z` lies and on whether the corner lies inside `S(w)`, outside it, or on both sides. So the corners at the
points one unit from `w` give each of the `2m` corners cut at `w` by those points' unit circles a set of barred labels;
where `k − 1` are barred the corner has the last one almost everywhere; repeat. Words the reader would stop at — "piece",
"member", "cell", "covering pair", "seed", "pure" — are struck or defined from these.

**"This is a …", and the homes, each tested.**

1. *This project's own.* (a) C136-TABLE: the step is its statement read on a cell — one line, as the card says. (b) For
   maps, *placing* (G91). (c) FS-132's M3–M5 (§ 0.2 item 2). Dictionary: a tile's vertex figure ↔ the labelled corners at a
   point; a placed tip ↔ a forced corner; a change point of a ring ↔ two adjacent forced corners of different labels.
   **Adopted** for the step; its changed step is named below.
2. *Inversion at the point; an arrangement of lines* (elementary geometry). Invert in the unit circle about `w`: the unit
   circles through `w` about `x_1, …, x_m` become `m` lines at distance `1/2` from `w`, the inside of `S(x_i)` the far
   half-plane, and a small punctured disc about `w` the outside of a large one. So the corners at `w` are the **ends at
   infinity of an arrangement of `m` lines tangent to one circle**: `2m` of them, each connected, each with one sign
   vector; two ends share a sign vector exactly when they are the two ends of the strip between two parallel lines and
   there is no third line. The same inversion at a member `x` turns every edge of a corner there, and `S(w)`, into
   half-lines, whose cyclic order at infinity is by direction and then by offset — the offset is half the edge's
   curvature. **It predicts a neighbour**, checked by hand and by the engine: the cell outside two unit circles tangent at
   `w` is two horns, not one piece — the flower's horn. **Adopted**: it is the description under which "the cell is a
   piece" and "inner, outer or crossing" are forced, and it is why a closure is exact arithmetic on directions and
   curvatures.
3. *Constraint propagation* (the card's home; recalled, not read — nothing below rests on more than the two lines of
   C136-CLOSE's argument). The closure is the least fixed point of a monotone step that reads finitely many facts at a
   time, hence the union of its finite stages and independent of the order of steps. **Adopted, with the facts named
   exactly**: a fact is a labelled corner — a germ — and not a region.
4. *Forced tiles: the empire of a patch* (tiling theory; recalled, not read; a dictionary only). It predicts what
   §IQ (5) of the plan already says in other words: a patch can be locally consistent and extend to no tiling. Kept as a
   word for the stranger; killed as a deciding home — its theorems are about tilings by copies of finitely many tiles.

**The features, sorted** (each with its receipt):

| feature | sort | receipt |
|---|---|---|
| each kept piece connected, its point in its closure | determines | C124-TYPE's path (first round, Stage 1) |
| the forced set is a *cell* (one choice of sides) | **splits** | the label conclusion needs no connectedness; "is a piece" needs a connected set: a cell is one corner except outside two unit circles tangent at `w`, where it is two (home 2) |
| the radius of a kept piece | **splits** | a bar needs a point strictly on the wrong side at the radius kept; the corner's class is what every radius has; a larger radius can turn *inner* or *outer* into *crossing* and never the reverse (the asking lane's scan: 2,990 of 34,200 triples, one way; `Σ_ρ′ ⊂ Σ_ρ` for `ρ′ < ρ`) |
| the radius of the forced piece | **accompanies — and is not bounded below** | `η` is half the least witness depth of the bars used: of the order of the kept radius at a transversal witness, of its square at a tangential one |
| "the pair's labels are all six" | splits | consumed as "every label but one is carried, and barred, by a corner at a point one unit from `w`": a label carried by none is never barred, so the points one unit from a forced corner carry at least `k − 1` labels between them |
| two members | accompanies | any `m ≥ 1`; with `m = 1` the one member carries at least `k − 1` labels |
| six | accompanies | any `k`; R7 at seven is the control |
| the seed is the tiles of a held object | accompanies | only each corner's two edges at its point (direction and curvature) and its label are read |
| the order of the steps | accompanies | C136-CLOSE's argument: a monotone step on finite subsets |
| the open set `U` | determines | the step is taken at points of `U` only: the argument needs a ball about `w` in `U` |

**The transfer.** Home 1 (a): C136-TABLE, read (first round, § 3.1 and its argument). Its hypotheses here: pieces at the
members — a labelled corner the colouring has gives a piece `Σ_ρ` for every small `ρ` (C136-CORNERS, by home 2); `w ∈ U`.
**The changed step, named**: "a label almost everywhere on a cell" becomes "a labelled corner at `w`" by home 2 — the cell
is one or two corners — and the class of that corner at the next point is the germ's, which no radius changes
(C136-CLASS). **The remaining step is not the problem renamed**: after the transfer a closure is a finite exact
computation per round.

**The class.** Any `k`; any `m ≥ 1`; corners bounded by rays and circular arcs of any radii. The label conclusion of the
step holds for any pieces (C136-TABLE's class); the closure is stated for corners.

**Where this differs from the card's picture — three findings.**

1. **A closure is a family of germs at isolated points, never a region.** Each forced corner is had at *some* radius,
   which shrinks at every step and is bounded below by nothing in the statement. A closure "that closes round a ring with
   no cell empty and none free" is therefore a finite set of vertex figures — what `plans/SEARCH-QUEUE.md` line 15 calls a
   labelled skeleton, "a design, not a colouring" — and **not** "a six-coloured fragment given by formula from its seed".
   The stub's existence form ("whose forced closure fills a neighbourhood of every point of the closed disc of radius 2")
   cannot be met by the closure of a finite seed unless some member carries at least `k − 1` labels and forces along a
   whole arc of its unit circle (the only step that reaches a continuum of points): at six with members of three or four
   labels, never from the seed alone. This re-poses the card's third branch; it is the asking lane's to re-word.
2. **The fixpoint is order-free, as the coordinator's framing says, and it is so only on germs.** With whole tiles as
   pieces the forced pieces are still germs, and a kept tile can bar more than its corner does (extent adds bars), so "the
   closure of six tiles" is the closure of their corners plus the extra bars of the seed's whole tiles at each point — a
   larger family, well defined, and not the same object. The three computed closures are of corners; where a seed's whole
   tiles would add a bar the record says so.
3. **Growth needs labels.** A corner is forced only at a point whose members carry at least `k − 1` labels between them,
   and a forced corner carries one. So a closure runs only where label-rich points stay within one unit: the seed's own
   points, and points that have gathered several forced corners.

**An invention signal?** One whiff, logged without picking a side: the stub's table row "on R7 at seven the closure
reproduces R7 near the seed … tightness at seven is rigid from two points" against the hand computation behind Q2 (the
closure of two adjacent lattice points is fifteen corners and stalls). If Stage 3 confirms Q2 these are not two truths:
the first is an expectation, and it falls. Reported in the inventory either way.

### The statements, as the verdicts will be about them (sent to the coordinator before any derivation)

**Added by this round.** Let `x` be a point and `γ₁ ≠ γ₂` two curves from `x`, each a ray from `x` or an arc of a circle
starting at `x`. For `ρ > 0`, `Σ_ρ(x; γ₁, γ₂)` is the set of points of `B(x, ρ) ∖ {x}` strictly between `γ₁` and `γ₂`,
counter-clockwise from `γ₁`. A **corner at `x`** is such a pair of curves; a **labelled corner** is a corner with a label.
A weak `k`-colouring `c` of `U` **has** the labelled corner `(x; γ₁, γ₂; a)` if for some `ρ > 0` the set `Σ_ρ` lies in `U`
and almost every point of it has the label `a`. For `|w − x| = 1` a corner at `x` is **inner at `w`** if `Σ_ρ` lies in the
closed unit disc about `w` for some `ρ > 0`, **outer at `w`** if `Σ_ρ` misses the open unit disc about `w` for some
`ρ > 0`, and **crossing at `w`** otherwise. For distinct points `x_1, …, x_m` (`m ≥ 1`) one unit from `w`, **the corners at
`w` cut by `S(x_1), …, S(x_m)`** are the `2m` corners at `w` between cyclically consecutive branches at `w` of those
circles. A finite set `F` of labelled corners **forces** `(w, Σ, ℓ)` if `Σ` is a corner at `w` cut by the unit circles
about the points of `F` one unit from `w` (there is at least one), and every label other than `ℓ` is the label of a corner
of `F` at such a point `x` that is not inner at `w` when `Σ` is inside `S(x)`, and not outer at `w` when `Σ` is outside
`S(x)`; `F` **empties** `Σ` if every label is. The **forced closure in `U`** of a set `𝒮` of labelled corners is the
least set of labelled corners that contains `𝒮` and every `(w, Σ, ℓ)` with `w ∈ U` forced by a finite subset of it.

**C136-CORNERS (added; a lemma).** *Let `w` be a point and `x_1, …, x_m` (`m ≥ 1`) distinct points with `|x_i − w| = 1`.
There is `ρ₀ > 0` such that for every `0 < ρ ≤ ρ₀` the disc `B(w, ρ)` less `w` and the circles `S(x_i)` is the disjoint
union of `2m` connected open sets, each with `w` in its closure and each lying inside or outside each `S(x_i)` — the sets
`Σ_ρ` of the `2m` corners at `w` cut by those circles; and two of them lie on the same side of every `S(x_i)` exactly when
`m = 2`, `x_1 + x_2 = 2w`, and they are the two outside both circles.* *Not claimed*: anything about a colouring; a value
of `ρ₀`.

**C136-CLASS (added; a lemma).** *Let `Σ = (x; γ₁, γ₂)` be a corner and `w` a point with `|w − x| = 1`. Order the curves
from `x` that are rays or circular arcs cyclically, counter-clockwise by direction at `x` and, for one direction, by
signed curvature (positive when the centre is to the left). Let `β₋`, `β₊` be the two branches of `S(w)` at `x`, `β₋` the
one whose counter-clockwise neighbours are inside `S(w)`. Then `Σ` is inner at `w` exactly when `β₋ ≤ γ₁ < γ₂ ≤ β₊` in that
order counted from `β₋`, and outer at `w` exactly when `β₊ ≤ γ₁ < γ₂ ≤ β₋` counted from `β₊`.* *Not claimed*: anything for
edges that are not rays or circular arcs; a depth for the points a corner that is not inner has strictly outside `S(w)`
(it is of the order of `ρ` when an edge direction is transversal to `S(w)` on the wrong side, and of `ρ²` when the wrong
side is reached only along an edge tangent to `S(w)`).

**C136-FORCED (the card's C-FORCED; its conclusion on a piece, its second sentence made exact).** *About weak colourings
that have the named pieces; no weak six-colouring is known to have one. Let `c` be a weak `k`-colouring of an open set `U`,
`w` a point of `U`, `x_1, …, x_m` (`m ≥ 1`) distinct points with `|x_i − w| = 1`, `𝒫_i` a family of pieces at `x_i`, `Σ` one
of the corners at `w` cut by `S(x_1), …, S(x_m)`, and `ℓ` a label such that every label other than `ℓ` is a label of some
`𝒫_i` that is not inner-pure at `w` for `𝒫_i` if `Σ` is inside `S(x_i)`, and not outer-pure at `w` for `𝒫_i` if `Σ` is
outside `S(x_i)`. Then there is `η > 0` such that `Σ_η` is a connected open subset of `U` with `w` in its closure and
almost every point of `Σ_η` has the label `ℓ`: `c` has the labelled corner `(w, Σ, ℓ)`. If two such corners, with labels
`ℓ ≠ ℓ′`, are adjacent along a branch `β` of some `S(x_i)`, then for some `η > 0` the set `Σ_η ∪ Σ′_η ∪ (β ∩ B(w, η))` is
open, almost every point of it on one side of `S(x_i)` has the label `ℓ`, and almost every point of it on the other side
the label `ℓ′`.* *Not claimed*: that a weak colouring has a piece; that `ℓ` is itself unbarred on `Σ` — if every label is
barred the conclusion holds for two labels at once and no such colouring exists (the first round's exclusions); a lower
bound for `η` (it is half the least witness depth of the bars used, and shrinks at every step); anything on a corner where
two or more labels are unbarred; anything where fewer than `k − 1` labels are carried by the families (a label of no family
is never barred); that the forced piece reaches beyond `B(w, η)`, is a tile of anything, or has `ℓ` everywhere and not
almost everywhere; in the second sentence, that the two pieces are all there is near `w`. *Restates*: for maps a forced
step is placing (G91; FS116-RING-TRANSFER-QC, -N3-SEMI, -N2-STAR, -N2-RECIP, as the claim list names them); for palettes
at the hubs of a ring it is a step of C132-M-ORBIT's argument (M3–M5); for pieces: not found.

**C136-CLOSE (the card's C-CLOSE: the statement).** *About weak colourings that have the seed; no weak six-colouring is
known to have one. Let `c` be a weak `k`-colouring of an open set `U` that has every labelled corner of a set `𝒮`. Then `c`
has every labelled corner of the forced closure of `𝒮` in `U`, and no finite subset of that closure empties a corner at a
point of `U`. The closure is the union of the sets `𝒮_0 = 𝒮`, `𝒮_{n+1} = 𝒮_n ∪ {(w, Σ, ℓ) : w ∈ U, forced by a finite
subset of 𝒮_n}`.* *Not claimed*: that a weak colouring has the seed; any radius — a corner of the closure is had at some
`ρ > 0` that depends on `c` and is not bounded below along the closure, so **no region of definite size is forced, and a
closure all of whose corners at every point reached are forced is a set of vertex figures, not a coloured fragment**; a
converse — a seed whose closure empties no corner need not be had by any colouring; the bars of extent — a whole tile can
be crossing where its corner is inner, and those bars are not in the closure of the corners; that the closure of a finite
seed is finite. *Restates*: as C136-FORCED.

**C136-CLOSE-R7, C136-CLOSE-FLOWER, C136-CLOSE-STRIP (the card's seeds; computed).** Each: *the forced closure in the named
open set of the named corners is exactly the listed family; it empties no corner; at every point one unit from two or more
points of the closure, and along the unit circle of every point of it that carries at least `k − 1` labels, the corners
are forced, free or — at seed points — parts of the seed's own corners, as listed.* The seeds: **R7** — the twelve corners
of the tight seven-colouring at the lattice points `(0, 0)` and `(1, 0)`, in the plane; **the flower** — the seven corners
of FS116-Y2-SIXFRAG at `e(180°)` and `e(270°)`, in the open disc of radius `3/2`; **the strip** — (c1) the eight corners of
FS-112's strip at `(0, 0)` and `(1/2, 0)`, (c2) the six at `(−1/4, √15/4)` and `(1/2, √3/2)`, in the strip. *Not claimed*,
each: what C136-CLOSE does not claim; anything about the closure of the seed's whole tiles; that the object is the only
colouring with the seed.

**C136-STOP-GERMS (the card's C-STOP-GERMS).** *About weak six-colourings that keep the named parts of one held object's
tiles; none is known to. For every `r > 0` there is no weak six-colouring of an open set that contains the point `w` and
the parts within distance `r` of their members of the named tiles, and gives almost every point of each part its label in
the object — for (a) FS-112's strip, `w = (1/4, √15/4 + √3/2)`, the members `(−1/4, √15/4)`, `(1/2, √3/2)` and the six
tiles of C136-STOP-STRIP; (b) the disk, with `w`, the members and the six tiles of C136-STOP-DISK; (c) FS114-Y2-BOWTIE,
`w = (√3, 0)`, the members `q₂`, `q₁` and the eight tiles of C136-STOP-BOWTIE.* *Not claimed*: what those three entries do
not claim; any exclusion of a colouring that does not keep these parts; a value of the chromatic number of the plane.
**C136-STOP-GERMS-RADIUS (its radius law, a second statement).** *In (a) and (b) there are `r₀ > 0` and `c > 0` such that
for every `0 < r ≤ r₀` almost every point within `c·r` of `w` of one of the corners at `w` cut by the two members' unit
circles would have none of the six labels; in (c) the same within `c·r²`.* *Not claimed*: the best constants; that in (c)
no larger ball can be had from other pieces.

*The coordinator's answer to the statements (relayed after Stage 1 was saved; FS-136 inventory item 10), read before going
on: the statements are fixed in the claim list as sent; finding 1 is accepted — a closure that closes up is a finite
skeleton of corners and is announced to nobody as a fragment; one "at once" clause is kept from my own exception: a label
forced along an arc of positive length. **How it changes the work**: nothing in its order; every run below prints
`arc-forced`, and it is `0` in all of them.*

## Stage 2 — SAVED: the engine; C136-CORNERS, C136-CLASS, C136-FORCED

### 2.1 The engine (`data/fs136/e2/closure.py`; its header is its specification)

A curve at a point is a direction and a signed curvature; a corner is two curves; the class of a corner at a point one unit
away is betweenness in the cyclic order of curves (C136-CLASS); the table at `w` cuts the `2m` corners there and bars labels
on each. **Every decision is an exact sign** in a tower of quadratic fields (`tools/fs114_yb_exact.py`, imported, not
edited; the brief keeps `tools/` out of this job's files, so the engine is under `data/fs136/e2/`). Added: `sqrt_in`, an
exact test of whether a number is a square in the current tower, so that the common unit points of two points are computed
without adjoining a root that is already there. Floats are used to pre-filter (then confirmed exactly), to print, and in
two controls that run on **another code path**: every class the tables use is re-read by sampling the corner at two radii
(`class-samples … mismatches=0` in every line below), and every forced corner inside an object is sampled against the
object's own colour function (`agree-with-object`). **A defect of my first sampler, repaired before any count was kept**
(G21): it took no sample hugging a corner's edges, so a half-plane bounded by rays tangent to the far circle read "inner"
in floats where the exact class is crossing (the tangent ray is outside at second order); two edge samples were added and
the self-test's fourth case is that corner.

### 2.2 The three entries

derivation: C136-CORNERS
  statement: Let w be a point and x_1, …, x_m (m ≥ 1) distinct points with |x_i − w| = 1. There is ρ₀ > 0 such that for every 0 < ρ ≤ ρ₀ the disc B(w, ρ) less w and the circles S(x_i) is the disjoint union of 2m connected open sets, each with w in its closure and each lying inside or outside each S(x_i) — the sets Σ_ρ of the 2m corners at w cut by those circles; and two of them lie on the same side of every S(x_i) exactly when m = 2, x_1 + x_2 = 2w, and they are the two outside both circles.
  uses only: inversion in S(w) — a unit circle through w goes to a line at distance 1/2 from w and its inside to the half-plane beyond that line; that outside a disc holding every crossing point of m distinct lines their complement is 2m connected regions, one between each two cyclically consecutive ends; that a cell of a line arrangement is convex and that a convex set with two ends at infinity contains a line
  not claimed: anything about a colouring; a value of ρ₀
  converse: § Converse — two corners on the same sides
  argument: § Argument — the corners at a point
  verdict: derived
  grade: hand
  minds: 1
  model: w = (0, 0) with the members (1, 0), (−1, 0) — four corners, two of them outside both circles; with (1, 0), (0, 1) — four corners with four different sides; with all three — six with six (control `corners-selftest`, its last three cases); and R7 at (1/2, √3/2) seen from (0, 0) and (1, 0): corners of 120°, 60°, 120°, 60° (`data/fs136/e2/out/r7.txt`)
  prior art: known: elementary plane geometry (inversion at a common point of circles; the unbounded cells of an arrangement of lines); no source read, and nothing rests on one
  handoff: none — the kernel's statement of C136-FORCED can be on the cell (the points on the chosen sides), which needs no connectedness; this lemma crosses only with a consumer of "is a piece"

derivation: C136-CLASS
  statement: Let Σ = (x; γ₁, γ₂) be a corner and w a point with |w − x| = 1. Order the curves from x that are rays or circular arcs cyclically, counter-clockwise by direction at x and, for one direction, by signed curvature (positive when the centre is to the left). Let β₋, β₊ be the two branches of S(w) at x, β₋ the one whose counter-clockwise neighbours are inside S(w). Then Σ is inner at w exactly when β₋ ≤ γ₁ < γ₂ ≤ β₊ in that order counted from β₋, and outer at w exactly when β₊ ≤ γ₁ < γ₂ ≤ β₋ counted from β₊.
  uses only: inversion in the unit circle about x — a ray from x goes to its own far part, a circle of radius R through x to a line at distance 1/(2R) from x, so a curve of direction d and signed curvature κ goes to the end in direction d of the line at signed offset κ/2 to the left of d; that outside a large disc finitely many half-lines with distinct (direction, offset) are disjoint and lie in the cyclic order of (direction, offset); that the closed unit disc about w goes to a closed half-plane whose far part lies between the ends β₋ and β₊
  not claimed: anything for edges that are not rays or circular arcs; a depth for the points a corner that is not inner has strictly outside S(w) (it is of the order of ρ when an edge direction is transversal to S(w) on the wrong side, and of ρ² when the wrong side is reached only along an edge tangent to S(w))
  converse: § Converse — a corner that is not between the branches
  argument: § Argument — the class of a corner
  verdict: derived
  grade: hand
  minds: 1
  model: x = (0, 0), w = (1, 0): the quarter-planes about the directions 0° and 180° are inner and outer; the right half-plane is crossing (its edges are rays tangent to S(w), outside it at second order); the horn between S(w) and the unit circle about (−1, 0) is outer; the horn between S(w) and a circle of radius 1/2 inside it is inner (control `corners-selftest`, eleven cases, each read exactly and by samples)
  prior art: known: elementary (order of contact of circles at a common point); for maps the cone calculus of FS-116 reads directions only and says "tangent" where this reads curvature (first round, Stage 1, last row of its table); no source read
  handoff: none — it is what makes a table a finite exact computation; the kernel needs it only if a computed closure is to be checked there

derivation: C136-FORCED
  statement: About weak colourings that have the named pieces; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U, w a point of U, x_1, …, x_m (m ≥ 1) distinct points with |x_i − w| = 1, 𝒫_i a family of pieces at x_i, Σ one of the corners at w cut by S(x_1), …, S(x_m), and ℓ a label such that every label other than ℓ is a label of some 𝒫_i that is not inner-pure at w for 𝒫_i if Σ is inside S(x_i), and not outer-pure at w for 𝒫_i if Σ is outside S(x_i). Then there is η > 0 such that Σ_η is a connected open subset of U with w in its closure and almost every point of Σ_η has the label ℓ: c has the labelled corner (w, Σ, ℓ). If two such corners, with labels ℓ ≠ ℓ′, are adjacent along a branch β of some S(x_i), then for some η > 0 the set Σ_η ∪ Σ′_η ∪ (β ∩ B(w, η)) is open, almost every point of it on one side of S(x_i) has the label ℓ, and almost every point of it on the other side the label ℓ′.
  uses only: C136-TABLE (`plans/FS136-E1-derivation.md` § 3.1; [hand] over C124-TYPE, one mind — inherited; its argument read whole) for the same members and families; C136-CORNERS for "connected, with w in its closure" and for "open"; that Σ lies on one side of every S(x_i). Not consumed: the number of labels; that the families' labels are all the labels (only that every label but ℓ is carried and barred); |x_i − w| = 1 beyond what C136-TABLE reads
  not claimed: that a weak colouring has a piece; that ℓ is itself unbarred on Σ — if every label is barred the conclusion holds for two labels at once and no such colouring exists (the first round's exclusions); a lower bound for η (it is half the least witness depth of the bars used, and shrinks at every step); anything on a corner where two or more labels are unbarred; anything where fewer than k − 1 labels are carried by the families (a label of no family is never barred); that the forced piece reaches beyond B(w, η), is a tile of anything, or has ℓ everywhere and not almost everywhere; in the second sentence, that the two pieces are all there is near w
  argument: § Argument — a corner with one label left
  verdict: derived
  grade: hand
  minds: 1
  model: at seven, R7: for each of the 54 pairs of lattice points less than 2 apart in a window and each of their 108 common unit points, the table from the pair's twelve corners — 432 corners, 141 of them with one label left, and at every one of the 432 the labels left are exactly the labels R7 has there (control `forced-r7-window`: "viol=0 … forced_wrong=0 exact=432"); at six, FS116-Y2-SIXFRAG at (−1, −1): four corners with one label left, 0 inside the unit circle about e(270°) and 1 outside — the interface is that circle (`data/fs136/e2/out/flower.txt`); FS-112's strip at (1/4, √15/4): three corners with one label left (`out/strip1.txt`)
  prior art: partly: for palettes at the hubs of one ring it is a step inside C132-M-ORBIT's argument, never an entry (`plans/FS132-E3-derivation.md` ll. 513–515: "a region near a ring point in which the transfer (⋆) leaves one label, so the colouring is forced there"; `plans/FS132-derivation.md` l. 102); for maps a forced step is placing (G91; FS116-RING-TRANSFER-QC, -N3-SEMI, -N2-STAR, -N2-RECIP, named by the claim list and not read by me); for pieces: declined twice (C124-FOUR and C136-ONE, their *not claimed* lines) and not found in the seven derivation files (Stage 0.2 item 2); print: zbMATH, four queries in the recognition's words (`data/fs136/e2/pa/zb.out`): "ab:"constraint propagation" & (ab:"chromatic number of the plane" | ab:"unit distance" | ab:"unit-distance")" (0), "(ab:"forced" | ab:"forcing") & ab:colo* & ab:plane & (ab:"unit circle" | ab:"unit distance") & (ab:region* | ab:tile* | ab:tiling*)" (1: a conference volume, Zbl 1271.05002, title only), "(ab:"local rule*" | ab:"vertex figure*" | ab:"empire*") & ab:colo* & (ab:"unit distance" | ab:"chromatic number of the plane")" (0), "ab:"chromatic number of the plane" & (ab:measurable | ab:"map-type" | ab:"map type") & (ab:"propagat*" | ab:"extend*" | ab:"extension")" (0) — not found
  handoff: de Bruijn — on the cell, not the corner: "for the set C of points on the chosen side of each S(x_i): almost every point of C ∩ B(w, η) has the label ℓ" is three lines over `ae_onSide_of_label` at each member (a point of C off the null sets has a label pure on C's side at every member carrying it); read the hypothesis back against "every label but ℓ is a label of some family that is not pure on C's side", not "of some piece"; the corner form (connected, w in its closure) needs C136-CORNERS and crosses only with a consumer

**Class**: every weak `k`-colouring of an open set; any finite set of points one unit from `w`, each with a finite family of
pieces; any `k`. **Verdict on the claim as posed**: derived — and **restated in two places**: "the cell" is one of the
corners cut at `w` (a cell is one corner, or two: the horns outside two unit circles tangent at `w`), so that the
conclusion is a piece; and the second sentence says where the two labels are (the union of two adjacent corners and the
arc between them, not "near `w` on one side of the arc", which takes in other corners). **What is new beyond the held
entries**: for maps nothing to state (a map has tiles at `w`); against C136-TABLE: the half its *not claimed* line left —
a region where none was kept; against FS-132's step: pieces in place of palettes, any members, any `k`, an entry.
**What it does not do**: give a colouring a first piece. **Side**: neither; the instrument of C136-CLOSE.

### Argument — the corners at a point

Let `ι` be the inversion in `S(w)`. A circle `S(x_i)` passes through `w`, so `ι` carries it (less `w`) onto the line
`ℓ_i = {y : (y − w)·(x_i − w) = 1/2}`, its open disc onto the open half-plane beyond `ℓ_i`, and its outside (less `w`) onto
the open half-plane holding `w`. The `x_i` are distinct unit vectors from `w`, so the `ℓ_i` are `m` distinct lines, all
tangent to the circle of radius `1/2` about `w`. Let `R₀` exceed the distance from `w` of every crossing point of two of
them, and `ρ₀ = 1/R₀`. For `R ≥ R₀` each line meets `{|y − w| > R}` in two half-lines (its ends), the `2m` ends are disjoint,
and they cut `{|y − w| > R}` into `2m` regions, one between each two cyclically consecutive ends; each is connected and
unbounded, and lies on one side of every `ℓ_i` (no line enters it). `ι` carries `{|y − w| > R}` onto `B(w, 1/R) ∖ {w}` and is a
homeomorphism: the `2m` images are connected, open, have `w` in their closures, and are the sets `Σ_{1/R}` of the corners
between consecutive branches. ∎

### Converse — two corners on the same sides

If `m = 2` and `x_1 + x_2 = 2w`, the lines `ℓ_1`, `ℓ_2` are parallel, on opposite sides of `w`; the strip between them is the
image of the outside of both circles, and far out it has two ends: two corners outside both. Conversely let two different
corners lie on the same side of every `S(x_i)`. Their images lie in one cell of the arrangement (a cell is the set of
points with given sides, an intersection of half-planes, convex) and are two different ends of it; a convex set with two
ends at infinity contains a line, so every `ℓ_i` is parallel to that line; lines tangent to one circle and parallel to one
direction are at most two; so `m = 2` (with `m = 1` a line has one end on each side), the two are parallel, `x_1 − w = −(x_2
− w)`, and the cell is the strip, which holds `w`: the outside of both circles. ∎

### Argument — the class of a corner

Let `ι` be the inversion in the unit circle about `x`. A ray from `x` in the direction `d` goes onto its own part beyond
distance `1/ρ`. A circle of radius `R` through `x` goes onto the line at distance `1/(2R)` from `x` on the side of its
centre, and its branch leaving `x` in the direction `d` onto the end of that line in the direction `d`. So a curve from `x`
of direction `d` and signed curvature `κ` (`0` for a ray, `±1/R` as the centre is to the left or right of `d`) goes onto
**the end in the direction `d` of the line at signed offset `κ/2` to the left of `d`**. Outside a large disc, half-lines with
different (direction, offset) are disjoint, and counter-clockwise they come in the order of direction and, for one
direction, of offset (parallel half-lines pointing one way are ordered by their offset to the left). So `ι(Σ_ρ)` is, for
small `ρ`, the region outside the disc of radius `1/ρ` from the end of `γ₁` counter-clockwise to the end of `γ₂`. The closed
unit disc about `w` (less `x`) goes onto the closed half-plane `H = {y : (y − x)·(w − x) ≥ 1/2}`, whose boundary line has the
two ends `β₋` (direction `w − x` turned by `−90°`, offset `+1/2`) and `β₊` (turned by `+90°`, offset `−1/2`), and whose far part
is the closed region from `β₋` counter-clockwise to `β₊`. If `β₋ ≤ γ₁ < γ₂ ≤ β₊` counted from `β₋`, the region from `γ₁` to `γ₂`
lies in the region from `β₋` to `β₊`: `ι(Σ_ρ) ⊂ H` for small `ρ`, and `Σ` is inner. The outer case is the same with the
closed complement of the open half-plane, from `β₊` to `β₋`. ∎

### Converse — a corner that is not between the branches

Suppose the order `β₋ ≤ γ₁ < γ₂ ≤ β₊` fails. Then the open region from `γ₁` to `γ₂` and the open region from `β₊` to `β₋` — the
far part of the complement of `H` — are two regions between ends of one cyclic order whose intervals of ends overlap, so
they meet outside every disc: every `Σ_ρ` has a point strictly outside `S(w)`, and `Σ` is not inner. The same with the
roles exchanged shows that a corner not between `β₊` and `β₋` is not outer. ∎ *Read off it, used below*: a corner that is not
inner has a point strictly outside `S(w)` at every radius (that is its definition), and for `ρ′ < ρ` the set `Σ_ρ′` lies in
`Σ_ρ`, so a larger radius can add a point on the wrong side and never remove one.

### Argument — a corner with one label left

C136-TABLE, for the members `x_i` and the families `𝒫_i`, gives `η₁ > 0` and a null set `N` such that every `z` of
`B(w, η₁) ∖ N` has a label that is inner-pure at `w` for every `𝒫_i` carrying it with `|z − x_i| < 1`, and outer-pure for every
one with `|z − x_i| > 1`. Let `η` be the least of `η₁`, the `ρ₀` of C136-CORNERS, and a radius with `B(w, η) ⊂ U`. Take
`z ∈ Σ_η ∖ N` and `a = c(z)`. If `a ≠ ℓ`, then `a` is a label of some `𝒫_i` that is not pure at `w` on the side of `S(x_i)` on
which `Σ` — hence `z` — lies: against the table. So `c(z) = ℓ`. By C136-CORNERS `Σ_η` is connected and open with `w` in its
closure, and it lies in `U`. For the second sentence take the smaller of the two radii: `Σ` and `Σ′` are adjacent ends in
the picture of that lemma, so with the open half-line between them their union is open; they lie on the two sides of
`S(x_i)`, and the arc between them is null. ∎

control: corners-selftest
  of: C136-CLASS — the arithmetic (four roots: in the field, a nested one, a new one, a product) and the classifier on eleven corners at (0, 0) seen from (1, 0), each read exactly and by samples — quarter-planes, the half-plane with tangent edges, the disc's own corner, three horns between tangent circles, two horns between circles of radius 1/2 and 2 and the unit circle — and C136-CORNERS on three arrangements (antipodal: two corners outside both; a right angle; three members). Tight: seven of the eleven are decided by curvature alone. The fault orders curves by direction only
  run: python3 ../data/fs136/e2/closure.py selftest
  expect: selftest: 18 of 18 OK
  fault: python3 ../data/fs136/e2/closure.py selftest --fault=bend

control: forced-r7-window
  of: C136-FORCED — at seven, on the tight colouring R7 (no margin anywhere): the 54 pairs of lattice points less than 2 apart in the window −1 ≤ m, n ≤ 2, their 108 common unit points, the 432 corners cut there; for each corner the labels the pair's twelve corners leave, against the labels of R7's own corners that meet it, exactly: viol = a label R7 has there is barred (it would refute C136-TABLE or the engine); forced_wrong = one label left and R7 has another or more; exact = the labels left are exactly R7's. The fault (the card's plant: one more bar) reads the first corner of each pair as crossing wherever it is inner
  run: python3 ../data/fs136/e2/closure.py window
  expect: r7 window: pairs=54 points=108 corners=432 viol=0 forced=141 forced_wrong=0 exact=432 empty=0 class-samples=1296 mismatches=0
  fault: python3 ../data/fs136/e2/closure.py window --fault=bar

**Predictions scored.** Q1 — **met** (0.95). The asking lane's "C-FORCED derived as posed 0.9" — derived, restated in two
places; "found already held under another name 0.2" — **partly**: held as a step about palettes inside one argument, not
for pieces.


*Corrections, dated 2026-10-07 (20:41 UTC; filed by the coordinator; source: the kernel planner's second look at the three entries of this
stage and of Stage 8 that had no second derivation — its record `plans/FS136-kernel-plan.md` on branch `fs136-wk1`, § 4.2 —
made after its own routes to the same statements were committed blind; FS-136 inventory items 22–24). "All three stand as
written. What each leaves implicit", copied by script:*

- **C136-FORCED / C136-CORNERS**: "they cut `{|y − w| > R}` into `2m` regions, one between each two cyclically consecutive ends; each is connected" is asserted, and is the whole count. And `R₀` "exceeding the distance from `w` of every crossing point" is vacuous when no two lines cross (`m = 1`; two tangent circles): `R₀ > 1/2` is needed as well — with two tangent circles and `ρ > 2` the outside of both is one region. The statement ("there is `ρ₀`") is not affected.
- **C136-CLASS**: that ends with different (direction, offset) are disjoint and so ordered far out is asserted (my leaf `CurveGerm.exists_forall_angle_lt`); the converse's "the intervals overlap, so the regions meet outside every disc" uses that between two germs there is a third (curvature is a real number). The tie the statement turns on — an edge of `β₋`'s direction and curvature below `1` is the last counted from `β₋` — is right (§ 2.3 item 8).
- **C136-COLLAR**: it reads of `A` only that it is a connected subset of `S(x) ∩ U`, of `F` only that its corners give pieces at `x`. "Shrink `η_w` so that `H_w` is connected" is free inside and a real step outside (the part of a small disc outside a unit circle through its centre is not convex): leaf `isPreconnected_ball_diff_closedBall`. "Their pieces `Σ_ρ`, for small `ρ`" cites C136-CORNERS' picture, which is about unit circles through the point; that a corner between two arbitrary rays or arcs is open and connected for small `ρ` is a separate statement: leaf `exists_isPieceShape_cornerSet`.

*No statement changes and no grade moves: each entry is one mind's, with a second look by a mind whose routes were
committed first. The count of `2m` corners in C136-CORNERS rests on the asserted sentence quoted above; the forward step
does not read it (the planner's route proves only that each corner reaches the point).*

## Stage 3 — SAVED: C136-CLOSE, and the closure of two adjacent lattice points of the tight seven-colouring

derivation: C136-CLOSE
  statement: About weak colourings that have the seed; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U that has every labelled corner of a set 𝒮. Then c has every labelled corner of the forced closure of 𝒮 in U, and no finite subset of that closure empties a corner at a point of U. The closure is the union of the sets 𝒮_0 = 𝒮, 𝒮_{n+1} = 𝒮_n ∪ {(w, Σ, ℓ) : w ∈ U, forced by a finite subset of 𝒮_n}.
  uses only: C136-FORCED at each step, with the pieces Σ_ρ of the corners c has (connected for small ρ: C136-CORNERS' picture at a member); that a corner which is not inner at w has, at every radius, a point strictly outside S(w); that the step reads a finite subset and that a larger family forces whatever a smaller one does; that a corner Σ_η has positive measure
  not claimed: that a weak colouring has the seed; any radius — a corner of the closure is had at some ρ > 0 that depends on c and is not bounded below along the closure, so no region of definite size is forced, and a closure all of whose corners at every point reached are forced is a set of vertex figures, not a coloured fragment; a converse — a seed whose closure empties no corner need not be had by any colouring; the bars of extent — a whole tile can be crossing where its corner is inner, and those bars are not in the closure of the corners; that the closure of a finite seed is finite
  argument: § Argument — the closure
  verdict: derived
  grade: derived from: C136-FORCED
  minds: 1
  model: R7 with the twelve corners at (0, 0) and (1, 0): it has the seed, its closure is fifteen corners, and R7 has each of the three forced ones (C136-CLOSE-R7; control `close-r7`: "agree-with-object=3 of 3")
  prior art: partly: as C136-FORCED; the closure as an object — the least family closed under a forced step — is the card's (`plans/STUB-covering-pairs.md` § Structural form), posed there on pieces and "as a fixpoint of a monotone step"; for maps the nearest held object is the ring calculus's placing run along a ring (G91); print: as C136-FORCED — not found
  handoff: none — a kernel statement would need a type of corners and their classes (C136-CLASS); it crosses only with a consumer: a seed whose closure empties a corner (none found), or the Searcher's propagator checked there

**Class**: every weak `k`-colouring of an open set and every set of labelled corners it has. **What is new**: the statement
(that forced steps chain, on germs, in any order) and its limit, said in the *not claimed* line: **what a seed forces is a
countable family of corners at isolated points — each had at some radius, none of a size any statement bounds — unless a
point carrying at least `k − 1` labels forces along an arc.** **Two things the argument gives beside the statement, used
by the computations and not entered**: (1) *refinement* — if `F ⊂ F′` and a corner `Σ′` cut at `w` by the members of `F′` lies
in a corner `Σ` cut by those of `F`, every label `F` bars on `Σ` is barred by `F′` on `Σ′`; so the table of the whole family
at a point finds, corner by corner, whatever any sub-family forces there; (2) *no overlap* — two labelled corners of the
closure at one point with different labels cannot meet in an open set (the colouring would have two labels almost
everywhere on it); the engine reports such a pair as a conflict, and reports none.

### Argument — the closure

*The colouring has it.* By induction on `n`, `c` has every member of `𝒮_n`. Let a finite `F ⊂ 𝒮_n` force `(w, Σ, ℓ)` with
`w ∈ U`. For each corner of `F`, at a point `x` one unit from `w`, `c` has it at some radius; shrink the radius until `Σ_ρ` is
connected (it is the image of an end-region under the inversion at `x`): it is a piece at `x`, a connected open subset of
`U` almost all of one label with `x` in its closure. Let `𝒫_x` be these pieces. If `Σ` is inside `S(x)` and a corner of `F` at
`x` with the label `a` is not inner at `w`, its piece has a point strictly outside `S(w)`, so it is not inner at `w` and `a` is
not inner-pure for `𝒫_x`; and the same outside. So the hypothesis of C136-FORCED holds for `Σ` and `ℓ`, and `c` has
`(w, Σ, ℓ)`. *No corner is emptied.* If a finite subset emptied `Σ` at `w ∈ U`, the same argument with C136-TABLE would leave
almost every point of `Σ_η` no label, and `Σ_η` has positive measure. *The union of the stages is the least set.* It
contains `𝒮`; a finite subset of it lies in some `𝒮_n` (the stages increase), so what it forces at a point of `U` is in
`𝒮_{n+1}`; and any set that contains `𝒮` and is closed under the step contains every `𝒮_n` by induction, because a set
forces whatever a subset of it forces. No order of steps enters. ∎

derivation: C136-CLOSE-R7
  statement: The forced closure in the plane of the twelve labelled corners of the tight seven-colouring R7 at the lattice points (0, 0) and (1, 0) is those twelve and three more: at (1/2, √3/2) the corner inside both points' unit circles, with the label 0; at (1/2, −√3/2) the corner inside the unit circle about (0, 0) and outside that about (1, 0), with the label 1, and the corner outside the first and inside the second, with the label 3. It empties no corner; at every point one unit from two or more of its four points every other corner cut there has two or more labels left; and along the unit circles about (0, 0) and (1, 0), off those points, each side has two or more labels left.
  uses only: C136-CLASS for every class and C136-CORNERS for every table; exact signs in ℚ(√3); the refinement remark under C136-CLOSE (the table of the whole family at each point); that a corner is forced only at a point whose members carry at least six of the seven labels — so the points to read are those one unit from two or more points of the family, and the whole unit circle of each point carrying six labels, which is read by one sample in each open arc between critical directions (the classes of that point's corners are constant on such an arc) and at the critical points
  not claimed: what C136-CLOSE does not claim; anything about the closure of the two points' whole tiles (extent adds bars: not computed); that R7 is the only colouring with the seed; anything for another pair of points of R7 except by its symmetries
  argument: § Argument — the three closures, computed
  verdict: derived
  grade: computed over: the twelve corners of R7 at (0, 0) and (1, 0); two rounds; the tables at 8 points and along 2 unit circles (12 arcs, 2 critical points); exact in ℚ(√3)
  minds: 1
  model: R7 itself: it has the seed and each of the three forced corners — the Reuleaux tile on (0, 0), (1, 0), (1/2, √3/2) at its third corner, and at (1/2, −√3/2) the halves, away from the cusp between them, of the two Reuleaux tiles there that hold (0, 0) and (1, 0)
  prior art: partly: the asking lane read the first step in floats with whole tiles ("singleton cells per coloured point … 1:69 2:27", `data/fs136/p1/germs_read.out`); the closure: here
  handoff: none — a control at seven; nothing consumes it

**The survival control passes: no corner is emptied at any step** (and with one wrong bar planted one is: control
`close-r7`'s fault). **What the closure gives of R7's own corners**: at the up apex one of six, whole (the Reuleaux corner);
at the down apex none whole — two half-corners; beyond the two common unit points, nothing: the four further points read
have 16 corners, each with two to four labels left (and five corners at the two common unit points are free). **Tightness at seven is not rigidity of the closure** (the stub's table
row, "tightness at seven is rigid from two points", falls): with both members full the table is *exact* at every corner —
`exact=432` of 432 in the window, the labels left are R7's labels there — and it stalls all the same, because R7 has two or
three labels in those corners and a forced corner carries one label, too few to bar anything one unit further on.

### Argument — the three closures, computed

Each closure is the output of `data/fs136/e2/closure.py close <seed>` (its header specifies it; the full listing — the
seed's corners, every forced corner, the table at every point read in the last round, the scans — is
`data/fs136/e2/out/<seed>.txt`; every forced step with its bars, for a second script to replay, is
`out/<seed>.steps.json`; the free corners, one line each in the form of a search request, `out/<seed>.free.txt`). *What makes
the output the closure*: (i) the seed's corners are read from the object's exact tiles at the two points, and fill a
neighbourhood of each ("full neighbourhoods: True": each corner's upper edge is the next one's lower edge, all round);
(ii) every class is C136-CLASS's order, in exact arithmetic; (iii) in each round the table is read at every point one unit
from two or more points of the family (all common unit points of pairs, computed exactly, the tower extended only when a
root is not in it), with **all** the family's points one unit away as members — by the refinement remark this finds what
any sub-family forces there; (iv) a point one unit from exactly one point of the family can have a forced corner only if
that point carries at least `k − 1` labels, and then its whole unit circle is scanned ("arc-scans"); (v) a round that adds
no corner ends the run ("closed=yes"): the family is then closed under the step at every point of `U`, and it is the least
such by construction. *What was checked on another path*: every class by samples; every forced corner inside the object
against the object's colour; the engine's first run on R7 against a closure worked by hand before it was written (Q2,
registered as not blind): the three corners and their labels are the hand's, and so are the hand's tables at two further
points — at `(3/2, √3/2)`, `{1, 2, 4}` inside and `{1, 3, 5, 6}` outside the unit circle about `(1, 0)`; at `(3/2, −√3/2)`,
`{3, 6}`, `{1, 6}`, `{0, 4, 5}`, `{0, 1, 4, 5}` (`out/r7.txt`).

control: close-r7
  of: C136-CLOSE-R7 — the closure, with its checks on other paths: the three forced corners sampled against R7's colour function, every class against samples. Tight: R7 has no margin. The fault bars the label of the first forced corner on every corner (one planted wrong bar): a corner must be emptied
  run: python3 ../data/fs136/e2/closure.py close r7 --brief
  expect: r7: seed=12 corners at 2 points (full neighbourhoods: True) labels=7 | rounds=2 closed=yes | forced=3 at 2 points | emptied=0 conflicts=0 | arc-scans=2 arc-forced=0 | corners read: forced=3 free=21 seed-point free=12 | agree-with-object=3 of 3 (disagree 0, unread 0) | class-samples=156 mismatches=0
  fault: python3 ../data/fs136/e2/closure.py close r7 --brief --fault=bar

**Predictions scored.** Q2 — **met** on both parts (0.99; 0.8, not blind). The asking lane's: "on R7 no cell empty 0.97" —
met; "the closure of R7's pair gives at least one of R7's germs at a common unit point 0.9" — met (one, whole); "all six
there 0.3" — no.

## Stage 4 — SAVED: the flower's pair

derivation: C136-CLOSE-FLOWER
  statement: The forced closure in the open disc of radius 3/2 about the origin of the seven labelled corners of FS116-Y2-SIXFRAG at e(180°) and e(270°) is those seven and six more: at (−1, −1) the four corners cut by the two points' unit circles, the two inside the unit circle about e(270°) with the label 0 and the two outside it with the label 1; at (−1 + √3/2, −1/2) the two corners outside the unit circle about e(180°), with the label 4. It empties no corner. The forced closure of the same seven in the whole plane is those thirteen and two more, at (−1 − √3/2, −1/2), the two corners inside the unit circle about e(180°), with the label 4; it empties no corner.
  uses only: as C136-CLOSE-R7, with exact signs in ℚ(√3, √7) (the fragment's own tower; no root is adjoined); no point of either closure carries five labels, so no unit circle is scanned
  not claimed: what C136-CLOSE does not claim; anything about the closure of whole tiles; that a weak six-colouring has these seven corners; anything about the fragment's other pattern or its other pairs; that the closure in the plane says anything about a colouring of a set that does not hold its three points
  argument: § Argument — the three closures, computed
  verdict: derived
  grade: computed over: the seven corners of FS116-Y2-SIXFRAG at e(180°) and e(270°); three rounds; the tables at 10 points (in the disc of radius 3/2) and at 13 points (in the plane); exact in ℚ(√3, √7)
  minds: 1
  model: the fragment itself: each of the six corners forced inside it has the fragment's colour there (control `close-flower`: "agree-with-object=6 of 6") — at (−1, −1) the lens Q4's and the lens Q5's sides of the unit circle about e(270°), at (−1 + √3/2, −1/2) an interior point of the sector S4
  prior art: partly: the first step is the first round's reading (C136-COVER's model; "in/in=0 in/out=1 out/in=0 out/out=1", `data/fs136/e1/out/sixfrag.txt`) and the asking lane's; the second step and the stall: here
  handoff: none — a computed closure with no consumer

**Where it agrees with the object, and where the object has more.** Six forced corners, each the fragment's colour (the
second survival control, at six: passed). **A unit arc is forced, not designed**: at `(−1, −1)` the labels `0` and `1` meet
along the unit circle about `e(270°)` — C136-FORCED's second sentence, on a held object. **Where it stalls**: after two
steps. At the origin — the pair's other common unit point, where the fragment has six sectors — the four corners keep
`{0,1,5}`, `{0,1,2,3}`, `{3,4}`, `{4,5}`: free. The forced point `(−1 + √3/2, −1/2)` carries one label, and one unit from it and
from a point of the family nothing more is forced. **The free corners**: 18 at 5 points in the disc
(`out/flower.free.txt`), 40 at 11 points in the plane (`out/flower.plane.free.txt`).

control: close-flower
  of: C136-CLOSE-FLOWER — both closures (in the disc of radius 3/2; in the plane), each with the forced corners sampled against the fragment's colour function where the fragment is defined and every class against samples. Tight: the fragment has no margin. The fault bars the label of the first forced corner on every corner
  run: python3 ../data/fs136/e2/closure.py close flower --brief; python3 ../data/fs136/e2/closure.py close flower --plane --brief
  expect: flower: seed=7 corners at 2 points (full neighbourhoods: True) labels=6 | rounds=3 closed=yes | forced=6 at 2 points | emptied=0 conflicts=0 | arc-scans=0 arc-forced=0 | corners read: forced=8 free=18 outside-U forced=2 outside-U free=10 seed-point free=4 | agree-with-object=6 of 6 (disagree 0, unread 0) | class-samples=69 mismatches=0
    flower: seed=7 corners at 2 points (full neighbourhoods: True) labels=6 | rounds=3 closed=yes | forced=8 at 3 points | emptied=0 conflicts=0 | arc-scans=0 arc-forced=0 | corners read: forced=12 free=40 seed-point free=6 | agree-with-object=6 of 8 (disagree 0, unread 2) | class-samples=90 mismatches=0
  fault: python3 ../data/fs136/e2/closure.py close flower --brief --fault=bar; python3 ../data/fs136/e2/closure.py close flower --plane --brief --fault=bar

**Predictions scored.** Q3 — first two parts **met** (0.9; 0.85, not blind); "still adding after four rounds" — no (0.3).
The asking lane's "the flower's pair reaches a point beyond (−1, −1) with a forced cell 0.35" — **met against its odds**.

## Stage 5 — SAVED: the strip's two seeds

derivation: C136-CLOSE-STRIP
  statement: (c1) The forced closure, in FS-112's strip and in the whole plane alike, of the eight labelled corners of the strip at (0, 0) and (1/2, 0) is those eight and ten more: three at each of (1/4, √15/4) and (1/4, −√15/4), and one at each of the four points ((1 + 3√5)/8, ±(√15 − √3)/8) and ((3 − 3√5)/8, ±(√15 − √3)/8); it empties no corner. (c2) The forced closure in the strip of its six labelled corners at (−1/4, √15/4) and (1/2, √3/2) is those six: at their common unit point (0, 0) each of the four corners has two labels left, and their other common unit point, (1/4, √15/4 + √3/2), is not in the strip; at that point the six empty the corner outside both unit circles.
  uses only: as C136-CLOSE-R7, with exact signs in ℚ(√3, √5) and, in the last round of (c1), one adjoined root; the strip's tiles list their boundary pieces without a direction of travel, so which of the two corners between a tile's two curves at a point is the tile's is taken from the object's own float point-location (five samples) — the two curves themselves are exact; "in the strip" is read by the first round's float test (two small circles about the point read whole); no point of either closure carries five labels
  not claimed: what C136-CLOSE does not claim; anything about the closure of whole tiles; that a weak six-colouring has either seed; for (c2), more than C136-STOP-GERMS (a) at the point outside the strip; that the card's seed "(c) the six tiles of a covering pair at one of its 34 three-label coloured points" is either of these — it names no object of the strip (Stage 0.2 item 1)
  argument: § Argument — the three closures, computed
  verdict: derived
  grade: computed over: the eight corners of FS-112's strip at (0, 0), (1/2, 0) — three rounds, the tables at 28 points; and its six corners at (−1/4, √15/4), (1/2, √3/2) — one round in the strip, two in the plane; exact in ℚ(√3, √5) and one extension
  minds: 1
  model: the strip itself: each of the ten forced corners of (c1) has the strip's colour there (control `close-strip`: "agree-with-object=10 of 10")
  prior art: partly: the first step of (c1) is the asking lane's float reading ("0:71 3:34": three singleton cells at each of the 34 three-label points) and the first round's (`data/fs136/e1/out/strip.txt` ll. 64–65); the stall of (c2) at (0, 0) is the first round's line 58 of that file; the second step of (c1): here
  handoff: none — computed closures with no consumer

**(c1)** — two four-label points half a unit apart. The forced corners, with the strip's letters: at `(1/4, √15/4)` — `R`, `P`,
`O`; at `(1/4, −√15/4)` — `M`, `G`, `B`; at `((1 + 3√5)/8, (√15 − √3)/8)` — `G`; at its mirror image below — `R`; at
`((3 − 3√5)/8, (√15 − √3)/8)` — `B`; below — `O`. All ten are the strip's colours. It stalls after two steps: 106 free corners
at 26 further points (`out/strip1.free.txt`). The strip's edge is never reached: the closure in the plane is the same
family. **(c2)** — the first round's pair of three-label points. Nothing is forced: inside the strip its one common unit
point has two labels in every corner (`BP`, `BO`, `MP`, `MO`), and the other is the stop. **So on the strip the pairs whose
tables fill corners are pairs of four-label points, and the pairs of three-label points — the close complementary pairs
of the first two rounds — force nothing: their only product is the exclusion at the point across.**

control: close-strip
  of: C136-CLOSE-STRIP — the four closures: (c1) in the strip and in the plane, (c2) in the strip and in the plane; forced corners sampled against the strip's colour function, classes against samples. Tight: the strip has no margin. The fault bars one label on every corner (for c1 the first forced corner's; for c2, which forces nothing, the least label left on its first free corner)
  run: python3 ../data/fs136/e2/closure.py close strip1 --brief --rounds=3; python3 ../data/fs136/e2/closure.py close strip1 --plane --brief --rounds=3; python3 ../data/fs136/e2/closure.py close strip2 --brief; python3 ../data/fs136/e2/closure.py close strip2 --plane --brief
  expect: strip1: seed=8 corners at 2 points (full neighbourhoods: True) labels=6 | rounds=3 closed=yes | forced=10 at 6 points | emptied=0 conflicts=0 | arc-scans=0 arc-forced=0 | corners read: forced=14 free=106 seed-point free=16 | agree-with-object=10 of 10 (disagree 0, unread 0) | class-samples=148 mismatches=0
    strip1: seed=8 corners at 2 points (full neighbourhoods: True) labels=6 | rounds=3 closed=yes | forced=10 at 6 points | emptied=0 conflicts=0 | arc-scans=0 arc-forced=0 | corners read: forced=14 free=106 seed-point free=16 | agree-with-object=10 of 10 (disagree 0, unread 0) | class-samples=148 mismatches=0
    strip2: seed=6 corners at 2 points (full neighbourhoods: True) labels=6 | rounds=1 closed=yes | forced=0 at 0 points | emptied=1 conflicts=0 | arc-scans=0 arc-forced=0 | corners read: free=4 outside-U empty=1 outside-U forced=2 outside-U free=1 | agree-with-object=0 of 0 (disagree 0, unread 0) | class-samples=12 mismatches=0
    strip2: seed=6 corners at 2 points (full neighbourhoods: True) labels=6 | rounds=2 closed=yes | forced=2 at 1 points | emptied=1 conflicts=0 | arc-scans=0 arc-forced=0 | corners read: empty=1 forced=2 free=21 | agree-with-object=0 of 2 (disagree 0, unread 2) | class-samples=32 mismatches=0
  fault: python3 ../data/fs136/e2/closure.py close strip1 --brief --rounds=3 --fault=bar; python3 ../data/fs136/e2/closure.py close strip1 --plane --brief --rounds=3 --fault=bar; python3 ../data/fs136/e2/closure.py close strip2 --brief --fault=bar; python3 ../data/fs136/e2/closure.py close strip2 --plane --brief --fault=bar

**Predictions scored.** Q4 — **met** on all three parts (0.9; 0.5; 0.85). Q5 — **no** (0.15): on four seeds, in the object
and in the plane, the one emptied corner is at the seed pair's own second common unit point (the strip's stop, known). The
asking lane's: "the strip's pair a third point 0.4" — met for (c1), not for (c2); "an empty cell from a pair alone beyond
its own two common unit points, on any seed tried, 0.25" — no; its hunch "it stalls at free cells within two steps on
every held six-coloured seed 0.65" — **met**: two forcing steps on the flower and on (c1), none on (c2); its falsifier
(three steps or more) did not fire.

## Stage 6 — SAVED: C136-STOP-GERMS — three stops with corners in place of tiles, and the radius law

derivation: C136-STOP-GERMS
  statement: About weak six-colourings that keep the named parts of one held object's tiles; none is known to. For every r > 0 there is no weak six-colouring of an open set that contains the point w and the parts within distance r of their members of the named tiles, and gives almost every point of each part its label in the object — for (a) FS-112's strip, w = (1/4, √15/4 + √3/2), the members (−1/4, √15/4), (1/2, √3/2) and the six tiles of C136-STOP-STRIP; (b) the disk, with w, the members and the six tiles of C136-STOP-DISK; (c) FS114-Y2-BOWTIE, w = (√3, 0), the members q₂, q₁ and the eight tiles of C136-STOP-BOWTIE.
  uses only: C136-CLOSE's second clause for the labelled corners of the named tiles at the two members (a colouring that keeps the part of a tile within r of a member has that tile's corner there, at a radius at most r); C136-CLASS and C136-CORNERS for the table at w; exact signs in each object's own tower (control `stop-corners`): in each case the corner at w outside both members' unit circles has every one of the six labels barred
  not claimed: what C136-STOP-STRIP, -DISK and -BOWTIE do not claim; any exclusion of a colouring that does not keep these parts; a value of the chromatic number of the plane; that a weak six-colouring has these corners; for (c), that the first round's six tiles (L2, T2, V′, t1, T1, W) suffice in corner form — they do not: the six corners that empty the corner outside both circles are W, t1, V′, T2 at q₂ and V, T1 at q₁
  argument: § Argument — the stops with corners
  verdict: derived
  grade: derived from: C136-CLOSE
  minds: 1
  model: the three objects, none of which holds a neighbourhood of its point; the flower's far vertex, the first round's own germ entry (C136-STOP-FLOWER-GERMS), read by the same engine as a positive: its emptied corner is inside the unit circle about e(−30°) and outside that about e(30°), as that entry says
  prior art: known for maps, as statements about germs: FS114-Y-PENT ("no valid map agrees with the disk near B_k, Z^R_k, Z^L_{k+1}"; two minds, blind), FS114-Y3-RSTOP ("agrees with it near q1 and q2 … the stop is the cone (−60°, 60°) at r"; two minds) — that cone is the corner outside both circles found here — and FS114-Y-STRIPK6 for the strip's six tiles; for whole tiles in measure: C136-STOP-STRIP, -DISK, -BOWTIE (first round, one mind); for two sector points with germs as pieces it is C124-BOTH's case; the asking lane read all 70 stops with germs in floats (`data/fs136/p1/germs_read.out`); the corner form in measure, exact: here
  handoff: none — the form a later statement would cite and the form of the Searcher's screen; it crosses to the kernel only with a consumer (the strip's is the cheapest: six classes in ℚ(√3, √5))

**Class**: three held families of corners — six, six and eight (six of them used). **What is new beyond the entries it
restates**: against the first round's three, the hypothesis is the two vertex figures and nothing of the tiles' extent,
and no `r₀` is needed; against the map entries, the class of colourings. **What it corrects in the first round's closing
section, in one sentence**: § 6.4 item 1 of `plans/FS136-E1-derivation.md` — "a cell is emptied by pieces that are
*crossing* at the point across, and crossing is a fact about a piece's extent … on the flower the germs suffice only because
of the tangency" — is false: at the strip's, the disk's and the bowtie fragment's stops the corners at the two members
already empty the corner outside both unit circles, at first order, and extent only adds bars. **And one detail of the
first round's bowtie entry**: its witnesses empty the cell inside the unit circle about `q₂` and outside that about `q₁`,
and its mirror — true of whole tiles (`T2` and `T1` cross as tiles and are inner as corners); in corner form those two
cells keep one label each (`2` and `4`) and the emptied corner is the third, outside both, which that entry's finite list
of witnesses did not reach. Nothing in that entry is wrong; its statement stands.

derivation: C136-STOP-GERMS-RADIUS
  statement: In the setting of C136-STOP-GERMS, in each of (a), (b) and (c) there are r₀ > 0 and c > 0 such that for every 0 < r ≤ r₀: an open set that carries a weak six-colouring keeping the parts within distance r of their members of the named tiles at their labels contains no point within c·r of w of the corner at w outside both members' unit circles.
  uses only: C124-SHADOW-OPEN (`plans/FS124-derivation.md` § 2; [hand], one mind — inherited, read at its statement) for the part of each tile within r of its member; that this part holds, for r ≤ r₀, the piece Σ_r of the tile's corner there; that for each label one of the named corners at a member x is not outer at w **and has in its cone a direction u with u·(w − x) > 0** (control `stop-corners`: "order 1" at all three); the estimate of § Argument — the stops with corners
  not claimed: the best constants, or any explicit one; anything in the three other corners at w; that a colouring keeping the parts exists; a law for the flower's far vertex, where one label is barred only at second order and the first round's r² stands
  argument: § Argument — the stops with corners
  verdict: derived
  grade: hand
  minds: 1
  model: the three objects: each is defined up to its point and holds no point of that corner (the strip's and the disk's own edges pass through w; the bowtie fragment is cut at radius 3√3/5)
  prior art: partly: the asking lane's float reading — depth exponents 0.60–1.05 at all 540 witnesses of the strip and the disk, "near 2 at … 16 of the bowtie fragment's" (`data/fs136/p1/germs_read.out`), which is why it posed r² for the bowtie fragment; that the bowtie fragment's emptied corner is first order: here; for maps FS114-Y3-RSTOP's "the stop is the cone (−60°, 60°) at r" is the same corner
  handoff: none — a quantitative rider with no consumer

**Verdict on the radius law as posed and as first fixed** ("in (a) and (b) … within `c·r` …; in (c) the same within
`c·r²`"): derived, and **restated, because it says less than the argument carries** — the bowtie fragment's case is first
order like the other two (`c·r²` follows from it for `r ≤ 1`), and the conclusion is put as a statement about the
colouring's domain, which is what the argument gives (the point `w` itself need not be in the set). The asking lane's
expectation "of order `r²` on the bowtie fragment" fails for a reason worth keeping: second-order witnesses do occur
there, in the two side corners, where whole tiles add bars; the corner the vertex figures empty is the third one.

### Argument — the stops with corners

*The exclusion.* Let `c` be a weak six-colouring of an open set `U ∋ w` that gives almost every point of `T ∩ B(x, r)` the
label of `T`, for each named tile `T` at its member `x`. Near `x` the tile is its corner: for small `ρ ≤ r` the piece `Σ_ρ` of
the corner lies in `T ∩ B(x, r)`, so `c` has the labelled corner. The engine's table at `w` for these labelled corners
(control `stop-corners`) has, in each of the three cases, the corner outside both members' unit circles emptied: for each
label a corner of that label at `x` or at `y` that is not outer at `w`. By C136-CLOSE's second clause no such `c` exists.
*The radius.* Let `Σ` be a corner at `x`, `e = w − x`, `u` a unit vector in the cone of `Σ` with `u·e = κ > 0`; then for small
`t` there is a point `q_t` of `Σ` with `|q_t − x| = t` and `(q_t − x)·e ≥ κt/2` (a direction inside the cone near `u`; or, for a
cone of one direction, the corner's own points `x + tu + O(t²)`), so `|q_t − w|² = 1 − 2(q_t − x)·e + t² ≤ 1 − κt + t² ≤ 1 − κt/2`
for `t ≤ κ/2`, and `|q_t − w| ≤ 1 − κt/4`. Let `z` be a point with `|z − x| > 1` and `|z − w| < κr/8`, and `t = r/2`: `|q_t − z| <
1`, while points of `Σ_r` near `x` are farther than 1 from `z`; `Σ_r` is connected, so `S(z)` meets it. By C124-SHADOW-OPEN
almost every such `z` in `U` has a label other than the corner's. In the corner at `w` outside both circles every point is
outside `S(x)` and `S(y)`, and each of the six labels has such a corner at `x` or at `y` ("order 1"); with `c` an eighth of the
least `κ` and `r₀` small enough for the six uses, almost every point of `U` in that corner within `c·r` of `w` has no label:
that part of `U` is null, and open, so empty. ∎

control: stop-corners
  of: C136-STOP-GERMS — the exact table at each stop from the corners of the object's tiles at the two members (the tiles are named in each line; x and y as in the first round's control): the labels left on each of the four corners at w, and for an emptied corner the order of its bars — 1 if every label has a bar with a direction strictly on the wrong side in the corner's cone, 2 if some label is barred only along a tangent edge. The flower's far vertex is the positive for "order 2" (its label 3: the gap tile's tangent edge). The fault reads the point moved by (1/50, 0)
  run: python3 ../data/fs136/e2/closure.py stops
  expect: strip: w=(0.25000,1.83427) corners at x: T-1 U-1 T0 | at y: T1 U0 U1 | labels=6 | corners at w (x/y): out/out=EMPTY(order 1) in/out=R in/in=OR out/in=O | class-samples=6 mismatches=0
    disk: w=(-1.80902,1.11352) corners at x: R1 S1 W1 | at y: S0 T1 P0 | labels=6 | corners at w (x/y): out/in=yellow out/out=EMPTY(order 1) in/out=red in/in=redyellow | class-samples=6 mismatches=0
    bowtie: w=(1.73205,0.00000) corners at x: W t1 L2 V' T2 | at y: V L1 t1 W T1 | labels=6 | corners at w (x/y): out/in=4 in/in=234 in/out=2 out/out=EMPTY(order 1) | class-samples=10 mismatches=0
    flower: w=(1.73205,0.00000) corners at x: Q0 S5 Q5 G5 | at y: G0 Q1 S0 Q0 | labels=6 | corners at w (x/y): out/in=1 in/in=2 in/out=EMPTY(order 2; second-order only: 3) out/out=1 | class-samples=8 mismatches=0
  fault: python3 ../data/fs136/e2/closure.py stops --fault=move

control: stop-shadow
  of: C136-STOP-GERMS — a second path to the same sixteen corners, in floats, with no class and no cyclic order: straight from C124-SHADOW-OPEN, a label is barred at a point z one millionth from w iff the unit circle about z meets a corner of that label at a member (sampled at radii from 0.02 down). Written after the bowtie fragment's table came out against the first round's cells and the asking lane's exponent (G21: a result that surprises is audited on another path before it is kept). The fault reads z on the far side of w
  run: python3 ../data/fs136/e2/shadow_check.py
  expect: strip: corners at w=4 left by the shadow: EMPTY R OR O | agree with the exact table: 4 of 4
    disk: corners at w=4 left by the shadow: yellow EMPTY red redyellow | agree with the exact table: 4 of 4
    bowtie: corners at w=4 left by the shadow: 4 234 2 EMPTY | agree with the exact table: 4 of 4
    flower: corners at w=4 left by the shadow: 1 2 EMPTY 1 | agree with the exact table: 4 of 4
  fault: python3 ../data/fs136/e2/shadow_check.py --fault

**Predictions scored.** Q6 — first part **met** (0.95); second **met** (0.85); third — **lost** (0.8): the bowtie fragment's
emptied corner is first order. The asking lane's "C-STOP-GERMS as posed 0.85 (the bowtie fragment's radius law is the
uncertain part)" — derived, and the uncertain part came out the other way, stronger.

## Stage 7 — SAVED: every claim's five lines; the free corners; the sweeps; the gates; where a successor takes over

### 7.1 For every claim: what is new, the class, the side, the kernel

| claim | new beyond the entry it restates | class | side | for the kernel lane |
|---|---|---|---|---|
| C136-FORCED | a region where none was kept; for maps nothing to state; for palettes a step of FS-132's argument, now an entry for pieces | every weak `k`-colouring, any members and pieces | none alone | the cell form over `ae_onSide_of_label` (three lines); the corner form only with a consumer |
| C136-CLOSE | that forced steps chain on germs, in any order — and that nothing of definite size is forced | every weak `k`-colouring and every set of labelled corners it has | none: no seed is known to be had | none without a consumer |
| C136-CLOSE-R7 | the control at seven: fifteen corners, no corner emptied | one seed of R7 | — (tightness is not rigidity of the closure) | none |
| C136-CLOSE-FLOWER, -STRIP | the second step and the stall; the free corners | three seeds of two held objects | a stall: the free corners, to the Searcher | none |
| C136-STOP-GERMS, -RADIUS | vertex figures in place of tiles; first order at all three | three held families of corners | none: it is the Searcher's screen | the strip's, with a consumer |

### 7.2 The free corners — search requests (the lists are results; one line per corner is in the files)

Each line of `data/fs136/e2/out/<seed>.free.txt` reads "search request | seed | point | corner (its side of each member's
unit circle) | labels left". Counts (corners with 2, 3, 4, 5, 6 labels left): **R7** 21 at 6 points (6, 9, 6, 0, 0);
**flower**, in its disc, 18 at 5 points (8, 7, 3) — in the plane 40 at 11 (14, 21, 5); **strip (c1)** 106 at 26 points
(46, 28, 18, 12, 2); **strip (c2)** 4 at 1 point (all with 2) — in the plane 21 at 6. The nearest to forced, where a
search would branch first — the two-label corners at the pair's own common unit points: flower, at the origin, `{3, 4}`
and `{4, 5}`; strip (c2), at `(0, 0)`, `BP`, `BO`, `MP`, `MO`; strip (c1), at each of `(1/4, ±√15/4)`, the one corner not
forced (`OR` above, `BG` below).

### 7.3 Predictions, all, against the card's registered numbers and mine

The card's: C-FORCED derived as posed 0.9 — derived, restated in two places; already held 0.2 — partly (a step about
palettes). On R7 no cell empty 0.97 — met; at least one of R7's germs 0.9 — met; all six 0.3 — no. The flower's pair beyond
`(−1, −1)` 0.35 — met; the strip's pair a third point 0.4 — met for the eight-corner seed; an empty cell from a pair alone
beyond its two common unit points 0.25 — no; C-STOP-GERMS as posed 0.85 — derived, the bowtie fragment better than posed; a
fragment by formula past `φ²/√2` 0.05 — no, **and it could not have come out**: a closure is germs (Stage 1, finding 1);
six against seven decided here 0.02 — no. Its hunch (a stall within two steps on every held six-coloured seed, 0.65) — met.
Mine: Q1 met; Q2 met; Q3 met, met, no; Q4 met on three; Q5 no; Q6 met, met, **lost**.

### 7.4 The sweeps

- **§G re-read.** *Paid*: G96 (it is the reason the closure is posed on germs, and the reason the third branch falls);
  G13 (per corner; the free-corner lists); G84 with G90 (curvature decides a class; first against second order); G54 with
  G95 (the prediction against "tight is rigid", met); G21 (the bowtie fragment's table audited on a second path before it
  was kept; the sampler's defect found by a positive worked by hand); G92 (the forward half of the table). *Should have
  borne and was not listed*: none found. *Instances drafted for `plans/GROKKING-INSTANCES.md`* (the coordinator files):
  under G96 — "FS-136, second round (2026-10-07): the first passage from ball data at two points to ball data at a third
  (C136-FORCED) yields a germ, a piece of no definite size; chained (C136-CLOSE) it is a countable family of vertex figures
  and never a region — so 'a connected piece of definite size' stays owed"; under G54 — "FS-136 (2026-10-07): the tight
  seven-colouring's table at a common unit point of two lattice points is exact (432 of 432 corners), and the closure of
  the pair stalls after three corners: tight is not rigid for forced corners"; under G21 — "FS-136 (2026-10-07): a float
  sampler with no sample hugging an edge read a half-plane with tangent edges as inner; and the first round's finite list
  of whole-tile witnesses missed the one corner of the bowtie fragment's stop that the vertex figures empty".
- **G99's killing test** ("a local statement in the piece class with no map antecedent that changes a move on the case
  list"): **not fired**. C136-FORCED has a map antecedent (placing), and it changed no move: every closure stalls.
- **§IQ and G79.** No counterexample to either rule: the closure is the invariant every colouring with the seed carries,
  and what it returned is three stalls and one control.
- **§PA, recognitions about what the object is**: (1) *a corner is the end at infinity of an arrangement of lines* —
  inversion at the point turns cells, classes and tangencies into the cyclic order of half-lines by direction and offset;
  (2) *a closure is a set of germs*. Neither is drafted as a grokking: one milestone, one mind; (2) is offered as G96's
  instance above.
- **The plan, "conjecture" and "not claimed"**: no conjecture. *Not claimed* lines that are open questions, each with its
  home: *a radius for a forced corner* — FS-127's ground (a piece of definite size); no stub of its own. *The closure of
  whole tiles* (extent adds bars at the seed's points) — declined: its forced pieces are germs all the same. *A seed whose
  closure empties a corner beyond its own common unit points* — none of four; the Searcher's line 15 is the search for
  one. *A member with `k − 1` labels forcing along an arc* — not met (`arc-forced=0` everywhere); at six it needs a point of
  five or six labels whose corners leave one label inner: the bowtie fragment's `q₁`, `q₂` (five labels) and the flower's
  centre (six) are the held candidates — **run after this stage was written: Stage 8. The bowtie fragment's points do
  force along arcs.**
- **G87 lookout.** The whiff of Stage 1 is settled and is not a signal: the stub's "tightness at seven is rigid from two
  points" was an expectation, and C136-CLOSE-R7 is the fact. One thing that looked like a collision and is not: the first
  round's bowtie entry (cells inside one circle and outside the other emptied) against this round's (the corner outside
  both) — whole tiles against corners; both hold.

### 7.5 Corrections owed and drafts (each names its slot; none is filed by this job)

1. `data/fs136/claims.md`, a dated line: C136-STOP-GERMS-RADIUS **restated** — the statement of this record's entry in place
   of the one fixed from Stage 1 ("in (c) the same within `c·r²`"): first order in all three, and a conclusion on the
   colouring's domain. Every other statement stands as fixed. The coordinator's.
2. `plans/STUB-covering-pairs.md` § The first claims a deriver takes, second round, C-CLOSE, seed (c): "the six tiles of a
   covering pair at one of its 34 three-label coloured points" → "(c1) the eight corners of two four-label points half a
   unit apart, whose common unit points are two of the 34 three-label coloured points; (c2) the six corners of a pair of
   three-label points". And its § Existence form and the card's third branch: re-worded for germs (Stage 1, finding 1).
   The asking lane's.
3. `plans/STUB-covering-pairs.md` § What each answer gives, last row ("on R7 at seven the closure reproduces R7 near the
   seed … tightness at seven is rigid from two points") → "on R7 the closure of two adjacent lattice points is fifteen
   corners and stalls; the pair's table is exact at every corner and no corner is emptied". The asking lane's.
4. `plans/FS136-E1-derivation.md`: an erratum under § 6.4 item 1, dated, with this record's Stage 6 as its source (the
   sentence quoted there); the record job's pen. No entry of that record changes.
5. `plans/SEARCH-QUEUE.md` line 15 (the skeleton search): its screen is C136-TABLE; **its propagation rule is now an
   entry** (C136-FORCED: "a cell with one such label fixes the wedge there"), and `data/fs136/e2/closure.py` is an exact
   implementation of table and propagation for corners bounded by rays and circular arcs, with R7 passing at seven. A
   note for the Searcher, through the coordinator.

### 7.6 The gates, and where a successor takes over

| stage | gate (from `plans/`, `derive_gate.py all FS136-E2-derivation.md`) | saved output |
|---|---|---|
| 0–1 | not run on its own: no entry yet (the first round's stage 0 has the same one expected failure) | — |
| 2–8 | exit 0; 10 entries, each derived; 8 controls, each firing on its fault; 1 warning (Stage 8's entry and control included) | `data/fs136/e2/gate-final.txt` |

The warning: C136-CLASS is two-way and the gate reads its one control as reading one direction; the control's eleven
corners include both (five that are between the branches, and the half-plane with tangent edges, which is not).
**A slip, disclosed**: Stages 2–7 were written and committed together — the engine made the three seeds and the stops one
afternoon's runs — so the verdicts went to the coordinator in one message, not one by one as the brief asked.

**Done**: every item of the brief's "Done means" — the three claims at verdicts, the three seeds (the strip's as two),
the lists. **Where a successor takes over**:

1. **Collars.** A point carrying `k − 1` labels can force its missing label along an arc (Stage 8: the bowtie fragment's
   `q₁`, `q₂` do; the flower's six-label centre does not). The engine counts such arcs and does not propagate from them: a
   collar is a piece with extent, and what it bars one unit away is read from its extent (C124-TYPE on the whole collar),
   not from a germ. **The closure of a seed with a five-label point is open**, and it is the one place a region comes out.
2. **Seeds of three or more points.** A closure grows only where label-rich points stay within one unit; a third seed
   point changes that. The Searcher's line 15 is the systematic form.
3. **A second mind.** C136-FORCED is three lines over a statement the kernel lane holds at one member; C136-CLASS's order
   and the engine have a hand-worked closure, a sampled re-reading of every class and a float second path at four
   points behind them, and no second derivation.
4. **Exactness of "in the strip"** and of the choice between a tile's two candidate corners there: floats, by the
   object's own point-location (Stage 5's *uses only*). The disk and the strip would need their boundary pieces given
   with a direction of travel for this to be exact.

## Stage 8 — SAVED: an addendum outside the three claims — a label forced along an arc; a gap of the engine closed

*Run after the verdicts, for the arc scan only, on the two held seeds that have a point with `k − 1` or `k` labels. No
statement was fixed for this when it was run; it went to the coordinator at once (its kept clause), **and at its request
it is an entry, C136-COLLAR, below** — its statement sent and fixed before the entry was written. The two computed
readings are the round's engine's — exact for every class, one mind. No value is touched; it is not a first piece.*

**The flower's centre alone** (six labels; `data/fs136/e2/out/flower0.txt`): along its unit circle every open arc between
critical directions leaves two labels on each side (`arc-forced=0`); at the six mid-arc ring points `e(60j + 30°)` the inside
has one label left — the sector's own — and those six corners are forced (all six the fragment's colours), and then the
closure stops. No arc.

**The bowtie fragment's two five-label points** (`q₂ = (√3/2, −1/2)`, which lacks the label 4; `q₁ = (√3/2, 1/2)`, which lacks
2; ten corners; `out/bowtie12.txt`): **`arc-forced=4`.** Along the open arc of `S(q₂)` from the origin to `(0, −1)` —
directions `150°` to `210°` from `q₂` — the corner inside `S(q₂)` has, at every point, exactly one label left: `4`. Along the
arc of directions `−30°` to `30°` the corner outside `S(q₂)` has only `4` left. The mirror image holds at `q₁` with the label
`2`. *Why*: on a side of its unit circle a point carrying `k − 1` labels leaves its missing label and those of its own
labels that are pure on that side; `q₂`'s corners have cones of `30°`, `120°`, `120°`, `6.9°`, `83.1°`, and for a direction in
`(150°, 210°)` the tangent line cuts both `120°` corners and the near half-plane holds no whole corner — no label of `q₂` is
inner-pure. (R7's lattice points carry six of seven labels and never do this: every half-plane there holds a whole
Reuleaux corner or a cusp, so each side keeps two labels or more — its scans read `arc-forced=0`.) *What C136-FORCED gives
there, with one member*: at each point `w` of such an arc almost every point of a one-sided neighbourhood of `w` has the
label; the union over the arc is an open set, almost all one label, that holds a one-sided collar of the whole arc — **a
region of definite length (`π/3` along the circle) and of no definite width**. *Checked on another path*: the fragment has
the label `4` at 118 of 118 float samples just inside the first arc and `2` at 118 of 118 inside `q₁`'s (the two outer arcs
lie beyond the fragment's radius `3√3/5`). *Held for maps*: FS116-N2-FIVERING (`plans/FS116-derivation.md` l. 655: "about a
vertex p of five colours … the ring has no change point"; read at its statement only) — G98's count, one label left for
the ring of a five-label point.

**What this does to Stage 1's finding 1.** It stands as worded, and its exception is inhabited at six: a seed with a
five-label point forces a region. So the sentence "at six with members of three or four labels, never from the seed
alone" is the true scope, and the three computed closures are inside it.

**What is not done.** The engine does not propagate from a collar (its header's LIMIT): the closure of the bowtie seed as
listed — five forced corners at three points, the four arcs, and the known emptied corner at its stop — is a lower bound.
What a collar bars one unit away is C124-TYPE on a piece with extent along an arc; nothing in this record computes it.
**Smallest open form, for the asking lane**: *a pieced point carrying five of six labels forces its sixth along every arc
of its unit circle on whose side none of its own labels is pure; what do two such collars, or a collar and a pieced point,
force one unit further on — a corner emptied, a stall, or a second collar?*

**A gap of the engine, found here and closed** (G21: the scan had had no positive before this seed). A corner forced at an
isolated critical point of a scanned circle was listed and not added to the family. Closed in `closure.py` (such a corner
now joins the family); every claimed closure re-run, line for line the same (their scans have no such point: R7's two
critical points read `0356 | 234` and `126 | 0145`). The flower's centre is the seed that showed it: six such corners.

derivation: C136-COLLAR
  statement: About weak colourings that have the named corners; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U, x a point, F a finite set of labelled corners at x that c has, whose labels are all the labels but one, ℓ, and A an open arc of S(x) lying in U such that at every point w of A each label of F has a corner in F that is not inner at w. Then there is a connected open subset V of U inside S(x), almost every point of which has the label ℓ, such that every point w of A has a radius η > 0 with every point of B(w, η) inside S(x) in V. With "outer" in place of "inner" there is such a V outside S(x), holding the points of B(w, η) outside S(x).
  uses only: C136-FORCED with the one member x at each point w of A (the two corners cut at w by S(x) are the parts of a small disc inside and outside S(x)), for the pieces Σ_ρ of the corners c has, as in C136-CLOSE's argument; that an open subset of the plane is the union of countably many of any family of open sets covering it; that the part of a disc inside (or outside) a unit circle through its centre is connected for a small radius, and that an arc is connected
  not claimed: that a weak colouring has such corners; any width — η depends on w and on c and is bounded below by nothing, at the ends of A or anywhere along it; anything at the end points of A; anything for a point whose corners lack two labels (two labels are left on each side) or lack none (there a side on which no label is pure cannot be coloured at all: C136-ONE); that an arc A exists for a given F (it is read from the corners by C136-CLASS: for the flower's centre and for R7's lattice points there is none); that V is a tile, reaches beyond its collar, or has ℓ everywhere and not almost everywhere; what V bars one unit further on (a fact about its extent; not computed here)
  argument: § Argument — the collar
  verdict: derived
  grade: derived from: C136-FORCED
  minds: 1
  model: FS114-Y2-BOWTIE with the five corners at q₂ = (√3/2, −1/2), whose labels are all but 4: A the open arc of S(q₂) of directions 150° to 210° from q₂ (from the origin to (0, −1)), on which each of the five corners is outer or crossing; the fragment has the label 4 at 118 of 118 samples just inside that arc; and the same at q₁ with the label 2 (control `forced-arc`: "arc-forced=4" — these two and the two arcs of directions −30° to 30°, outside, beyond the fragment)
  prior art: partly: for maps FS116-N2-FIVERING (`plans/FS116-derivation.md` l. 655: "in a valid fragment on a closed disc of radius above 1 about a vertex p of five colours, Siamese pairs allowed, the ring has no change point"; read at its statement only, its argument and mind count not read) — G98's count, one label left for the ring of a point of five; for pieces in measure: here, as C136-FORCED at one member taken along an arc; print: as C136-FORCED — not found
  handoff: de Bruijn — only with a consumer: `ae_onSide_of_label` at the one member for each point of the arc, a countable subcover, and the connectedness of a union of half-discs along an arc

**Class**: every weak `k`-colouring of an open set with a point whose corners carry all the labels but one. **What is new
beyond the entry it restates**: against FS116-N2-FIVERING, the class (no map, no disc about the point, nothing assumed on
the ring) and the hypothesis read arc by arc; against C136-FORCED, nothing but the passage from a point to an arc — and
that passage is what turns a germ into **a region with a definite length**. **Side**: none alone. It is the one step of
this round that forces a region, and no weak six-colouring is known to have a point of five labels. **The hypothesis as
the argument reads it**: "each label of `F` has a corner that is not inner at `w`" — weaker than "no corner of `F` is inner
at `w`" where two corners share a label.

### Argument — the collar

Let `D` be the open unit disc about `x`. Fix `w ∈ A`. The corners of `F` are had by `c`; their pieces `Σ_ρ`, for small `ρ`, are a
family `𝒫` of pieces at `x`, and a corner that is not inner at `w` has a piece that is not inner at `w` (C136-CLOSE's
argument). Every label other than `ℓ` is a label of `F`, hence of `𝒫`, with a piece that is not inner at `w`: it is not
inner-pure at `w`. The two corners cut at `w` by `S(x)` are the parts of a small disc inside and outside `S(x)`; C136-FORCED,
for the one inside, gives `η_w > 0` with `B(w, η_w) ⊂ U` such that almost every point of `H_w = B(w, η_w) ∩ D` has the label
`ℓ`; shrink `η_w` so that `H_w` is connected. Let `V` be the union of the `H_w`, `w ∈ A`: open, in `U`, inside `S(x)`, and holding
every point of `B(w, η_w)` inside `S(x)`. *Almost all `ℓ`*: `V` is the union of countably many of the `H_w`, each almost all `ℓ`.
*Connected*: if `V` were the union of two disjoint non-empty open sets, each connected `H_w` would lie in one of them, and
`A` would split into the two sets of its points so sorted, both non-empty; `A` is connected, so some `w₀` of one set is a
limit of points `w_n` of the other; for large `n`, `H_{w_n}` has points within `η_{w₀}` of `w₀`, which lie in `H_{w₀}`: the two
sets meet. The outside is the same with `D` replaced by the complement of its closure. ∎

control: forced-arc
  of: C136-COLLAR — C136-FORCED's case of one member, along an arc: the ten corners of FS114-Y2-BOWTIE at its two five-label points; the scan of both unit circles (one exact sample per open arc between critical directions); arc-forced counts the sides of arcs with one label left — four: inside and outside each circle along a 60° arc, the label the point lacks. Not a claim of this round; the closure it prints is a lower bound (collars are not propagated). The fault bars the label of the first forced corner on every corner
  run: python3 ../data/fs136/e2/closure.py close bowtie12 --brief --rounds=3
  expect: bowtie12: seed=10 corners at 2 points (full neighbourhoods: True) labels=6 | rounds=3 closed=yes | forced=5 at 3 points | emptied=1 conflicts=0 | arc-scans=2 arc-forced=4 | corners read: forced=7 free=17 outside-U empty=1 outside-U forced=2 outside-U free=9 seed-point free=12 | agree-with-object=5 of 5 (disagree 0, unread 0) | class-samples=226 mismatches=0
  fault: python3 ../data/fs136/e2/closure.py close bowtie12 --brief --rounds=3 --fault=bar
