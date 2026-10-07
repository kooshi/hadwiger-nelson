# FS-137 — what a ring can afford at six: the plan (§G, §PA, §IQ, the routes, the stages)

*The milestone's plan, written by its opening job FS137-E1 (Ephodos) on 2026-10-07 (UTC), on the asking lane's card
(`plans/STUB-collars.md` § The question (Poros, 2026-10-07)). The record is `plans/FS137-E1-derivation.md`; scripts and
outputs are under `data/fs137/e1/`. **Everything here is about weak colourings that already have labelled corners at named
points; no weak six-colouring is known to have one; no answer to this plan fixes the value of χ(ℝ²).***

## §G — the re-grokking, walked from inside this question

*The question, from inside: a point `x` at which finitely many one-label corners meet; for each direction `θ` the labels
its corners leave possible just inside and just outside its unit circle at `x + e(θ)`; and whether, at six, the cornered
points of one ring can all afford what the tight seven-colouring's lattice points afford at seven. Walked this session
from the grokkings file as preloaded at launch, each entry read for a clause about a point's corners, its unit circle, a
count of labels, or a control — not from the stub's provisional bearings, which this section replaces.*

**Bears** (what it says here → the phase it changes):

- **G98** — `k − m` labels are left for the ring of a point where `m` meet; at `m = k − 1` the one left is forced on
  one-sided collars. *Here*: the palette is that count with the point's own pure labels added. → claim 1 is stated by
  corners crossing the tangent line (the count G98 lacks), and every later claim reads "absent ∪ pure".
- **G100** — a forced step gives a germ; a region is forced only from a point with all labels but one. **Falsifiable
  here**: its "extent is forced in one way" is claim 4's target (a point of all `k` labels with one label pure along an
  arc); registered below (P4).
- **G97** — the palette calculus stops at a boundary along the unit circle about a point one unit away; a statement
  reading pieces at named points crosses it. *Here*: every count below has that arc as its slack term or its equality
  case (an edge of `x` along `S(y)`). → claim 2 and claim 6 are stated with the number of such edges as an explicit
  term; every headline carries "no weak six-colouring is known to have the corners".
- **G99**, **G92** — with pieces the local theory is the map class's; a held result reaches as far as its argument.
  → §PA item 1 names the map entry for each claim *before* it is stated; each claim is put at the class its argument
  reads (any `k`; any number of members; corners not required to fill a neighbourhood where that is not used).
- **G91** — points of a ring 60° apart are one unit apart; the ring is the pigeonhole. → claim 3 (pairs of ring points
  60° apart, on either side), claim 6 (the lattice ring; FS116-N2-STAR, -ANTI and -HEX6 are the map forms to compare).
- **G86** — a count over tiles is blind to a colour repeated near a point. **Falsifiable here** in the asking lane's
  reading ("a count over directions reads them as own-label arcs"): a label with two corners at one point breaks the
  bound by labels (Stage 0.4 item 2). → claim 1 states the bound by corners and names the failure by labels; claim 2
  names the four-corner escape; claim 6's count is stated for one corner per label.
