# FS112-YB2 — round-2 blind verification of FS-112's construction side (the six-coloured disk and the strip's stopping points)

*Job FS112-YB2, de Bruijn on Opus 5.5, launched 2026-09-27 at HEAD `b5f5db3b`. Brief: `data/fs112/briefs/YB112-verify-construction.md`, overridden by
the instance file `data/fs112/briefs/YB2-112-instance.md`, with `data/fs112/briefs/STANDING-RULES.md`. My checker `tools/fs112_yb2_check.py` is
written without reading Y's, Y2's or YB's checker code; Fig. 10 is transcribed by eye and the transcription committed before any solve; my verdicts on
O1–O5 are committed (step 3) before I open Y2's section, tools or outputs. Every object below is a local positive, not a map of the plane.*

## Theorems this phase proved

The table is at the end of stage 5 (YB2-CHK, YB2-STRIP3, YB2-DISK, YB2-ARCS, YB2-PAIRS, YB2-RIM, YB2-EDGE, YB2-Q, YB2-SAME, YB2-MOVE, YB2-FORCE, YB2-DISC).

## Would have searched here (standing rule 3)

- Stage 2: none (a checker built from a derivation, calibrated on held objects).
- Stage 4, the strip's colours: I would have fitted `[AxenovichEtAl2014]` Fig. 4; instead I read its colour pattern only (arches purple, light green,
  blue; inverted arches marble, red, orange; top tiles orange, marble, red in the valleys; bottom tiles blue, purple, green), every length from the words.
- Stage 4, the disk: I would have fitted Fig. 10's pixels for `X_k`, `U_k`, `F_k`; instead two derived bounds at the four-colour vertex are met with
  equality and the rim boundary is radial by the mirror reading (stage 3 §3.5–3.6), and the checker judges that one member.
- Stage 5, O1's rim: I would have sampled rim points to map where no colour is available; instead a derivation (a rim tile's own colour stays
  available on its open rim arc, proved exactly by the critical points of the distance) left the 15 rim vertices, each classified exactly.
- Stage 5, O2's outside points: found by the exhaustive list of the object's own close complementary pairs (30 vertices, a finite feature list of a
  given object, not a search for an object).

## Fence log (standing rule 13; brief § Fences; instance)

- Start-up: `ls data/fs112/` listed directory **names**, among them the fenced `fs112-a2`, `fs112-a3`, `fs112-y` — names only, nothing in them listed,
  opened or grepped. `ls data/fs112/briefs/` listed the brief file names (other briefs fenced; none opened but mine, my instance file,
  `Y112-construction.md` not yet, and `STANDING-RULES.md`).
- `plans/FS112-Y-construction.md`: I read lines 1–266 only (round 1, open to me), having located the fenced heading "§ Continuation — FS112-Y2" at
  l. 267 by a `grep -n "Continuation"` that printed that one heading line and nothing of its section.
- Step 4 (stage 6), after `d231d771`: Y2's section (ll. 267–650), `tools/fs112_y2_disk.py` (builder and plants, imported), `y2_dial_pin.out`,
  `y2_disk_readoff.out` read; FS112-Y3's files not opened.
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

## Stage 4 — SAVED: my strip (brief step 2) and the disk (instance O1, first half), rebuilt by formula and checked exactly

### 4.1 The strip, my rebuild (`tools/fs112_yb2_objects.py strip`, output `data/fs112/fs112-yb2/strip-mine.out`) [tools, exact; one rebuild]

Geometry from the printed words (width 1/2; each rounded side an arc of radius 1 about the opposite corner, so the straight side stops at height `√3/2`
and the apex is `(j/2 + 1/4, √15/4)`; the top row fixed by "the distance 1 between the point of intersection of circular arcs and the opposite corner",
`Y = √15/4 + √3/2`); colours from `[AxenovichEtAl2014]` Fig. 4 viewed at 400 dpi, pattern only. **Height `2Y = √15/2 + √3` exactly. ACCEPT: 90 orbit
pairs (the 12 tiles of a period, each with itself and every same-colour tile of columns −9…11), every tile beyond dismissed by an exact `x`-gap of
19/4; 36 exact contacts at 1** — the same object and the same counts as YB's (checked pair by pair at stage 2) and as Y's round-1 report (60 ordered
pairs = 12 self + 2 × 24). Three independent rebuilds, two of them blind to the others, one object.

### 4.2 The disk (`tools/fs112_yb2_objects.py disk`, output `data/fs112/fs112-yb2/disk-check.out`, 4 min on one core under `scripts/slot.py`)

