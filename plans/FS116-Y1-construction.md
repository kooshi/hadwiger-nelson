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
| **FS116-Y1-F15** | **Y-SAT positive**: a valid six-coloured fragment by formula on `B̄(P_0, 6/5)`, saturated on `B̄(P_0, 1/5)`, about the capped strip's midline vertex (degree 4, four colours, four straight edges, four (Q) arcs on its ring) | [tools, exact; one mind] | § 2.1; `tools/fs116_y1_sat.py` |
| **FS116-Y1-NOTCH** | Y-QRING's strip family: with the capped strip's arches kept, the notch next to each top stop point `Q_0`, `Q_{−1}` is forced to one colour (`D_0`'s, `D_{−1}`'s) — the one the strip's columns block; so a positive beyond `φ²/√2` must split the columns along the unit circles about the notches | [hand; one mind; its facts tools-exact] | § 3.2; `tools/fs116_y1_notch.py` |
| **FS116-Y1-STRIPCEIL** | every fragment agreeing with the capped strip on `B(P_0, 1)` and saturated on `B̄(P_0, R − 1)` has `R − 1 < √(√3 − 3/4) − 1/2 ≈ 0.491`: the strip cannot be saturated along its midline, and cannot decide SAT-STRIP | [hand; one mind; its numerical facts tools-exact] | § 2.2; `tools/fs116_y1_ceil.py` |

## Would-have-searched-here log (standing rule 5)

- Stage 1: none (reading and recognition).
- Stage 2: (a) I would have searched the band above the arches for colourings reaching a larger `r`; instead the ceiling was derived first
  (FS116-Y1-STRIPCEIL), which bounds every such search in the family. (b) I would have scanned witness points for the blocking fact; instead the two
  failing witnesses were re-placed by the hand argument's own condition (§ 2.2).
- Stage 3: I would have searched partitions of the upper band into the three column colours for one that fills the notches; instead the notch colours
  were derived (FS116-Y1-NOTCH) and the cascade stated as the family's open problem.

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

## Stage 2 — SAVED: Y-SAT — a saturated fragment to `R = 6/5`, and the ceiling of the strip family

### 2.0 Registered before any run of `tools/fs116_y1_sat.py` (2026-09-29)

- **controls** — `sq9` (k = 9, patch `|i|, |j| ≤ 5`): validity ACCEPT, saturation on `B̄(p, 1)` CERTIFIED; `r7` (k = 7, patch `|a|, |b| ≤ 2`):
  validity ACCEPT, saturation on `B̄(p, 1/2)` CERTIFIED by the split type (each arc about a lattice point that is a corner of an up tile of one side
  colour and a cusp of a down tile of the other); `strip` (the capped strip about `P_0`): no contact at `(1/4, 0)` for P nor for M, none at
  `(1/10, 0)` for M, a contact at `p` for M (the corner `A_{−1}` of `T_{−1}`), and the certificate on `B̄(p, 1/5)` NOT CERTIFIED.
- **the object `F(1/5)`** (`R = 6/5`): validity ACCEPT, map consistent with one closed rim chain, no rim piece within `6/5` of `p`, `p` a corner of
  exactly `U_{−1}, U_0, D_{−1}, D_0` (colours B, P, O, M), saturation on `B̄(p, 1/5)` CERTIFIED (four radial pieces), and contacts at `(±1/10, 0)`,
  `(0, ±1/10)` for both side colours.
- **plants** — `lift` (M* raised by `1/20`): validity ACCEPT, certificate NOT CERTIFIED at `[p, (1/5, 0)]` (M partner not found), no M contact at
  `(1/10, 0)`; `wide` (M* widened to `[0, 1/2]`): validity REJECT at exactly `(M*, T-1)`; `swap` (M* and O* colours exchanged, and their mirrors):
  validity ACCEPT (every new same-colour pair meets at a single tight corner or lies within distance `< 1`), certificate NOT CERTIFIED (partners of
  the wrong colour). *(The tool's header first guessed that `swap` REJECTs; corrected here, before the run, by computing its pairs: the header is
  corrected to match.)*

### 2.1 The runs, scored against 2.0

