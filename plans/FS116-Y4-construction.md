# FS116-Y4 — FS-116's construction side, round 4: the HEX3-star vertex beyond radius 2

*Job FS116-Y4 (Ephodos, Opus 5.5), from `data/fs116/briefs/FS116-Y4-hex3.md` and `plans/STANDING-RULES.md` (both read in full first; `RUNNING.md` § Make
the gate fail read before any tool). Launched 2026-10-03. Resuming check (standing rule 2): no record, tool, data or report of this job existed at start, so
nothing is resumed. Working files `data/fs116/y4/`; exact checks `tools/fs116_y4_*.py`. Every statement about a valid six-coloured fragment is about a
possible object: at six colours the class may be empty (the frozen list's preamble). Grades are my identity's grammar (`hand` = [hand], `derived from` =
[derived], `computed over` = [tools]).*

## Notation (the setting words of every statement below)

*Nothing is meant by these words beyond the frozen list's §§ 0, 10, 13 and 14 but what is marked* new.
- `p` is the origin; `e(θ)` the unit vector at angle `θ` (degrees); `ω(z)` the unit circle about `z`; `B(z, r)`, `B̄(z, r)` the open and closed discs.
  **N-E1**, **non-Siamese**, **simple**, **change point**, **hub**, **tip**, **outer tile**, **outer colour**, **germ**: the list's §§ 0, 13, 14. A tile has
  diameter at most 1, and so has its closure.
- `y_k = e(60k)` and `q_k = y_k + y_{k+1} = √3·e(60k + 30°)` (indices mod 6); `L_k` is the lens `B̄(y_k, 1) ∩ B̄(y_{k+1}, 1)` outside `B(p, 1)`, with far
  vertex `q_k` (§ 14's setting words). *New:* `2y_k = 2e(60k)`.
- **The HEX3 class on `B̄(p, R)`** *(new)*: the non-Siamese simple valid six-coloured fragments on a closed disc of radius `R` about a vertex `p` of at least
  four colours whose ring carries no arc of `Γ`, labelled as FS116-Y3-TIPS (§ 14: tiles `T1, T3, T2, T4` of colours `1, 3, 2, 4`, ring colours `X` on
  `(0°, 60°)`, `(120°, 180°)`, `(240°, 300°)` and `X̄` on the other three arcs), whose edges at `p` are `δ_1 = 90°`, `δ_2 = 150°`, `δ_3 = 270°`,
  `δ_4 = −30°` (FS116-N2-HEX3's star; for `R ≥ √3` this is FS116-Y3-STARFORCE's conclusion, frozen in § 12).
- **`R_{k,k+1}`** (§ 14): the ring tile over the arc from `y_k` to `y_{k+1}`; it holds that open arc of `ω(p)` off finitely many points (FS116-Y3-NOQ's
  argument). Its colour is `X` for `k` even and `X̄` for `k` odd.
- **`O_k`** *(new)*: the outer tile of `y_k` of the colour § 12's STARFORCE names (FS116-Y3-NBTIP: the only outer tile of `y_2` has colour 4, of `y_5`
  colour 3); **`Z_k`** *(new)*, for `k ∈ {1, 2, 4, 5}`: the tile of colour STARFORCE names at the lens points near `q_k` (2 at `q_1`, `q_5`; 1 at `q_2`,
  `q_4`), one tile near `q_k` by non-Siamese.
- **"Near `z`"**: in some neighbourhood of `z`. **"Colour `c` is absent at `x`"**: no tile of colour `c` has `x` in its closure. A tile **straddles** `x` when
  it has interior points at distance below 1 and above 1 from `x`; then its colour is absent on a neighbourhood of `x` (the interiors are connected; the
  frozen list's N-E1).
- **`σ_30`, `σ_120`** *(new)*: the reflections in the lines through `p` at `30°` and at `120°` (`θ ↦ 60° − θ` and `θ ↦ 240° − θ`).

## Theorems this phase proved

- **FS116-Y4-QT** — the brief's three quotations are verbatim at their sources, and its eight unquoted attributions present — computed over the brief's two
  blockquotes, its one inline quotation and eight phrases (`tools/fs116_y4_quotes.py`), § 1.1.
- *(stage 1 proves nothing else: its other products are a recognition and proposed statements, § 1.2–1.3.)*
- **FS116-Y4-SYM** — the HEX3 class with its labels is invariant under the reflections in the lines at `30°` and `120°` through `p`, the colours permuted by
  `(3 4)` and by `(1 2)(X X̄)` — [hand], one mind, § 2.1.
- **FS116-Y4-SPOKE** — the only outer tile of each single-tip hub reaches the lattice point at radius 2 beyond it and ends there on a unit arc about the hub:
  inside `ω(y_2)` near `2y_2` only colour 4, outside only `3, X, X̄` — [derived], one mind, § 2.2.
- **FS116-Y4-Q1** — the colours near `q_1` by sector: `{2}` in the lens, `{1, 2}`, `{2, 3}` beside it, `{1, 2, 3, X}` outside; 4 and `X̄` absent — [derived],
  one mind, § 2.3. *(Vacuous since stage 3: the class is empty.)*
- **FS116-Y4-FLANK** — a tile holding two ring points `60°` apart with full tip cones at both has its two flank edges leave along one direction, each
  inside the other point's unit disc, so the tiles beyond them come within distance below 1 — [hand], one mind, § 3.1.
- **FS116-Y4-EMPTY** — **no non-Siamese simple valid six-coloured fragment on a disc of radius above 1 about a four-colour vertex has a Γ-free ring**: the
  double tip's two flank tiles share a colour and come within 1 — [derived], one mind, § 3.2.
- **FS116-Y4-OBST** — the brief's answer: no fragment of the HEX3 class on any disc of radius above 1; FS116-Y4-FRAG is FALSE — [derived], one mind, § 3.3.

## Would-have-searched-here log (standing rule 5)

- Stage 1: none (reading and recognition).
- Stage 2: none — every step is a straddle read by hand at a lattice point; the tool checks the signs at twelve fixed points.
- Stage 3: would have searched colourings of the second shell (and, after 2026-10-01, asked a solver); instead compared two of round 3's derived edges, which ended the question.

## Fence log (standing rule 8)

- My brief fences nothing for me; it asks me to write nothing about my work outside this record, `data/fs116/y4/`, `tools/fs116_y4_*.py` and my report, and
  to message no other job (FS116-V5 is blind to every FS-116 record). The harness's start-up context held the auto-memory index (status lines, no proof
  content). I read no session transcript. My readback tool opens `data/fs116/briefs/FS116-V5-verify.md` only to find the string `FS116-Y3-STARFORCE` (the
  brief's "a blind verifier is checking it now"); I read nothing else of it, and no FS116-V5 or FS121-Z1 record.

## G87 lookout

- Stage 1: none seen as two truths in collision.
- Stage 2: none seen.
- Stage 3: none seen as two truths in collision. Classed: round 3's chain (SIX … STARFORCE) and N2's HEX6/HEX3 against EMPTY — not a collision: those are true
  of an empty class; the defect was a consequence left undrawn (FS116-Y3-TIGHT's two edges never compared), a G83 *Do* missed, not two truths.

## Stage 1 — SAVED: the readback, recognition on the target, and the proposed statements

### 1.1 Readback (standing rule 3)

Read from disk, in this order: the brief; `plans/STANDING-RULES.md`; `.claude/agents/ephodos.md` (outline, against the loaded copy); `data/fs116/claims.md`
§§ 0–14 in full; `plans/FS116-Y3-construction.md` in full (stages 1–4); `plans/FS116-N2-proof.md` header, theorem list, logs, § 2.1–2.4 and § 3.1–3.3 (STAR,
RECIP, ANTI, HEX6, HEX3, RING-TRANSFER-C); `plans/FS116-Y2-construction.md` header, theorem table, logs, § 1.1–1.2 and stage 2 in full (SIXFRAG, SIXOFF);
`tools/fs116_y2_six.py` in full and `tools/fs114_yb_exact.py` header and API (read-only; the exact checker for segment-and-arc tiles); `RUNNING.md` § Make the
gate fail; `plans/FS116-close-inventory.md` rows 88 and 114. The grokkings are in my context at launch (G82–G87 read for this job).

`tools/fs116_y4_quotes.py` (`data/fs116/y4/quotes.out`): **3 of 3 FOUND** — the stalled form (`plans/FS116-Y3-construction.md` § 4.3), STARFORCE
(`data/fs116/claims.md` § 12) and the inline "No enumeration of maps, colourings, tile graphs or dual graphs, by any program." (§ 9) — and **8 of 8
attributions PRESENT**: STARFORCE's theorem line and its "one mind" (Y3), FS116-V5's brief naming STARFORCE, inventory row 88, the list's §§ 13 and 14
headings, N2's RECIP and HEX6. Plants: one phrase of the stalled form altered (`--alter`: "above 2" → "at least 2") is NOT FOUND; every quotation against
the wrong file (`--source plans/STANDING-RULES.md`) is NOT FOUND.

**Two findings about the brief, by reading (neither a defect of mine):**
1. **The ban's date.** Standing rule 5 says the finite-witness ban runs to 2026-10-01 and "Delete this rule after 2026-10-01 unless Kooshi extends it"; today
   is 2026-10-03 and the rule is still in the file. The brief binds me independently through the list's § 9 ("No enumeration of maps, colourings, tile
   graphs or dual graphs, by any program", nor of ring types), and I keep the would-have-searched log. Held for the coordinator as a question.
2. **STARFORCE is at one mind and under a blind check now.** Everything below is conditional on it; the brief says so, and inventory row 114 says the round
   is re-aimed if FS116-V5 refutes it. Every entry of mine that uses it names it in *uses only*.

derivation: FS116-Y4-QT
  statement: the two blockquotes of data/fs116/briefs/FS116-Y4-hex3.md and its inline quotation of the list's § 9 occur verbatim, whitespace collapsed, in
    the sources they name, and the brief's eight named unquoted attributions are present at their sources
  uses only: the brief's text and the sources' text; whitespace normalisation and the quotation's list prefix only
  not claimed: that the brief's unquoted glosses are faithful beyond the eight phrases checked (the two findings above were found by reading)
  argument: § 1.1 Readback (standing rule 3)
  verdict: derived
  grade: computed over: the brief's 2 blockquotes, 1 inline quotation and 8 named attributions
  minds: 1
  model: the quotation of FS116-Y3-STARFORCE, found at data/fs116/claims.md § 12
  prior art: known: data/fs116/claims.md and plans/FS116-Y3-construction.md (the sources the quotations are checked against)
  handoff: none — a readback, not mathematics

control: fs116-y4-qt
  of: FS116-Y4-QT — the quotations found; with one phrase altered the first is not
  run: python3 ../tools/fs116_y4_quotes.py | tail -n 1
  expect: quotations: 3 found 3; attributions: 8 present 8
  fault: python3 ../tools/fs116_y4_quotes.py --alter | tail -n 1

**My target, restated beside the quotation** (the quotation governs): a fragment of the HEX3 class on a closed disc of radius above 2, given by formula and
checked exactly — or a derived obstruction: a radius `R_0 ≤ 2` with no fragment of the HEX3 class on `B̄(p, R_0)`.

### 1.2 Recognition (`ephodos-recognition`, invoked fresh)

**The stall it starts from** — *a wall that describes a counterexample*, and *a known theorem that almost applies*. Round 3 forced the star at `√3` and
stopped: the forced pieces "run from `p` to the `q_k`", and one branch at `2y_0` "closed there without contradiction". The question is what every fragment
of the class carries between radius `√3` and the disc's rim, and where.

**For a stranger** (a discrete geometer who works on colourings of the plane by tiles of diameter at most 1, the setting of de Grey's and Gibbs's six-coloured
discs): *Six colours; an open set containing the closed disc of radius `R` about the origin is cut by finitely many segments and circular arcs near each
point into open topological discs ("tiles"), each of diameter at most 1, any two of one colour at distance at least 1, closures meeting in connected sets.
Four tiles meet at the origin, with angles `120°, 60°, 120°, 60°` there, edges along `90°, 150°, 270°, 330°`; the unit circle about the origin meets the
boundaries in finitely many points. How large can `R` be?* Words the reader stops at: "ring", "hub", "tip", "outer tile", "(Q) arc", "HEX3", "lens point" —
each defined above from the reader's primitives; none is needed for the question, and none is a determiner the reader's field lacks.

**The features, sorted** (receipts in brackets):

| feature | sort | receipt |
|---|---|---|
| the unit circle about `p` meets `Γ` in finitely many points | determines | through FS116-Y3-SIX, -TIPS and -STARFORCE it fixes the star, the six hubs at `e(60k)`, every hub's colours and the lens colours near `q_1, q_2, q_4, q_5` (round 3's chain, each step consuming it) |
| the positions `p, y_k, q_k, 2y_k`: the unit Eisenstein lattice `ℤ[ζ₆]` | determines | every exclusion of round 3 and of § 2 below is a straddle between lattice points at distance exactly 1 (`|2y_2 − q_1| = |2y_2 − q_2| = |2y_2 − y_2| = 1`); moving `q_1` off the lattice frees a colour at `2y_2` (control fs116-y4-spoke's plant) |
| six colours | determines | the spoke (§ 1.3, P2) excludes all five colours other than 4 inside `ω(y_2)` near `2y_2`, one by each forced tile; with a seventh colour it survives there |
| non-Siamese | determines | the 4-tile inside `ω(y_2)` near `2y_2` is `y_2`'s outer tile because two 4-tiles within distance 1 are one |
| the radius | determines where the question lives | the spoke ends at `2y_2`, radius exactly 2: the first forced structure past STARFORCE sits on the circle of radius 2, so "above 2" asks what lies beyond the spoke ends |
| the Klein four-group `{1, σ_30, σ_120, −1}` | accompanies, and organizes | the class with its labels is invariant under it, the colours permuted (§ 1.3, P1): every local fact at `z` holds at `σ(z)`; a fundamental sector of directions is `[30°, 120°]` |
| one or two outer tiles at the double-tip hubs `y_0, y_1, y_3, y_4` | unsorted | STARFORCE leaves both; no argument here yet consumes the choice |
| whether a ring tile's cone at a hub meets the outer side of the ring | unsorted | decides whether `X`, `X̄` survive outside `ω(y_2)` near `2y_2` (P2's *not claimed*) |

**The homes.**
1. **The project's straddle calculus at lattice points** (FS116-Y2-SIXOFF, FS116-Y3-LENS and -NOQ). Its proofs apply at once one shell out: the lens tiles
   `Z_1`, `Z_2` near `q_1`, `q_2`, the ring tiles and the tip of `y_2` straddle every point near `2y_2` inside `ω(y_2)`. *Predicts a neighbour:* the spoke
   (P2), which no held lemma states. Adopted.
2. **The arrangement of unit circles about `ℤ[ζ₆]`.** Dictionary: a lattice edge `{A, B}` has the thin lens `E_{AB} = B̄(A′, 1) ∩ B̄(A″, 1)` of width
   `2 − √3`, `A′, A″` its two common neighbours; a lattice triangle has the curved triangle it keeps outside its three edge lenses (cusped at its vertices).
   Then `T1, T2` are the triangle tiles of `(p, y_0, y_1)`, `(p, y_3, y_4)` holding the two edge lenses at `p` (`T1`'s cone `[−30°, 90°]` is exactly
   `E_{p y_0} ∪ E_{p y_1}` at `p`); `T3 ⊂ B̄(p, 1) ∩ B̄(y_2, 1)` is an edge tile of `{p, y_2}`; `R_{12} ⊂ L_1 ∪ (B̄(y_1,1) ∩ B̄(y_2,1))` an edge tile of
   `{y_1, y_2}`; and the prediction P2 makes `O_2` the edge tile of `{y_2, 2y_2}`. *Test:* the old proofs apply (every distance is a lattice distance); the
   dictionary has one false line — tiles are not unions of cells (the cusp at `y_1` of the curved triangle of `(p, y_1, y_2)` lies outside `T1` and in no
   tile of `p` tipping `y_1`, so a cell is shared). Adopted as the map an obstruction or a construction reads, not as a tiling.
3. **Reuleaux lattice colourings at seven colours** (FS111-M-R7, de Grey's Reuleaux 4 + 3; the hexagonal seven-colouring). A construction home at `k = 7`;
   its lattice points carry six of seven colours, so no Γ-free four-colour vertex: silent on the class, a model for the cell map only.
4. **The literature's six-coloured discs** (Gibbs's disk of radius `√((25 + 9√5)/10) ≈ 2.1246` about a point interior to a tile, `[Polymath2021]` Fig. 10,
   held as row 136; Parts's six-colourings with voids, `plans/STUB-hole-dial.md`). Objects, no theorem; a fragment of the class above radius 2 would hold a
   disc about a four-colour vertex larger than any held. Context.
5. **Equivariance** (the symmetry of the set-up; G58's antipodal form, here a Klein four-group). *Test:* every forced datum of round 3 is carried to a forced
   datum by `σ_30` with colours `(3 4)` and by `σ_120` with `(1 2)(X X̄)` (§ 1.3, P1, checked line by line against STARFORCE's statement). Adopted: it halves
   twice the casework of an obstruction and is the natural ansatz of a construction.

**The recognition sentence.** *A HEX3-star vertex is a patch of the unit Eisenstein lattice with the symmetry of a rectangle — mirrors at `30°` and `120°`
through `p`, acting on the colours by `(3 4)` and by `(1 2)(X X̄)` — and its two single-tip hubs are spokes: the only outer tile of `y_2` is forced out along
the lattice edge to `2y_2`, where it ends on a unit arc about `y_2`; so the forced structure reaches radius exactly 2 in the directions `120°` and `300°`, and
the question "above 2" is what lies beyond the spoke ends and in the sector `[30°, 120°]` between a spoke and the mirror through `q_0`.*

**Where it differs from the brief's frame.** The stalled form asks for "the point inside radius 2 where every such fragment loses all six colours". The first
forced structure past STARFORCE lies *on* the circle of radius 2 (the spoke ends), not inside it; so an obstruction strictly inside radius 2 must be found
off the spokes (near `q_0`, `2y_0`, `2y_1`, or in the sectors at the `q_k`), and one at radius exactly 2 or just above is as much a result for the brief's
target (which asks for radius above 2). Reported with the result.

**Novelty, at the grain of the step:** the spoke and the symmetry are not in FS-116's gate; no search of my own is run at this stage — owed (INVENTORY).

### 1.3 The proposed statements (for freezing; each in the setting words above)

*Each is proposed before any derivation of it. Statements proposed at later stages are proposed in that stage's section before its derivation.*

- **P1, FS116-Y4-SYM**: let F be a fragment of the HEX3 class on B̄(p, R), R ≥ √3; then σ_30(F), with the colours 3 and 4 exchanged, and σ_120(F), with the
  colours 1 and 2 exchanged and X and X̄ exchanged, are fragments of the HEX3 class on B̄(p, R) with the same labels — σ_30 fixing T1 and T2 and exchanging
  T3 and T4, σ_120 exchanging T1 and T2 and fixing T3 and T4 — so every statement of this record about F at a point z holds at σ(z) with the colours so
  exchanged *Not claimed:* that any fragment of the class is symmetric; anything about stars other than HEX3's
- **P2, FS116-Y4-SPOKE**: in a fragment of the HEX3 class on a closed disc of radius above 2 about p, the outer tile O_2 of y_2 (colour 4) has 2y_2 in its
  closure, lies in B̄(y_2, 1) ∩ B̄(2y_2, 1), and contains every point of some neighbourhood of 2y_2 that lies in B(y_2, 1) and off Γ; every tile with a point
  of that neighbourhood outside B̄(y_2, 1) in its closure has colour 3, X or X̄; so near 2y_2 the circle ω(y_2) lies in Γ, with inner colour 4; and the same at
  y_5 and 2y_5 with 3 and 4 exchanged *Not claimed:* that the outer colour at 2y_2 is 3 (X and X̄ are not excluded there when the ring tiles' cones at y_2 do
  not meet the outer side of the ring); anything below radius 2; anything at the double-tip hubs
- **P3, FS116-Y4-Q1**: in a fragment of the HEX3 class on a closed disc of radius above 2 about p, for every point x = q_1 + s·e(χ) of some neighbourhood of
  q_1, colours 4 and X̄ are absent at x; X is absent when χ lies in (150°, 390°); 3 is absent when χ lies in (150°, 330°); 1 is absent when χ lies in
  (210°, 390°); and the points with χ in (210°, 330°) are in Z_1 (colour 2) *Not claimed:* which of the remaining colours occur; that 3 is absent for χ in
  (−30°, 150°) (it is when the outer colour at 2y_2 is 3 alone, § 2)
- **P4, FS116-Y4-FRAG**: there is a fragment of the HEX3 class on a closed disc of radius above 2, given by formula *Not claimed:* anything about its other
  four-colour vertices
- **P5, FS116-Y4-OBST**: there is an explicit R_0 ≤ 2 such that no fragment of the HEX3 class exists on B̄(p, R_0) — R_0 to be named by the derivation, or the
  statement withdrawn *Not claimed:* anything about the Siamese or non-simple class; anything at k ≥ 7

P4 and P5 are the brief's two outcomes; at most one is derived. P1–P3 are relay-results toward either.

## Stage 1 — SAVED

## Stage 2 — SAVED: the symmetry, the spokes, and the colours at `q_1`

*Class: the HEX3 class (Notation). Inputs at their grades: FS116-Y3-STARFORCE, -NBTIP, -NOQ, -TIGHT and -TIPS (one mind each, STARFORCE under FS116-V5's
blind check), RING-GERM (two minds). The plane facts each step uses are checked exactly at named points by `tools/fs116_y4_lattice.py` (a check of the hand
reading's signs, not a proof).*

### 2.1 The symmetry (FS116-Y4-SYM)

`σ_30` and `σ_120` are isometries fixing `p`, so they carry tiles to tiles, segments and arcs to segments and arcs, and preserve validity, non-Siamese,
simple, "a vertex of at least four colours" and "a ring carrying no arc of `Γ`"; renaming colours by a bijection preserves all of these. The labels:
`σ_30` (`θ ↦ 60° − θ`) carries the cones `[−30°, 90°]`, `[90°, 150°]`, `[150°, 270°]`, `[270°, 330°]` of `T1, T3, T2, T4` to `[−30°, 90°]`, `[270°, 330°]`,
`[150°, 270°]`, `[90°, 150°]` and the hubs `y_0, …, y_5` to `y_1, y_0, y_5, y_4, y_3, y_2`; with `3 ↔ 4` the image has colour 1 on `[−30°, 90°]`, 4 on
`[270°, 330°]`, 2 on `[150°, 270°]`, 3 on `[90°, 150°]` — the labels of TIPS with the same names — the ring arcs `(60k, 60k + 60°)` go to `(−60k, 60° − 60k)`,
which have the same colour `X` or `X̄`, and the tips go to tips (`T1` tips `y_0, y_1` ↦ `y_1, y_0`; `T3`'s `y_2` ↦ `y_5`, `T4`'s). `σ_120` (`θ ↦ 240° − θ`)
carries the four cones to `[150°, 270°]`, `[90°, 150°]`, `[−30°, 90°]`, `[270°, 330°]` and the hubs to `y_4, y_3, y_2, y_1, y_0, y_5`; with `1 ↔ 2` and
`X ↔ X̄` the labels are again TIPS's (the ring arc `(0°, 60°)` goes to `(180°, 240°)`, coloured `X̄` in `F`, hence `X` in the image). The edges `δ_i` go to
edges of HEX3's star in both. So the images are in the HEX3 class with the same labels; and since every statement of this record is a consequence of
membership in the class, each holds of the image, i.e. holds of `F` at `σ⁻¹(z)` = `σ(z)` with the colours exchanged. The table of round 3's forced data
(26 data: the four cones, six ring colours, six tips, six hubs' outer colours with STARFORCE's orders, four lens colours) is carried datum to datum
(`tools/fs116_y4_lattice.py sym`, `data/fs116/y4/sym.out`; plant: `σ_30` with `1 ↔ 2`, which carries none correctly to their images). ∎

### 2.2 The spoke at `y_2` (FS116-Y4-SPOKE)

Let `N` be a small neighbourhood of `2y_2`, inside the disc (radius above 2).
1. **`X̄`, `X` are absent at every `x ∈ N ∩ B(y_2, 1)`.** `R_{12}` (colour `X̄`) holds the ring points `e(θ)`, `θ ∈ (60°, 120°)`, off finitely many; as
   `θ → 120°`, `|x − e(θ)| → |x − y_2| < 1`, and `|2y_2 − e(90°)|² = 5 − 2√3 > 1`: `R_{12}` straddles `x`. Likewise `R_{23}` (`X`), with `θ → 120°⁺` and
   `e(150°)`.
2. **3 is absent there.** `y_2 ∈ cl T3`, so `T3` has interior points within `< 1` of `x`; `p ∈ cl T3` and `|x| ≈ 2`: `T3` straddles `x`.
3. **1 and 2 are absent at every `x ∈ N`.** `Z_1` holds the points of `L_1` near `q_1` (STARFORCE), whose cone at `q_1` is `[210°, 330°]`; `2y_2 − q_1 =
   e(180°)`, so for `|x − 2y_2| = s ≪ t ≪ 1`, `|x − q_1 − t·e(β)|² = 1 − 2t·cos(β − 180°) + O(s + t²)`, below 1 at `β = 220°` and above at `β = 320°`:
   `Z_1` straddles `x`. Likewise `Z_2` (colour 1) at `q_2` (`2y_2 − q_2 = e(60°)`, `L_2`'s cone `[270°, 30°]`, `β = 20°` and `280°`).
4. **The 4-tile inside is `O_2`.** By 1–3 every point of `N ∩ B(y_2, 1)` off `Γ` is interior to a tile of colour 4. `O_2` is `y_2`'s only outer tile (NBTIP),
   and its cone at `y_2` contains `(90°, 150°)` (RING-GERM (ii), one tile per colour at `y_2`), so it holds `y_2 + t·e(120°)` for small `t`, within `< 1` of `x`
   (`(x − y_2)·e(120°) ≈ 1` and `|x − y_2| < 1`). Two 4-tiles at distance `< 1` are one (non-Siamese): the 4-tile at `x` is `O_2`. So `O_2` contains
   `N ∩ B(y_2, 1)` off `Γ`, `2y_2 ∈ cl O_2`, and (diameter at most 1) `O_2 ⊂ B̄(y_2, 1) ∩ B̄(2y_2, 1)`.
5. **Outside.** A tile `W` with a point `x ∈ N ∖ B̄(y_2, 1)` in its closure has interior points near `x`, outside `B̄(y_2, 1)`; colours 1, 2 are absent (3.);
   colour 4 would make `W` within `< 1` of `O_2`'s points near `2y_2`, so `W = O_2 ⊂ B̄(y_2, 1)`, impossible. So `W` has colour 3, `X` or `X̄`, and every point
   of `ω(y_2) ∩ N` is in the closure of `O_2` and of a tile of another colour: `ω(y_2) ∩ N ⊂ Γ`, inner colour 4. ∎ By SYM (`σ_30`, `3 ↔ 4`) the same at
   `y_5`: `O_5` (colour 3) reaches `2y_5`, the outer side there has colours in `{4, X, X̄}`.

*What it says.* `O_2` is the edge tile of the lattice edge `{y_2, 2y_2}` (home 2 of § 1.2): the single-tip hubs throw their outer tile out to radius exactly
2, and `ω(y_2)` carries a (Q)-type arc at `2y_2` (centre `y_2` carries 3 and 4, both side colours when the outer colour is 3). *Where six is spent:* step 4,
where the five other colours are each excluded by one forced tile; with a seventh colour the 4-tile inside need not exist. *Controls:* the strip, the disk,
R7 and SQ9 have no Γ-free four-colour vertex with HEX3's star (FS116-Y3 § 2.5, § 3.3): silent.

### 2.3 The colours near `q_1` (FS116-Y4-Q1)

Let `x = q_1 + s·e(χ)`, `s` small.
- **`X̄`:** `R_{12}` holds `e(90°)`, `|q_1 − e(90°)| = √3 − 1 < 1`, and a point outside `B̄(q_1, 1)`: at `y_1` it shares a non-degenerate boundary curve with
  `T1` (the cyclic order at a hub, FS116-Y3-NOQ), `T1 ⊂ B̄(y_0, 1)`, and `B̄(y_0, 1) ∩ B̄(q_1, 1) = {y_1}` (`|y_0 − q_1| = 2`, midpoint `y_1`). So `R_{12}`
  straddles every `x` near `q_1` (TIGHT's argument, in the stronger form its proof gives).
- **4:** `O_2` holds `y_2 + t·e(120°)` (`q_1 − y_2 = e(60°)`: distance² `≈ 1 + 2s·cos(χ − 60°) − t`, below 1 for `s ≪ t`) and, by SPOKE, the points
  `2y_2 + t·e(240°)` of `B(y_2, 1)` (`q_1 − 2y_2 = e(0°)`: distance² `≈ 1 + 2s·cos χ + t`, above 1): `O_2` straddles every `x` near `q_1`.
- **`X`:** `R_{23}`'s ring points `e(120° + δ) = y_2 + δ·e(210°) + O(δ²)` give distance² `1 + 2s·cos(χ − 60°) + √3·δ + O(δ² + sδ)`, below 1 for
  `cos(χ − 60°) < 0` and `δ ≪ s`; `e(150°)` is at `≈ 1.506`. So `X` is absent for `χ ∈ (150°, 330°)`; by `R_{01}`'s ring points near `y_1` (`q_1 − y_1 =
  e(120°)`) and `e(30°)`, for `χ ∈ (210°, 390°)`.
- **3:** `T3` holds `y_2 + t·e(300°)` (its tip cone), distance² `1 + 2s·cos(χ − 60°) + t`, below 1 for `cos(χ − 60°) < 0` and `t ≪ s`; and `p`: absent for
  `χ ∈ (150°, 330°)`. **1:** `T1` holds `y_1 + t·e(240°)`, distance² `1 + 2s·cos(χ − 120°) + t`; absent for `χ ∈ (210°, 390°)`.
- **2:** for `χ ∈ (210°, 330°)`, `x ∈ L_1`, in `Z_1` (STARFORCE). ∎

`tools/fs116_y4_lattice.py q1` (`data/fs116/y4/q1.out`) confirms each claimed exclusion at the twelve points `χ = 15° + 30°j` with witnesses checked to lie in
the regions the argument names, and reports that outside each claimed sector the same witnesses fail at every sample (the sectors are sharp at first order);
plant: the centre moved to `q_1 + (1/4, 0)`, where 28 claims fail. By SYM the same at `q_5` (`σ_30`, `3 ↔ 4`), `q_2` (`σ_120`, `1 ↔ 2`, `X ↔ X̄`) and `q_4`.

**The sectors at `q_1`**, read off: `(210°, 330°)` (inside `L_1`): `{2}`; `(150°, 210°)`: `{1, 2}`; `(330°, 30°)`: `{2, 3}`; `(30°, 150°)`: `{1, 2, 3, X}`.

derivation: FS116-Y4-SYM
  statement: let F be a fragment of the HEX3 class on B̄(p, R), R ≥ √3; then σ_30(F), with the colours 3 and 4 exchanged, and σ_120(F), with the colours 1
    and 2 exchanged and X and X̄ exchanged, are fragments of the HEX3 class on B̄(p, R) with the same labels — σ_30 fixing T1 and T2 and exchanging T3 and
    T4, σ_120 exchanging T1 and T2 and fixing T3 and T4 — so every statement of this record about F at a point z holds at σ(z) with the colours so exchanged
  uses only: that σ_30 and σ_120 are isometries fixing p; that a bijection of the colours preserves validity, non-Siamese and simplicity; the cones, hubs, tips
    and ring colours of FS116-Y3-TIPS's labelling and the edges of HEX3's star, mapped by hand (§ 2.1) and checked as a table (control fs116-y4-sym)
  not claimed: that any fragment of the class is symmetric; anything about stars other than HEX3's
  argument: § 2.1 The symmetry (FS116-Y4-SYM)
  verdict: derived
  grade: hand
  minds: 1
  model: none at six colours (the class may be empty); the table is control fs116-y4-sym
  prior art: owed — no search run; the symmetry of a configuration under a colour-permuting isometry group is the standard frame of G58's equivariant sweeps
  handoff: none — a bookkeeping lemma for the casework of this record

derivation: FS116-Y4-SPOKE
  statement: in a fragment of the HEX3 class on a closed disc of radius above 2 about p, the outer tile O_2 of y_2 (colour 4) has 2y_2 in its closure, lies in
    B̄(y_2, 1) ∩ B̄(2y_2, 1), and contains every point of some neighbourhood of 2y_2 that lies in B(y_2, 1) and off Γ; every tile with a point of that
    neighbourhood outside B̄(y_2, 1) in its closure has colour 3, X or X̄; so near 2y_2 the circle ω(y_2) lies in Γ, with inner colour 4; and the same at y_5
    and 2y_5 with 3 and 4 exchanged
  uses only: FS116-Y3-STARFORCE (the lens colours near q_1 and q_2; HEX3's star); FS116-Y3-NBTIP (y_2's only outer colour is 4); RING-GERM (ii) (O_2's cone at
    y_2 holds (90°, 150°)); FS116-Y3-NOQ's argument (R_12 and R_23 hold the open ring arcs); non-Siamese; diameter at most 1; |2y_2 − q_1| = |2y_2 − q_2| = 1,
    |2y_2 − e(90°)|² = |2y_2 − e(150°)|² = 5 − 2√3; FS116-Y4-SYM for y_5
  not claimed: that the outer colour at 2y_2 is 3 (X and X̄ are not excluded there when the ring tiles' cones at y_2 do not meet the outer side of the ring);
    anything below radius 2; anything at the double-tip hubs; anything at k ≥ 7 (a seventh colour survives inside ω(y_2) near 2y_2)
  argument: § 2.2 The spoke at `y_2` (FS116-Y4-SPOKE)
  verdict: derived
  grade: derived from: FS116-Y3-STARFORCE, FS116-Y3-NBTIP, RING-GERM, FS116-Y4-SYM
  minds: 1
  model: none at six colours; the plane facts at twelve points round 2y_2 are control fs116-y4-spoke
  prior art: owed
  handoff: none — a relay-result for the obstruction or the construction of this record; with STARFORCE, after its blind check, a candidate for de Bruijn

derivation: FS116-Y4-Q1
  statement: in a fragment of the HEX3 class on a closed disc of radius above 2 about p, for every point x = q_1 + s·e(χ) of some neighbourhood of q_1,
    colours 4 and X̄ are absent at x; X is absent when χ lies in (150°, 390°); 3 is absent when χ lies in (150°, 330°); 1 is absent when χ lies in
    (210°, 390°); and the points with χ in (210°, 330°) are in Z_1 (colour 2)
  uses only: FS116-Y4-SPOKE (O_2's points inside ω(y_2) near 2y_2); FS116-Y3-STARFORCE (Z_1 at L_1 near q_1); FS116-Y3-NOQ (the ring tiles hold their open
    arcs; the cyclic order at y_1) and FS116-Y3-TIGHT's argument (|y_0 − q_1| = 2 with midpoint y_1); the tips T1 at y_1 and T3 at y_2 with their cones
    (RING-GERM (i)); straddles at first order
  not claimed: which of the remaining colours occur; that 3 is absent for χ in (−30°, 150°) (§ 3 reads when it is)
  argument: § 2.3 The colours near `q_1` (FS116-Y4-Q1)
  verdict: derived
  grade: derived from: FS116-Y4-SPOKE, FS116-Y3-STARFORCE
  minds: 1
  model: none at six colours; the plane facts at twelve points round q_1 are control fs116-y4-q1
  prior art: owed
  handoff: none — a relay-result for § 3

control: fs116-y4-sym
  of: FS116-Y4-SYM — round 3's 26 forced data carried datum to datum by σ_30 with (3 4) and σ_120 with (1 2)(X X̄); σ_30 with (1 2) fails
  run: python3 ../tools/fs116_y4_lattice.py sym | tail -n 1
  expect: SYM: every datum carried
  fault: python3 ../tools/fs116_y4_lattice.py sym --plant swap | tail -n 1

control: fs116-y4-spoke
  of: FS116-Y4-SPOKE — every claimed exclusion at twelve points round 2y_2, witnesses in their regions; Z_1's anchor moved off the lattice breaks it
  run: python3 ../tools/fs116_y4_lattice.py spoke | tail -n 1
  expect: SPOKE facts at 12 points: all hold
  fault: python3 ../tools/fs116_y4_lattice.py spoke --plant q1 | tail -n 1

control: fs116-y4-q1
  of: FS116-Y4-Q1 — every claimed exclusion at twelve points round q_1, witnesses in their regions; the centre moved breaks 28 claims
  run: python3 ../tools/fs116_y4_lattice.py q1 | tail -n 1
  expect: Q1 facts at 12 points: all hold
  fault: python3 ../tools/fs116_y4_lattice.py q1 --plant q1 | tail -n 1

## Stage 2 — SAVED

## Stage 3 — SAVED: the Γ-free class is empty (FS116-Y4-FLANK, FS116-Y4-EMPTY)

*Found while setting up the second shell's casework: round 3's own lemma FS116-Y3-TIGHT puts both flank edges of a double tip along `210°`, one inside
each hub's unit disc, and both flank tiles have colour `X̄`. Drawn out, that is a contradiction at radius `1 + ε`. The mechanism is G83's ("two tiles of one
colour forced along two unit circles to come within 1") and FS114-Y5-PXKILL's.*

### 3.0 Proposed before their derivation (setting words: the Notation)

- **P6, FS116-Y4-FLANK**: let t be a tile of a valid fragment, Siamese pairs allowed, on a closed disc of radius above 1 about a point p, and let y = r(ψ)
  and y′ = r(ψ + 60°) be points of ω(p) in the closure of t such that the cone of t at y contains the open cone (ψ + 150°, ψ + 210°) and its cone at y′
  contains (ψ + 210°, ψ + 270°); then t's cone at y ends at ψ + 210° and its cone at y′ begins at ψ + 210°, and if a is the tile bordering t at y along t's
  edge leaving y in the direction ψ + 210°, and b the tile bordering t at y′ along t's edge leaving y′ in the direction ψ + 210°, some point of the closure
  of a and some point of the closure of b are at distance below 1 *Not claimed:* anything about the colours of a and b; that a ≠ b
- **P7, FS116-Y4-EMPTY**: no non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has
  a ring carrying no arc of Γ *Not claimed:* anything for rings carrying an arc of Γ that is not a (Q) arc (the (Q)-free rings of FS114-N6-RING60 after the
  bends, with (R2) arcs); anything in the Siamese or non-simple class; anything at k ≥ 7 (with three absent colours the flank tiles need not share a colour)

### 3.1 The flank lemma (FS116-Y4-FLANK)

`t` has diameter at most 1 (its interior is connected and no two of its points are exactly 1 apart), so `t ⊂ B̄(y′, 1)`, whose tangent cone at `y` is
`[ψ + 30°, ψ + 210°]` (`y′ − y = e(ψ + 120°)`). The cone of `t` at `y` lies in it and contains `(ψ + 150°, ψ + 210°)`: it ends at `ψ + 210°`, along an
edge `e_a` of `Γ` leaving `y` in that direction, tangent there to `ω(y′)`, with `e_a ⊂ cl t ⊂ B̄(y′, 1)`. Likewise `t ⊂ B̄(y, 1)`, whose tangent cone at
`y′` is `[ψ + 210°, ψ + 30°]`; the cone of `t` at `y′` begins at `ψ + 210°`, along an edge `e_b ⊂ B̄(y, 1)` tangent to `ω(y)`. Near `y` and `y′` these edges
are segments or circular arcs, so `e_a(s) = y + s·e(ψ + 210°) + (κ_a s²/2)·e(ψ + 120°) + o(s²)` and `e_b(s) = y′ + s·e(ψ + 210°) + (κ_b s²/2)·e(ψ + 300°) +
o(s²)`; staying in the discs, `|e_a(s) − y′|² = 1 + (1 − κ_a)s² + o(s²) ≤ 1`, forces `κ_a ≥ 1`, and likewise `κ_b ≥ 1` (a tangent segment leaves the
disc). Then `e_b(s) − e_a(s) = (1 − (κ_a + κ_b)s²/2)·e(ψ + 120°) + o(s²)`, of length `1 − (κ_a + κ_b)s²/2 + o(s²) < 1` for small `s > 0`. The two edges
lie in `cl a` and `cl b` (near a vertex the sector beyond an edge is one tile). ∎ In the least-curved case, both edges arcs of radius 1, the points at
turning angle `φ` are exactly `2cos φ − 1` apart.

### 3.2 The class is empty (FS116-Y4-EMPTY)

Let `F` be such a fragment. By FS116-Y3-SIX the ring has exactly six change points `y_k = r(ψ_0 + 60°k)`, each a hub, and `p` has four tiles and four
colours, absent `X, X̄`; off `Γ` the ring's colour `c(θ)` is `X` or `X̄` and `c(θ + 60°) ≠ c(θ)` (RING-TWIST-C, as SIX uses it). By FS116-Y3-TIPS each hub
has exactly one tip and some tile `t` of `p` tips two adjacent hubs, `y_k` and `y_{k+1}` (six hubs, four tiles, a tile tipping at most two, and two only if
adjacent). By RING-GERM (i) `t`'s cone at `y_k` contains `(ψ_k + 150°, ψ_k + 210°)` and at `y_{k+1}` contains `(ψ_k + 210°, ψ_k + 270°)`; FLANK gives tiles
`a` at `y_k` and `b` at `y_{k+1}` whose closures come within distance below 1.
- **`a` is the tile holding the ring just clockwise of `y_k`.** `a`'s cone at `y_k` begins at `ψ_k + 210°`, an inward direction, so `a` meets `B(p, 1)`: it
  is neither an outer tile (an outer tile is at distance at least 1 from `p`'s tile of its colour, which holds `p`) nor a tile of `p` (a tile of `p` at
  `y_k` is a tip, and `t` is the only one). So its colour is `X` or `X̄` (FS116-N2-STAR: `C(y_k) = A(p) ⊔ T ⊔ O`), and one tile of each colour is at `y_k`.
  The tile of colour `c(ψ_k + δ)` holds the ring points just counter-clockwise of `y_k`, so its cone contains `ψ_k + 90°`; a cone (an interval) holding
  `ψ_k + 90°` and `ψ_k + 210°` contains the tip's cone `(ψ_k + 150°, ψ_k + 210°)` or the outer cone `(ψ_k − 30°, ψ_k + 30°)` (RING-GERM (ii)), both other
  tiles'. So `a` has colour `c(ψ_k − δ)` and holds `r(ψ_k − δ)` for small `δ > 0`. Likewise `b` has colour `c(ψ_k + 60° + δ)` and holds `r(ψ_k + 60° + δ)`.
- **One colour.** `c(ψ_k + 60° + δ) ≠ c(ψ_k + δ)` (the alternation) and `c(ψ_k − δ) ≠ c(ψ_k + δ)` (`y_k` a change point); with two colours,
  `c(ψ_k + 60° + δ) = c(ψ_k − δ)`.
- **Two tiles.** `|r(ψ_k − δ) − r(ψ_k + 60° + δ)| = 2 sin(30° + δ) > 1`, more than a tile's diameter: `a ≠ b`.

So `a` and `b` are distinct tiles of one colour within distance below 1 of each other, against non-Siamese. (Without non-Siamese they still straddle: their
interiors hold points below 1 apart near the edges and points above 1 apart near the ring, so two interior points of one colour are exactly 1 apart.) ∎

*Where six is spent:* at the alternation — two colours absent at `p` (QFREE4, through SIX). With seven colours a ring may cycle three absent colours, and the
flank tiles of a double tip then differ (control fs116-y4-flank's plant `three`). *Controls of the list:* the strip and the disk carry (Q) arcs on their
four-colour rings; FS116-Y2-SIXFRAG is a six-colour vertex; R7's lattice points carry six of seven colours; SQ9 at `k = 9` has a Γ-free four-colour vertex
but no tip (its tiles of `p` do not reach `ω(p)`): every one is outside the class, as it must be for an empty class.

### 3.3 What it does to the brief's target and to the held results

- **P5, FS116-Y4-OBST — derived, at every radius above 1**: no fragment of the HEX3 class exists on any closed disc of radius above 1 about `p` (the HEX3
  class is a subclass of EMPTY's). The brief's "named radius at most 2" is met with room: `R_0` may be any number above 1.
- **P4, FS116-Y4-FRAG — FALSE**: by EMPTY no fragment of the HEX3 class exists at any radius above 1, so none above 2.
- **The target was posed for an empty class** — the finding the brief asked to hear about. Round 3's stalled form ("a … fragment … whose star is HEX3's …
  or the point inside radius 2 where every such fragment loses all six colours") has its answer below radius 2 for the reason that there is no such
  fragment at all: no point loses its colours; the configuration dies on `ω(p)`'s neighbourhood.
- **Vacuous, not wrong.** Every statement whose hypotheses include a Γ-free four-colour vertex in the non-Siamese simple class holds vacuously:
  FS116-Y3-SIX, -TIPS, -HUBCOL, -TIGHT, -NOQ, -LENS, -TIGHTLENS, -NBTIP, -STARFORCE (frozen, § 12 and § 14), FS116-N2-HEX6 and -HEX3, the last clause of
  RING-TRANSFER-C, and this record's FS116-Y4-SYM, -SPOKE and -Q1 (stage 2). Their arguments stay valid as arguments; what they describe has no member.
  FS116-N2-RECIP is not of this kind (its `p` need not be Γ-free).
- **For C114-LOCAL-F's case list:** the Γ-free ring type is removed at radius `1 + ε`. The (Q)-free rings that carry (R2) arcs after the bends
  (FS114-N6-RING60's class, where N7-HUB and N7-3T live) are not reached: there a change point of `κ` may end an (R2) arc, RING-GERM's tip is not given, and
  the double tip's existence is not shown. Whether FLANK closes them is the next question (§ 3.4).

### 3.4 Look-back

- **Could it have been foreseen?** Yes: FS116-Y3-TIGHT (round 3, § 2.4) states both edges — "`T1`'s cone ends at `210°`, and the edge it shares there with
  … `R_{50}`, colour `X̄` — lies in `B̄(y_1, 1)`" and "Likewise at `y_1` (`T1`'s cone starts at `210°`, inside `B̄(y_0, 1)`)" with `R_{12}` of colour `X̄` —
  and used each only against a far lens vertex. The two were never compared: the consequence left undrawn. G83's *Do* ("hunt the straddle along two unit
  circles") names the move.
- **Does it deform into its neighbours?** FLANK reads no colour and no Γ-freeness: it applies to any tile holding two ring points `60°` apart with full tip
  cones at both. Its neighbours: a (Q)-free ring with (R2) arcs (§ 3.3); a semi-hub (FS116-N3-SEMI) whose tip is shared with the next change point; and
  FS114-N7's open-cap family OC. Each is a case where a double tip's flank tiles may share a colour; each is unread here.
- **Is it new?** The mechanism is held (G83; FS114-Y5-PXKILL; FS114-N7-3T's straddles at `√3` and `1 + ε`). Its application to the Γ-free ring is not in
  FS-116's records; no outside search run — owed.

derivation: FS116-Y4-FLANK
  statement: let t be a tile of a valid fragment, Siamese pairs allowed, on a closed disc of radius above 1 about a point p, and let y = r(ψ) and y′ =
    r(ψ + 60°) be points of ω(p) in the closure of t such that the cone of t at y contains the open cone (ψ + 150°, ψ + 210°) and its cone at y′ contains
    (ψ + 210°, ψ + 270°); then t's cone at y ends at ψ + 210° and its cone at y′ begins at ψ + 210°, and if a is the tile bordering t at y along t's edge
    leaving y in the direction ψ + 210°, and b the tile bordering t at y′ along t's edge leaving y′ in the direction ψ + 210°, some point of the closure of a
    and some point of the closure of b are at distance below 1
  uses only: that a tile has diameter at most 1, so t ⊂ B̄(y, 1) ∩ B̄(y′, 1); that near a vertex an edge of Γ is a segment or a circular arc (a second-order
    expansion); |y − y′| = 1 with y′ − y = e(ψ + 120°)
  not claimed: anything about the colours of a and b; that a ≠ b; that the cones contain the open cones (an input, here from RING-GERM (i))
  argument: § 3.1 The flank lemma (FS116-Y4-FLANK)
  verdict: derived
  grade: hand
  minds: 1
  model: the Reuleaux triangle Reul(p, y_0, y_1) as t, its two arcs through p as the edges: points at turning angle φ are 2cos φ − 1 apart (control
    fs116-y4-flank)
  prior art: partly: FS114-Y5-PXKILL (two tiles of one colour bordering a third along unit arcs, within √(1 − 2tt′) < 1) and G83's straddle are the same
    mechanism; this form not searched — owed
  handoff: de Bruijn — a short lemma about two arcs inside two unit discs, after a blind second mind

derivation: FS116-Y4-EMPTY
  statement: no non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a ring carrying
    no arc of Γ
  uses only: FS116-Y3-SIX (six change points y_k, hubs, the ring alternating X and X̄, four tiles at p); FS116-Y3-TIPS (one tip per hub; a tile tipping two
    adjacent hubs); RING-GERM (i) and (ii) (the tip cone and the outer cone at a hub); FS116-N2-STAR (C(y) = A(p) ⊔ T ⊔ O); FS116-Y4-FLANK; non-Siamese
  not claimed: anything for rings carrying an arc of Γ that is not a (Q) arc (the (Q)-free rings of FS114-N6-RING60 after the bends, with (R2) arcs); anything
    in the Siamese or non-simple class; anything at k ≥ 7 (with three absent colours the flank tiles need not share a colour)
  argument: § 3.2 The class is empty (FS116-Y4-EMPTY)
  verdict: derived
  grade: derived from: FS116-Y4-FLANK, FS116-Y3-SIX, FS116-Y3-TIPS, RING-GERM
  minds: 1
  model: none can exist (the statement is a non-existence); its geometric step is control fs116-y4-flank, whose plant three shows where six is spent
  prior art: partly: the mechanism is G83's and FS114-Y5-PXKILL's; that the Γ-free four-colour vertex dies at 1 + ε is not in FS-116's records (round 3
    and FS116-N2 worked it as possible); no outside search — owed
  handoff: de Bruijn — with SIX, TIPS and RING-GERM, after a blind second mind; for D2, the Γ-free ring type removed from C114-LOCAL-F's case list at 1 + ε

derivation: FS116-Y4-OBST
  statement: for every R > 1, no fragment of the HEX3 class exists on the closed disc of radius R about p
  uses only: FS116-Y4-EMPTY (the HEX3 class is a subclass of its class)
  not claimed: anything outside the non-Siamese simple Γ-free class
  argument: § 3.3 What it does to the brief's target and to the held results
  verdict: derived
  grade: derived from: FS116-Y4-EMPTY
  minds: 1
  model: none can exist
  prior art: partly: as FS116-Y4-EMPTY
  handoff: none — the brief's answer; it rides on EMPTY's handoff

control: fs116-y4-flank
  of: FS116-Y4-FLANK and -EMPTY — 12 edge pairs (radii 1 and 1/2, turning angles 1°, 10°, 30°) below 1, the ring points above 1, flank colours agreeing at 6
    of 6 positions; the tangent segments (curvature 0) never go below 1
  run: python3 ../tools/fs116_y4_lattice.py flank | tail -n 1
  expect: FLANK: 12 of 12 edge pairs below 1; EMPTY's contradiction holds
  fault: python3 ../tools/fs116_y4_lattice.py flank --plant straight | tail -n 1

control: fs116-y4-flank-seven
  of: FS116-Y4-EMPTY — where six is spent: a ring cycling three colours (a seventh colour) makes the flank colours differ at every position
  run: python3 ../tools/fs116_y4_lattice.py flank | sed -n 14p
  expect: double-tip positions whose two flank ring arcs share a colour: 6 of 6
  fault: python3 ../tools/fs116_y4_lattice.py flank --plant three | sed -n 14p

## Stage 3 — SAVED
