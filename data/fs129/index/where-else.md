<!-- the where-else column of theorems.jsonl as tables | command: python3 tools/fs129_z2_whereelse.py | FS129-Z2 -->

# Where else each theorem bears (FS-129)

Built by `tools/fs129_z2_whereelse.py` from the FS-129 readers' tables of misses, merge lists and sweeps, their verdict paragraphs, and every FS-129 entry's `uses only:` line; each site has the reader's address. `theorems.jsonl` carries the same items in the fields `where_else` and `near_misses` (a near miss names a failing hypothesis, and is not a bearing). Re-running `tools/fs129_index.py` rewrites `theorems.jsonl` without these fields; re-run this script after it.

**Counts**: 97 theorems have a site, 200 sites in all (era A 3, era R 94); near misses 28.

| reading lane | theorems with a site | composition | merge | stronger form held | answered elsewhere | closes | shortens | reduces | shared step (not one statement) | bears unapplied | bears | near miss |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| A | 4 | 2 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 |
| R | 93 | 43 | 55 | 12 | 18 | 5 | 18 | 19 | 14 | 0 | 12 | 28 |

## By theorem

| theorem | era | site | kind | address | by |
|---|---|---|---|---|---|
| FS106-AE-MAP6 | R | FS129-OR1-TOP5 | composition | plans/FS129-OR1-audit.md:444 | FS129-OR1 |
| FS106-AE-MAP6 | R | J10 — The map step at five: no open stub carries it | reduces | plans/FS129-OR1-audit.md:428 | FS129-OR1 |
| FS106-AE-MAP6 | R | J10 — The map step at five: no open stub carries it | reduces | plans/FS129-OR1-audit.md:433 | FS129-OR1 |
| FS106-AE-MAP6 | R | J10 — The map step at five: no open stub carries it | reduces | plans/FS129-OR1-audit.md:437 | FS129-OR1 |
| FS106-AE-MAP6 | R | J10 — The map step at five: no open stub carries it | reduces | plans/FS129-OR1-audit.md:441 | FS129-OR1 |
| FS106-AE-MAP6 | R | J23 — A root: Townsend's simplification (c), in full | shortens | plans/FS129-OR1-audit.md:692 | FS129-OR1 |
| FS106-BIKE | R | FS129-OA1-RINGWIND | bears unapplied | plans/FS129-MA1-audit.md:398 | FS129-MA1 |
| FS106-COMP | R | FS116-O1-YESLIM | merge | plans/FS129-SR2-audit.md:320 | FS129-SR2 |
| FS106-COMP | R | FS129-SR2-YESLIM-EQ | composition | plans/FS129-SR2-audit.md:352 | FS129-SR2 |
| FS106-DIAM | R | FS111-C-HULL | merge | plans/FS129-SR2-audit.md:76 | FS129-SR2 |
| FS106-DIAM | R | FS111-V0-CLOSE | merge | plans/FS129-SR2-audit.md:76 | FS129-SR2 |
| FS106-DIAM | R | FS116-V5-NE1 | merge | plans/FS129-SR2-audit.md:76 | FS129-SR2 |
| FS106-DIAM | R | FS116-V5-NE1 | merge | plans/FS129-SR2-audit.md:334 | FS129-SR2 |
| FS106-DIAM | R | FS129-SR2-CLOSURE | merge | plans/FS129-SR2-audit.md:76 | FS129-SR2 |
| FS106-EQ | R | FS116-O1-YESLIM | merge | plans/FS129-SR2-audit.md:320 | FS129-SR2 |
| FS106-EQ | R | FS129-SR2-SUPK | stronger form held | plans/FS129-SR2-audit.md:79 | FS129-SR2 |
| FS106-EQ | R | FS129-SR2-YESLIM-EQ | composition | plans/FS129-SR2-audit.md:352 | FS129-SR2 |
| FS106-SUP | R | FS129-SR2-SUPK | stronger form held | plans/FS129-SR2-audit.md:80 | FS129-SR2 |
| FS106-SUP | R | FS129-SR2-SUPK | composition | plans/FS129-SR2-audit.md:176 | FS129-SR2 |
| FS106-SUP | R | J12 — FS-104 route (c): correlation constraints on stationary colourings | near miss | plans/FS129-OR1-audit.md:503 | FS129-OR1 |
| FS106-TS-T | R | FS129-SR2-DISC1TS | composition | plans/FS129-SR2-audit.md:193 | FS129-SR2 |
| FS106-TW | R | J23 — A root: Townsend's simplification (c), in full | shortens | plans/FS129-OR1-audit.md:693 | FS129-OR1 |
| FS107-R-CP | R | J14 — FS-122: B-RR, a cone-scale bound independent of the holes | near miss | plans/FS129-OR1-audit.md:519 | FS129-OR1 |
| FS107-R-SW | R | J16 — FS-122: a robust count, and whether the kills survive a band | near miss | plans/FS129-OR1-audit.md:561 | FS129-OR1 |
| FS110-A3-HOLE | R | FS112-A4SIX | answered elsewhere | plans/FS129-MR1-audit.md:411 | FS129-MR1 |
| FS110-A3-HOLE | R | FS116-N1-QDISK | answered elsewhere | plans/FS129-MR1-audit.md:411 | FS129-MR1 |
| FS110-A3-HOLE | R | FS116-N1-QFREE4 | answered elsewhere | plans/FS129-MR1-audit.md:411 | FS129-MR1 |
| FS110-A3-HOLE | R | FS116-Y2-SIXFRAG | answered elsewhere | plans/FS129-MR1-audit.md:411 | FS129-MR1 |
| FS110-CE4 | R | J22 — A root: row 134's base, Lemma 4 at cusps | near miss | plans/FS129-OR1-audit.md:677 | FS129-OR1 |
| FS110-CLOSURE | R | J20 — FS-128: C121-NOPAR-C5 | near miss | plans/FS129-OR1-audit.md:660 | FS129-OR1 |
| FS110-CUSP-BASE | R | J22 — A root: row 134's base, Lemma 4 at cusps | near miss | plans/FS129-OR1-audit.md:676 | FS129-OR1 |
| FS110-N2-RING | R | FS110-Y3-GP | merge | plans/FS129-SR1-audit.md:194 | FS129-SR1 |
| FS110-N2-RING | R | FS129-SR1-RINGBAND | composition | plans/FS129-SR1-audit.md:319 | FS129-SR1 |
| FS110-N2-RING | R | J2 — FS-124, case 1: SEMI-PAR3 | shortens | plans/FS129-OR1-audit.md:271 | FS129-OR1 |
| FS110-N4-TERM | R | J23 — A root: Townsend's simplification (c), in full | shortens | plans/FS129-OR1-audit.md:690 | FS129-OR1 |
| FS110-N4-TERM | R | J23 — A root: Townsend's simplification (c), in full | shortens | plans/FS129-OR1-audit.md:692 | FS129-OR1 |
| FS110-W-MERGE | R | J23 — A root: Townsend's simplification (c), in full | shortens | plans/FS129-OR1-audit.md:690 | FS129-OR1 |
| FS110-Y3-GP | R | FS110-N2-RING | merge | plans/FS129-SR1-audit.md:194 | FS129-SR1 |
| FS110-Y3-GP | R | FS129-SR1-RINGBAND | merge | plans/FS129-SR1-audit.md:194 | FS129-SR1 |
| FS110-Y3-GP | R | J2 — FS-124, case 1: SEMI-PAR3 | shortens | plans/FS129-OR1-audit.md:271 | FS129-OR1 |
| FS110-Y3-GP | R | J2 — FS-124, case 1: SEMI-PAR3 | shortens | plans/FS129-OR1-audit.md:276 | FS129-OR1 |
| FS111-C-HULL | R | FS106-DIAM | merge | plans/FS129-SR2-audit.md:76 | FS129-SR2 |
| FS111-C-HULL | R | FS129-SR2-HULLSET | stronger form held | plans/FS129-SR2-audit.md:93 | FS129-SR2 |
| FS111-C-HULL-SO | R | FS111-C-HULL | bears | plans/FS129-MR1-audit.md:420 | FS129-MR1 |
| FS111-C-SAT-T-HONEST | R | J10 — The map step at five: no open stub carries it | reduces | plans/FS129-OR1-audit.md:430 | FS129-OR1 |
| FS111-M-COVER-SC | R | FS111-M2-HULLC | bears | plans/FS129-SR2-audit.md:94 | FS129-SR2 |
| FS111-M-PINCH | R | FS111-M-R7 | answered elsewhere | plans/FS129-SR3-audit.md:351 | FS129-SR3 |
| FS111-M-PINCH | R | J10 — The map step at five: no open stub carries it | reduces | plans/FS129-OR1-audit.md:439 | FS129-OR1 |
| FS111-M-R7 | R | FS111-M-PINCH | answered elsewhere | plans/FS129-SR3-audit.md:351 | FS129-SR3 |
| FS111-M-REDUCE-I | R | FS129-OR1-TOP5 | composition | plans/FS129-OR1-audit.md:444 | FS129-OR1 |
| FS111-M-REDUCE-I | R | J10 — The map step at five: no open stub carries it | reduces | plans/FS129-OR1-audit.md:429 | FS129-OR1 |
| FS111-M2-INT | R | FS111-M3-IRREG | bears | plans/FS129-SR3-audit.md:353 | FS129-SR3 |
| FS111-M2-INT | R | FS129-SR2-CLOSURE | composition | plans/FS129-SR2-audit.md:144 | FS129-SR2 |
| FS111-M2-REDUCE-C | R | J10 — The map step at five: no open stub carries it | reduces | plans/FS129-OR1-audit.md:428 | FS129-OR1 |
| FS111-M2-REDUCE-C | R | J10 — The map step at five: no open stub carries it | reduces | plans/FS129-OR1-audit.md:430 | FS129-OR1 |
| FS111-M3-CASCADE | R | J11 — FS-120: the pinch at a junction | near miss | plans/FS129-OR1-audit.md:495 | FS129-OR1 |
| FS111-M4-CUT | R | FS121-V5-FACE-SHARP | merge | plans/FS129-MR1-audit.md:413 | FS129-MR1 |
| FS111-M4-CUT | R | FS121-V5-FACE-SHARP | shared step (not one statement) | plans/FS129-SR1-audit.md:193 | FS129-SR1 |
| FS111-M4-CUT | R | J9 — FS-127: LAT | near miss | plans/FS129-OR1-audit.md:411 | FS129-OR1 |
| FS111-M4-MOVE | R | J11 — FS-120: the pinch at a junction | near miss | plans/FS129-OR1-audit.md:494 | FS129-OR1 |
| FS111-REG-JP-C5 | R | J10 — The map step at five: no open stub carries it | reduces | plans/FS129-OR1-audit.md:428 | FS129-OR1 |
| FS111-V0-CLOSE | R | FS106-DIAM | merge | plans/FS129-SR2-audit.md:76 | FS129-SR2 |
| FS111-V0-CLOSE | R | FS129-SR2-CLOSURE | merge | plans/FS129-SR2-audit.md:89 | FS129-SR2 |
| FS111-V0-ID1 | R | FS129-SR2-HULLSET | composition | plans/FS129-SR2-audit.md:160 | FS129-SR2 |
| FS111-V0-RESCALE | R | FS129-OR1-TOP5 | composition | plans/FS129-OR1-audit.md:444 | FS129-OR1 |
| FS111-V0-WIGGLE | R | J14 — FS-122: B-RR, a cone-scale bound independent of the holes | near miss | plans/FS129-OR1-audit.md:519 | FS129-OR1 |
| FS111-VM2-EQ5 | R | J10 — The map step at five: no open stub carries it | reduces | plans/FS129-OR1-audit.md:435 | FS129-OR1 |
| FS111-VMW-R7-MAX | R | J4 — FS-128: TOP₆, a smaller form | near miss | plans/FS129-OR1-audit.md:343 | FS129-OR1 |
| FS111-W-HX-PAIRS | R | J14 — FS-122: B-RR, a cone-scale bound independent of the holes | near miss | plans/FS129-OR1-audit.md:518 | FS129-OR1 |
| FS112-A4SIX | R | FS110-A3-HOLE | answered elsewhere | plans/FS129-MR1-audit.md:411 | FS129-MR1 |
| FS112-BEND | R | FS112-N2-BENDS | stronger form held | plans/FS129-SR2-audit.md:114 | FS129-SR2 |
| FS112-BEND | R | FS129-SR1-BENDANY | stronger form held | plans/FS129-SR2-audit.md:114 | FS129-SR2 |
| FS112-DISC | R | J6 — FS-124, case 2: the disk's corner | near miss | plans/FS129-OR1-audit.md:368 | FS129-OR1 |
| FS112-DISC1 | R | FS106-TS-T | stronger form held | plans/FS129-SR2-audit.md:111 | FS129-SR2 |
| FS112-DISC1 | R | FS129-OR1-LOCALDENSE | composition | plans/FS129-OR1-audit.md:600 | FS129-OR1 |
| FS112-DISC1 | R | FS129-SR2-DISC1TS | stronger form held | plans/FS129-SR2-audit.md:111 | FS129-SR2 |
| FS112-L60 | R | FS114-L60-WALK | bears | plans/FS129-SR2-audit.md:121 | FS129-SR2 |
| FS112-N2-BENDS | R | FS129-OR1-BEND3 | composition | plans/FS129-OR1-audit.md:279 | FS129-OR1 |
| FS112-N2-BENDS | R | FS129-OR1-BENDFRAG | composition | plans/FS129-OR1-audit.md:147 | FS129-OR1 |
| FS112-N2-BENDS | R | FS129-SR1-BENDANY | composition | plans/FS129-SR1-audit.md:266 | FS129-SR1 |
| FS112-N2-RAY | R | FS112-N3-PER | shared step (not one statement) | plans/FS129-SR1-audit.md:192 | FS129-SR1 |
| FS112-N2-RAY | R | FS121-D2-PERFIN | shared step (not one statement) | plans/FS129-SR1-audit.md:192 | FS129-SR1 |
| FS112-N2-RAY | R | FS121-D2-SYM | shared step (not one statement) | plans/FS129-SR1-audit.md:192 | FS129-SR1 |
| FS112-N2-RAY | R | FS129-SR1-BENDANY | composition | plans/FS129-SR1-audit.md:266 | FS129-SR1 |
| FS112-N2-RAY | R | J23 — A root: Townsend's simplification (c), in full | shortens | plans/FS129-OR1-audit.md:697 | FS129-OR1 |
| FS112-N2-RAY | R | J8 — FS-126: a curved tangent-type interface, at any number of colours | near miss | plans/FS129-OR1-audit.md:394 | FS129-OR1 |
| FS112-N2-TERM | R | J23 — A root: Townsend's simplification (c), in full | shortens | plans/FS129-OR1-audit.md:697 | FS129-OR1 |
| FS112-N3-BASE | R | FS129-OR1-LOCALDENSE | composition | plans/FS129-OR1-audit.md:600 | FS129-OR1 |
| FS112-N3-CHAINS | R | J8 — FS-126: a curved tangent-type interface, at any number of colours | near miss | plans/FS129-OR1-audit.md:395 | FS129-OR1 |
| FS112-N3-DENSE3 | R | J19 — FS-124 case 8: DISC-F and LOCAL-DENSE | closes | plans/FS129-OR1-audit.md:593 | FS129-OR1 |
| FS112-N3-PER | R | FS112-N2-RAY | shared step (not one statement) | plans/FS129-SR1-audit.md:192 | FS129-SR1 |
| FS112-N3-PER | R | FS121-D2-SYM | merge | plans/FS129-MR1-audit.md:412 | FS129-MR1 |
| FS112-N3-PER | R | FS121-O1-OUT | shared step (not one statement) | plans/FS129-SR1-audit.md:192 | FS129-SR1 |
| FS112-N3-PER | R | J8 — FS-126: a curved tangent-type interface, at any number of colours | near miss | plans/FS129-OR1-audit.md:398 | FS129-OR1 |
| FS112-SIX | R | FS116-N1-TWIST-D | merge | plans/FS129-SR1-audit.md:189 | FS129-SR1 |
| FS112-SIX | R | FS116-N2-FIVERING | merge | plans/FS129-SR1-audit.md:515 | FS129-SR1 |
| FS112-SIX | R | FS116-N2-SIXRING | answered elsewhere | plans/FS129-SR3-audit.md:354 | FS129-SR3 |
| FS112-SIX | R | FS116-V4-DICHOTOMY | answered elsewhere | plans/FS129-SR3-audit.md:354 | FS129-SR3 |
| FS112-SIX | R | FS129-SR1-SIXQ | merge | plans/FS129-SR1-audit.md:189 | FS129-SR1 |
| FS112-SIX | R | FS129-SR1-SIXQ | merge | plans/FS129-SR1-audit.md:515 | FS129-SR1 |
| FS112-U1 | R | FS116-V5-U1 | merge | plans/FS129-SR1-audit.md:516 | FS129-SR1 |
| FS112-U1 | R | FS116-V5-U1 | merge | plans/FS129-SR1-audit.md:524 | FS129-SR1 |
| FS112-Y3-END-AB | R | J8 — FS-126: a curved tangent-type interface, at any number of colours | near miss | plans/FS129-OR1-audit.md:399 | FS129-OR1 |
| FS114-BV-HEX | R | FS110-CUSP-BASE | bears | plans/FS129-SR3-audit.md:356 | FS129-SR3 |
| FS114-CV-EXISTS | R | J19 — FS-124 case 8: DISC-F and LOCAL-DENSE | closes | plans/FS129-OR1-audit.md:596 | FS129-OR1 |
| FS114-CV-EXISTS | R | J19 — FS-124 case 8: DISC-F and LOCAL-DENSE | closes | plans/FS129-OR1-audit.md:598 | FS129-OR1 |
| FS114-K1 | R | FS114-N7-HUB | bears | plans/FS129-SR1-audit.md:517 | FS129-SR1 |
| FS114-K1 | R | FS129-OR1-QFREE | bears | plans/FS129-SR1-audit.md:517 | FS129-SR1 |
| FS114-K1 | R | J17 — FS-124 cases 3, 5 and 6: crossed reciprocity, the recurrence, FS114-K1's (Q) residues | shortens | plans/FS129-OR1-audit.md:570 | FS129-OR1 |
| FS114-N2-AVG | R | J10 — The map step at five: no open stub carries it | reduces | plans/FS129-OR1-audit.md:441 | FS129-OR1 |
| FS114-N2-AVG | R | J23 — A root: Townsend's simplification (c), in full | shortens | plans/FS129-OR1-audit.md:695 | FS129-OR1 |
| FS114-N4-D | R | FS114-Y4-RSTOPALL | merge | plans/FS129-SR2-audit.md:134 | FS129-SR2 |
| FS114-N6-NOQ | R | FS129-OR1-QFREE | merge | plans/FS129-SR2-audit.md:138 | FS129-SR2 |
| FS114-Y-PENT | R | J6 — FS-124, case 2: the disk's corner | near miss | plans/FS129-OR1-audit.md:367 | FS129-OR1 |
| FS114-Y4-RSTOPALL | R | FS114-N4-D | merge | plans/FS129-SR2-audit.md:134 | FS129-SR2 |
| FS114-Y5-PINALL | R | FS129-SR3-E2ONE | composition | plans/FS129-SR3-audit.md:82 | FS129-SR3 |
| FS114-Y6-E2RED | R | FS129-SR3-E2ONE | composition | plans/FS129-SR3-audit.md:82 | FS129-SR3 |
| FS116-C114-LOCAL-F | R | J19 — FS-124 case 8: DISC-F and LOCAL-DENSE | closes | plans/FS129-OR1-audit.md:590 | FS129-OR1 |
| FS116-C114-LOCAL-F | R | J19 — FS-124 case 8: DISC-F and LOCAL-DENSE | closes | plans/FS129-OR1-audit.md:594 | FS129-OR1 |
| FS116-N1-F15TOUCH | R | J3 — FS-125: NO-SAT, through its cases | shortens | plans/FS129-OR1-audit.md:328 | FS129-OR1 |
| FS116-N1-GERM-R | R | FS129-SR2-TOUCHW | composition | plans/FS129-SR2-audit.md:384 | FS129-SR2 |
| FS116-N1-GERM-R | R | FS129-SR3-OUTERADJ | composition | plans/FS129-SR3-audit.md:264 | FS129-SR3 |
| FS116-N1-GERM-S | R | FS116-RING-GERM | merge | plans/FS129-SR2-audit.md:315 | FS129-SR2 |
| FS116-N1-GERM-S | R | FS116-RING-Q-PRIME | merge | plans/FS129-SR2-audit.md:324 | FS129-SR2 |
| FS116-N1-QDISK | R | FS110-A3-HOLE | answered elsewhere | plans/FS129-MR1-audit.md:411 | FS129-MR1 |
| FS116-N1-QFREE4 | R | FS110-A3-HOLE | answered elsewhere | plans/FS129-MR1-audit.md:411 | FS129-MR1 |
| FS116-N1-TOUCH | R | FS129-SR2-TOUCHW | stronger form held | plans/FS129-SR2-audit.md:316 | FS129-SR2 |
| FS116-N1-TOUCH | R | FS129-SR2-TOUCHW | composition | plans/FS129-SR2-audit.md:384 | FS129-SR2 |
| FS116-N1-TWIST-D | R | FS112-SIX | merge | plans/FS129-SR1-audit.md:189 | FS129-SR1 |
| FS116-N1-TWIST-D | R | FS129-SR1-SIXQ | composition | plans/FS129-SR1-audit.md:241 | FS129-SR1 |
| FS116-N1-TWIST-D | R | FS129-SR2-TOUCHW | composition | plans/FS129-SR2-audit.md:384 | FS129-SR2 |
| FS116-N2-FIVERING | R | FS112-SIX | merge | plans/FS129-SR1-audit.md:515 | FS129-SR1 |
| FS116-N2-FIVERING | R | FS129-SR1-SIXQ | merge | plans/FS129-SR1-audit.md:189 | FS129-SR1 |
| FS116-N2-SIXRING | R | FS112-SIX | answered elsewhere | plans/FS129-SR3-audit.md:354 | FS129-SR3 |
| FS116-O1-YESLIM | R | FS106-COMP | merge | plans/FS129-SR2-audit.md:320 | FS129-SR2 |
| FS116-O1-YESLIM | R | FS106-EQ | merge | plans/FS129-SR2-audit.md:320 | FS129-SR2 |
| FS116-O1-YESLIM | R | FS129-SR2-YESLIM-EQ | merge | plans/FS129-SR2-audit.md:320 | FS129-SR2 |
| FS116-RING-GERM | R | FS116-N1-GERM-S | merge | plans/FS129-SR2-audit.md:315 | FS129-SR2 |
| FS116-RING-GERM | R | FS129-MR1-DOUBLETIP | composition | plans/FS129-MR1-audit.md:110 | FS129-MR1 |
| FS116-RING-GERM | R | FS129-SR3-OUTERADJ | composition | plans/FS129-SR3-audit.md:264 | FS129-SR3 |
| FS116-RING-Q-PRIME | R | FS116-N1-GERM-S | merge | plans/FS129-SR2-audit.md:324 | FS129-SR2 |
| FS116-RING-Q-PRIME | R | FS116-RING-Q-PRIME-S | merge | plans/FS129-SR2-audit.md:324 | FS129-SR2 |
| FS116-RING-Q-PRIME-S | R | FS116-RING-Q-PRIME | merge | plans/FS129-SR2-audit.md:324 | FS129-SR2 |
| FS116-S1-KAPPA | R | FS116-S1-QF | answered elsewhere | plans/FS129-SR3-audit.md:358 | FS129-SR3 |
| FS116-S1-KAPPA | R | FS129-OR1-QFREE | answered elsewhere | plans/FS129-SR3-audit.md:358 | FS129-SR3 |
| FS116-S1-KAPPA | R | FS129-SR3-QFREE-NS | answered elsewhere | plans/FS129-SR3-audit.md:358 | FS129-SR3 |
| FS116-S1-QF | R | FS116-S1-KAPPA | answered elsewhere | plans/FS129-SR3-audit.md:358 | FS129-SR3 |
| FS116-S1-QF | R | FS129-OR1-QFREE | stronger form held | plans/FS129-SR2-audit.md:333 | FS129-SR2 |
| FS116-S1-QF | R | FS129-SR2-QFCASE | stronger form held | plans/FS129-SR2-audit.md:333 | FS129-SR2 |
| FS116-S1-QF | R | J3 — FS-125: NO-SAT, through its cases | shortens | plans/FS129-OR1-audit.md:327 | FS129-OR1 |
| FS116-SAT-QFREE | R | J3 — FS-125: NO-SAT, through its cases | shortens | plans/FS129-OR1-audit.md:324 | FS129-OR1 |
| FS116-SAT-QFREE | R | J3 — FS-125: NO-SAT, through its cases | shortens | plans/FS129-OR1-audit.md:326 | FS129-OR1 |
| FS116-SAT-QFREE | R | J3 — FS-125: NO-SAT, through its cases | shortens | plans/FS129-OR1-audit.md:328 | FS129-OR1 |
| FS116-SEMI-PAR3 | R | J2 — FS-124, case 1: SEMI-PAR3 | shortens | plans/FS129-OR1-audit.md:276 | FS129-OR1 |
| FS116-V4-DICHOTOMY | R | FS106-DIAM | bears | plans/FS129-SR2-audit.md:330 | FS129-SR2 |
| FS116-V4-DICHOTOMY | R | FS111-M-HULL2 | bears | plans/FS129-SR2-audit.md:330 | FS129-SR2 |
| FS116-V4-DICHOTOMY | R | FS112-SIX | answered elsewhere | plans/FS129-SR3-audit.md:354 | FS129-SR3 |
| FS116-V4-DICHOTOMY | R | FS129-MR1-DOUBLETIP | composition | plans/FS129-MR1-audit.md:110 | FS129-MR1 |
| FS116-V4-DICHOTOMY | R | FS129-OR1-BEND3 | composition | plans/FS129-OR1-audit.md:279 | FS129-OR1 |
| FS116-V4-DICHOTOMY | R | FS129-OR1-BENDFRAG | composition | plans/FS129-OR1-audit.md:147 | FS129-OR1 |
| FS116-V4-DICHOTOMY | R | FS129-OR1-DISCF-NS | composition | plans/FS129-OR1-audit.md:633 | FS129-OR1 |
| FS116-V4-DICHOTOMY | R | FS129-OR1-WHOLE | composition | plans/FS129-OR1-audit.md:93 | FS129-OR1 |
| FS116-V4-DICHOTOMY | R | FS129-SR1-BENDANY | composition | plans/FS129-SR1-audit.md:266 | FS129-SR1 |
| FS116-V4-DICHOTOMY | R | FS129-SR3-OUTERADJ | composition | plans/FS129-SR3-audit.md:264 | FS129-SR3 |
| FS116-V4-TWIST | R | FS129-MR1-DOUBLETIP | composition | plans/FS129-MR1-audit.md:110 | FS129-MR1 |
| FS116-V5-LENS | R | FS116-Y4-EMPTY | bears | plans/FS129-SR1-audit.md:523 | FS129-SR1 |
| FS116-V5-NE1 | R | FS106-DIAM | merge | plans/FS129-SR2-audit.md:76 | FS129-SR2 |
| FS116-V5-NE1 | R | FS106-DIAM | merge | plans/FS129-SR2-audit.md:334 | FS129-SR2 |
| FS116-V5-NE1 | R | FS129-OR1-WHOLE | composition | plans/FS129-OR1-audit.md:93 | FS129-OR1 |
| FS116-V5-NE1 | R | FS129-SR2-CLOSURE | merge | plans/FS129-SR2-audit.md:334 | FS129-SR2 |
| FS116-V5-RING | R | FS116-N1-TWIST-D | bears | plans/FS129-SR2-audit.md:336 | FS129-SR2 |
| FS116-V5-U1 | R | FS112-U1 | merge | plans/FS129-SR1-audit.md:516 | FS129-SR1 |
| FS116-V5-U1 | R | FS112-U1 | merge | plans/FS129-SR1-audit.md:524 | FS129-SR1 |
| FS116-V5-U1 | R | FS129-OR1-BEND3 | composition | plans/FS129-OR1-audit.md:279 | FS129-OR1 |
| FS116-V5-U1 | R | FS129-OR1-BENDFRAG | merge | plans/FS129-SR1-audit.md:195 | FS129-SR1 |
| FS116-V5-U1 | R | FS129-SR1-BENDLE3 | composition | plans/FS129-SR1-audit.md:289 | FS129-SR1 |
| FS116-V6-ADJ | R | FS129-MR1-DOUBLETIP | merge | plans/FS129-SR1-audit.md:188 | FS129-SR1 |
| FS116-V6-ADJ | R | FS129-SR1-TWOCIRC | merge | plans/FS129-SR1-audit.md:188 | FS129-SR1 |
| FS116-V6-ANTI | R | FS129-SR3-EMPTY-NS | composition | plans/FS129-SR3-audit.md:184 | FS129-SR3 |
| FS116-V6-COUNT | R | FS129-SR3-EMPTY-NS | composition | plans/FS129-SR3-audit.md:184 | FS129-SR3 |
| FS116-V6-HUBS | R | FS129-SR3-EMPTY-NS | composition | plans/FS129-SR3-audit.md:184 | FS129-SR3 |
| FS116-V6-HUG | R | FS129-MR1-DOUBLETIP | merge | plans/FS129-MR1-audit.md:402 | FS129-MR1 |
| FS116-V6-HUG | R | FS129-MR1-DOUBLETIP | merge | plans/FS129-SR1-audit.md:188 | FS129-SR1 |
| FS116-V6-HUG | R | FS129-MR1-DOUBLETIP | merge | plans/FS129-SR1-audit.md:525 | FS129-SR1 |
| FS116-V6-HUG | R | FS129-SR1-TWOCIRC | merge | plans/FS129-SR1-audit.md:188 | FS129-SR1 |
| FS116-V6-HUG | R | FS129-SR1-TWOCIRC | merge | plans/FS129-SR1-audit.md:525 | FS129-SR1 |
| FS116-V6-HUG | R | FS129-SR3-EMPTY-NS | composition | plans/FS129-SR3-audit.md:184 | FS129-SR3 |
| FS116-V6-HUG | R | J16 — FS-122: a robust count, and whether the kills survive a band | near miss | plans/FS129-OR1-audit.md:561 | FS129-OR1 |
| FS116-V6-HUG | R | J5 — FS-124, case 4: the five- and six-colour vertices | near miss | plans/FS129-OR1-audit.md:356 | FS129-OR1 |
| FS116-Y2-SIXFRAG | R | FS110-A3-HOLE | answered elsewhere | plans/FS129-MR1-audit.md:411 | FS129-MR1 |
| FS116-Y3-SIX | R | J7 — FS-123 question 3 with FS-124 case 7: the Siamese and non-simple classes | reduces | plans/FS129-OR1-audit.md:381 | FS129-OR1 |
| FS116-Y4-EMPTY | R | FS129-OR1-QFREE | composition | plans/FS129-OR1-audit.md:220 | FS129-OR1 |
| FS116-Y4-EMPTY | R | FS129-SR3-EMPTY-NS | composition | plans/FS129-SR3-audit.md:184 | FS129-SR3 |
| FS116-Y4-FLANK | R | FS129-MR1-DOUBLETIP | merge | plans/FS129-SR1-audit.md:188 | FS129-SR1 |
| FS116-Y4-FLANK | R | FS129-MR1-DOUBLETIP | composition | plans/FS129-MR1-audit.md:110 | FS129-MR1 |
| FS116-Y4-FLANK | R | FS129-SR1-TWOCIRC | merge | plans/FS129-SR1-audit.md:188 | FS129-SR1 |
| FS116-Y4-FLANK | R | J7 — FS-123 question 3 with FS-124 case 7: the Siamese and non-simple classes | reduces | plans/FS129-OR1-audit.md:382 | FS129-OR1 |
| FS121-C1-FLAT | R | J20 — FS-128: C121-NOPAR-C5 | near miss | plans/FS129-OR1-audit.md:661 | FS129-OR1 |
| FS121-C1-GMAP | R | J10 — The map step at five: no open stub carries it | reduces | plans/FS129-OR1-audit.md:437 | FS129-OR1 |
| FS121-D1-VT | R | FS121-V2-VT-W | bears | plans/FS129-SR3-audit.md:359 | FS129-SR3 |
| FS121-D2-PERFIN | R | FS112-N2-RAY | shared step (not one statement) | plans/FS129-SR1-audit.md:192 | FS129-SR1 |
| FS121-D2-PERFIN | R | FS121-O1-OUT | shared step (not one statement) | plans/FS129-SR1-audit.md:192 | FS129-SR1 |
| FS121-D2-PERFIN | R | J8 — FS-126: a curved tangent-type interface, at any number of colours | near miss | plans/FS129-OR1-audit.md:398 | FS129-OR1 |
| FS121-D2-SYM | R | FS112-N2-RAY | shared step (not one statement) | plans/FS129-SR1-audit.md:192 | FS129-SR1 |
| FS121-D2-SYM | R | FS112-N3-PER | merge | plans/FS129-MR1-audit.md:412 | FS129-MR1 |
| FS121-D3-EQ | R | J10 — The map step at five: no open stub carries it | reduces | plans/FS129-OR1-audit.md:434 | FS129-OR1 |
| FS121-D3-GRUNDY | R | J10 — The map step at five: no open stub carries it | reduces | plans/FS129-OR1-audit.md:438 | FS129-OR1 |
| FS121-D3-SWAP1D | R | J4 — FS-128: TOP₆, a smaller form | near miss | plans/FS129-OR1-audit.md:341 | FS129-OR1 |
| FS121-D4-FACE | R | FS121-V5-FACE-SHARP | merge | plans/FS129-MR1-audit.md:413 | FS129-MR1 |
| FS121-D4-FACE | R | FS121-V5-FACE-SHARP | shared step (not one statement) | plans/FS129-SR1-audit.md:193 | FS129-SR1 |
| FS121-D4-FACE | R | FS121-V5-FACE-SHARP | stronger form held | plans/FS129-SR1-audit.md:531 | FS129-SR1 |
| FS121-D4-FACE | R | J9 — FS-127: LAT | near miss | plans/FS129-OR1-audit.md:412 | FS129-OR1 |
| FS121-DB1-L3 | R | FS111-W-NOREP | stronger form held | plans/FS129-SR2-audit.md:345 | FS129-SR2 |
| FS121-NOPAR-C5 | R | J20 — FS-128: C121-NOPAR-C5 | near miss | plans/FS129-OR1-audit.md:660 | FS129-OR1 |
| FS121-O1-ABOVE7 | R | J4 — FS-128: TOP₆, a smaller form | near miss | plans/FS129-OR1-audit.md:343 | FS129-OR1 |
| FS121-O1-OUT | R | FS112-N3-PER | shared step (not one statement) | plans/FS129-SR1-audit.md:192 | FS129-SR1 |
| FS121-O1-OUT | R | FS121-D2-PERFIN | shared step (not one statement) | plans/FS129-SR1-audit.md:192 | FS129-SR1 |
| FS121-O1-OUT | R | J8 — FS-126: a curved tangent-type interface, at any number of colours | near miss | plans/FS129-OR1-audit.md:396 | FS129-OR1 |
| FS121-REGJ | R | J10 — The map step at five: no open stub carries it | reduces | plans/FS129-OR1-audit.md:431 | FS129-OR1 |
| FS121-SAT6 | R | J10 — The map step at five: no open stub carries it | reduces | plans/FS129-OR1-audit.md:429 | FS129-OR1 |
| FS121-V5-FACE-SHARP | R | FS111-M4-CUT | merge | plans/FS129-MR1-audit.md:413 | FS129-MR1 |
| FS121-V5-FACE-SHARP | R | FS111-M4-CUT | shared step (not one statement) | plans/FS129-SR1-audit.md:193 | FS129-SR1 |
| FS121-V5-FACE-SHARP | R | FS121-D4-FACE | merge | plans/FS129-MR1-audit.md:413 | FS129-MR1 |
| FS121-V5-FACE-SHARP | R | FS121-D4-FACE | shared step (not one statement) | plans/FS129-SR1-audit.md:193 | FS129-SR1 |
| FS121-V5-FACE-SHARP | R | J9 — FS-127: LAT | near miss | plans/FS129-OR1-audit.md:412 | FS129-OR1 |
| FS70-T9 | A | FS129-MA2-FALC-HOSTS | composition | plans/FS129-MA2-audit.md:327 | FS129-MA2 |
| FS81-T24 | A | FS129-MA2-FALC-HOSTS | composition | plans/FS129-MA2-audit.md:327 | FS129-MA2 |
| TC1-SQRT3-DYADIC | A | FS129-SA1-SQRT3-LOCAL | stronger form held | plans/FS129-SA1-audit.md:678 | FS129-SA1 |

