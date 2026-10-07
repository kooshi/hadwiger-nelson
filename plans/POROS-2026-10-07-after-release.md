# POROS — the frontier after an outside proof of six became this project's literature (FS132-P1)

*Poros, job 1 (the re-rank and the next question), brief `data/fs132/briefs/FS132-P1-rerank.md`. Working files: `data/fs132/p1/`.
The release is `[OAIMath2026]` family 158, read-only at `/home/kooshi/source/math` (commit `adc7f124`); below, **M** is its
`preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/build/sections/`. "The reading" is
`plans/EXT-OAI2-reading.md`; "the audit" is `plans/EXT-OAI1-audit.md`.*

## Theorems this phase proved

None. This is an asking job: it poses claims for the deriving lane and proves nothing. Statements written below with a label
`C132-…` or `C133-…` are claims to be derived, each at the grade "posed"; the hunches in § 1.5 are hunches.

## Would-have-searched-here log (standing rule 5)

- The placement of a 5-chromatic unit-distance graph inside the four-label region about a (Q)-free four-colour vertex (the reading's
  § 3.5) is already queued (`plans/SEARCH-QUEUE.md` line 9, per inventory item 618). I add nothing to the queue.

## Fence log (standing rule 8)

No fence in this brief; nothing fenced was read.

## Stage 1 — SAVED

### 1.1 Readback of the brief

`data/fs132/p1/readback.py` looks for every quoted line of the brief verbatim in its named source: **21 quotations, 21 lines
matched, 0 mismatched** (`data/fs132/p1/readback.out`, exit 0). Control: `--fault` changes one character of each quoted line and all
21 are reported as mismatches (exit 1). No finding about the brief's quotations.

Two findings about the brief's *frame*, which it invites (§ What is yours to decide):

1. **Its item 3 states the frame to test as "the release closes five by a cover of order two against a disc; at six a point may
   carry three colours and that obstruction is gone".** That is inventory item 616's reading (the audit's, one mind), which item 618
   reports the reading as correcting. Both are on record; § 1.4 treats the pair as an invention signal and does not pick a side.
2. **"Six-colour measurable colourings directly or one named step of their argument"** (item 1) leaves out the answer I arrive at in
   § 1.6: a question about *this project's* held six-colour chain, asked on the release's objects.

### 1.2 Expectations, registered before the reading, and their scores so far

Registered in `data/fs132/p1/expectations-before-reading.md` (commit `62d3db9c`),
written after the brief, Kooshi's words and the inventory items, before either record, the manuscript, the catalogue or the ranking
was opened. Scored here where the reading already decides; the rest at the stage that decides them.

| | claim (short) | p | outcome |
|---|---|---|---|
| E5 | FS-104 answered in its YES form and only there | 0.80 | **met** — the reading § 1.3, § 5.2: `χ_m⁰(ℝ²) ≥ 6`; the null-set step to `χ_m`, `χ_B` and the ZF + DC audit "not addressed by them" |
| E8 | the manuscript names, in a sentence of its own, why six is out of reach | 0.35 | **lost** — `M/introduction.tex:70`: "The remaining alternatives six and seven are unresolved." and nothing else: `rg -i 'six.col|six label|k = 6|more colors'` over the eight sections returns only the history line about Woodall (`introduction.tex:51`) |
| E9 | another family of the catalogue bears directly on six against seven | 0.30 | **lost**, by catalogue entries only — none does; § 1.3's last item names four a route could use, each unread |
| E10 | the reading turns up an invention signal | 0.50 | **met** — § 1.4 |
| E12 | a five-only statement is five-only in its statement and not in its argument | 0.40 | **half met** — the three headline statements are tightness statements (the reading's two counterexamples at seven, § 4.3); but `two_state_impossible` and `strict_state_no_unit_support` carry the count as a hypothesis and apply at six, and Act 3 is "typed at five only" with no count in its argument (the reading § 4.2, rows 7, 8, 10–13) |

E1–E4, E6, E7, E11: scored in the stages that decide them.

### 1.3 Evidence inventory

*By provenance, oldest first. "Read against" is the expectation written before the item was opened (for the two records and the
release, in the file of § 1.2 and here). An item too large to read whole says how it was sampled.*

- `data/external/EXT-OAI1-request.md`, Kooshi's three words — read against: the brief's three quotations match and his third word answers five numbered questions — surprised: no; whole file read, 39 lines
- `plans/FS131-close-inventory.md` items 607–609, 611–619 (Keryx's accounts of the two agents' messages), ll. 8002–8097, 8148–8460 — read against: the brief's quoted first lines match (checked by script) and each item separates the agent's account from Keryx's receipt — surprised: yes; item 616 (the audit: five is used at "the cover's order") and item 618 (the reading: "the cover of order two is not where five enters") are both on record and item 618 settles it in one sentence
- `plans/EXT-OAI2-reading.md` stage 1, the dictionary (ll. 30–198) — read against: their Definition 1.2 is the object of `χ_m⁰`, not Falconer's and not Borel-only — surprised: no; § 1.3's row for Def. 1.2, with its attack (a)–(c)
- `plans/EXT-OAI2-reading.md` stage 2, the transfer (ll. 200–400) — read against: the colouring is used only on a countable set; rigidity says wild implies Haar and nothing about the tame part; it uses a property no number field has — surprised: yes, once; F1 "needs less than its hypothesis: a proper `k`-colouring of the countable graph on `E`" (l. 313), so the transfer's input is a colouring of the algebraic plane and `χ(ℝ²) = χ(ℚ̄²)` is its unstated corollary
- `plans/EXT-OAI2-reading.md` § 2.6, the one-class sketch (ll. 352–364) — read against: the unchecked step is the passage from a stationary field to a density, closable by an ergodic average (E11) — surprised: yes, in the direction of less risk; read at stage 3 with `LEDGER.md` row 129 and `CLOSED-QUESTIONS.md` ll. 655–668: the infimum the argument bounds is over graphs in the algebraic plane, which is at least the infimum over all finite unit-distance graphs — the direction needed — so the sketch needs no redrawing lemma, and with it Johnson's Question 3 follows too; the reading does not say either
- `plans/EXT-OAI2-reading.md` stage 3, the obstruction in four acts (ll. 402–652) — read against: the palette bound is a disjointness count giving `k − 3`; the extraction needs palettes of at most two labels to produce a graph-valued map — surprised: yes; the second half is wrong: the map is graph-valued off the cyclic centres because "a clique in a forest has at most two vertices" (l. 480), with no palette bound; the palette bound enters only Theorem 6.5 and § 8
- `plans/EXT-OAI2-reading.md` stage 4, five against every `k` (ll. 654–779) — read against: at least one all-`k` statement is stronger than the summaries say — surprised: yes; § 4.1 item 4: the cover theorem "says that *no* colouring, at any `k`, has a graph-valued approximant on a large disc", so at every `k` the cyclic centres are forced to exist; no summary states it as a theorem about six and seven
- `plans/EXT-OAI2-reading.md` stage 5, the drafts and § 5.4's stub proposals (ll. 781–1102) — read against: its proposals rank [P₆] first — surprised: no; § 4.3 "The first place where nothing is held by either side is **[P₆]**", § 5.4 (ii)
- `plans/EXT-OAI1-audit.md` stage 6, the proof's shape from its Lean (ll. 325–512) — read against: `fullApprox_exists` is at `Fin 5` on a disc of radius 5, and the statements the summaries call "every `k`" are typed so — surprised: yes; `fullApprox_exists_of_finite_core` (l. 404) asks the core only on `closedBall 0 8`, so the five-colour obstruction reads a bounded region: it is a theorem about a disc, stated about the plane
- `plans/EXT-OAI1-audit.md` stages 1–5, 7–8 — read against: nothing there changes what may be cited — surprised: unread; taken from inventory items 608, 609, 614, 619, which are Keryx's accounts
- `M/introduction.tex` (324 lines) — read against: E8 — surprised: no on the mathematics, lost on E8; sampled: ll. 36–62, 118–148 and every line matching six, seven, unresolved, conjecture, question
- `M/` §§ 2–8 (4,304 lines of TeX) and `lean/OAI/Geometry/PlaneColoring` — read against: nothing; I rely on the reading and the audit — surprised: unread; "recalled, not read" for every statement of the release quoted in this record beyond `introduction.tex`
- `/home/kooshi/source/math/CONTENTS.md`, the catalogue of 372 families — read against: E9 — surprised: no; sampled by `rg` on thirty phrases of this frontier's disciplines over family headlines; families named for a route, each **unread**: 085 (endpoint Sobolev regularity of centred disc averages — the release's approximants are thresholded disc averages), 096 (the Gaussian propeller conjecture — an extremal statement about measurable partitions whose optimum is a triple junction), 015 (torus-packet equidistribution over totally real fields, "combines measure rigidity" — beside row 120), 167 (a power saving for planar unit distances), 073 (the Falconer distance conjecture)
- `plans/FRONTIER-STUBS.md`, the ranking (190 lines, 149 kB) — read against: the top twelve are the regularity wall's, most of the tail says "none on the answer", and some low row is suddenly at the frontier — surprised: yes; rank 37, FS-39 the bridge ("what is left, B2 (`RealAlgebraicDescent`, months)") has an alternative discharge in the release's transfer; sampled: header and rules whole, ranks 1–3 whole (the brief), ranks 4–51 at the first 210/420/330 characters of their stub, question and bearing cells, ranks 52–74 by title and bearing's first 110 characters; the closed list (ll. 120–190) unread
- `plans/SESSION-HANDOFF-2026-10-06.md` §§ 2–4 and `plans/SESSION-HANDOFF-2026-10-07.md` — read against: E7 — surprised: yes; the newer handoff's § 4 (ll. 85–101, read whole): "`Row130Collapse`, a named hypothesis of wave 9, is the statement the release's transfer proves"; the older one sampled: every line naming waves 6, 7, 9, 10 (24 lines), the rest unread
- `plans/STUB-cp-plane-six.md`, `plans/STUB-q-ring.md`, `plans/STUB-qfree-ring.md`, `plans/STUB-forced-pair.md`, `plans/STUB-lateral-extent.md` — read against: nothing yet — surprised: unread; not opened: § 4.3's banners are drafted from the ranking's rows and the reading's § 5.4, and I rewrote no bearing section in them — a job owed (the report's inventory)
- The conditions of the last reading: my ranking of 2026-10-03 (`plans/POROS-2026-10-03-fs129-rerank.md`) was made with "given MR" in front of the plane's equality and with the map step taken as the only road from a measurable colouring to a point with interfaces — read against: both premises were earned — surprised: yes; the first is removed by a theorem, and the second was a premise of the frame, never a result: row 140 called the map step at five "a reformulation, not a step toward six", and nobody asked what the exclusions consume

