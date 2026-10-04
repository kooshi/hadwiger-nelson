<!-- what FS129-Z2 changed in the index, edge by edge | command: python3 tools/fs129_z2_index.py | FS129-Z2, from data/fs129/index/edges.csv and theorems.jsonl as FS129-IX1 wrote them -->

# Index corrections (FS129-Z2)

Summary: z2 index: edges 1330 -> 1315 (dropped 44: false 35, reversed 9; kept and marked route 9, real 7; added 29: reversed-fix 2, range 13, prefix 14); cycles 30; Lean order 178 (166 on first routes); top root FS112-U1 depth 10; FS111-C-HULL-SO dependents 0; FS121-D4-HOLE dependents 0

## Dropped (44)

| from | to | source | class | sorted by |
|---|---|---|---|---|
| FS106-EQ | FS106-SUP | rests | false | SR2 |
| FS111-C-HULL-SO | FS111-C-HULL | rests | false | SR1 |
| FS111-C1-PW | FS111-C1-UNIF | rests | false | SR2 |
| FS111-C1-UNIF | FS111-C1-PW | rests | false | SR2 |
| FS111-M-COVER-SC | FS111-M2-HULLC | rests | false | SR2 |
| FS111-M2-DISC7 | FS111-M2-HULLC | rests | false | SR2 |
| FS111-M2-DISCK7-AS-PLACED | FS111-M2-DISCK7 | rests | false | SR1 |
| FS111-M3-FIXCONV | FS111-M2-FIX | rests | false | SR2 |
| FS112-BUDGET2 | FS112-NB4P | rests | false | SR2 |
| FS112-Y3-R1 | FS112-N3-CHAINS | rests | false | SR1 |
| FS114-CV-EXISTS | FS112-L60 | rests | false | SR2 |
| FS114-CV-EXISTS | FS112-N3-DENSE3 | rests | reversed | SR2 |
| FS114-CV-EXISTS | FS114-L60-WALK | rests | reversed | SR2 |
| FS114-K1 | FS114-N7-HUB | rests | false | SR1 |
| FS114-N6-NOQ | FS114-Y5-PINALL | rests | false | SR2 |
| FS114-ROUTE-T | FS114-N2-LEMMAS | rests | reversed | SR1 |
| FS114-Y3-RSTOP | FS114-N4-D | rests | false | SR2 |
| FS114-Y4-RSTOPALL | FS114-N4-D | rests | false | SR2 |
| FS114-Y4-RSTOPALL | FS114-Y3-RSTOP | rests | false | SR2 |
| FS114-Y5-PINALL | FS114-N6-NOQ | rests | false | SR2 |
| FS121-C1-GMAP | FS121-D3-GRUNDY | rests | false | SR1 |
| FS121-D1-PENCILWIN | FS121-O1-OUT | rests | false | SR1 |
| FS121-D1-R2CORNER | FS121-D1-R2SMOOTH | rests | reversed | SR2 |
| FS121-D1-R2CORNER | FS121-D1-RUNG2 | rests | reversed | SR2 |
| FS121-D2-PERFIN | FS121-D2-SYM | rests | reversed | SR1 |
| FS121-D4-HOLE | FS111-M-PINCH | rests | false | SR1 |
| FS121-DB1-L4 | FS121-DB1-L1 | rests | reversed | SR2 |
| FS121-DB1-L6 | FS111-M2-INTRAD | rests | false | SR1 |
| FS121-DB1-L7 | FS121-O1-OUT | rests | false | SR1 |
| FS121-V2-EROSION-DIAM | FS121-D1-EROSION | rests | false | SR1 |
| FS121-V2-VT-W | FS121-D1-VT | rests | false | SR1 |
| FS121-V3-CPI | FS121-V2-SECTOR | rests | false | SR1 |
| FS121-V5-RAY | FS121-V5-LOC | rests | reversed | SR2 |
| FS56-T6 | FS56-T2 | rests | reversed | SA1 |
| FS79-T31 | FS79-T40 | rests | false | SA1 |
| FS79-T41 | FS79-T38 | rests | false | SA1 |
| FS85-A3 | FS85-dB2 | rests | false | SA1 |
| FS91-J01-3 | FS91-J01-2 | rests | false | SA1 |
| FS91-J03a-6 | FS91-J01-7 | rests | false | SA1 |
| FS91-J03a-9 | FS89-CL2 | rests | false | SA1 |
| FS91-J07-14 | FS89-CL2 | rests | false | SA1 |
| M3-J21-NG3 | M3-J21-MX | rests | false | SA1 |
| MASCOT-T3 | MASCOT-T4 | rests | false | SA1 |
| Q8-T1 | M51-T1 | rests | false | SA1 |

## Kept and marked (16)

