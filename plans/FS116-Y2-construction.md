# FS116-Y2 — FS-116's construction side, round 2 (Y-QRING at the disk-corner configuration, then Y-SAT)

*Job FS116-Y2 (Ephodos, Opus 5.5), 2026-09-29, from `data/fs116/briefs/FS116-Y2-construction.md` and `plans/STANDING-RULES.md` (both read in full
first; `RUNNING.md` § Make the gate fail named by the brief). Working files `data/fs116/y2/`; exact checks `tools/fs116_y2_*.py`. Resuming check: no
record, tool or report of this job existed at start (`data/fs116/y2/` existed, empty). Every statement about a valid six-coloured fragment is about a
possible object: at six colours the class may be empty (the frozen list's preamble). Grades are my identity's grammar (`hand` = [hand], `derived
from` = [derived], `computed over` = [tools]).*

*Notation* (FS116-N1's, `plans/FS116-N1-proof.md` header, and the frozen list's § 0). `e(ψ)` the unit vector at angle `ψ`; `ω(z)` the unit circle
about `z`; `C(z)` the colours of the tiles whose closure holds `z`; `P = C(p)`. **N-E1**: if `z` is an interior point of a tile of colour `c` and
`|z − w| = 1` then `c ∉ C(w)`. **CL** (non-Siamese): two tiles of one colour with points less than 1 apart are one tile. A tile has diameter at most 1.
**The disk-corner configuration** (the brief's words, from FS116-N1-QDISK): a vertex `p` of at least four colours whose ring has a change point `y`
carrying two colours only, with `y ± 60°` inside (Q) arcs. In it I put `y = p + e(ψ)`, `u = p + e(ψ + 60°)`, `v = p + e(ψ − 60°)`; `X` (ring just
counter-clockwise of `y`) and `X̄` (just clockwise) are the colours absent at `p` (RING-GERM).

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| FS116-Y2-QT | the brief's two block quotations are verbatim in `data/fs116/claims.md` § 7, and its five unquoted attributions are present at their sources | [tools] | § 1.2; `tools/fs116_y2_quotes.py` |
| FS116-Y2-DCREAD | the disk realises the disk-corner configuration on all of its disc, so an exclusion of it on `B̄(p, 2)` (RING-Q's missing step) must read points outside the disk, which lie in the directions `(ψ + 157.4°, ψ + 324.5°)` about `p` — the side of `p` away from `y` | [hand; one mind; the window tools] | § 2.2; `tools/fs116_y2_six.py dcread` |
| **FS116-Y2-SIXFRAG** | **a valid six-coloured fragment by formula about a vertex of six colours** (its ring entirely `Γ`, every ring arc (Q)): the unit sector flower, six outer lenses, six gap tiles, holding `B̄(p, R)` for every `R < 3/2`; non-Siamese | [tools, exact; one mind] | § 2.3; `tools/fs116_y2_six.py frag` |
| **FS116-Y2-SIXOFF** | **no valid fragment, Siamese pairs allowed, in which `p` is a vertex of six colours whose tiles are the straight unit sectors and whose outer ring tiles are the six lenses over the arcs `[60j − 30°, 60j + 30°]` holds `B̄(p, √3)`**: both forced colour patterns leave a cone at `√3·e(60j)` with no colour | [hand; one mind; the six exclusions at the named points tools-exact] | § 2.4; `tools/fs116_y2_six.py point` |

## Would-have-searched-here log (standing rule 5)

- Stage 1: none (reading and recognition).
- Stage 2: (a) I would have searched re-rimmings of the disk for the disk-corner configuration beyond `φ`; instead I derived where any obstruction of it
  must read (FS116-Y2-DCREAD) and recorded the held stalls of the rim moves. (b) I would have searched colourings of the outer layers of a six-colour
  flower for the largest radius; instead the forced colours (the sector straddles, lens adjacency, the two cyclic patterns) were derived by hand and the
  stop point proved (FS116-Y2-SIXOFF); the one fragment built (FS116-Y2-SIXFRAG) is given by formula, its colouring the pattern the derivation forces.

## Fence log (standing rule 8)

- None: my brief fences nothing. The harness's start-up context included the auto-memory index (status lines, no proof content). I read no session
  transcript and no FS116-V2, FS121-V2 or FS121-D2/D3 record. I write about my work only here, in `data/fs116/y2/`, in `tools/fs116_y2_*.py` and in my
  report.

## G87 lookout

- Stage 1: none seen.
- Stage 2: none seen as two truths in collision. One near-miss classed: my own first-order reading of the point `x` beside `√3·e(0°)` ("the gap tile
  stays within `< 1`, so non-Siamese is needed") against the exact check (it straddles) — a slip of mine in a prediction, corrected before filing (§ 2.0),
  not two held results.

## Stage 1 — SAVED: the readback, and recognition on each claim

### 1.1 Read from disk (reading status)

- My brief and `plans/STANDING-RULES.md`, in full; `data/fs116/claims.md`, in full (§§ 0–10).
- `plans/FS116-Y1-construction.md`, in full; `tools/fs116_y1_quotes.py` read (read-only).
- `plans/FS116-N1-proof.md`: header, theorem list, logs, § 3 in full (RING-GERM, QDISK, the controls, § 3.4, the entries) and the hand-back;
  `data/fs116/n1/ring-survey.out` (the disk corner's ring word); `tools/fs116_n1_ring.py` header.
- `plans/FS116-local-exclusion.md` § 4.3–4.7 in full; § 2.2 (the stub's prior-art debts: Sirgedas's searcher, Gibbs's disk as the record).
- `plans/FS112-derivation.md`: FS112-CAL-DISK, FS112-DISK-S1, FS112-BUDGET2, FS112-STOP, FS112-DISK-RIM, FS112-FORCE, FS112-MOVE, FS112-DISC,
  FS112-Y3-PIN; `tools/fs112_yb2_objects.py` (the strip and the disk, lines 1–260); `plans/FS112-PA-reading.md` stage 3 excerpts (thread 7's disk
  question and the six-colour-vertex sketch `[08.17]`), and `plans/FS112-NB-verification.md`'s NB-SIX and C-V56 lines.
- `plans/FS114-derivation.md`: header, the milestone paragraph, FS114-CV-EXISTS, FS114-Y-PENT (with Y-DISKRIGID). `plans/FS114-Y*-construction.md` not
  re-read beyond what FS116-Y1 § 1.1 records (Y1 read their calibration and dial sections; I rely on the derivation file's entries for them).
- `plans/FS111-derivation.md`: FS111-M-R7, VMW-R7-MAX, VMW-R7-PPLUS, M-R7-FORCE, M-DEADLOCK, W-HEX7-RIGID, W-DECO-B.
- `plans/STUB-hole-dial.md` (`[Parts2020c]`'s void density `1.43·10⁻⁴`, one void per cell of area `≈ 0.461`; X₆); `BIBLIOGRAPHY.md` rows
  `[Parts2020c]`, `[Pritikin1998]`, `[Croft1967]`.
- `tools/fs114_yb_exact.py` header and function list (read-only; FS114-YB's exact curved-tile checker).
- The grokkings are in my context at launch (G82–G87 read for this job).

### 1.2 Readback (standing rule 3)

`tools/fs116_y2_quotes.py` (`data/fs116/y2/quotes.out`): **2 of 2 FOUND** — the brief's block quotations of Y-QRING and Y-SAT, verbatim in
`data/fs116/claims.md` § 7 — and **5 of 5 attributions PRESENT**: the brief's unquoted sentences about FS116-N1-QDISK (RING-Q false below `1.5985`),
"a fragment … beyond radius 2 makes RING-Q FALSE", "the construction side builds at that ring first" (plan § 4.5), FS116-Y1-STRIPCEIL, and the reading
of Y-SAT's target, each found at the source the brief names. Self-test PASS (`quotes-selftest.out`: an altered word MISSING, the faithful twin FOUND,
the wrong file MISSING).

**One finding about the brief (not a defect of mine):** "A fragment by formula holding the disk-corner configuration beyond radius 2 makes RING-Q FALSE
outright" drops RING-Q's class. RING-Q is stated "in a non-Siamese simple valid fragment on a closed disc of radius above 2" (claims § 5), so a fragment
refutes it only if it is also non-Siamese and simple. The brief copies FS116-N1 § 3.4's sentence, which drops the class in the same way. Y-QRING itself
(claims § 7) allows Siamese pairs, so the omission changes what a positive would refute, not what this job may build.

derivation: FS116-Y2-QT
  statement: the brief's two block quotations (Y-QRING, Y-SAT) are verbatim in data/fs116/claims.md § 7, whitespace aside, and its five named
    unquoted attributions are present at their sources
  uses only: the brief's text and the sources' text; whitespace and the brief's quotation prefixes normalised, nothing else
  not claimed: that the brief's unquoted glosses are faithful beyond the phrase checked (the RING-Q class omission above is a gloss the phrase check
    cannot see; it was found by reading)
  argument: § 1.2 Readback (standing rule 3)
  verdict: derived
  grade: computed over: the brief's 2 block quotations and 5 named attributions
  minds: 1
  model: the quotation of Y-QRING, found at claims.md § 7
  prior art: known: data/fs116/claims.md § 7 (the source the quotations are checked against)
  handoff: none — a readback, not mathematics

control: fs116-y2-qt
  of: FS116-Y2-QT — every block quotation found at its source; against the wrong file none is
  run: python3 ../tools/fs116_y2_quotes.py | tail -1
  expect: quotations: 2, all found: True
  fault: python3 ../tools/fs116_y2_quotes.py --source plans/STANDING-RULES.md | tail -1

My claims, restated beside the quotations (the quotations govern):
- **Y-QRING**: "a valid fragment on a closed disc of radius above `φ²/√2` about a vertex of at least four colours whose ring carries a (Q) arc — or a
  derived obstruction at a named radius." Aimed by the brief at the disk-corner configuration beyond radius 2.
- **Y-SAT**: "a valid fragment on `B̄(p, R)`, saturated on `B̄(p, R − 1)`, about a vertex `p` of at least four colours, for the largest `R` reached (…)
  — or a derived obstruction at a named radius." Read, as the brief says, with a geometry differing from the strip inside the unit disc.

### 1.3 Recognition — Y-QRING at the disk-corner configuration (`ephodos-recognition`, invoked fresh)

**The stall it starts from.** FS116-N1 § 3.4: RING-Q is GAP at a change point with a germ on a (Q) arc, and the disk's corner `A₀` realises the worst
case (all four germs on (Q) arcs, `y` of two colours) on a fragment holding `B̄(A₀, R)`, `R < 1.5985`, and `B̄(y, 1)`. FS112-DISC: every valid extension
of the disk holds `B̄(A₀, φ)` and none a larger disc about a vertex. So the configuration is known to live to radius `φ ≈ 1.618` and no further *in the
disk's own geometry*.

**For a stranger** (a combinatorial geometer on colourings of the plane that avoid distance 1): *six-colour a disc of radius `R` by finitely many
regions bounded by segments and circular arcs, no two interior points of one colour at distance exactly 1. At its centre `p` four regions of four
colours meet. On the unit circle about `p` there is a point `y` where exactly two regions meet (of the two colours missing at `p`), and the points of
that circle at `60°` on either side of `y` lie on arcs of the circle itself that separate two regions whose colours both occur at `p`. How large can
`R` be?* Words the reader would stop at: "change point", "(Q) arc", "ring", "germ" — all defined above from the reader's primitives; struck.

**"This is a …"**: a pair of complementary points at distance 1 — `p` carries four colours and `y` the other two, so (N-E1) every interior point of
`ω(y)` carries a colour of `p` and every interior point of `ω(p)` a colour of `y`. The configuration is the disk's corner and its two change points; in
the disk both change points and all four (Q) arcs occur, and the ring alternates violet/green every `60°` off `Γ` (`data/fs116/n1/ring-survey.out`).

**Features, sorted.**

| feature | sort | receipt |
|---|---|---|
| `y` of two colours at distance 1 from `p` of four | determines | N-E1 both ways: `ω(y)` off `Γ` carries only `P`, `ω(p)` off `Γ` only `{X, X̄}`; this is what RING-GERM (iii) fails to reach |
| the inner tiles of the (Q) arcs at `u` and `v` are tiles of `p` | determines | CL: an inner tile of colour `c ∈ P` has points within `< 1` of `p`, so it is `p`'s tile of colour `c` (non-Siamese only) |
| the Reuleaux pentagon `Z`, the rim tiles `R_k, S_k, T_k`, the five-fold symmetry | accompanies | the configuration's definition uses none of them; FS112-DISC's ceiling `φ` is set at the rim points `C_0, D_0` (colourless cone, FS112-DISK-RIM), which the configuration does not name |
| the radius at which the disk stops (`φ`, at `C_0`, `D_0`, directions `ψ + 223°`, `ψ + 259°` about `A₀`) | unsorted | whether the configuration forces a colourless point at radius `≤ 2` on that side is exactly RING-Q's missing step; no argument in hand |
| non-Siamese, simple | determines for RING-Q, accompanies for Y-QRING | RING-Q's class; Y-QRING allows Siamese pairs |

**Where an obstruction must read** (from the disk as a model): the disk's extension holds `B̄(A₀, φ)`; the disk itself holds `B̄(O, r)`, `r ≈ 2.1243`,
which contains `ω(y)` (`|y − O| + 1 ≈ 1.875`) and `ω(u)` (`≈ 1.47`), but not `ω(v)` (`|v − O| + 1 ≈ 2.35`). So an obstruction at radius 2 for the
configuration must read points outside `B̄(O, r) ∪ B̄(A₀, φ)` — in the directions about `p` around `ψ + 240°`, the side of `p` away from `y`. A proof of
RING-Q's missing step is therefore not a ring lemma; it propagates from `y` round to the far side of `p` (FS116-N1 § 3.4 said the same in radius).

**Homes, each with its test.**
1. *The literature's six-coloured discs* (Mixon's thread-7 question; Gibbs's disk, radius `≈ 2.1243`, the record; Sirgedas's searcher, non-Siamese,
   nothing above `≈ 1.82`, `plans/FS116-local-exclusion.md` § 2.2). Test: it holds no theorem, only objects; its best object is the configuration's own
   model. Held as the source of models; predicts nothing.
2. *Periodic six-colourings with holes* (`[Pritikin1998]`, `[Parts2020c]`): a hole-free disc of such a tiling is a valid fragment. Test: `[Parts2020c]`'s
   voids recur once per cell of area `≈ 0.461` (`plans/STUB-hole-dial.md`), so its hole-free discs are far below radius 2. **Dead** as a source of large
   fragments.
3. *The disk's geometry redesigned beyond the configuration's core* (the tiles `Z, W₀, P₀, P₄, W₁, P₁, P₂, T₁` kept, the rest free). Test: the held
   attempts on the disk's rim (FS112-MOVE: the colourless cone shrinks from `108°` to `36°` and does not close; FS112-Y3-PIN: the pinned corner is
   blocked by `Y₀`) apply at once and stall; FS114-Y-DISKRIGID says the disk's geometry has one colouring. A redesign must change the rim, not recolour
   it. Held as the construction family; worked in stage 2.
4. *The project's own ring theory* (RING-GERM, RING-TWIST-C, TWIST-D). Test: it predicts the local structure at `p` (stage 2's DC-ORDER) and nothing at
   radius 2. Held for the forced structure.

**The recognition, and where it differs from the plan.** The plan (§ 4.5, P3) and the brief aim the construction side at the disk-corner configuration
as *the* object for Y-QRING. Recognition finds that **Y-QRING as posed has a second, different target that no held record has built at or excluded**:
a vertex of **six** colours. At six colours such a vertex carries every colour, so (N-E1) no interior point of `ω(p)` can carry any colour and
`ω(p) ⊆ Γ` (FS112-NB's NB-SIX, two minds, filed as FS112-SIX); every arc of its ring then has both side colours at `p` and is a (Q) arc. De Grey and
Gibbs reached the six-sector picture in 2018 (`[08.17]`, `[08.18]`: "you get a circle divided into six tiles around the vertex … but what next?") and
the next layer's case analysis was never done (`plans/FS112-PA-reading.md` stage 3). Such a ring has **no change point**, so it bears on Y-QRING, G83's
killing test and C114-LOCAL-F, **not on RING-Q** (vacuous there). Reported to Keryx as a finding about the plan's framing: the ring types D2 must
exclude include the all-`Γ` ring of a six-colour vertex, which the plan's list (the strip's midline, the disk's corners, R7 at `k = 7`, the bowtie) does
not name — R7's lattice points have six colours at `k = 7`, where the seventh is absent and the ring is not all `Γ`.

### 1.4 Recognition — Y-SAT

**For a stranger**: as FS116-Y1 § 1.3 wrote it (a local fall colouring by six regular classes, maximal on the inner disc), with the strip's geometry
now excluded inside the unit disc (FS116-Y1-STRIPCEIL). **Features.** A straight edge at `p` is of SATPIN's tangent type (determines: FS116-O1-SATPIN,
M-PINCH); so each straight edge needs its partner colour one unit along the normal. **One consequence for the recognition's new home:** at a
six-colour vertex whose tiles are straight sectors, the partner point `x − ν` of a point `x` of a sector's ray lies just outside `ω(p)` in the direction
`60j − 30°` (for the ray between sectors `j` and `j + 1`), where stage 2's window law forbids that sector's colour; so the sector flower is never
saturated at `p` (worked in § 2 as a remark, not an entry). **Homes** as round 1 found them (fall colourings: a costume; morphology: the ladder; the
project's theory: the rung's collision). **The recognition:** Y-SAT needs a four-colour vertex whose edges' first rungs do not collide inside `B̄(p, 1)`;
no family with a free parameter meeting that demand is in hand, and this round spends its budget on Y-QRING first, as the brief orders.

**G87 lookout, stage 1:** none seen.

## Stage 1 — SAVED

## Stage 2 — SAVED: Y-QRING — the disk-corner configuration read for where it must break; a vertex of six colours built to `3/2` and stopped below `√3`

### 2.0 Registered before the runs of `tools/fs116_y2_six.py` (in its header, written before any run), and scored

- `frag`: VALID, NON-SIAMESE, SIX COLOURS AT `p`. *First run:* consistency reported 12 unmatched interior pieces — the ring arcs, which the sectors and
  the lenses split at different points (`60j` against `60j ± 30°`); both were split at every `30°` mark, a representation fix, and the rerun is the recorded
  one (`data/fs116/y2/six-frag.out`): **as registered**.
- `frag --plant patbreak` (Q₀ recoloured to Q₁'s colour): REJECT at `(Q₀, Q₁)`. *Scored:* REJECT at `(Q₀, Q₁)` **and** `(Q₀, G₅)` — the second not
  registered: recoloured Q₀ also touches the colour-3 gap tile at `e(−30°)`. A miss in wording, not in the check.
- `frag --plant grow` (cut at `8/5`): every `G_j` REJECTs against itself (diameter `2·(8/5)·sin(60° − arccos(4/5)) ≈ 1.257`). **As registered.**
- `point` (§ 2.4's step at `√3·e(0°)`): I registered by hand, to first order in the displacements, that five colours are straddled at `x` and that the
  sixth (colour 3 in pattern A, colour 2 in pattern B) is **not** straddled, its exclusion needing non-Siamese (CL). *Scored:* **all six straddled in both
  patterns** — the sixth by the gap tile's points along the lens boundary, where the second-order term `t²` (the horn between the two tangent circles at
  `e(∓30°)`) lifts the distance above 1. **The prediction lost, in the direction that strengthens the result:** the hand argument (§ 2.4) now runs by
  straddles alone and holds with Siamese pairs allowed. `point --plant move` (the point moved to `(√3 + 1/100, 0)`): a different colour is left
  unstraddled (colour 1 in pattern A, colour 4 in pattern B). **As registered.**

### 2.1 What was read about the disk-corner configuration, and the families

| family | free parameters | the configuration's demand beyond radius 2 | verdict |
|---|---|---|---|
| **D1** valid extensions of the disk about its corner `A₀` | the tiles beyond the rim | `B̄(A₀, R)`, `R > 2` | **dead above `φ`** (FS112-DISC, held: two minds on the bound, one on the attainment) |
| **D2** the disk's core kept (`Z, W₀, P₀, P₄, W₁, P₁, P₂, T₁`, the tiles that carry `p`, `y` and the (Q) arcs at `u`, `v`), the rim redesigned | every tile of the outer ring | the colourless points `C₀`, `D₀` at distance `φ` from `A₀` (directions `ψ + 223°`, `ψ + 259°`) removed | **stalled in the record**: FS112-MOVE (the colourless cone `108° → 36°`, not closed), FS112-Y3-PIN (the pinned corner blocked by `Y₀`), FS114-Y-DISKRIGID (the geometry has one colouring); no new member built this round |
| **D3** the capped strip | its upper band | a two-colour change point with `y ± 60°` inside (Q) arcs | **not a member**: the strip's midline change points are four-colour vertices whose `±60°` points *end* (Q) arcs (FS116-N1 § 3.3) |
| **D4** a vertex of six colours | the flower, the outer ring | — | **not a member** (no change point: its ring is all `Γ`); it is Y-QRING's other target, § 2.3–2.4 |

**Verdict on the disk-corner configuration: not landed** — no fragment holds it beyond `φ`, and no obstruction at radius 2 is derived. What is derived is
where an obstruction must look (§ 2.2).

### 2.2 Where an exclusion of the disk-corner configuration must read (FS116-Y2-DCREAD)

*Argument.* The disk (FS112-CAL-DISK: valid, exact, two checkers) holds the closed disc `B̄(O, r)`, `r² = (25 + 9√5)/10`, and realises the configuration at
`A₀`, `|A₀| = a`, `a² = (5 − √5)/10` (FS116-N1-QDISK; its class hypotheses non-Siamese and simple read in floats there). So a derivation that reads only
`B̄(A₀, 2) ∩ B̄(O, r)` cannot exclude the configuration: the disk is a counter-model to it. A point `A₀ + t·e(θ)`, `t ≤ 2`, leaves `B̄(O, r)` only if
`a² + t² + 2at sin θ > r²` (disk coordinates, `A₀ = (0, a)`), and the left side is largest at `t = 2`: so only if `sin θ > (r² − 4 − a²)/(4a) = (√5 − 2)/(4a)
≈ 0.11226`, i.e. `θ ∈ (6.4°, 173.6°)`, which about `A₀` is `(ψ + 157.4°, ψ + 324.5°)` with `ψ ≈ 209.01°` the direction of `y`. With FS112-DISC's grown
disk (valid, one checker) the region shrinks further to distance `> φ` from `A₀`; at `R = φ` the same window is exactly `(72°, 108°)`, the directions of
the grown tile `R₀` (the plant's output). ∎

derivation: FS116-Y2-DCREAD
  statement: any derivation that excludes, on the closed disc of radius 2 about p, the disk-corner configuration (a vertex p of at least four colours
    whose ring has a change point y of two colours with y ± 60° inside (Q) arcs) in RING-Q's class must read a point of that disc outside the disk of
    [Polymath2021] Fig. 10 placed with its corner A₀ at p and its change point at y, and every such point lies in the directions (ψ + 157.4°, ψ + 324.5°)
    about p, ψ the direction of y
  uses only: that the disk is a valid fragment on B̄(O, r) realising the configuration at A₀ (FS112-CAL-DISK, FS116-N1-QDISK); r² = (25 + 9√5)/10,
    a² = (5 − √5)/10, ψ ≈ 209.0102° (FS116-N1's ring survey); the maximum of |A₀ + t e(θ)| over t ≤ 2 is at t = 2
  not claimed: that the configuration is excluded at any radius; that an exclusion must read every point of the window; anything outside RING-Q's class
    (the disk's non-Siamese and simple readings are floats, FS116-N1)
  argument: § 2.2 Where an exclusion of the disk-corner configuration must read (FS116-Y2-DCREAD)
  verdict: derived
  grade: hand
  minds: 1
  model: the disk itself, about A₀
  prior art: partly: FS112-DISC (the disk's reach about A₀) and FS116-N1 § 3.4 (the gap is not local, stated in radius); the direction window is new here
  handoff: none — a scope statement for the proof side's RING-Q step (C-BEYOND in the claim list's sense)

control: fs116-y2-dcread
  of: FS116-Y2-DCREAD — the window at R = 2; at R = φ it is the grown tile's directions instead
  run: python3 ../tools/fs116_y2_six.py dcread | tail -1
  expect: R = 2.0000: sin t0 = 0.112257 (at R = 2 this is (sqrt5 - 2)/(4a)); window about A_0 in disk coordinates (6.4, 173.6) deg; relative to y at psi = 209.0102: (157.4, 324.5)
  fault: python3 ../tools/fs116_y2_six.py dcread --plant phi | tail -1

**What it says for the proof side.** RING-Q's missing step at radius 2 has to carry information from `y` round `p` to its far side — about `240°` from `y`,
where the disk's own extension breaks at `C₀`, `D₀`. A ring lemma at `y` cannot do it.

### 2.3 A vertex of six colours, by formula (FS116-Y2-SIXFRAG)

*Why it is Y-QRING's.* At a vertex carrying all six colours, N-E1 forbids every colour at every interior point of `ω(p)`, so `ω(p) ⊆ Γ` (FS112-NB's NB-SIX,
filed as FS112-SIX, two minds), and every ring arc has both side colours at `p`: every ring arc is a (Q) arc. In the non-Siamese class the inner tile of
each ring arc is `p`'s tile of its colour (CL), so each of the six tiles at `p` carries exactly one `60°` ring arc and lies in the Reuleaux triangle on it
(a remark, one mind; FS112-NB's C-V56 line is its prior form: "every tile `Z` meeting `B(V, 1)` is one of the six tiles at `V` or Siamese to the one of its
colour"). The simplest member takes the six tiles to be the straight unit sectors `S_j` (cone `[60j, 60j + 60°]`).

*The object* (`tools/fs116_y2_six.py`, exact in `ℚ(√3, √7)`): `S_j` coloured `j`; the lens `Q_j` — the points outside `ω(p)` within 1 of `e(60j − 30°)` and
of `e(60j + 30°)` — coloured `j + 2`; the gap tile `G_j` at `e(60j + 30°)` — the points outside `ω(p)` at distance at least 1 from `e(60j − 30°)` and from
`e(60j + 90°)` — coloured `j + 4` (mod 6); all cut at `|x| = 3/2`. *The check* (`data/fs116/y2/six-frag.out`): 36 same-colour pairs, **no REJECT**; **no
distinct same-colour pair at distance below 1** (non-Siamese); every interior piece shared by exactly two tiles and the 12 rim pieces forming the circle of
radius `3/2`, so the tiles tile the closed disc `B̄(p, 3/2)`; six colours at `p`. The plants fire (§ 2.0).

derivation: FS116-Y2-SIXFRAG
  statement: the unit sector flower S_j (colour j), the six lenses Q_j between e(60j − 30°) and e(60j + 30°) outside ω(p) (colour j + 2) and the six gap
    tiles G_j at e(60j + 30°) (colour j + 4), all cut at |x| = 3/2, form a valid non-Siamese six-coloured fragment holding B̄(p, R) for every R < 3/2, in
    which p is a vertex of six colours whose ring lies in Γ and all of whose ring arcs are (Q) arcs
  uses only: exact arithmetic in Q(√3, √7) (the cut points have cosine 3/4 and sine √7/4 at the lens corners); FS114-YB's exact pair verdict (every
    candidate distance compared with 1) and its map-consistency test; the 36 same-colour tile pairs, self-pairs included
  not claimed: any R ≥ 3/2 in this form (at 8/5 each G_j exceeds diameter 1: the plant); that the fragment extends; Y-QRING (3/2 < φ²/√2); that a vertex
    of six colours occurs in any valid map
  argument: § 2.3 A vertex of six colours, by formula (FS116-Y2-SIXFRAG)
  verdict: derived
  grade: computed over: the 18 tiles of the fragment and their 36 same-colour pairs, exact in Q(√3, √7)
  minds: 1
  model: the fragment itself
  prior art: partly: the six-sector picture at a six-colour vertex is de Grey's and Gibbs's ([Polymath16threads] [08.17], [08.18], 2018: "a circle divided
    into six tiles around the vertex … but what next?"); a fragment beyond the ring not found in print (FS112-PA-reading stage 3: the next layer's case
    analysis never done); no search of my own run (standing rule 5 does not bear; the debt is in the report)
  handoff: de Bruijn — an exact fragment in Q(√3, √7) with its pair certificate, a control object for any local exclusion that claims six-colour vertices;
    not urgent

control: fs116-y2-sixfrag
  of: FS116-Y2-SIXFRAG — the fragment holds every check; cut at 8/5 the gap tiles exceed diameter 1
  run: python3 ../tools/fs116_y2_six.py frag | tail -1
  expect: => FRAGMENT: VALID, NON-SIAMESE, SIX COLOURS AT p
  fault: python3 ../tools/fs116_y2_six.py frag --plant grow | tail -1

### 2.4 The offset flower stops below √3 (FS116-Y2-SIXOFF)

*Setting.* A valid six-coloured fragment on `B̄(p, R)`, Siamese pairs allowed, in which `p`'s tiles are the six straight unit sectors `S_j` (colours
`c_j`) and the tile covering the outer side of the ring near `e(60j)` is the lens `L_j` over the ring arc `[60j − 30°, 60j + 30°]` (as a tile, inside
`B̄(p, R)`). Suppose `R ≥ √3`, so each `L_j` lies whole in the disc and its far vertex `√3·e(60j)` is a point of the disc. Every step is a **straddle**: a
tile `T` is excluded at a point `x` when some tile of `T`'s colour has points at distance below 1 and above 1 from `x`'s neighbours in `T` (the interiors
being connected, two interior points are then exactly 1 apart).

*Step 1 (the lens colours).* Just outside `ω(p)` near `e(0°)`: `S_0`, `S_5` contain `e(0°)` and `p` (distances near 0 and above 1); `S_1` holds the points
`(1 − t)·e(60°)`, at distance `√(1 − t + t²) < 1` from `e(0°)`, and `p` — so colours `c_0, c_5, c_1` and (by the mirror) `c_4` are excluded, and `L_0` has
colour `c_2` or `c_3`; in general `L_j ∈ {c_{j+2}, c_{j+3}}`. Two lenses touching at `e(60j + 30°)` differ (the second has points beyond the first's arc,
more than 1 from the first's far corner). A cyclic 0/1 sequence that never steps from 1 to 0 is constant: **pattern A** (`L_j = c_{j+2}`) or **pattern B**
(`L_j = c_{j+3}`).
*Step 2 (the gap cones).* At `e(30°)` the outer cone `(0°, 60°)` between `L_0` (cone `[−60°, 0°]`) and `L_1` (`[60°, 120°]`) excludes `c_0` (`S_0` holds
`e(30°)`), `c_1`, `c_5` (the corners `e(60°)`, `e(0°)` of `S_1`, `S_5` at distance `0.518`) and the two lens colours (adjacency): it is **all `c_4`** in pattern
A, **all `c_2`** in pattern B; likewise the cone `(300°, 360°)` at `e(−30°)` is all `c_3` (A) or all `c_1` (B).
*Step 3 (the point `√3·e(0°)`).* `L_0` has cone `[120°, 240°]` there. For `x = √3·e(0°) + s·e(χ)`, `s` small, and a tile point `e(±30°) + t·e(δ)`:
`|x − y|² = 1 + 2s·cos(χ ∓ 30°) − 2t·cos(δ ∓ 30°) + O(s² + t²)`, the sign `∓` for the corner `e(±30°)`. **Pattern A, `χ ∈ (240°, 300°)`:** `c_0`, `c_5` by the
sectors; `c_2` by `L_0` (it holds `√3·e(0°)` and `e(30°)`, and `x` lies outside `B̄(e(30°), 1)`); `c_1` by `L_5` (cone `[240°, 300°]` at `e(−30°)`: the two
first-order terms have opposite signs); `c_4` by the gap tiles at `e(30°)` (cone inside `(0°, 60°)`: opposite signs); `c_3` by the gap tile at `e(−30°)`
adjacent to `L_5`, whose points `e(−30°) + t·e(300°)` lie on its side of `L_5`'s arc and give `|x − y|² = 1 + 2s·cos(χ − 30°) + t² + O(st + s²) > 1` at
`t = 2√s`, while its points in directions near `330°` give `< 1` — the horn between the tangent circles `ω(e(−90°))` and `ω(√3·e(0°))`. **Pattern B,
`χ ∈ (60°, 120°)`:** `c_0`, `c_5`; `c_3` by `L_0`; `c_4` by `L_1` (cone `[60°, 120°]` at `e(30°)`); `c_1` by the gap tiles at `e(−30°)`; `c_2` by the gap tile at
`e(30°)` adjacent to `L_1`, the mirror horn. So in either pattern a cone of directions at `√3·e(0°)` carries no colour, and no fragment of the setting
holds a neighbourhood of `√3·e(0°)`: `R < √3`. ∎

*Exact at named points* (`data/fs116/y2/six-point-*.out`): at `x = (√3, −1/100)` (pattern A) and `(√3, +1/100)` (pattern B), every colour is straddled by
exactly the tiles the argument names (the gap tiles as small pieces with their full cones at `e(±30°)`); moved to `(√3 + 1/100, 0)`, one colour is freed
(the plant).

derivation: FS116-Y2-SIXOFF
  statement: no valid six-coloured fragment on B̄(p, R), Siamese pairs allowed, in which p is a vertex whose six tiles are the straight unit sectors
    S_j and whose tile covering the outer side of the ring near e(60j) is the lens over the ring arc [60j − 30°, 60j + 30°], for each j, has R ≥ √3
  uses only: the straddle principle (a tile's interior is connected); the sectors' corners and p; the lenses' corners e(60j ± 30°) and far vertices
    √3 e(60j) with their cones there; the forced colours of Steps 1–2 (two cyclic patterns; the gap cones single-coloured); second order along the lens
    boundary in Step 3 (the horn); no non-Siamese hypothesis, no count of colours beyond six at Step 3's exclusions
  not claimed: anything for flowers whose tiles are not straight sectors (e.g. alternating Reuleaux and cusped tiles, where the corner straddles of Step 1
    change); anything for outer rings that break away from the arc midpoints; that any R in (3/2, √3) is attained; anything at k ≥ 7 (with a seventh colour
    the cone at √3 e(0) is coloured, as in R7's family)
  argument: § 2.4 The offset flower stops below √3 (FS116-Y2-SIXOFF)
  verdict: derived
  grade: hand
  minds: 1
  model: FS116-Y2-SIXFRAG, a member of the setting on every B̄(p, R) with R < 3/2
  prior art: partly: the six-sector picture at a six-colour vertex is [Polymath16threads] [08.17]–[08.18]'s; the layer after it is not done there
    (FS112-PA-reading stage 3); no search of my own run — owed
  handoff: none — a no-go for one family of one ring type, for D2's list of ring types; it enters no proof of a value

control: fs116-y2-sixoff-a
  of: FS116-Y2-SIXOFF — pattern A: every colour straddled at (√3, −1/100); moved to (√3 + 1/100, 0) colour 1 is freed
  run: python3 ../tools/fs116_y2_six.py point --pattern A | tail -1
  expect: => unstraddled colours at x: []
  fault: python3 ../tools/fs116_y2_six.py point --pattern A --plant move | tail -1

control: fs116-y2-sixoff-b
  of: FS116-Y2-SIXOFF — pattern B: every colour straddled at (√3, +1/100); moved to (√3 + 1/100, 0) colour 4 is freed
  run: python3 ../tools/fs116_y2_six.py point --pattern B | tail -1
  expect: => unstraddled colours at x: []
  fault: python3 ../tools/fs116_y2_six.py point --pattern B --plant move | tail -1

**What it says for Y-QRING.** A vertex of six colours is a ring type Y-QRING admits and RING-Q does not see. Its most symmetric family lives on every disc of
radius below `3/2` (exact) and dies below `√3 < φ²/√2`, Siamese pairs allowed: it does not meet G83's killing test. The general six-colour vertex is
**GAP** at two named freedoms — the flower's shape (Reuleaux or cusped tiles in place of sectors) and the outer ring's break points — and a no-go for the
whole ring type would be a piece of D2's exclusion. *A remark for Y-SAT:* the sector flower is never saturated at `p` — a ray between `S_j` and `S_{j+1}` is
straight, so its partner point for `S_j`'s colour lies just outside `ω(p)` near `e(60j − 30°)`, where Step 1's straddles exclude `c_j`.

### 2.5 Verdict on Y-QRING this round

**Not landed**: no fragment beyond `φ²/√2` about a (Q)-ring vertex of at least four colours, and no obstruction for the class at a named radius. Landed on the
way: where the disk-corner configuration's exclusion must read (FS116-Y2-DCREAD); the first exact fragment about a vertex of six colours
(FS116-Y2-SIXFRAG, to `3/2`); and the stop of its symmetric family below `√3`, Siamese allowed (FS116-Y2-SIXOFF). The families tried and their free
parameters: § 2.1 (the disk-corner configuration: D1–D4) and the six-colour setting of § 2.4 (free: the radius; forced: the colours; the flower and the
lens break points held fixed, and named as the open freedoms).

**G87 lookout, stage 2:** none seen (the near-miss is in the log above).

## Stage 2 — SAVED