- **controls** (`data/fs116/y1/sat-controls.out`): `sq9` validity ACCEPT (405 same-colour pairs; 81 examined, 324 dismissed by an exact gap `≥ 1`),
  saturation on `B̄(p, 1)` CERTIFIED (36 pieces, each partner the edge of the square three over); `r7` validity ACCEPT (214 pairs), saturation on
  `B̄(p, 1/2)` CERTIFIED by the split type (6 arcs); `strip` no contact at `(1/4, 0)` for P or M, none at `(1/10, 0)` for M, a contact at `p` for M,
  certificate NOT CERTIFIED — **as registered**, one miss in wording: the tool names `D_{−3}` (its corner `P_{−2}` at distance 1) as the M contact at
  `p`, not `A_{−1}`; both are contacts. *First run:* the `sq9` patch was built with `|i|, |j| ≤ 4`, too small for the partners of the rim-most pieces
  (at `x = ±2.5`); the certificate failed there, the registration said `≤ 5`, and the rerun at `≤ 5` is the recorded one. The small patch is now the
  certifier's own plant (`--sq9n 4`).
- **`F(1/5)`** (`sat-F1_5.out`): **ALL HOLD** — validity ACCEPT (52 same-colour pairs, 38 examined exactly, 14 dismissed; 12 tight maxima, 12 tight
  minima), map consistent (116 pieces, 32 rim pieces forming one closed chain), no rim piece within `6/5` of `p`, `p` a corner of exactly `U_{−1}, D_{−1},
  U_0, D_0` (B, O, P, M), saturation on `B̄(p, 1/5)` CERTIFIED: `[p, (±1/5, 0)]` by partners on `M*`, `β*` and `O*`, `α*`; `[p, (0, ±1/5)]` by partners on
  the sides of `U_2`, `U_{−3}`, `D_2`, `D_{−3}`. Contacts at the four named points, both colours each. **As registered.**
- **plants**: `lift` — validity ACCEPT, certificate NOT CERTIFIED at `[p, (1/5, 0)]` ("side D0 (M): partner segment (0,1)->(0.2,1) NOT FOUND"), no M
  contact at `(1/10, 0)`; `wide` — validity REJECT at exactly `(T-1, M*)`; `swap` — validity ACCEPT, certificate NOT CERTIFIED at both horizontal
  pieces. **All three as registered** (`sat-F1_5-plant-*.out`).

derivation: FS116-Y1-F15
  statement: F(1/5) — the capped strip's arches U_j, D_j (j = −3..2), its top and bottom tiles over V_{−1}, V_0, V_1 trimmed at |y| = 5/4, with the
    partner tiles M* = [0, 1/5] × [1, 5/4] (colour of D_0), O* = [−1/5, 0] × [1, 5/4] (colour of D_{−1}) and their mirrors β* (colour of U_0), α*
    (colour of U_{−1}) cut from the tiles over V_0 and V′_0 — is a valid six-coloured fragment on B̄(P_0, 6/5), saturated on B̄(P_0, 1/5), and P_0 is a
    degree-4 vertex of four colours whose four edges are segments and whose ring carries four (Q) arcs
  uses only: exact arithmetic in Q(√3, √5) on the 22 tiles; FS114-YB's exact pair checker for validity; the tangent-type certificate (each piece of
    the map within 1/5 of P_0 has, for each side tile, its unit translate away from that tile on a segment piece of a tile of the side tile's colour)
  not claimed: saturation beyond B̄(P_0, 1/5); that the fragment extends to a larger disc; SAT-STRIP either way (its saturation disc is B̄(p, 1))
  argument: § 2.1 The runs, scored against 2.0
  verdict: derived
  grade: computed over: the 52 same-colour tile pairs of F(1/5) and its 4 pieces within 1/5 of P_0
  minds: 1
  model: F(1/5) itself; its four (Q) arcs are the top arcs of U_{−1}, U_0 and the bottom arcs of D_{−1}, D_0 about P_0, whose outer tiles (over
    V_{−1}, V_1, V′_{−1}, V′_1) carry colours present at P_0
  prior art: new — "unit distance & (saturat* | maximal) & colo*" (0), "chromatic & plane & (measurable | map) & (tight | saturat* | maximal)" (7)
  handoff: none — a fragment by formula checked exactly; it proves no value and the kernel lane holds no fragment checker; its exact certificate is
    the tool