## Ledger rows (6 rows, 23 sites)

A ledger row is not a record of `theorems.jsonl`, so its sites are listed here only: each row an FS-129 entry names in its `uses only:` line, or a table of misses names in its mechanism cell.

| row | site | kind | address | by |
|---|---|---|---|---|
| 1 | FS106-BIKE | near miss | plans/FS129-MA1-audit.md:399 | FS129-MA1 |
| 66 | FS129-MA1-FALC-T | composition | plans/FS129-MA1-audit.md:183 | FS129-MA1 |
| 66 | FS129-MA1-NOAFF5 | composition | plans/FS129-MA1-audit.md:138 | FS129-MA1 |
| 66 | FS129-MA2-FALC-GAP4 | composition | plans/FS129-MA2-audit.md:124 | FS129-MA2 |
| 66 | FS129-OA1-FALC-11 | composition | plans/FS129-OA1-audit.md:238 | FS129-OA1 |
| 66 | FS129-OA1-NOLIN5 | composition | plans/FS129-OA1-audit.md:143 | FS129-OA1 |
| 66 | FS129-SA1-FALC-FAN | composition | plans/FS129-SA1-audit.md:245 | FS129-SA1 |
| 66 | FS129-SA1-NOAFF-K | composition | plans/FS129-SA1-audit.md:165 | FS129-SA1 |
| 66 | FS129-OA1-NOLIN5 | composition | plans/FS129-MA1-audit.md:396 | FS129-MA1 |
| 66 | FS129-OA1-FALC-11 | composition | plans/FS129-MA1-audit.md:396 | FS129-MA1 |
| 66 | FS129-MA1-NOAFF5 | composition | plans/FS129-MA1-audit.md:396 | FS129-MA1 |
| 66 | FS129-MA1-FALC-T | composition | plans/FS129-MA1-audit.md:396 | FS129-MA1 |
| 66 | FS129-MA1-FALC-19 | composition | plans/FS129-MA1-audit.md:396 | FS129-MA1 |
| 66 | ASTRA-2026-09-14-T10 | bears | plans/FS129-MA1-audit.md:400 | FS129-MA1 |
| 78 | FS129-MA2-FALC-HOSTS | composition | plans/FS129-MA2-audit.md:144 | FS129-MA2 |
| 78 | FS129-MA2-FALC-DICHO | composition | plans/FS129-MA2-audit.md:328 | FS129-MA2 |
| 78 | FS129-MA2-FALC-HOSTS | composition | plans/FS129-MA2-audit.md:328 | FS129-MA2 |
| 88 | FS129-MA2-FALC-HOSTS | composition | plans/FS129-MA2-audit.md:144 | FS129-MA2 |
| 88 | FS129-MA2-FALC-DICHO | composition | plans/FS129-MA2-audit.md:328 | FS129-MA2 |
| 88 | FS129-MA2-FALC-HOSTS | composition | plans/FS129-MA2-audit.md:328 | FS129-MA2 |
| 104 | FS129-SA1-FALC-RES | composition | plans/FS129-SA1-audit.md:293 | FS129-SA1 |
| 104 | FS129-SA1-NOAFF-FIELDS | composition | plans/FS129-SA1-audit.md:223 | FS129-SA1 |
| 111 | FS129-OA1-NOPERLAW | composition | plans/FS129-MA1-audit.md:397 | FS129-MA1 |
