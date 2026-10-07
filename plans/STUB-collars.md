# FS-137 — collars: what a point carrying all labels but one forces along its unit circle, and what those collars force one unit further on (stub)

*Minted 2026-10-07 by FS-136's record job (FS136-Z1; `plans/FS136-Z1-record.md` Stage 4), from the one result of FS-136 that
forces a region of definite extent: the entry C136-COLLAR (`plans/FS136-derivation.md` § 2; derived, one mind, kernel
pending), found by FS-136's second deriver after its verdicts (`plans/FS136-E2-derivation.md` Stage 8). Its number is the
brief's (FS-137); the coordinator files the banner. **State: Not started. Unranked — the asking lane ranks it and writes
its question section, which is left empty below.** **Solver column: in-ban** — derivation and exact arithmetic on named
corners; a step that branches on a free corner is a `search request`, never taken here. **Nothing in this stub is a
statement about every weak six-colouring: every statement is about colourings that already have a point with labelled
corners carrying five of the six labels, and no weak six-colouring is known to have one.** Written for a session with no
memory of FS-136: read `plans/FS136-derivation.md` §§ 1–2 (C136-TABLE, C136-CORNERS, C136-CLASS, C136-FORCED, C136-CLOSE,
C136-COLLAR, each with its `not claimed:` line), then `plans/FS136-E2-derivation.md` Stage 8.*

## The mission, in plain language

The plane needs six colours or seven so that no two points at distance exactly 1 share one (`[OAIMath2026]`; in this
library on one declared outside theorem). It needs seven exactly when some open disc has no *weak six-colouring* — a
measurable map to six labels giving almost no two points at distance 1 the same label — and six exactly when every disc
has one (ledger row 161; [kernel], the half toward seven on one declared outside theorem). So one disc that cannot be
six-coloured decides the problem one way, and six-coloured discs of every radius decide it the other.

Everything this project can say about a weak six-colouring near a point starts from a **piece**: a connected open set
almost all of one label. One lemma does the work (C124-SHADOW-OPEN, C124-TYPE; ledger row 162): an open set almost all of
one label bars that label at almost every point whose unit circle meets it. FS-136 ran that lemma at a point `w` with
several pieced points on its unit circle (the table, C136-TABLE), and then forward: where the pieces one unit from `w` bar
every label but one on a corner at `w`, that corner has the one label (C136-FORCED). Chained, this forces labelled corners
at further points (C136-CLOSE) — but each forced corner is a **germ**: it is had at some radius that nothing bounds below.
On every seed tried — two points with three or four labels each — the chain stalled within two steps and forced no region
of definite size.

There is one exception, and this stub is about it. **A point that already carries all the labels but one forces the
missing label along whole arcs of its unit circle**: at every point of an arc where none of its own labels is pure on a
side, the only label left on that side is the missing one, so the missing label fills a one-sided strip — a *collar* — of
the whole arc. A collar has a definite length (60° of the unit circle on the one held object that has one) and no definite
width. It is the first region of definite extent that either FS-124 or FS-136 forces where none was kept. **What a collar
forces one unit further on has not been computed**, and that is the question a milestone here would take.

## Terms, each with its address

*All in `data/fs136/claims.md`: "Definitions, stated once"; the dated line of 16:06 UTC ("Added by this plan"); the dated
line of 18:25 UTC ("Added by this round").*

- `S(p)`: the unit circle about `p`. A **weak `k`-colouring** of an open set `U`: a measurable map from `U` to `k` labels
  with `c(z) ≠ c(z + u)` for almost every pair of a point `z` of `U` and a unit vector `u` with `z + u` in `U`.
- A **piece**: a connected open subset of `U` almost every point of which has one label. A **family of pieces at `x`**: a
  finite set of pieces, each with `x` in its closure. For `|w − x| = 1` a piece is **inner at `w`** if it lies in the closed
  unit disc about `w`, **outer** if it misses the open one, **crossing** otherwise; a label of the family is **inner-pure**
  (**outer-pure**) at `w` if every piece of that label is inner (outer), and **barred** otherwise.
