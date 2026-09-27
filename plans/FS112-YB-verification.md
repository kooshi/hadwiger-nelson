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
