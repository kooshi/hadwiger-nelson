# FS127-Q1 — provenance and stage log of the outward question

*The outward document is `plans/FS127-Q1-question-for-a-third-party.md`. By the brief it carries no job id, ledger row, stub
number or file path, so this file is the job's working record as well as its provenance: the stage log (standing rule 2), the
check of the brief's quotations (rule 3), the statements as fixed with their addresses, and — from Stage 2 — one line per
statement of the outward text saying where it comes from and at what grade. Written by FS127-Q1 (Ephodos, the writer of one
outward document; brief `data/fs127/briefs/FS127-Q1-third-party-question.md`). Nothing is derived in this job.*

## Theorems this phase proved

None. The job states; it does not derive. No grade, scope or verdict is raised or lowered against its source.

## Stage 1 — SAVED: the readback, the brief's quotations, the three stalls, and the statements fixed

*2026-10-08, about 03:00 UTC.*

### 1.1 Readback

One outward document for a mathematician who has never seen this repository: the existence step that FS-132 could not
take, posed self-contained, with its variants, what may be assumed from print, this project's own hand results kept apart
and marked, the three attempts each with the step it could not take, what is known false, test colourings, what an answer
would and would not imply, and what is not claimed. No new derivation; if the step closes, stop and message. Kooshi sends
it himself.

**Not done as the workflow's default would have it, and why.** (i) No recognition stage and no entries in the deriver's
grammar: this is not a derivation job (the brief: "you state, you do not re-derive"), and no claim is assigned. (ii) The
brief says "load `ephodos` fresh with the Skill tool"; that skill is not in this session's skill list (the cores are
hidden from it), and the identity is in the launch text verbatim, which I worked from. (iii) The stage log is here and
not in the record, because the record is the outward text.

### 1.2 The brief's quotations against their sources

| quotation in the brief | source | result |
|---|---|---|
| Kooshi's K1 ("In the mean-mean-time, can you write up that derivation that stalled 3 times …") | `data/fs127/REQUEST-third-party.md` l. 3 | **matches**, character for character |
| the front page's ranked row 3 ("FS-127 lateral extent … the seed every statement of FS-124 begins with "if" about") | `CLAUDE.md` l. 259 (§ Paths forward, ranked) | **matches**, the whole row |

No mismatch.

### 1.3 Which three stalls — and that they are three statements

