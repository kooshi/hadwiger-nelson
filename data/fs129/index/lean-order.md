<!-- the results whose handoff names de Bruijn (SEED) and everything they rest on, each after what it uses | command: python3 tools/fs129_index.py | written at commit ef8f2086b4 (inputs clean) -->

# Lean order

Seeds: 78 entries whose `handoff:` matches /de ?bruijn/i. Closure: 197 entries (seeds plus every entry reaching a seed along edges.csv). Order: dependencies first; ties by id; a cycle's members are listed together and flagged CYCLE, in id order, not broken. `needs` lists the direct upstream ids inside the closure. Older-format results have `handoff` empty here, their `Kernel:` text is copied (cut at 120).

| # | id | role | address | era | needs | kernel / handoff |
|---|---|---|---|---|---|---|
| 1 | FS106-COMP | upstream | plans/FS106-derivation.md:227 | R |  | declined. |
| 2 | FS106-DIAM | upstream | plans/FS106-derivation.md:155 | R |  | stub — small, a natural first FS-101 leaf. |
| 3 | FS106-L | upstream | plans/FS106-derivation.md:160 | R |  | declined. |
| 4 | FS106-REM | upstream | plans/FS106-derivation.md:223 | R |  | declined. |
| 5 | FS106-EQ | upstream CYCLE | plans/FS106-derivation.md:197 | R | FS106-COMP, FS106-REM, FS106-SUP | stub — after row 130's M1 enters FS-101. |
| 6 | FS106-SUP | upstream CYCLE | plans/FS106-derivation.md:205 | R | FS106-EQ | declined. |
| 7 | FS106-TS-C | upstream | plans/FS106-derivation.md:143 | R | FS106-DIAM | declined. |
| 8 | FS106-TS-T | upstream | plans/FS106-derivation.md:151 | R | FS106-TS-C | declined. |
| 9 | FS106-WO | upstream | plans/FS106-derivation.md:73 | R | FS106-L | declined. |
| 10 | FS106-TW | upstream | plans/FS106-derivation.md:67 | R | FS106-L, FS106-WO | declined until the fill is walked. |
| 11 | FS106-AE-MAP6 | upstream | plans/FS106-derivation.md:121 | R | FS106-TS-T, FS106-TW | declined. |
| 12 | FS111-C-FILL | SEED | plans/FS111-derivation.md:252 | R |  | de Bruijn — queued behind the measurable chain: a short measure estimate once D-NF is in Lean |
| 13 | FS111-C-HULL-SO | upstream | plans/FS111-derivation.md:282 | R |  |  |
| 14 | FS111-M-R7 | SEED | plans/FS111-derivation.md:347 | R |  | de Bruijn — a periodic tiling in ℚ(√3) with an exact certificate; kernel-checkable now, not urgent (a control object) |
| 15 | FS111-M-SATC | SEED | plans/FS111-derivation.md:316 | R | FS111-C-FILL | de Bruijn — queued behind the measurable chain: Zorn on admissible covers is short once a.e.-properness is in Lean |
| 16 | FS111-M2-COV | SEED | plans/FS111-derivation.md:816 | R | FS111-M-SATC | de Bruijn — queued behind the measurable chain, with FS111-M-SATC |
| 17 | FS111-M2-DISC7 | upstream | plans/FS111-derivation.md:881 | R |  | none — a control object; exact and periodic, formalizable on demand |
| 18 | FS111-M2-ZERO | SEED | plans/FS111-derivation.md:833 | R |  | de Bruijn — queued behind the measurable chain |
| 19 | FS111-V0-CLOSE | upstream | plans/FS111-derivation.md:53 | R |  | none — a one-line lemma used by FS111-V0-CLEAN and VM2-FACE; crosses with them |
| 20 | FS111-V0-CLEAN | upstream | plans/FS111-derivation.md:37 | R | FS111-V0-CLOSE | none — a routine cleaning step inside FS111-C1-PW; it crosses with that entry if the chain is formalized |
| 21 | FS111-C1-PW | upstream CYCLE | plans/FS111-derivation.md:67 | R | FS111-C1-UNIF, FS111-V0-CLEAN | none — conditional on FS-114's NO, which is open; it crosses with the NO if the NO lands |
| 22 | FS111-C1-UNIF | SEED CYCLE | plans/FS111-derivation.md:18 | R | FS106-SUP, FS111-C1-PW | de Bruijn — queued behind the measurable chain (FS-113, FS-101): the statement with µ₆ and 𝓜_K defined; no Lean object … |
| 23 | FS111-V0-ID1 | SEED | plans/FS111-derivation.md:296 | R |  | de Bruijn — queued behind the measurable chain |
| 24 | FS111-C-HULL | SEED | plans/FS111-derivation.md:267 | R | FS111-C-HULL-SO, FS111-V0-ID1 | de Bruijn — queued behind the measurable chain, with FS111-V0-ID1 |
| 25 | FS111-M-COVER-SC | upstream | plans/FS111-derivation.md:534 | R | FS111-C-HULL, FS111-M-SATC | none — superseded by FS111-M2-HULLC's fuller form; crosses with it |
| 26 | FS111-M-HALF | upstream | plans/FS111-derivation.md:549 | R | FS111-C-HULL | none — a structural lemma toward REG-J′ |
| 27 | FS111-M-HULL2 | upstream | plans/FS111-derivation.md:579 | R | FS111-C-HULL | none — a lemma inside FS111-M-BLOCK-EQ |
| 28 | FS111-M-PINCH | SEED CYCLE | plans/FS111-derivation.md:435 | R | FS111-C-HULL, FS111-V0-ID1, FS121-D4-HOLE | de Bruijn — queued behind the measurable chain: the central lemma of route M, with (H1), (H2) stated and its not-claime… |
| 29 | FS121-D4-HOLE | upstream CYCLE | plans/FS121-derivation.md:951 | R | FS111-M-HULL2, FS111-M-PINCH | none — a structural no-go between open statements; it crosses with FS111-M-PINCH |
| 30 | FS111-M-C11 | SEED | plans/FS111-derivation.md:455 | R | FS111-M-PINCH | de Bruijn — with FS111-M-PINCH; the rolling-ball step would need its own formal proof or a Mathlib source |
| 31 | FS111-M2-INT | SEED | plans/FS111-derivation.md:850 | R | FS111-V0-ID1 | de Bruijn — queued behind the measurable chain |
| 32 | FS111-M2-FIX | SEED CYCLE | plans/FS111-derivation.md:864 | R | FS111-C-HULL, FS111-M2-INT, FS111-M2-ZERO, FS111-M3-FIXCONV | de Bruijn — queued behind the measurable chain: the identity route M's cover form rests on |
| 33 | FS111-M3-BAND | upstream CYCLE | plans/FS111-derivation.md:1255 | R | FS111-M2-FIX | none — design facts for HC |
| 34 | FS111-M3-FIXCONV | upstream CYCLE | plans/FS111-derivation.md:1241 | R | FS111-M3-IRREG | none — a scope marker for FS111-M2-FIX |
| 35 | FS111-M3-HC | upstream CYCLE | plans/FS111-derivation.md:1129 | R | FS111-M2-FIX, FS111-M3-BAND | none — a counterexample to a universal form; exact, formalizable on demand |
| 36 | FS111-M3-IRREG | upstream CYCLE | plans/FS111-derivation.md:1225 | R | FS111-M3-HC | none — a no-go for a universal form |
| 37 | FS111-M2-HULLC | SEED | plans/FS111-derivation.md:907 | R | FS111-C-HULL, FS111-M-COVER-SC, FS111-M-PINCH, FS111-M2-DISC7, FS111-M2-FIX | de Bruijn — queued behind the measurable chain; the finite-perimeter step needs Federer 4.5.11 or a Mathlib substitute |
| 38 | FS111-V0-RESCALE | SEED | plans/FS111-derivation.md:175 | R |  | de Bruijn — queued behind the measurable chain (FS-113): a short lemma with D-SLACK and a.e.-properness defined |
| 39 | FS111-C-SIX-M | upstream | plans/FS111-derivation.md:207 | R | FS106-AE-MAP6, FS111-V0-RESCALE | none — a composition of open statements; it crosses with them |
| 40 | FS111-M2-REDUCE-C | SEED | plans/FS111-derivation.md:973 | R | FS106-AE-MAP6, FS111-C-SIX-M, FS111-M-R7, FS111-M-SATC, FS111-M2-COV, FS111-M2-INT, FS111-V0-CLOSE, FS111-V0-RESCALE | de Bruijn — queued behind the measurable chain and FS106-AE-MAP6's formalization (Townsend's (c), FS-108) |
| 41 | FS111-W-KB-DIR | upstream | plans/FS111-derivation.md:677 | R | FS111-M-PINCH | none — a local rule for saturated maps |
| 42 | FS111-W-NOBEND | upstream | plans/FS111-derivation.md:471 | R | FS111-M-C11 | none — a corollary; it crosses with FS111-M-C11 |
| 43 | FS111-W-NOREP | upstream | plans/FS111-derivation.md:485 | R | FS111-M-C11, FS111-W-KB-DIR | none — a lemma inside FS111-W-HULLREG-MAPS; it crosses with it |
| 44 | FS111-W-SQ9 | upstream | plans/FS111-derivation.md:648 | R |  | none — a control object; exact and periodic, formalizable on demand |
| 45 | FS111-M2-INTRAD | SEED CYCLE | plans/FS111-derivation.md:1007 | R | FS111-M-C11, FS111-W-SQ9, FS121-DB1-L6 | de Bruijn — queued behind FS111-M-PINCH and FS111-M-C11: the link between route M and FS-115 |
| 46 | FS121-DB1-L6 | upstream CYCLE | plans/FS121-derivation.md:192 | R | FS111-M-PINCH, FS111-M2-INTRAD | none — a re-derivation inside C121-ENDS's verification; it crosses with FS111-M2-INTRAD |
| 47 | FS112-A4SIX | upstream | plans/FS112-derivation.md:61 | R |  | stub — with FS-114. |
| 48 | FS112-BOWTIE | upstream | plans/FS112-derivation.md:355 | R |  | declined — an exact fragment; FS-115 may promote it. |
| 49 | FS112-BUDGET2 | upstream | plans/FS112-derivation.md:292 | R |  | declined. |
| 50 | FS112-C-DOUBLE | upstream | plans/FS112-derivation.md:235 | R | FS112-BOWTIE | stub — with FS-115. |
| 51 | FS112-DISC1 | upstream | plans/FS112-derivation.md:124 | R |  | stub — with FS-114. |
| 52 | FS112-FLANK | upstream | plans/FS112-derivation.md:97 | R |  | stub — with FS-114. |
| 53 | FS112-ISO | upstream | plans/FS112-derivation.md:80 | R |  | declined — a local example. |
| 54 | FS112-LOCK | upstream | plans/FS112-derivation.md:70 | R |  | stub — with FS-114. |
| 55 | FS112-BEND | upstream | plans/FS112-derivation.md:75 | R | FS112-LOCK | stub — with FS-114. |
| 56 | FS112-N2-BENDS | upstream | plans/FS112-derivation.md:85 | R | FS112-ISO, FS112-LOCK | stub — with FS-114. |
| 57 | FS112-N2-FLANK-Q | upstream | plans/FS112-derivation.md:106 | R | FS112-FLANK | stub — with FS-114. |
| 58 | FS112-N2-RAY | upstream | plans/FS112-derivation.md:110 | R | FS112-FLANK | stub — with FS-114. |
| 59 | FS112-N3-ANTI | upstream | plans/FS112-derivation.md:151 | R |  | stub — with FS-114. |
| 60 | FS112-N3-FAIL | upstream | plans/FS112-derivation.md:146 | R |  | stub — with FS-114. |
| 61 | FS112-N3-NOBOTH | upstream | plans/FS112-derivation.md:142 | R |  | stub — with FS-114. |
| 62 | FS112-N3-END | upstream | plans/FS112-derivation.md:182 | R | FS112-N2-FLANK-Q, FS112-N3-NOBOTH | stub — with FS-114. |
| 63 | FS112-N3-PAIRS | upstream | plans/FS112-derivation.md:164 | R | FS112-N3-NOBOTH | stub — with FS-114. |
| 64 | FS112-NB4P | upstream | plans/FS112-derivation.md:53 | R | FS112-A4SIX, FS112-BUDGET2 | stub — with FS-114. |
| 65 | FS112-SIX | upstream | plans/FS112-derivation.md:48 | R |  | stub — with FS-114. |
| 66 | FS112-U1 | upstream | plans/FS112-derivation.md:42 | R |  | stub — with the NO's map argument (FS-114). |
| 67 | FS114-BV-HEX | upstream | plans/FS114-derivation.md:960 | R |  | none — BASE-V's regrade of row 134's base (the ledger draft carries it) |
| 68 | FS114-CV-HD | upstream | plans/FS114-derivation.md:57 | R | FS112-U1 | none — a relay-result inside FS-112's chain composition; CV-EXISTS no longer uses it (FS114-CVB-EXISTS's route) |
| 69 | FS114-CVB-THOM | upstream | plans/FS114-derivation.md:83 | R |  | none — a relay-result for route T: it says where Thomassen's argument fails on valid maps (only the rainbow step) |
| 70 | FS114-L60-LE | upstream | plans/FS114-derivation.md:922 | R |  | none — a correction of an FS-112 lemma, filed with its erratum |
| 71 | FS112-C-ENDS | upstream CYCLE | plans/FS112-derivation.md:197 | R | FS112-C-DOUBLE, FS112-N2-TERM, FS112-N3-END, FS114-CV-HD | stub — with FS-114. |
| 72 | FS112-L60 | upstream CYCLE | plans/FS112-derivation.md:66 | R | FS114-CV-EXISTS, FS114-L60-LE | stub — with FS-114. |
| 73 | FS112-N2-RED | upstream CYCLE | plans/FS112-derivation.md:90 | R | FS112-BEND, FS112-L60, FS112-N2-BENDS | stub — with FS-114. |
| 74 | FS112-N2-TERM | upstream CYCLE | plans/FS112-derivation.md:115 | R | FS112-N2-FLANK-Q, FS112-N2-RAY, FS112-N2-RED, FS112-NB4P | stub — with FS-114. |
| 75 | FS112-N3-BASE | upstream CYCLE | plans/FS112-derivation.md:169 | R | FS112-N2-BENDS, FS112-N3-ANTI, FS112-N3-COR3, FS112-N3-FAIL, FS112-N3-PAIRS, FS112-ROTHEX, FS114-BV-HEX | stub — with FS-114, over the base's own formalization. |
| 76 | FS112-N3-COR3 | upstream CYCLE | plans/FS112-derivation.md:156 | R | FS112-L60, FS112-N3-FAIL, FS112-N3-NOBOTH | stub — with FS-114. |
| 77 | FS112-N3-DENSE3 | upstream CYCLE | plans/FS112-derivation.md:176 | R | FS112-DISC1, FS112-N3-BASE, FS112-SIX, FS114-BV-HEX, FS114-CV-EXISTS | stub — with FS-114. |
| 78 | FS112-ROTHEX | upstream CYCLE | plans/FS112-derivation.md:191 | R | FS112-N3-COR3 | stub — with FS-114. |
| 79 | FS114-CV-EXISTS | SEED CYCLE | plans/FS114-derivation.md:26 | R | FS112-C-ENDS, FS112-N2-TERM, FS112-N3-DENSE3, FS114-CV-HD, FS114-L60-WALK | de Bruijn — deferred with D6 (a Lean skeleton of Q-full's statement, held for Kooshi): the statement verbatim, its not-… |
| 80 | FS114-L60-WALK | upstream CYCLE | plans/FS114-derivation.md:943 | R | FS114-CV-EXISTS, FS114-L60-LE | none — an audit of a chain; its blind second mind is owed before publication |
| 81 | FS114-N114-RD | upstream | plans/FS114-derivation.md:108 | R | FS114-CVB-THOM | none — a relay-result for route T's counts and for C114-RAINBOW's corrected statement |
| 82 | FS114-N114-EULER | upstream | plans/FS114-derivation.md:148 | R | FS114-N114-RD | none — an identity route T's counts are read from |
| 83 | FS114-N2-FIVE | upstream | plans/FS114-derivation.md:166 | R | FS114-N114-EULER, FS114-N114-RD | none — route T's positive control, a known value by counting |
| 84 | FS114-N114-ROOM | upstream | plans/FS114-derivation.md:187 | R | FS114-N114-EULER, FS114-N2-FIVE | none — a relay-result for FS114-N2-ENDS |
| 85 | FS114-N2-ENDS | SEED | plans/FS114-derivation.md:235 | R | FS114-N114-EULER, FS114-N114-RD, FS114-N114-ROOM, FS114-N2-FIVE | de Bruijn — deferred with D6: the identity on a torus map is a finite combinatorial statement, a natural first kernel t… |
| 86 | FS114-N3-LOCAL | upstream | plans/FS114-derivation.md:419 | R | FS112-U1 | none — local tools for every later round; a blind check of N3-HALF, -SEC, -FLANK, -PAIR, -ODD is owed before the succes… |
| 87 | FS114-N3-DR | upstream | plans/FS114-derivation.md:443 | R | FS114-N3-LOCAL | none — superseded by FS114-Y4-RSTOPALL as a statement; its lemmas are relay-results |
| 88 | FS114-N3-JOINT | upstream | plans/FS114-derivation.md:258 | R | FS114-N2-ENDS, FS114-N3-DR | none — a reduction; the kill it names is the successor's |
| 89 | FS114-N4-LEMMAS | upstream | plans/FS114-derivation.md:503 | R | FS112-A4SIX, FS112-NB4P, FS112-SIX, FS112-U1, FS114-N3-LOCAL | none — relay-results for the bowtie's exclusion |
| 90 | FS114-Y-EDGE | upstream | plans/FS114-derivation.md:130 | R |  | none — a relay-result for route T and the pinwheel lemmas (FS114-Y5-PINALL uses its non-Siamese form) |
| 91 | FS114-Y2-BOWTIE | upstream | plans/FS114-derivation.md:461 | R |  | none — an exact object checked by exact arithmetic; a kernel certificate is owed only if K1's route is ever published t… |
| 92 | FS114-Y4-LUNE | upstream | plans/FS114-derivation.md:554 | R | FS112-U1 | none — relay-results for FS114-Y4-RSTOPALL |
| 93 | FS114-N4-D | upstream CYCLE | plans/FS114-derivation.md:480 | R | FS114-N3-DR, FS114-N3-LOCAL, FS114-N4-LEMMAS, FS114-Y3-RSTOP, FS114-Y4-RSTOPALL | none — superseded in scope by FS114-Y4-RSTOPALL; kept as the proof side's route |
| 94 | FS114-N5-GRING | upstream CYCLE | plans/FS114-derivation.md:531 | R | FS114-N3-DR, FS114-N3-LOCAL, FS114-N4-D, FS114-N4-LEMMAS | none — the proof side's route to FS114-Y4-RSTOPALL's conclusion (NB5-BOWTIE) |
| 95 | FS114-Y3-RSTOP | upstream CYCLE | plans/FS114-derivation.md:601 | R | FS112-U1, FS114-Y2-BOWTIE, FS114-Y4-RSTOPALL | none — a member of FS114-Y4-RSTOPALL |
| 96 | FS114-Y4-RSTOPALL | SEED CYCLE | plans/FS114-derivation.md:577 | R | FS112-U1, FS114-N3-DR, FS114-N5-GRING, FS114-Y3-RSTOP, FS114-Y4-LUNE | de Bruijn — deferred with D6: the first explicit-radius exclusion of a configuration at a four-colour vertex; what cros… |
| 97 | FS114-N6-NOQ | upstream CYCLE | plans/FS114-derivation.md:619 | R | FS112-U1, FS114-N3-LOCAL, FS114-N5-GRING, FS114-Y5-PINALL | none — the proof side's half of the pinwheel's exclusion |
| 98 | FS114-Y5-PINALL | upstream CYCLE | plans/FS114-derivation.md:640 | R | FS114-N6-NOQ, FS114-Y-EDGE | none — a local exclusion with two named exceptions; filed with them |
| 99 | FS114-N7-QOPP | upstream | plans/FS114-derivation.md:787 | R | FS112-U1, FS114-N6-NOQ | none — tools for the (Q)-ring cases, the successor's |
| 100 | FS114-Y6-HALF | upstream | plans/FS114-derivation.md:698 | R | FS114-Y4-LUNE, FS114-Y4-RSTOPALL | none — a construction target's frame |
| 101 | FS114-K1 | upstream CYCLE | plans/FS114-derivation.md:804 | R | FS114-N114-ROOM, FS114-N2-ENDS, FS114-N3-DR, FS114-N3-JOINT, FS114-N3-LOCAL, FS114-N5-GRING, FS114-N7-3T, FS114-N7-QOPP, FS114-Y2-BOWTIE, FS114-Y4-RSTOPALL, FS114-Y5-PINALL |  |
| 102 | FS114-N7-3T | upstream CYCLE | plans/FS114-derivation.md:717 | R | FS114-N3-LOCAL, FS114-N6-NOQ, FS114-N7-HUB, FS114-Y6-HALF | none — owed a blind second mind first; then with K1 |
| 103 | FS114-N7-HUB | upstream CYCLE | plans/FS114-derivation.md:762 | R | FS114-K1, FS114-N6-NOQ, FS114-N7-3T | none — a relay-result; true vacuously where the ring carries no arc of Γ (FS116-Y4-EMPTY), and its content, if any, on … |
| 104 | FS116-N1-GERM-R | SEED | plans/FS116-derivation.md:414 | R |  | de Bruijn — the statement with its four open intervals; N-E1 and a monotonicity along the ring; queued behind D6's map … |
| 105 | FS116-N1-TWIST-D | SEED | plans/FS116-derivation.md:108 | R |  | de Bruijn — the first clause as stated, with N-E1 and the local finiteness it uses; a small statement once a map type e… |
| 106 | FS116-N1-ECHO | SEED | plans/FS116-derivation.md:528 | R | FS116-N1-TWIST-D | de Bruijn — with N-E1 and saturation read at a point |
| 107 | FS116-N1-GERM-S | SEED | plans/FS116-derivation.md:452 | R | FS116-N1-GERM-R, FS116-N1-TWIST-D | de Bruijn — with RING-GERM, the non-Siamese hypothesis dropped and (i), (ii) in their facing form |
| 108 | FS116-N1-QFREE4 | upstream | plans/FS116-derivation.md:490 | R | FS116-N1-TWIST-D | none — a two-line step used inside TOUCH's reduction; it crosses to Lean with it |
| 109 | FS116-N1-TOUCH | SEED | plans/FS116-derivation.md:507 | R | FS116-N1-GERM-R, FS116-N1-TWIST-D | de Bruijn — the statement, queued behind D6's map type |
| 110 | FS116-N2-FIVERING | upstream | plans/FS116-derivation.md:655 | R | FS116-N1-TWIST-D | none — a relay-result for the ring-type list; crosses to Lean with TWIST-D |
| 111 | FS116-N2-SIXRING | SEED | plans/FS116-derivation.md:635 | R | FS116-N1-TWIST-D | de Bruijn — with TWIST-D, queued behind D6's map type; a relay-result for any exclusion of six-colour vertices |
| 112 | FS116-N3-PAIR | SEED | plans/FS116-derivation.md:1396 | R |  | de Bruijn — with FS114-N7-QOPP, queued behind D6's map type |
| 113 | FS116-N3-STAR2 | SEED | plans/FS116-derivation.md:1414 | R | FS114-N7-QOPP, FS116-N3-PAIR | de Bruijn — with FS114-N7-QOPP |
| 114 | FS116-O1-SATPIN | SEED | plans/FS116-derivation.md:54 | R | FS111-M-C11, FS111-M-PINCH | de Bruijn — with FS111-M-PINCH and FS111-M-C11, queued behind the measurable chain: the statement, its cusp exclusion, … |
| 115 | FS116-N1-AXIS | SEED | plans/FS116-derivation.md:571 | R | FS116-N1-GERM-R, FS116-O1-SATPIN | de Bruijn — the statement at q_N with the quarter-turn symmetry; queued behind SATPIN and D6's map type |
| 116 | FS116-O1-YESLIM | SEED | plans/FS116-derivation.md:30 | R |  | de Bruijn — queued behind the measurable chain (row 131's weak-* step): the statement at every k, its not-claimed line,… |
| 117 | FS116-RING-GERM | SEED | plans/FS116-derivation.md:175 | R | FS116-N1-TWIST-D | de Bruijn — the statement with its four germs, the six-colour step named, over TWIST-D; queued behind D6's map type |
| 118 | FS116-N2-STAR | SEED | plans/FS116-derivation.md:673 | R | FS116-N1-TWIST-D, FS116-RING-GERM | de Bruijn — with RING-GERM, queued behind D6's map type |
| 119 | FS116-N2-ANTI | SEED | plans/FS116-derivation.md:714 | R | FS116-N2-STAR | de Bruijn — with STAR |
| 120 | FS116-N2-RECIP | SEED | plans/FS116-derivation.md:694 | R | FS116-N1-TOUCH, FS116-N2-STAR | de Bruijn — with STAR and TOUCH |
| 121 | FS116-N2-HEX6 | SEED | plans/FS116-derivation.md:731 | R | FS114-N7-HUB, FS116-N1-QFREE4, FS116-N2-RECIP, FS116-RING-GERM | de Bruijn — with RECIP, STAR and TOUCH; a relay-result for D2 (the first shell of a Γ-free vertex holds a hub whose rin… |
| 122 | FS116-N2-HEX3 | SEED | plans/FS116-derivation.md:752 | R | FS116-N2-HEX6 | de Bruijn — with HEX6 |
| 123 | FS116-N3-CONE | SEED | plans/FS116-derivation.md:1374 | R | FS112-N3-NOBOTH, FS112-U1, FS116-N1-GERM-R, FS116-RING-GERM | de Bruijn — with RING-GERM and NOBOTH, queued behind D6's map type: the six half-planes at y and the edge clause |
| 124 | FS116-N3-CROSS | SEED | plans/FS116-derivation.md:1469 | R | FS114-N7-QOPP, FS116-N3-CONE, FS116-N3-STAR2, FS116-RING-GERM | de Bruijn — with STAR2 and RING-GERM |
| 125 | FS116-RING-Q-PRIME | SEED | plans/FS116-derivation.md:201 | R | FS116-RING-GERM | de Bruijn — with RING-GERM |
| 126 | FS116-RING-Q-PRIME-S | SEED | plans/FS116-derivation.md:475 | R | FS116-N1-GERM-S | de Bruijn — with FS116-N1-GERM-S |
| 127 | FS116-RING-TWIST-C | SEED | plans/FS116-derivation.md:129 | R | FS116-N1-TWIST-D | de Bruijn — the statement, its six-colour step L2 named, and TWIST-LIT's slit as the reason the counting word is colour… |
| 128 | FS116-RING-TRANSFER-C | SEED | plans/FS116-derivation.md:769 | R | FS116-N1-TWIST-D, FS116-N2-ANTI, FS116-N2-FIVERING, FS116-N2-HEX6, FS116-N2-RECIP, FS116-N2-SIXRING, FS116-N2-STAR, FS116-RING-GERM, FS116-RING-TWIST-C | de Bruijn — deferred with D6's map type, after a blind second mind on STAR, RECIP, ANTI and HEX6 |
| 129 | FS116-S1-CLUSTER | SEED | plans/FS116-derivation.md:836 | R |  | de Bruijn — a short lemma on connected families of open sets; it crosses with RUNG |
| 130 | FS116-S1-EXIT | SEED | plans/FS116-derivation.md:904 | R |  | de Bruijn — an elementary plane-geometry lemma; mechanical |
| 131 | FS116-S1-RUNG | SEED | plans/FS116-derivation.md:854 | R | FS116-O1-SATPIN, FS116-S1-CLUSTER | de Bruijn — with SATPIN; a rung-and-contact lemma |
| 132 | FS116-V4-CHORD | upstream | plans/FS116-derivation.md:954 | R |  | none — a relay-result for stage 2 |
| 133 | FS116-V4-DICHOTOMY | upstream | plans/FS116-derivation.md:970 | R |  | none — a relay-result for KAPPA, RUNG and QF |
| 134 | FS116-V4-MEET | upstream | plans/FS116-derivation.md:986 | R | FS116-V4-DICHOTOMY | none — RUNG's Siamese case rests on it |
| 135 | FS116-V4-OUTER | upstream | plans/FS116-derivation.md:1035 | R | FS116-V4-CHORD, FS116-V4-DICHOTOMY | none — QF rests on it |
| 136 | FS116-V4-PARTNER | upstream | plans/FS116-derivation.md:1018 | R | FS116-V4-DICHOTOMY | none — RUNG and QF rest on it |
| 137 | FS116-V4-TWIST | upstream | plans/FS116-derivation.md:1001 | R | FS116-V4-CHORD, FS116-V4-DICHOTOMY | none — KAPPA rests on it |
| 138 | FS116-S1-KAPPA | SEED | plans/FS116-derivation.md:795 | R | FS116-V4-CHORD, FS116-V4-DICHOTOMY, FS116-V4-MEET, FS116-V4-OUTER, FS116-V4-PARTNER, FS116-V4-TWIST | de Bruijn — with N-E1 and the germ convention; queued behind D6's map type |
| 139 | FS116-S1-PAIR | SEED | plans/FS116-derivation.md:818 | R | FS116-S1-KAPPA | de Bruijn — with FS116-S1-KAPPA |
| 140 | FS116-S1-LENS | SEED | plans/FS116-derivation.md:882 | R | FS116-N1-AXIS, FS116-N1-GERM-S, FS116-S1-KAPPA, FS116-S1-PAIR | de Bruijn — with KAPPA, PAIR and GERM-S; queued behind D6's map type |
| 141 | FS116-S1-QF | SEED | plans/FS116-derivation.md:931 | R | FS111-W-NOBEND, FS116-O1-SATPIN, FS116-S1-CLUSTER, FS116-S1-EXIT, FS116-S1-LENS | de Bruijn — the composition of LENS, EXIT and CLUSTER, queued behind SATPIN, M-PINCH and D6's map type |
| 142 | FS116-V5-NE1 | upstream | plans/FS116-derivation.md:1256 | R |  | none — a relay-result for the stages that follow |
| 143 | FS116-V5-OUT | upstream | plans/FS116-derivation.md:1314 | R |  | none — a relay-result for NBTIP, TIGHTLENS and STARFORCE |
| 144 | FS116-V5-OUT2 | upstream | plans/FS116-derivation.md:1554 | R |  | none — a relay-result for CROSS |
| 145 | FS116-V5-QCOL | upstream | plans/FS116-derivation.md:1518 | R | FS116-V5-NE1 | none — a relay-result for SEMI, PAIR, CROSS |
| 146 | FS116-V5-RING | upstream | plans/FS116-derivation.md:1273 | R | FS116-V5-NE1 | none — a relay-result for SIX and everything after it |
| 147 | FS116-V5-GERM | upstream | plans/FS116-derivation.md:1294 | R | FS116-V5-NE1, FS116-V5-RING | none — a relay-result for TIPS onward |
| 148 | FS116-V5-TIPSET | upstream | plans/FS116-derivation.md:1332 | R | FS116-V5-NE1 | none — a relay-result for TIPS |
| 149 | FS116-V5-LENS | upstream CYCLE | plans/FS116-derivation.md:1349 | R | FS116-V5-GERM, FS116-V5-NE1, FS116-V5-OUT, FS116-V5-RING, FS116-V5-TIPSET, FS116-Y3-TIPS | Keryx — V5-LENS proves more than FS116-Y3-TIGHTLENS states (each lens forces its first disjunct); the divergence table … |
| 150 | FS116-Y3-SIX | SEED CYCLE | plans/FS116-derivation.md:1074 | R | FS116-N1-QFREE4, FS116-RING-GERM, FS116-RING-TWIST-C, FS116-V5-GERM, FS116-V5-LENS, FS116-V5-NE1, FS116-V5-OUT, FS116-V5-RING, FS116-V5-TIPSET | de Bruijn — with RING-TWIST-C and RING-GERM, queued behind D6's map type |
| 151 | FS116-Y3-TIPS | SEED CYCLE | plans/FS116-derivation.md:1095 | R | FS116-RING-GERM, FS116-Y3-SIX | de Bruijn — with SIX; a relay-result for any exclusion of the Γ-free type |
| 152 | FS116-V5-U1 | upstream | plans/FS116-derivation.md:1536 | R |  | none — a relay-result |
| 153 | FS116-V5-DICHO | upstream | plans/FS116-derivation.md:1570 | R | FS116-V5-NE1, FS116-V5-QCOL, FS116-V5-U1 | none — § 13's note asks that the dichotomy be checked, not given; here it is derived for every degree |
| 154 | FS116-N3-SEMI | SEED | plans/FS116-derivation.md:1436 | R | FS116-N2-STAR, FS116-N3-CONE, FS116-N3-PAIR, FS116-N3-STAR2, FS116-RING-GERM, FS116-V5-DICHO, FS116-V5-OUT2, FS116-V5-QCOL, FS116-V5-U1 | de Bruijn — with RING-GERM, NOBOTH and STAR, after a blind second mind; a relay-result for D2 (every semi-hub but the p… |
| 155 | FS116-RING-TRANSFER-QC | SEED | plans/FS116-derivation.md:1492 | R | FS112-N3-NOBOTH, FS114-N7-QOPP, FS116-N1-GERM-R, FS116-N2-STAR, FS116-N3-CONE, FS116-N3-CROSS, FS116-N3-PAIR, FS116-N3-SEMI, FS116-N3-STAR2, FS116-RING-GERM | de Bruijn — deferred with D6's map type, after a blind second mind on SEMI, PAIR, STAR2 and CROSS |
| 156 | FS116-V6-HUBS | upstream | plans/FS116-derivation.md:1768 | R |  | none — a step of FS116-V6's route to FS116-Y4-EMPTY; it travels with EMPTY's handoff |
| 157 | FS116-V6-ANTI | upstream | plans/FS116-derivation.md:1832 | R | FS116-V6-HUBS | none — a step of FS116-V6's route; with EMPTY |
| 158 | FS116-V6-HUG | SEED | plans/FS116-derivation.md:1786 | R | FS116-V6-HUBS | de Bruijn — the pinning of the two edges to ω(y_1) and ω(y_0) and the trigonometric identity, a short kernel target, wi… |
| 159 | FS116-V6-COUNT | upstream | plans/FS116-derivation.md:1815 | R | FS116-V6-ANTI, FS116-V6-HUBS, FS116-V6-HUG | none — a step of FS116-V6's route; with EMPTY |
| 160 | FS116-Y2-SIXFRAG | SEED | plans/FS116-derivation.md:365 | R |  | de Bruijn — an exact fragment in Q(√3, √7) with its pair certificate, a control object for any local exclusion that cla… |
| 161 | FS116-Y3-HUBCOL | upstream | plans/FS116-derivation.md:1114 | R | FS116-N2-STAR, FS116-RING-GERM, FS116-Y3-TIPS | none — a relay-result for § 3 and the families |
| 162 | FS116-Y3-NBTIP | upstream | plans/FS116-derivation.md:1212 | R | FS116-N2-STAR, FS116-RING-GERM, FS116-Y3-TIPS | none — a relay-result for STARFORCE |
| 163 | FS116-Y3-NOQ | SEED | plans/FS116-derivation.md:1150 | R | FS116-RING-GERM, FS116-Y3-SIX | de Bruijn — with SIX and TIPS; a relay-result for any exclusion of the Γ-free type |
| 164 | FS116-Y3-TIGHT | upstream | plans/FS116-derivation.md:1132 | R | FS116-RING-GERM, FS116-Y3-TIPS | none — a relay-result for § 3 and the families |
| 165 | FS116-Y3-LENS | upstream | plans/FS116-derivation.md:1170 | R | FS116-Y3-NOQ, FS116-Y3-TIGHT, FS116-Y3-TIPS | none — a relay-result for TIGHTLENS |
| 166 | FS116-Y3-TIGHTLENS | SEED | plans/FS116-derivation.md:1189 | R | FS116-Y3-HUBCOL, FS116-Y3-LENS, FS116-Y3-NOQ | de Bruijn — with NOQ, LENS, TIPS and SIX, after a blind second mind; the generic star's exclusion at √3 is a relay-resu… |
| 167 | FS116-Y3-STARFORCE | SEED | plans/FS116-derivation.md:1231 | R | FS116-Y3-HUBCOL, FS116-Y3-LENS, FS116-Y3-NBTIP, FS116-Y3-NOQ, FS116-Y3-TIGHTLENS | de Bruijn — with NOQ, LENS, NBTIP, TIPS and SIX, after a blind second mind; a relay-result for D2: the Γ-free type's ca… |
| 168 | FS116-Y4-FLANK | SEED | plans/FS116-derivation.md:1684 | R |  | de Bruijn — a short lemma about two arcs inside two unit discs, after a blind second mind |
| 169 | FS116-Y4-EMPTY | SEED | plans/FS116-derivation.md:1712 | R | FS116-N2-STAR, FS116-RING-GERM, FS116-V6-ANTI, FS116-V6-COUNT, FS116-V6-HUBS, FS116-V6-HUG, FS116-Y3-SIX, FS116-Y3-TIPS, FS116-Y4-FLANK | de Bruijn — by either route, the first with FLANK, SIX, TIPS and RING-GERM, or FS116-V6's (FS116-V6-HUBS, -HUG, -COUNT,… |
| 170 | FS116-Y4-SYM | upstream | plans/FS116-derivation.md:1625 | R | FS116-Y3-TIPS | none — a bookkeeping lemma for the casework of this record |
| 171 | FS116-Y4-SPOKE | SEED (conditional: handoff begins `none`) | plans/FS116-derivation.md:1645 | R | FS116-RING-GERM, FS116-Y3-NBTIP, FS116-Y3-NOQ, FS116-Y3-STARFORCE, FS116-Y4-SYM | none — a relay-result for the obstruction or the construction of this record; with STARFORCE, after its blind check, a … |
| 172 | FS121-C1-BOUND | SEED | plans/FS121-derivation.md:710 | R |  | de Bruijn — queued behind the measurable chain (FS-113): a short lemma on closed connected sets and one perturbation |
| 173 | FS121-C1-GMAP | SEED CYCLE | plans/FS121-derivation.md:732 | R | FS121-C1-BOUND, FS121-D3-GRUNDY | de Bruijn — with FS121-D3-GRUNDY, once map colourings and supports are in Lean |
| 174 | FS121-D3-GRUNDY | SEED CYCLE | plans/FS121-derivation.md:516 | R | FS111-M-SATC, FS111-M2-ZERO, FS121-C1-GMAP | de Bruijn — queued behind the measurable chain; its dependent-choice route matters to a ZF + DC audit (Soifer's Open AC… |
| 175 | FS121-C1-SAT | SEED | plans/FS121-derivation.md:751 | R | FS121-C1-BOUND | de Bruijn — queued behind FS121-C1-BOUND and the saturated-colouring definitions (FS-113) |
| 176 | FS121-D1-XCORNER | upstream | plans/FS121-derivation.md:228 | R |  | none — elementary; it crosses with FS121-D1-EROSION |
| 177 | FS121-D2-EXT | SEED | plans/FS121-derivation.md:607 | R | FS111-M-C11, FS111-M2-INTRAD | de Bruijn — queued behind FS111-M-PINCH, FS111-M-C11 and FS111-M2-INTRAD; its geometric core is elementary |
| 178 | FS121-D2-THIN | upstream | plans/FS121-derivation.md:632 | R | FS111-M2-INTRAD, FS121-D2-EXT | none — a necessary condition on an uninhabited class; it crosses with FS121-D2-SYM |
| 179 | FS121-D3-FALLSAT | SEED | plans/FS121-derivation.md:498 | R | FS111-C-FILL | de Bruijn — queued behind the measurable chain (FS-113) |
| 180 | FS121-D4-FACE | SEED | plans/FS121-derivation.md:908 | R |  | de Bruijn — a short measure-theoretic lemma (Fubini on Leb ⊗ σ, one trigonometric bound); it crosses with the measurabl… |
| 181 | FS121-DB1-L3 | SEED | plans/FS121-derivation.md:143 | R | FS111-M-C11, FS111-M-PINCH | de Bruijn — queued behind FS111-M-PINCH, FS111-M-C11 and the measurable chain |
| 182 | FS121-DB1-L7 | upstream | plans/FS121-derivation.md:207 | R | FS111-M-C11, FS111-M-PINCH, FS111-M2-INTRAD | none — it crosses with FS121-O1-OUT |
| 183 | FS121-O1-ENDS | SEED | plans/FS121-derivation.md:20 | R | FS111-M-HALF, FS111-M-PINCH, FS111-M2-INTRAD, FS111-W-NOREP, FS112-N3-NOBOTH, FS121-DB1-L3 | de Bruijn — queued behind FS111-M-PINCH, FS111-M2-INTRAD and the measurable chain (FS-113) |
| 184 | FS121-V2-EROSION-DIAM | upstream | plans/FS121-derivation.md:308 | R | FS111-M-HULL2 | none — it places FS121-D1-EROSION's content |
| 185 | FS121-V3-CPI | upstream | plans/FS121-derivation.md:469 | R |  | none — a corollary inside FS121-V2-SECTOR's verification |
| 186 | FS121-V2-SECTOR | SEED | plans/FS121-derivation.md:450 | R | FS111-M-C11, FS111-M-PINCH, FS121-DB1-L3, FS121-V3-CPI | de Bruijn — queued behind FS111-M-PINCH, FS111-M-C11 and the measurable chain |
| 187 | FS121-V2-VT-W | upstream | plans/FS121-derivation.md:267 | R | FS111-M-C11, FS111-M-PINCH, FS111-M2-INTRAD, FS121-V2-SECTOR | none — the wider form of FS121-D1-VT; it crosses with it if the corner case is consumed |
| 188 | FS121-D1-VT | SEED | plans/FS121-derivation.md:243 | R | FS111-M-C11, FS111-M-PINCH, FS111-M2-INTRAD, FS121-V2-SECTOR, FS121-V2-VT-W | de Bruijn — queued behind FS111-M-PINCH, FS111-M2-INTRAD and the measurable chain: the statement with its no-radius-1 c… |
| 189 | FS121-D1-EROSION | SEED | plans/FS121-derivation.md:288 | R | FS111-M-C11, FS121-D1-VT, FS121-D1-XCORNER, FS121-V2-EROSION-DIAM | de Bruijn — with FS121-D1-VT, queued behind the measurable chain |
| 190 | FS121-D1-PENCILWIN | upstream CYCLE | plans/FS121-derivation.md:389 | R | FS111-M-HULL2, FS111-M2-INTRAD, FS121-D1-VT, FS121-O1-OUT, FS121-V2-SECTOR | none — a necessary condition on an uninhabited object; it crosses with FS121-O1-OUT if a curved inhabitant lands |
| 191 | FS121-O1-OUT | SEED CYCLE | plans/FS121-derivation.md:44 | R | FS111-M-C11, FS111-M-PINCH, FS111-M2-INTRAD, FS121-D1-PENCILWIN, FS121-DB1-L7 | de Bruijn — with FS111-M2-INTRAD, queued behind the measurable chain |
| 192 | FS121-V5-LOC | upstream CYCLE | plans/FS121-derivation.md:1092 | R | FS111-M-C11, FS111-M-PINCH, FS121-V5-RAY | none — local lemmas consumed by FS121-V5-RAY |
| 193 | FS121-V5-RAY | SEED CYCLE | plans/FS121-derivation.md:1109 | R | FS111-M-C11, FS121-V5-LOC | de Bruijn — a self-contained lemma over FS111-M-C11 that both routes to FS121-D2-SYM can rest on (item 79) |
| 194 | FS121-D2-PERFIN | upstream CYCLE | plans/FS121-derivation.md:679 | R | FS111-M2-INTRAD, FS121-D2-SYM | none — it removes a hypothesis from C121-PER's periodic clause; it crosses with FS121-D2-SYM |
| 195 | FS121-D2-SYM | SEED CYCLE | plans/FS121-derivation.md:656 | R | FS111-M-C11, FS111-M2-INTRAD, FS121-D2-EXT, FS121-D2-PERFIN, FS121-D2-THIN, FS121-O1-OUT, FS121-V5-RAY | de Bruijn — queued behind FS111-M2-INTRAD and the measurable chain (FS-113); V5's route needs only FS121-V5-RAY beyond … |
| 196 | TC1-SQRT3-DYADIC | SEED (conditional: handoff begins `none`) | plans/TC1-derivation.md:8 | A |  | none — a two-line local lemma that scopes G56's exclusion; it crosses to de Bruijn with that exclusion if it is formali… |
| 197 | TC1-STANDING-FIVE | SEED (conditional: handoff begins `none`) | plans/TC1-derivation.md:60 | A | TC1-SQRT3-DYADIC | none — conditional on MR (row 120, [hand]); it crosses to de Bruijn only with row 123's chain |
