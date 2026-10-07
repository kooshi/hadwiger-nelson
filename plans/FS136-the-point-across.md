# FS-136 — the point across: the plan (the readback, §G, §PA, §IQ, the routes, the claims as the verdicts will be about them)

*Written 2026-10-07 (UTC) by FS136-E1 (Ephodos, the opening job; brief `data/fs136/briefs/FS136-E1-opening.md`). Stub
`plans/STUB-covering-pairs.md`; claim list `data/fs136/claims.md` (the coordinator's); inventory `plans/FS136-close-inventory.md`;
the job's record `plans/FS136-E1-derivation.md`. Nothing in this file is derived: it is the opening. A weak six-colouring, a
piece, a pieced point, inner, outer, crossing, separates, a covering pair, its common unit points, the point across: the claim
list's definitions, quoted in § The claims below.*

## The readback

**Quotations.** `data/fs136/e1/quote_check.py` (copied from `data/fs124/p3/quote_check.py`, the brief's path changed): the
brief's 11 quotations against their sources — `quotations=11 mismatches=0`, exit 0 (`data/fs136/e1/quote_check.out`); with
one character of the first quotation altered, `mismatches=1`, exit 1 (`quote_check.fault.out`). No mismatch.

**Read, and how far.** Whole: the brief; `plans/STANDING-RULES.md`; the claim list; the stub; this milestone's inventory;
FS-124's inventory items 21, 26, 28; `plans/FS124-derivation.md` §§ 2–4 (every entry's fields, every control line);
`plans/FS124-E2-derivation.md` § Notation and its arguments "one piece, one side", "four regions, six pieces", "sector
points", "the strip's top edge", "the two points of a pair"; the asking lane's record §§ 1.2, 1.3, 4.1 and its addendum; the
drafts of G97 (amended) and G99 in `plans/FS124-Z1-record.md` ll. 423–464; the entries FS112-N3-COR3, -C-PARTNERS, -EDGE,
-STOP, -DISK-RIM, -CAL-DISK (`plans/FS112-derivation.md`), FS114-Y-PAIRSHARE, -Y-STRIPK6, -Y-PENT, -Y2-BOWTIE, -Y3-RSTOP,
-CV-EXISTS (`plans/FS114-derivation.md`), FS116-Y2-SIXFRAG, -Y2-SIXOFF with its argument (`plans/FS116-Y2-construction.md`
§§ 2.3–2.4), -N2-SIXRING, -N2-FIVERING (`plans/FS116-derivation.md`); FS110-CALC, -N-SEAM, -NB-5, -N-X, -N2-SWAP
(`plans/FS110-derivation.md`) with N-E0, N-E1, N-E2, N-SEAM's proof (`plans/FS110-N-proof.md` § 1.4). Read at a statement
only: `LEDGER.md` rows 133–138, 145–150, 155–160 (their first lines). Not read: C124-LONE's Step II (read before C136-PARTNERS
is derived); the arguments under FS112-N3-COR3; `RUNNING.md` beyond § Make the gate fail (read before the first tool).

**What the job is, in my words.** A point `w`, finitely many points at distance exactly 1 from it, and at each of them
finitely many connected open one-label sets with that point in their closure. Each such set bars its label near `w` on one
side, or on both sides, of the unit circle about its own point (C124-TYPE). The unit circles about the points cut a
neighbourhood of `w` into cells; a cell with every label barred cannot be coloured. The card asks this at the second common
unit point of two points of one ring whose labels are all six. Five first claims: a reading of the held objects in these
terms; the count for two points; the count for one point carrying all six; a bound on partners; and the computation at two
held stops.

## §G — the re-grokking (walked 2026-10-07 from inside this question; every entry of the loaded file by its body)

