# STUB — FS-132: six against seven with no map — does the six-colour chain run on a measurable colouring's nerve?

*Minted 2026-10-07 by Poros (FS132-P1, `plans/POROS-2026-10-07-after-release.md`), on the day an outside proof that the plane is
not five-colourable became this project's literature (`[OAIMath2026]` family 158; Kooshi, 2026-10-07: "You may use their proof as
any other literature. Cite it, build on it, let's use it to slingshot us past anyone else working on this problem."). State: Not
started. Its number was fixed by Keryx (`plans/FS131-close-inventory.md` item 617).*

**Provisional bearings (Poros, 2026-10-07, rewritten by FS132-P2 after the first night; Ephodos's re-grokking replaces this line
at each opening):** G94, G95, G92, G91, G83, G71, G89, G86, G79, G72, G87, G82; rows 133, 134, 137, 139, 143, 148–150 — one line of
why each in § Bearing on the answer.

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
  rank: 3


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
  rank: 4

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
  rank: 5

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
  rank: 1

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
  rank: 2

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
point with a witnessed cycle of labels in every weak measurable six-colouring, (b) a witnessed cycle that is not a triangle, and
(c) the exclusion of every such cycle; `χ(ℝ²) = 6` is a weak six-colouring of discs of every radius (C132-RADIUS, posed). After
the first night (FS132-E1 to E3, each [hand], one mind): (a) holds where the cyclic centres are finite in a disc of radius above
1 and is open otherwise (the witness card); (c) holds for the four-cycle whose ring is outside-labelled and for the ring
alternating between two disjoint pairs, with no map, no Siamese clause and no normal form, and is open for mixed rings (FS-124),
the diagonal ring that does not alternate, and five- and six-cycles; (b) is stalled at the ring of a triangle centre (the ring
card), and is the one step whose open parts ask for regularity. The map step (FS-126, FS-127's arcs half, FS-128) is on no
derived step's route. Why each provisional bearing (FS132-P2's additions first):
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
