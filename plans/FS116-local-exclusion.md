# FS-116 — the local exclusion: the plan (job FS116-O1, the opening: §G, §PA, §IQ, the plan proper, the proposed claim list)

*Ephodos (Opus 5.5), job FS116-O1, for Keryx. Brief `data/fs116/briefs/FS116-O1-opening.md` (commit 519fe70b), with `plans/STANDING-RULES.md` as part of
it. Identity and procedure: `.claude/agents/ephodos.md` § The opening job. The stub is `plans/STUB-local-exclusion.md`, its question posed by Poros
(FS116-P1, `plans/POROS-2026-09-28-fs116-question.md`). No fences: FS-121's opening (FS121-O1) runs beside me; I write none of its files. I touch only this
record, `data/fs116/claims.md`, `data/fs116/o1/`, `tools/fs116_o1_*.py`, `data/fs116/reports/FS116-O1.md`, and new stubs numbered FS-123 to FS-125.
Grades are `CLAUDE.md` § Notation's; entries use my identity's grammar and translate at the edge (`.claude/agents/ephodos.md` § Two vocabularies).*

## Theorems this phase proved

- **FS116-O1-YESLIM** (card `the-yes-needs-no-map`) — valid fragments on discs of every radius give a measurable six-colouring of the plane proper at
  almost every unit pair, so `χ_m⁰(ℝ²) ≤ 6` and `χ(ℝ²) ≤ 6` with no MR — [hand], one mind (this job), § Stage 3 §IQ.4. *(Filled at stage 3.)*
- **FS116-O1-SATPIN** (card `what-does-saturation-pin`) — see § Stage 4 §4.2 for its statement and grade. *(Filled at stage 4.)*

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
