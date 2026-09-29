# FS-121 — the map step: the plan (job FS121-O1, Ephodos, the opening job)

*Written by Ephodos (Opus 5.5) for job FS121-O1, from its brief `data/fs121/briefs/FS121-O1-opening.md`, 2026-09-29. The stub is
`plans/STUB-map-step.md` (FS-111's close, with Poros's question, job FS116-P1). This record is the milestone's plan: §G, §PA and §IQ first, in that
order, then the plan proper. The proposed claim list is `data/fs121/claims.md`. FS-116's opening (FS116-O1) runs beside this job; I write none of its
files.*

## Theorems this phase proved

*(filled at each stage; one line per theorem, with its grade and address)*

## Would-have-searched-here log (standing rule 5)

- *(none yet)*

## Fence log (standing rule 8)

- No fences in this brief. No fenced text read. No transcripts, `chats-bak/` or auto-memory read.

## Slips

- **Stage 1:** I built `tools/fs121_o1_quotes.py` before reading `RUNNING.md` § Make the gate fail (standing rule 7 asks for that reading first). I
  read it right after, and checked the tool against it: a missing quote or an unreadable source exits non-zero, and the plant fires (below).

## Stage 1 — SAVED: the readback, and §G

### 1.1 Readback of the brief

Every quotation in the brief, checked verbatim against its source by `tools/fs121_o1_quotes.py` (whitespace normalised, nothing else), input
`data/fs121/o1/quotes-brief.tsv`, output `data/fs121/o1/quotes-brief.out`: **13 of 13 found, exit 0**. The plant (the first quote altered by one
character) is reported missing and the run exits 0 as a fired plant: `python3 tools/fs121_o1_quotes.py data/fs121/o1/quotes-brief.tsv --plant`.

- The aim, "My goal is to fully solve, and then verify in Lean, HN. Then we publish." (`CLAUDE.md` § The aim): found.
- "Item 1's default is overturned: FS-121 opens beside FS-116" (`plans/FS116-close-inventory.md`): found, and it is row 4 (l. 32), as the brief says.
- The existence form and the structural form (`plans/STUB-map-step.md` § Existence form, § Structural form): both found verbatim. My §IQ quotes them.
- The card's phrases "a check of a four-link composition", "under an hour", "this milestone opens on that link", "the two openings run it once" and
  the recommendation's "Kooshi's or the plan's call": all found in the stub.
- The erratum's evidence, "every edge-side carries its ladder" (`plans/FS111-derivation.md`, l. 1019), and "16 of 16 vertical edge-sides", "tested
  only off the midline" (`plans/FS111-VM2-verification.md`, ll. 41, 211): all found.
- Cohen–Mani's Question 5.1, as the stub quotes it: found.

**No mismatch.** One reading note, not a mismatch: the brief's ellipsis in "if a step fails: … this milestone opens on that link" drops the clause
"the failing link (a cusp, a repeated colour, a ladder stopping above radius 1) names what separates a saturated map's interfaces from FS-116's rings".
§IQ uses the clause in full.