| from | to | source | class |
|---|---|---|---|
| FS112-C-ENDS | FS114-CV-EXISTS | uses | route |
| FS114-CV-HD | FS114-CV-EXISTS | uses | route |
| FS114-N5-GRING | FS114-Y4-RSTOPALL | rests | route |
| FS114-Y3-RSTOP | FS114-Y4-RSTOPALL | rests | real |
| FS116-O1-YESLIM | FS116-C114-LOCAL-F | rests | real |
| FS116-RING-Q | FS116-C114-LOCAL-F | rests | real |
| FS116-RING-TRANSFER-QC | FS116-C114-LOCAL-F | rests | real |
| FS116-S1-QF | FS116-C114-LOCAL-F | rests | real |
| FS116-S1-QF | FS116-SAT-STRIP | rests | real |
| FS116-SEMI-PAR3 | FS116-C114-LOCAL-F | rests | real |
| FS116-V4-MEET | FS116-S1-KAPPA | rests | route |
| FS116-V4-OUTER | FS116-S1-KAPPA | rests | route |
| FS116-V4-PARTNER | FS116-S1-KAPPA | rests | route |
| FS116-V4-TWIST | FS116-S1-KAPPA | rests | route |
| FS116-V5-DICHO | FS116-N3-SEMI | rests | route |
| FS116-V5-LENS | FS116-Y3-SIX | rests | route |

## Added (29)

| from | to | class | from the text |
|---|---|---|---|
| ASTRA-2026-09-14-T5 | ASTRA-2026-09-14-T8 | range | `T7–T9` in rests |
| FS106-TS-C | FS114-L60-LE | prefix | `TS-C` in uses only |
| FS107-W-EQ-K | FS111-C1-PW | prefix | `W-EQ-K` in uses only |
| FS107-W-EQ-K | FS111-V0-CLEAN | prefix | `W-EQ-K` in uses only |
| FS107-W-EQ-K | FS114-N114-COMPACT | prefix | `W-EQ-K` in uses only |
| FS110-N4-FIN | FS114-CV-EXISTS | prefix | `N4-FIN` in uses only |
| FS110-N4-SHADOW | FS114-CV-EXISTS | prefix | `N4-SHADOW` in uses only |
| FS110-W-MERGE | FS114-CV-HD | prefix | `W-MERGE` in uses only |
| FS111-C-HULL | FS121-D4-HOLE | prefix | `C-HULL` in uses only |
| FS111-C-HULL | FS121-DB1-L3 | prefix | `C-HULL` in uses only |
| FS111-C-HULL | FS121-O1-ENDS | prefix | `C-HULL` in uses only |
| FS111-M-PINCH | FS116-Y1-STRIPCEIL | prefix | `M-PINCH` in uses only |
| FS111-M-PINCH | FS121-D1-FIRSTORDER | prefix | `M-PINCH` in uses only |
| FS112-N3-NOBOTH | FS114-L60-WALK | prefix | `N3-NOBOTH` in uses only |
| FS114-N2-LEMMAS | FS114-ROUTE-T | reversed-fix | the true direction of FS114-ROUTE-T -> FS114-N2-LEMMAS |
| FS116-N1-GERM-S | FS116-N1-AXIS | prefix | `GERM-S` in uses only |
| FS56-T2 | FS56-T6 | reversed-fix | the true direction of FS56-T6 -> FS56-T2 |
| FS73-T21 | FS73-T23 | range | `T22–T25` in rests |
| FS73-T21 | FS73-T24 | range | `T22–T25` in rests |
| FS73-T28 | FS73-T26 | range | `T25–T27` in rests |
| FS79-T8 | FS79-T39 | range | `T38–T40` in rests |
| FS81-T3 | FS81-T5 | range | `T4–T8` in rests |
| FS81-T3 | FS81-T6 | range | `T4–T8` in rests |
| FS81-T3 | FS81-T7 | range | `T4–T8` in rests |
| FS85-C7 | FS85-C9 | range | `C8–C10` in rests |
| FS89-CL2 | FS89-CL4 | range | `CL3–CL5` in rests |
| FS89-S0A-2 | FS89-CL3 | range | `FS89-CL2–CL5` in rests |
| FS89-S0A-2 | FS89-CL4 | range | `FS89-CL2–CL5` in rests |
| M63H2-T1 | M63H2-T3 | range | `M63H2-T2–T4` in rests |

## Suffix candidates left unresolved (183) — the strict rule did not apply; each is a reader's call

