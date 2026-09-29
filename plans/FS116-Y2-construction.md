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

## Would-have-searched-here log (standing rule 5)

- Stage 1: none (reading and recognition).

## Fence log (standing rule 8)

- None: my brief fences nothing. The harness's start-up context included the auto-memory index (status lines, no proof content). I read no session
  transcript and no FS116-V2, FS121-V2 or FS121-D2/D3 record. I write about my work only here, in `data/fs116/y2/`, in `tools/fs116_y2_*.py` and in my
  report.

## G87 lookout

- Stage 1: none seen.

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
