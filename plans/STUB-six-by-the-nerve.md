# STUB — FS-132: six against seven with no map — does the six-colour chain run on a measurable colouring's nerve?

*Minted 2026-10-07 by Poros (FS132-P1, `plans/POROS-2026-10-07-after-release.md`), on the day an outside proof that the plane is
not five-colourable became this project's literature (`[OAIMath2026]` family 158; Kooshi, 2026-10-07: "You may use their proof as
any other literature. Cite it, build on it, let's use it to slingshot us past anyone else working on this problem."). State: Not
started. Its number was fixed by Keryx (`plans/FS131-close-inventory.md` item 617).*

**Provisional bearings (Poros, 2026-10-07; Ephodos's re-grokking replaces this line at the opening):** G82, G83, G91, G86, G92, G79,
G72, G87, G25, G84, G89, G90, G60; rows 130–134, 137–145, 148–150, 153 — one line of why each in § Bearing on the answer.

## The mission, in plain language

How many colours does the plane need so that no two points at distance exactly 1 share a colour? Since 2026-10-06 the answer is
six or seven. The release proves two things. **The transfer**: for every number of colours `k`, a colouring of the plane with no
monochromatic unit pair exists if and only if a *measurable* one exists that is proper at almost every unit pair (their Theorem
1.3; this project's `χ(ℝ²) = χ_m⁰(ℝ²)`, held here until then only given measure rigidity). **The obstruction at five**: no such
measurable five-colouring exists (their Theorem 1.4). Both are kernel-checked in the release's own library and were built and
audited on this machine (`plans/EXT-OAI1-audit.md`); the manuscript was read in full by one mind with no gap found
(`plans/EXT-OAI2-reading.md`).

So the whole problem is now, with no hypothesis: **is there a measurable six-colouring of the plane, proper at almost every unit
pair?** A NO is `χ(ℝ²) = 7`. A YES is `χ(ℝ²) = 6`.

**How the release kills five** (the reading § 3.1, four acts), in words a newcomer can hold:
1. *The ring in measure.* Around any centre `x`, look at the unit circle about `x`. In each direction, the colours that show up
   with positive weight on nearby circles form the *palette* of that direction. Points at distance 1 exclude each other's colours,
   so palettes 60° apart are disjoint. With five colours every palette has at most two labels.
2. *Cyclic centres.* Call two colours *adjacent at* `x` if, in every ball about `x`, the area where a small shift `h` changes one
   colour into the other is of order `|h|`. The centres where this adjacency graph has a cycle — three or more classes meeting
   cyclically — are the *cyclic centres*. With five colours they are locally finite.
3. *The nerve.* Average each class over small discs and threshold. Off the cyclic centres the result is a continuous map into the
   complete graph on the colours (at most two classes are large at once, because the adjacency graph there is a forest). A purely
   topological theorem — no colours in it — says no such map exists on a large disc. So some cyclic centre carries a loop that
   cannot be filled; it gives a cycle of three to five labels and, for each consecutive pair, a connected set through the centre
   (an *interface continuum*) near which both colours are excluded wherever distances to it straddle 1.
4. *The kills.* With five labels a cycle of length 3, 4 or 5 leaves 2, 1 or 0 labels outside it, and each case is contradictory
   near the centre. The triangle dies because two outside labels make the ring rigid, leaving a three-coloured open region in which
   a Moser spindle fits.

**Why this does not reach six** (the reading § 3.4, § 4.3). A triangle at six leaves *three* labels outside, and the ring is not
rigid: three classes meeting at a point is what every seven-colouring does everywhere. The reading names four statements the same
road would need at six: [P₆] palettes of at most two labels; [L₆] cyclic centres locally finite; [G₆] some centre carries a cycle
of length at least four; [A₆] every cycle of length four, five or six is killed. Two of the release's five-only statements are
false at seven (EXT-OAI2-SLACK7-L, -P: islands and stripes planted in the hexagonal colouring), so at six they can hold only for
colourings with no local freedom of that kind.

**What this project holds that the release does not.** Months of theory about exactly the six-colour case, *in the class of
maps*: a tight six-colouring whose classes are regions bounded by segments and circular arcs.
- Every such map has a vertex of at least four colours (row 137, FS114-CV-EXISTS, two minds blind to each other) — [G₆] for maps.
- Such a vertex whose unit circle carries no (Q) arc exists on no disc of radius above 1 about it, in the non-Siamese class (rows
  148–149, FS116-Y4-EMPTY two minds, FS129-SR3-QFREE-NS one) — part of [A₆] for maps.
- The cases still open are named: (Q) rings and vertices of five or six colours (FS-124), Siamese pairs (FS-123), the saturated
  class (FS-125). Positive fragments by formula exist about (Q)-ring vertices up to radius `φ²/√2 ≈ 1.8512` (row 138) and about a
  six-colour vertex below `3/2` (row 148); valid fragments on discs of every radius would give `χ(ℝ²) ≤ 6` (row 145).
- To bring a measurable colouring into that class this project had one road, route M's *map step*: saturate the colouring and
  prove its interfaces are arcs with a locally finite singular set (rows 140–144; FS-126, FS-127, FS-128, all open).

**The surprise this stub is built on** (`plans/POROS-2026-10-07-after-release.md` § 1.4). The release never made a map. Its
extraction (act 3) uses no colour count — the reading § 4.2 marks Lemmas 7.2–7.8 "uses the count? no" — and what it hands the kills
is weaker than a map: a point, a label cycle, connected interfaces with limiting directions, and the two-colour exclusion. Nobody
has asked whether this project's own six-colour arguments need more than that. If they do not, the map step is not on the road to
seven at all.

## The question (Poros, 2026-10-07)

### The card

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


**Behind it, in rank order** (cards 2 and 3 of the same record; card 3 is the record's invention signal, addressed to Ephodos):

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

### Existence form

*Is there an object?* **Is there a measurable six-colouring of a closed disc of radius above 1 about a point `p`, proper at almost
every unit pair inside the disc, in which `p` is a cyclic centre whose label cycle has length four and almost every palette on
`p`'s ring holds one of the two labels outside the cycle?** This is the measurable form of the ring with no (Q) arc. In the
non-Siamese map class no such object exists (rows 148–149). In the measurable class there is no Siamese clause to appeal to, so:
an object by formula would be a fragment FS-123 has been looking for, and would show the exclusion false outside the class it was
proved in; a proof that none exists is rows 148–149 with every class hypothesis struck, and closes FS-123's first case. The class is
inhabited (six-colourings of small discs exist by formula), so both answers are theorems about things that exist. The reading § 3.5
gives a second route to the NO at radius 2: the region the two outside labels vacate is four-coloured, and a unit-distance graph
that is not four-colourable placed inside it finishes — a placement the Searcher holds (`plans/SEARCH-QUEUE.md` l. 9).

### Structural form

*About every solution, in the widest class where it makes sense.* **For every `k ≥ 5` and every measurable `k`-colouring of a
large disc, proper at almost every unit pair — no regularity, no normal form — what must its cyclic centres carry: is a label cycle
of length at least four forced at some centre exactly when `k ≤ 6`?** At `k = 5` the release answers: every cycle is forced out, so
no colouring exists. At `k = 7` the hexagonal colouring answers: triangles only. At `k = 6` the answer is the problem's — given the
exclusions, a forced long cycle is `χ(ℝ²) = 7`, and a six-colouring carrying only triangles on discs of every radius is
`χ(ℝ²) = 6`. The question cannot be answered without an invariant that every measurable colouring carries and that tells six from
seven. Candidates on the table, none earned: the class of each essential centre in the fundamental group of the nerve, with the
relation a disc imposes among them (card 3); the count that Euler's formula gives in the map class, which is blind to Siamese pairs
(G86) and so cannot be it as it stands. That the centres exist at all, at every `k`, is the first such invariant
(hunch `cores-exist-at-every-k`): the cover theorem has no colour in it.

## The first claim a deriver takes

**C132-EXT (posed, not derived).** *The extraction at every `k`.* For every `k` and every measurable `c : ℝ² → {1, …, k}` proper
at almost every unit pair whose cyclic centres (the manuscript's Definition 6.1 with `k` labels) are finite in the closed disc of
radius 8: there are a cyclic centre `x`, a simple cycle of labels of length `ℓ ∈ {3, …, k}`, and `ℓ` compact connected sets through
`x` with limiting directions, each excluding the essential supports of both its labels from its straddle set — the manuscript's
Proposition 7.1 with `k` in place of five. In particular **C132-CORES**: for every `k`, such a colouring has a cyclic centre in
every closed disc of radius 8.

Why first: cards 1–3 are all asked on its conclusion, and the only authority for it is one sentence of one reading ("Acts 3 runs
verbatim at six", `plans/EXT-OAI2-reading.md` l. 580). Its Lean neighbours are typed `Fin 5` (`forest_chart`, `fill_noncore_disks`,
`CommonInterface`); note that the Lean's arrangement — fill every core, then contradict the cover theorem — does not transfer, and
the manuscript's — an essential loop at some core — does (the reading § 4.3, row 13). Controls: the hexagonal seven-colouring
(centres are its vertices, every cycle a triangle, the continua its edges); the reading's island colouring at seven (centres
accumulate: what does the statement say there? — card 2). State it at the weakest hypothesis on the centres its argument reads
(G92).

**Then, in order:** card 1's two readings (FS116-Y4-EMPTY first — it is the shorter argument and the existence form's NO; then
FS114-CV-EXISTS); **C132-DIAG (posed)**: in a measurable six-colouring no four-cycle centre has a ring alternating, almost
everywhere under the 60° rotation, between the two diagonals of its cycle — the reading § 4.3's instance of the release's
`two_state_impossible` at `k = 6` ("by my reading of its type (`RealState` unread)"), a first exclusion of an all-(Q) ring;
**C132-RADIUS (posed)**: `χ(ℝ²) = 7` iff some disc has no measurable six-colouring proper at almost every unit pair inside it
(weak-* compactness as in row 131, least-index rounding as in the transfer's last step), with the radius the release's own
argument gives at five.

## What each answer gives

| outcome of card 1 | what it is, as a result | what it does to the road |
|---|---|---|
| both arguments run on the extraction's data | the six-colour chain of rows 137 and 148–149 holds for measurable colourings whose cyclic centres are tame enough for C132-EXT, with no map and no Siamese clause | seven is: C132-EXT's hypothesis on the centres (card 2), then the open exclusions (FS-124's cases, FS-125) in the same vocabulary; route M's FS-126 and the arcs half of FS-127 are off the road |
| the exclusion runs, the existence step does not | rows 148–149 without a class; and a named reason row 137 needs a map | the open statement is [G₆] for measurable colourings; card 3 is its first candidate; FS-117's count stays a non-Siamese statement |
| a step of the exclusion reads an arc or a tile count | a named step, with the configuration that needs it | the map step stands; the ranking of 2026-10-03 stands under an unconditional headline; the release serves FS-124 as lemmas |

Either way the YES side is unchanged and unconditional: valid fragments on discs of every radius give `χ(ℝ²) ≤ 6` (row 145).

## Registered expectations (Poros, before any derivation)

- EMPTY's argument runs on the extraction's data: 0.60. CV-EXISTS's does: 0.20. (Hunch `the-kills-read-pieces-not-arcs`.)
- C132-EXT holds as stated at every `k`: 0.80; it holds with "closed and totally disconnected" in place of "finite": 0.50.
- C132-DIAG holds as the reading reads it: 0.70. C132-RADIUS: 0.85.
- Card 3's first branch: 0.35.
- This milestone's derivation decides six against seven outright: 0.03 — registered as an instrument to be scored (`CLAUDE.md`
  § Counter-priors, rule 2), not as a reason to aim lower.

## Failure clauses

- If C132-EXT fails at a step that reads five, the reading's § 4.2 rows 10–13 carry a defect: report it as a statement defect
  against `plans/EXT-OAI2-reading.md` and re-pose card 1 on what the extraction does give at six.
- If card 1 cannot be decided from the `uses only:` lines, the arguments are under-recorded: say which line is missing; that is a
  finding about the derivation files, and the Lean backlog's wave 7 (the four-colour vertex) is where it would be repaired.
- Not landed is a complete sentence. A milestone that ends with C132-EXT derived and card 1 answered "a named step reads an arc" is
  a result: it says the map step is necessary and why.

## Named deliverables

- `plans/FS132-derivation.md`: C132-EXT, C132-CORES, C132-DIAG, C132-RADIUS and card 1's two readings, each with its `uses only:`
  line.
- **A nerve viewer** (an explorable page, colourings by formula, no search): the thresholded disc averages of the hexagonal
  seven-colouring, the capped strip (row 138), the six-colour-vertex fragment (row 148) and the island colouring, with the scale
  and the threshold as knobs; drawn on it, the cyclic centres, each centre's label cycle, and the fibres over edge midpoints. Its
  purpose is to look at what a (Q) arc and a Siamese pair are in the release's picture before anyone derives it.
- For de Bruijn, when a claim is Derived: C132-EXT's Lean form generalizes modules of the release's cone typed `Fin 5`
  (`GraphRealization`, `HoleApproximation`, `GraphPatches`, `ContinuumLimits`); Kooshi's word is to adopt pieces as a job needs them.

## Prior art and the risk of being second

The release is public and every group on this problem can read it. The natural first move for anyone is to push its five-only
statements to six, and the reading shows where that stops: the triangle. What they do not have is the map-class chain (rows 137,
148–150) or the list of positives that say which exclusions are impossible at which radius (rows 138, 148). Card 1 is the question
only this project can ask today. Not found in print as of the reading's bibliography pass: any six-colour form of the release's
statements (`M/introduction.tex:70`: "The remaining alternatives six and seven are unresolved.").

## Bearing on the answer

Decisive on the route, and through it on the answer: with the transfer unconditional, `χ(ℝ²) = 7` is the conjunction of (a) a
structure step that turns a measurable six-colouring into something exclusions can read, (b) the existence of a centre that is not
a triangle, and (c) the exclusions. This stub decides whether (a) is the map step or a statement about cyclic centres, and in which
vocabulary (b) and (c) are owed. Why each provisional bearing:
- **G82, rows 130–131**: the answer's exact form (`χ_m⁰(ℝ²) ≥ 7` iff `lim µ₆(ε) < 1`), now with no hypothesis in front of it.
- **G83, G91, rows 137, 148–150**: the four-colour vertex and its ring — the arguments card 1 reads; the release's palette is the
  ring in measure (the reading § 3.3).
- **G86**: a tile count cannot see Siamese pairs; the release's exclusions read no tiles, so the measurable class has no Siamese
  clause.
- **G92**: the method — read each held argument at the class its argument carries.
- **G79, G72**: the example invariant (centres exist at every `k`) and the structural form.
- **G87**: card 3.
- **G25**: the kills are the previous level's forcers placed in a region the ring empties — a unit pair, a unit triangle, the
  Moser spindle; at six the next rung is a 5-chromatic graph in a four-label region.
- **G84, G89, G90, rows 140–144**: the saturated normal form — needed for the exclusions if [P₆] and [L₆] can hold only there;
  maybe not for the extraction (card 2).
- **G60, row 129**: density cannot give six; what gave it was how classes fit together.
- **Rows 132–134, 139**: the two-colour exclusion and the band (`[SokolovVoronov2025]`, `[Voronov2023]`); route R, which card 3's
  first branch would meet.
- **Rows 138, 145, 153**: the positives and the YES side's unconditional form.
