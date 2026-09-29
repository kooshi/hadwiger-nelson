# FS116-Y1 — FS-116's construction side, round 1 (Y-SAT, Y-QRING)

*Job FS116-Y1 (Ephodos, Opus 5.5), 2026-09-29, from `data/fs116/briefs/FS116-Y1-construction.md` and `plans/STANDING-RULES.md` (both read in
full first). Working files `data/fs116/y1/`; exact checks `tools/fs116_y1_*.py`. Resuming check: no record, tool or report of this job existed at
start (`data/fs116/y1/` existed, empty). Every statement about a valid six-coloured fragment is about a possible object: at six colours the class
may be empty (the frozen list's preamble).*

*Notation.* The capped strip is FS112-YB2's rebuild of `[AxenovichEtAl2014]` Thm 4.2 with FS114-Y-DIAL's caps (`tools/fs112_yb2_objects.py`
`Strip`, read, never edited): midline vertices `P_j = (j/2, 0)`; arch `U_j` over `[j/2, (j+1)/2]` (vertical sides to `V_j = (j/2, √3/2)`,
`V_{j+1}`, top arcs of radius 1 about `P_{j+1}` from `V_j` to the apex `A_j = (j/2 + 1/4, √15/4)` and about `P_j` from `A_j` to `V_{j+1}`);
`D_j` its mirror in `y = 0`; top tile `T_m` over the valley `V_m`, `x ∈ [m/2 − 1/4, m/2 + 1/4]`, up to `Y = √3/2 + √15/4`, capped by the arc of
`ω(V_m)`; bottom tile `B_m` its mirror. Colours: `U_j` P, G, B (`j mod 3 = 0, 1, 2`); `D_j` M, R, O; `T_m` R, O, M; `B_m` G, B, P. `p = P_0`,
whose four tiles are `U_{−1}` (B, north-west), `U_0` (P, north-east), `D_{−1}` (O, south-west), `D_0` (M, south-east). `ω(u)` is the unit
circle about `u`; `e(ψ)` the unit vector at angle `ψ`.

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| FS116-Y1-QT | the brief's two block quotations are verbatim in `data/fs116/claims.md` § 7; the self-test's plants fire | [tools] | § 1.2; `tools/fs116_y1_quotes.py` |

## Would-have-searched-here log (standing rule 5)

- Stage 1: none (reading and recognition).

## Fence log (standing rule 8)

- None: my brief fences nothing. I write nothing about this job outside my record, `data/fs116/y1/`, `tools/fs116_y1_*.py` and my report.

## Stage 1 — SAVED: the readback, and recognition on each claim

### 1.1 Read from disk (reading status)

- My brief; `plans/STANDING-RULES.md`, in full; `data/fs116/claims.md`, in full; `plans/STUB-local-exclusion.md` to § What FS-114 established
  (the card, both forms, the bearing); `plans/FS116-local-exclusion.md` § 4.1–4.7 (SATPIN and its argument, the routes, the stages, P1–P3, the
  failure clauses); `plans/FS114-Y-construction.md` § 1.3–2.4 (calibration, the dial, STRIPK6, STRIPRIGID, DISKRIGID, the torus families);
  `plans/FS114-Y2-construction.md` header to § 1a.2; `data/fs114/fs114-y6/survey.out` (the strip's, the disk's and the bowtie's vertex survey);
  `plans/FS111-derivation.md` round 1 (M-SATC to M-C11, W-NOBEND, W-NOREP, W-SQ9, W-HEX9, W-KB-DIR, W-LADDER, W-HEXSAT, W-FILL-FREE,
  W-HEX7-RIGID, W-DECO-B), and VM2-STRIP-MID, M4-LADDER, M4-CUT; the headers of `tools/fs112_yb2_objects.py`, `tools/fs112_yb2_check.py`,
  `tools/fs114_yb_exact.py`, `tools/fs114_y2_k1.py` and the function list of `tools/fs114_yb_run.py` (read-only; imported, never edited).
- The grokkings are in my context at launch (G82–G86 read for this job).

### 1.2 Readback (standing rule 3)

`tools/fs116_y1_quotes.py` (`data/fs116/y1/quotes.out`): **2 of 2 FOUND** — the brief's block quotations of Y-SAT and Y-QRING, verbatim in
`data/fs116/claims.md` § 7. Self-test PASS (`quotes-selftest.out`: an altered word MISSING, the faithful twin FOUND, the faithful quotation against
the wrong file MISSING). The brief's unquoted sentences agree with their sources: its list of controls is § 9's; "does the capped strip's midline
configuration survive saturation?" is a fair gloss of P1 (`plans/FS116-local-exclusion.md` § 4.5); G83's killing test is "a valid fragment by
formula about such a vertex beyond `φ²/√2`", "such a vertex" being a four-colour vertex whose ring carries (Q) arcs. **No mismatch.**

derivation: FS116-Y1-QT
  statement: the brief's two block quotations (Y-SAT, Y-QRING) are verbatim in data/fs116/claims.md § 7, whitespace aside
  uses only: the brief's text and the claim list's text; whitespace and the brief's quotation prefixes normalised, nothing else
  not claimed: that the brief's unquoted glosses are verbatim (they are paraphrases, checked by reading and recorded above)
  argument: § 1.2 Readback (standing rule 3)
  verdict: derived
  grade: computed over: the set {Y-SAT, Y-QRING} of the brief's block quotations
  minds: 1
  model: the quotation of Y-SAT, found at claims.md § 7
  prior art: known: data/fs116/claims.md § 7 (the source the quotations are checked against)
  handoff: none — a readback, not mathematics

control: fs116-y1-qt
  of: FS116-Y1-QT — every block quotation found at its source; against the wrong file none is
  run: python3 ../tools/fs116_y1_quotes.py | tail -1
  expect: quotations: 2, all found: True
  fault: python3 ../tools/fs116_y1_quotes.py --source plans/STANDING-RULES.md | tail -1

My claims, restated beside the quotations (the quotations govern):
- **Y-SAT**: "a valid fragment on `B̄(p, R)`, saturated on `B̄(p, R − 1)`, about a vertex `p` of at least four colours, for the largest `R`
  reached (first: the capped strip made saturated at its midline, which decides SAT-STRIP from the other side) — or a derived obstruction at a named
  radius." — build, by formula and checked exactly, a six-coloured fragment whose boundary points within `R − 1` of a four-colour vertex all have
  their partners, and push `R`; or derive the radius at which that fails.
- **Y-QRING**: "a valid fragment on a closed disc of radius above `φ²/√2` about a vertex of at least four colours whose ring carries a (Q) arc — or a
  derived obstruction at a named radius." — beat the capped strip's dial with a (Q)-ring vertex, or derive why not.

### 1.3 Recognition — Y-SAT (`ephodos-recognition`, invoked fresh)

**The stall it starts from.** None yet in this job; the plan's framing is "saturate the capped strip at its midline". The skill's first
question is what determines the answer and what only accompanies it.

**For a stranger** (a combinatorial geometer who works on colourings of the plane avoiding distance 1, and, second, a graph theorist):
*Partition a disc of radius `R` into finitely many regions bounded by segments and circular arcs, each given one of six colours, so that no two
interior points of one colour are exactly 1 apart. Require, on the concentric disc of radius `R − 1`, that every boundary point `x` be at distance
exactly 1 from the closure of each colour that has positive density at `x`. The centre must be a point where at least four regions meet. How large
can `R` be?* In the graph theorist's words: a colouring of the unit-distance graph in which every colour class is, at each point of its boundary
inside the inner disc, a **maximal** independent set (no boundary point can be moved into a neighbouring class) — the continuous, local form of a
**fall colouring** (each class independent and dominating; `CLAUDE.md` G84 already calls maximal partitions "measurable fall colourings").

**Words the reader would stop at.** "Capped strip", "(Q)", "tactic" — costume: struck. "Saturated" — defined above from the reader's primitives.
"Essential multicolour" — defined (positive density), and it matters: a cusp's colour needs no partner.

**"This is a …"**: a local fall colouring of the unit-distance graph by six regular classes, maximal on an inner disc — and, at a straight edge,
M-PINCH's tangent case makes it a **ladder** (W-LADDER): the edge's unit translates carry the far side's colour. So the question is how far the
first rung of every ladder rooted in the inner disc can be placed without colliding with the colours the rest of the fragment is forced to carry.

**Features, sorted.**

| feature | sort | receipt |
|---|---|---|
| saturation required only on `B̄(p, R − 1)` | determines | for `R − 1 < 1/2` the only boundary in the inner disc about a strip midline vertex is `p`'s four edges (the next vertices are at `1/2`, `√3/2`); the demand is four rungs, at `(0, ±1)`, `(±1, 0)` |
| the tangent type of a straight edge (partners one unit along the normal, the near side's colour across) | determines | SATPIN (tangent); M-PINCH consumes it |
| the arches `U_{−2}, U_{−1}, U_0, D_{−2}, D_{−1}, D_0` near `p` | determines | they block five colours on the wedge above `V_{−1}` (the sixth, `D_0`'s colour M, is forced there) — derived in stage 2; the same wedge is at distance `< 1` from the rung `(x, 1)` only while `x < √(√3 − 3/4) − 1/2` |
| the caps, the tiles `T_m` above `y ≈ 1`, the periodicity, the tiles beyond `R` | accompanies | the rung demand and the forced wedge colours use none of them; they are free to be trimmed or recoloured inside the disc |
| six colours (not seven) | determines | at `k = 9` SQ9 is saturated everywhere; the forced-wedge argument counts five blocked colours |
| orthogonality of `p`'s edges | unsorted | SAT-STRIP is stated for any four segments; the strip's are orthogonal |

**Homes, each with its dictionary and its test.**
1. *Graph theory: fall colourings / idomatic partitions* (Dunbar–Hedetniemi–et al., 2000; Cockayne–Hedetniemi's idomatic number, recalled, not
   read). Dictionary: class ↔ colour class; dominating ↔ every point at distance 1 from each class; "local" has no counterpart (the graph notion is
   global and ignores topology: saturation asks domination only by the classes present at a boundary point). Test: the home's theorems (degree
   bounds `k ≤ δ + 1`) are vacuous on an infinite-degree graph; **it predicts nothing here** — a costume, recorded and dropped.
2. *Mathematical morphology* (the unit-circle dilation; the shadow identity `int F = ℝ² ∖ (F + S¹)`, FS111-M-SATC; rolling balls). Test: it
   decides the local edge types (SATPIN, C11) and nothing about existence. Held; it supplies the ladder.
3. *The project's own theory*: FS114-Y-STRIPRIGID (the strip's colouring is forced by its arches), W-LADDER, SATPIN. Test: the old proofs apply at
   once — the rigidity argument, run on the wedge above a valley with only the arches kept, forces that wedge's colour; the ladder's first rung
   then collides with it at a computable abscissa. **It predicts a neighbour**: the same collision bounds every fragment keeping the arches, not
   only the capped strip. This is the home adopted.

**The recognition, and where it differs from the plan.** "The capped strip made saturated at its midline" is not the question: saturating the
whole midline is impossible for **every** fragment that keeps the strip's arches near `p` (stage 2 derives it), while saturating a small disc about
one midline vertex is four rungs and nearly free. So Y-SAT in the strip family is a **dial** in `R − 1` with a derived ceiling, and SAT-STRIP at
`R = 2` can be decided from the construction side only by a geometry that does not keep the arches within about 1.5 of `p`. Reported to Keryx as
a finding about the plan's framing (not a defect of the claim).

### 1.4 Recognition — Y-QRING

**For a stranger** (the same geometer; the question is Mixon's thread-7 question restricted): *what is the largest radius of a disc about a point
where four colours meet, one region of which is bounded by an arc of the unit circle about that point with both of that arc's side colours present
at the point, that admits a valid six-colouring by segment-and-arc regions?* The record holders: the capped strip about its midline vertices
(radius `< φ²/√2`, not attained, FS114-Y-DIAL; its midline rings carry four (Q) arcs, the arches' top arcs about `p`) and the disk's corners (`φ`,
attained, FS112-DISC).

**Features, sorted.** The dial of the capped strip is set by the notch `Q_0 = (1/4, Y)` between two caps, at distance exactly `φ²/√2` from `p`
(determines, FS114-Y-DIAL); above `Q_0` the arch colours P, G, B are blocked by `U_{−1}, U_0, U_1` alone (determines — they straddle every point
near `Q_0`: stage 3 records the exact distances); what blocks R and O above `Q_0` is `T_0` and `T_1` **reaching the notch** while their valley wedges
sit at distance exactly 1 from it (unsorted: the valley wedges are forced, the tiles' upper parts are not). So the notch is forced by the caps'
design together with the forced wedges, and whether a redesign of the upper region can colour it is the open feature.

**Homes.** (1) Mixon's question and the literature's 6-coloured discs (`[Polymath2021]` Fig. 10's disk, radius `≈ 2.1246`, the record held here):
the disk's four-colour vertices are its central Reuleaux pentagon's corners, `0.5257` from its centre, so containment gives only `≈ 1.599` about
them (FS112-DISC's `φ` uses the design beyond the rim); FS114-Y-DISKRIGID makes its geometry rigid. (2) The strip family with its upper region
redesigned. (3) No third home found that holds (Q)-ring vertices; a new skeleton is the honest remaining family. Worked in stage 3.

**G87 lookout, stage 1:** none seen.

## Stage 1 — SAVED