### 1.4 What is curious, and the invention signal

**Three surprises with addresses, ranked by what their answers change.**

1. **The extraction never used the palette bound, and the cover theorem holds at every `k`.** The reading § 3.1 (Act 3): the
   thresholded disc averages land in the complete graph off the cyclic centres because "a clique in a forest has at most two
   vertices"; § 4.2 rows 10–13: Lemmas 7.2–7.8 "no" count, "typed at five only"; § 4.1 item 4: `compact_open_cover_impossible`
   "has no colour in it". So for a measurable colouring with **any** number of colours: (i) off its cyclic centres its smoothed
   classes are a graph-valued map up to small holes; (ii) no such map exists on a disc of radius 5; hence (iii) *the cyclic centres
   exist in every large disc, at every `k`* — true by inspection of the hexagonal seven-colouring (its vertices), and a theorem
   about every six-colouring if one exists. Pushes on the **object**: this project has studied the map; the thing is the measurable
   colouring's nerve, which exists with no regularity.
2. **This project's six-colour chain was never asked what it consumes.** Rows 137 and 148–149 are stated for valid six-maps and
   fragments, non-Siamese, with tiles and arcs; the reading § 3.3: "nothing in §§ 5–8 distinguishes Siamese pairs", and its table
   matches seven of the release's lemmas to rows of ours "re-derived in measure". The release proved, one colour down, that the
   exclusions need only a point, a label cycle, continua with limiting directions, and the two-colour exclusion. Whether ours do is
   unread. Pushes on the **question**: "make the tight colouring a map" (route M's step) may answer a question the exclusions
   never asked.
3. **The obstruction at five is about a disc.** The audit l. 404: the core is needed only on `closedBall 0 8`; the map lives on
   the disc of radius 5. With row 131's weak-* compactness the answer has a local form (hunch `critical-radius-form` below).
   Pushes on the **product**: "is there a six-colouring of the plane" against "is there a radius at which six-colourings of a disc
   stop".

**Invention signal: one item, stated in the words of both sides; no side picked.**

- *Side A* — `plans/EXT-OAI1-audit.md` stage 6, as inventory item 616 carries it (`plans/FS131-close-inventory.md` l. 8333):
  "**Where five is used, its reading, one mind, unchecked**: the cover's order — at six colours a point may need three positive
  coordinates, a 2-complex, where the disc is no obstruction; nothing in the cone states a six-colour analogue."
- *Side B* — `plans/EXT-OAI2-reading.md` § 4.1 item 4 (ll. 682–685): "**So the cover of order two against order three is not where
  five enters**: the cover theorem (`compact_open_cover_impossible`) has no colour in it and says that *no* colouring, at any `k`,
  has a graph-valued approximant on a large disc. Five enters in the two statements that would make one exist".
- *What cannot both be true as written*: A says that at six the obstruction is gone because the target grows a dimension; B says
  the obstruction stands at six unchanged and what fails is the filling of cores. The record settled it on the spot (item 618: "It
  corrects the audit's one-mind reading").
- *The premise both share, which is the finding*: **that the approximant's target is fixed before the colouring — the complete graph
  on the labels.** Under it, a triangle of classes is an *obstruction to be filled or killed* (B) or *a missing dimension* (A). Drop
  it — let the target be the nerve the colouring has, a triangle filled wherever three classes meet — and A and B are one
  statement: at seven every core fills by its own triangle and nothing is forced; at five no core may exist; at six the cores that
  remain essential are exactly the cycles of length four to six, and "some core is not a triangle" ([G₆], which the reading says
  needs "a global step") becomes "no approximant into the triangle-filled nerve exists on a large disc" — an order-three cover
  statement with a metric in it, which is the shape of `[Voronov2023]` Thm 1.3 and of route R's forced pair (row 139), not of
  Lebesgue's theorem. I do not say this works. Card 3 (§ 2) puts it to Ephodos.

**A wording collision, not a contradiction** (inventory kind: statement defect). "Slack" now names two things on this project's
pages: row 132's ("any colouring with slack" — a forbidden *interval* of distances everywhere, `[Voronov2023]` Thm 1.1) and the
reading § 4.3's ("slack at `v`" — local freedom to recolour near one vertex of the hexagonal seven-colouring). Row 132 says the
first needs seven; the reading says the second may or may not occur at six. A reader of the drafted G95 ("false under slack") beside
row 132 ("slack needs seven") will read a contradiction that is not there. The drafted entry should say *local slack*.

### 1.5 The hunch ledger, carried forward

*Carried from `plans/POROS-2026-10-03-fs129-rerank.md` §§ 1.4 and 2.2. Scored, with nothing changed since: confirmed —
third-statement-needed, the-base-print-steps-hold, fs115-waits, every-valid-map-has-a-four-colour-vertex, fs114-closed-undecided,
fragments-at-every-radius-give-six, q-rings-force-a-pattern, fs116-closed-undecided, fs121-closed-undecided,
identity-is-three-step-closure, bends-keep-the-class (repaired form), qfree-class-is-empty, five-route-orphaned,
next-miss-is-a-class-hypothesis-unread (weakly); killed, kept — the-unit-arc-no-is-global, the-closes-nominate-themselves,
curved-ladders-end-on-q-rings, closes-nominate-themselves-again, arithmetic-bears-through-compulsion,
fall-is-saturated-across-eras. Their full entries stay in that record. The open ones are restated here in the gate's form, each with
what the release does to it.*

hunch: kills-are-not-band-stable
  claim: FS-114's straddle kills do not survive an ε-band of slack uniformly in the complexity
  basis: analogy
  falsifier: FS114-Y4-RSTOPALL re-derived for band-proper fragments with slack ε and holes of density below η, at a radius and margin independent of the complexity
  registered: 2026-09-28
  status: open

hunch: local-f-overshoots
  claim: FS-116's one explicit radius is stronger than the NO; no held compactness gives a radius uniform in the complexity from the NO
  basis: derived
  falsifier: a derivation that valid fragments about four-colour vertices at every radius give a valid locally finite map of the plane
  registered: 2026-09-28
  status: open

hunch: route-m-consumes-unbounded-maps
  claim: FS-121's map step, if it lands, produces maps of no bounded complexity, so route M consumes the NO for every locally finite map
  basis: derived
  falsifier: a derivation that REG-A₆'s map can be taken of bounded complexity
  registered: 2026-09-28
  status: open

hunch: the-room-is-on-q-rings
  claim: every four-colour vertex with a valid fragment on the closed disc of radius √3 about it has a (Q) arc on its ring
  basis: analogy
  falsifier: a valid fragment by formula on the closed disc of radius √3 about a four-colour vertex whose ring carries no (Q) arc
  registered: 2026-09-28
  status: open

hunch: saturation-pins-the-four-colour-vertex
  claim: in an honestly saturated valid fragment every edge at a vertex of at least four colours is pinned
  basis: derived
  falsifier: an honestly saturated valid fragment by formula with a four-colour vertex one of whose edges has a side colour with no tile at distance exactly 1
  registered: 2026-09-29
  status: open

hunch: curved-tangent-inhabited-above-six
  claim: at some k ≥ 7 an honest saturated REG-J′ colouring has a curved tangent-type interface arc of finite radius (0.4)
  basis: prior
  falsifier: a derivation that at every k such colourings have only segments and split unit arcs
  registered: 2026-10-03
  status: open

hunch: semipar3-reads-a-height
  claim: SEMI-PAR3's exclusion, if it holds, reads the winding of G71's height on the ring of y (0.35)
  basis: analogy
  falsifier: SEMI-PAR3 decided, either way, by an argument that reads no invariant of y's ring colouring
  registered: 2026-10-03
  status: open

hunch: skeleton-carries-a-syntheme
  claim: a four-colour vertex and the four-colour hubs it places share one perfect matching of the six colours
  basis: derived
  falsifier: a held or by-formula fragment in which a four-colour vertex and a four-colour vertex it places have absent pairs that meet
  registered: 2026-10-03
  status: open

hunch: a-third-need-new-kinds
  claim: at least a third of FS-129's demand list's 24 steps need a kind of input no held result delivers (0.5)
  basis: prior
  falsifier: the pass-1 readers find a held result of an admissible kind for more than two thirds of the steps
  registered: 2026-10-03
  status: open

hunch: cover-rungs-spend-nothing
  claim: neither rung of the cover route at five has a certificate that it must spend the colour count (0.55)
  basis: analogy
  falsifier: a tight k-colouring by formula, k ≥ 7, at which every local modification of every maximal cover above it fails to be regular and locally finite
  registered: 2026-10-03
  status: open

hunch: empty-reads-non-siamese-locally
  claim: FS129-SR3-EMPTY-NS's route reads non-Siamese only among the tiles at p, at the ring's tips and at the hug tiles (0.5)
  basis: derived
  falsifier: a step of FS116-V6's route that reads the absence of a Siamese pair between two tiles neither of which has p, a tip or a hug point in its closure
  registered: 2026-10-03
  status: open

hunch: placements-conserve-the-type
  claim: in the held (Q)-ring positives the placed four-colour vertices carry rings of the placing vertex's type, except at the disk's corner (0.4)
  basis: analogy
  falsifier: a held positive in which a placed four-colour vertex's ring has a different number of (Q) arcs from the placing vertex's, away from the disk's corner
  registered: 2026-10-03
  status: open

*What the release does to the carried ones.* `cover-rungs-spend-nothing` is moot at five (no five-colouring exists; the reading's
row-140 draft: "the class of M2-REDUCE-C at five is empty") and stays open only as a statement about `k ≥ 7`.
`route-m-consumes-unbounded-maps` and `curved-tangent-inhabited-above-six` lose their consumer if card 1's first branch holds.
`the-room-is-on-q-rings` and `empty-reads-non-siamese-locally` gain a second route: the reading § 3.5's region kill reads no tiles.

*Registered today, before any derivation of them.*

hunch: the-map-needs-no-palette-bound
  claim: off the cyclic centres the release's approximant is graph-valued by the forest property alone; the palette bound enters only the local finiteness of the centres and the angular kills
  basis: read
  falsifier: a line of the manuscript's Lemmas 7.2 to 7.4 that cites Proposition 5.6
  registered: 2026-10-07
  status: confirmed (by: `plans/EXT-OAI2-reading.md` l. 480, "a clique in a forest has at most two vertices", and its § 4.2 rows 10 and 11, "uses the count? no" — the reading's word, one mind; the manuscript's lines themselves recalled, not read)

hunch: cores-exist-at-every-k
  claim: for every k, every measurable k-colouring proper at almost every unit pair has a cyclic centre in every closed disc of radius 8
  basis: derived
  falsifier: a step among the manuscript's Lemmas 7.2 to 7.6, or the Lean's forest_chart, fill_noncore_disks or no_large_positive_sequence, whose argument reads five
  registered: 2026-10-07
  status: open

hunch: act-three-needs-less-than-local-finiteness
  claim: the extraction of a point with a label cycle and continua runs when the cyclic centres are closed and totally disconnected; local finiteness is more than its argument reads (0.5)
  basis: derived
  falsifier: a step of the manuscript's Lemmas 7.6 to 7.8, Proposition 7.1 or Lemma 8.1 that reads an isolated centre — a continuum that must reach a fixed radius, or a limiting direction that needs an annulus free of centres
  registered: 2026-10-07
  status: open

hunch: critical-radius-form
  claim: the plane needs seven colours iff for some R the disc of radius R has no measurable six-colouring proper at almost every unit pair inside it; and the release's obstruction gives such an R at five
  basis: derived
  falsifier: a weak-* limit of such colourings of growing discs whose least-index rounding is not proper almost everywhere, or a step of the release's obstruction that reads the colouring outside a bounded region
  registered: 2026-10-07
  status: open

hunch: the-kills-read-pieces-not-arcs
  claim: FS116-Y4-EMPTY's argument reads connected same-colour pieces of diameter at most 1, unit circles and the 60° twist, all of which the release's objects supply at six; FS114-CV-EXISTS reads a map it can bend, which they do not (0.55 for the pair)
  basis: prior
  falsifier: EMPTY's uses-only line naming an arc's curvature or a finite count of tiles at the vertex; or CV-EXISTS restated with no modification of the map
  registered: 2026-10-07
  status: open

hunch: triangles-fill-in-their-own-nerve
  claim: with the approximant's target enlarged by a filled triangle wherever three classes meet cyclically, the cores left essential in a six-colouring are the cycles of length four to six, and their forced existence is an order-three cover statement of the kind `[Voronov2023]` Thm 1.3 proves for closed sets (0.35)
  basis: analogy
  falsifier: a triangle core of a measurable six-colouring whose disc averages do not extend the map over the core into the filled triangle, or a reading of Thm 1.3's proof that uses closedness beyond the band
  registered: 2026-10-07
  status: open

### 1.6 The registration the brief asks for, before I rank

- **Which stub I expect first**: a stub minted today, FS-132, ahead of FS-124 — and FS-124 second, not demoted. Reason, by bearing
  on the answer: every other stub of the regularity wall is posed *in a class* (maps; fragments; honest saturated colourings), and
  surprise 2 says the class itself is now the open choice. The question that decides the class outranks the questions inside it,
  because its answer changes how each of them is stated.
- **Directly about six-colour measurable colourings, or about one named step of their argument?** Neither as the brief words it.
  I expect FS-132's question to be: *does this project's own six-colour chain — the existence of a vertex of at least four colours,
  and the exclusions about it — run on the object the release's extraction delivers at six, with no map?* It is about a named
  object of theirs (their Proposition 7.1, at six) and named arguments of ours (FS114-CV-EXISTS, FS116-Y4-EMPTY, row 149).
- **What I expect not to pose first, and why**: the reading's nominee, [P₆]. By `the-map-needs-no-palette-bound` it is not what
  the extraction needs; it is an ingredient of [L₆]'s triangle case and of the kills, and a statement of the form "every
  six-colouring has at most two labels along a ring" can be refuted only by exhibiting a six-colouring, so as posed one of its two
  answers is the whole problem.

## Stage 1 — SAVED

## Stage 2 — SAVED

### 2.1 The milestone chosen, as a decision in four parts

- **The choice.** FS-132 is `plans/STUB-six-by-the-nerve.md`: *does this project's six-colour chain run on the object the release's
  extraction delivers at six, with no map?* It opens on claim C132-EXT (the extraction at every `k`) and then reads
  FS116-Y4-EMPTY and FS114-CV-EXISTS against it.
- **The alternative weighed.** The reading's nominee (its § 4.3, § 5.4 (ii)): "six by the nerve — [P₆] first", palettes of at
  most two labels on honest saturated six-colourings. Also weighed: opening FS-124, the (Q) ring, as ranked on 2026-10-03.
- **Why this one won.** (i) By `the-map-needs-no-palette-bound` (§ 1.5, confirmed from the reading's own table), [P₆] is not what
  the extraction needs; it is an ingredient of two later steps. (ii) [P₆] and [L₆] are statements about every six-colouring, so a
  refutation of either *is* a six-colouring: as posed, one of the two answers is the whole problem. Card 1's two answers are both
  theorems about arguments and objects this project holds today. (iii) Every stub of the regularity wall — FS-123 to FS-128,
  FS-117, FS-120 — is posed inside a class, and card 1 decides the class; its answer changes how each of them is stated, so it
  outranks them by bearing even though it is a smaller statement than any. (iv) It is the question only this project can ask: the
  release's readers have the extraction and not the chain.
- **Confidence, and the one fact that would change it.** Medium-high that this is the right first question; low that I know its
  answer (hunch: split, 0.55). What would change the choice: C132-EXT failing at six — if the extraction itself reads five, there
  is no object to ask card 1 on, and FS-124 in the map class is first again.
- **The default.** If Keryx and Kooshi say nothing, FS-132 opens on C132-EXT in the first deriver's slot after FS-133's short job
  (stage 3 says why that order).

### 2.2 The cards (the stub carries the same three; card 3 is the invention signal's card, addressed to Ephodos)

question: does-the-six-colour-chain-run-with-no-map
  evidence: `plans/EXT-OAI2-reading.md` § 4.2 rows 10–13 (the manuscript's Lemmas 7.2–7.8: "uses the count? no", "typed at five only") and § 3.3 ("nothing in §§ 5–8 distinguishes Siamese pairs"); `LEDGER.md` row 137 ("every locally finite map of the plane bounded by segments and circular arcs"), rows 148–149 ("non-Siamese … valid six-coloured fragments"); `plans/FS114-derivation.md` l. 29, FS114-CV-EXISTS "uses only: … FS112-N2-TERM (the terminal modification `M*`"
  expected: the exclusions at six need a map — arcs, tiles, a locally finite singular set — so a tight colouring must first be made one (route M: FS-126, FS-127, FS-128)
  ask: do FS114-CV-EXISTS and FS116-Y4-EMPTY read arcs and tiles, or only what the release's extraction gives a measurable six-colouring: a point, a label cycle, connected interfaces with limiting directions, and the two-colour exclusion?
  if both run on the extraction's data: the map step is replaced by one statement about cyclic centres; FS-126 and the arcs half of FS-127 lose their consumer; FS-123 and FS-124 are re-posed for measurable colourings with no Siamese clause; the next claim is card 2
  if the exclusion runs and the existence step does not: the exclusions move to measurable colourings, and "some centre is not a triangle" becomes the milestone's open statement, with card 3's form as its first candidate and row 137's bending argument as the thing it must replace
  if a named step of the exclusion reads an arc or a tile count: route M's map step stands for that step; the ranking keeps FS-124 and FS-123 in the map class; the release enters six as the transfer and as lemmas inside FS-124's cases; the named step is the stub of what a measurable form would need
  answered by: derivation — Ephodos, reading the two arguments by their `uses only:` lines against the conclusion of the manuscript's Proposition 7.1 restated at six (claim C132-EXT)
  cost: one opening and one derivation job, no search; to read: the manuscript's §§ 7–8, `plans/FS116-V6-verification.md` § 2.2, `plans/FS114-derivation.md` ll. 26–60
  hunch: split — EMPTY runs (pieces of diameter at most 1, unit circles, the 60° twist); CV-EXISTS does not (it bends a map)
  falsifier: EMPTY's route naming an arc's curvature or a finite count of tiles at the vertex; or CV-EXISTS restated with no modification of the map
  rank: 1

question: what-the-extraction-needs-of-the-centres
  evidence: `plans/EXT-OAI2-reading.md` § 4.3, the row for step 9 ("[L₆] the centres whose transition graph has a cycle are locally finite … **Not supplied.**"); `plans/EXT-OAI1-audit.md` l. 404, `fullApprox_exists_of_finite_core` from "(L : Finset ℂ) (hL : ∀ x ∈ closedBall 0 8, ¬(transitionGraph c x).IsAcyclic → x ∈ L)"; the reading's EXT-OAI2-SLACK7-L, a seven-colouring by formula whose cyclic centres accumulate at one point
  expected: the extraction needs the centres finite on compacts, so at six that must be proved on a normal form (FS-127's question without arcs)
  ask: which property of the set of cyclic centres does the extraction's argument read — finite on compacts, or only closed and totally disconnected — and does the island colouring at seven, whose centres accumulate, still yield a point with its continua?
  if closed and totally disconnected suffices: [L₆] is replaced by a statement the island colouring satisfies; FS-127's accumulation question leaves the road; the normal form is not needed for the extraction, only for the exclusions
  if isolation is read at a named step: [L₆] stands as posed, for honest saturated colourings; FS-127 is re-aimed at it without arcs; the named step says what an accumulation of centres would break
  answered by: derivation — Ephodos
  cost: one derivation job on the manuscript's Lemmas 7.6–7.8 and Proposition 7.1; the island colouring is the test object, by formula
  hunch: total disconnectedness gives a point with essential loops at every small scale; the limiting directions of the continua are where it can fail
  falsifier: a step of Lemmas 7.6–7.8, Proposition 7.1 or Lemma 8.1 that reads an isolated centre — a continuum that must reach a fixed radius, or a direction that needs an annulus free of centres
  rank: 2

question: where-does-five-enter
  evidence: side A, `plans/FS131-close-inventory.md` l. 8333: "the cover's order — at six colours a point may need three positive coordinates, a 2-complex, where the disc is no obstruction"; side B, `plans/EXT-OAI2-reading.md` ll. 682–685: "the cover of order two against order three is not where five enters … Five enters in the two statements that would make one exist"
  expected: one of the two readings is wrong, and the record has already said which
  ask: with a triangle filled in the target wherever three classes meet cyclically, which centres of a measurable six-colouring stay essential, and is their forced existence a covering statement of order three with the unit distance in it?
  if the essential centres are the cycles of length four to six and a metric cover statement forces one: "some centre is not a triangle" is that statement — the shape of `[Voronov2023]` Thm 1.3 with holes, route R's (FS-122) — and needs no count of tiles, so G86's blindness does not reach it
  if a triangle centre is not filled by its own disc averages, or no order-three statement survives the holes: the target stays the graph, the existence step stays row 137's in the map class, and the premise both readings share is earned
  answered by: derivation — Ephodos, by `ephodos-invention` once recognition's homes are killed; the collision is § 1.4's invention signal, stated there in both sides' words
  cost: one derivation job; `[Voronov2023]` Thm 1.3's proof re-read for where closedness enters (row 132: once, "as compactness giving a band")
  hunch: the triangle fills and the statement is route R's in the release's vocabulary (0.35)
  falsifier: a triangle centre whose disc averages do not extend the map over it into the filled triangle; or a reading of Thm 1.3's proof that uses closedness beyond the band
  rank: 3

### 2.3 Expectations scored at this stage

| | claim (short) | p | outcome |
|---|---|---|---|
| E2 | FS-132's question is about one named step of the release's argument run at six | 0.60 | **half met** — it names an object of theirs (Proposition 7.1 at six) and asks it of two arguments of ours; not a step of theirs to be re-proved |
| E3 | the named step is not [P₆] | 0.55 | **met** — § 2.1 (i), (ii) |
| E4 | the frame is "order three, Voronov's band" with no palette bound | 0.50 | **half met** — it is card 3, the invention signal's card, at rank 3 and hunch 0.35, not the frame of card 1; the half that held: no palette bound in the extraction |

**Invention signal:** one, § 1.4 — "where five is used": the audit's "the cover's order … a 2-complex, where the disc is no
obstruction" (`plans/FS131-close-inventory.md` l. 8333) against the reading's "the cover of order two against order three is not
where five enters" (`plans/EXT-OAI2-reading.md` ll. 682–685); the premise both share is that the approximant's target is the
complete graph on the labels, fixed before the colouring. Card 3 puts it to Ephodos. Read for it: both records' stages named in
§ 1.3, inventory items 607–619.

## Stage 2 — SAVED

## Stage 3 — SAVED

### 3.1 FS-133, and which milestone takes the deriver's first slot — a decision in four parts

- **The choice.** FS-133 (`plans/STUB-one-class-transfer.md`) takes the deriver's first slot, as a short job on four posed claims
  (C133-DENS, the unchecked step, first); FS-132 opens in the next slot, or beside it if two deriver slots are free.
- **The alternative weighed.** FS-132 first, because it alone bears on six against seven and FS-133 by its own stub bears none
  (`CLAUDE.md` § Counter-priors rule 1: rank by bearing, never by difficulty).
- **Why FS-133 first anyway.** Rule 1 ranks *routes to the answer*; FS-133 is not a route and is not ranked as one (§ 5 puts it
  outside the ranked table, as an open milestone, the way FS-131 is). What orders the slot is that its value decays with the
  calendar and FS-132's does not: the release is public, the question is three printed questions' answer, the people who posed it
  will run one class through the transfer, and this project holds every other link at two minds (row 129). Days matter for it;
  for FS-132 the holding nobody else has — the map-class chain — does not decay in a week.
- **Confidence, and the fact that would change it.** High. It would change if C133-DENS or C133-ONE stalls past one job: then
  FS-133 yields the slot and waits; it must not hold FS-132 back.
- **The default.** FS-133 first; FS-132 opens at FS-133's first hand-back at the latest.

### 3.2 The card (the stub carries it, with both forms and four posed claims)

*In this record the card is ranked 4, behind FS-132's three: ranks here order questions by bearing on the answer, and this one bears none. In its own stub it is rank 1. The slot order is § 3.1's, a separate decision. **A slip of mine, disclosed:** the first commit of this stage (`d0facc6d`) was made with this card at rank 1 and the gate failing on the duplicate rank — I chained the commit after the gate with `;`, against standing rule 9. This commit repairs it.*

question: does-the-rigidity-run-for-one-class
  evidence: `plans/EXT-OAI2-reading.md` ll. 352–364 (§ 2.6: "The step to check before it is claimed: the passage from a stationary field of mean `α₁` to a set of *upper density* `α₁`"); `LEDGER.md` row 129 ("At ℚ(√635087), given MR there: `α₁(ℝ²) = m₁(ℝ²)`"); `CLOSED-QUESTIONS.md` l. 655 ("answered at [hand], given MR")
  expected: the equality of the finitary and the measurable densities needs measure rigidity at a number field (row 120's outside input), so it stays conditional
  ask: does the release's rigidity theorem, run on an invariant random independent set of the algebraic plane in place of a colouring, give a measurable set avoiding distance 1 whose upper density is at least the finitary independence ratio?
  if it does: `α₁(ℝ²) = m₁(ℝ²)` and `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²)` hold with no hypothesis; row 129's plane clause loses "given MR"; three questions posed in print are answered at [hand] over an outside theorem; a short note is owed its Lean form and then a write-up
  if a step fails: the named step is where one class differs from a partition, row 129 keeps "given MR", and the finding is a limit of the release's transfer that its manuscript does not state
  answered by: derivation — Ephodos
  cost: one short derivation job, no search: the manuscript's § 4 (316 lines) re-read with one class, FS103-B-AMEN's Følner half restated at the algebraic plane, the density step, and the literature's definitions of `f(n)` and `m₁` read at their pages
  hunch: it runs; the density step closes by reverse Fatou on disc averages; the care is in which infimum the literature's `f(n)/n` names (0.85)
  falsifier: a step among the transfer's F3–F9 that uses the sum of the classes' fields being 1, or more than one class; or `[DuczVarga2026]`'s `f(n)` defined over graphs the argument's infimum does not cover
  rank: 4

### 3.3 Other consequences a short job could close this week (the stub's § Siblings carries each with its literature and risk)

1. The bridge without Tarski — `χ(ℝ²) = χ(ℚ̄²) = sup_F χ(F²)` with no `RealAlgebraicDescent` — with the import, de Bruijn's lane.
2. The axiom question — the Shelah–Soifer question for the plane is the null-set step `χ_m⁰ = χ_m` — a short derivation, third.
3. Falconer's `χ_m(ℝ²) ≥ 6`, `χ_B(ℝ²) ≥ 6` — a filing line.  4. `lim µ₅(ε) < 1` — a filing line.
5. The obstruction on a disc of explicit radius — inside FS-132 (C132-RADIUS).

### 3.4 Expectations scored at this stage

| | claim (short) | p | outcome |
|---|---|---|---|
| E6 | FS-133 takes the deriver's first slot | 0.75 | **met** — § 3.1 |
| E11 | the unchecked step closes by an ergodic average; the risk is in which density the literature names | 0.65 | **open until derived**; my route for the step is reverse Fatou on disc averages (C133-DENS), and the reading of row 129 moved the risk I named: the infimum is the favourable one |

hunch: one-class-needs-no-redrawing
  claim: the one-class argument bounds the infimum of α(G)/|G| over finite graphs in the algebraic plane, which is at least the infimum over all finite unit-distance graphs, so α₁(ℝ²) = m₁(ℝ²) and Johnson's Question 3 both follow with no Tarski
  basis: derived
  falsifier: a step of C133-INV or C133-ONE that needs a finite unit-distance graph of the real plane redrawn with algebraic coordinates
  registered: 2026-10-07
  status: open

**Invention signal:** none seen at this stage; read for it: `LEDGER.md` row 129, `CLOSED-QUESTIONS.md` ll. 655–668, the reading
§ 2.6. (A correction owed, not a collision: row 129's and G80's "finite-graph killing test for MR" cannot fire if C133-ONE holds.)

## Stage 3 — SAVED

## Stage 4 — SAVED

### 4.1 The aim's six links (`CLAUDE.md` § The aim), each in one line

| link | verdict | reason |
|---|---|---|
| 1. "Given MR, the plane is the measurable problem" | **unconditional now, for the plane; the field half keeps "given MR"** | `χ(ℝ²) = χ_m⁰(ℝ²)` at every `k` is `[OAIMath2026]` Thm 1.3 (the forward half kernel-checked in its library); `χ(F²) = χ(ℝ²)` at ℚ(√635087) and de Grey's field still rests on MR(F), which their rigidity "does not give … for any number field" (the reading § 2.2) |
| 2. "Upper bounds need no MR" | **unchanged** | it never needed MR; note its direction (`χ ≤ χ_m⁰`) is the one *not* in the release's Lean (the audit l. 381) — it stands at [hand] here and in their manuscript |
| 3. "Density cannot give six" | **unchanged in content; unconditional for the plane if FS-133 lands** | six was given by how classes fit — labels on a ring, the graph of adjacent classes, the nerve (the reading § 3.4) — never by one class's size |
| 4. "Regular colourings need seven … maps need six" | **the "maps need six" half is answered by citation; the "seven" half is unchanged** | every measurable colouring proper at almost every unit pair needs six (Thm 1.4), Jordan boundaries included; this project's arc-map proof stands as a second route |
| 5. "given MR, … one question: can vanishing holes save a colour?" | **unconditional now; answered at five; its "or `= 5`" clause is closed as a direction** | row 131 with Thm 1.3: `χ(ℝ²) = 7` iff `lim µ₆(ε) < 1`; `lim µ₅(ε) < 1` by Thm 1.4 |
| 6. "Its tools are Voronov's circle topology made robust, and the density topology" | **re-aimed: a third tool, and a question about which class the exclusions need** | the release's nerve reaches a point with interface continua with no regularity; whether the six-colour exclusions need more is FS-132's card 1 |

### 4.2 Every ranked stub of `plans/FRONTIER-STUBS.md`, each in one line (verdicts: answered / unconditional now / re-aimed / unchanged / closed as a direction)

*"Unconditional now" means: every sentence of the row that reads "`χ(ℝ²) = 7` given MR" or "`χ(ℝ²) ≥ 6` given MR" loses "given MR";
sentences about a number field's plane keep it. Old rank first.*

| old | stub | verdict | reason, in one line |
|---|---|---|---|
| 1 | FS-124 the (Q) ring | **unconditional now; re-aimed lightly** | still the bulk of the exclusions and the YES side's home; gains the release's dictionary (their diagonal states are (Q) arcs; `two_state_impossible` at `k = 6`; their four-cycle argument is the five-colour vertex's, one outsider); the class it is posed in waits on FS-132's card 1 |
| 2 | FS-123 the Siamese class | **unconditional now; re-aimed** | its first case is FS-132's existence form; the release's exclusions "read no tiles", so a measurable form has no Siamese clause; the reading § 3.5's region kill is a second route (queued for the Searcher) |
| 3 | FS-104 `χ_CP(ℝ²)` at six | **answered — YES, by citation** — exactly this form: `χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6`. **Not answered:** `χ_m⁰ = χ_m` (the null-set step), `χ_B` against `χ_m`, the ZF + DC audit — re-aimed at these as the axiom question | Thm 1.4 with row 130; its routes (0)–(e) are closed as routes; its NO side (a CP five-colouring) is closed as a direction |
| 4 | FS-128 the top colour, at five and six | **five half answered by citation; six half unconditional now** | row 154's two sides are both true (no five-colouring exists), so TOP₅ has nothing to bind; TOP₆ "given a NO … is the answer" stands, and whether the normal form is on the road at all waits on FS-132's cards 1–2 |
| 5 | FS-125 the saturated local exclusion | **unconditional now** | the class where slack-sensitive statements can hold (the reading § 4.3); the exclusions need it on either road |
| 6 | FS-122 the forced pair | **unconditional now; gains tools** | A-ALL "equivalent to seven" with no MR; the release's Lemma 5.5 is a separation constant "uniform in the colouring" (the reading § 3.3), the kind B-RR asks; card 3's first branch would land here |
| 7 | FS-120 the pinch, and the cover route at five | **five half answered by citation (closed as a need); six half unchanged** | the cover route's rungs at five were to give `χ(ℝ²) ≥ 6`; it is given |
| 8 | FS-127 lateral extent | **re-aimed** | at local finiteness of *cyclic centres* of honest saturated colourings, with no arcs ([L₆]); and behind FS-132's card 2, which asks whether even that is needed; its bearing through REG-J′₅ is moot |
| 9 | FS-126 curved pencils | **re-aimed downward** | not consumed by the extraction (the reading § 4.3: "the curved-pencil question (FS-126) [is] not consumed by Act 3"); on the road only under card 1's third branch |
| 10 | FS-117 route T, the count | **unconditional now** | the existence step in the map class, non-Siamese; card 3 names what would replace it for measurable colourings |
| 11 | FS-109 the hole dial | **unconditional now; gains a control** | `1 − µ₅(ε)` is now known to stay bounded below: a positive control for the dial before `µ₆` is read |
| 12 | FS-108 print residuals of the regular half | **answered by citation as a need** | FS106-AE-MAP6's role ("every route at five rests on AE-MAP6") is discharged: no five-colouring of any kind exists; Townsend's (c) stays a note on a printed proof |
| 13 | FS-44 the fifth colour | **closed as a direction** | its object, a CP five-colouring of the plane, does not exist (Thm 1.4 with row 130) |
| 14 | FS-80 window-frequency certificate | **its five target answered; unchanged otherwise** | re-aimed on 2026-09-27 at "averaged certificates at five colours on the real plane"; six is held; a certificate for seven is unposed |
| 15 | FS-113 MR in full, in Lean | **re-aimed downward** | no longer "required to publish … the answer seven through the measurable route": the plane's equality is the release's, importable; MR(F) is needed for the field rows only |
| 16 | FS-101 the main clause through five in the kernel | **unchanged** (field rows, given MR); its collapse slot is discharged for the plane by the import |
| 17 | FS-62 six is not a value | **re-aimed** | W now reads `χ(ℝ²) ≠ 6` ⟺ `χ(ℝ²) = 7`; some real number field's plane needs six (the transfer reads the algebraic plane only), so S is false unless the plane is seven |
| 18, 19 | FS-130 the bicycle's windings; FS-115 the stuck ray | **unchanged** | local structure in the map class; no sentence of theirs moved |
| 20, 22, 23, 24 | FS-67, FS-96, FS-64, FS-63 (product locality and the window cluster) | **unchanged**, given MR | field-level; FS-96's outcome "a CP five-colouring of the plane" is closed with FS-44 |
| 21 | FS-59 ℚ(√167): six colours | **re-aimed** | the conjunct `χ_CP(ℝ²) ≥ 6` holds, so given MR six there is `PL_∃(23, 43)` alone (row 125); its bearing on the answer ("gives `χ(ℝ²) ≥ 6`") is spent |
| 25 | FS-49 one gadget for six | **closed as a need** | `χ(ℝ²) ≥ 6` with no MR is held; a finite six-chromatic unit-distance graph exists by de Bruijn–Erdős and none is explicit; an explicit one is the genre Kooshi ruled out as a route |
| 26 | FS-102 the fallback write-up | **re-aimed — Kooshi's call** | its proposed lead (the collapse, rows 128–130) is in print as the release's theorem for the plane, dated three days before FS-103; rows 120–123 are still this project's |
| 33, 34, 35 | FS-78, FS-42, FS-43 (supply for FS-49) | **unchanged; consumer closed** | each bore "none on the answer beyond FS-49's" |
| 37 | FS-39 the bridge to the plane | **re-aimed** | a second discharge of `RealAlgebraicDescent` for the chromatic-number consumers, through the release's transfer (the reading § 5.3); the drawing lemma still needs it |
| 27–32, 36, 38–74 | FS-69, 57, 100, 65, 17, 55, 45, 75, 90, 98, 76, 95, 87, 92, 68, 47, 60, 46, 48, 72, 77, 88, 93, 94, 99, 41, 51, 52, 20, 2, 13, 12, 19, 37, 27, 23, 22, 30, 35, 8, 29, 9, 10, 5 | **unchanged** | each row already reads "none on the answer": residue planes, field planes given MR, four-colour rigidity, kernel ports, bookkeeping; no sentence of theirs names five as open except through FS-104 or FS-44 (sampled: ranks 4–51 at their cell prefixes, 52–74 by title and bearing — § 1.3) |

### 4.3 Banners, drafted for Keryx to file (one per answered or re-aimed stub; each goes at the head of the stub file)

- **`plans/STUB-cp-plane-six.md` (FS-104):** "Answered YES by citation, 2026-10-07: `χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6` (`[OAIMath2026]` Thm 1.4 with row 130). Routes (0)–(e) are closed as routes to that question. Re-aimed (FS132-P1): the stub now carries the null-set step `χ_m⁰(ℝ²) = χ_m(ℝ²)` — with the transfer, the Shelah–Soifer axiom question for the plane — `χ_B` against `χ_m`, and the ZF + DC audit. It bears on Falconer's number and on the axioms, not on `χ(ℝ²)`."
- **`plans/STUB-top-colour.md` (FS-128):** "2026-10-07: the five-colour half is answered by citation (no measurable five-colouring exists, `[OAIMath2026]` Thm 1.4; row 154's two sides are both true). TOP₆ stands, with no 'given MR'. Whether a saturated normal form is on the road at all waits on FS-132's cards 1 and 2."
- **`plans/STUB-pinch-at-junction.md` (FS-120):** "2026-10-07: the cover route at five is closed as a need — `χ(ℝ²) ≥ 6` is held by citation. The pinch question at six stands."
- **`plans/STUB-lateral-extent.md` (FS-127):** "Re-aimed 2026-10-07 (FS132-P1): at local finiteness of the *cyclic centres* of an honest saturated colouring (the reading's [L₆]) — no arcs, no integer radii — the statement `[OAIMath2026]`'s extraction consumes; and behind FS-132's card 2, which asks whether the extraction needs even that."
- **`plans/STUB-curved-pencils.md` (FS-126):** "Demoted 2026-10-07 (FS132-P1): `[OAIMath2026]`'s extraction reads no arcs, so this question is on the road to seven only if FS-132's card 1 finds a step of the exclusions that reads one."
- **`plans/STUB-regular-half-residuals.md` (FS-108):** "2026-10-07: closed as a need — FS106-AE-MAP6's role is discharged by `[OAIMath2026]` Thm 1.4 (no a.e.-proper five-colouring of any kind). Townsend's simplification (c) remains a note on a printed proof."
- **`plans/STUB-fifth-colour-structure.md` (FS-44):** "Closed as a direction, 2026-10-07: a CP five-colouring of the plane does not exist (`[OAIMath2026]` Thm 1.4 with row 130)."
- **`plans/STUB-distance-two-gadget.md` (FS-49):** "Closed as a need, 2026-10-07: `χ(ℝ²) ≥ 6` holds with no MR (`[OAIMath2026]`); a finite six-chromatic unit-distance graph exists and none is explicit. An explicit one is not pursued (Kooshi: 'search for a finite graph is out')."
- **`plans/STUB-mr-in-lean.md` (FS-113):** "Demoted 2026-10-07: the plane's equality `χ(ℝ²) = χ_m⁰(ℝ²)` is `[OAIMath2026]`'s and enters by import; MR(F) in Lean is needed for the field rows (120–129) only."
- **`plans/STUB-qfree-ring.md` (FS-123):** "2026-10-07 (FS132-P1): 'given MR' leaves this stub's bearing. Its first case is FS-132's existence form, asked for measurable colourings, where there is no Siamese clause; a second route to its NO at radius 2 is the reading § 3.5's region kill (a placement, queued for the Searcher)."
- **`plans/STUB-q-ring.md` (FS-124):** "2026-10-07 (FS132-P1): 'given MR' leaves this stub's bearing. From `[OAIMath2026]`: a palette that is a diagonal of the vertex's own labels is a (Q) arc in measure; its `two_state_impossible`, stated for every `k`, at six excludes a ring alternating between the two diagonals (FS-132's C132-DIAG, posed); its four-cycle argument (one outside label) is the template for the five-colour vertex. The class this stub is posed in waits on FS-132's card 1."
- **`plans/STUB-plane-bridge.md` (FS-39):** "Re-aimed 2026-10-07: `[OAIMath2026]`'s transfer reads a colouring only on the algebraic plane, so `χ(ℝ²) = χ(ℚ̄²) = sup_F χ(F²)` follows with no Tarski; what is left of this stub is the drawing lemma, and stating which kernel consumers of `RealAlgebraicDescent` the import discharges."
- **`plans/STUB-four-colours-167.md` (FS-59):** "2026-10-07: the conjunct `χ_CP(ℝ²) ≥ 6` holds by citation; given MR, six at ℚ(√167) is `PL_∃(23, 43)` alone (row 125)."
- **`plans/STUB-six-is-not-a-value.md` (FS-62):** "2026-10-07: with `χ(ℝ²) ∈ {6, 7}`, W reads `χ(ℝ²) = 7`, and some real number field's plane needs at least six."

### 4.4 The paused backlog (FS-131): which waves resume, in one table

*From `plans/SESSION-HANDOFF-2026-10-07.md` § 4 (read whole) and `plans/SESSION-HANDOFF-2026-10-06.md` (sampled: every line naming
waves 6, 7, 9, 10). The test for each wave: does the new frontier stand on what it formalizes?*

| wave | what it formalizes | the new frontier | verdict | first job when it resumes |
|---|---|---|---|---|
| **the import** (not a wave; the new handoff's queue item 2) | the release's two theorems as declared outside theorems, with the bridges | everything: rows 33 and 130's new sentences, FS-133's statement, wave 9's `Row130Collapse` | **first, before any wave** | the implementer's job from `data/external/oai1/audit/ImportSkeleton.lean` |
| **7 — the four-colour vertex** (`Count` proved; `FourColour/Local`, `Bowtie`, the fragment object, the pinwheel) | row 137's existence step and the fragments of rows 138, 145 | FS-132's card 1 reads exactly these arguments by their `uses only:` lines, and the positives are the test objects of every exclusion | **resumes first among the waves** | FS131-I7L (`FourColour/Local`, `anchor` first) and FS131-I7FA (the fragment object); the bowtie's jobs after; the pinwheel (K7d) can wait |
| **9 — the reductions** (`Reduction/Uniform`, the bend on a fragment, the join with wave 8; named hypothesis `Row130Collapse`) | rows 131, 133, 139, 149's bend | its headline hypothesis is "the statement the release's transfer proves" (the handoff § 4) | **re-aimed, then resumes second**: restate over the import so `Row130Collapse` is discharged, not assumed; the bend leaves stand as planned | FS131-I9A after the import lands (its first act joins wave 8) |
| **6 — the saturated class** (`CoverHull`, `Parallel`, `Centre`, `Accumulation`, `Fragment`, `ReduceI`, `Owed`) | rows 140–144: contact, parallels, ladders, the normal form, route M's reduction | the normal form is needed for the exclusions on either road; the *reduction to a map* (`ReduceI`, the arcs) is what FS-132's card 1 may take off the road | **finish what is in flight; hold the new lines**: the join and the centre leaves (I6Z2) and the three gaps (E9) are in results the frontier keeps; lines X, Y, W wait for card 1's answer | FS131-I6Z2, then FS131-E9; no new line |
| **10 — the arithmetic floors** (`LevelGraph`, `UsablePlace`) | the field rows' spectral floors (row 123's side) | none on six against seven; every one of its rows keeps "given MR" | **waits**, except gate hygiene | only I10G's open gate items of the second landing, so `main` is clean; K10d waits |

**Three slots, where they bear** (a recommendation; staffing is Kooshi's): a deriver on FS-133 and then FS-132; an implementer on
the import and then wave 7; the third on wave 8's landing, then wave 9 re-aimed, then wave 6's join.

**E7 scored (0.60):** registered "7 and 6 resume; 9 re-aimed; 10 waits". The table has 7 resuming, 9 re-aimed, 10 waiting, and 6
only *half* resuming (in-flight jobs yes, new lines held). By my own clause ("wrong if my table differs in any of the four"):
**lost**, on wave 6.

**Invention signal:** none new at this stage; read for it: the handoff's § 4, the ranking's rows as sampled, the reading § 5.2–5.4.

## Stage 4 — SAVED