`plans/POROS-2026-10-07-fs132-round2.md` ll. 347–350 names them: "the three that ask how a point with data is produced
were each answered off their tables — the first round's card 2 ("Neither as posed", `plans/FS132-E1-derivation.md` l. 333),
its card 3 ("the card's own frame is corrected", the inventory's item 5) and the witness card". The cards as asked:
`plans/STUB-six-by-the-nerve.md` ll. 85–127. So the brief's reading (the existence step) stands; what the record adds is
that it is not one statement tried three times.

| attempt | job, record | what it tried | the statement it could not prove | where it went |
|---|---|---|---|---|
| 1 — card 2, "what the extraction needs of the centres" | FS132-E1, `plans/FS132-E1-derivation.md` ll. 332–345 (§ Card 2) with ll. 224–235 (S8) | the release's extraction with no finiteness of the cyclic centres | the conclusion of C132-EXT-DISC "when 𝓛 ∩ D is infinite" (`plans/FS132-derivation.md` l. 465, its *not claimed*); for 𝓛 ∩ D countable and closed a sketch, "the step I have not done is the uniformity in `n` over infinitely many lower-rank centres" (E1 l. 345) | "Declined as a stub by the asking lane" (`plans/FS132-derivation.md` l. 1365); the hypothesis itself — isolation, zero length — is in the stub list's row for FS-127 (`plans/FRONTIER-STUBS.md` l. 46) |
| 2 — card 3, "where does five enter" | FS132-E2, `plans/FS132-E2-derivation.md` ll. 448–527 | to force a centre whose cycle has length at least four (C132-LONG; C132-M-CV), **given** finitely many centres in the disc | C132-RING-TAME's first clause, finiteness of `J_x` (`plans/FS132-derivation.md` ll. 1212–1222); behind it "two further steps of the regular chain have no weak form" (l. 1235) | C132-RING-TAME's first clause to FS-127 and FS-128; C132-LONG and C132-M-CV to FS-122 (`plans/FS132-derivation.md` ll. 1362–1363) |
| 3 — the witness card | FS132-E5, `plans/FS132-E5-derivation.md` ll. 485–521 (§ The stall) | C132-WIT-EX: a witnessed cycle at some point of every disc of radius above 1, no hypothesis | C132-WIT-EX itself (`plans/FS132-derivation.md` ll. 1271–1281); the step: "the selection of a point through which connected pieces of two smoothed classes pass and reach a common second point" | form (O) to FS-127 and FS-128 (l. 1363) |

Implications among them, each one line from held entries (no new derivation): the conclusion of attempt 1's statement gives
attempt 3's (take `q_j ∈ K_j ∩ ∂B(x, ρ)`; `Δ({x, q_j}) ⊂ Δ(K_j)` — the argument of C132-WIT-EX-FIN, E5 ll. 477–483).
Attempt 2 is not on that line: it assumes the data and asks for more.

### 1.4 Two records word the open step differently (sent to "main" at once, as the brief asks)

- `plans/STUB-lateral-extent.md` ll. 78–79 and `plans/FS132-derivation.md` ll. 1285–1286, quoting E5 ll. 511–513: form (O)
  is "a weak colouring and a disc of radius above 1 in which, at every point, the graph of witnessed label pairs is a
  forest" — the negation of C132-WIT-EX.
- `plans/FRONTIER-STUBS.md` l. 46 (its source `plans/POROS-2026-10-07-fs124-question.md` l. 366): "a point through which
  connected pieces of two smoothed classes pass and reach a common second point (C132-WIT-EX's form (O), where FS-132
  stalled)" — that is the stall's missing step (E5 ll. 492–494, item (c)), which is sufficient for a witnessed cycle by
  C132-WIT-SUPER and not necessary (C132-WIT-MARGIN gives one with no connected piece). The same row offers a third reading
  of "usable data": "a cyclic centre isolated among the cyclic centres".
- The front page's row says "stalled three times in FS-132"; the stub list's row says "Asked three times in FS-132".

**Chosen** (and said to "main" before choosing): the outward document leads with C132-WIT-EX in its entry's words, gives
form (O) as its negation, and keeps the other two readings as variants, each stated exactly, with the implications
between them.

### 1.5 A slip found in passing (for the coordinator's files)

`BIBLIOGRAPHY.md` l. 401 calls `palette_sixty_disjoint` "Corollary 5.3". In the manuscript's source
(`~/source/math/preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/build/sections/palettes.tex`: Definition
at l. 47, Lemma l. 111, Remark l. 278, Corollary l. 292; one counter for all, `build/preamble.tex` ll. 17–24) the 60°
exclusion is **Corollary 5.4** and 5.3 is a remark — as `plans/EXT-OAI2-reading.md` l. 429 and `plans/FS132-derivation.md`
l. 75 have it.

### 1.6 The statements, fixed

*Each is copied from the entry named, with the project's words replaced by their definitions; the mathematical content is
unchanged. "Weak measurable `k`-colouring" is the release's Definition 1.2 (`plans/EXT-OAI2-reading.md` ll. 57–72).
`H_i` is the closed essential support of the class of `i`; `Δ(K) = {z : min_{q∈K}|z − q| < 1 < max_{q∈K}|z − q|}` (the
release's (7.1), same file l. 476).*

**(E) The existence step, smallest open form — C132-WIT-EX**, `plans/FS132-derivation.md` l. 1272, verbatim: "for every
integer k ≥ 1, every weak measurable k-colouring of the plane and every closed disc D of radius greater than 1, there are
a point p of D, an integer ℓ ≥ 3, distinct labels i_0, …, i_{ℓ−1} and points q_0, …, q_{ℓ−1} other than p such that for
each j modulo ℓ the closed essential supports H_{i_j} and H_{i_{j+1}} both miss Δ({p, q_j})". Verdict there: stalls.
Grade of the stall: [hand], one mind. Its negation is (O), E5 ll. 511–513, verbatim: "Is there, for some `k`, a weak
measurable `k`-colouring of the plane and a closed disc `D` of radius above 1 such that at every point `p` of `D` the graph
on the labels with an edge `{a, b}` whenever some `q ≠ p` has `H_a` and `H_b` both missing `Δ({p, q})` is a forest?"

Why this one leads: it is the weakest conclusion the held exclusion reads (C132-WIT-ORBIT, l. 164: four points `q_j`, and
its *not claimed*: nothing says the labels are present at `p`, "and nothing in the argument uses it"); it follows from
attempt 1's statement; it needs two definitions; and its entry carries the one smallest open form the record states.

**Variants of the data** (which data count as usable):

- **(E-anch) anchored** — C132-WIT-EX-FIN's conclusion without its transition-graph clause (l. 575): moreover "both
  contain p and q_j", and so `p ∈ H_{i_j}` for every `j`. Open beyond finitely many centres (C132-WIT-EX's *not claimed*:
  "the anchored form beyond C132-WIT-EX-FIN").
- **(E-conn) connected pieces** — the stall's item (c), E5 ll. 492–494, with "reached from `x` in label `i`" as E5
  ll. 471–475 defines it. Implies (E) by C132-WIT-SUPER.
- **(E-cont) the extraction's continua with no finiteness** — C132-EXT-DISC's clauses (1)–(3), optionally (4), at some
  point of `D`, with the hypothesis "𝓛 ∩ D finite" dropped (l. 463; attempt 1). Implies (E).
- **(E-iso) an isolated essential centre** — what E1 § Card 2 says the argument reads: the centres in `D` covered by
  discs of total radius tending to 0, and the essential centre isolated among the centres. A reading of an argument, not
  an entry.
- **(E-long) a cycle of length at least four** — C132-LONG, l. 1231, verbatim; attempt 2's target. Not implied by (E).

**Variants of the class**: every weak measurable six-colouring (every `k` in the entry's own wording); or Grundy
colourings (FS121-D3-GRUNDY, `plans/FS121-derivation.md` ll. 516–532, [hand], two minds, the second blind; the open
statement about them is (G2), E5 ll. 659–661, at seven).

**The three attempts' unproved statements**: § 1.3's table, column four.

**What is known false, with its example** (each [hand], one mind, unless said): local finiteness of the cyclic centres at
seven (EXT-OAI2-SLACK7-L, `plans/EXT-OAI2-reading.md` ll. 1045–1055, 1081–1092); a palette of at most two labels at seven
(EXT-OAI2-SLACK7-P, ll. 1057–1067, 1094–1104); the extraction's conclusion with clause (4) at an accumulation centre (E1
ll. 321–330; control `hex7-islands`); that a witnessed cycle marks a meeting point (C132-WIT-MARGIN; control
`margin-witness`); that an anchored witnessed triangle makes a cyclic centre (E5 ll. 544–553, "Hand, one mind, no
control"); that a point of multiplicity three gives pairwise overlaps of definite size (E5 ll. 496–501); that a density
point has a connected smoothed piece of definite size (E5 ll. 503–509); that with triangles filled the long cycles stay
essential (C132-NOESS, l. 602); that a cyclic transition graph gives an essential loop (E1 ll. 305–313, "hand, one mind,
no control"); that the hexagonal colouring or the two built on it are Grundy (C132-GRUNDY7-NOT, l. 1133).

## Stage 1 — SAVED

## Stage 2 — SAVED: the outward document, and where each of its statements comes from

*2026-10-08. The document: `plans/FS127-Q1-question-for-a-third-party.md`. "D" is `plans/FS132-derivation.md`; "E1", "E2",
"E5" are `plans/FS132-E1-derivation.md`, `…-E2-…`, `…-E5-…`; "R" is `plans/EXT-OAI2-reading.md`; "M/" is the manuscript's
source, `~/source/math/preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/build/sections/`, opened by this
job for the statements marked "read at source". Grades are the sources'; none is raised or lowered. "Translated" means the
project's words are replaced by their definitions and nothing else is changed.*

### 2.1 The outward text's names for the record's terms

| outward | the record's | why |
|---|---|---|
| weak measurable `k`-colouring | the same | the manuscript's Definition 1.2 (R ll. 57–72) |
| straddling region `Δ(K)` | "straddle set" | the manuscript's own word (M/interfaces.tex ll. 16–23: "its open straddling region") |
| `q` witnesses `{a, b}` at `p`; witness graph `W_p`; witnessed cycle | "witnessed edge", "the graph of witnessed label pairs", "witnessed cycle" | the record's, defined in the text (Definition 4) from C132-WIT-EX's own clause |
| room | "margin" | plain word, defined at its first use by C132-WIT-MARGIN's hypothesis |
| smoothed class | "smoothed class", "superlevel set" | defined in § 1 |
| reached from `x` in label `i` | the same | E5 ll. 471–475 |
| measurable Grundy colouring | "Grundy colouring", "honest" (the front page's row) | the finite-graph word; defined in § 3 from D l. 1134 (C132-GRUNDY7-NOT's statement) |
| cyclic centre, transition graph, palette, trace, typical circle sampling | the same | the manuscript's (M/transitions.tex ll. 29–38, 276–286; M/palettes.tex ll. 20–66) |
| kept disc; islands, stripes, dust | "core disc"; "the island colouring", "the stripe colouring", — | described where used |
| P1 … P9, T1 … T7, (1a)–(1d), (2), (3), (S2) | the entries below | labels local to the document |

Not used in the outward text: seed, ring, centre (alone), card, extraction, honest, tight, slack, margin, nerve, any
job id, row, stub number, grokking number or path of ours.

### 2.2 Statement by statement

| § of the outward text | statement | source | grade there | how carried |
|---|---|---|---|---|
| 0 | `χ(ℝ²) ∈ {6, 7}` and it is the least `k` with a weak measurable `k`-colouring | the manuscript's Theorems 1.1, 1.3 (R ll. 74–95); `CLAUDE.md` l. 64 | printed; its Lean audited here (`BIBLIOGRAPHY.md` l. 401) | restated |
| 0 | "we have proofs … when … finite in a disc, and when three colours leave room" | C132-WIT-EX-FIN (D l. 575), C132-WIT-MARGIN (D l. 401) | [hand] / derived from [hand], one mind | summarized; marked unchecked in the sentence |
| 1, Def. 1 | weak measurable colouring | M/introduction.tex ll. 83–96 (R ll. 57–72) | printed | the null-set form; R l. 140 says the two forms are the same set of functions |
| 1, Def. 2 | `H_i` | M/palettes.tex ll. 26–31 (read at source) | printed | verbatim in content |
| 1, Def. 3 | `Δ(K)`; open; connected `K` gives a point at distance 1 | M/interfaces.tex ll. 16–28 (read at source) | printed | verbatim in content; the two-point description is elementary |
| 1, Def. 4 | witnesses, witness graph, witnessed cycle | C132-WIT-EX's clause (D l. 1272); (O) (E5 ll. 511–513) | definitions | translated |
| 1 | "where the definition comes from" | C132-WITNESS (D l. 362) and its argument (`plans/FS132-E4-derivation.md` § Argument — a region witnesses its label); the manuscript's sentence on [SV] Props. 1–2 (M/interfaces.tex ll. 11–13, read at source) | [hand], one mind; printed | P1 named; the manuscript's sentence reported, not [SV] itself (unread by this job) |
| 1 | disc averages | M/interfaces.tex ll. 82–93 (read at source) | printed | verbatim in content |
| 1 | transition graph, cyclic centre, `𝓛` closed | M/transitions.tex ll. 17–46, 276–290 (read at source); at every `k`: E1 ll. 172–174 (S1) | printed at five; [hand], one mind, at `k` | verbatim in content |
| 1 | typical points, circle samplings, traces, palette | M/palettes.tex ll. 20–66 (read at source) | printed at five | verbatim in content |
| 2 | **Question 1** | C132-WIT-EX, D l. 1272 | verdict "stalls at", [hand], one mind | **verbatim**, with `Δ(p, q_j)` for `Δ({p, q_j})` and "weak measurable" as there |
| 2 | the counterexample form | (O), E5 ll. 511–513; D ll. 1285–1286 | open | translated |
| 2 | `k ≤ 5` empty; `k ≥ 7` holds for every colouring written down; six may be empty | C132-EXT-DISC's model line (D l. 470); C132-WIT-EX's model line (D l. 1279: "No model of its failure is known") | printed (Thm 1.4) / [hand] | restated |
| 2 | "the weaker statement with 'some point of the plane' … would serve … and we cannot prove that either" | **the writer's remark, not an entry**: every held proof of the conclusion is under finiteness in a disc, a margin, or connected pieces (D l. 1273) | — | flagged here; a reviewer may strike it |
| 2 | "the consequences … use the points `q_j` and nothing else" | C132-WIT-ORBIT's *uses only* and *not claimed* (D ll. 165–166) | derived from C132-M-ORBIT | restated |
| 3 (1a) | anchored form | C132-WIT-EX-FIN's conclusion less its transition-graph clause (D l. 575); "the anchored form beyond C132-WIT-EX-FIN" not claimed (D l. 1274) | open | translated |
| 3 (1b) | connected pieces; "reached" | E5 ll. 471–475, 492–494; C132-WIT-EX's *uses only* (D l. 1273) | open; the implication by C132-WIT-SUPER, [hand], one mind | translated |
| 3 (1c) | continua with no finiteness | C132-EXT-DISC's clauses (1), (3) (D l. 463) with its hypothesis dropped; its *not claimed* (D l. 465) | open | translated; clause (2) and the isolation clause left out, so (1c) is weaker than what attempt 1 was after |
| 3 (1d) | local finiteness of `𝓛` at six; true at five by Thm 6.5; false at seven; "countable" open | R ll. 581–583 ([L₆]); M/transitions.tex ll. 276–286; EXT-OAI2-SLACK7-L (R l. 1046); E1 ll. 341–345 | open; printed; [hand], one mind; a sketch | restated |
| 3 | measurable Grundy colouring (definition) | D l. 1134 (C132-GRUNDY7-NOT's statement); `plans/FS121-derivation.md` ll. 516–520 | definition | translated |
| 3 (2) | the Grundy class; nothing decided; the examples are not Grundy | (G2), E5 ll. 659–661; C132-GRUNDY7-NOT (D l. 1134); the front page's row ("for all colourings, or for honest ones?") | open; [hand], one mind | restated |
| 3 (3) | a cycle of length at least four | C132-LONG, D l. 1231 | verdict "stalls at", [hand], one mind | **verbatim**, with "the conclusion of P3" for "the conclusion of C132-EXT-DISC" |
| 4 | the Lean of [NFC] compiled here, its headline and the direction proper ⟹ weak on the three axioms; the manuscript read in full once, no gap found | `BIBLIOGRAPHY.md` l. 401; `plans/EXT-OAI1-audit.md`; R ll. 406–407, 668 | audited here; one mind, one pass | restated |
| 4, T1 | Theorem 1.3; the converse direction's proof; not in the Lean; in our library | R ll. 84–95, 672–674; `CLAUDE.md` l. 198 | printed; [kernel] here for `χ ≤ χ_m⁰` | restated |
| 4, T2 | Theorems 1.1, 1.4 | R ll. 74–82, 97–101 | printed | restated |
| 4, T3 | Lemma 4.3 | M/transfer.tex ll. 266–270 (read at source) | printed, every `k` | verbatim in content |
| 4, T4 | Lemma 7.2; its Lean form for every `k` | M/interfaces.tex ll. 96–105 (read at source); R l. 711 (`diskAverage_unit_pair {k}`) | printed at five; Lean statement read by text (R) | verbatim in content |
| 4, T5 | Proposition 7.1; uses Theorem 6.5 | M/interfaces.tex ll. 3–8, 31–51 (read at source) | printed at five | abridged, clause (2) as "a limiting direction" |
| 4, T6 | Lebesgue's covering theorem for the square; Lemma 7.5; the disc form | `Proofs/HadwigerNelson/Topology/LebesgueCovering.lean` ll. 296–299 (the statement, with its citation of [HW] Thm IV 2, p. 42; [kernel] here); M/interfaces.tex ll. 333–338 (read at source); E1 ll. 205–210 (S6) | classical (the book's page not opened by this job); printed; [hand], one mind | the disc form is marked ours |
| 4, T7 | the hexagonal seven-colouring and its two margins | M/introduction.tex ll. 123–135 (read at source) | printed | restated |
| 4 | [SV] Theorem 2 "states that no polygonal colouring … with six colours exists" | `BIBLIOGRAPHY.md` l. 128 (the row's reading of the held PDF) | printed; **not opened by this job** | reported from the bibliography row |
| 5, P1 | C132-WITNESS | D l. 362 | [hand], one mind | translated, at `U` the plane |
| 5, P2 | C132-CORES-FREE | D l. 525 | derived from C132-EXT-DISC, one mind | verbatim in content |
| 5, P3 | C132-EXT-DISC; its corollary; clause (5) against the manuscript's sentence | D ll. 463–465, 477–486; C132-WIT-EX-FIN (D l. 575); M/interfaces.tex l. 51 (read at source) | [hand], one mind; clause (5) unread by a second | verbatim in content |
| 5, P4 | C132-WIT-MARGIN | D l. 401 | [hand], one mind | translated |
| 5, P5 | C132-WIT-SUPER | D l. 443 | [hand], one mind | translated |
| 5, P6 | C132-WIT-CROSSED | D l. 426 | [hand], one mind | verbatim in content |
| 5, P7 | C132-WIT-SIDE; the triangle consequence | D l. 259; C132-WIT-STRIP's first clauses (D l. 280) | [hand], one mind | verbatim in content; the consequence abridged (the "at least two" rule left as "one of the two strips") |
| 5, P8 | C132-WIT-EXCL; its status; the instance | D ll. 214, 221 (the instance); D l. 131 (`SixRing.not_ae_outside_points`, "[kernel], for a Borel colouring of the whole plane", "Not kernel: the statement on an open set") | [kernel] at the whole plane for Borel colourings; [hand], one mind on an open set | restated as "the set of directions whose palette contains neither X nor Y has positive measure" (the negation of "for almost every e the palette contains X or Y") |
| 5, P9 | FS121-D3-GRUNDY | `plans/FS121-derivation.md` ll. 516–532 | [hand], two minds, the second blind | verbatim in content |
| 6, attempt 1 | route, step, statement, what is missing | E1 ll. 162–258 (S0–S11), 332–345 (§ Card 2); D ll. 464–465 | [hand], one mind; the countable case "a sketch … not a claim" | summarized |
| 6, attempt 2 | route; the chain R1–R6; strips; `Π_x`; the winding statement; (S2); the caution | E2 ll. 448–527; C132-TRI-STRIP (D l. 304); C132-RING-WIND (D l. 676); C132-RING-TAME (D ll. 1213–1217); C132-LONG's verdict (D l. 1235); Corollary 5.4 (M/palettes.tex l. 292; its Lean form R l. 704) | [hand], one mind each | (S2) is C132-RING-TAME translated; "[SV] Corollary 1" from C132-LONG's prior-art line (D l. 1239), not opened by this job and said so in the text |
| 6, attempt 3 | route, step, statement, what is missing | E5 ll. 485–521; C132-WIT-EX's verdict (D l. 1276) | [hand], one mind | the step quoted from the verdict line |
| 7, preamble | the distances 0.83 and "more than 1" | D l. 1156 (C132-GRUNDY7-LOCAL's *uses only*: 0.06, 0.83, 1.003); R ll. 1086–1088 | [hand], one mind | restated |
| 7, Ex. A | centres are the vertices; witnessed triangles by tiles and by room; points near a vertex that are no centres; `r = 1/2` | D l. 470; E5 ll. 439–445; control `margin-witness` (D ll. 419–422); the dated line E5 l. 424 ("at 1/2 no witness comes from a margin") | [hand], one mind, with a control | "P1 still applies at the vertices" at `r = 1/2` is **the writer's application of C132-WITNESS, not an entry** |
| 7, Ex. B | islands | R ll. 1045–1055, 1081–1092 | [hand], one mind | restated |
| 7, Ex. C | stripes | R ll. 1057–1067, 1094–1104 | [hand], one mind | restated |
| 7, Ex. D | dust | E5 ll. 503–509 | [hand], one mind; described there, not written by formula | restated, and marked "described" |
| 7, items 1–2 | local finiteness false at seven; clause (4) false at `v` | R l. 1046; E1 ll. 321–330; control `hex7-islands` (D ll. 506–510) | [hand], one mind | restated |
| 7, item 3 | a witnessed cycle does not locate a meeting point | C132-WIT-MARGIN's *not claimed* (D l. 403) | [hand], one mind | restated |
| 7, item 4 | anchored triangle, `Γ_p` a path | E5 ll. 544–553 ("Hand, one mind, no control") | as quoted | restated |
| 7, item 5 | six sectors 1, 2, 3, 1, 3, 2 | E1 ll. 305–313 ("hand, one mind, no control") | as quoted | restated |
| 7, item 6 | three-label palette; the two labels with no witness | R l. 1058; D ll. 437–440 (C132-WIT-CROSSED's correction) | [hand], one mind | restated |
| 7, items 7–8 | four sectors; dust | E5 ll. 496–509 | [hand], one mind | restated |
| 7, item 9 | the filled target | C132-NOESS (D l. 602), C132-FILL (D l. 590); E2 ll. 529–538 | [hand], one mind | restated |
| 7, item 10 | not Grundy; some output erases the room | C132-GRUNDY7-NOT (D l. 1134), C132-GRUNDY7-LOCAL (D l. 1156) | [hand], one mind | restated |
| 7, last paragraph | what a counterexample must look like | E5 ll. 513–519 | [hand], one mind | restated; the clause on connected one-label open sets is P1 read as a necessary condition (the writer's, one line) |
| 8 | what each answer would and would not imply | P7, P8, P9, T1, T2 as above; `CLAUDE.md` l. 259 ("the existence step of every road to seven through a point … nothing toward six"); R ll. 570–574 ("At six a triangle … is not locally contradictory") | readings and compositions; no entry | the writer's, from the statements named |
| 9 | not claimed; no literature search for the question | C132-WIT-EX's prior-art line (D l. 1280: "owed") | — | restated |

### 2.3 Left out, and why

- The side question under REG-J′ (D ll. 1342–1343; the stub's l. 91): it needs saturation, the singular set and REG-J′
  defined, and it is "a candidate, unchecked" that was never started.
- The honest *saturated* class and the top colour (FS-128): the outward text keeps one restricted class, the Grundy one,
  which is the one the record shows every colouring can be brought to.
- The reading that facing bands may bind each other in a Grundy colouring (E5 ll. 668–676): "not an entry; one mind",
  resting on a sentence its author had not read at source.
- C132-CORES-SQUARE (a gap), C132-TURN (not re-posed by its poser), the search's finite family, the kernel planner's
  routes: none is needed to state the question.
- The square form of the cover theorem in this library's kernel is used only as the source of T6's wording.

## Stage 2 — SAVED
