<!-- results whose `model:` line says no held or known object meets the hypotheses, and what rests on each | command: python3 tools/fs129_index.py | written at commit 60a7fc112c (inputs clean) -->

# Vacuity

Rule (mechanical, case-insensitive, whole words): `model_flag` is `none-known` when the `model:` text begins with the word "none" or contains "no held object", "none held", "none known" or "not held"; `no-field` when the entry has no `model:` line (every older-format entry, and some block entries); else `named`. Whether a class is empty, or a statement hypothetical by design, is not judged here. Dependents are the results that would inherit vacuity (edges.csv, with grade edges).

Counts: none-known 55 (53 begin with "none", 2 say it later in the line), named 212, no-field 1028 (25 block-format, 1003 older-format).

Flagged `none-known` by a phrase later in the line, not by beginning with "none" (the borderline ones): FS116-N1-QFREE4, FS121-O1-OUT.

Flagged `named` yet matching a looser pattern ("no … known/held", "empty", "premises open", "not known", "may be empty"), for a reader to look at (16): FS111-C-REG-EQ, FS111-C-SEVEN-M, FS111-C-SIX-M, FS111-C1-ROUTES, FS111-M4-LADDER, FS111-M4-MOVE, FS111-VM2-EQ5, FS114-CV-EXISTS, FS114-N114-COMPACT, FS114-N6-NOQ, FS116-N3-SEMI, FS116-RING-TRANSFER-C, FS116-RING-TWIST-C, FS116-S1-KAPPA, FS116-S1-PAIR, FS121-D3-EQ.

## The none-known results, by transitive dependents

### 1. FS121-D4-HOLE — plans/FS121-derivation.md:951 — transitive 60, direct 1

- model: none held of the hypothesis (R7, SQ9, HEX9, TINY16 have no region with a hole); a no-go for islands whose shore holds a point off Σ
- direct dependents (1): FS111-M-PINCH
- further transitive dependents (59): FS111-M-C11, FS111-M-EXTREME, FS111-M-REDUCE-I, FS111-M2-HULLC, FS111-M2-INTRAD, FS111-M2-REDUCE-A, FS111-M4-CUT, FS111-M4-HC, FS111-M4-LADDER, FS111-M4-MOVE, FS111-W-HEXSAT, FS111-W-HULLREG-MAPS, FS111-W-KB-DIR, FS111-W-LADDER, FS111-W-NOBEND, FS111-W-NOREP, FS116-C114-LOCAL-F, FS116-N1-AXIS, FS116-O1-SATPIN, FS116-S1-LENS, FS116-S1-QF, FS116-S1-RUNG, FS116-SAT-STRIP, FS116-Y1-NOTCH, FS116-Y1-STRIPCEIL, FS121-CURVED, FS121-D1-EROSION, FS121-D1-FIRSTORDER, FS121-D1-PENCILWIN, FS121-D1-R2CORNER, FS121-D1-R2SMOOTH, FS121-D1-RUNG2, FS121-D1-VT, FS121-D2-EXT, FS121-D2-INCURVED, FS121-D2-PERFIN, FS121-D2-SYM, FS121-D2-THIN, FS121-DB1-L1, FS121-DB1-L3, FS121-DB1-L4, FS121-DB1-L5, FS121-DB1-L6, FS121-DB1-L7, FS121-NOLRA, FS121-O1-ABOVE7, FS121-O1-CARD, FS121-O1-ENDS, FS121-O1-LRA-LINE, FS121-O1-OUT, FS121-O1-PER, FS121-R2-FOUR, FS121-V2-SECTOR, FS121-V2-VT-W, FS121-V5-LOC, FS121-V5-RAY, FS121-V5-SYM-CPT, FS121-V5-SYM-UP, FS121-Z1-NOCURVED

### 2. FS116-N1-QFREE4 — plans/FS116-derivation.md:490 — transitive 19, direct 2