- **G83**, **G84** — at bounded complexity the tight question lives at a vertex of four or more colours with unit-arc
  ("tactic") edges; contact is the mechanism. → claim 6: compare the count's slack term with route T's charge (which
  counts tiles by Euler's formula; §PA item 1).
- **G96** — circle data and ball data. *Here*: corners at `x` are ball data; the palettes are circle data obtained from
  them by properness alone, the one free passage, and only as an upper bound (the kernel lane's finding 8). → every
  *not claimed* line says that no label of a palette is shown present.
- **G95** — a statement that every colouring satisfies must survive slack. → claim 6: any inequality is first tested on
  the assignment with the fewest labels (points on straight two-label edges), which every count must admit.
- **G79** — hunt the invariant every solution carries. → §IQ item 3.
- **G21** — a control satisfied with room measures the room. → each control is run on R7 and on the bowtie fragment's
  five-label points, where nothing has a margin, and each line says what was run.
- **G13** — coverage is a set property that pair sweeps do not see. → claim 5 is read cell by cell, never pair by pair.
- **G22** — no polygonal colouring uses six. *Here*, a consistency check only: by claim 2 a three-corner point with
  straight edges separates in no direction.

**Falsifiable here, registered**: G100 (P4); G86 in the asking lane's reading (P1's second half).

**Silent**: G1–G12, G14–G20, G23–G29, G31–G45, G48, G52–G66, G68–G71, G73–G78, G80–G82, G85, G88–G90, G93, G94.
**Retired (pointers only)**: G30, G46, G47, G49, G50, G51, G67, G72. **Lookout** (G87): no collision met at the opening;
the card's "whatever the corners" against a repeated label is a statement defect, not two truths.

**Ledger rows read by mechanism**: 165–167 (the table, the forward step and the collar, the stops), 137 and 149 at
their first sentences. **Method read**: `RUNNING.md` § Make the gate fail (before the checks were built).

**What the re-grokking changed in the plan**: (a) claim 1 is taken at a pointwise form — exactly two corners cross —
and the mean is its corollary; (b) claim 6 is aimed at the *crossing corners' labels across*, the one relation between a
point's count and its ring's that G97 and G99 point to, with the unit-arc edges as its explicit slack; (c) the first
test of any ring inequality is the slack assignment (G95), before R7.

## §PA — the prior-art gate

**1. In this project, by file (read at the source; what each claim restates).**

| claim | held entry | read | relation |
|---|---|---|---|
| BUDGET | **its one-corner step is held for maps as the cone lemma** ("that a tile of p in B̄(y, 1), or missing B(y, 1), has its cone in the closed half-plane facing y", `plans/FS116-derivation.md` l. 891, there called CL; ledger row 138's cone form, "every tile's cone and colour is pinned by the half-planes facing the edges' centres", by `plans/FS124-derivation.md` l. 224), and at a hub it is inside FS116-N2-STAR ("every tile of p at y has its cone at p in [ψ − 90°, ψ + 90°] … every tile of p whose cone holds ψ + 90° or ψ − 90° in its interior has its colour in A(y)"; one mind). **The count over directions — two corners cross; what the windows sum to — was not found**: nine derivation files (FS-110, -112, -114, -116, -121, -124, -129, -132, -136) grepped for "half-plane" (19 hits, all the cone lemma or an unrelated half-plane), "half-turn" (2), "angle sum" (0), "sum of the angles" (0), "windows" (21, none a set of directions), "tangent line" (2), "exactly two corners / tiles" (0), "k − 2" (2, another object). A search by terms measures the terms | STAR's argument whole; CL at the lines quoted | BUDGET's first half is the cone lemma at every direction and any number of corners; its count is not held |
| THREE | C124-BOTH's second sentence (one mind); FS112-N3-COR3 (two minds, maps) | statements; C124-BOTH's argument **not read** | THREE is the plane-geometry step, at any number of corners |
| SIXTY | FS116-N2-FIVERING, second clause (one mind, [hand], maps, Siamese pairs allowed): "If r(θ) and r(θ + 60°) were both such points, r(θ + 60°) would carry X while N-E1 … or FS116-N1's L1 … excludes X there" | **argument whole** (`plans/FS116-N2-proof.md` § 2.1) | the same step; in measure the hypothesis is "the palette is one label", not "not on a (Q) arc", so the conclusions differ (see claim 3) |
| OWN | FS116-N2-SIXRING ("every ring arc is a (Q) arc … each the whole set of ring points in the closure of one tile t_i"; one mind, non-Siamese) | argument whole | the map form is stronger (it identifies the tile); OWN reads no map and concludes on labels |
| MEET | C136-TABLE itself | whole | a rewording |
| RING | FS116-N2-STAR and FS116-N2-ANTI (one mind each; non-Siamese, simple; a four-colour vertex and its hubs): "if no edge of p leaves at a direction δ, the tile holding δ has its colour missing at both points of ω(p) at δ ± 90° that are change points"; FS116-N2-HEX6 ("of any four consecutive y_k at least one has a ring carrying an arc of Γ"); route T, FS114-N2-ENDS / -N2-FIVE (a count of tiles and edge-ends by Euler's formula; statements only) | STAR, ANTI: arguments whole; HEX6, route T: statements | the fact about one crossing corner is held for maps at hubs; the sum over a ring with the unit-arc term, and its value on R7, not found |

**2. In print, in the words of two disciplines** (`data/fs137/e1/pa/zb.sh`, output `zb.out`; zbMATH Open API, abstracts).
*Combinatorial geometry (tilings, map colourings of the plane)* — "ab:"chromatic number of the plane" & ab:vert* &
(ab:angle* | ab:"angle sum")" (1: a general introduction), "(ab:"map-type" | ab:"map type" | ab:tiling*) & ab:colo* &
(ab:"unit distance" | ab:"distance 1" | ab:"monochrom*") & ab:vert* & ab:circle*" (3: a problem book and two conference
volumes, titles only), "ab:Reuleaux & ab:colo* & ab:plane" (1: a colloquium volume), "ab:"chromatic number of the plane" &
(ab:"six colo*" | …) & (ab:local* | ab:"vertex figure*" | ab:discharging | ab:tiling*)" (0), "ab:discharging &
(ab:"unit distance" | ab:"chromatic number of the plane")" (1: matchstick graphs, another object). *List colouring*
(the asking lane's recognition: lists on a circle whose points 60° apart are adjacent) — "(ab:"list colo*" | ab:choosab*)
& ab:circle & (ab:"unit distance" | ab:"distance graph*")" (0), "(ab:"list colo*" | ab:choosab*) & (ab:"blow-up*" |
ab:"lexicographic product") & ab:cycle*" (1: a game on graphs). *Authors*: "au:"Coulson, D*" & (ti:tiling* |
ti:chromatic*)" (2, both held or known), "au:"Townsend, Stephen" & py:1979-2006" (0 under that spelling).
**Result: not found.** The method in print — a vertex of a map and its unit circle — is `[Woodall1973]`,
`[Townsend2005]`, `[Coulson2004]`, `[Thomassen1999]`, all held and read in full by earlier jobs (`BIBLIOGRAPHY.md`
ll. 139, 145, 168; **not re-read by this job**: what they hold on a count over directions is "recalled, not read" —
recalled: each takes one trichromatic vertex and colours its circle; none counts labels round a ring). The orbits of a
rotation by 60° are 6-cycles, and that even cycles are 2-choosable is Erdős–Rubin–Taylor (1979; recalled, not read; no
claim rests on it). No bibliography row is proposed: nothing new was found or used.

**3. The question itself** — "is there a local count separating six from seven for map-type or measurable colourings":
not found posed in print (the queries above). In this project it is the stub's structural form, asked twice by FS-136
(`plans/FS136-derivation.md` § 7 item 5, by the stub's citation; not read by me).

## §IQ — the invariant question

1. **Existence form** (the card's, verbatim): "Is there a weak six-colouring of an open set containing the closed unit
   disc about a point `x` at which it has labelled corners carrying five of the six labels — a five-label point *with
   its whole ring*? None is held: FS116-N2-FIVERING's model line reads "none held with five colours at a vertex", and
   the bowtie fragment's four five-label points (`data/fs136/e1/out/bowtie.txt` l. 1: "5-label:4") lie one unit from
   its centre, on the rim of what it holds. One ring further: is there one containing the closed disc of radius 2 about
   a point with corners, with corners at the six points of its ring 60° apart?"
2. **Structural form** (the card's, verbatim): "For every weak `k`-colouring and every point `x` at which it has labelled
   corners filling a neighbourhood: **what must the palettes of `x` be for both sides of `S(x)` to be coloured all the
   way round — points of `S(x)` 60° apart being one unit apart — and what must the palettes of two such points be for
   every cell at their common unit points to keep a label?** Is there one inequality between the numbers of labels at a
   point and at the points of its ring that every such colouring satisfies, that R7 meets at seven with every vertex
   carrying six of seven, and that no assignment meets at six?"
3. **The invariant it forces** (what every colouring with corners at `x` and at a point `y` of its ring carries,
   whatever the corners): *at every direction not perpendicular to an edge, exactly two corners of `x` cross the unit
   circle about the far point — the two holding the tangent directions — and the label of a crossing corner is the
   label of no corner at the far point.* The first half is claim 1; the second is claim 6's first sentence; the only
   way to have fewer than two crossing corners is an edge of `x` along the far unit circle (or a reflex corner).
   Whether this invariant yields an inequality no assignment meets at six is the milestone.
4. **Route**: derivation. The exact engine checks derived statements on R7 and the held objects and searches for nothing.
5. **Open instances it would decide**: the screen of the search lane's lines 15 and 21 (which labelled rings can be
   discarded before any branching); the card's third branch (whether a ring fits only with unit-arc edges); nothing
   about a disc.

## The routes

- **Route A (taken): count crossings, then read them across.** Claim 1 as "two corners cross"; claims 2–4 as its
  readings at `c = 3`, at a point lacking one label, at a point lacking none; claim 5 as the table reworded; claim 6 as
  "a crossing corner's label is absent across", summed over the cornered points of a ring, the unit-arc edges of the
  centre as the slack. The plan's test of the sum: the slack assignment (must pass), R7 (must pass; expected with
  equality), every unit pair of vertices of the four held objects (must pass).
- **Route B (declined before starting): list-colour the ring.** Colour both sides of `S(x)` from the palettes with
  points 60° apart different. It needs a label of a palette to be *present* somewhere, which the table does not give
  (finding 8); it is the search lane's line 21.
- **Route C (not taken here): the nineteen-point family by cases.** A choice among assignments; a `search request`.

## Stages (each a saved stage of the record; a kill redoes at most the stage in hand)

| stage | work | stop rule | checkpoint; resume |
|---|---|---|---|
| 0 | readback | — | commit; "continue at the first stage not saved" |
| 1 | this plan; the six statements sent to the coordinator | — | commit |
| 2 | recognition (`ephodos-recognition`, fresh) on the six claims | a recognition that differs from this plan is a finding | commit |
| 3–7 | claims 1–5, one a stage: the entry, its argument, its control and plant (`data/fs137/e1/budget.py`, each mode under 120 s) | three failed attempts on one step: a stall, stated | commit after each |
| 8 | claim 6: what an inequality must be; the count; its controls on R7 and on every held object | **a count that fires on R7 or on a held object is a defect: stop and report** | commit |
| 9 | the gate, the predictions scored, the report | — | commit |

**Failure clauses.** A count that excludes a held object or fires on R7: stop, a defect, to the coordinator at once. A
label forced along an arc on an object nobody has read: to the coordinator at once. If the opening has taken more than
two stages: hand back after the fifth claim (it took two: Stages 0 and 1). Scope that outgrows the job — the
nineteen-point family, growing a skeleton — is a `search request`, never run here.

## Registered predictions (each with the decision it serves; scored at the record job)

- **P1** — claim 1 holds at the pointwise form (two corners cross; `m − 2` pure labels at every generic direction for
  one-corner labels): 0.95; and the bound by *labels* fails for a repeated label: 0.95. *Decides*: whether claims 2–6
  are stated through crossings (yes) or through means.
- **P2** — the engine's scan, summed, reads 720° at an R7 lattice point and 540° at each of the bowtie fragment's
  five-label points, all four of them: 0.85. *Decides*: whether the count is trusted on objects before claim 6.
- **P3** — claim 3 holds in a stronger form than posed (either side at either point; total length at most 120°, not
  180°): 0.8. *Decides*: the form sent to the search lane's line 21 as its screen.
- **P4** — claim 4 holds as posed, and no held object has an own-label arc of positive length: 0.9. *Decides*: whether
  G100's "one way" is drafted for rewriting.
- **P5** — claim 6: the count `Σ |L(y_j)| ≤ (k − 2)·n + a` is derived, R7 meets it with equality at seven, and no unit
  pair of vertices of a held object violates it: 0.8. A count that no assignment meets at six: 0.03. A labelled ring
  out to 2 that fits at first order with every unit pair covering, found by derivation: 0.07. *Decides*: which of the
  card's three branches the report names, and whether the asking lane's stop is triggered.
- **P6** — any of this moves the value: 0.005.

## The six statements, as the verdicts will be about them

Fixed in `plans/FS137-E1-derivation.md` Stage 1 (§ 1.2), verbatim, with their *not claimed* lines, and sent to the
coordinator from there.
