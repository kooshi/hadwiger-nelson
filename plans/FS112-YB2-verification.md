# FS112-YB2 — round-2 blind verification of FS-112's construction side (the six-coloured disk and the strip's stopping points)

*Job FS112-YB2, de Bruijn on Opus 5.5, launched 2026-09-27 at HEAD `b5f5db3b`. Brief: `data/fs112/briefs/YB112-verify-construction.md`, overridden by
the instance file `data/fs112/briefs/YB2-112-instance.md`, with `data/fs112/briefs/STANDING-RULES.md`. My checker `tools/fs112_yb2_check.py` is
written without reading Y's, Y2's or YB's checker code; Fig. 10 is transcribed by eye and the transcription committed before any solve; my verdicts on
O1–O5 are committed (step 3) before I open Y2's section, tools or outputs. Every object below is a local positive, not a map of the plane.*

## Theorems this phase proved

(filled at each stage; one line per theorem, its grade and its address)

## Would have searched here (standing rule 3)

- Stage 2: none (a checker built from a derivation, calibrated on held objects).

## Fence log (standing rule 13; brief § Fences; instance)

- Start-up: `ls data/fs112/` listed directory **names**, among them the fenced `fs112-a2`, `fs112-a3`, `fs112-y` — names only, nothing in them listed,
  opened or grepped. `ls data/fs112/briefs/` listed the brief file names (other briefs fenced; none opened but mine, my instance file,
  `Y112-construction.md` not yet, and `STANDING-RULES.md`).
- `plans/FS112-Y-construction.md`: I read lines 1–266 only (round 1, open to me), having located the fenced heading "§ Continuation — FS112-Y2" at
  l. 267 by a `grep -n "Continuation"` that printed that one heading line and nothing of its section.
- Owner's message during stage 1 (fence addition, effective at once): FS112-Y3's `plans/FS112-Y3-construction.md`, `tools/fs112_y3_*.py` and
  `data/fs112/fs112-y/y3_*` are fenced until my step 3 is committed; after it, read only if step 4 needs them. Logged; nothing of them touched.

## Stage 1 — SAVED: reading; the quotation check

### 1.1 Read from disk, in this order

`STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim and § Counter-priors **from disk** (they differ from my context's snapshot in link 2, which
on disk adds `[GwynStavrianos2022]` and the choice remark; I work from disk), G20, G21, G22, G60 (unchanged from my snapshot); `LEDGER.md` rows 133–134;
`data/fs112/claims.md` in full (§0 and §7 closely); `plans/FS112-unit-arc-half.md` stage 5 (§§5.1, 5.2, 5.4–5.7 and the addendum; **not §5.3**);
`plans/FS112-PA-reading.md` (stages 1, 6, 8, 9) and the extracts `[07.10]`, `[07.15]`–`[07.19]`, `[07.45]`–`[07.50]`, `[08.12]`, `[09.100]`, `[11.1]`,
`[11.34]`, `[11.35]`, `[16.91]`, `[16.105]`, `[16.106]`, `[16.346]`, `[16.347]`, `[17.181]`; round 1 of `plans/FS112-Y-construction.md` (ll. 1–266); YB's
record `plans/FS112-YB-verification.md` in full and report `data/fs112/reports/FS112-YB.md`; `[Polymath2021]` pp. 194, 197–200 (PDF pp. 30, 33–36, text
layer) and **Fig. 10 viewed at 600 dpi** (PDF p. 36, the paper's p. 200) with its caption; the frozen FS-110 tools `tools/fs110_y_check.py` (in full),
`tools/fs110_y_fragments.py` and `tools/fs110_y_cone.py` (their object formats and drivers), `data/fs110/fs110-a6/a6_c2_single_horn.py` (in full);
YB's `tools/fs112_yb_strip.py` **for its object format only** (its `Strip` class and `check_strip` driver) and the data-representation lines of
`tools/fs112_yb_check.py` (the classes `F`, `Seg`, `Arc`: fields and orientation convention), so that my checker can take YB's strip object as input.
I did not read YB's pair logic, candidate list or sign code: my checker's logic is my own.

### 1.2 Quotation check (standing rule 5) — `tools/fs112_yb2_quotes.py`, output `data/fs112/fs112-yb2/quotes.out`

20 quotations: the brief's `[AxenovichEtAl2014]` sentences; the instance's `[11.34]` phrase; the standing rules' five Kooshi quotations; and those I use
below from the claim list, `[Polymath2021]` pp. 194–200 and the threads (`[07.49]`, `[07.50]`, `[11.34]`'s radius, `[16.91]`, `[16.106]`, `[16.346]`).
**19 of 20 verbatim.** One difference: standing rule 4's *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."*
carries a terminal period inside the quotation marks that `CLAUDE.md` (item 23) does not have — punctuation only, the words exact. Normalisation stated in
the tool (whitespace; typographic quotes; the `[Polymath2021]` text layer read in plain and `-layout` modes, because plain mode dehyphenates the printed
"unit-/edge" by itself). `--self-test`: an altered word turns FOUND into MISSING (`quotes-selftest.out`).

The Fig. 10 caption's radical is garbled in the text layer; on the page image (600 dpi) it reads "Figure 10: A 6-tiling of a disk of radius
√(5/2 + 9/(2√5))." — as the claim list §7 quotes it. The instance's radius `√((25 + 9√5)/10)` is not a quotation; its identity with `[11.34]`'s
printed `r = φ·√((15+√5)/10)` and with the caption is checked exactly at stage 3.

**No paraphrase found in my brief or instance file.** One naming point, not a paraphrase: the instance's O4 names `A₁ = (3/4, √15/4)` "YB's O3 placing"; in
YB's own labels that point is `A_1`, and in Y's round-1 labels `A₁` too (both `(3/4, √15/4)`): consistent.

## Stage 1 — SAVED

## Stage 2 — SAVED: my exact checker over towers of square roots, calibrated (brief step 1; instance: strip first, then plants)

**The checker** `tools/fs112_yb2_check.py` (written without reading Y's, Y2's or YB's checker logic). *Arithmetic:* a `Tower` is
`Q(√d₁)(√d₂)…(√d_n)`, each `d_k` a positive element of the level below; an element of level `k` is a pair `(a, b)` = `a + b√d_k`. Sums and products are
identities in the square roots; **the sign is exact by recursion** — `sign(a + b√d)` from `sign a`, `sign b` and `sign(a² − b²d)` — a statement about
real numbers that stays correct even if a radicand is a square lower down; inversion raises (never guesses) if a conjugate norm vanishes at a nonzero
element. Towers are built per object (`Q(√3)` for FS-110's fragments; `Q(√3)(√5)` for the strip; up to five levels for YB's radius plants; the disk's
at stage 4). *Verdict:* for a same-colour tile pair (a tile with itself included) REJECT iff `m < 1 < M`, `m`, `M` the exact minimum and maximum
cross-distance; each is decided against 1 exactly (`<`, `=`, `>`), with float values printed beside. *Completeness:* the candidate list holds every pair
of points that can realise an extreme (endpoint–endpoint; endpoint to a segment's foot; endpoint to an arc's radial points; segment–arc pairs along the
normal through the arc's centre; arc–arc pairs on the line of centres, radial and antipodal pairs for concentric arcs), each checked to be realised, each
of the form `|√A + B|` compared with 1 exactly. **No map hypothesis:** whether two tiles meet is decided exactly (incident endpoints, segment crossings,
segment–circle and circle–circle intersection points written `a + b√Δ` and tested on both pieces).

**Self-test** (`--selftest`, `data/fs112/fs112-yb2/selftest.out`): ten exact controls — a Reuleaux triangle of width 1 (ACCEPT), two at gap exactly 1
(ACCEPT), squares of diagonal 0.99 and 1.06, two squares at gap 9/10, two unit caps whose nearest pair is interior to both arcs, a cap facing a bar
(nearest pair interior to arc and bar), two long bars crossing, a thin crescent crossed by a bar **only at its arcs**, and two crescents crossing **only
arc to arc**. **Seven checker plants, each flipping exactly the controls predicted and no other:** `noself` (the 1.06 square), `endpoints_only` (both
interior-pair controls), `no_interior` (the same two), `no_meet` (the three crossing controls — each built so that every critical candidate is at least
1.13 while the tiles cross, so only the exact meeting test can see them), `closed_interval` (the two tight Reuleaux controls: tightness visible),
`cw_arcs` (both Reuleaux controls turn REJECT; the caps, the cap–bar and the crescent–bar turn ACCEPT; the two crescents stay REJECT because their
complementary circles still meet near `(2.0, −1.51)`). **Two slips of mine, both caught before any verdict was used:** my first cap–bar control had bar
corners 0.924 from the arc, so `no_interior` could not have flipped it (the plant's failure mode unreachable — rebuilt with the bar `|y| ≤ 7/10`), and
my first arc-crossing controls also crossed at a straight chord (a segment test, not the curved one — rebuilt as crescents); and I registered **no**
flips for `cw_arcs` by omission, the first run showed flips, and I derived the set above by hand before reading which controls had flipped.

**Calibration** (`tools/fs112_yb2_calib.py`; outputs `calib-frag.out`, `calib-cal7.out`, `calib-strip.out`):

| # | object | pairs | verdict | against |
|---|---|---|---|---|
| 1 | FS-110's S1, T2, BB, MX, WC, WC1, WCEQ, WCH, WC1H; the builders' planted faults `s1_flat`, `t2_flip`, `t2_flat`, `t2_six`, `bb_rot`; the eight tip tests; A6-C2 and its ten runs; every fragment under `closed_interval` in both checkers — built by the frozen builders (imported, unedited), converted exactly | **1,663 pairs**, each also run through the frozen checker in the same process | **every verdict agrees pair by pair** (89 REJECTs on both sides, the same pairs) | `tools/fs110_y_check.py` |
| 2 | **CAL-7, the claim list's object**: row 33's brick (`4/5 × 3/5`, shear `2/5`, colour `(i + 3j) mod 7`), cell `(0,0)` against itself and every same-colour cell with `|i|, |j| ≤ 5`, the rest dismissed by an exact gap bound (`≥ min(hR, R(w − s))`, squared ≥ 4) | 17 | **ACCEPT**; exact contacts at 1: the cell's own diagonal and the cells `(±1, ±2)` | `Seven.lean`'s docstring |
| 2′ | the variants `Seven.lean` records: `h = 1/2`, `w = 1`, `c = 2, 4, 6`, shear 0 (Lean `check false`); `c = 5` at shears 2/5 and 4/15 (Lean `check true`); `closed_interval` on the brick; and the frozen checker's hexagonal controls | 17–19 each | REJECT, REJECT, REJECT ×3, REJECT; ACCEPT ×2; REJECT (tight); hex7 ACCEPT, hex7 at side 11/20 REJECT, hex4 REJECT | each as recorded |
| 3 | **YB's strip object** (`tools/fs112_yb_strip.py`, run in-process, never edited), converted exactly into `Q(√3)(√5)` | **90 orbit pairs** (YB's own list) | **ACCEPT, every pair agreeing with YB's checker**; my exact contacts at 1: **36**, the number YB reports | `tools/fs112_yb_check.py` |
| 3′ | YB's four strip plants (arc radius 11/10, 9/10, edges raised 1/100, a colour swap) and `closed_interval` in both checkers, each in the tower of the primes it uses (up to `Q(√2, √3, √7, √13, √23)`) | 90–97 each | the same rejected pairs as YB's checker in every case (6, 18, 6, 3; 36 under `closed_interval`) | YB's checker |

**The instance's requirement is met**: the checker reproduces YB's verdict on YB's own strip object, pair by pair; and it reproduces the frozen FS-110
checker's verdicts pair by pair on 1,663 pairs, including every REJECT. **The suspect verdict is ACCEPT** (claim list §9): every ACCEPT above prints pairs
examined against pairs present, and the plants show which kinds of pair the ACCEPTs rest on (interior pairs, crossings, self-pairs, tight contacts).

## Stage 2 — SAVED

## Stage 3 — SAVED: `[Polymath2021]` Fig. 10 transcribed by eye (the D5 conditions), committed before any solve

*Source: PDF p. 36 of `~/source/library/geombinatorics/geombinatorics-v30-n4-2021-04.pdf` (the paper's p. 200), rendered at 300 and 600 dpi, viewed
whole and in five crops (top, left, bottom, right, centre). **Read: tiles, colours, adjacencies, junctions, which edges are curved and which straight,
the direction each curved edge bulges.** Not read: any coordinate, length or angle (no pixel is used as data; D5). Where the figure is read for a
qualitative feature that fixes geometry (parallel sides, mirror symmetry), it is marked **(reading)** and the rebuild says how it enters.*

### 3.1 The labelled points and the colours

- Six colours in the figure: red, orange, yellow, green, blue, violet. Labels printed on the figure: **A** (at the top vertex of the central red tile),
  **B** (inside the orange tile, at its upper-left corner), **C**, **D** (at the two upper corners of the top red tile, on the rim), **E** (inside the
  yellow tile, at its upper-right corner). By the printed words these are "the vertices of a unit-edge regular pentagon" (p. 199).
- **Notation (mine).** Sectors `k ∈ ℤ/5`, counter-clockwise, sector 0 the top one (the one holding the labels). `A_k` = the `k`-th vertex of the
  central tile (A = `A_0`, `A_k` = `A_0` turned by `72k`°). Non-red colours indexed cyclically: `c(0)` blue, `c(1)` green, `c(2)` yellow, `c(3)` orange,
  `c(4)` violet (the order in which blue, the colour of the tile above A, moves under a turn of 72°: see 3.3).

### 3.2 The tiles (26), per sector `k` (five tiles each) and the centre

| tile | where | corners (counter-clockwise description) | colour (sector 0 read; all sectors read) |
|---|---|---|---|
| `Z` | the centre | the five points `A_0 … A_4`; its five edges are curved, bulging outward | red |
| `W_k` "wedge" | above `A_k`, between the arches `P_{k−1}` and `P_k` | `A_k` (a point: the wedge comes down to `A_k`), `X_k`, `U_k`, `U′_k`, `X′_k` | `c(k)`: `W_0` blue, `W_1` green, `W_2` yellow, `W_3` orange, `W_4` violet |
| `P_k` "arch" | across the central edge `A_k A_{k+1}` | `A_k`, `X_k`, `B_k` (its apex, away from the centre), `Y_k`, `A_{k+1}` | `c(k+3)`: `P_0` orange, `P_1` violet, `P_2` blue, `P_3` green, `P_4` yellow |
| `R_k` | on the rim, above `W_k` | `C_k`, `U_k`, `U′_k`, `D_k` and the rim from `D_k` to `C_k` | red, all five |
| `S_k` | on the rim, above `P_k`'s edge `X_k B_k` | `B_k`, `X_k`, `U_k`, `C_k`, the rim from `C_k` to `F_k`, `F_k` | `c(k+4)`: `S_0` violet, `S_1` blue, `S_2` green, `S_3` yellow, `S_4` orange |
| `T_k` | on the rim, above `P_{k−1}`'s edge `Y_{k−1} B_{k−1}` | `D_k`, `U′_k`, `X′_k`, `B_{k−1}`, `F_{k−1}`, the rim from `F_{k−1}` to `D_k` | `c(k+1)`: `T_0` green, `T_1` yellow, `T_2` orange, `T_3` violet, `T_4` blue |

Identities read from the junctions: **`X′_k = Y_{k−1}`** (the wedge `W_k`, the rim tile `T_k` and the arch `P_{k−1}` meet there) and **`B_{k−1} = E`-point of
sector `k`** (the label E sits at `B_4`, the apex of the yellow arch `P_4`; the label B at `B_0`, the apex of the orange arch `P_0`). So the five pentagons
`A_k B_k C_k D_k B_{k−1}` are "connected" at the apexes, each apex shared by two consecutive pentagons — `[11.34]`'s "five connected regular pentagons".

**The colouring is five-fold with a colour permutation, and mirror-symmetric with another** (read, every tile): a turn by 72° carries each tile to its
namesake in the next sector and each non-red colour `c(j)` to `c(j+1)`, red fixed; the reflection in the vertical line through `A` carries `W_k ↔ W_{−k}`,
`P_k ↔ P_{−1−k}`, `S_k ↔ T_{−k}`, `R_k ↔ R_{−k}` with the colours `(green violet)(orange yellow)`, blue and red fixed. (Checked tile by tile: `P_0` orange
↔ `P_4` yellow; `S_0` violet ↔ `T_0` green; `S_1` blue ↔ `T_4` blue; `S_2` green ↔ `T_3` violet; `W_1` green ↔ `W_4` violet; `W_2` yellow ↔ `W_3` orange;
`P_2` blue fixed.)

### 3.3 Vertices (30 interior, 15 on the rim) and their colour sets

| vertex | tiles meeting there | colours (sector 0) | degree |
|---|---|---|---|
| `A_k` | `Z`, `P_{k−1}`, `W_k`, `P_k` | red, yellow, blue, orange — **four colours** | 4 |
| `X_k` | `P_k`, `W_k`, `S_k` | orange, blue, violet | 3 |
| `U_k` | `W_k`, `S_k`, `R_k` | blue, violet, red | 3 |
| `U′_k` | `W_k`, `R_k`, `T_k` | blue, red, green | 3 |
| `X′_k = Y_{k−1}` | `W_k`, `T_k`, `P_{k−1}` | blue, green, yellow | 3 |
| `B_k` | `P_k`, `S_k`, `T_{k+1}` | orange, violet, yellow | 3 |
| rim `C_k` | `R_k`, `S_k` | red, violet | — |
| rim `D_k` | `R_k`, `T_k` | red, green | — |
| rim `F_k` | `S_k`, `T_{k+1}` | violet, yellow | — |

The four-colour vertices are exactly the five `A_k` — de Grey's "{1,3,5,6} junction (at 2 o’clock on the central tile of the main disc; call it B)"
(`[16.106]`), and Sirgedas's "quads" (`[16.346]`). Euler's count: 45 vertices, 70 edges (55 interior, 15 on the rim), 26 tiles + the outside: 45 − 70 + 27 = 2.

### 3.4 Edges: which are curved, and where each curved edge is centred

**Curved (20), each bulging as stated; read as unit arcs** (the p. 198 words "we again employ the tactic of drawing inter-tile boundaries as arcs of
radius 1", p. 194's tactic, `[16.346]` "Arrows in the dual graph correspond to curved edges in the tile graph. Each quad in the dual graph “emits” four
arrows."). **Centres**: each curved edge is centred at the corner of its inner tile that is opposite it — the rule the strip's words state ("a circular arc
of radius 1 centered at the opposite corner of the tile") — which puts **four arcs at each `A_k`** and none elsewhere, as "each quad emits four arrows" says.

| curved edge | between (inner \| outer) | bulges | centre (the inner tile's opposite corner) |
|---|---|---|---|
| `A_{k+2} A_{k+3}` (an edge of `Z`) | `Z` \| `P_{k+2}` | away from the centre | `A_k` |
| `U_k U′_k` (the wedge's far edge) | `W_k` \| `R_k` | away from the centre | `A_k` |
| `Y_k B_k` | `P_k` \| `T_{k+1}` | away from `P_k` | `A_k` |
| `X_{k−1} B_{k−1}` | `P_{k−1}` \| `S_{k−1}` | away from `P_{k−1}` | `A_k` |

**Straight (35):** the wedge's four sides `A_k X_k`, `X_k U_k`, `U′_k X′_k`, `X′_k A_k`; the rim tiles' sides `U_k C_k`, `U′_k D_k`, `B_k F_k`. (Every straight
edge looks straight at 600 dpi; no curved edge looks like a segment.) **Rim (15):** arcs of the disk's boundary circle.

### 3.5 Readings that fix geometry beyond the printed words (stated before any solve; each enters the rebuild as named)

- **(reading P) Each arch's two straight sides look parallel to its axis** (clearest at `P_2`, whose sides both look vertical). In the rebuild this is not
  taken from the figure: it is the bound derived at A (§3.6), met with equality; the figure is consistent with it.
- **(reading M) The geometry looks mirror-symmetric** about each line through the centre and an `A_k` (and so about each line through a `B_k`): I read
  it as full five-fold dihedral symmetry of the geometry. It enters the rebuild in one place: the rim tiles' boundary `B_k F_k` then lies on the
  mirror line through `B_k`, i.e. is **radial**. Not printed; `[07.50]` prints only the five-fold turn ("(Same thing at the equivalent tiles at
  multiples of 72 degrees rotated, of course.)").
- **(reading W) Where the wedge's far arc `U_k U′_k` ends** is not printed and not fixed by the combinatorics. The rebuild takes the bound derived at A
  (§3.6) with equality.

### 3.6 Two bounds read off the transcription at the four-colour vertex (hand, before any solve; they aim the rebuild, the checker decides)

At `A_0` (every colour of every arc centred there is present at `A_0`, so every arc there is an out-contact — kind **both** once the inner tile's
self in-contact is counted): a tile of colour `s_out` at the centre must lie in the wedge facing away from the arc, to first order at the centre (for
`q = A_0 + t d`, `|q − (A_0 + e)|² = 1 + t² − 2t d·e`, which is below 1 for small `t` iff `d·e > 0`).
- The arc `X_4 B_4` (centred `A_0`, outer tile `S_4`, colour `c(3)` = orange = `P_0`'s colour at `A_0`) ends at `B_4`, and `B_4 − A_0` points at 36°
  (`A_0 B_4` is the pentagon's edge AE). So **`P_0`'s straight side at `A_0` points at 126° or more** (at least 90° from 36°); by the mirror reading the
  same for every arch at each end. **Equality (126°) is reading P**: the side is then parallel to `P_0`'s axis.
- The arc `U_0 U′_0` (centred `A_0`, outer tile `R_0`, red = `Z` at `A_0`): `Z`'s cone at `A_0` starts at the tangent of `Z`'s edge `A_0 A_1`, at 198°
  (the chord at 216° less half the edge's 36° opening). So **`U_0` lies at 108° or less** from `A_0` (at least 90° from 198°). The rebuild takes 108°.
- The other two arcs at `A_0` (`Z`'s far edge, outer `P_2`, colour blue = `W_0`; `Y_0 B_0`, outer `T_1`, yellow = `P_4`) impose the mirror images of the
  first and nothing new on `W_0` (its cone lies well inside the allowed one).

**Ambiguities reported, not resolved by a solver (D5):** (i) whether the figure's arch sides are exactly parallel (reading P) and `U_k` exactly at 108°
(reading W) — the rebuild uses the derived bounds with equality and says so; the checker's verdict is for that member only; (ii) the rim boundary `B_k F_k`
radial (reading M); (iii) nothing else: the combinatorics (tiles, colours, junctions, which edges curve and which way) read without ambiguity at 600 dpi.

### 3.7 Expectations registered before the solve (hand; each scored at stage 4, both outcomes reachable)

- **E-r.** The rebuild reproduces `r² = (25 + 9√5)/10` exactly, with `C_k, D_k` on the rim (the built-in control). Unreachable-outcome check: a wrong
  skeleton (e.g. `A_k` at another radius) changes `r²`, so a match is informative.
- **E-valid.** The rebuild with the two bounds met with equality (126°, 108°) and radial rim boundaries is ACCEPTed; if REJECTed, the rejected pair names
  which reading failed (three causes, told apart as the strip's were: a REJECT at a pair fixed only by the derived bounds points at the rebuild; one that
  survives a hand recomputation points at the print).
- **E-pairs.** Every close complementary pair of vertices contains a red three-colour vertex (`U_k` or `U′_k`): five non-red colours cannot make two
  disjoint non-red triples (a derivation from 3.3, not a hope). Registered: `(U′_0, B_0)` has common unit points `A_0` and the rim point `C_0`
  (mirror: `(U_0, B_4)` at `A_0` and `D_0`) — the strip's pattern (one common point a four-colour unit-arc centre, the other on the edge); and
  `(U′_0, X_4)` has `A_0` and a second common point **just outside** the rim near the radial line through `B_4` (hand floats: radius ≈ 2.16 > 2.124).
- **E-rim.** The rim points near which no colour is available include `C_k` and `D_k`; whether they are the only ones is not predicted.


## Stage 3 — SAVED