- `B-NONABS` in rests on it of FS111-W-B-NONABS (plans/FS111-derivation.md:772) — candidates: FS111-W-B-NONABS
- `C114-LOCAL-F` in rests on it of FS114-CV-EXISTS (plans/FS114-derivation.md:26) — candidates: FS116-C114-LOCAL-F
- `C114-LOCAL-F` in rests on it of FS114-N114-COMPACT (plans/FS114-derivation.md:300) — candidates: FS116-C114-LOCAL-F
- `C114-LOCAL-F` in rests on it of FS114-N2-LEMMAS (plans/FS114-derivation.md:351) — candidates: FS116-C114-LOCAL-F
- `C114-LOCAL-F` in rests on it of FS114-N7-3T (plans/FS114-derivation.md:717) — candidates: FS116-C114-LOCAL-F
- `C114-LOCAL-F` in rests on it of FS114-Y-DIAL (plans/FS114-derivation.md:824) — candidates: FS116-C114-LOCAL-F
- `C114-LOCAL-F` in rests on it of FS114-Y4-RSTOPALL (plans/FS114-derivation.md:577) — candidates: FS116-C114-LOCAL-F
- `HX-STALL` in rests on it of FS111-W-HX-PAIRS (plans/FS111-derivation.md:782) — candidates: FS107-HX-STALL
- `K-C6` in rests on it of FS111-W-HX-PAIRS (plans/FS111-derivation.md:782) — candidates: FS107-K-C6
- `N2-ROT` in rests on it of FS112-N3-COR3 (plans/FS112-derivation.md:156) — candidates: FS110-N2-ROT
- `N3-PAIR` in uses only of FS114-L60-WALK (plans/FS114-derivation.md:943) — candidates: FS116-N3-PAIR
- `P-R1` in rests on it of FS73-T9 (plans/FS73-derivation.md:100) — candidates: FS89-P-R1
- `REDUCE-C` in rests on it of FS111-M2-REDUCE-C (plans/FS111-derivation.md:973) — candidates: FS111-M2-REDUCE-C
- `REDUCE-C` in rests on it of FS111-VM2-EQ5 (plans/FS111-derivation.md:990) — candidates: FS111-M2-REDUCE-C
- `S0B-L4` in rests on it of FS91-J13-T5 (plans/FS91-derivation.md:577) — candidates: FS89-S0B-L4
- `W-EQ-K` in rests on it of FS110-CLOSURE (plans/FS110-derivation.md:28) — candidates: FS107-W-EQ-K
- `W-TAN` in rests on it of FS110-CUSP-K (plans/FS110-derivation.md:193) — candidates: FS107-W-TAN
- `A2` in rests on it of FS106-STAB (plans/FS106-derivation.md:235) — candidates: FS85-A2, FS86-A2
- `A2` in rests on it of FS107-HX-STALL (plans/FS107-derivation.md:108) — candidates: FS85-A2, FS86-A2
- `A2` in rests on it of FS107-K-C6 (plans/FS107-derivation.md:124) — candidates: FS85-A2, FS86-A2
- `A2` in rests on it of FS107-R-CP (plans/FS107-derivation.md:32) — candidates: FS85-A2, FS86-A2
- `A2` in rests on it of FS107-W-POLY (plans/FS107-derivation.md:90) — candidates: FS85-A2, FS86-A2
- `A3` in rests on it of M40-T1 (plans/M40-derivation.md:11) — candidates: FS85-A3, FS86-A3
- `AK1` in rests on it of M3-J18-F2 (plans/M3-derivation.md:53) — candidates: M3-J18-AK1
- `AK1` in rests on it of M3-J18-K0loc (plans/M3-derivation.md:82) — candidates: M3-J18-AK1
- `B1` in rests on it of FS89-S1VB-9 (plans/FS89-derivation.md:244) — candidates: FS89-PA-B1, FS91-J12-B1
- `B3` in rests on it of FS89-S1VB-6 (plans/FS89-derivation.md:237) — candidates: FS100-B3
- `B5` in rests on it of M55-T4 (plans/M55-derivation.md:74) — candidates: FS91-J12-B5
- `C1` in rests on it of FS89-S0A-12 (plans/FS89-derivation.md:99) — candidates: FS86-Cx-C1, FS89-D1-C1, FS89-S0B-C1, FS91-J02-C1, FS91-J12-C1
- `C1` in rests on it of M36-T1 (plans/M36-derivation.md:8) — candidates: FS86-Cx-C1, FS89-D1-C1, FS89-S0B-C1, FS91-J02-C1, FS91-J12-C1
- `C10` in rests on it of FS86-Cx-C9 (plans/FS86-derivation.md:264) — candidates: FS85-C10
- `C11` in rests on it of FS86-dB-S (plans/FS86-derivation.md:213) — candidates: FS111-M-C11, FS85-C11, FS86-Cx-C11
- `C12` in rests on it of FS85-dB8 (plans/FS85-derivation.md:142) — candidates: FS86-Cx-C12
- `C12` in rests on it of FS86-Cx-C12p1 (plans/FS86-derivation.md:362) — candidates: FS86-Cx-C12
- `C13` in rests on it of FS86-Cx-C12 (plans/FS86-derivation.md:367) — candidates: FS85-C13, FS86-Cx-C13
- `C13` in rests on it of FS86-Cx-C13p0 (plans/FS86-derivation.md:373) — candidates: FS85-C13, FS86-Cx-C13
- `C14` in rests on it of FS86-Cx-C12 (plans/FS86-derivation.md:367) — candidates: FS85-C14, FS86-Cx-C14
- `C14` in rests on it of FS86-Cx-C14K (plans/FS86-derivation.md:412) — candidates: FS85-C14, FS86-Cx-C14
- `C14` in rests on it of FS86-Cx-C9 (plans/FS86-derivation.md:264) — candidates: FS85-C14, FS86-Cx-C14
- `C14` in rests on it of FS86-VC-C2 (plans/FS86-derivation.md:401) — candidates: FS85-C14, FS86-Cx-C14
- `C14` in rests on it of FS86-VC-C3 (plans/FS86-derivation.md:404) — candidates: FS85-C14, FS86-Cx-C14
- `C2` in rests on it of FS86-Cx-C1 (plans/FS86-derivation.md:341) — candidates: FS106-TS-C2, FS110-A6-C2, FS86-Cx-C2, FS86-VC-C2, FS89-D1-C2, FS89-D5-C2 …
- `C2` in rests on it of FS89-S0A-7 (plans/FS89-derivation.md:73) — candidates: FS106-TS-C2, FS110-A6-C2, FS86-Cx-C2, FS86-VC-C2, FS89-D1-C2, FS89-D5-C2 …
- `C3` in rests on it of FS73-T24 (plans/FS73-derivation.md:225) — candidates: FS86-VC-C3, FS91-J12-C3
- `C3` in rests on it of J04-H1 (plans/M2-derivation.md:206) — candidates: FS86-VC-C3, FS91-J12-C3
- `C3` in rests on it of J17-T5 (plans/M2-derivation.md:255) — candidates: FS86-VC-C3, FS91-J12-C3
- `C7` in rests on it of FS86-Cx-C6 (plans/FS86-derivation.md:350) — candidates: FS85-C7, FS86-Cx-C7
- `C7` in rests on it of FS86-V3 (plans/FS86-derivation.md:92) — candidates: FS85-C7, FS86-Cx-C7
- `C7` in rests on it of FS86-VK (plans/FS86-derivation.md:111) — candidates: FS85-C7, FS86-Cx-C7
- `D1` in uses only of FS121-D1-VT (plans/FS121-derivation.md:243) — candidates: FS100-D1, FS105-W-D1, FS38-D1, M3-J21-D1
- `D1` in rests on it of FS121-V2-SECTOR (plans/FS121-derivation.md:450) — candidates: FS100-D1, FS105-W-D1, FS38-D1, M3-J21-D1
- `D1` in rests on it of FS81-T22 (plans/FS81-derivation.md:230) — candidates: FS100-D1, FS105-W-D1, FS38-D1, M3-J21-D1
- `D1` in rests on it of FS85-V2-T1 (plans/FS85-derivation.md:232) — candidates: FS100-D1, FS105-W-D1, FS38-D1, M3-J21-D1
- `D1` in rests on it of M48-T1 (plans/M48-derivation.md:12) — candidates: FS100-D1, FS105-W-D1, FS38-D1, M3-J21-D1
- `D1` in rests on it of M53-T1 (plans/M53-derivation.md:45) — candidates: FS100-D1, FS105-W-D1, FS38-D1, M3-J21-D1
- `D1` in rests on it of M56-T2 (plans/M56-derivation.md:34) — candidates: FS100-D1, FS105-W-D1, FS38-D1, M3-J21-D1
- `D2` in rests on it of ASTRA-2026-09-14-T4 (plans/ASTRA-2026-09-14-derivation.md:34) — candidates: FS105-W-D2, FS110-Y4-D2
- `D2` in rests on it of ASTRA-2026-09-14-T6 (plans/ASTRA-2026-09-14-derivation.md:40) — candidates: FS105-W-D2, FS110-Y4-D2
- `D2` in rests on it of FS110-CE5 (plans/FS110-derivation.md:148) — candidates: FS105-W-D2, FS110-Y4-D2
- `D2` in uses only of FS121-D2-SYM (plans/FS121-derivation.md:656) — candidates: FS105-W-D2, FS110-Y4-D2
- `D2` in rests on it of FS81-T23 (plans/FS81-derivation.md:237) — candidates: FS105-W-D2, FS110-Y4-D2
- `D2` in rests on it of M3-J21-NG1 (plans/M3-derivation.md:329) — candidates: FS105-W-D2, FS110-Y4-D2
- `D2` in rests on it of M43-T1 (plans/M43-derivation.md:10) — candidates: FS105-W-D2, FS110-Y4-D2
- `D2` in rests on it of M48-T1 (plans/M48-derivation.md:12) — candidates: FS105-W-D2, FS110-Y4-D2
- `D2` in rests on it of M55-T1 (plans/M55-derivation.md:10) — candidates: FS105-W-D2, FS110-Y4-D2
- `D2` in rests on it of M56-T1 (plans/M56-derivation.md:16) — candidates: FS105-W-D2, FS110-Y4-D2
- `D2` in rests on it of M56-T5 (plans/M56-derivation.md:76) — candidates: FS105-W-D2, FS110-Y4-D2
- `D3` in rests on it of ASTRA-2026-09-14-T9 (plans/ASTRA-2026-09-14-derivation.md:51) — candidates: FS111-M3-D3, FS38-D3, M3-J21-D3
- `D3` in rests on it of FS111-C1-FALS (plans/FS111-derivation.md:127) — candidates: FS111-M3-D3, FS38-D3, M3-J21-D3
- `D3` in rests on it of FS111-W-B-NONABS (plans/FS111-derivation.md:772) — candidates: FS111-M3-D3, FS38-D3, M3-J21-D3
- `D3` in uses only of FS121-D3-GRUNDY (plans/FS121-derivation.md:516) — candidates: FS111-M3-D3, FS38-D3, M3-J21-D3
- `D3` in rests on it of FS58-T6 (plans/FS58-derivation.md:119) — candidates: FS111-M3-D3, FS38-D3, M3-J21-D3
- `D3` in rests on it of M3-J21-SL (plans/M3-derivation.md:270) — candidates: FS111-M3-D3, FS38-D3, M3-J21-D3
- `D3` in rests on it of M40-T2 (plans/M40-derivation.md:28) — candidates: FS111-M3-D3, FS38-D3, M3-J21-D3
- `D3` in rests on it of M56-T4 (plans/M56-derivation.md:62) — candidates: FS111-M3-D3, FS38-D3, M3-J21-D3
- `D4` in rests on it of FS110-CE1 (plans/FS110-derivation.md:119) — candidates: M3-J21-D4
- `D4` in rests on it of FS111-M2-DISCK7-AS-PLACED (plans/FS111-derivation.md:1072) — candidates: M3-J21-D4
- `D4` in uses only of FS121-D4-GRID (plans/FS121-derivation.md:930) — candidates: M3-J21-D4
- `D4` in rests on it of M54-T2 (plans/M54-derivation.md:44) — candidates: M3-J21-D4
- `D4` in rests on it of M55-T1 (plans/M55-derivation.md:10) — candidates: M3-J21-D4
- `D4` in rests on it of M57-T2 (plans/M57-derivation.md:41) — candidates: M3-J21-D4
- `D8` in rests on it of FS111-C-SIX-M (plans/FS111-derivation.md:207) — candidates: FS86-B1-D8
- `D8` in rests on it of M40-T5 (plans/M40-derivation.md:95) — candidates: FS86-B1-D8
- `F1` in rests on it of FS111-M2-FIX (plans/FS111-derivation.md:864) — candidates: FS103-F1
- `F1` in rests on it of FS111-M3-IRREG (plans/FS111-derivation.md:1225) — candidates: FS103-F1
- `F1` in uses only of FS111-M4-CUT (plans/FS111-derivation.md:1288) — candidates: FS103-F1
- `F1` in rests on it of FS114-Y-STRIPK6 (plans/FS114-derivation.md:866) — candidates: FS103-F1
- `F1` in uses only of FS116-V1-FRAME (plans/FS116-derivation.md:84) — candidates: FS103-F1
- `F2` in rests on it of FS114-Y-PENT (plans/FS114-derivation.md:844) — candidates: M3-J18-F2
- `F3` in rests on it of FS114-NB-DUAL (plans/FS114-derivation.md:217) — candidates: M3-J18-F3
- `F3` in uses only of FS116-V1-FRAME (plans/FS116-derivation.md:84) — candidates: M3-J18-F3
- `F3` in rests on it of M51-T1 (plans/M51-derivation.md:29) — candidates: M3-J18-F3
- `H1` in uses only of FS111-M-PINCH (plans/FS111-derivation.md:435) — candidates: J04-H1, J14-H1
- `H1` in uses only of FS111-W-HULLREG-MAPS (plans/FS111-derivation.md:501) — candidates: J04-H1, J14-H1
- `H1` in uses only of FS116-O1-SATPIN (plans/FS116-derivation.md:54) — candidates: J04-H1, J14-H1
- `H1` in rests on it of M63H3-T2 (plans/M63H3-derivation.md:40) — candidates: J04-H1, J14-H1
- `HD4` in rests on it of FS86-V3 (plans/FS86-derivation.md:92) — candidates: FS86-dB-HD4
- `HD4` in rests on it of FS86-VX-Cp (plans/FS86-derivation.md:320) — candidates: FS86-dB-HD4
- `HD4` in rests on it of FS86-dB-D (plans/FS86-derivation.md:306) — candidates: FS86-dB-HD4
- `HD4` in rests on it of FS86-dB-HD4 (plans/FS86-derivation.md:335) — candidates: FS86-dB-HD4
- `HEX3` in uses only of FS116-Y4-OBST (plans/FS116-derivation.md:1747) — candidates: FS116-N2-HEX3
- `HEX3` in uses only of FS116-Y4-SPOKE (plans/FS116-derivation.md:1645) — candidates: FS116-N2-HEX3
- `HEX3` in uses only of FS116-Y4-SYM (plans/FS116-derivation.md:1625) — candidates: FS116-N2-HEX3
- `K1` in rests on it of FS86-VK (plans/FS86-derivation.md:111) — candidates: FS114-K1
- `K1` in rests on it of FS86-dB-A (plans/FS86-derivation.md:169) — candidates: FS114-K1
- `K3` in rests on it of FS86-dB-C0 (plans/FS86-derivation.md:272) — candidates: FS86-dB-K3
- `K4` in rests on it of FS85-dB2 (plans/FS85-derivation.md:82) — candidates: FS75-K4
- `L1` in uses only of FS116-N1-QFREE4 (plans/FS116-derivation.md:490) — candidates: FS106-L1, FS106-TS-L1, FS121-DB1-L1, FS38-L1, FS66-L1, FS67-L1 …
- `L1` in uses only of FS116-N2-FIVERING (plans/FS116-derivation.md:655) — candidates: FS106-L1, FS106-TS-L1, FS121-DB1-L1, FS38-L1, FS66-L1, FS67-L1 …
- `L1` in uses only of FS116-S1-QF (plans/FS116-derivation.md:931) — candidates: FS106-L1, FS106-TS-L1, FS121-DB1-L1, FS38-L1, FS66-L1, FS67-L1 …
- `L1` in rests on it of FS70-T6 (plans/FS70-derivation.md:50) — candidates: FS106-L1, FS106-TS-L1, FS121-DB1-L1, FS38-L1, FS66-L1, FS67-L1 …
- `L2` in uses only of FS116-RING-TWIST-C (plans/FS116-derivation.md:129) — candidates: FS38-L2, FS66-L2, FS89-D1-L2, FS89-D5-L2, FS91-J02-L2, FS91-J10-L2
- `L2` in rests on it of FS70-T6 (plans/FS70-derivation.md:50) — candidates: FS38-L2, FS66-L2, FS89-D1-L2, FS89-D5-L2, FS91-J02-L2, FS91-J10-L2
- `L2` in rests on it of FS73-T31 (plans/FS73-derivation.md:293) — candidates: FS38-L2, FS66-L2, FS89-D1-L2, FS89-D5-L2, FS91-J02-L2, FS91-J10-L2
- `L2` in rests on it of FS86-B2-T2 (plans/FS86-derivation.md:143) — candidates: FS38-L2, FS66-L2, FS89-D1-L2, FS89-D5-L2, FS91-J02-L2, FS91-J10-L2
- `L3` in rests on it of FS70-T10 (plans/FS70-derivation.md:87) — candidates: FS121-DB1-L3, FS38-L3, FS66-L3, FS89-D1-L3, FS89-D5-L3, FS91-J02-L3
- `L3` in rests on it of FS86-B2-T2 (plans/FS86-derivation.md:143) — candidates: FS121-DB1-L3, FS38-L3, FS66-L3, FS89-D1-L3, FS89-D5-L3, FS91-J02-L3
- `L6` in rests on it of FS70-T6 (plans/FS70-derivation.md:50) — candidates: FS105-B-L6, FS121-DB1-L6, FS66-L6, FS89-D1-L6
- `L6` in grade of FS70-T6 (plans/FS70-derivation.md:50) — candidates: FS105-B-L6, FS121-DB1-L6, FS66-L6, FS89-D1-L6
- `L6` in rests on it of FS73-T31 (plans/FS73-derivation.md:293) — candidates: FS105-B-L6, FS121-DB1-L6, FS66-L6, FS89-D1-L6
- `L60` in rests on it of FS114-L60-LE (plans/FS114-derivation.md:922) — candidates: FS112-L60
- `L60` in rests on it of FS114-L60-WALK (plans/FS114-derivation.md:943) — candidates: FS112-L60
- `L8` in rests on it of M56-T6 (plans/M56-derivation.md:88) — candidates: FS91-J10-L8
- `L8` in rests on it of M56-T7 (plans/M56-derivation.md:107) — candidates: FS91-J10-L8
- `N2` in rests on it of FS112-STRIP-CHAIN (plans/FS112-derivation.md:277) — candidates: FS75-N2
- `Q0` in rests on it of FS54-T1 (plans/FS54-derivation.md:20) — candidates: FS100-Q0
- `Q1` in rests on it of FS56-T5 (plans/FS56-derivation.md:96) — candidates: FS116-Y4-Q1
- `Q1` in rests on it of FS56-T7 (plans/FS56-derivation.md:128) — candidates: FS116-Y4-Q1
- `Q2` in rests on it of FS106-AE-Q2 (plans/FS106-derivation.md:129) — candidates: FS106-AE-Q2
- `R1` in rests on it of FS100-X27D-E (plans/FS100-derivation.md:346) — candidates: FS103-R1, FS112-Y3-R1, FS89-P-R1
- `R1` in rests on it of FS110-CE3 (plans/FS110-derivation.md:131) — candidates: FS103-R1, FS112-Y3-R1, FS89-P-R1
- `R1` in rests on it of FS86-A3 (plans/FS86-derivation.md:52) — candidates: FS103-R1, FS112-Y3-R1, FS89-P-R1
- `R1` in rests on it of M57-T3 (plans/M57-derivation.md:54) — candidates: FS103-R1, FS112-Y3-R1, FS89-P-R1
- `R1` in rests on it of M64-T1 (plans/M64-derivation.md:18) — candidates: FS103-R1, FS112-Y3-R1, FS89-P-R1
- `R3` in rests on it of M49-T3 (plans/M49-derivation.md:75) — candidates: FS112-Y3-R3
- `R3` in rests on it of M57-T3 (plans/M57-derivation.md:54) — candidates: FS112-Y3-R3
- `R3` in rests on it of M59-T2 (plans/M59-derivation.md:30) — candidates: FS112-Y3-R3
- `R3` in rests on it of M63D-T4 (plans/M63D-derivation.md:65) — candidates: FS112-Y3-R3
- `R7` in uses only of FS111-VMW-R7-MAX (plans/FS111-derivation.md:373) — candidates: FS111-M-R7
- `R7` in rests on it of FS111-VMW-R7-MAX (plans/FS111-derivation.md:373) — candidates: FS111-M-R7
- `R7` in rests on it of FS111-VMW-R7-PPLUS (plans/FS111-derivation.md:390) — candidates: FS111-M-R7
- `R7` in rests on it of FS111-W-KB-DIR (plans/FS111-derivation.md:677) — candidates: FS111-M-R7
- `R7` in rests on it of M59-T2 (plans/M59-derivation.md:30) — candidates: FS111-M-R7
- `R7` in rests on it of M59-T5 (plans/M59-derivation.md:87) — candidates: FS111-M-R7
- `R7` in rests on it of M61-T2 (plans/M61-derivation.md:30) — candidates: FS111-M-R7
- `S1` in rests on it of FS110-N2-S1 (plans/FS110-derivation.md:224) — candidates: FS110-N2-S1, FS112-DISK-S1
- `S1` in rests on it of FS86-dB-A1 (plans/FS86-derivation.md:180) — candidates: FS110-N2-S1, FS112-DISK-S1
- `S1` in rests on it of M59-T3 (plans/M59-derivation.md:50) — candidates: FS110-N2-S1, FS112-DISK-S1
- `S1` in rests on it of M59-T5 (plans/M59-derivation.md:87) — candidates: FS110-N2-S1, FS112-DISK-S1
- `S1` in rests on it of M61-T1 (plans/M61-derivation.md:11) — candidates: FS110-N2-S1, FS112-DISK-S1
- `SQ9` in uses only of FS121-V5-GRID-CANTOR (plans/FS121-derivation.md:1077) — candidates: FS111-W-SQ9
- `T1` in uses only of FS116-Y4-Q1 (plans/FS116-derivation.md:1666) — candidates: ASTRA-2026-09-14-T1, FS100-T1, FS25-T1, FS32-T1, FS36-T1, FS39-T1 …
- `T1` in rests on it of FS86-B2-T0 (plans/FS86-derivation.md:134) — candidates: ASTRA-2026-09-14-T1, FS100-T1, FS25-T1, FS32-T1, FS36-T1, FS39-T1 …
- `T1` in rests on it of FS86-V4 (plans/FS86-derivation.md:107) — candidates: ASTRA-2026-09-14-T1, FS100-T1, FS25-T1, FS32-T1, FS36-T1, FS39-T1 …
- `T1` in rests on it of FS86-dB-Atf (plans/FS86-derivation.md:195) — candidates: ASTRA-2026-09-14-T1, FS100-T1, FS25-T1, FS32-T1, FS36-T1, FS39-T1 …
- `T1` in rests on it of FS86-dB-E (plans/FS86-derivation.md:160) — candidates: ASTRA-2026-09-14-T1, FS100-T1, FS25-T1, FS32-T1, FS36-T1, FS39-T1 …
- `T2` in rests on it of FS110-Y-T2W (plans/FS110-derivation.md:266) — candidates: ASTRA-2026-09-14-T2, FS100-T2, FS25-T2, FS32-T2, FS36-T2, FS50-T2 …
- `T2` in rests on it of FS86-B2-T0 (plans/FS86-derivation.md:134) — candidates: ASTRA-2026-09-14-T2, FS100-T2, FS25-T2, FS32-T2, FS36-T2, FS50-T2 …
- `T24` in rests on it of M55-T7 (plans/M55-derivation.md:135) — candidates: FS73-T24, FS79-T24, FS81-T24
- `T3` in uses only of FS116-Y4-Q1 (plans/FS116-derivation.md:1666) — candidates: ASTRA-2026-09-14-T3, FS25-T3, FS50-T3, FS53-T3, FS54-T3, FS56-T3 …
- `T35` in rests on it of M3-J18-AKq (plans/M3-derivation.md:106) — candidates: FS73-T35, FS79-T35
- `T36` in rests on it of M3-J18-AKq (plans/M3-derivation.md:106) — candidates: FS73-T36, FS79-T36
- `T4` in rests on it of FS89-S0B-T2 (plans/FS89-derivation.md:114) — candidates: ASTRA-2026-09-14-T4, FS100-T4, FS25-T4, FS50-T4, FS53-T4, FS54-T4 …
- `T4` in grade of FS91-J09-J1 (plans/FS91-derivation.md:180) — candidates: ASTRA-2026-09-14-T4, FS100-T4, FS25-T4, FS50-T4, FS53-T4, FS54-T4 …
- `T5` in rests on it of FS89-S0B-T1 (plans/FS89-derivation.md:109) — candidates: ASTRA-2026-09-14-T5, FS100-T5, FS50-T5, FS54-T5, FS56-T5, FS58-T5 …
- `T5` in rests on it of FS89-S0B-T3 (plans/FS89-derivation.md:119) — candidates: ASTRA-2026-09-14-T5, FS100-T5, FS50-T5, FS54-T5, FS56-T5, FS58-T5 …
- `T6` in rests on it of FS91-J09-J4-T6 (plans/FS91-derivation.md:270) — candidates: ASTRA-2026-09-14-T6, FS50-T6, FS54-T6, FS56-T6, FS58-T6, FS62-T6 …
- `U1` in uses only of FS114-CV-EXISTS (plans/FS114-derivation.md:26) — candidates: FS112-U1, FS116-V5-U1
- `V1` in uses only of FS116-S1-QF (plans/FS116-derivation.md:931) — candidates: FS86-V1
- `V1` in uses only of FS116-V1-FRAME (plans/FS116-derivation.md:84) — candidates: FS86-V1
- `V2` in uses only of FS116-N1-TWIST-LIT (plans/FS116-derivation.md:156) — candidates: FS86-V2
- `V2` in uses only of FS116-RING-GERM (plans/FS116-derivation.md:175) — candidates: FS86-V2
- `V2` in uses only of FS121-DB1-L3 (plans/FS121-derivation.md:143) — candidates: FS86-V2
- `V2` in rests on it of FS73-T42 (plans/FS73-derivation.md:366) — candidates: FS86-V2
- `V3` in rests on it of FS106-SV1 (plans/FS106-derivation.md:58) — candidates: FS86-V3
- `V3` in uses only of FS116-N1-TOUCH (plans/FS116-derivation.md:507) — candidates: FS86-V3
- `V3` in uses only of FS116-V3-GERM-R-EDGE (plans/FS116-derivation.md:434) — candidates: FS86-V3
- `V3` in uses only of FS121-D3-FALLSAT (plans/FS121-derivation.md:498) — candidates: FS86-V3
- `V3` in uses only of FS121-D3-GRUNDY (plans/FS121-derivation.md:516) — candidates: FS86-V3
- `V3` in uses only of FS121-V3-CPI (plans/FS121-derivation.md:469) — candidates: FS86-V3
- `V3` in uses only of FS121-V3-CUSP (plans/FS121-derivation.md:483) — candidates: FS86-V3
- `V4` in uses only of FS121-V4-LF (plans/FS121-derivation.md:860) — candidates: FS86-V4
- `X1` in uses only of FS114-Y4-RSTOPALL (plans/FS114-derivation.md:577) — candidates: FS100-X1

## The no-entry lookup's prefix defect (item 111; `checks.md` § "Ids that appear in no indexed entry")

These 16 of item 20's 68 ids are filed with a milestone prefix and were reported as appearing in no indexed entry; each prefixed id is an entry (checked by this script):

- `D0-T1` — FS89-D0-T1
- `D5-L2` — FS89-D5-L2
- `TC-tab` — R88-TC-tab
- `TS-L1` — FS106-TS-L1
- `X27D-ATT` — FS100-X27D-ATT
- `X27D-E` — FS100-X27D-E
- `X27D-EQ` — FS100-X27D-EQ
- `X27D-FL` — FS100-X27D-FL
- `X27D-SIERP` — FS100-X27D-SIERP
- `X28D-CP1` — FS100-X28D-CP1
- `X28D-CP2` — FS100-X28D-CP2
- `X28D-CP3` — FS100-X28D-CP3
- `X28D-CUBE` — FS100-X28D-CUBE
- `X28D-ODD` — FS100-X28D-ODD
- `X28D-P` — FS100-X28D-P
- `X28D-S` — FS100-X28D-S