- model: FS114-Y2-BOWTIE's ring has (Q) arcs and is no model; the degree-4 vertices of FS114-N6's (Q)-free pinwheel frame have four colours by hypothesis — none held with a (Q)-free ring at six colours
- direct dependents (2): FS116-N2-HEX6, FS116-Y3-SIX
- further transitive dependents (17): FS116-C114-LOCAL-F, FS116-N2-HEX3, FS116-RING-TRANSFER-C, FS116-V5-LENS, FS116-Y3-HUBCOL, FS116-Y3-LENS, FS116-Y3-NBTIP, FS116-Y3-NOQ, FS116-Y3-STARFORCE, FS116-Y3-TIGHT, FS116-Y3-TIGHTLENS, FS116-Y3-TIPS, FS116-Y4-EMPTY, FS116-Y4-OBST, FS116-Y4-Q1, FS116-Y4-SPOKE, FS116-Y4-SYM

### 3. FS116-V5-RING — plans/FS116-derivation.md:1273 — transitive 17, direct 3

- model: none held — no fragment of the class is known, and the class may be empty (the list's preamble: a statement about a possible object)
- direct dependents (3): FS116-V5-GERM, FS116-V5-LENS, FS116-Y3-SIX
- further transitive dependents (14): FS116-C114-LOCAL-F, FS116-Y3-HUBCOL, FS116-Y3-LENS, FS116-Y3-NBTIP, FS116-Y3-NOQ, FS116-Y3-STARFORCE, FS116-Y3-TIGHT, FS116-Y3-TIGHTLENS, FS116-Y3-TIPS, FS116-Y4-EMPTY, FS116-Y4-OBST, FS116-Y4-Q1, FS116-Y4-SPOKE, FS116-Y4-SYM

### 4. FS116-V5-GERM — plans/FS116-derivation.md:1294 — transitive 16, direct 2

- model: none held — V5-RING's class is not known to be non-empty
- direct dependents (2): FS116-V5-LENS, FS116-Y3-SIX
- further transitive dependents (14): FS116-C114-LOCAL-F, FS116-Y3-HUBCOL, FS116-Y3-LENS, FS116-Y3-NBTIP, FS116-Y3-NOQ, FS116-Y3-STARFORCE, FS116-Y3-TIGHT, FS116-Y3-TIGHTLENS, FS116-Y3-TIPS, FS116-Y4-EMPTY, FS116-Y4-OBST, FS116-Y4-Q1, FS116-Y4-SPOKE, FS116-Y4-SYM

### 5. FS116-V5-OUT — plans/FS116-derivation.md:1314 — transitive 16, direct 2

- model: none held — V5-RING's class is not known to be non-empty
- direct dependents (2): FS116-V5-LENS, FS116-Y3-SIX
- further transitive dependents (14): FS116-C114-LOCAL-F, FS116-Y3-HUBCOL, FS116-Y3-LENS, FS116-Y3-NBTIP, FS116-Y3-NOQ, FS116-Y3-STARFORCE, FS116-Y3-TIGHT, FS116-Y3-TIGHTLENS, FS116-Y3-TIPS, FS116-Y4-EMPTY, FS116-Y4-OBST, FS116-Y4-Q1, FS116-Y4-SPOKE, FS116-Y4-SYM

### 6. FS116-V5-TIPSET — plans/FS116-derivation.md:1332 — transitive 16, direct 2

- model: none held — V5-RING's class is not known to be non-empty
- direct dependents (2): FS116-V5-LENS, FS116-Y3-SIX
- further transitive dependents (14): FS116-C114-LOCAL-F, FS116-Y3-HUBCOL, FS116-Y3-LENS, FS116-Y3-NBTIP, FS116-Y3-NOQ, FS116-Y3-STARFORCE, FS116-Y3-TIGHT, FS116-Y3-TIGHTLENS, FS116-Y3-TIPS, FS116-Y4-EMPTY, FS116-Y4-OBST, FS116-Y4-Q1, FS116-Y4-SPOKE, FS116-Y4-SYM

### 7. FS116-V5-LENS — plans/FS116-derivation.md:1349 — transitive 15, direct 1

- model: none held — the class is not known to be non-empty, at any radius (FS116-Y3-STARFORCE's own not-claimed line)
- direct dependents (1): FS116-Y3-SIX
- further transitive dependents (14): FS116-C114-LOCAL-F, FS116-Y3-HUBCOL, FS116-Y3-LENS, FS116-Y3-NBTIP, FS116-Y3-NOQ, FS116-Y3-STARFORCE, FS116-Y3-TIGHT, FS116-Y3-TIGHTLENS, FS116-Y3-TIPS, FS116-Y4-EMPTY, FS116-Y4-OBST, FS116-Y4-Q1, FS116-Y4-SPOKE, FS116-Y4-SYM

### 8. FS116-Y3-SIX — plans/FS116-derivation.md:1074 — transitive 15, direct 3

- model: none at six colours (no Γ-free four-colour vertex is held: N2 § 2.4); SQ9 at k = 9 meets every hypothesis but six colours and has twelve change points — control fs116-y3-sq9
- direct dependents (3): FS116-Y3-NOQ, FS116-Y3-TIPS, FS116-Y4-EMPTY
- further transitive dependents (12): FS116-C114-LOCAL-F, FS116-V5-LENS, FS116-Y3-HUBCOL, FS116-Y3-LENS, FS116-Y3-NBTIP, FS116-Y3-STARFORCE, FS116-Y3-TIGHT, FS116-Y3-TIGHTLENS, FS116-Y4-OBST, FS116-Y4-Q1, FS116-Y4-SPOKE, FS116-Y4-SYM

### 9. FS116-Y3-TIPS — plans/FS116-derivation.md:1095 — transitive 15, direct 7

- model: none at six colours; the lattice facts it uses are control fs116-y3-lattice
- direct dependents (7): FS116-V5-LENS, FS116-Y3-HUBCOL, FS116-Y3-LENS, FS116-Y3-NBTIP, FS116-Y3-TIGHT, FS116-Y4-EMPTY, FS116-Y4-SYM
- further transitive dependents (8): FS116-C114-LOCAL-F, FS116-Y3-NOQ, FS116-Y3-SIX, FS116-Y3-STARFORCE, FS116-Y3-TIGHTLENS, FS116-Y4-OBST, FS116-Y4-Q1, FS116-Y4-SPOKE

### 10. FS121-D1-PENCILWIN — plans/FS121-derivation.md:389 — transitive 8, direct 1

- model: none held of the hypothesis at any k (no held colouring has a curved tangent interface)
- direct dependents (1): FS121-O1-OUT
- further transitive dependents (7): FS121-CURVED, FS121-D2-PERFIN, FS121-D2-SYM, FS121-O1-PER, FS121-V5-SYM-CPT, FS121-V5-SYM-UP, FS121-Z1-NOCURVED

### 11. FS121-O1-OUT — plans/FS121-derivation.md:44 — transitive 8, direct 6

- model: k = 9: SQ9, whose flat edges carry the ladder at every unit translate (48 of 48 edge-sides); no held object has a curved tangent interface
- direct dependents (6): FS121-D1-PENCILWIN, FS121-D2-SYM, FS121-O1-PER, FS121-V5-SYM-CPT, FS121-V5-SYM-UP, FS121-Z1-NOCURVED
- further transitive dependents (2): FS121-CURVED, FS121-D2-PERFIN

### 12. FS116-V6-HUBS — plans/FS116-derivation.md:1768 — transitive 7, direct 4

- model: none at six colours (FS116-Y4-EMPTY, held: the class is empty); SQ9 at k = 9 for the hypotheses but the colour count (control v6-sq9)
- direct dependents (4): FS116-V6-ANTI, FS116-V6-COUNT, FS116-V6-HUG, FS116-Y4-EMPTY
- further transitive dependents (3): FS116-C114-LOCAL-F, FS116-V6-ADJ, FS116-Y4-OBST

### 13. FS121-V5-RAY — plans/FS121-derivation.md:1109 — transitive 7, direct 3

- model: none held of the hypothesis at any k (no held colouring has arcs of radius ≥ 2); the statement is a contradiction lemma
- direct dependents (3): FS121-D2-SYM, FS121-V5-LOC, FS121-V5-SYM-CPT
- further transitive dependents (4): FS121-CURVED, FS121-D2-PERFIN, FS121-V5-SYM-UP, FS121-Z1-NOCURVED

### 14. FS116-V4-OUTER — plans/FS116-derivation.md:1035 — transitive 6, direct 1

- model: none at six colours — the class is the one QF empties; the step's arithmetic is checked on its own (control `v4-outer`)
- direct dependents (1): FS116-S1-KAPPA
- further transitive dependents (5): FS116-C114-LOCAL-F, FS116-S1-LENS, FS116-S1-PAIR, FS116-S1-QF, FS116-SAT-STRIP

### 15. FS114-N7-HUB — plans/FS114-derivation.md:762 — transitive 5, direct 2

- model: none held — FS114-Y2-BOWTIE's centre is not one (its ring carries two (Q) arcs, the erratum above); on rings carrying no arc of Γ none exists at six colours, non-Siamese and simple (FS116-Y4-EMPTY, held)
- direct dependents (2): FS114-N7-3T, FS116-N2-HEX6
- further transitive dependents (3): FS114-K1, FS116-N2-HEX3, FS116-RING-TRANSFER-C

### 16. FS116-V5-QCOL — plans/FS116-derivation.md:1518 — transitive 5, direct 3

- model: none held — no fragment of the class is known
- direct dependents (3): FS116-N3-SEMI, FS116-V5-CROSS-S, FS116-V5-DICHO
- further transitive dependents (2): FS116-C114-LOCAL-F, FS116-RING-TRANSFER-QC

### 17. FS116-V6-HUG — plans/FS116-derivation.md:1786 — transitive 5, direct 3

- model: none at six colours; V6's stage-1 candidate (a star with two five-colour hubs, § 2.3 item 1) fails exactly here, its two X̄ ring tiles √3 − 1 apart at s = t = 30°
- direct dependents (3): FS116-V6-ADJ, FS116-V6-COUNT, FS116-Y4-EMPTY
- further transitive dependents (2): FS116-C114-LOCAL-F, FS116-Y4-OBST

### 18. FS116-Y3-NOQ — plans/FS116-derivation.md:1150 — transitive 5, direct 5

- model: none at six colours; the lattice facts are control fs116-y3-lens
- direct dependents (5): FS116-Y3-LENS, FS116-Y3-STARFORCE, FS116-Y3-TIGHTLENS, FS116-Y4-Q1, FS116-Y4-SPOKE
- further transitive dependents (0): —

### 19. FS116-Y3-TIGHT — plans/FS116-derivation.md:1132 — transitive 5, direct 2

- model: none at six colours
- direct dependents (2): FS116-Y3-LENS, FS116-Y4-Q1
- further transitive dependents (3): FS116-Y3-STARFORCE, FS116-Y3-TIGHTLENS, FS116-Y4-SPOKE

### 20. FS116-V5-OUT2 — plans/FS116-derivation.md:1554 — transitive 4, direct 2

- model: none held — no fragment of the class is known
- direct dependents (2): FS116-N3-SEMI, FS116-V5-CROSS-S
- further transitive dependents (2): FS116-C114-LOCAL-F, FS116-RING-TRANSFER-QC

### 21. FS116-V6-ANTI — plans/FS116-derivation.md:1832 — transitive 4, direct 2

- model: none at six colours
- direct dependents (2): FS116-V6-COUNT, FS116-Y4-EMPTY
- further transitive dependents (2): FS116-C114-LOCAL-F, FS116-Y4-OBST

### 22. FS116-Y3-HUBCOL — plans/FS116-derivation.md:1114 — transitive 4, direct 2

- model: none at six colours
- direct dependents (2): FS116-Y3-STARFORCE, FS116-Y3-TIGHTLENS
- further transitive dependents (2): FS116-Y4-Q1, FS116-Y4-SPOKE

### 23. FS116-Y3-LENS — plans/FS116-derivation.md:1170 — transitive 4, direct 2

- model: none at six colours
- direct dependents (2): FS116-Y3-STARFORCE, FS116-Y3-TIGHTLENS
- further transitive dependents (2): FS116-Y4-Q1, FS116-Y4-SPOKE

### 24. FS121-D2-EXT — plans/FS121-derivation.md:607 — transitive 4, direct 2

- model: none held of the hypothesis at any k (no held colouring has a junction inside an interface arc)
- direct dependents (2): FS121-D2-SYM, FS121-D2-THIN
- further transitive dependents (2): FS121-D2-PERFIN, FS121-NOLRA

### 25. FS116-N2-RECIP — plans/FS116-derivation.md:694 — transitive 3, direct 2

- model: none held (no held fragment has a hub, § 2.4); on (Q)-free rings FS114-N7-HUB's six change points are its instances where their rings meet the hypotheses
- direct dependents (2): FS116-N2-HEX6, FS116-RING-TRANSFER-C
- further transitive dependents (1): FS116-N2-HEX3

### 26. FS116-V5-DICHO — plans/FS116-derivation.md:1570 — transitive 3, direct 1

- model: none held — no fragment of the class is known
- direct dependents (1): FS116-N3-SEMI
- further transitive dependents (2): FS116-C114-LOCAL-F, FS116-RING-TRANSFER-QC

### 27. FS116-V6-COUNT — plans/FS116-derivation.md:1815 — transitive 3, direct 1

- model: none at six colours
- direct dependents (1): FS116-Y4-EMPTY
- further transitive dependents (2): FS116-C114-LOCAL-F, FS116-Y4-OBST

### 28. FS116-Y3-NBTIP — plans/FS116-derivation.md:1212 — transitive 3, direct 2

- model: none at six colours; the angle fact is control fs116-y3-nbtip
- direct dependents (2): FS116-Y3-STARFORCE, FS116-Y4-SPOKE
- further transitive dependents (1): FS116-Y4-Q1

### 29. FS116-Y3-TIGHTLENS — plans/FS116-derivation.md:1189 — transitive 3, direct 1

- model: none at six colours (it is an obstruction); the truth table of its four conditions is control fs116-y3-lens
- direct dependents (1): FS116-Y3-STARFORCE
- further transitive dependents (2): FS116-Y4-Q1, FS116-Y4-SPOKE

### 30. FS121-D1-R2CORNER — plans/FS121-derivation.md:372 — transitive 3, direct 3

- model: none held of the hypothesis at any k
- direct dependents (3): FS121-D1-R2SMOOTH, FS121-D1-RUNG2, FS121-R2-FOUR
- further transitive dependents (0): —

### 31. FS121-D1-R2SMOOTH — plans/FS121-derivation.md:340 — transitive 3, direct 1

- model: none held of the hypothesis at any k
- direct dependents (1): FS121-D1-R2CORNER
- further transitive dependents (2): FS121-D1-RUNG2, FS121-R2-FOUR

### 32. FS121-D1-RUNG2 — plans/FS121-derivation.md:357 — transitive 3, direct 2

- model: none held of the hypothesis at any k; the bound is the diameter of the p-tile the (R2) definition names
- direct dependents (2): FS121-D1-R2CORNER, FS121-R2-FOUR
- further transitive dependents (1): FS121-D1-R2SMOOTH

### 33. FS121-D2-THIN — plans/FS121-derivation.md:632 — transitive 3, direct 2

- model: none held of the hypothesis at any k (no held colouring has LRA)
- direct dependents (2): FS121-D2-SYM, FS121-NOLRA
- further transitive dependents (1): FS121-D2-PERFIN

### 34. FS116-N2-FIVERING — plans/FS116-derivation.md:655 — transitive 2, direct 2

- model: none held with five colours at a vertex; at k = 7 the vertices of R7 carry six of seven, and the step "the absent colour is X" is where six is spent
- direct dependents (2): FS116-C114-LOCAL-F, FS116-RING-TRANSFER-C
- further transitive dependents (0): —

### 35. FS116-N2-HEX6 — plans/FS116-derivation.md:731 — transitive 2, direct 2

- model: none held at six colours (no Γ-free four-colour vertex is held: FS116-N1-QFREE4's model line); the hypotheses at p are FS114-N7-HUB's, whose six change points are this hexagon
- direct dependents (2): FS116-N2-HEX3, FS116-RING-TRANSFER-C
- further transitive dependents (0): —

### 36. FS116-Y3-STARFORCE — plans/FS116-derivation.md:1231 — transitive 2, direct 2

- model: none at six colours; the truth table is control fs116-y3-star
- direct dependents (2): FS116-Y4-Q1, FS116-Y4-SPOKE
- further transitive dependents (0): —

### 37. FS116-Y4-EMPTY — plans/FS116-derivation.md:1712 — transitive 2, direct 2

- model: none can exist (the statement is a non-existence); its geometric step is control fs116-y4-flank, whose plant three shows where six is spent
- direct dependents (2): FS116-C114-LOCAL-F, FS116-Y4-OBST
- further transitive dependents (0): —

### 38. FS116-Y4-SYM — plans/FS116-derivation.md:1625 — transitive 2, direct 1

- model: none at six colours (the class may be empty); the table is control fs116-y4-sym
- direct dependents (1): FS116-Y4-SPOKE
- further transitive dependents (1): FS116-Y4-Q1

### 39. FS114-Y-PAIRSHARE — plans/FS114-derivation.md:884 — transitive 1, direct 1

- model: none known in a valid map; the hypothesis (a cubic trichromatic vertex with close complementary partners) met on the strip and the disk as fragments, where FS114-Y-PENT and FS114-Y-STRIPK6 show the screen firing
- direct dependents (1): FS114-Y-PENT
- further transitive dependents (0): —

### 40. FS116-N2-ANTI — plans/FS116-derivation.md:714 — transitive 1, direct 1

- model: none held with two antipodal hubs; the strip's P₀ meets every hypothesis but the interiority of the flanking directions, and fails the conclusion (A(P₂) = {M, P}, A(P₋₂) = {B, O}) — control fs116-n2-star
- direct dependents (1): FS116-RING-TRANSFER-C
- further transitive dependents (0): —

### 41. FS116-Y4-SPOKE — plans/FS116-derivation.md:1645 — transitive 1, direct 1

- model: none at six colours; the plane facts at twelve points round 2y_2 are control fs116-y4-spoke
- direct dependents (1): FS116-Y4-Q1
- further transitive dependents (0): —

### 42. FS121-D1-FIRSTORDER — plans/FS121-derivation.md:323 — transitive 1, direct 1

- model: none held of the hypothesis at any k (no held colouring has an (R2) arc, C121-PER)
- direct dependents (1): FS121-R2-FOUR
- further transitive dependents (0): —

### 43. FS121-D2-INCURVED — plans/FS121-derivation.md:591 — transitive 1, direct 1

- model: none held of the hypothesis at any k; a containment of two uninhabited classes
- direct dependents (1): FS121-Z1-NOCURVED
- further transitive dependents (0): —

### 44. FS114-NB-DUAL — plans/FS114-derivation.md:217 — transitive 0, direct 0

- model: none known in the class (no doubly periodic valid map is known); the count's local terms met at the disk's corners (four-colour, degree 4)
- direct dependents (0): —
- further transitive dependents (0): —

### 45. FS114-Y-REDBLOCK1 — plans/FS114-derivation.md:334 — transitive 0, direct 0

- model: none known in the class (every tile with five edge-neighbours, non-Siamese, valid); the partition's hypothesis met by the hexagonal seven-colouring at seven colours with six edge-neighbours, which the class excludes
- direct dependents (0): —
- further transitive dependents (0): —

### 46. FS116-N1-ECHO — plans/FS116-derivation.md:528 — transitive 0, direct 0

- model: none held saturated at a touch point; F(1/5)'s q_N has the ring hypothesis (R on both sides, R of density 1/2 at q_N) but F(1/5) is saturated on B̄(P₀, 1/5) only and ends at radius 6/5, before (0, 2)
- direct dependents (0): —
- further transitive dependents (0): —

### 47. FS116-N2-HEX3 — plans/FS116-derivation.md:752 — transitive 0, direct 0

- model: none held, as HEX6
- direct dependents (0): —
- further transitive dependents (0): —

### 48. FS116-RING-Q-PRIME — plans/FS116-derivation.md:201 — transitive 0, direct 0

- model: none held with a (Q) arc on the ring and a change point in scope — the strip's and the Y2 bowtie's change points have ±60° points ending (Q) arcs, the disk's inside them; the statement holds at the class RING-GERM names, where FS114-N7-HUB's (Q)-free rings are its instances
- direct dependents (0): —
- further transitive dependents (0): —

### 49. FS116-RING-Q-PRIME-S — plans/FS116-derivation.md:475 — transitive 0, direct 0

- model: none held with a change point in scope, as RING-Q-PRIME (§ 3.5); FS114-N7-HUB's (Q)-free rings are its non-Siamese instances
- direct dependents (0): —
- further transitive dependents (0): —

### 50. FS116-V1-FRAME — plans/FS116-derivation.md:84 — transitive 0, direct 0

- model: none at six colours; V1 read the frame's colour-level conditions by hand on OC, the (1, 2, 1, 2) pinwheel, +++ and the γ = 0° lens (V1 § 3.2), which are patterns, not fragments
- direct dependents (0): —
- further transitive dependents (0): —

### 51. FS116-V6-ADJ — plans/FS116-derivation.md:1847 — transitive 0, direct 0

- model: none at six colours; V6's stage-1 candidate needed five-colour hubs because of it (§ 2.3 item 2)
- direct dependents (0): —
- further transitive dependents (0): —

### 52. FS116-Y4-OBST — plans/FS116-derivation.md:1747 — transitive 0, direct 0

- model: none can exist
- direct dependents (0): —
- further transitive dependents (0): —

### 53. FS116-Y4-Q1 — plans/FS116-derivation.md:1666 — transitive 0, direct 0

- model: none at six colours; the plane facts at twelve points round q_1 are control fs116-y4-q1
- direct dependents (0): —
- further transitive dependents (0): —

### 54. FS121-DB1-L5 — plans/FS121-derivation.md:176 — transitive 0, direct 0

- model: none held of the hypothesis at any k (no held colouring has an (R2) arc, C121-PER); R7, SQ9, HEX9 meet it vacuously
- direct dependents (0): —
- further transitive dependents (0): —

### 55. FS121-O1-LRA-LINE — plans/FS121-derivation.md:82 — transitive 0, direct 0

- model: none held of the hypothesis at any k (no held saturated colouring has LRA); the statement is a reduction, and R7, SQ9, HEX9 meet it vacuously
- direct dependents (0): —
- further transitive dependents (0): —

## The no-field entries, by milestone (file prefix; § B's milestone column in the second column where it is one value)

| prefix | § B milestone | no-field entries | of which block-format |
|---|---|---|---|
| ASTRA-2026-09-14 | 2026-09-14 | 10 | 0 |
| FS100 | row 116, row 117, row 118, row 120, row 121, row 122, row 123, row 124, row 125, row 126 | 63 | 0 |
| FS103 | row 128, row 129, row 130 | 33 | 0 |
| FS105 | row 120, row 128, row 129 | 19 | 0 |
| FS106 | row 131, row 132, row 40 | 46 | 0 |
| FS107 | row 133 | 16 | 0 |
| FS110 | row 134 | 49 | 0 |
| FS111 | row 139, row 140, row 141 | 7 | 7 |
| FS112 | row 135, row 136 | 56 | 0 |
| FS114 | row 137, row 138 | 3 | 3 |
| FS116 | 145, 146, 147, 148 | 7 | 7 |
| FS121 | 142, 143, 144 | 8 | 8 |
| FS25 | FS-25 | 4 | 0 |
| FS32 | FS-32 | 2 | 0 |
| FS36 | FS-36 | 2 | 0 |
| FS38 | FS-38 | 7 | 0 |
| FS39 | FS-39 | 1 | 0 |
| FS50 | FS-50 | 6 | 0 |
| FS53 | FS-53 | 4 | 0 |
| FS54 | FS-54 | 11 | 0 |
| FS56 | FS-56 | 7 | 0 |
| FS58 | FS-58 | 9 | 0 |
| FS61 | FS-61 | 5 | 0 |
| FS62 | FS-62 | 6 | 0 |
| FS66 | FS-66 | 18 | 0 |
| FS67 | FS-67 | 20 | 0 |
| FS70 | FS-70 | 11 | 0 |
| FS73 | FS-73 | 45 | 0 |
| FS75 | row 119 | 7 | 0 |
| FS79 | FS-79 | 49 | 0 |
| FS81 | FS-81 | 25 | 0 |
| FS85 | FS-85 | 39 | 0 |
| FS86 | FS-86 | 68 | 0 |
| FS89 | FS-89 | 64 | 0 |
| FS91 | FS-91 | 73 | 0 |
| M18 | M18 | 1 | 0 |
| M2 | M2 | 12 | 0 |
| M3 | M3 | 46 | 0 |
| M31 | M31 | 1 | 0 |
| M32 | M32 | 1 | 0 |
| M35 | M35 | 1 | 0 |
| M36 | M36 | 1 | 0 |
| M39 | M39 | 1 | 0 |
| M40 | M40 | 5 | 0 |
| M41 | M41 | 1 | 0 |
| M43 | M43 | 2 | 0 |
| M45 | M45 | 1 | 0 |
| M48 | M48 | 1 | 0 |
| M49 | M49 | 3 | 0 |
| M50 | M50 | 2 | 0 |
| M51 | M51 | 1 | 0 |
| M52 | M52 | 2 | 0 |
| M53 | M53 | 14 | 0 |
| M54 | M54 | 4 | 0 |
| M55 | M55 | 7 | 0 |
| M56 | M56 | 7 | 0 |
| M57 | M57 | 9 | 0 |
| M58 | M58 | 3 | 0 |
| M59 | M59 | 6 | 0 |
| M60 | M60 | 3 | 0 |
| M61 | M61 | 5 | 0 |
| M62 | M62 | 4 | 0 |
| M63 | M63 | 3 | 0 |
| M63C | M63 | 3 | 0 |
| M63D | M63 | 7 | 0 |
| M63G | M63 | 5 | 0 |
| M63H2 | M63 | 11 | 0 |
| M63H3 | M63 | 9 | 0 |
| M63H4 | M63 | 4 | 0 |
| M64 | M64 | 3 | 0 |
| MASCOT | 2026-09-08 | 11 | 0 |
| Q8 | M51/M52 (Q8) | 2 | 0 |
| R52 | 2026-09-06 | 4 | 0 |
| R57 | 2026-09-08 | 1 | 0 |
| R59 | 2026-09-09 | 2 | 0 |
| R88 | row 88 | 19 | 0 |

Block-format entries with no `model:` line (25): FS111-C-HULL-SO, FS111-C-SAT-T-HONEST, FS111-M2-DISCK7-AS-PLACED, FS111-MUA-FIN-L, FS111-REG-A6, FS111-REG-JP-C5, FS111-W-B-NONABS, FS114-GSD, FS114-K1, FS114-ROUTE-T, FS116-C114-LOCAL-F, FS116-RING-Q, FS116-RING-TRANSFER-Q, FS116-SAT-QFREE, FS116-SAT-STRIP, FS116-SEMI-PAR3, FS116-Y-SAT, FS121-CURVED, FS121-NOLRA, FS121-NOPAR, FS121-NOPAR-C5, FS121-O1-CARD, FS121-R2-FOUR, FS121-REGJ, FS121-SAT6.