control: fs116-y1-f15
  of: FS116-Y1-F15 — the object holds every check; with M* lifted by 1/20 the saturation certificate fails at [p, (1/5, 0)]
  run: python3 ../tools/fs116_y1_sat.py object 1 5 | grep '=> F'
  expect: => F(1/5): ALL HOLD
  fault: python3 ../tools/fs116_y1_sat.py object 1 5 --plant lift | grep '=> F'

control: fs116-y1-satcert
  of: FS116-Y1-F15 — the certifier's controls: SQ9 and R7 certified, the capped strip refused at its midline; with SQ9's patch too small it misreads
  run: python3 ../tools/fs116_y1_sat.py controls | tail -1
  expect: CONTROLS ALL AS KNOWN
  fault: python3 ../tools/fs116_y1_sat.py controls --sq9n 4 | tail -1

*Prior-art note for both entries of this stage:* the two queries were run in FS-111's gate (`plans/FS111-derivation.md`, Q1) and are recalled from that
file, not rerun here; this job ran no search of its own (standing rule 5's ban does not bear; the prior-art debt is listed in the report).

### 2.2 The ceiling of the strip family (FS116-Y1-STRIPCEIL)

**The recognition's prediction, derived.** Let `F` be a valid six-coloured fragment on `B̄(P_0, R)` whose tiles, restricted to the open unit disc
`B(P_0, 1)`, are the capped strip's there, coloured as there up to a permutation of the six colours; suppose `F` is saturated on `B̄(P_0, r)`, `r = R − 1`,
and `r ≥ x* := √(√3 − 3/4) − 1/2 ≈ 0.49099`. Write `M` for `D_0`'s colour.

*Step 1: the wedge above `V_{−1}` is `M`.* `V_{−1} = (−1/2, √3/2)` is on `ω(P_0)`, so `F`'s domain holds a disc about it. Let `W` be its points within
`t₀` of `V_{−1}` outside both closed unit discs about `P_{−2}` and `P_0` — the wedge of directions `(30°, 150°)` at `V_{−1}` between `U_{−2}` and `U_{−1}`.
For `z ∈ W` off `Γ`, each of `U_{−2}, U_{−1}, U_0, D_{−2}, D_{−1}` has interior points **inside `B(P_0, 1)`** at distance `< 1` from `z` (near `V_{−1}`,
`V_{−1}`, `V_0`, `P_{−1}`, `P_{−1}`) and `> 1` (near `P_{−2}` and `P_0` — strictly, because `z` is outside their unit circles; near `P_1`, near
`(−9/10, −4/10)`, near `(−1/10, −9/10)`); a tile's interior is connected, so each has an interior point at distance exactly 1 from `z`, and `z` has
none of those five colours. So every tile meeting `W` is `M`. (Exact at `z = V_{−1} + (0, 1/100)` with named witnesses: fact (1).)

*Step 2: the `M` partner of `(x, 0)`, `0 < x < 1/2`, is `(x, 1)`.* `(x, 0)` lies on the edge `U_0 | D_0`, so saturation (when `x ≤ r`) gives `y_x ∈ supp M`
with `|y_x − (x, 0)| = 1`, in the closure of an `M`-tile `T′`. Let `D̃` be `F`'s tile containing `D_0`. `D̃` has diameter `≤ 1` (validity against
itself), so `D̃ ⊂ B̄(P_0, 1) ∩ B̄(P_1, 1)`, a lens in which every point is at distance `< 1` from `(x, 0)` (strict convexity of the norm along
`P_0P_1`); so `y_x ∉ cl D̃` and `T′ ≠ D̃`. The distances between `D̃°` and `T′°` form an interval (a connected set) avoiding 1 whose closure holds 1; the
same lens shows they are not all `≤ 1`; so all are `≥ 1`, `dist(y_x, D̃) = 1 = |y_x − (x, 0)|`, `(x, 0)` is a nearest point of `D̃` to `y_x`, and since it
is interior to `D̃`'s straight top edge, `y_x = (x, 1)`, the outward normal. `T′` lies at distance `≥ 1` from `D_0`, hence in `y ≥ 1` near `(x, 1)`.
(Fact (2): `D_0` within `< 1` of `(1/4, 0)` and `(1/100, 0)`, exactly.)

