# FS112-YB — blind verification of FS-112's construction side (the strip, its unit arcs, the objects Y's report names)

*Job FS112-YB, Opus 5.5, launched 2026-09-27 at HEAD `131a0a54`. Brief: `data/fs112/briefs/YB112-verify-construction.md`, instance file
`data/fs112/briefs/YB112-instance.md`, with `data/fs112/briefs/STANDING-RULES.md`. My own checker `tools/fs112_yb_check.py` is written without reading
Y's; every object is rebuilt from its defining words; my verdicts are committed (step 3) before I open `plans/FS112-Y-construction.md`.*

## Theorems this phase proved

The table is in stage 4 (YB-STRIP, YB-CONTACT, YB-T2, YB-SEAMS, YB-EDGE, YB-WEDGE, YB-LOCK, YB-CHAIN, YB-NB4); stage 5 adds none (a comparison).

## Would have searched here (standing rule 3)

The log is in stage 4 (five lines). Stages 1, 2 and 5: none (reading, a checker built from a derivation, a comparison).

## Fence log

- No fenced path opened, listed or grepped so far. `ls data/fs112/` (at start-up, to see whether my record existed) listed the directory names
  `fs112-a`, `fs112-a2`, `fs112-n`, `fs112-y`, `reports` — names only, no contents; `fs112-a2` and `fs112-y` are fenced for me, so this listing is logged
  as a touch of their **names** only.

## Stage 1 — SAVED: reading, the quotation check (standing rule 5)

### 1.1 Read from disk, in this order

`STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim and § Counter-priors (read from disk: my context's snapshot was not relied on), G20, G21, G22,
G60; `LEDGER.md` rows 133–134; `data/fs112/claims.md` in full; `data/fs110/claims.md` §0, §1, §1b, §9 (the definitions the list defers to);
`plans/FS112-unit-arc-half.md` stage 5 §§5.1, 5.2, 5.4–5.7 and the addendum (**not §5.3**); `plans/FS112-PA-reading.md` in full;
`data/fs112/briefs/Y112-construction.md` (allowed by my brief); `[AxenovichEtAl2014]` p. 8 (text layer, and Figure 4 viewed — see 1.3);
`[Polymath2021]` pp. 194–195 (PDF pages 30–31 of `geombinatorics-v30-n4-2021-04.pdf`); the frozen FS-110 tools, read and run, never edited:
`tools/fs110_y_check.py` (in full), `tools/fs110_y_fragments.py` (in full), `tools/fs110_y_cone.py` (in full), `data/fs110/fs110-a6/a6_c2_single_horn.py`
(in full), `tools/fs110_yb_check.py` and `tools/fs110_yb4_check.py` (headers and drivers); `Proofs/HadwigerNelson/Instances/Seven.lean` (CAL-7's object,
row 33's brick colouring). pp. 197–200 of `[Polymath2021]` are read at stage 2 with the disk (not needed before).

### 1.2 Quotation check

| quotation | where quoted | source | verdict |
|---|---|---|---|
| "The symmetric tiles have width 1/2, with the rounded boundary being a circular arc of radius 1 centered at the opposite corner of the tile. The tiles used in the top and bottom rows are determined by the distance 1 between the point of intersection of circular arcs and the opposite corner of a tile." | brief step 2; claim list §7 CAL-STRIP | `[AxenovichEtAl2014]` p. 8, text layer | **exact** (whitespace-normalised) |
| Kooshi: "From here on out, you may doubt your ability …" | standing rule 0 | `CLAUDE.md` § Counter-priors | exact |
| Kooshi: "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time" | standing rule 3 | `CLAUDE.md` § Toolchain | exact |
| Kooshi: "search for a finite graph is out. It would be huge, not feasible." | standing rule 3 | `CLAUDE.md` § Publication | exact |
| Kooshi: "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | standing rule 4 | `CLAUDE.md` item 23 | exact |
| Kooshi: "It's ok if jobs overrun a bit. …" | standing rule 10 | `plans/CONSOLIDATION-2026-09-27.md` | exact |
| "arc-closed" | instance O2 | claim list §6 C-ARC-END | exact |
| C-CHAIN-1 … C-CHAIN-18, the eighteen statements | claim list §3; instance O5 | `plans/FS110-derivation.md` | **all eighteen found verbatim** (whitespace-normalised) |
| ARC-INERT's quotation of FS112-A | claim list §6; instance O4 | the advisor's record | **not checked: the source is fenced for me** (brief) |

### 1.3 A disclosure about the rebuild's inputs

The brief asks for the strip "from its printed words alone". The words fix the **geometry** (tile width 1/2, arcs of radius 1 centred at the opposite
corner, the top row fixed by one unit distance) but not the **tile layout** (how many rows, their offsets) or the **colouring**, which the print gives
only as "a coloring, similar to one used by Pritikin, see Figure 4". I read Figure 4 **for its combinatorics only** (four rows: pointed arches over
the midline, inverted arches under it aligned with them, and a top and a bottom row of tiles sitting in the valleys, offset by half a tile; the colour
of each tile), rendered at 300 dpi; **no coordinate was taken from the figure** — every coordinate below is derived from the printed rules, and the
colouring is then checked exactly. The same reading of a figure's combinatorics is what the claim list prescribes for the disk (§7 CAL-DISK).

### 1.4 The frozen checkers' verdicts (the calibration targets; run, not edited)

`tools/fs110_y_fragments.py`: S1 11 tiles 18 pairs ACCEPT; T2 14/24 ACCEPT; BB 16/30 ACCEPT; MX 15/27 ACCEPT. `tools/fs110_y_cone.py --tips`: WC 15/30,
WC1 14/26, WCEQ 15/30, WCH 19/40, WC1H 16/30 ACCEPT; tip tests as predicted (WC tip→2, →3 ACCEPT; WC tip→4, WCH tip→2, →3, WC1H tip→2, →3, →4 REJECT,
with their pairs). `a6_c2_single_horn.py`: A6-C2 16/30 ACCEPT and its ten runs as predicted. `tools/fs110_y_check.py`: its seven controls as expected.
Outputs kept in `data/fs112/fs112-yb/frozen-verdicts.txt`.

## Stage 2 — SAVED: my exact checker, its plants, and its calibration (claim list §7, in its order)

**The checker** `tools/fs112_yb_check.py` (written without reading Y's; the frozen FS-110 checkers read, as the brief requires). For each same-colour
pair of tiles, a tile with itself included, it decides exactly whether 1 lies in the open range `(m, M)` of cross-distances — REJECT iff `m < 1 < M`
(the interior cross-distances fill exactly `(m, M)`, the tiles being open, connected and dense in their closures). `m` and `M` are the extremes over a
complete list of critical pairs of the boundary pieces (endpoint–endpoint; endpoint–foot or radial point; segment–arc along the perpendicular through
the arc's centre; arc–arc on the line of centres, concentric arcs radially; segment–segment is dominated), each a realised pair, plus an **exact meeting
test** (so no map hypothesis is needed: two tiles touch iff two pieces meet). Arithmetic: exact multiquadratic field `ℚ(√2, √3, √5, …)`, signs by rational
interval bounds on the square roots refined until decisive, zero decided exactly; one further square root (critical points, intersection points)
handled as `a + b√g`. Floats are printed, never compared.

**Self-test** (`--selftest`, output `data/fs112/fs112-yb/selftest.txt`): eight exact controls (Reuleaux triangle of width 1: ACCEPT; two at gap exactly 1:
ACCEPT; at gap 9/10: REJECT; squares of diagonal 0.99 / 1.06; two unit caps whose nearest pair is interior to both arcs; a cap facing a bar, nearest pair
interior to both; two crossing bars) and six checker plants, **each flipping exactly the controls predicted and no other**: `noself` (the 1.06 square
passes), `endpoints_only` (both interior-pair controls pass), `no_arcarc` (the two caps pass), `no_sa` (the cap and bar pass), `no_meet` (the crossing
bars pass), `closed_interval` (the width-1 Reuleaux triangle and the gap-1 pair reject: tightness is visible). A first design of three controls failed
its own plants — their tiles had diameter above 1, so their self-pairs rejected whatever the plant did; the plants caught the bad controls, which were
rebuilt with every tile of diameter at most 1.

**Calibration** (`tools/fs112_yb_calib.py`, output `data/fs112/fs112-yb/calibration.txt`, 55 s): FS-110's fragments S1, T2, BB, MX, WC, WC1, WCEQ, WCH,
WC1H and A6-C2, built by the frozen builders and converted exactly — **every pair's verdict equals the frozen checker's** (`tools/fs110_y_check.py`),
all ACCEPT, pairs examined equal to `Σ n_c(n_c + 1)/2` in each; the frozen builders' eleven planted faults, the eight tip tests and A6-C2's ten runs —
**same verdicts and the same rejected pairs**; both checkers under `closed_interval` — same rejected pairs (every fragment is tight). **CAL-7** (row 33's
brick seven-colouring, cells `4/5 × 3/5`, shear `2/5`, colour `(i + 3j) mod 7`): the cell `(0,0)` against itself and all ten same-colour cells with
`|i|, |j| ≤ 4` ACCEPT, three exact contacts at 1 (its diagonal, and the cells `(±1, ±2)` corner to corner); every cell beyond the window is at gap
`≥ 8/5`, dismissed exactly. Plants beside it: colour `(i + 2j) mod 7` REJECTs at offsets `(∓2, ±1)` (the vector `−2 + ζ₆` of norm 3 in the kernel, as
the Lean module's docstring predicts); cells `81/100 × 3/5` REJECT on the self-pair (diagonal above 1); `closed_interval` REJECTs CAL-7 (it is tight).

## Stage 3 — SAVED: the strip rebuilt from the printed words (brief step 2; instance O1–O3's objects built)

**The rebuild** (`tools/fs112_yb_strip.py`; every coordinate derived, none from the figure). Midline `y = 0`, midline vertices `P_j = (j/2, 0)`.
**Arch `j`** (columns `[j/2, (j+1)/2]`): corners `P_j, P_{j+1}`; each rounded side is "a circular arc of radius 1 centered at the opposite corner of the
tile", so the straight side `x = j/2` meets the circle about `P_{j+1}` at `V_j = (j/2, √3/2)`, and the two arcs meet at the apex `A_j = (j/2 + 1/4, √15/4)`
("the point of intersection of circular arcs"); arch `j` = `{j/2 ≤ x ≤ (j+1)/2, y ≥ 0} ∩ D(P_j, 1) ∩ D(P_{j+1}, 1)`. **Inverted arch `j`**: its mirror
image. **Top tile over the valley `V_m`**: bounded below by the two arcs through `V_m`, between `A_{m−1}` and `A_m`, vertical sides up to `y = Y`; the rule
"the distance 1 between the point of intersection of circular arcs and the opposite corner of a tile" gives `|A_{m−1} − (m/2 + 1/4, Y)| = 1`, so
`Y = √15/4 + √3/2`. **Both readings of "the point of intersection of circular arcs"** — the apex `A` (two arcs of one arch) and the valley `V_m` (arcs of
two arches) — give the same `Y` (checked exactly); the rule is unambiguous. **Bottom tile**: the mirror image. **Height `2Y = √15/2 + √3` exactly.**
Colours (Figure 4, read): arch `j` → `P, G, B` (`j mod 3`); inverted arch `j` → `M, R, O`; top tile over `V_m` → `R, O, M` (`m ≡ 0, 1, 2`); bottom tile
under `V′_m` → `G, B, P`. Field: `ℚ(√3, √5)` (the arches' sides `√3/2`, the apex `√15/4`: FS112-A's reading confirmed).

**Map consistency** (exact): in a period (12 tiles) every boundary piece is shared by exactly two tiles or lies on the edge `y = ±Y`; every tile's
boundary is one closed chain. Float guard: the twelve tile areas sum to `5.502813721` = period × height.

**The exact check: ACCEPT** (`data/fs112/fs112-yb/strip-check.txt`). Pairs up to the period `3/2`: 90 same-colour orbit pairs examined exactly (the 12
tiles of a period, each with itself and every same-colour tile of columns `−9 … 11`); every same-colour tile beyond is `x`-separated by `≥ 19/4`, so its
minimum distance exceeds 1 (dismissed exactly). **Of the 90, 36 are within reach (minimum ≤ 1), and all 36 touch at exactly 1**: the 12 self-pairs have
diameter exactly 1; the 12 pairs of like tiles three columns apart meet along parallel segments at distance exactly 1; the 12 **out-contact pairs** (a
top tile against the inverted arch whose corner is the centre of its arc; mirror: a bottom tile against an arch) have every point of the arc at distance
exactly 1 from the corner. **No slack pair within reach.**

**CAL-PLANT on the strip** (`strip-plants.txt`; each rejected set predicted by hand before the run): arcs of radius `11/10` about the opposite corner →
exactly the six arch self-pairs (diameter 11/10); radius `9/10` → exactly the twelve out-contact pairs (a corner to the whole arc at 9/10) plus the six
top/bottom self-pairs (valley to far corner `√1.027`); edges raised by `1/100` → exactly the six top/bottom self-pairs; arch 0 recoloured G → exactly
`(U0, U1)` (touching), `(U0, B0)` (0.968) and `(U0, U−2)` (1/2); the checker's `closed_interval` plant → exactly the 36 pairs within reach; `noself` on the
radius-`11/10` plant → nothing (the diameter fault invisible). **Two harness defects found by the plants, both fixed before the verdicts:** my colour-swap
prediction named the orbit `(U1, U3)`, the checker's canonical representative is `(U0, U−2)` (the same orbit, a naming slip of mine); and the `noself`
plant lived only in the fragment driver, so it **could not reach** the strip driver — moved into the pair verdict, where every driver meets it.

**The three causes of a REJECT, told apart in advance** (the brief's discipline): a wrong rebuild shows as a map-consistency failure or a failed identity
(the rule's two readings, the height); a wrong checker shows in the calibration (FS-110's fragments pair by pair, CAL-7, the plants); a wrong print would
show as a REJECT with a consistent rebuild and a calibrated checker. None arose: the strip is ACCEPTED.

## Stage 4 — SAVED: my verdicts on the instance's objects O1–O5 (the brief's step 3), committed before opening Y's record

*Data: `data/fs112/fs112-yb/strip-objects.txt` (vertices, arcs, symmetries, covering pairs, O2, O3), `o45.txt` (wedges, budget, arc lock, chains,
rings), `o3-edge.txt` (the edge test). Placing: midline `y = 0`, `P_j = (j/2, 0)`, top edge `Y = √3/2 + √15/4`. Colours P, G, B, M, R, O as stage 3.
**A labelling slip in the instance file** (harmless, logged): it writes "midline vertices are `P_j = (j/2, 0)`, take `P_1 = (1/2, 0)`, `P_2 = (3/2, 0)`";
by its own formula `(3/2, 0)` is `P_3`. I use the coordinates, and write `P_3` for `(3/2, 0)`.*

### O1 — the strip: **ACCEPT** [tools, exact; one rebuild, mine; checker calibrated (stage 2)]

- **Height** `√15/2 + √3` exactly; field `ℚ(√3, √5)`. **Period** `3/2`; the translation by `1/2` is a symmetry up to the colour permutation `(P G B)(M R O)`;
  also `y ↦ −y` with `(P M)(G R)(B O)`, `x ↦ −x` with `(P B)(M O)`, `x ↦ 1/2 − x` with `(G B)(R O)`, the half-turn about `P_0` with `(P O)(G R)(B M)`; not
  the translation by `1/4`, not the glide `y ↦ −y, x ↦ x + 1/4`.
- **Vertices of one period** (`P_cl`, degree): midline `P_0 {P,B,M,O}`, `P_1 {P,G,M,R}`, `P_2 {G,B,R,O}` — **four colours, degree 4**, straight edges at
  0°, 90°, 180°, 270°, four 90° sectors; valleys `V_0 {P,B,R}`, `V_1 {P,G,O}`, `V_2 {G,B,M}` — degree 3, three 120° sectors; apexes `A_0 {P,R,O}`,
  `A_1 {G,M,O}`, `A_2 {B,M,R}` — degree 3 (the arch's sector 151.04°, the two top tiles 104.48° each); the mirror images `V′_m {G,M,O}, {B,M,R},
  {P,R,O}`, `A′_j {G,B,M}, {P,B,R}, {P,G,O}`; edge points `(m/2 + 1/4, ±Y)`, two colours and one boundary piece: top `{R,O}, {M,O}, {M,R}`, bottom
  `{G,B}, {P,B}, {P,G}`.
- **Unit arcs**: all boundary arcs have radius 1; 12 per period, four centred at each midline vertex (on `ω(P_j)`, spanning `arccos(1/4) − π/3 ≈ 15.52°`
  each). **Contact kind: every one is "both", with the self case** — its inner tile is the arch or inverted arch whose corner is the centre, and its
  outer colour (a top or bottom tile) is carried at the centre by the inverted arch or arch on the other side. This is `[Polymath2021]` p. 194's tactic
  exactly ("a tile T of color 1 can share a boundary segment E with a tile U of color 2 and also a point P with a tile V also of color 2, if E is drawn as
  an arc of radius 1 centered on P": T the arch, U the top tile, V the inverted arch at P). No in-only, out-only or inert arc.
- **Tight: yes, in the strongest form** — every one of the 36 same-colour pairs within reach (per period) touches at exactly 1: 12 self-pairs (diameter
  exactly 1), 12 pairs of like tiles three columns apart (parallel segments at distance exactly 1), 12 out-contact pairs (a whole unit arc at distance
  exactly 1 from a corner). No slack pair.
- **Arc-closed** (C-ARC-END): every unit arc's two ends are trivalent vertices at heights `√3/2`, `√15/4` < Y, in the fully coloured strip.

### O2 — the unit rhombus `P_1 = (1/2, 0)`, `W = (1, √3/2)`, `P_3 = (3/2, 0)`, `W′ = (1, −√3/2)` [tools, exact; one mind]

`P_cl(P_1) = {P,G,M,R}`, `P_cl(P_3) = {P,B,M,O}` (four-colour, degree 4); `P_cl(W) = {G,B,M}`, `P_cl(W′) = {P,R,O}` (trivalent). All four sides and the
diagonal `P_1P_3` are 1; `|WW′| = √3`. **`W, W′` are a complementary pair at distance `√3`.** `ω(P_1) ∩ ω(P_3) = {W, W′}` exactly (the instance's
"`ω(P_1) ∩ ω(P_2)`"); the two closure types meet in `{P, M}`. **Unit arcs through `W`**: the arc of `ω(P_1)` from `W` to `A_1 = (3/4, √15/4)` and the arc of
`ω(P_3)` from `W` to `A_2 = (5/4, √15/4)`; through `W′` their mirror images; **all four have both ends interior to the strip: arc-closed.** Colours near the
seam points: `ω(W)` leaves `P_1` along 150° into `U0` (P) and 330° into `D1` (R), leaves `P_3` along 30° into `U3` (P) and 210° into `D2` (O); `ω(W′)` leaves
`P_1` along 30° into `U1` (G) and 210° into `D0` (M), leaves `P_3` along 150° into `U2` (B) and 330° into `D3` (M) — each outside its centre's type (A-CIRC),
and **the two circles' branches alternate** at `P_1` and at `P_3` (30° W′, 150° W, 210° W′, 330° W), as Y-T2W says. **So the strip realises T2 (C-T2 (i))
exactly and arc-closed**, and a second T2 on a non-spindle unit rhombus: `A_j, A′_j` (complementary, distance `√15/2`) with `w₀, w₀′ = P_j, P_{j+1}`
(`|w₀w₀′| = 1/2`). **C-SEAMS-TWO on the strip: TRUE for the seams it realises** — T2's seam points are four-colour vertices, each the centre of the unit
arcs its pair emits (a four-colour unit-arc centre); N-X's conclusion holds at them (no unit arc passes *through* `P_j`; the types of `(W, W′)` are
disjoint); no (S1) seam occurs in the strip.

### O3 — the top edge: `V_0 = (0, √3/2)`, `A_1 = (3/4, √15/4)` [hand, one mind; exact identities; exact checks at named points]

`P_cl(V_0) = {P,B,R}`, `P_cl(A_1) = {G,M,O}`: **complementary**, `|V_0A_1|² = (9 − 3√5)/4` (distance ≈ 0.75693). **Common unit points: `X_1 = (1/4, Y)`,
exactly on the top edge** (the vertex where the top tiles `T0` (R) and `T1` (O) meet the edge; `P_cl(X_1) = {R, O}`), **and `P_1 = (1/2, 0)`** (`= V_0 + A_1 −
X_1`; a four-colour midline vertex at which both `V_0` and `A_1` emit arcs of `ω(P_1)`: half of T2). **No colour can be given**: every point `Z = X_1 + εu`
with `u` at an angle in the open cone `(30°, 165.52°)` (all above the edge) and `ε` small lies outside both `D(V_0, 1)` and `D(A_1, 1)`, so near `V_0` its
unit circle runs at a small positive offset toward `X_1` and crosses the rays at 30° and 150° — through the sectors P, R, B — and near `A_1` crosses the
rays at 90° and 194.48° — through M, O, G: interior points of all six colours at distance exactly 1. Exact confirmations: at `X_1 + (0, 1/100)`,
`X_1 + (1/100, 1/100)`, `X_1 + (−1/100, 1/100)` every colour has a straddling tile (no colour free); control outside the cone, `X_1 + (−1/100, 1/1000)`
(174°): R free, as derived; above the middle of a top tile, `(1/2, Y + 1/100)`: B and O free. **So the colouring cannot be continued into any open set above
the edge at `X_1`** — nor, by the period-`1/2` symmetry, at any edge vertex, top or bottom. **Why, structurally** (exhaustive over one period): the strip's
close complementary pairs are `(V, A)`-type (distance ≈ 0.75693; 12 per period), `(V_m, V′_m)` (√3; 3) and `(A_j, A′_j)` (√15/2; 3); each common unit point
of each is either a midline four-colour vertex at which both members emit arcs of its unit circle, or **exactly an edge vertex** — the `(V, A)` pairs'
second point. Every trivalent vertex's unit circle leaves the strip exactly between two edge vertices. **This names C-BEYOND's step for the strip: a NO
route must read the plane at the strip's edge vertices**, the unsaved second common unit points of its close complementary pairs.

### O4 — the strip against the unit-arc-centre claims

| claim | verdict on the strip | grade, minds |
|---|---|---|
| **C-UA-INC** | Exactly one kind occurs: **both, with the self case**, at all 12 arcs per period. In-only, out-only and inert do not occur. For tight six-*maps* of the plane the question stays open: the strip shows "both (self)" is realisable in a tight arc-closed local positive, nothing more (C-BEYOND). | [tools, exact]; one |
| **C-UA-WEDGE** | **MISSTATED.** As written ("the `c`-tiles at `P` face the arc") it is false for `c = s_out`: at every arc the outer colour's tile at the centre lies in the wedge facing **away** (e.g. the arc of `ω(P_1)` at directions [104.48°, 120°], sides P \| R: the R-tile at `P_1` is `D1`, at [270°, 360°], inside the away wedge [210°, 14.48°]). **Corrected**: "if `P` carries `s_in`, its tiles at `P` lie in the facing wedge `{d : d·e ≥ 0 for every arc direction e}`; if `P` carries `s_out`, its tiles lie in the away wedge `{d·e ≤ 0}`; neither side colour meets the two side cones" — **TRUE** (for `q = P + εd` in an `s_in`-tile with `d·e < 0` for some arc direction `e`, `ω(q)` passes inside the arc near `P + e`, into the inner tile; symmetrically for `s_out`) — TS-U read conditionally (A4-TSU). The strip satisfies the corrected form at all 12 arcs (exact angle comparisons); its killing test (a side colour in a side cone) does not fire. | corrected form [hand], one; the strip [tools, exact] |
| **C-UA-BUDGET**, branch 1 (no covering pair `(v, y)`, `y ∈ ω(v)`) | **No instance on the strip** under the list's covering-pair sense (union all six, FS-110 §9 correction 1): every four-colour vertex `P_j` has covering partners at ring points, `P_{j±2}` (four-colour, types overlapping in two colours). Under the disjoint sense (NB §2.3's `P_cl(y) = {e, f}`) `P_j` has no partner, and branch 1 **holds**: four Γ-arcs on `ω(P_j)`, each of cosine `1/8 + 3√5/8 = cos(arccos(1/4) − π/3)` exactly, total **62.09° ≥ 60°**. | [tools, exact]; one |
| **C-UA-BUDGET**, branch 2 (a covering pair at a ring point `y`) | **FALSE on the strip under the union sense**: `P_1`'s partners `y = P_3, P_{−1}` carry no Γ-arc of `ω(σ_v^{±1}y)` (`σ^{±1}P_3 = W, W′`); `P_1`'s unit arcs are centred at `P_1` itself. Under the disjoint sense: no instance. **Are the branches exclusive on the strip?** Their hypotheses are, by definition; their conclusions are not tied to them — the strip's four-colour vertices meet branch 2's hypothesis (union sense) with branch 1's conclusion (arcs centred at `v`, ≥ 60°). **Verdict: MISSTATED** — branch 2's conclusion is NB §2.3's derivation, which is for the disjoint case `P_cl(y) = {e, f}` and assumes no Γ-arc on `ω(v)`; union-sense partners with overlapping types force nothing at `y`. | [tools, exact]; one |
| **C-UA-CHAIN** | First two clauses consistent on the strip: each unit arc's end vertices start further unit arcs, and the arcs lie in chains (no cycles). **Third clause: GAP at "a monotone quantity along a chain excludes bi-infinite chains"** — the strip carries two tight, periodic, bi-infinite chains of unit arcs, end to end (`… V_0 –ω(P_1)– A_0 –ω(P_0)– V_1 –ω(P_2)– A_1 –ω(P_1)– V_2 …` at heights `√3/2 … √15/4`, and its mirror); any such quantity must read beyond the strip (C-BEYOND). The killing test (a closed cycle) does not fire: no closed cycle of unit arcs occurs. | [tools, exact] + [hand]; one |
| **ARC-INERT** | **Vacuous on the strip** (no inert arc). Its converse is exact on the strip: a "both" arc is **locked on both sides** — the arc of `ω(P_1)` between arch `U1` (G) and the top tile `T2` (M), bent inward to its chord, rejects exactly `(D0, T2)` (the out-contact at `P_1`); bent outward by a kink to distance 1.08992 from `P_1`, rejects exactly `(U1, U1)` (the self in-contact) — both predicted. In general, an in-contact locks outward bends and an out-contact locks inward bends [hand, one mind]. Consistent with ARC-INERT's reduction: the strip *is* the reduced object (unit arcs with a contact at the centre). | [tools, exact] + [hand]; one |

### O5 — the strip against the Condition-5 chain (each step read with Condition 5 dropped; "contradicted" = the strip holds a tight valid local configuration violating the step's conclusion, inside the region the step's proof reads)

The strip's unit arcs all lie on the circles `ω(P_j)` about the midline vertices; a circle about any other point meets them in finitely many points. So a step
reading only circles about trivalent points meets Condition 5 on the strip; a step reading `ω(v)` at a midline vertex meets four unit arcs.

| step | verdict on the strip | configuration |
|---|---|---|
| C-CHAIN-1 NB-4 | **CONTRADICTED** — four-colour vertices, the proof's region `B(v, 1 + ε)` inside the strip. Escape: Γ-arcs **on `ω(v)`** — the ring's colour changes run along unit arcs centred at `v`, where NB §2.3's premise "`c(θ + 60°) ≠ c(θ)`, so every change point `y` is a swap with `σ_v y` and `σ_v^{-1}y`" fails (at `P_1` the ring is B on (0°, 60°), a Γ-arc on [60°, 75.52°], O on (75.52°, 104.48°), …). The printed general form ("`ω(y_k)` … passes through `y_k`") is vacuous in that clause as written; read with `ω(v)` for `ω(y_k)`, the strip's `P_j` satisfies it (every σ-orbit of change points meets a Γ-arc of `ω(v)`). | `P_1`: `{P,G,M,R}`, degree 4, four arcs of `ω(P_1)`, 62.09° |
| C-CHAIN-2 NB-5 | **CONTRADICTED** — close covering pairs inside the strip, their common unit points four-colour vertices (so the step fails exactly through NB-4). | `(W, W′)` at √3 with `P_1, P_3` (O2); `(A_j, A′_j)` at √15/2; the `(V, A)` pairs at 0.757 (one point on the edge) |
| C-CHAIN-3 N3-CONF | **Holds in substance; its parenthetical "(finitely many, Condition 5)" fails** at the arc centres — the contacts of a colour on `ω(P_j)` include whole unit arcs. Every contact is in-type or out-type, and every sector lies in `D_c(P_j)` (at `P_1`: `D_G = [−14.48°, 90°] ⊇ [0°, 90°]`, `D_P = [90°, 194.48°] ⊇ [90°, 180°]`, `D_M = [165.52°, 270°] ⊇ [180°, 270°]`, `D_R = [270°, 14.48°] ⊇ [270°, 360°]` [hand, one mind]). | `P_j` |
| C-CHAIN-4 W-MERGE | not contradicted — vacuous (no colour has two sectors at any vertex) | — |
| C-CHAIN-5 N3-DEG | not contradicted — `int D_c(v) ≠ ∅` at every vertex for every `c ∈ P_cl(v)` (104.48° wide at `P_j`); no cusp | — |
| C-CHAIN-6 N4-SHADOW | **Holds off the exception λ = −1, fails as written there**: for an arc tangent to `a` at `N` that is an arc of `ω(v)`, `f(λ) = λ/(1 + λ)` is undefined and "the circle through `v` concentric with that arc" degenerates to `{v}`; the shadow near `v` of the tile beyond it is the open cone of directions within 90° of the arc. | at `P_1`, the tile `T2` beyond the arc [60°, 75.52°]: shadow directions (−30°, 165.52°) |
| C-CHAIN-7 N4-SHAVE | not contradicted — vacuous (no horn) | — |
| C-CHAIN-8 N4-STUCK | not contradicted — vacuous (no two-sector colour) | — |
| C-CHAIN-9 N4-FIN | not contradicted — an arithmetic statement on the open interval; unit arcs sit at its excluded endpoints λ = −1, υ = 1 (the poles of `f`, `f̃`) | — |
| C-CHAIN-10 N4-TERM | **CONTRADICTED in its last clause** — the strip admits no merge, ray merge or shave, so it is its own terminal modification ("no colour has two sectors" holds), yet "every vertex is cubic" fails; that inference is NB-4's `|P_cl| ≤ 3`. | `P_j`, degree 4 |
| C-CHAIN-11 NB4-CS | not contradicted — vacuous (no cusp horn) | — |
| C-CHAIN-12 P17 | not contradicted — vacuous on the strip: no trivalent vertex's ring lies in it (each leaves between two edge vertices) | — |
| C-CHAIN-13 COR1-NOD2 | not contradicted — global, and the strip is not cubic | — |
| C-CHAIN-14 CB-LEMMA3 | **not contradicted, and consistent with O3**: the strip holds trivalent pairs with equal closure types at distances `3/2` and `√(9/4 + 3√5/4) ≈ 1.9817` — the configuration Lemma 3 forbids — whose unit circles carry no unit arc (Condition 5 holds on the circles the lemma reads); those circles leave the strip between edge vertices, exactly where the colouring cannot be continued. | `(V_0, V_3)` `{P,B,R}` at 3/2; `(V_0, A′_1)` `{P,B,R}` at 1.9817; etc. (listed in `o45.txt`) |
| C-CHAIN-15 CE5 | not contradicted — on every trivalent ring the M-in points are vertices (midline and edge vertices), and no antipodal pair of them lies in the strip (for the apex rings the antipodes of the midline M-in points lie beyond it) | exact list in `o45.txt` |
| C-CHAIN-16 CE6 | not contradicted — a statement about the reduction on cubic maps | — |
| C-CHAIN-17 CUSP-BASE | not contradicted — vacuous (no cusp) | — |
| C-CHAIN-18 FS110-CLOSURE | not contradicted — global; a strip is a local positive (C-BEYOND) | — |

**Summary of O5.** The first failure in chain order is **C-CHAIN-1 (NB-4)**, at the four-colour midline vertices, through unit arcs on `ω(v)` itself; it
carries NB-5 and N4-TERM's "cubic" clause with it; N4-SHADOW degenerates at λ = −1 (the same arcs seen from their centre); N3-CONF loses only its
finiteness parenthetical. The cone steps (4–11) are vacuous on the strip (no two-sector colour, no horn), the base steps (12–17) are about cubic maps
or rings the strip does not hold, and the headline is global.

### Theorems this phase proved (stage 4 adds; stage 3's strip result first)

| id | statement | grade | address |
|---|---|---|---|
| YB-STRIP | The strip rebuilt by formula from `[AxenovichEtAl2014]` p. 8's words (Figure 4 read for combinatorics) is a valid six-colouring of the strip of height `√15/2 + √3`; every same-colour pair within reach touches at exactly 1 | [tools, exact]; one rebuild | stage 3; `tools/fs112_yb_strip.py` |
| YB-CONTACT | Every unit arc of the strip is "both", with the self case (`[Polymath2021]` p. 194's tactic) | [tools, exact] | O1; `tools/fs112_yb_objects.py` |
| YB-T2 | The strip realises T2 exactly and arc-closed, on the spindle rhombus (`W, W′` at √3) and on a thin unit rhombus (`A_j, A′_j` at √15/2, `|w₀w₀′| = 1/2`) | [tools, exact] | O2 |
| YB-SEAMS | Every close complementary pair of the strip has each common unit point either at a midline four-colour vertex where both members emit arcs of its unit circle, or exactly at an edge vertex | [tools, exact], exhaustive over one period | O3; `strip-objects.txt` |
| YB-EDGE | The strip's colouring cannot be continued into any open set above an edge vertex: every point of the open cone (30°, 165.52°) at `X_1` is at distance exactly 1 from interior points of all six colours | [hand, one mind]; exact at three named points and two controls | O3; `o3-edge.txt` |
| YB-WEDGE | C-UA-WEDGE corrected (inner colour facing, outer colour away, side cones free) is TRUE | [hand], one; the strip [tools, exact] | O4 |
| YB-LOCK | In-contact locks outward bends of a unit arc, out-contact locks inward bends; a "both" arc cannot be bent either way | [hand], one; one arc [tools, exact] | O4; `o45.txt` |
| YB-CHAIN | A tight valid six-coloured strip carries bi-infinite periodic chains of unit arcs | [tools, exact] | O4 |
| YB-NB4 | Without Condition 5, NB-4 fails at a tight four-colour vertex whose ring carries four unit arcs centred at it (62.09° in all); NB-5 and N4-TERM's cubic clause fail with it | [tools, exact] + [hand]; one | O5 |

### Would have searched here (stages 3–4)

- Fit Figure 4's pixels for the tiles' positions → every coordinate derived from the printed rules; the figure read for rows, offsets and colours only.
- Scan the arc radius for where the strip breaks → two named plant values (11/10, 9/10), their rejected pairs predicted by hand.
- Sweep points above the edge to map the uncolourable region → the cone derived; four named points and a control checked exactly.
- Enumerate colourings of the tile layout to see whether Figure 4's is forced → not done (a search); the figure's colouring checked exactly.
- Search bendings of an arc that keep validity → the lock derived; the two named bends checked.

### Proposed `BIBLIOGRAPHY.md` reading-status edits (the close writes them)

`[AxenovichEtAl2014]`: p. 8 read (text), Figure 4 viewed for its combinatorics (FS112-YB, 2026-09-27), the strip rebuilt exactly and accepted by an exact
checker. `[Polymath2021]`: pp. 194–195 and 197–200 read (FS112-YB).

## Stage 5 — SAVED: Y's record and tools read (the brief's step 4); every divergence, with both addresses

*Read after stage 4 was committed (`adaa1f36`): `plans/FS112-Y-construction.md` in full, `tools/fs112_y_check.py` (header and structure),
`tools/fs112_y_calibrate.py` (structure), `data/fs112/fs112-y/calibrate_strip.out`, `calibrate_plants.out`. Y's strip calibration re-run at today's HEAD
(`python3 tools/fs112_y_calibrate.py strip plants`): identical output. Y's two strip plants I had not run, rebuilt from their words and put through my
checker (`data/fs112/fs112-yb/y-plants-through-yb.txt`).*

**The headline: no object and no verdict differs.** The two rebuilds are the same strip (same geometry; the same colouring under the label map
P, G, B, M, R, O ↔ Y's 1, 2, 3, 4, 5, 6: arches `A_j` = 1, 2, 3; inverted arches `B_j` = 4, 5, 6; top tiles `C_j` = 5, 6, 4; bottom tiles `D_j` = 2, 3, 1),
both ACCEPTed by independent exact checkers — **CAL-STRIP calibrated in the robust form the claim list §7 asks for.** Every closure type Y reports
(`P_1 {1,2,4,5}`, `(3/2, 0) {1,3,4,6}`, `W {2,3,4}`, `V₀ {1,3,5}`, `A₁ {2,4,6}`, `W′ {1,5,6}`) equals mine; Y's ring of `P_1` ("`3 | Γ | 6 | Γ | 3 | 6 | Γ | 3 | Γ | 6`")
equals mine (B, Γ, O, Γ, B, O, Γ, B, Γ, O).

| # | divergence | Y's address | mine | kind |
|---|---|---|---|---|
| D1 | **Label slip**: Y writes `P_j = (x_j, 0)`, `x_j = j/2`, then calls `(3/2, 0)` "`P_2`" (T2's second seam point); the instance file inherits it. By the formula it is `P_3`. Coordinates are explicit, so no object changes. | §1.3 item 4; §2.2; Y112-T2-SQRT3 | stage 4 header | slip, harmless |
| D2 | **Reading of the rule**: Y fixes the top edge by "distance 1" from the **valley** to the top corners; I checked both readings of "the point of intersection of circular arcs" (valley and apex) and they give the same `Y` exactly. Same object; the rule is unambiguous. | §1.3 | stage 3 | reading, same object |
| D3 | **CAL-7's object**: Y calibrated on the tight **hexagonal** seven-colouring (side 1/2; controls side 11/20 and the index-4 colouring — FS110-Y's frozen controls); the claim list's CAL-7 is "row 33's boundary-tight **brick** colouring (G20)". Mine is the brick (`4/5 × 3/5`, shear `2/5`, `(i + 3j) mod 7`), ACCEPT, with two plants. Both tight seven-colourings; only the brick is the named object. | §2.1 row 2; `tools/fs112_y_calibrate.py` `hexs()` | stage 2; `tools/fs112_yb_calib.py` `cal_7()` | calibration object differs from the claim list |
| D4 | **Checker model**: Y keeps FS110-Y's MAP HYPOTHESIS (distinct tiles touch only at shared endpoints), guarded by a float partition sample (4,896 samples, 0 overlaps, 0 holes); mine replaces it by an exact meeting test and, on the strip, an exact map-consistency check (every piece shared by exactly two tiles or on the edge; every chain closed). **The exact check confirms, on the strip, the hypothesis Y's verdict assumed.** | `tools/fs112_y_check.py` header | `tools/fs112_yb_check.py`; `fs112_yb_strip.py` `consistency()` | model; verdicts agree |
| D5 | **Pairs counted**: Y 60 ordered pairs (first in one period, horizontal gap ≤ 1); mine 90 orbit pairs examined, 36 within reach (minimum ≤ 1). **The same population**: 60 = 12 self-pairs + 2 × 24. No pair within reach was examined by one checker and not the other. Completeness: Y by "a window twice as wide adds none"; mine by an exact gap bound (19/4). | §2.1 row 3; `calibrate_strip.out` | stage 3 | count convention |
| D6 | **Arcs counted**: Y "22 unit arcs read in columns −1…4"; mine 12 per period, four per column (so 24 in six columns). Every one "both" in both. The count 22 is not reconciled (probably a window-edge effect); verdict-neutral. | §2.2 | stage 4 O1 | unreconciled count, verdict-neutral |
| D7 | **Plants**: `tall` run by both, same six self-pairs. Y's `flat` and `swap`, rebuilt from their words through my checker: **the same rejected pairs** (`flat`: my 12 out-contact orbit pairs = Y's 24 ordered; `swap`: `(D0, T1)`, `(D2, T2)` = Y's `(B0, C1)`, `(B2, C2)`). My `rho11`, `rho9`, `colswap` were not run by Y; Y's `cw_arcs` and `endpoints_only` on the strip not by me. | §2.2; `calibrate_plants.out` | stage 3; `y-plants-through-yb.txt` | cross-check agrees |
| D8 | **Close complementary pairs found by one side only**: I also find `(A_j, A′_j)` at `√15/2` (three per period), saved by T2 at `P_j, P_{j+1}` on a **thin** unit rhombus (`|w₀w₀′| = 1/2`) — T2 is not only "the spindle's rhombus" — and the overlapping covering pairs `(P_j, P_{j+1})` at 1/2. Y lists `(W, W′)`, `(V₀, A₁)` and `(P_1, (3/2, 0))`. | §1.3 item 5 | stage 4 O2, O3; `strip-objects.txt` | a finding one side has |
| D9 | **Y112-EDGE**: the same pair and point; Y's no-colour step [hand, one mind]; mine the same argument blind, plus the exact open cone (30°, 165.52°), three exact named points and a control outside the cone (R free, as derived). **The no-colour step is now two minds, one blind.** | §1.5, Y112-EDGE | stage 4 O3; `o3-edge.txt` | agreement, second mind |
| D10 | **The chain walk**: on every step the strip decides, the verdicts agree — NB-4 (c) at `P_1`; NB-5 (c) at `(W, W′)`; N3-CONF holds with "finite" relaxed; N4-SHADOW degenerate at λ = −1 with the same cone; N4-TERM's "cubic" (c). Where the strip is silent, Y gives general verdicts off named exceptions (steps 4–8, 11–17, the `κ = ±1` GAPs, W1–W5), which my instance does not ask; I record "vacuous / not contradicted" there. The headline: Y "(c): its proof does not transfer", mine "not contradicted (global)" — different questions, consistent. | §1.4, §2.3 | stage 4 O5 | framing only |
| D11 | **O4's claims**: the same verdicts where both give one — C-UA-WEDGE MISSTATED for the outer colour; C-UA-BUDGET's second branch fails at `P_1`; the strip's bi-infinite periodic chain; C-UA-INC "both" only. Mine adds: the corrected WEDGE verified at all 12 arcs; BUDGET's diagnosis (union versus disjoint covering sense; branch 1 holds at 62.09° under the disjoint sense); ARC-INERT vacuous on the strip, with the arc lock (two exact bends). | §2.5 item 4 | stage 4 O4 | agreement; mine adds |
| D12 | **Examined by Y only**: W1's corrected NB-4 (α)(β)(γ) (not in my instance; my data confirm the strip satisfies (α) in every orbit); W4's reading of the base's circles (my arc list confirms the arcs at `V₀`, `A₁` are centred on their unit circles); W2, W3 retractions (off the strip). **Examined by me only**: exact M-in points and antipodes on every trivalent ring (C-CHAIN-15); same-type trivalent pairs also at `√(9/4 + 3√5/4) ≈ 1.9817` (C-CHAIN-14). | §2.3 | stage 4 O5 | coverage |

**The fence discipline held**: nothing of Y's was opened before `adaa1f36`; the only touch is the start-up listing of directory names (fence log).