- A **corner at `x`**: two curves from `x`, each a ray or a circular arc; a **labelled corner** is a corner with a label; a
  colouring **has** it if, for some `ρ > 0`, almost every point between the curves within `ρ` of `x` has the label. A
  corner is **inner**, **outer** or **crossing at `w`** as its small parts are (C136-CLASS decides which, exactly, from
  directions and signed curvatures).
- A **collar** (this stub's word for C136-COLLAR's conclusion): a connected open set `V` inside (or outside) `S(x)`, almost
  all of one label, containing a one-sided neighbourhood of every point of an open arc `A` of `S(x)`.

## The entry it starts from

**C136-COLLAR** (`plans/FS136-derivation.md` § 2; copied from `plans/FS136-E2-derivation.md` Stage 8; **derived from
C136-FORCED; one mind; kernel pending**). Its statement, verbatim:

> About weak colourings that have the named corners; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U, x a point, F a finite set of labelled corners at x that c has, whose labels are all the labels but one, ℓ, and A an open arc of S(x) lying in U such that at every point w of A each label of F has a corner in F that is not inner at w. Then there is a connected open subset V of U inside S(x), almost every point of which has the label ℓ, such that every point w of A has a radius η > 0 with every point of B(w, η) inside S(x) in V. With "outer" in place of "inner" there is such a V outside S(x), holding the points of B(w, η) outside S(x).

Its *not claimed* line, verbatim:

> that a weak colouring has such corners; any width — η depends on w and on c and is bounded below by nothing, at the ends of A or anywhere along it; anything at the end points of A; anything for a point whose corners lack two labels (two labels are left on each side) or lack none (there a side on which no label is pure cannot be coloured at all: C136-ONE); that an arc A exists for a given F (it is read from the corners by C136-CLASS: for the flower's centre and for R7's lattice points there is none); that V is a tile, reaches beyond its collar, or has ℓ everywhere and not almost everywhere; what V bars one unit further on (a fact about its extent; not computed here)

Its argument is three steps (`plans/FS136-E2-derivation.md` § Argument — the collar): C136-FORCED with the one member `x`
at each point of the arc; a countable subcover; connectedness of a union of half-discs along a connected arc. Its control
(`forced-arc`) is the engine's scan on the held object below, with a planted fault.

## What is held on objects (the observations; each with its address)

- **The bowtie fragment** (FS114-Y2-BOWTIE, `tools/fs114_y2_k1.py`; a six-coloured fragment by formula holding the closed
  disc of radius `3√3/5` about `p = (0, 0)`). Its two five-label points are `q₂ = (√3/2, −1/2)`, which lacks the label 4,
  and `q₁ = (√3/2, 1/2)`, which lacks 2. From the second deriver's Stage 8, verbatim: "Along the open arc of `S(q₂)` from
  the origin to `(0, −1)` — directions `150°` to `210°` from `q₂` — the corner inside `S(q₂)` has, at every point, exactly one
  label left: `4`. Along the arc of directions `−30°` to `30°` the corner outside `S(q₂)` has only `4` left. The mirror image
  holds at `q₁` with the label `2`." Four collars: two inside the fragment, two beyond its radius. **Why there**: "`q₂`'s
  corners have cones of `30°`, `120°`, `120°`, `6.9°`, `83.1°`, and for a direction in `(150°, 210°)` the tangent line cuts both
  `120°` corners and the near half-plane holds no whole corner — no label of `q₂` is inner-pure." **Checked on another
  path**: "the fragment has the label `4` at 118 of 118 float samples just inside the first arc and `2` at 118 of 118
  inside `q₁`'s". The arcs' classes are exact (`data/fs136/e2/closure.py close bowtie12`; output
  `data/fs136/e2/out/bowtie12.txt`, first line "seed=10 corners at 2 points … arc-scans=2 arc-forced=4").