*Step 3: the collision.* `|V_{−1} − (x*, 1)| = 1` exactly (fact (3)); the direction from `V_{−1}` to `(x*, 1)` is `φ₀ ≈ 7.7°`. Since `x* ≤ r`, the points
`(x, 1)`, `x ∈ (x* − ε, x*)`, lie in `supp M` from above; by local finiteness one `M`-tile `T` has the segment `(x* − ε, x*) × {1}` on its boundary and holds
the points `(x* − σ, 1 + η)` for small `σ` and `0 < η ≤ σ²`. The directions `(97.7°, 150°)` at `V_{−1}` lie in `W` and are covered by finitely many
sectors of positive angle of `M`-tiles (step 1); let `S` hold `V_{−1} + ρe(ψ)` for `ψ` in an open interval `J ⊂ (97.7°, 150°)` and small `ρ`. Then
`|s − t|² = 1 − 2ρ cos(ψ − φ₀) − 2σ cos φ₀ + 2η sin φ₀ + O(ρ² + σ²)`, and `cos(ψ − φ₀) < 0` on `J`: `σ → 0` gives `|s − t| > 1`, `ρ → 0` gives
`|s − t| < 1`. `S° × T°` is connected, so two interior points of colour `M` are at distance exactly 1 — `F` is not valid. ∎

derivation: FS116-Y1-STRIPCEIL
  statement: if a valid six-coloured fragment on B̄(P_0, R) agrees with the capped strip on the open unit disc about its midline vertex P_0 (tiles, and
    colours up to a permutation) and is saturated on B̄(P_0, R − 1), then R − 1 < √(√3 − 3/4) − 1/2 ≈ 0.49099; in particular no such fragment is
    saturated at every point of a midline edge at P_0
  uses only: the wedge W above V_{−1} lies outside U_{−2} and U_{−1} and five of the strip's tiles straddle each of its points through their parts inside
    B(P_0, 1) (so W is coloured M, the sixth colour); a tile has diameter at most 1; D_0 lies in the lens B̄(P_0, 1) ∩ B̄(P_1, 1), every point of which is
    within distance < 1 of (x, 0) for 0 < x < 1/2, and D_0's top edge is straight, so the M partner of (x, 0) is (x, 1); |V_{−1} − (x*, 1)| = 1; local
    finiteness of the map at V_{−1} and at (x*, 1); no count of colours beyond six, and none of SATPIN, M-PINCH, FS121-D1-VT or EROSION
  not claimed: that any R − 1 between 1/5 (FS116-Y1-F15) and x* is attained; anything for fragments that change the strip inside B(P_0, 1); SAT-STRIP
    (saturation on B̄(p, 1) about any degree-4 four-colour vertex with four straight edges); anything at k ≥ 7 (with a seventh colour W need not be M)
  argument: § 2.2 The ceiling of the strip family (FS116-Y1-STRIPCEIL)
  verdict: derived
  grade: hand
  minds: 1
  model: F(1/5) (FS116-Y1-F15): R − 1 = 1/5 < x*; its wedge above V_{−1} is the tile over V_{−1}, coloured M, and its M* ends at x = 1/5, where
    |V_{−1} − (1/5, 1)| < 1
  prior art: new — "unit distance & (saturat* | maximal) & colo*" (0), "chromatic & plane & (measurable | map) & (tight | saturat* | maximal)" (7)
  handoff: none — a no-go for one family of fragments, bearing on which positive the construction side may build; it enters no proof of a value

control: fs116-y1-stripceil
  of: FS116-Y1-STRIPCEIL — the exact facts (1)–(4) at named points; with the wedge point moved below V_{−1} fact (1) fails
  run: python3 ../tools/fs116_y1_ceil.py | tail -1
  expect: => ALL HOLD
  fault: python3 ../tools/fs116_y1_ceil.py --plant inside | tail -1

*The facts' first run* (recorded, G21): two of the five blocking witnesses were first placed at `(−99/100, 1/100)` and `(−1/100, 1/100)`, at distance
`< 1` from `z` — the hand argument's own caveat (a witness near `P_{−2}` must sit within `|z − P_{−2}| − 1` of it, in a direction that does not shorten the
distance by more); moved to height `1/1000`, both fire. The instrument caught the witnesses, not the lemma.

