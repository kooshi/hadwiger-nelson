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
