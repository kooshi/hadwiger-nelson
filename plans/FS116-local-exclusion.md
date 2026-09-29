# FS-116 — the local exclusion: the plan (job FS116-O1, the opening: §G, §PA, §IQ, the plan proper, the proposed claim list)

*Ephodos (Opus 5.5), job FS116-O1, for Keryx. Brief `data/fs116/briefs/FS116-O1-opening.md` (commit 519fe70b), with `plans/STANDING-RULES.md` as part of
it. Identity and procedure: `.claude/agents/ephodos.md` § The opening job. The stub is `plans/STUB-local-exclusion.md`, its question posed by Poros
(FS116-P1, `plans/POROS-2026-09-28-fs116-question.md`). No fences: FS-121's opening (FS121-O1) runs beside me; I write none of its files. I touch only this
record, `data/fs116/claims.md`, `data/fs116/o1/`, `tools/fs116_o1_*.py`, `data/fs116/reports/FS116-O1.md`, and new stubs numbered FS-123 to FS-125.
Grades are `CLAUDE.md` § Notation's; entries use my identity's grammar and translate at the edge (`.claude/agents/ephodos.md` § Two vocabularies).*

## Theorems this phase proved

- **FS116-O1-YESLIM** (card `the-yes-needs-no-map`) — valid fragments on discs of every radius give a measurable six-colouring of the plane proper at
  almost every unit pair (at every `k`: `χ_m⁰(ℝ²) ≤ k`), so at six `χ(ℝ²) ≤ 6` with no MR — [hand], one mind (this job), § 3.4–3.5.
- **FS116-O1-SATPIN** (card `what-does-saturation-pin`) — at a cusp-free four-colour vertex of a saturated valid fragment every edge is a split unit arc
  of kind both about a point of `ω(p)` or a tangent-type segment or arc (radius ≥ 1) whose partners sit at `p ± ν(p)` — [derived] from FS111-M-PINCH and
  FS111-M-C11 (three minds each), one mind (this job), § 4.1–4.1a.

## Would-have-searched-here log (standing rule 5)

- Would have enumerated ring types (sequences of (Q) arcs and absent-colour arcs on `ω(p)`) on a grid of cone angles to see which close up. Instead: the
  ring's type is derived from the 60° structure of `ω(p)` (§IQ.3); enumeration of maps, colourings or tactic patterns is out beyond the ban too (the stub's
  solver column, FS-114's inventory item 115).

## Fence log (standing rule 8)

No path is fenced for this job. I read no session transcript. I read FS-121's stub (`plans/STUB-map-step.md`) only through Poros's record.

## Stage 1 — SAVED: the readback, and §G

### 1.1 Readback of the brief

Checked by `data/fs116/o1/quotes.py` (verbatim, whitespace-normalised substring search; output `data/fs116/o1/quotes.out`; a one-word plant fires):
- *"My goal is to fully solve, and then verify in Lean, HN. Then we publish."* — `CLAUDE.md` § The aim. **FOUND**, as a prefix; the brief opens the
  quotation mark and never closes it (Poros found the same in FS116-P1's brief).
- The existence form — `plans/STUB-local-exclusion.md` ll. 81–82. **FOUND.** The structural form — ll. 91–93. **FOUND.**
- *"a check at the §IQ, under an hour"* — l. 73. **FOUND.** *"an hour to one round"* — l. 65, a prefix of the card's `cost:` field. **FOUND.** *"to be
  told the answer"* — l. 64. **FOUND.**
- The erratum's two quoted lines — `plans/FS114-derivation.md` **l. 239** ("each with four tactic edges (`n = 0`, charge −2)") and **l. 261** ("the strip's
  midline vertices as deficient vertices"). **FOUND at those lines.** Poros's evidence `plans/FS114-N-proof.md` **l. 299** ("midline vertices `n = 4` (four
  straight edges)") **FOUND there**; `data/fs114/fs114-y6/survey.out` reads `tactic=0` and four `seg` edges at all ten strip midline vertices (read).
- **One mismatch, a pointer (a finding about the brief):** "The definitions they use (a valid map, a fragment, a tactic edge, a (Q) arc) are
  `data/fs114/claims.md` § 0". § 0 defines the valid map, (Q), and the valid fragment on a disc (in its "Local" item), **but not the tactic edge**: that word
  occurs in the file only at § 9, l. 213. The definition is FS114-N2's, `plans/FS114-N-proof.md` l. 246 ("a **tactic edge** is an edge of the map (between
  vertices of degree ≥ 3) that supplies an (A) repeat — a whole unit arc on `ω(q)`, its inner tile `x` with `q ∈ cl x`, and a tile of the outer tile's
  colour touching `x` at `q` alone …"). The claim list quotes it from there. **A second finding about the forms, not the brief:** § 0's valid fragment is
  "six-coloured", while the structural form asks about "any number `k ≥ 4` of colours"; the claim list states a `k`-coloured fragment as its own
  definition, marked "(this list)".

**My claims, restated beside the quotations.** I open FS-116 on its existence form (C114-LOCAL-F with its uniformity written in) and its structural form (the
ring of a four-colour vertex). The deliverables are §G, §PA, §IQ with card `the-yes-needs-no-map` answered, the plan proper with the erratum draft and
card `what-does-saturation-pin` if it fits, then the proposed claim list and the report. I send card 1's answer to "main" the moment it is committed.

