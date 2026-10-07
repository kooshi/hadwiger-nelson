# FS136-E2 — the second round: the table run forward: the record

*FS136-E2 (Ephodos), 2026-10-07 (UTC). Brief `data/fs136/briefs/FS136-E2-forward.md`; the card `plans/STUB-covering-pairs.md`
§ The question, second round; the claim list `data/fs136/claims.md` (its last dated block); the first round's record
`plans/FS136-E1-derivation.md`; working files `data/fs136/e2/`. **Every statement below is about a weak colouring that has
the named corners (its seed); no entry says that a weak six-colouring has a piece, a corner or a seed, and none is known to
have one.** Nothing here fixes or bears on the value of the chromatic number of the plane.*

## Theorems this phase proved

*(one line per theorem, with its grade and its address in this file; one mind each; kernel pending; filled as the stages are
saved)*

- none yet (Stages 0 and 1 are the readback and the recognition).

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
