<!-- every CHECK the script raised: fields it could not read, eras it could not place, defects | command: python3 tools/fs129_index.py | written at commit 8da8dc9352 (inputs clean) -->

# CHECK lines

CHECK: 498 older-format entries have no statement text between the header and `*Proof:*` (none, or only an `*Also:*` sentence), so `statement` is empty in the index (their statement, if any, is the header's title, kept in `title` and shown in statements-*.md); per file: FS100=58, FS103=33, FS105=19, FS106=46, FS107=16, FS110=49, FS112=56, FS67=20, FS75=7, FS79=8, FS85=12, FS86=35, FS89=51, FS91=29, M2=12, M3=41, R88=6. Each record's own `check` list carries the line; the ids are in theorems.jsonl.
CHECK: FS116-Y4-SPOKE (plans/FS116-derivation.md:1645): handoff begins `none` yet names de Bruijn in the field; indexed as a lean-order seed (the field, not the line, decides)
CHECK: TC1-SQRT3-DYADIC (plans/TC1-derivation.md:8): handoff begins `none` yet names de Bruijn in the field; indexed as a lean-order seed (the field, not the line, decides)
CHECK: TC1-STANDING-FIVE (plans/TC1-derivation.md:60): handoff begins `none` yet names de Bruijn in the field; indexed as a lean-order seed (the field, not the line, decides)
CHECK: defect `cycle`: dependency cycle: ASTRA-2026-09-14-T5, ASTRA-2026-09-14-T6
CHECK: defect `cycle`: dependency cycle: FS100-K0, FS100-MR
CHECK: defect `cycle`: dependency cycle: FS111-C1-PW, FS111-C1-UNIF
CHECK: defect `cycle`: dependency cycle: FS106-EQ, FS106-SUP
CHECK: defect `cycle`: dependency cycle: FS121-C1-GMAP, FS121-D3-GRUNDY
CHECK: defect `cycle`: dependency cycle: FS121-D2-PERFIN, FS121-D2-SYM
CHECK: defect `cycle`: dependency cycle: FS121-D1-PENCILWIN, FS121-O1-OUT
CHECK: defect `cycle`: dependency cycle: FS121-D1-R2CORNER, FS121-D1-R2SMOOTH, FS121-D1-RUNG2
CHECK: defect `cycle`: dependency cycle: FS111-M2-INTRAD, FS121-DB1-L6
CHECK: defect `cycle`: dependency cycle: FS121-DB1-L1, FS121-DB1-L4
CHECK: defect `cycle`: dependency cycle: FS121-V5-LOC, FS121-V5-RAY
CHECK: defect `cycle`: dependency cycle: FS111-M-PINCH, FS121-D4-HOLE
CHECK: defect `cycle`: dependency cycle: FS111-M2-FIX, FS111-M3-BAND, FS111-M3-FIXCONV, FS111-M3-HC, FS111-M3-IRREG
CHECK: defect `cycle`: dependency cycle: FS112-C-ENDS, FS112-L60, FS112-N2-RED, FS112-N2-TERM, FS112-N3-BASE, FS112-N3-COR3, FS112-N3-DENSE3, FS112-ROTHEX, FS114-CV-EXISTS, FS114-L60-WALK
CHECK: defect `cycle`: dependency cycle: FS114-K1, FS114-N7-3T, FS114-N7-HUB
CHECK: defect `cycle`: dependency cycle: FS114-N6-NOQ, FS114-Y5-PINALL
CHECK: defect `cycle`: dependency cycle: FS114-N4-D, FS114-N5-GRING, FS114-Y3-RSTOP, FS114-Y4-RSTOPALL
CHECK: defect `cycle`: dependency cycle: FS114-N2-AVG, FS114-N2-LEMMAS, FS114-ROUTE-T
CHECK: defect `cycle`: dependency cycle: FS116-V5-LENS, FS116-Y3-SIX, FS116-Y3-TIPS
CHECK: defect `cycle`: dependency cycle: FS25-T2, FS25-T3
CHECK: defect `cycle`: dependency cycle: FS38-L2, FS38-L3
CHECK: defect `cycle`: dependency cycle: FS61-T3, FS61-T4
CHECK: defect `cycle`: dependency cycle: FS66-T7, FS66-T8
CHECK: defect `cycle`: dependency cycle: FS66-L1, FS66-L2
CHECK: defect `cycle`: dependency cycle: FS66-L3, FS66-L4, FS66-L5
CHECK: defect `cycle`: dependency cycle: FS66-T3, FS66-W
CHECK: defect `cycle`: dependency cycle: FS70-T10, FS70-T11
CHECK: defect `cycle`: dependency cycle: FS70-T7, FS70-T8
CHECK: defect `cycle`: dependency cycle: FS85-R3b, FS85-V2-T8
CHECK: defect `cycle`: dependency cycle: FS85-C10, FS85-V7
CHECK: defect `cycle`: dependency cycle: FS91-J01-7, FS91-J08-10, FS91-J08-9
CHECK: defect `cycle`: dependency cycle: M3-J21-D0, M3-J21-RED
CHECK: defect `cycle`: dependency cycle: M3-J21-MX, M3-J21-TH, M3-J21-UNIF
CHECK: defect `cycle`: dependency cycle: M3-J18-AK2, M3-J18-K0H
CHECK: defect `cycle`: dependency cycle: M3-J19-KEF, M3-J19-KT
CHECK: defect `cycle`: dependency cycle: M3-J19-AFx, M3-J20-NAMED
CHECK: defect `cycle`: dependency cycle: M3-J21-D1-43p, M3-J22-T10
CHECK: defect `cycle`: dependency cycle: M53-T1, M53-T2
CHECK: defect `cycle`: dependency cycle: M56-T6, M56-T7
CHECK: defect `cycle`: dependency cycle: M59-T1, M59-T3
CHECK: defect `cycle`: dependency cycle: M63H2-T5, M63H2-T6
CHECK: defect `cycle`: dependency cycle: M63H2-T1, M63H2-T2
CHECK: defect `cycle`: dependency cycle: M63H2-T10, M63H2-T7
CHECK: defect `cycle`: dependency cycle: M63H3-T3, M63H3-T9
CHECK: defect `cycle`: dependency cycle: M63H4-T3, M63H4-T4
census note: note: M53-derivation.md: declared non-entry (header says 'not given … id'), not counted: **Proposition 6.4 (multiquadratic wall criterion), original and corrected — NOT given a fresh id; = 

## `*Also:*` clauses in older-format entries (each a claim with no record of its own)

CHECK: `*Also:*` at plans/FS100-derivation.md:289 (entry FS100-TCA) names X25B-PZ, X25B-LP — X25B-PZ (`r(G × H) ≤ max(r(G), r(H))` for LCA Cayley graphs, continuous factors included, in stationary form) and X25B-LP (Lemma P's bound at a ramified stable place of a real quadratic field) [hand, one mind each].
CHECK: `*Also:*` at plans/M3-derivation.md:246 (entry M3-J21-D1-43p) names no unresolved id; resolved to entries: M3-J21-UNIF — the uniform measure is optimal for both Hoffman and mixing on the level-one circle (M3-J21-UNIF).

## The 22 derivation files that define no indexed entry: entry-shaped headers and ids they define, and where each appears

A defined id is read mechanically (a bold entry header; a table row's first cell or a bold bullet id under a heading "Theorems this phase proved" / "The theorems"); it is looked for, with its job-qualified forms (`J27D-3`, `J27D #3` for a bare number), as a token in the text of the indexed entries (aliases such as `(= X23D-TCA)` are tokens there). A prime is dropped for the search. Not a judgement that any of them is a theorem.

### Ids that appear in no indexed entry (the finding)

CHECK: plans/FS100-J51D-derivation.md:15 `J51D-KS3` (table-row) appears in no indexed entry
CHECK: plans/FS100-X02D-derivation.md:346 `X02D-F` (table-row) appears in no indexed entry
CHECK: plans/FS100-X03D-derivation.md:13 `X03D-FL-1a` (table-row) appears in no indexed entry
CHECK: plans/FS100-X03D-derivation.md:21 `X03D-ED1-R` (table-row) appears in no indexed entry
CHECK: plans/FS100-X12B-derivation.md:202 `X12B-R` (table-row) appears in no indexed entry
CHECK: plans/FS100-X12B-derivation.md:209 `X12B-N` (table-row) appears in no indexed entry
CHECK: plans/FS100-X21D-derivation.md:12 `X21D-A2` (bold-bullet) appears in no indexed entry
CHECK: plans/FS100-X22D-derivation.md:16 `X22D-EF` (table-row) appears in no indexed entry
CHECK: plans/FS100-X22D-derivation.md:19 `X22D-FLK2` (table-row) appears in no indexed entry
CHECK: plans/FS100-X25B-derivation.md:170 `X25B-P` (bold-bullet) appears in no indexed entry
CHECK: plans/FS100-X25B-derivation.md:173 `X25B-L1` (bold-bullet) appears in no indexed entry
CHECK: plans/FS100-X25B-derivation.md:175 `X25B-W` (bold-bullet) appears in no indexed entry
CHECK: plans/FS100-X25B-derivation.md:181 `X25B-T1` (bold-bullet) appears in no indexed entry
CHECK: plans/FS100-X26B-derivation.md:11 `X26B-L2` (table-row) appears in no indexed entry
CHECK: plans/FS100-X26B-derivation.md:13 `X26B-CLS` (table-row) appears in no indexed entry
CHECK: plans/FS100-X26B-derivation.md:16 `X26B-ARCH` (table-row) appears in no indexed entry
CHECK: plans/FS100-X27D-derivation.md:13 `X27D-EQ` (table-row) appears in no indexed entry
CHECK: plans/FS100-X27D-derivation.md:18 `X27D-E` (table-row) appears in no indexed entry
CHECK: plans/FS100-X27D-derivation.md:19 `X27D-ATT` (table-row) appears in no indexed entry
CHECK: plans/FS100-X27D-derivation.md:20 `X27D-FL` (table-row) appears in no indexed entry
CHECK: plans/FS100-X27D-derivation.md:21 `X27D-SIERP` (table-row) appears in no indexed entry
CHECK: plans/FS100-X27D-derivation.md:22 `X27D-FLit` (table-row) appears in no indexed entry
CHECK: plans/FS100-X28D-derivation.md:14 `X28D-P` (table-row) appears in no indexed entry
CHECK: plans/FS100-X28D-derivation.md:15 `X28D-S` (table-row) appears in no indexed entry
CHECK: plans/FS100-X28D-derivation.md:16 `X28D-CP1` (table-row) appears in no indexed entry
CHECK: plans/FS100-X28D-derivation.md:17 `X28D-CP2` (table-row) appears in no indexed entry
CHECK: plans/FS100-X28D-derivation.md:18 `X28D-CP3` (table-row) appears in no indexed entry
CHECK: plans/FS100-X28D-derivation.md:19 `X28D-ODD` (table-row) appears in no indexed entry
CHECK: plans/FS100-X28D-derivation.md:20 `X28D-CUBE` (table-row) appears in no indexed entry
CHECK: plans/FS105-B-derivation.md:11 `FS105-B-L0` (bold-bullet) appears in no indexed entry
CHECK: plans/FS106-TQ-derivation.md:12 `TQ-CORE` (bold-bullet) appears in no indexed entry
CHECK: plans/FS106-TQ-derivation.md:16 `TQ-REM-ii` (bold-bullet) appears in no indexed entry
CHECK: plans/FS106-TQ-derivation.md:18 `TQ-P` (bold-bullet) appears in no indexed entry
CHECK: plans/FS106-TQ-derivation.md:18 `TQ-T` (bold-bullet) appears in no indexed entry
CHECK: plans/FS106-TQ-derivation.md:19 `TQ-SUP` (bold-bullet) appears in no indexed entry
CHECK: plans/FS106-TQ-derivation.md:20 `TQ-COMP-i` (bold-bullet) appears in no indexed entry
CHECK: plans/FS106-TQ-derivation.md:22 `TQ-COMP-ii` (bold-bullet) appears in no indexed entry
CHECK: plans/FS106-TQ-derivation.md:24 `TQ-EQ` (bold-bullet) appears in no indexed entry
CHECK: plans/FS106-TQ-derivation.md:26 `HOLE-t` (bold-bullet) appears in no indexed entry
CHECK: plans/FS106-TQ-derivation.md:32 `TQ-SYN` (bold-bullet) appears in no indexed entry
CHECK: plans/FS106-TS-derivation.md:17 `TS-L1` (bold-bullet) appears in no indexed entry
CHECK: plans/FS67-J27D-derivation.md:17 `7` (table-row) appears in no indexed entry
CHECK: plans/FS67-J27D-derivation.md:19 `9` (table-row) appears in no indexed entry
CHECK: plans/FS84-S1-derivation.md:12 `S1a` (table-row) appears in no indexed entry
CHECK: plans/FS84-S1-derivation.md:13 `S1a-P` (table-row) appears in no indexed entry
CHECK: plans/FS84-S1-derivation.md:14 `S1a-J` (table-row) appears in no indexed entry
CHECK: plans/FS84-S1-derivation.md:15 `S1b` (table-row) appears in no indexed entry
CHECK: plans/FS84-S1-derivation.md:16 `S1b-47` (table-row) appears in no indexed entry
CHECK: plans/FS84-S1-derivation.md:17 `S1c` (table-row) appears in no indexed entry
CHECK: plans/FS84-S1-derivation.md:18 `S1d-K` (table-row) appears in no indexed entry
CHECK: plans/FS84-S1-derivation.md:19 `S1e` (table-row) appears in no indexed entry
CHECK: plans/FS84-SI-D-derivation.md:11 `J45-N1` (table-row) appears in no indexed entry
CHECK: plans/FS84-SI-D-derivation.md:12 `J45-N2` (table-row) appears in no indexed entry
CHECK: plans/FS84-SI-D-derivation.md:13 `J45-SI-1` (table-row) appears in no indexed entry
CHECK: plans/FS84-SI-D-derivation.md:14 `J45-SI-2` (table-row) appears in no indexed entry
CHECK: plans/FS84-SI-D-derivation.md:15 `J45-SI-3` (table-row) appears in no indexed entry
CHECK: plans/FS84-SI-D-derivation.md:16 `J45-SI-4` (table-row) appears in no indexed entry
CHECK: plans/FS84-SI-D-derivation.md:17 `J45-SI-5` (table-row) appears in no indexed entry
CHECK: plans/FS84-SI-D-derivation.md:18 `J45-SI-J` (table-row) appears in no indexed entry
CHECK: plans/FS84-SI-D-derivation.md:19 `J45-G2` (table-row) appears in no indexed entry
CHECK: plans/FS84-SI-D-derivation.md:20 `J45-SI-C` (table-row) appears in no indexed entry
CHECK: plans/FS84-SI-D-derivation.md:23 `J45-RU` (table-row) appears in no indexed entry
CHECK: plans/FS84-SI-D-derivation.md:24 `J45-SP-oi` (table-row) appears in no indexed entry
CHECK: plans/FS84-SI-D-derivation.md:25 `J45-SP-if` (table-row) appears in no indexed entry
CHECK: plans/FS84-SI-D-derivation.md:26 `J45-SP-Cor` (table-row) appears in no indexed entry
CHECK: plans/FS86-R88-D-derivation.md:19 `TC-tab` (bold-bullet) appears in no indexed entry
CHECK: plans/FS89-S1D-derivation.md:405 `D0-T1` (table-row) appears in no indexed entry
CHECK: plans/FS89-S1D-derivation.md:418 `D5-L2` (table-row) appears in no indexed entry

### Ids found only as a bare token with no hyphen (weak: the token may mean something else in the entry that carries it)

CHECK: plans/FS100-X01D-derivation.md:13 `Haar` found only as the bare token `Haar` in FS100-CE1, FS100-FLK, FS100-K0
CHECK: plans/FS100-X01D-derivation.md:16 `Lemma` found only as the bare token `Lemma` in ASTRA-2026-09-14-T1, ASTRA-2026-09-14-T2, FS100-B12
CHECK: plans/FS100-X01D-derivation.md:17 `Lemma` found only as the bare token `Lemma` in ASTRA-2026-09-14-T1, ASTRA-2026-09-14-T2, FS100-B12
CHECK: plans/FS100-X01D-derivation.md:18 `Lemma` found only as the bare token `Lemma` in ASTRA-2026-09-14-T1, ASTRA-2026-09-14-T2, FS100-B12
CHECK: plans/FS100-X01D-derivation.md:21 `Corollary` found only as the bare token `Corollary` in ASTRA-2026-09-14-T7, ASTRA-2026-09-14-T8, FS100-MR
CHECK: plans/FS103-M-derivation.md:9 `M1` found only as the bare token `M1` in FS105-B-EFP, FS105-B-M1, FS106-COMP
CHECK: plans/FS103-M-derivation.md:10 `M1′` found only as the bare token `M1` in FS105-B-EFP, FS105-B-M1, FS106-COMP
CHECK: plans/FS103-M-derivation.md:12 `M1.1` found only as the bare token `M1.1` in FS103-M-FREE, M56-T1
CHECK: plans/FS103-M-derivation.md:12 `M1.2` found only as the bare token `M1.2` in FS103-M-FREE
CHECK: plans/FS103-M-derivation.md:14 `NR` found only as the bare token `NR` in FS86-VX-C, FS91-J07-3
CHECK: plans/FS103-M-derivation.md:18 `Q4` found only as the bare token `Q4` in FS116-Y3-TIGHTLENS, M32-T1
CHECK: plans/FS103-M-derivation.md:19 `Exact` found only as the bare token `Exact` in FS116-Y1-F15, FS61-T5, FS79-T18
CHECK: plans/FS106-TS-derivation.md:35 `C5` found only as the bare token `C5` in FS100-C45, FS106-AE-Q2, FS106-IND-X
CHECK: plans/FS67-J27D-derivation.md:33 `claim` found only as the bare token `claim` in ASTRA-2026-09-14-T7, FS100-COR, FS100-EFG
CHECK: plans/FS86-R88-D-derivation.md:14 `TC` found only as the bare token `TC` in R88-TC, R88-TCA

### Per file

- plans/FS100-J51D-derivation.md: 8 ids/headers defined, 7 found in an indexed entry, 1 not
    - :12 `J51D-T1` (table-row) — `J51D-T1` in FS100-KS2
    - :13 `J51D-T2` (table-row) — `J51D-T2` in FS100-CP
    - :14 `J51D-T3` (table-row) — `J51D-T3` in FS100-X1
    - :15 `J51D-KS3` (table-row) — NOT FOUND
    - :16 `J51D-T4` (table-row) — `J51D-T4` in FS100-T4
    - :17 `J51D-T5` (table-row) — `J51D-T5` in FS100-T5
    - :18 `J51D-R` (table-row) — `J51D-R` in FS100-R
    - :19 `J51D-C` (table-row) — `J51D-C` in FS100-EQ
- plans/FS100-X01D-derivation.md: 9 ids/headers defined, 9 found in an indexed entry, 0 not
    - :12 `EF-G` (bold-bullet) — `EF-G` in FS100-EFG
    - :13 `Haar` (bold-bullet) — `Haar` in FS100-CE1, FS100-FLK, FS100-K0
    - :14 `EF-G` (bold-bullet) — `EF-G` in FS100-EFG
    - :15 `EF-X` (bold-bullet) — `EF-X` in FS100-EFX
    - :16 `Lemma` (bold-bullet) — `Lemma` in ASTRA-2026-09-14-T1, ASTRA-2026-09-14-T2, FS100-B12
    - :17 `Lemma` (bold-bullet) — `Lemma` in ASTRA-2026-09-14-T1, ASTRA-2026-09-14-T2, FS100-B12
    - :18 `Lemma` (bold-bullet) — `Lemma` in ASTRA-2026-09-14-T1, ASTRA-2026-09-14-T2, FS100-B12
    - :20 `EF-MR` (bold-bullet) — `EF-MR` in FS100-MR, FS100-Q47
    - :21 `Corollary` (bold-bullet) — `Corollary` in ASTRA-2026-09-14-T7, ASTRA-2026-09-14-T8, FS100-MR
- plans/FS100-X02D-derivation.md: 9 ids/headers defined, 8 found in an indexed entry, 1 not
    - :346 `X02D-F` (table-row) — NOT FOUND
    - :347 `X02D-HX1` (table-row) — `X02D-HX1` in FS100-HX1
    - :348 `X02D-C` (table-row) — `X02D-C` in FS100-PE1
    - :349 `X02D-CX` (table-row) — `X02D-CX` in FS100-PE1
    - :350 `X02D-W` (table-row) — `X02D-W` in FS100-PE1
    - :351 `X02D-PE1′` (table-row) — `X02D-PE1` in FS100-PE1
    - :353 `X02D-PE2` (table-row) — `X02D-PE2` in FS100-PE2
    - :354 `X02D-HF` (table-row) — `X02D-HF` in FS100-CE1
    - :355 `X02D-LT` (table-row) — `X02D-LT` in FS100-CE1
- plans/FS100-X03D-derivation.md: 12 ids/headers defined, 10 found in an indexed entry, 2 not
    - :10 `X03D-FR1` (table-row) — `X03D-FR1` in FS100-FR1
    - :11 `X03D-ED1` (table-row) — `X03D-ED1` in FS100-ED1, FS100-ED2
    - :12 `X03D-FL-K` (table-row) — `X03D-FL-K` in FS100-FLK, FS100-X22
    - :13 `X03D-FL-1a` (table-row) — NOT FOUND
    - :14 `X03D-SPEC` (table-row) — `X03D-SPEC` in FS100-SPEC
    - :15 `X03D-FL-H` (table-row) — `X03D-FL-H` in FS100-FLH
    - :16 `X03D-FL-12` (table-row) — `X03D-FL-12` in FS100-FLH
    - :17 `X03D-FL-Q` (table-row) — `X03D-FL-Q` in FS100-FLH
    - :18 `X03D-ED2` (table-row) — `X03D-ED2` in FS100-ED2
    - :19 `X03D-Z` (table-row) — `X03D-Z` in FS100-ED2
    - :20 `X03D-ED1′` (table-row) — `X03D-ED1` in FS100-ED1, FS100-ED2
    - :21 `X03D-ED1-R` (table-row) — NOT FOUND
- plans/FS100-X12B-derivation.md: 7 ids/headers defined, 5 found in an indexed entry, 2 not
    - :202 `X12B-R` (table-row) — NOT FOUND
    - :203 `X12B-Z` (table-row) — `X12B-Z` in FS100-EFP, FS100-EFZ
    - :204 `X12B-E` (table-row) — `X12B-E` in FS100-EFZ
    - :205 `X12B-EF` (table-row) — `X12B-EF` in FS100-EFP
    - :207 `X12B-MR` (table-row) — `X12B-MR` in FS100-MR
    - :208 `X12B-G` (table-row) — `X12B-G` in FS100-EFG
    - :209 `X12B-N` (table-row) — NOT FOUND
- plans/FS100-X21D-derivation.md: 9 ids/headers defined, 8 found in an indexed entry, 1 not
    - :8 `X21D-Q0` (bold-bullet) — `X21D-Q0` in FS100-Q0
    - :10 `X21D-A1` (bold-bullet) — `X21D-A1` in FS100-FAM
    - :12 `X21D-A2` (bold-bullet) — NOT FOUND
    - :14 `X21D-A4` (bold-bullet) — `X21D-A4` in FS100-167
    - :16 `X21D-B1` (bold-bullet) — `X21D-B1` in FS100-B12
    - :18 `X21D-PL` (bold-bullet) — `X21D-PL` in FS100-B12
    - :20 `X21D-Y` (bold-bullet) — `X21D-Y` in FS100-B3
    - :22 `X21D-G23` (bold-bullet) — `X21D-G23` in FS100-B3
    - :25 `X21D-K0` (bold-bullet) — `X21D-K0` in FS100-K0b
- plans/FS100-X22D-derivation.md: 8 ids/headers defined, 6 found in an indexed entry, 2 not
    - :13 `X22D-C0` (table-row) — `X22D-C0` in FS100-X22
    - :14 `X22D-QR` (table-row) — `X22D-QR` in FS100-X22, FS100-X27D-E
    - :15 `X22D-RT` (table-row) — `X22D-RT` in FS100-X22, FS100-X27D-EQ
    - :16 `X22D-EF` (table-row) — NOT FOUND
    - :17 `X22D-TRM` (table-row) — `X22D-TRM` in FS100-X22
    - :18 `X22D-SEL` (table-row) — `X22D-SEL` in FS100-X22
    - :19 `X22D-FLK2` (table-row) — NOT FOUND
    - :20 `X22D-SPC2` (table-row) — `X22D-SPC2` in FS100-X22
- plans/FS100-X23D-derivation.md: 11 ids/headers defined, 11 found in an indexed entry, 0 not
    - :10 `X23D-CTL` (table-row) — `X23D-CTL` in FS100-CTL
    - :11 `X23D-G27` (table-row) — `X23D-G27` in FS100-G27
    - :12 `X23D-LP2` (table-row) — `X23D-LP2` in FS100-DLP
    - :13 `X23D-LPq` (table-row) — `X23D-LPq` in FS100-DLP
    - :14 `X23D-CLS` (table-row) — `X23D-CLS` in FS100-CLS
    - :15 `X23D-TCA` (table-row) — `X23D-TCA` in FS100-TCA
    - :16 `X23D-CX` (table-row) — `X23D-CX` in FS100-CX
    - :17 `X23D-SPC` (table-row) — `X23D-SPC` in FS100-SPC
    - :18 `X23D-COR` (table-row) — `X23D-COR` in FS100-COR
    - :19 `X23D-Q35` (table-row) — `X23D-Q35` in FS100-Q35
    - :20 `X23D-D1` (table-row) — `X23D-D1` in FS100-D1
- plans/FS100-X25B-derivation.md: 8 ids/headers defined, 4 found in an indexed entry, 4 not
    - :170 `X25B-P` (bold-bullet) — NOT FOUND
    - :171 `X25B-PZ` (bold-bullet) — `X25B-PZ` in FS100-TCA
    - :173 `X25B-L1` (bold-bullet) — NOT FOUND
    - :175 `X25B-W` (bold-bullet) — NOT FOUND
    - :177 `X25B-T` (bold-bullet) — `X25B-T` in FS100-TCA, FS103-F-ROUND
    - :180 `X25B-G1` (bold-bullet) — `X25B-G1` in FS100-CX
    - :181 `X25B-T1` (bold-bullet) — NOT FOUND
    - :183 `X25B-LP` (bold-bullet) — `X25B-LP` in FS100-TCA
- plans/FS100-X26B-derivation.md: 7 ids/headers defined, 4 found in an indexed entry, 3 not
    - :10 `X26B-L1` (table-row) — `X26B-L1` in FS100-DLP
    - :11 `X26B-L2` (table-row) — NOT FOUND
    - :12 `X26B-T1` (table-row) — `X26B-T1` in FS100-G27
    - :13 `X26B-CLS` (table-row) — NOT FOUND
    - :14 `X26B-EXC` (table-row) — `X26B-EXC` in FS100-EXC
    - :15 `X26B-L3` (table-row) — `X26B-L3` in FS100-CX
    - :16 `X26B-ARCH` (table-row) — NOT FOUND
- plans/FS100-X27D-derivation.md: 10 ids/headers defined, 4 found in an indexed entry, 6 not
    - :13 `X27D-EQ` (table-row) — NOT FOUND
    - :14 `X27D-L0` (table-row) — `X27D-L0` in FS100-X27D-E
    - :15 `X27D-PC` (table-row) — `X27D-PC` in FS100-X27D-E
    - :16 `X27D-TA` (table-row) — `X27D-TA` in FS100-X27D-E
    - :17 `X27D-SPL` (table-row) — `X27D-SPL` in FS100-X27D-E
    - :18 `X27D-E` (table-row) — NOT FOUND
    - :19 `X27D-ATT` (table-row) — NOT FOUND
    - :20 `X27D-FL` (table-row) — NOT FOUND
    - :21 `X27D-SIERP` (table-row) — NOT FOUND
    - :22 `X27D-FLit` (table-row) — NOT FOUND
- plans/FS100-X28D-derivation.md: 7 ids/headers defined, 0 found in an indexed entry, 7 not
    - :14 `X28D-P` (table-row) — NOT FOUND
    - :15 `X28D-S` (table-row) — NOT FOUND
    - :16 `X28D-CP1` (table-row) — NOT FOUND
    - :17 `X28D-CP2` (table-row) — NOT FOUND
    - :18 `X28D-CP3` (table-row) — NOT FOUND
    - :19 `X28D-ODD` (table-row) — NOT FOUND
    - :20 `X28D-CUBE` (table-row) — NOT FOUND
- plans/FS103-M-derivation.md: 8 ids/headers defined, 8 found in an indexed entry, 0 not
    - :9 `M1` (bold-bullet) — `M1` in FS105-B-EFP, FS105-B-M1, FS106-COMP
    - :10 `M1′` (bold-bullet) — `M1` in FS105-B-EFP, FS105-B-M1, FS106-COMP
    - :12 `M1.1` (bold-bullet) — `M1.1` in FS103-M-FREE, M56-T1
    - :12 `M1.2` (bold-bullet) — `M1.2` in FS103-M-FREE
    - :14 `NR` (bold-bullet) — `NR` in FS86-VX-C, FS91-J07-3
    - :15 `A-E3′` (bold-bullet) — `A-E3` in FS103-CTL, FS103-M-AE3
    - :18 `Q4` (bold-bullet) — `Q4` in FS116-Y3-TIGHTLENS, M32-T1
    - :19 `Exact` (bold-bullet) — `Exact` in FS116-Y1-F15, FS61-T5, FS79-T18
- plans/FS105-B-derivation.md: 6 ids/headers defined, 5 found in an indexed entry, 1 not
    - :9 `FS105-B-M1` (bold-bullet) — `FS105-B-M1` in FS105-B-M1
    - :11 `FS105-B-L0` (bold-bullet) — NOT FOUND
    - :13 `FS105-B-L5` (bold-bullet) — `FS105-B-L5` in FS105-B-L5
    - :14 `FS105-B-L6` (bold-bullet) — `FS105-B-L6` in FS105-B-L6
    - :15 `FS105-B-EFP` (bold-bullet) — `FS105-B-EFP` in FS105-B-EF0, FS105-B-EFP, FS105-B-L5
    - :16 `FS105-B-EF0` (bold-bullet) — `FS105-B-EF0` in FS105-B-EF0
- plans/FS106-TQ-derivation.md: 14 ids/headers defined, 4 found in an indexed entry, 10 not
    - :12 `TQ-CORE` (bold-bullet) — NOT FOUND
    - :14 `TQ-REM-i` (bold-bullet) — `TQ-REM-i` in FS106-EQ
    - :16 `TQ-REM-ii` (bold-bullet) — NOT FOUND
    - :18 `TQ-P` (bold-bullet) — NOT FOUND
    - :18 `TQ-T` (bold-bullet) — NOT FOUND
    - :19 `TQ-SUP` (bold-bullet) — NOT FOUND
    - :20 `TQ-COMP-i` (bold-bullet) — NOT FOUND
    - :22 `TQ-COMP-ii` (bold-bullet) — NOT FOUND
    - :24 `TQ-EQ` (bold-bullet) — NOT FOUND
    - :26 `HOLE-t` (bold-bullet) — NOT FOUND
    - :27 `TQ-EPS2` (bold-bullet) — `TQ-EPS2` in FS106-CS, FS106-V23, FS107-K-AD
    - :28 `TQ-ERODE` (bold-bullet) — `TQ-ERODE` in FS106-PIX
    - :30 `TQ-HIT` (bold-bullet) — `TQ-HIT` in FS106-PDEQ, FS107-K-AD
    - :32 `TQ-SYN` (bold-bullet) — NOT FOUND
- plans/FS106-TS-derivation.md: 13 ids/headers defined, 12 found in an indexed entry, 1 not
    - :15 `TS-U` (bold-bullet) — `TS-U` in FS106-AE-Q2, FS107-R-SW, FS110-A3-HOLE
    - :17 `TS-L1` (bold-bullet) — NOT FOUND
    - :18 `TS-C` (bold-bullet) — `TS-C` in FS106-TS-C2, FS110-N2-ROT, FS114-L60-LE
    - :19 `TS-T` (bold-bullet) — `TS-T` in FS106-SV1
    - :21 `C-AE-POLY` (bold-bullet) — `C-AE-POLY` in FS106-AE-POLY
    - :23 `C-AE-CONV` (bold-bullet) — `C-AE-CONV` in FS106-AE-CONV
    - :24 `C-T-L1a` (bold-bullet) — `C-T-L1a` in FS106-L1
    - :25 `C-T-L1b` (bold-bullet) — `C-T-L1b` in FS106-L1
    - :27 `C-T-TAN` (bold-bullet) — `C-T-TAN` in FS106-TAN, FS107-K-C6, FS107-MEET
    - :30 `C-T-TRIa` (bold-bullet) — `C-T-TRIa` in FS106-TRI
    - :31 `TS-C′` (bold-bullet) — `TS-C` in FS106-TS-C2, FS110-N2-ROT, FS114-L60-LE
    - :33 `C-T-IND` (bold-bullet) — `C-T-IND` in FS106-IND
    - :35 `C5` (bold-bullet) — `C5` in FS100-C45, FS106-AE-Q2, FS106-IND-X
- plans/FS67-J27D-derivation.md: 31 ids/headers defined, 29 found in an indexed entry, 2 not
    - :11 `1` (table-row) — `J27D #1` in the text of an entry
    - :12 `2` (table-row) — `J27D #2` in the text of an entry
    - :13 `3` (table-row) — `J27D #3` in the text of an entry
    - :14 `4` (table-row) — `J27D #4` in the text of an entry
    - :15 `5` (table-row) — `J27D #5` in the text of an entry
    - :16 `6` (table-row) — `J27D #6` in the text of an entry
    - :17 `7` (table-row) — NOT FOUND
    - :18 `8` (table-row) — `J27D #8` in the text of an entry
    - :19 `9` (table-row) — NOT FOUND
    - :20 `10` (table-row) — `J27D #10` in the text of an entry
    - :21 `11` (table-row) — `J27D #11` in the text of an entry
    - :22 `12` (table-row) — `J27D #12` in the text of an entry
    - :23 `13` (table-row) — `J27D #13` in the text of an entry
    - :24 `14` (table-row) — `J27D #14` in the text of an entry
    - :25 `15` (table-row) — `J27D #15` in the text of an entry
    - :26 `16` (table-row) — `J27D #16` in the text of an entry
    - :27 `17` (table-row) — `J27D #17` in the text of an entry
    - :28 `18` (table-row) — `J27D #18` in the text of an entry
    - :29 `19` (table-row) — `J27D #19` in the text of an entry
    - :33 `claim` (table-row) — `claim` in ASTRA-2026-09-14-T7, FS100-COR, FS100-EFG
    - :35 `DA-1′` (table-row) — `DA-1` in FS67-C5, FS67-DA1
    - :36 `DA-2′` (table-row) — `DA-2` in FS67-DA2
    - :37 `DA-3` (table-row) — `DA-3` in FS67-DA3, FS67-DA4, FS67-GL
    - :38 `DA-4` (table-row) — `DA-4` in FS67-DA4
    - :39 `DB-1` (table-row) — `DB-1` in FS67-C5, FS67-DB1R, FS67-DB1Z
    - :40 `DB-2` (table-row) — `DB-2` in FS67-DB2
    - :41 `DC-1` (table-row) — `DC-1` in FS67-DC1, FS67-DC3, FS67-DD2N
    - :42 `DC-2` (table-row) — `DC-2` in FS67-DC2, FS67-DC2S, FS67-DC3
    - :43 `DC-3` (table-row) — `DC-3` in FS67-DC3
    - :44 `DD-1` (table-row) — `DD-1` in FS67-DD1
    - :45 `DD-2` (table-row) — `DD-2` in FS67-DD2N, FS67-DD2R
- plans/FS84-S1-derivation.md: 8 ids/headers defined, 0 found in an indexed entry, 8 not
    - :12 `S1a` (table-row) — NOT FOUND
    - :13 `S1a-P` (table-row) — NOT FOUND
    - :14 `S1a-J` (table-row) — NOT FOUND
    - :15 `S1b` (table-row) — NOT FOUND
    - :16 `S1b-47` (table-row) — NOT FOUND
    - :17 `S1c` (table-row) — NOT FOUND
    - :18 `S1d-K` (table-row) — NOT FOUND
    - :19 `S1e` (table-row) — NOT FOUND
- plans/FS84-SI-D-derivation.md: 14 ids/headers defined, 0 found in an indexed entry, 14 not
    - :11 `J45-N1` (table-row) — NOT FOUND
    - :12 `J45-N2` (table-row) — NOT FOUND
    - :13 `J45-SI-1` (table-row) — NOT FOUND
    - :14 `J45-SI-2` (table-row) — NOT FOUND
    - :15 `J45-SI-3` (table-row) — NOT FOUND
    - :16 `J45-SI-4` (table-row) — NOT FOUND
    - :17 `J45-SI-5` (table-row) — NOT FOUND
    - :18 `J45-SI-J` (table-row) — NOT FOUND
    - :19 `J45-G2` (table-row) — NOT FOUND
    - :20 `J45-SI-C` (table-row) — NOT FOUND
    - :23 `J45-RU` (table-row) — NOT FOUND
    - :24 `J45-SP-oi` (table-row) — NOT FOUND
    - :25 `J45-SP-if` (table-row) — NOT FOUND
    - :26 `J45-SP-Cor` (table-row) — NOT FOUND
- plans/FS86-R88-D-derivation.md: 13 ids/headers defined, 12 found in an indexed entry, 1 not
    - :12 `T-A` (bold-bullet) — `T-A` in R88-TA, R88-TA1
    - :13 `T-A1` (bold-bullet) — `T-A1` in R88-B2-3, R88-TA1
    - :14 `TC` (bold-bullet) — `TC` in R88-TC, R88-TCA
    - :15 `TC-Y′` (bold-bullet) — `TC-Y` in R88-TC-Yp
    - :16 `TC-reg` (bold-bullet) — `TC-reg` in R88-TC-reg
    - :17 `TC-count` (bold-bullet) — `TC-count` in R88-TC-count
    - :19 `TC-tab` (bold-bullet) — NOT FOUND
    - :20 `B2-1` (bold-bullet) — `B2-1` in R88-B2-1
    - :20 `B2-2` (bold-bullet) — `B2-2` in R88-B2-2
    - :20 `B2-3` (bold-bullet) — `B2-3` in R88-B2-3
    - :21 `T-B1` (bold-bullet) — `T-B1` in FS100-Q47, FS100-X22, R88-TA1
    - :21 `T-B2` (bold-bullet) — `T-B2` in R88-B2-1, R88-B2-2, R88-B2-3
    - :22 `T-A2` (bold-bullet) — `T-A2` in R88-TA2
- plans/FS89-S1D-derivation.md: 18 ids/headers defined, 16 found in an indexed entry, 2 not
    - :405 `D0-T1` (table-row) — NOT FOUND
    - :406 `D1-L2` (table-row) — `D1-L2` in FS89-D1-L2, FS89-D1-T1, FS89-D5-T2
    - :407 `D1-L3` (table-row) — `D1-L3` in FS89-D1-L3, FS89-D5-T2, FS89-PA-B1
    - :408 `D1-L4` (table-row) — `D1-L4` in FS89-CL1, FS89-PA-B2
    - :409 `D1-T1` (table-row) — `D1-T1` in FS89-D1-L2, FS89-D1-L3, FS89-D1-L4
    - :410 `D1-L5` (table-row) — `D1-L5` in FS89-D0-T1, FS89-D1-C1
    - :411 `D1-L6` (table-row) — `D1-L6` in FS89-D0-T1, FS89-D1-C1, FS89-D1-T2
    - :412 `D1-C1` (table-row) — `D1-C1` in FS89-D1-C1, FS89-D1-L5, FS89-D1-L6
    - :413 `D1-T2` (table-row) — `D1-T2` in FS89-D1-C1, FS89-D1-C2, FS89-D1-L2
    - :414 `D1-C2` (table-row) — `D1-C2` in FS89-D1-C1, FS89-D2-T1, FS89-S1VB-6
    - :415 `D2-L1` (table-row) — `D2-L1` in FS89-D1-T2, FS89-D2-L1, FS89-D2-T1
    - :416 `D2-T1` (table-row) — `D2-T1` in FS89-CL2, FS89-CL3, FS89-CL4
    - :417 `D5-L1` (table-row) — `D5-L1` in FS89-D5-L1, FS89-D5-T1, FS89-PA-B2
    - :418 `D5-L2` (table-row) — NOT FOUND
    - :419 `D5-L3` (table-row) — `D5-L3` in FS89-D0-T1, FS89-D1-C1, FS89-D5-L3
    - :420 `D5-T1` (table-row) — `D5-T1` in FS89-D1-L2, FS89-D1-L3, FS89-D5-L1
    - :421 `D5-C2` (table-row) — `D5-C2` in FS89-S1VB-6
    - :422 `D5-T2` (table-row) — `D5-T2` in FS89-CL2, FS89-CL5, FS89-D2-L1
- plans/M37-derivation.md: 0 ids/headers defined, 0 found in an indexed entry, 0 not
