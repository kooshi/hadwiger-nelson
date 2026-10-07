# Poros — FS-136 at Derived: the re-read, the re-rank, the next card (job FS136-P2, 2026-10-07)

*The asking lane's record for brief `data/fs136/briefs/FS136-P2-rerank.md`. Carried forward from
`plans/POROS-2026-10-07-fs136-round1.md` (its hunch ledger). Everything here is a question, a reading or a ranking; this
lane derives nothing, and a sentence of mine that looks like an argument is a hunch with its basis `derived` in the ledger,
at one mind, unchecked, until a deriver takes it.*

## Theorems this phase proved

None. This job proves no theorem.

## Stage 0 — SAVED: the readback, and the expectations written before the items they are about were opened

### 0.1 The readback

Quotations: **12 of 12 match** (`data/fs136/p2/quote_check.py`, copied from the first round's with the brief's path changed;
output `data/fs136/p2/quote_check.out`, exit 0; with one character of the first quotation altered it exits 1 with
`mismatches=1`, `data/fs136/p2/quote_check.fault.out`). No finding about the brief from the readback.

### 0.2 What was seen before any expectation of mine was written

- The brief whole, with its five quoted inventory items (10, 11, 12, 14, 17), the two report lines and four table rows.
- `CLAUDE.md` and the grokkings file as loaded at launch (G96–G100 among them).
- The outline (headings and ledger statuses only) of `plans/POROS-2026-10-07-fs136-round1.md`.
- Three lines of `plans/STUB-collars.md` returned by a search for the map entry's name: it is **FS116-N2-FIVERING**
  (`plans/FS116-derivation.md` l. 655), "in a valid fragment on a closed disc of radius above 1 about a vertex p of five
  colours, Siamese pairs allowed, the ring has no change point". Seen, not read.
- The file names under `data/fs136/e2/out/`.
- **A relay from the coordinator at 19:44 UTC**, the kernel planner's four generalizations found by typing seven statements
  blind ("each checked by it against the built branch only — iteration, not yet a build"; its record not committed, so the
  primary is unread by me and the relay is the coordinator's words): (1) C136-TABLE reads neither distinct points nor the
  distance 1 nor six nor measurability; (2) the two counts read "six" in one sentence each; (3) the one-point clause "no
  label is present near `w` on both sides of that circle" holds for any finite family of pieces at `p` and any `w`; (4)
  the forward step's label half needs no corner — "almost every point of `B(w, η)` on the stated side of every `S(x_i)`
  has the label `ℓ` — the whole set of such points, connected or not", and in the tangent case "the two corners outside
  both circles are forced together or not at all". It is an inventory item below; my card states its claims at the wider
  forms or says why not.

### 0.3 What I worked out before opening anything (hunches, each registered in the ledger with its falsifier)

Written so that the reading can contradict them. The mechanism I hold from the brief's item 12 (the coordinator's own
check): at a point `p` and a ring point `w`, the labels allowed just inside `S(p)` near `w` are the labels absent at `p`
together with the labels of `p` all of whose corners lie wholly on `w`'s side of the tangent at `p` (call such a label
*pure* on that side); a side is forced where that set has one element, empty where it has none.

- **H-a (derived, mine, one mind, unchecked).** A collar arc cannot be longer than 60°: two points of the arc more than 60°
  apart have one-sided neighbourhoods inside the circle that contain a set of unit pairs of positive measure, both ends
  the forced label. So at a point with five single-corner labels no two adjacent corners span more than 240°, and the
  bowtie fragment's 60° arcs are *tight* — their ends are a unit apart. Expectation: the theorem record does not state
  this bound.
- **H-b (derived, mine, one mind, unchecked).** The collar's argument never reads that the forced label is absent at `p`:
  the same count forces, at a point carrying **all** `k` labels, a label of `p`'s own along any arc on whose side exactly
  one label is pure. If so G100's "extent is forced in one way" names one of two, and the second is a forced arc of the
  centre's own colour on its ring. The flower's centre would be its degenerate member (six corners of 60°: windows of
  length zero, "six isolated ring points").
