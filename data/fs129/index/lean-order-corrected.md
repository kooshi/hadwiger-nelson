<!-- the results whose handoff names de Bruijn (SEED) and everything they rest on, each after what it uses, on edges-corrected.csv | command: python3 tools/fs129_z2_index.py | FS129-Z2, from data/fs129/index/edges.csv and theorems.jsonl as FS129-IX1 wrote them -->

# Lean order (corrected)

Seeds: 78 (as `lean-order.md`). Closure: 178 entries on every kept edge; 166 on first routes (route edges left out); the readers' sorts alone give 171; `lean-order.md` had 197. `role` adds ROUTE-ONLY where the entry is in the closure only through a route edge. Order: dependencies first, ties by id, a cycle's members together and flagged CYCLE. Errata the index cannot see (FS-129 item 116) and the FS129-SR1 § 6.2 list of statements that do not formalize as stated are FS129-L1's to apply.

| # | id | role | was | address | era | needs | kernel / handoff |
|---|---|---|---|---|---|---|---|
| 1 | FS106-DIAM | upstream | 2 | plans/FS106-derivation.md:155 | R |  | stub — small, a natural first FS-101 leaf. |
| 2 | FS106-L | upstream | 3 | plans/FS106-derivation.md:160 | R |  | declined. |
| 3 | FS106-SUP | upstream | 6 | plans/FS106-derivation.md:205 | R |  | declined. |
| 4 | FS106-TS-C | upstream | 7 | plans/FS106-derivation.md:143 | R | FS106-DIAM | declined. |
| 5 | FS106-TS-T | upstream | 8 | plans/FS106-derivation.md:151 | R | FS106-TS-C | declined. |
| 6 | FS106-WO | upstream | 9 | plans/FS106-derivation.md:73 | R | FS106-L | declined. |
| 7 | FS106-TW | upstream | 10 | plans/FS106-derivation.md:67 | R | FS106-L, FS106-WO | declined until the fill is walked. |
| 8 | FS106-AE-MAP6 | upstream | 11 | plans/FS106-derivation.md:121 | R | FS106-TS-T, FS106-TW | declined. |
| 9 | FS110-N3-CONF | upstream | — | plans/FS110-derivation.md:57 | R |  | with FS110-CLOSURE. |
| 10 | FS110-N3-DEG | upstream | — | plans/FS110-derivation.md:61 | R | FS110-N3-CONF | with FS110-CLOSURE. |
| 11 | FS110-N4-SHADOW | upstream | — | plans/FS110-derivation.md:70 | R |  | with FS110-CLOSURE. |
| 12 | FS110-N4-SHAVE | upstream | — | plans/FS110-derivation.md:75 | R | FS110-N4-SHADOW | with FS110-CLOSURE. |
| 13 | FS110-N4-STUCK | upstream | — | plans/FS110-derivation.md:80 | R | FS110-N3-DEG, FS110-N4-SHAVE | with FS110-CLOSURE. |
| 14 | FS110-N4-FIN | upstream | — | plans/FS110-derivation.md:84 | R | FS110-N4-SHADOW, FS110-N4-STUCK | with FS110-CLOSURE — an exact inequality chain, a leaf. |
| 15 | FS110-W-MERGE | upstream ROUTE-ONLY | — | plans/FS110-derivation.md:51 | R | FS110-N3-CONF | with FS110-CLOSURE. |
| 16 | FS111-C-FILL | SEED | 12 | plans/FS111-derivation.md:252 | R |  | de Bruijn — queued behind the measurable chain: a short measure estimate once D-NF is in Lean |
| 17 | FS111-C1-UNIF | SEED | 22 | plans/FS111-derivation.md:18 | R | FS106-SUP | de Bruijn — queued behind the measurable chain (FS-113, FS-101): the statement with µ₆ and 𝓜_K defined; no Lean object … |
| 18 | FS111-M-R7 | SEED | 14 | plans/FS111-derivation.md:347 | R |  | de Bruijn — a periodic tiling in ℚ(√3) with an exact certificate; kernel-checkable now, not urgent (a control object) |
| 19 | FS111-M-SATC | SEED | 15 | plans/FS111-derivation.md:316 | R | FS111-C-FILL | de Bruijn — queued behind the measurable chain: Zorn on admissible covers is short once a.e.-properness is in Lean |
| 20 | FS111-M2-COV | SEED | 16 | plans/FS111-derivation.md:816 | R | FS111-M-SATC | de Bruijn — queued behind the measurable chain, with FS111-M-SATC |
| 21 | FS111-M2-ZERO | SEED | 18 | plans/FS111-derivation.md:833 | R |  | de Bruijn — queued behind the measurable chain |
| 22 | FS111-V0-CLOSE | upstream | 19 | plans/FS111-derivation.md:53 | R |  | none — a one-line lemma used by FS111-V0-CLEAN and VM2-FACE; crosses with them |
| 23 | FS111-V0-ID1 | SEED | 23 | plans/FS111-derivation.md:296 | R |  | de Bruijn — queued behind the measurable chain |
| 24 | FS111-C-HULL | SEED | 24 | plans/FS111-derivation.md:267 | R | FS111-V0-ID1 | de Bruijn — queued behind the measurable chain, with FS111-V0-ID1 |
| 25 | FS111-M-HALF | upstream | 26 | plans/FS111-derivation.md:549 | R | FS111-C-HULL | none — a structural lemma toward REG-J′ |
| 26 | FS111-M-PINCH | SEED | 28 | plans/FS111-derivation.md:435 | R | FS111-C-HULL, FS111-V0-ID1 | de Bruijn — queued behind the measurable chain: the central lemma of route M, with (H1), (H2) stated and its not-claime… |
| 27 | FS111-M-C11 | SEED | 30 | plans/FS111-derivation.md:455 | R | FS111-M-PINCH | de Bruijn — with FS111-M-PINCH; the rolling-ball step would need its own formal proof or a Mathlib source |
| 28 | FS111-M2-INT | SEED | 31 | plans/FS111-derivation.md:850 | R | FS111-V0-ID1 | de Bruijn — queued behind the measurable chain |
| 29 | FS111-M2-FIX | SEED | 32 | plans/FS111-derivation.md:864 | R | FS111-C-HULL, FS111-M2-INT, FS111-M2-ZERO | de Bruijn — queued behind the measurable chain: the identity route M's cover form rests on |
| 30 | FS111-M2-HULLC | SEED | 37 | plans/FS111-derivation.md:907 | R | FS111-C-HULL, FS111-M-PINCH, FS111-M2-FIX | de Bruijn — queued behind the measurable chain; the finite-perimeter step needs Federer 4.5.11 or a Mathlib substitute |
| 31 | FS111-V0-RESCALE | SEED | 38 | plans/FS111-derivation.md:175 | R |  | de Bruijn — queued behind the measurable chain (FS-113): a short lemma with D-SLACK and a.e.-properness defined |
| 32 | FS111-C-SIX-M | upstream | 39 | plans/FS111-derivation.md:207 | R | FS106-AE-MAP6, FS111-V0-RESCALE | none — a composition of open statements; it crosses with them |
| 33 | FS111-M2-REDUCE-C | SEED | 40 | plans/FS111-derivation.md:973 | R | FS106-AE-MAP6, FS111-C-SIX-M, FS111-M-R7, FS111-M-SATC, FS111-M2-COV, FS111-M2-INT, FS111-V0-CLOSE, FS111-V0-RESCALE | de Bruijn — queued behind the measurable chain and FS106-AE-MAP6's formalization (Townsend's (c), FS-108) |
| 34 | FS111-W-KB-DIR | upstream | 41 | plans/FS111-derivation.md:677 | R | FS111-M-PINCH | none — a local rule for saturated maps |
| 35 | FS111-W-NOBEND | upstream | 42 | plans/FS111-derivation.md:471 | R | FS111-M-C11 | none — a corollary; it crosses with FS111-M-C11 |
| 36 | FS111-W-NOREP | upstream | 43 | plans/FS111-derivation.md:485 | R | FS111-M-C11, FS111-W-KB-DIR | none — a lemma inside FS111-W-HULLREG-MAPS; it crosses with it |
| 37 | FS111-W-SQ9 | upstream | 44 | plans/FS111-derivation.md:648 | R |  | none — a control object; exact and periodic, formalizable on demand |
| 38 | FS111-M2-INTRAD | SEED | 45 | plans/FS111-derivation.md:1007 | R | FS111-M-C11, FS111-W-SQ9 | de Bruijn — queued behind FS111-M-PINCH and FS111-M-C11: the link between route M and FS-115 |
| 39 | FS112-A4SIX | upstream | 47 | plans/FS112-derivation.md:61 | R |  | stub — with FS-114. |
| 40 | FS112-BOWTIE | upstream ROUTE-ONLY | 48 | plans/FS112-derivation.md:355 | R |  | declined — an exact fragment; FS-115 may promote it. |
| 41 | FS112-C-DOUBLE | upstream ROUTE-ONLY | 50 | plans/FS112-derivation.md:235 | R | FS112-BOWTIE | stub — with FS-115. |
| 42 | FS112-DISC1 | upstream | 51 | plans/FS112-derivation.md:124 | R |  | stub — with FS-114. |
| 43 | FS112-FLANK | upstream | 52 | plans/FS112-derivation.md:97 | R |  | stub — with FS-114. |
| 44 | FS112-ISO | upstream | 53 | plans/FS112-derivation.md:80 | R |  | declined — a local example. |
| 45 | FS112-LOCK | upstream | 54 | plans/FS112-derivation.md:70 | R |  | stub — with FS-114. |
| 46 | FS112-BEND | upstream | 55 | plans/FS112-derivation.md:75 | R | FS112-LOCK | stub — with FS-114. |
| 47 | FS112-N2-BENDS | upstream | 56 | plans/FS112-derivation.md:85 | R | FS112-ISO, FS112-LOCK | stub — with FS-114. |
| 48 | FS112-N2-FLANK-Q | upstream | 57 | plans/FS112-derivation.md:106 | R | FS112-FLANK | stub — with FS-114. |
| 49 | FS112-N2-RAY | upstream | 58 | plans/FS112-derivation.md:110 | R | FS112-FLANK | stub — with FS-114. |
| 50 | FS112-N3-ANTI | upstream | 59 | plans/FS112-derivation.md:151 | R |  | stub — with FS-114. |
| 51 | FS112-N3-FAIL | upstream | 60 | plans/FS112-derivation.md:146 | R |  | stub — with FS-114. |
| 52 | FS112-N3-NOBOTH | upstream | 61 | plans/FS112-derivation.md:142 | R |  | stub — with FS-114. |
| 53 | FS112-N3-END | upstream ROUTE-ONLY | 62 | plans/FS112-derivation.md:182 | R | FS112-N2-FLANK-Q, FS112-N3-NOBOTH | stub — with FS-114. |
| 54 | FS112-N3-PAIRS | upstream | 63 | plans/FS112-derivation.md:164 | R | FS112-N3-NOBOTH | stub — with FS-114. |
| 55 | FS112-NB4P | upstream | 64 | plans/FS112-derivation.md:53 | R | FS112-A4SIX | stub — with FS-114. |
| 56 | FS112-SIX | upstream | 65 | plans/FS112-derivation.md:48 | R |  | stub — with FS-114. |
| 57 | FS112-U1 | upstream | 66 | plans/FS112-derivation.md:42 | R |  | stub — with the NO's map argument (FS-114). |
| 58 | FS114-BV-HEX | upstream | 67 | plans/FS114-derivation.md:960 | R |  | none — BASE-V's regrade of row 134's base (the ledger draft carries it) |
| 59 | FS114-CV-HD | upstream ROUTE-ONLY | 68 | plans/FS114-derivation.md:57 | R | FS110-W-MERGE, FS112-U1 | none — a relay-result inside FS-112's chain composition; CV-EXISTS no longer uses it (FS114-CVB-EXISTS's route) |
| 60 | FS114-CVB-THOM | upstream | 69 | plans/FS114-derivation.md:83 | R |  | none — a relay-result for route T: it says where Thomassen's argument fails on valid maps (only the rainbow step) |
| 61 | FS114-L60-LE | upstream | 70 | plans/FS114-derivation.md:922 | R | FS106-TS-C | none — a correction of an FS-112 lemma, filed with its erratum |
| 62 | FS112-L60 | upstream | 72 | plans/FS112-derivation.md:66 | R | FS114-L60-LE | stub — with FS-114. |
| 63 | FS112-N2-RED | upstream | 73 | plans/FS112-derivation.md:90 | R | FS112-BEND, FS112-L60, FS112-N2-BENDS | stub — with FS-114. |
| 64 | FS112-N2-TERM | upstream | 74 | plans/FS112-derivation.md:115 | R | FS112-N2-FLANK-Q, FS112-N2-RAY, FS112-N2-RED, FS112-NB4P | stub — with FS-114. |
| 65 | FS112-C-ENDS | upstream ROUTE-ONLY | 71 | plans/FS112-derivation.md:197 | R | FS112-C-DOUBLE, FS112-N2-TERM, FS112-N3-END, FS114-CV-HD | stub — with FS-114. |
| 66 | FS112-N3-COR3 | upstream | 76 | plans/FS112-derivation.md:156 | R | FS112-L60, FS112-N3-FAIL, FS112-N3-NOBOTH | stub — with FS-114. |
| 67 | FS112-ROTHEX | upstream | 78 | plans/FS112-derivation.md:191 | R | FS112-N3-COR3 | stub — with FS-114. |
| 68 | FS112-N3-BASE | upstream | 75 | plans/FS112-derivation.md:169 | R | FS112-N2-BENDS, FS112-N3-ANTI, FS112-N3-COR3, FS112-N3-FAIL, FS112-N3-PAIRS, FS112-ROTHEX, FS114-BV-HEX | stub — with FS-114, over the base's own formalization. |
| 69 | FS112-N3-DENSE3 | upstream | 77 | plans/FS112-derivation.md:176 | R | FS112-DISC1, FS112-N3-BASE, FS112-SIX, FS114-BV-HEX | stub — with FS-114. |
| 70 | FS114-L60-WALK | upstream | 80 | plans/FS114-derivation.md:943 | R | FS112-N3-NOBOTH, FS114-L60-LE | none — an audit of a chain; its blind second mind is owed before publication |
| 71 | FS114-CV-EXISTS | SEED | 79 | plans/FS114-derivation.md:26 | R | FS110-N4-FIN, FS110-N4-SHADOW, FS112-C-ENDS, FS112-N2-TERM, FS112-N3-DENSE3, FS114-CV-HD, FS114-L60-WALK | de Bruijn — deferred with D6 (a Lean skeleton of Q-full's statement, held for Kooshi): the statement verbatim, its not-… |
| 72 | FS114-N114-RD | upstream | 81 | plans/FS114-derivation.md:108 | R | FS114-CVB-THOM | none — a relay-result for route T's counts and for C114-RAINBOW's corrected statement |
| 73 | FS114-N114-EULER | upstream | 82 | plans/FS114-derivation.md:148 | R | FS114-N114-RD | none — an identity route T's counts are read from |
| 74 | FS114-N2-FIVE | upstream | 83 | plans/FS114-derivation.md:166 | R | FS114-N114-EULER, FS114-N114-RD | none — route T's positive control, a known value by counting |
| 75 | FS114-N114-ROOM | upstream | 84 | plans/FS114-derivation.md:187 | R | FS114-N114-EULER, FS114-N2-FIVE | none — a relay-result for FS114-N2-ENDS |
| 76 | FS114-N2-ENDS | SEED | 85 | plans/FS114-derivation.md:235 | R | FS114-N114-EULER, FS114-N114-RD, FS114-N114-ROOM, FS114-N2-FIVE | de Bruijn — deferred with D6: the identity on a torus map is a finite combinatorial statement, a natural first kernel t… |
| 77 | FS114-N3-LOCAL | upstream | 86 | plans/FS114-derivation.md:419 | R | FS112-U1 | none — local tools for every later round; a blind check of N3-HALF, -SEC, -FLANK, -PAIR, -ODD is owed before the succes… |
| 78 | FS114-N3-DR | upstream | 87 | plans/FS114-derivation.md:443 | R | FS114-N3-LOCAL | none — superseded by FS114-Y4-RSTOPALL as a statement; its lemmas are relay-results |
| 79 | FS114-N4-LEMMAS | upstream | 89 | plans/FS114-derivation.md:503 | R | FS112-A4SIX, FS112-NB4P, FS112-SIX, FS112-U1, FS114-N3-LOCAL | none — relay-results for the bowtie's exclusion |
| 80 | FS114-N4-D | upstream | 93 | plans/FS114-derivation.md:480 | R | FS114-N3-DR, FS114-N3-LOCAL, FS114-N4-LEMMAS | none — superseded in scope by FS114-Y4-RSTOPALL; kept as the proof side's route |
| 81 | FS114-N5-GRING | upstream | 94 | plans/FS114-derivation.md:531 | R | FS114-N3-DR, FS114-N3-LOCAL, FS114-N4-D, FS114-N4-LEMMAS | none — the proof side's route to FS114-Y4-RSTOPALL's conclusion (NB5-BOWTIE) |
| 82 | FS114-N6-NOQ | upstream | 97 | plans/FS114-derivation.md:619 | R | FS112-U1, FS114-N3-LOCAL, FS114-N5-GRING | none — the proof side's half of the pinwheel's exclusion |
| 83 | FS114-N7-QOPP | upstream | 99 | plans/FS114-derivation.md:787 | R | FS112-U1, FS114-N6-NOQ | none — tools for the (Q)-ring cases, the successor's |
| 84 | FS114-Y2-BOWTIE | upstream | 91 | plans/FS114-derivation.md:461 | R |  | none — an exact object checked by exact arithmetic; a kernel certificate is owed only if K1's route is ever published t… |
| 85 | FS114-Y3-RSTOP | upstream | 95 | plans/FS114-derivation.md:601 | R | FS112-U1, FS114-Y2-BOWTIE | none — a member of FS114-Y4-RSTOPALL |
| 86 | FS114-Y4-LUNE | upstream | 92 | plans/FS114-derivation.md:554 | R | FS112-U1 | none — relay-results for FS114-Y4-RSTOPALL |
| 87 | FS114-Y4-RSTOPALL | SEED | 96 | plans/FS114-derivation.md:577 | R | FS112-U1, FS114-N3-DR, FS114-N5-GRING, FS114-Y3-RSTOP, FS114-Y4-LUNE | de Bruijn — deferred with D6: the first explicit-radius exclusion of a configuration at a four-colour vertex; what cros… |
| 88 | FS114-Y6-HALF | upstream | 100 | plans/FS114-derivation.md:698 | R | FS114-Y4-LUNE, FS114-Y4-RSTOPALL | none — a construction target's frame |
| 89 | FS114-N7-3T | upstream CYCLE | 102 | plans/FS114-derivation.md:717 | R | FS114-N3-LOCAL, FS114-N6-NOQ, FS114-N7-HUB, FS114-Y6-HALF | none — owed a blind second mind first; then with K1 |
| 90 | FS114-N7-HUB | upstream CYCLE | 103 | plans/FS114-derivation.md:762 | R | FS114-N6-NOQ, FS114-N7-3T | none — a relay-result; true vacuously where the ring carries no arc of Γ (FS116-Y4-EMPTY), and its content, if any, on … |
| 91 | FS116-N1-GERM-R | SEED | 104 | plans/FS116-derivation.md:414 | R |  | de Bruijn — the statement with its four open intervals; N-E1 and a monotonicity along the ring; queued behind D6's map … |
| 92 | FS116-N1-TWIST-D | SEED | 105 | plans/FS116-derivation.md:108 | R |  | de Bruijn — the first clause as stated, with N-E1 and the local finiteness it uses; a small statement once a map type e… |
| 93 | FS116-N1-ECHO | SEED | 106 | plans/FS116-derivation.md:528 | R | FS116-N1-TWIST-D | de Bruijn — with N-E1 and saturation read at a point |
| 94 | FS116-N1-GERM-S | SEED | 107 | plans/FS116-derivation.md:452 | R | FS116-N1-GERM-R, FS116-N1-TWIST-D | de Bruijn — with RING-GERM, the non-Siamese hypothesis dropped and (i), (ii) in their facing form |
| 95 | FS116-N1-QFREE4 | upstream | 108 | plans/FS116-derivation.md:490 | R | FS116-N1-TWIST-D | none — a two-line step used inside TOUCH's reduction; it crosses to Lean with it |
| 96 | FS116-N1-TOUCH | SEED | 109 | plans/FS116-derivation.md:507 | R | FS116-N1-GERM-R, FS116-N1-TWIST-D | de Bruijn — the statement, queued behind D6's map type |
| 97 | FS116-N2-FIVERING | upstream | 110 | plans/FS116-derivation.md:655 | R | FS116-N1-TWIST-D | none — a relay-result for the ring-type list; crosses to Lean with TWIST-D |
| 98 | FS116-N2-SIXRING | SEED | 111 | plans/FS116-derivation.md:635 | R | FS116-N1-TWIST-D | de Bruijn — with TWIST-D, queued behind D6's map type; a relay-result for any exclusion of six-colour vertices |
| 99 | FS116-N3-PAIR | SEED | 112 | plans/FS116-derivation.md:1396 | R |  | de Bruijn — with FS114-N7-QOPP, queued behind D6's map type |
| 100 | FS116-N3-STAR2 | SEED | 113 | plans/FS116-derivation.md:1414 | R | FS114-N7-QOPP, FS116-N3-PAIR | de Bruijn — with FS114-N7-QOPP |
| 101 | FS116-O1-SATPIN | SEED | 114 | plans/FS116-derivation.md:54 | R | FS111-M-C11, FS111-M-PINCH | de Bruijn — with FS111-M-PINCH and FS111-M-C11, queued behind the measurable chain: the statement, its cusp exclusion, … |
| 102 | FS116-N1-AXIS | SEED | 115 | plans/FS116-derivation.md:571 | R | FS116-N1-GERM-R, FS116-N1-GERM-S, FS116-O1-SATPIN | de Bruijn — the statement at q_N with the quarter-turn symmetry; queued behind SATPIN and D6's map type |
| 103 | FS116-O1-YESLIM | SEED | 116 | plans/FS116-derivation.md:30 | R |  | de Bruijn — queued behind the measurable chain (row 131's weak-* step): the statement at every k, its not-claimed line,… |
| 104 | FS116-RING-GERM | SEED | 117 | plans/FS116-derivation.md:175 | R | FS116-N1-TWIST-D | de Bruijn — the statement with its four germs, the six-colour step named, over TWIST-D; queued behind D6's map type |
| 105 | FS116-N2-STAR | SEED | 118 | plans/FS116-derivation.md:673 | R | FS116-N1-TWIST-D, FS116-RING-GERM | de Bruijn — with RING-GERM, queued behind D6's map type |
| 106 | FS116-N2-ANTI | SEED | 119 | plans/FS116-derivation.md:714 | R | FS116-N2-STAR | de Bruijn — with STAR |
| 107 | FS116-N2-RECIP | SEED | 120 | plans/FS116-derivation.md:694 | R | FS116-N1-TOUCH, FS116-N2-STAR | de Bruijn — with STAR and TOUCH |
| 108 | FS116-N2-HEX6 | SEED | 121 | plans/FS116-derivation.md:731 | R | FS114-N7-HUB, FS116-N1-QFREE4, FS116-N2-RECIP, FS116-RING-GERM | de Bruijn — with RECIP, STAR and TOUCH; a relay-result for D2 (the first shell of a Γ-free vertex holds a hub whose rin… |
| 109 | FS116-N2-HEX3 | SEED | 122 | plans/FS116-derivation.md:752 | R | FS116-N2-HEX6 | de Bruijn — with HEX6 |
| 110 | FS116-N3-CONE | SEED | 123 | plans/FS116-derivation.md:1374 | R | FS112-N3-NOBOTH, FS112-U1, FS116-N1-GERM-R, FS116-RING-GERM | de Bruijn — with RING-GERM and NOBOTH, queued behind D6's map type: the six half-planes at y and the edge clause |
| 111 | FS116-N3-CROSS | SEED | 124 | plans/FS116-derivation.md:1469 | R | FS114-N7-QOPP, FS116-N3-CONE, FS116-N3-STAR2, FS116-RING-GERM | de Bruijn — with STAR2 and RING-GERM |
| 112 | FS116-RING-Q-PRIME | SEED | 125 | plans/FS116-derivation.md:201 | R | FS116-RING-GERM | de Bruijn — with RING-GERM |
| 113 | FS116-RING-Q-PRIME-S | SEED | 126 | plans/FS116-derivation.md:475 | R | FS116-N1-GERM-S | de Bruijn — with FS116-N1-GERM-S |
| 114 | FS116-RING-TWIST-C | SEED | 127 | plans/FS116-derivation.md:129 | R | FS116-N1-TWIST-D | de Bruijn — the statement, its six-colour step L2 named, and TWIST-LIT's slit as the reason the counting word is colour… |
| 115 | FS116-RING-TRANSFER-C | SEED | 128 | plans/FS116-derivation.md:769 | R | FS116-N1-TWIST-D, FS116-N2-ANTI, FS116-N2-FIVERING, FS116-N2-HEX6, FS116-N2-RECIP, FS116-N2-SIXRING, FS116-N2-STAR, FS116-RING-GERM, FS116-RING-TWIST-C | de Bruijn — deferred with D6's map type, after a blind second mind on STAR, RECIP, ANTI and HEX6 |
| 116 | FS116-S1-CLUSTER | SEED | 129 | plans/FS116-derivation.md:836 | R |  | de Bruijn — a short lemma on connected families of open sets; it crosses with RUNG |
| 117 | FS116-S1-EXIT | SEED | 130 | plans/FS116-derivation.md:904 | R |  | de Bruijn — an elementary plane-geometry lemma; mechanical |
| 118 | FS116-S1-RUNG | SEED | 131 | plans/FS116-derivation.md:854 | R | FS116-O1-SATPIN, FS116-S1-CLUSTER | de Bruijn — with SATPIN; a rung-and-contact lemma |
| 119 | FS116-V4-CHORD | upstream | 132 | plans/FS116-derivation.md:954 | R |  | none — a relay-result for stage 2 |
| 120 | FS116-V4-DICHOTOMY | upstream | 133 | plans/FS116-derivation.md:970 | R |  | none — a relay-result for KAPPA, RUNG and QF |
| 121 | FS116-V4-MEET | upstream ROUTE-ONLY | 134 | plans/FS116-derivation.md:986 | R | FS116-V4-DICHOTOMY | none — RUNG's Siamese case rests on it |
| 122 | FS116-V4-OUTER | upstream ROUTE-ONLY | 135 | plans/FS116-derivation.md:1035 | R | FS116-V4-CHORD, FS116-V4-DICHOTOMY | none — QF rests on it |
| 123 | FS116-V4-PARTNER | upstream ROUTE-ONLY | 136 | plans/FS116-derivation.md:1018 | R | FS116-V4-DICHOTOMY | none — RUNG and QF rest on it |
| 124 | FS116-V4-TWIST | upstream ROUTE-ONLY | 137 | plans/FS116-derivation.md:1001 | R | FS116-V4-CHORD, FS116-V4-DICHOTOMY | none — KAPPA rests on it |
| 125 | FS116-S1-KAPPA | SEED | 138 | plans/FS116-derivation.md:795 | R | FS116-V4-CHORD, FS116-V4-DICHOTOMY, FS116-V4-MEET, FS116-V4-OUTER, FS116-V4-PARTNER, FS116-V4-TWIST | de Bruijn — with N-E1 and the germ convention; queued behind D6's map type |
| 126 | FS116-S1-PAIR | SEED | 139 | plans/FS116-derivation.md:818 | R | FS116-S1-KAPPA | de Bruijn — with FS116-S1-KAPPA |
| 127 | FS116-S1-LENS | SEED | 140 | plans/FS116-derivation.md:882 | R | FS116-N1-AXIS, FS116-N1-GERM-S, FS116-S1-KAPPA, FS116-S1-PAIR | de Bruijn — with KAPPA, PAIR and GERM-S; queued behind D6's map type |
| 128 | FS116-S1-QF | SEED | 141 | plans/FS116-derivation.md:931 | R | FS111-W-NOBEND, FS116-O1-SATPIN, FS116-S1-CLUSTER, FS116-S1-EXIT, FS116-S1-LENS | de Bruijn — the composition of LENS, EXIT and CLUSTER, queued behind SATPIN, M-PINCH and D6's map type |
| 129 | FS116-V5-NE1 | upstream | 142 | plans/FS116-derivation.md:1256 | R |  | none — a relay-result for the stages that follow |
| 130 | FS116-V5-OUT | upstream | 143 | plans/FS116-derivation.md:1314 | R |  | none — a relay-result for NBTIP, TIGHTLENS and STARFORCE |
| 131 | FS116-V5-OUT2 | upstream | 144 | plans/FS116-derivation.md:1554 | R |  | none — a relay-result for CROSS |
| 132 | FS116-V5-QCOL | upstream | 145 | plans/FS116-derivation.md:1518 | R | FS116-V5-NE1 | none — a relay-result for SEMI, PAIR, CROSS |
| 133 | FS116-V5-RING | upstream | 146 | plans/FS116-derivation.md:1273 | R | FS116-V5-NE1 | none — a relay-result for SIX and everything after it |
| 134 | FS116-V5-GERM | upstream | 147 | plans/FS116-derivation.md:1294 | R | FS116-V5-NE1, FS116-V5-RING | none — a relay-result for TIPS onward |
| 135 | FS116-V5-TIPSET | upstream | 148 | plans/FS116-derivation.md:1332 | R | FS116-V5-NE1 | none — a relay-result for TIPS |
| 136 | FS116-V5-LENS | upstream CYCLE ROUTE-ONLY | 149 | plans/FS116-derivation.md:1349 | R | FS116-V5-GERM, FS116-V5-NE1, FS116-V5-OUT, FS116-V5-RING, FS116-V5-TIPSET, FS116-Y3-TIPS | Keryx — V5-LENS proves more than FS116-Y3-TIGHTLENS states (each lens forces its first disjunct); the divergence table … |
| 137 | FS116-Y3-SIX | SEED CYCLE | 150 | plans/FS116-derivation.md:1074 | R | FS116-N1-QFREE4, FS116-RING-GERM, FS116-RING-TWIST-C, FS116-V5-GERM, FS116-V5-LENS, FS116-V5-NE1, FS116-V5-OUT, FS116-V5-RING, FS116-V5-TIPSET | de Bruijn — with RING-TWIST-C and RING-GERM, queued behind D6's map type |
| 138 | FS116-Y3-TIPS | SEED CYCLE | 151 | plans/FS116-derivation.md:1095 | R | FS116-RING-GERM, FS116-Y3-SIX | de Bruijn — with SIX; a relay-result for any exclusion of the Γ-free type |
| 139 | FS116-V5-U1 | upstream | 152 | plans/FS116-derivation.md:1536 | R |  | none — a relay-result |
| 140 | FS116-V5-DICHO | upstream ROUTE-ONLY | 153 | plans/FS116-derivation.md:1570 | R | FS116-V5-NE1, FS116-V5-QCOL, FS116-V5-U1 | none — § 13's note asks that the dichotomy be checked, not given; here it is derived for every degree |
| 141 | FS116-N3-SEMI | SEED | 154 | plans/FS116-derivation.md:1436 | R | FS116-N2-STAR, FS116-N3-CONE, FS116-N3-PAIR, FS116-N3-STAR2, FS116-RING-GERM, FS116-V5-DICHO, FS116-V5-OUT2, FS116-V5-QCOL, FS116-V5-U1 | de Bruijn — with RING-GERM, NOBOTH and STAR, after a blind second mind; a relay-result for D2 (every semi-hub but the p… |
| 142 | FS116-RING-TRANSFER-QC | SEED | 155 | plans/FS116-derivation.md:1492 | R | FS112-N3-NOBOTH, FS114-N7-QOPP, FS116-N1-GERM-R, FS116-N2-STAR, FS116-N3-CONE, FS116-N3-CROSS, FS116-N3-PAIR, FS116-N3-SEMI, FS116-N3-STAR2, FS116-RING-GERM | de Bruijn — deferred with D6's map type, after a blind second mind on SEMI, PAIR, STAR2 and CROSS |
| 143 | FS116-V6-HUBS | upstream | 156 | plans/FS116-derivation.md:1768 | R |  | none — a step of FS116-V6's route to FS116-Y4-EMPTY; it travels with EMPTY's handoff |
| 144 | FS116-V6-ANTI | upstream | 157 | plans/FS116-derivation.md:1832 | R | FS116-V6-HUBS | none — a step of FS116-V6's route; with EMPTY |
| 145 | FS116-V6-HUG | SEED | 158 | plans/FS116-derivation.md:1786 | R | FS116-V6-HUBS | de Bruijn — the pinning of the two edges to ω(y_1) and ω(y_0) and the trigonometric identity, a short kernel target, wi… |
| 146 | FS116-V6-COUNT | upstream | 159 | plans/FS116-derivation.md:1815 | R | FS116-V6-ANTI, FS116-V6-HUBS, FS116-V6-HUG | none — a step of FS116-V6's route; with EMPTY |
| 147 | FS116-Y2-SIXFRAG | SEED | 160 | plans/FS116-derivation.md:365 | R |  | de Bruijn — an exact fragment in Q(√3, √7) with its pair certificate, a control object for any local exclusion that cla… |
| 148 | FS116-Y3-HUBCOL | upstream | 161 | plans/FS116-derivation.md:1114 | R | FS116-N2-STAR, FS116-RING-GERM, FS116-Y3-TIPS | none — a relay-result for § 3 and the families |
| 149 | FS116-Y3-NBTIP | upstream | 162 | plans/FS116-derivation.md:1212 | R | FS116-N2-STAR, FS116-RING-GERM, FS116-Y3-TIPS | none — a relay-result for STARFORCE |
| 150 | FS116-Y3-NOQ | SEED | 163 | plans/FS116-derivation.md:1150 | R | FS116-RING-GERM, FS116-Y3-SIX | de Bruijn — with SIX and TIPS; a relay-result for any exclusion of the Γ-free type |
| 151 | FS116-Y3-TIGHT | upstream | 164 | plans/FS116-derivation.md:1132 | R | FS116-RING-GERM, FS116-Y3-TIPS | none — a relay-result for § 3 and the families |
| 152 | FS116-Y3-LENS | upstream | 165 | plans/FS116-derivation.md:1170 | R | FS116-Y3-NOQ, FS116-Y3-TIGHT, FS116-Y3-TIPS | none — a relay-result for TIGHTLENS |
| 153 | FS116-Y3-TIGHTLENS | SEED | 166 | plans/FS116-derivation.md:1189 | R | FS116-Y3-HUBCOL, FS116-Y3-LENS, FS116-Y3-NOQ | de Bruijn — with NOQ, LENS, TIPS and SIX, after a blind second mind; the generic star's exclusion at √3 is a relay-resu… |
| 154 | FS116-Y3-STARFORCE | SEED | 167 | plans/FS116-derivation.md:1231 | R | FS116-Y3-HUBCOL, FS116-Y3-LENS, FS116-Y3-NBTIP, FS116-Y3-NOQ, FS116-Y3-TIGHTLENS | de Bruijn — with NOQ, LENS, NBTIP, TIPS and SIX, after a blind second mind; a relay-result for D2: the Γ-free type's ca… |
| 155 | FS116-Y4-FLANK | SEED | 168 | plans/FS116-derivation.md:1684 | R |  | de Bruijn — a short lemma about two arcs inside two unit discs, after a blind second mind |
| 156 | FS116-Y4-EMPTY | SEED | 169 | plans/FS116-derivation.md:1712 | R | FS116-N2-STAR, FS116-RING-GERM, FS116-V6-ANTI, FS116-V6-COUNT, FS116-V6-HUBS, FS116-V6-HUG, FS116-Y3-SIX, FS116-Y3-TIPS, FS116-Y4-FLANK | de Bruijn — by either route, the first with FLANK, SIX, TIPS and RING-GERM, or FS116-V6's (FS116-V6-HUBS, -HUG, -COUNT,… |
| 157 | FS116-Y4-SYM | upstream | 170 | plans/FS116-derivation.md:1625 | R | FS116-Y3-TIPS | none — a bookkeeping lemma for the casework of this record |
| 158 | FS116-Y4-SPOKE | SEED (conditional: handoff begins `none`) | 171 | plans/FS116-derivation.md:1645 | R | FS116-RING-GERM, FS116-Y3-NBTIP, FS116-Y3-NOQ, FS116-Y3-STARFORCE, FS116-Y4-SYM | none — a relay-result for the obstruction or the construction of this record; with STARFORCE, after its blind check, a … |
| 159 | FS121-C1-BOUND | SEED | 172 | plans/FS121-derivation.md:710 | R |  | de Bruijn — queued behind the measurable chain (FS-113): a short lemma on closed connected sets and one perturbation |
| 160 | FS121-C1-SAT | SEED | 175 | plans/FS121-derivation.md:751 | R | FS121-C1-BOUND | de Bruijn — queued behind FS121-C1-BOUND and the saturated-colouring definitions (FS-113) |
| 161 | FS121-D1-XCORNER | upstream | 176 | plans/FS121-derivation.md:228 | R |  | none — elementary; it crosses with FS121-D1-EROSION |
| 162 | FS121-D2-EXT | SEED | 177 | plans/FS121-derivation.md:607 | R | FS111-M-C11, FS111-M2-INTRAD | de Bruijn — queued behind FS111-M-PINCH, FS111-M-C11 and FS111-M2-INTRAD; its geometric core is elementary |
| 163 | FS121-D2-THIN | upstream | 178 | plans/FS121-derivation.md:632 | R | FS111-M2-INTRAD, FS121-D2-EXT | none — a necessary condition on an uninhabited class; it crosses with FS121-D2-SYM |
| 164 | FS121-D3-FALLSAT | SEED | 179 | plans/FS121-derivation.md:498 | R | FS111-C-FILL | de Bruijn — queued behind the measurable chain (FS-113) |
| 165 | FS121-D3-GRUNDY | SEED | 174 | plans/FS121-derivation.md:516 | R | FS111-M-SATC, FS111-M2-ZERO | de Bruijn — queued behind the measurable chain; its dependent-choice route matters to a ZF + DC audit (Soifer's Open AC… |
| 166 | FS121-C1-GMAP | SEED | 173 | plans/FS121-derivation.md:732 | R | FS121-C1-BOUND, FS121-D3-GRUNDY | de Bruijn — with FS121-D3-GRUNDY, once map colourings and supports are in Lean |
| 167 | FS121-D4-FACE | SEED | 180 | plans/FS121-derivation.md:908 | R |  | de Bruijn — a short measure-theoretic lemma (Fubini on Leb ⊗ σ, one trigonometric bound); it crosses with the measurabl… |
| 168 | FS121-DB1-L3 | SEED | 181 | plans/FS121-derivation.md:143 | R | FS111-C-HULL, FS111-M-C11, FS111-M-PINCH | de Bruijn — queued behind FS111-M-PINCH, FS111-M-C11 and the measurable chain |
| 169 | FS121-O1-ENDS | SEED | 183 | plans/FS121-derivation.md:20 | R | FS111-C-HULL, FS111-M-HALF, FS111-M-PINCH, FS111-M2-INTRAD, FS111-W-NOREP, FS112-N3-NOBOTH, FS121-DB1-L3 | de Bruijn — queued behind FS111-M-PINCH, FS111-M2-INTRAD and the measurable chain (FS-113) |
| 170 | FS121-O1-OUT | SEED | 191 | plans/FS121-derivation.md:44 | R | FS111-M-C11, FS111-M-PINCH, FS111-M2-INTRAD | de Bruijn — with FS111-M2-INTRAD, queued behind the measurable chain |
| 171 | FS121-V2-SECTOR | SEED | 186 | plans/FS121-derivation.md:450 | R | FS111-M-C11, FS111-M-PINCH, FS121-DB1-L3 | de Bruijn — queued behind FS111-M-PINCH, FS111-M-C11 and the measurable chain |
| 172 | FS121-D1-VT | SEED | 188 | plans/FS121-derivation.md:243 | R | FS111-M-C11, FS111-M-PINCH, FS111-M2-INTRAD, FS121-V2-SECTOR | de Bruijn — queued behind FS111-M-PINCH, FS111-M2-INTRAD and the measurable chain: the statement with its no-radius-1 c… |
| 173 | FS121-D1-EROSION | SEED | 189 | plans/FS121-derivation.md:288 | R | FS111-M-C11, FS121-D1-VT, FS121-D1-XCORNER | de Bruijn — with FS121-D1-VT, queued behind the measurable chain |
| 174 | FS121-V5-LOC | upstream | 192 | plans/FS121-derivation.md:1092 | R | FS111-M-C11, FS111-M-PINCH | none — local lemmas consumed by FS121-V5-RAY |
| 175 | FS121-V5-RAY | SEED | 193 | plans/FS121-derivation.md:1109 | R | FS111-M-C11, FS121-V5-LOC | de Bruijn — a self-contained lemma over FS111-M-C11 that both routes to FS121-D2-SYM can rest on (item 79) |
| 176 | FS121-D2-SYM | SEED | 195 | plans/FS121-derivation.md:656 | R | FS111-M-C11, FS111-M2-INTRAD, FS121-D2-EXT, FS121-D2-THIN, FS121-O1-OUT, FS121-V5-RAY | de Bruijn — queued behind FS111-M2-INTRAD and the measurable chain (FS-113); V5's route needs only FS121-V5-RAY beyond … |
| 177 | TC1-SQRT3-DYADIC | SEED (conditional: handoff begins `none`) | 196 | plans/TC1-derivation.md:8 | A |  | none — a two-line local lemma that scopes G56's exclusion; it crosses to de Bruijn with that exclusion if it is formali… |
| 178 | TC1-STANDING-FIVE | SEED (conditional: handoff begins `none`) | 197 | plans/TC1-derivation.md:60 | A | TC1-SQRT3-DYADIC | none — conditional on MR (row 120, [hand]); it crosses to de Bruijn only with row 123's chain |

Left the Lean order (26; leaving means no seed rests on it, not that it has no value — FS-129 item 118): FS106-COMP (was 1), FS106-REM (was 4), FS106-EQ (was 5), FS111-C-HULL-SO (was 13), FS111-M2-DISC7 (was 17), FS111-V0-CLEAN (was 20), FS111-C1-PW (was 21), FS111-M-COVER-SC (was 25), FS111-M-HULL2 (was 27), FS121-D4-HOLE (was 29), FS111-M3-BAND (was 33), FS111-M3-FIXCONV (was 34), FS111-M3-HC (was 35), FS111-M3-IRREG (was 36), FS121-DB1-L6 (was 46), FS112-BUDGET2 (was 49), FS114-N3-JOINT (was 88), FS114-Y-EDGE (was 90), FS114-Y5-PINALL (was 98), FS114-K1 (was 101), FS121-DB1-L7 (was 182), FS121-V2-EROSION-DIAM (was 184), FS121-V3-CPI (was 185), FS121-V2-VT-W (was 187), FS121-D1-PENCILWIN (was 190), FS121-D2-PERFIN (was 194)

Joined it (7): FS110-N3-CONF, FS110-N3-DEG, FS110-N4-FIN, FS110-N4-SHADOW, FS110-N4-SHAVE, FS110-N4-STUCK, FS110-W-MERGE