**Bears** (what it says about this milestone's object, and the phase it changes):

- **G13** (coverage is a k-set property; a pair sweep cannot see it) — the object at the point across is a coverage question:
  every cell cut at `w` by the members' unit circles needs a label that no piece bars there. "`x` or `y` separates" is a
  pair-level necessary condition; the exclusion is the cell statement. *Instruction (the claims)*: derive the cell table
  first, for any finite set of members, and read C136-COVER and C136-ONE off it; *(the reading)*: record cells, not only who
  separates.
- **G86** (a count over tiles is blind to two tiles of one colour; a kill there reads points and distances) — at a pieced
  point two pieces may share a label; a label with an inner piece and an outer piece at one member is barred on both sides.
  *Instruction (C136-COVER, C136-ONE)*: count labels, not pieces — the posed conclusion "has an inner and an outer piece" is
  met by one region cut in two along the circle. This changes two statements (§ The claims).
- **G92** (a held result reaches as far as its argument) — C124-FORCED-PIECES's argument reads neither "three pieces", nor
  "disjoint triples", nor "two members", nor "the pieces fill a neighbourhood". *Instruction*: state the head at the class
  the argument carries — any finite number of members, any number of labels — and place six in the corollaries.
- **G99, drafted and not filed** (`plans/FS124-Z1-record.md` l. 450: before posing a local claim in measure, find the map
  entry it restates) — applied at this opening it found what the stub did not: §PA item 1. *Instruction (every verdict)*:
  name FS110-N-SEAM and FS110-CALC beside the entries the stub names.
- **G96** (ball data and circle data; the one free passage from balls to a circle is a connected piece of definite size) —
  every hypothesis here is ball data at the members; C124-TYPE is that passage, and its radius `η` comes from one point of
  the piece strictly off the circle. *Instruction (C136-STOP)*: every kept region is a named open set with a named witness
  point, never a germ; the flower's kept gap piece must be large enough to hold its witness.
- **G84, G85** (contact; unit parallels) — the edges at the flower's ring points lie on unit circles about other ring points,
  and the unit circle about the point across is tangent to one of them at the member (centres 2 apart: C124-ANTIPODE's
  geometry). *Instruction (C136-STOP)*: at a tangency a cone at the member does not decide a piece's side; read points of
  the piece. G84's amended question — does the hypothesis exclude a contact arc — is answered in each headline.
- **G83** (the tight question lives at one four-colour vertex; hunt the straddle along two unit circles) — this milestone's
  unit; its killing test (a fragment by formula about such a vertex beyond `φ²/√2`) is the card's second branch.
- **G91, G98** (the ring is the pigeonhole; `6 − m` labels are left for the ring of a point of `m` labels) — at `m = 6`
  nothing is left: C136-ONE is that count's last case, and the ring is an interface between the point's own labels.
- **G97, as amended in draft** — say of each exclusion whether it reads palettes or pieces; C136-STOP reads pieces at named
  points, and its headline says that no weak six-colouring is known to have them.
- **G21** (a zero measures its enumeration; a control satisfied with room measures the room) — the three stops are three
  objects built to reach far. *Instruction (the reading)*: the reader's member test is checked on the flower's four-label
  ring points (a positive at the scale of the question) and on R7 (no covering pair); every count names its object.
- **G95** (plant the seven-colouring) — R7 is the control of every claim that spends six.
- **G79** (flip the wanted poster) — the card's ask is what a colouring would have to carry at an empty point; §IQ's
  invariant is what every held point across inside an object does carry.
- **G93** (pose for weak measurable colourings; the radius clause is the consumer) — the class of every claim.
- **G87** — lookout kept; one whiff is logged in the record when it has both sides (§ Registered predictions, P6).

**Falsifiable here**: G83's killing test (not expected to fire: no construction is in this job); G99's reading "every map
statement reading finitely many tiles is one use of the lemma from holding in measure" — C136-STOP on the flower tests it
where the map argument is "second order" (registered, P5); G97's amended killing test (not in play: no palette statement).

**Silent**: G1–G12, G14–G20, G22–G29, G31–G45, G48, G52–G66, G68–G71, G73–G78, G80–G82, G88–G90, G94; and the retired
pointers G30, G46, G47, G49, G50, G51, G67, G72 (carried by this workflow).

**What the re-grokking changed in the plan.** (1) A head statement the card does not pose is added and derived first: the
cell table at a point for any finite set of members (C136-TABLE), from which the second and third claims are read. (2) Two
posed conclusions are restated on labels (G86). (3) The reading records the table's cells at every point across, inside
or not, so a stop is classed by which cell is empty. (4) Each claim's "restates" line is replaced (§PA).

## §PA — the prior-art gate (first pass, before any derivation; the second pass is in the record before the report)

**1. In this project — a finding about the card.** The stub's C-COVER line reads "no held entry found for a member of four
labels", after a search of "`LEDGER.md` rows 135–138 and 145–150 and the derivation files they name". One milestone earlier
the object is held under the same name:

- `data/fs110/claims.md` l. 327: "§0 "covering pair": the union of the closure types is all six; disjointness is an extra
  hypothesis where a lemma needs it (N-X does; C-T-TAN and NB-5 do not)".
- FS110-CALC (`plans/FS110-derivation.md` l. 181; A-EXACT and A-SIX three minds): "no point of the plane sees all six colours
  near distance 1, so the closure types of any family of vertices covering six cannot all block"; N-E0's words
  (`plans/FS110-N-proof.md` l. 83): "likewise `⋂_i B_{u_i}(s) = ∅` for a covering family".
- FS110-N-SEAM (l. 189; two minds, one blind): "For a covering pair at distance below 2 each common unit point lies on the
  boundary set, every tile there lies on one side of the unit circles"; its proof's "*Where six is spent:* in (a), "every
  colour at `w₀` is at `u` or `v`"" and its seven-colour control are the count and the control the card poses.
- N-E2, the contact lemma (`plans/FS110-N-proof.md` l. 96; one mind): two tiles of one colour with points of their closures
  one unit apart are "Siamese" (each inside the closed unit disc about the other's point) or "outer" — the map form of
  C124-TYPE, symmetric in the two points, on whole tiles.
- FS110-NB-5 (two minds, one blind): under Condition 5 "no close covering pair"; FS110-N-X: with no unit arc the seam point
  is a four-colour vertex "with bowties at both ends".

So for maps the count at two points whose colours are all six — members of any number of colours, overlap allowed, a family
of any size — is held since 2026-09-27 at two and three minds, in the form "the tiles at the common unit point lie on one
side". **C136-COVER restates FS110-N-SEAM (a)–(b) with FS110-CALC, not only C124-FORCED-PIECES**; what a measure form can add
is the class (nothing assumed at the common unit point: no tile, no map) and the direction (the conclusion is about the
members' pieces, where N-SEAM's is about the tiles at the point). Sent to the coordinator with the first message.

Also in this project, read: FS112-STOP ("the second common unit point of a close complementary trivalent pair saved at its
first by a four-colour vertex"; two minds) and FS112-EDGE ("`Q` is at distance 1 from two complementary pairs, `(V₀, A₁)` and
`(V₁, A_{−1})`") — the strip's stop is the point across of two pairs on two rings at once; FS112-DISK-RIM ("exactly the ten
`C_k`, `D_k`, each with an open colourless cone of width 108°"; one mind); FS114-Y-PENT ("meet `ω(B_k)` at four distinct
points `A_k, C_k, A_{k+1}, D_{k+1}`"; two minds); FS114-Y3-RSTOP ("the stop is the cone `(−60°, 60°)` at `r`"; two minds);
FS116-Y2-SIXOFF (one mind; its Step 3 read whole); FS112-C-PARTNERS (one mind over two) and FS114-Y-PAIRSHARE (two minds);
FS116-N2-SIXRING (one mind). `grep` for "point across" in the three map files: none; for "second common unit point": the
two FS-112 lines and FS114-Y-STRIPK6's.

**2. In print** (the object named in the disciplines' words: colourings of the plane by regions with a forbidden distance;
tilings and map-type colourings; chromatic number of bounded subsets of the plane). zbMATH Open API, 2026-10-07, twelve
queries with their counts in `data/fs136/e1/pa/zb.out` (script `zb.sh`): `ab:"chromatic number of the plane" & ab:disk` (1),
`ab:"unit distance" & ab:colo* & ab:strip` (1), `ab:"six colo*" & ab:plane & ab:"distance"` (8), `ab:"chromatic number" &
ab:plane & (ab:tiling | … | ab:maps) & ab:"unit distance"` (6), `ab:colo* & ab:plane & ab:"monochrom*" & ab:"unit" &
(ab:regions | … | ab:Jordan)` (3), `ti:"chromatic number" & (ti:disk | … | ti:"bounded")` (27), `ab:"distance 1" & ab:colo*
& ab:plane & (ab:trichromatic | …)` (0), `ab:"unit circle" & ab:colo* & ab:plane & ab:"chromatic number" & (ab:boundary |
ab:arc | ab:arcs)` (1), three author listings (Kruskal 1, Bauslaugh 10, Oostema 1), and a distances-realized query (0).
Titles in the neighbourhood, each with its status: `[Polymath2021]`, `[AxenovichEtAl2014]`, `[SokolovVoronov2025]` (the one
hit of the unit-circle query), `[Parts2020c]`, `[HoffmanSoifer1993]`, `[Mundinger2024]`, `[Soifer1992six]`, `[Coulson2004]`,
`[Townsend1981]`, `[Thomassen1999]`, `[Woodall1973]` — held or listed in `BIBLIOGRAPHY.md`, read as that file says; Kruskal
2008 (Zbl 1139.05023; listed, abstract read by FS112-P: "two- and three-colourings of bounded regions; silent on six-maps");
`[Oostema2020]` (Zbl 1564.68263; named, not held; its summary read now: strips tiled by squares and hexagons, three to six
colours, by SAT — a search for patterns, no statement about a stop); **B. L. Bauslaugh, *Tearing a strip off the plane*,
J. Graph Theory 29 (1998) 17–33, Zbl 0919.05018 — not in `BIBLIOGRAPHY.md`**; its author's summary read now (homomorphisms of
the unit-distance graph of a strip; odd cycles; nothing on regions) — a row is proposed in the report. **None states the
count at a point one unit from two rich points, or why a printed six-coloured region stops.** In print the two nearest
sentences remain the ones FS-112 and FS-114 found in the Polymath16 threads (held): Sirgedas `[16.347]` on the strip ("all 6
colors are within two 'steps' of the new vertex") and de Grey `[17.282]` (trichromatic points sharing no colour at least 2
apart, with slack). Not done in this pass and owed: a citation walk from `[Polymath2021]` in a second database; the threads
re-grepped for the disk's rim.

## §IQ — the invariant question (G72)

**(1) Existence form**, verbatim from the card (`plans/STUB-covering-pairs.md` § Existence form): "Is there a weak
six-colouring of an open set containing the closed disc of radius 2 about a pieced point `p` with four or more labels?"

**(2) Structural form**, verbatim (§ Structural form): "In **every** weak six-colouring of an open set, for every point `p`
and all the pieced points of the unit circle about `p` that lie in the set: which pairs of them are covering pairs; at the
point across of each, which member separates, by which pieces, and which labels are present there; and what must the whole
family of covering pairs on one ring satisfy for every one of its points across within the set to be coloured?" It is not
the existence form reworded (that asks for one disc; this asks what every colouring obeys at every such point).

**(3) The invariant it forces.** The card's candidate is the ring's covering graph. Mine is indexed by the point across, not
by the ring: **the label table at a point `w`** — for each point `x` at distance 1 from `w` that has pieces, and each label
of `x`, one of three states (every piece of that label at `x` inner at `w`; every one outer; neither), and for each cell cut
near `w` by the unit circles about those points, the set of labels no state bars there. Every weak colouring with those
pieces carries a non-empty set at every cell. The ring enters as the list of points `w` it produces (`x + y − p`) and the
member `p` each of them shares. Why not the covering graph alone: on the strip the point across of `(V₁, A₋₁)` about `P₀` is
also the point across of `(V₀, A₁)` about `P₁` (FS112-EDGE), and the pieces that matter at it sit at members of both rings.

**(4) Its route**: derivation (the table from C124-TYPE); a computation only checks a derived table on a named object.

**(5) The open instances it would decide**: FS-124's eight cases as passed here, each as "which cell is empty, by which
members"; the disk's rim points and the flower's far vertices (C136-STOP); whether a ring of a point of four or more labels
can have every point across within 2 with a full table (the card's second branch) — not decided by a table alone, since a
full table is necessary for a colouring and not sufficient.

## The routes, the stages, the failure clauses

One route. **Stage 1**: recognition (`ephodos-recognition`, invoked fresh) on the five claims, saved. **Stage 2**: the
reader `data/fs136/e1/rings_read.py` and C136-RINGS-READ (budget: one stage; stop rule: every object listed in the claim
read or named as unreadable with the reason; checkpoint: `data/fs136/e1/out/<object>.txt`, one file per object, rewritten
whole; resume: `python3 data/fs136/e1/rings_read.py <object>`; a kill redoes one object). **Stage 3**: C136-TABLE, then
C136-COVER and C136-ONE as its corollaries. **Stage 4**: C136-PARTNERS, after reading C124-LONE's Step II. **Stage 5**:
C136-STOP — the flower's far vertex first (its table is small), then the disk's rim; each by named kept pieces, named
witness points and exact comparisons (`data/fs136/e1/stop_check.py`, sympy; under two minutes). **Stage 6**: the second §PA
pass, the sweeps, the report. Each stage is saved and committed before the next; the gate is run from `plans/` on the record
before each commit. No run is expected past two minutes; none needs a slot.

*Failure clauses.* If the reading finds a held stop that is not a point across: a message at once, and the claim's verdict
says which object. If C136-TABLE stalls, C136-COVER is derived directly as C124-FORCED-PIECES was. If a kept piece's side at
a point across cannot be decided exactly (a tangency whose sign is not algebraic in the field at hand), C136-STOP for that
object is a gap at that comparison. If the budget's hand-back line arrives (the brief: after the third claim's verdict when
the reading took more than two stages), the record says where a successor takes over.

## Registered predictions (before any derivation; each with the decision it bears on)

- **P1** — C136-RINGS-READ's statement (the least distance of a point across not inside equals `φ²/√2`, `φ`, `√3`) holds on
  the strip, the disk and the flower: **0.8**; on FS114-Y2-BOWTIE (its stop `(√3, 0)` is the point across of a covering pair
  on the ring of `p`): **0.6**. *Decides*: whether the unit is re-posed (a message) before the claims.
- **P2** — at every held stop the pair's own table (whole tiles at the two members only) already has an empty cell:
  **0.55**. *Decides*: whether C136-STOP names two members or more per object. Not blind for the strip: C124-EDGE-CLOSED's
  argument, read before this line, uses three members, with tiles cut at a line.
- **P3** — C136-TABLE derived as stated below, and C136-COVER and C136-ONE read off it in the restated (label) form:
  **0.93**. *Decides*: whether Stage 3 is one stage.
- **P4** — C136-PARTNERS derived as restated, resting on C124-BOTH: **0.85**; C124-LONE's Step II read and found sound by me
  (a checking reading, not a second mind): **0.8**. *Decides*: the grade line of C136-PARTNERS.
- **P5** — C136-STOP: the flower's far vertex is excluded by C124-TYPE alone with six kept pieces: **0.9 — not blind**: while
  reading FS116-Y2-SIXOFF's Step 3 for §PA I worked its table through and found the horn's witness is a point of the kept
  piece, which C124-TYPE reads as it stands; the number records that, not a forecast. The disk's rim point excluded by
  C124-TYPE with pieces at the members on its unit circle: **0.75** (not worked). *Decides*: whether "second order" names a
  limit of the lemma (the stub's failure clause) or only of cones.
- **P6** — the card's branches, as I read them after the opening: "turns on the ring's type" **0.8**; "always" **0.04**; "a
  ring by formula with every point across filled" appears in this job **0.03**. And one the card does not list: the reading
  shows a point across inside a held object whose pair's table is full with **neither member's separation needed twice** —
  that is, the count is slack somewhere on a held object — **0.3**. *Decides*: the one paragraph of item 5 of the brief.
- **P7** — a held object breaks the card's frame (its stop is not the point across of any covering pair on the ring of a
  point of four or more labels): **0.2**. *Decides*: a message at once.

## The claims, as the verdicts will be about them

*The claim list's definitions and statements stand as fixed by the coordinator; they are quoted from `data/fs136/claims.md`.
What follows is each claim's exact statement as my verdict will be about it, with its not-claimed line. Two are restated,
one is added; each restatement says why. Every one carries: **it does not claim that a weak six-colouring has a piece, a
pieced point or a covering pair.***

> **Definitions, stated once.** `c` is a weak six-colouring of an open set `U`. A **piece** is a connected open subset of `U` almost every point of which has one label. A **pieced point** is a point `x` of `U` with a neighbourhood that is, up to a null set, the union of finitely many disjoint pieces, each with `x` in its closure; its **labels** are its pieces' labels (a three-piece point of FS-124 is one with three pieces and three labels). For `|w − x| = 1` a piece of `x` is **inner at `w`** if it lies in the closed unit disc about `w`, **outer at `w`** if it misses the open one, **crossing** otherwise; `x` **separates at `w`** if it has an inner and an outer piece there (`plans/FS124-E2-derivation.md` § Notation). A **covering pair** is two pieced points `x`, `y` with `0 < |x − y| < 2` such that each of the six labels is a label of `x` or of `y`. Its **common unit points** are the two points one unit from both. For a point `p`, a covering pair **on the ring of `p`** is one with `|x − p| = |y − p| = 1`; `p` is then one common unit point and **the point across** is the other.
> — source: data/fs136/claims.md

**Added by this plan.** A **family of pieces at `x`** is a finite set of pieces of a weak `k`-colouring, each with `x` in its
closure (not assumed disjoint, of different labels, or filling a neighbourhood; the pieces of a pieced point are one). For
`|w − x| = 1` a label `a` of the family is **inner-pure at `w`** if every piece of the family with label `a` is inner at `w`,
**outer-pure at `w`** if every one is outer, **barred at `w`** otherwise. No label is both (a non-empty open set lies on no
circle). `x` **separates at `w` by labels** if the family has an inner-pure label and an outer-pure label.

**C136-TABLE (added; the head).** *Let `c` be a weak `k`-colouring of an open set `U`, `w` a point of `U`, `x_1, …, x_m`
distinct points with `|x_i − w| = 1`, and `𝒫_i` a family of pieces at `x_i`. Then there is `η > 0` such that almost every
point `z` of `B(w, η)` has a label `a` with the property: for every `i` such that `a` is a label of `𝒫_i`, `a` is inner-pure
at `w` for `𝒫_i` if `|z − x_i| < 1`, and outer-pure at `w` for `𝒫_i` if `|z − x_i| > 1`.* *Not claimed*: that a weak
colouring has a piece; anything about a label of no `𝒫_i` (it is unconstrained); a converse — a label left at every cell
does not give a colouring; the largest `η`. *Restates*: FS110-N-SEAM (b) with N-E2 for maps (whole tiles, two members);
C124-FORCED-PIECES's first half at the class its argument carries.

**C136-COVER (restated on labels).** *Let `c` be a weak six-colouring of `U`, `x`, `y` points with `0 < |x − y| < 2`, `𝒫_x`,
`𝒫_y` families of pieces at `x` and at `y` such that each of the six labels is a label of `𝒫_x` or of `𝒫_y`, and `w` a point
of `U` with `|w − x| = |w − y| = 1`. Then `x` or `y` separates at `w` by labels: one of the two families has a label all of
whose pieces are inner at `w` and another label all of whose pieces are outer at `w`.* The claim as posed is its case for the
pieces of two pieced points, with the weaker conclusion "has an inner and an outer piece". *Why restated*: at a pieced point
two pieces may carry one label, and one one-label region cut in two along the unit circle about `w` is an inner piece and an
outer piece — the posed conclusion holds there and says nothing, while that label is barred near `w` on both sides.
*Not claimed*: that a weak six-colouring has a pieced point or a covering pair; which member separates; that the two pure
labels' pieces share more than the member; **that separation suffices** — a cell at `w` can be empty while a member
separates (registered: the flower's far vertex); anything at seven. *Restates*: FS110-N-SEAM (a)–(b) and FS110-CALC's A-EXACT
for maps (§PA item 1); C124-FORCED-PIECES for two disjoint triples.

**C136-ONE (restated on labels).** *Let `c` be a weak six-colouring of `U`, `p` a point with a family `𝒫` of pieces at `p`
whose labels are all six, and `w` a point of `U` with `|w − p| = 1`. Then there is `η > 0` such that almost every point of
`B(w, η)` inside the unit circle about `p` has a label inner-pure at `w`, and almost every point of `B(w, η)` outside it a
label outer-pure at `w`; so `p` separates at `w` by labels, and no label is present near `w` on both sides of that circle.*
*Not claimed*: that a weak six-colouring has a pieced point with six labels; that one label fills a side; that the points
near `w` belong to the pieces of `p` — only that their labels are labels of pieces of `p` lying on that side; anything at
seven. *Restates*: FS116-N2-SIXRING ("the ring lies in Γ … every ring arc is a (Q) arc"; one mind, non-Siamese, a map) and
FS112-SIX (two minds, by FS116-Y2's § 2.3, not read by me).

**C136-PARTNERS (as posed, its terms fixed).** A *sector point*, its three *arcs* (edges) and *full*: `plans/FS124-E2-derivation.md`
§ Notation; a *close complementary sector partner* of `x`: a sector point `y` with `0 < |x − y| < 2` whose three labels are
the three labels `x` lacks. An edge of `x` **begins with an arc of the unit circle about `w`** if for some `r′ > 0` its part
within distance `r′` of `x` lies on that circle. *Let `c` be a weak six-colouring of `U` and `x` a sector point. (i) For each
edge of `x` there is at most one point `w` such that the edge begins with an arc of the unit circle about `w`; so there are
at most three such points. (ii) If `y` is a close complementary sector partner of `x` and both common unit points `w`, `w′` of
the pair lie in `U`, then each is one of those points and `y = w + w′ − x`. (iii) So `x` has at most three such partners.*
*Not claimed*: that a weak six-colouring has a sector point; anything for a partner with only one common unit point in `U`;
anything for a member of four or more labels, or a three-piece point that is not a sector point; that three is attained
except on the Searcher's kept model. *Restates*: FS112-C-PARTNERS (one mind, over two) and FS114-Y-PAIRSHARE's first clause.
It will rest on C124-BOTH, hence on C124-LONE, with that said in its grade.

**C136-STOP (as posed, the regions to be named from the reading).** Two statements of C124-EDGE-CLOSED's form, each: *there
is no weak six-colouring of an open set that contains the point `p′` and the named open sets, and gives almost every point
of each named set its label.* For the flower: `p′ = (√3, 0)`, the point across of `(e(−30°), e(30°))` on the ring of the
six-label vertex of FS116-Y2-SIXFRAG, the named sets among that fragment's tiles at the two members. For the disk: a rim
point named after the reading, the named sets among the disk's tiles at the members on its unit circle. *Not claimed*: any
exclusion of a weak six-colouring that does not keep the named sets — in particular **no statement about every weak
six-colouring of a disc, and no value of the chromatic number of the plane**; that the fragment's other colouring pattern is
excluded; anything at seven. *Restates*: FS116-Y2-SIXOFF (one mind; a map on the whole disc, both patterns) and FS112-DISK-RIM
with FS114-Y-PENT.

**C136-RINGS-READ (as posed)** — a reading; its *statement to verify* as in the claim list. *Not claimed*: that a reading
proves anything about a colouring not read; exactness beyond what each line says (floats, with the three radii checked
exactly); that an object's validity is re-checked here (each object's own entry holds it).

## Second round (FS136-E2, 2026-10-07) — a dated section under what stands

*Everything above is the opening of the first round and stands as written. The second round's card is
`plans/STUB-covering-pairs.md` § The question, second round; its record is `plans/FS136-E2-derivation.md`, which holds its
own readback, its re-walk of the grokkings from inside the new unit (a seed and what it forces), its recognition, the
statements as the verdicts are about them, and ten entries. This section only says what changed in the plan.*

- **The unit**: a finite family of *labelled corners* (germs: a point, two curves from it, a label) and its *forced
  closure* under one step — a corner at `w` on which the corners one unit away bar every label but one has that label
  (C136-FORCED). Not the ring of a point, and not the point across.
- **The invariant (§IQ, item 3, extended)**: the table at a point still; what is added is that a table with one label
  left on a corner is a labelled corner, so the tables at different points are related by the closure (C136-CLOSE).
- **What the round found against its own card**: a closure is a countable family of germs at isolated points, with no
  radius bounded below — never a fragment — **except** where a point carrying all labels but one forces its missing label
  along an arc (C136-COLLAR; inhabited at six by the bowtie fragment's two five-label points). The three seeds of the card
  (the strip's as two) each stall within two steps; the tight seven-colouring's stalls after one, with no corner emptied.
- **Statements changed after fixing**: C136-STOP-GERMS-RADIUS restated (first order at all three stops); C136-COLLAR
  added at the coordinator's request. Nothing else.
- **Open, for the asking lane** (the record's Stage 8, its smallest open form): what two collars, or a collar and a pieced
  point, force one unit further on.