**What it says.** "The capped strip made saturated at its midline" is impossible for every fragment keeping the strip inside the unit disc about a
midline vertex: the first rung of the midline's ladder collides, at abscissa `x*`, with the colour the arches force above the next valley. FS116-Y1-F15
reaches `r = 1/5` in that family; the family's supremum lies in `[1/5, x*)`. SAT-STRIP asks `r = 1` — so **the strip cannot decide SAT-STRIP from the
construction side**, and a positive there needs a geometry that differs from the strip inside the unit disc. P1 is not scored by this job: neither
TRUE nor FALSE follows.

### 2.3 The families tried for SAT-STRIP's configuration at `r = 1` (the plan's stop rule)

| family | its free parameters | the configuration's demands at `r = 1` | verdict |
|---|---|---|---|
| **S1** fragments agreeing with the capped strip on `B(P_0, 1)` | everything outside the unit disc | the rung `(x, 1)`, `x ∈ (0, 1]`, of both midline edges; the four axis points of the ring | **dead at `r ≥ x* ≈ 0.491`** (FS116-Y1-STRIPCEIL); alive at `r = 1/5` (FS116-Y1-F15) |
| **S2** tilings of the disc by axis-parallel squares of side `1/2`, `p` a grid point (SQ9's geometry) | the colouring | the nine squares of the `3 × 3` block about `p` pairwise straddle distance 1 (index offsets at most 2: minimum `< 1`, maximum `> 1`) | **dead at six colours for validity alone** (it needs nine: FS111-W-SQ9) |
| **S3** square grids of side `s ≠ 1/2` | `s`, the colouring | a tangent edge's rung lies on a grid line only if `1/s ∈ ℤ`; `s = 1` has diameter `√2 > 1`; `s = 1/n`, `n ≥ 3`, has a larger block of pairwise straddling squares | **dead** (hand) |

No third family with a free parameter that meets the demands was found: **SAT-STRIP is not decided from the construction side in this round**. The next
positive to try is a geometry whose midline does not run straight through the unit disc (FS121-D1-EROSION, below, points the same way).

### 2.4 FS121-D1's two lemmas, read at their source on Keryx's message (`plans/FS121-D1-proof.md` § 2.1–2.2)

- **FS121-D1-EROSION** at `P_0`: every sector at `P_0` has `θ = π/2`, `cot(θ/2) = 1`; the four tiles' maximal straight pieces at `P_0` have lengths `1/2`
  (midline) and `√3/2` (vertical sides), so `min(L₁, L₂) = 1/2 ≤ 1`: **met**, by the strip and by F(1/5) alike. In a saturated fragment with `r = 1` about
  such a vertex, a midline edge running straight past `x = 1` together with a vertical side past `y = 1` would need a point of `Σ` at distance 1 on each —
  the same direction as § 2.3's conclusion.
- **FS121-D1-VT** on F(1/5): the images of the saturated edges' interior points, `(s, ±1)` and `(±1, ±s)` for `0 < s < 1/5`, carry no arc ending from the
  far side (M*, O*, α*, β* are rectangles whose near sides are single pieces; `U_2`, `U_{−3}`, `D_2`, `D_{−3}` have no vertex on their sides below height
  `√3/2`): **met**. At `(±1/5, ±1)` an arc does end (the rectangles' sides); these are images of the saturation disc's boundary points, which VT excludes
  ("not claimed: anything at the image of an endpoint of I").
- **Carrying them to fragments.** Both lemmas are stated for colourings of the plane; their proofs apply FS111-W-NOREP at the image `Y`, one unit from the
  saturated edge, so they transfer to a fragment saturated on `B̄(p, r)` only where saturation holds at and near `Y` — for `r < 1/2` nowhere, since `Y` is
  at distance about 1 from `p`. What transfers without them is VT's step (i), the partner's location, which § 2.2's step 2 re-derives directly for the
  strip's edge. Neither lemma is used by FS116-Y1-STRIPCEIL.

**G87 lookout, stage 2:** none seen.

## Stage 2 — SAVED

## Stage 3 — SAVED: Y-QRING — not landed; the strip family's notch colours are forced

### 3.1 Registered before the run of `tools/fs116_y1_notch.py`

The facts (1)–(4) of the tool's header hold (ALL HOLD); the plant `high` (notch points raised to `Y + 1/20`) makes fact (3) fail for `U_1` and `U_{−1}`
at `Q_0` and their mirrors at `Q_{−1}`. *Scored:* both as registered (`data/fs116/y1/notch.out`, `notch-plant-high.out`). *First draft of the tool:* the
near witnesses of `U_1`, `U_{−1}` were first put at the valleys `V_1`, `V_0`, at distance `1.007 > 1` from the notch point; the nearest points of those
arches are on their top arcs facing the notch (`0.98` away), and the witnesses were placed there before the first run, by that computation.

### 3.2 The forced notch colours (FS116-Y1-NOTCH)

*Argument.* Let `F` be a valid six-coloured fragment on `B̄(P_0, R)`, `R ≥ φ²/√2`, whose tiles include the capped strip's arches `U_{−2}, …, U_1` and
`D_{−2}, …, D_1` (all inside `B̄(P_0, 3/2)`), coloured as in the strip up to a permutation. The stop points `Q_0 = (1/4, Y)`, `Q_{−1} = (−1/4, Y)` are at
distance `φ²/√2` from `P_0`, so `F`'s domain holds a disc about each. (a) *The valley wedges.* The wedges above `V_{−1}`, `V_0`, `V_1` (directions `(30°, 150°)`
between two arches) are coloured M, R, O respectively: at `V_{−1}` by FS116-Y1-STRIPCEIL's step 1; at `V_0` the same argument with `U_{−1}, U_0` adjacent,
`U_1` (through `V_1` and `P_2`), `D_{−1}` and `D_0` (through `P_0`) blocking G, B, P, O, M; at `V_1` with `U_0, U_1` adjacent, `U_{−1}` (through `V_0` and
`P_{−1}`), `D_0` and `D_1` (through `P_1`) blocking P, G, B, M, R. (b) *The notch at `Q_0`.* Points `n` near `Q_0` in the cone `(arcsin ¼, 180° − arcsin ¼)`
(the colourless cone of FS112-EDGE, bounded by the tangents at `Q_0` of `ω(V_0)` and `ω(V_1)`), at height below `≈ 1.854`, are straddled by `U_0` (P),
`U_1` (G) and `U_{−1}` (B) (fact (3): `U_1`'s and `U_{−1}`'s top arcs pass within `0.99` of `n`, their bottom corners more than 1 away). `|Q_0 − V_0| = 1`
exactly (fact (1)), and the direction `u` from `V_0` to `Q_0` lies within `90°` of every wedge direction at `V_0` and of every cone direction at `Q_0`
(fact (2)); so for an R-tile `S` meeting the wedge at `V_0` (a sector of positive angle at `V_0`) and a tile `N` meeting the cone at `Q_0` (a sector of
positive angle there), `|s − n|² = 1 − 2ρ⟨u, e(ψ)⟩ + 2σ⟨u, e(χ)⟩ + O(ρ² + σ²)` takes values below 1 (`σ → 0`) and above 1 (`ρ → 0`): `N` is not R. The
same with `V_1` (`|Q_0 − V_1| = 1`): `N` is not O. Five colours excluded, `N` is M. (c) *At `Q_{−1}`*, by the mirror `x ↦ −x` of the argument (arches
`U_{−1}, U_0, U_{−2}`; wedges at `V_{−1}` (M) and `V_0` (R)): the notch is O. ∎

derivation: FS116-Y1-NOTCH
  statement: in a valid six-coloured fragment on B̄(P_0, R), R ≥ φ²/√2, whose tiles include the capped strip's arches U_{−2}, …, U_1 and D_{−2}, …, D_1
    with the strip's colours up to a permutation, every tile meeting the cone (arcsin ¼, 180° − arcsin ¼) at the stop point Q_0 = (1/4, Y), near Q_0
    and below height 1.85, has D_0's colour, and every tile meeting the mirror cone at Q_{−1} = (−1/4, Y) has D_{−1}'s colour
  uses only: the valley wedges' forced colours (the argument of FS116-Y1-STRIPCEIL step 1 at V_{−1}, V_0, V_1); the three arches' straddles at the
    notch points; |Q_0 − V_0| = |Q_0 − V_1| = |Q_{−1} − V_{−1}| = |Q_{−1} − V_0| = 1 with every wedge and cone direction within 90° of the joining
    direction; local finiteness at the valleys and at the notch; nothing about the tiles above the arches
  not claimed: that a tile of that colour can be placed in the notch (the capped strip's columns over V_{−1} and V_2 straddle it); anything above height
    about 1.854, where U_{±1}'s top arcs pass distance 1 and the arch colours can return; any fragment that changes an arch; anything at k ≥ 7
  argument: § 3.2 The forced notch colours (FS116-Y1-NOTCH)
  verdict: derived
  grade: hand
  minds: 1
  model: the capped strip itself: its notch at Q_0 is colourless (FS112-EDGE), because the column tiles over V_{−1} and V_2 (colour M) reach within 1 of
    Q_0 while their valleys are at distance √(3/2) > 1 from it — the forced colour is the one the columns block
  prior art: new — "unit distance & (saturat* | maximal) & colo*" (0), "chromatic & plane & (measurable | map) & (tight | saturat* | maximal)" (7); the
    strip's stop point is FS112-EDGE's, the forced colour not considered there (plans/FS114-Y-construction.md § 2.1 read)
  handoff: none — a relay-result for the construction side's round 2; it enters no proof of a value

control: fs116-y1-notch
  of: FS116-Y1-NOTCH — the exact facts (1)–(4); with the notch points raised above height 1.854 the arch blockings fail
  run: python3 ../tools/fs116_y1_notch.py | tail -1
  expect: => ALL HOLD
  fault: python3 ../tools/fs116_y1_notch.py --plant high | tail -1

**What it says for Y-QRING.** Any positive in the strip family must put an M-tile in the notch at `Q_0` and an O-tile at `Q_{−1}` (and, by the mirror
`y ↦ −y`, tiles of `U_0`'s and `U_{−1}`'s colours in the bottom notches); the columns of colour M over `V_{−1}` and `V_2` then straddle the M notch
through their upper parts, so each must be split along the unit circles about the notch points — which pass exactly through the apexes `A_{−1}` and
`A_1` (`|Q_0 − A_{±1}| = 1`) and the columns' top corners — and the crescents left between the splits need a colour that the next columns block. The
arches' (Q) arcs at `P_0` survive every such redesign: their outer tiles near `V_{±1}` are the forced wedges, whose colours are present at `P_0`.

### 3.3 The families tried for Y-QRING (the plan's stop rule)

| family | free parameters | the configuration's demand beyond `φ²/√2` | verdict |
|---|---|---|---|
| **Q1** the capped strip's arches kept, the region above and below them free | the partition and colouring of the upper and lower bands inside `B̄(P_0, R)` | the four notches coloured (M, O at the top by FS116-Y1-NOTCH; `U_0`'s and `U_{−1}`'s colours at the bottom), the columns split along the unit circles about the notches | **open**: reduced to one band-colouring problem with its forced colours named; no member built. The cascade (split, crescent, next column) did not close in this round |
| **Q2** extensions of `[Polymath2021]` Fig. 10's disk about a corner `A_k` | the tiles beyond the disk | a disc of radius `> φ²/√2` about `A_k` | **dead above `φ`** (FS112-DISC, held, cited: the corners' dial is `φ`, attained); by containment the disk alone gives `≈ 1.599` |
| **Q3** the Reuleaux bowtie (FS114-Y2-BOWTIE), whose centre's ring carries arcs of `ω(p)` | its rim | a disc of radius `> φ²/√2` | **dead at `√3`** (FS114-Y4-RSTOPALL, held, two independent derivations) |

**Verdict on Y-QRING: not landed** — no fragment beyond `φ²/√2` about a (Q)-ring vertex was built; no obstruction at a named radius was derived
beyond the held ones of Q2 and Q3; the strip family is reduced (FS116-Y1-NOTCH). **P2** ("no fragment by formula about a (Q)-ring four-colour vertex
beyond `φ²/√2` is built in round 1", 0.8): **met** from this side.

**G87 lookout, stage 3:** none seen.

## Stage 3 — SAVED
