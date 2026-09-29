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