- **The closure of that seed as computed is a lower bound.** The engine lists five forced corners at three points — at the
  origin the labels 2, 4, 1 on three corners; at `(0, −1)` the label 6; at `(0, 1)` the label 5 — the four arcs, and the
  known emptied corner at the fragment's stop `(√3, 0)`, which lies outside the fragment. "The engine does not propagate
  from a collar (its header's LIMIT)". "What a collar bars one unit away is C124-TYPE on a piece with extent along an arc;
  nothing in this record computes it."
- **The flower's centre** (FS116-Y2-SIXFRAG's six-label vertex; `data/fs136/e2/out/flower0.txt`): no arc: "along its unit
  circle every open arc between critical directions leaves two labels on each side (`arc-forced=0`); at the six mid-arc
  ring points `e(60j + 30°)` the inside has one label left — the sector's own — and those six corners are forced (all six
  the fragment's colours), and then the closure stops."
- **The tight seven-colouring R7** (the calibration at seven): its lattice points carry six of seven labels and "never do
  this: every half-plane there holds a whole Reuleaux corner or a cusp, so each side keeps two labels or more — its scans
  read `arc-forced=0`".

## The smallest open form, the second deriver's (verbatim, `plans/FS136-E2-derivation.md` Stage 8)

> *a pieced point carrying five of six labels forces its sixth along every arc of its unit circle on whose side none of its own labels is pure; what do two such collars, or a collar and a pieced point, force one unit further on — a corner emptied, a stall, or a second collar?*

## The question

*This section is the asking lane's. Nothing is posed here.*

## What the record job noticed while filing — one line, not an entry, checked by no control

A collar `V` is itself an open set almost all of one label `ℓ`, so the one lemma applies to it as it stands
(C124-SHADOW-OPEN): `ℓ` is barred at almost every point at distance exactly 1 from a point of `V`. That set contains every
point `z` of `U` with `0 < |z − x| < 2` one of whose two unit points on `S(x)` lies in the arc `A` — the unit circle about
`z` crosses `S(x)` there, so it enters the collar. So the first thing a collar does one unit further on is **exclude** its
label, on a region of definite area swept by the unit circles about the arc's points; it forces a label there only where
the other labels are barred too. Whether that is so on the bowtie fragment's four collars is the first exact computation
a deriver would run. *One mind's remark made while reading; it is to be derived, or refuted, before anything rests on it.*

## The held map entry it restates