**My claims, restated beside the quotations.** This job owes: the plan (§G, §PA, §IQ with the card's answer, the route and its alternative, the
stages, the stub's three failure clauses, and only predictions that decide what runs next); the proposed claim list in `data/fs114/claims.md`'s form,
every rung with its colour count and its seven-colour inhabitant or where six is spent; the erratum to `plans/FS111-derivation.md` l. 1019, checked;
and the report.

### 1.2 §G — the re-grokking

*Read fresh at launch: the grokkings (preloaded, G1–G87, read by body); `LEDGER.md` rows 130–141 by mechanism (rows 130–133 by their headline,
134–141 in full); `CLAUDE.md` § The standard of evidence, § What compute actually helps, § Searching and § Toolchain's ban; the stub; FS-111's
derivation file in full; `plans/FS111-M-regularity.md` §§ 3–5; `plans/FS111-M2-regularity.md` § 4; `plans/FS111-W-wild.md` § 2; FS-112's arc kinds and
NOBOTH's two proofs (`plans/FS112-N-proof.md` l. 731, `plans/FS112-NB3-verification.md` § 1.4); Poros's record §§ 1.4–4.2.*

**Bears** (what the entry says about this milestone's object, and the phase it changes):

- **G85 — integer radii.** Its body: off a locally finite Σ, "radii fall by exactly 1 toward the centre and stop at 1", and "What escapes is radii → ∞".
  Read from inside the card, its source M2-INTRAD says more than the grokking's summary: the chain stops "at a unit arc of kind both **or at a unit arc
  centred at a point of Σ**" (`plans/FS111-M2-regularity.md` § 4.1, statement (ii)). The second stop is not M-PINCH's (split) type. It is the (tangent)
  type at radius exactly 1, whose centre carries the outer colour only. *Changes:* stage 3's card answer (the composition forks here), and the first
  derivation stage. *Falsifiable here:* yes; the card sharpens its killing test.
- **G84 — contact.** A saturated interface point lies on a unit arc whose centre carries both colours, or between two tangent unit discs. Its *Do* says
  to draw the ladder and find where it ends. *Changes:* the structural form's first question is where ladders end, and in which direction. Read with
  G85, the tangent case gives partners on **both** sides, so a curved ladder continues outward too. That is a derivation for stage 3 (the outward end).
  *Falsifiable here:* yes (its killing test, a non-`C^{1,1}` saturated interface, is what the honest route would meet).
- **G83 — the four-colour vertex.** "What is left is four-colour vertices whose rings carry (Q) arcs". *Changes:* the card asks whether the ladders
  end there; if some end elsewhere, the milestone opens on that end, not on FS-116's rings. *Falsifiable here:* its reading is tested by the card.
- **G82 — stability.** A weak-* limit of near-colourings is a colouring; "where the limit object is a map, look first for the printed regular theorem's
  own chain". *Changes:* the map step's route list. Row 134's chain (S–V Cor. 1 and Woodall's step 3, curved and a.e.) is the printed chain, and its
  N4 step, curvature monotonicity along the shadow map, is the candidate step for NO-PAR (stub question 1).
- **G21 — a negative measures its enumeration.** Every control here is tight at seven or nine, and none has an interface of radius ≥ 2 (VM2 § 1.5:
  "INTRAD's content beyond radius 1 is uninhabited among the objects held"). *Changes:* the claim list's vacuity rule. The card's own class (cusp-free,
  honestly saturated, with a curved interface) has **no held inhabitant at any `k`**: R7 has cusps, and SQ9 and HEX9 have no curved interface. So a
  seven-colour inhabitant of that class is a construction target, by formula, before any rung stated on it is believed.
- **G22 and G24/G60 — where six lives; integrality.** A six-colouring's classes are non-polygonal. No argument that bounds one class at a time gives six.
  *Changes:* M2-COV already says the cover route's regularity rungs are one class at a time (each is a statement about one MUA set). So those rungs are
  colour-blind: they cannot spend six, and every one needs a seven-colour inhabitant, not a six-colour one. The colour count enters only at the NO
  (Q-NO or NO-PAR) and at "the union is full". The claim list states each rung with its colour count and names where six is spent.
- **G54 — tight or slack; fall colourings.** Its body records that a gap-free colouring is "a fall colouring, which Csernák calls 'tight'". FS-111's regular
  maximal partitions are measurable fall colourings (M2-ZERO, M2-SELCOMP). *Changes:* §PA. The finite-graph vocabulary for a partition into
  independent dominating sets is **idomatic** (and "fall colouring"). §PA searches "idomatic" beside "fall colouring".
- **G86 — tile counts are blind to Siamese pairs.** Its *Do*: "before a counting or discharging route to a map-colouring NO, ask whether the class
  allows Siamese pairs". *Changes:* the joint with FS-116 and FS-117. The honest route hands the NO an honestly saturated map (M2-REDUCE-A). If honest
  saturation excludes Siamese pairs, route T's non-Siamese count (FS-117) would serve the honest route. Nobody has asked that. It becomes a question for
  the coordinator to route, in the report.
- **G79 — the wall and the example invariant.** *Changes:* the plan's shape. The universal forms that fail at seven (MUA-FIN-U, MUA-REG-U, block
  structure, arcs on covers) are counterexample invariants. The structural form asks for the invariant every ladder end carries, the example invariant.
  The first derivation stage aims at what every ladder end carries.
- **G87 — the invention signal.** *Changes:* nothing yet. I read for a collision in every source above (§ 3.4 records the result).

**Rows, by mechanism.**
- **Row 135** bears most. It does two things. It reduces every unit arc, by moves, to **(Q)** or **(R2)**, where (R2) is "an arc whose centre carries the outer
  side colour and not the inner, with an inner-colour tile along the radius-2 circle over the whole arc". It also finds the stuck chain consistent as "a
  pencil of circles of radius `k + 1`". *Changes:* the card. In a saturated map both appear without any move: (R2) as INTRAD's second stop, and the pencil
  as the outward ladder.
- **Row 134's N4 step** (the shadow map `λ ↦ λ/(1 + λ)`, curvature monotonicity along a line) is where NO-PAR would be decided, and "no step uses the
  complexity bound". *Changes:* the cover route's first stage.
- **Rows 137–138** bear on the joint. The NO's residue is (Q) rings (row 138's not-claimed: "K1 (GAP at rings with (Q) arcs …)"). A four-colour vertex
  exists in every valid map (row 137).
