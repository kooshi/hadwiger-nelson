# Poros — FS124-P1: the next milestone's question (the unit arc about a point one unit away), and the re-rank

*Record of job FS124-P1 (brief `data/fs124/briefs/FS124-P1-question.md`), 2026-10-07. Identity: Poros (`.claude/agents/poros.md`), job 1.
Stages are headed "Stage n — SAVED" and committed by explicit path. The hunch ledger is carried forward from
`plans/POROS-2026-10-07-fs132-night.md`. This record's re-rank draft, when written, replaces the two unfiled drafts of the night.*

## Theorems this phase proved

None. This job poses and ranks; every statement below is a question, a reading or a registered expectation, at the grade it names.

## Stage 0 — SAVED: the frame on its five axes, and the expectations, written before the reading

*Written from the brief, `CLAUDE.md` as loaded at launch and the grokkings alone. Nothing in the inventory below had been opened when
these lines were committed, except that the brief's 18 block quotations were string-matched against their sources
(`data/fs124/p1/quote_check.py`, exit 0, 18 of 18).*

**The goal, in the principal's words** (Kooshi, 2026-09-26, `CLAUDE.md` § The aim): "My goal is to fully solve, and then verify in Lean, HN.
Then we publish." And this morning (`data/external/EXT-OAI1-request.md`): "We move to the standard workflow, attacking 6/7."

**The frame as it arrived, on five axes** (each with the address where it lives):

- **The object** — "a boundary between two colours that runs exactly along a unit circle, centred on a point one unit away" (the brief,
  § opening); in the stub's vocabulary the "(Q) ring" (`plans/STUB-q-ring.md`). The brief itself flags that the object has two
  appearances (on the centre's own ring; through the centre) and that reading them as one is unchecked.
- **The question** — as filed (`plans/FRONTIER-STUBS.md` rank 2): "does every vertex of at least four colours whose ring carries (Q)
  arcs, and every vertex of five or six colours, die within an explicit radius?"; first, "what a (Q) ring passes to the four-colour
  vertices its change points place, and whether that is conserved". A question about vertices of a map.
- **The discipline** — the vocabulary the objects wear is map colouring: vertex, ring, tile, change point, Siamese, (Q)/(R2) arc. The
  class the problem lives in since `[OAIMath2026]` is measurable colourings proper at almost every unit pair, whose vocabulary last night
  was palettes, cyclic centres, interface continua, lenses.
- **The audience** — the stub was written for a deriver working in the map class; the card to be written is for a deriver in the
  measurable class, and for Kooshi in three lines.
- **The product** — "what done means" for the milestone: an exclusion at an explicit radius (toward seven) or valid fragments at every
  radius (six). For this job: a card whose first claims "cannot be" met by a margin or answered off the branch table (the brief).

**Where I expect the frame to be wrong, said before reading** (so it can be scored): the object axis. "Unit arc about a point one unit
away" is stated by position; I expect the reading to show it is a *relation between two special points* (a point whose palette is rich,
and a ring point whose palette is rich), and that the two appearances are the same relation with the roles exchanged — one object only
if the ring point is itself a rich point, which is a theorem in the map class (the placing rule) and I expect not yet one in measure.

## Evidence inventory

*By provenance, oldest and middle first. Each expectation was written before the item was opened; "surprised" is filled in at Stage 1.*