**Reading done before §G (in this order):** the brief; `plans/STANDING-RULES.md`; the stub in full; Poros's record in full (§§ 1–4, the hunch ledger);
`plans/FS114-derivation.md` in full (46 entries); `data/fs114/claims.md` in full; `LEDGER.md` rows 131 and 133–141 in full; `plans/FS114-N-proof.md`
ll. 240–335 (FS114-N2's notation, N2-ENDS and its controls, N2-VCAP, N2-KILL); `plans/FS114-N3-proof.md` § 3.2; `plans/FS114-C-close.md` stage 2 at
§§ 2.5–2.6 only (the rest of stage 2 not read; the derivation file carries each entry's minds); `plans/FS111-derivation.md`'s header, card 1's C-SEVEN-M,
C-SIX-M, C-REG-EQ, and M-SATC, M-SLACKFREE, M-DEADLOCK, M-PINCH, M-C11, W-NOBEND, W-NOREP, W-HULLREG-MAPS, M2-INTRAD, M2-REDUCE-A, VM2-STRIP-MID and the
four named gaps; `data/fs111/claims.md` § 0, § 3's C-SAT-T, § 6; `plans/FS111-M-regularity.md` §§ 1.5, 2.1–2.3, 3.1–3.5 (M-PINCH's proof).

### 1.2 §G — the re-grokking, from inside FS-116's object

*The object, as I read every entry against it:* a vertex `p` of at least four colours in a valid fragment (segment-and-arc, unit arcs allowed, Siamese
pairs allowed), and what lies within an explicit radius of it — first its ring `ω(p)`, the unit circle about it. Two classes: all valid fragments
(C114-LOCAL-F, `[SokolovVoronov2025]` Question 2) and honestly saturated ones (route M's honest branch, FS111-M2-REDUCE-A). Phase labels (D0, D1, D2, Y, K,
V) are the plan's (§ Stage 4 §4.4).

**Bears:**
- **G13** — its body: colour steps by confinement at a centre, and coverage "is a k-set property invisible to pair sweeps". `ω(p)` is `p`'s neighbourhood in
  the unit-distance graph, and N6-RING60 (a (Q)-free ring is covered by six 60° tiles alternating the two absent colours) is confinement of `p`'s colours
  off its ring. → **D1:** state every ring type as a coverage of `ω(p)` by colour classes, never as a list of straddling pairs.
- **G15** — pigeonhole × kill. FS114-CV-EXISTS is the class-level compulsion ("every valid map has a vertex of at least four colours"), and a local
  exclusion is the kill web; FS-114's kills are all of one shape, the straddle. → **plan, claim list:** pose the NO as a disjunction over ring types at `p`
  (the pigeonhole: which type does `p` carry?) with a kill per type. Its universality is not tested here.
- **G21** — a boundary claim needs its plant at the boundary; a held positive measures its own geometry. The strip's `φ²/√2` is measured about vertices
  whose edges are unsaturated (FS111-VM2-STRIP-MID), so **it is no lower bound for the saturated class**. → **every derivation job:** headline the class
  (non-Siamese, simple, saturated) and the reading radius; controls are the strip at `φ²/√2`, the disk at `φ`, the bowtie at `3√3/5`, and R7 at seven; exact
  checkers with a planted fault. **D0:** the saturated class's own dial is unknown, and the claim list says so.
- **G60** — no argument one colour class at a time gives six (row 129). → **failure clauses:** carried from the stub; a kill reads several colours' tiles.
- **G71** — the height of a three-colouring, and its body's last sentences: the index of a density trace "is this height on a curve", and "its bound between
  complementary curves fails only at a swap, which a unit-arc interface facing a bowtie forces". `ω(p)` is such a curve with extra structure: points 60° apart
  on it are at distance 1, so the ring is a union of unit hexagons, and a colouring of it by the two absent colours alternates, `c(θ + 60°) = σ(c(θ))` — N6-RING60
  and N3-ODD are this. With three colours on the ring, BASE-V's band lemma BV-H1 is G71's height. → **D1 (§IQ.3):** read the ring type as the twist of the ring
  colouring under the 60° rotation; (Q) arcs are where `p`'s own colours break the twist.
- **G79** — hunt the invariant every solution carries once a wall stands. FS-114's six rounds excluded escapes one at a time (counterexample invariants).
  → **plan order:** D0 and D1 (what every fragment carries at `p`) before FS-114's round-7 queue of escapes (K), which runs behind them or beside them only as a
  blind check. *Falsifiable here:* the close records a result from a counterexample invariant alone if one comes.
- **G82** — a weak-* limit of near-solutions is a solution (the circle measure is Rajchman). → **§IQ.4:** card `the-yes-needs-no-map` is this step on exact
  fragments; its Do ("price each certificate at its feature's scale") is the uniformity the existence form asks: a radius independent of the complexity.
- **G83** — the tight question lives at one four-colour vertex; its reading, "what is left is four-colour vertices whose rings carry (Q) arcs", with its
  killing test "a valid fragment by formula about such a vertex beyond `φ²/√2`". *Falsifiable here*: the killing test is this milestone's first construction
  target. → **Y, D1;** registered as P2 (§4.5).
- **G84** — contact is the regularity mechanism; a (Q) arc is FS111-M-PINCH's (split) case at a four-colour centre. → **D0:** card `what-does-saturation-pin` is
  M-PINCH read at a vertex (stage 4). *Falsifiable here* only through its killing test (a saturated interface point not `C^{1,1}`), which no FS-116 phase aims at.
- **G85** — saturated interfaces have integer radii (given REG-J′). → **D0:** in the saturated class an edge at `p` is a segment or an arc of integer radius
  whose ladder of unit parallels descends to a unit arc (FS-121's card `do-ladders-end-on-q-rings` asks where; FS-121 answers it).
- **G86** — tile counts are blind to Siamese pairs; the whole NO must read points and distances. → **claim list:** every NO statement allows Siamese pairs;
  K1's pieces keep "non-Siamese, simple" in their headlines; no count is a step of the NO (route T is FS-117's).
- **G87** — the lookout. → every stage records a line on it. *Stage 1:* none seen. One scope examined and classed: "any radius exceeds `φ²/√2`" is true for
  C114-LOCAL-F (all valid fragments) and says nothing about the saturated class, whose positives are unmeasured — a scope, not two truths in collision.

**Silent:** G1, G2, G3, G4, G5, G6, G7, G8, G9, G10, G11, G12, G14, G16, G17, G18, G19, G20, G22, G23, G24, G25, G26, G27, G28, G29, G30, G31, G32, G33,
G34, G35, G36, G37, G38, G39, G40, G41, G42, G43, G44, G45, G46, G47, G48, G49, G50, G51, G52, G53, G54, G55, G56, G57, G58, G59, G61, G62, G63, G64, G65, G66,
G67, G68, G69, G70, G72, G73, G74, G75, G76, G77, G78, G80, G81. *(Twelve bear, seventy-five silent: 87. G30, G46, G47, G49, G50, G51, G67 and G72 are retired
pointers whose content the workflow carries.)*

**Ledger rows (the stub's, and 137–141, the last close's):**
- **Row 131** bears — its Rajchman step is card 2's (→ §IQ.4); its no-gos (hole counting capped at `O(ε)`, trichromatic points blind to partial colourings)
  bind any FS-116 route that passes through near-colourings (none does; FS-116 works on exact fragments).
- **Row 133** bears — W-TAN, "complementary-type vertices within distance 2 are tangent pairs or bowties", is a design rule on tight maps that reads a
  radius-2 neighbourhood: → **D1** reads it as a constraint on the four-colour vertices a ring places.
- **Row 134** bears — the base (Condition 5 maps die); every unit-arc exception of its steps is a four-colour or repeated-colour vertex. Its Lemma 4 at cusps is
  one mind: → **V** (owed second mind, before any FS-116 NO is published).
- **Row 135** bears — DENSE3, NOBOTH ("the centre of a both-kind unit arc is a vertex with at least four colours or a repeated colour"), COR3, NB4P, A4SIX,
  SIX: the local tools at `p`. → **D0** (NOBOTH places the split centre), **D1**.
- **Row 136** bears — the two positives, "every unit arc of kind both and centred at a four-colour vertex"; its not-claimed line, "the strip is tight but not
  saturated on its midline". → **Y, controls.**
- **Row 137** bears — CV-EXISTS reduces the unit-arc NO to C114-LOCAL-F; the count gives room only at degree-4 vertices with three or four tactic edges. →
  the existence form's reduction; **K**.
- **Row 138** bears — K1's pieces; "every kill is a straddle … seen at second order"; not claimed: "four-colour vertices with at most two such edges or of
  degree ≥ 5; Siamese maps". → **D2** (the straddle is the kill); **K**.
- **Row 139** bears — "seven … is the NO's hole bound made uniform in the complexity bound"; route M is the NO with the map step. → the bearing; §IQ.4 shows the
  uniform radius is necessary for seven.
- **Row 140** bears — M-PINCH, "honest saturation at five or six (GAP)", M2-INTRAD. → **D0**; and a caution the plan keeps: **the saturated-class NO serves
  route M only together with C-SAT-T-HONEST at six** (FS111-C-SAT-T-HONEST, GAP), which is FS-121's.
- **Row 141** bears — a pinch climbs a ladder of unit parallels to a junction; M4-CUT bounds the ladder. → **D0** (a tangent-type edge at `p` is a rung of such a
  ladder, and `p` is a junction where one ends).

**CLAUDE.md method sections** — § The standard of evidence bears (every exclusion's artifact is the argument plus exact checks of the fragments it names; the
reviewer's question "what must someone who trusts none of this check?" is asked at each claim); § What compute actually helps and § Searching bear only
through the ban (no enumeration) and the `ugrep` caution for any completeness grep; `RUNNING.md` is read before any tool is built (none is planned at the
opening beyond the quotation check).

**What the re-grokking changed in the plan** (§G item 3): (1) G79 and G71 put the ring's invariant (D1) and card 1's pins (D0) **ahead of** FS-114's
round-7 queue, which the stub had placed first; (2) G21 removes `φ²/√2` as the saturated class's radius bound (the claim list's not-claimed line); (3) G86
fixes every NO statement to allow Siamese pairs; (4) G83's killing test becomes the construction side's first target and one registered prediction.

## Stage 1 — SAVED

## Stage 2 — SAVED: §PA, the prior-art gate (with the recognition it searches in)

### 2.1 The recognition, on the page (`ephodos-recognition`, invoked fresh)

**The stranger** — a discrete geometer who works on Euclidean Ramsey problems and colourings of the plane: *Partition a closed disc `D` of radius `R` into
open regions, finitely many meeting any unit disc, each bounded by line segments and circular arcs (arcs of radius exactly 1 allowed), and colour the regions
with six colours so that no two points in the interiors of regions of one colour are at distance exactly 1. Let the centre `p` of `D` be a point where regions
of at least four colours meet. Is there an `R`, independent of how many regions there are, for which no such coloured partition exists?* Words the reader
would stop at, and what they were: "valid", "fragment", "Siamese" — definitions, struck into the sentence; "(Q) arc" — a determiner with a home word:
Thomassen's and `[Polymath2021]` p. 199's **"unit-radius tactic"**, an arc of the unit circle about a vertex that carries both of the arc's side colours.

**The features** (receipt in brackets):
- six colours — *determines* [at seven R7 inhabits every disc; FS111-M-R7];
- unit arcs allowed — *determines* [without them every such map dies, row 134, and every held positive uses them, row 136];
- exact distance 1, not a band — *determines* [with slack, Voronov's Thm 1.1 gives seven; the unit arcs are admissible only because the distance is exact];
- the centre a four-colour vertex — *splits*: consumed by the reduction only as "every valid map has one" (FS114-CV-EXISTS); the limit argument uses no centre
  (§IQ.4) — it *accompanies* the YES and *determines* the NO's reach;
- the complexity — *accompanies* [§IQ.4's limit uses none; the question asks for a radius free of it];
- Siamese pairs allowed — *determines the method* [counts are blind to them, G86, N2-REFINE]; its effect on the local geometry *unsorted*;
- the degree of `p` and its number of tactic edges — *unsorted* [route T's count consumes them; no local kill so far has needed the count's
  distinction, and G79 predicts the determiner is the ring, not the tactic count: D1 owes the receipt];
- the 60° structure of `ω(p)` — *determines* [points 60° apart on `ω(p)` are at distance 1; every (Q)-free kill consumes it through N3-ODD,
  N6-RING60 and N7-HUB];
- boundaries by segments and arcs rather than other curves — *unsorted* [the kills read curvature at second order, YB4-2ND; the saturated class makes
  them segments and arcs of integer radius by theorem, G85].

**The homes**, each with its name for the object, its theorem, its dictionary and its test:
- **H1 — map colourings avoiding a distance** (Woodall 1973, Townsend 1981/2005, Thomassen 1999, Sokolov–Voronov 2025). Name: a map-type (Jordan, locally
  finite) colouring of a disc, arcs of unit curvature allowed, about a vertex of degree ≥ 4 with four colours. Theorems: maps need six (Woodall; Townsend);
  nice colourings need seven (Thomassen, whose criterion (ii) excludes the unit-radius tactic); seven under Conditions 5 and 6 (S–V). Dictionary: valid map
  ↔ map-type colouring with arcs of unit curvature allowed; four-colour vertex ↔ S–V's "trichromatic vertices of degree greater than 3" with a fourth colour;
  tactic edge ↔ the unit-radius tactic. Test: the old proofs fail at exactly one step, Thomassen's rainbow step (FS114-CVB-THOM, three minds). **H1 owns
  the question (S–V pose it as Question 2) and does not decide it.**
- **H2 — colourings of the circle avoiding a rotation.** Name: a proper colouring of the circle graph `Cay(S¹, {±60°})`, a union of hexagons. Theorem: a
  2-colouring of a 6-cycle alternates; with three colours, a colouring lifts to a height (BV-H1; G71). Dictionary: `ω(p)` ↔ the circle; the two colours absent
  at `p` ↔ the two colours of each hexagon; a (Q) arc ↔ a defect where `p`'s own colours enter (N7-QOPP: opposite tiles). Tests: it predicts N3-ODD and
  N6-RING60's alternation (yes, both held); it predicts a neighbour — at seven colours three absent colours colour each hexagon with a winding, R7's
  lattice points (checkable, D1's seven-colour control). **H2 is the ring's home: it names the invariant of the structural form (§IQ.3).**
- **H3 — Delone sets and local rules** (the local theorem, `[DolbilinSchattschneider1998]`, title seen at zbMATH only, unread). Name: four-colour vertices
  as a Delone set whose local configurations propagate. N7-HUB places six four-colour vertices on a (Q)-free ring, at `y + 60°ℤ`, so (Q)-free propagation
  lays four-colour vertices on the unit triangular lattice `p + ℤ[ζ₆]·e(y)`. The one step that must change: the local theorem assumes congruent coronas,
  and ring types vary. **A candidate home for D2's propagation only; not adopted, unread.**
- **H4 — Voronov's disc theorem** (six closed sets covering a disc of radius 3 realise distance 1). Killed as a decider: on a valid map the closed classes
  realise distance 1 on boundaries, harmlessly (FS114-N114-VOR, two minds).

**The recognition sentence** (the query words): *a map-type six-colouring of a disc with unit-radius-tactic arcs, about a four-colour vertex, whose unit circle
is a proper colouring of the 60°-hexagon graph of the circle.* **No home decides it.** Stated in H1's and H2's words, the stall is the structural form:
*which arrangements of unit-radius-tactic arcs on the hexagon-coloured unit circle of a four-colour vertex can recur at the four-colour vertices that circle
places?* That is D1's question, and no theory found holds it.

### 2.2 The stub's prior-art debts

- **Sirgedas, "Graph Coloring by Simulation"** (`~/source/library/hadwiger-nelson-problem-group/threads/J_Tw1_hUxQI.txt`, 5,325 lines). Read: the lines
  the stub names (715, 4378, 4409, 4504, 4888 region) and ll. 4290–4790 in full (8–26 Mar 2020), plus a grep for disc, radius, local, quad and four colours.
  **It holds the local-to-global idea, informally, for non-Siamese tilings, by search.** Sirgedas, 2020-03-17 (l. 4661): "A biggest disc implies no
  6-color-tiling of the plane exists." His aim (2020-03-09, l. 4504): "My goal for this searcher was to prove that there's no 6-color non-siamese tiling".
  His searcher's record: "The largest valid central part has 26 tiles and has a radius ~1.678" (2020-03-08, l. 4327); a 1.82 radius disc (l. 594); after a
  week, "everything has been below radius 1.6" (2020-03-26, l. 4775); Gibbs's disk at 2.124 is the reference (l. 4524). **What this does to novelty:** "a
  largest six-colourable disc bounds the tiling" is Sirgedas's (non-Siamese, stated, not derived); FS-114's reduction to a disc *about a four-colour vertex*,
  with Siamese pairs allowed and the radius uniform in the complexity, and any derived exclusion, are not in the thread as read. Unread: ll. 1–285,
  900–2400, 2415–3400, 3570–3930, 3950–4240, 4790–5325 beyond the grep hits.
- **The HNT simulator thread `a701Kwnhp_A`** — **held**, not unheld as the stub says (`…/threads/a701Kwnhp_A.txt`, 1,245 lines). Sirgedas and Parts,
  27 Jan – 23 Feb 2022: a relaxation simulator for tilings built from dual graphs, with a same-colour "tile dist" parameter. Read: the opening post
  (ll. 20–40), ll. 255–300, the last 30 lines; a grep for proof, theorem, impossible, cannot finds only tool talk. **No statement of an exclusion.**
- **`[Thomassen1999]`'s page images** — not pursued at this opening; nothing of the plan rests on them (the OCR is held and FS-114 read his steps).

### 2.3 zbMATH, in the recognition's words (`tools/fs116_o1_zb.py`; responses `data/fs116/o1/zb/*.json`, outputs `queries.out`, `queries2.out`)

The tool's self-test (a known positive by title, Woodall 1973, must hit; a planted nonsense query must return 0) **caught two defects of the tool itself**
before any query was believed: an empty response carried no total and read as `None`, and a non-JSON reply crashed the run. Both fixed; `selftest.out`
PASS. Queries (`ab:` unless marked) and hits, every hit title read:
1. `disk & "chromatic number" & ("unit distance" | "distance one" | "distance 1")` — **0**.
2. `ti:"chromatic number" & (ti:disk | disc | strip | strips | subsets)` — 5: `[Polymath2021]` and `[AxenovichEtAl2014]` (both held), three unrelated.
3. `("map-type" | "map type" | "Jordan coloring" | "Jordan colouring") & plane` — 3, none relevant (one record's contents withheld by licence).
4. `"forbidden distance" & (tiling | tilings | tiles | tessellation)` — **0**.
5. `"unit distance" & ("circular arcs" | "arcs of unit" | "unit arcs")` — 1, Reuleaux polyhedra for Borsuk's problem (unrelated).
6. `au:"Voronov, Vsevolod"` — 22: `[Voronov2023]`, `[SokolovVoronov2025]` (zbMATH 2026), the infinitesimal layer, 2-spheres, 3-dimensional slices,
   coverings by smaller diameter — nothing on local exclusions for maps.
7. `au:"Sokolov, Georgy"` — 7: S–V and his work on lines and set families; nothing further.
8. `au:"Townsend, S"` — 7: `[Townsend1981]`, `[Townsend2005]` (both held).
9. `("largest disk" | "largest disc" | "radius of the largest") & colo*` — 2, unrelated.
10. `"chromatic number of the plane" & (tiling | tilings | tiles | map | maps)` — 7: Soifer's books, Heule, the taxicab plane, S–V; nothing new.
11. `"local theorem" & (Delone | "regular system")` — 2: `[DolbilinSchattschneider1998]` "The local theorem for tilings" (Zbl 0918.52007; H3's source,
    title only) and its proceedings volume.
12. `"unit circle" & "chromatic number" & rotation` — the API returned an error page; **not measured**.

### 2.4 The citation graph (`tools/fs116_o1_cites.py`, Semantic Scholar and OpenAlex compared by identifier; self-test on `[Voronov2023]` PASS)

- **`[SokolovVoronov2025]`** (arXiv:2502.01958, the paper that poses Question 2): Semantic Scholar lists **one** citing work, "Ramsey problems for graphs in
  Euclidean spaces and Cartesian powers" (2025; title only, unread); **OpenAlex has no record under its arXiv DOI** — so this is one database's count, not two
  (G49's mechanism: a zero or a one from a single source measures the source). `data/fs116/o1/cites.out`.
- `[Polymath2021]` (Geombinatorics, no DOI) and `[Thomassen1999]`'s citing works: walked at FS-112's and FS-114's gates (FS-112 read Polymath16 threads 6–9
  and 16 in full); not re-walked here.

### 2.5 The eight questions, answered

1. **The discipline's vocabulary** — map-type colourings, the unit-radius tactic, circle colourings avoiding a rotation (§2.1): queries 1–5, 9, 10, 12.
2. **Two disciplines** — H1 (map colourings) and H2/H3 (circle colourings; Delone sets and local rules); G30's ladder puts the wall between combinatorial
   geometry and crystallography's local rules.
3. **The question itself** — S–V Question 2 and Mixon's thread-7 question ("What is the radius of the largest disk in $\mathbb{R}^2$ that can be
   6-colored?"): no answer found in print; Sirgedas's searches (2020) are the only attack on the local form, by computer, below radius 2.2.
4. **Outside arXiv** — the Google group (both threads), Geombinatorics (`[Polymath2021]`), `[Townsend2005]`: done.
5. **The poser's citation graph** — S–V's: one citing work (§2.4).
6. **Citing works in the neighbourhood** — the one citing title is a Ramsey survey; unread, a debt (INVENTORY).
7. **Two databases** — S2 and OpenAlex disagree (one against none): recorded as one database's count.
8. **Every poser's author listing, in a reviews database** — Voronov (22), Sokolov (7), Townsend (7) read by title in zbMATH; Mixon and Sirgedas publish the
   question in forums, not in reviewed venues. Hits are reviewers' records or author summaries as zbMATH gives them; no summary was relied on.

**Novelty, at the grain of the step.** The local-to-global idea is Sirgedas's (2020, non-Siamese, informal); FS-114's four-colour centring with Siamese pairs
and uniformity is not found; card 2's composition (§IQ.4) is row 131's Rajchman step, in print for one class (`[Bukh2008]` Lemma 12; `[CohenMani2025]`),
run on exact fragments — *partly* known; the ring's 60° twist as an invariant, and any explicit radius, not found.

**G87 lookout, stage 2:** none seen.

## Stage 2 — SAVED

## Stage 3 — SAVED: §IQ, the invariant question (G72), with card `the-yes-needs-no-map` answered

### 3.1 The existence form (Poros's card, `plans/STUB-local-exclusion.md` § Existence form, verbatim)

> **Is there a radius `R` — one `R` for every complexity, Siamese pairs allowed — such that no valid fragment exists on the closed disc of radius `R`
> about a vertex of at least four colours?**

### 3.2 The structural form (the same stub, § Structural form, verbatim)

> **In every valid fragment with any number `k ≥ 4` of colours, what does the unit circle about each vertex of at least four colours carry — its (Q)
> arcs, its change points, and the vertices of at least four colours it places at distance 1 — and which of these ring types can recur at every such
> vertex a ring places?**

It is not the existence form reworded: it asks for a rule every fragment obeys at every four-colour vertex, at every `k`, with R7's lattice points
(six colours each, `k = 7`) as its inhabitant, and the radius is to be read from the rule. One finding for the claim list: § 0's valid fragment is
six-coloured, so the `k`-coloured fragment the form quantifies over is defined there "(this list)".

### 3.3 The invariant it forces

**Named, from H2 (§2.1), not decided by any home:** the **ring type** of `p` — the colouring of `ω(p)` read as a proper colouring of the circle graph
`Cay(S¹, {±60°})`, whose components are unit hexagons. On any arc of `ω(p)` carried, with its 60° translate, by tiles of the colours absent at `p`, the
colouring is **twisted**: with `k = 6` two colours are absent, and on each hexagon they alternate, `c(θ + 60°) = σ(c(θ))`, `σ` their swap — which is
N3-ODD (an odd number of change points in every half-open 60° window) and N6-RING60 (change points exactly at `y + 60°ℤ` on a (Q)-free ring). The **defects**
of the twist are where `p`'s own colours reach the ring: its (Q) arcs (each joining opposite tiles of `p`, N7-QOPP), arcs of `Γ`, and the tips at change
points (N7-HUB). The type is the cyclic word of twisted arcs and defects, modulo the 60° rotation with `σ`; its **transfer rule** is what a ring of one
type forces on the four-colour vertices it places at distance 1 (N7-HUB is the rule for the defect-free type: six four-colour vertices at `y + 60°ℤ`, so
four-colour vertices lie on the unit triangular lattice `p + ℤ[ζ₆]·e(y)` until a defect intervenes, N7-CHAIN). At `k = 7` three colours are absent and
a hexagon can be coloured with a winding (BV-H1's height, G71): that is where the seventh colour's room is spent, the control the structural form names.
**The home discipline has no theorem on it: finding the transfer rule for rings with defects is the milestone** (D1).

### 3.4 Its route, and card `the-yes-needs-no-map`: the limit of fragments

**Route: derivation only.** A computation may check a derived claim — an exact check of a fragment given by formula — and never answers the structural
form; nothing enumerates rings, maps or colourings.

**Card `the-yes-needs-no-map`: TRUE, at one mind (mine), with a sharper statement than posed** — it needs neither the four-colour centre nor unit arcs,
and it holds at every `k`, which gives it a model at `k = 7`.

derivation: FS116-O1-YESLIM
  statement: for every k ≥ 1, if for every R > 0 some closed disc of radius R carries a valid k-coloured fragment (a map of an open set containing the disc,
    bounded by segments and circular arcs, k-coloured with no two interior points of one colour at distance exactly 1), then χ_m⁰(ℝ²) ≤ k; at k = 6, then
    χ(ℝ²) ≤ 6, with no MR
  uses only: that each fragment's tile boundaries are Lebesgue-null (countably many segments and arcs); that the circle measure σ on S¹ is Rajchman,
    σ̂(ξ) = J₀(|ξ|) → 0; weak-* compactness of the unit ball of L^∞; the definition of χ_m⁰ (a Lebesgue-measurable colouring whose unit pairs are
    bichromatic at (Leb ⊗ σ)-almost every pair); for the MR-free clause, χ(ℝ²) ≤ χ_m⁰(ℝ²) (row 130; `[GwynStavrianos2022]` Lemma 2, Theorem 2)
  not claimed: the converse (a measurable a.e.-proper six-colouring gives no fragment: it need not be a map); that the limit colouring is a map, or
    saturated, or regular; anything about the fragments' centres, so nothing about C114-LOCAL-F's explicitness; χ(ℝ²) ≤ 6 from fragments on discs of one
    bounded radius
  argument: § 3.5 The argument of FS116-O1-YESLIM
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7 — R7 (de Grey's Reuleaux seven-colouring, FS111-M-R7) restricted to every disc is a valid seven-coloured fragment, and the conclusion
    χ_m⁰(ℝ²) ≤ 7 holds (row 33's upper bound, measurable); at k = 6 the hypothesis is inhabited only if χ_m⁰(ℝ²) ≤ 6
  prior art: partly: row 131's weak-* step (`[Bukh2008]` Lemma 12 and `[CohenMani2025]` Lemma 2.4 for one class; its k-class form not found, FS-106's gate)
    and FS111-W-NEG (iii), its near-colouring twin; run on exact fragments here, not found in print
  handoff: de Bruijn — queued behind the measurable chain (row 131's weak-* step): the statement at every k, its not-claimed line, and the Rajchman lemma it
    rests on

### 3.5 The argument of FS116-O1-YESLIM

Let `f_n` be a valid `k`-coloured fragment on `B̄(c_n, n)`; translate so `c_n = 0`. Let `S_j^n` be the union of its open tiles of colour `j`; the
`S_j^n` are disjoint, and they cover `B(0, n)` up to the tile boundaries, a null set. **No unit pair:** `x, x + w ∈ S_j^n` with `|w| = 1` would be two
interior points of one colour at distance 1, so `1_{S_j^n}(x)·1_{S_j^n}(x + w) = 0` for all `x ∈ B(0, n − 1)`, `w ∈ S¹`. Pass to a subsequence along which
`1_{S_j^n} → g_j` weak-* in `L^∞(ℝ²)` for each `j`; then `0 ≤ g_j ≤ 1` and `Σ_j g_j = 1` a.e. (test against `φ ∈ L¹` supported in a fixed ball, inside
`B(0, n)` for large `n`). **The Rajchman step.** Fix `M` and put `h^n_j = 1_{S_j^n}·1_{B(0,M+1)}`, `h_j = g_j·1_{B(0,M+1)}`; `h^n_j ⇀ h_j` weakly in
`L²`, all supported in one ball, `‖h^n_j‖₂² ≤ |B(0, M+1)|`. Then `h^n_j ∗ σ → h_j ∗ σ` strongly in `L²`: the Fourier transforms converge pointwise and are
bounded by `|B(0,M+1)|`, so `∫_{|ξ|≤T} |ĥ^n_j − ĥ_j|²|σ̂|² → 0` by dominated convergence, while `∫_{|ξ|>T} ≤ sup_{|ξ|>T}|J₀(|ξ|)|²·4|B(0,M+1)|`, small
for large `T`. Hence for `φ ≥ 0` bounded, supported in `B(0, M)`: `∫ φ h^n_j (h^n_j ∗ σ) → ∫ φ h_j (h_j ∗ σ)` (weak against strong), and the left side is
`0` once `n > M + 1`. So `g_j(x)·(g_j ∗ σ)(x) = 0` for a.e. `x`. **Selection.** `F(x) = min{j : g_j(x) > 0}` is measurable and defined a.e. (the `g_j` sum
to 1); `F⁻¹(j) ⊆ G_j = {g_j > 0}`, and for a.e. `x ∈ G_j`, `(g_j ∗ σ)(x) = 0` with `g_j ≥ 0` forces `g_j(x + w) = 0` for σ-a.e. `w`, so
`(Leb ⊗ σ){(x, w) : F(x) = F(x + w) = j} = 0`. `F` is a measurable `k`-colouring proper at almost every unit pair: `χ_m⁰(ℝ²) ≤ k`. At `k = 6`,
`χ(ℝ²) ≤ χ_m⁰(ℝ²) ≤ 6` with no MR (row 130, link 2). ∎ *Uses:* nothing about the centre, the four-colour vertex, the unit arcs or the complexity.

### 3.6 What it does to the milestone

- **The bearing holds as the stub wrote it, now at one mind derived:** the failure of the existence form (a valid fragment about a four-colour vertex on
  every disc) is in particular fragments on every disc, so it gives `χ_m⁰(ℝ²) ≤ 6` and `χ(ℝ²) ≤ 6` with no MR. **Contrapositive:** `χ_m⁰(ℝ²) ≥ 7`
  implies that some radius admits no valid six-coloured fragment on any disc — about any centre, of any complexity. So the uniform radius is **implied
  by seven** (`χ_m⁰(ℝ²) ≥ 7`, the FS-111 convention), never an overshoot of it; what FS-116 adds is **explicitness**.
- **Hunch `local-f-overshoots` loses its sting:** C114-LOCAL-F can fail while no valid map exists only if `χ(ℝ²) ≤ 6`.
- **The YES side aims at fragments on growing discs, complexity free — not at a map.** R1's card 2's complexity half dissolves (Poros's § 2.4 said it
  would, if this card held).
- **The sharper form suggests the NO's strongest statement:** "some radius admits no valid six-coloured fragment on any disc" (DISC-F, the claim list):
  it needs no four-colour centre, and it is implied by seven. C114-LOCAL-F is DISC-F about four-colour vertices; with a local form of FS112-N3-DENSE3
  (a four-colour or repeated-colour vertex within a bounded distance of every point of a fragment's inner disc) they would be the same question — that local
  DENSE3 is a claim of its own (the claim list's LOCAL-DENSE).

### 3.7 The open instances it would decide

- C114-LOCAL-F (FS-114's GAP), hence with FS114-CV-EXISTS the unit-arc NO for every valid map: `[SokolovVoronov2025]` Question 2's unit-arc half, almost
  everywhere, for locally finite segment-and-arc maps; `[Polymath2021]` p. 199's hope; Mixon's thread-7 question's upper side for maps with unit arcs;
  Sirgedas's 2020 aim ("prove that there's no 6-color non-siamese tiling"), for every valid map, Siamese pairs included.
- FS114-K1's residues, each a ring type: rings with (Q) arcs (N7-HUBQ, NB6-QSTART), E1's residues and E2's S6, OC, the wrap.
- With FS-121's map step (and C-SAT-T-HONEST at six), `χ_m⁰(ℝ²) ≥ 7`, hence `χ(ℝ²) = 7` given MR; and in the other direction, a failure is `χ(ℝ²) ≤ 6`
  with no MR (§3.4).

**G87 lookout, stage 3:** none seen.

## Stage 3 — SAVED

## Stage 4 — SAVED: card `what-does-saturation-pin`, the erratum draft, and the plan proper

### 4.1 Card `what-does-saturation-pin` — what saturation forces on the edges at a four-colour vertex

*Saturated*, in FS-111's words (`plans/FS111-M-regularity.md` § 2.1, derived there as an equivalence): "every essential boundary point is at distance exactly
1 from the support of each colour of its essential multicolour." For a **fragment** the contacts must lie in its domain, so the class is read on an inner disc:
a valid fragment on `B̄(p, R)` is **saturated on `B̄(p, R − 1)`** when that holds at every essential boundary point of the inner disc; the restriction of an
honestly saturated map of the plane to any disc of radius `R` is such a fragment (a valid fragment is a partition, so it is honest).

**The answer: every edge at `p` is pinned — by definition — and pinned in exactly one of two ways, each of which places the edge's side colours on `ω(p)`.**
The card's falsifier ("an edge … a side colour with no tile at distance exactly 1 from its points") is empty in the class by definition; the content is *where*
the partners sit.

derivation: FS116-O1-SATPIN
  statement: let p be a vertex of at least four colours of a valid k-coloured fragment saturated on a disc about p, every tile at p with a cone of
    positive angle; each edge e at p, with side colours a (clockwise) and b (counter-clockwise) and unit normal ν pointing to b's side, is near p of
    exactly one of two types — (split) an arc of the unit circle about a point y of ω(p) at which both a and b have support, a unit arc of kind both; or
    (tangent) a segment or an arc of radius at least 1 along which every x has x + ν(x) in the closure of colour a and x − ν(x) in the closure of colour b,
    so that p + ν(p) carries a and p − ν(p) carries b, two antipodal points of ω(p) on the normal to e at p; and every colour of p is carried on ω(p)
  uses only: FS111-M-PINCH and FS111-M-C11 at the interior points of e, where (H1) and (H2) hold (two tiles meet there, each locally connected, e being a
    segment or an arc of a fragment); that supports are closed; that the split points of e's interior are open (M-C11 (iii)) and closed (a limit y of split
    centres y_n has |x − y| = 1 and carries both colours, and M-PINCH run with y as both contacts is (split)), so e's interior, being connected, is of one
    type; that e's tangent direction is continuous up to p; saturation at p itself for the last clause
  not claimed: anything at a cusp at p; that the split centre y has four colours (FS112-N3-NOBOTH gives four colours or a repeated colour, and
    FS111-W-NOREP removes the repeat only on cusp-free saturated maps); that any saturated valid six-coloured fragment about a four-colour vertex exists; that
    the strip's midline configuration is excluded in the class (SAT-STRIP, the claim list); saturation of any held six-colour positive
  argument: § 4.1a The argument of FS116-O1-SATPIN
  verdict: derived
  grade: derived from: FS111-M-PINCH, FS111-M-C11
  minds: 1
  model: k = 9 — FS111-W-SQ9, the square nine-colouring of side 1/2 (saturated, FS111-M-PINCH's model at an edge point): at each grid point four colours
    meet, every edge is of the tangent type, and its partners sit at the two points of ω(p) on the edge's normal; at k = 7 R7's lattice points have cusps
    and are outside the hypothesis
  prior art: partly: FS111-M-PINCH is FS-111's (the dichotomy at an edge point); its reading at a vertex of a map not found — FS-111's gate,
    "chromatic & plane & (measurable | map) & (tight | saturat* | maximal)" (7)
  handoff: de Bruijn — with FS111-M-PINCH and FS111-M-C11, queued behind the measurable chain: the statement, its cusp exclusion, and the inner-disc
    reading of saturation for fragments

### 4.1a The argument of FS116-O1-SATPIN

At an interior point `x` of `e` close to `p`, exactly two tiles meet (a fragment is a locally finite map), each meeting a small ball about `x` in one connected
open set: (H1) and (H2). `x` is an essential boundary point of both side colours, so saturation gives contacts `y_a`, `y_b`, and M-PINCH gives (split) or
(tangent). The split points are open (M-C11 (iii) fixes both sides as the two sides of `T₁(y)` on a neighbourhood) and closed (if split points `x_n → x` with
centres `y_n`, a subsequence has `y_n → y` with `|x − y| = 1`, `y` in both closed supports; M-PINCH at `x` with `y_a = y_b = y` excludes (in, in) and
(out, out), so it is (split)). `e`'s interior near `p` is connected, so it is all (split) — then `e` is an arc of `T₁(y)` for one `y`, and `|p − y| = 1` by
continuity — or all (tangent). In the tangent case M-PINCH's contacts are antipodal, `y_b = 2x − y_a`, with `B(y_a, 1)` covering `b`'s side near `x`, so
`y_a = x + ν(x)`; M-C11 makes `e` `C^{1,1}` with `|κ| ≤ 1`, and a segment or circular arc with `|κ| ≤ 1` is a segment or an arc of radius at least 1.
Letting `x → p` along `e` (its tangent is continuous at `p`), `p + ν(p) ∈ supp S_a` and `p − ν(p) ∈ supp S_b`. The last clause is saturation at `p`, an
essential boundary point of each of its colours. ∎

**What it does at the vertices the card named.**
- **The strip's midline configuration** (a degree-4 four-colour vertex with four straight edges at 0°, 90°, 180°, 270°, and four (Q) arcs on its ring,
  `data/fs114/fs114-y6/survey.out`, row 136): in the saturated class all four edges are of the tangent type (a segment cannot be split), so each axis point of
  `ω(p)` carries two of `p`'s colours — at 0° the colours of the tiles on the 90° edge's far side and the 270° edge's near side, and so on round — and each
  partner support contains the half of the tangent line to `ω(p)` there that runs parallel to its edge. The capped strip does not have this (its midline edges
  are free for both colours, FS111-VM2-STRIP-MID). **Whether any saturated fragment does is SAT-STRIP**, D0's first claim; it is not decided here.
- **Rings free of (Q) arcs** (N6-RING60): `p`'s colours reach such a ring at its change points (N7-HUB's tips) or on arcs of `Γ` of other kinds; so a tangent
  edge's partner points `p ± ν(p)` must sit at change points or on such arcs, and a split edge's centre is a point carrying two of `p`'s colours. Stated as
  SAT-QFREE, D0's second claim.
- **Tactic edges** (FS114-N2's sense: a whole unit arc about a four-colour vertex `q`, with `q` in its inner tile's closure): in the saturated class these are
  split edges whose centre lies in the inner tile's closure; a split edge whose inner colour sits at `y` on another tile is the case N4-LENS and N114-RD govern.

**Decision (the card's "if every edge is pinned" branch, taken with one qualification).** FS-116 poses its NO in both classes, and runs the saturated class
first **beside** the class-free ring work, not before it: (1) route M's honest branch consumes only the saturated NO (FS111-M2-REDUCE-A), and FS-121 produces
the class; (2) SATPIN gives every four-colour vertex of the class ring placements FS-114 never had, most at the 0–2-tactic vertices FS-114 never touched; (3)
the class has no held six-colour positive about any four-colour vertex, so its dial is unknown (G21) and the construction side's first saturated object
measures it. The qualification: a saturated-class NO answers Question 2 for no map outside the class, and serves route M only with C-SAT-T-HONEST at six
(FS111-C-SAT-T-HONEST, GAP, FS-121's); the all-maps NO stays the milestone's headline target. **Answer sent to "main" for FS-121's opening once committed.**

### 4.2 The erratum draft (for Keryx to file; `plans/FS114-derivation.md` is not mine)

**Checked, and Poros is right on both lines.** The capped strip's midline vertices have four straight edges and no tactic edge at all
(`data/fs114/fs114-y6/survey.out`: `tactic=0`, four `seg` edges, at all ten midline vertices), so `n = 4` and the charge is `n − 2 = 2`, a surplus;
FS114-N2's own control says so (`plans/FS114-N-proof.md` l. 299, "the strip — midline vertices `n = 4` (four straight edges)"). The slip conflated *has* four
tactic edges with *centres* four tactic arcs: each midline vertex is the centre of four arcs of kind both (N2-VCAP; row 136), none of them its own edges. The
configuration the charge penalises is held on a fragment elsewhere: FS114-Y2-BOWTIE's centre, "a degree-4 vertex `p` of four colours whose **four** edges are
tactic". N3-JOINT's model line inherits the slip: `plans/FS114-N3-proof.md` § 3.2 names no strip model; the close wrote it.

- **Slot 1:** `plans/FS114-derivation.md` l. 239–240, FS114-N2-ENDS's `model:` field. Replace
  `model: the capped strip's midline degree-4 vertices, each with four tactic edges (\`n = 0\`, charge −2) — the configuration the charge penalises, held` /
  `on a fragment` with:
  ```
    model: FS114-Y2-BOWTIE's centre `p`, a degree-4 four-colour vertex with four tactic edges (`n = 0`, charge −2) — the configuration the charge
      penalises, held on a fragment (`B̄(p, 3√3/5)`); the capped strip's midline degree-4 vertices have four straight edges (`n = 4`, charge 2), each the
      centre of four tactic arcs (N2-VCAP), not their own edges
  ```
- **Slot 2:** l. 261, FS114-N3-JOINT's `model:` field. Replace `model: the strip's midline vertices as deficient vertices, their continuation ends as sources
  (a fragment, not a map)` with:
  ```
    model: FS114-Y2-BOWTIE's centre `p` as a deficient vertex (DR's shape, FS114-N3-DR: four tactic edges, `n = 0`), its tactic ends' continuations as
      N3-PAY's sources (a fragment, not a map); the strip's midline vertices carry `n = 4` (charge 2), so their two ends beyond the first two are free ends
  ```
- **A dated erratum line** under FS114-N2-ENDS's "Rests on it:" paragraph, in the file's erratum style: "*Erratum (FS116-O1, 2026-09-29): the model line
  said the strip's midline vertices have four tactic edges (`n = 0`, charge −2); they have four straight edges (`n = 4`, charge 2) —
  `data/fs114/fs114-y6/survey.out`, FS114-N's control (`plans/FS114-N-proof.md` l. 299); found by Poros (FS116-P1). The model is now FS114-Y2-BOWTIE's
  centre; nothing rests on the model line.*" The same line, mutatis mutandis, under FS114-N3-JOINT. **No statement changes** — only model lines — so no
  ledger row and no dependant is affected (N2-ENDS's statement and K1's definition read the charge, not the model).

### 4.3 The routes

*The object is the ring of a four-colour vertex (§IQ.3); the kill is the straddle (row 138); the NO's shape is G15's — the pigeonhole at `p` is its ring type,
and each type gets a kill. Every job below is a derivation or an exact check of a fragment by formula; nothing enumerates.*

| phase | what it asks | its claims (`data/fs116/claims.md`) | §G instruction it carries | controls |
|---|---|---|---|---|
| **D0 — the saturated class** | card 1 continued: what SATPIN's placements exclude | SAT-STRIP, SAT-QFREE, NO-SAT | G84, G85, G21 (the class's dial unknown) | SQ9 (k = 9), R7 at its non-cusp points, the strip off its midline |
| **D1 — the ring** | the structural form: ring types, their twist, and the transfer rule; card 3 | RING-TWIST, RING-Q (card `what-do-q-rings-force`), RING-TRANSFER | G71, G13, G79, row 133's W-TAN | the strip's midline ring, the disk's corners, R7 at k = 7, the bowtie |
| **D2 — the exclusion** | follow a ring's placements outward to a straddle; the radius | C114-LOCAL-F, DISC-F, LOCAL-DENSE | G15, G86, G82 (uniform in the complexity) | the strip at `φ²/√2`, the disk at `φ`, the bowtie at `3√3/5` |
| **Y — construction** | killing tests by formula, checked exactly | Y-QRING (G83's killing test), Y-SAT (a saturated six-coloured fragment about a four-colour vertex) | G83, G21 | the held positives, rebuilt checkers |
| **K — FS-114's round 7** | K1's residues, as ring types | FS114-N7-3T and N7-HUB for the blind check; the wrap; OC; the (Q)-pinwheel | G79 (behind D0, D1) | the bowtie, L60-REAL |
| **V — blind second minds** | every claim on the frozen list | YESLIM, SATPIN, N7-3T, N7-HUB first | the standing independence rules | — |

**Why this order** (the re-grokking's change to the stub's queue): FS-114's round 7 was six escapes of K1, each a counterexample invariant, all at vertices with
three or four tactic edges; the positives that reach farthest sit at vertices with 0 and 2 (Poros's C1). G79 says derive what every solution carries first:
D1 is the structural form itself and D0 is the same question in the class route M consumes. K's first item (the blind second mind on N7-3T and N7-HUB) runs
in V at once, because D1 builds on N7-HUB; K's derivations (the wrap, OC) wait for D1's rule, which may absorb them as ring types.

### 4.4 Stages and jobs

*Budgets are guidance (Kooshi, 2026-09-27); every job saves and commits each stage in its record, so a kill redoes only the unsaved stage; resume by standing
rule 2 (read the record, continue at the first unsaved stage). No job runs a process over fifteen minutes; no checkpointed run is planned.*

- **Round 1 (after the freeze), three jobs, parallel if staffed** (Kooshi staffs; FS-121 runs beside):
  - **FS116-N1** (proof side, Ephodos): recognition first (standing workflow); then RING-TWIST at every `k` with its defects named, then RING-Q (card 3) with the
    strip's midline ring and the disk's corners as controls; then SAT-STRIP and SAT-QFREE if the budget holds. Record `plans/FS116-N1-proof.md`; ~450k.
    **Stop rule:** three failed attempts on one step → `ephodos-recognition`, then `ephodos-invention` if the homes die on one line.
  - **FS116-Y1** (construction side, Ephodos): Y-SAT first (saturate the capped strip at its midline, or show by formula why a saturated six-coloured strip
    cannot hold `φ²/√2`) — it scores P1 from the other side; then Y-QRING (G83's killing test). Exact checkers with plants; the controls' checkers accept
    first. Record `plans/FS116-Y1-construction.md`; ~400k. **Stop rule:** a candidate that fails the exact check measures the candidate; three failed
    families → report the families' free parameters against the configuration's.
  - **FS116-V1** (ephodos-verifier, blind): YESLIM and SATPIN (this job's, one mind each), then FS114-N7-3T with N7-HUB (b) and the `+++ b = a + 1` step —
    scoring N7's two registrations. Record `plans/FS116-V1-verification.md`; ~350k.
- **Round 2**, chosen by P1–P3: D2 on the ring rule D1 returns (FS116-N2), with the blind second minds on round 1's derived claims (FS116-V2); K's wrap and
  OC only if D1 did not absorb them; the construction side on what D1 says a positive must carry.
- **The close** (FS116-C): the derivation file, the drafts, the sweeps (`.claude/agents/ephodos.md` § The close job).

### 4.5 Registered predictions (each decides what runs next; instruments for G21, scored at the close, never caps)

- **P1 — SAT-STRIP is TRUE** (no valid six-coloured fragment saturated on `B̄(p, 1)` has the strip's midline configuration at `p`): **0.55**. *Decides round 2's
  class:* TRUE → the saturated class loses its only candidate positive beyond `√3`, and round 2 aims D0's pinned-edge kills at the disk's corners (two tactic
  edges) and at degree ≥ 5; FALSE → a saturated positive at a 0-tactic vertex exists, the saturated class is no easier there, and round 2 runs D1 → D2 in the
  all-maps class first.
- **P2 — no fragment by formula about a (Q)-ring four-colour vertex beyond `φ²/√2` is built in round 1** (G83's killing test not met): **0.8**. *Decides the
  construction side's round 2:* met → C114-LOCAL-F's lower bound moves, and the proof side reads what that fragment's ring carries before any exclusion.
- **P3 — RING-Q holds** (at a four-colour vertex whose ring carries a (Q) arc, every change point of the ring off the (Q) arcs is a vertex of at least four
  colours): **0.45**. *Decides D2's route:* TRUE → D2 follows four-colour vertices along the triangular lattice through (Q) rings to a straddle; FALSE → the
  (Q) ring closes without placing a four-colour vertex, and D2 needs another handle there (the construction side builds at that ring first).
- Carried from FS-114, scored by FS116-V1: N7's two registrations (OC dies within `√3`, 0.5; every (Q)-ring survivor has a 60° (Q) arc or a (Q) arc ending 60°
  from a tactic centre, 0.4). The stub's four provisional expectations are replaced by P1–P3.

### 4.6 Failure clauses

- A local exclusion for one configuration or one ring type is a piece, and names the types that remain; a NO for non-Siamese, simple or saturated fragments
  only says so in its headline (G21, G86); a saturated-class NO says it serves route M only with C-SAT-T-HONEST at six.
- Every step states its reading radius and the controls it fails on (the strip at `φ²/√2`, the disk at `φ`, the bowtie at `3√3/5`); a ring-type rule stated at
  `k = 6` says what it does at `k = 7` (R7) — the vacuity rule, because the six-colour class may be empty.
- No argument one colour class at a time (row 129); no count as a step of the NO (G86); a derivation that uses the complexity bound says so.
- YESLIM's converse is never used; a YES is fragments on growing discs, not a map.
- A YES candidate that fails the exact check measures the candidate; a family that all fail measures its image, its free parameters stated.

### 4.7 Stubs

**None minted.** Every question this opening surfaced is inside FS-116's claim list (LOCAL-DENSE, DISC-F) or FS-121's (C-SAT-T-HONEST); FS-123 to FS-125 are
unused.

**G87 lookout, stage 4:** none seen. One near-collision classed: the strip "holds every disc below `φ²/√2`" (FS114-Y-DIAL) and "the strip is not saturated"
(FS111-VM2-STRIP-MID) are both true; they collide only if the dial is read as the saturated class's, which G21 forbids — a scope.

## Stage 4 — SAVED

## Stage 5 — SAVED: the proposed claim list, FS-121's answer folded in, and the report

### 5.1 FS-121's card answered, and what it does to D0 (the coordinator's ruling, 2026-09-29)

FS121-O1 answered `do-ladders-end-on-q-rings` (one mind, hand; `plans/FS121-map-step.md` § 3.2–3.4, commit 96889732, read at the source for its entries
FS121-O1-CARD, -OUT and -PER). Keryx ruled that card `what-do-q-rings-force` stays FS-116's, run once here (RING-Q), and FS-121 takes its result as an input.
Two of its entries bear on D0, as one-mind inputs graded as filed:
- **FS121-O1-PER** (verbatim): "in an honest saturated colouring in D-NF satisfying REG-J′ whose interfaces carry only finitely many radii of curvature — in
  particular a doubly periodic one without large-radius accumulation — every curved interface is a split unit arc of kind both and no (R2) arc occurs; where no
  colour has density 0 at an arc's centre, every such arc is (Q)". Composed with SATPIN: in that subclass every edge at a cusp-free four-colour vertex is a
  tangent-type segment or a (Q) arc about a point of `ω(p)` — **SATPIN-PER**, added to the claim list's D0.
- **FS121-O1-OUT** (its statement: the unit parallel away from the centre of every tangent-type interface arc of radius `n` is, off `Σ`, a tangent-type
  interface arc of radius `n + 1`; "infinite for a segment"): with M2-INTRAD, **every tangent-type segment at `p` is one rung of a ladder of straight
  interfaces at every integer distance on both sides, off `Σ`**. This is D0's first handle on SAT-STRIP: the strip's four straight edges would lay a unit grid
  of interfaces about `p`, and the partner colours SATPIN places at the axis points of `ω(p)` must fit it. Instruction to FS116-N1 (and to Y-SAT's builder):
  start SAT-STRIP from that grid.

### 5.2 The proposed claim list

`data/fs116/claims.md`, for Keryx to freeze: the definitions (valid map and fragment, the `k`-coloured fragment, Siamese, `Γ` and tiles, ring and change point,
tactic edge, simple, essential multicolour, saturated and saturated on a disc, `χ_m⁰`, the strip's midline configuration, ring type) quoted with addresses or
marked "(this list)"; the two questions verbatim; five held inputs verbatim; this opening's YESLIM and SATPIN for their blind second mind; D0 (SAT-STRIP,
SAT-QFREE, SATPIN-PER, NO-SAT), D1 (RING-TWIST, RING-Q with RING-Q′, RING-TRANSFER), D2 (C114-LOCAL-F, DISC-F, LOCAL-DENSE), Y (Y-QRING, Y-SAT), K
(FS114-N7-3T verbatim for its owed blind check); controls and carried killing tests. Each statement has its *not claimed* line; no grades, no priors, no
routes. **Note for the freeze:** RING-Q quotes the card's ask and states a sharper claim beside it, marked; P3 is registered on RING-Q, P1 on SAT-STRIP.

**G87 lookout, stage 5:** none seen. FS121-O1's "a step fails, at link 1 → 2" and this plan's D0 do not collide: FS-121's failing link is at (R2) ends with a
three-colour centre, which FS121-O1-PER removes in the finitely-many-radii subclass and which SATPIN, stated for four-colour `p`, does not reach.

## Stage 5 — SAVED
