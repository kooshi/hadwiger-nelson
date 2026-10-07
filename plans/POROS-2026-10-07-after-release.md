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
- `plans/EXT-OAI2-reading.md` § 2.6, the one-class sketch (ll. 352–364) — read against: the unchecked step is the passage from a stationary field to a density, closable by an ergodic average (E11) — surprised: unread; read against E11 at stage 3 with `LEDGER.md` row 129 and `CLOSED-QUESTIONS.md`
- `plans/EXT-OAI2-reading.md` stage 3, the obstruction in four acts (ll. 402–652) — read against: the palette bound is a disjointness count giving `k − 3`; the extraction needs palettes of at most two labels to produce a graph-valued map — surprised: yes; the second half is wrong: the map is graph-valued off the cyclic centres because "a clique in a forest has at most two vertices" (l. 480), with no palette bound; the palette bound enters only Theorem 6.5 and § 8
- `plans/EXT-OAI2-reading.md` stage 4, five against every `k` (ll. 654–779) — read against: at least one all-`k` statement is stronger than the summaries say — surprised: yes; § 4.1 item 4: the cover theorem "says that *no* colouring, at any `k`, has a graph-valued approximant on a large disc", so at every `k` the cyclic centres are forced to exist; no summary states it as a theorem about six and seven
- `plans/EXT-OAI2-reading.md` stage 5, the drafts and § 5.4's stub proposals (ll. 781–1102) — read against: its proposals rank [P₆] first — surprised: no; § 4.3 "The first place where nothing is held by either side is **[P₆]**", § 5.4 (ii)
- `plans/EXT-OAI1-audit.md` stage 6, the proof's shape from its Lean (ll. 325–512) — read against: `fullApprox_exists` is at `Fin 5` on a disc of radius 5, and the statements the summaries call "every `k`" are typed so — surprised: yes; `fullApprox_exists_of_finite_core` (l. 404) asks the core only on `closedBall 0 8`, so the five-colour obstruction reads a bounded region: it is a theorem about a disc, stated about the plane
- `plans/EXT-OAI1-audit.md` stages 1–5, 7–8 — read against: nothing there changes what may be cited — surprised: unread; taken from inventory items 608, 609, 614, 619, which are Keryx's accounts
- `M/introduction.tex` (324 lines) — read against: E8 — surprised: no on the mathematics, lost on E8; sampled: ll. 36–62, 118–148 and every line matching six, seven, unresolved, conjecture, question
- `M/` §§ 2–8 (4,304 lines of TeX) and `lean/OAI/Geometry/PlaneColoring` — read against: nothing; I rely on the reading and the audit — surprised: unread; "recalled, not read" for every statement of the release quoted in this record beyond `introduction.tex`
- `/home/kooshi/source/math/CONTENTS.md`, the catalogue of 372 families — read against: E9 — surprised: no; sampled by `rg` on thirty phrases of this frontier's disciplines over family headlines; families named for a route, each **unread**: 085 (endpoint Sobolev regularity of centred disc averages — the release's approximants are thresholded disc averages), 096 (the Gaussian propeller conjecture — an extremal statement about measurable partitions whose optimum is a triple junction), 015 (torus-packet equidistribution over totally real fields, "combines measure rigidity" — beside row 120), 167 (a power saving for planar unit distances), 073 (the Falconer distance conjecture)
- `plans/FRONTIER-STUBS.md`, the ranking (190 lines, 149 kB) — read against: the top twelve are the regularity wall's, most of the tail says "none on the answer", and some low row is suddenly at the frontier — surprised: yes; rank 37, FS-39 the bridge ("what is left, B2 (`RealAlgebraicDescent`, months)") has an alternative discharge in the release's transfer; sampled: header and rules whole, ranks 1–3 whole (the brief), ranks 4–51 at the first 210/420/330 characters of their stub, question and bearing cells, ranks 52–74 by title and bearing's first 110 characters; the closed list (ll. 120–190) unread
- `plans/SESSION-HANDOFF-2026-10-06.md` §§ 2–4 and `plans/SESSION-HANDOFF-2026-10-07.md` — read against: E7 — surprised: unread; read at stage 4, for the backlog table
- `plans/STUB-cp-plane-six.md`, `plans/STUB-q-ring.md`, `plans/STUB-qfree-ring.md`, `plans/STUB-forced-pair.md`, `plans/STUB-lateral-extent.md` — read against: nothing yet — surprised: unread; opened at stages 2 and 4 where a banner or a question section needs their words
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