**The formula** (from the stage-3 transcription): `Z` the Reuleaux pentagon of width 1 on `A_k = a·e(90° + 72k)`, `a = R₅/φ = √((5 − √5)/10)`; the unit
regular pentagon `A_0 B_0 C_0 D_0 E` with `B_0 = A_0 + e(144°)`, `C_0 = B_0 + e(72°)`, `D_0 = C_0 + (1, 0)`, `E = B_4`; `X_0 = A_0 + s·e(126°)`,
`s = √(1/φ)` (the arch's straight side parallel to its axis, the bound 126° met with equality; then `|X_0 − A_1|² = s² + 1/φ² = 1`); `X′_0 = Y_4 =
A_0 + s·e(54°)`; `U_0 = A_0 + e(108°)`, `U′_0 = A_0 + e(72°)` (the bound 108° met with equality); `F_0 = r·e(126°)` (radial); everything turned by
`72k`. Tower `Q(√5)(√(10 + 2√5))(√(1/φ))(√r²)`: `r` generates degree 8 over `Q` (`r²` is not a square in `Q(√5)`, norm `11/5`, nor `r²(10 + 2√5) =
34 + 14√5`, norm 176), and `√(1/φ)` is new over `Q(√5, √(10 + 2√5))` (`1/φ` has norm −1; `(10 + 2√5)/φ = 4√5` has norm −80).

**Exact identities, 78 of 78** (`disk_identities`): **`r² = (25 + 9√5)/10` — the built-in control — equal exactly to the caption's `5/2 + 9/(2√5)` and to
`[11.34]`'s `φ²(15 + √5)/10`**; `|A_k A_{k+2}| = 1`; `|A_k B_k| = |A_{k+1} B_k| = 1`; the pentagon's edges `|B_k C_k| = |C_k D_k| = |D_k B_{k−1}| = 1`
and diagonal `|A_k C_k| = φ`; `|X_k A_{k+1}| = |Y_k A_k| = |U_k A_k| = |U′_k A_k| = 1`; `C_k, D_k, F_k` on the rim; each arch's straight side parallel to
its axis. **Map consistency (exact): 70 pieces, 55 shared by exactly two tiles and 15 rim arcs** (Euler: 45 − 70 + 27 = 2); float area guard: the 26
tile areas sum to 14.1763122 against `πr²` = 14.1763149 (the gap is the polyline's).

**The exact check: ACCEPT — 71 of 71 same-colour pairs examined (21 red among `Z, R_0…R_4`; 10 for each of the five other colours among `W_k,
P_{k+2}, S_{k+1}, T_{k−1}`), a tile with itself included; none has 1 interior to its range.** 46 pairs touch at exactly 1: **every tile has diameter
exactly 1** (26 self-pairs), and 20 cross pairs are at minimum distance exactly 1 — for each non-red colour the arch `P_{k+2}` against `W_k` (across
`Z`'s arc about `A_k`), against `S_{k+1}` and against `T_{k−1}` (across the arches' arcs), and red `Z` against each `R_k` (across the wedge's far arc).
**Those 20 contacts are the 20 unit arcs' out-contacts**; no other same-colour pair is closer than `√5 − 1 ≈ 1.236` (adjacent `R_k`) or 1.3657 (`W`
against the rim tiles of its colour).

**Scored (stage 3 §3.7):** **E-r met** (the radius reproduced exactly, three printed forms); **E-valid met** (the member with both bounds at equality and
radial rim boundaries is valid). What the ACCEPT covers: that one member of a family the print does not pin down (readings P, W, M); what it does not:
the figure's own coordinates, which I never read.

## Stage 4 — SAVED

## Stage 5 — SAVED: my verdicts on O1–O5 (the brief's step 3), committed before I open Y2's section, tools or outputs

*Tools: `tools/fs112_yb2_analysis.py` (exact, at named points; no scan). Outputs: `data/fs112/fs112-yb2/o1-o2.out`, `cone-disk.out`, `cone-strip.out`,
`strip-o2-o4.out`, `o3-o5.out`. **Method at a point `z`** (hand, one mind; each application exact): for every tile the exact minimum and maximum of
`|z − q|` against 1. A colour is **strictly blocked** at `z` if one of its tiles has `min < 1 < max` — then at every point near `z`. A tile with `max = 1`
(it lies in the closed unit disc about `z`) touching `ω(z)` at a contact `V` blocks `z + εd` for small `ε` iff `(V − z)·d < 0`; with `min = 1`, iff
`(V − z)·d > 0` (near `V`, `ω(z + εd)` is the tangent line at `V` shifted by `ε(V − z)·d`). The colourless directions are the open arcs where every colour
is blocked; boundary directions (a contact perpendicular to `d`) are second order and not decided. Test directions inside each arc are checked exactly.*

### O1 — the six-coloured disk [tools, exact; one rebuild, mine; readings P, W, M of stage 3]

- **Radius** `r = √((25 + 9√5)/10) ≈ 2.1242554`, reproduced exactly (the control; stage 4), `= √(5/2 + 9/(2√5))` (the caption) `= φ√((15 + √5)/10)` (`[11.34]`).
- **Valid** (stage 4): 71 of 71 same-colour pairs ACCEPT; every tile has diameter exactly 1; the 20 unit arcs' out-contacts are the only other
  distance-1 contacts.
- **Vertices (45)** — every colour set exact (`o1-o2.out`): the five `A_k` at radius `a = √((5 − √5)/10) ≈ 0.5257` carry **four colours** (`Z`, `P_{k−1}`,
  `W_k`, `P_k`; `A_0`: red, yellow, blue, orange — de Grey's `{1,3,5,6}` junction, `[16.106]`); 25 interior vertices carry three (`X_k`, `U_k`, `U′_k`,
  `Y_k = X′_{k+1}`, `B_k` as transcribed, at radii 1.2503, 1.5088, 1.5088, 1.2503, 1.3764); the 15 rim vertices `C_k`, `D_k`, `F_k` carry two.
- **Unit arcs (20), all kind `both`, self case, all arc-closed:** four centred at each `A_k` — `Z`'s far edge `A_{k+2}A_{k+3}` (inner `Z`, outer
  `P_{k+2}`), the wedge's far edge `U_kU′_k` (inner `W_k`, outer `R_k`), the arches' arcs `Y_kB_k` and `X_{k−1}B_{k−1}` (inner the arch, outer `T_{k+1}`,
  `S_{k−1}`). In each, the inner tile has the centre as a corner (self in-contact: the tile's diameter realised along the arc) and the outer colour is one of
  the centre's four (out-contact) — `[Polymath2021]` p. 194's tactic, at every arc. Spans: `Z`'s and the wedges' 36°, the arches' `arccos(…)` ≈ 20.17°.
  Every arc's two ends are interior vertices of the disk (`|end| < r`, exact): **C-ARC-END realised arc-closed at every unit arc.**
- **Close complementary pairs (20)** — exhaustive over the 30 interior vertices (types disjoint, union all six, distance < 2). **Every one contains a red
  three-colour vertex** (`U_k` or `U′_k`; five non-red colours make no two disjoint non-red triples — E-pairs met) **and every one has a four-colour
  vertex `A_j` as a common unit point** (T2's half: both members emit unit arcs of `ω(A_j)`). Their other common points:
  - `(U′_k, B_k)` at distance `2 sin 36° ≈ 1.1756` → **`C_k`, on the rim**; `(U_k, B_{k−1})` → **`D_k`, on the rim** (10 pairs);
  - `(X_k, U′_{k+1})` (common point `A_{k+1}`) and `(U_k, Y_k)` (common point `A_k`), each at distance ≈ 0.9416 → **one point `Q_k` outside the disk**, on the
    ray of `B_k` and `F_k`, at `|Q_k|² ≈ 4.6765503` (the root of `25x⁴ − 50x³ − 265x² − 250x + 121`), 0.0383 beyond the rim; `Q_k` is at distance
    exactly 1 from the four vertices `X_k, U_k, Y_k, U′_{k+1}` (10 pairs, two per `Q_k`).
- **The rim: the points near which no colour can be given just outside are exactly the ten vertices `C_k`, `D_k`.**
  - *Open rim arcs* (exact, `rim_open_arcs`): for each of the 15 rim tiles, every interior point of its rim arc is at distance < 1 from all of the tile
    (every critical candidate with an interior rim point is < 1, and the tile's diameter is 1), and every other tile of its colour is at distance > 1 from
    the closed rim arc; so **the rim tile's own colour is available just outside every interior point of its rim arc.**
  - `F_k`: violet and yellow (at `F_0`) are never blocked — **available** in every outward direction.
  - **`C_0`** (exact contacts, `cone-disk.out`): blue (`W_0`), green (`T_0`), orange (`P_0`), yellow (`T_1`) strictly blocked — `ω(C_0)` crosses those
    tiles; red has `max = 1` at `R_0`, touching at `D_0` and `U′_0`; violet has `max = 1` at `S_0`, touching at `B_0`. With `U′_0 − C_0 = e(−36°)`,
    `B_0 − C_0 = e(252°)`, `D_0 − C_0 = e(0°)` (exact): **the colourless outward directions are the open cone (54°, 162°), of width exactly 108° = 3π/5**
    (`= 180° − ∠U′_0 C_0 B_0`, the angle being 72°, `(U′_0 − C_0)·(B_0 − C_0) = cos 72°` exactly); red is available in (13.61°, 54°) (toward the top of
    `R_0`), violet in (162°, 193.61°). **`D_0`**: the mirror, colourless (18°, 126°), 108°; red available in (126°, 166.39°), green in (346.39°, 18°).
  - E-rim met; the "only them" part, not predicted, is a result.

### O2 — the stopping points of both positives [tools, exact; the comparison hand, one mind]

- **The strip** (my rebuild; `strip-o2-o4.out`, `cone-strip.out`): its close complementary pairs with a four-colour common point are the `(V, A)` pairs
  (other point: **an edge vertex**, e.g. `X_1 = (1/4, Y)` for `(V_0, A_1)`), `(W, W′)` at `√3` and `(A_j, A′_j)` at `√15/2` (both common points
  four-colour midline vertices, inside; no other point) — as YB found. **At `X_1` (exact):** `X_1` is at distance exactly 1 from four vertices, `V_0`, `A_1`,
  `V_1`, `A_{−1}`; purple, green, blue and marble are **strictly** blocked (arches 0, 1, −1 and the top tiles `T_{−1}`, `T_2` cross `ω(X_1)`); red has
  `max = 1` at `T_0` (touching at `V_0`, `A_{−1}`) and `min = 1` at `T_3` (its corner `(5/4, Y)`); orange `max = 1` at `T_1` (at `V_1`, `A_1`) and
  `min = 1` at `T_{−2}` (its corner `(−3/4, Y)`). **Colourless: the open cone (arcsin(1/4), 180° − arcsin(1/4)) = (14.48°, 165.52°), width
  180° − 2·arcsin(1/4) ≈ 151.045°**, symmetric about the vertical; orange available in (0°, 14.48°), red in (165.52°, 180°).
- **The disk**: the other points are `C_k`, `D_k` on the rim (colourless cones of 108°, O1) and `Q_k` outside. **At `Q_0`** (exact): blue, green, orange,
  red strictly blocked; violet `max = 1` at `S_0` (touching at `X_0`, `U_0`), yellow `max = 1` at `T_1` (at `Y_0`, `U′_1`). **`Q_0` itself can take violet or
  yellow** (neither is blocked at the point), but **every point `Q_0 + εd` with `d` in (54°, 198°) — width 144°, containing the outward radial 126° — is
  colourless**; violet is available in (254.17°, 54°) and yellow in (198°, 357.83°). So an extension of the disk beyond `F_k` is stopped at `Q_k`, 0.0383
  beyond the rim, in the outward cone.
- **Do the two positives stop for the same reason? Yes** [hand, one mind; the ingredients exact]: each stops at the **second common unit point of a close
  complementary pair saved at a four-colour unit-arc centre**, lying on the object's boundary (strip: `X`; disk: `C_k`, `D_k`), and the mechanism is
  identical — **four colours are strictly blocked** there (their tiles are crossed by the unit circle about the point) and **the two tiles meeting at the
  point each realise their diameter from it** (`max = 1`: strip `T_0`, `T_1`; disk `R_0`, `S_0`), so their colours continue only in the half-planes
  pointing away from their far contacts, and the outward cone between the two perpendiculars is colourless. The differences: the strip's boundary tiles
  are also blocked sideways (`min = 1` at the next same-colour top tiles, exactly 1 along the edge) and its cone is wider (151.045° against 108°); the
  disk has a second kind of stopping point off its boundary (`Q_k`, radius ≈ 2.16253), the strip none.

### O3 — the move at `C_k` and `D_k` [tools, exact; hand for the first-order reading]

At `C_0` the only straight side of an adjacent tile (`R_0`, `S_0`) that is a chord of `ω(C_0)` is **`D_0U′_0`** (the side between red `R_0` and green `T_0`;
`|C_0D_0| = |C_0U′_0| = 1`); the mirror at `D_0` is **`C_0U_0`** (between `R_0` and violet `S_0`). The move bends `D_kU′_k` into the arc of `ω(C_k)` through
its ends (bulging away from `C_k`, into `T_k`) and `C_kU_k` into the arc of `ω(D_k)` (into `S_k`), in all five sectors: red gains two lenses per sector.

**Valid: yes** (`o3-o5.out`, exact): the ten new arcs meet every other piece only at their shared ends (circle–circle and circle–line second
intersections tested exactly); the map stays consistent (70 pieces); **71 of 71 same-colour pairs ACCEPT**, 46 exact contacts at 1 — the same count: the
new arcs add no out-contact. `R_k` keeps diameter exactly 1 (two points of the two lenses, at angles `α`, `β` along them, are at distance² `3 + 2cos(α + β)
− 2cos α − 2cos β ≤ 1`, with equality only at an end — hand, and the checker agrees).

**Kinds of the new unit arcs** (exact): the arc of `ω(C_k)` (inner `R_k`, red; outer `T_k`) and the arc of `ω(D_k)` (inner `R_k`; outer `S_k`) are of kind
**in, self case — not out**: the centre is a rim vertex carrying only red and the colour of `S_k` (resp. `T_k`), and the outer colour is the third one.
Each new arc has one end on the rim (`D_k`, resp. `C_k`), so these ten are **not arc-closed**.

**Colours at the rim point, and the colourless set, before and after** (`cone-disk.out`, exact contacts; first order):

| point | before the move | after the move |
|---|---|---|
| `C_0` | red available on (13.61°, 54°); **colourless (54°, 162°), 108° = 3π/5**; violet available on (162°, 193.61°) | red on (13.61°, 54°); **colourless (54°, 90°), 36° = π/5**; **green now available on (90°, 193.61°)** (with violet on (162°, 193.61°)) |
| `D_0` | green on (346.39°, 18°); **colourless (18°, 126°), 108°**; red on (126°, 166.39°) | **violet now available on (346.39°, 90°)** (with green on (346.39°, 18°)); **colourless (90°, 126°), 36°**; red on (126°, 166.39°) |

Why green appears at `C_0`: before the move `ω(C_0)` crossed `T_0` along the chord's bulge (strict block); after it, `T_0`'s boundary **is** that arc of
`ω(C_0)`, so `T_0` lies outside the open unit disc about `C_0` and blocks only the directions with `d·(D_0 − C_0) > 0` or `d·(U′_0 − C_0) > 0`, i.e.
(234°, 90°). What remains at `C_0` is bounded by red's contact at `U′_0` (54° = 324° + 90°) and green's new contact at `D_0` (90°). **A colourless
set remains, of width exactly 36°, at each of the ten rim vertices.**

### O4 — the strip's forced sectors at `V_0` and `A_1` [hand, one mind; the directions exact]

Near `V_0 = (0, √3/2)` the unit circle of a point `V_0 + tw` passes near the four-colour midline vertices `P_{±1}` (both at distance exactly 1) along the
tangent line of `ω(V_0)` shifted by `t(P − V_0)·w`; it therefore crosses the sectors of `P` on the side of that line, and a colour met there is forbidden at
`V_0 + tw`. `P_1 − V_0` points at 300°, `P_{−1} − V_0` at 240° (exact); the four lines cut the directions at `V_0` at 30°, 150°, 210°, 330°:

| directions at `V_0` | `P_1` allows | `P_{−1}` allows | forced |
|---|---|---|---|
| (330°, 30°) | purple, blue, orange | purple, red, marble | **purple** (arch 0) |
| (30°, 150°) | red, blue, orange | purple, red, marble | **red** (the top tile `T_0`) |
| (150°, 210°) | red, blue, orange | purple, blue, marble | **blue** (arch −1) |
| (210°, 330°) | purple, blue, orange | purple, blue, marble | **free: purple or blue** (120° of directions, below `V_0`, where the two arches meet along `x = 0`) |

At `A_1 = (3/4, √15/4)` with `P_1 − A_1` at 255.52° and `P_2 − A_1` at 284.48° (lines at 14.48°, 165.52°, 194.48°, 345.52°): **(345.52°, 14.48°) forced
marble**; **(165.52°, 194.48°) forced orange**; **(194.48°, 345.52°) forced green** (arch 1); **(14.48°, 165.52°) free: marble or orange** (151.04°, the top
tiles `T_2`, `T_1` meeting along `x = 3/4`). The strip's own colouring meets every forced region and splits each free region at 270° and 90°.

**Can a change confined to those free directions, or to the neighbourhoods of `V_0` and `A_1`, make a colour available at `X_1`? No.** At `X_1` the
colourless cone is (14.48°, 165.52°) (O2). In it: purple, green, blue and marble are strictly blocked **by tiles crossing `ω(X_1)` far from `V_0` and `A_1`**
(arch 0 near its apex, arch 1 near the middle of its arc — nearest point 0.982 from `X_1` —, arch −1, and the top tile `T_2`, which has a point at distance
1/2 (`(3/4, Y)`) and one at `√7/2` (`A_2`), exact) — no change near `V_0`, `A_1` can touch them; red is blocked through `V_0` in directions `d` with
`(V_0 − X_1)·d < 0`, i.e. (−14.48°, 165.52°) ⊇ the cone — and red at `V_0` in (30°, 150°) is **forced**, so it stays; orange likewise through `A_1`
(`(A_1 − X_1)·d < 0` on (30°, 210°), orange **forced** at `A_1` on (165.52°, 194.48°) ⊂ that half-plane) and through `V_1` on (14.48°, 30°], where the
change is not confined. The free arc at `V_0` (210°–330°) lies wholly outside the half-plane that `X_1`'s cone reads at `V_0`; the free arc at `A_1`
meets it but only marble and orange live there, and both are blocked by other means. (The lens of arch 1 inside `ω(X_1)` runs from `V_1` to `A_1`; its middle is ≈ 0.135 from `A_1`, so the claim holds for neighbourhoods of radius below that; larger regions are outside O4's question.) **So the strip's stop at `X_1` is not an artefact of the sectors
at `V_0`, `A_1`: four of the six colours are lost to tiles no local change at `V_0` or `A_1` reaches.**

### O5 — the largest vertex-centred disc [tools, exact; the bound hand, one mind]

- **Inside O1:** the largest closed disc centred at a vertex has radius **`r − a = √((25 + 9√5)/10) − √((5 − √5)/10) ≈ 1.5985243`**, centred at any
  `A_k` (the `A_k` are the vertices nearest the centre: `|A_k|² = a² = (5 − √5)/10` is the least `|vertex|²`, exact).
- **A valid extension holds a larger one** (exact): grow `R_0` over its rim arc to the arc of the circle `(A_0, φ)` from `D_0` to `C_0` (`|A_0C_0| =
  |A_0D_0| = φ`, exact); the circles `(A_0, φ)` and `(O, r)` meet exactly at `C_0`, `D_0`, so the new object contains the closed disc `B(A_0, φ)`; **71 of 71
  pairs ACCEPT**, `R_0` keeping diameter exactly 1 (its new arc is a 36° arc of radius φ with chord `2φ sin 18° = 1`). **`φ ≈ 1.6180340 > r − a`.**
- **No valid extension of O1 holds a larger closed disc centred at a vertex of O1** [hand, one mind; the cones exact]: a closed disc about `A_k` of radius
  `> φ` contains a neighbourhood of `C_k`, hence an open set of the colourless cone (54°, 162°) at `C_k`; almost every point of it would be an interior
  point of a tile, and each is at distance exactly 1 from interior points of all six colours of O1 — a monochromatic unit pair. About any other vertex of
  O1 the bound is its distance to the nearest `C_j`/`D_j`, **at most 1** (the list in `o3-o5.out`: after the five `A_k` at φ, the apexes `B_k` at exactly
  1, all others less). So **the answer is φ, attained, at the `A_k`**; the O3 move leaves a 36° colourless cone at `C_k`, so the same bound holds for the
  moved disk. (The outside stopping points `Q_k` are farther: `|A_0 − Q_0| ≈ 1.7645`.)

### Theorems this phase proved (stages 2–5)

| id | statement (one line) | grade | address |
|---|---|---|---|
| YB2-CHK | an exact curved-tile checker over towers of square roots (signs by recursion; exact meeting, no map hypothesis) agrees pair by pair with the frozen FS-110 checker on 1,663 pairs and with YB's checker on YB's strip and its plants; seven checker plants each flip exactly their predicted controls | tools, exact | stage 2; `tools/fs112_yb2_check.py`, `tools/fs112_yb2_calib.py` |
| YB2-STRIP3 | a third rebuild of `[AxenovichEtAl2014]`'s strip (words + Fig. 4's colour pattern) is valid; height `√15/2 + √3` exact; 90 orbit pairs, 36 exact contacts | tools, exact; one rebuild | 4.1 |
| YB2-DISK | the disk rebuilt from its by-eye transcription (bounds 126°, 108° met with equality; rim sides radial) is a valid six-colouring of the closed disc of radius `√((25 + 9√5)/10)`, the printed radius reproduced exactly; every tile has diameter exactly 1 | tools, exact; one rebuild; readings P, W, M | 4.2 |
| YB2-ARCS | its 20 unit arcs, four at each four-colour vertex `A_k`, are all of kind both (self case) and arc-closed | tools, exact | O1 |
| YB2-PAIRS | its 20 close complementary pairs each contain `U_k` or `U′_k` and have an `A_j` as a common unit point; the other point is `C_k`/`D_k` on the rim (10) or `Q_k` outside, `|Q_k|²` the root ≈ 4.6766 of `25x⁴ − 50x³ − 265x² − 250x + 121` (10, two per point) | tools, exact | O1 |
| YB2-RIM | the rim points of the disk near which no colour can be given just outside are exactly the ten `C_k`, `D_k`, each with an open colourless cone of width exactly 108° | hand (first-order rule, one mind) + tools, exact | O1 |
| YB2-EDGE | the strip's edge vertex `X_1` has the colourless cone (arcsin 1/4, 180° − arcsin 1/4), width ≈ 151.045°; four colours strictly blocked; YB's (30°, 165.52°) is a proper sub-cone | hand + tools, exact | O2 |
| YB2-Q | at `Q_k` violet and yellow (at `Q_0`) remain available at the point itself, and the cone (54°, 198°), 144°, is colourless | hand + tools, exact | O2 |
| YB2-SAME | the strip and the disk stop for the same reason: the second common unit point of a close complementary pair saved at a four-colour unit-arc centre lies on the boundary, four colours are crossed there and the two boundary tiles realise their diameters from it | hand, one mind | O2 |
| YB2-MOVE | O3's move (ten chords bent to unit arcs about `C_k`, `D_k`) keeps the disk valid; the new arcs are of kind in (self), not arc-closed; the colourless cone at each `C_k`, `D_k` shrinks from 108° to 36° | tools, exact + hand | O3 |
| YB2-FORCE | at the strip's `V_0` and `A_1` the neighbouring four-colour midline vertices force one colour on three arcs of directions and leave two colours free on one (120° at `V_0`, 151.04° at `A_1`); no change confined to those free arcs, or to neighbourhoods of `V_0`, `A_1` of radius below ≈ 0.13, makes a colour available at `X_1` | hand, one mind; the directions exact | O4 |
| YB2-DISC | the largest closed vertex-centred disc inside O1 has radius `r − a`; a valid extension holds one of radius φ about `A_0` (exact), and none larger about a vertex of O1 | tools, exact + hand, one mind | O5 |

## Stage 5 — SAVED (step 3 complete: every O1–O5 verdict above is committed before Y2's section, tools or outputs are opened)

## Stage 6 — SAVED: Y2's section, tools and outputs read (the brief's step 4); every divergence, with both addresses

*Read after stage 5 was committed (`d231d771`): `plans/FS112-Y-construction.md` § Continuation — FS112-Y2 (ll. 267–650) in full; `tools/fs112_y2_disk.py`
(the `field`, `Disk` builder and plant switches; run and imported, never edited); `data/fs112/fs112-y/y2_dial_pin.out`, `y2_disk_readoff.out`. Not
read: Y2's other tools' logic, `y2_house*`, `y2_dial_move*` beyond the record's quotation of them; FS112-Y3's files (fenced; step 4 did not need them).
New tools of this stage: `tools/fs112_yb2_compare.py` (Y2's object against mine; Y2's plants through my checker), `tools/fs112_yb2_edgecheck.py` (the
strip's stop point at finite offsets, in Y2's terms). Outputs: `compare-objects.out`, `compare-plants.out`, `edgecheck.out`.*

**The headline: the disk — two blind rebuilds, one object, two checkers, one verdict.** Y2's disk and mine are **identical**: the four radicands
equal, and **26 of 26 tiles have the same colour and every piece the same as a point set** (`compare-objects.out`), reached by different readings
(Y2 put `Z^L_k` on the pentagon's diagonal `A_kC_k` and made the legs parallel by reading the figure; I derived the bounds 108° and 126° at the
four-colour vertex and met them with equality — the same points). Both ACCEPT 71 of 71 pairs with 26 self contacts and 20 out-contacts, 25 slack pairs.
**CAL-DISK now stands in the robust form claim list §7 asks for** — two independent rebuilds, two exact checkers — at the grade [tools, exact; two
rebuilds, one blind], with readings P, W, M (mine) and Y2's 4.5 items 1–6 (theirs) as the shared reading assumptions: the print pins none of them.

| # | divergence | Y2's address | mine | kind |
|---|---|---|---|---|
| D1 | **The strip's colourless wedge at its stop point is wider than Y2 (and YB) state.** Y2-PIN: "an outward wedge carries no colour (strip `(30°, 165.52°)`" — YB's cone — "each of `Q`'s two tiles contains a point at distance exactly 1 from `Q` (strip: `V_0`, `A_1`)". **Each has two**: the top tile `C_0` (red) touches `ω(Q)` at `V_0` **and `A_{−1}`**, the top tile `C_1` (orange) at `A_1` **and `V_1`**; and the next same-colour top tiles `C_3`, `C_{−2}` touch it at their corners `(1/4 ± 1, Y)` from outside. With all contacts the colourless set is **the symmetric cone (arcsin(1/4), 180° − arcsin(1/4)) = (14.48°, 165.52°), width ≈ 151.045°** (the strip's mirror `x ↦ 1/2 − x` fixes `Q` and swaps red and orange, so the true cone must be symmetric; (30°, 165.52°) is not). **Confirmed in Y2's own terms, exactly** (`edgecheck.out`): at `Q + e(20.0°)/100` no colour is free; at `Q + e(10.0°)/100` orange is free, at `170.0°` red — Y2 and YB tested only 30°–150°. Every tested direction agrees; the stated wedge is a proper sub-cone. **Correction owed** to Y2-PIN's wedge and to YB-EDGE's cone (both true as sufficient statements, neither the colourless set), and to the widths compared: **151.045° against the disk's 108°**, not 135.52°. | §6.1, Y2-PIN; YB's record O3 | O2 (YB2-EDGE); `cone-strip.out`, `edgecheck.out` | a verdict differs (the set); a correction owed |
| D2 | **Where the rim stops, completeness.** Y2 tests `C_0 + e(θ)/100` at θ = 36°, 54°, …, 162° and one control beyond `u_0`, and concludes "the rim cannot be passed at `C_k` (nor … `D_k`)". I prove the complete list: **the colourless rim points are exactly the ten `C_k`, `D_k`** — every open rim arc keeps its tile's colour available (exact, all 15 arcs) and the five `F_k` (Y2's `u_k`) keep violet and yellow (Y2's `P`, `Yw`, matching its control); at `C_0` the exact first-order cone (54°, 162°), 108° = 3π/5, equals Y2's tested directions' pattern (`R` free at 36°, none 54°–162°, `P` at 180°). | §5.3 (f) | O1 (YB2-RIM); `o1-o2.out`, `cone-disk.out` | coverage: the "only them" is mine |
| D3 | **O5's attainment.** Y2-DISK-R bounds the vertex-centred discs of any extension by φ ("the point `C_0 + e(108°)/100` … has no colour") and the inside value `r − |OA|` ≈ 1.5985 — the same numbers as mine. **Mine adds that φ is attained**: `R_0` grown to the arc of the circle `(A_0, φ)` over its rim arc is valid (71/71 ACCEPT) and holds the closed disc `B(A_0, φ)`; and for the upper bound I use the open colourless cone (a positive-measure set of points each at distance exactly 1 from interior points of all six colours), which is what an almost-everywhere-valid extension forbids — Y2's single point is the cone's sample (its straddles are open, so the two readings agree). | §5.3 (g), Y2-DISK-R | O5 (YB2-DISC) | coverage: attainment mine |
| D4 | **The strip's stop point is the second common point of two complementary pairs, the disk's rim stop of one.** `Q = X_1` is at distance exactly 1 from four vertices: `(V_0, A_1)` **and `(V_1, A_{−1})`** (both complementary, both at ≈ 0.757, both with a four-colour first common point); `C_k` is on the circles of `(U′_k, B_k)` only (Y2's `(B_0, Z^R_0)`), which is why the strip's cone has four boundary contacts and the disk's two. The disk's outside points `Q_k` (Y2's `w*`) are, like the strip's `X`, shared by two pairs — Y2 and I both find `w*` at distance 1 from four vertices. | §6.1, §5.3 (d) | O2 | a finding one side has (the strip half) |
| D5 | **Close pairs listed.** Y2 lists close **covering** pairs of every overlap (`(A_0, A_1)`, `(A_0, X_3)`, `(A_0, B_2)`, `(A_0, y)`) and finds (S1) on the disk and C-UA-BUDGET's second branch false in the disjoint sense; I list the **complementary** pairs only (the instance's O1), all 20, with the same two second points (`C_k`/`D_k`, `w*` = my `Q_k`, `|w*|² = 4.676550266` both; I add its minimal polynomial `25x⁴ − 50x³ − 265x² − 250x + 121`). | §5.3 (d), (e) | O1 (YB2-PAIRS) | coverage; agreement where both look |
| D6 | **The outside point `Q_k`'s colours.** Y2: "along the mirror lines the colouring may pass the rim (at `u_0`, `P`, `Yw` are free) but not past `w*`". Mine, exact: at `Q_0` itself violet and yellow are **not** blocked (each only touches `ω(Q_0)` from inside at two vertices); the colourless set near `Q_0` is the cone (54°, 198°), 144°, containing the outward radial 126° — so Y2's "not past `w*`" holds in the outward cone, while `Q_0` as a single point can still be coloured. | §5.3 (f) | O2 (YB2-Q) | agreement, sharpened |
| D7 | **The move (O3).** Same move (the chords `D_kZ^R_k`, `C_kZ^L_k` of `ω(C_k)`, `ω(D_k)` bent to their unit arcs, lenses to `R_k`), same verdicts: valid (71/71), ten new arcs of kind **in** (self), colourless wedge 108° → 36° = (54°, 90°) at `C_0`, (90°, 126°) at `D_0`, green free at `C_0` from 90°, violet at `D_0` up to 90°. Mine adds: the ten new arcs are **not arc-closed** (one end on the rim each). Y2 adds: the second move's GAP (6.4) and Y2-SLACK (the `R_k | U_k` boundary not locked). | §6.2–6.4, 6.6 | O3 (YB2-MOVE) | agreement; coverage both ways |
| D8 | **The forced sectors (O4).** The same four arcs at `V_0` and at `A_1`, the same forced colours and free pairs (Y's colours 1, 3, 5 and 2, 4, 6 = my purple, blue, red and green, marble, orange). Y2 concludes the same **No**. Mine adds the radius to which "confined to the neighbourhoods" is meant (below ≈ 0.135: the lens of arch 1 inside `ω(Q)` runs from `V_1` to `A_1`) and that the free arc at `V_0` lies wholly outside the half-plane `Q`'s cone reads there. | §6.5, Y2-FORCE | O4 (YB2-FORCE) | agreement |
| D9 | **Unit arcs, kinds, arc-closedness, vertices, `[16.106]`.** Identical: 20 arcs, all both, four per `A_k`, total 112.35° on `ω(A_0)`; every end interior; the five `A_k` four-colour, `A_4` carrying `{R, G, Yw, P}`. | §5.3 (a)–(c), (h) | O1 | agreement |
| D10 | **Plants on the disk.** Y2's three disk plants (`ring2_short`, `swap`, `chords`), rebuilt by Y2's builder and run through **my** checker: **every plant rejects exactly the pairs Y2 registered in §5.0 and its own checker found** — `chords`: the five `(T1_k, T2_{k+3})` (my `(P_k, W_{k+3})`); `swap`: `(T1_4, U_0)`, `(T1_1, U′_0)` (my `(P_4, S_0)`, `(P_1, T_1)`); `ring2_short`: the five `(C0, R_k)` and the five `(R_k, R_k)`; the faithful twin ACCEPTs (71/71 each). | §5.0, §5.2 | `compare-plants.out` | cross-check |
| D11 | **Examined by one side only.** Y2 only: Y2-NB4 (the corrected NB-4), Y2-X4 ((S2)-with-arcs on the strip), Y2-D3/D4S/D6 (house-keeping on the strip and brick), Y2-DISK-S1, Y2-BUDGET2, Y2-SLACK, the second move's GAP, Y2-X2. Mine only: the complete rim classification (D2), the strip's exact cone (D1), the O5 attainment (D3), the checker's calibration on FS-110's fragments pair by pair (1,663 pairs) and on YB's strip and plants pair by pair. | Y2's table | stages 2, 5 | coverage |

**Pairs one checker examined and the other did not:** none on the disk — both examine the 71 pairs the colour map generates (six red tiles, four
of each other colour, each tile with itself). On the strip, Y2's round-1 population (60 ordered pairs, horizontal gap ≤ 1) and mine (90 orbit pairs,
36 within reach) are the same pairs within reach (as YB found for Y's).

**Grades after the comparison.** YB2-DISK becomes **[tools, exact; two rebuilds, one blind (mine), two checkers]** (the readings shared, stated);
YB2-ARCS, YB2-PAIRS (the second points), YB2-MOVE and YB2-FORCE **two minds, one blind**; YB2-RIM's completeness, YB2-EDGE and YB2-DISC's
attainment **one mind** (mine).

## Stage 6 — SAVED

## Stage 7 — SAVED: hand-back notes

**Erratum to my stage 5** (O1, unit arcs): "the arches' `arccos(…)` ≈ 20.17°" should read **`72° − arctan(√φ)` ≈ 20.17°** (the direction of `X_0 − A_1`
is `36° + arctan(√φ)`, exact from `|A_0A_1| = 1/φ` and the perpendicular leg `1/√φ`). No verdict rests on it.

**Proposed `BIBLIOGRAPHY.md` reading-status edits (the close writes them):** `[Polymath2021]`: pp. 194, 197–200 read (text); Fig. 10 viewed at 300 and 600
dpi for its combinatorics and its caption's radical read on the page image (FS112-YB2, 2026-09-27); the disk rebuilt exactly from it, independently of
FS112-Y2, and the two rebuilds found identical. `[AxenovichEtAl2014]`: p. 8 read (text), Fig. 4 viewed at 400 dpi for its colour pattern (FS112-YB2).

**Proposed corrections (the close decides):** Y2-PIN's strip wedge and YB-EDGE's cone, as the colourless set, → `(arcsin(1/4), 180° − arcsin(1/4))`,
width ≈ 151.045° (D1); the comparison "strip 135.52° against disk 108°" → "151.045° against 108°".

**Left open (not this job's):** the second move at `C_k` (Y2's 6.4 GAP) — after the move the 36° cone at `C_0` is bounded by red's contact at `U′_0`
(54°) and green's new contact at `D_0` (90°), both exact; whether the triangle Y2 names can be blue is untouched by me. Whether the disk's colourless
cones at `C_k`, `D_k` can be closed at all by changes confined near the rim is O3's question one step further and is not decided here.

## Stage 7 — SAVED
