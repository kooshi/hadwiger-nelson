# STUB — FS-132: six against seven with no map — does the six-colour chain run on a measurable colouring's nerve?

*Minted 2026-10-07 by Poros (FS132-P1, `plans/POROS-2026-10-07-after-release.md`), on the day an outside proof that the plane is
not five-colourable became this project's literature (`[OAIMath2026]` family 158; Kooshi, 2026-10-07: "You may use their proof as
any other literature. Cite it, build on it, let's use it to slingshot us past anyone else working on this problem."). State: Not
started. Its number was fixed by Keryx (`plans/FS131-close-inventory.md` item 617).*

**Provisional bearings (Poros, 2026-10-07, rewritten by FS132-P3 after the second round; Ephodos's re-grokking replaces this line
at each opening):** G91, G83, G94, G95, G84, G92, G87, G79, G72, G71, G86, G21, G89, G82; rows 133–137, 139–141, 143, 148–150 — one
line of why each in § Bearing on the answer.

*2026-10-07 (EXT-OAI3 § 3.2):* `[OAIMath2026]` family 156 (Borsuk in dimension nine; Lean in the release, not audited here) is a second instance of the map-to-a-simplex method, with a rigidity statement at the threshold number of labels — every maximal support has exactly dim + 1 labels, by a mod-two degree count — of the kind [P₆] and [L₆] ask for. Its first step enlarges a cover to an open one, so it applies with slack only. Read its `extension.tex`, `topology.tex` and `six-labels.tex` at the opening.

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

*Fates of the three cards below (Poros, FS132-P2, 2026-10-07; `plans/POROS-2026-10-07-fs132-night.md` Stage 1). Card 1:
answered between its second and third branches — the exclusion's statement is derived for weak measurable colourings with no map
and no Siamese clause (C132-M-ORBIT, C132-M-EXCL; [hand], one mind, kernel pending) although its listed route stalls at one step
(V6-HUBS, which reads a tile); the existence route does not run (C132-RUN-CV stalls at FS112-N3-DENSE3, and its other three
inputs are not needed). Card 2: answered "neither as posed" — the extraction reads zero length of the centres and isolation of the
one essential centre; re-posed below as the witness card. Card 3: its first branch has an empty answer (every loop bounds in the
filled target, C132-NOESS); what it was after is the index of the three outside labels on a triangle centre's ring (C132-INDEX),
and the forcing statement C132-LONG stalls there; re-posed below as the ring card. The cards are kept as asked, at ranks 1, 2
and 3 this morning; their rank lines now read 3, 4 and 5 behind the two cards re-posed below.*

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
  rank: 4


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
  rank: 5

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
  rank: 6

### Existence form

*Is there an object?* **Is there a measurable six-colouring of an open set containing the closed unit disc about a point `p`,
proper at almost every unit pair inside it, in which `p` carries four labels in a cycle, each consecutive pair with a compact set
through `p` and another point that excludes both labels' supports from its straddle set, and almost every palette on `p`'s ring
holds one of the two labels outside the cycle?** (Worded 2026-10-07 by FS132-P2 on the object the arguments read: the extraction
returns some centre, not a prescribed one, and the exclusion reads the four sets, not the centre's isolation or its transition
graph. **Answered NO** by C132-M-EXCL, [hand], one mind, kernel pending.) This is the measurable form of the ring with no (Q) arc. In the
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

## The question, re-posed after the first night (Poros, 2026-10-07, FS132-P2)

