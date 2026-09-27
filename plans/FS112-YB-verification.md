# FS112-YB — blind verification of FS-112's construction side (the strip, its unit arcs, the objects Y's report names)

*Job FS112-YB, Opus 5.5, launched 2026-09-27 at HEAD `131a0a54`. Brief: `data/fs112/briefs/YB112-verify-construction.md`, instance file
`data/fs112/briefs/YB112-instance.md`, with `data/fs112/briefs/STANDING-RULES.md`. My own checker `tools/fs112_yb_check.py` is written without reading
Y's; every object is rebuilt from its defining words; my verdicts are committed (step 3) before I open `plans/FS112-Y-construction.md`.*

## Theorems this phase proved

*(filled stage by stage; one line each, with grade and address)*

## Would have searched here (standing rule 3)

*(one line per move I would have made by search, and what I did instead)*

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
