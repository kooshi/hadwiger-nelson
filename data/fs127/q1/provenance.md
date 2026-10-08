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