**FS116-N2-FIVERING** (`plans/FS116-derivation.md` l. 655, as the second deriver quotes it): "in a valid fragment on a
closed disc of radius above 1 about a vertex p of five colours, Siamese pairs allowed, the ring has no change point" —
"read at its statement only, its argument and mind count not read". In G98's count: one label is left for the ring of a
point of five labels. What C136-COLLAR adds, in its deriver's words: "the class (no map, no disc about the point, nothing
assumed on the ring) and the hypothesis read arc by arc". **A deriver here reads FS116-N2-FIVERING's argument first**
(a prior-art debt), and with it the map entries on placing that the forward step restates (FS116-RING-TRANSFER-QC,
-N3-SEMI, -N2-STAR, -N2-RECIP: named by FS-136's claim list, read by neither deriver).

## Controls a deriver should run

- **At seven, R7 reads zero**: no lattice point of the tight seven-colouring forces an arc (`closure.py close r7`:
  "arc-scans=2 arc-forced=0"). Any statement about collars must leave R7 alone; a corner emptied on R7 is a defect, never a
  finding.
- **The flower's centre gives isolated points**: six forced corners at the six mid-arc ring points and no arc.
- **The bowtie fragment agrees with its own collars**: the label forced along each arc inside the fragment is the
  fragment's (118 of 118 samples, floats). A propagation from a collar must agree with the fragment wherever both are
  defined.
- **The planted fault** of the arc scan (`--fault=bar`: one wrong bar) must empty a corner.
- G21, G95: run each control where the hypothesis is tight — R7 and the two fragments have no margin anywhere.

## Bearing on the answer (provisional; the asking lane writes it)

None on the value as it stands. It is the one place in two milestones where a seed forces a region with extent. *Toward
seven*: an exclusion reached from collars would be an exclusion of colourings with a five-label point, and it is seven
only with a statement that every weak six-colouring has such a point — which nothing held gives (FS-127, FS-128, FS-135).
*Toward six*: collars are regions a construction does not choose; a seed whose collars and corners force a consistent
piece of a colouring would be the first object here not kept by hand. Neither is in sight from one arc of 60°.

## Owed second minds

C136-COLLAR, C136-FORCED and C136-CLASS's order are one mind's each: "each has controls on another code path … and no
second derivation" (FS-136 inventory item 14). The kernel is the workflow's second check and none of FS-136's entries is
in it; C136-COLLAR's `handoff:` line says what its kernel statement needs — "`ae_onSide_of_label` at the one member for
each point of the arc, a countable subcover, and the connectedness of a union of half-discs along an arc" — and
`ae_onSide_of_label` is kernel-checked on a branch, not through the gate.

## Registered expectations

None is registered: the second deriver registered nothing on collars (the arc scan was run after its verdicts, "on seeds
nobody had named"), and the record job registers none. The asking lane registers its own with its card.

## Failure clauses

- If what a collar bars one unit away is, on the held object, only what the point's own corners already bar there, the
  product is that sentence, exact, and the stub closes on it.
- If a propagation from collars empties a corner on R7, stop: the defect is in the statement or the engine, and it goes to
  the coordinator at once.
- A label forced on a region of definite area, or two collars that close up, is a region nobody kept: to the coordinator
  at once, as "claimed by one mind, unchecked" (FS-136 inventory, the announcement rule and item 12 (d)).
- Every statement says in its headline that it is about colourings that have the five-label point's corners, and that no
  weak six-colouring is known to have one.
- Three failed attempts on one step: stop and hand the stalled form back.

## Deliverables

Entries in the deriver's grammar, each with its control and planted fault; the engine extended to propagate from a collar
(its header's LIMIT names the gap), under a new job's directory, the original left as it is; and an explorable picture of
the bowtie fragment with its two five-label points, their corners, the four collars and whatever the collars bar or force
one unit on.

## Provisional bearings

G98 (the count: `k − 1` labels at a point leave one for its ring — at six, a five-label point; the collar is that count
for pieces, arc by arc); G96 (a forced corner is a germ; a collar is the first forced piece with a definite extent, and it
has length and no width — "a connected piece of definite size" is still owed across it); G84, G90 (a corner's class is
decided by curvature where directions are tangent: the classes along an arc are exact, by C136-CLASS); G13 (the hypothesis
is a coverage statement at each point of the arc: no label of the point pure on that side); G91 with G99 (for maps the
forced step is placing and the five-colour ring is FS116-N2-FIVERING: read them before posing; no weak six-colouring is
known to have the corners); G97 (pieces at named points, not palettes); G21, G95 (R7 and the flower's centre are the
controls; a zero from the scan measures which arcs were scanned); G83, G86 (the bowtie fragment is a Siamese-class object:
a count over tiles says nothing here). Ledger rows 161–162 (the disc criterion; the one lemma), FS-136's rows as filed;
entries C136-TABLE, C136-CORNERS, C136-CLASS, C136-FORCED, C136-CLOSE, C136-COLLAR, C136-ONE, C136-STOP-GERMS (c)
(`plans/FS136-derivation.md`); C124-SHADOW-OPEN, C124-TYPE (`plans/FS124-derivation.md` § 2); FS116-N2-FIVERING,
FS116-N2-SIXRING (`plans/FS116-derivation.md`); FS114-Y2-BOWTIE and FS114-Y3-RSTOP (`plans/FS114-derivation.md`). Stubs
FS-136 (`plans/STUB-covering-pairs.md`, the predecessor), FS-127 and FS-128 (a first piece), FS-135 (the seed's
remainder), FS-124 (`plans/STUB-q-ring.md`, case 4: the five- and six-colour vertices). Search queue lines 15 and 17–20
(the skeleton search and the free corners of FS-136's four closures).