- **Row 136:** the strip is unsaturated on its midline, so it is no control for saturation. This gives the erratum (§ 4.4).
- **Rows 140–141:** the rungs this milestone continues. They are M-PINCH and M-C11 (three minds), M2-INTRAD (two on its core), W-NOREP (one mind) and
  M4-LADDER/M4-CUT (one mind, no verifier).
- **Rows 130–133 and 139** fix the frame: tight exists iff `χ_m⁰ ≤ k` (V0-RESCALE), both routes' third statements are the answer restated (C-REG-EQ,
  W-NEG), and W-EQ-K. They bear as the honesty rule every claim obeys; they change no phase.
- **`CLAUDE.md` method sections.** The ban (§ Toolchain) rules out every search for a saturated six-colouring or a radius-2 chain. The standard of evidence
  bears through its question, "what must someone who trusts none of this actually check?": for this milestone that is the statements, because every top
  rung is conditional.

**Silent:** G1, G2, G3, G4, G5, G6, G7, G8, G9, G10, G11, G12, G13, G14, G15, G16, G17, G18, G19, G20, G23, G25, G26, G27, G28, G29, G31, G32, G33,
G34, G35, G36, G37, G38, G39, G40, G41, G42, G43, G44, G45, G48, G52, G53, G55, G56, G57, G58, G59, G61, G62, G63, G64, G65, G66, G68, G69, G70, G71,
G73, G74, G75, G76, G77, G78, G80, G81. Retired, read as pointers: G30, G46, G47, G49, G50, G51, G67, G72.

**Does the re-grokking change the plan? Yes, in four places:**
1. The card is answered on INTRAD's full statement, not on G85's summary. The (R2) stop becomes the milestone's first structural object (stage 3).
2. The outward direction of a curved ladder becomes a claim (stage 3).
3. A seven-colour inhabitant of the card's class is a construction target before any rung on that class (G21).
4. Two questions go to other lanes: "does honest saturation exclude Siamese pairs" (G86), and idomatic partitions as §PA vocabulary (G54).

## Stage 1 — SAVED

