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

## Would-have-searched-here log (standing rule 5)

- Stage 1: none (reading and recognition).

## Fence log (standing rule 8)

- My brief fences nothing for me; it asks me to write nothing about my work outside this record, `data/fs116/y4/`, `tools/fs116_y4_*.py` and my report, and
  to message no other job (FS116-V5 is blind to every FS-116 record). The harness's start-up context held the auto-memory index (status lines, no proof
  content). I read no session transcript. My readback tool opens `data/fs116/briefs/FS116-V5-verify.md` only to find the string `FS116-Y3-STARFORCE` (the
  brief's "a blind verifier is checking it now"); I read nothing else of it, and no FS116-V5 or FS121-Z1 record.

## G87 lookout

- Stage 1: none seen as two truths in collision.

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