- `LEDGER.md` rows 133–138 (the tight six-map; Condition 5; a vertex of at least four colours; the printed positives) — read against: every statement quantifies over maps (tiles, vertices, arcs), not over colourings; at least one of rows 136/138 states the held positives are valid past `√3` and extend to no whole-plane map; no row says anything, positive or negative, about a ring that carries a (Q) arc except to except it — surprised: yes; row 135 gives the (Q) arc as a normal form reached "by merges and whole-arc bends that create no unit arc" — a modification no measurable colouring admits — and row 136 says what the arc is for: each printed positive "stops at the unsaved second common unit point of a close complementary pair saved at its first". Rows 133, 135, 136, 138 read at their statement cells (first 1,700–2,600 characters); 134 and 137 through the front page only
- `LEDGER.md` rows 145–150 (fragments at every radius; the Γ-free and (Q)-free rings die; the change points) — read against: every exclusion carries "non-Siamese" and a "no (Q) arc" hypothesis in its statement; row 145's "fragments at every radius give six" is stated for map fragments and its proof is the random-rigid-motion argument, which never reads tiles — so it holds verbatim for measurable fragments — surprised: yes; row 145's mechanism is the weak-* limit ("the circle measure is Rajchman"), not the random rigid motion I expected, and its statement is for "segment-and-arc maps of discs". Row 145 read at its cell; rows 146–150 only through the stub's quotations of them
- `plans/STUB-q-ring.md`, the plain-language section, the card of 2026-10-03, the eight cases — read against: the (Q) arc is defined by position on the ring of a vertex `p` of at least four colours, as an arc of `ω(p)` that is a map boundary with one of `p`'s own colours on a side; the eight cases are ring types of a map and at most two of the eight can be stated for a measurable colouring without a dictionary — surprised: yes; `plans/STUB-q-ring.md` l. 22: a (Q) arc has *both* side colours carried at `p`, not one; and `data/fs116/claims.md` l. 190 (FS116-N3-SEMI's second alternative) already states the measurable round's appearance (β): "a vertex of exactly three colours one of whose edges at y is an arc of the unit circle about r(ψ + 60°) or about r(ψ − 60°) whose two side colours are both carried at that centre, which is then a vertex of at least four colours"
- `plans/STUB-q-ring.md`, registered expectations and failure clauses (2026-10-03) — read against: probabilities registered; the "conserved" branch priced below 0.5; no expectation mentions the measurable class — surprised: no; four probabilities (0.5, 0.35, 0.2, 0.15; ll. 176–177), none on the measurable class
- `plans/STUB-q-ring.md`, the dated lines of this morning under the provisional bearings — read against: about five lines; they describe the object in two appearances; at most one names an entry that identifies the two, and at a one-mind or reading grade — surprised: yes; eight bullets, and the grade is as expected ("only then is `y_0` known to carry both side labels", ll. 222–223) — but l. 250 says what transfers from the map class "needs the dictionary fact FS-134 owes", while FS-134's own stub states that fact (F2) for reading a measurable exclusion at a map, the other direction
- `plans/FS132-derivation.md` §§ 1–4 (rounds one and two; the middle of the file) — read against: the exclusions' hypotheses are of two kinds — the centre isolated among cyclic centres, and no interface that is a unit arc about a ring point; the held fragments satisfy the first and fail the second at every vertex of at least four colours — surprised: yes; isolation of the centre is read by the extraction alone (§ 3: "No exclusion in this file reads it"), and the arc-free hypotheses are two different ones, (α) on the centre's ring and (β) through the centre; the release's two-state theorem sits on the (α) side as an exclusion (ll. 244–247). Read whole, ll. 1–853
- `plans/FS132-derivation.md` § 5 (the third round: the lens, the placed point, the placed point's ring) — read against: made at the end of two long contexts (card at 471k, derivation at about 470k), so more stalls and one-mind grades than rounds one and two; the placed point is shown rich only under a hypothesis, not outright — surprised: yes; control `kept-model` (l. 354): labels 012, 1234, 012, 0145, 012, 0235, interfaces-of-x=3 on-unit-circles-about=[1, 3, 5] — the kept model's centre carries three labels, the four-label points are its alternate ring points, and its three even ring points carry the complementary triple. The grades are as expected (C132-LENS-FOUR needs three consecutive outer-pure points). Read whole, ll. 854–997
- `plans/FS132-derivation.md` § 8 (stalls and gaps with smallest open forms) — read against: every stall's smallest open form names the unit arc about a ring point; fewer than three stalls are about anything else — surprised: yes; of nine stalls only C132-PLACED's sits beside the arc; the other eight (RUN-EMPTY, RUN-CV, RING-TAME, LONG, TURN, WIT-EX, GRUNDY7, LENS-II) are about tiles, finiteness, witnesses and far-away sets. The arc is where the exclusions' hypotheses end (§ 12), not where the derivations stalled. Read whole, ll. 1138–1301
- `plans/FS132-derivation.md` § 9 (posed, not started) — read against: three to six items, among them C132-ARC, C132-RADIUS and C132-DIAG; C132-RADIUS is "measurable fragments on discs of every radius give `χ(ℝ²) ≤ 6`" and is a short consequence of the random-rigid-motion argument — surprised: no; nine items; C132-RADIUS is "`χ(ℝ²) = 7` iff some disc has no measurable six-colouring proper at almost every unit pair inside it" (`data/fs132/claims.md` l. 34), as expected. Its derivation is still nobody's
- `plans/FS132-derivation.md` § 12 (the tally of the line) — read against: at least 40 of 57 entries on the arc-free side; at most 10 on the arc side, mostly definitions and stalls; no entry excludes anything on the arc side — surprised: yes; the tally is 18 no side, 5 arc-free (α), 12 arc-free (β), 3 margin — not 40 arc-free — and "reaches the hard case" holds entries whose conclusion is the object (C132-PLACED-RING, C132-COMP-SHARP as stated). Read whole, ll. 1433–1448; § 10 (the claims as posed) not read
- `plans/FS132-close-inventory.md` items 21–35 (the process's own behaviour) — read against: three derivation rounds each ending at the same object; both the third card and its derivation handed back at about 470k, at the hand-back line — surprised: no; both third-round jobs handed back at about 470k. Read by sample: only the items the derivation file quotes (24, 28, 29, 31); the file itself was not opened
- `plans/SEARCH-2026-10-07.md` and `data/search/2026-10-07/KEEP-turning-4label-arcs.json` (the one model the search kept) — read against: a finite combinatorial model on a ring of six points at 60°, three alternate points carrying four labels; a family of tens to thousands of models; it colours no disc — it is a consistent labelling of ring points and the centre's interfaces only; the null "no model without arcs" is stated with its enumeration bounds — surprised: yes; "all 192 models are of one shape, in four classes of 48 by symmetry" (`plans/FS132-derivation.md` l. 1063), and "No model of this family has a three-way point at two adjacent ring points" — one shape, and it is fragment T2's rhombus three times over: a three-label centre with three complementary partners, the maximum row 136 allows. Read through § 6 of the derivation file and control `kept-model`; the JSON and the search record were not opened
- `plans/SEARCH-QUEUE.md` line 11 (the kept model extended outward; held) — read against: one request, sized, with a stated yes and no; held for a decision, not for capacity — surprised: no; one request, "a design problem with a handful of interfaces per sector, not a large enumeration", held with "the asking lane ranks it" (`plans/SEARCH-QUEUE.md` l. 19)
- The six-coloured fragments held (rows 136, 138, 145–150 and the derivation files they name; FS116-Y2-SIXFRAG) — read against: every one is a map fragment; at every vertex of at least four colours its ring carries a (Q) arc or the fragment's radius is below `1 + ε`; none has been read against last night's measurable entries by anyone but the record job — surprised: no; every one a map fragment — the capped strip below `φ²/√2`, the disk at `φ`, SIXFRAG below `3/2`, the bowtie at `3√3/5`, T2 on four neighbourhoods. Read through rows 136, 138 and the stub only; no fragment's file was opened
- `plans/STUB-exclusion-back-to-maps.md` (FS-134; the dictionary) — read against: the one underived fact runs from measure to maps (a map's ring data are its palettes), so carrying a *map theorem into the measurable class* does not need it — that direction is a re-derivation of the argument at the class it reads (G92), not a dictionary — surprised: no; F2, "a map's palette is its ring read two-sidedly", is owed for reading C132-M-EXCL at a map vertex (`plans/STUB-exclusion-back-to-maps.md` ll. 40–52). Read ll. 1–60
- `plans/STUB-seed-remainder.md` (FS-135) — read against: a list of seed types last night left; its question 4 is a restatement of a stalled claim — surprised: no; question 4 is C132-TURN's stall restated, with its history said (`plans/STUB-seed-remainder.md` ll. 76–82). Read by sample: the four question heads and question 4
- `plans/POROS-2026-10-07-fs132-night.md` and `plans/POROS-2026-10-07-fs132-round2.md` (my own records; the hunch ledger, two re-rank drafts, five banners) — read against: the ledger's read-basis hunches scored better than prior-basis ones again; the "needs no cone scale" finding is registered with basis derived and was never read against row 139's entries; both re-rank drafts put FS-124 at rank 1 or 2 — surprised: yes; `plans/POROS-2026-10-07-fs132-round2.md` l. 471 already reads the search's survivor as "row 136's three-partner count" — the rhombus was in my own record last night and the third card was posed on the lens. The ledgers scored as expected (below). Read by sample: the ledgers' status lines, both re-rank sections, the banners, the cone-scale lines
- `data/fs132/reports/FS132-Z2.md` and `plans/FS132-Z2-record.md` Stage 3 and the row-139 paragraph — read against: 63 predictions scored; the "three failed at wording" are claims whose statement fixed a constant or a quantifier the derivation then met differently; the phrase the brief attributes to the record job about the two appearances is in this record — surprised: yes; the phrase on the two appearances is in the stub (ll. 211–212) and the derivation file (ll. 53–54), not in the record job's record; and the three wording failures are "a route named where a statement was meant (M1), a clause that was not a statement (A6), a clause resting on a sentence true one way only (B1)" (`plans/FS132-Z2-record.md` ll. 272–274), not constants or quantifiers. Read: ll. 268–276 and the row-139 paragraph (l. 337)
- `LEDGER.md` row 139 and the derivation file it names (the cone scale) — read against: the cone scale belongs to route R's limit class (near-colourings with holes, the hole bound made uniform); in the exact class there are no holes, so "needs no cone scale" is true and empty as a note on that row — true as drafted with probability 0.15, true but misfiled 0.60, false as drafted 0.25 — surprised: no; `plans/FS111-derivation.md` l. 240: "not claimed: that either route closes; that the cone scale is idle in route M", and row 133's cell already carries the exact-class line ("in the exact class the tangent pair is an edge that lies on the unit circle about the common unit point"). Read: rows 133 and 139 at their cells, and the eight lines of the derivation file that hold the words "cone scale"
- `plans/FS124-close-inventory.md` (the rules that will judge this milestone) — read against: rules about a claim's wording being fixed before derivation, drawn from last night's three wording failures — surprised: yes; the rules are announcement rules, and rule 3 says of rows 135–138 and 145–150 that "what of them transfers to measurable colourings is a claim, never a default" — no rule on a claim's wording. Read whole
- `plans/FRONTIER-STUBS.md` (the table to re-rank) — read against: 72 open stubs, FS-132 at rank 1 and still listed as Opened; FS-134 and FS-135 absent from the table — surprised: no; FS-132 at rank 1, FS-134 and FS-135 absent. Read by sample: the first 330 characters of ranks 1–9
- The absent, 1: a held six-coloured object that is *not* a map (a measurable fragment with a non-map class) — read against: none exists; every positive this project holds is a map fragment or a finite labelling — surprised: no; none exists: "No model is known — no weak six-colouring with a turning seed is held" (`plans/STUB-q-ring.md` ll. 223–224)
- The absent, 2: an entry that *defines* the object in measure (what "(Q) arc" means for a measurable colouring) at a grade — read against: exists as one entry, one mind — surprised: yes; no entry defines it. The two appearances are defined in prose in the derivation file's § How to read an entry; C132-ARC, the one statement that would give the object a property in measure, is "posed, not started" (§ 9)
- The absent, 3: the centre of the arc's own data — what the colouring looks like *at the point the arc is centred on* — read against: last night's entries read the arc from the cyclic centre it passes through and say nothing about the palette at the arc's centre beyond "a ring point"; if so the object's defining point is the one nobody has looked at — surprised: yes; confirmed absent — C132-LENS "reads nothing at `y_0`", C132-PLACED-RING claims nothing "on the rest of the unit circle about `y_0`" — and a held entry gives it in three lines when pointed the other way: C132-SHADOW (§ 2) applied from the arc back to its centre
- The conditions of the last readings — read against: the stub's dated lines were written by the record job from the derivation file (a summary of a summary of E6's record); nobody since E6 has opened E6's record against them — surprised: yes; the derivation file's entry blocks are copied by script from the derivers' records (l. 7), so they are primaries; what is a summary is its Side lines and § 12, the record job's reading, and the stub's dated lines after them

## Stage 1 — SAVED: the re-read, and the reframe

*The inventory above carries each item's verdict with its address and, where an item was sampled, the sampling. Skills invoked fresh:
`poros-anomaly-hunt` before the reading, `poros-reframing` after it. Fifteen of twenty-five items surprised.*

### 1.1 The readback

All 18 block quotations of the brief match their sources (`data/fs124/p1/quote_check.py`, exit 0). The brief's in-prose phrase "checked by
neither the coordinator nor the record job" is the stub's (ll. 211–212, broken across a line); the derivation file's own words are "not
checked by the coordinator, nor by this job" (ll. 53–54). **One sentence of the brief is wider than its source**: "nothing derived last
night touches it". The file's sentence is "nothing in this file excludes, builds or bounds a boundary that is a unit arc about a ring
point" — appearance (β) — and its § 12 places C132-DIAG-WIDE on a ring "of kind (α)" throughout, as an exclusion: the release's two-state
theorem read at six. So one exclusion on the arc's side is held, and it is the release's.

### 1.2 The three bodies of evidence, read against each other

**What a theorem about maps says that no measurable entry yet says.**
1. *What the arc's centre carries.* Row 135: every unit arc reduces "to one centred at a vertex of at least four colours carrying both
   its side colours ((Q))" — by "merges and whole-arc bends". In measure the centre is known to carry both side labels only under a
   hypothesis three ring points wide (C132-LENS-FOUR), and C132-ARC, the statement that would say it at the complementary pair, is
   unstarted.
2. *What the arc is for.* Row 135: "a close complementary pair of cubic trichromatic vertices sits on a unit rhombus with four-colour
   corners (FS-110's T2, forced)". Row 136: each printed positive "stops at the unsaved second common unit point of a close complementary
   pair saved at its first". In measure C132-COMP-SHARP gives the first half — one of six edge sets on the unit circle about each common
   unit point — and nothing about what that point carries.
3. *The placing rule and its one exception* (FS116-N3-SEMI): a statement about what a ring passes on. In measure its only instance is
   C132-PLACED-RING, whose conclusion is the object and whose hypotheses lie at the two neighbours.

**What the measurable entries say that the map theorems cannot.** No Siamese clause and no simplicity (C132-M-EXCL against rows 148–149);
no properness at all in the covering count (C132-CROSS: "It reads no properness"); the shadow of an open one-label piece at every number
of labels, with no palette and no chart (C132-SHADOW).

**Where each held six-coloured object sits against last night's exclusions.**

| exclusion | the hypothesis the held objects fail | the address |
|---|---|---|
| C132-M-ORBIT, C132-M-EXCL | (i), an outside label near all six orbit directions: "at least two of its four germs at ±60° lie on (Q) arcs" at each of the 8 change points of the 4 held rings | control `positives-escape` |
| C132-CROSS, C132-COMP-SHARP as an exclusion | the proviso: "a set K all of whose points are at distance 1 from w … enters none of the four unions"; fragment T2 has three such sets | control `seam-fragments` |
| C132-PLACE, C132-ALT, C132-TURN-EDGE, C132-LENS-FOUR, C132-LENS-GERM | two edge sets strictly on one side at a ring point: the kept model's sides read `I - I - I -`, "no ring point is outer-pure" | control `kept-model` |
| SEARCH-1007-TURN-SS | straight rays at the centre | § 6 |

Every held object escapes at one place: a set of the centre's that lies on the unit circle about a ring point, or the centre's own labels
on its ring. None escapes by having infinitely many centres, by a margin, or by a far witness — the three other ways the night left open.

**Is the object one object?** As a set in the plane, yes; as a hypothesis, no. Both appearances are one configuration: *two points one
unit apart, `q` and `z`, and an interface between two labels that runs along the unit circle about `q` near `z`*. Appearance (α) stands
at `q` and adds that `q` is rich (a vertex of at least four colours, carrying both side labels). Appearance (β) stands at `z` and adds
that `z` is rich (a cyclic centre, the interface one of its edge sets). They are the same hypothesis only where both ends are rich, and
that is one named place in each class: in maps, FS116-N3-SEMI's second alternative (`data/fs116/claims.md` l. 190), a three-colour vertex
with an edge on the unit circle about a four-colour ring point carrying both side colours; in measure, the kept model, where the
three-label centre's three edges lie on the unit circles about its three four-label ring points (control `kept-model`). So the night's
reading "one object behind five leftovers" is right about the object and silent about the end one stands at; no entry transfers between
the two ends, and the cheapest one that would is C132-SHADOW read from the arc back to its centre.

### 1.3 The reframe (`poros-reframing`)

**Is there a wall?** Yes, by the record and not by feeling: three derivation rounds and two map-class milestones each excluded what they
could and each stopped with the same exception — FS-114 (row 138: "K1 (GAP at rings with (Q) arcs…)"), FS-116 and FS-129 (rows 148–149:
rings with no (Q) arc), FS-132 (§ 12). Five attempts, one exception.

**What every attempt held fixed** (the failed attempts lined up, what varied struck out): each stands at one rich point and reads *its
unit circle* for labels. The method is a transfer — the centre's labels are forbidden on its ring, so the ring is coloured by the labels
the centre lacks, two of them at a four-label point — and the object is exactly where the ring is not coloured at all, because it is an
interface. The exact value (the interface lies on the circle the instrument reads, to the last digit) is the instrument speaking.

**The commitments**, given or chosen:

| commitment | given or chosen | receipt, or chooser and reason | does the wall stand on it? |
|---|---|---|---|
| the class: measurable colourings proper at almost every unit pair | given | `[OAIMath2026]` Thm 1.3; in this library `Outside.OAI158.chromaticNumber_plane_eq_chiM0` | no |
| the product: an exclusion at an explicit radius, or fragments at every radius | given | Kooshi's goal; row 145's FS116-O1-YESLIM for maps; C132-RADIUS posed for measure | no |
| the object named by where it lies on a rich point's ring ("(Q) ring", "arc about a ring point") | chosen | FS-116 sorted vertices "by what their ring carries" (the stub, l. 20); FS-132's record job kept two names for two vantage points | **yes** |
| the unit of analysis: one point and its unit circle (a vertex; a seed) | chosen | FS-114's C114-LOCAL-F, where one vertex suffices because FS114-CV-EXISTS supplies it in every map; in measure nothing supplies it (C132-WIT-EX stalls) | **yes** |
| the question's kind: does it die (an exclusion, case by case) | chosen | the case list of `plans/FS116-Z1-close.md` § 2.6; the stub's eight cases | yes |
| the level: the arc as one case among ring types | chosen | the same list; "the hard case" is the brief's and the derivation file's word | **yes** |
| the grammar of a claim: palettes at a point | chosen | the release's § 5, adopted in round one; C132-SHADOW shows a claim can be stated over open one-label pieces instead | no, but it is why controls on maps need FS-134's fact |
| "(Q)": the centre carries both side colours and at least four | given for maps after reduction (row 135); **chosen** for measure | no measurable entry derives it without a hypothesis | yes, for the NO side's wording |

**The reading of the wall.** The exception is not a case the exclusions missed; it is what they force. Held, with addresses: at a
witnessed four-cycle the ring *cannot* carry an outside label almost everywhere (C132-M-EXCL), so the centre's own labels fill the ring
on a set of positive measure; a close complementary pair *must* put an edge set on the unit circle about each common unit point
(C132-COMP-SHARP); a turning seed with outer-pure neighbours *produces* the arc at the placed point (C132-PLACED-RING); in maps every
valid six-map has a four-colour vertex (row 137) and, non-Siamese, each has (Q) arcs or dies at `1 + ε` (row 149); in a saturated
colouring a two-colour interface point lies on a unit arc whose centre carries both colours, or on a tangent curve (G84). And at seven
the object is not a corner either: R7 has "every boundary a unit arc centred at a lattice point that carries both its side colours".
So "exclude the unit arc" is not the next case; in every class where a rich point is known to exist it is the whole NO. The level was
wrong: the arc is the rule of a six-colouring, and the question about a rule is what it passes on.

**The object, for a stranger** (one statement; the candidate frame F2 below). *A unit pair `(q, z)` is tight for the labels `(a, b)` in
a measurable colouring when some neighbourhood of `z` has label `a` almost everywhere inside the unit circle about `q` and label `b`
almost everywhere outside it.* No vertex, ring, tile, palette or seed is in it; a map's unit arc is an instance with no dictionary; the
two appearances are its two ends. The discipline whose words these are: on the inside, sets of diameter 1 that reach their diameter
along a whole arc (constant width, Reuleaux; spindle convexity is the theory of intersections of unit discs); on the outside, the
unit-distance exclusion of one class by itself; and where both pin one arc from one point, this project's own contact (G84) — a class
"carved by unit circles about its own points". Recalled, not read: no theorem of constant-width theory is known to me that speaks of a
partition into six classes; the bridge is named, not crossed (frame F3, registered at prior).

**What the frame predicts that the old one did not** (so it can fail): (1) the centre of a tight pair is never a margin point and is
never unconstrained — by C132-SHADOW, near `q` the inside label lives in the closed unit disc about `z` and the outside label outside
the open one, so two labels are pinned to opposite half-planes at `q` by *each* tight pair through `q`; (2) therefore tight pairs at
several ring points of one centre multiply half-plane conditions on the same labels, and there is a count: three half-planes with
normals 120° apart meet in nothing when their signs agree and in a 60° cone when they do not, so *a point with exactly four labels
cannot be the centre of tight pairs at all six points of one 60° orbit of its ring* when those pairs use its four labels in two pairs —
the four labels cover at most 240° of the directions at it (`tools/fs124_p1_cones.py`, exit 0; `--fault` exits 1). That is a statement on
the arc's side, at first order, that reads no ring label; it is a hunch (C124-SIX below), one mind, unchecked. (3) The kept model's shape,
continued as it begins — three-label points of two complementary types on a unit honeycomb, four-label points at the hexagon centres — is
therefore not self-reproducing with four-label centres: the centres need a fifth label, which is the stub's case 4, not a different
subject.

**The test.** *Consequence*: in the new frame the wall is a matter of course — an instrument that reads ring labels reads nothing where
the ring is an interface, and the interface is forced. *Conservation*: every entry of § 12 keeps its statement; the "arc-free" provisos
become "no tight pair at this ring point", and the three "reaches the hard case" entries become the first statements *about* tight
pairs. No verdict of the inventory changes from "no" to a surprise. *Prediction*: (1)–(3) above. *Compression*: "(α) or (β)", "(Q) arc",
"edge set on the unit circle about a ring point", "semi-hub of the second alternative", "the search's kept shape" are one definition.
*Cost*: the stub's card of 2026-10-03 and its eight cases are not written off — the cases become the ways a tight pair's two ends can be
filled — but the first claims change, and FS-134's dictionary fact leaves this milestone's critical path. The product does not change.

## Stage 2 — SAVED: the question card

*The card, its existence and structural forms, what each answer gives, the first claims and the registered expectations are in
`plans/STUB-q-ring.md` § The question (Poros, 2026-10-07), under the card of 2026-10-03, which stays. The section's source is
`data/fs124/p1/question-2026-10-07.md`; the card below is copied from it by script. The stub's "Bearing on the answer" has a dated
paragraph for the measurable class and its provisional bearings a dated line; no banner and no other lane's line was touched.
`poros_gate.py cards` on the stub reports one failure by construction — two dated cards in one file each carry rank 1 (ll. 61 and
114) — and this record's gate is the binding one.*

question: what-does-a-tight-unit-pair-pass-on
  evidence: `plans/FS132-derivation.md` § 12 — every exclusion of FS-132 is arc-free, and the three entries that reach the object
    conclude at it or produce it (C132-PLACED-RING, C132-COMP-SHARP as stated, C132-LENS); C132-M-EXCL (its § 1) forces the centre's own
    labels onto the ring at every witnessed four-cycle; `LEDGER.md` row 135, "a close complementary pair … sits on a unit rhombus with
    four-colour corners (FS-110's T2, forced)", and row 136, each printed positive "stops at the unsaved second common unit point of a
    close complementary pair saved at its first"; control `kept-model` (that file, l. 354): labels 012, 1234, 012, 0145, 012, 0235,
    interfaces-of-x=3 on-unit-circles-about=[1, 3, 5] — one shape in all 192 models, a three-label centre with three complementary
    partners, each pair saved at both common unit points
  expected: that the unit arc is the hard case — the one exception each exclusion leaves, to be excluded next at an explicit radius, ring type by ring type
  ask: When near one end of a unit pair one label fills the inside of the unit circle about the other end and another label the outside, what must a weak six-colouring carry at the two rhombus completions, and does that recur or run out?
  if it recurs (a completion is again an end of tight pairs, its labels fixed by the pair's): the tight pairs of a six-colouring span
    a labelled piece of the unit triangular lattice; FS-124 becomes one question about that labelled skeleton at every radius — the YES
    side grows the kept shape along it, the NO side looks for the lattice point with no label set left — and the cases 1, 3, 4 and 5
    above are its local rules
  if it runs out (some completion, or a point a bounded number of unit steps on, is left no label): that distance is the explicit
    radius, the exclusion holds for every weak six-colouring with a tight pair of the kind named, and what remains for seven is only
    that every six-colouring has such a pair
  if nothing is forced beyond the first step (the completions lose the pair's two labels and are otherwise free): tight pairs are not
    a skeleton; the milestone is the case list after all, worked case by case in this section's grammar, SEMI-PAR3 and the capped
    strip's family first
  answered by: derivation — Ephodos, FS-124's opening job and its first round, on the first claims below
  cost: an opening job; five first claims of a stage or less each; then one round on the skeleton
  hunch: it recurs at first order and the count bites at the centre — a four-label point cannot be the centre of tight pairs at all
    six points of a 60° orbit of its ring, so a skeleton that saves every pair twice needs five-label centres (C124-SIX; 0.5 that the
    card's first branch is the one that occurs)
  falsifier: a weak six-colouring or a held fragment with a tight pair one of whose rhombus completions has a label of the pair
    present; or a four-label point of a held object that centres six such pairs
  rank: 1

**Why this card and not the stub's of 2026-10-03 re-worded.** That card asked what a (Q) ring passes "to the four-colour vertices its
change points place"; its unit was the vertex and its ring type, and three of its hypotheses (vertex, change point, (Q)) have no
measurable form without a dictionary. This one keeps its question — what is passed on, and does it recur or close — and changes the
unit to the pair, which is defined for every measurable colouring, and whose first two consequences (at the centre, at the
completions) are corollaries of an entry already held. The eight cases are not withdrawn: they are the ways the two ends of a tight
pair can be filled in a map.

**The six first claims**, by side (statements in the stub): YES — C124-RADIUS (up). NO — C124-HALF; C124-SIX read as an exclusion on
a closed unit disc. Deciding between — C124-COMPLETION, C124-SIX. No side — C124-CENTRE, C124-KIND, C124-RADIUS (down).

**What I checked of my own claims before posing them, and what I did not.** C124-CENTRE and C124-COMPLETION: I matched each sentence to
C132-SHADOW's statement, sign by sign (the two half-planes at the completion have normals 120° and 60° apart, so both directions `v`
exist); not derived, one mind, minutes. C124-SIX: the count is `tools/fs124_p1_cones.py`; the step from closed unit discs to half-planes
at `q` is asserted, not written. C124-HALF: the quadrant argument is C132-CROSS's, run with one set on the circle; its first statement
has no held inhabitant and may be vacuous at six. C124-KIND: the two margins of the hexagonal colouring at circumradius 2/5 (0.8 and
1.033) leave room for a short unit arc by a sagitta estimate only; no formula was written. C124-RADIUS (up): the motion group's map to
(point, unit vector) for one edge is a diffeomorphism onto its image, so a null set of bad pairs pulls back to a null set of motions;
not written out. Each is a claim for the deriver, and none is an entry.

## Stage 3 — SAVED: for the kernel lane, for the search, for Kooshi; three answers owed

### 3.1 For the kernel lane

**Plan C124-RADIUS first, if it is derived** — both statements, at every `k` for (up). It rests on nothing of FS-132's [hand] entries:
(up) is this library's N-EASY argument run on a disc with de Bruijn–Erdős, (down) is the declared outside theorem
`Outside.OAI158.proper_to_borel_weak` and a restriction. It is the statement through which either answer of this milestone is consumed —
a NO becomes "this disc has no weak six-colouring", a YES a family on discs — as M36's certificate machinery is for periodic avoiders;
and (up) at `k = 5`, with the first import, gives a radius at which no disc has a weak five-colouring, which the release does not
state. **The dependency to formalize with it** (Kooshi, 2026-10-07: "if any dependencies need to be formalized, have those done as
well"): the weak colouring of an *open set*, the local form the planner listed second (`plans/FS132-kernel-plan.md` § 3.6) — every
C124 claim is local, so it is this milestone's shared definition. **Second**: C132-SHADOW ("one intermediate value, one open set, one
Fubini") with C124-CENTRE and C124-COMPLETION as its corollaries; every exclusion this milestone can reach stands on them. C124-SIX
waits for its derivation: its wording at the step from closed unit discs to directions at `q` is the place I expect a restatement.

### 3.2 For the search

**The held request (`plans/SEARCH-QUEUE.md` line 11: the kept four-label fragment extended to the annulus and the closed unit disc) is not
worth a day as queued; it is worth one after two claims, re-aimed.** As queued, its yes is a valid fragment of radius just above 1
about a three-label point — a shape already held three times over (fragment T2's), below every held radius — and its no is a null in a
design family "with a handful of interfaces per sector", which measures the family (G21). What changed today: if C124-COMPLETION and
C124-SIX hold, the kept shape continued as it begins (three-label points of two complementary types on a unit honeycomb, four-label
points at the hexagon centres) cannot keep four-label centres, and the request that decides something is another one — **the first-order
label skeleton**: on the points of the unit triangular lattice within radius 2, then 3, then 4 of a three-label point, assign label sets
and tight pairs obeying the two rules, the 60° rule and C124-SIX; a constraint problem on 19, 37 and 61 points, exhaustive. *Its yes*
at every radius tried: a combinatorial skeleton to fill, and the design problem of line 11 re-posed on it with the centres' labels
known (five, by C124-SIX, where six tight pairs meet). *Its no* at a radius: the first-order rules alone kill the saved skeleton there,
by a certificate a deriver can read back as a count — the NO side's first exclusion at the object, in the class of colourings whose
tight pairs lie on one lattice (said in its headline). Neither is a statement about all weak colourings. Queue it when the two claims
are derived; until then line 11 stays held.

### 3.3 Three lines for Kooshi

1. **What it asks.** Every six-colouring we can analyse has a boundary between two colours that runs exactly along a circle of radius 1
   around a point one unit away. The milestone asks what such a boundary forces at the four corners of the unit rhombus it sits in —
   its two ends and the two points one unit from both — and whether that forcing reproduces itself across the plane or runs out within
   a fixed distance.
2. **What a yes and a no mean.** If it reproduces, a six-colouring has a rigid lattice skeleton: build it at every size and the plane
   needs six; find the size at which it contradicts itself and it needs seven — once we also know every six-colouring has such a
   boundary, which this milestone does not ask. If it runs out, no six-colouring carries such a boundary past that distance: seven,
   with the same proviso. A short separate statement makes "six-colourings of discs of every size" the same as "the plane needs six".
3. **What I expect.** The first forcing step holds (0.85); the skeleton recurs rather than runs out (0.50 against 0.12, the rest
   "nothing forced"); an exclusion at a named distance within this milestone 0.10; a six-coloured object larger than any held 0.12;
   six against seven decided here 0.03.

### 3.4 The record job's two questions, and the coordinator's one

**Is FS-135's question 4 (the one-edge form) a question?** No — not a card, and not a first claim of FS-135. It asks whether every
witnessed cycle at `y` contains the pair `{a, b}`; its only consumer, C132-TURN-EDGE's contradiction, needs `y` to carry a witnessed
cycle at all, which is the seed's existence asked at `y`. What it wanted — a statement at a point "near which one side of a unit circle
through `y` carries `a` and then `b`" — is, in today's grammar, a statement at an end of two tight pairs, and C124-CENTRE and
C124-COMPLETION say what is there without any witness. It stays in FS-135's stub as a recorded open form with its history.

**Is C132-RADIUS FS-124's YES-side clause, or a short job of its own?** Both, in this sense: it is FS-124's first claim (C124-RADIUS,
re-posed as two statements, since "iff" hid that one direction needs the import and the other does not), derived as its own entry in
the opening round; it is not a milestone. Its Lean module is worth planning alone (§ 3.1), because it depends on nothing else here.

**The row-139 note: is it true as drafted?** Its first clause is true of the entries it cites; as a note on row 139 it is not, and I
recommend it stay declined. Read against the row and its derivation file:
1. *"the complementary pair's exclusion needs no cone scale"* — true of C132-CROSS and C132-COMP-SHARP: their statements carry no
   scale, and C132-CROSS's own *not claimed* line puts "the quantified form with holes" at "FS107-R-CP, row 133". But it is not news
   for the exact class and not about row 139: the cone scale of rows 133 and 139 is (B), a hypothesis of route R for band-proper
   partial colourings with holes; for exact maps row 133 already held the scale-free form as a design rule (W-TAN), and its cell
   already carries FS-132's line ("in the exact class the tangent pair is an edge that lies on the unit circle about the common unit
   point"). Row 139's own entry declines the stronger reading: "not claimed: that either route closes; that the cone scale is idle in
   route M" (`plans/FS111-derivation.md` l. 240).
2. *"up to one residue"* — understates it. In the exact class with unit arcs the pair is not excluded with a corner case left over; it
   is **saved**, and the residue is the saving: rows 135–136 ("sits on a unit rhombus with four-colour corners (FS-110's T2, forced)";
   "saved at its first by such a vertex"). The residue is FS-124's object.
3. *"what is left of route R there is the forcing"* — false as an account: the forcing **and** the residue. A forced close
   complementary pair in the exact class delivers a tight pair, not a contradiction.
So: my finding of the night, "(B) has no consumer there (finding B, if it holds)" (`plans/POROS-2026-10-07-fs132-night.md` l. 134), is
true and empty — there are no holes in the exact class for (B) to bound — and the two rows it would have annotated say nothing it
corrects. The same over-reading is in my drafted banner for FS-122 ("the pair's exclusion needs no cone scale … so the question is the
forcing alone"); § 4.4 below replaces it.

## Stage 4 — SAVED: the re-rank

## Draft re-rank

*This draft **replaces** the two unfiled drafts of the night (`plans/POROS-2026-10-07-fs132-night.md` § The ranked table, and
`plans/POROS-2026-10-07-fs132-round2.md` § Draft re-rank). What of them stands is carried here and named. `CLAUDE.md` and
`plans/FRONTIER-STUBS.md` were re-read from disk at this stage (after the filing `fd3988367`, "FS-132, six by the nerve: Derived"):
the ranked table there still has FS-132 at rank 1 and no row for FS-134 or FS-135. Ranked by bearing on the answer, never by difficulty
(§ Counter-priors, rule 1). Keryx files.*

### 4.1 The ranks, 1 to 16 (17 to 72 as filed)

FS-132 leaves the ranked list: it is Derived, and belongs in § Open milestones. The sixteen top ranks, filed → drafted:

| rank | stub | filed rank | the row's text |
|---|---|---|---|
| 1 | FS-124 | 2 | § 4.2, in full |
| 2 | FS-135 the seed remainder | new | § 4.2, in full |
| 3 | FS-127 lateral extent | 6 | § 4.2, in full |
| 4 | FS-122 the forced pair | 5 | § 4.2, in full |
| 5 | FS-128 the top colour, at six | 7 | the night's draft row, verbatim (`plans/POROS-2026-10-07-fs132-night.md` l. 400), with the rank 5 |
| 6 | FS-130 the bicycle's windings | 15 | the night's draft row, verbatim (that file, l. 398), with the rank 6, and this sentence added to its question cell: "The winding lemma asks that no two changes be 60° apart (C132-INDEX's *not claimed* line), and on every six-coloured object held the changes are exactly 60° apart — the tight pairs' lattice — so this row bears on colourings with no tight pair only." |
| 7 | FS-125 the saturated local exclusion | 4 | § 4.2, in full |
| 8 | FS-123 the Siamese class | 3 | the night's draft row, verbatim (that file, l. 401), with this sentence added to its question cell: "The composition, and the one fact it needs (a map's palette is its ring read two-sidedly), are FS-134's (`plans/STUB-exclusion-back-to-maps.md`), a short job." |
| 9 | FS-117 route T, the count | 8 | as filed |
| 10 | FS-109 the hole dial | 9 | as filed |
| 11 | FS-104 the null-set step | 10 | as filed |
| 12 | FS-120 the pinch at a junction | 11 | as filed, with the banner of § 4.4 |
| 13 | FS-126 curved pencils | 12 | as filed, with the banner of § 4.4 |
| 14 | FS-62 six is not a value | 13 | as filed |
| 15 | FS-39 the bridge to the plane | 14 | as filed |
| 16 | FS-115 the stuck ray | 16 | as filed |

**Unranked, with the reason: FS-134, the exclusion back to maps** (`plans/STUB-exclusion-back-to-maps.md`, minted 2026-10-07 by
FS132-Z2). A short job — one fact (F2) and one composition. It bears on the map class's statement only (rows 148–149 with no Siamese
clause, which is FS-123's first case), moves nothing on six against seven, and is **not on FS-124's path**: FS-124's claims are posed
over open one-label pieces, so a held map is a control with no dictionary. Its line for § Open milestones: "FS-134, the exclusion back
to maps: a short job, unranked; run when a derive slot is free; closes FS-123's first case in the map class."

### 4.2 The rows that change, in full

| rank | stub | the question | bearing on the answer | cost | status | solver |
|---|---|---|---|---|---|---|
| 1 | **FS-124 the unit arc: what a tight unit pair passes on** — `plans/STUB-q-ring.md` (minted 2026-10-03 by FS116-Z2 as the (Q) ring; re-posed 2026-10-07 by FS124-P1 for every measurable colouring; **Opened 2026-10-07**, Kooshi's choice) | when near one end of a unit pair one label fills the inside of the unit circle about the other end and another label the outside (a *tight pair*: in a map a boundary arc of a unit circle, the (Q) arc when its centre carries both side colours and at least four), what must a weak six-colouring carry at the pair's two ends and at its two rhombus completions, and does that recur along the unit triangular lattice or run out within an explicit radius? **First** (its question section of 2026-10-07, six claims posed, none derived): C124-RADIUS (weak six-colourings of discs of every radius give `χ(ℝ²) ≤ 6`, and the converse over the declared outside theorem); C124-CENTRE and C124-COMPLETION (what a tight pair forces at its centre and at its completions, at every number of labels, each a corollary of C132-SHADOW); C124-KIND (a calibration at seven); C124-SIX (a four-label point is not the centre of six tight pairs of two label pairs on one 60° orbit); C124-HALF (C132-ARC with its sides named). Held for maps: rows 135–138, 145–150, 153, and the card of 2026-10-03 with its eight cases, which stand as the ways a tight pair's two ends are filled in a map. Held in measure, [hand], one mind, kernel pending: C132-M-ORBIT, C132-COMP-SHARP, C132-PLACED-RING; the release's two-state theorem read at six (C132-DIAG-WIDE). In a finite family, [cert]: the Searcher's kept shape, a three-label centre with three complementary partners, each pair saved at both common unit points by a four-label point (SEARCH-1007-TURN4, local) | the object every exclusion held ends at and every six-coloured object held is made of — and what the exclusions force, not what they leave over: at a witnessed four-cycle (C132-M-EXCL), at a close complementary pair (C132-COMP-SHARP), in every non-Siamese valid six-map (rows 137, 149). **Toward seven**: an exclusion of tight pairs of a named kind at an explicit radius, which is `χ(ℝ²) = 7` only with a statement that every weak six-colouring has such a pair (FS-135 for a seed; FS-127 and FS-128 for the seed). **Toward six**: weak six-colourings of discs of every radius are `χ(ℝ²) = 6` (C124-RADIUS, posed; for maps FS116-O1-YESLIM, held); the held objects stop below `φ²/√2` about a tight pair's centre. Alone it delivers what a tight pair passes on and the first count that spends six on the arc's side | unpriced | **Opened** 2026-10-07; rank 2 → 1 (FS124-P1) | none in the milestone; `plans/SEARCH-QUEUE.md` line 11 held, and one request drafted (the label skeleton on a lattice patch), each waiting on C124-COMPLETION and C124-SIX |
| 2 | **FS-135 the seed remainder** — `plans/STUB-seed-remainder.md` (minted 2026-10-07 by FS132-Z2) | at a point with data on its unit circle (a seed) and no tight pair at its ring points, do the configurations FS-132 left open exist: the sixteen patterns of sides whose witnessing sets are far away (C132-LENS-II, a gap); the alternating and the turning ring for germs that are only measurable (three shift lemmas for C132-ALT, sketched; the third-label rigidity, unproved)? Its question 4, the one-edge form of C132-TURN's stall, is **not asked** (FS124-P1 § 3.4): its content returns as C124-CENTRE and C124-COMPLETION at the placed point | necessary on the road to seven, silent on six: it is the statement that a seed with no tight pair does not exist — the step between "every colouring has a seed" (FS-127, FS-128) and FS-124's exclusions; C132-M-EXCL is its four-cycle half, held | unpriced | Not started; **new, at rank 2** (FS124-P1) | in-ban: derivation; the Searcher's wedge family is its finite control |
| 3 | **FS-127 lateral extent** — `plans/STUB-lateral-extent.md` (minted 2026-10-03 by FS121-Z1; re-aimed 2026-10-07) | does every weak six-colouring have, in every disc of radius above 1, a point with usable data — a cyclic centre isolated among the cyclic centres (what the extraction reads: zero length of the centres and isolation of the essential one, `plans/FS132-E1-derivation.md` § Card 2), or a point through which connected pieces of two smoothed classes pass and reach a common second point (C132-WIT-EX's form (O), where FS-132 stalled) — for all weak colourings, or for honest ones (row 143's normal form; C132-GRUNDY7 did not decide whether honesty removes accumulation)? Carried from FS-132: C132-WIT-EX (O), C132-RING-TAME's first clause, the REG-J′ side question | the existence step of every road to seven that passes through a point: with FS-135 and FS-124's exclusion it is `χ(ℝ²) = 7`; nothing toward six. Asked three times in FS-132 and left there by Kooshi's word of 2026-10-07: ranked by bearing, not proposed as the next opening | unpriced | Not started; rank 6 → 3 (FS124-P1) | in-ban |
| 4 | **FS-122 the forced pair** — `plans/STUB-forced-pair.md` (minted 2026-09-28 by FS111-C; route R; re-aimed 2026-10-07 at the exact class) | in a weak six-colouring all of whose seeds are triangles, must two with disjoint label triples lie closer than 2 — or two of one type between 1 and 2 apart (the bicycle, FS-130)? In the exact class a close complementary pair is **not excluded**: one of its six edge sets lies on the unit circle about each common unit point (C132-COMP-SHARP, [hand], one mind) — rows 135–136's rhombus, the pair saved by tight pairs — so the forcing delivers FS-124's object, not a contradiction. Carried from FS-132: C132-M-CV and C132-LONG, the forcing, stalled at C132-RING-TAME. The count behind it (eleven vertices against ten types) is cited to `[SokolovVoronov2025]` Lemma 6.1 in this row and to `[Voronov2023]` in FS-130's: one is a slip, to check against the papers at the filing. B-RR stays the band form's question | the forcing in route R's form: with it every colouring that lives on triangles has a tight pair — FS-135's conclusion by another road; nothing toward six | unpriced | Not started; rank 5 → 4 (FS124-P1) | in-ban |
| 7 | **FS-125 the saturated local exclusion** — `plans/STUB-saturated-local.md` (minted 2026-10-03 by FS116-Z2; route M's honest branch) | NO-SAT: an explicit radius about a four-colour vertex within which no valid fragment saturated one unit inside exists. Held: every edge at a four-colour vertex of a saturated fragment is a unit arc about a ring point carrying both its side colours, or tangent (FS116-O1-SATPIN, in its corrected wording) — in FS-124's words, saturation makes every tight pair at such a vertex of kind both. Left: SAT-STRIP's G3, G1, G2 on rings with (Q) arcs, SATPIN-PER, NO-SAT, Y-SAT | none on the measurable road unless one condition holds: C124-KIND true **and** FS-124's exclusions needing "of kind both" — then this is the class that supplies the kind, and FS-124's NO is stated in it | unpriced | Not started; demoted 4 → 7 (FS132-P2, FS124-P1) | in-ban |

### 4.3 The top three, as `CLAUDE.md` § Paths forward should carry them

| rank | stub | the question | bearing on the answer |
|---|---|---|---|
| 1 | **FS-124 the unit arc** — `plans/STUB-q-ring.md` (Opened 2026-10-07) | where a boundary between two labels runs along the unit circle about a point one unit away (a tight pair; the (Q) arc of maps), what must a measurable six-colouring carry at the pair's two ends and at the two points one unit from both — and does that recur along the unit triangular lattice or run out within an explicit radius? First: six claims posed (C124-RADIUS, -CENTRE, -COMPLETION, -KIND, -SIX, -HALF) | what every held exclusion forces and every held six-coloured object is made of; an exclusion at a radius is `χ(ℝ²) = 7` given that every six-colouring has such a pair (FS-135, FS-127); six-colourings of discs of every radius are `χ(ℝ²) = 6` |
| 2 | **FS-135 the seed remainder** — `plans/STUB-seed-remainder.md` | does a point with data on its unit circle and no tight pair at its ring points exist — far witnesses, and rings whose germs are only measurable? | the step from "every colouring has a seed" to FS-124's object; its four-cycle half is held (C132-M-EXCL); nothing toward six |
| 3 | **FS-127 lateral extent** — `plans/STUB-lateral-extent.md` | does every measurable six-colouring have a point with usable data in every disc of radius above 1 — for all colourings, or for honest ones? | the existence step of every road to seven through a point; stalled three times in FS-132 and left there by Kooshi's word; nothing toward six |
| 4–72 | 69 more open stubs, in rank order in `plans/FRONTIER-STUBS.md` | … | … |

**A line for § Open milestones**: "**Opened 2026-10-07: FS-124, the unit arc** (`plans/STUB-q-ring.md`; Kooshi's choice), re-posed for
every measurable colouring proper at almost every unit pair: what a tight unit pair passes on (`plans/POROS-2026-10-07-fs124-question.md`).
FS-134, the exclusion back to maps, is a short job, unranked."

### 4.4 Banners for Keryx to file (one line each; these replace the night's five)

- `plans/STUB-qfree-ring.md` (FS-123): the night's banner stands, verbatim (`plans/POROS-2026-10-07-fs132-night.md` § Banners, first
  line), with "FS-134 carries the composition" added after its first sentence.
- `plans/STUB-forced-pair.md` (FS-122): "Re-aimed, 2026-10-07 (FS132-P2; wording corrected by FS124-P1), at the exact class: a close
  complementary pair is not excluded there — one of its edge sets lies on the unit circle about each common unit point (C132-COMP-SHARP)
  — so the question is the forcing, and what the forcing delivers is FS-124's object. B-RR stays as the band form's question."
- `plans/STUB-lateral-extent.md` (FS-127): "Re-aimed, 2026-10-07 (FS132-P2, FS124-P1): it carries the existence of a point with usable
  data — C132-WIT-EX's form (O), C132-RING-TAME's first clause, the REG-J′ side question — for all weak colourings or for honest ones
  (row 143). Ranked by bearing, 6 → 3; left unopened by Kooshi's word of 2026-10-07."
- `plans/STUB-saturated-local.md` (FS-125): "Demoted, 2026-10-07 (FS132-P2, FS124-P1), 4 → 7: on the road again on one condition —
  C124-KIND true and FS-124's exclusions needing 'of kind both', which saturation supplies (FS116-O1-SATPIN)."
- `plans/STUB-curved-pencils.md` (FS-126), `plans/STUB-pinch-at-junction.md` (FS-120): the night's banner stands, verbatim (its fourth
  line), for these two.

### 4.5 The closed list, and what of the night's drafts stands

**Closed list**: no row closes — nothing derived is kernel-checked and nothing is two minds'. FS-132 is Derived, not closed, and moves
from the ranked table to § Open milestones. The night's one change of wording to FS-116's entry (`plans/POROS-2026-10-07-fs132-night.md`
§ The closed list) stands as drafted there. **Carried from the night's drafts**: the rows of FS-128, FS-130 and FS-123 (§ 4.1); the
banners named in § 4.4; the citation slip flagged in FS-122's row. **Withdrawn from them**: FS-132's rows (the milestone is Derived);
FS-124's two draft rows (replaced by § 4.2); FS-122's row and banner in the wording "needs no cone scale" (§ 3.4); FS-127's row in its
conditional wording ("only if the witness card finds…"), which the second and third rounds overtook.

## Hunch ledger

*Carried forward from `plans/POROS-2026-10-07-fs132-night.md` and `plans/POROS-2026-10-07-fs132-round2.md`. The night's closed entries stay
in those files (deprecated, never deleted); the three still open there are restated here with today's status. **The score by basis, both
nights and today**: read — 5 of 5 confirmed; derived — 5 confirmed, 1 killed, 2 open; analogy — 0 confirmed, 2 killed, 1 open; prior —
3 confirmed, 5 killed, 3 open. The three prior-basis hunches that held are of this morning, registered from the front page minutes before
the entries that settled them were read — predictions of what a record says, not of mathematics; the night's five scored priors, which
were about mathematics, all died. Read before you guess.*

hunch: the-two-appearances-are-one-relation-with-roles-exchanged
  claim: the arc on a rich point's own ring and the arc through a rich point are one object exactly when the arc's centre is itself a rich point, and that is a theorem for maps and not yet one in measure
  basis: prior
  falsifier: an entry of `plans/FS132-derivation.md` that proves, for every measurable colouring, that the centre of an interface arc through a cyclic centre is itself a cyclic centre or carries at least four labels
  registered: 2026-10-07
  status: confirmed (by: derivation C132-LENS-FOUR and C132-PLACED-RING's not-claimed line, `plans/FS132-derivation.md` § 5 — four labels at the placed point only under three consecutive outer-pure ring points; for maps FS116-N3-SEMI, `data/fs116/claims.md` l. 190. Sharper than registered: both ends rich is one named configuration, § 1.2)

hunch: radius-statement-is-the-easy-argument
  claim: C132-RADIUS is the statement that measurable fragments at every radius give six, and it follows from the random-rigid-motion argument in under a page
  basis: prior
  falsifier: C132-RADIUS as posed is a different statement, or its derivation needs more than absolute continuity of the edge map plus de Bruijn–Erdős
  registered: 2026-10-07
  status: open

hunch: row-139-note-is-true-but-misfiled
  claim: the complementary pair "needs no cone scale" in the exact class is true, and is not a statement about row 139's entries, whose cone scale lives in the limit class
  basis: prior
  falsifier: row 139's derivation uses the cone scale in the exact class too, or the night's entry is narrower than the note
  registered: 2026-10-07
  status: confirmed (by: derivation C132-CROSS, whose not-claimed line reads "any area or scale (the quantified form with holes is FS107-R-CP, row 133)", and FS111-C1-ROUTES's entry, `plans/FS111-derivation.md` l. 240, "not claimed: … that the cone scale is idle in route M"; Stage 3 § 3.4 has the verdict)

hunch: map-to-measure-goes-around-the-dictionary
  claim: carrying a map-class exclusion into the measurable class needs the argument re-read at its class, not FS-134's dictionary fact, which runs the other way
  basis: prior
  falsifier: `plans/STUB-exclusion-back-to-maps.md` states its fact as needed for the map-to-measure direction, with the step named
  registered: 2026-10-07
  status: confirmed (by: derivation C132-SHADOW, stated over an open set "almost every point of which has the label i" — a map's tile is one, with no palette read; and the stub's own F2, ll. 40–52, which serves reading C132-M-EXCL at a map vertex)

hunch: the-room-is-on-q-rings
  claim: (carried from the night) whatever room six colours have is on rings that carry the centre's own labels
  basis: analogy
  falsifier: a weak six-colouring, or a fragment past `√3`, none of whose rich points has a tight pair on its ring
  registered: 2026-10-07
  status: open

hunch: the-two-stalls-only-look-alike
  claim: (carried from round 2) the ring card's stall and the witness card's stall are different statements
  basis: prior
  falsifier: one statement whose proof closes both
  registered: 2026-10-07
  status: open

hunch: the-turning-seed-places-a-fourth-label-inside
  claim: (carried from round 2) on a turning seed the lens at a ring point holds a label of the centre, so a four-label point is placed
  basis: derived
  falsifier: a turning seed with six pure sides and no four-label ring point
  registered: 2026-10-07
  status: confirmed (by: derivation C132-LENS and C132-LENS-FOUR, `plans/FS132-derivation.md` § 5 — for three consecutive outer-pure ring points only; C132-LENS-II is the gap for the sixteen other patterns)

hunch: the-arc-is-the-rule
  claim: (frame F1) in a weak six-colouring the unit arc is forced wherever a rich point is known, so it is the colouring's skeleton and not a case of a case list
  basis: read
  falsifier: an exclusion entry whose arc-free hypothesis is shown to hold at some rich point of some six-coloured object held or built
  registered: 2026-10-07
  status: confirmed (by: `plans/FS132-derivation.md` C132-M-EXCL's statement and § 12's last row; `LEDGER.md` row 135 "every unit arc reduces…", row 149; control `positives-escape` — for maps and at witnessed four-cycles; for every weak colouring it waits on a rich point existing, which is not this milestone's)

hunch: the-unit-is-the-tight-pair
  claim: (frame F2) stated by what determines it, the object is a unit pair tight for two labels, and each appearance is one end of it
  basis: derived
  falsifier: a held unit arc, in a fragment or in the kept model, that is not a tight pair in the stated sense; or an entry in which the two appearances differ by more than the end stood at
  registered: 2026-10-07
  status: open

hunch: constant-width-owns-the-inside
  claim: (frame F3) the theory of sets of constant width and of intersections of unit discs has a statement that bears on a tile pinned along an arc by its own point
  basis: prior
  falsifier: a reading of that literature finding statements about one body only and none about a partition or a packing of such bodies with a second class pinned from outside
  registered: 2026-10-07
  status: open

hunch: four-labels-cannot-centre-six-tight-pairs
  claim: (C124-SIX) a point where exactly four labels are present is not the centre of tight pairs at all six points of one 60° orbit of its ring when the three even ones use one pair of its labels and the three odd ones the other pair
  basis: derived
  falsifier: an error in the half-plane count (`tools/fs124_p1_cones.py`), a gap in passing from C132-SHADOW's closed discs to half-planes, or a held fragment with such a four-label point
  registered: 2026-10-07
  status: open

Invention signal: none new. Read for it in the stub (whole), `plans/FS132-derivation.md` §§ 1–9 and 11–12, `LEDGER.md` rows 133, 135, 136, 138, 139 and 145, and the two new stubs. Two things looked like collisions and are not: "nothing excludes the arc" against "the arc is forced" are both true and together are the reframe of § 1.3 (the shared premise — that the arc is one case — is named there as a chosen commitment, and I do not send it to Ephodos as an invention because no held description has to be revised); and the stub's l. 250 against FS-134's own stub is a slip of direction, reported as a correction owed. One whiff already on record stays where it is with no side picked: C132-EXT-DISC's clause (5) against the manuscript's sentence "The extracted cycle need not consist of edges of Γ_x" (`plans/FS132-derivation.md` ll. 474–482).