- **H-c (prior, mine).** The stall is a count, not a weakness of one label: a side is forced only where five labels are
  barred, a forced corner supplies one bar one unit on, so in a colouring whose points carry at most four labels nothing
  is ever forced and every palette has at least two labels. If so "a six-colouring with no five-label point" is the
  *locally free* object, and what constrains it must be a count round a ring (G98's winding), never a forced step.
- **H-d (prior, mine).** The existence step has a form today's results suggest and no stub holds: pose the seed as a
  *blow-up* at a point (the limit of the colouring rescaled about it — a corner pattern is the case where the limit is an
  indicator of cones), since the one lemma reads a piece only through which side of a circle it lies on near a point. The
  obstruction I expect to be already on record is G95's stripes (antiphase rings about `p` and about `S(p)`).

### 0.4 Expectations, written before the items were opened (each could be wrong; a number is a probability)

| # | item | expectation written first |
|---|---|---|
| E1 | `plans/FS136-derivation.md`, C136-COLLAR | hypothesis is piece data at `p` for general `k`; conclusion gives `η(w) > 0` with no bound along the arc; *not claimed*: that any colouring has such a point, what a collar forces. The bound of H-a is **absent** (0.8). The statement's class ("all labels but one") is narrower than its argument (H-b; 0.6) |
| E2 | same file, the closures (C136-CLOSE and its computed seeds) | free corners 21, 18 (40 in the plane), 106 and 4, as the brief quotes; every free corner has at least two labels left; the file gives **no distribution** of how many labels are left at the free corners (0.7) — if it does, I read it for organisation |
| E3 | same file, § 7 (what it does not hold) | says no entry is about every colouring; names the eight cases as not taken one by one; names the structural form's second half; says nothing about a point with all six labels and one pure (0.8) |
| E4 | `plans/STUB-collars.md` whole | poses "two collars, or a collar and a pieced point, one unit on"; names FS116-N2-FIVERING as unread at its argument; controls: the bowtie fragment (four arcs of 60°), the flower's centre, R7 reading zero; holds neither H-a nor H-b (0.75 each) |
| E5 | `plans/STUB-covering-pairs.md`, the dated blocks | the eight cases listed by name; at most three of eight touched by a C136 entry (0.7); the first card's unit ("the ring's type") marked as read by nothing |
| E6 | `data/fs136/reports/FS136-Z1.md` | 52 predictions, mean Brier 0.0754; this lane's four card defects listed; one tool defect (the first round's checker); the G98 miss |
| E7 | `plans/POROS-2026-10-07-fs136-round1.md`, ledger and card | eleven hunches, seven open; "the-table-runs-forward" now confirmable by C136-FORCED; "the-two-stalls-only-look-alike" and "the-room-is-on-q-rings" still open; my second card's registered numbers: stall 0.65 (met), empty corner beyond the pair 0.25 (not met) |
| E8 | `plans/STUB-lateral-extent.md`, `plans/STUB-seed-remainder.md` | each carries a bearing note of today's record job; neither poses existence for a label count at a point, nor in blow-up or density form (0.7); the three stalls of FS-127's question are named with their steps |
| E9 | `plans/FRONTIER-STUBS.md`, rows 1–12 and the closed list's head | five- and six-colour vertices have no stub of their own (0.8); FS-122, FS-130 (a centre that is not a triangle) and FS-128 (the top colour) sit in ranks 4–10; no row asks for a construction with a five-label point |
| E10 | `plans/SEARCH-QUEUE.md` lines 15–20 | none is aimed at a five-label point or a collar (0.85); line 16 held on 15 |
| E11 | `data/fs136/e2/out/bowtie12.txt` (the collar's primary output) | first line "seed=10 corners at 2 points … arc-scans=2 arc-forced=4"; the inner arcs are exactly 60° and the outer arcs their antipodes about the five-label point (exactness, forced by the half-plane mechanism: a tell if they are not) |
| E12 | `plans/FS116-derivation.md` l. 655 ff., FS116-N2-FIVERING — the map entry the collar restates, which the second deriver "read at its statement only" | its argument is the same count (five colours at `p` leave one for the ring) and its "no change point" is the *whole* ring one colour — which would be **stronger** than a collar on 60° arcs: if so the two disagree about what a five-colour vertex forces off the arcs, and the difference is the pure labels (a whiff: 0.5) |
| E13 | the conditions of the last reading | the collar was derived at the end of a 598k context and filed by a 556k one; expectation that its statement's fine print (second order; a label with two corners at `p`) was read under conditions in which reading was possible: weak (0.4) |
| E14 | the absent | (i) a count of five- and six-label points over the held six-coloured objects — expect only the bowtie fragment's two and the flower's centre; (ii) any entry saying what a point with **four** labels forces — expect none (palette at least two); (iii) a statement of what "has a corner" needs of the colouring off the corner — expect nothing |
| E15 | the coordinator's two sentences to Kooshi | "the first time something with real extent is forced where nobody put it" — expect it larger than its entry on one word (FS116-N2-FIVERING holds it for maps; the hypothesis is five kept corners at `p`); "stall because one colour is too few to rule anything out one unit further on" — expect it a deriver's explanation on one seed, not an entry (0.7) |
| E16 | the kernel planner's relay (0.2 above) | its item 4 — "forced together or not at all" in the tangent case — should show in the bowtie fragment's stop (the corner outside both circles, C136-STOP-GERMS); expect the derivation's corner form to be narrower than the relay's set form, with no entry stating the set form (0.7) |

## Evidence inventory

- `plans/FS136-derivation.md`, read whole (704 lines, in two passes) — read against: E1–E3 (the collar's class and what it leaves; the closures' counts; § 7) — surprised: yes; C136-COLLAR's *not claimed* line leaves "anything at the end points of A", and the arc's end is where the object stops (S1); its statement's "all the labels but one" is narrower than C136-FORCED's hypothesis, which lets the forced label be one of the point's own (S4)
- `plans/STUB-collars.md`, read whole — read against: E4 — surprised: yes; l. 79 gives the five-label point's cones as 30°, 120°, 120°, 6.9°, 83.1°: the two that make the arc span exactly 240°, the largest any five-label point can have (S2); and l. 74 says "its two five-label points" where the fragment has four (S6)
- `plans/FS116-derivation.md` ll. 655–668, FS116-N2-FIVERING at its source — read against: E12 (its "no change point" would be the whole ring one colour, stronger than a collar) — surprised: yes; the statement has a second clause that neither the collar's entry nor the stub quotes — "for every θ outside a finite set r(θ) or r(θ + 60°) lies on a (Q) arc; so the (Q) arcs of the ring have total length at least 180° and p has no hub" — and its model line reads "none held with five colours at a vertex" (S3)
- `data/fs136/e2/out/bowtie12.txt`, first 30 of 98 lines (the summary, the seed, the forced corners, the two seed points' tables; the middle 68 lines not read) — read against: E11 (60° arcs, the outer the antipodes of the inner) — surprised: no; seed lines give `1:[60.0+,180.0-]`, `6:[180.0-,300.0-]` at q₂ and `5:[60.0+,180.0+]`, `1:[180.0+,300.0-]` at q₁; the forced corner at the origin with label 1 is the tip of the tile `t1`, which is at both points
- `data/fs136/e1/out/*.txt`, the first line of each of eleven (the census of vertices by number of labels) — read against: E14 (i): only the bowtie fragment's two points and the flower's centre carry five or six labels — surprised: yes; `bowtie.txt` l. 1 reads "5-label:4"; and the two objects with no vertex above four labels are the two that reach farthest (the strip, 1.8512; the disk, about its centre) (S6, S7)
- `plans/STUB-q-ring.md` ll. 25–57 (the eight cases), l. 229, ll. 682–694 (the record job's note) — read against: E5 (at most three of eight touched) — surprised: yes, at l. 229 and at `plans/FS116-V6-verification.md` l. 206: two earlier records say a construction past a stop "has five-label centres" and "needs five-colour hubs", before FS-136 found the five-label point to be the one source of extent (S5); the note itself as expected: cases 2 and 4 touched, "Cases 1, 3 and 5–8: nothing"
- `plans/STUB-covering-pairs.md`, by sample only (the registered-number lines by search; the dated blocks through the report's lines about them) — read against: E5 — surprised: no; not read whole, and nothing below rests on a line of it I did not open
- `data/fs136/reports/FS136-Z1.md`, the lines naming this lane, the Brier line, the tool-defect lines — read against: E6 — surprised: yes, once; l. 23: this lane's gate fails on its own stub as it stands ("rank 1 already used at line 55"), which I had not seen
- `plans/POROS-2026-10-07-fs136-round1.md`, ledger ll. 391–476 read whole, the rest by outline — read against: E7 — surprised: no; eleven hunches, seven open
- `plans/STUB-lateral-extent.md` ll. 60–110 and its outline; `plans/STUB-seed-remainder.md` by its row in the ranking only — read against: E8 — surprised: no; form (O) is "at every point, the graph of witnessed label pairs is a forest"; no form by number of labels at a point, none by blow-up; the seed remainder's stub was not opened
- `plans/FRONTIER-STUBS.md`, rows 1–24 at their first 210 characters, the section headings, and the three rows the brief quotes in full; the closed list not read — read against: E9 — surprised: no; FS-122 at 4, FS-128 at 5, FS-130 at 6; the five- and six-colour vertices have no stub (they are case 4 of `plans/STUB-q-ring.md`)
- `plans/SEARCH-QUEUE.md` lines 15–20, read whole — read against: E10 — surprised: no; none is aimed at a five-label point; line 15's family is the nineteen lattice points with wedges
- nine derivation files, searched by file for a held count of labels left on a ring's side over directions (`on average`, `average number`, `mean number`, `total length`, `half-plane`: FS110, FS112, FS114, FS116, FS124, FS132, FS136 and the two rounds' records) — read against: E14 (ii)–(iii) and H-c (no entry counts what a point's own corners leave over all directions) — surprised: no; the nearest held line is FS116-N2-FIVERING's "total length at least 180°"; a search by five terms measures those terms
- the conditions of the last reading — read against: E13 (the collar derived at the end of a 598k context) — surprised: yes; what slipped is not the entry's fine print but its neighbourhood: the quoted half of the map entry, and "two" for four
- the coordinator's two sentences to Kooshi — read against: E15 — surprised: no; scored in § 1.3
- the kernel planner's relay — read against: E16 (the tangent case would show at the bowtie fragment's stop) — surprised: no; my expectation was wrong, not the relay: the stop's two members are one unit apart, 60° as seen from the stop, and the tangent case is antipodal members (C136-CORNERS's last clause, l. 156); no entry states the relay's set form of the forward step (C136-FORCED's `handoff:` line carries it as "on the cell")

## Stage 1 — SAVED: the re-read (`poros-anomaly-hunt`, invoked fresh)

### 1.1 The expectations, scored

E1 met in both halves. E2, E3, E4 met. E5 met (two of eight). E6 met, with one line I had not expected. E7–E11 met.
**E12 lost**: I expected a disagreement between the map entry and the collar; what is there is a dropped clause. **E13
half-lost**: the entry stands; its surroundings slipped twice. **E14 (i) lost**: four five-label points, not two.
E15: § 1.3. **E16 lost** (mine). Ten of sixteen met, three lost, three mixed; the three I lost are the three surprises
that carry the card.

### 1.2 The surprises, each with its address

- **S1. The bowtie fragment's stop is where its two outer collars meet.** `plans/STUB-collars.md` ll. 75–78: outside
  `S(q₂)` the label 4 is forced along directions −30° to 30°, and "the mirror image holds at `q₁` with the label 2". The
  ends: `q₂ + e(30°) = q₁ + e(−30°) = (√3, 0)` — the stop. `plans/FS136-derivation.md` l. 547 (control `stop-corners`)
  reads there "out/in=4 … in/out=2 out/out=EMPTY(order 1)": outside both circles a label would have to be the one `q₂`
  lacks and the one `q₁` lacks at once. At the pair's other common unit point, the origin, the two *inner* collars meet
  and the corner between them is coloured — label 1, the tip of `t1`, a tile both points carry
  (`data/fs136/e2/out/bowtie12.txt`, "label 1 corner [300.0+,60.0-] (forced, round 1)"). No record says the stop is a
  meeting of collars. *Fate: a question — it is the card's third claim.*
- **S2. The one held collar is extremal.** Two corners of 120° make the arc: 240°, a window of exactly 60°, its ends a
  unit apart (`(0, 0)` and `(0, −1)`). *Fate: evidence for H-a; a tight object, as every held object is.*
- **S3. The map entry says more than was carried.** FS116-N2-FIVERING's second clause is H-a for maps and stronger: on
  the ring of a five-colour vertex the centre's own colours take at least half. C136-COLLAR's `prior art:` line quotes
  the first clause and says "read at its statement only". *Fate: a finding already explained for maps (G99, G92: my H-a
  has a held antecedent, and I name it); in measure it is one line that no entry states — the card's second claim.*
- **S4. "Extent is forced in one way" (G100) is narrower than the step it rests on.** C136-FORCED's hypothesis does not
  ask that the forced label be absent at the member; `data/fs136/e2/out/flower0.txt` as the stub quotes it: "at the six
  mid-arc ring points … the inside has one label left — the sector's own — and those six corners are forced". A point
  with all six labels forces its own label where exactly one is pure; the flower shows it at isolated points because
  its sectors are 60°. For maps FS116-N2-SIXRING holds it ("six 60° (Q) arcs, one per tile"). *Fate: a generalization,
  reported; the card's fourth claim.*
- **S5. Two earlier records ask for five-label points.** `plans/STUB-q-ring.md` l. 229: "a skeleton that saves every
  complementary pair at both common unit points has five-label centres"; `plans/FS116-V6-verification.md` l. 206: "why
  a construction needs five-colour hubs — which V6-HUG then kills from the inside". Read at those sentences only.
  *Fate: a question — if a way past a stop needs a label-rich point and a label-rich point is rigid, that is one
  trade-off, and nobody has written what is traded.*
- **S6. Four, not two.** `data/fs136/e1/out/bowtie.txt` l. 1: "5-label:4" — `(±√3/2, ±1/2)`, four of the six hubs on the
  ring of the origin. The collar's control, the theorem record (l. 251) and the stub (l. 74) say "its two five-label
  points"; the scan was seeded with two. *Fate: an instrument fault of wording — a correction owed; no verdict moves.*
- **S7. The label-poor objects reach farthest.** The strip (vertices of three and four labels only) stops at 1.8512;
  the bowtie fragment and the flower (five and six) at 1.7321. *Fate: a ledger entry; four objects are not a law.*

### 1.3 The coordinator's two sentences, against their entries

- *"the first time something with real extent is forced where nobody put it"* — at its entry for the class of weak
  colourings, and larger in two words. "Nobody put it": the hypothesis keeps five labelled corners at the point, so
  somebody put five of six there. "First": for maps FS116-N2-FIVERING holds it with more (S3). And the extent is a
  length; of the four arcs on the held object, the two outside it run into the fragment's stop (S1).
- *"stall because one colour is too few to rule anything out one unit further on"* — a deriver's sentence about one
  seed (the prose under C136-CLOSE-R7, `plans/FS136-derivation.md` ll. 303–305), not an entry, and wrong as worded: one
  label does rule that label out on a side. The entry-level fact is a count (C136-FORCED's hypothesis): a side is
  forced only where all labels but one are barred, and each forced corner brings one bar.

### 1.4 The record job's remark — my position

**True, and it is the one lemma itself, not a consequence to be derived.** An open set almost all of one label bars
that label at almost every point whose unit circle meets it (C124-SHADOW-OPEN's statement); the collar is such a set.
What the remark adds is the region, which by my hand (one mind, no control) is the union of the unit circles about
the arc's points: for an arc of 60° two lunes, each holding a disc of radius 1/2, joined by a thin bridge. On it the
colouring uses five labels. **It forces nothing there by itself** — one bar, where a forced side needs five. What is
new in a collar is the *kind* of bar: on an open region, where a germ bars only at corners of isolated points. So
"what do collars force one unit on" has, from a collar alone, the answer *nothing*; with the corners of other points
it is the table again, with one label fewer to bar on that region. The stub's first failure clause covers it.

## Stage 2 — SAVED: the reframe, the choice, the card

### 2.1 Is there a wall (`poros-reframing`, invoked fresh)

Yes, and the record shows it rather than a feeling. Three milestones in a row — FS-132, FS-124, FS-136 — changed the seed
(a cyclic centre; a tight pair; a covering pair; corners) and the tool (palettes; pieces; germs) and ended in the same
place, in the same words: "no weak six-colouring is known to have one". Two of them ended at a *list* (eight cases; free
corners). Inside the last one the unit changed twice in an afternoon (a ring's type; the table at a point across;
corners), each change a patch.

**The commitments, given or chosen** (the wall stands on those marked ▲):

| commitment | given / chosen | receipt, or chooser and reason | ▲ |
|---|---|---|---|
| the product: the value, either way | given | Kooshi's aim; row 161 (both answers are statements about discs) | |
| the lemma: an open one-label set bars its label where a unit circle meets it | given | C124-SHADOW-OPEN, C124-TYPE ([hand], one mind; kernel on a branch) | |
| the class: every weak six-colouring, no normal form | chosen | Kooshi's word of 2026-10-07 for FS-132 ("what any such point's circle forces"); G95 says what it costs: existence statements are false under local slack | ▲ existence |
| the object: pieces, then corners, at named points | chosen | the lemma was to hand (FS-124); corners because germs decide the stops (FS-136) | ▲ existence |
| the direction: from a seed outward | chosen | G96's *Do* | |
| the unit: **one point's table** — which labels are left on a cell at one `w` | chosen | FS-136's first round ("what decides it is … the table at the point across") | ▲ the lists |
| the event read: a side with *one* label left (forced) or *none* (empty) | chosen | the forward step is the only step that needs no choice | ▲ the lists |
| what is held fixed: the number of labels at a member is "not read" | chosen | the first round's reading of four objects | ▲ the lists |

Two walls, then, and they are different. **The existence wall** stands on the class and the object; nothing I read today
moves it, and I pose nothing on it (H-d below is registered and not adopted). **The wall of lists** stands on three
chosen bricks at once: one point at a time, only the sides with one label or none, and the label count ignored.

**Reading the wall of lists.** *What every attempt held fixed*: a side with two labels left was "free", the search
lane's. *The shape of the patches*: ring type → table → corner → collar; each added what the last lacked, and the last
one, the collar, is the first that reads a whole arc of directions at one point — it draws the missing unit: **a
point's palette as a function of direction, round its whole circle**. *The exact values*: the one held collar is 60°
from a pair of corners spanning 240° (S2), its ends a unit apart; the stop is the common end of two of them (S1). *The
map entry* already reads the whole ring: FS116-N2-FIVERING's "(Q) arcs … total length at least 180°" (S3). *The dual*:
not "which corner is forced" but "how many labels does a point's own figure leave on a side, on average" — a number
that depends only on how many labels the point carries.

**Said for a stranger** (a combinatorial geometer who knows list colouring and not this project): at a point where
`m` of `k` colour classes meet in sectors, a class can touch the unit circle about the point from inside only in the
directions whose facing half-plane contains its whole sector — an arc of `180° − α` for a sector of angle `α`. So each
side of the circle is list-coloured, the list at a direction being the `k − m` classes not at the point and the classes
whose sectors face it; points of the circle 60° apart are adjacent. The sectors' angles sum to 360°, so the lists' mean
size is `k − 1 − m/2` — whatever the angles. The discipline is **list colouring of a circle's 60°-graph**, with lists
given by half-plane containment; its standard objects are choosability of blown-up cycles and Hall-type counts. Not
read by me: whether that literature has this graph (a prior-art debt for the opening).

**Candidate frames, registered** (ledger, § below): F-1 *the budget* (derived, adopted for the card); F-2 *existence by
blow-up* (prior; not adopted — it meets G95's stripes where the old forms met them); F-3 *the five-label point as a
necessary rigid object* (read at two sentences; folded into F-1 as its regime `m = 5`, not posed alone).

**The test of F-1**, written before it is believed. *Consequence*: in it the lists are a matter of course — a side with
two labels is the ordinary case (mean 3.5, 3, 2.5, 2 at `m` = 3, 4, 5, 6), forced and empty sides are the tails, and
closures stall because a forced corner adds one sector at a new point, which moves that point's `m` by one. *Conservation*:
every entry of FS-136 stands as it is; the frame re-reads the inventory with no item turning anomalous — S1, S2, S4
become expected (two points lacking different labels have disjoint absent sets; a 240° pair leaves a 60° gap in the
windows; a point with every label has palettes of own labels only). *Prediction* (can fail): at `q₂` the windows sum
to exactly 540° and the only uncovered directions are (150°, 210°) — checked by hand from the seed line: 150 + 60 + 60
+ 173.1 + 96.9 = 540 ✓, uncovered (150°, 210°) ✓; on R7 the mean is 3 (not run); a three-label point pays only along
a unit arc (a held clause, by another route). *Compression*: collar, own-label arc, "never forces on R7", the stop as
a meeting, the unit arc at three labels — five separate remarks become readings of one function. *Cost*: nothing held
is written off; the search lane's line 15 is unchanged and gains a reason; what is spent is one more milestone on local
configurations, which is why § 2.3 sets a stop.

### 2.2 The choice — a recommendation in four parts

**The choice**: open **FS-137, re-posed** — not "what do two collars force one unit on" but *can a ring afford its
points at six*: the count of labels a point's own corners leave on each side of its unit circle, and whether that count
closes round one ring. **Alternatives weighed**: (a) *the existence step again* (FS-127, with FS-122 for a point of four
or more labels) — it bears most toward seven and nothing toward six; no entry of today gives it a form it did not have
this morning, and a fourth pose on the step that stalled three times is the same instrument on the same null; (b) *the
stub as minted* (two collars, a collar and a pieced point) — § 1.4: from a collar alone the answer is "nothing", and the
one held instance is already an entry (the stop); (c) *the case list* (FS-124's eight) one at a time — they are sides
with two labels left on rings that carry own labels, the thing a count over directions is for; (d) *a construction* —
the search lane's, tomorrow; this card is its reason, and the two run side by side on one two-sided question. **Why
this one**: it is the only candidate whose every answer changes a move for both roads (the card's three branches), it
is what the record begged (S1–S5), and its first five claims are small and exact. **Confidence**: medium (0.55 that it
is the right opening). The one fact that would change it: a form of the existence step with an attack — if the
coordinator or Kooshi holds one, it outranks this. **Default**: if nothing is said, FS-137 opens on the card in
`plans/STUB-collars.md` § The question (Poros, 2026-10-07).

**Not leaning**: the card's hunch says the count falls short at first order (0.6) *and* that this is as likely the
strip's road to a construction (unit-arc edges) as a road to an exclusion; the registered number for a clean "no" is
0.12, for a ring 0.3.

### 2.3 The stop, set now

If claim 6 ends at a list — no count, no ring — it is the third local milestone to do so, and this lane poses no fourth
card on local configurations: the next opening is the existence step in whatever form it then has, or an honest exit
to Kooshi. (Three failed cards on one impasse is a dispatch, never a fourth.)

### 2.4 The cards

*Rank 1 is the turn; it is in `plans/STUB-collars.md` with its two forms, what each answer gives, six first claims, their
controls with what was run, and the registered numbers. Rank 2 is the invention-signal card.*

question: can-a-ring-afford-its-points-at-six
  evidence: `plans/FS136-derivation.md` l. 547 — at the bowtie fragment's stop `(√3, 0)` "out/in=4 … in/out=2 out/out=EMPTY(order 1)", and `(√3, 0) = q₂ + e(30°) = q₁ + e(−30°)` is the common end of the two outer collar arcs (`plans/STUB-collars.md` ll. 75–78); `data/fs136/e2/out/bowtie12.txt` seed line — the arc comes from two corners of 120°, a window of exactly 60°; `plans/FS116-derivation.md` ll. 655–658 — "r(θ) or r(θ + 60°) lies on a (Q) arc; so the (Q) arcs of the ring have total length at least 180°"; `data/fs136/e1/out/*.txt` l. 1 — strip "3-label:40 4-label:10" reaching 1.8512, bowtie "5-label:4" and flower "6-label:1" reaching 1.7321, R7 "6-label:16" of seven with no cell empty anywhere; `plans/STUB-q-ring.md` l. 229 — "a skeleton that saves every complementary pair at both common unit points has five-label centres"
  expected: a collar is a curiosity of one fragment, the stops are facts about pairs of tiles, and how many labels a point carries is "not read by anything at the point across" (FS-136's first round)
  ask: at six, can the points round one ring both pay at every point across (four labels or more, or three with a unit-arc edge) and keep a label on each side of their own unit circles, as R7's points do at seven?
  if the count falls short for every assignment of corners round a ring: an exclusion within 2 of a point for every weak six-colouring that has corners there and at the points of its ring; the existence stubs are re-aimed at exactly what it reads, and route T's count (FS-117) is re-read with directions in place of tiles
  if an assignment fits at first order: it is the Searcher's line-15 object with its reason and goes to line 16 to be grown into pieces; the palettes say where a construction has no freedom and where it has
  if it fits only with unit-arc edges at three-label points: the unit arc is the equality case of the count, the strip's way is the only way, and FS-124's cases 1, 3 and 5 become one question — how many such edges a ring needs
  answered by: derivation — Ephodos, for the count and claims 1–5; the first-order lattice family of the ask is the Searcher's line 15, beside it
  cost: one round for claims 1–5; the ring question unpriced
  hunch: at first order the count falls short on the nineteen-point family and fits only with unit-arc edges — 0.6; a count excluding every ring with no family named — 0.12; the value moves — 0.01
  falsifier: a labelled set of corners at a point and the six points of its ring, every cell at every common unit point within 2 non-empty at first order, no edge along a unit circle about a point across
  rank: 1

question: do-rich-points-carry-a-colouring-further-or-stop-it
  evidence: side A — `plans/STUB-q-ring.md` l. 229: "a skeleton that saves every complementary pair at both common unit points has five-label centres", and `plans/FS116-V6-verification.md` l. 206: "why a construction needs five-colour hubs — which V6-HUG then kills from the inside"; side B — `data/fs136/e1/out/strip.txt` l. 1 "3-label:40 4-label:10" with `plans/FS136-derivation.md` l. 636 "1.8512 at six interior centres", against `bowtie.txt` l. 1 "5-label:4" and `sixfrag.txt` l. 1 "6-label:1" with ll. 639–640 "1.7321"
  expected: one of the two is simply true: either more labels at a point is what a colouring needs to get past a stop, or it is what stops it
  ask: both sides hold that a point pays for a point across by the number of labels it carries — what, exactly, is the payment, and is that premise right at second order, where the strip pays with three?
  if the payment is first-order windows only: side A is the rule, the strip is the exception that pays along unit arcs, and claim 2 of the first card is the whole reconciliation
  if a unit-arc edge is a second currency: rich points and unit arcs are substitutes, and the question for a construction is the exchange rate — a statement nobody has posed
  answered by: derivation — Ephodos, with `ephodos-invention` if recognition's homes fail; neither side is picked here
  cost: read the two sentences at their entries first (I read them at the sentence only); then one claim
  rank: 2

## Hunch ledger

*Carried forward from `plans/POROS-2026-10-07-fs136-round1.md` (closed entries keep their status and their text there;
the four still open and the one settled here are restated). Score by basis after this job: read — 8 of 8, 2 open;
derived — 8 confirmed, 2 killed, 3 open; analogy — 0 confirmed, 2 killed, 3 open; prior — 4 confirmed, 7 killed, 5
open; measured — 4 confirmed, 3 killed, 1 open. The last card's two registered numbers, as the record job scored them:
a stall within two steps on every six-coloured seed (0.65) — met; an empty corner from a pair alone beyond its own
common unit points (0.25) — not met. Its four defects, each caught by the deriver who took it (a unit read by nothing;
a control at seven false as reasoned; a third seed naming no object; a third branch asking a closure for a fragment),
are this lane's; the rule they were made under is amended in the card of § 2.4, in place: the seeds are counted by
their labels before the word "forced"; each control says what was run; "not found held" names the files and the terms.*

hunch: the-table-runs-forward
  claim: (carried) a cell with exactly one unbarred label is a piece, and the closure of a held covering pair's pieces under that step reaches beyond the pair's two common unit points on some held object
  basis: measured
  falsifier: C-FORCED false as posed, or already held; or the closure stalling at its first step on every held seed
  registered: 2026-10-07
  status: confirmed (by: derivation — C136-FORCED, `plans/FS136-derivation.md` § 2; and for the second half another mind's exact computation, C136-CLOSE-STRIP (c1) and C136-CLOSE-FLOWER, whose second steps force corners at points that are not the seed pair's common unit points. They stall at the second step, not the first)

hunch: the-map-no-is-unavoidability
  claim: (carried, not adopted) the held stops are reducible configurations of two vertex figures, and what the six-map NO lacks is that every six-map contains one — route T's count
  basis: analogy
  falsifier: a six-map NO, or a tight six-map, obtained with no count over the map
  registered: 2026-10-07
  status: open

hunch: the-local-theory-is-the-map-classes
  claim: (carried) every local statement derivable in the piece class from C124-TYPE has an antecedent held for maps; measure adds economy of hypothesis and no content
  basis: read
  falsifier: a local statement in the piece class with no map antecedent that changes a move on the case list
  registered: 2026-10-07
  status: open

hunch: the-seed-first
  claim: (carried, not adopted) the next milestone that bears most is the seed, FS-127, and no local milestone moves a decision before a seed statement exists
  basis: prior
  falsifier: the successor producing an exclusion at an explicit radius for a ring type, or a fragment past `φ²/√2`, before any statement gives a weak six-colouring a piece
  registered: 2026-10-07
  status: open

hunch: constant-width-owns-the-inside
  claim: (carried) the theory of sets of constant width and of intersections of unit discs has a statement that bears on a tile pinned along an arc by its own point
  basis: prior
  falsifier: a reading of that literature finding statements about one body only and none about a partition or a packing of such bodies with a second class pinned from outside
  registered: 2026-10-07
  status: open

hunch: the-room-is-on-q-rings
  claim: (carried) whatever room six colours have is on rings that carry the centre's own labels
  basis: analogy
  falsifier: a weak six-colouring, or a fragment past `√3`, none of whose rich points has a tight pair on its ring
  registered: 2026-10-07
  status: open

hunch: the-two-stalls-only-look-alike
  claim: (carried) the ring card's stall and the witness card's stall are different statements
  basis: prior
  falsifier: one statement whose proof closes both
  registered: 2026-10-07
  status: open

hunch: a-collar-arc-is-at-most-sixty
  claim: (H-a) at a point whose corners carry all labels but one, the directions with no label pure on a side hold no two interior directions 60° apart; so a forced arc is at most 60° and two adjacent one-corner labels span at most 240°
  basis: derived
  falsifier: a weak six-colouring, or a held fragment, with a forced arc of the absent label longer than 60° lying whole in its domain
  registered: 2026-10-07
  status: open

hunch: a-full-point-forces-its-own-label
  claim: (H-b) C136-FORCED at one member forces a label of the member's own where it is the only pure one; G100's "extent is forced in one way" is narrower than the entry it rests on
  basis: read
  falsifier: a clause of C136-FORCED's hypothesis asking that the forced label be absent at the member
  registered: 2026-10-07
  status: confirmed (by: `plans/FS136-derivation.md` l. 191 — "ℓ a label such that every label other than ℓ is a label of some 𝒫_i that is not inner-pure at w …", nothing on ℓ itself; and `plans/STUB-collars.md` ll. 89–92 — the flower's six forced corners are "the sector's own". The arc form is claim 4 of the card and is not confirmed)

hunch: the-stall-is-a-count
  claim: (H-c) a side is forced only where all labels but one are barred, a forced corner brings one bar, so among points of at most four labels at six every palette has two labels or more and nothing is forced; what constrains such a colouring is a count round a ring, never a forced step
  basis: prior
  falsifier: a seed of points with at most four labels each whose closure, computed exactly, forces along an arc (G100's own killing test)
  registered: 2026-10-07
  status: open

hunch: existence-by-blow-up
  claim: (H-d, frame F-2, not adopted) the seed can be posed as the limit of the colouring rescaled about a point, and the table holds for such limits where they are indicators of cones
  basis: prior
  falsifier: a weak colouring whose rescalings about a point have only limits that are no indicators, properness lost in the limit — antiphase fine rings about the point and about its unit circle (G95's stripes)
  registered: 2026-10-07
  status: open

hunch: the-budget
  claim: (frame F-1, adopted for the card) for one-corner labels filling a neighbourhood, each corner at most 180°, the windows sum to 180°·(m − 2), so the mean number of labels left on a side of the point's unit circle is k − 1 − m/2, whatever the angles
  basis: derived
  falsifier: a held vertex whose windows, read exactly by the engine's scan of its unit circle, sum to anything else — `q₂` must read 540°, a lattice point of R7 720°
  registered: 2026-10-07
  status: open

hunch: the-stop-is-a-meeting-of-collars
  claim: (S1) the bowtie fragment's stop is the common end of the outer collar arcs of its two five-label points on that side, and the cell outside both circles is empty there
  basis: read
  falsifier: the two arcs ending at different points, or the table at `(√3, 0)` leaving a label outside both circles
  registered: 2026-10-07
  status: confirmed (by: `plans/FS136-derivation.md` l. 547 — "out/in=4 … in/out=2 out/out=EMPTY(order 1)" — with `plans/STUB-collars.md` ll. 75–78 and `(√3/2, −1/2) + e(30°) = (√3/2, 1/2) + e(−30°) = (√3, 0)`. Why it is empty — no label outer-pure for both — is claim 5 and is not confirmed)

hunch: a-three-label-point-pays-only-along-a-unit-arc
  claim: at a point with three one-corner labels, edges rays or circular arcs, a direction with one label inner-pure and another outer-pure is perpendicular to an edge that begins along the unit circle about the point in that direction
  basis: derived
  falsifier: a three-label point separating at a point across with no edge along that point's unit circle — among the strip's 17 pairs with both common unit points inside, or by formula
  registered: 2026-10-07
  status: open

hunch: a-count-by-directions-sees-siamese-pairs
  claim: the budget counts own-label arcs on a ring, so it is not blind where G86 says a count over tiles is
  basis: analogy
  falsifier: a refinement of a tile into a two-colour map (FS114-N2-REFINE) that changes no palette's size on any ring
  registered: 2026-10-07
  status: open

hunch: label-poor-objects-reach-farthest
  claim: (S7) among the held six-coloured objects, those with no vertex above four labels reach farther from a four-label centre than those with a five- or six-label vertex
  basis: measured
  falsifier: a fragment with a five- or six-label vertex past 1.8512; or the distances being an artefact of the centre chosen (the disk holds about 2.12 about its pentagon's centre)
  registered: 2026-10-07
  status: open

hunch: a-rich-point-is-needed-past-a-stop
  claim: (frame F-3, S5; folded into the card as its regime of five labels) a skeleton that saves both common unit points of its pairs has points of five labels
  basis: read
  falsifier: the entries behind `plans/STUB-q-ring.md` l. 229 and `plans/FS116-V6-verification.md` l. 206 saying less than their sentences; or a skeleton past a stop with no point above four labels
  registered: 2026-10-07
  status: open

Invention signal: one whiff, written as the rank-2 card of § 2.4 and not settled — two earlier records say a way past a stop needs points of five labels (`plans/STUB-q-ring.md` l. 229; `plans/FS116-V6-verification.md` l. 206), and the census says the objects with such points stop sooner than the strip, which has none (`data/fs136/e1/out/` first lines; `plans/FS136-derivation.md` ll. 636–640); the premise both share is that a point pays by its number of labels. No two entries that cannot both hold were found. Read for it in `plans/FS136-derivation.md` (whole), `plans/STUB-collars.md` (whole), FS116-N2-FIVERING and FS116-N2-SIXRING at their statements, the eight cases and the record job's note on them, `data/fs136/e2/out/bowtie12.txt` (first 30 lines), the eleven census lines, and the kernel planner's relay. One thing looked like a collision and is not: C136-COLLAR forces a label along the outer arcs up to their end while C136-STOP-GERMS-RADIUS lets no domain reach that end — both hold, and together they say the outer arcs are never had whole when both points' corners are kept (claim 5).

### Slips, disclosed

- Stage 0's commit was made after the theorem record and the stub had been read. Its expectations were written before
  either was opened (the file was created first), but git cannot show that order.
- E16 was my misreading of the relay's tangent case (antipodal members), not a finding.
- `plans/STUB-covering-pairs.md`, the seed remainder's stub and the ranking's closed list were not read whole; the
  inventory says so at each.
- In `plans/STUB-collars.md` I replaced the record job's provisional paragraph under "Bearing on the answer
  (provisional; the asking lane writes it)" with mine, and put my bearings line above the record job's, which is kept.