*What moved (`plans/POROS-2026-10-07-fs132-night.md` Stage 1, findings A–E). Three derivers' records, read against each other:
(A) every statement derived at a centre tonight reads **a point, a cycle of labels and one further point per edge with the
two-label exclusion** — call that a **witnessed cycle** — and none reads the centre's isolation, which only the extraction's
construction reads; (B) the regular chain's terminal contradiction, two triangle centres with disjoint triples less than 2 apart,
is in row 133 for maps and in no record for weak colourings, though C132-TRI-STRIP supplies both of its hypotheses; (C) the
existence step — some centre is not a triangle — is where regularity comes back: of the regular chain R1–R6
(`plans/FS132-E2-derivation.md` § Where the forcing statement stalls) R3 needs C132-RING-TAME, R4 more, R5 and R6 have no weak
form; (D) the method that turned "finitely many change points" from a hypothesis into a conclusion at a four-cycle centre
(C132-M-ORBIT's M8) has not been asked of C132-RING-TAME's second clause; (E) the normal form that costs nothing is honesty
(Grundy colourings, row 143), not saturation, and it has not been tested on the two slack colourings at seven.*

**The class in which C132-RING-TAME is posed (the ruling asked of this job).** Split it. *Its second clause* — no two changes of
the outside label `π/3` apart — is posed as a **conclusion**, for every weak measurable six-colouring all of whose centres are
triangles: the ring card. *Its first clause* — finitely many changes — is posed for **honest (Grundy) colourings**: not for every
weak colouring (its own entry: local slack breaks it), and not for saturated ones (row 143: saturation at six is binding the top
colour, "the answer restated" given the NO, so a theorem about saturated colourings is not yet a theorem about `χ(ℝ²)`); and only
after the witness card's third claim says whether honesty removes the planted slack. Of the second deriver's three smallest
forms, (b) and (c) are the ring card; (a) waits on that claim.

### The card

question: can-a-triangle-ring-change-at-two-points-sixty-degrees-apart
  evidence: `plans/FS132-E2-derivation.md` ll. 457–460 (R3 "their hypothesis is C132-RING-TAME — the stall"; R5, R6 "no weak form") and ll. 552–556 (the turning ring: "C132-INDEX does not exclude it"); `plans/FS132-E3-derivation.md` l. 511 ("(⋆) and M7 are label-free and carry over word for word") and ll. 289–290 (finitely many change points: "here it is a consequence"); `LEDGER.md` row 133 ("complementary-type vertices within distance 2 are tangent pairs or bowties")
  expected: the existence step needs a triangle centre's ring to be tame, as a hypothesis that only a normal form could supply
  ask: in a weak measurable six-colouring all of whose centres are triangles, can a triangle centre's ring have two essential changes of its outside label π/3 apart, or does the transfer put a fourth label or a complementary triangle at the ring point?
  if it cannot: C132-RING-TAME's second clause is a theorem with no normal form, the turning and the alternating ring leave the YES sketch, and the existence step is reduced to finitely many changes (the witness card's third claim) and the count inside the unit circle (the structural form below)
  if a colouring by formula carries such a ring with triangles only on a disc of radius above 2: it is the first six-coloured object no map can be; extend it outward by formula, ask at which radius it dies, and rank that above the (Q) ring
  if all three outside labels are forced at the ring point but no cycle is witnessed there: the stall has moved from the ring to which points carry witnesses, and the witness card takes the next slot
  answered by: derivation — Ephodos
  cost: one derivation job, no search; to read: `plans/FS132-E3-derivation.md` M0–M2 and M7, `plans/FS132-E2-derivation.md` §§ one-sided pure strips, the orbit index, the stalled step; `plans/FS107-derivation.md` for W-TAN and R-CP (row 133's map form)
  hunch: it cannot — at a change on an outside-pure arc whose two neighbours also change, the point outside the unit circle whose two ring neighbours carry the labels on either side is left the third outside label (0.45)
  falsifier: a weak colouring by formula near the closed unit disc about a triangle centre with ring a, b, c, a, b, c in which a ring point between two sectors on an outside-pure arc has only two outside labels near it
  rank: 2

question: do-witnessed-cycles-exist-with-no-hypothesis-on-the-centres
  evidence: `plans/FS132-E3-derivation.md` l. 102 ("of the sets K_j only that p ∈ K_j, K_j ≠ {p}, and the exclusion") and ll. 210–237 (M4–M6 use one point of each set); `plans/FS132-E1-derivation.md` l. 326 (at the island colouring's accumulation centre "With clauses (1)–(3) alone the straight edges do satisfy it at `v`") and ll. 334–335 (isolation is read at "a continuum that must reach a fixed radius"); `LEDGER.md` row 143 ("a measurable Grundy colouring … without raising any point's colour index")
  expected: the exclusions need the extraction's centre, so every measurable statement waits on local finiteness of the centres, or on a saturated normal form that gives it
  ask: does every weak measurable colouring have, in every disc of radius above 1 and with no hypothesis on its centres, a point with a label cycle and one further point per edge carrying the two-label exclusion — the only data tonight's exclusions read?
  if it does: the hypothesis on the centres leaves the road for every statement that reads witnesses only; the binary four-cycle's exclusion and the strips hold for every weak six-colouring; FS-127's accumulation question has no consumer on the exclusion side
  if a colouring by formula has a disc with no witnessed cycle: the widest class is too wide; every statement is posed for honest colourings, and FS-127 is re-aimed at "an essential centre of an honest colouring is isolated"
  if witnesses exist only at isolated centres, because the proof of the exclusion reads the continuum between the two points: the hypothesis stands as the first deriver left it, and its countable-closed sketch is the next claim
  answered by: derivation — Ephodos
  cost: one derivation job, no search; to read: the manuscript's proof of clause (3) (`M/interfaces.tex`, to ll. 581–590), `plans/FS132-E1-derivation.md` steps S8–S11 and § The two controls at seven, `plans/EXT-OAI2-reading.md` § 5.6 (the two slack colourings), `plans/FS121-D3-proof.md` (the Grundy construction)
  hunch: the restatement is immediate; existence without isolation stalls at the proof of clause (3) (0.5)
  falsifier: a step of C132-M-ORBIT's M0–M9 or of C132-TRI-STRIP's argument that reads a second point of one set, its connectedness or a limit of its points; or a weak colouring by formula with a disc of radius above 1 holding no witnessed cycle
  rank: 3

**Which goes first.** The ring card: it is the step at which six differs from seven (three labels outside a triangle wind; four
do not), its first claim is two lines if it holds, and each of its three answers changes the next launch. The witness card takes
the second slot as it frees; the two share no claim and neither waits on the other.

### Existence form

*Is there an object?* **Is there a weak measurable six-colouring of a closed disc of radius above 2 about a point `x`, all of whose
cyclic centres in the disc are triangles — each a point with three labels in a cycle and one witness per edge — in which the ring
of `x` is not tame: its outside label has two essential changes `π/3` apart, or infinitely many changes?** By rows 134 and 137 no
segment-and-arc map is such an object, so a colouring by formula would be the first six-coloured structure that exists only
outside the map class, and the YES side's candidates would move to it. A NO for "two changes `π/3` apart" makes C132-RING-TAME's
second clause a theorem; a NO for "infinitely many" in the honest class makes the first one. The class is not known to be
inhabited at six; at seven its analogue is empty for a different reason (four outside labels have no index), and the honeycomb's
rings are tame.

### Structural form

*About every solution, in the widest class where it makes sense.* **For every weak measurable six-colouring and every point `x`
carrying a witnessed triangle: the classes of the cyclic centres inside a circle about `x` add up to the class of the smoothed
colouring on that circle, with no tameness (C132-REL), and the ring carries an orbit index `W_x` with values 2, 3, 4, with no
tameness (C132-ORBIT). Which measurable quantity of the ring is the class on the unit circle — and so what must the centres inside
the unit disc of every triangle centre of every solution add up to?** It is `W_x` on a tame ring (3 times the outside triangle)
and on a turning ring (2 or 4 times), and it is not `W_x` on an alternating ring (`W_x = 3`, class 0;
`plans/FS132-E2-derivation.md` l. 498). The question cannot be answered without an invariant of a measurable ring that every
solution carries and that the smoothing respects; the regular proof's R3 and R4 are its answer for maps. If such a quantity
exists, the count of R5 is a statement in the first homology of the complete graph on six labels — ten types of triangle with at
least two outside labels, one of them the complementary type, which C132-COMP excludes — and what is left of the regular chain is
the bicycle (two centres of one type), for which no weak form is posed.

### The first claims a deriver takes (each stated in its plan before it is derived, then fixed in `data/fs132/claims.md`)

*For the ring card.*
- **C132-COMP (posed, not derived).** No weak measurable six-colouring of an open set containing the closed unit discs about two
  points `x ≠ y` with `|x − y| < 2` has at `x` and at `y` the data of C132-TRI-STRIP (clauses (1)–(3) with `ℓ = 3`) with disjoint
  label triples, provided one of the two crossing points of the unit circles lies, for `x` and for `y`, in a direction
  perpendicular to none of that centre's three limiting directions. *Why first*: it is the regular chain's last line (row 133's
  W-TAN in the map class, its exceptions the tangent pair and the bowtie), it needs no cone scale in the exact class, and every
  later claim ends in it. Controls: at seven no two honeycomb vertices have disjoint outside sets (four and four of seven), so
  the analogue is empty; in the class of partial colourings its quantified form is held (FS107-R-CP, row 133: two fat junctions
  of complementary types blocking toward a common unit point force holes of area bounded below — two minds), so this claim is
  that statement in the exact class with a witnessed triangle for a junction and no scale; in the map class, the held fragments' complementary pairs (rows 133, 139: "HX carries complementary
  blocking pairs whose unit points lie in its voids") must each fall under the proviso.
- **C132-PLACE (posed).** What the transfer (C132-M-ORBIT's (⋆), read at a triangle centre) and C132-TRI-STRIP force near a ring
  point `x + e(ψ)` at which the ring's outside label changes essentially, in each pattern of the germs of the outside label at
  `ψ ± π/3`: nothing when both germs are one constant label (the tame case); the third outside label on a pure side when they
  differ. State the list, with the six-sector rings `a, b, c, a, b, c` and `a, b, a, b, a, b` as its two test objects.
- **C132-TURN (posed).** In a weak measurable six-colouring of a closed disc of radius above 2 about a triangle centre `x`, every
  cyclic centre of which carries a witnessed triangle and no longer witnessed cycle, `W_x = 3` almost everywhere and no two
  essential changes of the outside label are `π/3` apart.

*For the witness card.*
- **C132-WIT (posed).** C132-M-ORBIT, C132-M-EXCL and C132-TRI-STRIP with each set `K_j` replaced by a two-point set `{p, q_j}`
  — for the strips, with the changes of side at the directions `f` with `2 f·(q_j − x) = |q_j − x|²`.
- **C132-WIT-EX (posed).** Every weak measurable `k`-colouring has, in every closed disc of radius above 1, a point with a
  witnessed simple cycle of labels, with no hypothesis on the cyclic centres. Controls: the island colouring's accumulation
  centre; the stripe colouring's unit circle.
- **C132-GRUNDY7 (posed).** For no order of the seven labels is the island colouring or the stripe colouring
  (`plans/EXT-OAI2-reading.md` § 5.6) a Grundy colouring, and the Grundy-ization of each (FS121-D3-GRUNDY's construction) has
  finitely many cyclic centres in every disc and finitely many changes on every ring.

  *Dated line (2026-10-07, from FS132-E5, `plans/FS132-E5-derivation.md` § The two controls at seven; drafted by FS132-Z1):* the stripe colouring is not a witnessed triangle with a wild ring. The unit circle about the striped circle's centre `x` passes through the vertex `v` and crosses two of the three hexagons at `v` along arcs, so those two labels have no witness at `x` at all (C132-WIT-CROSSED), with the stripes or without; the colouring stays a control for a three-label palette only.

### What each answer gives

| outcome | what it is, as a result | what it does to the road |
|---|---|---|
| C132-COMP and C132-TURN derived | on six-colourings that live on triangles alone, every ring has orbit index 3 and no two changes `π/3` apart, and no complementary pair is closer than 2 — for every weak colouring | the existence step is: finitely many changes on a ring (honest class), then the count inside the unit circle and the bicycle; two of the three ways the YES sketch spends a ring are gone |
| a turning or alternating ring by formula, triangles only | a six-coloured fragment outside every map class | the YES side's first object of its own; its radius of death, or its extension to every radius (`χ(ℝ²) = 6`), outranks the (Q) ring |
| C132-WIT-EX derived | witnessed cycles in every disc of every weak colouring | "the measurable road" is literal for the exclusions: no normal form, no hypothesis on the centres |
| C132-WIT-EX refuted by formula, C132-GRUNDY7 derived | the widest class is too wide and honesty repairs the examples | every statement is posed for honest colourings; FS-127 re-aimed; C132-RING-TAME's first clause is the next claim there |
| C132-GRUNDY7 refuted | an honest colouring at seven with accumulating centres or a wild ring | the normal form must be saturation, whose six-colour content is the top colour (row 143): route M's cost returns for the existence step |

### Registered expectations (Poros, before any derivation of these)

C132-COMP derived at the first attempt: 0.85. C132-PLACE's list with the third label forced in the differing case: 0.60.
C132-TURN: derived 0.45, stalls at "the ring point carries a witnessed cycle" 0.40, refuted by formula 0.15. C132-WIT: 0.90.
C132-WIT-EX: derived 0.30, stalls 0.50, refuted 0.20. C132-GRUNDY7: 0.60. C132-LONG for every weak colouring within two jobs:
0.07; for honest colourings: 0.15. Six against seven decided by this milestone: 0.03.

## The question, re-posed after the second round (Poros, 2026-10-07, FS132-P3)

*What moved (`plans/POROS-2026-10-07-fs132-round2.md` Stage 1, findings A–E). Two derivers' records and one search, read against
each other: (A) the two cards of the second round stalled at the two **opposite** inclusions between two graphs on the labels at a
point — the transition graph `Γ_p` (which classes meet in every small ball about `p`) and the witness graph `W_p` (which pairs a
second point keeps off one side of the unit circle about `p`) — and the witness card's own example shuts the route the ring card
named (a witnessed triangle need not lie in its point's transition graph); so C132-TURN as posed above has C132-WIT-EX's defect,
and the flagged clause (5) does not bear on it; (B) every control of two rounds stands on a margin (the hexagonal colouring at
circumradius 2/5) or on a held fragment, none on a tight colouring; the one tight seven-colouring held by formula (R7,
`plans/FS111-derivation.md`, FS111-M-R7) has no three-label point at all — six tiles meet at each of its vertices, each boundary
there a unit arc about a ring point of that vertex — so no entry of the second round is about any point of it; (C) the
exception of C132-COMP-SHARP, the residue of C132-ALT, the void of C132-PLACE and the search's survivors are one object — an
interface of a three-label point on the unit circle about one of its own ring points — which is rows 135–136's unit arc with a
four-colour vertex at its centre; (D) every statement derived in two rounds crosses from one point's unit circle to the small
balls about the points of that circle, by properness alone, and both stalls are attempts to cross the other way, which asks a
measurable class for connected pieces of a definite size; (E) read in the direction that derives, the ring card's stalled claim
may need no witness at the ring point at all (a composition of four lines of `plans/FS132-E4-derivation.md`, mine, unchecked).*

**The object, re-cut.** Not "a centre with a witnessed cycle". A **seed**: a point with data on its unit circle, however it came by
them; and what that circle forces in the balls about its ring points — what is *present* there, which is again data for the next
circle. The existence of a seed in every weak six-colouring is not asked by this card: it is the map step met again in the exact
class (FS-127, FS-128), and two rounds give no reason to think the measurable tools supply it (the record's Stage 2).

*Terms.* A weak colouring, `H_i`, `Δ(K)`, a witnessed edge and a witnessed triangle, an edge outer- or inner-blocked at a ring
point, a pure side, the outside state `s(θ)`, the chart `Z(α, d)` and the four wedges far, lens, cw, ccw at a ring point: as in
`plans/FS132-E4-derivation.md` § 1.4 and the setting of its Stage 3. A label `a` is **present** at a point `p` when `p ∈ H_a`. A
**six-sector turning seed** is an open set `U` containing the closed unit disc about a point `x`, a weak measurable six-colouring
of `U`, a witnessed triangle at `x` on three labels `T` with sets `K_0, K_1, K_2`, the other labels `N = {a, b, n}`, and an angle
`ψ` such that the palette `P_x(e(θ))` contains, for almost every `θ`, the label `a` on `(ψ − π/3, ψ)` and `(ψ + 2π/3, ψ + π)`,
`b` on `(ψ, ψ + π/3)` and `(ψ + π, ψ + 4π/3)`, and `n` on the two remaining arcs. Its ring points are `y_k = x + e(ψ + kπ/3)`.

### The card

question: what-does-a-seeds-circle-force-in-the-balls-about-its-ring-points
  evidence: `plans/FS132-E4-derivation.md` ll. 547–557 (near `y_+` "the label is `a`, and … these points are outside the unit circle about `y`"; near `y_−` "the label is `b`, outside the unit circle about `y`") against its l. 472 ("At a ring point with a pure inner side: inside the ring only `a` and `b`") and ll. 585–587 (the stall's smallest form); `plans/FS132-E5-derivation.md` ll. 546–550 (an anchored witnessed triangle at a point whose `Γ_p` is a path) and l. 411; `plans/SEARCH-2026-10-07.md` ll. 183–188 (four labels at exactly the ring points about which `x`'s interfaces are unit arcs; no two adjacent ring points three-way); `LEDGER.md` rows 135–136 ("a unit rhombus with four-colour corners"; "at most three close complementary partners")
  expected: the turning ring's fate waits on a witness at the ring point, and that witness on the bridge from a meeting of classes to its witnesses — the extraction's selection step with no isolated centre
  ask: on a six-sector turning seed, does the centre's circle data force the inner lens at a ring point between two outer-pure neighbours to carry only the centre's own labels — so that some ring point has four labels present, with no witness there?
  if it does: in step form two changes π/3 apart place a four-label point or sit on a unit arc about a ring point; C132-TURN's stall dissolves with no clause (5); the next claim is the placed point's ring, and the Searcher's queue line 11 is ranked on the same object
  if a colouring by formula carries a six-sector turning seed with six pure sides and three labels present at every ring point: the search's null is its family's alone and a seed that lives on triangles exists; extend it outward by formula and rank it above the (Q) ring
  if it stalls at a line of one chart: return the chart and the line to the asking lane; the fallback is the ring card's one-edge form, and no job is spent on a second reading of clause (5)
  answered by: derivation — Ephodos
  cost: one derivation job, no search; to read: `plans/FS132-E4-derivation.md` Stage 3 whole (the setting, (W), P1–P3, list lines L3–L6, the proof of C132-TURN-EDGE), `plans/FS132-E5-derivation.md` C132-WIT-SIDE and its argument, `plans/SEARCH-2026-10-07.md` § 1.5 and Stage 3's last two paragraphs, `LEDGER.md` rows 135–136
  hunch: it does — the open wedges that C132-TURN-EDGE's proof places near the two neighbours exclude `a` and `b` from the lens, and the transfer excludes `n` (0.65)
  falsifier: a set of positive measure in that lens whose points' unit circles miss, in length, both the `a`-wedge at `y_1` and the `b`-wedge at `y_{−1}`; or a weak colouring by formula near the closed unit disc with a six-sector turning seed, six pure sides and three labels present at every ring point
  rank: 1

### Existence form

*Is there an object?* **Is there a weak measurable six-colouring of an open set containing the closed disc of radius 2 about a
point `x`, with a witnessed triangle at `x` whose ring is a step ring having two changes of its outside label `π/3` apart?**
(Radius 2: the closed unit discs about the ring points.) *Held*: seven germs of radius about 0.25 — at `x` and its six ring
points — with four labels at three alternate ring points and `x`'s three interfaces on the unit circles about them
(SEARCH-1007-TURN4, [cert], `data/search/2026-10-07/KEEP-turning-4label-arcs.json`); in the wedge family, none with three labels
at every ring point (SEARCH-1007-TURN3, [cert]) and none of the alternating kind (SEARCH-1007-ALT, [cert]; C132-ALT, [hand]).
*Not held*: anything between the germs, or beyond 0.25 from the unit circle. An object on the disc of radius 2 would be the YES
side's first seed with one generation of growth; its exclusion at a stated radius is a local exclusion of row 137's kind, in
measure.

### Structural form

*About every solution, in the widest class where it makes sense.* **For every `k ≥ 2` and every weak measurable `k`-colouring of
an open set containing two points `x`, `y` at distance 1: which pairs (the colouring near `x`, the colouring near `y`) occur?**
For pieces that are open the answer is C132-WIT-SIDE's side rule: a label filling an open set near `x` inside the unit circle
about `y` is absent near `y` outside the unit circle about `x`, and the same with inside and outside exchanged. **Of which
invariant of a measurable germ is that rule a statement — its palette, its density on each side of the other point's unit
circle, its sections along the unit circles about the points near the other end — in the widest class where the rule still
holds; and where exactly does it stop holding?** It cannot be answered without naming what every weak colouring carries along
each of its unit pairs. Two partial answers are held and neither is joined to the other: the release's transfer (`[OAIMath2026]`
Lemma 5.2: the label at `e + v` lies in neither palette), which is averaged and hypothesis-free, and C132-WIT-SIDE, which is
pointwise and reads an open piece. The **unit arc** — an interface near `x` lying on the unit circle about `y` — is the rule's
equality case: there it says nothing, and the second order decides. This is not the existence form reworded: it asks for a law
at every unit pair of every colouring, at every `k`, and names no ring.

### The first claims a deriver takes (each stated in its plan before it is derived, then fixed in `data/fs132/claims.md`)

- **C132-LENS (posed, not derived).** On a six-sector turning seed, if at each of the ring points `y_1` and `y_{−1}` at least two
  of the sets `K_j` have a point strictly inside the unit circle about that ring point, then almost every point `z` near `y_0`
  with `|z − y_1| < 1` and `|z − y_{−1}| < 1` has its label in `T`. Consequently (i) it is not the case that at least two of the
  sets `K_j` have a point strictly outside the unit circle about `y_0`; (ii) if each of the six ring points has a pure side,
  some ring point has four labels present: `a`, `b`, `n` and a label of `T`. *The composition behind it is the asking lane's,
  unchecked*: the proof of C132-TURN-EDGE (`plans/FS132-E4-derivation.md` ll. 547–557) places `a` outside and `b` inside the unit
  circle about `y_0` near `y_1`, and `b` outside and `a` inside near `y_{−1}`, on open sets; a point near `y_0` inside the unit
  circle about `y_1` has its own unit circle passing through that `a`-set, one inside the unit circle about `y_{−1}` through that
  `b`-set; the lens is inside both; P1 with the steps `b | n` at `ψ + π/3` and `n | a` at `ψ − π/3` keeps `n` out. For (ii):
  pure sides are opposite at antipodes (that record's l. 578), so the six read O O O I I I or O I O I O I up to rotation; by (i)
  the second has no inner-pure point, and in the first the middle outer-pure point has `a`, `n`, `b` in its outer wedges (list
  line L4). *Controls a deriver should run*: the search's table (a simple straight `x` is refused at every number of labels;
  every survivor has an edge of `x` on the unit circle about a neighbour, where the hypothesis fails), a planted fault in
  the chart, and — riding with this claim, not a claim of its own — the second round's seven-label controls (`hex7-crossings`,
  `margin-witness`, `hex7-relation`) re-run at circumradius 1/2, where no margin gives a witness. *Not posed*: that the ring point is a cyclic centre; that any pair is witnessed there; anything for an outside state
  that is not a step on the six arcs; anything at a ring point one of whose neighbours has no pure outer side.
- **C132-PLACED (posed).** At the four-label ring point `y` of C132-LENS (ii): in the grammar of C132-PLACE's list, the labels
  present in each of the six wedges at `y` cut by the unit circles about `x`, `y_1` and `y_{−1}`, and which labels of `T` the
  sides at `y` allow in the lens; then, using C132-WITNESS only on wedges the list forces to be of one label, which pairs of the
  four labels are witnessed edges at `y`, whether they close a four-cycle, and — if they do — what the first night's exclusion
  (C132-M-ORBIT in C132-WIT's four-point form) says on the orbit of `y`'s ring through `x`. Each line derived or marked open.
- **C132-ARC (posed).** In the setting of C132-COMP-SHARP, with exactly one of the six sets — a set of `x`, with labels `t_0`,
  `t_1` — contained in the unit circle about the common unit point `w`, and with `y` having a pure side at `w`: both `t_0` and
  `t_1` are present at `w`, almost everywhere on opposite sides of the unit circle about `x` within `y`'s pure side, and the third
  label of `x` is absent there. (C132-CROSS's four quadrants read with the exception present: the asking lane's reading,
  unchecked. In the map class it is the property (Q) of row 135, "carrying both its side colours".) *Controls*: fragment T2, where
  three sets lie on that circle; and R7 by formula, whose statement already has every boundary "a unit arc centred at a lattice
  point that carries both its side colours" at seven labels and six-label vertices — the check that six tiles meet at each of
  its vertices and that each boundary through a vertex is centred at a ring point of it rides here, as a control.

The three share a setting and no step; C132-LENS is the one the card asks. If the job has room for one only, it is C132-LENS.

### What each answer gives

| answer | what it is | what it gives |
|---|---|---|
| C132-LENS derived | in step form, a turning ring with six pure sides has a ring point with four labels present | with C132-ALT: at a seed, two changes `π/3` apart place a four-label point or sit on a unit arc about a ring point — the second clause of C132-RING-TAME in step form with one residue; the stall at the flagged clause is gone; the measurable road enters FS-124's object with a derived first step |
| C132-LENS refuted by formula | a seed that lives on three-label points, outside the search's family | the YES side's first object that no held map is; extend it outward; the search's hand argument fails for it at a step to be named |
| C132-LENS stalls | a line of one chart will not close | the chart and the line come back to the asking lane; nothing else of the round depends on it |
| C132-PLACED: the first night's exclusion applies on an orbit | the six-sector turning seed with six pure sides does not exist | the turning ring leaves the list of ways to spend a ring, by hand, with no witness posited and no family |
| C132-PLACED: the placed point's ring carries its own labels toward `x` | a mixed ring, met from the measurable side | FS-124's first question — what a (Q) ring passes to the vertices it places — has a measurable instance with every hypothesis derived |
| C132-ARC derived | the centre of a unit arc carries both its labels, in measure | the one residue of five entries is an object with a property, not a void; rows 135–136's rhombus in the exact class, first half |
| C132-ARC refuted or void | the common unit point need carry neither label | the unit arc in measure is not row 135's (Q), and FS-124's map-class results do not transfer by this route |

### Registered expectations (Poros, before any derivation of these)

C132-LENS: derived 0.65, stalls at a line of one chart 0.25, refuted by formula 0.10. C132-PLACED: the exclusion applies on an
orbit 0.25, a mixed ring 0.55, off this table 0.20. C132-ARC: derived 0.60. A seed shown to exist in every weak six-colouring
within two derivation jobs: 0.03. Six against seven decided by this milestone: 0.03.

## The first claim a deriver takes (this morning's, kept: answered by FS132-E1 to FS132-E3)

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

Decisive on the route, and through it on the answer. With the transfer unconditional, `χ(ℝ²) = 7` is the conjunction of (a) a
**seed** in every weak measurable six-colouring — a point with data on its unit circle that an exclusion can read; (b) a seed
that is not a triangle, or a triangle seed whose growth places one; and (c) the exclusion of every such point. `χ(ℝ²) = 6` is a
weak six-colouring of discs of every radius (C132-RADIUS, posed). After two rounds (FS132-E1 to E5 and one search, each [hand] at
one mind or [cert] in its family): (c) holds for the four-cycle whose ring is outside-labelled and for the ring alternating
between two disjoint pairs, with no map, no Siamese clause and no normal form, and is open for mixed rings (FS-124), the diagonal
ring that does not alternate, and five- and six-cycles; (b) holds for the complementary pair and for the alternating ring in
step form, each up to one residue — an interface on the unit circle about a ring point — and is posed for the turning ring
(this stub's third section); (a) holds where the cyclic centres are finite in a disc and wherever three labels have a common
margin, and is open otherwise: it is the map step in the exact class, and no entry of two rounds derives circle data at a
point from what meets in its small balls. So the bearing is this: on the measurable road everything that reads a seed is being
derived, with the unit arc as its one residue, and that residue is where both answers live in the map class (rows 136, 138,
149); what produces a seed is not being derived. Why each provisional bearing (FS132-P3's additions first):
- **G91, G83, rows 135–137, 149**: the ring's change points place vertices, and with unit arcs the tight question lives at one
  four-colour vertex; the second round re-derived the placing rule in measure on the pure side, and the search found row 136's
  three-partner count as the turning ring's only survivor.
- **G84, rows 140–141**: contact is the regularity mechanism, a maximal class is carved by unit circles about its own points,
  and bands vanish on Cantor sets — why a meeting of classes hands over no connected piece, and why R7's every boundary is the
  residue.
- **G21**: every control of two rounds stood on a margin or on a held fragment. Two controls are owed, each riding with a claim
  and neither a claim of its own: the second round's controls at seven re-run on the hexagonal colouring at circumradius 1/2
  (three-label points, straight edges, and each vertex's own labels touching its unit circle — the case between a margin and a
  unit arc), with C132-LENS; and R7 (six-label points, every edge a unit arc about a ring point) as the inhabitant of C132-ARC's
  conclusion and of the structural form's equality case.
- **G94, G95**: the nerve replaces the map for what an exclusion reads; and a statement about every weak colouring that slack
  would break must either be a conclusion drawn inside a class it empties (C132-M-ORBIT's step lemma) or be posed for a normal
  form — honesty first (G89, row 143), since saturation costs the top colour.
- **G71**: the ring of a triangle centre at six is a three-colouring of the 60° rotation graph, which has a height; the index
  3 modulo 6 and the orbit index are its two forms.
- **Rows 133, 139**: route R's complementary pair is the regular chain's last line; in the exact class it needs no cone scale
  (C132-COMP, posed).
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