## Stage 2 — SAVED: §PA, the prior-art gate

### 2.1 The recognition (`ephodos-recognition`, invoked fresh at this stage)

**For a stranger** — a geometer who works on parallel curves and sets with the rolling-ball property: *Partition the plane into `k` measurable sets
(classes) so that no class contains two points at distance exactly 1 (up to null sets), and assume the partition is* saturated: *at every boundary
point, each colour present there has a point of its own closure at distance exactly 1. Then every two-colour stretch of boundary has two tangent unit
discs, one in each class, so it is a `C^{1,1}` curve with `|κ| ≤ 1` (Blaschke–Walther rolling), and its unit parallel curves on both sides are again
boundary curves. Where does such a family of parallel boundary curves stop, and how many stopping points can a bounded set hold?*

**Features, sorted** (one line each; the receipt in brackets):
- that same-colour points avoid distance exactly 1 — *determines* (every step of M-PINCH consumes it);
- saturation, but only through its consequence "each boundary point has a partner at distance exactly 1 for each of its colours" — *determines* (split
  off; M-DEADLOCK's unsaturated hexagons have wiggled, non-`C^{1,1}` edges, V0-WIG7);
- the number of colours `k` — *accompanies* the ladder statements (M-PINCH, M2-INTRAD and the card's links use no colour count; R7 at `k = 7`, SQ9 and
  HEX9 at `k = 9` satisfy them) and *determines* only the NO and "the union is full" (G24's rule);
- measurability / D-NF — *determines* what Σ means: `[DidinVoronov2026]`'s everywhere-proper colourings with **dense** classes (12 colours) would make a
  topological singular set everywhere; FS-111's Σ is measure-theoretic (essential boundaries, density points), and that is what keeps the existence
  form from a trivial inhabitant at `k ≥ 12`;
- the plane's metric through the unit circle only — *determines* (the parallel-curve formula `ρ ↦ ρ ± 1` is all INTRAD uses);
- the complexity bound — *accompanies* (INTRAD states none; row 134's chain "uses no complexity bound").

**Homes, each with its dictionary and its test:**
1. **Free-boundary regularity of optimal partitions** (Caffarelli–Lin; Conti–Terracini–Verzini; `q03`: Ramos–Tavares–Terracini 2016, Alper 2020 "On the
   singular set of free interface in an optimal partition problem"). Dictionary: class ↔ cell; saturation ↔ optimality; Σ ↔ the singular set; REG-J′ ↔
   "regular partition" (a locally finite singular set, finitely many arcs at each point). *Test:* **killed as a theorem home.** Its proofs run on a PDE
   (monotonicity formulas, harmonic blow-ups), and the dictionary line "first variation of an energy" has no counterpart for a distance-1 constraint.
   It is kept as vocabulary: REG-J′ is that field's "regular partition", in words.
2. **Rolling-ball regularity** (Blaschke's rolling theorem; `[Walther1999]`; `q02`: 57 hits, among them Howard 1999 and Drach 2026). Dictionary: two-sided unit
   discs ↔ the two-sided ball condition of radius 1 ↔ `C^{1,1}`, reach ≥ 1 on both sides. *Test:* the old proofs apply at once to M-C11's step. It is a
   **home for one step**, and it has no theorem about unit distance.
3. **Parallel families and their focal set** (the differential geometry of parallel curves: the evolute, the grassfire and medial axis). Dictionary:
   ladder ↔ a family of parallel curves at integer offsets; its inner end ↔ the focal point (the centre of curvature), where the inward parallel
   collapses; the curvature transport `λ ↦ λ/(1 + λ)` ↔ the parallel-curve formula `ρ ↦ ρ ± 1`. *Tests:* the old proofs apply (INTRAD's step (2) *is* the
   parallel-curve formula). The exceptions vanish: one statement covers split arcs and tangent arcs, because both are a family's last rung before its
   focal point. **It predicts a neighbour that INTRAD does not state:** on the convex side a parallel family never focuses, so a curved ladder has **no
   outer end**. That is derived in § 3.3 (FS121-O1-OUT) and checked on the controls (SQ9's and HEX9's straight ladders are its flat case). **This is the
   working home for the card.**
4. **Idomatic partitions / fall colourings** (`q04`: 16 hits; `q05`: 3; all finite graphs, including Goddard–Henning's fractional idomatic number). Dictionary:
   a regular maximal partition ↔ a measurable idomatic partition of the unit-distance graph (M2-ZERO, M2-SELCOMP (d)). *Test:* the theorems are for
   finite graphs, and a finite graph need not have a fall colouring. It is a **home for the honest route's saturation rung, as a question**:
   "does a tight `k`-colouring give a measurable idomatic `k`-partition?" `q06` (maximal independent / independent dominating × unit distance × plane or
   measurable) returns **0**. That zero measures the query's words (G21); it is not a proof of absence.
5. **Sets avoiding distance 1** (`[KMOR2016]`, `[CohenMani2025]`, `[Tolmachev2025]`). This is a **calibration home**, one class at a time. It has no
   regularity theory.

**The recognition sentence:** *a saturated colouring's interfaces are the members of parallel families of rolling-ball curves of radius 1, and the
question of where a ladder ends is the question of where a parallel family focuses — at a point that carries the outer colour of the last member —
posed for a measurable idomatic partition of the plane's unit-distance graph.*

### 2.2 The eight questions

Tools: `tools/fs121_o1_zb.py` (zbMATH Open API; positive control `an:0933.52003` → 1 and a nonsense title → 0, else exit 2; `--plant` swaps the control's
id and exits 2, run and seen). Queries: `data/fs121/o1/zb-queries.tsv`; output: `data/fs121/o1/zb-run.out`, JSON in `data/fs121/o1/zb/`.
`tools/fs121_o1_oa.py` (OpenAlex citing works; positive control: `[KMOR2016]` has ≥ 5 citing works, 11 found; `--plant` exits 2). Output:
`data/fs121/o1/oa-run.out`, and Semantic Scholar's citing lists in `data/fs121/o1/s2-run.out`. All run 2026-09-29.

1. **The discipline's words.** I ran `q01`–`q10` and `q17` in morphology, free-boundary, graph-theory, distance-avoiding and parallel-curve vocabulary.
   `q01` ("r-regular") returned 250 hits, all regular graphs: the word does not reach morphology in zbMATH's abstracts. `q02` (rolling) returned the
   Blaschke literature. `q03` returned optimal partitions (Ramos–Tavares–Terracini 2016; Alper 2020). `q07` and `q08` returned `[KMOR2016]` only. `q10`
   (parallel curves × colouring or unit distance) returned nothing bearing. `q17` (unit distance × free boundary, nonlocal or saturat*) returned nothing
   bearing. **No hit states a regularity theorem for measurable colourings or unit-distance-avoiding partitions.**
2. **Two disciplines.** Five homes (§ 2.1), each searched in its own words.
3. **The question itself.** `q09` combined "measurable chromatic" or "chromatic number of the plane" with map, tiling, regular*, Jordan or boundar*: 13 hits.
   Bernshteyn 2019 (measurable Lovász local lemma) is measurable colourings in the Borel-combinatorics sense; there is no map-regularity statement. The
   stub's map step is not posed in print. Its nearest printed questions are `[SokolovVoronov2025]` Question 2 (the NO side) and Cohen–Mani's Question 5.1
   (one class).
4. **Outside arXiv.** The Google group (held, `~/source/library/hadwiger-nelson-problem-group/`) has one "saturated", Sirgedas 2020, thread `Z50mmulkXCQ`:
   "the last vertex … is 'saturated' with curved edges". That is informal and in another sense (a vertex crowded with unit-radius edges). In the
   Geombinatorics archive's catalogue the "saturated" hits are packings, unrelated. `[Polymath16threads]` threads 4 and 12 (R7; "100% exclusion
   rate") were already read by FS-111.
5. **The posers' citation graphs.** `[SokolovVoronov2025]` has one citing work (Semantic Scholar: Axenovich–Liu–Sagdeev, Ramsey problems, off-topic), as
   FS-114 found. `[CohenMani2025]` has one (both databases: `[Tolmachev2025]`). `[Voronov2023]` has one (OpenAlex; max-norm triangles, off-topic).
   `[Walther1999]` has 75 (OpenAlex), every one in set estimation or statistics (alpha-shapes, boundary estimation, reach estimation); none is near
   colourings.
6. **Every citing work in the neighbourhood, opened.** `[Tolmachev2025]` (arXiv:2411.13248, fetched, not committed): abstract read, text skimmed by keyword.
   It finds dense periodic 1-avoiding sets as maximal independent sets of torus graphs, and its best sets approximate Croft's block construction: a
   calibration of Question 5.1, with no regularity. The rest are off-topic by title.
7. **Two databases.** OpenAlex and Semantic Scholar agree on Cohen–Mani's one citing work (the arXiv id and DOI 10.1142/s1793830925500314 are one paper).
   **OpenAlex does not resolve `[SokolovVoronov2025]`'s arXiv DOI** (a database miss, recorded), so S–V's citing list rests on Semantic Scholar alone:
   one database's count (G49).
8. **The posers' author listings (zbMATH).** Voronov (`q11`, 9 hits: the listing includes `[DidinVoronov2026]`, dense colour classes, whose abstract is
   read and which calibrates Σ in § 2.1, and Cherkashin–Voronov 2024 on spheres); Sokolov (`q12`, 4); Townsend (`q13`, 2: 1981, 2005, both held as
   bibliography keys); Coulson (`q14`, 7); Woodall (`q15`, 13). The query `au:"Mani, N"` (`q16`) mixes two authors and does not separate Nitya Mani's
   papers; "Cohen, A" is too common to query. Both are recorded as unsearched. **Nothing in these listings bears on regularity beyond what is held.**

**Debts.** `[Walther1999]` (Math. Methods Appl. Sci. 22 (1999) 301–316; Zbl 0933.52003): **not held, listing only.** The debt stands, named for the
library. M-C11's step rests on its theorem, now with Howard 1999 (Zbl 0958.53024, a review listed) as a second route to the same classical fact.
`[CohenMani2025]` § 5: **now read around Question 5.1** (the block-structure paragraph, the question, the ILP experiment, and the remark on greedy maximal
independent sets). The question is about one densest class. It bears on FS-121 only as a calibration: its "maximal independent set" is FS-111's MUA set
in graph words.

**Novelty.** The card's answer and the pencil lemmas of § 3 are not found in print. No indexed work treats saturated or maximal measurable colourings
of the plane (this gate, and FS-111's seven queries). Measured at the grain of the object class.

**Proposed bibliography rows** (INVENTORY in the report):
- `[Tolmachev2025]` A. Tolmachev, *On lower bounds of the density of planar periodic sets without unit distances*, arXiv:2411.13248 (v2, 11 Apr 2025);
  DOI 10.1142/s1793830925500314. Read: abstract, keyword skim. Role: calibration of `[CohenMani2025]` Question 5.1.
- `[Alper2020]` O. Alper, *On the singular set of free interface in an optimal partition problem* (Zbl 1442.05019). Listing only. Role: the vocabulary of
  REG-J′ ("regular partition", "singular set").
- `[Howard1999]` R. Howard, *Blaschke's rolling theorem for manifolds with boundary* (Zbl 0958.53024). Listing only. Role: a second source for M-C11's
  rolling step.

*Would have searched here:* none. This stage searched literature only.

## Stage 2 — SAVED
