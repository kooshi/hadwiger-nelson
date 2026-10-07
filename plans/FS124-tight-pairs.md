# FS-124 — what a tight unit pair passes on: the milestone's plan

*Opened 2026-10-07 (UTC) by FS124-E1 (Ephodos; brief `data/fs124/briefs/FS124-E1-opening.md`), at Kooshi's word of the same day
("We move to the standard workflow, attacking 6/7", `data/external/EXT-OAI1-request.md` § Kooshi's sixth word). The question is the
asking lane's card of 2026-10-07 (`plans/STUB-q-ring.md` § The question (Poros, 2026-10-07); record
`plans/POROS-2026-10-07-fs124-question.md`). The claim list is `data/fs124/claims.md` (the coordinator's). The derivation record of
this job is `plans/FS124-E1-derivation.md`. Nothing in this milestone is blind; the kernel is the second check.*

## Readback

Every block quotation of the brief matches its source: `data/fs124/e1/quote_check.py`, 16 quotations, 16 lines, 0 misses, exit 0;
with `--fault` (one character of the first quoted line changed) it reports 1 miss and exits 1. The three quotations from
`plans/FS124-close-inventory.md` are the first lines of items 1–3 (the items continue; read whole). One thing found while reading the
sources, not a mismatch: the correction the inventory's item 2 (c) asks this job to draft — that FS-134's dictionary fact serves the
other direction — is already filed in the stub as a dated correction (`plans/STUB-q-ring.md` ll. 456–458); the replacement for the
provisional bearings in this job's record carries the corrected sentence and drafts nothing further for that line.

## §G — the re-grokking

*Walked 2026-10-07 from inside this question, from the file on disk (`.claude/skills/grokkings/SKILL.md`, 180,656 bytes, G1–G98).
The question, in the words the walk used: a measurable colouring proper at almost every unit pair; two points `q`, `z` one unit apart;
near `z` one label fills the inside of the unit circle about `q` and another the outside. What does that force, where, and at which
number of labels does a count begin to bite?*

**Bears** (each with what it dictates and the phase it changes):

- **G92** (a held result reaches as far as its argument). C132-SHADOW's argument has two halves: a computation that certain points
  have a unit circle meeting the open piece, and a Fubini step that never reads the segment or the direction `v`. The second half
  alone is a statement: *the class of a label is null on the union of the unit circles about the points of an open set carrying
  that label*. **Dictates**: state that lemma once (C124-SHADOW-OPEN) and derive every first-order claim as a computation of one
  open set; do not apply C132-SHADOW four times with four directions. Changes the route of C124-CENTRE and C124-COMPLETION.
- **G84** (contact: a saturated class is carved by unit circles about its own points; `int F = ℝ² ∖ (F + S¹)`). A tight pair of
  kind both is contact from both sides; a tight pair not of kind both has room to move on a side. **Dictates**: (i) the lemma above
  is the open-piece half of the shadow identity, so the complete first-order consequence of a tight pair is the pair of open sets
  `W_a + S¹`, `W_b + S¹`, computed whole — not only at three named points; (ii) every control runs on a model with no margin (R7,
  the strip, the disk, the honeycomb at circumradius 1/2), the honeycomb at 2/5 only where a claim must *not* fire; (iii) kind both
  is what saturation supplies and is never assumed. Changes the statement of C124-COMPLETION (a wider form is derived beside it).
- **G85** (saturated interfaces have integer radii: the unit parallel of an interface is an interface). The unit parallels of an
  arc of radius 1 about `q` are the point `q` (radius 0) and the arc of radius 2 about `q`. **Dictates**: ask what a tight pair
  forces at `2z − q` as well as at `q` and the completions — a claim the card does not pose (C124-ANTIPODE, added). **G88** rides
  with it: a tangent-type arc of radius 2 is exactly what the statement at `2z − q` leaves room for. **G16** too: distance 2 enters
  here as the far parallel, not as a pigeonhole.
- **G91** (the ring is a twisted colouring of its 60° hexagons; change points place four-colour vertices). In the map class what a
  ring passes on is passed at its *change points* — the ends of arcs — never at interior points of an arc. **Dictates**: tightness
  is an open condition along the ring (C124-OPEN, added), so the object has ends; before answering the card's "does it recur", read
  on R7 and on the strip *where* the recurrence sits — at the completions of an interior far end, or at the ends of the maximal
  tight arc. Changes §IQ and the paragraph the brief asks for after C124-COMPLETION.
- **G83** (one four-colour vertex; every kill a straddle along two unit circles). **Dictates**: the first-order rule is not the
  kill. Once it is known, the first test of any first-order-consistent configuration is two pieces of one label pinned by two tight
  pairs coming within 1 — second order. No claim of this job is that test; the plan's route names it as the next round's. G83's
  killing test (a fragment about a tight pair's centre past `φ²/√2`) is the existence form's yes.
- **G96** (circle data and ball data). A tight pair is ball data at `z` that is circle data at `q`; C124-CENTRE is the free passage
  (properness alone). **Dictates**: say of each hypothesis which kind it is. C124-SIX: hypothesis circle data at `q` (six tight
  pairs on its ring), conclusion ball data at `q` (a fifth label present) — well posed. C124-HALF: hypotheses are exclusion sets
  (circle data at `x`, `y`), conclusion ball data at `w` on one side.
- **G97** (every exclusion stops at this object). **Falsifiable here**: its killing test's second clause — "a statement by the
  same tools that excludes, builds or bounds a unit arc about a ring point" — is met if C124-SIX is derived (a first-order count
  that forbids six such arcs at a four-label centre). Registered below (P7).
- **G95** (tightness is not regularity; local slack at seven). **Dictates**: plant slack at seven before believing any statement
  that reads presence at the centre — C124-KIND is that plant; C124-CENTRE and C124-COMPLETION hold at every number of labels and
  must survive it; nothing downstream may read "of kind both" as a property.
- **G60** (no argument one class at a time gives six). C124-SHADOW-OPEN, C124-CENTRE, C124-COMPLETION, C124-ANTIPODE are each a
  statement about one label's shadow: true at every `k`, so silent on six against seven by themselves. **Dictates**: tag every
  claim *per class* (free at every `k`) or *across classes* (spends the count); only C124-SIX and C124-HALF are of the second kind,
  and a recurrence, if there is one at six, must come from a count across classes at a point.
- **G89** (honesty is free; the content of saturation is the top colour). What forces a boundary to be a unit arc at all is
  binding. **Dictates**: "is the completion again an end of a tight pair" cannot be derived for all weak colourings by first-order
  tools unless a count forces it; where it is not forced the question goes to FS-125 and FS-128 by name.
- **G94** (the nerve replaces the map). A tight pair's hypothesis — two open one-label pieces in one ball — is more regularity than
  the nerve gives. **Dictates**: every entry's *not claimed* line says that the class of weak colourings with a tight pair is not
  known to be all weak six-colourings (nor known inhabited at six).
- **G79** (the example invariant). **Dictates**: read what R7, the strip and the disk carry at their tight arcs — windows, cones,
  what sits at the completions and at the ends — before posing the recurrence. Done in the derivation's controls, by formula.
- **G82, G93** (the YES is objects on discs; the plane's number is the measurable one). C124-RADIUS is G82's regular-objects form
  with no limit taken, and its (down) is G93's transfer restricted. **Dictates**: (up) by a random rigid motion on one disc per
  finite graph — no weak-* limit, no hole count (row 145's route is not needed).
- **G86** (tile counts are blind to Siamese pairs). C124-SIX counts directions at one point and reads no tile. **Dictates**: no
  claim may read "a tile is one connected piece of diameter at most 1".
- **G21** (a negative measures its enumeration; a control satisfied with room measures the room). **Dictates**: each control's line
  says whether the hypothesis is tight on its model, and how many times the conclusion was met non-vacuously.
- **G13** (coverage is a `k`-set property invisible to pair sweeps). C124-SIX is a coverage statement at a point — do four labels
  cover the directions at `q` — that no single tight pair sees. **G22**: every six-coloured map has non-polygonal classes; unit arcs
  are the only curved boundaries any held six-coloured object has. **G90**: the case C132-SHADOW declines (`v` tangent) is the
  sagitta regime; the arc form (two tight far ends) replaces it. **G98**: on every six-coloured object held the ring's changes are
  60° apart — the ends of tight arcs; it bears on the skeleton round, not on the first claims. **G87**: on the lookout; none raised
  at the opening.

**Silent**: G1–G12, G14, G15, G17–G20, G23–G29, G31–G45, G48, G52–G59, G61–G66, G68–G71, G73–G78, G80, G81 (the arithmetic era, the
finite planes, the cell family, lattices and characters: none reads a boundary of a measurable class). **Retired pointers** (carried
by the workflow, used as such): G30, G46, G49, G50 (§PA), G47, G51, G67, G72 (§IQ).

**Ledger rows, by mechanism** (rows 135, 136, 138 read at their statement cells; 133, 134, 137, 145–150 through `CLAUDE.md` and the
stub's quotations only): 135 — the rhombus lemma and the reduction of every unit arc to (Q) or to the radius-2 configuration, "by
merges and whole-arc bends": a move, so in measure (Q) is a hypothesis; 136 — "every unit arc of kind both and centred at a
four-colour vertex", and the stop "at the unsaved second common unit point"; 138 — "every tile's cone and colour is pinned by the
half-planes facing the edges' centres", the cone form C124-CENTRE restates, and "every kill is a straddle"; 145 — fragments at
every radius give six, for arc maps, by a weak-* limit (in Lean: `chromaticNumber_plane_le_six_of_fragments`); C124-RADIUS (up)
is its form for every weak colouring.

**What the re-grokking changed in the plan.** (1) One lemma first (C124-SHADOW-OPEN), the claims as its corollaries. (2) Two claims
added: C124-OPEN (the object is an arc with ends) and C124-ANTIPODE (the radius-2 parallel). (3) C124-COMPLETION derived beside a
wider form (every point one unit from `z` except `q` and `2z − q`). (4) The recurrence is asked at arc ends, read first on R7.
(5) Each claim tagged per class or across classes. (6) One prediction registered against G97.

## §PA — the prior-art gate

*Run 2026-10-07, 13:02–13:05 UTC, before the derivation; again before the report (the record says what the second pass added).
Instruments: the zbMATH Open API (`data/fs124/e1/zb.py`; full listings in `data/fs124/e1/pa/zb-log.txt`) and the arXiv API
(`data/fs124/e1/pa/arxiv-log.txt`). The reviews database answered every query (last night it returned an error at every attempt).
**Everything below is a listing unless it says "held"; no paper was opened by this pass.***

1. **The object, in its disciplines' words.** *Combinatorial geometry*: a set avoiding distance 1 whose boundary contains an arc of
   the unit circle about a point of the closure of another piece of the same partition; *convexity*: Reuleaux polygons, bodies of
   constant width, spindle (ball) convexity — a tile "pinned along an arc by its own point" is locally an intersection of unit
   discs; *map colouring*: map-type and tile-based colourings (Woodall, Townsend, Coulson, Thomassen, Sokolov–Voronov);
   *geometric measure theory*: the interface and the multiple junction of a measurable partition; *this project*: contact (G84).
2. **Searched, two disciplines and more.** zbMATH: `(ab:"avoiding unit distance" | … | ab:"distance-avoiding") & (ab:boundary |
   ab:arc | ab:"Reuleaux" | ab:"constant width")` — 2 hits, neither on point; `(ab:"Reuleaux" | ab:"constant width") &
   (ab:"chromatic number" | ab:coloring | ab:colouring) & (ab:plane | ab:tiling)` — 2 hits, both proceedings volumes; `(ab:"spindle
   convex" | ab:"ball polyhedra" | ab:"hyperconvex" | ab:"Reuleaux polygon") & (ab:tiling | ab:partition | ab:packing | ab:"unit
   distance")` — 2 hits, one in the neighbourhood by title (Lopez-Campos, Oliveros, Ramírez Alfonsín, *Borsuk and Vázsonyi problems
   through Reuleaux polyhedra*, 2025, Zbl 1580.52001; a reviewer's review exists; not opened — diameter graphs in space, a
   prior-art debt of low bearing); `(ti:tiling | ti:tilings | ti:"map-type" | ti:"tile-based" | ti:polygonal) & (ab:"chromatic number
   of the plane" | ab:"Hadwiger-Nelson" | ab:"unit distance")` — 4 hits, all held or known to the bibliography's lineage
   (`[deGreyParts2022]`, Coulson 2004 and 2003, Sokolov–Voronov, now with a 2026 journal record); `ti:"unit distance" & (ti:arc |
   ti:arcs | ti:circle | ti:circles) & (cc:05C15 | cc:52C10)` — 0. arXiv: `all:"chromatic number of the plane" AND (all:Reuleaux OR
   all:"unit arc" OR all:"arcs of unit" OR all:"unit circles")` — 2 (`[SokolovVoronov2025]`, held; 2301.13695 on Minkowski planes,
   title only); the abstract-only form of the same query returned 0 and was checked against a known positive (`ti:"map-type" AND
   ti:chromatic` finds 2502.01958), so the zero was the field, not the instrument; `abs:"avoiding unit distance" OR …` — 5, all
   held (`[AmbrusEtAl2023]`, `[CohenMani2025]`, `[MatolcsiEtAl2025]`) or off the object.
3. **The question, not only the method.** "What does a boundary arc of radius 1 centred at a vertex force" is posed in print only
   as Sokolov–Voronov's Question 2 with unit arcs (held; row 135 reduces it) and in `[Polymath16threads]` thread 8 (held, searched
   2026-09-09). Nothing found posing it for measurable colourings.
4. **The triple junction of a measurable partition** (owed by nine of last night's entries). zbMATH, three vocabularies:
   `(ab:"triple junction" | ab:"triple point" | ab:"multiple junction") & (ab:"measurable partition" | ab:"Caccioppoli partition" |
   ab:"Lebesgue density" | ab:"density point" | ab:"measurable sets")` — 0; `(ab:"Lebesgue covering" | ab:"covering dimension" |
   ab:Sperner | ab:"KKM") & (ab:"density point" | ab:"Lebesgue density" | ab:"positive density" | ab:"measure-theoretic boundary") &
   (ab:partition | ab:cover | ab:covering)` — 0; `"density topology" & ("covering dimension" | "topological dimension" | "Lebesgue
   covering")` — 0; `(ab:"three sets" | …) & (ab:"density point" | …) & ab:plane` — 0; `(ab:"nerve") & (ab:"measurable") & …` — 0.
   Read as: the regularity theory of junctions in print is for perimeter-minimising clusters, not for arbitrary measurable
   partitions, and the covering-dimension argument for a point where three classes of a measurable partition meet is, as far as
   these searches reach, `[OAIMath2026]` § 6's. One-sided: `ab:` misses records whose summary is withheld, and no author listing
   was pulled (item 8 of the gate) — **a debt**, named in the report.
5. **C124-RADIUS: local to global for almost-proper colourings of discs.** The proper form is classical (de Bruijn–Erdős: the plane
   is `k`-colourable iff every bounded part is). The bounded case as a subject: C. P. Kruskal, *The chromatic number of the plane:
   the bounded case* (2008, Zbl 1139.05023; **held at abstract**, `BIBLIOGRAPHY.md` l. 903) — proper colourings of bounded regions.
   The random-rigid-motion argument for a colouring proper at almost every unit pair of the *whole plane* is in print
   (`[GwynStavrianos2022]` Lemma 2, Thm 2; held) and in this library (N-EASY, `chromaticNumber_plane_le_chiM0`). For a disc, or an
   open set: `(ab:"probabilistic Hadwiger" | (ab:"almost every" & ab:"unit distance" & …))` — 0 in zbMATH; arXiv `(abs:"Hadwiger-Nelson"
   OR abs:"chromatic number of the plane") AND (abs:"almost every" OR abs:"almost all" OR abs:"measurable") AND (abs:disc OR abs:disk
   OR abs:"bounded" OR abs:"local")` — 3, none on point by title. **Not found in print**; the step from the plane to a disc is one
   line (the motions carrying a finite set into an open set form a non-empty open set), so "not found" is said, never "new".
6. **Outside arXiv / citation graphs / author listings** (gate items 4, 5, 7, 8): not done by this pass beyond the zbMATH title
   queries (`au:` Woodall and Kruskal found their records; `au:"Townsend, Stephen"` finds none — Townsend's papers are held under
   the bibliography's own key). A debt, with item 4's.

**Result.** Nothing found in print states what a tight unit pair forces at its centre, its completions or its antipode for a
measurable colouring, or the disc form of the local-to-global clause; every neighbouring work found is held or is a title in a
listing. The negative is a finding about where the unworked ground is, at the reach stated.

## §IQ — the invariant question

1. **Existence form** (the card's, verbatim, `plans/STUB-q-ring.md` § Existence form of 2026-10-07): "Is there, for every `R > 0`,
   a weak measurable six-colouring of the open disc of radius `R`? By C124-RADIUS below (posed) a yes is `χ(ℝ²) = 6` and a no at one
   radius is `χ(ℝ²) = 7`: the existence form needs no vertex, no seed and no map. Its form at the object: is there a weak
   six-colouring of an open set containing the closed disc of radius `r` about the centre of a tight pair of kind both, for some `r`
   above `φ²/√2`?"
2. **Structural form** (verbatim, the same section): "In **every** weak measurable six-colouring of an open set, and for every
   tight pair `(q, z)` in it: which labels are present at `q`, at `z` and at the two rhombus completions, and in which directions at
   each; which unit pairs through those four points are then tight, and for which labels; and is there a datum, defined at a point
   from the tight pairs through it, that every colouring carries from `q` to each point it forces to be an end of a tight pair?"
   It is not the existence form reworded: it quantifies over every colouring and asks what each carries; the existence form asks
   whether one exists.
3. **The invariant it forces — and whether the card's candidate is the one.** The card names "the first-order datum (for each
   label, the set of directions at the point in which it is present, and for each unit pair through the point and each label present
   at both ends whether the label lies between the two ends or apart)". **Assessment, before the derivation (to be scored)**: the
   candidate is of the right kind and has the wrong unit, in two ways. (a) *The carrier is an arc, not a pair*: tightness is open
   along the unit circle about `q`, so the object is the open set of tight directions on `q`'s ring for an ordered pair of labels —
   maximal arcs with ends. What sits at the rhombus completions of an *interior* far end is, by the claims as posed, only the
   absence of two labels, at every number of labels: a constraint, not a datum that is carried on. If anything recurs it is at the
   *ends* of the maximal arcs (the map class's change points and vertices; G91). (b) *The relation the datum obeys is a polarity*:
   at `q`, each label's directions of presence lie within 90° of every ring direction where that label fills the inside, and at
   least 90° from every ring direction where it fills the outside. So the invariant proposed here is the pair *(cones of presence at
   `q`; tight windows on `q`'s ring, with sides)* under that polarity, and the count that spends six is the total angle of the cones
   at one point (C124-SIX is its first instance). **None known beyond first order**: whether an end of a maximal tight arc of kind
   both is forced to centre tight arcs is the milestone's question, and it is not a first-order statement at any `k`.
4. **Route**: derivation only; computation checks derived claims on the held objects by formula.
5. **Open instances it would decide**: the stub's cases 1, 3, 4, 5 read as local rules of the skeleton; the rules of the
   label-skeleton search the asking lane drafted (`plans/POROS-2026-10-07-fs124-question.md` § 3.2 — on which points constraints
   live); C132-PLACED's open line; whether FS-125's class (saturation) is where the NO must be stated.

**A finding for the asking lane, from §IQ**: the card's unit — a tight pair and its two rhombus completions — reads the object at
an interior point of an arc. On R7, the one inhabitant "at seven" the card names, the completions of an interior far end are
interior points of a one-label tile; the lattice points are the arcs' ends. The derivation's paragraph after C124-COMPLETION says
this with the exact reading.

*Dated line (2026-10-07, this job's Stage 4; the text above stands as registered).* Scored against the derivation and its
controls: the assessment's first half held — at the completions of an interior far end the first-order rule gives the absence of
two labels and nothing else, and that is not special to tight pairs (C124-STRADDLE). Its second half — "if anything recurs it is
at the ends" — is R7's shape (6 of 6 ends centre tight arcs) and the disk's pentagon's (10 of 40), and is **false of the strip**
(0 of 92 ends of its unit-arc pieces centre a unit arc; control `maps-ends`). So the finding for the asking lane is narrower than
the paragraph above says: the card's unit reads the object at a place where nothing is carried on; the ends are not that place
on every held object either; what the three held objects share is the centre, of kind both for several arcs at once
(`plans/FS124-E1-derivation.md` § What the datum at a completion is). The route's item (i) below is changed with it: the next
round's unit is the centre with all its tight arcs.

## The plan proper

**Tags.** *Per class* (true at every `k`; cannot alone move six against seven, G60): C124-SHADOW-OPEN, C124-OPEN, C124-CENTRE,
C124-COMPLETION with its wider form C124-STRADDLE, C124-ANTIPODE, C124-RADIUS. *Across classes* (spend the count): C124-SIX,
C124-HALF. *A calibration*: C124-KIND.

**Route.** One lemma: for an open set `W` carrying the label `i` almost everywhere, the class of `i` is null on `(W + S¹) ∩ U`.
Then each first-order claim is the computation of `W + S¹` near a named point for the two collars `W_a = B(z, ρ) ∩ B(q, 1)`,
`W_b = B(z, ρ) ∖ B̄(q, 1)`: near `q` (C124-CENTRE), near every point one unit from `z` other than `q` and `2z − q` (C124-STRADDLE;
the completions are two of them), near `2z − q` (C124-ANTIPODE). C124-RADIUS: a random rigid motion on one open set per finite
graph, then de Bruijn–Erdős; (down) the declared outside theorem and restriction. C124-KIND: the honeycomb at circumradius 2/5
with one cap, margins in exact rationals. C124-SIX: C124-CENTRE three times per label and the geometry of three unit discs through
`q`. C124-HALF: C132-WIT-SIDE at `w` for five of the six sets.

**Stages** (each saved and committed before the next; budgets are guidance):

| stage | content | budget | stop rule | checkpoint | resume | a kill redoes |
|---|---|---|---|---|---|---|
| 1 | this plan; the record's readback and drafts; the claims' statements to the coordinator | 60k | plan committed | this file; the record's Stage 1 | read the record's last SAVED stage | the stage |
| 2 | recognition (`ephodos-recognition`, fresh) on the assigned claims | 15k | saved | the record's Stage 2 | — | the stage |
| 3 | C124-RADIUS (up, down), its relay and the five-colour corollary; control `radius-motions` | 25k | verdicts saved | Stage 3 | `python3 data/fs124/e1/tight_checks.py radius` | the stage |
| 4 | C124-SHADOW-OPEN, C124-OPEN, C124-CENTRE, C124-COMPLETION, C124-STRADDLE, C124-ANTIPODE; the paragraph on the datum at a completion; controls on R7, the strip, the disk, the honeycomb at 1/2 | 50k | verdicts saved | Stage 4 | `… tight_checks.py maps`, `r7`, `hexhalf` | the stage |
| 5 | C124-KIND, C124-SIX | 30k | verdicts saved | Stage 5 | `… tight_checks.py kind`, `cones` | the stage |
| 6 | C124-HALF | 30k | verdict saved, or handed to a successor | Stage 6 | — | the stage |

No run exceeds two minutes; every script and output is under `data/fs124/e1/`. No search: a step a search could decide goes to the
report as a `search request`.

**After the first-order rule (this job's Stage 4), the route for the next round** — written now so that it can be wrong: (i) the
unit becomes the maximal tight arc and its two ends; (ii) the first question at an end of an arc of kind both is a count across
classes at that end (which labels can be present there, given the cones the arc forces at `q` and the absences it forces on the
straddle set) — where six is spent; (iii) the first kill to try on any configuration that survives the first-order rules is G83's
straddle between two pieces of one label pinned by two tight arcs.

## Registered predictions (2026-10-07, before any derivation; each with the decision it drives)

- **P1.** C124-RADIUS (up) derived as posed, and in the wider form (any open set `U`, any finite `V ⊂ U`, almost every rigid
  motion keeping `V` in `U`): 0.95. (down) derived at every `k ≥ 1`: 0.95. *Decides*: the kernel lane's first module of this
  milestone (the wider form is the statement to plan).
- **P2.** C124-CENTRE derived as posed: 0.97. C124-COMPLETION derived as posed: 0.95, and in the wider form C124-STRADDLE: 0.90.
  C124-ANTIPODE (near `2z − q`: `b` absent; `a` absent inside the circle of radius 2 about `q`) derived: 0.85. *Decides*: whether
  the drafted label-skeleton search places constraints at lattice points only, or along whole circles and at distance 2.
- **P3.** The card's branches, for one tight pair by first-order tools: "nothing is forced beyond the first step" at the
  completions of an interior far end, at every `k`, exhibited at seven by a colouring with exactly one maximal tight arc: 0.85.
  On R7 every end of a maximal tight arc is a centre of tight arcs and no completion of an interior far end is an end of one: 0.90.
  *Decides*: the next round's unit (arc ends, not completions) and what the search request is posed on.
- **P4.** C124-KIND true by formula, both margins exact: 0.93. *Decides*: every later statement names the kind it needs.
- **P5.** C124-SIX derived as posed: 0.85; and found to say less than its wording (no held object meets its hypothesis; the
  hypothesis forces more than a fifth label): 0.40. *Decides*: whether the count is restated as an angle inequality at a centre.
- **P6.** C124-HALF derived as posed: 0.75. *Decides*: whether the skeleton round may start from a complementary pair.
- **P7.** G97's killing test fires in its second clause (a first-order statement bounding unit arcs about ring points is derived
  in this job): 0.80. *Decides*: a rewrite of G97 drafted at the record job.

## Failure clauses

A claim met only by a degenerate case, vacuous on the held objects, or saying less than its wording is restated and the reason
given; a claim refuted is refuted by an exhibited object with an exact check; a stall names its step and its smallest open form.
No statement about weak six-colourings with a tight pair is called a statement about weak six-colourings; no class is called
inhabited at six. Any statement that would fix the value of `χ(ℝ²)` goes to the coordinator at once as "claimed by one mind,
unchecked".

## Second round (FS124-E2, 2026-10-07) — dated additions; everything above stands as written

*Added by FS124-E2 (Ephodos; brief `data/fs124/briefs/FS124-E2-second-round.md`; record `plans/FS124-E2-derivation.md`; scripts and
outputs `data/fs124/e2/`). The object has changed since §G was written — from one tight pair read outward to a close complementary
pair of three-piece points and its common unit points (`plans/STUB-q-ring.md` § The question (Poros, 2026-10-07, after the first
round)) — so the grokkings are walked again from inside it.*

### Readback (second round)

`data/fs124/e2/quote_check.py`: 13 quotations, 13 lines, 0 misses, exit 0; with `--fault` 1 miss, exit 1. Read whole: the card's
section, `plans/FS124-E1-derivation.md`, `plans/POROS-2026-10-07-fs124-round1.md`, the claim list, this plan; of
`plans/FS132-derivation.md` the entries C132-WIT-SIDE, C132-SHADOW, C132-WITNESS, C132-CROSS, C132-COMP-SHARP with their prose (the
arguments in the E4/E5 records not opened: this round re-derives what it uses from C124-SHADOW-OPEN).

### §G, walked again from inside the save

*The object in the walk's words: two points `x`, `y` less than 2 apart; near each, three connected open one-label pieces, six labels
in all; a point `w` one unit from both. What must the pieces look like at `x` and `y`, what is present at `w`, and what is carried
to the other such point?*

**Bears** (what each dictates for this round):

- **G92** (a held result reaches as far as its argument). C132-COMP-SHARP's argument reads of an "edge set" only two of its points,
  each in the closure of one connected piece. **Dictates**: state the rule on *pieces*, not on edges or exclusion sets — a piece
  with a point strictly inside (outside) the unit circle about `w` bars its label near `w` outside (inside) the unit circle about
  its member — and read every claim as a statement about which pieces lie on one side of that circle. Changes the route of every
  claim; an open set is never inside a circle, so every piece is barred on a side at once, with no pigeonhole on edges.
- **G96** (circle data and ball data). A three-piece point is ball data at `x` and at `y`; what it bars at `w` is circle data; the
  passage is the one G96 names as free — a connected piece of definite size. **Dictates**: hypotheses of one kind (pieces at the
  members); conclusions at `w` and, back through C124-SHADOW-OPEN, at the members. "Every weak six-colouring has a three-piece
  point" is the regularity stubs' and is in no claim.
- **G83** (one four-colour vertex; every kill a straddle along two unit circles). A saved point is G83's vertex seen from its cause.
  **Dictates**: the first test of a save by one member is two unit circles through that member — the one about `w` and the one about
  a neighbour `w′` of `w` on the member's ring — and the thin regions between them. Run before any object is designed.
- **G91** (the ring is the pigeonhole; before building on a type ask whether it is inhabited, testing the straddle among the forced
  pieces first). **Dictates**: in C124-ONE-MEMBER exclude first, build second; `w` is a change point of both members' rings.
- **G84** (contact). The saving boundary is carved by the unit circle about a point one unit from it, both sides present there:
  contact forced by a count. **Dictates**: every control on an object with no margin (all held six-coloured objects; R7); the
  honeycomb at 2/5 only where a claim must fail at seven.
- **G97** (every exclusion stops at the unit arc about the other end). Here the arc is forced, not excepted. **Falsifiable here**:
  its killing test's second clause — "a statement by the same tools that excludes, builds or bounds a unit arc about a ring point" —
  is met if a save by one member is excluded in a named class. Registered (Q5).
- **G98** (six is the one count at which the ring's labels can wind). A three-piece point leaves its ring three labels; a
  complementary partner carries exactly those three. **Dictates**: read C124-SECOND's cyclic order as what the two rings exchange at
  the two crossing points; no winding number is taken in this round.
- **G86** (Siamese pairs). The save's exception is a point where a label's germ is not connected (a bowtie). **Dictates**: "three
  connected pieces" and "every two pieces share boundary at the point" go in the headline of every statement that needs them.
- **G60, G13** (one class at a time gives nothing; coverage is a set property). The count enters once: each of the four regions cut
  at `w` by the two unit circles needs a label, and two triples are all six. **Dictates**: tag the statements; the per-class lemma
  is stated once.
- **G95, G94** (tightness is not regularity; the nerve gives less than a map). **Dictates**: the failure at seven by formula; no
  claim that a three-piece point exists.
- **G21, G79** (a reading measures its enumeration; the example invariant). **Dictates**: the reading enumerates vertices from the
  tiles' own pieces, not from the ends of unit arcs, and says so; what every held save carries is read before the derivation is
  written down. **G22** (non-polygonal classes): a save needs a boundary on a unit circle. **G85**: the saving arc's inner unit
  parallel is the point `w`. **G87**: on the lookout (one item for the report: a held map-class result the card did not read).

**Silent**: G1–G12, G14–G20, G23–G29, G31–G45, G48, G52–G59, G61–G66, G68–G71, G73–G78, G80–G82, G88–G90, G93. **Retired pointers**:
G30, G46, G47, G49, G50, G51, G67, G72.

**Rows, by mechanism** (133–136 read at their statement cells; FS112-N3-COR3 and FS107-W-TAN at their statements,
`plans/FS112-derivation.md` l. 158, `plans/FS107-derivation.md` l. 100, and N3-COR3's verification note,
`plans/FS112-NB3-verification.md` ll. 120–131). **For maps the card's question is already answered in this project**: FS107-W-TAN —
two vertices under 2 apart with complementary three-sets "form a tangent pair or include a bowtie"; FS112-N3-COR3 (row 135; two
minds, one blind) — a close complementary pair of cubic trichromatic vertices of a valid map "sits on a unit rhombus … whose other
corners are vertices of at least four colours, each a leaving centre of both", with the line "**One failure is not enough**". So in
the map class a save by one member is excluded and at least four colours are forced, the bowtie the only exception. The card's
hunch ("one edge of each member is not forced … nobody has built one") did not read these. What is open is the measurable form.

**What the re-walk changed.** (1) The unit of every statement is the piece and its side of the unit circle about `w`. (2)
C124-ONE-MEMBER is attacked as an exclusion first, in measure, by G83's two circles. (3) A statement is added that the card reads
but does not pose: which labels are present at a saved point. (4) Three classes are kept apart: three-piece points by the letter,
those whose pieces pairwise share boundary at the point, and sector points (a map's three-tile vertices).

### §PA (second round)

*14:13 UTC, zbMATH Open API (`data/fs124/e2/zb.py`, log `data/fs124/e2/pa/zb-log.txt`); listings only.* In the map class's words:
`(ab:"trichromatic" | ab:"tricolored" | ab:"triple point" | …) & (ab:"chromatic number of the plane" | ab:"unit distance" |
ab:"forbidden distance" | ab:"Hadwiger-Nelson")` — 0; `(ab:"map-type" | ab:"map coloring" | ab:"tile-based" | ab:"tiling") &
(ab:"chromatic number of the plane" | ab:"Hadwiger-Nelson") & (ab:"six" | … | ab:"vertices")` — 0 (the first round's title query
found the four held works; this abstract form finds none, so the zero is the field). In measure: `(ab:"measurable chromatic number" |
ab:"measurable coloring" | …) & (ab:plane | ab:"Euclidean") & (ab:boundary | ab:tile | ab:map | ab:junction | ab:arc …)` — 1, off
the object (the taxicab plane). **In print for maps, by this project's records, not re-read by me**: trichromatic points sharing no
colour are at least 2 apart in a tiling avoiding an interval of distances (de Grey, cited at `plans/FS112-derivation.md` l. 396 as
`[17.282]`); the regular form `[Voronov2023]` Prop. 2.2 (by FS106-TAN); the edge exclusion `[SokolovVoronov2025]` Props. 1–2 (row
134); the rescue by a unit arc is in print only as the two objects of row 136 (`[AxenovichEtAl2014]` Thm 4.2's strip,
`[Polymath2021]` Fig. 10's disk), with no statement that it is forced. **The measurable form: not found in print**, at this reach
(two vocabularies, one database, no author listing — a debt).

### §IQ (second round)

Both forms are the card's (`plans/STUB-q-ring.md` §§ Existence form, Structural form, of the section "after the first round").
**The invariant the structural form forces, as this round proposes it before deriving**: for each member and each common unit point,
the *side* of each of the member's three pieces with respect to the unit circle about the point — inside, outside, or crossing. The
card's candidate (the pattern with a cyclic order) is a function of it. Route: derivation; the reading checks derived shapes.

### Route and stages (second round)

One lemma (C124-TYPE: a connected open one-label piece with its member in its closure and a point strictly inside, or outside, the
unit circle about `w` bars its label near `w` outside, or inside, the member's unit circle — C124-SHADOW-OPEN and one intermediate
value). Then: the count over the four regions at `w` (C124-FORCED in piece form); the half-window at `w` when one member does not
separate, C124-CENTRE's computation at the other member for one neighbour `w′`, and the two thin regions between the unit circles
about `w` and `w′` (C124-ONE-MEMBER); the labels present (added); the strip's top edge by formula (C124-EDGE); the two points of a
pair (C124-SECOND). Stages, each saved and committed: 1 this addition, the readback, the claims as stated; 2 recognition; 3 the
reading (`data/fs124/e2/saves_read.py`; no run over two minutes); 4 C124-FORCED with the failure at seven; 5 C124-ONE-MEMBER and
the labels present; 6 C124-EDGE, C124-SECOND, the report. A kill redoes the current stage.

### Registered predictions (second round)

*Registered 14:20 UTC, before any entry was written and before any held object was read by this job — but after a first analysis
by hand in the session (the route above is that analysis), which is said here because it makes the derivation predictions less
blind than the reading's.*

- **Q1 (the reading).** On the strip and the disk, read from the tiles (every three-tile vertex, not only arc ends): every common
  unit point inside is saved with one boundary piece of each member on its circle, 0.85. Some held object shows a pattern other than
  (1, 1): 0.8. At every common unit point inside a held object, every member that is a three-sector vertex has a piece inside and a
  piece outside the unit circle about the point: 0.9 — *a miss is a defect in the route, to be found before anything is derived on
  it*. Some held fragment shows a point saved by a bowtie member alone: 0.6. *Decides*: whether Stage 5 is written as an exclusion.
- **Q2 (C124-FORCED).** Derived in piece form for three-piece points by the letter: 0.9; as posed for sector points: 0.9; as posed
  by the letter it fails where two pieces meet only at the member: 0.7. *Decides*: the statement the kernel lane plans.
- **Q3 (C124-ONE-MEMBER).** For members whose pieces pairwise share boundary at the member, a save by one member is excluded: 0.85;
  an object by formula with a save by one member at a point of that kind: 0.03. *Decides*: the card's branch; whether the drafted
  search (queue line 14) is asked.
- **Q4 (C124-EDGE, C124-SECOND).** The top-edge computation holds as read: 0.8. C124-SECOND derived as posed for sector points:
  0.9. Exactly four labels at a point saved by one boundary of each sector member, derived: 0.8.
- **Q5 (G97).** Its killing test fires in the second clause: 0.8. *Decides*: a rewrite drafted at the record job.
