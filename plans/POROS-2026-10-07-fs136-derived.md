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

## Stage 2 — in progress
